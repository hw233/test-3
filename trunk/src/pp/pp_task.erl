%% @author Administrator
%% @doc @todo Add description to pp_task.


-module(pp_task).

-include("common.hrl").
-include("record.hrl").
-include("task.hrl").
-include("prompt_msg_code.hrl").
-include("protocol/pt_30.hrl").
-include("xs_task.hrl").
-include("log.hrl").
-include("ets_name.hrl").

%% ====================================================================
%% API functions
%% ====================================================================
-export([handle/3]).
-compile(export_all).


% %% @doc 请求任务列表
% handle(?REQUEST_TASK_LIST, Status, []) ->
	
% 	ok;


%% @doc 请求触发列表
handle(30001, Status, []) ->
    lib_task:set_auto_task_trigger_switch(true),
    lib_task:send_trigger_msg_no_compare(Status),
    % 从第一次客户端请求后打开记录自动任务开关
    ok;


%% @doc 请求已接任务列表
handle(30002, Status, []) ->
	AcceptedList = lib_task:get_client_accepted(Status),
    ?DEBUG_MSG("---------- handle(30002, Status, []) AcceptedList-------------~p~n", [AcceptedList]),
    ?DEBUG_MSG("---------- handle(30002, Status, []) -------------~p~n", [lib_task:get_completed_list()]),

    % ?LDS_TRACE("30002!!!!!!!!!!!!", AcceptedList),
	{ok, BinData} = pt_30:write(30002, [AcceptedList]),
    lib_send:send_to_sock(Status#player_status.socket, BinData),
%%    ?DEBUG_MSG("notify_client ~p_______~p~n",[{notifu_client_id, Status#player_status.id},ets:lookup(?ETS_ACHIEVEMENT_TMP_CACHE, {notifu_client_id, Status#player_status.id})]),
%%    case ets:lookup(?ETS_ACHIEVEMENT_TMP_CACHE, {notifu_client_id, Status#player_status.id}) of
%%        [] ->
%%            skip;
%%        [{_, GetTaskId}] ->
%%            ?DEBUG_MSG("notify_client ~p~n",[GetTaskId]),
%%            {ok, BinData2} = pt_30:write(?PT_NOTIFY_TASKID, [GetTaskId]),
%%            lib_send:send_to_sock(Status#player_status.socket, BinData2),
%%            ets:delete(?ETS_ACHIEVEMENT_TMP_CACHE,{notifu_client_id, Status#player_status.id}),
%%            ?DEBUG_MSG("notify_client ~p~n",[ets:lookup(?ETS_ACHIEVEMENT_TMP_CACHE, {notifu_client_id, Status#player_status.id})])
%%    end,
%%    notifu_client_id
    % ?LDS_TRACE(30002, AcceptedList),
	ok;


%% @doc 接任务
handle(30003, Status, [TaskId]) ->
	case lib_task:check_cross_accept(TaskId) of
		{ok, 0} ->
			case player:is_leader(Status) of
				true -> lib_task:team_captain_accept(TaskId, Status);
				false -> lib_task:accept(TaskId, Status)
			% {ok, BinData} = pt_30:write(30003, [TaskId, Flag]),
			%    lib_send:send_to_sock(Status#player_status.socket, BinData)
			end,
			ok;
		{ok, 1} ->
			%% 跨服任务
			PlayerId = player:get_id(Status),
			lib_task:accept_task_cross(PlayerId, TaskId),
			ok;
		{fail, MsgCode} ->
			lib_send:send_prompt_msg(Status, MsgCode)
	end;


%% @doc 交任务
handle(30004, _Status, [0, ItemList]) ->
    ?ERROR_MSG("task error 30004 submit taskId = 0, ItemList = ~p, trigger task = ~p, accept task = ~p, completed task = ~p~n", 
        [ItemList, lib_task:get_trigger(), lib_task:get_accepted_list(), lib_task:get_completed_list()]),
    ?ASSERT(false);
handle(30004, Status, [TaskId, ItemList]) ->
    % case player:is_leader(Status) of
    %     true -> lib_task:team_captain_submit(TaskId, ItemList, Status);
    %     false -> lib_task:submit(TaskId, ItemList, Status)
    % end,

	lib_task:submit(TaskId, ItemList, Status),
    %% ===== test ========
    % mod_inv:batch_smart_add_new_goods(player:id(Status), [{4101, 1}]),
    % player:add_exp(Status, 100 * (Status#player_status.lv) * (Status#player_status.lv)),
    %% =====
    % ?LDS_TRACE("30004"),
	ok;


%% @doc 放弃任务
handle(30005, Status, [TaskId]) -> 
	lib_task:abandon(TaskId, Status),
	ok;


%% 更新某一任务
handle(30006, Status, [TaskId]) ->
    % ?LDS_TRACE("handle 30006"),
    lib_task:refresh_task(TaskId, Status),
    ok;

%% 取得某一NPC task data
handle(30008, Status, [NpcId]) ->
    lib_task:trigger(Status),
    TriggerList = lib_task:get_client_trigger_by_npc(NpcId),
    % ?LDS_TRACE(30008, TriggerList),
  %%剔除掉那些环数满了的

  TriggerList2 = [  [TaskId, State, NpcId, SceneId, Step, Ring]  || [TaskId, State, NpcId, SceneId, Step, Ring] <- TriggerList
  , begin TaskData =  data_task:get(TaskId),
      case TaskData#task.ring of
        0 ->
          true;
        _ ->
          {_, _MaxStep, _, MaxRing, _} =TaskData#task.ring,
          Ring =< MaxRing
      end
    end],


    {ok, BinData} = pt_30:write(30008, [TriggerList2]),
    lib_send:send_to_sock(Status#player_status.socket, BinData),
    ok;


handle(30009, Status, [State]) ->
    lib_task:handle_client_push_info(State, Status);


%% 寻路查找怪物位置
handle(30010, Status, [TaskId]) ->
	case data_task:get(TaskId) of
		Task when is_record(Task, task) ->
			F = fun() ->
						case lib_task:get_accepted(TaskId) of
							RoleTask when is_record(RoleTask, role_task) -> 
								{_, MonNo} = RoleTask#role_task.monNo,
								case MonNo > 0 of
									true ->
										case ply_scene:query_task_mon_pos(personal, player:id(Status), MonNo) of
											{ok, MonId, SceneId, X, Y} ->
												{ok, BinData} = pt_30:write(30010, [TaskId, SceneId, X, Y,MonId]),
												lib_send:send_to_sock(Status#player_status.socket, BinData);
											_ -> lib_send:send_prompt_msg(Status, ?TASK_NO_FIND_MON)
										end;
									_ -> lib_send:send_prompt_msg(Status, ?TASK_NO_FIND_MON)
								end;
							_ -> lib_send:send_prompt_msg(Status, ?PM_TASK_TASK_NOT_ACCEPT)
						end
				end,
			Ft = fun() ->
						 case player:is_in_team(Status) of
							 false ->
								 lib_send:send_prompt_msg(Status, ?TASK_NO_FIND_MON);
							 true ->
								 case mod_team:get_mon(Status, TaskId) of
									 [{_, MonNo} | _] -> 
										 case ply_scene:query_task_mon_pos(team, player:get_team_id(Status), MonNo) of
											 fail -> lib_send:send_prompt_msg(Status, ?TASK_NO_FIND_MON);
											 {ok, MonId, SceneId, X, Y} ->
												 {ok, BinData} = pt_30:write(30010, [TaskId, SceneId, X, Y,MonId]),
												 lib_send:send_to_sock(Status#player_status.socket, BinData)
										 end;
									 _ -> lib_send:send_prompt_msg(Status, ?TASK_NO_FIND_MON)
								 end
						 end
				 end,
			if 
				Task#task.team == 0 ->
					% 不限制组队或单人，先找单人还是先找组队？
					case player:is_in_team(Status) of
						false ->
							%% 不在队伍，那只找任务身上的
							F();
						true ->
							case mod_team:get_mon(Status, TaskId) of
								[{_, _MonNo} | _] -> 
									Ft();
								_ ->
									F()
							end
					end;
				Task#task.team == 1 ->
					% 任务只能单人的
					F();
				true ->
					% 任务是组队才能做的
					Ft()
			end;
		_ ->
			lib_send:send_prompt_msg(Status, ?PM_CLI_MSG_ILLEGAL)
	end,
	ok;
            %         {MonNo, _} = Task#role_task.monNo,
            %         Type = (data_task:get(TaskId))#task.mon_type,
            %         ?LDS_TRACE(30010, [MonNo, Type]),
            %         Result = case Type of
            %                     0 -> 
            %                         % 先尝试找个人的，如果失败，则再尝试找队伍的
            %                         case ply_scene:query_task_mon_pos(personal, player:id(Status), MonNo) of
            %                             fail ->
            %                                 case player:is_in_team(Status) of
            %                                     true -> ply_scene:query_task_mon_pos(team, player:get_team_id(Status), MonNo);
            %                                     false -> fail
            %                                 end;
            %                             Result__ ->
            %                                 Result__
            %                         end;
            %                     _ ->
            %                         ply_scene:query_task_mon_pos(public, MonNo)
            %                 end,
            %         case Result of
            %             fail -> lib_send:send_prompt_msg(Status, ?TASK_NO_FIND_MON);
            %             {ok, _MonId, SceneId, X, Y} ->
            %                 ?LDS_TRACE(30010, [{SceneId, X, Y}]),
            %                 {ok, BinData} = pt_30:write(30010, [TaskId, SceneId, X, Y]),
            %                 lib_send:send_to_sock(Status#player_status.socket, BinData)
            %         end
            % end;


%% 队长准备提交任务，对队员广播
handle(30011, Status, [TaskId]) ->
    lib_task:broadcast_member_to_submit_task(TaskId, Status),
    ok;


handle(30014, Status, [TaskId]) ->
    {ok, BinData} = pt_30:write(30014, [TaskId, lib_task:get_task_state(TaskId, Status)]),
    lib_send:send_to_sock(Status#player_status.socket, BinData);


%% gm
handle(30901, Status, [TaskId, State]) ->
    case lib_task:set_task_state(TaskId, State) of
        ok -> 
            {ok, BinData} = pt_30:write(30901, [1]),
            lib_task:refresh_task(TaskId, Status),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        _ ->
            {ok, BinData} = pt_30:write(30901, [0]),
            lib_send:send_to_sock(Status#player_status.socket, BinData)
    end;

%% ============================
%% 悬赏任务相关 30100 ~ 30199
%% ============================
% ======== 悬赏任务面板信息 ========
handle(?PT_GET_XS_TASK_INFO, Status, [FiltType, Page]) ->
    case catch mod_xs_task:get_issue_task_list() of
        L when is_list(L) ->
            MyLv = player:get_lv(Status),
            MyId = player:id(Status),
            % 过滤
            L1 = [T || T<-L, T#issue_task.issue_num=/=0, FiltType=:=0 orelse (FiltType=:=1 andalso T#issue_task.issue_lv=<MyLv andalso T#issue_task.role_id=/=MyId)],
            % 排序           
            SortIssueList  = lists:sort(fun lib_xs_task:issue_task_sort_fun/2, L1),
            % 获取对应页数据
            MaxLength = length(SortIssueList),
            MaxPage = max(util:ceil(MaxLength/?PAGE_NUM), 1),
            SelectIssueList = 
                case Page > MaxPage orelse Page =< 0 of
                    true -> [];
                    false ->
                        StartIndex = (Page-1)*?PAGE_NUM+1,
                        IssueList = lists:sublist(SortIssueList, StartIndex, ?PAGE_NUM),
                        Now = util:unixtime(),
                        LiveTime = data_xs_task:config(issue_task_live_time),
                        F = fun(IssueTask) ->
                            {IssueTask#issue_task.id
                            ,IssueTask#issue_task.role_id
                            ,IssueTask#issue_task.role_name
                            ,IssueTask#issue_task.issue_lv
                            ,IssueTask#issue_task.issue_num
                            ,max(LiveTime - (Now - IssueTask#issue_task.issue_time),0)
                            }
                        end,
                        [F(I) || I <- IssueList]
                end,
            % 获取今日剩余领取数
            ReceiveNum = player:get_xs_task_receive_num(Status),
            LeftReceiveNum = data_xs_task:config(receive_num_per_day) - ReceiveNum,
            % 返回数据
            {ok, BinData} = pt_30:write(?PT_GET_XS_TASK_INFO, [Page, MaxPage, SelectIssueList, LeftReceiveNum]),
            %?ylh_Debug("get_xs_task_info ~p~n", [[L, Page, MaxPage, SelectIssueList]]),
            lib_send:send_to_sock(Status, BinData),
            ok;
        _ -> skip
    end,
    ok;

% ======== 发布悬赏任务 ========
handle(?PT_ISSUE_XS_TASK, Status, [IssueNum, IsAnonymity]) ->
    ErrCode = 
    % 检查发布条件
    case lib_xs_task:check_issue_task(Status, IssueNum) of
        {error, ErrCode__} -> ErrCode__;
        {ok, Cost} ->
            % 消耗发布次数与金子
            case lib_xs_task:cost_issue_task(Status, IssueNum, Cost) of
                error -> ?PM_XS_TASK_ERROR_SYS;
                ok ->
                    % 发布悬赏任务
                    lib_xs_task:issue_xs_task(Status, IssueNum, IsAnonymity),
                    0
            end
    end,
    % 回复客户端
    case ErrCode =:= 0 of
        true ->
            LeftIssueNum = player:get_xs_task_left_issue_num(Status),
            %?ylh_Debug("issue xs task ~p~n", [[IssueNum, ErrCode, LeftIssueNum-IssueNum]]), 
            {ok, BinData} = pt_30:write(?PT_ISSUE_XS_TASK, [0, LeftIssueNum-IssueNum]),
            % lib_send:send_to_sock(Status, BinData); 
             %需求5562：悬赏任务单次发布10个悬赏任务以上，给予公告提示
            case IssueNum >= 10 of
                true ->
                    case IsAnonymity =:= 0 of
                        true ->
                            ply_tips:send_sys_tips(Status, {issue_xs_task, [player:get_name(Status),IssueNum]});
                        false ->
                            ply_tips:send_sys_tips(Status, {issue_xs_task, [<<"匿名">>,IssueNum]})
                    end;
                false ->
                    lib_send:send_to_sock(Status, BinData)
            end;
        false ->
            % 发送错误信息
            lib_send:send_prompt_msg(Status, ErrCode)
    end,
    ok;

% ======= 领取悬赏任务 ========
handle(?PT_RECEIVE_XS_TASK, Status, [IssueId]) ->
    ErrCode =
    % 检查领取条件
    case lib_xs_task:check_receive_task(Status, IssueId) of
        {error, ErrCode__} -> ErrCode__;
        {ok, TaskId} ->
            % 领取任务
            case lib_task:accept(TaskId, Status) of
                1 -> % 接取成功
                    OldXSReceiveNum = player:get_xs_task_receive_num(Status),
                    player:set_xs_task_receive_num(Status, OldXSReceiveNum+1),
                    mod_xs_task:receive_task(IssueId, player:id(Status)),
                    lib_log:statis_role_action(Status, [power,vip_lv], "xs_task", "accept", [TaskId]),
                    0;
                _ -> skip
            end
    end,
    % 回复客户端
    %?ylh_Debug("receive xs task ~p~n", [[player:id(Status), IssueId, ErrCode]]),
    case ErrCode of
        skip -> skip;
        0 ->
            {ok, BinData} = pt_30:write(?PT_RECEIVE_XS_TASK, [0]),
            lib_send:send_to_sock(Status, BinData);
        ?PM_XS_TASK_ERROR_RECEIVE_NO_EXIST -> % 对应的悬赏任务不存在则返回1，客户端刷新界面
            {ok, BinData} = pt_30:write(?PT_RECEIVE_XS_TASK, [1]),
            lib_send:send_to_sock(Status, BinData),
            lib_send:send_prompt_msg(Status, ErrCode);
        _ ->
            % 发送错误信息
            lib_send:send_prompt_msg(Status, ErrCode)
    end,   
    ok;

% ======= 获取剩余发布数量 ========
handle(?PT_GET_LEFT_ISSUE_NUM, Status, []) ->
    {ok, BinData} = pt_30:write(?PT_GET_LEFT_ISSUE_NUM, [player:get_xs_task_left_issue_num(Status), player:get_xs_task_issue_num(Status)]),
    ?ylh_Debug("get_left_issue_num ~p~n", [[player:id(Status), player:get_xs_task_issue_num(Status), player:get_xs_task_left_issue_num(Status), player:get_xs_task_receive_num(Status)]]),
    lib_send:send_to_sock(Status, BinData),
    ok;

% ======== 判断是否可以领取任务=======
handle(?PT_IS_CAN_RECEIVE_XS_TASK, Status, [])->
    case catch mod_xs_task:get_issue_task_list() of
        L when is_list(L) ->
            % 过滤
            F = fun(IssueTask) ->
                    case lib_xs_task:check_receive_task(Status, IssueTask#issue_task.id) of
                        {error, _ErrCode} -> 
                            false;
                        {ok, _TaskId} -> true
                    end       
                end,
            CanReceive = case lists:filter(F, L) of
                                %没有可以领取的任务
                                [] -> 1;
                                _ -> 0
                        end,
            ?ylh_Debug("can receive xs task =~p~n", [CanReceive]),
            {ok, BinData} = pt_30:write(?PT_IS_CAN_RECEIVE_XS_TASK, [CanReceive]),
            lib_send:send_to_sock(Status, BinData);
        _ ->
            ?ylh_Debug("can receive xs task next ~n"),
            {ok, BinData} = pt_30:write(?PT_IS_CAN_RECEIVE_XS_TASK, [1]),
            lib_send:send_to_sock(Status, BinData)
    end,
    ok;

%%handle(?PT_IS_CAN_GET_REWARD_BY_TIMES, Status, [])->
%%    {ok, BinData} = pt_30:write(?PT_IS_CAN_GET_REWARD_BY_TIMES, [0]),
%%    lib_send:send_to_sock(Status, BinData);


handle(?PT_ERNIE_GET, Status, [])->

    case erlang:get(?TASK_REWARD) of
        true ->
            ErnieNo = lib_reward:get_reward_by_gosht_faction_task(),
            {ok, BinData} = pt_30:write(?PT_ERNIE_GET, [ErnieNo]),
            lib_send:send_to_sock(Status, BinData),
            [{GoodsNo, GoodsCount, Quality, BindState}] = (data_task_ernie:get(ErnieNo))#task_ernie.reward,

            case mod_inv:batch_smart_add_new_goods(player:id(Status),
                    [{GoodsNo, GoodsCount}],
                    [{quality, Quality}, {bind_state, BindState}],
                    [?LOG_TASK_ERNIE, "task_ernie"]) of
                {fail, _} ->
                    lib_mail:send_sys_mail(player:id(Status), <<"任务转盘奖励">>, <<"大侠，你的背包不足，现通过邮件发送任务转盘奖励！">>, [{GoodsNo, 1, GoodsCount}], [?LOG_TASK_ERNIE, "task_ernie"]);
                {ok, RetGoods} ->
                    % 增加提示
                    F1 = fun({Id, No, Cnt}) ->
                            case mod_inv:find_goods_by_id_from_bag(player:id(Status), Id) of
                                null -> skip;
                                Goods1 ->
                                    ply_tips:send_sys_tips(Status, {get_goods, [No, lib_goods:get_quality(Goods1), Cnt,Id]})
                            end
                         end,
                    [F1(X) || X <- RetGoods]

            end,
            erlang:put(?TASK_REWARD, false);
        _ ->
            skip
    end;

                
handle(_Cmd, _, _) ->
	?ASSERT(false, [_Cmd]).

%% ====================================================================
%% Internal functions
%% ====================================================================


% test_handle(Id, Cmd, Args) ->
%     Pid = player:get_pid(Id),
%     Status = player:get_PS(Id),
%     gen_server:cast(Pid, {apply_cast, ?MODULE, handle, [Cmd, Status, Args]}).

% test_handle(Id, Cmd, Args, MODULE) ->
%     Pid = player:get_pid(Id),
%     Status = player:get_PS(Id),
%     gen_server:cast(Pid, {apply_cast, MODULE, handle, [Cmd, Status, Args]}).

% get_dect(Id, Method, Args) ->
%     Pid = player:get_pid(Id),
%     Msg = gen_server:call(Pid, {apply_call, lib_task, Method, Args}),
%     ?LDS_TRACE(Msg).


% set_lv(Id, Lv) ->

%     Status = player:get_PS(Id),
%     ?LDS_TRACE("set_lv first Lv = ", Status#player_status.lv),
%     mod_svr_mgr:update_online_player_status_to_ets(Status#player_status{lv = Lv}).

% event(Id, EventType, Args) ->
%     Status = player:get_PS(tool:to_integer(Id)),
%     lib_event:event(EventType, Args, Status).

% get_PS(Id) ->
%     Status = player:get_PS(Id),
%     ?LDS_TRACE(Status),
%     ?LDS_TRACE(exp, Status#player_status.exp).


% set_state(Val) ->
%     redo.
