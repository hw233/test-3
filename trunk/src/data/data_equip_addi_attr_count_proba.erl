%%%---------------------------------------
%%% @Module  : data_equip_addi_attr_count_proba
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  装备具有附加属性加成的条数的概率，
%%%---------------------------------------


-module(data_equip_addi_attr_count_proba).
-include("common.hrl").
-include("record/goods_record.hrl").
-compile(export_all).

get(1) ->
	#eqp_addi_attr_count_proba{
		quality = 1,
		proba_no_addi_attrs = 1,
		proba_one_addi_attrs = 0,
		proba_two_addi_attrs = 0,
		proba_three_addi_attrs = 0,
		proba_four_addi_attrs = 0,
		proba_five_addi_attrs = 0
};

get(2) ->
	#eqp_addi_attr_count_proba{
		quality = 2,
		proba_no_addi_attrs = 0,
		proba_one_addi_attrs = 1,
		proba_two_addi_attrs = 0,
		proba_three_addi_attrs = 0,
		proba_four_addi_attrs = 0,
		proba_five_addi_attrs = 0
};

get(3) ->
	#eqp_addi_attr_count_proba{
		quality = 3,
		proba_no_addi_attrs = 0,
		proba_one_addi_attrs = 0,
		proba_two_addi_attrs = 1,
		proba_three_addi_attrs = 0,
		proba_four_addi_attrs = 0,
		proba_five_addi_attrs = 0
};

get(4) ->
	#eqp_addi_attr_count_proba{
		quality = 4,
		proba_no_addi_attrs = 0,
		proba_one_addi_attrs = 0,
		proba_two_addi_attrs = 0,
		proba_three_addi_attrs = 1,
		proba_four_addi_attrs = 0,
		proba_five_addi_attrs = 0
};

get(5) ->
	#eqp_addi_attr_count_proba{
		quality = 5,
		proba_no_addi_attrs = 0,
		proba_one_addi_attrs = 0,
		proba_two_addi_attrs = 0,
		proba_three_addi_attrs = 0,
		proba_four_addi_attrs = 1,
		proba_five_addi_attrs = 0
};

get(6) ->
	#eqp_addi_attr_count_proba{
		quality = 6,
		proba_no_addi_attrs = 0,
		proba_one_addi_attrs = 0,
		proba_two_addi_attrs = 0,
		proba_three_addi_attrs = 0,
		proba_four_addi_attrs = 0,
		proba_five_addi_attrs = 1
};

get(_Quality) ->
	      ?ASSERT(false, _Quality),
          null.

