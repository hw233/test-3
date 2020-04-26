%%%------------------------------------
%%% @author lf <529132738@qq.com>
%%% @copyright UCweb 2015.03.24
%%% @doc 幸运轮盘 抽奖活动 统计器.
%%% @end
%%%------------------------------------

-module(mod_ernie).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([ernie_open/2      % 活动开启初始化（由活动管理器调用）
        ,ernie_close/2     % 活动关闭（由活动管理器调用）
        ,get_ernie_state/0 % 得到当前状态
        ,ernie_counter/5   % 抽奖统计
    ]).

-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("log.hrl").
-include("record.hrl").
-include("ernie.hrl").

-define(WRITE_DATA_TO_DB_INTERVAL, 300). % 每300秒持续化一次数据


%%=========================================================================
%% 接口函数
%%=========================================================================

%% 抽奖统计
ernie_counter(PS, Goods_no, Num, Quality, Bind) ->
    gen_server:cast(?MODULE, {ernie_counter, PS, Goods_no, Num, Quality, Bind}).

%% 活动开启初始化（由活动管理器调用）
ernie_open(ActId, ActData) ->
    gen_server:cast(?MODULE, {ernie_open, ActId, ActData}),
    ok.

%% 活动关闭（由活动管理器调用）
ernie_close(ActId, ActData) ->
    gen_server:cast(?MODULE, {ernie_close, ActId, ActData}),
    ok.

% 获取抽奖状态信息
get_ernie_state() ->
    gen_server:call(?MODULE, 'get_ernie_state').

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
stop() ->
    gen_server:call(?MODULE, stop).

%%=========================================================================
%% 回调函数
%%=========================================================================
init([]) ->
    process_flag(trap_exit, true),
    {ok, #ernie_state{status = 1}}.

handle_call(stop, _From, State) ->
    {stop, normal, stopped, State};
handle_call(Request, _From, State) -> 
    try 
		do_call(Request, _From, State)
    catch
        _Err:_Reason ->
            ?ERROR_MSG("handle_call *** [~p:~p] ~p ***~n", [_Err, _Reason, erlang:get_stacktrace()]),
            {reply, error, State}
    end.

do_call('get_ernie_state', _From, State) ->
    {reply, State, State};

do_call(_Request, _From, State) ->
    throw({no_match, do_call, _Request}),
	{reply, ok, State}.


handle_cast(Request, State)-> 
	try 
		do_cast(Request, State)
    catch
        _Err:_Reason ->
            ?ERROR_MSG("handle_cast *** [~p:~p] ~p ***~n", [_Err, _Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.

%% 活动开启初始化
do_cast({ernie_open, _ActId, _ActData}, State) ->
    State1 = State#ernie_state{status = 1},
    {noreply, State1};

%% 活动关闭
do_cast({ernie_close, _ActId, _ActData}, State) ->
    State1 = State#ernie_state{status = 0},
    {noreply, State1};

%% 玩家抽奖统计数据（统计的是消耗数量，而不是抽奖次数）
do_cast({ernie_counter, PS, Goods_no, Num, Quality, Bind}, State) ->
    Len = length(State#ernie_state.reward_logs),
    State1 = case Len < 10 of
        true -> State#ernie_state{reward_logs = [{player:get_id(PS), player:get_name(PS), Goods_no, Num, Quality, Bind} | State#ernie_state.reward_logs]};
        false ->
            {List, _} = lists:split(9, State#ernie_state.reward_logs), 
            State#ernie_state{reward_logs = [{player:get_id(PS), player:get_name(PS), Goods_no, Num, Quality, Bind} | List]}
    end,
    % State1 = State#ernie_state{reward_logs = [{player:get_id(PS), player:get_name(PS), Goods_no, Num, Quality, Bind} | State#ernie_state.reward_logs]},
    {noreply, State1};

do_cast(_Request, State) ->
    throw({no_match, do_cast, _Request}),
	{noreply, State}.


handle_info(Request, State)->  
    try 
		do_info(Request, State)
    catch
        _Err:_Reason ->
            ?ERROR_MSG("handle_info *** [~p:~p] ~p ***~n", [_Err, _Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.

do_info(_Request, State) ->
    throw({no_match, do_info, _Request}),
	{noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

    






