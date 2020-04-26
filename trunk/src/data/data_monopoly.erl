%%%---------------------------------------
%%% @Module  : data_monopoly
%%% @Author  : 
%%% @Email   : 
%%% @Description:  大富翁配置表
%%%---------------------------------------


-module(data_monopoly).

-include("monopoly.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#monopoly{
		type = 1,
		probability = [10,20]
};

get(2) ->
	#monopoly{
		type = 2,
		probability = [3,5]
};

get(3) ->
	#monopoly{
		type = 3,
		probability = [5,10]
};

get(4) ->
	#monopoly{
		type = 4,
		probability = [3,6]
};

get(_Type) ->
	      ?ASSERT(false, _Type),
          null.

get_monopoly_no()->
	[1,2,3,4].

