%%%---------------------------------------
%%% @Module  : data_AI_condition
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description:  战斗单位AI的条件
%%%---------------------------------------


-module(data_AI_condition).
-export([get/1]).

-include("battle_AI.hrl").
-include("debug.hrl").


get(1) ->
	#ai_cond{
		no = 1,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,0},
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [undead, enemy_side, not_invisible_to_me, is_not_frozen, mag_def_highest],
		attr_R = mag_def,
		addi_value_R = {"+",0}
};

get(2) ->
	#ai_cond{
		no = 2,
		rules_filter_bo_L = [undead, not_invisible_to_me, enemy_side, {cur_mp_higher_than, 5}, cur_mp_lowest],
		attr_L = cur_mp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",35}
};

get(3) ->
	#ai_cond{
		no = 3,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, phy_def_highest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.5}
};

get(4) ->
	#ai_cond{
		no = 4,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, phy_def_highest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",1.5}
};

get(5) ->
	#ai_cond{
		no = 5,
		rules_filter_bo_L = [undead, enemy_side, not_invisible_to_me, {has_not_spec_no_buff, 1001}, is_not_frozen, phy_def_highest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [undead, enemy_side, not_invisible_to_me, is_not_frozen, mag_def_highest],
		attr_R = mag_def,
		addi_value_R = {"+",0}
};

get(6) ->
	#ai_cond{
		no = 6,
		rules_filter_bo_L = [undead, enemy_side, not_invisible_to_me, is_not_frozen, phy_def_highest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [undead, enemy_side, not_invisible_to_me, is_not_frozen, mag_def_highest],
		attr_R = mag_def,
		addi_value_R = {"+",0}
};

get(7) ->
	#ai_cond{
		no = 7,
		rules_filter_bo_L = [my_owner],
		attr_L = is_fallen,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(8) ->
	#ai_cond{
		no = 8,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_under_control, is_monster, phy_att_highest],
		attr_L = mag_att,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [enemy_side, undead, not_invisible_to_me, is_not_under_control, is_monster, mag_att_highest],
		attr_R = phy_att,
		addi_value_R = {"*",0.8}
};

get(9) ->
	#ai_cond{
		no = 9,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_under_control, is_monster, mag_att_highest],
		attr_L = mag_att,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [enemy_side, undead, not_invisible_to_me, is_not_under_control, is_monster, phy_att_highest],
		attr_R = phy_att,
		addi_value_R = {"*",0.8}
};

get(10) ->
	#ai_cond{
		no = 10,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(11) ->
	#ai_cond{
		no = 11,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, phy_def_lowest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.65}
};

get(12) ->
	#ai_cond{
		no = 12,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, {cur_hp_percentage_lower_than, 50}, is_not_frozen, cur_hp_lowest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.8}
};

get(13) ->
	#ai_cond{
		no = 13,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",30}
};

get(14) ->
	#ai_cond{
		no = 14,
		rules_filter_bo_L = [undead, not_invisible_to_me, enemy_side, is_not_frozen, phy_def_highest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",1.2}
};

get(15) ->
	#ai_cond{
		no = 15,
		rules_filter_bo_L = [undead, not_invisible_to_me, enemy_side, is_not_frozen, phy_def_highest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.6}
};

get(16) ->
	#ai_cond{
		no = 16,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 10}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(17) ->
	#ai_cond{
		no = 17,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, {has_not_spec_no_buff, 11}, is_not_frozen, mag_def_highest],
		attr_L = is_undead,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(18) ->
	#ai_cond{
		no = 18,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control, cur_hp_lowest],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [myself],
		attr_R = cur_hp_percentage,
		addi_value_R = {"+",25}
};

get(19) ->
	#ai_cond{
		no = 19,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 12}],
		attr_L = is_undead,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(20) ->
	#ai_cond{
		no = 20,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.75}
};

get(21) ->
	#ai_cond{
		no = 21,
		rules_filter_bo_L = [myself, {cur_hp_percentage_lower_than, 50}, {cur_hp_percentage_higher_than, 7}],
		attr_L = is_undead,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(22) ->
	#ai_cond{
		no = 22,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 13}],
		attr_L = is_undead,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(23) ->
	#ai_cond{
		no = 23,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control, cur_hp_lowest],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [myself],
		attr_R = cur_hp_percentage,
		addi_value_R = {"+",25}
};

get(24) ->
	#ai_cond{
		no = 24,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control, not_invisible_to_me, {cur_hp_percentage_lower_than, 15}, is_not_frozen],
		attr_L = mag_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = mag_att,
		addi_value_R = {"*",0.65}
};

get(25) ->
	#ai_cond{
		no = 25,
		rules_filter_bo_L = [ally_side, {belong_to_faction, 1}, undead],
		attr_L = is_undead,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(26) ->
	#ai_cond{
		no = 26,
		rules_filter_bo_L = [enemy_side, undead, {has_not_spec_no_buff, 25}, {has_not_spec_no_buff, 26}, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(27) ->
	#ai_cond{
		no = 27,
		rules_filter_bo_L = [enemy_side, undead, is_player, {cur_mp_percentage_lower_than, 25}, {cur_mp_percentage_higher_than, 10}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(28) ->
	#ai_cond{
		no = 28,
		rules_filter_bo_L = [enemy_side, undead, mag_def_lowest],
		attr_L = mag_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [myself],
		attr_R = mag_att,
		addi_value_R = {"*",0.5}
};

get(29) ->
	#ai_cond{
		no = 29,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 4018}],
		attr_L = is_undead,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30) ->
	#ai_cond{
		no = 30,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, mag_def_lowest],
		attr_L = mag_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [myself],
		attr_R = mag_att,
		addi_value_R = {"*",3}
};

get(31) ->
	#ai_cond{
		no = 31,
		rules_filter_bo_L = [ally_side, is_fallen],
		attr_L = is_fallen,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(32) ->
	#ai_cond{
		no = 32,
		rules_filter_bo_L = [ally_side, {cur_hp_percentage_lower_than, 50}, undead],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(33) ->
	#ai_cond{
		no = 33,
		rules_filter_bo_L = [ally_side, {cur_hp_percentage_lower_than, 80}, undead],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(34) ->
	#ai_cond{
		no = 34,
		rules_filter_bo_L = [ally_side, undead, {cur_mp_percentage_lower_than, 35}],
		attr_L = is_undead,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(35) ->
	#ai_cond{
		no = 35,
		rules_filter_bo_L = [ally_side, undead, {has_not_spec_no_buff, 29}],
		attr_L = is_my_ally,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(36) ->
	#ai_cond{
		no = 36,
		rules_filter_bo_L = [ally_side, undead, {has_not_spec_no_buff, 4019}],
		attr_L = is_my_ally,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(37) ->
	#ai_cond{
		no = 37,
		rules_filter_bo_L = [enemy_side, undead, phy_att_highest],
		attr_L = phy_att,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [ally_side, undead, phy_def_lowest, {has_not_spec_no_buff, 31}],
		attr_R = phy_def,
		addi_value_R = {"*",3}
};

get(38) ->
	#ai_cond{
		no = 38,
		rules_filter_bo_L = [ally_side, undead, {cur_hp_percentage_lower_than, 25}],
		attr_L = is_my_ally,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(39) ->
	#ai_cond{
		no = 39,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 31}],
		attr_L = is_undead,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(40) ->
	#ai_cond{
		no = 40,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",20}
};

get(41) ->
	#ai_cond{
		no = 41,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(42) ->
	#ai_cond{
		no = 42,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,2},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(43) ->
	#ai_cond{
		no = 43,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill, 3},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(44) ->
	#ai_cond{
		no = 44,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,4},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(45) ->
	#ai_cond{
		no = 45,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,5},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(46) ->
	#ai_cond{
		no = 46,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,6},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(47) ->
	#ai_cond{
		no = 47,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,7},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(48) ->
	#ai_cond{
		no = 48,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,11},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(49) ->
	#ai_cond{
		no = 49,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,12},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50) ->
	#ai_cond{
		no = 50,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,13},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(51) ->
	#ai_cond{
		no = 51,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,14},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(52) ->
	#ai_cond{
		no = 52,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,15},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(53) ->
	#ai_cond{
		no = 53,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,16},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(54) ->
	#ai_cond{
		no = 54,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,17},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(55) ->
	#ai_cond{
		no = 55,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,41},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(56) ->
	#ai_cond{
		no = 56,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,42},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(57) ->
	#ai_cond{
		no = 57,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,43},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(58) ->
	#ai_cond{
		no = 58,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,44},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(59) ->
	#ai_cond{
		no = 59,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,45},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(60) ->
	#ai_cond{
		no = 60,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,46},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(61) ->
	#ai_cond{
		no = 61,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,47},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(62) ->
	#ai_cond{
		no = 62,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,51},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(63) ->
	#ai_cond{
		no = 63,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,52},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(64) ->
	#ai_cond{
		no = 64,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,53},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(65) ->
	#ai_cond{
		no = 65,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,54},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(66) ->
	#ai_cond{
		no = 66,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,55},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(67) ->
	#ai_cond{
		no = 67,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,56},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(68) ->
	#ai_cond{
		no = 68,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,57},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(69) ->
	#ai_cond{
		no = 69,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10001},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(70) ->
	#ai_cond{
		no = 70,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10002},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(71) ->
	#ai_cond{
		no = 71,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10003},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(72) ->
	#ai_cond{
		no = 72,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10004},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(73) ->
	#ai_cond{
		no = 73,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10010},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(74) ->
	#ai_cond{
		no = 74,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10011},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(75) ->
	#ai_cond{
		no = 75,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10019},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(76) ->
	#ai_cond{
		no = 76,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10021},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(77) ->
	#ai_cond{
		no = 77,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 36}],
		attr_L = {is_can_use_skill,7},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(78) ->
	#ai_cond{
		no = 78,
		rules_filter_bo_L = [enemy_side, undead, phy_def_highest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [ally_side, undead, phy_att_highest],
		attr_R = phy_att,
		addi_value_R = {"*",1.2}
};

get(79) ->
	#ai_cond{
		no = 79,
		rules_filter_bo_L = [enemy_side, undead, mag_def_highest],
		attr_L = mag_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [ally_side, undead, mag_att_highest],
		attr_R = mag_att,
		addi_value_R = {"*",1.2}
};

get(80) ->
	#ai_cond{
		no = 80,
		rules_filter_bo_L = [enemy_side, is_not_frozen, undead],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(81) ->
	#ai_cond{
		no = 81,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(82) ->
	#ai_cond{
		no = 82,
		rules_filter_bo_L = [enemy_side, undead, has_invisible_eff],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(83) ->
	#ai_cond{
		no = 83,
		rules_filter_bo_L = [ally_side, {has_not_spec_no_buff, 15}, undead],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(84) ->
	#ai_cond{
		no = 84,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,23},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(85) ->
	#ai_cond{
		no = 85,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,4},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(86) ->
	#ai_cond{
		no = 86,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,21},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(87) ->
	#ai_cond{
		no = 87,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,22},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(88) ->
	#ai_cond{
		no = 88,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,23},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(89) ->
	#ai_cond{
		no = 89,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,24},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(90) ->
	#ai_cond{
		no = 90,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,25},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(91) ->
	#ai_cond{
		no = 91,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,26},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(92) ->
	#ai_cond{
		no = 92,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,27},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(93) ->
	#ai_cond{
		no = 93,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, {has_not_spec_no_buff, 40}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(94) ->
	#ai_cond{
		no = 94,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 38}, {has_not_spec_no_buff, 39}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(95) ->
	#ai_cond{
		no = 95,
		rules_filter_bo_L = [{has_not_spec_no_buff, 41}, {has_not_spec_no_buff, 42}, ally_side],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(96) ->
	#ai_cond{
		no = 96,
		rules_filter_bo_L = [ally_side, undead, phy_att_highest],
		attr_L = phy_att,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [ally_side, undead, phy_att_highest],
		attr_R = mag_att,
		addi_value_R = {"*",1.5}
};

