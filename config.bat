@echo off
chcp 65001 > nul

@REM 取得日期字串存入變數 YMD
@REM call .\Functions\get_date.bat 1 "yyyy-MM-dd-HHmmss"
@REM echo %YMD%

call .\Functions\get_date.bat

@REM 讀取 config.ini 設定檔
call .\Functions\load_config.bat

echo REPO: %REPO%
echo COPY_DIRS: %COPY_DIRS%
echo VS_DEV_CMD: %VS_DEV_CMD%