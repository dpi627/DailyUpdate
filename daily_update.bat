@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

@REM 參數說明
@REM %1 {string} 更新分支名稱 yyyymmdd, yyyymmddB
@REM %2 {int} 跳到指定步驟
@REM %3 {string} 安靜模式，預設無，啟用帶入 y

@REM 取得外部傳遞參數
set "BRANCH_NM=%~1"
set "JUMP_TO_STEP=%~2"
set "SILENT=%3"

@REM 更新分支名稱如果沒有就抓前一天 yyyymmdd
if "%BRANCH_NM%"=="" (
	call .\Utils\get_date.bat
	set "BRANCH_NM=!YMD!"
	
)
echo Branch Name: [%BRANCH_NM%]

@REM 將 BRANCH_NM 設為全域變數
endlocal & set "BRANCH_NM=%BRANCH_NM%"

@REM 載入設定檔
call .\Utils\load_config.bat

@REM 設定LOG檔完整路徑
call .\Utils\get_date.bat 0
set "LOG_FILE=%LOG_DIR%\%LOG_PREFIX%_%YMD%.%LOG_SUFFIX%"
echo Log to [%LOG_FILE%]
echo.

@REM 其他參數設定
set "MSG=press [ENTER] when done, go to next step."

@REM 步驟開始之前暫停顯示訊息
pause

@REM 如果 JUMP_TO_STEP 有值，跳到指定步驟繼續執行
if "%JUMP_TO_STEP%" neq "" ( goto %JUMP_TO_STEP% )

:1
call .\Batchs\1_remove_last_pub_data.bat %PUB% %SILENT%
echo.

exit /b

:2