%%%---------------------------------------
%%% @Module  : data_passi_eff
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 被动技能的效果
%%%---------------------------------------


-module(data_passi_eff).
-export([get/1]).
-include("effect.hrl").
-include("debug.hrl").

get(1001) ->
	#passi_eff{
		no = 1001,
		name = add_buff,
		op = 3,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 207,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1002) ->
	#passi_eff{
		no = 1002,
		name = add_anger,
		op = 3,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 30,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2001) ->
	#passi_eff{
		no = 2001,
		name = add_pursue_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2002) ->
	#passi_eff{
		no = 2002,
		name = add_max_pursue_att_times,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2003) ->
	#passi_eff{
		no = 2003,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2001,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2004) ->
	#passi_eff{
		no = 2004,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2002,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2005) ->
	#passi_eff{
		no = 2005,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2004,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2006) ->
	#passi_eff{
		no = 2006,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2006,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2101) ->
	#passi_eff{
		no = 2101,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2101,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2102) ->
	#passi_eff{
		no = 2102,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2102,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2103) ->
	#passi_eff{
		no = 2103,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2103,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2104) ->
	#passi_eff{
		no = 2104,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2105,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2105) ->
	#passi_eff{
		no = 2105,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2107,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2106) ->
	#passi_eff{
		no = 2106,
		name = add_buff_begin_enemy_survival,
		op = 3,
		rules_filter_target = [enemy_side,undead],
		rules_sort_target = [],
		target_count = 10,
		para = 2108,
		para2 = 1000,
		para3 = 1,
		para4 = 1,
		para5 = 1,
		para6 = 0,
		battle_power_coef = 0
};

get(2201) ->
	#passi_eff{
		no = 2201,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2201,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2202) ->
	#passi_eff{
		no = 2202,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2203,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2203) ->
	#passi_eff{
		no = 2203,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2204,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2204) ->
	#passi_eff{
		no = 2204,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2205,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2205) ->
	#passi_eff{
		no = 2205,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2206,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2206) ->
	#passi_eff{
		no = 2206,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2207,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2301) ->
	#passi_eff{
		no = 2301,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2301,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2302) ->
	#passi_eff{
		no = 2302,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2302,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2303) ->
	#passi_eff{
		no = 2303,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2305,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2304) ->
	#passi_eff{
		no = 2304,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2307,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2305) ->
	#passi_eff{
		no = 2305,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2310,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2306) ->
	#passi_eff{
		no = 2306,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2311,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2401) ->
	#passi_eff{
		no = 2401,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2401,
		para2 = 250,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2402) ->
	#passi_eff{
		no = 2402,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2402,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2403) ->
	#passi_eff{
		no = 2403,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [enemy_side, undead, is_not_boss],
		rules_sort_target = [],
		target_count = 1,
		para = 2404,
		para2 = 400,
		para3 = null,
		para4 = 99,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2404) ->
	#passi_eff{
		no = 2404,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2405,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2405) ->
	#passi_eff{
		no = 2405,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2408,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2406) ->
	#passi_eff{
		no = 2406,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2409,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2407) ->
	#passi_eff{
		no = 2407,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2410,
		para2 = 400,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10001) ->
	#passi_eff{
		no = 10001,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2215,
		para2 = 42000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10002) ->
	#passi_eff{
		no = 10002,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 222,
		para2 = 4200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10003) ->
	#passi_eff{
		no = 10003,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 222,
		para2 = 4200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10004) ->
	#passi_eff{
		no = 10004,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 443,
		para2 = 8390,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10005) ->
	#passi_eff{
		no = 10005,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 443,
		para2 = 8390,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10006) ->
	#passi_eff{
		no = 10006,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 89,
		para2 = 1680,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10007) ->
	#passi_eff{
		no = 10007,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 111,
		para2 = 2100,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10008) ->
	#passi_eff{
		no = 10008,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 230,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10009) ->
	#passi_eff{
		no = 10009,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 230,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10010) ->
	#passi_eff{
		no = 10010,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 340,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10011) ->
	#passi_eff{
		no = 10011,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 340,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10012) ->
	#passi_eff{
		no = 10012,
		name = hot_hp,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 831,
		para2 = 15700,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10013) ->
	#passi_eff{
		no = 10013,
		name = add_strikeback_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 120,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10014) ->
	#passi_eff{
		no = 10014,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10015) ->
	#passi_eff{
		no = 10015,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10016) ->
	#passi_eff{
		no = 10016,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10017) ->
	#passi_eff{
		no = 10017,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10018) ->
	#passi_eff{
		no = 10018,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.080000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10019) ->
	#passi_eff{
		no = 10019,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10020) ->
	#passi_eff{
		no = 10020,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10021) ->
	#passi_eff{
		no = 10021,
		name = add_be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.080000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10022) ->
	#passi_eff{
		no = 10022,
		name = add_be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.080000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10023) ->
	#passi_eff{
		no = 10023,
		name = add_phy_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10024) ->
	#passi_eff{
		no = 10024,
		name = add_mag_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10025) ->
	#passi_eff{
		no = 10025,
		name = add_pursue_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 230,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10026) ->
	#passi_eff{
		no = 10026,
		name = add_max_pursue_att_times,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10027) ->
	#passi_eff{
		no = 10027,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10001,
		para2 = 250,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10028) ->
	#passi_eff{
		no = 10028,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10002,
		para2 = 250,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10099) ->
	#passi_eff{
		no = 10099,
		name = die_trriger_support,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 1,
		para = 999,
		para2 = 300,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10101) ->
	#passi_eff{
		no = 10101,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3544,
		para2 = 67200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10102) ->
	#passi_eff{
		no = 10102,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 354,
		para2 = 6720,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10103) ->
	#passi_eff{
		no = 10103,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 354,
		para2 = 6720,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10104) ->
	#passi_eff{
		no = 10104,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 709,
		para2 = 13430,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10105) ->
	#passi_eff{
		no = 10105,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 709,
		para2 = 13430,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10106) ->
	#passi_eff{
		no = 10106,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 142,
		para2 = 2690,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10107) ->
	#passi_eff{
		no = 10107,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 177,
		para2 = 3360,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10108) ->
	#passi_eff{
		no = 10108,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 360,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10109) ->
	#passi_eff{
		no = 10109,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 360,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10110) ->
	#passi_eff{
		no = 10110,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 540,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10111) ->
	#passi_eff{
		no = 10111,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 540,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10112) ->
	#passi_eff{
		no = 10112,
		name = hot_hp,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1329,
		para2 = 25200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10113) ->
	#passi_eff{
		no = 10113,
		name = add_strikeback_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 190,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10114) ->
	#passi_eff{
		no = 10114,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10115) ->
	#passi_eff{
		no = 10115,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10116) ->
	#passi_eff{
		no = 10116,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 220,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10117) ->
	#passi_eff{
		no = 10117,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10118) ->
	#passi_eff{
		no = 10118,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10119) ->
	#passi_eff{
		no = 10119,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10120) ->
	#passi_eff{
		no = 10120,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10121) ->
	#passi_eff{
		no = 10121,
		name = add_be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.130000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10122) ->
	#passi_eff{
		no = 10122,
		name = add_be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.130000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10123) ->
	#passi_eff{
		no = 10123,
		name = add_phy_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10124) ->
	#passi_eff{
		no = 10124,
		name = add_mag_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 320,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10125) ->
	#passi_eff{
		no = 10125,
		name = add_pursue_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 370,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10126) ->
	#passi_eff{
		no = 10126,
		name = add_max_pursue_att_times,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10127) ->
	#passi_eff{
		no = 10127,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10101,
		para2 = 400,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10128) ->
	#passi_eff{
		no = 10128,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10102,
		para2 = 400,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10199) ->
	#passi_eff{
		no = 10199,
		name = die_trriger_support,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 1,
		para = 999,
		para2 = 500,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10201) ->
	#passi_eff{
		no = 10201,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 5671,
		para2 = 107400,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10202) ->
	#passi_eff{
		no = 10202,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 567,
		para2 = 10740,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10203) ->
	#passi_eff{
		no = 10203,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 567,
		para2 = 10740,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10204) ->
	#passi_eff{
		no = 10204,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1134,
		para2 = 21490,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10205) ->
	#passi_eff{
		no = 10205,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1134,
		para2 = 21490,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10206) ->
	#passi_eff{
		no = 10206,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 227,
		para2 = 4300,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10207) ->
	#passi_eff{
		no = 10207,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 284,
		para2 = 5370,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10208) ->
	#passi_eff{
		no = 10208,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 580,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10209) ->
	#passi_eff{
		no = 10209,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 580,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10210) ->
	#passi_eff{
		no = 10210,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 870,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10211) ->
	#passi_eff{
		no = 10211,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 870,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10212) ->
	#passi_eff{
		no = 10212,
		name = hot_hp,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2126,
		para2 = 40300,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10213) ->
	#passi_eff{
		no = 10213,
		name = add_strikeback_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10214) ->
	#passi_eff{
		no = 10214,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10215) ->
	#passi_eff{
		no = 10215,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10216) ->
	#passi_eff{
		no = 10216,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 350,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10217) ->
	#passi_eff{
		no = 10217,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.175000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10218) ->
	#passi_eff{
		no = 10218,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10219) ->
	#passi_eff{
		no = 10219,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10220) ->
	#passi_eff{
		no = 10220,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10221) ->
	#passi_eff{
		no = 10221,
		name = add_be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.210000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10222) ->
	#passi_eff{
		no = 10222,
		name = add_be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.210000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10223) ->
	#passi_eff{
		no = 10223,
		name = add_phy_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 640,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10224) ->
	#passi_eff{
		no = 10224,
		name = add_mag_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 520,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10225) ->
	#passi_eff{
		no = 10225,
		name = add_pursue_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 590,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10226) ->
	#passi_eff{
		no = 10226,
		name = add_max_pursue_att_times,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10227) ->
	#passi_eff{
		no = 10227,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10201,
		para2 = 650,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10228) ->
	#passi_eff{
		no = 10228,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10202,
		para2 = 650,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10229) ->
	#passi_eff{
		no = 10229,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10207,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10230) ->
	#passi_eff{
		no = 10230,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10208,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10231) ->
	#passi_eff{
		no = 10231,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10210,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10232) ->
	#passi_eff{
		no = 10232,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10211,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10233) ->
	#passi_eff{
		no = 10233,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10212,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10234) ->
	#passi_eff{
		no = 10234,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10213,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10235) ->
	#passi_eff{
		no = 10235,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10214,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10236) ->
	#passi_eff{
		no = 10236,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10218,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10237) ->
	#passi_eff{
		no = 10237,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10219,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10238) ->
	#passi_eff{
		no = 10238,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10220,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10239) ->
	#passi_eff{
		no = 10239,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10221,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10240) ->
	#passi_eff{
		no = 10240,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 450,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10241) ->
	#passi_eff{
		no = 10241,
		name = reduce_strikeback_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 450,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10242) ->
	#passi_eff{
		no = 10242,
		name = reduce_dam_by_rate_base_hp_lim,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.080000,
		para2 = 350,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10243) ->
	#passi_eff{
		no = 10243,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 10225,
		para2 = 1000,
		para3 = 300,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10244) ->
	#passi_eff{
		no = 10244,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 10226,
		para2 = 1000,
		para3 = 300,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10301) ->
	#passi_eff{
		no = 10301,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 10301,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10302) ->
	#passi_eff{
		no = 10302,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [enemy_side,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 10302,
		para2 = 1000,
		para3 = null,
		para4 = 99,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10303) ->
	#passi_eff{
		no = 10303,
		name = add_buff_action_friend_survival,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [sort_by_hp_asce],
		target_count = 3,
		para = 10303,
		para2 = 1000,
		para3 = 1,
		para4 = 99,
		para5 = 1,
		para6 = 2,
		battle_power_coef = 0
};

get(10304) ->
	#passi_eff{
		no = 10304,
		name = add_buff_on_be_att_hit,
		op = 3,
		rules_filter_target = [],
		rules_sort_target = [sort_by_hp_asce],
		target_count = 1,
		para = 10304,
		para2 = 1000,
		para3 = ally_side,
		para4 = 99,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10305) ->
	#passi_eff{
		no = 10305,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10305,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10306) ->
	#passi_eff{
		no = 10306,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10307,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10307) ->
	#passi_eff{
		no = 10307,
		name = add_buff_action_friend_survival,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 10308,
		para2 = 1000,
		para3 = 1,
		para4 = 99,
		para5 = 1,
		para6 = 1,
		battle_power_coef = 0
};

get(10308) ->
	#passi_eff{
		no = 10308,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10309,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10309) ->
	#passi_eff{
		no = 10309,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10310,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10310) ->
	#passi_eff{
		no = 10310,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10311,
		para2 = 400,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10311) ->
	#passi_eff{
		no = 10311,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10312,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10312) ->
	#passi_eff{
		no = 10312,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10313,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(10313) ->
	#passi_eff{
		no = 10313,
		name = add_buff_on_att_hit,
		op = 3,
		rules_filter_target = [no_act_bo],
		rules_sort_target = [],
		target_count = 10,
		para = 10315,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13001) ->
	#passi_eff{
		no = 13001,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13201,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13002) ->
	#passi_eff{
		no = 13002,
		name = add_buff_on_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13202,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13003) ->
	#passi_eff{
		no = 13003,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13203,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13004) ->
	#passi_eff{
		no = 13004,
		name = add_buff_on_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13204,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13005) ->
	#passi_eff{
		no = 13005,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13230,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13006) ->
	#passi_eff{
		no = 13006,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13231,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13007) ->
	#passi_eff{
		no = 13007,
		name = add_buff_action_friend_survival,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13207,
		para2 = 1000,
		para3 = 7,
		para4 = 2,
		para5 = 1,
		para6 = 1,
		battle_power_coef = 0
};

get(13008) ->
	#passi_eff{
		no = 13008,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13208,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13009) ->
	#passi_eff{
		no = 13009,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13210,
		para2 = 250,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13010) ->
	#passi_eff{
		no = 13010,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13232,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13011) ->
	#passi_eff{
		no = 13011,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13233,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13012) ->
	#passi_eff{
		no = 13012,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13213,
		para2 = 1000,
		para3 = 200,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13013) ->
	#passi_eff{
		no = 13013,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13214,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13014) ->
	#passi_eff{
		no = 13014,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.006000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13015) ->
	#passi_eff{
		no = 13015,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13215,
		para2 = 300,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13016) ->
	#passi_eff{
		no = 13016,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13216,
		para2 = 200,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13017) ->
	#passi_eff{
		no = 13017,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13217,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13018) ->
	#passi_eff{
		no = 13018,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13218,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13019) ->
	#passi_eff{
		no = 13019,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13219,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13020) ->
	#passi_eff{
		no = 13020,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13221,
		para2 = 16,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13021) ->
	#passi_eff{
		no = 13021,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13222,
		para2 = 34,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13022) ->
	#passi_eff{
		no = 13022,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13223,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13023) ->
	#passi_eff{
		no = 13023,
		name = add_anger,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 20,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13024) ->
	#passi_eff{
		no = 13024,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13225,
		para2 = 80,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13025) ->
	#passi_eff{
		no = 13025,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13227,
		para2 = 94,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13026) ->
	#passi_eff{
		no = 13026,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13234,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13101) ->
	#passi_eff{
		no = 13101,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13301,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13102) ->
	#passi_eff{
		no = 13102,
		name = add_buff_on_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13302,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13103) ->
	#passi_eff{
		no = 13103,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13303,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13104) ->
	#passi_eff{
		no = 13104,
		name = add_buff_on_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13304,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13105) ->
	#passi_eff{
		no = 13105,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13330,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13106) ->
	#passi_eff{
		no = 13106,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13331,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13107) ->
	#passi_eff{
		no = 13107,
		name = add_buff_action_friend_survival,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13307,
		para2 = 1000,
		para3 = 7,
		para4 = 2,
		para5 = 1,
		para6 = 1,
		battle_power_coef = 0
};

get(13108) ->
	#passi_eff{
		no = 13108,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13308,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13109) ->
	#passi_eff{
		no = 13109,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13310,
		para2 = 250,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13110) ->
	#passi_eff{
		no = 13110,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13332,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13111) ->
	#passi_eff{
		no = 13111,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13333,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13112) ->
	#passi_eff{
		no = 13112,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13313,
		para2 = 1000,
		para3 = 200,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13113) ->
	#passi_eff{
		no = 13113,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13314,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13114) ->
	#passi_eff{
		no = 13114,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.010000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13115) ->
	#passi_eff{
		no = 13115,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13315,
		para2 = 300,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13116) ->
	#passi_eff{
		no = 13116,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13316,
		para2 = 200,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13117) ->
	#passi_eff{
		no = 13117,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13317,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13118) ->
	#passi_eff{
		no = 13118,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13318,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13119) ->
	#passi_eff{
		no = 13119,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13319,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13120) ->
	#passi_eff{
		no = 13120,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13321,
		para2 = 24,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13121) ->
	#passi_eff{
		no = 13121,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13322,
		para2 = 52,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13122) ->
	#passi_eff{
		no = 13122,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13323,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13123) ->
	#passi_eff{
		no = 13123,
		name = add_anger,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 35,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13124) ->
	#passi_eff{
		no = 13124,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13325,
		para2 = 120,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13125) ->
	#passi_eff{
		no = 13125,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13327,
		para2 = 140,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13126) ->
	#passi_eff{
		no = 13126,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13334,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13201) ->
	#passi_eff{
		no = 13201,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13401,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13202) ->
	#passi_eff{
		no = 13202,
		name = add_buff_on_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13402,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13203) ->
	#passi_eff{
		no = 13203,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13403,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13204) ->
	#passi_eff{
		no = 13204,
		name = add_buff_on_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13404,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13205) ->
	#passi_eff{
		no = 13205,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13431,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13206) ->
	#passi_eff{
		no = 13206,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13432,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13207) ->
	#passi_eff{
		no = 13207,
		name = add_buff_action_friend_survival,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13407,
		para2 = 1000,
		para3 = 7,
		para4 = 2,
		para5 = 1,
		para6 = 1,
		battle_power_coef = 0
};

get(13208) ->
	#passi_eff{
		no = 13208,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13408,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13209) ->
	#passi_eff{
		no = 13209,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13410,
		para2 = 250,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13210) ->
	#passi_eff{
		no = 13210,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13433,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13211) ->
	#passi_eff{
		no = 13211,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13434,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13212) ->
	#passi_eff{
		no = 13212,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13413,
		para2 = 1000,
		para3 = 200,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13213) ->
	#passi_eff{
		no = 13213,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13414,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13214) ->
	#passi_eff{
		no = 13214,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.016000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13215) ->
	#passi_eff{
		no = 13215,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13415,
		para2 = 300,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13216) ->
	#passi_eff{
		no = 13216,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13416,
		para2 = 200,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13217) ->
	#passi_eff{
		no = 13217,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13417,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13218) ->
	#passi_eff{
		no = 13218,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13418,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13219) ->
	#passi_eff{
		no = 13219,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13419,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13220) ->
	#passi_eff{
		no = 13220,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13421,
		para2 = 40,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13221) ->
	#passi_eff{
		no = 13221,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13422,
		para2 = 86,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13222) ->
	#passi_eff{
		no = 13222,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13423,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13223) ->
	#passi_eff{
		no = 13223,
		name = add_anger,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13224) ->
	#passi_eff{
		no = 13224,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13425,
		para2 = 200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13225) ->
	#passi_eff{
		no = 13225,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13427,
		para2 = 234,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13226) ->
	#passi_eff{
		no = 13226,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13435,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13227) ->
	#passi_eff{
		no = 13227,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13430,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13301) ->
	#passi_eff{
		no = 13301,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13501,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13302) ->
	#passi_eff{
		no = 13302,
		name = add_buff_on_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13502,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13303) ->
	#passi_eff{
		no = 13303,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13503,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13304) ->
	#passi_eff{
		no = 13304,
		name = add_buff_on_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13504,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13305) ->
	#passi_eff{
		no = 13305,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13531,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13306) ->
	#passi_eff{
		no = 13306,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13532,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13307) ->
	#passi_eff{
		no = 13307,
		name = add_buff_action_friend_survival,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13507,
		para2 = 1000,
		para3 = 7,
		para4 = 2,
		para5 = 1,
		para6 = 1,
		battle_power_coef = 0
};

