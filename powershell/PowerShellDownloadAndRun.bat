@echo off
cls
echo Inicio do script "%0..."
@echo ----------------------------------------------------------

set URL=%1
if "%URL%" == "" goto :EOF
echo - URL: %URL%

set GRUPO=%2
if "%GRUPO%" == "" set GRUPO=default
echo - GRUPO: %GRUPO%

@rem Formatar data e hora como YYYYMMDD_HHMMSS
set FILE_DATE=%date:~6,4%%date:~3,2%%date:~0,2%
set FILE_TIME=%time:~0,2%%time:~3,2%%time:~6,2%
set "FILE_TIME=%file_time: =0%"
set FILE_TO_RUN=C:\temp\powershell_%file_date%_%file_time%.ps1
set FILE_TO_LOG=C:\temp\powershell_%file_date%_%file_time%.log
if not exist "c:\temp\" md c:\temp

echo - Script para executar: %FILE_TO_RUN% >> %FILE_TO_LOG%

@echo - Baixando script '%URL%'... >> %FILE_TO_LOG%
@echo ----------------------------------------------------------
curl -k -s -o %FILE_TO_RUN% %URL% >> %FILE_TO_LOG%

powershell -executionpolicy unrestricted -File %FILE_TO_RUN% -grupo %GRUPO% >> %FILE_TO_LOG%

@echo Fim do script "%0"
@TIMEOUT 10 /nobreak