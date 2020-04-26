%%%---------------------------------------
%%% @Module  : data_AI
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description:  战斗单位的AI
%%%---------------------------------------


-module(data_AI).
-export([get/1]).

-include("battle_AI.hrl").
-include("debug.hrl").


get(201) ->
	#bo_ai{
		no = 201,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 201},
		condition_list = [201]
};

get(202) ->
	#bo_ai{
		no = 202,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 202},
		condition_list = [202]
};

get(203) ->
	#bo_ai{
		no = 203,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 203},
		condition_list = [203]
};

get(204) ->
	#bo_ai{
		no = 204,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 204},
		condition_list = [204]
};

get(205) ->
	#bo_ai{
		no = 205,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 205},
		condition_list = [205]
};

get(301) ->
	#bo_ai{
		no = 301,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 301},
		condition_list = [301]
};

get(302) ->
	#bo_ai{
		no = 302,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 302},
		condition_list = [302]
};

get(303) ->
	#bo_ai{
		no = 303,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 303},
		condition_list = [303]
};

get(304) ->
	#bo_ai{
		no = 304,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 304},
		condition_list = [304]
};

get(305) ->
	#bo_ai{
		no = 305,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 305},
		condition_list = [305]
};

get(401) ->
	#bo_ai{
		no = 401,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 401},
		condition_list = [401]
};

get(402) ->
	#bo_ai{
		no = 402,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 402},
		condition_list = [402]
};

get(403) ->
	#bo_ai{
		no = 403,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 403},
		condition_list = [403]
};

get(404) ->
	#bo_ai{
		no = 404,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 404},
		condition_list = [404]
};

get(405) ->
	#bo_ai{
		no = 405,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 405},
		condition_list = [405]
};

get(501) ->
	#bo_ai{
		no = 501,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 501},
		condition_list = [501]
};

get(502) ->
	#bo_ai{
		no = 502,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 502},
		condition_list = [502]
};

get(503) ->
	#bo_ai{
		no = 503,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 503},
		condition_list = [503]
};

get(504) ->
	#bo_ai{
		no = 504,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 504},
		condition_list = [504]
};

get(505) ->
	#bo_ai{
		no = 505,
		priority = 1000,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 505},
		condition_list = [505]
};

get(601) ->
	#bo_ai{
		no = 601,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {escape, 1000},
		condition_list = [1000071]
};

get(602) ->
	#bo_ai{
		no = 602,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_escape, 1},
		condition_list = []
};

get(30001) ->
	#bo_ai{
		no = 30001,
		priority = 10,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1027},
		condition_list = [30001]
};

get(30002) ->
	#bo_ai{
		no = 30002,
		priority = 10,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1028},
		condition_list = [30002]
};

get(30003) ->
	#bo_ai{
		no = 30003,
		priority = 10,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1029},
		condition_list = [30003]
};

get(30004) ->
	#bo_ai{
		no = 30004,
		priority = 10,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1030},
		condition_list = [30004]
};

get(30005) ->
	#bo_ai{
		no = 30005,
		priority = 10,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1031},
		condition_list = [30005]
};

get(30006) ->
	#bo_ai{
		no = 30006,
		priority = 10,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1032},
		condition_list = [30006]
};

get(30007) ->
	#bo_ai{
		no = 30007,
		priority = 10,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1033},
		condition_list = [30007]
};

get(30008) ->
	#bo_ai{
		no = 30008,
		priority = 10,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1034},
		condition_list = [30008]
};

get(30009) ->
	#bo_ai{
		no = 30009,
		priority = 10,
		weight = 20,
		rules_filter_action_target = [undead, ally_side, cur_hp_lowest],
		action_content = {use_skill, 1035},
		condition_list = [30009]
};

get(30010) ->
	#bo_ai{
		no = 30010,
		priority = 10,
		weight = 20,
		rules_filter_action_target = [undead, ally_side, cur_hp_lowest],
		action_content = {use_skill, 1036},
		condition_list = [30010]
};

get(30101) ->
	#bo_ai{
		no = 30101,
		priority = 20,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1127},
		condition_list = [30101]
};

get(30102) ->
	#bo_ai{
		no = 30102,
		priority = 20,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1128},
		condition_list = [30102]
};

get(30103) ->
	#bo_ai{
		no = 30103,
		priority = 20,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1129},
		condition_list = [30103]
};

get(30104) ->
	#bo_ai{
		no = 30104,
		priority = 20,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1130},
		condition_list = [30104]
};

get(30105) ->
	#bo_ai{
		no = 30105,
		priority = 20,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1131},
		condition_list = [30105]
};

get(30106) ->
	#bo_ai{
		no = 30106,
		priority = 20,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1132},
		condition_list = [30106]
};

get(30107) ->
	#bo_ai{
		no = 30107,
		priority = 20,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1133},
		condition_list = [30107]
};

get(30108) ->
	#bo_ai{
		no = 30108,
		priority = 20,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1134},
		condition_list = [30108]
};

get(30109) ->
	#bo_ai{
		no = 30109,
		priority = 20,
		weight = 20,
		rules_filter_action_target = [undead, ally_side, cur_hp_lowest],
		action_content = {use_skill, 1135},
		condition_list = [30109]
};

get(30110) ->
	#bo_ai{
		no = 30110,
		priority = 20,
		weight = 20,
		rules_filter_action_target = [undead, ally_side, cur_hp_lowest],
		action_content = {use_skill, 1136},
		condition_list = [30110]
};

get(30201) ->
	#bo_ai{
		no = 30201,
		priority = 30,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1227},
		condition_list = [30201]
};

get(30202) ->
	#bo_ai{
		no = 30202,
		priority = 30,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1228},
		condition_list = [30202]
};

get(30203) ->
	#bo_ai{
		no = 30203,
		priority = 30,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1229},
		condition_list = [30203]
};

get(30204) ->
	#bo_ai{
		no = 30204,
		priority = 30,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1230},
		condition_list = [30204]
};

get(30205) ->
	#bo_ai{
		no = 30205,
		priority = 30,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1231},
		condition_list = [30205]
};

get(30206) ->
	#bo_ai{
		no = 30206,
		priority = 30,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1232},
		condition_list = [30206]
};

get(30207) ->
	#bo_ai{
		no = 30207,
		priority = 30,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1233},
		condition_list = [30207]
};

get(30208) ->
	#bo_ai{
		no = 30208,
		priority = 30,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1234},
		condition_list = [30208]
};

get(30209) ->
	#bo_ai{
		no = 30209,
		priority = 30,
		weight = 20,
		rules_filter_action_target = [undead, ally_side, cur_hp_lowest],
		action_content = {use_skill, 1235},
		condition_list = [30209]
};

get(30210) ->
	#bo_ai{
		no = 30210,
		priority = 30,
		weight = 20,
		rules_filter_action_target = [undead, ally_side, cur_hp_lowest],
		action_content = {use_skill, 1236},
		condition_list = [30210]
};

get(30301) ->
	#bo_ai{
		no = 30301,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 1309},
		condition_list = [30301]
};

get(30302) ->
	#bo_ai{
		no = 30302,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_under_control],
		action_content = {use_skill, 1310},
		condition_list = [30302]
};

get(30303) ->
	#bo_ai{
		no = 30303,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 1311},
		condition_list = [30303]
};

get(30304) ->
	#bo_ai{
		no = 30304,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 1312},
		condition_list = [30304]
};

get(30305) ->
	#bo_ai{
		no = 30305,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 1314},
		condition_list = [30305]
};

get(30306) ->
	#bo_ai{
		no = 30306,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 1314},
		condition_list = [30305, 30306]
};

get(1) ->
	#bo_ai{
		no = 1,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, {cur_mp_higher_than, 5}, is_not_frozen, cur_mp_lowest],
		action_content = {use_skill, 10001},
		condition_list = [69,2]
};

get(2) ->
	#bo_ai{
		no = 2,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, {cur_mp_higher_than, 5},is_not_frozen],
		action_content = {use_skill, 10001},
		condition_list = [69]
};

get(3) ->
	#bo_ai{
		no = 3,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen,  phy_def_highest],
		action_content = {use_skill, 10002},
		condition_list = [70,3,4]
};

get(4) ->
	#bo_ai{
		no = 4,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen,  phy_def_lowest],
		action_content = {use_skill, 10002},
		condition_list = [70]
};

get(5) ->
	#bo_ai{
		no = 5,
		priority = 21,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen,  cur_hp_lowest],
		action_content = {use_skill, 10003},
		condition_list = [71]
};

get(6) ->
	#bo_ai{
		no = 6,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen,  phy_def_lowest],
		action_content = {use_skill, 10004},
		condition_list = [72]
};

get(7) ->
	#bo_ai{
		no = 7,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10010},
		condition_list = [81,73]
};

get(8) ->
	#bo_ai{
		no = 8,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10010},
		condition_list = [73]
};

get(9) ->
	#bo_ai{
		no = 9,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side, not_invisible_to_me, is_not_frozen, phy_def_highest],
		action_content = {use_skill, 10011},
		condition_list = [74,5]
};

get(10) ->
	#bo_ai{
		no = 10,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side, not_invisible_to_me,is_not_frozen,  mag_def_highest],
		action_content = {use_skill, 10011},
		condition_list = [74,6]
};

get(11) ->
	#bo_ai{
		no = 11,
		priority = 30,
		weight = 100,
		rules_filter_action_target = [my_owner],
		action_content = {use_skill, 10019},
		condition_list = [75,7]
};

get(12) ->
	#bo_ai{
		no = 12,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_under_control, mag_att_highest],
		action_content = {use_skill, 10021},
		condition_list = [76,8,40]
};

get(13) ->
	#bo_ai{
		no = 13,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_under_control, phy_att_highest],
		action_content = {use_skill, 10021},
		condition_list = [76,9,40]
};

get(14) ->
	#bo_ai{
		no = 14,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10011},
		condition_list = [74]
};

get(15) ->
	#bo_ai{
		no = 15,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill, 1},
		condition_list = [41]
};

get(16) ->
	#bo_ai{
		no = 16,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_under_control, seal_resis_lowest],
		action_content = {use_skill, 2},
		condition_list = [42, 130]
};

get(17) ->
	#bo_ai{
		no = 17,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_under_control, seal_resis_lowest],
		action_content = {use_skill, 3},
		condition_list = [43, 131]
};

get(18) ->
	#bo_ai{
		no = 18,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 4021}],
		action_content = {use_skill, 4},
		condition_list = [44, 133]
};

get(19) ->
	#bo_ai{
		no = 19,
		priority = 12,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_under_control, seal_resis_lowest],
		action_content = {use_skill, 5},
		condition_list = [45, 130]
};

get(20) ->
	#bo_ai{
		no = 20,
		priority = 12,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_under_control, seal_resis_lowest],
		action_content = {use_skill, 6},
		condition_list = [46, 131]
};

get(21) ->
	#bo_ai{
		no = 21,
		priority = 25,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 7},
		condition_list = [47, 132, 134]
};

get(29) ->
	#bo_ai{
		no = 29,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, phy_att_highest, mag_att_highest],
		action_content = {use_skill,11},
		condition_list = [48 ,135, 137]
};

get(30) ->
	#bo_ai{
		no = 30,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,12},
		condition_list = [49]
};

get(31) ->
	#bo_ai{
		no = 31,
		priority = 16,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill,13},
		condition_list = [50, 138]
};

get(32) ->
	#bo_ai{
		no = 32,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,  phy_def_highest],
		action_content = {use_skill,14},
		condition_list = [51]
};

get(33) ->
	#bo_ai{
		no = 33,
		priority = 25,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill,15},
		condition_list = [52, 140 ,143]
};

get(34) ->
	#bo_ai{
		no = 34,
		priority = 19,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,16},
		condition_list = [53, 141]
};

get(35) ->
	#bo_ai{
		no = 35,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill,17},
		condition_list = [54, 142, 136]
};

get(36) ->
	#bo_ai{
		no = 36,
		priority = 16,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill,13},
		condition_list = [50, 139]
};

get(41) ->
	#bo_ai{
		no = 41,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 41},
		condition_list = [55]
};

get(42) ->
	#bo_ai{
		no = 42,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me, {cur_hp_percentage_lower_than, 15}],
		action_content = {use_skill, 42},
		condition_list = [56,24]
};

get(43) ->
	#bo_ai{
		no = 43,
		priority = 0,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 43},
		condition_list = [57,25,26]
};

get(44) ->
	#bo_ai{
		no = 44,
		priority = 0,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_player, cur_mp_highest],
		action_content = {use_skill, 44},
		condition_list = [58,27]
};

get(45) ->
	#bo_ai{
		no = 45,
		priority = 0,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 45},
		condition_list = [59,25,26]
};

get(46) ->
	#bo_ai{
		no = 46,
		priority = 16,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 46},
		condition_list = [60,28,29]
};

get(47) ->
	#bo_ai{
		no = 47,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen,  mag_def_highest],
		action_content = {use_skill, 47},
		condition_list = [61,30]
};

get(48) ->
	#bo_ai{
		no = 48,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me,is_not_frozen,  enemy_side],
		action_content = {use_skill, 51},
		condition_list = [62]
};

get(49) ->
	#bo_ai{
		no = 49,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [ally_side, is_fallen],
		action_content = {use_skill, 52},
		condition_list = [63,31]
};

get(50) ->
	#bo_ai{
		no = 50,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [ally_side, {cur_hp_percentage_lower_than, 50}, undead],
		action_content = {use_skill, 53},
		condition_list = [32,33,64]
};

get(51) ->
	#bo_ai{
		no = 51,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [ally_side, {cur_hp_percentage_lower_than, 80}, undead],
		action_content = {use_skill, 53},
		condition_list = [33,64]
};

get(52) ->
	#bo_ai{
		no = 52,
		priority = 18,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, {cur_mp_percentage_lower_than, 35},{has_not_spec_no_buff, 28}],
		action_content = {use_skill, 54},
		condition_list = [34,35,65]
};

get(53) ->
	#bo_ai{
		no = 53,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 32}, {has_not_spec_no_buff, 33}],
		action_content = {use_skill, 56},
		condition_list = [79,67]
};

get(54) ->
	#bo_ai{
		no = 54,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 4019}],
		action_content = {use_skill, 55},
		condition_list = [36,66]
};

get(55) ->
	#bo_ai{
		no = 55,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 32}, {has_not_spec_no_buff, 33}],
		action_content = {use_skill, 56},
		condition_list = [78,67]
};

get(56) ->
	#bo_ai{
		no = 56,
		priority = 16,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, {cur_hp_percentage_lower_than, 25}],
		action_content = {use_skill, 57},
		condition_list = [68,38,39]
};

get(58) ->
	#bo_ai{
		no = 58,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}, undead],
		action_content = {use_skill, 23},
		condition_list = [82,83,84]
};

get(59) ->
	#bo_ai{
		no = 59,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 40}],
		action_content = {use_skill, 23},
		condition_list = [88,93,94,121]
};

get(60) ->
	#bo_ai{
		no = 60,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 21},
		condition_list = [86,99]
};

get(61) ->
	#bo_ai{
		no = 61,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me, cur_hp_lowest],
		action_content = {use_skill, 21},
		condition_list = [86,99,100]
};

get(62) ->
	#bo_ai{
		no = 62,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [87,101,120]
};

get(63) ->
	#bo_ai{
		no = 63,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [87,101,120]
};

get(64) ->
	#bo_ai{
		no = 64,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 41}, {has_not_spec_no_buff, 42}, undead],
		action_content = {use_skill, 26},
		condition_list = [91,95]
};

get(65) ->
	#bo_ai{
		no = 65,
		priority = 12,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 40}],
		action_content = {use_skill, 23},
		condition_list = [88,93]
};

get(66) ->
	#bo_ai{
		no = 66,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 16}, phy_def_highest],
		action_content = {use_skill, 24},
		condition_list = [89,96,97]
};

get(67) ->
	#bo_ai{
		no = 67,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 43}],
		action_content = {use_skill, 27},
		condition_list = [92,128,102]
};

get(68) ->
	#bo_ai{
		no = 68,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 32},
		condition_list = [104,111]
};

get(69) ->
	#bo_ai{
		no = 69,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 32},
		condition_list = [105,112,113]
};

get(70) ->
	#bo_ai{
		no = 70,
		priority = 16,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 32},
		condition_list = [105,113,114]
};

get(71) ->
	#bo_ai{
		no = 71,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 33},
		condition_list = [106,115,117]
};

get(72) ->
	#bo_ai{
		no = 72,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 34},
		condition_list = [106,117]
};

get(73) ->
	#bo_ai{
		no = 73,
		priority = 17,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me, cur_hp_lowest],
		action_content = {use_skill, 35},
		condition_list = [108,116]
};

get(74) ->
	#bo_ai{
		no = 74,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 36},
		condition_list = [109,117]
};

get(75) ->
	#bo_ai{
		no = 75,
		priority = 16,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_player, cur_hp_lowest, {has_not_spec_no_buff, 44}],
		action_content = {use_skill, 37},
		condition_list = [110,122,123]
};

get(76) ->
	#bo_ai{
		no = 76,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 21},
		condition_list = [86]
};

get(77) ->
	#bo_ai{
		no = 77,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 25},
		condition_list = [90]
};

get(78) ->
	#bo_ai{
		no = 78,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen,  mag_def_highest],
		action_content = {use_skill,10006},
		condition_list = [1002,1007,1039]
};

get(79) ->
	#bo_ai{
		no = 79,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen,  mag_def_highest],
		action_content = {use_skill,10007},
		condition_list = [1003,1008,1007,1039]
};

get(80) ->
	#bo_ai{
		no = 80,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill,10012},
		condition_list = [1005,1009]
};

get(81) ->
	#bo_ai{
		no = 81,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill,10013},
		condition_list = [1006,1010]
};

get(82) ->
	#bo_ai{
		no = 82,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me, phy_def_lowest],
		action_content = {use_skill,10005},
		condition_list = [1001, 1011, 125]
};

get(83) ->
	#bo_ai{
		no = 83,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, {cur_mp_higher_than, 5},is_not_frozen],
		action_content = {use_skill, 10009},
		condition_list = [2,1012]
};

get(84) ->
	#bo_ai{
		no = 84,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10014},
		condition_list = [1013]
};

get(85) ->
	#bo_ai{
		no = 85,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10020},
		condition_list = [1014]
};

get(86) ->
	#bo_ai{
		no = 86,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 42},
		condition_list = [56,127]
};

get(87) ->
	#bo_ai{
		no = 87,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10020},
		condition_list = [1014,127]
};

get(88) ->
	#bo_ai{
		no = 88,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10014},
		condition_list = [1013,127]
};

get(89) ->
	#bo_ai{
		no = 89,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10022},
		condition_list = [1015]
};

get(90) ->
	#bo_ai{
		no = 90,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10022},
		condition_list = [1015,127]
};

get(91) ->
	#bo_ai{
		no = 91,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_player, cur_hp_lowest, {has_not_spec_no_buff, 1021}],
		action_content = {use_skill, 10023},
		condition_list = [122,123,1016]
};

get(92) ->
	#bo_ai{
		no = 92,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10024},
		condition_list = [1017]
};

get(93) ->
	#bo_ai{
		no = 93,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10025},
		condition_list = [1018,1007,1039]
};

get(94) ->
	#bo_ai{
		no = 94,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, act_speed_highest],
		action_content = {use_skill, 10026},
		condition_list = [1019,1034]
};

get(95) ->
	#bo_ai{
		no = 95,
		priority = 25,
		weight = 100,
		rules_filter_action_target = [my_owner],
		action_content = {use_skill, 10027},
		condition_list = [1020,7]
};

get(96) ->
	#bo_ai{
		no = 96,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, {cur_mp_higher_than, 5},is_not_frozen],
		action_content = {use_skill, 10028},
		condition_list = [1021]
};

get(97) ->
	#bo_ai{
		no = 97,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill, 10029},
		condition_list = [1022,1010]
};

get(98) ->
	#bo_ai{
		no = 98,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10030},
		condition_list = [81,1023]
};

get(99) ->
	#bo_ai{
		no = 99,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10030},
		condition_list = [1023]
};

get(100) ->
	#bo_ai{
		no = 100,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill, 10031},
		condition_list = [1024,1009]
};

get(101) ->
	#bo_ai{
		no = 101,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen,  mag_def_highest],
		action_content = {use_skill,10032},
		condition_list = [1025,1007,1039]
};

get(102) ->
	#bo_ai{
		no = 102,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side,  {has_not_spec_no_buff, 1023}, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10033},
		condition_list = [1026,1035]
};

get(103) ->
	#bo_ai{
		no = 103,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10033},
		condition_list = [1026]
};

get(104) ->
	#bo_ai{
		no = 104,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10034},
		condition_list = [1027]
};

get(105) ->
	#bo_ai{
		no = 105,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen,  phy_def_highest],
		action_content = {use_skill, 10035},
		condition_list = [1028,3,4]
};

get(106) ->
	#bo_ai{
		no = 106,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, phy_def_highest],
		action_content = {use_skill, 10035},
		condition_list = [1028]
};

get(107) ->
	#bo_ai{
		no = 107,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, {cur_mp_higher_than, 5}, is_not_frozen, cur_mp_lowest],
		action_content = {use_skill, 10036},
		condition_list = [1029,2]
};

get(108) ->
	#bo_ai{
		no = 108,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, {cur_mp_higher_than, 5},is_not_frozen],
		action_content = {use_skill, 10036},
		condition_list = [1029]
};

get(109) ->
	#bo_ai{
		no = 109,
		priority = 21,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen,  cur_hp_lowest],
		action_content = {use_skill, 10037},
		condition_list = [1030]
};

get(110) ->
	#bo_ai{
		no = 110,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10038},
		condition_list = [81,1031]
};

get(111) ->
	#bo_ai{
		no = 111,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10038},
		condition_list = [1031]
};

get(112) ->
	#bo_ai{
		no = 112,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10039},
		condition_list = [81,1032]
};

get(113) ->
	#bo_ai{
		no = 113,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10039},
		condition_list = [1032]
};

get(114) ->
	#bo_ai{
		no = 114,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, {cur_hp_percentage_lower_than, 60}, {has_not_spec_no_buff, 1027}],
		action_content = {use_skill, 10040},
		condition_list = [1033,1035]
};

get(115) ->
	#bo_ai{
		no = 115,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10011},
		condition_list = [1036]
};

get(116) ->
	#bo_ai{
		no = 116,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10011},
		condition_list = [1036,127]
};

get(117) ->
	#bo_ai{
		no = 117,
		priority = 21,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10041},
		condition_list = [1037]
};

get(118) ->
	#bo_ai{
		no = 118,
		priority = 21,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10042},
		condition_list = [1038]
};

get(119) ->
	#bo_ai{
		no = 119,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen,  mag_def_highest],
		action_content = {use_skill,10007},
		condition_list = [1003,1007,1039]
};

get(120) ->
	#bo_ai{
		no = 120,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, {has_spec_eff_type_buff, bad}],
		action_content = {use_skill, 10043},
		condition_list = []
};

get(121) ->
	#bo_ai{
		no = 121,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10044},
		condition_list = []
};

get(122) ->
	#bo_ai{
		no = 122,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10044},
		condition_list = [1042]
};

get(123) ->
	#bo_ai{
		no = 123,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, {pos_equal_to, 6}],
		action_content = {use_skill, 10045},
		condition_list = [1043, 1044, 1054]
};

get(124) ->
	#bo_ai{
		no = 124,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, {pos_equal_to, 7}],
		action_content = {use_skill, 10045},
		condition_list = [1043, 1045, 1055]
};

get(125) ->
	#bo_ai{
		no = 125,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, {pos_equal_to, 8}],
		action_content = {use_skill, 10045},
		condition_list = [1043, 1046, 1056]
};

get(126) ->
	#bo_ai{
		no = 126,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, {pos_equal_to, 9}],
		action_content = {use_skill, 10045},
		condition_list = [1043, 1047, 1057]
};

get(127) ->
	#bo_ai{
		no = 127,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, {pos_equal_to, 10}],
		action_content = {use_skill, 10045},
		condition_list = [1043, 1048, 1058]
};

get(128) ->
	#bo_ai{
		no = 128,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, {pos_equal_to, 6}],
		action_content = {use_skill, 10045},
		condition_list = [1043, 1049, 1054]
};

get(129) ->
	#bo_ai{
		no = 129,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, {pos_equal_to, 7}],
		action_content = {use_skill, 10045},
		condition_list = [1043, 1050, 1055]
};

get(130) ->
	#bo_ai{
		no = 130,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, {pos_equal_to, 8}],
		action_content = {use_skill, 10045},
		condition_list = [1043, 1051, 1056]
};

get(131) ->
	#bo_ai{
		no = 131,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, {pos_equal_to, 9}],
		action_content = {use_skill, 10045},
		condition_list = [1043, 1052, 1057]
};

get(132) ->
	#bo_ai{
		no = 132,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, {pos_equal_to, 10}],
		action_content = {use_skill, 10045},
		condition_list = [1043, 1053, 1058]
};

get(133) ->
	#bo_ai{
		no = 133,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10045},
		condition_list = [1043]
};

get(134) ->
	#bo_ai{
		no = 134,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen,  mag_def_highest],
		action_content = {use_skill,10006},
		condition_list = [1002]
};

get(135) ->
	#bo_ai{
		no = 135,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10009},
		condition_list = [1012]
};

get(136) ->
	#bo_ai{
		no = 136,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10046},
		condition_list = [1059]
};

get(137) ->
	#bo_ai{
		no = 137,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10046},
		condition_list = [1059]
};

get(138) ->
	#bo_ai{
		no = 138,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10047},
		condition_list = [1060]
};

get(139) ->
	#bo_ai{
		no = 139,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10047},
		condition_list = [1060]
};

get(140) ->
	#bo_ai{
		no = 140,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10048},
		condition_list = [1061]
};

get(141) ->
	#bo_ai{
		no = 141,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10048},
		condition_list = [1061]
};

get(143) ->
	#bo_ai{
		no = 143,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 47}],
		action_content = {use_skill, 10049},
		condition_list = [129]
};

get(144) ->
	#bo_ai{
		no = 144,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, cur_hp_lowest],
		action_content = {use_skill,10050},
		condition_list = [1064, 1063,1062]
};

get(145) ->
	#bo_ai{
		no = 145,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen,  cur_hp_lowest],
		action_content = {use_skill,10050},
		condition_list = [1064, 1063]
};

get(146) ->
	#bo_ai{
		no = 146,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_player, is_frozen],
		action_content = {use_skill,10051},
		condition_list = [1065, 1069]
};

get(147) ->
	#bo_ai{
		no = 147,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_player, is_chaos],
		action_content = {use_skill,10051},
		condition_list = [1066, 1069]
};

get(148) ->
	#bo_ai{
		no = 148,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_frozen
],
		action_content = {use_skill,10051},
		condition_list = [1067, 1069]
};

get(149) ->
	#bo_ai{
		no = 149,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_chaos
],
		action_content = {use_skill,10051},
		condition_list = [1068, 1069]
};

get(1001) ->
	#bo_ai{
		no = 1001,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 2},
		condition_list = [42, 118]
};

get(1002) ->
	#bo_ai{
		no = 1002,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 2},
		condition_list = [42, 118]
};

get(1003) ->
	#bo_ai{
		no = 1003,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 2},
		condition_list = [42, 118]
};

get(1004) ->
	#bo_ai{
		no = 1004,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 2},
		condition_list = [42, 118]
};

get(1005) ->
	#bo_ai{
		no = 1005,
		priority = 1,
		weight = 50,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 2},
		condition_list = [42, 118]
};

get(1006) ->
	#bo_ai{
		no = 1006,
		priority = 1,
		weight = 60,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 2},
		condition_list = [42, 118]
};

get(1007) ->
	#bo_ai{
		no = 1007,
		priority = 1,
		weight = 70,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 2},
		condition_list = [42, 118]
};

get(1008) ->
	#bo_ai{
		no = 1008,
		priority = 1,
		weight = 80,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 2},
		condition_list = [42, 118]
};

get(1009) ->
	#bo_ai{
		no = 1009,
		priority = 1,
		weight = 90,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 2},
		condition_list = [42, 118]
};

get(1010) ->
	#bo_ai{
		no = 1010,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 2},
		condition_list = [42, 118]
};

get(1011) ->
	#bo_ai{
		no = 1011,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 3},
		condition_list = [43]
};

get(1012) ->
	#bo_ai{
		no = 1012,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 3},
		condition_list = [43]
};

get(1013) ->
	#bo_ai{
		no = 1013,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 3},
		condition_list = [43]
};

get(1014) ->
	#bo_ai{
		no = 1014,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 3},
		condition_list = [43]
};

get(1015) ->
	#bo_ai{
		no = 1015,
		priority = 1,
		weight = 50,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 3},
		condition_list = [43]
};

get(1016) ->
	#bo_ai{
		no = 1016,
		priority = 1,
		weight = 60,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 3},
		condition_list = [43]
};

get(1017) ->
	#bo_ai{
		no = 1017,
		priority = 1,
		weight = 70,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 3},
		condition_list = [43]
};

get(1018) ->
	#bo_ai{
		no = 1018,
		priority = 1,
		weight = 80,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 3},
		condition_list = [43]
};

get(1019) ->
	#bo_ai{
		no = 1019,
		priority = 1,
		weight = 90,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 3},
		condition_list = [43]
};

get(1020) ->
	#bo_ai{
		no = 1020,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 3},
		condition_list = [43]
};

get(1021) ->
	#bo_ai{
		no = 1021,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 6},
		condition_list = [45, 118]
};

get(1022) ->
	#bo_ai{
		no = 1022,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 6},
		condition_list = [45, 118]
};

get(1023) ->
	#bo_ai{
		no = 1023,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 6},
		condition_list = [45, 118]
};

get(1024) ->
	#bo_ai{
		no = 1024,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 6},
		condition_list = [45, 118]
};

get(1025) ->
	#bo_ai{
		no = 1025,
		priority = 1,
		weight = 50,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 6},
		condition_list = [45, 118]
};

get(1026) ->
	#bo_ai{
		no = 1026,
		priority = 1,
		weight = 60,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 6},
		condition_list = [45, 118]
};

get(1027) ->
	#bo_ai{
		no = 1027,
		priority = 1,
		weight = 70,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 6},
		condition_list = [45, 118]
};

get(1028) ->
	#bo_ai{
		no = 1028,
		priority = 1,
		weight = 80,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 6},
		condition_list = [45, 118]
};

get(1029) ->
	#bo_ai{
		no = 1029,
		priority = 1,
		weight = 90,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 6},
		condition_list = [45, 118]
};

get(1030) ->
	#bo_ai{
		no = 1030,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 6},
		condition_list = [45, 118]
};

get(1031) ->
	#bo_ai{
		no = 1031,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 5},
		condition_list = [46, 119]
};

get(1032) ->
	#bo_ai{
		no = 1032,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 5},
		condition_list = [46, 119]
};

get(1033) ->
	#bo_ai{
		no = 1033,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 5},
		condition_list = [46, 119]
};

get(1034) ->
	#bo_ai{
		no = 1034,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 5},
		condition_list = [46, 119]
};

get(1035) ->
	#bo_ai{
		no = 1035,
		priority = 1,
		weight = 50,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 5},
		condition_list = [46, 119]
};

get(1036) ->
	#bo_ai{
		no = 1036,
		priority = 1,
		weight = 60,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 5},
		condition_list = [46, 119]
};

get(1037) ->
	#bo_ai{
		no = 1037,
		priority = 1,
		weight = 70,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 5},
		condition_list = [46, 119]
};

get(1038) ->
	#bo_ai{
		no = 1038,
		priority = 1,
		weight = 80,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 5},
		condition_list = [46, 119]
};

get(1039) ->
	#bo_ai{
		no = 1039,
		priority = 1,
		weight = 90,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 5},
		condition_list = [46, 119]
};

get(1040) ->
	#bo_ai{
		no = 1040,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control],
		action_content = {use_skill, 5},
		condition_list = [46, 119]
};

get(1041) ->
	#bo_ai{
		no = 1041,
		priority = 2,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill, 1},
		condition_list = [47, 111]
};

get(1042) ->
	#bo_ai{
		no = 1042,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill, 1},
		condition_list = [47, 111]
};

get(1043) ->
	#bo_ai{
		no = 1043,
		priority = 2,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill, 1},
		condition_list = [47, 111]
};

get(1044) ->
	#bo_ai{
		no = 1044,
		priority = 2,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill, 1},
		condition_list = [47, 111]
};

get(1045) ->
	#bo_ai{
		no = 1045,
		priority = 2,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill, 1},
		condition_list = [47, 111]
};

get(1046) ->
	#bo_ai{
		no = 1046,
		priority = 2,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill, 1},
		condition_list = [47, 111]
};

