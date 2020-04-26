#!/bin/sh
# by huangjf


cd /home/nemo/online_copy_game_server/smserver/sh/
sh ./start.sh

sleep 3

ps aux | grep beam
