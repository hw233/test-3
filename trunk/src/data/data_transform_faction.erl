%%%---------------------------------------
%%% @Module  : data_transform_faction
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  职业转换
%%%---------------------------------------


-module(data_transform_faction).
-include("common.hrl").
-include("faction.hrl").
-compile(export_all).

get(1) ->
	#transform_faction{
		no = 1,
		time_range = [0 ,2],
		money = [{2,888888}]
};

get(2) ->
	#transform_faction{
		no = 2,
		time_range = [3 ,7],
		money = [{2,200000}]
};

get(3) ->
	#transform_faction{
		no = 3,
		time_range = [8 ,999999999],
		money = [{2,68000}]
};

get(_No) ->
		  null.

