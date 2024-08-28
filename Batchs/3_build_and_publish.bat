@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

@REM 參數說明
@REM %1 {string} 方案檔路徑 "C:\dev\LIMS20\SOURCE\CODE\SDO.sln"

@REM 取得外部傳遞參數
set "SLN=%~1"
set "DEV=%~2"

@REM 檢查傳入參數
if "!SLN!"=="" (
    echo Error: Solution path not specified
    goto end
)
if "!DEV!"=="" (
    echo Error: Developer Command Prompt not specified
    goto end
)

@REM 功能說明
echo :::: Build and Publish
echo :::: 編譯並發佈專案，並寫入最後更新時間
echo.

@REM 執行 Visual Studio Developer Command Prompt
call "!DEV!"

@REM 編譯並發佈專案
MSBuild "!SLN!" /p:platform="any cpu" /p:configuration="release" /p:DeployOnBuild=true /p:PublishProfile="FolderProfile" /verbosity:minimal
if !errorlevel! neq 0 goto end
echo.

:end
endlocal
echo.