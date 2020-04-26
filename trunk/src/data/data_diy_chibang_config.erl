%%%---------------------------------------
%%% @Module  : data_diy_chibang_config
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 定制翅膀配置表
%%%---------------------------------------


-module(data_diy_chibang_config).
-compile(export_all).

-include("diy.hrl").
-include("debug.hrl").

get(1) ->
	#diy_chibang_config{
		no = 1,
		type = 1,
		chibang_no = [10000,10001,10002],
		chibang_add_attr_num = 3,
		chibang_add_attr = [{hp_lim,250,2},{mp_lim,250,2},{phy_def,60, 2},{mag_def,60,2},{heal_value,60,1},{seal_resis,36,1}],
		cost = {89312,1}
};

get(2) ->
	#diy_chibang_config{
		no = 2,
		type = 2,
		chibang_no = [10000,10001,10002],
		chibang_add_attr_num = 5,
		chibang_add_attr = [{phy_att,75, 1},{mag_att,75,1},{hp_lim,300,2},{mp_lim,300,2},{phy_def,75, 2},{mag_def,75,2},{heal_value,75,1},{act_speed,75,1},{seal_resis,45,1}],
		cost = {89313,1}
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

