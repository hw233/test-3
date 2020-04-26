%%%---------------------------------------
%%% @Module  : data_skill_eff
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 技能效果
%%%---------------------------------------


-module(data_skill_eff).
-export([get/1]).
-include("effect.hrl").
-include("debug.hrl").

get(2) ->
	#skl_eff{
		no = 2,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_category, 4,999}
};

get(10) ->
	#skl_eff{
		no = 10,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(20) ->
	#skl_eff{
		no = 20,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_category_buff_first,2}],
		target_count = 1,
		para = 2
};

get(30) ->
	#skl_eff{
		no = 30,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_category_buff_first,2}],
		target_count = 1,
		para = 3
};

get(40) ->
	#skl_eff{
		no = 40,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first,{has_not_spec_buff_first,4021},sort_by_phy_att_desc],
		target_count = xinfa_related,
		para = 4021
};

get(50) ->
	#skl_eff{
		no = 50,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_category_buff_first,2}, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = 5
};

get(60) ->
	#skl_eff{
		no = 60,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_category_buff_first,2}, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = 6
};

get(70) ->
	#skl_eff{
		no = 70,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead, myself],
		rules_sort_target = [],
		target_count = 1,
		para = [4023, 4101]
};

get(110) ->
	#skl_eff{
		no = 110,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(111) ->
	#skl_eff{
		no = 111,
		name = tmp_force_set_phy_combo_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 2
};

get(112) ->
	#skl_eff{
		no = 112,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 37
};

get(113) ->
	#skl_eff{
		no = 113,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 19
};

get(114) ->
	#skl_eff{
		no = 114,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 20
};

get(115) ->
	#skl_eff{
		no = 115,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 4085
};

get(120) ->
	#skl_eff{
		no = 120,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = [7,33,34]
};

get(130) ->
	#skl_eff{
		no = 130,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {phy_att,phy_att,124,1.4}
};

get(131) ->
	#skl_eff{
		no = 131,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(140) ->
	#skl_eff{
		no = 140,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(141) ->
	#skl_eff{
		no = 141,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 11
};

get(150) ->
	#skl_eff{
		no = 150,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 12
};

get(151) ->
	#skl_eff{
		no = 151,
		name = do_attack,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(153) ->
	#skl_eff{
		no = 153,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [],
		target_count = 10,
		para = 4299
};

get(160) ->
	#skl_eff{
		no = 160,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(161) ->
	#skl_eff{
		no = 161,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 37
};

get(170) ->
	#skl_eff{
		no = 170,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [undead, myself],
		rules_sort_target = [],
		target_count = 1,
		para = 13
};

get(171) ->
	#skl_eff{
		no = 171,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(172) ->
	#skl_eff{
		no = 172,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first,{has_not_spec_buff_first,4094},sort_by_phy_att_desc],
		target_count = xinfa_related,
		para = 4094
};

get(210) ->
	#skl_eff{
		no = 210,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(211) ->
	#skl_eff{
		no = 211,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = infinite,
		para = 38
};

get(212) ->
	#skl_eff{
		no = 212,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_phy_def_desc],
		target_count = 1,
		para = [4024,4096]
};

get(220) ->
	#skl_eff{
		no = 220,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(221) ->
	#skl_eff{
		no = 221,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side,undead],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,4024}, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = [4024,4096]
};

get(230) ->
	#skl_eff{
		no = 230,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(231) ->
	#skl_eff{
		no = 231,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = xinfa_related,
		para = 40
};

get(232) ->
	#skl_eff{
		no = 232,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4080
};

get(233) ->
	#skl_eff{
		no = 233,
		name = revive,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = null
};

get(234) ->
	#skl_eff{
		no = 234,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,hp,117,0.5}
};

get(240) ->
	#skl_eff{
		no = 240,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(241) ->
	#skl_eff{
		no = 241,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = 4
};

get(242) ->
	#skl_eff{
		no = 242,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first,{has_not_spec_buff_first,35}],
		target_count = xinfa_related,
		para = [35,4025]
};

get(250) ->
	#skl_eff{
		no = 250,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_category_buff_first,4026}],
		target_count = 1,
		para = 4026
};

get(260) ->
	#skl_eff{
		no = 260,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,4027}, {has_not_spec_buff_first,4028}],
		target_count = 1,
		para = [4027,4028]
};

get(261) ->
	#skl_eff{
		no = 261,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(262) ->
	#skl_eff{
		no = 262,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,4093}],
		target_count = xinfa_related,
		para = 4100
};

get(270) ->
	#skl_eff{
		no = 270,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,43}],
		target_count = 1,
		para = 43
};

get(271) ->
	#skl_eff{
		no = 271,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 43
};

get(310) ->
	#skl_eff{
		no = 310,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(311) ->
	#skl_eff{
		no = 311,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 4030
};

get(320) ->
	#skl_eff{
		no = 320,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = [20,19]
};

get(330) ->
	#skl_eff{
		no = 330,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = [21,4013]
};

get(331) ->
	#skl_eff{
		no = 331,
		name = do_attack,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [not_frozen_first, cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(332) ->
	#skl_eff{
		no = 332,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [4030]}
};

get(333) ->
	#skl_eff{
		no = 333,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 4031
};

get(340) ->
	#skl_eff{
		no = 340,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = [22,4011]
};

get(341) ->
	#skl_eff{
		no = 341,
		name = do_attack,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [not_frozen_first, cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(350) ->
	#skl_eff{
		no = 350,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(351) ->
	#skl_eff{
		no = 351,
		name = tmp_force_set_pursue_att_proba,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(352) ->
	#skl_eff{
		no = 352,
		name = tmp_force_set_max_pursue_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 2
};

get(353) ->
	#skl_eff{
		no = 353,
		name = tmp_force_set_pursue_att_dam_coef,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 0.500000
};

get(360) ->
	#skl_eff{
		no = 360,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 23
};

get(361) ->
	#skl_eff{
		no = 361,
		name = do_attack,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [not_frozen_first, cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(370) ->
	#skl_eff{
		no = 370,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 44
};

get(371) ->
	#skl_eff{
		no = 371,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [not_frozen_first, cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(410) ->
	#skl_eff{
		no = 410,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(420) ->
	#skl_eff{
		no = 420,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(430) ->
	#skl_eff{
		no = 430,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,25}],
		target_count = 1,
		para = 25
};

get(440) ->
	#skl_eff{
		no = 440,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(441) ->
	#skl_eff{
		no = 441,
		name = tmp_mark_do_fix_mp_dam_by_xinfa_lv,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(442) ->
	#skl_eff{
		no = 442,
		name = reduce_target_mp_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(450) ->
	#skl_eff{
		no = 450,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,26}],
		target_count = xinfa_related,
		para = 26
};

get(460) ->
	#skl_eff{
		no = 460,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = [4079,4020,4018,4086]
};

get(470) ->
	#skl_eff{
		no = 470,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = xinfa_related,
		para = null
};

get(510) ->
	#skl_eff{
		no = 510,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(520) ->
	#skl_eff{
		no = 520,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first],
		target_count = 1,
		para = null
};

get(530) ->
	#skl_eff{
		no = 530,
		name = revive,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = null
};

get(531) ->
	#skl_eff{
		no = 531,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 4045
};

get(532) ->
	#skl_eff{
		no = 532,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4087
};

get(533) ->
	#skl_eff{
		no = 533,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_spec_category_buff_first, 2}],
		target_count = xinfa_related,
		para = {by_category,2,1}
};

get(534) ->
	#skl_eff{
		no = 534,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_spec_category_buff_first, 2}],
		target_count = xinfa_related,
		para = 4098
};

get(540) ->
	#skl_eff{
		no = 540,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_mp_asce],
		target_count = xinfa_related,
		para = 29
};

get(550) ->
	#skl_eff{
		no = 550,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,4019}, sort_by_mag_att_desc],
		target_count = xinfa_related,
		para = [4019,4022]
};

get(560) ->
	#skl_eff{
		no = 560,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,32}],
		target_count = xinfa_related,
		para = [32, 4097]
};

get(570) ->
	#skl_eff{
		no = 570,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(1000) ->
	#skl_eff{
		no = 1000,
		name = do_attack,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = xinfa_related,
		para = null
};

get(1001) ->
	#skl_eff{
		no = 1001,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(1002) ->
	#skl_eff{
		no = 1002,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 205
};

get(1003) ->
	#skl_eff{
		no = 1003,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(1004) ->
	#skl_eff{
		no = 1004,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(1005) ->
	#skl_eff{
		no = 1005,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {phy_att,phy_def,117,1}
};

get(1006) ->
	#skl_eff{
		no = 1006,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = [201,202,203]
};

get(1007) ->
	#skl_eff{
		no = 1007,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(1008) ->
	#skl_eff{
		no = 1008,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 206
};

get(1009) ->
	#skl_eff{
		no = 1009,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 204
};

get(1010) ->
	#skl_eff{
		no = 1010,
		name = tmp_kill_target_add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 1001
};

get(1011) ->
	#skl_eff{
		no = 1011,
		name = tmp_kill_target_add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 1002
};

get(1101) ->
	#skl_eff{
		no = 1101,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(1102) ->
	#skl_eff{
		no = 1102,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 301
};

get(1103) ->
	#skl_eff{
		no = 1103,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 10,
		para = null
};

get(1104) ->
	#skl_eff{
		no = 1104,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 3,
		para = null
};

get(1105) ->
	#skl_eff{
		no = 1105,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 302
};

get(1106) ->
	#skl_eff{
		no = 1106,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 3,
		para = null
};

get(1107) ->
	#skl_eff{
		no = 1107,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 303
};

get(1108) ->
	#skl_eff{
		no = 1108,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 10,
		para = null
};

get(1109) ->
	#skl_eff{
		no = 1109,
		name = tmp_select_first_cause_crit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 1
};

get(1201) ->
	#skl_eff{
		no = 1201,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(1202) ->
	#skl_eff{
		no = 1202,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 401
};

get(1203) ->
	#skl_eff{
		no = 1203,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(1204) ->
	#skl_eff{
		no = 1204,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 5,
		para = 402
};

get(1205) ->
	#skl_eff{
		no = 1205,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(1206) ->
	#skl_eff{
		no = 1206,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_eff_type,good,2}
};

get(1207) ->
	#skl_eff{
		no = 1207,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 300,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 5,
		para = {by_category,2,999}
};

get(1208) ->
	#skl_eff{
		no = 1208,
		name = tmp_select_target_add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 403
};

get(1209) ->
	#skl_eff{
		no = 1209,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 3,
		para = null
};

get(1210) ->
	#skl_eff{
		no = 1210,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 404
};

get(1211) ->
	#skl_eff{
		no = 1211,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 405
};

get(1212) ->
	#skl_eff{
		no = 1212,
		name = tmp_select_target_add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 406
};

get(1301) ->
	#skl_eff{
		no = 1301,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(1302) ->
	#skl_eff{
		no = 1302,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(1303) ->
	#skl_eff{
		no = 1303,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(1304) ->
	#skl_eff{
		no = 1304,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 502
};

get(1305) ->
	#skl_eff{
		no = 1305,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = 5,
		para = null
};

get(1306) ->
	#skl_eff{
		no = 1306,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = 3,
		para = 503
};

get(2001) ->
	#skl_eff{
		no = 2001,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 2005
};

get(2101) ->
	#skl_eff{
		no = 2101,
		name = tmp_target_count_add,
		need_perf_casting = 0,
		trigger_proba = 600,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 2
};

get(2102) ->
	#skl_eff{
		no = 2102,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 2104
};

get(2103) ->
	#skl_eff{
		no = 2103,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 2106
};

get(2201) ->
	#skl_eff{
		no = 2201,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [],
		target_count = 3,
		para = 2202
};

get(2202) ->
	#skl_eff{
		no = 2202,
		name = revive,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [ally_side, dead],
		rules_sort_target = [],
		target_count = 2,
		para = {hp_lim, 0.1}
};

get(2301) ->
	#skl_eff{
		no = 2301,
		name = tmp_target_count_add,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 3
};

get(2302) ->
	#skl_eff{
		no = 2302,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = [2303,2304]
};

get(2303) ->
	#skl_eff{
		no = 2303,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [2303,2304]}
};

