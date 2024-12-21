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

### Start Danu (Windows)
cd %danu_install_dir%
startup.bat

### Crawl the seed sites (Cygwin)
cd ${danu_install_dir}
./crawl.sh

### access solr

#### Admin access
http://localhost:8983/solr/#/

#### Admin - index overview
http://localhost:8983/solr/#/nutch/core-overview

This URL will show the total pages that have been indexed. The page count is shown by
the "num docs" property.

#### User query
To brinng up a query page, use the HTML file provided at "[DanuAI]/search.html".

#### Admin query
http://localhost:8983/solr/#/nutch/query

This command brings up the Solr admin query page. A good query would be the following, which
searches the "text" (AKA the FTS field) for the term "download":
http://localhost:8983/solr/#/nutch/query?q=text:download

### shutdown Danu (Windows)
cd %danu_install_dir%
./shutdown.bat

