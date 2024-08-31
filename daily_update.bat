@echo off
chcp 65001 > nul
@REM 載入設定
call .\global_usings.bat

@REM 外部參數說明
@REM %1 {string} 更新分支名稱，通常使用日期 yyyymmdd, yyyymmddB
@REM %2 {int} 跳到指定步驟執行，預設無，可帶入 1, 2, 3, 4
@REM %3 {string} 安靜模式，預設無(n)，啟用帶入 y

@REM 取得外部傳遞參數
set "BRANCH_NM=%~1"
set "JUMP_TO_STEP=%~2"
set "SILENT=%~3"

if "%SILENT%"=="" set "SILENT=n"

@REM 更新分支名稱如果沒有帶入，就使用前一天 yyyymmdd
setlocal enabledelayedexpansion
if "%BRANCH_NM%"=="" (
	call :getDate -1 %BRANCH_NM_FORMAT%
	set "BRANCH_NM=!YMD!"
)

@REM 設定處理分支，例如 u/20220808
endlocal & set "BRANCH_NM=%BRANCH_NM%"
set "BRANCH_PROC=%BRANCH_PREFIX_DAILY%/%BRANCH_NM%"

@REM 設定本次LOG檔完整路徑
call :getDate 0
set "LOG_FILE=%LOG_DIR%\%LOG_PREFIX%_%YMD%.%LOG_SUFFIX%"

@REM 執行前最後確認
echo.
echo %BMG%Final Confirm:%R%
echo %BBK%========================================================%R%
echo %BCY%1.%R% Make sure %BRD%SAVE%R% all editing files
echo %BCY%2.%R% %BRD%Commit%R% all changes (or Stash)
echo %BCY%3.%R% %BBK%[Optional]%R% Close Visual Studio would be better
echo %BCY%4.%R% Update Branch: %BGR%%BRANCH_PROC%%R%
echo %BCY%5.%R% Log file path: %BGR%%LOG_FILE%%R%
echo %BBK%========================================================%R%
echo.

@REM 暫停確認繼續執行或中斷
call :chkStep

@REM 如果 JUMP_TO_STEP 有值，跳到指定步驟繼續執行
if "%JUMP_TO_STEP%" neq "" ( goto %JUMP_TO_STEP% )

:1
@REM 刪除最後一次部署檔案
call :logger "Remove Last Publish Data"
call .\Batches\1_remove_last_pub_data.bat %PUB% %SILENT%
if errorlevel 2 goto end

@REM 檢查 Visual Studio 是否正在執行
call .\Utils\chk_proc.bat %VS_EXE% "%MSG_VS_RUNNING%"
@REM 暫停確認繼續執行或中斷
call :chkStep

:2
@REM 更新儲存庫指定分支並建立更新分支
call :logger "Update Repository and Create Branch [%BRANCH_PROC%]"
call .\Batches\2_sync_repo_and_switch_br.bat %REPO% %BRANCH_UAT% %BRANCH_PROC% %SILENT%
if errorlevel 2 goto end

@REM 暫停確認繼續執行或中斷
call :chkStep

:3
@REM 編譯並部署
call :logger "Build and Publish [%SLN_NM%]"
call .\Batches\3_build_and_publish.bat "%REPO%%CODE_DIR%\%SLN_NM%" "%VS_DEV_CMD%"
if errorlevel 2 goto end

@REM 暫停確認繼續執行或中斷
call :chkStep

:4
@REM (Optional)加入時間戳記
call :logger "Add Timestamp"
call .\Batches\4_add_timestamp.bat %PUB%

@REM 暫停確認繼續執行或中斷
call :chkStep

:5
@REM 更新測試機 1
call :logger "Update UAT Server [%UAT01_PATH%]"
call .\Batches\5_update_uat.bat %PUB% %UAT01_PATH% "%COPY_DIRS%" %LOG_FILE% %SILENT%

@REM 暫停確認繼續執行或中斷
call :chkStep

:6
@REM 更新測試機 2
call :logger "Update UAT Server [%UAT02_PATH%]"
call .\Batches\5_update_uat.bat %PUB% %UAT02_PATH% "%COPY_DIRS%" %LOG_FILE% %SILENT%

@REM 暫停確認繼續執行或中斷
call :chkStep

:7
@REM 開啟瀏覽器測試 1
call :logger "Open UAT for test [%UAT01_URL%]"
call :openUrl %UAT01_URL%

@REM 暫停確認繼續執行或中斷
call :chkStep

:8
@REM 開啟瀏覽器測試 2
call :logger "Open UAT for test [%UAT02_URL%]"
call :openUrl %UAT02_URL%

:end
if errorlevel 2 (
	call :logger "User Interupted" "Warning"
	echo %BRD%User Interupted%R%
) else (
    call :logger "Process Completed"
	call :copyToClip "%BRANCH_NM% %MSG_FINISH_DAILY%"
	echo %BGR%Process Completed%R%
)

@REM 主程序結束
exit

@REM 函式使用標籤摸擬，統一放在主程序最後，方便呼叫與管理

:chkStep
	call .\Utils\chk_step.bat "%MSG_STEP%" %SILENT%
	if errorlevel 2 goto end
	goto :eof

:getDate
	call .\Utils\get_date.bat %*
	goto :eof

:logger
	call .\Utils\logger.bat %*
	goto :eof

:chkProc
	call .\Utils\chk_proc.bat %*
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

:openUrl
	call .\Utils\open_url.bat %*
	goto :eof

:copyToClip
	call .\Utils\copy_to_clip.bat %*
	goto :eof