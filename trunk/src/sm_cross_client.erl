%% @author Administrator
%% @doc @todo Add description to sm_cross_client.
%% 跨服通讯客户端进程，这个模块进程是对应每个服务器的通讯连接，多个客户端节点连接过来本服
%% 本模块只做消息中转
-module(sm_cross_client).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-include("common.hrl").
-include("ets_name.hrl").
-include("cross.hrl").

-compile(export_all).
%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/2]).

%% 当有新的服务器节点连接时，开启新进程？是否需要判断旧进程的存在？
start_link(RegName, Socket) ->
	gen_server:start_link({local, RegName}, ?MODULE, [Socket], []).


client_regname(ServerId) ->
	list_to_atom(lists:concat(["sm_cross_client_", ServerId])).


handle_cross_msg_cast(Pid, FromSocket, CrossMsg) ->
	gen_server:cast(Pid, {handle_cross_msg, FromSocket, CrossMsg}).

send_to_client_cast(Pid, CrossMsg) ->
	gen_server:cast(Pid, {send_to_client, CrossMsg}).
	
update_socket(Pid, Socket) ->
	gen_server:cast(Pid, {update_socket, Socket}).

%% ====================================================================
%% Behavioural functions
%% ====================================================================
-record(state, {
				heartbeat_unixtime = 0,
				transfer_server_id = 0,
				socket = ?undefined	%% 节点通讯socket
			   }).

%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:init-1">gen_server:init/1</a>
-spec init(Args :: term()) -> Result when
	Result :: {ok, State}
			| {ok, State, Timeout}
			| {ok, State, hibernate}
			| {stop, Reason :: term()}
			| ignore,
	State :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
init([Socket]) ->
	{ok, #state{heartbeat_unixtime = util:unixtime(), transfer_server_id = config:get_server_id(), socket = Socket}}.


%% handle_call/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_call-3">gen_server:handle_call/3</a>
-spec handle_call(Request :: term(), From :: {pid(), Tag :: term()}, State :: term()) -> Result when
	Result :: {reply, Reply, NewState}
			| {reply, Reply, NewState, Timeout}
			| {reply, Reply, NewState, hibernate}
			| {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason, Reply, NewState}
			| {stop, Reason, NewState},
	Reply :: term(),
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity,
	Reason :: term().
%% ====================================================================
handle_call(Request, From, State) ->
    Reply = ok,
    {reply, Reply, State}.


%% handle_cast/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_cast-2">gen_server:handle_cast/2</a>
-spec handle_cast(Request :: term(), State :: term()) -> Result when
	Result :: {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason :: term(), NewState},
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_cast({handle_cross_msg, FromSocket, CrossMsg}, #state{} = State) ->
	State2 = handle_cross_msg(State, FromSocket, CrossMsg),
	{noreply, State2#state{socket = FromSocket}};

%% 回传数据到client节点
handle_cast({send_to_client, CrossMsg}, #state{socket = Socket} = State) ->
	send_cross_msg(Socket, CrossMsg),
	{noreply, State};

handle_cast({update_socket, Socket}, State) ->
	catch gen_tcp:close(State#state.socket),
	{noreply, State#state{socket = Socket}};

handle_cast(Msg, State) ->
    {noreply, State}.


%% handle_info/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_info-2">gen_server:handle_info/2</a>
-spec handle_info(Info :: timeout | term(), State :: term()) -> Result when
	Result :: {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason :: term(), NewState},
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_info({tcp, Socket, Packet}, State) ->
	Term = erlang:binary_to_term(Packet),
	handle_cross_msg(State, Socket, Term),
	{noreply, State};


handle_info({tcp_closed, Socket}, State) ->
	?ERROR_MSG("{tcp_closed, Socket} : ~p~n", [{tcp_closed, Socket}]),
	{noreply, State#state{socket = ?undefined}};


handle_info(ticket, State) ->
	Unixtime = util:unixtime(),
	case Unixtime - State#state.heartbeat_unixtime > 20 of
		?true ->
			%% 超过20秒，退出进程
			{stop, normal, State};
		?false ->
			{noreply, State}
	end;


handle_info(Info, State) ->
	?ERROR_MSG("Unhandle Info : ~p~n", [Info]),
    {noreply, State}.


%% terminate/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:terminate-2">gen_server:terminate/2</a>
-spec terminate(Reason, State :: term()) -> Any :: term() when
	Reason :: normal 
			| shutdown
			| {shutdown, term()}
			| term().
%% ====================================================================
terminate(Reason, State) ->
    ok.


%% code_change/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:code_change-3">gen_server:code_change/3</a>
-spec code_change(OldVsn, State :: term(), Extra :: term()) -> Result when
	Result :: {ok, NewState :: term()} | {error, Reason :: term()},
	OldVsn :: Vsn | {down, Vsn},
	Vsn :: term().
%% ====================================================================
code_change(OldVsn, State, Extra) ->
    {ok, State}.


%% ====================================================================
%% Internal functions
%% ====================================================================
%% 处理跨服服务器返回的消息
handle_cross_msg(State, Socket, heartbeat) ->
	%% 暂时原样返回给那边，目前那边已经处理了超时的情况，可以考虑下这边是否有必要判断心跳超时
	Msg = heartbeat,
	send_cross_msg(Socket, Msg),
	State#state{heartbeat_unixtime = util:unixtime()};
handle_cross_msg(#state{transfer_server_id = TransferServerId} = State, Socket, CrossMsg) 
  when is_record(CrossMsg, cross_msg) orelse is_record(CrossMsg, cross_msg_reply) ->
	DistServer = 
		case CrossMsg of
			#cross_msg{dist_server = DistServer0} ->
				DistServer0;
			#cross_msg_reply{from_server = FromServer} ->
				[FromServer]
		end,
	
	%% 这是C2C中转包，需要发给最终节点的
	Pids = 
		case DistServer of
			[] ->
				%% 广播给所有节点的
				sm_cross_client_sup:get_child_pids();
			_ ->
				%% 转换成pid
				lists:foldl(fun(ServerId, Acc) when TransferServerId == ServerId ->
									%% 本节点处理，把消息发给本节点的进程处理即可
									gen_server:cast(sm_cross_server, {handle_cross_msg, Socket, CrossMsg}),
									Acc;
							   (ServerId, Acc) ->
									RegName = client_regname(ServerId),
									[RegName|Acc]
							end, [], DistServer)
		end,
	[send_to_client_cast(Pid, CrossMsg)  || Pid <- Pids],
	State;



handle_cross_msg(State, Socket, Packet) ->
	?ERROR_MSG("Unhandle Data : ~p~n", [{Socket, Packet}]),
	State.


send_cross_msg(Socket, Msg) when erlang:is_binary(Msg) ->
	lib_send:send_to_sock(Socket, Msg, true);

send_cross_msg(Socket, Term) ->
	BinData = erlang:term_to_binary(Term, [compressed]),
	send_cross_msg(Socket, BinData).





   

