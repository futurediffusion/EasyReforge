@echo off
chcp 65001 > NUL
@REM Minimum は Civitai ログイン不要を維持する
call %~dp0src\NoobAiCommon_Minimum.bat

call %~dp0Stable-diffusion\NoobV\HarmoniqMixSpo_v22.bat
call %~dp0Stable-diffusion\NoobV\CatTower_v12.bat
