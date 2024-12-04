# Developer notes

## Build commands

### Build the installer (main task)
gradle buildInstaller

### Clean the installer image contents (does not delete downloads)
gradle cleanInstallerImage

### download third-party software
gradle downloadAll

### shutdown solr (windows)
cd ${danu}
installer_image\solr-8.11.4\bin\solr.cmd stop  -p 8983


## Run commands

### Crawl the seed sites
using cygwin...
cd [danu]/installer_image/apache-nutch-1.20
bin/crawl -i -D http.agent.name="DanuCrawler" /path/to/urls/seed.txt /path/to/crawl-data 3



