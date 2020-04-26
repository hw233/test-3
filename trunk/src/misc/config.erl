%%%--------------------------------------
%%% @Module  : config
%%% @Author  : Skyman Wu
%%% @Email   : 
%%% @Created : 2011.12.4
%%% @Description: 读取application的配置数据
%%%--------------------------------------
-module(config).

%%
%% Include files
%%
-include("record.hrl").
-include("common.hrl").
-include("db.hrl").
-include("framework.hrl").
%%
%% Exported Functions
%%
-export([get_load_scenes/0,
		 get_guest_mode/0,
		 get_infant_ctrl/1, get_wait_all_logout_time/0, get_guild_scene_in_node/0, get_http_ips/1, 
		 get_db_node/1, get_logger_node/1, get_gateway_node/1,
		 get_log_file/0, get_log_level/0, 

		 get_db_host/1,
		 get_db_port/1,
		 get_db_conn_num/1,
		 % get_bg_db_host/1,
		 % get_bg_db_port/1,
		 % get_bg_db_conn_num/1,

		 get_db_user/1,
		 get_db_password/1,
		 get_db_name/1,

		 get_port_to_listen/1,
		 get_adm_port_to_listen/1,
		 
		 reload_env/0,

		 can_use_gm_cmd/1,
		 if_check_heartbeat_timeout/1,

         get_limit_login/1, 
		 get_limit_login_threshold/1,
		 get_server_id/0,
         get_greenpass_vip_level/1,

         need_md5_login_auth/0,
         need_to_log_recved_proto/1,
         need_to_goto_hell_after_die/0,

         get_role_reconn_timeout_time/0,
         get_role_reconn_timeout_time_floating/0,
         get_game_logic_reconn_timeout_time/0,

         check_admin_security_switch/0,

         recharge_feekback_switch/0,

         get_adm_udp_port/0,
         get_svr_udp_port/0,
         get_adm_addr/0,
         get_chat_monitor_switch/0,

         get_check_proto_freq_intv/0,
         get_max_allowed_proto_per_intv/0,
		 
		 get_cross_server/0,
		 get_cross_server_host/0,
		 get_cross_server_port/0,
		 get_cross_server_count/0,
		 
		 get_admin_addr_control_server/0
         ]).

%%
%% API Functions
%%
get_load_scenes() ->
    case application:get_env(?APP_SERVER, scenes) of
		{ok, all} -> data_scene:get_id_list();
		{ok, SL} -> SL
	end.

%% 游客模式开关读取
get_guest_mode() ->
	case application:get_env(?APP_SERVER, guest_mode) of
		{ok, Mode} -> tool:to_integer(Mode);
		_ -> 0
    end.


%% 防沉迷开关读取
get_infant_ctrl(App) ->
    case application:get_env(App, infant_ctrl) of
	{ok, Mode} -> tool:to_integer(Mode);
	_ -> 0
    end.

%% 关服时等待所有玩家退出的时间间隔
get_wait_all_logout_time() ->
	case application:get_env(?APP_SERVER, all_logout_time) of
		{ok, Time} -> tool:to_integer(Time);
		_ -> 10000
    end.

%% 帮派场景在哪个server节点生成（server节点的index）
get_guild_scene_in_node() ->
	case application:get_env(world, guild_scene_in) of
	{ok, Index} -> tool:to_integer(Index);
	_ -> 1
    end.

get_http_ips(App) ->
    case application:get_env(App, http_ips) of
			{ok, Http_ips} -> Http_ips;
	_ -> []
    end.  

%% 获取db节点
get_db_node(App) ->
	{ok, DB_node} = application:get_env(App, db_node),
	DB_node.

%% 获取logger节点
get_logger_node(App) ->
	{ok, Logger_node} = application:get_env(App, logger_node),
	Logger_node.

%% 获取logger节点
get_gateway_node(App) ->
	{ok, Gateway_node} = application:get_env(App, gateway_node),
	Gateway_node.

%% 获取日志文件名
get_log_file() ->
	case application:get_env(logger, log_file) of
		undefined -> ?DEFAULT_LOG_FILE;
		{ok, Log_file} -> Log_file
	end.

%% 获取日志等级
get_log_level() ->
	case application:get_env(logger, log_level) of
		undefined -> ?DEFAULT_LOG_LEVEL;
		{ok, Log_level} -> Log_level
	end.

%% 游戏数据库所在主机的ip
get_db_host(App) ->
	case application:get_env(App, db_host) of
		undefined -> ?ASSERT(false), "localhost";
		{ok, DB_Host} -> DB_Host
	end.

%% 游戏数据库的端口
get_db_port(App) ->
	case application:get_env(App, db_port) of
		undefined -> ?ASSERT(false), ?DEFAULT_DB_PORT;
		{ok, DB_Port} -> DB_Port
	end.

