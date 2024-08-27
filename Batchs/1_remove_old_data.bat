@REM 可搜尋 TODO: 自行修改參數(如果有)
@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

@REM 參數說明
@REM %1 {string} 專案發佈(publis)路徑 "C:\dev\_publish\RELEASE"
@REM %2 {string} 安靜模式(執行前不再確認) y/n 預設不輸入為 n

@REM 取得外部傳遞參數
set "PUB=%~1"
set "SILENT=%~2"

@REM 函式功能說明輸出
echo :::: Func: Remove Last Publish Data
echo :::: Note: 清除最後一次部署檔案，避免影響本次部署內容
echo.

@REM 設定 TODO: 專案預設發佈路徑
if "!PUB!"=="" (
    set "PUB=C:\dev\_publish\RELEASE"
    echo Default publis path: !PUB!
    set /p "PUB=Press ENTER to use default, or input others: "
)

@REM 如果有多個路徑可用逗點串接
set "ARR=!PUB!"

@REM 確認路徑是否正確
if "!SILENT!"=="" set "SILENT=n"
if /i "!SILENT!" neq "y" (
    echo Will remove all contents in below paths...
    echo.
    for %%f in (!ARR!) do ( echo [%%f] )
    echo.
    choice /c yn /n /m "Press y/n: "
    if errorlevel 2 goto end
)

for %%f in (!ARR!) do (
    echo Remove all contents in [%%f]....
    if exist "%%f" (
        @REM 移除資料夾中的所有內容但保留資料夾本身
        for /d %%d in ("%%f\*") do rmdir "%%d" /s /q
        del /q "%%f\*"
    )
)

:end
endlocal
echo.
pause