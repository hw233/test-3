%%%---------------------------------------
%%% @Module  : data_home_splendid
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  风水豪华度配置表
%%%---------------------------------------


-module(data_home_splendid).

-include("home.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#home_splendid{
		no = 1,
		name = <<"生态宜居">>,
		home_luxury = 50,
		broadcast = [],
		reward = 0
};

get(2) ->
	#home_splendid{
		no = 2,
		name = <<"风水宝地">>,
		home_luxury = 200,
		broadcast = [],
		reward = 0
};

get(3) ->
	#home_splendid{
		no = 3,
		name = <<"纳气迎福">>,
		home_luxury = 500,
		broadcast = [],
		reward = 0
};

get(4) ->
	#home_splendid{
		no = 4,
		name = <<"人杰地灵">>,
		home_luxury = 1000,
		broadcast = [],
		reward = 0
};

get(5) ->
	#home_splendid{
		no = 5,
		name = <<"名门旺庭">>,
		home_luxury = 2500,
		broadcast = [362],
		reward = 0
};

get(6) ->
	#home_splendid{
		no = 6,
		name = <<"福祉盈门">>,
		home_luxury = 4000,
		broadcast = [363],
		reward = 0
};

get(7) ->
	#home_splendid{
		no = 7,
		name = <<"紫气东来">>,
		home_luxury = 5000,
		broadcast = [364],
		reward = 62349
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

