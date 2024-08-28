@echo off

@REM 傳入參數說明
@REM %1: 取得日期位移，預設 -1 (昨天)

@REM 設定傳入參數
set "CONFIG=%~1"

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
        echo :: %%A=%%B
    )
)
echo.

@REM 完成通知
echo [%CONFIG%] loaded.
echo.