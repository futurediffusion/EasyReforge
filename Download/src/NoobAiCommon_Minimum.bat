@echo off
chcp 65001 > NUL
@REM Minimum は Civitai ログイン不要を維持する

call %~dp0..\adetailer\bbox\face_yolov9c.bat
call %~dp0..\adetailer\bbox\foot_yolov8x_v2.bat
call %~dp0..\adetailer\bbox\hand_yolov9c.bat

call %~dp0..\adetailer\segm\AnzhcBreasts-v1-1024-seg.bat
call %~dp0..\adetailer\segm\AnzhcEyes-seg.bat
call %~dp0..\adetailer\segm\AnzhcFace-v2-640-seg.bat
call %~dp0..\adetailer\segm\AnzhcFace-v2-768MS-seg.bat
call %~dp0..\adetailer\segm\AnzhcFace-v2-1024-seg.bat
call %~dp0..\adetailer\segm\AnzhcHead-seg.bat
call %~dp0..\adetailer\segm\AnzhcHeadHair-seg.bat
call %~dp0..\adetailer\segm\PitHandDetailer-v1b-seg.bat

call %~dp0..\All\ESRGAN.bat

@REM call %~dp0..\ControlNet\Pony\CN-anytest_v3-50000_pn_dim8.bat
@REM call %~dp0..\ControlNet\Pony\CN-anytest_v3-50000_pn_dim64.bat
@REM call %~dp0..\ControlNet\Pony\CN-anytest_v3-50000_pn_dim256.bat
@REM call %~dp0..\ControlNet\Pony\CN-anytest_v4-marged_pn_dim64.bat
@REM call %~dp0..\ControlNet\Pony\CN-anytest_v4-marged_pn_dim256.bat

@REM call %~dp0..\ControlNet\Sdxl\CN-anytest_v3-50000_am_dim8.bat
@REM call %~dp0..\ControlNet\Sdxl\CN-anytest_v3-50000_am_dim64.bat
@REM call %~dp0..\ControlNet\Sdxl\CN-anytest_v3-50000_am_dim256.bat
@REM call %~dp0..\ControlNet\Sdxl\CN-anytest_v4-marged_am_dim64.bat
@REM call %~dp0..\ControlNet\Sdxl\CN-anytest_v4-marged_am_dim256.bat
@REM call %~dp0..\ControlNet\Sdxl\cnlllite-anystyle_v3-step00005000.bat
@REM call %~dp0..\ControlNet\Sdxl\Kataragi_inpaintXL-lora128.bat
@REM call %~dp0..\ControlNet\Sdxl\TTPLANET_Controlnet_Tile_realistic_v2_rank256.bat

call %~dp0..\Lora\Sdxl_Boost\dmd2_sdxl_4step.bat
call %~dp0..\Lora\Sdxl_Boost\Hyper_sdxl_8step.bat
