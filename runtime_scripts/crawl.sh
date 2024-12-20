#!/bin/bash
# Script Name: crawl.sh
# Description: A POC script to perform a crawl.

# Change the current directory to the nutch directory
cd "$(dirname "$0")"
cd ./apache-nutch-1.20/

LINUX_HADOOP_HOME="${PWD}/../hadoop-3.3.6/"
WINDOWS_HADOOP_HOME=$(cygpath -w ${LINUX_HADOOP_HOME})

export HADOOP_HOME=${WINDOWS_HADOOP_HOME}
# export HADOOP_BIN_PATH="${HADOOP_HOME}/bin"
export PATH=${PATH}:${HADOOP_HOME}/bin

Echo "HADOOP_HOME is ${HADOOP_HOME}"

# crawl_generate
# bin/nutch inject crawl/crawldb urls

# Variables
SEED_DIR="urls"         # Directory containing the seed URLs
CRAWL_DIR="crawl_data"  # Directory where crawl data will be stored
DEPTH=3                 # Maximum crawl depth
TOP_N=1000              # Maximum number of pages to fetch per round

# Ensure the seed directory exists
if [ ! -d "$SEED_DIR" ]; then
  echo "Seed directory '$SEED_DIR' does not exist. Create it and add seed URLs in seed.txt."
  exit 1
fi

# Run the Nutch crawl command
# bin/crawl $SEED_DIR $CRAWL_DIR $DEPTH -topN $TOP_N

bin/crawl -i -s urls crawl 2
