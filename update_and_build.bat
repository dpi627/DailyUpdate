@echo off

:: [1] set variables
:: local [development] path
set DEV="C:\dev\SGS.LIMS2"
:: local [release code] path
set REL="D:\LIMS20\SOURCE\RELEASE_CODE"
:: set Developer Command Prompt for VS 2022 path
set CMD="C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat"
:: finish message
set MSG=本機更新、編譯正常

@REM :: [2] SVN update
@REM :: SVN update all directories
@REM set ARR=%DEV%,%REL%
@REM for %%f in (%ARR%) do (
@REM     svn info %%f
@REM     svn update %%f
@REM echo.
@REM )

@REM :: [3] build solution
@REM :: load Developer Command Prompt for VS 2022
@REM call %CMD%
@REM :: build solution
@REM MSBuild %DEV%\SDO.sln /p:configuration="Release"

:: [4] show message
echo.
echo %MSG%
echo.

:: [5] copy message
:: use pipline send message to clipbord
echo %MSG% | clip
echo message already copied