get(1047) ->
	#bo_ai{
		no = 1047,
		priority = 2,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill, 1},
		condition_list = [47, 111]
};

get(1048) ->
	#bo_ai{
		no = 1048,
		priority = 2,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill, 1},
		condition_list = [47, 111]
};

get(1049) ->
	#bo_ai{
		no = 1049,
		priority = 2,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill, 1},
		condition_list = [47, 111]
};

get(1050) ->
	#bo_ai{
		no = 1050,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill, 1},
		condition_list = [47, 111]
};

get(1051) ->
	#bo_ai{
		no = 1051,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 7},
		condition_list = [77]
};

get(1052) ->
	#bo_ai{
		no = 1052,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 7},
		condition_list = [77]
};

get(1053) ->
	#bo_ai{
		no = 1053,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 7},
		condition_list = [77]
};

get(1054) ->
	#bo_ai{
		no = 1054,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 7},
		condition_list = [77]
};

get(1055) ->
	#bo_ai{
		no = 1055,
		priority = 1,
		weight = 50,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 7},
		condition_list = [77]
};

get(1056) ->
	#bo_ai{
		no = 1056,
		priority = 1,
		weight = 60,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 7},
		condition_list = [77]
};

get(1057) ->
	#bo_ai{
		no = 1057,
		priority = 1,
		weight = 70,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 7},
		condition_list = [77]
};

get(1058) ->
	#bo_ai{
		no = 1058,
		priority = 1,
		weight = 80,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 7},
		condition_list = [77]
};

get(1059) ->
	#bo_ai{
		no = 1059,
		priority = 1,
		weight = 90,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 7},
		condition_list = [77]
};

get(1060) ->
	#bo_ai{
		no = 1060,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 7},
		condition_list = [77]
};

get(1061) ->
	#bo_ai{
		no = 1061,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}, undead],
		action_content = {use_skill, 23},
		condition_list = [82, 83, 84]
};

get(1062) ->
	#bo_ai{
		no = 1062,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}, undead],
		action_content = {use_skill, 23},
		condition_list = [82, 83, 84]
};

get(1063) ->
	#bo_ai{
		no = 1063,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}, undead],
		action_content = {use_skill, 23},
		condition_list = [82, 83, 84]
};

get(1064) ->
	#bo_ai{
		no = 1064,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}, undead],
		action_content = {use_skill, 23},
		condition_list = [82, 83, 84]
};

get(1065) ->
	#bo_ai{
		no = 1065,
		priority = 1,
		weight = 50,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}, undead],
		action_content = {use_skill, 23},
		condition_list = [82, 83, 84]
};

get(1066) ->
	#bo_ai{
		no = 1066,
		priority = 1,
		weight = 60,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}, undead],
		action_content = {use_skill, 23},
		condition_list = [82, 83, 84]
};

get(1067) ->
	#bo_ai{
		no = 1067,
		priority = 1,
		weight = 70,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}, undead],
		action_content = {use_skill, 23},
		condition_list = [82, 83, 84]
};

get(1068) ->
	#bo_ai{
		no = 1068,
		priority = 1,
		weight = 80,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}, undead],
		action_content = {use_skill, 23},
		condition_list = [82, 83, 84]
};

get(1069) ->
	#bo_ai{
		no = 1069,
		priority = 1,
		weight = 90,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}, undead],
		action_content = {use_skill, 23},
		condition_list = [82, 83, 84]
};

get(1070) ->
	#bo_ai{
		no = 1070,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}, undead],
		action_content = {use_skill, 23},
		condition_list = [82, 83, 84]
};

get(1101) ->
	#bo_ai{
		no = 1101,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,11},
		condition_list = [48]
};

get(1102) ->
	#bo_ai{
		no = 1102,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,11},
		condition_list = [48]
};

get(1103) ->
	#bo_ai{
		no = 1103,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,11},
		condition_list = [48]
};

get(1104) ->
	#bo_ai{
		no = 1104,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,11},
		condition_list = [48]
};

get(1105) ->
	#bo_ai{
		no = 1105,
		priority = 1,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,11},
		condition_list = [48]
};

get(1106) ->
	#bo_ai{
		no = 1106,
		priority = 1,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,11},
		condition_list = [48]
};

get(1107) ->
	#bo_ai{
		no = 1107,
		priority = 1,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,11},
		condition_list = [48]
};

get(1108) ->
	#bo_ai{
		no = 1108,
		priority = 1,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,11},
		condition_list = [48]
};

get(1109) ->
	#bo_ai{
		no = 1109,
		priority = 1,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,11},
		condition_list = [48]
};

get(1110) ->
	#bo_ai{
		no = 1110,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,11},
		condition_list = [48]
};

get(1111) ->
	#bo_ai{
		no = 1111,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [myself],
		action_content = {use_skill,13},
		condition_list = [16, 49]
};

get(1112) ->
	#bo_ai{
		no = 1112,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill,13},
		condition_list = [16, 49]
};

get(1113) ->
	#bo_ai{
		no = 1113,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [myself],
		action_content = {use_skill,13},
		condition_list = [16, 49]
};

get(1114) ->
	#bo_ai{
		no = 1114,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [myself],
		action_content = {use_skill,13},
		condition_list = [16, 49]
};

get(1115) ->
	#bo_ai{
		no = 1115,
		priority = 1,
		weight = 50,
		rules_filter_action_target = [myself],
		action_content = {use_skill,13},
		condition_list = [16, 49]
};

get(1116) ->
	#bo_ai{
		no = 1116,
		priority = 1,
		weight = 60,
		rules_filter_action_target = [myself],
		action_content = {use_skill,13},
		condition_list = [16, 49]
};

get(1117) ->
	#bo_ai{
		no = 1117,
		priority = 1,
		weight = 70,
		rules_filter_action_target = [myself],
		action_content = {use_skill,13},
		condition_list = [16, 49]
};

get(1118) ->
	#bo_ai{
		no = 1118,
		priority = 1,
		weight = 80,
		rules_filter_action_target = [myself],
		action_content = {use_skill,13},
		condition_list = [16, 49]
};

get(1119) ->
	#bo_ai{
		no = 1119,
		priority = 1,
		weight = 90,
		rules_filter_action_target = [myself],
		action_content = {use_skill,13},
		condition_list = [16, 49]
};

get(1120) ->
	#bo_ai{
		no = 1120,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill,13},
		condition_list = [16, 49]
};

get(1121) ->
	#bo_ai{
		no = 1121,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me],
		action_content = {use_skill,14},
		condition_list = [50]
};

get(1122) ->
	#bo_ai{
		no = 1122,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me],
		action_content = {use_skill,14},
		condition_list = [50]
};

get(1123) ->
	#bo_ai{
		no = 1123,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me],
		action_content = {use_skill,14},
		condition_list = [50]
};

get(1124) ->
	#bo_ai{
		no = 1124,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me],
		action_content = {use_skill,14},
		condition_list = [50]
};

get(1125) ->
	#bo_ai{
		no = 1125,
		priority = 1,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me],
		action_content = {use_skill,14},
		condition_list = [50]
};

get(1126) ->
	#bo_ai{
		no = 1126,
		priority = 1,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me],
		action_content = {use_skill,14},
		condition_list = [50]
};

get(1127) ->
	#bo_ai{
		no = 1127,
		priority = 1,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me],
		action_content = {use_skill,14},
		condition_list = [50]
};

get(1128) ->
	#bo_ai{
		no = 1128,
		priority = 1,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me],
		action_content = {use_skill,14},
		condition_list = [50]
};

get(1129) ->
	#bo_ai{
		no = 1129,
		priority = 1,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me],
		action_content = {use_skill,14},
		condition_list = [50]
};

get(1130) ->
	#bo_ai{
		no = 1130,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me],
		action_content = {use_skill,14},
		condition_list = [50]
};

get(1131) ->
	#bo_ai{
		no = 1131,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [myself],
		action_content = {use_skill,15},
		condition_list = [51, 19]
};

get(1132) ->
	#bo_ai{
		no = 1132,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill,15},
		condition_list = [51, 19]
};

get(1133) ->
	#bo_ai{
		no = 1133,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [myself],
		action_content = {use_skill,15},
		condition_list = [51, 19]
};

get(1134) ->
	#bo_ai{
		no = 1134,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [myself],
		action_content = {use_skill,15},
		condition_list = [51, 19]
};

get(1135) ->
	#bo_ai{
		no = 1135,
		priority = 1,
		weight = 50,
		rules_filter_action_target = [myself],
		action_content = {use_skill,15},
		condition_list = [51, 19]
};

get(1136) ->
	#bo_ai{
		no = 1136,
		priority = 1,
		weight = 60,
		rules_filter_action_target = [myself],
		action_content = {use_skill,15},
		condition_list = [51, 19]
};

get(1137) ->
	#bo_ai{
		no = 1137,
		priority = 1,
		weight = 70,
		rules_filter_action_target = [myself],
		action_content = {use_skill,15},
		condition_list = [51, 19]
};

get(1138) ->
	#bo_ai{
		no = 1138,
		priority = 1,
		weight = 80,
		rules_filter_action_target = [myself],
		action_content = {use_skill,15},
		condition_list = [51, 19]
};

get(1139) ->
	#bo_ai{
		no = 1139,
		priority = 1,
		weight = 90,
		rules_filter_action_target = [myself],
		action_content = {use_skill,15},
		condition_list = [51, 19]
};

get(1140) ->
	#bo_ai{
		no = 1140,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill,15},
		condition_list = [51, 19]
};

get(1141) ->
	#bo_ai{
		no = 1141,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [myself,is_not_frozen],
		action_content = {use_skill,12},
		condition_list = [52]
};

get(1142) ->
	#bo_ai{
		no = 1142,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [myself,is_not_frozen],
		action_content = {use_skill,12},
		condition_list = [52]
};

get(1143) ->
	#bo_ai{
		no = 1143,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [myself,is_not_frozen],
		action_content = {use_skill,12},
		condition_list = [52]
};

get(1144) ->
	#bo_ai{
		no = 1144,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [myself,is_not_frozen],
		action_content = {use_skill,12},
		condition_list = [52]
};

get(1145) ->
	#bo_ai{
		no = 1145,
		priority = 1,
		weight = 50,
		rules_filter_action_target = [myself,is_not_frozen],
		action_content = {use_skill,12},
		condition_list = [52]
};

get(1146) ->
	#bo_ai{
		no = 1146,
		priority = 1,
		weight = 60,
		rules_filter_action_target = [myself,is_not_frozen],
		action_content = {use_skill,12},
		condition_list = [52]
};

get(1147) ->
	#bo_ai{
		no = 1147,
		priority = 1,
		weight = 70,
		rules_filter_action_target = [myself,is_not_frozen],
		action_content = {use_skill,12},
		condition_list = [52]
};

get(1148) ->
	#bo_ai{
		no = 1148,
		priority = 1,
		weight = 80,
		rules_filter_action_target = [myself,is_not_frozen],
		action_content = {use_skill,12},
		condition_list = [52]
};

get(1149) ->
	#bo_ai{
		no = 1149,
		priority = 1,
		weight = 90,
		rules_filter_action_target = [myself,is_not_frozen],
		action_content = {use_skill,12},
		condition_list = [52]
};

get(1150) ->
	#bo_ai{
		no = 1150,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [myself,is_not_frozen],
		action_content = {use_skill,12},
		condition_list = [52]
};

get(1151) ->
	#bo_ai{
		no = 1151,
		priority = 2,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,16},
		condition_list = [53]
};

get(1152) ->
	#bo_ai{
		no = 1152,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,16},
		condition_list = [53]
};

get(1153) ->
	#bo_ai{
		no = 1153,
		priority = 2,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,16},
		condition_list = [53]
};

get(1154) ->
	#bo_ai{
		no = 1154,
		priority = 2,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,16},
		condition_list = [53]
};

get(1155) ->
	#bo_ai{
		no = 1155,
		priority = 2,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,16},
		condition_list = [53]
};

get(1156) ->
	#bo_ai{
		no = 1156,
		priority = 2,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,16},
		condition_list = [53]
};

get(1157) ->
	#bo_ai{
		no = 1157,
		priority = 2,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,16},
		condition_list = [53]
};

get(1158) ->
	#bo_ai{
		no = 1158,
		priority = 2,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,16},
		condition_list = [53]
};

get(1159) ->
	#bo_ai{
		no = 1159,
		priority = 2,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,16},
		condition_list = [53]
};

get(1160) ->
	#bo_ai{
		no = 1160,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,16},
		condition_list = [53]
};

get(1161) ->
	#bo_ai{
		no = 1161,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [myself],
		action_content = {use_skill,17},
		condition_list = [54, 23]
};

get(1162) ->
	#bo_ai{
		no = 1162,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill,17},
		condition_list = [54, 23]
};

get(1163) ->
	#bo_ai{
		no = 1163,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [myself],
		action_content = {use_skill,17},
		condition_list = [54, 23]
};

get(1164) ->
	#bo_ai{
		no = 1164,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [myself],
		action_content = {use_skill,17},
		condition_list = [54, 23]
};

get(1165) ->
	#bo_ai{
		no = 1165,
		priority = 1,
		weight = 50,
		rules_filter_action_target = [myself],
		action_content = {use_skill,17},
		condition_list = [54, 23]
};

get(1166) ->
	#bo_ai{
		no = 1166,
		priority = 1,
		weight = 60,
		rules_filter_action_target = [myself],
		action_content = {use_skill,17},
		condition_list = [54, 23]
};

get(1167) ->
	#bo_ai{
		no = 1167,
		priority = 1,
		weight = 70,
		rules_filter_action_target = [myself],
		action_content = {use_skill,17},
		condition_list = [54, 23]
};

get(1168) ->
	#bo_ai{
		no = 1168,
		priority = 1,
		weight = 80,
		rules_filter_action_target = [myself],
		action_content = {use_skill,17},
		condition_list = [54, 23]
};

get(1169) ->
	#bo_ai{
		no = 1169,
		priority = 1,
		weight = 90,
		rules_filter_action_target = [myself],
		action_content = {use_skill,17},
		condition_list = [54, 23]
};

get(1170) ->
	#bo_ai{
		no = 1170,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill,17},
		condition_list = [54, 23]
};

get(1201) ->
	#bo_ai{
		no = 1201,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 41},
		condition_list = [55]
};

get(1202) ->
	#bo_ai{
		no = 1202,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 41},
		condition_list = [55]
};

get(1203) ->
	#bo_ai{
		no = 1203,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 41},
		condition_list = [55]
};

get(1204) ->
	#bo_ai{
		no = 1204,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 41},
		condition_list = [55]
};

get(1205) ->
	#bo_ai{
		no = 1205,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 41},
		condition_list = [55]
};

get(1206) ->
	#bo_ai{
		no = 1206,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 41},
		condition_list = [55]
};

get(1207) ->
	#bo_ai{
		no = 1207,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 41},
		condition_list = [55]
};

get(1208) ->
	#bo_ai{
		no = 1208,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 41},
		condition_list = [55]
};

get(1209) ->
	#bo_ai{
		no = 1209,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 41},
		condition_list = [55]
};

get(1210) ->
	#bo_ai{
		no = 1210,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 41},
		condition_list = [55]
};

get(1211) ->
	#bo_ai{
		no = 1211,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 42},
		condition_list = [56]
};

get(1212) ->
	#bo_ai{
		no = 1212,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 42},
		condition_list = [56]
};

get(1213) ->
	#bo_ai{
		no = 1213,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 42},
		condition_list = [56]
};

get(1214) ->
	#bo_ai{
		no = 1214,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 42},
		condition_list = [56]
};

get(1215) ->
	#bo_ai{
		no = 1215,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 42},
		condition_list = [56]
};

get(1216) ->
	#bo_ai{
		no = 1216,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 42},
		condition_list = [56]
};

get(1217) ->
	#bo_ai{
		no = 1217,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 42},
		condition_list = [56]
};

get(1218) ->
	#bo_ai{
		no = 1218,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 42},
		condition_list = [56]
};

get(1219) ->
	#bo_ai{
		no = 1219,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 42},
		condition_list = [56]
};

get(1220) ->
	#bo_ai{
		no = 1220,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 42},
		condition_list = [56]
};

get(1221) ->
	#bo_ai{
		no = 1221,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 43},
		condition_list = [57,25,26]
};

get(1222) ->
	#bo_ai{
		no = 1222,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 43},
		condition_list = [57,25,26]
};

get(1223) ->
	#bo_ai{
		no = 1223,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 43},
		condition_list = [57,25,26]
};

get(1224) ->
	#bo_ai{
		no = 1224,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 43},
		condition_list = [57,25,26]
};

get(1225) ->
	#bo_ai{
		no = 1225,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 43},
		condition_list = [57,25,26]
};

get(1226) ->
	#bo_ai{
		no = 1226,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 43},
		condition_list = [57,25,26]
};

get(1227) ->
	#bo_ai{
		no = 1227,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 43},
		condition_list = [57,25,26]
};

get(1228) ->
	#bo_ai{
		no = 1228,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 43},
		condition_list = [57,25,26]
};

get(1229) ->
	#bo_ai{
		no = 1229,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 43},
		condition_list = [57,25,26]
};

get(1230) ->
	#bo_ai{
		no = 1230,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 43},
		condition_list = [57,25,26]
};

get(1231) ->
	#bo_ai{
		no = 1231,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_player],
		action_content = {use_skill, 44},
		condition_list = [58]
};

get(1232) ->
	#bo_ai{
		no = 1232,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_player],
		action_content = {use_skill, 44},
		condition_list = [58]
};

get(1233) ->
	#bo_ai{
		no = 1233,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_player],
		action_content = {use_skill, 44},
		condition_list = [58]
};

get(1234) ->
	#bo_ai{
		no = 1234,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_player],
		action_content = {use_skill, 44},
		condition_list = [58]
};

get(1235) ->
	#bo_ai{
		no = 1235,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_player],
		action_content = {use_skill, 44},
		condition_list = [58]
};

get(1236) ->
	#bo_ai{
		no = 1236,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_player],
		action_content = {use_skill, 44},
		condition_list = [58]
};

get(1237) ->
	#bo_ai{
		no = 1237,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_player],
		action_content = {use_skill, 44},
		condition_list = [58]
};

get(1238) ->
	#bo_ai{
		no = 1238,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_player],
		action_content = {use_skill, 44},
		condition_list = [58]
};

get(1239) ->
	#bo_ai{
		no = 1239,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_player],
		action_content = {use_skill, 44},
		condition_list = [58]
};

get(1240) ->
	#bo_ai{
		no = 1240,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_player],
		action_content = {use_skill, 44},
		condition_list = [58]
};

get(1241) ->
	#bo_ai{
		no = 1241,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 45},
		condition_list = [59,25,26]
};

get(1242) ->
	#bo_ai{
		no = 1242,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 45},
		condition_list = [59,25,26]
};

get(1243) ->
	#bo_ai{
		no = 1243,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 45},
		condition_list = [59,25,26]
};

get(1244) ->
	#bo_ai{
		no = 1244,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 45},
		condition_list = [59,25,26]
};

get(1245) ->
	#bo_ai{
		no = 1245,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 45},
		condition_list = [59,25,26]
};

get(1246) ->
	#bo_ai{
		no = 1246,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 45},
		condition_list = [59,25,26]
};

get(1247) ->
	#bo_ai{
		no = 1247,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 45},
		condition_list = [59,25,26]
};

get(1248) ->
	#bo_ai{
		no = 1248,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 45},
		condition_list = [59,25,26]
};

get(1249) ->
	#bo_ai{
		no = 1249,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 45},
		condition_list = [59,25,26]
};

get(1250) ->
	#bo_ai{
		no = 1250,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 25}],
		action_content = {use_skill, 45},
		condition_list = [59,25,26]
};

get(1251) ->
	#bo_ai{
		no = 1251,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 46},
		condition_list = [60,29]
};

get(1252) ->
	#bo_ai{
		no = 1252,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 46},
		condition_list = [60,29]
};

get(1253) ->
	#bo_ai{
		no = 1253,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 46},
		condition_list = [60,29]
};

get(1254) ->
	#bo_ai{
		no = 1254,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 46},
		condition_list = [60,29]
};

get(1255) ->
	#bo_ai{
		no = 1255,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 46},
		condition_list = [60,29]
};

get(1256) ->
	#bo_ai{
		no = 1256,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 46},
		condition_list = [60,29]
};

get(1257) ->
	#bo_ai{
		no = 1257,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 46},
		condition_list = [60,29]
};

get(1258) ->
	#bo_ai{
		no = 1258,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 46},
		condition_list = [60,29]
};

get(1259) ->
	#bo_ai{
		no = 1259,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 46},
		condition_list = [60,29]
};

get(1260) ->
	#bo_ai{
		no = 1260,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 46},
		condition_list = [60,29]
};

get(1261) ->
	#bo_ai{
		no = 1261,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 47},
		condition_list = [61]
};

get(1262) ->
	#bo_ai{
		no = 1262,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 47},
		condition_list = [61]
};

get(1263) ->
	#bo_ai{
		no = 1263,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 47},
		condition_list = [61]
};

get(1264) ->
	#bo_ai{
		no = 1264,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 47},
		condition_list = [61]
};

get(1265) ->
	#bo_ai{
		no = 1265,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 47},
		condition_list = [61]
};

get(1266) ->
	#bo_ai{
		no = 1266,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 47},
		condition_list = [61]
};

get(1267) ->
	#bo_ai{
		no = 1267,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 47},
		condition_list = [61]
};

get(1268) ->
	#bo_ai{
		no = 1268,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 47},
		condition_list = [61]
};

get(1269) ->
	#bo_ai{
		no = 1269,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 47},
		condition_list = [61]
};

get(1270) ->
	#bo_ai{
		no = 1270,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 47},
		condition_list = [61]
};

get(1301) ->
	#bo_ai{
		no = 1301,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me,is_not_frozen,  enemy_side],
		action_content = {use_skill, 51},
		condition_list = [62]
};

get(1302) ->
	#bo_ai{
		no = 1302,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me,is_not_frozen,  enemy_side],
		action_content = {use_skill, 51},
		condition_list = [62]
};

get(1303) ->
	#bo_ai{
		no = 1303,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me,is_not_frozen,  enemy_side],
		action_content = {use_skill, 51},
		condition_list = [62]
};

get(1304) ->
	#bo_ai{
		no = 1304,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me,is_not_frozen,  enemy_side],
		action_content = {use_skill, 51},
		condition_list = [62]
};

get(1305) ->
	#bo_ai{
		no = 1305,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me,is_not_frozen,  enemy_side],
		action_content = {use_skill, 51},
		condition_list = [62]
};

get(1306) ->
	#bo_ai{
		no = 1306,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me,is_not_frozen,  enemy_side],
		action_content = {use_skill, 51},
		condition_list = [62]
};

get(1307) ->
	#bo_ai{
		no = 1307,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me,is_not_frozen,  enemy_side],
		action_content = {use_skill, 51},
		condition_list = [62]
};

get(1308) ->
	#bo_ai{
		no = 1308,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me,is_not_frozen,  enemy_side],
		action_content = {use_skill, 51},
		condition_list = [62]
};

get(1309) ->
	#bo_ai{
		no = 1309,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me,is_not_frozen,  enemy_side],
		action_content = {use_skill, 51},
		condition_list = [62]
};

get(1310) ->
	#bo_ai{
		no = 1310,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me,is_not_frozen,  enemy_side],
		action_content = {use_skill, 51},
		condition_list = [62]
};

get(1311) ->
	#bo_ai{
		no = 1311,
		priority = 101,
		weight = 10,
		rules_filter_action_target = [ally_side, is_fallen],
		action_content = {use_skill, 52},
		condition_list = [63,31]
};

get(1312) ->
	#bo_ai{
		no = 1312,
		priority = 101,
		weight = 20,
		rules_filter_action_target = [ally_side, is_fallen],
		action_content = {use_skill, 52},
		condition_list = [63,31]
};

get(1313) ->
	#bo_ai{
		no = 1313,
		priority = 101,
		weight = 30,
		rules_filter_action_target = [ally_side, is_fallen],
		action_content = {use_skill, 52},
		condition_list = [63,31]
};

get(1314) ->
	#bo_ai{
		no = 1314,
		priority = 101,
		weight = 40,
		rules_filter_action_target = [ally_side, is_fallen],
		action_content = {use_skill, 52},
		condition_list = [63,31]
};

get(1315) ->
	#bo_ai{
		no = 1315,
		priority = 101,
		weight = 50,
		rules_filter_action_target = [ally_side, is_fallen],
		action_content = {use_skill, 52},
		condition_list = [63,31]
};

get(1316) ->
	#bo_ai{
		no = 1316,
		priority = 101,
		weight = 60,
		rules_filter_action_target = [ally_side, is_fallen],
		action_content = {use_skill, 52},
		condition_list = [63,31]
};

get(1317) ->
	#bo_ai{
		no = 1317,
		priority = 101,
		weight = 70,
		rules_filter_action_target = [ally_side, is_fallen],
		action_content = {use_skill, 52},
		condition_list = [63,31]
};

get(1318) ->
	#bo_ai{
		no = 1318,
		priority = 101,
		weight = 80,
		rules_filter_action_target = [ally_side, is_fallen],
		action_content = {use_skill, 52},
		condition_list = [63,31]
};

get(1319) ->
	#bo_ai{
		no = 1319,
		priority = 101,
		weight = 90,
		rules_filter_action_target = [ally_side, is_fallen],
		action_content = {use_skill, 52},
		condition_list = [63,31]
};

get(1320) ->
	#bo_ai{
		no = 1320,
		priority = 101,
		weight = 100,
		rules_filter_action_target = [ally_side, is_fallen],
		action_content = {use_skill, 52},
		condition_list = [63,31]
};

get(1321) ->
	#bo_ai{
		no = 1321,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 28}],
		action_content = {use_skill, 53},
		condition_list = [33,64]
};

get(1322) ->
	#bo_ai{
		no = 1322,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 28}],
		action_content = {use_skill, 53},
		condition_list = [33,64]
};

get(1323) ->
	#bo_ai{
		no = 1323,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 28}],
		action_content = {use_skill, 53},
		condition_list = [33,64]
};

get(1324) ->
	#bo_ai{
		no = 1324,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 28}],
		action_content = {use_skill, 53},
		condition_list = [33,64]
};

get(1325) ->
	#bo_ai{
		no = 1325,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 28}],
		action_content = {use_skill, 53},
		condition_list = [33,64]
};

get(1326) ->
	#bo_ai{
		no = 1326,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 28}],
		action_content = {use_skill, 53},
		condition_list = [33,64]
};

get(1327) ->
	#bo_ai{
		no = 1327,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 28}],
		action_content = {use_skill, 53},
		condition_list = [33,64]
};

get(1328) ->
	#bo_ai{
		no = 1328,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 28}],
		action_content = {use_skill, 53},
		condition_list = [33,64]
};

get(1329) ->
	#bo_ai{
		no = 1329,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 28}],
		action_content = {use_skill, 53},
		condition_list = [33,64]
};

get(1330) ->
	#bo_ai{
		no = 1330,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 28}],
		action_content = {use_skill, 53},
		condition_list = [33,64]
};

get(1331) ->
	#bo_ai{
		no = 1331,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 29}],
		action_content = {use_skill, 54},
		condition_list = [35,65]
};

get(1332) ->
	#bo_ai{
		no = 1332,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 29}],
		action_content = {use_skill, 54},
		condition_list = [35,65]
};

get(1333) ->
	#bo_ai{
		no = 1333,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 29}],
		action_content = {use_skill, 54},
		condition_list = [35,65]
};

get(1334) ->
	#bo_ai{
		no = 1334,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 29}],
		action_content = {use_skill, 54},
		condition_list = [35,65]
};

get(1335) ->
	#bo_ai{
		no = 1335,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 29}],
		action_content = {use_skill, 54},
		condition_list = [35,65]
};

get(1336) ->
	#bo_ai{
		no = 1336,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 29}],
		action_content = {use_skill, 54},
		condition_list = [35,65]
};

get(1337) ->
	#bo_ai{
		no = 1337,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 29}],
		action_content = {use_skill, 54},
		condition_list = [35,65]
};

get(1338) ->
	#bo_ai{
		no = 1338,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 29}],
		action_content = {use_skill, 54},
		condition_list = [35,65]
};

get(1339) ->
	#bo_ai{
		no = 1339,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 29}],
		action_content = {use_skill, 54},
		condition_list = [35,65]
};

get(1340) ->
	#bo_ai{
		no = 1340,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 29}],
		action_content = {use_skill, 54},
		condition_list = [35,65]
};

get(1341) ->
	#bo_ai{
		no = 1341,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 30}],
		action_content = {use_skill, 55},
		condition_list = [36,66]
};

get(1342) ->
	#bo_ai{
		no = 1342,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 30}],
		action_content = {use_skill, 55},
		condition_list = [36,66]
};

get(1343) ->
	#bo_ai{
		no = 1343,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 30}],
		action_content = {use_skill, 55},
		condition_list = [36,66]
};

get(1344) ->
	#bo_ai{
		no = 1344,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 30}],
		action_content = {use_skill, 55},
		condition_list = [36,66]
};

get(1345) ->
	#bo_ai{
		no = 1345,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 30}],
		action_content = {use_skill, 55},
		condition_list = [36,66]
};

get(1346) ->
	#bo_ai{
		no = 1346,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 30}],
		action_content = {use_skill, 55},
		condition_list = [36,66]
};

get(1347) ->
	#bo_ai{
		no = 1347,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 30}],
		action_content = {use_skill, 55},
		condition_list = [36,66]
};

get(1348) ->
	#bo_ai{
		no = 1348,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 30}],
		action_content = {use_skill, 55},
		condition_list = [36,66]
};

get(1349) ->
	#bo_ai{
		no = 1349,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 30}],
		action_content = {use_skill, 55},
		condition_list = [36,66]
};

get(1350) ->
	#bo_ai{
		no = 1350,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [ally_side, undead,{has_not_spec_no_buff, 30}],
		action_content = {use_skill, 55},
		condition_list = [36,66]
};

get(1351) ->
	#bo_ai{
		no = 1351,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 32}, {has_not_spec_no_buff, 33}],
		action_content = {use_skill, 56},
		condition_list = [78,79]
};

get(1352) ->
	#bo_ai{
		no = 1352,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 32}, {has_not_spec_no_buff, 33}],
		action_content = {use_skill, 56},
		condition_list = [78,79]
};

get(1353) ->
	#bo_ai{
		no = 1353,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 32}, {has_not_spec_no_buff, 33}],
		action_content = {use_skill, 56},
		condition_list = [78,79]
};

get(1354) ->
	#bo_ai{
		no = 1354,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 32}, {has_not_spec_no_buff, 33}],
		action_content = {use_skill, 56},
		condition_list = [78,79]
};

get(1355) ->
	#bo_ai{
		no = 1355,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 32}, {has_not_spec_no_buff, 33}],
		action_content = {use_skill, 56},
		condition_list = [78,79]
};

get(1356) ->
	#bo_ai{
		no = 1356,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 32}, {has_not_spec_no_buff, 33}],
		action_content = {use_skill, 56},
		condition_list = [78,79]
};

get(1357) ->
	#bo_ai{
		no = 1357,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 32}, {has_not_spec_no_buff, 33}],
		action_content = {use_skill, 56},
		condition_list = [78,79]
};

get(1358) ->
	#bo_ai{
		no = 1358,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 32}, {has_not_spec_no_buff, 33}],
		action_content = {use_skill, 56},
		condition_list = [78,79]
};

get(1359) ->
	#bo_ai{
		no = 1359,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 32}, {has_not_spec_no_buff, 33}],
		action_content = {use_skill, 56},
		condition_list = [78,79]
};

get(1360) ->
	#bo_ai{
		no = 1360,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, {has_not_spec_no_buff, 32}, {has_not_spec_no_buff, 33}],
		action_content = {use_skill, 56},
		condition_list = [78,79]
};

get(1361) ->
	#bo_ai{
		no = 1361,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 57},
		condition_list = [68]
};

get(1362) ->
	#bo_ai{
		no = 1362,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 57},
		condition_list = [68]
};

get(1363) ->
	#bo_ai{
		no = 1363,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 57},
		condition_list = [68]
};

get(1364) ->
	#bo_ai{
		no = 1364,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 57},
		condition_list = [68]
};

get(1365) ->
	#bo_ai{
		no = 1365,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 57},
		condition_list = [68]
};

get(1366) ->
	#bo_ai{
		no = 1366,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 57},
		condition_list = [68]
};

get(1367) ->
	#bo_ai{
		no = 1367,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 57},
		condition_list = [68]
};

get(1368) ->
	#bo_ai{
		no = 1368,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 57},
		condition_list = [68]
};

