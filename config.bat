@echo off

@REM 取得日期字串存入變數 YMD
call .\Functions\get_date.bat 1 "yyyy-MM-dd-HHmmss"
echo %YMD%

call .\Functions\get_date.bat
echo %YMD%

@REM 讀取 config.ini 設定檔
for /f "usebackq tokens=1,* delims==" %%A in ("config.ini") do set "%%A=%%B"

echo DEV: %DEV%
echo REL: %REL%
echo CMD: %CMD%