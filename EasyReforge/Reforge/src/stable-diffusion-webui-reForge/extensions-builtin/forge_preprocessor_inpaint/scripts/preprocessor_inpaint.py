import os
import cv2
import torch
import numpy as np
import yaml
import einops

from omegaconf import OmegaConf
from modules_forge.supported_preprocessor import Preprocessor, PreprocessorParameter
from modules_forge.forge_util import numpy_to_pytorch, resize_image_with_pad
from modules_forge.shared import preprocessor_dir, add_supported_preprocessor
from modules.modelloader import load_file_from_url
from annotator.lama.saicinpainting.training.trainers import load_checkpoint


class PreprocessorInpaint(Preprocessor):
    def __init__(self):
        super().__init__()
        self.name = 'inpaint_global_harmonious'
        self.tags = ['Inpaint']
        self.model_filename_filters = ['inpaint']
        self.slider_resolution = PreprocessorParameter(visible=False)
        self.fill_mask_with_one_when_resize_and_fill = True
        self.expand_mask_when_resize_and_fill = True

    def process_before_every_sampling(self, process, cond, mask, *args, **kwargs):
        mask = mask.round()
        mixed_cond = cond * (1.0 - mask) - mask
        return mixed_cond, None


class PreprocessorInpaintOnly(PreprocessorInpaint):
    def __init__(self):
        super().__init__()
        self.name = 'inpaint_only'
        self.image = None
        self.mask = None
        self.latent = None

    def process_before_every_sampling(self, process, cond, mask, *args, **kwargs):
        mask = mask.round()
        self.image = cond
        self.mask = mask

        vae = process.sd_model.forge_objects.vae
        # This is a powerful VAE with integrated memory management, bf16, and tiled fallback.

        latent_image = vae.encode(self.image.movedim(1, -1))
        latent_image = process.sd_model.forge_objects.unet.model.latent_format.process_in(latent_image)

        B, C, H, W = latent_image.shape

        latent_mask = self.mask
        latent_mask = torch.nn.functional.interpolate(latent_mask, size=(H * 8, W * 8), mode="bilinear").round()
        latent_mask = torch.nn.functional.max_pool2d(latent_mask, (8, 8)).round().to(latent_image)

        unet = process.sd_model.forge_objects.unet.clone()

        def pre_cfg(model, c, uc, x, timestep, model_options):
            noisy_latent = latent_image.to(x) + timestep[:, None, None, None].to(x) * torch.randn_like(latent_image).to(x)
            x = x * latent_mask.to(x) + noisy_latent.to(x) * (1.0 - latent_mask.to(x))
            return model, c, uc, x, timestep, model_options

        def post_cfg(args):
            denoised = args['denoised']
            denoised = denoised * latent_mask.to(denoised) + latent_image.to(denoised) * (1.0 - latent_mask.to(denoised))
            return denoised

        unet.add_sampler_pre_cfg_function(pre_cfg)
        unet.set_model_sampler_post_cfg_function(post_cfg)

        process.sd_model.forge_objects.unet = unet

        self.latent = latent_image

        mixed_cond = cond * (1.0 - mask) - mask

        return mixed_cond, None

    def process_after_every_sampling(self, process, params, *args, **kwargs):
        a1111_batch_result = args[0]
        new_results = []

        for img in a1111_batch_result.images:
            sigma = 7
            mask = self.mask[0, 0].detach().cpu().numpy().astype(np.float32)
            mask = cv2.dilate(mask, np.ones((sigma, sigma), dtype=np.uint8))
            mask = cv2.blur(mask, (sigma, sigma))[None]
            mask = torch.from_numpy(np.ascontiguousarray(mask).copy()).to(img).clip(0, 1)
            raw = self.image[0].to(img).clip(0, 1)
            img = img.clip(0, 1)
            new_results.append(raw * (1.0 - mask) + img * mask)

        a1111_batch_result.images = new_results
        return


