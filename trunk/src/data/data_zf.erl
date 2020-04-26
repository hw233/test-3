%%%---------------------------------------
%%% @Module  : data_zf
%%% @Author  : lf
%%% @Email   : 
%%% @Description:  阵法
%%%---------------------------------------


-module(data_zf).
-include("common.hrl").
-include("zf.hrl").
-compile(export_all).

get_all_no_list()->
	[1,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,5001,5002,5003,5004,5005,5006,5007,5008,5009,5010,6001,6002,6003,6004,6005,6006,6007,6008,6009,6010,7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,8001,8002,8003,8004,8005,8006,8007,8008,8009,8010,9001,9002,9003,9004,9005,9006,9007,9008,9009,9010,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,11001,11002,11003,11004,11005,11006,11007,11008,11009,11010].

get(1) ->
	#zf_cfg{
		no = 1,
		zf_lv = 0,
		cnt_limit = 0,
		type = 0,
		zf_battle_pos = [{2,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [],
		pre_zf = [],
		pos_attr_1 = [],
		pos_attr_2 = [],
		pos_attr_3 = [],
		pos_attr_4 = [],
		pos_attr_5 = []
};

get(2001) ->
	#zf_cfg{
		no = 2001,
		zf_lv = 1,
		cnt_limit = 1,
		type = 1,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10056,1}],
		pre_zf = [],
		pos_attr_1 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02},{act_speed_rate, -0.02}],
		pos_attr_2 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02},{act_speed_rate, -0.02}],
		pos_attr_3 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02},{act_speed_rate, -0.02}],
		pos_attr_4 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02},{act_speed_rate, -0.02}],
		pos_attr_5 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02},{act_speed_rate, -0.02}]
};

get(2002) ->
	#zf_cfg{
		no = 2002,
		zf_lv = 1,
		cnt_limit = 1,
		type = 1,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10056,80}],
		pre_zf = [{2001}],
		pos_attr_1 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04},{act_speed_rate, -0.04}],
		pos_attr_2 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04},{act_speed_rate, -0.04}],
		pos_attr_3 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04},{act_speed_rate, -0.04}],
		pos_attr_4 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04},{act_speed_rate, -0.04}],
		pos_attr_5 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04},{act_speed_rate, -0.04}]
};

get(2003) ->
	#zf_cfg{
		no = 2003,
		zf_lv = 1,
		cnt_limit = 1,
		type = 1,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10056,240}],
		pre_zf = [{2002}],
		pos_attr_1 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06},{act_speed_rate, -0.06}],
		pos_attr_2 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06},{act_speed_rate, -0.06}],
		pos_attr_3 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06},{act_speed_rate, -0.06}],
		pos_attr_4 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06},{act_speed_rate, -0.06}],
		pos_attr_5 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06},{act_speed_rate, -0.06}]
};

get(2004) ->
	#zf_cfg{
		no = 2004,
		zf_lv = 1,
		cnt_limit = 1,
		type = 1,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10056,500}],
		pre_zf = [{2003}],
		pos_attr_1 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08},{act_speed_rate, -0.08}],
		pos_attr_2 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08},{act_speed_rate, -0.08}],
		pos_attr_3 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08},{act_speed_rate, -0.08}],
		pos_attr_4 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08},{act_speed_rate, -0.08}],
		pos_attr_5 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08},{act_speed_rate, -0.08}]
};

get(2005) ->
	#zf_cfg{
		no = 2005,
		zf_lv = 1,
		cnt_limit = 1,
		type = 1,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10056,1000}],
		pre_zf = [{2004}],
		pos_attr_1 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1},{act_speed_rate, -0.1}],
		pos_attr_2 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1},{act_speed_rate, -0.1}],
		pos_attr_3 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1},{act_speed_rate, -0.1}],
		pos_attr_4 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1},{act_speed_rate, -0.1}],
		pos_attr_5 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1},{act_speed_rate, -0.1}]
};

get(2006) ->
	#zf_cfg{
		no = 2006,
		zf_lv = 1,
		cnt_limit = 1,
		type = 1,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10056,2000}],
		pre_zf = [{2005}],
		pos_attr_1 = [{do_phy_dam_scaling,0.12}, {do_mag_dam_scaling,0.12},{act_speed_rate, -0.12}],
		pos_attr_2 = [{do_phy_dam_scaling,0.12}, {do_mag_dam_scaling,0.12},{act_speed_rate, -0.12}],
		pos_attr_3 = [{do_phy_dam_scaling,0.12}, {do_mag_dam_scaling,0.12},{act_speed_rate, -0.12}],
		pos_attr_4 = [{do_phy_dam_scaling,0.12}, {do_mag_dam_scaling,0.12},{act_speed_rate, -0.12}],
		pos_attr_5 = [{do_phy_dam_scaling,0.12}, {do_mag_dam_scaling,0.12},{act_speed_rate, -0.12}]
};

get(2007) ->
	#zf_cfg{
		no = 2007,
		zf_lv = 1,
		cnt_limit = 1,
		type = 1,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10056,4000}],
		pre_zf = [{2006}],
		pos_attr_1 = [{do_phy_dam_scaling,0.14}, {do_mag_dam_scaling,0.14},{act_speed_rate, -0.14}],
		pos_attr_2 = [{do_phy_dam_scaling,0.14}, {do_mag_dam_scaling,0.14},{act_speed_rate, -0.14}],
		pos_attr_3 = [{do_phy_dam_scaling,0.14}, {do_mag_dam_scaling,0.14},{act_speed_rate, -0.14}],
		pos_attr_4 = [{do_phy_dam_scaling,0.14}, {do_mag_dam_scaling,0.14},{act_speed_rate, -0.14}],
		pos_attr_5 = [{do_phy_dam_scaling,0.14}, {do_mag_dam_scaling,0.14},{act_speed_rate, -0.14}]
};

get(2008) ->
	#zf_cfg{
		no = 2008,
		zf_lv = 1,
		cnt_limit = 1,
		type = 1,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10056,8000}],
		pre_zf = [{2007}],
		pos_attr_1 = [{do_phy_dam_scaling,0.16}, {do_mag_dam_scaling,0.16},{act_speed_rate, -0.16}],
		pos_attr_2 = [{do_phy_dam_scaling,0.16}, {do_mag_dam_scaling,0.16},{act_speed_rate, -0.16}],
		pos_attr_3 = [{do_phy_dam_scaling,0.16}, {do_mag_dam_scaling,0.16},{act_speed_rate, -0.16}],
		pos_attr_4 = [{do_phy_dam_scaling,0.16}, {do_mag_dam_scaling,0.16},{act_speed_rate, -0.16}],
		pos_attr_5 = [{do_phy_dam_scaling,0.16}, {do_mag_dam_scaling,0.16},{act_speed_rate, -0.16}]
};

get(2009) ->
	#zf_cfg{
		no = 2009,
		zf_lv = 1,
		cnt_limit = 1,
		type = 1,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10056,16000}],
		pre_zf = [{2008}],
		pos_attr_1 = [{do_phy_dam_scaling,0.18}, {do_mag_dam_scaling,0.18},{act_speed_rate, -0.18}],
		pos_attr_2 = [{do_phy_dam_scaling,0.18}, {do_mag_dam_scaling,0.18},{act_speed_rate, -0.18}],
		pos_attr_3 = [{do_phy_dam_scaling,0.18}, {do_mag_dam_scaling,0.18},{act_speed_rate, -0.18}],
		pos_attr_4 = [{do_phy_dam_scaling,0.18}, {do_mag_dam_scaling,0.18},{act_speed_rate, -0.18}],
		pos_attr_5 = [{do_phy_dam_scaling,0.18}, {do_mag_dam_scaling,0.18},{act_speed_rate, -0.18}]
};

