%%%---------------------------------------
%%% @Module  : data_battle_buff
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2012-09-19  18:01:27
%%% @Description:  战斗系统的buff，自动生成（模板：battle_buff_erl.tpl.php）
%%%---------------------------------------

-module(data_battle_buff).
-export([get_buff_id/2]).

%% 依据buff的效果名和类型获取对应的buff编号

get_buff_id(phy_att_add, buff) ->
	1001;

get_buff_id(phy_att_add, debuff) ->
	1002;

get_buff_id(phy_def_add, buff) ->
	1003;

get_buff_id(phy_def_add, debuff) ->
	1004;

get_buff_id(mag_att_add, buff) ->
	1005;

get_buff_id(mag_att_add, debuff) ->
	1006;

get_buff_id(mag_def_add, buff) ->
	1007;

get_buff_id(mag_def_add, debuff) ->
	1008;

get_buff_id(stu_att_add, buff) ->
	1009;

get_buff_id(stu_att_add, debuff) ->
	1010;

get_buff_id(stu_def_add, buff) ->
	1011;

get_buff_id(stu_def_add, debuff) ->
	1012;

get_buff_id(phy_att_add_rate, buff) ->
	1013;

get_buff_id(phy_att_add_rate, debuff) ->
	1014;

get_buff_id(mag_att_add_rate, buff) ->
	1015;

get_buff_id(mag_att_add_rate, debuff) ->
	1016;

get_buff_id(stu_att_add_rate, buff) ->
	1017;

get_buff_id(stu_att_add_rate, debuff) ->
	1018;

get_buff_id(phy_def_add_rate, buff) ->
	1019;

get_buff_id(phy_def_add_rate, debuff) ->
	1020;

get_buff_id(mag_def_add_rate, buff) ->
	1021;

get_buff_id(mag_def_add_rate, debuff) ->
	1022;

get_buff_id(stu_def_add_rate, buff) ->
	1023;

get_buff_id(stu_def_add_rate, debuff) ->
	1024;

get_buff_id(hp_lim_add_rate, buff) ->
	1025;

get_buff_id(stun, debuff) ->
	1026;

get_buff_id(silence, debuff) ->
	1027;

get_buff_id(be_dam_add_rate, debuff) ->
	1028;

get_buff_id(be_dam_add_rate, buff) ->
	1029;

get_buff_id(trans_dam_to_phy_att, buff) ->
	1030;

get_buff_id(trans_dam_to_mag_att, buff) ->
	1031;

get_buff_id(trans_dam_to_stu_att, buff) ->
	1032;

get_buff_id(return_dam_shield, buff) ->
	1033;

get_buff_id(ward_off_dam_shield, buff) ->
	1034;

get_buff_id(add_dam_rate_by_crit, buff) ->
	1035;

get_buff_id(add_phy_att_rate_by_dodge, buff) ->
	1036;

get_buff_id(add_phy_att_rate_by_block, buff) ->
	1037;

get_buff_id(add_hp_rate_by_block, buff) ->
	1038;

get_buff_id(add_dam_rate_to_all_by_crit, buff) ->
	1039;

get_buff_id(ignore_phy_def, buff) ->
	1040;

get_buff_id(ignore_mag_def, buff) ->
	1041;

get_buff_id(ignore_stu_def, buff) ->
	1042;

get_buff_id(ignore_block, buff) ->
	1043;

get_buff_id(ignore_dodge, buff) ->
	1044;

get_buff_id(freeze_anger_add, debuff) ->
	1045;

get_buff_id(hp_add, buff) ->
	1046;

get_buff_id(avoid_hurt, buff) ->
	1047;

get_buff_id(extra_dam, debuff) ->
	1048;

get_buff_id(extra_dam_rate, debuff) ->
	1049;

get_buff_id(hp_sub_rate, debuff) ->
	1050;

get_buff_id(hp_lim_add_rate, debuff) ->
	1051;

get_buff_id(crit_rate_add, buff) ->
	1052;

get_buff_id(gain_anger_by_att, buff) ->
	1053;

get_buff_id(change_anger_speed, buff) ->
	1054;

get_buff_id(dodge_rate_add, buff) ->
	1055;
	
	
get_buff_id(_EffName, _BuffType) ->
    0.
