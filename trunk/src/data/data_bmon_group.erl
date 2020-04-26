%%%---------------------------------------
%%% @Module  : data_bmon_group
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 战斗怪物组
%%%---------------------------------------


-module(data_bmon_group).
-export([get/1]).
-include("monster.hrl").
-include("debug.hrl").

get(1) ->
	#bmon_group{
		no = 1,
		name = <<"新手战斗">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{25001,1},{25003,3},{25004,4}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 1,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2) ->
	#bmon_group{
		no = 2,
		name = <<"测试战斗">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{56001,1}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3) ->
	#bmon_group{
		no = 3,
		name = <<"日常玩法怪物测试">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {fixed,10000},
		mon_pool_fixed = [{2500, 1}, {2501, 2}, {2501, 3}, {2501, 4}, {2501, 5}, {2501, 6}, {2501, 7}, {2501, 8}, {2501, 9}, {2501, 10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4) ->
	#bmon_group{
		no = 4,
		name = <<"挑战玩法怪物测试">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {fixed,10000},
		mon_pool_fixed = [{2502, 1}, {2503, 2}, {2503, 3}, {2503, 4}, {2503, 5}, {2503, 6}, {2503, 7}, {2503, 8}, {2503, 9}, {2503, 10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2901) ->
	#bmon_group{
		no = 2901,
		name = <<"帮派任务-流氓痞子">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2601, 1}, {2601, 2}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2902) ->
	#bmon_group{
		no = 2902,
		name = <<"帮派任务-阴险探子 ">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2602, 1}, {2602, 2}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2903) ->
	#bmon_group{
		no = 2903,
		name = <<"帮派任务-江洋大盗">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2603, 1}, {2603, 2}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2904) ->
	#bmon_group{
		no = 2904,
		name = <<"帮派任务-流氓痞子">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2604, 1}, {2604, 2}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2905) ->
	#bmon_group{
		no = 2905,
		name = <<"帮派任务-阴险探子 ">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2605, 1}, {2605, 2}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2906) ->
	#bmon_group{
		no = 2906,
		name = <<"帮派任务-江洋大盗">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2606, 1}, {2606, 2}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2907) ->
	#bmon_group{
		no = 2907,
		name = <<"帮派任务-流氓痞子">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2607, 1}, {2607, 2}, {2607, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2908) ->
	#bmon_group{
		no = 2908,
		name = <<"帮派任务-阴险探子 ">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2608, 1}, {2608, 2}, {2608, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2909) ->
	#bmon_group{
		no = 2909,
		name = <<"帮派任务-江洋大盗">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2609, 1}, {2609, 2}, {2609, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2910) ->
	#bmon_group{
		no = 2910,
		name = <<"帮派任务-流氓痞子">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2610, 1}, {2610, 2}, {2610, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2911) ->
	#bmon_group{
		no = 2911,
		name = <<"帮派任务-阴险探子 ">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2611, 1}, {2611, 2}, {2611, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2912) ->
	#bmon_group{
		no = 2912,
		name = <<"帮派任务-江洋大盗">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2612, 1}, {2613, 2}, {2614, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2913) ->
	#bmon_group{
		no = 2913,
		name = <<"帮派任务-流氓痞子">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2613, 1}, {2613, 2}, {2613, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2914) ->
	#bmon_group{
		no = 2914,
		name = <<"帮派任务-阴险探子 ">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2614, 1}, {2614, 2}, {2614, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2915) ->
	#bmon_group{
		no = 2915,
		name = <<"帮派任务-江洋大盗">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{2615, 1}, {2615, 2}, {2615, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4395) ->
	#bmon_group{
		no = 4395,
		name = <<"镇妖塔1层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 1,
		attr_random_range = 0,
		attr_streng = {1,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4396) ->
	#bmon_group{
		no = 4396,
		name = <<"镇妖塔2层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 1,
		attr_random_range = 0,
		attr_streng = {2,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4397) ->
	#bmon_group{
		no = 4397,
		name = <<"镇妖塔3层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 1,
		attr_random_range = 0,
		attr_streng = {3,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4398) ->
	#bmon_group{
		no = 4398,
		name = <<"镇妖塔4层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 1,
		attr_random_range = 0,
		attr_streng = {4,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4399) ->
	#bmon_group{
		no = 4399,
		name = <<"镇妖塔5层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 1,
		attr_random_range = 0,
		attr_streng = {5,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4400) ->
	#bmon_group{
		no = 4400,
		name = <<"镇妖塔6层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 1,
		attr_random_range = 0,
		attr_streng = {6,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4401) ->
	#bmon_group{
		no = 4401,
		name = <<"镇妖塔7层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 1,
		attr_random_range = 0,
		attr_streng = {7,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4402) ->
	#bmon_group{
		no = 4402,
		name = <<"镇妖塔8层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 1,
		attr_random_range = 0,
		attr_streng = {8,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4403) ->
	#bmon_group{
		no = 4403,
		name = <<"镇妖塔9层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 1,
		attr_random_range = 0,
		attr_streng = {9,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4404) ->
	#bmon_group{
		no = 4404,
		name = <<"镇妖塔10层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 1,
		attr_random_range = 0,
		attr_streng = {10,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4405) ->
	#bmon_group{
		no = 4405,
		name = <<"镇妖塔11层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {11,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4406) ->
	#bmon_group{
		no = 4406,
		name = <<"镇妖塔12层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {12,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4407) ->
	#bmon_group{
		no = 4407,
		name = <<"镇妖塔13层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {13,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4408) ->
	#bmon_group{
		no = 4408,
		name = <<"镇妖塔14层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {14,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4409) ->
	#bmon_group{
		no = 4409,
		name = <<"镇妖塔15层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {15,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4410) ->
	#bmon_group{
		no = 4410,
		name = <<"镇妖塔16层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {16,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4411) ->
	#bmon_group{
		no = 4411,
		name = <<"镇妖塔17层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {17,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4412) ->
	#bmon_group{
		no = 4412,
		name = <<"镇妖塔18层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {18,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4413) ->
	#bmon_group{
		no = 4413,
		name = <<"镇妖塔19层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {19,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4414) ->
	#bmon_group{
		no = 4414,
		name = <<"镇妖塔20层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {20,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4415) ->
	#bmon_group{
		no = 4415,
		name = <<"镇妖塔21层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {21,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4416) ->
	#bmon_group{
		no = 4416,
		name = <<"镇妖塔22层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {22,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4417) ->
	#bmon_group{
		no = 4417,
		name = <<"镇妖塔23层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {23,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4418) ->
	#bmon_group{
		no = 4418,
		name = <<"镇妖塔24层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {24,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4419) ->
	#bmon_group{
		no = 4419,
		name = <<"镇妖塔25层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {25,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4420) ->
	#bmon_group{
		no = 4420,
		name = <<"镇妖塔26层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {26,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4421) ->
	#bmon_group{
		no = 4421,
		name = <<"镇妖塔27层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {27,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4422) ->
	#bmon_group{
		no = 4422,
		name = <<"镇妖塔28层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {28,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4423) ->
	#bmon_group{
		no = 4423,
		name = <<"镇妖塔29层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {29,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4424) ->
	#bmon_group{
		no = 4424,
		name = <<"镇妖塔30层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = {30,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4425) ->
	#bmon_group{
		no = 4425,
		name = <<"镇妖塔31层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {31,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4426) ->
	#bmon_group{
		no = 4426,
		name = <<"镇妖塔32层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {32,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4427) ->
	#bmon_group{
		no = 4427,
		name = <<"镇妖塔33层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {33,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4428) ->
	#bmon_group{
		no = 4428,
		name = <<"镇妖塔34层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {34,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4429) ->
	#bmon_group{
		no = 4429,
		name = <<"镇妖塔35层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {35,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4430) ->
	#bmon_group{
		no = 4430,
		name = <<"镇妖塔36层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {36,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4431) ->
	#bmon_group{
		no = 4431,
		name = <<"镇妖塔37层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {37,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4432) ->
	#bmon_group{
		no = 4432,
		name = <<"镇妖塔38层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {38,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4433) ->
	#bmon_group{
		no = 4433,
		name = <<"镇妖塔39层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {39,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4434) ->
	#bmon_group{
		no = 4434,
		name = <<"镇妖塔40层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {40,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4435) ->
	#bmon_group{
		no = 4435,
		name = <<"镇妖塔41层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {41,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4436) ->
	#bmon_group{
		no = 4436,
		name = <<"镇妖塔42层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {42,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4437) ->
	#bmon_group{
		no = 4437,
		name = <<"镇妖塔43层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {43,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4438) ->
	#bmon_group{
		no = 4438,
		name = <<"镇妖塔44层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {44,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4439) ->
	#bmon_group{
		no = 4439,
		name = <<"镇妖塔45层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {45,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4440) ->
	#bmon_group{
		no = 4440,
		name = <<"镇妖塔46层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {46,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4441) ->
	#bmon_group{
		no = 4441,
		name = <<"镇妖塔47层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {47,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4442) ->
	#bmon_group{
		no = 4442,
		name = <<"镇妖塔48层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {48,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4443) ->
	#bmon_group{
		no = 4443,
		name = <<"镇妖塔49层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {49,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4444) ->
	#bmon_group{
		no = 4444,
		name = <<"镇妖塔50层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {50,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4445) ->
	#bmon_group{
		no = 4445,
		name = <<"镇妖塔51层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {51,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4446) ->
	#bmon_group{
		no = 4446,
		name = <<"镇妖塔52层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {52,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4447) ->
	#bmon_group{
		no = 4447,
		name = <<"镇妖塔53层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {53,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4448) ->
	#bmon_group{
		no = 4448,
		name = <<"镇妖塔54层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {54,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4449) ->
	#bmon_group{
		no = 4449,
		name = <<"镇妖塔55层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {55,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4450) ->
	#bmon_group{
		no = 4450,
		name = <<"镇妖塔56层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {56,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4451) ->
	#bmon_group{
		no = 4451,
		name = <<"镇妖塔57层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {57,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4452) ->
	#bmon_group{
		no = 4452,
		name = <<"镇妖塔58层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {58,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4453) ->
	#bmon_group{
		no = 4453,
		name = <<"镇妖塔59层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = {59,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4454) ->
	#bmon_group{
		no = 4454,
		name = <<"镇妖塔60层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {60,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4455) ->
	#bmon_group{
		no = 4455,
		name = <<"镇妖塔61层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {61,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4456) ->
	#bmon_group{
		no = 4456,
		name = <<"镇妖塔62层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {62,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4457) ->
	#bmon_group{
		no = 4457,
		name = <<"镇妖塔63层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {63,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4458) ->
	#bmon_group{
		no = 4458,
		name = <<"镇妖塔64层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {64,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4459) ->
	#bmon_group{
		no = 4459,
		name = <<"镇妖塔65层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {65,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4460) ->
	#bmon_group{
		no = 4460,
		name = <<"镇妖塔66层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {66,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4461) ->
	#bmon_group{
		no = 4461,
		name = <<"镇妖塔67层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {67,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4462) ->
	#bmon_group{
		no = 4462,
		name = <<"镇妖塔68层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {68,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4463) ->
	#bmon_group{
		no = 4463,
		name = <<"镇妖塔69层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {69,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4464) ->
	#bmon_group{
		no = 4464,
		name = <<"镇妖塔70层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {70,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55028 ,55029 , 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4465) ->
	#bmon_group{
		no = 4465,
		name = <<"镇妖塔71层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {71,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4466) ->
	#bmon_group{
		no = 4466,
		name = <<"镇妖塔72层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {72,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4467) ->
	#bmon_group{
		no = 4467,
		name = <<"镇妖塔73层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {73,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4468) ->
	#bmon_group{
		no = 4468,
		name = <<"镇妖塔74层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {74,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4469) ->
	#bmon_group{
		no = 4469,
		name = <<"镇妖塔75层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {75,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4470) ->
	#bmon_group{
		no = 4470,
		name = <<"镇妖塔76层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {76,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4471) ->
	#bmon_group{
		no = 4471,
		name = <<"镇妖塔77层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {77,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4472) ->
	#bmon_group{
		no = 4472,
		name = <<"镇妖塔78层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {78,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4473) ->
	#bmon_group{
		no = 4473,
		name = <<"镇妖塔79层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {79,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4474) ->
	#bmon_group{
		no = 4474,
		name = <<"镇妖塔80层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 4,
		attr_random_range = 0,
		attr_streng = {80,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4475) ->
	#bmon_group{
		no = 4475,
		name = <<"镇妖塔81层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {81,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4476) ->
	#bmon_group{
		no = 4476,
		name = <<"镇妖塔82层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {82,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4477) ->
	#bmon_group{
		no = 4477,
		name = <<"镇妖塔83层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {83,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4478) ->
	#bmon_group{
		no = 4478,
		name = <<"镇妖塔84层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {84,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4479) ->
	#bmon_group{
		no = 4479,
		name = <<"镇妖塔85层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {85,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4480) ->
	#bmon_group{
		no = 4480,
		name = <<"镇妖塔86层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {86,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4481) ->
	#bmon_group{
		no = 4481,
		name = <<"镇妖塔87层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {87,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4482) ->
	#bmon_group{
		no = 4482,
		name = <<"镇妖塔88层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {88,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4483) ->
	#bmon_group{
		no = 4483,
		name = <<"镇妖塔89层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {89,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4484) ->
	#bmon_group{
		no = 4484,
		name = <<"镇妖塔90层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {90,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4485) ->
	#bmon_group{
		no = 4485,
		name = <<"镇妖塔91层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {91,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4486) ->
	#bmon_group{
		no = 4486,
		name = <<"镇妖塔92层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {92,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4487) ->
	#bmon_group{
		no = 4487,
		name = <<"镇妖塔93层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {93,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4488) ->
	#bmon_group{
		no = 4488,
		name = <<"镇妖塔94层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {94,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4489) ->
	#bmon_group{
		no = 4489,
		name = <<"镇妖塔95层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {95,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4490) ->
	#bmon_group{
		no = 4490,
		name = <<"镇妖塔96层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {96,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4491) ->
	#bmon_group{
		no = 4491,
		name = <<"镇妖塔97层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {97,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4492) ->
	#bmon_group{
		no = 4492,
		name = <<"镇妖塔98层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {98,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4493) ->
	#bmon_group{
		no = 4493,
		name = <<"镇妖塔99层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {99,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4494) ->
	#bmon_group{
		no = 4494,
		name = <<"镇妖塔100层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = {100,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4701) ->
	#bmon_group{
		no = 4701,
		name = <<"镇妖塔101层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = {101,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4702) ->
	#bmon_group{
		no = 4702,
		name = <<"镇妖塔102层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = {102,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4703) ->
	#bmon_group{
		no = 4703,
		name = <<"镇妖塔103层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = {103,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4704) ->
	#bmon_group{
		no = 4704,
		name = <<"镇妖塔104层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = {104,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4705) ->
	#bmon_group{
		no = 4705,
		name = <<"镇妖塔105层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = {105,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4706) ->
	#bmon_group{
		no = 4706,
		name = <<"镇妖塔106层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = {106,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4707) ->
	#bmon_group{
		no = 4707,
		name = <<"镇妖塔107层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = {107,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4708) ->
	#bmon_group{
		no = 4708,
		name = <<"镇妖塔108层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = {108,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4709) ->
	#bmon_group{
		no = 4709,
		name = <<"镇妖塔109层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = {109,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4710) ->
	#bmon_group{
		no = 4710,
		name = <<"镇妖塔110层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = {110,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4711) ->
	#bmon_group{
		no = 4711,
		name = <<"镇妖塔111层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {111,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4712) ->
	#bmon_group{
		no = 4712,
		name = <<"镇妖塔112层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {112,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4713) ->
	#bmon_group{
		no = 4713,
		name = <<"镇妖塔113层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {113,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4714) ->
	#bmon_group{
		no = 4714,
		name = <<"镇妖塔114层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {114,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4715) ->
	#bmon_group{
		no = 4715,
		name = <<"镇妖塔115层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {115,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4716) ->
	#bmon_group{
		no = 4716,
		name = <<"镇妖塔116层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {116,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4717) ->
	#bmon_group{
		no = 4717,
		name = <<"镇妖塔117层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {117,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4718) ->
	#bmon_group{
		no = 4718,
		name = <<"镇妖塔118层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {118,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4719) ->
	#bmon_group{
		no = 4719,
		name = <<"镇妖塔119层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {119,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4720) ->
	#bmon_group{
		no = 4720,
		name = <<"镇妖塔120层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {120,0.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4721) ->
	#bmon_group{
		no = 4721,
		name = <<"镇妖塔121层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {121,0.7},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4722) ->
	#bmon_group{
		no = 4722,
		name = <<"镇妖塔122层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {122,0.8},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4723) ->
	#bmon_group{
		no = 4723,
		name = <<"镇妖塔123层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {123,0.9},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4724) ->
	#bmon_group{
		no = 4724,
		name = <<"镇妖塔124层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {124,1.0},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4725) ->
	#bmon_group{
		no = 4725,
		name = <<"镇妖塔125层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {125,1.1},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4726) ->
	#bmon_group{
		no = 4726,
		name = <<"镇妖塔126层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {126,1.2},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4727) ->
	#bmon_group{
		no = 4727,
		name = <<"镇妖塔127层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {127,1.3},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4728) ->
	#bmon_group{
		no = 4728,
		name = <<"镇妖塔128层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {128,1.4},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4729) ->
	#bmon_group{
		no = 4729,
		name = <<"镇妖塔129层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = {129,1.5},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4730) ->
	#bmon_group{
		no = 4730,
		name = <<"镇妖塔130层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {130,1.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4731) ->
	#bmon_group{
		no = 4731,
		name = <<"镇妖塔131层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {131,1.7},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4732) ->
	#bmon_group{
		no = 4732,
		name = <<"镇妖塔132层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {132,1.8},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4733) ->
	#bmon_group{
		no = 4733,
		name = <<"镇妖塔133层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {133,1.9},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4734) ->
	#bmon_group{
		no = 4734,
		name = <<"镇妖塔134层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {134,1.10},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4735) ->
	#bmon_group{
		no = 4735,
		name = <<"镇妖塔135层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {135,1.11},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4736) ->
	#bmon_group{
		no = 4736,
		name = <<"镇妖塔136层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {136,1.12},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4737) ->
	#bmon_group{
		no = 4737,
		name = <<"镇妖塔137层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {137,1.13},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4738) ->
	#bmon_group{
		no = 4738,
		name = <<"镇妖塔138层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {138,1.14},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4739) ->
	#bmon_group{
		no = 4739,
		name = <<"镇妖塔139层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {139,1.15},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4740) ->
	#bmon_group{
		no = 4740,
		name = <<"镇妖塔140层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {140,1.16},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4741) ->
	#bmon_group{
		no = 4741,
		name = <<"镇妖塔141层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {141,1.2},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4742) ->
	#bmon_group{
		no = 4742,
		name = <<"镇妖塔142层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {142,1.3},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4743) ->
	#bmon_group{
		no = 4743,
		name = <<"镇妖塔143层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {143,1.4},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4744) ->
	#bmon_group{
		no = 4744,
		name = <<"镇妖塔144层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {144,1.5},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4745) ->
	#bmon_group{
		no = 4745,
		name = <<"镇妖塔145层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {145,1.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4746) ->
	#bmon_group{
		no = 4746,
		name = <<"镇妖塔146层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {146,1.7},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4747) ->
	#bmon_group{
		no = 4747,
		name = <<"镇妖塔147层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {147,1.8},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4748) ->
	#bmon_group{
		no = 4748,
		name = <<"镇妖塔148层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {148,1.9},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4749) ->
	#bmon_group{
		no = 4749,
		name = <<"镇妖塔149层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {149,2.0},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4750) ->
	#bmon_group{
		no = 4750,
		name = <<"镇妖塔150层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = {150,3.0},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4751) ->
	#bmon_group{
		no = 4751,
		name = <<"镇妖塔151层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {151,3.1},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4752) ->
	#bmon_group{
		no = 4752,
		name = <<"镇妖塔152层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {152,3.2},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4753) ->
	#bmon_group{
		no = 4753,
		name = <<"镇妖塔153层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {153,3.3},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4754) ->
	#bmon_group{
		no = 4754,
		name = <<"镇妖塔154层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {154,3.4},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4755) ->
	#bmon_group{
		no = 4755,
		name = <<"镇妖塔155层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {155,3.5},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4756) ->
	#bmon_group{
		no = 4756,
		name = <<"镇妖塔156层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {156,3.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4757) ->
	#bmon_group{
		no = 4757,
		name = <<"镇妖塔157层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {157,3.7},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4758) ->
	#bmon_group{
		no = 4758,
		name = <<"镇妖塔158层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {158,3.8},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4759) ->
	#bmon_group{
		no = 4759,
		name = <<"镇妖塔159层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {159,3.9},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4760) ->
	#bmon_group{
		no = 4760,
		name = <<"镇妖塔160层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {160,4.0},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4761) ->
	#bmon_group{
		no = 4761,
		name = <<"镇妖塔161层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {161,4.1},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4762) ->
	#bmon_group{
		no = 4762,
		name = <<"镇妖塔162层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {162,4.2},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4763) ->
	#bmon_group{
		no = 4763,
		name = <<"镇妖塔163层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {163,4.3},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4764) ->
	#bmon_group{
		no = 4764,
		name = <<"镇妖塔164层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {164,4.4},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4765) ->
	#bmon_group{
		no = 4765,
		name = <<"镇妖塔165层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {165,4.5},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4766) ->
	#bmon_group{
		no = 4766,
		name = <<"镇妖塔166层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {166,4.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4767) ->
	#bmon_group{
		no = 4767,
		name = <<"镇妖塔167层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {167,4.7},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4768) ->
	#bmon_group{
		no = 4768,
		name = <<"镇妖塔168层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {168,4.8},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4769) ->
	#bmon_group{
		no = 4769,
		name = <<"镇妖塔169层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {169,4.9},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4770) ->
	#bmon_group{
		no = 4770,
		name = <<"镇妖塔170层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {170,5.0},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4771) ->
	#bmon_group{
		no = 4771,
		name = <<"镇妖塔171层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {171,5.1},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4772) ->
	#bmon_group{
		no = 4772,
		name = <<"镇妖塔172层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {172,5.2},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4773) ->
	#bmon_group{
		no = 4773,
		name = <<"镇妖塔173层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {173,5.3},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4774) ->
	#bmon_group{
		no = 4774,
		name = <<"镇妖塔174层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {174,5.4},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4775) ->
	#bmon_group{
		no = 4775,
		name = <<"镇妖塔175层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {175,5.5},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4776) ->
	#bmon_group{
		no = 4776,
		name = <<"镇妖塔176层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {176,5.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4777) ->
	#bmon_group{
		no = 4777,
		name = <<"镇妖塔177层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {177,5.7},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4778) ->
	#bmon_group{
		no = 4778,
		name = <<"镇妖塔178层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {178,5.8},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4779) ->
	#bmon_group{
		no = 4779,
		name = <<"镇妖塔179层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {179,5.9},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4780) ->
	#bmon_group{
		no = 4780,
		name = <<"镇妖塔180层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {180,6.0},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4781) ->
	#bmon_group{
		no = 4781,
		name = <<"镇妖塔181层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {181,6.1},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4782) ->
	#bmon_group{
		no = 4782,
		name = <<"镇妖塔182层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {182,6.2},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4783) ->
	#bmon_group{
		no = 4783,
		name = <<"镇妖塔183层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {183,6.3},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4784) ->
	#bmon_group{
		no = 4784,
		name = <<"镇妖塔184层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {184,6.4},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4785) ->
	#bmon_group{
		no = 4785,
		name = <<"镇妖塔185层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {185,6.5},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4786) ->
	#bmon_group{
		no = 4786,
		name = <<"镇妖塔186层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {186,6.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4787) ->
	#bmon_group{
		no = 4787,
		name = <<"镇妖塔187层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {187,6.7},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4788) ->
	#bmon_group{
		no = 4788,
		name = <<"镇妖塔188层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {188,6.8},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4789) ->
	#bmon_group{
		no = 4789,
		name = <<"镇妖塔189层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {189,6.9},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4790) ->
	#bmon_group{
		no = 4790,
		name = <<"镇妖塔190层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {190,7.0},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4791) ->
	#bmon_group{
		no = 4791,
		name = <<"镇妖塔191层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {191,7.1},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4792) ->
	#bmon_group{
		no = 4792,
		name = <<"镇妖塔192层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {192,7.2},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4793) ->
	#bmon_group{
		no = 4793,
		name = <<"镇妖塔193层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {193,7.3},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4794) ->
	#bmon_group{
		no = 4794,
		name = <<"镇妖塔194层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {194,7.4},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4795) ->
	#bmon_group{
		no = 4795,
		name = <<"镇妖塔195层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {195,7.5},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4796) ->
	#bmon_group{
		no = 4796,
		name = <<"镇妖塔196层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {196,7.6},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4797) ->
	#bmon_group{
		no = 4797,
		name = <<"镇妖塔197层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {197,7.7},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4798) ->
	#bmon_group{
		no = 4798,
		name = <<"镇妖塔198层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {198,7.8},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4799) ->
	#bmon_group{
		no = 4799,
		name = <<"镇妖塔199层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {199,7.9},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4800) ->
	#bmon_group{
		no = 4800,
		name = <<"镇妖塔200层守卫怪物组">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = {200,8.0},
		mon_pool_fixed = [],
		mon_pool_normal = [55027 ,55028 ,55029 ,55030, 55031, 55032],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(5000) ->
	#bmon_group{
		no = 5000,
		name = <<"15级怪物攻城">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{5100, 1}, {5101, 2}, {5102, 3}],
		mon_pool_normal = [5103, 5104, 5105, 5106, 5107, 5108,5109],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(5001) ->
	#bmon_group{
		no = 5001,
		name = <<"25级怪物攻城">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 0.220000,
		mon_pool_fixed = [{5100, 1}, {5101, 2}, {5102, 3}],
		mon_pool_normal = [5103, 5104, 5105, 5106, 5107, 5108,5109],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(5002) ->
	#bmon_group{
		no = 5002,
		name = <<"35级怪物攻城">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0.250000,
		mon_pool_fixed = [{5100, 1}, {5101, 2}, {5102, 3}],
		mon_pool_normal = [5103, 5104, 5105, 5106, 5107, 5108,5109],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(5003) ->
	#bmon_group{
		no = 5003,
		name = <<"45级怪物攻城">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0.280000,
		mon_pool_fixed = [{5100, 1}, {5101, 2}, {5102, 3}],
		mon_pool_normal = [5103, 5104, 5105, 5106, 5107, 5108,5109],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(5008) ->
	#bmon_group{
		no = 5008,
		name = <<"55级怪物攻城">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{5100, 1}, {5101, 2}, {5102, 3}],
		mon_pool_normal = [5103, 5104, 5105, 5106, 5107, 5108,5109],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(5009) ->
	#bmon_group{
		no = 5009,
		name = <<"65级怪物攻城">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 0.320000,
		mon_pool_fixed = [{5100, 1}, {5101, 2}, {5102, 3}],
		mon_pool_normal = [5103, 5104, 5105, 5106, 5107, 5108,5109],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(5071) ->
	#bmon_group{
		no = 5071,
		name = <<"75级怪物攻城">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{5100, 1}, {5101, 2}, {5102, 3}],
		mon_pool_normal = [5103, 5104, 5105, 5106, 5107, 5108,5109],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(5072) ->
	#bmon_group{
		no = 5072,
		name = <<"85级怪物攻城">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 0.400000,
		mon_pool_fixed = [{5100, 1}, {5101, 2}, {5102, 3}],
		mon_pool_normal = [5103, 5104, 5105, 5106, 5107, 5108,5109],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7501) ->
	#bmon_group{
		no = 7501,
		name = <<"护法金刚">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4000,1},{4009,2},{4009,3},{4005,7},{4004,9},{4006,10}],
		mon_pool_normal = [4007, 4008],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7502) ->
	#bmon_group{
		no = 7502,
		name = <<"淘气童子">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4001,1},{4007,6},{4005,7},{4008,8},{4004,9},{4006,10}],
		mon_pool_normal = [4009, 4010],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7503) ->
	#bmon_group{
		no = 7503,
		name = <<"掌灯侍女">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4002,1},{4007,6},{4005,7},{4008,8},{4004,9},{4006,10}],
		mon_pool_normal = [4009, 4010],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7504) ->
	#bmon_group{
		no = 7504,
		name = <<"星宿护卫头领">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4003,1},{4009,2},{4010,3},{4007,4},{4002,5},{4000,6},{4005,7},{4006,8},{4008,9},{4001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7505) ->
	#bmon_group{
		no = 7505,
		name = <<"角木蛟">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4029,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7506) ->
	#bmon_group{
		no = 7506,
		name = <<"亢金龙">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4030,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7507) ->
	#bmon_group{
		no = 7507,
		name = <<"女士蝠">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4031,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7508) ->
	#bmon_group{
		no = 7508,
		name = <<"房日兔">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4032,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7509) ->
	#bmon_group{
		no = 7509,
		name = <<"心月狐">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4033,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7510) ->
	#bmon_group{
		no = 7510,
		name = <<"尾火虎">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4034,1},{4020,2},{4020,3},{4020,4},{4020,5},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7511) ->
	#bmon_group{
		no = 7511,
		name = <<"箕水豹">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4035,1},{4020,2},{4020,3},{4020,4},{4020,5},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7512) ->
	#bmon_group{
		no = 7512,
		name = <<"奎木狼">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4036,1},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4023, 4024, 4025, 4026, 4027, 4028
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7513) ->
	#bmon_group{
		no = 7513,
		name = <<"娄金狗">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4037,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7514) ->
	#bmon_group{
		no = 7514,
		name = <<"胃土雉">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4038,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7515) ->
	#bmon_group{
		no = 7515,
		name = <<"昂日鸡">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4039,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7516) ->
	#bmon_group{
		no = 7516,
		name = <<"毕月乌">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4040,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7517) ->
	#bmon_group{
		no = 7517,
		name = <<"觜火猴">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4041,1},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4023, 4024, 4025, 4026, 4027, 4028
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7518) ->
	#bmon_group{
		no = 7518,
		name = <<"参水猿">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4042,1},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4023, 4024, 4025, 4026, 4027, 4028
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7519) ->
	#bmon_group{
		no = 7519,
		name = <<"井木犴">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4043,1},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4023, 4024, 4025, 4026, 4027, 4028
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7520) ->
	#bmon_group{
		no = 7520,
		name = <<"鬼金羊">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4044,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7521) ->
	#bmon_group{
		no = 7521,
		name = <<"柳土獐">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4045,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7522) ->
	#bmon_group{
		no = 7522,
		name = <<"星日马">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4046,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7523) ->
	#bmon_group{
		no = 7523,
		name = <<"张月鹿">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4047,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7524) ->
	#bmon_group{
		no = 7524,
		name = <<"翼火蛇">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4048,1},{4020,2},{4020,3},{4020,4},{4020,5},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7525) ->
	#bmon_group{
		no = 7525,
		name = <<"轸水蚓">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4049,1},{4020,2},{4020,3},{4020,4},{4020,5},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7526) ->
	#bmon_group{
		no = 7526,
		name = <<"斗木獬">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4050,1},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4023, 4024, 4025, 4026, 4027, 4028
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7527) ->
	#bmon_group{
		no = 7527,
		name = <<"牛金牛">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4051,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7528) ->
	#bmon_group{
		no = 7528,
		name = <<"氐土貉">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4052,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7529) ->
	#bmon_group{
		no = 7529,
		name = <<"虚日鼠">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4053,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7530) ->
	#bmon_group{
		no = 7530,
		name = <<"危月燕">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4054,1},{4020,2},{4020,3},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4024,4027
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7531) ->
	#bmon_group{
		no = 7531,
		name = <<"室火猪">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4055,1},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4023, 4024, 4025, 4026, 4027, 4028
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7532) ->
	#bmon_group{
		no = 7532,
		name = <<"壁水柱">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4056,1},{4021,6},{4021,7},{4021,8},{4021,9},{4021,10}],
		mon_pool_normal = [4023, 4024, 4025, 4026, 4027, 4028
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7533) ->
	#bmon_group{
		no = 7533,
		name = <<"角木蛟之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4062,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7534) ->
	#bmon_group{
		no = 7534,
		name = <<"亢金龙之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4063,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7535) ->
	#bmon_group{
		no = 7535,
		name = <<"女士蝠之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4064,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7536) ->
	#bmon_group{
		no = 7536,
		name = <<"房日兔之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4065,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7537) ->
	#bmon_group{
		no = 7537,
		name = <<"心月狐之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4066,1},{4090,2},{4090,3},{4090,4},{4090,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7538) ->
	#bmon_group{
		no = 7538,
		name = <<"尾火虎之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4067,1},{4090,2},{4090,3},{4090,4},{4090,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7539) ->
	#bmon_group{
		no = 7539,
		name = <<"箕水豹之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4068,1},{4090,2},{4090,3},{4090,4},{4090,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7540) ->
	#bmon_group{
		no = 7540,
		name = <<"奎木狼之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4069,1},{4090,2},{4090,3},{4090,4},{4090,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7541) ->
	#bmon_group{
		no = 7541,
		name = <<"娄金狗之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4070,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7542) ->
	#bmon_group{
		no = 7542,
		name = <<"胃土雉之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4071,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7543) ->
	#bmon_group{
		no = 7543,
		name = <<"昂日鸡之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4072,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7544) ->
	#bmon_group{
		no = 7544,
		name = <<"毕月乌之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4073,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7545) ->
	#bmon_group{
		no = 7545,
		name = <<"觜火猴之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4074,1},{4090,2},{4090,3},{4090,4},{4090,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7546) ->
	#bmon_group{
		no = 7546,
		name = <<"参水猿之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4075,1},{4090,2},{4090,3},{4090,4},{4090,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7547) ->
	#bmon_group{
		no = 7547,
		name = <<"井木犴之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4076,1},{4090,2},{4090,3},{4090,4},{4090,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7548) ->
	#bmon_group{
		no = 7548,
		name = <<"鬼金羊之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4077,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7549) ->
	#bmon_group{
		no = 7549,
		name = <<"柳土獐之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4078,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7550) ->
	#bmon_group{
		no = 7550,
		name = <<"星日马之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4079,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7551) ->
	#bmon_group{
		no = 7551,
		name = <<"张月鹿之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4080,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7552) ->
	#bmon_group{
		no = 7552,
		name = <<"翼火蛇之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4081,1},{4090,2},{4090,3},{4090,4},{4090,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7553) ->
	#bmon_group{
		no = 7553,
		name = <<"轸水蚓之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4082,1},{4090,2},{4090,3},{4090,4},{4090,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7554) ->
	#bmon_group{
		no = 7554,
		name = <<"斗木獬之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4083,1},{4090,2},{4090,3},{4090,4},{4090,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7555) ->
	#bmon_group{
		no = 7555,
		name = <<"牛金牛之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4084,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7556) ->
	#bmon_group{
		no = 7556,
		name = <<"氐土貉之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4085,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7557) ->
	#bmon_group{
		no = 7557,
		name = <<"虚日鼠之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4086,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7558) ->
	#bmon_group{
		no = 7558,
		name = <<"危月燕之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4087,1},{4090,2},{4090,3},{4091,4},{4091,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7559) ->
	#bmon_group{
		no = 7559,
		name = <<"室火猪之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4088,1},{4090,2},{4090,3},{4090,4},{4090,5}],
		mon_pool_normal = [4092, 4095
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7560) ->
	#bmon_group{
		no = 7560,
		name = <<"壁水柱之怒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{4089,1},{4090,2},{4090,3},{4090,4},{4090,5}],
		mon_pool_normal = [4092, 4095, 4093, 4094, 4096, 4097
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(7561) ->
	#bmon_group{
		no = 7561,
		name = <<"财神送礼">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{90158,1}],
		mon_pool_normal = [90156, 90157
],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(10101) ->
	#bmon_group{
		no = 10101,
		name = <<"运营节日活动">>,
		lv_range_min = 20,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 1,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{20001,1}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(11001) ->
	#bmon_group{
		no = 11001,
		name = <<"挖宝">>,
		lv_range_min = 20,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{58014, 1}, {58013,2}, {58013,3}, {58013,4}],
		mon_pool_normal = [58013, 58013],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(11601) ->
	#bmon_group{
		no = 11601,
		name = <<"藏宝图任务">>,
		lv_range_min = 25,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 3,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{58013, 2},{58013, 3}],
		mon_pool_normal = [58001,58002,58003,58004,58005,58006,58007,58008,58009,58010,58011,58012],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(13200) ->
	#bmon_group{
		no = 13200,
		name = <<"25级经验任务">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30100, 1}, {30101, 2}, {30102, 3}, {30103, 4}],
		mon_pool_normal = [30101, 30102],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(13201) ->
	#bmon_group{
		no = 13201,
		name = <<"35级经验任务">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30104, 1}, {30105, 2}, {30106, 3}, {30107, 4}, {30108, 5}],
		mon_pool_normal = [30105, 30106],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(13202) ->
	#bmon_group{
		no = 13202,
		name = <<"40级经验任务">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30109, 1}, {30110, 2}, {30111, 3}, {30112, 4}, {30113, 5}, {30114, 6}],
		mon_pool_normal = [30110, 30111],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(13203) ->
	#bmon_group{
		no = 13203,
		name = <<"45级经验任务">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30115, 1}, {30116, 2}, {30117, 3}, {30118, 4}, {30119, 5}, {30120, 6}],
		mon_pool_normal = [30116, 30117],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(13204) ->
	#bmon_group{
		no = 13204,
		name = <<"50级经验任务">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30121, 1}, {30122, 2}, {30123, 3}, {30124, 4}, {30125, 5}, {30126, 6}],
		mon_pool_normal = [30122, 30123],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(20001) ->
	#bmon_group{
		no = 20001,
		name = <<"挖宝测试怪">>,
		lv_range_min = 34,
		lv_range_max = 39,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30001,1},{2421,2}],
		mon_pool_normal = [2420, 2421, 2422, 2423, 2424],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(200001) ->
	#bmon_group{
		no = 200001,
		name = <<"测试">>,
		lv_range_min = 0,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30127,1},{30127,2},{30127,3},{30127,4},{30127,5},{30127,6},{30127,7},{30127,8},{30127,9},{30127,10}],
		mon_pool_normal = [30127, 30127],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(200002) ->
	#bmon_group{
		no = 200002,
		name = <<"60-69级殴打策划怪物类型A难度高">>,
		lv_range_min = 60,
		lv_range_max = 69,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30128,1},{30129,2},{30130,3},{30131,4},{30132,5},{30133,6},{30134,7},{30135,8},{30136,9},{30137,10}],
		mon_pool_normal = [30129, 30130],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(200003) ->
	#bmon_group{
		no = 200003,
		name = <<"70-79级殴打策划怪物类型A难度高">>,
		lv_range_min = 70,
		lv_range_max = 79,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30138,1},{30139,2},{30140,3},{30141,4},{30142,5},{30143,6},{30144,7},{30145,8},{30146,9},{30147,10}],
		mon_pool_normal = [30139, 30140],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(200004) ->
	#bmon_group{
		no = 200004,
		name = <<"80-89级殴打策划怪物类型A难度高">>,
		lv_range_min = 80,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30148,1},{30149,2},{30150,3},{30151,4},{30152,5},{30153,6},{30154,7},{30155,8},{30156,9},{30157,10}],
		mon_pool_normal = [30149, 30150],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(200005) ->
	#bmon_group{
		no = 200005,
		name = <<"60-69级殴打策划怪物类型B难度中">>,
		lv_range_min = 60,
		lv_range_max = 69,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30158,1},{30159,6}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(200006) ->
	#bmon_group{
		no = 200006,
		name = <<"70-79级殴打策划怪物类型B难度中">>,
		lv_range_min = 70,
		lv_range_max = 79,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30160,1},{30161,6}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(200007) ->
	#bmon_group{
		no = 200007,
		name = <<"80-89级殴打策划怪物类型B难度中">>,
		lv_range_min = 80,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30162,1},{30163,6}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(200008) ->
	#bmon_group{
		no = 200008,
		name = <<"60-69级殴打策划怪物类型C难度低">>,
		lv_range_min = 60,
		lv_range_max = 69,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30164,1},{30165,2},{30166,3},{30167,4},{30168,5},{30169,6},{30170,7},{30171,8},{30172,9},{30173,10}],
		mon_pool_normal = [30165, 30166],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(200009) ->
	#bmon_group{
		no = 200009,
		name = <<"70-79级殴打策划怪物类型C难度低">>,
		lv_range_min = 70,
		lv_range_max = 79,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30174,1},{30175,2},{30176,3},{30177,4},{30178,5},{30179,6},{30180,7},{30181,8},{30182,9},{30183,10}],
		mon_pool_normal = [30175, 30176],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(200010) ->
	#bmon_group{
		no = 200010,
		name = <<"80-89级殴打策划怪物类型C难度低">>,
		lv_range_min = 80,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30184,1},{30185,2},{30186,3},{30187,4},{30188,5},{30189,6},{30190,7},{30191,8},{30192,9},{30193,10}],
		mon_pool_normal = [30185, 30186],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(200011) ->
	#bmon_group{
		no = 200011,
		name = <<"测试">>,
		lv_range_min = 0,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{30194,1},{30195,2},{30196,3},{30197,4},{30198,5},{30199,6}],
		mon_pool_normal = [30195, 30196],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300001) ->
	#bmon_group{
		no = 300001,
		name = <<"杀身鬼">>,
		lv_range_min = 25,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40001,1} ],
		mon_pool_normal = [50001, 50002, 50003, 50004, 50005, 50006, 50007, 50008, 50009, 50010, 50011, 50012, 50013, 50014],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300002) ->
	#bmon_group{
		no = 300002,
		name = <<"针口鬼">>,
		lv_range_min = 25,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40002,1} ],
		mon_pool_normal = [50001, 50002, 50003, 50004, 50005, 50006, 50007, 50008, 50009, 50010, 50011, 50012, 50013, 50014],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300003) ->
	#bmon_group{
		no = 300003,
		name = <<"炽燃鬼">>,
		lv_range_min = 25,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40003,1} ],
		mon_pool_normal = [50001, 50002, 50003, 50004, 50005, 50006, 50007, 50008, 50009, 50010, 50011, 50012, 50013, 50014],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300004) ->
	#bmon_group{
		no = 300004,
		name = <<"食肉鬼">>,
		lv_range_min = 25,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40004,1} ],
		mon_pool_normal = [50001, 50002, 50003, 50004, 50005, 50006, 50007, 50008, 50009, 50010, 50011, 50012, 50013, 50014],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300005) ->
	#bmon_group{
		no = 300005,
		name = <<"食法鬼">>,
		lv_range_min = 25,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40005,1} ],
		mon_pool_normal = [50001, 50002, 50003, 50004, 50005, 50006, 50007, 50008, 50009, 50010, 50011, 50012, 50013, 50014],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300006) ->
	#bmon_group{
		no = 300006,
		name = <<"食气鬼">>,
		lv_range_min = 25,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40006,1} ],
		mon_pool_normal = [50001, 50002, 50003, 50004, 50005, 50006, 50007, 50008, 50009, 50010, 50011, 50012, 50013, 50014],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300007) ->
	#bmon_group{
		no = 300007,
		name = <<"疾行鬼">>,
		lv_range_min = 25,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40007,1} ],
		mon_pool_normal = [50001, 50002, 50003, 50004, 50005, 50006, 50007, 50008, 50009, 50010, 50011, 50012, 50013, 50014],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300008) ->
	#bmon_group{
		no = 300008,
		name = <<"恶鬼罗刹">>,
		lv_range_min = 25,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40008,1} ],
		mon_pool_normal = [50001, 50002, 50003, 50004, 50005, 50006, 50007, 50008, 50009, 50010, 50011, 50012, 50013, 50014],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300011) ->
	#bmon_group{
		no = 300011,
		name = <<"杀身鬼王">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40011,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300012) ->
	#bmon_group{
		no = 300012,
		name = <<"针口鬼王">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40012,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300013) ->
	#bmon_group{
		no = 300013,
		name = <<"炽燃鬼王">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40013,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300014) ->
	#bmon_group{
		no = 300014,
		name = <<"食肉鬼王">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40014,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300015) ->
	#bmon_group{
		no = 300015,
		name = <<"食法鬼王">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40015,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300016) ->
	#bmon_group{
		no = 300016,
		name = <<"食气鬼王">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40016,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300017) ->
	#bmon_group{
		no = 300017,
		name = <<"疾行鬼王">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40017,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(300018) ->
	#bmon_group{
		no = 300018,
		name = <<"恶鬼王">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.385000,
		mon_pool_fixed = [{40018,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(400001) ->
	#bmon_group{
		no = 400001,
		name = <<"宝库陵墓（南乡花海）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70001,70004,70007],
		mon_pool_chief = [{70002,0.02},{70005,0.02},{70008,0.02}],
		mon_pool_elite = [{70003,0.008},{70006,0.008},{70009,0.008}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400002) ->
	#bmon_group{
		no = 400002,
		name = <<"上古迷宫（东郊皇陵）1层（20-29）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70010,70011 ,70012 ],
		mon_pool_chief = [{70019,0.002} ,{70020,0.002} ,{70021,0.002}],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400003) ->
	#bmon_group{
		no = 400003,
		name = <<"上古迷宫（东郊皇陵）2层（20-29）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70013,70014 ,70015],
		mon_pool_chief = [{70019,0.005} ,{70020,0.005} ,{70021,0.005}],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400004) ->
	#bmon_group{
		no = 400004,
		name = <<"上古迷宫（东郊皇陵）3层（20-29）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70016,70017 ,70018],
		mon_pool_chief = [{70019,0.01} ,{70020,0.01} ,{70021,0.01}],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400005) ->
	#bmon_group{
		no = 400005,
		name = <<"赵国监牢（长安西岭南）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70022,70025,70028,70031],
		mon_pool_chief = [{70023,0.01} ,{70026,0.01}, {70029,0.01} ,{70032,0.01}],
		mon_pool_elite = [{70024,0.002} ,{70027,0.002},{70030,0.002} ,{70033,0.002}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400006) ->
	#bmon_group{
		no = 400006,
		name = <<"赵家私牢（千狐影洞）1层（30-39）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70034,70037],
		mon_pool_chief = [{70035,0.01} ,{70038,0.01}],
		mon_pool_elite = [{70036,0.005} ,{70039,0.005}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400007) ->
	#bmon_group{
		no = 400007,
		name = <<"赵家私牢（千狐影洞）2层（30-39）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70037,70040],
		mon_pool_chief = [{70038,0.01} ,{70041,0.01}],
		mon_pool_elite = [{70039,0.005} ,{70042,0.005}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400008) ->
	#bmon_group{
		no = 400008,
		name = <<"赵家私牢（千狐影洞）3层（30-39）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70034,70037,70040],
		mon_pool_chief = [{70035,0.01} ,{70038,0.01} ,{70041,0.01}],
		mon_pool_elite = [{70036,0.005} ,{70039,0.005} ,{70042,0.005}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400009) ->
	#bmon_group{
		no = 400009,
		name = <<"赵家私牢（千狐影洞）1层（40-49）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70043,70046],
		mon_pool_chief = [{70043,0.01} ,{70046,0.01}],
		mon_pool_elite = [{70043,0.005} ,{70046,0.005}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400010) ->
	#bmon_group{
		no = 400010,
		name = <<"赵家私牢（千狐影洞）2层（40-49）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70046,70049],
		mon_pool_chief = [{70046,0.01} ,{70049,0.01}],
		mon_pool_elite = [{70046,0.005} ,{70049,0.005}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400011) ->
	#bmon_group{
		no = 400011,
		name = <<"赵家私牢（千狐影洞）3层（40-49）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70043,70046,70049],
		mon_pool_chief = [{70043,0.01} ,{70046,0.01} ,{70049,0.01}],
		mon_pool_elite = [{70043,0.005} ,{70046,0.005} ,{70049,0.005}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400012) ->
	#bmon_group{
		no = 400012,
		name = <<"幽曲小径（长安西岭北）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70052,70055,70058],
		mon_pool_chief = [{70053,0.05} ,{70056,0.05} ,{70059,0.05}],
		mon_pool_elite = [{70054,0.01} ,{70057,0.01} ,{70060,0.01}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400013) ->
	#bmon_group{
		no = 400013,
		name = <<"粮草营地（龙楼宝阁）1层">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70061,70064],
		mon_pool_chief = [{70062,0.01} ,{70065,0.01}],
		mon_pool_elite = [{70063,0.01} ,{70066,0.01}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400014) ->
	#bmon_group{
		no = 400014,
		name = <<"粮草营地（龙楼宝阁）2层">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70064,70067],
		mon_pool_chief = [{70065,0.01} ,{70068,0.01}],
		mon_pool_elite = [{70066,0.01} ,{70069,0.01}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400015) ->
	#bmon_group{
		no = 400015,
		name = <<"粮草营地（龙楼宝阁）3层">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70061,70064,70067],
		mon_pool_chief = [{70062,0.01} ,{70065,0.01} ,{70068,0.01}],
		mon_pool_elite = [{70063,0.01} ,{70066,0.01} ,{70069,0.01}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400016) ->
	#bmon_group{
		no = 400016,
		name = <<"秦国宿营（东海龙域）">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70070,70073,70076],
		mon_pool_chief = [{70071,0.01} ,{70074,0.01} ,{70077,0.01}],
		mon_pool_elite = [{70072,0.01} ,{70075,0.01} ,{70078,0.01}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400017) ->
	#bmon_group{
		no = 400017,
		name = <<"海底世界1层">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70088,70091],
		mon_pool_chief = [{70089,0.01} ,{70092,0.01}],
		mon_pool_elite = [{70090,0.01} ,{70093,0.01}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400018) ->
	#bmon_group{
		no = 400018,
		name = <<"海底世界2层">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70091,70094],
		mon_pool_chief = [{70092,0.01} ,{70095,0.01}],
		mon_pool_elite = [{70093,0.01} ,{70096,0.01}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400019) ->
	#bmon_group{
		no = 400019,
		name = <<"海底世界3层">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70088,70091,70094],
		mon_pool_chief = [{70089,0.01} ,{70092,0.01} ,{70095,0.01}],
		mon_pool_elite = [{70090,0.01} ,{70093,0.01} ,{70096,0.01}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(400020) ->
	#bmon_group{
		no = 400020,
		name = <<"东海神殿">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [],
		mon_pool_normal = [70079,70082,70085],
		mon_pool_chief = [{70080,0.01} ,{70083,0.01} ,{70086,0.01}],
		mon_pool_elite = [{70081,0.01} ,{70084,0.01} ,{70087,0.01}],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 1,
		zf_no = 0
};

get(504100) ->
	#bmon_group{
		no = 504100,
		name = <<"30级装备副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.400000,
		mon_pool_fixed = [{56001,1}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504101) ->
	#bmon_group{
		no = 504101,
		name = <<"30级装备副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{56001,1},{56001,2}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504102) ->
	#bmon_group{
		no = 504102,
		name = <<"30级装备副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{56001,1},{56001,2}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504103) ->
	#bmon_group{
		no = 504103,
		name = <<"50级装备副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.400000,
		mon_pool_fixed = [{56006,1},{56011,2},{56007,3},{56008,4}],
		mon_pool_normal = [56011, 56007],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 2,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504104) ->
	#bmon_group{
		no = 504104,
		name = <<"50级装备副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{56006,1},{56011,2},{56007,3},{56008,4}],
		mon_pool_normal = [56011, 56007],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 3,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504105) ->
	#bmon_group{
		no = 504105,
		name = <<"50级装备副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{56006,1},{56011,2},{56007,3},{56008,4}],
		mon_pool_normal = [56011, 56007],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 4,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504106) ->
	#bmon_group{
		no = 504106,
		name = <<"25级门客副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 0.400000,
		mon_pool_fixed = [{56041,1},{56042,2}],
		mon_pool_normal = [56016, 56017, 56018],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504107) ->
	#bmon_group{
		no = 504107,
		name = <<"25级门客副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{56041,1},{56042,2}],
		mon_pool_normal = [56019, 56020, 56021],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504108) ->
	#bmon_group{
		no = 504108,
		name = <<"25级门客副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{56041,1},{56042,2}],
		mon_pool_normal = [56022, 56023, 56024, 56025],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504109) ->
	#bmon_group{
		no = 504109,
		name = <<"45级门客副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.400000,
		mon_pool_fixed = [{90272,1},{90273,2}],
		mon_pool_normal = [56022, 56023, 56024, 56025],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504110) ->
	#bmon_group{
		no = 504110,
		name = <<"45级门客副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{90272,1},{90273,2}],
		mon_pool_normal = [56026, 56027, 56028, 56029],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504111) ->
	#bmon_group{
		no = 504111,
		name = <<"45级门客副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90272,1},{90273,2}],
		mon_pool_normal = [56030, 56031, 56032, 56033],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504112) ->
	#bmon_group{
		no = 504112,
		name = <<"65级门客副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.400000,
		mon_pool_fixed = [{90274,1},{90275,2}],
		mon_pool_normal = [56030, 56031, 56032, 56033],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504113) ->
	#bmon_group{
		no = 504113,
		name = <<"65级门客副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{90274,1},{90275,2}],
		mon_pool_normal = [56034, 56035, 56037, 56036],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504114) ->
	#bmon_group{
		no = 504114,
		name = <<"65级门客副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90274,1},{90275,2}],
		mon_pool_normal = [56038, 56039, 56040, 56037],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504115) ->
	#bmon_group{
		no = 504115,
		name = <<"80级装备副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36027,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504116) ->
	#bmon_group{
		no = 504116,
		name = <<"80级装备副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36028,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504117) ->
	#bmon_group{
		no = 504117,
		name = <<"80级装备副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36029,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504118) ->
	#bmon_group{
		no = 504118,
		name = <<"80级装备副本怪物组4">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36030,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504119) ->
	#bmon_group{
		no = 504119,
		name = <<"80级装备副本怪物组5">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36031,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504120) ->
	#bmon_group{
		no = 504120,
		name = <<"80级装备副本怪物组6">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36032,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504121) ->
	#bmon_group{
		no = 504121,
		name = <<"80级装备副本怪物组7">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36033,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504122) ->
	#bmon_group{
		no = 504122,
		name = <<"80级装备副本怪物组8">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36034,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504123) ->
	#bmon_group{
		no = 504123,
		name = <<"80级装备副本怪物组9">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36035,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504124) ->
	#bmon_group{
		no = 504124,
		name = <<"80级门客副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36036,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504125) ->
	#bmon_group{
		no = 504125,
		name = <<"80级门客副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36037,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504126) ->
	#bmon_group{
		no = 504126,
		name = <<"80级门客副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36038,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504127) ->
	#bmon_group{
		no = 504127,
		name = <<"80级门客副本怪物组4">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36039,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504128) ->
	#bmon_group{
		no = 504128,
		name = <<"80级门客副本怪物组5">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36040,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504129) ->
	#bmon_group{
		no = 504129,
		name = <<"80级门客副本怪物组6">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36041,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504130) ->
	#bmon_group{
		no = 504130,
		name = <<"80级门客副本怪物组7">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36042,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504131) ->
	#bmon_group{
		no = 504131,
		name = <<"80级门客副本怪物组8">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36043,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504132) ->
	#bmon_group{
		no = 504132,
		name = <<"80级门客副本怪物组9">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36044,1}],
		mon_pool_normal = [36055, 36056, 36057, 36058, 36059, 36060, 36061],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504133) ->
	#bmon_group{
		no = 504133,
		name = <<"100级装备副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90011,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504134) ->
	#bmon_group{
		no = 504134,
		name = <<"100级装备副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90012,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504135) ->
	#bmon_group{
		no = 504135,
		name = <<"100级装备副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90013,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504136) ->
	#bmon_group{
		no = 504136,
		name = <<"100级装备副本怪物组4">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90014,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504137) ->
	#bmon_group{
		no = 504137,
		name = <<"100级装备副本怪物组5">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90015,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504138) ->
	#bmon_group{
		no = 504138,
		name = <<"100级装备副本怪物组6">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90016,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504139) ->
	#bmon_group{
		no = 504139,
		name = <<"100级装备副本怪物组7">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90017,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504140) ->
	#bmon_group{
		no = 504140,
		name = <<"100级装备副本怪物组8">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90018,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504141) ->
	#bmon_group{
		no = 504141,
		name = <<"100级装备副本怪物组9">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90019,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504142) ->
	#bmon_group{
		no = 504142,
		name = <<"100级门客副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90020,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504143) ->
	#bmon_group{
		no = 504143,
		name = <<"100级门客副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90021,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504144) ->
	#bmon_group{
		no = 504144,
		name = <<"100级门客副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90022,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504145) ->
	#bmon_group{
		no = 504145,
		name = <<"100级门客副本怪物组4">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90023,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504146) ->
	#bmon_group{
		no = 504146,
		name = <<"100级门客副本怪物组5">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90024,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504147) ->
	#bmon_group{
		no = 504147,
		name = <<"100级门客副本怪物组6">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90025,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504148) ->
	#bmon_group{
		no = 504148,
		name = <<"100级门客副本怪物组7">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90026,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504149) ->
	#bmon_group{
		no = 504149,
		name = <<"100级门客副本怪物组8">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90027,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(504150) ->
	#bmon_group{
		no = 504150,
		name = <<"100级门客副本怪物组9">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90028,1}],
		mon_pool_normal = [36062, 36063, 36064, 36065, 36066, 36067, 36068],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505001) ->
	#bmon_group{
		no = 505001,
		name = <<"10级紫色BB">>,
		lv_range_min = 10,
		lv_range_max = 19,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{ 55015, 1}],
		mon_pool_normal = [58023],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505002) ->
	#bmon_group{
		no = 505002,
		name = <<"20级紫色BB">>,
		lv_range_min = 20,
		lv_range_max = 29,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{ 55016, 1}],
		mon_pool_normal = [58024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505003) ->
	#bmon_group{
		no = 505003,
		name = <<"30级紫色BB">>,
		lv_range_min = 30,
		lv_range_max = 39,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{ 55017, 1}],
		mon_pool_normal = [58025],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505004) ->
	#bmon_group{
		no = 505004,
		name = <<"40级紫色BB">>,
		lv_range_min = 40,
		lv_range_max = 49,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{ 55018, 1}],
		mon_pool_normal = [58026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505005) ->
	#bmon_group{
		no = 505005,
		name = <<"50级紫色BB">>,
		lv_range_min = 50,
		lv_range_max = 59,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{ 55019, 1}],
		mon_pool_normal = [58027],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505006) ->
	#bmon_group{
		no = 505006,
		name = <<"60级紫色BB">>,
		lv_range_min = 60,
		lv_range_max = 69,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{ 55020, 1}],
		mon_pool_normal = [58028],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505007) ->
	#bmon_group{
		no = 505007,
		name = <<"70级紫色BB">>,
		lv_range_min = 70,
		lv_range_max = 79,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{ 55021, 1}],
		mon_pool_normal = [58029],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505008) ->
	#bmon_group{
		no = 505008,
		name = <<"80级紫色BB">>,
		lv_range_min = 80,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{ 55022, 1}],
		mon_pool_normal = [58030],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505009) ->
	#bmon_group{
		no = 505009,
		name = <<"20级妖王">>,
		lv_range_min = 20,
		lv_range_max = 29,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{55004, 1},{55004, 2},{55004, 3},{55005, 4},{55005, 5},{55005, 6},{55006, 7},{55006, 8},{55006, 9}],
		mon_pool_normal = [55004, 55004],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505010) ->
	#bmon_group{
		no = 505010,
		name = <<"30级妖王">>,
		lv_range_min = 30,
		lv_range_max = 39,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{55004, 1},{55004, 2},{55004, 3},{55005, 4},{55005, 5},{55005, 6},{55006, 7},{55006, 8},{55006, 9}],
		mon_pool_normal = [55004, 55004],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505011) ->
	#bmon_group{
		no = 505011,
		name = <<"40级妖王">>,
		lv_range_min = 40,
		lv_range_max = 49,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.400000,
		mon_pool_fixed = [{55004, 1},{55004, 2},{55004, 3},{55005, 4},{55005, 5},{55005, 6},{55006, 7},{55006, 8},{55006, 9}],
		mon_pool_normal = [55004, 55004],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505012) ->
	#bmon_group{
		no = 505012,
		name = <<"50级妖王">>,
		lv_range_min = 50,
		lv_range_max = 59,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{55004, 1},{55004, 2},{55004, 3},{55005, 4},{55005, 5},{55005, 6},{55006, 7},{55006, 8},{55006, 9}],
		mon_pool_normal = [55004, 55004],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505013) ->
	#bmon_group{
		no = 505013,
		name = <<"60级妖王">>,
		lv_range_min = 60,
		lv_range_max = 69,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.600000,
		mon_pool_fixed = [{55004, 1},{55004, 2},{55004, 3},{55005, 4},{55005, 5},{55005, 6},{55006, 7},{55006, 8},{55006, 9}],
		mon_pool_normal = [55004, 55004],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505014) ->
	#bmon_group{
		no = 505014,
		name = <<"70级妖王">>,
		lv_range_min = 70,
		lv_range_max = 79,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{55004, 1},{55004, 2},{55004, 3},{55005, 4},{55005, 5},{55005, 6},{55006, 7},{55006, 8},{55006, 9}],
		mon_pool_normal = [55004, 55004],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505015) ->
	#bmon_group{
		no = 505015,
		name = <<"80级妖王">>,
		lv_range_min = 80,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{55004, 1},{55004, 2},{55004, 3},{55005, 4},{55005, 5},{55005, 6},{55006, 7},{55006, 8},{55006, 9}],
		mon_pool_normal = [55004, 55004],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505016) ->
	#bmon_group{
		no = 505016,
		name = <<"10级蓝色BB">>,
		lv_range_min = 10,
		lv_range_max = 19,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{55007 ,1}],
		mon_pool_normal = [58015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505017) ->
	#bmon_group{
		no = 505017,
		name = <<"20级蓝色BB">>,
		lv_range_min = 20,
		lv_range_max = 29,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{55008 ,1}],
		mon_pool_normal = [58016],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505018) ->
	#bmon_group{
		no = 505018,
		name = <<"30级蓝色BB">>,
		lv_range_min = 30,
		lv_range_max = 39,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{55009 ,1}],
		mon_pool_normal = [58017],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505019) ->
	#bmon_group{
		no = 505019,
		name = <<"40级蓝色BB">>,
		lv_range_min = 40,
		lv_range_max = 49,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{55010 ,1}],
		mon_pool_normal = [58018],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505020) ->
	#bmon_group{
		no = 505020,
		name = <<"50级蓝色BB">>,
		lv_range_min = 50,
		lv_range_max = 59,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{55011 ,1}],
		mon_pool_normal = [58019],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505021) ->
	#bmon_group{
		no = 505021,
		name = <<"60级蓝色BB">>,
		lv_range_min = 60,
		lv_range_max = 69,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{55012 ,1}],
		mon_pool_normal = [58020],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505022) ->
	#bmon_group{
		no = 505022,
		name = <<"70级蓝色BB">>,
		lv_range_min = 70,
		lv_range_max = 79,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{55013 ,1}],
		mon_pool_normal = [58021],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505023) ->
	#bmon_group{
		no = 505023,
		name = <<"80级蓝色BB">>,
		lv_range_min = 80,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{55014 ,1}],
		mon_pool_normal = [58022],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505024) ->
	#bmon_group{
		no = 505024,
		name = <<"20级小妖">>,
		lv_range_min = 20,
		lv_range_max = 29,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{55003, 1},{55001, 2},{55002, 3},{55001, 3},{55002, 4}],
		mon_pool_normal = [55001, 55002],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505025) ->
	#bmon_group{
		no = 505025,
		name = <<"30级小妖">>,
		lv_range_min = 30,
		lv_range_max = 39,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.400000,
		mon_pool_fixed = [{55003, 1},{55001, 2},{55002, 3},{55001, 3},{55002, 4}],
		mon_pool_normal = [55001, 55002],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505026) ->
	#bmon_group{
		no = 505026,
		name = <<"40级小妖">>,
		lv_range_min = 40,
		lv_range_max = 49,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{55003, 1},{55001, 2},{55002, 3},{55001, 3},{55002, 4}],
		mon_pool_normal = [55001, 55002],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505027) ->
	#bmon_group{
		no = 505027,
		name = <<"50级小妖">>,
		lv_range_min = 50,
		lv_range_max = 59,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.600000,
		mon_pool_fixed = [{55003, 1},{55001, 2},{55002, 3},{55001, 3},{55002, 4}],
		mon_pool_normal = [55001, 55002],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505028) ->
	#bmon_group{
		no = 505028,
		name = <<"60级小妖">>,
		lv_range_min = 60,
		lv_range_max = 69,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{55003, 1},{55001, 2},{55002, 3},{55001, 3},{55002, 4}],
		mon_pool_normal = [55001, 55002],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505029) ->
	#bmon_group{
		no = 505029,
		name = <<"70级小妖">>,
		lv_range_min = 70,
		lv_range_max = 79,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{55003, 1},{55001, 2},{55002, 3},{55001, 3},{55002, 4}],
		mon_pool_normal = [55001, 55002],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505030) ->
	#bmon_group{
		no = 505030,
		name = <<"80级小妖">>,
		lv_range_min = 80,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{55003, 1},{55001, 2},{55002, 3},{55001, 3},{55002, 4}],
		mon_pool_normal = [55001, 55002],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505031) ->
	#bmon_group{
		no = 505031,
		name = <<"墨家赋闲弟子">>,
		lv_range_min = 28,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{55023, 1}],
		mon_pool_normal = [55035, 55036 ],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505032) ->
	#bmon_group{
		no = 505032,
		name = <<"兵家赋闲弟子">>,
		lv_range_min = 28,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{55024, 1}],
		mon_pool_normal = [55035, 55036],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505033) ->
	#bmon_group{
		no = 505033,
		name = <<"道家赋闲弟子">>,
		lv_range_min = 28,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{55025, 1}],
		mon_pool_normal = [55035, 55036 ],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505034) ->
	#bmon_group{
		no = 505034,
		name = <<"儒家赋闲弟子">>,
		lv_range_min = 28,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{55026, 1}],
		mon_pool_normal = [55035, 55036],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505038) ->
	#bmon_group{
		no = 505038,
		name = <<"阴阳赋闲弟子">>,
		lv_range_min = 28,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{55033, 1}],
		mon_pool_normal = [55035, 55036],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505039) ->
	#bmon_group{
		no = 505039,
		name = <<"法家赋闲弟子">>,
		lv_range_min = 28,
		lv_range_max = 89,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{55034, 1}],
		mon_pool_normal = [55035, 55036],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505035) ->
	#bmon_group{
		no = 505035,
		name = <<"70级装备副本普通难度">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.400000,
		mon_pool_fixed = [{36001,1},{36002,2},{36003,3},{36004,4},{36005 ,5},{36007 ,6},{36008 ,7},{36006 ,8}],
		mon_pool_normal = [36002, 36003],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505036) ->
	#bmon_group{
		no = 505036,
		name = <<"70级装备副本困难难度">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{36009,1},{36012,2},{36011,3},{36013,4},{36010 ,5},{36014 ,6}],
		mon_pool_normal = [36012, 36011],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(505037) ->
	#bmon_group{
		no = 505037,
		name = <<"70级装备副本卓越难度">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 2,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{36015,1}],
		mon_pool_normal = [36016,36017, 36018],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350001) ->
	#bmon_group{
		no = 350001,
		name = <<"帮派副本第1层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.010000,
		mon_pool_fixed = [{35001,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350002) ->
	#bmon_group{
		no = 350002,
		name = <<"帮派副本第2层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.020000,
		mon_pool_fixed = [{35002,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350003) ->
	#bmon_group{
		no = 350003,
		name = <<"帮派副本第3层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.030000,
		mon_pool_fixed = [{35003,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350004) ->
	#bmon_group{
		no = 350004,
		name = <<"帮派副本第4层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.040000,
		mon_pool_fixed = [{35004,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350005) ->
	#bmon_group{
		no = 350005,
		name = <<"帮派副本第5层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.050000,
		mon_pool_fixed = [{35005,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350006) ->
	#bmon_group{
		no = 350006,
		name = <<"帮派副本第6层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.060000,
		mon_pool_fixed = [{35006,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350007) ->
	#bmon_group{
		no = 350007,
		name = <<"帮派副本第7层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.070000,
		mon_pool_fixed = [{35007,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350008) ->
	#bmon_group{
		no = 350008,
		name = <<"帮派副本第8层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{35008,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350009) ->
	#bmon_group{
		no = 350009,
		name = <<"帮派副本第9层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{35009,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350010) ->
	#bmon_group{
		no = 350010,
		name = <<"帮派副本第10层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.100000,
		mon_pool_fixed = [{35010,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350011) ->
	#bmon_group{
		no = 350011,
		name = <<"帮派副本第11层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.110000,
		mon_pool_fixed = [{35001,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350012) ->
	#bmon_group{
		no = 350012,
		name = <<"帮派副本第12层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.110000,
		mon_pool_fixed = [{35002,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350013) ->
	#bmon_group{
		no = 350013,
		name = <<"帮派副本第13层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.130000,
		mon_pool_fixed = [{35003,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350014) ->
	#bmon_group{
		no = 350014,
		name = <<"帮派副本第14层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.130000,
		mon_pool_fixed = [{35004,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350015) ->
	#bmon_group{
		no = 350015,
		name = <<"帮派副本第15层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.160000,
		mon_pool_fixed = [{35005,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350016) ->
	#bmon_group{
		no = 350016,
		name = <<"帮派副本第16层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.160000,
		mon_pool_fixed = [{35006,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350017) ->
	#bmon_group{
		no = 350017,
		name = <<"帮派副本第17层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.170000,
		mon_pool_fixed = [{35007,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350018) ->
	#bmon_group{
		no = 350018,
		name = <<"帮派副本第18层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.180000,
		mon_pool_fixed = [{35008,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350019) ->
	#bmon_group{
		no = 350019,
		name = <<"帮派副本第19层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.180000,
		mon_pool_fixed = [{35009,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350020) ->
	#bmon_group{
		no = 350020,
		name = <<"帮派副本第20层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{35010,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350021) ->
	#bmon_group{
		no = 350021,
		name = <<"帮派副本第21层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{35001,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350022) ->
	#bmon_group{
		no = 350022,
		name = <<"帮派副本第22层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.210000,
		mon_pool_fixed = [{35002,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350023) ->
	#bmon_group{
		no = 350023,
		name = <<"帮派副本第23层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.230000,
		mon_pool_fixed = [{35003,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350024) ->
	#bmon_group{
		no = 350024,
		name = <<"帮派副本第24层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.230000,
		mon_pool_fixed = [{35004,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350025) ->
	#bmon_group{
		no = 350025,
		name = <<"帮派副本第25层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.250000,
		mon_pool_fixed = [{35005,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350026) ->
	#bmon_group{
		no = 350026,
		name = <<"帮派副本第26层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.250000,
		mon_pool_fixed = [{35006,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350027) ->
	#bmon_group{
		no = 350027,
		name = <<"帮派副本第27层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.270000,
		mon_pool_fixed = [{35007,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350028) ->
	#bmon_group{
		no = 350028,
		name = <<"帮派副本第28层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.270000,
		mon_pool_fixed = [{35008,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350029) ->
	#bmon_group{
		no = 350029,
		name = <<"帮派副本第29层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.280000,
		mon_pool_fixed = [{35009,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350030) ->
	#bmon_group{
		no = 350030,
		name = <<"帮派副本第30层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{35010,1}],
		mon_pool_normal = [35011,35012,35013,35014,35015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350031) ->
	#bmon_group{
		no = 350031,
		name = <<"帮派副本第31层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40017,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350032) ->
	#bmon_group{
		no = 350032,
		name = <<"帮派副本第32层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40018,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350033) ->
	#bmon_group{
		no = 350033,
		name = <<"帮派副本第33层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40011,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350034) ->
	#bmon_group{
		no = 350034,
		name = <<"帮派副本第34层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40012,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350035) ->
	#bmon_group{
		no = 350035,
		name = <<"帮派副本第35层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40013,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350036) ->
	#bmon_group{
		no = 350036,
		name = <<"帮派副本第36层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40014,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350037) ->
	#bmon_group{
		no = 350037,
		name = <<"帮派副本第37层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40015,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350038) ->
	#bmon_group{
		no = 350038,
		name = <<"帮派副本第38层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40016,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350039) ->
	#bmon_group{
		no = 350039,
		name = <<"帮派副本第39层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40017,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350040) ->
	#bmon_group{
		no = 350040,
		name = <<"帮派副本第40层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40018,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350041) ->
	#bmon_group{
		no = 350041,
		name = <<"帮派副本第41层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40011,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350042) ->
	#bmon_group{
		no = 350042,
		name = <<"帮派副本第42层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40012,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350043) ->
	#bmon_group{
		no = 350043,
		name = <<"帮派副本第43层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40013,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350044) ->
	#bmon_group{
		no = 350044,
		name = <<"帮派副本第44层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40014,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350045) ->
	#bmon_group{
		no = 350045,
		name = <<"帮派副本第45层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40015,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350046) ->
	#bmon_group{
		no = 350046,
		name = <<"帮派副本第46层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40016,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350047) ->
	#bmon_group{
		no = 350047,
		name = <<"帮派副本第47层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40017,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350048) ->
	#bmon_group{
		no = 350048,
		name = <<"帮派副本第48层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40018,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350049) ->
	#bmon_group{
		no = 350049,
		name = <<"帮派副本第49层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40011,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350050) ->
	#bmon_group{
		no = 350050,
		name = <<"帮派副本第50层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40012,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350051) ->
	#bmon_group{
		no = 350051,
		name = <<"帮派副本第51层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40013,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350052) ->
	#bmon_group{
		no = 350052,
		name = <<"帮派副本第52层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40014,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350053) ->
	#bmon_group{
		no = 350053,
		name = <<"帮派副本第53层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40015,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350054) ->
	#bmon_group{
		no = 350054,
		name = <<"帮派副本第54层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40016,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350055) ->
	#bmon_group{
		no = 350055,
		name = <<"帮派副本第55层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40017,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350056) ->
	#bmon_group{
		no = 350056,
		name = <<"帮派副本第56层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40018,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350057) ->
	#bmon_group{
		no = 350057,
		name = <<"帮派副本第57层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40011,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350058) ->
	#bmon_group{
		no = 350058,
		name = <<"帮派副本第58层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40012,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350059) ->
	#bmon_group{
		no = 350059,
		name = <<"帮派副本第59层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40013,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350060) ->
	#bmon_group{
		no = 350060,
		name = <<"帮派副本第60层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40014,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350061) ->
	#bmon_group{
		no = 350061,
		name = <<"帮派副本第61层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40015,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350062) ->
	#bmon_group{
		no = 350062,
		name = <<"帮派副本第62层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40016,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350063) ->
	#bmon_group{
		no = 350063,
		name = <<"帮派副本第63层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40017,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350064) ->
	#bmon_group{
		no = 350064,
		name = <<"帮派副本第64层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40018,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350065) ->
	#bmon_group{
		no = 350065,
		name = <<"帮派副本第65层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40011,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350066) ->
	#bmon_group{
		no = 350066,
		name = <<"帮派副本第66层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40012,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350067) ->
	#bmon_group{
		no = 350067,
		name = <<"帮派副本第67层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40013,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350068) ->
	#bmon_group{
		no = 350068,
		name = <<"帮派副本第68层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40014,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350069) ->
	#bmon_group{
		no = 350069,
		name = <<"帮派副本第69层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40015,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350070) ->
	#bmon_group{
		no = 350070,
		name = <<"帮派副本第70层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40016,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350071) ->
	#bmon_group{
		no = 350071,
		name = <<"帮派副本第71层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40017,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350072) ->
	#bmon_group{
		no = 350072,
		name = <<"帮派副本第72层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40018,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350073) ->
	#bmon_group{
		no = 350073,
		name = <<"帮派副本第73层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40011,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350074) ->
	#bmon_group{
		no = 350074,
		name = <<"帮派副本第74层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40012,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350075) ->
	#bmon_group{
		no = 350075,
		name = <<"帮派副本第75层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40013,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350076) ->
	#bmon_group{
		no = 350076,
		name = <<"帮派副本第76层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40014,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350077) ->
	#bmon_group{
		no = 350077,
		name = <<"帮派副本第77层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40015,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350078) ->
	#bmon_group{
		no = 350078,
		name = <<"帮派副本第78层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40016,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350079) ->
	#bmon_group{
		no = 350079,
		name = <<"帮派副本第79层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40017,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350080) ->
	#bmon_group{
		no = 350080,
		name = <<"帮派副本第80层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40018,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350081) ->
	#bmon_group{
		no = 350081,
		name = <<"帮派副本第81层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40011,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350082) ->
	#bmon_group{
		no = 350082,
		name = <<"帮派副本第82层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40012,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350083) ->
	#bmon_group{
		no = 350083,
		name = <<"帮派副本第83层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40013,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350084) ->
	#bmon_group{
		no = 350084,
		name = <<"帮派副本第84层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40014,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350085) ->
	#bmon_group{
		no = 350085,
		name = <<"帮派副本第85层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40015,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350086) ->
	#bmon_group{
		no = 350086,
		name = <<"帮派副本第86层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40016,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350087) ->
	#bmon_group{
		no = 350087,
		name = <<"帮派副本第87层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40017,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350088) ->
	#bmon_group{
		no = 350088,
		name = <<"帮派副本第88层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40018,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350089) ->
	#bmon_group{
		no = 350089,
		name = <<"帮派副本第89层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40011,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350090) ->
	#bmon_group{
		no = 350090,
		name = <<"帮派副本第90层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40012,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350091) ->
	#bmon_group{
		no = 350091,
		name = <<"帮派副本第91层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40013,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350092) ->
	#bmon_group{
		no = 350092,
		name = <<"帮派副本第92层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40014,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350093) ->
	#bmon_group{
		no = 350093,
		name = <<"帮派副本第93层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40015,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350094) ->
	#bmon_group{
		no = 350094,
		name = <<"帮派副本第94层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40016,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350095) ->
	#bmon_group{
		no = 350095,
		name = <<"帮派副本第95层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40017,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350096) ->
	#bmon_group{
		no = 350096,
		name = <<"帮派副本第96层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40018,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350097) ->
	#bmon_group{
		no = 350097,
		name = <<"帮派副本第97层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40011,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350098) ->
	#bmon_group{
		no = 350098,
		name = <<"帮派副本第98层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40012,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350099) ->
	#bmon_group{
		no = 350099,
		name = <<"帮派副本第99层怪物组">>,
		lv_range_min = 15,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.080000,
		mon_pool_fixed = [{40013,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800001) ->
	#bmon_group{
		no = 800001,
		name = <<"50级兵临城下第1波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80210,1},{80223,2},{80090,3},{80130,4},{80170,5},{80190,6}],
		mon_pool_normal = [80000],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800002],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800002) ->
	#bmon_group{
		no = 800002,
		name = <<"50级兵临城下第2波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80288,1},{80210,2},{80223,3},{80091,4},{80131,5},{80171,6},{80191,7}],
		mon_pool_normal = [80000],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800003],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800003) ->
	#bmon_group{
		no = 800003,
		name = <<"50级兵临城下第3波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80288,1},{80237,2},{80263,3},{80092,4},{80112,5},{80132,6},{80172,7}],
		mon_pool_normal = [80001],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800004],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800004) ->
	#bmon_group{
		no = 800004,
		name = <<"50级兵临城下第4波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80307,1},{80237,2},{80263,3},{80113,4},{80133,5},{80153,6},{80173,7}],
		mon_pool_normal = [80001],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800005],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800005) ->
	#bmon_group{
		no = 800005,
		name = <<"50级兵临城下第5波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80307,1},{80251,2},{80277,3},{80114,4},{80154,5},{80174,6},{80194,7}],
		mon_pool_normal = [80002],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800006],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800006) ->
	#bmon_group{
		no = 800006,
		name = <<"50级兵临城下第6波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80326,1},{80251,2},{80277,3},{80095,4},{80135,5},{80155,6},{80195,7}],
		mon_pool_normal = [80003],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800007],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800007) ->
	#bmon_group{
		no = 800007,
		name = <<"50级兵临城下第7波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80326,1},{80252,2},{80226,3},{80096,4},{80116,5},{80176,6},{80196,7}],
		mon_pool_normal = [80004],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800008],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800008) ->
	#bmon_group{
		no = 800008,
		name = <<"50级兵临城下第8波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80318,1},{80214,2},{80240,3},{80097,4},{80117,5},{80157,6},{80197,7}],
		mon_pool_normal = [80005],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800009],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800009) ->
	#bmon_group{
		no = 800009,
		name = <<"50级兵临城下第9波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80318,1},{80267,2},{80280,3},{80118,4},{80138,5},{80158,6},{80178,7}],
		mon_pool_normal = [80006],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800010],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800010) ->
	#bmon_group{
		no = 800010,
		name = <<"50级兵临城下第10波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80301,1},{80255,2},{80268,3},{80139,4},{80159,5},{80179,6},{80199,7}],
		mon_pool_normal = [80007],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800101) ->
	#bmon_group{
		no = 800101,
		name = <<"70级兵临城下第1波">>,
		lv_range_min = 70,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80255,1},{80268,2},{80100,3},{80140,4},{80180,5},{80200,6}],
		mon_pool_normal = [80007],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800102],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800102) ->
	#bmon_group{
		no = 800102,
		name = <<"70级兵临城下第2波">>,
		lv_range_min = 70,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80301,1},{80255,2},{80268,3},{80101,4},{80141,5},{80181,6},{80201,7}],
		mon_pool_normal = [80007],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800103],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800103) ->
	#bmon_group{
		no = 800103,
		name = <<"70级兵临城下第3波">>,
		lv_range_min = 70,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80301,1},{80243,2},{80230,3},{80102,4},{80122,5},{80142,6},{80182,7}],
		mon_pool_normal = [80008],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800104],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800104) ->
	#bmon_group{
		no = 800104,
		name = <<"70级兵临城下第4波">>,
		lv_range_min = 70,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80311,1},{80243,2},{80230,3},{80123,4},{80143,5},{80163,6},{80183,7}],
		mon_pool_normal = [80008],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800105],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800105) ->
	#bmon_group{
		no = 800105,
		name = <<"70级兵临城下第5波">>,
		lv_range_min = 70,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80311,1},{80244,2},{80283,3},{80124,4},{80144,5},{80164,6},{80204,7}],
		mon_pool_normal = [80009],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800106],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800106) ->
	#bmon_group{
		no = 800106,
		name = <<"70级兵临城下第6波">>,
		lv_range_min = 70,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80339,1},{80244,2},{80283,3},{80105,4},{80165,5},{80185,6},{80205,7}],
		mon_pool_normal = [80010],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800107],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800107) ->
	#bmon_group{
		no = 800107,
		name = <<"70级兵临城下第7波">>,
		lv_range_min = 70,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80339,1},{80245,2},{80258,3},{80106,4},{80146,5},{80186,6},{80206,7}],
		mon_pool_normal = [80011],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800108],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800108) ->
	#bmon_group{
		no = 800108,
		name = <<"70级兵临城下第8波">>,
		lv_range_min = 70,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80304,1},{80233,2},{80259,3},{80107,4},{80127,5},{80147,6},{80187,7}],
		mon_pool_normal = [80012],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800109],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800109) ->
	#bmon_group{
		no = 800109,
		name = <<"70级兵临城下第9波">>,
		lv_range_min = 70,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80304,1},{80247,2},{80286,3},{80108,4},{80128,5},{80148,6},{80188,7}],
		mon_pool_normal = [80013],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800110],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800110) ->
	#bmon_group{
		no = 800110,
		name = <<"70级兵临城下第10波">>,
		lv_range_min = 70,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80323,1},{80222,2},{80261,3},{80129,4},{80149,5},{80169,6},{80189,7}],
		mon_pool_normal = [80014],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800201) ->
	#bmon_group{
		no = 800201,
		name = <<"80级兵临城下第1波">>,
		lv_range_min = 80,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80356,1},{80371,2},{80386,3},{80401,4},{80416,5},{80431,6}],
		mon_pool_normal = [80015],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800202],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800202) ->
	#bmon_group{
		no = 800202,
		name = <<"80级兵临城下第2波">>,
		lv_range_min = 80,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80432,1},{80452,2},{80472,3},{80492,4},{80512,5},{80532,6},{80552,7}],
		mon_pool_normal = [80016],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800203],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800203) ->
	#bmon_group{
		no = 800203,
		name = <<"80级兵临城下第3波">>,
		lv_range_min = 80,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80433,1},{80453,2},{80473,3},{80493,4},{80513,5},{80533,6},{80566,7}],
		mon_pool_normal = [80017],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800204],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800204) ->
	#bmon_group{
		no = 800204,
		name = <<"80级兵临城下第4波">>,
		lv_range_min = 80,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80434,1},{80454,2},{80474,3},{80494,4},{80514,5},{80534,6},{80580,7}],
		mon_pool_normal = [80018],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800205],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800205) ->
	#bmon_group{
		no = 800205,
		name = <<"80级兵临城下第5波">>,
		lv_range_min = 80,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80435,1},{80455,2},{80475,3},{80495,4},{80515,5},{80596,6},{80612,7}],
		mon_pool_normal = [80019],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800206],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800206) ->
	#bmon_group{
		no = 800206,
		name = <<"80级兵临城下第6波">>,
		lv_range_min = 80,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80436,1},{80456,2},{80476,3},{80496,4},{80628,5},{80615,6},{80602,7}],
		mon_pool_normal = [80020],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800207],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800207) ->
	#bmon_group{
		no = 800207,
		name = <<"80级兵临城下第7波">>,
		lv_range_min = 80,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80561,1},{80574,2},{80587,3},{80600,4},{80613,5},{80627,6},{80680,7}],
		mon_pool_normal = [80021],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800208],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800208) ->
	#bmon_group{
		no = 800208,
		name = <<"80级兵临城下第8波">>,
		lv_range_min = 80,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80562,1},{80575,2},{80588,3},{80601,4},{80614,5},{80663,6},{80672,7}],
		mon_pool_normal = [80022],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800209],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800209) ->
	#bmon_group{
		no = 800209,
		name = <<"80级兵临城下第9波">>,
		lv_range_min = 80,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80563,1},{80576,2},{80589,3},{80602,4},{80655,5},{80646,6},{80637,7}],
		mon_pool_normal = [80023],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800210],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800210) ->
	#bmon_group{
		no = 800210,
		name = <<"80级兵临城下第10波">>,
		lv_range_min = 80,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80638,1},{80647,2},{80656,3},{80665,4},{80674,5},{80683,6},{80356,7}],
		mon_pool_normal = [80024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800401) ->
	#bmon_group{
		no = 800401,
		name = <<"90级兵临城下第1波">>,
		lv_range_min = 90,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{90029,1},{80638,2},{80647,3},{80656,4},{80665,5},{80674,6},{80683,7}],
		mon_pool_normal = [80603],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800402],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800402) ->
	#bmon_group{
		no = 800402,
		name = <<"90级兵临城下第2波">>,
		lv_range_min = 90,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{90030,1},{80638,2},{80647,3},{80656,4},{80665,5},{80674,6},{80683,7}],
		mon_pool_normal = [80603],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800403],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800403) ->
	#bmon_group{
		no = 800403,
		name = <<"90级兵临城下第3波">>,
		lv_range_min = 90,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{90031,1},{80638,2},{80647,3},{80656,4},{80665,5},{80674,6},{80683,7}],
		mon_pool_normal = [80603],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800404],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800404) ->
	#bmon_group{
		no = 800404,
		name = <<"90级兵临城下第4波">>,
		lv_range_min = 90,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{90032,1},{80638,2},{80647,3},{80656,4},{80665,5},{80674,6},{80683,7}],
		mon_pool_normal = [80603],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800405],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800405) ->
	#bmon_group{
		no = 800405,
		name = <<"90级兵临城下第5波">>,
		lv_range_min = 90,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{90033,1},{80638,2},{80647,3},{80656,4},{80665,5},{80674,6},{80683,7}],
		mon_pool_normal = [80603],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800406],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800406) ->
	#bmon_group{
		no = 800406,
		name = <<"90级兵临城下第6波">>,
		lv_range_min = 90,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{90034,1},{80638,2},{80647,3},{80656,4},{80665,5},{80674,6},{80683,7}],
		mon_pool_normal = [80603],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800407],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800407) ->
	#bmon_group{
		no = 800407,
		name = <<"90级兵临城下第7波">>,
		lv_range_min = 90,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{90035,1},{80638,2},{80647,3},{80656,4},{80665,5},{80674,6},{80683,7}],
		mon_pool_normal = [80603],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800408],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800408) ->
	#bmon_group{
		no = 800408,
		name = <<"90级兵临城下第8波">>,
		lv_range_min = 90,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{90036,1},{80638,2},{80647,3},{80656,4},{80665,5},{80674,6},{80683,7}],
		mon_pool_normal = [80603],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800409],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800409) ->
	#bmon_group{
		no = 800409,
		name = <<"90级兵临城下第9波">>,
		lv_range_min = 90,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{90037,1},{80638,2},{80647,3},{80656,4},{80665,5},{80674,6},{80683,7}],
		mon_pool_normal = [80603],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800410],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800410) ->
	#bmon_group{
		no = 800410,
		name = <<"90级兵临城下第10波">>,
		lv_range_min = 90,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{90038,1},{80638,2},{80647,3},{80656,4},{80665,5},{80674,6},{80683,7}],
		mon_pool_normal = [80603],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350600) ->
	#bmon_group{
		no = 350600,
		name = <<"蟠桃小偷">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{90000,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350601) ->
	#bmon_group{
		no = 350601,
		name = <<"蟠桃小偷">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{90001,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350602) ->
	#bmon_group{
		no = 350602,
		name = <<"蟠桃小偷">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{90002,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350603) ->
	#bmon_group{
		no = 350603,
		name = <<"蟠桃小偷">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{90003,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350604) ->
	#bmon_group{
		no = 350604,
		name = <<"蟠桃小偷">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{90004,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350605) ->
	#bmon_group{
		no = 350605,
		name = <<"蟠桃小偷">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{90005,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350606) ->
	#bmon_group{
		no = 350606,
		name = <<"蟠桃小偷">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{90006,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(350607) ->
	#bmon_group{
		no = 350607,
		name = <<"蟠桃小偷">>,
		lv_range_min = 50,
		lv_range_max = 100,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{90007,1} ],
		mon_pool_normal = [40021, 40022, 40023 ,40024, 40025, 40026],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800301) ->
	#bmon_group{
		no = 800301,
		name = <<"大闹天宫第1波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80210,1},{80223,2},{80090,3},{80130,4},{80170,5},{80190,6}],
		mon_pool_normal = [80000],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800302],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800302) ->
	#bmon_group{
		no = 800302,
		name = <<"大闹天宫第2波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80288,1},{80210,2},{80223,3},{80091,4},{80131,5},{80171,6},{80191,7}],
		mon_pool_normal = [80000],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800303],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800303) ->
	#bmon_group{
		no = 800303,
		name = <<"大闹天宫第3波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80301,1},{80243,2},{80230,3},{80102,4},{80122,5},{80142,6},{80182,7}],
		mon_pool_normal = [80008],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800304],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800304) ->
	#bmon_group{
		no = 800304,
		name = <<"大闹天宫第4波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80311,1},{80243,2},{80230,3},{80123,4},{80143,5},{80163,6},{80183,7}],
		mon_pool_normal = [80008],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800305],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800305) ->
	#bmon_group{
		no = 800305,
		name = <<"大闹天宫第5波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80311,1},{80244,2},{80283,3},{80124,4},{80144,5},{80164,6},{80204,7}],
		mon_pool_normal = [80009],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800306],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800306) ->
	#bmon_group{
		no = 800306,
		name = <<"大闹天宫第6波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80436,1},{80456,2},{80476,3},{80496,4},{80628,5},{80615,6},{80602,7}],
		mon_pool_normal = [80020],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800307],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800307) ->
	#bmon_group{
		no = 800307,
		name = <<"大闹天宫第7波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80561,1},{80574,2},{80587,3},{80600,4},{80613,5},{80627,6},{80680,7}],
		mon_pool_normal = [80021],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800308],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800308) ->
	#bmon_group{
		no = 800308,
		name = <<"大闹天宫第8波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80562,1},{80575,2},{80588,3},{80601,4},{80614,5},{80663,6},{80672,7}],
		mon_pool_normal = [80022],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800309],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800309) ->
	#bmon_group{
		no = 800309,
		name = <<"大闹天宫第9波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80563,1},{80576,2},{80589,3},{80602,4},{80655,5},{80646,6},{80637,7}],
		mon_pool_normal = [80023],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [800310],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800310) ->
	#bmon_group{
		no = 800310,
		name = <<"大闹天宫第10波">>,
		lv_range_min = 50,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{80638,1},{80647,2},{80656,3},{80665,4},{80674,5},{80683,6},{80356,7}],
		mon_pool_normal = [80024],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800411) ->
	#bmon_group{
		no = 800411,
		name = <<"森罗派门派闯关副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90039,1}],
		mon_pool_normal = [90048, 90049, 90050, 90051, 90052, 90053, 90054],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800412) ->
	#bmon_group{
		no = 800412,
		name = <<"森罗派门派闯关副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90040,1}],
		mon_pool_normal = [90048, 90049, 90050, 90051, 90052, 90053, 90054],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800413) ->
	#bmon_group{
		no = 800413,
		name = <<"森罗派门派闯关副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90041,1}],
		mon_pool_normal = [90048, 90049, 90050, 90051, 90052, 90053, 90054],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800414) ->
	#bmon_group{
		no = 800414,
		name = <<"森罗派门派闯关副本怪物组4">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90042,1}],
		mon_pool_normal = [90048, 90049, 90050, 90051, 90052, 90053, 90054],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800415) ->
	#bmon_group{
		no = 800415,
		name = <<"森罗派门派闯关副本怪物组5">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90043,1}],
		mon_pool_normal = [90048, 90049, 90050, 90051, 90052, 90053, 90054],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800416) ->
	#bmon_group{
		no = 800416,
		name = <<"森罗派门派闯关副本怪物组6">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90044,1}],
		mon_pool_normal = [90048, 90049, 90050, 90051, 90052, 90053, 90054],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800417) ->
	#bmon_group{
		no = 800417,
		name = <<"森罗派门派闯关副本怪物组7">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90045,1}],
		mon_pool_normal = [90048, 90049, 90050, 90051, 90052, 90053, 90054],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800418) ->
	#bmon_group{
		no = 800418,
		name = <<"森罗派门派闯关副本怪物组8">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90046,1}],
		mon_pool_normal = [90048, 90049, 90050, 90051, 90052, 90053, 90054],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800419) ->
	#bmon_group{
		no = 800419,
		name = <<"森罗派门派闯关副本怪物组9">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90047,1}],
		mon_pool_normal = [90048, 90049, 90050, 90051, 90052, 90053, 90054],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800420) ->
	#bmon_group{
		no = 800420,
		name = <<"天罡派门派闯关副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90055,1}],
		mon_pool_normal = [90064, 90065, 90066, 90067, 90068, 90069, 90070],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800421) ->
	#bmon_group{
		no = 800421,
		name = <<"天罡派门派闯关副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90056,1}],
		mon_pool_normal = [90064, 90065, 90066, 90067, 90068, 90069, 90070],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800422) ->
	#bmon_group{
		no = 800422,
		name = <<"天罡派门派闯关副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90057,1}],
		mon_pool_normal = [90064, 90065, 90066, 90067, 90068, 90069, 90070],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800423) ->
	#bmon_group{
		no = 800423,
		name = <<"天罡派门派闯关副本怪物组4">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90058,1}],
		mon_pool_normal = [90064, 90065, 90066, 90067, 90068, 90069, 90070],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800424) ->
	#bmon_group{
		no = 800424,
		name = <<"天罡派门派闯关副本怪物组5">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90059,1}],
		mon_pool_normal = [90064, 90065, 90066, 90067, 90068, 90069, 90070],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800425) ->
	#bmon_group{
		no = 800425,
		name = <<"天罡派门派闯关副本怪物组6">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90060,1}],
		mon_pool_normal = [90064, 90065, 90066, 90067, 90068, 90069, 90070],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800426) ->
	#bmon_group{
		no = 800426,
		name = <<"天罡派门派闯关副本怪物组7">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90061,1}],
		mon_pool_normal = [90064, 90065, 90066, 90067, 90068, 90069, 90070],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800427) ->
	#bmon_group{
		no = 800427,
		name = <<"天罡派门派闯关副本怪物组8">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90062,1}],
		mon_pool_normal = [90064, 90065, 90066, 90067, 90068, 90069, 90070],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800428) ->
	#bmon_group{
		no = 800428,
		name = <<"天罡派门派闯关副本怪物组9">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90063,1}],
		mon_pool_normal = [90064, 90065, 90066, 90067, 90068, 90069, 90070],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800429) ->
	#bmon_group{
		no = 800429,
		name = <<"魔魁派门派闯关副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90071,1}],
		mon_pool_normal = [90080, 90081, 90082, 90083, 90084, 90085, 90086],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800430) ->
	#bmon_group{
		no = 800430,
		name = <<"魔魁派门派闯关副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90072,1}],
		mon_pool_normal = [90080, 90081, 90082, 90083, 90084, 90085, 90086],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800431) ->
	#bmon_group{
		no = 800431,
		name = <<"魔魁派门派闯关副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90073,1}],
		mon_pool_normal = [90080, 90081, 90082, 90083, 90084, 90085, 90086],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800432) ->
	#bmon_group{
		no = 800432,
		name = <<"魔魁派门派闯关副本怪物组4">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90074,1}],
		mon_pool_normal = [90080, 90081, 90082, 90083, 90084, 90085, 90086],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800433) ->
	#bmon_group{
		no = 800433,
		name = <<"魔魁派门派闯关副本怪物组5">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90075,1}],
		mon_pool_normal = [90080, 90081, 90082, 90083, 90084, 90085, 90086],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800434) ->
	#bmon_group{
		no = 800434,
		name = <<"魔魁派门派闯关副本怪物组6">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90076,1}],
		mon_pool_normal = [90080, 90081, 90082, 90083, 90084, 90085, 90086],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800435) ->
	#bmon_group{
		no = 800435,
		name = <<"魔魁派门派闯关副本怪物组7">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90077,1}],
		mon_pool_normal = [90080, 90081, 90082, 90083, 90084, 90085, 90086],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800436) ->
	#bmon_group{
		no = 800436,
		name = <<"魔魁派门派闯关副本怪物组8">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90078,1}],
		mon_pool_normal = [90080, 90081, 90082, 90083, 90084, 90085, 90086],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800437) ->
	#bmon_group{
		no = 800437,
		name = <<"魔魁派门派闯关副本怪物组9">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90079,1}],
		mon_pool_normal = [90080, 90081, 90082, 90083, 90084, 90085, 90086],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800438) ->
	#bmon_group{
		no = 800438,
		name = <<"罗刹派门派闯关副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90087,1}],
		mon_pool_normal = [90096, 90097, 90098, 90099, 90100, 90101, 90102],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800439) ->
	#bmon_group{
		no = 800439,
		name = <<"罗刹派门派闯关副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90088,1}],
		mon_pool_normal = [90096, 90097, 90098, 90099, 90100, 90101, 90102],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800440) ->
	#bmon_group{
		no = 800440,
		name = <<"罗刹派门派闯关副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90089,1}],
		mon_pool_normal = [90096, 90097, 90098, 90099, 90100, 90101, 90102],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800441) ->
	#bmon_group{
		no = 800441,
		name = <<"罗刹派门派闯关副本怪物组4">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90090,1}],
		mon_pool_normal = [90096, 90097, 90098, 90099, 90100, 90101, 90102],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800442) ->
	#bmon_group{
		no = 800442,
		name = <<"罗刹派门派闯关副本怪物组5">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90091,1}],
		mon_pool_normal = [90096, 90097, 90098, 90099, 90100, 90101, 90102],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800443) ->
	#bmon_group{
		no = 800443,
		name = <<"罗刹派门派闯关副本怪物组6">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90092,1}],
		mon_pool_normal = [90096, 90097, 90098, 90099, 90100, 90101, 90102],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800444) ->
	#bmon_group{
		no = 800444,
		name = <<"罗刹派门派闯关副本怪物组7">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90093,1}],
		mon_pool_normal = [90096, 90097, 90098, 90099, 90100, 90101, 90102],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800445) ->
	#bmon_group{
		no = 800445,
		name = <<"罗刹派门派闯关副本怪物组8">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90094,1}],
		mon_pool_normal = [90096, 90097, 90098, 90099, 90100, 90101, 90102],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800446) ->
	#bmon_group{
		no = 800446,
		name = <<"罗刹派门派闯关副本怪物组9">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90095,1}],
		mon_pool_normal = [90096, 90097, 90098, 90099, 90100, 90101, 90102],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800447) ->
	#bmon_group{
		no = 800447,
		name = <<"逍遥派门派闯关副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90103,1}],
		mon_pool_normal = [90112, 90113, 90114, 90115, 90116, 90117, 90118],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800448) ->
	#bmon_group{
		no = 800448,
		name = <<"逍遥派门派闯关副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90104,1}],
		mon_pool_normal = [90112, 90113, 90114, 90115, 90116, 90117, 90118],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800449) ->
	#bmon_group{
		no = 800449,
		name = <<"逍遥派门派闯关副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90105,1}],
		mon_pool_normal = [90112, 90113, 90114, 90115, 90116, 90117, 90118],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800450) ->
	#bmon_group{
		no = 800450,
		name = <<"逍遥派门派闯关副本怪物组4">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90106,1}],
		mon_pool_normal = [90112, 90113, 90114, 90115, 90116, 90117, 90118],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800451) ->
	#bmon_group{
		no = 800451,
		name = <<"逍遥派门派闯关副本怪物组5">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90107,1}],
		mon_pool_normal = [90112, 90113, 90114, 90115, 90116, 90117, 90118],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800452) ->
	#bmon_group{
		no = 800452,
		name = <<"逍遥派门派闯关副本怪物组6">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90108,1}],
		mon_pool_normal = [90112, 90113, 90114, 90115, 90116, 90117, 90118],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800453) ->
	#bmon_group{
		no = 800453,
		name = <<"逍遥派门派闯关副本怪物组7">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90109,1}],
		mon_pool_normal = [90112, 90113, 90114, 90115, 90116, 90117, 90118],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800454) ->
	#bmon_group{
		no = 800454,
		name = <<"逍遥派门派闯关副本怪物组8">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90110,1}],
		mon_pool_normal = [90112, 90113, 90114, 90115, 90116, 90117, 90118],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800455) ->
	#bmon_group{
		no = 800455,
		name = <<"逍遥派门派闯关副本怪物组9">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90111,1}],
		mon_pool_normal = [90112, 90113, 90114, 90115, 90116, 90117, 90118],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800456) ->
	#bmon_group{
		no = 800456,
		name = <<"灵云派门派闯关副本怪物组1">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90119,1}],
		mon_pool_normal = [90128, 90129, 90130, 90131, 90132, 90133, 90134],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800457) ->
	#bmon_group{
		no = 800457,
		name = <<"灵云派门派闯关副本怪物组2">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90120,1}],
		mon_pool_normal = [90128, 90129, 90130, 90131, 90132, 90133, 90134],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800458) ->
	#bmon_group{
		no = 800458,
		name = <<"灵云派门派闯关副本怪物组3">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90121,1}],
		mon_pool_normal = [90128, 90129, 90130, 90131, 90132, 90133, 90134],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800459) ->
	#bmon_group{
		no = 800459,
		name = <<"灵云派门派闯关副本怪物组4">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 6,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90122,1}],
		mon_pool_normal = [90128, 90129, 90130, 90131, 90132, 90133, 90134],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800460) ->
	#bmon_group{
		no = 800460,
		name = <<"灵云派门派闯关副本怪物组5">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90123,1}],
		mon_pool_normal = [90128, 90129, 90130, 90131, 90132, 90133, 90134],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800461) ->
	#bmon_group{
		no = 800461,
		name = <<"灵云派门派闯关副本怪物组6">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90124,1}],
		mon_pool_normal = [90128, 90129, 90130, 90131, 90132, 90133, 90134],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800462) ->
	#bmon_group{
		no = 800462,
		name = <<"灵云派门派闯关副本怪物组7">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90125,1}],
		mon_pool_normal = [90128, 90129, 90130, 90131, 90132, 90133, 90134],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800463) ->
	#bmon_group{
		no = 800463,
		name = <<"灵云派门派闯关副本怪物组8">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90126,1}],
		mon_pool_normal = [90128, 90129, 90130, 90131, 90132, 90133, 90134],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800464) ->
	#bmon_group{
		no = 800464,
		name = <<"灵云派门派闯关副本怪物组9">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90127,1}],
		mon_pool_normal = [90128, 90129, 90130, 90131, 90132, 90133, 90134],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800465) ->
	#bmon_group{
		no = 800465,
		name = <<"采花贼">>,
		lv_range_min = 50,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.600000,
		mon_pool_fixed = [{90135,1}],
		mon_pool_normal = [90138, 90139, 90140, 90141, 90142, 90143],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800466) ->
	#bmon_group{
		no = 800466,
		name = <<"食丹鬼">>,
		lv_range_min = 50,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.600000,
		mon_pool_fixed = [{90136,1}],
		mon_pool_normal = [90144, 90145, 90146, 90147, 90148, 90149],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800467) ->
	#bmon_group{
		no = 800467,
		name = <<"偷矿者">>,
		lv_range_min = 50,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.600000,
		mon_pool_fixed = [{90137,1}],
		mon_pool_normal = [90150, 90151, 90152, 90153, 90154, 90155],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800468) ->
	#bmon_group{
		no = 800468,
		name = <<"端午节陶朱公任务怪物组">>,
		lv_range_min = 30,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{90166,1}],
		mon_pool_normal = [90171, 90172, 90173, 90174, 90175, 90176],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800469) ->
	#bmon_group{
		no = 800469,
		name = <<"端午节李保安任务怪物组">>,
		lv_range_min = 30,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{90169,1}],
		mon_pool_normal = [90171, 90172, 90173, 90174, 90175, 90176],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800470) ->
	#bmon_group{
		no = 800470,
		name = <<"端午节吕大人任务怪物组">>,
		lv_range_min = 30,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{90168,1}],
		mon_pool_normal = [90171, 90172, 90173, 90174, 90175, 90176],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800471) ->
	#bmon_group{
		no = 800471,
		name = <<"端午节蚌精大王任务怪物组">>,
		lv_range_min = 30,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{90167,1},{90166,2}],
		mon_pool_normal = [90171, 90172, 90173, 90174, 90175, 90176],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800472) ->
	#bmon_group{
		no = 800472,
		name = <<"端午节赵管家任务怪物组">>,
		lv_range_min = 30,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{90170,1},{90169,2}],
		mon_pool_normal = [90171, 90172, 90173, 90174, 90175, 90176],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800473) ->
	#bmon_group{
		no = 800473,
		name = <<"端午节李园主任务怪物组">>,
		lv_range_min = 30,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{90168,1},{90167,2}],
		mon_pool_normal = [90171, 90172, 90173, 90174, 90175, 90176],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800474) ->
	#bmon_group{
		no = 800474,
		name = <<"端午节汉国商人任务怪物组">>,
		lv_range_min = 30,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{90166,1},{90169,2}],
		mon_pool_normal = [90171, 90172, 90173, 90174, 90175, 90176],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800475) ->
	#bmon_group{
		no = 800475,
		name = <<"端午节蒙大人任务怪物组">>,
		lv_range_min = 30,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{90170,1},{90168,2}],
		mon_pool_normal = [90171, 90172, 90173, 90174, 90175, 90176],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800476) ->
	#bmon_group{
		no = 800476,
		name = <<"端午节太傅任务怪物组">>,
		lv_range_min = 30,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{90170,1},{90167,2}],
		mon_pool_normal = [90171, 90172, 90173, 90174, 90175, 90176],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800477) ->
	#bmon_group{
		no = 800477,
		name = <<"端午节捉鬼弟子任务怪物组">>,
		lv_range_min = 30,
		lv_range_max = 120,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.200000,
		mon_pool_fixed = [{90166,1},{90167,2},{90168,3},{90169,4},{90170,5}],
		mon_pool_normal = [90171, 90172, 90173, 90174, 90175, 90176],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800478) ->
	#bmon_group{
		no = 800478,
		name = <<"巡山小妖">>,
		lv_range_min = 40,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.040000,
		mon_pool_fixed = [{90177,1}],
		mon_pool_normal = [90185, 90186, 90187, 90188, 90189, 90190],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800479) ->
	#bmon_group{
		no = 800479,
		name = <<"瘴气小妖">>,
		lv_range_min = 40,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.040000,
		mon_pool_fixed = [{90178,1}],
		mon_pool_normal = [90185, 90186, 90187, 90188, 90189, 90190],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800480) ->
	#bmon_group{
		no = 800480,
		name = <<"异域小妖">>,
		lv_range_min = 40,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.040000,
		mon_pool_fixed = [{90179,1}],
		mon_pool_normal = [90185, 90186, 90187, 90188, 90189, 90190],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800481) ->
	#bmon_group{
		no = 800481,
		name = <<"黑风山贼">>,
		lv_range_min = 40,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.040000,
		mon_pool_fixed = [{90180,1}],
		mon_pool_normal = [90185, 90186, 90187, 90188, 90189, 90190],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800482) ->
	#bmon_group{
		no = 800482,
		name = <<"封印使者">>,
		lv_range_min = 40,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.040000,
		mon_pool_fixed = [{90181,1}],
		mon_pool_normal = [90185, 90186, 90187, 90188, 90189, 90190],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800483) ->
	#bmon_group{
		no = 800483,
		name = <<"九黎幻魔">>,
		lv_range_min = 40,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0,
		mon_pool_fixed = [{90182,1},{90183,2},{90184,3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800484) ->
	#bmon_group{
		no = 800484,
		name = <<"三界轶事-山贼头目">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{90191, 1}, {90191, 2}, {90191, 3}, {90191, 4}, {90191, 5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800485) ->
	#bmon_group{
		no = 800485,
		name = <<"三界轶事-无赖赌徒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{90192, 1}, {90192, 2}, {90192, 3}, {90192, 4}, {90192, 5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800486) ->
	#bmon_group{
		no = 800486,
		name = <<"三界轶事-强盗帮凶">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{90193, 1}, {90193, 2}, {90193, 3}, {90193, 4}, {90193, 5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800487) ->
	#bmon_group{
		no = 800487,
		name = <<"三界轶事-山贼头目">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90191, 1}, {90191, 2}, {90191, 3}, {90191, 4}, {90191, 5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800488) ->
	#bmon_group{
		no = 800488,
		name = <<"三界轶事-无赖赌徒">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90192, 1}, {90192, 2}, {90192, 3}, {90192, 4}, {90192, 5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800489) ->
	#bmon_group{
		no = 800489,
		name = <<"三界轶事-强盗帮凶">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90193, 1}, {90193, 2}, {90193, 3}, {90193, 4}, {90193, 5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800559) ->
	#bmon_group{
		no = 800559,
		name = <<"星罗棋布-宝藏强盗">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.800000,
		mon_pool_fixed = [{2610, 1}, {2610, 2}, {2610, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800560) ->
	#bmon_group{
		no = 800560,
		name = <<"星罗棋布-宝藏强盗">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.800000,
		mon_pool_fixed = [{2611, 1}, {2611, 2}, {2611, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800561) ->
	#bmon_group{
		no = 800561,
		name = <<"星罗棋布-宝藏强盗">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.800000,
		mon_pool_fixed = [{2612, 1}, {2613, 2}, {2614, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800562) ->
	#bmon_group{
		no = 800562,
		name = <<"星罗棋布-宝藏强盗">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.800000,
		mon_pool_fixed = [{2613, 1}, {2613, 2}, {2613, 3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800563) ->
	#bmon_group{
		no = 800563,
		name = <<"限时任务-简单攻">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.008000,
		mon_pool_fixed = [{90194,1},{90195,2},{90196,3},{90197,4},{90198,5},{90199,6},{90200,7}],
		mon_pool_normal = [90195,90196,90197,90198,90199,90200],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800564) ->
	#bmon_group{
		no = 800564,
		name = <<"限时任务-简单防">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.008000,
		mon_pool_fixed = [{90201,1},{90202,2},{90203,3},{90204,4},{90205,5},{90206,6},{90207,7}],
		mon_pool_normal = [90202,90203,90204,90205,90206,90207],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800565) ->
	#bmon_group{
		no = 800565,
		name = <<"限时任务-困难攻">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.250000,
		mon_pool_fixed = [{90194,1},{90195,2},{90196,3},{90197,4},{90198,5},{90199,6},{90200,7}],
		mon_pool_normal = [90195,90196,90197,90198,90199,90200],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800566) ->
	#bmon_group{
		no = 800566,
		name = <<"限时任务-困难防">>,
		lv_range_min = 0,
		lv_range_max = 150,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.300000,
		mon_pool_fixed = [{90201,1},{90202,2},{90203,3},{90204,4},{90205,5},{90206,6},{90207,7}],
		mon_pool_normal = [90202,90203,90204,90205,90206,90207],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800567) ->
	#bmon_group{
		no = 800567,
		name = <<"120级蓬莱秘境普通秘境第1关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90237, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800568) ->
	#bmon_group{
		no = 800568,
		name = <<"120级蓬莱秘境普通秘境第2关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90236, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800569) ->
	#bmon_group{
		no = 800569,
		name = <<"120级蓬莱秘境普通秘境第3关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90235, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800570) ->
	#bmon_group{
		no = 800570,
		name = <<"120级蓬莱秘境普通秘境第4关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90234, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800571) ->
	#bmon_group{
		no = 800571,
		name = <<"120级蓬莱秘境普通秘境第5关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90233, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800572) ->
	#bmon_group{
		no = 800572,
		name = <<"120级蓬莱秘境普通秘境第6关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90232, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800573) ->
	#bmon_group{
		no = 800573,
		name = <<"120级蓬莱秘境普通秘境第7关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90231, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800574) ->
	#bmon_group{
		no = 800574,
		name = <<"120级蓬莱秘境普通秘境第8关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90230, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800575) ->
	#bmon_group{
		no = 800575,
		name = <<"120级蓬莱秘境普通秘境第9关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90229, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800576) ->
	#bmon_group{
		no = 800576,
		name = <<"120级蓬莱秘境普通秘境第10关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.800000,
		mon_pool_fixed = [{90228, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800577) ->
	#bmon_group{
		no = 800577,
		name = <<"180级蓬莱秘境困难秘境第1关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90220, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800578) ->
	#bmon_group{
		no = 800578,
		name = <<"180级蓬莱秘境困难秘境第2关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 7,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90221, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800579) ->
	#bmon_group{
		no = 800579,
		name = <<"180级蓬莱秘境困难秘境第3关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90222, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800580) ->
	#bmon_group{
		no = 800580,
		name = <<"180级蓬莱秘境困难秘境第4关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90223, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800581) ->
	#bmon_group{
		no = 800581,
		name = <<"180级蓬莱秘境困难秘境第5关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90224, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800582) ->
	#bmon_group{
		no = 800582,
		name = <<"180级蓬莱秘境困难秘境第6关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90225, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800583) ->
	#bmon_group{
		no = 800583,
		name = <<"180级蓬莱秘境困难秘境第7关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90226, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800584) ->
	#bmon_group{
		no = 800584,
		name = <<"180级蓬莱秘境困难秘境第8关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90227, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800585) ->
	#bmon_group{
		no = 800585,
		name = <<"180级蓬莱秘境困难秘境第9关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90228, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800586) ->
	#bmon_group{
		no = 800586,
		name = <<"180级蓬莱秘境困难秘境第10关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90229, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800587) ->
	#bmon_group{
		no = 800587,
		name = <<"180级蓬莱秘境困难秘境第11关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90208, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800588) ->
	#bmon_group{
		no = 800588,
		name = <<"180级蓬莱秘境困难秘境第12关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90209, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800589) ->
	#bmon_group{
		no = 800589,
		name = <<"180级蓬莱秘境困难秘境第13关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90210, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800590) ->
	#bmon_group{
		no = 800590,
		name = <<"180级蓬莱秘境困难秘境第14关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90211, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800591) ->
	#bmon_group{
		no = 800591,
		name = <<"180级蓬莱秘境困难秘境第15关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90212, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800592) ->
	#bmon_group{
		no = 800592,
		name = <<"250级蓬莱秘境炼狱秘境第1关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90215, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800593) ->
	#bmon_group{
		no = 800593,
		name = <<"250级蓬莱秘境炼狱秘境第2关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90216, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800594) ->
	#bmon_group{
		no = 800594,
		name = <<"250级蓬莱秘境炼狱秘境第3关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90217, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800595) ->
	#bmon_group{
		no = 800595,
		name = <<"250级蓬莱秘境炼狱秘境第4关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90218, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800596) ->
	#bmon_group{
		no = 800596,
		name = <<"250级蓬莱秘境炼狱秘境第5关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90219, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800597) ->
	#bmon_group{
		no = 800597,
		name = <<"250级蓬莱秘境炼狱秘境第6关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90220, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800598) ->
	#bmon_group{
		no = 800598,
		name = <<"250级蓬莱秘境炼狱秘境第7关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90221, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800599) ->
	#bmon_group{
		no = 800599,
		name = <<"250级蓬莱秘境炼狱秘境第8关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90222, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800600) ->
	#bmon_group{
		no = 800600,
		name = <<"250级蓬莱秘境炼狱秘境第9关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90223, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800601) ->
	#bmon_group{
		no = 800601,
		name = <<"250级蓬莱秘境炼狱秘境第10关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90224, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800602) ->
	#bmon_group{
		no = 800602,
		name = <<"250级蓬莱秘境炼狱秘境第11关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90225, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800603) ->
	#bmon_group{
		no = 800603,
		name = <<"250级蓬莱秘境炼狱秘境第12关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90226, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800604) ->
	#bmon_group{
		no = 800604,
		name = <<"250级蓬莱秘境炼狱秘境第13关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90227, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800605) ->
	#bmon_group{
		no = 800605,
		name = <<"250级蓬莱秘境炼狱秘境第14关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90228, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800606) ->
	#bmon_group{
		no = 800606,
		name = <<"250级蓬莱秘境炼狱秘境第15关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90229, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800607) ->
	#bmon_group{
		no = 800607,
		name = <<"250级蓬莱秘境炼狱秘境第16关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90230, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800608) ->
	#bmon_group{
		no = 800608,
		name = <<"250级蓬莱秘境炼狱秘境第17关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90231, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800609) ->
	#bmon_group{
		no = 800609,
		name = <<"250级蓬莱秘境炼狱秘境第18关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90232, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800610) ->
	#bmon_group{
		no = 800610,
		name = <<"250级蓬莱秘境炼狱秘境第19关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90233, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800611) ->
	#bmon_group{
		no = 800611,
		name = <<"250级蓬莱秘境炼狱秘境第20关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90234, 1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800612) ->
	#bmon_group{
		no = 800612,
		name = <<"120级太虚幻境普通幻境第1关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90228, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800613) ->
	#bmon_group{
		no = 800613,
		name = <<"120级太虚幻境普通幻境第2关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90229, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800614) ->
	#bmon_group{
		no = 800614,
		name = <<"120级太虚幻境普通幻境第3关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90244,1}, {90230, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800615) ->
	#bmon_group{
		no = 800615,
		name = <<"120级太虚幻境普通幻境第4关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90245,1}, {90231, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800616) ->
	#bmon_group{
		no = 800616,
		name = <<"120级太虚幻境普通幻境第5关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90232, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800617) ->
	#bmon_group{
		no = 800617,
		name = <<"120级太虚幻境普通幻境第6关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90246,1}, {90233, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800618) ->
	#bmon_group{
		no = 800618,
		name = <<"120级太虚幻境普通幻境第7关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90247,1}, {90234, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800619) ->
	#bmon_group{
		no = 800619,
		name = <<"120级太虚幻境普通幻境第8关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90235, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800620) ->
	#bmon_group{
		no = 800620,
		name = <<"120级太虚幻境普通幻境第9关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90248,1}, {90236, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800621) ->
	#bmon_group{
		no = 800621,
		name = <<"120级太虚幻境普通幻境第10关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90249,1}, {90237, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800622) ->
	#bmon_group{
		no = 800622,
		name = <<"120级太虚幻境普通幻境第11关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90208, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800623) ->
	#bmon_group{
		no = 800623,
		name = <<"120级太虚幻境普通幻境第12关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90250,1}, {90209, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800624) ->
	#bmon_group{
		no = 800624,
		name = <<"120级太虚幻境普通幻境第13关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90251,1}, {90210, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800625) ->
	#bmon_group{
		no = 800625,
		name = <<"120级太虚幻境普通幻境第14关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90211, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800626) ->
	#bmon_group{
		no = 800626,
		name = <<"120级太虚幻境普通幻境第15关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90252,1}, {90212, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800627) ->
	#bmon_group{
		no = 800627,
		name = <<"120级太虚幻境普通幻境第16关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90253,1}, {90213, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800628) ->
	#bmon_group{
		no = 800628,
		name = <<"120级太虚幻境普通幻境第17关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90214, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800629) ->
	#bmon_group{
		no = 800629,
		name = <<"120级太虚幻境普通幻境第18关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90254,1}, {90215, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800630) ->
	#bmon_group{
		no = 800630,
		name = <<"120级太虚幻境普通幻境第19关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90255,1}, {90216, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800631) ->
	#bmon_group{
		no = 800631,
		name = <<"120级太虚幻境普通幻境第20关">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90256,1}, {90217, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800632) ->
	#bmon_group{
		no = 800632,
		name = <<"180级太虚幻境困难幻境第1关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90237, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800633) ->
	#bmon_group{
		no = 800633,
		name = <<"180级太虚幻境困难幻境第2关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90236, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800634) ->
	#bmon_group{
		no = 800634,
		name = <<"180级太虚幻境困难幻境第3关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90239,1}, {90235, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800635) ->
	#bmon_group{
		no = 800635,
		name = <<"180级太虚幻境困难幻境第4关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90242,1}, {90234, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800636) ->
	#bmon_group{
		no = 800636,
		name = <<"180级太虚幻境困难幻境第5关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90233, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800637) ->
	#bmon_group{
		no = 800637,
		name = <<"180级太虚幻境困难幻境第6关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90243,1}, {90232, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800638) ->
	#bmon_group{
		no = 800638,
		name = <<"180级太虚幻境困难幻境第7关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90244,1}, {90231, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800639) ->
	#bmon_group{
		no = 800639,
		name = <<"180级太虚幻境困难幻境第8关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90230, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800640) ->
	#bmon_group{
		no = 800640,
		name = <<"180级太虚幻境困难幻境第9关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90245,1}, {90229, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800641) ->
	#bmon_group{
		no = 800641,
		name = <<"180级太虚幻境困难幻境第10关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90246,1}, {90228, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800642) ->
	#bmon_group{
		no = 800642,
		name = <<"180级太虚幻境困难幻境第11关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90227, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800643) ->
	#bmon_group{
		no = 800643,
		name = <<"180级太虚幻境困难幻境第12关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90247,1}, {90226, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800644) ->
	#bmon_group{
		no = 800644,
		name = <<"180级太虚幻境困难幻境第13关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90248,1}, {90225, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800645) ->
	#bmon_group{
		no = 800645,
		name = <<"180级太虚幻境困难幻境第14关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90224, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800646) ->
	#bmon_group{
		no = 800646,
		name = <<"180级太虚幻境困难幻境第15关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90249,1}, {90223, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800647) ->
	#bmon_group{
		no = 800647,
		name = <<"180级太虚幻境困难幻境第16关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90250,1}, {90222, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800648) ->
	#bmon_group{
		no = 800648,
		name = <<"180级太虚幻境困难幻境第17关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90221, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800649) ->
	#bmon_group{
		no = 800649,
		name = <<"180级太虚幻境困难幻境第18关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90251,1}, {90220, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800650) ->
	#bmon_group{
		no = 800650,
		name = <<"180级太虚幻境困难幻境第19关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90252,1}, {90219, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800651) ->
	#bmon_group{
		no = 800651,
		name = <<"180级太虚幻境困难幻境第20关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90218, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800652) ->
	#bmon_group{
		no = 800652,
		name = <<"180级太虚幻境困难幻境第21关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90253,1}, {90217, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800653) ->
	#bmon_group{
		no = 800653,
		name = <<"180级太虚幻境困难幻境第22关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90254,1}, {90216, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800654) ->
	#bmon_group{
		no = 800654,
		name = <<"180级太虚幻境困难幻境第23关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90215, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800655) ->
	#bmon_group{
		no = 800655,
		name = <<"180级太虚幻境困难幻境第24关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90255,1}, {90214, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800656) ->
	#bmon_group{
		no = 800656,
		name = <<"180级太虚幻境困难幻境第25关">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90256,1}, {90213, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800657) ->
	#bmon_group{
		no = 800657,
		name = <<"250级太虚幻境炼狱幻境第1关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90208, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800658) ->
	#bmon_group{
		no = 800658,
		name = <<"250级太虚幻境炼狱幻境第2关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90209, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800659) ->
	#bmon_group{
		no = 800659,
		name = <<"250级太虚幻境炼狱幻境第3关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90240,1}, {90210, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800660) ->
	#bmon_group{
		no = 800660,
		name = <<"250级太虚幻境炼狱幻境第4关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90241,1}, {90211, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800661) ->
	#bmon_group{
		no = 800661,
		name = <<"250级太虚幻境炼狱幻境第5关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90212, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800662) ->
	#bmon_group{
		no = 800662,
		name = <<"250级太虚幻境炼狱幻境第6关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90242,1}, {90213, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800663) ->
	#bmon_group{
		no = 800663,
		name = <<"250级太虚幻境炼狱幻境第7关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90243,1}, {90214, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800664) ->
	#bmon_group{
		no = 800664,
		name = <<"250级太虚幻境炼狱幻境第8关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90215, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800665) ->
	#bmon_group{
		no = 800665,
		name = <<"250级太虚幻境炼狱幻境第9关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90244,1}, {90216, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800666) ->
	#bmon_group{
		no = 800666,
		name = <<"250级太虚幻境炼狱幻境第10关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90245,1}, {90217, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800667) ->
	#bmon_group{
		no = 800667,
		name = <<"250级太虚幻境炼狱幻境第11关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90218, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800668) ->
	#bmon_group{
		no = 800668,
		name = <<"250级太虚幻境炼狱幻境第12关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90246,1}, {90219, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800669) ->
	#bmon_group{
		no = 800669,
		name = <<"250级太虚幻境炼狱幻境第13关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90247,1}, {90220, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800670) ->
	#bmon_group{
		no = 800670,
		name = <<"250级太虚幻境炼狱幻境第14关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90221, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800671) ->
	#bmon_group{
		no = 800671,
		name = <<"250级太虚幻境炼狱幻境第15关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90248,1}, {90222, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800672) ->
	#bmon_group{
		no = 800672,
		name = <<"250级太虚幻境炼狱幻境第16关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90249,1}, {90223, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800673) ->
	#bmon_group{
		no = 800673,
		name = <<"250级太虚幻境炼狱幻境第17关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90224, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800674) ->
	#bmon_group{
		no = 800674,
		name = <<"250级太虚幻境炼狱幻境第18关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90250,1}, {90225, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800675) ->
	#bmon_group{
		no = 800675,
		name = <<"250级太虚幻境炼狱幻境第19关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90251,1}, {90226, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800676) ->
	#bmon_group{
		no = 800676,
		name = <<"250级太虚幻境炼狱幻境第20关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90227, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800677) ->
	#bmon_group{
		no = 800677,
		name = <<"250级太虚幻境炼狱幻境第21关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90252,1}, {90228, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800678) ->
	#bmon_group{
		no = 800678,
		name = <<"250级太虚幻境炼狱幻境第22关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90253,1}, {90229, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800679) ->
	#bmon_group{
		no = 800679,
		name = <<"250级太虚幻境炼狱幻境第23关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90230, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800680) ->
	#bmon_group{
		no = 800680,
		name = <<"250级太虚幻境炼狱幻境第24关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90254,1}, {90231, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800681) ->
	#bmon_group{
		no = 800681,
		name = <<"250级太虚幻境炼狱幻境第25关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90255,1}, {90232, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800682) ->
	#bmon_group{
		no = 800682,
		name = <<"250级太虚幻境炼狱幻境第26关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90256,1}, {90233, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800683) ->
	#bmon_group{
		no = 800683,
		name = <<"250级太虚幻境炼狱幻境第27关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90234, 1}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800684) ->
	#bmon_group{
		no = 800684,
		name = <<"250级太虚幻境炼狱幻境第28关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90257,1}, {90235, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800685) ->
	#bmon_group{
		no = 800685,
		name = <<"250级太虚幻境炼狱幻境第29关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90258,1}, {90236, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800686) ->
	#bmon_group{
		no = 800686,
		name = <<"250级太虚幻境炼狱幻境第30关">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.400000,
		mon_pool_fixed = [{90259,1}, {90237, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800687) ->
	#bmon_group{
		no = 800687,
		name = <<"120级蓬莱秘境普通秘境第5关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90239,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800688) ->
	#bmon_group{
		no = 800688,
		name = <<"120级蓬莱秘境普通秘境第7关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90240,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800689) ->
	#bmon_group{
		no = 800689,
		name = <<"120级蓬莱秘境普通秘境第9关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.900000,
		mon_pool_fixed = [{90241,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800690) ->
	#bmon_group{
		no = 800690,
		name = <<"180级蓬莱秘境困难秘境第16关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90239,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800691) ->
	#bmon_group{
		no = 800691,
		name = <<"180级蓬莱秘境困难秘境第19关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90240,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800692) ->
	#bmon_group{
		no = 800692,
		name = <<"180级蓬莱秘境困难秘境第21关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90241,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800693) ->
	#bmon_group{
		no = 800693,
		name = <<"180级蓬莱秘境困难秘境第23关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90242,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800694) ->
	#bmon_group{
		no = 800694,
		name = <<"180级蓬莱秘境困难秘境第25关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{90243,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800695) ->
	#bmon_group{
		no = 800695,
		name = <<"250级蓬莱秘境炼狱秘境第31关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90239,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800696) ->
	#bmon_group{
		no = 800696,
		name = <<"250级蓬莱秘境炼狱秘境第34关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90240,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800697) ->
	#bmon_group{
		no = 800697,
		name = <<"250级蓬莱秘境炼狱秘境第37关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90241,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800698) ->
	#bmon_group{
		no = 800698,
		name = <<"250级蓬莱秘境炼狱秘境第39关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90242,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800699) ->
	#bmon_group{
		no = 800699,
		name = <<"250级蓬莱秘境炼狱秘境第41关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90243,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800700) ->
	#bmon_group{
		no = 800700,
		name = <<"250级蓬莱秘境炼狱秘境第43关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90244,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800701) ->
	#bmon_group{
		no = 800701,
		name = <<"250级蓬莱秘境炼狱秘境第45关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.100000,
		mon_pool_fixed = [{90246,1}],
		mon_pool_normal = [90260, 90261, 90262, 90263, 90264, 90265, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800702) ->
	#bmon_group{
		no = 800702,
		name = <<"120级太虚幻境普通幻境第48关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90244,1}, {90230, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800703) ->
	#bmon_group{
		no = 800703,
		name = <<"120级太虚幻境普通幻境第49关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 9,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90245,1}, {90231, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800704) ->
	#bmon_group{
		no = 800704,
		name = <<"120级太虚幻境普通幻境第51关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90246,1}, {90233, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800705) ->
	#bmon_group{
		no = 800705,
		name = <<"120级太虚幻境普通幻境第52关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90247,1}, {90234, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800706) ->
	#bmon_group{
		no = 800706,
		name = <<"120级太虚幻境普通幻境第54关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90248,1}, {90236, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800707) ->
	#bmon_group{
		no = 800707,
		name = <<"120级太虚幻境普通幻境第55关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90249,1}, {90237, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800708) ->
	#bmon_group{
		no = 800708,
		name = <<"120级太虚幻境普通幻境第57关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90250,1}, {90209, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800709) ->
	#bmon_group{
		no = 800709,
		name = <<"120级太虚幻境普通幻境第58关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90251,1}, {90210, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800710) ->
	#bmon_group{
		no = 800710,
		name = <<"120级太虚幻境普通幻境第60关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90252,1}, {90212, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800711) ->
	#bmon_group{
		no = 800711,
		name = <<"120级太虚幻境普通幻境第61关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90253,1}, {90213, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800712) ->
	#bmon_group{
		no = 800712,
		name = <<"120级太虚幻境普通幻境第63关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90254,1}, {90215, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800713) ->
	#bmon_group{
		no = 800713,
		name = <<"120级太虚幻境普通幻境第64关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90255,1}, {90216, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800714) ->
	#bmon_group{
		no = 800714,
		name = <<"120级太虚幻境普通幻境第65关精英">>,
		lv_range_min = 120,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.200000,
		mon_pool_fixed = [{90256,1}, {90217, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800715) ->
	#bmon_group{
		no = 800715,
		name = <<"180级太虚幻境困难幻境第68关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90239,1}, {90235, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800716) ->
	#bmon_group{
		no = 800716,
		name = <<"180级太虚幻境困难幻境第69关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90242,1}, {90234, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800717) ->
	#bmon_group{
		no = 800717,
		name = <<"180级太虚幻境困难幻境第71关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90243,1}, {90232, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800718) ->
	#bmon_group{
		no = 800718,
		name = <<"180级太虚幻境困难幻境第72关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90244,1}, {90231, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800719) ->
	#bmon_group{
		no = 800719,
		name = <<"180级太虚幻境困难幻境第74关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90245,1}, {90229, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800720) ->
	#bmon_group{
		no = 800720,
		name = <<"180级太虚幻境困难幻境第75关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90246,1}, {90228, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800721) ->
	#bmon_group{
		no = 800721,
		name = <<"180级太虚幻境困难幻境第77关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90247,1}, {90226, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800722) ->
	#bmon_group{
		no = 800722,
		name = <<"180级太虚幻境困难幻境第78关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90248,1}, {90225, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800723) ->
	#bmon_group{
		no = 800723,
		name = <<"180级太虚幻境困难幻境第80关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90249,1}, {90223, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800724) ->
	#bmon_group{
		no = 800724,
		name = <<"180级太虚幻境困难幻境第81关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90250,1}, {90222, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800725) ->
	#bmon_group{
		no = 800725,
		name = <<"180级太虚幻境困难幻境第83关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90251,1}, {90220, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800726) ->
	#bmon_group{
		no = 800726,
		name = <<"180级太虚幻境困难幻境第84关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90252,1}, {90219, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800727) ->
	#bmon_group{
		no = 800727,
		name = <<"180级太虚幻境困难幻境第86关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90253,1}, {90217, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800728) ->
	#bmon_group{
		no = 800728,
		name = <<"180级太虚幻境困难幻境第87关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90254,1}, {90216, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800729) ->
	#bmon_group{
		no = 800729,
		name = <<"180级太虚幻境困难幻境第89关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90255,1}, {90214, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800730) ->
	#bmon_group{
		no = 800730,
		name = <<"180级太虚幻境困难幻境第90关精英">>,
		lv_range_min = 180,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.300000,
		mon_pool_fixed = [{90256,1}, {90213, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800731) ->
	#bmon_group{
		no = 800731,
		name = <<"250级太虚幻境炼狱幻境第93关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90240,1}, {90210, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800732) ->
	#bmon_group{
		no = 800732,
		name = <<"250级太虚幻境炼狱幻境第94关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90241,1}, {90211, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800733) ->
	#bmon_group{
		no = 800733,
		name = <<"250级太虚幻境炼狱幻境第96关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90242,1}, {90213, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800734) ->
	#bmon_group{
		no = 800734,
		name = <<"250级太虚幻境炼狱幻境第97关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90243,1}, {90214, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800735) ->
	#bmon_group{
		no = 800735,
		name = <<"250级太虚幻境炼狱幻境第99关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90244,1}, {90216, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800736) ->
	#bmon_group{
		no = 800736,
		name = <<"250级太虚幻境炼狱幻境第100关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90245,1}, {90217, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800737) ->
	#bmon_group{
		no = 800737,
		name = <<"250级太虚幻境炼狱幻境第102关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90246,1}, {90219, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800738) ->
	#bmon_group{
		no = 800738,
		name = <<"250级太虚幻境炼狱幻境第103关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90247,1}, {90220, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800739) ->
	#bmon_group{
		no = 800739,
		name = <<"250级太虚幻境炼狱幻境第105关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90248,1}, {90222, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800740) ->
	#bmon_group{
		no = 800740,
		name = <<"250级太虚幻境炼狱幻境第106关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90249,1}, {90223, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800741) ->
	#bmon_group{
		no = 800741,
		name = <<"250级太虚幻境炼狱幻境第108关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90250,1}, {90225, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800742) ->
	#bmon_group{
		no = 800742,
		name = <<"250级太虚幻境炼狱幻境第109关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90251,1}, {90226, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800743) ->
	#bmon_group{
		no = 800743,
		name = <<"250级太虚幻境炼狱幻境第111关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90252,1}, {90228, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800744) ->
	#bmon_group{
		no = 800744,
		name = <<"250级太虚幻境炼狱幻境第112关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90253,1}, {90229, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800745) ->
	#bmon_group{
		no = 800745,
		name = <<"250级太虚幻境炼狱幻境第114关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90254,1}, {90231, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800746) ->
	#bmon_group{
		no = 800746,
		name = <<"250级太虚幻境炼狱幻境第115关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90255,1}, {90232, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800747) ->
	#bmon_group{
		no = 800747,
		name = <<"250级太虚幻境炼狱幻境第116关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90256,1}, {90233, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800748) ->
	#bmon_group{
		no = 800748,
		name = <<"250级太虚幻境炼狱幻境第118关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90257,1}, {90235, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800749) ->
	#bmon_group{
		no = 800749,
		name = <<"250级太虚幻境炼狱幻境第119关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90258,1}, {90236, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(800750) ->
	#bmon_group{
		no = 800750,
		name = <<"250级太虚幻境炼狱幻境第120关精英">>,
		lv_range_min = 250,
		lv_range_max = 300,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 10,
		attr_random_range = 0,
		attr_streng = 1.500000,
		mon_pool_fixed = [{90259,1}, {90237, 2}],
		mon_pool_normal = [90266, 90267, 90268, 90269, 90270, 90271, 90238],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1001) ->
	#bmon_group{
		no = 1001,
		name = <<"长安妖乱(单人)">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.450000,
		mon_pool_fixed = [{1001,1},{1002,2},{1003,3},{1002,4},{1003,5},{1004,6},{1005,7},{1005,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1002) ->
	#bmon_group{
		no = 1002,
		name = <<"长安妖乱(组队)">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.450000,
		mon_pool_fixed = [{1006,1},{1007,2},{1008,3},{1007,4},{1008,5},{1009,6},{1009,7},{1009,8},{1010,9},{1010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1003) ->
	#bmon_group{
		no = 1003,
		name = <<"长安盗匪（单人）
">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.450000,
		mon_pool_fixed = [{1011,1},{1012,2},{1013,3},{1012,4},{1013,5},{1014,6},{1015,7},{1015,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1004) ->
	#bmon_group{
		no = 1004,
		name = <<"长安盗匪（组队）
">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.450000,
		mon_pool_fixed = [{1016,1},{1017,2},{1018,3},{1017,4},{1018,5},{1019,6},{1019,7},{1019,8},{1020,9},{1020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1005) ->
	#bmon_group{
		no = 1005,
		name = <<"北冥除妖—红魔">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{1021,1},{1025,2},{1026,3},{1025,4},{1026,5},{1027,6},{1027,7},{1027,8},{1028,9},{1028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1006) ->
	#bmon_group{
		no = 1006,
		name = <<"北冥除妖—魅魔">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{1022,1},{1028,2},{1028,3},{1027,4},{1027,5},{1025,6},{1025,7},{1025,8},{1026,9},{1026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1007) ->
	#bmon_group{
		no = 1007,
		name = <<"北冥除妖—狂魔">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{1023,1},{1025,2},{1025,3},{1026,4},{1026,5},{1028,6},{1028,7},{1028,8},{1027,9},{1027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1008) ->
	#bmon_group{
		no = 1008,
		name = <<"北冥除妖—疯魔">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{1024,1},{1025,2},{1026,3},{1025,4},{1026,5},{1027,6},{1027,7},{1027,8},{1028,9},{1028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1009) ->
	#bmon_group{
		no = 1009,
		name = <<"昆仑神兽—金鹏">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{1029,1},{1036,2},{1036,3},{1035,4},{1035,5},{1034,6},{1034,7},{1034,8},{1033,9},{1033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1010) ->
	#bmon_group{
		no = 1010,
		name = <<"昆仑神兽—冰凤">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{1030,1},{1033,2},{1034,3},{1033,4},{1034,5},{1035,6},{1035,7},{1035,8},{1036,9},{1036,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1011) ->
	#bmon_group{
		no = 1011,
		name = <<"昆仑神兽—白狼">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{1031,1},{1035,2},{1035,3},{1036,4},{1036,5},{1034,6},{1034,7},{1034,8},{1033,9},{1033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1012) ->
	#bmon_group{
		no = 1012,
		name = <<"昆仑神兽—术猿">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1,
		mon_pool_fixed = [{1032,1},{1035,2},{1036,3},{1035,4},{1036,5},{1033,6},{1033,7},{1033,8},{1034,9},{1034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1013) ->
	#bmon_group{
		no = 1013,
		name = <<"深海冰魔★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1037,1},{1060,2},{1060,3},{1059,4},{1059,5},{1057,6},{1057,7},{1057,8},{1058,9},{1058,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1014) ->
	#bmon_group{
		no = 1014,
		name = <<"深海蝰蛇★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1038,1},{1059,2},{1059,3},{1060,4},{1060,5},{1058,6},{1058,7},{1058,8},{1057,9},{1057,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1015) ->
	#bmon_group{
		no = 1015,
		name = <<"深海女皇★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1039,1},{1057,2},{1057,3},{1059,4},{1059,5},{1058,6},{1058,7},{1058,8},{1060,9},{1060,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1016) ->
	#bmon_group{
		no = 1016,
		name = <<"深海姣王★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1040,1},{1058,2},{1058,3},{1057,4},{1057,5},{1060,6},{1059,7},{1059,8},{1060,9},{1060,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1017) ->
	#bmon_group{
		no = 1017,
		name = <<"深海冰魔★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1041,1},{1123,2},{1123,3},{1122,4},{1122,5},{1120,6},{1120,7},{1120,8},{1121,9},{1121,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1018) ->
	#bmon_group{
		no = 1018,
		name = <<"深海蝰蛇★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1042,1},{1122,2},{1122,3},{1123,4},{1123,5},{1121,6},{1121,7},{1121,8},{1120,9},{1120,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1019) ->
	#bmon_group{
		no = 1019,
		name = <<"深海女皇★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1043,1},{1120,2},{1120,3},{1122,4},{1122,5},{1121,6},{1121,7},{1121,8},{1123,9},{1123,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1020) ->
	#bmon_group{
		no = 1020,
		name = <<"深海姣王★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1044,1},{1121,2},{1121,3},{1120,4},{1120,5},{1123,6},{1122,7},{1122,8},{1123,9},{1123,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1021) ->
	#bmon_group{
		no = 1021,
		name = <<"深海冰魔★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1045,1},{1127,2},{1127,3},{1126,4},{1126,5},{1124,6},{1124,7},{1124,8},{1125,9},{1125,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1022) ->
	#bmon_group{
		no = 1022,
		name = <<"深海蝰蛇★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1046,1},{1126,2},{1126,3},{1127,4},{1127,5},{1125,6},{1125,7},{1125,8},{1124,9},{1124,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1023) ->
	#bmon_group{
		no = 1023,
		name = <<"深海女皇★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1047,1},{1124,2},{1124,3},{1126,4},{1126,5},{1125,6},{1125,7},{1125,8},{1127,9},{1127,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1024) ->
	#bmon_group{
		no = 1024,
		name = <<"深海姣王★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1048,1},{1125,2},{1125,3},{1124,4},{1124,5},{1127,6},{1126,7},{1126,8},{1127,9},{1127,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1025) ->
	#bmon_group{
		no = 1025,
		name = <<"深海冰魔★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1049,1},{1131,2},{1131,3},{1130,4},{1130,5},{1128,6},{1128,7},{1128,8},{1129,9},{1129,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1026) ->
	#bmon_group{
		no = 1026,
		name = <<"深海蝰蛇★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1050,1},{1130,2},{1130,3},{1131,4},{1131,5},{1129,6},{1129,7},{1129,8},{1128,9},{1128,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1027) ->
	#bmon_group{
		no = 1027,
		name = <<"深海女皇★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1051,1},{1128,2},{1128,3},{1130,4},{1130,5},{1129,6},{1129,7},{1129,8},{1131,9},{1131,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1028) ->
	#bmon_group{
		no = 1028,
		name = <<"深海姣王★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1052,1},{1129,2},{1129,3},{1128,4},{1128,5},{1131,6},{1130,7},{1130,8},{1131,9},{1131,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1029) ->
	#bmon_group{
		no = 1029,
		name = <<"深海冰魔★★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1053,1},{1135,2},{1135,3},{1134,4},{1134,5},{1132,6},{1132,7},{1132,8},{1133,9},{1133,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1030) ->
	#bmon_group{
		no = 1030,
		name = <<"深海蝰蛇★★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1054,1},{1134,2},{1134,3},{1135,4},{1135,5},{1133,6},{1133,7},{1133,8},{1132,9},{1132,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1031) ->
	#bmon_group{
		no = 1031,
		name = <<"深海女皇★★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1055,1},{1132,2},{1132,3},{1134,4},{1134,5},{1133,6},{1133,7},{1133,8},{1135,9},{1135,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1032) ->
	#bmon_group{
		no = 1032,
		name = <<"深海姣王★★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1056,1},{1133,2},{1133,3},{1132,4},{1132,5},{1135,6},{1134,7},{1134,8},{1135,9},{1135,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1033) ->
	#bmon_group{
		no = 1033,
		name = <<"蓬莱仙子★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1061,1},{1082,2},{1082,3},{1084,4},{1084,5},{1083,6},{1083,7},{1083,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1034) ->
	#bmon_group{
		no = 1034,
		name = <<"蓬莱阎王★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1062,1},{1084,2},{1084,3},{1082,4},{1082,5},{1083,6},{1083,7},{1083,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1035) ->
	#bmon_group{
		no = 1035,
		name = <<"蓬莱圣女★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1063,1},{1083,2},{1083,3},{1082,4},{1082,5},{1084,6},{1084,7},{1084,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1036) ->
	#bmon_group{
		no = 1036,
		name = <<"蓬莱剑神★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1064,1},{1081,2},{1082,3},{1081,4},{1082,5},{1084,6},{1083,7},{1083,8},{1084,9},{1084,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1037) ->
	#bmon_group{
		no = 1037,
		name = <<"蓬莱仙子★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1065,1},{1082,2},{1082,3},{1084,4},{1084,5},{1083,6},{1083,7},{1083,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1038) ->
	#bmon_group{
		no = 1038,
		name = <<"蓬莱阎王★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1066,1},{1084,2},{1084,3},{1082,4},{1082,5},{1083,6},{1083,7},{1083,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1039) ->
	#bmon_group{
		no = 1039,
		name = <<"蓬莱圣女★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1067,1},{1083,2},{1083,3},{1082,4},{1082,5},{1084,6},{1084,7},{1084,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1040) ->
	#bmon_group{
		no = 1040,
		name = <<"蓬莱剑神★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1068,1},{1081,2},{1082,3},{1081,4},{1082,5},{1084,6},{1083,7},{1083,8},{1084,9},{1084,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1041) ->
	#bmon_group{
		no = 1041,
		name = <<"蓬莱仙子★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1069,1},{1082,2},{1082,3},{1084,4},{1084,5},{1083,6},{1083,7},{1083,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1042) ->
	#bmon_group{
		no = 1042,
		name = <<"蓬莱阎王★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1070,1},{1084,2},{1084,3},{1082,4},{1082,5},{1083,6},{1083,7},{1083,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1043) ->
	#bmon_group{
		no = 1043,
		name = <<"蓬莱圣女★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1071,1},{1083,2},{1083,3},{1082,4},{1082,5},{1084,6},{1084,7},{1084,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1044) ->
	#bmon_group{
		no = 1044,
		name = <<"蓬莱剑神★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1072,1},{1081,2},{1082,3},{1081,4},{1082,5},{1084,6},{1083,7},{1083,8},{1084,9},{1084,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1045) ->
	#bmon_group{
		no = 1045,
		name = <<"蓬莱仙子★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1073,1},{1082,2},{1082,3},{1084,4},{1084,5},{1083,6},{1083,7},{1083,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1046) ->
	#bmon_group{
		no = 1046,
		name = <<"蓬莱阎王★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1074,1},{1084,2},{1084,3},{1082,4},{1082,5},{1083,6},{1083,7},{1083,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1047) ->
	#bmon_group{
		no = 1047,
		name = <<"蓬莱圣女★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1075,1},{1083,2},{1083,3},{1082,4},{1082,5},{1084,6},{1084,7},{1084,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1048) ->
	#bmon_group{
		no = 1048,
		name = <<"蓬莱剑神★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1076,1},{1081,2},{1082,3},{1081,4},{1082,5},{1084,6},{1083,7},{1083,8},{1084,9},{1084,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1049) ->
	#bmon_group{
		no = 1049,
		name = <<"蓬莱仙子★★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1077,1},{1082,2},{1082,3},{1084,4},{1084,5},{1083,6},{1083,7},{1083,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1050) ->
	#bmon_group{
		no = 1050,
		name = <<"蓬莱阎王★★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1078,1},{1084,2},{1084,3},{1082,4},{1082,5},{1083,6},{1083,7},{1083,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1051) ->
	#bmon_group{
		no = 1051,
		name = <<"蓬莱圣女★★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1079,1},{1083,2},{1083,3},{1082,4},{1082,5},{1084,6},{1084,7},{1084,8},{1081,9},{1081,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1052) ->
	#bmon_group{
		no = 1052,
		name = <<"蓬莱剑神★★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1080,1},{1081,2},{1082,3},{1081,4},{1082,5},{1084,6},{1083,7},{1083,8},{1084,9},{1084,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1053) ->
	#bmon_group{
		no = 1053,
		name = <<"白虎圣兽★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1085,1},{1110,6},{1110,7},{1110,8},{1110,9},{1110,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1054) ->
	#bmon_group{
		no = 1054,
		name = <<"朱雀圣兽★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1086,1},{1112,6},{1112,7},{1112,8},{1112,9},{1112,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1055) ->
	#bmon_group{
		no = 1055,
		name = <<"玄武圣兽★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1087,1},{1111,6},{1111,7},{1111,8},{1111,9},{1111,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1056) ->
	#bmon_group{
		no = 1056,
		name = <<"黑龙圣兽★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1088,1},{1113,6},{1113,7},{1113,8},{1113,9},{1113,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1057) ->
	#bmon_group{
		no = 1057,
		name = <<"白虎圣兽★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1089,1},{1110,6},{1110,7},{1110,8},{1110,9},{1110,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1058) ->
	#bmon_group{
		no = 1058,
		name = <<"朱雀圣兽★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1090,1},{1112,6},{1112,7},{1112,8},{1112,9},{1112,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1059) ->
	#bmon_group{
		no = 1059,
		name = <<"玄武圣兽★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1091,1},{1111,6},{1111,7},{1111,8},{1111,9},{1111,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1060) ->
	#bmon_group{
		no = 1060,
		name = <<"黑龙圣兽★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1092,1},{1113,6},{1113,7},{1113,8},{1113,9},{1113,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1061) ->
	#bmon_group{
		no = 1061,
		name = <<"白虎圣兽★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1093,1},{1110,6},{1110,7},{1110,8},{1110,9},{1110,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1062) ->
	#bmon_group{
		no = 1062,
		name = <<"朱雀圣兽★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1094,1},{1112,6},{1112,7},{1112,8},{1112,9},{1112,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1063) ->
	#bmon_group{
		no = 1063,
		name = <<"玄武圣兽★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1095,1},{1111,6},{1111,7},{1111,8},{1111,9},{1111,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1064) ->
	#bmon_group{
		no = 1064,
		name = <<"黑龙圣兽★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1096,1},{1113,6},{1113,7},{1113,8},{1113,9},{1113,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1065) ->
	#bmon_group{
		no = 1065,
		name = <<"白虎圣兽★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1097,1},{1110,6},{1110,7},{1110,8},{1110,9},{1110,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1066) ->
	#bmon_group{
		no = 1066,
		name = <<"朱雀圣兽★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1098,1},{1112,6},{1112,7},{1112,8},{1112,9},{1112,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1067) ->
	#bmon_group{
		no = 1067,
		name = <<"玄武圣兽★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1099,1},{1111,6},{1111,7},{1111,8},{1111,9},{1111,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1068) ->
	#bmon_group{
		no = 1068,
		name = <<"黑龙圣兽★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1100,1},{1113,6},{1113,7},{1113,8},{1113,9},{1113,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1069) ->
	#bmon_group{
		no = 1069,
		name = <<"白虎圣兽★★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1101,1},{1110,6},{1110,7},{1110,8},{1110,9},{1110,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1070) ->
	#bmon_group{
		no = 1070,
		name = <<"朱雀圣兽★★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1102,1},{1112,6},{1112,7},{1112,8},{1112,9},{1112,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1071) ->
	#bmon_group{
		no = 1071,
		name = <<"玄武圣兽★★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1103,1},{1111,6},{1111,7},{1111,8},{1111,9},{1111,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1072) ->
	#bmon_group{
		no = 1072,
		name = <<"黑龙圣兽★★★★★">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{1104,1},{1113,6},{1113,7},{1113,8},{1113,9},{1113,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(1101) ->
	#bmon_group{
		no = 1101,
		name = <<"挑战魔龙">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1895.868},
		mon_pool_fixed = [{58031,6}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2001) ->
	#bmon_group{
		no = 2001,
		name = <<"主线任务1怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1.302},
		mon_pool_fixed = [{20001,1},{10001,2},{10001,3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2002) ->
	#bmon_group{
		no = 2002,
		name = <<"主线任务2怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2.263},
		mon_pool_fixed = [{20024,1},{10001,2},{10001,3},{10029,4},{10029,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2003) ->
	#bmon_group{
		no = 2003,
		name = <<"主线任务3怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4.462},
		mon_pool_fixed = [{20003,1},{10006,2},{10006,3},{10029,4},{10029,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2004) ->
	#bmon_group{
		no = 2004,
		name = <<"主线任务4怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7.263},
		mon_pool_fixed = [{20001,1},{10032,2},{10032,3},{10029,4},{10029,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2005) ->
	#bmon_group{
		no = 2005,
		name = <<"主线任务5怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,11.622},
		mon_pool_fixed = [{20016,1},{10006,2},{10006,3},{10007,4},{10007,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2006) ->
	#bmon_group{
		no = 2006,
		name = <<"主线任务6怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,19.601},
		mon_pool_fixed = [{20027,1},{10032,2},{10032,3},{10035,4},{10035,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2007) ->
	#bmon_group{
		no = 2007,
		name = <<"主线任务7怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,21.611},
		mon_pool_fixed = [{20012,1},{10031,2},{10031,3},{10015,4},{10015,5},{10001,6},{10001,7}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2008) ->
	#bmon_group{
		no = 2008,
		name = <<"主线任务8怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,26.347},
		mon_pool_fixed = [{20015,1},{10001,2},{10001,3},{10029,4},{10029,5},{10006,6},{10006,7}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2009) ->
	#bmon_group{
		no = 2009,
		name = <<"主线任务9怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27.473},
		mon_pool_fixed = [{20024,1},{10032,2},{10032,3},{10006,4},{10006,5},{10029,6},{10029,7}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2010) ->
	#bmon_group{
		no = 2010,
		name = <<"主线任务10怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,36.482},
		mon_pool_fixed = [{20023,1},{10033,2},{10033,3},{10008,4},{10008,5},{10031,6},{10031,7}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2011) ->
	#bmon_group{
		no = 2011,
		name = <<"主线任务11怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,40.75},
		mon_pool_fixed = [{20010,1},{10003,2},{10003,3},{10008,4},{10008,5},{10035,6},{10035,7}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2012) ->
	#bmon_group{
		no = 2012,
		name = <<"主线任务12怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,67.308},
		mon_pool_fixed = [{20005,1},{10008,2},{10008,3},{10003,4},{10003,5},{10032,6},{10032,7}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2013) ->
	#bmon_group{
		no = 2013,
		name = <<"主线任务13怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,75.833},
		mon_pool_fixed = [{20022,1},{10031,2},{10031,3},{10035,4},{10035,5},{10001,6},{10001,7}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2014) ->
	#bmon_group{
		no = 2014,
		name = <<"主线任务14怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,86.778},
		mon_pool_fixed = [{20030,1},{10033,2},{10033,3},{10031,4},{10031,5},{10015,6},{10015,7}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2015) ->
	#bmon_group{
		no = 2015,
		name = <<"主线任务15怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,89.949},
		mon_pool_fixed = [{20011,1},{10015,2},{10015,3},{10007,4},{10007,5},{10029,6},{10006,7},{10006,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2016) ->
	#bmon_group{
		no = 2016,
		name = <<"主线任务16怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,98.185},
		mon_pool_fixed = [{20035,1},{10032,2},{10032,3},{10008,4},{10008,5},{10020,6},{10001,7},{10001,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2017) ->
	#bmon_group{
		no = 2017,
		name = <<"主线任务17怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,105.887},
		mon_pool_fixed = [{20025,1},{10033,2},{10033,3},{10015,4},{10015,5},{10031,6},{10031,7},{10031,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2018) ->
	#bmon_group{
		no = 2018,
		name = <<"主线任务18怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,182.357},
		mon_pool_fixed = [{20028,1},{10006,2},{10006,3},{10033,4},{10033,5},{10033,6},{10029,7},{10029,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2019) ->
	#bmon_group{
		no = 2019,
		name = <<"主线任务19怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,233.725},
		mon_pool_fixed = [{20036,1},{10003,2},{10003,3},{10007,4},{10007,5},{10008,6},{10008,7},{10008,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2020) ->
	#bmon_group{
		no = 2020,
		name = <<"主线任务20怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,309.065},
		mon_pool_fixed = [{20019,1},{10007,2},{10007,3},{10006,4},{10006,5},{10029,6},{10029,7},{10029,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2021) ->
	#bmon_group{
		no = 2021,
		name = <<"主线任务21怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,463.125},
		mon_pool_fixed = [{20027,1},{10032,2},{10032,3},{10006,4},{10006,5},{10020,6},{10020,7},{10020,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2022) ->
	#bmon_group{
		no = 2022,
		name = <<"主线任务22怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,583.314},
		mon_pool_fixed = [{20024,1},{10033,2},{10033,3},{10032,4},{10032,5},{10008,6},{10035,7},{10035,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2023) ->
	#bmon_group{
		no = 2023,
		name = <<"主线任务23怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,708.49},
		mon_pool_fixed = [{20026,1},{10007,2},{10007,3},{10020,4},{10020,5},{10031,6},{10031,7},{10031,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2024) ->
	#bmon_group{
		no = 2024,
		name = <<"主线任务24怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,951.137},
		mon_pool_fixed = [{20018,1},{10008,2},{10008,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2025) ->
	#bmon_group{
		no = 2025,
		name = <<"主线任务25怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1024.804},
		mon_pool_fixed = [{20021,1},{10007,2},{10007,3},{10006,4},{10006,5},{10015,6},{10015,7},{10015,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2026) ->
	#bmon_group{
		no = 2026,
		name = <<"主线任务26怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1192.877},
		mon_pool_fixed = [{20023,1},{10033,2},{10033,3},{10008,4},{10008,5},{10031,6},{10031,7},{10031,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2027) ->
	#bmon_group{
		no = 2027,
		name = <<"主线任务27怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1654.68},
		mon_pool_fixed = [{20022,1},{10031,2},{10031,3},{100032,4},{10032,5},{10006,6},{10007,7},{10007,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2028) ->
	#bmon_group{
		no = 2028,
		name = <<"主线任务28怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1895.868},
		mon_pool_fixed = [{20031,1},{10033,2},{10033,3},{10032,4},{10032,5},{10008,6},{10008,7},{10008,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2029) ->
	#bmon_group{
		no = 2029,
		name = <<"主线任务29怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2296.036},
		mon_pool_fixed = [{20015,1},{10001,2},{10001,3},{10029,4},{10029,5},{10020,6},{10020,7},{10020,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2030) ->
	#bmon_group{
		no = 2030,
		name = <<"主线任务30怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2703.113},
		mon_pool_fixed = [{20032,1},{10007,2},{10007,3},{10006,4},{10006,5},{10020,6},{10020,7},{10020,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2031) ->
	#bmon_group{
		no = 2031,
		name = <<"主线任务31怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3006.127},
		mon_pool_fixed = [{20008,1},{10032,2},{10032,3},{10007,4},{10007,5},{10020,6},{10020,7},{10020,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2032) ->
	#bmon_group{
		no = 2032,
		name = <<"主线任务32怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3370.92},
		mon_pool_fixed = [{20015,1},{10001,2},{10001,3},{10029,4},{10029,5},{10020,6},{10020,7},{10020,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2033) ->
	#bmon_group{
		no = 2033,
		name = <<"主线任务33怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3998.454},
		mon_pool_fixed = [{20048,1},{10037,2},{10037,3},{10022,4},{10022,5},{10035,6},{10035,7},{10035,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2034) ->
	#bmon_group{
		no = 2034,
		name = <<"主线任务34怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4500.824},
		mon_pool_fixed = [{20039,1},{10033,2},{10033,3},{10026,4},{10026,5},{10021,6},{10003,7},{10003,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2035) ->
	#bmon_group{
		no = 2035,
		name = <<"主线任务35怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4966.275},
		mon_pool_fixed = [{20040,1},{10008,2},{10008,3},{10011,4},{10011,5},{10025,6},{10031,7},{10031,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2036) ->
	#bmon_group{
		no = 2036,
		name = <<"主线任务36怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5486.402},
		mon_pool_fixed = [{20092,1},{10033,2},{10033,3},{10008,4},{10008,5},{10004,6},{10004,7},{10004,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2037) ->
	#bmon_group{
		no = 2037,
		name = <<"主线任务37怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6329.381},
		mon_pool_fixed = [{20091,1},{10033,2},{10033,3},{10008,4},{10008,5},{10004,6},{10004,7},{10004,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2038) ->
	#bmon_group{
		no = 2038,
		name = <<"主线任务38怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6613.527},
		mon_pool_fixed = [{20090,1},{10033,2},{10033,3},{10008,4},{10008,5},{10004,6},{10004,7},{10004,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2039) ->
	#bmon_group{
		no = 2039,
		name = <<"主线任务39怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7693.994},
		mon_pool_fixed = [{20054,1},{10037,2},{10037,3},{10036,4},{10036,5},{10015,6},{10015,7},{10015,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2040) ->
	#bmon_group{
		no = 2040,
		name = <<"主线任务40怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8490.495},
		mon_pool_fixed = [{20014,1},{10012,2},{10012,3},{10023,4},{10023,5},{10001,6},{10001,7},{10001,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2041) ->
	#bmon_group{
		no = 2041,
		name = <<"主线任务41怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8745.036},
		mon_pool_fixed = [{20005,1},{10003,2},{10003,3},{10032,4},{10032,5},{10007,6},{10008,7},{10008,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2042) ->
	#bmon_group{
		no = 2042,
		name = <<"主线任务42怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,9003.971},
		mon_pool_fixed = [{20037,1},{10032,2},{10032,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2043) ->
	#bmon_group{
		no = 2043,
		name = <<"主线任务43怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,12063.12},
		mon_pool_fixed = [{20040,1},{10008,2},{10008,3},{10011,4},{10011,5},{10025,6},{10031,7},{10031,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2044) ->
	#bmon_group{
		no = 2044,
		name = <<"主线任务44怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,12808.063},
		mon_pool_fixed = [{20042,1},{10022,2},{10022,3},{10026,4},{10026,5},{10015,6},{10015,7},{10015,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2045) ->
	#bmon_group{
		no = 2045,
		name = <<"主线任务45怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,13488.109},
		mon_pool_fixed = [{20043,1},{10003,2},{10003,3},{10020,4},{10020,5},{10032,6},{10032,7},{10032,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2046) ->
	#bmon_group{
		no = 2046,
		name = <<"主线任务46怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,17056.411},
		mon_pool_fixed = [{20045,1},{10015,2},{10015,3},{10029,4},{10029,5},{10020,6},{10020,7},{10020,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2047) ->
	#bmon_group{
		no = 2047,
		name = <<"主线任务47怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,17944.325},
		mon_pool_fixed = [{20048,1},{10037,2},{10037,3},{10022,4},{10022,5},{10035,6},{10035,7},{10035,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2048) ->
	#bmon_group{
		no = 2048,
		name = <<"主线任务48怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,19217.124},
		mon_pool_fixed = [{20049,1},{10036,2},{10036,3},{10008,4},{10008,5},{10031,6},{10031,7},{10031,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2049) ->
	#bmon_group{
		no = 2049,
		name = <<"主线任务49怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,23698.468},
		mon_pool_fixed = [{20044,1},{10021,2},{10021,3},{10023,4},{10023,5},{10035,6},{10035,7},{10035,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2050) ->
	#bmon_group{
		no = 2050,
		name = <<"主线任务50怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,24820.357},
		mon_pool_fixed = [{20038,1},{10013,2},{10013,3},{10008,4},{10008,5},{10035,6},{10035,7},{10035,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2051) ->
	#bmon_group{
		no = 2051,
		name = <<"主线任务51怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,26089.612},
		mon_pool_fixed = [{20046,1},{10016,2},{10016,3},{10013,4},{10013,5},{10032,6},{10032,7},{10032,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2052) ->
	#bmon_group{
		no = 2052,
		name = <<"主线任务52怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,31118.582},
		mon_pool_fixed = [{20087,1},{10016,2},{10016,3},{10013,4},{10013,5},{10015,6},{10015,7},{10015,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2053) ->
	#bmon_group{
		no = 2053,
		name = <<"主线任务53怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,34438.063},
		mon_pool_fixed = [{20088,1},{10002,2},{10002,3},{10009,4},{10009,5},{10024,6},{10024,7},{10024,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2054) ->
	#bmon_group{
		no = 2054,
		name = <<"主线任务54怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,37089.435},
		mon_pool_fixed = [{20089,1},{10037,2},{10037,3},{10002,4},{10002,5},{10021,6},{10023,7},{10023,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2093) ->
	#bmon_group{
		no = 2093,
		name = <<"主线任务3怪物组（补充）">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4.462},
		mon_pool_fixed = [{20093,1},{10001,2},{10001,3},{10029,4},{10029,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2094) ->
	#bmon_group{
		no = 2094,
		name = <<"主线任务3怪物组（补充）">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4.462},
		mon_pool_fixed = [{20094,1},{10001,2},{10001,3},{10029,4},{10029,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2095) ->
	#bmon_group{
		no = 2095,
		name = <<"主线任务3怪物组（补充）">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4.462},
		mon_pool_fixed = [{20095,1},{10001,2},{10001,3},{10029,4},{10029,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2096) ->
	#bmon_group{
		no = 2096,
		name = <<"主线任务3怪物组（补充）">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4.462},
		mon_pool_fixed = [{20096,1},{10001,2},{10001,3},{10029,4},{10029,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2097) ->
	#bmon_group{
		no = 2097,
		name = <<"主线任务1怪物组（补充）">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1.302},
		mon_pool_fixed = [{20097,1},{10001,2},{10001,3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2098) ->
	#bmon_group{
		no = 2098,
		name = <<"主线任务1怪物组（补充）">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1.302},
		mon_pool_fixed = [{20098,1},{10001,2},{10001,3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2099) ->
	#bmon_group{
		no = 2099,
		name = <<"主线任务1怪物组（补充）">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1.302},
		mon_pool_fixed = [{20099,1},{10001,2},{10001,3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2100) ->
	#bmon_group{
		no = 2100,
		name = <<"主线任务1怪物组（补充）">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1.302},
		mon_pool_fixed = [{20100,1},{10001,2},{10001,3}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2101) ->
	#bmon_group{
		no = 2101,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20301,1},{10005,2},{10007,3},{10005,4},{10007,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2102) ->
	#bmon_group{
		no = 2102,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20302,1},{10012,2},{10014,3},{10012,4},{10014,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2103) ->
	#bmon_group{
		no = 2103,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20303,1},{10015,2},{10020,3},{10015,4},{10020,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2104) ->
	#bmon_group{
		no = 2104,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20304,1},{10010,2},{10024,3},{10010,4},{10024,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2105) ->
	#bmon_group{
		no = 2105,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20305,1},{10025,2},{10032,3},{10025,4},{10032,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2106) ->
	#bmon_group{
		no = 2106,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20306,1},{10005,2},{10007,3},{10005,4},{10007,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2107) ->
	#bmon_group{
		no = 2107,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20307,1},{10012,2},{10014,3},{10012,4},{10014,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2108) ->
	#bmon_group{
		no = 2108,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20308,1},{10015,2},{10020,3},{10015,4},{10020,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2109) ->
	#bmon_group{
		no = 2109,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20309,1},{10010,2},{10024,3},{10010,4},{10024,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2110) ->
	#bmon_group{
		no = 2110,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20310,1},{10025,2},{10032,3},{10025,4},{10032,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2111) ->
	#bmon_group{
		no = 2111,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20311,1},{10031,2},{10031,3},{10031,4},{10031,5},{10037,6},{10037,7},{10037,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2112) ->
	#bmon_group{
		no = 2112,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20312,1},{10035,2},{10035,3},{10035,4},{10035,5},{10027,6},{10027,7},{10027,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2113) ->
	#bmon_group{
		no = 2113,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20313,1},{10021,2},{10021,3},{10021,4},{10021,5},{10018,6},{10018,7},{10018,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2114) ->
	#bmon_group{
		no = 2114,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20314,1},{10003,2},{10003,3},{10003,4},{10003,5},{10008,6},{10008,7},{10008,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2115) ->
	#bmon_group{
		no = 2115,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20315,1},{10024,2},{10024,3},{10024,4},{10024,5},{10022,6},{10022,7},{10022,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2116) ->
	#bmon_group{
		no = 2116,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20316,1},{10031,2},{10031,3},{10031,4},{10031,5},{10037,6},{10037,7},{10037,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2117) ->
	#bmon_group{
		no = 2117,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20317,1},{10035,2},{10035,3},{10035,4},{10035,5},{10027,6},{10027,7},{10027,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2118) ->
	#bmon_group{
		no = 2118,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20318,1},{10021,2},{10021,3},{10021,4},{10021,5},{10018,6},{10018,7},{10018,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2119) ->
	#bmon_group{
		no = 2119,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20319,1},{10003,2},{10003,3},{10003,4},{10003,5},{10008,6},{10008,7},{10008,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2120) ->
	#bmon_group{
		no = 2120,
		name = <<"师门任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20320,1},{10024,2},{10024,3},{10024,4},{10024,5},{10022,6},{10022,7},{10022,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2201) ->
	#bmon_group{
		no = 2201,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20401,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2202) ->
	#bmon_group{
		no = 2202,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20402,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2203) ->
	#bmon_group{
		no = 2203,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20403,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2204) ->
	#bmon_group{
		no = 2204,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20404,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2205) ->
	#bmon_group{
		no = 2205,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20405,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2206) ->
	#bmon_group{
		no = 2206,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20406,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2207) ->
	#bmon_group{
		no = 2207,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20407,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2208) ->
	#bmon_group{
		no = 2208,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20408,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2209) ->
	#bmon_group{
		no = 2209,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20409,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2210) ->
	#bmon_group{
		no = 2210,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20410,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2211) ->
	#bmon_group{
		no = 2211,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20411,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2212) ->
	#bmon_group{
		no = 2212,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20412,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2213) ->
	#bmon_group{
		no = 2213,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20413,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2214) ->
	#bmon_group{
		no = 2214,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20414,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2215) ->
	#bmon_group{
		no = 2215,
		name = <<"抓鬼任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 8,
		attr_random_range = 0,
		attr_streng = 0.700000,
		mon_pool_fixed = [{20415,1}],
		mon_pool_normal = [20416, 20417, 20418, 20419, 20420, 20421, 20422, 20423, 20424, 20425],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2311) ->
	#bmon_group{
		no = 2311,
		name = <<"宝图任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20501,1},{20506,2},{20506,3},{20506,4},{20506,5},{20507,6},{20507,7},{20507,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2312) ->
	#bmon_group{
		no = 2312,
		name = <<"宝图任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20502,1},{20507,2},{20507,3},{20507,4},{20507,5},{20506,6},{20506,7},{20506,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2313) ->
	#bmon_group{
		no = 2313,
		name = <<"宝图任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20503,1},{20508,2},{20508,3},{20508,4},{20508,5},{20509,6},{20509,7},{20509,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2314) ->
	#bmon_group{
		no = 2314,
		name = <<"宝图任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20504,1},{20509,2},{20509,3},{20509,4},{20509,5},{20508,6},{20508,7},{20508,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2315) ->
	#bmon_group{
		no = 2315,
		name = <<"宝图任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20505,1},{20510,2},{20510,3},{20510,4},{20510,5},{20507,6},{20507,7},{20507,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2401) ->
	#bmon_group{
		no = 2401,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20601,1},{10005,2},{10005,3},{10005,4},{10005,5},{10007,6},{10007,7},{10007,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2402) ->
	#bmon_group{
		no = 2402,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20602,1},{10008,2},{10008,3},{10008,4},{10008,5},{10011,6},{10011,7},{10011,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2403) ->
	#bmon_group{
		no = 2403,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20603,1},{10012,2},{10012,3},{10012,4},{10012,5},{10015,6},{10015,7},{10015,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2404) ->
	#bmon_group{
		no = 2404,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20604,1},{10014,2},{10014,3},{10014,4},{10014,5},{10010,6},{10010,7},{10010,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2405) ->
	#bmon_group{
		no = 2405,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20605,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2406) ->
	#bmon_group{
		no = 2406,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20606,1},{10024,2},{10024,3},{10024,4},{10024,5},{10025,6},{10025,7},{10025,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2407) ->
	#bmon_group{
		no = 2407,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20607,1},{10031,2},{10031,3},{10031,4},{10031,5},{10029,6},{10029,7},{10029,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2408) ->
	#bmon_group{
		no = 2408,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20608,1},{10032,2},{10032,3},{10032,4},{10032,5},{10033,6},{10033,7},{10033,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2409) ->
	#bmon_group{
		no = 2409,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [{20609,1},{10035,2},{10035,3},{10035,4},{10035,5},{10037,6},{10037,7},{10037,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2410) ->
	#bmon_group{
		no = 2410,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20610,1},{10005,2},{10005,3},{10005,4},{10005,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2411) ->
	#bmon_group{
		no = 2411,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20611,1},{10008,2},{10008,3},{10008,4},{10008,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2412) ->
	#bmon_group{
		no = 2412,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20612,1},{10012,2},{10012,3},{10012,4},{10012,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2413) ->
	#bmon_group{
		no = 2413,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20613,1},{10014,2},{10014,3},{10014,4},{10014,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2414) ->
	#bmon_group{
		no = 2414,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20614,1},{10020,2},{10020,3},{10020,4},{10020,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2415) ->
	#bmon_group{
		no = 2415,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20615,1},{10024,2},{10024,3},{10024,4},{10024,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2416) ->
	#bmon_group{
		no = 2416,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20616,1},{10031,2},{10031,3},{10031,4},{10031,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2417) ->
	#bmon_group{
		no = 2417,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20617,1},{10032,2},{10032,3},{10032,4},{10032,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2418) ->
	#bmon_group{
		no = 2418,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20618,1},{10035,2},{10035,3},{10035,4},{10035,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2419) ->
	#bmon_group{
		no = 2419,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20619,1},{10020,2},{10020,3},{10020,4},{10020,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2420) ->
	#bmon_group{
		no = 2420,
		name = <<"帮派任务怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.500000,
		mon_pool_fixed = [{20620,1},{10024,2},{10024,3},{10024,4},{10024,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(2501) ->
	#bmon_group{
		no = 2501,
		name = <<"蟠桃盛会怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 2,
		force_spawn_mon_count = 5,
		attr_random_range = 0,
		attr_streng = 0.350000,
		mon_pool_fixed = [],
		mon_pool_normal = [21001],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3001) ->
	#bmon_group{
		no = 3001,
		name = <<"伏魔塔1层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,88.23},
		mon_pool_fixed = [{10101,1},{10001,2},{10001,3},{10003,4},{10003,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3002) ->
	#bmon_group{
		no = 3002,
		name = <<"伏魔塔2层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,98.467},
		mon_pool_fixed = [{10102,1},{10002,2},{10002,3},{10004,4},{10004,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3003) ->
	#bmon_group{
		no = 3003,
		name = <<"伏魔塔3层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,112.204},
		mon_pool_fixed = [{10103,1},{10003,2},{10003,3},{10005,4},{10005,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3004) ->
	#bmon_group{
		no = 3004,
		name = <<"伏魔塔4层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,125.943},
		mon_pool_fixed = [{10104,1},{10004,2},{10004,3},{10006,4},{10006,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3005) ->
	#bmon_group{
		no = 3005,
		name = <<"伏魔塔5层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,160.512},
		mon_pool_fixed = [{10105,1},{10005,2},{10005,3},{10007,4},{10007,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3006) ->
	#bmon_group{
		no = 3006,
		name = <<"伏魔塔6层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,199.076},
		mon_pool_fixed = [{10106,1},{10006,2},{10006,3},{10008,4},{10008,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3007) ->
	#bmon_group{
		no = 3007,
		name = <<"伏魔塔7层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,236.496},
		mon_pool_fixed = [{10107,1},{10007,2},{10007,3},{10009,4},{10009,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3008) ->
	#bmon_group{
		no = 3008,
		name = <<"伏魔塔8层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,276.935},
		mon_pool_fixed = [{10108,1},{10008,2},{10008,3},{10010,4},{10010,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3009) ->
	#bmon_group{
		no = 3009,
		name = <<"伏魔塔9层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,313.952},
		mon_pool_fixed = [{10109,1},{10009,2},{10009,3},{10011,4},{10011,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3010) ->
	#bmon_group{
		no = 3010,
		name = <<"伏魔塔10层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,346.479},
		mon_pool_fixed = [{10110,1},{10010,2},{10010,3},{10012,4},{10012,5}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3011) ->
	#bmon_group{
		no = 3011,
		name = <<"伏魔塔11层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,380.59},
		mon_pool_fixed = [{10111,1},{10011,2},{10011,3},{10013,4},{10013,5},{10017,6},{10017,7},{10017,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3012) ->
	#bmon_group{
		no = 3012,
		name = <<"伏魔塔12层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,394.075},
		mon_pool_fixed = [{10112,1},{10012,2},{10012,3},{10014,4},{10014,5},{10018,6},{10018,7},{10018,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3013) ->
	#bmon_group{
		no = 3013,
		name = <<"伏魔塔13层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,407.775},
		mon_pool_fixed = [{10113,1},{10013,2},{10013,3},{10015,4},{10015,5},{10019,6},{10019,7},{10019,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3014) ->
	#bmon_group{
		no = 3014,
		name = <<"伏魔塔14层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,421.691},
		mon_pool_fixed = [{10201,1},{10014,2},{10014,3},{10016,4},{10016,5},{10020,6},{10020,7},{10020,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3015) ->
	#bmon_group{
		no = 3015,
		name = <<"伏魔塔15层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,435.823},
		mon_pool_fixed = [{10202,1},{10015,2},{10015,3},{10017,4},{10017,5},{10021,6},{10021,7},{10021,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3016) ->
	#bmon_group{
		no = 3016,
		name = <<"伏魔塔16层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,450.17},
		mon_pool_fixed = [{10203,1},{10016,2},{10016,3},{10018,4},{10018,5},{10022,6},{10022,7},{10022,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3017) ->
	#bmon_group{
		no = 3017,
		name = <<"伏魔塔17层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,464.733},
		mon_pool_fixed = [{10204,1},{10017,2},{10017,3},{10019,4},{10019,5},{10023,6},{10023,7},{10023,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3018) ->
	#bmon_group{
		no = 3018,
		name = <<"伏魔塔18层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,494.505},
		mon_pool_fixed = [{10205,1},{10018,2},{10018,3},{10020,4},{10020,5},{10024,6},{10024,7},{10024,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3019) ->
	#bmon_group{
		no = 3019,
		name = <<"伏魔塔19层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,525.137},
		mon_pool_fixed = [{10206,1},{10019,2},{10019,3},{10021,4},{10021,5},{10025,6},{10025,7},{10025,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3020) ->
	#bmon_group{
		no = 3020,
		name = <<"伏魔塔20层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,551.36},
		mon_pool_fixed = [{10207,1},{10020,2},{10020,3},{10022,4},{10022,5},{10026,6},{10026,7},{10026,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3021) ->
	#bmon_group{
		no = 3021,
		name = <<"伏魔塔21层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,578.215},
		mon_pool_fixed = [{10208,1},{10021,2},{10021,3},{10023,4},{10023,5},{10027,6},{10027,7},{10027,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3022) ->
	#bmon_group{
		no = 3022,
		name = <<"伏魔塔22层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,605.702},
		mon_pool_fixed = [{10209,1},{10022,2},{10022,3},{10024,4},{10024,5},{10028,6},{10028,7},{10028,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3023) ->
	#bmon_group{
		no = 3023,
		name = <<"伏魔塔23层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,633.823},
		mon_pool_fixed = [{10210,1},{10023,2},{10023,3},{10025,4},{10025,5},{10029,6},{10029,7},{10029,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3024) ->
	#bmon_group{
		no = 3024,
		name = <<"伏魔塔24层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,662.574},
		mon_pool_fixed = [{10211,1},{10024,2},{10024,3},{10026,4},{10026,5},{10030,6},{10030,7},{10030,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3025) ->
	#bmon_group{
		no = 3025,
		name = <<"伏魔塔25层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,692.8},
		mon_pool_fixed = [{10212,1},{10025,2},{10025,3},{10027,4},{10027,5},{10031,6},{10031,7},{10031,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3026) ->
	#bmon_group{
		no = 3026,
		name = <<"伏魔塔26层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,723.692},
		mon_pool_fixed = [{10213,1},{10026,2},{10026,3},{10028,4},{10028,5},{10032,6},{10032,7},{10032,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3027) ->
	#bmon_group{
		no = 3027,
		name = <<"伏魔塔27层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,755.25},
		mon_pool_fixed = [{10214,1},{10027,2},{10027,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3028) ->
	#bmon_group{
		no = 3028,
		name = <<"伏魔塔28层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,787.473},
		mon_pool_fixed = [{10301,1},{10028,2},{10028,3},{10030,4},{10030,5},{10034,6},{10034,7},{10034,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3029) ->
	#bmon_group{
		no = 3029,
		name = <<"伏魔塔29层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,820.357},
		mon_pool_fixed = [{10302,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3030) ->
	#bmon_group{
		no = 3030,
		name = <<"伏魔塔30层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,861.904},
		mon_pool_fixed = [{10303,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3031) ->
	#bmon_group{
		no = 3031,
		name = <<"伏魔塔31层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,904.402},
		mon_pool_fixed = [{10304,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3032) ->
	#bmon_group{
		no = 3032,
		name = <<"伏魔塔32层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,947.851},
		mon_pool_fixed = [{10305,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3033) ->
	#bmon_group{
		no = 3033,
		name = <<"伏魔塔33层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,992.251},
		mon_pool_fixed = [{10306,1},{10036,2},{10036,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10034,9},{10034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3034) ->
	#bmon_group{
		no = 3034,
		name = <<"伏魔塔34层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1037.604},
		mon_pool_fixed = [{10101,1},{10035,2},{10035,3},{10035,4},{10035,5},{10034,6},{10034,7},{10034,8},{10033,9},{10033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3035) ->
	#bmon_group{
		no = 3035,
		name = <<"伏魔塔35层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1087.183},
		mon_pool_fixed = [{10102,1},{10034,2},{10034,3},{10034,4},{10034,5},{10033,6},{10033,7},{10033,8},{10032,9},{10032,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3036) ->
	#bmon_group{
		no = 3036,
		name = <<"伏魔塔36层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1137.822},
		mon_pool_fixed = [{10103,1},{10033,2},{10033,3},{10033,4},{10033,5},{10032,6},{10032,7},{10032,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3037) ->
	#bmon_group{
		no = 3037,
		name = <<"伏魔塔37层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1189.518},
		mon_pool_fixed = [{10104,1},{10032,2},{10032,3},{10032,4},{10032,5},{10031,6},{10031,7},{10031,8},{10030,9},{10030,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3038) ->
	#bmon_group{
		no = 3038,
		name = <<"伏魔塔38层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1242.273},
		mon_pool_fixed = [{10105,1},{10031,2},{10031,3},{10031,4},{10031,5},{10030,6},{10030,7},{10030,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3039) ->
	#bmon_group{
		no = 3039,
		name = <<"伏魔塔39层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1296.083},
		mon_pool_fixed = [{10106,1},{10030,2},{10030,3},{10030,4},{10030,5},{10029,6},{10029,7},{10029,8},{10028,9},{10028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3040) ->
	#bmon_group{
		no = 3040,
		name = <<"伏魔塔40层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1335.686},
		mon_pool_fixed = [{10107,1},{10029,2},{10029,3},{10029,4},{10029,5},{10028,6},{10028,7},{10028,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3041) ->
	#bmon_group{
		no = 3041,
		name = <<"伏魔塔41层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1375.884},
		mon_pool_fixed = [{10108,1},{10028,2},{10028,3},{10028,4},{10028,5},{10027,6},{10027,7},{10027,8},{10026,9},{10026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3042) ->
	#bmon_group{
		no = 3042,
		name = <<"伏魔塔42层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1416.678},
		mon_pool_fixed = [{10109,1},{10027,2},{10027,3},{10027,4},{10027,5},{10026,6},{10026,7},{10026,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3043) ->
	#bmon_group{
		no = 3043,
		name = <<"伏魔塔43层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1458.068},
		mon_pool_fixed = [{10110,1},{10026,2},{10026,3},{10026,4},{10026,5},{10025,6},{10025,7},{10025,8},{10024,9},{10024,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3044) ->
	#bmon_group{
		no = 3044,
		name = <<"伏魔塔44层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1500.058},
		mon_pool_fixed = [{10111,1},{10025,2},{10025,3},{10025,4},{10025,5},{10024,6},{10024,7},{10024,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3045) ->
	#bmon_group{
		no = 3045,
		name = <<"伏魔塔45层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1598.539},
		mon_pool_fixed = [{10112,1},{10024,2},{10024,3},{10024,4},{10024,5},{10023,6},{10023,7},{10023,8},{10022,9},{10022,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3046) ->
	#bmon_group{
		no = 3046,
		name = <<"伏魔塔46层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1699.191},
		mon_pool_fixed = [{10113,1},{10023,2},{10023,3},{10023,4},{10023,5},{10022,6},{10022,7},{10022,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3047) ->
	#bmon_group{
		no = 3047,
		name = <<"伏魔塔47层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1802.014},
		mon_pool_fixed = [{10201,1},{10022,2},{10022,3},{10022,4},{10022,5},{10021,6},{10021,7},{10021,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3048) ->
	#bmon_group{
		no = 3048,
		name = <<"伏魔塔48层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1907.007},
		mon_pool_fixed = [{10202,1},{10021,2},{10021,3},{10021,4},{10021,5},{10020,6},{10020,7},{10020,8},{10019,9},{10019,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3049) ->
	#bmon_group{
		no = 3049,
		name = <<"伏魔塔49层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2014.167},
		mon_pool_fixed = [{10203,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3050) ->
	#bmon_group{
		no = 3050,
		name = <<"伏魔塔50层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2075.612},
		mon_pool_fixed = [{10204,1},{10019,2},{10019,3},{10019,4},{10019,5},{10018,6},{10018,7},{10018,8},{10017,9},{10017,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3051) ->
	#bmon_group{
		no = 3051,
		name = <<"伏魔塔51层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2137.967},
		mon_pool_fixed = [{10205,1},{10018,2},{10018,3},{10018,4},{10018,5},{10017,6},{10017,7},{10017,8},{10016,9},{10016,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3052) ->
	#bmon_group{
		no = 3052,
		name = <<"伏魔塔52层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2201.232},
		mon_pool_fixed = [{10206,1},{10017,2},{10017,3},{10017,4},{10017,5},{10016,6},{10016,7},{10016,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3053) ->
	#bmon_group{
		no = 3053,
		name = <<"伏魔塔53层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2265.407},
		mon_pool_fixed = [{10207,1},{10016,2},{10016,3},{10016,4},{10016,5},{10015,6},{10015,7},{10015,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3054) ->
	#bmon_group{
		no = 3054,
		name = <<"伏魔塔54层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2330.491},
		mon_pool_fixed = [{10208,1},{10015,2},{10015,3},{10015,4},{10015,5},{10014,6},{10014,7},{10014,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3055) ->
	#bmon_group{
		no = 3055,
		name = <<"伏魔塔55层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2412.622},
		mon_pool_fixed = [{10209,1},{10014,2},{10014,3},{10014,4},{10014,5},{10013,6},{10013,7},{10013,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3056) ->
	#bmon_group{
		no = 3056,
		name = <<"伏魔塔56层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2496.062},
		mon_pool_fixed = [{10210,1},{10013,2},{10013,3},{10013,4},{10013,5},{10012,6},{10012,7},{10012,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3057) ->
	#bmon_group{
		no = 3057,
		name = <<"伏魔塔57层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2580.81},
		mon_pool_fixed = [{10211,1},{10012,2},{10012,3},{10012,4},{10012,5},{10011,6},{10011,7},{10011,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3058) ->
	#bmon_group{
		no = 3058,
		name = <<"伏魔塔58层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2666.867},
		mon_pool_fixed = [{10212,1},{10011,2},{10011,3},{10011,4},{10011,5},{10010,6},{10010,7},{10010,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3059) ->
	#bmon_group{
		no = 3059,
		name = <<"伏魔塔59层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2754.228},
		mon_pool_fixed = [{10213,1},{10010,2},{10010,3},{10010,4},{10010,5},{10009,6},{10009,7},{10009,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3060) ->
	#bmon_group{
		no = 3060,
		name = <<"伏魔塔60层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2869.032},
		mon_pool_fixed = [{10214,1},{10009,2},{10009,3},{10009,4},{10009,5},{10008,6},{10008,7},{10008,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3061) ->
	#bmon_group{
		no = 3061,
		name = <<"伏魔塔61层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2985.753},
		mon_pool_fixed = [{10301,1},{10008,2},{10008,3},{10008,4},{10008,5},{10007,6},{10007,7},{10007,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3062) ->
	#bmon_group{
		no = 3062,
		name = <<"伏魔塔62层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3104.39},
		mon_pool_fixed = [{10302,1},{10007,2},{10007,3},{10007,4},{10007,5},{10006,6},{10006,7},{10006,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3063) ->
	#bmon_group{
		no = 3063,
		name = <<"伏魔塔63层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3224.943},
		mon_pool_fixed = [{10303,1},{10006,2},{10006,3},{10006,4},{10006,5},{10005,6},{10005,7},{10005,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3064) ->
	#bmon_group{
		no = 3064,
		name = <<"伏魔塔64层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3347.411},
		mon_pool_fixed = [{10304,1},{10005,2},{10005,3},{10005,4},{10005,5},{10004,6},{10004,7},{10004,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3065) ->
	#bmon_group{
		no = 3065,
		name = <<"伏魔塔65层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3446.266},
		mon_pool_fixed = [{10305,1},{10004,2},{10004,3},{10004,4},{10004,5},{10003,6},{10003,7},{10003,8},{10002,9},{10002,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3066) ->
	#bmon_group{
		no = 3066,
		name = <<"伏魔塔66层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3546.477},
		mon_pool_fixed = [{10306,1},{10003,2},{10003,3},{10003,4},{10003,5},{10002,6},{10002,7},{10002,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3067) ->
	#bmon_group{
		no = 3067,
		name = <<"伏魔塔67层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3648.042},
		mon_pool_fixed = [{10101,1},{10021,2},{10021,3},{10023,4},{10023,5},{10027,6},{10027,7},{10027,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3068) ->
	#bmon_group{
		no = 3068,
		name = <<"伏魔塔68层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3750.963},
		mon_pool_fixed = [{10102,1},{10022,2},{10022,3},{10024,4},{10024,5},{10028,6},{10028,7},{10028,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3069) ->
	#bmon_group{
		no = 3069,
		name = <<"伏魔塔69层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3855.241},
		mon_pool_fixed = [{10103,1},{10023,2},{10023,3},{10025,4},{10025,5},{10029,6},{10029,7},{10029,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3070) ->
	#bmon_group{
		no = 3070,
		name = <<"伏魔塔70层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3970.952},
		mon_pool_fixed = [{10104,1},{10024,2},{10024,3},{10026,4},{10026,5},{10030,6},{10030,7},{10030,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3071) ->
	#bmon_group{
		no = 3071,
		name = <<"伏魔塔71层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4088.228},
		mon_pool_fixed = [{10105,1},{10025,2},{10025,3},{10027,4},{10027,5},{10031,6},{10031,7},{10031,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3072) ->
	#bmon_group{
		no = 3072,
		name = <<"伏魔塔72层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4207.069},
		mon_pool_fixed = [{10106,1},{10026,2},{10026,3},{10028,4},{10028,5},{10032,6},{10032,7},{10032,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3073) ->
	#bmon_group{
		no = 3073,
		name = <<"伏魔塔73层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4327.476},
		mon_pool_fixed = [{10107,1},{10027,2},{10027,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3074) ->
	#bmon_group{
		no = 3074,
		name = <<"伏魔塔74层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4449.438},
		mon_pool_fixed = [{10108,1},{10028,2},{10028,3},{10030,4},{10030,5},{10034,6},{10034,7},{10034,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3075) ->
	#bmon_group{
		no = 3075,
		name = <<"伏魔塔75层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4633.514},
		mon_pool_fixed = [{10109,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3076) ->
	#bmon_group{
		no = 3076,
		name = <<"伏魔塔76层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4820.355},
		mon_pool_fixed = [{10110,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3077) ->
	#bmon_group{
		no = 3077,
		name = <<"伏魔塔77层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5009.959},
		mon_pool_fixed = [{10111,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3078) ->
	#bmon_group{
		no = 3078,
		name = <<"伏魔塔78层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5202.328},
		mon_pool_fixed = [{10112,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3079) ->
	#bmon_group{
		no = 3079,
		name = <<"伏魔塔79层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5397.466},
		mon_pool_fixed = [{10113,1},{10036,2},{10036,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10034,9},{10034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3080) ->
	#bmon_group{
		no = 3080,
		name = <<"伏魔塔80层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5511.457},
		mon_pool_fixed = [{10201,1},{10035,2},{10035,3},{10035,4},{10035,5},{10034,6},{10034,7},{10034,8},{10033,9},{10033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3081) ->
	#bmon_group{
		no = 3081,
		name = <<"伏魔塔81层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5626.629},
		mon_pool_fixed = [{10202,1},{10034,2},{10034,3},{10034,4},{10034,5},{10033,6},{10033,7},{10033,8},{10032,9},{10032,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3082) ->
	#bmon_group{
		no = 3082,
		name = <<"伏魔塔82层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5742.982},
		mon_pool_fixed = [{10203,1},{10033,2},{10033,3},{10033,4},{10033,5},{10032,6},{10032,7},{10032,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3083) ->
	#bmon_group{
		no = 3083,
		name = <<"伏魔塔83层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5860.516},
		mon_pool_fixed = [{10204,1},{10032,2},{10032,3},{10032,4},{10032,5},{10031,6},{10031,7},{10031,8},{10030,9},{10030,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3084) ->
	#bmon_group{
		no = 3084,
		name = <<"伏魔塔84层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5979.222},
		mon_pool_fixed = [{10205,1},{10031,2},{10031,3},{10031,4},{10031,5},{10030,6},{10030,7},{10030,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3085) ->
	#bmon_group{
		no = 3085,
		name = <<"伏魔塔85层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6132.564},
		mon_pool_fixed = [{10206,1},{10030,2},{10030,3},{10030,4},{10030,5},{10029,6},{10029,7},{10029,8},{10028,9},{10028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3086) ->
	#bmon_group{
		no = 3086,
		name = <<"伏魔塔86层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6287.689},
		mon_pool_fixed = [{10207,1},{10029,2},{10029,3},{10029,4},{10029,5},{10028,6},{10028,7},{10028,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3087) ->
	#bmon_group{
		no = 3087,
		name = <<"伏魔塔87层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6444.598},
		mon_pool_fixed = [{10208,1},{10028,2},{10028,3},{10028,4},{10028,5},{10027,6},{10027,7},{10027,8},{10026,9},{10026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3088) ->
	#bmon_group{
		no = 3088,
		name = <<"伏魔塔88层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6603.29},
		mon_pool_fixed = [{10209,1},{10027,2},{10027,3},{10027,4},{10027,5},{10026,6},{10026,7},{10026,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3089) ->
	#bmon_group{
		no = 3089,
		name = <<"伏魔塔89层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6763.771},
		mon_pool_fixed = [{10210,1},{10026,2},{10026,3},{10026,4},{10026,5},{10025,6},{10025,7},{10025,8},{10024,9},{10024,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3090) ->
	#bmon_group{
		no = 3090,
		name = <<"伏魔塔90层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6874.752},
		mon_pool_fixed = [{10211,1},{10025,2},{10025,3},{10025,4},{10025,5},{10024,6},{10024,7},{10024,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3091) ->
	#bmon_group{
		no = 3091,
		name = <<"伏魔塔91层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6986.439},
		mon_pool_fixed = [{10212,1},{10024,2},{10024,3},{10024,4},{10024,5},{10023,6},{10023,7},{10023,8},{10022,9},{10022,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3092) ->
	#bmon_group{
		no = 3092,
		name = <<"伏魔塔92层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7098.832},
		mon_pool_fixed = [{10213,1},{10023,2},{10023,3},{10023,4},{10023,5},{10022,6},{10022,7},{10022,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3093) ->
	#bmon_group{
		no = 3093,
		name = <<"伏魔塔93层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7211.931},
		mon_pool_fixed = [{10214,1},{10022,2},{10022,3},{10022,4},{10022,5},{10021,6},{10021,7},{10021,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3094) ->
	#bmon_group{
		no = 3094,
		name = <<"伏魔塔94层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7325.737},
		mon_pool_fixed = [{10301,1},{10021,2},{10021,3},{10021,4},{10021,5},{10020,6},{10020,7},{10020,8},{10019,9},{10019,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3095) ->
	#bmon_group{
		no = 3095,
		name = <<"伏魔塔95层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7440.249},
		mon_pool_fixed = [{10302,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3096) ->
	#bmon_group{
		no = 3096,
		name = <<"伏魔塔96层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7555.468},
		mon_pool_fixed = [{10303,1},{10019,2},{10019,3},{10019,4},{10019,5},{10018,6},{10018,7},{10018,8},{10017,9},{10017,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3097) ->
	#bmon_group{
		no = 3097,
		name = <<"伏魔塔97层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7671.392},
		mon_pool_fixed = [{10304,1},{10018,2},{10018,3},{10018,4},{10018,5},{10017,6},{10017,7},{10017,8},{10016,9},{10016,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3098) ->
	#bmon_group{
		no = 3098,
		name = <<"伏魔塔98层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7788.023},
		mon_pool_fixed = [{10305,1},{10017,2},{10017,3},{10017,4},{10017,5},{10016,6},{10016,7},{10016,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3099) ->
	#bmon_group{
		no = 3099,
		name = <<"伏魔塔99层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7905.35},
		mon_pool_fixed = [{10306,1},{10016,2},{10016,3},{10016,4},{10016,5},{10015,6},{10015,7},{10015,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3100) ->
	#bmon_group{
		no = 3100,
		name = <<"伏魔塔100层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8011.295},
		mon_pool_fixed = [{10101,1},{10015,2},{10015,3},{10015,4},{10015,5},{10014,6},{10014,7},{10014,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3101) ->
	#bmon_group{
		no = 3101,
		name = <<"伏魔塔101层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8117.846},
		mon_pool_fixed = [{10102,1},{10014,2},{10014,3},{10014,4},{10014,5},{10013,6},{10013,7},{10013,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3102) ->
	#bmon_group{
		no = 3102,
		name = <<"伏魔塔102层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8225.003},
		mon_pool_fixed = [{10103,1},{10013,2},{10013,3},{10013,4},{10013,5},{10012,6},{10012,7},{10012,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3103) ->
	#bmon_group{
		no = 3103,
		name = <<"伏魔塔103层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8332.766},
		mon_pool_fixed = [{10104,1},{10012,2},{10012,3},{10012,4},{10012,5},{10011,6},{10011,7},{10011,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3104) ->
	#bmon_group{
		no = 3104,
		name = <<"伏魔塔104层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8441.134},
		mon_pool_fixed = [{10105,1},{10011,2},{10011,3},{10011,4},{10011,5},{10010,6},{10010,7},{10010,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3105) ->
	#bmon_group{
		no = 3105,
		name = <<"伏魔塔105层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8550.109},
		mon_pool_fixed = [{10106,1},{10010,2},{10010,3},{10010,4},{10010,5},{10009,6},{10009,7},{10009,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3106) ->
	#bmon_group{
		no = 3106,
		name = <<"伏魔塔106层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8659.689},
		mon_pool_fixed = [{10107,1},{10009,2},{10009,3},{10009,4},{10009,5},{10008,6},{10008,7},{10008,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3107) ->
	#bmon_group{
		no = 3107,
		name = <<"伏魔塔107层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8769.875},
		mon_pool_fixed = [{10108,1},{10008,2},{10008,3},{10008,4},{10008,5},{10007,6},{10007,7},{10007,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3108) ->
	#bmon_group{
		no = 3108,
		name = <<"伏魔塔108层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8880.667},
		mon_pool_fixed = [{10109,1},{10007,2},{10007,3},{10007,4},{10007,5},{10006,6},{10006,7},{10006,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3109) ->
	#bmon_group{
		no = 3109,
		name = <<"伏魔塔109层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8992.073},
		mon_pool_fixed = [{10110,1},{10006,2},{10006,3},{10006,4},{10006,5},{10005,6},{10005,7},{10005,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3110) ->
	#bmon_group{
		no = 3110,
		name = <<"伏魔塔110层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,9118.157},
		mon_pool_fixed = [{10111,1},{10005,2},{10005,3},{10005,4},{10005,5},{10004,6},{10004,7},{10004,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3111) ->
	#bmon_group{
		no = 3111,
		name = <<"伏魔塔111层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,9244.96},
		mon_pool_fixed = [{10112,1},{10004,2},{10004,3},{10004,4},{10004,5},{10003,6},{10003,7},{10003,8},{10002,9},{10002,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3112) ->
	#bmon_group{
		no = 3112,
		name = <<"伏魔塔112层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,9372.481},
		mon_pool_fixed = [{10113,1},{10003,2},{10003,3},{10003,4},{10003,5},{10002,6},{10002,7},{10002,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3113) ->
	#bmon_group{
		no = 3113,
		name = <<"伏魔塔113层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,9500.72},
		mon_pool_fixed = [{10201,1},{10021,2},{10021,3},{10023,4},{10023,5},{10027,6},{10027,7},{10027,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3114) ->
	#bmon_group{
		no = 3114,
		name = <<"伏魔塔114层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,9629.677},
		mon_pool_fixed = [{10202,1},{10022,2},{10022,3},{10024,4},{10024,5},{10028,6},{10028,7},{10028,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3115) ->
	#bmon_group{
		no = 3115,
		name = <<"伏魔塔115层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,9759.352},
		mon_pool_fixed = [{10203,1},{10023,2},{10023,3},{10025,4},{10025,5},{10029,6},{10029,7},{10029,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3116) ->
	#bmon_group{
		no = 3116,
		name = <<"伏魔塔116层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,9889.746},
		mon_pool_fixed = [{10204,1},{10024,2},{10024,3},{10026,4},{10026,5},{10030,6},{10030,7},{10030,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3117) ->
	#bmon_group{
		no = 3117,
		name = <<"伏魔塔117层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,10020.857},
		mon_pool_fixed = [{10205,1},{10025,2},{10025,3},{10027,4},{10027,5},{10031,6},{10031,7},{10031,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3118) ->
	#bmon_group{
		no = 3118,
		name = <<"伏魔塔118层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,10152.686},
		mon_pool_fixed = [{10206,1},{10026,2},{10026,3},{10028,4},{10028,5},{10032,6},{10032,7},{10032,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3119) ->
	#bmon_group{
		no = 3119,
		name = <<"伏魔塔119层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,10285.244},
		mon_pool_fixed = [{10207,1},{10027,2},{10027,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3120) ->
	#bmon_group{
		no = 3120,
		name = <<"伏魔塔120层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,10521.022},
		mon_pool_fixed = [{10208,1},{10028,2},{10028,3},{10030,4},{10030,5},{10034,6},{10034,7},{10034,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3121) ->
	#bmon_group{
		no = 3121,
		name = <<"伏魔塔121层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,10758.304},
		mon_pool_fixed = [{10209,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3122) ->
	#bmon_group{
		no = 3122,
		name = <<"伏魔塔122层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,10997.09},
		mon_pool_fixed = [{10210,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3123) ->
	#bmon_group{
		no = 3123,
		name = <<"伏魔塔123层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,11237.379},
		mon_pool_fixed = [{10211,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3124) ->
	#bmon_group{
		no = 3124,
		name = <<"伏魔塔124层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,11479.172},
		mon_pool_fixed = [{10212,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3125) ->
	#bmon_group{
		no = 3125,
		name = <<"伏魔塔125层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,11722.468},
		mon_pool_fixed = [{10213,1},{10036,2},{10036,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10034,9},{10034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3126) ->
	#bmon_group{
		no = 3126,
		name = <<"伏魔塔126层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,11967.268},
		mon_pool_fixed = [{10214,1},{10035,2},{10035,3},{10035,4},{10035,5},{10034,6},{10034,7},{10034,8},{10033,9},{10033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3127) ->
	#bmon_group{
		no = 3127,
		name = <<"伏魔塔127层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,12213.572},
		mon_pool_fixed = [{10301,1},{10034,2},{10034,3},{10034,4},{10034,5},{10033,6},{10033,7},{10033,8},{10032,9},{10032,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3128) ->
	#bmon_group{
		no = 3128,
		name = <<"伏魔塔128层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,12461.379},
		mon_pool_fixed = [{10302,1},{10033,2},{10033,3},{10033,4},{10033,5},{10032,6},{10032,7},{10032,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3129) ->
	#bmon_group{
		no = 3129,
		name = <<"伏魔塔129层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,12710.704},
		mon_pool_fixed = [{10303,1},{10032,2},{10032,3},{10032,4},{10032,5},{10031,6},{10031,7},{10031,8},{10030,9},{10030,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3130) ->
	#bmon_group{
		no = 3130,
		name = <<"伏魔塔130层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,12871.98},
		mon_pool_fixed = [{10304,1},{10031,2},{10031,3},{10031,4},{10031,5},{10030,6},{10030,7},{10030,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3131) ->
	#bmon_group{
		no = 3131,
		name = <<"伏魔塔131层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,13034.099},
		mon_pool_fixed = [{10305,1},{10030,2},{10030,3},{10030,4},{10030,5},{10029,6},{10029,7},{10029,8},{10028,9},{10028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3132) ->
	#bmon_group{
		no = 3132,
		name = <<"伏魔塔132层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,13197.06},
		mon_pool_fixed = [{10306,1},{10029,2},{10029,3},{10029,4},{10029,5},{10028,6},{10028,7},{10028,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3133) ->
	#bmon_group{
		no = 3133,
		name = <<"伏魔塔133层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,13360.865},
		mon_pool_fixed = [{10101,1},{10028,2},{10028,3},{10028,4},{10028,5},{10027,6},{10027,7},{10027,8},{10026,9},{10026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3134) ->
	#bmon_group{
		no = 3134,
		name = <<"伏魔塔134层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,13525.512},
		mon_pool_fixed = [{10102,1},{10027,2},{10027,3},{10027,4},{10027,5},{10026,6},{10026,7},{10026,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3135) ->
	#bmon_group{
		no = 3135,
		name = <<"伏魔塔135层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,13691.002},
		mon_pool_fixed = [{10103,1},{10026,2},{10026,3},{10026,4},{10026,5},{10025,6},{10025,7},{10025,8},{10024,9},{10024,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3136) ->
	#bmon_group{
		no = 3136,
		name = <<"伏魔塔136层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,13857.335},
		mon_pool_fixed = [{10104,1},{10025,2},{10025,3},{10025,4},{10025,5},{10024,6},{10024,7},{10024,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3137) ->
	#bmon_group{
		no = 3137,
		name = <<"伏魔塔137层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,14024.511},
		mon_pool_fixed = [{10105,1},{10024,2},{10024,3},{10024,4},{10024,5},{10023,6},{10023,7},{10023,8},{10022,9},{10022,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3138) ->
	#bmon_group{
		no = 3138,
		name = <<"伏魔塔138层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,14192.529},
		mon_pool_fixed = [{10106,1},{10023,2},{10023,3},{10023,4},{10023,5},{10022,6},{10022,7},{10022,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3139) ->
	#bmon_group{
		no = 3139,
		name = <<"伏魔塔139层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,14361.379},
		mon_pool_fixed = [{10107,1},{10022,2},{10022,3},{10022,4},{10022,5},{10021,6},{10021,7},{10021,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3140) ->
	#bmon_group{
		no = 3140,
		name = <<"伏魔塔140层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,14566.959},
		mon_pool_fixed = [{10108,1},{10021,2},{10021,3},{10021,4},{10021,5},{10020,6},{10020,7},{10020,8},{10019,9},{10019,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3141) ->
	#bmon_group{
		no = 3141,
		name = <<"伏魔塔141层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,14773.636},
		mon_pool_fixed = [{10109,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3142) ->
	#bmon_group{
		no = 3142,
		name = <<"伏魔塔142层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,14981.412},
		mon_pool_fixed = [{10110,1},{10019,2},{10019,3},{10019,4},{10019,5},{10018,6},{10018,7},{10018,8},{10017,9},{10017,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3143) ->
	#bmon_group{
		no = 3143,
		name = <<"伏魔塔143层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,15190.285},
		mon_pool_fixed = [{10111,1},{10018,2},{10018,3},{10018,4},{10018,5},{10017,6},{10017,7},{10017,8},{10016,9},{10016,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3144) ->
	#bmon_group{
		no = 3144,
		name = <<"伏魔塔144层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,15400.257},
		mon_pool_fixed = [{10112,1},{10017,2},{10017,3},{10017,4},{10017,5},{10016,6},{10016,7},{10016,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3145) ->
	#bmon_group{
		no = 3145,
		name = <<"伏魔塔145层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,15611.327},
		mon_pool_fixed = [{10113,1},{10016,2},{10016,3},{10016,4},{10016,5},{10015,6},{10015,7},{10015,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3146) ->
	#bmon_group{
		no = 3146,
		name = <<"伏魔塔146层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,15823.495},
		mon_pool_fixed = [{10201,1},{10015,2},{10015,3},{10015,4},{10015,5},{10014,6},{10014,7},{10014,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3147) ->
	#bmon_group{
		no = 3147,
		name = <<"伏魔塔147层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,16036.762},
		mon_pool_fixed = [{10202,1},{10014,2},{10014,3},{10014,4},{10014,5},{10013,6},{10013,7},{10013,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3148) ->
	#bmon_group{
		no = 3148,
		name = <<"伏魔塔148层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,16251.126},
		mon_pool_fixed = [{10203,1},{10013,2},{10013,3},{10013,4},{10013,5},{10012,6},{10012,7},{10012,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3149) ->
	#bmon_group{
		no = 3149,
		name = <<"伏魔塔149层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,16466.586},
		mon_pool_fixed = [{10204,1},{10012,2},{10012,3},{10012,4},{10012,5},{10011,6},{10011,7},{10011,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3150) ->
	#bmon_group{
		no = 3150,
		name = <<"伏魔塔150层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,16779.884},
		mon_pool_fixed = [{10205,1},{10011,2},{10011,3},{10011,4},{10011,5},{10010,6},{10010,7},{10010,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3151) ->
	#bmon_group{
		no = 3151,
		name = <<"伏魔塔151层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,17094.944},
		mon_pool_fixed = [{10206,1},{10010,2},{10010,3},{10010,4},{10010,5},{10009,6},{10009,7},{10009,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3152) ->
	#bmon_group{
		no = 3152,
		name = <<"伏魔塔152层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,17411.768},
		mon_pool_fixed = [{10207,1},{10009,2},{10009,3},{10009,4},{10009,5},{10008,6},{10008,7},{10008,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3153) ->
	#bmon_group{
		no = 3153,
		name = <<"伏魔塔153层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,17730.355},
		mon_pool_fixed = [{10208,1},{10008,2},{10008,3},{10008,4},{10008,5},{10007,6},{10007,7},{10007,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3154) ->
	#bmon_group{
		no = 3154,
		name = <<"伏魔塔154层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,18050.705},
		mon_pool_fixed = [{10209,1},{10007,2},{10007,3},{10007,4},{10007,5},{10006,6},{10006,7},{10006,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3155) ->
	#bmon_group{
		no = 3155,
		name = <<"伏魔塔155层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,18372.818},
		mon_pool_fixed = [{10210,1},{10006,2},{10006,3},{10006,4},{10006,5},{10005,6},{10005,7},{10005,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3156) ->
	#bmon_group{
		no = 3156,
		name = <<"伏魔塔156层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,18696.694},
		mon_pool_fixed = [{10211,1},{10005,2},{10005,3},{10005,4},{10005,5},{10004,6},{10004,7},{10004,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3157) ->
	#bmon_group{
		no = 3157,
		name = <<"伏魔塔157层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,19022.332},
		mon_pool_fixed = [{10212,1},{10004,2},{10004,3},{10004,4},{10004,5},{10003,6},{10003,7},{10003,8},{10002,9},{10002,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3158) ->
	#bmon_group{
		no = 3158,
		name = <<"伏魔塔158层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,19349.734},
		mon_pool_fixed = [{10213,1},{10003,2},{10003,3},{10003,4},{10003,5},{10002,6},{10002,7},{10002,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3159) ->
	#bmon_group{
		no = 3159,
		name = <<"伏魔塔159层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,19678.893},
		mon_pool_fixed = [{10214,1},{10021,2},{10021,3},{10023,4},{10023,5},{10027,6},{10027,7},{10027,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3160) ->
	#bmon_group{
		no = 3160,
		name = <<"伏魔塔160层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,19938.111},
		mon_pool_fixed = [{10301,1},{10022,2},{10022,3},{10024,4},{10024,5},{10028,6},{10028,7},{10028,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3161) ->
	#bmon_group{
		no = 3161,
		name = <<"伏魔塔161层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,20198.615},
		mon_pool_fixed = [{10302,1},{10023,2},{10023,3},{10025,4},{10025,5},{10029,6},{10029,7},{10029,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3162) ->
	#bmon_group{
		no = 3162,
		name = <<"伏魔塔162层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,20460.405},
		mon_pool_fixed = [{10303,1},{10024,2},{10024,3},{10026,4},{10026,5},{10030,6},{10030,7},{10030,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3163) ->
	#bmon_group{
		no = 3163,
		name = <<"伏魔塔163层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,20723.482},
		mon_pool_fixed = [{10304,1},{10025,2},{10025,3},{10027,4},{10027,5},{10031,6},{10031,7},{10031,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3164) ->
	#bmon_group{
		no = 3164,
		name = <<"伏魔塔164层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,20987.846},
		mon_pool_fixed = [{10305,1},{10026,2},{10026,3},{10028,4},{10028,5},{10032,6},{10032,7},{10032,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3165) ->
	#bmon_group{
		no = 3165,
		name = <<"伏魔塔165层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,21253.496},
		mon_pool_fixed = [{10306,1},{10027,2},{10027,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3166) ->
	#bmon_group{
		no = 3166,
		name = <<"伏魔塔166层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,21520.433},
		mon_pool_fixed = [{10101,1},{10028,2},{10028,3},{10030,4},{10030,5},{10034,6},{10034,7},{10034,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3167) ->
	#bmon_group{
		no = 3167,
		name = <<"伏魔塔167层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,21788.656},
		mon_pool_fixed = [{10102,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3168) ->
	#bmon_group{
		no = 3168,
		name = <<"伏魔塔168层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,22058.166},
		mon_pool_fixed = [{10103,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3169) ->
	#bmon_group{
		no = 3169,
		name = <<"伏魔塔169层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,22328.953},
		mon_pool_fixed = [{10104,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3170) ->
	#bmon_group{
		no = 3170,
		name = <<"伏魔塔170层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,22601.026},
		mon_pool_fixed = [{10105,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3171) ->
	#bmon_group{
		no = 3171,
		name = <<"伏魔塔171层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,22874.386},
		mon_pool_fixed = [{10106,1},{10036,2},{10036,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10034,9},{10034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3172) ->
	#bmon_group{
		no = 3172,
		name = <<"伏魔塔172层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,23149.032},
		mon_pool_fixed = [{10107,1},{10035,2},{10035,3},{10035,4},{10035,5},{10034,6},{10034,7},{10034,8},{10033,9},{10033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3173) ->
	#bmon_group{
		no = 3173,
		name = <<"伏魔塔173层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,23424.965},
		mon_pool_fixed = [{10108,1},{10034,2},{10034,3},{10034,4},{10034,5},{10033,6},{10033,7},{10033,8},{10032,9},{10032,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3174) ->
	#bmon_group{
		no = 3174,
		name = <<"伏魔塔174层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,23702.184},
		mon_pool_fixed = [{10109,1},{10033,2},{10033,3},{10033,4},{10033,5},{10032,6},{10032,7},{10032,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3175) ->
	#bmon_group{
		no = 3175,
		name = <<"伏魔塔175层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,23980.69},
		mon_pool_fixed = [{10110,1},{10032,2},{10032,3},{10032,4},{10032,5},{10031,6},{10031,7},{10031,8},{10030,9},{10030,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3176) ->
	#bmon_group{
		no = 3176,
		name = <<"伏魔塔176层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,24260.482},
		mon_pool_fixed = [{10111,1},{10031,2},{10031,3},{10031,4},{10031,5},{10030,6},{10030,7},{10030,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3177) ->
	#bmon_group{
		no = 3177,
		name = <<"伏魔塔177层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,24541.561},
		mon_pool_fixed = [{10112,1},{10030,2},{10030,3},{10030,4},{10030,5},{10029,6},{10029,7},{10029,8},{10028,9},{10028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3178) ->
	#bmon_group{
		no = 3178,
		name = <<"伏魔塔178层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,24823.926},
		mon_pool_fixed = [{10113,1},{10029,2},{10029,3},{10029,4},{10029,5},{10028,6},{10028,7},{10028,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3179) ->
	#bmon_group{
		no = 3179,
		name = <<"伏魔塔179层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,25107.578},
		mon_pool_fixed = [{10201,1},{10028,2},{10028,3},{10028,4},{10028,5},{10027,6},{10027,7},{10027,8},{10026,9},{10026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3180) ->
	#bmon_group{
		no = 3180,
		name = <<"伏魔塔180层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,25392.516},
		mon_pool_fixed = [{10202,1},{10027,2},{10027,3},{10027,4},{10027,5},{10026,6},{10026,7},{10026,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3181) ->
	#bmon_group{
		no = 3181,
		name = <<"伏魔塔181层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,25678.74},
		mon_pool_fixed = [{10203,1},{10026,2},{10026,3},{10026,4},{10026,5},{10025,6},{10025,7},{10025,8},{10024,9},{10024,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3182) ->
	#bmon_group{
		no = 3182,
		name = <<"伏魔塔182层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,25966.251},
		mon_pool_fixed = [{10204,1},{10025,2},{10025,3},{10025,4},{10025,5},{10024,6},{10024,7},{10024,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3183) ->
	#bmon_group{
		no = 3183,
		name = <<"伏魔塔183层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,26255.048},
		mon_pool_fixed = [{10205,1},{10024,2},{10024,3},{10024,4},{10024,5},{10023,6},{10023,7},{10023,8},{10022,9},{10022,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3184) ->
	#bmon_group{
		no = 3184,
		name = <<"伏魔塔184层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,26545.132},
		mon_pool_fixed = [{10206,1},{10023,2},{10023,3},{10023,4},{10023,5},{10022,6},{10022,7},{10022,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3185) ->
	#bmon_group{
		no = 3185,
		name = <<"伏魔塔185层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,26836.503},
		mon_pool_fixed = [{10207,1},{10022,2},{10022,3},{10022,4},{10022,5},{10021,6},{10021,7},{10021,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3186) ->
	#bmon_group{
		no = 3186,
		name = <<"伏魔塔186层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27129.159},
		mon_pool_fixed = [{10208,1},{10021,2},{10021,3},{10021,4},{10021,5},{10020,6},{10020,7},{10020,8},{10019,9},{10019,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3187) ->
	#bmon_group{
		no = 3187,
		name = <<"伏魔塔187层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27423.103},
		mon_pool_fixed = [{10209,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3188) ->
	#bmon_group{
		no = 3188,
		name = <<"伏魔塔188层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27718.332},
		mon_pool_fixed = [{10210,1},{10019,2},{10019,3},{10019,4},{10019,5},{10018,6},{10018,7},{10018,8},{10017,9},{10017,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3189) ->
	#bmon_group{
		no = 3189,
		name = <<"伏魔塔189层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,28014.848},
		mon_pool_fixed = [{10211,1},{10018,2},{10018,3},{10018,4},{10018,5},{10017,6},{10017,7},{10017,8},{10016,9},{10016,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3190) ->
	#bmon_group{
		no = 3190,
		name = <<"伏魔塔190层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,28312.651},
		mon_pool_fixed = [{10212,1},{10017,2},{10017,3},{10017,4},{10017,5},{10016,6},{10016,7},{10016,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3191) ->
	#bmon_group{
		no = 3191,
		name = <<"伏魔塔191层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,28611.74},
		mon_pool_fixed = [{10213,1},{10016,2},{10016,3},{10016,4},{10016,5},{10015,6},{10015,7},{10015,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3192) ->
	#bmon_group{
		no = 3192,
		name = <<"伏魔塔192层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,28912.116},
		mon_pool_fixed = [{10214,1},{10015,2},{10015,3},{10015,4},{10015,5},{10014,6},{10014,7},{10014,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3193) ->
	#bmon_group{
		no = 3193,
		name = <<"伏魔塔193层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,29213.778},
		mon_pool_fixed = [{10301,1},{10014,2},{10014,3},{10014,4},{10014,5},{10013,6},{10013,7},{10013,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3194) ->
	#bmon_group{
		no = 3194,
		name = <<"伏魔塔194层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,29516.726},
		mon_pool_fixed = [{10302,1},{10013,2},{10013,3},{10013,4},{10013,5},{10012,6},{10012,7},{10012,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3195) ->
	#bmon_group{
		no = 3195,
		name = <<"伏魔塔195层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,29820.961},
		mon_pool_fixed = [{10303,1},{10012,2},{10012,3},{10012,4},{10012,5},{10011,6},{10011,7},{10011,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3196) ->
	#bmon_group{
		no = 3196,
		name = <<"伏魔塔196层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,30126.482},
		mon_pool_fixed = [{10304,1},{10011,2},{10011,3},{10011,4},{10011,5},{10010,6},{10010,7},{10010,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3197) ->
	#bmon_group{
		no = 3197,
		name = <<"伏魔塔197层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,30433.29},
		mon_pool_fixed = [{10305,1},{10010,2},{10010,3},{10010,4},{10010,5},{10009,6},{10009,7},{10009,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3198) ->
	#bmon_group{
		no = 3198,
		name = <<"伏魔塔198层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,30741.384},
		mon_pool_fixed = [{10306,1},{10009,2},{10009,3},{10009,4},{10009,5},{10008,6},{10008,7},{10008,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3199) ->
	#bmon_group{
		no = 3199,
		name = <<"伏魔塔199层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,31050.765},
		mon_pool_fixed = [{10101,1},{10008,2},{10008,3},{10008,4},{10008,5},{10007,6},{10007,7},{10007,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3200) ->
	#bmon_group{
		no = 3200,
		name = <<"伏魔塔200层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,31361.432},
		mon_pool_fixed = [{10102,1},{10007,2},{10007,3},{10007,4},{10007,5},{10006,6},{10006,7},{10006,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3201) ->
	#bmon_group{
		no = 3201,
		name = <<"伏魔塔201层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,31673.386},
		mon_pool_fixed = [{10103,1},{10006,2},{10006,3},{10006,4},{10006,5},{10005,6},{10005,7},{10005,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3202) ->
	#bmon_group{
		no = 3202,
		name = <<"伏魔塔202层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,31986.626},
		mon_pool_fixed = [{10104,1},{10005,2},{10005,3},{10005,4},{10005,5},{10004,6},{10004,7},{10004,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3203) ->
	#bmon_group{
		no = 3203,
		name = <<"伏魔塔203层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,32301.153},
		mon_pool_fixed = [{10105,1},{10004,2},{10004,3},{10004,4},{10004,5},{10003,6},{10003,7},{10003,8},{10002,9},{10002,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3204) ->
	#bmon_group{
		no = 3204,
		name = <<"伏魔塔204层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,32616.966},
		mon_pool_fixed = [{10106,1},{10003,2},{10003,3},{10003,4},{10003,5},{10002,6},{10002,7},{10002,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3205) ->
	#bmon_group{
		no = 3205,
		name = <<"伏魔塔205层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,32934.065},
		mon_pool_fixed = [{10107,1},{10021,2},{10021,3},{10023,4},{10023,5},{10027,6},{10027,7},{10027,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3206) ->
	#bmon_group{
		no = 3206,
		name = <<"伏魔塔206层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,33252.451},
		mon_pool_fixed = [{10108,1},{10022,2},{10022,3},{10024,4},{10024,5},{10028,6},{10028,7},{10028,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3207) ->
	#bmon_group{
		no = 3207,
		name = <<"伏魔塔207层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,33572.124},
		mon_pool_fixed = [{10109,1},{10023,2},{10023,3},{10025,4},{10025,5},{10029,6},{10029,7},{10029,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3208) ->
	#bmon_group{
		no = 3208,
		name = <<"伏魔塔208层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,33893.083},
		mon_pool_fixed = [{10110,1},{10024,2},{10024,3},{10026,4},{10026,5},{10030,6},{10030,7},{10030,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3209) ->
	#bmon_group{
		no = 3209,
		name = <<"伏魔塔209层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,34215.328},
		mon_pool_fixed = [{10111,1},{10025,2},{10025,3},{10027,4},{10027,5},{10031,6},{10031,7},{10031,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3210) ->
	#bmon_group{
		no = 3210,
		name = <<"伏魔塔210层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,34538.86},
		mon_pool_fixed = [{10112,1},{10026,2},{10026,3},{10028,4},{10028,5},{10032,6},{10032,7},{10032,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3211) ->
	#bmon_group{
		no = 3211,
		name = <<"伏魔塔211层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,34863.678},
		mon_pool_fixed = [{10113,1},{10027,2},{10027,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3212) ->
	#bmon_group{
		no = 3212,
		name = <<"伏魔塔212层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,35189.783},
		mon_pool_fixed = [{10201,1},{10028,2},{10028,3},{10030,4},{10030,5},{10034,6},{10034,7},{10034,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3213) ->
	#bmon_group{
		no = 3213,
		name = <<"伏魔塔213层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,35517.174},
		mon_pool_fixed = [{10202,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3214) ->
	#bmon_group{
		no = 3214,
		name = <<"伏魔塔214层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,35845.852},
		mon_pool_fixed = [{10203,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3215) ->
	#bmon_group{
		no = 3215,
		name = <<"伏魔塔215层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,36175.816},
		mon_pool_fixed = [{10204,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3216) ->
	#bmon_group{
		no = 3216,
		name = <<"伏魔塔216层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,36507.066},
		mon_pool_fixed = [{10205,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3217) ->
	#bmon_group{
		no = 3217,
		name = <<"伏魔塔217层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,36839.603},
		mon_pool_fixed = [{10206,1},{10036,2},{10036,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10034,9},{10034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3218) ->
	#bmon_group{
		no = 3218,
		name = <<"伏魔塔218层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,37173.427},
		mon_pool_fixed = [{10207,1},{10035,2},{10035,3},{10035,4},{10035,5},{10034,6},{10034,7},{10034,8},{10033,9},{10033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3219) ->
	#bmon_group{
		no = 3219,
		name = <<"伏魔塔219层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,37508.537},
		mon_pool_fixed = [{10208,1},{10034,2},{10034,3},{10034,4},{10034,5},{10033,6},{10033,7},{10033,8},{10032,9},{10032,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3220) ->
	#bmon_group{
		no = 3220,
		name = <<"伏魔塔220层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,37844.933},
		mon_pool_fixed = [{10209,1},{10033,2},{10033,3},{10033,4},{10033,5},{10032,6},{10032,7},{10032,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3221) ->
	#bmon_group{
		no = 3221,
		name = <<"伏魔塔221层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,38182.616},
		mon_pool_fixed = [{10210,1},{10032,2},{10032,3},{10032,4},{10032,5},{10031,6},{10031,7},{10031,8},{10030,9},{10030,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3222) ->
	#bmon_group{
		no = 3222,
		name = <<"伏魔塔222层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,38521.585},
		mon_pool_fixed = [{10211,1},{10031,2},{10031,3},{10031,4},{10031,5},{10030,6},{10030,7},{10030,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3223) ->
	#bmon_group{
		no = 3223,
		name = <<"伏魔塔223层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,38861.841},
		mon_pool_fixed = [{10212,1},{10030,2},{10030,3},{10030,4},{10030,5},{10029,6},{10029,7},{10029,8},{10028,9},{10028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3224) ->
	#bmon_group{
		no = 3224,
		name = <<"伏魔塔224层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,39203.383},
		mon_pool_fixed = [{10213,1},{10029,2},{10029,3},{10029,4},{10029,5},{10028,6},{10028,7},{10028,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3225) ->
	#bmon_group{
		no = 3225,
		name = <<"伏魔塔225层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,39546.212},
		mon_pool_fixed = [{10214,1},{10028,2},{10028,3},{10028,4},{10028,5},{10027,6},{10027,7},{10027,8},{10026,9},{10026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3226) ->
	#bmon_group{
		no = 3226,
		name = <<"伏魔塔226层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,39890.327},
		mon_pool_fixed = [{10301,1},{10027,2},{10027,3},{10027,4},{10027,5},{10026,6},{10026,7},{10026,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3227) ->
	#bmon_group{
		no = 3227,
		name = <<"伏魔塔227层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,40235.729},
		mon_pool_fixed = [{10302,1},{10026,2},{10026,3},{10026,4},{10026,5},{10025,6},{10025,7},{10025,8},{10024,9},{10024,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3228) ->
	#bmon_group{
		no = 3228,
		name = <<"伏魔塔228层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,40582.417},
		mon_pool_fixed = [{10303,1},{10025,2},{10025,3},{10025,4},{10025,5},{10024,6},{10024,7},{10024,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3229) ->
	#bmon_group{
		no = 3229,
		name = <<"伏魔塔229层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,40930.392},
		mon_pool_fixed = [{10304,1},{10024,2},{10024,3},{10024,4},{10024,5},{10023,6},{10023,7},{10023,8},{10022,9},{10022,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3230) ->
	#bmon_group{
		no = 3230,
		name = <<"伏魔塔230层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,41279.653},
		mon_pool_fixed = [{10305,1},{10023,2},{10023,3},{10023,4},{10023,5},{10022,6},{10022,7},{10022,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3231) ->
	#bmon_group{
		no = 3231,
		name = <<"伏魔塔231层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,41630.2},
		mon_pool_fixed = [{10306,1},{10022,2},{10022,3},{10022,4},{10022,5},{10021,6},{10021,7},{10021,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3232) ->
	#bmon_group{
		no = 3232,
		name = <<"伏魔塔232层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,41982.034},
		mon_pool_fixed = [{10101,1},{10021,2},{10021,3},{10021,4},{10021,5},{10020,6},{10020,7},{10020,8},{10019,9},{10019,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3233) ->
	#bmon_group{
		no = 3233,
		name = <<"伏魔塔233层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,42335.154},
		mon_pool_fixed = [{10102,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3234) ->
	#bmon_group{
		no = 3234,
		name = <<"伏魔塔234层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,42689.561},
		mon_pool_fixed = [{10103,1},{10019,2},{10019,3},{10019,4},{10019,5},{10018,6},{10018,7},{10018,8},{10017,9},{10017,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3235) ->
	#bmon_group{
		no = 3235,
		name = <<"伏魔塔235层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,43045.255},
		mon_pool_fixed = [{10104,1},{10018,2},{10018,3},{10018,4},{10018,5},{10017,6},{10017,7},{10017,8},{10016,9},{10016,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3236) ->
	#bmon_group{
		no = 3236,
		name = <<"伏魔塔236层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,43402.234},
		mon_pool_fixed = [{10105,1},{10017,2},{10017,3},{10017,4},{10017,5},{10016,6},{10016,7},{10016,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3237) ->
	#bmon_group{
		no = 3237,
		name = <<"伏魔塔237层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,43760.501},
		mon_pool_fixed = [{10106,1},{10016,2},{10016,3},{10016,4},{10016,5},{10015,6},{10015,7},{10015,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3238) ->
	#bmon_group{
		no = 3238,
		name = <<"伏魔塔238层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,44120.053},
		mon_pool_fixed = [{10107,1},{10015,2},{10015,3},{10015,4},{10015,5},{10014,6},{10014,7},{10014,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3239) ->
	#bmon_group{
		no = 3239,
		name = <<"伏魔塔239层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,44480.892},
		mon_pool_fixed = [{10108,1},{10014,2},{10014,3},{10014,4},{10014,5},{10013,6},{10013,7},{10013,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3240) ->
	#bmon_group{
		no = 3240,
		name = <<"伏魔塔240层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,44843.018},
		mon_pool_fixed = [{10109,1},{10013,2},{10013,3},{10013,4},{10013,5},{10012,6},{10012,7},{10012,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3241) ->
	#bmon_group{
		no = 3241,
		name = <<"伏魔塔241层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,45206.43},
		mon_pool_fixed = [{10110,1},{10012,2},{10012,3},{10012,4},{10012,5},{10011,6},{10011,7},{10011,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3242) ->
	#bmon_group{
		no = 3242,
		name = <<"伏魔塔242层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,45571.129},
		mon_pool_fixed = [{10111,1},{10011,2},{10011,3},{10011,4},{10011,5},{10010,6},{10010,7},{10010,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3243) ->
	#bmon_group{
		no = 3243,
		name = <<"伏魔塔243层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,45937.114},
		mon_pool_fixed = [{10112,1},{10010,2},{10010,3},{10010,4},{10010,5},{10009,6},{10009,7},{10009,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3244) ->
	#bmon_group{
		no = 3244,
		name = <<"伏魔塔244层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,46304.385},
		mon_pool_fixed = [{10113,1},{10009,2},{10009,3},{10009,4},{10009,5},{10008,6},{10008,7},{10008,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3245) ->
	#bmon_group{
		no = 3245,
		name = <<"伏魔塔245层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,46672.943},
		mon_pool_fixed = [{10201,1},{10008,2},{10008,3},{10008,4},{10008,5},{10007,6},{10007,7},{10007,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3246) ->
	#bmon_group{
		no = 3246,
		name = <<"伏魔塔246层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,47042.787},
		mon_pool_fixed = [{10202,1},{10007,2},{10007,3},{10007,4},{10007,5},{10006,6},{10006,7},{10006,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3247) ->
	#bmon_group{
		no = 3247,
		name = <<"伏魔塔247层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,47413.918},
		mon_pool_fixed = [{10203,1},{10006,2},{10006,3},{10006,4},{10006,5},{10005,6},{10005,7},{10005,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3248) ->
	#bmon_group{
		no = 3248,
		name = <<"伏魔塔248层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,47786.335},
		mon_pool_fixed = [{10204,1},{10005,2},{10005,3},{10005,4},{10005,5},{10004,6},{10004,7},{10004,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3249) ->
	#bmon_group{
		no = 3249,
		name = <<"伏魔塔249层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,48160.039},
		mon_pool_fixed = [{10205,1},{10004,2},{10004,3},{10004,4},{10004,5},{10003,6},{10003,7},{10003,8},{10002,9},{10002,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3250) ->
	#bmon_group{
		no = 3250,
		name = <<"伏魔塔250层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,48535.029},
		mon_pool_fixed = [{10206,1},{10003,2},{10003,3},{10003,4},{10003,5},{10002,6},{10002,7},{10002,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3251) ->
	#bmon_group{
		no = 3251,
		name = <<"伏魔塔251层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,48911.306},
		mon_pool_fixed = [{10207,1},{10021,2},{10021,3},{10023,4},{10023,5},{10027,6},{10027,7},{10027,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3252) ->
	#bmon_group{
		no = 3252,
		name = <<"伏魔塔252层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,49288.869},
		mon_pool_fixed = [{10208,1},{10022,2},{10022,3},{10024,4},{10024,5},{10028,6},{10028,7},{10028,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3253) ->
	#bmon_group{
		no = 3253,
		name = <<"伏魔塔253层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,49667.719},
		mon_pool_fixed = [{10209,1},{10023,2},{10023,3},{10025,4},{10025,5},{10029,6},{10029,7},{10029,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3254) ->
	#bmon_group{
		no = 3254,
		name = <<"伏魔塔254层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,50047.855},
		mon_pool_fixed = [{10210,1},{10024,2},{10024,3},{10026,4},{10026,5},{10030,6},{10030,7},{10030,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3255) ->
	#bmon_group{
		no = 3255,
		name = <<"伏魔塔255层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,50429.277},
		mon_pool_fixed = [{10211,1},{10025,2},{10025,3},{10027,4},{10027,5},{10031,6},{10031,7},{10031,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3256) ->
	#bmon_group{
		no = 3256,
		name = <<"伏魔塔256层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,50811.986},
		mon_pool_fixed = [{10212,1},{10026,2},{10026,3},{10028,4},{10028,5},{10032,6},{10032,7},{10032,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3257) ->
	#bmon_group{
		no = 3257,
		name = <<"伏魔塔257层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,51195.982},
		mon_pool_fixed = [{10213,1},{10027,2},{10027,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3258) ->
	#bmon_group{
		no = 3258,
		name = <<"伏魔塔258层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,51581.264},
		mon_pool_fixed = [{10214,1},{10028,2},{10028,3},{10030,4},{10030,5},{10034,6},{10034,7},{10034,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3259) ->
	#bmon_group{
		no = 3259,
		name = <<"伏魔塔259层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,51967.832},
		mon_pool_fixed = [{10301,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3260) ->
	#bmon_group{
		no = 3260,
		name = <<"伏魔塔260层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,52355.687},
		mon_pool_fixed = [{10302,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3261) ->
	#bmon_group{
		no = 3261,
		name = <<"伏魔塔261层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,52744.828},
		mon_pool_fixed = [{10303,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3262) ->
	#bmon_group{
		no = 3262,
		name = <<"伏魔塔262层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,53135.256},
		mon_pool_fixed = [{10304,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3263) ->
	#bmon_group{
		no = 3263,
		name = <<"伏魔塔263层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,53526.97},
		mon_pool_fixed = [{10305,1},{10036,2},{10036,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10034,9},{10034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3264) ->
	#bmon_group{
		no = 3264,
		name = <<"伏魔塔264层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,53919.971},
		mon_pool_fixed = [{10306,1},{10035,2},{10035,3},{10035,4},{10035,5},{10034,6},{10034,7},{10034,8},{10033,9},{10033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3265) ->
	#bmon_group{
		no = 3265,
		name = <<"伏魔塔265层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,54314.258},
		mon_pool_fixed = [{10101,1},{10034,2},{10034,3},{10034,4},{10034,5},{10033,6},{10033,7},{10033,8},{10032,9},{10032,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3266) ->
	#bmon_group{
		no = 3266,
		name = <<"伏魔塔266层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,54709.831},
		mon_pool_fixed = [{10102,1},{10033,2},{10033,3},{10033,4},{10033,5},{10032,6},{10032,7},{10032,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3267) ->
	#bmon_group{
		no = 3267,
		name = <<"伏魔塔267层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,55106.691},
		mon_pool_fixed = [{10103,1},{10032,2},{10032,3},{10032,4},{10032,5},{10031,6},{10031,7},{10031,8},{10030,9},{10030,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3268) ->
	#bmon_group{
		no = 3268,
		name = <<"伏魔塔268层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,55504.838},
		mon_pool_fixed = [{10104,1},{10031,2},{10031,3},{10031,4},{10031,5},{10030,6},{10030,7},{10030,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3269) ->
	#bmon_group{
		no = 3269,
		name = <<"伏魔塔269层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,55904.271},
		mon_pool_fixed = [{10105,1},{10030,2},{10030,3},{10030,4},{10030,5},{10029,6},{10029,7},{10029,8},{10028,9},{10028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3270) ->
	#bmon_group{
		no = 3270,
		name = <<"伏魔塔270层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,56304.99},
		mon_pool_fixed = [{10106,1},{10029,2},{10029,3},{10029,4},{10029,5},{10028,6},{10028,7},{10028,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3271) ->
	#bmon_group{
		no = 3271,
		name = <<"伏魔塔271层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,56706.996},
		mon_pool_fixed = [{10107,1},{10028,2},{10028,3},{10028,4},{10028,5},{10027,6},{10027,7},{10027,8},{10026,9},{10026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3272) ->
	#bmon_group{
		no = 3272,
		name = <<"伏魔塔272层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,57110.288},
		mon_pool_fixed = [{10108,1},{10027,2},{10027,3},{10027,4},{10027,5},{10026,6},{10026,7},{10026,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3273) ->
	#bmon_group{
		no = 3273,
		name = <<"伏魔塔273层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,57514.867},
		mon_pool_fixed = [{10109,1},{10026,2},{10026,3},{10026,4},{10026,5},{10025,6},{10025,7},{10025,8},{10024,9},{10024,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3274) ->
	#bmon_group{
		no = 3274,
		name = <<"伏魔塔274层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,57920.732},
		mon_pool_fixed = [{10110,1},{10025,2},{10025,3},{10025,4},{10025,5},{10024,6},{10024,7},{10024,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3275) ->
	#bmon_group{
		no = 3275,
		name = <<"伏魔塔275层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,58327.884},
		mon_pool_fixed = [{10111,1},{10024,2},{10024,3},{10024,4},{10024,5},{10023,6},{10023,7},{10023,8},{10022,9},{10022,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3276) ->
	#bmon_group{
		no = 3276,
		name = <<"伏魔塔276层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,58736.322},
		mon_pool_fixed = [{10112,1},{10023,2},{10023,3},{10023,4},{10023,5},{10022,6},{10022,7},{10022,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3277) ->
	#bmon_group{
		no = 3277,
		name = <<"伏魔塔277层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,59146.047},
		mon_pool_fixed = [{10113,1},{10022,2},{10022,3},{10022,4},{10022,5},{10021,6},{10021,7},{10021,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3278) ->
	#bmon_group{
		no = 3278,
		name = <<"伏魔塔278层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,59557.058},
		mon_pool_fixed = [{10201,1},{10021,2},{10021,3},{10021,4},{10021,5},{10020,6},{10020,7},{10020,8},{10019,9},{10019,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3279) ->
	#bmon_group{
		no = 3279,
		name = <<"伏魔塔279层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,59969.356},
		mon_pool_fixed = [{10202,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3280) ->
	#bmon_group{
		no = 3280,
		name = <<"伏魔塔280层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,60382.94},
		mon_pool_fixed = [{10203,1},{10019,2},{10019,3},{10019,4},{10019,5},{10018,6},{10018,7},{10018,8},{10017,9},{10017,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3281) ->
	#bmon_group{
		no = 3281,
		name = <<"伏魔塔281层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,60797.81},
		mon_pool_fixed = [{10204,1},{10018,2},{10018,3},{10018,4},{10018,5},{10017,6},{10017,7},{10017,8},{10016,9},{10016,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3282) ->
	#bmon_group{
		no = 3282,
		name = <<"伏魔塔282层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,61213.967},
		mon_pool_fixed = [{10205,1},{10017,2},{10017,3},{10017,4},{10017,5},{10016,6},{10016,7},{10016,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3283) ->
	#bmon_group{
		no = 3283,
		name = <<"伏魔塔283层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,61631.41},
		mon_pool_fixed = [{10206,1},{10016,2},{10016,3},{10016,4},{10016,5},{10015,6},{10015,7},{10015,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3284) ->
	#bmon_group{
		no = 3284,
		name = <<"伏魔塔284层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,62050.14},
		mon_pool_fixed = [{10207,1},{10015,2},{10015,3},{10015,4},{10015,5},{10014,6},{10014,7},{10014,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3285) ->
	#bmon_group{
		no = 3285,
		name = <<"伏魔塔285层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,62470.157},
		mon_pool_fixed = [{10208,1},{10014,2},{10014,3},{10014,4},{10014,5},{10013,6},{10013,7},{10013,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3286) ->
	#bmon_group{
		no = 3286,
		name = <<"伏魔塔286层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,62891.459},
		mon_pool_fixed = [{10209,1},{10013,2},{10013,3},{10013,4},{10013,5},{10012,6},{10012,7},{10012,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3287) ->
	#bmon_group{
		no = 3287,
		name = <<"伏魔塔287层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,63314.049},
		mon_pool_fixed = [{10210,1},{10012,2},{10012,3},{10012,4},{10012,5},{10011,6},{10011,7},{10011,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3288) ->
	#bmon_group{
		no = 3288,
		name = <<"伏魔塔288层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,63737.924},
		mon_pool_fixed = [{10211,1},{10011,2},{10011,3},{10011,4},{10011,5},{10010,6},{10010,7},{10010,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3289) ->
	#bmon_group{
		no = 3289,
		name = <<"伏魔塔289层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,64163.086},
		mon_pool_fixed = [{10212,1},{10010,2},{10010,3},{10010,4},{10010,5},{10009,6},{10009,7},{10009,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3290) ->
	#bmon_group{
		no = 3290,
		name = <<"伏魔塔290层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,64589.535},
		mon_pool_fixed = [{10213,1},{10009,2},{10009,3},{10009,4},{10009,5},{10008,6},{10008,7},{10008,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3291) ->
	#bmon_group{
		no = 3291,
		name = <<"伏魔塔291层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,65017.27},
		mon_pool_fixed = [{10214,1},{10008,2},{10008,3},{10008,4},{10008,5},{10007,6},{10007,7},{10007,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3292) ->
	#bmon_group{
		no = 3292,
		name = <<"伏魔塔292层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,65446.292},
		mon_pool_fixed = [{10301,1},{10007,2},{10007,3},{10007,4},{10007,5},{10006,6},{10006,7},{10006,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3293) ->
	#bmon_group{
		no = 3293,
		name = <<"伏魔塔293层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,65876.6},
		mon_pool_fixed = [{10302,1},{10006,2},{10006,3},{10006,4},{10006,5},{10005,6},{10005,7},{10005,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3294) ->
	#bmon_group{
		no = 3294,
		name = <<"伏魔塔294层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,66308.194},
		mon_pool_fixed = [{10303,1},{10005,2},{10005,3},{10005,4},{10005,5},{10004,6},{10004,7},{10004,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3295) ->
	#bmon_group{
		no = 3295,
		name = <<"伏魔塔295层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,66741.075},
		mon_pool_fixed = [{10304,1},{10004,2},{10004,3},{10004,4},{10004,5},{10003,6},{10003,7},{10003,8},{10002,9},{10002,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3296) ->
	#bmon_group{
		no = 3296,
		name = <<"伏魔塔296层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,67175.242},
		mon_pool_fixed = [{10305,1},{10003,2},{10003,3},{10003,4},{10003,5},{10002,6},{10002,7},{10002,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3297) ->
	#bmon_group{
		no = 3297,
		name = <<"伏魔塔297层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,67610.696},
		mon_pool_fixed = [{10306,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3298) ->
	#bmon_group{
		no = 3298,
		name = <<"伏魔塔298层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,68047.436},
		mon_pool_fixed = [{10302,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3299) ->
	#bmon_group{
		no = 3299,
		name = <<"伏魔塔299层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,68485.463},
		mon_pool_fixed = [{10304,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(3300) ->
	#bmon_group{
		no = 3300,
		name = <<"伏魔塔300层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,68924.776},
		mon_pool_fixed = [{10301,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4001) ->
	#bmon_group{
		no = 4001,
		name = <<"镇妖塔1层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,298.285},
		mon_pool_fixed = [{10101,1},{10001,2},{10001,3},{10003,4},{10003,5},{10007,6},{10007,7},{10007,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4002) ->
	#bmon_group{
		no = 4002,
		name = <<"镇妖塔2层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,338.198},
		mon_pool_fixed = [{10102,1},{10002,2},{10002,3},{10004,4},{10004,5},{10008,6},{10008,7},{10008,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4003) ->
	#bmon_group{
		no = 4003,
		name = <<"镇妖塔3层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,380.59},
		mon_pool_fixed = [{10103,1},{10003,2},{10003,3},{10005,4},{10005,5},{10009,6},{10009,7},{10009,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4004) ->
	#bmon_group{
		no = 4004,
		name = <<"镇妖塔4层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,450.17},
		mon_pool_fixed = [{10104,1},{10004,2},{10004,3},{10006,4},{10006,5},{10010,6},{10010,7},{10010,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4005) ->
	#bmon_group{
		no = 4005,
		name = <<"镇妖塔5层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,525.137},
		mon_pool_fixed = [{10105,1},{10005,2},{10005,3},{10007,4},{10007,5},{10011,6},{10011,7},{10011,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4006) ->
	#bmon_group{
		no = 4006,
		name = <<"镇妖塔6层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,591.879},
		mon_pool_fixed = [{10106,1},{10006,2},{10006,3},{10008,4},{10008,5},{10012,6},{10012,7},{10012,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4007) ->
	#bmon_group{
		no = 4007,
		name = <<"镇妖塔7层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,633.823},
		mon_pool_fixed = [{10107,1},{10007,2},{10007,3},{10009,4},{10009,5},{10013,6},{10013,7},{10013,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4008) ->
	#bmon_group{
		no = 4008,
		name = <<"镇妖塔8层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,677.604},
		mon_pool_fixed = [{10108,1},{10008,2},{10008,3},{10010,4},{10010,5},{10014,6},{10014,7},{10014,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4009) ->
	#bmon_group{
		no = 4009,
		name = <<"镇妖塔9层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,723.692},
		mon_pool_fixed = [{10109,1},{10009,2},{10009,3},{10011,4},{10011,5},{10015,6},{10015,7},{10015,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4010) ->
	#bmon_group{
		no = 4010,
		name = <<"镇妖塔10层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,771.278},
		mon_pool_fixed = [{10110,1},{10010,2},{10010,3},{10012,4},{10012,5},{10016,6},{10016,7},{10016,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4011) ->
	#bmon_group{
		no = 4011,
		name = <<"镇妖塔11层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,820.357},
		mon_pool_fixed = [{10111,1},{10011,2},{10011,3},{10013,4},{10013,5},{10017,6},{10017,7},{10017,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4012) ->
	#bmon_group{
		no = 4012,
		name = <<"镇妖塔12层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,883.034},
		mon_pool_fixed = [{10112,1},{10012,2},{10012,3},{10014,4},{10014,5},{10018,6},{10018,7},{10018,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4013) ->
	#bmon_group{
		no = 4013,
		name = <<"镇妖塔13层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,947.851},
		mon_pool_fixed = [{10113,1},{10013,2},{10013,3},{10015,4},{10015,5},{10019,6},{10019,7},{10019,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4014) ->
	#bmon_group{
		no = 4014,
		name = <<"镇妖塔14层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1014.808},
		mon_pool_fixed = [{10201,1},{10014,2},{10014,3},{10016,4},{10016,5},{10020,6},{10020,7},{10020,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4015) ->
	#bmon_group{
		no = 4015,
		name = <<"镇妖塔15层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1087.183},
		mon_pool_fixed = [{10202,1},{10015,2},{10015,3},{10017,4},{10017,5},{10021,6},{10021,7},{10021,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4016) ->
	#bmon_group{
		no = 4016,
		name = <<"镇妖塔16层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1163.538},
		mon_pool_fixed = [{10203,1},{10016,2},{10016,3},{10018,4},{10018,5},{10022,6},{10022,7},{10022,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4017) ->
	#bmon_group{
		no = 4017,
		name = <<"镇妖塔17层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1242.273},
		mon_pool_fixed = [{10204,1},{10017,2},{10017,3},{10019,4},{10019,5},{10023,6},{10023,7},{10023,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4018) ->
	#bmon_group{
		no = 4018,
		name = <<"镇妖塔18层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1315.81},
		mon_pool_fixed = [{10205,1},{10018,2},{10018,3},{10020,4},{10020,5},{10024,6},{10024,7},{10024,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4019) ->
	#bmon_group{
		no = 4019,
		name = <<"镇妖塔19层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1375.884},
		mon_pool_fixed = [{10206,1},{10019,2},{10019,3},{10021,4},{10021,5},{10025,6},{10025,7},{10025,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4020) ->
	#bmon_group{
		no = 4020,
		name = <<"镇妖塔20层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1437.299},
		mon_pool_fixed = [{10207,1},{10020,2},{10020,3},{10022,4},{10022,5},{10026,6},{10026,7},{10026,8}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4021) ->
	#bmon_group{
		no = 4021,
		name = <<"镇妖塔21层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1500.058},
		mon_pool_fixed = [{10208,1},{10021,2},{10021,3},{10023,4},{10023,5},{10027,6},{10027,7},{10027,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4022) ->
	#bmon_group{
		no = 4022,
		name = <<"镇妖塔22层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1648.594},
		mon_pool_fixed = [{10209,1},{10022,2},{10022,3},{10024,4},{10024,5},{10028,6},{10028,7},{10028,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4023) ->
	#bmon_group{
		no = 4023,
		name = <<"镇妖塔23层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1802.014},
		mon_pool_fixed = [{10210,1},{10023,2},{10023,3},{10025,4},{10025,5},{10029,6},{10029,7},{10029,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4024) ->
	#bmon_group{
		no = 4024,
		name = <<"镇妖塔24层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,1960.317},
		mon_pool_fixed = [{10211,1},{10024,2},{10024,3},{10026,4},{10026,5},{10030,6},{10030,7},{10030,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4025) ->
	#bmon_group{
		no = 4025,
		name = <<"镇妖塔25层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2075.612},
		mon_pool_fixed = [{10212,1},{10025,2},{10025,3},{10027,4},{10027,5},{10031,6},{10031,7},{10031,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4026) ->
	#bmon_group{
		no = 4026,
		name = <<"镇妖塔26层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2169.485},
		mon_pool_fixed = [{10213,1},{10026,2},{10026,3},{10028,4},{10028,5},{10032,6},{10032,7},{10032,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4027) ->
	#bmon_group{
		no = 4027,
		name = <<"镇妖塔27层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2265.407},
		mon_pool_fixed = [{10214,1},{10027,2},{10027,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4028) ->
	#bmon_group{
		no = 4028,
		name = <<"镇妖塔28层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2371.393},
		mon_pool_fixed = [{10301,1},{10028,2},{10028,3},{10030,4},{10030,5},{10034,6},{10034,7},{10034,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4029) ->
	#bmon_group{
		no = 4029,
		name = <<"镇妖塔29层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2496.062},
		mon_pool_fixed = [{10302,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4030) ->
	#bmon_group{
		no = 4030,
		name = <<"镇妖塔30层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2623.675},
		mon_pool_fixed = [{10303,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4031) ->
	#bmon_group{
		no = 4031,
		name = <<"镇妖塔31层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2754.228},
		mon_pool_fixed = [{10304,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4032) ->
	#bmon_group{
		no = 4032,
		name = <<"镇妖塔32层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,2927.153},
		mon_pool_fixed = [{10305,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4033) ->
	#bmon_group{
		no = 4033,
		name = <<"镇妖塔33层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3104.39},
		mon_pool_fixed = [{10306,1},{10036,2},{10036,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10034,9},{10034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4034) ->
	#bmon_group{
		no = 4034,
		name = <<"镇妖塔34层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3285.939},
		mon_pool_fixed = [{10101,1},{10035,2},{10035,3},{10035,4},{10035,5},{10034,6},{10034,7},{10034,8},{10033,9},{10033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4035) ->
	#bmon_group{
		no = 4035,
		name = <<"镇妖塔35层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3446.266},
		mon_pool_fixed = [{10102,1},{10034,2},{10034,3},{10034,4},{10034,5},{10033,6},{10033,7},{10033,8},{10032,9},{10032,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4036) ->
	#bmon_group{
		no = 4036,
		name = <<"镇妖塔36层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3597.09},
		mon_pool_fixed = [{10103,1},{10033,2},{10033,3},{10033,4},{10033,5},{10032,6},{10032,7},{10032,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4037) ->
	#bmon_group{
		no = 4037,
		name = <<"镇妖塔37层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3750.963},
		mon_pool_fixed = [{10104,1},{10032,2},{10032,3},{10032,4},{10032,5},{10031,6},{10031,7},{10031,8},{10030,9},{10030,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4038) ->
	#bmon_group{
		no = 4038,
		name = <<"镇妖塔38层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,3912.9},
		mon_pool_fixed = [{10105,1},{10031,2},{10031,3},{10031,4},{10031,5},{10030,6},{10030,7},{10030,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4039) ->
	#bmon_group{
		no = 4039,
		name = <<"镇妖塔39层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4088.228},
		mon_pool_fixed = [{10106,1},{10030,2},{10030,3},{10030,4},{10030,5},{10029,6},{10029,7},{10029,8},{10028,9},{10028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4040) ->
	#bmon_group{
		no = 4040,
		name = <<"镇妖塔40层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4267.077},
		mon_pool_fixed = [{10107,1},{10029,2},{10029,3},{10029,4},{10029,5},{10028,6},{10028,7},{10028,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4041) ->
	#bmon_group{
		no = 4041,
		name = <<"镇妖塔41层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4449.438},
		mon_pool_fixed = [{10108,1},{10028,2},{10028,3},{10028,4},{10028,5},{10027,6},{10027,7},{10027,8},{10026,9},{10026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4042) ->
	#bmon_group{
		no = 4042,
		name = <<"镇妖塔42层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,4726.589},
		mon_pool_fixed = [{10109,1},{10027,2},{10027,3},{10027,4},{10027,5},{10026,6},{10026,7},{10026,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4043) ->
	#bmon_group{
		no = 4043,
		name = <<"镇妖塔43层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5009.959},
		mon_pool_fixed = [{10110,1},{10026,2},{10026,3},{10026,4},{10026,5},{10025,6},{10025,7},{10025,8},{10024,9},{10024,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4044) ->
	#bmon_group{
		no = 4044,
		name = <<"镇妖塔44层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5299.548},
		mon_pool_fixed = [{10111,1},{10025,2},{10025,3},{10025,4},{10025,5},{10024,6},{10024,7},{10024,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4045) ->
	#bmon_group{
		no = 4045,
		name = <<"镇妖塔45层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5511.457},
		mon_pool_fixed = [{10112,1},{10024,2},{10024,3},{10024,4},{10024,5},{10023,6},{10023,7},{10023,8},{10022,9},{10022,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4046) ->
	#bmon_group{
		no = 4046,
		name = <<"镇妖塔46层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5684.658},
		mon_pool_fixed = [{10113,1},{10023,2},{10023,3},{10023,4},{10023,5},{10022,6},{10022,7},{10022,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4047) ->
	#bmon_group{
		no = 4047,
		name = <<"镇妖塔47层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,5860.516},
		mon_pool_fixed = [{10201,1},{10022,2},{10022,3},{10022,4},{10022,5},{10021,6},{10021,7},{10021,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4048) ->
	#bmon_group{
		no = 4048,
		name = <<"镇妖塔48层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6055.67},
		mon_pool_fixed = [{10202,1},{10021,2},{10021,3},{10021,4},{10021,5},{10020,6},{10020,7},{10020,8},{10019,9},{10019,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4049) ->
	#bmon_group{
		no = 4049,
		name = <<"镇妖塔49层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6287.689},
		mon_pool_fixed = [{10203,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4050) ->
	#bmon_group{
		no = 4050,
		name = <<"镇妖塔50层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6523.721},
		mon_pool_fixed = [{10204,1},{10019,2},{10019,3},{10019,4},{10019,5},{10018,6},{10018,7},{10018,8},{10017,9},{10017,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4051) ->
	#bmon_group{
		no = 4051,
		name = <<"镇妖塔51层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,6763.771},
		mon_pool_fixed = [{10205,1},{10018,2},{10018,3},{10018,4},{10018,5},{10017,6},{10017,7},{10017,8},{10016,9},{10016,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4052) ->
	#bmon_group{
		no = 4052,
		name = <<"镇妖塔52层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7098.832},
		mon_pool_fixed = [{10206,1},{10017,2},{10017,3},{10017,4},{10017,5},{10016,6},{10016,7},{10016,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4053) ->
	#bmon_group{
		no = 4053,
		name = <<"镇妖塔53层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7440.249},
		mon_pool_fixed = [{10207,1},{10016,2},{10016,3},{10016,4},{10016,5},{10015,6},{10015,7},{10015,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4054) ->
	#bmon_group{
		no = 4054,
		name = <<"镇妖塔54层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,7788.023},
		mon_pool_fixed = [{10208,1},{10015,2},{10015,3},{10015,4},{10015,5},{10014,6},{10014,7},{10014,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4055) ->
	#bmon_group{
		no = 4055,
		name = <<"镇妖塔55层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8117.846},
		mon_pool_fixed = [{10209,1},{10014,2},{10014,3},{10014,4},{10014,5},{10013,6},{10013,7},{10013,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4056) ->
	#bmon_group{
		no = 4056,
		name = <<"镇妖塔56层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8441.134},
		mon_pool_fixed = [{10210,1},{10013,2},{10013,3},{10013,4},{10013,5},{10012,6},{10012,7},{10012,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4057) ->
	#bmon_group{
		no = 4057,
		name = <<"镇妖塔57层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8769.875},
		mon_pool_fixed = [{10211,1},{10012,2},{10012,3},{10012,4},{10012,5},{10011,6},{10011,7},{10011,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4058) ->
	#bmon_group{
		no = 4058,
		name = <<"镇妖塔58层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,8992.073},
		mon_pool_fixed = [{10212,1},{10011,2},{10011,3},{10011,4},{10011,5},{10010,6},{10010,7},{10010,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4059) ->
	#bmon_group{
		no = 4059,
		name = <<"镇妖塔59层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,9244.96},
		mon_pool_fixed = [{10213,1},{10010,2},{10010,3},{10010,4},{10010,5},{10009,6},{10009,7},{10009,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4060) ->
	#bmon_group{
		no = 4060,
		name = <<"镇妖塔60层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,9500.72},
		mon_pool_fixed = [{10214,1},{10009,2},{10009,3},{10009,4},{10009,5},{10008,6},{10008,7},{10008,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4061) ->
	#bmon_group{
		no = 4061,
		name = <<"镇妖塔61层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,9759.352},
		mon_pool_fixed = [{10301,1},{10008,2},{10008,3},{10008,4},{10008,5},{10007,6},{10007,7},{10007,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4062) ->
	#bmon_group{
		no = 4062,
		name = <<"镇妖塔62层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,10020.857},
		mon_pool_fixed = [{10302,1},{10007,2},{10007,3},{10007,4},{10007,5},{10006,6},{10006,7},{10006,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4063) ->
	#bmon_group{
		no = 4063,
		name = <<"镇妖塔63层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,10285.244},
		mon_pool_fixed = [{10303,1},{10006,2},{10006,3},{10006,4},{10006,5},{10005,6},{10005,7},{10005,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4064) ->
	#bmon_group{
		no = 4064,
		name = <<"镇妖塔64层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,10758.304},
		mon_pool_fixed = [{10304,1},{10005,2},{10005,3},{10005,4},{10005,5},{10004,6},{10004,7},{10004,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4065) ->
	#bmon_group{
		no = 4065,
		name = <<"镇妖塔65层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,11237.379},
		mon_pool_fixed = [{10305,1},{10004,2},{10004,3},{10004,4},{10004,5},{10003,6},{10003,7},{10003,8},{10002,9},{10002,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4066) ->
	#bmon_group{
		no = 4066,
		name = <<"镇妖塔66层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,11722.468},
		mon_pool_fixed = [{10306,1},{10003,2},{10003,3},{10003,4},{10003,5},{10002,6},{10002,7},{10002,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4067) ->
	#bmon_group{
		no = 4067,
		name = <<"镇妖塔67层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,12213.572},
		mon_pool_fixed = [{10101,1},{10021,2},{10021,3},{10023,4},{10023,5},{10027,6},{10027,7},{10027,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4068) ->
	#bmon_group{
		no = 4068,
		name = <<"镇妖塔68层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,12710.704},
		mon_pool_fixed = [{10102,1},{10022,2},{10022,3},{10024,4},{10024,5},{10028,6},{10028,7},{10028,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4069) ->
	#bmon_group{
		no = 4069,
		name = <<"镇妖塔69层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,13034.099},
		mon_pool_fixed = [{10103,1},{10023,2},{10023,3},{10025,4},{10025,5},{10029,6},{10029,7},{10029,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4070) ->
	#bmon_group{
		no = 4070,
		name = <<"镇妖塔70层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,13360.865},
		mon_pool_fixed = [{10104,1},{10024,2},{10024,3},{10026,4},{10026,5},{10030,6},{10030,7},{10030,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4071) ->
	#bmon_group{
		no = 4071,
		name = <<"镇妖塔71层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,13691.002},
		mon_pool_fixed = [{10105,1},{10025,2},{10025,3},{10027,4},{10027,5},{10031,6},{10031,7},{10031,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4072) ->
	#bmon_group{
		no = 4072,
		name = <<"镇妖塔72层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,14024.511},
		mon_pool_fixed = [{10106,1},{10026,2},{10026,3},{10028,4},{10028,5},{10032,6},{10032,7},{10032,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4073) ->
	#bmon_group{
		no = 4073,
		name = <<"镇妖塔73层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,14361.379},
		mon_pool_fixed = [{10107,1},{10027,2},{10027,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4074) ->
	#bmon_group{
		no = 4074,
		name = <<"镇妖塔74层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,14773.636},
		mon_pool_fixed = [{10108,1},{10028,2},{10028,3},{10030,4},{10030,5},{10034,6},{10034,7},{10034,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4075) ->
	#bmon_group{
		no = 4075,
		name = <<"镇妖塔75层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,15190.285},
		mon_pool_fixed = [{10109,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4076) ->
	#bmon_group{
		no = 4076,
		name = <<"镇妖塔76层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,15611.327},
		mon_pool_fixed = [{10110,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4077) ->
	#bmon_group{
		no = 4077,
		name = <<"镇妖塔77层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,16036.762},
		mon_pool_fixed = [{10111,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4078) ->
	#bmon_group{
		no = 4078,
		name = <<"镇妖塔78层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,16466.586},
		mon_pool_fixed = [{10112,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4079) ->
	#bmon_group{
		no = 4079,
		name = <<"镇妖塔79层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,17094.944},
		mon_pool_fixed = [{10113,1},{10036,2},{10036,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10034,9},{10034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4080) ->
	#bmon_group{
		no = 4080,
		name = <<"镇妖塔80层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,17730.355},
		mon_pool_fixed = [{10201,1},{10035,2},{10035,3},{10035,4},{10035,5},{10034,6},{10034,7},{10034,8},{10033,9},{10033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4081) ->
	#bmon_group{
		no = 4081,
		name = <<"镇妖塔81层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,18372.818},
		mon_pool_fixed = [{10202,1},{10034,2},{10034,3},{10034,4},{10034,5},{10033,6},{10033,7},{10033,8},{10032,9},{10032,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4082) ->
	#bmon_group{
		no = 4082,
		name = <<"镇妖塔82层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,19022.332},
		mon_pool_fixed = [{10203,1},{10033,2},{10033,3},{10033,4},{10033,5},{10032,6},{10032,7},{10032,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4083) ->
	#bmon_group{
		no = 4083,
		name = <<"镇妖塔83层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,19678.893},
		mon_pool_fixed = [{10204,1},{10032,2},{10032,3},{10032,4},{10032,5},{10031,6},{10031,7},{10031,8},{10030,9},{10030,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4084) ->
	#bmon_group{
		no = 4084,
		name = <<"镇妖塔84层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,20198.615},
		mon_pool_fixed = [{10205,1},{10031,2},{10031,3},{10031,4},{10031,5},{10030,6},{10030,7},{10030,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4085) ->
	#bmon_group{
		no = 4085,
		name = <<"镇妖塔85层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,20723.482},
		mon_pool_fixed = [{10206,1},{10030,2},{10030,3},{10030,4},{10030,5},{10029,6},{10029,7},{10029,8},{10028,9},{10028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4086) ->
	#bmon_group{
		no = 4086,
		name = <<"镇妖塔86层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,21253.496},
		mon_pool_fixed = [{10207,1},{10029,2},{10029,3},{10029,4},{10029,5},{10028,6},{10028,7},{10028,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4087) ->
	#bmon_group{
		no = 4087,
		name = <<"镇妖塔87层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,21788.656},
		mon_pool_fixed = [{10208,1},{10028,2},{10028,3},{10028,4},{10028,5},{10027,6},{10027,7},{10027,8},{10026,9},{10026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4088) ->
	#bmon_group{
		no = 4088,
		name = <<"镇妖塔88层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,22328.953},
		mon_pool_fixed = [{10209,1},{10027,2},{10027,3},{10027,4},{10027,5},{10026,6},{10026,7},{10026,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4089) ->
	#bmon_group{
		no = 4089,
		name = <<"镇妖塔89层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,22874.386},
		mon_pool_fixed = [{10210,1},{10026,2},{10026,3},{10026,4},{10026,5},{10025,6},{10025,7},{10025,8},{10024,9},{10024,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4090) ->
	#bmon_group{
		no = 4090,
		name = <<"镇妖塔90层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,23424.965},
		mon_pool_fixed = [{10211,1},{10025,2},{10025,3},{10025,4},{10025,5},{10024,6},{10024,7},{10024,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4091) ->
	#bmon_group{
		no = 4091,
		name = <<"镇妖塔91层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,23980.69},
		mon_pool_fixed = [{10212,1},{10024,2},{10024,3},{10024,4},{10024,5},{10023,6},{10023,7},{10023,8},{10022,9},{10022,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4092) ->
	#bmon_group{
		no = 4092,
		name = <<"镇妖塔92层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,24541.561},
		mon_pool_fixed = [{10213,1},{10023,2},{10023,3},{10023,4},{10023,5},{10022,6},{10022,7},{10022,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4093) ->
	#bmon_group{
		no = 4093,
		name = <<"镇妖塔93层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,25107.578},
		mon_pool_fixed = [{10214,1},{10022,2},{10022,3},{10022,4},{10022,5},{10021,6},{10021,7},{10021,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4094) ->
	#bmon_group{
		no = 4094,
		name = <<"镇妖塔94层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,25678.74},
		mon_pool_fixed = [{10301,1},{10021,2},{10021,3},{10021,4},{10021,5},{10020,6},{10020,7},{10020,8},{10019,9},{10019,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4095) ->
	#bmon_group{
		no = 4095,
		name = <<"镇妖塔95层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,26255.048},
		mon_pool_fixed = [{10302,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4096) ->
	#bmon_group{
		no = 4096,
		name = <<"镇妖塔96层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,26836.503},
		mon_pool_fixed = [{10303,1},{10019,2},{10019,3},{10019,4},{10019,5},{10018,6},{10018,7},{10018,8},{10017,9},{10017,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4097) ->
	#bmon_group{
		no = 4097,
		name = <<"镇妖塔97层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,27423.103},
		mon_pool_fixed = [{10304,1},{10018,2},{10018,3},{10018,4},{10018,5},{10017,6},{10017,7},{10017,8},{10016,9},{10016,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4098) ->
	#bmon_group{
		no = 4098,
		name = <<"镇妖塔98层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,28014.848},
		mon_pool_fixed = [{10305,1},{10017,2},{10017,3},{10017,4},{10017,5},{10016,6},{10016,7},{10016,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4099) ->
	#bmon_group{
		no = 4099,
		name = <<"镇妖塔99层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,28611.74},
		mon_pool_fixed = [{10306,1},{10016,2},{10016,3},{10016,4},{10016,5},{10015,6},{10015,7},{10015,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4100) ->
	#bmon_group{
		no = 4100,
		name = <<"镇妖塔100层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,29213.778},
		mon_pool_fixed = [{10101,1},{10015,2},{10015,3},{10015,4},{10015,5},{10014,6},{10014,7},{10014,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4101) ->
	#bmon_group{
		no = 4101,
		name = <<"镇妖塔101层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,29820.961},
		mon_pool_fixed = [{10102,1},{10014,2},{10014,3},{10014,4},{10014,5},{10013,6},{10013,7},{10013,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4102) ->
	#bmon_group{
		no = 4102,
		name = <<"镇妖塔102层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,30433.29},
		mon_pool_fixed = [{10103,1},{10013,2},{10013,3},{10013,4},{10013,5},{10012,6},{10012,7},{10012,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4103) ->
	#bmon_group{
		no = 4103,
		name = <<"镇妖塔103层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,31050.765},
		mon_pool_fixed = [{10104,1},{10012,2},{10012,3},{10012,4},{10012,5},{10011,6},{10011,7},{10011,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4104) ->
	#bmon_group{
		no = 4104,
		name = <<"镇妖塔104层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,31673.386},
		mon_pool_fixed = [{10105,1},{10011,2},{10011,3},{10011,4},{10011,5},{10010,6},{10010,7},{10010,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4105) ->
	#bmon_group{
		no = 4105,
		name = <<"镇妖塔105层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,32301.153},
		mon_pool_fixed = [{10106,1},{10010,2},{10010,3},{10010,4},{10010,5},{10009,6},{10009,7},{10009,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4106) ->
	#bmon_group{
		no = 4106,
		name = <<"镇妖塔106层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,32934.065},
		mon_pool_fixed = [{10107,1},{10009,2},{10009,3},{10009,4},{10009,5},{10008,6},{10008,7},{10008,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4107) ->
	#bmon_group{
		no = 4107,
		name = <<"镇妖塔107层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,33572.124},
		mon_pool_fixed = [{10108,1},{10008,2},{10008,3},{10008,4},{10008,5},{10007,6},{10007,7},{10007,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4108) ->
	#bmon_group{
		no = 4108,
		name = <<"镇妖塔108层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,34215.328},
		mon_pool_fixed = [{10109,1},{10007,2},{10007,3},{10007,4},{10007,5},{10006,6},{10006,7},{10006,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4109) ->
	#bmon_group{
		no = 4109,
		name = <<"镇妖塔109层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,34863.678},
		mon_pool_fixed = [{10110,1},{10006,2},{10006,3},{10006,4},{10006,5},{10005,6},{10005,7},{10005,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4110) ->
	#bmon_group{
		no = 4110,
		name = <<"镇妖塔110层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,35517.174},
		mon_pool_fixed = [{10111,1},{10005,2},{10005,3},{10005,4},{10005,5},{10004,6},{10004,7},{10004,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4111) ->
	#bmon_group{
		no = 4111,
		name = <<"镇妖塔111层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,36175.816},
		mon_pool_fixed = [{10112,1},{10004,2},{10004,3},{10004,4},{10004,5},{10003,6},{10003,7},{10003,8},{10002,9},{10002,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4112) ->
	#bmon_group{
		no = 4112,
		name = <<"镇妖塔112层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,36839.603},
		mon_pool_fixed = [{10113,1},{10003,2},{10003,3},{10003,4},{10003,5},{10002,6},{10002,7},{10002,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4113) ->
	#bmon_group{
		no = 4113,
		name = <<"镇妖塔113层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,37508.537},
		mon_pool_fixed = [{10201,1},{10021,2},{10021,3},{10023,4},{10023,5},{10027,6},{10027,7},{10027,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4114) ->
	#bmon_group{
		no = 4114,
		name = <<"镇妖塔114层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,38182.616},
		mon_pool_fixed = [{10202,1},{10022,2},{10022,3},{10024,4},{10024,5},{10028,6},{10028,7},{10028,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4115) ->
	#bmon_group{
		no = 4115,
		name = <<"镇妖塔115层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,38861.841},
		mon_pool_fixed = [{10203,1},{10023,2},{10023,3},{10025,4},{10025,5},{10029,6},{10029,7},{10029,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4116) ->
	#bmon_group{
		no = 4116,
		name = <<"镇妖塔116层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,39546.212},
		mon_pool_fixed = [{10204,1},{10024,2},{10024,3},{10026,4},{10026,5},{10030,6},{10030,7},{10030,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4117) ->
	#bmon_group{
		no = 4117,
		name = <<"镇妖塔117层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,40235.729},
		mon_pool_fixed = [{10205,1},{10025,2},{10025,3},{10027,4},{10027,5},{10031,6},{10031,7},{10031,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4118) ->
	#bmon_group{
		no = 4118,
		name = <<"镇妖塔118层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,40930.392},
		mon_pool_fixed = [{10206,1},{10026,2},{10026,3},{10028,4},{10028,5},{10032,6},{10032,7},{10032,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4119) ->
	#bmon_group{
		no = 4119,
		name = <<"镇妖塔119层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,41630.2},
		mon_pool_fixed = [{10207,1},{10027,2},{10027,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4120) ->
	#bmon_group{
		no = 4120,
		name = <<"镇妖塔120层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,42335.154},
		mon_pool_fixed = [{10208,1},{10028,2},{10028,3},{10030,4},{10030,5},{10034,6},{10034,7},{10034,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4121) ->
	#bmon_group{
		no = 4121,
		name = <<"镇妖塔121层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,43045.255},
		mon_pool_fixed = [{10209,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4122) ->
	#bmon_group{
		no = 4122,
		name = <<"镇妖塔122层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,43760.501},
		mon_pool_fixed = [{10210,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4123) ->
	#bmon_group{
		no = 4123,
		name = <<"镇妖塔123层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,44480.892},
		mon_pool_fixed = [{10211,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4124) ->
	#bmon_group{
		no = 4124,
		name = <<"镇妖塔124层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,45206.43},
		mon_pool_fixed = [{10212,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4125) ->
	#bmon_group{
		no = 4125,
		name = <<"镇妖塔125层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,45937.114},
		mon_pool_fixed = [{10213,1},{10036,2},{10036,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10034,9},{10034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4126) ->
	#bmon_group{
		no = 4126,
		name = <<"镇妖塔126层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,46672.943},
		mon_pool_fixed = [{10214,1},{10035,2},{10035,3},{10035,4},{10035,5},{10034,6},{10034,7},{10034,8},{10033,9},{10033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4127) ->
	#bmon_group{
		no = 4127,
		name = <<"镇妖塔127层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,47413.918},
		mon_pool_fixed = [{10301,1},{10034,2},{10034,3},{10034,4},{10034,5},{10033,6},{10033,7},{10033,8},{10032,9},{10032,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4128) ->
	#bmon_group{
		no = 4128,
		name = <<"镇妖塔128层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,48160.039},
		mon_pool_fixed = [{10302,1},{10033,2},{10033,3},{10033,4},{10033,5},{10032,6},{10032,7},{10032,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4129) ->
	#bmon_group{
		no = 4129,
		name = <<"镇妖塔129层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,48911.306},
		mon_pool_fixed = [{10303,1},{10032,2},{10032,3},{10032,4},{10032,5},{10031,6},{10031,7},{10031,8},{10030,9},{10030,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4130) ->
	#bmon_group{
		no = 4130,
		name = <<"镇妖塔130层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,49667.719},
		mon_pool_fixed = [{10304,1},{10031,2},{10031,3},{10031,4},{10031,5},{10030,6},{10030,7},{10030,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4131) ->
	#bmon_group{
		no = 4131,
		name = <<"镇妖塔131层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,50429.277},
		mon_pool_fixed = [{10305,1},{10030,2},{10030,3},{10030,4},{10030,5},{10029,6},{10029,7},{10029,8},{10028,9},{10028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4132) ->
	#bmon_group{
		no = 4132,
		name = <<"镇妖塔132层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,51195.982},
		mon_pool_fixed = [{10306,1},{10029,2},{10029,3},{10029,4},{10029,5},{10028,6},{10028,7},{10028,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4133) ->
	#bmon_group{
		no = 4133,
		name = <<"镇妖塔133层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,51967.832},
		mon_pool_fixed = [{10101,1},{10028,2},{10028,3},{10028,4},{10028,5},{10027,6},{10027,7},{10027,8},{10026,9},{10026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4134) ->
	#bmon_group{
		no = 4134,
		name = <<"镇妖塔134层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,52744.828},
		mon_pool_fixed = [{10102,1},{10027,2},{10027,3},{10027,4},{10027,5},{10026,6},{10026,7},{10026,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4135) ->
	#bmon_group{
		no = 4135,
		name = <<"镇妖塔135层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,53526.97},
		mon_pool_fixed = [{10103,1},{10026,2},{10026,3},{10026,4},{10026,5},{10025,6},{10025,7},{10025,8},{10024,9},{10024,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4136) ->
	#bmon_group{
		no = 4136,
		name = <<"镇妖塔136层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,54314.258},
		mon_pool_fixed = [{10104,1},{10025,2},{10025,3},{10025,4},{10025,5},{10024,6},{10024,7},{10024,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4137) ->
	#bmon_group{
		no = 4137,
		name = <<"镇妖塔137层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,55106.691},
		mon_pool_fixed = [{10105,1},{10024,2},{10024,3},{10024,4},{10024,5},{10023,6},{10023,7},{10023,8},{10022,9},{10022,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4138) ->
	#bmon_group{
		no = 4138,
		name = <<"镇妖塔138层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,55904.271},
		mon_pool_fixed = [{10106,1},{10023,2},{10023,3},{10023,4},{10023,5},{10022,6},{10022,7},{10022,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4139) ->
	#bmon_group{
		no = 4139,
		name = <<"镇妖塔139层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,56706.996},
		mon_pool_fixed = [{10107,1},{10022,2},{10022,3},{10022,4},{10022,5},{10021,6},{10021,7},{10021,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4140) ->
	#bmon_group{
		no = 4140,
		name = <<"镇妖塔140层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,57514.867},
		mon_pool_fixed = [{10108,1},{10021,2},{10021,3},{10021,4},{10021,5},{10020,6},{10020,7},{10020,8},{10019,9},{10019,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4141) ->
	#bmon_group{
		no = 4141,
		name = <<"镇妖塔141层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,58327.884},
		mon_pool_fixed = [{10109,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4142) ->
	#bmon_group{
		no = 4142,
		name = <<"镇妖塔142层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,59146.047},
		mon_pool_fixed = [{10110,1},{10019,2},{10019,3},{10019,4},{10019,5},{10018,6},{10018,7},{10018,8},{10017,9},{10017,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4143) ->
	#bmon_group{
		no = 4143,
		name = <<"镇妖塔143层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,59969.356},
		mon_pool_fixed = [{10111,1},{10018,2},{10018,3},{10018,4},{10018,5},{10017,6},{10017,7},{10017,8},{10016,9},{10016,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4144) ->
	#bmon_group{
		no = 4144,
		name = <<"镇妖塔144层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,60797.81},
		mon_pool_fixed = [{10112,1},{10017,2},{10017,3},{10017,4},{10017,5},{10016,6},{10016,7},{10016,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4145) ->
	#bmon_group{
		no = 4145,
		name = <<"镇妖塔145层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,61631.41},
		mon_pool_fixed = [{10113,1},{10016,2},{10016,3},{10016,4},{10016,5},{10015,6},{10015,7},{10015,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4146) ->
	#bmon_group{
		no = 4146,
		name = <<"镇妖塔146层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,62470.157},
		mon_pool_fixed = [{10201,1},{10015,2},{10015,3},{10015,4},{10015,5},{10014,6},{10014,7},{10014,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4147) ->
	#bmon_group{
		no = 4147,
		name = <<"镇妖塔147层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,63314.049},
		mon_pool_fixed = [{10202,1},{10014,2},{10014,3},{10014,4},{10014,5},{10013,6},{10013,7},{10013,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4148) ->
	#bmon_group{
		no = 4148,
		name = <<"镇妖塔148层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,64163.086},
		mon_pool_fixed = [{10203,1},{10013,2},{10013,3},{10013,4},{10013,5},{10012,6},{10012,7},{10012,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4149) ->
	#bmon_group{
		no = 4149,
		name = <<"镇妖塔149层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,65017.27},
		mon_pool_fixed = [{10204,1},{10012,2},{10012,3},{10012,4},{10012,5},{10011,6},{10011,7},{10011,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4150) ->
	#bmon_group{
		no = 4150,
		name = <<"镇妖塔150层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,65876.6},
		mon_pool_fixed = [{10205,1},{10011,2},{10011,3},{10011,4},{10011,5},{10010,6},{10010,7},{10010,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4151) ->
	#bmon_group{
		no = 4151,
		name = <<"镇妖塔151层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,66741.075},
		mon_pool_fixed = [{10206,1},{10010,2},{10010,3},{10010,4},{10010,5},{10009,6},{10009,7},{10009,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4152) ->
	#bmon_group{
		no = 4152,
		name = <<"镇妖塔152层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,67610.696},
		mon_pool_fixed = [{10207,1},{10009,2},{10009,3},{10009,4},{10009,5},{10008,6},{10008,7},{10008,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4153) ->
	#bmon_group{
		no = 4153,
		name = <<"镇妖塔153层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,68485.463},
		mon_pool_fixed = [{10208,1},{10008,2},{10008,3},{10008,4},{10008,5},{10007,6},{10007,7},{10007,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4154) ->
	#bmon_group{
		no = 4154,
		name = <<"镇妖塔154层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,69365.376},
		mon_pool_fixed = [{10209,1},{10007,2},{10007,3},{10007,4},{10007,5},{10006,6},{10006,7},{10006,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4155) ->
	#bmon_group{
		no = 4155,
		name = <<"镇妖塔155层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,70250.435},
		mon_pool_fixed = [{10210,1},{10006,2},{10006,3},{10006,4},{10006,5},{10005,6},{10005,7},{10005,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4156) ->
	#bmon_group{
		no = 4156,
		name = <<"镇妖塔156层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,71140.639},
		mon_pool_fixed = [{10211,1},{10005,2},{10005,3},{10005,4},{10005,5},{10004,6},{10004,7},{10004,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4157) ->
	#bmon_group{
		no = 4157,
		name = <<"镇妖塔157层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,72035.99},
		mon_pool_fixed = [{10212,1},{10004,2},{10004,3},{10004,4},{10004,5},{10003,6},{10003,7},{10003,8},{10002,9},{10002,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4158) ->
	#bmon_group{
		no = 4158,
		name = <<"镇妖塔158层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,72936.486},
		mon_pool_fixed = [{10213,1},{10003,2},{10003,3},{10003,4},{10003,5},{10002,6},{10002,7},{10002,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4159) ->
	#bmon_group{
		no = 4159,
		name = <<"镇妖塔159层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,73260.648},
		mon_pool_fixed = [{10214,1},{10021,2},{10021,3},{10023,4},{10023,5},{10027,6},{10027,7},{10027,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4160) ->
	#bmon_group{
		no = 4160,
		name = <<"镇妖塔160层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,73584.81},
		mon_pool_fixed = [{10301,1},{10022,2},{10022,3},{10024,4},{10024,5},{10028,6},{10028,7},{10028,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4161) ->
	#bmon_group{
		no = 4161,
		name = <<"镇妖塔161层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,73908.972},
		mon_pool_fixed = [{10302,1},{10023,2},{10023,3},{10025,4},{10025,5},{10029,6},{10029,7},{10029,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4162) ->
	#bmon_group{
		no = 4162,
		name = <<"镇妖塔162层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,74233.135},
		mon_pool_fixed = [{10303,1},{10024,2},{10024,3},{10026,4},{10026,5},{10030,6},{10030,7},{10030,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4163) ->
	#bmon_group{
		no = 4163,
		name = <<"镇妖塔163层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,74557.297},
		mon_pool_fixed = [{10304,1},{10025,2},{10025,3},{10027,4},{10027,5},{10031,6},{10031,7},{10031,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4164) ->
	#bmon_group{
		no = 4164,
		name = <<"镇妖塔164层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,74881.459},
		mon_pool_fixed = [{10305,1},{10026,2},{10026,3},{10028,4},{10028,5},{10032,6},{10032,7},{10032,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4165) ->
	#bmon_group{
		no = 4165,
		name = <<"镇妖塔165层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,75205.621},
		mon_pool_fixed = [{10306,1},{10027,2},{10027,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4166) ->
	#bmon_group{
		no = 4166,
		name = <<"镇妖塔166层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,75529.783},
		mon_pool_fixed = [{10101,1},{10028,2},{10028,3},{10030,4},{10030,5},{10034,6},{10034,7},{10034,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4167) ->
	#bmon_group{
		no = 4167,
		name = <<"镇妖塔167层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,75853.945},
		mon_pool_fixed = [{10102,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4168) ->
	#bmon_group{
		no = 4168,
		name = <<"镇妖塔168层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,76178.108},
		mon_pool_fixed = [{10103,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4169) ->
	#bmon_group{
		no = 4169,
		name = <<"镇妖塔169层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,76502.27},
		mon_pool_fixed = [{10104,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4170) ->
	#bmon_group{
		no = 4170,
		name = <<"镇妖塔170层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,76826.432},
		mon_pool_fixed = [{10105,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4171) ->
	#bmon_group{
		no = 4171,
		name = <<"镇妖塔171层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,77150.594},
		mon_pool_fixed = [{10106,1},{10036,2},{10036,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10034,9},{10034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4172) ->
	#bmon_group{
		no = 4172,
		name = <<"镇妖塔172层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,77474.756},
		mon_pool_fixed = [{10107,1},{10035,2},{10035,3},{10035,4},{10035,5},{10034,6},{10034,7},{10034,8},{10033,9},{10033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4173) ->
	#bmon_group{
		no = 4173,
		name = <<"镇妖塔173层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,77798.918},
		mon_pool_fixed = [{10108,1},{10034,2},{10034,3},{10034,4},{10034,5},{10033,6},{10033,7},{10033,8},{10032,9},{10032,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4174) ->
	#bmon_group{
		no = 4174,
		name = <<"镇妖塔174层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,78123.081},
		mon_pool_fixed = [{10109,1},{10033,2},{10033,3},{10033,4},{10033,5},{10032,6},{10032,7},{10032,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4175) ->
	#bmon_group{
		no = 4175,
		name = <<"镇妖塔175层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,78447.243},
		mon_pool_fixed = [{10110,1},{10032,2},{10032,3},{10032,4},{10032,5},{10031,6},{10031,7},{10031,8},{10030,9},{10030,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4176) ->
	#bmon_group{
		no = 4176,
		name = <<"镇妖塔176层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,78771.405},
		mon_pool_fixed = [{10111,1},{10031,2},{10031,3},{10031,4},{10031,5},{10030,6},{10030,7},{10030,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4177) ->
	#bmon_group{
		no = 4177,
		name = <<"镇妖塔177层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,79095.567},
		mon_pool_fixed = [{10112,1},{10030,2},{10030,3},{10030,4},{10030,5},{10029,6},{10029,7},{10029,8},{10028,9},{10028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4178) ->
	#bmon_group{
		no = 4178,
		name = <<"镇妖塔178层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,79419.729},
		mon_pool_fixed = [{10113,1},{10029,2},{10029,3},{10029,4},{10029,5},{10028,6},{10028,7},{10028,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4179) ->
	#bmon_group{
		no = 4179,
		name = <<"镇妖塔179层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,79743.891},
		mon_pool_fixed = [{10201,1},{10028,2},{10028,3},{10028,4},{10028,5},{10027,6},{10027,7},{10027,8},{10026,9},{10026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4180) ->
	#bmon_group{
		no = 4180,
		name = <<"镇妖塔180层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,80068.054},
		mon_pool_fixed = [{10202,1},{10027,2},{10027,3},{10027,4},{10027,5},{10026,6},{10026,7},{10026,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4181) ->
	#bmon_group{
		no = 4181,
		name = <<"镇妖塔181层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,80392.216},
		mon_pool_fixed = [{10203,1},{10026,2},{10026,3},{10026,4},{10026,5},{10025,6},{10025,7},{10025,8},{10024,9},{10024,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4182) ->
	#bmon_group{
		no = 4182,
		name = <<"镇妖塔182层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,80716.378},
		mon_pool_fixed = [{10204,1},{10025,2},{10025,3},{10025,4},{10025,5},{10024,6},{10024,7},{10024,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4183) ->
	#bmon_group{
		no = 4183,
		name = <<"镇妖塔183层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,81040.54},
		mon_pool_fixed = [{10205,1},{10024,2},{10024,3},{10024,4},{10024,5},{10023,6},{10023,7},{10023,8},{10022,9},{10022,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4184) ->
	#bmon_group{
		no = 4184,
		name = <<"镇妖塔184层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,81364.702},
		mon_pool_fixed = [{10206,1},{10023,2},{10023,3},{10023,4},{10023,5},{10022,6},{10022,7},{10022,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4185) ->
	#bmon_group{
		no = 4185,
		name = <<"镇妖塔185层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,81688.864},
		mon_pool_fixed = [{10207,1},{10022,2},{10022,3},{10022,4},{10022,5},{10021,6},{10021,7},{10021,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4186) ->
	#bmon_group{
		no = 4186,
		name = <<"镇妖塔186层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,82013.026},
		mon_pool_fixed = [{10208,1},{10021,2},{10021,3},{10021,4},{10021,5},{10020,6},{10020,7},{10020,8},{10019,9},{10019,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4187) ->
	#bmon_group{
		no = 4187,
		name = <<"镇妖塔187层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,82337.189},
		mon_pool_fixed = [{10209,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4188) ->
	#bmon_group{
		no = 4188,
		name = <<"镇妖塔188层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,82661.351},
		mon_pool_fixed = [{10210,1},{10019,2},{10019,3},{10019,4},{10019,5},{10018,6},{10018,7},{10018,8},{10017,9},{10017,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4189) ->
	#bmon_group{
		no = 4189,
		name = <<"镇妖塔189层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,82985.513},
		mon_pool_fixed = [{10211,1},{10018,2},{10018,3},{10018,4},{10018,5},{10017,6},{10017,7},{10017,8},{10016,9},{10016,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4190) ->
	#bmon_group{
		no = 4190,
		name = <<"镇妖塔190层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,83309.675},
		mon_pool_fixed = [{10212,1},{10017,2},{10017,3},{10017,4},{10017,5},{10016,6},{10016,7},{10016,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4191) ->
	#bmon_group{
		no = 4191,
		name = <<"镇妖塔191层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,83633.837},
		mon_pool_fixed = [{10213,1},{10016,2},{10016,3},{10016,4},{10016,5},{10015,6},{10015,7},{10015,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4192) ->
	#bmon_group{
		no = 4192,
		name = <<"镇妖塔192层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,83957.999},
		mon_pool_fixed = [{10214,1},{10015,2},{10015,3},{10015,4},{10015,5},{10014,6},{10014,7},{10014,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4193) ->
	#bmon_group{
		no = 4193,
		name = <<"镇妖塔193层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,84282.162},
		mon_pool_fixed = [{10301,1},{10014,2},{10014,3},{10014,4},{10014,5},{10013,6},{10013,7},{10013,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4194) ->
	#bmon_group{
		no = 4194,
		name = <<"镇妖塔194层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,84606.324},
		mon_pool_fixed = [{10302,1},{10013,2},{10013,3},{10013,4},{10013,5},{10012,6},{10012,7},{10012,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4195) ->
	#bmon_group{
		no = 4195,
		name = <<"镇妖塔195层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,84930.486},
		mon_pool_fixed = [{10303,1},{10012,2},{10012,3},{10012,4},{10012,5},{10011,6},{10011,7},{10011,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4196) ->
	#bmon_group{
		no = 4196,
		name = <<"镇妖塔196层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,85254.648},
		mon_pool_fixed = [{10304,1},{10011,2},{10011,3},{10011,4},{10011,5},{10010,6},{10010,7},{10010,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4197) ->
	#bmon_group{
		no = 4197,
		name = <<"镇妖塔197层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,85578.81},
		mon_pool_fixed = [{10305,1},{10010,2},{10010,3},{10010,4},{10010,5},{10009,6},{10009,7},{10009,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4198) ->
	#bmon_group{
		no = 4198,
		name = <<"镇妖塔198层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,85902.972},
		mon_pool_fixed = [{10306,1},{10009,2},{10009,3},{10009,4},{10009,5},{10008,6},{10008,7},{10008,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4199) ->
	#bmon_group{
		no = 4199,
		name = <<"镇妖塔199层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,86227.135},
		mon_pool_fixed = [{10101,1},{10008,2},{10008,3},{10008,4},{10008,5},{10007,6},{10007,7},{10007,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4200) ->
	#bmon_group{
		no = 4200,
		name = <<"镇妖塔200层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,86551.297},
		mon_pool_fixed = [{10102,1},{10007,2},{10007,3},{10007,4},{10007,5},{10006,6},{10006,7},{10006,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4201) ->
	#bmon_group{
		no = 4201,
		name = <<"镇妖塔201层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,86875.459},
		mon_pool_fixed = [{10103,1},{10006,2},{10006,3},{10006,4},{10006,5},{10005,6},{10005,7},{10005,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4202) ->
	#bmon_group{
		no = 4202,
		name = <<"镇妖塔202层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,87199.621},
		mon_pool_fixed = [{10104,1},{10005,2},{10005,3},{10005,4},{10005,5},{10004,6},{10004,7},{10004,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4203) ->
	#bmon_group{
		no = 4203,
		name = <<"镇妖塔203层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,87523.783},
		mon_pool_fixed = [{10105,1},{10004,2},{10004,3},{10004,4},{10004,5},{10003,6},{10003,7},{10003,8},{10002,9},{10002,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4204) ->
	#bmon_group{
		no = 4204,
		name = <<"镇妖塔204层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,87847.945},
		mon_pool_fixed = [{10106,1},{10003,2},{10003,3},{10003,4},{10003,5},{10002,6},{10002,7},{10002,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4205) ->
	#bmon_group{
		no = 4205,
		name = <<"镇妖塔205层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,88172.108},
		mon_pool_fixed = [{10107,1},{10021,2},{10021,3},{10023,4},{10023,5},{10027,6},{10027,7},{10027,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4206) ->
	#bmon_group{
		no = 4206,
		name = <<"镇妖塔206层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,88496.27},
		mon_pool_fixed = [{10108,1},{10022,2},{10022,3},{10024,4},{10024,5},{10028,6},{10028,7},{10028,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4207) ->
	#bmon_group{
		no = 4207,
		name = <<"镇妖塔207层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,88820.432},
		mon_pool_fixed = [{10109,1},{10023,2},{10023,3},{10025,4},{10025,5},{10029,6},{10029,7},{10029,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4208) ->
	#bmon_group{
		no = 4208,
		name = <<"镇妖塔208层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,89144.594},
		mon_pool_fixed = [{10110,1},{10024,2},{10024,3},{10026,4},{10026,5},{10030,6},{10030,7},{10030,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4209) ->
	#bmon_group{
		no = 4209,
		name = <<"镇妖塔209层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,89468.756},
		mon_pool_fixed = [{10111,1},{10025,2},{10025,3},{10027,4},{10027,5},{10031,6},{10031,7},{10031,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4210) ->
	#bmon_group{
		no = 4210,
		name = <<"镇妖塔210层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,89792.918},
		mon_pool_fixed = [{10112,1},{10026,2},{10026,3},{10028,4},{10028,5},{10032,6},{10032,7},{10032,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4211) ->
	#bmon_group{
		no = 4211,
		name = <<"镇妖塔211层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,90117.08},
		mon_pool_fixed = [{10113,1},{10027,2},{10027,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4212) ->
	#bmon_group{
		no = 4212,
		name = <<"镇妖塔212层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,90441.243},
		mon_pool_fixed = [{10201,1},{10028,2},{10028,3},{10030,4},{10030,5},{10034,6},{10034,7},{10034,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4213) ->
	#bmon_group{
		no = 4213,
		name = <<"镇妖塔213层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,90765.405},
		mon_pool_fixed = [{10202,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4214) ->
	#bmon_group{
		no = 4214,
		name = <<"镇妖塔214层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,91089.567},
		mon_pool_fixed = [{10203,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4215) ->
	#bmon_group{
		no = 4215,
		name = <<"镇妖塔215层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,91413.729},
		mon_pool_fixed = [{10204,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4216) ->
	#bmon_group{
		no = 4216,
		name = <<"镇妖塔216层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,91737.891},
		mon_pool_fixed = [{10205,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4217) ->
	#bmon_group{
		no = 4217,
		name = <<"镇妖塔217层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,92062.053},
		mon_pool_fixed = [{10206,1},{10036,2},{10036,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10034,9},{10034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4218) ->
	#bmon_group{
		no = 4218,
		name = <<"镇妖塔218层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,92386.216},
		mon_pool_fixed = [{10207,1},{10035,2},{10035,3},{10035,4},{10035,5},{10034,6},{10034,7},{10034,8},{10033,9},{10033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4219) ->
	#bmon_group{
		no = 4219,
		name = <<"镇妖塔219层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,92710.378},
		mon_pool_fixed = [{10208,1},{10034,2},{10034,3},{10034,4},{10034,5},{10033,6},{10033,7},{10033,8},{10032,9},{10032,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4220) ->
	#bmon_group{
		no = 4220,
		name = <<"镇妖塔220层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,93034.54},
		mon_pool_fixed = [{10209,1},{10033,2},{10033,3},{10033,4},{10033,5},{10032,6},{10032,7},{10032,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4221) ->
	#bmon_group{
		no = 4221,
		name = <<"镇妖塔221层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,93358.702},
		mon_pool_fixed = [{10210,1},{10032,2},{10032,3},{10032,4},{10032,5},{10031,6},{10031,7},{10031,8},{10030,9},{10030,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4222) ->
	#bmon_group{
		no = 4222,
		name = <<"镇妖塔222层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,93682.864},
		mon_pool_fixed = [{10211,1},{10031,2},{10031,3},{10031,4},{10031,5},{10030,6},{10030,7},{10030,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4223) ->
	#bmon_group{
		no = 4223,
		name = <<"镇妖塔223层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,94007.026},
		mon_pool_fixed = [{10212,1},{10030,2},{10030,3},{10030,4},{10030,5},{10029,6},{10029,7},{10029,8},{10028,9},{10028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4224) ->
	#bmon_group{
		no = 4224,
		name = <<"镇妖塔224层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,94331.189},
		mon_pool_fixed = [{10213,1},{10029,2},{10029,3},{10029,4},{10029,5},{10028,6},{10028,7},{10028,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4225) ->
	#bmon_group{
		no = 4225,
		name = <<"镇妖塔225层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,94655.351},
		mon_pool_fixed = [{10214,1},{10028,2},{10028,3},{10028,4},{10028,5},{10027,6},{10027,7},{10027,8},{10026,9},{10026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4226) ->
	#bmon_group{
		no = 4226,
		name = <<"镇妖塔226层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,94979.513},
		mon_pool_fixed = [{10301,1},{10027,2},{10027,3},{10027,4},{10027,5},{10026,6},{10026,7},{10026,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4227) ->
	#bmon_group{
		no = 4227,
		name = <<"镇妖塔227层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,95303.675},
		mon_pool_fixed = [{10302,1},{10026,2},{10026,3},{10026,4},{10026,5},{10025,6},{10025,7},{10025,8},{10024,9},{10024,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4228) ->
	#bmon_group{
		no = 4228,
		name = <<"镇妖塔228层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,95627.837},
		mon_pool_fixed = [{10303,1},{10025,2},{10025,3},{10025,4},{10025,5},{10024,6},{10024,7},{10024,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4229) ->
	#bmon_group{
		no = 4229,
		name = <<"镇妖塔229层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,95951.999},
		mon_pool_fixed = [{10304,1},{10024,2},{10024,3},{10024,4},{10024,5},{10023,6},{10023,7},{10023,8},{10022,9},{10022,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4230) ->
	#bmon_group{
		no = 4230,
		name = <<"镇妖塔230层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,96276.162},
		mon_pool_fixed = [{10305,1},{10023,2},{10023,3},{10023,4},{10023,5},{10022,6},{10022,7},{10022,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4231) ->
	#bmon_group{
		no = 4231,
		name = <<"镇妖塔231层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,96600.324},
		mon_pool_fixed = [{10306,1},{10022,2},{10022,3},{10022,4},{10022,5},{10021,6},{10021,7},{10021,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4232) ->
	#bmon_group{
		no = 4232,
		name = <<"镇妖塔232层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,96924.486},
		mon_pool_fixed = [{10101,1},{10021,2},{10021,3},{10021,4},{10021,5},{10020,6},{10020,7},{10020,8},{10019,9},{10019,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4233) ->
	#bmon_group{
		no = 4233,
		name = <<"镇妖塔233层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,97248.648},
		mon_pool_fixed = [{10102,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4234) ->
	#bmon_group{
		no = 4234,
		name = <<"镇妖塔234层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,97572.81},
		mon_pool_fixed = [{10103,1},{10019,2},{10019,3},{10019,4},{10019,5},{10018,6},{10018,7},{10018,8},{10017,9},{10017,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4235) ->
	#bmon_group{
		no = 4235,
		name = <<"镇妖塔235层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,97896.972},
		mon_pool_fixed = [{10104,1},{10018,2},{10018,3},{10018,4},{10018,5},{10017,6},{10017,7},{10017,8},{10016,9},{10016,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4236) ->
	#bmon_group{
		no = 4236,
		name = <<"镇妖塔236层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,98221.134},
		mon_pool_fixed = [{10105,1},{10017,2},{10017,3},{10017,4},{10017,5},{10016,6},{10016,7},{10016,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4237) ->
	#bmon_group{
		no = 4237,
		name = <<"镇妖塔237层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,98545.297},
		mon_pool_fixed = [{10106,1},{10016,2},{10016,3},{10016,4},{10016,5},{10015,6},{10015,7},{10015,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4238) ->
	#bmon_group{
		no = 4238,
		name = <<"镇妖塔238层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,98869.459},
		mon_pool_fixed = [{10107,1},{10015,2},{10015,3},{10015,4},{10015,5},{10014,6},{10014,7},{10014,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4239) ->
	#bmon_group{
		no = 4239,
		name = <<"镇妖塔239层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,99193.621},
		mon_pool_fixed = [{10108,1},{10014,2},{10014,3},{10014,4},{10014,5},{10013,6},{10013,7},{10013,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4240) ->
	#bmon_group{
		no = 4240,
		name = <<"镇妖塔240层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,99517.783},
		mon_pool_fixed = [{10109,1},{10013,2},{10013,3},{10013,4},{10013,5},{10012,6},{10012,7},{10012,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4241) ->
	#bmon_group{
		no = 4241,
		name = <<"镇妖塔241层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,99841.945},
		mon_pool_fixed = [{10110,1},{10012,2},{10012,3},{10012,4},{10012,5},{10011,6},{10011,7},{10011,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4242) ->
	#bmon_group{
		no = 4242,
		name = <<"镇妖塔242层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,100166.107},
		mon_pool_fixed = [{10111,1},{10011,2},{10011,3},{10011,4},{10011,5},{10010,6},{10010,7},{10010,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4243) ->
	#bmon_group{
		no = 4243,
		name = <<"镇妖塔243层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,100490.27},
		mon_pool_fixed = [{10112,1},{10010,2},{10010,3},{10010,4},{10010,5},{10009,6},{10009,7},{10009,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4244) ->
	#bmon_group{
		no = 4244,
		name = <<"镇妖塔244层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,100814.432},
		mon_pool_fixed = [{10113,1},{10009,2},{10009,3},{10009,4},{10009,5},{10008,6},{10008,7},{10008,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4245) ->
	#bmon_group{
		no = 4245,
		name = <<"镇妖塔245层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,101138.594},
		mon_pool_fixed = [{10201,1},{10008,2},{10008,3},{10008,4},{10008,5},{10007,6},{10007,7},{10007,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4246) ->
	#bmon_group{
		no = 4246,
		name = <<"镇妖塔246层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,101462.756},
		mon_pool_fixed = [{10202,1},{10007,2},{10007,3},{10007,4},{10007,5},{10006,6},{10006,7},{10006,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4247) ->
	#bmon_group{
		no = 4247,
		name = <<"镇妖塔247层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,101786.918},
		mon_pool_fixed = [{10203,1},{10006,2},{10006,3},{10006,4},{10006,5},{10005,6},{10005,7},{10005,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4248) ->
	#bmon_group{
		no = 4248,
		name = <<"镇妖塔248层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,102111.08},
		mon_pool_fixed = [{10204,1},{10005,2},{10005,3},{10005,4},{10005,5},{10004,6},{10004,7},{10004,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4249) ->
	#bmon_group{
		no = 4249,
		name = <<"镇妖塔249层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,102435.243},
		mon_pool_fixed = [{10205,1},{10004,2},{10004,3},{10004,4},{10004,5},{10003,6},{10003,7},{10003,8},{10002,9},{10002,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4250) ->
	#bmon_group{
		no = 4250,
		name = <<"镇妖塔250层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,102759.405},
		mon_pool_fixed = [{10206,1},{10003,2},{10003,3},{10003,4},{10003,5},{10002,6},{10002,7},{10002,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4251) ->
	#bmon_group{
		no = 4251,
		name = <<"镇妖塔251层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,103083.567},
		mon_pool_fixed = [{10207,1},{10021,2},{10021,3},{10023,4},{10023,5},{10027,6},{10027,7},{10027,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4252) ->
	#bmon_group{
		no = 4252,
		name = <<"镇妖塔252层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,103407.729},
		mon_pool_fixed = [{10208,1},{10022,2},{10022,3},{10024,4},{10024,5},{10028,6},{10028,7},{10028,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4253) ->
	#bmon_group{
		no = 4253,
		name = <<"镇妖塔253层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,103731.891},
		mon_pool_fixed = [{10209,1},{10023,2},{10023,3},{10025,4},{10025,5},{10029,6},{10029,7},{10029,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4254) ->
	#bmon_group{
		no = 4254,
		name = <<"镇妖塔254层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,104056.053},
		mon_pool_fixed = [{10210,1},{10024,2},{10024,3},{10026,4},{10026,5},{10030,6},{10030,7},{10030,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4255) ->
	#bmon_group{
		no = 4255,
		name = <<"镇妖塔255层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,104380.216},
		mon_pool_fixed = [{10211,1},{10025,2},{10025,3},{10027,4},{10027,5},{10031,6},{10031,7},{10031,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4256) ->
	#bmon_group{
		no = 4256,
		name = <<"镇妖塔256层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,104704.378},
		mon_pool_fixed = [{10212,1},{10026,2},{10026,3},{10028,4},{10028,5},{10032,6},{10032,7},{10032,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4257) ->
	#bmon_group{
		no = 4257,
		name = <<"镇妖塔257层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,105028.54},
		mon_pool_fixed = [{10213,1},{10027,2},{10027,3},{10029,4},{10029,5},{10033,6},{10033,7},{10033,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4258) ->
	#bmon_group{
		no = 4258,
		name = <<"镇妖塔258层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,105352.702},
		mon_pool_fixed = [{10214,1},{10028,2},{10028,3},{10030,4},{10030,5},{10034,6},{10034,7},{10034,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4259) ->
	#bmon_group{
		no = 4259,
		name = <<"镇妖塔259层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,105676.864},
		mon_pool_fixed = [{10301,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4260) ->
	#bmon_group{
		no = 4260,
		name = <<"镇妖塔260层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,106001.026},
		mon_pool_fixed = [{10302,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4261) ->
	#bmon_group{
		no = 4261,
		name = <<"镇妖塔261层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,106325.188},
		mon_pool_fixed = [{10303,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4262) ->
	#bmon_group{
		no = 4262,
		name = <<"镇妖塔262层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,106649.351},
		mon_pool_fixed = [{10304,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4263) ->
	#bmon_group{
		no = 4263,
		name = <<"镇妖塔263层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,106973.513},
		mon_pool_fixed = [{10305,1},{10036,2},{10036,3},{10036,4},{10036,5},{10035,6},{10035,7},{10035,8},{10034,9},{10034,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4264) ->
	#bmon_group{
		no = 4264,
		name = <<"镇妖塔264层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,107297.675},
		mon_pool_fixed = [{10306,1},{10035,2},{10035,3},{10035,4},{10035,5},{10034,6},{10034,7},{10034,8},{10033,9},{10033,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4265) ->
	#bmon_group{
		no = 4265,
		name = <<"镇妖塔265层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,107621.837},
		mon_pool_fixed = [{10101,1},{10034,2},{10034,3},{10034,4},{10034,5},{10033,6},{10033,7},{10033,8},{10032,9},{10032,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4266) ->
	#bmon_group{
		no = 4266,
		name = <<"镇妖塔266层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,107945.999},
		mon_pool_fixed = [{10102,1},{10033,2},{10033,3},{10033,4},{10033,5},{10032,6},{10032,7},{10032,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4267) ->
	#bmon_group{
		no = 4267,
		name = <<"镇妖塔267层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,108270.161},
		mon_pool_fixed = [{10103,1},{10032,2},{10032,3},{10032,4},{10032,5},{10031,6},{10031,7},{10031,8},{10030,9},{10030,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4268) ->
	#bmon_group{
		no = 4268,
		name = <<"镇妖塔268层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,108594.324},
		mon_pool_fixed = [{10104,1},{10031,2},{10031,3},{10031,4},{10031,5},{10030,6},{10030,7},{10030,8},{10029,9},{10029,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4269) ->
	#bmon_group{
		no = 4269,
		name = <<"镇妖塔269层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,108918.486},
		mon_pool_fixed = [{10105,1},{10030,2},{10030,3},{10030,4},{10030,5},{10029,6},{10029,7},{10029,8},{10028,9},{10028,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4270) ->
	#bmon_group{
		no = 4270,
		name = <<"镇妖塔270层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,109242.648},
		mon_pool_fixed = [{10106,1},{10029,2},{10029,3},{10029,4},{10029,5},{10028,6},{10028,7},{10028,8},{10027,9},{10027,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4271) ->
	#bmon_group{
		no = 4271,
		name = <<"镇妖塔271层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,109566.81},
		mon_pool_fixed = [{10107,1},{10028,2},{10028,3},{10028,4},{10028,5},{10027,6},{10027,7},{10027,8},{10026,9},{10026,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4272) ->
	#bmon_group{
		no = 4272,
		name = <<"镇妖塔272层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,109890.972},
		mon_pool_fixed = [{10108,1},{10027,2},{10027,3},{10027,4},{10027,5},{10026,6},{10026,7},{10026,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4273) ->
	#bmon_group{
		no = 4273,
		name = <<"镇妖塔273层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,110215.134},
		mon_pool_fixed = [{10109,1},{10026,2},{10026,3},{10026,4},{10026,5},{10025,6},{10025,7},{10025,8},{10024,9},{10024,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4274) ->
	#bmon_group{
		no = 4274,
		name = <<"镇妖塔274层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,110539.297},
		mon_pool_fixed = [{10110,1},{10025,2},{10025,3},{10025,4},{10025,5},{10024,6},{10024,7},{10024,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4275) ->
	#bmon_group{
		no = 4275,
		name = <<"镇妖塔275层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,110863.459},
		mon_pool_fixed = [{10111,1},{10024,2},{10024,3},{10024,4},{10024,5},{10023,6},{10023,7},{10023,8},{10022,9},{10022,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4276) ->
	#bmon_group{
		no = 4276,
		name = <<"镇妖塔276层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,111187.621},
		mon_pool_fixed = [{10112,1},{10023,2},{10023,3},{10023,4},{10023,5},{10022,6},{10022,7},{10022,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4277) ->
	#bmon_group{
		no = 4277,
		name = <<"镇妖塔277层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,111511.783},
		mon_pool_fixed = [{10113,1},{10022,2},{10022,3},{10022,4},{10022,5},{10021,6},{10021,7},{10021,8},{10020,9},{10020,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4278) ->
	#bmon_group{
		no = 4278,
		name = <<"镇妖塔278层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,111835.945},
		mon_pool_fixed = [{10201,1},{10021,2},{10021,3},{10021,4},{10021,5},{10020,6},{10020,7},{10020,8},{10019,9},{10019,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4279) ->
	#bmon_group{
		no = 4279,
		name = <<"镇妖塔279层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,112160.107},
		mon_pool_fixed = [{10202,1},{10020,2},{10020,3},{10020,4},{10020,5},{10019,6},{10019,7},{10019,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4280) ->
	#bmon_group{
		no = 4280,
		name = <<"镇妖塔280层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,112484.27},
		mon_pool_fixed = [{10203,1},{10019,2},{10019,3},{10019,4},{10019,5},{10018,6},{10018,7},{10018,8},{10017,9},{10017,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4281) ->
	#bmon_group{
		no = 4281,
		name = <<"镇妖塔281层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,112808.432},
		mon_pool_fixed = [{10204,1},{10018,2},{10018,3},{10018,4},{10018,5},{10017,6},{10017,7},{10017,8},{10016,9},{10016,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4282) ->
	#bmon_group{
		no = 4282,
		name = <<"镇妖塔282层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,113132.594},
		mon_pool_fixed = [{10205,1},{10017,2},{10017,3},{10017,4},{10017,5},{10016,6},{10016,7},{10016,8},{10015,9},{10015,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4283) ->
	#bmon_group{
		no = 4283,
		name = <<"镇妖塔283层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,113456.756},
		mon_pool_fixed = [{10206,1},{10016,2},{10016,3},{10016,4},{10016,5},{10015,6},{10015,7},{10015,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4284) ->
	#bmon_group{
		no = 4284,
		name = <<"镇妖塔284层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,113780.918},
		mon_pool_fixed = [{10207,1},{10015,2},{10015,3},{10015,4},{10015,5},{10014,6},{10014,7},{10014,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4285) ->
	#bmon_group{
		no = 4285,
		name = <<"镇妖塔285层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,114105.08},
		mon_pool_fixed = [{10208,1},{10014,2},{10014,3},{10014,4},{10014,5},{10013,6},{10013,7},{10013,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4286) ->
	#bmon_group{
		no = 4286,
		name = <<"镇妖塔286层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,114429.242},
		mon_pool_fixed = [{10209,1},{10013,2},{10013,3},{10013,4},{10013,5},{10012,6},{10012,7},{10012,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4287) ->
	#bmon_group{
		no = 4287,
		name = <<"镇妖塔287层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,114753.405},
		mon_pool_fixed = [{10210,1},{10012,2},{10012,3},{10012,4},{10012,5},{10011,6},{10011,7},{10011,8},{10010,9},{10010,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4288) ->
	#bmon_group{
		no = 4288,
		name = <<"镇妖塔288层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,115077.567},
		mon_pool_fixed = [{10211,1},{10011,2},{10011,3},{10011,4},{10011,5},{10010,6},{10010,7},{10010,8},{10009,9},{10009,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4289) ->
	#bmon_group{
		no = 4289,
		name = <<"镇妖塔289层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,115401.729},
		mon_pool_fixed = [{10212,1},{10010,2},{10010,3},{10010,4},{10010,5},{10009,6},{10009,7},{10009,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4290) ->
	#bmon_group{
		no = 4290,
		name = <<"镇妖塔290层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,115725.891},
		mon_pool_fixed = [{10213,1},{10009,2},{10009,3},{10009,4},{10009,5},{10008,6},{10008,7},{10008,8},{10007,9},{10007,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4291) ->
	#bmon_group{
		no = 4291,
		name = <<"镇妖塔291层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,116050.053},
		mon_pool_fixed = [{10214,1},{10008,2},{10008,3},{10008,4},{10008,5},{10007,6},{10007,7},{10007,8},{10006,9},{10006,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4292) ->
	#bmon_group{
		no = 4292,
		name = <<"镇妖塔292层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,116374.215},
		mon_pool_fixed = [{10301,1},{10007,2},{10007,3},{10007,4},{10007,5},{10006,6},{10006,7},{10006,8},{10005,9},{10005,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4293) ->
	#bmon_group{
		no = 4293,
		name = <<"镇妖塔293层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,116698.378},
		mon_pool_fixed = [{10302,1},{10006,2},{10006,3},{10006,4},{10006,5},{10005,6},{10005,7},{10005,8},{10004,9},{10004,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4294) ->
	#bmon_group{
		no = 4294,
		name = <<"镇妖塔294层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,117022.54},
		mon_pool_fixed = [{10303,1},{10005,2},{10005,3},{10005,4},{10005,5},{10004,6},{10004,7},{10004,8},{10003,9},{10003,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4295) ->
	#bmon_group{
		no = 4295,
		name = <<"镇妖塔295层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,117346.702},
		mon_pool_fixed = [{10304,1},{10004,2},{10004,3},{10004,4},{10004,5},{10003,6},{10003,7},{10003,8},{10002,9},{10002,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4296) ->
	#bmon_group{
		no = 4296,
		name = <<"镇妖塔296层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,117670.864},
		mon_pool_fixed = [{10305,1},{10003,2},{10003,3},{10003,4},{10003,5},{10002,6},{10002,7},{10002,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4297) ->
	#bmon_group{
		no = 4297,
		name = <<"镇妖塔297层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,117995.026},
		mon_pool_fixed = [{10306,1},{10029,2},{10029,3},{10031,4},{10031,5},{10035,6},{10035,7},{10035,8},{10012,9},{10012,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4298) ->
	#bmon_group{
		no = 4298,
		name = <<"镇妖塔298层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,118319.188},
		mon_pool_fixed = [{10302,1},{10030,2},{10030,3},{10032,4},{10032,5},{10036,6},{10036,7},{10036,8},{10013,9},{10013,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4299) ->
	#bmon_group{
		no = 4299,
		name = <<"镇妖塔299层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,118643.351},
		mon_pool_fixed = [{10304,1},{10031,2},{10031,3},{10033,4},{10033,5},{10037,6},{10037,7},{10037,8},{10014,9},{10014,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4300) ->
	#bmon_group{
		no = 4300,
		name = <<"镇妖塔300层怪物组">>,
		lv_range_min = 1,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = {fixed,118967.513},
		mon_pool_fixed = [{10301,1},{10037,2},{10037,3},{10037,4},{10037,5},{10036,6},{10036,7},{10036,8},{10035,9},{10035,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4501) ->
	#bmon_group{
		no = 4501,
		name = <<"普通装备副本怪物组">>,
		lv_range_min = 100,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.400000,
		mon_pool_fixed = [{30001,1},{10028,2},{10030,3},{10017,4},{10017,5},{10018,6},{10018,7},{10018,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4502) ->
	#bmon_group{
		no = 4502,
		name = <<"普通装备副本怪物组">>,
		lv_range_min = 100,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.470000,
		mon_pool_fixed = [{30002,1},{10037,2},{10037,3},{10036,4},{10036,5},{10021,6},{10021,7},{10021,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4503) ->
	#bmon_group{
		no = 4503,
		name = <<"普通装备副本怪物组">>,
		lv_range_min = 100,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.550000,
		mon_pool_fixed = [{30003,1},{10026,2},{10026,3},{10035,4},{10035,5},{10023,6},{10023,7},{10023,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4504) ->
	#bmon_group{
		no = 4504,
		name = <<"中等装备副本怪物组">>,
		lv_range_min = 150,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.720000,
		mon_pool_fixed = [{30004,1},{10028,2},{10030,3},{10017,4},{10017,5},{10018,6},{10018,7},{10018,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4505) ->
	#bmon_group{
		no = 4505,
		name = <<"中等装备副本怪物组">>,
		lv_range_min = 150,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.846000,
		mon_pool_fixed = [{30005,1},{10037,2},{10037,3},{10036,4},{10036,5},{10021,6},{10021,7},{10021,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4506) ->
	#bmon_group{
		no = 4506,
		name = <<"中等装备副本怪物组">>,
		lv_range_min = 150,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.990000,
		mon_pool_fixed = [{30006,1},{10026,2},{10026,3},{10035,4},{10035,5},{10023,6},{10023,7},{10023,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4507) ->
	#bmon_group{
		no = 4507,
		name = <<"困难装备副本怪物组">>,
		lv_range_min = 200,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.440000,
		mon_pool_fixed = [{30007,1},{10028,2},{10030,3},{10017,4},{10017,5},{10018,6},{10018,7},{10018,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4508) ->
	#bmon_group{
		no = 4508,
		name = <<"困难装备副本怪物组">>,
		lv_range_min = 200,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.692000,
		mon_pool_fixed = [{30008,1},{10037,2},{10037,3},{10036,4},{10036,5},{10021,6},{10021,7},{10021,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4509) ->
	#bmon_group{
		no = 4509,
		name = <<"困难装备副本怪物组">>,
		lv_range_min = 200,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.980000,
		mon_pool_fixed = [{30009,1},{10026,2},{10026,3},{10035,4},{10035,5},{10023,6},{10023,7},{10023,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4510) ->
	#bmon_group{
		no = 4510,
		name = <<"噩梦装备副本怪物组">>,
		lv_range_min = 250,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 3.168000,
		mon_pool_fixed = [{30010,1},{10028,2},{10030,3},{10017,4},{10017,5},{10018,6},{10018,7},{10018,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4511) ->
	#bmon_group{
		no = 4511,
		name = <<"噩梦装备副本怪物组">>,
		lv_range_min = 250,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 3.722000,
		mon_pool_fixed = [{30011,1},{10037,2},{10037,3},{10036,4},{10036,5},{10021,6},{10021,7},{10021,8},{10018,9},{10018,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4512) ->
	#bmon_group{
		no = 4512,
		name = <<"噩梦装备副本怪物组">>,
		lv_range_min = 250,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 4.356000,
		mon_pool_fixed = [{30012,1},{10026,2},{10026,3},{10035,4},{10035,5},{10023,6},{10023,7},{10023,8},{10021,9},{10021,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4521) ->
	#bmon_group{
		no = 4521,
		name = <<"普通宠物副本怪物组">>,
		lv_range_min = 100,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.400000,
		mon_pool_fixed = [{30021,1},{10013,2},{10013,3},{10008,4},{10008,5},{10025,6},{10031,7},{10031,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4522) ->
	#bmon_group{
		no = 4522,
		name = <<"普通宠物副本怪物组">>,
		lv_range_min = 100,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.470000,
		mon_pool_fixed = [{30022,1},{10022,2},{10022,3},{10024,4},{10024,5},{10026,6},{10035,7},{10035,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4523) ->
	#bmon_group{
		no = 4523,
		name = <<"普通宠物副本怪物组">>,
		lv_range_min = 100,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.550000,
		mon_pool_fixed = [{30023,1},{10009,2},{10009,3},{10009,4},{10009,5},{10011,6},{10003,7},{10003,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4524) ->
	#bmon_group{
		no = 4524,
		name = <<"中等宠物副本怪物组">>,
		lv_range_min = 150,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.720000,
		mon_pool_fixed = [{30024,1},{10013,2},{10013,3},{10008,4},{10008,5},{10025,6},{10031,7},{10031,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4525) ->
	#bmon_group{
		no = 4525,
		name = <<"中等宠物副本怪物组">>,
		lv_range_min = 150,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.846000,
		mon_pool_fixed = [{30025,1},{10022,2},{10022,3},{10024,4},{10024,5},{10026,6},{10035,7},{10035,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4526) ->
	#bmon_group{
		no = 4526,
		name = <<"中等宠物副本怪物组">>,
		lv_range_min = 150,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.990000,
		mon_pool_fixed = [{30026,1},{10009,2},{10009,3},{10009,4},{10009,5},{10011,6},{10003,7},{10003,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4527) ->
	#bmon_group{
		no = 4527,
		name = <<"困难宠物副本怪物组">>,
		lv_range_min = 200,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.296000,
		mon_pool_fixed = [{30027,1},{10013,2},{10013,3},{10008,4},{10008,5},{10025,6},{10031,7},{10031,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4528) ->
	#bmon_group{
		no = 4528,
		name = <<"困难宠物副本怪物组">>,
		lv_range_min = 200,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.523000,
		mon_pool_fixed = [{30028,1},{10022,2},{10022,3},{10024,4},{10024,5},{10026,6},{10035,7},{10035,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4529) ->
	#bmon_group{
		no = 4529,
		name = <<"困难宠物副本怪物组">>,
		lv_range_min = 200,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.782000,
		mon_pool_fixed = [{30029,1},{10009,2},{10009,3},{10009,4},{10009,5},{10011,6},{10003,7},{10003,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4530) ->
	#bmon_group{
		no = 4530,
		name = <<"噩梦宠物副本怪物组">>,
		lv_range_min = 250,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 2.592000,
		mon_pool_fixed = [{30030,1},{10013,2},{10013,3},{10008,4},{10008,5},{10025,6},{10031,7},{10031,8},{10031,9},{10031,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4531) ->
	#bmon_group{
		no = 4531,
		name = <<"噩梦宠物副本怪物组">>,
		lv_range_min = 250,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 3.046000,
		mon_pool_fixed = [{30031,1},{10022,2},{10022,3},{10024,4},{10024,5},{10026,6},{10035,7},{10035,8},{10001,9},{10001,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4532) ->
	#bmon_group{
		no = 4532,
		name = <<"噩梦宠物副本怪物组">>,
		lv_range_min = 250,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 3.564000,
		mon_pool_fixed = [{30032,1},{10009,2},{10009,3},{10009,4},{10009,5},{10011,6},{10003,7},{10003,8},{10008,9},{10008,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4541) ->
	#bmon_group{
		no = 4541,
		name = <<"普通翅膀副本怪物组">>,
		lv_range_min = 100,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.400000,
		mon_pool_fixed = [{30041,1},{10016,2},{10005,3},{10007,4},{10007,5},{10032,6},{10003,7},{10003,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4542) ->
	#bmon_group{
		no = 4542,
		name = <<"普通翅膀副本怪物组">>,
		lv_range_min = 100,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.470000,
		mon_pool_fixed = [{30042,1},{10009,2},{10009,3},{10008,4},{10008,5},{10025,6},{10011,7},{10011,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4543) ->
	#bmon_group{
		no = 4543,
		name = <<"普通翅膀副本怪物组">>,
		lv_range_min = 100,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.550000,
		mon_pool_fixed = [{30043,1},{10030,2},{10030,3},{10002,4},{10002,5},{10003,6},{10023,7},{10023,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4544) ->
	#bmon_group{
		no = 4544,
		name = <<"中等翅膀副本怪物组">>,
		lv_range_min = 150,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.720000,
		mon_pool_fixed = [{30044,1},{10016,2},{10005,3},{10007,4},{10007,5},{10032,6},{10003,7},{10003,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4545) ->
	#bmon_group{
		no = 4545,
		name = <<"中等翅膀副本怪物组">>,
		lv_range_min = 150,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.846000,
		mon_pool_fixed = [{30045,1},{10009,2},{10009,3},{10008,4},{10008,5},{10025,6},{10011,7},{10011,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4546) ->
	#bmon_group{
		no = 4546,
		name = <<"中等翅膀副本怪物组">>,
		lv_range_min = 150,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 0.990000,
		mon_pool_fixed = [{30046,1},{10030,2},{10030,3},{10002,4},{10002,5},{10003,6},{10023,7},{10023,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4547) ->
	#bmon_group{
		no = 4547,
		name = <<"困难翅膀副本怪物组">>,
		lv_range_min = 200,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.296000,
		mon_pool_fixed = [{30047,1},{10016,2},{10005,3},{10007,4},{10007,5},{10032,6},{10003,7},{10003,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4548) ->
	#bmon_group{
		no = 4548,
		name = <<"困难翅膀副本怪物组">>,
		lv_range_min = 200,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.523000,
		mon_pool_fixed = [{30048,1},{10009,2},{10009,3},{10008,4},{10008,5},{10025,6},{10011,7},{10011,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4549) ->
	#bmon_group{
		no = 4549,
		name = <<"困难翅膀副本怪物组">>,
		lv_range_min = 200,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 1.782000,
		mon_pool_fixed = [{30049,1},{10030,2},{10030,3},{10002,4},{10002,5},{10003,6},{10023,7},{10023,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4550) ->
	#bmon_group{
		no = 4550,
		name = <<"噩梦翅膀副本怪物组">>,
		lv_range_min = 250,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 2.592000,
		mon_pool_fixed = [{30050,1},{10016,2},{10005,3},{10007,4},{10007,5},{10032,6},{10003,7},{10003,8},{10025,9},{10025,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4551) ->
	#bmon_group{
		no = 4551,
		name = <<"噩梦翅膀副本怪物组">>,
		lv_range_min = 250,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 3.046000,
		mon_pool_fixed = [{30051,1},{10009,2},{10009,3},{10008,4},{10008,5},{10025,6},{10011,7},{10011,8},{10011,9},{10011,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(4552) ->
	#bmon_group{
		no = 4552,
		name = <<"噩梦翅膀副本怪物组">>,
		lv_range_min = 250,
		lv_range_max = 360,
		troop_no = 1,
		spawn_mon_type = 1,
		force_spawn_mon_count = 0,
		attr_random_range = 0,
		attr_streng = 3.564000,
		mon_pool_fixed = [{30052,1},{10030,2},{10030,3},{10002,4},{10002,5},{10003,6},{10023,7},{10023,8},{10023,9},{10023,10}],
		mon_pool_normal = [],
		mon_pool_chief = [],
		mon_pool_elite = [],
		mon_pool_rare = [],
		next_bmon_group_no = [],
		bt_plot_no = 0,
		is_hire_prohibited = 0,
		zf_no = 0
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

