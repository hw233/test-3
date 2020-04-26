%%%-----------------------------------
%%% @Module  : sm_cross_client_sup
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2018.08.20
%%% @Description: 跨服客户端服务监控树
%%%-----------------------------------
-module(sm_cross_client_sup).
-behaviour(supervisor).
-export([start_link/0, get_child_pids/0, interval_do/0]).
-export([init/1]).
start_link() ->
    supervisor:start_link({local,?MODULE}, ?MODULE, []).

init([]) ->
%% 	erlang:register(ServerRef, self()),
    timer:apply_interval(5000, ?MODULE, interval_do, []),
	{ok, {{simple_one_for_one, 10, 10},
          [{sm_cross_client, {sm_cross_client,start_link,[]},
            temporary, brutal_kill, worker, [sm_cross_client]}]}}.

get_child_pids() ->
	ChildList = supervisor:which_children(?MODULE),
	[Child || {_Id, Child, _Type, _Modules} <- ChildList].


interval_do() ->
	Pids = get_child_pids(),
	[erlang:send(Pid, ticket) || Pid <- Pids].
	