get(2010) ->
	#zf_cfg{
		no = 2010,
		zf_lv = 1,
		cnt_limit = 1,
		type = 1,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10056,30000}],
		pre_zf = [{2009}],
		pos_attr_1 = [{do_phy_dam_scaling,0.2}, {do_mag_dam_scaling,0.2},{act_speed_rate, -0.2}],
		pos_attr_2 = [{do_phy_dam_scaling,0.2}, {do_mag_dam_scaling,0.2},{act_speed_rate, -0.2}],
		pos_attr_3 = [{do_phy_dam_scaling,0.2}, {do_mag_dam_scaling,0.2},{act_speed_rate, -0.2}],
		pos_attr_4 = [{do_phy_dam_scaling,0.2}, {do_mag_dam_scaling,0.2},{act_speed_rate, -0.2}],
		pos_attr_5 = [{do_phy_dam_scaling,0.2}, {do_mag_dam_scaling,0.2},{act_speed_rate, -0.2}]
};

get(3001) ->
	#zf_cfg{
		no = 3001,
		zf_lv = 1,
		cnt_limit = 1,
		type = 2,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10057,1}],
		pre_zf = [],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.015},{be_mag_dam_reduce_coef, 0.015}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.015},{be_mag_dam_reduce_coef, 0.015}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.015},{be_mag_dam_reduce_coef, 0.015}],
		pos_attr_4 = [{do_phy_dam_scaling,0.01}, {do_mag_dam_scaling,0.01}],
		pos_attr_5 = [{act_speed_rate, 0.015}]
};

get(3002) ->
	#zf_cfg{
		no = 3002,
		zf_lv = 1,
		cnt_limit = 1,
		type = 2,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10057,80}],
		pre_zf = [{3001}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.03},{be_mag_dam_reduce_coef, 0.03}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.03},{be_mag_dam_reduce_coef, 0.03}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.03},{be_mag_dam_reduce_coef, 0.03}],
		pos_attr_4 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02}],
		pos_attr_5 = [{act_speed_rate, 0.03}]
};

get(3003) ->
	#zf_cfg{
		no = 3003,
		zf_lv = 1,
		cnt_limit = 1,
		type = 2,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10057,240}],
		pre_zf = [{3002}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.045},{be_mag_dam_reduce_coef, 0.045}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.045},{be_mag_dam_reduce_coef, 0.045}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.045},{be_mag_dam_reduce_coef, 0.045}],
		pos_attr_4 = [{do_phy_dam_scaling,0.03}, {do_mag_dam_scaling,0.03}],
		pos_attr_5 = [{act_speed_rate, 0.045}]
};

get(3004) ->
	#zf_cfg{
		no = 3004,
		zf_lv = 1,
		cnt_limit = 1,
		type = 2,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10057,500}],
		pre_zf = [{3003}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.06},{be_mag_dam_reduce_coef, 0.06}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.06},{be_mag_dam_reduce_coef, 0.06}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.06},{be_mag_dam_reduce_coef, 0.06}],
		pos_attr_4 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04}],
		pos_attr_5 = [{act_speed_rate, 0.06}]
};

get(3005) ->
	#zf_cfg{
		no = 3005,
		zf_lv = 1,
		cnt_limit = 1,
		type = 2,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10057,1000}],
		pre_zf = [{3004}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.075},{be_mag_dam_reduce_coef, 0.075}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.075},{be_mag_dam_reduce_coef, 0.075}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.075},{be_mag_dam_reduce_coef, 0.075}],
		pos_attr_4 = [{do_phy_dam_scaling,0.05}, {do_mag_dam_scaling,0.05}],
		pos_attr_5 = [{act_speed_rate, 0.075}]
};

get(3006) ->
	#zf_cfg{
		no = 3006,
		zf_lv = 1,
		cnt_limit = 1,
		type = 2,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10057,2000}],
		pre_zf = [{3005}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.09},{be_mag_dam_reduce_coef, 0.09}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.09},{be_mag_dam_reduce_coef, 0.09}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.09},{be_mag_dam_reduce_coef, 0.09}],
		pos_attr_4 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06}],
		pos_attr_5 = [{act_speed_rate, 0.09}]
};

get(3007) ->
	#zf_cfg{
		no = 3007,
		zf_lv = 1,
		cnt_limit = 1,
		type = 2,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10057,4000}],
		pre_zf = [{3006}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.105},{be_mag_dam_reduce_coef, 0.105}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.105},{be_mag_dam_reduce_coef, 0.105}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.105},{be_mag_dam_reduce_coef, 0.105}],
		pos_attr_4 = [{do_phy_dam_scaling,0.07}, {do_mag_dam_scaling,0.07}],
		pos_attr_5 = [{act_speed_rate, 0.105}]
};

get(3008) ->
	#zf_cfg{
		no = 3008,
		zf_lv = 1,
		cnt_limit = 1,
		type = 2,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10057,8000}],
		pre_zf = [{3007}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.120},{be_mag_dam_reduce_coef, 0.120}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.120},{be_mag_dam_reduce_coef, 0.120}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.120},{be_mag_dam_reduce_coef, 0.120}],
		pos_attr_4 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08}],
		pos_attr_5 = [{act_speed_rate, 0.120}]
};

get(3009) ->
	#zf_cfg{
		no = 3009,
		zf_lv = 1,
		cnt_limit = 1,
		type = 2,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10057,16000}],
		pre_zf = [{3008}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.135},{be_mag_dam_reduce_coef, 0.135}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.135},{be_mag_dam_reduce_coef, 0.135}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.135},{be_mag_dam_reduce_coef, 0.135}],
		pos_attr_4 = [{do_phy_dam_scaling,0.09}, {do_mag_dam_scaling,0.09}],
		pos_attr_5 = [{act_speed_rate, 0.135}]
};

get(3010) ->
	#zf_cfg{
		no = 3010,
		zf_lv = 1,
		cnt_limit = 1,
		type = 2,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10057,30000}],
		pre_zf = [{3009}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.15},{be_mag_dam_reduce_coef, 0.15}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.15},{be_mag_dam_reduce_coef, 0.15}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.15},{be_mag_dam_reduce_coef, 0.15}],
		pos_attr_4 = [{do_phy_dam_scaling,0.10}, {do_mag_dam_scaling,0.10}],
		pos_attr_5 = [{act_speed_rate, 0.150}]
};

get(4001) ->
	#zf_cfg{
		no = 4001,
		zf_lv = 1,
		cnt_limit = 1,
		type = 3,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10058,1}],
		pre_zf = [],
		pos_attr_1 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02}],
		pos_attr_2 = [{do_phy_dam_scaling,0.01}, {do_mag_dam_scaling,0.01}],
		pos_attr_3 = [{do_phy_dam_scaling,0.01}, {do_mag_dam_scaling,0.01}],
		pos_attr_4 = [{act_speed_rate, 0.01}],
		pos_attr_5 = [{act_speed_rate, 0.01}]
};

get(4002) ->
	#zf_cfg{
		no = 4002,
		zf_lv = 1,
		cnt_limit = 1,
		type = 3,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10058,80}],
		pre_zf = [{4001}],
		pos_attr_1 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04}],
		pos_attr_2 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02}],
		pos_attr_3 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02}],
		pos_attr_4 = [{act_speed_rate, 0.02}],
		pos_attr_5 = [{act_speed_rate, 0.02}]
};

get(4003) ->
	#zf_cfg{
		no = 4003,
		zf_lv = 1,
		cnt_limit = 1,
		type = 3,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10058,240}],
		pre_zf = [{4002}],
		pos_attr_1 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06}],
		pos_attr_2 = [{do_phy_dam_scaling,0.03}, {do_mag_dam_scaling,0.03}],
		pos_attr_3 = [{do_phy_dam_scaling,0.03}, {do_mag_dam_scaling,0.03}],
		pos_attr_4 = [{act_speed_rate, 0.03}],
		pos_attr_5 = [{act_speed_rate, 0.03}]
};

