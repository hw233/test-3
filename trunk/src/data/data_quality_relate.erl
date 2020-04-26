%%%---------------------------------------
%%% @Module  : data_quality_relate
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  宠物相关
%%%---------------------------------------


-module(data_quality_relate).
-include("common.hrl").
-include("record.hrl").
-include("partner.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#quality_relate_data{
		quality = 1,
		life = 1600,
		loyalty_max = 100,
		evolution_lv_max = 4,
		evolution_intimacy = 1,
		growth_value_region = [0.92,1],
		one_aptitude_region = [0.92,1],
		inborn_skill_num_region = [1,2],
		postnatal_skill_slot_region = [5,8],
		postnatal_skill_num_region = [1,4],
		wash_elixir_no = 50087,
		wash_elixir_count = 1,
		high_wash_elixir_no = 50366,
		high_wash_elixir_count = 1
};

get(2) ->
	#quality_relate_data{
		quality = 2,
		life = 2400,
		loyalty_max = 100,
		evolution_lv_max = 5,
		evolution_intimacy = 2,
		growth_value_region = [0.92,1],
		one_aptitude_region = [0.90,1],
		inborn_skill_num_region = [1,2],
		postnatal_skill_slot_region = [5,8],
		postnatal_skill_num_region = [1,4],
		wash_elixir_no = 50087,
		wash_elixir_count = 1,
		high_wash_elixir_no = 50366,
		high_wash_elixir_count = 1
};

get(3) ->
	#quality_relate_data{
		quality = 3,
		life = 3200,
		loyalty_max = 125,
		evolution_lv_max = 6,
		evolution_intimacy = 3,
		growth_value_region = [0.92,1],
		one_aptitude_region = [0.88,1],
		inborn_skill_num_region = [1,2],
		postnatal_skill_slot_region = [5,8],
		postnatal_skill_num_region = [1,4],
		wash_elixir_no = 50087,
		wash_elixir_count = 2,
		high_wash_elixir_no = 50366,
		high_wash_elixir_count = 2
};

get(4) ->
	#quality_relate_data{
		quality = 4,
		life = 4000,
		loyalty_max = 200,
		evolution_lv_max = 7,
		evolution_intimacy = 5,
		growth_value_region = [0.92,1],
		one_aptitude_region = [0.86,1],
		inborn_skill_num_region = [1,2],
		postnatal_skill_slot_region = [5,8],
		postnatal_skill_num_region = [2,4],
		wash_elixir_no = 50087,
		wash_elixir_count = 3,
		high_wash_elixir_no = 50366,
		high_wash_elixir_count = 2
};

get(5) ->
	#quality_relate_data{
		quality = 5,
		life = 4800,
		loyalty_max = 300,
		evolution_lv_max = 8,
		evolution_intimacy = 7,
		growth_value_region = [0.92,1],
		one_aptitude_region = [0.84,1],
		inborn_skill_num_region = [1,2],
		postnatal_skill_slot_region = [5,12],
		postnatal_skill_num_region = [2,4],
		wash_elixir_no = 50087,
		wash_elixir_count = 4,
		high_wash_elixir_no = 50366,
		high_wash_elixir_count = 3
};

get(6) ->
	#quality_relate_data{
		quality = 6,
		life = 5200,
		loyalty_max = 400,
		evolution_lv_max = 9,
		evolution_intimacy = 9,
		growth_value_region = [0.92,1],
		one_aptitude_region = [0.82,1],
		inborn_skill_num_region = [1,2],
		postnatal_skill_slot_region = [5,8],
		postnatal_skill_num_region = [2,4],
		wash_elixir_no = 50087,
		wash_elixir_count = 5,
		high_wash_elixir_no = 50366,
		high_wash_elixir_count = 4
};

get(_) ->
	      ?ASSERT(false),
          null.

