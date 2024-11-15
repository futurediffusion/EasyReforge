@echo off
call %~dp0Reforge.bat --pin-shared-memory --cuda-malloc --cuda-stream %*
cmd /k