get(2304) ->
	#skl_eff{
		no = 2304,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 2306
};

get(2305) ->
	#skl_eff{
		no = 2305,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = [2308,2309]
};

get(2306) ->
	#skl_eff{
		no = 2306,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [2308,2309]}
};

get(2401) ->
	#skl_eff{
		no = 2401,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_under_control],
		rules_sort_target = [],
		target_count = 10,
		para = 2403
};

get(2402) ->
	#skl_eff{
		no = 2402,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [],
		target_count = 10,
		para = {by_no_list, [2403]}
};

get(2403) ->
	#skl_eff{
		no = 2403,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [enemy_side, undead, is_under_control, is_not_boss_monster],
		rules_sort_target = [],
		target_count = 10,
		para = [2406,2407]
};

get(9997) ->
	#skl_eff{
		no = 9997,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 9997
};

get(9998) ->
	#skl_eff{
		no = 9998,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 9998
};

get(9999) ->
	#skl_eff{
		no = 9999,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 9999
};

get(10001) ->
	#skl_eff{
		no = 10001,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(10002) ->
	#skl_eff{
		no = 10002,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {act_speed,mag_att,116,999}
};

get(10003) ->
	#skl_eff{
		no = 10003,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(10004) ->
	#skl_eff{
		no = 10004,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {mag_att,hp,117,0.35}
};

get(10005) ->
	#skl_eff{
		no = 10005,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 3,
		para = null
};

get(10006) ->
	#skl_eff{
		no = 10006,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 60,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = 10003
};

get(10007) ->
	#skl_eff{
		no = 10007,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(10008) ->
	#skl_eff{
		no = 10008,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = [10004,10005]
};

get(10009) ->
	#skl_eff{
		no = 10009,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(10010) ->
	#skl_eff{
		no = 10010,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {act_speed,phy_att,116,999}
};

get(10011) ->
	#skl_eff{
		no = 10011,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(10012) ->
	#skl_eff{
		no = 10012,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {phy_att,hp,117,0.35}
};

get(10013) ->
	#skl_eff{
		no = 10013,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 3,
		para = null
};

get(10014) ->
	#skl_eff{
		no = 10014,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 60,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = 10008
};

get(10015) ->
	#skl_eff{
		no = 10015,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(10016) ->
	#skl_eff{
		no = 10016,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = [10009,10010]
};

get(10017) ->
	#skl_eff{
		no = 10017,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = null
};

get(10018) ->
	#skl_eff{
		no = 10018,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 5,
		para = null
};

get(10101) ->
	#skl_eff{
		no = 10101,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(10102) ->
	#skl_eff{
		no = 10102,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {act_speed,mag_att,116,999}
};

get(10103) ->
	#skl_eff{
		no = 10103,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(10104) ->
	#skl_eff{
		no = 10104,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {mag_att,hp,117,0.4}
};

get(10105) ->
	#skl_eff{
		no = 10105,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 3,
		para = null
};

get(10106) ->
	#skl_eff{
		no = 10106,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 80,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = 10103
};

get(10107) ->
	#skl_eff{
		no = 10107,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(10108) ->
	#skl_eff{
		no = 10108,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 350,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = [10104,10105]
};

get(10109) ->
	#skl_eff{
		no = 10109,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(10110) ->
	#skl_eff{
		no = 10110,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {act_speed,phy_att,116,999}
};

get(10111) ->
	#skl_eff{
		no = 10111,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(10112) ->
	#skl_eff{
		no = 10112,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {phy_att,hp,117,0.4}
};

get(10113) ->
	#skl_eff{
		no = 10113,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 3,
		para = null
};

get(10114) ->
	#skl_eff{
		no = 10114,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 80,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = 10108
};

get(10115) ->
	#skl_eff{
		no = 10115,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(10116) ->
	#skl_eff{
		no = 10116,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = [10109,10110]
};

get(10117) ->
	#skl_eff{
		no = 10117,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = null
};

get(10118) ->
	#skl_eff{
		no = 10118,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 5,
		para = null
};

get(10201) ->
	#skl_eff{
		no = 10201,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(10202) ->
	#skl_eff{
		no = 10202,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {act_speed,mag_att,116,999}
};

get(10203) ->
	#skl_eff{
		no = 10203,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(10204) ->
	#skl_eff{
		no = 10204,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {mag_att,hp,117,0.42}
};

get(10205) ->
	#skl_eff{
		no = 10205,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 3,
		para = null
};

get(10206) ->
	#skl_eff{
		no = 10206,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 100,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = 10203
};

get(10207) ->
	#skl_eff{
		no = 10207,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(10208) ->
	#skl_eff{
		no = 10208,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = [10204,10205]
};

get(10209) ->
	#skl_eff{
		no = 10209,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(10210) ->
	#skl_eff{
		no = 10210,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {act_speed,phy_att,116,999}
};

get(10211) ->
	#skl_eff{
		no = 10211,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(10212) ->
	#skl_eff{
		no = 10212,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {phy_att,hp,117,0.42}
};

get(10213) ->
	#skl_eff{
		no = 10213,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 3,
		para = null
};

get(10214) ->
	#skl_eff{
		no = 10214,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 100,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = 10229
};

get(10215) ->
	#skl_eff{
		no = 10215,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 5,
		para = null
};

get(10216) ->
	#skl_eff{
		no = 10216,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = [10230,10231]
};

get(10217) ->
	#skl_eff{
		no = 10217,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = null
};

get(10218) ->
	#skl_eff{
		no = 10218,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 5,
		para = null
};

get(10219) ->
	#skl_eff{
		no = 10219,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 10206
};

get(10220) ->
	#skl_eff{
		no = 10220,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, has_invisible_eff, is_not_frozen],
		rules_sort_target = [],
		target_count = 10,
		para = 10209
};

get(10221) ->
	#skl_eff{
		no = 10221,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, has_invisible_eff, is_not_frozen],
		rules_sort_target = [],
		target_count = 10,
		para = 10209
};

get(10301) ->
	#skl_eff{
		no = 10301,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 200,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 10,
		para = 10315
};

get(10302) ->
	#skl_eff{
		no = 10302,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [],
		target_count = 10,
		para = {by_category,2,999}
};

get(10303) ->
	#skl_eff{
		no = 10303,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [],
		target_count = 10,
		para = 10316
};

get(10304) ->
	#skl_eff{
		no = 10304,
		name = force_die_and_leave_battle,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(10305) ->
	#skl_eff{
		no = 10305,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 10317
};

get(10306) ->
	#skl_eff{
		no = 10306,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 10318
};

get(10307) ->
	#skl_eff{
		no = 10307,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side ,undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_eff_type,good,99}
};

get(10308) ->
	#skl_eff{
		no = 10308,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim, 1}
};

get(10309) ->
	#skl_eff{
		no = 10309,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 10319
};

get(13001) ->
	#skl_eff{
		no = 13001,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 4,
		para = null
};

get(13002) ->
	#skl_eff{
		no = 13002,
		name = reduce_target_anger_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 4,
		para = -60
};

get(13003) ->
	#skl_eff{
		no = 13003,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 4,
		para = 13001
};

get(13004) ->
	#skl_eff{
		no = 13004,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = null
};

get(13005) ->
	#skl_eff{
		no = 13005,
		name = reduce_target_anger_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 100
};

get(13006) ->
	#skl_eff{
		no = 13006,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 13001
};

get(13007) ->
	#skl_eff{
		no = 13007,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13002
};

get(13008) ->
	#skl_eff{
		no = 13008,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13003
};

get(13009) ->
	#skl_eff{
		no = 13009,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = {by_eff_type,good,99}
};

get(13010) ->
	#skl_eff{
		no = 13010,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13004,13005]
};

get(13011) ->
	#skl_eff{
		no = 13011,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_spec_category_buff_first, 2}],
		target_count = 10,
		para = {by_name_list, [chaos, cd, frozen, silent, trance]}
};

get(13012) ->
	#skl_eff{
		no = 13012,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13006
};

get(13013) ->
	#skl_eff{
		no = 13013,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 500,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13007,13008]
};

get(13014) ->
	#skl_eff{
		no = 13014,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13008
};

get(13015) ->
	#skl_eff{
		no = 13015,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 13009
};

get(13016) ->
	#skl_eff{
		no = 13016,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13010
};

get(13017) ->
	#skl_eff{
		no = 13017,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13011
};

get(13018) ->
	#skl_eff{
		no = 13018,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13012,13013]
};

get(13019) ->
	#skl_eff{
		no = 13019,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13014,13015]
};

get(13020) ->
	#skl_eff{
		no = 13020,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13016,13017]
};

get(13021) ->
	#skl_eff{
		no = 13021,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13018,13019]
};

get(13022) ->
	#skl_eff{
		no = 13022,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13020
};

get(13023) ->
	#skl_eff{
		no = 13023,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13021
};

get(13024) ->
	#skl_eff{
		no = 13024,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13022,13023]
};

get(13025) ->
	#skl_eff{
		no = 13025,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13024,13025]
};

get(13026) ->
	#skl_eff{
		no = 13026,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13026,13027]
};

get(13027) ->
	#skl_eff{
		no = 13027,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13028,13029]
};

get(13028) ->
	#skl_eff{
		no = 13028,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 400,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, no_act_bo],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 13030
};

get(13029) ->
	#skl_eff{
		no = 13029,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13031
};

get(13030) ->
	#skl_eff{
		no = 13030,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13032
};

get(13031) ->
	#skl_eff{
		no = 13031,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 13033
};

get(13101) ->
	#skl_eff{
		no = 13101,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 4,
		para = null
};

get(13102) ->
	#skl_eff{
		no = 13102,
		name = reduce_target_anger_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 4,
		para = -100
};

get(13103) ->
	#skl_eff{
		no = 13103,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 4,
		para = 13001
};

get(13104) ->
	#skl_eff{
		no = 13104,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = null
};

get(13105) ->
	#skl_eff{
		no = 13105,
		name = reduce_target_anger_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 150
};

get(13106) ->
	#skl_eff{
		no = 13106,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 13101
};

get(13107) ->
	#skl_eff{
		no = 13107,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13102
};

get(13108) ->
	#skl_eff{
		no = 13108,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13103
};

get(13109) ->
	#skl_eff{
		no = 13109,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 5,
		para = {by_eff_type,good,99}
};

get(13110) ->
	#skl_eff{
		no = 13110,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13104,13105]
};

get(13111) ->
	#skl_eff{
		no = 13111,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_spec_category_buff_first, 2}],
		target_count = 10,
		para = {by_name_list, [chaos, cd, frozen, silent, trance]}
};

get(13112) ->
	#skl_eff{
		no = 13112,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13106
};

get(13113) ->
	#skl_eff{
		no = 13113,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 800,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13107,13108]
};

get(13114) ->
	#skl_eff{
		no = 13114,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 800,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13108
};

get(13115) ->
	#skl_eff{
		no = 13115,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 5,
		para = 13109
};

get(13116) ->
	#skl_eff{
		no = 13116,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13110
};

get(13117) ->
	#skl_eff{
		no = 13117,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13111
};

get(13118) ->
	#skl_eff{
		no = 13118,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13112,13113]
};

get(13119) ->
	#skl_eff{
		no = 13119,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13114,13115]
};

get(13120) ->
	#skl_eff{
		no = 13120,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13116,13117]
};

get(13121) ->
	#skl_eff{
		no = 13121,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13118,13119]
};

get(13122) ->
	#skl_eff{
		no = 13122,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13120
};

get(13123) ->
	#skl_eff{
		no = 13123,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13121
};

get(13124) ->
	#skl_eff{
		no = 13124,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13122,13123]
};

get(13125) ->
	#skl_eff{
		no = 13125,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13124,13125]
};

get(13126) ->
	#skl_eff{
		no = 13126,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13126,13127]
};

get(13127) ->
	#skl_eff{
		no = 13127,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13128,13129]
};

get(13128) ->
	#skl_eff{
		no = 13128,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 600,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, no_act_bo],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 13130
};

get(13129) ->
	#skl_eff{
		no = 13129,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13131
};

get(13130) ->
	#skl_eff{
		no = 13130,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13132
};

