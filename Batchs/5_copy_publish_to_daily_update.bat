@echo off
:: �i�j�M TODO�A�אּ�������|�A�`�N���n����ܼƴN�n
echo :::: Copy Publish Files to Daily Backup Folder ::::
echo.
:: �z�L powershell ���o�Q�Ѥ�� yyyyMMdd
set YMD=%1
:: TODO: �ӷ����| (RELASE_CODE �M�� publish ���|)
set SRC=%2
:: �ؼи��| (LIMS2�C�骩��root���|\yyyymmdd\�{��)
set TAG="\\twfs007\OAD_Lims2Team\%YMD%\CODE"
:: �ƥ��ؿ� (�ؿ��W�٤��i���Ů�B�H�r�I���j)
set FLD=%~3
:: TODO: LOG�ɼg��� (�`�N�p�G���|�]�t�ؿ��A�����w�g�s�b�åB���v��Ū��)
set LOG=%4
:: �T�{����? (�w�]y)
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
:: �N��s��Ʃ��C���s�ؿ� (�`�Τ��Ӹ�Ƨ�)
for %%f in (%FLD%) do (
	robocopy %SRC%\%%f %TAG%\%%f /e /xo /r:1 /w:0 /tee /log+:%LOG% /ndl /nfl
)
pause
) else (
pause
)