@echo off

:: 可用參數
:: %1 目標主機代碼 1=TWTPEOAD001, 2=TWTPEOAD002
:: %2 {y, default empty} 如帶入 y，部分步驟將不進行確認

:: 選擇測試機 001 或者 002，輸入 1 或 2
set SNO=%1
:: 安靜模式，啟用請帶入參數 y，例如 all_in_one.bat yyyymmdd y
set SILENT_MODE=%2

if "%SNO%"=="" (
	echo The first argument [Server No] can't be empty.
	echo Enter 1 for TWTPEOAD001, 2 for TWTPEOAD002
	echo Please restart the process and try again.
	pause
	exit
)
:: [RELEASE_CODE] 專案目錄
set RELEASE_CODE_DIR="D:\LIMS20\SOURCE\RELEASE_CODE"
:: [RELEASE_CODE] 專案發佈目錄 (預設會在上述目錄之 \bin 內)
set RELEASE_CODE_DEPLOY="C:\dev\_publish\RELEASE"
:: 備份的專案名稱 (資料夾名稱)
set BACKUP_APP=SGS
:: 要更新的資料夾 (通常固定五個)
set BACKUP_FLD="bin,Content,Scripts,Templates,Views"
:: 取得當天日期 yyyymmdd，提供 LOG_FILE 使用
echo Get DateTime string...
for /f "delims=" %%a in ('powershell -Command [DateTime]::Today.ToString(\"yyyyMMdd\"^)') do @Set YMD=%%a
:: LOG 檔路徑
set LOG_FILE=".\Logs\robo_%YMD%.log"
echo Log to %LOG_FILE%
echo.

:: 將 [RELEASE_CODE] 專案發佈目錄內的 [BACKUP_FLD] 複製到指定主機進行更新
call .\Batchs\6_copy_publish_to_server.bat %SNO% %BACKUP_APP% %RELEASE_CODE_DEPLOY% %BACKUP_FLD% %LOG_FILE% %SILENT_MODE%