%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.11.28
%%% @doc 悬赏任务 函数库.
%%% @end
%%%------------------------------------

-module(lib_xs_task).

-include("common.hrl").
-include("record.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("goods.hrl").
-include("task.hrl").
-include("xs_task.hrl").
-include("activity_degree_sys.hrl").
-include("abbreviate.hrl").

-compile(export_all).
-export([]).


%%------------------------------------
%% 每日重置函数 (在玩家进程中执行)
%%------------------------------------
daily_reset(PS, LastTime) ->
    Days = max(util:get_differ_days_by_timestamp(util:unixtime(), LastTime), 1),
    OldLeftIssueNum = player:get_xs_task_left_issue_num(PS),
    NewLeftIssueNum = min(200, OldLeftIssueNum + (Days * data_xs_task:config(issue_num_per_day)) ),
    player:set_xs_task_left_issue_num(PS, NewLeftIssueNum),
    player:set_xs_task_issue_num(PS, 0),
    player:set_xs_task_receive_num(PS, 0),
    ok.

%%------------------------------------
%% 悬赏任务榜排序函数
%%------------------------------------
issue_task_sort_fun(A, B) ->
    if
        % 剩余时间排序
        A#issue_task.issue_time < B#issue_task.issue_time -> true;
        A#issue_task.issue_time > B#issue_task.issue_time -> false;
        % 剩余次数排序
        A#issue_task.issue_num > B#issue_task.issue_num -> true;
        A#issue_task.issue_num < B#issue_task.issue_num -> false;
        % 任务等级排序
        A#issue_task.issue_lv > B#issue_task.issue_lv -> true;
        A#issue_task.issue_lv < B#issue_task.issue_lv -> false;
        true -> false
    end.

%%------------------------------------
%% 发布悬赏任务
%%------------------------------------
% 检查发布
check_issue_task(PS, IssueNum) ->
    % 检查最低发布等级
    case player:get_lv(PS) < data_xs_task:config(issue_min_lv) of
        true -> {error, ?PM_XS_TASK_ERROR_ISSUE_LV_LIMIT};
        false ->
            % 检查剩余发布数
            case player:get_xs_task_left_issue_num(PS) < IssueNum of
                true -> {error, ?PM_XS_TASK_ERROR_ISSUE_NUM_LIMIT};
                false ->
                    % 检查消耗金子
                    BaseCost = data_xs_task:get_issue_cost(player:get_lv(PS)),
                    AlreadyIssueNum = player:get_xs_task_issue_num(PS),
                    CostYB = calc_issue_task_cost_yb(BaseCost, AlreadyIssueNum, IssueNum),
                    case player:has_enough_yuanbao(PS, CostYB) of
                        false -> {error, ?PM_XS_TASK_ERROR_ISSUE_MONEY_LIMIT};
                        true -> {ok, CostYB}
                    end
            end
    end.

% 计算消耗金子数
calc_issue_task_cost_yb(_BaseCost, AlreadyIssueNum, IssueNum) -> 
    calc_issue_task_cost_yb__(IssueNum, AlreadyIssueNum+1, 0).

calc_issue_task_cost_yb__(0, _N, Sum) -> Sum;
calc_issue_task_cost_yb__(IssueNum, N, Sum) ->
    calc_issue_task_cost_yb__(IssueNum-1, N+1, Sum + get_issue_one_cost(N)).
    

get_issue_one_cost(0) -> ?ASSERT(false),0;
% get_issue_one_cost(1) -> 5;
% get_issue_one_cost(2) -> 8;
get_issue_one_cost(N) when N =< 5 -> 4;
get_issue_one_cost(N) when N =< 10 -> 8;
get_issue_one_cost(N) when N =< 15 -> 12;
get_issue_one_cost(N) when N =< 20 -> 20;
get_issue_one_cost(N) when N =< 30 -> 25;
get_issue_one_cost(N) when N =< 200 -> 30;
% get_issue_one_cost(N) when N =< 100 -> 80;
% get_issue_one_cost(N) when N =< 200 -> 120;
get_issue_one_cost(_N) -> ?ASSERT(false, _N),0.



% 发布消耗
cost_issue_task(PS, IssueNum, CostYB) ->
    OldLeftIssueNum = player:get_xs_task_left_issue_num(PS),
    OldIssueNum = player:get_xs_task_issue_num(PS),
    % 消耗元宝
    player_syn:cost_money(PS, ?MNY_T_YUANBAO, CostYB, [?LOG_XS_TASK, "issue"]), 
    % 消耗发布次数
    player:set_xs_task_left_issue_num(PS, max(OldLeftIssueNum-IssueNum, 0)),
    player:set_xs_task_issue_num(PS, min(OldIssueNum+IssueNum, 200)),
    ok.

% 发布悬赏任务
issue_xs_task(PS, IssueNum, IsAnonymity) ->
    % 生成用户名
    RoleName = case IsAnonymity of
        1 -> <<"">>;
        _ -> player:get_name(PS)
    end,
    issue_xs_task__(player:id(PS), player:get_lv(PS), RoleName, IssueNum).

issue_xs_task__(Id, Lv, NickName, IssueNum) ->
    % 随机任务Id
    TaskList = data_xs_task:get_rand_task_list(Lv),
    {TaskNo, _} = util:rand_by_weight(TaskList, 2),
    % 构造数据
    IssueTask = #issue_task{role_id = Id
                           ,role_name = NickName
                           ,task_no = TaskNo
                           ,issue_lv = calc_issue_lv(Lv)
                           ,issue_num = IssueNum
                           ,issue_time = util:unixtime()
    },
    case Id == 0 of
        true -> 
            lib_log:statis_role_action(sys, [], "xs_task", "issue", 
                ["sys", "", "", IssueTask#issue_task.issue_lv, IssueTask#issue_task.task_no]);
        false -> 
            case player:get_PS(Id) of 
                PS when is_record(PS, player_status) ->
                    lib_log:statis_role_action(PS, [power,vip_lv], "xs_task", "issue", 
                        ["role", player:get_xs_task_issue_num(PS), player:get_xs_task_left_issue_num(PS), 
                        IssueTask#issue_task.issue_lv, IssueTask#issue_task.task_no]);
                _ -> skip
            end
    end,
    mod_xs_task:issue_task(IssueTask).

calc_issue_lv(Lv) ->
    (Lv div 10) * 10.

%%------------------------------------
%% 领取悬赏任务
%%------------------------------------
check_receive_task(PS, IssueId) ->
    % 检查身上是否有同类任务
    AcceptTaskIdList = lib_task:get_accepted_list(), 
    AcceptXSTaskIdList = [T || T<-AcceptTaskIdList, (data_task:get(T))#task.type=:=?TASK_XS_TASK_TYPE],
    case length(AcceptXSTaskIdList) of
        Len when Len>0 -> % 已经有接取悬赏任务
            {error, ?PM_XS_TASK_ERROR_HAS_XS_TASK};
        0 ->
            % 检查可领取次数
            case player:get_xs_task_receive_num(PS) >= data_xs_task:config(receive_num_per_day) of
                true -> {error, ?PM_XS_TASK_ERROR_RECEIVE_NUM_LIMIT};
                false -> 
                    MyPlayerId = player:id(PS),
                    case catch mod_xs_task:get_issue_task(IssueId) of
                        false ->
                            {error, ?PM_XS_TASK_ERROR_RECEIVE_NO_EXIST};
                        IssueTask when IssueTask#issue_task.role_id =:= MyPlayerId ->
                            {error, ?PM_XS_TASK_ERROR_RECEIVE_YOUR_TASK};
                        IssueTask when IssueTask#issue_task.issue_num =< 0 ->
                            {error, ?PM_XS_TASK_ERROR_RECEIVE_NO_EXIST};
                        IssueTask when is_record(IssueTask, issue_task) ->
                            TaskNo = IssueTask#issue_task.task_no,
                            case catch check_base_receive_task(PS, TaskNo) of
                                {error, ErrCode} -> {error, ErrCode};
                                ok -> {ok, TaskNo}
                            end;
                        _ -> 
                            {error, ?PM_XS_TASK_ERROR_SYS}
                    end
            end
    end.

do_check_receive_task(PS, IssueTask) ->
    % 检查身上是否有同类任务
    AcceptTaskIdList = lib_task:get_accepted_list(), 
    AcceptXSTaskIdList = [T || T<-AcceptTaskIdList, (data_task:get(T))#task.type=:=?TASK_XS_TASK_TYPE],
    case length(AcceptXSTaskIdList) of
        Len when Len>0 -> % 已经有接取悬赏任务
            {error, ?PM_XS_TASK_ERROR_HAS_XS_TASK};
        0 ->
            % 检查可领取次数
            case player:get_xs_task_receive_num(PS) >= data_xs_task:config(receive_num_per_day) of
                true -> {error, ?PM_XS_TASK_ERROR_RECEIVE_NUM_LIMIT};
                false -> 
                    MyPlayerId = player:id(PS),
                    case IssueTask of
                        false ->
                            {error, ?PM_XS_TASK_ERROR_RECEIVE_NO_EXIST};
                        IssueTask when IssueTask#issue_task.role_id =:= MyPlayerId ->
                            {error, ?PM_XS_TASK_ERROR_RECEIVE_YOUR_TASK};
                        IssueTask when IssueTask#issue_task.issue_num =< 0 ->
                            {error, ?PM_XS_TASK_ERROR_RECEIVE_NO_EXIST};
                        IssueTask when is_record(IssueTask, issue_task) ->
                            TaskNo = IssueTask#issue_task.task_no,
                            case catch check_base_receive_task(PS, TaskNo) of
                                {error, ErrCode} -> {error, ErrCode};
                                ok -> {ok, TaskNo}
                            end;
                        _ -> 
                            {error, ?PM_XS_TASK_ERROR_SYS}
                    end
            end
    end.

check_base_receive_task(PS, TaskNo) ->
    Task = data_task:get(TaskNo),
    % 等级不够
    ?Ifc (player:get_lv(PS) < Task#task.lv_down)
        throw({error, ?PM_XS_TASK_ERROR_RECEIVE_LV_LIMIT})
    ?End,

    % ... 其他条件

    ok.  

%%------------------------------------
%% 完成任务发送奖励邮件
%%------------------------------------
send_xs_task_finish_mail(TaskId, Status) ->
    RoleId = player:id(Status),
    RoleLv = player:get_lv(Status),
    % 获取奖励绑银数量
    Reward1 = data_xs_task:get_receive_reward(RoleLv),
    % 获取保证金数量 -配置在任务配置中
    Reward2 = 
        case data_task:get(TaskId) of
            null -> 0;
            Task -> Task#task.start_ub_cost + Task#task.start_cost
        end,
    Reward = Reward1 + Reward2,
    % 发送奖励
    lib_mail:send_sys_mail(RoleId
                          ,receive_mail_t()
                          ,io_lib:format(receive_mail_c(), [Reward1, Reward2, Reward])
                          ,[{89000, 1, Reward}]
                          ,[?LOG_XS_TASK, "receive"]
                      ),
    % 统计日志 %TODO
    lib_log:statis_role_action(Status, [power,vip_lv], "xs_task", "finish", ["role", TaskId]),
    % 反馈给悬赏任务管理器
    mod_xs_task:feedback_xs_task_finish(TaskId, RoleId),
    ok.

%%------------------------------------
%% 完成任务反馈
%%------------------------------------
feedback_xs_task_finish(State, TaskId, RoleId) ->
    NewTaskList = feedback_xs_task_finish__(State#issue_state.task_list, TaskId, RoleId, []),
    %?ylh_Debug("feedback_xs_task_finish__ ~p~n", [[State#issue_state.task_list,NewTaskList]]),
    State#issue_state{task_list = NewTaskList}.

feedback_xs_task_finish__([], _TaskId, _RoleId, AccISTask) -> AccISTask;
feedback_xs_task_finish__([IssueTask = #issue_task{task_no=TaskId
                                                ,role_receive = RoleReceive
                                                ,complete_num = CompleteNum
                                            } | Left], TaskId, RoleId, AccISTask) ->
    case lists:keyfind(RoleId, 2, RoleReceive) of
        false -> feedback_xs_task_finish__(Left, TaskId, RoleId, [IssueTask|AccISTask]);
        {_RTime, RoleId} ->
            NewIssueTask = IssueTask#issue_task{role_receive = lists:keydelete(RoleId, 2, RoleReceive)
                                                ,complete_num = CompleteNum + 1
                                            },
            [NewIssueTask | Left++AccISTask]
    end;
feedback_xs_task_finish__([IssueTask | Left], TaskId, RoleId, AccISTask) ->
    feedback_xs_task_finish__(Left, TaskId, RoleId, [IssueTask|AccISTask]).

%%------------------------------------
%% 任务失败发送邮件
%%------------------------------------
try_send_task_fail_mail(RoleId, TaskId) ->
    case data_task:get(TaskId) of
        Task when Task#task.type=:=?TASK_XS_TASK_TYPE ->
            lib_mail:send_sys_mail(RoleId, receive_mail_fail_t(), receive_mail_fail_c(), [], []),
            ok;
        _ -> skip
    end.

%%------------------------------------
%% 定时作业
%%------------------------------------
xs_task_doloop(State) ->
    Now = util:unixtime(),
    % 检查发送发布者奖励
    State1 = check_send_issue_reward(State, Now),
    % 检查系统接取完成任务
    State2 = check_sys_receive_task(State1, Now),
    % 检查系统发布任务
    State3 = check_sys_issue_task(State2, Now),
    State3.

% 检查发送发布者奖励 （整点发送奖励）
check_send_issue_reward(State, Now) ->
    DaySeconds = util:get_seconds_from_midnight(Now),
    HourSecond = DaySeconds rem ?ONE_HOUR_SECONDS, 
    case HourSecond < ?XS_TASK_MATCH_PERIOD of
        false -> State;
        true -> 
            TaskList = State#issue_state.task_list,
            % 统计
            F1 = fun(#issue_task{role_id=RoleId, issue_lv=IssueLv, complete_num=Num, task_no = TaskNo}, {ExpDict, NumDict}) 
                        when RoleId=/=0 andalso Num > 0 ->
                    lib_log:statis_role_action(sys, [], "xs_task", "finish", [TaskNo]),
                    AddExp = Num * data_xs_task:get_issue_exp(IssueLv),
                    {dict:update_counter(RoleId, AddExp, ExpDict)
                    ,dict:update_counter(RoleId, Num, NumDict)};
                    (_IssueTask, {ExpDict, NumDict}) -> {ExpDict, NumDict}
            end,
            {D1, D2} = lists:foldl(F1, {dict:new(), dict:new()}, TaskList),
            RewardDict = dict:merge(fun(_K, V1, V2)->{V1,V2} end, D1, D2),
            % 发送奖励
            F2 = fun(RoleId, {AddExp, Num}) ->
                    lib_mail:send_sys_mail(RoleId
                                          ,issue_mail_t()
                                          ,io_lib:format(issue_mail_c(), [Num, AddExp])
                                          ,[{89004, 1, AddExp}]
                                          ,[?LOG_XS_TASK, "issue"]
                                      ),
                    ok               
            end,
            dict:map(F2, RewardDict),
            %?ACT_MSG("xs_task : send_issue_reward Info: ~p~n", [dict:to_list(RewardDict)]),
            % 清空完成任务数
            NewTaskList = [T#issue_task{complete_num=0} || T <- TaskList],
            State#issue_state{task_list=NewTaskList}
    end.

% 检查系统接取完成任务
check_sys_receive_task(State, Now) -> 
    LastTime = State#issue_state.last_sys_receive_time,
    Period = data_xs_task:config(sys_receive_task_period),
   
    {MinNum, ReceiveNum} = data_xs_task:config(sys_receive_task_condition1),
    MinSeconds = data_xs_task:config(sys_receive_task_condition2),
    IssueLiveT = data_xs_task:config(issue_task_live_time),
            % 剩余时间小于5分钟则全部领取完成 （周期检查）
    F = fun(IssueTask=#issue_task{issue_num=IssueNum,issue_time=IssueTime,complete_num=CompleteNum}) when IssueTime+IssueLiveT-Now =< MinSeconds ->
               % 检查已经被玩家领取的任务，过期了则系统完成
               {NewRoleReceive, ExportNum} = check_role_receive_list(IssueTask#issue_task.role_receive, IssueTask#issue_task.task_no, Now),
               IssueTask#issue_task{issue_num=0, complete_num=CompleteNum+ExportNum+IssueNum, role_receive=NewRoleReceive};
            % 剩余次数大于5则领取2次 (2小时检查一次)
           (IssueTask=#issue_task{issue_num=IssueNum,complete_num=CompleteNum}) when IssueNum >= MinNum andalso (LastTime + Period < Now ) ->
               %?ACT_MSG("xs_task : sys_receive_task Info: issue_role=~p role_name=~s task_no=~p sys_receive_num=~p~n", [IssueTask#issue_task.role_id, IssueTask#issue_task.role_name, IssueTask#issue_task.task_no, ReceiveNum]),
               IssueTask#issue_task{issue_num=IssueNum-ReceiveNum, complete_num=CompleteNum+ReceiveNum};
            % 其他情况不处理
           (IssueTask) -> IssueTask

    end,

    NewTaskList1 = [F(T) || T <- State#issue_state.task_list],
    % 过滤掉剩余发布数为0且完成数为0且的任务
    NewTaskList2 = [ T || T <- NewTaskList1, T#issue_task.issue_num=/=0 orelse T#issue_task.complete_num=/=0 orelse T#issue_task.role_receive=/=[] ],
    % 更新系统自动接取时间
    NewLastTime = case LastTime + Period < Now of
        true -> Now;
        false -> LastTime
    end,
    State#issue_state{last_sys_receive_time = NewLastTime, task_list=NewTaskList2}.

% 检查已经被玩家领取的任务，返回新的接受列表和过期数
check_role_receive_list(RoleReceive, TaskNo, Now) ->
    TaskLimitTime = 
    case data_task:get(TaskNo) of
        null -> 0;
        Task -> Task#task.time_limit
    end,
    check_role_receive_list__(RoleReceive, TaskLimitTime, Now, [], 0).

check_role_receive_list__([], _LimitTime, _Now, AccRoleRecieve, ExportNum) -> {AccRoleRecieve, ExportNum};
check_role_receive_list__([{ReceiveTime, _RoleId}|Left], LimitTime, Now, AccRoleRecieve, ExportNum) when Now-ReceiveTime>LimitTime+600 -> % 过期了
    check_role_receive_list__(Left, LimitTime, Now, AccRoleRecieve, ExportNum+1);
check_role_receive_list__([ReveiveInfo|Left], LimitTime, Now, AccRoleRecieve, ExportNum) -> % 没过期
    check_role_receive_list__(Left, LimitTime, Now, [ReveiveInfo|AccRoleRecieve], ExportNum).




% 检查系统发布任务
check_sys_issue_task(State, Now) -> 
    LastTime = State#issue_state.last_sys_issue_time,
    Period = data_xs_task:config(sys_issue_task_period),
    case LastTime + Period < Now of
        false -> State;
        true ->
            TaskList = State#issue_state.task_list,
            ConditionNum = data_xs_task:config(sys_issue_task_condition),
            case lists:sum([T#issue_task.issue_num || T<- TaskList]) < ConditionNum of
                false -> State;
                true ->
                    RandTaskInfo = data_xs_task:config(sys_issue_task_rand_info),
                    RandTaskInfo1 = [ {{Lv, Num}, Weight} || {Lv, Weight, Num} <- RandTaskInfo],
                    {{PickLv, PickNum}, _} = util:rand_by_weight(RandTaskInfo1, 2),
                    %?ACT_MSG("xs_task : sys_issue_task Info: PickLv=~p PickNum=~p~n", [PickLv, PickNum]),
                    issue_xs_task__(0, PickLv, <<"">>, PickNum),
                    State#issue_state{last_sys_issue_time = Now}
            end
    end.

%%------------------------------------
%% 奖励邮件内容 t=title c=content
%%------------------------------------
issue_mail_t() -> <<"悬赏任务发布奖励">>.
issue_mail_c() -> <<"主人，您发布悬赏任务已经被热心人完成了~p次，共获得~p点经验！别问我为什么，就是有钱，任性！">>.
receive_mail_t() -> <<"悬赏任务完成奖励">>.
receive_mail_c() -> <<"主人，恭喜您完成了1次悬赏任务，奖励~p银子，返回保证金~p银子，共获得~p银子！">>.
receive_mail_fail_t() -> <<"悬赏任务失败">>.
receive_mail_fail_c() -> <<"主人，您领取悬赏任务没有在规定时间内完成，保证金不能退还，希望亲下次及时完成悬赏任务哦！">>.

