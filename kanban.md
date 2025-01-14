# Kanban Board for Danu

Danu is an AI Augmented Search Engine project.

This file contains the cards for the project. As a card moves
from Backlog to WIP to Done, it is physically moved in the file below.
Within Done, there are subsections that define the various releases.
Releases are listed in ascending cronological order.

## Done

### POC #1 release (0.1)

* initial structure and loading of third-party components

* have the decompression of downloads only down if not already done.

* build bash script to mimic eventual crawl script

* create nutch core in solr -
  use the build script to configure solr to include a nutch core
  as described in the nutch tutorial.
  
* create initial runtime startup script

* create initial runtime shutdown script

* set project license to AGPL.

* build installer

* set up runtime crawl to write to solr
  setup the runtime crawl script to work with Solr.
  
* build simple search page HTML

* Populate the readme.md for the project, including:
  1. describe the purpose and supported use cases
  2. describe the "why" of the project
  3. describe how to build it
  
* Investagate using MS Hyper-V for building the installer.
  - https://www.youtube.com/watch?v=3I64TeJ4iNI
  
## WIP

* create a hyper-v based build process
  - create vm_based_build.bat
  - update README.md and notes.md

* create a hyper-v based install process for testing



## Backlog

* Launch pre-release Danu
  - get domain
  - switch project to new domain
  - create github tag
  - publish binary
  - Announce to Nutch users mailing list.

* clean up the gradle directory structure. some ideas:
  - "/src/main/install/{nutch, solr, hadoop}/"
  - "/src/main/runtime_scripts/"
  - "/build/install_image/"
  - "/src/docs/"
  - /src/test/"
  
* move build-time bat scripts out of install image location. (use "/build_scripts/solr" instead)
  - createNutchCore.bat

* start admin web UI framework

* start user web UI framework
  - Make it similar to WLSEM in that it shows highlighted text in the results.
  - Have it use the same process as the admin UI, but use a different port.

* change crawl to be BAT based
  Have a bat file with something like:
  "%cygwindir%/bin/bash.exe" --login %DanuDir%/crawl.sh


  
* create "build script" to track third-party software CVEs

## Deep backlog (non-critical cards)

* The gradle code for Solr start and stop is a clusterfuck.  Clean it up.

* bundle Java with the installer? Can NSIS both include and be dependent on Java?

* Have the installer install Cygwin if not already on the machine. Or, possible buncle a private version.
  
* Have the decompression to the install image result in a version agnostic disk image -
  for example, replace "[danu]\installer_image\hadoop-3.4.1\" with
  "danu\installer_image\hadoop\".
  
* replace the finalizedBy garbage in the build file - 
  In Gradle, replacing `finalizedBy` with "proper ordering" typically means 
  restructuring the build script to define task dependencies and execution 
  order more appropriately using mechanisms like `dependsOn`, `mustRunAfter`, 
  or `shouldRunAfter`. This approach ensures that tasks are executed in a 
  clear, logical sequence while adhering to Gradle's best practices for 
  dependency resolution.