get(13131) ->
	#skl_eff{
		no = 13131,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 5,
		para = 13133
};

get(13132) ->
	#skl_eff{
		no = 13132,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_category,1,99}
};

get(13133) ->
	#skl_eff{
		no = 13133,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {hp_lim, 0.15}
};

get(13134) ->
	#skl_eff{
		no = 13134,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, dead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {hp_lim, 0.01}
};

get(13135) ->
	#skl_eff{
		no = 13135,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {hp_lim, 0.6}
};

get(13201) ->
	#skl_eff{
		no = 13201,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13209
};

get(13202) ->
	#skl_eff{
		no = 13202,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13220
};

get(13203) ->
	#skl_eff{
		no = 13203,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13224
};

get(13204) ->
	#skl_eff{
		no = 13204,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_buff_name, immunity_control,999}
};

get(13205) ->
	#skl_eff{
		no = 13205,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_category, 4,999}
};

get(13206) ->
	#skl_eff{
		no = 13206,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_buff_name, immu_damage,999}
};

get(13207) ->
	#skl_eff{
		no = 13207,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1
};

get(13208) ->
	#skl_eff{
		no = 13208,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13205
};

get(13209) ->
	#skl_eff{
		no = 13209,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13206
};

get(13210) ->
	#skl_eff{
		no = 13210,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13211
};

get(13211) ->
	#skl_eff{
		no = 13211,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13212
};

get(13212) ->
	#skl_eff{
		no = 13212,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 80,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13229
};

get(13301) ->
	#skl_eff{
		no = 13301,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13309
};

get(13302) ->
	#skl_eff{
		no = 13302,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13320
};

get(13303) ->
	#skl_eff{
		no = 13303,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13324
};

get(13304) ->
	#skl_eff{
		no = 13304,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_buff_name, immunity_control,999}
};

get(13305) ->
	#skl_eff{
		no = 13305,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_category, 4,999}
};

get(13306) ->
	#skl_eff{
		no = 13306,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_buff_name, immu_damage,999}
};

get(13307) ->
	#skl_eff{
		no = 13307,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1
};

get(13308) ->
	#skl_eff{
		no = 13308,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13305
};

get(13309) ->
	#skl_eff{
		no = 13309,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13306
};

get(13310) ->
	#skl_eff{
		no = 13310,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13311
};

get(13311) ->
	#skl_eff{
		no = 13311,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13312
};

get(13312) ->
	#skl_eff{
		no = 13312,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 120,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13329
};

get(13401) ->
	#skl_eff{
		no = 13401,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13409
};

get(13402) ->
	#skl_eff{
		no = 13402,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13420
};

get(13403) ->
	#skl_eff{
		no = 13403,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13424
};

get(13404) ->
	#skl_eff{
		no = 13404,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_buff_name, immunity_control,999}
};

get(13405) ->
	#skl_eff{
		no = 13405,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_category, 4,999}
};

get(13406) ->
	#skl_eff{
		no = 13406,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_buff_name, immu_damage,999}
};

get(13407) ->
	#skl_eff{
		no = 13407,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1
};

get(13408) ->
	#skl_eff{
		no = 13408,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13405
};

get(13409) ->
	#skl_eff{
		no = 13409,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13406
};

get(13410) ->
	#skl_eff{
		no = 13410,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13411
};

get(13411) ->
	#skl_eff{
		no = 13411,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13412
};

get(13412) ->
	#skl_eff{
		no = 13412,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 150,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13429
};

get(13501) ->
	#skl_eff{
		no = 13501,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13509
};

get(13502) ->
	#skl_eff{
		no = 13502,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13520
};

get(13503) ->
	#skl_eff{
		no = 13503,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13524
};

get(13504) ->
	#skl_eff{
		no = 13504,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_buff_name, immunity_control,999}
};

get(13505) ->
	#skl_eff{
		no = 13505,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_category, 4,999}
};

get(13506) ->
	#skl_eff{
		no = 13506,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_buff_name, immu_damage,999}
};

get(13507) ->
	#skl_eff{
		no = 13507,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1
};

get(13508) ->
	#skl_eff{
		no = 13508,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13505
};

get(13509) ->
	#skl_eff{
		no = 13509,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13506
};

get(13510) ->
	#skl_eff{
		no = 13510,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13511
};

get(13511) ->
	#skl_eff{
		no = 13511,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13512
};

get(13512) ->
	#skl_eff{
		no = 13512,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 200,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13529
};

get(13601) ->
	#skl_eff{
		no = 13601,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 4,
		para = null
};

get(13602) ->
	#skl_eff{
		no = 13602,
		name = reduce_target_anger_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 4,
		para = -60
};

get(13603) ->
	#skl_eff{
		no = 13603,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 4,
		para = 13601
};

get(13604) ->
	#skl_eff{
		no = 13604,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = null
};

get(13605) ->
	#skl_eff{
		no = 13605,
		name = reduce_target_anger_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 100
};

get(13606) ->
	#skl_eff{
		no = 13606,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 13601
};

get(13607) ->
	#skl_eff{
		no = 13607,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13602
};

get(13608) ->
	#skl_eff{
		no = 13608,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13603
};

get(13609) ->
	#skl_eff{
		no = 13609,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = {by_eff_type,good,99}
};

get(13610) ->
	#skl_eff{
		no = 13610,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13604,13605]
};

get(13611) ->
	#skl_eff{
		no = 13611,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 200,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13607,13608]
};

get(13612) ->
	#skl_eff{
		no = 13612,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 200,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13608
};

get(13613) ->
	#skl_eff{
		no = 13613,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13609
};

get(13614) ->
	#skl_eff{
		no = 13614,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13610
};

get(13615) ->
	#skl_eff{
		no = 13615,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13611
};

get(13616) ->
	#skl_eff{
		no = 13616,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13612,13613]
};

get(13617) ->
	#skl_eff{
		no = 13617,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13614,13615]
};

get(13618) ->
	#skl_eff{
		no = 13618,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13616,13617]
};

get(13619) ->
	#skl_eff{
		no = 13619,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13618,13619]
};

get(13620) ->
	#skl_eff{
		no = 13620,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13620
};

get(13621) ->
	#skl_eff{
		no = 13621,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13622,13623]
};

get(13622) ->
	#skl_eff{
		no = 13622,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13624,13625]
};

get(13623) ->
	#skl_eff{
		no = 13623,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13626,13627]
};

get(13624) ->
	#skl_eff{
		no = 13624,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13628,13629]
};

get(13625) ->
	#skl_eff{
		no = 13625,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 200,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, no_act_bo],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 13630
};

get(13626) ->
	#skl_eff{
		no = 13626,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13631
};

get(13627) ->
	#skl_eff{
		no = 13627,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13632
};

get(13628) ->
	#skl_eff{
		no = 13628,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13633
};

get(13701) ->
	#skl_eff{
		no = 13701,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 4,
		para = null
};

get(13702) ->
	#skl_eff{
		no = 13702,
		name = reduce_target_anger_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 4,
		para = -100
};

get(13703) ->
	#skl_eff{
		no = 13703,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 4,
		para = 13701
};

get(13704) ->
	#skl_eff{
		no = 13704,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = null
};

get(13705) ->
	#skl_eff{
		no = 13705,
		name = reduce_target_anger_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 150
};

get(13706) ->
	#skl_eff{
		no = 13706,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 13701
};

get(13707) ->
	#skl_eff{
		no = 13707,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13702
};

get(13708) ->
	#skl_eff{
		no = 13708,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 13703
};

get(13709) ->
	#skl_eff{
		no = 13709,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 2,
		para = {by_eff_type,good,99}
};

get(13710) ->
	#skl_eff{
		no = 13710,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13704,13705]
};

get(13711) ->
	#skl_eff{
		no = 13711,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 300,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13707,13708]
};

get(13712) ->
	#skl_eff{
		no = 13712,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13708
};

get(13713) ->
	#skl_eff{
		no = 13713,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 2,
		para = 13709
};

get(13714) ->
	#skl_eff{
		no = 13714,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13710
};

get(13715) ->
	#skl_eff{
		no = 13715,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13711
};

get(13716) ->
	#skl_eff{
		no = 13716,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13712,13713]
};

get(13717) ->
	#skl_eff{
		no = 13717,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13714,13715]
};

get(13718) ->
	#skl_eff{
		no = 13718,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13716,13717]
};

get(13719) ->
	#skl_eff{
		no = 13719,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13718,13719]
};

get(13720) ->
	#skl_eff{
		no = 13720,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13720
};

get(13721) ->
	#skl_eff{
		no = 13721,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13721
};

get(13722) ->
	#skl_eff{
		no = 13722,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13722,13723]
};

get(13723) ->
	#skl_eff{
		no = 13723,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13724,13725]
};

get(13724) ->
	#skl_eff{
		no = 13724,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [13726,13727]
};

get(13725) ->
	#skl_eff{
		no = 13725,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [13728,13729]
};

get(13726) ->
	#skl_eff{
		no = 13726,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 300,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, no_act_bo],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 13730
};

get(13727) ->
	#skl_eff{
		no = 13727,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 13731
};

get(13728) ->
	#skl_eff{
		no = 13728,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 13732
};

get(13729) ->
	#skl_eff{
		no = 13729,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 2,
		para = 13733
};

get(14001) ->
	#skl_eff{
		no = 14001,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 66,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14002
};

get(14002) ->
	#skl_eff{
		no = 14002,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14002]}
};

get(14003) ->
	#skl_eff{
		no = 14003,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 66,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14004
};

get(14004) ->
	#skl_eff{
		no = 14004,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14004]}
};

get(14005) ->
	#skl_eff{
		no = 14005,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 66,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14006
};

get(14006) ->
	#skl_eff{
		no = 14006,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14006]}
};

get(14101) ->
	#skl_eff{
		no = 14101,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 90,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14102
};

get(14102) ->
	#skl_eff{
		no = 14102,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14102]}
};

get(14103) ->
	#skl_eff{
		no = 14103,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 90,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14104
};

get(14104) ->
	#skl_eff{
		no = 14104,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14104]}
};

get(14105) ->
	#skl_eff{
		no = 14105,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 90,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14106
};

get(14106) ->
	#skl_eff{
		no = 14106,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14106]}
};

get(14201) ->
	#skl_eff{
		no = 14201,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 122,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14202
};

get(14202) ->
	#skl_eff{
		no = 14202,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14202]}
};

get(14203) ->
	#skl_eff{
		no = 14203,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 122,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14204
};

get(14204) ->
	#skl_eff{
		no = 14204,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14204]}
};

get(14205) ->
	#skl_eff{
		no = 14205,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 122,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14206
};

get(14206) ->
	#skl_eff{
		no = 14206,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14206]}
};

get(14301) ->
	#skl_eff{
		no = 14301,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 164,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14302
};

get(14302) ->
	#skl_eff{
		no = 14302,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14302]}
};

get(14303) ->
	#skl_eff{
		no = 14303,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 164,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14304
};

get(14304) ->
	#skl_eff{
		no = 14304,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14304]}
};

get(14305) ->
	#skl_eff{
		no = 14305,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 164,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14306
};

get(14306) ->
	#skl_eff{
		no = 14306,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14306]}
};

get(14401) ->
	#skl_eff{
		no = 14401,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 222,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14402
};

get(14402) ->
	#skl_eff{
		no = 14402,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14402]}
};

get(14403) ->
	#skl_eff{
		no = 14403,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 222,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14404
};

get(14404) ->
	#skl_eff{
		no = 14404,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14404]}
};

get(14405) ->
	#skl_eff{
		no = 14405,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 222,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14406
};

get(14406) ->
	#skl_eff{
		no = 14406,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14406]}
};

get(14501) ->
	#skl_eff{
		no = 14501,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14502
};

get(14502) ->
	#skl_eff{
		no = 14502,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14502]}
};

get(14503) ->
	#skl_eff{
		no = 14503,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14504
};

get(14504) ->
	#skl_eff{
		no = 14504,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14504]}
};

get(14505) ->
	#skl_eff{
		no = 14505,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 14506
};

get(14506) ->
	#skl_eff{
		no = 14506,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [14506]}
};

get(50001) ->
	#skl_eff{
		no = 50001,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 4,
		para = null
};

