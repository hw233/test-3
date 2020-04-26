%%%---------------------------------------
%%% @Module  : data_guild_dungeon_rank_reward
%%% @Author  : lzx
%%% @Email   : 
%%% @Description:  帮派副本排名奖励表
%%%---------------------------------------


-module(data_guild_dungeon_rank_reward).

-include("guild_dungeon.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#guild_dungeon_rank_reward{
		group = 1,
		begin_ranking = 1,
		end_ranking = 1,
		reward = 91780
};

get(2) ->
	#guild_dungeon_rank_reward{
		group = 2,
		begin_ranking = 2,
		end_ranking = 2,
		reward = 91781
};

get(3) ->
	#guild_dungeon_rank_reward{
		group = 3,
		begin_ranking = 3,
		end_ranking = 3,
		reward = 91782
};

get(4) ->
	#guild_dungeon_rank_reward{
		group = 4,
		begin_ranking = 4,
		end_ranking = 4,
		reward = 91783
};

get(5) ->
	#guild_dungeon_rank_reward{
		group = 5,
		begin_ranking = 5,
		end_ranking = 5,
		reward = 91784
};

get(6) ->
	#guild_dungeon_rank_reward{
		group = 6,
		begin_ranking = 6,
		end_ranking = 10,
		reward = 91785
};

get(7) ->
	#guild_dungeon_rank_reward{
		group = 7,
		begin_ranking = 11,
		end_ranking = 50,
		reward = 91786
};

get(8) ->
	#guild_dungeon_rank_reward{
		group = 8,
		begin_ranking = 51,
		end_ranking = 100,
		reward = 91787
};

get(9) ->
	#guild_dungeon_rank_reward{
		group = 9,
		begin_ranking = 101,
		end_ranking = 300,
		reward = 91788
};

get(10) ->
	#guild_dungeon_rank_reward{
		group = 10,
		begin_ranking = 301,
		end_ranking = 500,
		reward = 91789
};

get(11) ->
	#guild_dungeon_rank_reward{
		group = 11,
		begin_ranking = 501,
		end_ranking = 1000,
		reward = 91790
};

get(12) ->
	#guild_dungeon_rank_reward{
		group = 12,
		begin_ranking = 0,
		end_ranking = 0,
		reward = 91791
};

get(_group) ->
	      ?ASSERT(false),
          null.

