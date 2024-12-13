@echo off

REM Define variables
rem set GRADLE_CMD=gradle createBaseDiskImage --info --stacktrace
set GRADLE_CMD=cmd /c "gradle createBaseDiskImage --info --stacktrace"
set SOLR_CMD=installer_image\solr-8.11.4\bin\solr.cmd stop -p 8983

REM Run Gradle command and output to console
echo Running: %GRADLE_CMD%
%GRADLE_CMD%
if not "%ERRORLEVEL%"=="0" (
    echo Gradle command failed with error code %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

REM Run Solr stop command and output to console
echo Running: %SOLR_CMD%
%SOLR_CMD%
if not "%ERRORLEVEL%"=="0" (
    echo Solr command failed with error code %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

REM Indicate script completion
echo Script execution completed.