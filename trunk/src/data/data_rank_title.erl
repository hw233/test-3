%%%---------------------------------------
%%% @Module  : data_rank_title
%%% @Author  : liuzz
%%% @Email   :
%%% @Description: 排行榜称号
%%%---------------------------------------


-module(data_rank_title).
-export([get_ids/0, get/1]).
-include("debug.hrl").
-include("rank.hrl").

get_ids()->
	[1001,1002,1003,1007,1008,1010,1011,1021,1022,1023,1024,1025,1026,1201,1202,2001,3001,4002,6001,7001,7002,8001,9001,9002,9003].

get(1001) ->
	#rank_title{
		rank = 1001,
		rewards = [],
		title = "",
		content = ""
};

get(1002) ->
	#rank_title{
		rank = 1002,
		rewards = [],
		title = "",
		content = ""
};

get(1003) ->
	#rank_title{
		rank = 1003,
		rewards = [],
		title = "",
		content = ""
};

get(1021) ->
	#rank_title{
		rank = 1021,
		rewards = [],
		title = "",
		content = ""
};

get(1022) ->
	#rank_title{
		rank = 1022,
		rewards = [],
		title = "",
		content = ""
};

get(1023) ->
	#rank_title{
		rank = 1023,
		rewards = [],
		title = "",
		content = ""
};

get(1024) ->
	#rank_title{
		rank = 1024,
		rewards = [],
		title = "",
		content = ""
};

get(1025) ->
	#rank_title{
		rank = 1025,
		rewards = [],
		title = "",
		content = ""
};

get(1026) ->
	#rank_title{
		rank = 1026,
		rewards = [],
		title = "",
		content = ""
};

get(2001) ->
	#rank_title{
		rank = 2001,
		rewards = [],
		title = "",
		content = ""
};

get(3001) ->
	#rank_title{
		rank = 3001,
		rewards = [],
		title = "",
		content = ""
};

get(4002) ->
	#rank_title{
		rank = 4002,
		rewards = [],
		title = "",
		content = ""
};

get(6001) ->
	#rank_title{
		rank = 6001,
		rewards = [],
		title = "",
		content = ""
};

get(1201) ->
	#rank_title{
		rank = 1201,
		rewards = [],
		title = "",
		content = ""
};

get(1202) ->
	#rank_title{
		rank = 1202,
		rewards = [],
		title = "",
		content = ""
};

get(1007) ->
	#rank_title{
		rank = 1007,
		rewards = [],
		title = "",
		content = ""
};

get(1008) ->
	#rank_title{
		rank = 1008,
		rewards = [],
		title = "",
		content = ""
};

get(1010) ->
	#rank_title{
		rank = 1010,
		rewards = [],
		title = "",
		content = ""
};

get(7001) ->
	#rank_title{
		rank = 7001,
		rewards = [],
		title = "",
		content = ""
};

get(7002) ->
	#rank_title{
		rank = 7002,
		rewards = [],
		title = "",
		content = ""
};

get(8001) ->
	#rank_title{
		rank = 8001,
		rewards = [],
		title = "",
		content = ""
};

get(9001) ->
	#rank_title{
		rank = 9001,
		rewards = [],
		title = "",
		content = ""
};

get(9002) ->
	#rank_title{
		rank = 9002,
		rewards = [],
		title = "",
		content = ""
};

get(9003) ->
	#rank_title{
		rank = 9003,
		rewards = [],
		title = "",
		content = ""
};

get(1011) ->
	#rank_title{
		rank = 1011,
		rewards = [{1,2001},{2,2002},{3,2003},{4,2004},{5,2005},{10,2006},{50,2007},{200,2008},{500,2009},{9999,2010}],
		title = "伏魔塔排行榜",
		content = "您昨日在挑战伏魔塔的排名是第~p，排名结算奖励请查收附件！"
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

