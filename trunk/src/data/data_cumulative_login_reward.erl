%%%---------------------------------------
%%% @Module  : cumulative_login_reward
%%% @Author  : easy
%%% @Email   : 
%%% @Description: 累计登陆奖励
%%%---------------------------------------


-module(data_cumulative_login_reward).
-export([
        get/1
    ]).

-include("reward.hrl").
-include("debug.hrl").

get(1) ->
	#data_cumulative_login_reward{
		no = 1,
		goods_no = [{89001,6888},{70011,10},{60063,100},{20013,50}]
};

get(2) ->
	#data_cumulative_login_reward{
		no = 2,
		goods_no = [{89001,12888},{55011,1},{72401,3},{50038,100}]
};

get(3) ->
	#data_cumulative_login_reward{
		no = 3,
		goods_no = [{89001,16888},{55111,3},{62025,10},{62041,5}]
};

get(4) ->
	#data_cumulative_login_reward{
		no = 4,
		goods_no = [{89001,18888},{20049,1},{62042,3},{20022,20}]
};

get(5) ->
	#data_cumulative_login_reward{
		no = 5,
		goods_no = [{89001,23888},{55111,7},{72402,100},{72403,100}]
};

get(6) ->
	#data_cumulative_login_reward{
		no = 6,
		goods_no = [{89001,23888},{55111,7},{72402,100},{72403,100}]
};

get(7) ->
	#data_cumulative_login_reward{
		no = 7,
		goods_no = [{89001,23888},{55111,7},{72402,100},{72403,100}]
};

get(8) ->
	#data_cumulative_login_reward{
		no = 8,
		goods_no = [{89001,23888},{55111,7},{72402,100},{72403,100}]
};

get(_No) ->
    null.

get_cumulative_login_reward_nos()->
	[1,2,3,4,5,6,7,8].

