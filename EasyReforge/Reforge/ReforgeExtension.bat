@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\EasyTools
set GITHUB_CLONE_OR_PULL=%EASY_TOOLS%\Git\GitHub_CloneOrPull.bat
set CURL_CMD=C:\Windows\System32\curl.exe -kL

pushd %~dp0..\..\stable-diffusion-webui-reForge\extensions

if not exist ..\extensions-backup\ (
	mkdir ..\extensions-backup
)

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

@REM 2024/11/15 JSON Decode Error
@REM https://github.com/Haoming02/sd-forge-couple/commit/3925bc756e6bb221ee2b6326aea1594d40519953
@REM ef08a705d69d538cd8c763e75250eec8225f5b22
@REM https://github.com/Haoming02/sd-forge-couple
@REM TODO: HEAD への再追従
call %GITHUB_CLONE_OR_PULL% Haoming02 sd-forge-couple main d157041bf7de425761fdf84611d9e358959cb066
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/blue-pen5805/sdweb-easy-generate-forever
call %GITHUB_CLONE_OR_PULL% blue-pen5805 sdweb-easy-generate-forever master
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/alemelis/sd-webui-ar
@REM call %GITHUB_CLONE_OR_PULL% alemelis sd-webui-ar main
@REM if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

call :MOVE_TO_BACKUP sd-webui-ar

@REM https://github.com/altoiddealer/--sd-webui-ar-plusplus
call %GITHUB_CLONE_OR_PULL% altoiddealer --sd-webui-ar-plusplus main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

if not exist --sd-webui-ar-plusplus\resolutions.txt (
	echo copy %~dp0src\resolutions.txt --sd-webui-ar-plusplus\
	copy %~dp0src\resolutions.txt --sd-webui-ar-plusplus\
)

if not exist --sd-webui-ar-plusplus\aspect_ratios.txt (
	echo copy %~dp0src\aspect_ratios.txt --sd-webui-ar-plusplus\
	copy %~dp0src\aspect_ratios.txt --sd-webui-ar-plusplus\
)

@REM https://github.com/hako-mikan/sd-webui-cd-tuner
call %GITHUB_CLONE_OR_PULL% hako-mikan sd-webui-cd-tuner main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/hako-mikan/sd-webui-lora-block-weight
@REM call %GITHUB_CLONE_OR_PULL% hako-mikan sd-webui-lora-block-weight main
@REM if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM hako-mikan/sd-webui-lora-block-weight ver13 ブランチへの切り替え
@REM https://github.com/Panchovix/stable-diffusion-webui-reForge/issues/144
@REM git -C sd-webui-lora-block-weight switch -C ver13 origin/ver13
@REM if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

call :MOVE_TO_BACKUP sd-webui-lora-block-weight
call :MOVE_TO_BACKUP sd-webui-lora-block-weight-reforge
@REM call :MOVE_TO_BACKUP ..\extensions-builtin\sd-webui-lora-block-weight-reforge

@REM https://github.com/Panchovix/sd-webui-lora-block-weight-reforge
@REM call %GITHUB_CLONE_OR_PULL% Panchovix sd-webui-lora-block-weight-reforge main
@REM if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/hako-mikan/sd-webui-negpip
call %GITHUB_CLONE_OR_PULL% hako-mikan sd-webui-negpip main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/nihedon/sd-webui-weight-helper
call %GITHUB_CLONE_OR_PULL% nihedon sd-webui-weight-helper main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/zixaphir/Stable-Diffusion-Webui-Civitai-Helper
call %GITHUB_CLONE_OR_PULL% zixaphir Stable-Diffusion-Webui-Civitai-Helper master
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/Bocchi-Chan2023/stable-diffusion-webui-wd14-tagger
call %GITHUB_CLONE_OR_PULL% Bocchi-Chan2023 stable-diffusion-webui-wd14-tagger master 2d313188ae9176906e9d6c5138d4b1638ff19a09
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

echo %CURL_CMD% -o stable-diffusion-webui-wd14-tagger\tagger\utils.py https://gist.githubusercontent.com/Zuntan03/ec9010bef0f8fce5b752facd3f8053f0/raw
%CURL_CMD% -o stable-diffusion-webui-wd14-tagger\tagger\utils.py https://gist.githubusercontent.com/Zuntan03/ec9010bef0f8fce5b752facd3f8053f0/raw
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

@REM https://github.com/KohakuBlueleaf/z-tipo-extension
call %GITHUB_CLONE_OR_PULL% KohakuBlueleaf z-tipo-extension main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

@REM https://github.com/L4Ph/stable-diffusion-webui-localization-ja_JP
call %GITHUB_CLONE_OR_PULL% L4Ph stable-diffusion-webui-localization-ja_JP main
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem %~dp0..\..\stable-diffusion-webui-reForge\extensions
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
