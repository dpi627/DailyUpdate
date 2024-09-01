@echo off
setlocal enabledelayedexpansion

set "IS_SILIENT=n"

@REM 功能說明
echo :::: %BMG%Select Excute Mode%R%
echo :::: %BBK%輸入 y/n 選擇執行模式，預設 [詢問模式] 可直接按 Enter 繼續%R%
echo.
echo %MSG_MODE_SILENT_DESC%
echo %MSG_MODE_ASK_DESC%

:askUser
    set "userInput="
    echo.
    set /p "userInput=!BYL!!MSG_MODE_CFN!!R!"
    @REM 直接按下 Enter = 預設值 n
    if "!userInput!"=="" set "userInput=!IS_SILIENT!"
    @REM 輸入 y 或 Y 啟動安靜模式
    if /i "!userInput!"=="y" set "IS_SILIENT=y"
    @REM 判斷是否為有效輸入
    if /i not "!userInput!"=="y" if /i not "!userInput!"=="n" (
        echo.
        echo !BRD!Error:!R! !MSG_MODE_CHECK!
        goto askUser
    )
    echo.
    if /i "!userInput!"=="y" (
        echo %BGR%%MSG_MODE_SILENT%%R%
    ) else (
        echo %BGR%%MSG_MODE_ASK%%R%
    )
    echo.

endlocal & (
    set "IS_SILIENT=%IS_SILIENT%"
    exit /b
)