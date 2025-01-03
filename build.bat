@echo off

REM Define variables
set GRADLE_COMPOSE_IMAGE_CMD=cmd /c "gradle createBaseDiskImage --info --stacktrace"
set GRADLE_BUILD_INSTALLER_CMD=cmd /c "gradle createInstaller --info --stacktrace"
set SOLR_CMD=cmd /c "installer_image\solr-8.11.4\bin\solr.cmd stop -p 8983"
set CLEAN_CMD=cmd /c "clean.bat"

REM Clean previous builds  and output to console
echo Running: %CLEAN_CMD%
%CLEAN_CMD%
if not "%ERRORLEVEL%"=="0" (
    echo Clean command failed with error code %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

REM Run Gradle command and output to console
echo Running: %GRADLE_COMPOSE_IMAGE_CMD%
%GRADLE_COMPOSE_IMAGE_CMD%
if not "%ERRORLEVEL%"=="0" (
    echo Gradle compose image command failed with error code %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

REM Run Solr stop command and output to console
echo Running: %SOLR_CMD%
%SOLR_CMD%
if not "%ERRORLEVEL%"=="0" (
    echo Stop solr command failed with error code %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

REM Create installer_image\solr (createInstaller)
echo Running: %GRADLE_BUILD_INSTALLER_CMD%
%GRADLE_BUILD_INSTALLER_CMD%
if not "%ERRORLEVEL%"=="0" (
    echo Gradle build command failed with error code %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

REM Indicate script completion
echo Build script completed successfully.