get(4004) ->
	#zf_cfg{
		no = 4004,
		zf_lv = 1,
		cnt_limit = 1,
		type = 3,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10058,500}],
		pre_zf = [{4003}],
		pos_attr_1 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08}],
		pos_attr_2 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04}],
		pos_attr_3 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04}],
		pos_attr_4 = [{act_speed_rate, 0.04}],
		pos_attr_5 = [{act_speed_rate, 0.04}]
};

get(4005) ->
	#zf_cfg{
		no = 4005,
		zf_lv = 1,
		cnt_limit = 1,
		type = 3,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10058,1000}],
		pre_zf = [{4004}],
		pos_attr_1 = [{do_phy_dam_scaling,0.10}, {do_mag_dam_scaling,0.10}],
		pos_attr_2 = [{do_phy_dam_scaling,0.05}, {do_mag_dam_scaling,0.05}],
		pos_attr_3 = [{do_phy_dam_scaling,0.05}, {do_mag_dam_scaling,0.05}],
		pos_attr_4 = [{act_speed_rate, 0.05}],
		pos_attr_5 = [{act_speed_rate, 0.05}]
};

get(4006) ->
	#zf_cfg{
		no = 4006,
		zf_lv = 1,
		cnt_limit = 1,
		type = 3,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10058,2000}],
		pre_zf = [{4005}],
		pos_attr_1 = [{do_phy_dam_scaling,0.12}, {do_mag_dam_scaling,0.12}],
		pos_attr_2 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06}],
		pos_attr_3 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06}],
		pos_attr_4 = [{act_speed_rate, 0.06}],
		pos_attr_5 = [{act_speed_rate, 0.06}]
};

get(4007) ->
	#zf_cfg{
		no = 4007,
		zf_lv = 1,
		cnt_limit = 1,
		type = 3,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10058,4000}],
		pre_zf = [{4006}],
		pos_attr_1 = [{do_phy_dam_scaling,0.14}, {do_mag_dam_scaling,0.14}],
		pos_attr_2 = [{do_phy_dam_scaling,0.07}, {do_mag_dam_scaling,0.07}],
		pos_attr_3 = [{do_phy_dam_scaling,0.07}, {do_mag_dam_scaling,0.07}],
		pos_attr_4 = [{act_speed_rate, 0.07}],
		pos_attr_5 = [{act_speed_rate, 0.07}]
};

get(4008) ->
	#zf_cfg{
		no = 4008,
		zf_lv = 1,
		cnt_limit = 1,
		type = 3,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10058,8000}],
		pre_zf = [{4007}],
		pos_attr_1 = [{do_phy_dam_scaling,0.16}, {do_mag_dam_scaling,0.16}],
		pos_attr_2 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08}],
		pos_attr_3 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08}],
		pos_attr_4 = [{act_speed_rate, 0.08}],
		pos_attr_5 = [{act_speed_rate, 0.08}]
};

get(4009) ->
	#zf_cfg{
		no = 4009,
		zf_lv = 1,
		cnt_limit = 1,
		type = 3,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10058,16000}],
		pre_zf = [{4008}],
		pos_attr_1 = [{do_phy_dam_scaling,0.18}, {do_mag_dam_scaling,0.18}],
		pos_attr_2 = [{do_phy_dam_scaling,0.09}, {do_mag_dam_scaling,0.09}],
		pos_attr_3 = [{do_phy_dam_scaling,0.09}, {do_mag_dam_scaling,0.09}],
		pos_attr_4 = [{act_speed_rate, 0.09}],
		pos_attr_5 = [{act_speed_rate, 0.09}]
};

get(4010) ->
	#zf_cfg{
		no = 4010,
		zf_lv = 1,
		cnt_limit = 1,
		type = 3,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10058,30000}],
		pre_zf = [{4009}],
		pos_attr_1 = [{do_phy_dam_scaling,0.2}, {do_mag_dam_scaling,0.2}],
		pos_attr_2 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1}],
		pos_attr_3 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1}],
		pos_attr_4 = [{act_speed_rate, 0.1}],
		pos_attr_5 = [{act_speed_rate, 0.1}]
};

get(5001) ->
	#zf_cfg{
		no = 5001,
		zf_lv = 1,
		cnt_limit = 1,
		type = 4,
		zf_battle_pos = [{4,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10061,1}],
		pre_zf = [],
		pos_attr_1 = [{do_phy_dam_scaling,0.025}, {do_mag_dam_scaling,0.025}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.01}, {be_mag_dam_reduce_coef, 0.01}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.01}, {be_mag_dam_reduce_coef, 0.01}],
		pos_attr_4 = [{do_phy_dam_scaling,0.01}, {do_mag_dam_scaling,0.01}],
		pos_attr_5 = [{do_phy_dam_scaling,0.01}, {do_mag_dam_scaling,0.01}]
};

get(5002) ->
	#zf_cfg{
		no = 5002,
		zf_lv = 1,
		cnt_limit = 1,
		type = 4,
		zf_battle_pos = [{4,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10061,80}],
		pre_zf = [{5001}],
		pos_attr_1 = [{do_phy_dam_scaling,0.05}, {do_mag_dam_scaling,0.05}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.02}, {be_mag_dam_reduce_coef, 0.02}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.02}, {be_mag_dam_reduce_coef, 0.02}],
		pos_attr_4 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02}],
		pos_attr_5 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02}]
};

get(5003) ->
	#zf_cfg{
		no = 5003,
		zf_lv = 1,
		cnt_limit = 1,
		type = 4,
		zf_battle_pos = [{4,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10061,240}],
		pre_zf = [{5002}],
		pos_attr_1 = [{do_phy_dam_scaling,0.075}, {do_mag_dam_scaling,0.075}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.03}, {be_mag_dam_reduce_coef, 0.03}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.03}, {be_mag_dam_reduce_coef, 0.03}],
		pos_attr_4 = [{do_phy_dam_scaling,0.03}, {do_mag_dam_scaling,0.03}],
		pos_attr_5 = [{do_phy_dam_scaling,0.03}, {do_mag_dam_scaling,0.03}]
};

get(5004) ->
	#zf_cfg{
		no = 5004,
		zf_lv = 1,
		cnt_limit = 1,
		type = 4,
		zf_battle_pos = [{4,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10061,500}],
		pre_zf = [{5003}],
		pos_attr_1 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.04}, {be_mag_dam_reduce_coef, 0.04}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.04}, {be_mag_dam_reduce_coef, 0.04}],
		pos_attr_4 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04}],
		pos_attr_5 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04}]
};

get(5005) ->
	#zf_cfg{
		no = 5005,
		zf_lv = 1,
		cnt_limit = 1,
		type = 4,
		zf_battle_pos = [{4,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10061,1000}],
		pre_zf = [{5004}],
		pos_attr_1 = [{do_phy_dam_scaling,0.125}, {do_mag_dam_scaling,0.125}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.05}, {be_mag_dam_reduce_coef, 0.05}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.05}, {be_mag_dam_reduce_coef, 0.05}],
		pos_attr_4 = [{do_phy_dam_scaling,0.05}, {do_mag_dam_scaling,0.05}],
		pos_attr_5 = [{do_phy_dam_scaling,0.05}, {do_mag_dam_scaling,0.05}]
};

get(5006) ->
	#zf_cfg{
		no = 5006,
		zf_lv = 1,
		cnt_limit = 1,
		type = 4,
		zf_battle_pos = [{4,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10061,2000}],
		pre_zf = [{5005}],
		pos_attr_1 = [{do_phy_dam_scaling,0.15}, {do_mag_dam_scaling,0.15}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.06}, {be_mag_dam_reduce_coef, 0.06}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.06}, {be_mag_dam_reduce_coef, 0.06}],
		pos_attr_4 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06}],
		pos_attr_5 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06}]
};

