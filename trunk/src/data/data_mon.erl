%%%---------------------------------------
%%% @Module  : data_mon
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description:  明雷怪模板
%%%---------------------------------------


-module(data_mon).
-export([get/1]).
-include("monster.hrl").
-include("debug.hrl").

get(10001) ->
	#mon_tpl{
		no = 10001,
		name = <<"金刚护卫">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [7501],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1200,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,70,300}}]
};

get(10002) ->
	#mon_tpl{
		no = 10002,
		name = <<"淘气童子">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [7502],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1200,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,70,300}}]
};

get(10003) ->
	#mon_tpl{
		no = 10003,
		name = <<"掌灯侍女">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [7503],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1200,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,70,300}}]
};

get(10004) ->
	#mon_tpl{
		no = 10004,
		name = <<"星宿护卫头领">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [7504],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1200,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,70,300}}]
};

get(10011) ->
	#mon_tpl{
		no = 10011,
		name = <<"角木蛟">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7505],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10012) ->
	#mon_tpl{
		no = 10012,
		name = <<"亢金龙">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7506],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10013) ->
	#mon_tpl{
		no = 10013,
		name = <<"女士蝠">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7507],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10014) ->
	#mon_tpl{
		no = 10014,
		name = <<"房日兔">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7508],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10015) ->
	#mon_tpl{
		no = 10015,
		name = <<"心月狐">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7509],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10016) ->
	#mon_tpl{
		no = 10016,
		name = <<"尾火虎">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7510],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10017) ->
	#mon_tpl{
		no = 10017,
		name = <<"箕水豹">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7511],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10018) ->
	#mon_tpl{
		no = 10018,
		name = <<"奎木狼">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7512],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10019) ->
	#mon_tpl{
		no = 10019,
		name = <<"娄金狗">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7513],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10020) ->
	#mon_tpl{
		no = 10020,
		name = <<"胃土雉">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7514],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10021) ->
	#mon_tpl{
		no = 10021,
		name = <<"昂日鸡">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7515],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10022) ->
	#mon_tpl{
		no = 10022,
		name = <<"毕月乌">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7516],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10023) ->
	#mon_tpl{
		no = 10023,
		name = <<"觜火猴">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7517],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10024) ->
	#mon_tpl{
		no = 10024,
		name = <<"参水猿">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7518],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10025) ->
	#mon_tpl{
		no = 10025,
		name = <<"井木犴">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7519],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10026) ->
	#mon_tpl{
		no = 10026,
		name = <<"鬼金羊">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7520],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10027) ->
	#mon_tpl{
		no = 10027,
		name = <<"柳土獐">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7521],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10028) ->
	#mon_tpl{
		no = 10028,
		name = <<"星日马">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7522],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10029) ->
	#mon_tpl{
		no = 10029,
		name = <<"张月鹿">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7523],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10030) ->
	#mon_tpl{
		no = 10030,
		name = <<"翼火蛇">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7524],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10031) ->
	#mon_tpl{
		no = 10031,
		name = <<"轸水蚓">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7525],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10032) ->
	#mon_tpl{
		no = 10032,
		name = <<"斗木獬">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7526],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10033) ->
	#mon_tpl{
		no = 10033,
		name = <<"牛金牛">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7527],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10034) ->
	#mon_tpl{
		no = 10034,
		name = <<"氐土貉">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7528],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10035) ->
	#mon_tpl{
		no = 10035,
		name = <<"虚日鼠">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7529],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10036) ->
	#mon_tpl{
		no = 10036,
		name = <<"危月燕">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7530],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10037) ->
	#mon_tpl{
		no = 10037,
		name = <<"室火猪">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7531],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10038) ->
	#mon_tpl{
		no = 10038,
		name = <<"壁水柱">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [7532],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,100,300}}]
};

get(10039) ->
	#mon_tpl{
		no = 10039,
		name = <<"角木蛟之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7533],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10040) ->
	#mon_tpl{
		no = 10040,
		name = <<"亢金龙之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7534],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10041) ->
	#mon_tpl{
		no = 10041,
		name = <<"女士蝠之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7535],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10042) ->
	#mon_tpl{
		no = 10042,
		name = <<"房日兔之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7536],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10043) ->
	#mon_tpl{
		no = 10043,
		name = <<"心月狐之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7537],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10044) ->
	#mon_tpl{
		no = 10044,
		name = <<"尾火虎之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7538],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10045) ->
	#mon_tpl{
		no = 10045,
		name = <<"箕水豹之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7539],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10046) ->
	#mon_tpl{
		no = 10046,
		name = <<"奎木狼之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7540],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10047) ->
	#mon_tpl{
		no = 10047,
		name = <<"娄金狗之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7541],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10048) ->
	#mon_tpl{
		no = 10048,
		name = <<"胃土雉之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7542],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10049) ->
	#mon_tpl{
		no = 10049,
		name = <<"昂日鸡之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7543],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10050) ->
	#mon_tpl{
		no = 10050,
		name = <<"毕月乌之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7544],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10051) ->
	#mon_tpl{
		no = 10051,
		name = <<"觜火猴之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7545],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10052) ->
	#mon_tpl{
		no = 10052,
		name = <<"参水猿之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7546],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10053) ->
	#mon_tpl{
		no = 10053,
		name = <<"井木犴之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7547],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10054) ->
	#mon_tpl{
		no = 10054,
		name = <<"鬼金羊之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7548],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10055) ->
	#mon_tpl{
		no = 10055,
		name = <<"柳土獐之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7549],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10056) ->
	#mon_tpl{
		no = 10056,
		name = <<"星日马之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7550],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10057) ->
	#mon_tpl{
		no = 10057,
		name = <<"张月鹿之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7551],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10058) ->
	#mon_tpl{
		no = 10058,
		name = <<"翼火蛇之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7552],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10059) ->
	#mon_tpl{
		no = 10059,
		name = <<"轸水蚓之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7553],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10060) ->
	#mon_tpl{
		no = 10060,
		name = <<"斗木獬之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7554],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10061) ->
	#mon_tpl{
		no = 10061,
		name = <<"牛金牛之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7555],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10062) ->
	#mon_tpl{
		no = 10062,
		name = <<"氐土貉之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7556],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10063) ->
	#mon_tpl{
		no = 10063,
		name = <<"虚日鼠之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7557],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10064) ->
	#mon_tpl{
		no = 10064,
		name = <<"危月燕之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7558],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10065) ->
	#mon_tpl{
		no = 10065,
		name = <<"室火猪之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7559],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(10066) ->
	#mon_tpl{
		no = 10066,
		name = <<"壁水柱之怒">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [7560],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 2400,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,120,300}}]
};

get(13000) ->
	#mon_tpl{
		no = 13000,
		name = <<"魔星后卿">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [3000],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1200,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(13001) ->
	#mon_tpl{
		no = 13001,
		name = <<"遁神银灵子">>,
		type = 4,
		lv = 50,
		bmon_group_no_list = [3001],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1200,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(13002) ->
	#mon_tpl{
		no = 13002,
		name = <<"冥神郁垒">>,
		type = 4,
		lv = 60,
		bmon_group_no_list = [3002],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1200,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(13003) ->
	#mon_tpl{
		no = 13003,
		name = <<"冥神神荼">>,
		type = 4,
		lv = 70,
		bmon_group_no_list = [3003],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1200,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(15000) ->
	#mon_tpl{
		no = 15000,
		name = <<"冥界突袭军">>,
		type = 3,
		lv = 80,
		bmon_group_no_list = [5000, 5001, 5002, 5003, 5008,5009,5071,5072],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1200,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count,2}},{single_or_in_team, {lv_all_between,80,300}}]
};

get(15001) ->
	#mon_tpl{
		no = 15001,
		name = <<"冥界小卒">>,
		type = 3,
		lv = 80,
		bmon_group_no_list = [5000, 5001, 5002, 5003, 5008,5009,5071,5072],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1200,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team, {lv_all_between,80,300}}]
};

