@echo off
@REM 可搜尋 TODO: 自行修改參數(如果有)
chcp 65001 > nul
setlocal enabledelayedexpansion

@REM 參數說明
@REM %1 {string} 專案發佈(publis)路徑 "C:\dev\_publish\RELEASE"
@REM %2 {string} 安靜模式(執行前不再確認) y/n

@REM 取得外部傳遞參數
set "PUB=%~1"
set "SILENT=%~2"

@REM 設定變數
set "MSG_CFM=Press ENTER to use default, or input others: "

@REM 功能說明
echo :::: %BMG%Remove Last Publish Data%R%
echo :::: %BBK%清除最後一次部署檔案，避免影響本次部署內容%R%
echo.

@REM 設定 TODO: 專案預設發佈路徑
if "!PUB!"=="" (
	echo :: Set publish path
    set "PUB=C:\dev\_publish\RELEASE"
    echo Default: !PUB!
    set /p "PUB=!MSG_CFM!"
    echo.
)

@REM 如果有多個路徑可用逗點串接，例如 "ARR=!PUB!,!XYZ!"
set "ARR=!PUB!"

@REM 確認執行
if "!SILENT!"=="" set "SILENT=n"
if /i "!SILENT!" neq "y" (
    echo Will remove all contents in below paths...
    echo.
    for %%f in (!ARR!) do ( echo [%BGR%%%f%R%] )
    echo.
    choice /c yn /n /m %BYL%"%MSG_STEP%"%R%
    if errorlevel 2 goto end
)

@REM 執行
for %%f in (!ARR!) do (
    echo Remove all contents in [%BGR%%%f%R%]....
    if exist "%%f" (
        @REM 移除資料夾中的所有內容但保留資料夾本身
        for /d %%d in ("%%f\*") do rmdir "%%d" /s /q
        del /q "%%f\*"
    )
)

:end
echo.
set "EXIT_CODE=%errorlevel%"
endlocal & exit /b %EXIT_CODE%