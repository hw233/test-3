%%%---------------------------------------
%%% @Module  : data_soaring_config
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 飞升配置
%%%---------------------------------------


-module(data_soaring_config).
-export([
        get/1
    ]).

-include("player.hrl").
-include("debug.hrl").

get(1) ->
	#soaring_config{
		id = 1,
		goods = [{10102,10}],
		need_lv = 200,
		lv_limit = 230
};

get(2) ->
	#soaring_config{
		id = 2,
		goods = [{10102,25}],
		need_lv = 230,
		lv_limit = 260
};

get(3) ->
	#soaring_config{
		id = 3,
		goods = [{10104,10}],
		need_lv = 260,
		lv_limit = 290
};

get(4) ->
	#soaring_config{
		id = 4,
		goods = [{10104,25}],
		need_lv = 290,
		lv_limit = 320
};

get(5) ->
	#soaring_config{
		id = 5,
		goods = [{10105,10}],
		need_lv = 320,
		lv_limit = 360
};

get(Lv) ->
    null.

