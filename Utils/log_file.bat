@echo off
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

@REM 設定時間戳記 (Seq 使用 ISO 8601 格式)
if "%Timestamp%"=="" call %~dp0get_date.bat 0 "yyyy-MM-ddTHH:mm:ss.fffZ"

@REM 檢查目錄與檔案是否存在，不存在則建立
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"
if not exist "%LogFile%" type nul > "%LogFile%"

@REM 寫入檔案
echo [%YMD%] [%LogLevel%] %LogMessage% >> "%LogFile%"

endlocal
exit /b