%%%---------------------------------------
%%% @Module  : data_internal_skill_star_relevant
%%% @Author  : easy
%%% @Email   : 
%%% @Description: 星级关联属性配置表
%%%---------------------------------------


-module(data_internal_skill_star_relevant).
-export([
        get_no/0,
        get/1
    ]).

-include("train.hrl").
-include("debug.hrl").

get_no()->
	[1,2,3,4,5].

get(1) ->
	#internal_skill_star_relevant_cfg{
		no = 1,
		coe_a = 1,
		coe_b = 1,
		coe_c = 0,
		coe_d = 0
};

get(2) ->
	#internal_skill_star_relevant_cfg{
		no = 2,
		coe_a = 1,
		coe_b = 1,
		coe_c = 0,
		coe_d = 0
};

get(3) ->
	#internal_skill_star_relevant_cfg{
		no = 3,
		coe_a = 1,
		coe_b = 1,
		coe_c = 0,
		coe_d = 0
};

get(4) ->
	#internal_skill_star_relevant_cfg{
		no = 4,
		coe_a = 1,
		coe_b = 1,
		coe_c = 0,
		coe_d = 0
};

get(5) ->
	#internal_skill_star_relevant_cfg{
		no = 5,
		coe_a = 1,
		coe_b = 1,
		coe_c = 0,
		coe_d = 0
};

get(_No) ->
	?ASSERT(false, _No),
    null.

