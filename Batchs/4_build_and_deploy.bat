@echo off
:: 可搜尋 TODO，改為本機路徑，注意不要改到變數就好
echo :::: Build and Publish RELEASE_CODE ::::
echo.
:: Load Developer Command Prompt for VS 2022
call "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat"
:: Path to [RELEASE_CODE]
set DIR=%1
:: Build and Publish
MSBuild %DIR%\SDO.sln /p:platform="any cpu" /p:configuration="release" /p:DeployOnBuild=true /p:PublishProfile="FolderProfile"
echo.
:: 最後更新時間 last-update-time
set LST=null
:: 透過 powershell 取得目前時間
echo Get DateTime string...
for /f "delims=" %%a in ('powershell -Command "Get-Date -format 'yyyy-MM-dd HH:mm:ss'"') do @set LST=%%a
echo %LST%
echo.
:: TODO: [RELEASE_CODE] 發佈路徑
set TAG=%2
:: 指定 [Scripts] 資料夾
set DIR="%TAG:"=%\Scripts"
:: 檢查資料夾是否存在，不存在就新增
if not exist %DIR% mkdir %DIR%
:: 將最後更新時間寫入檔案
echo const _lims2_last_update='%LST%';> %DIR%\lastUpdate.js
echo Save last-update-time '%LST%' to [%DIR:"=%]
echo.
pause