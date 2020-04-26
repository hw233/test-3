-module (mod_udp).

-behavour(gen_server).
-export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0]).

-compile(export_all).

-include("debug.hrl").
-include("common.hrl").

-record(state, {socket = null}).

-define(SEND_PORT, config:get_svr_udp_port()).
-define(ADMIN_RECV_PORT, config:get_adm_udp_port()).
-define(ADMIN_ADDR, config:get_adm_addr()).
-define(CHAT_MONITOR_PROTOCOL, 5001).

chat_monitor(Channel, Msg, Status) ->
	chat_monitor(Channel, Msg, Status, 0).

chat_monitor(Channel, Msg, Status, PlayerId2) ->
	PlayerId = player:id(Status),
	Account = player:get_accname(Status),
	PlayerName = player:get_name(Status),
	chat_monitor(Channel, Msg, PlayerName, PlayerId, PlayerId2, Account).

chat_monitor(Channel, Msg, PlayerName, PlayerId, PlayerId2, Account) ->
	case config:get_chat_monitor_switch() of
		true -> 
			gen_server:cast(mod_udp, {'chat_monitor', Channel, PlayerId, PlayerId2, Account, Msg, PlayerName});
		false -> 
			skip
	end,
	mod_chat:ban_sensitive(PlayerId, Account, Msg).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [?SEND_PORT], []).


-define(UDP_OPTION, [{active, false}]).

init([Port]) ->
    case gen_udp:open(Port, ?UDP_OPTION) of
        {ok, Socket} ->
            process_flag('trap_exit', true),
            gen_udp:controlling_process(Socket, self()),
            {ok, #state{socket = Socket}, 1000};
        _ -> error
    end.

handle_info(timeout, State) ->
    % spawn(fun() -> recv_msg(State) end),
    {noreply, State};

handle_info('test', State) ->
    PackData = pack_chat_monitor_data(<<0:16, <<"hello world">>/binary>>, <<"test">>),
    gen_udp:send(State#state.socket, ?ADMIN_ADDR, ?ADMIN_RECV_PORT, PackData),
    case get(set) of
        1 -> erlang:send_after(1, self(), 'test');
        _ -> skip
    end,
    % ?LDS_TRACE("OK"),
    case get(count) of
        Int when is_integer(Int) -> put(count, Int + 1);
        undefined -> put(count, 1)
    end,

    {noreply, State};

handle_info(_M, State) ->
    {noreply, State}.


handle_cast({'chat_monitor', Msg, Name}, State) ->
    case pack_chat_monitor_data(Msg, Name) of
        PackData when is_binary(PackData) -> 
            try gen_udp:send(State#state.socket, ?ADMIN_ADDR, ?ADMIN_RECV_PORT, PackData) of
                _ -> ok
            catch
                _E:_T -> ?ERROR_MSG("[mod_udp] chat_monitor error = ~p~n", [{_E, _T}]) 
            end;
        _ -> skip
    end,
    {noreply, State};

%% 新的聊天数据记录
handle_cast({'chat_monitor', Channel, PlayerId, PlayerId2, Account, Msg, Name}, State) ->
	case pack_chat_monitor_data2(Channel, PlayerId, PlayerId2, Account, Msg, Name) of
		PackData when is_binary(PackData) ->
			try gen_udp:send(State#state.socket, ?ADMIN_ADDR, ?ADMIN_RECV_PORT, PackData) of
				_ -> ok
			catch
				_E:_T -> ?ERROR_MSG("[mod_udp] chat_monitor error = ~p~n", [{_E, _T}]) 
			end;
		_ -> skip
	end,
	{noreply, State};


handle_cast({'send', Data}, State) ->
    % gen_udp:send(State#state.socket, 'localhost', ?ADMIN_RECV_PORT, tool:to_binary(Data)),
    _Time = timer:tc(gen_udp, send, [State#state.socket, 'localhost', ?SEND_PORT, tool:to_binary(Data)]),
    ?LDS_DEBUG("send", {_Time, Data}),
    {noreply, State};

handle_cast({'set', Flag}, State) ->
    put(set, Flag),
    self() ! 'test',
    ?LDS_DEBUG("end !!!!!", get(count)),
    {noreply, State};

handle_cast('count', State) ->
    ?LDS_DEBUG("count !!!!!", get(count)),
    {noreply, State};

handle_cast('reset_count', State) ->
    erase(count),
    {noreply, State};

handle_cast(_, State) ->
    {noreply, State}.

handle_call(_, _, State) ->
    {reply, [], State}.


code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


terminate(_Reason, State) ->
    gen_udp:close(State#state.socket),
    ok.


% recv_msg(#state{socket = Socket}) ->
%     case gen_udp:recv(Socket, 0) of
%         {ok, {Address, Port, Packet}} ->
%             ?LDS_DEBUG("upd recv data ", [{Address, Port, Packet}]),
%             recv_msg(#state{socket = Socket});
%         _ -> 
%             ?LDS_DEBUG("upd recv data error", []),
%             skip
%     end.


%% 打包协议数据， 修改消息传送结构，包括频道类型，玩家id
%% @return : null | binary()
pack_chat_monitor_data(<<_:16, Msg/binary>>, Name) when is_binary(Name) ->
    Content = <<Name/binary, 58:8, Msg/binary>>,
    % Len = byte_size(Content),
    ServerId = config:get_server_id(),
    <<?CHAT_MONITOR_PROTOCOL:16, ServerId:32, Content/binary>>;
pack_chat_monitor_data(_, _) -> null.


pack_chat_monitor_data2(Channel, PlayerId, PlayerId2, Account, <<_:16, Msg/binary>>, Name) when is_binary(Name) ->
	Content = <<Name/binary, 58:8, Msg/binary>>,
	ServerId = config:get_server_id(),
	BinAccount = util:to_binary(Account),
	LenAccount = byte_size(BinAccount),
	<<?CHAT_MONITOR_PROTOCOL:16, ServerId:32, Channel:8, PlayerId:64, PlayerId2:64, LenAccount:8, BinAccount/binary,  Content/binary>>;

pack_chat_monitor_data2(_, _, _, _, _, _) ->
	null.
	
	
	
	
	
	
	