get(97) ->
	#ai_cond{
		no = 97,
		rules_filter_bo_L = [enemy_side, undead, {has_not_spec_no_buff, 16}, phy_def_highest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [ally_side, phy_att_highest],
		attr_R = phy_att,
		addi_value_R = {"+",0.8}
};

get(98) ->
	#ai_cond{
		no = 98,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, not_invisible_to_me, cur_hp_highest],
		attr_L = cur_hp,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = mag_att,
		addi_value_R = {"*",0.2}
};

get(99) ->
	#ai_cond{
		no = 99,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(100) ->
	#ai_cond{
		no = 100,
		rules_filter_bo_L = [myself],
		attr_L = {has_spec_no_buff,38},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(101) ->
	#ai_cond{
		no = 101,
		rules_filter_bo_L = [myself],
		attr_L = {has_spec_no_buff,39},
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(102) ->
	#ai_cond{
		no = 102,
		rules_filter_bo_L = [myself, {cur_hp_percentage_lower_than, 20}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(103) ->
	#ai_cond{
		no = 103,
		rules_filter_bo_L = [enemy_side, undead, {has_not_spec_no_buff, 25}, {has_not_spec_no_buff, 26}, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(104) ->
	#ai_cond{
		no = 104,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,32},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(105) ->
	#ai_cond{
		no = 105,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,32},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(106) ->
	#ai_cond{
		no = 106,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,33},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(107) ->
	#ai_cond{
		no = 107,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,34},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(108) ->
	#ai_cond{
		no = 108,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,35},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(109) ->
	#ai_cond{
		no = 109,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,36},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(110) ->
	#ai_cond{
		no = 110,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,37},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(111) ->
	#ai_cond{
		no = 111,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(112) ->
	#ai_cond{
		no = 112,
		rules_filter_bo_L = [enemy_side, undead, phy_att_highest],
		attr_L = phy_att,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [enemy_side, undead, phy_att_highest],
		attr_R = mag_att,
		addi_value_R = {"*",1.5}
};

get(113) ->
	#ai_cond{
		no = 113,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 20}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(114) ->
	#ai_cond{
		no = 114,
		rules_filter_bo_L = [enemy_side, {belong_to_faction, 2}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(115) ->
	#ai_cond{
		no = 115,
		rules_filter_bo_L = [enemy_side, {belong_to_faction,6}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(116) ->
	#ai_cond{
		no = 116,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, cur_hp_lowest],
		attr_L = cur_hp,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.5}
};

get(117) ->
	#ai_cond{
		no = 117,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 21}, {has_not_spec_no_buff, 22}, {has_not_spec_no_buff, 23}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(118) ->
	#ai_cond{
		no = 118,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_under_control],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(119) ->
	#ai_cond{
		no = 119,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_under_control],
		attr_L = filtered_bo_count,
		addi_value_L = {"-",1},
		cmp_symbol = ">=",
		rules_filter_bo_R = [myself],
		attr_R = lv,
		addi_value_R = {"*",0.025}
};

get(120) ->
	#ai_cond{
		no = 120,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(121) ->
	#ai_cond{
		no = 121,
		rules_filter_bo_L = [enemy_side, cur_hp_lowest, {cur_hp_percentage_higher_than, 50}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(122) ->
	#ai_cond{
		no = 122,
		rules_filter_bo_L = [enemy_side, {belong_to_faction, 6}, undead],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(123) ->
	#ai_cond{
		no = 123,
		rules_filter_bo_L = [enemy_side, undead, is_player, cur_hp_lowest, {has_not_spec_no_buff, 44}],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",20}
};

get(124) ->
	#ai_cond{
		no = 124,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(125) ->
	#ai_cond{
		no = 125,
		rules_filter_bo_L = [myself],
		attr_L = phy_att,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [myself],
		attr_R = mag_att,
		addi_value_R = {"*",1.2}
};

get(126) ->
	#ai_cond{
		no = 126,
		rules_filter_bo_L = [myself],
		attr_L = mag_att,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",1.2}
};

get(127) ->
	#ai_cond{
		no = 127,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(128) ->
	#ai_cond{
		no = 128,
		rules_filter_bo_L = [enemy_side, undead, {cur_hp_percentage_higher_than, 75}, {has_spec_no_buff, 43}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(129) ->
	#ai_cond{
		no = 129,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10049},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(130) ->
	#ai_cond{
		no = 130,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",5}
};

get(131) ->
	#ai_cond{
		no = 131,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(132) ->
	#ai_cond{
		no = 132,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control, seal_resis_lowest],
		attr_L = seal_resis,
		addi_value_L = {"*",1},
		cmp_symbol = ">=",
		rules_filter_bo_R = [myself],
		attr_R = seal_hit,
		addi_value_R = {"*",0.8}
};

get(133) ->
	#ai_cond{
		no = 133,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control, phy_def_lowest],
		attr_L = phy_def,
		addi_value_L = {"*",2},
		cmp_symbol = ">=",
		rules_filter_bo_R = [ally_side, undead, is_not_under_control, phy_att_lowest],
		attr_R = phy_att,
		addi_value_R = {"*", 1}
};

get(134) ->
	#ai_cond{
		no = 134,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 4023}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(135) ->
	#ai_cond{
		no = 135,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, phy_def_lowest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",1}
};

get(136) ->
	#ai_cond{
		no = 136,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 13}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(137) ->
	#ai_cond{
		no = 137,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, phy_def_lowest],
		attr_L = cur_hp,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",4}
};

get(138) ->
	#ai_cond{
		no = 138,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, phy_att_lowest],
		attr_L = phy_att,
		addi_value_L = {"*",2},
		cmp_symbol = "<",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",1}
};

get(139) ->
	#ai_cond{
		no = 139,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, phy_att_highest],
		attr_L = phy_att,
		addi_value_L = {"*",1},
		cmp_symbol = ">",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",2}
};

get(140) ->
	#ai_cond{
		no = 140,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",20}
};

get(141) ->
	#ai_cond{
		no = 141,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(142) ->
	#ai_cond{
		no = 142,
		rules_filter_bo_L = [enemy_side, undead, cur_hp_lowest],
		attr_L = cur_hp,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",5}
};

get(143) ->
	#ai_cond{
		no = 143,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 12}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(201) ->
	#ai_cond{
		no = 201,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,201},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(202) ->
	#ai_cond{
		no = 202,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,202},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(203) ->
	#ai_cond{
		no = 203,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,203},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(204) ->
	#ai_cond{
		no = 204,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,204},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(205) ->
	#ai_cond{
		no = 205,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,205},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(301) ->
	#ai_cond{
		no = 301,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,301},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(302) ->
	#ai_cond{
		no = 302,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,302},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(303) ->
	#ai_cond{
		no = 303,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,303},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(304) ->
	#ai_cond{
		no = 304,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,304},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(305) ->
	#ai_cond{
		no = 305,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,305},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(401) ->
	#ai_cond{
		no = 401,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,401},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(402) ->
	#ai_cond{
		no = 402,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,402},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(403) ->
	#ai_cond{
		no = 403,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,403},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(404) ->
	#ai_cond{
		no = 404,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,404},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(405) ->
	#ai_cond{
		no = 405,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,405},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(501) ->
	#ai_cond{
		no = 501,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,501},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(502) ->
	#ai_cond{
		no = 502,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,502},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(503) ->
	#ai_cond{
		no = 503,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,503},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(504) ->
	#ai_cond{
		no = 504,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,504},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(505) ->
	#ai_cond{
		no = 505,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,505},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000) ->
	#ai_cond{
		no = 1000,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10003},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1001) ->
	#ai_cond{
		no = 1001,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10005},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1002) ->
	#ai_cond{
		no = 1002,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10006},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1003) ->
	#ai_cond{
		no = 1003,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10007},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1004) ->
	#ai_cond{
		no = 1004,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10008},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1005) ->
	#ai_cond{
		no = 1005,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10012},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1006) ->
	#ai_cond{
		no = 1006,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10013},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1007) ->
	#ai_cond{
		no = 1007,
		rules_filter_bo_L = [myself],
		attr_L = mag_att,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",1.2}
};

get(1008) ->
	#ai_cond{
		no = 1008,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, not_invisible_to_me],
		attr_L = no_attr,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(1009) ->
	#ai_cond{
		no = 1009,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control, phy_att_highest],
		attr_L = phy_att,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [enemy_side, undead, is_not_under_control, mag_att_highest],
		attr_R = mag_att,
		addi_value_R = {"*",1.6}
};

get(1010) ->
	#ai_cond{
		no = 1010,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control, mag_att_highest],
		attr_L = mag_att,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [enemy_side, undead, is_not_under_control, phy_att_highest],
		attr_R = phy_att,
		addi_value_R = {"*",1.6}
};

get(1011) ->
	#ai_cond{
		no = 1011,
		rules_filter_bo_L = [myself],
		attr_L = phy_att,
		addi_value_L = {"*",0.7},
		cmp_symbol = ">=",
		rules_filter_bo_R = [enemy_side, undead, is_not_frozen, not_invisible_to_me, phy_def_lowest],
		attr_R = phy_def,
		addi_value_R = {"+",1}
};

get(1012) ->
	#ai_cond{
		no = 1012,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10009},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1013) ->
	#ai_cond{
		no = 1013,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10014},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1014) ->
	#ai_cond{
		no = 1014,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10020},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1015) ->
	#ai_cond{
		no = 1015,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10022},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1016) ->
	#ai_cond{
		no = 1016,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10023},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1017) ->
	#ai_cond{
		no = 1017,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10024},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1018) ->
	#ai_cond{
		no = 1018,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10025},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1019) ->
	#ai_cond{
		no = 1019,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10026},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1020) ->
	#ai_cond{
		no = 1020,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10027},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1021) ->
	#ai_cond{
		no = 1021,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10028},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1022) ->
	#ai_cond{
		no = 1022,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10029},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1023) ->
	#ai_cond{
		no = 1023,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10030},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1024) ->
	#ai_cond{
		no = 1024,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10031},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1025) ->
	#ai_cond{
		no = 1025,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10032},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1026) ->
	#ai_cond{
		no = 1026,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10033},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1027) ->
	#ai_cond{
		no = 1027,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10034},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1028) ->
	#ai_cond{
		no = 1028,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10035},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1029) ->
	#ai_cond{
		no = 1029,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10036},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1030) ->
	#ai_cond{
		no = 1030,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10037},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1031) ->
	#ai_cond{
		no = 1031,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10038},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1032) ->
	#ai_cond{
		no = 1032,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10039},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1033) ->
	#ai_cond{
		no = 1033,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10040},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1034) ->
	#ai_cond{
		no = 1034,
		rules_filter_bo_L = [ally_side, undead, act_speed_highest],
		attr_L = {has_spec_no_buff,1022},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1035) ->
	#ai_cond{
		no = 1035,
		rules_filter_bo_L = [ally_side, undead, {cur_hp_percentage_lower_than, 60}, {has_not_spec_no_buff, 1027}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1036) ->
	#ai_cond{
		no = 1036,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10011},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1037) ->
	#ai_cond{
		no = 1037,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10041},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1038) ->
	#ai_cond{
		no = 1038,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10042},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1039) ->
	#ai_cond{
		no = 1039,
		rules_filter_bo_L = [myself],
		attr_L = phy_att,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = mag_att,
		addi_value_R = {"*",1.2}
};

