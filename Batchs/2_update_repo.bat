@echo off
@REM 可搜尋 TODO:，改為本機路徑，注意不要改到變數順序
chcp 65001 > nul
setlocal enabledelayedexpansion

@REM 參數說明
@REM %1 {string} 儲存庫(Repository)路徑 "C:\dev\LIMS20\"
@REM %2 {string} 基底分支(branch)名稱 "uat" 或 "main"
@REM %3 {string} 處理分支(branch)名稱 "u/yyyymmdd" 或 "r/yyyymmdd"
@REM %4 {string} 安靜模式(執行前不再確認) y/n

@REM 取得外部傳遞參數
set "REPO=%~1"
set "BR_BASE=%~2"
set "BR_PROC=%~3"
set "SILENT=%~4"

@REM 設定變數
set "MSG_CFM=Press ENTER to use default, or input others: "

@REM 函式功能說明輸出
echo :::: Update Repository
echo :::: 更新儲存庫，切換基底分支，建立處理分支
echo.

@REM 設定 TODO: 儲存庫路徑
if "!REPO!"=="" (
	echo :: Set local repo path
	set REPO="C:\dev\LIMS20\"
	echo Default: !REPO!
	set /p "REPO=!MSG_CFM!"
)
echo.

@REM 設定 TODO: 基底分支
if "!BR_BASE!"=="" (
	echo :: Set base branch
	set "BR_BASE=uat"
	echo Default: !BR_BASE!
	set /p "BR_BASE=!MSG_CFM!"
)
echo.

@REM 設定 TODO: 處理分支名稱
if "!BR_PROC!"=="" (
	echo :: Set process branch
	set "BR_PROC=u/yyyymmdd"
	echo Default: !BR_PROC!
	set /p "BR_PROC=!MSG_CFM!"
)
echo.

@REM 確認執行
if "!SILENT!"=="" set "SILENT=n"
if /i "!SILENT!" neq "y" (
    echo Will pull branch [!BR_BASE!] in !REPO! and create branch [!BR_PROC!]...
    choice /c yn /n /m "Press y/n: "
    if errorlevel 2 goto end
)

@REM 執行
@REM 進入儲存庫目錄
cd !REPO!
echo Into [%cd%]
echo.
@REM 切換至基底分支
git switch !BR_BASE!
echo "Current branch:"
git branch --show-current
echo.
@REM 拉取最新版本
git pull origin !BR_BASE!
echo.
@REM 拉取兩次，因為第一次可能驗證失敗
git pull origin !BR_BASE!
echo.
@REM 建立處理分支並切換
git checkout -b !BR_PROC!
echo "Current branch:"
git branch --show-current

:end
endlocal
echo.
pause