get(50002) ->
	#skl_eff{
		no = 50002,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 150,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, {has_not_spec_category_buff_first, 2}],
		target_count = 10,
		para = 50001
};

get(50003) ->
	#skl_eff{
		no = 50003,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50004) ->
	#skl_eff{
		no = 50004,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50002
};

get(50005) ->
	#skl_eff{
		no = 50005,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,hp_lim,117,0.5}
};

get(50006) ->
	#skl_eff{
		no = 50006,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50007) ->
	#skl_eff{
		no = 50007,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50008) ->
	#skl_eff{
		no = 50008,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50009) ->
	#skl_eff{
		no = 50009,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 200,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 5,
		para = 50003
};

get(50010) ->
	#skl_eff{
		no = 50010,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50011) ->
	#skl_eff{
		no = 50011,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 800,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, {has_not_spec_category_buff_first, 2}],
		target_count = 1,
		para = 50004
};

get(50012) ->
	#skl_eff{
		no = 50012,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = {by_eff_type,good,99}
};

get(50013) ->
	#skl_eff{
		no = 50013,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50014) ->
	#skl_eff{
		no = 50014,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50005
};

get(50015) ->
	#skl_eff{
		no = 50015,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50016) ->
	#skl_eff{
		no = 50016,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 800,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, {has_not_spec_category_buff_first, 2}],
		target_count = 1,
		para = 50006
};

get(50017) ->
	#skl_eff{
		no = 50017,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50018) ->
	#skl_eff{
		no = 50018,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50019) ->
	#skl_eff{
		no = 50019,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 5,
		para = 50007
};

get(50020) ->
	#skl_eff{
		no = 50020,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,hp_lim,117,0.5}
};

get(50021) ->
	#skl_eff{
		no = 50021,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 50008
};

get(50022) ->
	#skl_eff{
		no = 50022,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50023) ->
	#skl_eff{
		no = 50023,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50009
};

get(50024) ->
	#skl_eff{
		no = 50024,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, {has_not_spec_category_buff_first, 2}],
		target_count = 1,
		para = 50010
};

get(50025) ->
	#skl_eff{
		no = 50025,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50026) ->
	#skl_eff{
		no = 50026,
		name = tmp_force_set_pursue_att_proba,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(50027) ->
	#skl_eff{
		no = 50027,
		name = tmp_force_set_max_pursue_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 3
};

get(50028) ->
	#skl_eff{
		no = 50028,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = [50011,50012]
};

get(50029) ->
	#skl_eff{
		no = 50029,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50030) ->
	#skl_eff{
		no = 50030,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 150,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 10,
		para = 50013
};

get(50031) ->
	#skl_eff{
		no = 50031,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50032) ->
	#skl_eff{
		no = 50032,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 50014
};

get(50033) ->
	#skl_eff{
		no = 50033,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50034) ->
	#skl_eff{
		no = 50034,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50015
};

get(50035) ->
	#skl_eff{
		no = 50035,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50036) ->
	#skl_eff{
		no = 50036,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50016
};

get(50037) ->
	#skl_eff{
		no = 50037,
		name = tmp_force_set_pursue_att_proba,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(50038) ->
	#skl_eff{
		no = 50038,
		name = tmp_force_set_max_pursue_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 2
};

get(50039) ->
	#skl_eff{
		no = 50039,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50040) ->
	#skl_eff{
		no = 50040,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {hp_lim, 0.2}
};

get(50041) ->
	#skl_eff{
		no = 50041,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = [50017,50018]
};

get(50042) ->
	#skl_eff{
		no = 50042,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50043) ->
	#skl_eff{
		no = 50043,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 5,
		para = 50019
};

get(50044) ->
	#skl_eff{
		no = 50044,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, {has_not_spec_category_buff_first, 2}],
		target_count = 10,
		para = 50020
};

get(50045) ->
	#skl_eff{
		no = 50045,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50046) ->
	#skl_eff{
		no = 50046,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 50021
};

get(50047) ->
	#skl_eff{
		no = 50047,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [],
		target_count = 5,
		para = 50022
};

get(50048) ->
	#skl_eff{
		no = 50048,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, {has_not_spec_category_buff_first, 2}],
		target_count = 3,
		para = 50023
};

get(50049) ->
	#skl_eff{
		no = 50049,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, {has_not_spec_category_buff_first, 2}],
		target_count = 3,
		para = 50024
};

get(50050) ->
	#skl_eff{
		no = 50050,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50051) ->
	#skl_eff{
		no = 50051,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,hp_lim,117,999}
};

get(50052) ->
	#skl_eff{
		no = 50052,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50053) ->
	#skl_eff{
		no = 50053,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50054) ->
	#skl_eff{
		no = 50054,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, {has_not_spec_category_buff_first, 2}],
		target_count = 10,
		para = 50025
};

get(50055) ->
	#skl_eff{
		no = 50055,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, {has_not_spec_category_buff_first, 2}],
		target_count = 5,
		para = 50026
};

get(50056) ->
	#skl_eff{
		no = 50056,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = [50027,50028]
};

get(50057) ->
	#skl_eff{
		no = 50057,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = 10,
		para = {hp_lim, 1}
};

get(50058) ->
	#skl_eff{
		no = 50058,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50059) ->
	#skl_eff{
		no = 50059,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50029
};

get(50060) ->
	#skl_eff{
		no = 50060,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50061) ->
	#skl_eff{
		no = 50061,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50030
};

get(50062) ->
	#skl_eff{
		no = 50062,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50063) ->
	#skl_eff{
		no = 50063,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50031
};

get(50064) ->
	#skl_eff{
		no = 50064,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50032
};

get(50065) ->
	#skl_eff{
		no = 50065,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [],
		target_count = 10,
		para = {by_buff_name, immu_damage, 999}
};

get(50066) ->
	#skl_eff{
		no = 50066,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [],
		target_count = 10,
		para = {by_category, 4,999}
};

get(50067) ->
	#skl_eff{
		no = 50067,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50068) ->
	#skl_eff{
		no = 50068,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50033
};

get(50069) ->
	#skl_eff{
		no = 50069,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50034
};

get(50070) ->
	#skl_eff{
		no = 50070,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [],
		target_count = 10,
		para = {by_buff_name, immu_damage, 999}
};

get(50071) ->
	#skl_eff{
		no = 50071,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [],
		target_count = 10,
		para = {by_category, 4,999}
};

get(50072) ->
	#skl_eff{
		no = 50072,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50073) ->
	#skl_eff{
		no = 50073,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50035
};

get(50098) ->
	#skl_eff{
		no = 50098,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50099) ->
	#skl_eff{
		no = 50099,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50100) ->
	#skl_eff{
		no = 50100,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50101) ->
	#skl_eff{
		no = 50101,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_no_list, [50109]}
};

get(50201) ->
	#skl_eff{
		no = 50201,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50202) ->
	#skl_eff{
		no = 50202,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50203) ->
	#skl_eff{
		no = 50203,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50211) ->
	#skl_eff{
		no = 50211,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50212) ->
	#skl_eff{
		no = 50212,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50213) ->
	#skl_eff{
		no = 50213,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50221) ->
	#skl_eff{
		no = 50221,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50222) ->
	#skl_eff{
		no = 50222,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50002
};

get(50223) ->
	#skl_eff{
		no = 50223,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,hp_lim,117,0.5}
};

get(50224) ->
	#skl_eff{
		no = 50224,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50225) ->
	#skl_eff{
		no = 50225,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50226) ->
	#skl_eff{
		no = 50226,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50005
};

get(50227) ->
	#skl_eff{
		no = 50227,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = [50011,50012]
};

get(50228) ->
	#skl_eff{
		no = 50228,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50229) ->
	#skl_eff{
		no = 50229,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50231) ->
	#skl_eff{
		no = 50231,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50232) ->
	#skl_eff{
		no = 50232,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50233) ->
	#skl_eff{
		no = 50233,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50234) ->
	#skl_eff{
		no = 50234,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50241) ->
	#skl_eff{
		no = 50241,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50242) ->
	#skl_eff{
		no = 50242,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = [50241, 50242]
};

get(50243) ->
	#skl_eff{
		no = 50243,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50244) ->
	#skl_eff{
		no = 50244,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50243
};

get(50245) ->
	#skl_eff{
		no = 50245,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50246) ->
	#skl_eff{
		no = 50246,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 5,
		para = 50244
};

get(50251) ->
	#skl_eff{
		no = 50251,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50252) ->
	#skl_eff{
		no = 50252,
		name = tmp_force_set_pursue_att_proba,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(50253) ->
	#skl_eff{
		no = 50253,
		name = tmp_force_set_max_pursue_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 3
};

get(50254) ->
	#skl_eff{
		no = 50254,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 4,
		para = null
};

get(50255) ->
	#skl_eff{
		no = 50255,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50256) ->
	#skl_eff{
		no = 50256,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50016
};

get(50257) ->
	#skl_eff{
		no = 50257,
		name = tmp_force_set_pursue_att_proba,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(50258) ->
	#skl_eff{
		no = 50258,
		name = tmp_force_set_max_pursue_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 2
};

get(50259) ->
	#skl_eff{
		no = 50259,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = [50017,50018]
};

get(50261) ->
	#skl_eff{
		no = 50261,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50262) ->
	#skl_eff{
		no = 50262,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50261
};

get(50263) ->
	#skl_eff{
		no = 50263,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50264) ->
	#skl_eff{
		no = 50264,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50265) ->
	#skl_eff{
		no = 50265,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [50262,50263]
};

get(50266) ->
	#skl_eff{
		no = 50266,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50267) ->
	#skl_eff{
		no = 50267,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50268) ->
	#skl_eff{
		no = 50268,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50264
};

get(50269) ->
	#skl_eff{
		no = 50269,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50270) ->
	#skl_eff{
		no = 50270,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 10,
		para = 50265
};

get(50271) ->
	#skl_eff{
		no = 50271,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [],
		target_count = 5,
		para = 50266
};

get(50281) ->
	#skl_eff{
		no = 50281,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50282) ->
	#skl_eff{
		no = 50282,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 50281
};

get(50283) ->
	#skl_eff{
		no = 50283,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {hp_lim, 0.05}
};

get(50284) ->
	#skl_eff{
		no = 50284,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50285) ->
	#skl_eff{
		no = 50285,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50282
};

get(50286) ->
	#skl_eff{
		no = 50286,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, {has_not_spec_category_buff_first, 2}],
		target_count = 1,
		para = 50283
};

get(50287) ->
	#skl_eff{
		no = 50287,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50288) ->
	#skl_eff{
		no = 50288,
		name = tmp_force_set_pursue_att_proba,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(50289) ->
	#skl_eff{
		no = 50289,
		name = tmp_force_set_max_pursue_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 3
};

get(50290) ->
	#skl_eff{
		no = 50290,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50291) ->
	#skl_eff{
		no = 50291,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 8,
		para = null
};

get(50292) ->
	#skl_eff{
		no = 50292,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, {has_not_spec_category_buff_first, 2}],
		target_count = 3,
		para = 50284
};

get(50300) ->
	#skl_eff{
		no = 50300,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side],
		rules_sort_target = [],
		target_count = 10,
		para = {by_no_list, [50313]}
};

get(50301) ->
	#skl_eff{
		no = 50301,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle],
		target_count = 3,
		para = null
};

get(50302) ->
	#skl_eff{
		no = 50302,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first, 50301}],
		target_count = 10,
		para = [50301,50302]
};

get(50303) ->
	#skl_eff{
		no = 50303,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_desc, {has_not_spec_buff_first, 50303}],
		target_count = 3,
		para = null
};

get(50304) ->
	#skl_eff{
		no = 50304,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50303
};

get(50305) ->
	#skl_eff{
		no = 50305,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,hp_lim,117,0.5}
};

get(50306) ->
	#skl_eff{
		no = 50306,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, cur_hp_lowest],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50307) ->
	#skl_eff{
		no = 50307,
		name = tmp_force_set_pursue_att_proba,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(50308) ->
	#skl_eff{
		no = 50308,
		name = tmp_force_set_max_pursue_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 3
};

get(50309) ->
	#skl_eff{
		no = 50309,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50310) ->
	#skl_eff{
		no = 50310,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_category_buff_first, 2}],
		target_count = 3,
		para = 50305
};

