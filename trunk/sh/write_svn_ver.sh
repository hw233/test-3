#!/bin/sh
#Written by Skyman Wu
echo "更新assets目录..."
svn update /data/www/ztj_web/assets
echo "更新assets目录成功"
echo "开始写入版本号..."
TIME=`date   +%Y%m%d%H%M`
SVN_REV_SERVER=`svn info | grep 最后修改的版本 | awk '{print $2}'`
FILE=/data/www/ztj_web/bin-release/config/config.xml 
sed -i 's/<ser_ver.*$/<ser_ver>'$TIME'-'$SVN_REV_SERVER'<\/ser_ver>/' $FILE
echo  "写入版本号成功"
