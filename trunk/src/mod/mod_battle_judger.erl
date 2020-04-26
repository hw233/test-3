%%%------------------------------------
%%% @Module  : mod_battle_judger
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.11.13
%%% @Description: 战斗judger，目前仅用于辅助实现：避免玩家与多个其他玩家同时触发多场PK战斗
%%%------------------------------------
-module(mod_battle_judger).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start_link/0,
        req_start_pk/4,
        on_unmark_player_battling/1,
        on_player_logout/1
        ]).

-include("debug.hrl").


-record(state, {
        }).

-record(bt_jdgr_plyr_info, {
        is_battling = false
        }).


-define(PDKN_PLAYER_INFO, pdkn_player_info).



start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


%% 请求触发PK
req_start_pk(PS, OpponentPS, PK_Type, Callback) ->
    gen_server:cast(?MODULE, {'req_start_pk', PS, OpponentPS, PK_Type, Callback}).


on_unmark_player_battling(PS) ->
    PlayerId = player:id(PS),
    gen_server:cast(?MODULE, {'on_unmark_player_battling', PlayerId}).


on_player_logout(PS) ->
    PlayerId = player:id(PS),
    gen_server:cast(?MODULE, {'on_player_logout', PlayerId}).    


    



%% ===================================================================================================
    
init([]) ->
    ?TRACE("[~p] init()...~n", [?MODULE]),
    process_flag(trap_exit, true),
    {ok, #state{}}.


handle_call(Msg, From, State) ->
    try
        handle_call_i(Msg, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("Err:~p, Reason:~p, stacktrace:~w", [Err, Reason, erlang:get_stacktrace()]),
            {reply, error, State}
    end.


handle_cast(Msg, State) ->
    try
        handle_cast_i(Msg, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("Err:~p, Reason:~p, stacktrace:~w", [Err, Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.


handle_info(Msg, State) ->
    try
        handle_info_i(Msg, State)
    catch
        Err:Reason->
            ?ERROR_MSG("Err:~p, Reason:~p, stacktrace:~w", [Err, Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.


terminate(Reason, _State) ->
    case Reason of
        normal -> skip;
        shutdown -> skip;
        {shutdown, _} -> skip;
        _ ->
            ?ERROR_MSG("[~p] !!!!!terminate!!!!! for reason: ~w", [?MODULE, Reason])
    end,
    ok.


code_change(_OldVsn, State, _Extra)->
	{ok, State}.





handle_call_i(Msg, _From, State) ->
    ?ASSERT(false, Msg),
    ?WARNING_MSG("unknown call msg: ~p", [Msg]),
    {reply, error, State}.



handle_cast_i({'req_start_pk', PS, OpponentPS, PK_Type, Callback}, State) ->
    PlayerId = player:id(PS),
    OpponentPlayerId = player:id(OpponentPS),

    case is_battling(PlayerId) orelse is_battling(OpponentPlayerId) of
        true ->
            ?DEBUG_MSG("mod_battle_judger, PS is_battling:~p, OpponentPS is_battling:~p~n", [is_battling(PlayerId), is_battling(OpponentPlayerId)]),
            skip;
        false ->
            mark_battling(PlayerId),
            mark_battling(OpponentPlayerId),
            mod_battle:do_start_pk(PS, OpponentPS, PK_Type, Callback)
    end,
    {noreply, State};

handle_cast_i({'on_unmark_player_battling', PlayerId}, State) ->
    ?ASSERT(is_integer(PlayerId)),
    unmark_battling(PlayerId),
    {noreply, State};

handle_cast_i({'on_player_logout', PlayerId}, State) ->
    ?ASSERT(is_integer(PlayerId)),
    del_player_info(PlayerId),  % 删除，以免残留数据
    {noreply, State};

handle_cast_i(Msg, State) ->
    ?ASSERT(false, Msg),
    ?WARNING_MSG("unknown cast msg: ~p", [Msg]),
    {noreply, State}.




handle_info_i(_Msg, State) ->
    {noreply, State}.





%% ================================================================================================

get_player_info(PlayerId) ->
    case erlang:get({?PDKN_PLAYER_INFO, PlayerId}) of
        undefined ->
            null;
        Val ->
            Val
    end.

set_player_info(PlayerId, Val) when is_record(Val, bt_jdgr_plyr_info) ->
    erlang:put({?PDKN_PLAYER_INFO, PlayerId}, Val).

del_player_info(PlayerId) ->
    % ?DEBUG_MSG("Mod:~p, del_player_info, PlayerId:~p", [?MODULE, PlayerId]),
    erlang:erase({?PDKN_PLAYER_INFO, PlayerId}).

    

is_battling(PlayerId) ->
    case get_player_info(PlayerId) of
        null ->
            false;
        Info ->
            Info#bt_jdgr_plyr_info.is_battling
    end.

mark_battling(PlayerId) ->
    case get_player_info(PlayerId) of
        null ->
            set_player_info(PlayerId, #bt_jdgr_plyr_info{is_battling = true});
        Info ->
            set_player_info(PlayerId, Info#bt_jdgr_plyr_info{is_battling = true})
    end.

unmark_battling(PlayerId) ->
    % ?DEBUG_MSG("Mod:~p, unmark_battling, PlayerId:~p", [?MODULE, PlayerId]),
    case get_player_info(PlayerId) of
        null ->
            skip;
        Info ->
            set_player_info(PlayerId, Info#bt_jdgr_plyr_info{is_battling = false})
    end.

