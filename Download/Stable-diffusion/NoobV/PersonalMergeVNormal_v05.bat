@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\..\..\EasyTools
set HUGGING_FACE=%EASY_TOOLS%\Download\HuggingFace.bat
pushd %~dp0..\..\..\Model\Stable-diffusion

@REM https://huggingface.co/Illustrious012585/illustriousXLPersonalMerge_vp05testNormalsteps
call %HUGGING_FACE% NoobV\ PersonalMergeVNormal_v05.safetensors Illustrious012585/illustriousXLPersonalMerge_vp05testNormalsteps illustriousXLPersonalMerge_vp05testNormalsteps.safetensors?
if %ERRORLEVEL% neq 0 ( popd & exit /b 1 )

popd rem %~dp0..\..\..\Model\Stable-diffusion

exit /b 0
