%% @author Administrator
%% @doc @todo Add description to sm_cross_server.
%% 跨服通讯服务端进程 -- 一对多, 这个进程的作用是初始化与跨服节点的网络通信和实现rpc接口
%% 初始流程，1：根据host和port连接中心跨服节点，并发送server_id给中心节点，双方保持连接的存活，一但心跳超时则
%% 释放旧的套接字重新建立新连接。2：发送消息的格式使用mod，fun，args的 rpc方式进行远程调用
%% ticket定时检测和初始化与中转节点的网络连接
-module(sm_cross_server).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-include("common.hrl").
-include("cross.hrl").
-compile(export_all).
%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/0]).

start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


%% 初始化跨服节点网络连接
connect_cross_server(Host, Port) -> 
	gen_server:call(?MODULE, {connect_cross_server, Host, Port}).


%% 只发送给跨服服务器节点
rpc_cast(Mod, Func, Args) ->
	gen_server:cast(?MODULE, {rpc_cast, Mod, Func, Args}).

rpc_cast(ServerIds, Mod, Func, Args) ->
	gen_server:cast(?MODULE, {rpc_cast, ServerIds, Mod, Func, Args}).



%%没有特殊要求，统一默认5秒等待超时
rpc_call(Mod, Func, Args) ->
	Ref = erlang:make_ref(),
	From = self(),
	Timeout = 3000,
	gen_server:cast(?MODULE, {rpc_call, From, Ref, Mod, Func, Args}),
	receive
		{Ref, Reply} ->
			{ok, Reply}
	after Timeout ->
		{fail, timeout}
	end.

rpc_call(ServerId, Mod, Func, Args) ->
	Ref = erlang:make_ref(),
	From = self(),
	Timeout = 3000,
	gen_server:cast(?MODULE, {rpc_call, From, Ref, ServerId, Mod, Func, Args}),
	receive
		{Ref, Reply} ->
			{ok, Reply}
	after Timeout ->
		{fail, timeout}
	end.



rpc_proto_data_cast(PlayerId, Cmd, Data) ->

	rpc_cast(?MODULE, rpc_proto_data, [config:get_server_id(), PlayerId, Cmd, Data]).

rpc_proto_data_cast(ServerId, PlayerId, Cmd, Data) ->
	rpc_cast(ServerId, ?MODULE, rpc_proto_data, [config:get_server_id(), PlayerId, Cmd, Data]).


rpc_proto_data(ServerId, PlayerId, Cmd, Data) ->
	Pid = player:get_pid(PlayerId),
	case is_pid(Pid) andalso is_process_alive(Pid) of
		?true ->
			gen_server:cast(Pid, {'SOCKET_EVENT', Cmd, Data}),
%% 			gen:call(Pid, '$gen_call', {'SOCKET_EVENT', Cmd, Data}), % 处理游戏逻辑
			ok;
		_ ->
			sm_cross_server:rpc_cast(ServerId, lib_cross, init_cross, [PlayerId])
%% 			case player:get_PS(PlayerId) of
%% 				PS when is_tuple(PS) ->
%% 					ServerId = player:get_server_id(PS),
%% 					%% 尝试重新初始化镜像进程
%% 					sm_cross_server:rpc_cast(ServerId, lib_cross, init_cross_proc, [PlayerId]);
%% 				E ->
%% 					?ERROR_MSG("Err : ~p~n", [{PlayerId, E}])
%% 			end
	end.