get(16001) ->
	#mon_tpl{
		no = 16001,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4112],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16002) ->
	#mon_tpl{
		no = 16002,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4113],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16003) ->
	#mon_tpl{
		no = 16003,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4114],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16004) ->
	#mon_tpl{
		no = 16004,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4115],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16005) ->
	#mon_tpl{
		no = 16005,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4116],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16006) ->
	#mon_tpl{
		no = 16006,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4117],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16007) ->
	#mon_tpl{
		no = 16007,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4118],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16008) ->
	#mon_tpl{
		no = 16008,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4119],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16009) ->
	#mon_tpl{
		no = 16009,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4120],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16010) ->
	#mon_tpl{
		no = 16010,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [504100],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16011) ->
	#mon_tpl{
		no = 16011,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [4101],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16012) ->
	#mon_tpl{
		no = 16012,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [4102],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16013) ->
	#mon_tpl{
		no = 16013,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [4103],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16014) ->
	#mon_tpl{
		no = 16014,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [4104],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16015) ->
	#mon_tpl{
		no = 16015,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [4105],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16016) ->
	#mon_tpl{
		no = 16016,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [4106],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16017) ->
	#mon_tpl{
		no = 16017,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [4107],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16018) ->
	#mon_tpl{
		no = 16018,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [4108],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16019) ->
	#mon_tpl{
		no = 16019,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [4109],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16020) ->
	#mon_tpl{
		no = 16020,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [4110],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16021) ->
	#mon_tpl{
		no = 16021,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [4111],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16022) ->
	#mon_tpl{
		no = 16022,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4120],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16023) ->
	#mon_tpl{
		no = 16023,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4121],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16024) ->
	#mon_tpl{
		no = 16024,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4122],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16025) ->
	#mon_tpl{
		no = 16025,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4123],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16026) ->
	#mon_tpl{
		no = 16026,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4124],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16027) ->
	#mon_tpl{
		no = 16027,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4125],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16028) ->
	#mon_tpl{
		no = 16028,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4126],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16029) ->
	#mon_tpl{
		no = 16029,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4127],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16030) ->
	#mon_tpl{
		no = 16030,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4128],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16031) ->
	#mon_tpl{
		no = 16031,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4129],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16032) ->
	#mon_tpl{
		no = 16032,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4130],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16033) ->
	#mon_tpl{
		no = 16033,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4131],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16034) ->
	#mon_tpl{
		no = 16034,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4132],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16035) ->
	#mon_tpl{
		no = 16035,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4133],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16036) ->
	#mon_tpl{
		no = 16036,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4134],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16037) ->
	#mon_tpl{
		no = 16037,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4135],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16038) ->
	#mon_tpl{
		no = 16038,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4136],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16039) ->
	#mon_tpl{
		no = 16039,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4137],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16040) ->
	#mon_tpl{
		no = 16040,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4138],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16041) ->
	#mon_tpl{
		no = 16041,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4139],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16042) ->
	#mon_tpl{
		no = 16042,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4140],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16043) ->
	#mon_tpl{
		no = 16043,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4141],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16044) ->
	#mon_tpl{
		no = 16044,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4142],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(16045) ->
	#mon_tpl{
		no = 16045,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4143],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17001) ->
	#mon_tpl{
		no = 17001,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4500],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17002) ->
	#mon_tpl{
		no = 17002,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4501],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17003) ->
	#mon_tpl{
		no = 17003,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4502],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17004) ->
	#mon_tpl{
		no = 17004,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4503],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17005) ->
	#mon_tpl{
		no = 17005,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4504],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17006) ->
	#mon_tpl{
		no = 17006,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4505],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17007) ->
	#mon_tpl{
		no = 17007,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4506],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17008) ->
	#mon_tpl{
		no = 17008,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4507],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17009) ->
	#mon_tpl{
		no = 17009,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4508],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17010) ->
	#mon_tpl{
		no = 17010,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4509],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17011) ->
	#mon_tpl{
		no = 17011,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4510],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17012) ->
	#mon_tpl{
		no = 17012,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4511],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17013) ->
	#mon_tpl{
		no = 17013,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4512],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17014) ->
	#mon_tpl{
		no = 17014,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4513],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17015) ->
	#mon_tpl{
		no = 17015,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4514],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17016) ->
	#mon_tpl{
		no = 17016,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4515],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17017) ->
	#mon_tpl{
		no = 17017,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4516],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17018) ->
	#mon_tpl{
		no = 17018,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4517],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17019) ->
	#mon_tpl{
		no = 17019,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4518],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17020) ->
	#mon_tpl{
		no = 17020,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4519],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17021) ->
	#mon_tpl{
		no = 17021,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4520],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17022) ->
	#mon_tpl{
		no = 17022,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4521],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17023) ->
	#mon_tpl{
		no = 17023,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4522],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17024) ->
	#mon_tpl{
		no = 17024,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4523],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17025) ->
	#mon_tpl{
		no = 17025,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4524],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17026) ->
	#mon_tpl{
		no = 17026,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4525],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17027) ->
	#mon_tpl{
		no = 17027,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4526],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17028) ->
	#mon_tpl{
		no = 17028,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4527],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17029) ->
	#mon_tpl{
		no = 17029,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4528],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17030) ->
	#mon_tpl{
		no = 17030,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4529],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17031) ->
	#mon_tpl{
		no = 17031,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4530],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17032) ->
	#mon_tpl{
		no = 17032,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4531],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17033) ->
	#mon_tpl{
		no = 17033,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4532],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17034) ->
	#mon_tpl{
		no = 17034,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4533],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17035) ->
	#mon_tpl{
		no = 17035,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4534],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17036) ->
	#mon_tpl{
		no = 17036,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4535],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17037) ->
	#mon_tpl{
		no = 17037,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4536],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17038) ->
	#mon_tpl{
		no = 17038,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4537],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17039) ->
	#mon_tpl{
		no = 17039,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4538],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17040) ->
	#mon_tpl{
		no = 17040,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4539],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17041) ->
	#mon_tpl{
		no = 17041,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4540],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17042) ->
	#mon_tpl{
		no = 17042,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4541],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17043) ->
	#mon_tpl{
		no = 17043,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4542],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17044) ->
	#mon_tpl{
		no = 17044,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4543],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17045) ->
	#mon_tpl{
		no = 17045,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4544],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17046) ->
	#mon_tpl{
		no = 17046,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4545],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17047) ->
	#mon_tpl{
		no = 17047,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4546],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(17048) ->
	#mon_tpl{
		no = 17048,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4547],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18001) ->
	#mon_tpl{
		no = 18001,
		name = <<"1层镇妖塔怪">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [4395],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18002) ->
	#mon_tpl{
		no = 18002,
		name = <<"2层镇妖塔怪">>,
		type = 1,
		lv = 21,
		bmon_group_no_list = [4396],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18003) ->
	#mon_tpl{
		no = 18003,
		name = <<"3层镇妖塔怪">>,
		type = 1,
		lv = 22,
		bmon_group_no_list = [4397],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18004) ->
	#mon_tpl{
		no = 18004,
		name = <<"4层镇妖塔怪">>,
		type = 1,
		lv = 23,
		bmon_group_no_list = [4398],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18005) ->
	#mon_tpl{
		no = 18005,
		name = <<"5层镇妖塔怪">>,
		type = 1,
		lv = 24,
		bmon_group_no_list = [4399],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18006) ->
	#mon_tpl{
		no = 18006,
		name = <<"6层镇妖塔怪">>,
		type = 1,
		lv = 25,
		bmon_group_no_list = [4400],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18007) ->
	#mon_tpl{
		no = 18007,
		name = <<"7层镇妖塔怪">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [4401],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18008) ->
	#mon_tpl{
		no = 18008,
		name = <<"8层镇妖塔怪">>,
		type = 1,
		lv = 27,
		bmon_group_no_list = [4402],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18009) ->
	#mon_tpl{
		no = 18009,
		name = <<"9层镇妖塔怪">>,
		type = 1,
		lv = 28,
		bmon_group_no_list = [4403],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18010) ->
	#mon_tpl{
		no = 18010,
		name = <<"10层镇妖塔怪">>,
		type = 1,
		lv = 29,
		bmon_group_no_list = [4404],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18011) ->
	#mon_tpl{
		no = 18011,
		name = <<"11层镇妖塔怪">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [4405],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18012) ->
	#mon_tpl{
		no = 18012,
		name = <<"12层镇妖塔怪">>,
		type = 1,
		lv = 31,
		bmon_group_no_list = [4406],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18013) ->
	#mon_tpl{
		no = 18013,
		name = <<"13层镇妖塔怪">>,
		type = 1,
		lv = 32,
		bmon_group_no_list = [4407],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18014) ->
	#mon_tpl{
		no = 18014,
		name = <<"14层镇妖塔怪">>,
		type = 1,
		lv = 33,
		bmon_group_no_list = [4408],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18015) ->
	#mon_tpl{
		no = 18015,
		name = <<"15层镇妖塔怪">>,
		type = 1,
		lv = 34,
		bmon_group_no_list = [4409],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18016) ->
	#mon_tpl{
		no = 18016,
		name = <<"16层镇妖塔怪">>,
		type = 1,
		lv = 35,
		bmon_group_no_list = [4410],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18017) ->
	#mon_tpl{
		no = 18017,
		name = <<"17层镇妖塔怪">>,
		type = 1,
		lv = 36,
		bmon_group_no_list = [4411],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18018) ->
	#mon_tpl{
		no = 18018,
		name = <<"18层镇妖塔怪">>,
		type = 1,
		lv = 37,
		bmon_group_no_list = [4412],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18019) ->
	#mon_tpl{
		no = 18019,
		name = <<"19层镇妖塔怪">>,
		type = 1,
		lv = 38,
		bmon_group_no_list = [4413],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18020) ->
	#mon_tpl{
		no = 18020,
		name = <<"20层镇妖塔怪">>,
		type = 1,
		lv = 39,
		bmon_group_no_list = [4414],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18021) ->
	#mon_tpl{
		no = 18021,
		name = <<"21层镇妖塔怪">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [4415],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18022) ->
	#mon_tpl{
		no = 18022,
		name = <<"22层镇妖塔怪">>,
		type = 1,
		lv = 41,
		bmon_group_no_list = [4416],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18023) ->
	#mon_tpl{
		no = 18023,
		name = <<"23层镇妖塔怪">>,
		type = 1,
		lv = 42,
		bmon_group_no_list = [4417],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18024) ->
	#mon_tpl{
		no = 18024,
		name = <<"24层镇妖塔怪">>,
		type = 1,
		lv = 43,
		bmon_group_no_list = [4418],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18025) ->
	#mon_tpl{
		no = 18025,
		name = <<"25层镇妖塔怪">>,
		type = 1,
		lv = 44,
		bmon_group_no_list = [4419],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18026) ->
	#mon_tpl{
		no = 18026,
		name = <<"26层镇妖塔怪">>,
		type = 1,
		lv = 45,
		bmon_group_no_list = [4420],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18027) ->
	#mon_tpl{
		no = 18027,
		name = <<"27层镇妖塔怪">>,
		type = 1,
		lv = 46,
		bmon_group_no_list = [4421],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18028) ->
	#mon_tpl{
		no = 18028,
		name = <<"28层镇妖塔怪">>,
		type = 1,
		lv = 47,
		bmon_group_no_list = [4422],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18029) ->
	#mon_tpl{
		no = 18029,
		name = <<"29层镇妖塔怪">>,
		type = 1,
		lv = 48,
		bmon_group_no_list = [4423],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18030) ->
	#mon_tpl{
		no = 18030,
		name = <<"30层镇妖塔怪">>,
		type = 1,
		lv = 49,
		bmon_group_no_list = [4424],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18031) ->
	#mon_tpl{
		no = 18031,
		name = <<"31层镇妖塔怪">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [4425],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18032) ->
	#mon_tpl{
		no = 18032,
		name = <<"32层镇妖塔怪">>,
		type = 1,
		lv = 51,
		bmon_group_no_list = [4426],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18033) ->
	#mon_tpl{
		no = 18033,
		name = <<"33层镇妖塔怪">>,
		type = 1,
		lv = 52,
		bmon_group_no_list = [4427],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18034) ->
	#mon_tpl{
		no = 18034,
		name = <<"34层镇妖塔怪">>,
		type = 1,
		lv = 53,
		bmon_group_no_list = [4428],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18035) ->
	#mon_tpl{
		no = 18035,
		name = <<"35层镇妖塔怪">>,
		type = 1,
		lv = 54,
		bmon_group_no_list = [4429],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18036) ->
	#mon_tpl{
		no = 18036,
		name = <<"36层镇妖塔怪">>,
		type = 1,
		lv = 55,
		bmon_group_no_list = [4430],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18037) ->
	#mon_tpl{
		no = 18037,
		name = <<"37层镇妖塔怪">>,
		type = 1,
		lv = 56,
		bmon_group_no_list = [4431],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18038) ->
	#mon_tpl{
		no = 18038,
		name = <<"38层镇妖塔怪">>,
		type = 1,
		lv = 57,
		bmon_group_no_list = [4432],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18039) ->
	#mon_tpl{
		no = 18039,
		name = <<"39层镇妖塔怪">>,
		type = 1,
		lv = 58,
		bmon_group_no_list = [4433],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18040) ->
	#mon_tpl{
		no = 18040,
		name = <<"40层镇妖塔怪">>,
		type = 1,
		lv = 59,
		bmon_group_no_list = [4434],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18041) ->
	#mon_tpl{
		no = 18041,
		name = <<"41层镇妖塔怪">>,
		type = 1,
		lv = 60,
		bmon_group_no_list = [4435],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18042) ->
	#mon_tpl{
		no = 18042,
		name = <<"42层镇妖塔怪">>,
		type = 1,
		lv = 61,
		bmon_group_no_list = [4436],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18043) ->
	#mon_tpl{
		no = 18043,
		name = <<"43层镇妖塔怪">>,
		type = 1,
		lv = 62,
		bmon_group_no_list = [4437],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18044) ->
	#mon_tpl{
		no = 18044,
		name = <<"44层镇妖塔怪">>,
		type = 1,
		lv = 63,
		bmon_group_no_list = [4438],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18045) ->
	#mon_tpl{
		no = 18045,
		name = <<"45层镇妖塔怪">>,
		type = 1,
		lv = 64,
		bmon_group_no_list = [4439],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18046) ->
	#mon_tpl{
		no = 18046,
		name = <<"46层镇妖塔怪">>,
		type = 1,
		lv = 65,
		bmon_group_no_list = [4440],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18047) ->
	#mon_tpl{
		no = 18047,
		name = <<"47层镇妖塔怪">>,
		type = 1,
		lv = 66,
		bmon_group_no_list = [4441],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18048) ->
	#mon_tpl{
		no = 18048,
		name = <<"48层镇妖塔怪">>,
		type = 1,
		lv = 67,
		bmon_group_no_list = [4442],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18049) ->
	#mon_tpl{
		no = 18049,
		name = <<"49层镇妖塔怪">>,
		type = 1,
		lv = 68,
		bmon_group_no_list = [4443],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18050) ->
	#mon_tpl{
		no = 18050,
		name = <<"50层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4444],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18051) ->
	#mon_tpl{
		no = 18051,
		name = <<"51层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4445],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18052) ->
	#mon_tpl{
		no = 18052,
		name = <<"52层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4446],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18053) ->
	#mon_tpl{
		no = 18053,
		name = <<"53层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4447],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18054) ->
	#mon_tpl{
		no = 18054,
		name = <<"54层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4448],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18055) ->
	#mon_tpl{
		no = 18055,
		name = <<"55层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4449],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18056) ->
	#mon_tpl{
		no = 18056,
		name = <<"56层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4450],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18057) ->
	#mon_tpl{
		no = 18057,
		name = <<"57层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4451],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18058) ->
	#mon_tpl{
		no = 18058,
		name = <<"58层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4452],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18059) ->
	#mon_tpl{
		no = 18059,
		name = <<"59层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4453],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18060) ->
	#mon_tpl{
		no = 18060,
		name = <<"60层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4454],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18061) ->
	#mon_tpl{
		no = 18061,
		name = <<"61层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4455],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18062) ->
	#mon_tpl{
		no = 18062,
		name = <<"62层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4456],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18063) ->
	#mon_tpl{
		no = 18063,
		name = <<"63层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4457],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18064) ->
	#mon_tpl{
		no = 18064,
		name = <<"64层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4458],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18065) ->
	#mon_tpl{
		no = 18065,
		name = <<"65层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4459],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18066) ->
	#mon_tpl{
		no = 18066,
		name = <<"66层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4460],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18067) ->
	#mon_tpl{
		no = 18067,
		name = <<"67层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4461],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18068) ->
	#mon_tpl{
		no = 18068,
		name = <<"68层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4462],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18069) ->
	#mon_tpl{
		no = 18069,
		name = <<"69层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4463],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18070) ->
	#mon_tpl{
		no = 18070,
		name = <<"70层镇妖塔怪">>,
		type = 1,
		lv = 69,
		bmon_group_no_list = [4464],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18071) ->
	#mon_tpl{
		no = 18071,
		name = <<"71层镇妖塔怪">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [4465],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18072) ->
	#mon_tpl{
		no = 18072,
		name = <<"72层镇妖塔怪">>,
		type = 1,
		lv = 71,
		bmon_group_no_list = [4466],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18073) ->
	#mon_tpl{
		no = 18073,
		name = <<"73层镇妖塔怪">>,
		type = 1,
		lv = 72,
		bmon_group_no_list = [4467],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18074) ->
	#mon_tpl{
		no = 18074,
		name = <<"74层镇妖塔怪">>,
		type = 1,
		lv = 73,
		bmon_group_no_list = [4468],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18075) ->
	#mon_tpl{
		no = 18075,
		name = <<"75层镇妖塔怪">>,
		type = 1,
		lv = 74,
		bmon_group_no_list = [4469],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18076) ->
	#mon_tpl{
		no = 18076,
		name = <<"76层镇妖塔怪">>,
		type = 1,
		lv = 75,
		bmon_group_no_list = [4470],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18077) ->
	#mon_tpl{
		no = 18077,
		name = <<"77层镇妖塔怪">>,
		type = 1,
		lv = 76,
		bmon_group_no_list = [4471],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18078) ->
	#mon_tpl{
		no = 18078,
		name = <<"78层镇妖塔怪">>,
		type = 1,
		lv = 77,
		bmon_group_no_list = [4472],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18079) ->
	#mon_tpl{
		no = 18079,
		name = <<"79层镇妖塔怪">>,
		type = 1,
		lv = 78,
		bmon_group_no_list = [4473],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18080) ->
	#mon_tpl{
		no = 18080,
		name = <<"80层镇妖塔怪">>,
		type = 1,
		lv = 79,
		bmon_group_no_list = [4474],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18081) ->
	#mon_tpl{
		no = 18081,
		name = <<"81层镇妖塔怪">>,
		type = 1,
		lv = 80,
		bmon_group_no_list = [4475],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18082) ->
	#mon_tpl{
		no = 18082,
		name = <<"82层镇妖塔怪">>,
		type = 1,
		lv = 81,
		bmon_group_no_list = [4476],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18083) ->
	#mon_tpl{
		no = 18083,
		name = <<"83层镇妖塔怪">>,
		type = 1,
		lv = 82,
		bmon_group_no_list = [4477],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18084) ->
	#mon_tpl{
		no = 18084,
		name = <<"84层镇妖塔怪">>,
		type = 1,
		lv = 83,
		bmon_group_no_list = [4478],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18085) ->
	#mon_tpl{
		no = 18085,
		name = <<"85层镇妖塔怪">>,
		type = 1,
		lv = 84,
		bmon_group_no_list = [4479],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18086) ->
	#mon_tpl{
		no = 18086,
		name = <<"86层镇妖塔怪">>,
		type = 1,
		lv = 85,
		bmon_group_no_list = [4480],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18087) ->
	#mon_tpl{
		no = 18087,
		name = <<"87层镇妖塔怪">>,
		type = 1,
		lv = 86,
		bmon_group_no_list = [4481],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18088) ->
	#mon_tpl{
		no = 18088,
		name = <<"88层镇妖塔怪">>,
		type = 1,
		lv = 87,
		bmon_group_no_list = [4482],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18089) ->
	#mon_tpl{
		no = 18089,
		name = <<"89层镇妖塔怪">>,
		type = 1,
		lv = 88,
		bmon_group_no_list = [4483],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18090) ->
	#mon_tpl{
		no = 18090,
		name = <<"90层镇妖塔怪">>,
		type = 1,
		lv = 89,
		bmon_group_no_list = [4484],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18091) ->
	#mon_tpl{
		no = 18091,
		name = <<"91层镇妖塔怪">>,
		type = 1,
		lv = 90,
		bmon_group_no_list = [4485],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18092) ->
	#mon_tpl{
		no = 18092,
		name = <<"92层镇妖塔怪">>,
		type = 1,
		lv = 91,
		bmon_group_no_list = [4486],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18093) ->
	#mon_tpl{
		no = 18093,
		name = <<"93层镇妖塔怪">>,
		type = 1,
		lv = 92,
		bmon_group_no_list = [4487],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18094) ->
	#mon_tpl{
		no = 18094,
		name = <<"94层镇妖塔怪">>,
		type = 1,
		lv = 93,
		bmon_group_no_list = [4488],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18095) ->
	#mon_tpl{
		no = 18095,
		name = <<"95层镇妖塔怪">>,
		type = 1,
		lv = 94,
		bmon_group_no_list = [4489],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18096) ->
	#mon_tpl{
		no = 18096,
		name = <<"96层镇妖塔怪">>,
		type = 1,
		lv = 95,
		bmon_group_no_list = [4490],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18097) ->
	#mon_tpl{
		no = 18097,
		name = <<"97层镇妖塔怪">>,
		type = 1,
		lv = 96,
		bmon_group_no_list = [4491],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18098) ->
	#mon_tpl{
		no = 18098,
		name = <<"98层镇妖塔怪">>,
		type = 1,
		lv = 97,
		bmon_group_no_list = [4492],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18099) ->
	#mon_tpl{
		no = 18099,
		name = <<"99层镇妖塔怪">>,
		type = 1,
		lv = 98,
		bmon_group_no_list = [4493],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18100) ->
	#mon_tpl{
		no = 18100,
		name = <<"100层镇妖塔怪">>,
		type = 1,
		lv = 99,
		bmon_group_no_list = [4494],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18101) ->
	#mon_tpl{
		no = 18101,
		name = <<"101层镇妖塔怪">>,
		type = 1,
		lv = 100,
		bmon_group_no_list = [4701],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18102) ->
	#mon_tpl{
		no = 18102,
		name = <<"102层镇妖塔怪">>,
		type = 1,
		lv = 101,
		bmon_group_no_list = [4702],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18103) ->
	#mon_tpl{
		no = 18103,
		name = <<"103层镇妖塔怪">>,
		type = 1,
		lv = 102,
		bmon_group_no_list = [4703],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18104) ->
	#mon_tpl{
		no = 18104,
		name = <<"104层镇妖塔怪">>,
		type = 1,
		lv = 103,
		bmon_group_no_list = [4704],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18105) ->
	#mon_tpl{
		no = 18105,
		name = <<"105层镇妖塔怪">>,
		type = 1,
		lv = 104,
		bmon_group_no_list = [4705],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18106) ->
	#mon_tpl{
		no = 18106,
		name = <<"106层镇妖塔怪">>,
		type = 1,
		lv = 105,
		bmon_group_no_list = [4706],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18107) ->
	#mon_tpl{
		no = 18107,
		name = <<"107层镇妖塔怪">>,
		type = 1,
		lv = 106,
		bmon_group_no_list = [4707],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18108) ->
	#mon_tpl{
		no = 18108,
		name = <<"108层镇妖塔怪">>,
		type = 1,
		lv = 107,
		bmon_group_no_list = [4708],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18109) ->
	#mon_tpl{
		no = 18109,
		name = <<"109层镇妖塔怪">>,
		type = 1,
		lv = 108,
		bmon_group_no_list = [4709],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18110) ->
	#mon_tpl{
		no = 18110,
		name = <<"110层镇妖塔怪">>,
		type = 1,
		lv = 109,
		bmon_group_no_list = [4710],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18111) ->
	#mon_tpl{
		no = 18111,
		name = <<"111层镇妖塔怪">>,
		type = 1,
		lv = 110,
		bmon_group_no_list = [4711],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18112) ->
	#mon_tpl{
		no = 18112,
		name = <<"112层镇妖塔怪">>,
		type = 1,
		lv = 111,
		bmon_group_no_list = [4712],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18113) ->
	#mon_tpl{
		no = 18113,
		name = <<"113层镇妖塔怪">>,
		type = 1,
		lv = 112,
		bmon_group_no_list = [4713],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18114) ->
	#mon_tpl{
		no = 18114,
		name = <<"114层镇妖塔怪">>,
		type = 1,
		lv = 113,
		bmon_group_no_list = [4714],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18115) ->
	#mon_tpl{
		no = 18115,
		name = <<"115层镇妖塔怪">>,
		type = 1,
		lv = 114,
		bmon_group_no_list = [4715],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18116) ->
	#mon_tpl{
		no = 18116,
		name = <<"116层镇妖塔怪">>,
		type = 1,
		lv = 115,
		bmon_group_no_list = [4716],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18117) ->
	#mon_tpl{
		no = 18117,
		name = <<"117层镇妖塔怪">>,
		type = 1,
		lv = 116,
		bmon_group_no_list = [4717],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18118) ->
	#mon_tpl{
		no = 18118,
		name = <<"118层镇妖塔怪">>,
		type = 1,
		lv = 117,
		bmon_group_no_list = [4718],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18119) ->
	#mon_tpl{
		no = 18119,
		name = <<"119层镇妖塔怪">>,
		type = 1,
		lv = 118,
		bmon_group_no_list = [4719],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18120) ->
	#mon_tpl{
		no = 18120,
		name = <<"120层镇妖塔怪">>,
		type = 1,
		lv = 119,
		bmon_group_no_list = [4720],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18121) ->
	#mon_tpl{
		no = 18121,
		name = <<"121层镇妖塔怪">>,
		type = 1,
		lv = 120,
		bmon_group_no_list = [4721],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18122) ->
	#mon_tpl{
		no = 18122,
		name = <<"122层镇妖塔怪">>,
		type = 1,
		lv = 121,
		bmon_group_no_list = [4722],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18123) ->
	#mon_tpl{
		no = 18123,
		name = <<"123层镇妖塔怪">>,
		type = 1,
		lv = 122,
		bmon_group_no_list = [4723],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18124) ->
	#mon_tpl{
		no = 18124,
		name = <<"124层镇妖塔怪">>,
		type = 1,
		lv = 123,
		bmon_group_no_list = [4724],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18125) ->
	#mon_tpl{
		no = 18125,
		name = <<"125层镇妖塔怪">>,
		type = 1,
		lv = 124,
		bmon_group_no_list = [4725],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18126) ->
	#mon_tpl{
		no = 18126,
		name = <<"126层镇妖塔怪">>,
		type = 1,
		lv = 125,
		bmon_group_no_list = [4726],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18127) ->
	#mon_tpl{
		no = 18127,
		name = <<"127层镇妖塔怪">>,
		type = 1,
		lv = 126,
		bmon_group_no_list = [4727],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18128) ->
	#mon_tpl{
		no = 18128,
		name = <<"128层镇妖塔怪">>,
		type = 1,
		lv = 127,
		bmon_group_no_list = [4728],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18129) ->
	#mon_tpl{
		no = 18129,
		name = <<"129层镇妖塔怪">>,
		type = 1,
		lv = 128,
		bmon_group_no_list = [4729],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18130) ->
	#mon_tpl{
		no = 18130,
		name = <<"130层镇妖塔怪">>,
		type = 1,
		lv = 129,
		bmon_group_no_list = [4730],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18131) ->
	#mon_tpl{
		no = 18131,
		name = <<"131层镇妖塔怪">>,
		type = 1,
		lv = 130,
		bmon_group_no_list = [4731],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18132) ->
	#mon_tpl{
		no = 18132,
		name = <<"132层镇妖塔怪">>,
		type = 1,
		lv = 131,
		bmon_group_no_list = [4732],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18133) ->
	#mon_tpl{
		no = 18133,
		name = <<"133层镇妖塔怪">>,
		type = 1,
		lv = 132,
		bmon_group_no_list = [4733],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18134) ->
	#mon_tpl{
		no = 18134,
		name = <<"134层镇妖塔怪">>,
		type = 1,
		lv = 133,
		bmon_group_no_list = [4734],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18135) ->
	#mon_tpl{
		no = 18135,
		name = <<"135层镇妖塔怪">>,
		type = 1,
		lv = 134,
		bmon_group_no_list = [4735],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18136) ->
	#mon_tpl{
		no = 18136,
		name = <<"136层镇妖塔怪">>,
		type = 1,
		lv = 135,
		bmon_group_no_list = [4736],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18137) ->
	#mon_tpl{
		no = 18137,
		name = <<"137层镇妖塔怪">>,
		type = 1,
		lv = 136,
		bmon_group_no_list = [4737],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18138) ->
	#mon_tpl{
		no = 18138,
		name = <<"138层镇妖塔怪">>,
		type = 1,
		lv = 137,
		bmon_group_no_list = [4738],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18139) ->
	#mon_tpl{
		no = 18139,
		name = <<"139层镇妖塔怪">>,
		type = 1,
		lv = 138,
		bmon_group_no_list = [4739],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18140) ->
	#mon_tpl{
		no = 18140,
		name = <<"140层镇妖塔怪">>,
		type = 1,
		lv = 139,
		bmon_group_no_list = [4740],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18141) ->
	#mon_tpl{
		no = 18141,
		name = <<"141层镇妖塔怪">>,
		type = 1,
		lv = 140,
		bmon_group_no_list = [4741],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18142) ->
	#mon_tpl{
		no = 18142,
		name = <<"142层镇妖塔怪">>,
		type = 1,
		lv = 141,
		bmon_group_no_list = [4742],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18143) ->
	#mon_tpl{
		no = 18143,
		name = <<"143层镇妖塔怪">>,
		type = 1,
		lv = 142,
		bmon_group_no_list = [4743],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18144) ->
	#mon_tpl{
		no = 18144,
		name = <<"144层镇妖塔怪">>,
		type = 1,
		lv = 143,
		bmon_group_no_list = [4744],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18145) ->
	#mon_tpl{
		no = 18145,
		name = <<"145层镇妖塔怪">>,
		type = 1,
		lv = 144,
		bmon_group_no_list = [4745],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18146) ->
	#mon_tpl{
		no = 18146,
		name = <<"146层镇妖塔怪">>,
		type = 1,
		lv = 145,
		bmon_group_no_list = [4746],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18147) ->
	#mon_tpl{
		no = 18147,
		name = <<"147层镇妖塔怪">>,
		type = 1,
		lv = 146,
		bmon_group_no_list = [4747],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18148) ->
	#mon_tpl{
		no = 18148,
		name = <<"148层镇妖塔怪">>,
		type = 1,
		lv = 147,
		bmon_group_no_list = [4748],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18149) ->
	#mon_tpl{
		no = 18149,
		name = <<"149层镇妖塔怪">>,
		type = 1,
		lv = 148,
		bmon_group_no_list = [4749],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18150) ->
	#mon_tpl{
		no = 18150,
		name = <<"150层镇妖塔怪">>,
		type = 1,
		lv = 149,
		bmon_group_no_list = [4750],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18151) ->
	#mon_tpl{
		no = 18151,
		name = <<"151层镇妖塔怪">>,
		type = 3,
		lv = 150,
		bmon_group_no_list = [4751],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18152) ->
	#mon_tpl{
		no = 18152,
		name = <<"152层镇妖塔怪">>,
		type = 3,
		lv = 151,
		bmon_group_no_list = [4752],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18153) ->
	#mon_tpl{
		no = 18153,
		name = <<"153层镇妖塔怪">>,
		type = 3,
		lv = 152,
		bmon_group_no_list = [4753],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18154) ->
	#mon_tpl{
		no = 18154,
		name = <<"154层镇妖塔怪">>,
		type = 3,
		lv = 153,
		bmon_group_no_list = [4754],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18155) ->
	#mon_tpl{
		no = 18155,
		name = <<"155层镇妖塔怪">>,
		type = 3,
		lv = 154,
		bmon_group_no_list = [4755],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18156) ->
	#mon_tpl{
		no = 18156,
		name = <<"156层镇妖塔怪">>,
		type = 3,
		lv = 155,
		bmon_group_no_list = [4756],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18157) ->
	#mon_tpl{
		no = 18157,
		name = <<"157层镇妖塔怪">>,
		type = 3,
		lv = 156,
		bmon_group_no_list = [4757],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18158) ->
	#mon_tpl{
		no = 18158,
		name = <<"158层镇妖塔怪">>,
		type = 3,
		lv = 157,
		bmon_group_no_list = [4758],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18159) ->
	#mon_tpl{
		no = 18159,
		name = <<"159层镇妖塔怪">>,
		type = 3,
		lv = 158,
		bmon_group_no_list = [4759],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18160) ->
	#mon_tpl{
		no = 18160,
		name = <<"160层镇妖塔怪">>,
		type = 3,
		lv = 159,
		bmon_group_no_list = [4760],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18161) ->
	#mon_tpl{
		no = 18161,
		name = <<"161层镇妖塔怪">>,
		type = 3,
		lv = 160,
		bmon_group_no_list = [4761],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18162) ->
	#mon_tpl{
		no = 18162,
		name = <<"162层镇妖塔怪">>,
		type = 3,
		lv = 161,
		bmon_group_no_list = [4762],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18163) ->
	#mon_tpl{
		no = 18163,
		name = <<"163层镇妖塔怪">>,
		type = 3,
		lv = 162,
		bmon_group_no_list = [4763],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18164) ->
	#mon_tpl{
		no = 18164,
		name = <<"164层镇妖塔怪">>,
		type = 3,
		lv = 163,
		bmon_group_no_list = [4764],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18165) ->
	#mon_tpl{
		no = 18165,
		name = <<"165层镇妖塔怪">>,
		type = 3,
		lv = 164,
		bmon_group_no_list = [4765],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18166) ->
	#mon_tpl{
		no = 18166,
		name = <<"166层镇妖塔怪">>,
		type = 3,
		lv = 165,
		bmon_group_no_list = [4766],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18167) ->
	#mon_tpl{
		no = 18167,
		name = <<"167层镇妖塔怪">>,
		type = 3,
		lv = 166,
		bmon_group_no_list = [4767],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18168) ->
	#mon_tpl{
		no = 18168,
		name = <<"168层镇妖塔怪">>,
		type = 3,
		lv = 167,
		bmon_group_no_list = [4768],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18169) ->
	#mon_tpl{
		no = 18169,
		name = <<"169层镇妖塔怪">>,
		type = 3,
		lv = 168,
		bmon_group_no_list = [4769],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18170) ->
	#mon_tpl{
		no = 18170,
		name = <<"170层镇妖塔怪">>,
		type = 3,
		lv = 169,
		bmon_group_no_list = [4770],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18171) ->
	#mon_tpl{
		no = 18171,
		name = <<"171层镇妖塔怪">>,
		type = 3,
		lv = 170,
		bmon_group_no_list = [4771],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18172) ->
	#mon_tpl{
		no = 18172,
		name = <<"172层镇妖塔怪">>,
		type = 3,
		lv = 171,
		bmon_group_no_list = [4772],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18173) ->
	#mon_tpl{
		no = 18173,
		name = <<"173层镇妖塔怪">>,
		type = 3,
		lv = 172,
		bmon_group_no_list = [4773],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18174) ->
	#mon_tpl{
		no = 18174,
		name = <<"174层镇妖塔怪">>,
		type = 3,
		lv = 173,
		bmon_group_no_list = [4774],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18175) ->
	#mon_tpl{
		no = 18175,
		name = <<"175层镇妖塔怪">>,
		type = 3,
		lv = 174,
		bmon_group_no_list = [4775],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18176) ->
	#mon_tpl{
		no = 18176,
		name = <<"176层镇妖塔怪">>,
		type = 3,
		lv = 175,
		bmon_group_no_list = [4776],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18177) ->
	#mon_tpl{
		no = 18177,
		name = <<"177层镇妖塔怪">>,
		type = 3,
		lv = 176,
		bmon_group_no_list = [4777],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18178) ->
	#mon_tpl{
		no = 18178,
		name = <<"178层镇妖塔怪">>,
		type = 3,
		lv = 177,
		bmon_group_no_list = [4778],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18179) ->
	#mon_tpl{
		no = 18179,
		name = <<"179层镇妖塔怪">>,
		type = 3,
		lv = 178,
		bmon_group_no_list = [4779],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18180) ->
	#mon_tpl{
		no = 18180,
		name = <<"180层镇妖塔怪">>,
		type = 3,
		lv = 179,
		bmon_group_no_list = [4780],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18181) ->
	#mon_tpl{
		no = 18181,
		name = <<"181层镇妖塔怪">>,
		type = 3,
		lv = 180,
		bmon_group_no_list = [4781],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18182) ->
	#mon_tpl{
		no = 18182,
		name = <<"182层镇妖塔怪">>,
		type = 3,
		lv = 181,
		bmon_group_no_list = [4782],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18183) ->
	#mon_tpl{
		no = 18183,
		name = <<"183层镇妖塔怪">>,
		type = 3,
		lv = 182,
		bmon_group_no_list = [4783],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18184) ->
	#mon_tpl{
		no = 18184,
		name = <<"184层镇妖塔怪">>,
		type = 3,
		lv = 183,
		bmon_group_no_list = [4784],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18185) ->
	#mon_tpl{
		no = 18185,
		name = <<"185层镇妖塔怪">>,
		type = 3,
		lv = 184,
		bmon_group_no_list = [4785],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18186) ->
	#mon_tpl{
		no = 18186,
		name = <<"186层镇妖塔怪">>,
		type = 3,
		lv = 185,
		bmon_group_no_list = [4786],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18187) ->
	#mon_tpl{
		no = 18187,
		name = <<"187层镇妖塔怪">>,
		type = 3,
		lv = 186,
		bmon_group_no_list = [4787],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18188) ->
	#mon_tpl{
		no = 18188,
		name = <<"188层镇妖塔怪">>,
		type = 3,
		lv = 187,
		bmon_group_no_list = [4788],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18189) ->
	#mon_tpl{
		no = 18189,
		name = <<"189层镇妖塔怪">>,
		type = 3,
		lv = 188,
		bmon_group_no_list = [4789],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18190) ->
	#mon_tpl{
		no = 18190,
		name = <<"190层镇妖塔怪">>,
		type = 3,
		lv = 189,
		bmon_group_no_list = [4790],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18191) ->
	#mon_tpl{
		no = 18191,
		name = <<"191层镇妖塔怪">>,
		type = 3,
		lv = 190,
		bmon_group_no_list = [4791],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18192) ->
	#mon_tpl{
		no = 18192,
		name = <<"192层镇妖塔怪">>,
		type = 3,
		lv = 191,
		bmon_group_no_list = [4792],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18193) ->
	#mon_tpl{
		no = 18193,
		name = <<"193层镇妖塔怪">>,
		type = 3,
		lv = 192,
		bmon_group_no_list = [4793],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18194) ->
	#mon_tpl{
		no = 18194,
		name = <<"194层镇妖塔怪">>,
		type = 3,
		lv = 193,
		bmon_group_no_list = [4794],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18195) ->
	#mon_tpl{
		no = 18195,
		name = <<"195层镇妖塔怪">>,
		type = 3,
		lv = 194,
		bmon_group_no_list = [4795],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18196) ->
	#mon_tpl{
		no = 18196,
		name = <<"196层镇妖塔怪">>,
		type = 3,
		lv = 195,
		bmon_group_no_list = [4796],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18197) ->
	#mon_tpl{
		no = 18197,
		name = <<"197层镇妖塔怪">>,
		type = 3,
		lv = 196,
		bmon_group_no_list = [4797],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18198) ->
	#mon_tpl{
		no = 18198,
		name = <<"198层镇妖塔怪">>,
		type = 3,
		lv = 197,
		bmon_group_no_list = [4798],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18199) ->
	#mon_tpl{
		no = 18199,
		name = <<"199层镇妖塔怪">>,
		type = 3,
		lv = 198,
		bmon_group_no_list = [4799],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18200) ->
	#mon_tpl{
		no = 18200,
		name = <<"200层镇妖塔怪">>,
		type = 3,
		lv = 199,
		bmon_group_no_list = [4800],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18501) ->
	#mon_tpl{
		no = 18501,
		name = <<"饿死鬼">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8501,8502,8503,8504,8505,8506,8507,8508,8509,8510],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18502) ->
	#mon_tpl{
		no = 18502,
		name = <<"吊死鬼">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8511,8512,8513,8514,8515,8516,8517,8518,8519,8520],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18503) ->
	#mon_tpl{
		no = 18503,
		name = <<"落尸鬼">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8521,8522,8523,8524,8525,8526,8527,8528,8529,8530],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18504) ->
	#mon_tpl{
		no = 18504,
		name = <<"落水鬼">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8531,8532,8533,8534,8535,8536,8537,8538,8539,8540],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18505) ->
	#mon_tpl{
		no = 18505,
		name = <<"还情鬼">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8541,8542,8543,8544,8545,8546,8547,8548,8549,8550],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18506) ->
	#mon_tpl{
		no = 18506,
		name = <<"还魂鬼">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8551,8552,8553,8554,8555,8556,8557,8558,8559,8560],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18507) ->
	#mon_tpl{
		no = 18507,
		name = <<"影子鬼">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8561,8562,8563,8564,8565,8566,8567,8568,8569,8570],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18508) ->
	#mon_tpl{
		no = 18508,
		name = <<"怨气鬼">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8571,8572,8573,8574,8575,8576,8577,8578,8579,8580],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18509) ->
	#mon_tpl{
		no = 18509,
		name = <<"勾魂鬼">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8581,8582,8583,8584,8585,8586,8587,8588,8589,8590],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(18510) ->
	#mon_tpl{
		no = 18510,
		name = <<"回音鬼">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8591,8592,8593,8594,8595,8596,8597,8598,8599,8600],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(19001) ->
	#mon_tpl{
		no = 19001,
		name = <<"闲逛门客">>,
		type = 1,
		lv = 10,
		bmon_group_no_list = [11501],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19002) ->
	#mon_tpl{
		no = 19002,
		name = <<"闲逛门客">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [11502],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19003) ->
	#mon_tpl{
		no = 19003,
		name = <<"闲逛门客">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [11503],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19004) ->
	#mon_tpl{
		no = 19004,
		name = <<"闲逛门客">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [11504],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19005) ->
	#mon_tpl{
		no = 19005,
		name = <<"闲逛门客">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [11505],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19006) ->
	#mon_tpl{
		no = 19006,
		name = <<"闲逛门客">>,
		type = 1,
		lv = 60,
		bmon_group_no_list = [11506],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19007) ->
	#mon_tpl{
		no = 19007,
		name = <<"闲逛门客">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [11507],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19008) ->
	#mon_tpl{
		no = 19008,
		name = <<"闲逛门客">>,
		type = 1,
		lv = 80,
		bmon_group_no_list = [11508],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19101) ->
	#mon_tpl{
		no = 19101,
		name = <<"未知">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [12001],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19102) ->
	#mon_tpl{
		no = 19102,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [12002],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19103) ->
	#mon_tpl{
		no = 19103,
		name = <<"未知">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [12003],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19104) ->
	#mon_tpl{
		no = 19104,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [12004],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19105) ->
	#mon_tpl{
		no = 19105,
		name = <<"未知">>,
		type = 1,
		lv = 60,
		bmon_group_no_list = [12005],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19106) ->
	#mon_tpl{
		no = 19106,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [12006],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(19107) ->
	#mon_tpl{
		no = 19107,
		name = <<"未知">>,
		type = 1,
		lv = 80,
		bmon_group_no_list = [12007],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(20001) ->
	#mon_tpl{
		no = 20001,
		name = <<"鲁光光">>,
		type = 2,
		lv = 20,
		bmon_group_no_list = [10101],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(20002) ->
	#mon_tpl{
		no = 20002,
		name = <<"未知">>,
		type = 1,
		lv = 35,
		bmon_group_no_list = [10102],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(20003) ->
	#mon_tpl{
		no = 20003,
		name = <<"未知">>,
		type = 1,
		lv = 35,
		bmon_group_no_list = [10103],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(20004) ->
	#mon_tpl{
		no = 20004,
		name = <<"未知">>,
		type = 1,
		lv = 35,
		bmon_group_no_list = [10104],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(20005) ->
	#mon_tpl{
		no = 20005,
		name = <<"未知">>,
		type = 1,
		lv = 35,
		bmon_group_no_list = [10105],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(20006) ->
	#mon_tpl{
		no = 20006,
		name = <<"未知">>,
		type = 1,
		lv = 35,
		bmon_group_no_list = [10106],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(20007) ->
	#mon_tpl{
		no = 20007,
		name = <<"未知">>,
		type = 1,
		lv = 35,
		bmon_group_no_list = [10107],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(20008) ->
	#mon_tpl{
		no = 20008,
		name = <<"未知">>,
		type = 1,
		lv = 35,
		bmon_group_no_list = [10108],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(20009) ->
	#mon_tpl{
		no = 20009,
		name = <<"未知">>,
		type = 1,
		lv = 35,
		bmon_group_no_list = [10109],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(20010) ->
	#mon_tpl{
		no = 20010,
		name = <<"未知">>,
		type = 1,
		lv = 35,
		bmon_group_no_list = [10110],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(21000) ->
	#mon_tpl{
		no = 21000,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [8200],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 120,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(21001) ->
	#mon_tpl{
		no = 21001,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [8201],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 120,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(21002) ->
	#mon_tpl{
		no = 21002,
		name = <<"未知">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [8202],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 120,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(21100) ->
	#mon_tpl{
		no = 21100,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8203],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 120,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(21101) ->
	#mon_tpl{
		no = 21101,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8204],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 120,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(21102) ->
	#mon_tpl{
		no = 21102,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8205],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 120,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(21200) ->
	#mon_tpl{
		no = 21200,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [8206],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 120,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(21201) ->
	#mon_tpl{
		no = 21201,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [8207],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 120,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(21202) ->
	#mon_tpl{
		no = 21202,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [8208],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 120,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(22000) ->
	#mon_tpl{
		no = 22000,
		name = <<"幻世魔王">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [800001],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team,{least_non_tmp_leave_mb_count,2}}]
};

