%%%-------------------------------------------------
%%% @Module  : mod_wrlog_svr (write log server)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.3.28
%%% @Description: 写日志服务
%%%-------------------------------------------------
-module(mod_wrlog_svr).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/1]).

-export([
        write_recv_proto_log/2,
        on_player_logout/1
    ]).

-include("common.hrl").
-include("record.hrl").
-include("log.hrl").


start_link(SeqNum) ->
	ServerName = list_to_atom("mod_wrlog_svr" ++ "_" ++ integer_to_list(SeqNum)),
	% ?TRACE("write log server name: ~p~n", [ServerName]),
    gen_server:start_link({local, ServerName}, ?MODULE, [], []).




write_recv_proto_log(RoleId, Info) ->
    ProcName = to_write_log_proc_name(RoleId),
    ?ASSERT(is_wrlog_server_alive(ProcName)),
    gen_server:cast(ProcName, {'write_recv_proto_log', RoleId, Info}).



on_player_logout(RoleId) ->
    ProcName = to_write_log_proc_name(RoleId),
    %% ?ASSERT(is_wrlog_server_alive(ProcName)),
    gen_server:cast(ProcName, {'on_player_logout', RoleId}).









%% ---------------------------------------------------------------------------

init([]) ->
    process_flag(trap_exit, true),
    {ok, null}.



	
handle_call(_Request, _From, State) ->
	?ASSERT(false, _Request),
    {reply, State, State}.


% handle_cast({'tmp_logout', PS, Delay}, State) ->
%     {noreply, State};




handle_cast({'write_recv_proto_log', RoleId, Info}, State) ->
    Fd = case get({recv_proto_log_file_fd, RoleId}) of
            undefined ->
                Fd0 = open_recv_proto_log_file(RoleId),
                put({recv_proto_log_file_fd, RoleId}, Fd0),
                Fd0;
            Fd0 ->
                Fd0
        end,
    case Fd of
        null ->
            skip;
        _ ->
            ?TRY_CATCH(file:write(Fd, Info), ErrReason)
    end,
    {noreply, State};


handle_cast({'on_player_logout', RoleId}, State) ->
    case get({recv_proto_log_file_fd, RoleId}) of
        undefined ->
            skip;
        null ->
            skip;
        Fd ->
            %%?DEBUG_MSG("[mod_wrlog_svr] on_player_logout(), close file, RoleId:~p", [RoleId]),
            close_recv_proto_log_file(Fd)
    end,
    erase({recv_proto_log_file_fd, RoleId}),
    ?ASSERT(get({recv_proto_log_file_fd, RoleId}) == undefined),
    {noreply, State};

        
    
handle_cast(_Msg, State) ->
	?ASSERT(false, _Msg),
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
	case Reason of
		normal -> skip;
		shutdown -> skip;
		_ -> ?ERROR_MSG("[mod_wrlog_svr] !!!!!terminate!!!!! for reason: ~w", [Reason])
	end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.





%%========================================== Local Functions ===============================================





is_wrlog_server_alive(ProcName) ->
    Pid = erlang:whereis(ProcName),
    is_pid(Pid) andalso is_process_alive(Pid).




to_write_log_proc_name(RoleId) ->
    Remainder = RoleId rem ?MAX_WRITE_LOG_SERVER_COUNT,
    Num = Remainder + 1,
    ServerName = list_to_atom("mod_wrlog_svr" ++ "_" ++ integer_to_list(Num)),
    ServerName.






open_recv_proto_log_file(RoleId) ->
    filelib:ensure_dir("./logs/recv_proto_logs/"),
    File = lists:concat(["./logs/recv_proto_logs/", "role-", integer_to_list(RoleId), ".log"]),

    BufSize = 2048,    % 2048 bytes
    Delay = 50 * 1000, % 50秒
    case file:open(File, [write, raw, binary, append, {delayed_write, BufSize, Delay}]) of
        {ok, Fd} ->
            Fd;
        Other ->
            ?ERROR_MSG("[mod_wrlog_svr] open_recv_proto_log_file() failed!!! RoleId:~p, info:~p", [RoleId, Other]),
            null
    end.
    


close_recv_proto_log_file(Fd) ->
    case file:close(Fd) of
        {error, _Reason} ->
            file:close(Fd);  % 因打开文件时使用了delayed_write选项，故这里尝试再次关闭，详见官方文档的说明
        _ ->
            done
    end.
