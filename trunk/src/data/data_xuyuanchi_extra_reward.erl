%%%---------------------------------------
%%% @Module  : data_xuyuanchi_extra_reward
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 许愿额外奖励表
%%%---------------------------------------


-module(data_xuyuanchi_extra_reward).
-compile(export_all).

-include("luck_info.hrl").
-include("debug.hrl").

get(1) ->
	#xuyuanchi_extra_reward{
		no = 1,
		xuyuan_num = 100,
		reward = [{55090,1,0,3}]
};

get(2) ->
	#xuyuanchi_extra_reward{
		no = 2,
		xuyuan_num = 100,
		reward = [{55096,1,0,3}]
};

get(3) ->
	#xuyuanchi_extra_reward{
		no = 3,
		xuyuan_num = 100,
		reward = [{55102,1,0,3}]
};

get(4) ->
	#xuyuanchi_extra_reward{
		no = 4,
		xuyuan_num = 100,
		reward = [{55108,1,0,3}]
};

get(5) ->
	#xuyuanchi_extra_reward{
		no = 5,
		xuyuan_num = 100,
		reward = [{55114,1,0,3}]
};

get(6) ->
	#xuyuanchi_extra_reward{
		no = 6,
		xuyuan_num = 500,
		reward = [{55264,1,0,3}]
};

get(7) ->
	#xuyuanchi_extra_reward{
		no = 7,
		xuyuan_num = 500,
		reward = [{55270,1,0,3}]
};

get(8) ->
	#xuyuanchi_extra_reward{
		no = 8,
		xuyuan_num = 500,
		reward = [{55276,1,0,3}]
};

get(9) ->
	#xuyuanchi_extra_reward{
		no = 9,
		xuyuan_num = 500,
		reward = [{55282,1,0,3}]
};

get(10) ->
	#xuyuanchi_extra_reward{
		no = 10,
		xuyuan_num = 500,
		reward = [{55288,1,0,3}]
};

get(11) ->
	#xuyuanchi_extra_reward{
		no = 11,
		xuyuan_num = 500,
		reward = [{55294,1,0,3}]
};

get(12) ->
	#xuyuanchi_extra_reward{
		no = 12,
		xuyuan_num = 1000,
		reward = [{55126,1,0,3}]
};

get(13) ->
	#xuyuanchi_extra_reward{
		no = 13,
		xuyuan_num = 1000,
		reward = [{55132,1,0,3}]
};

get(14) ->
	#xuyuanchi_extra_reward{
		no = 14,
		xuyuan_num = 1000,
		reward = [{55138,1,0,3}]
};

get(15) ->
	#xuyuanchi_extra_reward{
		no = 15,
		xuyuan_num = 1000,
		reward = [{55144,1,0,3}]
};

get(16) ->
	#xuyuanchi_extra_reward{
		no = 16,
		xuyuan_num = 1000,
		reward = [{55150,1,0,3}]
};

get(17) ->
	#xuyuanchi_extra_reward{
		no = 17,
		xuyuan_num = 2000,
		reward = [{55312,1,0,3}]
};

get(18) ->
	#xuyuanchi_extra_reward{
		no = 18,
		xuyuan_num = 2000,
		reward = [{55318,1,0,3}]
};

get(19) ->
	#xuyuanchi_extra_reward{
		no = 19,
		xuyuan_num = 2000,
		reward = [{55324,1,0,3}]
};

get(20) ->
	#xuyuanchi_extra_reward{
		no = 20,
		xuyuan_num = 5000,
		reward = [{89303,1,0,3}]
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

