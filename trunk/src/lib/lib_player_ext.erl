%%%-----------------------------------
%%% @Module  : lib_player_ext
%%% @Author  : 段世和
%%% @Email   : 
%%% @Created : 2015.07.06
%%% @Description: 商会交易系统
%%%-----------------------------------

-module(lib_player_ext).

% include
-include("common.hrl").
-include("player_ext.hrl").
-include("goods.hrl").
-include("ets_name.hrl").
-include("abbreviate.hrl").
-include("log.hrl").

-include("record.hrl").

-include("debug.hrl").

-compile(export_all).
% -export([]).

% function body

% 玩家临时退出操作---保存数据到数据库
tmp_logout(PS) ->
    % 存人气值
    player:db_save_popular(PS,player:get_popular(PS)),
    % 存筹码
    player:db_save_chip(PS,player:get_chip(PS)),

    void.

% 数据库尝试获取数据
try_load_data(PS,Key) when is_record(PS, player_status) ->
    PlayerID = player:id(PS),
    try_load_data(PlayerID,Key);

% 数据库尝试获取数据
try_load_data(PlayerID,Key) ->
    try 
        RetInfo = db:select_one(player_ext,"`value`",[{player_id,PlayerID},{key,Key}]),
        Ret = case RetInfo of 
            null -> 
                try_insert_data(PlayerID,Key,0),
                0;
            _ -> RetInfo
        end,

        ?DEBUG_MSG("PlayerID=~p,Key=~p,Info=~p",[PlayerID,Key,Ret]),
        {ok, Ret}
    catch
        _:Reason ->
            ?ERROR_MSG("try_load_data() failed!! PlayerID:~p, Reason:~w", [PlayerID, Reason]),
            fail
    end.

% 数据库更新
try_update_data(PS,Key,Value) when is_record(PS, player_status) ->
    PlayerID = player:id(PS),
    try_update_data(PlayerID,Key,Value);

% 数据库更新
try_update_data(PlayerID,Key,Value) ->
    try 
        db:update(player_ext,[{value, Value}], [{player_id, PlayerID},{key,Key}]),
        ok
    catch
        _:Reason ->
            ?ERROR_MSG("try_update_data() failed!! PlayerID:~p, Reason:~w", [PlayerID, Reason]),
            fail
    end.

% 插入数据
try_insert_data(PS,Key,Value) when is_record(PS, player_status) ->
    PlayerID = player:id(PS),
    try_insert_data(PlayerID,Key,Value);

% 插入数据
try_insert_data(PlayerID,Key,Value) ->
    try 
        db:insert(player_ext, [player_id, key, value], [PlayerID, Key, Value]),
        ok
    catch
        _:Reason ->
            ?ERROR_MSG("try_update_data() failed!! PlayerID:~p, Reason:~w", [PlayerID, Reason]),
            fail
    end.
