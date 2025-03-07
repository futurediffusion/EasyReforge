@echo off
chcp 65001 > NUL

call %~dp0Forge\Forge.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )

call %~dp0Forge\ForgeExtension.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )

call %~dp0Forge\ForgeLink.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )
