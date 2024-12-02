@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\EasyTools
set GIT_SET_PATH=%EASY_TOOLS%\Git\Git_SetPath.bat

call %GIT_SET_PATH%
if %ERRORLEVEL% neq 0 ( exit /b 1 )

pushd %~dp0..\stable-diffusion-webui-reForge

@REM dev ブランチへの切り替え
git switch -C dev origin/dev
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

popd rem %~dp0..\stable-diffusion-webui-reForge
