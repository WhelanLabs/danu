#!/bin/bash

#
# Copyright (C) 2024 whelanlabs.com
#
 
# Define the Solr version as a variable
SOLR_VERSION="8.11.4"

# Change the working directory to the location of the script
cd "$(dirname "$0")"

# Create the logs directory if it does not exist
mkdir -p logs

# Call the Solr command to stop the server on port 8983 and write the output to logs/log.txt
./solr-$SOLR_VERSION/bin/solr.cmd stop -p 8983 > logs/log.txt 2>&1

echo server stopped
