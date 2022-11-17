@echo off
:: �i�j�M TODO�A�אּ�������|�A�`�N���n����ܼƴN�n
echo :::: Build and Publish RELEASE_CODE ::::
echo.
:: Load Developer Command Prompt for VS 2019
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\Tools\VsDevCmd.bat"
:: Path to [RELEASE_CODE]
set DIR=%1
:: Build and Publish
MSBuild %DIR%\SDO.sln /p:platform="any cpu" /p:configuration="release" /p:DeployOnBuild=true /p:PublishProfile="FolderProfile"
echo.
:: �̫��s�ɶ� last-update-time
set LST=null
:: �z�L powershell ���o�ثe�ɶ�
echo Get DateTime string...
for /f "delims=" %%a in ('powershell -Command "Get-Date -format 'yyyy-MM-dd HH:mm:ss'"') do @set LST=%%a
echo %LST%
echo.
:: TODO: [RELEASE_CODE] �o�G���|
set TAG=%2
:: ���w [Scripts] ��Ƨ�
set DIR="%TAG:"=%\Scripts"
:: �ˬd��Ƨ��O�_�s�b�A���s�b�N�s�W
if not exist %DIR% mkdir %DIR%
:: �N�̫��s�ɶ��g�J�ɮ�
echo const _lims2_last_update='%LST%';> %DIR%\lastUpdate.js
echo Save last-update-time '%LST%' to [%DIR:"=%]
echo.
pause