get(50311) ->
	#skl_eff{
		no = 50311,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50312) ->
	#skl_eff{
		no = 50312,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50306
};

get(50313) ->
	#skl_eff{
		no = 50313,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = [50307,50308]
};

get(50314) ->
	#skl_eff{
		no = 50314,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce, sort_by_act_speed_asce],
		target_count = 1,
		para = null
};

get(50315) ->
	#skl_eff{
		no = 50315,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_asce],
		target_count = 3,
		para = null
};

get(50316) ->
	#skl_eff{
		no = 50316,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50312
};

get(50317) ->
	#skl_eff{
		no = 50317,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, {act_speed_lower_than, 10000}],
		rules_sort_target = [],
		target_count = 10,
		para = 50313
};

get(50318) ->
	#skl_eff{
		no = 50318,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, {act_speed_lower_than, 20000}],
		rules_sort_target = [],
		target_count = 10,
		para = 50313
};

get(50319) ->
	#skl_eff{
		no = 50319,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, {act_speed_lower_than, 30000}],
		rules_sort_target = [],
		target_count = 10,
		para = 50313
};

get(50320) ->
	#skl_eff{
		no = 50320,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, {act_speed_lower_than, 40000}],
		rules_sort_target = [],
		target_count = 10,
		para = 50313
};

get(50321) ->
	#skl_eff{
		no = 50321,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, {act_speed_lower_than, 50000}],
		rules_sort_target = [],
		target_count = 10,
		para = 50313
};

get(50321) ->
	#skl_eff{
		no = 50321,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50322) ->
	#skl_eff{
		no = 50322,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50321
};

get(50323) ->
	#skl_eff{
		no = 50323,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {hp_lim, 0.15}
};

get(50324) ->
	#skl_eff{
		no = 50324,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50325) ->
	#skl_eff{
		no = 50325,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50326) ->
	#skl_eff{
		no = 50326,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50322
};

get(50327) ->
	#skl_eff{
		no = 50327,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50328) ->
	#skl_eff{
		no = 50328,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, cur_hp_lowest],
		rules_sort_target = [],
		target_count = 5,
		para = 50323
};

get(50329) ->
	#skl_eff{
		no = 50329,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50330) ->
	#skl_eff{
		no = 50330,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, cur_hp_lowest],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50331) ->
	#skl_eff{
		no = 50331,
		name = tmp_force_set_pursue_att_proba,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(50332) ->
	#skl_eff{
		no = 50332,
		name = tmp_force_set_max_pursue_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 3
};

get(50333) ->
	#skl_eff{
		no = 50333,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = 1,
		para = {hp_lim, 0.1}
};

get(50334) ->
	#skl_eff{
		no = 50334,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_category_buff_first, 2}],
		target_count = 1,
		para = 50333
};

get(50335) ->
	#skl_eff{
		no = 50335,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50336) ->
	#skl_eff{
		no = 50336,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 50334
};

get(50337) ->
	#skl_eff{
		no = 50337,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, cur_hp_lowest],
		rules_sort_target = [sort_by_hp_asce],
		target_count = 1,
		para = 50335
};

get(50341) ->
	#skl_eff{
		no = 50341,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50342) ->
	#skl_eff{
		no = 50342,
		name = tmp_force_set_pursue_att_proba,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(50343) ->
	#skl_eff{
		no = 50343,
		name = tmp_force_set_max_pursue_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 3
};

get(50344) ->
	#skl_eff{
		no = 50344,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, {cur_hp_percentage_lower_than, 50}],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 50341
};

get(50345) ->
	#skl_eff{
		no = 50345,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side],
		rules_sort_target = [],
		target_count = 10,
		para = {by_no_list, [50341]}
};

get(50346) ->
	#skl_eff{
		no = 50346,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50347) ->
	#skl_eff{
		no = 50347,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 10,
		para = 50342
};

get(50348) ->
	#skl_eff{
		no = 50348,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50349) ->
	#skl_eff{
		no = 50349,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50343
};

get(50350) ->
	#skl_eff{
		no = 50350,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50351) ->
	#skl_eff{
		no = 50351,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50352) ->
	#skl_eff{
		no = 50352,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50353) ->
	#skl_eff{
		no = 50353,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 250,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 5,
		para = 50344
};

get(50354) ->
	#skl_eff{
		no = 50354,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50355) ->
	#skl_eff{
		no = 50355,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 50345
};

get(50356) ->
	#skl_eff{
		no = 50356,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50357) ->
	#skl_eff{
		no = 50357,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 10,
		para = 50345
};

get(50358) ->
	#skl_eff{
		no = 50358,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50359) ->
	#skl_eff{
		no = 50359,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target, {has_spec_no_buff, 50347}],
		rules_sort_target = [],
		target_count = 1,
		para = 50348
};

get(50360) ->
	#skl_eff{
		no = 50360,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 50347
};

get(50361) ->
	#skl_eff{
		no = 50361,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50362) ->
	#skl_eff{
		no = 50362,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50363) ->
	#skl_eff{
		no = 50363,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50364) ->
	#skl_eff{
		no = 50364,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp,hp,116,0.2}
};

get(50365) ->
	#skl_eff{
		no = 50365,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50366) ->
	#skl_eff{
		no = 50366,
		name = tmp_force_set_pursue_att_proba,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(50367) ->
	#skl_eff{
		no = 50367,
		name = tmp_force_set_max_pursue_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 3
};

get(50368) ->
	#skl_eff{
		no = 50368,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50350
};

get(50369) ->
	#skl_eff{
		no = 50369,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50381) ->
	#skl_eff{
		no = 50381,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50382) ->
	#skl_eff{
		no = 50382,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50383) ->
	#skl_eff{
		no = 50383,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50381
};

get(50384) ->
	#skl_eff{
		no = 50384,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,hp_lim,117,0.5}
};

get(50385) ->
	#skl_eff{
		no = 50385,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 1,
		para = null
};

get(50386) ->
	#skl_eff{
		no = 50386,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50387) ->
	#skl_eff{
		no = 50387,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 2,
		para = {hp_lim, 0.2}
};

get(50388) ->
	#skl_eff{
		no = 50388,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50401) ->
	#skl_eff{
		no = 50401,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50402) ->
	#skl_eff{
		no = 50402,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 500,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, {has_not_spec_category_buff_first, 2}],
		target_count = 3,
		para = 50401
};

get(50403) ->
	#skl_eff{
		no = 50403,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50404) ->
	#skl_eff{
		no = 50404,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50405) ->
	#skl_eff{
		no = 50405,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 150,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 10,
		para = 50402
};

get(50406) ->
	#skl_eff{
		no = 50406,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50407) ->
	#skl_eff{
		no = 50407,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = [50403,50404]
};

get(50421) ->
	#skl_eff{
		no = 50421,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50422) ->
	#skl_eff{
		no = 50422,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50421
};

get(50423) ->
	#skl_eff{
		no = 50423,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50424) ->
	#skl_eff{
		no = 50424,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50422
};

get(50425) ->
	#skl_eff{
		no = 50425,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50426) ->
	#skl_eff{
		no = 50426,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 500,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50423
};

get(50427) ->
	#skl_eff{
		no = 50427,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = [50424,50425]
};

get(50428) ->
	#skl_eff{
		no = 50428,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50429) ->
	#skl_eff{
		no = 50429,
		name = tmp_force_set_pursue_att_proba,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(50430) ->
	#skl_eff{
		no = 50430,
		name = tmp_force_set_max_pursue_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 3
};

get(50431) ->
	#skl_eff{
		no = 50431,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 5,
		para = null
};

get(50501) ->
	#skl_eff{
		no = 50501,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, {has_spec_buff_first, 50503}],
		target_count = 3,
		para = null
};

get(50502) ->
	#skl_eff{
		no = 50502,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, {has_spec_no_buff, 50503}],
		rules_sort_target = [],
		target_count = 10,
		para = 50504
};

get(50503) ->
	#skl_eff{
		no = 50503,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [],
		target_count = 10,
		para = {by_no_list, [50504]}
};

get(50504) ->
	#skl_eff{
		no = 50504,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50505) ->
	#skl_eff{
		no = 50505,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50501
};

get(50506) ->
	#skl_eff{
		no = 50506,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 2,
		para = 50503
};

get(50507) ->
	#skl_eff{
		no = 50507,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50505
};

get(50511) ->
	#skl_eff{
		no = 50511,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 10,
		para = null
};

get(50512) ->
	#skl_eff{
		no = 50512,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 2,
		para = null
};

get(50513) ->
	#skl_eff{
		no = 50513,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 3,
		para = null
};

get(50514) ->
	#skl_eff{
		no = 50514,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50511
};

get(50521) ->
	#skl_eff{
		no = 50521,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = [50521,50522]
};

get(50522) ->
	#skl_eff{
		no = 50522,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50523) ->
	#skl_eff{
		no = 50523,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_category_buff_first, 2}],
		target_count = 1,
		para = null
};

get(50524) ->
	#skl_eff{
		no = 50524,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 50523
};

get(50531) ->
	#skl_eff{
		no = 50531,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle],
		target_count = 3,
		para = null
};

get(50532) ->
	#skl_eff{
		no = 50532,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 3,
		para = 50531
};

get(50533) ->
	#skl_eff{
		no = 50533,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(50534) ->
	#skl_eff{
		no = 50534,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 50532
};

get(50535) ->
	#skl_eff{
		no = 50535,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 50531
};

get(50536) ->
	#skl_eff{
		no = 50536,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = 1,
		para = null
};

get(50537) ->
	#skl_eff{
		no = 50537,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 50533
};

get(100010) ->
	#skl_eff{
		no = 100010,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100011) ->
	#skl_eff{
		no = 100011,
		name = reduce_target_mp_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100012) ->
	#skl_eff{
		no = 100012,
		name = tmp_mark_do_fix_mp_dam_by_xinfa_lv,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100020) ->
	#skl_eff{
		no = 100020,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100021) ->
	#skl_eff{
		no = 100021,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(100030) ->
	#skl_eff{
		no = 100030,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100040) ->
	#skl_eff{
		no = 100040,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100041) ->
	#skl_eff{
		no = 100041,
		name = tmp_mark_do_twice_phy_att_but_reduce_phy_att_by_rate,
		need_perf_casting = 0,
		trigger_proba = 450,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 0.100000
};

get(100050) ->
	#skl_eff{
		no = 100050,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, not_invisible_to_me, is_not_frozen, undead],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100060) ->
	#skl_eff{
		no = 100060,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, is_not_fallen, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100070) ->
	#skl_eff{
		no = 100070,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100080) ->
	#skl_eff{
		no = 100080,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100081) ->
	#skl_eff{
		no = 100081,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {0.08,0.16}
};

get(100090) ->
	#skl_eff{
		no = 100090,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100091) ->
	#skl_eff{
		no = 100091,
		name = reduce_target_mp_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100092) ->
	#skl_eff{
		no = 100092,
		name = tmp_mark_do_fix_mp_dam_by_xinfa_lv,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100100) ->
	#skl_eff{
		no = 100100,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100101) ->
	#skl_eff{
		no = 100101,
		name = reduce_target_mp_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100110) ->
	#skl_eff{
		no = 100110,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100111) ->
	#skl_eff{
		no = 100111,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 1001
};

get(100120) ->
	#skl_eff{
		no = 100120,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,1003}, {has_not_spec_buff_first,1004}],
		target_count = 1,
		para = [1003,1004]
};

get(100130) ->
	#skl_eff{
		no = 100130,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,1005}, {has_not_spec_buff_first,1006}],
		target_count = 1,
		para = [1005,1006]
};

get(100190) ->
	#skl_eff{
		no = 100190,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [my_owner],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100191) ->
	#skl_eff{
		no = 100191,
		name = force_die_and_leave_battle,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100200) ->
	#skl_eff{
		no = 100200,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100210) ->
	#skl_eff{
		no = 100210,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100211) ->
	#skl_eff{
		no = 100211,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(100220) ->
	#skl_eff{
		no = 100220,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100230) ->
	#skl_eff{
		no = 100230,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,1021}],
		target_count = 1,
		para = 1021
};

