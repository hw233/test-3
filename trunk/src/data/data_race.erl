%%%---------------------------------------
%%% @Module  : data_race
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  种族信息
%%%---------------------------------------


-module(data_race).
-export([get/2]).
-include("common.hrl").
-include("record.hrl").

get(1,1) ->
	#race{
		no = 1,
		sex = 1,
		inborn_goods = [],
		inborn_money = [{10,200}]
};

get(1,2) ->
	#race{
		no = 1,
		sex = 2,
		inborn_goods = [],
		inborn_money = [{10,200}]
};

get(2,1) ->
	#race{
		no = 2,
		sex = 1,
		inborn_goods = [],
		inborn_money = [{10,200}]
};

get(2,2) ->
	#race{
		no = 2,
		sex = 2,
		inborn_goods = [],
		inborn_money = [{10,200}]
};

get(3,1) ->
	#race{
		no = 3,
		sex = 1,
		inborn_goods = [],
		inborn_money = [{10,200}]
};

get(3,2) ->
	#race{
		no = 3,
		sex = 2,
		inborn_goods = [],
		inborn_money = [{10,200}]
};

get(_Race, _Sex) ->
	      ?ASSERT(false, {_Race, _Sex}),
          null.

