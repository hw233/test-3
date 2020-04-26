%%%---------------------------------------
%%% @Module  : data_slotmachine
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  老虎机
%%%---------------------------------------


-module(data_slotmachine).

-include("slotmachine.hrl").
-include("debug.hrl").
-compile(export_all).

get_all_config_no_list()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24].

get(1) ->
	#slotmachine_config{
		no = 1,
		class = 1,
		odds = 0,
		widget = 0,
		type = 2,
		name = luck
};

get(2) ->
	#slotmachine_config{
		no = 2,
		class = 1,
		odds = 0,
		widget = 0,
		type = 1,
		name = luck
};

get(3) ->
	#slotmachine_config{
		no = 3,
		class = 2,
		odds = 40,
		widget = 90,
		type = 2,
		name = <<"钻石">>
};

get(4) ->
	#slotmachine_config{
		no = 4,
		class = 2,
		odds = 10,
		widget = 240,
		type = 1,
		name = <<"钻石">>
};

get(5) ->
	#slotmachine_config{
		no = 5,
		class = 3,
		odds = 20,
		widget = 300,
		type = 2,
		name = <<"黄金">>
};

get(6) ->
	#slotmachine_config{
		no = 6,
		class = 3,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"黄金">>
};

get(7) ->
	#slotmachine_config{
		no = 7,
		class = 4,
		odds = 20,
		widget = 300,
		type = 2,
		name = <<"白银">>
};

get(8) ->
	#slotmachine_config{
		no = 8,
		class = 4,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"白银">>
};

get(9) ->
	#slotmachine_config{
		no = 9,
		class = 5,
		odds = 20,
		widget = 300,
		type = 2,
		name = <<"丝绸">>
};

get(10) ->
	#slotmachine_config{
		no = 10,
		class = 5,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"丝绸">>
};

get(11) ->
	#slotmachine_config{
		no = 11,
		class = 6,
		odds = 5,
		widget = 700,
		type = 2,
		name = <<"花生">>
};

get(12) ->
	#slotmachine_config{
		no = 12,
		class = 6,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"花生">>
};

get(13) ->
	#slotmachine_config{
		no = 13,
		class = 6,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"花生">>
};

get(14) ->
	#slotmachine_config{
		no = 14,
		class = 7,
		odds = 5,
		widget = 700,
		type = 2,
		name = <<"小麦">>
};

get(15) ->
	#slotmachine_config{
		no = 15,
		class = 7,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"小麦">>
};

get(16) ->
	#slotmachine_config{
		no = 16,
		class = 7,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"小麦">>
};

get(17) ->
	#slotmachine_config{
		no = 17,
		class = 8,
		odds = 5,
		widget = 700,
		type = 2,
		name = <<"大豆">>
};

get(18) ->
	#slotmachine_config{
		no = 18,
		class = 8,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"大豆">>
};

get(19) ->
	#slotmachine_config{
		no = 19,
		class = 8,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"大豆">>
};

get(20) ->
	#slotmachine_config{
		no = 20,
		class = 9,
		odds = 5,
		widget = 600,
		type = 2,
		name = <<"玉米">>
};

get(21) ->
	#slotmachine_config{
		no = 21,
		class = 9,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"玉米">>
};

get(22) ->
	#slotmachine_config{
		no = 22,
		class = 9,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"玉米">>
};

get(23) ->
	#slotmachine_config{
		no = 23,
		class = 9,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"玉米">>
};

get(24) ->
	#slotmachine_config{
		no = 24,
		class = 9,
		odds = 3,
		widget = 400,
		type = 1,
		name = <<"玉米">>
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

