%%%-----------------------------------
%%% @Module  : sm_reader
%%% @Author  :
%%% @Email   :
%%% @Created : 2011.06.1
%%% @Description: 读取客户端
%%%-----------------------------------
-module(sm_reader).
-export([start_link/0, init/0]).

-include("common.hrl").
-include("account.hrl").
-include("abbreviate.hrl").
-include("pt_10.hrl").
-include("pt_12.hrl").
-include("pt_13.hrl").
-include("pt_61.hrl").
-include("player.hrl").
-include("ets_name.hrl").
-include("ban.hrl").
-include("framework.hrl").
-include("lginout.hrl").
-include("phone.hrl").


%%-define(TCP_TIMEOUT, 1000). % 解析协议超时时间
-define(HEART_TIMEOUT, (60000 + 10000)). % 心跳包超时时间（允许10秒的延迟）
-define(MAX_HEART_TIMEOUT_COUNT, 2). % 心跳包超时的最大允许次数
%%-define(MAX_HANDLE_CMD_ERROR_TIMES, 1). % 处理协议出错的最大允许次数
%%-define(HEADER_LENGTH, 4). % 消息头长度
%%-define(BAN_IP, 46001).   %IP封禁
%%-define(BAN_ACC, 46002).  %账号封禁



%% login step（登录流程，按先后顺序从小到大排列）
-define(LGN_STEP_BEGIN, 1).              % 登录流程开始：准备请求登录
-define(LGN_STEP_LOGIN_SUCCESS, 2).      % 已经登录成功
-define(LGN_STEP_GOT_ROLE_LIST, 3).      % 已经获取了角色列表
-define(LGN_STEP_IN_ACCESS_QUEUE, 4).    % 已经排队
-define(LGN_STEP_END, 5).                % 登录流程结束：选定一个角色并且进入了游戏


-define(PDKN_ALREADY_RECVED_FIRST_GAME_LOGIC_PROTO, pdkn_already_recved_first_game_logic_proto).
-define(PDKN_LAST_CHECK_PROTO_FREQ_TIME, pdkn_last_check_proto_freq_time).
-define(PDKN_RECVED_PROTO_COUNT, pdkn_recved_proto_count).
-define(PDKN_SHOULD_DO_LOST, pdkn_should_do_lost).
-define(PDKN_LOG_RID, pdkn_log_rid).
-define(PDKN_ALREADY_LOG_SKIP_PLOT, pdkn_already_log_skip_plot).
-define(PDKN_CUR_PROTO_SEQ_NUM, pdkn_cur_proto_seq_num).
-define(PDKN_ENTER_GAME_TIME, pdkn_enter_game_time).



%% 角色的简要信息
-record(role_brief, {
			id = 0,              	% 角色id
			%%% accid = 0,           	% 角色对应的账户id
			is_banned = false,   	% 是否被封禁了
			vip_lv = 0,           	% vip等级
			vip_expire_time = 0  	% vip过期时间（unix时间戳）
	}).

%%记录客户端进程
-record(client, {
			accname = "",   % 账户名
            player_pid = null,    % 玩家进程pid
            cur_login_step = ?LGN_STEP_BEGIN,   % 当前的登录步骤
            role_list = [],  % 账户下的角色列表， role_brief结构体列表
            cur_role_id = ?INVALID_ID,  % 账户下当前在线的角色
            last_try_create_role_time = 0,  % 上次尝试创建角色的时间戳（longunixtime, 精确到毫秒）
            acc_try_create_role_times = 0,  % 尝试创建角色的累计次数

            %%accid_list = [], % 账户id列表（合服后，同一个账户名可能对应有多个账户id）
            timeout_count = 0, % 超时（一定时间段内一直没有收到客户端发过来的数据包）的累计次数
            try_enter_game_failed_times = 0,  % 累计尝试进入游戏失败的次数

            %%handle_cmd_error_times = 0  % 累计处理协议出错的次数

            phone_info = #phone_info{},

            from_server_id = ?INVALID_ID   % 表示是从哪个服登录（合服之后，有必要知道此信息）
                                           % TODO：考虑：机器人登录代码是否需要调整？
     }).




start_link() ->
    {ok, proc_lib:spawn_link(?MODULE, init, [])}.

%%gen_server init
%%Host:主机IP
%%Port:端口
init() ->
    process_flag(trap_exit, true),
    Client = #client{
    			accname = "",
                player_pid = null,
                cur_login_step = ?LGN_STEP_BEGIN,
                role_list = [],
                cur_role_id = ?INVALID_ID,
                timeout_count = 0
            },
    receive
        {go, Socket} ->
        	?TRACE("go, Socket: ~p~n", [Socket]),

            SelfPid = self(),

            DistPid = spawn_link(fun() -> dispatch_msg(Socket, SelfPid, <<>>) end),

            {ok, SendPid} = sm_writer:start_link(Socket),

            nosql:set(sock_writer_map, Socket, SendPid),

            proc_logger:add_reader(SelfPid),
            proc_logger:add_recver(SelfPid, DistPid),
            proc_logger:add_sender(SelfPid, SendPid),

            erlang:put(send_pid, SendPid),

            gen_tcp:controlling_process(Socket, DistPid),

            login_parse_packet(Socket, Client, DistPid)
    end.

dist_bin(ReaderPid, Socket, Ref, <<Len:16, Data:Len/binary-unit:8, Rest/binary>>) ->
        ReaderPid ! {inet_async, Socket, Ref, {ok, Data}},
        dist_bin(ReaderPid, Socket, Ref, Rest);
dist_bin(_ReaderPid, _Socket, _Ref, Bin) ->
        Bin.

dispatch_msg(Socket, ReaderPid, BinFrag) ->
    case async_recv(Socket, ?HEART_TIMEOUT) of
        {error, Reason} ->
            ReaderPid ! {error_from_dispatch_msg, Reason};
        Ref ->
            receive
                {inet_async, Socket, Ref, {ok, Bin}} ->
                    BinFrag2 = dist_bin(ReaderPid, Socket, Ref, <<BinFrag/binary, Bin/binary>>),

                    dispatch_msg(Socket, ReaderPid, BinFrag2);

                {inet_async, Socket, Ref, {error, timeout}} ->
                    ReaderPid ! {inet_async, Socket, Ref, {error, timeout}},

                    dispatch_msg(Socket, ReaderPid, BinFrag);

                %%{inet_async, Socket, Ref, {error, Reason}} ->
                %%    ReaderPid ! {inet_async, Socket, Ref, {error, Reason}};

                Other ->
                    ReaderPid ! Other
            end
    end.







