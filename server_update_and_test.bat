@echo off
chcp 65001 > nul

@REM 參數說明
@REM %1 {int} 目標主機代碼 1=TWTPEOAD001, 2=TWTPEOAD002
@REM %2 {string} {string} 安靜模式(執行前不再確認) y/n

set SNO=%1
set SILENT=%2

:: [RELEASE_CODE] 專案發佈目錄 (預設會在上述目錄之 \bin 內)
set RELEASE_CODE_DEPLOY="C:\dev\_publish\RELEASE"
:: 備份的專案名稱 (資料夾名稱)
set BACKUP_APP=TST
:: 要更新的資料夾 (通常固定五個)
set BACKUP_FLD="bin Content Scripts Templates Views"
:: 取得當天日期 yyyymmdd，提供 LOG_FILE 使用
echo Get DateTime string...
for /f "delims=" %%a in ('powershell -Command [DateTime]::Today.ToString(\"yyyyMMdd\"^)') do @Set YMD=%%a
:: LOG 檔路徑
set LOG_FILE=".\Logs\robo_%YMD%.log"
echo Log to %LOG_FILE%
echo.

:: 將 [RELEASE_CODE] 專案發佈目錄內的 [BACKUP_FLD] 複製到指定主機進行更新
call .\Batchs\6_copy_publish_to_server.bat %SNO% %BACKUP_APP% %RELEASE_CODE_DEPLOY% %BACKUP_FLD% %LOG_FILE% %SILENT%

echo.