@echo off
:: �i�j�M TODO�A�אּ�������|�A�p���|�]�t�ܼ� %XXX% �`�N���n���
:: �M���W�@�����ץX�B�o�G���|�U�Ҧ��ɮ�
echo :::: Clear Folder (Remove Old Data) ::::
echo.
:: TODO: SVN �ץX�ɮ�(export)���|
set DEV=%1
if "%DEV%"=="" (
	set DEV="C:\dev\_export"
	set /p DEV="Press ENTER to use default, or input [EXPORT] path: "
)
:: TODO: [RELEASE_CODE] �o�G(publis)���|
set REL=%2
if "%REL%"=="" (
	set REL="C:\dev\_publish\RELEASE"
	set /p REL="Press ENTER to use default, or input [RELEASE] path: "
)
:: �W�z���|�զX�A�p�G���s�W�n�P�B�ק�
set ARR=%DEV%,%REL%
:: �O�_���w�R�Ҧ�(���߰ݪ�������)�A�a�J y �h����ܽT�{�T��
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