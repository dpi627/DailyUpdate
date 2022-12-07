@echo off

:: �Ѽƻ���
:: %1 {yyyymmdd, yyyymmddB} �ƥ���Ƨ��W��
:: %2 {�Ʀr} ������w�B�J
:: %3 {y, default empty} y=�w�R�Ҧ��A�w�]�L

set BACKUP_DIR=%1
set STEP=%2
set SILENT_MODE=%3

:: �ƥ���Ƨ��W�٦p�G�S���N��e�@�� yyyymmdd
if "%BACKUP_DIR%"=="" (
	echo The first argument [Backup Folder Name] can't be empty.
	echo It's usually like [yyyymmdd] or [yyyymmddB].
	echo Get DateTime string...
	for /f "delims=" %%a in ('powershell -Command [DateTime]::Today.AddDays(-1^).ToString(\"yyyyMMdd\"^)') do @Set BACKUP_DIR=%%a
)
echo Backup Folder: [%BACKUP_DIR%]

:: SVN�ץX�ؿ�
set SVN_EXPORT="C:\dev\_export"
:: SVN�ץX�ؿ�����[CODE]�ؿ�
set SVN_EXPORT_CODE="%SVN_EXPORT:"=%\SOURCE\CODE"
:: [RELEASE_CODE] �����M��
set RELEASE_CODE_DIR="D:\LIMS20\SOURCE\RELEASE_CODE"
:: [RELEASE_CODE] ���O�M�׵o���ؿ�
set RELEASE_CODE_DEPLOY="C:\dev\_publish\RELEASE"
:: �ƥ��M�צW��(�q�`�����Ƨ��W��)
set BACKUP_APP=SGS
:: [CODE]�����}�o�ؿ�
set CODE_DIR="C:\dev\SGS.LIMS2"
:: �w�]�ƥ���Ƨ�
set BACKUP_FLD="bin,Content,Scripts,Templates,Views"
:: LOG�ɸ��|
for /f "delims=" %%a in ('powershell -Command [DateTime]::Today.ToString(\"yyyyMMdd\"^)') do @Set YMD=%%a
set LOG_FILE=".\Logs\robo_%YMD%.log"
echo Log to %LOG_FILE%
:: �B�J���e�Ȱ���ܰT��
set MSG=press [ENTER] when done, go to next step.
pause

if "%STEP%" neq "" ( goto %STEP% )

echo.
:1
call .\Batchs\1_remove_old_data.bat %SVN_EXPORT% %RELEASE_CODE_DEPLOY% %SILENT_MODE%
echo.
:2
call .\Batchs\2_svn_update.bat %CODE_DIR% %RELEASE_CODE_DIR% %SILENT_MODE%
echo.
echo :::: Select Log and Export ::::
echo.
echo Open TortoiseSVN, select SVN Logs, export to [EXPORT]
echo %MSG%
echo.
pause
echo.
:3
call .\Batchs\3_copy_exports_to_release_code.bat %SVN_EXPORT_CODE% %RELEASE_CODE_DIR% %LOG_FILE% %SILENT_MODE%
echo.
echo :::: Check Log again ::::
echo.
echo Check SVN Log if any specific actions, such as Add/Delete/Conflict
echo %MSG%
echo.
pause
echo.
:4
call .\Batchs\4_build_and_deploy.bat %RELEASE_CODE_DIR% %RELEASE_CODE_DEPLOY%
echo.
:5
call .\Batchs\5_copy_publish_to_daily_update.bat %BACKUP_DIR% %RELEASE_CODE_DEPLOY% %BACKUP_FLD% %LOG_FILE% %SILENT_MODE%
echo.
echo :::: Check SQL Scripts ::::
echo.
echo Check [SQL], copy finished script, then execute in SSMS
echo %MSG%
echo.
pause
echo.
echo :::: Handling special cases ::::
echo.
echo Check SVN Log and [EXPORT] for special cases, such as Web.config, ClientAPI...
echo All they have different update step, plz reference doc.
echo %MSG%
echo.
pause
echo.
echo :::: Upgrade Server and Test ::::
echo.
echo Copy Backup-Folders from [PUBLISH] to remote servers, then test in browser.
echo Execute command: .\server_update_and_test.bat (server_no yyyymmdd y)
echo %MSG%
echo.
pause
echo.
echo :::: Commit [RELEASE_CODE] ::::
echo.
echo Commit [RELEASE_CODE], paste export SVN Log Message
echo %MSG%
echo.
pause
echo.
chcp 950
echo :::: Report in TEAMS ::::
echo.
echo %BACKUP_DIR:~0,4%.%BACKUP_DIR:~4,2%.%BACKUP_DIR:~6,2% �w��s
echo.
pause