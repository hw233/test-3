%%%---------------------------------------
%%% @Module  : data_beauty_contest
%%% @Author  : YanLihong
%%% @Email   :
%%% @Description: 抽奖 女妖选美 配置数据
%%%---------------------------------------


-module(data_beauty_contest).
-export([get_ids/0, get/1]).
-include("beauty_contest.hrl").
-include("debug.hrl").

get_ids()->
	[1,2,3].

get(1) ->
	#data_beauty_contest{
		no = 1,
		lv_limit = {30,49},
		reward_bags = [{1,100}],
		cost_goods = {60193,1},
		cost_byuanbao = 20,
		cost_reset = 200
};

get(2) ->
	#data_beauty_contest{
		no = 2,
		lv_limit = {50,69},
		reward_bags = [{2,100}],
		cost_goods = {60193,1},
		cost_byuanbao = 20,
		cost_reset = 200
};

get(3) ->
	#data_beauty_contest{
		no = 3,
		lv_limit = {70,89},
		reward_bags = [{3,100}],
		cost_goods = {60193,1},
		cost_byuanbao = 20,
		cost_reset = 200
};

get(_No) ->
				?WARNING_MSG("Cannot get ~p", [_No]),
          null.

