@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\..\EasyTools
set CIVITAI_MODEL=%EASY_TOOLS%\Download\CivitaiModel.bat
pushd %~dp0..\..\..\Model\Stable-diffusion

@REM https://civitai.com/models/80473?modelVersionId=1115553
call %CIVITAI_MODEL% NoobE_Real\ PornMasterPro_v02.safetensors 80473 1115553
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem %~dp0..\..\..\Model\Stable-diffusion