get(1040) ->
	#ai_cond{
		no = 1040,
		rules_filter_bo_L = [ally_side, undead, {has_spec_eff_type_buff, bad}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1041) ->
	#ai_cond{
		no = 1041,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10043},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1042) ->
	#ai_cond{
		no = 1042,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10044},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1043) ->
	#ai_cond{
		no = 1043,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10045},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1044) ->
	#ai_cond{
		no = 1044,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, {pos_equal_to, 6}],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.5}
};

get(1045) ->
	#ai_cond{
		no = 1045,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, {pos_equal_to, 7}],
		attr_L = phy_def,
		addi_value_L = {"+",1},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.5}
};

get(1046) ->
	#ai_cond{
		no = 1046,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, {pos_equal_to, 8}],
		attr_L = phy_def,
		addi_value_L = {"+",2},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.5}
};

get(1047) ->
	#ai_cond{
		no = 1047,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, {pos_equal_to, 9}],
		attr_L = phy_def,
		addi_value_L = {"+",3},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.5}
};

get(1048) ->
	#ai_cond{
		no = 1048,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, {pos_equal_to, 10}],
		attr_L = phy_def,
		addi_value_L = {"+",4},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.5}
};

get(1049) ->
	#ai_cond{
		no = 1049,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, {pos_equal_to, 6}],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.65}
};

get(1050) ->
	#ai_cond{
		no = 1050,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, {pos_equal_to, 7}],
		attr_L = phy_def,
		addi_value_L = {"+",1},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.65}
};

get(1051) ->
	#ai_cond{
		no = 1051,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, {pos_equal_to, 8}],
		attr_L = phy_def,
		addi_value_L = {"+",2},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.65}
};

get(1052) ->
	#ai_cond{
		no = 1052,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, {pos_equal_to, 9}],
		attr_L = phy_def,
		addi_value_L = {"+",3},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.65}
};

get(1053) ->
	#ai_cond{
		no = 1053,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen, {pos_equal_to, 10}],
		attr_L = phy_def,
		addi_value_L = {"+",4},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.65}
};

get(1054) ->
	#ai_cond{
		no = 1054,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {pos_equal_to, 1}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1055) ->
	#ai_cond{
		no = 1055,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {pos_equal_to, 2}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1056) ->
	#ai_cond{
		no = 1056,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {pos_equal_to, 3}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1057) ->
	#ai_cond{
		no = 1057,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {pos_equal_to, 4}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1058) ->
	#ai_cond{
		no = 1058,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {pos_equal_to, 5}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1059) ->
	#ai_cond{
		no = 1059,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10046},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1060) ->
	#ai_cond{
		no = 1060,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10047},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1061) ->
	#ai_cond{
		no = 1061,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10048},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1062) ->
	#ai_cond{
		no = 1062,
		rules_filter_bo_L = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",2}
};

get(1063) ->
	#ai_cond{
		no = 1063,
		rules_filter_bo_L = [myself, {cur_hp_percentage_higher_than, 30}],
		attr_L = is_undead,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1064) ->
	#ai_cond{
		no = 1064,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10050},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1065) ->
	#ai_cond{
		no = 1065,
		rules_filter_bo_L = [undead, ally_side, is_player, is_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1066) ->
	#ai_cond{
		no = 1066,
		rules_filter_bo_L = [undead, ally_side, is_player, is_chaos
],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1067) ->
	#ai_cond{
		no = 1067,
		rules_filter_bo_L = [undead, ally_side, is_frozen
],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1068) ->
	#ai_cond{
		no = 1068,
		rules_filter_bo_L = [undead, ally_side, is_chaos
],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1069) ->
	#ai_cond{
		no = 1069,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10051},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5001) ->
	#ai_cond{
		no = 5001,
		rules_filter_bo_L = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5002) ->
	#ai_cond{
		no = 5002,
		rules_filter_bo_L = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		attr_L = diff_between_my_phy_att_and_target_phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [enemy_side, cur_hp_lowest],
		attr_R = cur_hp,
		addi_value_R = {"*",1.5}
};

get(5003) ->
	#ai_cond{
		no = 5003,
		rules_filter_bo_L = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		attr_L = diff_between_my_phy_att_and_target_phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [enemy_side, cur_hp_lowest],
		attr_R = cur_hp,
		addi_value_R = {"*",1.8}
};

get(5004) ->
	#ai_cond{
		no = 5004,
		rules_filter_bo_L = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		attr_L = diff_between_my_phy_att_and_target_phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [enemy_side, cur_hp_lowest],
		attr_R = cur_hp,
		addi_value_R = {"*",2.1}
};

get(5005) ->
	#ai_cond{
		no = 5005,
		rules_filter_bo_L = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		attr_L = diff_between_my_phy_att_and_target_phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [enemy_side, cur_hp_lowest],
		attr_R = cur_hp,
		addi_value_R = {"*",1}
};

get(5006) ->
	#ai_cond{
		no = 5006,
		rules_filter_bo_L = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5007) ->
	#ai_cond{
		no = 5007,
		rules_filter_bo_L = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		attr_L = diff_between_my_mag_att_and_target_mag_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [enemy_side, cur_hp_lowest],
		attr_R = cur_hp,
		addi_value_R = {"*",1.5}
};

get(5008) ->
	#ai_cond{
		no = 5008,
		rules_filter_bo_L = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		attr_L = diff_between_my_mag_att_and_target_mag_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [enemy_side, cur_hp_lowest],
		attr_R = cur_hp,
		addi_value_R = {"*",1.8}
};

get(5009) ->
	#ai_cond{
		no = 5009,
		rules_filter_bo_L = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		attr_L = diff_between_my_mag_att_and_target_mag_def,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [enemy_side, cur_hp_lowest],
		attr_R = cur_hp,
		addi_value_R = {"*",2.1}
};

get(5010) ->
	#ai_cond{
		no = 5010,
		rules_filter_bo_L = [undead, enemy_side, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		attr_L = diff_between_my_mag_att_and_target_mag_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [enemy_side, cur_hp_lowest],
		attr_R = cur_hp,
		addi_value_R = {"*",1}
};

get(5011) ->
	#ai_cond{
		no = 5011,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control, {cur_hp_percentage_higher_than, 40}, cur_hp_highest],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(5012) ->
	#ai_cond{
		no = 5012,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control, {cur_hp_percentage_higher_than, 30}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(5013) ->
	#ai_cond{
		no = 5013,
		rules_filter_bo_L = [enemy_side, undead, is_not_under_control, {cur_hp_percentage_higher_than, 25}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",4}
};

get(5014) ->
	#ai_cond{
		no = 5014,
		rules_filter_bo_L = [ally_side, undead, {has_not_spec_no_buff, 31}, {has_not_spec_no_buff, 46}, {has_not_spec_no_buff, 57}, {has_not_spec_no_buff, 58}, {has_not_spec_no_buff, 59}, {has_not_spec_no_buff, 1015}, {has_not_spec_no_buff, 1016}, {cur_hp_percentage_lower_than, 40}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5015) ->
	#ai_cond{
		no = 5015,
		rules_filter_bo_L = [ally_side, dead, is_player, {has_not_spec_no_buff, 44}, {has_not_spec_no_buff, 1013}, {has_not_spec_no_buff, 1014}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(5016) ->
	#ai_cond{
		no = 5016,
		rules_filter_bo_L = [ally_side, undead, is_under_control, is_not_cding, is_not_xuliing],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5017) ->
	#ai_cond{
		no = 5017,
		rules_filter_bo_L = [ally_side, undead, {cur_hp_percentage_lower_than, 80}, is_not_frozen, {has_not_spec_no_buff, 31}, {has_not_spec_no_buff, 46}, {has_not_spec_no_buff, 57}, {has_not_spec_no_buff, 58}, {has_not_spec_no_buff, 59}, {has_not_spec_no_buff, 1015}, {has_not_spec_no_buff, 1016}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(5018) ->
	#ai_cond{
		no = 5018,
		rules_filter_bo_L = [ally_side, undead, {cur_hp_percentage_lower_than, 40}, is_not_frozen, {has_not_spec_no_buff, 31}, {has_not_spec_no_buff, 46}, {has_not_spec_no_buff, 57}, {has_not_spec_no_buff, 58}, {has_not_spec_no_buff, 59}, {has_not_spec_no_buff, 1015}, {has_not_spec_no_buff, 1016}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(5019) ->
	#ai_cond{
		no = 5019,
		rules_filter_bo_L = [myself],
		attr_L = phy_att,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [myself],
		attr_R = phy_def,
		addi_value_R = {"+",1.35}
};

get(5020) ->
	#ai_cond{
		no = 5020,
		rules_filter_bo_L = [myself],
		attr_L = mag_att,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [myself],
		attr_R = mag_def,
		addi_value_R = {"+",1.35}
};

get(5021) ->
	#ai_cond{
		no = 5021,
		rules_filter_bo_L = [myself],
		attr_L = phy_att,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = phy_def,
		addi_value_R = {"+",1.35}
};

get(5022) ->
	#ai_cond{
		no = 5022,
		rules_filter_bo_L = [myself],
		attr_L = mag_att,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [myself],
		attr_R = mag_def,
		addi_value_R = {"+",1.35}
};

get(5023) ->
	#ai_cond{
		no = 5023,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, phy_def_highest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [myself],
		attr_R = phy_att,
		addi_value_R = {"*",0.8}
};

get(5024) ->
	#ai_cond{
		no = 5024,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, mag_def_highest],
		attr_L = mag_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [myself],
		attr_R = mag_att,
		addi_value_R = {"*",0.8}
};

get(5025) ->
	#ai_cond{
		no = 5025,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {cur_hp_percentage_lower_than, 25}, cur_hp_lowest],
		attr_L = cur_hp,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [enemy_side, undead, is_not_frozen, {cur_hp_percentage_lower_than, 25}, cur_hp_lowest],
		attr_R = diff_between_my_phy_att_and_target_phy_def,
		addi_value_R = {"*",1.2}
};

get(5026) ->
	#ai_cond{
		no = 5026,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {cur_hp_percentage_lower_than, 35}, cur_hp_lowest],
		attr_L = cur_hp,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [enemy_side, undead, is_not_frozen, {cur_hp_percentage_lower_than, 25}, cur_hp_lowest],
		attr_R = diff_between_my_mag_att_and_target_mag_def,
		addi_value_R = {"*",1.2}
};

get(5027) ->
	#ai_cond{
		no = 5027,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {cur_hp_percentage_lower_than, 45}, cur_hp_lowest],
		attr_L = cur_hp,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [enemy_side, undead, is_not_frozen, {cur_hp_percentage_lower_than, 25}, cur_hp_lowest],
		attr_R = diff_between_my_mag_att_and_target_mag_def,
		addi_value_R = {"*",1.2}
};

get(5028) ->
	#ai_cond{
		no = 5028,
		rules_filter_bo_L = [ally_side, undead, {has_spec_eff_type_buff, bad}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(5029) ->
	#ai_cond{
		no = 5029,
		rules_filter_bo_L = [ally_side, undead, is_under_control, is_not_cding, is_not_xuliing],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(5030) ->
	#ai_cond{
		no = 5030,
		rules_filter_bo_L = [enemy_side, is_partner, is_not_under_control, undead, {cur_hp_percentage_higher_than, 80}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5031) ->
	#ai_cond{
		no = 5031,
		rules_filter_bo_L = [enemy_side, is_player, undead, is_not_under_control, {cur_anger_higher_than, 60}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5032) ->
	#ai_cond{
		no = 5032,
		rules_filter_bo_L = [enemy_side, undead, is_player, {cur_anger_higher_than, 60}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"*",1}
};

