@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\EasyTools
set JUNCTION=%EASY_TOOLS%\Link\Junction.bat

setlocal enabledelayedexpansion
set "LINK_SRC=%~1"
set "LINK_NAME=%~nx1"

if "%LINK_SRC%"=="" (
	set /p LINK_SRC="参照元のフォルダをドラッグ＆ドロップしてください: "
	if not exist "!LINK_SRC!" (
		echo "参照元のフォルダが見つかりません: !LINK_SRC!"
		pause & endlocal & exit /b 1
	)
	for %%i in ("!LINK_SRC!") do set "LINK_NAME=%%~nxi"

	set /p LINK_NAME_INPUT="数文字の短いリンク名を入力してください（空欄なら !LINK_NAME! ）: "
	if not "!LINK_NAME_INPUT!"=="" set LINK_NAME=!LINK_NAME_INPUT!
)

call %JUNCTION% "%~dp0%LINK_NAME%" "%LINK_SRC%"
if %ERRORLEVEL% neq 0 ( endlocal & exit /b 1 )
endlocal
