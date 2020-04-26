%%%---------------------------------------
%%% @Module  : data_xinfa
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 心法配置数据
%%%---------------------------------------


-module(data_xinfa).
-export([get/1]).
-include("xinfa.hrl").
-include("debug.hrl").

get(1) ->
	#xinfa{
		id = 1,
		name = <<"归元心法">>,
		is_master = 1,
		faction = 1,
		unlock_lv = 0,
		add_attrs = [mag_def],
		skill1 = 1,
		skill1_unlock_lv = 1,
		skill2 = 4,
		skill2_unlock_lv = 30,
		skill3 = 7,
		skill3_unlock_lv = 60
};

get(2) ->
	#xinfa{
		id = 2,
		name = <<"迷乱心智">>,
		is_master = 0,
		faction = 1,
		unlock_lv = 5,
		add_attrs = [phy_def],
		skill1 = 2,
		skill1_unlock_lv = 10,
		skill2 = 5,
		skill2_unlock_lv = 40,
		skill3 = 0,
		skill3_unlock_lv = 0
};

get(3) ->
	#xinfa{
		id = 3,
		name = <<"明性修身">>,
		is_master = 0,
		faction = 1,
		unlock_lv = 10,
		add_attrs = [hp_lim],
		skill1 = 3,
		skill1_unlock_lv = 20,
		skill2 = 6,
		skill2_unlock_lv = 50,
		skill3 = 0,
		skill3_unlock_lv = 0
};

get(6) ->
	#xinfa{
		id = 6,
		name = <<"为兵之道">>,
		is_master = 1,
		faction = 2,
		unlock_lv = 0,
		add_attrs = [phy_att],
		skill1 = 11,
		skill1_unlock_lv = 1,
		skill2 = 14,
		skill2_unlock_lv = 30,
		skill3 = 17,
		skill3_unlock_lv = 60
};

get(7) ->
	#xinfa{
		id = 7,
		name = <<"十方无敌">>,
		is_master = 0,
		faction = 2,
		unlock_lv = 5,
		add_attrs = [phy_def],
		skill1 = 12,
		skill1_unlock_lv = 10,
		skill2 = 15,
		skill2_unlock_lv = 40,
		skill3 = 0,
		skill3_unlock_lv = 0
};

get(8) ->
	#xinfa{
		id = 8,
		name = <<"文韬武略">>,
		is_master = 0,
		faction = 2,
		unlock_lv = 10,
		add_attrs = [mag_def],
		skill1 = 16,
		skill1_unlock_lv = 20,
		skill2 = 13,
		skill2_unlock_lv = 50,
		skill3 = 0,
		skill3_unlock_lv = 0
};

get(11) ->
	#xinfa{
		id = 11,
		name = <<"阴阳术">>,
		is_master = 1,
		faction = 4,
		unlock_lv = 0,
		add_attrs = [mag_att],
		skill1 = 21,
		skill1_unlock_lv = 1,
		skill2 = 24,
		skill2_unlock_lv = 30,
		skill3 = 27,
		skill3_unlock_lv = 60
};

get(12) ->
	#xinfa{
		id = 12,
		name = <<"六道轮回">>,
		is_master = 0,
		faction = 4,
		unlock_lv = 5,
		add_attrs = [phy_def],
		skill1 = 25,
		skill1_unlock_lv = 10,
		skill2 = 22,
		skill2_unlock_lv = 40,
		skill3 = 0,
		skill3_unlock_lv = 0
};

get(13) ->
	#xinfa{
		id = 13,
		name = <<"九幽阴魂">>,
		is_master = 0,
		faction = 4,
		unlock_lv = 10,
		add_attrs = [mag_def],
		skill1 = 23,
		skill1_unlock_lv = 20,
		skill2 = 26,
		skill2_unlock_lv = 50,
		skill3 = 0,
		skill3_unlock_lv = 0
};

get(16) ->
	#xinfa{
		id = 16,
		name = <<"天生神功">>,
		is_master = 1,
		faction = 3,
		unlock_lv = 0,
		add_attrs = [phy_att],
		skill1 = 31,
		skill1_unlock_lv = 1,
		skill2 = 34,
		skill2_unlock_lv = 30,
		skill3 = 37,
		skill3_unlock_lv = 60
};

get(17) ->
	#xinfa{
		id = 17,
		name = <<"力大无穷">>,
		is_master = 0,
		faction = 3,
		unlock_lv = 5,
		add_attrs = [mag_def],
		skill1 = 32,
		skill1_unlock_lv = 10,
		skill2 = 35,
		skill2_unlock_lv = 40,
		skill3 = 0,
		skill3_unlock_lv = 0
};

get(18) ->
	#xinfa{
		id = 18,
		name = <<"怒火中烧">>,
		is_master = 0,
		faction = 3,
		unlock_lv = 10,
		add_attrs = [phy_def],
		skill1 = 33,
		skill1_unlock_lv = 20,
		skill2 = 36,
		skill2_unlock_lv = 50,
		skill3 = 0,
		skill3_unlock_lv = 0
};

get(21) ->
	#xinfa{
		id = 21,
		name = <<"九雷诀">>,
		is_master = 1,
		faction = 5,
		unlock_lv = 0,
		add_attrs = [mag_att],
		skill1 = 41,
		skill1_unlock_lv = 1,
		skill2 = 44,
		skill2_unlock_lv = 30,
		skill3 = 47,
		skill3_unlock_lv = 60
};

get(22) ->
	#xinfa{
		id = 22,
		name = <<"两仪四象">>,
		is_master = 0,
		faction = 5,
		unlock_lv = 5,
		add_attrs = [mag_def],
		skill1 = 42,
		skill1_unlock_lv = 10,
		skill2 = 45,
		skill2_unlock_lv = 40,
		skill3 = 0,
		skill3_unlock_lv = 0
};

get(23) ->
	#xinfa{
		id = 23,
		name = <<"白虹贯日">>,
		is_master = 0,
		faction = 5,
		unlock_lv = 10,
		add_attrs = [mp_lim],
		skill1 = 43,
		skill1_unlock_lv = 20,
		skill2 = 46,
		skill2_unlock_lv = 50,
		skill3 = 0,
		skill3_unlock_lv = 0
};

get(26) ->
	#xinfa{
		id = 26,
		name = <<"凝神静气">>,
		is_master = 1,
		faction = 6,
		unlock_lv = 0,
		add_attrs = [phy_def],
		skill1 = 51,
		skill1_unlock_lv = 1,
		skill2 = 54,
		skill2_unlock_lv = 30,
		skill3 = 57,
		skill3_unlock_lv = 60
};

get(27) ->
	#xinfa{
		id = 27,
		name = <<"万物轮转">>,
		is_master = 0,
		faction = 6,
		unlock_lv = 5,
		add_attrs = [hp_lim],
		skill1 = 53,
		skill1_unlock_lv = 10,
		skill2 = 55,
		skill2_unlock_lv = 40,
		skill3 = 0,
		skill3_unlock_lv = 0
};

get(28) ->
	#xinfa{
		id = 28,
		name = <<"起死回生">>,
		is_master = 0,
		faction = 6,
		unlock_lv = 10,
		add_attrs = [mag_def],
		skill1 = 52,
		skill1_unlock_lv = 20,
		skill2 = 56,
		skill2_unlock_lv = 50,
		skill3 = 0,
		skill3_unlock_lv = 0
};

get(_Id) ->
	      ?ASSERT(false, _Id),
          null.

