%%%-----------------------------------
%%% @Module  : pp_hardtower
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2014.1
%%% @Description: 爬塔函数
%%%-----------------------------------

-module(pp_hardtower).

-include("common.hrl").
-include("record.hrl").
-include("dungeon.hrl").

-export ([handle/3]).

%% @doc 爬塔信息
handle(62001, Status, []) ->
    lib_hardtower:get_tower_info(Status),
    ok;

handle(62002, Status, []) ->
    lib_hardtower:get_tower_dungeon_info(Status),
    ok;

%% @doc 进入爬塔副本
handle(62003, Status, [TowerNo,Floor, State]) ->
    ?ASSERT(lists:member(TowerNo, ?HARD_TOWER_DUNGEON_NO_LIST), TowerNo),
    lib_hardtower:enter_tower(TowerNo, Floor, Status, State),
    ok;


%% @doc 清除进度
handle(62004, Status, []) ->
    lib_hardtower:clean_schedule(Status),
    ok;


%% @doc 投币增加打BOSS次数
handle(62005, Status, [Flag]) ->
    case Flag =:= 1 of
        true -> lib_hardtower:add_chal_times(Status);
        false -> lib_hardtower:close_tower(Status)
    end,
    ok;


handle(_Cmd, _, _) ->
    ?ASSERT(false, [_Cmd]),
    error.