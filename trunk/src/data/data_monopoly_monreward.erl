%%%---------------------------------------
%%% @Module  : data_monopoly_monreward
%%% @Author  : 
%%% @Email   : 
%%% @Description:  大富翁怪物组对应奖励表
%%%---------------------------------------


-module(data_monopoly_monreward).

-include("monopoly.hrl").
-include("debug.hrl").
-compile(export_all).

get(800559) ->
	#monopoly_monreward{
		mon = 800559,
		reward = [110005,5,3]
};

get(800560) ->
	#monopoly_monreward{
		mon = 800560,
		reward = [110004,10,3]
};

get(800561) ->
	#monopoly_monreward{
		mon = 800561,
		reward = [110009,5,3]
};

get(800562) ->
	#monopoly_monreward{
		mon = 800562,
		reward = [110008,10,3]
};

get(_Mon) ->
	      ?ASSERT(false, _Mon),
          null.