get(13308) ->
	#passi_eff{
		no = 13308,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13508,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13309) ->
	#passi_eff{
		no = 13309,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13510,
		para2 = 250,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13310) ->
	#passi_eff{
		no = 13310,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13533,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13311) ->
	#passi_eff{
		no = 13311,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13534,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13312) ->
	#passi_eff{
		no = 13312,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13513,
		para2 = 1000,
		para3 = 200,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13313) ->
	#passi_eff{
		no = 13313,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13514,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13314) ->
	#passi_eff{
		no = 13314,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13315) ->
	#passi_eff{
		no = 13315,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13515,
		para2 = 300,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13316) ->
	#passi_eff{
		no = 13316,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13516,
		para2 = 200,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13317) ->
	#passi_eff{
		no = 13317,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13517,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13318) ->
	#passi_eff{
		no = 13318,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13518,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13319) ->
	#passi_eff{
		no = 13319,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13519,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13320) ->
	#passi_eff{
		no = 13320,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13521,
		para2 = 60,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13321) ->
	#passi_eff{
		no = 13321,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13522,
		para2 = 130,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13322) ->
	#passi_eff{
		no = 13322,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13523,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13323) ->
	#passi_eff{
		no = 13323,
		name = add_anger,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13324) ->
	#passi_eff{
		no = 13324,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13525,
		para2 = 300,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13325) ->
	#passi_eff{
		no = 13325,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13527,
		para2 = 350,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13326) ->
	#passi_eff{
		no = 13326,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13535,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(13327) ->
	#passi_eff{
		no = 13327,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13530,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14001) ->
	#passi_eff{
		no = 14001,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14001,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14002) ->
	#passi_eff{
		no = 14002,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14003,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14003) ->
	#passi_eff{
		no = 14003,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14005,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14004) ->
	#passi_eff{
		no = 14004,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14007,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14005) ->
	#passi_eff{
		no = 14005,
		name = add_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.034000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14006) ->
	#passi_eff{
		no = 14006,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14008,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14007) ->
	#passi_eff{
		no = 14007,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14009,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14008) ->
	#passi_eff{
		no = 14008,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.034000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14009) ->
	#passi_eff{
		no = 14009,
		name = add_mag_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.034000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14010) ->
	#passi_eff{
		no = 14010,
		name = reduce_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.020000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14011) ->
	#passi_eff{
		no = 14011,
		name = add_phy_att_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.044000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14012) ->
	#passi_eff{
		no = 14012,
		name = add_mag_att_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.044000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14013) ->
	#passi_eff{
		no = 14013,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14014,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14014) ->
	#passi_eff{
		no = 14014,
		name = reduce_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.020000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14015) ->
	#passi_eff{
		no = 14015,
		name = add_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.044000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14016) ->
	#passi_eff{
		no = 14016,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14016,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14017) ->
	#passi_eff{
		no = 14017,
		name = add_gem_attr_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.056000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14018) ->
	#passi_eff{
		no = 14018,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.034000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14019) ->
	#passi_eff{
		no = 14019,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.034000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14020) ->
	#passi_eff{
		no = 14020,
		name = be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.044000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14021) ->
	#passi_eff{
		no = 14021,
		name = be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.044000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14022) ->
	#passi_eff{
		no = 14022,
		name = add_phy_crit_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 34,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14023) ->
	#passi_eff{
		no = 14023,
		name = add_mag_crit_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 34,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14024) ->
	#passi_eff{
		no = 14024,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 90,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14025) ->
	#passi_eff{
		no = 14025,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 90,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14026) ->
	#passi_eff{
		no = 14026,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 134,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14027) ->
	#passi_eff{
		no = 14027,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 134,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14028) ->
	#passi_eff{
		no = 14028,
		name = add_seal_hit_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.034000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14029) ->
	#passi_eff{
		no = 14029,
		name = add_seal_resis_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.034000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14030) ->
	#passi_eff{
		no = 14030,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.066000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14031) ->
	#passi_eff{
		no = 14031,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 220,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14032) ->
	#passi_eff{
		no = 14032,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 220,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14033) ->
	#passi_eff{
		no = 14033,
		name = add_neglect_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 220,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14034) ->
	#passi_eff{
		no = 14034,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14035) ->
	#passi_eff{
		no = 14035,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.056000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14036) ->
	#passi_eff{
		no = 14036,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14037) ->
	#passi_eff{
		no = 14037,
		name = recover_self_anger_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.022000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14038) ->
	#passi_eff{
		no = 14038,
		name = add_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.034000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14039) ->
	#passi_eff{
		no = 14039,
		name = reduce_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.044000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14101) ->
	#passi_eff{
		no = 14101,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14101,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14102) ->
	#passi_eff{
		no = 14102,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14103,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14103) ->
	#passi_eff{
		no = 14103,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14105,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14104) ->
	#passi_eff{
		no = 14104,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14107,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14105) ->
	#passi_eff{
		no = 14105,
		name = add_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.046000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14106) ->
	#passi_eff{
		no = 14106,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14108,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14107) ->
	#passi_eff{
		no = 14107,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14109,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14108) ->
	#passi_eff{
		no = 14108,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.046000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14109) ->
	#passi_eff{
		no = 14109,
		name = add_mag_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.046000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14110) ->
	#passi_eff{
		no = 14110,
		name = reduce_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14111) ->
	#passi_eff{
		no = 14111,
		name = add_phy_att_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14112) ->
	#passi_eff{
		no = 14112,
		name = add_mag_att_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14113) ->
	#passi_eff{
		no = 14113,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14114,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14114) ->
	#passi_eff{
		no = 14114,
		name = reduce_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14115) ->
	#passi_eff{
		no = 14115,
		name = add_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14116) ->
	#passi_eff{
		no = 14116,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14116,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14117) ->
	#passi_eff{
		no = 14117,
		name = add_gem_attr_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.076000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14118) ->
	#passi_eff{
		no = 14118,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.046000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14119) ->
	#passi_eff{
		no = 14119,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.046000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14120) ->
	#passi_eff{
		no = 14120,
		name = be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14121) ->
	#passi_eff{
		no = 14121,
		name = be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14122) ->
	#passi_eff{
		no = 14122,
		name = add_phy_crit_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 46,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14123) ->
	#passi_eff{
		no = 14123,
		name = add_mag_crit_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 46,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14124) ->
	#passi_eff{
		no = 14124,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 120,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14125) ->
	#passi_eff{
		no = 14125,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 120,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14126) ->
	#passi_eff{
		no = 14126,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 180,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14127) ->
	#passi_eff{
		no = 14127,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 180,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14128) ->
	#passi_eff{
		no = 14128,
		name = add_seal_hit_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.046000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14129) ->
	#passi_eff{
		no = 14129,
		name = add_seal_resis_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.046000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14130) ->
	#passi_eff{
		no = 14130,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14131) ->
	#passi_eff{
		no = 14131,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14132) ->
	#passi_eff{
		no = 14132,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14133) ->
	#passi_eff{
		no = 14133,
		name = add_neglect_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14134) ->
	#passi_eff{
		no = 14134,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 136,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14135) ->
	#passi_eff{
		no = 14135,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.076000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14136) ->
	#passi_eff{
		no = 14136,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 136,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14137) ->
	#passi_eff{
		no = 14137,
		name = recover_self_anger_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14138) ->
	#passi_eff{
		no = 14138,
		name = add_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.046000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14139) ->
	#passi_eff{
		no = 14139,
		name = reduce_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14201) ->
	#passi_eff{
		no = 14201,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14201,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14202) ->
	#passi_eff{
		no = 14202,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14203,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14203) ->
	#passi_eff{
		no = 14203,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14205,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14204) ->
	#passi_eff{
		no = 14204,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14207,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14205) ->
	#passi_eff{
		no = 14205,
		name = add_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14206) ->
	#passi_eff{
		no = 14206,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14208,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14207) ->
	#passi_eff{
		no = 14207,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14209,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14208) ->
	#passi_eff{
		no = 14208,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14209) ->
	#passi_eff{
		no = 14209,
		name = add_mag_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14210) ->
	#passi_eff{
		no = 14210,
		name = reduce_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.032000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14211) ->
	#passi_eff{
		no = 14211,
		name = add_phy_att_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14212) ->
	#passi_eff{
		no = 14212,
		name = add_mag_att_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14213) ->
	#passi_eff{
		no = 14213,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14214,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14214) ->
	#passi_eff{
		no = 14214,
		name = reduce_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.032000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14215) ->
	#passi_eff{
		no = 14215,
		name = add_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14216) ->
	#passi_eff{
		no = 14216,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14216,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14217) ->
	#passi_eff{
		no = 14217,
		name = add_gem_attr_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.102000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14218) ->
	#passi_eff{
		no = 14218,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14219) ->
	#passi_eff{
		no = 14219,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14220) ->
	#passi_eff{
		no = 14220,
		name = be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14221) ->
	#passi_eff{
		no = 14221,
		name = be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14222) ->
	#passi_eff{
		no = 14222,
		name = add_phy_crit_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14223) ->
	#passi_eff{
		no = 14223,
		name = add_mag_crit_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14224) ->
	#passi_eff{
		no = 14224,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 162,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14225) ->
	#passi_eff{
		no = 14225,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 162,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14226) ->
	#passi_eff{
		no = 14226,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 244,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14227) ->
	#passi_eff{
		no = 14227,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 244,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14228) ->
	#passi_eff{
		no = 14228,
		name = add_seal_hit_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14229) ->
	#passi_eff{
		no = 14229,
		name = add_seal_resis_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14230) ->
	#passi_eff{
		no = 14230,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.122000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14231) ->
	#passi_eff{
		no = 14231,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14232) ->
	#passi_eff{
		no = 14232,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14233) ->
	#passi_eff{
		no = 14233,
		name = add_neglect_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14234) ->
	#passi_eff{
		no = 14234,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 182,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14235) ->
	#passi_eff{
		no = 14235,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.102000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14236) ->
	#passi_eff{
		no = 14236,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 182,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14237) ->
	#passi_eff{
		no = 14237,
		name = recover_self_anger_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14238) ->
	#passi_eff{
		no = 14238,
		name = add_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14239) ->
	#passi_eff{
		no = 14239,
		name = reduce_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14301) ->
	#passi_eff{
		no = 14301,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14301,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14302) ->
	#passi_eff{
		no = 14302,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14303,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14303) ->
	#passi_eff{
		no = 14303,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14305,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14304) ->
	#passi_eff{
		no = 14304,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14307,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14305) ->
	#passi_eff{
		no = 14305,
		name = add_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14306) ->
	#passi_eff{
		no = 14306,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14308,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14307) ->
	#passi_eff{
		no = 14307,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14309,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14308) ->
	#passi_eff{
		no = 14308,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14309) ->
	#passi_eff{
		no = 14309,
		name = add_mag_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14310) ->
	#passi_eff{
		no = 14310,
		name = reduce_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.045000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14311) ->
	#passi_eff{
		no = 14311,
		name = add_phy_att_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14312) ->
	#passi_eff{
		no = 14312,
		name = add_mag_att_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14313) ->
	#passi_eff{
		no = 14313,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14314,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14314) ->
	#passi_eff{
		no = 14314,
		name = reduce_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.045000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14315) ->
	#passi_eff{
		no = 14315,
		name = add_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14316) ->
	#passi_eff{
		no = 14316,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14316,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14317) ->
	#passi_eff{
		no = 14317,
		name = add_gem_attr_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.138000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14318) ->
	#passi_eff{
		no = 14318,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14319) ->
	#passi_eff{
		no = 14319,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14320) ->
	#passi_eff{
		no = 14320,
		name = be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14321) ->
	#passi_eff{
		no = 14321,
		name = be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14322) ->
	#passi_eff{
		no = 14322,
		name = add_phy_crit_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14323) ->
	#passi_eff{
		no = 14323,
		name = add_mag_crit_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14324) ->
	#passi_eff{
		no = 14324,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 220,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14325) ->
	#passi_eff{
		no = 14325,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 220,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14326) ->
	#passi_eff{
		no = 14326,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 330,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14327) ->
	#passi_eff{
		no = 14327,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 330,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14328) ->
	#passi_eff{
		no = 14328,
		name = add_seal_hit_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14329) ->
	#passi_eff{
		no = 14329,
		name = add_seal_resis_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14330) ->
	#passi_eff{
		no = 14330,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.164000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14331) ->
	#passi_eff{
		no = 14331,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 540,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14332) ->
	#passi_eff{
		no = 14332,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 540,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14333) ->
	#passi_eff{
		no = 14333,
		name = add_neglect_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 540,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14334) ->
	#passi_eff{
		no = 14334,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14335) ->
	#passi_eff{
		no = 14335,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.138000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14336) ->
	#passi_eff{
		no = 14336,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14337) ->
	#passi_eff{
		no = 14337,
		name = recover_self_anger_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.054000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14338) ->
	#passi_eff{
		no = 14338,
		name = add_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.082000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14339) ->
	#passi_eff{
		no = 14339,
		name = reduce_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14401) ->
	#passi_eff{
		no = 14401,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14401,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14402) ->
	#passi_eff{
		no = 14402,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14403,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14403) ->
	#passi_eff{
		no = 14403,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14405,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14404) ->
	#passi_eff{
		no = 14404,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14407,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14405) ->
	#passi_eff{
		no = 14405,
		name = add_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.112000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14406) ->
	#passi_eff{
		no = 14406,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14408,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14407) ->
	#passi_eff{
		no = 14407,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14409,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14408) ->
	#passi_eff{
		no = 14408,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.112000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14409) ->
	#passi_eff{
		no = 14409,
		name = add_mag_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.112000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14410) ->
	#passi_eff{
		no = 14410,
		name = reduce_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14411) ->
	#passi_eff{
		no = 14411,
		name = add_phy_att_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.148000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14412) ->
	#passi_eff{
		no = 14412,
		name = add_mag_att_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.148000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14413) ->
	#passi_eff{
		no = 14413,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14414,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14414) ->
	#passi_eff{
		no = 14414,
		name = reduce_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14415) ->
	#passi_eff{
		no = 14415,
		name = add_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.148000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14416) ->
	#passi_eff{
		no = 14416,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14416,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14417) ->
	#passi_eff{
		no = 14417,
		name = add_gem_attr_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.186000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14418) ->
	#passi_eff{
		no = 14418,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.112000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14419) ->
	#passi_eff{
		no = 14419,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.112000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14420) ->
	#passi_eff{
		no = 14420,
		name = be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.148000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14421) ->
	#passi_eff{
		no = 14421,
		name = be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.148000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14422) ->
	#passi_eff{
		no = 14422,
		name = add_phy_crit_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 112,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14423) ->
	#passi_eff{
		no = 14423,
		name = add_mag_crit_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 112,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14424) ->
	#passi_eff{
		no = 14424,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 296,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14425) ->
	#passi_eff{
		no = 14425,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 296,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14426) ->
	#passi_eff{
		no = 14426,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 444,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14427) ->
	#passi_eff{
		no = 14427,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 444,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14428) ->
	#passi_eff{
		no = 14428,
		name = add_seal_hit_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.112000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14429) ->
	#passi_eff{
		no = 14429,
		name = add_seal_resis_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.112000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14430) ->
	#passi_eff{
		no = 14430,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.222000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14431) ->
	#passi_eff{
		no = 14431,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 740,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14432) ->
	#passi_eff{
		no = 14432,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 740,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14433) ->
	#passi_eff{
		no = 14433,
		name = add_neglect_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 740,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14434) ->
	#passi_eff{
		no = 14434,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 334,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14435) ->
	#passi_eff{
		no = 14435,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.186000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14436) ->
	#passi_eff{
		no = 14436,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 334,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14437) ->
	#passi_eff{
		no = 14437,
		name = recover_self_anger_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.074000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14438) ->
	#passi_eff{
		no = 14438,
		name = add_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.112000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14439) ->
	#passi_eff{
		no = 14439,
		name = reduce_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.148000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14501) ->
	#passi_eff{
		no = 14501,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14501,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14502) ->
	#passi_eff{
		no = 14502,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14503,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14503) ->
	#passi_eff{
		no = 14503,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14505,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14504) ->
	#passi_eff{
		no = 14504,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14507,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14505) ->
	#passi_eff{
		no = 14505,
		name = add_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14506) ->
	#passi_eff{
		no = 14506,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14508,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14507) ->
	#passi_eff{
		no = 14507,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14509,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14508) ->
	#passi_eff{
		no = 14508,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14509) ->
	#passi_eff{
		no = 14509,
		name = add_mag_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14510) ->
	#passi_eff{
		no = 14510,
		name = reduce_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.080000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14511) ->
	#passi_eff{
		no = 14511,
		name = add_phy_att_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14512) ->
	#passi_eff{
		no = 14512,
		name = add_mag_att_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14513) ->
	#passi_eff{
		no = 14513,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14514,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14514) ->
	#passi_eff{
		no = 14514,
		name = reduce_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.080000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14515) ->
	#passi_eff{
		no = 14515,
		name = add_hp_lim_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14516) ->
	#passi_eff{
		no = 14516,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14516,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14517) ->
	#passi_eff{
		no = 14517,
		name = add_gem_attr_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14518) ->
	#passi_eff{
		no = 14518,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14519) ->
	#passi_eff{
		no = 14519,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14520) ->
	#passi_eff{
		no = 14520,
		name = be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14521) ->
	#passi_eff{
		no = 14521,
		name = be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14522) ->
	#passi_eff{
		no = 14522,
		name = add_phy_crit_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14523) ->
	#passi_eff{
		no = 14523,
		name = add_mag_crit_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14524) ->
	#passi_eff{
		no = 14524,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14525) ->
	#passi_eff{
		no = 14525,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14526) ->
	#passi_eff{
		no = 14526,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 600,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14527) ->
	#passi_eff{
		no = 14527,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 600,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14528) ->
	#passi_eff{
		no = 14528,
		name = add_seal_hit_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14529) ->
	#passi_eff{
		no = 14529,
		name = add_seal_resis_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14530) ->
	#passi_eff{
		no = 14530,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.300000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14531) ->
	#passi_eff{
		no = 14531,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14532) ->
	#passi_eff{
		no = 14532,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14533) ->
	#passi_eff{
		no = 14533,
		name = add_neglect_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14534) ->
	#passi_eff{
		no = 14534,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 450,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14535) ->
	#passi_eff{
		no = 14535,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14536) ->
	#passi_eff{
		no = 14536,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 450,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14537) ->
	#passi_eff{
		no = 14537,
		name = recover_self_anger_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14538) ->
	#passi_eff{
		no = 14538,
		name = add_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(14539) ->
	#passi_eff{
		no = 14539,
		name = reduce_act_speed_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15001) ->
	#passi_eff{
		no = 15001,
		name = add_phy_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 750,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15002) ->
	#passi_eff{
		no = 15002,
		name = add_phy_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15003) ->
	#passi_eff{
		no = 15003,
		name = add_phy_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1750,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15004) ->
	#passi_eff{
		no = 15004,
		name = add_phy_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15005) ->
	#passi_eff{
		no = 15005,
		name = add_phy_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2750,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15006) ->
	#passi_eff{
		no = 15006,
		name = add_phy_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15007) ->
	#passi_eff{
		no = 15007,
		name = add_phy_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3750,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15008) ->
	#passi_eff{
		no = 15008,
		name = add_phy_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15021) ->
	#passi_eff{
		no = 15021,
		name = add_mag_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 750,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15022) ->
	#passi_eff{
		no = 15022,
		name = add_mag_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15023) ->
	#passi_eff{
		no = 15023,
		name = add_mag_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1750,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15024) ->
	#passi_eff{
		no = 15024,
		name = add_mag_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15025) ->
	#passi_eff{
		no = 15025,
		name = add_mag_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2750,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15026) ->
	#passi_eff{
		no = 15026,
		name = add_mag_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15027) ->
	#passi_eff{
		no = 15027,
		name = add_mag_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3750,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15028) ->
	#passi_eff{
		no = 15028,
		name = add_mag_dam_to_mon,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15041) ->
	#passi_eff{
		no = 15041,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15042) ->
	#passi_eff{
		no = 15042,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15043) ->
	#passi_eff{
		no = 15043,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 350,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15044) ->
	#passi_eff{
		no = 15044,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15045) ->
	#passi_eff{
		no = 15045,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15046) ->
	#passi_eff{
		no = 15046,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 600,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15047) ->
	#passi_eff{
		no = 15047,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15048) ->
	#passi_eff{
		no = 15048,
		name = add_neglect_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 850,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15061) ->
	#passi_eff{
		no = 15061,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15062) ->
	#passi_eff{
		no = 15062,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15063) ->
	#passi_eff{
		no = 15063,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 350,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15064) ->
	#passi_eff{
		no = 15064,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15065) ->
	#passi_eff{
		no = 15065,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15066) ->
	#passi_eff{
		no = 15066,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 600,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15067) ->
	#passi_eff{
		no = 15067,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15068) ->
	#passi_eff{
		no = 15068,
		name = add_neglect_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 850,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15081) ->
	#passi_eff{
		no = 15081,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 41,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15082) ->
	#passi_eff{
		no = 15082,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 68,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15083) ->
	#passi_eff{
		no = 15083,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 96,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15084) ->
	#passi_eff{
		no = 15084,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 123,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15085) ->
	#passi_eff{
		no = 15085,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15086) ->
	#passi_eff{
		no = 15086,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 178,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15087) ->
	#passi_eff{
		no = 15087,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 205,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15088) ->
	#passi_eff{
		no = 15088,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15089) ->
	#passi_eff{
		no = 15089,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15090) ->
	#passi_eff{
		no = 15090,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 137,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15091) ->
	#passi_eff{
		no = 15091,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 191,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15092) ->
	#passi_eff{
		no = 15092,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15093) ->
	#passi_eff{
		no = 15093,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 301,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15094) ->
	#passi_eff{
		no = 15094,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 355,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15095) ->
	#passi_eff{
		no = 15095,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15096) ->
	#passi_eff{
		no = 15096,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 492,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15101) ->
	#passi_eff{
		no = 15101,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 41,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15102) ->
	#passi_eff{
		no = 15102,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 68,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15103) ->
	#passi_eff{
		no = 15103,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 96,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15104) ->
	#passi_eff{
		no = 15104,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 123,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15105) ->
	#passi_eff{
		no = 15105,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15106) ->
	#passi_eff{
		no = 15106,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 178,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15107) ->
	#passi_eff{
		no = 15107,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 205,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15108) ->
	#passi_eff{
		no = 15108,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15109) ->
	#passi_eff{
		no = 15109,
		name = add_phy_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 30,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15110) ->
	#passi_eff{
		no = 15110,
		name = add_phy_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15111) ->
	#passi_eff{
		no = 15111,
		name = add_phy_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 75,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15112) ->
	#passi_eff{
		no = 15112,
		name = add_phy_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 95,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15113) ->
	#passi_eff{
		no = 15113,
		name = add_phy_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 115,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15114) ->
	#passi_eff{
		no = 15114,
		name = add_phy_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 135,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15115) ->
	#passi_eff{
		no = 15115,
		name = add_phy_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 155,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15116) ->
	#passi_eff{
		no = 15116,
		name = add_phy_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 190,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15121) ->
	#passi_eff{
		no = 15121,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 41,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15122) ->
	#passi_eff{
		no = 15122,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 68,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15123) ->
	#passi_eff{
		no = 15123,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 96,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15124) ->
	#passi_eff{
		no = 15124,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 123,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15125) ->
	#passi_eff{
		no = 15125,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15126) ->
	#passi_eff{
		no = 15126,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 178,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15127) ->
	#passi_eff{
		no = 15127,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 205,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15128) ->
	#passi_eff{
		no = 15128,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15129) ->
	#passi_eff{
		no = 15129,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15130) ->
	#passi_eff{
		no = 15130,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15131) ->
	#passi_eff{
		no = 15131,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15132) ->
	#passi_eff{
		no = 15132,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15133) ->
	#passi_eff{
		no = 15133,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15134) ->
	#passi_eff{
		no = 15134,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15135) ->
	#passi_eff{
		no = 15135,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.125000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15136) ->
	#passi_eff{
		no = 15136,
		name = add_phy_def_by_rate,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15141) ->
	#passi_eff{
		no = 15141,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15142) ->
	#passi_eff{
		no = 15142,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 137,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15143) ->
	#passi_eff{
		no = 15143,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 191,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15144) ->
	#passi_eff{
		no = 15144,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15145) ->
	#passi_eff{
		no = 15145,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 301,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15146) ->
	#passi_eff{
		no = 15146,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 355,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15147) ->
	#passi_eff{
		no = 15147,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15148) ->
	#passi_eff{
		no = 15148,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 492,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15149) ->
	#passi_eff{
		no = 15149,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 16,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15150) ->
	#passi_eff{
		no = 15150,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 27,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15151) ->
	#passi_eff{
		no = 15151,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 38,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15152) ->
	#passi_eff{
		no = 15152,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 49,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15153) ->
	#passi_eff{
		no = 15153,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15154) ->
	#passi_eff{
		no = 15154,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15155) ->
	#passi_eff{
		no = 15155,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15156) ->
	#passi_eff{
		no = 15156,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 98,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15161) ->
	#passi_eff{
		no = 15161,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 41,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15162) ->
	#passi_eff{
		no = 15162,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 68,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15163) ->
	#passi_eff{
		no = 15163,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 96,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15164) ->
	#passi_eff{
		no = 15164,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 123,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15165) ->
	#passi_eff{
		no = 15165,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15166) ->
	#passi_eff{
		no = 15166,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 178,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15167) ->
	#passi_eff{
		no = 15167,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 205,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15168) ->
	#passi_eff{
		no = 15168,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15169) ->
	#passi_eff{
		no = 15169,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15170) ->
	#passi_eff{
		no = 15170,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 137,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15171) ->
	#passi_eff{
		no = 15171,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 191,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15172) ->
	#passi_eff{
		no = 15172,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15173) ->
	#passi_eff{
		no = 15173,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 301,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15174) ->
	#passi_eff{
		no = 15174,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 355,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15175) ->
	#passi_eff{
		no = 15175,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15176) ->
	#passi_eff{
		no = 15176,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 492,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15181) ->
	#passi_eff{
		no = 15181,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 41,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15182) ->
	#passi_eff{
		no = 15182,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 68,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15183) ->
	#passi_eff{
		no = 15183,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 96,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15184) ->
	#passi_eff{
		no = 15184,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 123,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15185) ->
	#passi_eff{
		no = 15185,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15186) ->
	#passi_eff{
		no = 15186,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 178,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15187) ->
	#passi_eff{
		no = 15187,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 205,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15188) ->
	#passi_eff{
		no = 15188,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15189) ->
	#passi_eff{
		no = 15189,
		name = add_mag_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 30,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15190) ->
	#passi_eff{
		no = 15190,
		name = add_mag_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15191) ->
	#passi_eff{
		no = 15191,
		name = add_mag_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 75,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15192) ->
	#passi_eff{
		no = 15192,
		name = add_mag_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 95,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15193) ->
	#passi_eff{
		no = 15193,
		name = add_mag_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 115,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15194) ->
	#passi_eff{
		no = 15194,
		name = add_mag_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 135,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15195) ->
	#passi_eff{
		no = 15195,
		name = add_mag_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 155,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15196) ->
	#passi_eff{
		no = 15196,
		name = add_mag_combo_att_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 190,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15201) ->
	#passi_eff{
		no = 15201,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15202) ->
	#passi_eff{
		no = 15202,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 137,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15203) ->
	#passi_eff{
		no = 15203,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 191,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15204) ->
	#passi_eff{
		no = 15204,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15205) ->
	#passi_eff{
		no = 15205,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 301,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15206) ->
	#passi_eff{
		no = 15206,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 355,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15207) ->
	#passi_eff{
		no = 15207,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15208) ->
	#passi_eff{
		no = 15208,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 492,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15209) ->
	#passi_eff{
		no = 15209,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 16,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15210) ->
	#passi_eff{
		no = 15210,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 27,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15211) ->
	#passi_eff{
		no = 15211,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 38,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15212) ->
	#passi_eff{
		no = 15212,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 49,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15213) ->
	#passi_eff{
		no = 15213,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15214) ->
	#passi_eff{
		no = 15214,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15215) ->
	#passi_eff{
		no = 15215,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15216) ->
	#passi_eff{
		no = 15216,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 98,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15221) ->
	#passi_eff{
		no = 15221,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15222) ->
	#passi_eff{
		no = 15222,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 680,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15223) ->
	#passi_eff{
		no = 15223,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 957,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15224) ->
	#passi_eff{
		no = 15224,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1230,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15225) ->
	#passi_eff{
		no = 15225,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1503,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15226) ->
	#passi_eff{
		no = 15226,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1777,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15227) ->
	#passi_eff{
		no = 15227,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2050,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15228) ->
	#passi_eff{
		no = 15228,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2460,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15229) ->
	#passi_eff{
		no = 15229,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 21,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15230) ->
	#passi_eff{
		no = 15230,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 34,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15231) ->
	#passi_eff{
		no = 15231,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 48,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15232) ->
	#passi_eff{
		no = 15232,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 62,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15233) ->
	#passi_eff{
		no = 15233,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 75,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15234) ->
	#passi_eff{
		no = 15234,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 89,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15235) ->
	#passi_eff{
		no = 15235,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 103,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15236) ->
	#passi_eff{
		no = 15236,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 123,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15241) ->
	#passi_eff{
		no = 15241,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 820,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15242) ->
	#passi_eff{
		no = 15242,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1367,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15243) ->
	#passi_eff{
		no = 15243,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1913,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15244) ->
	#passi_eff{
		no = 15244,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2460,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15245) ->
	#passi_eff{
		no = 15245,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3007,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15246) ->
	#passi_eff{
		no = 15246,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3554,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15247) ->
	#passi_eff{
		no = 15247,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4100,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15248) ->
	#passi_eff{
		no = 15248,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4920,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15249) ->
	#passi_eff{
		no = 15249,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.015000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15250) ->
	#passi_eff{
		no = 15250,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.020000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15251) ->
	#passi_eff{
		no = 15251,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15252) ->
	#passi_eff{
		no = 15252,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15253) ->
	#passi_eff{
		no = 15253,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.045000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15254) ->
	#passi_eff{
		no = 15254,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.055000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15255) ->
	#passi_eff{
		no = 15255,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.065000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15256) ->
	#passi_eff{
		no = 15256,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15261) ->
	#passi_eff{
		no = 15261,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 820,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15262) ->
	#passi_eff{
		no = 15262,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1367,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15263) ->
	#passi_eff{
		no = 15263,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1913,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15264) ->
	#passi_eff{
		no = 15264,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2460,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15265) ->
	#passi_eff{
		no = 15265,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3007,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15266) ->
	#passi_eff{
		no = 15266,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3554,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15267) ->
	#passi_eff{
		no = 15267,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4100,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15268) ->
	#passi_eff{
		no = 15268,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4920,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15269) ->
	#passi_eff{
		no = 15269,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 16,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15270) ->
	#passi_eff{
		no = 15270,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 27,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15271) ->
	#passi_eff{
		no = 15271,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 38,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15272) ->
	#passi_eff{
		no = 15272,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 49,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15273) ->
	#passi_eff{
		no = 15273,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15274) ->
	#passi_eff{
		no = 15274,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15275) ->
	#passi_eff{
		no = 15275,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15276) ->
	#passi_eff{
		no = 15276,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 98,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15281) ->
	#passi_eff{
		no = 15281,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15282) ->
	#passi_eff{
		no = 15282,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 65,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15283) ->
	#passi_eff{
		no = 15283,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 90,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15284) ->
	#passi_eff{
		no = 15284,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 115,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15285) ->
	#passi_eff{
		no = 15285,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 140,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15286) ->
	#passi_eff{
		no = 15286,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 165,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15287) ->
	#passi_eff{
		no = 15287,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 190,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15288) ->
	#passi_eff{
		no = 15288,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 225,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15289) ->
	#passi_eff{
		no = 15289,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15290) ->
	#passi_eff{
		no = 15290,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.065000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15291) ->
	#passi_eff{
		no = 15291,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15292) ->
	#passi_eff{
		no = 15292,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.115000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15293) ->
	#passi_eff{
		no = 15293,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.140000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15294) ->
	#passi_eff{
		no = 15294,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.165000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15295) ->
	#passi_eff{
		no = 15295,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.190000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15296) ->
	#passi_eff{
		no = 15296,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.225000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15301) ->
	#passi_eff{
		no = 15301,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 33,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15302) ->
	#passi_eff{
		no = 15302,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 55,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15303) ->
	#passi_eff{
		no = 15303,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 77,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15304) ->
	#passi_eff{
		no = 15304,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 98,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15305) ->
	#passi_eff{
		no = 15305,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 120,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15306) ->
	#passi_eff{
		no = 15306,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 142,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15307) ->
	#passi_eff{
		no = 15307,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 164,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15308) ->
	#passi_eff{
		no = 15308,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 197,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15309) ->
	#passi_eff{
		no = 15309,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.010000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15310) ->
	#passi_eff{
		no = 15310,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.015000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15311) ->
	#passi_eff{
		no = 15311,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15312) ->
	#passi_eff{
		no = 15312,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15313) ->
	#passi_eff{
		no = 15313,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.035000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15314) ->
	#passi_eff{
		no = 15314,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.045000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15315) ->
	#passi_eff{
		no = 15315,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15316) ->
	#passi_eff{
		no = 15316,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15321) ->
	#passi_eff{
		no = 15321,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15322) ->
	#passi_eff{
		no = 15322,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15323) ->
	#passi_eff{
		no = 15323,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15324) ->
	#passi_eff{
		no = 15324,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15325) ->
	#passi_eff{
		no = 15325,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15326) ->
	#passi_eff{
		no = 15326,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15327) ->
	#passi_eff{
		no = 15327,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.125000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15328) ->
	#passi_eff{
		no = 15328,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15329) ->
	#passi_eff{
		no = 15329,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15330) ->
	#passi_eff{
		no = 15330,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 137,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15331) ->
	#passi_eff{
		no = 15331,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 191,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15332) ->
	#passi_eff{
		no = 15332,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15333) ->
	#passi_eff{
		no = 15333,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 301,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15334) ->
	#passi_eff{
		no = 15334,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 355,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15335) ->
	#passi_eff{
		no = 15335,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15336) ->
	#passi_eff{
		no = 15336,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 492,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15341) ->
	#passi_eff{
		no = 15341,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15342) ->
	#passi_eff{
		no = 15342,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15343) ->
	#passi_eff{
		no = 15343,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15344) ->
	#passi_eff{
		no = 15344,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15345) ->
	#passi_eff{
		no = 15345,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15346) ->
	#passi_eff{
		no = 15346,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15347) ->
	#passi_eff{
		no = 15347,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.125000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15348) ->
	#passi_eff{
		no = 15348,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15349) ->
	#passi_eff{
		no = 15349,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15350) ->
	#passi_eff{
		no = 15350,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 137,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15351) ->
	#passi_eff{
		no = 15351,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 191,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15352) ->
	#passi_eff{
		no = 15352,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15353) ->
	#passi_eff{
		no = 15353,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 301,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15354) ->
	#passi_eff{
		no = 15354,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 355,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15355) ->
	#passi_eff{
		no = 15355,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15356) ->
	#passi_eff{
		no = 15356,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 492,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15361) ->
	#passi_eff{
		no = 15361,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15362) ->
	#passi_eff{
		no = 15362,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15363) ->
	#passi_eff{
		no = 15363,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15364) ->
	#passi_eff{
		no = 15364,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15365) ->
	#passi_eff{
		no = 15365,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15366) ->
	#passi_eff{
		no = 15366,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15367) ->
	#passi_eff{
		no = 15367,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.125000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15368) ->
	#passi_eff{
		no = 15368,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15369) ->
	#passi_eff{
		no = 15369,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.015000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15370) ->
	#passi_eff{
		no = 15370,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.020000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15371) ->
	#passi_eff{
		no = 15371,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15372) ->
	#passi_eff{
		no = 15372,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15373) ->
	#passi_eff{
		no = 15373,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.045000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15374) ->
	#passi_eff{
		no = 15374,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.055000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15375) ->
	#passi_eff{
		no = 15375,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.065000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15376) ->
	#passi_eff{
		no = 15376,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15381) ->
	#passi_eff{
		no = 15381,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15382) ->
	#passi_eff{
		no = 15382,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15383) ->
	#passi_eff{
		no = 15383,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15384) ->
	#passi_eff{
		no = 15384,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15385) ->
	#passi_eff{
		no = 15385,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15386) ->
	#passi_eff{
		no = 15386,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15387) ->
	#passi_eff{
		no = 15387,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.125000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15388) ->
	#passi_eff{
		no = 15388,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15389) ->
	#passi_eff{
		no = 15389,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.015000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15390) ->
	#passi_eff{
		no = 15390,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.020000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15391) ->
	#passi_eff{
		no = 15391,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15392) ->
	#passi_eff{
		no = 15392,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15393) ->
	#passi_eff{
		no = 15393,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.045000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15394) ->
	#passi_eff{
		no = 15394,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.055000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15395) ->
	#passi_eff{
		no = 15395,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.065000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15396) ->
	#passi_eff{
		no = 15396,
		name = reduce_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15401) ->
	#passi_eff{
		no = 15401,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15402) ->
	#passi_eff{
		no = 15402,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15403) ->
	#passi_eff{
		no = 15403,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15404) ->
	#passi_eff{
		no = 15404,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15405) ->
	#passi_eff{
		no = 15405,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15406) ->
	#passi_eff{
		no = 15406,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15407) ->
	#passi_eff{
		no = 15407,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.125000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15408) ->
	#passi_eff{
		no = 15408,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15409) ->
	#passi_eff{
		no = 15409,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.015000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15410) ->
	#passi_eff{
		no = 15410,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.020000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15411) ->
	#passi_eff{
		no = 15411,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15412) ->
	#passi_eff{
		no = 15412,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15413) ->
	#passi_eff{
		no = 15413,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.045000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15414) ->
	#passi_eff{
		no = 15414,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.055000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15415) ->
	#passi_eff{
		no = 15415,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.065000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15416) ->
	#passi_eff{
		no = 15416,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15421) ->
	#passi_eff{
		no = 15421,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 33,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15422) ->
	#passi_eff{
		no = 15422,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 55,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15423) ->
	#passi_eff{
		no = 15423,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 77,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15424) ->
	#passi_eff{
		no = 15424,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 98,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15425) ->
	#passi_eff{
		no = 15425,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 120,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15426) ->
	#passi_eff{
		no = 15426,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 142,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15427) ->
	#passi_eff{
		no = 15427,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 164,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15428) ->
	#passi_eff{
		no = 15428,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 197,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15429) ->
	#passi_eff{
		no = 15429,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.015000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15430) ->
	#passi_eff{
		no = 15430,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.020000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15431) ->
	#passi_eff{
		no = 15431,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15432) ->
	#passi_eff{
		no = 15432,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15433) ->
	#passi_eff{
		no = 15433,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.045000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15434) ->
	#passi_eff{
		no = 15434,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.055000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15435) ->
	#passi_eff{
		no = 15435,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.065000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15436) ->
	#passi_eff{
		no = 15436,
		name = reduce_do_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15441) ->
	#passi_eff{
		no = 15441,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.035000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15442) ->
	#passi_eff{
		no = 15442,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.055000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15443) ->
	#passi_eff{
		no = 15443,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15444) ->
	#passi_eff{
		no = 15444,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15445) ->
	#passi_eff{
		no = 15445,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15446) ->
	#passi_eff{
		no = 15446,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.140000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15447) ->
	#passi_eff{
		no = 15447,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.165000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15448) ->
	#passi_eff{
		no = 15448,
		name = add_absorb_hp_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.195000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15461) ->
	#passi_eff{
		no = 15461,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 65,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15462) ->
	#passi_eff{
		no = 15462,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 105,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15463) ->
	#passi_eff{
		no = 15463,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15464) ->
	#passi_eff{
		no = 15464,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 190,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15465) ->
	#passi_eff{
		no = 15465,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 235,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15466) ->
	#passi_eff{
		no = 15466,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 275,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15467) ->
	#passi_eff{
		no = 15467,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 320,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15468) ->
	#passi_eff{
		no = 15468,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 380,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15469) ->
	#passi_eff{
		no = 15469,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 16,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15470) ->
	#passi_eff{
		no = 15470,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 27,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15471) ->
	#passi_eff{
		no = 15471,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 38,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15472) ->
	#passi_eff{
		no = 15472,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 49,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15473) ->
	#passi_eff{
		no = 15473,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15474) ->
	#passi_eff{
		no = 15474,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15475) ->
	#passi_eff{
		no = 15475,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15476) ->
	#passi_eff{
		no = 15476,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 98,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15481) ->
	#passi_eff{
		no = 15481,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 65,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15482) ->
	#passi_eff{
		no = 15482,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 105,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15483) ->
	#passi_eff{
		no = 15483,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15484) ->
	#passi_eff{
		no = 15484,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 190,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15485) ->
	#passi_eff{
		no = 15485,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 235,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15486) ->
	#passi_eff{
		no = 15486,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 275,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15487) ->
	#passi_eff{
		no = 15487,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 320,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15488) ->
	#passi_eff{
		no = 15488,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 380,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15489) ->
	#passi_eff{
		no = 15489,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 16,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15490) ->
	#passi_eff{
		no = 15490,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 27,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15491) ->
	#passi_eff{
		no = 15491,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 38,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15492) ->
	#passi_eff{
		no = 15492,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 49,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15493) ->
	#passi_eff{
		no = 15493,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15494) ->
	#passi_eff{
		no = 15494,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15495) ->
	#passi_eff{
		no = 15495,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15496) ->
	#passi_eff{
		no = 15496,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 98,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15501) ->
	#passi_eff{
		no = 15501,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 164,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15502) ->
	#passi_eff{
		no = 15502,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 273,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15503) ->
	#passi_eff{
		no = 15503,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 383,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15504) ->
	#passi_eff{
		no = 15504,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 492,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15505) ->
	#passi_eff{
		no = 15505,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 601,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15506) ->
	#passi_eff{
		no = 15506,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 711,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15507) ->
	#passi_eff{
		no = 15507,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 820,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15508) ->
	#passi_eff{
		no = 15508,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 984,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15509) ->
	#passi_eff{
		no = 15509,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 16,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15510) ->
	#passi_eff{
		no = 15510,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 27,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15511) ->
	#passi_eff{
		no = 15511,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 38,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15512) ->
	#passi_eff{
		no = 15512,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 49,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15513) ->
	#passi_eff{
		no = 15513,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15514) ->
	#passi_eff{
		no = 15514,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15515) ->
	#passi_eff{
		no = 15515,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15516) ->
	#passi_eff{
		no = 15516,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 98,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15521) ->
	#passi_eff{
		no = 15521,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 164,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15522) ->
	#passi_eff{
		no = 15522,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 273,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15523) ->
	#passi_eff{
		no = 15523,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 383,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15524) ->
	#passi_eff{
		no = 15524,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 492,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15525) ->
	#passi_eff{
		no = 15525,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 601,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15526) ->
	#passi_eff{
		no = 15526,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 711,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15527) ->
	#passi_eff{
		no = 15527,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 820,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15528) ->
	#passi_eff{
		no = 15528,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 984,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15529) ->
	#passi_eff{
		no = 15529,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 16,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15530) ->
	#passi_eff{
		no = 15530,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 27,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15531) ->
	#passi_eff{
		no = 15531,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 38,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15532) ->
	#passi_eff{
		no = 15532,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 49,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15533) ->
	#passi_eff{
		no = 15533,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15534) ->
	#passi_eff{
		no = 15534,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15535) ->
	#passi_eff{
		no = 15535,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15536) ->
	#passi_eff{
		no = 15536,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 98,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15541) ->
	#passi_eff{
		no = 15541,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 75,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15542) ->
	#passi_eff{
		no = 15542,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 125,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15543) ->
	#passi_eff{
		no = 15543,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 175,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15544) ->
	#passi_eff{
		no = 15544,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 225,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15545) ->
	#passi_eff{
		no = 15545,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 275,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15546) ->
	#passi_eff{
		no = 15546,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 325,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15547) ->
	#passi_eff{
		no = 15547,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 375,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15548) ->
	#passi_eff{
		no = 15548,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 450,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15549) ->
	#passi_eff{
		no = 15549,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 16,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15550) ->
	#passi_eff{
		no = 15550,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 27,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15551) ->
	#passi_eff{
		no = 15551,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 38,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15552) ->
	#passi_eff{
		no = 15552,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 49,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15553) ->
	#passi_eff{
		no = 15553,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15554) ->
	#passi_eff{
		no = 15554,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15555) ->
	#passi_eff{
		no = 15555,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15556) ->
	#passi_eff{
		no = 15556,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 98,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15561) ->
	#passi_eff{
		no = 15561,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 33,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15562) ->
	#passi_eff{
		no = 15562,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 55,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15563) ->
	#passi_eff{
		no = 15563,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 77,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15564) ->
	#passi_eff{
		no = 15564,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 98,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15565) ->
	#passi_eff{
		no = 15565,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 120,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15566) ->
	#passi_eff{
		no = 15566,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 142,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15567) ->
	#passi_eff{
		no = 15567,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 164,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15568) ->
	#passi_eff{
		no = 15568,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 197,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15569) ->
	#passi_eff{
		no = 15569,
		name = reduce_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15570) ->
	#passi_eff{
		no = 15570,
		name = reduce_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 683,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15571) ->
	#passi_eff{
		no = 15571,
		name = reduce_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 957,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15572) ->
	#passi_eff{
		no = 15572,
		name = reduce_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1230,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15573) ->
	#passi_eff{
		no = 15573,
		name = reduce_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1503,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15574) ->
	#passi_eff{
		no = 15574,
		name = reduce_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1777,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15575) ->
	#passi_eff{
		no = 15575,
		name = reduce_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2050,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15576) ->
	#passi_eff{
		no = 15576,
		name = reduce_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2460,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15581) ->
	#passi_eff{
		no = 15581,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15582) ->
	#passi_eff{
		no = 15582,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15583) ->
	#passi_eff{
		no = 15583,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15584) ->
	#passi_eff{
		no = 15584,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15585) ->
	#passi_eff{
		no = 15585,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15586) ->
	#passi_eff{
		no = 15586,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15587) ->
	#passi_eff{
		no = 15587,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.125000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15588) ->
	#passi_eff{
		no = 15588,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15589) ->
	#passi_eff{
		no = 15589,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 16,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15590) ->
	#passi_eff{
		no = 15590,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 27,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15591) ->
	#passi_eff{
		no = 15591,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 38,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15592) ->
	#passi_eff{
		no = 15592,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 49,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15593) ->
	#passi_eff{
		no = 15593,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15594) ->
	#passi_eff{
		no = 15594,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15595) ->
	#passi_eff{
		no = 15595,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 82,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15596) ->
	#passi_eff{
		no = 15596,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 98,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15601) ->
	#passi_eff{
		no = 15601,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.015000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15602) ->
	#passi_eff{
		no = 15602,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.020000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15603) ->
	#passi_eff{
		no = 15603,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15604) ->
	#passi_eff{
		no = 15604,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15605) ->
	#passi_eff{
		no = 15605,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.045000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15606) ->
	#passi_eff{
		no = 15606,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.055000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15607) ->
	#passi_eff{
		no = 15607,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.065000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15608) ->
	#passi_eff{
		no = 15608,
		name = add_be_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15609) ->
	#passi_eff{
		no = 15609,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 21,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15610) ->
	#passi_eff{
		no = 15610,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 34,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15611) ->
	#passi_eff{
		no = 15611,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 48,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15612) ->
	#passi_eff{
		no = 15612,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 62,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15613) ->
	#passi_eff{
		no = 15613,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 75,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15614) ->
	#passi_eff{
		no = 15614,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 89,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15615) ->
	#passi_eff{
		no = 15615,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 103,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15616) ->
	#passi_eff{
		no = 15616,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 123,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15621) ->
	#passi_eff{
		no = 15621,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 41,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15622) ->
	#passi_eff{
		no = 15622,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 68,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15623) ->
	#passi_eff{
		no = 15623,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 96,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15624) ->
	#passi_eff{
		no = 15624,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 123,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15625) ->
	#passi_eff{
		no = 15625,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15626) ->
	#passi_eff{
		no = 15626,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 178,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15627) ->
	#passi_eff{
		no = 15627,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 205,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15628) ->
	#passi_eff{
		no = 15628,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15629) ->
	#passi_eff{
		no = 15629,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15630) ->
	#passi_eff{
		no = 15630,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 683,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15631) ->
	#passi_eff{
		no = 15631,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 957,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15632) ->
	#passi_eff{
		no = 15632,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1230,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15633) ->
	#passi_eff{
		no = 15633,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1503,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15634) ->
	#passi_eff{
		no = 15634,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1777,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15635) ->
	#passi_eff{
		no = 15635,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2050,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15636) ->
	#passi_eff{
		no = 15636,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2460,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15641) ->
	#passi_eff{
		no = 15641,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 41,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15642) ->
	#passi_eff{
		no = 15642,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 68,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15643) ->
	#passi_eff{
		no = 15643,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 96,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15644) ->
	#passi_eff{
		no = 15644,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 123,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15645) ->
	#passi_eff{
		no = 15645,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15646) ->
	#passi_eff{
		no = 15646,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 178,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15647) ->
	#passi_eff{
		no = 15647,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 205,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15648) ->
	#passi_eff{
		no = 15648,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 246,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15649) ->
	#passi_eff{
		no = 15649,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15650) ->
	#passi_eff{
		no = 15650,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 683,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15651) ->
	#passi_eff{
		no = 15651,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 957,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15652) ->
	#passi_eff{
		no = 15652,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1230,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15653) ->
	#passi_eff{
		no = 15653,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1503,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15654) ->
	#passi_eff{
		no = 15654,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1777,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15655) ->
	#passi_eff{
		no = 15655,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2050,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15656) ->
	#passi_eff{
		no = 15656,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2460,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15661) ->
	#passi_eff{
		no = 15661,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15662) ->
	#passi_eff{
		no = 15662,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15663) ->
	#passi_eff{
		no = 15663,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15664) ->
	#passi_eff{
		no = 15664,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15665) ->
	#passi_eff{
		no = 15665,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15666) ->
	#passi_eff{
		no = 15666,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15667) ->
	#passi_eff{
		no = 15667,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.125000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15668) ->
	#passi_eff{
		no = 15668,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15669) ->
	#passi_eff{
		no = 15669,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 21,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15670) ->
	#passi_eff{
		no = 15670,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 34,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15671) ->
	#passi_eff{
		no = 15671,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 48,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15672) ->
	#passi_eff{
		no = 15672,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 62,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15673) ->
	#passi_eff{
		no = 15673,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 75,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15674) ->
	#passi_eff{
		no = 15674,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 89,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15675) ->
	#passi_eff{
		no = 15675,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 103,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15676) ->
	#passi_eff{
		no = 15676,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 123,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15681) ->
	#passi_eff{
		no = 15681,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15682) ->
	#passi_eff{
		no = 15682,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 80,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15683) ->
	#passi_eff{
		no = 15683,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 110,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15684) ->
	#passi_eff{
		no = 15684,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 145,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15685) ->
	#passi_eff{
		no = 15685,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 175,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15686) ->
	#passi_eff{
		no = 15686,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 205,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15687) ->
	#passi_eff{
		no = 15687,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 240,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15688) ->
	#passi_eff{
		no = 15688,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 285,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15689) ->
	#passi_eff{
		no = 15689,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15690) ->
	#passi_eff{
		no = 15690,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 683,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15691) ->
	#passi_eff{
		no = 15691,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 957,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15692) ->
	#passi_eff{
		no = 15692,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1230,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15693) ->
	#passi_eff{
		no = 15693,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1503,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15694) ->
	#passi_eff{
		no = 15694,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1777,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15695) ->
	#passi_eff{
		no = 15695,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2050,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15696) ->
	#passi_eff{
		no = 15696,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2460,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15701) ->
	#passi_eff{
		no = 15701,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15702) ->
	#passi_eff{
		no = 15702,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 80,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15703) ->
	#passi_eff{
		no = 15703,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 110,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15704) ->
	#passi_eff{
		no = 15704,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 145,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15705) ->
	#passi_eff{
		no = 15705,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 175,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15706) ->
	#passi_eff{
		no = 15706,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 205,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15707) ->
	#passi_eff{
		no = 15707,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 240,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15708) ->
	#passi_eff{
		no = 15708,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 285,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15709) ->
	#passi_eff{
		no = 15709,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15710) ->
	#passi_eff{
		no = 15710,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 683,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15711) ->
	#passi_eff{
		no = 15711,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 957,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15712) ->
	#passi_eff{
		no = 15712,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1230,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15713) ->
	#passi_eff{
		no = 15713,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1503,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15714) ->
	#passi_eff{
		no = 15714,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1777,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15715) ->
	#passi_eff{
		no = 15715,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2050,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15716) ->
	#passi_eff{
		no = 15716,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2460,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15721) ->
	#passi_eff{
		no = 15721,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15722) ->
	#passi_eff{
		no = 15722,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15723) ->
	#passi_eff{
		no = 15723,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15724) ->
	#passi_eff{
		no = 15724,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15725) ->
	#passi_eff{
		no = 15725,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15726) ->
	#passi_eff{
		no = 15726,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.110000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15727) ->
	#passi_eff{
		no = 15727,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.125000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15728) ->
	#passi_eff{
		no = 15728,
		name = add_be_heal_eff_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15729) ->
	#passi_eff{
		no = 15729,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 410,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15730) ->
	#passi_eff{
		no = 15730,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 683,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15731) ->
	#passi_eff{
		no = 15731,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 957,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15732) ->
	#passi_eff{
		no = 15732,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1230,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15733) ->
	#passi_eff{
		no = 15733,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1503,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15734) ->
	#passi_eff{
		no = 15734,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1777,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15735) ->
	#passi_eff{
		no = 15735,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2050,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15736) ->
	#passi_eff{
		no = 15736,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2460,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15661) ->
	#passi_eff{
		no = 15661,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15661,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15662) ->
	#passi_eff{
		no = 15662,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15662,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15663) ->
	#passi_eff{
		no = 15663,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15663,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15664) ->
	#passi_eff{
		no = 15664,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15664,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15665) ->
	#passi_eff{
		no = 15665,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15665,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15666) ->
	#passi_eff{
		no = 15666,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15666,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15667) ->
	#passi_eff{
		no = 15667,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15667,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15668) ->
	#passi_eff{
		no = 15668,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15668,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15681) ->
	#passi_eff{
		no = 15681,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15681,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15682) ->
	#passi_eff{
		no = 15682,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15682,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15683) ->
	#passi_eff{
		no = 15683,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15683,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15684) ->
	#passi_eff{
		no = 15684,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15684,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15685) ->
	#passi_eff{
		no = 15685,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15685,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15686) ->
	#passi_eff{
		no = 15686,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15686,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15687) ->
	#passi_eff{
		no = 15687,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15687,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15688) ->
	#passi_eff{
		no = 15688,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15688,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15701) ->
	#passi_eff{
		no = 15701,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15701,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15702) ->
	#passi_eff{
		no = 15702,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15702,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15703) ->
	#passi_eff{
		no = 15703,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15703,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15704) ->
	#passi_eff{
		no = 15704,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15704,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15705) ->
	#passi_eff{
		no = 15705,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15705,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15706) ->
	#passi_eff{
		no = 15706,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15706,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15707) ->
	#passi_eff{
		no = 15707,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15707,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(15708) ->
	#passi_eff{
		no = 15708,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15708,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16001) ->
	#passi_eff{
		no = 16001,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 89500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16002) ->
	#passi_eff{
		no = 16002,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 179100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16003) ->
	#passi_eff{
		no = 16003,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 268600,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16004) ->
	#passi_eff{
		no = 16004,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 358100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16005) ->
	#passi_eff{
		no = 16005,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 447700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16006) ->
	#passi_eff{
		no = 16006,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 568500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16007) ->
	#passi_eff{
		no = 16007,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 716300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16008) ->
	#passi_eff{
		no = 16008,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 868500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16009) ->
	#passi_eff{
		no = 16009,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 9000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16010) ->
	#passi_eff{
		no = 16010,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 17900,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16011) ->
	#passi_eff{
		no = 16011,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 26900,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16012) ->
	#passi_eff{
		no = 16012,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 35800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16013) ->
	#passi_eff{
		no = 16013,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 44800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16014) ->
	#passi_eff{
		no = 16014,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 56900,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16015) ->
	#passi_eff{
		no = 16015,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71600,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16016) ->
	#passi_eff{
		no = 16016,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 86800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16017) ->
	#passi_eff{
		no = 16017,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 9000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16018) ->
	#passi_eff{
		no = 16018,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 17900,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16019) ->
	#passi_eff{
		no = 16019,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 26900,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16020) ->
	#passi_eff{
		no = 16020,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 35800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16021) ->
	#passi_eff{
		no = 16021,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 44800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16022) ->
	#passi_eff{
		no = 16022,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 56900,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16023) ->
	#passi_eff{
		no = 16023,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71600,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16024) ->
	#passi_eff{
		no = 16024,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 86800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16025) ->
	#passi_eff{
		no = 16025,
		name = add_seal_hit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2200,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16026) ->
	#passi_eff{
		no = 16026,
		name = add_seal_hit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16027) ->
	#passi_eff{
		no = 16027,
		name = add_seal_hit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 6700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16028) ->
	#passi_eff{
		no = 16028,
		name = add_seal_hit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 9000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16029) ->
	#passi_eff{
		no = 16029,
		name = add_seal_hit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 11200,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16030) ->
	#passi_eff{
		no = 16030,
		name = add_seal_hit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14200,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16031) ->
	#passi_eff{
		no = 16031,
		name = add_seal_hit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 17900,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16032) ->
	#passi_eff{
		no = 16032,
		name = add_seal_hit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 21700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16033) ->
	#passi_eff{
		no = 16033,
		name = add_be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.026000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16034) ->
	#passi_eff{
		no = 16034,
		name = add_be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.039000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16035) ->
	#passi_eff{
		no = 16035,
		name = add_be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.053000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16036) ->
	#passi_eff{
		no = 16036,
		name = add_be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.066000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16037) ->
	#passi_eff{
		no = 16037,
		name = add_be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.079000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16038) ->
	#passi_eff{
		no = 16038,
		name = add_be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.092000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16039) ->
	#passi_eff{
		no = 16039,
		name = add_be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.105000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16040) ->
	#passi_eff{
		no = 16040,
		name = add_be_phy_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.118000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16041) ->
	#passi_eff{
		no = 16041,
		name = add_be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.026000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16042) ->
	#passi_eff{
		no = 16042,
		name = add_be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.039000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16043) ->
	#passi_eff{
		no = 16043,
		name = add_be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.053000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16044) ->
	#passi_eff{
		no = 16044,
		name = add_be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.066000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16045) ->
	#passi_eff{
		no = 16045,
		name = add_be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.079000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16046) ->
	#passi_eff{
		no = 16046,
		name = add_be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.092000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16047) ->
	#passi_eff{
		no = 16047,
		name = add_be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.105000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16048) ->
	#passi_eff{
		no = 16048,
		name = add_be_mag_dam_reduce_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.118000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16051) ->
	#passi_eff{
		no = 16051,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 17900,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16052) ->
	#passi_eff{
		no = 16052,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 35800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16053) ->
	#passi_eff{
		no = 16053,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 53700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16054) ->
	#passi_eff{
		no = 16054,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71600,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16055) ->
	#passi_eff{
		no = 16055,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 89500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16056) ->
	#passi_eff{
		no = 16056,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 113700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16057) ->
	#passi_eff{
		no = 16057,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 143300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16058) ->
	#passi_eff{
		no = 16058,
		name = add_phy_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 173700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16059) ->
	#passi_eff{
		no = 16059,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.015000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16060) ->
	#passi_eff{
		no = 16060,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.023000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16061) ->
	#passi_eff{
		no = 16061,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16062) ->
	#passi_eff{
		no = 16062,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.038000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16063) ->
	#passi_eff{
		no = 16063,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.045000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16064) ->
	#passi_eff{
		no = 16064,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.053000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16065) ->
	#passi_eff{
		no = 16065,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16066) ->
	#passi_eff{
		no = 16066,
		name = add_do_phy_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.068000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16067) ->
	#passi_eff{
		no = 16067,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 38,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16068) ->
	#passi_eff{
		no = 16068,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 57,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16069) ->
	#passi_eff{
		no = 16069,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 76,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16070) ->
	#passi_eff{
		no = 16070,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 95,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16071) ->
	#passi_eff{
		no = 16071,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 114,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16072) ->
	#passi_eff{
		no = 16072,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 133,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16073) ->
	#passi_eff{
		no = 16073,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 152,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16074) ->
	#passi_eff{
		no = 16074,
		name = add_phy_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 171,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16101) ->
	#passi_eff{
		no = 16101,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 17900,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16102) ->
	#passi_eff{
		no = 16102,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 35800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16103) ->
	#passi_eff{
		no = 16103,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 53700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16104) ->
	#passi_eff{
		no = 16104,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71600,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16105) ->
	#passi_eff{
		no = 16105,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 89500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16106) ->
	#passi_eff{
		no = 16106,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 113700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16107) ->
	#passi_eff{
		no = 16107,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 143300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16108) ->
	#passi_eff{
		no = 16108,
		name = add_mag_att,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 173700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16109) ->
	#passi_eff{
		no = 16109,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.015000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16110) ->
	#passi_eff{
		no = 16110,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.023000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16111) ->
	#passi_eff{
		no = 16111,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16112) ->
	#passi_eff{
		no = 16112,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.038000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16113) ->
	#passi_eff{
		no = 16113,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.045000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16114) ->
	#passi_eff{
		no = 16114,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.053000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16115) ->
	#passi_eff{
		no = 16115,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16116) ->
	#passi_eff{
		no = 16116,
		name = add_do_mag_dam_scaling,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.068000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16117) ->
	#passi_eff{
		no = 16117,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 38,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16118) ->
	#passi_eff{
		no = 16118,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 57,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16119) ->
	#passi_eff{
		no = 16119,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 76,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16120) ->
	#passi_eff{
		no = 16120,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 95,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16121) ->
	#passi_eff{
		no = 16121,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 114,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16122) ->
	#passi_eff{
		no = 16122,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 133,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16123) ->
	#passi_eff{
		no = 16123,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 152,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16124) ->
	#passi_eff{
		no = 16124,
		name = add_mag_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 171,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16151) ->
	#passi_eff{
		no = 16151,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 35800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16152) ->
	#passi_eff{
		no = 16152,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71600,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16153) ->
	#passi_eff{
		no = 16153,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 107400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16154) ->
	#passi_eff{
		no = 16154,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 143300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16155) ->
	#passi_eff{
		no = 16155,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 179100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16156) ->
	#passi_eff{
		no = 16156,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 227400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16157) ->
	#passi_eff{
		no = 16157,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 286500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16158) ->
	#passi_eff{
		no = 16158,
		name = add_hp_lim,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 347400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16159) ->
	#passi_eff{
		no = 16159,
		name = add_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 7200,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16160) ->
	#passi_eff{
		no = 16160,
		name = add_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16161) ->
	#passi_eff{
		no = 16161,
		name = add_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 21500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16162) ->
	#passi_eff{
		no = 16162,
		name = add_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 28700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16163) ->
	#passi_eff{
		no = 16163,
		name = add_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 35800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16164) ->
	#passi_eff{
		no = 16164,
		name = add_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 45500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16165) ->
	#passi_eff{
		no = 16165,
		name = add_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 57300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16166) ->
	#passi_eff{
		no = 16166,
		name = add_phy_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 69500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16167) ->
	#passi_eff{
		no = 16167,
		name = add_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 7200,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16168) ->
	#passi_eff{
		no = 16168,
		name = add_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16169) ->
	#passi_eff{
		no = 16169,
		name = add_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 21500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16170) ->
	#passi_eff{
		no = 16170,
		name = add_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 28700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16171) ->
	#passi_eff{
		no = 16171,
		name = add_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 35800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16172) ->
	#passi_eff{
		no = 16172,
		name = add_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 45500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16173) ->
	#passi_eff{
		no = 16173,
		name = add_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 57300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16174) ->
	#passi_eff{
		no = 16174,
		name = add_mag_def,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 69500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16175) ->
	#passi_eff{
		no = 16175,
		name = add_act_speed,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16176) ->
	#passi_eff{
		no = 16176,
		name = add_act_speed,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2900,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16177) ->
	#passi_eff{
		no = 16177,
		name = add_act_speed,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16178) ->
	#passi_eff{
		no = 16178,
		name = add_act_speed,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 5700,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16179) ->
	#passi_eff{
		no = 16179,
		name = add_act_speed,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 7200,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16180) ->
	#passi_eff{
		no = 16180,
		name = add_act_speed,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 9100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16181) ->
	#passi_eff{
		no = 16181,
		name = add_act_speed,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 11500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16182) ->
	#passi_eff{
		no = 16182,
		name = add_act_speed,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13900,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16183) ->
	#passi_eff{
		no = 16183,
		name = add_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1800,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16184) ->
	#passi_eff{
		no = 16184,
		name = add_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3600,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16185) ->
	#passi_eff{
		no = 16185,
		name = add_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 5400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16186) ->
	#passi_eff{
		no = 16186,
		name = add_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 7200,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16187) ->
	#passi_eff{
		no = 16187,
		name = add_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 9000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16188) ->
	#passi_eff{
		no = 16188,
		name = add_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 11400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16189) ->
	#passi_eff{
		no = 16189,
		name = add_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 14300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16190) ->
	#passi_eff{
		no = 16190,
		name = add_seal_resis,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 17400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16191) ->
	#passi_eff{
		no = 16191,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16192) ->
	#passi_eff{
		no = 16192,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 107,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16193) ->
	#passi_eff{
		no = 16193,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 143,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16194) ->
	#passi_eff{
		no = 16194,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 179,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16195) ->
	#passi_eff{
		no = 16195,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 214,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16196) ->
	#passi_eff{
		no = 16196,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16197) ->
	#passi_eff{
		no = 16197,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 286,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16198) ->
	#passi_eff{
		no = 16198,
		name = add_phy_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 321,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16199) ->
	#passi_eff{
		no = 16199,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 71,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16200) ->
	#passi_eff{
		no = 16200,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 107,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16201) ->
	#passi_eff{
		no = 16201,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 143,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16202) ->
	#passi_eff{
		no = 16202,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 179,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16203) ->
	#passi_eff{
		no = 16203,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 214,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16204) ->
	#passi_eff{
		no = 16204,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16205) ->
	#passi_eff{
		no = 16205,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 286,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(16206) ->
	#passi_eff{
		no = 16206,
		name = add_mag_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 321,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50101) ->
	#passi_eff{
		no = 50101,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50101,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50102) ->
	#passi_eff{
		no = 50102,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50102,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50103) ->
	#passi_eff{
		no = 50103,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50103,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50104) ->
	#passi_eff{
		no = 50104,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50104,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50105) ->
	#passi_eff{
		no = 50105,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50105,
		para2 = 500,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50106) ->
	#passi_eff{
		no = 50106,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50106,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50107) ->
	#passi_eff{
		no = 50107,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50107,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50108) ->
	#passi_eff{
		no = 50108,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50108,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50109) ->
	#passi_eff{
		no = 50109,
		name = add_buff_begin_enemy_survival,
		op = 3,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50109,
		para2 = 1000,
		para3 = 1,
		para4 = 999,
		para5 = 1,
		para6 = 0,
		battle_power_coef = 0
};

