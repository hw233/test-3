#!/bin/sh
#Written by Skyman Wu

echo "警告：执行此命令将会清除所有的SASL的log文件！！你确定要这么做吗？"
read Y_OR_N
if [ "$Y_OR_N" == "y" ] || [ "$Y_OR_N" == "Y" ]; then
	echo "开始清理SASL的log文件..."
	rm -f ../../app_cfg/logs/index
	rm -f ../../app_cfg/logs/1
	rm -f ../../app_cfg/logs/2
	rm -f ../../app_cfg/logs/3
	rm -f ../../app_cfg/logs/4
	rm -f ../../app_cfg/logs/5
	rm -f ../../app_cfg/logs/6
	rm -f ../../app_cfg/logs/7
	rm -f ../../app_cfg/logs/8
	rm -f ../../app_cfg/logs/9
	rm -f ../../app_cfg/logs/10
	echo  "清理SASL的log文件完毕"
fi
