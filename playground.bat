@echo off
chcp 65001 > nul

@REM 載入設定
call .\global_usings.bat


call .\Utils\get_date.bat 1 %WEEKLY_DIR_FORMAT%
set "TAG=%WEEKLY_PATH%\%WEEKLY_DIR_CODE%\%YMD%"
echo "%TAG%"
@REM call .\Batchs\5_update_uat.bat %PUB% "%TAG%" "%COPY_DIRS%" %LOG_FILE% %SILENT%

call .\Utils\chk_proc.bat %VS_EXE% "%MSG_VS_RUNNING%"

exit /b

@REM call .\Utils\get_date.bat -1 "yyyy.MM.dd" y

call .\Utils\get_date.bat 0
set "LOG_FILE=%LOG_DIR%\%LOG_PREFIX%_%YMD%.%LOG_SUFFIX%"
echo %BCY%5.%R% Log file path: %BGR%%LOG_FILE%%R%
set "MSG_LOG=Test Log File Path"
call .\Utils\log_file.bat "%MSG_LOG%"
call .\Utils\log_seq.bat "%MSG_LOG%"

exit /b 0

echo "%MSG_STEP%"
echo %MSG_FINISH_DAILY_UPDATE%

call .\Utils\copy_to_clip.bat "%MSG_FINISH_DAILY_UPDATE%"

exit /b 0

@REM 取得日期字串存入變數 YMD
@REM call .\Functions\get_date.bat 1 "yyyy-MM-dd-HHmmss"

call .\Utils\log_seq.bat
call .\Utils\log_seq.bat "This is a warning" "Warning"
call .\Utils\log_seq.bat "This is a error" "Error"

exit /b 0

call .\Utils\get_date.bat



@REM echo REPO: %REPO%
@REM echo COPY_DIRS: %COPY_DIRS%
@REM echo VS_DEV_CMD: %VS_DEV_CMD%

call .\Utils\open_url.bat