get(50110) ->
	#passi_eff{
		no = 50110,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50110,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50111) ->
	#passi_eff{
		no = 50111,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50111,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50112) ->
	#passi_eff{
		no = 50112,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50112,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50113) ->
	#passi_eff{
		no = 50113,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50113,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50114) ->
	#passi_eff{
		no = 50114,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50114,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50115) ->
	#passi_eff{
		no = 50115,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50115,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50116) ->
	#passi_eff{
		no = 50116,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50116,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50117) ->
	#passi_eff{
		no = 50117,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50117,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50118) ->
	#passi_eff{
		no = 50118,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50118,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50119) ->
	#passi_eff{
		no = 50119,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50119,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50120) ->
	#passi_eff{
		no = 50120,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50120,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50121) ->
	#passi_eff{
		no = 50121,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50121,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50122) ->
	#passi_eff{
		no = 50122,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50122,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50123) ->
	#passi_eff{
		no = 50123,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50123,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50124) ->
	#passi_eff{
		no = 50124,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50124,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50125) ->
	#passi_eff{
		no = 50125,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50125,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50126) ->
	#passi_eff{
		no = 50126,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50126,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50127) ->
	#passi_eff{
		no = 50127,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50127,
		para2 = 1000,
		para3 = 200,
		para4 = 999,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50128) ->
	#passi_eff{
		no = 50128,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50128,
		para2 = 1000,
		para3 = 200,
		para4 = 999,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50129) ->
	#passi_eff{
		no = 50129,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50129,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50130) ->
	#passi_eff{
		no = 50130,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50130,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50131) ->
	#passi_eff{
		no = 50131,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50131,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50132) ->
	#passi_eff{
		no = 50132,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50132,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50133) ->
	#passi_eff{
		no = 50133,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50133,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50134) ->
	#passi_eff{
		no = 50134,
		name = protect_hp_by_rate_base_hp_lim,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50135) ->
	#passi_eff{
		no = 50135,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50134,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50221) ->
	#passi_eff{
		no = 50221,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50225,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50222) ->
	#passi_eff{
		no = 50222,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50226,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50223) ->
	#passi_eff{
		no = 50223,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50227,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50301) ->
	#passi_eff{
		no = 50301,
		name = add_buff_enemy_while_die,
		op = 3,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50309,
		para2 = 1000,
		para3 = null,
		para4 = 999,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50302) ->
	#passi_eff{
		no = 50302,
		name = add_buff_enemy_while_die,
		op = 3,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50310,
		para2 = 1000,
		para3 = null,
		para4 = 999,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50303) ->
	#passi_eff{
		no = 50303,
		name = add_buff_friend_while_die,
		op = 3,
		rules_filter_target = [enemy_side,undead],
		rules_sort_target = [],
		target_count = 10,
		para = 50311,
		para2 = 1000,
		para3 = null,
		para4 = 999,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50321) ->
	#passi_eff{
		no = 50321,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50324,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50322) ->
	#passi_eff{
		no = 50322,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50325,
		para2 = 1000,
		para3 = 500,
		para4 = 1,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50323) ->
	#passi_eff{
		no = 50323,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50326,
		para2 = 1000,
		para3 = 500,
		para4 = 1,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50324) ->
	#passi_eff{
		no = 50324,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50327,
		para2 = 1000,
		para3 = 500,
		para4 = 1,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50325) ->
	#passi_eff{
		no = 50325,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50328,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50326) ->
	#passi_eff{
		no = 50326,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50329,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50327) ->
	#passi_eff{
		no = 50327,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50330,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50328) ->
	#passi_eff{
		no = 50328,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50331,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50329) ->
	#passi_eff{
		no = 50329,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50332,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50501) ->
	#passi_eff{
		no = 50501,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50502,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50502) ->
	#passi_eff{
		no = 50502,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [sjjh_principle],
		target_count = 1,
		para = 50507,
		para2 = 1000,
		para3 = null,
		para4 = 1,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50503) ->
	#passi_eff{
		no = 50503,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [enemy_side, undead, {has_spec_no_buff, 50507}],
		rules_sort_target = [],
		target_count = 1,
		para = 50506,
		para2 = 1000,
		para3 = null,
		para4 = 1,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50504) ->
	#passi_eff{
		no = 50504,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50508,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50511) ->
	#passi_eff{
		no = 50511,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [myself, {has_spec_no_buff, 50516}],
		rules_sort_target = [],
		target_count = 1,
		para = 50512,
		para2 = 1000,
		para3 = null,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50512) ->
	#passi_eff{
		no = 50512,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50513,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50513) ->
	#passi_eff{
		no = 50513,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [ally_side,undead, {has_spec_no_buff, 50513}],
		rules_sort_target = [],
		target_count = 1,
		para = 50514,
		para2 = 1000,
		para3 = null,
		para4 = 1,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50514) ->
	#passi_eff{
		no = 50514,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50515,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50515) ->
	#passi_eff{
		no = 50515,
		name = add_buff_begin_friend_survival,
		op = 3,
		rules_filter_target = [ally_side,undead, {has_spec_no_buff, 50513}],
		rules_sort_target = [],
		target_count = 1,
		para = 50516,
		para2 = 1000,
		para3 = 1,
		para4 = 1,
		para5 = 1,
		para6 = 0,
		battle_power_coef = 0
};

