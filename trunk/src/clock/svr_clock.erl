%%%--------------------------------------
%%% @Module: svr_clock (server clock)
%%% @Author: huangjf
%%% @Created: 2013.5.14
%%% @Description: 游戏服务器的时钟
%%%--------------------------------------
-module(svr_clock).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start_link/0,
        get_tick_count/0,
        get_unixtime/0
        ]).

-include("common.hrl").
-include("debug.hrl").
-include("server_misc.hrl").
-include("ets_name.hrl").
-include("sys_code_2.hrl").
-include("limitedtask.hrl").
-include("admin_activity.hrl").
-include("record.hrl").

-record(state, {
				unixtime_tower_ghost_restore = 0    %% 伏魔塔挑战次数上次回复时间戳--用来触发挑战次数下次回复
			   }).

%% 开启服务器时钟
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


% %% 关闭服务器时钟
% stop() ->
%     %%?DEBUG_MSG("svr clock stoping...", []),
%     ok.


%% 获取当前的时钟滴答计数
get_tick_count() ->
     [{?SM_CLOCK_TICK_COUNT, CurTickCount}] = ets:lookup(?ETS_SERVER_MISC, ?SM_CLOCK_TICK_COUNT),
     CurTickCount.


%% 获取当前unix时间戳（不一定十分精确，如果要精确获取，应该使用util:unixtime()）
get_unixtime() ->
     [{?SM_CLOCK_UNIXTIME, CurUnixTime}] = ets:lookup(?ETS_SERVER_MISC, ?SM_CLOCK_UNIXTIME),
     CurUnixTime.




%%
%% Callback Functions
%%

