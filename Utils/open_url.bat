@echo off
setlocal enabledelayedexpansion

@REM 參數說明
@REM %1 {string} 網址 "http://twtpeoad001/SGS/"

@REM 設定傳入參數
set "URL=%~1"

@REM 檢查傳入參數
if "!URL!"=="" (
    echo %RD%Error:%R% url not specified
    goto end
)

@REM 前導提示
echo Opening %BCY%!URL!%R%...
echo.

@REM 開啟網站
start "" "!URL!"

:end
endlocal
echo.