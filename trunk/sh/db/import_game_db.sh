#!/bin/sh
#Written by huangjf

CurDir=$(pwd)
MyDir=$(dirname "${0}")
DstDir=$(cd $(dirname "${0}")/../../sql && pwd)
cd ${CurDir}

###mysql -usmserver -p123456 < ${DstDir}/create_game_database.sql

echo "importing db ..."
mysql -usimserver -p123456 < ${DstDir}/db.sql

# 调整auto_increment
mysql -usimserver -p123456 < ${DstDir}/alter_auto_increment.sql

echo  "import db done!"

