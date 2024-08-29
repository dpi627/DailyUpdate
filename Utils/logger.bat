@echo off
setlocal enabledelayedexpansion

@REM 設定傳入參數
set "LogMessage=%~1"
set "LogLevel=%~2"
set "LogFile=%~3"

@REM 如果參數空白，設定預設值
if "%LogMessage%"=="" set "LogMessage=This is a test message"
if "%LogLevel%"=="" set "LogLevel=Information"
if "%LogFile%"=="" set "LogFile=%LOG_FILE%"

@REM 設定時間戳記 (Seq 使用 ISO 8601 格式)
call %~dp0get_date.bat 0 "yyyy-MM-ddTHH:mm:ss.fffZ"
@REM set "Timestamp=%YMD%"

call %~dp0log_file.bat "%YMD%" "%LogMessage%" "%LogLevel%" "%LogFile%"
call %~dp0log_seq.bat "%YMD%" "%LogMessage%" "%LogLevel%" "%LogFile%"

exit /b

endlocal