cd ./cluster
::start flash.bat
::start logger.bat
::@ping 127.0.0.1 -n 5 -w 3000 > nul
::start gateway.bat
::start world.bat
::@ping 127.0.0.1 -n 5 -w 2000 > nul
start server.bat
echo 启动集群完毕
