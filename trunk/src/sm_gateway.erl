%%%--------------------------------------
%%% @Module  : sm_gateway
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.25
%%% @Description: 游戏网关
%%%--------------------------------------
-module(sm_gateway).
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
    sm_gateway_server:stop(Port),
    sm_gateway_server:start_raw_server(Port, F, ?ALL_SERVER_PLAYERS),
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
            gen_tcp:close(Socket);
           
%%         {ok, <<_Len:16, 60000:16>>} ->
%%             List = get_server_list(),
%%             {ok, Data} = pt_60:write(60000, List),
%%             gen_tcp:send(Socket, Data),
%%             gen_tcp:close(Socket);
%% 
%%         {ok, <<Len:16, 60001:16>>} ->
%%             BodyLen = Len - ?HEADER_LENGTH,
%%             case gen_tcp:recv(Socket, BodyLen, 3000) of
%%                 {ok, <<Bin/binary>>} ->
%%                     {Accname, _} = pt:read_string(Bin),
%%                     {ok, Data} = pt_60:write(60001, {_Status, _} = get_account_info(Accname)),
%%                     gen_tcp:send(Socket, Data),
%%                     handoff(Socket);
%%                  _ ->
%%                     gen_tcp:close(Socket)
%%             end;
		{ok, <<Len:16, 60002:16>>} ->
%% 			P = tool:to_list(Packet),
%% 			P1 = string:left(P, 4),
%% %% ?DEBUG("~s here_4_[/~p/~p/~p/~p/]",[misc:time_format(now()), Socket, P, P1, (P1 == "GET ")]), 			
%% 			if (P1 == "GET " orelse P1 == "POST") ->
%% 				   P2 = string:right(P, length(P) - 4),
%% %% ?DEBUG("~s here_4_1_[/~p/~p/~p/~p/]",[misc:time_format(now()), Socket, P, P1, P2]), 				   
%% 					misc_admin:treat_http_request(Socket, P2),
%%            		    gen_tcp:close(Socket);
%% 				true ->
%% 					gen_tcp:close(Socket)
%% 			end;
			?TRACE("recv PHP CMD~n"),
			MsgLen = Len - ?HEADER_LENGTH,
			misc_admin:treat_http_request(Socket, MsgLen),
			gen_tcp:close(Socket);
         _ ->
             gen_tcp:close(Socket)
    end.

%% 获取服务器列表
%% get_server_list() ->
%%     case mod_disperse:server_list() of
%%         [] ->
%%             [];
%%         Server ->
%%             F = fun(S) ->
%%                     [State, Num] = case rpc:call(S#server.node, mod_kernel, scene_and_online_state, []) of
%%                                 {badrpc, _} ->
%%                                     [[], 4, 0];
%%                                 N ->
%%                                     N
%%                             end,
%%                     [S#server.id, S#server.ip, S#server.port, State, Num]
%%                 end,
%%             [F(S) || S <- Server]
%%     end.


