%%%---------------------------------------
%%% @Module  : data_day_reward_com
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 每日日奖励 不包括节日
%%%---------------------------------------


-module(data_day_reward_com).
-export([
        get/1
    ]).

-include("reward.hrl").
-include("debug.hrl").

get(1) ->
	#data_reward_cfg_1{
		no = 1,
		goods_no = 70011,
		goods_count = 20,
		bind_gold = 0,
		bind_silver = 0
};

get(2) ->
	#data_reward_cfg_1{
		no = 2,
		goods_no = 60063,
		goods_count = 200,
		bind_gold = 0,
		bind_silver = 0
};

get(3) ->
	#data_reward_cfg_1{
		no = 3,
		goods_no = 20013,
		goods_count = 50,
		bind_gold = 0,
		bind_silver = 0
};

get(4) ->
	#data_reward_cfg_1{
		no = 4,
		goods_no = 50038,
		goods_count = 100,
		bind_gold = 0,
		bind_silver = 0
};

get(5) ->
	#data_reward_cfg_1{
		no = 5,
		goods_no = 72403,
		goods_count = 30,
		bind_gold = 0,
		bind_silver = 0
};

get(6) ->
	#data_reward_cfg_1{
		no = 6,
		goods_no = 72401,
		goods_count = 2,
		bind_gold = 0,
		bind_silver = 0
};

get(7) ->
	#data_reward_cfg_1{
		no = 7,
		goods_no = 50366,
		goods_count = 2,
		bind_gold = 0,
		bind_silver = 0
};

get(8) ->
	#data_reward_cfg_1{
		no = 8,
		goods_no = 60063,
		goods_count = 200,
		bind_gold = 0,
		bind_silver = 0
};

get(9) ->
	#data_reward_cfg_1{
		no = 9,
		goods_no = 20013,
		goods_count = 60,
		bind_gold = 0,
		bind_silver = 0
};

get(10) ->
	#data_reward_cfg_1{
		no = 10,
		goods_no = 89001,
		goods_count = 30000,
		bind_gold = 0,
		bind_silver = 0
};

get(11) ->
	#data_reward_cfg_1{
		no = 11,
		goods_no = 50038,
		goods_count = 120,
		bind_gold = 0,
		bind_silver = 0
};

get(12) ->
	#data_reward_cfg_1{
		no = 12,
		goods_no = 72402,
		goods_count = 25,
		bind_gold = 0,
		bind_silver = 0
};

get(13) ->
	#data_reward_cfg_1{
		no = 13,
		goods_no = 10043,
		goods_count = 15,
		bind_gold = 0,
		bind_silver = 0
};

get(14) ->
	#data_reward_cfg_1{
		no = 14,
		goods_no = 62041,
		goods_count = 3,
		bind_gold = 0,
		bind_silver = 0
};

get(15) ->
	#data_reward_cfg_1{
		no = 15,
		goods_no = 50366,
		goods_count = 2,
		bind_gold = 0,
		bind_silver = 0
};

get(16) ->
	#data_reward_cfg_1{
		no = 16,
		goods_no = 72403,
		goods_count = 50,
		bind_gold = 0,
		bind_silver = 0
};

get(17) ->
	#data_reward_cfg_1{
		no = 17,
		goods_no = 89001,
		goods_count = 30000,
		bind_gold = 0,
		bind_silver = 0
};

get(18) ->
	#data_reward_cfg_1{
		no = 18,
		goods_no = 50307,
		goods_count = 30,
		bind_gold = 0,
		bind_silver = 0
};

get(19) ->
	#data_reward_cfg_1{
		no = 19,
		goods_no = 60063,
		goods_count = 200,
		bind_gold = 0,
		bind_silver = 0
};

get(20) ->
	#data_reward_cfg_1{
		no = 20,
		goods_no = 20013,
		goods_count = 70,
		bind_gold = 0,
		bind_silver = 0
};

get(21) ->
	#data_reward_cfg_1{
		no = 21,
		goods_no = 50366,
		goods_count = 2,
		bind_gold = 0,
		bind_silver = 0
};

get(22) ->
	#data_reward_cfg_1{
		no = 22,
		goods_no = 20024,
		goods_count = 20,
		bind_gold = 0,
		bind_silver = 0
};

get(23) ->
	#data_reward_cfg_1{
		no = 23,
		goods_no = 62041,
		goods_count = 3,
		bind_gold = 0,
		bind_silver = 0
};

get(24) ->
	#data_reward_cfg_1{
		no = 24,
		goods_no = 89001,
		goods_count = 30000,
		bind_gold = 0,
		bind_silver = 0
};

get(25) ->
	#data_reward_cfg_1{
		no = 25,
		goods_no = 50307,
		goods_count = 30,
		bind_gold = 0,
		bind_silver = 0
};

get(26) ->
	#data_reward_cfg_1{
		no = 26,
		goods_no = 20013,
		goods_count = 80,
		bind_gold = 0,
		bind_silver = 0
};

get(27) ->
	#data_reward_cfg_1{
		no = 27,
		goods_no = 60063,
		goods_count = 200,
		bind_gold = 0,
		bind_silver = 0
};

get(28) ->
	#data_reward_cfg_1{
		no = 28,
		goods_no = 20022,
		goods_count = 20,
		bind_gold = 0,
		bind_silver = 0
};

get(29) ->
	#data_reward_cfg_1{
		no = 29,
		goods_no = 72401,
		goods_count = 2,
		bind_gold = 0,
		bind_silver = 0
};

get(30) ->
	#data_reward_cfg_1{
		no = 30,
		goods_no = 89001,
		goods_count = 30000,
		bind_gold = 0,
		bind_silver = 0
};

get(31) ->
	#data_reward_cfg_1{
		no = 31,
		goods_no = 62042,
		goods_count = 1,
		bind_gold = 0,
		bind_silver = 0
};

get(_No) ->
	?ASSERT(false, _No),
    null.

