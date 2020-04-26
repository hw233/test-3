%%%---------------------------------------
%%% @Module  : data_qujing_battle_coef
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  取经战斗系数配置表
%%%---------------------------------------


-module(data_qujing_battle_coef).

-include("road.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#qujing_battle_coef{
		no = 1,
		ratio_min = 0.700000,
		ratio_max = 0.800000
};

get(2) ->
	#qujing_battle_coef{
		no = 2,
		ratio_min = 0.700000,
		ratio_max = 0.800000
};

get(3) ->
	#qujing_battle_coef{
		no = 3,
		ratio_min = 0.900000,
		ratio_max = 1.100000
};

get(4) ->
	#qujing_battle_coef{
		no = 4,
		ratio_min = 1.100000,
		ratio_max = 1.300000
};

get(5) ->
	#qujing_battle_coef{
		no = 5,
		ratio_min = 1.300000,
		ratio_max = 1.500000
};

get(6) ->
	#qujing_battle_coef{
		no = 6,
		ratio_min = 1.500000,
		ratio_max = 1.700000
};

get(7) ->
	#qujing_battle_coef{
		no = 7,
		ratio_min = 1.500000,
		ratio_max = 1.700000
};

get(8) ->
	#qujing_battle_coef{
		no = 8,
		ratio_min = 1.700000,
		ratio_max = 1.900000
};

get(9) ->
	#qujing_battle_coef{
		no = 9,
		ratio_min = 2,
		ratio_max = 2.500000
};

get(10) ->
	#qujing_battle_coef{
		no = 10,
		ratio_min = 2,
		ratio_max = 2.500000
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

