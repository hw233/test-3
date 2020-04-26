%%%-----------------------------------
%%% @Module  : pp_tower
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2014.1
%%% @Description: 爬塔函数
%%%-----------------------------------

-module(pp_tower).

-include("common.hrl").
-include("record.hrl").
-include("tower_ghost.hrl").

-export ([handle/3]).

%% @doc 爬塔信息
handle(49001, Status, []) ->
    lib_tower:get_tower_info(Status),
    ok;

handle(49002, Status, []) ->
    lib_tower:get_tower_dungeon_info(Status),
    ok;

%% @doc 进入爬塔副本
handle(49003, Status, [Type, Floor]) ->
    lib_dungeon:enter_tower_dungeon(player:get_id(Status), Floor, Type),
    ok;


%% @doc 清除进度
handle(49004, Status, []) ->
    lib_tower:clean_schedule(Status),
    ok;


%% @doc 投币增加打BOSS次数
handle(49005, Status, [Flag]) ->
    case Flag =:= 1 of
        true -> lib_tower:add_chal_times(Status);
        false -> lib_tower:close_tower(Status)
    end,
    ok;


%% 请求伏魔塔数据
handle(49020, Status, []) ->
	case lib_tower_ghost:get_tower_ghost_info(player:id(Status)) of
		{ok, #tower_ghost{floor = Floor, times = Times, last_time_restore = LastTimeRestore}} ->
			{ok, BinData} = pt_49:write(49020, [Floor, Times, LastTimeRestore]),
			lib_send:send_to_sock(Status, BinData);
		null ->
			ok
	end;


handle(49021, Status, [_Floor]) ->
	case lib_tower_ghost:chanllenge_floor(Status) of
		ok ->
			ok;
		{fail, Reason} ->
			lib_send:send_prompt_msg(Status, Reason)
	end;
		


handle(_Cmd, _, _) ->
    ?ASSERT(false, [_Cmd]),
    error.


