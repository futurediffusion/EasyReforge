@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\..\EasyTools
set CIVITAI_MODEL=%EASY_TOOLS%\Download\CivitaiModel.bat
pushd %~dp0..\..\..\Model\Stable-diffusion

@REM https://civitai.com/models/920709?modelVersionId=1200764
call %CIVITAI_MODEL% NoobV\ CatTower_v15.safetensors 920709 1200764
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem %~dp0..\..\..\Model\Stable-diffusion
