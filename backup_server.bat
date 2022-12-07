@echo off
:: 可搜尋 TODO，改為本機路徑，注意不要改到變數就好
echo :::: Remote Server Backup ::::
echo.
:: 選擇測試機 001 或者 002，輸入 1 或 2
set SRV=TWTPEOAD00%1
if "%SRV%"=="" (
	echo The first argument [Server No] can't be empty.
	echo Press 1 for TWTPEOAD001, 2 for TWTPEOAD002
	echo Please restart the process.
	pause
	exit
)
:: 透過 powershell 取得昨天日期 yyyyMMdd
set YMD=%2
:: 如果空白，透過 powershell 取得昨天日期 yyyyMMdd
if "%YMD%"=="" (
	echo Get DateTime string...
	for /f "delims=" %%a in ('powershell -Command [DateTime]::Today.AddDays(-1^).ToString(\"yyyyMMdd\"^)') do @Set YMD=%%a
	echo %YMD%
	echo.
)
:: 要備份的專案資料夾名稱，例如 SGS
set APP=SGS
:: 來源路徑
set SRC="\\%SRV%\SGS_WEB\%APP%"
:: 目標路徑 (備份到哪裡，目錄不存在沒關係)
set TAG="\\%SRV%\SGS_WEB\_backup\%YMD%\%APP%"
if %1==2 (
	set TAG="\\%SRV%\_backup\%YMD%\%APP%"
)
:: 排除目錄
set EXD="%SRC:"=%\Log" "%SRC:"=%\CodeTemplates"
echo %EXD%
:: 取得當天日期 yyyymmdd，提供 LOG_FILE 使用
echo Get DateTime string...
for /f "delims=" %%a in ('powershell -Command [DateTime]::Today.ToString(\"yyyyMMdd\"^)') do @Set LOG=%%a
:: LOG 檔路徑
set LOG_FILE=".\Logs\robo_%LOG%.log"
echo Log to %LOG_FILE%

:: 確認執行?
set CHK=%3
if "%CHK%"=="" (
	set CHK=y
	echo Ready to Copy Files...
	echo.
	echo from %SRC%
	echo   to %TAG%
	echo.
	set /p CHK="Press y/n (enter to use y): "
)

if %CHK%==y (
	:: Set CodePage, Log in English
	chcp 65001
	:: 將主機上的專案資料夾備份到遠端指定路徑，省略正常資料夾檔案、log
	robocopy %SRC% %TAG% /e /xo /r:1 /w:0 /tee /log+:%LOG_FILE% /nfl /xd %EXD%
	pause
)