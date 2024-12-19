@echo off

:: Copyright (C) 2024 whelanlabs.com

:: Define the Solr version as a variable
set SOLR_VERSION=8.11.4

:: Change the working directory to the location of the script
cd /d "%~dp0"

:: Create the logs directory if it does not exist
if not exist logs (
    mkdir logs
)

:: Call the Solr command to stop the server on port 8983 and write the output to logs/log.txt
call solr-%SOLR_VERSION%\bin\solr.cmd stop -p 8983 > logs\Shutdownlog.txt 2>&1

echo server stopped
