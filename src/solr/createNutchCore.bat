rem @echo off
setlocal
cd /d %~dp0
bin\solr.cmd create -p 8983 -c nutch -d server/solr/configsets/nutch/conf
endlocal