get(1369) ->
	#bo_ai{
		no = 1369,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 57},
		condition_list = [68]
};

get(1370) ->
	#bo_ai{
		no = 1370,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 57},
		condition_list = [68]
};

get(1401) ->
	#bo_ai{
		no = 1401,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 21},
		condition_list = [86]
};

get(1402) ->
	#bo_ai{
		no = 1402,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 21},
		condition_list = [86]
};

get(1403) ->
	#bo_ai{
		no = 1403,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 21},
		condition_list = [86]
};

get(1404) ->
	#bo_ai{
		no = 1404,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 21},
		condition_list = [86]
};

get(1405) ->
	#bo_ai{
		no = 1405,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 21},
		condition_list = [86]
};

get(1406) ->
	#bo_ai{
		no = 1406,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 21},
		condition_list = [86]
};

get(1407) ->
	#bo_ai{
		no = 1407,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 21},
		condition_list = [86]
};

get(1408) ->
	#bo_ai{
		no = 1408,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 21},
		condition_list = [86]
};

get(1409) ->
	#bo_ai{
		no = 1409,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 21},
		condition_list = [86]
};

get(1410) ->
	#bo_ai{
		no = 1410,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 21},
		condition_list = [86]
};

get(1411) ->
	#bo_ai{
		no = 1411,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [87]
};

get(1412) ->
	#bo_ai{
		no = 1412,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [87]
};

get(1413) ->
	#bo_ai{
		no = 1413,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [87]
};

get(1414) ->
	#bo_ai{
		no = 1414,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [87]
};

get(1415) ->
	#bo_ai{
		no = 1415,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [87]
};

get(1416) ->
	#bo_ai{
		no = 1416,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [87]
};

get(1417) ->
	#bo_ai{
		no = 1417,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [87]
};

get(1418) ->
	#bo_ai{
		no = 1418,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [87]
};

get(1419) ->
	#bo_ai{
		no = 1419,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [87]
};

get(1420) ->
	#bo_ai{
		no = 1420,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [87]
};

get(1421) ->
	#bo_ai{
		no = 1421,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 23},
		condition_list = [88,93]
};

get(1422) ->
	#bo_ai{
		no = 1422,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 23},
		condition_list = [88,93]
};

get(1423) ->
	#bo_ai{
		no = 1423,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 23},
		condition_list = [88,93]
};

get(1424) ->
	#bo_ai{
		no = 1424,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 23},
		condition_list = [88,93]
};

get(1425) ->
	#bo_ai{
		no = 1425,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 23},
		condition_list = [88,93]
};

get(1426) ->
	#bo_ai{
		no = 1426,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 23},
		condition_list = [88,93]
};

get(1427) ->
	#bo_ai{
		no = 1427,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 23},
		condition_list = [88,93]
};

get(1428) ->
	#bo_ai{
		no = 1428,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 23},
		condition_list = [88,93]
};

get(1429) ->
	#bo_ai{
		no = 1429,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 23},
		condition_list = [88,93]
};

get(1430) ->
	#bo_ai{
		no = 1430,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 23},
		condition_list = [88,93]
};

get(1431) ->
	#bo_ai{
		no = 1431,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead,is_not_frozen],
		action_content = {use_skill, 24},
		condition_list = [89]
};

get(1432) ->
	#bo_ai{
		no = 1432,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead,is_not_frozen],
		action_content = {use_skill, 24},
		condition_list = [89]
};

get(1433) ->
	#bo_ai{
		no = 1433,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead,is_not_frozen],
		action_content = {use_skill, 24},
		condition_list = [89]
};

get(1434) ->
	#bo_ai{
		no = 1434,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead,is_not_frozen],
		action_content = {use_skill, 24},
		condition_list = [89]
};

get(1435) ->
	#bo_ai{
		no = 1435,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead,is_not_frozen],
		action_content = {use_skill, 24},
		condition_list = [89]
};

get(1436) ->
	#bo_ai{
		no = 1436,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead,is_not_frozen],
		action_content = {use_skill, 24},
		condition_list = [89]
};

get(1437) ->
	#bo_ai{
		no = 1437,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead,is_not_frozen],
		action_content = {use_skill, 24},
		condition_list = [89]
};

get(1438) ->
	#bo_ai{
		no = 1438,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead,is_not_frozen],
		action_content = {use_skill, 24},
		condition_list = [89]
};

get(1439) ->
	#bo_ai{
		no = 1439,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead,is_not_frozen],
		action_content = {use_skill, 24},
		condition_list = [89]
};

get(1440) ->
	#bo_ai{
		no = 1440,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead,is_not_frozen],
		action_content = {use_skill, 24},
		condition_list = [89]
};

get(1441) ->
	#bo_ai{
		no = 1441,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 25},
		condition_list = [90]
};

get(1442) ->
	#bo_ai{
		no = 1442,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 25},
		condition_list = [90]
};

get(1443) ->
	#bo_ai{
		no = 1443,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 25},
		condition_list = [90]
};

get(1444) ->
	#bo_ai{
		no = 1444,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 25},
		condition_list = [90]
};

get(1445) ->
	#bo_ai{
		no = 1445,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 25},
		condition_list = [90]
};

get(1446) ->
	#bo_ai{
		no = 1446,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 25},
		condition_list = [90]
};

get(1447) ->
	#bo_ai{
		no = 1447,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 25},
		condition_list = [90]
};

get(1448) ->
	#bo_ai{
		no = 1448,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 25},
		condition_list = [90]
};

get(1449) ->
	#bo_ai{
		no = 1449,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 25},
		condition_list = [90]
};

get(1450) ->
	#bo_ai{
		no = 1450,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 25},
		condition_list = [90]
};

get(1451) ->
	#bo_ai{
		no = 1451,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 41}, {has_not_spec_no_buff, 42}, undead],
		action_content = {use_skill, 26},
		condition_list = [91,95]
};

get(1452) ->
	#bo_ai{
		no = 1452,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 41}, {has_not_spec_no_buff, 42}, undead],
		action_content = {use_skill, 26},
		condition_list = [91,95]
};

get(1453) ->
	#bo_ai{
		no = 1453,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 41}, {has_not_spec_no_buff, 42}, undead],
		action_content = {use_skill, 26},
		condition_list = [91,95]
};

get(1454) ->
	#bo_ai{
		no = 1454,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 41}, {has_not_spec_no_buff, 42}, undead],
		action_content = {use_skill, 26},
		condition_list = [91,95]
};

get(1455) ->
	#bo_ai{
		no = 1455,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 41}, {has_not_spec_no_buff, 42}, undead],
		action_content = {use_skill, 26},
		condition_list = [91,95]
};

get(1456) ->
	#bo_ai{
		no = 1456,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 41}, {has_not_spec_no_buff, 42}, undead],
		action_content = {use_skill, 26},
		condition_list = [91,95]
};

get(1457) ->
	#bo_ai{
		no = 1457,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 41}, {has_not_spec_no_buff, 42}, undead],
		action_content = {use_skill, 26},
		condition_list = [91,95]
};

get(1458) ->
	#bo_ai{
		no = 1458,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 41}, {has_not_spec_no_buff, 42}, undead],
		action_content = {use_skill, 26},
		condition_list = [91,95]
};

get(1459) ->
	#bo_ai{
		no = 1459,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 41}, {has_not_spec_no_buff, 42}, undead],
		action_content = {use_skill, 26},
		condition_list = [91,95]
};

get(1460) ->
	#bo_ai{
		no = 1460,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 41}, {has_not_spec_no_buff, 42}, undead],
		action_content = {use_skill, 26},
		condition_list = [91,95]
};

get(1461) ->
	#bo_ai{
		no = 1461,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 43}],
		action_content = {use_skill, 27},
		condition_list = [92,128,102]
};

get(1462) ->
	#bo_ai{
		no = 1462,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 43}],
		action_content = {use_skill, 27},
		condition_list = [92,128,102]
};

get(1463) ->
	#bo_ai{
		no = 1463,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 43}],
		action_content = {use_skill, 27},
		condition_list = [92,128,102]
};

get(1464) ->
	#bo_ai{
		no = 1464,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 43}],
		action_content = {use_skill, 27},
		condition_list = [92,128,102]
};

get(1465) ->
	#bo_ai{
		no = 1465,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 43}],
		action_content = {use_skill, 27},
		condition_list = [92,128,102]
};

get(1466) ->
	#bo_ai{
		no = 1466,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 43}],
		action_content = {use_skill, 27},
		condition_list = [92,128,102]
};

get(1467) ->
	#bo_ai{
		no = 1467,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 43}],
		action_content = {use_skill, 27},
		condition_list = [92,128,102]
};

get(1468) ->
	#bo_ai{
		no = 1468,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 43}],
		action_content = {use_skill, 27},
		condition_list = [92,128,102]
};

get(1469) ->
	#bo_ai{
		no = 1469,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 43}],
		action_content = {use_skill, 27},
		condition_list = [92,128,102]
};

get(1470) ->
	#bo_ai{
		no = 1470,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen, {has_not_spec_no_buff, 43}],
		action_content = {use_skill, 27},
		condition_list = [92,128,102]
};

get(1501) ->
	#bo_ai{
		no = 1501,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 31},
		condition_list = [104]
};

get(1502) ->
	#bo_ai{
		no = 1502,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 31},
		condition_list = [104]
};

get(1503) ->
	#bo_ai{
		no = 1503,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 31},
		condition_list = [104]
};

get(1504) ->
	#bo_ai{
		no = 1504,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 31},
		condition_list = [104]
};

get(1505) ->
	#bo_ai{
		no = 1505,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 31},
		condition_list = [104]
};

get(1506) ->
	#bo_ai{
		no = 1506,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 31},
		condition_list = [104]
};

get(1507) ->
	#bo_ai{
		no = 1507,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 31},
		condition_list = [104]
};

get(1508) ->
	#bo_ai{
		no = 1508,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 31},
		condition_list = [104]
};

get(1509) ->
	#bo_ai{
		no = 1509,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 31},
		condition_list = [104]
};

get(1510) ->
	#bo_ai{
		no = 1510,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 31},
		condition_list = [104]
};

get(1511) ->
	#bo_ai{
		no = 1511,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 32},
		condition_list = [105,113]
};

get(1512) ->
	#bo_ai{
		no = 1512,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 32},
		condition_list = [105,113]
};

get(1513) ->
	#bo_ai{
		no = 1513,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 32},
		condition_list = [105,113]
};

get(1514) ->
	#bo_ai{
		no = 1514,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 32},
		condition_list = [105,113]
};

get(1515) ->
	#bo_ai{
		no = 1515,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 32},
		condition_list = [105,113]
};

get(1516) ->
	#bo_ai{
		no = 1516,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 32},
		condition_list = [105,113]
};

get(1517) ->
	#bo_ai{
		no = 1517,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 32},
		condition_list = [105,113]
};

get(1518) ->
	#bo_ai{
		no = 1518,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 32},
		condition_list = [105,113]
};

get(1519) ->
	#bo_ai{
		no = 1519,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 32},
		condition_list = [105,113]
};

get(1520) ->
	#bo_ai{
		no = 1520,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 32},
		condition_list = [105,113]
};

get(1521) ->
	#bo_ai{
		no = 1521,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 33},
		condition_list = [106,115,117]
};

get(1522) ->
	#bo_ai{
		no = 1522,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 33},
		condition_list = [106,115,117]
};

get(1523) ->
	#bo_ai{
		no = 1523,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 33},
		condition_list = [106,115,117]
};

get(1524) ->
	#bo_ai{
		no = 1524,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 33},
		condition_list = [106,115,117]
};

get(1525) ->
	#bo_ai{
		no = 1525,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 33},
		condition_list = [106,115,117]
};

get(1526) ->
	#bo_ai{
		no = 1526,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 33},
		condition_list = [106,115,117]
};

get(1527) ->
	#bo_ai{
		no = 1527,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 33},
		condition_list = [106,115,117]
};

get(1528) ->
	#bo_ai{
		no = 1528,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 33},
		condition_list = [106,115,117]
};

get(1529) ->
	#bo_ai{
		no = 1529,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 33},
		condition_list = [106,115,117]
};

get(1530) ->
	#bo_ai{
		no = 1530,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 33},
		condition_list = [106,115,117]
};

get(1531) ->
	#bo_ai{
		no = 1531,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 34},
		condition_list = [106,117]
};

get(1532) ->
	#bo_ai{
		no = 1532,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 34},
		condition_list = [106,117]
};

get(1533) ->
	#bo_ai{
		no = 1533,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 34},
		condition_list = [106,117]
};

get(1534) ->
	#bo_ai{
		no = 1534,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 34},
		condition_list = [106,117]
};

get(1535) ->
	#bo_ai{
		no = 1535,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 34},
		condition_list = [106,117]
};

get(1536) ->
	#bo_ai{
		no = 1536,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 34},
		condition_list = [106,117]
};

get(1537) ->
	#bo_ai{
		no = 1537,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 34},
		condition_list = [106,117]
};

get(1538) ->
	#bo_ai{
		no = 1538,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 34},
		condition_list = [106,117]
};

get(1539) ->
	#bo_ai{
		no = 1539,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 34},
		condition_list = [106,117]
};

get(1540) ->
	#bo_ai{
		no = 1540,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 34},
		condition_list = [106,117]
};

get(1541) ->
	#bo_ai{
		no = 1541,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 35},
		condition_list = [108]
};

get(1542) ->
	#bo_ai{
		no = 1542,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 35},
		condition_list = [108]
};

get(1543) ->
	#bo_ai{
		no = 1543,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 35},
		condition_list = [108]
};

get(1544) ->
	#bo_ai{
		no = 1544,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 35},
		condition_list = [108]
};

get(1545) ->
	#bo_ai{
		no = 1545,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 35},
		condition_list = [108]
};

get(1546) ->
	#bo_ai{
		no = 1546,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 35},
		condition_list = [108]
};

get(1547) ->
	#bo_ai{
		no = 1547,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 35},
		condition_list = [108]
};

get(1548) ->
	#bo_ai{
		no = 1548,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 35},
		condition_list = [108]
};

get(1549) ->
	#bo_ai{
		no = 1549,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 35},
		condition_list = [108]
};

get(1550) ->
	#bo_ai{
		no = 1550,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 35},
		condition_list = [108]
};

get(1551) ->
	#bo_ai{
		no = 1551,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 36},
		condition_list = [109,117]
};

get(1552) ->
	#bo_ai{
		no = 1552,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 36},
		condition_list = [109,117]
};

get(1553) ->
	#bo_ai{
		no = 1553,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 36},
		condition_list = [109,117]
};

get(1554) ->
	#bo_ai{
		no = 1554,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 36},
		condition_list = [109,117]
};

get(1555) ->
	#bo_ai{
		no = 1555,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 36},
		condition_list = [109,117]
};

get(1556) ->
	#bo_ai{
		no = 1556,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 36},
		condition_list = [109,117]
};

get(1557) ->
	#bo_ai{
		no = 1557,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 36},
		condition_list = [109,117]
};

get(1558) ->
	#bo_ai{
		no = 1558,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 36},
		condition_list = [109,117]
};

get(1559) ->
	#bo_ai{
		no = 1559,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 36},
		condition_list = [109,117]
};

get(1560) ->
	#bo_ai{
		no = 1560,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill, 36},
		condition_list = [109,117]
};

get(1561) ->
	#bo_ai{
		no = 1561,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_player,{has_not_spec_no_buff, 44}],
		action_content = {use_skill, 37},
		condition_list = [110]
};

get(1562) ->
	#bo_ai{
		no = 1562,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_player,{has_not_spec_no_buff, 44}],
		action_content = {use_skill, 37},
		condition_list = [110]
};

get(1563) ->
	#bo_ai{
		no = 1563,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_player,{has_not_spec_no_buff, 44}],
		action_content = {use_skill, 37},
		condition_list = [110]
};

get(1564) ->
	#bo_ai{
		no = 1564,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_player,{has_not_spec_no_buff, 44}],
		action_content = {use_skill, 37},
		condition_list = [110]
};

get(1565) ->
	#bo_ai{
		no = 1565,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_player,{has_not_spec_no_buff, 44}],
		action_content = {use_skill, 37},
		condition_list = [110]
};

get(1566) ->
	#bo_ai{
		no = 1566,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_player,{has_not_spec_no_buff, 44}],
		action_content = {use_skill, 37},
		condition_list = [110]
};

get(1567) ->
	#bo_ai{
		no = 1567,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_player,{has_not_spec_no_buff, 44}],
		action_content = {use_skill, 37},
		condition_list = [110]
};

get(1568) ->
	#bo_ai{
		no = 1568,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_player,{has_not_spec_no_buff, 44}],
		action_content = {use_skill, 37},
		condition_list = [110]
};

get(1569) ->
	#bo_ai{
		no = 1569,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_player,{has_not_spec_no_buff, 44}],
		action_content = {use_skill, 37},
		condition_list = [110]
};

get(1570) ->
	#bo_ai{
		no = 1570,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_player,{has_not_spec_no_buff, 44}],
		action_content = {use_skill, 37},
		condition_list = [110]
};

get(2001) ->
	#bo_ai{
		no = 2001,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10001},
		condition_list = [69]
};

get(2002) ->
	#bo_ai{
		no = 2002,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10001},
		condition_list = [69]
};

get(2003) ->
	#bo_ai{
		no = 2003,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10001},
		condition_list = [69]
};

get(2004) ->
	#bo_ai{
		no = 2004,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10001},
		condition_list = [69]
};

get(2005) ->
	#bo_ai{
		no = 2005,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10001},
		condition_list = [69]
};

get(2006) ->
	#bo_ai{
		no = 2006,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10001},
		condition_list = [69]
};

get(2007) ->
	#bo_ai{
		no = 2007,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10001},
		condition_list = [69]
};

get(2008) ->
	#bo_ai{
		no = 2008,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10001},
		condition_list = [69]
};

get(2009) ->
	#bo_ai{
		no = 2009,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10001},
		condition_list = [69]
};

get(2010) ->
	#bo_ai{
		no = 2010,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10001},
		condition_list = [69]
};

get(2011) ->
	#bo_ai{
		no = 2011,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10002},
		condition_list = [70]
};

get(2012) ->
	#bo_ai{
		no = 2012,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10002},
		condition_list = [70]
};

get(2013) ->
	#bo_ai{
		no = 2013,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10002},
		condition_list = [70]
};

get(2014) ->
	#bo_ai{
		no = 2014,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10002},
		condition_list = [70]
};

get(2015) ->
	#bo_ai{
		no = 2015,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10002},
		condition_list = [70]
};

get(2016) ->
	#bo_ai{
		no = 2016,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10002},
		condition_list = [70]
};

get(2017) ->
	#bo_ai{
		no = 2017,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10002},
		condition_list = [70]
};

get(2018) ->
	#bo_ai{
		no = 2018,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10002},
		condition_list = [70]
};

get(2019) ->
	#bo_ai{
		no = 2019,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10002},
		condition_list = [70]
};

get(2020) ->
	#bo_ai{
		no = 2020,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10002},
		condition_list = [70]
};

get(2021) ->
	#bo_ai{
		no = 2021,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10003},
		condition_list = [71]
};

get(2022) ->
	#bo_ai{
		no = 2022,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10003},
		condition_list = [71]
};

get(2023) ->
	#bo_ai{
		no = 2023,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10003},
		condition_list = [71]
};

get(2024) ->
	#bo_ai{
		no = 2024,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10003},
		condition_list = [71]
};

get(2025) ->
	#bo_ai{
		no = 2025,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10003},
		condition_list = [71]
};

get(2026) ->
	#bo_ai{
		no = 2026,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10003},
		condition_list = [71]
};

get(2027) ->
	#bo_ai{
		no = 2027,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10003},
		condition_list = [71]
};

get(2028) ->
	#bo_ai{
		no = 2028,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10003},
		condition_list = [71]
};

get(2029) ->
	#bo_ai{
		no = 2029,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10003},
		condition_list = [71]
};

get(2030) ->
	#bo_ai{
		no = 2030,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10003},
		condition_list = [71]
};

get(2031) ->
	#bo_ai{
		no = 2031,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10004},
		condition_list = [72]
};

get(2032) ->
	#bo_ai{
		no = 2032,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10004},
		condition_list = [72]
};

get(2033) ->
	#bo_ai{
		no = 2033,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10004},
		condition_list = [72]
};

get(2034) ->
	#bo_ai{
		no = 2034,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10004},
		condition_list = [72]
};

get(2035) ->
	#bo_ai{
		no = 2035,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10004},
		condition_list = [72]
};

get(2036) ->
	#bo_ai{
		no = 2036,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10004},
		condition_list = [72]
};

get(2037) ->
	#bo_ai{
		no = 2037,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10004},
		condition_list = [72]
};

get(2038) ->
	#bo_ai{
		no = 2038,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10004},
		condition_list = [72]
};

get(2039) ->
	#bo_ai{
		no = 2039,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10004},
		condition_list = [72]
};

get(2040) ->
	#bo_ai{
		no = 2040,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10004},
		condition_list = [72]
};

get(2041) ->
	#bo_ai{
		no = 2041,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10010},
		condition_list = [73]
};

get(2042) ->
	#bo_ai{
		no = 2042,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10010},
		condition_list = [73]
};

get(2043) ->
	#bo_ai{
		no = 2043,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10010},
		condition_list = [73]
};

get(2044) ->
	#bo_ai{
		no = 2044,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10010},
		condition_list = [73]
};

get(2045) ->
	#bo_ai{
		no = 2045,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10010},
		condition_list = [73]
};

get(2046) ->
	#bo_ai{
		no = 2046,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10010},
		condition_list = [73]
};

get(2047) ->
	#bo_ai{
		no = 2047,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10010},
		condition_list = [73]
};

get(2048) ->
	#bo_ai{
		no = 2048,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10010},
		condition_list = [73]
};

get(2049) ->
	#bo_ai{
		no = 2049,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10010},
		condition_list = [73]
};

get(2050) ->
	#bo_ai{
		no = 2050,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10010},
		condition_list = [73]
};

get(2051) ->
	#bo_ai{
		no = 2051,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10006},
		condition_list = [1002]
};

get(2052) ->
	#bo_ai{
		no = 2052,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10006},
		condition_list = [1002]
};

get(2053) ->
	#bo_ai{
		no = 2053,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10006},
		condition_list = [1002]
};

get(2054) ->
	#bo_ai{
		no = 2054,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10006},
		condition_list = [1002]
};

get(2055) ->
	#bo_ai{
		no = 2055,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10006},
		condition_list = [1002]
};

get(2056) ->
	#bo_ai{
		no = 2056,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10006},
		condition_list = [1002]
};

get(2057) ->
	#bo_ai{
		no = 2057,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10006},
		condition_list = [1002]
};

get(2058) ->
	#bo_ai{
		no = 2058,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10006},
		condition_list = [1002]
};

get(2059) ->
	#bo_ai{
		no = 2059,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10006},
		condition_list = [1002]
};

get(2060) ->
	#bo_ai{
		no = 2060,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10006},
		condition_list = [1002]
};

get(2061) ->
	#bo_ai{
		no = 2061,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10007},
		condition_list = [1003]
};

get(2062) ->
	#bo_ai{
		no = 2062,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10007},
		condition_list = [1003]
};

get(2063) ->
	#bo_ai{
		no = 2063,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10007},
		condition_list = [1003]
};

get(2064) ->
	#bo_ai{
		no = 2064,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10007},
		condition_list = [1003]
};

get(2065) ->
	#bo_ai{
		no = 2065,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10007},
		condition_list = [1003]
};

get(2066) ->
	#bo_ai{
		no = 2066,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10007},
		condition_list = [1003]
};

get(2067) ->
	#bo_ai{
		no = 2067,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10007},
		condition_list = [1003]
};

get(2068) ->
	#bo_ai{
		no = 2068,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10007},
		condition_list = [1003]
};

get(2069) ->
	#bo_ai{
		no = 2069,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10007},
		condition_list = [1003]
};

get(2070) ->
	#bo_ai{
		no = 2070,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10007},
		condition_list = [1003]
};

get(2071) ->
	#bo_ai{
		no = 2071,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill,10012},
		condition_list = [1005]
};

get(2072) ->
	#bo_ai{
		no = 2072,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill,10012},
		condition_list = [1005]
};

get(2073) ->
	#bo_ai{
		no = 2073,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill,10012},
		condition_list = [1005]
};

get(2074) ->
	#bo_ai{
		no = 2074,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill,10012},
		condition_list = [1005]
};

get(2075) ->
	#bo_ai{
		no = 2075,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill,10012},
		condition_list = [1005]
};

get(2076) ->
	#bo_ai{
		no = 2076,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill,10012},
		condition_list = [1005]
};

get(2077) ->
	#bo_ai{
		no = 2077,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill,10012},
		condition_list = [1005]
};

get(2078) ->
	#bo_ai{
		no = 2078,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill,10012},
		condition_list = [1005]
};

get(2079) ->
	#bo_ai{
		no = 2079,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill,10012},
		condition_list = [1005]
};

get(2080) ->
	#bo_ai{
		no = 2080,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill,10012},
		condition_list = [1005]
};

get(2081) ->
	#bo_ai{
		no = 2081,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill,10013},
		condition_list = [1006]
};

get(2082) ->
	#bo_ai{
		no = 2082,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill,10013},
		condition_list = [1006]
};

get(2083) ->
	#bo_ai{
		no = 2083,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill,10013},
		condition_list = [1006]
};

get(2084) ->
	#bo_ai{
		no = 2084,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill,10013},
		condition_list = [1006]
};

get(2085) ->
	#bo_ai{
		no = 2085,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill,10013},
		condition_list = [1006]
};

get(2086) ->
	#bo_ai{
		no = 2086,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill,10013},
		condition_list = [1006]
};

get(2087) ->
	#bo_ai{
		no = 2087,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill,10013},
		condition_list = [1006]
};

get(2088) ->
	#bo_ai{
		no = 2088,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill,10013},
		condition_list = [1006]
};

get(2089) ->
	#bo_ai{
		no = 2089,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill,10013},
		condition_list = [1006]
};

get(2090) ->
	#bo_ai{
		no = 2090,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill,10013},
		condition_list = [1006]
};

get(2091) ->
	#bo_ai{
		no = 2091,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,10005},
		condition_list = [1001]
};

get(2092) ->
	#bo_ai{
		no = 2092,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,10005},
		condition_list = [1001]
};

get(2093) ->
	#bo_ai{
		no = 2093,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,10005},
		condition_list = [1002]
};

get(2094) ->
	#bo_ai{
		no = 2094,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,10005},
		condition_list = [1002]
};

get(2095) ->
	#bo_ai{
		no = 2095,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,10005},
		condition_list = [1003]
};

get(2096) ->
	#bo_ai{
		no = 2096,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,10005},
		condition_list = [1003]
};

get(2097) ->
	#bo_ai{
		no = 2097,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,10005},
		condition_list = [1004]
};

get(2098) ->
	#bo_ai{
		no = 2098,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,10005},
		condition_list = [1004]
};

get(2099) ->
	#bo_ai{
		no = 2099,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,10005},
		condition_list = [1005]
};

get(2100) ->
	#bo_ai{
		no = 2100,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,10005},
		condition_list = [1005]
};

get(2101) ->
	#bo_ai{
		no = 2101,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10014},
		condition_list = [1013]
};

get(2102) ->
	#bo_ai{
		no = 2102,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10014},
		condition_list = [1013]
};

get(2103) ->
	#bo_ai{
		no = 2103,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10014},
		condition_list = [1013]
};

get(2104) ->
	#bo_ai{
		no = 2104,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10014},
		condition_list = [1013]
};

get(2105) ->
	#bo_ai{
		no = 2105,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10014},
		condition_list = [1013]
};

get(2106) ->
	#bo_ai{
		no = 2106,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10014},
		condition_list = [1013]
};

get(2107) ->
	#bo_ai{
		no = 2107,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10014},
		condition_list = [1013]
};

get(2108) ->
	#bo_ai{
		no = 2108,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10014},
		condition_list = [1013]
};

get(2109) ->
	#bo_ai{
		no = 2109,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10014},
		condition_list = [1013]
};

get(2110) ->
	#bo_ai{
		no = 2110,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10014},
		condition_list = [1013]
};

get(2111) ->
	#bo_ai{
		no = 2111,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10020},
		condition_list = [1014]
};

get(2112) ->
	#bo_ai{
		no = 2112,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10020},
		condition_list = [1014]
};

get(2113) ->
	#bo_ai{
		no = 2113,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10020},
		condition_list = [1014]
};

get(2114) ->
	#bo_ai{
		no = 2114,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10020},
		condition_list = [1014]
};

get(2115) ->
	#bo_ai{
		no = 2115,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10020},
		condition_list = [1014]
};

get(2116) ->
	#bo_ai{
		no = 2116,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10020},
		condition_list = [1014]
};

get(2117) ->
	#bo_ai{
		no = 2117,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10020},
		condition_list = [1014]
};

get(2118) ->
	#bo_ai{
		no = 2118,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10020},
		condition_list = [1014]
};

get(2119) ->
	#bo_ai{
		no = 2119,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10020},
		condition_list = [1014]
};

get(2120) ->
	#bo_ai{
		no = 2120,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10020},
		condition_list = [1014]
};

get(2121) ->
	#bo_ai{
		no = 2121,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10022},
		condition_list = [1015]
};

get(2122) ->
	#bo_ai{
		no = 2122,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10022},
		condition_list = [1015]
};

get(2123) ->
	#bo_ai{
		no = 2123,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10022},
		condition_list = [1015]
};

get(2124) ->
	#bo_ai{
		no = 2124,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10022},
		condition_list = [1015]
};

get(2125) ->
	#bo_ai{
		no = 2125,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10022},
		condition_list = [1015]
};

get(2126) ->
	#bo_ai{
		no = 2126,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10022},
		condition_list = [1015]
};

get(2127) ->
	#bo_ai{
		no = 2127,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10022},
		condition_list = [1015]
};

get(2128) ->
	#bo_ai{
		no = 2128,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10022},
		condition_list = [1015]
};

get(2129) ->
	#bo_ai{
		no = 2129,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10022},
		condition_list = [1015]
};

get(2130) ->
	#bo_ai{
		no = 2130,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10022},
		condition_list = [1015]
};

get(2131) ->
	#bo_ai{
		no = 2131,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_player, {has_not_spec_no_buff, 1021}],
		action_content = {use_skill, 10023},
		condition_list = [123,1016]
};

get(2132) ->
	#bo_ai{
		no = 2132,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_player, {has_not_spec_no_buff, 1021}],
		action_content = {use_skill, 10023},
		condition_list = [123,1016]
};

get(2133) ->
	#bo_ai{
		no = 2133,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_player, {has_not_spec_no_buff, 1021}],
		action_content = {use_skill, 10023},
		condition_list = [123,1016]
};

get(2134) ->
	#bo_ai{
		no = 2134,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_player, {has_not_spec_no_buff, 1021}],
		action_content = {use_skill, 10023},
		condition_list = [123,1016]
};

get(2135) ->
	#bo_ai{
		no = 2135,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_player, {has_not_spec_no_buff, 1021}],
		action_content = {use_skill, 10023},
		condition_list = [123,1016]
};

get(2136) ->
	#bo_ai{
		no = 2136,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_player, {has_not_spec_no_buff, 1021}],
		action_content = {use_skill, 10023},
		condition_list = [123,1016]
};

get(2137) ->
	#bo_ai{
		no = 2137,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_player, {has_not_spec_no_buff, 1021}],
		action_content = {use_skill, 10023},
		condition_list = [123,1016]
};

get(2138) ->
	#bo_ai{
		no = 2138,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_player, {has_not_spec_no_buff, 1021}],
		action_content = {use_skill, 10023},
		condition_list = [123,1016]
};

get(2139) ->
	#bo_ai{
		no = 2139,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_player, {has_not_spec_no_buff, 1021}],
		action_content = {use_skill, 10023},
		condition_list = [123,1016]
};

get(2140) ->
	#bo_ai{
		no = 2140,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_player, {has_not_spec_no_buff, 1021}],
		action_content = {use_skill, 10023},
		condition_list = [123,1016]
};

get(2141) ->
	#bo_ai{
		no = 2141,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10024},
		condition_list = [1017]
};

get(2142) ->
	#bo_ai{
		no = 2142,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10024},
		condition_list = [1017]
};

get(2143) ->
	#bo_ai{
		no = 2143,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10024},
		condition_list = [1017]
};

get(2144) ->
	#bo_ai{
		no = 2144,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10024},
		condition_list = [1017]
};

get(2145) ->
	#bo_ai{
		no = 2145,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10024},
		condition_list = [1017]
};

get(2146) ->
	#bo_ai{
		no = 2146,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10024},
		condition_list = [1017]
};

