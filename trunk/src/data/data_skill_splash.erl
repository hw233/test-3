%%%---------------------------------------
%%% @Module  : data_skill_splash
%%% @Author  : YanLihong
%%% @Email   :
%%% @Description: 技能溅射效果配置表
%%%---------------------------------------


-module(data_skill_splash).
-export([get/1]).
-include("record/battle_record.hrl").
-include("debug.hrl").

get(1) ->
	#splash_pattern{
		no = 1,
		pos_1 = [],
		pos_2 = [],
		pos_3 = [],
		pos_4 = [],
		pos_5 = [],
		pos_6 = [1],
		pos_7 = [2],
		pos_8 = [3],
		pos_9 = [4],
		pos_10 = [5]
};

get(2) ->
	#splash_pattern{
		no = 2,
		pos_1 = [random],
		pos_2 = [random],
		pos_3 = [random],
		pos_4 = [random],
		pos_5 = [random],
		pos_6 = [random],
		pos_7 = [random],
		pos_8 = [random],
		pos_9 = [random],
		pos_10 = [random]
};

get(_No) ->
				?WARNING_MSG("Cannot get ~p", [_No]),
          null.

