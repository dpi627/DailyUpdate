@echo off
setlocal enabledelayedexpansion

@REM 傳入參數說明
@REM %1 {string} 訊息字串

@REM 設定傳入參數
set "MSG=%~1"

@REM 設定變數並複製到剪貼簿
if "!MSG!" neq "" (
    echo | set /p="%~1" | clip
    echo Message %BGR%"!MSG!"%R% Copied to Clipboard.
    echo.
)

endlocal
exit /b