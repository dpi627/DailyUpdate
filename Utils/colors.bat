@echo off
chcp 65001 > nul

@REM 設定 ESC 字符
set "E="

@REM 設定顏色變數
set "BK=%E%[30m"
set "RD=%E%[31m"
set "GR=%E%[32m"
set "YL=%E%[33m"
set "BL=%E%[34m"
set "MG=%E%[35m"
set "CY=%E%[36m"
set "WH=%E%[37m"
set "BBK=%E%[90m"
set "BRD=%E%[91m"
set "BGR=%E%[92m"
set "BYL=%E%[93m"
set "BBL=%E%[94m"
set "BMG=%E%[95m"
set "BCY=%E%[96m"
set "BWH=%E%[97m"
set "R=%E%[0m"

setlocal enabledelayedexpansion
@REM 取得輸入參數，判斷是否顯示範例
set "SHOW_SAMPLE=%~1"
if "!SHOW_SAMPLE!" equ "y" (
    @REM 輸出每種顏色的範例
    echo %BK%BK %RD%RD %GR%GR %YL%YL %BL%BL %MG%MG %CY%CY %WH%WH %BBK%BBK %BRD%BRD %BGR%BGR %BYL%BYL %BBL%BBL %BMG%BMG %BCY%BCY %BWH%BWH%R%
)
endlocal