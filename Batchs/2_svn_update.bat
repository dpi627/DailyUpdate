@echo off
:: �i�j�M TODO�A�אּ�������|�A�`�N���n����ܼƴN�n
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
:: �W�z���|�զX�A�p�G���s�W�n�P�B�ק�
set ARR=%DEV%,%REL%
:: �O�_���w�R�Ҧ�(���߰ݪ�������)�A�a�J y �h����ܽT�{�T��
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