get(22100) ->
	#mon_tpl{
		no = 22100,
		name = <<"幻世魔王">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [800101],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team,{least_non_tmp_leave_mb_count,2}}]
};

get(23000) ->
	#mon_tpl{
		no = 23000,
		name = <<"未知">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [8301],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(23100) ->
	#mon_tpl{
		no = 23100,
		name = <<"未知">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [8302],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(23200) ->
	#mon_tpl{
		no = 23200,
		name = <<"未知">>,
		type = 1,
		lv = 60,
		bmon_group_no_list = [8303],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(23300) ->
	#mon_tpl{
		no = 23300,
		name = <<"未知">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [8304],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(23400) ->
	#mon_tpl{
		no = 23400,
		name = <<"未知">>,
		type = 1,
		lv = 80,
		bmon_group_no_list = [8305],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(23501) ->
	#mon_tpl{
		no = 23501,
		name = <<"未知">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [10111, 10112, 10113, 10114, 10115, 10116],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{not_in_team,{lv_between,30,89}}]
};

get(23601) ->
	#mon_tpl{
		no = 23601,
		name = <<"未知">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [13030, 13031, 13032, 13033, 13034, 13035, 13036, 13037, 13038, 13039],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{not_in_team,{lv_between,30,89}}]
};

get(23602) ->
	#mon_tpl{
		no = 23602,
		name = <<"未知">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [13040, 13041, 13042, 13043, 13044, 13045, 13046, 13047, 13048, 13049],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{not_in_team,{lv_between,40,89}}]
};

