%%%---------------------------------------
%%% @Module  : data_clifford_config
%%% @Author  : duansh
%%% @Email   : 
%%% @Description: 福源
%%%---------------------------------------


-module(data_clifford_config).
-export([
        get/1
    ]).

-include("clifford.hrl").
-include("debug.hrl").

get(0) ->
	#clifford_config{
		type = 0,
		consume = [{10108, 1}],
		must_goods = [{10043, 5}]
};

get(1) ->
	#clifford_config{
		type = 1,
		consume = [{10109, 1}],
		must_goods = [{10043, 10}]
};

get(_Type) ->
				?ASSERT(false, _Type),
				null.

