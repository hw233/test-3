%%%-----------------------------------
%%% @Module  : sm_server_app
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.15
%%% @Description: 游戏服app的关联模块（详见server.app的配置）
%%%-----------------------------------
-module(sm_server_app).
-behaviour(application).
-export([start/2, stop/1]).

-include("framework.hrl").
-include("debug.hrl").

start(normal, []) ->
    % 从启动参数-extra换取参数（节点，端口，游戏线路）
    % [Ip, Port, Sid] = init:get_plain_arguments(),  % Ip, Port, Sid均为list类型
	
    Ip = ?IP_OF_SERVER_NODE,
    Port = config:get_port_to_listen(?APP_SERVER),
    Sid = ?LINE_ID_OF_SERVER_NODE,
    ?TRACE("~nIp:~p, Port:~p, Sid:~p, ~p, ~p, ~p~n~n", [Ip, Port, Sid, is_list(Ip), is_integer(Port), is_integer(Sid)]),

    {ok, SupPid} = sm_sup:start_link(),
%%    case sm_gateway_srv:start_link() of
%%		true ->
%%			ok;
%%		false ->
%%			throw(unknown)
%%	end,
	sm_third:start(sm_sup, "server"),
    log_sup:start_sys_log(),
    log_sup:start_act_log(),

    db:init_db(?APP_SERVER),
    % 数据库更新
    db_upgrade:upgrade(),

    sm_networking:start([Ip, Port, Sid]),

%%    supervisor:start_child(sm_sup, {test_stat, {test_stat, start_link, []},transient, brutal_kill, worker, [test_stat]}),

    ?WARNING_MSG("~s", ["\n
                            _ooOoo_
                           o8888888o
                           88\" . \"88
                           (| -_- |)
                            O\\ = /O
                        ____/`---'\\____
                         .' \\\\| |// `.
                       / \\\\||| : |||// \\
                     / _||||| -:- |||||- \\
                       | | \\\\\\ - /// | |
                     | \\_| ''\\---/'' | |
                      \\ .-\\__ `-` ___/-. /
                   ___`. .' /--.--\\ `. . __
                .\"\" '< `.___\\_<|>_/___.' >'\"\".
               | | : `- \\`.;`\\ _ /`;.`/ - ` : | |
                 \\ \\ `-. \\_ __\\ /__ _/ .-` / /
         ======`-.____`-.___\\_____/___.-`____.-'======
                            `=---='

         .............................................  "]),
    ?WARNING_MSG("the global Pro ok! Please start the next node...", []),
	
    {ok, SupPid}.

stop(_State) ->   
    % error_logger:error_msg("server application stop!!~n", []),
    void.