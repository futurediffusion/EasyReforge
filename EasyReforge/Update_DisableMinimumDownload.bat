@echo off
if not exist %~dp0Reforge\Update_DisableMinimumDownload.txt ( copy NUL %~dp0Reforge\Update_DisableMinimumDownload.txt > NUL )