get(2147) ->
	#bo_ai{
		no = 2147,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10024},
		condition_list = [1017]
};

get(2148) ->
	#bo_ai{
		no = 2148,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10024},
		condition_list = [1017]
};

get(2149) ->
	#bo_ai{
		no = 2149,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10024},
		condition_list = [1017]
};

get(2150) ->
	#bo_ai{
		no = 2150,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10024},
		condition_list = [1017]
};

get(2151) ->
	#bo_ai{
		no = 2151,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10025},
		condition_list = [1018]
};

get(2152) ->
	#bo_ai{
		no = 2152,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10025},
		condition_list = [1018]
};

get(2153) ->
	#bo_ai{
		no = 2153,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10025},
		condition_list = [1018]
};

get(2154) ->
	#bo_ai{
		no = 2154,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10025},
		condition_list = [1018]
};

get(2155) ->
	#bo_ai{
		no = 2155,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10025},
		condition_list = [1018]
};

get(2156) ->
	#bo_ai{
		no = 2156,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10025},
		condition_list = [1018]
};

get(2157) ->
	#bo_ai{
		no = 2157,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10025},
		condition_list = [1018]
};

get(2158) ->
	#bo_ai{
		no = 2158,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10025},
		condition_list = [1018]
};

get(2159) ->
	#bo_ai{
		no = 2159,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10025},
		condition_list = [1018]
};

get(2160) ->
	#bo_ai{
		no = 2160,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10025},
		condition_list = [1018]
};

get(2161) ->
	#bo_ai{
		no = 2161,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [ally_side, undead, act_speed_highest],
		action_content = {use_skill, 10026},
		condition_list = [1019,1034]
};

get(2162) ->
	#bo_ai{
		no = 2162,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [ally_side, undead, act_speed_highest],
		action_content = {use_skill, 10026},
		condition_list = [1019,1034]
};

get(2163) ->
	#bo_ai{
		no = 2163,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [ally_side, undead, act_speed_highest],
		action_content = {use_skill, 10026},
		condition_list = [1019,1034]
};

get(2164) ->
	#bo_ai{
		no = 2164,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [ally_side, undead, act_speed_highest],
		action_content = {use_skill, 10026},
		condition_list = [1019,1034]
};

get(2165) ->
	#bo_ai{
		no = 2165,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [ally_side, undead, act_speed_highest],
		action_content = {use_skill, 10026},
		condition_list = [1019,1034]
};

get(2166) ->
	#bo_ai{
		no = 2166,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [ally_side, undead, act_speed_highest],
		action_content = {use_skill, 10026},
		condition_list = [1019,1034]
};

get(2167) ->
	#bo_ai{
		no = 2167,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [ally_side, undead, act_speed_highest],
		action_content = {use_skill, 10026},
		condition_list = [1019,1034]
};

get(2168) ->
	#bo_ai{
		no = 2168,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [ally_side, undead, act_speed_highest],
		action_content = {use_skill, 10026},
		condition_list = [1019,1034]
};

get(2169) ->
	#bo_ai{
		no = 2169,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [ally_side, undead, act_speed_highest],
		action_content = {use_skill, 10026},
		condition_list = [1019,1034]
};

get(2170) ->
	#bo_ai{
		no = 2170,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, act_speed_highest],
		action_content = {use_skill, 10026},
		condition_list = [1019,1034]
};

get(2171) ->
	#bo_ai{
		no = 2171,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [my_owner],
		action_content = {use_skill, 10027},
		condition_list = [1020,7]
};

get(2172) ->
	#bo_ai{
		no = 2172,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [my_owner],
		action_content = {use_skill, 10027},
		condition_list = [1020,7]
};

get(2173) ->
	#bo_ai{
		no = 2173,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [my_owner],
		action_content = {use_skill, 10027},
		condition_list = [1020,7]
};

get(2174) ->
	#bo_ai{
		no = 2174,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [my_owner],
		action_content = {use_skill, 10027},
		condition_list = [1020,7]
};

get(2175) ->
	#bo_ai{
		no = 2175,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [my_owner],
		action_content = {use_skill, 10027},
		condition_list = [1020,7]
};

get(2176) ->
	#bo_ai{
		no = 2176,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [my_owner],
		action_content = {use_skill, 10027},
		condition_list = [1020,7]
};

get(2177) ->
	#bo_ai{
		no = 2177,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [my_owner],
		action_content = {use_skill, 10027},
		condition_list = [1020,7]
};

get(2178) ->
	#bo_ai{
		no = 2178,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [my_owner],
		action_content = {use_skill, 10027},
		condition_list = [1020,7]
};

get(2179) ->
	#bo_ai{
		no = 2179,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [my_owner],
		action_content = {use_skill, 10027},
		condition_list = [1020,7]
};

get(2180) ->
	#bo_ai{
		no = 2180,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [my_owner],
		action_content = {use_skill, 10027},
		condition_list = [1020,7]
};

get(2181) ->
	#bo_ai{
		no = 2181,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10028},
		condition_list = [1021]
};

get(2182) ->
	#bo_ai{
		no = 2182,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10028},
		condition_list = [1021]
};

get(2183) ->
	#bo_ai{
		no = 2183,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10028},
		condition_list = [1021]
};

get(2184) ->
	#bo_ai{
		no = 2184,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10028},
		condition_list = [1021]
};

get(2185) ->
	#bo_ai{
		no = 2185,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10028},
		condition_list = [1021]
};

get(2186) ->
	#bo_ai{
		no = 2186,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10028},
		condition_list = [1021]
};

get(2187) ->
	#bo_ai{
		no = 2187,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10028},
		condition_list = [1021]
};

get(2188) ->
	#bo_ai{
		no = 2188,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10028},
		condition_list = [1021]
};

get(2189) ->
	#bo_ai{
		no = 2189,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10028},
		condition_list = [1021]
};

get(2190) ->
	#bo_ai{
		no = 2190,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side, is_not_frozen],
		action_content = {use_skill, 10028},
		condition_list = [1021]
};

get(2191) ->
	#bo_ai{
		no = 2191,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill, 10029},
		condition_list = [1022,1010]
};

get(2192) ->
	#bo_ai{
		no = 2192,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill, 10029},
		condition_list = [1022,1010]
};

get(2193) ->
	#bo_ai{
		no = 2193,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill, 10029},
		condition_list = [1022,1010]
};

get(2194) ->
	#bo_ai{
		no = 2194,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill, 10029},
		condition_list = [1022,1010]
};

get(2195) ->
	#bo_ai{
		no = 2195,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill, 10029},
		condition_list = [1022,1010]
};

get(2196) ->
	#bo_ai{
		no = 2196,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill, 10029},
		condition_list = [1022,1010]
};

get(2197) ->
	#bo_ai{
		no = 2197,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill, 10029},
		condition_list = [1022,1010]
};

get(2198) ->
	#bo_ai{
		no = 2198,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill, 10029},
		condition_list = [1022,1010]
};

get(2199) ->
	#bo_ai{
		no = 2199,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill, 10029},
		condition_list = [1022,1010]
};

get(2200) ->
	#bo_ai{
		no = 2200,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1005}],
		action_content = {use_skill, 10029},
		condition_list = [1022,1010]
};

get(2201) ->
	#bo_ai{
		no = 2201,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10030},
		condition_list = [1023]
};

get(2202) ->
	#bo_ai{
		no = 2202,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10030},
		condition_list = [1023]
};

get(2203) ->
	#bo_ai{
		no = 2203,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10030},
		condition_list = [1023]
};

get(2204) ->
	#bo_ai{
		no = 2204,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10030},
		condition_list = [1023]
};

get(2205) ->
	#bo_ai{
		no = 2205,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10030},
		condition_list = [1023]
};

get(2206) ->
	#bo_ai{
		no = 2206,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10030},
		condition_list = [1023]
};

get(2207) ->
	#bo_ai{
		no = 2207,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10030},
		condition_list = [1023]
};

get(2208) ->
	#bo_ai{
		no = 2208,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10030},
		condition_list = [1023]
};

get(2209) ->
	#bo_ai{
		no = 2209,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10030},
		condition_list = [1023]
};

get(2210) ->
	#bo_ai{
		no = 2210,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10030},
		condition_list = [1023]
};

get(2211) ->
	#bo_ai{
		no = 2211,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill, 10031},
		condition_list = [1024,1009]
};

get(2212) ->
	#bo_ai{
		no = 2212,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill, 10031},
		condition_list = [1024,1009]
};

get(2213) ->
	#bo_ai{
		no = 2213,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill, 10031},
		condition_list = [1024,1009]
};

get(2214) ->
	#bo_ai{
		no = 2214,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill, 10031},
		condition_list = [1024,1009]
};

get(2215) ->
	#bo_ai{
		no = 2215,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill, 10031},
		condition_list = [1024,1009]
};

get(2216) ->
	#bo_ai{
		no = 2216,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill, 10031},
		condition_list = [1024,1009]
};

get(2217) ->
	#bo_ai{
		no = 2217,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill, 10031},
		condition_list = [1024,1009]
};

get(2218) ->
	#bo_ai{
		no = 2218,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill, 10031},
		condition_list = [1024,1009]
};

get(2219) ->
	#bo_ai{
		no = 2219,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill, 10031},
		condition_list = [1024,1009]
};

get(2220) ->
	#bo_ai{
		no = 2220,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [ally_side,  undead, {has_not_spec_no_buff, 1003}],
		action_content = {use_skill, 10031},
		condition_list = [1024,1009]
};

get(2221) ->
	#bo_ai{
		no = 2221,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10032},
		condition_list = [1025]
};

get(2222) ->
	#bo_ai{
		no = 2222,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10032},
		condition_list = [1025]
};

get(2223) ->
	#bo_ai{
		no = 2223,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10032},
		condition_list = [1025]
};

get(2224) ->
	#bo_ai{
		no = 2224,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10032},
		condition_list = [1025]
};

get(2225) ->
	#bo_ai{
		no = 2225,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10032},
		condition_list = [1025]
};

get(2226) ->
	#bo_ai{
		no = 2226,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10032},
		condition_list = [1025]
};

get(2227) ->
	#bo_ai{
		no = 2227,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10032},
		condition_list = [1025]
};

get(2228) ->
	#bo_ai{
		no = 2228,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10032},
		condition_list = [1025]
};

get(2229) ->
	#bo_ai{
		no = 2229,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10032},
		condition_list = [1025]
};

get(2230) ->
	#bo_ai{
		no = 2230,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill,10032},
		condition_list = [1025]
};

get(2231) ->
	#bo_ai{
		no = 2231,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10033},
		condition_list = [1026]
};

get(2232) ->
	#bo_ai{
		no = 2232,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10033},
		condition_list = [1026]
};

get(2233) ->
	#bo_ai{
		no = 2233,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10033},
		condition_list = [1026]
};

get(2234) ->
	#bo_ai{
		no = 2234,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10033},
		condition_list = [1026]
};

get(2235) ->
	#bo_ai{
		no = 2235,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10033},
		condition_list = [1026]
};

get(2236) ->
	#bo_ai{
		no = 2236,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10033},
		condition_list = [1026]
};

get(2237) ->
	#bo_ai{
		no = 2237,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10033},
		condition_list = [1026]
};

get(2238) ->
	#bo_ai{
		no = 2238,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10033},
		condition_list = [1026]
};

get(2239) ->
	#bo_ai{
		no = 2239,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10033},
		condition_list = [1026]
};

get(2240) ->
	#bo_ai{
		no = 2240,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10033},
		condition_list = [1026]
};

get(2241) ->
	#bo_ai{
		no = 2241,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10034},
		condition_list = [1027]
};

get(2242) ->
	#bo_ai{
		no = 2242,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10034},
		condition_list = [1027]
};

get(2243) ->
	#bo_ai{
		no = 2243,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10034},
		condition_list = [1027]
};

get(2244) ->
	#bo_ai{
		no = 2244,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10034},
		condition_list = [1027]
};

get(2245) ->
	#bo_ai{
		no = 2245,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10034},
		condition_list = [1027]
};

get(2246) ->
	#bo_ai{
		no = 2246,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10034},
		condition_list = [1027]
};

get(2247) ->
	#bo_ai{
		no = 2247,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10034},
		condition_list = [1027]
};

get(2248) ->
	#bo_ai{
		no = 2248,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10034},
		condition_list = [1027]
};

get(2249) ->
	#bo_ai{
		no = 2249,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10034},
		condition_list = [1027]
};

get(2250) ->
	#bo_ai{
		no = 2250,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10034},
		condition_list = [1027]
};

get(2251) ->
	#bo_ai{
		no = 2251,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10035},
		condition_list = [1028]
};

get(2252) ->
	#bo_ai{
		no = 2252,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10035},
		condition_list = [1028]
};

get(2253) ->
	#bo_ai{
		no = 2253,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10035},
		condition_list = [1028]
};

get(2254) ->
	#bo_ai{
		no = 2254,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10035},
		condition_list = [1028]
};

get(2255) ->
	#bo_ai{
		no = 2255,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10035},
		condition_list = [1028]
};

get(2256) ->
	#bo_ai{
		no = 2256,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10035},
		condition_list = [1028]
};

get(2257) ->
	#bo_ai{
		no = 2257,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10035},
		condition_list = [1028]
};

get(2258) ->
	#bo_ai{
		no = 2258,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10035},
		condition_list = [1028]
};

get(2259) ->
	#bo_ai{
		no = 2259,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10035},
		condition_list = [1028]
};

get(2260) ->
	#bo_ai{
		no = 2260,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 10035},
		condition_list = [1028]
};

get(2261) ->
	#bo_ai{
		no = 2261,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10036},
		condition_list = [1029]
};

get(2262) ->
	#bo_ai{
		no = 2262,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10036},
		condition_list = [1029]
};

get(2263) ->
	#bo_ai{
		no = 2263,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10036},
		condition_list = [1029]
};

get(2264) ->
	#bo_ai{
		no = 2264,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10036},
		condition_list = [1029]
};

get(2265) ->
	#bo_ai{
		no = 2265,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10036},
		condition_list = [1029]
};

get(2266) ->
	#bo_ai{
		no = 2266,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10036},
		condition_list = [1029]
};

get(2267) ->
	#bo_ai{
		no = 2267,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10036},
		condition_list = [1029]
};

get(2268) ->
	#bo_ai{
		no = 2268,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10036},
		condition_list = [1029]
};

get(2269) ->
	#bo_ai{
		no = 2269,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10036},
		condition_list = [1029]
};

get(2270) ->
	#bo_ai{
		no = 2270,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10036},
		condition_list = [1029]
};

get(2271) ->
	#bo_ai{
		no = 2271,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10037},
		condition_list = [1030]
};

get(2272) ->
	#bo_ai{
		no = 2272,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10037},
		condition_list = [1030]
};

get(2273) ->
	#bo_ai{
		no = 2273,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10037},
		condition_list = [1030]
};

get(2274) ->
	#bo_ai{
		no = 2274,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10037},
		condition_list = [1030]
};

get(2275) ->
	#bo_ai{
		no = 2275,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10037},
		condition_list = [1030]
};

get(2276) ->
	#bo_ai{
		no = 2276,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10037},
		condition_list = [1030]
};

get(2277) ->
	#bo_ai{
		no = 2277,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10037},
		condition_list = [1030]
};

get(2278) ->
	#bo_ai{
		no = 2278,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10037},
		condition_list = [1030]
};

get(2279) ->
	#bo_ai{
		no = 2279,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10037},
		condition_list = [1030]
};

get(2280) ->
	#bo_ai{
		no = 2280,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10037},
		condition_list = [1030]
};

get(2281) ->
	#bo_ai{
		no = 2281,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10038},
		condition_list = [1031]
};

get(2282) ->
	#bo_ai{
		no = 2282,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10038},
		condition_list = [1031]
};

get(2283) ->
	#bo_ai{
		no = 2283,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10038},
		condition_list = [1031]
};

get(2284) ->
	#bo_ai{
		no = 2284,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10038},
		condition_list = [1031]
};

get(2285) ->
	#bo_ai{
		no = 2285,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10038},
		condition_list = [1031]
};

get(2286) ->
	#bo_ai{
		no = 2286,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10038},
		condition_list = [1031]
};

get(2287) ->
	#bo_ai{
		no = 2287,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10038},
		condition_list = [1031]
};

get(2288) ->
	#bo_ai{
		no = 2288,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10038},
		condition_list = [1031]
};

get(2289) ->
	#bo_ai{
		no = 2289,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10038},
		condition_list = [1031]
};

get(2290) ->
	#bo_ai{
		no = 2290,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10038},
		condition_list = [1031]
};

get(2291) ->
	#bo_ai{
		no = 2291,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10039},
		condition_list = [1032]
};

get(2292) ->
	#bo_ai{
		no = 2292,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10039},
		condition_list = [1032]
};

get(2293) ->
	#bo_ai{
		no = 2293,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10039},
		condition_list = [1032]
};

get(2294) ->
	#bo_ai{
		no = 2294,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10039},
		condition_list = [1032]
};

get(2295) ->
	#bo_ai{
		no = 2295,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10039},
		condition_list = [1032]
};

get(2296) ->
	#bo_ai{
		no = 2296,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10039},
		condition_list = [1032]
};

get(2297) ->
	#bo_ai{
		no = 2297,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10039},
		condition_list = [1032]
};

get(2298) ->
	#bo_ai{
		no = 2298,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10039},
		condition_list = [1032]
};

get(2299) ->
	#bo_ai{
		no = 2299,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10039},
		condition_list = [1032]
};

get(2300) ->
	#bo_ai{
		no = 2300,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10039},
		condition_list = [1032]
};

get(2301) ->
	#bo_ai{
		no = 2301,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 10040},
		condition_list = [1033]
};

get(2302) ->
	#bo_ai{
		no = 2302,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 10040},
		condition_list = [1033]
};

get(2303) ->
	#bo_ai{
		no = 2303,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 10040},
		condition_list = [1033]
};

get(2304) ->
	#bo_ai{
		no = 2304,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 10040},
		condition_list = [1033]
};

get(2305) ->
	#bo_ai{
		no = 2305,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 10040},
		condition_list = [1033]
};

get(2306) ->
	#bo_ai{
		no = 2306,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 10040},
		condition_list = [1033]
};

get(2307) ->
	#bo_ai{
		no = 2307,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 10040},
		condition_list = [1033]
};

get(2308) ->
	#bo_ai{
		no = 2308,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 10040},
		condition_list = [1033]
};

get(2309) ->
	#bo_ai{
		no = 2309,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 10040},
		condition_list = [1033]
};

get(2310) ->
	#bo_ai{
		no = 2310,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 10040},
		condition_list = [1033]
};

get(2311) ->
	#bo_ai{
		no = 2311,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10011},
		condition_list = [1036]
};

get(2312) ->
	#bo_ai{
		no = 2312,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10011},
		condition_list = [1036]
};

get(2313) ->
	#bo_ai{
		no = 2313,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10011},
		condition_list = [1036]
};

get(2314) ->
	#bo_ai{
		no = 2314,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10011},
		condition_list = [1036]
};

get(2315) ->
	#bo_ai{
		no = 2315,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10011},
		condition_list = [1036]
};

get(2316) ->
	#bo_ai{
		no = 2316,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10011},
		condition_list = [1036]
};

get(2317) ->
	#bo_ai{
		no = 2317,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10011},
		condition_list = [1036]
};

get(2318) ->
	#bo_ai{
		no = 2318,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10011},
		condition_list = [1036]
};

get(2319) ->
	#bo_ai{
		no = 2319,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10011},
		condition_list = [1036]
};

get(2320) ->
	#bo_ai{
		no = 2320,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10011},
		condition_list = [1036]
};

get(2321) ->
	#bo_ai{
		no = 2321,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10041},
		condition_list = [1030]
};

get(2322) ->
	#bo_ai{
		no = 2322,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10041},
		condition_list = [1030]
};

get(2323) ->
	#bo_ai{
		no = 2323,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10041},
		condition_list = [1030]
};

get(2324) ->
	#bo_ai{
		no = 2324,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10041},
		condition_list = [1030]
};

get(2325) ->
	#bo_ai{
		no = 2325,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10041},
		condition_list = [1030]
};

get(2326) ->
	#bo_ai{
		no = 2326,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10041},
		condition_list = [1030]
};

get(2327) ->
	#bo_ai{
		no = 2327,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10041},
		condition_list = [1030]
};

get(2328) ->
	#bo_ai{
		no = 2328,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10041},
		condition_list = [1030]
};

get(2329) ->
	#bo_ai{
		no = 2329,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10041},
		condition_list = [1030]
};

get(2330) ->
	#bo_ai{
		no = 2330,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10041},
		condition_list = [1030]
};

get(2331) ->
	#bo_ai{
		no = 2331,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10042},
		condition_list = [1030]
};

get(2332) ->
	#bo_ai{
		no = 2332,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10042},
		condition_list = [1030]
};

get(2333) ->
	#bo_ai{
		no = 2333,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10042},
		condition_list = [1030]
};

get(2334) ->
	#bo_ai{
		no = 2334,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10042},
		condition_list = [1030]
};

get(2335) ->
	#bo_ai{
		no = 2335,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10042},
		condition_list = [1030]
};

get(2336) ->
	#bo_ai{
		no = 2336,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10042},
		condition_list = [1030]
};

get(2337) ->
	#bo_ai{
		no = 2337,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10042},
		condition_list = [1030]
};

get(2338) ->
	#bo_ai{
		no = 2338,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10042},
		condition_list = [1030]
};

get(2339) ->
	#bo_ai{
		no = 2339,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10042},
		condition_list = [1030]
};

get(2340) ->
	#bo_ai{
		no = 2340,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me,is_not_frozen],
		action_content = {use_skill, 10042},
		condition_list = [1030]
};

get(2341) ->
	#bo_ai{
		no = 2341,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10044},
		condition_list = [1042]
};

get(2342) ->
	#bo_ai{
		no = 2342,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10044},
		condition_list = [1042]
};

get(2343) ->
	#bo_ai{
		no = 2343,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10044},
		condition_list = [1042]
};

get(2344) ->
	#bo_ai{
		no = 2344,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10044},
		condition_list = [1042]
};

get(2345) ->
	#bo_ai{
		no = 2345,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10044},
		condition_list = [1042]
};

get(2346) ->
	#bo_ai{
		no = 2346,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10044},
		condition_list = [1042]
};

get(2347) ->
	#bo_ai{
		no = 2347,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10044},
		condition_list = [1042]
};

get(2348) ->
	#bo_ai{
		no = 2348,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10044},
		condition_list = [1042]
};

get(2349) ->
	#bo_ai{
		no = 2349,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10044},
		condition_list = [1042]
};

get(2350) ->
	#bo_ai{
		no = 2350,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 10044},
		condition_list = [1042]
};

get(2351) ->
	#bo_ai{
		no = 2351,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10045},
		condition_list = [1043]
};

get(2352) ->
	#bo_ai{
		no = 2352,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10045},
		condition_list = [1043]
};

get(2353) ->
	#bo_ai{
		no = 2353,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10045},
		condition_list = [1043]
};

get(2354) ->
	#bo_ai{
		no = 2354,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10045},
		condition_list = [1043]
};

get(2355) ->
	#bo_ai{
		no = 2355,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10045},
		condition_list = [1043]
};

get(2356) ->
	#bo_ai{
		no = 2356,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10045},
		condition_list = [1043]
};

get(2357) ->
	#bo_ai{
		no = 2357,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10045},
		condition_list = [1043]
};

get(2358) ->
	#bo_ai{
		no = 2358,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10045},
		condition_list = [1043]
};

get(2359) ->
	#bo_ai{
		no = 2359,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10045},
		condition_list = [1043]
};

get(2360) ->
	#bo_ai{
		no = 2360,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10045},
		condition_list = [1043]
};

get(2361) ->
	#bo_ai{
		no = 2361,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10046},
		condition_list = [1059]
};

get(2362) ->
	#bo_ai{
		no = 2362,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10046},
		condition_list = [1059]
};

get(2363) ->
	#bo_ai{
		no = 2363,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10046},
		condition_list = [1059]
};

get(2364) ->
	#bo_ai{
		no = 2364,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10046},
		condition_list = [1059]
};

get(2365) ->
	#bo_ai{
		no = 2365,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10046},
		condition_list = [1059]
};

get(2366) ->
	#bo_ai{
		no = 2366,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10046},
		condition_list = [1059]
};

get(2367) ->
	#bo_ai{
		no = 2367,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10046},
		condition_list = [1059]
};

get(2368) ->
	#bo_ai{
		no = 2368,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10046},
		condition_list = [1059]
};

get(2369) ->
	#bo_ai{
		no = 2369,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10046},
		condition_list = [1059]
};

get(2370) ->
	#bo_ai{
		no = 2370,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10046},
		condition_list = [1059]
};

get(2371) ->
	#bo_ai{
		no = 2371,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10047},
		condition_list = [1060]
};

get(2372) ->
	#bo_ai{
		no = 2372,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10047},
		condition_list = [1060]
};

get(2373) ->
	#bo_ai{
		no = 2373,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10047},
		condition_list = [1060]
};

get(2374) ->
	#bo_ai{
		no = 2374,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10047},
		condition_list = [1060]
};

get(2375) ->
	#bo_ai{
		no = 2375,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10047},
		condition_list = [1060]
};

get(2376) ->
	#bo_ai{
		no = 2376,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10047},
		condition_list = [1060]
};

get(2377) ->
	#bo_ai{
		no = 2377,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10047},
		condition_list = [1060]
};

get(2378) ->
	#bo_ai{
		no = 2378,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10047},
		condition_list = [1060]
};

get(2379) ->
	#bo_ai{
		no = 2379,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10047},
		condition_list = [1060]
};

get(2380) ->
	#bo_ai{
		no = 2380,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10047},
		condition_list = [1060]
};

get(2381) ->
	#bo_ai{
		no = 2381,
		priority = 100,
		weight = 10,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10048},
		condition_list = [1061]
};

get(2382) ->
	#bo_ai{
		no = 2382,
		priority = 100,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10048},
		condition_list = [1061]
};

get(2383) ->
	#bo_ai{
		no = 2383,
		priority = 100,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10048},
		condition_list = [1061]
};

get(2384) ->
	#bo_ai{
		no = 2384,
		priority = 100,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10048},
		condition_list = [1061]
};

get(2385) ->
	#bo_ai{
		no = 2385,
		priority = 100,
		weight = 50,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10048},
		condition_list = [1061]
};

get(2386) ->
	#bo_ai{
		no = 2386,
		priority = 100,
		weight = 60,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10048},
		condition_list = [1061]
};

get(2387) ->
	#bo_ai{
		no = 2387,
		priority = 100,
		weight = 70,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10048},
		condition_list = [1061]
};

get(2388) ->
	#bo_ai{
		no = 2388,
		priority = 100,
		weight = 80,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10048},
		condition_list = [1061]
};

get(2389) ->
	#bo_ai{
		no = 2389,
		priority = 100,
		weight = 90,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10048},
		condition_list = [1061]
};

get(2390) ->
	#bo_ai{
		no = 2390,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, phy_def_lowest],
		action_content = {use_skill, 10048},
		condition_list = [1061]
};

get(3001) ->
	#bo_ai{
		no = 3001,
		priority = 150,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		action_content = {use_skill, 62001},
		condition_list = [5001, 5002, 5005, 5101]
};

get(3002) ->
	#bo_ai{
		no = 3002,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		action_content = {use_skill, 62002},
		condition_list = [5001, 5003, 5005, 5102]
};

get(3003) ->
	#bo_ai{
		no = 3003,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		action_content = {use_skill, 62003},
		condition_list = [5001, 5004, 5005, 5103]
};

get(3004) ->
	#bo_ai{
		no = 3004,
		priority = 150,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		action_content = {use_skill, 62011},
		condition_list = [5006, 5007, 5010, 5104]
};

get(3005) ->
	#bo_ai{
		no = 3005,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		action_content = {use_skill, 62012},
		condition_list = [5006, 5008, 5010, 5105]
};

get(3006) ->
	#bo_ai{
		no = 3006,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		action_content = {use_skill, 62013},
		condition_list = [5006, 5009, 5010, 5106]
};

get(3007) ->
	#bo_ai{
		no = 3007,
		priority = 150,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_under_control,  cur_hp_highest],
		action_content = {use_skill, 62021},
		condition_list = [5011, 5107]
};

get(3008) ->
	#bo_ai{
		no = 3008,
		priority = 150,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_under_control,  cur_hp_highest],
		action_content = {use_skill, 62022},
		condition_list = [5011, 5108]
};

get(3009) ->
	#bo_ai{
		no = 3009,
		priority = 150,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_under_control,  cur_hp_highest],
		action_content = {use_skill, 62023},
		condition_list = [5011, 5109]
};

get(3010) ->
	#bo_ai{
		no = 3010,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_under_control,  cur_hp_highest],
		action_content = {use_skill, 62022},
		condition_list = [5012, 5108]
};

get(3011) ->
	#bo_ai{
		no = 3011,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_under_control,  cur_hp_highest],
		action_content = {use_skill, 62023},
		condition_list = [5012, 5109]
};

get(3012) ->
	#bo_ai{
		no = 3012,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_under_control,  cur_hp_highest],
		action_content = {use_skill, 62023},
		condition_list = [5013, 5109]
};

get(3013) ->
	#bo_ai{
		no = 3013,
		priority = 150,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, {has_not_spec_no_buff, 31}, {has_not_spec_no_buff, 46}, {has_not_spec_no_buff, 57}, {has_not_spec_no_buff, 58}, {has_not_spec_no_buff, 59}, {has_not_spec_no_buff, 1015}, {has_not_spec_no_buff, 1016}, {cur_hp_percentage_lower_than, 40}],
		action_content = {use_skill, 62031},
		condition_list = [5014, 5110]
};

get(3014) ->
	#bo_ai{
		no = 3014,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, {has_not_spec_no_buff, 31}, {has_not_spec_no_buff, 46}, {has_not_spec_no_buff, 57}, {has_not_spec_no_buff, 58}, {has_not_spec_no_buff, 59}, {has_not_spec_no_buff, 1015}, {has_not_spec_no_buff, 1016}, {cur_hp_percentage_lower_than, 40}],
		action_content = {use_skill, 62032},
		condition_list = [5014, 5111]
};

get(3015) ->
	#bo_ai{
		no = 3015,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, {has_not_spec_no_buff, 31}, {has_not_spec_no_buff, 46}, {has_not_spec_no_buff, 57}, {has_not_spec_no_buff, 58}, {has_not_spec_no_buff, 59}, {has_not_spec_no_buff, 1015}, {has_not_spec_no_buff, 1016}, {cur_hp_percentage_lower_than, 40}],
		action_content = {use_skill, 62033},
		condition_list = [5014, 5112]
};

get(3016) ->
	#bo_ai{
		no = 3016,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [ally_side, dead, is_player, {has_not_spec_no_buff, 44}, {has_not_spec_no_buff, 1013}, {has_not_spec_no_buff, 1014}],
		action_content = {use_skill, 62041},
		condition_list = [5015, 5113]
};

get(3017) ->
	#bo_ai{
		no = 3017,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [ally_side, dead, is_player, {has_not_spec_no_buff, 44}, {has_not_spec_no_buff, 1013}, {has_not_spec_no_buff, 1014}],
		action_content = {use_skill, 62042},
		condition_list = [5015, 5114]
};

get(3018) ->
	#bo_ai{
		no = 3018,
		priority = 180,
		weight = 100,
		rules_filter_action_target = [ally_side, dead, is_player, {has_not_spec_no_buff, 44}, {has_not_spec_no_buff, 1013}, {has_not_spec_no_buff, 1014}],
		action_content = {use_skill, 62043},
		condition_list = [5015, 5115]
};

get(3019) ->
	#bo_ai{
		no = 3019,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, is_under_control, is_not_cding, is_not_xuliing],
		action_content = {use_skill, 62062},
		condition_list = [5016, 5120]
};

get(3020) ->
	#bo_ai{
		no = 3020,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, is_under_control, is_not_cding, is_not_xuliing],
		action_content = {use_skill, 62063},
		condition_list = [5016, 5121]
};

get(3021) ->
	#bo_ai{
		no = 3021,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 62071},
		condition_list = [5017, 5122]
};

get(3022) ->
	#bo_ai{
		no = 3022,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 62072},
		condition_list = [5017, 5123]
};

get(3023) ->
	#bo_ai{
		no = 3023,
		priority = 180,
		weight = 100,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 62073},
		condition_list = [5017, 5124]
};

get(3024) ->
	#bo_ai{
		no = 3024,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 62071},
		condition_list = [5018, 5122]
};

get(3025) ->
	#bo_ai{
		no = 3025,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 62072},
		condition_list = [5018, 5123]
};

