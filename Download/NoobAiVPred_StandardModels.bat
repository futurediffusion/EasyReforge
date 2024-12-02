@echo off
chcp 65001 > NUL

@REM 最大 14項目 100GB 目安

call %~dp0Stable-diffusion\NoobV\copycatNoobV_v06.bat
call %~dp0Stable-diffusion\NoobV\HikariNoob_v065.bat
call %~dp0Stable-diffusion\NoobV\illusobV_v165s.bat
call %~dp0Stable-diffusion\NoobV\ObsessionV_v01.bat
call %~dp0Stable-diffusion\NoobV\PersonalMergeVNormal_v05.bat
call %~dp0Stable-diffusion\NoobV\susamixV_v31.bat

call %~dp0Stable-diffusion\NoobV_Base\NoobAiVPred_v065s.bat

call %~dp0NoobAiVPred_Standard.bat
