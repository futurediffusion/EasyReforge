@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\..\EasyTools
set CIVITAI_MODEL=%EASY_TOOLS%\Download\CivitaiModel.bat
pushd %~dp0..\..\..\Model\Stable-diffusion

@REM https://civitai.com/models/1286421?modelVersionId=1472562
call %CIVITAI_MODEL% NoobE\ songMix_v13.safetensors 1286421 1472562
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem %~dp0..\..\..\Model\Stable-diffusion
urn:air:sdxl:checkpoint:civitai:@