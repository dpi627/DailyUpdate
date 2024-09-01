@echo off
chcp 65001 > nul

@REM 載入設定
call .\global_usings.bat

@REM call :GetDate 1 %WEEKLY_DIR_FORMAT%
@REM set "TAG=%WEEKLY_PATH%\%WEEKLY_DIR_CODE%\%YMD%"
@REM echo %YMD%
@REM call .\Batches\5_update_uat.bat %PUB% "%TAG%" "%COPY_DIRS%" %LOG_FILE% %SILENT%

@REM call :ChkProc %VS_EXE% "%MSG_VS_RUNNING%"

@REM call :chkStep "%MSG_STEP%" %SILENT%

@REM echo "After call chkStep"

@REM :end
@REM echo "After end"
@REM goto :eof
@REM exit

@REM choice /c sm /m "請選擇:"
@REM echo %errorlevel%
@REM exit

set "silentMode=n"
call :selectMode
echo %silentMode%
exit

:selectMode
    echo %MSG_MODE_SILENT_DESC%
    echo %MSG_MODE_ASK_DESC%
:askUser
    set "userInput="
    echo.
    set /p "userInput=%BYL%%MSG_MODE_CFN%%R%"
    @REM 直接按下 Enter = 預設值 n
    if "%userInput%"=="" set "userInput=%silentMode%"
    @REM 輸入 y 或 Y 啟動安靜模式
    if /i "%userInput%"=="y" set "silentMode=y"
    @REM 判斷是否為有效輸入
    if /i not "%userInput%"=="y" if /i not "%userInput%"=="n" (
        echo.
        echo %BRD%Error:%R% %MSG_MODE_CHECK%
        goto askUser
    )
    goto :eof


:getDate
rem 在這裡放置 get_date.bat 的內容，或者調用原文件
    call .\Utils\get_date.bat %*
    goto :eof

:chkStep
	call .\Utils\chk_step.bat %*
	echo %errorlevel%
	if errorlevel 2 goto end
	goto :eof

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