@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\EasyTools
set ARIA=%EASY_TOOLS%\Download\Aria.bat

echo https://huggingface.co/Undi95/Lumimaid-Magnum-v4-12B-GGUF
set HUGGING_FACE_REPO=Undi95/Lumimaid-Magnum-v4-12B-GGUF
set HUGGING_FACE_DIR=
set HUGGING_FACE_FILE=Lumimaid-Magnum-v4-12B.q4_k_m.gguf
set LLM_MODEL_DIR=%~dp0

if exist %LLM_MODEL_DIR%%HUGGING_FACE_FILE% ( goto :LLM_MODEL_EXISTS )
if not exist %LLM_MODEL_DIR% ( mkdir %LLM_MODEL_DIR% )

call %ARIA% %LLM_MODEL_DIR% %HUGGING_FACE_FILE% ^
https://huggingface.co/%HUGGING_FACE_REPO%/resolve/main/%HUGGING_FACE_DIR%%HUGGING_FACE_FILE%
if %ERRORLEVEL% neq 0 ( exit /b 1 )

:LLM_MODEL_EXISTS

call "%~dp099_ModelDragAndDrop_Cpu.bat" "%LLM_MODEL_DIR%%HUGGING_FACE_FILE%" %*
