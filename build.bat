@echo off

REM build the same way that the pipeline does
docker build -f docker/Dockerfile.build -t danu-ai-build .

REM copy out the resulting installer exe
docker run --name build-container danu-ai-build
if not exist "out" mkdir out
docker cp build-container:/app/out/DanuAI_Installer.exe ./out/DanuAI_Installer.exe
docker rm build-container

REM Indicate script completion
echo Build script completed successfully.
