%%%---------------------------------------
%%% @Module  : data_fabao_change_anim
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 法宝幻化外观表
%%%---------------------------------------


-module(data_fabao_change_anim).
-compile(export_all).
-include("fabao.hrl").
-include("debug.hrl").

get(60001) ->
	#fabao_change_anim{
		no = 60001,
		type = 1,
		get_price = 0
};

get(60002) ->
	#fabao_change_anim{
		no = 60002,
		type = 1,
		get_price = 0
};

get(60003) ->
	#fabao_change_anim{
		no = 60003,
		type = 1,
		get_price = 0
};

get(60004) ->
	#fabao_change_anim{
		no = 60004,
		type = 1,
		get_price = 0
};

get(60005) ->
	#fabao_change_anim{
		no = 60005,
		type = 1,
		get_price = 0
};

get(60006) ->
	#fabao_change_anim{
		no = 60006,
		type = 1,
		get_price = 0
};

get(70001) ->
	#fabao_change_anim{
		no = 70001,
		type = 2,
		get_price = {14, 6000}
};

get(70002) ->
	#fabao_change_anim{
		no = 70002,
		type = 2,
		get_price = {14, 8000}
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

