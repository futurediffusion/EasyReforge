@echo off
chcp 65001 > NUL
setlocal enabledelayedexpansion

call %~dp0Reforge\Reforge.bat
if !ERRORLEVEL! neq 0 ( exit /b 1 )

call %~dp0Reforge\ReforgeExtension.bat
if !ERRORLEVEL! neq 0 ( exit /b 1 )

call %~dp0Reforge\ReforgeLink.bat
if !ERRORLEVEL! neq 0 ( exit /b 1 )

if exist %~dp0..\Model\Stable-diffusion\NoobE\ (
	call %~dp0..\Download\NoobAiEpsilonPred_Minimum.bat
	if !ERRORLEVEL! neq 0 ( endlocal & exit /b 1 )
)

endlocal
