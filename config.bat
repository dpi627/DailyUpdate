@echo off
chcp 65001 > nul

call .\Utils\colors.bat

@REM 取得日期字串存入變數 YMD
@REM call .\Functions\get_date.bat 1 "yyyy-MM-dd-HHmmss"

call .\Utils\get_date.bat

@REM 讀取 config.ini 設定檔
call .\Utils\load_config.bat ".\Configs\system.ini"
call .\Utils\load_config.bat ".\Configs\personal.ini" y

@REM echo REPO: %REPO%
@REM echo COPY_DIRS: %COPY_DIRS%
@REM echo VS_DEV_CMD: %VS_DEV_CMD%

call .\Utils\open_url.bat