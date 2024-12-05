# Kanban Board for Danu

Danu is an AI Augmented Search Engine project.

This file contains the cards for the project. As a card moves
from Backlog to WIP to Done, it is physically moved in the file below.
Within Done, there are subsections that define the various releases.
Releases are listed in ascending cronological order.

## Done

### Initial release (1.0)

* initial structure and loading of third-party components

* have the decompression of downloads only down if not already done.

## WIP

* create nutch core in solr -
  use the build script to configure solr to include a nutch core
  as described in the nutch tutorial.


## Backlog

* build bash script to mimic eventual install script

* build bash script to mimic eventual crawl script






## Deep backlog (non-critical cards)

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