%%%---------------------------------------
%%% @Module  : data_guild_war_reward
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 山寨
%%%---------------------------------------


-module(data_guild_war_reward).
-export([
        get/1
    ]).

-include("record/guild_record.hrl").
-include("debug.hrl").

get(1) ->
	#guild_war_reward{
		no = 1,
		goods_no = 60227,
		prosper = 100,
		boss_goods_no = 60243
};

get(2) ->
	#guild_war_reward{
		no = 2,
		goods_no = 60226,
		prosper = 90,
		boss_goods_no = 60242
};

get(3) ->
	#guild_war_reward{
		no = 3,
		goods_no = 60222,
		prosper = 80,
		boss_goods_no = 0
};

get(4) ->
	#guild_war_reward{
		no = 4,
		goods_no = 60225,
		prosper = 70,
		boss_goods_no = 60241
};

get(5) ->
	#guild_war_reward{
		no = 5,
		goods_no = 60222,
		prosper = 60,
		boss_goods_no = 0
};

get(6) ->
	#guild_war_reward{
		no = 6,
		goods_no = 60224,
		prosper = 50,
		boss_goods_no = 0
};

get(7) ->
	#guild_war_reward{
		no = 7,
		goods_no = 60222,
		prosper = 40,
		boss_goods_no = 0
};

get(8) ->
	#guild_war_reward{
		no = 8,
		goods_no = 60223,
		prosper = 30,
		boss_goods_no = 0
};

get(_No) ->
  ?ASSERT(false, _No),
    null.

