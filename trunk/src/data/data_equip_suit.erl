%%%---------------------------------------
%%% @Module  : data_equip_suit
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 装备套装
%%%---------------------------------------


-module(data_equip_suit).
-export([
        get_all_lv/0,
        get/1
    ]).

-include("record/goods_record.hrl").
-include("debug.hrl").

get_all_lv()->
	[0,6,10,15,17,20].

get(0) ->
	#equip_suit{
		no = 1,
		lv = 0,
		hp_lim_rate = 0,
		mp_lim_rate = 0,
		phy_att_rate = 0,
		mag_att_rate = 0,
		phy_def_rate = 0,
		mag_def_rate = 0
};

get(6) ->
	#equip_suit{
		no = 2,
		lv = 6,
		hp_lim_rate = 0,
		mp_lim_rate = 0,
		phy_att_rate = 0,
		mag_att_rate = 0,
		phy_def_rate = 0,
		mag_def_rate = 0
};

get(10) ->
	#equip_suit{
		no = 3,
		lv = 10,
		hp_lim_rate = 0,
		mp_lim_rate = 0,
		phy_att_rate = 0,
		mag_att_rate = 0,
		phy_def_rate = 0,
		mag_def_rate = 0
};

get(15) ->
	#equip_suit{
		no = 4,
		lv = 15,
		hp_lim_rate = 0,
		mp_lim_rate = 0,
		phy_att_rate = 0,
		mag_att_rate = 0,
		phy_def_rate = 0,
		mag_def_rate = 0
};

get(17) ->
	#equip_suit{
		no = 5,
		lv = 17,
		hp_lim_rate = 0,
		mp_lim_rate = 0,
		phy_att_rate = 0,
		mag_att_rate = 0,
		phy_def_rate = 0,
		mag_def_rate = 0
};

get(20) ->
	#equip_suit{
		no = 6,
		lv = 20,
		hp_lim_rate = 0,
		mp_lim_rate = 0,
		phy_att_rate = 0,
		mag_att_rate = 0,
		phy_def_rate = 0,
		mag_def_rate = 0
};

get(_Lv) ->
	?ASSERT(false, _Lv),
    null.

