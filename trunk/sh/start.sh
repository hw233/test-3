#!/bin/sh
echo "modify ulimit -n 102400"
ulimit -n 102400
nofiles=$(echo `ulimit -n`)
echo "current ulimit -n: $nofiles"


if [ "$nofiles" -lt 102400 ]; then
	echo "start failed!!!! ulimit -n is less than 102400"
	exit 0
fi

#ERL_MAX_PORTS=32000  # 现在已经改为在erl命令中使用 +Q 参数的方式了，故注释掉
#export ERL_MAX_PORTS

#echo "reset player online flag ..."
#mysql -usmserver -p123456 < ../sql/alter_player_ol.sql
cd cluster
#echo "starting logger server..."
#sh ./logger.sh
#sleep 5
#echo "starting gateway server..."
#sh ./gateway.sh
#echo "starting world server..."
#sh ./world.sh
#sleep 5
echo "starting game server..."
sh ./server.sh
echo "start game server done!"