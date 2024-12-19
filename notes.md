# Developer notes

## Build commands

### Build the installer (main task)
build.bat

Don't directly call "gradle createBaseDiskImage --info --stacktrace" because gradle has a hard time shutting
down Solr after it has added the Nutch core. For this reason, the gradle command has been wrappered in
a BAT script to include a post-build command to shutdown Solr after creating the base disk image.

### Clean the environment (deletes the installer_image and out directories, but does not delete downloads)
clean.bat

### download third-party software
gradle downloadAll


## Run commands

### Start Danu (Cygwin)
cd ${danu_install_dir}
./startup.sh

### Crawl the seed sites (Cygwin)
cd ${danu_install_dir}
./crawl.sh

### access solr
http://localhost:8983/solr/#/

### shutdown Danu (Cygwin)
cd ${danu_install_dir}
./shutdown.sh

