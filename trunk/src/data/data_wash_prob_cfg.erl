%%%---------------------------------------
%%% @Module  : data_wash_prob_cfg
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  洗髓成长资质随机概率
%%%---------------------------------------


-module(data_wash_prob_cfg).
-include("partner.hrl").
-include("debug.hrl").
-compile(export_all).

get_all_no_list()->
	[1,2,3,4,5,6,7,8,9,10].

get(1) ->
	#wash_prob_cfg{
		no = 1,
		prob = 1
};

get(2) ->
	#wash_prob_cfg{
		no = 2,
		prob = 1
};

get(3) ->
	#wash_prob_cfg{
		no = 3,
		prob = 1
};

get(4) ->
	#wash_prob_cfg{
		no = 4,
		prob = 1
};

get(5) ->
	#wash_prob_cfg{
		no = 5,
		prob = 1
};

get(6) ->
	#wash_prob_cfg{
		no = 6,
		prob = 1
};

get(7) ->
	#wash_prob_cfg{
		no = 7,
		prob = 1
};

get(8) ->
	#wash_prob_cfg{
		no = 8,
		prob = 1
};

get(9) ->
	#wash_prob_cfg{
		no = 9,
		prob = 1
};

get(10) ->
	#wash_prob_cfg{
		no = 10,
		prob = 1
};

get(_No) ->
	?ASSERT(false, _No),
	null.