get(100240) ->
	#skl_eff{
		no = 100240,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100250) ->
	#skl_eff{
		no = 100250,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, is_not_fallen, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100260) ->
	#skl_eff{
		no = 100260,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,1022}],
		target_count = 3,
		para = 1022
};

get(100270) ->
	#skl_eff{
		no = 100270,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [my_owner],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100271) ->
	#skl_eff{
		no = 100271,
		name = force_die_and_leave_battle,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100280) ->
	#skl_eff{
		no = 100280,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100281) ->
	#skl_eff{
		no = 100281,
		name = reduce_target_mp_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100282) ->
	#skl_eff{
		no = 100282,
		name = tmp_mark_do_fix_mp_dam_by_xinfa_lv,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100290) ->
	#skl_eff{
		no = 100290,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,1005}, {has_not_spec_buff_first,1006}],
		target_count = 1,
		para = [1005,1006]
};

get(100300) ->
	#skl_eff{
		no = 100300,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100310) ->
	#skl_eff{
		no = 100310,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,1003}, {has_not_spec_buff_first,1004}],
		target_count = 1,
		para = [1003,1004]
};

get(100320) ->
	#skl_eff{
		no = 100320,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100330) ->
	#skl_eff{
		no = 100330,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100331) ->
	#skl_eff{
		no = 100331,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [undead, cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 1023
};

get(100340) ->
	#skl_eff{
		no = 100340,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100341) ->
	#skl_eff{
		no = 100341,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [undead, cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 1024
};

get(100342) ->
	#skl_eff{
		no = 100342,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100343) ->
	#skl_eff{
		no = 100343,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100344) ->
	#skl_eff{
		no = 100344,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100345) ->
	#skl_eff{
		no = 100345,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100346) ->
	#skl_eff{
		no = 100346,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100350) ->
	#skl_eff{
		no = 100350,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100351) ->
	#skl_eff{
		no = 100351,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(100352) ->
	#skl_eff{
		no = 100352,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = 1,
		para = {by_eff_type,good,1}
};

get(100353) ->
	#skl_eff{
		no = 100353,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 4041
};

get(100354) ->
	#skl_eff{
		no = 100354,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 4042
};

get(100355) ->
	#skl_eff{
		no = 100355,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 4039
};

get(100356) ->
	#skl_eff{
		no = 100356,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 4040
};

get(100360) ->
	#skl_eff{
		no = 100360,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100361) ->
	#skl_eff{
		no = 100361,
		name = reduce_target_mp_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100362) ->
	#skl_eff{
		no = 100362,
		name = tmp_mark_do_fix_mp_dam_by_xinfa_lv,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(100370) ->
	#skl_eff{
		no = 100370,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100380) ->
	#skl_eff{
		no = 100380,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100381) ->
	#skl_eff{
		no = 100381,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 1026
};

get(100382) ->
	#skl_eff{
		no = 100382,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100383) ->
	#skl_eff{
		no = 100383,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100384) ->
	#skl_eff{
		no = 100384,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100385) ->
	#skl_eff{
		no = 100385,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100386) ->
	#skl_eff{
		no = 100386,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100390) ->
	#skl_eff{
		no = 100390,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100392) ->
	#skl_eff{
		no = 100392,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 250,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4032
};

get(100393) ->
	#skl_eff{
		no = 100393,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 250,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4033
};

get(100394) ->
	#skl_eff{
		no = 100394,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 250,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4034
};

get(100395) ->
	#skl_eff{
		no = 100395,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 250,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = {by_eff_type,good,1}
};

get(100396) ->
	#skl_eff{
		no = 100396,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 250,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4035
};

get(100400) ->
	#skl_eff{
		no = 100400,
		name = heal_hp_and_add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 1027
};

get(100410) ->
	#skl_eff{
		no = 100410,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = {by_no_list, [1,2,3,4,5,6,4031,4000]}
};

get(100420) ->
	#skl_eff{
		no = 100420,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = {by_eff_type,bad,99}
};

get(100430) ->
	#skl_eff{
		no = 100430,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = {by_eff_type,bad,1}
};

get(100440) ->
	#skl_eff{
		no = 100440,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_frozen_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100450) ->
	#skl_eff{
		no = 100450,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_frozen_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100451) ->
	#skl_eff{
		no = 100451,
		name = splash,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = {1, 0.8}
};

get(100460) ->
	#skl_eff{
		no = 100460,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100461) ->
	#skl_eff{
		no = 100461,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(100470) ->
	#skl_eff{
		no = 100470,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100480) ->
	#skl_eff{
		no = 100480,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100481) ->
	#skl_eff{
		no = 100481,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {0.1,0.2}
};

get(100490) ->
	#skl_eff{
		no = 100490,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100491) ->
	#skl_eff{
		no = 100491,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {0.1,0.2}
};

get(100492) ->
	#skl_eff{
		no = 100492,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 47
};

get(100500) ->
	#skl_eff{
		no = 100500,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, not_invisible_to_me, is_not_frozen, undead],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(100510) ->
	#skl_eff{
		no = 100510,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead,is_under_control],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = {by_no_list, [1, 2, 3,4, 5, 6, 49, 54, 55, 56, 60,4000,4001,4014]}
};

get(100601) ->
	#skl_eff{
		no = 100601,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100602) ->
	#skl_eff{
		no = 100602,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100603) ->
	#skl_eff{
		no = 100603,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100604) ->
	#skl_eff{
		no = 100604,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100605) ->
	#skl_eff{
		no = 100605,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100606) ->
	#skl_eff{
		no = 100606,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4043
};

get(100607) ->
	#skl_eff{
		no = 100607,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = infinite,
		para = 4044
};

get(100608) ->
	#skl_eff{
		no = 100608,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100609) ->
	#skl_eff{
		no = 100609,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4046
};

get(100610) ->
	#skl_eff{
		no = 100610,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4047
};

get(100611) ->
	#skl_eff{
		no = 100611,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4052
};

get(100612) ->
	#skl_eff{
		no = 100612,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,loss_hp,117,0.7}
};

get(100613) ->
	#skl_eff{
		no = 100613,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100614) ->
	#skl_eff{
		no = 100614,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100615) ->
	#skl_eff{
		no = 100615,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(100616) ->
	#skl_eff{
		no = 100616,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = [4076, 4054]
};

get(100617) ->
	#skl_eff{
		no = 100617,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(100618) ->
	#skl_eff{
		no = 100618,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = [4056,4055]
};

get(102619) ->
	#skl_eff{
		no = 102619,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(102620) ->
	#skl_eff{
		no = 102620,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp,null,116,0.7}
};

get(102621) ->
	#skl_eff{
		no = 102621,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = null
};

get(102622) ->
	#skl_eff{
		no = 102622,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4078
};

get(102623) ->
	#skl_eff{
		no = 102623,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(102624) ->
	#skl_eff{
		no = 102624,
		name = splash,
		need_perf_casting = 1,
		trigger_proba = 750,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = {2,2}
};

get(102625) ->
	#skl_eff{
		no = 102625,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = 4099
};

get(102626) ->
	#skl_eff{
		no = 102626,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = {by_eff_type,bad,2}
};

get(400010) ->
	#skl_eff{
		no = 400010,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, spouse],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(400020) ->
	#skl_eff{
		no = 400020,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, spouse],
		rules_sort_target = [],
		target_count = 1,
		para = 3600
};

get(400030) ->
	#skl_eff{
		no = 400030,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, dead, spouse],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(620010) ->
	#skl_eff{
		no = 620010,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first, not_frozen_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(620110) ->
	#skl_eff{
		no = 620110,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first, not_frozen_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(620210) ->
	#skl_eff{
		no = 620210,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_monster],
		rules_sort_target = [cur_pick_target_first, not_frozen_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = 48
};

get(620310) ->
	#skl_eff{
		no = 620310,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = {hp_lim, 0.25}
};

get(620320) ->
	#skl_eff{
		no = 620320,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = {hp_lim, 0.35}
};

get(620330) ->
	#skl_eff{
		no = 620330,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = {hp_lim, 0.45}
};

get(620410) ->
	#skl_eff{
		no = 620410,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = {hp_lim, 0.1}
};

get(620420) ->
	#skl_eff{
		no = 620420,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = {hp_lim, 0.1}
};

get(620430) ->
	#skl_eff{
		no = 620430,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = {hp_lim, 0.1}
};

get(620510) ->
	#skl_eff{
		no = 620510,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = {hp_lim, 0.25}
};

get(620520) ->
	#skl_eff{
		no = 620520,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = {hp_lim, 0.35}
};

get(620530) ->
	#skl_eff{
		no = 620530,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = {hp_lim, 0.45}
};

get(620610) ->
	#skl_eff{
		no = 620610,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = {by_eff_type,bad,99}
};

get(620620) ->
	#skl_eff{
		no = 620620,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = {by_no_list, [1, 2, 3,4, 5, 6, 49, 54, 55, 56, 60,4000,4001,4014]}
};

get(620630) ->
	#skl_eff{
		no = 620630,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = 50
};

get(620710) ->
	#skl_eff{
		no = 620710,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = {hp_lim, 0.2}
};

get(620720) ->
	#skl_eff{
		no = 620720,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = {hp_lim, 0.27}
};

get(620730) ->
	#skl_eff{
		no = 620730,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = {hp_lim, 0.35}
};

get(620810) ->
	#skl_eff{
		no = 620810,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {0.25,9999}
};

get(620811) ->
	#skl_eff{
		no = 620811,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, not_invisible_to_me, is_not_frozen, undead, is_not_monster],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(620820) ->
	#skl_eff{
		no = 620820,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {0.35,9999}
};

get(620830) ->
	#skl_eff{
		no = 620830,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {0.45,9999}
};

get(620910) ->
	#skl_eff{
		no = 620910,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {by_eff_type,bad,99}
};

get(620920) ->
	#skl_eff{
		no = 620920,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {by_no_list, [1, 2, 3, 4, 5, 6, 49, 54, 55, 56, 60]}
};

get(621010) ->
	#skl_eff{
		no = 621010,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 750,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_partner],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 60
};

get(621020) ->
	#skl_eff{
		no = 621020,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_partner],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 60
};

get(621110) ->
	#skl_eff{
		no = 621110,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 51
};

get(621120) ->
	#skl_eff{
		no = 621120,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 52
};

get(621130) ->
	#skl_eff{
		no = 621130,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 53
};

get(621210) ->
	#skl_eff{
		no = 621210,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 54
};

get(621220) ->
	#skl_eff{
		no = 621220,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 55
};

get(621230) ->
	#skl_eff{
		no = 621230,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 56
};

get(621310) ->
	#skl_eff{
		no = 621310,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 57
};

get(621320) ->
	#skl_eff{
		no = 621320,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 58
};

get(621330) ->
	#skl_eff{
		no = 621330,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 59
};

get(621410) ->
	#skl_eff{
		no = 621410,
		name = reduce_target_anger_by_do_skill_att,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_invisible_to_me, is_not_frozen, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = -50
};

get(621420) ->
	#skl_eff{
		no = 621420,
		name = reduce_target_anger_by_do_skill_att,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_invisible_to_me, is_not_frozen, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = -55
};

get(621430) ->
	#skl_eff{
		no = 621430,
		name = reduce_target_anger_by_do_skill_att,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_invisible_to_me, is_not_frozen, not_myself],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = -60
};

get(1002000) ->
	#skl_eff{
		no = 1002000,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = null
};

get(1002001) ->
	#skl_eff{
		no = 1002001,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {0.35,9999}
};

get(1002002) ->
	#skl_eff{
		no = 1002002,
		name = force_die_and_leave_battle,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(1002010) ->
	#skl_eff{
		no = 1002010,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead,{has_not_spec_skill, 100201}],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {by_no_list, [2, 3, 5, 6, 49, 54, 55, 56, 60]}
};

get(1002020) ->
	#skl_eff{
		no = 1002020,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead,{has_not_spec_skill, 100201}],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 1030
};

get(1002030) ->
	#skl_eff{
		no = 1002030,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead,{has_not_spec_skill, 100201}],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 1029
};

get(1002040) ->
	#skl_eff{
		no = 1002040,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead,{has_not_spec_skill, 100201}],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 1031
};

