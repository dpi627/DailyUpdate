@echo off

:: 可用參數
:: %1 {yyyymmdd, yyyymmddB} 備份資料夾名稱 
:: %2 執行指定步驟(跳到特定步驟執行)
:: %3 {y, default empty} 如帶入 y，部分步驟將不進行確認

:: 備份資料夾名稱，通常是昨天或連假前一天日期
set BACKUP_DIR=%1
:: 跳到特定步驟執行
set STEP=%2
:: 安靜模式，啟用請帶入參數 y，例如 all_in_one.bat yyyymmdd y
set SILENT_MODE=%3
:: 如果 BACKUP_DIR 無資料，改取得前一天日期 yyyyMMdd
if "%BACKUP_DIR%"=="" (
	echo The first argument [Backup Folder Name] can't be empty.
	echo It's usually like [yyyymmdd] or [yyyymmddB].
	echo Get DateTime string...
	for /f "delims=" %%a in ('powershell -Command [DateTime]::Today.AddDays(-1^).ToString(\"yyyyMMdd\"^)') do @Set BACKUP_DIR=%%a
)
echo Backup Folder: [%BACKUP_DIR%]

if "%BACKUP_DIR%"=="" (
	echo The first argument [Backup Folder Name] can't be empty.
	echo Please restart the process.
	pause
	exit
)

:: SVN 匯出目錄
set SVN_EXPORT="C:\dev\_export"
:: SVN 匯出目錄內的 [CODE] (真正要覆蓋[RELEASE_CODE]的程式)
set SVN_EXPORT_CODE="%SVN_EXPORT:"=%\SOURCE\CODE"
:: [RELEASE_CODE] 專案目錄
set RELEASE_CODE_DIR="D:\LIMS20\SOURCE\RELEASE_CODE"
:: [RELEASE_CODE] 專案發佈目錄 (預設會在上述目錄之 \bin 內)
set RELEASE_CODE_DEPLOY="C:\dev\_publish\RELEASE"
:: 備份的專案名稱 (資料夾名稱)
set BACKUP_APP=SGS
:: [CODE] 目錄 (本機開發目錄)
set CODE_DIR="C:\dev\SGS.LIMS2"
:: 要更新的資料夾 (通常固定五個)
set BACKUP_FLD="bin,Content,Scripts,Templates,Views"
:: LOG 檔路徑
for /f "delims=" %%a in ('powershell -Command [DateTime]::Today.ToString(\"yyyyMMdd\"^)') do @Set YMD=%%a
set LOG_FILE=".\Logs\robo_%YMD%.log"
echo Log to %LOG_FILE%
:: 步驟之間的提示訊息
set MSG=press [ENTER] when done, go to next step.
pause

if "%STEP%" neq "" ( goto %STEP% )

echo.
:1
call .\Batchs\1_remove_old_data.bat %SVN_EXPORT% %RELEASE_CODE_DEPLOY% %SILENT_MODE%
echo.
:2
call .\Batchs\2_svn_update.bat %CODE_DIR% %RELEASE_CODE_DIR% %SILENT_MODE%
echo.
echo :::: Check Log and Export ::::
echo.
echo Use TortoiseSVN to check SVN Log, export files to [EXPORT]
echo %MSG%
echo.
pause
echo.
:3
call .\Batchs\3_copy_exports_to_release_code.bat %SVN_EXPORT_CODE% %RELEASE_CODE_DIR% %LOG_FILE% %SILENT_MODE%
echo.
echo :::: Check Log again ::::
echo.
echo Check SVN Log again, process Add/Delete/Conflict Actions
echo %MSG%
echo.
pause
echo.
:4
call .\Batchs\4_build_and_deploy.bat %RELEASE_CODE_DIR% %RELEASE_CODE_DEPLOY%
echo.
:5
call .\Batchs\5_copy_publish_to_daily_update.bat %BACKUP_DIR% %RELEASE_CODE_DEPLOY% %BACKUP_FLD% %LOG_FILE% %SILENT_MODE%
echo.
echo :::: Check SQL Scripts ::::
echo.
echo Check [SQL], copy finished syntax, then execute in SSMS
echo %MSG%
echo.
pause
echo.
echo :::: Check Log and Exports ::::
echo.
echo Check SVN Log and [EXPORT], process exception case, such as Web.config, ClientAPI...
echo %MSG%
echo.
pause
echo.
echo :::: Upgrade remote servers then test it ::::
echo.
echo Copy Backup-Folders from [PUBLISH] to remote servers, open browser then test it.
echo execute command .\server_update_and_test.bat (server_no yyyymmdd y)
echo %MSG%
echo.
pause
echo.
echo :::: Commit [RELEASE_CODE] ::::
echo.
echo Commit [RELEASE_CODE], paste export SVN Log Message
echo %MSG%
echo.
pause
echo.
chcp 65001
echo :::: Report in TEAMS ::::
echo.
echo %BACKUP_DIR% 已更新
echo.
pause