get(5033) ->
	#ai_cond{
		no = 5033,
		rules_filter_bo_L = [enemy_side, undead, {belong_to_faction, 6}, is_under_control],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5101) ->
	#ai_cond{
		no = 5101,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62001},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5102) ->
	#ai_cond{
		no = 5102,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62002},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5103) ->
	#ai_cond{
		no = 5103,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62003},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5104) ->
	#ai_cond{
		no = 5104,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62011},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5105) ->
	#ai_cond{
		no = 5105,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62012},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5106) ->
	#ai_cond{
		no = 5106,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62013},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5107) ->
	#ai_cond{
		no = 5107,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62021},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5108) ->
	#ai_cond{
		no = 5108,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62022},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5109) ->
	#ai_cond{
		no = 5109,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62023},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5110) ->
	#ai_cond{
		no = 5110,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62031},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5111) ->
	#ai_cond{
		no = 5111,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62032},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5112) ->
	#ai_cond{
		no = 5112,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62033},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5113) ->
	#ai_cond{
		no = 5113,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62041},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5114) ->
	#ai_cond{
		no = 5114,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62042},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5115) ->
	#ai_cond{
		no = 5115,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62043},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5116) ->
	#ai_cond{
		no = 5116,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62051},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5117) ->
	#ai_cond{
		no = 5117,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62052},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5118) ->
	#ai_cond{
		no = 5118,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62053},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5119) ->
	#ai_cond{
		no = 5119,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62061},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5120) ->
	#ai_cond{
		no = 5120,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62062},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5121) ->
	#ai_cond{
		no = 5121,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62063},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5122) ->
	#ai_cond{
		no = 5122,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62071},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5123) ->
	#ai_cond{
		no = 5123,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62072},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5124) ->
	#ai_cond{
		no = 5124,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62073},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5125) ->
	#ai_cond{
		no = 5125,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62081},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5126) ->
	#ai_cond{
		no = 5126,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62082},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5127) ->
	#ai_cond{
		no = 5127,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62083},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5128) ->
	#ai_cond{
		no = 5128,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62091},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5129) ->
	#ai_cond{
		no = 5129,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62092},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5130) ->
	#ai_cond{
		no = 5130,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62093},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5131) ->
	#ai_cond{
		no = 5131,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62101},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5132) ->
	#ai_cond{
		no = 5132,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62102},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5133) ->
	#ai_cond{
		no = 5133,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62103},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5134) ->
	#ai_cond{
		no = 5134,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62111},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5135) ->
	#ai_cond{
		no = 5135,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62112},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5136) ->
	#ai_cond{
		no = 5136,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62113},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5137) ->
	#ai_cond{
		no = 5137,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62121},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5138) ->
	#ai_cond{
		no = 5138,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62122},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5139) ->
	#ai_cond{
		no = 5139,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62123},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5140) ->
	#ai_cond{
		no = 5140,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62131},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5141) ->
	#ai_cond{
		no = 5141,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62132},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(5142) ->
	#ai_cond{
		no = 5142,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62133},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10000) ->
	#ai_cond{
		no = 10000,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10004},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10001) ->
	#ai_cond{
		no = 10001,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10002},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10002) ->
	#ai_cond{
		no = 10002,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10011},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10003) ->
	#ai_cond{
		no = 10003,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10001},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10004) ->
	#ai_cond{
		no = 10004,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10010},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10005) ->
	#ai_cond{
		no = 10005,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10003},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10006) ->
	#ai_cond{
		no = 10006,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,57},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [myself],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10007) ->
	#ai_cond{
		no = 10007,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,51},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10008) ->
	#ai_cond{
		no = 10008,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,2},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [{has_not_spec_no_buff, 2}],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10009) ->
	#ai_cond{
		no = 10009,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,3},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [{has_not_spec_no_buff, 3}],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10010) ->
	#ai_cond{
		no = 10010,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 20}],
		attr_L = {is_can_use_skill,32},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [myself],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10011) ->
	#ai_cond{
		no = 10011,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,31},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10012) ->
	#ai_cond{
		no = 10012,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 24}],
		attr_L = {is_can_use_skill,37},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [myself],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10013) ->
	#ai_cond{
		no = 10013,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,24},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10014) ->
	#ai_cond{
		no = 10014,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,26},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10015) ->
	#ai_cond{
		no = 10015,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 14}],
		attr_L = {is_can_use_skill,22},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [myself],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10016) ->
	#ai_cond{
		no = 10016,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,11},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10017) ->
	#ai_cond{
		no = 10017,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,41},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10018) ->
	#ai_cond{
		no = 10018,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10019) ->
	#ai_cond{
		no = 10019,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,16},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10020) ->
	#ai_cond{
		no = 10020,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 150}],
		attr_L = {is_can_use_skill,15},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [myself],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10021) ->
	#ai_cond{
		no = 10021,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,44},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10022) ->
	#ai_cond{
		no = 10022,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,52},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [ally_side, dead],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10023) ->
	#ai_cond{
		no = 10023,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,53},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [{has_not_spec_no_buff, 530}, ally_side],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10024) ->
	#ai_cond{
		no = 10024,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,12},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10025) ->
	#ai_cond{
		no = 10025,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 10}],
		attr_L = {is_can_use_skill,13},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [myself],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10026) ->
	#ai_cond{
		no = 10026,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,2},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(10027) ->
	#ai_cond{
		no = 10027,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,43},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10028) ->
	#ai_cond{
		no = 10028,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,100},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10029) ->
	#ai_cond{
		no = 10029,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,55},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [myself],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10030) ->
	#ai_cond{
		no = 10030,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,14},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10031) ->
	#ai_cond{
		no = 10031,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,7},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [myself],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10032) ->
	#ai_cond{
		no = 10032,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,21},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10033) ->
	#ai_cond{
		no = 10033,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,6},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10034) ->
	#ai_cond{
		no = 10034,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,100},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(10035) ->
	#ai_cond{
		no = 10035,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,100},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(10036) ->
	#ai_cond{
		no = 10036,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,100},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",4}
};

get(10037) ->
	#ai_cond{
		no = 10037,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,100},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",5}
};

get(10038) ->
	#ai_cond{
		no = 10038,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,100},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",6}
};

get(10039) ->
	#ai_cond{
		no = 10039,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,100},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",7}
};

get(10040) ->
	#ai_cond{
		no = 10040,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,100},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",8}
};

get(10041) ->
	#ai_cond{
		no = 10041,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,100},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",9}
};

get(10042) ->
	#ai_cond{
		no = 10042,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,100},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(10043) ->
	#ai_cond{
		no = 10043,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 250}],
		attr_L = {is_can_use_skill,25},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10044) ->
	#ai_cond{
		no = 10044,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,27},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10045) ->
	#ai_cond{
		no = 10045,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,2},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(10046) ->
	#ai_cond{
		no = 10046,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,3},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(10047) ->
	#ai_cond{
		no = 10047,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,4},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(10048) ->
	#ai_cond{
		no = 10048,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,5},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(10049) ->
	#ai_cond{
		no = 10049,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,6},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(10050) ->
	#ai_cond{
		no = 10050,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,7},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(10051) ->
	#ai_cond{
		no = 10051,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,8},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(10052) ->
	#ai_cond{
		no = 10052,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,9},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(10053) ->
	#ai_cond{
		no = 10053,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,10},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(10054) ->
	#ai_cond{
		no = 10054,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(10055) ->
	#ai_cond{
		no = 10055,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",4}
};

get(10056) ->
	#ai_cond{
		no = 10056,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",5}
};

get(10057) ->
	#ai_cond{
		no = 10057,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",6}
};

get(10058) ->
	#ai_cond{
		no = 10058,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",7}
};

get(10059) ->
	#ai_cond{
		no = 10059,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",8}
};

get(10060) ->
	#ai_cond{
		no = 10060,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",9}
};

get(10061) ->
	#ai_cond{
		no = 10061,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(10062) ->
	#ai_cond{
		no = 10062,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10063) ->
	#ai_cond{
		no = 10063,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(10064) ->
	#ai_cond{
		no = 10064,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(10065) ->
	#ai_cond{
		no = 10065,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",4}
};

get(10066) ->
	#ai_cond{
		no = 10066,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",5}
};

get(10067) ->
	#ai_cond{
		no = 10067,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",6}
};

get(10068) ->
	#ai_cond{
		no = 10068,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",7}
};

get(10069) ->
	#ai_cond{
		no = 10069,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",8}
};

get(10070) ->
	#ai_cond{
		no = 10070,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",9}
};

get(10071) ->
	#ai_cond{
		no = 10071,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(10072) ->
	#ai_cond{
		no = 10072,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,47},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10073) ->
	#ai_cond{
		no = 10073,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,41},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10074) ->
	#ai_cond{
		no = 10074,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,42},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(10100) ->
	#ai_cond{
		no = 10100,
		rules_filter_bo_L = [ally_side],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(20000) ->
	#ai_cond{
		no = 20000,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,100000},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [enemy_side, is_player],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(20001) ->
	#ai_cond{
		no = 20001,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",5}
};

get(20002) ->
	#ai_cond{
		no = 20002,
		rules_filter_bo_L = [none],
		attr_L = {remainder_of_cur_round_div_by_N,5},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(20003) ->
	#ai_cond{
		no = 20003,
		rules_filter_bo_L = [none],
		attr_L = {remainder_of_cur_round_div_by_N,5},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(20004) ->
	#ai_cond{
		no = 20004,
		rules_filter_bo_L = [none],
		attr_L = {remainder_of_cur_round_div_by_N,5},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(20005) ->
	#ai_cond{
		no = 20005,
		rules_filter_bo_L = [none],
		attr_L = {remainder_of_cur_round_div_by_N,5},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",4}
};

get(20006) ->
	#ai_cond{
		no = 20006,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(20007) ->
	#ai_cond{
		no = 20007,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",15}
};

get(20008) ->
	#ai_cond{
		no = 20008,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",20}
};

get(100001) ->
	#ai_cond{
		no = 100001,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(100002) ->
	#ai_cond{
		no = 100002,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(100003) ->
	#ai_cond{
		no = 100003,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(100004) ->
	#ai_cond{
		no = 100004,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",4}
};

get(100005) ->
	#ai_cond{
		no = 100005,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",5}
};

get(100006) ->
	#ai_cond{
		no = 100006,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",6}
};

get(100007) ->
	#ai_cond{
		no = 100007,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",7}
};

get(100008) ->
	#ai_cond{
		no = 100008,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",8}
};

get(100009) ->
	#ai_cond{
		no = 100009,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",9}
};

get(100010) ->
	#ai_cond{
		no = 100010,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(2001) ->
	#ai_cond{
		no = 2001,
		rules_filter_bo_L = [ally_side, {pos_equal_to, 2}, is_fallen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2002) ->
	#ai_cond{
		no = 2002,
		rules_filter_bo_L = [none],
		attr_L = {remainder_of_cur_round_div_by_N,10},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(2003) ->
	#ai_cond{
		no = 2003,
		rules_filter_bo_L = [ally_side, {pos_equal_to, 3}, is_fallen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2004) ->
	#ai_cond{
		no = 2004,
		rules_filter_bo_L = [ally_side, {pos_equal_to, 1}, is_fallen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2005) ->
	#ai_cond{
		no = 2005,
		rules_filter_bo_L = [ally_side, {pos_equal_to, 6}, is_fallen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2006) ->
	#ai_cond{
		no = 2006,
		rules_filter_bo_L = [none],
		attr_L = {remainder_of_cur_round_div_by_N,1},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(2007) ->
	#ai_cond{
		no = 2007,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",5}
};

