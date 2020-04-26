%%%---------------------------------------
%%% @Module  : data_lv_reward
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 冲级奖励
%%%---------------------------------------


-module(data_lv_reward).
-export([
        get/1
    ]).

-include("reward.hrl").
-include("debug.hrl").

get(1) ->
	#lv_reward{
		no = 1,
		lv = 10,
		reward_no = 2001
};

get(2) ->
	#lv_reward{
		no = 2,
		lv = 50,
		reward_no = 2002
};

get(3) ->
	#lv_reward{
		no = 3,
		lv = 80,
		reward_no = 2003
};

get(4) ->
	#lv_reward{
		no = 4,
		lv = 100,
		reward_no = 2004
};

get(5) ->
	#lv_reward{
		no = 5,
		lv = 120,
		reward_no = 2005
};

get(6) ->
	#lv_reward{
		no = 6,
		lv = 140,
		reward_no = 2006
};

get(7) ->
	#lv_reward{
		no = 7,
		lv = 160,
		reward_no = 2007
};

get(8) ->
	#lv_reward{
		no = 8,
		lv = 180,
		reward_no = 2008
};

get(9) ->
	#lv_reward{
		no = 9,
		lv = 200,
		reward_no = 2009
};

get(10) ->
	#lv_reward{
		no = 10,
		lv = 220,
		reward_no = 2010
};

get(11) ->
	#lv_reward{
		no = 11,
		lv = 240,
		reward_no = 2011
};

get(_No) ->
    null.

