#!/bin/sh
# by huangjf


echo "bakup logs..."
rm -rf /home/nemo/bakup/online_copy_game_server/logs.old.bak/
mv -f /home/nemo/bakup/online_copy_game_server/logs/  /home/nemo/bakup/online_copy_game_server/logs.old.bak/  # just rename dir since logs.old.bak was removed in last step
mv -f /home/nemo/online_copy_game_server/smserver/app_cfg/logs/   /home/nemo/bakup/online_copy_game_server/   # move dir


##echo "rm old smserver..."
##rm -rf /home/nemo/online_copy_game_server/smserver/


echo "copy smserver..."
cp -rf ../../online_copy_game_server/smserver/  /home/nemo/online_copy_game_server/



echo "done!"
~
~
~
~
~
