%%%---------------------------------------
%%% @Module  : data_find_par
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 寻妖表
%%%---------------------------------------


-module(data_find_par).
-export([
        get_all_lv_step_list/0,
        get/1
    ]).

-include("partner.hrl").
-include("debug.hrl").

get_all_lv_step_list()->
	[1].

get(1) ->
	#find_par_cfg{
		no = 1,
		lv_range = [1 ,120],
		money_need_com = 1000,
		goods_need_com = [{60102,1}],
		money_need_high = 4500,
		goods_need_high = [],
		common_pool = [{1001,100,1},{1011,100,1},{1021,100,1},{1031,50,1},{1041,400,20},{1051,400,20},{1061,40,20},{1071,400,30},{1081,400,30},{1091,40,30},{1101,400,40},{1111,400,40},{1121,40,40},{1131,600,50},{1141,600,50},{1151,60,50},{1161,600,60},{1171,600,60},{1181,60,60},{1191,600,70},{1201,600,70},{1211,60,70},{1221,600,80},{1231,600,80},{1241,60,80}],
		high_pool = [{1001,1300,1},
{1011,1300,1},
{1021,1300,1},
{1031,2000,1},
{1041,4000,1},
{1051,4000,1},
{1061,1300,1},
{1071,4000,1},
{1081,4000,1},
{1091,1300,1},
{1101,4000,1},
{1111,4000,1},
{1121,1300,1},
{1131,6000,1},
{1141,6000,1},
{1151,1300,1},
{1161,6000,1},
{1171,6000,1},
{1181,1300,1},
{1191,6000,1},
{1201,6000,1},
{1211,1300,1},
{1221,6000,1},
{1231,6000,1},
{1241,1300,1},
{2001,2000,1},
{2011,2000,1},
{2021,2000,1},
{2031,2000,1},
{2051,1000,1},
{2061,1000,1},
{2071,1000,1},
{2081,1000,1},
{2091,1000,1},
{4001,190,1},
{4011,190,1},
{4021,190,1},
{4027,190,1},
{4033,190,1},
{4039,190,1},
{4045,190,1},
{4051,190,1}

],
		high_pool10 = [{2001,50,80},{2011,50,70},{2021,50,50},{2031,50,40}],
		minimum_pool = [{2051,1,1},{2061,1,1},{2071,1,1},{2081,1,1},{2091,1,1}],
		minimum_money = 10000000,
		minimum_count = 10
};

get(_No) ->
	?ASSERT(false, _No),
    null.

