-module(mod_activity).
-behavour(gen_server).
-export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0]).

-compile(export_all).

-include("common.hrl").
-include("record.hrl").
-include("activity_degree.hrl").
-include("activity_degree_sys.hrl").
-include("admin_activity.hrl").
-include("ets_name.hrl").

-record(state, {timing_activitys = []}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


init([]) ->
    ?LDS_TRACE("mod_activity init"),
    process_flag('trap_exit', true),
    do_init_jobs(),
    {ok, #state{}, 5000}.


handle_call(_Msg, _From, State) ->
    {reply, badmatch, State}.


% handle_cast()

handle_cast({'sys_open', Sys}, State) ->
    put(?PUBLIC_ACITICTY_ALIVE(Sys), 1),
    {noreply, State};

handle_cast({'sys_close', Sys}, State) ->
    try 
        put(?PUBLIC_ACITICTY_ALIVE(Sys), 0),
        F = fun() -> 
            IdList = mod_svr_mgr:get_all_online_player_ids(),
            {ok, BinData} = pt_58:write(58005, [[{Sys, 2, 0}]]),
            [lib_send:send_to_uid(RoleId, BinData) || RoleId <- IdList, is_integer(RoleId)]
        end,
        spawn(F)
    catch 
        _:_ -> ?ERROR_MSG("[mod_activity] sys_close  error", [])
    end,
    {noreply, State};


handle_cast({action_script, Fun, Args}, State) ->
    catch Fun(Args),
    {noreply, State};


handle_cast(_Msg, State) ->
    {noreply, State}.


handle_info(timeout, State) ->
    try 
        erlang:start_timer(?ACTIVITY_TIMING_INTEVAL, self(), 'check_activity'),
        
        % 记录在线
        timing_log_online_num()
    catch 
        _:_ -> ?ERROR_MSG("[mod_activity] timeout  error", [])
    end,
    {noreply, State};

handle_info({timeout, _TimerRef, 'check_activity'}, State) ->
    try 
        check_activity()
    catch 
        _:_ -> ?ERROR_MSG("[mod_activity] timeout check_activity error", [])
    end,
    erlang:start_timer(?ACTIVITY_TIMING_INTEVAL, self(), 'check_activity'),
    {noreply, State};

%% 活动结束
handle_info({timeout, _TimerRef, {'close_activity', Activity}}, State) ->
    try
        erase(?ACTIVITY_OPEN(Activity)),
        close_activity(Activity)
    catch 
        _:_ -> ?ERROR_MSG("[mod_activity] timeout close_activity error", [])
    end,
    {noreply, State};

handle_info({timeout, _TimerRef, {'delay_exec_script', Script}}, State) ->
    try
        spawn_exec_script_now(Script)
    catch
        _:_ -> ?ERROR_MSG("[mod_activity] timeout delay_exec_script error", [])
    end,
    {noreply, State};

handle_info({timeout, _TimerRef, 'timing_online_num'}, State) ->
    try
        timing_log_online_num()
    catch 
        _:_ -> ?ERROR_MSG("[mod_activity] timeout timing_online_num error", [])
    end,
    {noreply, State};

handle_info({timeout, _TimerRef, {'admin_activity_open', OrderId}}, State) ->
    try
        lib_activity:trigger_admin_activity(OrderId)
    catch 
        _:_ -> ?ERROR_MSG("[mod_activity] timeout admin_activity_open error", [])
    end,
    {noreply, State};

handle_info(_Msg, State) ->
    {noreply, State}.


code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


terminate(_Reason, _State) ->
    ok.



%% ==========================================================
%% internal function
%% ==========================================================



do_init_jobs() ->
    ok.
    



%% @doc 检查活动是否要开启
check_activity() -> 
    {Date, _} = LocalTime = erlang:localtime(),
    WeekDay = calendar:day_of_the_week(Date),
    check_activity(get_activity_list(), {LocalTime, WeekDay}).

check_activity([], _) -> skip;
check_activity([Activity | Left], Time) ->
    case is_activity_alive(Activity) of
        true -> skip;
        false ->
            % ?LDS_TRACE(check_activity),
            case is_time_to_open_activity(Activity, Time) of
                {true, Duration} -> open_activity(Activity, Duration);
                false -> skip
            end
    end,
    check_activity(Left, Time).


%% @doc 活动是否存活
%% @return boolean()

% 活动进程调用的接口, 非活动进程请勿调用
is_activity_alive(Activity) ->
    case get(?ACTIVITY_OPEN(Activity)) of
        true -> true;
        _ -> false
    end.

%% 对外提供的接口，非活动进程请调用该接口, 判断活动是否存活
%% @return ： boolean()
publ_is_activity_alive(Activity) ->
    {Date, _} = LocalTime = erlang:localtime(),
    WeekDay = calendar:day_of_the_week(Date),
    case is_actual_time_to_open_activity(Activity, {LocalTime, WeekDay}) of
        {true, _} -> true;
        false -> false
    end.

%% 对外提供的接口，非活动进程请调用该接口
%% 取得活动持续时间（sec）
%% @return : integer() | null
publ_get_activity_duration(Activity) ->
    case get_activity_actual_time_script(Activity) of
        [{_, _, _, Duration} | _] -> Duration * 60;
        _ -> null
    end.

%% 对外提供的接口，非活动进程请调用该接口
%% 取得活动开启时间
%% @return :: [{Hour, Min}] | []
publ_get_activity_open_time(Activity) ->
    case get_activity_actual_time_script(Activity) of
        List when is_list(List) -> [{Hour, Min} || {_, _, {Hour, Min}, _} <- List];
        _ -> []
    end.


%% @doc 活动是否到时间开启（服务器运作活动的时间，包括提前广播）
%% @return {true, Duration} | false
is_time_to_open_activity(Activity, Time) ->
    case get_activity_time_script(Activity) of
        ScriptTime when is_list(ScriptTime) ->
            is_time_to_open_activity_1(ScriptTime, Time);
        _ -> ?ASSERT(false), false
    end.
    % analyze_time_script(ScriptTime, Time).

%% @doc 活动是否到时间开启(策划定制的活动真是时间，不包括广播时间)]
is_actual_time_to_open_activity(Activity, Time) ->
    case get_activity_actual_time_script(Activity) of
        ScriptTime when is_list(ScriptTime) ->
            is_time_to_open_activity_1(ScriptTime, Time);
        _ -> ?ASSERT(false), false
    end.


%% @return {true, Duration} | false
is_time_to_open_activity_1([], _Time) -> false;
is_time_to_open_activity_1([ScriptTime | Left], Time) ->
    case analyze_time_script(ScriptTime, Time) of
        false -> is_time_to_open_activity_1(Left, Time);
        Other -> Other
    end.


%% @doc 关闭活动处理
%% @ActivityId : 活动编号
close_activity(_ActivityId) ->
    redo.


%% @doc 开启活动
open_activity(Activity, Duration) ->
    % ?LDS_DEBUG(open_activity, [{Activity}]),
    put(?ACTIVITY_OPEN(Activity), true),
    exec_script(get_activity_script(Activity)),
    erlang:start_timer((Duration * 60 + 10) * 1000, self(), {'close_activity', Activity}),
    redo.


%% @doc 执行脚本
exec_script([]) -> skip;
exec_script([Script | List]) ->
    exec_script__(Script),
    exec_script(List).


exec_script__({0, Script}) -> spawn_exec_script_now(Script);
exec_script__({Timing, Script}) when Timing > 0 ->
    erlang:start_timer(Timing * 1000, self(), {'delay_exec_script', Script});
exec_script__(_) -> ?ASSERT(false).


spawn_exec_script_now(Script) ->
    ?LDS_DEBUG(spawn_exec_script_now, [Script]),
    util:actin_new_proc(?MODULE, exec_script_now, [Script]).

exec_script_now({refresh, ScriptList}) ->
    % ?LDS_DEBUG(exec_script_refresh, [time(), ScriptList]),
    lib_task:refresh_script(ScriptList, sys);
exec_script_now({refresh_melee, ScriptList}) ->
    % ?LDS_DEBUG(exec_script_refresh, [time(), ScriptList]),
    Key = refresh_melee,
	erlang:put(Key, 1),
	lib_task:refresh_script(ScriptList, sys),
	erlang:erase(Key);
exec_script_now({broadcast, BroadcastList}) ->
    script_broadcast(BroadcastList);
exec_script_now({answer, _}) -> skip;
%     lib_activity:notify_enter_answer_activity();
exec_script_now({guild_party_b}) ->
    mod_guild_mgr:guild_party_begin();
exec_script_now({guild_party_e}) ->
    mod_guild_mgr:guild_party_end();
exec_script_now({refresh_in_guild_dungeon, ScriptList}) ->
    mod_guild_mgr:refresh_script(ScriptList, sys);
exec_script_now({add_guild_buff, Interval}) ->
    mod_guild_mgr:add_guild_buff(Interval);
exec_script_now({guild_dungeon_b, _}) ->
    mod_guild_mgr:notify_guild_dungeon_begin();
exec_script_now({notify_activity_open, SysList}) ->
    notify_activity_open(SysList);
exec_script_now({open_boss_dungeon, [DunNo]}) ->
    ?LDS_DEBUG("[mod_activity] open_boss_dungeon"),
    gen_server:cast(dungeon_manage, {'create_boss_dungeon', DunNo, util:unixtime()});
exec_script_now(cruise_activity_begin) ->
    mod_cruise:on_activity_begin();
exec_script_now({melee_activity_begin}) ->
    lib_melee:melee_open();
exec_script_now({melee_activity_end}) ->
    lib_melee:melee_close();
exec_script_now({arena_1v1_close}) ->
    mod_arena_1v1:arena_1v1_close();
exec_script_now({arena_3v3_close}) ->
    ?LDS_DEBUG("[mod_activity] arena_3v3_close"),
    mod_arena_3v3:arena_3v3_close();
%新年宴会活动
exec_script_now({newyearBroadcast, BroadcastList}) ->
    script_broadcast(BroadcastList);
exec_script_now({newyear_scene}) ->
    lib_newyear_banquet:create_newyear_banquet_scene(),
    mod_newyear_banquet:start();
exec_script_now({newyear_banquet_b}) ->
    mod_newyear_banquet:newyear_banquet_open(1, 1);
exec_script_now({newyear_banquet_e}) ->
    mod_newyear_banquet:newyear_banquet_close(1, 1),
    mod_newyear_banquet:stop(),
    lib_newyear_banquet:close_newyear_banquet_scene();



exec_script_now({discount, No, Discount}) ->
    case ets:lookup(?ETS_ADMIN_SYS_SET, No) of
        [SysSet] when is_record(SysSet, admin_sys_set) ->
            ets:insert(?ETS_ADMIN_SYS_SET, SysSet#admin_sys_set{script = [{discount, Discount} | SysSet#admin_sys_set.script]});
        _ -> ets:insert(?ETS_ADMIN_SYS_SET, #admin_sys_set{no = No, script = [{discount, Discount}]})
    end;

exec_script_now({del_scene_npc, SceneNo, NpcNo}) ->
    mod_scene:clear_spec_no_dynamic_npc_from_scene_WNC(SceneNo, NpcNo);

exec_script_now({multi_reward, No, Multi}) when is_integer(Multi) andalso Multi > 0 ->
    case ets:lookup(?ETS_ADMIN_SYS_SET, No) of
        [SysSet] when is_record(SysSet, admin_sys_set) -> 
            ets:insert(?ETS_ADMIN_SYS_SET, SysSet#admin_sys_set{script = [{multi_reward, Multi} | SysSet#admin_sys_set.script]});
        _ -> ets:insert(?ETS_ADMIN_SYS_SET, #admin_sys_set{no = No, script = [{multi_reward, Multi}]})
    end;

exec_script_now({guild_battle_ready_begin}) ->
    ?LDS_DEBUG("[mod_activity]", {guild_battle_ready_begin, erlang:localtime()}),
    mod_guild_mgr:notify_guild_pre_war_begin();

exec_script_now({guild_battle_ready_end}) ->
    mod_guild_mgr:notify_guild_pre_war_end();
    
exec_script_now({guild_battle_begin}) ->
    mod_guild_mgr:notify_guild_war_begin();
    
exec_script_now({guild_battle_end}) ->
    ?LDS_DEBUG("[mod_activity]", {guild_battle_end, erlang:localtime()}),
    mod_guild_mgr:notify_guild_war_end();

exec_script_now({give_goods, No, GoodsNo, CntLimit}) ->
    case ets:lookup(?ETS_ADMIN_SYS_SET, No) of
        [SysSet] when is_record(SysSet, admin_sys_set) -> 
            ets:insert(?ETS_ADMIN_SYS_SET, SysSet#admin_sys_set{script = [{give_goods, GoodsNo, CntLimit} | SysSet#admin_sys_set.script]});
        _ -> 
            ets:insert(?ETS_ADMIN_SYS_SET, #admin_sys_set{no = No, script = [{give_goods, GoodsNo, CntLimit}]})
    end;

exec_script_now({give_goods_high, No, GoodsNo, CntLimit}) ->
    case ets:lookup(?ETS_ADMIN_SYS_SET, No) of
        [SysSet] when is_record(SysSet, admin_sys_set) -> 
            ets:insert(?ETS_ADMIN_SYS_SET, SysSet#admin_sys_set{script = [{give_goods_high, GoodsNo, CntLimit} | SysSet#admin_sys_set.script]});
        _ -> 
            ets:insert(?ETS_ADMIN_SYS_SET, #admin_sys_set{no = No, script = [{give_goods_high, GoodsNo, CntLimit}]})
    end;

exec_script_now(_Any) -> ?ASSERT(false, _Any).



%% {cycle,{day/week/month, 0/indexDay/indexDay},{hour, minute},duration}  |  {specific, year, month, day, hour, minute}
%% @return {true, Duration} | false
analyze_time_script({cycle, {day, _}, {Hour, Min}, Duration}, {{_, {NowHour, NowMin, _}}, _}) ->
    % ?BIN_PRED(NowHour > Hour orelse (NowHour =:= Hour andalso NowMin >= Min), {true, Duration}, false);
    analyze_day_time({Hour, Min}, {NowHour, NowMin}, Duration);
analyze_time_script({cycle, {week, IndexDay}, {Hour, Min}, Duration}, {{_, {NowHour, NowMin, _}}, WeekDay}) when is_integer(IndexDay) ->
    ?BIN_PRED(IndexDay =:= WeekDay, analyze_day_time({Hour, Min}, {NowHour, NowMin}, Duration), false);
analyze_time_script({cycle, {week, DayList}, {Hour, Min}, Duration}, {{_, {NowHour, NowMin, _}}, WeekDay}) when is_list(DayList) ->
    ?BIN_PRED(lists:member(WeekDay, DayList), analyze_day_time({Hour, Min}, {NowHour, NowMin}, Duration), false);
analyze_time_script({cycle, {month, IndexDay}, {Hour, Min}, Duration}, {{{_, _, NowDay}, {NowHour, NowMin, _}}, _}) when is_integer(IndexDay) ->
    ?BIN_PRED(IndexDay =:= NowDay, analyze_day_time({Hour, Min}, {NowHour, NowMin}, Duration), false);
analyze_time_script({cycle, {month, DayList}, {Hour, Min}, Duration}, {{{_, _, NowDay}, {NowHour, NowMin, _}}, _}) when is_list(DayList) ->
    ?BIN_PRED(lists:member(NowDay, DayList), analyze_day_time({Hour, Min}, {NowHour, NowMin}, Duration), false);
analyze_time_script({specific, Year, Month, Day, Hour, Minute, Duration}, {{{NowYear, NowMonth, NowDay}, {NowHour, NowMin, _}}, _}) ->
    ?BIN_PRED(Year =:= NowYear andalso Month =:= NowMonth andalso Day =:= NowDay andalso Hour =:= NowHour andalso Minute =:= NowMin,
        {true, Duration}, false).


analyze_day_time({Hour, Min}, {NowHour, NowMin}, Duration) ->
    case NowHour > Hour orelse (NowHour =:= Hour andalso NowMin >= Min) of
        true ->
            LastHour = Hour + (Duration div 60),
            LastMin  = Min + (Duration rem 60),

            {EndHour, EndMin} = case LastMin >= 60 of
                true -> {(LastHour + 1) rem 24, LastMin - 60};
                false -> {(LastHour rem 24), LastMin}
            end,

            case NowHour < EndHour orelse (NowHour =:= EndHour andalso NowMin < EndMin) of
                true -> {true, (EndHour - NowHour) * 60 + (EndMin - NowMin)};
                false -> false
            end;
        false -> false
    end.

%% 定时记录在线人数
timing_log_online_num() ->
    Num = mod_svr_mgr:get_total_online_num(),
    lib_log:statis_online(Num),
    erlang:start_timer(?LOG_ONLINE_NUM_INTEVAL, self(), 'timing_online_num').

%% ===========================================================
%% config data
%% ===========================================================

%% @ doc 取得活动列表
get_activity_list() ->
    % data_activity_degree:
    data_activity_degree:get_script_activity_list().

get_activity_time_script(Activity) ->
    data_activity_degree:get_time_script(Activity).

get_activity_actual_time_script(Activity) ->
    data_activity_degree:get_actual_time_script(Activity).

get_activity_script(Activity) ->
    data_activity_degree:get_script(Activity).




%% ==================================================
%% script
%% ==================================================

%% 公告脚本
script_broadcast([]) -> skip;
script_broadcast([{No, Args} | Left]) ->
    mod_broadcast:send_sys_broadcast(No, Args),
    script_broadcast(Left).




%% ==================================================

%% 通知系统开放
notify_activity_open([]) -> skip;
notify_activity_open([Sys | Left]) ->
    notify_activity_open__(Sys),
    notify_activity_open(Left);
notify_activity_open(_Arg) -> ?LDS_DEBUG(error, [_Arg]), skip.


notify_activity_open__(?AD_EXAM) -> 
    lib_activity:notify_enter_answer_activity();
notify_activity_open__(Sys) -> 
    F = fun(RoleId) -> 
        % ?LDS_DEBUG("notify_activity_open__", [{Sys}]),
        {ok, BinData} = pt_58:write(58005, [[{Sys, 0, 0}]]),
        lib_send:send_to_uid(RoleId, BinData)
    end,
    lists:foreach(F, mod_svr_mgr:get_all_online_player_ids()).


%% 升级检查活动开启
upgrade_notify_activity(Status) ->
    check_activity_open(Status).

    
check_activity_open(Status) ->
    OpenList = check_activity_open_1(get_activity_list(), Status, []),

    % ?LDS_TRACE("[activity_degree] upgrade_notify_activity", [OpenList]),
    {ok, BinData} = pt_58:write(58005, [[{Sys, State, 1} || {Sys, State} <- OpenList]]),
    lib_send:send_to_uid(player:id(Status), BinData).

check_activity_open_1([], _, Sum) -> Sum;
check_activity_open_1([Sys | Left], Status, Sum) ->
    case check_activity_open__(Sys, Status) of
        true -> check_activity_open_1(Left, Status, [{Sys, 0} | Sum]);
        false -> check_activity_open_1(Left, Status, Sum)
    end.

check_activity_open__(Sys, Status) ->
    case publ_is_activity_alive(Sys) of
        true -> data_activity_degree:get_activity_open_lv(Sys) =:= player:get_lv(Status);
        false -> false
    end.


%% @doc 活动结束时通知玩家
activity_over_notify(Status) -> 
    gen_server:cast(player:get_pid(Status), 'activity_over_notify').


%% 登录时检查活动开启
login_check_activity_open(Status) ->
    OpenList = login_check_activity_open_1(get_activity_list(), Status, []),
    % ?LDS_TRACE(58005, [{A} || A <- OpenList]),
    {ok, BinData} = pt_58:write(58005, [[{Sys, State, 0} || {Sys, State} <- OpenList]]),
    lib_send:send_to_uid(player:id(Status), BinData).

login_check_activity_open_1([], _, Sum) -> Sum;
login_check_activity_open_1([Sys | Left], Status, Sum) ->
    case login_check_activity_open__(Sys, Status) of
        true -> login_check_activity_open_1(Left, Status, [{Sys, 0} | Sum]);
        false -> login_check_activity_open_1(Left, Status, Sum)
    end.

login_check_activity_open__(Sys, Status) ->
    case publ_is_activity_alive(Sys) of
        true -> 
            case data_activity_degree:get_activity_open_lv(Sys) =< player:get_lv(Status) of
                true -> check_actual_take_part_in(Sys, Status);
                false -> false
            end;
        false -> false
    end.

%% @doc 检查玩家可参与活动的真实情况
%% @return : boolean()
check_actual_take_part_in(?AD_EXAM, Status) ->
    lib_activity:notify_open_answer(Status);
check_actual_take_part_in(?AD_CRUISE, Status) ->
    ply_cruise:has_join_times(Status);
check_actual_take_part_in(?AD_GUILD_DUNGEON, Status) ->
    lib_guild:can_join_guild_dungeon(Status);
check_actual_take_part_in(?AD_DUNGEON_BOSS, _Status) ->
    case get(?PUBLIC_ACITICTY_ALIVE(?AD_DUNGEON_BOSS)) of
        1 -> true;
        _ -> false
    end;
check_actual_take_part_in(_, _) -> true.


%% @doc 活动结束时通知玩家
notify_close_activity(RoleIdList, Sys) ->
    ?LDS_DEBUG(58005, [{Sys, 2}]),
    {ok, BinData} = pt_58:write(58005, [[{Sys, 2, 0}]]),
    [lib_send:send_to_uid(RoleId, BinData) || RoleId <- RoleIdList].
