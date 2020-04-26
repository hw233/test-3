%%%---------------------------------------
%%% @Module  : data_lv_break
%%% @Author  : liuzhongzheng
%%% @Email   : 
%%% @Description: 角色等级突破
%%%---------------------------------------


-module(data_lv_break).
-export([get_to_break_lv_list/0, get/1]).
-include("player.hrl").
-include("debug.hrl").

get_to_break_lv_list()->
	[19,29,39,49,59,69,79].

get(19) ->
	#lv_break{
		lv = 19,
		master_xinfa_lv_need = 15,
		slave_xinfa_lv_need = 10,
		reward_str = 0,
		reward_con = 0,
		reward_sta = 0,
		reward_spi = 0,
		reward_agi = 0
};

get(29) ->
	#lv_break{
		lv = 29,
		master_xinfa_lv_need = 25,
		slave_xinfa_lv_need = 20,
		reward_str = 0,
		reward_con = 0,
		reward_sta = 0,
		reward_spi = 0,
		reward_agi = 0
};

get(39) ->
	#lv_break{
		lv = 39,
		master_xinfa_lv_need = 35,
		slave_xinfa_lv_need = 30,
		reward_str = 0,
		reward_con = 0,
		reward_sta = 0,
		reward_spi = 0,
		reward_agi = 0
};

get(49) ->
	#lv_break{
		lv = 49,
		master_xinfa_lv_need = 45,
		slave_xinfa_lv_need = 40,
		reward_str = 0,
		reward_con = 0,
		reward_sta = 0,
		reward_spi = 0,
		reward_agi = 0
};

get(59) ->
	#lv_break{
		lv = 59,
		master_xinfa_lv_need = 55,
		slave_xinfa_lv_need = 50,
		reward_str = 0,
		reward_con = 0,
		reward_sta = 0,
		reward_spi = 0,
		reward_agi = 0
};

get(69) ->
	#lv_break{
		lv = 69,
		master_xinfa_lv_need = 65,
		slave_xinfa_lv_need = 60,
		reward_str = 0,
		reward_con = 0,
		reward_sta = 0,
		reward_spi = 0,
		reward_agi = 0
};

get(79) ->
	#lv_break{
		lv = 79,
		master_xinfa_lv_need = 75,
		slave_xinfa_lv_need = 70,
		reward_str = 0,
		reward_con = 0,
		reward_sta = 0,
		reward_spi = 0,
		reward_agi = 0
};

get(_Lv) ->
          null.

