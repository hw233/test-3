%%%---------------------------------------
%%% @Module  : data_monopoly_event
%%% @Author  : 
%%% @Email   : 
%%% @Description:  大富翁随机事件配置表
%%%---------------------------------------


-module(data_monopoly_event).

-include("monopoly.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#monopoly_event{
		no = 1,
		event = [nocontrol,1]
};

get(2) ->
	#monopoly_event{
		no = 2,
		event = [freecontrol,1]
};

get(3) ->
	#monopoly_event{
		no = 3,
		event = [battle,[mon,800559]]
};

get(4) ->
	#monopoly_event{
		no = 4,
		event = [battle,[mon,800560]]
};

get(5) ->
	#monopoly_event{
		no = 5,
		event = [battle,[mon,800561]]
};

get(6) ->
	#monopoly_event{
		no = 6,
		event = [battle,[mon,800562]]
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

