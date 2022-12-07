@echo off
:: �i�j�M TODO�A�אּ�������|�A�`�N���n����ܼƴN�n
echo :::: Remote Server Backup ::::
echo.
:: ��ܴ��վ� 001 �Ϊ� 002�A��J 1 �� 2
set SRV=TWTPEOAD00%1
if "%SRV%"=="" (
	echo The first argument [Server No] can't be empty.
	echo Press 1 for TWTPEOAD001, 2 for TWTPEOAD002
	echo Please restart the process.
	pause
	exit
)
:: �z�L powershell ���o�Q�Ѥ�� yyyyMMdd
set YMD=%2
:: �p�G�ťաA�z�L powershell ���o�Q�Ѥ�� yyyyMMdd
if "%YMD%"=="" (
	echo Get DateTime string...
	for /f "delims=" %%a in ('powershell -Command [DateTime]::Today.AddDays(-1^).ToString(\"yyyyMMdd\"^)') do @Set YMD=%%a
	echo %YMD%
	echo.
)
:: �n�ƥ����M�׸�Ƨ��W�١A�Ҧp SGS
set APP=SGS
:: �ӷ����|
set SRC="\\%SRV%\SGS_WEB\%APP%"
:: �ؼи��| (�ƥ�����̡A�ؿ����s�b�S���Y)
set TAG="\\%SRV%\SGS_WEB\_backup\%YMD%\%APP%"
if %1==2 (
	set TAG="\\%SRV%\_backup\%YMD%\%APP%"
)
:: �ư��ؿ�
set EXD="%SRC:"=%\Log" "%SRC:"=%\CodeTemplates"
echo %EXD%
:: ���o��Ѥ�� yyyymmdd�A���� LOG_FILE �ϥ�
echo Get DateTime string...
for /f "delims=" %%a in ('powershell -Command [DateTime]::Today.ToString(\"yyyyMMdd\"^)') do @Set LOG=%%a
:: LOG �ɸ��|
set LOG_FILE=".\Logs\robo_%LOG%.log"
echo Log to %LOG_FILE%

:: �T�{����?
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
	:: �N�D���W���M�׸�Ƨ��ƥ��컷�ݫ��w���|�A�ٲ����`��Ƨ��ɮסBlog
	robocopy %SRC% %TAG% /e /xo /r:1 /w:0 /tee /log+:%LOG_FILE% /nfl /xd %EXD%
	pause
)