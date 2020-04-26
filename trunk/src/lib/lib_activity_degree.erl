%%%-----------------------------------
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2014.2
%%% @Description: 玩家活跃度
%%%-----------------------------------

-module(lib_activity_degree).

-compile(export_all).

-include("common.hrl").
-include("record.hrl").
-include("activity_degree.hrl").
-include("activity_degree_sys.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("player.hrl").
-include("ets_name.hrl").

-define(DEGREE_ACTIVITY_TYPE, 12).

-define(ACTIVITY_SYS_TIMES_TASK, [?AD_MON_SIEGE, 
								  ?AD_EXP_MON, 
								  ?AD_PAR_EXP, 
								  ?AD_TIMING_BOSS, 
								  ?AD_MON_SIEGE2, 
								  ?AD_MON_SIEGE3, 
								  ?AD_MON_SIEGE4, 
								  ?AD_MON_SIEGE5, 
								  ?AD_MON_SIEGE6, 
								  ?AD_MON_SIEGE7, 
								  ?AD_MON_SIEGE8]).    %% 活动是任务相关的次数

%% ==================================================
%% function
%% ==================================================

%% 凌晨通知在线玩家刷新列表
notify_refresh(Status) ->
    pp_activity_degree:handle(58001, Status, []).


%% @doc 取得某一系统活跃点数
get_sys_point(Sys) ->
    get_sys_activity_times(Sys) * get_point_by_sys(Sys).


%% @doc 取得系统活跃度信息
get_activity_info(Status) ->
    % ?LDS_TRACE("!!!!!!!!!!! 1"),
    check_refresh(),
    SysList = get_activity_sys_list(),
    % ?LDS_TRACE("!!!!!!!!!!! 2"),
    % [{Sys, get_sys_activity_times(Sys)} || Sys <- SysList].
    [{Sys, get_sys_activity_times(Sys), publ_get_sys_actual_times(Sys, util:unixtime(), Status), 
     publ_get_sys_max_actual_times(Sys, Status), get_activity_alive_info(Sys, Status)} || Sys <- SysList].


get_activity_alive_info(Sys, Status) ->
    case lists:member(Sys, mod_activity:get_activity_list()) of
        false -> 0;
        true -> ?BIN_PRED(mod_activity:login_check_activity_open__(Sys, Status), 1, 0)
    end.


%% @doc 取得奖励信息
get_reward_info(Status) ->
    check_refresh(),
    get_activity_reward_history(Status).


%% @doc 获取对应奖励  lib_reward:give_reward_to_player(player:get_PS(1000100000000334), 90043, [?LOG_AD, "prize"]).
%% @return boolean()
get_reward(RewardIndex, Status) ->
    case check_reward(RewardIndex, Status) of
        {true, Rid} -> 
            % Rid = data_activity_degree:get_reward(RewardIndex),
            case lib_reward:check_bag_space(Status, Rid) of
                ok -> 
                    add_reward_in_history(RewardIndex),
                    update_db(player:id(Status)),
                    lib_reward:give_reward_to_player(Status, Rid, [?LOG_AD, "prize"]),
                    true;
                {fail, Reason} -> 
                    lib_send:send_prompt_msg(Status, Reason),
                    false
            end;
        false -> 
            lib_send:send_prompt_msg(Status, ?PM_AD_REPEAT_GET),
            false
    end.




%% @doc 重置系统活跃度信息
% publ_reset_activity_degree(Status) ->
%     Timestamp = util:unixtime(),
%     DeviationStamp = calendar:time_to_seconds(time()),
%     case DeviationStamp =< ?DEVIATION_TIME of
%         true -> gen_server:cast(player:get_pid(Status), ?MODULE, reset_activity_degree, [Timestamp]);
%         false -> gen_server:cast(player:get_pid(Status), ?MODULE, reset_activity_degree, [Timestamp + ?DEVIATION_TIME])
%     end.

reset_activity_degree(Daystamp) -> 
    SysList = get_activity_sys_list(),
    [reset_sys_activity_times(Sys) || Sys <- SysList],    % 重置各个系统活跃次数
    RewardList = [{Index, ?AP_NO_GET_REWARD} || Index <- get_reward_index_list()],
    set_activity_degree(#activity_degree{daystamp = Daystamp, reward_list = RewardList}).


%% @doc 检查是否需要刷新
%% @return boolean()
check_refresh() ->
    NowDaystamp = util:get_now_days(),
    OldDaystamp = get_activity_stamp(),
    ?BIN_PRED(NowDaystamp =:= OldDaystamp, skip, reset_activity_degree(NowDaystamp)).


%% @doc 检查奖励能否获取
%% @return false | {true, RewardId}
check_reward(RewardIndex, Status) ->
    case get_activity_reward_history(Status) of
        [] -> false;
        List -> 
            case lists:keyfind(RewardIndex, 1, List) of
                false -> ?ASSERT(false, [RewardIndex]), false;
                {_, RewardId, Reward_need_point, State} ->
                    % ?LDS_TRACE([RewardId, Reward_need_point, State]), 
                    case State =:= ?AP_NO_GET_REWARD andalso get_activity_degree_point() >= Reward_need_point of
                        true -> {true, RewardId};
                        false -> false
                    end
            end
    end.


login(RoleId, role_in_cache) ->
    case ets:lookup(?ETS_ACTIVITY_DEGREE_TMP_CACHE, RoleId) of
        [] -> 
            ?ASSERT(false, [RoleId]),
            login(RoleId, not_in_cache);
            % reset_activity_degree(util:get_now_days()),
            % save(RoleId);
        [{RoleId, Rd, SysInfo}] when is_record(Rd, activity_degree) ->
            Daystamp = Rd#activity_degree.daystamp, 
            RewardList = Rd#activity_degree.reward_list,
            NowDay = util:get_now_days(),
            case Daystamp =:= NowDay of
                true -> 
                    analy_sys_info(SysInfo),
                    check_new_ad_sys(),
                    set_activity_degree(#activity_degree{daystamp = Daystamp, reward_list = RewardList});
                false ->
                    reset_activity_degree(NowDay)
            end,
            ets:delete(?ETS_ACTIVITY_DEGREE_TMP_CACHE, RoleId)
    end;
    


login(RoleId, _) ->
    case db:select_row(activity_degree, "daystamp, reward_list, sys_info", [{id, RoleId}]) of
        [] -> 
            reset_activity_degree(util:get_now_days()),
            save(RoleId);
        [Daystamp, RewardList, SysInfo] ->
            NowDay = util:get_now_days(),
            case Daystamp =:= NowDay of
                true -> 
                    List = util:bitstring_to_term(SysInfo), 
                    analy_sys_info(List),
                    check_new_ad_sys(),
                    set_activity_degree(#activity_degree{daystamp = Daystamp, reward_list = util:bitstring_to_term(RewardList)});
                false ->
                    reset_activity_degree(NowDay)
            end;
        Err -> 
            ?ERROR_MSG("load activity_degree RoleId = ~p error = ~p~n", [RoleId, Err]),
            ?ASSERT(false, [RoleId, Err])
    end.


tmp_logout(RoleId) ->
    case get_activity_degree() of
        null -> skip;
        Rd -> 
            SysInfo = pack_sys_info(),
            ets:insert(?ETS_ACTIVITY_DEGREE_TMP_CACHE, {RoleId, Rd, SysInfo})
    end.

final_logout(RoleId) ->
    case ets:lookup(?ETS_ACTIVITY_DEGREE_TMP_CACHE, RoleId) of
        [] -> skip;
        [{RoleId, Rd, SysInfo}] when is_record(Rd, activity_degree) ->
            % mod_lgout_svr:common_handle(RoleId, db, update, [activity_degree, 
            %     [{daystamp, Rd#activity_degree.daystamp}, 
            %      {reward_list, util:term_to_bitstring(Rd#activity_degree.reward_list)},
            %      {sys_info, util:term_to_bitstring(SysInfo)}], 
            %      [{id, RoleId}]]),
            db:update(RoleId, activity_degree, 
                [{daystamp, Rd#activity_degree.daystamp}, 
                 {reward_list, util:term_to_bitstring(Rd#activity_degree.reward_list)},
                 {sys_info, util:term_to_bitstring(SysInfo)}], 
                 [{id, RoleId}]),
            ets:delete(?ETS_ACTIVITY_DEGREE_TMP_CACHE, RoleId)
    end.


logout(RoleId) ->
    % update_db(RoleId).
    case get_activity_degree() of
        null -> skip;
        Rd -> 
            SysInfo = pack_sys_info(),
            % mod_lgout_svr:common_handle(RoleId, db, update, [activity_degree, 
            %     [{daystamp, Rd#activity_degree.daystamp}, 
            %      {reward_list, util:term_to_bitstring(Rd#activity_degree.reward_list)},
            %      {sys_info, util:term_to_bitstring(SysInfo)}], 
            %      [{id, RoleId}]])
            db:update(RoleId, activity_degree, 
                [{daystamp, Rd#activity_degree.daystamp}, 
                 {reward_list, util:term_to_bitstring(Rd#activity_degree.reward_list)},
                 {sys_info, util:term_to_bitstring(SysInfo)}], 
                 [{id, RoleId}])
    end.



update_db(RoleId) ->
    case get_activity_degree() of
        null -> skip;
        Rd -> 
            SysInfo = pack_sys_info(),
            db:update(RoleId, activity_degree, 
                [{daystamp, Rd#activity_degree.daystamp}, 
                 {reward_list, util:term_to_bitstring(Rd#activity_degree.reward_list)},
                 {sys_info, util:term_to_bitstring(SysInfo)}], 
                 [{id, RoleId}])
    end.

save(RoleId) ->
    case get_activity_degree() of
        null -> skip;
        Rd -> 
            SysInfo = pack_sys_info(),
            db:insert(RoleId, activity_degree, 
                [{daystamp, Rd#activity_degree.daystamp}, 
                 {reward_list, util:term_to_bitstring(Rd#activity_degree.reward_list)},
                 {sys_info, util:term_to_bitstring(SysInfo)}, 
                 {id, RoleId}])
    end.
    

%% @doc 把系统活跃度信息打包成列表
%% @return list()
pack_sys_info() ->
    SysList = get_activity_sys_list(),
    [{Sys, get_sys_activity_times(Sys)} || Sys <- SysList].

%% @doc 解析系统活跃度列表并存储
analy_sys_info([]) -> skip;
analy_sys_info([{Sys, Times} | Left]) ->
    case lists:member(Sys, get_activity_sys_list()) of
        true -> set_sys_activity_times(Sys, Times);
        false -> skip
    end,
    analy_sys_info(Left).
    
check_new_ad_sys() ->
    NewList = get_activity_sys_list(),
    [set_sys_activity_times(Sys, 0) || Sys <- NewList, (not is_exists_sys_activity(Sys))].

%% ==================================================
%% data
%% ==================================================

%% @doc 取得活跃度记录体
%% @return null | #activity_degree{}
get_activity_degree() ->
    case get(?AP_ACTIVITY_DEGREE) of
        Rd when is_record(Rd, activity_degree) -> Rd;
        _ -> null
    end.


%% @doc 取得活跃度日期戳
%% @return 0 | integer()
get_activity_stamp() ->
    case get_activity_degree() of
        Rd when is_record(Rd, activity_degree) -> Rd#activity_degree.daystamp;
        _ -> ?ASSERT(false), 0
    end.


%% @doc 取得活跃度点数
get_activity_degree_point() ->
    SysList = get_activity_sys_list(),
    get_activity_degree_point(SysList, 0).

get_activity_degree_point([], Sum) -> Sum;
get_activity_degree_point([Sys | Left], Sum) ->
    get_activity_degree_point(Left, (Sum + get_sys_activity_times(Sys) * get_point_by_sys(Sys))).


%% @doc 取得活跃度奖励信息
%% @return [] | [{Index, rewardId, reward_need_point, state}]
get_activity_reward_history(Status) ->
    case get_activity_degree() of
        Rd when is_record(Rd, activity_degree) -> 
            List = Rd#activity_degree.reward_list,
            [{Index, get_reward_id(Index, player:get_lv(Status)), get_need_point(Index), State} || {Index, State} <- List];
        _ -> ?ASSERT(false), []
    end.


%% @取得玩家对应的奖励ID
%% @return 0 | Rid
get_reward_id(Index, Lv) ->
    LvList = data_activity_degree:get_reward_lv_list(),
    case get_lv_gap(LvList, Lv) of
        null -> 0;
        LvGap -> data_activity_degree:get(Index, LvGap)
    end.

get_lv_gap([], _Lv) -> null;
get_lv_gap([{LvDown, LvUp} | Left], Lv) ->
    case Lv >= LvDown andalso Lv =< LvUp of
        true -> {LvDown, LvUp};
        false -> get_lv_gap(Left, Lv)
    end.


%% @doc 添加奖励记录到奖励信息中
add_reward_in_history(RewardIndex) ->
    case get_activity_degree() of
        Rd when is_record(Rd, activity_degree) -> 
            OldHistory = Rd#activity_degree.reward_list,
            case lists:keyfind(RewardIndex, 1, OldHistory) of
                false -> ?ASSERT(false, [RewardIndex]);
                {_, _State} -> 
                    NewList = lists:keyreplace(RewardIndex, 1, OldHistory, {RewardIndex, ?AP_HAD_GET_REWARD}),
                    set_activity_degree(Rd#activity_degree{reward_list = NewList})
            end;
        _ -> ?ASSERT(false), error
    end.


%% @doc 设置系统活跃度记录体
set_activity_degree(Ad) when is_record(Ad, activity_degree) ->
    put(?AP_ACTIVITY_DEGREE, Ad);
set_activity_degree(_Arg) ->
    ?ASSERT(false, [_Arg]),
    error.


%% @doc 取得系统对应的每次活跃次数对应的活跃值
get_point_by_sys(Sys) ->
    data_activity_degree:get_sys_max_point(Sys).


%% @doc 取得系统列表
get_activity_sys_list() ->
    data_activity_degree:get_sys_list().


%% @doc 取得奖励位置列表
get_reward_index_list() ->
    data_activity_degree:get_reward_index_list().

%% @doc 取得系统活跃最大次数
get_sys_max_times(Sys) ->
    data_activity_degree:get_sys_max_times(Sys).


%% @doc 取得每个奖励对应的活跃点
get_need_point(Index) ->
    List = data_activity_degree:get_need_point_list(),
    case lists:keyfind(Index, 1, List) of
        false -> ?ASSERT(false), 0;
        {_, Point} -> Point
    end.

%% @doc 取得某系统活跃次数
%% @return integer()
get_sys_activity_times(Sys) ->
    case get(?AP_SYS_NAME(Sys)) of
        undefined -> 0;
        Val when is_integer(Val) -> Val;
        _Arg -> ?ASSERT(false, [Sys, _Arg]), 0
    end. 

%% @doc 判断是否存在系统活跃度
%% @return boolean()
is_exists_sys_activity(Sys) ->
    case get(?AP_SYS_NAME(Sys)) of
        undefined -> false;
        _ -> true
    end.

%% @doc 添加系统活跃次数
publ_add_sys_activity_times(Sys, Status) ->
    publ_add_sys_activity_times(Sys, 1, Status).

publ_add_sys_activity_times(_, Num, _) when Num =< 0 -> ok;
publ_add_sys_activity_times(Sys, Num, Status) when Num > 0 ->
    gen_server:cast(player:get_pid(Status), {apply_cast, ?MODULE, add_sys_activity_times, [Sys, Num, player:id(Status)]}).
    % publ_add_sys_activity_times(Sys, Num - 1, Status).


%% 活动任务相关活跃次数
add_sys_times_activity_task(TaskId, Status) ->
	Fun = fun(Sys) ->
				  case data_activity_degree:get_mark_data(Sys) of
					  MarkDatas when is_list(MarkDatas) ->
						  case lists:member(TaskId, MarkDatas) of
							  true -> publ_add_sys_activity_times(Sys, Status);
							  false ->
								  skip
						  end;
					  _ ->
						  skip
				  end
		  end,
	%% 考虑到暂时没有非任务的其他情况，先统一默认mark_data字段填的都是任务id吧，方便策划配新活动，有其他情况的时候再扩展
	SysList = data_activity_degree:get_sys_list(),
	lists:foreach(Fun, SysList).
%% 	lists:foreach(Fun, ?ACTIVITY_SYS_TIMES_TASK).
%%     case lists:member(TaskId, data_activity_degree:get_mark_data(?AD_MON_SIEGE)) of
%%         true -> publ_add_sys_activity_times(?AD_MON_SIEGE, Status);
%%         false -> 
%%             case lists:member(TaskId, data_activity_degree:get_mark_data(?AD_EXP_MON)) of
%%                 true -> publ_add_sys_activity_times(?AD_EXP_MON, Status);
%%                 false -> 
%%                     case lists:member(TaskId, data_activity_degree:get_mark_data(?AD_PAR_EXP)) of
%%                         true -> publ_add_sys_activity_times(?AD_PAR_EXP, Status);
%%                         false -> skip
%%                     end
%%             end
%%     end.


%% 必须玩家进程执行！
%% @return ok | error
add_sys_activity_times(Sys, Num, RoleId) when is_integer(Num) andalso Num > 0 ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) ->
            check_refresh(),
            SysTimes = get_sys_activity_times(Sys),
            TotalNum = SysTimes + Num,
            MaxNum = get_sys_max_times(Sys),
            FitNum = ?BIN_PRED(TotalNum > MaxNum, MaxNum, TotalNum),
            case SysTimes >= MaxNum of
                true -> 
                    notify_client_get_reward(Sys, MaxNum, publ_get_sys_actual_times(Sys, util:unixtime(), Status), RoleId);
                false -> 
                    Point = get_point_by_sys(Sys) * Num,
                    ply_tips:send_sys_tips(RoleId, {add_activity_times, [Point]}),
                    set_sys_activity_times(Sys, FitNum),
                    lib_jingyan:update_times(Sys, FitNum),
                    %% 统计活跃度
                    lib_log:statis_activity_degree(Status, Point),
                    notify_client_get_reward(Sys, FitNum, publ_get_sys_actual_times(Sys, util:unixtime(), Status), RoleId),
                    case send_admin_activity_reward(Status) of
                        NewStatus when is_record(NewStatus, player_status) ->
                            player_syn:update_PS_to_ets(NewStatus);
                        _ -> skip
                    end
            end,
            ok;
        _ -> skip
    end;
add_sys_activity_times(_, _, _) -> ?ASSERT(false), error.


notify_client_get_reward(Sys, TotalNum, CurTimes, RoleId) ->
    {ok, BinData} = pt_58:write(58004, [Sys, TotalNum, CurTimes]),
    lib_send:send_to_uid(RoleId, BinData).


%% @return : ok | NewPlayerStatus
send_admin_activity_reward(Status) ->
    Now = util:unixtime(),
    case mod_svr_mgr:check_role_admin_activity_open(?DEGREE_ACTIVITY_TYPE, Now) of
        {true, Activity} when is_record(Activity, admin_activity_query) ->
            {Title, MailContent, RankList} = Activity#admin_activity_query.content,
            SysList = get_activity_sys_list(),
            NowPoints = lists:foldl(
                fun(Sys, Count) -> get_sys_point(Sys) + Count end, 
                0,
                SysList),
            ?LDS_TRACE("AD Points", NowPoints),
            send_reward_by_rank(Status, NowPoints, RankList, Title, MailContent, 
                ?DEGREE_ACTIVITY_TYPE, Activity#admin_activity_query.start_time, Now);
        _ -> ok
    end.


%% @return : NewStatus
send_reward_by_rank(Status, Points, RankList, Title, MailContent, ActType, Flag, Now) ->
    StateList = Status#player_status.admin_acitvity_state,
    {PrePoints, NewStatus} = case lists:keyfind(ActType, 1, StateList) of
        {ActType, AccNum, Timestamp, Flag} -> 
            NewAccNum = ?BIN_PRED(util:is_timestamp_same_day(Timestamp, Now), AccNum, 0),
            {NewAccNum, Status#player_status{admin_acitvity_state = 
                lists:keyreplace(ActType, 1, StateList, {ActType, Points, Now, Flag})}};
        {ActType, _, _, _} -> 
            {0, Status#player_status{admin_acitvity_state = 
                lists:keyreplace(ActType, 1, StateList, {ActType, Points, Now, Flag})}};
        _ -> 
            {0, Status#player_status{admin_acitvity_state = [{ActType, Points, Now, Flag} | StateList]}}
    end,
    SendList = select_rank_list(PrePoints, Points, RankList),
    send_reward_by_rank(Status, Title, MailContent, SendList),
    NewStatus.


%% @List :: [{_, _} | _]
%% @return : NewList
select_rank_list(Min, Max, List) when Min =< Max ->
    select_right_rank(Max, select_left_rank(Min, List));
select_rank_list(_, _, _) -> [].

select_left_rank(_Min, []) -> [];
select_left_rank(Min, [{Num, _} | Left] = List) ->
    case Min >= Num of
        true -> select_left_rank(Min, Left);
        false -> List
    end.

select_right_rank(_Max, []) -> [];
select_right_rank(Max, [{Num, Elm} | Left]) ->
    case Max >= Num of
        true -> [{Num, Elm} | select_right_rank(Max, Left)];
        false -> []
    end.


send_reward_by_rank(_, _, _, []) -> skip;
send_reward_by_rank(Status, Title, Content, [{_Rank, GoodsList} | Left]) ->
    lib_mail:send_sys_mail(player:id(Status), Title, Content, GoodsList, [?LOG_MAIL, "recv_paybag"]),
    send_reward_by_rank(Status, Title, Content, Left).


% add_activity_point(Point) ->
%     case get_activity_degree() of
%         Rd when is_record(Rd, activity_degree) -> 
%             set_activity_degree(Rd#activity_degree{point = Rd#activity_degree.point + Point});
%         _ -> ?ASSERT(false), 0
%     end.


%% @doc 重置系统活跃度次数
%% @return void
reset_sys_activity_times(Sys) ->
    set_sys_activity_times(Sys, 0).


%% @doc 设置系统活跃度次数
%% @return void
set_sys_activity_times(Sys, Num) ->
    put(?AP_SYS_NAME(Sys), Num).


%% @doc 取得配置表系统实际当前次数
get_config_atcual_times(Sys) ->
    data_activity_degree:get_actual_times(Sys).


%% @doc 取得配置表系统实际最大次数
get_config_atcual_max_times(Sys) ->
    data_activity_degree:get_actual_max_times(Sys).


%% @doc 取得配置表次数相关数据
get_config_times_data(Sys) ->
    Data = data_activity_degree:get_times_data(Sys),
    Data.


%% @doc 取得系统实际参与次数
publ_get_sys_actual_times(Sys, Timestamp, Status) ->
    case get_config_atcual_times(Sys) of
        sys -> get_sys_actual_times(Sys, Timestamp, Status);
        ad -> get_sys_activity_times(Sys);
        Int when is_integer(Int) -> Int;
        _Other -> ?ASSERT(false, [_Other]), 0
    end.

-define(RING_TASK_SYS_LIST, [?AD_TASK_FACTION, ?AD_TASK_GHOST, ?AD_TASK_GUILD, ?AD_TASK_TREASURE_MAP, ?AD_MON_SIEGE6, ?AD_MON_SIEGE7, ?AD_MON_SIEGE8]).     % 环任务类型活动
-define(TASK_SYS_LIST, [?AD_TIMING_BOSS, ?AD_MON_SIEGE, ?AD_MON_SIEGE2, ?AD_MON_SIEGE3, ?AD_MON_SIEGE4, ?AD_MON_SIEGE5]).                                                                % 普通任务类型
-define(DUNGEON_SYS_LIST, [?AD_DUN_EQUIP, ?AD_DUN_PET]).                                                    % 副本类型活动

% 竞技场
get_sys_actual_times(?AD_DUN_ARENA, Timestamp, Status) ->
    lib_offline_arena:get_challenge_cur_times(Timestamp, Status);
% 答题
get_sys_actual_times(?AD_EXAM, _Timestamp, _Status) ->
    % ?LDS_TRACE(get_sys_actual_times, [get_sys_activity_times(?AD_EXAM)]),
    get_sys_activity_times(?AD_EXAM);
% 全民追女（巡游活动）
get_sys_actual_times(?AD_CRUISE, _Timestamp, Status) ->
    ply_cruise:get_already_join_times(Status);
% 运镖
get_sys_actual_times(?AD_TRANSPORT, _Timestamp, Status) ->
    lib_transport:get_already_join_times(Status);
% 环任务 / 普通任务 / 副本 / 未知类
get_sys_actual_times(Sys, Timestamp, Status) ->
    case lists:member(Sys, ?RING_TASK_SYS_LIST) of
        true -> lib_task:get_ring_task_cur_times(get_config_times_data(Sys), Timestamp, Status);
        false ->
            case lists:member(Sys, ?TASK_SYS_LIST) of
                true -> 
                    TaskId = case get_config_times_data(Sys) of
								 [TaskId0|_] ->
									 TaskId0;
								 TaskId0 when is_integer(TaskId0) ->
									 TaskId0;
								 _ ->
									 0
							 end,
                    lib_task:get_task_cur_times(TaskId, Timestamp, Status);
                false -> 
                    case lists:member(Sys, ?DUNGEON_SYS_LIST) of
                        true -> lib_dungeon:get_update_dungeon_used_times(Status, Timestamp, get_config_times_data(Sys));
                        false -> ?ASSERT(false), 0
                    end
            end
    end.


%% @doc 取得系统最大可参与次数
publ_get_sys_max_actual_times(Sys, Status) ->
    case get_config_atcual_max_times(Sys) of
        sys -> get_sys_max_actual_times(Sys, Status);
        Int when is_integer(Int) -> Int;
        _Other -> ?ASSERT(false, [_Other]), 0
    end.

% 竞技场
get_sys_max_actual_times(?AD_DUN_ARENA, Status) ->
    lib_offline_arena:get_max_challenge_times(Status);

% 全民追女（巡游活动）
get_sys_max_actual_times(?AD_CRUISE, _Status) ->
    ply_cruise:get_max_join_times_per_day();

% 运镖
get_sys_max_actual_times(?AD_TRANSPORT, Status) ->
    lib_transport:get_max_join_times(Status);

% 环任务 / 普通任务 / 副本 / 未知类
get_sys_max_actual_times(Sys, Status) ->
    case lists:member(Sys, ?RING_TASK_SYS_LIST) of
        true -> lib_task:get_ring_task_max_times(get_config_times_data(Sys), Status);
        false ->
            case lists:member(Sys, ?TASK_SYS_LIST) of
                true -> 
					TaskId = case get_config_times_data(Sys) of
								 [TaskId0|_] ->
									 TaskId0;
								 TaskId0 when is_integer(TaskId0) ->
									 TaskId0;
								 _ ->
									 0
							 end,
%%                     [TaskId] = get_config_times_data(Sys),
                    lib_task:get_task_max_times(TaskId, Status);
                false -> 
                    case lists:member(Sys, ?DUNGEON_SYS_LIST) of
                        true -> lib_dungeon:get_max_dun_times(Status, get_config_times_data(Sys));
                        false -> ?ASSERT(false), 0
                    end
            end
    end.


%% 根据任务id获取相应关联的活动Sys号(须是ad类型且任务id存在配置表mark_data字段里)
get_sys_by_task_id(TaskId) ->
	SysList = get_activity_sys_list(),
	get_sys_by_task_id(TaskId, SysList).


get_sys_by_task_id(TaskId, [Sys|List]) ->
	case get_config_atcual_times(Sys) of
		ad ->
			case get_config_times_data(Sys) of
				TaskIds when is_list(TaskIds) ->
					case lists:member(TaskId, TaskIds) of
						?true ->
							Sys;
						?false ->
							get_sys_by_task_id(TaskId, List)
					end;
				_ ->
					get_sys_by_task_id(TaskId, List)
			end;
		_ ->
			get_sys_by_task_id(TaskId, List)
	end;

get_sys_by_task_id(_TaskId, []) ->
	skip.
	
	

%% 检查活动是否还有可参与次数
%% 不关联的就让过
check_activity_degree_times_valid(_PS, 0) ->
	true;

check_activity_degree_times_valid(Status, Sys) ->
	MaxTimes = publ_get_sys_max_actual_times(Sys, Status),
	ActualTimes = publ_get_sys_actual_times(Sys, util:unixtime(), Status),
	%% io:format("?MODULE, ?LINE ~p~n", [{?MODULE, ?LINE, Sys, ActualTimes, MaxTimes}]),
	ActualTimes < MaxTimes.