get(3026) ->
	#bo_ai{
		no = 3026,
		priority = 180,
		weight = 100,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 62073},
		condition_list = [5018, 5124]
};

get(3027) ->
	#bo_ai{
		no = 3027,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, phy_def_highest],
		action_content = {use_skill, 62081},
		condition_list = [5019, 5023, 5125]
};

get(3028) ->
	#bo_ai{
		no = 3028,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, mag_def_highest],
		action_content = {use_skill, 62081},
		condition_list = [5020, 5024, 5125]
};

get(3029) ->
	#bo_ai{
		no = 3029,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, {cur_hp_percentage_lower_than, 25}, cur_hp_lowest],
		action_content = {use_skill, 62081},
		condition_list = [5021, 5022, 5025, 5125]
};

get(3030) ->
	#bo_ai{
		no = 3030,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, phy_def_highest],
		action_content = {use_skill, 62082},
		condition_list = [5019, 5023, 5126]
};

get(3031) ->
	#bo_ai{
		no = 3031,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, mag_def_highest],
		action_content = {use_skill, 62082},
		condition_list = [5020, 5024, 5126]
};

get(3032) ->
	#bo_ai{
		no = 3032,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		action_content = {use_skill, 62082},
		condition_list = [5021, 5022, 5026, 5126]
};

get(3033) ->
	#bo_ai{
		no = 3033,
		priority = 180,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, phy_def_highest],
		action_content = {use_skill, 62083},
		condition_list = [5019, 5023, 5127]
};

get(3034) ->
	#bo_ai{
		no = 3034,
		priority = 180,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, mag_def_highest],
		action_content = {use_skill, 62083},
		condition_list = [5020, 5024, 5127]
};

get(3035) ->
	#bo_ai{
		no = 3035,
		priority = 180,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, {cur_hp_percentage_lower_than, 45}, cur_hp_lowest],
		action_content = {use_skill, 62083},
		condition_list = [5021, 5022, 5027, 5127]
};

get(3036) ->
	#bo_ai{
		no = 3036,
		priority = 150,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, {has_spec_eff_type_buff, bad}],
		action_content = {use_skill, 62091},
		condition_list = [5028, 5128]
};

get(3037) ->
	#bo_ai{
		no = 3037,
		priority = 150,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, {has_spec_eff_type_buff, bad}],
		action_content = {use_skill, 62092},
		condition_list = [5028, 5129]
};

get(3038) ->
	#bo_ai{
		no = 3038,
		priority = 150,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, {has_spec_eff_type_buff, bad}],
		action_content = {use_skill, 62093},
		condition_list = [5028, 5130]
};

get(3039) ->
	#bo_ai{
		no = 3039,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, is_under_control, is_not_cding, is_not_xuliing],
		action_content = {use_skill, 62092},
		condition_list = [5029, 5129]
};

get(3040) ->
	#bo_ai{
		no = 3040,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [ally_side, undead, is_under_control, is_not_cding, is_not_xuliing],
		action_content = {use_skill, 62092},
		condition_list = [5029, 5130]
};

get(3041) ->
	#bo_ai{
		no = 3041,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [enemy_side, is_partner, is_not_under_control, undead, {cur_hp_percentage_higher_than, 80}],
		action_content = {use_skill, 62101},
		condition_list = [5030, 5131]
};

get(3042) ->
	#bo_ai{
		no = 3042,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [enemy_side, is_partner, is_not_under_control, undead, {cur_hp_percentage_higher_than, 80}],
		action_content = {use_skill, 62102},
		condition_list = [5030, 5132]
};

get(3043) ->
	#bo_ai{
		no = 3043,
		priority = 180,
		weight = 100,
		rules_filter_action_target = [enemy_side, is_partner, is_not_under_control, undead, {cur_hp_percentage_higher_than, 60}],
		action_content = {use_skill, 62103},
		condition_list = [5031, 5133]
};

get(3044) ->
	#bo_ai{
		no = 3044,
		priority = 150,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_player, {cur_anger_higher_than, 60}],
		action_content = {use_skill, 62121},
		condition_list = [5032, 5137]
};

get(3045) ->
	#bo_ai{
		no = 3045,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_player, {cur_anger_higher_than, 60}],
		action_content = {use_skill, 62122},
		condition_list = [5032, 5138]
};

get(3046) ->
	#bo_ai{
		no = 3046,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_player, {cur_anger_higher_than, 60}],
		action_content = {use_skill, 62123},
		condition_list = [5032, 5139]
};

get(3047) ->
	#bo_ai{
		no = 3047,
		priority = 150,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, {belong_to_faction, 6}, cur_hp_lowest],
		action_content = {use_skill, 62131},
		condition_list = [5033, 5140]
};

get(3048) ->
	#bo_ai{
		no = 3048,
		priority = 160,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, {belong_to_faction, 6}, cur_hp_lowest],
		action_content = {use_skill, 62132},
		condition_list = [5033, 5141]
};

get(3049) ->
	#bo_ai{
		no = 3049,
		priority = 170,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, {belong_to_faction, 6}, cur_hp_lowest],
		action_content = {use_skill, 62133},
		condition_list = [5033, 5142]
};

get(20000) ->
	#bo_ai{
		no = 20000,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 10004},
		condition_list = [10026, 10000]
};

get(20001) ->
	#bo_ai{
		no = 20001,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 43},
		condition_list = [10027, 10026]
};

get(20002) ->
	#bo_ai{
		no = 20002,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 55},
		condition_list = [10028, 10029]
};

get(20003) ->
	#bo_ai{
		no = 20003,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, myself],
		action_content = {use_skill, 7},
		condition_list = [10028, 10031]
};

get(20004) ->
	#bo_ai{
		no = 20004,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, myself],
		action_content = {use_skill, 13},
		condition_list = [10028, 10025]
};

get(20005) ->
	#bo_ai{
		no = 20005,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 12},
		condition_list = [10034, 10024]
};

get(20006) ->
	#bo_ai{
		no = 20006,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 11},
		condition_list = [10036, 10016]
};

get(20007) ->
	#bo_ai{
		no = 20007,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, myself],
		action_content = {use_skill, 25},
		condition_list = [10028, 10043]
};

get(20008) ->
	#bo_ai{
		no = 20008,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, myself],
		action_content = {use_skill, 22},
		condition_list = [10039, 10015]
};

get(20009) ->
	#bo_ai{
		no = 20009,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side, is_player],
		action_content = {use_skill, 100000},
		condition_list = [20000]
};

get(20010) ->
	#bo_ai{
		no = 20010,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 31},
		condition_list = [10011, 10035]
};

get(20011) ->
	#bo_ai{
		no = 20011,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 31},
		condition_list = [10011, 10045]
};

get(20012) ->
	#bo_ai{
		no = 20012,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 31},
		condition_list = [10011, 10047]
};

get(20013) ->
	#bo_ai{
		no = 20013,
		priority = 40,
		weight = 100,
		rules_filter_action_target = [undead, myself],
		action_content = defend,
		condition_list = [10055]
};

get(20014) ->
	#bo_ai{
		no = 20014,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 10003},
		condition_list = [10005, 10065]
};

get(20015) ->
	#bo_ai{
		no = 20015,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, myself],
		action_content = {use_skill, 32},
		condition_list = [10063, 10010]
};

get(20016) ->
	#bo_ai{
		no = 20016,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 26},
		condition_list = [10014, 10045]
};

get(20017) ->
	#bo_ai{
		no = 20017,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 26},
		condition_list = [10014, 10047]
};

get(20018) ->
	#bo_ai{
		no = 20018,
		priority = 25,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 100001},
		condition_list = [20001]
};

get(20019) ->
	#bo_ai{
		no = 20019,
		priority = 26,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 100002},
		condition_list = [20006]
};

get(20020) ->
	#bo_ai{
		no = 20020,
		priority = 27,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 100003},
		condition_list = [20007]
};

get(20021) ->
	#bo_ai{
		no = 20021,
		priority = 28,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 100004},
		condition_list = [20008]
};

get(20022) ->
	#bo_ai{
		no = 20022,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 100005},
		condition_list = [20002]
};

get(20023) ->
	#bo_ai{
		no = 20023,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 100005},
		condition_list = [20004]
};

get(20024) ->
	#bo_ai{
		no = 20024,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side, cur_hp_highest],
		action_content = {use_skill, 100006},
		condition_list = [20003]
};

get(20025) ->
	#bo_ai{
		no = 20025,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side, cur_hp_highest],
		action_content = {use_skill, 100006},
		condition_list = [20005]
};

get(20050) ->
	#bo_ai{
		no = 20050,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = defend,
		condition_list = [10062]
};

get(20051) ->
	#bo_ai{
		no = 20051,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = defend,
		condition_list = [10063]
};

get(20052) ->
	#bo_ai{
		no = 20052,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = defend,
		condition_list = [10064]
};

get(20053) ->
	#bo_ai{
		no = 20053,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {escape, 1000},
		condition_list = [10065]
};

get(20054) ->
	#bo_ai{
		no = 20054,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = do_normal_att,
		condition_list = [10062]
};

get(20055) ->
	#bo_ai{
		no = 20055,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [is_partner, enemy_side, undead],
		action_content = do_normal_att,
		condition_list = [10063]
};

get(20056) ->
	#bo_ai{
		no = 20056,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [ally_side, undead],
		action_content = {use_skill, 55},
		condition_list = [10064]
};

get(20057) ->
	#bo_ai{
		no = 20057,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 41},
		condition_list = [10065]
};

get(20058) ->
	#bo_ai{
		no = 20058,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25001}],
		action_content = {use_skill, 100101},
		condition_list = [10065]
};

get(20101) ->
	#bo_ai{
		no = 20101,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, is_player],
		action_content = do_normal_att,
		condition_list = [100001]
};

get(20102) ->
	#bo_ai{
		no = 20102,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, is_player],
		action_content = {use_skill, 100103},
		condition_list = [100001]
};

get(20103) ->
	#bo_ai{
		no = 20103,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25005}],
		action_content = {use_skill, 100104},
		condition_list = [100002]
};

get(20104) ->
	#bo_ai{
		no = 20104,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25005}],
		action_content = do_normal_att,
		condition_list = [100002]
};

get(20105) ->
	#bo_ai{
		no = 20105,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, is_player],
		action_content = do_normal_att,
		condition_list = [100002]
};

get(20106) ->
	#bo_ai{
		no = 20106,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, is_player],
		action_content = {use_skill, 100105},
		condition_list = [100002]
};

get(20107) ->
	#bo_ai{
		no = 20107,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [is_player],
		action_content = {use_skill, 100106},
		condition_list = [100002]
};

get(20108) ->
	#bo_ai{
		no = 20108,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25001}],
		action_content = {use_skill, 100111},
		condition_list = [100002]
};

get(20109) ->
	#bo_ai{
		no = 20109,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25002}],
		action_content = {use_skill, 100111},
		condition_list = [100003]
};

get(20110) ->
	#bo_ai{
		no = 20110,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25006}],
		action_content = do_normal_att,
		condition_list = [100003]
};

get(20111) ->
	#bo_ai{
		no = 20111,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25007}],
		action_content = do_normal_att,
		condition_list = [100003]
};

get(20112) ->
	#bo_ai{
		no = 20112,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25002}],
		action_content = {use_skill, 100109},
		condition_list = [100003]
};

get(20113) ->
	#bo_ai{
		no = 20113,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25002}],
		action_content = {use_skill, 100108},
		condition_list = [100003]
};

get(20114) ->
	#bo_ai{
		no = 20114,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25001}],
		action_content = {use_skill, 100107},
		condition_list = [100003]
};

get(20115) ->
	#bo_ai{
		no = 20115,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {escape, 1000},
		condition_list = [100004]
};

get(20116) ->
	#bo_ai{
		no = 20116,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25005}],
		action_content = do_normal_att,
		condition_list = [100001]
};

get(20117) ->
	#bo_ai{
		no = 20117,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25005}],
		action_content = {use_skill, 100103},
		condition_list = [100001]
};

get(20118) ->
	#bo_ai{
		no = 20118,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25009}],
		action_content = {use_skill, 100104},
		condition_list = [100003]
};

get(20119) ->
	#bo_ai{
		no = 20119,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25007}],
		action_content = do_normal_att,
		condition_list = [100003]
};

get(20120) ->
	#bo_ai{
		no = 20120,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25008}],
		action_content = do_normal_att,
		condition_list = [100003]
};

get(20121) ->
	#bo_ai{
		no = 20121,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25001}],
		action_content = {use_skill, 100113},
		condition_list = [100003]
};

get(20122) ->
	#bo_ai{
		no = 20122,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, is_player],
		action_content = {use_skill, 100112},
		condition_list = [100003]
};

get(20123) ->
	#bo_ai{
		no = 20123,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [{mon_no_equal_to, 25002}],
		action_content = {use_skill, 100114},
		condition_list = [100003]
};

get(20124) ->
	#bo_ai{
		no = 20124,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {escape, 1000},
		condition_list = [100003]
};

get(20125) ->
	#bo_ai{
		no = 20125,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {escape, 1000},
		condition_list = [100003]
};

get(25001) ->
	#bo_ai{
		no = 25001,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 100200},
		condition_list = [10067]
};

get(25002) ->
	#bo_ai{
		no = 25002,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 100204},
		condition_list = [100001]
};

get(25003) ->
	#bo_ai{
		no = 25003,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 100202},
		condition_list = [100002]
};

get(25004) ->
	#bo_ai{
		no = 25004,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 100203},
		condition_list = [100003]
};

get(25005) ->
	#bo_ai{
		no = 25005,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 100206},
		condition_list = [100004]
};

get(25006) ->
	#bo_ai{
		no = 25006,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 100205},
		condition_list = [100005]
};

get(25007) ->
	#bo_ai{
		no = 25007,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [undead],
		action_content = {use_skill, 100201},
		condition_list = [100006]
};

get(25008) ->
	#bo_ai{
		no = 25008,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {escape, 1000},
		condition_list = [10100]
};

get(50001) ->
	#bo_ai{
		no = 50001,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50001},
		condition_list = [50001]
};

get(50002) ->
	#bo_ai{
		no = 50002,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50002},
		condition_list = [50002]
};

get(50003) ->
	#bo_ai{
		no = 50003,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50003},
		condition_list = [50003]
};

get(50004) ->
	#bo_ai{
		no = 50004,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50004},
		condition_list = [50004]
};

get(50005) ->
	#bo_ai{
		no = 50005,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50005},
		condition_list = [50005]
};

get(50006) ->
	#bo_ai{
		no = 50006,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50006},
		condition_list = [50006]
};

get(50007) ->
	#bo_ai{
		no = 50007,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50007},
		condition_list = [50007]
};

get(50008) ->
	#bo_ai{
		no = 50008,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50008},
		condition_list = [50008]
};

get(50009) ->
	#bo_ai{
		no = 50009,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50009},
		condition_list = [50009]
};

get(50010) ->
	#bo_ai{
		no = 50010,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50010},
		condition_list = [50010]
};

get(50011) ->
	#bo_ai{
		no = 50011,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50011},
		condition_list = [50011]
};

get(50012) ->
	#bo_ai{
		no = 50012,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50012},
		condition_list = [50012]
};

get(50013) ->
	#bo_ai{
		no = 50013,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50013},
		condition_list = [50013]
};

get(50014) ->
	#bo_ai{
		no = 50014,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50014},
		condition_list = [50014]
};

get(50015) ->
	#bo_ai{
		no = 50015,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50015},
		condition_list = [50015, 50059]
};

get(50016) ->
	#bo_ai{
		no = 50016,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50016},
		condition_list = [50016]
};

get(50017) ->
	#bo_ai{
		no = 50017,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50017},
		condition_list = [50017]
};

get(50018) ->
	#bo_ai{
		no = 50018,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50018},
		condition_list = [50018]
};

get(50019) ->
	#bo_ai{
		no = 50019,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50019},
		condition_list = [50019, 50054]
};

get(50020) ->
	#bo_ai{
		no = 50020,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50020},
		condition_list = [50020]
};

get(50021) ->
	#bo_ai{
		no = 50021,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50021},
		condition_list = [50021]
};

get(50022) ->
	#bo_ai{
		no = 50022,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50022},
		condition_list = [50022]
};

get(50023) ->
	#bo_ai{
		no = 50023,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50023},
		condition_list = [50023]
};

get(50024) ->
	#bo_ai{
		no = 50024,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50024},
		condition_list = [50024]
};

get(50025) ->
	#bo_ai{
		no = 50025,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 50025},
		condition_list = [50025, 50052]
};

get(50026) ->
	#bo_ai{
		no = 50026,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 50026},
		condition_list = [50026, 50051]
};

get(50027) ->
	#bo_ai{
		no = 50027,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50027},
		condition_list = [50027]
};

get(50028) ->
	#bo_ai{
		no = 50028,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50028},
		condition_list = [50028, 50060]
};

get(50029) ->
	#bo_ai{
		no = 50029,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50029},
		condition_list = [50029]
};

get(50030) ->
	#bo_ai{
		no = 50030,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 50030},
		condition_list = [50030, 50053]
};

get(50031) ->
	#bo_ai{
		no = 50031,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50031},
		condition_list = [50031]
};

get(50032) ->
	#bo_ai{
		no = 50032,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50032},
		condition_list = [50032]
};

get(50033) ->
	#bo_ai{
		no = 50033,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50033},
		condition_list = [50033]
};

get(50034) ->
	#bo_ai{
		no = 50034,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50034},
		condition_list = [50034, 50060]
};

get(50035) ->
	#bo_ai{
		no = 50035,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50035},
		condition_list = [50035, 50060]
};

get(50036) ->
	#bo_ai{
		no = 50036,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50036},
		condition_list = [50036, 50060]
};

get(50037) ->
	#bo_ai{
		no = 50037,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50037},
		condition_list = [50037]
};

get(50038) ->
	#bo_ai{
		no = 50038,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50038},
		condition_list = [50038, 50055]
};

get(50039) ->
	#bo_ai{
		no = 50039,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [ally_side],
		action_content = {use_skill, 50039},
		condition_list = [50039]
};

get(50040) ->
	#bo_ai{
		no = 50040,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50040},
		condition_list = [50040]
};

get(50041) ->
	#bo_ai{
		no = 50041,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50041},
		condition_list = [50041]
};

get(50042) ->
	#bo_ai{
		no = 50042,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50042},
		condition_list = [50042]
};

get(50043) ->
	#bo_ai{
		no = 50043,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50043},
		condition_list = [50043]
};

get(50044) ->
	#bo_ai{
		no = 50044,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50044},
		condition_list = [50044]
};

get(50080) ->
	#bo_ai{
		no = 50080,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50018},
		condition_list = [50018, 50056]
};

get(50081) ->
	#bo_ai{
		no = 50081,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50023},
		condition_list = [50023, 50056]
};

get(50101) ->
	#bo_ai{
		no = 50101,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50001},
		condition_list = [50001, 50057]
};

get(50102) ->
	#bo_ai{
		no = 50102,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50002},
		condition_list = [50002, 50058]
};

get(50103) ->
	#bo_ai{
		no = 50103,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50003},
		condition_list = [50003, 50057]
};

get(50104) ->
	#bo_ai{
		no = 50104,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50004},
		condition_list = [50004, 50058]
};

get(50105) ->
	#bo_ai{
		no = 50105,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50005},
		condition_list = [50005, 50057]
};

get(50106) ->
	#bo_ai{
		no = 50106,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50006},
		condition_list = [50006, 50058]
};

get(50107) ->
	#bo_ai{
		no = 50107,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50007},
		condition_list = [50007, 50057]
};

get(50108) ->
	#bo_ai{
		no = 50108,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50008},
		condition_list = [50008, 50058]
};

get(50109) ->
	#bo_ai{
		no = 50109,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50009},
		condition_list = [50009, 50057]
};

get(50110) ->
	#bo_ai{
		no = 50110,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50010},
		condition_list = [50010, 50058]
};

get(50111) ->
	#bo_ai{
		no = 50111,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50011},
		condition_list = [50011, 50057]
};

get(50112) ->
	#bo_ai{
		no = 50112,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50012},
		condition_list = [50012, 50058]
};

get(50113) ->
	#bo_ai{
		no = 50113,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50013},
		condition_list = [50013, 50057]
};

get(50114) ->
	#bo_ai{
		no = 50114,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50014},
		condition_list = [50014, 50058]
};

get(50115) ->
	#bo_ai{
		no = 50115,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50015},
		condition_list = [50015, 50059]
};

get(50116) ->
	#bo_ai{
		no = 50116,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50016},
		condition_list = [50016, 50058]
};

get(50117) ->
	#bo_ai{
		no = 50117,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50017},
		condition_list = [50017, 50057]
};

get(50118) ->
	#bo_ai{
		no = 50118,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50018},
		condition_list = [50018, 50058]
};

get(50119) ->
	#bo_ai{
		no = 50119,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50019},
		condition_list = [50019, 50054]
};

get(50120) ->
	#bo_ai{
		no = 50120,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50020},
		condition_list = [50020, 50058]
};

get(50121) ->
	#bo_ai{
		no = 50121,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50021},
		condition_list = [50021, 50057]
};

get(50122) ->
	#bo_ai{
		no = 50122,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50022},
		condition_list = [50022, 50058]
};

get(50123) ->
	#bo_ai{
		no = 50123,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50023},
		condition_list = [50023, 50057]
};

get(50124) ->
	#bo_ai{
		no = 50124,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50024},
		condition_list = [50024, 50058]
};

get(50125) ->
	#bo_ai{
		no = 50125,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 50025},
		condition_list = [50025, 50052]
};

get(50126) ->
	#bo_ai{
		no = 50126,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 50026},
		condition_list = [50026, 50051]
};

get(50127) ->
	#bo_ai{
		no = 50127,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50027},
		condition_list = [50027, 50057]
};

get(50128) ->
	#bo_ai{
		no = 50128,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50028},
		condition_list = [50028, 50058]
};

get(50129) ->
	#bo_ai{
		no = 50129,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50029},
		condition_list = [50029, 50057]
};

get(50130) ->
	#bo_ai{
		no = 50130,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 50030},
		condition_list = [50030, 50053]
};

get(50131) ->
	#bo_ai{
		no = 50131,
		priority = 1,
		weight = 30,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen, is_not_under_control],
		action_content = {use_skill, 50031},
		condition_list = [50031, 50057]
};

get(50201) ->
	#bo_ai{
		no = 50201,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50201},
		condition_list = [50201]
};

get(50202) ->
	#bo_ai{
		no = 50202,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50202},
		condition_list = [50202]
};

get(50203) ->
	#bo_ai{
		no = 50203,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50203},
		condition_list = [50203]
};

get(50211) ->
	#bo_ai{
		no = 50211,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50211},
		condition_list = [50211]
};

get(50212) ->
	#bo_ai{
		no = 50212,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50212},
		condition_list = [50212]
};

get(50213) ->
	#bo_ai{
		no = 50213,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50213},
		condition_list = [50213]
};

get(50221) ->
	#bo_ai{
		no = 50221,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50221},
		condition_list = [50221]
};

get(50222) ->
	#bo_ai{
		no = 50222,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50222},
		condition_list = [50222]
};

get(50223) ->
	#bo_ai{
		no = 50223,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50223},
		condition_list = [50223]
};

get(50224) ->
	#bo_ai{
		no = 50224,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50224},
		condition_list = [50224]
};

get(50225) ->
	#bo_ai{
		no = 50225,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50225},
		condition_list = [50225]
};

get(50226) ->
	#bo_ai{
		no = 50226,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50226},
		condition_list = [50226]
};

get(50231) ->
	#bo_ai{
		no = 50231,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50231},
		condition_list = [50231]
};

get(50232) ->
	#bo_ai{
		no = 50232,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50232},
		condition_list = [50232]
};

get(50233) ->
	#bo_ai{
		no = 50233,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50233},
		condition_list = [50233]
};

get(50234) ->
	#bo_ai{
		no = 50234,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50234},
		condition_list = [50234]
};

get(50241) ->
	#bo_ai{
		no = 50241,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50241},
		condition_list = [50241]
};

get(50242) ->
	#bo_ai{
		no = 50242,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50242},
		condition_list = [50242]
};

get(50243) ->
	#bo_ai{
		no = 50243,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50243},
		condition_list = [50243]
};

get(50244) ->
	#bo_ai{
		no = 50244,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50244},
		condition_list = [50244]
};

get(50251) ->
	#bo_ai{
		no = 50251,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50251},
		condition_list = [50251]
};

get(50252) ->
	#bo_ai{
		no = 50252,
		priority = 1,
		weight = 40,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50252},
		condition_list = [50252]
};

get(50253) ->
	#bo_ai{
		no = 50253,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50253},
		condition_list = [50253]
};

get(50254) ->
	#bo_ai{
		no = 50254,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 50254},
		condition_list = [50254]
};

get(50261) ->
	#bo_ai{
		no = 50261,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50261},
		condition_list = [50261]
};

get(50262) ->
	#bo_ai{
		no = 50262,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50262},
		condition_list = [50262]
};

get(50263) ->
	#bo_ai{
		no = 50263,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50263},
		condition_list = [50263]
};

get(50264) ->
	#bo_ai{
		no = 50264,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 50264},
		condition_list = [50264]
};

get(50265) ->
	#bo_ai{
		no = 50265,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50265},
		condition_list = [50265]
};

get(50266) ->
	#bo_ai{
		no = 50266,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50266},
		condition_list = [50266]
};

get(50267) ->
	#bo_ai{
		no = 50267,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50267},
		condition_list = [50267]
};

get(50268) ->
	#bo_ai{
		no = 50268,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 50268},
		condition_list = [50268]
};

get(50281) ->
	#bo_ai{
		no = 50281,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50281},
		condition_list = [50281]
};

get(50282) ->
	#bo_ai{
		no = 50282,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50282},
		condition_list = [50282]
};

get(50283) ->
	#bo_ai{
		no = 50283,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50283},
		condition_list = [50283]
};

get(50284) ->
	#bo_ai{
		no = 50284,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50284},
		condition_list = [50284, 50280]
};

get(50285) ->
	#bo_ai{
		no = 50285,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50285},
		condition_list = [50285]
};

get(50286) ->
	#bo_ai{
		no = 50286,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50286},
		condition_list = [50286]
};

get(50287) ->
	#bo_ai{
		no = 50287,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50287},
		condition_list = [50287]
};

get(50288) ->
	#bo_ai{
		no = 50288,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50288},
		condition_list = [50288]
};

get(50301) ->
	#bo_ai{
		no = 50301,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50301},
		condition_list = [50301]
};

get(50302) ->
	#bo_ai{
		no = 50302,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 50302},
		condition_list = [50302, 50300]
};

get(50303) ->
	#bo_ai{
		no = 50303,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50303},
		condition_list = [50303]
};

get(50304) ->
	#bo_ai{
		no = 50304,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50304},
		condition_list = [50304, 50309]
};

get(50305) ->
	#bo_ai{
		no = 50305,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50305},
		condition_list = [50305]
};

get(50306) ->
	#bo_ai{
		no = 50306,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50306},
		condition_list = [50306, 50300]
};

get(50307) ->
	#bo_ai{
		no = 50307,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50307},
		condition_list = [50307]
};

get(50308) ->
	#bo_ai{
		no = 50308,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 50308},
		condition_list = [50308]
};

get(50310) ->
	#bo_ai{
		no = 50310,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50310},
		condition_list = [50310, 50300]
};

get(50311) ->
	#bo_ai{
		no = 50311,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50311},
		condition_list = [50311]
};

get(50312) ->
	#bo_ai{
		no = 50312,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50312},
		condition_list = [50312, 50300]
};

get(50313) ->
	#bo_ai{
		no = 50313,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50313},
		condition_list = [50313]
};

get(50314) ->
	#bo_ai{
		no = 50314,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50314},
		condition_list = [50314, 50300]
};

get(50315) ->
	#bo_ai{
		no = 50315,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50315},
		condition_list = [50315]
};

get(50316) ->
	#bo_ai{
		no = 50316,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50316},
		condition_list = [50316, 50300]
};

get(50317) ->
	#bo_ai{
		no = 50317,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50317},
		condition_list = [50317]
};

get(50318) ->
	#bo_ai{
		no = 50318,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50318},
		condition_list = [50318, 50300]
};

get(50319) ->
	#bo_ai{
		no = 50319,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50319},
		condition_list = [50319]
};

get(50321) ->
	#bo_ai{
		no = 50321,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50321},
		condition_list = [50321]
};

get(50322) ->
	#bo_ai{
		no = 50322,
		priority = 5,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 50322},
		condition_list = [50322, 50329]
};

get(50323) ->
	#bo_ai{
		no = 50323,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50323},
		condition_list = [50323]
};

get(50324) ->
	#bo_ai{
		no = 50324,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50324},
		condition_list = [50324]
};

get(50325) ->
	#bo_ai{
		no = 50325,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50325},
		condition_list = [50325]
};

get(50326) ->
	#bo_ai{
		no = 50326,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 50326},
		condition_list = [50326]
};

get(50327) ->
	#bo_ai{
		no = 50327,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50327},
		condition_list = [50327]
};

get(50328) ->
	#bo_ai{
		no = 50328,
		priority = 5,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50328},
		condition_list = [50328, 50330]
};

get(50332) ->
	#bo_ai{
		no = 50332,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 50332},
		condition_list = [50332, 50331]
};

get(50333) ->
	#bo_ai{
		no = 50333,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50333},
		condition_list = [50333]
};

get(50334) ->
	#bo_ai{
		no = 50334,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50334},
		condition_list = [50334]
};

get(50335) ->
	#bo_ai{
		no = 50335,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 50335},
		condition_list = [50335]
};

get(50341) ->
	#bo_ai{
		no = 50341,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50341},
		condition_list = [50341]
};

get(50342) ->
	#bo_ai{
		no = 50342,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50342},
		condition_list = [50342, 50300]
};

get(50343) ->
	#bo_ai{
		no = 50343,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50343},
		condition_list = [50343]
};

get(50344) ->
	#bo_ai{
		no = 50344,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 50344},
		condition_list = [50344]
};

get(50345) ->
	#bo_ai{
		no = 50345,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50345},
		condition_list = [50345]
};

get(50346) ->
	#bo_ai{
		no = 50346,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50346},
		condition_list = [50346]
};

get(50347) ->
	#bo_ai{
		no = 50347,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50347},
		condition_list = [50347]
};

get(50348) ->
	#bo_ai{
		no = 50348,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50348},
		condition_list = [50348, 50300]
};

get(50361) ->
	#bo_ai{
		no = 50361,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50361},
		condition_list = [50361]
};

get(50362) ->
	#bo_ai{
		no = 50362,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50362},
		condition_list = [50362]
};

get(50363) ->
	#bo_ai{
		no = 50363,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50363},
		condition_list = [50363]
};

get(50364) ->
	#bo_ai{
		no = 50364,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 50364},
		condition_list = [50364]
};

get(50365) ->
	#bo_ai{
		no = 50365,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50365},
		condition_list = [50365]
};

get(50366) ->
	#bo_ai{
		no = 50366,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50366},
		condition_list = [50366]
};

get(50381) ->
	#bo_ai{
		no = 50381,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50381},
		condition_list = [50381]
};

get(50382) ->
	#bo_ai{
		no = 50382,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50382},
		condition_list = [50382]
};

get(50383) ->
	#bo_ai{
		no = 50383,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50383},
		condition_list = [50383]
};

get(50384) ->
	#bo_ai{
		no = 50384,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50384},
		condition_list = [50384]
};

get(50385) ->
	#bo_ai{
		no = 50385,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, ally_side],
		action_content = {use_skill, 50385},
		condition_list = [50385]
};

get(50386) ->
	#bo_ai{
		no = 50386,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50386},
		condition_list = [50386]
};

get(50401) ->
	#bo_ai{
		no = 50401,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50401},
		condition_list = [50401]
};

get(50402) ->
	#bo_ai{
		no = 50402,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50402},
		condition_list = [50402, 50300]
};

get(50403) ->
	#bo_ai{
		no = 50403,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50403},
		condition_list = [50403]
};

get(50404) ->
	#bo_ai{
		no = 50404,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50404},
		condition_list = [50404]
};

get(50405) ->
	#bo_ai{
		no = 50405,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50405},
		condition_list = [50405]
};

get(50406) ->
	#bo_ai{
		no = 50406,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 50406},
		condition_list = [50406]
};

get(50501) ->
	#bo_ai{
		no = 50501,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50501},
		condition_list = [50501]
};

get(50502) ->
	#bo_ai{
		no = 50502,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50502},
		condition_list = [50502]
};

get(50503) ->
	#bo_ai{
		no = 50503,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50503},
		condition_list = [50503, 50500]
};

get(50504) ->
	#bo_ai{
		no = 50504,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_use_skill, 5001},
		condition_list = [50500]
};

