%%%---------------------------------------
%%% @Module  : data_ranking3v3_rank_reward
%%% @Author  : lzx
%%% @Email   : 
%%% @Description:  段位排名奖励表
%%%---------------------------------------


-module(data_ranking3v3_rank_reward).

-include("pvp.hrl").
-include("debug.hrl").
-compile(export_all).

get_group()->
	[1,2,3,4,5,6,7,8,9,10,11].

get(1) ->
	#ranking3v3_rank_reward{
		group = 1,
		begin_ranking = 1,
		end_ranking = 1,
		reward = 91616
};

get(2) ->
	#ranking3v3_rank_reward{
		group = 2,
		begin_ranking = 2,
		end_ranking = 2,
		reward = 91617
};

get(3) ->
	#ranking3v3_rank_reward{
		group = 3,
		begin_ranking = 3,
		end_ranking = 3,
		reward = 91618
};

get(4) ->
	#ranking3v3_rank_reward{
		group = 4,
		begin_ranking = 4,
		end_ranking = 10,
		reward = 91619
};

get(5) ->
	#ranking3v3_rank_reward{
		group = 5,
		begin_ranking = 11,
		end_ranking = 20,
		reward = 91620
};

get(6) ->
	#ranking3v3_rank_reward{
		group = 6,
		begin_ranking = 21,
		end_ranking = 30,
		reward = 91621
};

get(7) ->
	#ranking3v3_rank_reward{
		group = 7,
		begin_ranking = 31,
		end_ranking = 50,
		reward = 91622
};

get(8) ->
	#ranking3v3_rank_reward{
		group = 8,
		begin_ranking = 51,
		end_ranking = 100,
		reward = 91623
};

get(9) ->
	#ranking3v3_rank_reward{
		group = 9,
		begin_ranking = 101,
		end_ranking = 200,
		reward = 91624
};

get(10) ->
	#ranking3v3_rank_reward{
		group = 10,
		begin_ranking = 201,
		end_ranking = 300,
		reward = 91625
};

get(11) ->
	#ranking3v3_rank_reward{
		group = 11,
		begin_ranking = 301,
		end_ranking = 10000,
		reward = 91626
};

get(_group) ->
	      ?ASSERT(false, {_group}),
          null.

