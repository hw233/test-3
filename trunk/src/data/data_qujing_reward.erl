%%%---------------------------------------
%%% @Module  : data_qujing_reward
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  取经奖励配置表
%%%---------------------------------------


-module(data_qujing_reward).

-include("road.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#qujing_reward{
		no = 1,
		reward_no = 62458
};

get(2) ->
	#qujing_reward{
		no = 2,
		reward_no = 62459
};

get(3) ->
	#qujing_reward{
		no = 3,
		reward_no = 62460
};

get(4) ->
	#qujing_reward{
		no = 4,
		reward_no = 62461
};

get(5) ->
	#qujing_reward{
		no = 5,
		reward_no = 62462
};

get(6) ->
	#qujing_reward{
		no = 6,
		reward_no = 62463
};

get(7) ->
	#qujing_reward{
		no = 7,
		reward_no = 62464
};

get(8) ->
	#qujing_reward{
		no = 8,
		reward_no = 62465
};

get(9) ->
	#qujing_reward{
		no = 9,
		reward_no = 62466
};

get(10) ->
	#qujing_reward{
		no = 10,
		reward_no = 62467
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

