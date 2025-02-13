@echo off
chcp 65001 > NUL
set EASY_TOOLS=%~dp0..\EasyTools

set LLM_HOST=localhost
set LLM_PORT=7830

echo http://%LLM_HOST%:%LLM_PORT%
start http://%LLM_HOST%:%LLM_PORT%

set LLAMA_CPP_SERVER_ARGS=^
--host %LLM_HOST% ^
--port %LLM_PORT% ^
--model %*

echo call "%EASY_TOOLS%\LlamaCppServer.bat" %LLAMA_CPP_SERVER_ARGS%
call "%EASY_TOOLS%\LlamaCppServer.bat" %LLAMA_CPP_SERVER_ARGS%
