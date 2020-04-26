%%%---------------------------------------
%%% @Module  : data_intimacy_lv_relate
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  宠物亲密度等级相关
%%%---------------------------------------


-module(data_intimacy_lv_relate).
-include("partner.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 1,
		lv = 1,
		consume_life = 50,
		battle_num = 3,
		consume_loyalty_die = 20,
		intimacy_lim = 50,
		inborn_skill_num = 4
};

get(2) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 2,
		lv = 20,
		consume_life = 48,
		battle_num = 3,
		consume_loyalty_die = 20,
		intimacy_lim = 102,
		inborn_skill_num = 5
};

get(3) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 3,
		lv = 20,
		consume_life = 46,
		battle_num = 3,
		consume_loyalty_die = 19,
		intimacy_lim = 105,
		inborn_skill_num = 6
};

get(4) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 4,
		lv = 30,
		consume_life = 44,
		battle_num = 3,
		consume_loyalty_die = 19,
		intimacy_lim = 113,
		inborn_skill_num = 7
};

get(5) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 5,
		lv = 30,
		consume_life = 42,
		battle_num = 4,
		consume_loyalty_die = 18,
		intimacy_lim = 125,
		inborn_skill_num = 8
};

get(6) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 6,
		lv = 40,
		consume_life = 40,
		battle_num = 4,
		consume_loyalty_die = 18,
		intimacy_lim = 143,
		inborn_skill_num = 9
};

get(7) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 7,
		lv = 40,
		consume_life = 38,
		battle_num = 4,
		consume_loyalty_die = 17,
		intimacy_lim = 169,
		inborn_skill_num = 10
};

get(8) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 8,
		lv = 50,
		consume_life = 36,
		battle_num = 4,
		consume_loyalty_die = 17,
		intimacy_lim = 202,
		inborn_skill_num = 11
};

get(9) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 9,
		lv = 50,
		consume_life = 34,
		battle_num = 5,
		consume_loyalty_die = 16,
		intimacy_lim = 246,
		inborn_skill_num = 12
};

get(10) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 10,
		lv = 60,
		consume_life = 32,
		battle_num = 5,
		consume_loyalty_die = 16,
		intimacy_lim = 300,
		inborn_skill_num = 13
};

get(11) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 11,
		lv = 60,
		consume_life = 30,
		battle_num = 5,
		consume_loyalty_die = 15,
		intimacy_lim = 366,
		inborn_skill_num = 14
};

get(12) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 12,
		lv = 70,
		consume_life = 28,
		battle_num = 5,
		consume_loyalty_die = 15,
		intimacy_lim = 446,
		inborn_skill_num = 15
};

get(13) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 13,
		lv = 70,
		consume_life = 26,
		battle_num = 6,
		consume_loyalty_die = 14,
		intimacy_lim = 539,
		inborn_skill_num = 16
};

get(14) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 14,
		lv = 80,
		consume_life = 24,
		battle_num = 6,
		consume_loyalty_die = 14,
		intimacy_lim = 649,
		inborn_skill_num = 17
};

get(15) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 15,
		lv = 80,
		consume_life = 22,
		battle_num = 6,
		consume_loyalty_die = 13,
		intimacy_lim = 775,
		inborn_skill_num = 18
};

get(16) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 16,
		lv = 90,
		consume_life = 20,
		battle_num = 7,
		consume_loyalty_die = 13,
		intimacy_lim = 919,
		inborn_skill_num = 19
};

get(17) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 17,
		lv = 90,
		consume_life = 18,
		battle_num = 7,
		consume_loyalty_die = 12,
		intimacy_lim = 1083,
		inborn_skill_num = 20
};

get(18) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 18,
		lv = 100,
		consume_life = 16,
		battle_num = 7,
		consume_loyalty_die = 12,
		intimacy_lim = 1266,
		inborn_skill_num = 21
};

get(19) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 19,
		lv = 100,
		consume_life = 14,
		battle_num = 8,
		consume_loyalty_die = 11,
		intimacy_lim = 1472,
		inborn_skill_num = 22
};

get(20) ->
	#intimacy_lv_relate_data{
		intimacy_lv = 20,
		lv = 110,
		consume_life = 12,
		battle_num = 8,
		consume_loyalty_die = 11,
		intimacy_lim = 1700,
		inborn_skill_num = 23
};

get(_IntimacyLv) ->
	      ?ASSERT(false, _IntimacyLv),
          null.