class PreprocessorInpaintLama(PreprocessorInpaintOnly):
    def __init__(self):
        super().__init__()
        self.name = 'inpaint_only+lama'

    def load_model(self):
        remote_model_path = "https://huggingface.co/lllyasviel/Annotators/resolve/main/ControlNetLama.pth"
        model_path = load_file_from_url(remote_model_path, model_dir=preprocessor_dir)
        config_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'lama_config.yaml')
        cfg = yaml.safe_load(open(config_path, 'rt'))
        cfg = OmegaConf.create(cfg)
        cfg.training_model.predict_only = True
        cfg.visualizer.kind = 'noop'
        model = load_checkpoint(cfg, os.path.abspath(model_path), strict=False, map_location='cpu')
        self.setup_model_patcher(model)
        return

    def __call__(self, input_image, resolution, slider_1=None, slider_2=None, slider_3=None, input_mask=None, **kwargs):
        if input_mask is None:
            return input_image

        H, W, C = input_image.shape
        raw_color = input_image.copy()
        raw_mask = input_mask.copy()

        input_image, remove_pad = resize_image_with_pad(input_image, 256)
        input_mask, remove_pad = resize_image_with_pad(input_mask, 256)
        input_mask = input_mask[..., :1]

        self.load_model()

        self.move_all_model_patchers_to_gpu()

        color = np.ascontiguousarray(input_image).astype(np.float32) / 255.0
        mask = np.ascontiguousarray(input_mask).astype(np.float32) / 255.0
        with torch.no_grad():
            color = self.send_tensor_to_model_device(torch.from_numpy(color))
            mask = self.send_tensor_to_model_device(torch.from_numpy(mask))
            mask = (mask > 0.5).float()
            color = color * (1 - mask)
            image_feed = torch.cat([color, mask], dim=2)
            image_feed = einops.rearrange(image_feed, 'h w c -> 1 c h w')
            prd_color = self.model_patcher.model(image_feed)[0]
            prd_color = einops.rearrange(prd_color, 'c h w -> h w c')
            prd_color = prd_color * mask + color * (1 - mask)
            prd_color *= 255.0
            prd_color = prd_color.detach().cpu().numpy().clip(0, 255).astype(np.uint8)

        prd_color = remove_pad(prd_color)
        prd_color = cv2.resize(prd_color, (W, H))

        alpha = raw_mask.astype(np.float32) / 255.0
        fin_color = prd_color.astype(np.float32) * alpha + raw_color.astype(np.float32) * (1 - alpha)
        fin_color = fin_color.clip(0, 255).astype(np.uint8)

        return fin_color

    def process_before_every_sampling(self, process, cond, mask, *args, **kwargs):
        cond, mask = super().process_before_every_sampling(process, cond, mask, *args, **kwargs)
        sigma_max = process.sd_model.forge_objects.unet.model.model_sampling.sigma_max
        original_noise = kwargs['noise']
        process.modified_noise = original_noise + self.latent.to(original_noise) / sigma_max.to(original_noise)
        return cond, mask


class PreprocessorInpaintNoobAIXL(PreprocessorInpaint):
    def __init__(self):
        super().__init__()
        self.name = 'inpaint_noobai_xl'
        self.model_filename_filters = ['inpaint', 'noobai']

    def __call__(self, input_image, resolution=512, slider_1=None, slider_2=None, slider_3=None, input_mask=None, **kwargs):
        if input_mask is None:
            return input_image

        if not isinstance(input_image, np.ndarray):
            input_image = np.array(input_image)
        if not isinstance(input_mask, np.ndarray):
            input_mask = np.array(input_mask)

        mask = input_mask.astype(np.float32) / 255.0
        mask = (mask > 0.5).astype(np.float32)

        # Create a copy of the input image
        result = input_image.copy()

        # Convert mask to proper shape if needed
        if mask.ndim == 2:
            mask = np.expand_dims(mask, axis=-1)
        if mask.shape[-1] == 1:
            mask = np.repeat(mask, 3, axis=-1)

        mask_indices = mask > 0.5
        result[mask_indices] = 0.0

        return result

    def process_before_every_sampling(self, process, cond, mask, *args, **kwargs):
        mask = mask.round()
        mixed_cond = cond.clone()
        mixed_cond = mixed_cond * (1.0 - mask)
        
        return mixed_cond, None


