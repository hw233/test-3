%%%---------------------------------------
%%% @Module  : data_race_FOR_QUDAO_TEST
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  种族信息（仅用于渠道体验服）
%%%---------------------------------------


-module(data_race_FOR_QUDAO_TEST).
-export([get/2]).
-include("common.hrl").
-include("record.hrl").

get(1,1) ->
	#race{
		no = 1,
		sex = 1,
		inborn_goods = [{4101,1},{50262,1},{50256,1},{60118,1}],
		inborn_money = [{2,10000}]
};

get(1,2) ->
	#race{
		no = 1,
		sex = 2,
		inborn_goods = [{4151,1},{50262,1},{50256,1},{60118,1}],
		inborn_money = [{2,10000}]
};

get(2,1) ->
	#race{
		no = 2,
		sex = 1,
		inborn_goods = [{4201,1},{50262,1},{50256,1},{60118,1}],
		inborn_money = [{2,10000}]
};

get(2,2) ->
	#race{
		no = 2,
		sex = 2,
		inborn_goods = [{4251,1},{50262,1},{50256,1},{60118,1}],
		inborn_money = [{2,10000}]
};

get(3,1) ->
	#race{
		no = 3,
		sex = 1,
		inborn_goods = [{4301,1},{50262,1},{50256,1},{60118,1}],
		inborn_money = [{2,10000}]
};

get(3,2) ->
	#race{
		no = 3,
		sex = 2,
		inborn_goods = [{4351,1},{50262,1},{50256,1},{60118,1}],
		inborn_money = [{2,10000}]
};

get(_Race, _Sex) ->
	      ?ASSERT(false, {_Race, _Sex}),
          null.

