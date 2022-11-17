@echo off
:: 可搜尋 TODO，改為本機路徑，如路徑包含變數 %XXX% 注意不要改到
:: 清除上一次的匯出、發佈路徑下所有檔案
echo :::: Clear Folder (Remove Old Data) ::::
echo.
:: TODO: SVN 匯出檔案(export)路徑
set DEV=%1
if "%DEV%"=="" (
	set DEV="C:\dev\_export"
	set /p DEV="Press ENTER to use default, or input [EXPORT] path: "
)
:: TODO: [RELEASE_CODE] 發佈(publis)路徑
set REL=%2
if "%REL%"=="" (
	set REL="C:\dev\_publish\RELEASE"
	set /p REL="Press ENTER to use default, or input [RELEASE] path: "
)
:: 上述路徑組合，如果有新增要同步修改
set ARR=%DEV%,%REL%
:: 是否為安靜模式(不詢問直接執行)，帶入 y 則不顯示確認訊息
set CHK=%3
if "%CHK%"=="" (
	set CHK=y
	echo Remove all contents below...
	echo.
	for %%f in (%ARR%) do ( echo [%%f] )
	echo.
	set /p CHK="Press y/n (enter to use y): "
)
if %CHK%==y (
	for %%f in (%ARR%) do (
		echo Remove all contents in [%%f]....
		if exist %%f (
			:: remove all content in Folder and itself
			rmdir %%f /s /q
			:: recreate the Folder
			mkdir %%f
		)
	)
)
echo.
pause