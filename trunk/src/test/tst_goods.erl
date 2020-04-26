 %%%--------------------------------------
%%% @Module  : test_goods
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Created : 2013.5.15
%%% @Description : 测试玩家的物品栏
%%%                注：玩家的物品栏是一个概念，包括玩家的背包、仓库、装备栏以及其宠物的装备栏。
%%%-------------------------------------
-module(tst_goods).

-include("ets_name.hrl").
-include("inventory.hrl").
-include("goods.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("record.hrl").

-export([
			init/0,
			show_state/0,
			extend_bag/0,
			extend_sto/0,
			add_goods/0,
			destroy_goods/0,
			get_bag_capacity/0,
			get_sto_capacity/0,
			get_goods_by_id/0,
			get_empty_slot_list/0,
			db_save_inv/0,
			get_goods_list/0,
			drag_goods/0,
			move_goods/0,
			use_goods/0,
			calc_empty_slots/0,
			arrange_bag/0,
			put_player_equip/0,
			takeoff_player_equip/0
		]).

make_PS() ->
	#player_status{id = 100, accname = [zhangwq], lv = 100}.

init() ->
	ets:new(?ETS_INVENTORY, [{keypos,#inv.player_id}, named_table, public, set]),
	PS = make_PS(),
	mysql_test2:init_db(),
	mod_inv:init_inventory(PS#player_status.id, [36, 24]).

extend_bag() ->
	{ok, [ExtendSlot]} = io:fread("imput ExtendSlot:", "~d\n"),
	PS = make_PS(),
	mod_inv:extend_capacity(PS, ?LOC_BAG_EQ, ExtendSlot),
	_Inv = mod_inv:get_inventory(PS#player_status.id),
	?TRACE("GoodsState: ~p~n", [_Inv]).

extend_sto() ->
	{ok, [ExtendSlot]} = io:fread("imput ExtendSlot:", "~d\n"),
	PS = make_PS(),
	mod_inv:extend_capacity(PS, ?LOC_STORAGE, ExtendSlot),
	_Inv = mod_inv:get_inventory(PS#player_status.id),
	?TRACE("GoodsState: ~p~n", [_Inv]).

add_goods() ->
	{ok, [GoodsNo]} = io:fread("imput GoodsNo:", "~d\n"),
	PS = make_PS(),
	PlayerId = PS#player_status.id,
	mod_inv:add_new_goods_to_bag(PlayerId, GoodsNo),
	_Inv = mod_inv:get_inventory(PlayerId),
	?TRACE("GoodsState: ~p~n", [_Inv]).

destroy_goods() ->
	{ok, [GoodsId]} = io:fread("imput GoodsId:", "~d\n"),
	PS = make_PS(),
	Goods = mod_inv:get_bag_goods_by_id(PS#player_status.id, GoodsId),
	PlayerId = PS#player_status.id,
	mod_inv:destroy_goods(PlayerId, Goods),
	_Inv = mod_inv:get_inventory(PlayerId),
	?TRACE("GoodsState: ~p~n", [_Inv]).

get_bag_capacity() ->
	PS = make_PS(),
	_Capacity = mod_inv:get_bag_capacity(PS#player_status.id),
	?TRACE("Bag Capacity:~p~n", [_Capacity]).

get_sto_capacity() ->
	PS = make_PS(),
	_Capacity = mod_inv:get_storage_capacity(PS#player_status.id),
	?TRACE("Sto Capacity:~p~n", [_Capacity]).

get_goods_by_id() ->
	PS = make_PS(),
	{ok, [GoodsId]} = io:fread("imput GoodsId:", "~d\n"),
	_Goods = mod_inv:find_goods_by_id(PS#player_status.id, GoodsId, ?LOC_BAG_EQ),
	?TRACE("Goods:~p~n", [_Goods]).

get_empty_slot_list() ->
	PS = make_PS(),
	{ok, [Location]} = io:fread("imput Location 0 or 1:", "~d\n"),
	_EmptySlot = mod_inv:get_empty_slot_list(PS#player_status.id, Location),
	?TRACE("EmptySlot:~p~n", [_EmptySlot]).

db_save_inv() ->
	PS = make_PS(),
	mod_inv:db_save_inventory(PS#player_status.id).

get_goods_list() ->
	PS = make_PS(),
	{ok, [Location]} = io:fread("imput Location 0 or 1:", "~d\n"),
	_GoodsList = mod_inv:get_goods_list(PS#player_status.id, Location),
	?TRACE("GoodsList:~p~n", [_GoodsList]).

drag_goods() ->
	PS = make_PS(),
	{ok, [Location]} = io:fread("imput Location 0 or 1:", "~d\n"),
	{ok, [GoodsId]} = io:fread("imput GoodsId:", "~d\n"),
	{ok, [ToSlot]} = io:fread("imput ToSlot:", "~d\n"),
	mod_inv:drag_goods(PS#player_status.id, GoodsId, ToSlot, Location),
	_Inv = mod_inv:get_inventory(PS#player_status.id),
	?TRACE("GoodsState: ~p~n", [_Inv]).

move_goods() ->
	PS = make_PS(),
	{ok, [GoodsId]} = io:fread("imput GoodsId:", "~d\n"),
	{ok, [FromLoc]} = io:fread("imput FromLoc 0 or 1:", "~d\n"),
	{ok, [ToLoc]} = io:fread("imput ToLoc 0 or 1:", "~d\n"),
	mod_inv:move_goods(PS#player_status.id, GoodsId, FromLoc, ToLoc),
	_Inv = mod_inv:get_inventory(PS#player_status.id),
	?TRACE("GoodsState: ~p~n", [_Inv]).

use_goods() ->
	PS = make_PS(),
	{ok, [GoodsId]} = io:fread("imput GoodsId:", "~d\n"),
	Goods = mod_inv:find_goods_by_id(PS#player_status.id, GoodsId, ?LOC_BAG_EQ),
	mod_inv:do_use_goods(PS, Goods),
	show_state().

show_state() ->
	PS = make_PS(),
	_Inv = mod_inv:get_inventory(PS#player_status.id),
	?TRACE("GoodsState: ~p~n", [_Inv]).

calc_empty_slots() ->
	PS = make_PS(),
	{ok, [Location]} = io:fread("imput Location 0 or 1:", "~d\n"),
	_EmptySlot = mod_inv:calc_empty_slots(PS#player_status.id, Location),
	?TRACE("EmptySlot:~p~n", [_EmptySlot]).

arrange_bag() ->
	PS = make_PS(),
	mod_inv:arrange_bag(PS),
	show_state().

put_player_equip() ->
	PS = make_PS(),
	{ok, [GoodsId]} = io:fread("imput GoodsId:", "~d\n"),
	mod_equip:puton_equip(for_player, PS, GoodsId),
	show_state().

takeoff_player_equip() ->
	PS = make_PS(),
	{ok, [EquipPos]} = io:fread("imput EquipPos:", "~d\n"),
	mod_equip:takeoff_equip(for_player, PS, EquipPos),
	show_state().