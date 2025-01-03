@echo off
:: Try to get the Cygwin path from HKCU (Current User)
for /f "tokens=2*" %%A in ('REG QUERY "HKCU\SOFTWARE\Cygwin\setup" /v rootdir 2^>nul') do set CYGWIN_PATH=%%B

:: If not found in HKCU, fallback to HKLM (Local Machine)
if not defined CYGWIN_PATH (
    for /f "tokens=2*" %%A in ('REG QUERY "HKLM\SOFTWARE\Cygwin\setup" /v rootdir 2^>nul') do set CYGWIN_PATH=%%B
)

:: Check if the Cygwin path was found
if not defined CYGWIN_PATH (
    echo Cygwin is not installed or not found in the registry.
    exit /b 1
)

:: Add the Cygwin bin directory to the PATH
set PATH=%CYGWIN_PATH%\bin;%PATH%

:: Convert the current script directory to Linux path format
for /f "delims=" %%P in ('cygpath -u "%~dp0crawl.sh"') do set LINUX_SCRIPT_PATH=%%P

:: Call the BASH script using the converted path
bash -l -c "%LINUX_SCRIPT_PATH%"
