@echo off
chcp 65001 > NUL

call %~dp0NoobAiEpsilonPred_Standard.bat

call %~dp0Stable-diffusion\NoobE\CuteNoobAI_v10.bat
call %~dp0Stable-diffusion\NoobE\illusobXl_v10.bat
call %~dp0Stable-diffusion\NoobE\LibrasIllustriousXL_v40a.bat
call %~dp0Stable-diffusion\NoobE\NtrMix_v35.bat
call %~dp0Stable-diffusion\NoobE\Obsession_v30.bat
call %~dp0Stable-diffusion\NoobE\PersonalMerge_v30.bat

call %~dp0Stable-diffusion\NoobE_Unique\PVCStyleModelMovable_v10.bat

call %~dp0Stable-diffusion\NoobE_Base\NoobAiEpsilonPred_v10.bat
