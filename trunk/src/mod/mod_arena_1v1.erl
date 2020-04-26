%%%-----------------------------------
%%% @Module  : mod_arena_1v1
%%% @Author  : liuzhongzheng2012@gmail.com
%%% @Email   :
%%% @Created : 2014.6.10
%%% @Description: 1v1在线竞技场
%%%-----------------------------------

-module(mod_arena_1v1).
-behaviour(gen_server).

-export([
        join/1,
        leave/1,
        report/1,
        award/2,
        get_week_top/0,
        set_week_top/1,
        weekly_reset/0,
        send_reports/1,
        arena_1v1_close/0,
        set_battle_flag/1
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
report(Rec) ->
    gen_server:cast(?MODULE, {report, Rec}).

%% 发放奖励
award(UID, Wins) ->
    gen_server:cast(?MODULE, {award, UID, Wins}).

%% 向客户端发全局战报
send_reports(PS) ->
    UID = player:id(PS),
    gen_server:cast(?MODULE, {send_reports, UID}).

%% 比武大会结束作业
arena_1v1_close() ->
    gen_server:cast(?MODULE, arena_1v1_close).

%% 设置战斗标识
set_battle_flag(Id) ->
    gen_server:cast(?MODULE, {set_battle_flag, Id}).

get_week_top() ->
    gen_server:call(?MODULE, get_week_top).

set_week_top(Top) ->
    gen_server:cast(?MODULE, {set_week_top, Top}).

weekly_reset() ->
    lib_arena_1v1:weekly_reset().

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
    State = lib_arena_1v1:init(),
    ets:new(?ETS_LIB_ARENA_1V1, [{keypos, 1}, named_table, public, set]),
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
    Reply = lib_arena_1v1:get_week_top(State),
    {reply, Reply, State};

do_call(_Msg, _From, State) ->
    ?WARNING_MSG("unhandle call ~p", [_Msg]),
    {reply, ok, State}.

do_cast({join, Waiter}, State) ->
    State1 = lib_arena_1v1:join(Waiter, State),
    {noreply, State1};
do_cast({leave, Waiter}, State) ->
    State1 = lib_arena_1v1:leave(Waiter, State),
    {noreply, State1};
do_cast({report, Rec}, State) ->
    State1 = lib_arena_1v1:report(Rec, State),
    {noreply, State1};
do_cast({award, UID, Wins}, State) ->
    lib_arena_1v1:award(UID, Wins, State),
    {noreply, State};
do_cast({send_reports, UID}, State) ->
    lib_arena_1v1:send_reports(UID, State),
    {noreply, State};
do_cast({set_week_top, Top}, State) ->
    State1 = lib_arena_1v1:set_week_top(Top, State),
    {noreply, State1};
do_cast(arena_1v1_close, State) ->
    State1 = lib_arena_1v1:arena_1v1_close(State), 
    {noreply, State1};
do_cast({set_battle_flag, Id}, State) ->
    State1 = lib_arena_1v1:set_battle_flag(Id, State),
    {noreply, State1};
do_cast(_Msg, State) ->
    ?WARNING_MSG("unhandle cast ~p", [_Msg]),
    {noreply, State}.



do_info(doloop, State) ->
    mod_rank:release(?RANK_ARENA_1V1_DAY),
    mod_rank:release(?RANK_ARENA_1V1_WEEK),
    State1 = lib_arena_1v1:match(State),
	{noreply, State1};

do_info(_Msg, State) ->
    ?WARNING_MSG("unhandle info ~w", [_Msg]),
    {noreply, State}.


