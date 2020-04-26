%%%---------------------------------------
%%% @Module  : data_newyear_banquet
%%% @Author  : liufang
%%% @Email   : 529132738@qq.com
%%% @Description:  年夜宴会
%%%---------------------------------------


-module(data_newyear_banquet).
-include("common.hrl").
-include("record.hrl").
-include("newyear_banquet.hrl").
-compile(export_all).


				get(1) ->
	#newyear_dishes{
		type = 1,
		dish_limit = 40,
		exp_add = 10,
		name = <<"粗茶淡饭">>,
		need_gamemoney = 100000,
		need_yuanbao = 0,
		special_goods = 0,
		normal_goods = [{60228,20,0,3}]}
			;

				get(2) ->
	#newyear_dishes{
		type = 2,
		dish_limit = 30,
		exp_add = 30,
		name = <<"大鱼大肉">>,
		need_gamemoney = 0,
		need_yuanbao = 188,
		special_goods = [{20004,15},{0,85}],
		normal_goods = [{60291,1,0,2},{70094,1,0,3},{70096,1,0,3}]}
			;

				get(3) ->
	#newyear_dishes{
		type = 3,
		dish_limit = 12,
		exp_add = 50,
		name = <<"鲍参翅肚">>,
		need_gamemoney = 0,
		need_yuanbao = 688,
		special_goods = [{20005,20},{0,80}],
		normal_goods = [{50399,1,0,2},{70099,1,0,3}]}
			;

				get(_) ->
	      ?ASSERT(false),
          null.

		



				config(1) ->
	#newyear_banquet_lv{
		banquet_lv = 1,
		banquet_exp = 0,
		banquet_exp_limit = {1800,3,4},
		buff_no = 0,
		banquet_player_exp = 100,
		banquet_player_gamemoney = 100,
		banquet_player_item = [{80071,80,3}],
		banquet_even = [{2,30},{0,70}],
		npc = {6107,48,17}}
			;

				config(2) ->
	#newyear_banquet_lv{
		banquet_lv = 2,
		banquet_exp = 2000,
		banquet_exp_limit = {3800,3,8},
		buff_no = 0,
		banquet_player_exp = 120,
		banquet_player_gamemoney = 108,
		banquet_player_item = [{80072,80,3}],
		banquet_even = [{2,30},{3,10},{0,60}],
		npc = {6105,48,17}}
			;

				config(3) ->
	#newyear_banquet_lv{
		banquet_lv = 3,
		banquet_exp = 4200,
		banquet_exp_limit = {6600,3,8},
		buff_no = 0,
		banquet_player_exp = 140,
		banquet_player_gamemoney = 116,
		banquet_player_item = [{80073,81,3}],
		banquet_even = [{2,30},{3,10},{5,10},{0,50}],
		npc = {6104,48,17}}
			;

				config(4) ->
	#newyear_banquet_lv{
		banquet_lv = 4,
		banquet_exp = 7000,
		banquet_exp_limit = {11000, 3,8},
		buff_no = 0,
		banquet_player_exp = 180,
		banquet_player_gamemoney = 133,
		banquet_player_item = [{80074,82,3}],
		banquet_even = [{2,30},{3,10},{5,10},{7,10},{0,40}],
		npc = {6106,48,17}}
			;

				config(5) ->
	#newyear_banquet_lv{
		banquet_lv = 5,
		banquet_exp = 11400,
		banquet_exp_limit = {29999, 3,50},
		buff_no = 0,
		banquet_player_exp = 213,
		banquet_player_gamemoney = 166,
		banquet_player_item = [{80075,83,3}],
		banquet_even = [{2,30},{3,10},{5,10},{7,10},{10,10},{0,30}],
		npc = {6108,48,17}}
			;

				config(6) ->
	#newyear_banquet_lv{
		banquet_lv = 6,
		banquet_exp = 20000,
		banquet_exp_limit = {39999, 3,50},
		buff_no = 0,
		banquet_player_exp = 213,
		banquet_player_gamemoney = 166,
		banquet_player_item = [{80071,80,3}],
		banquet_even = [{2,30},{0,70}],
		npc = {6108,48,17}}
			;

				config(_) ->
	      ?ASSERT(false),
          null.

		