get(5007) ->
	#zf_cfg{
		no = 5007,
		zf_lv = 1,
		cnt_limit = 1,
		type = 4,
		zf_battle_pos = [{4,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10061,4000}],
		pre_zf = [{5006}],
		pos_attr_1 = [{do_phy_dam_scaling,0.175}, {do_mag_dam_scaling,0.175}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.07}, {be_mag_dam_reduce_coef, 0.07}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.07}, {be_mag_dam_reduce_coef, 0.07}],
		pos_attr_4 = [{do_phy_dam_scaling,0.07}, {do_mag_dam_scaling,0.07}],
		pos_attr_5 = [{do_phy_dam_scaling,0.07}, {do_mag_dam_scaling,0.07}]
};

get(5008) ->
	#zf_cfg{
		no = 5008,
		zf_lv = 1,
		cnt_limit = 1,
		type = 4,
		zf_battle_pos = [{4,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10061,8000}],
		pre_zf = [{5007}],
		pos_attr_1 = [{do_phy_dam_scaling,0.2}, {do_mag_dam_scaling,0.2}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.08}, {be_mag_dam_reduce_coef, 0.08}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.08}, {be_mag_dam_reduce_coef, 0.08}],
		pos_attr_4 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08}],
		pos_attr_5 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08}]
};

get(5009) ->
	#zf_cfg{
		no = 5009,
		zf_lv = 1,
		cnt_limit = 1,
		type = 4,
		zf_battle_pos = [{4,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10061,16000}],
		pre_zf = [{5008}],
		pos_attr_1 = [{do_phy_dam_scaling,0.225}, {do_mag_dam_scaling,0.225}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.09}, {be_mag_dam_reduce_coef, 0.09}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.09}, {be_mag_dam_reduce_coef, 0.09}],
		pos_attr_4 = [{do_phy_dam_scaling,0.09}, {do_mag_dam_scaling,0.09}],
		pos_attr_5 = [{do_phy_dam_scaling,0.09}, {do_mag_dam_scaling,0.09}]
};

get(5010) ->
	#zf_cfg{
		no = 5010,
		zf_lv = 1,
		cnt_limit = 1,
		type = 4,
		zf_battle_pos = [{4,3},{2,4},{2,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10061,30000}],
		pre_zf = [{5009}],
		pos_attr_1 = [{do_phy_dam_scaling,0.25}, {do_mag_dam_scaling,0.25}],
		pos_attr_2 = [{be_phy_dam_reduce_coef, 0.1}, {be_mag_dam_reduce_coef, 0.1}],
		pos_attr_3 = [{be_phy_dam_reduce_coef, 0.1}, {be_mag_dam_reduce_coef, 0.1}],
		pos_attr_4 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1}],
		pos_attr_5 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1}]
};

get(6001) ->
	#zf_cfg{
		no = 6001,
		zf_lv = 1,
		cnt_limit = 1,
		type = 5,
		zf_battle_pos = [{3,3},{2,2},{2,5},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10065,1}],
		pre_zf = [],
		pos_attr_1 = [{seal_resis_rate, 0.015}],
		pos_attr_2 = [{seal_resis_rate, 0.015}],
		pos_attr_3 = [{seal_resis_rate, 0.015}],
		pos_attr_4 = [{do_phy_dam_scaling,0.01}, {do_mag_dam_scaling,0.01}],
		pos_attr_5 = [{do_phy_dam_scaling,0.01}, {do_mag_dam_scaling,0.01}]
};

get(6002) ->
	#zf_cfg{
		no = 6002,
		zf_lv = 1,
		cnt_limit = 1,
		type = 5,
		zf_battle_pos = [{3,3},{2,2},{2,5},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10065,80}],
		pre_zf = [{6001}],
		pos_attr_1 = [{seal_resis_rate, 0.03}],
		pos_attr_2 = [{seal_resis_rate, 0.03}],
		pos_attr_3 = [{seal_resis_rate, 0.03}],
		pos_attr_4 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02}],
		pos_attr_5 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02}]
};

get(6003) ->
	#zf_cfg{
		no = 6003,
		zf_lv = 1,
		cnt_limit = 1,
		type = 5,
		zf_battle_pos = [{3,3},{2,2},{2,5},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10065,240}],
		pre_zf = [{6002}],
		pos_attr_1 = [{seal_resis_rate, 0.045}],
		pos_attr_2 = [{seal_resis_rate, 0.045}],
		pos_attr_3 = [{seal_resis_rate, 0.045}],
		pos_attr_4 = [{do_phy_dam_scaling,0.03}, {do_mag_dam_scaling,0.03}],
		pos_attr_5 = [{do_phy_dam_scaling,0.03}, {do_mag_dam_scaling,0.03}]
};

get(6004) ->
	#zf_cfg{
		no = 6004,
		zf_lv = 1,
		cnt_limit = 1,
		type = 5,
		zf_battle_pos = [{3,3},{2,2},{2,5},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10065,500}],
		pre_zf = [{6003}],
		pos_attr_1 = [{seal_resis_rate, 0.06}],
		pos_attr_2 = [{seal_resis_rate, 0.06}],
		pos_attr_3 = [{seal_resis_rate, 0.06}],
		pos_attr_4 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04}],
		pos_attr_5 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04}]
};

get(6005) ->
	#zf_cfg{
		no = 6005,
		zf_lv = 1,
		cnt_limit = 1,
		type = 5,
		zf_battle_pos = [{3,3},{2,2},{2,5},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10065,1000}],
		pre_zf = [{6004}],
		pos_attr_1 = [{seal_resis_rate, 0.075}],
		pos_attr_2 = [{seal_resis_rate, 0.075}],
		pos_attr_3 = [{seal_resis_rate, 0.075}],
		pos_attr_4 = [{do_phy_dam_scaling,0.05}, {do_mag_dam_scaling,0.05}],
		pos_attr_5 = [{do_phy_dam_scaling,0.05}, {do_mag_dam_scaling,0.05}]
};

get(6006) ->
	#zf_cfg{
		no = 6006,
		zf_lv = 1,
		cnt_limit = 1,
		type = 5,
		zf_battle_pos = [{3,3},{2,2},{2,5},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10065,2000}],
		pre_zf = [{6005}],
		pos_attr_1 = [{seal_resis_rate, 0.09}],
		pos_attr_2 = [{seal_resis_rate, 0.09}],
		pos_attr_3 = [{seal_resis_rate, 0.09}],
		pos_attr_4 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06}],
		pos_attr_5 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06}]
};

get(6007) ->
	#zf_cfg{
		no = 6007,
		zf_lv = 1,
		cnt_limit = 1,
		type = 5,
		zf_battle_pos = [{3,3},{2,2},{2,5},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10065,4000}],
		pre_zf = [{6006}],
		pos_attr_1 = [{seal_resis_rate, 0.105}],
		pos_attr_2 = [{seal_resis_rate, 0.105}],
		pos_attr_3 = [{seal_resis_rate, 0.105}],
		pos_attr_4 = [{do_phy_dam_scaling,0.07}, {do_mag_dam_scaling,0.07}],
		pos_attr_5 = [{do_phy_dam_scaling,0.07}, {do_mag_dam_scaling,0.07}]
};

get(6008) ->
	#zf_cfg{
		no = 6008,
		zf_lv = 1,
		cnt_limit = 1,
		type = 5,
		zf_battle_pos = [{3,3},{2,2},{2,5},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10065,8000}],
		pre_zf = [{6007}],
		pos_attr_1 = [{seal_resis_rate, 0.12}],
		pos_attr_2 = [{seal_resis_rate, 0.12}],
		pos_attr_3 = [{seal_resis_rate, 0.12}],
		pos_attr_4 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08}],
		pos_attr_5 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08}]
};

