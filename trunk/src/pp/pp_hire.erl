%%%-------------------------------------- 
%%% @Module: pp_hire
%%% @Author: zwq
%%% @Created: 2013-12-31
%%% @Description: 
%%%-------------------------------------- 


-module(pp_hire).


-export([handle/3]).

-include("common.hrl"). 
-include("pt_41.hrl").
-include("prompt_msg_code.hrl").
-include("hire.hrl").
-include("sys_code.hrl").

%% desc: 等级检查
handle(Cmd, PS, Data) ->
    case ply_sys_open:is_open(PS, ?SYS_HIRE) of
        true -> handle_cmd(Cmd, PS, Data);
        false -> skip
    end.

handle_cmd(?GET_HIRE_LIST, PS, [Faction, StartIndex, EndIndex, SortType]) ->
    {Len, L} = ply_hire:get_hire_list(PS, Faction, StartIndex, EndIndex, SortType),
    {ok, BinData} = pt_41:write(?GET_HIRE_LIST, [?RES_OK, Len, L]),
    lib_send:send_to_sock(PS, BinData);


handle_cmd(?HIRE_PLAYER, PS, [PlayerId, Count, Price]) ->
    case ply_hire:employ_hire(PS, PlayerId, Count, Price) of
        {fail, Reason} ->
            case Reason of
                ?PM_HIRE_COUNT_LIMIT ->
                    {ok, BinData} = pt_41:write(?HIRE_PLAYER, [?RES_OK, PlayerId, Count]),
                    lib_send:send_to_sock(PS, BinData),
                    lib_send:send_prompt_msg(PS, Reason);
                ?PM_PRICE_CHANGE_TRY_AGAIN ->
                    {ok, BinData} = pt_41:write(?HIRE_PLAYER, [?RES_OK, PlayerId, Count]),
                    lib_send:send_to_sock(PS, BinData),
                    lib_send:send_prompt_msg(PS, Reason);
                _Any ->
                    lib_send:send_prompt_msg(PS, Reason)
            end;
        ok ->
            {ok, BinData} = pt_41:write(?HIRE_PLAYER, [?RES_OK, PlayerId, Count]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle_cmd(?GET_PLAYER_HIRED_INFO, PS, _) ->
    case ply_hire:get_hired_info(PS) of
        {fail, _Reason} ->
            {ok, BinData} = pt_41:write(?GET_PLAYER_HIRED_INFO, [PS, null]),
            lib_send:send_to_sock(PS, BinData);
        Hire ->
            {ok, BinData} = pt_41:write(?GET_PLAYER_HIRED_INFO, [PS, Hire]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle_cmd(?SIGN_UP, PS, [Price]) ->
    case Price =< 0 of
        true -> skip;
        false -> mod_hire_mgr:sign_up(PS, Price)
    end;


handle_cmd(?GET_INCOME, PS, _) ->
    case ply_hire:get_income(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, CanGet} ->
            {ok, BinData} = pt_41:write(?GET_INCOME, [?RES_OK, CanGet]),
            lib_send:send_to_sock(PS, BinData)
    end;            


handle_cmd(?GET_MY_HIRE, PS, _) ->
    case ply_hire:get_my_hire(PS) of
        {fail, _Reason} ->
            % lib_send:send_prompt_msg(PS, Reason);
            skip;
        {ok, Hirer} ->
            {ok, BinData} = pt_41:write(?GET_MY_HIRE, [?RES_OK, Hirer]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle_cmd(?FIGHT_MY_HIRE, PS, _) ->
    case ply_hire:fight_my_hire(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_41:write(?FIGHT_MY_HIRE, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle_cmd(?REST_MY_HIRE, PS, _) ->
    case ply_hire:rest_my_hire(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_41:write(?REST_MY_HIRE, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle_cmd(?FIRE_MY_HIRE, PS, _) ->
    case ply_hire:fire_my_hire(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_41:write(?FIRE_MY_HIRE, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;
                

handle_cmd(?HIRE_CHANGE_PRICE, PS, [Price]) ->
    case ply_hire:change_price(PS, Price) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, LeftCount} ->
            {ok, BinData} = pt_41:write(?HIRE_CHANGE_PRICE, [?RES_OK, Price, LeftCount]),
            lib_send:send_to_sock(PS, BinData)
    end;


%% desc: 容错
handle_cmd(_Cmd, _PS, _Data) ->
    ?DEBUG_MSG("pp_hire no match", []),
    {error, "pp_hire no match"}.