%%%---------------------------------------
%%% @Module  : data_internal_skill
%%% @Author  : easy
%%% @Email   : 
%%% @Description: 内功基础表
%%%---------------------------------------


-module(data_internal_skill).
-export([
        get_no/0,
        get/1
    ]).

-include("train.hrl").
-include("debug.hrl").

get_no()->
	[100000,100001,100002,100003,100004,100005,100006,100007,100008,100009,100010,100011,100012,100013,100014,100015,100016,100017,100018,100019,100020,100021,100022,100023,100024,100025,100026,100027,100028,100029,100030,100031,100032,100033].

get(100000) ->
	#internal_skill_cfg{
		no = 100000,
		internal_skill_star = 1,
		internal_skill_type = [{hp_lim,94090,0}],
		lv_coef = 1
};

get(100001) ->
	#internal_skill_cfg{
		no = 100001,
		internal_skill_star = 1,
		internal_skill_type = [{act_speed,940,0}],
		lv_coef = 1
};

get(100002) ->
	#internal_skill_cfg{
		no = 100002,
		internal_skill_star = 2,
		internal_skill_type = [{phy_att,940,0}],
		lv_coef = 1
};

get(100003) ->
	#internal_skill_cfg{
		no = 100003,
		internal_skill_star = 2,
		internal_skill_type = [{phy_def,940,0}],
		lv_coef = 1
};

get(100004) ->
	#internal_skill_cfg{
		no = 100004,
		internal_skill_star = 2,
		internal_skill_type = [{mag_def,940,0}],
		lv_coef = 1
};

get(100005) ->
	#internal_skill_cfg{
		no = 100005,
		internal_skill_star = 2,
		internal_skill_type = [{phy_crit,0,0.05}],
		lv_coef = 1
};

get(100006) ->
	#internal_skill_cfg{
		no = 100006,
		internal_skill_star = 3,
		internal_skill_type = [{hp_lim,94090,0}],
		lv_coef = 1
};

get(100007) ->
	#internal_skill_cfg{
		no = 100007,
		internal_skill_star = 3,
		internal_skill_type = [{act_speed,940,0}],
		lv_coef = 1
};

get(100008) ->
	#internal_skill_cfg{
		no = 100008,
		internal_skill_star = 3,
		internal_skill_type = [{phy_att,940,0}],
		lv_coef = 1
};

get(100009) ->
	#internal_skill_cfg{
		no = 100009,
		internal_skill_star = 3,
		internal_skill_type = [{phy_def,940,0}],
		lv_coef = 1
};

get(100010) ->
	#internal_skill_cfg{
		no = 100010,
		internal_skill_star = 3,
		internal_skill_type = [{mag_def,940,0}],
		lv_coef = 1
};

get(100011) ->
	#internal_skill_cfg{
		no = 100011,
		internal_skill_star = 3,
		internal_skill_type = [{phy_crit,0,0.05}],
		lv_coef = 1
};

get(100012) ->
	#internal_skill_cfg{
		no = 100012,
		internal_skill_star = 3,
		internal_skill_type = [{hp_lim,94090,0}],
		lv_coef = 1
};

get(100013) ->
	#internal_skill_cfg{
		no = 100013,
		internal_skill_star = 3,
		internal_skill_type = [{act_speed,940,0}],
		lv_coef = 1
};

get(100014) ->
	#internal_skill_cfg{
		no = 100014,
		internal_skill_star = 3,
		internal_skill_type = [{phy_att,940,0}],
		lv_coef = 1
};

get(100015) ->
	#internal_skill_cfg{
		no = 100015,
		internal_skill_star = 3,
		internal_skill_type = [{phy_def,940,0}],
		lv_coef = 1
};

get(100016) ->
	#internal_skill_cfg{
		no = 100016,
		internal_skill_star = 3,
		internal_skill_type = [{mag_def,940,0}],
		lv_coef = 1
};

get(100017) ->
	#internal_skill_cfg{
		no = 100017,
		internal_skill_star = 3,
		internal_skill_type = [{phy_crit,0,0.05}],
		lv_coef = 1
};

get(100018) ->
	#internal_skill_cfg{
		no = 100018,
		internal_skill_star = 3,
		internal_skill_type = [{hp_lim,94090,0}],
		lv_coef = 1
};

get(100019) ->
	#internal_skill_cfg{
		no = 100019,
		internal_skill_star = 3,
		internal_skill_type = [{act_speed,940,0}],
		lv_coef = 1
};

get(100020) ->
	#internal_skill_cfg{
		no = 100020,
		internal_skill_star = 4,
		internal_skill_type = [{phy_att,940,0}],
		lv_coef = 1
};

get(100021) ->
	#internal_skill_cfg{
		no = 100021,
		internal_skill_star = 4,
		internal_skill_type = [{phy_def,940,0}],
		lv_coef = 1
};

get(100022) ->
	#internal_skill_cfg{
		no = 100022,
		internal_skill_star = 4,
		internal_skill_type = [{mag_def,940,0}],
		lv_coef = 1
};

get(100023) ->
	#internal_skill_cfg{
		no = 100023,
		internal_skill_star = 4,
		internal_skill_type = [{phy_crit,0,0.05}],
		lv_coef = 1
};

get(100024) ->
	#internal_skill_cfg{
		no = 100024,
		internal_skill_star = 4,
		internal_skill_type = [{hp_lim,94090,0}],
		lv_coef = 1
};

get(100025) ->
	#internal_skill_cfg{
		no = 100025,
		internal_skill_star = 4,
		internal_skill_type = [{act_speed,940,0}],
		lv_coef = 1
};

get(100026) ->
	#internal_skill_cfg{
		no = 100026,
		internal_skill_star = 5,
		internal_skill_type = [{phy_att,940,0}],
		lv_coef = 1
};

get(100027) ->
	#internal_skill_cfg{
		no = 100027,
		internal_skill_star = 5,
		internal_skill_type = [{phy_def,940,0}],
		lv_coef = 1
};

get(100028) ->
	#internal_skill_cfg{
		no = 100028,
		internal_skill_star = 5,
		internal_skill_type = [{mag_def,940,0}],
		lv_coef = 1
};

get(100029) ->
	#internal_skill_cfg{
		no = 100029,
		internal_skill_star = 5,
		internal_skill_type = [{phy_crit,0,0.05}],
		lv_coef = 1
};

get(100030) ->
	#internal_skill_cfg{
		no = 100030,
		internal_skill_star = 5,
		internal_skill_type = [{hp_lim,94090,0}],
		lv_coef = 1
};

get(100031) ->
	#internal_skill_cfg{
		no = 100031,
		internal_skill_star = 5,
		internal_skill_type = [{act_speed,940,0}],
		lv_coef = 1
};

get(100032) ->
	#internal_skill_cfg{
		no = 100032,
		internal_skill_star = 5,
		internal_skill_type = [{phy_att,940,0}],
		lv_coef = 1
};

get(100033) ->
	#internal_skill_cfg{
		no = 100033,
		internal_skill_star = 5,
		internal_skill_type = [{phy_def,940,0}],
		lv_coef = 1
};

get(_No) ->
	?ASSERT(false, _No),
    null.

