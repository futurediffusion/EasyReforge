@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\EasyTools
set GITHUB_CLONE_OR_PULL=%EASY_TOOLS%\Git\GitHub_CloneOrPull.bat

pushd %~dp0..\..

@REM https://github.com/AUTOMATIC1111/stable-diffusion-webui
@REM https://github.com/lllyasviel/stable-diffusion-webui-forge
call %GITHUB_CLONE_OR_PULL% lllyasviel stable-diffusion-webui-forge main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd
pushd %~dp0..\..\stable-diffusion-webui-forge

call %EASY_TOOLS%\Python\Python_Activate.bat
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

echo python -m pip install -qq -U pip setuptools wheel
python -m pip install -qq -U pip setuptools wheel
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

echo pip install -qq torch==2.3.1+cu121 torchvision --index-url https://download.pytorch.org/whl/cu121
pip install -qq torch==2.3.1+cu121 torchvision --index-url https://download.pytorch.org/whl/cu121
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

@REM echo pip install -qq torch==2.5.1+cu124 torchvision --index-url https://download.pytorch.org/whl/cu124
@REM pip install -qq torch==2.5.1+cu124 torchvision --index-url https://download.pytorch.org/whl/cu124
@REM if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

@REM ImportError: cannot import name 'Undefined' from 'pydantic.fields'
@REM https://github.com/AUTOMATIC1111/stable-diffusion-webui/issues/15564
@REM echo pip -qq install albumentations==1.4.3 pydantic==1.10.15
@REM pip -qq install albumentations==1.4.3 pydantic==1.10.15
@REM if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

@REM CN Pidinet ModuleNotFoundError: No module named 'basicsr'
@REM echo pip install -qq basicsr==1.4.2
@REM pip install -qq basicsr==1.4.2
@REM if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

@REM fixed ImportError: cannot import name 'cached_download' from 'huggingface_hub'
@REM echo pip install -qq peft==0.13.2 huggingface-hub==0.25.2
@REM pip install -qq peft==0.13.2 huggingface-hub==0.25.2
@REM if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

popd rem %~dp0..\..\stable-diffusion-webui-forge
