%%%---------------------------------------
%%% @Module  : data_guild_cultivate_learn_config
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  帮派点修等级配置表
%%%---------------------------------------


-module(data_guild_cultivate_learn_config).
-include("common.hrl").
-include("record.hrl").
-include("record/guild_record.hrl").
-compile(export_all).

get(1) ->
	#guild_cultivate_learn_cfg{
		no = 1,
		goods_no = 60101,
		type = 1,
		cons_ratio = 1.500000,
		include_attrs = [do_phy_dam_scaling,do_mag_dam_scaling,seal_hit]
};

get(2) ->
	#guild_cultivate_learn_cfg{
		no = 2,
		goods_no = 60101,
		type = 1,
		cons_ratio = 1,
		include_attrs = [be_phy_dam_reduce_coef]
};

get(3) ->
	#guild_cultivate_learn_cfg{
		no = 3,
		goods_no = 60101,
		type = 1,
		cons_ratio = 1,
		include_attrs = [be_mag_dam_reduce_coef]
};

get(4) ->
	#guild_cultivate_learn_cfg{
		no = 4,
		goods_no = 60101,
		type = 1,
		cons_ratio = 1,
		include_attrs = [seal_resis]
};

get(5) ->
	#guild_cultivate_learn_cfg{
		no = 5,
		goods_no = 62032,
		type = 2,
		cons_ratio = 1.500000,
		include_attrs = [do_phy_dam_scaling,do_mag_dam_scaling,seal_hit]
};

get(6) ->
	#guild_cultivate_learn_cfg{
		no = 6,
		goods_no = 62032,
		type = 2,
		cons_ratio = 1,
		include_attrs = [be_phy_dam_reduce_coef]
};

get(7) ->
	#guild_cultivate_learn_cfg{
		no = 7,
		goods_no = 62032,
		type = 2,
		cons_ratio = 1,
		include_attrs = [be_mag_dam_reduce_coef]
};

get(8) ->
	#guild_cultivate_learn_cfg{
		no = 8,
		goods_no = 62032,
		type = 2,
		cons_ratio = 1,
		include_attrs = [seal_resis]
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

