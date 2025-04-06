@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\EasyTools

pushd %~dp0..\stable-diffusion-webui-reForge

call %EASY_TOOLS%\Python\Python_Activate.bat
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

echo pip uninstall -y torch torchvision
pip uninstall -y torch torchvision
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem %~dp0..\stable-diffusion-webui-reForge
