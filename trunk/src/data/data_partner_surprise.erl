%%%---------------------------------------
%%% @Module  : data_partner_surprise
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 宠物惊喜
%%%---------------------------------------


-module(data_partner_surprise).
-compile(export_all).

-include("partner.hrl").
-include("debug.hrl").

get_all_surprise_no()->
	[1,2,3,4,5].

get(1) ->
	#surprise{
		no = 1,
		para = 0,
		weight = 105
};

get(2) ->
	#surprise{
		no = 2,
		para = 0,
		weight = 5
};

get(3) ->
	#surprise{
		no = 3,
		para = 0,
		weight = 50
};

get(4) ->
	#surprise{
		no = 4,
		para = 0,
		weight = 40
};

get(5) ->
	#surprise{
		no = 5,
		para = 0,
		weight = 800
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

