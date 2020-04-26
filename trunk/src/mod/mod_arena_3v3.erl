%%%-----------------------------------
%%% @Module  : mod_arena_3v3
%%% @Author  : liuzhongzheng2012@gmail.com
%%% @Email   :
%%% @Created : 2014.6.10
%%% @Description: 3v3在线竞技场
%%%-----------------------------------

-module(mod_arena_3v3).
-behaviour(gen_server).

-export([
        join/1,
        leave/1,
        report/2,
        award/2,
        get_week_top/0,
        set_week_top/1,
        weekly_reset/0,
        send_reports/1,
        arena_3v3_close/0,
        set_battle_flag/1,
        get_arena_3v3_state/0,
        clear_arena_3v3_state/0,
        set_player_state/2,
        get_player_state/1,
        set_player_all_times/1
	]).

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include("common.hrl").
-include("rank.hrl").
-include("ets_name.hrl").
%% --------------------------------------------------------------------
%% External exports

-define(MATCH_PERIOD, 15).

%% gen_server callbacks
-export([start/0, start_link/0, init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

join(Waiter) ->
    gen_server:cast(?MODULE, {join, Waiter}).

leave(Waiter) ->
    gen_server:cast(?MODULE, {leave, Waiter}).

%% 记录战报
report(UID,Rec) ->
    gen_server:cast(?MODULE, {report, UID, Rec}).

%% 发放奖励
award(UID, Wins) ->
    gen_server:cast(?MODULE, {award, UID, Wins}).

%% 向客户端发全局战报
send_reports(PS) ->
    UID = player:id(PS),
    gen_server:cast(?MODULE, {send_reports, UID}).

%% 比武大会结束作业
arena_3v3_close() ->
    gen_server:cast(?MODULE, arena_3v3_close).

%% 设置战斗标识
set_battle_flag(Id) ->
    gen_server:cast(?MODULE, {set_battle_flag, Id}).

set_player_all_times(Id) ->
    gen_server:cast(?MODULE, {set_player_all_times, Id}).

%% 设置比武状态
set_player_state(Id, Value) ->
    gen_server:cast(?MODULE, {set_player_state, Id, Value}).

get_player_state(Id) ->
    gen_server:call(?MODULE, {get_player_state, Id}).

get_week_top() ->
    gen_server:call(?MODULE, get_week_top).

set_week_top(Top) ->
    gen_server:cast(?MODULE, {set_week_top, Top}).

weekly_reset() ->
    lib_arena_3v3:weekly_reset().

get_arena_3v3_state() ->
    gen_server:call(?MODULE, get_arena_3v3_state).

clear_arena_3v3_state() ->
    gen_server:call(?MODULE, clear_arena_3v3_state).

start() ->
    case erlang:whereis(?MODULE) of
        undefined ->
            case supervisor:start_child(
               sm_sup,
               {?MODULE,
                {?MODULE, start_link, []},
                 permanent, 10000, worker, [?MODULE]}) of
            {ok, Pid} ->
                Pid;
            {error, R} ->
                ?WARNING_MSG("start error:~p~n", [R]),
                undefined
            end;
        Pid ->
            Pid
    end.

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    mod_timer:reg_loop_msg(self(), ?MATCH_PERIOD * 1000),
    State = lib_arena_3v3:init(),
    ets:new(?ETS_LIB_ARENA_3V3, [{keypos, 1}, named_table, public, set]),
    {ok, State}.


handle_call(Request, From, State) ->
    try
        do_call(Request, From, State)
    catch
        Err:Reason->
            ?WARNING_MSG("ERR:~p,Reason:~p ~p",[Err,Reason,erlang:get_stacktrace()]),
             {reply, error, State}
    end.


handle_cast(Request, State) ->
    try
        do_cast(Request, State)
    catch
        Err:Reason->
            ?WARNING_MSG("ERR:~p,Reason:~p ~p",[Err,Reason,erlang:get_stacktrace()]),
             {noreply, State}
    end.



handle_info(Request, State) ->
    try
        do_info(Request, State)
    catch
        Err:Reason->
            ?WARNING_MSG("ERR:~p,Reason:~p ~p",[Err,Reason,erlang:get_stacktrace()]),
             {noreply, State}
    end.



code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


terminate(_Reason, _State) ->
    ok.

do_call(get_week_top, _From, State) ->
    Reply = lib_arena_3v3:get_week_top(State),
    {reply, Reply, State};

do_call(get_arena_3v3_state, _From, State) ->
    Reply = State,
    {reply, Reply, State};

do_call(clear_arena_3v3_state, _From, _State) ->
    Reply = ok,
    State1 = lib_arena_3v3:init(),
    {reply, Reply, State1};

do_call({get_player_state,Id}, _From, State) ->
    Reply = lib_arena_3v3:get_player_state(Id, State),
    {reply, Reply, State};

do_call(_Msg, _From, State) ->
    ?WARNING_MSG("unhandle call ~p", [_Msg]),
    {reply, ok, State}.

do_cast({join, Waiter}, State) ->
    State1 = lib_arena_3v3:join(Waiter, State),
    {noreply, State1};
do_cast({leave, Waiter}, State) ->
    State1 = lib_arena_3v3:leave(Waiter, State),
    {noreply, State1};
do_cast({report, UID, Rec}, State) ->
    State1 = lib_arena_3v3:report(UID, Rec, State),
    {noreply, State1};
do_cast({award, UID, Wins}, State) ->
    lib_arena_3v3:award(UID, Wins, State),
    {noreply, State};
do_cast({send_reports, UID}, State) ->
    lib_arena_3v3:send_reports(UID, State),
    {noreply, State};
do_cast({set_week_top, Top}, State) ->
    State1 = lib_arena_3v3:set_week_top(Top, State),
    {noreply, State1};
do_cast(arena_3v3_close, State) ->
    State1 = lib_arena_3v3:arena_3v3_close(State), 
    {noreply, State1};
do_cast({set_battle_flag, Id}, State) ->
    State1 = lib_arena_3v3:set_battle_flag(Id, State),
    {noreply, State1};
do_cast({set_player_all_times, Id}, State) ->
    State1 = lib_arena_3v3:set_player_all_times(Id, State),
    {noreply, State1};
do_cast({set_player_state, Id, Value}, State) ->
    State1 = lib_arena_3v3:set_player_state(Id, Value, State),
    {noreply, State1};
do_cast(_Msg, State) ->
    ?WARNING_MSG("unhandle cast ~p", [_Msg]),
    {noreply, State}.



do_info(doloop, State) ->
    mod_rank:release(?RANK_ARENA_3V3_DAY),
    mod_rank:release(?RANK_ARENA_3V3_WEEK),
    State1 = lib_arena_3v3:match(State),
	{noreply, State1};

do_info(_Msg, State) ->
    ?WARNING_MSG("unhandle info ~w", [_Msg]),
    {noreply, State}.


