%%%--------------------------------------
%%% @Module  : sm_flash
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.25
%%% @Description: flash policy file server
%%%--------------------------------------
-module(sm_flash).
-behaviour(gen_server).
-export([start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-include("common.hrl").
-include("record.hrl").
-define(HEADER_LENGTH, 4). % 消息头长度

%%开启网关
%%Node:节点
%%Port:端口
start_link(Port) ->
    gen_server:start(?MODULE, [Port], []).

init([Port]) ->
    F = fun(Sock) -> handoff(Sock) end,
    sm_flash_server:stop(Port),
    sm_flash_server:start_raw_server(Port, F, ?ALL_SERVER_PLAYERS),
    {ok, true}.

handle_cast(_Rec, Status) ->
    {noreply, Status}.

handle_call(_Rec, _FROM, Status) ->
    {reply, ok, Status}.

handle_info(_Info, Status) ->
    {noreply, Status}.

terminate(normal, Status) ->
    {ok, Status}.

code_change(_OldVsn, Status, _Extra)->
	{ok, Status}.

%%发送要连接的IP和port到客户端，并关闭连接
handoff(Socket) ->
    case gen_tcp:recv(Socket, ?HEADER_LENGTH) of
        {ok, ?FL_POLICY_REQ} ->
			?TRACE("--- flash policy ---~n"),
            Len = 23 - ?HEADER_LENGTH,
            gen_tcp:recv(Socket, Len, 1000),
            gen_tcp:send(Socket, ?FL_POLICY_FILE),
            gen_tcp:close(Socket)
    end.


