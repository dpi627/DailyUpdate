@echo off

@REM 傳入參數說明
@REM %1 {string} 設定檔名稱，預設 "config.ini"
@REM %2 {string} 顯示詳細設定，預設無，啟用帶入 y

@REM 設定傳入參數
set "CONFIG=%~1"
set "DETAIL=%~2"

@REM 如果參數空白，設定預設值
if "%CONFIG%"=="" set CONFIG=config.ini

@REM 前導提示
echo Loading settings from [%CONFIG%]...
echo.

@REM 讀取 config.ini 設定檔，設定所有全域變數
for /f "usebackq tokens=1,* delims==" %%A in ("%CONFIG%") do (
    set "line=%%A"
    @REM 判斷是否為註解
    if "!line:~0,1!" neq ";" (
        set "%%A=%%B"
        if "%DETAIL%"=="y" echo :: %%A=%%B
    )
)
if "%DETAIL%"=="y" echo.

@REM 完成通知
echo [%CONFIG%] loaded.
echo.