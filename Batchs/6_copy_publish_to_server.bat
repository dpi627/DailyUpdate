@echo off
:: 可搜尋 TODO，改為本機路徑，注意不要改到變數就好
echo :::: Copy Publish Files to Remote Server ::::
echo.
:: 選擇測試機 001 或者 002，輸入 1 或 2
set SRV=TWTPEOAD00%1
:: 要備份的專案資料夾名稱
set APP=%2
:: TODO: 來源路徑 (RELASE_CODE 專案 publish 路徑)
set SRC=%3
:: 目標路徑 (LIMS2每日版更root路徑\yyyymmdd\程式)
set TAG="\\%SRV%\SGS_WEB\%APP%"
:: 備份目錄 (目錄名稱不可有空格、不用雙引號，以逗點分隔)
set FLD=%~4
:: TODO: LOG檔寫到哪 (注意如果路徑包含目錄，必須已經存在並且有權限讀取)
set LOG=%5
:: 確認執行? (預設y)
set CHK=%6
if "%CHK%"=="" (
	set CHK=y
	echo Ready to Copy Files...
	echo.
	echo   from %SRC%
	echo     to %TAG%
	echo folder %FLD%
	echo.
	set /p CHK="Press y/n (enter to use y): "
)
if %CHK%==y (
	:: Set CodePage, Log in English
	@REM chcp 65001
	:: 將更新資料放到每日更新目錄 (常用五個資料夾)
	:: 如要清除資料再備份，可將 /e 改為 /mir (等同 /e /purge)
	for %%f in (%FLD%) do (
		robocopy %SRC%\%%f %TAG%\%%f /e /xo /r:1 /w:0 /tee /log+:%LOG% /nfl
	)
	:: 開啟網站測試
	start http://%SRV%/%APP%/
	pause
) else (
	pause
)