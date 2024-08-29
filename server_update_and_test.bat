@echo off
chcp 65001 > nul
@REM 載入設定
call .\global_usings.bat

@REM 參數說明
@REM %1 {int} 目標主機代碼 1=TWTPEOAD001, 2=TWTPEOAD002
@REM %2 {string} 安靜模式(執行前不再確認) y/n

set SNO=%1
set SILENT=%2

@REM 檢查傳入參數
if "%SNO%"=="" (
    echo %BRD%Error:%R% Server No not specified
    goto end
)

if "%SNO%"=="1" (
    set "TAG=%UAT01_PATH%"
    set "URL=%UAT01_URL%"
) else (
    set "TAG=%UAT02_PATH%"
    set "URL=%UAT02_URL%"
)

@REM 設定本次LOG檔完整路徑
call .\Utils\get_date.bat 0
set "LOG_FILE=%LOG_DIR%\%LOG_PREFIX%_%YMD%.%LOG_SUFFIX%"

@REM 複製專案發佈目錄內的常用更新目錄，貼到測試機進行更新
call .\Batchs\5_update_uat.bat %PUB% %TAG% "%COPY_DIRS%" %LOG_FILE% %SILENT%

@REM 更新完成後，開啟瀏覽器進行測試
call .\Utils\open_url.bat %URL%

:end