get(50511) ->
	#bo_ai{
		no = 50511,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50511},
		condition_list = [50511]
};

get(50512) ->
	#bo_ai{
		no = 50512,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50512},
		condition_list = [50512]
};

get(50513) ->
	#bo_ai{
		no = 50513,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50513},
		condition_list = [50513]
};

get(50521) ->
	#bo_ai{
		no = 50521,
		priority = 2,
		weight = 20,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 50521},
		condition_list = [50521, 50500]
};

get(50522) ->
	#bo_ai{
		no = 50522,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50522},
		condition_list = [50522]
};

get(50523) ->
	#bo_ai{
		no = 50523,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50523},
		condition_list = [50523]
};

get(50531) ->
	#bo_ai{
		no = 50531,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50531},
		condition_list = [50531]
};

get(50532) ->
	#bo_ai{
		no = 50532,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50532},
		condition_list = [50532]
};

get(50533) ->
	#bo_ai{
		no = 50533,
		priority = 1,
		weight = 20,
		rules_filter_action_target = [undead, not_invisible_to_me, enemy_side,is_not_frozen],
		action_content = {use_skill, 50533},
		condition_list = [50533]
};

get(100000) ->
	#bo_ai{
		no = 100000,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = do_normal_att,
		condition_list = []
};

get(100001) ->
	#bo_ai{
		no = 100001,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1001},
		condition_list = [100001]
};

get(100002) ->
	#bo_ai{
		no = 100002,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1002},
		condition_list = [100001]
};

get(100003) ->
	#bo_ai{
		no = 100003,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1003},
		condition_list = [100001]
};

get(100004) ->
	#bo_ai{
		no = 100004,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1004},
		condition_list = [100001]
};

get(100005) ->
	#bo_ai{
		no = 100005,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1005},
		condition_list = [100001]
};

get(100011) ->
	#bo_ai{
		no = 100011,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1011},
		condition_list = [100001]
};

get(100012) ->
	#bo_ai{
		no = 100012,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1012},
		condition_list = [100001]
};

get(100013) ->
	#bo_ai{
		no = 100013,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1013},
		condition_list = [100001]
};

get(100014) ->
	#bo_ai{
		no = 100014,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1014},
		condition_list = [100001]
};

get(100015) ->
	#bo_ai{
		no = 100015,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1015},
		condition_list = [100001]
};

get(100021) ->
	#bo_ai{
		no = 100021,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1021},
		condition_list = [100001]
};

get(100022) ->
	#bo_ai{
		no = 100022,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1022},
		condition_list = [100001]
};

get(100023) ->
	#bo_ai{
		no = 100023,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1023},
		condition_list = [100001]
};

get(100024) ->
	#bo_ai{
		no = 100024,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1024},
		condition_list = [100001]
};

get(100025) ->
	#bo_ai{
		no = 100025,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1025},
		condition_list = [100001]
};

get(100031) ->
	#bo_ai{
		no = 100031,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1031},
		condition_list = [100001]
};

get(100032) ->
	#bo_ai{
		no = 100032,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1032},
		condition_list = [100001]
};

get(100033) ->
	#bo_ai{
		no = 100033,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1033},
		condition_list = [100001]
};

get(100034) ->
	#bo_ai{
		no = 100034,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1034},
		condition_list = [100001]
};

get(100035) ->
	#bo_ai{
		no = 100035,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1035},
		condition_list = [100001]
};

get(100036) ->
	#bo_ai{
		no = 100036,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1036},
		condition_list = [100001]
};

get(100041) ->
	#bo_ai{
		no = 100041,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1041},
		condition_list = [100001]
};

get(100042) ->
	#bo_ai{
		no = 100042,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1042},
		condition_list = [100001]
};

get(100043) ->
	#bo_ai{
		no = 100043,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1043},
		condition_list = [100001]
};

get(100044) ->
	#bo_ai{
		no = 100044,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1044},
		condition_list = [100001]
};

get(100045) ->
	#bo_ai{
		no = 100045,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1045},
		condition_list = [100001]
};

get(100046) ->
	#bo_ai{
		no = 100046,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1046},
		condition_list = [100001]
};

get(100051) ->
	#bo_ai{
		no = 100051,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1051},
		condition_list = [100001]
};

get(100052) ->
	#bo_ai{
		no = 100052,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1052},
		condition_list = [100001]
};

get(100053) ->
	#bo_ai{
		no = 100053,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1053},
		condition_list = [100001]
};

get(100054) ->
	#bo_ai{
		no = 100054,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1054},
		condition_list = [100001]
};

get(100055) ->
	#bo_ai{
		no = 100055,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1055},
		condition_list = [100001]
};

get(100056) ->
	#bo_ai{
		no = 100056,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1056},
		condition_list = [100001]
};

get(100057) ->
	#bo_ai{
		no = 100057,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1057},
		condition_list = [100001]
};

get(100058) ->
	#bo_ai{
		no = 100058,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 1058},
		condition_list = [100001]
};

get(100100) ->
	#bo_ai{
		no = 100100,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2001},
		condition_list = [100001]
};

get(100101) ->
	#bo_ai{
		no = 100101,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2002},
		condition_list = [100001]
};

get(100102) ->
	#bo_ai{
		no = 100102,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2003},
		condition_list = [100001]
};

get(100103) ->
	#bo_ai{
		no = 100103,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2004},
		condition_list = [100002]
};

get(100104) ->
	#bo_ai{
		no = 100104,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2005},
		condition_list = [100002]
};

get(100105) ->
	#bo_ai{
		no = 100105,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2006},
		condition_list = [100002]
};

get(100106) ->
	#bo_ai{
		no = 100106,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2007},
		condition_list = [100002]
};

get(100107) ->
	#bo_ai{
		no = 100107,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2008},
		condition_list = [100002]
};

get(100108) ->
	#bo_ai{
		no = 100108,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2009},
		condition_list = [100003]
};

get(100109) ->
	#bo_ai{
		no = 100109,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2010},
		condition_list = [100003]
};

get(100110) ->
	#bo_ai{
		no = 100110,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2011},
		condition_list = [100003]
};

get(100111) ->
	#bo_ai{
		no = 100111,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2012},
		condition_list = [100003]
};

get(100112) ->
	#bo_ai{
		no = 100112,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 2013},
		condition_list = [100003]
};

get(200001) ->
	#bo_ai{
		no = 200001,
		priority = 199,
		weight = 100,
		rules_filter_action_target = [ally_side, {pos_equal_to, 2}, is_fallen],
		action_content = {use_skill, 62144},
		condition_list = [2001]
};

get(200002) ->
	#bo_ai{
		no = 200002,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [ally_side],
		action_content = {use_skill, 62147},
		condition_list = [2002]
};

get(200003) ->
	#bo_ai{
		no = 200003,
		priority = 199,
		weight = 100,
		rules_filter_action_target = [ally_side, {pos_equal_to, 3}, is_fallen],
		action_content = {use_skill, 62145},
		condition_list = [2003]
};

get(200004) ->
	#bo_ai{
		no = 200004,
		priority = 199,
		weight = 100,
		rules_filter_action_target = [ally_side, {pos_equal_to, 1}, is_fallen],
		action_content = {use_skill, 62146},
		condition_list = [2004]
};

get(200005) ->
	#bo_ai{
		no = 200005,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [ally_side, {pos_equal_to, 6}, is_fallen],
		action_content = {use_skill, 62144},
		condition_list = [2005]
};

get(200006) ->
	#bo_ai{
		no = 200006,
		priority = 150,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me],
		action_content = {use_skill, 62148},
		condition_list = []
};

get(200007) ->
	#bo_ai{
		no = 200007,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [ally_side],
		action_content = {use_skill, 62147},
		condition_list = [2006]
};

get(200008) ->
	#bo_ai{
		no = 200008,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [enemy_side,  undead, is_not_under_control, act_speed_highest],
		action_content = do_normal_att,
		condition_list = []
};

get(1003001) ->
	#bo_ai{
		no = 1003001,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 3001},
		condition_list = [100001]
};

get(1003002) ->
	#bo_ai{
		no = 1003002,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 3002},
		condition_list = [100005]
};

get(1003003) ->
	#bo_ai{
		no = 1003003,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 3003},
		condition_list = [100001]
};

get(1003004) ->
	#bo_ai{
		no = 1003004,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 3004},
		condition_list = [100003]
};

get(1003005) ->
	#bo_ai{
		no = 1003005,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 3005},
		condition_list = [100006]
};

get(1003006) ->
	#bo_ai{
		no = 1003006,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 3006},
		condition_list = [100004]
};

get(1003007) ->
	#bo_ai{
		no = 1003007,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 3007},
		condition_list = [100002]
};

get(1003008) ->
	#bo_ai{
		no = 1003008,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 3008},
		condition_list = [100006]
};

get(1003009) ->
	#bo_ai{
		no = 1003009,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 3009},
		condition_list = [10100]
};

get(1003010) ->
	#bo_ai{
		no = 1003010,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 3010},
		condition_list = []
};

get(1004001) ->
	#bo_ai{
		no = 1004001,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4001},
		condition_list = [100001]
};

get(1004002) ->
	#bo_ai{
		no = 1004002,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4002},
		condition_list = [100001]
};

get(1004003) ->
	#bo_ai{
		no = 1004003,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_be_attack, 4003},
		condition_list = [100001]
};

get(1004004) ->
	#bo_ai{
		no = 1004004,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_attack, 4004},
		condition_list = [100001]
};

get(1004005) ->
	#bo_ai{
		no = 1004005,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4005},
		condition_list = [100001]
};

get(1004006) ->
	#bo_ai{
		no = 1004006,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4006},
		condition_list = [100002]
};

get(1004007) ->
	#bo_ai{
		no = 1004007,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4007},
		condition_list = [100002]
};

get(1004008) ->
	#bo_ai{
		no = 1004008,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_attack, 4008},
		condition_list = [100002]
};

get(1004009) ->
	#bo_ai{
		no = 1004009,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_attack, 4009},
		condition_list = [100002]
};

get(1004010) ->
	#bo_ai{
		no = 1004010,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_attack, 4010},
		condition_list = [100002]
};

get(1004011) ->
	#bo_ai{
		no = 1004011,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_attack, 4011},
		condition_list = [100002]
};

get(1004012) ->
	#bo_ai{
		no = 1004012,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4012},
		condition_list = [100003]
};

get(1004013) ->
	#bo_ai{
		no = 1004013,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4013},
		condition_list = [100003]
};

get(1004014) ->
	#bo_ai{
		no = 1004014,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_attack, 4014},
		condition_list = [100003]
};

get(1004015) ->
	#bo_ai{
		no = 1004015,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {use_skill, 100115},
		condition_list = [100004]
};

get(1004016) ->
	#bo_ai{
		no = 1004016,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_attack, 4015},
		condition_list = [100003]
};

get(1004017) ->
	#bo_ai{
		no = 1004017,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_use_skill, 4016},
		condition_list = [100004]
};

get(1004018) ->
	#bo_ai{
		no = 1004018,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4017},
		condition_list = [100005]
};

get(1004019) ->
	#bo_ai{
		no = 1004019,
		priority = 25,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 100113},
		condition_list = [100005]
};

get(1004020) ->
	#bo_ai{
		no = 1004020,
		priority = 26,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 100114},
		condition_list = [100005]
};

get(1004021) ->
	#bo_ai{
		no = 1004021,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [],
		action_content = { summon_mon,[{56002,2}]},
		condition_list = [100001]
};

get(1004022) ->
	#bo_ai{
		no = 1004022,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [],
		action_content = { summon_mon,[{56003,2}]},
		condition_list = [100002]
};

get(1004023) ->
	#bo_ai{
		no = 1004023,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [],
		action_content = { summon_mon,[{56004,2}]},
		condition_list = [100003]
};

get(1004024) ->
	#bo_ai{
		no = 1004024,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [],
		action_content = { summon_mon,[{56005,2}]},
		condition_list = [100004]
};

get(1004025) ->
	#bo_ai{
		no = 1004025,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 10078},
		condition_list = [2007,2016]
};

get(1004026) ->
	#bo_ai{
		no = 1004026,
		priority = 1000,
		weight = 500,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {use_skill, 10079},
		condition_list = [2010,2008,2017]
};

get(1004027) ->
	#bo_ai{
		no = 1004027,
		priority = 1,
		weight = 5,
		rules_filter_action_target = [],
		action_content = {escape, 1000},
		condition_list = [2010,2007]
};

get(1004028) ->
	#bo_ai{
		no = 1004028,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10057},
		condition_list = [2011]
};

get(1004029) ->
	#bo_ai{
		no = 1004029,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10058},
		condition_list = [2012]
};

get(1004030) ->
	#bo_ai{
		no = 1004030,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10059},
		condition_list = [2013]
};

get(1004031) ->
	#bo_ai{
		no = 1004031,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10060},
		condition_list = [2014]
};

get(1004032) ->
	#bo_ai{
		no = 1004032,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10061},
		condition_list = [2015]
};

get(1004033) ->
	#bo_ai{
		no = 1004033,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10078},
		condition_list = [2016]
};

get(1004034) ->
	#bo_ai{
		no = 1004034,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10062},
		condition_list = [2018]
};

get(1004035) ->
	#bo_ai{
		no = 1004035,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10063},
		condition_list = [2019]
};

get(1004036) ->
	#bo_ai{
		no = 1004036,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10064},
		condition_list = [2020]
};

get(1004037) ->
	#bo_ai{
		no = 1004037,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10065},
		condition_list = [2021]
};

get(1004038) ->
	#bo_ai{
		no = 1004038,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10066},
		condition_list = [2022]
};

get(1004039) ->
	#bo_ai{
		no = 1004039,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [ally_side, {cur_hp_percentage_lower_than, 50}, undead, {has_not_spec_no_buff, 28}],
		action_content = {use_skill, 10067},
		condition_list = [2023]
};

get(1004040) ->
	#bo_ai{
		no = 1004040,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10068},
		condition_list = [2024]
};

get(1004041) ->
	#bo_ai{
		no = 1004041,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10069},
		condition_list = [2025]
};

get(1004042) ->
	#bo_ai{
		no = 1004042,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10070},
		condition_list = [2026]
};

get(1004043) ->
	#bo_ai{
		no = 1004043,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10071},
		condition_list = [2027]
};

get(1004044) ->
	#bo_ai{
		no = 1004044,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10072},
		condition_list = [2028]
};

get(1004045) ->
	#bo_ai{
		no = 1004045,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10073},
		condition_list = [2029]
};

get(1004046) ->
	#bo_ai{
		no = 1004046,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10074},
		condition_list = [2030]
};

get(1004047) ->
	#bo_ai{
		no = 1004047,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10075},
		condition_list = [2031]
};

get(1004048) ->
	#bo_ai{
		no = 1004048,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10076},
		condition_list = [2032]
};

get(1004049) ->
	#bo_ai{
		no = 1004049,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10077},
		condition_list = [2033]
};

get(1004050) ->
	#bo_ai{
		no = 1004050,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_escape, 4018},
		condition_list = []
};

get(1004051) ->
	#bo_ai{
		no = 1004051,
		priority = 200,
		weight = 100,
		rules_filter_action_target = [undead, enemy_side],
		action_content = {talk, on_use_skill, 4019},
		condition_list = [2008]
};

get(1004052) ->
	#bo_ai{
		no = 1004052,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4020},
		condition_list = [100001]
};

get(1004053) ->
	#bo_ai{
		no = 1004053,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4021},
		condition_list = [100002]
};

get(1004054) ->
	#bo_ai{
		no = 1004054,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4022},
		condition_list = [100003]
};

get(1004055) ->
	#bo_ai{
		no = 1004055,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4023},
		condition_list = [100004]
};

get(1004056) ->
	#bo_ai{
		no = 1004056,
		priority = 50,
		weight = 100,
		rules_filter_action_target = [ally_side, {pos_equal_to, 2}],
		action_content = {use_skill, 400004},
		condition_list = [100002, 2034]
};

get(1004057) ->
	#bo_ai{
		no = 1004057,
		priority = 50,
		weight = 100,
		rules_filter_action_target = [ally_side, {pos_equal_to, 2}],
		action_content = {use_skill, 400004},
		condition_list = [100003, 2035]
};

get(1004058) ->
	#bo_ai{
		no = 1004058,
		priority = 50,
		weight = 100,
		rules_filter_action_target = [ally_side, {pos_equal_to, 2}],
		action_content = {use_skill, 400004},
		condition_list = [100004, 2036]
};

get(1004059) ->
	#bo_ai{
		no = 1004059,
		priority = 50,
		weight = 100,
		rules_filter_action_target = [ally_side, {pos_equal_to, 2}],
		action_content = {use_skill, 400004},
		condition_list = [100005, 2037]
};

get(1004060) ->
	#bo_ai{
		no = 1004060,
		priority = 40,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 400006},
		condition_list = [2038]
};

get(1004061) ->
	#bo_ai{
		no = 1004061,
		priority = 50,
		weight = 100,
		rules_filter_action_target = [ally_side, {pos_equal_to, 1}],
		action_content = {use_skill, 400007},
		condition_list = [2039]
};

get(1004062) ->
	#bo_ai{
		no = 1004062,
		priority = 60,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {escape, 1000},
		condition_list = [2038]
};

get(1004063) ->
	#bo_ai{
		no = 1004063,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10052},
		condition_list = [2041]
};

get(1004064) ->
	#bo_ai{
		no = 1004064,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10053},
		condition_list = [2042]
};

get(1004065) ->
	#bo_ai{
		no = 1004065,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10054},
		condition_list = [2043]
};

get(1004066) ->
	#bo_ai{
		no = 1004066,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10055},
		condition_list = [2044]
};

get(1004067) ->
	#bo_ai{
		no = 1004067,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,10056},
		condition_list = [2045]
};

get(1004068) ->
	#bo_ai{
		no = 1004068,
		priority = 100,
		weight = 5,
		rules_filter_action_target = [],
		action_content = {escape, 1000},
		condition_list = [2046]
};

get(1004069) ->
	#bo_ai{
		no = 1004069,
		priority = 100,
		weight = 5,
		rules_filter_action_target = [],
		action_content = {escape, 1000},
		condition_list = [2047]
};

get(1004070) ->
	#bo_ai{
		no = 1004070,
		priority = 100,
		weight = 5,
		rules_filter_action_target = [],
		action_content = {escape, 1000},
		condition_list = [2048]
};

get(1004071) ->
	#bo_ai{
		no = 1004071,
		priority = 100,
		weight = 5,
		rules_filter_action_target = [],
		action_content = {escape, 1000},
		condition_list = [2049]
};

get(1004072) ->
	#bo_ai{
		no = 1004072,
		priority = 100,
		weight = 5,
		rules_filter_action_target = [],
		action_content = {escape, 1000},
		condition_list = [2050]
};

get(1004073) ->
	#bo_ai{
		no = 1004073,
		priority = 100,
		weight = 5,
		rules_filter_action_target = [],
		action_content = {escape, 1000},
		condition_list = [2051]
};

get(1004075) ->
	#bo_ai{
		no = 1004075,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70001},
		condition_list = [2053]
};

get(1004076) ->
	#bo_ai{
		no = 1004076,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70002},
		condition_list = [2054]
};

get(1004077) ->
	#bo_ai{
		no = 1004077,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70003},
		condition_list = [2055]
};

get(1004078) ->
	#bo_ai{
		no = 1004078,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70004},
		condition_list = [2056]
};

get(1004079) ->
	#bo_ai{
		no = 1004079,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70005},
		condition_list = [2057]
};

get(1004080) ->
	#bo_ai{
		no = 1004080,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70101},
		condition_list = [2058]
};

get(1004081) ->
	#bo_ai{
		no = 1004081,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [ally_side],
		action_content = {use_skill,70102},
		condition_list = [2059]
};

get(1004082) ->
	#bo_ai{
		no = 1004082,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70103},
		condition_list = [2060]
};

get(1004083) ->
	#bo_ai{
		no = 1004083,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70104},
		condition_list = [2061]
};

get(1004084) ->
	#bo_ai{
		no = 1004084,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70105},
		condition_list = [2062]
};

get(1004085) ->
	#bo_ai{
		no = 1004085,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 10080},
		condition_list = [2063]
};

get(1004086) ->
	#bo_ai{
		no = 1004086,
		priority = 6,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 21},
		condition_list = [2064]
};

get(1004087) ->
	#bo_ai{
		no = 1004087,
		priority = 8,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 22},
		condition_list = [2065, 2078]
};

get(1004088) ->
	#bo_ai{
		no = 1004088,
		priority = 10,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 23},
		condition_list = [2066, 2079]
};

get(1004089) ->
	#bo_ai{
		no = 1004089,
		priority = 16,
		weight = 10,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}],
		action_content = {use_skill, 24},
		condition_list = [2067, 2080,2081]
};

get(1004090) ->
	#bo_ai{
		no = 1004090,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [ally_side],
		action_content = {use_skill, 25},
		condition_list = [2068]
};

get(1004091) ->
	#bo_ai{
		no = 1004091,
		priority = 20,
		weight = 10,
		rules_filter_action_target = [ally_side, is_fallen],
		action_content = {use_skill, 26},
		condition_list = [2069, 2082]
};

get(1004092) ->
	#bo_ai{
		no = 1004092,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 27},
		condition_list = [2070]
};

get(1004093) ->
	#bo_ai{
		no = 1004093,
		priority = 20,
		weight = 10,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 31},
		condition_list = [2071, 2084]
};

get(1004094) ->
	#bo_ai{
		no = 1004094,
		priority = 16,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 32},
		condition_list = [2072, 2086]
};

get(1004095) ->
	#bo_ai{
		no = 1004095,
		priority = 18,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead,{belong_to_faction, 1}],
		action_content = {use_skill, 33},
		condition_list = [2073, 2085]
};

get(1004096) ->
	#bo_ai{
		no = 1004096,
		priority = 12,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 34},
		condition_list = [2074, 2083]
};

get(1004097) ->
	#bo_ai{
		no = 1004097,
		priority = 18,
		weight = 10,
		rules_filter_action_target = [ally_side, {has_not_spec_no_buff, 15}],
		action_content = {use_skill, 35},
		condition_list = [2075, 2087]
};

get(1004098) ->
	#bo_ai{
		no = 1004098,
		priority = 14,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 36},
		condition_list = [2076]
};

get(1004099) ->
	#bo_ai{
		no = 1004099,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 37},
		condition_list = [2077]
};

get(1004100) ->
	#bo_ai{
		no = 1004100,
		priority = 12,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 23},
		condition_list = [2066, 2083]
};

get(1004101) ->
	#bo_ai{
		no = 1004101,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70106},
		condition_list = [2088]
};

get(1004102) ->
	#bo_ai{
		no = 1004102,
		priority = 100,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70107},
		condition_list = [2089, 2007]
};

get(1004103) ->
	#bo_ai{
		no = 1004103,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70006},
		condition_list = [2090]
};

get(1004104) ->
	#bo_ai{
		no = 1004104,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70007},
		condition_list = [2091]
};

get(1004105) ->
	#bo_ai{
		no = 1004105,
		priority = 1,
		weight = 10,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70008},
		condition_list = [2092]
};

get(1004106) ->
	#bo_ai{
		no = 1004106,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill,70009},
		condition_list = [2093]
};

get(1004107) ->
	#bo_ai{
		no = 1004107,
		priority = 19,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		action_content = {use_skill,70011},
		condition_list = [2096]
};

get(1004108) ->
	#bo_ai{
		no = 1004108,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [ally_side],
		action_content = {use_skill, 70010},
		condition_list = [2095]
};

get(1004109) ->
	#bo_ai{
		no = 1004109,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70012},
		condition_list = [2097]
};

get(1004110) ->
	#bo_ai{
		no = 1004110,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [ally_side],
		action_content = {use_skill,70013},
		condition_list = [2098]
};

get(1004111) ->
	#bo_ai{
		no = 1004111,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70014},
		condition_list = [2099]
};

get(1004112) ->
	#bo_ai{
		no = 1004112,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70015},
		condition_list = [2100]
};

get(1004113) ->
	#bo_ai{
		no = 1004113,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [ally_side],
		action_content = {use_skill,70016},
		condition_list = [2101]
};

get(1004114) ->
	#bo_ai{
		no = 1004114,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill,70017},
		condition_list = [2102]
};

get(1004115) ->
	#bo_ai{
		no = 1004115,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill,70018},
		condition_list = [2103]
};

get(1004116) ->
	#bo_ai{
		no = 1004116,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill,70019},
		condition_list = [2104]
};

get(1004117) ->
	#bo_ai{
		no = 1004117,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		action_content = {use_skill,70020},
		condition_list = [2105]
};

get(1004118) ->
	#bo_ai{
		no = 1004118,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,70021},
		condition_list = [2106]
};

get(1004119) ->
	#bo_ai{
		no = 1004119,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 70022},
		condition_list = [2107]
};

get(1004120) ->
	#bo_ai{
		no = 1004120,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 70023},
		condition_list = [2108]
};

get(1004123) ->
	#bo_ai{
		no = 1004123,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 70024},
		condition_list = [2109]
};

get(1004125) ->
	#bo_ai{
		no = 1004125,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 70025},
		condition_list = [2110]
};

get(1004126) ->
	#bo_ai{
		no = 1004126,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 70026},
		condition_list = [2111]
};

get(1004127) ->
	#bo_ai{
		no = 1004127,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill, 70027},
		condition_list = [2112]
};

get(3000001) ->
	#bo_ai{
		no = 3000001,
		priority = 20,
		weight = 103,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 62149},
		condition_list = [1000001, 1000002, 1000003]
};

get(3000002) ->
	#bo_ai{
		no = 3000002,
		priority = 20,
		weight = 103,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 62149},
		condition_list = [1000001, 1000004, 1000003]
};

get(3000003) ->
	#bo_ai{
		no = 3000003,
		priority = 20,
		weight = 103,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 62149},
		condition_list = [1000001, 1000005, 1000003]
};

get(3000004) ->
	#bo_ai{
		no = 3000004,
		priority = 20,
		weight = 5,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62151},
		condition_list = [1000006]
};

get(3000005) ->
	#bo_ai{
		no = 3000005,
		priority = 20,
		weight = 5,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62150},
		condition_list = [1000007]
};

get(3000006) ->
	#bo_ai{
		no = 3000006,
		priority = 20,
		weight = 5,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62152},
		condition_list = [1000008]
};

get(3000007) ->
	#bo_ai{
		no = 3000007,
		priority = 20,
		weight = 101,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 62149},
		condition_list = [1000010, 1000012]
};

get(3000008) ->
	#bo_ai{
		no = 3000008,
		priority = 20,
		weight = 102,
		rules_filter_action_target = [ally_side, {pos_equal_to, 2}],
		action_content = {use_skill, 62153},
		condition_list = [1000011]
};

get(3000009) ->
	#bo_ai{
		no = 3000009,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {escape, 1000},
		condition_list = [1000013]
};

get(3000010) ->
	#bo_ai{
		no = 3000010,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [phy_att_highest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62154},
		condition_list = [1000014, 1000015]
};

get(3000011) ->
	#bo_ai{
		no = 3000011,
		priority = 20,
		weight = 5,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62155},
		condition_list = [1000013, 1000016]
};

get(3000012) ->
	#bo_ai{
		no = 3000012,
		priority = 20,
		weight = 5,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62156},
		condition_list = [1000017]
};

get(3000013) ->
	#bo_ai{
		no = 3000013,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62156},
		condition_list = [1000014, 1000018]
};

get(3000014) ->
	#bo_ai{
		no = 3000014,
		priority = 20,
		weight = 10,
		rules_filter_action_target = [enemy_side, {belong_to_faction, 1}, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 62157},
		condition_list = [1000013, 1000019, 1000021]
};

get(3000015) ->
	#bo_ai{
		no = 3000015,
		priority = 20,
		weight = 5,
		rules_filter_action_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 62156},
		condition_list = [1000013, 1000020]
};

get(3000016) ->
	#bo_ai{
		no = 3000016,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [ally_side, {pos_equal_to, 1}],
		action_content = protect_others,
		condition_list = [1000022]
};

get(3000017) ->
	#bo_ai{
		no = 3000017,
		priority = 20,
		weight = 50,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62156},
		condition_list = [1000023, 1000024]
};

get(3000018) ->
	#bo_ai{
		no = 3000018,
		priority = 20,
		weight = 5,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62155},
		condition_list = [1000025]
};

get(3000019) ->
	#bo_ai{
		no = 3000019,
		priority = 20,
		weight = 5,
		rules_filter_action_target = [],
		action_content = defend,
		condition_list = [1000026]
};

get(3000020) ->
	#bo_ai{
		no = 3000020,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4155},
		condition_list = [1000026]
};

get(3000021) ->
	#bo_ai{
		no = 3000021,
		priority = 20,
		weight = 105,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{36019,1},{36020,1},{36021,1},{36022,1},{36023,1},{36024,1},{36025,1},{36026,1}]},
		condition_list = [1000027]
};

get(3000022) ->
	#bo_ai{
		no = 3000022,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4156},
		condition_list = [1000027]
};

get(3000023) ->
	#bo_ai{
		no = 3000023,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62151},
		condition_list = [1000028, 1000029]
};

get(3000024) ->
	#bo_ai{
		no = 3000024,
		priority = 20,
		weight = 108,
		rules_filter_action_target = [undead, ally_side, is_under_control],
		action_content = {use_skill, 400009},
		condition_list = [1000030, 1000031, 1000032]
};

get(3000026) ->
	#bo_ai{
		no = 3000026,
		priority = 20,
		weight = 105,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62151},
		condition_list = []
};

get(3000027) ->
	#bo_ai{
		no = 3000027,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_under_control],
		action_content = {use_skill, 400010},
		condition_list = [1000030, 1000031, 1000033]
};

get(3000029) ->
	#bo_ai{
		no = 3000029,
		priority = 20,
		weight = 105,
		rules_filter_action_target = [ally_side, {pos_equal_to, 1}],
		action_content = protect_others,
		condition_list = [1000034]
};

get(3000030) ->
	#bo_ai{
		no = 3000030,
		priority = 20,
		weight = 104,
		rules_filter_action_target = [ally_side, {pos_equal_to, 1}],
		action_content = protect_others,
		condition_list = [1000035]
};

get(3000031) ->
	#bo_ai{
		no = 3000031,
		priority = 20,
		weight = 150,
		rules_filter_action_target = [ally_side, {pos_equal_to, 1}, is_fallen],
		action_content = {use_skill, 62158},
		condition_list = [1000036, 1000037]
};

get(3000032) ->
	#bo_ai{
		no = 3000032,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62151},
		condition_list = [1000029]
};

get(3000033) ->
	#bo_ai{
		no = 3000033,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62155},
		condition_list = [1000025]
};

get(3000034) ->
	#bo_ai{
		no = 3000034,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62156},
		condition_list = [1000024]
};

get(3000035) ->
	#bo_ai{
		no = 3000035,
		priority = 20,
		weight = 99,
		rules_filter_action_target = [],
		action_content = {escape, 1000},
		condition_list = [1000038, 1000039, 1000040,  1000041, 1000042, 1000043,  1000044, 1000045]
};

get(3000036) ->
	#bo_ai{
		no = 3000036,
		priority = 20,
		weight = 99,
		rules_filter_action_target = [],
		action_content = {talk, on_escape, 4157},
		condition_list = []
};

get(3000037) ->
	#bo_ai{
		no = 3000037,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, {belong_to_faction, 2}, undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 62154},
		condition_list = [1000046, 1000047]
};

get(3000038) ->
	#bo_ai{
		no = 3000038,
		priority = 23,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62155},
		condition_list = [1000048, 1000049]
};

get(3000039) ->
	#bo_ai{
		no = 3000039,
		priority = 28,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = do_normal_att,
		condition_list = [1000050]
};

get(3000040) ->
	#bo_ai{
		no = 3000040,
		priority = 29,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62154},
		condition_list = [1000047]
};

get(3000041) ->
	#bo_ai{
		no = 3000041,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62155},
		condition_list = [1000051, 1000052, 1000053, 1000054]
};

get(3000042) ->
	#bo_ai{
		no = 3000042,
		priority = 23,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62154},
		condition_list = [1000055,1000056, 1000057, 1000058]
};

get(3000043) ->
	#bo_ai{
		no = 3000043,
		priority = 28,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = do_normal_att,
		condition_list = [1000050]
};

get(3000044) ->
	#bo_ai{
		no = 3000044,
		priority = 29,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62155},
		condition_list = [1000048]
};

get(3000045) ->
	#bo_ai{
		no = 3000045,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62159},
		condition_list = [1000059]
};

get(3000046) ->
	#bo_ai{
		no = 3000046,
		priority = 29,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62154},
		condition_list = [1000060, 1000047]
};