%% 与游戏数据库的连接数
get_db_conn_num(App) ->
	% case application:get_env(App, db_conn_num) of
	% 	undefined -> ?ASSERT(false), 1;
	% 	{ok, DB_ConnNum} -> DB_ConnNum
	% end.
	% case App of
	% 	?APP_GATEWAY ->
	% 		?DB_CONN_NUM_FOR_GATEWAY;
	% 	?APP_SERVER ->
	% 		?DB_CONN_NUM_FOR_SERVER;
	% 	_Any ->
	% 		?ASSERT(false, _Any),
	% 		1
	% end.

	case application:get_env(App, db_conn_num) of
		undefined -> ?ASSERT(false), 1;
		{ok, ConnNum} -> ConnNum
	end.


%% 游戏数据库的用户名
get_db_user(App) ->
	case application:get_env(App, db_user) of
		undefined -> ?ASSERT(false), "";
		{ok, DB_User} -> DB_User
	end.

%% 游戏数据库的用户密码
get_db_password(App) ->
	case application:get_env(App, db_password) of
		undefined -> ?ASSERT(false), "";
		{ok, DB_Password} -> DB_Password
	end.

%% 游戏数据库名
get_db_name(App) ->
	case application:get_env(App, db_name) of
		undefined -> ?ASSERT(false), "";
		{ok, DB_Name} -> DB_Name
	end.


%% 将要监听的端口
get_port_to_listen(App) ->
	case application:get_env(App, port_to_listen) of
		undefined -> ?ASSERT(false), 0;
		{ok, PortToListen} -> PortToListen
	end.

get_adm_port_to_listen(App) ->
	case application:get_env(App, adm_port_to_listen) of
		undefined -> ?ASSERT(false), 0;
		{ok, AdmPortToListen} -> AdmPortToListen
	end.	


% %% 后台数据库所在主机的ip
% get_bg_db_host(App) ->  % bg: background
% 	case application:get_env(App, bg_db_host) of
% 		undefined -> ?ASSERT(false), "localhost";
% 		{ok, Db_host} -> Db_host
% 	end.


% %% 游戏数据库的端口
% get_bg_db_port(App) ->
% 	case application:get_env(App, bg_db_port) of
% 		undefined -> ?ASSERT(false), ?DEFAULT_DB_PORT_BG;
% 		{ok, Port} -> Port
% 	end.

% get_bg_db_conn_num(App) ->
% 	case application:get_env(App, bg_db_conn_num) of
% 		undefined -> 1;
% 		{ok, Db_conn_num} -> Db_conn_num
% 	end.


reload_env() ->
	case file:consult("server.config") of
		{ok, [Content | _]} ->
			% [[_, {server, EnvConfig}]] = Content,
			case lists:keyfind(server, 1, Content) of
				false -> 
					io:format("error !  no find server env. Content = ~w~n", [Content]),
					error;
				{server, EnvConfig} ->
					Fun = fun({Key, Value}) ->
								  % 这里用io:format而不用?TRACE，是因为想在release版也能打印出信息
								  io:format("K:~p, V:~p~n", [Key,Value]),
								  application:set_env(server, Key, Value)
						  end,
					lists:foreach(Fun, EnvConfig),
					completed
			end;
		{error, _Reason} ->
			error
	end.


%% 是否可以使用gm指令？
can_use_gm_cmd(App) ->
	case application:get_env(App, can_use_gm_cmd) of
	{ok, 1} -> true;
	_ -> false
    end.
	

%% 是否检测心跳包超时？
if_check_heartbeat_timeout(App) ->
	case application:get_env(App, check_heartbeat_timeout) of
	{ok, 1} -> true;
	_ -> false
    end.


%% 登录人数限制开关读取
get_limit_login(App) ->
    case application:get_env(App, limit_login) of
	{ok, Mode} -> tool:to_integer(Mode);
	_ -> 0
    end.

%% 登录人数限制阀值读取
get_limit_login_threshold(App) ->
    case application:get_env(App, limit_login_threshold) of
	{ok, Mode} -> tool:to_integer(Mode);
	_ -> 3000
    end.

%% 绿色通道登录最低VIP低级读取
get_greenpass_vip_level(App) ->
    case application:get_env(App, greenpass_vip_level) of
	{ok, Mode} -> tool:to_integer(Mode);
	_ -> 1 
    end.

%% 取得服务器id
%% 服务器id = 平台号 * 10000 + 平台下的服务器流水编号 （假定平台下的服务器的流水编号不超过9999）
get_server_id() ->
	case application:get_env(?APP_SERVER, server_id) of
		{ok, Mode} -> tool:to_integer(Mode);
		_ -> ?ASSERT(false), -1 
    end.



%% 是否要做MD5登录验证
need_md5_login_auth() ->
	case application:get_env(?APP_SERVER, md5_login_auth) of
		{ok, 1} -> true;
		_ -> false
    end.

