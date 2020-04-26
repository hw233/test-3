%%%---------------------------------------
%%% @Module  : data_diy_mount_config
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 定制坐骑配置表
%%%---------------------------------------


-module(data_diy_mount_config).
-compile(export_all).

-include("diy.hrl").
-include("debug.hrl").

get(1) ->
	#diy_mount_config{
		no = 1,
		type = 1,
		mount_no = [1101,1102,1103,1104,1105],
		mount_add_attr = [{hp_lim,250 ,0},{mp_lim,250 ,0},{phy_att,65 ,0},{mag_att,65 ,0},{phy_def,85 ,0},{mag_def,85 ,0},{act_speed,13 ,0},{phy_crit,5 ,0},{mag_crit,5 ,0},{phy_ten,8 ,0},{mag_ten,8 ,0},{phy_crit_coef,11 ,0},{mag_crit_coef,11 ,0},{be_phy_dam_shrink,11 ,0},{be_mag_dam_shrink,11 ,0},{seal_hit,11 ,0},{seal_resis,11 ,0}],
		attr_min1 = 900,
		attr_max1 = 900,
		attr_min2 = 900,
		attr_max2 = 900,
		attr_min3 = 900,
		attr_max3 = 900,
		gamemoney_reset_attr_min1 = 400,
		gamemoney_reset_attr_max1 = 900,
		gamemoney_reset_attr_min2 = 400,
		gamemoney_reset_attr_max2 = 900,
		gamemoney_reset_attr_min3 = 400,
		gamemoney_reset_attr_max3 = 900,
		shuiyu_reset_attr_min1 = 700,
		shuiyu_reset_attr_max1 = 1050,
		shuiyu_reset_attr_min2 = 700,
		shuiyu_reset_attr_max2 = 1050,
		shuiyu_reset_attr_min3 = 700,
		shuiyu_reset_attr_max3 = 1050,
		mount_effect_par_num = 2,
		cost = [{89314,1},{89325,100}]
};

get(2) ->
	#diy_mount_config{
		no = 2,
		type = 2,
		mount_no = [1201,1202,1203,1204,1205,1206,1207],
		mount_add_attr = [{hp_lim,300 ,0},{mp_lim,300 ,0},{phy_att,70 ,0},{mag_att,70 ,0},{phy_def,90 ,0},{mag_def,90 ,0},{act_speed,14 ,0},{phy_crit,6 ,0},{mag_crit,6 ,0},{phy_ten,9 ,0},{mag_ten,9 ,0},{phy_crit_coef,12 ,0},{mag_crit_coef,12 ,0},{be_phy_dam_shrink,12 ,0},{be_mag_dam_shrink,12 ,0},{seal_hit,12 ,0},{seal_resis,12 ,0}],
		attr_min1 = 950,
		attr_max1 = 950,
		attr_min2 = 950,
		attr_max2 = 950,
		attr_min3 = 950,
		attr_max3 = 950,
		gamemoney_reset_attr_min1 = 450,
		gamemoney_reset_attr_max1 = 950,
		gamemoney_reset_attr_min2 = 450,
		gamemoney_reset_attr_max2 = 950,
		gamemoney_reset_attr_min3 = 450,
		gamemoney_reset_attr_max3 = 950,
		shuiyu_reset_attr_min1 = 750,
		shuiyu_reset_attr_max1 = 1100,
		shuiyu_reset_attr_min2 = 750,
		shuiyu_reset_attr_max2 = 1100,
		shuiyu_reset_attr_min3 = 750,
		shuiyu_reset_attr_max3 = 1100,
		mount_effect_par_num = 2,
		cost = [{89315,1},{89325,300}]
};

get(3) ->
	#diy_mount_config{
		no = 3,
		type = 3,
		mount_no = [1301,1302,1303,1304,1305,1306,1307,1308,1309],
		mount_add_attr = [{hp_lim,350 ,0},{mp_lim,350 ,0},{phy_att,75 ,0},{mag_att,75 ,0},{phy_def,95 ,0},{mag_def,95 ,0},{act_speed,15 ,0},{phy_crit,7 ,0},{mag_crit,7 ,0},{phy_ten,10 ,0},{mag_ten,10 ,0},{phy_crit_coef,13 ,0},{mag_crit_coef,13 ,0},{be_phy_dam_shrink,13 ,0},{be_mag_dam_shrink,13 ,0},{seal_hit,13 ,0},{seal_resis,13 ,0}],
		attr_min1 = 1000,
		attr_max1 = 1000,
		attr_min2 = 1000,
		attr_max2 = 1000,
		attr_min3 = 1000,
		attr_max3 = 1000,
		gamemoney_reset_attr_min1 = 500,
		gamemoney_reset_attr_max1 = 1000,
		gamemoney_reset_attr_min2 = 500,
		gamemoney_reset_attr_max2 = 1000,
		gamemoney_reset_attr_min3 = 500,
		gamemoney_reset_attr_max3 = 1000,
		shuiyu_reset_attr_min1 = 800,
		shuiyu_reset_attr_max1 = 1150,
		shuiyu_reset_attr_min2 = 800,
		shuiyu_reset_attr_max2 = 1150,
		shuiyu_reset_attr_min3 = 800,
		shuiyu_reset_attr_max3 = 1150,
		mount_effect_par_num = 2,
		cost = [{89316,1},{89325,750}]
};

get(4) ->
	#diy_mount_config{
		no = 4,
		type = 4,
		mount_no = [1401,1402,1403,1404,1405,1406,1407,1408,1409,1410,1411,1412,1413],
		mount_add_attr = [{hp_lim,400 ,0},{mp_lim,400 ,0},{phy_att,80 ,0},{mag_att,80 ,0},{phy_def,100 ,0},{mag_def,100 ,0},{act_speed,16 ,0},{phy_crit,8 ,0},{mag_crit,8 ,0},{phy_ten,11 ,0},{mag_ten,11 ,0},{phy_crit_coef,14 ,0},{mag_crit_coef,14 ,0},{be_phy_dam_shrink,14 ,0},{be_mag_dam_shrink,14 ,0},{seal_hit,14 ,0},{seal_resis,14 ,0}],
		attr_min1 = 1050,
		attr_max1 = 1050,
		attr_min2 = 1050,
		attr_max2 = 1050,
		attr_min3 = 1050,
		attr_max3 = 1050,
		gamemoney_reset_attr_min1 = 550,
		gamemoney_reset_attr_max1 = 1050,
		gamemoney_reset_attr_min2 = 550,
		gamemoney_reset_attr_max2 = 1050,
		gamemoney_reset_attr_min3 = 550,
		gamemoney_reset_attr_max3 = 1050,
		shuiyu_reset_attr_min1 = 850,
		shuiyu_reset_attr_max1 = 1200,
		shuiyu_reset_attr_min2 = 850,
		shuiyu_reset_attr_max2 = 1200,
		shuiyu_reset_attr_min3 = 850,
		shuiyu_reset_attr_max3 = 1200,
		mount_effect_par_num = 2,
		cost = [{89317,1},{89325,1500}]
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

