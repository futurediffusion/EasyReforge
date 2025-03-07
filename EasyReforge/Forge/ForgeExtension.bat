@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\EasyTools
set GITHUB_CLONE_OR_PULL=%EASY_TOOLS%\Git\GitHub_CloneOrPull.bat
set CURL_CMD=C:\Windows\System32\curl.exe -kL

pushd %~dp0..\..\stable-diffusion-webui-forge\extensions

if not exist ..\extensions-backup\ (
	mkdir ..\extensions-backup
)

@REM https://github.com/DominikDoom/a1111-sd-webui-tagcomplete
call %GITHUB_CLONE_OR_PULL% DominikDoom a1111-sd-webui-tagcomplete main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/adieyal/sd-dynamic-prompts
call %GITHUB_CLONE_OR_PULL% adieyal sd-dynamic-prompts main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/Haoming02/sd-forge-couple
call %GITHUB_CLONE_OR_PULL% Haoming02 sd-forge-couple main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/blue-pen5805/sdweb-easy-generate-forever
call %GITHUB_CLONE_OR_PULL% blue-pen5805 sdweb-easy-generate-forever master
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/altoiddealer/--sd-webui-ar-plusplus
call %GITHUB_CLONE_OR_PULL% altoiddealer --sd-webui-ar-plusplus main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

if not exist --sd-webui-ar-plusplus\resolutions.txt (
	echo copy %~dp0..\Reforge\src\resolutions.txt --sd-webui-ar-plusplus\
	copy %~dp0..\Reforge\src\resolutions.txt --sd-webui-ar-plusplus\
)

if not exist --sd-webui-ar-plusplus\aspect_ratios.txt (
	echo copy %~dp0..\Reforge\src\aspect_ratios.txt --sd-webui-ar-plusplus\
	copy %~dp0..\Reforge\src\aspect_ratios.txt --sd-webui-ar-plusplus\
)

@REM https://github.com/hako-mikan/sd-webui-cd-tuner
call %GITHUB_CLONE_OR_PULL% hako-mikan sd-webui-cd-tuner main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/hako-mikan/sd-webui-lora-block-weight
call %GITHUB_CLONE_OR_PULL% hako-mikan sd-webui-lora-block-weight main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/hako-mikan/sd-webui-negpip
call %GITHUB_CLONE_OR_PULL% hako-mikan sd-webui-negpip main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/bluelovers/sd-webui-pnginfo-beautify
call %GITHUB_CLONE_OR_PULL% bluelovers sd-webui-pnginfo-beautify master
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/hako-mikan/sd-webui-regional-prompter
@REM call %GITHUB_CLONE_OR_PULL% hako-mikan sd-webui-regional-prompter main
@REM if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/hako-mikan/sd-webui-supermerger
call %GITHUB_CLONE_OR_PULL% hako-mikan sd-webui-supermerger main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/hako-mikan/sd-webui-traintrain
call %GITHUB_CLONE_OR_PULL% hako-mikan sd-webui-traintrain main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/nihedon/sd-webui-weight-helper
call %GITHUB_CLONE_OR_PULL% nihedon sd-webui-weight-helper main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/zixaphir/Stable-Diffusion-Webui-Civitai-Helper
@REM call %GITHUB_CLONE_OR_PULL% zixaphir Stable-Diffusion-Webui-Civitai-Helper master
@REM if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/Bocchi-Chan2023/stable-diffusion-webui-wd14-tagger
@REM call %GITHUB_CLONE_OR_PULL% Bocchi-Chan2023 stable-diffusion-webui-wd14-tagger master 2d313188ae9176906e9d6c5138d4b1638ff19a09
@REM if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM echo %CURL_CMD% -o stable-diffusion-webui-wd14-tagger\tagger\utils.py https://gist.githubusercontent.com/Zuntan03/ec9010bef0f8fce5b752facd3f8053f0/raw
@REM %CURL_CMD% -o stable-diffusion-webui-wd14-tagger\tagger\utils.py https://gist.githubusercontent.com/Zuntan03/ec9010bef0f8fce5b752facd3f8053f0/raw
@REM if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

@REM https://github.com/KohakuBlueleaf/z-tipo-extension
call %GITHUB_CLONE_OR_PULL% KohakuBlueleaf z-tipo-extension main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/L4Ph/stable-diffusion-webui-localization-ja_JP
call %GITHUB_CLONE_OR_PULL% L4Ph stable-diffusion-webui-localization-ja_JP main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem %~dp0..\..\stable-diffusion-webui-forge\extensions
exit /b 0

:MOVE_TO_BACKUP
set "SRC_DIR=%1"
if not exist %SRC_DIR% ( exit /b 0 )

if not exist ..\extensions-backup\ (
	echo mkdir ..\extensions-backup
	mkdir ..\extensions-backup
)

set "DST_DIR=..\extensions-backup\%~nx1"
if exist %DST_DIR%\ (
	echo rmdir /S /Q %DST_DIR%
    rmdir /S /Q %DST_DIR%
)

echo move /Y %SRC_DIR% %DST_DIR%
move /Y %SRC_DIR% %DST_DIR%

exit /b 0