get(1002050) ->
	#skl_eff{
		no = 1002050,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead,{has_not_spec_skill, 100201}],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 1032
};

get(1002060) ->
	#skl_eff{
		no = 1002060,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead,{has_not_spec_skill, 100201}],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = {hp_lim, 0.2}
};

get(1000000) ->
	#skl_eff{
		no = 1000000,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(1000010) ->
	#skl_eff{
		no = 1000010,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(1000050) ->
	#skl_eff{
		no = 1000050,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, has_not_invisible_eff],
		rules_sort_target = [{has_not_spec_buff_first,3001}],
		target_count = xinfa_related,
		para = 3001
};

get(1000060) ->
	#skl_eff{
		no = 1000060,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(1000061) ->
	#skl_eff{
		no = 1000061,
		name = tmp_force_set_phy_combo_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 2
};

get(1001010) ->
	#skl_eff{
		no = 1001010,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 1028
};

get(1001020) ->
	#skl_eff{
		no = 1001020,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, is_not_player],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = null
};

get(1001030) ->
	#skl_eff{
		no = 1001030,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = null
};

get(1001050) ->
	#skl_eff{
		no = 1001050,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side],
		rules_sort_target = [cur_pick_target_first,{spec_mon_first, 25005}],
		target_count = xinfa_related,
		para = null
};

get(1001060) ->
	#skl_eff{
		no = 1001060,
		name = heal_hp_and_add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, {spec_mon_first, 25003},{spec_mon_first, 25002}],
		target_count = xinfa_related,
		para = 28
};

get(1001070) ->
	#skl_eff{
		no = 1001070,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side],
		rules_sort_target = [{spec_mon_first,25002},{spec_mon_first,25003}, {spec_mon_first,25011},{spec_mon_first,25004}],
		target_count = xinfa_related,
		para = null
};

get(1001080) ->
	#skl_eff{
		no = 1001080,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side],
		rules_sort_target = [{spec_mon_first,25002},{spec_mon_first,25003}, {spec_mon_first,25011},{spec_mon_first,25012}],
		target_count = xinfa_related,
		para = null
};

get(1001110) ->
	#skl_eff{
		no = 1001110,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side],
		rules_sort_target = [{spec_mon_first,25001},{spec_mon_first,25002}, {spec_mon_first,2503},{spec_mon_first,25011}],
		target_count = xinfa_related,
		para = 1028
};

get(1001130) ->
	#skl_eff{
		no = 1001130,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side],
		rules_sort_target = [cur_pick_target_first, {spec_mon_first,25001},{spec_mon_first,25002},{spec_mon_first,25003},{spec_mon_first,25011}],
		target_count = xinfa_related,
		para = null
};

get(1001131) ->
	#skl_eff{
		no = 1001131,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [],
		target_count = xinfa_related,
		para = null
};

get(2000000) ->
	#skl_eff{
		no = 2000000,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first],
		target_count = 1,
		para = {hp_lim, 1}
};

get(2000001) ->
	#skl_eff{
		no = 2000001,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first],
		target_count = 10,
		para = {hp_lim, 1}
};

get(2000002) ->
	#skl_eff{
		no = 2000002,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_category_buff_first,2}],
		target_count = 6,
		para = 1
};

get(2000003) ->
	#skl_eff{
		no = 2000003,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 280,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = 4014
};

get(2000004) ->
	#skl_eff{
		no = 2000004,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 4002
};

get(2000005) ->
	#skl_eff{
		no = 2000005,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 4003
};

get(2000006) ->
	#skl_eff{
		no = 2000006,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 200,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {by_no_list, [1, 2, 3, 4, 5, 6, 49, 54, 55, 56, 60]}
};

get(2000007) ->
	#skl_eff{
		no = 2000007,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead, ally_side],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_buff_first,41}, {has_not_spec_buff_first,42}],
		target_count = xinfa_related,
		para = 4005
};

get(2000008) ->
	#skl_eff{
		no = 2000008,
		name = tmp_force_set_phy_combo_att_times,
		need_perf_casting = 0,
		trigger_proba = 250,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 3
};

get(2000009) ->
	#skl_eff{
		no = 2000009,
		name = tmp_force_set_phy_combo_att_times,
		need_perf_casting = 0,
		trigger_proba = 100,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 4
};

get(2000010) ->
	#skl_eff{
		no = 2000010,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = null
};

get(2000011) ->
	#skl_eff{
		no = 2000011,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 4016
};

get(4000001) ->
	#skl_eff{
		no = 4000001,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(4000002) ->
	#skl_eff{
		no = 4000002,
		name = tmp_force_set_phy_combo_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 20
};

get(4000003) ->
	#skl_eff{
		no = 4000003,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(4000004) ->
	#skl_eff{
		no = 4000004,
		name = tmp_force_set_phy_combo_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 20
};

get(4000005) ->
	#skl_eff{
		no = 4000005,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = null
};

get(4000006) ->
	#skl_eff{
		no = 4000006,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = {hp_lim, 0.1}
};

get(4000007) ->
	#skl_eff{
		no = 4000007,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [4038]
};

get(4000008) ->
	#skl_eff{
		no = 4000008,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = 1,
		para = null
};

get(4000009) ->
	#skl_eff{
		no = 4000009,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = [4081,4082]
};

get(4000010) ->
	#skl_eff{
		no = 4000010,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 5,
		para = null
};

get(4000011) ->
	#skl_eff{
		no = 4000011,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 5,
		para = null
};

get(4000012) ->
	#skl_eff{
		no = 4000012,
		name = do_attack,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [not_frozen_first, cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(4000013) ->
	#skl_eff{
		no = 4000013,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = null
};

get(4000014) ->
	#skl_eff{
		no = 4000014,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(4000015) ->
	#skl_eff{
		no = 4000015,
		name = tmp_force_set_phy_combo_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 2
};

get(4000016) ->
	#skl_eff{
		no = 4000016,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 37
};

get(4000017) ->
	#skl_eff{
		no = 4000017,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 3,
		para = null
};

get(4000018) ->
	#skl_eff{
		no = 4000018,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 5,
		para = null
};

get(4000019) ->
	#skl_eff{
		no = 4000019,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 20
};

get(4000020) ->
	#skl_eff{
		no = 4000020,
		name = do_attack,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [not_frozen_first, cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(4000021) ->
	#skl_eff{
		no = 4000021,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 4031
};

get(4000022) ->
	#skl_eff{
		no = 4000022,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first],
		target_count = 1,
		para = {hp_lim, 1}
};

get(4000023) ->
	#skl_eff{
		no = 4000023,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead,is_under_control],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = {by_no_list, [1, 2, 3,4, 5, 6, 49, 54, 55, 56, 60,4000,4001,4014]}
};

get(4000024) ->
	#skl_eff{
		no = 4000024,
		name = heal_hp,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 3,
		para = {hp_lim, 0.1}
};

get(4000025) ->
	#skl_eff{
		no = 4000025,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 3,
		para = 4038
};

get(4000026) ->
	#skl_eff{
		no = 4000026,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4084
};

get(4000027) ->
	#skl_eff{
		no = 4000027,
		name = tmp_force_set_phy_combo_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 3
};

get(4000028) ->
	#skl_eff{
		no = 4000028,
		name = splash,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 1,
		para = {2,0.8}
};

get(4000029) ->
	#skl_eff{
		no = 4000029,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000030) ->
	#skl_eff{
		no = 4000030,
		name = tmp_mark_do_fix_mp_dam_by_xinfa_lv,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(4000031) ->
	#skl_eff{
		no = 4000031,
		name = reduce_target_mp_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(4000032) ->
	#skl_eff{
		no = 4000032,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000033) ->
	#skl_eff{
		no = 4000033,
		name = tmp_mark_do_fix_mp_dam_by_xinfa_lv,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(4000034) ->
	#skl_eff{
		no = 4000034,
		name = do_attack,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = xinfa_related,
		para = null
};

get(4000035) ->
	#skl_eff{
		no = 4000035,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = 5,
		para = null
};

get(4000036) ->
	#skl_eff{
		no = 4000036,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [cur_pick_target_first, {has_not_spec_category_buff_first,2}],
		target_count = 1,
		para = 3
};

get(4000037) ->
	#skl_eff{
		no = 4000037,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first,{has_not_spec_buff_first,4021},sort_by_phy_att_desc],
		target_count = 5,
		para = [4090,4093]
};

get(4000038) ->
	#skl_eff{
		no = 4000038,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first,{has_not_spec_buff_first,4021},sort_by_phy_att_desc],
		target_count = 5,
		para = 4092
};

get(4000039) ->
	#skl_eff{
		no = 4000039,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000040) ->
	#skl_eff{
		no = 4000040,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first,{has_not_spec_buff_first,35}],
		target_count = xinfa_related,
		para = [35,4025]
};

get(4000041) ->
	#skl_eff{
		no = 4000041,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first,{has_not_spec_buff_first,4021},sort_by_phy_att_desc],
		target_count = xinfa_related,
		para = 4103
};

get(4000042) ->
	#skl_eff{
		no = 4000042,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = xinfa_related,
		para = 6
};

get(4000043) ->
	#skl_eff{
		no = 4000043,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000044) ->
	#skl_eff{
		no = 4000044,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000045) ->
	#skl_eff{
		no = 4000045,
		name = revive,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = null
};

get(4000046) ->
	#skl_eff{
		no = 4000046,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 4045
};

get(4000047) ->
	#skl_eff{
		no = 4000047,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4129
};

get(4000048) ->
	#skl_eff{
		no = 4000048,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_mp_asce],
		target_count = xinfa_related,
		para = 4130
};

get(4000049) ->
	#skl_eff{
		no = 4000049,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000050) ->
	#skl_eff{
		no = 4000050,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,loss_hp,117,0.7}
};

get(4000051) ->
	#skl_eff{
		no = 4000051,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first,{has_not_spec_buff_first,4135},sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4135
};

get(4000052) ->
	#skl_eff{
		no = 4000052,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {by_no_list, [1,2,3,4,5,6,4031,4000]}
};

get(4000053) ->
	#skl_eff{
		no = 4000053,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 4045
};

get(4000054) ->
	#skl_eff{
		no = 4000054,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000055) ->
	#skl_eff{
		no = 4000055,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4140
};

get(4000056) ->
	#skl_eff{
		no = 4000056,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4141
};

get(4000057) ->
	#skl_eff{
		no = 4000057,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000058) ->
	#skl_eff{
		no = 4000058,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = [4143, 4144]
};

get(4000059) ->
	#skl_eff{
		no = 4000059,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 4147
};

get(4000060) ->
	#skl_eff{
		no = 4000060,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [],
		target_count = xinfa_related,
		para = [4145, 4146]
};

get(4000061) ->
	#skl_eff{
		no = 4000061,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000062) ->
	#skl_eff{
		no = 4000062,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,loss_hp,117,0.8}
};

get(4000063) ->
	#skl_eff{
		no = 4000063,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000064) ->
	#skl_eff{
		no = 4000064,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,hp,117,0.8}
};

get(4000065) ->
	#skl_eff{
		no = 4000065,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = xinfa_related,
		para = 4155
};

get(4000066) ->
	#skl_eff{
		no = 4000066,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4156
};

get(4000067) ->
	#skl_eff{
		no = 4000067,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_mp_asce],
		target_count = xinfa_related,
		para = 4157
};

get(4000068) ->
	#skl_eff{
		no = 4000068,
		name = revive,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = null
};

get(4000069) ->
	#skl_eff{
		no = 4000069,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(4000070) ->
	#skl_eff{
		no = 4000070,
		name = tmp_force_set_phy_combo_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 4
};

get(4000071) ->
	#skl_eff{
		no = 4000071,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000072) ->
	#skl_eff{
		no = 4000072,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = [4167, 4168]
};

get(4000073) ->
	#skl_eff{
		no = 4000073,
		name = revive,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = null
};

get(4000074) ->
	#skl_eff{
		no = 4000074,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 4045
};

get(4000075) ->
	#skl_eff{
		no = 4000075,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4169
};

get(4000076) ->
	#skl_eff{
		no = 4000076,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_mp_asce],
		target_count = xinfa_related,
		para = 4170
};

