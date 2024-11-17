@echo off
chcp 65001 > NUL

call %~dp0NoobAiVPred_Standard.bat

call %~dp0Stable-diffusion\NoobV_Base\NoobAiVPred_v06.bat