get(23603) ->
	#mon_tpl{
		no = 23603,
		name = <<"未知">>,
		type = 4,
		lv = 50,
		bmon_group_no_list = [13050, 13051, 13052, 13053, 13054, 13055, 13056, 13057, 13058, 13059],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{not_in_team,{lv_between,50,89}}]
};

get(23604) ->
	#mon_tpl{
		no = 23604,
		name = <<"未知">>,
		type = 4,
		lv = 60,
		bmon_group_no_list = [13060, 13061, 13062, 13063, 13064, 13065, 13066, 13067, 13068, 13069],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{not_in_team,{lv_between,60,89}}]
};

get(23605) ->
	#mon_tpl{
		no = 23605,
		name = <<"未知">>,
		type = 4,
		lv = 70,
		bmon_group_no_list = [13070, 13071, 13072, 13073, 13074, 13075, 13076, 13077, 13078, 13079],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{not_in_team,{lv_between,70,89}}]
};

get(23606) ->
	#mon_tpl{
		no = 23606,
		name = <<"未知">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [13080, 13081, 13082, 13083, 13084, 13085, 13086, 13087, 13088, 13089],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{not_in_team,{lv_between,80,89}}]
};

get(23607) ->
	#mon_tpl{
		no = 23607,
		name = <<"未知">>,
		type = 4,
		lv = 60,
		bmon_group_no_list = [200008, 200009, 200010],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(23608) ->
	#mon_tpl{
		no = 23608,
		name = <<"未知">>,
		type = 4,
		lv = 60,
		bmon_group_no_list = [200005, 200006, 200007],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(23609) ->
	#mon_tpl{
		no = 23609,
		name = <<"未知">>,
		type = 4,
		lv = 60,
		bmon_group_no_list = [200002, 200003, 200004],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 1,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(40001) ->
	#mon_tpl{
		no = 40001,
		name = <<"杀身鬼">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [300001],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060001}, {least_count,2}}]
};

