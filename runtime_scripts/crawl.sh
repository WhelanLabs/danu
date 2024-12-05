#!/bin/bash
# Script Name: crawl.sh
# Description: A POC script to perform a crawl.

# Change the current directory to the nutch directory
cd "$(dirname "$0")"
cd ../installer_image/apache-nutch-1.20/

LINUX_HADOOP_HOME="${PWD}/../hadoop-3.4.1/"
WINDOWS_HADOOP_HOME=$(cygpath -w ${LINUX_HADOOP_HOME})

export HADOOP_HOME=${WINDOWS_HADOOP_HOME}

Echo "HADOOP_HOME is ${HADOOP_HOME}"

bin/nutch inject crawl/crawldb urls