get(2008) ->
	#ai_cond{
		no = 2008,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",5}
};

get(2009) ->
	#ai_cond{
		no = 2009,
		rules_filter_bo_L = [ally_side,{pos_equal_to, 1}],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",30}
};

get(2010) ->
	#ai_cond{
		no = 2010,
		rules_filter_bo_L = [ally_side,{pos_equal_to, 1}],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",30}
};

get(2011) ->
	#ai_cond{
		no = 2011,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10057},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2012) ->
	#ai_cond{
		no = 2012,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10058},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2013) ->
	#ai_cond{
		no = 2013,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10059},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2014) ->
	#ai_cond{
		no = 2014,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10060},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2015) ->
	#ai_cond{
		no = 2015,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10061},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2016) ->
	#ai_cond{
		no = 2016,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10078},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2017) ->
	#ai_cond{
		no = 2017,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10079},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2018) ->
	#ai_cond{
		no = 2018,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10062},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2019) ->
	#ai_cond{
		no = 2019,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10063},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2020) ->
	#ai_cond{
		no = 2020,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10064},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2021) ->
	#ai_cond{
		no = 2021,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10065},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2022) ->
	#ai_cond{
		no = 2022,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10066},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2023) ->
	#ai_cond{
		no = 2023,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10067},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2024) ->
	#ai_cond{
		no = 2024,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10068},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2025) ->
	#ai_cond{
		no = 2025,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10069},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2026) ->
	#ai_cond{
		no = 2026,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10070},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2027) ->
	#ai_cond{
		no = 2027,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10071},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2028) ->
	#ai_cond{
		no = 2028,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10072},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2029) ->
	#ai_cond{
		no = 2029,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10073},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2030) ->
	#ai_cond{
		no = 2030,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10074},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2031) ->
	#ai_cond{
		no = 2031,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10075},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2032) ->
	#ai_cond{
		no = 2032,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10076},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2033) ->
	#ai_cond{
		no = 2033,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10077},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2034) ->
	#ai_cond{
		no = 2034,
		rules_filter_bo_L = [ally_side, {pos_equal_to, 2}],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",90}
};

get(2035) ->
	#ai_cond{
		no = 2035,
		rules_filter_bo_L = [ally_side, {pos_equal_to, 2}],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",80}
};

get(2036) ->
	#ai_cond{
		no = 2036,
		rules_filter_bo_L = [ally_side, {pos_equal_to, 2}],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",70}
};

get(2037) ->
	#ai_cond{
		no = 2037,
		rules_filter_bo_L = [ally_side, {pos_equal_to, 2}],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",60}
};

get(2038) ->
	#ai_cond{
		no = 2038,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",20}
};

get(2039) ->
	#ai_cond{
		no = 2039,
		rules_filter_bo_L = [ally_side, {pos_equal_to, 1}],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",60}
};

get(2040) ->
	#ai_cond{
		no = 2040,
		rules_filter_bo_L = [ally_side, {pos_equal_to, 1}],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",60}
};

get(2041) ->
	#ai_cond{
		no = 2041,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10052},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2042) ->
	#ai_cond{
		no = 2042,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10053},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2043) ->
	#ai_cond{
		no = 2043,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10054},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2044) ->
	#ai_cond{
		no = 2044,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10055},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2045) ->
	#ai_cond{
		no = 2045,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10056},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2046) ->
	#ai_cond{
		no = 2046,
		rules_filter_bo_L = [enemy_side, {belong_to_faction, 1}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2047) ->
	#ai_cond{
		no = 2047,
		rules_filter_bo_L = [enemy_side, {belong_to_faction, 2}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2048) ->
	#ai_cond{
		no = 2048,
		rules_filter_bo_L = [enemy_side, {belong_to_faction, 3}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2049) ->
	#ai_cond{
		no = 2049,
		rules_filter_bo_L = [enemy_side, {belong_to_faction, 4}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2050) ->
	#ai_cond{
		no = 2050,
		rules_filter_bo_L = [enemy_side, {belong_to_faction, 5}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2051) ->
	#ai_cond{
		no = 2051,
		rules_filter_bo_L = [enemy_side, {belong_to_faction, 6}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2052) ->
	#ai_cond{
		no = 2052,
		rules_filter_bo_L = [enemy_side, is_partner, undead],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(2053) ->
	#ai_cond{
		no = 2053,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70001},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2054) ->
	#ai_cond{
		no = 2054,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70002},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2055) ->
	#ai_cond{
		no = 2055,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70003},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2056) ->
	#ai_cond{
		no = 2056,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70004},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2057) ->
	#ai_cond{
		no = 2057,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70005},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2058) ->
	#ai_cond{
		no = 2058,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70101},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2059) ->
	#ai_cond{
		no = 2059,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70102},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2060) ->
	#ai_cond{
		no = 2060,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70103},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2061) ->
	#ai_cond{
		no = 2061,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70104},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2062) ->
	#ai_cond{
		no = 2062,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70105},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2063) ->
	#ai_cond{
		no = 2063,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,10080},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2064) ->
	#ai_cond{
		no = 2064,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,21},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2065) ->
	#ai_cond{
		no = 2065,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,22},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2066) ->
	#ai_cond{
		no = 2066,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,23},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2067) ->
	#ai_cond{
		no = 2067,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,24},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2068) ->
	#ai_cond{
		no = 2068,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,25},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2069) ->
	#ai_cond{
		no = 2069,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,26},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2070) ->
	#ai_cond{
		no = 2070,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,27},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2071) ->
	#ai_cond{
		no = 2071,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,31},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2072) ->
	#ai_cond{
		no = 2072,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,32},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2073) ->
	#ai_cond{
		no = 2073,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,33},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2074) ->
	#ai_cond{
		no = 2074,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,34},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2075) ->
	#ai_cond{
		no = 2075,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,35},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2076) ->
	#ai_cond{
		no = 2076,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,36},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2077) ->
	#ai_cond{
		no = 2077,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,37},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2078) ->
	#ai_cond{
		no = 2078,
		rules_filter_bo_L = [enemy_side, undead, {has_not_spec_no_buff, 4024}, phy_def_highest],
		attr_L = phy_def,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [ally_side, undead, phy_att_highest],
		attr_R = phy_att,
		addi_value_R = {"*",1.2}
};

get(2079) ->
	#ai_cond{
		no = 2079,
		rules_filter_bo_L = [ally_side,is_player, {cur_hp_percentage_lower_than, 50}, undead],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2080) ->
	#ai_cond{
		no = 2080,
		rules_filter_bo_L = [enemy_side, undead, has_invisible_eff],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2081) ->
	#ai_cond{
		no = 2081,
		rules_filter_bo_L = [ally_side, {has_not_spec_no_buff, 15}, undead],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2082) ->
	#ai_cond{
		no = 2082,
		rules_filter_bo_L = [ally_side, is_fallen],
		attr_L = is_fallen,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2083) ->
	#ai_cond{
		no = 2083,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2084) ->
	#ai_cond{
		no = 2084,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 4030}],
		attr_L = is_undead,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2085) ->
	#ai_cond{
		no = 2085,
		rules_filter_bo_L = [enemy_side, undead,{belong_to_faction, 1}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2086) ->
	#ai_cond{
		no = 2086,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2087) ->
	#ai_cond{
		no = 2087,
		rules_filter_bo_L = [ally_side, undead, {cur_mp_percentage_lower_than, 20},{has_not_spec_no_buff, 15}],
		attr_L = is_undead,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2088) ->
	#ai_cond{
		no = 2088,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70106},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2089) ->
	#ai_cond{
		no = 2089,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70107},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2090) ->
	#ai_cond{
		no = 2090,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70006},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2091) ->
	#ai_cond{
		no = 2091,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70007},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2092) ->
	#ai_cond{
		no = 2092,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70008},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2093) ->
	#ai_cond{
		no = 2093,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70009},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2094) ->
	#ai_cond{
		no = 2094,
		rules_filter_bo_L = [ally_side, {cur_hp_percentage_lower_than, 100}, undead],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2095) ->
	#ai_cond{
		no = 2095,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70010},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2096) ->
	#ai_cond{
		no = 2096,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70011},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2097) ->
	#ai_cond{
		no = 2097,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70012},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2098) ->
	#ai_cond{
		no = 2098,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70013},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2099) ->
	#ai_cond{
		no = 2099,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70014},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2100) ->
	#ai_cond{
		no = 2100,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70015},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2101) ->
	#ai_cond{
		no = 2101,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70016},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2102) ->
	#ai_cond{
		no = 2102,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70017},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2103) ->
	#ai_cond{
		no = 2103,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70018},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2104) ->
	#ai_cond{
		no = 2104,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70019},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2105) ->
	#ai_cond{
		no = 2105,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70020},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2106) ->
	#ai_cond{
		no = 2106,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70021},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2107) ->
	#ai_cond{
		no = 2107,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70022},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2108) ->
	#ai_cond{
		no = 2108,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70023},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2109) ->
	#ai_cond{
		no = 2109,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70024},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2110) ->
	#ai_cond{
		no = 2110,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70025},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2111) ->
	#ai_cond{
		no = 2111,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70026},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(2112) ->
	#ai_cond{
		no = 2112,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,70027},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30001) ->
	#ai_cond{
		no = 30001,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1027},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30002) ->
	#ai_cond{
		no = 30002,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1028},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30003) ->
	#ai_cond{
		no = 30003,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1029},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30004) ->
	#ai_cond{
		no = 30004,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1030},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30005) ->
	#ai_cond{
		no = 30005,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1031},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30006) ->
	#ai_cond{
		no = 30006,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1032},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30007) ->
	#ai_cond{
		no = 30007,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1033},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30008) ->
	#ai_cond{
		no = 30008,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1034},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30009) ->
	#ai_cond{
		no = 30009,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1035},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30010) ->
	#ai_cond{
		no = 30010,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1036},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30101) ->
	#ai_cond{
		no = 30101,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1127},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30102) ->
	#ai_cond{
		no = 30102,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1128},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30103) ->
	#ai_cond{
		no = 30103,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1129},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30104) ->
	#ai_cond{
		no = 30104,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1130},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30105) ->
	#ai_cond{
		no = 30105,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1131},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30106) ->
	#ai_cond{
		no = 30106,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1132},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30107) ->
	#ai_cond{
		no = 30107,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1133},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30108) ->
	#ai_cond{
		no = 30108,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1134},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30109) ->
	#ai_cond{
		no = 30109,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1135},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30110) ->
	#ai_cond{
		no = 30110,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1136},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30201) ->
	#ai_cond{
		no = 30201,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1227},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30202) ->
	#ai_cond{
		no = 30202,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1228},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30203) ->
	#ai_cond{
		no = 30203,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1229},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30204) ->
	#ai_cond{
		no = 30204,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1230},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30205) ->
	#ai_cond{
		no = 30205,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1231},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30206) ->
	#ai_cond{
		no = 30206,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1232},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30207) ->
	#ai_cond{
		no = 30207,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1233},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30208) ->
	#ai_cond{
		no = 30208,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1234},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30209) ->
	#ai_cond{
		no = 30209,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1235},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30210) ->
	#ai_cond{
		no = 30210,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1236},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30301) ->
	#ai_cond{
		no = 30301,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1309},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30302) ->
	#ai_cond{
		no = 30302,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1310},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30303) ->
	#ai_cond{
		no = 30303,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1311},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30304) ->
	#ai_cond{
		no = 30304,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1312},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30305) ->
	#ai_cond{
		no = 30305,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,1314},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(30306) ->
	#ai_cond{
		no = 30306,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",20}
};

