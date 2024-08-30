@echo off
setlocal enabledelayedexpansion

@REM 參數說明
@REM %1 {string} 是否安靜模式 y/n
@REM %2 {string} 提問字串

@REM 取得外部傳遞參數
set "SILENT=%~1"
set "MSG_CFN=%~2"

@REM 如果變數未設定，則預設為 n (詢問模式)
if "!SILENT!"=="" set "SILENT=n"
@REM 如果變數未設定，則預設為 Press y/n: (提問字串)
if "!MSG_CFN!"=="" set "MSG_CFN=Press y/n: "

@REM 詢問模式顯示提問字串
if /i "!SILENT!" equ "n" (
    choice /c yn /n /m %BYL%"%MSG_CFN%"%R%
    if errorlevel 2 exit /b 2
)

@REM 安靜模式，或者詢問模式選擇了 y
exit /b 0

endlocal