get(6009) ->
	#zf_cfg{
		no = 6009,
		zf_lv = 1,
		cnt_limit = 1,
		type = 5,
		zf_battle_pos = [{3,3},{2,2},{2,5},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10065,16000}],
		pre_zf = [{6008}],
		pos_attr_1 = [{seal_resis_rate, 0.135}],
		pos_attr_2 = [{seal_resis_rate, 0.135}],
		pos_attr_3 = [{seal_resis_rate, 0.135}],
		pos_attr_4 = [{do_phy_dam_scaling,0.09}, {do_mag_dam_scaling,0.09}],
		pos_attr_5 = [{do_phy_dam_scaling,0.09}, {do_mag_dam_scaling,0.09}]
};

get(6010) ->
	#zf_cfg{
		no = 6010,
		zf_lv = 1,
		cnt_limit = 1,
		type = 5,
		zf_battle_pos = [{3,3},{2,2},{2,5},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10065,30000}],
		pre_zf = [{6009}],
		pos_attr_1 = [{seal_resis_rate, 0.15}],
		pos_attr_2 = [{seal_resis_rate, 0.15}],
		pos_attr_3 = [{seal_resis_rate, 0.15}],
		pos_attr_4 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1}],
		pos_attr_5 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1}]
};

get(7001) ->
	#zf_cfg{
		no = 7001,
		zf_lv = 1,
		cnt_limit = 1,
		type = 6,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10060,1}],
		pre_zf = [],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.02}],
		pos_attr_2 = [{act_speed_rate, 0.015}],
		pos_attr_3 = [{do_mag_dam_scaling,0.03},{act_speed_rate, -0.03}],
		pos_attr_4 = [{do_phy_dam_scaling,0.02}],
		pos_attr_5 = [{be_phy_dam_reduce_coef, 0.02}]
};

get(7002) ->
	#zf_cfg{
		no = 7002,
		zf_lv = 1,
		cnt_limit = 1,
		type = 6,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10060,80}],
		pre_zf = [{7001}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.04}],
		pos_attr_2 = [{act_speed_rate, 0.030}],
		pos_attr_3 = [{do_mag_dam_scaling,0.06},{act_speed_rate, -0.06}],
		pos_attr_4 = [{do_phy_dam_scaling,0.04}],
		pos_attr_5 = [{be_phy_dam_reduce_coef, 0.04}]
};

get(7003) ->
	#zf_cfg{
		no = 7003,
		zf_lv = 1,
		cnt_limit = 1,
		type = 6,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10060,240}],
		pre_zf = [{7002}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.06}],
		pos_attr_2 = [{act_speed_rate, 0.045}],
		pos_attr_3 = [{do_mag_dam_scaling,0.09},{act_speed_rate, -0.09}],
		pos_attr_4 = [{do_phy_dam_scaling,0.06}],
		pos_attr_5 = [{be_phy_dam_reduce_coef, 0.06}]
};

get(7004) ->
	#zf_cfg{
		no = 7004,
		zf_lv = 1,
		cnt_limit = 1,
		type = 6,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10060,500}],
		pre_zf = [{7003}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.08}],
		pos_attr_2 = [{act_speed_rate, 0.060}],
		pos_attr_3 = [{do_mag_dam_scaling,0.12},{act_speed_rate, -0.12}],
		pos_attr_4 = [{do_phy_dam_scaling,0.08}],
		pos_attr_5 = [{be_phy_dam_reduce_coef, 0.08}]
};

get(7005) ->
	#zf_cfg{
		no = 7005,
		zf_lv = 1,
		cnt_limit = 1,
		type = 6,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10060,1000}],
		pre_zf = [{7004}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.10}],
		pos_attr_2 = [{act_speed_rate, 0.075}],
		pos_attr_3 = [{do_mag_dam_scaling,0.15},{act_speed_rate, -0.15}],
		pos_attr_4 = [{do_phy_dam_scaling,0.10}],
		pos_attr_5 = [{be_phy_dam_reduce_coef, 0.10}]
};

get(7006) ->
	#zf_cfg{
		no = 7006,
		zf_lv = 1,
		cnt_limit = 1,
		type = 6,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10060,2000}],
		pre_zf = [{7005}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.12}],
		pos_attr_2 = [{act_speed_rate, 0.090}],
		pos_attr_3 = [{do_mag_dam_scaling,0.18},{act_speed_rate, -0.18}],
		pos_attr_4 = [{do_phy_dam_scaling,0.12}],
		pos_attr_5 = [{be_phy_dam_reduce_coef, 0.12}]
};

get(7007) ->
	#zf_cfg{
		no = 7007,
		zf_lv = 1,
		cnt_limit = 1,
		type = 6,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10060,4000}],
		pre_zf = [{7006}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.14}],
		pos_attr_2 = [{act_speed_rate, 0.105}],
		pos_attr_3 = [{do_mag_dam_scaling,0.21},{act_speed_rate, -0.21}],
		pos_attr_4 = [{do_phy_dam_scaling,0.14}],
		pos_attr_5 = [{be_phy_dam_reduce_coef, 0.14}]
};

get(7008) ->
	#zf_cfg{
		no = 7008,
		zf_lv = 1,
		cnt_limit = 1,
		type = 6,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10060,8000}],
		pre_zf = [{7007}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.16}],
		pos_attr_2 = [{act_speed_rate, 0.120}],
		pos_attr_3 = [{do_mag_dam_scaling,0.24},{act_speed_rate, -0.24}],
		pos_attr_4 = [{do_phy_dam_scaling,0.16}],
		pos_attr_5 = [{be_phy_dam_reduce_coef, 0.16}]
};

get(7009) ->
	#zf_cfg{
		no = 7009,
		zf_lv = 1,
		cnt_limit = 1,
		type = 6,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10060,16000}],
		pre_zf = [{7008}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.18}],
		pos_attr_2 = [{act_speed_rate, 0.135}],
		pos_attr_3 = [{do_mag_dam_scaling,0.27},{act_speed_rate, -0.27}],
		pos_attr_4 = [{do_phy_dam_scaling,0.18}],
		pos_attr_5 = [{be_phy_dam_reduce_coef, 0.18}]
};

get(7010) ->
	#zf_cfg{
		no = 7010,
		zf_lv = 1,
		cnt_limit = 1,
		type = 6,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10060,30000}],
		pre_zf = [{7009}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.20}],
		pos_attr_2 = [{act_speed_rate, 0.150}],
		pos_attr_3 = [{do_mag_dam_scaling,0.30},{act_speed_rate, -0.30}],
		pos_attr_4 = [{do_phy_dam_scaling,0.20}],
		pos_attr_5 = [{be_phy_dam_reduce_coef, 0.20}]
};

get(8001) ->
	#zf_cfg{
		no = 8001,
		zf_lv = 1,
		cnt_limit = 1,
		type = 7,
		zf_battle_pos = [{2,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10062,1}],
		pre_zf = [],
		pos_attr_1 = [{act_speed_rate, 0.015}],
		pos_attr_2 = [{act_speed_rate, 0.015}],
		pos_attr_3 = [{act_speed_rate, 0.015}],
		pos_attr_4 = [{act_speed_rate, 0.015}],
		pos_attr_5 = [{act_speed_rate, 0.015}]
};

get(8002) ->
	#zf_cfg{
		no = 8002,
		zf_lv = 1,
		cnt_limit = 1,
		type = 7,
		zf_battle_pos = [{2,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10062,80}],
		pre_zf = [{8001}],
		pos_attr_1 = [{act_speed_rate, 0.030}],
		pos_attr_2 = [{act_speed_rate, 0.030}],
		pos_attr_3 = [{act_speed_rate, 0.030}],
		pos_attr_4 = [{act_speed_rate, 0.030}],
		pos_attr_5 = [{act_speed_rate, 0.030}]
};

