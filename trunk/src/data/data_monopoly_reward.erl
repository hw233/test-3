%%%---------------------------------------
%%% @Module  : data_monopoly_reward
%%% @Author  : 
%%% @Email   : 
%%% @Description:  大富翁奖励配置表
%%%---------------------------------------


-module(data_monopoly_reward).

-include("monopoly.hrl").
-include("debug.hrl").
-compile(export_all).

get(62227) ->
	#monopoly_reward{
		no = 62227,
		type = 1,
		number = [2,5],
		probability = [1,5],
		bind = 3
};

get(62230) ->
	#monopoly_reward{
		no = 62230,
		type = 1,
		number = [2,5],
		probability = [1,4],
		bind = 3
};

get(62231) ->
	#monopoly_reward{
		no = 62231,
		type = 1,
		number = [2,5],
		probability = [1,3],
		bind = 3
};

get(62631) ->
	#monopoly_reward{
		no = 62631,
		type = 1,
		number = [3,7],
		probability = [1,4],
		bind = 3
};

get(62321) ->
	#monopoly_reward{
		no = 62321,
		type = 1,
		number = [3,7],
		probability = [1,3],
		bind = 3
};

get(60039) ->
	#monopoly_reward{
		no = 60039,
		type = 1,
		number = [5,20],
		probability = [1,4],
		bind = 3
};

get(20013) ->
	#monopoly_reward{
		no = 20013,
		type = 1,
		number = [2,10],
		probability = [1,3],
		bind = 3
};

get(110000) ->
	#monopoly_reward{
		no = 110000,
		type = 1,
		number = [3,6],
		probability = [1,3],
		bind = 3
};

get(60040) ->
	#monopoly_reward{
		no = 60040,
		type = 1,
		number = [2,5],
		probability = [1,4],
		bind = 3
};

get(20014) ->
	#monopoly_reward{
		no = 20014,
		type = 1,
		number = [2,5],
		probability = [1,4],
		bind = 3
};

get(110000) ->
	#monopoly_reward{
		no = 110000,
		type = 2,
		number = [5,8],
		probability = [0,2],
		bind = 3
};

get(62632) ->
	#monopoly_reward{
		no = 62632,
		type = 2,
		number = [2,4],
		probability = [0,3],
		bind = 3
};

get(62229) ->
	#monopoly_reward{
		no = 62229,
		type = 2,
		number = [1,2],
		probability = [0,2],
		bind = 3
};

get(62322) ->
	#monopoly_reward{
		no = 62322,
		type = 2,
		number = [1,3],
		probability = [0,2],
		bind = 3
};

get(60040) ->
	#monopoly_reward{
		no = 60040,
		type = 2,
		number = [5,10],
		probability = [0,2],
		bind = 3
};

get(20014) ->
	#monopoly_reward{
		no = 20014,
		type = 3,
		number = [5,10],
		probability = [0,2],
		bind = 3
};

get(110001) ->
	#monopoly_reward{
		no = 110001,
		type = 3,
		number = [1,3],
		probability = [0,2],
		bind = 3
};

get(110001) ->
	#monopoly_reward{
		no = 110001,
		type = 3,
		number = [5,10],
		probability = [1,1],
		bind = 3
};

get(20032) ->
	#monopoly_reward{
		no = 20032,
		type = 3,
		number = [2,5],
		probability = [0,2],
		bind = 3
};

get(62232) ->
	#monopoly_reward{
		no = 62232,
		type = 3,
		number = [1,2],
		probability = [0,1],
		bind = 3
};

get(20033) ->
	#monopoly_reward{
		no = 20033,
		type = 3,
		number = [1,3],
		probability = [0,1],
		bind = 3
};

get(110002) ->
	#monopoly_reward{
		no = 110002,
		type = 3,
		number = [1,1],
		probability = [1,2],
		bind = 3
};

get(110002) ->
	#monopoly_reward{
		no = 110002,
		type = 3,
		number = [3,3],
		probability = [1,1],
		bind = 3
};

get(62250) ->
	#monopoly_reward{
		no = 62250,
		type = 3,
		number = [10,20],
		probability = [0,1],
		bind = 3
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

get_first_type()->
	[62227,62230,62231,62631,62321,60039,20013,110000,60040,20014].

get_second_type()->
	[110000,62632,62229,62322,60040].

get_third_type()->
	[20014,110001,110001,20032,62232,20033,110002,110002,62250].