get(50001) ->
	#ai_cond{
		no = 50001,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50001},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50002) ->
	#ai_cond{
		no = 50002,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50002},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50003) ->
	#ai_cond{
		no = 50003,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50003},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50004) ->
	#ai_cond{
		no = 50004,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50004},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50005) ->
	#ai_cond{
		no = 50005,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50005},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50006) ->
	#ai_cond{
		no = 50006,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50006},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50007) ->
	#ai_cond{
		no = 50007,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50007},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50008) ->
	#ai_cond{
		no = 50008,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50008},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50009) ->
	#ai_cond{
		no = 50009,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50009},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50010) ->
	#ai_cond{
		no = 50010,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50010},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50011) ->
	#ai_cond{
		no = 50011,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50011},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50012) ->
	#ai_cond{
		no = 50012,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50012},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50013) ->
	#ai_cond{
		no = 50013,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50013},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50014) ->
	#ai_cond{
		no = 50014,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50014},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50015) ->
	#ai_cond{
		no = 50015,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50015},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50016) ->
	#ai_cond{
		no = 50016,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50016},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50017) ->
	#ai_cond{
		no = 50017,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50017},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50018) ->
	#ai_cond{
		no = 50018,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50018},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50019) ->
	#ai_cond{
		no = 50019,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50019},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50020) ->
	#ai_cond{
		no = 50020,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50020},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50021) ->
	#ai_cond{
		no = 50021,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50021},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50022) ->
	#ai_cond{
		no = 50022,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50022},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50023) ->
	#ai_cond{
		no = 50023,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50023},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50024) ->
	#ai_cond{
		no = 50024,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50024},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50025) ->
	#ai_cond{
		no = 50025,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50025},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50026) ->
	#ai_cond{
		no = 50026,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50026},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50027) ->
	#ai_cond{
		no = 50027,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50027},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50028) ->
	#ai_cond{
		no = 50028,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50028},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50029) ->
	#ai_cond{
		no = 50029,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50029},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50030) ->
	#ai_cond{
		no = 50030,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50030},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50031) ->
	#ai_cond{
		no = 50031,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50031},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50032) ->
	#ai_cond{
		no = 50032,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50032},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50033) ->
	#ai_cond{
		no = 50033,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50033},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50034) ->
	#ai_cond{
		no = 50034,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50034},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50035) ->
	#ai_cond{
		no = 50035,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50035},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50036) ->
	#ai_cond{
		no = 50036,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50036},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50037) ->
	#ai_cond{
		no = 50037,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50037},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50038) ->
	#ai_cond{
		no = 50038,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50038},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50039) ->
	#ai_cond{
		no = 50039,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50039},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50040) ->
	#ai_cond{
		no = 50040,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50040},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50041) ->
	#ai_cond{
		no = 50041,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50041},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50042) ->
	#ai_cond{
		no = 50042,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50042},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50043) ->
	#ai_cond{
		no = 50043,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50043},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50044) ->
	#ai_cond{
		no = 50044,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50044},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50051) ->
	#ai_cond{
		no = 50051,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 50017}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50052) ->
	#ai_cond{
		no = 50052,
		rules_filter_bo_L = [ally_side, undead, {cur_hp_percentage_lower_than, 50}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50053) ->
	#ai_cond{
		no = 50053,
		rules_filter_bo_L = [ally_side, undead, {has_spec_no_buff, 50022}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(50054) ->
	#ai_cond{
		no = 50054,
		rules_filter_bo_L = [enemy_side, undead, {has_not_spec_no_buff, 50011}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50055) ->
	#ai_cond{
		no = 50055,
		rules_filter_bo_L = [enemy_side, undead, {has_not_spec_no_buff, 50027}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50056) ->
	#ai_cond{
		no = 50056,
		rules_filter_bo_L = [enemy_side, undead, {cur_hp_percentage_lower_than, 20}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50057) ->
	#ai_cond{
		no = 50057,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,2},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50058) ->
	#ai_cond{
		no = 50058,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,2},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(50059) ->
	#ai_cond{
		no = 50059,
		rules_filter_bo_L = [ally_side, undead, {has_spec_no_buff, 50008}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(50060) ->
	#ai_cond{
		no = 50060,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50201) ->
	#ai_cond{
		no = 50201,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50201},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50202) ->
	#ai_cond{
		no = 50202,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50202},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50203) ->
	#ai_cond{
		no = 50203,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50203},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50211) ->
	#ai_cond{
		no = 50211,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50211},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50212) ->
	#ai_cond{
		no = 50212,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50212},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50213) ->
	#ai_cond{
		no = 50213,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50213},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50221) ->
	#ai_cond{
		no = 50221,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50221},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50222) ->
	#ai_cond{
		no = 50222,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50222},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50223) ->
	#ai_cond{
		no = 50223,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50223},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50224) ->
	#ai_cond{
		no = 50224,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50224},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50225) ->
	#ai_cond{
		no = 50225,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50225},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50226) ->
	#ai_cond{
		no = 50226,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50226},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50231) ->
	#ai_cond{
		no = 50231,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50231},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50232) ->
	#ai_cond{
		no = 50232,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50232},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50233) ->
	#ai_cond{
		no = 50233,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50233},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50234) ->
	#ai_cond{
		no = 50234,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50234},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50241) ->
	#ai_cond{
		no = 50241,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50241},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50242) ->
	#ai_cond{
		no = 50242,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50242},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50243) ->
	#ai_cond{
		no = 50243,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50243},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50244) ->
	#ai_cond{
		no = 50244,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50244},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50251) ->
	#ai_cond{
		no = 50251,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50251},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50252) ->
	#ai_cond{
		no = 50252,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50252},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50253) ->
	#ai_cond{
		no = 50253,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50253},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50254) ->
	#ai_cond{
		no = 50254,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50254},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50261) ->
	#ai_cond{
		no = 50261,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50261},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50262) ->
	#ai_cond{
		no = 50262,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50262},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50263) ->
	#ai_cond{
		no = 50263,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50263},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50264) ->
	#ai_cond{
		no = 50264,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50264},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50265) ->
	#ai_cond{
		no = 50265,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50265},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50266) ->
	#ai_cond{
		no = 50266,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50266},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50267) ->
	#ai_cond{
		no = 50267,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50267},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50268) ->
	#ai_cond{
		no = 50268,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50268},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50280) ->
	#ai_cond{
		no = 50280,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",50}
};

get(50281) ->
	#ai_cond{
		no = 50281,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50281},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50282) ->
	#ai_cond{
		no = 50282,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50282},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50283) ->
	#ai_cond{
		no = 50283,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50283},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50284) ->
	#ai_cond{
		no = 50284,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50284},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50285) ->
	#ai_cond{
		no = 50285,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50285},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50286) ->
	#ai_cond{
		no = 50286,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50286},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50287) ->
	#ai_cond{
		no = 50287,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50287},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50288) ->
	#ai_cond{
		no = 50288,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50288},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50300) ->
	#ai_cond{
		no = 50300,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(50301) ->
	#ai_cond{
		no = 50301,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50301},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50302) ->
	#ai_cond{
		no = 50302,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50302},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50303) ->
	#ai_cond{
		no = 50303,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50303},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50304) ->
	#ai_cond{
		no = 50304,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50304},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50305) ->
	#ai_cond{
		no = 50305,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50305},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50306) ->
	#ai_cond{
		no = 50306,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50306},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50307) ->
	#ai_cond{
		no = 50307,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50307},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50308) ->
	#ai_cond{
		no = 50308,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50308},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50309) ->
	#ai_cond{
		no = 50309,
		rules_filter_bo_L = [enemy_side, undead, {cur_hp_percentage_lower_than, 50}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50310) ->
	#ai_cond{
		no = 50310,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50310},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50311) ->
	#ai_cond{
		no = 50311,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50311},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50312) ->
	#ai_cond{
		no = 50312,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50312},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50313) ->
	#ai_cond{
		no = 50313,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50313},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50314) ->
	#ai_cond{
		no = 50314,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50314},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50315) ->
	#ai_cond{
		no = 50315,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50315},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50316) ->
	#ai_cond{
		no = 50316,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50316},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50317) ->
	#ai_cond{
		no = 50317,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50317},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50318) ->
	#ai_cond{
		no = 50318,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50318},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50319) ->
	#ai_cond{
		no = 50319,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50319},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50321) ->
	#ai_cond{
		no = 50321,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50321},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50322) ->
	#ai_cond{
		no = 50322,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50322},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50323) ->
	#ai_cond{
		no = 50323,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50323},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50324) ->
	#ai_cond{
		no = 50324,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50324},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50325) ->
	#ai_cond{
		no = 50325,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50325},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50326) ->
	#ai_cond{
		no = 50326,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50326},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50327) ->
	#ai_cond{
		no = 50327,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50327},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50328) ->
	#ai_cond{
		no = 50328,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50328},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50329) ->
	#ai_cond{
		no = 50329,
		rules_filter_bo_L = [ally_side, undead, {cur_hp_percentage_lower_than, 70}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50330) ->
	#ai_cond{
		no = 50330,
		rules_filter_bo_L = [enemy_side, undead, {cur_hp_percentage_lower_than, 20}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50331) ->
	#ai_cond{
		no = 50331,
		rules_filter_bo_L = [ally_side, undead, {cur_hp_percentage_lower_than, 90}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50332) ->
	#ai_cond{
		no = 50332,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50332},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50333) ->
	#ai_cond{
		no = 50333,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50333},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50334) ->
	#ai_cond{
		no = 50334,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50334},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50335) ->
	#ai_cond{
		no = 50335,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50335},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50341) ->
	#ai_cond{
		no = 50341,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50341},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50342) ->
	#ai_cond{
		no = 50342,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50342},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50343) ->
	#ai_cond{
		no = 50343,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50343},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50344) ->
	#ai_cond{
		no = 50344,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50344},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50345) ->
	#ai_cond{
		no = 50345,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50345},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50346) ->
	#ai_cond{
		no = 50346,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50346},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50347) ->
	#ai_cond{
		no = 50347,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50347},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50348) ->
	#ai_cond{
		no = 50348,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50348},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50361) ->
	#ai_cond{
		no = 50361,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50361},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50362) ->
	#ai_cond{
		no = 50362,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50362},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50363) ->
	#ai_cond{
		no = 50363,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50363},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50364) ->
	#ai_cond{
		no = 50364,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50364},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50365) ->
	#ai_cond{
		no = 50365,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50365},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50366) ->
	#ai_cond{
		no = 50366,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50366},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50381) ->
	#ai_cond{
		no = 50381,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50381},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50382) ->
	#ai_cond{
		no = 50382,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50382},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50383) ->
	#ai_cond{
		no = 50383,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50383},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50384) ->
	#ai_cond{
		no = 50384,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50384},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50385) ->
	#ai_cond{
		no = 50385,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50385},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50386) ->
	#ai_cond{
		no = 50386,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50386},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50401) ->
	#ai_cond{
		no = 50401,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50401},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50402) ->
	#ai_cond{
		no = 50402,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50402},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50403) ->
	#ai_cond{
		no = 50403,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50403},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50404) ->
	#ai_cond{
		no = 50404,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50404},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50405) ->
	#ai_cond{
		no = 50405,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50405},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50406) ->
	#ai_cond{
		no = 50406,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50406},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50500) ->
	#ai_cond{
		no = 50500,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,2},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(50501) ->
	#ai_cond{
		no = 50501,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50501},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50502) ->
	#ai_cond{
		no = 50502,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50502},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50503) ->
	#ai_cond{
		no = 50503,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50503},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50511) ->
	#ai_cond{
		no = 50511,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50511},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50512) ->
	#ai_cond{
		no = 50512,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50512},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50513) ->
	#ai_cond{
		no = 50513,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50513},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50521) ->
	#ai_cond{
		no = 50521,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50521},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50522) ->
	#ai_cond{
		no = 50522,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50522},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50523) ->
	#ai_cond{
		no = 50523,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50523},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50531) ->
	#ai_cond{
		no = 50531,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50531},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50532) ->
	#ai_cond{
		no = 50532,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50532},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(50533) ->
	#ai_cond{
		no = 50533,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,50533},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000001) ->
	#ai_cond{
		no = 1000001,
		rules_filter_bo_L = [none],
		attr_L = {remainder_of_cur_round_div_by_N,3},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000002) ->
	#ai_cond{
		no = 1000002,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",50}
};

