@echo off
setlocal enabledelayedexpansion

@REM 定義函數以檢查程序是否正在執行
set "EXE=%~1"
set "MSG=%~2"

@REM 檢查傳入參數，例如 "devenv.exe"
if "!EXE!"=="" (
    echo %BRD%Error:%R% process name not specified
    goto :end
)

@REM 檢查程序是否正在執行
tasklist /FI "IMAGENAME eq !EXE!" | find /I "!EXE!" >nul
if !ERRORLEVEL! equ 0 (
    echo %BYL%Warning:%R% [%BCY%!EXE!%R%] is running
    @REM 顯示提示視窗
    powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('!MSG!')" > nul
) else (
    echo %BGR%Info:%R% [%BCY%!EXE!%R%] is not running
)

:end
endlocal
echo.
exit /b