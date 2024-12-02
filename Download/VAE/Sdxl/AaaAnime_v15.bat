@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\..\EasyTools
set CIVITAI_MODEL=%EASY_TOOLS%\Download\CivitaiModel.bat
pushd %~dp0..\..\..\Model\VAE

@REM https://civitai.com/models/888145?modelVersionId=1042046
call %CIVITAI_MODEL% Sdxl\ AaaAnime_v15.safetensors 888145 1042046
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem %~dp0..\..\..\Model\VAE
