@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\EasyTools
set GITHUB_CLONE_OR_PULL=%EASY_TOOLS%\Git\GitHub_CloneOrPull.bat

pushd %~dp0..\..\stable-diffusion-webui-reForge\extensions

@REM https://github.com/DominikDoom/a1111-sd-webui-tagcomplete
call %GITHUB_CLONE_OR_PULL% DominikDoom a1111-sd-webui-tagcomplete main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/Bing-su/adetailer
call %GITHUB_CLONE_OR_PULL% Bing-su adetailer main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/Panchovix/reForge-Sigmas_merge
call %GITHUB_CLONE_OR_PULL% Panchovix reForge-Sigmas_merge main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/adieyal/sd-dynamic-prompts
call %GITHUB_CLONE_OR_PULL% adieyal sd-dynamic-prompts main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM 2024/11/15 JSON Decode Error https://github.com/Haoming02/sd-forge-couple/commit/3925bc756e6bb221ee2b6326aea1594d40519953
@REM https://github.com/Haoming02/sd-forge-couple
call %GITHUB_CLONE_OR_PULL% Haoming02 sd-forge-couple main ef08a705d69d538cd8c763e75250eec8225f5b22
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/blue-pen5805/sdweb-easy-generate-forever
call %GITHUB_CLONE_OR_PULL% blue-pen5805 sdweb-easy-generate-forever master
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/alemelis/sd-webui-ar
call %GITHUB_CLONE_OR_PULL% alemelis sd-webui-ar main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

if not exist sd-webui-ar\resolutions.txt (
	echo copy %~dp0src\resolutions.txt sd-webui-ar\
	copy %~dp0src\resolutions.txt sd-webui-ar\
)

if not exist sd-webui-ar\aspect_ratios.txt (
	echo copy %~dp0src\aspect_ratios.txt sd-webui-ar\
	copy %~dp0src\aspect_ratios.txt sd-webui-ar\
)

@REM https://github.com/hako-mikan/sd-webui-cd-tuner
call %GITHUB_CLONE_OR_PULL% hako-mikan sd-webui-cd-tuner main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/hako-mikan/sd-webui-lora-block-weight
call %GITHUB_CLONE_OR_PULL% hako-mikan sd-webui-lora-block-weight main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM ver13 ブランチへの切り替え
@REM https://github.com/Panchovix/stable-diffusion-webui-reForge/issues/144
git -C sd-webui-lora-block-weight switch -C ver13 origin/ver13
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

@REM https://github.com/hako-mikan/sd-webui-negpip
call %GITHUB_CLONE_OR_PULL% hako-mikan sd-webui-negpip main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/nihedon/sd-webui-weight-helper
call %GITHUB_CLONE_OR_PULL% nihedon sd-webui-weight-helper main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/zixaphir/Stable-Diffusion-Webui-Civitai-Helper
call %GITHUB_CLONE_OR_PULL% zixaphir Stable-Diffusion-Webui-Civitai-Helper master
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/KohakuBlueleaf/z-tipo-extension
call %GITHUB_CLONE_OR_PULL% KohakuBlueleaf z-tipo-extension main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/L4Ph/stable-diffusion-webui-localization-ja_JP
call %GITHUB_CLONE_OR_PULL% L4Ph stable-diffusion-webui-localization-ja_JP main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem %~dp0..\..\stable-diffusion-webui-reForge\extensions
