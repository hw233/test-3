%%%---------------------------------------
%%% @Module  : data_five_elements
%%% @Author  : 海狸喵
%%% @Email   : 
%%% @Description:  五行属性配置表
%%%---------------------------------------


-module(data_five_elements).

-include("five_elements.hrl").
-include("debug.hrl").
-compile(export_all).

get(0) ->
	#five_elements{
		no = 0,
		restraint = [],
		berestraint = [1,2,3,4,5,6],
		re_num = 1.200000,
		be_num = 0.700000
};

get(1) ->
	#five_elements{
		no = 1,
		restraint = [0,2,6],
		berestraint = [4],
		re_num = 1.200000,
		be_num = 0.700000
};

get(2) ->
	#five_elements{
		no = 2,
		restraint = [0,5,6],
		berestraint = [1],
		re_num = 1.200000,
		be_num = 0.700000
};

get(3) ->
	#five_elements{
		no = 3,
		restraint = [0,4,6],
		berestraint = [5],
		re_num = 1.200000,
		be_num = 0.700000
};

get(4) ->
	#five_elements{
		no = 4,
		restraint = [0,1,6],
		berestraint = [3],
		re_num = 1.200000,
		be_num = 0.700000
};

get(5) ->
	#five_elements{
		no = 5,
		restraint = [0,3,6],
		berestraint = [2],
		re_num = 1.200000,
		be_num = 0.700000
};

get(6) ->
	#five_elements{
		no = 6,
		restraint = [0,1,2,3,4,5,6],
		berestraint = [1,2,3,4,5,6],
		re_num = 1.200000,
		be_num = 0.700000
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