get(8003) ->
	#zf_cfg{
		no = 8003,
		zf_lv = 1,
		cnt_limit = 1,
		type = 7,
		zf_battle_pos = [{2,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10062,240}],
		pre_zf = [{8002}],
		pos_attr_1 = [{act_speed_rate, 0.045}],
		pos_attr_2 = [{act_speed_rate, 0.045}],
		pos_attr_3 = [{act_speed_rate, 0.045}],
		pos_attr_4 = [{act_speed_rate, 0.045}],
		pos_attr_5 = [{act_speed_rate, 0.045}]
};

get(8004) ->
	#zf_cfg{
		no = 8004,
		zf_lv = 1,
		cnt_limit = 1,
		type = 7,
		zf_battle_pos = [{2,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10062,500}],
		pre_zf = [{8003}],
		pos_attr_1 = [{act_speed_rate, 0.060}],
		pos_attr_2 = [{act_speed_rate, 0.060}],
		pos_attr_3 = [{act_speed_rate, 0.060}],
		pos_attr_4 = [{act_speed_rate, 0.060}],
		pos_attr_5 = [{act_speed_rate, 0.060}]
};

get(8005) ->
	#zf_cfg{
		no = 8005,
		zf_lv = 1,
		cnt_limit = 1,
		type = 7,
		zf_battle_pos = [{2,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10062,1000}],
		pre_zf = [{8004}],
		pos_attr_1 = [{act_speed_rate, 0.075}],
		pos_attr_2 = [{act_speed_rate, 0.075}],
		pos_attr_3 = [{act_speed_rate, 0.075}],
		pos_attr_4 = [{act_speed_rate, 0.075}],
		pos_attr_5 = [{act_speed_rate, 0.075}]
};

get(8006) ->
	#zf_cfg{
		no = 8006,
		zf_lv = 1,
		cnt_limit = 1,
		type = 7,
		zf_battle_pos = [{2,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10062,2000}],
		pre_zf = [{8005}],
		pos_attr_1 = [{act_speed_rate, 0.090}],
		pos_attr_2 = [{act_speed_rate, 0.090}],
		pos_attr_3 = [{act_speed_rate, 0.090}],
		pos_attr_4 = [{act_speed_rate, 0.090}],
		pos_attr_5 = [{act_speed_rate, 0.090}]
};

get(8007) ->
	#zf_cfg{
		no = 8007,
		zf_lv = 1,
		cnt_limit = 1,
		type = 7,
		zf_battle_pos = [{2,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10062,4000}],
		pre_zf = [{8006}],
		pos_attr_1 = [{act_speed_rate, 0.105}],
		pos_attr_2 = [{act_speed_rate, 0.105}],
		pos_attr_3 = [{act_speed_rate, 0.105}],
		pos_attr_4 = [{act_speed_rate, 0.105}],
		pos_attr_5 = [{act_speed_rate, 0.105}]
};

get(8008) ->
	#zf_cfg{
		no = 8008,
		zf_lv = 1,
		cnt_limit = 1,
		type = 7,
		zf_battle_pos = [{2,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10062,8000}],
		pre_zf = [{8007}],
		pos_attr_1 = [{act_speed_rate, 0.120}],
		pos_attr_2 = [{act_speed_rate, 0.120}],
		pos_attr_3 = [{act_speed_rate, 0.120}],
		pos_attr_4 = [{act_speed_rate, 0.120}],
		pos_attr_5 = [{act_speed_rate, 0.120}]
};

get(8009) ->
	#zf_cfg{
		no = 8009,
		zf_lv = 1,
		cnt_limit = 1,
		type = 7,
		zf_battle_pos = [{2,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10062,16000}],
		pre_zf = [{8008}],
		pos_attr_1 = [{act_speed_rate, 0.135}],
		pos_attr_2 = [{act_speed_rate, 0.135}],
		pos_attr_3 = [{act_speed_rate, 0.135}],
		pos_attr_4 = [{act_speed_rate, 0.135}],
		pos_attr_5 = [{act_speed_rate, 0.135}]
};

get(8010) ->
	#zf_cfg{
		no = 8010,
		zf_lv = 1,
		cnt_limit = 1,
		type = 7,
		zf_battle_pos = [{2,3},{3,4},{3,2},{2,5},{2,1},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10062,30000}],
		pre_zf = [{8009}],
		pos_attr_1 = [{act_speed_rate, 0.150}],
		pos_attr_2 = [{act_speed_rate, 0.150}],
		pos_attr_3 = [{act_speed_rate, 0.150}],
		pos_attr_4 = [{act_speed_rate, 0.150}],
		pos_attr_5 = [{act_speed_rate, 0.150}]
};

get(9001) ->
	#zf_cfg{
		no = 9001,
		zf_lv = 1,
		cnt_limit = 1,
		type = 8,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,2},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10063,1}],
		pre_zf = [],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.02}],
		pos_attr_2 = [{be_mag_dam_reduce_coef, 0.02}],
		pos_attr_3 = [{be_mag_dam_reduce_coef, 0.02}],
		pos_attr_4 = [{do_phy_dam_scaling,0.01}, {do_mag_dam_scaling,0.01}],
		pos_attr_5 = [{do_phy_dam_scaling,0.01}, {do_mag_dam_scaling,0.01}]
};

get(9002) ->
	#zf_cfg{
		no = 9002,
		zf_lv = 1,
		cnt_limit = 1,
		type = 8,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,2},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10063,80}],
		pre_zf = [{9001}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.04}],
		pos_attr_2 = [{be_mag_dam_reduce_coef, 0.04}],
		pos_attr_3 = [{be_mag_dam_reduce_coef, 0.04}],
		pos_attr_4 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02}],
		pos_attr_5 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02}]
};

get(9003) ->
	#zf_cfg{
		no = 9003,
		zf_lv = 1,
		cnt_limit = 1,
		type = 8,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,2},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10063,240}],
		pre_zf = [{9002}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.06}],
		pos_attr_2 = [{be_mag_dam_reduce_coef, 0.06}],
		pos_attr_3 = [{be_mag_dam_reduce_coef, 0.06}],
		pos_attr_4 = [{do_phy_dam_scaling,0.03}, {do_mag_dam_scaling,0.03}],
		pos_attr_5 = [{do_phy_dam_scaling,0.03}, {do_mag_dam_scaling,0.03}]
};

get(9004) ->
	#zf_cfg{
		no = 9004,
		zf_lv = 1,
		cnt_limit = 1,
		type = 8,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,2},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10063,500}],
		pre_zf = [{9003}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.08}],
		pos_attr_2 = [{be_mag_dam_reduce_coef, 0.08}],
		pos_attr_3 = [{be_mag_dam_reduce_coef, 0.08}],
		pos_attr_4 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04}],
		pos_attr_5 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04}]
};

get(9005) ->
	#zf_cfg{
		no = 9005,
		zf_lv = 1,
		cnt_limit = 1,
		type = 8,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,2},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10063,1000}],
		pre_zf = [{9004}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.10}],
		pos_attr_2 = [{be_mag_dam_reduce_coef, 0.10}],
		pos_attr_3 = [{be_mag_dam_reduce_coef, 0.10}],
		pos_attr_4 = [{do_phy_dam_scaling,0.05}, {do_mag_dam_scaling,0.05}],
		pos_attr_5 = [{do_phy_dam_scaling,0.05}, {do_mag_dam_scaling,0.05}]
};

get(9006) ->
	#zf_cfg{
		no = 9006,
		zf_lv = 1,
		cnt_limit = 1,
		type = 8,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,2},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10063,2000}],
		pre_zf = [{9005}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.12}],
		pos_attr_2 = [{be_mag_dam_reduce_coef, 0.12}],
		pos_attr_3 = [{be_mag_dam_reduce_coef, 0.12}],
		pos_attr_4 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06}],
		pos_attr_5 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06}]
};

