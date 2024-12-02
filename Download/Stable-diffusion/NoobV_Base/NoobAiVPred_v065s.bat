@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\..\EasyTools
set HUGGING_FACE=%EASY_TOOLS%\Download\HuggingFace.bat
pushd %~dp0..\..\..\Model\Stable-diffusion

@REM https://huggingface.co/Laxhar/noobai-XL-Vpred-0.65s
call %HUGGING_FACE% NoobV_Base\ NoobAiVPred_v065s.safetensors Laxhar/noobai-XL-Vpred-0.65s NoobAI-XL-Vpred-v0.65s.safetensors?
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem %~dp0..\..\..\Model\Stable-diffusion
