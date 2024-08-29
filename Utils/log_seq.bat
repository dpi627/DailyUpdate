@echo off
setlocal enabledelayedexpansion

:: Seq 服务器的 URL 和 API 密钥
set "SEQ_URL=http://twtpeoad002:5341/"
set "API_KEY=seWpW3r80et5WT6aRjuq"

:: 设置日志信息
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set "TIMESTAMP=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%T%datetime:~8,2%:%datetime:~10,2%:%datetime:~12,2%.%datetime:~15,3%Z"
set "LEVEL=Information"

:: 设置消息模板和属性
set "MESSAGE_TEMPLATE=User {Username} logged in from {IPAddress}"
set "USERNAME=JohnDoe"
set "IPADDRESS=192.168.1.100"

:: 构建 JSON 数据
set "JSON={\"Events\":[{"
set "JSON=!JSON!\"Timestamp\":\"%TIMESTAMP%\","
set "JSON=!JSON!\"Level\":\"%LEVEL%\","
set "JSON=!JSON!\"MessageTemplate\":\"%MESSAGE_TEMPLATE%\","
set "JSON=!JSON!\"Properties\":{"
set "JSON=!JSON!\"Username\":\"%USERNAME%\","
set "JSON=!JSON!\"IPAddress\":\"%IPADDRESS%\""
set "JSON=!JSON!}}]}"

:: 使用 curl 发送数据到 Seq
curl -X POST "%SEQ_URL%api/events/raw" ^
     -H "Content-Type: application/json" ^
     -H "X-Seq-ApiKey: %API_KEY%" ^
     -d "%JSON%"

if %errorlevel% equ 0 (
    echo Log sent to Seq: %MESSAGE_TEMPLATE%
) else (
    echo Failed to send log to Seq
)

endlocal