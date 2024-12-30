@echo off

if not exist "out" mkdir out

REM Create the volume (if it doesn't exist)
docker volume create --name danu-ai-build

REM Run docker-compose up 
docker-compose up -d

REM  (Optional: Run some checks or further actions after docker-compose up)
Write-Host "Docker Compose containers started successfully."


rem docker-compose build

REM copy out the resulting installer exe
REM docker run --name build-container danu-ai-build
REM if not exist "out" mkdir out
REM docker cp build-container:/app/out/DanuAI_Installer.exe ./out/DanuAI_Installer.exe
REM docker rm build-container

REM Indicate script completion
echo Build script completed successfully.
