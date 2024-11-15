@echo off
chcp 65001 > NUL
cd /d %~dp0stable-diffusion-webui-reForge
call venv\Scripts\activate.bat
cmd /k
