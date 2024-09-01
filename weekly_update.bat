@echo off
chcp 65001 > nul
@REM 載入設定
call .\global_usings.bat

@REM 外部參數說明
@REM %1 {string} 更新分支名稱，通常使用日期 yyyymmdd, yyyymmddB
@REM %2 {int} 跳到指定步驟執行，預設無，可帶入 1, 2, 3, 4

@REM 取得外部傳遞參數
set "BRANCH_NM=%~1"
set "JUMP_TO_STEP=%~2"

@REM 更新分支名稱如果為空，預設使用明天 yyyymmdd
setlocal enabledelayedexpansion
if "%BRANCH_NM%"=="" (
	call :getDate 1 %BRANCH_NM_FORMAT%
	set "BRANCH_NM=!YMD!"
)
@REM 設定處理分支，例如 r/20240808
endlocal & set "BRANCH_NM=%BRANCH_NM%"
set "BRANCH_PROC=%BRANCH_PREFIX_WEEKLY%/%BRANCH_NM%"

@REM 設定本次LOG檔完整路徑
call :getDate 0
set "LOG_FILE=%LOG_DIR%\%LOG_PREFIX%_%YMD%.%LOG_SUFFIX%"

@REM 最後確認
echo.
echo :::: %BMG%Final Confirm:%R%
echo %BBK%========================================================%R%
echo %BCY%1.%R% Make sure %BRD%SAVE%R% all editing files
echo %BCY%2.%R% %BRD%Commit%R% all changes (or Stash)
echo %BCY%3.%R% %BBK%[Optional]%R% Close Visual Studio would be better
echo %BCY%4.%R% Update Branch: %BGR%%BRANCH_PROC%%R%
echo %BCY%5.%R% Log file path: %BGR%%LOG_FILE%%R%
echo %BBK%========================================================%R%
echo.

@REM 執行模式選擇
call :selectMode
set "SILENT=%IS_SILIENT%"

@REM 跳到指定步驟繼續執行
if "%JUMP_TO_STEP%" neq "" ( goto %JUMP_TO_STEP% )

:1
@REM 刪除最後一次部署檔案
call :logger "Remove Last Publish Data"
call :removeLastPublishData %PUB% %SILENT%
if %errorlevel% equ 2 goto end

@REM 檢查 Visual Studio 是否正在執行
call :chkProc %VS_EXE% "%MSG_VS_RUNNING%"
call :chkStep

:2
@REM 更新儲存庫指定分支並建立更新分支
call :logger "Update Repository and Create Branch [%BRANCH_PROC%]"
call :syncRepoAndSwitchBranch %REPO% %BRANCH_DEF% %BRANCH_PROC% %SILENT%
if %errorlevel% equ 2 goto end
call :chkStep

:3
@REM 編譯並部署
call :logger "Build and Publish [%SLN_NM%]"
call :buildAndPublish "%REPO%%CODE_DIR%\%SLN_NM%" "%VS_DEV_CMD%"
if %errorlevel% equ 2 goto end
call :chkStep

:4
@REM (Optional)加入時間戳記
call :logger "Add Timestamp"
call :addTimestamp %PUB%
call :chkStep

:5
@REM 複製到週更新資料夾，完成後開啟資料夾進行確認
call :getDate 1 %WEEKLY_DIR_FORMAT%
set "TAG=%WEEKLY_PATH%\%YMD%\%WEEKLY_DIR_CODE%"
call :logger "Copy to Weekly Update Folder"
call :updateUat %PUB% "%TAG%" "%COPY_DIRS%" %LOG_FILE% %SILENT%
explorer "%TAG%"

:end
if %errorlevel% equ 2 (
	call :logger "User Interupted" "Warning"
	echo %BRD%User Interupted%R%
) else (
    call :logger "Process Completed"
	call :copyToClip "%BRANCH_NM% %MSG_FINISH_DAILY%"
	echo %BGR%Process Completed%R%
)

@REM 主程序結束
exit

@REM 函式使用標籤縮短路徑, 必須放在主程序最後

@REM 選擇執行模式
:selectMode
    call .\Utils\chk_mode.bat
    goto :eof

@REM 暫停確認是否繼續執行或中斷
:chkStep
	call .\Utils\chk_step.bat "%MSG_STEP%" %SILENT%
	if errorlevel 2 goto end
	goto :eof

@REM 取得日期字串存入變數 YMD
:getDate
	call .\Utils\get_date.bat %*
	goto :eof

@REM 記錄日誌
:logger
	call .\Utils\logger.bat %*
	goto :eof

@REM 檢查指定程序是否正在執行
:chkProc
	call .\Utils\chk_proc.bat %*
	goto :eof

@REM 開啟指定網址
:openUrl
	call .\Utils\open_url.bat %*
	goto :eof

@REM 複製指定字串到剪貼簿
:copyToClip
	call .\Utils\copy_to_clip.bat %*
	goto :eof

:removeLastPublishData
	call .\Batches\1_remove_last_pub_data.bat %*
	goto :eof

:syncRepoAndSwitchBranch
	call .\Batches\2_sync_repo_and_switch_br.bat %*
	goto :eof

:buildAndPublish
	call .\Batches\3_build_and_publish.bat %*
	goto :eof

:addTimestamp
	call .\Batches\4_add_timestamp.bat %*
	goto :eof

:updateUat
	call .\Batches\5_update_uat.bat %*
	goto :eof