get(50516) ->
	#passi_eff{
		no = 50516,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [ally_side,undead, {has_spec_no_buff, 50513}],
		rules_sort_target = [],
		target_count = 1,
		para = 50517,
		para2 = 1000,
		para3 = null,
		para4 = 1,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50521) ->
	#passi_eff{
		no = 50521,
		name = add_buff_begin_friend_survival,
		op = 3,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50524,
		para2 = 1000,
		para3 = 1,
		para4 = 999,
		para5 = 1,
		para6 = 0,
		battle_power_coef = 0
};

get(50522) ->
	#passi_eff{
		no = 50522,
		name = add_buff_begin_friend_survival,
		op = 3,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50525,
		para2 = 1000,
		para3 = 1,
		para4 = 999,
		para5 = 1,
		para6 = 0,
		battle_power_coef = 0
};

get(50523) ->
	#passi_eff{
		no = 50523,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [ally_side,undead, {has_spec_no_buff, 50524}],
		rules_sort_target = [],
		target_count = 1,
		para = 50526,
		para2 = 1000,
		para3 = null,
		para4 = 1,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50524) ->
	#passi_eff{
		no = 50524,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [ally_side,undead, {has_spec_no_buff, 50524}],
		rules_sort_target = [],
		target_count = 1,
		para = 50527,
		para2 = 1000,
		para3 = null,
		para4 = 1,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50525) ->
	#passi_eff{
		no = 50525,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50528,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50531) ->
	#passi_eff{
		no = 50531,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [],
		target_count = 10,
		para = 50534,
		para2 = 1000,
		para3 = null,
		para4 = 1,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50532) ->
	#passi_eff{
		no = 50532,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 50535,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50533) ->
	#passi_eff{
		no = 50533,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [ally_side,undead, {has_not_spec_no_buff, 50535}],
		rules_sort_target = [],
		target_count = 1,
		para = 50536,
		para2 = 1000,
		para3 = null,
		para4 = 1,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(50534) ->
	#passi_eff{
		no = 50534,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [ally_side,undead, {has_not_spec_no_buff, 50535}],
		rules_sort_target = [],
		target_count = 1,
		para = 50537,
		para2 = 1000,
		para3 = null,
		para4 = 1,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56001) ->
	#passi_eff{
		no = 56001,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40001,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56002) ->
	#passi_eff{
		no = 56002,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40002,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56003) ->
	#passi_eff{
		no = 56003,
		name = add_max_pursue_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56004) ->
	#passi_eff{
		no = 56004,
		name = add_pursue_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 140,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56005) ->
	#passi_eff{
		no = 56005,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40004,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56006) ->
	#passi_eff{
		no = 56006,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40006,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56007) ->
	#passi_eff{
		no = 56007,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40007,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56008) ->
	#passi_eff{
		no = 56008,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40008,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56009) ->
	#passi_eff{
		no = 56009,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40009,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56010) ->
	#passi_eff{
		no = 56010,
		name = add_mag_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 70,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56011) ->
	#passi_eff{
		no = 56011,
		name = add_max_mag_combo_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56012) ->
	#passi_eff{
		no = 56012,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40011,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56013) ->
	#passi_eff{
		no = 56013,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40013,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56014) ->
	#passi_eff{
		no = 56014,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40014,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56016) ->
	#passi_eff{
		no = 56016,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40016,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56017) ->
	#passi_eff{
		no = 56017,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40017,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56018) ->
	#passi_eff{
		no = 56018,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40020,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(56019) ->
	#passi_eff{
		no = 56019,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 230001,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(100001) ->
	#passi_eff{
		no = 100001,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1060,
		para2 = 0,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(100002) ->
	#passi_eff{
		no = 100002,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 105,
		para2 = 0,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(100003) ->
	#passi_eff{
		no = 100003,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 105,
		para2 = 0,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(100004) ->
	#passi_eff{
		no = 100004,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 210,
		para2 = 0,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(100005) ->
	#passi_eff{
		no = 100005,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 210,
		para2 = 0,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(100006) ->
	#passi_eff{
		no = 100006,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 40,
		para2 = 0,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(100007) ->
	#passi_eff{
		no = 100007,
		name = add_seal_hit,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 25,
		para2 = 0,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(100008) ->
	#passi_eff{
		no = 100008,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 55,
		para2 = 0,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(100462) ->
	#passi_eff{
		no = 100462,
		name = add_phy_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 20,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(100471) ->
	#passi_eff{
		no = 100471,
		name = add_do_mag_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.020000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(100493) ->
	#passi_eff{
		no = 100493,
		name = add_seal_resis,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.225000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200010) ->
	#passi_eff{
		no = 200010,
		name = add_strikeback_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200020) ->
	#passi_eff{
		no = 200020,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200021) ->
	#passi_eff{
		no = 200021,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.500000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200040) ->
	#passi_eff{
		no = 200040,
		name = add_neglect_ret_dam,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200041) ->
	#passi_eff{
		no = 200041,
		name = add_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.015000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200050) ->
	#passi_eff{
		no = 200050,
		name = add_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200060) ->
	#passi_eff{
		no = 200060,
		name = add_do_mag_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.080000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.080000
};