get(1000003) ->
	#ai_cond{
		no = 1000003,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62149},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000004) ->
	#ai_cond{
		no = 1000004,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",60}
};

get(1000005) ->
	#ai_cond{
		no = 1000005,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",70}
};

get(1000006) ->
	#ai_cond{
		no = 1000006,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62151},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000007) ->
	#ai_cond{
		no = 1000007,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62150},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000008) ->
	#ai_cond{
		no = 1000008,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62152},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000009) ->
	#ai_cond{
		no = 1000009,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 4081}, {has_not_spec_no_buff, 4082}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000010) ->
	#ai_cond{
		no = 1000010,
		rules_filter_bo_L = [ally_side, {pos_equal_to, 2}, is_fallen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000011) ->
	#ai_cond{
		no = 1000011,
		rules_filter_bo_L = [ally_side, {pos_equal_to, 2},undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000012) ->
	#ai_cond{
		no = 1000012,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000013) ->
	#ai_cond{
		no = 1000013,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000014) ->
	#ai_cond{
		no = 1000014,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000015) ->
	#ai_cond{
		no = 1000015,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62154},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000016) ->
	#ai_cond{
		no = 1000016,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62155},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000017) ->
	#ai_cond{
		no = 1000017,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62156},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000018) ->
	#ai_cond{
		no = 1000018,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62156},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000019) ->
	#ai_cond{
		no = 1000019,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62157},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000020) ->
	#ai_cond{
		no = 1000020,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62156},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000021) ->
	#ai_cond{
		no = 1000021,
		rules_filter_bo_L = [enemy_side, undead,{belong_to_faction, 1}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000022) ->
	#ai_cond{
		no = 1000022,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000023) ->
	#ai_cond{
		no = 1000023,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(1000024) ->
	#ai_cond{
		no = 1000024,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62156},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000025) ->
	#ai_cond{
		no = 1000025,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62155},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000026) ->
	#ai_cond{
		no = 1000026,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000027) ->
	#ai_cond{
		no = 1000027,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(1000028) ->
	#ai_cond{
		no = 1000028,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000029) ->
	#ai_cond{
		no = 1000029,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62151},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000030) ->
	#ai_cond{
		no = 1000030,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",4}
};

get(1000031) ->
	#ai_cond{
		no = 1000031,
		rules_filter_bo_L = [ally_side, undead, is_under_control, is_not_cding, is_not_xuliing],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000032) ->
	#ai_cond{
		no = 1000032,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,400009},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000033) ->
	#ai_cond{
		no = 1000033,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,400010},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000034) ->
	#ai_cond{
		no = 1000034,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000035) ->
	#ai_cond{
		no = 1000035,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(1000036) ->
	#ai_cond{
		no = 1000036,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000037) ->
	#ai_cond{
		no = 1000037,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62158},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000038) ->
	#ai_cond{
		no = 1000038,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen, {pos_equal_to, 3}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000039) ->
	#ai_cond{
		no = 1000039,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen, {pos_equal_to, 4}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000040) ->
	#ai_cond{
		no = 1000040,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen, {pos_equal_to, 5}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000041) ->
	#ai_cond{
		no = 1000041,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen, {pos_equal_to, 6}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000042) ->
	#ai_cond{
		no = 1000042,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen, {pos_equal_to, 7}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000043) ->
	#ai_cond{
		no = 1000043,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen, {pos_equal_to, 8}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000044) ->
	#ai_cond{
		no = 1000044,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen, {pos_equal_to, 9}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000045) ->
	#ai_cond{
		no = 1000045,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen, {pos_equal_to, 10}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000046) ->
	#ai_cond{
		no = 1000046,
		rules_filter_bo_L = [enemy_side, undead,{belong_to_faction, 2}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000047) ->
	#ai_cond{
		no = 1000047,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62154},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000048) ->
	#ai_cond{
		no = 1000048,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62155},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000049) ->
	#ai_cond{
		no = 1000049,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",25}
};

get(1000050) ->
	#ai_cond{
		no = 1000050,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",5}
};

get(1000051) ->
	#ai_cond{
		no = 1000051,
		rules_filter_bo_L = [enemy_side, undead,  {has_spec_no_buff, 4026}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000052) ->
	#ai_cond{
		no = 1000052,
		rules_filter_bo_L = [enemy_side, undead,  {has_spec_no_buff, 4036}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000053) ->
	#ai_cond{
		no = 1000053,
		rules_filter_bo_L = [enemy_side, undead,  {has_spec_no_buff, 1019}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000054) ->
	#ai_cond{
		no = 1000054,
		rules_filter_bo_L = [enemy_side, undead,  {has_spec_no_buff, 1020}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000055) ->
	#ai_cond{
		no = 1000055,
		rules_filter_bo_L = [enemy_side, undead,  {has_spec_no_buff, 4026}, {cur_hp_percentage_lower_than, 30}],
		attr_L = cur_hp,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",30}
};

get(1000056) ->
	#ai_cond{
		no = 1000056,
		rules_filter_bo_L = [enemy_side, undead,  {has_spec_no_buff, 4036}, {cur_hp_percentage_lower_than, 30}],
		attr_L = cur_hp,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",30}
};

get(1000057) ->
	#ai_cond{
		no = 1000057,
		rules_filter_bo_L = [enemy_side, undead,  {has_spec_no_buff, 1019}, {cur_hp_percentage_lower_than, 30}],
		attr_L = cur_hp,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",30}
};

get(1000058) ->
	#ai_cond{
		no = 1000058,
		rules_filter_bo_L = [enemy_side, undead,  {has_spec_no_buff, 1020}, {cur_hp_percentage_lower_than, 30}],
		attr_L = cur_hp,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",30}
};

get(1000059) ->
	#ai_cond{
		no = 1000059,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62159},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000060) ->
	#ai_cond{
		no = 1000060,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",25}
};

get(1000061) ->
	#ai_cond{
		no = 1000061,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",5}
};

get(1000062) ->
	#ai_cond{
		no = 1000062,
		rules_filter_bo_L = [ally_side, undead, is_under_control, is_not_cding, is_not_xuliing],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000063) ->
	#ai_cond{
		no = 1000063,
		rules_filter_bo_L = [ally_side, undead,  {has_not_spec_no_buff, 35}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000064) ->
	#ai_cond{
		no = 1000064,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62167},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000065) ->
	#ai_cond{
		no = 1000065,
		rules_filter_bo_L = [enemy_side, undead, is_under_control, is_not_cding, is_not_xuliing],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000066) ->
	#ai_cond{
		no = 1000066,
		rules_filter_bo_L = [ally_side, undead,  {has_not_spec_no_buff, 4025}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000067) ->
	#ai_cond{
		no = 1000067,
		rules_filter_bo_L = [ally_side, undead,  {has_not_spec_no_buff, 4092}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000068) ->
	#ai_cond{
		no = 1000068,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000069) ->
	#ai_cond{
		no = 1000069,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62161},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000070) ->
	#ai_cond{
		no = 1000070,
		rules_filter_bo_L = [enemy_side, {belong_to_faction, 6}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000071) ->
	#ai_cond{
		no = 1000071,
		rules_filter_bo_L = [enemy_side, {belong_to_faction,4}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000072) ->
	#ai_cond{
		no = 1000072,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62160},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000073) ->
	#ai_cond{
		no = 1000073,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000074) ->
	#ai_cond{
		no = 1000074,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62151},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000075) ->
	#ai_cond{
		no = 1000075,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000076) ->
	#ai_cond{
		no = 1000076,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62155},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000077) ->
	#ai_cond{
		no = 1000077,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000078) ->
	#ai_cond{
		no = 1000078,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62154},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000079) ->
	#ai_cond{
		no = 1000079,
		rules_filter_bo_L = [ally_side, undead,{cur_hp_percentage_lower_than, 50}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000080) ->
	#ai_cond{
		no = 1000080,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62162},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000081) ->
	#ai_cond{
		no = 1000081,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62163},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000082) ->
	#ai_cond{
		no = 1000082,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,400010},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000083) ->
	#ai_cond{
		no = 1000083,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000084) ->
	#ai_cond{
		no = 1000084,
		rules_filter_bo_L = [myself],
		attr_L = {remainder_of_cur_round_div_by_N,2},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000085) ->
	#ai_cond{
		no = 1000085,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62165},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000086) ->
	#ai_cond{
		no = 1000086,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62164},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000087) ->
	#ai_cond{
		no = 1000087,
		rules_filter_bo_L = [ally_side, undead, {has_spec_no_buff, 35}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000088) ->
	#ai_cond{
		no = 1000088,
		rules_filter_bo_L = [ally_side, undead, {has_spec_no_buff, 4025}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000089) ->
	#ai_cond{
		no = 1000089,
		rules_filter_bo_L = [ally_side, undead, {has_spec_no_buff, 4092}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000090) ->
	#ai_cond{
		no = 1000090,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62184},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000091) ->
	#ai_cond{
		no = 1000091,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62190},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000092) ->
	#ai_cond{
		no = 1000092,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62170},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000093) ->
	#ai_cond{
		no = 1000093,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62172},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000094) ->
	#ai_cond{
		no = 1000094,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62171},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000095) ->
	#ai_cond{
		no = 1000095,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62173},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000096) ->
	#ai_cond{
		no = 1000096,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62174},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000097) ->
	#ai_cond{
		no = 1000097,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62183},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000098) ->
	#ai_cond{
		no = 1000098,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62198},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000099) ->
	#ai_cond{
		no = 1000099,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62184},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000100) ->
	#ai_cond{
		no = 1000100,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62185},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000101) ->
	#ai_cond{
		no = 1000101,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62186},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000102) ->
	#ai_cond{
		no = 1000102,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",60}
};

get(1000103) ->
	#ai_cond{
		no = 1000103,
		rules_filter_bo_L = [ally_side, undead, is_under_control, is_not_cding, is_not_xuliing],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000104) ->
	#ai_cond{
		no = 1000104,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000105) ->
	#ai_cond{
		no = 1000105,
		rules_filter_bo_L = [enemy_side, undead, {cur_hp_percentage_lower_than, 20}, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000106) ->
	#ai_cond{
		no = 1000106,
		rules_filter_bo_L = [enemy_side, is_partner, undead],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000107) ->
	#ai_cond{
		no = 1000107,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 12}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000108) ->
	#ai_cond{
		no = 1000108,
		rules_filter_bo_L = [myself,  {has_spec_no_buff, 12}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000109) ->
	#ai_cond{
		no = 1000109,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000110) ->
	#ai_cond{
		no = 1000110,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",20}
};

