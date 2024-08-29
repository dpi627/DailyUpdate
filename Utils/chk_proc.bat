@echo off
setlocal enabledelayedexpansion

@REM 定義函數以檢查程序是否正在執行
:CheckProcess
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
        @REM 如果找到顯示提示視窗
        powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('!MSG!')"
    )
    goto :eof

:end
endlocal
exit /b
