%%%---------------------------------------
%%% @Module  : data_guild_dishes
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 山寨加菜
%%%---------------------------------------


-module(data_guild_dishes).
-export([
        get/1
    ]).

-include("record/guild_record.hrl").
-include("debug.hrl").

get(1) ->
	#guild_dishes{
		no = 1,
		buff_no = 20001,
		broadcast_id = 0,
		reward_id = 0,
		exp_add = {1,400},
		gamemoney_add = {1,400},
		need_yuanbao = 0,
		vip_lv = 0,
		npc = {6100,92,39}
};

get(2) ->
	#guild_dishes{
		no = 2,
		buff_no = 20002,
		broadcast_id = 273,
		reward_id = 0,
		exp_add = 3,
		gamemoney_add = 8,
		need_yuanbao = 10,
		vip_lv = 0,
		npc = {6101,80,41}
};

get(3) ->
	#guild_dishes{
		no = 3,
		buff_no = 20012,
		broadcast_id = 274,
		reward_id = 0,
		exp_add = 4,
		gamemoney_add = 15,
		need_yuanbao = 58,
		vip_lv = 0,
		npc = {6101,82,42}
};

get(4) ->
	#guild_dishes{
		no = 4,
		buff_no = 20013,
		broadcast_id = 275,
		reward_id = 0,
		exp_add = 5,
		gamemoney_add = 25,
		need_yuanbao = 130,
		vip_lv = 0,
		npc = {6101,83,43}
};

get(5) ->
	#guild_dishes{
		no = 5,
		buff_no = 20014,
		broadcast_id = 276,
		reward_id = 0,
		exp_add = 6,
		gamemoney_add = 40,
		need_yuanbao = 202,
		vip_lv = 0,
		npc = {6101,85,44}
};

get(6) ->
	#guild_dishes{
		no = 6,
		buff_no = 20003,
		broadcast_id = 277,
		reward_id = 0,
		exp_add = 7,
		gamemoney_add = 60,
		need_yuanbao = 322,
		vip_lv = 0,
		npc = {6102,79,35}
};

get(7) ->
	#guild_dishes{
		no = 7,
		buff_no = 20015,
		broadcast_id = 278,
		reward_id = 0,
		exp_add = 8,
		gamemoney_add = 80,
		need_yuanbao = 442,
		vip_lv = 0,
		npc = {6102,80,34}
};

get(8) ->
	#guild_dishes{
		no = 8,
		buff_no = 20016,
		broadcast_id = 279,
		reward_id = 0,
		exp_add = 9,
		gamemoney_add = 120,
		need_yuanbao = 682,
		vip_lv = 0,
		npc = {6102,82,33}
};

get(9) ->
	#guild_dishes{
		no = 9,
		buff_no = 20017,
		broadcast_id = 280,
		reward_id = 0,
		exp_add = 10,
		gamemoney_add = 160,
		need_yuanbao = 922,
		vip_lv = 0,
		npc = {6102,84,32}
};

get(10) ->
	#guild_dishes{
		no = 10,
		buff_no = 20004,
		broadcast_id = 281,
		reward_id = 0,
		exp_add = 11,
		gamemoney_add = 250,
		need_yuanbao = 1402,
		vip_lv = 0,
		npc = {6103,104,41}
};

get(11) ->
	#guild_dishes{
		no = 11,
		buff_no = 20018,
		broadcast_id = 282,
		reward_id = 0,
		exp_add = 12,
		gamemoney_add = 500,
		need_yuanbao = 2842,
		vip_lv = 0,
		npc = {6103,102,42}
};

get(12) ->
	#guild_dishes{
		no = 12,
		buff_no = 20019,
		broadcast_id = 283,
		reward_id = 0,
		exp_add = 13,
		gamemoney_add = 1000,
		need_yuanbao = 5722,
		vip_lv = 0,
		npc = {6103,100,43}
};

get(13) ->
	#guild_dishes{
		no = 13,
		buff_no = 20020,
		broadcast_id = 284,
		reward_id = 0,
		exp_add = 14,
		gamemoney_add = 1500,
		need_yuanbao = 8602,
		vip_lv = 0,
		npc = {6103,98,45}
};

get(_No) ->
  ?ASSERT(false, _No),
    null.

