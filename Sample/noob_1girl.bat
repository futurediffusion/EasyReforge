@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\EasyTools
set ARIA=%EASY_TOOLS%\Download\Aria.bat
set PS_CMD=PowerShell -Version 5.1 -NoProfile -ExecutionPolicy Bypass
pushd %~dp0

if exist noob_1girl/ ( exit /b 0 )

call %ARIA% .\ noob_1girl.zip https://yyy.wpx.jp/EasyReforge/noob_1girl.zip
if %ERRORLEVEL% neq 0 ( exit /b 1 )

echo %PS_CMD% "try { Expand-Archive -Path noob_1girl.zip -DestinationPath . -Force } catch { exit 1 }"
%PS_CMD% "try { Expand-Archive -Path noob_1girl.zip -DestinationPath . -Force } catch { exit 1 }"
if %ERRORLEVEL% neq 0 ( pause & exit /b 1 )

echo del /Q noob_1girl.zip
del /Q noob_1girl.zip
if %ERRORLEVEL% neq 0 ( pause & exit /b 1 )

popd rem %~dp0
