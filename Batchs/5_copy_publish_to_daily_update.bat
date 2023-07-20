@echo off
:: 可搜尋 TODO，改為本機路徑，注意不要改到變數就好
echo :::: Copy Publish Files to Daily Backup Folder ::::
echo.
:: 透過 powershell 取得昨天日期 yyyyMMdd
set YMD=%1
:: TODO: 來源路徑 (RELASE_CODE 專案 publish 路徑)
set SRC=%2
:: 目標路徑 (LIMS2每日版更root路徑\yyyymmdd\程式)
set TAG="\\twfs007\OAD_Lims2Team\%YMD%\CODE"
:: 備份目錄 (目錄名稱不可有空格、以逗點分隔)
set FLD=%~3
:: TODO: LOG檔寫到哪 (注意如果路徑包含目錄，必須已經存在並且有權限讀取)
set LOG=%4
:: 確認執行? (預設y)
set CHK=%5
if "%CHK%"=="" (
	set CHK=y
	echo Ready to Copy Files...
	echo.
	echo from %SRC%
	echo   to %TAG%
	echo flds %FLD%
	echo.
	set /p CHK="Press y/n (enter to use y): "
)
if %CHK%==y (
:: Set CodePage, Log in English
chcp 850
:: 將更新資料放到每日更新目錄 (常用五個資料夾)
for %%f in (%FLD%) do (
	robocopy %SRC%\%%f %TAG%\%%f /e /xo /r:1 /w:0 /tee /log+:%LOG% /ndl /nfl
)
pause
) else (
pause
)