get(1000111) ->
	#ai_cond{
		no = 1000111,
		rules_filter_bo_L = [enemy_side, undead,{belong_to_faction, 1}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000112) ->
	#ai_cond{
		no = 1000112,
		rules_filter_bo_L = [enemy_side, undead, {belong_to_faction, 6}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000113) ->
	#ai_cond{
		no = 1000113,
		rules_filter_bo_L = [enemy_side, undead,{belong_to_faction, 1}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000114) ->
	#ai_cond{
		no = 1000114,
		rules_filter_bo_L = [enemy_side, undead,{belong_to_faction, 4}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000115) ->
	#ai_cond{
		no = 1000115,
		rules_filter_bo_L = [enemy_side, undead,{belong_to_faction, 3}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000116) ->
	#ai_cond{
		no = 1000116,
		rules_filter_bo_L = [enemy_side, undead,{belong_to_faction, 5}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000117) ->
	#ai_cond{
		no = 1000117,
		rules_filter_bo_L = [enemy_side, undead,{belong_to_faction, 3}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000118) ->
	#ai_cond{
		no = 1000118,
		rules_filter_bo_L = [enemy_side, undead,{belong_to_faction, 6}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000119) ->
	#ai_cond{
		no = 1000119,
		rules_filter_bo_L = [enemy_side, is_partner, undead, is_not_trance],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000120) ->
	#ai_cond{
		no = 1000120,
		rules_filter_bo_L = [enemy_side, is_partner, undead, is_trance],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000121) ->
	#ai_cond{
		no = 1000121,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62168},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000122) ->
	#ai_cond{
		no = 1000122,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000123) ->
	#ai_cond{
		no = 1000123,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000124) ->
	#ai_cond{
		no = 1000124,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 12}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000125) ->
	#ai_cond{
		no = 1000125,
		rules_filter_bo_L = [myself,  {has_spec_no_buff, 12}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000126) ->
	#ai_cond{
		no = 1000126,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {pos_equal_to, 1}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000127) ->
	#ai_cond{
		no = 1000127,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {pos_equal_to, 2}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000128) ->
	#ai_cond{
		no = 1000128,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {pos_equal_to, 3}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000129) ->
	#ai_cond{
		no = 1000129,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {pos_equal_to, 4}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000130) ->
	#ai_cond{
		no = 1000130,
		rules_filter_bo_L = [enemy_side, undead, is_not_frozen, {pos_equal_to, 5}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000131) ->
	#ai_cond{
		no = 1000131,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",50}
};

get(1000132) ->
	#ai_cond{
		no = 1000132,
		rules_filter_bo_L = [none],
		attr_L = {remainder_of_cur_round_div_by_N,1},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000133) ->
	#ai_cond{
		no = 1000133,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000134) ->
	#ai_cond{
		no = 1000134,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000135) ->
	#ai_cond{
		no = 1000135,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",50}
};

get(1000136) ->
	#ai_cond{
		no = 1000136,
		rules_filter_bo_L = [ally_side, undead, is_under_control, is_not_cding, is_not_xuliing],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(1000137) ->
	#ai_cond{
		no = 1000137,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",20}
};

get(1000138) ->
	#ai_cond{
		no = 1000138,
		rules_filter_bo_L = [enemy_side, undead,{belong_to_faction, 3}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000139) ->
	#ai_cond{
		no = 1000139,
		rules_filter_bo_L = [enemy_side, undead, {belong_to_faction, 6}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000140) ->
	#ai_cond{
		no = 1000140,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",25}
};

get(1000141) ->
	#ai_cond{
		no = 1000141,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000142) ->
	#ai_cond{
		no = 1000142,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000143) ->
	#ai_cond{
		no = 1000143,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",7}
};

get(1000144) ->
	#ai_cond{
		no = 1000144,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,400019},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000145) ->
	#ai_cond{
		no = 1000145,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62188},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000146) ->
	#ai_cond{
		no = 1000146,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62187},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000147) ->
	#ai_cond{
		no = 1000147,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62190},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000148) ->
	#ai_cond{
		no = 1000148,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62189},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000149) ->
	#ai_cond{
		no = 1000149,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",40}
};

get(1000150) ->
	#ai_cond{
		no = 1000150,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",30}
};

get(1000151) ->
	#ai_cond{
		no = 1000151,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",25}
};

get(1000152) ->
	#ai_cond{
		no = 1000152,
		rules_filter_bo_L = [enemy_side, is_partner, undead],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000153) ->
	#ai_cond{
		no = 1000153,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 35}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000154) ->
	#ai_cond{
		no = 1000154,
		rules_filter_bo_L = [myself,  {has_spec_no_buff, 35}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000160) ->
	#ai_cond{
		no = 1000160,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62175},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000161) ->
	#ai_cond{
		no = 1000161,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62178},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000162) ->
	#ai_cond{
		no = 1000162,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62176},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000163) ->
	#ai_cond{
		no = 1000163,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62177},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000164) ->
	#ai_cond{
		no = 1000164,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62179},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000165) ->
	#ai_cond{
		no = 1000165,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62181},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000166) ->
	#ai_cond{
		no = 1000166,
		rules_filter_bo_L = [enemy_side, undead, has_invisible_eff],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(1000167) ->
	#ai_cond{
		no = 1000167,
		rules_filter_bo_L = [enemy_side, undead, has_invisible_eff],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000168) ->
	#ai_cond{
		no = 1000168,
		rules_filter_bo_L = [enemy_side, undead,  {has_spec_no_buff, 4024}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",7}
};

get(1000169) ->
	#ai_cond{
		no = 1000169,
		rules_filter_bo_L = [ally_side, undead, {cur_hp_percentage_lower_than, 50}, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000170) ->
	#ai_cond{
		no = 1000170,
		rules_filter_bo_L = [ally_side, undead,  {has_not_spec_no_buff, 4080}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000171) ->
	#ai_cond{
		no = 1000171,
		rules_filter_bo_L = [ally_side, undead,  {has_spec_no_buff, 4080}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",6}
};

get(1000172) ->
	#ai_cond{
		no = 1000172,
		rules_filter_bo_L = [enemy_side, undead,is_not_frozen,{cur_hp_percentage_lower_than, 10},{pos_equal_to, 1}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000173) ->
	#ai_cond{
		no = 1000173,
		rules_filter_bo_L = [enemy_side, undead,is_not_frozen,{cur_hp_percentage_lower_than, 10},{pos_equal_to, 2}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000174) ->
	#ai_cond{
		no = 1000174,
		rules_filter_bo_L = [enemy_side, undead,is_not_frozen,{cur_hp_percentage_lower_than, 10},{pos_equal_to, 3}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000175) ->
	#ai_cond{
		no = 1000175,
		rules_filter_bo_L = [enemy_side, undead,is_not_frozen,{cur_hp_percentage_lower_than, 10},{pos_equal_to, 4}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000176) ->
	#ai_cond{
		no = 1000176,
		rules_filter_bo_L = [enemy_side, undead,is_not_frozen,{cur_hp_percentage_lower_than, 10},{pos_equal_to, 5}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000177) ->
	#ai_cond{
		no = 1000177,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",25}
};

get(1000178) ->
	#ai_cond{
		no = 1000178,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000180) ->
	#ai_cond{
		no = 1000180,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62191},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000181) ->
	#ai_cond{
		no = 1000181,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62192},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000182) ->
	#ai_cond{
		no = 1000182,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62193},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000183) ->
	#ai_cond{
		no = 1000183,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62194},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000184) ->
	#ai_cond{
		no = 1000184,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62195},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000185) ->
	#ai_cond{
		no = 1000185,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62196},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000186) ->
	#ai_cond{
		no = 1000186,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,62197},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000187) ->
	#ai_cond{
		no = 1000187,
		rules_filter_bo_L = [ally_side, undead, {cur_hp_percentage_lower_than, 20}, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(1000188) ->
	#ai_cond{
		no = 1000188,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",2}
};

get(1000189) ->
	#ai_cond{
		no = 1000189,
		rules_filter_bo_L = [ally_side, undead, {cur_hp_percentage_lower_than, 40}, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",4}
};

get(1000190) ->
	#ai_cond{
		no = 1000190,
		rules_filter_bo_L = [none],
		attr_L = cur_round,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",3}
};

get(1000191) ->
	#ai_cond{
		no = 1000191,
		rules_filter_bo_L = [enemy_side, undead, {cur_hp_percentage_lower_than, 5}, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000192) ->
	#ai_cond{
		no = 1000192,
		rules_filter_bo_L = [ally_side, undead,  {has_not_spec_no_buff, 4022}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000193) ->
	#ai_cond{
		no = 1000193,
		rules_filter_bo_L = [ally_side, undead,  {has_spec_no_buff, 4022}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000194) ->
	#ai_cond{
		no = 1000194,
		rules_filter_bo_L = [myself, undead, is_under_control, is_not_cding, is_not_xuliing],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000195) ->
	#ai_cond{
		no = 1000195,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",25}
};

get(1000196) ->
	#ai_cond{
		no = 1000196,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000197) ->
	#ai_cond{
		no = 1000197,
		rules_filter_bo_L = [none],
		attr_L = {remainder_of_cur_round_div_by_N,1},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000198) ->
	#ai_cond{
		no = 1000198,
		rules_filter_bo_L = [ally_side, undead,  {has_not_spec_no_buff, 4097}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000199) ->
	#ai_cond{
		no = 1000199,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,400020},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000200) ->
	#ai_cond{
		no = 1000200,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,400021},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000201) ->
	#ai_cond{
		no = 1000201,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",50}
};

get(1000202) ->
	#ai_cond{
		no = 1000202,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000203) ->
	#ai_cond{
		no = 1000203,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",33}
};

get(1000204) ->
	#ai_cond{
		no = 1000204,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000205) ->
	#ai_cond{
		no = 1000205,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",25}
};

get(1000206) ->
	#ai_cond{
		no = 1000206,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000207) ->
	#ai_cond{
		no = 1000207,
		rules_filter_bo_L = [myself],
		attr_L = cur_hp_percentage,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",18}
};

get(1000208) ->
	#ai_cond{
		no = 1000208,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",10}
};

get(1000209) ->
	#ai_cond{
		no = 1000209,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",7}
};

get(1000210) ->
	#ai_cond{
		no = 1000210,
		rules_filter_bo_L = [ally_side, undead, is_not_frozen],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "<=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",5}
};

get(1000211) ->
	#ai_cond{
		no = 1000211,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill,400022},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000212) ->
	#ai_cond{
		no = 1000212,
		rules_filter_bo_L = [enemy_side, undead, is_under_control, is_not_cding, is_not_xuliing],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = ">=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",0}
};

get(1000213) ->
	#ai_cond{
		no = 1000213,
		rules_filter_bo_L = [myself],
		attr_L = {is_can_use_skill, 62199},
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(1000214) ->
	#ai_cond{
		no = 1000214,
		rules_filter_bo_L = [myself, {has_not_spec_no_buff, 4103}],
		attr_L = filtered_bo_count,
		addi_value_L = {"+",0},
		cmp_symbol = "=",
		rules_filter_bo_R = [none],
		attr_R = no_attr,
		addi_value_R = {"+",1}
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