get(200070) ->
	#passi_eff{
		no = 200070,
		name = reduce_be_mag_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200071) ->
	#passi_eff{
		no = 200071,
		name = protect_hp_by_rate_base_hp_lim,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.900000,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200072) ->
	#passi_eff{
		no = 200072,
		name = reduce_be_mag_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200090) ->
	#passi_eff{
		no = 200090,
		name = add_be_heal_eff_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200100) ->
	#passi_eff{
		no = 200100,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2.500000,
		para2 = 30,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200110) ->
	#passi_eff{
		no = 200110,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2.500000,
		para2 = 30,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200120) ->
	#passi_eff{
		no = 200120,
		name = reduce_be_mag_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = -0.050000
};

get(200121) ->
	#passi_eff{
		no = 200121,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 6,
		para2 = 60,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200130) ->
	#passi_eff{
		no = 200130,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 6,
		para2 = 60,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200131) ->
	#passi_eff{
		no = 200131,
		name = reduce_be_phy_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200140) ->
	#passi_eff{
		no = 200140,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 6,
		para2 = 60,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200141) ->
	#passi_eff{
		no = 200141,
		name = reduce_be_phy_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = -0.050000
};

get(200150) ->
	#passi_eff{
		no = 200150,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 6,
		para2 = 60,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200151) ->
	#passi_eff{
		no = 200151,
		name = reduce_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200160) ->
	#passi_eff{
		no = 200160,
		name = add_anti_invisible_status,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = null,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200170) ->
	#passi_eff{
		no = 200170,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4066,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200171) ->
	#passi_eff{
		no = 200171,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4067,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200180) ->
	#passi_eff{
		no = 200180,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4068,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200181) ->
	#passi_eff{
		no = 200181,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4070,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200182) ->
	#passi_eff{
		no = 200182,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4069,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200183) ->
	#passi_eff{
		no = 200183,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4071,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200190) ->
	#passi_eff{
		no = 200190,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4072,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200191) ->
	#passi_eff{
		no = 200191,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4074,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200192) ->
	#passi_eff{
		no = 200192,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4073,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200193) ->
	#passi_eff{
		no = 200193,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4075,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200200) ->
	#passi_eff{
		no = 200200,
		name = add_qugui_status,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = null,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200201) ->
	#passi_eff{
		no = 200201,
		name = add_qugui_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.500000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200220) ->
	#passi_eff{
		no = 200220,
		name = add_mag_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 150,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200221) ->
	#passi_eff{
		no = 200221,
		name = add_max_mag_combo_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200222) ->
	#passi_eff{
		no = 200222,
		name = add_pursue_att_dam_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.500000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200230) ->
	#passi_eff{
		no = 200230,
		name = add_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200250) ->
	#passi_eff{
		no = 200250,
		name = add_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.080000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200260) ->
	#passi_eff{
		no = 200260,
		name = add_phy_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 450,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200261) ->
	#passi_eff{
		no = 200261,
		name = reduce_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200262) ->
	#passi_eff{
		no = 200262,
		name = add_max_phy_combo_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200270) ->
	#passi_eff{
		no = 200270,
		name = add_ghost_prep_status,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.500000,
		para2 = 5,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200271) ->
	#passi_eff{
		no = 200271,
		name = reduce_be_heal_eff_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.500000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200272) ->
	#passi_eff{
		no = 200272,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1.500000,
		para2 = 5,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200273) ->
	#passi_eff{
		no = 200273,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2,
		para2 = 10,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200290) ->
	#passi_eff{
		no = 200290,
		name = add_absorb_hp_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200310) ->
	#passi_eff{
		no = 200310,
		name = add_reborn_prep_status,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.600000,
		para2 = 200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200320) ->
	#passi_eff{
		no = 200320,
		name = add_max_pursue_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200321) ->
	#passi_eff{
		no = 200321,
		name = add_pursue_att_dam_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.500000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200322) ->
	#passi_eff{
		no = 200322,
		name = add_pursue_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200330) ->
	#passi_eff{
		no = 200330,
		name = add_invisible_status,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200340) ->
	#passi_eff{
		no = 200340,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1007,
		para2 = 100,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200350) ->
	#passi_eff{
		no = 200350,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1009,
		para2 = 200,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200360) ->
	#passi_eff{
		no = 200360,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1011,
		para2 = 200,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200370) ->
	#passi_eff{
		no = 200370,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1013,
		para2 = 180,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200380) ->
	#passi_eff{
		no = 200380,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1015,
		para2 = 180,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200390) ->
	#passi_eff{
		no = 200390,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1017,
		para2 = 150,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200400) ->
	#passi_eff{
		no = 200400,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1019,
		para2 = 150,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200410) ->
	#passi_eff{
		no = 200410,
		name = lengthen_good_buff_lasting_round,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200420) ->
	#passi_eff{
		no = 200420,
		name = hot_mp,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.010000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200430) ->
	#passi_eff{
		no = 200430,
		name = hot_hp,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.010000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200440) ->
	#passi_eff{
		no = 200440,
		name = force_change_bad_buff_lasting_round,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(200450) ->
	#passi_eff{
		no = 200450,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4000,
		para2 = 120,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(200451) ->
	#passi_eff{
		no = 200451,
		name = reduce_do_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(200452) ->
	#passi_eff{
		no = 200452,
		name = add_be_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300010) ->
	#passi_eff{
		no = 300010,
		name = add_strikeback_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300020) ->
	#passi_eff{
		no = 300020,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 400,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300021) ->
	#passi_eff{
		no = 300021,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.700000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300030) ->
	#passi_eff{
		no = 300030,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4037,
		para2 = 500,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300031) ->
	#passi_eff{
		no = 300031,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2,
		para2 = 30,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300040) ->
	#passi_eff{
		no = 300040,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 6,
		para2 = 60,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300041) ->
	#passi_eff{
		no = 300041,
		name = add_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.025000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300050) ->
	#passi_eff{
		no = 300050,
		name = add_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 200,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = -0.100000
};

get(300060) ->
	#passi_eff{
		no = 300060,
		name = add_do_mag_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.120000
};

get(300070) ->
	#passi_eff{
		no = 300070,
		name = reduce_be_mag_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300071) ->
	#passi_eff{
		no = 300071,
		name = protect_hp_by_rate_base_hp_lim,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.700000,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300072) ->
	#passi_eff{
		no = 300072,
		name = reduce_be_mag_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300090) ->
	#passi_eff{
		no = 300090,
		name = add_be_heal_eff_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300100) ->
	#passi_eff{
		no = 300100,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4,
		para2 = 60,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300110) ->
	#passi_eff{
		no = 300110,
		name = reduce_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4,
		para2 = 60,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.400000
};

get(300120) ->
	#passi_eff{
		no = 300120,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 9,
		para2 = 120,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300130) ->
	#passi_eff{
		no = 300130,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 9,
		para2 = 120,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300131) ->
	#passi_eff{
		no = 300131,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 25,
		para2 = 200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300140) ->
	#passi_eff{
		no = 300140,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 9,
		para2 = 120,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300150) ->
	#passi_eff{
		no = 300150,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 9,
		para2 = 120,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300151) ->
	#passi_eff{
		no = 300151,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 25,
		para2 = 200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300160) ->
	#passi_eff{
		no = 300160,
		name = add_anti_invisible_status,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = null,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300161) ->
	#passi_eff{
		no = 300161,
		name = add_crit,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = 50,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.150000
};

get(300170) ->
	#passi_eff{
		no = 300170,
		name = add_chaos_resis,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300180) ->
	#passi_eff{
		no = 300180,
		name = add_trance_resis,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300190) ->
	#passi_eff{
		no = 300190,
		name = add_frozen_resis,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300200) ->
	#passi_eff{
		no = 300200,
		name = add_qugui_status,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = null,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(300201) ->
	#passi_eff{
		no = 300201,
		name = add_qugui_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300220) ->
	#passi_eff{
		no = 300220,
		name = add_mag_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(300221) ->
	#passi_eff{
		no = 300221,
		name = add_max_mag_combo_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300230) ->
	#passi_eff{
		no = 300230,
		name = add_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 250,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300250) ->
	#passi_eff{
		no = 300250,
		name = add_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.120000
};

get(300260) ->
	#passi_eff{
		no = 300260,
		name = add_phy_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 550,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300261) ->
	#passi_eff{
		no = 300261,
		name = reduce_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300262) ->
	#passi_eff{
		no = 300262,
		name = add_max_phy_combo_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300270) ->
	#passi_eff{
		no = 300270,
		name = add_ghost_prep_status,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = 5,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300271) ->
	#passi_eff{
		no = 300271,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2.200000,
		para2 = 10,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(300272) ->
	#passi_eff{
		no = 300272,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3.200000,
		para2 = 15,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(300290) ->
	#passi_eff{
		no = 300290,
		name = add_absorb_hp_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.300000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300310) ->
	#passi_eff{
		no = 300310,
		name = add_reborn_prep_status,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = 300,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(300320) ->
	#passi_eff{
		no = 300320,
		name = add_max_pursue_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300321) ->
	#passi_eff{
		no = 300321,
		name = add_pursue_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300322) ->
	#passi_eff{
		no = 300322,
		name = add_pursue_att_dam_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300330) ->
	#passi_eff{
		no = 300330,
		name = add_invisible_status,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 5,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300340) ->
	#passi_eff{
		no = 300340,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1008,
		para2 = 150,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300350) ->
	#passi_eff{
		no = 300350,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1010,
		para2 = 250,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300360) ->
	#passi_eff{
		no = 300360,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1012,
		para2 = 350,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300370) ->
	#passi_eff{
		no = 300370,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1014,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300380) ->
	#passi_eff{
		no = 300380,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1016,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.150000
};

