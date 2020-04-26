%%%---------------------------------------
%%% @Module  : data_partner_mood
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 宠物心情
%%%---------------------------------------


-module(data_partner_mood).
-compile(export_all).

-include("partner.hrl").
-include("debug.hrl").

get_all_mood_no_list()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16].

get(1) ->
	#mood_cfg{
		no = 1,
		buff_no_list = [10501],
		weight = 15
};

get(2) ->
	#mood_cfg{
		no = 2,
		buff_no_list = [10501],
		weight = 15
};

get(3) ->
	#mood_cfg{
		no = 3,
		buff_no_list = [10501],
		weight = 15
};

get(4) ->
	#mood_cfg{
		no = 4,
		buff_no_list = [10501],
		weight = 15
};

get(5) ->
	#mood_cfg{
		no = 5,
		buff_no_list = [10501],
		weight = 6
};

get(6) ->
	#mood_cfg{
		no = 6,
		buff_no_list = [10501],
		weight = 6
};

get(7) ->
	#mood_cfg{
		no = 7,
		buff_no_list = [10501],
		weight = 6
};

get(8) ->
	#mood_cfg{
		no = 8,
		buff_no_list = [10501],
		weight = 6
};

get(9) ->
	#mood_cfg{
		no = 9,
		buff_no_list = [10501],
		weight = 3
};

get(10) ->
	#mood_cfg{
		no = 10,
		buff_no_list = [10501],
		weight = 3
};

get(11) ->
	#mood_cfg{
		no = 11,
		buff_no_list = [10501],
		weight = 3
};

get(12) ->
	#mood_cfg{
		no = 12,
		buff_no_list = [10501],
		weight = 3
};

get(13) ->
	#mood_cfg{
		no = 13,
		buff_no_list = [10501],
		weight = 1
};

get(14) ->
	#mood_cfg{
		no = 14,
		buff_no_list = [10501],
		weight = 1
};

get(15) ->
	#mood_cfg{
		no = 15,
		buff_no_list = [10501],
		weight = 1
};

get(16) ->
	#mood_cfg{
		no = 16,
		buff_no_list = [10501],
		weight = 1
};

get(_No) ->
	?ASSERT(false, _No),
    null.

