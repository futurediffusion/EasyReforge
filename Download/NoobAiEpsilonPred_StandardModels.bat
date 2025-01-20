@echo off
chcp 65001 > NUL

@REM 最大 14項目 100GB 目安

@REM 直近更新有り
call %~dp0Stable-diffusion\NoobE\momiziNoob_v31.bat
call %~dp0Stable-diffusion\NoobE\NtrMix_vXIII.bat
call %~dp0Stable-diffusion\NoobE\Obsession_v31.bat
call %~dp0Stable-diffusion\NoobE\WaiShuffleNoob_v20.bat

@REM 直近更新無し
@REM call %~dp0Stable-diffusion\NoobE\illusobXl_v10.bat
@REM call %~dp0Stable-diffusion\NoobE\LibrasIllustriousXL_v40a.bat
@REM call %~dp0Stable-diffusion\NoobE\NonameMix_v11.bat
@REM call %~dp0Stable-diffusion\NoobE\NonameMixL_v11.bat
@REM call %~dp0Stable-diffusion\NoobE\PersonalMerge_v30.bat

call %~dp0Stable-diffusion\NoobE_Base\NoobAiEpsilonPred_v11.bat

call %~dp0Stable-diffusion\NoobE_Real\PornMasterPro_v10.bat

call %~dp0Stable-diffusion\NoobE_Unique\ColourfulTart_v10.bat
call %~dp0Stable-diffusion\NoobE_Unique\MatureRitual_v20.bat
call %~dp0Stable-diffusion\NoobE_Unique\PVCStyleModelMovable_v12.bat

call %~dp0NoobAiEpsilonPred_Standard.bat