%% 接收并处理来自客户端的消息包：处理登录流程
%% @para: Socket => socket连接
%%        Client => client结构体
login_parse_packet(Socket, Client, DistPid) ->
    receive
		{inet_async, Socket, _Ref, {ok, ?CROSS_SECURITY}} ->
        %% 接收到跨服连接请求，初始化相关进程
        lib_send:send_to_sock(Socket, ?CROSS_SECURITY),    %% 回应给客户节点 ，客户节点收到这条消息就进入通讯阶段
        do_parse_packet_cross(Socket, Client, DistPid);
    {inet_async, Socket, _Ref, {ok, <<Cmd:16, Binary/binary>>}} ->
        ?TRACE("recv msg, Cmd:~p..........~n~n", [Cmd]),
        Ip = misc:get_ip(Socket),
			case get_ip_status(Ip) of
				ban ->
					notify_cli_login_failed(Socket, ?LOGIN_FAIL_IP_BANNED),
					timer:sleep(6000),  % 为什么要sleep？？
					login_lost(Socket, Client, DistPid, Cmd, {login_err, ip_banned});
				unban ->
          case catch routing(Cmd, Binary) of
            % 请求登录
            {ok, ?PT_LOGIN_REQ, Data} ->
              handle_login_request(Socket, Client, DistPid, Data);

            % 获取账户下的角色列表
            {ok, ?PT_GET_ACC_ROLE_LIST, _Data} ->
                handle_get_acc_role_list(Socket, Client, DistPid);
						
						% 检查角色名是否可用
						{ok, ?PT_CHECK_ROLE_NAME_REPEAT, [Name]} ->
							% 角色名是否有效？
							RetCode = 
								case lib_account:new_role_name_legal(Name) of
									{false, _Reason} ->
										1;
									true ->
										0
								end,
							{ok, BinData} = pt_10:write(?PT_CHECK_ROLE_NAME_REPEAT, [RetCode]),
							lib_send:send_to_sock(Socket, BinData),
							login_parse_packet(Socket, Client, DistPid);

            % 创建角色
            {ok, ?PT_CREATE_ROLE, Data} ->
              handle_create_role(Socket, Client, DistPid, Data);

						% 删除角色（现在是通过npc删除角色，故注释掉代码！）
						% {ok, ?PT_DI SCARD_ROLE, Id} ->
						% 	handle_discard_role(Socket, Client, DistPid, Id);

						% TODO: 游客模式
							%%{ok, new_role, [AccId, Sex, Race, Name]} ->
							% ...
            % 记录剧情跳过日志（跳过开头的剧情CG）
            {ok, [?PT_PLYR_C2S_LOG_PLOT, State]} ->
                case erlang:get(?PDKN_ALREADY_LOG_SKIP_PLOT) of
                    true ->
                        ?ASSERT(false),
                        login_lost(Socket, Client, DistPid, 0, "login fail");
                    _ ->
                        RoleId =
                            case erlang:get(?PDKN_LOG_RID) of
                                Int when is_integer(Int) -> Int;
                                _ -> 0
                            end,
                        catch lib_log:plot_skip_record(RoleId, State),
                        erlang:put(?PDKN_ALREADY_LOG_SKIP_PLOT, true),
                        login_parse_packet(Socket, Client, DistPid)
                end;
            % 请求进入游戏
            {ok, ?PT_ENTER_GAME, RoleId} ->
                    handle_request_enter_game(Socket, Client, DistPid, RoleId);

						% 心跳包
						{ok, heartbeat} ->
							% 回复心跳包 -- 目前屏蔽掉，不回复
							% {ok, BinData} = pt_10:write(?PT_CONNECTION_HEARTBEAT, []),
    			% 			lib_send:send_to_sock(Socket, BinData),
							login_parse_packet(Socket, Client, DistPid);
                        {ok, OtherPtID, Data} ->
                                case (OtherPtID >= ?PT_MONITOR_COME) and (OtherPtID < ?PT_ACC_QUEUE_START_WAIT) of
                                        true ->
                                                case misc:check_ip_validity_config(Ip) of
                                                    true ->
                                                        ?TRY_CATCH(monitor:handle_msg(Socket, OtherPtID, Data)),

                                                        login_parse_packet(Socket, Client, DistPid);
                                                    false ->
                                                        login_lost(Socket, Client, DistPid, Cmd, monitor_ip_invalid)
                                                end;    
                                        false ->
                                                case OtherPtID of
                                                    ?PT_ACC_QUEUE_QUERY_INDEX ->
                                                        access_queue_svr:query_index(Socket),

                                                        login_parse_packet(Socket, Client, DistPid);
                                                    ?PT_ACC_QUEUE_SET_MAX_POL ->
                                                        access_queue_svr:set_max_play_ol_num(Socket, Data),

                                                        login_parse_packet(Socket, Client, DistPid);
                                                    ?PT_ACC_QUEUE_GET_OL_INFO ->
                                                        access_queue_svr:query_online_info(Socket),

                                                        login_parse_packet(Socket, Client, DistPid);
                                                    _Other ->
                                                        login_lost(Socket, Client, DistPid, Cmd, {ok, OtherPtID, Data})
                                                end
                                end;
            		    Other ->
            		        login_lost(Socket, Client, DistPid, Cmd, Other)
            		end
			end;

        % 超时
	    {inet_async, Socket, _Ref, {error,timeout}} ->
        	?TRACE("[sm_reader] login_parse_packet() inet_async error: timeout......!~n"),
            case config:if_check_heartbeat_timeout(?APP_SERVER) of
        		false ->
        			login_parse_packet(Socket, Client#client{timeout_count = Client#client.timeout_count + 1}, DistPid);
        		true ->
        			case Client#client.timeout_count >= ?MAX_HEART_TIMEOUT_COUNT of
		                true ->
		                    login_lost(Socket, Client, DistPid, 0, {error,timeout});
		                false ->
		                    login_parse_packet(Socket, Client#client{timeout_count = Client#client.timeout_count + 1}, DistPid)
		            end
        	end;

        {do_enter_game, [RoleId]} ->
            do_enter_game(Socket, Client, DistPid, RoleId);

        {login_lost, [?PT_ENTER_GAME, {error,server_full}]} ->
            login_lost(Socket, Client, DistPid, ?PT_ENTER_GAME, {error,server_full});

        % 用户断开连接或出错
        Other ->
        	?TRACE("[sm_reader] login_parse_packet() error, **Reason: ~p~n", [Other]),
            login_lost(Socket, Client, DistPid, 0, Other)
    end.


%% 接收并处理来自跨服节点的消息包
%% @para: Socket => socket连接
%%        Client => client结构体
do_parse_packet_cross(Socket, Client, DistPid) ->
    receive
        {inet_async, Socket, _Ref, {ok, Binary}} ->
			%% 约定先传server_id过来开启进程?
%%         	?TRACE("recv msg, Cmd:~p..........~n~n", [Cmd]),
			Msg = erlang:binary_to_term(Binary),
			ProcKey = proc_cross_client,
			ServerIdKey = serverid_cross_client,
			case Msg of
%% 				heartbeat ->
%% 					%% 心跳包
%% 					do_parse_packet_cross(Socket, Client, DistPid);
				{server_id, ServerId} ->%% 接收server_id,标记对方是哪个服务器
					
					case config:get_server_id() of
						ServerId ->
							sm_cross_client:send_cross_msg(Socket, same_node),
							do_parse_packet_cross(Socket, Client, DistPid);
						_ ->
							CrossClientPid = init_cross_client_proc(ServerId, Socket, ProcKey, ServerIdKey),
							sm_cross_client:send_to_client_cast(CrossClientPid, {server_id, config:get_server_id()}),
							do_parse_packet_cross(Socket, Client, DistPid)
					end;
				_ ->
					%% Cross Msg 交由进程处理?
					%% 用别名来判断即可
					%% 判断clinet进程是否存在，
					case erlang:get(ProcKey) of
						?undefined ->
							case erlang:get(ServerIdKey) of
								?undefined ->
									?ERROR_MSG("Binary : ~p~n", [Binary]);
								ServerId ->
									CrossClientPid = init_cross_client_proc(ServerId, Socket, ProcKey, ServerIdKey),
									sm_cross_client:handle_cross_msg_cast(CrossClientPid, Socket, Msg)
							end;
					 	CrossClientPid ->
							sm_cross_client:handle_cross_msg_cast(CrossClientPid, Socket, Msg)
					end,
					do_parse_packet_cross(Socket, Client, DistPid)
			end;
        % 超时
	    {inet_async, Socket, _Ref, {error,timeout}} ->
        	?TRACE("[sm_reader] login_parse_packet() inet_async error: timeout......!~n"),
            login_lost(Socket, Client, DistPid, 0, {error,timeout});
		
        % 用户断开连接或出错
        Other ->
        	?TRACE("[sm_reader] login_parse_packet() error, **Reason: ~p~n", [Other]),
            login_lost(Socket, Client, DistPid, 0, Other)
    end.


init_cross_client_proc(ServerId, Socket, ProcKey, ServerIdKey) ->
	Pid = get_cross_client_proc(ServerId, Socket),%% 开启相应的client进程管理通信连接
	erlang:put(ProcKey, Pid),
	erlang:put(ServerIdKey, ServerId),
	Pid.

%% 获取对应的server_id的进程别名 
get_cross_client_proc(ServerId, Socket) -> 
	RegName = sm_cross_client:client_regname(ServerId),
	case erlang:whereis(RegName) of
		?undefined ->
			{ok, Child} = supervisor:start_child(sm_cross_client_sup, [RegName, Socket]),
			erlang:put(proc_cross_client, Child),
			Child;
		Pid ->
			%% 更新socket？
			sm_cross_client:update_socket(Pid, Socket),
			Pid
	end.

%% 登录并且进入游戏后，接收并处理来自客户端的消息包：处理游戏逻辑
%% @para: Socket => socket连接
%%        Client => client结构体
do_parse_packet(Socket, Client, DistPid) ->
    RoldId = Client#client.cur_role_id,
    receive
        {inet_async, Socket, _Ref, {ok, <<Cmd:16, Binary/binary>>}} ->
            case Cmd of
                ?PT_ACC_QUEUE_QUERY_INDEX ->  % 不需处理此协议
                    do_parse_packet(Socket, Client, DistPid);
                _ ->
                    try
                        {ok, Data} = routing2(RoldId, Cmd, Binary),
                        {ok, _Res} = gen:call(Client#client.player_pid, '$gen_call', {'SOCKET_EVENT', Cmd, Data}) % 处理游戏逻辑
                    catch
                        _:__Reason ->
                            ?LDS_DEBUG(__Reason),
                            erlang:put(?PDKN_SHOULD_DO_LOST, {true, __Reason})
                    end,

                    case erlang:get(?PDKN_SHOULD_DO_LOST) of
                        {true, Reason} ->
                            ?ERROR_MSG("do_parse_packet(), handle cmd error!! Client:~w, Cmd:~p, Binary:~w, Reason:~w", [Client, Cmd, Binary, Reason]),
                            do_lost(Socket, Client, DistPid, Cmd, {handle_cmd_error, Reason});
                        _ ->
                            do_parse_packet(Socket, Client, DistPid)
                    end
            end;        

        % 超时
        {inet_async, Socket, _Ref, {error,timeout}} ->
        	?TRACE("[sm_reader] do_parse_packet(), inet_async error: heartbeat timeout......!~n"),
        	case config:if_check_heartbeat_timeout(?APP_SERVER) of
        		false ->
        			do_parse_packet(Socket, Client#client{timeout_count = Client#client.timeout_count + 1}, DistPid);
        		true ->
        			case Client#client.timeout_count >= ?MAX_HEART_TIMEOUT_COUNT of
		                true ->
		                    do_lost(Socket, Client, DistPid, 0, {error,timeout});
		                false ->
		                    do_parse_packet(Socket, Client#client {timeout_count = Client#client.timeout_count + 1}, DistPid)
		            end
        	end;

        % 用户断开连接或出错
        Other ->
        	?TRACE("[sm_reader] do_parse_packet() error, **Reason: ~w~n", [Other]),
            do_lost(Socket, Client, DistPid, 0, Other)
    end.


%%断开连接
login_lost(Socket, Client, DistPid, Cmd, Reason) ->
	Atom = case Reason of
			   {inet_async, _, _, {error,closed}} -> % 该错误不让SASL生成crash report
				   ?TRACE("######## login_lost: client closed ip: ~p########~n", [misc:get_ip(Socket)]),
				   shutdown;
			   {inet_async, _, _, {error,etimedout}} ->
				   ?TRACE("######## login_lost: etimedout ########~n"),
				   shutdown;
			   {error, timeout} -> % 该错误写到log里，不让SASL生成crash report
				   shutdown;
               {error, server_full} ->
                   shutdown;
               {login_err, _} ->
				   ?TRACE("######## login_lost: ~p ########~n", [Reason]),
                   shutdown;
			   "login fail" ->
				   ?TRACE("######## login_lost: login fail ########~n"),
				   shutdown;
               monitor_ip_invalid ->
                   ?TRACE("######## login_lost: monitor_ip_invalid ########~n"),
                   shutdown;
               {error_from_dispatch_msg, _} ->
                   error_from_dispatch_msg;
               {error, proto_illegal} ->
                   shutdown;
			   _ ->
				   unexpected_message
		   end,
	?INFO_MSG("[sm_reader] login_lost(), Cmd:~p, Atom:~p, Reason:~w", [Cmd, Atom, Reason]),

    case Client#client.cur_login_step == ?LGN_STEP_IN_ACCESS_QUEUE of
        true ->
            case Reason of
                {error, server_full} ->
                    pass;
                _Other ->
                    access_queue_svr:exit(Socket, Client#client.accname)
            end;
        false ->
            pass
    end,

    nosql:del(sock_writer_map, Socket),

    gen_tcp:close(Socket),

    proc_logger:del_reader(self()),

    exit(DistPid, kill),
    exit({Atom, {Cmd, Reason}}).




-define(CLEANUP_RESIDUAL_PLAYER_PROC_DELAY_TIME, ?MAX_HANDLE_LOGOUT_TIME).


%%退出游戏
do_lost(Socket, Client, DistPid, Cmd, Reason) ->
	?TRACE("[sm_reader] do_lost(), RoleId:~p, Cmd:~p, Reason:~w~n", [Client#client.cur_role_id, Cmd, Reason]),

    access_queue_svr:exit(Socket, Client#client.accname),

	Atom = case Reason of
			   {inet_async, _, _, {error,closed}} -> % 表示是客户端主动关闭tcp连接。 该错误不让SASL生成crash report
				   ?TRACE("######## do_lost: client closed, RoleId:~p ########~n", [Client#client.cur_role_id]),
				   shutdown;
			   {inet_async, _, _, {error,etimedout}} ->
				   ?TRACE("######## do_lost: etimedout ########~n"),
				   shutdown;
			   {error, timeout} ->
				   ?TRACE("######## do_lost: {error,timeout}, Cmd:~p ########~n", [Cmd]),
				   ?INFO_MSG("sm_reader:do_lost, cmd:~p, reason:~w", [Cmd, Reason]),
				   shutdown;
               {error, server_full} ->
                   shutdown;
			   {'EXIT', _, normal} ->  % 如： {'EXIT',#Port<0.4109>,normal}格式的Reason表示是服务端主动关闭了tcp连接
				   ?TRACE("######## do_lost: ~p ########~n", [Reason]),
				   ?INFO_MSG("sm_reader:do_lost, cmd:~p, reason:~w", [Cmd, Reason]),
				   shutdown;
               {error_from_dispatch_msg, _} ->
                   ?INFO_MSG("sm_reader:do_lost, cmd:~p, reason:~w", [Cmd, Reason]),
                   error_from_dispatch_msg;
               {player_proc_terminate, _RoleId, _RolePid} -> % 玩家进程终止
                   ?TRACE("######## do_lost: player_proc_terminate(RoleId:~p, RolePid:~p) ########~n", [_RoleId, _RolePid]),
                   ?INFO_MSG("sm_reader:do_lost, cmd:~p, reason:~w", [Cmd, Reason]),
                   shutdown;
                {player_proc_crash, _RoleId, _RolePid} -> % 玩家进程crash（bug导致）
                   ?TRACE("######## do_lost: player_proc_crash(RoleId:~p, RolePid:~p) ########~n", [_RoleId, _RolePid]),
                   ?INFO_MSG("sm_reader:do_lost, cmd:~p, reason:~w", [Cmd, Reason]),
                   shutdown;
               {handle_cmd_error, ReasonDetails} ->  % 处理协议出错
                   case ReasonDetails of
                        normal ->
                            shutdown;
                        {shutdown, server_stop} -> % 表示是由于关服而引起协议处理出错，不让SASL生成crash report
                            %%?INFO_MSG("do_lost() for {shutdown, server_stop}, RoleId:~p", [Client#client.cur_role_id]),
                            shutdown;
                        _ ->
                            ?INFO_MSG("sm_reader:do_lost, cmd:~p, reason:~w", [Cmd, Reason]),
                            handle_cmd_error
                   end;
			   _ ->
				   ?INFO_MSG("sm_reader:do_lost, cmd:~p, reason:~w", [Cmd, Reason]),
				   unexpected_message
		   end,
	%%?TRACE("[sm_reader] do_lost(), before calling mod_login:force_disconnect(), CurRoleId=~p, PlayerPid=~p...~n", [Client#client.cur_role_id, Client#client.player_pid]),

    case Reason of
        {player_proc_crash, _, _} -> skip;      %% ?DEBUG_MSG("do_lost(), player_proc_crash, so skip, RoleId:~p", [Client#client.cur_role_id]),
        {player_proc_terminate, _, _} -> skip;  %% ?DEBUG_MSG("do_lost(), player_proc_terminate, so skip, RoleId:~p", [Client#client.cur_role_id]),
        _ ->
            mod_login:force_disconnect(Client#client.accname, Client#client.from_server_id, Client#client.cur_role_id, Client#client.player_pid),
            % 添加作业计划：检测玩家进程是否alive，如果alive，则kill之
            % ?DEBUG_MSG("[sm_reader] do_lost(), before add cleanup residual player proc sch, PlayerId:~p, PlayerPid:~p", [Client#client.cur_role_id, Client#client.player_pid]),
            mod_sys_jobsch:add_sch_cleanup_residual_player_proc(Client#client.cur_role_id, Client#client.player_pid, ?CLEANUP_RESIDUAL_PLAYER_PROC_DELAY_TIME)
    end,

    case config:need_to_log_recved_proto(?APP_SERVER) of
        true -> mod_wrlog_svr:on_player_logout(Client#client.cur_role_id);
        false -> skip
    end,

    nosql:del(sock_writer_map, Socket),

    gen_tcp:close(Socket),

    proc_logger:del_reader(self()),

    exit(DistPid, kill),
    exit({Atom, {Cmd, Reason}}).



%% 是否非游戏业务逻辑的协议？
is_non_game_logic_proto(Cmd) ->
    (Cmd >= 61000)
    andalso (Cmd =< 61999)
    andalso (Cmd /= ?PT_ACC_QUEUE_START_WAIT)
    andalso (Cmd /= ?PT_ACC_QUEUE_QUERY_INDEX)
    andalso (Cmd /= ?PT_ACC_QUEUE_SERVER_FULL).


%%路由
%%组成如:pt_10:read
routing(Cmd, CmdBody) ->
    %%取前面二位区分功能类型
 	?TRACE("***cmd: ~p~n",[Cmd]),
    [H1, H2, _, _, _] = integer_to_list(Cmd),
    Module = list_to_atom("pt_"++[H1,H2]),

    case is_non_game_logic_proto(Cmd) of
        true ->
            Module:read(Cmd, CmdBody);
        false ->
            case is_proto_legal(Cmd, CmdBody) of
                {true, ProtoSeqNum, ActualCmdBody} ->
                    set_cur_proto_seq_num(ProtoSeqNum),  % 更新协议序号
                    Module:read(Cmd, ActualCmdBody);
                false ->
                    ?DEBUG_MSG("routing(), proto_illegal!! Cmd:~p, CmdBody:~w", [Cmd, CmdBody]),
                    {error, proto_illegal}
            end             
    end.



%%路由
%%组成如:pt_10:read
routing2(RoleId, Cmd, CmdBody) ->
    %%取前面二位区分功能类型
    ?TRACE("***cmd: ~p~n",[Cmd]),

    case check_proto_freq() of
        ok ->
            case is_proto_legal(Cmd, CmdBody) of
                {true, ProtoSeqNum, ActualCmdBody} ->
                    set_cur_proto_seq_num(ProtoSeqNum),  % 更新协议序号

                    maybe_log_recved_proto(RoleId, Cmd),

                    [H1, H2, _, _, _] = integer_to_list(Cmd),
                    Module = list_to_atom("pt_"++[H1,H2]),
                    Module:read(Cmd, ActualCmdBody);
                false ->
                    ?WARNING_MSG("routing2(), proto_illegal!! RoleId:~p, Cmd:~p, CmdBody:~w", [RoleId, Cmd, CmdBody]),
                    {error, proto_illegal}
            end;    
        _ ->
            {error, cli_msg_freq_too_high, get_recved_proto_count()}
    end.



%% 是否需要做协议合法性的检测？
need_to_check_proto() ->
    true.


%% 检测客户端发送的协议是否合法
%% @return: {true, 实际有效的协议体} | false
-ifdef(debug).
is_proto_legal(Cmd, CmdBody) ->
	CmdBodyLen = byte_size(CmdBody),
	case CmdBodyLen >= 8 of
        true ->
			ActualCmdBodyLen = CmdBodyLen - 8,
			case CmdBody of
                <<ProtoSeqNum:32, ActualCmdBody:ActualCmdBodyLen/binary-unit:8, CheckCode:32>> ->
                    {true, ProtoSeqNum, ActualCmdBody};    
                _ ->
                    % ?ASSERT(false, {Cmd, CmdBody}),
                    ?DEBUG_MSG("proto illegal, CmdBody content error! Cmd:~p, CmdBody:~p", [Cmd, CmdBody]),
                    false
            end;
		false ->
			false
	end.
-else.
is_proto_legal(Cmd, CmdBody) ->
    CmdBodyLen = byte_size(CmdBody),
    case CmdBodyLen >= 8 of
        true ->
            ActualCmdBodyLen = CmdBodyLen - 8,
            case CmdBody of
                <<ProtoSeqNum:32, ActualCmdBody:ActualCmdBodyLen/binary-unit:8, CheckCode:32>> ->
                    % ?DEBUG_MSG("proto illegal, Cmd:~p, ProtoSeqNum:~p, CheckCode:~p, ActualCmdBody:~p", [Cmd, ProtoSeqNum, CheckCode, ActualCmdBody]),
                    % ?DEBUG_MSG("is_proto_seq_num_legal:~p, is_check_code_legal:~p, get_cur_proto_seq_num:~p, pt:calc_check_code:~p", 
                    %                 [
                    %                 is_proto_seq_num_legal(ProtoSeqNum), 
                    %                 is_check_code_legal(Cmd, CmdBody, CheckCode),
                    %                 get_cur_proto_seq_num(),
                    %                 begin _ToCheckBinLen = byte_size(CmdBody) - 4, <<_ToCheckBin:_ToCheckBinLen/binary-unit:8, _/binary>> = CmdBody, pt:calc_check_code(Cmd, _ToCheckBin) end
                    %                 ]
                    %           ),

                    case need_to_check_proto() of
                        true ->
                            case is_proto_seq_num_legal(ProtoSeqNum)
                            andalso is_check_code_legal(Cmd, CmdBody, CheckCode) of
                                true ->
                                    {true, ProtoSeqNum, ActualCmdBody};
                                false ->
                                    % ?ASSERT(false),
                                    false
                            end;
                        false ->
                            {true, ProtoSeqNum, ActualCmdBody}
                    end;    
                _ ->
                    % ?ASSERT(false, {Cmd, CmdBody}),
                    ?DEBUG_MSG("proto illegal, CmdBody content error! Cmd:~p, CmdBody:~p", [Cmd, CmdBody]),
                    false
            end;
        false ->
            ?DEBUG_MSG("proto illegal, CmdBody too short! Cmd:~p, CmdBody:~p", [Cmd, CmdBody]),
            false
    end.      
-endif.


is_proto_seq_num_legal(ProtoSeqNum) ->
    Diff = ProtoSeqNum - get_cur_proto_seq_num(),
    Diff > 0.


get_cur_proto_seq_num() ->
    case erlang:get(?PDKN_CUR_PROTO_SEQ_NUM) of
        undefined -> 0;
        Val -> Val
    end.

set_cur_proto_seq_num(Num) ->
    ?ASSERT(is_integer(Num)),
    erlang:put(?PDKN_CUR_PROTO_SEQ_NUM, Num).




is_check_code_legal(Cmd, CmdBody, CheckCode) ->
    case Cmd of
        ?PT_PLAYER_MOVE ->
            true;
        _ ->
            ToCheckBinLen = byte_size(CmdBody) - 4, 
            <<ToCheckBin:ToCheckBinLen/binary-unit:8, _/binary>> = CmdBody,
            ?ASSERT(is_binary(ToCheckBin) andalso (byte_size(ToCheckBin) == ToCheckBinLen)),


            % ?DEBUG_MSG("is_check_code_legal(), Cmd:~p, CmdBody:~w, ToCheckBin:~w", [Cmd, CmdBody, ToCheckBin]),
            CheckCode == pt:calc_check_code(Cmd, ToCheckBin)
    end.
            




get_last_check_proto_freq_time() ->
    case erlang:get(?PDKN_LAST_CHECK_PROTO_FREQ_TIME) of
        undefined ->
            0;
        Time ->
            Time
    end.

set_last_check_proto_freq_time(Time) ->
    erlang:put(?PDKN_LAST_CHECK_PROTO_FREQ_TIME, Time).


get_recved_proto_count() ->
    case erlang:get(?PDKN_RECVED_PROTO_COUNT) of
        undefined ->
            0;
        Count ->
            Count
    end.

incr_recved_proto_count() ->
    NewCount = get_recved_proto_count() + 1,
    erlang:put(?PDKN_RECVED_PROTO_COUNT, NewCount).


zero_recved_proto_count() ->
    erlang:put(?PDKN_RECVED_PROTO_COUNT, 0).



get_enter_game_time() ->
    erlang:get(?PDKN_ENTER_GAME_TIME).

set_enter_game_time(UnixTime) ->
    erlang:put(?PDKN_ENTER_GAME_TIME, UnixTime).


%% 是否刚进入游戏不久？
is_just_enter_game(CurTime) ->
    TimeElapsed = CurTime - get_enter_game_time(),
    TimeElapsed < 30.

    
-ifdef(debug).
check_proto_freq() ->
	ok.
-else.
check_proto_freq() ->
    incr_recved_proto_count(),
    CurTime = svr_clock:get_unixtime(),
    LastCheckTime = get_last_check_proto_freq_time(),
    case (CurTime - LastCheckTime) > config:get_check_proto_freq_intv() of
        true ->
            set_last_check_proto_freq_time(CurTime),
            RecvedProtoCount = get_recved_proto_count(),
            MaxAllowedCount = case is_just_enter_game(CurTime) of
                                  true -> config:get_max_allowed_proto_per_intv() * 2; % 刚进入游戏时，客户端会发送较多的协议过来，故放宽限制
                                  false -> config:get_max_allowed_proto_per_intv()
                              end,
            case RecvedProtoCount > MaxAllowedCount of
                true ->
                    % ?TRACE("check_proto_freq() error!!!! RecvedProtoCount:~p, CurTime:~p,  LastCheckTime:~p....~n", [RecvedProtoCount, CurTime, LastCheckTime]),
                    {error, too_many_proto};
                false ->
                    % ?TRACE("check_proto_freq() ok, RecvedProtoCount:~p, CurTime:~p,  LastCheckTime:~p....~n", [RecvedProtoCount, CurTime, LastCheckTime]),
                    zero_recved_proto_count(),  % 归零
                    ok
            end;
        false ->
            % ?TRACE("check_proto_freq() not need now, RecvedProtoCount:~p, CurTime:~p, LastCheckTime:~p....~n", [get_recved_proto_count(), CurTime, LastCheckTime]),
            ok
    end.
-endif.



maybe_log_recved_proto(RoleId, Cmd) ->
    case config:need_to_log_recved_proto(?APP_SERVER) of
        true ->
            Info =  case erlang:get(?PDKN_ALREADY_RECVED_FIRST_GAME_LOGIC_PROTO) of
                        undefined ->
                            erlang:put(?PDKN_ALREADY_RECVED_FIRST_GAME_LOGIC_PROTO, true),
                            io_lib:format("\n\n\n\n\n\n\n\n==================\n~p: ~p\n",[svr_clock:get_unixtime(), Cmd]);  % 前面添加几个空行，以隔开上一次进游戏时所记录的已接收协议
                        true ->
                            io_lib:format("~p: ~p\n",[svr_clock:get_unixtime(), Cmd])
                    end,
            mod_wrlog_svr:write_recv_proto_log(RoleId, Info);
        false ->
            skip
    end.


%% 接受信息
async_recv(Sock, Timeout) when is_port(Sock) ->
    case prim_inet:async_recv(Sock, 0, Timeout) of
        {error, Reason} -> {error, Reason};  %% 旧代码：throw({Reason});  是错误的做法！ -- huangjf
        {ok, Res}       -> Res;
        Res             -> Res
    end.


% %%封禁账号(角色ID)操作
% ban_account(Id) ->
% 	case db:select_row(t_ban_account_list, "end_time", [{role_id, Id}]) of
% 		[] ->
% 			unban;
% 		[EndTime] ->
% 			NowTime = util:unixtime(),
% 			if
% 				NowTime > EndTime ->
% 					unban;
% 				true ->
% 					ban
% 			end
% 	end.

%%取得IP封禁状态
get_ip_status(Ip) ->
    case ets:lookup(?ETS_BANNED_IP, Ip) of
        [] -> unban;
        [Rd | _] ->
            EndTime = Rd#banned_ip.end_time,
            NowTime = util:unixtime(),
            if  EndTime =:= ?CANCEL_BAN_TIME ->
                    ets:delete(?ETS_BANNED_IP, Ip),
                    unban;
                EndTime =:= ?FORVER_BAN_TIME -> ban;
                true ->
                    case NowTime > EndTime of
                        true -> ets:delete(?ETS_BANNED_IP, Ip), unban;
                        false -> ban
                    end
            end
    end.


	% case db:select_row(t_ban_ip_list, "end_time", [{ip, Ip}]) of
	% 	[] ->
	% 		unban;
 %        [?FORVER_BAN_TIME] -> ban;
	% 	[EndTime] ->
	% 		NowTime = util:unixtime(),
	% 		if
	% 			NowTime > EndTime ->
	% 				unban;
	% 			true ->
	% 				ban
	% 		end
	% end.


% %% 发消息给客户端
% send_msg(Socket) ->
%     receive
%         {send, Bin} ->
%             % gen_tcp:send(Socket, Bin),
%             lib_send:send_to_sock(Socket, Bin),
%             send_msg(Socket)
%         % _Any ->
%         % 	?ASSERT(false, _Any),
%         %     send_msg(Socket)
%     end.



%% 通知客户端：登录失败
notify_cli_login_failed(Socket, Reason) ->
	{ok, BinData} = pt_10:write(?PT_LOGIN_REQ, Reason),
    lib_send:send_to_sock(Socket, BinData).


%% 通知客户端：登录成功
notify_cli_login_success(Socket) ->
	?TRACE("notify_cli_login_success()...~n"),
	{ok, BinData} = pt_10:write(?PT_LOGIN_REQ, ?RES_OK),
    lib_send:send_to_sock(Socket, BinData).



%% 做登录验证
%% @return: ok | fail
login_auth(Data) ->
	case config:need_md5_login_auth() of
		false ->
			ok;
		true ->
            [TimeStamp, AccName, Md5AuthStr | _T] = Data,
			try is_bad_auth(TimeStamp, AccName, Md5AuthStr) of
				true -> fail;
				false -> ok
			catch
				_:_ -> fail
			end
	end.



%% md5登录验证字串是否有误（true | false）
is_bad_auth(TimeStamp, AccName, Md5AuthStr) ->
	Str = AccName ++ integer_to_list(TimeStamp) ++ ?TICKET, %% ++ integer_to_list(Infant_state),
	Md5Str_Hex = util:md5(Str),
	%%?DEBUG_MSG("~p~n~p~n", [Str, Md5Str_Hex]),
    ?TRACE("Client Md5AuthStr:~p, Server Md5Str_Hex:~p~n", [Md5AuthStr, Md5Str_Hex]),
	Md5AuthStr /= Md5Str_Hex.



%% 处理登录请求
handle_login_request(Socket, Client, DistPid, Data) ->
	?TRACE("[sm_reader] handle_login_request()...~n"),
	% 当前登录步骤是否正确？
	case Client#client.cur_login_step /= ?LGN_STEP_BEGIN of
		true ->
			?ASSERT(false, Client#client.cur_login_step),
			login_lost(Socket, Client, DistPid, 0, "login fail");
		false ->
			case sm:get_server_open_state() of
				closed ->  % 服务器未开启
					notify_cli_login_failed(Socket, ?LOGIN_FAIL_SERVER_CLOSED),
					timer:sleep(2000),
					login_lost(Socket, Client, DistPid, 0, {login_err, server_closed});  % 直接退出，不尾递归
				open -> % 服务器已开启
					% 验证信息是否正确？
					case login_auth(Data) of
						ok ->
							% TODO: 对于防沉迷的处理，以后视情况再决定是否打开，或者同样改为在进入游戏时才做此检测...
							% ...

							[_TimeStamp, AccName, _Ticket, PhoneModel, PhoneMAC, FromServerId0] = Data,
							?ASSERT(is_list(AccName)),

                            FromServerId =  case FromServerId0 of
                                                ?INVALID_ID ->  % 若是机器人登录，则执行此分支（以配置选项中的server_id值代替之)
                                                    % ?WARNING_MSG("handle_login_request(), AccName:~p, FromServerId0 invalid!", [AccName]),
                                                    config:get_server_id();
                                                _ ->
                                                    FromServerId0
                                            end,

                            ?DEBUG_MSG("handle_login_request(), AccName:~p, FromServerId0:~p, FromServerId:~p", [AccName, FromServerId0, FromServerId]),

							Client2 = Client#client{
												cur_login_step = ?LGN_STEP_LOGIN_SUCCESS,
												accname = AccName,
                                                phone_info = #phone_info{model = PhoneModel, mac = PhoneMAC},
                                                from_server_id = FromServerId
												},

							notify_cli_login_success(Socket),

							% 上层函数尾递归
							login_parse_packet(Socket, Client2, DistPid);
						fail ->
							notify_cli_login_failed(Socket, ?LOGIN_FAIL_AUTH_FAILED),
							timer:sleep(100),
							login_lost(Socket, Client, DistPid, 0, {login_err, auth_failed})  % 直接退出，不尾递归
					end
			end
	end.



make_role_brief(Id, IsBanned, VipLv, VipExpireTime) ->
	#role_brief{
		id = Id,
		is_banned = util:oz_to_bool(IsBanned),  % 数字1或0转为true或false
		vip_lv = VipLv,
		vip_expire_time = VipExpireTime
		}.



%% 获取账户下的角色列表
handle_get_acc_role_list(Socket, Client, DistPid) ->
	?TRACE("[sm_reader] handle_get_acc_role_list()...~n"),
	% 当前登录步骤是否正确？
	case Client#client.cur_login_step /= ?LGN_STEP_LOGIN_SUCCESS of
	    true ->
	    	?ASSERT(false, Client#client.cur_login_step),
	    	% 直接退出，不尾递归
	        login_lost(Socket, Client, DistPid, 0, "login fail");
	    false ->
	        case lib_account:db_get_role_list(Client#client.accname) of
                fail ->
                    notify_cli_get_acc_role_list_failed(Socket),
                    % 直接退出，不尾递归
                    login_lost(Socket, Client, DistPid, 0, "login fail");
                {ok, L} ->
                    % id, local_id, from_server_id, is_banned, vip_lv, vip_expire_time, nickname, race, faction, sex, lv
                    ?ASSERT(is_list(L), L),
                    ?TRACE("role list len:~p, role list:~w~n", [length(L), L]),

                    % 筛选出正确的角色（应对合服后的情况）
                    L2 = [X || X <- L, begin 
                                            [RoleId, _, FromServerId | _T] = X,     
                                            (RoleId /= ?INVALID_ID) andalso (FromServerId == Client#client.from_server_id)
                                       end],

                    ?DEBUG_MSG("handle_get_acc_role_list(), server_id:~p, client.from_server_id:~p, L:~p, L2:~p", [config:get_server_id(), Client#client.from_server_id, L, L2]),

                    % 发送给客户端
                    {ok, BinData} = pt_10:write(?PT_GET_ACC_ROLE_LIST, [?RES_OK, L2]),
                    lib_send:send_to_sock(Socket, BinData),

                    % 上层调用函数尾递归
                    login_parse_packet(Socket, Client#client{
                                                    role_list = [make_role_brief(Id, IsBanned, VipLv, VipExpireTime)
                                                                    || [Id, _LocalId, _FromServerId, IsBanned, VipLv, VipExpireTime | _T] <- L2],
                                                    cur_login_step = ?LGN_STEP_GOT_ROLE_LIST
                                                    }, DistPid)
            end        
	end.


%% 通知客户端：获取角色列表失败
notify_cli_get_acc_role_list_failed(Socket) ->
    {ok, BinData} = pt_10:write(?PT_GET_ACC_ROLE_LIST, [?RES_FAIL, []]),
    lib_send:send_to_sock(Socket, BinData, true).


%% 通知客户端：创建角色的结果
notify_cli_create_role_result(Socket, Data) ->
	{ok, BinData} = pt_10:write(?PT_CREATE_ROLE, Data),
	lib_send:send_to_sock(Socket, BinData).


-define(MAX_TRY_CREATE_ROLE_TIMES, 15).

%% 创建角色
handle_create_role(Socket, Client, DistPid, Data) ->
	% 当前登录步骤是否正确？
	case Client#client.cur_login_step /= ?LGN_STEP_GOT_ROLE_LIST of
        true ->
        	?ASSERT(false, Client#client.cur_login_step),
            login_lost(Socket, Client, DistPid, 0, "login fail");
        false ->
            TimeNow = util:longunixtime(),
            TimdDiff_Ms = TimeNow - Client#client.last_try_create_role_time,
            case TimdDiff_Ms < 1200 of  % 检测时间间隔，避免恶意攻击
                true ->
                    ?ASSERT(false, {TimdDiff_Ms, Client}),
                    % 上层调用函数尾递归
                    login_parse_packet(Socket, Client, DistPid);
                false ->
                    case Client#client.acc_try_create_role_times >= ?MAX_TRY_CREATE_ROLE_TIMES of  % 检测次数，避免恶意攻击
                        true ->
                            ?WARNING_MSG("try create role reach max times!!! Client:~w", [Client]),
                            login_lost(Socket, Client, DistPid, 0, "login fail");
                        false ->
                            Client2 =
                                case check_create_role(Client, Data) of
                                    ok ->
                                        AccName = Client#client.accname,
                                        case lib_account:db_is_account_exists(AccName) of
                                            true -> ?DEBUG_MSG("[sm_reader] handle_create_role(), account(~p) already exists!~n", [AccName]), skip;
                                            false -> lib_account:db_insert_new_account(AccName)
                                        end,

                                        case lib_account:create_role(AccName, Data, Client#client.from_server_id) of
                                            {ok, NewRoleId, NewRoleLocalId} ->
                                                ?DEBUG_MSG("[sm_reader] handle_create_role() create role success, AccName:~p, NewRoleId:~p~n", [AccName, NewRoleId]),
                                                % 通知客户端：创建角色成功
                                                notify_cli_create_role_result(Socket, [?RES_OK, NewRoleId, NewRoleLocalId | Data]),

                                                erlang:put(?PDKN_LOG_RID, NewRoleId),

                                                _NewRoleBrief = #role_brief{
                                                                    id = NewRoleId,
                                                                    %%%accid = AccId,
                                                                    is_banned = false
                                                                    },

                                                Client#client{
                                                    role_list = Client#client.role_list ++ [_NewRoleBrief]
                                                    };

                                                %%记录创角日志
                                                %%Ip = misc:get_ip(Socket),
                                                %%log:log_register(NewRoleId, Name, Accname, Sex, Race, Ip);
                                            fail ->
                                                ?ASSERT(false),
                                                notify_cli_create_role_result(Socket, [?CR_FAIL_UNKNOWN, ?INVALID_ID, ?INVALID_ID | Data]),
                                                Client
                                        end;
                                    {fail, Reason} ->
                                        notify_cli_create_role_result(Socket, [Reason, ?INVALID_ID, ?INVALID_ID | Data]),
                                        Client
                                end,

                            ?ASSERT(is_record(Client2, client)),

                            Client3 = Client2#client{
                                                last_try_create_role_time = TimeNow,
                                                acc_try_create_role_times = Client2#client.acc_try_create_role_times + 1
                                                },

                            % 上层调用函数尾递归
                            login_parse_packet(Socket, Client3, DistPid)
                    end
            end
    end.




%% 检查创建角色
%% @return: ok | {fail, Reason}
check_create_role(Client, [Race, Sex, Name]) ->
	?ASSERT(is_list(Name)),
	% 是否角色列表满了？
	case length(Client#client.role_list) >= ?MAX_ROLES_PER_ACCOUNT of
		true ->
			{fail, ?CR_FAIL_ROLE_LIST_FULL};
		false ->
			% 职业是否有效？
			case Race < ?RACE_MIN orelse ?RACE_MAX < Race of
				true ->
					?ASSERT(false, Race),
					{fail, ?CR_FAIL_UNKNOWN};
				false ->
					 % 性别是否有效？
					 case Sex /= ?SEX_MALE andalso Sex /= ?SEX_FEMALE of
					 	true ->
					 		?ASSERT(false, Sex),
					 		{fail, ?CR_FAIL_UNKNOWN};
					 	false ->
					 		% 角色名是否有效？
					 		case lib_account:new_role_name_legal(Name) of
					 			{false, Reason} ->
					 				{fail, Reason};
					 			true ->
					 				ok
					 		end
					 end
			end
	end.






%% 处理请求进入游戏
handle_request_enter_game(Socket, Client, DistPid, RoleId) ->
    case check_request_enter_game(Client, RoleId) of
        ok ->
            access_queue_svr:access(Socket, Client#client.accname, do_enter_game, [RoleId]),
            % 上层函数尾递归
            login_parse_packet(Socket, Client#client{cur_login_step = ?LGN_STEP_IN_ACCESS_QUEUE}, DistPid);
        {fail, unknown_error} ->
            % 直接退出
            login_lost(Socket, Client, DistPid, 0, "login fail");
        {fail, Reason} ->
            ply_comm:notify_cli_enter_game_result(Socket, [Reason, RoleId]),
            % 上层函数尾递归
            login_parse_packet(Socket, Client, DistPid)
    end.


% % 进程字典key名(pdkn: process dictionary key name)
% -define(PDKN_PLAYER_PID, pdkn_player_pid).


%%-define(MAX_TRY_ENTER_GAME_TIMES, 3).

%% 进入游戏
do_enter_game(Socket, Client, DistPid, RoleId) ->
        	AccName = Client#client.accname,
            PhoneInfo = Client#client.phone_info,
            FromServerId = Client#client.from_server_id,
            SelfPid = self(),
        	case catch mod_login:enter_game(Socket, [RoleId, AccName, SelfPid, PhoneInfo, FromServerId]) of
        		{'EXIT', Reason} ->
        			?ERROR_MSG("[sm_reader] do_enter_game() error!! Reason: ~w", [Reason]),
        			% 直接退出
        			login_lost(Socket, Client, DistPid, 0, "login fail");
				fail ->
					ply_comm:notify_cli_enter_game_result(Socket, [?ENTER_GAME_FAIL_UNKNOWN, RoleId]),

					% % !!!!容错处理：!!!!
					% % !!!!如果进入游戏失败累计到一定的次数并且角色在临时退出缓存中，则删除玩家的缓存，使得下次可以尝试全新进入游戏!!!!
					% AccFailedTimes = Client#client.try_enter_game_failed_times + 1,
					% ?Ifc (AccFailedTimes == ?MAX_TRY_ENTER_GAME_TIMES - 1)
     %                    ?ERROR_MSG("[sm_reader] do_enter_game() error!!!!! RoleId:~p, AccFailedTimes:~p", [RoleId, AccFailedTimes]),
					% 	case player:in_tmplogout_cache(RoleId) of
     %                        false -> skip;
					% 		true ->
					% 			?TRY_CATCH(mod_ply_jobsch:remove_reconnect_timeout_sche(RoleId), ErrReason_1),
     %                            ?TRY_CATCH(mod_ply_jobsch:remove_kick_out_team_sche(RoleId), ErrReason_2),
					% 			case player:in_tmplogout_cache(RoleId) of
     %                                false -> skip;
					% 				true ->
					% 					?TRY_CATCH(mod_login:final_logout(RoleId), ErrReason_3)
					% 			end
					% 	end
				 %    ?End,

     %                Client2 = Client#client{try_enter_game_failed_times = AccFailedTimes},
     %                % 上层函数尾递归
     %                login_parse_packet(Socket, Client2, DistPid);


                    % 直接退出
                    login_lost(Socket, Client, DistPid, 0, "login fail");

                {fail, server_busy} ->
                    ?ERROR_MSG("[sm_reader] do_enter_game() error!! server busy! RoleId:~p, Client:~w", [RoleId, Client]),
                    ply_comm:notify_cli_enter_game_result(Socket, [?ENTER_GAME_FAIL_SERVER_BUSY, RoleId]),

                    % timer:sleep(2500),

                    % 直接退出
                    login_lost(Socket, Client, DistPid, 0, "login fail");

                    % % 上层函数尾递归
                    % login_parse_packet(Socket, Client, DistPid);

				{ok, PlayerPid} ->
					?TRACE("enter game success, PlayerPid: ~p~n", [PlayerPid]),

					% % 将玩家的进程id存到进程字典里，这样方便通过process_info()查看玩家sm_reader进程来获得玩家进程pid，从而踢出该玩家 ---- 废弃！
					% put(?PDKN_PLAYER_PID, PlayerPid),

					%%notify_cli_enter_game_result(Socket, [?RES_OK, RoleId]), % 通知进入游戏成功改为在完全初始化成功后再通知，见player进程针对'more_init_for_enter_game'的处理
                    Client2 = Client#client{
                                        cur_role_id = RoleId,
                                        player_pid = PlayerPid
                                        },

                    proc_logger:add_player(self(), PlayerPid, Client#client.accname),

                    set_enter_game_time(svr_clock:get_unixtime()),

					% 转到进入游戏后的消息包处理循环
					do_parse_packet(Socket, Client2, DistPid)
			end.




%% 检查进入游戏
%% @reutrn: ok | {fail, Reason}
check_request_enter_game(Client, RoleId) ->
	try check_request_enter_game__(Client, RoleId) of
        ok ->
        	ok
    catch
        throw: FailReason ->
        	{fail, FailReason}
    end.



check_request_enter_game__(Client, RoleId) ->
    % 当前的登录步骤是否正确？
    ?Ifc (Client#client.cur_login_step /= ?LGN_STEP_GOT_ROLE_LIST)
        ?ASSERT(false, Client#client.cur_login_step),
        throw(unknown_error)
    ?End,

    % 角色是否被封禁了？
    ?Ifc (player:is_role_banned(RoleId))
        %%notify_cli_enter_game_result(Socket, [?ENTER_GAME_FAIL_ROLE_BANNED, RoleId]),  %%notify_cli_login_failed(Socket, ?LOGIN_FAIL_ROLE_BANNED),
        %%timer:sleep(2000),
        %%login_lost(Socket, Client, DistPid, Cmd, {login_err, role_banned});
        throw(?ENTER_GAME_FAIL_ROLE_BANNED)
    ?End,

	RoleBrief = lists:keyfind(RoleId, #role_brief.id, Client#client.role_list),
	% 角色id是否正确？
	?Ifc (RoleBrief == false)
		?ASSERT(false, RoleId),
		throw(unknown_error)
	?End,

	% % 角色是否被封禁了？
	% ?Ifc (RoleBrief#role_brief.is_banned)
	% 	throw(?ENTER_GAME_FAIL_ROLE_BANNED)
	% ?End,

	% 检查服务器当前在线人数，是否允许继续进入游戏？
	% VipAllowLv = config:get_greenpass_vip_level(server),
	% TimeNow = util:unixtime(),

	% case RoleBrief#role_brief.vip_lv >= VipAllowLv
	% andalso RoleBrief#role_brief.vip_expire_time > TimeNow of
	% 	true ->
	% 		ok;   % vip绿色通道: 可以不受服务器是否满人的限制
	% 	false ->
	% 		case lib_account:login_limit_check() of
	% 			ok ->
	% 				ok;
	% 			fail ->
	% 				throw(?ENTER_GAME_FAIL_SERVER_FULL)
	% 		end
	% end.

    ok.














% notify_cli_discard_role_result(Socket, RoleId, RetCode) ->
% 	{ok, BinData} = pt_10:write(?PT_DISCARD_ROLE, [RetCode, RoleId]),
%     lib_send:send_to_sock(Socket, BinData).




% %% 删除角色
% handle_discard_role(Socket, Client, DistPid, RoleId) ->
% 	% 当前登录步骤是否正确？
% 	case Client#client.cur_login_step /= ?LGN_STEP_GOT_ROLE_LIST of
% 		true ->
% 			?ASSERT(false, Client#client.cur_login_step),
% 			login_lost(Socket, Client, DistPid, 0, "login fail");
% 		false ->
% 			% 角色id是否正确？
% 			case lists:keyfind(RoleId, #role_brief.id, Client#client.role_list) of
% 				false ->
% 					?ASSERT(false, RoleId),
% 					login_lost(Socket, Client, DistPid, 0, "login fail");
% 				_RoleBrief ->
% 					case lib_account:discard_role(RoleId) of
%         				ok ->
%             				notify_cli_discard_role_result(Socket, RoleId, ?RES_OK);
%         				_ ->
%         					notify_cli_discard_role_result(Socket, RoleId, ?RES_FAIL)
%     				end,

%     				% 上层函数尾递归
%             		login_parse_packet(Socket, Client, DistPid)
% 			end
% 	end.
