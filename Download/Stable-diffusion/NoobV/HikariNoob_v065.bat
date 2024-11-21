@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\..\EasyTools
set HUGGING_FACE=%EASY_TOOLS%\Download\HuggingFace.bat
pushd %~dp0..\..\..\Model\Stable-diffusion

@REM https://huggingface.co/RedRayz/hikari_noob_0.6.5
call %HUGGING_FACE% NoobV\ HikariNoob_v065.safetensors RedRayz/hikari_noob_0.6.5 Hikari_Noob_v-pred_0.6.5.safetensors?
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem %~dp0..\..\..\Model\Stable-diffusion