class PreprocessorInpaintOnlyNoobAIXL(PreprocessorInpaintOnly):
    def __init__(self):
        super().__init__()
        self.name = 'inpaint_only_noobai_xl'
        self.model_filename_filters = ['inpaint', 'noobai']

    def __call__(self, input_image, resolution=512, slider_1=None, slider_2=None, slider_3=None, input_mask=None, **kwargs):
        if input_mask is None:
            return input_image

        if not isinstance(input_image, np.ndarray):
            input_image = np.array(input_image)
        if not isinstance(input_mask, np.ndarray):
            input_mask = np.array(input_mask)

        mask = input_mask.astype(np.float32) / 255.0
        mask = (mask > 0.5).astype(np.float32)

        # Create a copy of the input image
        result = input_image.copy()

        # Convert mask to proper shape if needed
        if mask.ndim == 2:
            mask = np.expand_dims(mask, axis=-1)
        if mask.shape[-1] == 1:
            mask = np.repeat(mask, 3, axis=-1)

        mask_indices = mask > 0.5
        result[mask_indices] = 0.0

        return result

    def process_before_every_sampling(self, process, cond, mask, *args, **kwargs):
        super().process_before_every_sampling(process, cond, mask.ceil(), *args, **kwargs)
        mask = mask.round()
        self.mask = mask
        mixed_cond = cond.clone()
        mixed_cond = mixed_cond * (1.0 - mask)

        return mixed_cond, None

    def process_after_every_sampling(self, process, params, *args, **kwargs):
        a1111_batch_result = args[0]
        new_results = []

        for img in a1111_batch_result.images:
            sigma = 3

            mask = self.mask[0, 0].detach().cpu().numpy().astype(np.float32)
            mask = cv2.dilate(mask, np.ones((sigma, sigma), dtype=np.uint8))
            mask = cv2.blur(mask, (sigma, sigma))[None]
            mask = torch.from_numpy(np.ascontiguousarray(mask).copy()).to(img).clip(0, 1)

            raw = self.image[0].to(img).clip(0, 1)
            img = img.clip(0, 1)
            new_results.append(raw * (1.0 - mask) + img * mask)

        a1111_batch_result.images = new_results
        return


