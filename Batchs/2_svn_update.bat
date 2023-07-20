@echo off
:: 可搜尋 TODO，改為本機路徑，注意不要改到變數就好
echo :::: SVN Update ::::
echo.
:: TODO: Path to Develop Folder or [CODE]
set DEV=%1
if "%DEV%"=="" (
	set DEV="C:\dev\SGS.LIMS2"
	set /p DEV="Press ENTER to use default, or input [CODE] path: "
)
:: TODO: Path to [RELEASE_CODE]
set REL=%2
if "%REL%"=="" (
	set REL="D:\LIMS20\SOURCE\RELEASE_CODE"
	set /p REL="Press ENTER to use default, or input [RELEASE_CODE] path: "
)
:: 上述路徑組合，如果有新增要同步修改
set ARR=%DEV%,%REL%
:: 是否為安靜模式(不詢問直接執行)，帶入 y 則不顯示確認訊息
set CHK=%3
if "%CHK%"=="" (
	set CHK=y
	echo SVN UPDATE all path below...
	echo.
	for %%f in (%ARR%) do ( echo [%%f] )
	echo.
	set /p CHK="Press y/n (enter to use y): "
)
:: SVN update all folders
if %CHK%==y (
	chcp 950
	for %%f in (%ARR%) do (
		svn info %%f
		svn update %%f
	echo.
	)
)
pause