get(3000047) ->
	#bo_ai{
		no = 3000047,
		priority = 28,
		weight = 200,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = do_normal_att,
		condition_list = [1000061]
};

get(3000048) ->
	#bo_ai{
		no = 3000048,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62155},
		condition_list = [1000048]
};

get(3000049) ->
	#bo_ai{
		no = 3000049,
		priority = 28,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = do_normal_att,
		condition_list = [1000050]
};

get(3000050) ->
	#bo_ai{
		no = 3000050,
		priority = 30,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {escape, 1000},
		condition_list = [1000062]
};

get(3000051) ->
	#bo_ai{
		no = 3000051,
		priority = 30,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_escape, 4158},
		condition_list = []
};

get(3000052) ->
	#bo_ai{
		no = 3000052,
		priority = 28,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_under_control],
		action_content = {use_skill, 62167},
		condition_list = [1000065, 1000063, 1000066, 1000064]
};

get(3000053) ->
	#bo_ai{
		no = 3000053,
		priority = 27,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_under_control],
		action_content = {use_skill, 400015},
		condition_list = [1000067, 1000065]
};

get(3000054) ->
	#bo_ai{
		no = 3000054,
		priority = 26,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,62161},
		condition_list = [1000065, 1000087, 1000088, 1000069]
};

get(3000055) ->
	#bo_ai{
		no = 3000055,
		priority = 22,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {escape, 1000},
		condition_list = [1000070, 1000071]
};

get(3000056) ->
	#bo_ai{
		no = 3000056,
		priority = 21,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_escape, 4159},
		condition_list = []
};

get(3000057) ->
	#bo_ai{
		no = 3000057,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,62160},
		condition_list = [1000072]
};

get(3000058) ->
	#bo_ai{
		no = 3000058,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,62165},
		condition_list = [1000085]
};

get(3000059) ->
	#bo_ai{
		no = 3000059,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,62155},
		condition_list = [1000075, 1000076]
};

get(3000060) ->
	#bo_ai{
		no = 3000060,
		priority = 21,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,62154},
		condition_list = [1000077, 1000078]
};

get(3000061) ->
	#bo_ai{
		no = 3000061,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,62162},
		condition_list = [1000080]
};

get(3000062) ->
	#bo_ai{
		no = 3000062,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [enemy_side, undead, is_not_frozen,  not_invisible_to_me],
		action_content = {use_skill,62163},
		condition_list = [1000081]
};

get(3000063) ->
	#bo_ai{
		no = 3000063,
		priority = 21,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_under_control, cur_hp_lowest],
		action_content = {use_skill,400010},
		condition_list = [1000079, 1000082]
};

get(3000064) ->
	#bo_ai{
		no = 3000064,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me,is_not_frozen,  enemy_side],
		action_content = {use_skill,62164},
		condition_list = [1000086]
};

get(3000066) ->
	#bo_ai{
		no = 3000066,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [mag_def_highest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62166},
		condition_list = [1000091]
};

get(3000067) ->
	#bo_ai{
		no = 3000067,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62165},
		condition_list = [1000085]
};

get(3000068) ->
	#bo_ai{
		no = 3000068,
		priority = 22,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62154},
		condition_list = [1000047]
};

get(3000069) ->
	#bo_ai{
		no = 3000069,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62155},
		condition_list = [1000048]
};

get(3000070) ->
	#bo_ai{
		no = 3000070,
		priority = 22,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62156},
		condition_list = [1000024]
};

get(3000071) ->
	#bo_ai{
		no = 3000071,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side],
		action_content = {use_skill, 62152},
		condition_list = [1000090]
};

get(3000080) ->
	#bo_ai{
		no = 3000080,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,phy_att_highest],
		action_content = {use_skill,62170},
		condition_list = [1000092, 1000109, 1000106]
};

get(3000081) ->
	#bo_ai{
		no = 3000081,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,cur_hp_highest, phy_def_highest],
		action_content = {use_skill,62172},
		condition_list = [1000093, 1000106]
};

get(3000082) ->
	#bo_ai{
		no = 3000082,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,phy_def_highest,cur_hp_lowest,phy_def_lowest],
		action_content = {use_skill,62171},
		condition_list = [1000094, 1000109, 1000106]
};

get(3000083) ->
	#bo_ai{
		no = 3000083,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill,62173},
		condition_list = [1000095, 1000104, 1000107]
};

get(3000084) ->
	#bo_ai{
		no = 3000084,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,cur_hp_lowest, act_speed_highest],
		action_content = {use_skill,62174},
		condition_list = [1000096, 1000105, 1000106]
};

get(3000085) ->
	#bo_ai{
		no = 3000085,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,cur_hp_lowest,act_speed_highest],
		action_content = {use_skill,62170},
		condition_list = [1000092, 1000109]
};

get(3000086) ->
	#bo_ai{
		no = 3000086,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,cur_hp_highest, phy_def_highest,seal_resis_highest],
		action_content = {use_skill,62172},
		condition_list = [1000093]
};

get(3000087) ->
	#bo_ai{
		no = 3000087,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,cur_hp_lowest, act_speed_highest,seal_hit_highest],
		action_content = {use_skill,62171},
		condition_list = [1000094, 1000109]
};

get(3000088) ->
	#bo_ai{
		no = 3000088,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,cur_hp_lowest, act_speed_highest,cur_hp_lowest],
		action_content = {use_skill,62174},
		condition_list = [1000096, 1000105]
};

get(3000089) ->
	#bo_ai{
		no = 3000089,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,phy_att_highest],
		action_content = {use_skill,62183},
		condition_list = [1000097,1000102, 1000106]
};

get(3000090) ->
	#bo_ai{
		no = 3000090,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,phy_def_highest,cur_hp_lowest,phy_def_lowest],
		action_content = {use_skill,62184},
		condition_list = [1000099, 1000106]
};

get(3000091) ->
	#bo_ai{
		no = 3000091,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,sjjh_principle],
		action_content = {use_skill,62185},
		condition_list = [1000110, 1000110, 1000103, 1000106]
};

get(3000092) ->
	#bo_ai{
		no = 3000092,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [cur_hp_lowest, undead, not_invisible_to_me, is_not_frozen,  enemy_side,phy_att_highest],
		action_content = {use_skill,62183},
		condition_list = [1000097, 1000102]
};

get(3000093) ->
	#bo_ai{
		no = 3000093,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,phy_def_highest,cur_hp_lowest,phy_def_lowest],
		action_content = {use_skill,62184},
		condition_list = [1000099]
};

get(3000094) ->
	#bo_ai{
		no = 3000094,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,phy_def_highest,cur_hp_lowest,phy_def_lowest],
		action_content = {use_skill,62185},
		condition_list = [1000110, 1000110, 1000103]
};

get(3000095) ->
	#bo_ai{
		no = 3000095,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [enemy_side,{belong_to_faction,[1]}, {belong_to_faction,[6]},is_not_frozen ,is_trance],
		action_content = {use_skill,62186},
		condition_list = [1000101, 1000110, 1000111, 1000112]
};

get(3000096) ->
	#bo_ai{
		no = 3000096,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_trance, is_partner,phy_att_highest,act_speed_highest],
		action_content = {use_skill,62169},
		condition_list = [1000086, 1000119]
};

get(3000097) ->
	#bo_ai{
		no = 3000097,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, is_partner,phy_def_highest, cur_hp_lowest],
		action_content = {use_skill,62168},
		condition_list = [1000121, 1000106]
};

get(3000098) ->
	#bo_ai{
		no = 3000098,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[1]}],
		action_content = {use_skill,62169},
		condition_list = [1000113, 1000086]
};

get(3000099) ->
	#bo_ai{
		no = 3000099,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[4]}],
		action_content = {use_skill,62169},
		condition_list = [1000114, 1000086]
};

get(3000100) ->
	#bo_ai{
		no = 3000100,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[2]}],
		action_content = {use_skill,62169},
		condition_list = [1000115, 1000086]
};

get(3000101) ->
	#bo_ai{
		no = 3000101,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[5]}],
		action_content = {use_skill,62169},
		condition_list = [1000116, 1000086]
};

get(3000102) ->
	#bo_ai{
		no = 3000102,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[3]}],
		action_content = {use_skill,62169},
		condition_list = [1000117, 1000086]
};

get(3000103) ->
	#bo_ai{
		no = 3000103,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[6]}],
		action_content = {use_skill,62169},
		condition_list = [1000118, 1000086]
};

get(3000104) ->
	#bo_ai{
		no = 3000104,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_trance,cur_hp_lowest,phy_def_highest],
		action_content = {use_skill,62168},
		condition_list = [1000121]
};

get(3000105) ->
	#bo_ai{
		no = 3000105,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,act_speed_highest,seal_hit_highest],
		action_content = {use_skill,62170},
		condition_list = [1000092, 1000123]
};

get(3000106) ->
	#bo_ai{
		no = 3000106,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,is_partner,phy_att_highest,mag_att_highest],
		action_content = {use_skill,62170},
		condition_list = [1000092, 1000122, 1000125, 1000126, 1000127, 1000128, 1000129, 1000130]
};

get(3000107) ->
	#bo_ai{
		no = 3000107,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill,62173},
		condition_list = [1000095, 1000123, 1000124]
};

get(3000108) ->
	#bo_ai{
		no = 3000108,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,phy_att_highest,mag_att_highest,seal_hit_highest],
		action_content = {use_skill,62174},
		condition_list = [1000096, 1000125, 1000123]
};

get(3000109) ->
	#bo_ai{
		no = 3000109,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,cur_hp_highest, mag_att_highest],
		action_content = {use_skill,62172},
		condition_list = [1000093]
};

get(3000110) ->
	#bo_ai{
		no = 3000110,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4019,2}]},
		condition_list = [1000131, 1000133]
};

get(3000111) ->
	#bo_ai{
		no = 3000111,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4160},
		condition_list = []
};

get(3000115) ->
	#bo_ai{
		no = 3000115,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,cur_hp_highest, phy_def_highest],
		action_content = {use_skill,62183},
		condition_list = [1000097, 1000135]
};

get(3000116) ->
	#bo_ai{
		no = 3000116,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,cur_hp_highest, phy_def_highest],
		action_content = {use_skill,62184},
		condition_list = [1000099]
};

get(3000117) ->
	#bo_ai{
		no = 3000117,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,cur_hp_highest,mag_att_highest],
		action_content = {use_skill,62185},
		condition_list = [1000100, 1000137, 1000136]
};

get(3000118) ->
	#bo_ai{
		no = 3000118,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,cur_hp_highest,phy_att_highest],
		action_content = {use_skill,62183},
		condition_list = [1000097, 1000126, 1000127, 1000128, 1000129, 1000130]
};

get(3000119) ->
	#bo_ai{
		no = 3000119,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,cur_hp_highest],
		action_content = {use_skill,62184},
		condition_list = [1000099, 1000126, 1000127, 1000128, 1000129, 1000130]
};

get(3000120) ->
	#bo_ai{
		no = 3000120,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,cur_hp_highest, phy_def_highest],
		action_content = {use_skill,62185},
		condition_list = [1000100, 1000126, 1000127, 1000128, 1000129, 1000130, 1000137, 1000136]
};

get(3000121) ->
	#bo_ai{
		no = 3000121,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [enemy_side,{belong_to_faction,[3]}, {belong_to_faction,[3]},is_not_frozen ,is_trance],
		action_content = {use_skill,62186},
		condition_list = [1000101, 1000137, 1000138, 1000139]
};

get(3000122) ->
	#bo_ai{
		no = 3000122,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4019,2}]},
		condition_list = [1000140, 1000141]
};

get(3000123) ->
	#bo_ai{
		no = 3000123,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4160},
		condition_list = []
};

get(3000130) ->
	#bo_ai{
		no = 3000130,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_under_control],
		action_content = {use_skill, 400019},
		condition_list = [1000032]
};

get(3000131) ->
	#bo_ai{
		no = 3000131,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_use_skill, 4161},
		condition_list = []
};

get(3000132) ->
	#bo_ai{
		no = 3000132,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4018,2}]},
		condition_list = [1000143]
};

get(3000133) ->
	#bo_ai{
		no = 3000133,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000135) ->
	#bo_ai{
		no = 3000135,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest, cur_hp_lowest, seal_hit_highest],
		action_content = {use_skill, 62188},
		condition_list = [1000145]
};

get(3000136) ->
	#bo_ai{
		no = 3000136,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest, cur_hp_lowest, seal_hit_highest],
		action_content = {use_skill, 62187},
		condition_list = [1000146, 1000149]
};

get(3000137) ->
	#bo_ai{
		no = 3000137,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_highest,seal_hit_highest,cur_hp_highest],
		action_content = {use_skill, 62190},
		condition_list = [1000147, 1000150, 1000154]
};

get(3000138) ->
	#bo_ai{
		no = 3000138,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 62189},
		condition_list = [1000148, 1000153, 1000150]
};

get(3000139) ->
	#bo_ai{
		no = 3000139,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest,act_speed_highest, is_partner],
		action_content = {use_skill, 62188},
		condition_list = [1000145, 1000152]
};

get(3000140) ->
	#bo_ai{
		no = 3000140,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest,act_speed_highest, is_partner],
		action_content = {use_skill, 62187},
		condition_list = [1000146, 1000149, 1000152]
};

get(3000141) ->
	#bo_ai{
		no = 3000141,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_highest,cur_hp_highest, is_partner],
		action_content = {use_skill, 62190},
		condition_list = [1000147, 1000150, 1000154, 1000152]
};

get(3000142) ->
	#bo_ai{
		no = 3000142,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4019,2}]},
		condition_list = [1000151, 1000178]
};

get(3000143) ->
	#bo_ai{
		no = 3000143,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000145) ->
	#bo_ai{
		no = 3000145,
		priority = 12,
		weight = 100,
		rules_filter_action_target = [undead,sjjh_principle,is_not_under_control,enemy_side],
		action_content = {use_skill, 62175},
		condition_list = [1000160]
};

get(3000146) ->
	#bo_ai{
		no = 3000146,
		priority = 13,
		weight = 100,
		rules_filter_action_target = [ally_side, mag_att_highest,is_not_under_control,not_invisible_to_me,phy_att_highest],
		action_content = {use_skill, 62178},
		condition_list = [1000161, 1000166]
};

get(3000147) ->
	#bo_ai{
		no = 3000147,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,phy_def_highest,mag_def_highest],
		action_content = {use_skill, 62176},
		condition_list = [1000162, 1000167]
};

get(3000148) ->
	#bo_ai{
		no = 3000148,
		priority = 17,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,seal_hit_highest,act_speed_highest,cur_hp_highest],
		action_content = {use_skill, 62177},
		condition_list = [1000163, 1000169, 1000170]
};

get(3000149) ->
	#bo_ai{
		no = 3000149,
		priority = 18,
		weight = 100,
		rules_filter_action_target = [ally_side,is_not_under_control,not_invisible_to_me,cur_hp_highest],
		action_content = {use_skill, 62179},
		condition_list = [1000164, 1000171]
};

get(3000150) ->
	#bo_ai{
		no = 3000150,
		priority = 19,
		weight = 100,
		rules_filter_action_target = [ally_side,is_not_under_control,{pos_equal_to, 1},{pos_equal_to, 2},{pos_equal_to, 3},{pos_equal_to, 4},{pos_equal_to, 5}],
		action_content = {use_skill, 62181},
		condition_list = [1000165, 1000172, 1000173, 1000174, 1000175, 1000176]
};

get(3000151) ->
	#bo_ai{
		no = 3000151,
		priority = 14,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,is_partner,phy_def_highest,act_speed_highest],
		action_content = {use_skill, 62176},
		condition_list = [1000162, 1000167]
};

get(3000152) ->
	#bo_ai{
		no = 3000152,
		priority = 16,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,is_partner,act_speed_highest,cur_hp_lowest],
		action_content = {use_skill, 62177},
		condition_list = [1000163, 1000169, 1000170, 1000152]
};

get(3000153) ->
	#bo_ai{
		no = 3000153,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4019,2}]},
		condition_list = [1000177, 1000178]
};

get(3000154) ->
	#bo_ai{
		no = 3000154,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000155) ->
	#bo_ai{
		no = 3000155,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [undead,sjjh_principle,is_not_under_control,enemy_side,is_partner],
		action_content = {use_skill, 62175},
		condition_list = [1000160, 1000152]
};

get(3000160) ->
	#bo_ai{
		no = 3000160,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,act_speed_lowest,cur_hp_lowest],
		action_content = {use_skill, 62191},
		condition_list = [1000180]
};

get(3000161) ->
	#bo_ai{
		no = 3000161,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [ally_side,undead, not_invisible_to_me, is_not_frozen,cur_hp_lowest],
		action_content = {use_skill, 62192},
		condition_list = [1000181, 1000187, 1000188]
};

get(3000162) ->
	#bo_ai{
		no = 3000162,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [ally_side,undead, not_invisible_to_me, is_not_frozen,cur_hp_lowest],
		action_content = {use_skill, 62193},
		condition_list = [1000182, 1000189, 1000190]
};

get(3000163) ->
	#bo_ai{
		no = 3000163,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,phy_def_highest,mag_def_highest,cur_hp_highest],
		action_content = {use_skill, 62194},
		condition_list = [1000183, 1000191]
};

get(3000164) ->
	#bo_ai{
		no = 3000164,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [ally_side,undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 62195},
		condition_list = [1000184, 1000192]
};

get(3000165) ->
	#bo_ai{
		no = 3000165,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,phy_def_highest,mag_def_highest],
		action_content = {use_skill, 62196},
		condition_list = [1000185, 1000193, 1000198]
};

get(3000166) ->
	#bo_ai{
		no = 3000166,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 62197},
		condition_list = [1000186, 1000194]
};

get(3000167) ->
	#bo_ai{
		no = 3000167,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4018,2}]},
		condition_list = [1000195, 1000196]
};

get(3000168) ->
	#bo_ai{
		no = 3000168,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000170) ->
	#bo_ai{
		no = 3000170,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_trance, is_partner,phy_att_highest,act_speed_highest],
		action_content = {use_skill,62169},
		condition_list = [1000086, 1000119]
};

get(3000171) ->
	#bo_ai{
		no = 3000171,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, is_partner,phy_def_highest, cur_hp_lowest],
		action_content = {use_skill,62168},
		condition_list = [1000121, 1000212, 1000152]
};

get(3000172) ->
	#bo_ai{
		no = 3000172,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[1]}],
		action_content = {use_skill,62169},
		condition_list = [1000113, 1000086]
};

get(3000173) ->
	#bo_ai{
		no = 3000173,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[4]}],
		action_content = {use_skill,62169},
		condition_list = [1000114, 1000086]
};

get(3000174) ->
	#bo_ai{
		no = 3000174,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[2]}],
		action_content = {use_skill,62169},
		condition_list = [1000115, 1000086]
};

get(3000175) ->
	#bo_ai{
		no = 3000175,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[5]}],
		action_content = {use_skill,62169},
		condition_list = [1000116, 1000086]
};

get(3000176) ->
	#bo_ai{
		no = 3000176,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[3]}],
		action_content = {use_skill,62169},
		condition_list = [1000117, 1000086]
};

get(3000177) ->
	#bo_ai{
		no = 3000177,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[6]}],
		action_content = {use_skill,62169},
		condition_list = [1000118, 1000086]
};

get(3000178) ->
	#bo_ai{
		no = 3000178,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_trance,cur_hp_lowest,phy_def_highest],
		action_content = {use_skill,62168},
		condition_list = [1000121, 1000212]
};

get(3000179) ->
	#bo_ai{
		no = 3000179,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4019,2}]},
		condition_list = [1000131, 1000141]
};

get(3000180) ->
	#bo_ai{
		no = 3000180,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000185) ->
	#bo_ai{
		no = 3000185,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, is_partner,cur_hp_lowest, mag_def_lowest, phy_att_lowest],
		action_content = {use_skill,400020},
		condition_list = [1000199]
};

get(3000186) ->
	#bo_ai{
		no = 3000186,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, mag_att_highest, phy_att_lowest, cur_hp_highest],
		action_content = {use_skill,400021},
		condition_list = [1000200]
};

get(3000200) ->
	#bo_ai{
		no = 3000200,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,act_speed_lowest,cur_hp_lowest],
		action_content = {use_skill, 62191},
		condition_list = [1000180]
};

get(3000201) ->
	#bo_ai{
		no = 3000201,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [ally_side,undead, not_invisible_to_me, is_not_frozen,cur_hp_lowest],
		action_content = {use_skill, 62192},
		condition_list = [1000181, 1000187, 1000188]
};

get(3000202) ->
	#bo_ai{
		no = 3000202,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [ally_side,undead, not_invisible_to_me, is_not_frozen,cur_hp_lowest],
		action_content = {use_skill, 62193},
		condition_list = [1000182, 1000189, 1000190]
};

get(3000203) ->
	#bo_ai{
		no = 3000203,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,phy_def_highest,mag_def_highest,cur_hp_highest],
		action_content = {use_skill, 62194},
		condition_list = [1000183, 1000191]
};

get(3000204) ->
	#bo_ai{
		no = 3000204,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [ally_side,undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill, 62195},
		condition_list = [1000184, 1000192]
};

get(3000205) ->
	#bo_ai{
		no = 3000205,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,phy_def_highest,mag_def_highest],
		action_content = {use_skill, 62196},
		condition_list = [1000185, 1000193, 1000198]
};

get(3000206) ->
	#bo_ai{
		no = 3000206,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 62197},
		condition_list = [1000186, 1000194]
};

get(3000207) ->
	#bo_ai{
		no = 3000207,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000201, 1000202]
};

get(3000208) ->
	#bo_ai{
		no = 3000208,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000209) ->
	#bo_ai{
		no = 3000209,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,act_speed_highest,seal_hit_highest],
		action_content = {use_skill,62170},
		condition_list = [1000092, 1000123]
};

get(3000210) ->
	#bo_ai{
		no = 3000210,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,is_partner,phy_att_highest,mag_att_highest],
		action_content = {use_skill,62170},
		condition_list = [1000092, 1000122, 1000125, 1000126, 1000127, 1000128, 1000129, 1000130]
};

get(3000211) ->
	#bo_ai{
		no = 3000211,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill,62173},
		condition_list = [1000095, 1000123, 1000124]
};

get(3000212) ->
	#bo_ai{
		no = 3000212,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,phy_att_highest,mag_att_highest,seal_hit_highest],
		action_content = {use_skill,62174},
		condition_list = [1000096, 1000125, 1000123]
};

get(3000213) ->
	#bo_ai{
		no = 3000213,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,cur_hp_highest, mag_att_highest],
		action_content = {use_skill,62172},
		condition_list = [1000093]
};

get(3000214) ->
	#bo_ai{
		no = 3000214,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000203, 1000204]
};

get(3000215) ->
	#bo_ai{
		no = 3000215,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4160},
		condition_list = []
};

get(3000216) ->
	#bo_ai{
		no = 3000216,
		priority = 12,
		weight = 100,
		rules_filter_action_target = [undead,sjjh_principle,is_not_under_control,enemy_side],
		action_content = {use_skill, 62175},
		condition_list = [1000160]
};

get(3000217) ->
	#bo_ai{
		no = 3000217,
		priority = 13,
		weight = 100,
		rules_filter_action_target = [ally_side, mag_att_highest,is_not_under_control,not_invisible_to_me,phy_att_highest],
		action_content = {use_skill, 62178},
		condition_list = [1000161, 1000166]
};

get(3000218) ->
	#bo_ai{
		no = 3000218,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,phy_def_highest,mag_def_highest],
		action_content = {use_skill, 62176},
		condition_list = [1000162, 1000167]
};

get(3000219) ->
	#bo_ai{
		no = 3000219,
		priority = 17,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,seal_hit_highest,act_speed_highest,cur_hp_highest],
		action_content = {use_skill, 62177},
		condition_list = [1000163, 1000169, 1000170]
};

get(3000220) ->
	#bo_ai{
		no = 3000220,
		priority = 18,
		weight = 100,
		rules_filter_action_target = [ally_side,is_not_under_control,not_invisible_to_me,cur_hp_highest],
		action_content = {use_skill, 62179},
		condition_list = [1000164, 1000171]
};

get(3000221) ->
	#bo_ai{
		no = 3000221,
		priority = 19,
		weight = 100,
		rules_filter_action_target = [ally_side,is_not_under_control,{pos_equal_to, 1},{pos_equal_to, 2},{pos_equal_to, 3},{pos_equal_to, 4},{pos_equal_to, 5}],
		action_content = {use_skill, 62181},
		condition_list = [1000165, 1000172, 1000173, 1000174, 1000175, 1000176]
};

get(3000222) ->
	#bo_ai{
		no = 3000222,
		priority = 14,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,is_partner,phy_def_highest,act_speed_highest],
		action_content = {use_skill, 62176},
		condition_list = [1000162, 1000167]
};

get(3000223) ->
	#bo_ai{
		no = 3000223,
		priority = 16,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,is_partner,act_speed_highest,cur_hp_lowest],
		action_content = {use_skill, 62177},
		condition_list = [1000163, 1000169, 1000170, 1000152]
};

get(3000224) ->
	#bo_ai{
		no = 3000224,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000203, 1000204]
};

get(3000225) ->
	#bo_ai{
		no = 3000225,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000226) ->
	#bo_ai{
		no = 3000226,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [undead,sjjh_principle,is_not_under_control,enemy_side,is_partner],
		action_content = {use_skill, 62175},
		condition_list = [1000160, 1000152]
};

get(3000227) ->
	#bo_ai{
		no = 3000227,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest, cur_hp_lowest, seal_hit_highest],
		action_content = {use_skill, 62188},
		condition_list = [1000145]
};

get(3000228) ->
	#bo_ai{
		no = 3000228,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest, cur_hp_lowest, seal_hit_highest],
		action_content = {use_skill, 62187},
		condition_list = [1000146, 1000149]
};

get(3000229) ->
	#bo_ai{
		no = 3000229,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_highest,seal_hit_highest,cur_hp_highest],
		action_content = {use_skill, 62190},
		condition_list = [1000147, 1000150, 1000154]
};

get(3000230) ->
	#bo_ai{
		no = 3000230,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 62189},
		condition_list = [1000148, 1000153, 1000150]
};

get(3000231) ->
	#bo_ai{
		no = 3000231,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest,act_speed_highest, is_partner],
		action_content = {use_skill, 62188},
		condition_list = [1000145, 1000152]
};

get(3000232) ->
	#bo_ai{
		no = 3000232,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest,act_speed_highest, is_partner],
		action_content = {use_skill, 62187},
		condition_list = [1000146, 1000149, 1000152]
};

get(3000233) ->
	#bo_ai{
		no = 3000233,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_highest,cur_hp_highest, is_partner],
		action_content = {use_skill, 62190},
		condition_list = [1000147, 1000150, 1000154, 1000152]
};

get(3000234) ->
	#bo_ai{
		no = 3000234,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000203, 1000204]
};

get(3000235) ->
	#bo_ai{
		no = 3000235,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000236) ->
	#bo_ai{
		no = 3000236,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_trance, is_partner,phy_att_highest,act_speed_highest],
		action_content = {use_skill,62169},
		condition_list = [1000086, 1000119]
};

get(3000237) ->
	#bo_ai{
		no = 3000237,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, is_partner,phy_def_highest, cur_hp_lowest],
		action_content = {use_skill,62168},
		condition_list = [1000121, 1000212, 1000152]
};

get(3000238) ->
	#bo_ai{
		no = 3000238,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[1]}],
		action_content = {use_skill,62169},
		condition_list = [1000113, 1000086]
};

get(3000239) ->
	#bo_ai{
		no = 3000239,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[4]}],
		action_content = {use_skill,62169},
		condition_list = [1000114, 1000086]
};

get(3000240) ->
	#bo_ai{
		no = 3000240,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[2]}],
		action_content = {use_skill,62169},
		condition_list = [1000115, 1000086]
};

get(3000241) ->
	#bo_ai{
		no = 3000241,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[5]}],
		action_content = {use_skill,62169},
		condition_list = [1000116, 1000086]
};

get(3000242) ->
	#bo_ai{
		no = 3000242,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[3]}],
		action_content = {use_skill,62169},
		condition_list = [1000117, 1000086]
};

get(3000243) ->
	#bo_ai{
		no = 3000243,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[6]}],
		action_content = {use_skill,62169},
		condition_list = [1000118, 1000086]
};

get(3000244) ->
	#bo_ai{
		no = 3000244,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_trance,cur_hp_lowest,phy_def_highest],
		action_content = {use_skill,62168},
		condition_list = [1000121, 1000212]
};

get(3000245) ->
	#bo_ai{
		no = 3000245,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000205, 1000206]
};

get(3000246) ->
	#bo_ai{
		no = 3000246,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000247) ->
	#bo_ai{
		no = 3000247,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,act_speed_highest,seal_hit_highest],
		action_content = {use_skill,62170},
		condition_list = [1000092, 1000123]
};

get(3000248) ->
	#bo_ai{
		no = 3000248,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,is_partner,phy_att_highest,mag_att_highest],
		action_content = {use_skill,62170},
		condition_list = [1000092, 1000122, 1000125, 1000126, 1000127, 1000128, 1000129, 1000130]
};

get(3000249) ->
	#bo_ai{
		no = 3000249,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill,62173},
		condition_list = [1000095, 1000123, 1000124]
};

get(3000250) ->
	#bo_ai{
		no = 3000250,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,phy_att_highest,mag_att_highest,seal_hit_highest],
		action_content = {use_skill,62174},
		condition_list = [1000096, 1000125, 1000123]
};

get(3000251) ->
	#bo_ai{
		no = 3000251,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,cur_hp_highest, mag_att_highest],
		action_content = {use_skill,62172},
		condition_list = [1000093]
};

get(3000252) ->
	#bo_ai{
		no = 3000252,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000205, 1000206]
};

get(3000253) ->
	#bo_ai{
		no = 3000253,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4160},
		condition_list = []
};

get(3000254) ->
	#bo_ai{
		no = 3000254,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_under_control],
		action_content = {use_skill, 400019},
		condition_list = [1000032]
};

get(3000255) ->
	#bo_ai{
		no = 3000255,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_use_skill, 4161},
		condition_list = []
};

get(3000256) ->
	#bo_ai{
		no = 3000256,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000205, 1000206]
};

get(3000257) ->
	#bo_ai{
		no = 3000257,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000258) ->
	#bo_ai{
		no = 3000258,
		priority = 12,
		weight = 100,
		rules_filter_action_target = [undead,sjjh_principle,is_not_under_control,enemy_side],
		action_content = {use_skill, 62175},
		condition_list = [1000160]
};

get(3000259) ->
	#bo_ai{
		no = 3000259,
		priority = 13,
		weight = 100,
		rules_filter_action_target = [ally_side, mag_att_highest,is_not_under_control,not_invisible_to_me,phy_att_highest],
		action_content = {use_skill, 62178},
		condition_list = [1000161, 1000166]
};

get(3000260) ->
	#bo_ai{
		no = 3000260,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,phy_def_highest,mag_def_highest],
		action_content = {use_skill, 62176},
		condition_list = [1000162, 1000167]
};

get(3000261) ->
	#bo_ai{
		no = 3000261,
		priority = 17,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,seal_hit_highest,act_speed_highest,cur_hp_highest],
		action_content = {use_skill, 62177},
		condition_list = [1000163, 1000169, 1000170]
};

get(3000262) ->
	#bo_ai{
		no = 3000262,
		priority = 18,
		weight = 100,
		rules_filter_action_target = [ally_side,is_not_under_control,not_invisible_to_me,cur_hp_highest],
		action_content = {use_skill, 62179},
		condition_list = [1000164, 1000171]
};

get(3000263) ->
	#bo_ai{
		no = 3000263,
		priority = 19,
		weight = 100,
		rules_filter_action_target = [ally_side,is_not_under_control,{pos_equal_to, 1},{pos_equal_to, 2},{pos_equal_to, 3},{pos_equal_to, 4},{pos_equal_to, 5}],
		action_content = {use_skill, 62181},
		condition_list = [1000165, 1000172, 1000173, 1000174, 1000175, 1000176]
};

get(3000264) ->
	#bo_ai{
		no = 3000264,
		priority = 14,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,is_partner,phy_def_highest,act_speed_highest],
		action_content = {use_skill, 62176},
		condition_list = [1000162, 1000167]
};

get(3000265) ->
	#bo_ai{
		no = 3000265,
		priority = 16,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,is_partner,act_speed_highest,cur_hp_lowest],
		action_content = {use_skill, 62177},
		condition_list = [1000163, 1000169, 1000170, 1000152]
};

get(3000266) ->
	#bo_ai{
		no = 3000266,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000205, 1000206]
};

