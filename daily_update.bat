@echo off
chcp 65001 > nul
call .\Utils\colors.bat

@REM 參數說明
@REM %1 {string} 更新分支名稱 yyyymmdd, yyyymmddB
@REM %2 {int} 跳到指定步驟
@REM %3 {string} 安靜模式，預設無，啟用帶入 y

@REM 取得外部傳遞參數
set "BRANCH_NM=%~1"
set "JUMP_TO_STEP=%~2"
set "SILENT=%3"

setlocal enabledelayedexpansion

@REM 更新分支名稱如果沒有就抓前一天 yyyymmdd
if "%BRANCH_NM%"=="" (
	call .\Utils\get_date.bat
	set "BRANCH_NM=!YMD!"
	
)
echo Branch Name: %BGR%%BRANCH_NM%%R%
echo.

@REM 將 BRANCH_NM 設為全域變數
endlocal & set "BRANCH_NM=%BRANCH_NM%"

@REM 載入設定檔
call .\Utils\load_config.bat ".\Configs\system.ini"
call .\Utils\load_config.bat ".\Configs\personal.ini" y

@REM 設定LOG檔完整路徑
call .\Utils\get_date.bat 0
set "LOG_FILE=%LOG_DIR%\%LOG_PREFIX%_%YMD%.%LOG_SUFFIX%"
echo Log to %BGR%%LOG_FILE%%R%
echo.

@REM 其他參數設定
set "MSG=press %BCY%ENTER%R% when done, go to next step."

@REM 步驟開始之前暫停顯示訊息
echo %MSG%
pause

@REM 如果 JUMP_TO_STEP 有值，跳到指定步驟繼續執行
if "%JUMP_TO_STEP%" neq "" ( goto %JUMP_TO_STEP% )

:1
call .\Batchs\1_remove_last_pub_data.bat %PUB% %SILENT%
echo.

:2
call .\2_sync_repo_and_switch_br.bat %REPO% %BRANCH_UAT% "%BRANCH_PREFIX_DAILY%/%BRANCH_NM%" %SILENT%

:3
call .\3_build_and_deploy.bat "%REPO%%CODE_DIR%\%SLN_NM%" %VS_DEV_CMD%

:4
call .\4_add_timestamp.bat %PUB%