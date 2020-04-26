%%%---------------------------------------
%%% @Module  : data_paodian
%%% @Author  : duan
%%% @Email   :
%%% @Description: 泡点
%%%---------------------------------------


-module(data_paodian).
-export([get/1]).
-include("record.hrl").
-include("debug.hrl").

get(0) ->
	#paodian_config{
		id = 0,
		price_type = 1,
		price = 0,
		exp = 20
};

get(1) ->
	#paodian_config{
		id = 1,
		price_type = 1,
		price = 10000,
		exp = 30
};

get(2) ->
	#paodian_config{
		id = 2,
		price_type = 2,
		price = 100,
		exp = 50
};

get(3) ->
	#paodian_config{
		id = 3,
		price_type = 2,
		price = 300,
		exp = 100
};

get(4) ->
	#paodian_config{
		id = 4,
		price_type = 14,
		price = 5,
		exp = 80
};

get(_ID) ->
				?ERROR_MSG("not found ~w", [_ID]),
          null.