get(4000077) ->
	#skl_eff{
		no = 4000077,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {by_no_list, [1,2,3,4,5,6,4031,4000]}
};

get(4000078) ->
	#skl_eff{
		no = 4000078,
		name = do_attack,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [not_frozen_first, cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = xinfa_related,
		para = null
};

get(4000079) ->
	#skl_eff{
		no = 4000079,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 4175
};

get(4000080) ->
	#skl_eff{
		no = 4000080,
		name = do_attack,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me],
		rules_sort_target = [not_frozen_first, cur_pick_target_first,  sjjh_principle,not_trance_first],
		target_count = xinfa_related,
		para = null
};

get(4000081) ->
	#skl_eff{
		no = 4000081,
		name = reduce_target_mp_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = xinfa_related,
		para = null
};

get(4000082) ->
	#skl_eff{
		no = 4000082,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 4179
};

get(4000083) ->
	#skl_eff{
		no = 4000083,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4183
};

get(4000084) ->
	#skl_eff{
		no = 4000084,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first,{has_not_spec_buff_first,4135},sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4182
};

get(4000085) ->
	#skl_eff{
		no = 4000085,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000086) ->
	#skl_eff{
		no = 4000086,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4187
};

get(4000087) ->
	#skl_eff{
		no = 4000087,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_mp_asce],
		target_count = xinfa_related,
		para = 4188
};

get(4000088) ->
	#skl_eff{
		no = 4000088,
		name = revive,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = null
};

get(4000089) ->
	#skl_eff{
		no = 4000089,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 4192
};

get(4000090) ->
	#skl_eff{
		no = 4000090,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4193
};

get(4000091) ->
	#skl_eff{
		no = 4000091,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000092) ->
	#skl_eff{
		no = 4000092,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,loss_hp,117,0.6}
};

get(4000093) ->
	#skl_eff{
		no = 4000093,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {by_eff_type,good,7}
};

get(4000094) ->
	#skl_eff{
		no = 4000094,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first,{has_not_spec_buff_first,4135},sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4194
};

get(4000095) ->
	#skl_eff{
		no = 4000095,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 4045
};

get(4000096) ->
	#skl_eff{
		no = 4000096,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4195
};

get(4000097) ->
	#skl_eff{
		no = 4000097,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_mp_asce],
		target_count = xinfa_related,
		para = 4196
};

get(4000098) ->
	#skl_eff{
		no = 4000098,
		name = revive,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = null
};

get(4000099) ->
	#skl_eff{
		no = 4000099,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4046
};

get(4000100) ->
	#skl_eff{
		no = 4000100,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000101) ->
	#skl_eff{
		no = 4000101,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,loss_hp,117,0.7}
};

get(4000102) ->
	#skl_eff{
		no = 4000102,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 4212
};

get(4000103) ->
	#skl_eff{
		no = 4000103,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 600,
		rules_filter_target = [myself, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4201
};

get(4000104) ->
	#skl_eff{
		no = 4000104,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 4211
};

get(4000105) ->
	#skl_eff{
		no = 4000105,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 4221
};

get(4000106) ->
	#skl_eff{
		no = 4000106,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = 4213
};

get(4000107) ->
	#skl_eff{
		no = 4000107,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 4214
};

get(4000108) ->
	#skl_eff{
		no = 4000108,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4215
};

get(4000109) ->
	#skl_eff{
		no = 4000109,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000110) ->
	#skl_eff{
		no = 4000110,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,loss_hp,117,0.6}
};

get(4000111) ->
	#skl_eff{
		no = 4000111,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [4240, 4241, 4242, 4243]
};

get(4000112) ->
	#skl_eff{
		no = 4000112,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [4244, 4245]
};

get(4000113) ->
	#skl_eff{
		no = 4000113,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [4246, 4247, 4248]
};

get(4000114) ->
	#skl_eff{
		no = 4000114,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [4249, 4250, 4251]
};

get(4000115) ->
	#skl_eff{
		no = 4000115,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [4252, 4253]
};

get(4000116) ->
	#skl_eff{
		no = 4000116,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [4254, 4255]
};

get(4000117) ->
	#skl_eff{
		no = 4000117,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [4256, 4257, 4258, 4259, 4260]
};

get(4000118) ->
	#skl_eff{
		no = 4000118,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [4261, 4262, 4253]
};

get(4000119) ->
	#skl_eff{
		no = 4000119,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = [4264, 4265]
};

get(4000120) ->
	#skl_eff{
		no = 4000120,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [undead, not_invisible_to_me, is_not_frozen, enemy_side],
		rules_sort_target = [cur_pick_target_first, sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000121) ->
	#skl_eff{
		no = 4000121,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,hp,117,0.8}
};

get(4000122) ->
	#skl_eff{
		no = 4000122,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = xinfa_related,
		para = 4266
};

get(4000123) ->
	#skl_eff{
		no = 4000123,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4267
};

get(4000124) ->
	#skl_eff{
		no = 4000124,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_mp_asce],
		target_count = xinfa_related,
		para = 4268
};

get(4000125) ->
	#skl_eff{
		no = 4000125,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 300,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = infinite,
		para = 4269
};

get(4000126) ->
	#skl_eff{
		no = 4000126,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 400,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 4270
};

get(4000127) ->
	#skl_eff{
		no = 4000127,
		name = revive,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first, dead_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = null
};

get(4000128) ->
	#skl_eff{
		no = 4000128,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 4277
};

get(4000129) ->
	#skl_eff{
		no = 4000129,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_hp_asce],
		target_count = xinfa_related,
		para = 4278
};

get(4000130) ->
	#skl_eff{
		no = 4000130,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first, sort_by_mp_asce],
		target_count = xinfa_related,
		para = 4279
};

get(4000131) ->
	#skl_eff{
		no = 4000131,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {by_no_list, [1,2,3,4,5,6,4031,4000]}
};

get(4000132) ->
	#skl_eff{
		no = 4000132,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {by_eff_type,good,7}
};

get(4000133) ->
	#skl_eff{
		no = 4000133,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 4280
};

get(4000134) ->
	#skl_eff{
		no = 4000134,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [],
		target_count = xinfa_related,
		para = [4286, 4287]
};

get(4000135) ->
	#skl_eff{
		no = 4000135,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 4290
};

get(4000136) ->
	#skl_eff{
		no = 4000136,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, not_trance_first,sort_by_act_speed_desc],
		target_count = xinfa_related,
		para = null
};

get(4000137) ->
	#skl_eff{
		no = 4000137,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {hp_lim,loss_hp,117,0.7}
};

get(4000138) ->
	#skl_eff{
		no = 4000138,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [cur_att_target],
		rules_sort_target = [],
		target_count = xinfa_related,
		para = 4291
};

get(1000020) ->
	#skl_eff{
		no = 1000020,
		name = tmp_force_set_phy_combo_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 5
};

get(1000021) ->
	#skl_eff{
		no = 1000021,
		name = tmp_force_set_pursue_att_proba,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 1000
};

get(1000022) ->
	#skl_eff{
		no = 1000022,
		name = tmp_force_set_max_pursue_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 5
};

get(1000023) ->
	#skl_eff{
		no = 1000023,
		name = tmp_force_set_pursue_att_dam_coef,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 2
};

get(1000024) ->
	#skl_eff{
		no = 1000024,
		name = tmp_mark_do_dam_by_defer_hp_rate_with_limit,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = {0.5,hp_lim,1}
};

get(1000030) ->
	#skl_eff{
		no = 1000030,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [],
		target_count = 10,
		para = {by_no_list, [1,2,3,4,5,6,4031,4000]}
};

get(1000031) ->
	#skl_eff{
		no = 1000031,
		name = add_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [],
		target_count = 10,
		para = 4320
};

get(1000032) ->
	#skl_eff{
		no = 1000032,
		name = force_die_and_leave_battle,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = null
};

get(1000033) ->
	#skl_eff{
		no = 1000033,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 4321
};

get(1000034) ->
	#skl_eff{
		no = 1000034,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 3,
		para = 4322
};

get(1000035) ->
	#skl_eff{
		no = 1000035,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side ,undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 10,
		para = {by_eff_type,good,99}
};

get(1000036) ->
	#skl_eff{
		no = 1000036,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side ,undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = {by_buff_name, dummy, 999}
};

get(1000037) ->
	#skl_eff{
		no = 1000037,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 4321
};

get(1000038) ->
	#skl_eff{
		no = 1000038,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 5,
		para = 4324
};

get(20000001) ->
	#skl_eff{
		no = 20000001,
		name = add_multi_buffs,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = [5001, 5002]
};

get(5000001) ->
	#skl_eff{
		no = 5000001,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = {by_no_list, [1, 2, 3,4, 5, 6, 49, 54, 55, 56, 60,4000,4001,4014]}
};

get(5000002) ->
	#skl_eff{
		no = 5000002,
		name = purge_buff,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {by_no_list, [1, 2, 3,4, 5, 6, 49, 54, 55, 56, 60,4000,4001,4014]}
};

get(5000003) ->
	#skl_eff{
		no = 5000003,
		name = heal_hp,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = {hp_lim, 0.25}
};

get(5000004) ->
	#skl_eff{
		no = 5000004,
		name = heal_hp,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {hp_lim, 0.15}
};

get(5000005) ->
	#skl_eff{
		no = 5000005,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 30001
};

get(5000006) ->
	#skl_eff{
		no = 5000006,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 30002
};

get(5000007) ->
	#skl_eff{
		no = 5000007,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 30003
};

get(5000008) ->
	#skl_eff{
		no = 5000008,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 30004
};

get(5000009) ->
	#skl_eff{
		no = 5000009,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 30005
};

get(5000010) ->
	#skl_eff{
		no = 5000010,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 30006
};

get(5000011) ->
	#skl_eff{
		no = 5000011,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 30007
};

get(5000012) ->
	#skl_eff{
		no = 5000012,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 30008
};

get(5000013) ->
	#skl_eff{
		no = 5000013,
		name = add_multi_buffs,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = [30009,30010]
};

get(5000014) ->
	#skl_eff{
		no = 5000014,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 30011
};

get(5000015) ->
	#skl_eff{
		no = 5000015,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 30012
};

get(5000016) ->
	#skl_eff{
		no = 5000016,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 30013
};

get(5000017) ->
	#skl_eff{
		no = 5000017,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 30014
};

get(5000018) ->
	#skl_eff{
		no = 5000018,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 30015
};

get(5000019) ->
	#skl_eff{
		no = 5000019,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = 30016
};

get(5000020) ->
	#skl_eff{
		no = 5000020,
		name = add_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [myself],
		rules_sort_target = [],
		target_count = 1,
		para = 30017
};

get(5000021) ->
	#skl_eff{
		no = 5000021,
		name = revive,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {hp_lim, 990}
};

get(5000022) ->
	#skl_eff{
		no = 5000022,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen],
		rules_sort_target = [cur_pick_target_first, sjjh_principle,not_trance_first],
		target_count = 1,
		para = null
};

get(5000023) ->
	#skl_eff{
		no = 5000023,
		name = tmp_force_set_phy_combo_att_times,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [myself, undead],
		rules_sort_target = [],
		target_count = 1,
		para = 1
};

get(5000024) ->
	#skl_eff{
		no = 5000024,
		name = reduce_target_anger_by_do_skill_att,
		need_perf_casting = 0,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = 70
};

get(5000025) ->
	#skl_eff{
		no = 5000025,
		name = do_attack,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [enemy_side, undead, not_invisible_to_me, is_not_frozen, is_not_monster],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = null
};

get(5000026) ->
	#skl_eff{
		no = 5000026,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = 1,
		para = {by_no_list, [1, 2, 3,4, 5, 6, 49, 54, 55, 56, 60,4000,4001,4014]}
};

get(5000027) ->
	#skl_eff{
		no = 5000027,
		name = purge_buff,
		need_perf_casting = 1,
		trigger_proba = 1000,
		rules_filter_target = [ally_side, undead],
		rules_sort_target = [cur_pick_target_first],
		target_count = xinfa_related,
		para = {by_no_list, [1, 2, 3,4, 5, 6, 49, 54, 55, 56, 60,4000,4001,4014]}
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

