@echo off
@REM 可搜尋 TODO: 自行修改參數(如果有)
chcp 65001 > nul
setlocal enabledelayedexpansion

@REM 參數說明
@REM %1 {string} 專案發佈(publis)路徑 

@REM 取得外部傳遞參數
set "PUB=%~1"

@REM 檢查傳入參數
if "!PUB!"=="" (
    echo %BRD%Error:%R% Publish path not specified
    goto end
)

@REM 設定 TODO: 變數
set "SCRIPTS_DIR=!PUB!\Scripts"
set "UPD_FILE=!SCRIPTS_DIR!\lastUpdate.js"

@REM 功能說明
echo :::: %BMG%Add Timestamp%R%
echo :::: %BBK%(非必要) 寫入最後更新時間戳記方便追蹤%R%
echo.

@REM 透過 powershell 取得目前時間
@REM for /f "delims=" %%a in ('powershell -Command "Get-Date -format 'yyyy-MM-dd HH:mm:ss'"') do @set UPD=%%a
call .\Utils\get_date.bat 0 "yyyy-MM-dd HH:mm:ss"
@REM echo Get datetime: %YMD%
@REM 設定 [Scripts] 資料夾
if not exist "!SCRIPTS_DIR!" mkdir "!SCRIPTS_DIR!"
@REM 將最後更新時間寫入檔案
echo const _lims2_last_update='%YMD%';> "!UPD_FILE!"
echo Save last-update-time %BGR%'%YMD%'%R% to %BGR%!UPD_FILE!%R%

:end
endlocal
echo.