-module (mod_admin_activity).
-behavour(gen_server).
-export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, get_role_order_id_list/1, check_role_admin_activity/3, login_check_admin_activity/2,
    add_new_admin_activity/9, fetch_admin_activity/2, fetch_admin_activity_list/1, logout_handle/1, admin_sys_activity_end/2,
    admin_sys_activity_start/2, add_new_admin_sys_activity/7, delete_admin_sys_activity/1, fetch_admin_sys_activity_list/1,
    get_reward_admin_sys_activity/3,
    fetch_admin_sys_activity/2, check_update/2, check_delete/1,
    check_add_all_festival_activity/1, add_db_festival_activity/5,
    single_add_festival_activity/5, delete_festival_activity/2, delete_all_festival_activity/0,
    fetch_festival_activity/1, fetch_assign_festival_activity/2,
    action_festival_script/1, get_admin_sys_set/1, check_update_festival/5,
    is_festival_activity_alive/1, is_festival_act_alive/1, get_admin_set_rd/1, get_festival_config_data/1, exec_script_for_act/1, tst_add_fes_act/3,
    notify_value_admin_sys_activity_all/2, notify_value_admin_sys_activity/2
]).

-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("admin_activity.hrl").
-include("log.hrl").
-include("player.hrl").

-record(state, {}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


init([]) ->
    process_flag('trap_exit', true),
    load_admin_activity(),
    load_admin_sys_activity(),
    load_admin_festival_activity(),
    start_check_timer(),
    {ok, #state{}}.


handle_call(_Msg, _From, State) ->
    {reply, badmatch, State}.

handle_cast({'notify_client_new_admin_activity', AdminActivity}, State) ->
    try
        notify_client_new_admin_activity(AdminActivity),
        {noreply, State}
    catch
        _T:_E ->
            ?ERROR_MSG("[mod_activity] notify_admin_sys_activity_change error = ~p~n", [{_T, _E}]),
            {noreply, State}
    end;

handle_cast({'notify_admin_sys_activity_change', Type, OrderId}, State) ->
    try
        List = mod_svr_mgr:get_all_online_player_ids(),
        case Type of
            add ->
                case ets:lookup(?ETS_ADMIN_SYS_ACTIVITY, OrderId) of
                    [Activity] when is_record(Activity, admin_sys_activity) ->
                        BinData = pack_sys_activity_content(Activity),
%%                         {ok, BinData} = pt_31:write(31061, [Activity#admin_sys_activity.order_id, Activity#admin_sys_activity.show_panel]),
                        lists:foreach(fun(RoleId) -> lib_send:send_to_uid(RoleId, BinData) end, List);
                    _ -> skip
                end;
            del ->
                {ok, BinData} = pt_31:write(31062, [OrderId, 0]),
                lists:foreach(fun(RoleId) -> lib_send:send_to_uid(RoleId, BinData) end, List)
        end
    catch
        _T:_E -> ?ERROR_MSG("[mod_activity] notify_admin_sys_activity_change error = ~p~n", [{_T, _E}])
    end,
    {noreply, State};

handle_cast({'test', OrderId, StartTime, EndTime, MailTitle, MailContent, MailAttach, ClientStartTime, ClientEndTime, ClientContent}, State) ->
    try
        add_new_admin_activity(OrderId, StartTime, EndTime, MailTitle, MailContent, MailAttach, ClientStartTime, ClientEndTime, ClientContent),
        {noreply, State}
    catch
        _:_ ->
            ?ERROR_MSG("[mod_activity] test error", []),
            {noreply, State}
    end;


handle_cast(t, State) ->
    erlang:error({kaho}),
    {noreply, State};

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info('check_admin_activity', State) ->
    try
        start_check_timer(),
        Now = util:unixtime(),
        ActiveList = get_active_admin_activity(Now),
        F = fun(ActiveId) ->
            case get(?AA_ACTIVE(ActiveId)) of
                undefined ->
                    notify_online_players(ActiveId),
                    put(?AA_ACTIVE(ActiveId), 1);
                _ -> skip
            end
            end,
        lists:foreach(F, ActiveList),

        check_admin_sys_activity(Now),

        check_open_festival(Now),
        {noreply, State}
    catch
        _T:_E ->
            ?ERROR_MSG("[mod_activity] check_admin_activity error = ~p~n", [{_T, _E}]),
            {noreply, State}
    end;

handle_info(_Msg, State) ->
    {noreply, State}.


code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


terminate(_Reason, _State) ->
    ok.


start_check_timer() ->
    erlang:send_after(?AA_TIMER_INTERVAL, self(), 'check_admin_activity').


%% ===========================================
%% 运营活动
%% ===========================================

%% @doc 开服加载运营活动
load_admin_activity() ->
    case db:select_all(admin_activity, "*", [{end_time, ">", util:unixtime()}]) of
        [] -> skip;
        List when is_list(List) ->
            F = fun([OrderId, StartTime, EndTime, MailTitle, MailContent, MailAttach, ClientStartTime, ClientEndTime, ClientContent]) ->
                AdminActivity = make_admin_activity_record(OrderId, StartTime, EndTime, MailTitle, MailContent, util:bitstring_to_term(MailAttach),
                    ClientStartTime, ClientEndTime, ClientContent),
                ets:insert(?ETS_ADMIN_ACTIVITY, AdminActivity)
                end,
            lists:foreach(F, List)
    end.


load_admin_sys_activity() ->
    Now = util:unixtime(),
    case db:select_all(admin_sys_activity, "order_id, trigger_timestamp, end_timestamp, sys, content, show_panel, display",
        [{end_timestamp, ">", Now}, {state, "<", 2}]) of
        [] -> skip;
        List when is_list(List) ->
            F = fun([OrderId, Timestamp, EndTime, Sys, Content, ShowPanel, Display]) ->
                add_new_admin_sys_activity(OrderId, Timestamp, EndTime, Sys, util:bitstring_to_term(Content), ShowPanel, Display)
                end,
            lists:foreach(F, List)
    end,
    case db:select_all(admin_sys_activity, "order_id", [{end_timestamp, "<=", util:unixtime()}, {state, "<", 2}]) of
        [] -> skip;
        PastList when is_list(PastList) ->
            lists:foreach(
                fun([PastOrderId]) ->
                    db:update(?DB_SYS, admin_sys_activity, [{state, 2}], [{order_id, PastOrderId}])
                end,
                PastList)
    end.


%% @doc 添加新的运营活动
%% @retrun : Code
add_new_admin_activity(OrderId, StartTime, EndTime, MailTitle, MailContent, MailAttach, ClientStartTime, ClientEndTime, ClientContent) ->
    Now = util:unixtime(),
    case check_admin_activity(OrderId, ClientStartTime, ClientEndTime, Now) of
        {false, ErrCode} -> ErrCode;
        true ->
            case check_mail(StartTime, ClientStartTime, EndTime, MailTitle, MailContent, MailAttach) of
                false -> 6;
                true ->
                    AdminActivity = make_admin_activity_record(OrderId, StartTime, EndTime, MailTitle,
                        MailContent, MailAttach, ClientStartTime, ClientEndTime, ClientContent),
                    save_admin_activity(AdminActivity),
                    % 通知客户端
                    gen_server:cast(?MODULE, {'notify_client_new_admin_activity', AdminActivity}),
                    % notify_client_new_admin_activity(AdminActivity),
                    1
                % 通知活动预备
                % erlang:start_timer((Now - StartTime) * 1000, misc:whereis_name({local, mod_activity}), {'admin_activity_open', OrderId})
            end
    end.


check_mail(StartTime, ClientStartTime, EndTime, _, _, _) when StartTime < ClientStartTime orelse StartTime > EndTime -> false;
check_mail(_, _, _, MailTitle, MailContent, MailAttach) ->
    case erlang:is_binary(MailTitle) andalso erlang:is_binary(MailContent) of
        true -> lib_mail:check_attach(MailAttach);
        false -> false
    end.


%% @doc 检查活动
check_admin_activity(_OrderId, ClientStartTime, _ClientEndTime, Now) when ClientStartTime < Now -> {false, 5};
check_admin_activity(_OrderId, ClientStartTime, ClientEndTime, _Now) when ClientStartTime >= ClientEndTime -> {false, 6};
check_admin_activity(OrderId, ClientStartTime, ClientEndTime, _Now) ->
    List = ets:tab2list(?ETS_ADMIN_ACTIVITY),
    case lists:keyfind(OrderId, 2, List) of
        false ->
            case check_not_overlap_activity(ClientStartTime, ClientEndTime, List) of
                true -> true;
                false -> {false, 4}
            end;
        _ -> {false, 2}
    end.

%% @doc 检查活动是否重叠
check_not_overlap_activity(_StartTime, _EndTime, []) -> true;
check_not_overlap_activity(StartTime, EndTime, [AdminActivity | Left]) ->
    case (StartTime >= AdminActivity#admin_activity.client_start_time andalso StartTime =< AdminActivity#admin_activity.client_end_time) orelse
        (EndTime >= AdminActivity#admin_activity.client_start_time andalso EndTime =< AdminActivity#admin_activity.client_end_time) of
        true -> false;
        false -> check_not_overlap_activity(StartTime, EndTime, Left)
    end.


%% @doc 设置运营活动记录体
make_admin_activity_record(OrderId, StartTime, EndTime, MailTitle, MailContent, MailAttach, ClientStartTime, ClientEndTime, ClientContent) ->
    #admin_activity{
        order_id = OrderId
        ,start_time = StartTime
        ,end_time = EndTime
        ,mail_title = tool:to_binary(MailTitle)
        ,mail_content = tool:to_binary(MailContent)
        ,mail_attach = MailAttach
        ,client_start_time = ClientStartTime
        ,client_end_time = ClientEndTime
        ,client_content = tool:to_binary(ClientContent)
    }.


%% @doc 保存运营活动数据
save_admin_activity(AdminActivity) ->
    db:insert(?DB_SYS, admin_activity,
        [{order_id, AdminActivity#admin_activity.order_id}, {start_time, AdminActivity#admin_activity.start_time},
            {end_time, AdminActivity#admin_activity.end_time}, {mail_title, AdminActivity#admin_activity.mail_title},
            {mail_content, AdminActivity#admin_activity.mail_content}, {mail_attach, util:term_to_bitstring(AdminActivity#admin_activity.mail_attach)},
            {client_start_time, AdminActivity#admin_activity.client_start_time}, {client_end_time, AdminActivity#admin_activity.client_end_time},
            {client_content, AdminActivity#admin_activity.client_content}]),
    ets:insert(?ETS_ADMIN_ACTIVITY, AdminActivity).


%% @doc 通知客户端
notify_client_new_admin_activity(AdminActivity) ->
    {ok, BinData} = pt_31:write(31051,
        [AdminActivity#admin_activity.order_id, AdminActivity#admin_activity.client_start_time,
            AdminActivity#admin_activity.client_end_time, AdminActivity#admin_activity.client_content]),
    lists:foreach(fun(RoleId) -> lib_send:send_to_uid(RoleId, BinData) end, mod_svr_mgr:get_all_online_player_ids()).


%% @doc 通知在线用户处理处罚的活动
notify_online_players(ActiveId) ->
    lists:foreach(fun(Pid) -> gen_server:cast(Pid, {'trigger_admin_activity', ActiveId}) end, mod_svr_mgr:get_all_online_player_pids()).


%% @doc 请求单个运营活动详情
fetch_admin_activity(OrderId, Status) ->
    case ets:lookup(?ETS_ADMIN_ACTIVITY, OrderId) of
        [AdminActivity] when is_record(AdminActivity, admin_activity) ->
            {ok, BinData} = pt_31:write(31051,
                [AdminActivity#admin_activity.order_id, AdminActivity#admin_activity.client_start_time,
                    AdminActivity#admin_activity.client_end_time, AdminActivity#admin_activity.client_content]),
            lib_send:send_to_uid(player:id(Status), BinData);
        _ -> skip
    end.


%% @doc 请求运营活动列表
fetch_admin_activity_list(Status) ->
    List = ets:tab2list(?ETS_ADMIN_ACTIVITY),
    {ok, BinData} = pt_31:write(31050, [[AdminActivity#admin_activity.order_id || AdminActivity <- List, is_record(AdminActivity, admin_activity)]]),
    lib_send:send_to_uid(player:id(Status), BinData).


% %% @doc 触发活动
% trigger_admin_activity(OrderId) ->
%     lists:foreach(fun(Pid) -> Pid ! {'trigger_admin_activity', OrderId}, mod_svr_mgr:get_all_online_player_pids()).


%% @doc 上线检查活动(必须玩家进程处理)
login_check_admin_activity(RoleId, role_in_cache) ->
    ActiveList = get_active_admin_activity(),
    ExistList = get_role_order_id_list(RoleId),
    check_role_admin_activity(RoleId, ExistList, ActiveList);
login_check_admin_activity(RoleId, _) ->
    ActiveList = get_active_admin_activity(),
    case db:select_row(role_admin_activity, "order_id_list", [{role_id, RoleId}]) of
        [] ->
            db:insert(RoleId, role_admin_activity, [{role_id, RoleId}, {order_id_list, util:term_to_bitstring([])}]),
            ets:insert(?ETS_ROLE_ADMIN_ACTIVITY, #role_admin_activity{role_id = RoleId, order_id_list = []}),
            check_role_admin_activity(RoleId, [], ActiveList);
        [RawData] ->

            OrderList = [Elem || {Elem} <- util:bitstring_to_term(RawData)],
            % ?LDS_DEBUG("login_check_admin_activity", [{OrderList, ActiveList}]),
            ets:insert(?ETS_ROLE_ADMIN_ACTIVITY, #role_admin_activity{role_id = RoleId, order_id_list = OrderList}),
            check_role_admin_activity(RoleId, OrderList, ActiveList)
    end.


%% @doc 下线处理
logout_handle(RoleId) ->
    ets:delete(?ETS_ROLE_ADMIN_ACTIVITY, RoleId).


%% @doc 取得角色已经参与的活动ID列表
get_role_order_id_list(RoleId) ->
    case ets:lookup(?ETS_ROLE_ADMIN_ACTIVITY, RoleId) of
        [Activity | _] when is_record(Activity, role_admin_activity) -> Activity#role_admin_activity.order_id_list;
        _ -> []
    end.

%% @doc 更新角色硬件参与的活动Id列表
update_role_admin_activity(RoleId, List) ->
    ets:insert(?ETS_ROLE_ADMIN_ACTIVITY, #role_admin_activity{role_id = RoleId, order_id_list = List}),
    SaveList = [{Elem} || Elem <- List],
    % ?LDS_DEBUG("check_role_admin_activity_1", SaveList),
    db:update(RoleId, role_admin_activity, [{order_id_list, util:term_to_bitstring(SaveList)}], [{role_id, RoleId}]).


%% @doc 检查角色参与活动
check_role_admin_activity(_, _, []) -> skip;
check_role_admin_activity(RoleId, ExistList, ActiveList) ->
    check_role_admin_activity_1(RoleId, ExistList, ActiveList, []).

check_role_admin_activity_1(_, _, [], []) -> skip;
check_role_admin_activity_1(RoleId, ExistList, [], CountList) ->
    update_role_admin_activity(RoleId, lists:append(ExistList, CountList));
check_role_admin_activity_1(RoleId, ExistList, [ActiveId | Left], CountList) ->
    case lists:member(ActiveId, ExistList) of
        true -> check_role_admin_activity_1(RoleId, ExistList, Left, CountList);
        false ->
            NewCount =
                try send_admin_activity_reward(RoleId, ActiveId) of
                    _ -> [ActiveId | CountList]
                catch
                    T:E ->
                        ?ERROR_MSG("[admin_activity] send_admin_activity_reward error = ~p, RoleId = ~p, ActivityId = ~p~n",
                            [{T, E}, RoleId, ActiveId]),
                        CountList
                end,
            check_role_admin_activity_1(RoleId, ExistList, Left, NewCount)
    end.


%% @doc 发放运营活动奖励
send_admin_activity_reward(RoleId, ActiveId) when is_integer(ActiveId) ->
    case ets:lookup(?ETS_ADMIN_ACTIVITY, ActiveId) of
        [AdminActivity | _] when is_record(AdminActivity, admin_activity) ->
            send_admin_activity_reward(RoleId, AdminActivity),
            ok;
        _ -> throw({error, unfinddata})
    end;
send_admin_activity_reward(RoleId, AdminActivity) when is_record(AdminActivity, admin_activity) ->
    % ?LDS_DEBUG("[admin_activity] begin send mail", [AdminActivity#admin_activity.mail_attach]),
    lib_mail:send_sys_mail(RoleId, AdminActivity#admin_activity.mail_title,
        AdminActivity#admin_activity.mail_content, AdminActivity#admin_activity.mail_attach, [?LOG_MAIL, "recv_gm"]),
    % ?LDS_DEBUG("[admin_activity] end send mail"),
    ok.


%% @doc 取得生效的活动ID列表
get_active_admin_activity() ->
    get_active_admin_activity(util:unixtime()).

get_active_admin_activity(Now) ->
    lists:foldl(
        fun(AdminActivity, AccList) ->
            if  AdminActivity#admin_activity.start_time > Now -> AccList;
                AdminActivity#admin_activity.start_time =< Now andalso AdminActivity#admin_activity.end_time >= Now ->
                    [AdminActivity#admin_activity.order_id | AccList];
                true ->
                    ets:delete(?ETS_ADMIN_ACTIVITY, AdminActivity#admin_activity.order_id),
                    AccList
            end
        end, [], ets:tab2list(?ETS_ADMIN_ACTIVITY)).



%% ===================================
%% 运营-系统活动
%% ===================================

%% @doc 检查活动
check_admin_sys_activity(Now) ->
    List = get_all_admin_sys_activity_brief(),
    lists:foreach(
        fun(Activity) ->
            case Now >= Activity#admin_sys_activity_brief.timestamp of
                true ->
                    case Activity#admin_sys_activity_brief.state =:= 1 of
                        true ->
                            case Now < Activity#admin_sys_activity_brief.end_time of
                                true -> skip;
                                false ->
                                    notify_admin_sys_activity_end(Activity#admin_sys_activity_brief.order_id),
                                    delete_admin_sys_activity(Activity#admin_sys_activity_brief.order_id)
                            end;
                        false ->
                            update_admin_sys_activity_state(Activity, 1),
                            notify_admin_sys_activity_start(Activity#admin_sys_activity_brief.order_id)

                        % case Activity#admin_sys_activity_brief.end_time =:= 0 of
                        %     true -> delete_admin_sys_activity(Activity#admin_sys_activity_brief.order_id);
                        %     false -> update_admin_sys_activity_state(Activity, 1)
                        % end
                    end;
                false -> skip
            end
        end, List).


%% @doc 通知活动开启
notify_admin_sys_activity_start(OrderId) ->
    case ets:lookup(?ETS_ADMIN_SYS_ACTIVITY, OrderId) of
        [Activity] when is_record(Activity, admin_sys_activity) ->
            util:actin_new_proc(?MODULE, admin_sys_activity_start, [Activity#admin_sys_activity.sys, Activity]);
        _T ->
            ?ERROR_MSG("[admin_sys_activity] open admin_activity id = ~p error = ~p~n", [OrderId, _T]),
            ?ASSERT(false, [_T])
    end.


%% @doc 活动开始各系统处理
admin_sys_activity_start(1, Activity) ->
    mod_rank_gift:gift_for_rank(Activity#admin_sys_activity.content, Activity#admin_sys_activity.order_id);
admin_sys_activity_start(2, Activity) ->
    mod_guild_mgr:give_reward_for_activity(Activity#admin_sys_activity.content);
admin_sys_activity_start(3, Activity) ->
    mod_svr_mgr:open_recharge_accum_activity(Activity);
admin_sys_activity_start(10, Activity) ->
    mod_beauty_contest:beauty_contest_open(10, Activity#admin_sys_activity.content);
admin_sys_activity_start(Sys, Activity) when Sys >= 6 andalso Sys =< 9 ->
    mod_svr_mgr:open_consume_activity(Activity);
admin_sys_activity_start(11, Activity) ->
    mod_shop:on_op_shop_activity_open(Activity#admin_sys_activity.content,
        Activity#admin_sys_activity.timestamp, Activity#admin_sys_activity.end_time);
admin_sys_activity_start(12, Activity) ->
    mod_svr_mgr:open_role_admin_activity(Activity);
admin_sys_activity_start(13, Activity) ->
    mod_svr_mgr:open_recharge_one_activity(Activity);
admin_sys_activity_start(14, Activity) ->
    mod_svr_mgr:open_recharge_accum_day_activity(Activity);
admin_sys_activity_start(_Sys, _) ->
    ?LDS_DEBUG("start admin_activity", _Sys),
    skip.


%% @doc 通知活动结束
notify_admin_sys_activity_end(OrderId) ->
    case ets:lookup(?ETS_ADMIN_SYS_ACTIVITY, OrderId) of
        [Activity] when is_record(Activity, admin_sys_activity) ->
            util:actin_new_proc(?MODULE, admin_sys_activity_end, [Activity#admin_sys_activity.sys, Activity]);
        _T ->
            ?ERROR_MSG("[admin_sys_activity] open admin_activity id = ~p error = ~p~n", [OrderId, _T]),
            ?ASSERT(false, [_T])
    end.


%% @doc 活动结束各系统处理
admin_sys_activity_end(3, _) ->
    mod_svr_mgr:close_recharge_accum_activity();
admin_sys_activity_end(10, Activity) ->
    mod_beauty_contest:beauty_contest_close(10, Activity#admin_sys_activity.content);
admin_sys_activity_end(Sys, _) when Sys >= 6 andalso Sys =< 9 ->
    mod_svr_mgr:close_consume_activity(Sys);
admin_sys_activity_end(12, Activity) ->
    mod_svr_mgr:close_role_admin_activity(Activity);
%% 单笔充值活动
admin_sys_activity_end(13, _) ->
    mod_svr_mgr:close_recharge_one_activity();
admin_sys_activity_end(14, _) ->
    mod_svr_mgr:close_recharge_accum_day_activity();
admin_sys_activity_end(15, Activity) ->
    ?DEBUG_MSG("fasongjiangli2",[]),
    lib_newyear_banquet:set_time_limit_rank(),
    mod_rank_gift:limit_gift_for_rank(Activity#admin_sys_activity.content);

admin_sys_activity_end(16, _) ->
    ?DEBUG_MSG("fasongjiangli16",[]),
    lib_limited_task:send_rank_reward(),
    lib_limited_task:get_rank_player_data();
admin_sys_activity_end(Sys, _) when Sys >= 17 andalso Sys =< 18 ->
    clear_player_day_racharge(),
    clear_player_acc_recharge();

admin_sys_activity_end(Sys, _) when Sys >= 19 andalso Sys =< 20 ->
    clear_player_acc_recharge();

admin_sys_activity_end(_Sys, _Id) ->
    ?LDS_DEBUG("end admin_activity", _Sys),
    skip.

clear_player_day_racharge() ->
    ets:delete_all_objects(ets_player_day_recharge),
    db:update(clock_data, "UPDATE clock_data  SET fanli = '{1,1,[]}'").

clear_player_acc_recharge()->
    ets:delete_all_objects(ets_player_acc_recharge).



%% @doc 取得所有系统活动
%% @return : list()
get_all_admin_sys_activity() ->
    ets:tab2list(?ETS_ADMIN_SYS_ACTIVITY).


%% @doc 取得所有系统活动简要信息
%% @return : list()
get_all_admin_sys_activity_brief() ->
    ets:tab2list(?ETS_ADMIN_SYS_ACTIVITY_BRIEF).


%% @doc 更新活动开启状态
%% @Brief::#admin_sys_activity_brief{}
update_admin_sys_activity_state(Brief, State) ->
    ets:insert(?ETS_ADMIN_SYS_ACTIVITY_BRIEF, Brief#admin_sys_activity_brief{state = State}),
    db:update(admin_sys_activity, [{state, State}], [{order_id, Brief#admin_sys_activity_brief.order_id}]).


%% @doc 添加新活动
add_new_admin_sys_activity(OrderId, Timestamp, EndTime, Sys, Content, ShowPanel, Display) ->
    ets:insert(?ETS_ADMIN_SYS_ACTIVITY, #admin_sys_activity{order_id = OrderId, timestamp = Timestamp, end_time = EndTime,
        sys = Sys, content = Content, show_panel = ShowPanel, display = Display}),
    ets:insert(?ETS_ADMIN_SYS_ACTIVITY_BRIEF, #admin_sys_activity_brief{order_id = OrderId, timestamp = Timestamp, end_time = EndTime}),
    notify_admin_sys_activity_change(add, OrderId).

%% @doc 添加正在开启的活动


%% @doc 更新活动
% update_admin_sys_activity(OrderId, Timestamp, Sys) ->
%     ets:insert(?ETS_ADMIN_SYS_ACTIVITY, #admin_sys_activity{order_id = OrderId, timestamp = Timestamp, sys = Sys}).

%% @doc 删除活动
delete_admin_sys_activity(OrderId) ->
    ets:delete(?ETS_ADMIN_SYS_ACTIVITY, OrderId),
    ets:delete(?ETS_ADMIN_SYS_ACTIVITY_BRIEF, OrderId),
    db:update(admin_sys_activity, [{state, ?AA_OVERDUE}], [{order_id, OrderId}]),
    notify_admin_sys_activity_change(del, OrderId).


notify_admin_sys_activity_change(Type, OrderId) ->
    gen_server:cast(mod_admin_activity, {'notify_admin_sys_activity_change', Type, OrderId}).


fetch_admin_sys_activity_list(Status) ->
    List = get_all_admin_sys_activity(),
    Data = [Activity#admin_sys_activity.order_id || Activity <- List,
        is_record(Activity, admin_sys_activity) andalso Activity#admin_sys_activity.display == 1],
    {ok, BinData} = pt_31:write(31060, [Data]),
    lib_send:send_to_uid(player:id(Status), BinData),
    notify_value_admin_sys_activity_all(Status, [3,6,8,13,14,20]).


fetch_admin_sys_activity(ActivityId, Status) ->
    case ets:lookup(?ETS_ADMIN_SYS_ACTIVITY, ActivityId) of
        [Activity] when is_record(Activity, admin_sys_activity) ->
            BinData = pack_sys_activity_content(Activity),
%%            {ok, BinData} = pt_31:write(31061, [Activity#admin_sys_activity.order_id, Activity#admin_sys_activity.show_panel]),
            lib_send:send_to_uid(player:id(Status), BinData);
        _ -> skip
    end.


%% 手动领取活动奖励
%% 累计充值
get_reward_admin_sys_activity(Status0, Value,  3) ->
    #player_status{recharge_accum = RechargeAccum} = Status = player:refresh_recharge_accum_data(Status0),
    Now = util:unixtime(),
    %% 判断活动开启状态和时间戳有效性和是否已领取
    case mod_svr_mgr:check_recharge_accum_activity_open(Now) of
        {true, Activity} when is_record(Activity, recharge_accum) ->
            #r_accum{activity_id = ActId,
                num = Num,
                timestamp = Timestamp,
                reward_yet = RewardYet} = RechargeAccum,
            %% 判断时间戳是否符合活动期间内，否则刷新
            case Activity#recharge_accum.id =:= ActId
                andalso Timestamp > Activity#recharge_accum.start_time
                andalso Timestamp =< Activity#recharge_accum.end_time
                andalso Num >= Value of
                true ->
                    {_Title, _MailContent, RankList} = Activity#recharge_accum.content,
                    case lists:keyfind(Value, 1, RankList) of
                        false -> skip;
                        {_, SendList} ->
                            case lists:keyfind(Value, 1, RewardYet) of
                                ?false ->
                                    case mod_inv:check_batch_add_goods(player:id(Status), [{Gid,Count}||{Gid,_IsBind,Count} <- SendList]) of
                                        {fail, Reason} ->  % 背包满了则不给
                                            lib_send:send_prompt_msg(Status0, Reason);
                                        ok ->
                                            PlayerId = player:id(Status),
                                            lists:foreach(fun({GoodsNo, IsBind, Count}) ->
                                                ExtraInitInfo = [{bind_state, IsBind}],
                                                mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, Count}], ExtraInitInfo, [?LOG_GOODS, "get_recharge_accum"])
                                                          end, SendList),
                                            RewardYet2 = [{Value, Now}|RewardYet],
                                            Status2 = Status#player_status{recharge_accum = RechargeAccum#r_accum{reward_yet = RewardYet2}},
                                            db:update(PlayerId, player, [{recharge_accum, util:term_to_bitstring(Status2#player_status.recharge_accum)}], [{id, PlayerId}]),
                                            player_syn:update_PS_to_ets(Status2),
                                            {ok, BinData} = pt_31:write(31063, [3, Value]),
                                            lib_send:send_to_sock(Status2, BinData),
                                            ok
                                    end;
                                {Value, TimeGet} ->
                                    %% 已领取
                                    ok
                            end
                    end;
                false ->
                    %% 为满足领取条件
                    ok
            end;
        false ->
            %% 活动为开启
            ok
    end;

get_reward_admin_sys_activity(Status0, Value,  No) when No == 6 orelse No == 8 ->
    MoneyType = case No of
                    6 ->
                        [gamemoney];
                    _ ->
                        [yuanbao]
                end,
    #player_status{consume_state = ConsumeState} = Status = player:refresh_consume_activity(Status0, MoneyType),
    Now = util:unixtime(),
    case player:query_consume_acitvity_open([No], Now) of
        {true, Activity, No} ->
            case lists:keytake(No, #r_consume.type, ConsumeState) of
                {value, #r_consume{reward_yet = RewardYet} = Rconsume, ConsumeState2} ->
                    {Title, MailContent, RankList} = Activity#consume_activity.content,
                    case lists:keyfind(Value, 1, RankList) of
                        false ->
                            skip;
                        {_, SendList} ->
                            case lists:keyfind(Value, 1, RewardYet) of
                                ?false ->
                                    case mod_inv:check_batch_add_goods(player:id(Status), [{Gid,Count}||{Gid,_IsBind,Count} <- SendList]) of
                                        {fail, Reason} ->  % 背包满了则不给
                                            lib_send:send_prompt_msg(Status0, Reason);
                                        ok ->
                                            PlayerId = player:id(Status),
                                            lists:foreach(fun({GoodsNo, IsBind, Count}) ->
                                                ExtraInitInfo = [{bind_state, IsBind}],
                                                mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, Count}], ExtraInitInfo, [?LOG_GOODS, "get_recharge_accum"])
                                                          end, SendList),
                                            RewardYet2 = [{Value, Now}|RewardYet],
                                            Status2 = Status#player_status{consume_state = [Rconsume#r_consume{reward_yet = RewardYet2}|ConsumeState2]},
                                            Ret = db:update(PlayerId, player, [{consume_state, util:term_to_bitstring(Status2#player_status.consume_state)}], [{id, PlayerId}]),
                                            player_syn:update_PS_to_ets(Status2),
                                            {ok, BinData} = pt_31:write(31063, [No, Value]),
                                            lib_send:send_to_sock(Status2, BinData),
                                            ok
                                    end;
                                {Value, TimeGet} ->
                                    %% 已领取
                                    ok
                            end
                    end;
                false ->
                    Status
            end;
        false ->
            Status
    end;

get_reward_admin_sys_activity(Status0, Value, 13) ->
    #player_status{one_recharge_reward = RechargeOne} = Status = player:refresh_recharge_one(Status0),
    Now = util:unixtime(),
    %% 判断活动开启状态和时间戳有效性和是否已领取
    case mod_svr_mgr:check_recharge_one_activity_open(Now) of
        {true, Activity} when is_record(Activity, recharge_one) ->
            #r_accum_one{activity_id = ActId,
                timestamp = Timestamp,
                reward_valid = RewardValid,
                reward_yet = RewardYet} = RechargeOne,
            %% RewardValid 这个值应该保存[{Amount, RechargeTimes, RewardTimes}]先判断次数是否符合才可领取
            %% 判断时间戳是否符合活动期间内，否则刷新
            case Activity#recharge_one.id =:= ActId andalso Timestamp > Activity#recharge_one.start_time andalso Timestamp =< Activity#recharge_one.end_time of
                true ->
                    {Title, MailContent, RankList} = Activity#recharge_one.content,
                    case player:select_recharge_one_reward(Value, RankList) of
                        [] ->
                            ?DEBUG_MSG("select_recharge_one_reward:~w~n", [{Title, MailContent, RankList}]),
                            Status;
                        [Data|_] ->
                            SendList =
                                case erlang:tuple_size(Data) > 2 of
                                    true ->
                                        element(3, Data);
                                    false ->
                                        element(2, Data)
                                end,
                            case lists:keytake(Value, 1, RewardValid) of
                                {value, {Value, RechargeTimes, RewardTimes}, RewardValid2} ->
                                    case RechargeTimes > RewardTimes of
                                        ?true ->
                                            NewRewardValid = [{Value, RechargeTimes, RewardTimes + 1}|RewardValid2],
                                            PlayerId = player:id(Status),
                                            case mod_inv:check_batch_add_goods(PlayerId, [{Gid,Count}||{Gid,_IsBind,Count} <- SendList]) of
                                                {fail, Reason} ->  % 背包满了则不给
                                                    lib_send:send_prompt_msg(Status0, Reason);
                                                ok ->
                                                    lists:foreach(fun({GoodsNo, IsBind, Count}) ->
                                                        ExtraInitInfo = [{bind_state, IsBind}],
                                                        mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, Count}], ExtraInitInfo, [?LOG_GOODS, "get_recharge_accum"])
                                                                  end, SendList),
%% 													RewardYet2 = [Value|RewardYet],
                                                    RechargeOne2 = RechargeOne#r_accum_one{reward_valid = NewRewardValid},
                                                    Status2 = Status#player_status{one_recharge_reward = RechargeOne2},
                                                    RoleId = player:id(Status2),
                                                    Ret = db:update(RoleId, player, [{one_recharge_reward, util:term_to_bitstring(RechargeOne2)}], [{id, RoleId}]),
                                                    player_syn:update_PS_to_ets(Status2),
                                                    {ok, BinData} = pt_31:write(31063, [13, Value]),
                                                    lib_send:send_to_sock(Status2, BinData),
                                                    ok
                                            end;
                                        ?false ->%% 领完了或者还没充值
                                            ok
                                    end;
                                false ->%% 没有充值数据
                                    ok
                            end
%% 							case lists:member(Value, RewardValid) andalso not lists:member(Value, RewardYet) of
%% 								?true ->
%% 									PlayerId = player:id(Status),
%% 									case mod_inv:check_batch_add_goods(PlayerId, [{Gid,Count}||{Gid,_IsBind,Count} <- SendList]) of
%% 										{fail, Reason} ->  % 背包满了则不给
%% 											{fail,Reason};
%% 										ok ->
%% 											lists:foreach(fun({GoodsNo, IsBind, Count}) ->
%% 																  ExtraInitInfo = [{bind_state, IsBind}],
%% 																  mod_inv:add_new_goods_to_bag(PlayerId, GoodsNo, Count, ExtraInitInfo)
%% 														  end, SendList),
%% 											RewardYet2 = [Value|RewardYet],
%% 											RechargeOne2 = RechargeOne#r_accum_one{reward_yet = RewardYet2},
%% 											Status2 = Status#player_status{one_recharge_reward = RechargeOne2},
%% 											RoleId = player:id(Status2),
%% 											Ret = db:update(RoleId, player, [{one_recharge_reward, util:term_to_bitstring(RechargeOne2)}], [{id, RoleId}]),
%% 											player_syn:update_PS_to_ets(Status2),
%% 											{ok, BinData} = pt_31:write(31063, [13, Value]),
%% 											lib_send:send_to_sock(Status2, BinData),
%% 											ok
%% 									end;
%% 								?false ->
%% 									ok
%% 							end
                    end;
                false ->
                    ok
            end;
        false ->
            ok
    end;

get_reward_admin_sys_activity(Status, Value,  14) ->
    #player_status{recharge_accum_day = RechargeAccumDay} = State2 = player:refresh_recharge_accum_day_data(Status),
    Now = util:unixtime(),
    %% 判断活动开启状态和时间戳有效性和是否已领取
    case mod_svr_mgr:check_recharge_accum_day_activity_open(Now) of
        {true, Activity} when is_record(Activity, recharge_accum_day) ->
            #r_accum_day{activity_id = ActId,
                num = Num,
                timestamp = Timestamp,
                reward_yet = RewardYet} = RechargeAccumDay,
            %% 判断时间戳是否符合活动期间内，否则刷新
            case Activity#recharge_accum_day.id =:= ActId andalso Timestamp > Activity#recharge_accum_day.start_time andalso Timestamp =< Activity#recharge_accum_day.end_time of
                true ->
                    {_Title, _MailContent, RankList} = Activity#recharge_accum_day.content,
                    % SendList = select_recharge_rank_list(Accum, Accum + Amount, RankList),
                    case lists:keyfind(Value, 1, RankList) of
                        false -> skip;
                        {_, SendList} ->
                            case lists:keyfind(Value, 1, RewardYet) of
                                ?false ->
                                    case mod_inv:check_batch_add_goods(player:id(Status), [{Gid,Count}||{Gid,_IsBind,Count} <- SendList]) of
                                        {fail, Reason} ->  % 背包满了则不给
                                            lib_send:send_prompt_msg(Status, Reason);
                                        ok ->
                                            PlayerId = player:id(Status),
                                            lists:foreach(fun({GoodsNo, IsBind, Count}) ->
                                                ExtraInitInfo = [{bind_state, IsBind}],
                                                mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, Count}], ExtraInitInfo, [?LOG_GOODS, "get_recharge_accum"])
                                                          end, SendList),
                                            RewardYet2 = [{Value, Now}|RewardYet],
                                            Status2 = Status#player_status{recharge_accum_day = RechargeAccumDay#r_accum_day{reward_yet = RewardYet2}},
                                            Ret = db:update(PlayerId, player, [{recharge_accum_day, util:term_to_bitstring(Status2#player_status.recharge_accum_day)}], [{id, PlayerId}]),
                                            player_syn:update_PS_to_ets(Status2),
                                            {ok, BinData} = pt_31:write(31063, [14, Value]),
                                            lib_send:send_to_sock(Status2, BinData),
                                            ok
                                    end;
                                {Value, TimeGet} ->
                                    %% 已领取
                                    ok
                            end
                    end;
                false ->
                    ok
            end;
        false ->
            ok
    end;

get_reward_admin_sys_activity(_Status, _Value,  _ActivityId) ->
    ok.



%% 获取活动进度值
%% 累计充值
progress_value_admin_sys_activity(Status, 3) ->
    #player_status{recharge_accum = RechargeAccum} = Status2 = player:refresh_recharge_accum_data(Status),
    {Status2, [{3, RechargeAccum#r_accum.num, RechargeAccum#r_accum.reward_yet}]};

%% 累计银币消耗
progress_value_admin_sys_activity(Status0, 6) ->
    #player_status{consume_state = ConsumeState} = Status = player:refresh_consume_activity(Status0, [gamemoney]),
    case lists:keyfind(6, #r_consume.type, ConsumeState) of
        #r_consume{num = Num, reward_yet = RewardYet} ->
            {Status, [{6, Num, RewardYet}]};
        false ->
            {Status, []}
    end;

%%累计消耗积分
progress_value_admin_sys_activity(Status0, 20) ->
    #player_status{consume_state = ConsumeState} = Status = player:refresh_consume_activity(Status0, [integral]),
    case lists:keyfind(20, 1, ConsumeState) of
        {_,{Num,_UnixTime}} ->
            {Status, [{20, Num, []}]};
        false ->
            {Status, []}
    end;

%% 累计水玉消耗
progress_value_admin_sys_activity(Status0, 8) ->
    #player_status{consume_state = ConsumeState} = Status = player:refresh_consume_activity(Status0, [yuanbao]),
    case lists:keyfind(8, #r_consume.type, ConsumeState) of
        #r_consume{num = Num, reward_yet = RewardYet} ->
            {Status, [{8, Num, RewardYet}]};
        false ->
            {Status, []}
    end;

%% 活跃度成就
progress_value_admin_sys_activity(Status, 12) ->
    {Status, []};

%% 单笔充值
progress_value_admin_sys_activity(Status0, 13) ->
    #player_status{one_recharge_reward = RechargeOne} = Status = player:refresh_recharge_one(Status0),
    Now = util:unixtime(),
    case mod_svr_mgr:check_recharge_one_activity_open(Now) of
        {true, Activity} when is_record(Activity, recharge_one) ->
            {_Title, _MailContent, RankList} = Activity#recharge_one.content,
            %% 现在没有冲过钱的档次前端也需要知道最大次数，所以不能用已充值数据来遍历
            L =
                lists:foldl(fun(Data, Acc) ->
                    Value = erlang:element(1, Data),
                    ValidTimes =
                        case player:select_recharge_one_reward(Value, RankList) of
                            [] ->
                                ?ERROR_MSG("Value, RankList :~w~n", [{Value, RankList}]),
                                0;
                            SendList ->
                                case erlang:hd(SendList) of
                                    {_, _} ->
                                        1;
                                    {_, ValidTimes0, _} ->
                                        ValidTimes0
                                end
                        end,
                    {RechargeTimes, RewardTimes} =
                        case lists:keyfind(Value, 1, RechargeOne#r_accum_one.reward_valid) of
                            {Value, RechargeTimes0, RewardTimes0} ->
                                {RechargeTimes0, RewardTimes0};
                            _ ->
                                {0, 0}
                        end,
                    [{13, Value, [ValidTimes, RechargeTimes, RewardTimes]}|Acc]
                            end, [], RankList),
            {Status, L};
        ?false ->
            {Status, []}
    end;

%% 每日累计充值
progress_value_admin_sys_activity(Status, 14) ->
    #player_status{recharge_accum_day = RechargeAccumDay} = Status2 = player:refresh_recharge_accum_day_data(Status),
    L =
        case RechargeAccumDay#r_accum_day.num > 0 of
            ?true ->
                [{14, RechargeAccumDay#r_accum_day.num, RechargeAccumDay#r_accum_day.reward_yet}];
            ?false ->
                []
        end,
    {Status2, L};

progress_value_admin_sys_activity(Status, _) ->
    {Status, []}.


%% 通知活动当前值
notify_value_admin_sys_activity_all(PS, []) ->
    ok;
notify_value_admin_sys_activity_all(PS, ActIds) ->
    {PS2, ActIdValueL} =
        lists:foldl(fun(ActId, {PsAcc, Acc}) ->
            {PsAcc2, Acc2}= progress_value_admin_sys_activity(PsAcc, ActId),
            {PsAcc2, Acc ++ Acc2}
                    end, {PS, []}, ActIds),
%% 	?ERROR_MSG("~n~n~nActIdValueL : ~p~n~n", [{ActIds,ActIdValueL}]),
    notify_value_admin_sys_activity(PS2, ActIdValueL),
    player_syn:update_PS_to_ets(PS2),
    ok.

notify_value_admin_sys_activity(_PS, []) ->
    ok;
notify_value_admin_sys_activity(PS, ActIdValueL) ->
    {ok, BinData} = pt_31:write(31064, [ActIdValueL]),
    ?INFO_MSG("~n~n~nActIdValueL : ~p~n~n~n", [{ActIdValueL, BinData}]),
    lib_send:send_to_sock(PS, BinData).


pack_sys_activity_content(Activity) ->
    Content =
        case erlang:is_tuple(Activity#admin_sys_activity.content) of
            true ->
                erlang:tuple_to_list(Activity#admin_sys_activity.content);
            false ->
                Activity#admin_sys_activity.content
        end,
    RewardDatas =
        case lists:filter(fun(Term) ->
            erlang:is_list(Term)
                          end, Content) of
            [] ->
                [];
            [Content2|_] ->
                admin_sys_activity_content(Content2)
        end,
    RewardDatas1 =
        case Activity#admin_sys_activity.sys =:= 15 of
            true ->
                [];
            false ->
                RewardDatas
        end,

    MimiDatas =
        case Activity#admin_sys_activity.content of
            {1066, _Title, _Cont, _Gifts} ->
                DataJson = db:select_one(admin_sys_activity, "origin_content", [{order_id, Activity#admin_sys_activity.order_id}]),
                {ok, DataJsonResult, _}= rfc4627:decode(DataJson),
                AttachJson = find("attach", DataJsonResult),
                {ok, [AttachJson2Result], _} = rfc4627:decode(AttachJson), %[[josn]] util:bitstring_to_term(<<"[[1]]">>).
                F = fun (X, Acc) ->
                    Integral = util:bitstring_to_term( find("integral", X) ),
                    RankTuple = util:bitstring_to_term( find("rank", X) ),
                    [{RankTuple,Integral}|Acc]
                    end,
                OriginMiminun = lists:foldl(F, [], AttachJson2Result),
                %%排序一下
                lists:sort(fun(A,B) ->
                    A > B
                           end, OriginMiminun);
            _ ->
                []
        end,

    %%这里因为土豪榜的原因需要从另外个字段读取最低限制，暂时将其他活动都默认为0 wjc2019/8/22
    %%{Args1, Args2, GoodsList}  {GoodsNo, _IsBind, Num}   {GoodsNo, _IsBind, Num}
    RewardDatas2 = lists:foldl(fun({Args1, Args2, GoodsList},BinAcc) ->
        Miminum =case  lists:keyfind({Args1, Args2} ,1 ,MimiDatas) of
                     false -> 0;
                     {_,MimiValue} -> MimiValue
                 end,
        NewGoodsList = lists:foldl(fun({GoodsNo, IsBind, Num},BinAcc2) ->
            [{GoodsNo, IsBind, Num,Miminum } |BinAcc2];
            ({GoodsNo, Num}, BinInsideAcc) ->
                [{GoodsNo, Num,Miminum}| BinInsideAcc]
                                   end,[] ,GoodsList
        ),
        [{Args1, Args2, NewGoodsList}|BinAcc]
                               end,[], RewardDatas1
    ),

    ?DEBUG_MSG("------------ RewardDatas1 -----------~p~n",[RewardDatas1]),
    {ok, BinData} = pt_31:write(31061, [Activity#admin_sys_activity.order_id, Activity#admin_sys_activity.show_panel, RewardDatas2]),
    BinData.

find(Key, {obj, List}) ->
    {_, Val} = lists:keyfind(Key, 1, List),
    Val.

admin_sys_activity_content([{_, GoodsList}|_] = Rewards) when erlang:is_list(GoodsList) ->
    lists:foldl(fun({{Arg1, Arg2}, GoodsL}, Acc) ->
        [{Arg1, Arg2, GoodsL}|Acc];
        ({Target, GoodsL}, Acc) ->
            [{Target, 0, GoodsL}|Acc]
                end, [], Rewards);

admin_sys_activity_content([{_GoodsNo, _IsBind, Num}|_] = Rewards) when erlang:is_integer(Num) ->
    lists:foldl(fun({GoodsNo2, IsBind2, Num2}, Acc) ->
        [{0, 0, [{GoodsNo2, IsBind2, Num2}]}|Acc]
                end, [], Rewards);

admin_sys_activity_content([{_Num, _ValidTimes, GoodsList}|_] = Rewards) when erlang:is_list(GoodsList) ->
    lists:foldl(fun({{Arg1, Arg2}, _ValidTimes, GoodsL}, Acc) ->
        [{Arg1, Arg2, GoodsL}|Acc];
        ({Target, _ValidTimes, GoodsL}, Acc) ->
            [{Target, 0, GoodsL}|Acc]
                end, [], Rewards);

admin_sys_activity_content([]) ->
    [];

admin_sys_activity_content(Rewards) ->
    ?ERROR_MSG("Unknon Rewards : ~p~n", [Rewards]),
    [].





-define(BUFFER_TIME, 10).
check_update(OrderId, Timestamp) ->
    case ets:lookup(?ETS_ADMIN_SYS_ACTIVITY, OrderId) of
        [Activity] when is_record(Activity, admin_sys_activity) ->
            Now = util:unixtime(),
            case (Activity#admin_sys_activity.timestamp - ?BUFFER_TIME) > Now andalso (Timestamp - ?BUFFER_TIME) > Now of
                true -> true;
                false -> {false, 3}
            end;
        _ -> {false, 4}
    end.

check_delete(OrderId) ->
    case ets:lookup(?ETS_ADMIN_SYS_ACTIVITY, OrderId) of
        [Activity] when is_record(Activity, admin_sys_activity) ->
            Now = util:unixtime(),true;
        %% 暂时去掉时间判定，让后台删除活动
%%             case (Activity#admin_sys_activity.timestamp - ?BUFFER_TIME) > Now of
%%                 true -> true;
%%                 false -> {false, 3}
%%             end;
        _ -> {false, 4}
    end.



%% ================================================================
%% 节日活动
%% ================================================================

%% @doc 指定类型的节日活动是否存在
is_festival_activity_alive(No) ->
    % case ets:match_object(?ETS_ADMIN_FESTIVAL_ACTIVITY, #admin_festival_activity{no = No, _ = '_'}, 1) of
    %     '$end_of_table' -> false;
    %     _ -> true
    % end.
    case ets:lookup(?ETS_ADMIN_SYS_SET, No) of
        [Act | _] when is_record(Act, admin_sys_set) -> true;
        _ -> false
    end.


%% @doc 开服加载
load_admin_festival_activity() ->
    case db:select_all(admin_festival_activity, "order_id, no, start_timestamp, end_timestamp, content, type",
        [{end_timestamp, ">", (util:unixtime() + 5)}, {state, "<", 2}]) of
        [] -> skip;
        List when is_list(List) ->
            F = fun([OrderId, No, StartTime, EndTime, Content, Type]) ->
                add_festival_activity(OrderId, No, StartTime, EndTime, Type, Content)
                end,
            lists:foreach(F, List);
        _ -> erlang:error({?MODULE, load_admin_festival_activity})
    end,
    case db:select_all(admin_festival_activity, "order_id", [{end_timestamp, "<=", (util:unixtime() + 5)}, {state, "<", 2}]) of
        [] -> skip;
        PastList when is_list(PastList) ->
            lists:foreach(
                fun([PastOrderId]) ->
                    db:update(?DB_SYS, admin_festival_activity, [{state, 2}], [{order_id, PastOrderId}])
                end,
                PastList)
    end.


%% @doc 添加节日活动
add_db_festival_activity(TmpNo, StartTime, EndTime, Type, Content) ->
    No = ?BIN_PRED(Type =:= 0, ?AA_FESTIVAL_FATHER_ACT, TmpNo),
    % Content = util:bitstring_to_term(OriContent),
    try db:insert_get_id(admin_festival_activity, ["no", "start_timestamp", "end_timestamp", "content", "type", "state"],
        [No, StartTime, EndTime, Content, Type, 0]) of
        OrderId when is_integer(OrderId) ->
            Rd = add_festival_activity(OrderId, No, StartTime, EndTime, Type, Content),
            notify_client_update_festival(Rd, 1),
            Rd;
        _ -> error
    catch
        T:E -> ?ERROR_MSG("[mod_admin_activity] add_db_festival_activity error = ~p~n", [{T, E}])
    end.


%% @return #admin_festival_activity{}
add_festival_activity(OrderId, TmpNo, StartTime, EndTime, Type, Content) ->
    No = ?BIN_PRED(Type =:= 0, ?AA_FESTIVAL_FATHER_ACT, TmpNo),
    Festival =
        #admin_festival_activity{
            no = No
            ,order_id = OrderId
            ,start_time = StartTime
            ,end_time = EndTime
            ,type = Type
            ,content = Content
        },
    ets:insert(?ETS_ADMIN_FESTIVAL_ACTIVITY, Festival),
    Festival.


%% @doc 检查节日任务
%% @return : true | {false, ErrCode}
check_add_all_festival_activity([[?AA_FESTIVAL_FATHER_ACT, _, StartTime, EndTime, _] | _] = Activitys) when StartTime =< EndTime ->
    case util:unixtime() < StartTime of
        true -> check_add_all_festival_activity(Activitys, StartTime, EndTime);
        false -> {false, 6}
    end;
check_add_all_festival_activity(_) -> {false, 0}.


check_add_all_festival_activity([], _, _) -> true;
check_add_all_festival_activity([[Type, TmpNo, SubStartTime, SubEndTime, _Content] | Left], StartTime, EndTime) ->
    case Type =:= 0 of
        true ->
            No = ?AA_FESTIVAL_FATHER_ACT,
            case ets:match_object(?ETS_ADMIN_FESTIVAL_ACTIVITY, #admin_festival_activity{no = No, _ = '_'}, 1) of
                '$end_of_table' -> check_add_all_festival_activity(Left, StartTime, EndTime);
                _T -> ?LDS_DEBUG(check, [_T]), {false, 5}
            end;
        false ->
            case is_integer(TmpNo) andalso check_festival_no(TmpNo) of
                true ->
                    case SubStartTime >= StartTime andalso SubEndTime =< EndTime of
                        true ->
                            No = TmpNo,
                            SubFestList = ets:match_object(?ETS_ADMIN_FESTIVAL_ACTIVITY, #admin_festival_activity{no = No, _ = '_'}),
                            case check_festival_time(SubStartTime, SubEndTime, SubFestList) of
                                true -> check_add_all_festival_activity(Left, StartTime, EndTime);
                                false -> ?LDS_TRACE(1), {false, 6}
                            end;
                        false -> ?LDS_TRACE(2), {false, 6}
                    end;
                false -> {false, 2}
            end
    end.


check_update_festival(_, _, 0, _, _) -> {false, 7};
check_update_festival(OrderId, _No, _Type, StartTime, _EndTime) ->
    case ets:lookup(?ETS_ADMIN_FESTIVAL_ACTIVITY, OrderId) of
        [Festival | _] when is_record(Festival, admin_festival_activity) ->
            case Festival#admin_festival_activity.no =/= ?AA_FESTIVAL_FATHER_ACT  of
                true ->
                    Now = util:unixtime(),
                    case Now < Festival#admin_festival_activity.start_time of
                        true -> ?BIN_PRED(StartTime > Now, true, {false, 6});
                        false -> {false, 8}
                    end;
                false -> {false, 2}
            end;
        _ -> {false, 3}
    end.


% check_update_festival(_, _, 0, _, _) -> {false, 7};
% check_update_festival(OrderId, _No, _Type, StartTime, _EndTime) ->



%% @doc 删除节日活动
%% @return : true | {false, ErrCode}
delete_festival_activity(No, OrderId) ->
    % case ets:lookup(?ETS_ADMIN_FESTIVAL_ACTIVITY, OrderId) of
    %     [Festival] ->
    %         try db:update(admin_festival_activity, [{state, ?AA_OVERDUE}], [{order_id, Festival#admin_festival_activity.order_id}]) of
    %             _ -> ets:delete(?ETS_ADMIN_FESTIVAL_ACTIVITY, OrderId)
    %         catch
    %             T:E -> ?ERROR_MSG("[mod_admin_activity] delete_festival_activity error = ~p~n", [{T, E}]),
    %                     {false, 0}
    %         end;
    %     _ -> {false, 4}
    % end,
    try db:update(admin_festival_activity, [{state, ?AA_OVERDUE}], [{order_id, OrderId}]) of
        _ ->
            ets:delete(?ETS_ADMIN_FESTIVAL_ACTIVITY, OrderId),
            ets:delete(?ETS_ADMIN_SYS_SET, No),
            catch notify_client_update_festival(No, OrderId, 0),
            true
    catch
        T:E -> ?ERROR_MSG("[mod_admin_activity] delete_festival_activity error = ~p~n", [{T, E}]),
            {false, 0}
    end.



%% @doc 删除所有节日活动
%% @return : true | {false, ErrCode}
delete_all_festival_activity() ->
    case ets:tab2list(?ETS_ADMIN_FESTIVAL_ACTIVITY) of
        [] -> true;
        List when is_list(List) ->
            F = fun(Festival) when is_record(Festival, admin_festival_activity) ->
                catch db:update(admin_festival_activity, [{state, ?AA_OVERDUE}], [{order_id, Festival#admin_festival_activity.order_id}])
                end,
            lists:foreach(F, List),
            ets:delete_all_objects(?ETS_ADMIN_FESTIVAL_ACTIVITY),
            ets:delete_all_objects(?ETS_ADMIN_SYS_SET),
            [notify_client_update_festival(Festival, 0) || Festival <- List],
            true
    end.


%% @doc 单个添加节日活动
%% @return : true | {false, ErrCode}
single_add_festival_activity(_, 0, _, _, _) -> {false, 0};
single_add_festival_activity(No, Type, StartTime, EndTime, Content) when StartTime =< EndTime ->
    case check_festival_no(No) of
        true ->
            case ets:match_object(?ETS_ADMIN_FESTIVAL_ACTIVITY, #admin_festival_activity{no = ?AA_FESTIVAL_FATHER_ACT, _ = '_'}, 1) of
                {[Festival], _} when is_record(Festival, admin_festival_activity) ->
                    case StartTime >= Festival#admin_festival_activity.start_time andalso EndTime =< Festival#admin_festival_activity.end_time of
                        true ->
                            SubFestList = ets:match_object(?ETS_ADMIN_FESTIVAL_ACTIVITY, #admin_festival_activity{no = No, _ = '_'}),
                            case check_festival_time(StartTime, EndTime, SubFestList) of
                                true ->
                                    try db:insert_get_id(admin_festival_activity, ["no", "start_timestamp", "end_timestamp", "content", "type", "state"],
                                        [No, StartTime, EndTime, Content, Type, 0]) of
                                        OrderId when is_integer(OrderId) ->
                                            Rd = add_festival_activity(OrderId, No, StartTime, EndTime, Type, Content),
                                            notify_client_update_festival(Rd, 1),
                                            true;
                                        _ -> {false, 0}
                                    catch
                                        T:E -> ?ERROR_MSG("[mod_admin_activity] add_single_festival_activity error = ~p~n", [{T, E}]), {false, 0}
                                    end;
                                false -> {false, 6}
                            end;
                        false -> {false, 6}
                    end;
                _ -> {false, 4}
            end;
        false -> {false, 2}
    end;
single_add_festival_activity(_, _, _, _, _) -> {false, 6}.


check_festival_time(_, _, []) -> true;
check_festival_time(StartTime, EndTime, [Festival | Left]) when is_record(Festival, admin_festival_activity) ->
    case StartTime > Festival#admin_festival_activity.end_time orelse EndTime < Festival#admin_festival_activity.start_time of
        true -> check_festival_time(StartTime, EndTime, Left);
        false -> false
    end;
check_festival_time(_, _, _T) -> ?ASSERT(false, [_T]), false.


notify_client_update_festival(Festival, State) when is_record(Festival, admin_festival_activity) ->
    case lists:member(Festival#admin_festival_activity.no, get_show_festival_no()) of
        true ->
            {ok, BinData} = pt_31:write(31072, [Festival#admin_festival_activity.order_id, Festival#admin_festival_activity.no, State]),
            lists:foreach(fun(RoleId) -> lib_send:send_to_uid(RoleId, BinData) end, mod_svr_mgr:get_all_online_player_ids());
        _ -> skip
    end.

notify_client_update_festival(No, OrderId, State) ->
    case lists:member(No, get_show_festival_no()) of
        true ->
            {ok, BinData} = pt_31:write(31072, [OrderId, No, State]),
            lists:foreach(fun(RoleId) -> lib_send:send_to_uid(RoleId, BinData) end, mod_svr_mgr:get_all_online_player_ids());
        _ -> skip
    end.


fetch_festival_activity(Status) ->
    List = ets:tab2list(?ETS_ADMIN_FESTIVAL_ACTIVITY),
    % ?LDS_DEBUG(31070, List),
    {ok, BinData} = pt_31:write(31070,
        [[{Festival#admin_festival_activity.order_id, Festival#admin_festival_activity.no} ||
            Festival <- List, is_record(Festival, admin_festival_activity) andalso
                lists:member(Festival#admin_festival_activity.no, get_show_festival_no())]]),
    lib_send:send_to_uid(player:id(Status), BinData).


fetch_assign_festival_activity(Status, List) ->
    % ?LDS_DEBUG("!!!!!!", List),
    F = fun({OrderId, No}, Count) ->
        FestList = ets:lookup(?ETS_ADMIN_FESTIVAL_ACTIVITY, OrderId),
        Count ++ [{OrderId, No, Fest#admin_festival_activity.content} || Fest <- FestList, is_record(Fest, admin_festival_activity)]
        end,
    % ?LDS_DEBUG(fetch_assign_festival_activity, {List, lists:foldl(F, [], List)}),
    {ok, BinData} = pt_31:write(31071, [lists:foldl(F, [], List)]),
    lib_send:send_to_uid(player:id(Status), BinData).



%% @doc 检查节日任务开启
check_open_festival(Timestamp) ->
    List = ets:tab2list(?ETS_ADMIN_FESTIVAL_ACTIVITY),
    check_open_festival_1(Timestamp, List).

check_open_festival_1(_, []) -> skip;
check_open_festival_1(Timestamp, [Festival | Left]) when is_record(Festival, admin_festival_activity) ->
    case Festival#admin_festival_activity.start_time =< Timestamp of
        true ->
            case Festival#admin_festival_activity.state =:= 1 of
                true ->
                    case Timestamp < Festival#admin_festival_activity.end_time of
                        true -> skip;
                        false ->
                            delete_festival_activity(Festival#admin_festival_activity.no, Festival#admin_festival_activity.order_id),
                            festival_activity_end(Festival#admin_festival_activity.no, Festival)
                    end;
                false ->
                    update_festival_activity(Festival, 1),
                    festival_activity_open(Festival)
            end;
        false -> skip
    end,
    check_open_festival_1(Timestamp, Left);
check_open_festival_1(Timestamp, [_ | Left]) -> check_open_festival_1(Timestamp, Left).


update_festival_activity(Festival, State) ->
    ets:insert(?ETS_ADMIN_FESTIVAL_ACTIVITY, Festival#admin_festival_activity{state = State}),
    db:update(?DB_SYS, admin_festival_activity, [{state, State}], [{order_id, Festival#admin_festival_activity.order_id}]).


festival_activity_open(Festival) ->
    No = Festival#admin_festival_activity.no,
    StartTime = Festival#admin_festival_activity.start_time,
    EndTime = Festival#admin_festival_activity.end_time,

    ets:insert(?ETS_ADMIN_SYS_SET, #admin_sys_set{no = No, script = [], start_time = StartTime, end_time = EndTime}),

    case lists:member(No, get_script_festival_nos()) of
        true -> gen_server:cast(mod_activity, {action_script, fun action_festival_script/1, [No]});
        false ->
            festival_activity_start(No, Festival)
    end.


action_festival_script([No]) ->
    case get_festival_config_data(No) of
        null -> skip;
        ConfigData -> mod_activity:exec_script(ConfigData#festival_activity_data.script)
    end.


-define(SNOW_MAN, 15).
-define(HORSE_RACE, 14).

festival_activity_start(?SNOW_MAN, Festival) ->
    ?LDS_DEBUG(festival_activity_start, ?SNOW_MAN),
    mod_global_collection:open_snowman_activity(Festival#admin_festival_activity.start_time, Festival#admin_festival_activity.end_time);

festival_activity_start(?HORSE_RACE, _Festival) ->
    ?LDS_DEBUG(festival_activity_start, ?HORSE_RACE),
    mod_horse_race:horse_race_open(1, []);

festival_activity_start(_, _) -> skip.




festival_activity_end(?SNOW_MAN, _Festival) ->
    mod_global_collection:close_snowman_activity();

festival_activity_end(14, _Festival) ->
    mod_horse_race:horse_race_close(1, []);

festival_activity_end(_, _) -> skip.


%% @doc 取得节日活动配置表有脚本执行的编号列表
%% @return : list()
get_script_festival_nos() ->
    data_festival_activity:get_script_nos().


%% @doc 取得节日活动配置表数据
%% @return : #festival_activity_data{} | null
get_festival_config_data(No) ->
    case data_festival_activity:get(No) of
        Data when is_record(Data, festival_activity_data) -> Data;
        _ -> null
    end.


get_show_festival_no() ->
    [?AA_FESTIVAL_FATHER_ACT | data_festival_activity:get_show_nos()].


%% @doc 取得节日活动对系统操作脚本数据
%% @return : null | script::term
get_admin_sys_set(No) ->
    case ets:lookup(?ETS_ADMIN_SYS_SET, No) of
        [SysSet] when is_record(SysSet, admin_sys_set) -> SysSet#admin_sys_set.script;
        _ -> null
    end.


%% return null | admin_sys_set 结构体
get_admin_set_rd(No) ->
    case ets:lookup(?ETS_ADMIN_SYS_SET, No) of
        [SysSet] when is_record(SysSet, admin_sys_set) -> SysSet;
        _ -> null
    end.

%% 指定编号的节日活动是否开启
%% @return : boolean()
is_festival_act_alive(No) ->
    case get_admin_sys_set(No) of
        null -> false;
        _ -> true
    end.


%% @doc 检查节日活动编号
%% @return : boolean()
check_festival_no(No) ->
    lists:member(No, data_festival_activity:get_nos()).


%% 为某个活动执行脚本：使用场景如：每天按一定的时间规律刷npc或者怪物，持续n天
exec_script_for_act(No) ->
    case lists:member(No, get_script_festival_nos()) of
        true -> gen_server:cast(mod_activity, {action_script, fun action_festival_script/1, [No]});
        false -> skip
    end.

tst_add_fes_act(No, StartTime, EndTime) ->
    ets:insert(?ETS_ADMIN_SYS_SET, #admin_sys_set{no = No, script = [], start_time = StartTime, end_time = EndTime}).