get(3000267) ->
	#bo_ai{
		no = 3000267,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000268) ->
	#bo_ai{
		no = 3000268,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [undead,sjjh_principle,is_not_under_control,enemy_side,is_partner],
		action_content = {use_skill, 62175},
		condition_list = [1000160, 1000152]
};

get(3000269) ->
	#bo_ai{
		no = 3000269,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,cur_hp_highest, phy_def_highest],
		action_content = {use_skill,62183},
		condition_list = [1000097, 1000135]
};

get(3000270) ->
	#bo_ai{
		no = 3000270,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,cur_hp_highest, phy_def_highest],
		action_content = {use_skill,62184},
		condition_list = [1000099]
};

get(3000271) ->
	#bo_ai{
		no = 3000271,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,cur_hp_highest,mag_att_highest],
		action_content = {use_skill,62185},
		condition_list = [1000100, 1000137, 1000136]
};

get(3000272) ->
	#bo_ai{
		no = 3000272,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,cur_hp_highest,phy_att_highest],
		action_content = {use_skill,62183},
		condition_list = [1000097, 1000126, 1000127, 1000128, 1000129, 1000130]
};

get(3000273) ->
	#bo_ai{
		no = 3000273,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,cur_hp_highest],
		action_content = {use_skill,62184},
		condition_list = [1000099, 1000126, 1000127, 1000128, 1000129, 1000130]
};

get(3000274) ->
	#bo_ai{
		no = 3000274,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,cur_hp_highest, phy_def_highest],
		action_content = {use_skill,62185},
		condition_list = [1000100, 1000126, 1000127, 1000128, 1000129, 1000130, 1000137, 1000136]
};

get(3000275) ->
	#bo_ai{
		no = 3000275,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [enemy_side,{belong_to_faction,[3]}, {belong_to_faction,[3]},is_not_frozen ,is_trance],
		action_content = {use_skill,62186},
		condition_list = [1000101, 1000137, 1000138, 1000139]
};

get(3000276) ->
	#bo_ai{
		no = 3000276,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000207, 1000208]
};

get(3000277) ->
	#bo_ai{
		no = 3000277,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4160},
		condition_list = []
};

get(3000278) ->
	#bo_ai{
		no = 3000278,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest, cur_hp_lowest, seal_hit_highest],
		action_content = {use_skill, 62188},
		condition_list = [1000145]
};

get(3000279) ->
	#bo_ai{
		no = 3000279,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest, cur_hp_lowest, seal_hit_highest],
		action_content = {use_skill, 62187},
		condition_list = [1000146, 1000149]
};

get(3000280) ->
	#bo_ai{
		no = 3000280,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_highest,seal_hit_highest,cur_hp_highest],
		action_content = {use_skill, 62190},
		condition_list = [1000147, 1000150, 1000154]
};

get(3000281) ->
	#bo_ai{
		no = 3000281,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 62189},
		condition_list = [1000148, 1000153, 1000150]
};

get(3000282) ->
	#bo_ai{
		no = 3000282,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest,act_speed_highest, is_partner],
		action_content = {use_skill, 62188},
		condition_list = [1000145, 1000152]
};

get(3000283) ->
	#bo_ai{
		no = 3000283,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest,act_speed_highest, is_partner],
		action_content = {use_skill, 62187},
		condition_list = [1000146, 1000149, 1000152]
};

get(3000284) ->
	#bo_ai{
		no = 3000284,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_highest,cur_hp_highest, is_partner],
		action_content = {use_skill, 62190},
		condition_list = [1000147, 1000150, 1000154, 1000152]
};

get(3000285) ->
	#bo_ai{
		no = 3000285,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000207, 1000208]
};

get(3000286) ->
	#bo_ai{
		no = 3000286,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000287) ->
	#bo_ai{
		no = 3000287,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_under_control],
		action_content = {use_skill, 400019},
		condition_list = [1000032]
};

get(3000288) ->
	#bo_ai{
		no = 3000288,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_use_skill, 4161},
		condition_list = []
};

get(3000289) ->
	#bo_ai{
		no = 3000289,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000207, 1000208]
};

get(3000290) ->
	#bo_ai{
		no = 3000290,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000291) ->
	#bo_ai{
		no = 3000291,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_trance, is_partner,phy_att_highest,act_speed_highest],
		action_content = {use_skill,62169},
		condition_list = [1000086, 1000119]
};

get(3000292) ->
	#bo_ai{
		no = 3000292,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, is_partner,phy_def_highest, cur_hp_lowest],
		action_content = {use_skill,62168},
		condition_list = [1000121, 1000212, 1000152]
};

get(3000293) ->
	#bo_ai{
		no = 3000293,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[1]}],
		action_content = {use_skill,62169},
		condition_list = [1000113, 1000086]
};

get(3000294) ->
	#bo_ai{
		no = 3000294,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[4]}],
		action_content = {use_skill,62169},
		condition_list = [1000114, 1000086]
};

get(3000295) ->
	#bo_ai{
		no = 3000295,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[2]}],
		action_content = {use_skill,62169},
		condition_list = [1000115, 1000086]
};

get(3000296) ->
	#bo_ai{
		no = 3000296,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[5]}],
		action_content = {use_skill,62169},
		condition_list = [1000116, 1000086]
};

get(3000297) ->
	#bo_ai{
		no = 3000297,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[3]}],
		action_content = {use_skill,62169},
		condition_list = [1000117, 1000086]
};

get(3000298) ->
	#bo_ai{
		no = 3000298,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[6]}],
		action_content = {use_skill,62169},
		condition_list = [1000118, 1000086]
};

get(3000299) ->
	#bo_ai{
		no = 3000299,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_trance,cur_hp_lowest,phy_def_highest],
		action_content = {use_skill,62168},
		condition_list = [1000121, 1000212]
};

get(3000300) ->
	#bo_ai{
		no = 3000300,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000207, 1000208]
};

get(3000301) ->
	#bo_ai{
		no = 3000301,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000302) ->
	#bo_ai{
		no = 3000302,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest, cur_hp_lowest, seal_hit_highest],
		action_content = {use_skill, 62188},
		condition_list = [1000145]
};

get(3000303) ->
	#bo_ai{
		no = 3000303,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest, cur_hp_lowest, seal_hit_highest],
		action_content = {use_skill, 62187},
		condition_list = [1000146, 1000149]
};

get(3000304) ->
	#bo_ai{
		no = 3000304,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_highest,seal_hit_highest,cur_hp_highest],
		action_content = {use_skill, 62190},
		condition_list = [1000147, 1000150, 1000154]
};

get(3000305) ->
	#bo_ai{
		no = 3000305,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 62189},
		condition_list = [1000148, 1000153, 1000150]
};

get(3000306) ->
	#bo_ai{
		no = 3000306,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest,act_speed_highest, is_partner],
		action_content = {use_skill, 62188},
		condition_list = [1000145, 1000152]
};

get(3000307) ->
	#bo_ai{
		no = 3000307,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest,act_speed_highest, is_partner],
		action_content = {use_skill, 62187},
		condition_list = [1000146, 1000149, 1000152]
};

get(3000308) ->
	#bo_ai{
		no = 3000308,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_highest,cur_hp_highest, is_partner],
		action_content = {use_skill, 62190},
		condition_list = [1000147, 1000150, 1000154, 1000152]
};

get(3000309) ->
	#bo_ai{
		no = 3000309,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000209]
};

get(3000310) ->
	#bo_ai{
		no = 3000310,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000311) ->
	#bo_ai{
		no = 3000311,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_under_control],
		action_content = {use_skill, 400019},
		condition_list = [1000032]
};

get(3000312) ->
	#bo_ai{
		no = 3000312,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_use_skill, 4161},
		condition_list = []
};

get(3000313) ->
	#bo_ai{
		no = 3000313,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000209]
};

get(3000314) ->
	#bo_ai{
		no = 3000314,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000315) ->
	#bo_ai{
		no = 3000315,
		priority = 12,
		weight = 100,
		rules_filter_action_target = [undead,sjjh_principle,is_not_under_control,enemy_side],
		action_content = {use_skill, 62175},
		condition_list = [1000160]
};

get(3000316) ->
	#bo_ai{
		no = 3000316,
		priority = 13,
		weight = 100,
		rules_filter_action_target = [ally_side, mag_att_highest,is_not_under_control,not_invisible_to_me,phy_att_highest],
		action_content = {use_skill, 62178},
		condition_list = [1000161, 1000166]
};

get(3000317) ->
	#bo_ai{
		no = 3000317,
		priority = 15,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,phy_def_highest,mag_def_highest],
		action_content = {use_skill, 62176},
		condition_list = [1000162, 1000167]
};

get(3000318) ->
	#bo_ai{
		no = 3000318,
		priority = 17,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,seal_hit_highest,act_speed_highest,cur_hp_highest],
		action_content = {use_skill, 62177},
		condition_list = [1000163, 1000169, 1000170]
};

get(3000319) ->
	#bo_ai{
		no = 3000319,
		priority = 18,
		weight = 100,
		rules_filter_action_target = [ally_side,is_not_under_control,not_invisible_to_me,cur_hp_highest],
		action_content = {use_skill, 62179},
		condition_list = [1000164, 1000171]
};

get(3000320) ->
	#bo_ai{
		no = 3000320,
		priority = 19,
		weight = 100,
		rules_filter_action_target = [ally_side,is_not_under_control,{pos_equal_to, 1},{pos_equal_to, 2},{pos_equal_to, 3},{pos_equal_to, 4},{pos_equal_to, 5}],
		action_content = {use_skill, 62181},
		condition_list = [1000165, 1000172, 1000173, 1000174, 1000175, 1000176]
};

get(3000321) ->
	#bo_ai{
		no = 3000321,
		priority = 14,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,is_partner,phy_def_highest,act_speed_highest],
		action_content = {use_skill, 62176},
		condition_list = [1000162, 1000167]
};

get(3000322) ->
	#bo_ai{
		no = 3000322,
		priority = 16,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,is_partner,act_speed_highest,cur_hp_lowest],
		action_content = {use_skill, 62177},
		condition_list = [1000163, 1000169, 1000170, 1000152]
};

get(3000323) ->
	#bo_ai{
		no = 3000323,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000209]
};

get(3000324) ->
	#bo_ai{
		no = 3000324,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000325) ->
	#bo_ai{
		no = 3000325,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [undead,sjjh_principle,is_not_under_control,enemy_side,is_partner],
		action_content = {use_skill, 62175},
		condition_list = [1000160, 1000152]
};

get(3000326) ->
	#bo_ai{
		no = 3000326,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_trance, is_partner,phy_att_highest,act_speed_highest],
		action_content = {use_skill,62169},
		condition_list = [1000086, 1000119]
};

get(3000327) ->
	#bo_ai{
		no = 3000327,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, is_partner,phy_def_highest, cur_hp_lowest],
		action_content = {use_skill,62168},
		condition_list = [1000121, 1000212, 1000152]
};

get(3000328) ->
	#bo_ai{
		no = 3000328,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[1]}],
		action_content = {use_skill,62169},
		condition_list = [1000113, 1000086]
};

get(3000329) ->
	#bo_ai{
		no = 3000329,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[4]}],
		action_content = {use_skill,62169},
		condition_list = [1000114, 1000086]
};

get(3000330) ->
	#bo_ai{
		no = 3000330,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[2]}],
		action_content = {use_skill,62169},
		condition_list = [1000115, 1000086]
};

get(3000331) ->
	#bo_ai{
		no = 3000331,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[5]}],
		action_content = {use_skill,62169},
		condition_list = [1000116, 1000086]
};

get(3000332) ->
	#bo_ai{
		no = 3000332,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[3]}],
		action_content = {use_skill,62169},
		condition_list = [1000117, 1000086]
};

get(3000333) ->
	#bo_ai{
		no = 3000333,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[6]}],
		action_content = {use_skill,62169},
		condition_list = [1000118, 1000086]
};

get(3000334) ->
	#bo_ai{
		no = 3000334,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_trance,cur_hp_lowest,phy_def_highest],
		action_content = {use_skill,62168},
		condition_list = [1000121, 1000212]
};

get(3000335) ->
	#bo_ai{
		no = 3000335,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000209]
};

get(3000336) ->
	#bo_ai{
		no = 3000336,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000337) ->
	#bo_ai{
		no = 3000337,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest, cur_hp_lowest, seal_hit_highest],
		action_content = {use_skill, 62188},
		condition_list = [1000145]
};

get(3000338) ->
	#bo_ai{
		no = 3000338,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest, cur_hp_lowest, seal_hit_highest],
		action_content = {use_skill, 62187},
		condition_list = [1000146, 1000149]
};

get(3000339) ->
	#bo_ai{
		no = 3000339,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_highest,seal_hit_highest,cur_hp_highest],
		action_content = {use_skill, 62190},
		condition_list = [1000147, 1000150, 1000154]
};

get(3000340) ->
	#bo_ai{
		no = 3000340,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill, 62189},
		condition_list = [1000148, 1000153, 1000150]
};

get(3000341) ->
	#bo_ai{
		no = 3000341,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest,act_speed_highest, is_partner],
		action_content = {use_skill, 62188},
		condition_list = [1000145, 1000152]
};

get(3000342) ->
	#bo_ai{
		no = 3000342,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_lowest,act_speed_highest, is_partner],
		action_content = {use_skill, 62187},
		condition_list = [1000146, 1000149, 1000152]
};

get(3000343) ->
	#bo_ai{
		no = 3000343,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,enemy_side,mag_def_highest,cur_hp_highest, is_partner],
		action_content = {use_skill, 62190},
		condition_list = [1000147, 1000150, 1000154, 1000152]
};

get(3000344) ->
	#bo_ai{
		no = 3000344,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000210]
};

get(3000345) ->
	#bo_ai{
		no = 3000345,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000346) ->
	#bo_ai{
		no = 3000346,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,act_speed_highest,seal_hit_highest],
		action_content = {use_skill,62170},
		condition_list = [1000092, 1000123]
};

get(3000347) ->
	#bo_ai{
		no = 3000347,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,is_partner,phy_att_highest,mag_att_highest],
		action_content = {use_skill,62170},
		condition_list = [1000092, 1000122, 1000125, 1000126, 1000127, 1000128, 1000129, 1000130]
};

get(3000348) ->
	#bo_ai{
		no = 3000348,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [myself],
		action_content = {use_skill,62173},
		condition_list = [1000095, 1000123, 1000124]
};

get(3000349) ->
	#bo_ai{
		no = 3000349,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,phy_att_highest,mag_att_highest,seal_hit_highest],
		action_content = {use_skill,62174},
		condition_list = [1000096, 1000125, 1000123]
};

get(3000350) ->
	#bo_ai{
		no = 3000350,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side,cur_hp_highest, mag_att_highest],
		action_content = {use_skill,62172},
		condition_list = [1000093]
};

get(3000351) ->
	#bo_ai{
		no = 3000351,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000210]
};

get(3000352) ->
	#bo_ai{
		no = 3000352,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4160},
		condition_list = []
};

get(3000353) ->
	#bo_ai{
		no = 3000353,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [undead, ally_side, is_under_control],
		action_content = {use_skill, 400019},
		condition_list = [1000032]
};

get(3000354) ->
	#bo_ai{
		no = 3000354,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_use_skill, 4161},
		condition_list = []
};

get(3000355) ->
	#bo_ai{
		no = 3000355,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000210]
};

get(3000356) ->
	#bo_ai{
		no = 3000356,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4162},
		condition_list = []
};

get(3000357) ->
	#bo_ai{
		no = 3000357,
		priority = 4,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,cur_hp_highest, phy_def_highest],
		action_content = {use_skill,62183},
		condition_list = [1000097, 1000135]
};

get(3000358) ->
	#bo_ai{
		no = 3000358,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,cur_hp_highest, phy_def_highest],
		action_content = {use_skill,62184},
		condition_list = [1000099]
};

get(3000359) ->
	#bo_ai{
		no = 3000359,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,cur_hp_highest,mag_att_highest],
		action_content = {use_skill,62185},
		condition_list = [1000100, 1000137, 1000136]
};

get(3000360) ->
	#bo_ai{
		no = 3000360,
		priority = 3,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,cur_hp_highest,phy_att_highest],
		action_content = {use_skill,62183},
		condition_list = [1000097, 1000126, 1000127, 1000128, 1000129, 1000130]
};

get(3000361) ->
	#bo_ai{
		no = 3000361,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,is_partner,cur_hp_highest],
		action_content = {use_skill,62184},
		condition_list = [1000099, 1000126, 1000127, 1000128, 1000129, 1000130]
};

get(3000362) ->
	#bo_ai{
		no = 3000362,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [undead, not_invisible_to_me, is_not_frozen,  enemy_side,cur_hp_highest, phy_def_highest],
		action_content = {use_skill,62185},
		condition_list = [1000100, 1000126, 1000127, 1000128, 1000129, 1000130, 1000137, 1000136]
};

get(3000363) ->
	#bo_ai{
		no = 3000363,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [enemy_side,{belong_to_faction,[3]}, {belong_to_faction,[3]},is_not_frozen ,is_trance],
		action_content = {use_skill,62186},
		condition_list = [1000101, 1000137, 1000138, 1000139]
};

get(3000364) ->
	#bo_ai{
		no = 3000364,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {summon_mon,[{4098,2}]},
		condition_list = [1000210]
};

get(3000365) ->
	#bo_ai{
		no = 3000365,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_summon, 4160},
		condition_list = []
};

get(3000366) ->
	#bo_ai{
		no = 3000366,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control,cur_hp_lowest, mag_def_lowest, phy_att_lowest],
		action_content = {use_skill,400022},
		condition_list = [1000211]
};

get(3000367) ->
	#bo_ai{
		no = 3000367,
		priority = 11,
		weight = 100,
		rules_filter_action_target = [ally_side,undead, not_invisible_to_me, is_not_frozen],
		action_content = {use_skill,62199},
		condition_list = [1000213, 1000214]
};

get(3000368) ->
	#bo_ai{
		no = 3000368,
		priority = 2,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_trance, is_partner,phy_att_highest,act_speed_highest],
		action_content = {use_skill,62169},
		condition_list = [1000086, 1000119]
};

get(3000369) ->
	#bo_ai{
		no = 3000369,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, is_partner,phy_def_highest, cur_hp_lowest],
		action_content = {use_skill,62168},
		condition_list = [1000121, 1000212, 1000152]
};

get(3000370) ->
	#bo_ai{
		no = 3000370,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[1]}],
		action_content = {use_skill,62169},
		condition_list = [1000113, 1000086]
};

get(3000371) ->
	#bo_ai{
		no = 3000371,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[4]}],
		action_content = {use_skill,62169},
		condition_list = [1000114, 1000086]
};

get(3000372) ->
	#bo_ai{
		no = 3000372,
		priority = 8,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[2]}],
		action_content = {use_skill,62169},
		condition_list = [1000115, 1000086]
};

get(3000373) ->
	#bo_ai{
		no = 3000373,
		priority = 7,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[5]}],
		action_content = {use_skill,62169},
		condition_list = [1000116, 1000086]
};

get(3000374) ->
	#bo_ai{
		no = 3000374,
		priority = 6,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[3]}],
		action_content = {use_skill,62169},
		condition_list = [1000117, 1000086]
};

get(3000375) ->
	#bo_ai{
		no = 3000375,
		priority = 5,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_not_under_control, {belong_to_faction,[6]}],
		action_content = {use_skill,62169},
		condition_list = [1000118, 1000086]
};

get(3000376) ->
	#bo_ai{
		no = 3000376,
		priority = 1,
		weight = 100,
		rules_filter_action_target = [enemy_side,undead,is_trance,cur_hp_lowest,phy_def_highest],
		action_content = {use_skill,62168},
		condition_list = [1000121, 1000212]
};

get(1004074) ->
	#bo_ai{
		no = 1004074,
		priority = 20,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_escape, 4024},
		condition_list = []
};

get(2000000) ->
	#bo_ai{
		no = 2000000,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4025},
		condition_list = []
};

get(2000001) ->
	#bo_ai{
		no = 2000001,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4026},
		condition_list = []
};

get(2000002) ->
	#bo_ai{
		no = 2000002,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4027},
		condition_list = []
};

get(2000003) ->
	#bo_ai{
		no = 2000003,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4028},
		condition_list = []
};

get(2000004) ->
	#bo_ai{
		no = 2000004,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4029},
		condition_list = []
};

get(2000005) ->
	#bo_ai{
		no = 2000005,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4030},
		condition_list = []
};

get(2000006) ->
	#bo_ai{
		no = 2000006,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4031},
		condition_list = []
};

get(2000007) ->
	#bo_ai{
		no = 2000007,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4032},
		condition_list = []
};

get(2000008) ->
	#bo_ai{
		no = 2000008,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4033},
		condition_list = []
};

get(2000009) ->
	#bo_ai{
		no = 2000009,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4034},
		condition_list = []
};

get(2000010) ->
	#bo_ai{
		no = 2000010,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4035},
		condition_list = []
};

get(2000011) ->
	#bo_ai{
		no = 2000011,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4036},
		condition_list = []
};

get(2000012) ->
	#bo_ai{
		no = 2000012,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4037},
		condition_list = []
};

get(2000013) ->
	#bo_ai{
		no = 2000013,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4038},
		condition_list = []
};

get(2000014) ->
	#bo_ai{
		no = 2000014,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4039},
		condition_list = []
};

get(2000015) ->
	#bo_ai{
		no = 2000015,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4040},
		condition_list = []
};

get(2000016) ->
	#bo_ai{
		no = 2000016,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4041},
		condition_list = []
};

get(2000017) ->
	#bo_ai{
		no = 2000017,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4042},
		condition_list = []
};

get(2000018) ->
	#bo_ai{
		no = 2000018,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4043},
		condition_list = []
};

get(2000019) ->
	#bo_ai{
		no = 2000019,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4044},
		condition_list = []
};

get(2000020) ->
	#bo_ai{
		no = 2000020,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4045},
		condition_list = []
};

get(2000021) ->
	#bo_ai{
		no = 2000021,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4046},
		condition_list = []
};

get(2000022) ->
	#bo_ai{
		no = 2000022,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4047},
		condition_list = []
};

get(2000023) ->
	#bo_ai{
		no = 2000023,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4048},
		condition_list = []
};

get(2000024) ->
	#bo_ai{
		no = 2000024,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4049},
		condition_list = []
};

get(2000025) ->
	#bo_ai{
		no = 2000025,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4050},
		condition_list = []
};

get(2000026) ->
	#bo_ai{
		no = 2000026,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4051},
		condition_list = []
};

get(2000027) ->
	#bo_ai{
		no = 2000027,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4052},
		condition_list = []
};

get(2000028) ->
	#bo_ai{
		no = 2000028,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4053},
		condition_list = []
};

get(2000029) ->
	#bo_ai{
		no = 2000029,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4054},
		condition_list = []
};

get(2000030) ->
	#bo_ai{
		no = 2000030,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4055},
		condition_list = []
};

get(2000031) ->
	#bo_ai{
		no = 2000031,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4056},
		condition_list = []
};

get(2000032) ->
	#bo_ai{
		no = 2000032,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4057},
		condition_list = []
};

get(2000033) ->
	#bo_ai{
		no = 2000033,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4058},
		condition_list = []
};

get(2000034) ->
	#bo_ai{
		no = 2000034,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4059},
		condition_list = []
};

get(2000035) ->
	#bo_ai{
		no = 2000035,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4060},
		condition_list = []
};

get(2000036) ->
	#bo_ai{
		no = 2000036,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4061},
		condition_list = []
};

get(2000037) ->
	#bo_ai{
		no = 2000037,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4062},
		condition_list = []
};

get(2000038) ->
	#bo_ai{
		no = 2000038,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4063},
		condition_list = []
};

get(2000039) ->
	#bo_ai{
		no = 2000039,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4064},
		condition_list = []
};

get(2000040) ->
	#bo_ai{
		no = 2000040,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4065},
		condition_list = []
};

get(2000041) ->
	#bo_ai{
		no = 2000041,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4066},
		condition_list = []
};

get(2000042) ->
	#bo_ai{
		no = 2000042,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4067},
		condition_list = []
};

get(2000043) ->
	#bo_ai{
		no = 2000043,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4068},
		condition_list = []
};

get(2000044) ->
	#bo_ai{
		no = 2000044,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4069},
		condition_list = []
};

get(2000045) ->
	#bo_ai{
		no = 2000045,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4070},
		condition_list = []
};

get(2000046) ->
	#bo_ai{
		no = 2000046,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4071},
		condition_list = []
};

get(2000047) ->
	#bo_ai{
		no = 2000047,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4072},
		condition_list = []
};

get(2000048) ->
	#bo_ai{
		no = 2000048,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4073},
		condition_list = []
};

get(2000049) ->
	#bo_ai{
		no = 2000049,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4074},
		condition_list = []
};

get(2000050) ->
	#bo_ai{
		no = 2000050,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4075},
		condition_list = []
};

get(2000051) ->
	#bo_ai{
		no = 2000051,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4076},
		condition_list = []
};

get(2000052) ->
	#bo_ai{
		no = 2000052,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4077},
		condition_list = []
};

get(2000053) ->
	#bo_ai{
		no = 2000053,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4078},
		condition_list = []
};

get(2000054) ->
	#bo_ai{
		no = 2000054,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4079},
		condition_list = []
};

get(2000055) ->
	#bo_ai{
		no = 2000055,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4080},
		condition_list = []
};

get(2000056) ->
	#bo_ai{
		no = 2000056,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4081},
		condition_list = []
};

get(2000057) ->
	#bo_ai{
		no = 2000057,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4082},
		condition_list = []
};

get(2000058) ->
	#bo_ai{
		no = 2000058,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4083},
		condition_list = []
};

get(2000059) ->
	#bo_ai{
		no = 2000059,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4084},
		condition_list = []
};

get(2000060) ->
	#bo_ai{
		no = 2000060,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4085},
		condition_list = []
};

get(2000061) ->
	#bo_ai{
		no = 2000061,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4086},
		condition_list = []
};

get(2000062) ->
	#bo_ai{
		no = 2000062,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4087},
		condition_list = []
};

get(2000063) ->
	#bo_ai{
		no = 2000063,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4088},
		condition_list = []
};

get(2000064) ->
	#bo_ai{
		no = 2000064,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4089},
		condition_list = []
};

get(2000065) ->
	#bo_ai{
		no = 2000065,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4090},
		condition_list = []
};

get(2000066) ->
	#bo_ai{
		no = 2000066,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4091},
		condition_list = []
};

get(2000067) ->
	#bo_ai{
		no = 2000067,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4092},
		condition_list = []
};

get(2000068) ->
	#bo_ai{
		no = 2000068,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4093},
		condition_list = []
};

get(2000069) ->
	#bo_ai{
		no = 2000069,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4094},
		condition_list = []
};

get(2000070) ->
	#bo_ai{
		no = 2000070,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4095},
		condition_list = []
};

get(2000071) ->
	#bo_ai{
		no = 2000071,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4096},
		condition_list = []
};

get(2000072) ->
	#bo_ai{
		no = 2000072,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4097},
		condition_list = []
};

get(2000073) ->
	#bo_ai{
		no = 2000073,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4098},
		condition_list = []
};

get(2000074) ->
	#bo_ai{
		no = 2000074,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4099},
		condition_list = []
};

get(2000075) ->
	#bo_ai{
		no = 2000075,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4100},
		condition_list = []
};

get(2000076) ->
	#bo_ai{
		no = 2000076,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4101},
		condition_list = []
};

get(2000077) ->
	#bo_ai{
		no = 2000077,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4102},
		condition_list = []
};

get(2000078) ->
	#bo_ai{
		no = 2000078,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4103},
		condition_list = []
};

get(2000079) ->
	#bo_ai{
		no = 2000079,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4104},
		condition_list = []
};

get(2000080) ->
	#bo_ai{
		no = 2000080,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4105},
		condition_list = []
};

get(2000081) ->
	#bo_ai{
		no = 2000081,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4106},
		condition_list = []
};

get(2000082) ->
	#bo_ai{
		no = 2000082,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4107},
		condition_list = []
};

get(2000083) ->
	#bo_ai{
		no = 2000083,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4108},
		condition_list = []
};

get(2000084) ->
	#bo_ai{
		no = 2000084,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4109},
		condition_list = []
};

get(2000085) ->
	#bo_ai{
		no = 2000085,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4110},
		condition_list = []
};

get(2000086) ->
	#bo_ai{
		no = 2000086,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4111},
		condition_list = []
};

get(2000087) ->
	#bo_ai{
		no = 2000087,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4112},
		condition_list = []
};

get(2000088) ->
	#bo_ai{
		no = 2000088,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4113},
		condition_list = []
};

get(2000089) ->
	#bo_ai{
		no = 2000089,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4114},
		condition_list = []
};

get(2000090) ->
	#bo_ai{
		no = 2000090,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4115},
		condition_list = []
};

get(2000091) ->
	#bo_ai{
		no = 2000091,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4116},
		condition_list = []
};

get(2000092) ->
	#bo_ai{
		no = 2000092,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4117},
		condition_list = []
};

get(2000093) ->
	#bo_ai{
		no = 2000093,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4118},
		condition_list = []
};

get(2000094) ->
	#bo_ai{
		no = 2000094,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4119},
		condition_list = []
};

get(2000095) ->
	#bo_ai{
		no = 2000095,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4120},
		condition_list = []
};

get(2000096) ->
	#bo_ai{
		no = 2000096,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4121},
		condition_list = []
};

get(2000097) ->
	#bo_ai{
		no = 2000097,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4122},
		condition_list = []
};

get(2000098) ->
	#bo_ai{
		no = 2000098,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4123},
		condition_list = []
};

get(2000099) ->
	#bo_ai{
		no = 2000099,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4124},
		condition_list = []
};

get(2000100) ->
	#bo_ai{
		no = 2000100,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4125},
		condition_list = []
};

get(2000101) ->
	#bo_ai{
		no = 2000101,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4126},
		condition_list = []
};

get(2000102) ->
	#bo_ai{
		no = 2000102,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4127},
		condition_list = []
};

get(2000103) ->
	#bo_ai{
		no = 2000103,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4128},
		condition_list = []
};

get(2000104) ->
	#bo_ai{
		no = 2000104,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4129},
		condition_list = []
};

get(2000105) ->
	#bo_ai{
		no = 2000105,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4130},
		condition_list = []
};

get(2000106) ->
	#bo_ai{
		no = 2000106,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4131},
		condition_list = []
};

get(2000107) ->
	#bo_ai{
		no = 2000107,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4132},
		condition_list = []
};

get(2000108) ->
	#bo_ai{
		no = 2000108,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4133},
		condition_list = []
};

get(2000109) ->
	#bo_ai{
		no = 2000109,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4134},
		condition_list = []
};

get(2000110) ->
	#bo_ai{
		no = 2000110,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4135},
		condition_list = []
};

get(2000111) ->
	#bo_ai{
		no = 2000111,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4136},
		condition_list = []
};

get(2000112) ->
	#bo_ai{
		no = 2000112,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4137},
		condition_list = []
};

get(2000113) ->
	#bo_ai{
		no = 2000113,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4138},
		condition_list = []
};

get(2000114) ->
	#bo_ai{
		no = 2000114,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4139},
		condition_list = []
};

get(2000115) ->
	#bo_ai{
		no = 2000115,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4140},
		condition_list = []
};

get(2000116) ->
	#bo_ai{
		no = 2000116,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4141},
		condition_list = []
};

get(2000117) ->
	#bo_ai{
		no = 2000117,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4142},
		condition_list = []
};

get(2000118) ->
	#bo_ai{
		no = 2000118,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4143},
		condition_list = []
};

get(2000119) ->
	#bo_ai{
		no = 2000119,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4144},
		condition_list = []
};

get(2000120) ->
	#bo_ai{
		no = 2000120,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4145},
		condition_list = []
};

get(2000121) ->
	#bo_ai{
		no = 2000121,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4146},
		condition_list = []
};

get(2000122) ->
	#bo_ai{
		no = 2000122,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4147},
		condition_list = []
};

get(2000123) ->
	#bo_ai{
		no = 2000123,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4148},
		condition_list = []
};

get(2000124) ->
	#bo_ai{
		no = 2000124,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4149},
		condition_list = []
};

get(2000125) ->
	#bo_ai{
		no = 2000125,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4150},
		condition_list = []
};

get(2000126) ->
	#bo_ai{
		no = 2000126,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4151},
		condition_list = []
};

get(2000127) ->
	#bo_ai{
		no = 2000127,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4152},
		condition_list = []
};

get(2000128) ->
	#bo_ai{
		no = 2000128,
		priority = 10,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_round_begin, 4153},
		condition_list = []
};

get(2000129) ->
	#bo_ai{
		no = 2000129,
		priority = 9,
		weight = 100,
		rules_filter_action_target = [],
		action_content = {talk, on_act, 4154},
		condition_list = []
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

