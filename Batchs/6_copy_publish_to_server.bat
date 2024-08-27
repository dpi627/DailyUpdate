@echo off
@REM 可搜尋 TODO: 自行修改參數(如果有)
chcp 65001 > nul
setlocal enabledelayedexpansion

@REM 參數說明
@REM %1 {int} 測試機 001 或者 002，輸入 1 或 2
@REM %2 {string} 要更新的遠端資料夾名稱 "SGS"
@REM %3 {string} 來源路徑 "C:\dev\_publish\RELEASE"
@REM %4 {string} 需備份資料夾(通常五個) "bin,Content,Scripts,Templates,Views"
@REM %5 {string} LOG檔路徑 ".\Logs\robo_%YMD%.log"
@REM %6 {string} 安靜模式(執行前不再確認) y/n

@REM 取得外部傳遞參數
set "SNO=%~1"
set "APP=%~2"
set "SRC=%~3"
set "FLD=%~4"
set "LOG=%~5"
set "SILENT_MODE=%~6"

echo %SNO% %APP% %SRC% %FLD% %LOG% %SILENT_MODE%
echo !SNO! !APP! !SRC! !FLD! !LOG! !SILENT_MODE!
pause

@REM 設定變數
set "SRV=TWTPEOAD00!SNO!"
set "TAG=\\!SRV!\SGS_WEB\!APP!"
set "URL=http://!SRV!/!APP!"

@REM 功能說明
echo :::: Update UAT Server
echo :::: 複製發佈檔案到測試機，完成後開啟網站測試
echo.

@REM 確認執行
if /i "!SILENT!" neq "y" (
	echo Ready to Copy Files...
	echo.
	echo   from !SRC!
	echo     to !TAG!
	echo folder !FLD!
	echo.
	choice /c yn /n /m "Press y/n: "
    if errorlevel 2 goto end
)

@REM 執行
echo Copying files...
set "FLD=!FLD:,= !"
for %%f in (!FLD!) do (
	robocopy "!SRC!\%%f" "!TAG!\%%f" /e /xo /r:1 /w:0 /tee /log+:"!LOG!" /nfl /mt:8
	if errorlevel 8 (
		echo Error occurred while copying %%f. Check the log file for details.
	) else (
		echo %%f copied successfully.
	)
)

@REM 開啟網站測試
echo Opening website for testing...
start "" "!URL!"

:end
endlocal
echo.