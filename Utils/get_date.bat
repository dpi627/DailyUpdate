@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

@REM 傳入參數說明
@REM %1 {int} 取得位移天數，預設 -1 (昨天)
@REM %2 {string} 取得日期格式字串，預設 "yyyyMMdd"
@REM %3 {string} 安靜模式(不輸出訊息)

@REM 設定傳入參數
set "DAYS=%1"
set "FORMAT=%~2"
set "SILENT=%~3"

@REM 如果參數空白，設定預設值
if "!DAYS!"=="" set DAYS=-1
if "!FORMAT!"=="" set FORMAT=yyyyMMdd

@REM 前導提示
echo Get DateTime %BCY%!FORMAT!%R%, shift %BCY%!DAYS!%R% days...

@REM 透過 powershell 取得日期 yyyyMMdd 字串 並設定給 RESULT 變數
for /f "delims=" %%a in ('powershell -Command [DateTime]::Now.AddDays(!DAYS!^).ToString(\"!FORMAT!\"^)') do set YMD=%%a

@REM 完成通知
if "!SILENT!" equ "y" (
    echo %BGR%!YMD!%R% saved to variable: %BMG%YMD%R%
    echo.
)

@REM 設定全域變數
endlocal & set "YMD=%YMD%"