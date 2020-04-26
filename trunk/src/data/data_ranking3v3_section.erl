%%%---------------------------------------
%%% @Module  : data_ranking3v3_section
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 段位池分段表
%%%---------------------------------------


-module(data_ranking3v3_section).
-export([get_no/0,get/1]).
-include("pvp.hrl").
-include("debug.hrl").

get_no()->
	[0,1,2,3,4,5,6,7,8].

get(0) ->
	#ranking3v3_section{
		no = 0,
		section = [0]
};

get(1) ->
	#ranking3v3_section{
		no = 1,
		section = [1,2,3,4,5]
};

get(2) ->
	#ranking3v3_section{
		no = 2,
		section = [6,7,8,9,10]
};

get(3) ->
	#ranking3v3_section{
		no = 3,
		section = [11,12,13,14,15]
};

get(4) ->
	#ranking3v3_section{
		no = 4,
		section = [16,17,18,19,20]
};

get(5) ->
	#ranking3v3_section{
		no = 5,
		section = [21,22,23,24,25]
};

get(6) ->
	#ranking3v3_section{
		no = 6,
		section = [26,27,28,29,30]
};

get(7) ->
	#ranking3v3_section{
		no = 7,
		section = [31]
};

get(8) ->
	#ranking3v3_section{
		no = 8,
		section = [32]
};

get(_no) ->
	?ASSERT(false, _no),
    null.

