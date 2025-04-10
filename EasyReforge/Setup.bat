@echo off
chcp 65001 > NUL

call %~dp0Reforge\Reforge.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )

call %~dp0Reforge\ReforgeExtension.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )

call %~dp0Reforge\ReforgeLink.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )

if exist %~dp0vc_redist.x64.exe ( goto :EXIST_VC_REDIST_X64 )
echo.
echo %CURL_CMD% -o %~dp0vc_redist.x64.exe https://aka.ms/vs/17/release/vc_redist.x64.exe
%CURL_CMD% -o %~dp0vc_redist.x64.exe https://aka.ms/vs/17/release/vc_redist.x64.exe
if %ERRORLEVEL% neq 0 ( pause & exit /b 1 )
:EXIST_VC_REDIST_X64

@REM if not exist %~dp0..\stable-diffusion-webui\ ( goto :SKIP_A1111_UPDATE )
@REM call %~dp0SetupA1111.bat
@REM if %ERRORLEVEL% neq 0 ( exit /b 1 )
@REM :SKIP_A1111_UPDATE

if not exist %~dp0..\stable-diffusion-webui-forge\ ( goto :SKIP_FORGE_UPDATE )
call %~dp0SetupForge.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )
:SKIP_FORGE_UPDATE

if exist %~dp0Reforge\Update_DisableMinimumDownload.txt ( exit /b 0 )

if exist %~dp0..\Model\Stable-diffusion\NoobE\ (
	@REM call %~dp0..\Download\NoobAiEpsilonPred_Minimum.bat
	call %~dp0..\Download\src\NoobAiCommon_Minimum.bat
	@REM リンク切れ対策としてダウンロードの結果は確認しない
)