get(40002) ->
	#mon_tpl{
		no = 40002,
		name = <<"针口鬼">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [300002],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060002}, {least_count,2}}]
};

get(40003) ->
	#mon_tpl{
		no = 40003,
		name = <<"炽燃鬼">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [300003],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060003}, {least_count,2}}]
};

get(40004) ->
	#mon_tpl{
		no = 40004,
		name = <<"食肉鬼">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [300004],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060004}, {least_count,2}}]
};

get(40005) ->
	#mon_tpl{
		no = 40005,
		name = <<"食法鬼">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [300005],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060005}, {least_count,2}}]
};

get(40006) ->
	#mon_tpl{
		no = 40006,
		name = <<"食气鬼">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [300006],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060006}, {least_count,2}}]
};

get(40007) ->
	#mon_tpl{
		no = 40007,
		name = <<"疾行鬼">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [300007],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060007}, {least_count,2}}]
};

get(40008) ->
	#mon_tpl{
		no = 40008,
		name = <<"恶鬼罗刹">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [300008],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060008}, {least_count,2}}]
};

get(40011) ->
	#mon_tpl{
		no = 40011,
		name = <<"杀身鬼王">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [300011],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060010}, {least_count,2}}]
};

get(40012) ->
	#mon_tpl{
		no = 40012,
		name = <<"针口鬼王">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [300012],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060011}, {least_count,2}}]
};

get(40013) ->
	#mon_tpl{
		no = 40013,
		name = <<"炽燃鬼王">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [300013],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060012}, {least_count,2}}]
};

get(40014) ->
	#mon_tpl{
		no = 40014,
		name = <<"食肉鬼王">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [300014],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060013}, {least_count,2}}
]
};

get(40015) ->
	#mon_tpl{
		no = 40015,
		name = <<"食法鬼王">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [300015],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060014}, {least_count,2}}]
};

get(40016) ->
	#mon_tpl{
		no = 40016,
		name = <<"食气鬼王">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [300016],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060015}, {least_count,2}}]
};

get(40017) ->
	#mon_tpl{
		no = 40017,
		name = <<"疾行鬼王">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [300017],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060016}, {least_count,2}}]
};

get(40018) ->
	#mon_tpl{
		no = 40018,
		name = <<"恶鬼罗刹王">>,
		type = 3,
		lv = 80,
		bmon_group_no_list = [300018],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060017}, {least_count,2}}]
};

get(40021) ->
	#mon_tpl{
		no = 40021,
		name = <<"杀身鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300001],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060019}, {least_count,2}}]
};

get(40022) ->
	#mon_tpl{
		no = 40022,
		name = <<"针口鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300002],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [
{in_team, {has_unfinished_task, 1060020}, {least_count,2}}]
};

get(40023) ->
	#mon_tpl{
		no = 40023,
		name = <<"炽燃鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300003],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060021}, {least_count,2}}]
};

get(40024) ->
	#mon_tpl{
		no = 40024,
		name = <<"食肉鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300004],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060022}, {least_count,2}}]
};

get(40025) ->
	#mon_tpl{
		no = 40025,
		name = <<"食法鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300005],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060023}, {least_count,2}}]
};

get(40026) ->
	#mon_tpl{
		no = 40026,
		name = <<"食气鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300006],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060024}, {least_count,2}}]
};

get(40027) ->
	#mon_tpl{
		no = 40027,
		name = <<"疾行鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300007],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [
{in_team, {has_unfinished_task, 1060025}, {least_count,2}}]
};

get(40028) ->
	#mon_tpl{
		no = 40028,
		name = <<"恶鬼罗刹">>,
		type = 3,
		lv = 30,
		bmon_group_no_list = [300008],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060026}, {least_count,2}}]
};

get(40031) ->
	#mon_tpl{
		no = 40031,
		name = <<"杀身鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300001],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060028}, {least_count,2}}]
};

get(40032) ->
	#mon_tpl{
		no = 40032,
		name = <<"针口鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300002],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060029}, {least_count,2}}]
};

get(40033) ->
	#mon_tpl{
		no = 40033,
		name = <<"炽燃鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300003],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060030}, {least_count,2}}]
};

get(40034) ->
	#mon_tpl{
		no = 40034,
		name = <<"食肉鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300004],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060031}, {least_count,2}}]
};

get(40035) ->
	#mon_tpl{
		no = 40035,
		name = <<"食法鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300005],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060032}, {least_count,2}}]
};

get(40036) ->
	#mon_tpl{
		no = 40036,
		name = <<"食气鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300006],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060033}, {least_count,2}}]
};

get(40037) ->
	#mon_tpl{
		no = 40037,
		name = <<"疾行鬼">>,
		type = 1,
		lv = 26,
		bmon_group_no_list = [300007],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060034}, {least_count,2}}]
};

get(40038) ->
	#mon_tpl{
		no = 40038,
		name = <<"恶鬼罗刹">>,
		type = 3,
		lv = 30,
		bmon_group_no_list = [300008],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060035}, {least_count,2}}]
};

get(19000) ->
	#mon_tpl{
		no = 19000,
		name = <<"宝图强盗">>,
		type = 1,
		lv = 25,
		bmon_group_no_list = [11601],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23621) ->
	#mon_tpl{
		no = 23621,
		name = <<"10级闲逛门客">>,
		type = 1,
		lv = 10,
		bmon_group_no_list = [505001 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23622) ->
	#mon_tpl{
		no = 23622,
		name = <<"20级闲逛门客">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [505002 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23623) ->
	#mon_tpl{
		no = 23623,
		name = <<"30级闲逛门客">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [505003 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23624) ->
	#mon_tpl{
		no = 23624,
		name = <<"40级闲逛门客">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [505004 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23625) ->
	#mon_tpl{
		no = 23625,
		name = <<"50级闲逛门客">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [505005 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23626) ->
	#mon_tpl{
		no = 23626,
		name = <<"60级闲逛门客">>,
		type = 1,
		lv = 60,
		bmon_group_no_list = [505006 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23627) ->
	#mon_tpl{
		no = 23627,
		name = <<"70级闲逛门客">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [505007 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23628) ->
	#mon_tpl{
		no = 23628,
		name = <<"80级闲逛门客">>,
		type = 1,
		lv = 80,
		bmon_group_no_list = [505008 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23629) ->
	#mon_tpl{
		no = 23629,
		name = <<"20级妖王">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [505009 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23630) ->
	#mon_tpl{
		no = 23630,
		name = <<"30级妖王">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [505010 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23631) ->
	#mon_tpl{
		no = 23631,
		name = <<"40级妖王">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [505011 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23632) ->
	#mon_tpl{
		no = 23632,
		name = <<"50级妖王">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [505012 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23633) ->
	#mon_tpl{
		no = 23633,
		name = <<"60级妖王">>,
		type = 1,
		lv = 60,
		bmon_group_no_list = [505013 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23634) ->
	#mon_tpl{
		no = 23634,
		name = <<"70级妖王">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [505014 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23635) ->
	#mon_tpl{
		no = 23635,
		name = <<"80级妖王">>,
		type = 1,
		lv = 80,
		bmon_group_no_list = [505015],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}]
};

get(23636) ->
	#mon_tpl{
		no = 23636,
		name = <<"10级赋闲门客">>,
		type = 1,
		lv = 10,
		bmon_group_no_list = [505016 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23637) ->
	#mon_tpl{
		no = 23637,
		name = <<"20级赋闲门客">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [505017 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23638) ->
	#mon_tpl{
		no = 23638,
		name = <<"30级赋闲门客">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [505018 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23639) ->
	#mon_tpl{
		no = 23639,
		name = <<"40级赋闲门客">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [505019 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23640) ->
	#mon_tpl{
		no = 23640,
		name = <<"50级赋闲门客">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [505020 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23641) ->
	#mon_tpl{
		no = 23641,
		name = <<"60级赋闲门客">>,
		type = 1,
		lv = 60,
		bmon_group_no_list = [505021 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23642) ->
	#mon_tpl{
		no = 23642,
		name = <<"70级赋闲门客">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [505022 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23643) ->
	#mon_tpl{
		no = 23643,
		name = <<"80级赋闲门客">>,
		type = 1,
		lv = 80,
		bmon_group_no_list = [505023 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23644) ->
	#mon_tpl{
		no = 23644,
		name = <<"20级小妖">>,
		type = 1,
		lv = 20,
		bmon_group_no_list = [505024 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23645) ->
	#mon_tpl{
		no = 23645,
		name = <<"30级小妖">>,
		type = 1,
		lv = 30,
		bmon_group_no_list = [505025 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23646) ->
	#mon_tpl{
		no = 23646,
		name = <<"40级小妖">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [505026 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23647) ->
	#mon_tpl{
		no = 23647,
		name = <<"50级小妖">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [505027 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23648) ->
	#mon_tpl{
		no = 23648,
		name = <<"60级小妖">>,
		type = 1,
		lv = 60,
		bmon_group_no_list = [505028 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23649) ->
	#mon_tpl{
		no = 23649,
		name = <<"70级小妖">>,
		type = 1,
		lv = 70,
		bmon_group_no_list = [505029 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23650) ->
	#mon_tpl{
		no = 23650,
		name = <<"80级小妖">>,
		type = 1,
		lv = 80,
		bmon_group_no_list = [505030],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,25,309}}]
};

get(23651) ->
	#mon_tpl{
		no = 23651,
		name = <<"墨家赋闲弟子">>,
		type = 1,
		lv = 180,
		bmon_group_no_list = [505031],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,180,300}}]
};

get(23652) ->
	#mon_tpl{
		no = 23652,
		name = <<"兵家赋闲弟子">>,
		type = 1,
		lv = 180,
		bmon_group_no_list = [505032],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,180,300}}]
};

get(23653) ->
	#mon_tpl{
		no = 23653,
		name = <<"道家赋闲弟子">>,
		type = 1,
		lv = 180,
		bmon_group_no_list = [505033],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,180,300}}]
};

get(23654) ->
	#mon_tpl{
		no = 23654,
		name = <<"儒家赋闲弟子">>,
		type = 1,
		lv = 180,
		bmon_group_no_list = [505034],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,180,300}}]
};

get(23655) ->
	#mon_tpl{
		no = 23655,
		name = <<"阴阳赋闲弟子">>,
		type = 1,
		lv = 180,
		bmon_group_no_list = [505038 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,180,300}}]
};

get(23656) ->
	#mon_tpl{
		no = 23656,
		name = <<"法家赋闲弟子">>,
		type = 1,
		lv = 180,
		bmon_group_no_list = [505039 ],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,180,300}}]
};

