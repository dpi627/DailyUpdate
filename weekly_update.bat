@echo off
chcp 65001 > nul
@REM 載入顏色設定
call .\Utils\colors.bat
@REM 載入設定檔
call .\Utils\load_config.bat ".\Configs\system.ini"
call .\Utils\load_config.bat ".\Configs\message.ini"
call .\Utils\load_config.bat ".\Configs\personal.ini" y

@REM 外部參數說明
@REM %1 {string} 更新分支名稱，通常使用日期 yyyymmdd, yyyymmddB
@REM %2 {int} 跳到指定步驟執行，預設無，可帶入 1, 2, 3, 4
@REM %3 {string} 安靜模式，預設無，啟用帶入 y

@REM 取得外部傳遞參數
set "BRANCH_NM=%~1"
set "JUMP_TO_STEP=%~2"
set "SILENT=%3"

@REM 更新分支名稱如果沒有帶入，就使用前一天 yyyymmdd
setlocal enabledelayedexpansion
if "%BRANCH_NM%"=="" (
	call .\Utils\get_date.bat 1 %BRANCH_NM_FORMAT%
	set "BRANCH_NM=!YMD!"
)
@REM 設定處理分支名稱
endlocal & set "BRANCH_NM=%BRANCH_NM%"
set "BRANCH_PROC=%BRANCH_PREFIX_WEEKLY%/%BRANCH_NM%"

@REM 設定本次LOG檔完整路徑
call .\Utils\get_date.bat 0
set "LOG_FILE=%LOG_DIR%\%LOG_PREFIX%_%YMD%.%LOG_SUFFIX%"

@REM 最後確認
echo.
echo %BMG%Final Confirm:%R%
echo %BBK%========================================================%R%
echo %BCY%1.%R% Make sure %BRD%SAVE%R% all editing files
echo %BCY%2.%R% %BRD%Commit%R% all changes (or Stash)
echo %BCY%3.%R% %BBK%[Optional]%R% Close VS2022 would a plus
echo %BCY%4.%R% Update Branch: %BGR%%BRANCH_PROC%%R%
echo %BCY%5.%R% Log file path: %BGR%%LOG_FILE%%R%
echo %BBK%========================================================%R%
echo.

@REM 步驟開始之前暫停顯示訊息
echo %BYL%%MSG_STEP%%R%
pause

@REM 如果 JUMP_TO_STEP 有值，跳到指定步驟繼續執行
if "%JUMP_TO_STEP%" neq "" ( goto %JUMP_TO_STEP% )

:1
@REM 移除最後一次部署檔案
call .\Utils\logger.bat "Remove Last Publish Data"
call .\Batchs\1_remove_last_pub_data.bat %PUB% %SILENT%
if %errorlevel% equ 2 goto end

:2
@REM 更新儲存庫指定分支並建立更新分支
call .\Utils\logger.bat "Update Repository and Create Branch [%BRANCH_PROC%]"
call .\Batchs\2_sync_repo_and_switch_br.bat %REPO% %BRANCH_DEF% %BRANCH_PROC% %SILENT%
if %errorlevel% equ 2 goto end

:3
@REM 編譯並部署
call .\Utils\logger.bat "Build and Publish [%SLN_NM%]"
call .\Batchs\3_build_and_publish.bat "%REPO%%CODE_DIR%\%SLN_NM%" "%VS_DEV_CMD%"
if %errorlevel% equ 2 goto end

:4
@REM (Optional)加入時間戳記
call .\Utils\logger.bat "Add Timestamp"
call .\Batchs\4_add_timestamp.bat %PUB%

:end
if %errorlevel% equ 2 (
	call .\Utils\logger.bat "User Interupted" "Warning"
	echo %BRD%User Interupted%R%
) else (
    call .\Utils\logger.bat "Process Completed"
	call .\Utils\copy_to_clip.bat "%BRANCH_NM% %MSG_FINISH_DAILY%"
	echo %BGR%Process Completed%R%
)