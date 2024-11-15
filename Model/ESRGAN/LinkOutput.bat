@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\EasyTools
set JUNCTION=%EASY_TOOLS%\Link\Junction.bat

setlocal enabledelayedexpansion
set "LINK_DST=%~1"
set "LINK_SRC=%~dp0"
for %%i in ("%LINK_SRC:~0,-1%") do set "LINK_NAME=%%~nxi"

if "%LINK_DST%"=="" (
	set /p LINK_DST="参照先の親フォルダをドラッグ＆ドロップしてください: "
	if not exist "!LINK_DST!" (
		echo "参照先の親フォルダが見つかりません: !LINK_DST!"
		pause & endlocal & exit /b 1
	)
	for %%i in ("!LINK_DST!") do set "LINK_NAME=%%~nxi"

	set /p LINK_NAME_INPUT="数文字の短いリンク名を入力してください（空欄なら !LINK_NAME! ）: "
	if not "!LINK_NAME_INPUT!"=="" set LINK_NAME=!LINK_NAME_INPUT!
)

call %JUNCTION% "%LINK_DST%\%LINK_NAME%" "%LINK_SRC%"
if %ERRORLEVEL% neq 0 ( endlocal & exit /b 1 )
endlocal