get(300390) ->
	#passi_eff{
		no = 300390,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1018,
		para2 = 200,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300400) ->
	#passi_eff{
		no = 300400,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1020,
		para2 = 300,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300410) ->
	#passi_eff{
		no = 300410,
		name = lengthen_good_buff_lasting_round,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300420) ->
	#passi_eff{
		no = 300420,
		name = hot_mp,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300430) ->
	#passi_eff{
		no = 300430,
		name = hot_hp,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300440) ->
	#passi_eff{
		no = 300440,
		name = force_change_bad_buff_lasting_round,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300450) ->
	#passi_eff{
		no = 300450,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4000,
		para2 = 200,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(300451) ->
	#passi_eff{
		no = 300451,
		name = reduce_do_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(300452) ->
	#passi_eff{
		no = 300452,
		name = add_be_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600010) ->
	#passi_eff{
		no = 600010,
		name = add_act_speed,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600020) ->
	#passi_eff{
		no = 600020,
		name = add_act_speed,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600030) ->
	#passi_eff{
		no = 600030,
		name = add_act_speed,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600110) ->
	#passi_eff{
		no = 600110,
		name = add_be_mag_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600120) ->
	#passi_eff{
		no = 600120,
		name = add_be_mag_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600130) ->
	#passi_eff{
		no = 600130,
		name = add_be_mag_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600210) ->
	#passi_eff{
		no = 600210,
		name = add_be_phy_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600220) ->
	#passi_eff{
		no = 600220,
		name = add_be_phy_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600230) ->
	#passi_eff{
		no = 600230,
		name = add_be_phy_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600310) ->
	#passi_eff{
		no = 600310,
		name = add_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600320) ->
	#passi_eff{
		no = 600320,
		name = add_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600330) ->
	#passi_eff{
		no = 600330,
		name = add_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600410) ->
	#passi_eff{
		no = 600410,
		name = add_do_mag_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600420) ->
	#passi_eff{
		no = 600420,
		name = add_do_mag_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600430) ->
	#passi_eff{
		no = 600430,
		name = add_do_mag_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600510) ->
	#passi_eff{
		no = 600510,
		name = reduce_anger_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600511) ->
	#passi_eff{
		no = 600511,
		name = reduce_anger_on_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600520) ->
	#passi_eff{
		no = 600520,
		name = reduce_anger_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600521) ->
	#passi_eff{
		no = 600521,
		name = reduce_anger_on_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600530) ->
	#passi_eff{
		no = 600530,
		name = reduce_anger_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(600531) ->
	#passi_eff{
		no = 600531,
		name = reduce_anger_on_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1001110) ->
	#passi_eff{
		no = 1001110,
		name = add_phy_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(1001111) ->
	#passi_eff{
		no = 1001111,
		name = add_max_phy_combo_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2000011) ->
	#passi_eff{
		no = 2000011,
		name = add_be_phy_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.850000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2000012) ->
	#passi_eff{
		no = 2000012,
		name = reduce_do_mag_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2000021) ->
	#passi_eff{
		no = 2000021,
		name = add_be_mag_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.850000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2000022) ->
	#passi_eff{
		no = 2000022,
		name = reduce_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2000031) ->
	#passi_eff{
		no = 2000031,
		name = add_be_phy_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2000032) ->
	#passi_eff{
		no = 2000032,
		name = add_be_mag_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(2000041) ->
	#passi_eff{
		no = 2000041,
		name = add_hp_lim,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.800000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000010) ->
	#passi_eff{
		no = 3000010,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4000,
		para2 = 90,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000011) ->
	#passi_eff{
		no = 3000011,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4000,
		para2 = 120,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000012) ->
	#passi_eff{
		no = 3000012,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4000,
		para2 = 150,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000013) ->
	#passi_eff{
		no = 3000013,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4000,
		para2 = 180,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000014) ->
	#passi_eff{
		no = 3000014,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4000,
		para2 = 210,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000015) ->
	#passi_eff{
		no = 3000015,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4001,
		para2 = 140,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000016) ->
	#passi_eff{
		no = 3000016,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4001,
		para2 = 200,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000017) ->
	#passi_eff{
		no = 3000017,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4001,
		para2 = 260,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000018) ->
	#passi_eff{
		no = 3000018,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4001,
		para2 = 320,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000019) ->
	#passi_eff{
		no = 3000019,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4001,
		para2 = 400,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000020) ->
	#passi_eff{
		no = 3000020,
		name = reduce_hp_on_phy_att_hit_base_target_mg_lim ,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = 100,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000021) ->
	#passi_eff{
		no = 3000021,
		name = reduce_hp_on_phy_att_hit_base_target_mg_lim ,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = 150,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000022) ->
	#passi_eff{
		no = 3000022,
		name = reduce_hp_on_phy_att_hit_base_target_mg_lim ,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = 200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000023) ->
	#passi_eff{
		no = 3000023,
		name = reduce_hp_on_phy_att_hit_base_target_mg_lim ,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = 250,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000024) ->
	#passi_eff{
		no = 3000024,
		name = reduce_hp_on_phy_att_hit_base_target_mg_lim ,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = 300,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000025) ->
	#passi_eff{
		no = 3000025,
		name = reduce_hp_on_phy_att_hit_base_mg,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = 150,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000026) ->
	#passi_eff{
		no = 3000026,
		name = reduce_hp_on_phy_att_hit_base_mg,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = 200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000027) ->
	#passi_eff{
		no = 3000027,
		name = reduce_hp_on_phy_att_hit_base_mg,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = 250,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000028) ->
	#passi_eff{
		no = 3000028,
		name = reduce_hp_on_phy_att_hit_base_mg,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = 300,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000029) ->
	#passi_eff{
		no = 3000029,
		name = reduce_hp_on_phy_att_hit_base_mg,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = 350,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000030) ->
	#passi_eff{
		no = 3000030,
		name = change_phy_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000031) ->
	#passi_eff{
		no = 3000031,
		name = change_phy_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000032) ->
	#passi_eff{
		no = 3000032,
		name = change_phy_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 11,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000033) ->
	#passi_eff{
		no = 3000033,
		name = change_phy_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 9,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000034) ->
	#passi_eff{
		no = 3000034,
		name = change_phy_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 7,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000035) ->
	#passi_eff{
		no = 3000035,
		name = change_mag_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 15,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000036) ->
	#passi_eff{
		no = 3000036,
		name = change_mag_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000037) ->
	#passi_eff{
		no = 3000037,
		name = change_mag_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 11,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000038) ->
	#passi_eff{
		no = 3000038,
		name = change_mag_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 9,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000039) ->
	#passi_eff{
		no = 3000039,
		name = change_mag_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 7,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000040) ->
	#passi_eff{
		no = 3000040,
		name = change_phy_def_when_hp_change_by_rate,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = 1000,
		para3 = 0.010000,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000041) ->
	#passi_eff{
		no = 3000041,
		name = change_phy_def_when_hp_change_by_rate,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.036000,
		para2 = 1000,
		para3 = 0.010000,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000042) ->
	#passi_eff{
		no = 3000042,
		name = change_phy_def_when_hp_change_by_rate,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.032000,
		para2 = 1000,
		para3 = 0.010000,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000043) ->
	#passi_eff{
		no = 3000043,
		name = change_phy_def_when_hp_change_by_rate,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.028000,
		para2 = 1000,
		para3 = 0.010000,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000044) ->
	#passi_eff{
		no = 3000044,
		name = change_phy_def_when_hp_change_by_rate,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.024000,
		para2 = 1000,
		para3 = 0.010000,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000045) ->
	#passi_eff{
		no = 3000045,
		name = change_mag_def_when_hp_change_by_rate,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = 1000,
		para3 = 0.010000,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000046) ->
	#passi_eff{
		no = 3000046,
		name = change_mag_def_when_hp_change_by_rate,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.036000,
		para2 = 1000,
		para3 = 0.010000,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000047) ->
	#passi_eff{
		no = 3000047,
		name = change_mag_def_when_hp_change_by_rate,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.032000,
		para2 = 1000,
		para3 = 0.010000,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000048) ->
	#passi_eff{
		no = 3000048,
		name = change_mag_def_when_hp_change_by_rate,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.028000,
		para2 = 1000,
		para3 = 0.010000,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000049) ->
	#passi_eff{
		no = 3000049,
		name = change_mag_def_when_hp_change_by_rate,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.024000,
		para2 = 1000,
		para3 = 0.010000,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000050) ->
	#passi_eff{
		no = 3000050,
		name = protect_hp_by_rate_base_hp_lim,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.700000,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000051) ->
	#passi_eff{
		no = 3000051,
		name = protect_hp_by_rate_base_hp_lim,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.600000,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000052) ->
	#passi_eff{
		no = 3000052,
		name = protect_hp_by_rate_base_hp_lim,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.500000,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000053) ->
	#passi_eff{
		no = 3000053,
		name = protect_hp_by_rate_base_hp_lim,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.420000,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000054) ->
	#passi_eff{
		no = 3000054,
		name = protect_hp_by_rate_base_hp_lim,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.360000,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000055) ->
	#passi_eff{
		no = 3000055,
		name = hot_phy_att,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000056) ->
	#passi_eff{
		no = 3000056,
		name = hot_phy_att,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000057) ->
	#passi_eff{
		no = 3000057,
		name = hot_phy_att,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000058) ->
	#passi_eff{
		no = 3000058,
		name = hot_phy_att,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000059) ->
	#passi_eff{
		no = 3000059,
		name = hot_phy_att,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000060) ->
	#passi_eff{
		no = 3000060,
		name = hot_mag_att,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000061) ->
	#passi_eff{
		no = 3000061,
		name = hot_mag_att,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.040000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000062) ->
	#passi_eff{
		no = 3000062,
		name = hot_mag_att,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000063) ->
	#passi_eff{
		no = 3000063,
		name = hot_mag_att,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000064) ->
	#passi_eff{
		no = 3000064,
		name = hot_mag_att,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000065) ->
	#passi_eff{
		no = 3000065,
		name = add_ret_dam_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000066) ->
	#passi_eff{
		no = 3000066,
		name = add_ret_dam_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000067) ->
	#passi_eff{
		no = 3000067,
		name = add_ret_dam_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 140,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000068) ->
	#passi_eff{
		no = 3000068,
		name = add_ret_dam_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.160000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000069) ->
	#passi_eff{
		no = 3000069,
		name = add_ret_dam_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 180,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000070) ->
	#passi_eff{
		no = 3000070,
		name = add_ret_dam_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000071) ->
	#passi_eff{
		no = 3000071,
		name = add_ret_dam_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 220,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000072) ->
	#passi_eff{
		no = 3000072,
		name = add_ret_dam_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.240000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000073) ->
	#passi_eff{
		no = 3000073,
		name = add_ret_dam_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 260,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000074) ->
	#passi_eff{
		no = 3000074,
		name = add_ret_dam_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.300000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000075) ->
	#passi_eff{
		no = 3000075,
		name = add_strikeback_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000076) ->
	#passi_eff{
		no = 3000076,
		name = add_strikeback_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 140,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000077) ->
	#passi_eff{
		no = 3000077,
		name = add_strikeback_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 180,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000078) ->
	#passi_eff{
		no = 3000078,
		name = add_strikeback_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 220,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000079) ->
	#passi_eff{
		no = 3000079,
		name = add_strikeback_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 260,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000080) ->
	#passi_eff{
		no = 3000080,
		name = add_mag_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 80,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000081) ->
	#passi_eff{
		no = 3000081,
		name = add_mag_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000082) ->
	#passi_eff{
		no = 3000082,
		name = add_mag_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 120,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000083) ->
	#passi_eff{
		no = 3000083,
		name = add_mag_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 140,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000084) ->
	#passi_eff{
		no = 3000084,
		name = add_mag_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 160,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000085) ->
	#passi_eff{
		no = 3000085,
		name = reduce_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.280000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000086) ->
	#passi_eff{
		no = 3000086,
		name = add_max_phy_combo_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000087) ->
	#passi_eff{
		no = 3000087,
		name = reduce_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.340000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000088) ->
	#passi_eff{
		no = 3000088,
		name = add_max_phy_combo_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000089) ->
	#passi_eff{
		no = 3000089,
		name = reduce_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.420000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000090) ->
	#passi_eff{
		no = 3000090,
		name = add_max_phy_combo_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000091) ->
	#passi_eff{
		no = 3000091,
		name = reduce_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.480000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000092) ->
	#passi_eff{
		no = 3000092,
		name = add_max_phy_combo_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000093) ->
	#passi_eff{
		no = 3000093,
		name = reduce_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.520000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000094) ->
	#passi_eff{
		no = 3000094,
		name = add_max_phy_combo_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 5,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000095) ->
	#passi_eff{
		no = 3000095,
		name = add_absorb_hp_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000096) ->
	#passi_eff{
		no = 3000096,
		name = add_absorb_hp_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000097) ->
	#passi_eff{
		no = 3000097,
		name = add_absorb_hp_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000098) ->
	#passi_eff{
		no = 3000098,
		name = add_absorb_hp_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.180000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000099) ->
	#passi_eff{
		no = 3000099,
		name = add_absorb_hp_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.230000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000100) ->
	#passi_eff{
		no = 3000100,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4102,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000101) ->
	#passi_eff{
		no = 3000101,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4030,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000102) ->
	#passi_eff{
		no = 3000102,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4036,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(3000103) ->
	#passi_eff{
		no = 3000103,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4037,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000001) ->
	#passi_eff{
		no = 4000001,
		name = protect_hp_by_rate_base_hp_lim,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000002) ->
	#passi_eff{
		no = 4000002,
		name = change_phy_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 25,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000003) ->
	#passi_eff{
		no = 4000003,
		name = change_mag_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 25,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000004) ->
	#passi_eff{
		no = 4000004,
		name = add_buff_on_be_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4048,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000005) ->
	#passi_eff{
		no = 4000005,
		name = add_buff_on_be_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4049,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000006) ->
	#passi_eff{
		no = 4000006,
		name = add_buff_on_be_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4050,
		para2 = 1000,
		para3 = all_enemy,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000007) ->
	#passi_eff{
		no = 4000007,
		name = add_buff_on_be_mag_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4051,
		para2 = 1000,
		para3 = all_ally,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000008) ->
	#passi_eff{
		no = 4000008,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4057,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000009) ->
	#passi_eff{
		no = 4000009,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4058,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000010) ->
	#passi_eff{
		no = 4000010,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4059,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000011) ->
	#passi_eff{
		no = 4000011,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4060,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000012) ->
	#passi_eff{
		no = 4000012,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4061,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000020) ->
	#passi_eff{
		no = 4000020,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4091,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000013) ->
	#passi_eff{
		no = 4000013,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4063,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000014) ->
	#passi_eff{
		no = 4000014,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 84057,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000015) ->
	#passi_eff{
		no = 4000015,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 84058,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000016) ->
	#passi_eff{
		no = 4000016,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 84059,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000017) ->
	#passi_eff{
		no = 4000017,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 84060,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000018) ->
	#passi_eff{
		no = 4000018,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 84061,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000019) ->
	#passi_eff{
		no = 4000019,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 84063,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000021) ->
	#passi_eff{
		no = 4000021,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 84091,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000022) ->
	#passi_eff{
		no = 4000022,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4083,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000023) ->
	#passi_eff{
		no = 4000023,
		name = add_phy_combo_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(4000024) ->
	#passi_eff{
		no = 4000024,
		name = add_max_phy_combo_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000025) ->
	#passi_eff{
		no = 4000025,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4088,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(4000026) ->
	#passi_eff{
		no = 4000026,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4089,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000027) ->
	#passi_eff{
		no = 4000027,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4037,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000028) ->
	#passi_eff{
		no = 4000028,
		name = reduce_be_mag_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000029) ->
	#passi_eff{
		no = 4000029,
		name = reduce_be_phy_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 2,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000030) ->
	#passi_eff{
		no = 4000030,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4104,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000031) ->
	#passi_eff{
		no = 4000031,
		name = dam_is_full,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = null,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000032) ->
	#passi_eff{
		no = 4000032,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4123,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000033) ->
	#passi_eff{
		no = 4000033,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4124,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000034) ->
	#passi_eff{
		no = 4000034,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4125,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000035) ->
	#passi_eff{
		no = 4000035,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4126,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000036) ->
	#passi_eff{
		no = 4000036,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4131,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000037) ->
	#passi_eff{
		no = 4000037,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4132,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000038) ->
	#passi_eff{
		no = 4000038,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000039) ->
	#passi_eff{
		no = 4000039,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.800000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000040) ->
	#passi_eff{
		no = 4000040,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4136,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000041) ->
	#passi_eff{
		no = 4000041,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4137,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000042) ->
	#passi_eff{
		no = 4000042,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4142,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000043) ->
	#passi_eff{
		no = 4000043,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000044) ->
	#passi_eff{
		no = 4000044,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.800000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000045) ->
	#passi_eff{
		no = 4000045,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4148,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000046) ->
	#passi_eff{
		no = 4000046,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4153,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000047) ->
	#passi_eff{
		no = 4000047,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4154,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000048) ->
	#passi_eff{
		no = 4000048,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4158,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000049) ->
	#passi_eff{
		no = 4000049,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4161,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000050) ->
	#passi_eff{
		no = 4000050,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4057,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000051) ->
	#passi_eff{
		no = 4000051,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4164,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000052) ->
	#passi_eff{
		no = 4000052,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4173,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000053) ->
	#passi_eff{
		no = 4000053,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4174,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000054) ->
	#passi_eff{
		no = 4000054,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4176,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000055) ->
	#passi_eff{
		no = 4000055,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4173,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000056) ->
	#passi_eff{
		no = 4000056,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4174,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000057) ->
	#passi_eff{
		no = 4000057,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4180,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000058) ->
	#passi_eff{
		no = 4000058,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4181,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000059) ->
	#passi_eff{
		no = 4000059,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4184,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000060) ->
	#passi_eff{
		no = 4000060,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4189,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000061) ->
	#passi_eff{
		no = 4000061,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4197,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000062) ->
	#passi_eff{
		no = 4000062,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4198,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000063) ->
	#passi_eff{
		no = 4000063,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4199,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000064) ->
	#passi_eff{
		no = 4000064,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4203,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000065) ->
	#passi_eff{
		no = 4000065,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4204,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000066) ->
	#passi_eff{
		no = 4000066,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4191,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000067) ->
	#passi_eff{
		no = 4000067,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4210,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000068) ->
	#passi_eff{
		no = 4000068,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4216,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000069) ->
	#passi_eff{
		no = 4000069,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4219,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400010) ->
	#passi_eff{
		no = 400010,
		name = hot_mp,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(400011) ->
	#passi_eff{
		no = 400011,
		name = hot_hp,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(400012) ->
	#passi_eff{
		no = 400012,
		name = change_phy_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = 1000,
		para3 = 30,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400013) ->
	#passi_eff{
		no = 400013,
		name = change_mag_att_when_hp_change,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = 1000,
		para3 = 30,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400014) ->
	#passi_eff{
		no = 400014,
		name = change_phy_def_when_hp_change_by_rate,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400015) ->
	#passi_eff{
		no = 400015,
		name = change_mag_def_when_hp_change_by_rate,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 10,
		para2 = 1000,
		para3 = 1,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400016) ->
	#passi_eff{
		no = 400016,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4222,
		para2 = 300,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400017) ->
	#passi_eff{
		no = 400017,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4223,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400018) ->
	#passi_eff{
		no = 400018,
		name = add_seal_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4,
		para2 = 20,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(400019) ->
	#passi_eff{
		no = 400019,
		name = add_chaos_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4,
		para2 = 20,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(400020) ->
	#passi_eff{
		no = 400020,
		name = add_trance_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4,
		para2 = 20,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(400021) ->
	#passi_eff{
		no = 400021,
		name = add_frozen_resis,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4,
		para2 = 20,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.100000
};

get(400022) ->
	#passi_eff{
		no = 400022,
		name = reduce_hp_on_phy_att_hit_base_target_mg_lim ,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.300000,
		para2 = 300,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400023) ->
	#passi_eff{
		no = 400023,
		name = reduce_hp_on_phy_att_hit_base_mg,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = 350,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400024) ->
	#passi_eff{
		no = 400024,
		name = reduce_hp_on_mag_att_hit_base_mg,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = 350,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400025) ->
	#passi_eff{
		no = 400025,
		name = shorten_bad_buff_lasting_round,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 3,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(400026) ->
	#passi_eff{
		no = 400026,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4224,
		para2 = 350,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400027) ->
	#passi_eff{
		no = 400027,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4225,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400028) ->
	#passi_eff{
		no = 400028,
		name = protect_hp_by_rate_base_hp_lim,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.600000,
		para2 = 500,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400029) ->
	#passi_eff{
		no = 400029,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4220,
		para2 = 300,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400030) ->
	#passi_eff{
		no = 400030,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4000,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400031) ->
	#passi_eff{
		no = 400031,
		name = add_do_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(400032) ->
	#passi_eff{
		no = 400032,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.250000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400033) ->
	#passi_eff{
		no = 400033,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4226,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400034) ->
	#passi_eff{
		no = 400034,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4227,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400035) ->
	#passi_eff{
		no = 400035,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4228,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400036) ->
	#passi_eff{
		no = 400036,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4229,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400037) ->
	#passi_eff{
		no = 400037,
		name = add_do_mag_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(400038) ->
	#passi_eff{
		no = 400038,
		name = add_do_phy_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(400039) ->
	#passi_eff{
		no = 400039,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4230,
		para2 = 400,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(400040) ->
	#passi_eff{
		no = 400040,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4231,
		para2 = 400,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.150000
};

get(400041) ->
	#passi_eff{
		no = 400041,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4232,
		para2 = 400,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(400042) ->
	#passi_eff{
		no = 400042,
		name = add_be_heal_eff_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.300000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.300000
};

get(400043) ->
	#passi_eff{
		no = 400043,
		name = add_hp_lim,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = 1,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400044) ->
	#passi_eff{
		no = 400044,
		name = add_phy_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13,
		para2 = 200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400045) ->
	#passi_eff{
		no = 400045,
		name = add_mag_def,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13,
		para2 = 200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400046) ->
	#passi_eff{
		no = 400046,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4233,
		para2 = 500,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400047) ->
	#passi_eff{
		no = 400047,
		name = add_phy_crit_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400048) ->
	#passi_eff{
		no = 400048,
		name = add_mag_crit_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400049) ->
	#passi_eff{
		no = 400049,
		name = add_absorb_hp_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.400000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(400050) ->
	#passi_eff{
		no = 400050,
		name = add_max_pursue_att_times,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400051) ->
	#passi_eff{
		no = 400051,
		name = add_pursue_att_proba,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400052) ->
	#passi_eff{
		no = 400052,
		name = add_pursue_att_dam_coef,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 1.500000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400053) ->
	#passi_eff{
		no = 400053,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 500,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400054) ->
	#passi_eff{
		no = 400054,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.800000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400055) ->
	#passi_eff{
		no = 400055,
		name = add_ten,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 300,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400056) ->
	#passi_eff{
		no = 400056,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4234,
		para2 = 350,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(400057) ->
	#passi_eff{
		no = 400057,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4235,
		para2 = 400,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(400058) ->
	#passi_eff{
		no = 400058,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4236,
		para2 = 300,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0.200000
};

get(400059) ->
	#passi_eff{
		no = 400059,
		name = add_phy_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13,
		para2 = 200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400060) ->
	#passi_eff{
		no = 400060,
		name = add_mag_att,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 13,
		para2 = 200,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400061) ->
	#passi_eff{
		no = 400061,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4237,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400062) ->
	#passi_eff{
		no = 400062,
		name = add_anti_invisible_status,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = null,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400063) ->
	#passi_eff{
		no = 400063,
		name = add_crit,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 100,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400064) ->
	#passi_eff{
		no = 400064,
		name = add_act_speed,
		op = 2,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 7,
		para2 = 60,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(400065) ->
	#passi_eff{
		no = 400065,
		name = add_do_dam_scaling,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000070) ->
	#passi_eff{
		no = 4000070,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4271,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000071) ->
	#passi_eff{
		no = 4000071,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4275,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000072) ->
	#passi_eff{
		no = 4000072,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4276,
		para2 = 1000,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000073) ->
	#passi_eff{
		no = 4000073,
		name = add_ret_dam_proba,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 60,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000074) ->
	#passi_eff{
		no = 4000074,
		name = add_ret_dam_coef,
		op = 1,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 0.500000,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000075) ->
	#passi_eff{
		no = 4000075,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4281,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000076) ->
	#passi_eff{
		no = 4000076,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4284,
		para2 = 300,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000077) ->
	#passi_eff{
		no = 4000077,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4285,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000078) ->
	#passi_eff{
		no = 4000078,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4288,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000079) ->
	#passi_eff{
		no = 4000079,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4289,
		para2 = 1000,
		para3 = atter,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000080) ->
	#passi_eff{
		no = 4000080,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4292,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000081) ->
	#passi_eff{
		no = 4000081,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4296,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(4000082) ->
	#passi_eff{
		no = 4000082,
		name = add_buff_on_be_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4297,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000001) ->
	#passi_eff{
		no = 1000001,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4182,
		para2 = 1000,
		para3 = 500,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000002) ->
	#passi_eff{
		no = 1000002,
		name = add_buff_begin_friend_survival,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4182,
		para2 = 1000,
		para3 = 3,
		para4 = 2,
		para5 = 1,
		para6 = 0,
		battle_power_coef = 0
};

