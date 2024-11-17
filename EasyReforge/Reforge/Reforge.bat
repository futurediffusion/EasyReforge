@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\EasyTools
set GITHUB_CLONE_OR_PULL=%EASY_TOOLS%\Git\GitHub_CloneOrPull.bat

pushd %~dp0..\..

echo https://github.com/Panchovix/stable-diffusion-webui-reForge/tree/dev
@REM https://github.com/Panchovix/stable-diffusion-webui-reForge/
call %GITHUB_CLONE_OR_PULL% Panchovix stable-diffusion-webui-reForge main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd
pushd %~dp0..\..\stable-diffusion-webui-reForge

@REM dev ブランチへの切り替え
git switch -C dev origin/dev
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

call %EASY_TOOLS%\Python\Python_Activate.bat
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

echo python -m pip install -qq --upgrade pip
python -m pip install -qq --upgrade pip
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

echo pip install -qq torch==2.3.1+cu121 torchvision --index-url https://download.pytorch.org/whl/cu121
pip install -qq torch==2.3.1+cu121 torchvision --index-url https://download.pytorch.org/whl/cu121
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

@REM fixed ImportError: cannot import name 'cached_download' from 'huggingface_hub'
@REM echo pip install -qq peft==0.13.2 huggingface-hub==0.25.2
@REM pip install -qq peft==0.13.2 huggingface-hub==0.25.2
@REM if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

popd
