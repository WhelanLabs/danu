rem @echo off
setlocal
cd /d %~dp0
rem bin\solr.cmd stop -p 8983
java -DSTOP.PORT=7983 -DSTOP.KEY=stopkey -jar server/start.jar --stop
endlocal
