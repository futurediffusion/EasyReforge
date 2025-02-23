@echo off
chcp 65001 > NUL
call %~dp0EasyTools\Git\Git_SetPath.bat
cd /d %~dp0stable-diffusion-webui-reForge
call venv\Scripts\activate.bat

echo pip install ^
https://huggingface.co/w-e-w/torch-2.6.0-cu128.nv/resolve/main/torch-2.6.0+cu128.nv-cp310-cp310-win_amd64.whl#sha256=fef3de7ce8f4642e405576008f384304ad0e44f7b06cc1aa45e0ab4b6e70490d ^
https://huggingface.co/w-e-w/torch-2.6.0-cu128.nv/resolve/main/torchvision-0.20.0a0+cu128.nv-cp310-cp310-win_amd64.whl#sha256=50841254f59f1db750e7348b90a8f4cd6befec217ab53cbb03780490b225abef

pip install ^
https://huggingface.co/w-e-w/torch-2.6.0-cu128.nv/resolve/main/torch-2.6.0+cu128.nv-cp310-cp310-win_amd64.whl#sha256=fef3de7ce8f4642e405576008f384304ad0e44f7b06cc1aa45e0ab4b6e70490d ^
https://huggingface.co/w-e-w/torch-2.6.0-cu128.nv/resolve/main/torchvision-0.20.0a0+cu128.nv-cp310-cp310-win_amd64.whl#sha256=50841254f59f1db750e7348b90a8f4cd6befec217ab53cbb03780490b225abef

cmd /k
