@echo off
chcp 65001 > NUL

call %~dp0Stable-diffusion\NoobV\copycatNoobV_v06.bat
call %~dp0Stable-diffusion\NoobV\HarmoniqMixSpoEx_v11.bat
call %~dp0Stable-diffusion\NoobV\illusobV05_v11.bat
call %~dp0Stable-diffusion\NoobV\ObsessionV_v01.bat

call %~dp0Stable-diffusion\NoobV_Base\NoobAiVPred_v06.bat

call %~dp0NoobAiVPred_Standard.bat
