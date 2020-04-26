%%%---------------------------------------
%%% @Module  : data_day_reward
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 每日签到与在线奖励配置数据
%%%---------------------------------------


-module(data_day_reward).
-export([
        get_no_by_type/1,
        get/1
    ]).

-include("reward.hrl").
-include("debug.hrl").

get_no_by_type(1)->
	[1,2,3,4,5,6];
get_no_by_type(2)->
	[7,8,9,10,11,12,13,14];
get_no_by_type(3)->
	[15,16,17,18,19,20,21];
get_no_by_type(4)->
	[22,23,24].

get(1) ->
	#day_reward_cfg{
		no = 1,
		type = 1,
		reward_no = 41200,
		condition = 1,
		precondition = 0
};

get(2) ->
	#day_reward_cfg{
		no = 2,
		type = 1,
		reward_no = 41201,
		condition = 3,
		precondition = 0
};

get(3) ->
	#day_reward_cfg{
		no = 3,
		type = 1,
		reward_no = 41202,
		condition = 7,
		precondition = 0
};

get(4) ->
	#day_reward_cfg{
		no = 4,
		type = 1,
		reward_no = 41203,
		condition = 12,
		precondition = 0
};

get(5) ->
	#day_reward_cfg{
		no = 5,
		type = 1,
		reward_no = 41204,
		condition = 18,
		precondition = 0
};

get(6) ->
	#day_reward_cfg{
		no = 6,
		type = 1,
		reward_no = 41205,
		condition = 24,
		precondition = 0
};

get(7) ->
	#day_reward_cfg{
		no = 7,
		type = 2,
		reward_no = 2101,
		condition = 0,
		precondition = 0
};

get(8) ->
	#day_reward_cfg{
		no = 8,
		type = 2,
		reward_no = 2102,
		condition = 120,
		precondition = 7
};

get(9) ->
	#day_reward_cfg{
		no = 9,
		type = 2,
		reward_no = 2103,
		condition = 300,
		precondition = 8
};

get(10) ->
	#day_reward_cfg{
		no = 10,
		type = 2,
		reward_no = 2104,
		condition = 600,
		precondition = 9
};

get(11) ->
	#day_reward_cfg{
		no = 11,
		type = 2,
		reward_no = 2105,
		condition = 900,
		precondition = 10
};

get(12) ->
	#day_reward_cfg{
		no = 12,
		type = 2,
		reward_no = 2106,
		condition = 1800,
		precondition = 11
};

get(13) ->
	#day_reward_cfg{
		no = 13,
		type = 2,
		reward_no = 2107,
		condition = 3600,
		precondition = 12
};

get(14) ->
	#day_reward_cfg{
		no = 14,
		type = 2,
		reward_no = 2108,
		condition = 7200,
		precondition = 13
};

get(15) ->
	#day_reward_cfg{
		no = 15,
		type = 3,
		reward_no = 90039,
		condition = 1,
		precondition = 0
};

get(16) ->
	#day_reward_cfg{
		no = 16,
		type = 3,
		reward_no = 90040,
		condition = 2,
		precondition = 0
};

get(17) ->
	#day_reward_cfg{
		no = 17,
		type = 3,
		reward_no = 90041,
		condition = 3,
		precondition = 0
};

get(18) ->
	#day_reward_cfg{
		no = 18,
		type = 3,
		reward_no = 90042,
		condition = 4,
		precondition = 0
};

get(19) ->
	#day_reward_cfg{
		no = 19,
		type = 3,
		reward_no = 90043,
		condition = 5,
		precondition = 0
};

get(20) ->
	#day_reward_cfg{
		no = 20,
		type = 3,
		reward_no = 90044,
		condition = 6,
		precondition = 0
};

get(21) ->
	#day_reward_cfg{
		no = 21,
		type = 3,
		reward_no = 90045,
		condition = 7,
		precondition = 0
};

get(22) ->
	#day_reward_cfg{
		no = 22,
		type = 4,
		reward_no = 91605,
		condition = 3,
		precondition = 0
};

get(23) ->
	#day_reward_cfg{
		no = 23,
		type = 4,
		reward_no = 91606,
		condition = 5,
		precondition = 0
};

get(24) ->
	#day_reward_cfg{
		no = 24,
		type = 4,
		reward_no = 91607,
		condition = 7,
		precondition = 0
};

get(_No) ->
	?ASSERT(false, _No),
    null.