get(9007) ->
	#zf_cfg{
		no = 9007,
		zf_lv = 1,
		cnt_limit = 1,
		type = 8,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,2},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10063,4000}],
		pre_zf = [{9006}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.14}],
		pos_attr_2 = [{be_mag_dam_reduce_coef, 0.14}],
		pos_attr_3 = [{be_mag_dam_reduce_coef, 0.14}],
		pos_attr_4 = [{do_phy_dam_scaling,0.07}, {do_mag_dam_scaling,0.07}],
		pos_attr_5 = [{do_phy_dam_scaling,0.07}, {do_mag_dam_scaling,0.07}]
};

get(9008) ->
	#zf_cfg{
		no = 9008,
		zf_lv = 1,
		cnt_limit = 1,
		type = 8,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,2},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10063,8000}],
		pre_zf = [{9007}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.16}],
		pos_attr_2 = [{be_mag_dam_reduce_coef, 0.16}],
		pos_attr_3 = [{be_mag_dam_reduce_coef, 0.16}],
		pos_attr_4 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08}],
		pos_attr_5 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08}]
};

get(9009) ->
	#zf_cfg{
		no = 9009,
		zf_lv = 1,
		cnt_limit = 1,
		type = 8,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,2},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10063,16000}],
		pre_zf = [{9008}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.18}],
		pos_attr_2 = [{be_mag_dam_reduce_coef, 0.18}],
		pos_attr_3 = [{be_mag_dam_reduce_coef, 0.18}],
		pos_attr_4 = [{do_phy_dam_scaling,0.09}, {do_mag_dam_scaling,0.09}],
		pos_attr_5 = [{do_phy_dam_scaling,0.09}, {do_mag_dam_scaling,0.09}]
};

get(9010) ->
	#zf_cfg{
		no = 9010,
		zf_lv = 1,
		cnt_limit = 1,
		type = 8,
		zf_battle_pos = [{3,3},{3,4},{3,2},{2,2},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10063,30000}],
		pre_zf = [{9009}],
		pos_attr_1 = [{be_mag_dam_reduce_coef, 0.20}],
		pos_attr_2 = [{be_mag_dam_reduce_coef, 0.20}],
		pos_attr_3 = [{be_mag_dam_reduce_coef, 0.20}],
		pos_attr_4 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1}],
		pos_attr_5 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1}]
};

get(10001) ->
	#zf_cfg{
		no = 10001,
		zf_lv = 1,
		cnt_limit = 1,
		type = 9,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10064,1}],
		pre_zf = [],
		pos_attr_1 = [{do_phy_dam_scaling,0.015},{do_mag_dam_scaling,0.015}],
		pos_attr_2 = [{act_speed_rate, 0.015}],
		pos_attr_3 = [{act_speed_rate, 0.015}],
		pos_attr_4 = [{do_phy_dam_scaling,0.01}, {do_mag_dam_scaling,0.01}],
		pos_attr_5 = [{do_phy_dam_scaling,0.01}, {do_mag_dam_scaling,0.01}]
};

get(10002) ->
	#zf_cfg{
		no = 10002,
		zf_lv = 1,
		cnt_limit = 1,
		type = 9,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10064,80}],
		pre_zf = [{10001}],
		pos_attr_1 = [{do_phy_dam_scaling,0.030},{do_mag_dam_scaling,0.030}],
		pos_attr_2 = [{act_speed_rate, 0.030}],
		pos_attr_3 = [{act_speed_rate, 0.030}],
		pos_attr_4 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02}],
		pos_attr_5 = [{do_phy_dam_scaling,0.02}, {do_mag_dam_scaling,0.02}]
};

get(10003) ->
	#zf_cfg{
		no = 10003,
		zf_lv = 1,
		cnt_limit = 1,
		type = 9,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10064,240}],
		pre_zf = [{10002}],
		pos_attr_1 = [{do_phy_dam_scaling,0.045},{do_mag_dam_scaling,0.045}],
		pos_attr_2 = [{act_speed_rate, 0.045}],
		pos_attr_3 = [{act_speed_rate, 0.045}],
		pos_attr_4 = [{do_phy_dam_scaling,0.03}, {do_mag_dam_scaling,0.03}],
		pos_attr_5 = [{do_phy_dam_scaling,0.03}, {do_mag_dam_scaling,0.03}]
};

get(10004) ->
	#zf_cfg{
		no = 10004,
		zf_lv = 1,
		cnt_limit = 1,
		type = 9,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10064,500}],
		pre_zf = [{10003}],
		pos_attr_1 = [{do_phy_dam_scaling,0.060},{do_mag_dam_scaling,0.060}],
		pos_attr_2 = [{act_speed_rate, 0.060}],
		pos_attr_3 = [{act_speed_rate, 0.060}],
		pos_attr_4 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04}],
		pos_attr_5 = [{do_phy_dam_scaling,0.04}, {do_mag_dam_scaling,0.04}]
};

get(10005) ->
	#zf_cfg{
		no = 10005,
		zf_lv = 1,
		cnt_limit = 1,
		type = 9,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10064,1000}],
		pre_zf = [{10004}],
		pos_attr_1 = [{do_phy_dam_scaling,0.075},{do_mag_dam_scaling,0.075}],
		pos_attr_2 = [{act_speed_rate, 0.075}],
		pos_attr_3 = [{act_speed_rate, 0.075}],
		pos_attr_4 = [{do_phy_dam_scaling,0.05}, {do_mag_dam_scaling,0.05}],
		pos_attr_5 = [{do_phy_dam_scaling,0.05}, {do_mag_dam_scaling,0.05}]
};

get(10006) ->
	#zf_cfg{
		no = 10006,
		zf_lv = 1,
		cnt_limit = 1,
		type = 9,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10064,2000}],
		pre_zf = [{10005}],
		pos_attr_1 = [{do_phy_dam_scaling,0.090},{do_mag_dam_scaling,0.090}],
		pos_attr_2 = [{act_speed_rate, 0.090}],
		pos_attr_3 = [{act_speed_rate, 0.090}],
		pos_attr_4 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06}],
		pos_attr_5 = [{do_phy_dam_scaling,0.06}, {do_mag_dam_scaling,0.06}]
};

get(10007) ->
	#zf_cfg{
		no = 10007,
		zf_lv = 1,
		cnt_limit = 1,
		type = 9,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10064,4000}],
		pre_zf = [{10006}],
		pos_attr_1 = [{do_phy_dam_scaling,0.105},{do_mag_dam_scaling,0.105}],
		pos_attr_2 = [{act_speed_rate, 0.105}],
		pos_attr_3 = [{act_speed_rate, 0.105}],
		pos_attr_4 = [{do_phy_dam_scaling,0.07}, {do_mag_dam_scaling,0.07}],
		pos_attr_5 = [{do_phy_dam_scaling,0.07}, {do_mag_dam_scaling,0.07}]
};

get(10008) ->
	#zf_cfg{
		no = 10008,
		zf_lv = 1,
		cnt_limit = 1,
		type = 9,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10064,8000}],
		pre_zf = [{10007}],
		pos_attr_1 = [{do_phy_dam_scaling,0.120},{do_mag_dam_scaling,0.120}],
		pos_attr_2 = [{act_speed_rate, 0.120}],
		pos_attr_3 = [{act_speed_rate, 0.120}],
		pos_attr_4 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08}],
		pos_attr_5 = [{do_phy_dam_scaling,0.08}, {do_mag_dam_scaling,0.08}]
};

get(10009) ->
	#zf_cfg{
		no = 10009,
		zf_lv = 1,
		cnt_limit = 1,
		type = 9,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10064,16000}],
		pre_zf = [{10008}],
		pos_attr_1 = [{do_phy_dam_scaling,0.135},{do_mag_dam_scaling,0.135}],
		pos_attr_2 = [{act_speed_rate, 0.135}],
		pos_attr_3 = [{act_speed_rate, 0.135}],
		pos_attr_4 = [{do_phy_dam_scaling,0.09}, {do_mag_dam_scaling,0.09}],
		pos_attr_5 = [{do_phy_dam_scaling,0.09}, {do_mag_dam_scaling,0.09}]
};