%% 是否要记录服务端所收到的协议
need_to_log_recved_proto(App) ->
	case application:get_env(App, log_recved_proto) of
		{ok, 1} -> true;
		_ -> false
    end.
%% 	true.  %% 记录协议？


%% 死亡后是否要传送到地府
need_to_goto_hell_after_die() ->
	case application:get_env(?APP_SERVER, goto_hell_after_die) of
		{ok, 1} -> true;
		_ -> false
    end.


%% 角色重连超时的时间
get_role_reconn_timeout_time() ->
	case application:get_env(?APP_SERVER, role_reconn_timeout_time) of
		{ok, Time} -> ?ASSERT(util:is_nonnegative_int(Time)), Time;
		_ -> ?ASSERT(false), 0
    end.
	
%% 角色重连超时的时间的浮动范围
get_role_reconn_timeout_time_floating() ->
	case application:get_env(?APP_SERVER, role_reconn_timeout_time_floating) of
		{ok, TimeFloating} -> ?ASSERT(util:is_nonnegative_int(TimeFloating)), TimeFloating;
		_ -> ?ASSERT(false), 0
    end.

%% 游戏逻辑（如：队伍，副本等）重连超时的时间
get_game_logic_reconn_timeout_time() ->
	case application:get_env(?APP_SERVER, game_logic_reconn_timeout_time) of
		{ok, Time} -> ?ASSERT(util:is_nonnegative_int(Time)), Time;
		_ -> ?ASSERT(false), 0
    end.

%% 获取后台安全性验证开关
%% @return ：boolean()
check_admin_security_switch() ->
	case application:get_env(?APP_SERVER, check_admin_security) of
		{ok, 1} -> true;
		{ok, 0} -> false;
		_ -> ?ASSERT(false), false
	end.


%% 获取充值返还开关
recharge_feekback_switch() ->
	case application:get_env(?APP_SERVER, switch_recharge_feekback) of
		{ok, 1} -> true;
		{ok, 0} -> false;
		_ -> ?ASSERT(false), false
	end.



get_adm_udp_port() ->
	case application:get_env(?APP_SERVER, admin_udp_port) of
		undefined -> ?ASSERT(false), 0;
		{ok, AdmPortToListen} -> AdmPortToListen
	end.

get_svr_udp_port() ->
	case application:get_env(?APP_SERVER, server_udp_port) of
		undefined -> ?ASSERT(false), 0;
		{ok, AdmPortToListen} -> AdmPortToListen
	end.

get_adm_addr() ->
	case application:get_env(?APP_SERVER, admin_addr) of
		undefined -> ?ASSERT(false), 0;
		{ok, AdmPortToListen} -> AdmPortToListen
	end.

get_chat_monitor_switch() ->
	case application:get_env(?APP_SERVER, switch_chat_monitor) of
		{ok, 1} -> true;
		{ok, 0} -> false;
		_ -> ?ASSERT(false), false
	end.


%% 检测客户端发送协议包的频率的时间间隔（单位：秒）
get_check_proto_freq_intv() ->
	case application:get_env(?APP_SERVER, check_proto_freq_intv) of
		{ok, Val} -> ?ASSERT(util:is_nonnegative_int(Val)), Val;
		_ -> ?ASSERT(false), 0
    end.
	
%% 单个时间间隔内允许客户端发协议包的最大个数
get_max_allowed_proto_per_intv() ->
	case application:get_env(?APP_SERVER, max_allowed_proto_per_intv) of
		{ok, Val} -> ?ASSERT(util:is_nonnegative_int(Val)), Val;
		_ -> ?ASSERT(false), 0
    end.
	

%% 获取跨服节点地址和监听端口（如果在同一网段最好填内网地址）
get_cross_server() ->
	Host = get_cross_server_host(),
	Port = get_cross_server_port(),
	{Host, Port}.

get_cross_server_host() ->
	case application:get_env(?APP_SERVER, cross_server_host) of
		undefined -> ?ASSERT(false), "localhost";
		{ok, CrossServerHost} -> CrossServerHost
	end.

get_cross_server_port() ->
	case application:get_env(?APP_SERVER, cross_server_port) of
		undefined -> ?ASSERT(false), 0;
		{ok, CrossServerPort} -> CrossServerPort
	end.

get_cross_server_count() ->
	case application:get_env(?APP_SERVER, cross_server_count) of
		undefined -> ?ASSERT(false), 0;
		{ok, CrossServerCount} -> CrossServerCount
	end.

%% 获取控制服http访问地址（竞猜活动等需要用到）
get_admin_addr_control_server() ->
	case application:get_env(?APP_SERVER, admin_addr_control_server) of
		undefined -> ?ASSERT(false), "";
		{ok, CrossServerHost} -> CrossServerHost
	end.


%%
%% Local Functions
%%

