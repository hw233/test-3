%%%--------------------------------------
%%% @Module  : sm
%%% @Author  :
%%% @Email   :
%%% @Created : 2011.04.15
%%% @Description:  游戏开启
%%%--------------------------------------
-module(sm).
-export([
    set_server_open_state/1, get_server_open_state/0, flash_start/0, flash_stop/0,
    logger_start/0, logger_stop/0, gateway_start/0,
    gateway_stop/0, world_start/0, world_stop/0, server_start/0, server_stop/0, server_shutdown/0,
    info/0, process_infos/0, process_infos/1, process_infos/2
    ]).

-include("common.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("server_misc.hrl").
-include("framework.hrl").
-include("net.hrl").

-define(FLASH_APPS, [sasl, flash]).
-define(LOGGER_APPS, [sasl, logger]).
-define(GATEWAY_APPS, [sasl, gateway]).
-define(WORLD_APPS, [sasl, world]).
-define(SERVER_APPS, [sasl, ?APP_SERVER]).

%% 设置服务器的开启状态
%% 参数：State: open | closed
set_server_open_state(State) ->
	case State of
		open ->   % 设为开服状态
			ets:insert(?ETS_SERVER_MISC, {?SM_OPEN_STATE, 1});
		closed -> % 设为关服状态
			ets:insert(?ETS_SERVER_MISC, {?SM_OPEN_STATE, 0})
	end.

%% 获取服务器的开启状态
%% 返回值：open（开启中） | closed（未开启）
get_server_open_state() ->
	case ets:lookup(?ETS_SERVER_MISC, ?SM_OPEN_STATE) of
		[] ->
			closed;
		[{?SM_OPEN_STATE, 1}] ->
			open;
		[{?SM_OPEN_STATE, 0}] ->
			closed;
		_Other ->
			?ASSERT(false, _Other),
			closed
	end.

%%启动flash server
flash_start()->
    try
        ok = start_applications(?FLASH_APPS)
    after
        timer:sleep(100)
    end.

%%停止flash server
flash_stop() ->
    ok =  stop_applications(?FLASH_APPS),
	erlang:halt().

%%启动日志
logger_start()->
    try
        ok = start_applications(?LOGGER_APPS)
    after
        timer:sleep(100)
    end.

%%停止日志
logger_stop() ->
    io:format("[sm] logger_stop()...~n"),
    ok = stop_applications(?LOGGER_APPS),
	erlang:halt().

%%启动网关
gateway_start()->
    try
        ok = start_applications(?GATEWAY_APPS)
    after
        timer:sleep(100)
    end.

%%停止网关
gateway_stop() ->
    io:format("[sm] gateway_stop()...~n"),
    ok = stop_applications(?GATEWAY_APPS),
	erlang:halt().

%%启动世界服务器
world_start()->
    try
        ok = start_applications(?WORLD_APPS)
    after
        timer:sleep(100)
    end.

%%停止世界服务器
world_stop() ->
	io:format("------- begin save world data to db --------~n"), % 注意：这里用io:format，而不用TRACE，是因为想在release版本时也能打印出来，下同
	%%%%mod_guild:save_guilds_data(),
	io:format("------- save world data to db finish --------~n"),
	timer:sleep(15000),
    ok = stop_applications(?WORLD_APPS),
    erlang:halt().

%%启动游戏服务器
server_start()->
    try
        ok = start_applications(?SERVER_APPS)
    after
        timer:sleep(100)
    end.

%%停止游戏服务器
server_stop() ->
    io:format("----- stop server begin... ------~n"),
	% 标记为关服状态
	set_server_open_state(closed),

    io:format("----- disconnecting all players, this will take a few moments, Please Wait... -----~n"),
    % 关闭TCP_LISTENER_SUP，此操作会断开所有在线玩家，并且不再接受重连
    supervisor:terminate_child(?TOP_SUP, ?TCP_LISTENER_SUP),
    timer:sleep(13000),  % 等待断开玩家的处理完成
    ?TRY_CATCH(mod_ply_jobsch:force_handle_all_reconnect_timeout_schs(), ErrReason_ForceHandleReconnTimeoutSch),
    io:format("----- disconnect all players done! -----~n"),

    io:format("----- saving data to database, this will take a few moments, Please Wait... -----~n"),
    io:format("----- saving data to database, this will take a few moments, Please Wait... -----~n"),

    timer:sleep(6000),

    % 停服前保存必要的数据到DB
    ?TRY_CATCH(save_data_before_server_stop(), ErrReason_SaveData),

    % 等待保存数据的操作完成
    timer:sleep(config:get_wait_all_logout_time()),

    io:format("----- save data to database done! -----~n"),

    ?TRY_CATCH(db:dump_db_op_stat(), ErrReason_DumpDbOpStat),

    io:format("----- stopping applications, Please Wait... -----~n"),

    % 最后，关闭应用
    case catch stop_applications(?SERVER_APPS) of
        ok ->
            io:format("----- stop applications done! -----~n");
        Other ->
            io:format("----- !!!!!stop applications failed!!!!! details:~p -----~n", [Other])
    end,

    io:format("----- stop server done! -----~n"),

    0.

server_shutdown() ->
    erlang:halt(0, [{flush, false}]).

save_data_before_server_stop() ->
    % 保存全局收集活动数据
    ?TRY_CATCH(mod_global_collection:save_data_on_close(), ErrReason_GLC),
    % 保存帮派关键数据
    ?TRY_CATCH(mod_guild:db_save_all_guild(), ErrReason_DBSaveGuild),
    % 保存商店动态物品数据
    ?TRY_CATCH(lib_shop:db_save_dynamic_shop_goods(), ErrReason_DBSaveDynamicShop),
    % 保存竞技场数据
    % ?TRY_CATCH(mod_offline_arena:db_save_all_daily_rank(), ErrReason_DBSaveOA),
    %% 保存游戏排行榜数据
    ?TRY_CATCH(mod_rank:on_server_stop(), ErrReason_DBSaveRank),
    %% 保存tve兵临城下数据
    ?TRY_CATCH(mod_tve:db_save_all_tve_data(), ErrReason_DBSaveTve),
    %% 保存运镖数据
    ?TRY_CATCH(mod_transport:save_all_truck(), ErrReason_DBSaveTS),

    %% 保存商会数据数据
    ?TRY_CATCH(mod_business:db_save(), ErrReason_DBSaveBusiness),

    %% 保存老虎机数据数据
    ?TRY_CATCH(mod_slotmachine:db_save(), ErrReason_DBSaveSlotmachine),

    %% 保存老虎机数据数据
    ?TRY_CATCH(mod_guild_battle:db_save(), ErrReason_DBSaveGuildBattle),

    ?TRY_CATCH(ply_relation:db_save_all_relation_data(), ErrReason_DBSaveRela).


info() ->
    SchedId      = erlang:system_info(scheduler_id),
    SchedNum     = erlang:system_info(schedulers),
    ProcCount    = erlang:system_info(process_count),
    ProcLimit    = erlang:system_info(process_limit),
    ProcMemUsed  = erlang:memory(processes_used),
    ProcMemAlloc = erlang:memory(processes),
    MemTot       = erlang:memory(total),
    io:format( "abormal termination:
                       ~n   Scheduler id:                         ~p
                       ~n   Num scheduler:                        ~p
                       ~n   Process count:                        ~p
                       ~n   Process limit:                        ~p
                       ~n   Memory used by erlang processes:      ~p
                       ~n   Memory allocated by erlang processes: ~p
                       ~n   The total amount of memory allocated: ~p
                       ~n",
                            [SchedId, SchedNum, ProcCount, ProcLimit,
                             ProcMemUsed, ProcMemAlloc, MemTot]),
      ok.

process_infos() ->
    filelib:ensure_dir("./logs/"),
	File = lists:concat(["./logs/",node(),"-processes_infos.log"]),
    {ok, Fd} = file:open(File, [write, raw, binary, append]),
    Fun = fun(P) ->
				  Pi = erlang:process_info(P),
                  Info = io_lib:format("~p=>~p \n\n",[P,Pi]),
                  case  filelib:is_file(File) of
                        true   ->   file:write(Fd, Info);
                        false  ->
                            file:close(Fd),
                            {ok, NewFd} = file:open(File, [write, raw, binary, append]),
                            file:write(NewFd, Info)
                     end,
                     timer:sleep(20)
                 end,
    [Fun(P) || P <- erlang:processes()],
	file:close(Fd).

process_infos(Count) ->
    filelib:ensure_dir("./logs/"),
    File = lists:concat(["./logs/",node(),"-processes_infos.log"]),
    {ok, Fd} = file:open(File, [write, raw, binary, append]),
	ProcessList = erlang:processes(),
    get_proc_info(Fd, File, 1, Count, ProcessList),
	file:close(Fd).

process_infos(K, V) ->
    filelib:ensure_dir("./logs/"),
    File = lists:concat(["./logs/",node(),"-processes_infos.log"]),
    {ok, Fd} = file:open(File, [write, raw, binary, append]),
	Fun = fun(P) ->
				  Pi = erlang:process_info(P),
				  case lists:member({K,V}, Pi) of
					  false ->
						  skip;
					  true ->
						  Info = io_lib:format("~p=>~p \n\n",[P,Pi]),
						  case  filelib:is_file(File) of
							  true   ->   file:write(Fd, Info);
							  false  ->
								  file:close(Fd),
								  {ok, NewFd} = file:open(File, [write, raw, binary, append]),
								  file:write(NewFd, Info)
						  end,
						  timer:sleep(20)
				  end
		  end,
    [Fun(P) || P <- erlang:processes()],
	file:close(Fd).
get_proc_info(_Fd, _File, Idx, Max, _L) when Idx > Max ->
	ok;
get_proc_info(Fd, File, Idx, Max, [P|T]) ->
	Pi = erlang:process_info(P),
	Info = io_lib:format("~p=>~p \n\n",[P,Pi]),
	case  filelib:is_file(File) of
		true   ->   file:write(Fd, Info);
		false  ->
			file:close(Fd),
			{ok, NewFd} = file:open(File, [write, raw, binary, append]),
			file:write(NewFd, Info)
	end,
	timer:sleep(20),
	get_proc_info(Fd, File, Idx+1, Max, T).

%%############辅助调用函数##############
manage_applications(Iterate, Do, Undo, SkipError, ErrorTag, Apps) ->
    Iterate(fun (App, Acc) ->
                    case Do(App) of
                        ok -> [App | Acc];%合拢
                        {error, {SkipError, _}} -> Acc;
                        {error, Reason} ->
                            lists:foreach(Undo, Acc),
                            throw({error, {ErrorTag, App, Reason}})
                    end
            end, [], Apps),
    ok.

start_applications(Apps) ->
    manage_applications(fun lists:foldl/3,
                        fun application:start/1,
                        fun application:stop/1,
                        already_started,
                        cannot_start_application,
                        Apps).

stop_applications(Apps) ->
    manage_applications(fun lists:foldr/3,
                        fun application:stop/1,
                        fun application:start/1,
                        not_started,
                        cannot_stop_application,
                        Apps).