get(10010) ->
	#zf_cfg{
		no = 10010,
		zf_lv = 1,
		cnt_limit = 1,
		type = 9,
		zf_battle_pos = [{3,3},{2,4},{2,2},{2,3},{4,3},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10064,30000}],
		pre_zf = [{10009}],
		pos_attr_1 = [{do_phy_dam_scaling,0.150},{do_mag_dam_scaling,0.150}],
		pos_attr_2 = [{act_speed_rate, 0.150}],
		pos_attr_3 = [{act_speed_rate, 0.150}],
		pos_attr_4 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1}],
		pos_attr_5 = [{do_phy_dam_scaling,0.1}, {do_mag_dam_scaling,0.1}]
};

get(11001) ->
	#zf_cfg{
		no = 11001,
		zf_lv = 1,
		cnt_limit = 1,
		type = 10,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10059,1}],
		pre_zf = [],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.04}, {be_mag_dam_reduce_coef, 0.04},{act_speed_rate, -0.03}],
		pos_attr_2 = [{do_phy_dam_scaling,0.015},{do_mag_dam_scaling,0.015}],
		pos_attr_3 = [{do_phy_dam_scaling,0.015},{do_mag_dam_scaling,0.015}],
		pos_attr_4 = [{act_speed_rate, 0.01}],
		pos_attr_5 = [{act_speed_rate, 0.01}]
};

get(11002) ->
	#zf_cfg{
		no = 11002,
		zf_lv = 1,
		cnt_limit = 1,
		type = 10,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10059,80}],
		pre_zf = [{11001}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.08}, {be_mag_dam_reduce_coef, 0.08},{act_speed_rate, -0.06}],
		pos_attr_2 = [{do_phy_dam_scaling,0.030},{do_mag_dam_scaling,0.030}],
		pos_attr_3 = [{do_phy_dam_scaling,0.030},{do_mag_dam_scaling,0.030}],
		pos_attr_4 = [{act_speed_rate, 0.02}],
		pos_attr_5 = [{act_speed_rate, 0.02}]
};

get(11003) ->
	#zf_cfg{
		no = 11003,
		zf_lv = 1,
		cnt_limit = 1,
		type = 10,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10059,240}],
		pre_zf = [{11002}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.12}, {be_mag_dam_reduce_coef, 0.12},{act_speed_rate, -0.09}],
		pos_attr_2 = [{do_phy_dam_scaling,0.045},{do_mag_dam_scaling,0.045}],
		pos_attr_3 = [{do_phy_dam_scaling,0.045},{do_mag_dam_scaling,0.045}],
		pos_attr_4 = [{act_speed_rate, 0.03}],
		pos_attr_5 = [{act_speed_rate, 0.03}]
};

get(11004) ->
	#zf_cfg{
		no = 11004,
		zf_lv = 1,
		cnt_limit = 1,
		type = 10,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10059,500}],
		pre_zf = [{11003}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.16}, {be_mag_dam_reduce_coef, 0.16},{act_speed_rate, -0.12}],
		pos_attr_2 = [{do_phy_dam_scaling,0.060},{do_mag_dam_scaling,0.060}],
		pos_attr_3 = [{do_phy_dam_scaling,0.060},{do_mag_dam_scaling,0.060}],
		pos_attr_4 = [{act_speed_rate, 0.04}],
		pos_attr_5 = [{act_speed_rate, 0.04}]
};

get(11005) ->
	#zf_cfg{
		no = 11005,
		zf_lv = 1,
		cnt_limit = 1,
		type = 10,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10059,1000}],
		pre_zf = [{11004}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.20}, {be_mag_dam_reduce_coef, 0.20},{act_speed_rate, -0.15}],
		pos_attr_2 = [{do_phy_dam_scaling,0.075},{do_mag_dam_scaling,0.075}],
		pos_attr_3 = [{do_phy_dam_scaling,0.075},{do_mag_dam_scaling,0.075}],
		pos_attr_4 = [{act_speed_rate, 0.05}],
		pos_attr_5 = [{act_speed_rate, 0.05}]
};

get(11006) ->
	#zf_cfg{
		no = 11006,
		zf_lv = 1,
		cnt_limit = 1,
		type = 10,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10059,2000}],
		pre_zf = [{11005}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.24}, {be_mag_dam_reduce_coef, 0.24},{act_speed_rate, -0.18}],
		pos_attr_2 = [{do_phy_dam_scaling,0.090},{do_mag_dam_scaling,0.090}],
		pos_attr_3 = [{do_phy_dam_scaling,0.090},{do_mag_dam_scaling,0.090}],
		pos_attr_4 = [{act_speed_rate, 0.06}],
		pos_attr_5 = [{act_speed_rate, 0.06}]
};

get(11007) ->
	#zf_cfg{
		no = 11007,
		zf_lv = 1,
		cnt_limit = 1,
		type = 10,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10059,4000}],
		pre_zf = [{11006}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.28}, {be_mag_dam_reduce_coef, 0.28},{act_speed_rate, -0.21}],
		pos_attr_2 = [{do_phy_dam_scaling,0.105},{do_mag_dam_scaling,0.105}],
		pos_attr_3 = [{do_phy_dam_scaling,0.105},{do_mag_dam_scaling,0.105}],
		pos_attr_4 = [{act_speed_rate, 0.07}],
		pos_attr_5 = [{act_speed_rate, 0.07}]
};

get(11008) ->
	#zf_cfg{
		no = 11008,
		zf_lv = 1,
		cnt_limit = 1,
		type = 10,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10059,8000}],
		pre_zf = [{11007}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.32}, {be_mag_dam_reduce_coef, 0.32},{act_speed_rate, -0.24}],
		pos_attr_2 = [{do_phy_dam_scaling,0.120},{do_mag_dam_scaling,0.120}],
		pos_attr_3 = [{do_phy_dam_scaling,0.120},{do_mag_dam_scaling,0.120}],
		pos_attr_4 = [{act_speed_rate, 0.08}],
		pos_attr_5 = [{act_speed_rate, 0.08}]
};

get(11009) ->
	#zf_cfg{
		no = 11009,
		zf_lv = 1,
		cnt_limit = 1,
		type = 10,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10059,16000}],
		pre_zf = [{11008}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.36}, {be_mag_dam_reduce_coef, 0.36},{act_speed_rate, -0.27}],
		pos_attr_2 = [{do_phy_dam_scaling,0.135},{do_mag_dam_scaling,0.135}],
		pos_attr_3 = [{do_phy_dam_scaling,0.135},{do_mag_dam_scaling,0.135}],
		pos_attr_4 = [{act_speed_rate, 0.09}],
		pos_attr_5 = [{act_speed_rate, 0.09}]
};

get(11010) ->
	#zf_cfg{
		no = 11010,
		zf_lv = 1,
		cnt_limit = 1,
		type = 10,
		zf_battle_pos = [{4,3},{3,4},{3,2},{2,4},{2,2},{1,3},{1,4},{1,2},{1,5},{1,1}],
		zf_goods = [{10059,30000}],
		pre_zf = [{11009}],
		pos_attr_1 = [{be_phy_dam_reduce_coef, 0.40}, {be_mag_dam_reduce_coef, 0.40},{act_speed_rate, -0.30}],
		pos_attr_2 = [{do_phy_dam_scaling,0.150},{do_mag_dam_scaling,0.150}],
		pos_attr_3 = [{do_phy_dam_scaling,0.150},{do_mag_dam_scaling,0.150}],
		pos_attr_4 = [{act_speed_rate, 0.10}],
		pos_attr_5 = [{act_speed_rate, 0.10}]
};

get(_) ->
          null.

