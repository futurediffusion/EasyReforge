@echo off
chcp 65001 > NUL
@REM Minimum は Civitai ログイン不要を維持する
call %~dp0src\NoobAiCommon_Minimum.bat

call %~dp0Stable-diffusion\NoobV\PersonalMergeVNormal_v05.bat
call %~dp0Stable-diffusion\NoobV\HarmoniqMixSpo_v11.bat