class PreprocessorInpaintOnlyNoobAIXLLama(PreprocessorInpaintOnly):
    def __init__(self):
        super().__init__()
        self.name = 'inpaint_only_noobai_xl+lama'
        self.model_filename_filters = ['inpaint', 'noobai']
        self.boundary_width = 7
        self.tile_size = 2048
        self.model_loaded = False

    def load_model(self):
        if self.model_loaded:
            return
            
        remote_model_path = "https://huggingface.co/lllyasviel/Annotators/resolve/main/ControlNetLama.pth"
        model_path = load_file_from_url(remote_model_path, model_dir=preprocessor_dir)
        config_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'lama_config.yaml')
        cfg = yaml.safe_load(open(config_path, 'rt'))
        cfg = OmegaConf.create(cfg)
        cfg.training_model.predict_only = True
        cfg.visualizer.kind = 'noop'
        model = load_checkpoint(cfg, os.path.abspath(model_path), strict=False, map_location='cpu')
        self.setup_model_patcher(model)
        self.model_loaded = True
        return

    def __call__(self, input_image, resolution=512, slider_1=None, slider_2=None, slider_3=None, input_mask=None, **kwargs):
        if input_mask is None:
            return input_image

        if not isinstance(input_image, np.ndarray):
            input_image = np.array(input_image)
        if not isinstance(input_mask, np.ndarray):
            input_mask = np.array(input_mask)

        mask = input_mask.astype(np.float32) / 255.0
        mask = (mask > 0.5).astype(np.float32)

        # Create a copy of the input image
        result = input_image.copy()

        # Convert mask to proper shape if needed
        if mask.ndim == 2:
            mask = np.expand_dims(mask, axis=-1)
        if mask.shape[-1] == 1:
            mask = np.repeat(mask, 3, axis=-1)

        mask_indices = mask > 0.5
        result[mask_indices] = 0.0

        return result

    def process_before_every_sampling(self, process, cond, mask, *args, **kwargs):
        super().process_before_every_sampling(process, cond, mask.ceil(), *args, **kwargs)
        mask = mask.round()
        self.mask = mask
        mixed_cond = cond.clone()
        mixed_cond = mixed_cond * (1.0 - mask)

        return mixed_cond, None

    def process_lama_tile(self, image, mask, x, y, tile_size):
        """Process a single tile with Lama"""
        # Extract tile
        tile_img = image[y:y+tile_size, x:x+tile_size]
        tile_mask = mask[y:y+tile_size, x:x+tile_size]
        
        # Skip empty mask tiles (optimization)
        if not np.any(tile_mask > 0.5):
            return tile_img
            
        # Ensure tile has proper shape
        h, w = tile_img.shape[:2]
        if h == 0 or w == 0:
            return tile_img
            
        # Process with Lama
        color = np.ascontiguousarray(tile_img).astype(np.float32) / 255.0
        
        # Ensure mask is single channel for Lama
        if tile_mask.ndim == 3 and tile_mask.shape[2] > 1:
            mask_input = np.ascontiguousarray(tile_mask[:, :, 0]).astype(np.float32)
        else:
            mask_input = np.ascontiguousarray(tile_mask).astype(np.float32)
        
        # Ensure mask is 2D (H,W)
        if mask_input.ndim == 3:
            mask_input = mask_input[:, :, 0]
        
        with torch.no_grad():
            color_tensor = self.send_tensor_to_model_device(torch.from_numpy(color))
            mask_tensor = self.send_tensor_to_model_device(torch.from_numpy(mask_input))
            
            # Ensure mask has the right shape (H,W)
            if mask_tensor.ndim == 3 and mask_tensor.shape[2] == 1:
                mask_tensor = mask_tensor[:, :, 0]
                
            # Convert to boolean mask
            mask_tensor = (mask_tensor > 0.5).float()
            
            # LAMAモデルのために正しい形式に変換 (入力: RGB + mask の4チャンネル)
            # マスクを画像と同じ形状で拡張
            mask_expanded = mask_tensor.unsqueeze(-1) if mask_tensor.ndim == 2 else mask_tensor
            
            # 入力画像にマスク適用
            color_masked = color_tensor * (1 - mask_expanded)
            
            # RGB画像とマスクを連結 (チャンネル次元で)
            if color_masked.ndim == 3 and mask_tensor.ndim == 2:
                # 正しく連結するために次元を合わせる
                image_feed = torch.cat([color_masked, mask_tensor.unsqueeze(-1)], dim=-1)
                # 1,C,H,Wの形式に変換
                image_feed = image_feed.permute(2, 0, 1).unsqueeze(0)
            else:
                print(f"Tensor shapes - color: {color_masked.shape}, mask: {mask_tensor.shape}")
                raise ValueError("Unexpected tensor shapes for LAMA processing")
            
            # モデル推論
            prd_color = self.model_patcher.model(image_feed)[0]
            # 結果を元の形式に戻す
            prd_color = prd_color.permute(1, 2, 0)
            
            # マスク領域のみ予測結果を適用
            if mask_tensor.ndim == 2:
                mask_3d = mask_tensor.unsqueeze(-1)
            else:
                mask_3d = mask_tensor
            
            prd_color = prd_color * mask_3d + color_tensor * (1 - mask_3d)
            prd_color *= 255.0
            prd_color = prd_color.detach().cpu().numpy().clip(0, 255).astype(np.uint8)
            
        return prd_color

    def apply_lama_to_boundary(self, image, original_mask):
        """Apply Lama only to the boundary area of the mask"""
        # Load the model if not already loaded
        self.load_model()
        self.move_all_model_patchers_to_gpu()
        
        # Create a copy of the image to work with
        result = image.copy()
        
        # Ensure original_mask is 2D
        if original_mask.ndim == 3:
            original_mask = original_mask[:, :, 0]
        
        # Create boundary mask - kernel size based on boundary_width
        kernel = np.ones((self.boundary_width, self.boundary_width), np.uint8)
        
        # Dilate and erode to get the boundary region
        dilated = cv2.dilate(original_mask, kernel, iterations=1)
        eroded = cv2.erode(original_mask, kernel, iterations=1)
        
        # Boundary = dilated - eroded (get both inner and outer boundary)
        boundary = dilated.astype(np.float32) - eroded.astype(np.float32)
        boundary = (boundary > 0).astype(np.float32)
        
        # Skip if no boundary
        if not np.any(boundary > 0):
            return result
            
        # Process the image in tiles
        h, w = image.shape[:2]
        tile_size = self.tile_size
        
        # Calculate number of tiles
        n_h = (h + tile_size - 1) // tile_size
        n_w = (w + tile_size - 1) // tile_size
        
        # Create an empty result canvas
        canvas = np.zeros_like(image)
        mask_canvas = np.zeros((h, w, 1), dtype=np.float32)
        
        # Process each tile
        for i in range(n_h):
            for j in range(n_w):
                y = i * tile_size
                x = j * tile_size
                
                # Extract current boundary region for this tile
                y_end = min(y+tile_size, h)
                x_end = min(x+tile_size, w)
                tile_boundary = boundary[y:y_end, x:x_end]
                
                # Skip tiles that don't contain boundary
                if not np.any(tile_boundary > 0):
                    continue

                # Process tile with Lama (マスクは2次元のまま渡す)
                tile_result = self.process_lama_tile(
                    image, 
                    tile_boundary,  # 2D mask
                    x, y, tile_size
                )
                
                # Add tile to canvas
                tile_h, tile_w = tile_result.shape[:2]
                canvas[y:y+tile_h, x:x+tile_w] = tile_result

                
                # Update mask canvas
                mask_canvas[y:y_end, x:x_end, 0] = tile_boundary
        
        # Expand mask_canvas to match image channels
        if mask_canvas.shape[-1] == 1 and image.shape[-1] == 3:
            mask_canvas = np.repeat(mask_canvas, 3, axis=-1)
        
        # Blend the processed areas with the original image
        mask_canvas = mask_canvas.astype(np.float32)
        result = result * (1 - mask_canvas) + canvas * mask_canvas
        
        return result.astype(np.uint8)

    def process_after_every_sampling(self, process, params, *args, **kwargs):
        a1111_batch_result = args[0]
        new_results = []

        for img in a1111_batch_result.images:
            sigma = 3

            # Get the mask from previous processing
            mask = self.mask[0, 0].detach().cpu().numpy().astype(np.float32)
            
            # Create the boundary for blending
            mask_dilated = cv2.dilate(mask, np.ones((sigma, sigma), dtype=np.uint8))
            mask_blurred = cv2.blur(mask_dilated, (sigma, sigma))[None]
            mask_tensor = torch.from_numpy(np.ascontiguousarray(mask_blurred).copy()).to(img).clip(0, 1)

            # Get the raw and generated images
            raw = self.image[0].to(img).clip(0, 1)
            img_generated = img.clip(0, 1)
            
            # Blend them based on the mask
            blended = raw * (1.0 - mask_tensor) + img_generated * mask_tensor
            
            # Convert for Lama processing
            blended_np = (blended.permute(1, 2, 0).detach().cpu().numpy() * 255).astype(np.uint8)
            mask_np = mask * 255.0
            
            # Apply Lama to the boundary region only
            processed = self.apply_lama_to_boundary(blended_np, mask_np.astype(np.uint8))
            
            # Convert back to tensor
            processed_tensor = torch.from_numpy(processed).float().permute(2, 0, 1) / 255.0
            processed_tensor = processed_tensor.to(img.device)
            
            new_results.append(processed_tensor)

        a1111_batch_result.images = new_results
        return


add_supported_preprocessor(PreprocessorInpaint())

add_supported_preprocessor(PreprocessorInpaintOnly())

add_supported_preprocessor(PreprocessorInpaintLama())

add_supported_preprocessor(PreprocessorInpaintNoobAIXL())

add_supported_preprocessor(PreprocessorInpaintOnlyNoobAIXL())

add_supported_preprocessor(PreprocessorInpaintOnlyNoobAIXLLama())
