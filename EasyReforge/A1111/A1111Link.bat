@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\EasyTools
set JUNCTION=%EASY_TOOLS%\Link\Junction.bat

pushd %~dp0..\..\stable-diffusion-webui

if not exist models\adetailer\ ( mkdir models\adetailer )
call %JUNCTION% models\adetailer ..\Model\adetailer
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

if not exist models\ControlNet\ ( mkdir models\ControlNet )
call %JUNCTION% models\ControlNet ..\Model\ControlNet
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

if not exist models\ESRGAN\ ( mkdir models\ESRGAN )
call %JUNCTION% models\ESRGAN ..\Model\ESRGAN
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

if not exist models\Lora\ ( mkdir models\Lora )
call %JUNCTION% models\Lora ..\Model\Lora
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

call %JUNCTION% models\Stable-diffusion ..\Model\Stable-diffusion
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

call %JUNCTION% models\VAE ..\Model\VAE
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM call %JUNCTION% extensions\sd-dynamic-prompts\wildcards ..\Model\wildcards 
@REM if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

if not exist outputs\txt2img-images\ ( mkdir outputs\txt2img-images )
if not exist outputs\img2img-images\ ( mkdir outputs\img2img-images )
if not exist outputs\extras-images\ ( mkdir outputs\extras-images )
if not exist outputs\txt2img-grids\ ( mkdir outputs\txt2img-grids )
if not exist outputs\img2img-grids\ ( mkdir outputs\img2img-grids )
if not exist log\images\ ( mkdir log\images )

call %JUNCTION% ..\OutputA1111 outputs
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem %~dp0..\..\stable-diffusion-webui
