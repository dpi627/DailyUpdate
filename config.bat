@echo off
chcp 65001 > nul

@REM 取得日期字串存入變數 YMD
@REM call .\Functions\get_date.bat 1 "yyyy-MM-dd-HHmmss"

call .\Utils\get_date.bat
echo %YMD%

@REM 讀取 config.ini 設定檔
@REM call .\Utils\load_config.bat

@REM echo REPO: %REPO%
@REM echo COPY_DIRS: %COPY_DIRS%
@REM echo VS_DEV_CMD: %VS_DEV_CMD%