%% ====================================================================
%% Behavioural functions
%% ====================================================================
-record(state, {host,
				port,
				socket, 
				bin = <<>>, 
				server_id = 0, 
				server_id_transfer = 0,
				is_local_transfer = 0,
				heartbeat_unixtime = 0,
				bad_count = 0,
				reconnect_unixtime = 0
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
init([]) ->
	scheduler_tick(),
	ServerId = config:get_server_id(),
	{Host, Port} = config:get_cross_server(),
	{ok, #state{server_id = ServerId, host = Host, port = Port}}.


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
	try
		do_handle_call(Request, From, State)
	catch 
		Error:Reason ->
			?ERROR_MSG("{Error, Reason, erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
			{noreply, State}
	end.

do_handle_call({connect_cross_server, Host, Port}, _From, State) ->
	{reply, ok, State#state{host = Host, port = Port}};



do_handle_call(Request, From, State) ->
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
handle_cast(Request, State) ->
	try
		do_handle_cast(Request, State)
	catch 
		Error:Reason ->
			?ERROR_MSG("{Error, Reason, erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
			{noreply, State}
	end.


do_handle_cast({handle_cross_msg, Socket, CrossMsg}, State) ->
	do_handle_cross_msg2(Socket, CrossMsg),
	{noreply, State};

do_handle_cast(heartbeat_unixtime, State) ->
	{noreply, State#state{heartbeat_unixtime = util:unixtime()}};

do_handle_cast({rpc_cast, ServerIds, Mod, Func, Args}, #state{socket = Socket, server_id = FromServer} = State) ->
	%% c2s 
	DistServer = 
		case is_list(ServerIds) of
			?true ->
				ServerIds;
			?false ->
			 	case is_integer(ServerIds) of
					?true ->
						[ServerIds];
					?false ->
						[]
				end
		end,
	CrossMsg = #cross_msg{from_server = FromServer,
						  dist_server = DistServer,
						  type = ?DEF_RPC_CAST,
						  mod = Mod,
						  func = Func,
						  args = Args},
	%% 判断下是否是跨服节点，直接发到对应client进程即可，不需要要通过socket发给跨服节点中转
	case check_is_local_transfer(State) of
		{?true, State2} ->
			send_to_client_pid(CrossMsg),
			{noreply, State2};
		?false ->
			send_cross_msg(Socket, CrossMsg),
			{noreply, State}
	end;

do_handle_cast({rpc_cast, Mod, Func, Args}, #state{server_id_transfer = ServerIdTransfer} = State) ->
	do_handle_cast({rpc_cast, ServerIdTransfer, Mod, Func, Args}, State);


do_handle_cast({rpc_call, From, Ref, ServerId, Mod, Func, Args}, #state{socket = Socket, server_id = FromServer} = State) ->
	CrossMsg = #cross_msg{
						  from_server = FromServer, 
						  dist_server = [ServerId], 
						  type = ?DEF_RPC_CALL, 
						  from_pid = From,
						  ref = Ref, 
						  mod = Mod, 
						  func = Func, 
						  args = Args
						  },
	%% 判断下是否是跨服节点，直接发到对应client进程即可，不需要要通过socket发给跨服节点中转
	case check_is_local_transfer(State) of
		{?true, State2} ->
			send_to_client_pid(CrossMsg),
			{noreply, State2};
		?false ->
			send_cross_msg(Socket, CrossMsg),
			{noreply, State}
	end;

do_handle_cast({rpc_call, From, Ref, Mod, Func, Args}, #state{server_id_transfer = ServerIdTransfer} = State) ->
	do_handle_cast({rpc_call, From, Ref, ServerIdTransfer, Mod, Func, Args}, State);

do_handle_cast({server_id_transfer, ServerIdTransfer}, State) ->
	{noreply, State#state{server_id_transfer = ServerIdTransfer}};


do_handle_cast(same_node, State) ->
	State2 = free_cross_socket(State),
	{noreply, State2#state{host = "", port = 0}};

do_handle_cast(Msg, State) ->
	?ERROR_MSG("Unhandle Msg : ~p~n", [Msg]),
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
handle_info(Request, State) ->
	try
		do_handle_info(Request, State)
	catch 
		Error:Reason ->
			?ERROR_MSG("{Error, Reason, erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
			{noreply, State}
	end.

do_handle_info({tcp, Socket, Packet}, #state{bin = Bin} = State) ->
	BinFrag = handle_cross_msg(Socket, <<Bin/binary, Packet/binary>>),
	{noreply, State#state{bin = BinFrag}};


do_handle_info({tcp_closed, Socket}, State) ->
	?ERROR_MSG("{tcp_closed, Socket} : ~p~n", [{tcp_closed, Socket}]),
	{noreply, State#state{socket = ?undefined}};


do_handle_info(tick, #state{socket = Socket, heartbeat_unixtime = HeartbeatUnixtime} = State) ->
	scheduler_tick(),
	%% 发心跳包，保持连接，心跳包超时的话进行重连？
	case is_port(State#state.socket) of
		?false ->%% 如果没有套接字则尝试建立新连接？
			do_connect_cross_server(State);
		?true ->%% 连接已存在，检查心跳存活？
			%% 判断是否超过心跳时间，重连
			Unixtime = util:unixtime(),
			case Unixtime - HeartbeatUnixtime > 20 of
				?true ->
					%% 超过十秒，删除旧套接字和sm_switer进程并重连
					State2 = free_cross_socket(State),
					do_connect_cross_server(State2);
				?false ->
					Msg = heartbeat,
					send_cross_msg(Socket, Msg),
					{noreply, State}
			end
	end;


do_handle_info(Info, State) ->
	?ERROR_MSG("Unknown Info : ~p~n", [Info]),
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

free_cross_socket(#state{socket = Socket} = State) ->
	?TRY_CATCH(gen_tcp:close(State#state.socket), ErrReason),
	case nosql:get(sock_writer_map, Socket) of
		undef ->
			pass;
		SendPid ->
			gen_server:cast(SendPid, stop)
	end,
	nosql:del(sock_writer_map, Socket),
	State#state{socket = ?undefined}.

scheduler_tick() ->
	Time = 5000,
	erlang:send_after(Time, ?MODULE, tick).

do_connect_cross_server(#state{host = Host, port = Port, bad_count = BadCount, reconnect_unixtime = ReconnectUnixtime} = State) ->
	Unixtime = util:unixtime(),
	case is_integer(Port) andalso Port > 0 andalso Unixtime > ReconnectUnixtime of
		?true ->%% 重复连接的原因是心跳时间超时
			case gen_tcp:connect(Host, Port, [binary, {packet, 0}]) of
				{ok, Socket} ->
					%% 连接以后发送安全串让对方将连接转交cross_client进程处理
					{ok, SendPid} = sm_writer:start_link(Socket),
					nosql:set(sock_writer_map, Socket, SendPid),
					Bin = ?CROSS_SECURITY,
					lib_send:send_to_sock(Socket, Bin),
					gen_tcp:controlling_process(Socket, self()),
					{noreply, State#state{socket = Socket, heartbeat_unixtime = Unixtime}};
				{error, Reason} ->
					%% 连接失败，达到一定次数暂停连接？ 10次失败，暂停5分钟，再重复尝试
					?ERROR_MSG("{connect_cross_server, Address, Port} Reason : ~p~n", [{Host, Port, Reason}]),
					State2 = 
						case BadCount + 1 > 10 of
							?true ->
								State#state{bad_count = 0, reconnect_unixtime = Unixtime + 300};
							?false ->
								State#state{bad_count = BadCount + 1}
						end,
					{noreply, State2}
			end;
		?false ->
			{noreply, State}
	end.


%% 这边解包需要处理包头，因为sm_reader和sm_writer那边底层已经处理了
handle_cross_msg(Socket, <<Len:16, Data:Len/binary-unit:8, Rest/binary>>) ->
%% 	spawn(fun() ->
%% 				  do_handle_cross_msg(Socket, Data)
%% 		  end),
	do_handle_cross_msg(Socket, Data),
	handle_cross_msg(Socket, Rest);

handle_cross_msg(_Socket, BinFrag) ->
	BinFrag.


%% 处理跨服服务器返回的消息
do_handle_cross_msg(Socket, ?CROSS_SECURITY) ->
	%% 收到安全串响应，第一步发送server_id给服务器那边初始化进程
	ServerId = config:get_server_id(),
	Msg = {server_id, ServerId},
	send_cross_msg(Socket, Msg);


do_handle_cross_msg(Socket, Packet) ->
	Data = erlang:binary_to_term(Packet),
	do_handle_cross_msg2(Socket, Data).

do_handle_cross_msg2(_Socket, heartbeat) ->
	%% 心跳，暂不做回应？，记录下当前时间戳
	gen_server:cast(?MODULE, heartbeat_unixtime),
	ok;

do_handle_cross_msg2(_Socket, same_node) ->
	gen_server:cast(?MODULE, same_node);

do_handle_cross_msg2(_Socket, {server_id, ServerIdTransfer}) ->
	gen_server:cast(?MODULE, {server_id_transfer, ServerIdTransfer});

do_handle_cross_msg2(Socket, #cross_msg{from_server = FromServer, type = Type, from_pid = FromPid, ref = Ref, mod = Module, func = Function, args = Args} = CM) ->
	%% 这里考虑了call函数需要等待的情况可能引起阻塞，一律子进程异步处理，防止执行过程中阻塞影响后续消息的处理
	Fun = fun() ->
				  try erlang:apply(Module, Function, Args) of
					  Reply ->
						  case Type of 
							  ?DEF_RPC_CALL ->
								  %% 需要回应
								  CrossMsgReply = #cross_msg_reply{from_server = FromServer, from_pid = FromPid, ref = Ref, reply = Reply},
								  send_cross_msg(Socket, CrossMsgReply);
							  _ ->
								  skip
						  end
				  catch
					  Error:Reason ->
						  ?ERROR_MSG("handle cross error : ~p~n", [{Error, Reason, erlang:get_stacktrace()}])
				  end
		  end,
	erlang:spawn(Fun);

do_handle_cross_msg2(Socket, #cross_msg_reply{from_pid = FromPid, ref = Ref, reply = Reply}) ->
	%% 回应给正在等待的call进程
	FromPid ! {Ref, Reply},
	ok.


send_cross_msg(Socket, Msg) when erlang:is_binary(Msg) ->
	lib_send:send_to_sock(Socket, Msg, true);

send_cross_msg(Socket, Term) ->
	BinData = erlang:term_to_binary(Term, [compressed]),
	send_cross_msg(Socket, BinData).
	

check_is_local_transfer(#state{is_local_transfer = IsLocalTransfer} = State) ->
	case IsLocalTransfer of
		1 ->
			{?true, State};
		_ ->
			case sm_cross_client_sup:get_child_pids() of
				[] ->
					?false;
				_ ->
					{?true, State#state{is_local_transfer = 1}}
			end
	end.

send_to_client_pid(#cross_msg{dist_server = []} = CrossMsg) ->
	%% 广播给所有节点的
	Pids = sm_cross_client_sup:get_child_pids(),
	[sm_cross_client:send_to_client_cast(Pid, CrossMsg) || Pid <- Pids];

send_to_client_pid(CrossMsg) ->
	#cross_msg{dist_server = DistServer} = CrossMsg,
	Fun = fun(ServerId) ->
				  RegName = sm_cross_client:client_regname(ServerId),
				  sm_cross_client:send_to_client_cast(RegName, CrossMsg)
		  end,
	lists:foreach(Fun, DistServer).

	