#!/bin/sh
# by huangjf


echo "是否要同步代码？（y：是，n：否）"
read Sync_Code_Y_OR_N

if [ "$Sync_Code_Y_OR_N" = "y" ] || [ "$Sync_Code_Y_OR_N" = "Y" ]; then
	sh ./sync_code.sh
fi



echo "是否要同步配置数据？（y：是，n：否）"
read Sync_Cfg_Data_Y_OR_N

if [ "$Sync_Cfg_Data_Y_OR_N" = "y" ] || [ "$Sync_Cfg_Data_Y_OR_N" = "Y" ]; then
	sh ./sync_cfg_data.sh
fi



cd /home/nemo/new_func_game_server/smserver/sh/

sh ./up_mk.sh
