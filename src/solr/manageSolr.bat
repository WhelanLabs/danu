rem @echo off
setlocal
cd /d %~dp0
bin\solr.cmd create -p 8983 -c nutch -d server/solr/configsets/nutch/conf

rem timeout /t 5
bin\solr.cmd stop -p 8983
endlocal
