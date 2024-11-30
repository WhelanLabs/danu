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





