@echo off
chcp 65001 > NUL

call %~dp0A1111\A1111.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )

call %~dp0A1111\A1111Extension.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )

call %~dp0A1111\A1111Link.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )
