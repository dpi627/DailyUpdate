@echo off
@REM 可搜尋 TODO: 自行修改參數(如果有)
chcp 65001 > nul
setlocal enabledelayedexpansion

@REM 參數說明
@REM %1 {string} 專案原始碼(source code)路徑 "C:\dev\LIMS20\SOURCE\CODE"
@REM %2 {string} 專案發佈(publis)路徑 "C:\dev\_publish\RELEASE"

@REM 取得外部傳遞參數
set "SRC=%~1"
set "PUB=%~2"

@REM 檢查傳入參數
if "!SRC!"=="" (
    echo Error: Source code path not specified
    goto end
)
if "!PUB!"=="" (
    echo Error: Publish path not specified
    goto end
)

@REM 設定 TODO: 變數
set "SLN=!SRC!\SDO.sln"
set "SCRIPTS_DIR=!PUB!\Scripts"
set "UPD_FILE=!SCRIPTS_DIR!\lastUpdate.js"

@REM 功能說明
echo :::: Build and Publish
echo :::: 編譯並發佈專案，並寫入最後更新時間
echo.

@REM Load TODO: Developer Command Prompt
call "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat"

@REM 編譯並發佈專案
MSBuild "!SLN!" /p:platform="any cpu" /p:configuration="release" /p:DeployOnBuild=true /p:PublishProfile="FolderProfile" /verbosity:minimal
if !errorlevel! neq 0 goto end
echo.

@REM 透過 powershell 取得目前時間
for /f "delims=" %%a in ('powershell -Command "Get-Date -format 'yyyy-MM-dd HH:mm:ss'"') do @set UPD=%%a
echo Get datetime: !UPD!
@REM 設定 [Scripts] 資料夾
if not exist "!SCRIPTS_DIR!" mkdir "!SCRIPTS_DIR!"
@REM 將最後更新時間寫入檔案
echo const _lims2_last_update='!UPD!';> "!UPD_FILE!"
echo Save last-update-time '!UPD!' to [!SCRIPTS_DIR!]

:end
endlocal
echo.