@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

@REM 參數說明
@REM %1 {string} 更新來源路徑 "C:\dev\_publish\RELEASE"
@REM %2 {string} 覆蓋目標路徑 "\TWTPEOAD002\SGS_WEB\TST"
@REM %3 {string} 需更新的資料夾(通常五個) "bin Content Scripts Templates Views"
@REM %4 {string} LOG檔路徑 ".\Logs\robo_%YMD%.log"
@REM %5 {string} 安靜模式(執行前不再確認) y/n

@REM 取得外部傳遞參數
set "SRC=%~1"
set "TAG=%~2"
set "FLD=%~3"
set "LOG=%~4"
set "SILENT=%~5"

@REM 功能說明
echo :::: %BMG%Update UAT Server%R%
echo :::: %BBK%複製發佈檔案到測試機進行更新%R%
echo.

@REM 確認執行
if /i "!SILENT!" neq "y" (
	echo Ready to Copy Files...
	echo.
	echo   from %BL%!SRC!%R%
	echo     to %BL%!TAG!%R%
	echo folder %BL%!FLD!%R%
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
		echo %BRD%Error:%R% occurred while copying %BGR%%%f%R%. Check the log file for details.
	) else (
		echo %BGR%%%f%R% copied successfully.
	)
)

:end
set "EXIT_CODE=%errorlevel%"
endlocal & exit /b %EXIT_CODE%
echo.