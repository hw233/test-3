%%%---------------------------------------
%%% @Module  : data_partner_awake
%%% @Author  : zjy
%%% @Email   : 
%%% @Description: 宠物觉醒
%%%---------------------------------------


-module(data_partner_awake).
-export([get/1, get_nos/0]).
-include("partner.hrl").
-include("debug.hrl").

get(1) ->
	#partner_awake{
		no = 1,
		par_no = 1020,
		awake_lv = 1,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55109,3}],
		attrs = [{hp_lim,573008,0},{phy_def,0,0.05}],
		skills = [2201]
};

get(2) ->
	#partner_awake{
		no = 2,
		par_no = 1020,
		awake_lv = 2,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55109,7}],
		attrs = [{mag_att,57301,0},{act_speed,22920,0}],
		skills = [2202]
};

get(3) ->
	#partner_awake{
		no = 3,
		par_no = 1020,
		awake_lv = 3,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55109,13}],
		attrs = [{hp_lim,573008,0},{mag_def,0,0.05}],
		skills = [2203]
};

get(4) ->
	#partner_awake{
		no = 4,
		par_no = 1020,
		awake_lv = 4,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55109,21}],
		attrs = [{act_speed,22920,0},{be_phy_dam_reduce_coef,0.05,0},{be_mag_dam_reduce_coef,0.05,0}],
		skills = [2204]
};

get(5) ->
	#partner_awake{
		no = 5,
		par_no = 1020,
		awake_lv = 5,
		need_lv1 = 12,
		need_lv2 = 12,
		goods = [{55109,32}],
		attrs = [{phy_ten,127,0},{mag_ten,127,0},{seal_resis,0,0.05}],
		skills = [2205]
};

get(6) ->
	#partner_awake{
		no = 6,
		par_no = 1021,
		awake_lv = 1,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55110,3}],
		attrs = [{phy_att,57301,0},{phy_crit,127,0}],
		skills = [2301]
};

get(7) ->
	#partner_awake{
		no = 7,
		par_no = 1021,
		awake_lv = 2,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55110,7}],
		attrs = [{hp_lim,573008,0},{phy_def,0,0.05}],
		skills = [2302]
};

get(8) ->
	#partner_awake{
		no = 8,
		par_no = 1021,
		awake_lv = 3,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55110,13}],
		attrs = [{phy_att,57301,0},{mag_def,0,0.05}],
		skills = [2303]
};

get(9) ->
	#partner_awake{
		no = 9,
		par_no = 1021,
		awake_lv = 4,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55110,21}],
		attrs = [{do_phy_dam_scaling,0.05,0},{phy_crit,127,0}],
		skills = [2304]
};

get(10) ->
	#partner_awake{
		no = 10,
		par_no = 1021,
		awake_lv = 5,
		need_lv1 = 12,
		need_lv2 = 12,
		goods = [{55110,32}],
		attrs = [{do_phy_dam_scaling,0.05,0},{act_speed,0,0.05}],
		skills = [2305]
};

get(11) ->
	#partner_awake{
		no = 11,
		par_no = 1022,
		awake_lv = 1,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55111,3}],
		attrs = [{mag_att,57301,0},{mag_crit,127,0}],
		skills = [2101]
};

get(12) ->
	#partner_awake{
		no = 12,
		par_no = 1022,
		awake_lv = 2,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55111,7}],
		attrs = [{hp_lim,573008,0},{phy_def,0,0.05}],
		skills = [2102]
};

get(13) ->
	#partner_awake{
		no = 13,
		par_no = 1022,
		awake_lv = 3,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55111,13}],
		attrs = [{mag_att,57301,0},{mag_def,0,0.05}],
		skills = [2103]
};

get(14) ->
	#partner_awake{
		no = 14,
		par_no = 1022,
		awake_lv = 4,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55111,21}],
		attrs = [{do_mag_dam_scaling,0.05,0},{mag_crit,127,0}],
		skills = [2104]
};

get(15) ->
	#partner_awake{
		no = 15,
		par_no = 1022,
		awake_lv = 5,
		need_lv1 = 12,
		need_lv2 = 12,
		goods = [{55111,32}],
		attrs = [{do_mag_dam_scaling,0.05,0},{act_speed,0,0.05}],
		skills = [2105]
};

get(16) ->
	#partner_awake{
		no = 16,
		par_no = 1023,
		awake_lv = 1,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55112,3}],
		attrs = [{mag_att,57301,0},{mag_def,0,0.05}],
		skills = [2401]
};

get(17) ->
	#partner_awake{
		no = 17,
		par_no = 1023,
		awake_lv = 2,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55112,7}],
		attrs = [{hp_lim,573008,0},{phy_def,0,0.05}],
		skills = [2402]
};

get(18) ->
	#partner_awake{
		no = 18,
		par_no = 1023,
		awake_lv = 3,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55112,13}],
		attrs = [{act_speed,22920,0},{be_phy_dam_reduce_coef,0.05,0},{be_mag_dam_reduce_coef,0.05,0}],
		skills = [2403]
};

get(19) ->
	#partner_awake{
		no = 19,
		par_no = 1023,
		awake_lv = 4,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55112,21}],
		attrs = [{act_speed,22920,0},{be_phy_dam_reduce_coef,0.05,0},{be_mag_dam_reduce_coef,0.05,0}],
		skills = [2404]
};

get(20) ->
	#partner_awake{
		no = 20,
		par_no = 1023,
		awake_lv = 5,
		need_lv1 = 12,
		need_lv2 = 12,
		goods = [{55112,32}],
		attrs = [{hp_lim,573008,0},{seal_resis,0,0.05}],
		skills = [2405]
};

get(21) ->
	#partner_awake{
		no = 21,
		par_no = 1024,
		awake_lv = 1,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55113,3}],
		attrs = [{phy_att,57301,0},{phy_crit,127,0}],
		skills = [2001]
};

get(22) ->
	#partner_awake{
		no = 22,
		par_no = 1024,
		awake_lv = 2,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55113,7}],
		attrs = [{hp_lim,573008,0},{phy_def,0,0.05}],
		skills = [2002]
};

get(23) ->
	#partner_awake{
		no = 23,
		par_no = 1024,
		awake_lv = 3,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55113,13}],
		attrs = [{phy_att,57301,0},{mag_def,0,0.05}],
		skills = [2003]
};

get(24) ->
	#partner_awake{
		no = 24,
		par_no = 1024,
		awake_lv = 4,
		need_lv1 = 6,
		need_lv2 = 6,
		goods = [{55113,21}],
		attrs = [{do_phy_dam_scaling,0.05,0},{phy_combo_att_proba,125,0}],
		skills = [2004]
};

get(25) ->
	#partner_awake{
		no = 25,
		par_no = 1024,
		awake_lv = 5,
		need_lv1 = 12,
		need_lv2 = 12,
		goods = [{55113,32}],
		attrs = [{do_phy_dam_scaling,0.05,0},{act_speed,0,0.05}],
		skills = [2005]
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

get_nos()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25].

