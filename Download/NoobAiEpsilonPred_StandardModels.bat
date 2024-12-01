@echo off
chcp 65001 > NUL

@REM 最大 14項目 100GB 目安

call %~dp0Stable-diffusion\NoobE\illusobXl_v10.bat
call %~dp0Stable-diffusion\NoobE\LibrasIllustriousXL_v40a.bat
call %~dp0Stable-diffusion\NoobE\NonameMix_v11.bat
call %~dp0Stable-diffusion\NoobE\NonameMixL_v11.bat
call %~dp0Stable-diffusion\NoobE\NtrMix_v40.bat
call %~dp0Stable-diffusion\NoobE\Obsession_v30.bat
call %~dp0Stable-diffusion\NoobE\PersonalMerge_v30.bat
call %~dp0Stable-diffusion\NoobE\WaiShuffleNoob_v10.bat

call %~dp0Stable-diffusion\NoobE_Unique\PVCStyleModelMovable_v10.bat

call %~dp0Stable-diffusion\NoobE_Base\NoobAiEpsilonPred_v11.bat

call %~dp0NoobAiEpsilonPred_Standard.bat
