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

## WIP

* set project license to AGPL.

* build installer

* set up runtime crawl to write to solr
  setup the runtime crawl script to work with Solr.

## Backlog

* move build-time bat scripts out of install image location. (use "/build_scripts/solr" instead)
  - createNutchCore.bat

* build initial testing framework

* start admin UI framework

* start user UI framework

* change crawl to be BAT based
  Have a bat file with something like:
  "%cygwindir%/bin/bash.exe" --login %DanuDir%/crawl.sh

* Populate the readme.md for the project, including:
  1. describe the purpose and supported use cases
  2. describe the "why" of the project
  3. describe how to build it
  4. describe the architecture

* create "build script" to track third-party software CVEs

## Deep backlog (non-critical cards)

* The gradle code for SOlr start and stop is a clusterfuck.  Clean it up.

* clean up the gradle directory structure. some ideas:
  - "/src/main/install/{nutch, solr, hadoop}/"
  - "/src/main/runtime_scripts/"
  - "/build/install_image/"
  - "/src/docs/"
  - /src/test/"
  
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