get(34001) ->
	#mon_tpl{
		no = 34001,
		name = <<"七星之魂">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504100],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34002) ->
	#mon_tpl{
		no = 34002,
		name = <<"极七星之魂">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504101],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34003) ->
	#mon_tpl{
		no = 34003,
		name = <<"狂怒七星之魂">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504102],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34011) ->
	#mon_tpl{
		no = 34011,
		name = <<"龙渊之魂">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504103],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34012) ->
	#mon_tpl{
		no = 34012,
		name = <<"极龙渊之魂">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504104],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34013) ->
	#mon_tpl{
		no = 34013,
		name = <<"狂怒龙渊之魂">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504105],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34014) ->
	#mon_tpl{
		no = 34014,
		name = <<"悦来酒客">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504106],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34015) ->
	#mon_tpl{
		no = 34015,
		name = <<"悦来剑侠">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504107],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34016) ->
	#mon_tpl{
		no = 34016,
		name = <<"悦来斗神">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504108],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34017) ->
	#mon_tpl{
		no = 34017,
		name = <<"龙门酒客">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504109],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34018) ->
	#mon_tpl{
		no = 34018,
		name = <<"龙门剑侠">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504110],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34019) ->
	#mon_tpl{
		no = 34019,
		name = <<"龙门斗神">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504111],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(13200) ->
	#mon_tpl{
		no = 13200,
		name = <<"逆天魔龙">>,
		type = 7,
		lv = 50,
		bmon_group_no_list = [1101],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 1,
		can_be_killed_times = 0,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{not_in_team,{lv_between,30,309}}]
};

get(13201) ->
	#mon_tpl{
		no = 13201,
		name = <<"异界统领">>,
		type = 7,
		lv = 100,
		bmon_group_no_list = [3101],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 1,
		can_be_killed_times = 0,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{not_in_team,{lv_between,30,309}}]
};

get(34020) ->
	#mon_tpl{
		no = 34020,
		name = <<"鱼肠之魂">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [505035],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34021) ->
	#mon_tpl{
		no = 34021,
		name = <<"极鱼肠之魂">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [505036],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34022) ->
	#mon_tpl{
		no = 34022,
		name = <<"狂怒鱼肠之魂">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [505037],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34023) ->
	#mon_tpl{
		no = 34023,
		name = <<"琅琊酒客">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504112],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34024) ->
	#mon_tpl{
		no = 34024,
		name = <<"琅琊剑侠">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504113],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34025) ->
	#mon_tpl{
		no = 34025,
		name = <<"琅琊斗神">>,
		type = 4,
		lv = 30,
		bmon_group_no_list = [504114],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35001) ->
	#mon_tpl{
		no = 35001,
		name = <<"帮派副本第1层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350001],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35002) ->
	#mon_tpl{
		no = 35002,
		name = <<"帮派副本第2层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350002],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35003) ->
	#mon_tpl{
		no = 35003,
		name = <<"帮派副本第3层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350003],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35004) ->
	#mon_tpl{
		no = 35004,
		name = <<"帮派副本第4层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350004],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35005) ->
	#mon_tpl{
		no = 35005,
		name = <<"帮派副本第5层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350005],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35006) ->
	#mon_tpl{
		no = 35006,
		name = <<"帮派副本第6层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350006],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35007) ->
	#mon_tpl{
		no = 35007,
		name = <<"帮派副本第7层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350007],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35008) ->
	#mon_tpl{
		no = 35008,
		name = <<"帮派副本第8层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350008],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35009) ->
	#mon_tpl{
		no = 35009,
		name = <<"帮派副本第9层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350009],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35010) ->
	#mon_tpl{
		no = 35010,
		name = <<"帮派副本第10层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350010],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35011) ->
	#mon_tpl{
		no = 35011,
		name = <<"帮派副本第11层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350011],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35012) ->
	#mon_tpl{
		no = 35012,
		name = <<"帮派副本第12层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350012],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35013) ->
	#mon_tpl{
		no = 35013,
		name = <<"帮派副本第13层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350013],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35014) ->
	#mon_tpl{
		no = 35014,
		name = <<"帮派副本第14层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350014],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35015) ->
	#mon_tpl{
		no = 35015,
		name = <<"帮派副本第15层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350015],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35016) ->
	#mon_tpl{
		no = 35016,
		name = <<"帮派副本第16层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350016],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35017) ->
	#mon_tpl{
		no = 35017,
		name = <<"帮派副本第17层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350017],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35018) ->
	#mon_tpl{
		no = 35018,
		name = <<"帮派副本第18层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350018],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35019) ->
	#mon_tpl{
		no = 35019,
		name = <<"帮派副本第19层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350019],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35020) ->
	#mon_tpl{
		no = 35020,
		name = <<"帮派副本第20层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350020],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35021) ->
	#mon_tpl{
		no = 35021,
		name = <<"帮派副本第21层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350021],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35022) ->
	#mon_tpl{
		no = 35022,
		name = <<"帮派副本第22层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350022],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35023) ->
	#mon_tpl{
		no = 35023,
		name = <<"帮派副本第23层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350023],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35024) ->
	#mon_tpl{
		no = 35024,
		name = <<"帮派副本第24层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350024],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35025) ->
	#mon_tpl{
		no = 35025,
		name = <<"帮派副本第25层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350025],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35026) ->
	#mon_tpl{
		no = 35026,
		name = <<"帮派副本第26层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350026],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35027) ->
	#mon_tpl{
		no = 35027,
		name = <<"帮派副本第27层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350027],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35028) ->
	#mon_tpl{
		no = 35028,
		name = <<"帮派副本第28层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350028],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35029) ->
	#mon_tpl{
		no = 35029,
		name = <<"帮派副本第29层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350029],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35030) ->
	#mon_tpl{
		no = 35030,
		name = <<"帮派副本第30层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350030],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35031) ->
	#mon_tpl{
		no = 35031,
		name = <<"帮派副本第31层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350031],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35032) ->
	#mon_tpl{
		no = 35032,
		name = <<"帮派副本第32层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350032],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35033) ->
	#mon_tpl{
		no = 35033,
		name = <<"帮派副本第33层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350033],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35034) ->
	#mon_tpl{
		no = 35034,
		name = <<"帮派副本第34层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350034],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35035) ->
	#mon_tpl{
		no = 35035,
		name = <<"帮派副本第35层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350035],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35036) ->
	#mon_tpl{
		no = 35036,
		name = <<"帮派副本第36层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350036],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35037) ->
	#mon_tpl{
		no = 35037,
		name = <<"帮派副本第37层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350037],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35038) ->
	#mon_tpl{
		no = 35038,
		name = <<"帮派副本第38层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350038],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35039) ->
	#mon_tpl{
		no = 35039,
		name = <<"帮派副本第39层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350039],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35040) ->
	#mon_tpl{
		no = 35040,
		name = <<"帮派副本第40层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350040],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35041) ->
	#mon_tpl{
		no = 35041,
		name = <<"帮派副本第41层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350041],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35042) ->
	#mon_tpl{
		no = 35042,
		name = <<"帮派副本第42层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350042],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35043) ->
	#mon_tpl{
		no = 35043,
		name = <<"帮派副本第43层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350043],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35044) ->
	#mon_tpl{
		no = 35044,
		name = <<"帮派副本第44层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350044],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35045) ->
	#mon_tpl{
		no = 35045,
		name = <<"帮派副本第45层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350045],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35046) ->
	#mon_tpl{
		no = 35046,
		name = <<"帮派副本第46层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350046],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35047) ->
	#mon_tpl{
		no = 35047,
		name = <<"帮派副本第47层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350047],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35048) ->
	#mon_tpl{
		no = 35048,
		name = <<"帮派副本第48层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350048],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35049) ->
	#mon_tpl{
		no = 35049,
		name = <<"帮派副本第49层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350049],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35050) ->
	#mon_tpl{
		no = 35050,
		name = <<"帮派副本第50层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350050],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35051) ->
	#mon_tpl{
		no = 35051,
		name = <<"帮派副本第51层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350051],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35052) ->
	#mon_tpl{
		no = 35052,
		name = <<"帮派副本第52层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350052],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35053) ->
	#mon_tpl{
		no = 35053,
		name = <<"帮派副本第53层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350053],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35054) ->
	#mon_tpl{
		no = 35054,
		name = <<"帮派副本第54层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350054],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35055) ->
	#mon_tpl{
		no = 35055,
		name = <<"帮派副本第55层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350055],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35056) ->
	#mon_tpl{
		no = 35056,
		name = <<"帮派副本第56层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350056],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35057) ->
	#mon_tpl{
		no = 35057,
		name = <<"帮派副本第57层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350057],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35058) ->
	#mon_tpl{
		no = 35058,
		name = <<"帮派副本第58层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350058],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35059) ->
	#mon_tpl{
		no = 35059,
		name = <<"帮派副本第59层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350059],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35060) ->
	#mon_tpl{
		no = 35060,
		name = <<"帮派副本第60层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350060],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35061) ->
	#mon_tpl{
		no = 35061,
		name = <<"帮派副本第61层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350061],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35062) ->
	#mon_tpl{
		no = 35062,
		name = <<"帮派副本第62层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350062],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35063) ->
	#mon_tpl{
		no = 35063,
		name = <<"帮派副本第63层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350063],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35064) ->
	#mon_tpl{
		no = 35064,
		name = <<"帮派副本第64层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350064],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35065) ->
	#mon_tpl{
		no = 35065,
		name = <<"帮派副本第65层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350065],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35066) ->
	#mon_tpl{
		no = 35066,
		name = <<"帮派副本第66层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350066],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35067) ->
	#mon_tpl{
		no = 35067,
		name = <<"帮派副本第67层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350067],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35068) ->
	#mon_tpl{
		no = 35068,
		name = <<"帮派副本第68层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350068],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35069) ->
	#mon_tpl{
		no = 35069,
		name = <<"帮派副本第69层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350069],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35070) ->
	#mon_tpl{
		no = 35070,
		name = <<"帮派副本第70层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350070],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35071) ->
	#mon_tpl{
		no = 35071,
		name = <<"帮派副本第71层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350071],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35072) ->
	#mon_tpl{
		no = 35072,
		name = <<"帮派副本第72层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350072],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35073) ->
	#mon_tpl{
		no = 35073,
		name = <<"帮派副本第73层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350073],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35074) ->
	#mon_tpl{
		no = 35074,
		name = <<"帮派副本第74层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350074],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35075) ->
	#mon_tpl{
		no = 35075,
		name = <<"帮派副本第75层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350075],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35076) ->
	#mon_tpl{
		no = 35076,
		name = <<"帮派副本第76层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350076],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35077) ->
	#mon_tpl{
		no = 35077,
		name = <<"帮派副本第77层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350077],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35078) ->
	#mon_tpl{
		no = 35078,
		name = <<"帮派副本第78层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350078],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35079) ->
	#mon_tpl{
		no = 35079,
		name = <<"帮派副本第79层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350079],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35080) ->
	#mon_tpl{
		no = 35080,
		name = <<"帮派副本第80层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350080],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35081) ->
	#mon_tpl{
		no = 35081,
		name = <<"帮派副本第81层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350081],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35082) ->
	#mon_tpl{
		no = 35082,
		name = <<"帮派副本第82层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350082],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35083) ->
	#mon_tpl{
		no = 35083,
		name = <<"帮派副本第83层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350083],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35084) ->
	#mon_tpl{
		no = 35084,
		name = <<"帮派副本第84层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350084],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35085) ->
	#mon_tpl{
		no = 35085,
		name = <<"帮派副本第85层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350085],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35086) ->
	#mon_tpl{
		no = 35086,
		name = <<"帮派副本第86层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350086],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35087) ->
	#mon_tpl{
		no = 35087,
		name = <<"帮派副本第87层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350087],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35088) ->
	#mon_tpl{
		no = 35088,
		name = <<"帮派副本第88层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350088],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35089) ->
	#mon_tpl{
		no = 35089,
		name = <<"帮派副本第89层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350089],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35090) ->
	#mon_tpl{
		no = 35090,
		name = <<"帮派副本第90层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350090],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35091) ->
	#mon_tpl{
		no = 35091,
		name = <<"帮派副本第91层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350091],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35092) ->
	#mon_tpl{
		no = 35092,
		name = <<"帮派副本第92层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350092],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35093) ->
	#mon_tpl{
		no = 35093,
		name = <<"帮派副本第93层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350093],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35094) ->
	#mon_tpl{
		no = 35094,
		name = <<"帮派副本第94层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350094],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35095) ->
	#mon_tpl{
		no = 35095,
		name = <<"帮派副本第95层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350095],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35096) ->
	#mon_tpl{
		no = 35096,
		name = <<"帮派副本第96层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350096],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35097) ->
	#mon_tpl{
		no = 35097,
		name = <<"帮派副本第97层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350097],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35098) ->
	#mon_tpl{
		no = 35098,
		name = <<"帮派副本第98层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350098],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35099) ->
	#mon_tpl{
		no = 35099,
		name = <<"帮派副本第99层怪物">>,
		type = 4,
		lv = 15,
		bmon_group_no_list = [350099],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,15,89}}]
};

get(35100) ->
	#mon_tpl{
		no = 35100,
		name = <<"蟠桃小偷">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [350600],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 900,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35101) ->
	#mon_tpl{
		no = 35101,
		name = <<"蟠桃小偷">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [350601],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 900,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35102) ->
	#mon_tpl{
		no = 35102,
		name = <<"蟠桃小偷">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [350602],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 900,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35103) ->
	#mon_tpl{
		no = 35103,
		name = <<"蟠桃小偷">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [350603],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 900,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35104) ->
	#mon_tpl{
		no = 35104,
		name = <<"蟠桃小偷">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [350604],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 900,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35105) ->
	#mon_tpl{
		no = 35105,
		name = <<"蟠桃小偷">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [350605],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 900,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35106) ->
	#mon_tpl{
		no = 35106,
		name = <<"蟠桃小偷">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [350606],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 900,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35107) ->
	#mon_tpl{
		no = 35107,
		name = <<"蟠桃小偷">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [350607],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 900,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35108) ->
	#mon_tpl{
		no = 35108,
		name = <<"试炼之魂">>,
		type = 1,
		lv = 80,
		bmon_group_no_list = [800301],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(22200) ->
	#mon_tpl{
		no = 22200,
		name = <<"幻世魔王">>,
		type = 1,
		lv = 80,
		bmon_group_no_list = [800201],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team,{least_non_tmp_leave_mb_count,2}}]
};

