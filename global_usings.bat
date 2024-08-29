@echo off

@REM 外部參數說明
@REM %1 {string} 顯示詳細訊息，預設無，啟用帶入 y

@REM 取得外部傳遞參數
set "DETAIL=%~1"

@REM 載入顏色設定
call .\Utils\colors.bat %DETAIL%
@REM 載入系統設定
call .\Utils\load_config.bat ".\Configs\system.ini" %DETAIL%
@REM 載入訊息設定
call .\Utils\load_config.bat ".\Configs\message.ini" %DETAIL%
@REM 載入個人設定，預設顯示詳細訊息
call .\Utils\load_config.bat ".\Configs\personal.ini" y