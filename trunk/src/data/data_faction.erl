%%%---------------------------------------
%%% @Module  : data_faction
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  门派基本信息
%%%---------------------------------------


-module(data_faction).
-include("faction.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#faction_base{
		faction = 1,
		sex_limit = 1,
		scene_no = 1102,
		skills = [{202, 1},
{201, 1},
{203, 30},
{204, 50},
{205, 100}],
		init_attr = 1000,
		recommand_point = [1,0,4,0,0],
		five_elements = 3,
		race_limit = 1,
		master_xinfa = 1,
		xinfa_list = [1,2,3]
};

get(2) ->
	#faction_base{
		faction = 2,
		sex_limit = 2,
		scene_no = 2102,
		skills = [{302, 1},
{301, 1},
{303, 30},
{304, 50},
{305, 100}],
		init_attr = 1001,
		recommand_point = [0,5,0,0,0],
		five_elements = 1,
		race_limit = 1,
		master_xinfa = 6,
		xinfa_list = [6,7,8]
};

get(3) ->
	#faction_base{
		faction = 3,
		sex_limit = 1,
		scene_no = 3102,
		skills = [{402, 1},
{401, 1},
{403, 30},
{404, 50},
{405, 100}],
		init_attr = 1002,
		recommand_point = [1,0,3,0,1],
		five_elements = 4,
		race_limit = 2,
		master_xinfa = 16,
		xinfa_list = [16,17,18]
};

get(4) ->
	#faction_base{
		faction = 4,
		sex_limit = 2,
		scene_no = 4102,
		skills = [{502, 1},
{501, 1},
{503, 30},
{504, 50},
{505, 100}],
		init_attr = 1003,
		recommand_point = [1,3,0,1,0],
		five_elements = 6,
		race_limit = 2,
		master_xinfa = 11,
		xinfa_list = [11,12,13]
};

get(_Faction) ->
	      ?ASSERT(false, _Faction),
          null.