init([]) ->
    ?TRACE("[svr_clock] init()...~n"),
    process_flag(trap_exit, true),
    do_init_jobs(),
    erlang:send_after(?SERVER_CLOCK_TICK_INTV, self(), 'tick'),
    {ok, #state{unixtime_tower_ghost_restore = 0}}.


handle_call(_Msg, _From, State) ->
    {noreply, State}.


handle_cast(_Msg, State) ->
    {noreply, State}.


%% 时钟滴答一次
handle_info('tick', State) ->
    State2 = handle_clock_tick(State),
    % 投递下一个tick
    erlang:send_after(?SERVER_CLOCK_TICK_INTV, self(), 'tick'),
    {noreply, State2};

handle_info(_Msg, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ?TRACE("@@@ svr_clock:terminate, reason:~p~n", [_Reason]),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.



%%
%% ============================== Local Functions =================================
%%

%% 做初始化工作
do_init_jobs() ->
    init_clock_tick_count(),
    update_clock_unixtime(),
    create_server_open_time(),
    init_next_minute_unixtime(),
    check_reset_time().



%% 初始化时钟滴答计数为0
init_clock_tick_count() ->
    ets:insert(?ETS_SERVER_MISC, {?SM_CLOCK_TICK_COUNT, 0}),
    void.

%% 自增时钟滴答计数
%% @return: 新的时钟滴答计数
incr_clock_tick_count() ->
    [{?SM_CLOCK_TICK_COUNT, CurTickCount}] = ets:lookup(?ETS_SERVER_MISC, ?SM_CLOCK_TICK_COUNT),
    ets:insert(?ETS_SERVER_MISC, {?SM_CLOCK_TICK_COUNT, CurTickCount + 1}),
    CurTickCount + 1.


%% 更新unix时间戳
%% @return: 当前最新的unix时间戳
update_clock_unixtime() ->
    CurUnixTime = util:unixtime(),
    update_clock_unixtime(CurUnixTime).

update_clock_unixtime(CurUnixTime) ->
	ets:insert(?ETS_SERVER_MISC, {?SM_CLOCK_UNIXTIME, CurUnixTime}),
    CurUnixTime.



%% 时钟滴答的处理
handle_clock_tick(State) ->
	CurUnixTime = util:unixtime(),
	
    NewTickCount = incr_clock_tick_count(),
    NewUnixTime = update_clock_unixtime(CurUnixTime),
    %%?TRACE("[SVR_CLOCK] tick, NewTickCount: ~p~n", [NewTickCount]),
    notice_to_other_modules(NewTickCount, NewUnixTime),  % 通知其他模块
    check_and_handle_new_minute_comes(NewUnixTime).
	
	%% 滴答里通知所有在线玩家处理伏魔塔的定时回复挑战次数(20200108暂时不用定时处理，由前端倒计时事件驱动回复次数就好了，平时也不用回复)
%% 	try
%% 		Unixtime_tower_ghost_restore = lib_tower_ghost:interval_incr_times(State#state.unixtime_tower_ghost_restore, CurUnixTime),
%% 		State#state{unixtime_tower_ghost_restore = Unixtime_tower_ghost_restore}
%% 	catch
%% 		E:R ->
%% 			
%% 			State
%% 	end.


notice_to_other_modules(NewTickCount, NewUnixTime) ->
    mod_ply_hb_mgr:on_server_clock_tick(NewTickCount, NewUnixTime),
    mod_mon_mgr:on_server_clock_tick(NewTickCount, NewUnixTime),
    mod_npc_mgr:on_server_clock_tick(NewTickCount, NewUnixTime),
    mod_ply_jobsch:on_server_clock_tick(NewTickCount, NewUnixTime),
    mod_sys_jobsch:on_server_clock_tick(NewTickCount, NewUnixTime),
    mod_battle_mgr:on_server_clock_tick(NewTickCount, NewUnixTime).


create_server_open_time() ->
    ets:new(?ETS_SERVER_OPEN_TIME, [public, set, named_table]),
    ets:insert(?ETS_SERVER_OPEN_TIME, {stamp, util:unixtime()}),
    ets:insert(?ETS_SERVER_OPEN_TIME, {time, {date(), time()}}),
    %% 首次开服时间
    case db:select_row(first_open_server_time, "first_timestamp", []) of
        [Timestamp] when is_integer(Timestamp) andalso Timestamp > 0 ->
            ets:insert(?ETS_SERVER_OPEN_TIME, {first_time, util:get_datetime_by_timestamp(Timestamp)});
        [] ->
            Timestamp = util:unixtime(),
            ets:insert(?ETS_SERVER_OPEN_TIME, {first_time, util:get_datetime_by_timestamp(Timestamp)}),
            db:insert(first_open_server_time, [{first_timestamp, Timestamp}]);
        _T ->
            erlang:error({first_open_server_time_error, [_T]})
    end.





%% 初始化下一个整分所对应的unix时间戳
init_next_minute_unixtime() ->
    {_Hour, _Min, Sec} = erlang:time(),
    CurUnixTime = util:unixtime(),
    DiffSec = 60 - Sec,  % 距离下一个整分的秒数
    NextMinuteUnixTime = CurUnixTime + DiffSec,
    % ?TRACE("[svr_clock] init_next_minute_unixtime(), CurUnixTime:~p, DiffSec:~p, NextMinuteUnixTime:~p~n", [CurUnixTime, DiffSec, NextMinuteUnixTime]),
    erlang:put(next_minute_unixtime, NextMinuteUnixTime).




%% 检测并处理新的整分到了
check_and_handle_new_minute_comes(CurUnixTime) ->
    case is_new_minute_comes(CurUnixTime) of
        true ->
            % ?DEBUG_MSG("[svr_clock] check_and_handle_new_minute_comes(), new minute comes!! CurUnixTime:~p, Old NextMinuteUnixTime:~p", [CurUnixTime, erlang:get(next_minute_unixtime)]),
            ?TRY_CATCH(new_minute_comes(), ErrReason),
            init_next_minute_unixtime();  % 重新初始化
        false ->
            % ?TRACE("new minute does not comes yet!!~n"),
            skip
    end.




%% 判断新的整分是否到了
is_new_minute_comes(CurUnixTime) ->
    CurUnixTime >= erlang:get(next_minute_unixtime).



%% 新的整分到了
new_minute_comes() ->
    {_Hour, Min, _Sec} = erlang:time(),
    % ?TRACE("[svr_clock] new_minute_comes(), Hour:~p, Min:~p, Sec:~p~n", [_Hour, Min, _Sec]),

    % 在此处添加所需的整分的处理（目前暂时没有）
    % ...
    % ...
    %%三十分钟刷新一次限时任务排行榜
    case Min == 30 of
        true ->
            lib_limited_task:get_rank_player_data();
        false ->
            skip
    end,

    case Min == 0 of
        true -> new_hour_comes();
        false -> skip
    end,
    case lists:member({_Hour, Min}, data_special_config:get('guild_shop_refresh_time')) of
        true ->
            ply_guild:refresh_guild_shop();
        false ->
            skip
    end.




%% 新的整点到了
new_hour_comes() ->
    {Hour, _Min, _Sec} = erlang:time(),
    ?DEBUG_MSG("[svr_clock] new_hour_comes(), Hour:~p, Min:~p, Sec:~p", [Hour, _Min, _Sec]),

    lib_task:notify_refresh_hourly(),
    % 在此处添加其他所需的整点处理
    % ...
    % ...
    if
        % 某些东西要在0点执行
        Hour == 0 ->
            new_day_comes();
        % 日常更新修改为5点更新
        Hour == 5 ->
            new_day_comes5();
        Hour == 4 ->
            mod_team_mgr:try_clear_data();
        true -> skip
    end.

new_day_comes() ->
    ?DEBUG_MSG("[svr_clock] new_day_comes()...", []),
    % 世界等级提示刷新
    mod_world_lv:notify_refresh_daily(),
    % 离线竞技场通知 排名信息
    mod_offline_arena:daily_notify(),
    % 
    sys_daily_reset(),
    mod_shop:new_day_comes(),
    mod_horse_race:new_day_comes(),

    %重置限时任务
    case ets:tab2list(ets_limit_time_task_player) of
        [] ->
            skip;
        R ->
            F = fun(X) ->
                lib_limited_task:update_player_data(X,X#limited_time_player{times = 0, remain = 5})
                end,
            lists:foreach(F, R)
    end,
    
    

    % 每周更新的放到0点
    case util:get_week() of
        1 ->
            new_week_comes();
        _ ->
            skip
    end,

    %%每日凌晨水玉返利
    case ets:tab2list(ets_player_day_recharge) of
        [] ->
            skip;
        Lists ->
            case db:select_row(admin_sys_activity, "order_id", [{sys,  21}, {state,1}]) of
                [] ->
                    skip;
                [OrderId] ->
                    case ets:lookup(ets_admin_sys_activity, OrderId) of
                        [] ->
                            skip;
                        [Day_Recharge_R] ->
                            {Title,Content, RewardList} = Day_Recharge_R#admin_sys_activity.content,
                            %排序一下奖励表，确保返利是按最大的发
                            RewardList2 =  lists:reverse(lists:keysort(1, RewardList)),
                          Day_Recharge_F =
                                fun(X) ->
                                    {PlayerId,DayRecharge} = X,
                                  Day_Recharge_F2 =
                                        fun(X2, Acc) ->
                                            {LimitValue, Reward} = X2,
                                            case DayRecharge >= LimitValue andalso Acc == 0 of
                                                true ->
                                                    [{GoodsNo,BindState,Count}] = Reward,
                                                    Reward2 = [{GoodsNo,BindState,Count * DayRecharge * player:recharge_ratio() div 100}],
                                                    lib_mail:send_sys_mail(PlayerId, Title, Content, Reward2, ["log_mail", "day_fanli"]),
                                                    1;
                                                false ->
                                                    Acc
                                            end

                                        end,
                                    lists:foldl(Day_Recharge_F2, 0, RewardList2),
                                    %更新数据库数据
                                    Fanli = case ets:lookup(ets_player_acc_recharge, PlayerId) of
                                                [] ->
                                                    util:term_to_bitstring({0, 0, []});
                                                [{PlayerId, RechargeMoney, GetReward}] ->
                                                    util:term_to_bitstring({0, RechargeMoney, GetReward})
                                            end,
                                    db:update(PlayerId, clock_data, [{fanli, Fanli}],
                                        [{player_id,PlayerId}]),
                                    %%更新每日返利的
                                    ets:insert(ets_player_day_recharge, {PlayerId, 0})

                                end,
                            lists:foreach(Day_Recharge_F, Lists)
                    end
            end

    end,

    ets:delete_all_objects(ets_player_day_recharge) %%清空每日充值的奖励
.


%% 新的一天到了（到了隔天的0点整）
new_day_comes5() ->
    ?DEBUG_MSG("[svr_clock] new_day_comes()...", []),
    % 该函数优先执行
    
    % mod_global_collection:daily_operation(),
    % 每日任务通知
    lib_task:notify_refresh_daily(),
    % 给所有玩家触发新的一天更新事件
    ply_comm:notify_new_day_comes_to_all(),

    % 例如拜年活动类的刷新
    lib_festival_act:new_day_comes(),
    void.
    

%% 新的一周到了（到了隔周周一的0点整）
new_week_comes() ->
    sys_weekly_reset().



%% 必须保证每天执行一次的系统
sys_daily_reset() ->
    ?INFO_MSG("sys_daily_reset", []),
    mod_data:save(?SYS_DAILY_RESET_TIME, util:unixtime()),
    mod_rank_gift:daily_title(),
    case sm_cross_client_sup:get_child_pids() of
		[] ->
			skip;
		_ ->
            mod_pvp:kuafu_3v3_close(),
			cross_3v3_match:become_legend()
	end,
    lib_luck:rich_info_reset(),
    lib_mystery:mystery_daily_reset(),
    mod_rank:daily_reset().

%% 必须保证每周执行一次有系统
sys_weekly_reset() ->
    ?INFO_MSG("sys_weekly_reset", []),
    mod_data:save(?SYS_WEEKLY_RESET_TIME, util:unixtime()),
    mod_rank:weekly_reset(),
    mod_arena_1v1:weekly_reset(),
	lib_guild_dungeon:refresh_data(),
	lib_luck:weekly_clear_hunting(),
    mod_arena_3v3:weekly_reset(),
	case sm_cross_client_sup:get_child_pids() of
		[] ->
			skip;
		_ ->
			cross_3v3_match:send_rank_reward()
	end.




check_reset_time() ->
    Daily =
        case mod_data:load(?SYS_DAILY_RESET_TIME) of
            [D] -> D;
            _ -> 0
        end,
    case util:is_same_day(Daily) of
        ?false -> sys_daily_reset();
        _ -> ok
    end,

    Weekly =
        case mod_data:load(?SYS_WEEKLY_RESET_TIME) of
            [W] -> W;
            _ -> 0
        end,
    case util:is_same_week(Weekly) of
        ?false -> sys_weekly_reset();
        _ -> ok
    end.










% -------以下为旧代码，注释掉！--------


% %% 每日凌晨0点整触发的事件
% handle_info({timeout, _TimerRef, 'daily_task'}, State) ->
%     ?TRY_CATCH(new_day_comes(), ErrReason),
%     %% ======================
%     Sec = get_time_to_midnight_secs(erlang:time()),
%     NewSec = get_combile_time_to_midnight_secs(Sec),
%     ?LDS_TRACE("handle daily task ", [{next_time, NewSec}]),
%     erlang:start_timer(NewSec * 1000, self(), 'daily_task'),
%     {noreply, State};

% %% 每小时触发事件 整点报时
% handle_info({timeout, _TimerRef, 'hour_task'}, State) ->
%     lib_task:notify_refresh_hourly(),
%     %% 添加小时整点的作业
%     erlang:start_timer(3600000, self(), 'hour_task'),
%     {noreply, State};



% init_daily_timer() ->
%     Sec = get_time_to_midnight_secs(erlang:time()),
%     ?LDS_TRACE("start init daily timer", [{next_time, Sec}]),
%     erlang:start_timer(Sec * 1000, self(), 'daily_task').




% -define(DAY_SECONDS, 86400).
% -define(ERROE_ROUND_SEC, 10).

% -spec get_time_to_midnight_secs(Time::tuple()) -> Second::integer() | error.
% get_time_to_midnight_secs({_, _, _} = Time) ->
%     ?DAY_SECONDS - calendar:time_to_seconds(Time);
% get_time_to_midnight_secs(_) ->
%     ?ASSERT(false), error.

% -spec get_combile_time_to_midnight_secs(Second::integer()) -> integer() | error.
% get_combile_time_to_midnight_secs(Second) when is_integer(Second) ->
%     ?BIN_PRED(Second < ?ERROE_ROUND_SEC, Second + ?DAY_SECONDS, Second);
% get_combile_time_to_midnight_secs(_) ->
%     ?ASSERT(false), error.
