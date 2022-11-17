@echo off
:: 可搜尋 TODO，改為本機路徑，注意不要改到變數就好
echo :::: Copy Export Files to RELEASE_CODE ::::
echo.
:: TODO: 來源路徑 (SVN匯出目標\SOURCE\CODE\)
set SRC=%1
if "%SRC%"=="" (
	set SRC="C:\dev\_export\SOURCE\CODE"
	set /p SRC="Press ENTER to use default, or input [EXPORT] path: "
)
:: TODO: 目標路徑 (RELASE_CODE位置)
set TAG=%2
if "%TAG%"=="" (
	set TAG="D:\LIMS20\SOURCE\RELEASE_CODE"
	set /p TAG="Press ENTER to use default, or input [RELEASE_CODE] path: "
)
:: TODO: LOG檔寫到哪 (注意如果路徑包含目錄，必須已經存在並且有權限讀取)
set LOG=%3

:: 確認執行? (預設y)
:: 是否為安靜模式(不詢問直接執行)，帶入 y 則不顯示確認訊息
set CHK=%4
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
	robocopy %SRC% %TAG% /e /xo /r:1 /w:0 /tee /log+:%LOG% /nfl
)
pause