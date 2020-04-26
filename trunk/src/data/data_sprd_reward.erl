%%%---------------------------------------
%%% @Module  : data_sprd_reward
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 推广系统的奖励配置
%%%---------------------------------------


-module(data_sprd_reward).
-export([get/1]).
-include("sprd.hrl").

get(25) ->
	#sprd_reward{
		lv = 25,
		pkg_to_sprder = 90019,
		pkg_to_sprdee = 90018
};

get(40) ->
	#sprd_reward{
		lv = 40,
		pkg_to_sprder = 90020,
		pkg_to_sprdee = 0
};

get(50) ->
	#sprd_reward{
		lv = 50,
		pkg_to_sprder = 90021,
		pkg_to_sprdee = 0
};

get(_Lv) ->
          null.

