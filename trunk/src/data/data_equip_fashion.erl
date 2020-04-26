%%%---------------------------------------
%%% @Module  : data_equip_fashion
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 定制称号配置表
%%%---------------------------------------


-module(data_equip_fashion).
-compile(export_all).

-include("equip.hrl").
-include("debug.hrl").

get(1) ->
	#equip_fashion{
		no = 1,
		goods_list = [{20043,1},{20044,1},{20045,1}],
		add_attr = [{hp_lim,94090,0},{act_speed,3764,0},{phy_crit,70,0},{mag_crit,70,0}]
};

get(2) ->
	#equip_fashion{
		no = 2,
		goods_list = [{20046,1},{20047,1},{20048,1}],
		add_attr = [{phy_att,13173,0},{mag_att,13173,0},{seal_hit,3293,0},{phy_ten,75,0},{mag_ten,75,0}]
};

get(3) ->
	#equip_fashion{
		no = 3,
		goods_list = [{20049,1},{20050,1},{20051,1}],
		add_attr = [{phy_att,26345,0},{mag_att,26345,0},{seal_hit,6586,0},{phy_crit,140,0},{mag_crit,140,0}]
};

get(4) ->
	#equip_fashion{
		no = 4,
		goods_list = [{20052,1},{20053,1},{20054,1}],
		add_attr = [{phy_att,39518,0},{mag_att,39518,0},{seal_hit,9879,0},{be_phy_dam_reduce_coef,0.0828,0},{be_mag_dam_reduce_coef,0.0828,0}]
};

get(5) ->
	#equip_fashion{
		no = 5,
		goods_list = [{20055,1},{20056,1},{20057,1}],
		add_attr = [{hp_lim,282270,0},{act_speed,11291,0},{do_phy_dam_scaling,0.0828,0},{do_mag_dam_scaling,0.0828,0}]
};

get(6) ->
	#equip_fashion{
		no = 6,
		goods_list = [{20058,1},{20059,1},{20060,1}],
		add_attr = [{phy_att,79036,0},{mag_att,79036,0},{seal_hit,19759,0},{phy_crit,420,0},{mag_crit,420,0}]
};

get(7) ->
	#equip_fashion{
		no = 7,
		goods_list = [{20061,1},{20062,1},{20063,1}],
		add_attr = [{phy_def,112908,0},{mag_def,112908,0},{seal_resis,28227,0},{do_phy_dam_scaling,0.1655,0},{do_mag_dam_scaling,0.1655,0}]
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

