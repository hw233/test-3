%%%---------------------------------------
%%% @Module  : data_sworn_attr_add
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  结拜关系属性加成
%%%---------------------------------------


-module(data_sworn_attr_add).
-include("common.hrl").
-include("record.hrl").
-include("relation.hrl").
-compile(export_all).

get(1) ->
	#sworn_attr_add{
		type = 1,
		add_attrs_2 = [{be_heal_eff_coef,0.1,0},{hp_lim, 0, 0.05}],
		add_attrs_3 = [{be_heal_eff_coef,0.15,0},{hp_lim, 0, 0.07}],
		add_attrs_4 = [{be_heal_eff_coef,0.2,0},{hp_lim, 0, 0.1}],
		add_attrs_5 = [{be_heal_eff_coef,0.25,0},{hp_lim, 0, 0.12}],
		reward_no = 0
};

get(2) ->
	#sworn_attr_add{
		type = 2,
		add_attrs_2 = [{be_heal_eff_coef,0.1,0},{hp_lim, 0, 0.05},{seal_resis,0,0.03}],
		add_attrs_3 = [{be_heal_eff_coef,0.15,0},{hp_lim, 0, 0.07},{seal_resis,0,0.04}],
		add_attrs_4 = [{be_heal_eff_coef,0.2,0},{hp_lim, 0, 0.1},{seal_resis,0,0.05}],
		add_attrs_5 = [{be_heal_eff_coef,0.25,0},{hp_lim, 0, 0.12},{seal_resis,0,0.06}],
		reward_no = 0
};

get(_Type) ->
          null.

