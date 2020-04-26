#!/bin/sh
#Written by huangjf   创建游戏数据库

CurDir=$(pwd)
MyDir=$(dirname "${0}")
DstDir=$(cd $(dirname "${0}")/../../sql && pwd)
cd ${CurDir}
echo "creating db ..."
mysql -usimserver -p123456 < ${DstDir}/create_game_db.sql
echo  "create db done!"