get(22300) ->
	#mon_tpl{
		no = 22300,
		name = <<"混沌魔兵">>,
		type = 1,
		lv = 90,
		bmon_group_no_list = [800401],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team,{least_non_tmp_leave_mb_count,2}}]
};

get(34026) ->
	#mon_tpl{
		no = 34026,
		name = <<"普通铁匠分身">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504115],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34027) ->
	#mon_tpl{
		no = 34027,
		name = <<"强力铁匠分身">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504116],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34028) ->
	#mon_tpl{
		no = 34028,
		name = <<"超级铁匠分身">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504117],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34029) ->
	#mon_tpl{
		no = 34029,
		name = <<"普通铁匠分身">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504118],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34030) ->
	#mon_tpl{
		no = 34030,
		name = <<"强力铁匠分身">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504119],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34031) ->
	#mon_tpl{
		no = 34031,
		name = <<"超级铁匠分身">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504120],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34032) ->
	#mon_tpl{
		no = 34032,
		name = <<"普通铁匠分身">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504121],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34033) ->
	#mon_tpl{
		no = 34033,
		name = <<"强力铁匠分身">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504122],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34034) ->
	#mon_tpl{
		no = 34034,
		name = <<"超级铁匠分身">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504123],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34035) ->
	#mon_tpl{
		no = 34035,
		name = <<"聚贤庄酒客">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504124],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34036) ->
	#mon_tpl{
		no = 34036,
		name = <<"聚贤庄剑客">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504125],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34037) ->
	#mon_tpl{
		no = 34037,
		name = <<"聚贤庄斗神">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504126],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34038) ->
	#mon_tpl{
		no = 34038,
		name = <<"聚贤庄酒客">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504127],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34039) ->
	#mon_tpl{
		no = 34039,
		name = <<"聚贤庄剑客">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504128],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34040) ->
	#mon_tpl{
		no = 34040,
		name = <<"聚贤庄斗神">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504129],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34041) ->
	#mon_tpl{
		no = 34041,
		name = <<"聚贤庄酒客">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504130],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34042) ->
	#mon_tpl{
		no = 34042,
		name = <<"聚贤庄剑客">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504131],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34043) ->
	#mon_tpl{
		no = 34043,
		name = <<"聚贤庄斗神">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [504132],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34044) ->
	#mon_tpl{
		no = 34044,
		name = <<"提炼大师的试炼">>,
		type = 4,
		lv = 100,
		bmon_group_no_list = [4501],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34045) ->
	#mon_tpl{
		no = 34045,
		name = <<"熔铸大师的试炼">>,
		type = 4,
		lv = 100,
		bmon_group_no_list = [4502],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34046) ->
	#mon_tpl{
		no = 34046,
		name = <<"锻造大师的试炼">>,
		type = 4,
		lv = 100,
		bmon_group_no_list = [4503],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34047) ->
	#mon_tpl{
		no = 34047,
		name = <<"提炼大师的试炼">>,
		type = 4,
		lv = 150,
		bmon_group_no_list = [4504],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34048) ->
	#mon_tpl{
		no = 34048,
		name = <<"熔铸大师的试炼">>,
		type = 4,
		lv = 150,
		bmon_group_no_list = [4505],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34049) ->
	#mon_tpl{
		no = 34049,
		name = <<"锻造大师的试炼">>,
		type = 4,
		lv = 150,
		bmon_group_no_list = [4506],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34050) ->
	#mon_tpl{
		no = 34050,
		name = <<"提炼大师的试炼">>,
		type = 4,
		lv = 200,
		bmon_group_no_list = [4507],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34051) ->
	#mon_tpl{
		no = 34051,
		name = <<"熔铸大师的试炼">>,
		type = 4,
		lv = 200,
		bmon_group_no_list = [4508],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34052) ->
	#mon_tpl{
		no = 34052,
		name = <<"锻造大师的试炼">>,
		type = 4,
		lv = 200,
		bmon_group_no_list = [4509],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34053) ->
	#mon_tpl{
		no = 34053,
		name = <<"提炼之神的试炼">>,
		type = 4,
		lv = 250,
		bmon_group_no_list = [4510],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34054) ->
	#mon_tpl{
		no = 34054,
		name = <<"熔铸大师的试炼">>,
		type = 4,
		lv = 250,
		bmon_group_no_list = [4511],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34055) ->
	#mon_tpl{
		no = 34055,
		name = <<"锻造大师的试炼">>,
		type = 4,
		lv = 250,
		bmon_group_no_list = [4512],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34101) ->
	#mon_tpl{
		no = 34101,
		name = <<"幽蓝蛇王魂">>,
		type = 4,
		lv = 100,
		bmon_group_no_list = [4521],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34102) ->
	#mon_tpl{
		no = 34102,
		name = <<"翡翠火麒麟">>,
		type = 4,
		lv = 100,
		bmon_group_no_list = [4522],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34103) ->
	#mon_tpl{
		no = 34103,
		name = <<"冰晶神羽兽">>,
		type = 4,
		lv = 100,
		bmon_group_no_list = [4523],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34104) ->
	#mon_tpl{
		no = 34104,
		name = <<"幽蓝蛇王魂">>,
		type = 4,
		lv = 150,
		bmon_group_no_list = [4524],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34105) ->
	#mon_tpl{
		no = 34105,
		name = <<"翡翠火麒麟">>,
		type = 4,
		lv = 150,
		bmon_group_no_list = [4525],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34106) ->
	#mon_tpl{
		no = 34106,
		name = <<"冰晶神羽兽">>,
		type = 4,
		lv = 150,
		bmon_group_no_list = [4526],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34107) ->
	#mon_tpl{
		no = 34107,
		name = <<"幽蓝蛇王魂">>,
		type = 4,
		lv = 200,
		bmon_group_no_list = [4527],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34108) ->
	#mon_tpl{
		no = 34108,
		name = <<"翡翠火麒麟">>,
		type = 4,
		lv = 200,
		bmon_group_no_list = [4528],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34109) ->
	#mon_tpl{
		no = 34109,
		name = <<"冰晶神羽兽">>,
		type = 4,
		lv = 200,
		bmon_group_no_list = [4529],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34110) ->
	#mon_tpl{
		no = 34110,
		name = <<"幽蓝蛇王魂">>,
		type = 4,
		lv = 250,
		bmon_group_no_list = [4530],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34111) ->
	#mon_tpl{
		no = 34111,
		name = <<"翡翠火麒麟">>,
		type = 4,
		lv = 250,
		bmon_group_no_list = [4531],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34112) ->
	#mon_tpl{
		no = 34112,
		name = <<"冰晶神羽兽">>,
		type = 4,
		lv = 250,
		bmon_group_no_list = [4532],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34201) ->
	#mon_tpl{
		no = 34201,
		name = <<"冰翼笛仙">>,
		type = 4,
		lv = 100,
		bmon_group_no_list = [4541],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34202) ->
	#mon_tpl{
		no = 34202,
		name = <<"金翅武圣">>,
		type = 4,
		lv = 100,
		bmon_group_no_list = [4542],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34203) ->
	#mon_tpl{
		no = 34203,
		name = <<"黑羽剑神">>,
		type = 4,
		lv = 100,
		bmon_group_no_list = [4543],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34204) ->
	#mon_tpl{
		no = 34204,
		name = <<"冰翼笛仙">>,
		type = 4,
		lv = 150,
		bmon_group_no_list = [4544],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34205) ->
	#mon_tpl{
		no = 34205,
		name = <<"金翅武圣">>,
		type = 4,
		lv = 150,
		bmon_group_no_list = [4545],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34206) ->
	#mon_tpl{
		no = 34206,
		name = <<"黑羽剑神">>,
		type = 4,
		lv = 150,
		bmon_group_no_list = [4546],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34207) ->
	#mon_tpl{
		no = 34207,
		name = <<"冰翼笛仙">>,
		type = 4,
		lv = 200,
		bmon_group_no_list = [4547],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34208) ->
	#mon_tpl{
		no = 34208,
		name = <<"金翅武圣">>,
		type = 4,
		lv = 200,
		bmon_group_no_list = [4548],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34209) ->
	#mon_tpl{
		no = 34209,
		name = <<"黑羽剑神">>,
		type = 4,
		lv = 200,
		bmon_group_no_list = [4549],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34210) ->
	#mon_tpl{
		no = 34210,
		name = <<"冰翼笛仙">>,
		type = 4,
		lv = 250,
		bmon_group_no_list = [4550],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34211) ->
	#mon_tpl{
		no = 34211,
		name = <<"金翅武圣">>,
		type = 4,
		lv = 250,
		bmon_group_no_list = [4551],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(34212) ->
	#mon_tpl{
		no = 34212,
		name = <<"黑羽剑神">>,
		type = 4,
		lv = 250,
		bmon_group_no_list = [4552],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35109) ->
	#mon_tpl{
		no = 35109,
		name = <<"墨家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800411],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35110) ->
	#mon_tpl{
		no = 35110,
		name = <<"墨家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800412],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35111) ->
	#mon_tpl{
		no = 35111,
		name = <<"墨家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800413],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35112) ->
	#mon_tpl{
		no = 35112,
		name = <<"墨家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800414],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35113) ->
	#mon_tpl{
		no = 35113,
		name = <<"墨家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800415],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35114) ->
	#mon_tpl{
		no = 35114,
		name = <<"墨家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800416],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35115) ->
	#mon_tpl{
		no = 35115,
		name = <<"墨家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800417],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35116) ->
	#mon_tpl{
		no = 35116,
		name = <<"墨家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800418],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35117) ->
	#mon_tpl{
		no = 35117,
		name = <<"墨家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800419],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35118) ->
	#mon_tpl{
		no = 35118,
		name = <<"兵家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800420],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35119) ->
	#mon_tpl{
		no = 35119,
		name = <<"兵家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800421],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35120) ->
	#mon_tpl{
		no = 35120,
		name = <<"兵家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800422],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35121) ->
	#mon_tpl{
		no = 35121,
		name = <<"兵家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800423],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35122) ->
	#mon_tpl{
		no = 35122,
		name = <<"兵家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800424],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35123) ->
	#mon_tpl{
		no = 35123,
		name = <<"兵家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800425],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35124) ->
	#mon_tpl{
		no = 35124,
		name = <<"兵家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800426],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35125) ->
	#mon_tpl{
		no = 35125,
		name = <<"兵家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800427],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35126) ->
	#mon_tpl{
		no = 35126,
		name = <<"兵家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800428],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35127) ->
	#mon_tpl{
		no = 35127,
		name = <<"法家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800429],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35128) ->
	#mon_tpl{
		no = 35128,
		name = <<"法家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800430],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35129) ->
	#mon_tpl{
		no = 35129,
		name = <<"法家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800431],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35130) ->
	#mon_tpl{
		no = 35130,
		name = <<"法家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800432],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35131) ->
	#mon_tpl{
		no = 35131,
		name = <<"法家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800433],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35132) ->
	#mon_tpl{
		no = 35132,
		name = <<"法家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800434],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35133) ->
	#mon_tpl{
		no = 35133,
		name = <<"法家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800435],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35134) ->
	#mon_tpl{
		no = 35134,
		name = <<"法家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800436],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35135) ->
	#mon_tpl{
		no = 35135,
		name = <<"法家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800437],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35136) ->
	#mon_tpl{
		no = 35136,
		name = <<"阴阳家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800438],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35137) ->
	#mon_tpl{
		no = 35137,
		name = <<"阴阳家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800439],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35138) ->
	#mon_tpl{
		no = 35138,
		name = <<"阴阳家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800440],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35139) ->
	#mon_tpl{
		no = 35139,
		name = <<"阴阳家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800441],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35140) ->
	#mon_tpl{
		no = 35140,
		name = <<"阴阳家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800442],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35141) ->
	#mon_tpl{
		no = 35141,
		name = <<"阴阳家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800443],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35142) ->
	#mon_tpl{
		no = 35142,
		name = <<"阴阳家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800444],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35143) ->
	#mon_tpl{
		no = 35143,
		name = <<"阴阳家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800445],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35144) ->
	#mon_tpl{
		no = 35144,
		name = <<"阴阳家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800446],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35145) ->
	#mon_tpl{
		no = 35145,
		name = <<"道家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800447],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35146) ->
	#mon_tpl{
		no = 35146,
		name = <<"道家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800448],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35147) ->
	#mon_tpl{
		no = 35147,
		name = <<"道家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800449],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35148) ->
	#mon_tpl{
		no = 35148,
		name = <<"道家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800450],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35149) ->
	#mon_tpl{
		no = 35149,
		name = <<"道家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800451],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35150) ->
	#mon_tpl{
		no = 35150,
		name = <<"道家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800452],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35151) ->
	#mon_tpl{
		no = 35151,
		name = <<"道家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800453],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35152) ->
	#mon_tpl{
		no = 35152,
		name = <<"道家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800454],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35153) ->
	#mon_tpl{
		no = 35153,
		name = <<"道家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800455],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35154) ->
	#mon_tpl{
		no = 35154,
		name = <<"儒家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800456],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35155) ->
	#mon_tpl{
		no = 35155,
		name = <<"儒家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800457],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35156) ->
	#mon_tpl{
		no = 35156,
		name = <<"儒家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800458],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35157) ->
	#mon_tpl{
		no = 35157,
		name = <<"儒家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800459],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35158) ->
	#mon_tpl{
		no = 35158,
		name = <<"儒家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800460],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35159) ->
	#mon_tpl{
		no = 35159,
		name = <<"儒家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800461],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35160) ->
	#mon_tpl{
		no = 35160,
		name = <<"儒家左护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800462],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35161) ->
	#mon_tpl{
		no = 35161,
		name = <<"儒家右护法">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800463],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35162) ->
	#mon_tpl{
		no = 35162,
		name = <<"儒家首席弟子">>,
		type = 4,
		lv = 80,
		bmon_group_no_list = [800464],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 3600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35163) ->
	#mon_tpl{
		no = 35163,
		name = <<"采花贼">>,
		type = 4,
		lv = 50,
		bmon_group_no_list = [800465],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35164) ->
	#mon_tpl{
		no = 35164,
		name = <<"食丹鬼">>,
		type = 4,
		lv = 50,
		bmon_group_no_list = [800466],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35165) ->
	#mon_tpl{
		no = 35165,
		name = <<"偷矿者">>,
		type = 4,
		lv = 50,
		bmon_group_no_list = [800467],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(35166) ->
	#mon_tpl{
		no = 35166,
		name = <<"巡山小妖">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [800478],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 518400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [not_in_team]
};

