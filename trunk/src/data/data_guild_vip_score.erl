%%%---------------------------------------
%%% @Module  : data_guild_vip_score
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  山寨战力vip等级评分
%%%---------------------------------------


-module(data_guild_vip_score).
-include("record/guild_record.hrl").
-include("debug.hrl").
-compile(export_all).

get(0) ->
	#guild_vip_score{
		vip_lv = 0,
		score = 0
};

get(1) ->
	#guild_vip_score{
		vip_lv = 1,
		score = 50
};

get(2) ->
	#guild_vip_score{
		vip_lv = 2,
		score = 100
};

get(3) ->
	#guild_vip_score{
		vip_lv = 3,
		score = 150
};

get(4) ->
	#guild_vip_score{
		vip_lv = 4,
		score = 200
};

get(5) ->
	#guild_vip_score{
		vip_lv = 5,
		score = 250
};

get(6) ->
	#guild_vip_score{
		vip_lv = 6,
		score = 300
};

get(7) ->
	#guild_vip_score{
		vip_lv = 7,
		score = 350
};

get(8) ->
	#guild_vip_score{
		vip_lv = 8,
		score = 400
};

get(9) ->
	#guild_vip_score{
		vip_lv = 9,
		score = 450
};

get(10) ->
	#guild_vip_score{
		vip_lv = 10,
		score = 500
};

get(11) ->
	#guild_vip_score{
		vip_lv = 11,
		score = 550
};

get(12) ->
	#guild_vip_score{
		vip_lv = 12,
		score = 600
};

get(13) ->
	#guild_vip_score{
		vip_lv = 13,
		score = 650
};

get(14) ->
	#guild_vip_score{
		vip_lv = 14,
		score = 700
};

get(15) ->
	#guild_vip_score{
		vip_lv = 15,
		score = 750
};

get(16) ->
	#guild_vip_score{
		vip_lv = 16,
		score = 800
};

get(17) ->
	#guild_vip_score{
		vip_lv = 17,
		score = 850
};

get(_VipLv) ->
	?ASSERT(false, _VipLv),
	null.

