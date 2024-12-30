@echo off

REM Define variables
set GRADLE_CLEAN_ENV_CMD=cmd /c "gradle cleanEnv --info --stacktrace"

REM Run Gradle command and output to console
echo Running: %GRADLE_CLEAN_ENV_CMD%
%GRADLE_CLEAN_ENV_CMD%
if not "%ERRORLEVEL%"=="0" (
    echo Gradle clean command failed with error code %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

REM Indicate script completion
echo Clean script completed successfully.
