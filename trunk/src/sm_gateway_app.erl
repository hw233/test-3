%%%-----------------------------------
%%% @Module  : sm_gateway_app
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.15
%%% @Description: 打包程序
%%%-----------------------------------
-module(sm_gateway_app).
-behaviour(application).
-export([start/2, stop/1]).  

-include("framework.hrl").
-include("ets_name.hrl").
-include("debug.hrl").

start(_Type, _Args) -> 
	% ip，端口，线路id（从0开始，网关的线路id为0，游戏server1的线路id为1，server2为2，...）
    % [Ip, Port, Sid] = init:get_plain_arguments(),  % Ip, Port, Sid均为list类型

    Ip = ?IP_OF_GATEWAY_NODE,
    Port = config:get_port_to_listen(?APP_GATEWAY),
    Sid = ?LINE_ID_OF_GATEWAY_NODE,
    ?TRACE("~nIp:~p, Port:~p, Sid:~p, ~p, ~p, ~p~n~n", [Ip, Port, Sid, is_list(Ip), is_integer(Port), is_integer(Sid)]),

	db:init_db(?APP_GATEWAY),

	% ets:new(?ETS_STAT_SOCKET, [named_table, public, set]),   % 输出socket统计
	% ets:new(?ETS_STAT_COMPRESS, [named_table, public, set]), % socket压缩统计
	
    {ok, Pid} = sm_gateway_sup:start_link([Ip, Port, Sid]),
    
    sm_third:start(sm_gateway_sup, "gateway"),
    log_sup:start_sys_log(),
    
    {ok, Pid}.

stop(_State) ->   
    void.
