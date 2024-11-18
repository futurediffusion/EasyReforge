@echo off
chcp 65001 > NUL

call %~dp0Stable-diffusion\NoobV\copycatNoobV_v06_v06.bat
call %~dp0Stable-diffusion\NoobV\NoobAiVPredIterComp_v06.bat

call %~dp0Stable-diffusion\NoobV_Base\NoobAiVPred_v06.bat

call %~dp0NoobAiVPred_Standard.bat
