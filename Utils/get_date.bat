@echo off
setlocal enabledelayedexpansion

@REM 傳入參數說明
@REM %1: 取得日期位移，預設 -1 (昨天)
@REM %2: 取得日期格式，預設 yyyyMMdd

@REM 設定傳入參數
set "DAYS=%1"
set "FORMAT=%~2"

@REM 如果參數空白，設定預設值
if "!DAYS!"=="" set DAYS=-1
if "!FORMAT!"=="" set FORMAT=yyyyMMdd

@REM 前導提示
echo Get DateTime [!FORMAT!], shift !DAYS! days...
echo.

@REM 透過 powershell 取得日期 yyyyMMdd 字串 並設定給 RESULT 變數
for /f "delims=" %%a in ('powershell -Command [DateTime]::Now.AddDays(!DAYS!^).ToString(\"!FORMAT!\"^)') do set YMD=%%a

@REM 完成通知
echo [!YMD!] saved to variable: YMD
echo.

@REM 設定全域變數
endlocal & set "YMD=%YMD%"