get(35167) ->
	#mon_tpl{
		no = 35167,
		name = <<"瘴气小妖">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [800479],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 345600,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [not_in_team]
};

get(35168) ->
	#mon_tpl{
		no = 35168,
		name = <<"异域小妖">>,
		type = 1,
		lv = 40,
		bmon_group_no_list = [800480],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 172800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [not_in_team]
};

get(35169) ->
	#mon_tpl{
		no = 35169,
		name = <<"黑风山贼">>,
		type = 2,
		lv = 40,
		bmon_group_no_list = [800481],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 432000,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [not_in_team]
};

get(35170) ->
	#mon_tpl{
		no = 35170,
		name = <<"封印使者">>,
		type = 2,
		lv = 40,
		bmon_group_no_list = [800482],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [not_in_team]
};

get(35171) ->
	#mon_tpl{
		no = 35171,
		name = <<"九黎幻魔">>,
		type = 4,
		lv = 40,
		bmon_group_no_list = [800483],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 86400,
		can_concurrent_battle = 1,
		can_be_killed_times = 0,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [not_in_team]
};

get(35172) ->
	#mon_tpl{
		no = 35172,
		name = <<"黑风山贼">>,
		type = 2,
		lv = 40,
		bmon_group_no_list = [800481],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 172800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [not_in_team]
};

get(1001) ->
	#mon_tpl{
		no = 1001,
		name = <<"蝴蝶妖">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [1001],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,70,500}}]
};

get(1002) ->
	#mon_tpl{
		no = 1002,
		name = <<"蜘蛛精">>,
		type = 4,
		lv = 60,
		bmon_group_no_list = [1002],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,70,500}}]
};

get(1003) ->
	#mon_tpl{
		no = 1003,
		name = <<"盗匪刀卫">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [1003],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,120,500}}]
};

get(1004) ->
	#mon_tpl{
		no = 1004,
		name = <<"盗匪首领">>,
		type = 4,
		lv = 60,
		bmon_group_no_list = [1004],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,120,500}}]
};

get(1005) ->
	#mon_tpl{
		no = 1005,
		name = <<"红魔">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [1005],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,150,500}}]
};

get(1006) ->
	#mon_tpl{
		no = 1006,
		name = <<"魅魔">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [1006],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,150,500}}]
};

get(1007) ->
	#mon_tpl{
		no = 1007,
		name = <<"狂魔">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [1007],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,150,500}}]
};

get(1008) ->
	#mon_tpl{
		no = 1008,
		name = <<"疯魔">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [1008],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,150,500}}]
};

get(1009) ->
	#mon_tpl{
		no = 1009,
		name = <<"金鹏">>,
		type = 2,
		lv = 60,
		bmon_group_no_list = [1009],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,180,500}}]
};

get(1010) ->
	#mon_tpl{
		no = 1010,
		name = <<"冰凤">>,
		type = 2,
		lv = 60,
		bmon_group_no_list = [1010],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,180,500}}]
};

get(1011) ->
	#mon_tpl{
		no = 1011,
		name = <<"白狼">>,
		type = 2,
		lv = 60,
		bmon_group_no_list = [1011],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,180,500}}]
};

get(1012) ->
	#mon_tpl{
		no = 1012,
		name = <<"术猿">>,
		type = 2,
		lv = 60,
		bmon_group_no_list = [1012],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,180,500}}]
};

get(1013) ->
	#mon_tpl{
		no = 1013,
		name = <<"深海冰魔">>,
		type = 2,
		lv = 60,
		bmon_group_no_list = [{1,1013},{2,1017},{3,1021},{4,1025},{5,1029}],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,220,250,280,310,340,500}}]
};

get(1014) ->
	#mon_tpl{
		no = 1014,
		name = <<"深海蝰蛇">>,
		type = 2,
		lv = 60,
		bmon_group_no_list = [{1,1014},{2,1018},{3,1022},{4,1026},{5,1030}],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,220,250,280,310,340,500}}]
};

get(1015) ->
	#mon_tpl{
		no = 1015,
		name = <<"深海女皇">>,
		type = 2,
		lv = 60,
		bmon_group_no_list = [{1,1015},{2,1019},{3,1023},{4,1027},{5,1031}],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,220,250,280,310,340,500}}]
};

get(1016) ->
	#mon_tpl{
		no = 1016,
		name = <<"深海姣王">>,
		type = 2,
		lv = 60,
		bmon_group_no_list = [{1,1016},{2,1020},{3,1024},{4,1028},{5,1032}],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,220,250,280,310,340,500}}]
};

get(1017) ->
	#mon_tpl{
		no = 1017,
		name = <<"蓬莱仙子">>,
		type = 2,
		lv = 60,
		bmon_group_no_list = [{1,1033},{2,1037},{3,1041},{4,1045},{5,1049}],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,250,280,310,340,360,500}}]
};

get(1018) ->
	#mon_tpl{
		no = 1018,
		name = <<"蓬莱阎王">>,
		type = 2,
		lv = 60,
		bmon_group_no_list = [{1,1034},{2,1038},{3,1042},{4,1046},{5,1050}],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,250,280,310,340,360,500}}]
};

get(1019) ->
	#mon_tpl{
		no = 1019,
		name = <<"蓬莱圣女">>,
		type = 2,
		lv = 60,
		bmon_group_no_list = [{1,1035},{2,1039},{3,1043},{4,1047},{5,1051}],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,250,280,310,340,360,500}}]
};

get(1020) ->
	#mon_tpl{
		no = 1020,
		name = <<"蓬莱剑神">>,
		type = 2,
		lv = 60,
		bmon_group_no_list = [{1,1036},{2,1040},{3,1044},{4,1048},{5,1052}],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,250,280,310,340,360,500}}]
};

get(1021) ->
	#mon_tpl{
		no = 1021,
		name = <<"白虎圣兽">>,
		type = 4,
		lv = 60,
		bmon_group_no_list = [{1,1053},{6,1060},{7,1064},{8,1068},{9,1072},{10,1072}],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 43200,
		can_concurrent_battle = 1,
		can_be_killed_times = 0,
		need_cleared_after_die = 0,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,300,320,340,360,380,500}}]
};

get(1022) ->
	#mon_tpl{
		no = 1022,
		name = <<"朱雀圣兽">>,
		type = 4,
		lv = 60,
		bmon_group_no_list = [{1,1054},{6,1060},{7,1064},{8,1068},{9,1072},{10,1072}],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 43200,
		can_concurrent_battle = 1,
		can_be_killed_times = 0,
		need_cleared_after_die = 0,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,300,320,340,360,380,500}}]
};

get(1023) ->
	#mon_tpl{
		no = 1023,
		name = <<"玄武圣兽">>,
		type = 4,
		lv = 60,
		bmon_group_no_list = [{1,1055},{6,1060},{7,1064},{8,1068},{9,1072},{10,1072}],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 43200,
		can_concurrent_battle = 1,
		can_be_killed_times = 0,
		need_cleared_after_die = 0,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,300,320,340,360,380,500}}]
};

get(1024) ->
	#mon_tpl{
		no = 1024,
		name = <<"黑龙圣兽">>,
		type = 4,
		lv = 60,
		bmon_group_no_list = [{1,1056},{6,1060},{7,1064},{8,1068},{9,1072},{10,1072}],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 43200,
		can_concurrent_battle = 1,
		can_be_killed_times = 0,
		need_cleared_after_die = 0,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,300,320,340,360,380,500}}]
};

get(1025) ->
	#mon_tpl{
		no = 1025,
		name = <<"盗贼喽喽">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [800481],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 300,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{single_or_in_team,{lv_all_between,65,500}}]
};

get(1026) ->
	#mon_tpl{
		no = 1026,
		name = <<"盗贼首领">>,
		type = 4,
		lv = 60,
		bmon_group_no_list = [800481],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 300,
		can_concurrent_battle = 1,
		can_be_killed_times = 0,
		need_cleared_after_die = 0,
		events_after_die = [],
		conditions = [{in_team, {least_non_tmp_leave_mb_count, 3}}, {single_or_in_team, {lv_all_between,65,500}}]
};

get(2001) ->
	#mon_tpl{
		no = 2001,
		name = <<"机灵鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2201],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060001}, {least_count,2}}]
};

get(2002) ->
	#mon_tpl{
		no = 2002,
		name = <<"捣蛋鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2202],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060002}, {least_count,2}}]
};

get(2003) ->
	#mon_tpl{
		no = 2003,
		name = <<"调皮鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2203],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060003}, {least_count,2}}]
};

get(2004) ->
	#mon_tpl{
		no = 2004,
		name = <<"爱哭鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2204],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060004}, {least_count,2}}]
};

get(2005) ->
	#mon_tpl{
		no = 2005,
		name = <<"小气鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2205],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060005}, {least_count,2}}]
};

get(2006) ->
	#mon_tpl{
		no = 2006,
		name = <<"机灵鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2206],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060006}, {least_count,2}}]
};

get(2007) ->
	#mon_tpl{
		no = 2007,
		name = <<"捣蛋鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2207],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060007}, {least_count,2}}]
};

get(2008) ->
	#mon_tpl{
		no = 2008,
		name = <<"调皮鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2208],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060008}, {least_count,2}}]
};

get(2009) ->
	#mon_tpl{
		no = 2009,
		name = <<"爱哭鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2209],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060009}, {least_count,2}}]
};

get(2010) ->
	#mon_tpl{
		no = 2010,
		name = <<"小气鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2210],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060010}, {least_count,2}}]
};

get(2011) ->
	#mon_tpl{
		no = 2011,
		name = <<"机灵鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2211],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060011}, {least_count,2}}]
};

get(2012) ->
	#mon_tpl{
		no = 2012,
		name = <<"捣蛋鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2212],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060012}, {least_count,2}}]
};

get(2013) ->
	#mon_tpl{
		no = 2013,
		name = <<"调皮鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2213],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060013}, {least_count,2}}]
};

get(2014) ->
	#mon_tpl{
		no = 2014,
		name = <<"爱哭鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2214],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060014}, {least_count,2}}]
};

get(2015) ->
	#mon_tpl{
		no = 2015,
		name = <<"小气鬼">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2215],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{in_team, {has_unfinished_task, 1060015}, {least_count,2}}]
};

get(2111) ->
	#mon_tpl{
		no = 2111,
		name = <<"盗匪首领">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2311],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1070001}]
};

get(2112) ->
	#mon_tpl{
		no = 2112,
		name = <<"盗匪首领">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2312],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1070002}]
};

get(2113) ->
	#mon_tpl{
		no = 2113,
		name = <<"盗匪首领">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2313],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1070003}]
};

get(2114) ->
	#mon_tpl{
		no = 2114,
		name = <<"盗匪首领">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2314],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1070004}]
};

get(2115) ->
	#mon_tpl{
		no = 2115,
		name = <<"盗匪首领">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2315],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1070005}]
};

get(2201) ->
	#mon_tpl{
		no = 2201,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2401],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031016}]
};

get(2202) ->
	#mon_tpl{
		no = 2202,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2402],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031017}]
};

get(2203) ->
	#mon_tpl{
		no = 2203,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2403],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031018}]
};

get(2204) ->
	#mon_tpl{
		no = 2204,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2404],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031019}]
};

get(2205) ->
	#mon_tpl{
		no = 2205,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2405],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031020}]
};

get(2206) ->
	#mon_tpl{
		no = 2206,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2406],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031021}]
};

get(2207) ->
	#mon_tpl{
		no = 2207,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2407],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031022}]
};

get(2208) ->
	#mon_tpl{
		no = 2208,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2408],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031023}]
};

get(2209) ->
	#mon_tpl{
		no = 2209,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2409],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031024}]
};

get(2210) ->
	#mon_tpl{
		no = 2210,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2410],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031025}]
};

get(2211) ->
	#mon_tpl{
		no = 2211,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2411],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031026}]
};

get(2212) ->
	#mon_tpl{
		no = 2212,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2412],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031027}]
};

get(2213) ->
	#mon_tpl{
		no = 2213,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2413],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031028}]
};

get(2214) ->
	#mon_tpl{
		no = 2214,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2414],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031029}]
};

get(2215) ->
	#mon_tpl{
		no = 2215,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2415],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031030}]
};

get(2216) ->
	#mon_tpl{
		no = 2216,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2416],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031031}]
};

get(2217) ->
	#mon_tpl{
		no = 2217,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2417],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031032}]
};

get(2218) ->
	#mon_tpl{
		no = 2218,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2418],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031033}]
};

get(2219) ->
	#mon_tpl{
		no = 2219,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2419],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031034}]
};

get(2220) ->
	#mon_tpl{
		no = 2220,
		name = <<"试炼使者">>,
		type = 3,
		lv = 60,
		bmon_group_no_list = [2420],
		is_combative = 0,
		is_visible_to_all = 0,
		att_area = 0,
		trace_area = 0,
		existing_time = 1800,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = [{has_task, 1031035}]
};

get(2301) ->
	#mon_tpl{
		no = 2301,
		name = <<"小蟠桃">>,
		type = 1,
		lv = 50,
		bmon_group_no_list = [2501],
		is_combative = 0,
		is_visible_to_all = 1,
		att_area = 0,
		trace_area = 0,
		existing_time = 110,
		can_concurrent_battle = 0,
		can_be_killed_times = 1,
		need_cleared_after_die = 1,
		events_after_die = [],
		conditions = []
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

