@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

@REM 檢查 curl 是否安裝，未安裝退出
where curl >nul 2>nul
if %errorlevel% neq 0 (
    echo %BYL%Warning:%R% curl is not installed. Skip this script.
    exit /b 1
)

@REM 傳入參數說明
@REM %1 {string} 訊息內容，預設 "This is a test message"
@REM %2 {string} 訊息等級，預設 "Information"，其他 "Error", "Warning"

@REM 設定傳入參數
set "TIMESTAMP=%~1"
set "MESSAGE=%~2"
set "LEVEL=%~3"

@REM 如果參數空白，設定預設值
if "%MESSAGE%"=="" set "MESSAGE=This is a test message"
if "%LEVEL%"=="" set "LEVEL=Information"

if "%TIMESTAMP%"=="" (
    @REM 設定時間戳記 (Seq 使用 ISO 8601 格式)
    call %~dp0get_date.bat 0 "yyyy-MM-ddTHH:mm:ss.fffZ"
    set "TIMESTAMP=%YMD%"
)
@REM @REM 設定時間戳記 (Seq 使用 ISO 8601 格式)
@REM call %~dp0get_date.bat 0 "yyyy-MM-ddTHH:mm:ss.fffZ"
@REM set "TIMESTAMP=%YMD%"

@REM 設定 Seq 伺服器資訊
set "SEQ_URL=%SEQ_URL%"
set "API_KEY=%SEQ_API_KEY%"

@REM 設定 Seq 訊息模板與屬性
set "MESSAGE_TEMPLATE=[{AppId}] {User}@{Host} Message: {Message}"
set "APP_ID=%APP_ID%"
set "USER_NM=%USERNAME%"
set "HOST_NM=%COMPUTERNAME%"

@REM 組合 JSON 資料
set "JSON={\"Events\":[{"
set "JSON=!JSON!\"Timestamp\":\"%TIMESTAMP%\","
set "JSON=!JSON!\"Level\":\"%LEVEL%\","
set "JSON=!JSON!\"MessageTemplate\":\"%MESSAGE_TEMPLATE%\","
set "JSON=!JSON!\"Properties\":{"
set "JSON=!JSON!\"AppId\":\"%APP_ID%\","
set "JSON=!JSON!\"User\":\"%USER_NM%\","
set "JSON=!JSON!\"Host\":\"%HOST_NM%\","
set "JSON=!JSON!\"Message\":\"%MESSAGE%\""
set "JSON=!JSON!}}]}"

@REM 使用 curl 送出 JSON 資料到 Seq
curl -s -o nul -X POST "%SEQ_URL%api/events/raw" ^
     -H "Content-Type: application/json" ^
     -H "X-Seq-ApiKey: %API_KEY%" ^
     -d "%JSON%"
echo.

if %errorlevel% neq 0 echo %BRD%Error:%R% Failed to send log to Seq

endlocal