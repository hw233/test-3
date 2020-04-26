#!/bin/sh
# Written by Skyman Wu
# modify by huangjf ---- 2012.4.6

echo "警告：执行此命令将会清空数据库！！"
echo "如果是外网，请千万不要这么做！！你确定要继续么？（y：继续；n：返回）"
read Y_OR_N

if [ "$Y_OR_N" = "y" ] || [ "$Y_OR_N" = "Y" ]; then
        echo "再次警告：执行此命令将会清空数据库！！"
        echo "如果是外网，请千万不要这么做！！你确定要继续么？（y；继续；n：返回）"
        
        read Y_OR_N2
        if [ "$Y_OR_N2" = "y" ] || [ "$Y_OR_N2" = "Y" ]; then
                # 重导游戏数据库
                sh db/import_game_db.sh 
                
		# 重导后台数据库（已作废！ -- huangjf）
		#sh db/import_bg_db.sh

        # 重导激活码表
        #sh db/import_active_code.sh
        fi
fi
