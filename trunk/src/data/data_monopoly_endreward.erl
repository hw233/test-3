%%%---------------------------------------
%%% @Module  : data_monopoly_endreward
%%% @Author  : 
%%% @Email   : 
%%% @Description:  大富翁终点奖励配置表
%%%---------------------------------------


-module(data_monopoly_endreward).

-include("monopoly.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#monopoly_endreward{
		no = 1,
		reward = 62569
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

