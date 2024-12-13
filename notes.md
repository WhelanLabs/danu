# Developer notes

## Build commands

### Build the installer (main task)
build.bat

Don't directly call "gradle createBaseDiskImage --info --stacktrace" because gradle has a hard time shutting
down Solr after it has added the Nutch core. For this reason, the gradle command has been wrappered in
a BAT script to include a post-build command to shutdown Solr after creating the base disk image.

### Clean the installer image contents (does not delete downloads)
gradle cleanInstallerImage --info

### download third-party software
gradle downloadAll


## Run commands

### Crawl the seed sites
using cygwin...
cd [danu]/installer_image/apache-nutch-1.20
bin/crawl -i -D http.agent.name="DanuCrawler" /path/to/urls/seed.txt /path/to/crawl-data 3

### Start solr (windows)
cd ${danu}
installer_image\solr-8.11.4\bin\solr.cmd start

### access solr
http://localhost:8983/solr/#/

### shutdown solr (windows)
cd ${danu}
installer_image\solr-8.11.4\bin\solr.cmd stop  -p 8983


