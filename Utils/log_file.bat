@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

@REM 設定傳入參數
set "Timestamp=%~1"
set "LogMessage=%~2"
set "LogLevel=%~3"
set "LogFile=%~4"

@REM 如果參數空白，設定預設值
if "%LogMessage%"=="" set "LogMessage=This is a test message"
if "%LogLevel%"=="" set "LogLevel=INF"
if "%LogFile%"=="" set "LogFile=%LOG_FILE%"

if "%Timestamp%"=="" (
    @REM 設定時間戳記 (Seq 使用 ISO 8601 格式)
    call %~dp0get_date.bat 0 "yyyy-MM-ddTHH:mm:ss.fffZ"
    set "Timestamp=%YMD%"
)
@REM @REM 設定時間戳記 (Seq 使用 ISO 8601 格式)
@REM call %~dp0get_date.bat 0 "yyyy-MM-ddTHH:mm:ss.fffZ"
@REM set "Timestamp=%YMD%"

:: 寫入日誌
echo [%Timestamp%] [%LogLevel%] %LogMessage% >> "%LogFile%"

exit /b

endlocal