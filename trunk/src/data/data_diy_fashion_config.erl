%%%---------------------------------------
%%% @Module  : data_diy_fashion_config
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 定制时装配置表
%%%---------------------------------------


-module(data_diy_fashion_config).
-compile(export_all).

-include("diy.hrl").
-include("debug.hrl").

get(1) ->
	#diy_fashion_config{
		no = 1,
		type = 1,
		fashion_no = [7101,7151,7201,7251,7301,7351,7103,7153,7104,7154],
		fashion_add_attr_num = 2,
		fashion_add_attr = [{talent_str,35,0},{talent_con,35,0},{talent_sta,35,0},{talent_spi,35,0},{talent_agi,35,0},{phy_crit,100,0},{phy_ten,100,0},{mag_crit,100,0},{mag_ten,100,0},{phy_crit_coef,100,0},{mag_crit_coef,100,0},{revive_heal_coef,4000,0},{heal_value,400,0},{seal_hit_to_partner,3500,0},{seal_hit_to_mon,3500,0},{phy_dam_to_partner,3500,0},{phy_dam_to_mon,3500,0},{mag_dam_to_partner,3500,0},{mag_dam_to_mon,3500,0},{be_chaos_round_repair,3000,0},{chaos_round_repair,3000,0},{be_froze_round_repair,3000,0},{froze_round_repair,3000,0},{neglect_phy_def,650,0},{neglect_mag_def,650,0},{neglect_seal_resis,600,0},{phy_dam_to_speed_1,2500,0},{phy_dam_to_speed_2,1200,0},{mag_dam_to_speed_1,2500,0},{mag_dam_to_speed_2,1200,0},{seal_hit_to_speed,1500,0}],
		fashion_effect_no = [53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68],
		cost = {89310,1}
};

get(2) ->
	#diy_fashion_config{
		no = 2,
		type = 2,
		fashion_no = [9101,9151,9201,9251,9301,9351,9103,9153,9104,9154,440013,440014,440015,440016],
		fashion_add_attr_num = 3,
		fashion_add_attr = [{talent_str,40,0},{talent_con,40,0},{talent_sta,40,0},{talent_spi,40,0},{talent_agi,40,0},{phy_crit,120,0},{phy_ten,120,0},{mag_crit,120,0},{mag_ten,120,0},{phy_crit_coef,120,0},{mag_crit_coef,120,0},{revive_heal_coef,4500,0},{heal_value,450,0},{seal_hit_to_partner,3800,0},{seal_hit_to_mon,3800,0},{phy_dam_to_partner,3800,0},{phy_dam_to_mon,3800,0},{mag_dam_to_partner,3800,0},{mag_dam_to_mon,3800,0},{be_chaos_round_repair,3500,0},{chaos_round_repair,3500,0},{be_froze_round_repair,3500,0},{froze_round_repair,3500,0},{neglect_phy_def,800,0},{neglect_mag_def,800,0},{neglect_seal_resis,700,0},{phy_dam_to_speed_1,3000,0},{phy_dam_to_speed_2,1400,0},{mag_dam_to_speed_1,3000,0},{mag_dam_to_speed_2,1400,0},{seal_hit_to_speed,1800,0}],
		fashion_effect_no = [101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116],
		cost = {89311,1}
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

