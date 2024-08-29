@echo off
setlocal enabledelayedexpansion

:: Seq 服務器的 URL 和 API 密鑰
set "SEQ_URL=http://twtpeoad002:5341/"
set "API_KEY=seWpW3r80et5WT6aRjuq"

:: 設置日誌信息
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set "TIMESTAMP=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%T%datetime:~8,2%:%datetime:~10,2%:%datetime:~12,2%.%datetime:~15,3%Z"
set "MESSAGE=This is a test log message"
set "LEVEL=Information"

:: 構建 JSON 數據
set "JSON={\"Events\":[{\"Timestamp\":\"%TIMESTAMP%\",\"MessageTemplate\":\"%MESSAGE%\",\"Level\":\"%LEVEL%\",\"Properties\":{}}]}"

:: 使用 curl 發送數據到 Seq
curl -X POST "%SEQ_URL%api/events/raw" ^
     -H "Content-Type: application/json" ^
     -H "X-Seq-ApiKey: %API_KEY%" ^
     -d "%JSON%"

if %errorlevel% equ 0 (
    echo Log sent to Seq: %MESSAGE%
) else (
    echo Failed to send log to Seq
)

endlocal