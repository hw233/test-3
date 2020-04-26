%%%------------------------------------
%%% @author 段世和 
%%% @copyright UCweb 2015.07.09
%%% @doc 商会.
%%% @end
%%%------------------------------------

-module(pp_slotmachine).
-export([handle/3]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("slotmachine.hrl").
-include("pt_64.hrl").

%% 所有信息更新
handle(?PT_SLOTMACHINE_INFO, PS, []) -> 
    % ?DEBUG_MSG("PT_SLOTMACHINE_INFO handle",[]),
    % 封装后返回给客户端
    CurRounds =         mod_slotmachine:get_rounds(),
    % ?DEBUG_MSG("PT_SLOTMACHINE_INFO CurRounds ~p",[CurRounds]),
    LeftTime =          mod_slotmachine:get_lefttime(),
    % ?DEBUG_MSG("PT_SLOTMACHINE_INFO LeftTime ~p",[LeftTime]),

    SP = mod_slotmachine:get_slotmachine_player(player:id(PS)),                % 自己的信息
    
    % SP = #slotmachine_player{player_id=player:id(PS),rounds=mod_slotmachine:get_rounds()},
    % ?DEBUG_MSG("PT_SLOTMACHINE_INFO SP ~p",[SP]),

    HS = mod_slotmachine:get_slotmachine_history(),                % 历史信息
    % ?DEBUG_MSG("PT_SLOTMACHINE_INFO HS ~p",[HS]),
    SSP = mod_slotmachine:get_slotmachine_server(),               % 服务器信息
    % ?DEBUG_MSG("PT_SLOTMACHINE_INFO SSP ~p",[SSP]),
    % ?DEBUG_MSG("CurRounds=~p,LeftTime=~p,SP=~p,HS=~p,SSP=~p",[CurRounds,LeftTime,SP,HS,SSP]),

    {ok, BinData} = pt_64:write(?PT_SLOTMACHINE_INFO, [CurRounds,LeftTime,SP,HS,SSP]),
    lib_send:send_to_sid(PS, BinData);


%% 服务器信息更新
handle(?PT_SLOTMACHINE_SERVER_INFO, PS, []) -> 
    % 封装后返回给客户端
    CurRounds =         mod_slotmachine:get_rounds(),
    LeftTime =          mod_slotmachine:get_lefttime(),

    SSP = mod_slotmachine:get_slotmachine_server(),                % 服务器信息

    {ok, BinData} = pt_64:write(?PT_SLOTMACHINE_SERVER_INFO, [CurRounds,LeftTime,SSP]),
    lib_send:send_to_sid(PS, BinData);


%% 服务器信息更新
handle(?PT_SLOTMACHINE_BUY_1, PS, [BuyInfo]) -> 
    case mod_slotmachine:buy1(PS,BuyInfo) of
    {fail, Reason} ->
        lib_send:send_prompt_msg(PS, Reason);
    _ ->
        handle(?PT_SLOTMACHINE_INFO, PS, [])
    end;


handle(?PT_SLOTMACHINE_BUY_2, PS, [Change,Value]) -> 
    case mod_slotmachine:buy2(PS,Change,Value) of
    {fail, Reason} ->
        lib_send:send_prompt_msg(PS, Reason);
    _ ->
        handle(?PT_SLOTMACHINE_INFO, PS, [])
    end;

handle(_Msg, _PS, _) ->
    ?WARNING_MSG("unknown handle ~p", [_Msg]),
    error.