get(1000003) ->
	#passi_eff{
		no = 1000003,
		name = add_buff_begin_enemy_survival,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4182,
		para2 = 1000,
		para3 = 3,
		para4 = 2,
		para5 = 1,
		para6 = 0,
		battle_power_coef = 0
};

get(1000004) ->
	#passi_eff{
		no = 1000004,
		name = add_buff_action_friend_survival,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4298,
		para2 = 1000,
		para3 = 3,
		para4 = 2,
		para5 = 1,
		para6 = 2,
		battle_power_coef = 0
};

get(1000005) ->
	#passi_eff{
		no = 1000005,
		name = add_buff_action_enemy_survival,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4301,
		para2 = 1000,
		para3 = 3,
		para4 = 2,
		para5 = 1,
		para6 = 2,
		battle_power_coef = 0
};

get(1000006) ->
	#passi_eff{
		no = 1000006,
		name = add_buff_enemy_while_die,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4182,
		para2 = 1000,
		para3 = null,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000007) ->
	#passi_eff{
		no = 1000007,
		name = add_buff_friend_while_die,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4301,
		para2 = 1000,
		para3 = null,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000008) ->
	#passi_eff{
		no = 1000008,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4182,
		para2 = 1000,
		para3 = null,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000009) ->
	#passi_eff{
		no = 1000009,
		name = add_buff_arrive_layer,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4182,
		para2 = 1000,
		para3 = {1001,2},
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000010) ->
	#passi_eff{
		no = 1000010,
		name = die_trriger_support,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 1,
		para = 999,
		para2 = 1000,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000011) ->
	#passi_eff{
		no = 1000011,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4298,
		para2 = 1000,
		para3 = 500,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000012) ->
	#passi_eff{
		no = 1000012,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 10,
		para = 4299,
		para2 = 1000,
		para3 = 500,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000013) ->
	#passi_eff{
		no = 1000013,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4300,
		para2 = 1000,
		para3 = 500,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000014) ->
	#passi_eff{
		no = 1000014,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [enemy_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4301,
		para2 = 1000,
		para3 = 500,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000015) ->
	#passi_eff{
		no = 1000015,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4302,
		para2 = 1000,
		para3 = 500,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000016) ->
	#passi_eff{
		no = 1000016,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4303,
		para2 = 1000,
		para3 = 500,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000017) ->
	#passi_eff{
		no = 1000017,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4304,
		para2 = 1000,
		para3 = 500,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000018) ->
	#passi_eff{
		no = 1000018,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [],
		target_count = 3,
		para = 4305,
		para2 = 1000,
		para3 = 500,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000019) ->
	#passi_eff{
		no = 1000019,
		name = add_buff_on_hp_low,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 4306,
		para2 = 1000,
		para3 = 500,
		para4 = 2,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000020) ->
	#passi_eff{
		no = 1000020,
		name = add_buff_on_phy_att_hit,
		op = 0,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 4307,
		para2 = 1000,
		para3 = myself,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000021) ->
	#passi_eff{
		no = 1000021,
		name = add_buff_self_while_die,
		op = 3,
		rules_filter_target = [enemy_side,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 4308,
		para2 = 1000,
		para3 = null,
		para4 = 99,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000022) ->
	#passi_eff{
		no = 1000022,
		name = add_buff_action_friend_survival,
		op = 3,
		rules_filter_target = [ally_side,undead],
		rules_sort_target = [sort_by_hp_asce],
		target_count = 3,
		para = 4309,
		para2 = 1000,
		para3 = 1,
		para4 = 99,
		para5 = 1,
		para6 = 2,
		battle_power_coef = 0
};

get(1000023) ->
	#passi_eff{
		no = 1000023,
		name = add_buff_on_be_att_hit,
		op = 3,
		rules_filter_target = [],
		rules_sort_target = [sort_by_hp_asce],
		target_count = 1,
		para = 4310,
		para2 = 1000,
		para3 = ally_side,
		para4 = 99,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000024) ->
	#passi_eff{
		no = 1000024,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4311,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000025) ->
	#passi_eff{
		no = 1000025,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4313,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000026) ->
	#passi_eff{
		no = 1000026,
		name = add_buff_action_friend_survival,
		op = 3,
		rules_filter_target = [myself,undead],
		rules_sort_target = [],
		target_count = 1,
		para = 4314,
		para2 = 1000,
		para3 = 1,
		para4 = 99,
		para5 = 1,
		para6 = 1,
		battle_power_coef = 0
};

get(1000027) ->
	#passi_eff{
		no = 1000027,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4315,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000028) ->
	#passi_eff{
		no = 1000028,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4316,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000029) ->
	#passi_eff{
		no = 1000029,
		name = add_buff_on_att_hit,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4317,
		para2 = 400,
		para3 = cur_att_target,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000030) ->
	#passi_eff{
		no = 1000030,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4318,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000031) ->
	#passi_eff{
		no = 1000031,
		name = add_buff,
		op = 0,
		rules_filter_target = [],
		rules_sort_target = [],
		target_count = 0,
		para = 4319,
		para2 = null,
		para3 = null,
		para4 = 0,
		para5 = 0,
		para6 = 0,
		battle_power_coef = 0
};

get(1000032) ->
	#passi_eff{
		no = 1000032,
		name = add_buff_begin_friend_survival,
		op = 3,
		rules_filter_target = [myself,dead],
		rules_sort_target = [],
		target_count = 1,
		para = 4300,
		para2 = 1000,
		para3 = 1,
		para4 = 1,
		para5 = 1,
		para6 = 0,
		battle_power_coef = 0
};

get(5000001) ->
	#passi_eff{
		no = 5000001,
		name = add_phy_dam_to_mon,
		op = 0,
		para = 700,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000002) ->
	#passi_eff{
		no = 5000002,
		name = add_phy_dam_to_mon,
		op = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000003) ->
	#passi_eff{
		no = 5000003,
		name = add_phy_dam_to_mon,
		op = 0,
		para = 1300,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000004) ->
	#passi_eff{
		no = 5000004,
		name = add_phy_dam_to_mon,
		op = 0,
		para = 1700,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000005) ->
	#passi_eff{
		no = 5000005,
		name = add_phy_dam_to_mon,
		op = 0,
		para = 2100,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000006) ->
	#passi_eff{
		no = 5000006,
		name = add_mag_dam_to_mon,
		op = 0,
		para = 700,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000007) ->
	#passi_eff{
		no = 5000007,
		name = add_mag_dam_to_mon,
		op = 0,
		para = 1000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000008) ->
	#passi_eff{
		no = 5000008,
		name = add_mag_dam_to_mon,
		op = 0,
		para = 1300,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000009) ->
	#passi_eff{
		no = 5000009,
		name = add_mag_dam_to_mon,
		op = 0,
		para = 1700,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000010) ->
	#passi_eff{
		no = 5000010,
		name = add_mag_dam_to_mon,
		op = 0,
		para = 2100,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000011) ->
	#passi_eff{
		no = 5000011,
		name = add_phy_crit_coef,
		op = 0,
		para = 50,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000012) ->
	#passi_eff{
		no = 5000012,
		name = add_phy_crit_coef,
		op = 0,
		para = 70,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000013) ->
	#passi_eff{
		no = 5000013,
		name = add_phy_crit_coef,
		op = 0,
		para = 90,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000014) ->
	#passi_eff{
		no = 5000014,
		name = add_phy_crit_coef,
		op = 0,
		para = 120,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000015) ->
	#passi_eff{
		no = 5000015,
		name = add_phy_crit_coef,
		op = 0,
		para = 150,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000016) ->
	#passi_eff{
		no = 5000016,
		name = add_mag_crit_coef,
		op = 0,
		para = 50,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000017) ->
	#passi_eff{
		no = 5000017,
		name = add_mag_crit_coef,
		op = 0,
		para = 70,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000018) ->
	#passi_eff{
		no = 5000018,
		name = add_mag_crit_coef,
		op = 0,
		para = 90,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000019) ->
	#passi_eff{
		no = 5000019,
		name = add_mag_crit_coef,
		op = 0,
		para = 120,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000020) ->
	#passi_eff{
		no = 5000020,
		name = add_mag_crit_coef,
		op = 0,
		para = 150,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000021) ->
	#passi_eff{
		no = 5000021,
		name = add_neglect_phy_def,
		op = 0,
		para = 500,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000022) ->
	#passi_eff{
		no = 5000022,
		name = add_neglect_phy_def,
		op = 0,
		para = 700,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000023) ->
	#passi_eff{
		no = 5000023,
		name = add_neglect_phy_def,
		op = 0,
		para = 900,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000024) ->
	#passi_eff{
		no = 5000024,
		name = add_neglect_phy_def,
		op = 0,
		para = 1200,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000025) ->
	#passi_eff{
		no = 5000025,
		name = add_neglect_phy_def,
		op = 0,
		para = 1500,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000026) ->
	#passi_eff{
		no = 5000026,
		name = add_neglect_mag_def,
		op = 0,
		para = 500,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000027) ->
	#passi_eff{
		no = 5000027,
		name = add_neglect_mag_def,
		op = 0,
		para = 700,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000028) ->
	#passi_eff{
		no = 5000028,
		name = add_neglect_mag_def,
		op = 0,
		para = 900,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000029) ->
	#passi_eff{
		no = 5000029,
		name = add_neglect_mag_def,
		op = 0,
		para = 1200,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000030) ->
	#passi_eff{
		no = 5000030,
		name = add_neglect_mag_def,
		op = 0,
		para = 1500,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000031) ->
	#passi_eff{
		no = 5000031,
		name = add_phy_att,
		op = 2,
		para = 7,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000032) ->
	#passi_eff{
		no = 5000032,
		name = add_phy_att,
		op = 2,
		para = 10,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000033) ->
	#passi_eff{
		no = 5000033,
		name = add_phy_att,
		op = 2,
		para = 13,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000034) ->
	#passi_eff{
		no = 5000034,
		name = add_phy_att,
		op = 2,
		para = 17,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000035) ->
	#passi_eff{
		no = 5000035,
		name = add_phy_att,
		op = 2,
		para = 21,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000036) ->
	#passi_eff{
		no = 5000036,
		name = add_phy_def,
		op = 2,
		para = 5,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000037) ->
	#passi_eff{
		no = 5000037,
		name = add_phy_def,
		op = 2,
		para = 7,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000038) ->
	#passi_eff{
		no = 5000038,
		name = add_phy_def,
		op = 2,
		para = 9,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000039) ->
	#passi_eff{
		no = 5000039,
		name = add_phy_def,
		op = 2,
		para = 12,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000040) ->
	#passi_eff{
		no = 5000040,
		name = add_phy_def,
		op = 2,
		para = 15,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000041) ->
	#passi_eff{
		no = 5000041,
		name = add_phy_att,
		op = 2,
		para = 7,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000042) ->
	#passi_eff{
		no = 5000042,
		name = add_phy_att,
		op = 2,
		para = 10,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000043) ->
	#passi_eff{
		no = 5000043,
		name = add_phy_att,
		op = 2,
		para = 13,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000044) ->
	#passi_eff{
		no = 5000044,
		name = add_phy_att,
		op = 2,
		para = 17,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000045) ->
	#passi_eff{
		no = 5000045,
		name = add_phy_att,
		op = 2,
		para = 21,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000046) ->
	#passi_eff{
		no = 5000046,
		name = add_strikeback_proba,
		op = 0,
		para = 70,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000047) ->
	#passi_eff{
		no = 5000047,
		name = add_strikeback_proba,
		op = 0,
		para = 10,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000048) ->
	#passi_eff{
		no = 5000048,
		name = add_strikeback_proba,
		op = 0,
		para = 130,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000049) ->
	#passi_eff{
		no = 5000049,
		name = add_strikeback_proba,
		op = 0,
		para = 170,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000050) ->
	#passi_eff{
		no = 5000050,
		name = add_strikeback_proba,
		op = 0,
		para = 210,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000051) ->
	#passi_eff{
		no = 5000051,
		name = add_phy_att,
		op = 2,
		para = 7,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000052) ->
	#passi_eff{
		no = 5000052,
		name = add_phy_att,
		op = 2,
		para = 10,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000053) ->
	#passi_eff{
		no = 5000053,
		name = add_phy_att,
		op = 2,
		para = 13,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000054) ->
	#passi_eff{
		no = 5000054,
		name = add_phy_att,
		op = 2,
		para = 17,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000055) ->
	#passi_eff{
		no = 5000055,
		name = add_phy_att,
		op = 2,
		para = 21,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000056) ->
	#passi_eff{
		no = 5000056,
		name = reduce_act_speed,
		op = 2,
		para = 3,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000057) ->
	#passi_eff{
		no = 5000057,
		name = reduce_act_speed,
		op = 2,
		para = 4.500000,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000058) ->
	#passi_eff{
		no = 5000058,
		name = reduce_act_speed,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000059) ->
	#passi_eff{
		no = 5000059,
		name = reduce_act_speed,
		op = 2,
		para = 7.500000,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000060) ->
	#passi_eff{
		no = 5000060,
		name = reduce_act_speed,
		op = 2,
		para = 9,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000061) ->
	#passi_eff{
		no = 5000061,
		name = add_mag_att,
		op = 2,
		para = 7,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000062) ->
	#passi_eff{
		no = 5000062,
		name = add_mag_att,
		op = 2,
		para = 10,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000063) ->
	#passi_eff{
		no = 5000063,
		name = add_mag_att,
		op = 2,
		para = 13,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000064) ->
	#passi_eff{
		no = 5000064,
		name = add_mag_att,
		op = 2,
		para = 17,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000065) ->
	#passi_eff{
		no = 5000065,
		name = add_mag_att,
		op = 2,
		para = 21,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000066) ->
	#passi_eff{
		no = 5000066,
		name = add_mag_def,
		op = 2,
		para = 5,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000067) ->
	#passi_eff{
		no = 5000067,
		name = add_mag_def,
		op = 2,
		para = 7,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000068) ->
	#passi_eff{
		no = 5000068,
		name = add_mag_def,
		op = 2,
		para = 9,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000069) ->
	#passi_eff{
		no = 5000069,
		name = add_mag_def,
		op = 2,
		para = 12,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000070) ->
	#passi_eff{
		no = 5000070,
		name = add_mag_def,
		op = 2,
		para = 15,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000071) ->
	#passi_eff{
		no = 5000071,
		name = add_mag_att,
		op = 2,
		para = 7,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000072) ->
	#passi_eff{
		no = 5000072,
		name = add_mag_att,
		op = 2,
		para = 10,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000073) ->
	#passi_eff{
		no = 5000073,
		name = add_mag_att,
		op = 2,
		para = 13,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000074) ->
	#passi_eff{
		no = 5000074,
		name = add_mag_att,
		op = 2,
		para = 17,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000075) ->
	#passi_eff{
		no = 5000075,
		name = add_mag_att,
		op = 2,
		para = 21,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000076) ->
	#passi_eff{
		no = 5000076,
		name = add_mag_combo_att_proba,
		op = 0,
		para = 70,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000077) ->
	#passi_eff{
		no = 5000077,
		name = add_mag_combo_att_proba,
		op = 0,
		para = 100,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000078) ->
	#passi_eff{
		no = 5000078,
		name = add_mag_combo_att_proba,
		op = 0,
		para = 130,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000079) ->
	#passi_eff{
		no = 5000079,
		name = add_mag_combo_att_proba,
		op = 0,
		para = 170,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000080) ->
	#passi_eff{
		no = 5000080,
		name = add_mag_combo_att_proba,
		op = 0,
		para = 210,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000081) ->
	#passi_eff{
		no = 5000081,
		name = add_mag_att,
		op = 2,
		para = 7,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000082) ->
	#passi_eff{
		no = 5000082,
		name = add_mag_att,
		op = 2,
		para = 10,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000083) ->
	#passi_eff{
		no = 5000083,
		name = add_mag_att,
		op = 2,
		para = 13,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000084) ->
	#passi_eff{
		no = 5000084,
		name = add_mag_att,
		op = 2,
		para = 17,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000085) ->
	#passi_eff{
		no = 5000085,
		name = add_mag_att,
		op = 2,
		para = 21,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000086) ->
	#passi_eff{
		no = 5000086,
		name = reduce_act_speed,
		op = 2,
		para = 3,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000087) ->
	#passi_eff{
		no = 5000087,
		name = reduce_act_speed,
		op = 2,
		para = 4.500000,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000088) ->
	#passi_eff{
		no = 5000088,
		name = reduce_act_speed,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000089) ->
	#passi_eff{
		no = 5000089,
		name = reduce_act_speed,
		op = 2,
		para = 7.500000,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000090) ->
	#passi_eff{
		no = 5000090,
		name = reduce_act_speed,
		op = 2,
		para = 9,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000091) ->
	#passi_eff{
		no = 5000091,
		name = add_hp_lim,
		op = 2,
		para = 20,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000092) ->
	#passi_eff{
		no = 5000092,
		name = add_hp_lim,
		op = 2,
		para = 30,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000093) ->
	#passi_eff{
		no = 5000093,
		name = add_hp_lim,
		op = 2,
		para = 40,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000094) ->
	#passi_eff{
		no = 5000094,
		name = add_hp_lim,
		op = 2,
		para = 50,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000095) ->
	#passi_eff{
		no = 5000095,
		name = add_hp_lim,
		op = 2,
		para = 60,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000096) ->
	#passi_eff{
		no = 5000096,
		name = add_seal_resis,
		op = 2,
		para = 4,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000097) ->
	#passi_eff{
		no = 5000097,
		name = add_seal_resis,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000098) ->
	#passi_eff{
		no = 5000098,
		name = add_seal_resis,
		op = 2,
		para = 8,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000099) ->
	#passi_eff{
		no = 5000099,
		name = add_seal_resis,
		op = 2,
		para = 10,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000100) ->
	#passi_eff{
		no = 5000100,
		name = add_seal_resis,
		op = 2,
		para = 12,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000101) ->
	#passi_eff{
		no = 5000101,
		name = add_hp_lim,
		op = 2,
		para = 20,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000102) ->
	#passi_eff{
		no = 5000102,
		name = add_hp_lim,
		op = 2,
		para = 30,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000103) ->
	#passi_eff{
		no = 5000103,
		name = add_hp_lim,
		op = 2,
		para = 40,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000104) ->
	#passi_eff{
		no = 5000104,
		name = add_hp_lim,
		op = 2,
		para = 50,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000105) ->
	#passi_eff{
		no = 5000105,
		name = add_hp_lim,
		op = 2,
		para = 60,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000106) ->
	#passi_eff{
		no = 5000106,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000107) ->
	#passi_eff{
		no = 5000107,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000108) ->
	#passi_eff{
		no = 5000108,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000109) ->
	#passi_eff{
		no = 5000109,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000110) ->
	#passi_eff{
		no = 5000110,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000111) ->
	#passi_eff{
		no = 5000111,
		name = add_hp_lim,
		op = 2,
		para = 30,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000112) ->
	#passi_eff{
		no = 5000112,
		name = add_hp_lim,
		op = 2,
		para = 45,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000113) ->
	#passi_eff{
		no = 5000113,
		name = add_hp_lim,
		op = 2,
		para = 60,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000114) ->
	#passi_eff{
		no = 5000114,
		name = add_hp_lim,
		op = 2,
		para = 75,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000115) ->
	#passi_eff{
		no = 5000115,
		name = add_hp_lim,
		op = 2,
		para = 90,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000116) ->
	#passi_eff{
		no = 5000116,
		name = reduce_act_speed,
		op = 2,
		para = 3,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000117) ->
	#passi_eff{
		no = 5000117,
		name = reduce_act_speed,
		op = 2,
		para = 4.500000,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000118) ->
	#passi_eff{
		no = 5000118,
		name = reduce_act_speed,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000119) ->
	#passi_eff{
		no = 5000119,
		name = reduce_act_speed,
		op = 2,
		para = 7.500000,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000120) ->
	#passi_eff{
		no = 5000120,
		name = reduce_act_speed,
		op = 2,
		para = 9,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000121) ->
	#passi_eff{
		no = 5000121,
		name = add_ret_dam_proba,
		op = 0,
		para = 140,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000122) ->
	#passi_eff{
		no = 5000122,
		name = add_ret_dam_proba,
		op = 0,
		para = 200,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000123) ->
	#passi_eff{
		no = 5000123,
		name = add_ret_dam_proba,
		op = 0,
		para = 260,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000124) ->
	#passi_eff{
		no = 5000124,
		name = add_ret_dam_proba,
		op = 0,
		para = 320,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000125) ->
	#passi_eff{
		no = 5000125,
		name = add_ret_dam_proba,
		op = 0,
		para = 400,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000126) ->
	#passi_eff{
		no = 5000126,
		name = add_ret_dam_coef,
		op = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000127) ->
	#passi_eff{
		no = 5000127,
		name = add_ret_dam_coef,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000128) ->
	#passi_eff{
		no = 5000128,
		name = add_ret_dam_coef,
		op = 0,
		para = 0.200000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000129) ->
	#passi_eff{
		no = 5000129,
		name = add_ret_dam_coef,
		op = 0,
		para = 0.250000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000130) ->
	#passi_eff{
		no = 5000130,
		name = add_ret_dam_coef,
		op = 0,
		para = 0.300000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000131) ->
	#passi_eff{
		no = 5000131,
		name = add_act_speed,
		op = 2,
		para = 3,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000132) ->
	#passi_eff{
		no = 5000132,
		name = add_act_speed,
		op = 2,
		para = 4.500000,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000133) ->
	#passi_eff{
		no = 5000133,
		name = add_act_speed,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000134) ->
	#passi_eff{
		no = 5000134,
		name = add_act_speed,
		op = 2,
		para = 7.500000,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000135) ->
	#passi_eff{
		no = 5000135,
		name = add_act_speed,
		op = 2,
		para = 9,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000136) ->
	#passi_eff{
		no = 5000136,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.030000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000137) ->
	#passi_eff{
		no = 5000137,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.045000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000138) ->
	#passi_eff{
		no = 5000138,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.060000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000139) ->
	#passi_eff{
		no = 5000139,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.075000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000140) ->
	#passi_eff{
		no = 5000140,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000141) ->
	#passi_eff{
		no = 5000141,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000142) ->
	#passi_eff{
		no = 5000142,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.140000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000143) ->
	#passi_eff{
		no = 5000143,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.180000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000144) ->
	#passi_eff{
		no = 5000144,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.240000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000145) ->
	#passi_eff{
		no = 5000145,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.300000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000146) ->
	#passi_eff{
		no = 5000146,
		name = add_phy_def,
		op = 2,
		para = 5,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000147) ->
	#passi_eff{
		no = 5000147,
		name = add_phy_def,
		op = 2,
		para = 7,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000148) ->
	#passi_eff{
		no = 5000148,
		name = add_phy_def,
		op = 2,
		para = 9,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000149) ->
	#passi_eff{
		no = 5000149,
		name = add_phy_def,
		op = 2,
		para = 12,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000150) ->
	#passi_eff{
		no = 5000150,
		name = add_phy_def,
		op = 2,
		para = 15,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000151) ->
	#passi_eff{
		no = 5000151,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.100000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000152) ->
	#passi_eff{
		no = 5000152,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.140000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000153) ->
	#passi_eff{
		no = 5000153,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.180000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000154) ->
	#passi_eff{
		no = 5000154,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.240000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000155) ->
	#passi_eff{
		no = 5000155,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.300000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000156) ->
	#passi_eff{
		no = 5000156,
		name = add_mag_def,
		op = 2,
		para = 5,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000157) ->
	#passi_eff{
		no = 5000157,
		name = add_mag_def,
		op = 2,
		para = 7,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000158) ->
	#passi_eff{
		no = 5000158,
		name = add_mag_def,
		op = 2,
		para = 9,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000159) ->
	#passi_eff{
		no = 5000159,
		name = add_mag_def,
		op = 2,
		para = 12,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000160) ->
	#passi_eff{
		no = 5000160,
		name = add_mag_def,
		op = 2,
		para = 15,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000161) ->
	#passi_eff{
		no = 5000161,
		name = add_do_phy_dam_scaling,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000162) ->
	#passi_eff{
		no = 5000162,
		name = add_do_phy_dam_scaling,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000163) ->
	#passi_eff{
		no = 5000163,
		name = add_do_phy_dam_scaling,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000164) ->
	#passi_eff{
		no = 5000164,
		name = add_do_phy_dam_scaling,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000165) ->
	#passi_eff{
		no = 5000165,
		name = add_do_phy_dam_scaling,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000166) ->
	#passi_eff{
		no = 5000166,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000167) ->
	#passi_eff{
		no = 5000167,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000168) ->
	#passi_eff{
		no = 5000168,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000169) ->
	#passi_eff{
		no = 5000169,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000170) ->
	#passi_eff{
		no = 5000170,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000171) ->
	#passi_eff{
		no = 5000171,
		name = add_do_mag_dam_scaling,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000172) ->
	#passi_eff{
		no = 5000172,
		name = add_do_mag_dam_scaling,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000173) ->
	#passi_eff{
		no = 5000173,
		name = add_do_mag_dam_scaling,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000174) ->
	#passi_eff{
		no = 5000174,
		name = add_do_mag_dam_scaling,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000175) ->
	#passi_eff{
		no = 5000175,
		name = add_do_mag_dam_scaling,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000176) ->
	#passi_eff{
		no = 5000176,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000177) ->
	#passi_eff{
		no = 5000177,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000178) ->
	#passi_eff{
		no = 5000178,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000179) ->
	#passi_eff{
		no = 5000179,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000180) ->
	#passi_eff{
		no = 5000180,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000181) ->
	#passi_eff{
		no = 5000181,
		name = add_be_dam_reduce_coef,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000182) ->
	#passi_eff{
		no = 5000182,
		name = add_be_dam_reduce_coef,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000183) ->
	#passi_eff{
		no = 5000183,
		name = add_be_dam_reduce_coef,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000184) ->
	#passi_eff{
		no = 5000184,
		name = add_be_dam_reduce_coef,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000185) ->
	#passi_eff{
		no = 5000185,
		name = add_be_dam_reduce_coef,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000186) ->
	#passi_eff{
		no = 5000186,
		name = reduce_do_dam_scaling,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000187) ->
	#passi_eff{
		no = 5000187,
		name = reduce_do_dam_scaling,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000188) ->
	#passi_eff{
		no = 5000188,
		name = reduce_do_dam_scaling,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000189) ->
	#passi_eff{
		no = 5000189,
		name = reduce_do_dam_scaling,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000190) ->
	#passi_eff{
		no = 5000190,
		name = reduce_do_dam_scaling,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000191) ->
	#passi_eff{
		no = 5000191,
		name = add_act_speed,
		op = 2,
		para = 3,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000192) ->
	#passi_eff{
		no = 5000192,
		name = add_act_speed,
		op = 2,
		para = 4.500000,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000193) ->
	#passi_eff{
		no = 5000193,
		name = add_act_speed,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000194) ->
	#passi_eff{
		no = 5000194,
		name = add_act_speed,
		op = 2,
		para = 7.500000,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000195) ->
	#passi_eff{
		no = 5000195,
		name = add_act_speed,
		op = 2,
		para = 9,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000196) ->
	#passi_eff{
		no = 5000196,
		name = reduce_do_dam_scaling,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000197) ->
	#passi_eff{
		no = 5000197,
		name = reduce_do_dam_scaling,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000198) ->
	#passi_eff{
		no = 5000198,
		name = reduce_do_dam_scaling,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000199) ->
	#passi_eff{
		no = 5000199,
		name = reduce_do_dam_scaling,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000200) ->
	#passi_eff{
		no = 5000200,
		name = reduce_do_dam_scaling,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000201) ->
	#passi_eff{
		no = 5000201,
		name = add_absorb_hp_coef,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000202) ->
	#passi_eff{
		no = 5000202,
		name = add_absorb_hp_coef,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000203) ->
	#passi_eff{
		no = 5000203,
		name = add_absorb_hp_coef,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000204) ->
	#passi_eff{
		no = 5000204,
		name = add_absorb_hp_coef,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000205) ->
	#passi_eff{
		no = 5000205,
		name = add_absorb_hp_coef,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000206) ->
	#passi_eff{
		no = 5000206,
		name = add_be_phy_dam_reduce_coef,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000207) ->
	#passi_eff{
		no = 5000207,
		name = add_be_phy_dam_reduce_coef,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000208) ->
	#passi_eff{
		no = 5000208,
		name = add_be_phy_dam_reduce_coef,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000209) ->
	#passi_eff{
		no = 5000209,
		name = add_be_phy_dam_reduce_coef,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000210) ->
	#passi_eff{
		no = 5000210,
		name = add_be_phy_dam_reduce_coef,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000211) ->
	#passi_eff{
		no = 5000211,
		name = add_be_mag_dam_reduce_coef,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000212) ->
	#passi_eff{
		no = 5000212,
		name = add_be_mag_dam_reduce_coef,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000213) ->
	#passi_eff{
		no = 5000213,
		name = add_be_mag_dam_reduce_coef,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000214) ->
	#passi_eff{
		no = 5000214,
		name = add_be_mag_dam_reduce_coef,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000215) ->
	#passi_eff{
		no = 5000215,
		name = add_be_mag_dam_reduce_coef,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000216) ->
	#passi_eff{
		no = 5000216,
		name = add_crit,
		op = 1,
		para = 50,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000217) ->
	#passi_eff{
		no = 5000217,
		name = add_crit,
		op = 1,
		para = 70,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000218) ->
	#passi_eff{
		no = 5000218,
		name = add_crit,
		op = 1,
		para = 90,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000219) ->
	#passi_eff{
		no = 5000219,
		name = add_crit,
		op = 1,
		para = 120,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000220) ->
	#passi_eff{
		no = 5000220,
		name = add_crit,
		op = 1,
		para = 150,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000221) ->
	#passi_eff{
		no = 5000221,
		name = add_ten,
		op = 1,
		para = 50,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000222) ->
	#passi_eff{
		no = 5000222,
		name = add_ten,
		op = 1,
		para = 70,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000223) ->
	#passi_eff{
		no = 5000223,
		name = add_ten,
		op = 1,
		para = 90,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000224) ->
	#passi_eff{
		no = 5000224,
		name = add_ten,
		op = 1,
		para = 120,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000225) ->
	#passi_eff{
		no = 5000225,
		name = add_ten,
		op = 1,
		para = 150,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000226) ->
	#passi_eff{
		no = 5000226,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000227) ->
	#passi_eff{
		no = 5000227,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000228) ->
	#passi_eff{
		no = 5000228,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000229) ->
	#passi_eff{
		no = 5000229,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000230) ->
	#passi_eff{
		no = 5000230,
		name = add_be_heal_eff_coef,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000231) ->
	#passi_eff{
		no = 5000231,
		name = add_strikeback_proba,
		op = 0,
		para = 70,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000232) ->
	#passi_eff{
		no = 5000232,
		name = add_strikeback_proba,
		op = 0,
		para = 100,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000233) ->
	#passi_eff{
		no = 5000233,
		name = add_strikeback_proba,
		op = 0,
		para = 130,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000234) ->
	#passi_eff{
		no = 5000234,
		name = add_strikeback_proba,
		op = 0,
		para = 160,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000235) ->
	#passi_eff{
		no = 5000235,
		name = add_strikeback_proba,
		op = 0,
		para = 200,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000236) ->
	#passi_eff{
		no = 5000236,
		name = add_do_dam_scaling,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000237) ->
	#passi_eff{
		no = 5000237,
		name = add_do_dam_scaling,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000238) ->
	#passi_eff{
		no = 5000238,
		name = add_do_dam_scaling,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000239) ->
	#passi_eff{
		no = 5000239,
		name = add_do_dam_scaling,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000240) ->
	#passi_eff{
		no = 5000240,
		name = add_do_dam_scaling,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000241) ->
	#passi_eff{
		no = 5000241,
		name = add_phy_combo_att_proba,
		op = 0,
		para = 50,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000242) ->
	#passi_eff{
		no = 5000242,
		name = add_phy_combo_att_proba,
		op = 0,
		para = 70,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000243) ->
	#passi_eff{
		no = 5000243,
		name = add_phy_combo_att_proba,
		op = 0,
		para = 90,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000244) ->
	#passi_eff{
		no = 5000244,
		name = add_phy_combo_att_proba,
		op = 0,
		para = 120,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000245) ->
	#passi_eff{
		no = 5000245,
		name = add_phy_combo_att_proba,
		op = 0,
		para = 150,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000246) ->
	#passi_eff{
		no = 5000246,
		name = add_mag_combo_att_proba,
		op = 0,
		para = 50,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000247) ->
	#passi_eff{
		no = 5000247,
		name = add_mag_combo_att_proba,
		op = 0,
		para = 70,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000248) ->
	#passi_eff{
		no = 5000248,
		name = add_mag_combo_att_proba,
		op = 0,
		para = 90,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000249) ->
	#passi_eff{
		no = 5000249,
		name = add_mag_combo_att_proba,
		op = 0,
		para = 120,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000250) ->
	#passi_eff{
		no = 5000250,
		name = add_mag_combo_att_proba,
		op = 0,
		para = 150,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000251) ->
	#passi_eff{
		no = 5000251,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.050000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000252) ->
	#passi_eff{
		no = 5000252,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.070000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000253) ->
	#passi_eff{
		no = 5000253,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.090000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000254) ->
	#passi_eff{
		no = 5000254,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.120000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000255) ->
	#passi_eff{
		no = 5000255,
		name = reduce_be_dam_reduce_coef,
		op = 0,
		para = 0.150000,
		para2 = null,
		para3 = null,
		battle_power_coef = 0
};

get(5000256) ->
	#passi_eff{
		no = 5000256,
		name = add_phy_def,
		op = 2,
		para = 5,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000257) ->
	#passi_eff{
		no = 5000257,
		name = add_phy_def,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000258) ->
	#passi_eff{
		no = 5000258,
		name = add_phy_def,
		op = 2,
		para = 8,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000259) ->
	#passi_eff{
		no = 5000259,
		name = add_phy_def,
		op = 2,
		para = 10,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000260) ->
	#passi_eff{
		no = 5000260,
		name = add_phy_def,
		op = 2,
		para = 12,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000261) ->
	#passi_eff{
		no = 5000261,
		name = add_mag_def,
		op = 2,
		para = 5,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000262) ->
	#passi_eff{
		no = 5000262,
		name = add_mag_def,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000263) ->
	#passi_eff{
		no = 5000263,
		name = add_mag_def,
		op = 2,
		para = 8,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000264) ->
	#passi_eff{
		no = 5000264,
		name = add_mag_def,
		op = 2,
		para = 10,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000265) ->
	#passi_eff{
		no = 5000265,
		name = add_mag_def,
		op = 2,
		para = 12,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000266) ->
	#passi_eff{
		no = 5000266,
		name = reduce_act_speed,
		op = 2,
		para = 4,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000267) ->
	#passi_eff{
		no = 5000267,
		name = reduce_act_speed,
		op = 2,
		para = 5,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000268) ->
	#passi_eff{
		no = 5000268,
		name = reduce_act_speed,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000269) ->
	#passi_eff{
		no = 5000269,
		name = reduce_act_speed,
		op = 2,
		para = 7,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000270) ->
	#passi_eff{
		no = 5000270,
		name = reduce_act_speed,
		op = 2,
		para = 8,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000271) ->
	#passi_eff{
		no = 5000271,
		name = add_seal_resis,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000272) ->
	#passi_eff{
		no = 5000272,
		name = add_seal_resis,
		op = 2,
		para = 8,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000273) ->
	#passi_eff{
		no = 5000273,
		name = add_seal_resis,
		op = 2,
		para = 10,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000274) ->
	#passi_eff{
		no = 5000274,
		name = add_seal_resis,
		op = 2,
		para = 12,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000275) ->
	#passi_eff{
		no = 5000275,
		name = add_seal_resis,
		op = 2,
		para = 14,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000276) ->
	#passi_eff{
		no = 5000276,
		name = add_act_speed,
		op = 2,
		para = 3,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000277) ->
	#passi_eff{
		no = 5000277,
		name = add_act_speed,
		op = 2,
		para = 4,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000278) ->
	#passi_eff{
		no = 5000278,
		name = add_act_speed,
		op = 2,
		para = 5,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000279) ->
	#passi_eff{
		no = 5000279,
		name = add_act_speed,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000280) ->
	#passi_eff{
		no = 5000280,
		name = add_act_speed,
		op = 2,
		para = 7,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000281) ->
	#passi_eff{
		no = 5000281,
		name = add_chaos_resis,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000282) ->
	#passi_eff{
		no = 5000282,
		name = add_chaos_resis,
		op = 2,
		para = 8,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000283) ->
	#passi_eff{
		no = 5000283,
		name = add_chaos_resis,
		op = 2,
		para = 10,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000284) ->
	#passi_eff{
		no = 5000284,
		name = add_chaos_resis,
		op = 2,
		para = 14,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000285) ->
	#passi_eff{
		no = 5000285,
		name = add_chaos_resis,
		op = 2,
		para = 18,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000286) ->
	#passi_eff{
		no = 5000286,
		name = add_frozen_resis,
		op = 2,
		para = 6,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000287) ->
	#passi_eff{
		no = 5000287,
		name = add_frozen_resis,
		op = 2,
		para = 8,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000288) ->
	#passi_eff{
		no = 5000288,
		name = add_frozen_resis,
		op = 2,
		para = 10,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000289) ->
	#passi_eff{
		no = 5000289,
		name = add_frozen_resis,
		op = 2,
		para = 14,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000290) ->
	#passi_eff{
		no = 5000290,
		name = add_frozen_resis,
		op = 2,
		para = 18,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000291) ->
	#passi_eff{
		no = 5000291,
		name = add_hp_lim,
		op = 2,
		para = 20,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000292) ->
	#passi_eff{
		no = 5000292,
		name = add_hp_lim,
		op = 2,
		para = 30,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000293) ->
	#passi_eff{
		no = 5000293,
		name = add_hp_lim,
		op = 2,
		para = 40,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000294) ->
	#passi_eff{
		no = 5000294,
		name = add_hp_lim,
		op = 2,
		para = 50,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(5000295) ->
	#passi_eff{
		no = 5000295,
		name = add_hp_lim,
		op = 2,
		para = 60,
		para2 = 1,
		para3 = null,
		battle_power_coef = 0
};

get(6000001) ->
	#passi_eff{
		no = 6000001,
		name = add_buff_on_phy_att_hit,
		op = 0,
		para = 34105,
		para2 = 1000,
		para3 = myself,
		battle_power_coef = 0
};

get(6000002) ->
	#passi_eff{
		no = 6000002,
		name = add_buff_on_phy_att_hit,
		op = 0,
		para = 34107,
		para2 = 1000,
		para3 = myself,
		battle_power_coef = 0
};

get(6000003) ->
	#passi_eff{
		no = 6000003,
		name = add_buff_on_phy_att_hit,
		op = 0,
		para = 34109,
		para2 = 1000,
		para3 = myself,
		battle_power_coef = 0
};

get(6000004) ->
	#passi_eff{
		no = 6000004,
		name = add_buff_on_phy_att_hit,
		op = 0,
		para = 34110,
		para2 = 1000,
		para3 = myself,
		battle_power_coef = 0
};

get(6000005) ->
	#passi_eff{
		no = 6000005,
		name = add_buff_on_phy_att_hit,
		op = 0,
		para = 34111,
		para2 = 1000,
		para3 = cur_att_target,
		battle_power_coef = 0
};

get(6000006) ->
	#passi_eff{
		no = 6000006,
		name = add_buff_on_phy_att_hit,
		op = 0,
		para = 34113,
		para2 = 1000,
		para3 = cur_att_target,
		battle_power_coef = 0
};

get(6000007) ->
	#passi_eff{
		no = 6000007,
		name = add_buff_on_phy_att_hit,
		op = 0,
		para = 34112,
		para2 = 1000,
		para3 = cur_att_target,
		battle_power_coef = 0
};

get(6000008) ->
	#passi_eff{
		no = 6000008,
		name = add_buff_on_phy_att_hit,
		op = 0,
		para = 34114,
		para2 = 1000,
		para3 = cur_att_target,
		battle_power_coef = 0
};

get(6000009) ->
	#passi_eff{
		no = 6000009,
		name = add_buff_on_phy_att_hit,
		op = 0,
		para = 34115,
		para2 = 1000,
		para3 = cur_att_target,
		battle_power_coef = 0
};

get(6000101) ->
	#passi_eff{
		no = 6000101,
		name = add_buff_on_mag_att_hit,
		op = 0,
		para = 34106,
		para2 = 1000,
		para3 = myself,
		battle_power_coef = 0
};

get(6000102) ->
	#passi_eff{
		no = 6000102,
		name = add_buff_on_mag_att_hit,
		op = 0,
		para = 34108,
		para2 = 1000,
		para3 = myself,
		battle_power_coef = 0
};

get(6000103) ->
	#passi_eff{
		no = 6000103,
		name = add_buff_on_mag_att_hit,
		op = 0,
		para = 34109,
		para2 = 1000,
		para3 = myself,
		battle_power_coef = 0
};

get(6000104) ->
	#passi_eff{
		no = 6000104,
		name = add_buff_on_mag_att_hit,
		op = 0,
		para = 34110,
		para2 = 1000,
		para3 = myself,
		battle_power_coef = 0
};

get(6000105) ->
	#passi_eff{
		no = 6000105,
		name = add_buff_on_mag_att_hit,
		op = 0,
		para = 34111,
		para2 = 1000,
		para3 = cur_att_target,
		battle_power_coef = 0
};

get(6000106) ->
	#passi_eff{
		no = 6000106,
		name = add_buff_on_mag_att_hit,
		op = 0,
		para = 34113,
		para2 = 1000,
		para3 = cur_att_target,
		battle_power_coef = 0
};

get(6000107) ->
	#passi_eff{
		no = 6000107,
		name = add_buff_on_mag_att_hit,
		op = 0,
		para = 34112,
		para2 = 1000,
		para3 = cur_att_target,
		battle_power_coef = 0
};

get(6000108) ->
	#passi_eff{
		no = 6000108,
		name = add_buff_on_mag_att_hit,
		op = 0,
		para = 34114,
		para2 = 1000,
		para3 = cur_att_target,
		battle_power_coef = 0
};

get(6000109) ->
	#passi_eff{
		no = 6000109,
		name = add_buff_on_mag_att_hit,
		op = 0,
		para = 34115,
		para2 = 1000,
		para3 = cur_att_target,
		battle_power_coef = 0
};

get(6000201) ->
	#passi_eff{
		no = 6000201,
		name = add_buff_on_be_att_hit,
		op = 0,
		para = 34117,
		para2 = 1000,
		para3 = myself,
		battle_power_coef = 0
};

get(6000202) ->
	#passi_eff{
		no = 6000202,
		name = add_buff_on_be_att_hit,
		op = 0,
		para = 34118,
		para2 = 100,
		para3 = myself,
		battle_power_coef = 0
};

get(6000203) ->
	#passi_eff{
		no = 6000203,
		name = add_buff_on_be_att_hit,
		op = 0,
		para = 34110,
		para2 = 1000,
		para3 = myself,
		battle_power_coef = 0
};

get(6000204) ->
	#passi_eff{
		no = 6000204,
		name = add_buff_on_be_att_hit,
		op = 0,
		para = 34109,
		para2 = 1000,
		para3 = myself,
		battle_power_coef = 0
};

get(6000205) ->
	#passi_eff{
		no = 6000205,
		name = add_buff_on_be_att_hit,
		op = 0,
		para = 34119,
		para2 = 1000,
		para3 = myself,
		battle_power_coef = 0
};

get(6000206) ->
	#passi_eff{
		no = 6000206,
		name = add_buff_on_be_att_hit,
		op = 0,
		para = 34113,
		para2 = 1000,
		para3 = atter,
		battle_power_coef = 0
};

get(6000207) ->
	#passi_eff{
		no = 6000207,
		name = add_buff_on_be_att_hit,
		op = 0,
		para = 34114,
		para2 = 1000,
		para3 = atter,
		battle_power_coef = 0
};

get(6000208) ->
	#passi_eff{
		no = 6000208,
		name = add_buff_on_be_att_hit,
		op = 0,
		para = 34120,
		para2 = 1000,
		para3 = atter,
		battle_power_coef = 0
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

