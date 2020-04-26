%% @author Administrator
%% @doc @todo Add description to lib_task.


-module(lib_task).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("task.hrl").
-include("event.hrl").
-include("scene.hrl").
-include("faction.hrl").
-include("activity_degree_sys.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("goods.hrl").
-include("buff.hrl").

%% @doc 已完成任务

-record(completed, {
					   id = 0
					  ,task_type = 0
					  ,date = 0
					  ,times = 1
				   }).

-define(TASK_CANT_TRIGGER, 0).	%任务不可触发
-define(TASK_TRIGGER, 1).		%可触发的任务	1
-define(TASK_CAN_ACCEPT, 3).	%可接的任务 	11
-define(TASK_ACCEPTED, 7).		%已接的任务 	111 
-define(TASK_FAIL, 15).			%失败的任务 	1111
-define(TASK_COMPLETED, 23).	%完成的任务		10111

-define(ERROR, 0).				%错误代号
-define(SUCCESS, 1).			%成功代号
-define(FAIL, 3).				%失败代号

-define(TASK_SET, task_set).
-define(MEM_TASK_ACCEPT, task_accept).

-define(TASK_FLAG, {task, flag}).

-define(OVER_TASK_LIMIT, 3).
-define(TASK_STATE_ERROR, 4).
-define(BAG_OVERRIDE, 5).
-define(NOT_ENOUGH_PEOPLE, 6).	 		% 人数不足
-define(TASK_CAN_NOT_IN_TEAM, 7). 		% 不能组队领取
-define(TASK_ITEM_ERROR, 10).    		% 任务需求物品不足
-define(PERV_TASK_NOT_SUBMIT, 11).  	% 前置任务未完成
-define(TASK_NOT_ENOUT_TIMES, 12).      % 任务接取次数不足
-define(HAD_SAME_TYPE_TASK, 13).        % 已有相同类型任务
-define(TASK_ROLE_LIMIT, 14).           % 角色自身条件不符合(种族、性别等)
-define(TASK_GUILD_LIMIT, 15).          % 角色帮派条件不符合
-define(TASK_ROLE_LV_NOT_ENOUGTH, 16).  % 角色等级不足
-define(NO_TASK_TRIGGER_ITEM, 17).      % 没有触发任务物品
-define(TASK_MONEY_ERROR, 18).    		% 任务需求货币不足

-define(SAVE_INTERVAL, 180000).			% 3 MIN 任务定时存储时间间隔

-define(COMPLETED_EVENT_TYPE, [talk, send, join_faction]).

-define(DEFAULT_VAL(Val), Val =:= 0 orelse Val =:= nil).
%% ====================================================================
%% API functions
%% ====================================================================
-export([]).
-compile(export_all).

%% -------------------- 任务流程基本接口 ----------------

%% @doc trigger task 
%% @spec
%% @end
trigger(Status) ->
	ok = refresh_base_task_set(trigger_task, Status),		% 添加基本类型任务到触发列表
	% ok = refresh_time_limit_task_set(trigger_task, Status),% 添加期限任务到触发表 
	% check_auto_task( player:get_pid(Status)),	%检查自动领取任务
	ok.



%% @doc accept task
%% @spec accept(Status::#player_status{}, Task::#task()) -> Flag::integer()
%% @end
accept(TaskId, Status) when is_integer(TaskId) ->
	case data_task:get(TaskId) of
		null -> ?ASSERT(false), error;
		Task when is_record(Task, task) -> accept(Task, Status);
		_ -> ?ASSERT(false), error
	end;
accept(TmpTask, Status) ->
	% RoleId = Status#player_status.id,
	% TmpTask = data_task:get(TmpTaskId),

	TmpTaskId = TmpTask#task.id,
	case lib_activity_degree:check_activity_degree_times_valid(Status, TmpTask#task.sys_no) of
		?true ->
			case can_accept(TmpTask, Status) of
				?SUCCESS ->
					
					% 2018/11/7三界增加扣除水玉
					{Step, Ring} = get_current_setp_and_round(TmpTaskId),
					?DEBUG_MSG("-------------------{Step, _Ring}------------------~p~p~n", [Step, Ring]),
					case is_sanjie_task(TmpTaskId) andalso Step =:= 1 of
						true ->
							{Type, Num} = (data_sanjieyishi_cost:get(TmpTaskId))#sanjieyishi_cost.cost,
							?ASSERT((Type =:= ?MNY_T_YUANBAO)),
							player:cost_money(Status, Type, Num, [?LOG_SANJIE, "sanjie"]);
						false ->
							skip
					end,
					
					case accept_ring_task(TmpTask) of
						null -> 
							send_trigger_msg_no_compare(Status),
							notify_client_task_accept(?TASK_STATE_ERROR, TmpTaskId, Status),
							?FAIL;
						Task ->
							TaskId = Task#task.id,

							% 回收开始任务物品
							case cyc_task_start_item(TaskId, Status) of
								{false, ErrCode} -> 
									% 推送客户端
									notify_client_task_accept(ErrCode, TmpTaskId, Status),
									?FAIL;
								true ->
									
									% 任务日志
									lib_log:task_accept(TaskId, Status),
									
									% 打包任务数据并添加至接受任务表
									TmpRoleTask = package_task_data(content, [Task, ?TASK_ACCEPTED]),
									RoleTask_1 = check_task_finish(TmpRoleTask, Status),
									% 检查任务是否提前完成
									RoleTask = notify_check_update_task_if_change_local(RoleTask_1, Status),
									% 发放开始任务物品
									catch offer_start_task_item(TaskId, Status),
									% 开始任务事件触发
									catch accept_event(Task, Status),
									% 保存任务
									add_accepted(RoleTask),
									cache_task_operation(insert, RoleTask),
									
									% 设置环任务标志
									set_task_ring_state(Task, accept),
									start_task_timer(RoleTask),
									
									% 推送客户端
									notify_client_task_accept(?SUCCESS, RoleTask, Status),
									% 检查任务是否提前完成
									% notify_check_update_task_if_change(TaskId, Status),
									send_trigger_msg(Status),
									%% 通知任务事件
									notify_task_event(TaskId, ?TASK_ACCEPTED_EVENT, Status),
									case Task#task.type == ?TASK_ONHOOK_TYPE orelse Task#task.ring =:= 0 of   %%除了8挂机任务，其他环任务都要发30017
										false ->
											{ok, BinData2} = pt_30:write(30017, [TaskId]),
											lib_send:send_to_sock(Status#player_status.socket, BinData2);
										true ->
											skip
									end,
									?SUCCESS
							end
					end;
				% {ok, BinData} = pt_30:write(30003, [TaskId, Flag]),
				%  		lib_send:send_to_sock(Status#player_status.socket, BinData);
				Other -> 
					notify_client_task_accept(Other, TmpTaskId, Status),
					?FAIL
					% {ok, BinData} = pt_30:write(30003, [TmpTaskId, Other]),
					%  		lib_send:send_to_sock(Status#player_status.socket, BinData)
			end;
		_ ->
			error
	end.


accept(TmpTask, Status,_TaskType) ->
	% RoleId = Status#player_status.id,
	% TmpTask = data_task:get(TmpTaskId),

	TmpTaskId = TmpTask#task.id,
	case lib_activity_degree:check_activity_degree_times_valid(Status, TmpTask#task.sys_no) of
		?true ->
			case can_accept(TmpTask, Status) of
				?SUCCESS ->

					% 2018/11/7三界增加扣除水玉
					{Step, Ring} = get_current_setp_and_round(TmpTaskId),
					?DEBUG_MSG("-------------------{Step, _Ring}------------------~p~p~n", [Step, Ring]),
					case is_sanjie_task(TmpTaskId) andalso Step =:= 1 of
						true ->
							{Type, Num} = (data_sanjieyishi_cost:get(TmpTaskId))#sanjieyishi_cost.cost,
							?ASSERT((Type =:= ?MNY_T_YUANBAO)),
							player:cost_money(Status, Type, Num, [?LOG_SANJIE, "sanjie"]);
						false ->
							skip
					end,

					case accept_ring_task(TmpTask) of
						null ->
							send_trigger_msg_no_compare(Status),
							notify_client_task_accept(?TASK_STATE_ERROR, TmpTaskId, Status),
							?FAIL;
						Task ->
							TaskId = Task#task.id,
%%							ets:insert(?ETS_ACHIEVEMENT_TMP_CACHE,{{notifu_client_id , Status#player_status.id},TaskId}),
							% 回收开始任务物品
							case cyc_task_start_item(TaskId, Status) of
								{false, ErrCode} ->
									% 推送客户端
									notify_client_task_accept(ErrCode, TmpTaskId, Status),
									?FAIL;
								true ->

									% 任务日志
									lib_log:task_accept(TaskId, Status),

									% 打包任务数据并添加至接受任务表
									TmpRoleTask = package_task_data(content, [Task, ?TASK_ACCEPTED]),
									RoleTask_1 = check_task_finish(TmpRoleTask, Status),
									% 检查任务是否提前完成
									RoleTask = notify_check_update_task_if_change_local(RoleTask_1, Status),
									% 发放开始任务物品
									catch offer_start_task_item(TaskId, Status),
									% 开始任务事件触发
									catch accept_event(Task, Status),
									% 保存任务
									add_accepted(RoleTask),
									cache_task_operation(insert, RoleTask),

									% 设置环任务标志
									set_task_ring_state(Task, accept),
									start_task_timer(RoleTask),

									% 推送客户端
									notify_client_task_accept(?SUCCESS, RoleTask, Status),
									% 检查任务是否提前完成
									% notify_check_update_task_if_change(TaskId, Status),
									send_trigger_msg(Status),
									%% 通知任务事件
									notify_task_event(TaskId, ?TASK_ACCEPTED_EVENT, Status),
									{ok, BinData2} = pt_30:write(30017, [TaskId]),
									lib_send:send_to_sock(Status#player_status.socket, BinData2),
									?SUCCESS
							end
					end;
				% {ok, BinData} = pt_30:write(30003, [TaskId, Flag]),
				%  		lib_send:send_to_sock(Status#player_status.socket, BinData);
				Other ->
					notify_client_task_accept(Other, TmpTaskId, Status),
					?FAIL
				% {ok, BinData} = pt_30:write(30003, [TmpTaskId, Other]),
				%  		lib_send:send_to_sock(Status#player_status.socket, BinData)
			end;
		_ ->
			error
	end.

	
	

%% 强制接取任务条件，成功包括扣除物品, 只配合force_accept/2使用
%% @return : true | false
force_accept_condition(TaskId, Status) ->
	% Task = data_task:get(TaskId),
	case is_task_can_accepted(TaskId, Status) of
		true -> true == cyc_task_start_item(TaskId, Status);
		_ -> false
	end.

%% @return : void
force_accept(TaskId, Status) ->
	% Task = accept_ring_task(data_task:get(TmpTaskId)),
	% TaskId = Task#task.id,
	Task = data_task:get(TaskId),

	% Task = accept_ring_task(TmpTask),
	% cyc_task_start_item(TaskId, Status),

	% 记录任务日志
	lib_log:task_accept(TaskId, Status),

	% 打包任务数据并添加至接受任务表
	TmpRoleTask = package_task_data(content, [Task, ?TASK_ACCEPTED]),
	RoleTask_1 = check_task_finish(TmpRoleTask, Status),
	% 检查任务是否提前完成
	RoleTask = notify_check_update_task_if_change_local(RoleTask_1, Status),
	add_accepted(RoleTask),
	cache_task_operation(insert, RoleTask),

	% 发放开始任务物品
	offer_start_task_item(TaskId, Status),

	% 开始任务事件触发
	accept_event(Task, Status),
	% 设置环任务标志
	set_task_ring_state(Task, accept),
	start_task_timer(RoleTask),
	% 推送客户端
	notify_client_task_accept(?SUCCESS, RoleTask, Status),
	% 检查任务是否提前完成
	% notify_check_update_task_if_change(TaskId, Status),
	send_trigger_msg(Status),
	%% 通知任务事件
	notify_task_event(TaskId, ?TASK_ACCEPTED_EVENT, Status),
	?SUCCESS.


%% @doc 通知客户端接取任务
notify_client_task_accept(State, TaskId, Status) when is_integer(TaskId) ->
	{ok, BinData} = pt_30:write(30003, [TaskId, State]),
	lib_send:send_to_sock(Status#player_status.socket, BinData);

notify_client_task_accept(State, Task, Status) when is_record(Task, role_task) ->
	case State =:= ?SUCCESS of
		true ->
			{ok, BinData} = pt_30:write(30003, [Task#role_task.id, ?SUCCESS]),
    		lib_send:send_to_sock(Status#player_status.socket, BinData),
    		Data = package_task_data(accepted, [Task]),
			{ok, PackData} = pt_30:write(30013, [Data]),
			lib_send:send_to_sock(Status#player_status.socket, PackData);
		false ->
			{ok, BinData} = pt_30:write(30003, [Task#role_task.id, State]),
    		lib_send:send_to_sock(Status#player_status.socket, BinData)
    end;
notify_client_task_accept(_, _, _) -> ?ASSERT(false).


%% 组队情况下接任务
team_captain_accept(TaskId, Status) ->
    ?DEBUG_MSG("----------------------accept(TmpTask, Status) TaskId--------------------~p~n", [TaskId]),
	case data_task:get(TaskId) of
		null -> ?ASSERT(false), skip;
		Task ->
			%% 只要不等于1，都可以走队伍任务20200102 zjy
			case Task#task.team > 1 of
				true -> accept_team_task(Task, Status);
				false -> accept(Task, Status)
			end
	end.
			
%% @doc submit task
%% @spec
%% @end
submit(TaskId, ItemIdList, Status) ->
	Task = data_task:get(TaskId),
	RoleTask = get_accepted(TaskId),
	case lib_activity_degree:check_activity_degree_times_valid(Status, Task#task.sys_no) of
		?false ->
			skip;
		?true ->
			Flag = 
				if 
					RoleTask =:= null -> ?ERROR;
					RoleTask#role_task.state =:= ?TASK_COMPLETED -> 
						case can_finish_condition(RoleTask, Status) of
							?SUCCESS ->
								case cyc_task_item(TaskId, ItemIdList, Status) of
									true ->
										%% 通知队员提交任务
										notify_member_submit(TaskId, ItemIdList, Status),
										% 发放奖励
										catch send_reward(Task, Status),
										% 添加完成任务记录
										add_completed_db(Task),
										del_accepted_db(TaskId),
										% ?LDS_TRACE("submit 11", TaskId),
										% 环任务处理
										ring_task_submit(TaskId),
										% 触发事件
										submit_event(Task, Status),
										gen_server:cast( player:get_pid(Status), 'send_trigger_msg_no_compare'),
										%% 通知任务事件
										notify_task_event(TaskId, ?TASK_SUBMIT_EVENT, Status),
										%% 通知各系统
										notify_sys_task_submit(Task, Status),
										catch lib_log:task_submit(TaskId, Status),
										%%检查是否为师门人物/环任务？
										case Task#task.type == ?TASK_ONHOOK_TYPE orelse Task#task.ring =:= 0 
											orelse Task#task.type == ?TASK_GOSHT_TYPE of   %%除了8挂机任务，其他环任务都要，20191224 zjy 抓鬼不要自动接任务
											false ->
												{MasterId, _MaxStep, _, _MaxRing, _} = Task#task.ring,
												%%自动接任务   lib_task:accept(1041100, player:get_PS(1000100000000676))
												gen_server:cast( player:get_pid(Status), {'auto_accept_task', MasterId});
											true ->
												skip
										end,
										?SUCCESS;
									false ->
										send_trigger_msg(Status),
										notify_check_update_task_if_change(TaskId, Status),
										?TASK_ITEM_ERROR
								end;
							Other ->
								send_trigger_msg(Status),
								notify_check_update_task_if_change(TaskId, Status),
								Other
						end;
					true -> ?ERROR
				end,
			{ok, BinData} = pt_30:write(30004, [TaskId, Flag]),
			lib_send:send_to_sock(Status#player_status.socket, BinData)
	end.


force_submit(TaskId, Status) ->
	case get_accepted(TaskId) of
		null -> skip;
		_ ->
			Task = data_task:get(TaskId),
			
			%% 判断跟活动关联的，如果不满足次数的，不给奖励了
			case lib_activity_degree:check_activity_degree_times_valid(Status, Task#task.sys_no) of
				?false ->
					notify_member_submit(TaskId, [], Status),
					del_accepted_db(TaskId);
				?true ->
					% RoleTask = get_accepted(TaskId),
					cyc_task_item(TaskId, [], Status),
					%% 通知队员提交任务
					notify_member_submit(TaskId, [], Status),
					% 发放奖励
					catch send_reward(Task, Status),
					% 添加完成任务记录
					add_completed_db(Task),
					del_accepted_db(TaskId),
					% ?LDS_TRACE("submit 11", TaskId),
					% 环任务处理
					ring_task_submit(TaskId),
					% 触发事件
					submit_event(Task, Status),
					gen_server:cast( player:get_pid(Status), 'send_trigger_msg_no_compare'),
					%% 通知任务事件
					notify_task_event(TaskId, ?TASK_SUBMIT_EVENT, Status),
					%% 通知各系统
					notify_sys_task_submit(Task, Status),
					lib_log:task_submit(TaskId, Status),
					case Task#task.type == ?TASK_ONHOOK_TYPE orelse Task#task.ring =:= 0 
						orelse Task#task.type == ?TASK_GOSHT_TYPE of   %%除了8挂机任务，其他环任务都要，20191224 zjy 抓鬼不要自动接任务
						false ->
							{MasterId, _MaxStep, _, _MaxRing, _} = Task#task.ring,
							%%自动接任务   lib_task:accept(1041100, player:get_PS(1000100000000676))
							gen_server:cast( player:get_pid(Status), {'auto_accept_task', MasterId});
						true ->
							skip
					end,
					{ok, BinData} = pt_30:write(30004, [TaskId, ?SUCCESS]),
					lib_send:send_to_sock(Status#player_status.socket, BinData)
			end
	end.

force_submit(TaskId, Status, goods_eff) ->
	case get_accepted(TaskId) of
		null -> skip;
		_ ->
			Task = data_task:get(TaskId),
			% RoleTask = get_accepted(TaskId),
			%cyc_task_item(TaskId, [], Status),
			%% 通知队员提交任务
			notify_member_submit(TaskId, [], Status),
			% 发放奖励
			try
				send_reward(Task, Status)
			catch
				E:R ->
					?ERROR_MSG("error ~p~n", [{E, R, erlang:get_stacktrace()}])
			end,
			% 添加完成任务记录
			add_completed_db(Task),
			del_accepted_db(TaskId),
			% ?LDS_TRACE("submit 11", TaskId),
			% 环任务处理
			ring_task_submit(TaskId),
			% 触发事件
			submit_event(Task, Status),
			gen_server:cast( player:get_pid(Status), 'send_trigger_msg_no_compare'),
			%% 通知任务事件
			notify_task_event(TaskId, ?TASK_SUBMIT_EVENT, Status),
			%% 通知各系统
			notify_sys_task_submit(Task, Status),
			lib_log:task_submit(TaskId, Status),
			{ok, BinData} = pt_30:write(30004, [TaskId, ?SUCCESS]),
		    lib_send:send_to_sock(Status#player_status.socket, BinData)
	end.


%% @doc 放弃任务
%% @spec
%% @end
abandon(TaskId, Status) -> 
	Task = data_task:get(TaskId),
	%增加师门挑战任务判断
	case Task#task.type =:= ?TASK_MAIN_TYPE orelse is_faction_fight_can_abandon(TaskId) of
		true -> skip;
		false ->
			Flag = 
				case get_accepted(TaskId) of
					null -> 
						?ASSERT(false, [TaskId]),
						?ERROR;
					Rd -> 
						% 删除动态刷新任务怪
						del_dynamic_task_mon(TaskId),
						% 删除接受任务表相关记录
						del_accepted(TaskId),	
						cache_task_operation(delete, Rd),
						% 额外条件处理
						handle_extra_condition(abandon, TaskId, Status),
						% @todo 物品回收
						cyc_task_offer_item(TaskId, Status), 
						%% 解除环任务标志
						release_ring_task_falg(data_task:get(TaskId)),
						%% 通知任务事件
						notify_task_event(TaskId, ?TASK_ABANDON_EVENT, Status),
						send_trigger_msg(Status),
						?SUCCESS
				end,
			{ok, BinData} = pt_30:write(30005, [TaskId, Flag]),
		    lib_send:send_to_sock(Status#player_status.socket, BinData)
	end.

%%增加师门挑战任务是否可以放弃
is_faction_fight_can_abandon(TaskId) ->
	Task = data_task:get(TaskId),
	case Task#task.type =:= ?TASK_FACTION_FIGHT_TYPE of
		true ->
			case get_accepted(TaskId) of
				null ->
					?ASSERT(false, [TaskId]),
					false;
				Rd ->
					CurTime = util:unixtime(),
					AcceptTime = Rd#role_task.accept_time, 
					case util:is_timestamp_same_day(AcceptTime, CurTime) of
						true ->
							true;
						false ->
							false
					end
			end;
		false ->
			false	
	end.

%% @doc 使任务失败
make_fail(Task, Status) ->
	% ?LDS_TRACE("make"),
	NewTask = Task#role_task{state = ?TASK_FAIL},
	update_accepted(NewTask),
	handle_extra_condition(fail, Task#role_task.id, Status),
	refresh_task(NewTask, player:id(Status)),
    % 悬赏任务发送邮件
    lib_xs_task:try_send_task_fail_mail(player:id(Status), Task#role_task.id),
	%% 通知任务事件
	notify_task_event(Task#role_task.id, ?TASK_FAIL_EVENT, Status),
	ok.


%% ------------------------ 通用接口处理 --------------------------------
%% @doc 处理任务时需要额外处理的条件  true | false
handle_extra_condition(trigger, _TaskId, _Status) ->
	% @add
	true;

handle_extra_condition(accepted, _TaskId, _Status) ->
	% @add
	true;

handle_extra_condition(completed, _TaskId, _Status) ->
	% @add
	true;

handle_extra_condition(fail, _TaskId, _Status) ->
	% @add
	true;

handle_extra_condition(abandon, _TaskId, _Status) ->
	% @add
	true.


%% @doc 判断任务额外条件
%% @return true | false
%% @end
is_extra_condition(can_accept, _TaskId, _Status) -> 
	true;

is_extra_condition(?TASK_SANJIE_TYPE, TaskId, Status) ->
    PlyVipLv = player:get_vip_lv(Status),
    Extra = data_vip_welfare:get(sanjieyishi_extra_time, PlyVipLv),
    {Step, Ring} = get_current_setp_and_round(TaskId),
    {_, _MaxStep, _, MaxRing, _} = (data_task:get(TaskId))#task.ring,
    {Type, Num} = (data_sanjieyishi_cost:get(TaskId))#sanjieyishi_cost.cost,

    case Step =:= 1 of
        true ->
            case player:has_enough_money(Status, Type, Num) of
                true ->
                    case Ring > 1 of
                        true ->
                            case get_task_ring(TaskId) of
                                null ->
                                    ?ASSERT(false), {false, ?TASK_STATE_ERROR};
                                RingTask ->
                                    NowDays = get_now_date(),
                                    case NowDays - RingTask#task_ring.date =< 7 of
                                        true ->
                                            case MaxRing + Extra >= Ring of
                                                true ->
                                                    ?SUCCESS;
                                                false ->
                                                    ?TASK_NOT_ENOUT_TIMES
                                            end;
                                        false ->
                                            ?SUCCESS
                                    end

                            end;
                        false ->
                            ?SUCCESS
                    end;
                false ->
                    ?TASK_MONEY_ERROR
            end;
        false ->
            ?SUCCESS
    end;


is_extra_condition(finish, TaskId, Status) -> 
	faction_condition(TaskId, Status).


%% --------------------- function interface -------------

-define(TASK_NO_ACCEPT, 1).
-define(TASK_HAD_ACCEPT, 2).
-define(TASK_HAD_SUBMIT, 3).

%% 获取任务状态
get_task_state(TaskId, Status) when is_integer(TaskId)->
	case get_accepted(TaskId) of
		null -> 
			case is_task_submit(TaskId, Status) of
				true -> ?TASK_HAD_SUBMIT;
				false -> ?TASK_NO_ACCEPT
			end;

			
		_ -> ?TASK_HAD_ACCEPT
	end.

%% 是否接了该任务
have_task(TaskId,Status) when is_integer(TaskId) -> 
	List = get_accepted_list(),

	F = fun(Tid,Acc) ->
		Tid /= TaskId andalso Acc
	end,

	Ret = lists:foldl(F,true,List),

	?DEBUG_MSG("Ret = ~p,List = ~p",[Ret,List]),

	Ret.
	


%% 任务提交通知各系统
notify_sys_task_submit(Task, Status) ->
	notify_activity_degree(Task, Status),
	notify_guild_task(Task#task.type, Task#task.id, Status),
	% 通知成就
	mod_achievement:notify_achi(submit_task, [{no, Task#task.id}], Status),
	% 完成指定任务通知成就
	mod_achievement:notify_achi(submit_task_ex, [{no, Task#task.type}], Status),
	% 带领队员完成捕星任务通知成就
	case player:is_in_team(Status) andalso player:is_leader(Status) of
		true ->
			mod_achievement:notify_achi(submit_task_tl, [{no, Task#task.type}], Status);
		false ->
			skip
	end,

	% 通知历练系统
	?DEBUG_MSG("------------- notify_sys_task_submit --------------~p~n", [Task#task.id]),
	mod_chapter_target:notify_lilian(Status, Task),

	% 通知任务
	lib_event:event(submit_type_task, [Task#task.type, 1], Status),
	ok.


%% 根据任务类型通知活跃度系统
notify_activity_degree(Task, Status) ->
	Sys = 
		case Task#task.type of
			3 -> ?AD_TASK_GUILD;
			4 -> ?AD_TASK_FACTION;
			6 -> ?AD_TASK_GHOST;
			7 -> ?AD_TASK_TREASURE_MAP;
			8 ->
				%% 这类型的任务要做个判断，如果是存在多任务类型的ad类型的就走publ_add接口，否则就走单任务
				lib_activity_degree:get_sys_by_task_id(Task#task.id);
			_ -> skip
		end,
	?BIN_PRED(is_integer(Sys), 
		lib_activity_degree:publ_add_sys_activity_times(Sys, Status), 
		lib_activity_degree:add_sys_times_activity_task(Task#task.id, Status)).

notify_guild_task(?TASK_GUILD_TYPE, TaskId, Status) ->
	ply_guild:on_player_finish_guild_task(Status, TaskId);
notify_guild_task(_, _, _) -> skip.



%% 使任务进度完成
publ_make_task_finish(TaskId, Status) ->
	gen_server:cast(player:get_pid(Status), {apply_cast, ?MODULE, make_task_finish, [TaskId, player:id(Status)]}).

make_task_finish(TaskId, RoleId) ->
	case get_accepted(TaskId) of
		null -> skip;
		RoleTask -> 
			NewRoleTask = make_task_finish_1(RoleTask),
			update_accepted(NewRoleTask),
			refresh_task(NewRoleTask, RoleId)
	end.

make_task_finish_1(RoleTask) ->
	NewMark = [[1, Event, Target, EndNum, EndNum | Left] || [_, Event, Target, _, EndNum | Left] <- RoleTask#role_task.mark],
	RoleTask#role_task{state = ?TASK_COMPLETED, mark = NewMark}.


%% 通知任务事件
notify_task_event(TaskId, EventType, Status) ->
	% ?LDS_TRACE("2222222 notify_task_event", [EventType,  TaskId]),
	lib_event:event(EventType, [TaskId], Status).

%% 清除副本类型任务


% publ_clean_all_in_dungeon_task(RoleId)

% publ_clean_all_dungeon_task(Status) when is_record(Status, player_status) ->
% 	case player:is_in_dungeon(Status) of
% 		{true, _} -> skip;
% 		false -> publ_clean_all_dungeon_task(player:id(Status))
% 	end;

publ_clean_all_dungeon_task(RoleId) when is_integer(RoleId) ->
	gen_server:cast(player:get_pid(RoleId), {apply_cast, ?MODULE, clean_all_dungeon_task, [RoleId]}).

% clean_all_dungeon_task(Status) when is_record(Status, player_status) ->
% 	case player:is_in_dungeon(Status) of
% 		{true, _} -> skip;
% 		false -> clean_all_dungeon_task(player:id(Status))
% 	end;

clean_all_dungeon_task(RoleId) ->
	%% 清除所有已接任务
	Status = player:get_PS(RoleId),
	case player:is_in_dungeon(Status) of
		false ->
			AptList = get_accepted_list(),
			% ?LDS_TRACE("clean_all_dungeon_task !!!!!!!!!!!!!!!", [AptList]),
			F1 = fun(TaskId) ->
					Task = data_task:get(TaskId),
					case Task#task.type =:= ?TASK_DUNGEON_TYPE of
						true -> abandon(TaskId, Status);
						false -> skip
					end
				end,
			lists:foreach(F1, AptList),

			%% 清除已做副本任务记录
			DunTaskIdList = data_task:get_dungeon_task_ids(),
			F2 = fun(TaskId) ->
					case get_repeat_completed(TaskId) of
						null -> skip;
						Rd when is_record(Rd, completed) -> 
							del_completed(Rd),
							cache_task_operation(delete, Rd);
						_ -> ?ASSERT(false), skip
					end
				end,
			lists:foreach(F2, DunTaskIdList),
			%% 重新推送任务内容
			lib_task:send_trigger_msg_no_compare(Status),
			pp_task:handle(30002, Status, []);
		_ -> 
			%% 重新推送任务内容
			lib_task:send_trigger_msg_no_compare(Status),
			pp_task:handle(30002, Status, [])
	end.

	


%% 队长向队员广播提交任务
broadcast_member_to_submit_task(TaskId, Status) ->
	case player:is_leader(Status) of
		true -> 
			CaptainId = player:id(Status),
			TeamId = player:get_team_id(Status),
			MemberList = mod_team:get_normal_member_id_list(TeamId),
			[broadcast_member_to_submit_task_1(TaskId, RoleId) || RoleId <- MemberList, RoleId =/= CaptainId];
		false -> ?ASSERT(false)
	end.


broadcast_member_to_submit_task_1(TaskId, RoleId) ->
	{ok, BinData} = pt_30:write(30011, [TaskId]),
    lib_send:send_to_uid(RoleId, BinData).


faction_condition(TaskId, Status) ->
	Task = data_task:get(TaskId),
	[[Action | _] | _] = Task#task.content,
	case Action =:= join_faction of
		true -> player:get_faction(Status) =/= ?FACTION_NONE;
		false -> true
	end.


get_task_hard_lv(TaskId) ->
	Task = data_task:get(TaskId),
	[{Hard, _} | _] = Task#task.reward,
	Hard.


get_task_lv(TaskId) ->
	Task = data_task:get(TaskId),
	Task#task.lv.


publ_can_item_task_accept(TaskId, RoleId) when is_integer(RoleId) ->
	case player:get_PS(RoleId) of
		Status when is_record(Status, player_status) -> publ_can_item_task_accept(TaskId, Status);
		_ -> false
	end;
publ_can_item_task_accept(TaskId, Status) when is_record(Status, player_status) ->
	RoleId = player:id(Status),
	case get_task_flag() of
		RoleId -> can_item_task_accept(RoleId, TaskId);
		_ ->
			Pid = player:get_pid(Status),
			case erlang:is_pid(Pid) andalso erlang:is_process_alive(Pid) andalso Pid =/= self() of
				true ->
					case catch gen_server:call(Pid, {apply_call, ?MODULE, can_item_task_accept, [RoleId, TaskId]}, 2000) of
						R when is_boolean(R) -> R;
						Err -> ?ERROR_MSG("can_item_task_accept ERROR = ~p~n", [Err]), false
					end;
				false ->
					false
			end
	end;
publ_can_item_task_accept(_, _) -> ?ASSERT(false), false.


publ_is_fail(TaskId, RoleId) when is_integer(RoleId) ->
	case player:get_PS(RoleId) of
		Status when is_record(Status, player_status) -> publ_is_fail(TaskId, Status);
		_ -> false
	end;
publ_is_fail(TaskId, Status) when is_record(Status, player_status) ->
	RoleId = player:id(Status),
	case get_task_flag() of
		RoleId -> is_task_fail(TaskId);
		_ ->
			Pid = player:get_pid(Status),
			case erlang:is_pid(Pid) andalso erlang:is_process_alive(Pid) andalso Pid =/= self() of
				true ->
					case catch gen_server:call(Pid, {apply_call, ?MODULE, is_task_fail, [TaskId]}, 2000) of
						R when is_boolean(R) -> R;
						Err -> ?ERROR_MSG("is_task_fail ERROR = ~p~n", [Err]), false
					end;
				false ->
					false
			end
	end;
publ_is_fail(_, _) -> ?ASSERT(false), false.


publ_is_submit(TaskId, RoleId) when is_integer(RoleId) ->
	case player:get_PS(RoleId) of
		Status when is_record(Status, player_status) -> publ_is_submit(TaskId, Status);
		_ -> false
	end;
publ_is_submit(TaskId, Status) when is_record(Status, player_status) ->
	RoleId = player:id(Status),
	case get_task_flag() of
		RoleId -> is_task_submit(TaskId, Status);
		_ ->
			Pid = player:get_pid(Status),
			case erlang:is_pid(Pid) andalso erlang:is_process_alive(Pid) andalso Pid =/= self() of
				true ->
					case catch gen_server:call(Pid, {apply_call, ?MODULE, is_task_submit, [TaskId, Status]}, 2000) of
						R when is_boolean(R) -> R;
						Err -> ?ERROR_MSG("is_task_submit ERROR = ~p~n", [Err]), false
					end;
				false ->
					false
			end
	end;
publ_is_submit(_, _) -> ?ASSERT(false), false.


publ_is_completed(TaskId, RoleId) when is_integer(RoleId) ->
	case player:get_PS(RoleId) of
		Status when is_record(Status, player_status) -> publ_is_completed(TaskId, Status);
		_ -> false
	end;
publ_is_completed(TaskId, Status) when is_record(Status, player_status) ->
	RoleId = player:id(Status),
	case get_task_flag() of
		RoleId -> is_task_completed(TaskId);
		_ ->
			Pid = player:get_pid(Status),
			case erlang:is_pid(Pid) andalso erlang:is_process_alive(Pid) andalso Pid =/= self() of
				true ->
					case catch gen_server:call(Pid, {apply_call, ?MODULE, is_task_completed, [TaskId]}, 2000) of
						R when is_boolean(R) -> R;
						Err -> ?ERROR_MSG("is_task_completed ERROR = ~p~n", [Err]), false
					end;
				false ->
					false
			end
	end;
publ_is_completed(_, _) -> ?ASSERT(false), false.


publ_is_can_accept(TaskId, RoleId) when is_integer(RoleId) ->
	case player:get_PS(RoleId) of
		Status when is_record(Status, player_status) -> publ_is_can_accept(TaskId, Status);
		_ -> false
	end;
publ_is_can_accept(TaskId, Status) when is_record(Status, player_status) ->
	RoleId = player:id(Status),
	case get_task_flag() of
		RoleId -> is_task_can_accepted(TaskId, Status);
		_ ->	
			Pid = player:get_pid(Status),
			case erlang:is_pid(Pid) andalso erlang:is_process_alive(Pid) andalso Pid =/= self() of
				true ->
					case catch gen_server:call(Pid, {apply_call, ?MODULE, is_task_can_accepted, [TaskId, Status]}, 2000) of
						R when is_boolean(R) -> R;
						Err -> ?ERROR_MSG("publ_is_task_can_accept ERROR = ~p~n", [Err]), false
					end;
				false ->
					false
			end
	end;
publ_is_can_accept(_, _) -> ?ASSERT(false), false.


publ_is_accepted(TaskId, Id) when is_integer(Id) ->
	case player:get_PS(Id) of
		Status when is_record(Status, player_status) -> publ_is_accepted(TaskId, Status);
		_ -> false
	end;
publ_is_accepted(TaskId, Status) when is_record(Status, player_status) ->
	Id = player:id(Status),
	case get_task_flag() of
		Id -> is_task_accepted(TaskId);
		_ ->
			Pid = player:get_pid(Status),
			case erlang:is_pid(Pid) andalso erlang:is_process_alive(Pid) andalso Pid =/= self() of
				true ->
					case catch gen_server:call(Pid, {apply_call, ?MODULE, is_task_accepted, [TaskId]}, 5000) of
						R when is_boolean(R) -> R;
						Err -> ?ERROR_MSG("is_task_accepted ERROR = ~p~n", [Err]), false
					end;
				_ -> false
			end
	end;
publ_is_accepted(_T, _S) -> false.


publ_is_accepted_no_complete(TaskId, Id) when is_integer(Id) ->
	case player:get_PS(Id) of
		Status when is_record(Status, player_status) -> publ_is_accepted_no_complete(TaskId, Status);
		_ -> false
	end;
publ_is_accepted_no_complete(TaskId, Status) when is_record(Status, player_status) ->
	Id = player:id(Status),
	case get_task_flag() of
		Id -> is_accepted_no_complete(TaskId);
		_ ->
			Pid = player:get_pid(Status),
			case erlang:is_pid(Pid) andalso erlang:is_process_alive(Pid) andalso Pid =/= self() of
				true ->
					case catch gen_server:call(Pid, {apply_call, ?MODULE, is_accepted_no_complete, [TaskId]}, 2000) of
						R when is_boolean(R) -> R;
						Err -> ?ERROR_MSG("is_accepted_no_complete ERROR = ~p~n", [Err]), false
					end;
				false ->
					false
			end
	end;
publ_is_accepted_no_complete(_, _) -> ?ASSERT(false), false. 


publ_is_accepted_no_complete_list(Id) when is_integer(Id) ->
	case player:get_PS(Id) of
		Status when is_record(Status, player_status) -> publ_is_accepted_no_complete_list(Status);
		_ -> false
	end;
publ_is_accepted_no_complete_list(Status) when is_record(Status, player_status) ->
	Id = player:id(Status),
	case get_task_flag() of
		Id -> is_accepted_no_complete_list();
		_ ->
			Pid = player:get_pid(Status),
			case erlang:is_pid(Pid) andalso erlang:is_process_alive(Pid) andalso Pid =/= self() of
				true ->
					case catch gen_server:call(Pid, {apply_call, ?MODULE, is_accepted_no_complete_list, []}, 2000) of
						R when is_boolean(R) -> R;
						Err -> ?ERROR_MSG("is_accepted_no_complete_list ERROR = ~p~n", [Err]), false
					end;
				false ->
					false
			end
	end;
publ_is_accepted_no_complete_list(_) -> ?ASSERT(false), false.


handle_task_timeout(TaskId, TimeStamp, Status) ->
	case get_accepted(TaskId) of
		Task when is_record(Task, role_task) -> 
			case is_task_finish(Task) orelse Task#role_task.accept_time =/= TimeStamp of
				true -> skip;
				false -> make_fail(Task, Status)
			end;
		_ -> skip
	end.


%% 重新开始检查任务是否过期
start_task_timer(RoleTask) when RoleTask#role_task.state =:= ?TASK_ACCEPTED ->
	TaskId = RoleTask#role_task.id,
	Task = data_task:get(TaskId),
	Time = Task#task.time_limit,
	%增加师门挑战任务
	case is_faction_fight_task(TaskId) of
		true ->
			CurTime = util:unixtime(),
			AcceptTime1 = RoleTask#role_task.accept_time,
			case util:is_timestamp_same_day(AcceptTime1, CurTime) of
				true ->
					Timing1 = 24 * 60 * 60 - util:get_seconds_from_midnight(CurTime),
					Ref1 = erlang:start_timer(Timing1 * 1000, self(), {timer_task, Task#task.id, RoleTask#role_task.accept_time}),
								add_timing_ref(Ref1);
				false ->
					Timing2 = 1,
					Ref2 = erlang:start_timer(Timing2 * 1000, self(), {timer_task, Task#task.id, RoleTask#role_task.accept_time}),
								add_timing_ref(Ref2)
			end;
		false ->
			case Time =:= 0 of
				true -> skip;
				false ->
					%增加
					Now = util:unixtime(),
					AcceptTime = RoleTask#role_task.accept_time,
					Timing = AcceptTime + Time - Now,
					case Timing > 0 of
						true -> Ref = erlang:start_timer(Timing * 1000, self(), {timer_task, Task#task.id, RoleTask#role_task.accept_time}),
								add_timing_ref(Ref);
						false -> skip
					end
			end
	end;
start_task_timer(_) -> skip.


%% @doc 加载任务数据
%% @end
load_task_data(Status) ->
	RoleId = player:id(Status),
	load_accepted_task(Status),
	load_completed_task(RoleId),
	refresh_base_task_set(trigger_task, Status),
	refresh_time_limit_task_set(trigger_task, Status).


%% @doc 取得触发任务状态列表
%% @return [{task_id, state}]
%% @end
get_trigger_base_tasks_state(Status) ->
	OldTriggerList = get_trigger(),
	case player:is_in_dungeon(Status) of
		{true, _} ->
			%% 玩家在副本里，触发副本任务?
			trigger_dungeon_task(Status, OldTriggerList);
		false -> 
			% ?LDS_TRACE(get_trigger_base_tasks_state, trigger_unrepeat_task(Status, OldTriggerList)),
			trigger_repeate_task(Status, OldTriggerList) ++ trigger_ring_task(Status, OldTriggerList) ++ trigger_unrepeat_task(Status, OldTriggerList)
	end.

trigger_dungeon_task(Status, OldTriggerList) ->
	case player:get_dungeon_no(Status) of
		null -> ?ASSERT(false, [Status]), [];
		DunNo -> 
			case data_task:get_dun_classify_task(DunNo) of
				null -> [];
				DunNoList -> 
					[{TaskId, can_trigger(?DUNGEON_TASK_TYPE, TaskId, Status, OldTriggerList)} || TaskId <- DunNoList]
			end
	end.

trigger_unrepeat_task(Status, OldTriggerList) ->
	List = [{Type, data_task:get_classify_task(Type)} || Type <- ?UNREPEAT_TASK_TYPES],
	lists:flatten(trigger_unrepeat_task(Status, OldTriggerList, List, [])).

trigger_unrepeat_task(_Status, _OldTriggerList, [], Count) -> Count;
trigger_unrepeat_task(Status, OldTriggerList, [{Type, List} | Left], Count) ->
	% NewTrigger = 
	case get_unrepeat_completed(Type) of
		null ->
			?ASSERT(false),
			trigger_unrepeat_task(Status, OldTriggerList, Left, Count);
		Completed ->
			TaskId = Completed#completed_unrepeat.id,
			Faction = player:get_faction(Status),
			case get_next_id(TaskId, List, Faction) of
				null -> trigger_unrepeat_task(Status, OldTriggerList, Left, Count);
				NextList ->
					Trigger = [{NextId, can_trigger(?UNREPEAT_TASK_TYPE, NextId, Status, OldTriggerList)} || NextId <- NextList],
					NewTrigger = [{NewId, State} || {NewId, State} <- Trigger, State =:= ?TASK_TRIGGER orelse State =:= ?TASK_CAN_ACCEPT],
					trigger_unrepeat_task(Status, OldTriggerList, Left, [NewTrigger | Count])
			end
	end.
	% trigger_unrepeat_task(Status, OldTriggerList, Left, [NewTrigger | Count]).


trigger_repeate_task(Status, OldTriggerList) ->
	List = lists:flatten([data_task:get_classify_task(Type) || Type <- ?REPEAT_TASK_TYPES]),
	Trigger = [{TaskId, can_trigger(?REPEAT_TASK_TYPE, TaskId, Status, OldTriggerList)} || TaskId <- List],
	[{NewId, State} || {NewId, State} <- Trigger, State =:= ?TASK_TRIGGER orelse State =:= ?TASK_CAN_ACCEPT].


trigger_ring_task(Status, OldTriggerList) ->
	List = data_task:get_ring_head_ids(),
	Trigger = [{TaskId, can_trigger(?RING_TASK_TYPE, TaskId, Status, OldTriggerList)} || TaskId <- List],

	% ?LDS_TRACE(trigger_ring_task, Trigger),
	?DEBUG_MSG("wjctesttask3 ~p~n",[Trigger]),
	[{NewId, State} || {NewId, State} <- Trigger, State =:= ?TASK_TRIGGER orelse State =:= ?TASK_CAN_ACCEPT].



%% @return null | list()
% get_next_id(0, []) -> null;
% get_next_id(0, [TaskId | _]) -> [TaskId];
% get_next_id(_Id, []) -> null;
% get_next_id(_Id, [_]) -> null;
% get_next_id(Id, [Id | Left]) -> Left;
% get_next_id(Id, [_ | Left]) -> get_next_id(Id, Left).

get_next_id(0, [], _Faction) -> null;
get_next_id(0, List0, Faction) ->
	%% 最开始的门派主线不同，所以这里不能简单取最小那个？要根据门派来取20191210 zjy
	Pred = fun(TaskId) ->
				   case data_task:get(TaskId) of
					   #task{career = Faction} ->
						   true;
					   _ ->
						   false
				   end
		   end,
	List = lists:filter(Pred, List0),
	[TaskId | _] = lists:sort(List),
	[TaskId];
get_next_id(Id, _, _Faction) ->
	case data_task:get(Id) of
		Task when is_record(Task, task) ->
			?BIN_PRED(Task#task.next =:= [], null, Task#task.next);
		_ -> ?ASSERT(false, [Id]), null
	end.
	

get_task_trigger_type(TaskType) ->
	get_task_trigger_type_1(TaskType, [{?UNREPEAT_TASK_TYPE, ?UNREPEAT_TASK_TYPES}, {?REPEAT_TASK_TYPE, ?REPEAT_TASK_TYPES}, 
		{?RING_TASK_TYPE, ?RING_TASK_TYPES}, {?DUNGEON_TASK_TYPE, ?DUNGEON_TASK_TYPES}]).


get_task_trigger_type_1(_Type, []) -> ?ASSERT(false, [_Type]), 0;
get_task_trigger_type_1(Type, [{TriggerType, List} | Left]) ->
	case lists:member(Type, List) of
		true -> TriggerType;
		false -> get_task_trigger_type_1(Type, Left)
	end.


can_trigger(Type, TaskId, Status, OldTriggerList) when is_integer(TaskId) andalso TaskId > 0 ->
	case data_task:get(TaskId) of
		Task when is_record(Task, task) -> can_trigger(Type, Task, Status, OldTriggerList);
		_ -> ?ASSERT(false, [TaskId]), ?TASK_CANT_TRIGGER
	end;
can_trigger(Type, Task, Status, OldTriggerList) when is_record(Task, task) -> 
	State = can_trigger(Type, Task, Status),
	case State of
		?TASK_CAN_ACCEPT -> check_auto_trigger(Task, Status, OldTriggerList);
		_ -> skip
	end,
	State;
can_trigger(_, _Task, _, _) -> ?TASK_CANT_TRIGGER.


 

% get_trigger_base_tasks_state(Status) ->
% 	AllList = data_task:get_ids(),
% 	FinUnrepList = get_completed_list(unrepeat),
% 	AcceptList = get_accepted_list(),
% 	CheckList = lists:subtract(lists:subtract(AllList, FinUnrepList), AcceptList),
% 	OldTriggerList = get_trigger(),
% 	case player:is_in_dungeon(Status) of
% 		{true, _} ->
% 			DunNo = player:get_dungeon_no(Status),
			
% 			[{TaskId, can_trigger(TaskId, Status, OldTriggerList)} || TaskId <- CheckList, (data_task:get(TaskId))#task.dun_no =:= DunNo];
% 		false -> 
% 			[{TaskId, can_trigger(TaskId, Status, OldTriggerList)} || TaskId <- CheckList, (data_task:get(TaskId))#task.type =/= ?TASK_DUNGEON_TYPE]
% 	end.
% get_trigger_base_tasks_state(Status) ->
% 	case player:is_in_dungeon(Status) of
% 		{true, _} ->
% 			DunNo = player:get_dungeon_no(Status),
% 			[{TaskId, can_trigger(TaskId, Status)} || TaskId <- data_task:get_classify_task(DunNo)];
% 		false ->
% 			CheckList = data_task:get_classify_task(?DEF_CLASSIFY),
% 			todo,
% 			[{TaskId, can_trigger(TaskId, Status)} || TaskId <- CheckList]
% 	end.


%% @doc 刷新基本类型触发任务
%% @spec
%% @end
refresh_base_task_set(trigger_task, Status) ->
	List = get_trigger_base_tasks_state(Status),
	?DEBUG_MSG("wujianchengtesttask ~p",[List]),
	% ?LDS_TRACE(refresh_base_task_set, List),
	Trigger = [{Id, State} || {Id, State} <- List, 
				State =:= ?TASK_TRIGGER orelse State =:= ?TASK_CAN_ACCEPT],
	set_trigger(Trigger),
	CanAccept = [Id || {Id, State} <- List, State =:= ?TASK_CAN_ACCEPT],
	notify_trigger_event(CanAccept, Status),
	ok.


notify_trigger_event([], _) -> skip;
notify_trigger_event([Id | Left], Status) ->
	lib_event:event(?TASK_CAN_ACCEPT_EVENT, [Id], Status),
	notify_trigger_event(Left, Status).


%% @doc 刷新时间期限上架类型触发任务
%% @spec
%% @end
refresh_time_limit_task_set(trigger_task, _Status) ->
	redo,
	ok.


% 提交任务时环任务处理
ring_task_submit(TaskId) ->
	Task = data_task:get(TaskId),
	case Task#task.ring of
		0 -> skip;
		{MasterId, RingCount, _, _Times, _} ->
			%% 解除环任务标志
			release_ring_task_falg(Task),
			case get_task_ring(MasterId) of
				null ->
					?ASSERT(false),
					?ERROR_MSG("task ring_task_submit error taskId = ~p~n", [TaskId]);
				RingRd -> 
					{Ring,Times} = 
					case RingRd#task_ring.ring + 1 > RingCount of
						false ->
							{RingRd#task_ring.ring + 1,
							RingRd#task_ring.times};
						true -> 
							{RingRd#task_ring.ring - RingCount + 1,
							RingRd#task_ring.times + 1}
					end,

					update_task_ring(MasterId, 
						RingRd#task_ring{ring = Ring,times = Times, seed = rand_task_seed()})
			end
			
	end.


%% 取得类型环任务的次数
get_ring_task_cur_times(TaskIdList, _Timestamp, Status) ->
	get_ring_task_cur_times_1(lists:sort(TaskIdList), Status).


get_ring_task_cur_times_1([], _) -> 0;
get_ring_task_cur_times_1([TaskId | Left], Status) ->
	% case is_task_can_accepted(TaskId, Status) of
	% 	true -> 
	% 		{Step, Ring} = get_current_setp_and_round(TaskId),
	% 		get_ring_task_cur_times_1(Left, Status, Step * Ring);
	% 	false -> Acc
	% end.
	case data_task:get(TaskId) of
		Task when is_record(Task, task) ->
			case Task#task.ring of
				{_, RingCount, _, _, _} ->
					case is_fit_can_accept_lv(player:get_lv(Status), Task#task.lv, Task#task.lv_limit) andalso is_task_classify(Task, Status) of
						true -> 
							{Step, Ring} = get_current_setp_and_round(TaskId),
							(Ring - 1) * RingCount + Step - 1;
						false -> 
							get_ring_task_cur_times_1(Left, Status)
					end;
				_ -> get_ring_task_cur_times_1(Left, Status)
			end;
		_ -> get_ring_task_cur_times_1(Left, Status)
	end.


get_ring_task_max_times([TaskId | _], _Status) ->
	case data_task:get(TaskId) of
		Task when is_record(Task, task) ->
			case Task#task.ring of
				{TaskId, RingCount, _RanCount, TimesCount, _} -> RingCount * TimesCount;
				_ -> 0
			end;
		_ -> 0
	end.

get_task_cur_times(TaskId, _Timestamp, _Status) ->
	case data_task:get(TaskId) of
		Task when is_record(Task, task) ->
			case get_repeat_completed(TaskId) of
				null -> 0;
				Rd -> 
					NowDate = get_now_date(),
					if  Task#task.day_task =/= 0 -> ?BIN_PRED(NowDate =:= Rd#completed.date, Rd#completed.times, 0);
						Task#task.week_task =/= 0 -> ?BIN_PRED(is_week_round(Rd#completed.date, NowDate, Task#task.week_task), Rd#completed.date, 0);
						true -> Rd#completed.times
					end
			end;
		_ -> 0
	end.

get_task_max_times(TaskId, _Status) ->
	case data_task:get(TaskId) of
		Task when is_record(Task, task) -> Task#task.repeat;
		_ -> 0
	end.


%% @doc 取得任务数据
%% @return {[触发列表]， [可接受列表]， [已接列表]， [完成列表]}
%% @end
% get_task_list(RoleId) ->
% 	{get_trigger(),
% 	 get_can_accept_list(RoleId),
% 	 get_accepted_list(RoleId),
% 	 get_completed_list(RoleId)}.


send_trigger_msg(Status) ->
	OldList = get_client_trigger(),
	trigger(Status),
	TriggerList = get_client_trigger(),
	case OldList =:= TriggerList of
		true ->
			skip;
		false ->
			% ?LDS_TRACE("30001_send_trigger_msg", [TriggerList, ?MODULE]),
			{ok, BinData} = pt_30:write(30001, [TriggerList]),
    		lib_send:send_to_sock(Status, BinData)
	end.


send_trigger_msg_no_compare(Status) ->
 	trigger(Status),
	TriggerList1 = get_client_trigger(),
	Predicate = fun([TaskID,_A,_B,_C,_D,_E]) -> not(TaskID =:= 1200022 orelse TaskID =:= 1200023)  end, 
	TriggerList = lists:filter(Predicate, TriggerList1),
    % ?LDS_TRACE("30001_send_trigger_msg", [TriggerList]),
	{ok, BinData} = pt_30:write(30001, [TriggerList]),
    lib_send:send_to_sock(Status, BinData).


%% @doc 取得客户端任务触发数据
get_client_trigger() ->
	Trigger = get_trigger(),
	[package_task_data(trigger, [TaskId, State]) || {TaskId, State} <- Trigger].

%% 跨服情况下由于npc都是固定的，所以直接当作本地处理?
get_client_trigger_by_npc(NpcId) ->
	Trigger = get_trigger(),
	F = fun({TaskId, State}, Sum) ->
			Task = data_task:get(TaskId),
			case Task#task.start_npc =:= NpcId of
				true -> 
					SceneId = get_npc_scene_id(NpcId),
					{Step, Ring} = get_current_setp_and_round(TaskId),
					[[TaskId, State, NpcId, SceneId, Step, Ring] | Sum];
				false -> Sum
			end
		end,
	lists:foldl(F, [], Trigger).


%% @doc 取得客户端已接任务数据
get_client_accepted(Status) ->
	Accepted = get_accepted_list(),
	% ?LDS_TRACE("!!!!!!!!!!!!!!!!!!!!!!! get_client_accepted", player:get_dungeon_no(Status)),
	case player:get_dungeon_no(Status) of
		null ->	[package_task_data(accepted, [TaskId]) || TaskId <- Accepted];
		No -> [package_task_data(accepted, [TaskId]) || TaskId <- Accepted, (data_task:get(TaskId))#task.dun_no =:= No]
	end.
	

%% ------------------------------- 通知接口 -----------------------------

%% 通知队员提交任务
notify_member_submit(TaskId, ItemIdList, Status) ->
	Task = data_task:get(TaskId),
	%% 如果team是0的话也是有可能的，那么判断条件为不等于1
	case Task#task.team > 1 of
		true ->
			case player:is_leader(Status) andalso Task#task.team > 1 of
				true -> 
					CaptainId = player:id(Status),
					TeamId = player:get_team_id(Status),
					MemberList = mod_team:get_normal_member_id_list(TeamId),
					[broadcast_member_force_submit_task(TaskId, ItemIdList, RoleId) || RoleId <- MemberList, RoleId =/= CaptainId];
				false -> skip
			end;
		false -> skip
	end.

broadcast_member_force_submit_task(TaskId, ItemIdList, RoleId) ->
	gen_server:cast(player:get_pid(RoleId), {'force_submit_task', TaskId, ItemIdList}).


%% 通知所有玩家刷新任务触发
notify_refresh_daily() ->
	PidList = mod_svr_mgr:get_all_online_player_pids(),
	% ?DEBUG_MSG("notify_refresh_daily ~p", [PidList]),
	[gen_server:cast(Pid, 'task_refresh_daily') || Pid <- PidList, is_pid(Pid)].


notify_refresh_hourly() ->
	PidList = mod_svr_mgr:get_all_online_player_pids(),
	F = fun() ->
			[gen_server:cast(Pid, 'task_refresh_hourly') || Pid <- PidList, is_pid(Pid)]
		end,
	spawn(F).


%% 任务事件通知
accept_handle(EventType, Args, Status) ->
	% ?LDS_TRACE(accept_handle, [EventType, Args]),
	gen_server:cast( player:get_pid(Status), {'task_event', [EventType, Args]}).


%% @doc handle all task event
accept_handle_apply(EventType, Args, Status) ->
	%% 这里涉及任务的完成等事件，判断是否跨服节点玩家的镜像进程，然后cast回去，目前的判断方法是暂定的，考虑是否有更好的办法
	case lib_cross:check_is_mirror() of
		?true ->
			PlayerId = player:get_id(Status),
			ServerId = player:get_server_id(Status),
			sm_cross_server:rpc_cast(ServerId, lib_cross, player_msg_cast, [PlayerId, {'task_event', [EventType, Args]}]);
		?false ->
			AcceptList = get_accepted_list(),
			?DEBUG_MSG("wujianchengTestachiTask ~p~n",[AcceptList]),
			F = fun(TaskId) ->
						handle_event(EventType, Args, get_accepted(TaskId), Status)
				end,
			lists:foreach(F, AcceptList)
	end.


%% @doc 自动接任务事件触发
%% @end
% check_auto_task(Pid) when is_pid(Pid) ->
% 	gen_server:cast(Pid, 'check_auto_task').

% auto_task_event(Status) ->
% 	%% 检测数值是否达标
% 	case check_value(Status) of
% 		[] -> skip;
% 		TaskList ->
% 			[auto_accept(TaskId, Status) || TaskId <- TaskList]
% 	end.


%% @doc刷新任务内容
%% @end
refresh_task(Task, RoleId) when is_record(Task, role_task) ->
	% ?LDS_TRACE(30006, [Task#role_task.id]),
	Data = package_task_data(accepted, [Task]),
	{ok, PackData} = pt_30:write(30006, [Data]),
	lib_send:send_to_uid(RoleId, PackData);
refresh_task(TaskId, Status) when is_integer(TaskId) ->
	case is_task_accepted(TaskId) of
		true ->
			% ?LDS_TRACE(30006, [TaskId]),
			Data = package_task_data(accepted, [TaskId]),
			{ok, PackData} = pt_30:write(30006, [Data]),
			lib_send:send_to_sock(Status, PackData);
		false -> 
			% 任务不存在，从新推送新任务
			pp_task:handle(30002, Status, [])
			% ?ERROR_MSG("refresh_task ~p, ~p~n", [TaskId, 30006]),
			% ?ASSERT(false),
			% skip
	end;
refresh_task(_, _) -> skip.


%% ====================================================================
%% Internal functions
%% ====================================================================

%% 接取环任务时随机抽取任务
%% Task :: #task{}
%% @return new #task{} | null
accept_ring_task(Task) when Task#task.ring =:= 0 -> Task;
accept_ring_task(Task) ->
	case get_task_ring(Task#task.id) of
		null -> 
			?ERROR_MSG("task_ring accept_ring_task = ~p~n", [Task#task.id]),
			?ASSERT(false),
			null;
		RingTask ->
			case  Task#task.id of
				1300008 -> case RingTask#task_ring.ring  of 
							   10 ->  data_task:get(1300018);
							   _  ->  
								   {TaskId, _, TaskCount, _, _} = Task#task.ring,
								   Seed = RingTask#task_ring.seed,
								   NewTaskId = TaskId + (Seed rem (TaskCount - 1)) + 1,
								   CurTaskId = ?BIN_PRED(NewTaskId =:= TaskId, NewTaskId + 1, NewTaskId),
								   data_task:get(CurTaskId)
						   end;
				1300019 -> case RingTask#task_ring.ring  of 
							   10 ->  data_task:get(1300029);
							   _  ->  
								   {TaskId, _, TaskCount, _, _} = Task#task.ring,
								   Seed = RingTask#task_ring.seed,
								   NewTaskId = TaskId + (Seed rem (TaskCount - 1)) + 1,
								   CurTaskId = ?BIN_PRED(NewTaskId =:= TaskId, NewTaskId + 1, NewTaskId),
								   data_task:get(CurTaskId)
						   end;

				_ ->    {TaskId, _, TaskCount, _, _} = Task#task.ring,
						Seed = RingTask#task_ring.seed,
						NewTaskId = TaskId + (Seed rem (TaskCount - 1)) + 1,
						CurTaskId = ?BIN_PRED(NewTaskId =:= TaskId, NewTaskId + 1, NewTaskId),
						data_task:get(CurTaskId)
			end
								   
			
	end.


%% 通知队员领取某任务,队员没有该任务则略过
notify_accept_single_task(TaskId, RoleId) ->
	gen_server:cast(player:get_pid(RoleId), {apply_cast, ?MODULE, notify_member_accept, [TaskId, player:get_PS(RoleId)]}).

%% 队员领取某任务,队员没有该任务则略过
notify_member_accept(TaskId, Status) ->
	case force_accept_condition(TaskId, Status) of
		true -> force_accept(TaskId, Status);
		false -> skip
	end.


%% 队长接取组队任务，判断跨服状态，rpc远程节点一同检查和接取任务
accept_team_task(Task, Status) ->
	TaskId = Task#task.id,
	TeamId = player:get_team_id(Status),
	TeamMember = mod_team:get_normal_member_id_list(TeamId),
	% StateList = [{RoleId, publ_task_accept_state(TaskId, RoleId)} || RoleId <- TeamMember],
	% FailList = [RoleId || {RoleId, State} <- StateList, State =:= false],
	case erlang:length(TeamMember) >= Task#task.team of
		true ->% 队伍人数满足任务接取要求
			%% 新需求，除了抓鬼任务会让队友同时接取任务以外，其余均队长自己接即可 2020-01-03
			case Task#task.type of
				?TASK_GOSHT_TYPE ->
					F = fun(RoleId, Acc) ->
								case publ_task_accept_state(TaskId, RoleId) of
									true -> Acc;
									{false, Err} -> [{RoleId, Err} | Acc]
								end
						end,
					FailList = lists:foldl(F, [], TeamMember),
					case FailList =:= [] of
						true -> notify_member_force_accept(TaskId, TeamMember);
						false -> 
							{ok, BinData} = pt_30:write(30012, [TaskId, FailList]),
							[lib_send:send_to_uid(Uid, BinData) || Uid <- TeamMember]
					end;
				_ ->
					accept(Task, Status)
			end;
		false ->
			{ok, BinData} = pt_30:write(30012, [TaskId, [{player:id(Status), ?NOT_ENOUGH_PEOPLE}]]),
			lib_send:send_to_uid(player:id(Status), BinData)
	end.


%% 判断跨服状态，rpc远程节点一同检查和接取任务
do_accept_task_cross(Task, Status) ->
	TaskId = Task#task.id,
	case player:is_leader(Status) andalso Task#task.type == ?TASK_GOSHT_TYPE  of    %% 只有抓鬼会，其他都是单人任务
		?true ->
			TeamId = player:get_team_id(Status),
			TeamMember = mod_team:get_normal_member_id_list(TeamId),
			case erlang:length(TeamMember) >= Task#task.team of
				true ->
					F = fun(RoleId, Acc) ->
								%% 因为是跨服，所以这里的队员全部是镜像，rpc call回去做检查
								case sm_cross_server:rpc_call(player:get_server_id(player:get_PS(RoleId)), lib_cross, player_apply_call, [RoleId, ?MODULE, publ_task_accept_state, [TaskId, RoleId]]) of
									{ok, true} ->
										Acc;
									{ok, {false, Err}} ->
										[{RoleId, Err}|Acc]
								%% 暂不处理超时情况，让错误暴露出来
								%% 							E ->
								%% 								?ERROR_MSG("rpc call err : ~p~n", [E]),
								%% 								Acc
								%% %% 								[{RoleId, 6}|Acc]
								end
						end,
					FailList = lists:foldl(F, [], TeamMember),
					case FailList =:= [] of
						true ->
							%% call 回去让队长抽取？
							case sm_cross_server:rpc_call(player:get_server_id(Status), lib_cross, player_apply_call, [player:get_id(Status), ?MODULE, accept_ring_task, [data_task:get(TaskId)]]) of
								%% 					   case accept_ring_task(data_task:get(TaskId)) of
								{ok, null} -> ?ASSERT(false);
								{ok, NewTask}-> 
									%% rpc call回去让每个人接取这个任务，在处理刷怪的时候判断是否跨服，跨服的情况cast到跨服节点去处理，还是说单独写一个专用接任务函数？
									Fun = fun(PlayerId) ->
												  case player:is_online(PlayerId) of
													  ?true ->
														  sm_cross_server:rpc_cast(player:get_server_id(player:get_PS(PlayerId)), lib_cross, player_msg_cast, [PlayerId, {'force_accept_task', NewTask#task.id}]);
													  ?false ->
														  skip
												  end
										  end,
									lists:foreach(Fun, TeamMember),
									%% 因为是任务开始事件判断了不处理跨服的状态，所以在这里还要处理一下，还有刷怪的时候要把怪物ID加入任务结构里面，但怪物在跨服，任务在本服，所以要特殊处理
									task_state_event(NewTask#task.start_event, NewTask#task.id, Status)
							
							%% 暂时不处理超时的情况
							end;
						false ->
							{ok, BinData} = pt_30:write(30012, [TaskId, FailList]),
							[lib_send:send_to_uid(Uid, BinData) || Uid <- TeamMember]
					end;
				false ->
					{ok, BinData} = pt_30:write(30012, [TaskId, [{player:id(Status), ?NOT_ENOUGH_PEOPLE}]]),
					lib_send:send_to_uid(player:id(Status), BinData)
			end;
		?false ->
			RoleId = player:id(Status),
			case sm_cross_server:rpc_call(player:get_server_id(Status), lib_cross, player_apply_call, [RoleId, ?MODULE, publ_task_accept_state, [TaskId, RoleId]]) of
				{ok, true} ->
					sm_cross_server:rpc_cast(player:get_server_id(Status), lib_cross, player_msg_cast, [RoleId, {'force_accept_task', TaskId}]),
					task_state_event(Task#task.start_event, TaskId, Status);
				{ok, {false, Err}} ->
					notify_client_task_accept(Err, TaskId, Status)
			end
	end.


accept_task_cross(PlayerId, TaskId) ->
	sm_cross_server:rpc_cast(?MODULE, accept_task_cross_apply, [PlayerId, TaskId]).


accept_task_cross_apply(PlayerId, TaskId) ->
	case data_task:get(TaskId) of
		null -> ?ASSERT(false), skip;
		Task ->
			Status = player:get_PS(PlayerId),
			do_accept_task_cross(Task, Status)
%% 			case player:is_leader(Status) of
%% 				true ->
%% 					case Task#task.team > 1 of
%% 						true ->
%% 							do_accept_task_cross(Task, Status);
%% 						false ->
%% 							lib_send:send_prompt_msg(Status, ?PM_CROSS_BAN_PROTO)
%% 					end;
%% 				false ->
%% 					lib_send:send_prompt_msg(Status, ?PM_NOT_TEAM_LEADER)
%% 			end
	end.
	

%% 强制队员领取某任务
notify_member_force_accept(TaskId, TeamMember) ->
	% NewTask = accept_ring_task(data_task:get(TaskId)),
	case accept_ring_task(data_task:get(TaskId)) of
		null -> ?ASSERT(false);
		NewTask -> [gen_server:cast(player:get_pid(RoleId), {'force_accept_task', NewTask#task.id}) || RoleId <- TeamMember, player:is_online(RoleId)]
	end.


%% @retrun void
del_dynamic_task_mon(TaskId) ->
	case get_accepted(TaskId) of
		Rd when is_record(Rd, role_task) ->
			case Rd#role_task.monNo of
				{_, MonId} when MonId > 0 -> 
					case mod_mon:is_exists(MonId) of
						true ->  mod_scene:clear_mon_from_scene_WNC(MonId);
						_ ->  skip
					end;
				_ -> skip
			end;
		_ -> skip
	end.


%% @doc 处理客户端推送的任务状态信息
-define(EXPLORE, 1).

handle_client_push_info(?EXPLORE, Status) ->
	Pos = player:get_position(Status),
	SceneId = Pos#plyr_pos.scene_id,
	X = Pos#plyr_pos.x,
	Y = Pos#plyr_pos.y,
	% ?LDS_TRACE("export !!!!!!!!!!!!! ", [SceneId, {X, Y}]),
	AcceptList = get_accepted_list(),
	[handle_explore(TaskId, [SceneId, X, Y], player:id(Status)) || 
		TaskId <- AcceptList, is_integer(TaskId)];
handle_client_push_info(_, _) ->
	?ASSERT(false).	


handle_explore(TaskId, [SceneId, X, Y], RoleId) ->
	#role_task{mark = Mark} = Task = get_accepted(TaskId),
	{Flag, NewMark} = handle_explore_mark(Mark, [SceneId, X, Y], 0, []),
	% ?LDS_TRACE(is_in_same_range, [{Flag, NewMark}]),
	case Flag =:= 0 of
		true -> skip;
		false -> 
			NewTask = check_task_finish(Task#role_task{mark = NewMark}, player:get_PS(RoleId)),
			update_accepted(NewTask),
			refresh_task(NewTask, RoleId)
	end.


handle_explore_mark([], _, Count, MarkList) -> {Count, lists:reverse(MarkList)};
handle_explore_mark([[0, go, [OldSceneId, ExpId], _, EndNum | Adr] = Mark | Left],
					 [SceneId, X, Y], Count, MarkList) ->
	case get_explore_area(OldSceneId, ExpId) of
		{ExpId, _OldX, _OldY, _Width, _Height} ->
			%% !!! 暂时屏蔽位置检查
			handle_explore_mark(Left, [SceneId, X, Y], Count + 1, 
						[[1, go, [OldSceneId, ExpId], EndNum, EndNum | Adr] | MarkList]);
			% case is_in_same_range({OldSceneId, OldX, OldY, Width, Height}, {SceneId, X, Y}) of
			% 	true -> 
			% 		handle_explore_mark(Left, [SceneId, X, Y], Count + 1, 
			% 			[[1, go, [OldSceneId, ExpId], EndNum, EndNum | Adr] | MarkList]);
			% 	false ->
			% 		handle_explore_mark(Left, [SceneId, X, Y], Count, [Mark | MarkList])
			% end;
		_ ->
			handle_explore_mark(Left, [SceneId, X, Y], Count, [Mark | MarkList])
	end;
handle_explore_mark([Mark | Left], Pos, Count, MarkList) ->
	handle_explore_mark(Left, Pos, Count, [Mark | MarkList]).

is_in_same_range({SceneId, OldX, OldY, W, H}, {SceneId, X, Y}) ->
	( X >= OldX andalso X =< (OldX + W) ) andalso ( Y >= OldY andalso Y =< (OldY + H) );
is_in_same_range(_, _) -> false.


%% @retrun tuple() | false
get_explore_area(SceneNo, ExpId) ->
	case data_scene:get(SceneNo) of
		Scene when is_record(Scene, scene_tpl) ->
			ExpList = Scene#scene_tpl.explore_area,
			lists:keyfind(ExpId, 1, ExpList);
		_ -> false
	end.


%% @doc 自动接取任务
%% @end
% auto_accept(TaskId, Status) ->
% 	% @redo : need to write in db?
% 	List = get_auto_task_trigger_list(),
% 	case lists:member(TaskId, List) orelse (not get_auto_task_trigger_switch()) of
% 		true -> skip;
% 		false ->
% 			?LDS_TRACE(auto_accept, [TaskId, Status#player_status.dun_info]),
% 			DunTaskIdList = data_task:get_dungeon_task_ids(),
% 			{ok, BinData} = pt_30:write(30007, [TaskId]),
% 			case lists:member(TaskId, DunTaskIdList) of
% 				true -> 
% 					case player:is_in_dungeon(Status) of
% 						false -> skip;
% 						{true, _} -> 
% 							Task = data_task:get(TaskId),
% 							case Task#task.dun_no =:= player:get_dungeon_no(Status) of
% 								true ->
% 									?LDS_TRACE("send dun 30007 !!!!!!!!!", [TaskId]),
% 									add_auto_task_trigger(List, TaskId),
% 				    				lib_send:send_to_sock(Status, BinData);
% 				    			false -> skip
% 				    		end
% 		    		end;
% 		    	false ->
% 		    		case player:is_in_dungeon(Status) of
% 		    			false ->
% 		    				?LDS_TRACE("send out of dun 30007 !!!!!!!!!!!!", [TaskId]),
% 		    				add_auto_task_trigger(List, TaskId),
% 		    				lib_send:send_to_sock(Status, BinData);
% 		    			{true, _} -> skip
% 		    		end
% 		    end
% 	end.


% check_value(Status) ->
% 	List = data_task:get_auto_ids(),
% 	F = fun(TaskId, Sum) ->
% 			case can_trigger(TaskId, Status) of
% 				?TASK_CAN_ACCEPT ->
% 					[TaskId | Sum];
% 				_ -> Sum
% 			end
% 		end,
% 	lists:foldl(F, [], List).


%% @doc 处理任务事件
%% @end
handle_event(EventType, Args, Task, Status) when Task#role_task.state =:= ?TASK_ACCEPTED ->
	% ?LDS_TRACE(handle_event, [EventType, Args, Task#role_task.mark]),
	{Flag, NewMark} = check_mark_update(Task#role_task.mark, EventType, Args),
	io:format("888888888888888888 EventType, Args, Flag : ~p~n", [{?MODULE, ?LINE, EventType, Args, Flag}]),
	if
		Flag =:= 0 -> skip;
		true ->
			TmpTask = Task#role_task{mark = NewMark},
			NewTask = check_task_finish(TmpTask, Status),
			update_accepted(NewTask),
			refresh_task(NewTask, player:id(Status))
	end;
handle_event(_, _, _, _) -> skip.

check_mark_update(Mark, EventType, Args) ->
	check_mark_update(Mark, EventType, Args, 0, []).

check_mark_update([], _, _, Count, List) ->
	{Count, lists:reverse(List)};
check_mark_update([[0, EventType | _] = Item | Left] = _Mark, EventType, Args, Count, List) ->
	% ?LDS_DEBUG(check_mark_update, [_Mark, Args]),
	{Flag, NewItem} = mark(Item, Args),
	check_mark_update(Left, EventType, Args, Count + Flag, [NewItem | List]);
check_mark_update([Item | Left], EventType, Args, Count, List) ->
	check_mark_update(Left, EventType, Args, Count, [Item | List]).
	


mark([0, Action, List, NowNum, EndNum | Left] = Mark, [Object, Num]) when is_list(List) ->
	case lists:member(Object, List) of
		true ->
			NewNum = NowNum + Num,
			NewMark = if
				NewNum >= EndNum ->
					[1, Action, List, EndNum, EndNum | Left];
				true -> 
					[0, Action, List, NewNum, EndNum | Left]
			end,
			{1, NewMark};
		false -> {0, Mark}
	end;	
mark([0, Action, [], _NowNum, EndNum | Left] = _Mark, []) ->
	{1, [1, Action, [], EndNum, EndNum | Left]};
mark([0, Action, Object, NowNum, EndNum | Left], [Object, Num]) ->
	NewNum = NowNum + Num,
	NewMark = if
		NewNum >= EndNum ->
			[1, Action, Object, EndNum, EndNum | Left];
		true -> 
			[0, Action, Object, NewNum, EndNum | Left]
	end,
	{1, NewMark};	
mark(Mark, _) ->
	{0, Mark}.


%% @doc 接受任务触发事件，判断如果是跨服状态就不处理了，另外写代码来单独处理跨服那边的
%% @end
accept_event(Task, Status) ->
	case lib_cross:check_is_remote() of
		?true ->
			skip;
		?false ->
			Flag = 
				case player:is_in_team(Status) of
					true -> player:is_leader(Status);
					false -> true
				end, 
			case Flag of
				false -> skip;
				true ->
					gen_server:cast(player:get_pid(Status), 
									{apply_cast, ?MODULE, 'task_state_event', [Task#task.start_event, Task#task.id, Status]})
			end
	end.
% 	gen_server:cast(player:get_pid(Status), {'accept_task_event', Task}).

% accept_task_event(Task, Status) ->
% 	Events = Task#task.start_event,
% 	case Events =:= [] of
% 		true -> skip;
% 		false ->
% 			[[{MonNo, MonId} | _] | _] = [refresh_monster(Event, Status) || Event <- Events, is_list(Event)],
% 			case get_accepted(Task#task.id) of
% 				null -> ?ASSERT(false);
% 				Rd -> update_accepted(Rd#role_task{monNo = {MonNo, MonId}})
% 			end
% 	end.


%% 任务进度完成时触发的事件
finish_event(Task, Status) ->
	% Flag = 
	% 	case player:is_in_team(Status) of
	% 		true -> player:is_leader(Status);
	% 		false -> true
	% 	end, 
	% case Flag of
	% 	true ->
	% 		gen_server:cast(player:get_pid(Status), 
	% 			{apply_cast, ?MODULE, 'task_state_event', [Task#task.finish_event, Task#task.id, Status]});
	% 	false -> skip
	% end.
	gen_server:cast(player:get_pid(Status), 
		{apply_cast, ?MODULE, 'task_state_event', [Task#task.finish_event, Task#task.id, Status]}).   


%% @doc 提交任务触发事件	
submit_event(Task, Status) -> 
	Flag = 
		case player:is_in_team(Status) of
			true -> player:is_leader(Status);
			false -> true
		end, 
	case Flag of
		false -> skip;
		true ->
			gen_server:cast(player:get_pid(Status), 
				{apply_cast, ?MODULE, 'task_state_event', [Task#task.end_event, Task#task.id, Status]})
	end.


%% 各任务状态下事件处理
%% @spec task_state_event(Event :: task_event(), TaskId, Status)
task_state_event([], _, _) -> skip;
task_state_event([Event | Left], TaskId, Status) ->
	script_event(Event, TaskId, Status),
	task_state_event(Left, TaskId, Status).


%% 捕星任务刷怪脚本：
%% [[star_task_refresh_mon, [{Lv, Script}, {Lv2, Script2}, ...] ] , ....]
%% Script脚本格式: 与之前single和random一致
%% Lv : 等级段, 从低到高排序, 左闭右开区间
script_event([star_task_refresh_mon, Script | _], TaskId, Status) ->
	Lv = mod_team:get_member_min_lv(Status),
	star_task_refresh_mon(Lv, Script, TaskId, Status);


script_event([single | _] = Event, TaskId, Status) ->
	case player:is_in_team(Status) of
		true ->
			MonList = refresh_monster(Event, Status),
			mod_team:add_mon(Status, TaskId, MonList);
		false ->
			create_mon_by_task(TaskId, Event, Status)
	end;

script_event([random | _] = Event, TaskId, Status) ->
	case player:is_in_team(Status) of
		true ->
			MonList = refresh_monster(Event, Status),
			mod_team:add_mon(Status, TaskId, MonList);
		false ->
			create_mon_by_task(TaskId, Event, Status)
	end;

% 用于提交任务后自动领取任务
% script_event([next_task, TaskId], _, Status) ->
% 	case player:is_in_team(Status) of
% 		true ->
% 			team_captain_accept(TaskId, Status);
% 		false ->
% 			accept(TaskId, Status)
% 	end,
	
% 	ok;

script_event([auto_submit, TaskId], _, Status) ->
	force_submit(TaskId, Status),
	ok;

%% 悬赏任务发送奖励
script_event(send_xs_task_mail, TaskId, Status) ->
    lib_xs_task:send_xs_task_finish_mail(TaskId, Status),
	ok;


script_event(_, _, _) -> skip.


star_task_refresh_mon(_Lv, [], _, _) -> skip;
star_task_refresh_mon(Lv, Script, TaskId, Status) -> 
	star_task_refresh_mon_1(Lv, lists:sort(Script), TaskId, Status).


star_task_refresh_mon_1(_, [], _, _) -> skip;
star_task_refresh_mon_1(Lv, [{NextLv, Script}], TaskId, Status) -> 
	case Lv >= NextLv of
		true -> script_event(Script, TaskId, Status);
		false -> skip
	end;
star_task_refresh_mon_1(Lv, [{PrevLv, PrevScript}, {NextLv, NextScript} | Left], TaskId, Status) ->
	case Lv >= PrevLv andalso Lv < NextLv of
		true -> script_event(PrevScript, TaskId, Status);
		false -> star_task_refresh_mon_1(Lv, [{NextLv, NextScript} | Left], TaskId, Status)
	end.



create_mon_by_task(TaskId, Event, Status) ->
	case refresh_monster(Event, Status) of
		[{MonId, MonNo} | _] -> 
			case get_accepted(TaskId) of
				Task when is_record(Task, role_task) -> 
					update_accepted(Task#role_task{monNo = {MonId, MonNo}});
				_ -> ?ASSERT(false)
			end;
		_ -> ?ASSERT(false)
	end.


%% @doc 检测任务是否提交
%% @end
is_task_submit(0, _Status) -> true;
is_task_submit(TaskId, Status) ->
	case data_task:get(TaskId) of
		Task when is_record(Task, task) ->
			case lists:member(Task#task.type, ?UNREPEAT_TASK_TYPES) of
				true -> 
					case Task#task.career =:= 0 orelse Task#task.career =:= player:get_faction(Status) of
						false -> false;
						true -> 
							case get_unrepeat_completed(Task#task.type) of 
								null -> ?ASSERT(false, [TaskId]), false;
								Completed -> 
									case Completed#completed_unrepeat.id >= TaskId of
										true -> true;
										false -> false
									end
							end
					end;
				false ->
					case get_repeat_completed(TaskId) of
						null -> false;
						_ -> true
					end
			end;
		_ -> ?ASSERT(false, [TaskId]), false
	end.



	% case get_completed(TaskId) of
	% 	null ->
	% 		false;
	% 	_Task ->
	% 		% @redo 对于日/周常任务，是否要判断在同一周期内是否完成？
	% 		true
	% end.


is_task_can_trigger(TaskId, Status) when is_integer(TaskId) ->
	case data_task:get(TaskId) of
		Task when is_record(Task, task) ->	is_task_can_trigger(Task, Status);
		_ -> ?ASSERT(false), false
	end;
is_task_can_trigger(Task, Status) when is_record(Task, task) ->
	Type = Task#task.type,
	case 
		case lists:member(Type, ?UNREPEAT_TASK_TYPES) of
			true -> can_trigger(?UNREPEAT_TASK_TYPE, Task, Status);
			false -> 
				case lists:member(Type, ?REPEAT_TASK_TYPES) of
					true -> can_trigger(?REPEAT_TASK_TYPE, Task, Status);
					false -> 
						case lists:member(Type, ?RING_TASK_TYPES) of
							true -> can_trigger(?RING_TASK_TYPE, Task, Status);
							false -> 
								case lists:member(Type, ?DUNGEON_TASK_TYPES) of
									true -> can_trigger(?DUNGEON_TASK_TYPE, Task, Status);
									false -> ?ASSERT(false), false
								end
						end
				end
		end of
		?TASK_CAN_ACCEPT -> true;
		_ -> false
	end.


publ_task_accept_state(TaskId, RoleId) ->
	case get_task_flag() of
		RoleId -> task_accept_state(TaskId, RoleId);
		_ ->
			Pid = player:get_pid(RoleId),
			case erlang:is_pid(Pid) andalso erlang:is_process_alive(Pid) andalso Pid =/= self() of
				true ->
					case catch gen_server:call(Pid, {apply_call, ?MODULE, task_accept_state, [TaskId, RoleId]}, 3000) of
						true -> true;
						{false, Err} -> {false, Err};
						_Err -> ?ERROR_MSG("[task] publ_task_accept_state = ~p~n", [{player:get_pid(RoleId), TaskId, _Err}]), {false, ?ERROR}
					end;
				false ->
					false
			end
	end.

% 获取任务类型
get_task_type(TaskId) ->
	case data_task:get(TaskId) of
		Task when is_record(Task, task) ->
			Task#task.type;
		_Err -> 
			9999
	end.
	

%% @return : true | {false, ErrCode}
task_accept_state(TaskId, RoleId) when is_integer(RoleId) -> 
	task_accept_state(TaskId, player:get_PS(RoleId));
task_accept_state(TaskId, Status) when is_record(Status, player_status) ->
	case data_task:get(TaskId) of
		Task when is_record(Task, task) ->
			case lib_activity_degree:check_activity_degree_times_valid(Status, Task#task.sys_no) of
				?true ->
					case catch can_trigger(get_task_trigger_type(Task#task.type), Task, Status) of
						?TASK_CAN_ACCEPT ->
							case can_accept(Task, Status) of
								?SUCCESS -> true;
								Err -> {false, Err}
							end;
						% {false, Err} -> {false, Err};
						?TASK_TRIGGER -> {false, ?TASK_ROLE_LV_NOT_ENOUGTH};
						Err -> {false, Err}
					end;
				?false ->
					{false, ?ERROR}
			end;
		_Err -> 
			 ?ERROR_MSG("[task] task_accept_state = ~p~n", [_Err]), 
			?ASSERT(false, [TaskId]), 
			{false, ?ERROR}
	end.



is_task_can_accepted(TaskId, Status) ->
	case data_task:get(TaskId) of
		null -> false;
		Task ->
			case is_task_can_trigger(Task, Status) of
				true ->
					case can_accept(Task, Status) of
						?SUCCESS -> true;
						_ -> false
					end;
				_ -> false
			end
	end.

is_task_accepted(TaskId) ->
	case get_accepted(TaskId) of
		null ->false;
		_ -> true
	end.

is_task_completed(TaskId) ->
	case get_accepted(TaskId) of
		null -> false;
		Rd -> Rd#role_task.state =:= ?TASK_COMPLETED
	end.

is_accepted_no_complete(TaskId) ->
	case get_accepted(TaskId) of
		null ->false;
		Rd -> Rd#role_task.state =:= ?TASK_ACCEPTED
	end.

is_accepted_no_complete_list() ->
	List = get_accepted_list(),
	[TaskId || TaskId <- List, is_accepted_no_complete(TaskId) =:= true].


is_task_fail(TaskId) ->
	case get_accepted(TaskId) of
		null -> false;
		Rd -> Rd#role_task.state =:= ?TASK_FAIL
	end.


can_item_task_accept(RoleId, TaskId) ->
	Task = data_task:get(TaskId),
	ItemList = Task#task.start_item,
	(not over_task_limit()) andalso (mod_inv:check_batch_add_goods(RoleId, ItemList) =:= ok).


set_task_flag(Status) ->
	put(?TASK_FLAG, player:id(Status)).

get_task_flag() ->
	case get(?TASK_FLAG) of
		undefined -> null;
		Rd -> Rd
	end.


%% @doc 判断已接任务是否完成
%% @end	
is_task_finish(Task) when is_record(Task, role_task) ->
	Task#role_task.state =:= ?TASK_COMPLETED;
is_task_finish(_) -> ?ASSERT(false), false.

%% @doc 检测已接任务是否完成
%% @end	
check_task_finish(Task, Status) ->
	case [0 || [0 | _] <- Task#role_task.mark] =:= [] of
		true ->
			%% 通知任务事件
			notify_task_event(Task#role_task.id, ?TASK_COMPLETED_EVENT, Status),
			%% 触发完成任务事件
			finish_event(data_task:get(Task#role_task.id), Status),
			%% 记录任务日志
			?BIN_PRED(Task#role_task.state =/= ?TASK_COMPLETED, lib_log:task_finish(Task#role_task.id, Status), skip),
			Task#role_task{state = ?TASK_COMPLETED};
		false -> 
			case Task#role_task.state =:= ?TASK_COMPLETED of
				true -> Task#role_task{state = ?TASK_ACCEPTED};
				false -> Task
			end
	end.


%% @doc 检查并更新所有任务并全部推送客户端
%% @end
notify_task_refresh_all(Status) ->
	gen_server:cast( player:get_pid(Status), 
		{apply_cast, ?MODULE, check_update_task_list, [player:id(Status)]}).

%% @doc 检查并更新所有任务在有任务更新时才推送客户端
%% @end
notify_task_refresh_all_if_change(Status) ->
	gen_server:cast( player:get_pid(Status), 
		{apply_cast, ?MODULE, check_update_task_list_if_change, [player:id(Status)]}).

%% @doc 检查并更新指定任务并全部推送客户端
%% @end
notify_check_update_task(TaskId, Status) ->
	gen_server:cast( player:get_pid(Status), 
		{apply_cast, ?MODULE, check_update_task, [TaskId, player:id(Status)]}).

%% @doc 检查并更新指定任务在有任务更新时才推送客户端
%% @end
notify_check_update_task_if_change(TaskId, Status) ->
	gen_server:cast( player:get_pid(Status), 
		{apply_cast, ?MODULE, check_update_task_if_change, [TaskId, player:id(Status)]}).


notify_check_update_task_if_change_local(Task, Status) ->
	RoleId = player:id(Status), 
	{Flag, NewMarkTmp, _} = lists:foldl(fun update_mark/2, {0, [], RoleId}, Task#role_task.mark),
	NewMark = lists:reverse(NewMarkTmp),
	if
		Flag =:= 0 -> Task;
		true ->
			NewTask = check_task_finish(Task#role_task{mark = NewMark}, player:get_PS(RoleId)),
			% update_accepted(NewTask),
			NewTask
	end.


check_update_task_list(RoleId) ->
	AcceptList = get_accepted_list(),
	check_update_task_list(AcceptList, RoleId).
check_update_task_list([], _RoleId) -> skip;
check_update_task_list([TaskId | Left], RoleId) ->
	check_update_task(TaskId, RoleId),
	check_update_task_list(Left, RoleId).

check_update_task_list_if_change(RoleId) ->
	AcceptList = get_accepted_list(),
	check_update_task_list_if_change(AcceptList, RoleId).
check_update_task_list_if_change([], _RoleId) -> skip;
check_update_task_list_if_change([TaskId | Left], RoleId) ->
	check_update_task_if_change(TaskId, RoleId),
	check_update_task_list_if_change(Left, RoleId).


check_update_task(TaskId, RoleId) ->
	case get_accepted(TaskId) of
		null ->
			?ERROR_MSG("task check_update_task ~p, ~p~n", [TaskId, RoleId]),
			?ASSERT(false),
			skip;
		Task ->
			{Flag, NewMarkTmp, _} = lists:foldl(fun update_mark/2, {0, [], RoleId}, Task#role_task.mark),
			NewMark = lists:reverse(NewMarkTmp),
			if
				Flag =:= 0 -> 
					refresh_task(Task, RoleId);
				true ->
					NewTask = check_task_finish(Task#role_task{mark = NewMark}, player:get_PS(RoleId)),
					update_accepted(NewTask),
					refresh_task(NewTask, RoleId)
			end
	end.


check_update_task_if_change(TaskId, RoleId) ->
	case get_accepted(TaskId) of
		null ->
			?ERROR_MSG("task check_update_task ~p, ~p~n", [TaskId, RoleId]),
			?ASSERT(false),
			skip;
		Task ->
			{Flag, NewMarkTmp, _} = lists:foldl(fun update_mark/2, {0, [], RoleId}, Task#role_task.mark),
			NewMark = lists:reverse(NewMarkTmp),
			if
				Flag =:= 0 -> skip;
				true ->
					NewTask = check_task_finish(Task#role_task{mark = NewMark}, player:get_PS(RoleId)),
					update_accepted(NewTask),
					refresh_task(NewTask, RoleId)
			end
	end.


update_mark(Mark = [State, Action, Object, NowNum, EndNum | Left], {Flag, Sum, RoleId}) ->
	case lists:member(Action, ?UPDATE_CHECK_ACTION) of
		true ->
			% NewNum = mod_inv:get_goods_count_in_bag_by_no(RoleId, Object),
			NewNum = 
				case is_specific_action(Action) of
					true -> specific_action(Action, NowNum, EndNum, RoleId,Object);
					false ->
						case is_list(Object) of
							true -> L1 = [mod_inv:get_goods_count_in_bag_by_no(RoleId, Obj1) || Obj1 <- Object],
									lists:sum(L1);
							false -> mod_inv:get_goods_count_in_bag_by_no(RoleId, Object)
						end
				end,
			if
			 	NewNum >= EndNum ->
			 		{?BIN_PRED(State =:= 1, Flag, Flag + 1), [[1, Action, Object, EndNum, EndNum | Left] | Sum], RoleId};
			 	true ->
			 		{?BIN_PRED(State =:= 0 andalso NowNum =:= NewNum, Flag, Flag + 1), [[0, Action, Object, NewNum, EndNum | Left] | Sum], RoleId}
			end;
		false -> {Flag, [Mark | Sum], RoleId}
	end;
update_mark(Mark, {Flag, Sum, RoleId}) -> {Flag, [Mark | Sum], RoleId}.


%% 是否指定行为
is_specific_action(Action) ->
	lists:member(Action, ?TASK_SPECIFIC_ACTION).

specific_action(had_guild, NowNum, EndNum, RoleId,_Object) ->
	?BIN_PRED(player:get_guild_id(RoleId) =:= 0, NowNum, EndNum);
specific_action(be_hired, NowNum, EndNum, RoleId,_Object) ->
	?BIN_PRED(ply_hire:has_been_hire(player:get_PS(RoleId)), EndNum, NowNum);
specific_action(hire, NowNum, EndNum, RoleId,_Object) ->
	?BIN_PRED(ply_hire:has_hired_player(player:get_PS(RoleId)), EndNum, NowNum);
specific_action(reach_achievement, NowNum, EndNum, RoleId,Object) ->
	?BIN_PRED(mod_achievement:check_achievement_task(RoleId, Object) , EndNum, NowNum);
specific_action(_Action, NowNum, _, _,_) -> ?ASSERT(false, [_Action]),	NowNum.


get_npc_scene_id(NpcId) ->
	case ?DEFAULT_VAL(NpcId) of
		true -> 0;
		false -> 1304%mod_npc:get_scene_id(NpcId)
	end.

%% @doc 打包任务相关数据
package_task_data(trigger, [TaskId, State]) ->
	Task = data_task:get(TaskId),
	NpcId = Task#task.start_npc,
	% @redo
	SceneId = get_npc_scene_id(NpcId),
	{Step, Ring} = get_current_setp_and_round(TaskId),
	[TaskId, State, NpcId, SceneId, Step, Ring];


package_task_data(accepted, [Task]) when is_record(Task, role_task) ->
	% redo
	TaskId = Task#role_task.id, 
	DataTask = data_task:get(TaskId),
	
	State = Task#role_task.state, 
	NpcId = DataTask#task.start_npc, 
	% ?LDS_TRACE("package_task_data", [TaskId, NpcId]),
	SceneId = get_npc_scene_id(NpcId), 
	Mark = pack_mark_all(Task#role_task.mark),
	{Step, Ring} = get_current_setp_and_round(TaskId),
	[TaskId, State, NpcId, SceneId, Step, Ring, Task#role_task.accept_time, Mark];
package_task_data(accepted, [TaskId]) ->
	case get_accepted(TaskId) of
		Task when is_record(Task, role_task) ->
			package_task_data(accepted, [Task]);
		_ -> skip
	end;


package_task_data(content, [Task, State]) ->
	% Mark = add_state_mark(Task#task.content),
	#role_task{
					   id = Task#task.id
					  ,accept_time = util:unixtime()
					  ,mark = add_state_mark(Task#task.content)
					  ,state = State
			}.
	% case is_ring_task(Task#task.id) of
	% 	true ->
	% 		Seed = get_task_seed(),
	% 		Index = (Seed rem erlang:length(Task#task.content)) + 1,
	% 		RingMark = [lists:nth(Index, Task#task.content)],
	% 		?LDS_TRACE("package_task_data content", [Seed, Index, RingMark]),
	% 		#role_task{
	% 		   id = Task#task.id
	% 		  ,accept_time = util:unixtime()
	% 		  ,mark = add_state_mark(RingMark)
	% 		  ,state = State
	% 		};
	% 	false ->
	% 		#role_task{
	% 				   id = Task#task.id
	% 				  ,accept_time = util:unixtime()
	% 				  ,mark = add_state_mark(Task#task.content)
	% 				  ,state = State
	% 		}
	% end.


-define(INIT_MARK_STATE, 0).
-define(COMPLETED_MARK_STATE, 1).
add_state_mark(Content) ->
	[add_state(Item) || Item <- Content, is_list(Item)].


% add_state([kill_dark | Left]) ->  		%% 把杀暗雷怪脚本（客户端特殊需求）转换成普通杀怪
% 	[set_event_type_state(kill_dark) | [kill | Left]];
add_state([EventType | _] = List) ->
	[set_event_type_state(EventType) | List].

set_event_type_state(EventType) ->
	case lists:member(EventType, ?COMPLETED_EVENT_TYPE) of
		true -> ?COMPLETED_MARK_STATE;
		false -> ?INIT_MARK_STATE
	end.

pack_mark_all(Mark) ->
	[pack_mark(Item) || Item <- Mark, is_list(Item)].

pack_mark([State, talk, NpcId, StartNum, EndNum | _]) ->
	[transform_event_index(talk), State, get_npc_scene_id(NpcId), 
	 0, 0, NpcId, StartNum, EndNum];

pack_mark([State, reach_achievement, NpcId, StartNum, EndNum | _]) ->
	[transform_event_index(reach_achievement), State, get_npc_scene_id(NpcId),
		0, 0, NpcId, StartNum, EndNum];

pack_mark([State, join_faction, NpcId, StartNum, EndNum | _]) ->
	[transform_event_index(join_faction), State, get_npc_scene_id(NpcId), 
	 0, 0, NpcId, StartNum, EndNum];
pack_mark([State, send, ItemNO, StartNum, EndNum, [NpcId]]) ->
	[transform_event_index(send), State, get_npc_scene_id(NpcId), 
	 0, NpcId, ItemNO, StartNum, EndNum];
pack_mark([State, kill, MonId, StartNum, EndNum, _]) ->
	[transform_event_index(kill), State, 0, 
	 0, 0, MonId, StartNum, EndNum];
pack_mark([State, go, [SceneId, ExpId], StartNum, EndNum | _]) ->
	[transform_event_index(go), State, SceneId, 
	 0, 0, ExpId, StartNum, EndNum];	
pack_mark([State, buy, ItemId, StartNum, EndNum, [NpcId]]) -> 
	[transform_event_index(buy), State, get_npc_scene_id(NpcId), 
	 0, NpcId, ItemId, StartNum, EndNum];
pack_mark([State, catch_pet, ItemId, StartNum, EndNum, [SceneId]]) -> 
	[transform_event_index(catch_pet), State, SceneId, 
	 0, 0, ItemId, StartNum, EndNum];
pack_mark([State, kill_collect, ItemId, StartNum, EndNum, [SceneId | _MonId]]) ->
	[transform_event_index(kill_collect), State, SceneId, 
	 0, 0, ItemId, StartNum, EndNum];
pack_mark([State, collect, ItemId, StartNum, EndNum, [NpcId]]) ->
	[transform_event_index(collect), State, 0, 
	 0, NpcId, ItemId, StartNum, EndNum];
pack_mark([State, kill_dark, MonId, StartNum, EndNum | _]) ->
	[transform_event_index(kill_dark), State, 0, 
	 0, 0, MonId, StartNum, EndNum];
pack_mark([State, drop_kill, ItemId, StartNum, EndNum | _]) ->
	[transform_event_index(drop_kill), State, 0, 
	 0, 0, ItemId, StartNum, EndNum];
pack_mark([State, drop_kill_dark, ItemId, StartNum, EndNum | _]) ->
	[transform_event_index(drop_kill_dark), State, 0, 
	 0, 0, ItemId, StartNum, EndNum];
pack_mark([State, Event, TargetId, StartNum, EndNum | _]) ->
	[transform_event_index(Event), State, 0, 
	 0, 0, TargetId, StartNum, EndNum];
pack_mark(_) ->
	[].	 


transform_event_index(Event) ->
	data_task:get_task_event_no(Event).
	

%% @doc 任务触发状态
%% @spec 
%% @end
% trigger_state(RoleId, TaskId) ->
% 	Task_data = data_task:get(TaskId),
% 	redo.



% -record(tri_condition, {
% 						lv = 0				%等级条件
% 					   ,pre_task = 0		%前置任务条件
% 					   ,race = 0			%种族条件		
% 					   ,career = 0			%职业条件
% %% 					   ,team = 0			%组队条件
% 					   ,times = 0			%次数条件
% 						}).


%% @doc 把任务记录体#trigger_state{}转化为2进制位串, 
%% 其中每位存储一个任务条件，1->符合条件，0->不符合, 节省网络传输和内存数据量
%% @end
transform_trigger_state(T_state) ->
	[_ | State] = erlang:tuple_to_list(T_state),
	[Val | List] = lists:reverse(State),
	for_set_state(List, Val).

for_set_state([], State) -> State;
for_set_state([Val | List], State) ->
	NewState = (State bsl 1) + Val,
	for_set_state(List, NewState).


%% @doc 判断任务是否能触发
%% @return 0 -> 不触发 | 1 -> 触发 | 3 -> 可接受
%% @end

% can_trigger(TaskId, Status) when is_integer(TaskId) ->
% 	case data_task:get(TaskId) of
% 		null -> false;
% 		Task -> can_trigger(Task, Status)
% 	end;
% can_trigger(Task, Status) ->
% 	RoleLv = player:get_lv(Status),
% 	RoleId = player:id(Status),
% 	TaskLv = Task#task.lv,
% 	case
% 		(?DEFAULT_VAL(Task#task.race) orelse Task#task.race =:= player:get_race(Status)) 
% 		andalso
% 		(?DEFAULT_VAL(Task#task.career) orelse Task#task.career =:= player:get_faction(Status))
% 		andalso
% 		guild_task_condition(Task, Status)
% 		andalso
% 		item_task_condition(Task) 
% 		andalso
% 		(not is_task_accepted(Task#task.id)) 
% 		andalso
% 		task_dungeon_condition(Task, Status)
% 		andalso
% 		(is_task_prev_submit(Task)) 
% 		andalso
% 		is_fit_trigger_lv(RoleLv, Task, Task#task.lv_limit) 
% 		andalso 
% 		is_fit_times(RoleId, Task) 
% 		andalso
% 		ring_task_condition(Task, RoleLv) 
% 		andalso
% 		auto_accept_condition(Task, Status) 
% 		andalso
% 		is_in_time(Task) of
% 			false -> ?TASK_CANT_TRIGGER;
% 			true -> ?BIN_PRED(is_fit_can_accept_lv(RoleLv, TaskLv), ?TASK_CAN_ACCEPT, ?TASK_TRIGGER)
% 		end.

%% @return : integer()
can_trigger(Type, TaskId, Status) when is_integer(TaskId) ->
	case data_task:get(TaskId) of
		Task when is_record(Task, task) -> can_trigger(Type, Task, Status);
		_ -> ?ASSERT(false), ?TASK_CANT_TRIGGER
	end;
can_trigger(Type, Task, Status) when is_record(Task, task) ->
	can_trigger_type(Type, Task, Status);
can_trigger(_, _, _) -> ?ASSERT(false), ?TASK_CANT_TRIGGER.


%% 根据种族职业判断任务是否适合角色分类
is_task_classify(Task, Status) ->
	%% 种族race字段作废了20191210
	(?DEFAULT_VAL(Task#task.race) orelse Task#task.race =:= player:get_race(Status) orelse true) 
	andalso
	(?DEFAULT_VAL(Task#task.career) orelse Task#task.career =:= player:get_faction(Status)).


%% @return : true | {false, ErrCode}
can_trigger_base(Task, Status) ->
	RoleLv = player:get_lv(Status),
	case is_task_classify(Task, Status) of
		false -> {false, ?TASK_ROLE_LIMIT};
		true -> 
			case guild_task_condition(Task, Status) of
				false -> {false, ?TASK_GUILD_LIMIT};
				true ->
					case accepted_or_submit_task(Task, Status) of
						false -> {false, ?PERV_TASK_NOT_SUBMIT};
						true ->
							case item_task_condition(Task) of
								false -> {false, ?NO_TASK_TRIGGER_ITEM};
								true -> 
									case is_task_accepted(Task#task.id) of
										true -> {false, ?HAD_SAME_TYPE_TASK};
										false -> ?BIN_PRED(is_fit_trigger_lv(RoleLv, Task, Task#task.lv_limit), true, {false, ?TASK_ROLE_LV_NOT_ENOUGTH})
									end
							end
					end
			end
	end.

accepted_or_submit_task(Task, Status) ->
	accepted_or_submit_task_1(Task#task.accepted_submit, Status).

accepted_or_submit_task_1([], _) -> true;
accepted_or_submit_task_1([TaskId | Left], Status) ->
	case is_task_accepted(TaskId) orelse is_task_submit(TaskId, Status) of
		true -> accepted_or_submit_task_1(Left, Status);
		false -> false
	end.

	% is_task_classify(Task, Status)
	% andalso
	% guild_task_condition(Task, Status)
	% andalso
	% item_task_condition(Task) 
	% andalso
	% (not is_task_accepted(Task#task.id))
	% andalso
	% is_fit_trigger_lv(RoleLv, Task, Task#task.lv_limit).


%% @return : integer()
can_trigger_type(?UNREPEAT_TASK_TYPE, Task, Status) ->
	case can_trigger_base(Task, Status) of
		true -> 
			case is_task_prev_submit(Task, Status) of
				true -> ?BIN_PRED(is_fit_can_accept_lv(player:get_lv(Status), Task#task.lv, Task#task.lv_limit), ?TASK_CAN_ACCEPT, ?TASK_TRIGGER);
				false -> ?PERV_TASK_NOT_SUBMIT
			end;
		{false, ErrCode} -> ErrCode
	end;

can_trigger_type(?REPEAT_TASK_TYPE, Task, Status) ->
	case can_trigger_base(Task, Status) of
		{false, ErrCode} -> ErrCode;
		true -> 
			case is_task_prev_submit(Task, Status) andalso is_fit_times(player:id(Status), Task) andalso is_in_time(Task) of
				true -> ?BIN_PRED(is_fit_can_accept_lv(player:get_lv(Status), Task#task.lv, Task#task.lv_limit), ?TASK_CAN_ACCEPT, ?TASK_TRIGGER);
				false -> ?TASK_NOT_ENOUT_TIMES
			end
	end;

can_trigger_type(?DUNGEON_TASK_TYPE, Task, Status) ->
	case can_trigger_base(Task, Status) of
		true -> 
			case is_task_prev_submit(Task, Status) andalso is_fit_times(player:id(Status), Task) of
				true -> ?BIN_PRED(is_fit_can_accept_lv(player:get_lv(Status), Task#task.lv, Task#task.lv_limit), ?TASK_CAN_ACCEPT, ?TASK_TRIGGER);
				false -> ?PERV_TASK_NOT_SUBMIT
			end;
		{false, ErrCode} -> ErrCode
	end;

can_trigger_type(?RING_TASK_TYPE, Task, Status) ->
	case can_trigger_base(Task, Status) of
		{false, ErrCode} -> ErrCode;
		true -> 
			case is_fit_times(player:id(Status), Task) of
				false -> ?TASK_NOT_ENOUT_TIMES;
				true -> 
					case is_in_time(Task) of
						false -> ?TASK_NOT_ENOUT_TIMES;
						true ->
							case ring_task_condition(Task, player:get_lv(Status)) of
								true -> ?BIN_PRED(is_fit_can_accept_lv(player:get_lv(Status), Task#task.lv, Task#task.lv_limit), ?TASK_CAN_ACCEPT, ?TASK_TRIGGER);
								{false, ErrCode} -> ErrCode
							end
					end
			end
	end;
	% 		case ring_task_condition(Task, player:get_lv(Status)) andalso is_fit_times(player:id(Status), Task) andalso is_in_time(Task) of
	% 			true -> ?BIN_PRED(is_fit_can_accept_lv(player:get_lv(Status), Task#task.lv, Task#task.lv_limit), ?TASK_CAN_ACCEPT, ?TASK_TRIGGER);
	% 			{false, ErrCode} -> ErrCode
	% 		end
	% end;
can_trigger_type(_T, _, _) ->  
	?ERROR_MSG("[task] can_trigger_type = ~p~n", [_T]),
	?ASSERT(false), ?ERROR.


%% 检测任务触发同时检测是否自动弹出接受界面
% can_trigger(TaskId, Status, OldTriggerList) when is_integer(TaskId) ->
% 	case data_task:get(TaskId) of
% 		Task when is_record(Task, task) -> can_trigger(Task, Status, OldTriggerList);
% 		_ -> ?ASSERT(false, [TaskId])
% 	end;
% can_trigger(Task, Status, OldTriggerList) ->
% 	State = can_trigger(Task, Status),
% 	case State of
% 		?TASK_CAN_ACCEPT -> check_auto_trigger(Task, Status, OldTriggerList);
% 		_ -> skip
% 	end,
% 	State.

	

auto_accept_condition(Task, _Status) ->
	case Task#task.auto_accept of
		0 -> true;
		1 -> 
			redo,
			true
	end.


check_auto_trigger(Task, Status, OldTriggerList) ->
	?DEBUG_MSG("wjctesttask2 ~p~n", [{	Task#task.repeat,
		Task#task.day_task ,
		Task#task.week_task}]),
	case Task#task.auto_accept =:= 1 andalso (not is_task_repeat(Task)) of
		true -> 
			case lists:keyfind(Task#task.id, 1, OldTriggerList) of
				false -> gen_server:cast(player:get_pid(Status), {apply_cast, ?MODULE, notify_auto_trigger, [Task#task.id, player:id(Status)]});
				_ -> skip
			end;
		false -> skip
	end.

notify_auto_trigger(TaskId, RoleId) ->
	{ok, BinData} = pt_30:write(30007, [TaskId]),
	lib_send:send_to_uid(RoleId, BinData).

guild_task_condition(Task, Status) ->
	case Task#task.type =/= ?TASK_GUILD_TYPE of
		true -> true;
		false -> player:is_in_guild(Status)
	end.


task_dungeon_condition(Task, Status) ->
	case player:is_in_dungeon(Status) of
		{true, _} ->
			case player:get_dungeon_no(Status) of
				null -> ?ASSERT(false), false;
				DunNo -> Task#task.dun_no =:= DunNo
			end;
		false -> Task#task.dun_no =:= 0
	end.


item_task_condition(Task) ->
	Task#task.type =/= ?TASK_ITEM_TRIGGER.


item_task_accept_condition(TaskId) ->
	Task = data_task:get(TaskId),
	Task#task.type =:= ?TASK_ITEM_TRIGGER.

is_xs_task(TaskId) ->
    (data_task:get(TaskId))#task.type =:= ?TASK_XS_TASK_TYPE.

%判断是否是师门挑战任务
is_faction_fight_task(TaskId) ->
	(data_task:get(TaskId))#task.type =:= ?TASK_FACTION_FIGHT_TYPE.

% 判断是否三界任务
is_sanjie_task(TaskId) ->
    (data_task:get(TaskId))#task.type =:= ?TASK_SANJIE_TYPE.

%% 环任务条件判断
%% @return : true | {false, ErrCode}
ring_task_condition(Task, RoleLv) ->
	TaskLv = Task#task.lv,
	TaskId = Task#task.id,
	NowDays = get_now_date(),

	% ?DEBUG_MSG("Task=~p",[Task]),
	% ?DEBUG_MSG("Task#task.ring=~p",[Task#task.ring]),

	case Task#task.ring of
		{TaskId, _RingCount, _RanCount, _TimesCount, TaskId} -> 
			case get_task_ring_state(Task) of
				null -> 
					case get_task_ring(TaskId) of
						null -> ?ASSERT(false, [TaskId]), {false, ?TASK_STATE_ERROR};
						RingTask -> 
							case RingTask#task_ring.date =:= 0 of
								true -> 
									NewRingTask = RingTask#task_ring{date = NowDays},
									update_task_ring(TaskId, NewRingTask), 
									?BIN_PRED(ring_cd(NewRingTask), true, {false, ?TASK_NOT_ENOUT_TIMES});
								false -> 
									?BIN_PRED(ring_cd(RingTask), true, {false, ?TASK_NOT_ENOUT_TIMES}) 
							end
					end;
				_ -> {false, ?HAD_SAME_TYPE_TASK}
			end;
		{TaskId, _RingCount, _RanCount, _TimesCount, PervId} ->
			case RoleLv >= TaskLv andalso get_task_ring_state(data_task:get(PervId)) =:= null of 			% 其他阶段环任务不提前显示
				true ->
					case get_task_ring_state(Task) of
						null ->
							case get_task_ring(TaskId) of
								null -> ?ASSERT(false), {false, ?TASK_STATE_ERROR};
								RingTask -> 
									case RingTask#task_ring.date =:= 0 of
										true -> 
											% 取上一阶段环任务信息, 继承上一阶段的任务进度
											case get_task_ring(PervId) of
												null -> ?ASSERT(false), {false, ?TASK_STATE_ERROR};
												PrevRing -> 
													case PrevRing#task_ring.date =:= NowDays of
														true -> 
															NewRingTask = PrevRing#task_ring{masterId = TaskId},
															update_task_ring(TaskId, NewRingTask),
															?BIN_PRED(ring_cd(NewRingTask), true, {false, ?TASK_NOT_ENOUT_TIMES});
														_ -> 
															NewRingTask = RingTask#task_ring{date = NowDays},
															update_task_ring(TaskId, NewRingTask),
															?BIN_PRED(ring_cd(NewRingTask), true, {false, ?TASK_NOT_ENOUT_TIMES})
													end
											end;
										false -> ?BIN_PRED(ring_cd(RingTask), true, {false, ?TASK_NOT_ENOUT_TIMES})
									end
							end;
						_ -> {false, ?HAD_SAME_TYPE_TASK}
					end;
				false -> ?BIN_PRED(RoleLv >= TaskLv, {false, ?HAD_SAME_TYPE_TASK}, {false, ?TASK_ROLE_LV_NOT_ENOUGTH})
			end;
		_ -> ?ASSERT(false, [TaskId]), {false, ?TASK_STATE_ERROR}
	end.


% ring_task_condition(Task, RoleLv) ->
% 	TaskId = Task#task.id,
% 	TaskLv = Task#task.lv,
% 	case Task#task.ring of
% 		0 -> true;
% 		{TaskId, _RingCount, _RanCount, _TimesCount, TaskId} -> 
% 			case get_task_ring_state(Task) of
% 				null -> 
% 					RingTask =
% 						case get_task_ring(TaskId) of
% 							null ->
% 								Rd = make_new_task_ring(TaskId),
% 								set_task_ring_db(TaskId, Rd),
% 								Rd;
% 							Rd -> Rd
% 						end,
% 					ring_cd(RingTask);
% 				_ -> false
% 			end;
% 		{TaskId, _RingCount, _RanCount, _TimesCount, PervId} ->
% 			case RoleLv >= TaskLv andalso get_task_ring_state(data_task:get(PervId)) =:= null of 			% 其他阶段环任务不提前显示
% 				true ->
% 					case get_task_ring_state(Task) of
% 						null -> 
% 							case get_task_ring(TaskId) of 
% 								null ->
% 									% 取上一阶段环任务信息
% 									case get_task_ring(PervId) of
% 										null -> 
% 											% ?ERROR_MSG("ring_task_condition error task id = ~p, prev_id = ~p~n", [TaskId, PervId]),
% 											% ?ASSERT(false, [TaskId, PervId]),
% 											% false;
% 											% 帮派的环任务可能在玩家跳过之前触发的帮派任务等级后才加入帮派，故后面的阶段环任务前一阶段环任务信息为空
% 											set_task_ring_db(TaskId, make_new_task_ring(TaskId)),
% 											true;
% 										Rd when is_record(Rd, task_ring) ->
% 											NewRingRd = case get_now_date() =:= Rd#task_ring.date of
% 												true -> Rd#task_ring{masterId = TaskId};
% 												false -> make_new_task_ring(TaskId)
% 											end,
% 											set_task_ring_db(TaskId, NewRingRd),
% 											ring_cd(NewRingRd)
% 									end;
% 								Rd -> ring_cd(Rd)
% 							end;

% 						_ -> false
% 					end;  
% 				false -> false
% 			end;
% 		_ -> false
% 	end.


ring_cd(RingRd) ->
	MasterId = RingRd#task_ring.masterId,
	Task = data_task:get(MasterId),
	Rring = RingRd#task_ring.ring,
	Rtimes = RingRd#task_ring.times,
	{MasterId, RingCount, _, TimesCount, _} = Task#task.ring,
	case TimesCount =:= 0 of
		true ->
			case Rring > RingCount of
				true -> update_task_ring(MasterId, RingRd#task_ring{ring = 1, times = Rtimes + 1});
				false -> skip
			end,
			true;
		false ->

			NowDate = get_now_date(),
			OldDate = RingRd#task_ring.date,
			?DEBUG_MSG("daily_reset2 ~p~n",[get(reset_task)]),
			IsReset = case get(reset_task) of
									undefined ->
										false;
									_ -> true
								end,
			CdType = 
				if
					IsReset -> false;
					Task#task.week_task >= 1 -> is_week_round(OldDate, NowDate, Task#task.week_task);
					Task#task.day_task =:= 1 -> NowDate =:= OldDate;
					true -> true
				end,
			case CdType of
				false ->
					update_task_ring(MasterId, RingRd#task_ring{ring = 1, times = 1, date = NowDate}),
					true;
				true ->
					
					case Rring > RingCount of
						true ->
							
							case Rtimes >= TimesCount of
								true -> false;
								false -> 
									update_task_ring(MasterId, RingRd#task_ring{ring = 1, times = Rtimes + 1, date = NowDate}),
									true
							end;
						false ->
							true
					end
			end
	end.


make_new_task_ring(MasterId) ->
	#task_ring{masterId = MasterId, ring = 1, seed = rand_task_seed(), times = 1, date = get_now_date()}.


make_new_task_ring(MasterId, Date) ->
	#task_ring{masterId = MasterId, ring = 1, seed = rand_task_seed(), times = 1, date = Date}.

is_task_prev_submit(Task, Status) ->
	case Task#task.prev_id of
		[0] -> true;
		List -> is_task_prev_submit_1(List, Status)
	end.

is_task_prev_submit_1([], _) -> false;
is_task_prev_submit_1([TaskId | Left], Status) ->
	case is_task_submit(TaskId, Status) of
		true -> true;
		false -> is_task_prev_submit_1(Left, Status)
	end.
 

-define(TRIGGER_LV, -2).	%触发等级差

%% @doc 判断是否满足触发等级差
%% @return true | false
%% @end
is_fit_trigger_lv(RoleLv, Task, UpperLv) -> 
	case Task#task.type =:= ?TASK_MAIN_TYPE of
		true -> true;
		false ->
			TaskLv = Task#task.lv,
			RoleLv >= (TaskLv + ?TRIGGER_LV) andalso (?DEFAULT_VAL(UpperLv) orelse RoleLv =< UpperLv)
	end.

is_fit_can_accept_lv(RoleLv, TaskLv, UpperLv) -> 
	RoleLv >= TaskLv andalso (?DEFAULT_VAL(UpperLv) orelse RoleLv =< UpperLv).


-define(TASK_UNREPEAT, 1).
-define(TASK_DAY, 1).
-define(TASK_WEEK, 2).

%% @doc 判断任务是否满足次数
is_fit_times(_RoleId, Task) ->
	case Task#task.ring =:= 0 of
		true ->
			TaskId = Task#task.id,
			RepTimes = Task#task.repeat,
			case get_repeat_completed(TaskId) of
				null ->
					true;
				#completed{date = OldDate, times = Times} = _Rd ->
					NowDate = get_now_date(),
					if
						Task#task.day_task =:= 1 ->
							case NowDate =:= OldDate of
								true -> Times < RepTimes;
								false -> true
							end;
						Task#task.week_task =/= 0 ->
							case is_week_round(OldDate, NowDate, Task#task.week_task) of
								true -> Times < RepTimes;
								false -> true
							end;
						true -> Times < RepTimes
					end
			end;
		false -> true
	end.
	

%% @doc 判断任务是否在上架时间内
%% @end
is_in_time(Task) ->
	is_in_time(Task, os:timestamp()).

is_in_time(Task, Time) ->
	TaskTime = analyze_task_time(Task),
	case TaskTime of
		infinity -> true;
		{server_start, Hour} ->
			{Stamp, _NowTimeList} = get_now_task_time(Time),
			StartStamp = util:get_server_open_stamp(),
			Stamp =< (StartStamp + (Hour * 3600));
		{timing, TimeList} ->
			{_Stamp, NowTimeList} = get_now_task_time(Time),
			is_in_time_1(NowTimeList, TimeList)
	end.


is_in_time_1([], []) -> true;
is_in_time_1([_ | LeftTime], [nil | LeftTerm]) -> 
	is_in_time_1(LeftTime, LeftTerm);
is_in_time_1([Time | LeftTime], [Term | LeftTerm]) ->
	case lists:member(Time, Term) of
		true ->
			is_in_time_1(LeftTime, LeftTerm);
		false ->
			false
	end.


get_now_task_time({M, S, _} = Now) ->
	{{Year, Month, Day}, {Hour, _, _}} =
		calendar:now_to_local_time(Now),
	Week = calendar:day_of_the_week({Year, Month, Day}),
	{M * 1000000 + S, [Year, Month, Week, Day, Hour]}.


%% @doc 解析任务配置表时间
%% @spec
%% @end
analyze_task_time(Task) ->
	List = [Year, Month, Week, Day, Hour]
		 = [Task#task.year, Task#task.month, Task#task.week, Task#task.day,
		 	Task#task.hour],
	ServiceOpen = Task#task.server_start,
	if
		Year =:= nil andalso Month =:= nil andalso Week =:= nil andalso 
			Day =:= nil andalso Hour =:= nil andalso ServiceOpen =:= nil ->
			infinity;
		ServiceOpen =/= nil ->
			{server_start, ServiceOpen};
		true ->
			{timing, [translate_time_format(Elm) || Elm <- List]}

	end.


translate_time_format(nil) -> nil;
translate_time_format([A]) -> [A];
translate_time_format([A, B]) ->
	lists:seq(A, B);
translate_time_format(Term) when is_tuple(Term) ->
	tuple_to_list(Term);
translate_time_format(_) ->
	?ASSERT(false), [].


% is_ring_task(TaskId) ->
% 	Task = data_task:get(TaskId),
% 	Task#task.ring =/= 0.


%% get ring task by step
% get_ring_task_id_by_step(TaskId, 1) -> TaskId;
% get_ring_task_id_by_step(TaskId, Step) ->
% 	Task = data_task:get(TaskId),
% 	get_ring_task_id_by_step(Task#task.next, Step - 1).


%% @doc 判断任务能否可接
%% @return code
%% @end
can_accept(null, _Status) -> ?ERROR;
can_accept(Task, Status) ->
	% @todo 不再检测任务是否过期
	TaskId = Task#task.id,
	Trigger = get_trigger(),
	case item_task_accept_condition(TaskId) of
		true -> true;
		false ->
            case lists:member({TaskId, ?TASK_CAN_ACCEPT}, Trigger) orelse 
                 can_accept_ring_task(Task, Trigger) orelse 
                 is_xs_task(TaskId) orelse
                 is_faction_fight_task(TaskId) orelse
                 is_sanjie_task(TaskId) of
				false -> ?TASK_STATE_ERROR;
				true ->
					case over_task_limit() of
						true -> ?OVER_TASK_LIMIT;
						false ->
							case check_begin_bag_volume(TaskId, Status) of
								false -> ?BAG_OVERRIDE;
								true -> 
									case is_fit_role_number(Task, Status) of
										true ->
                                            case is_sanjie_task(TaskId) of
                                                true ->
                                                    is_extra_condition(Task#task.type, TaskId, Status);
                                                false ->
                                                    ?SUCCESS
                                            end;
%%											case is_extra_condition(can_accept, TaskId, Status) of
%%												true -> ?SUCCESS;
%%												false -> ?ERROR
%%											end;
										{false, ErrCode} -> ErrCode
									end
							end
					end
			end
	end.


is_fit_role_number(Task, _Status) when Task#task.team =< 0 -> true;
is_fit_role_number(Task, Status) when Task#task.team == 1 -> 
	case Task#task.type == ?TASK_MAIN_TYPE of
		true -> true;
		false -> ?BIN_PRED(player:is_in_team(Status), {false, ?TASK_CAN_NOT_IN_TEAM}, true)
	end;
is_fit_role_number(Task, Status) ->
	%% 跨服组队抓鬼的话这里就不判断了，因为玩家在本服是没有队伍的，队伍人数已经在跨服节点做了判断了，所以跳过即可
	case lib_cross:check_is_remote() of
		true ->
			true;
		false ->
			Num = Task#task.team,
			case player:is_in_team(Status) of
				true -> 
					TeamId = player:get_team_id(Status),
					TeamMemberNum = mod_team:get_normal_member_count(TeamId),
					?BIN_PRED(TeamMemberNum >= Num, true, {false, ?NOT_ENOUGH_PEOPLE});
				false -> {false, ?NOT_ENOUGH_PEOPLE}
			end
	end.



can_accept_ring_task(Task, _) when Task#task.ring =:= 0 -> false;
can_accept_ring_task(Task, Trigger) ->
	case get_task_ring_state(Task) of
		null -> 
			case Task#task.ring of
				{HeadId, RingCount,_,Times ,_} -> 
					case lists:member(HeadId, Trigger) of
						true ->
							case get_task_ring(Task#task.id) of
								RingTask when is_record(RingTask, task_ring) ->
									case RingTask#task_ring.ring =< RingCount + 1 of
										true -> 
											RingTask#task_ring.times =< Times;
										false ->
											RingTask#task_ring.times =< Times + 1
									end;
								_ -> false
							end;
						false -> false
					end;
				_ -> false
			end;
		_ -> false
	end.
				

-define(MAX_TASK_ACCEPT_NO, 100).
%% @doc判断任务数量是否满载
over_task_limit() ->
	AccList = get_accepted_list(),
	length(AccList) >= ?MAX_TASK_ACCEPT_NO.


%% @doc 判断任务能否完成
%% @return code
%% @end
can_finish_condition(Task, Status) ->
	TaskId = Task#role_task.id,
	case is_task_finish(Task) of
		false -> ?TASK_STATE_ERROR;
		true ->
			case check_finish_bag_volume(TaskId, Status) of
				false -> ?BAG_OVERRIDE;
				true ->
					case is_extra_condition(finish, TaskId, Status) of
						true -> ?SUCCESS;
						false -> ?ERROR
					end
			end
	end.


%% @doc 取得公元1年到当前的天数
%% @end
get_now_date() ->
	calendar:date_to_gregorian_days(date()).


%% @doc 回收任务发放的物品
%% @retrun true | false
%% @end
cyc_task_offer_item(TaskId, Status) ->
	Task = data_task:get(TaskId),
	ItemList = Task#task.start_item,
	%% @todo 删除物品
	catch delete_task_item( player:id(Status), ItemList, TaskId).


%% @doc 回收任务物品
%% @retrun true | false
%% @end
cyc_task_item(TaskId, [], Status) ->
	Task = data_task:get(TaskId),
	ItemList = Task#task.end_item,
	case ItemList of
		[] -> true;
		[A | _] when is_tuple(A) ->
			case is_ingore_end_item(Task) of
				true ->
					F = fun({ItemNo, Num, IsAll}, {Flag, Sum}) ->
							case IsAll =:= 1 of
								true -> 
									Count = mod_inv:get_goods_count_in_bag_by_no(player:id(Status), ItemNo),
									case Count >= Num of
										true -> {Flag, [{ItemNo, Count} | Sum]};
										false -> {Flag + 1, Sum}
									end;
								false ->
									{Flag, [{ItemNo, Num} | Sum]}
							end
						end,
					{Flag1, Sum1} = lists:foldl(F, {0, []}, ItemList),
					case Flag1 > 0 of
						true -> false;
						false -> delete_task_item(player:id(Status), Sum1, TaskId)
					end,
					true;
				false -> 
					F = fun({ItemNo, Num, IsAll}, {Flag, Sum}) ->
							case IsAll =:= 1 of
								true -> 
									Count = mod_inv:get_goods_count_in_bag_by_no(player:id(Status), ItemNo),
									case Count >= Num of
										true -> {Flag, [{ItemNo, Count} | Sum]};
										false -> {Flag + 1, Sum}
									end;
								false ->
									{Flag, [{ItemNo, Num} | Sum]}
							end
						end,
					{Flag1, Sum1} = lists:foldl(F, {0, []}, ItemList),
					case Flag1 > 0 of
						true -> false;
						false -> delete_task_item(player:id(Status), Sum1, TaskId)
					end
			end;
		[A | _] when is_integer(A) ->
			delete_task_item(player:id(Status), [{A, 1}], TaskId);
		_ -> ?ASSERT(false), false
	end;

cyc_task_item(TaskId, ItemIdList, Status) ->
	RoleId = player:id(Status),
	Task = data_task:get(TaskId),
	ItemNoList = Task#task.end_item,
	CheckList = [{mod_inv:get_goods_no_by_goods_id(RoleId, Id), Id, Num1} || {Id, Num1} <- ItemIdList, is_integer(Id)],
	case ItemNoList of
		[] -> true;
		[A | _] when is_tuple(A) ->
			F = fun({ItemNo, Num, _}, {Flag, Sum}) ->
					case lists:keyfind(ItemNo, 1, CheckList) of
						false -> {Flag + 1, Sum};
						{ItemNo, ItemId, _ItemNum} -> 
							case mod_inv:get_goods_count_in_bag_by_id(RoleId, ItemId) >= Num of
								true -> {Flag, [{ItemId, Num} | Sum]};
								false -> {Flag + 1, Sum}
							end
					end
				end,
			{Flag1, Sum1} = lists:foldl(F, {0, []}, ItemNoList),
			case Flag1 > 0 of
				true -> false;
				false -> delete_task_item_by_id(RoleId, Sum1, TaskId)
			end;
		[A | _] when is_integer(A) ->
			F = fun({ItemId, Num}, {Flag, Sum}) ->
					ItemNo = mod_inv:get_goods_no_by_goods_id(RoleId, ItemId),
					case lists:member(ItemNo, ItemNoList) of
						true -> {Flag, [{ItemId, Num} | Sum]};
						false -> {Flag + 1, Sum}
					end
				end,
			{Flag1, Sum1} = lists:foldl(F, {0, []}, ItemIdList),
			case Flag1 > 0 of
				true -> false;
				false -> delete_task_item_by_id(RoleId, Sum1, TaskId)
			end;
		_ -> ?ASSERT(false), false
	end.



is_ingore_end_item(Task) when is_record(Task, task) ->
	[[Type | _] | _] = Task#task.content,
	Type =:= send.





%% @doc 任务开始时回收物品
%% @retrun true | {false, ErrCode}
%% @end
cyc_task_start_item(TaskId, Status) ->
	Task = data_task:get(TaskId),
	case case player:has_enough_money(Status, ?MNY_T_BIND_GAMEMONEY, Task#task.start_cost) of
			true -> player:has_enough_money(Status, ?MNY_T_GAMEMONEY, Task#task.start_ub_cost);
			false -> false
		end of
		false -> 
			{false, ?TASK_MONEY_ERROR};
		true ->
			case delete_task_item( player:id(Status), Task#task.start_recycle, TaskId) of
				true -> 
					player:cost_money(Status, ?MNY_T_BIND_GAMEMONEY, Task#task.start_cost, [?LOG_TASK, TaskId]),
					player:cost_money(Status, ?MNY_T_GAMEMONEY, Task#task.start_ub_cost, [?LOG_TASK, TaskId]),
					true;
				_ -> {false, ?TASK_ITEM_ERROR}
			end
	end.

	% ItemList = Task#task.start_recycle,
	% %% @todo 删除物品
	% delete_task_item( player:id(Status), ItemList, TaskId).


%% @doc 删除任务物品
%% @spec delete_task_item(RoleId, ItemList) -> true | false
delete_task_item(_RoleId, [], _TaskId) -> true;
delete_task_item(RoleId, ItemList, TaskId) -> mod_inv:destroy_goods_WNC(RoleId, ItemList, [?LOG_TASK, TaskId]).

delete_task_item_by_id(_, [], _) -> true;
delete_task_item_by_id(RoleId, ItemIdList, TaskId) -> mod_inv:destroy_goods_by_id_WNC(RoleId, ItemIdList, [?LOG_TASK, TaskId]).


%% @doc 任务开始发放物品
%% @retrun ok | fail
%% @end
offer_start_task_item(TaskId, Status) ->
	Task = data_task:get(TaskId),
	ItemList = Task#task.start_item,
	%% @todo 添加物品
	case ItemList =:= [] of
		true -> skip;
		false ->
			mod_inv:batch_smart_add_new_goods( player:id(Status), ItemList, [{bind_state, ?BIND_ON_GET}], [?LOG_TASK, TaskId])
	end.


%% @doc 检测背包容量是否满足任务发放物品种类
check_begin_bag_volume(TaskId, Status) ->
	Task = data_task:get(TaskId),
	ItemList = Task#task.start_item,
	case ItemList =:= [] of
		true -> true;
		false -> 
			case mod_inv:check_batch_add_goods( player:id(Status), ItemList) of
				ok -> true;
				_ -> false
			end
	end.

check_finish_bag_volume(TaskId, Status) ->
	Task = data_task:get(TaskId),
	RewardIds = Task#task.reward,
	
	case RewardIds of
		[] -> true;
		_ ->
			Ids = [Id || {_, Id} <- RewardIds],
			% ?LDS_TRACE(check_finish_bag_volume, [is_record(Status, player_status), Ids]),
			case lib_reward:check_bag_space(Status, Ids) of
				ok -> true;
				{fail, _Reason} -> false
			end
	end.
	% ItemList = Task#task.end_item,
	% case ItemList =:= [] of
	% 	true -> true;
	% 	false -> 
	% 		case mod_inv:check_batch_add_goods(Status#player_status.id, ItemList) of
	% 			ok -> true;
	% 			_ -> false
	% 		end
	% end.
	

%% @doc 发放任务完成奖励
send_reward(Task, Status) ->
	%% 添加经验
	Exp = Task#task.exp,
	player:add_exp(Status, Exp, [?LOG_TASK, [Task#task.id]]),
	% TeamLv = mod_team:get_member_average_lv(player:id(Status)),
	RewardIds = Task#task.reward,
	F = fun({_HardLv, Rid}) ->
		CheckFlag = case is_auto_submit_task(Task) of
			true -> true;
			false -> 
				case lib_reward:check_bag_space(Status, Rid) of
					ok -> true;
					{fail, Rea} -> {fail, Rea}
				end
		end,
		case CheckFlag of
			true ->
				case Task#task.ring of
					0 -> lib_reward:give_reward_to_player(common, Status, Rid, [], [?LOG_TASK, Task#task.id]);
					{MasterId, _, _, _, _} ->
						{Ring, Times} = 
							case get_task_ring(MasterId) of
								null -> ?ASSERT(false), {1, 1};
								Rd -> {?BIN_PRED(Rd#task_ring.ring < 1, 1, Rd#task_ring.ring), Rd#task_ring.times}
							end,
						lib_reward:give_reward_to_player(task, Status, Rid, [Task#task.id, Ring, 0, Times], [?LOG_TASK, Task#task.id])
				end;
			{fail, Reason} -> lib_send:send_prompt_msg(Status, Reason)
		end
	end,
	lists:foreach(F, RewardIds).


task_ghost_exp(PS, TaskNo, Exp) ->
	TaskType = lib_task:get_task_type(TaskNo),
	case TaskType == ?TASK_GOSHT_TYPE orelse TaskType == ?TASK_GOSHT_KING_TYPE of
		?true ->
			case mod_buff:has_buff(player, player:id(PS), ?BFN_ADD_ZHUOGUI_EXP) of
				false ->
					Exp;
				true ->
					case mod_buff:get_buff_state_by_name(player, player:id(PS), ?BFN_ADD_ZHUOGUI_EXP) of
						0 ->
							Exp;
						1 ->
							BuffPara = mod_buff:get_buff_para_by_name(player, player:id(PS), ?BFN_ADD_ZHUOGUI_EXP),
							?ASSERT(BuffPara =/= null andalso is_integer(BuffPara)),
							util:ceil(Exp * BuffPara)
					end
			end;
		?false ->
			Exp
	end.


is_auto_submit_task(Task) ->
	Count = lists:foldl(
		fun([Event | _], Count) -> 
			case Event == auto_submit of
				true -> Count + 1;
				false -> Count
			end 
		end, 0, Task#task.finish_event),
	Count > 0.


%% 强行设置任务状态 (gm)
set_task_state(TaskId, State) ->
	case get_accepted(TaskId) of
		null ->
			% ?LDS_TRACE("set task state", null),
			fail;
		Task ->
			update_accepted(Task#role_task{state = State}),
			ok
	end.

set_finish(TaskId, Status) ->
	force_accept(TaskId, Status),
	set_task_state(TaskId, ?TASK_COMPLETED),
	submit(TaskId, [], Status).

%% @doc 定期任务

%% =======================================================	
%% ------------------- memery data -----------------------
%% =======================================================	

-define(TASK_OPERATION, {task, operation}).

%% @doc 缓存数据操作, 采用process dict数据结构保存操作数据，保证最新操作在列表最前
%%		每次插入均进行一次压缩操作
%% @end
cache_task_operation(OpType, Content) ->
	case get(?TASK_OPERATION) of
		undefined -> 
			put(?TASK_OPERATION, [{OpType, Content}]);
		List ->
			NewList = compress({OpType, Content}, List),	
			put(?TASK_OPERATION, NewList)
	end.
	

%% @doc 合并压缩任务操作，必须保证最新操作在列表最前
%% 		update1 + update2 -> update1; 	update1 + insert2 -> insert1; 
%%		insert  + * -> insert; 			insert  + delete -> update
%%		delete + * -> delete
%% @end
compress(Elm, List) ->
	compress_1(Elm, List, []).

compress_1(Elm, [], Sum) -> [Elm | lists:reverse(Sum)];
% compress_1({insert, _} = Elm, List, Sum) -> [Elm | lists:reverse(Sum)] ++ List;
compress_1({insert, #role_task{id = Id} = Task} = Elm, 
				[{Op2, #role_task{id = Id}} | Left] = _List, Sum) ->
	if % Op2 =:= insert -> ?ASSERT(false), [Elm | lists:reverse(Sum)] ++ Left; 
	   % Op2 =:= delete -> [{update, Task} | lists:reverse(Sum)] ++ Left;
	   % true -> [Elm | lists:reverse(Sum)] ++ List
	   Op2 =:= delete -> compress_1({update, Task}, Left, Sum);
	   true -> ?ERROR_MSG("compress task error curOP = ~p, cache = ~p~n", [Elm, _List]), compress_1(Elm, Left, Sum)
	end;
compress_1({update, #role_task{id = Id} = Task}, 
				[{Op2, #role_task{id = Id}} | Left] = _List, Sum) ->
	if Op2 =:= insert -> compress_1({insert, Task}, Left, Sum);
	   Op2 =:= update -> compress_1({update, Task}, Left, Sum);
	   Op2 =:= delete -> ?ASSERT(false), ?ERROR_MSG("compress task error curOP = ~p, cache = ~p~n", [{update, Task}, _List]), 
	   					 compress_1({update, Task}, Left, Sum);
	   true -> ?ERROR_MSG("compress task error curOP = ~p, Op2 = ~p~n", [Task, Op2]), ?ASSERT(false), []
	end;
compress_1({delete, #role_task{id = Id}} = Elm1, 
				[{Op2, #role_task{id = Id}} | Left], Sum) ->
	if Op2 =:= insert -> lists:reverse(Sum) ++ Left;
		true -> compress_1(Elm1, Left, Sum)
	end;

compress_1({insert, #completed{id = Id} = Task} = Elm, 
				[{Op2, #completed{id = Id}} | Left] = _List, Sum) ->
	if % Op2 =:= insert -> ?ASSERT(false), [Elm | lists:reverse(Sum)] ++ Left; 
	   % Op2 =:= delete -> [{update, Task} | lists:reverse(Sum)] ++ Left;
	   Op2 =:= delete -> compress_1({update, Task}, Left, Sum);
	   true -> ?ERROR_MSG("compress task error curOP = ~p, cache = ~p~n", [Elm, _List]), ?ASSERT(false), compress_1(Elm, Left, Sum)
	end;
compress_1({update, #completed{id = Id} = Task},             
				[{Op2, #completed{id = Id}} | Left], Sum) ->
	if Op2 =:= insert -> compress_1({insert, Task}, Left, Sum);
	   Op2 =:= update -> compress_1({update, Task}, Left, Sum);
	   Op2 =:= delete -> ?ASSERT(false),compress_1({update, Task}, Left, Sum);
	   true -> ?ERROR_MSG("compress task error curOP = ~p, Op2 = ~p~n", [Task, Op2]), ?ASSERT(false), []
	end;
compress_1({delete, #completed{id = Id}} = Elm1,           
				[{Op2, #completed{id = Id}} | Left], Sum) ->
	if Op2 =:= insert -> lists:reverse(Sum) ++ Left;
		true -> compress_1(Elm1, Left, Sum)
	end;

compress_1({insert, #task_ring{masterId = Id} = Ring} = Elm, [{Op2, #task_ring{masterId = Id}} | Left] = _List, Sum) ->
	% [Elm | lists:reverse(Sum)] ++ List;
	if  Op2 =:= delete -> compress_1({update, Ring}, Left, Sum);
		true -> ?ERROR_MSG("compress task error curOP = ~p, cache = ~p~n", [Elm, _List]), ?ASSERT(false, [Ring]), compress_1(Elm, Left, Sum)
	end;

compress_1({update, #task_ring{masterId = Id} = Ring1} = Elm, [{Op2, #task_ring{masterId = Id}} | Left] = _List, Sum) ->
	if Op2 =:= insert -> compress_1({insert, Ring1}, Left, Sum);
	   Op2 =:= update -> compress_1({update, Ring1}, Left, Sum);
	   true -> ?ERROR_MSG("compress task error curOP = ~p, cache = ~p~n", [Elm, _List]), ?ASSERT(false), compress_1({update, Ring1}, Left, Sum)
	end;

compress_1({insert, #completed_unrepeat{task_type = Type}} = Elm, [{Op2, #completed_unrepeat{task_type = Type}} | Left], Sum) ->
	if  Op2 =:= delete -> compress_1({update, Elm}, Left, Sum);
		true -> ?ASSERT(false, [Type])
	end;

compress_1({update, #completed_unrepeat{task_type = Type} = Task}, [{Op2, #completed_unrepeat{task_type = Type}} | Left], Sum) ->
	if  Op2 =:= insert -> compress_1({insert, Task}, Left, Sum);
		Op2 =:= update -> compress_1({update, Task}, Left, Sum);
		true -> ?ASSERT(false, [Type])
	end;

compress_1(Elm1, [Elm2 | Left], Sum) ->
	compress_1(Elm1, Left, [Elm2 | Sum]).


-define(KEY_TRIGGER, {task, trigger}).
-define(KEY_ACCEPTED_SET, {task, accepted}).
-define(KEY_ACCEPTED(Id), {task, accepted, Id}).
-define(KEY_COMPLETED_UNREPEAT, {task, completed, unrepeat}).
-define(KEY_COMPLETED_REPEAT, {task, completed, repeat}).
-define(KEY_COMPLETED(Id), {task, completed, Id}).


%% @doc 取得已接任务record
get_task_accepted(TaskId) ->
	case get(?KEY_ACCEPTED(TaskId)) of
		undefined -> [];
		Rd -> Rd
	end.

%% @doc 触发任务
set_trigger(Content) ->
	put(?KEY_TRIGGER, Content).

add_trigger(TaskId, State) ->
	case get(?KEY_TRIGGER) of
		undefined ->
			put(?KEY_TRIGGER, [{TaskId, State}]);
		List ->
			put(?KEY_TRIGGER, [{TaskId, State} | List])
	end.

del_trigger(TaskId, State) ->
	case get(?KEY_TRIGGER) of
		undefined ->
			?ASSERT(false);
		List ->
			NewList = lists:delete({TaskId, State}, List),
			put(?KEY_TRIGGER, NewList)
	end.

get_trigger() ->
	case get(?KEY_TRIGGER) of
		undefined -> [];
		List -> List
	end.

-define(TASK_ADD, 1).

%% @doc 已接任务
add_accepted(RoleTask) ->
	TaskId = RoleTask#role_task.id,
	case get(?KEY_ACCEPTED_SET) of
		undefined ->
			put(?KEY_ACCEPTED_SET, [TaskId]);
		List ->
			put(?KEY_ACCEPTED_SET, [TaskId | List])
	end,
	put(?KEY_ACCEPTED(TaskId), RoleTask).
	

del_accepted(TaskId) ->
	case get(?KEY_ACCEPTED_SET) of
		undefined ->
			?ASSERT(false);
		List ->
			put(?KEY_ACCEPTED_SET, lists:delete(TaskId, List))
	end,
	erlang:erase(?KEY_ACCEPTED(TaskId)).

del_accepted_db(TaskId) ->
	case get_accepted(TaskId) of
		null -> ?ASSERT(false), skip;
		Rd -> 
			del_accepted(TaskId),
			cache_task_operation(delete, Rd)
	end.
	

update_accepted(Task) ->
	put(?KEY_ACCEPTED(Task#role_task.id), Task),
	cache_task_operation(update, Task).

get_accepted_list() ->
	case get(?KEY_ACCEPTED_SET) of
		undefined -> [];
		Rd -> Rd
	end.

get_accepted(TaskId) ->
	case get(?KEY_ACCEPTED(TaskId)) of
		undefined -> null;
		Rd -> Rd
	end.


add_completed_db(TaskId) when is_integer(TaskId) ->
	case data_task:get(TaskId) of
		Task when is_record(Task, task) ->
			add_completed_db(Task);
		_ -> ?ASSERT(false, [TaskId]), ?ERROR_MSG("add_completed_db error = ~p~n", [TaskId])
	end;
add_completed_db(Task) when is_record(Task, task) ->
	case lists:member(Task#task.type, ?UNREPEAT_TASK_TYPES) of
		true -> 
			NowDate = get_now_date(),
			Rd = #completed_unrepeat{id = Task#task.id, date = NowDate, task_type = Task#task.type},
			reset_unrepeat_completed(Rd),
			cache_task_operation(update, Rd);
		false ->
			NowDate = get_now_date(),
			case lists:member(Task#task.type, ?REPEAT_TASK_TYPES) orelse lists:member(Task#task.type, ?DUNGEON_TASK_TYPES) of
				true ->
					case get_repeat_completed_list() of
						[] -> 
							set_repeat_completed_list([Task#task.id]),
							case get_repeat_completed(Task#task.id) of
								null -> 
									Rd = #completed{id = Task#task.id, date = NowDate, task_type = Task#task.type},
									set_repeat_completed(Rd),
									cache_task_operation(insert, Rd);
								Completed ->
									?ASSERT(false, [Task#task.id, Completed]),
									?ERROR_MSG("task add_completed_db repeat task = ~p, completed = ~p~n", [Task#task.id, Completed]),
									OldDate = Completed#completed.date,
									OldTimes = Completed#completed.times,	
									NewCompleted = 
										if  Task#task.day_task =:= 1 ->
												?BIN_PRED(OldDate =:= NowDate, 
														  Completed#completed{times = OldTimes + 1},
														  Completed#completed{date = NowDate, times = 1}
														  );
										    Task#task.week_task =/= 0 ->	
												?BIN_PRED(is_week_round(OldDate, NowDate, Task#task.week_task),
														  Completed#completed{times = OldTimes + 1},
														  Completed#completed{date = NowDate, times = 1}
														  );
										    true -> Completed#completed{times = OldTimes + 1}
										end,
									% Completed#completed{date = NowDate, times = Completed#completed.times + 1},
									set_repeat_completed(NewCompleted),
									cache_task_operation(update, NewCompleted)
							end;
						List ->
							case lists:member(Task#task.id, List) of
								true -> skip;
								false -> set_repeat_completed_list([Task#task.id | List])
							end,
							case get_repeat_completed(Task#task.id) of
								null -> 
									% ?ASSERT(false, [Task#task.id]),
									% ?ERROR_MSG("task add_completed_db repeat task = ~p~n", [Task#task.id]),
									Rd = #completed{id = Task#task.id, date = NowDate, task_type = Task#task.type},
									set_repeat_completed(Rd),
									cache_task_operation(insert, Rd);
								Completed ->
									OldDate = Completed#completed.date,
									OldTimes = Completed#completed.times,
									NewCompleted = 
										if  Task#task.day_task =:= 1 ->
												?BIN_PRED(OldDate =:= NowDate, 
														  Completed#completed{times = OldTimes + 1},
														  Completed#completed{date = NowDate, times = 1}
														  );
										    Task#task.week_task =/= 0 ->	
												?BIN_PRED(is_week_round(OldDate, NowDate, Task#task.week_task),
														  Completed#completed{times = OldTimes + 1},
														  Completed#completed{date = NowDate, times = 1}
														  );
										    true -> Completed#completed{times = OldTimes + 1}
										end,
									% Completed#completed{date = NowDate, times = Completed#completed.times + 1},
									set_repeat_completed(NewCompleted),
									cache_task_operation(update, NewCompleted)
							end
					end;
				false -> skip
			end
	end,
	ok;
add_completed_db(_A) -> ?ASSERT(false, [_A]), ?ERROR_MSG("add_completed_db error = ~p~n", [_A]).


add_unrepeat_completed(Task) when is_record(Task, completed_unrepeat) ->
	set_unrepeat_completed(Task).


add_repeat_completed(Task) when is_record(Task, completed) ->
	add_repeat_completed_list(Task#completed.id),
	set_repeat_completed(Task).


del_completed(Task) when is_record(Task, completed) ->
	% TaskData = data_task:get(Task#completed.id),
	case lists:member(Task#completed.task_type, ?REPEAT_TASK_TYPES) orelse lists:member(Task#completed.task_type, ?DUNGEON_TASK_TYPES)
		orelse lists:member(Task#completed.id, data_task:get_dungeon_task_ids()) of
		false -> 
			?ASSERT(false, [Task]),
			?ERROR_MSG("task del_completed not repeat task = ~p~n", [Task]),
			del_repeat_completed_list(Task#completed.id),
			del_repeat_completed(Task);
		true -> 
			del_repeat_completed_list(Task#completed.id),
			del_repeat_completed(Task)
	end.

-define(TASK_UNREPEAT(Type), {task, unrepeat, Type}).
-define(TASK_REPEAT_LIST, {task, repeat_list}).
-define(TASK_REPEAT(Id), {task, repeat, Id}).

get_unrepeat_completed(Type) ->
	case get(?TASK_UNREPEAT(Type)) of
		undefined -> null;
		Rd when is_record(Rd, completed_unrepeat) -> Rd;
		_ -> ?ASSERT(false, [Type]), null
	end.

reset_unrepeat_completed(Completed) ->
	put(?TASK_UNREPEAT(Completed#completed_unrepeat.task_type), Completed).

set_unrepeat_completed(Completed) ->
	put(?TASK_UNREPEAT(Completed#completed_unrepeat.task_type), Completed).


set_repeat_completed_list(List) ->
	put(?TASK_REPEAT_LIST, List).

get_repeat_completed_list() ->
	case get(?TASK_REPEAT_LIST) of
		undefined -> [];
		List when is_list(List) -> List; 
		_ -> ?ASSERT(flase), []
	end.

add_repeat_completed_list(Elem) ->
	List = get_repeat_completed_list(),
	case lists:member(Elem, List) of
		true -> skip;
		false -> set_repeat_completed_list([Elem | List])
	end.

del_repeat_completed_list(Elem) ->
	List = get_repeat_completed_list(),
	case lists:member(Elem, List) of
		true -> set_repeat_completed_list(lists:delete(Elem, List));
		false -> skip
	end.

set_repeat_completed(Rd) ->
	put(?TASK_REPEAT(Rd#completed.id), Rd).

del_repeat_completed(Rd) ->
	erase(?TASK_REPEAT(Rd#completed.id)).

get_repeat_completed(TaskId) ->
	case get(?TASK_REPEAT(TaskId)) of
		undefined -> null;
		Rd when is_record(Rd, completed) -> Rd;
		_ -> ?ASSERT(false)
	end.

% get_completed(TaskId) ->
% 	case get(?KEY_COMPLETED(TaskId)) of
% 		undefined -> null;
% 		Rd -> Rd
% 	end.

get_completed_list() ->
	get_completed_list(repeat) ++ get_completed_list(unrepeat).

get_completed_list(unrepeat) ->
	case get(?KEY_COMPLETED_UNREPEAT) of
		undefined -> [];
		Set -> sets:to_list(Set)
	end;

get_completed_list(repeat) ->
	case get(?KEY_COMPLETED_REPEAT) of
		undefined -> [];
		Set -> sets:to_list(Set)
	end.


is_task_repeat(Task) ->
	Task#task.repeat > 1 orelse
	Task#task.day_task =:= 1 orelse
	Task#task.week_task =:= 1.


-define(WEEK_DAYS, 7).

is_week_round(OldDate, OldDate, _) -> true;
is_week_round(OldDate, NewDate, _) when OldDate + ?WEEK_DAYS =< NewDate -> false;
is_week_round(OldDate, NewDate, RefreshDay) ->
	OldDateFmt = calendar:gregorian_days_to_date(OldDate),
	NewDateFmt = calendar:gregorian_days_to_date(NewDate),
	OldWeekDay = calendar:day_of_the_week(OldDateFmt),
	NewWeekDay = calendar:day_of_the_week(NewDateFmt),
	if
		OldWeekDay =:= NewWeekDay -> true;
		true ->
			DayList = 
				case OldWeekDay < NewWeekDay of
					true -> lists:seq(OldWeekDay + 1, NewWeekDay);
					false -> 
						case OldWeekDay =:= 7 of
							true -> lists:seq(1, NewWeekDay);
							false -> lists:seq(OldWeekDay + 1, 7) ++ lists:seq(1, NewWeekDay)
						end
				end,
			not lists:member(RefreshDay, DayList)

			% DayList = lists:seq(OldWeekDay + 1, NewWeekDay),
			% List = tool:to_list(RefreshDay),
			% [X || X <- DayList, lists:member(X, List)] =/= []
	end.
	% OldWeekNo = calendar:iso_week_number(OldDateFmt),
	% NewWeekNo = calendar:iso_week_number(NewDateFmt),
	% OldWeekNo =:= NewWeekNo.


%% 保存任务定时器句柄
add_timing_ref(Ref) ->
	List = case get(?TASK_TIMING_REF) of
		undefined -> [Ref];
		Rd -> [Ref | Rd]
	end,
	put(?TASK_TIMING_REF, List).

get_timing_ref() ->
	case get(?TASK_TIMING_REF) of
		undefined -> [];
		List -> List
	end.


clean_all_timing() ->
	List = get_timing_ref(),
	[erlang:cancel_timer(Ref) || Ref <- List].

			
-define(AUTO_TASK_TRIGGER, auto_task_trigger).
-define(AUTO_TASK_TRIGGER_NEW, auto_task_trigger_new).

%% 所有最新自动触发任务数据
get_auto_task_trigger_list() ->
	case get(?AUTO_TASK_TRIGGER) of
		undefined -> [];
		List -> List
	end.

%% 最新自动触发任务，（只包含还未存库的数据）
get_auto_task_trigger_new_list() ->
	case get(?AUTO_TASK_TRIGGER_NEW) of
		undefined -> [];
		Set -> sets:to_list(Set)
	end.

get_auto_task_trigger_new_set() ->
	case get(?AUTO_TASK_TRIGGER_NEW) of
		undefined -> sets:new();
		Set -> Set
	end.

add_auto_task_trigger(TaskId) ->
	List = get_auto_task_trigger_list(),
	case lists:member(TaskId, List) of
		true -> skip;
		false -> add_auto_task_trigger(List, TaskId)
	end.

add_auto_task_trigger(List, TaskId) ->
	put(?AUTO_TASK_TRIGGER, [TaskId | List]),
	add_auto_task_trigger_new(TaskId).

add_auto_task_trigger_new(TaskId) ->
	Set = get_auto_task_trigger_new_set(),
	put(?AUTO_TASK_TRIGGER_NEW, sets:add_element(TaskId, Set)).

init_auto_task_trigger(List) ->

	put(?AUTO_TASK_TRIGGER, [TaskId || TaskId <- List, is_record((data_task:get(TaskId)), task)]).

-define(AUTO_TASK_TRIGGER_SWITCH, auto_task_trigger_switch).
set_auto_task_trigger_switch(Switch) when is_boolean(Switch) ->
	put(?AUTO_TASK_TRIGGER_SWITCH, Switch);
set_auto_task_trigger_switch(_) -> skip.

get_auto_task_trigger_switch() ->
	case get(?AUTO_TASK_TRIGGER_SWITCH) of
		Switch when is_boolean(Switch) -> Switch;
		_ -> false
	end.


% set_task_seed(RoleId) ->
% 	Seed = rand_task_seed(),
% 	% put(?TASK_SEED, Seed).
% 	ets:insert(?ETS_TASK_RAND_SEED, {RoleId, Seed}).

% set_task_seed(RoleId, Seed) ->
% 	% put(?TASK_SEED, Seed).
% 	ets:insert(?ETS_TASK_RAND_SEED, {RoleId, Seed}).

% get_task_seed() ->
% 	case get(?TASK_SEED) of
% 		undefined -> null;
% 		Seed -> Seed
% 	end.

rand_task_seed() ->
	util:rand(1, 100).


get_task_ring(TaskId) ->
	case get(?TASK_RING(TaskId)) of
		undefined -> null;
		Rd -> Rd
	end.

%% 设置环任务状态
set_task_ring_state(Task, State) ->
	case Task#task.ring of
		{MasterId, _, _, _, _} ->
			put(?TASK_RING_ACCEPTED(MasterId), State);
		0 -> skip
	end.

get_task_ring_state(Task) ->
	{MasterId, _, _, _, _} = Task#task.ring,
	case get(?TASK_RING_ACCEPTED(MasterId)) of
		undefined -> null;
		State -> State
	end.

release_ring_task_falg(Task) ->
	case Task#task.ring of
		{MasterId, _, _, _, _} ->
			erase(?TASK_RING_ACCEPTED(MasterId));
		0 -> skip
	end. 

set_task_ring(TaskId, Ring) ->
	put(?TASK_RING(TaskId), Ring),
	add_task_ring_id_list(TaskId).


-define(TASK_RING_ID_LIST, {task, ring_ids}).

add_task_ring_id_list(TaskId) ->
	List = get_task_ring_id_list(),
	put(?TASK_RING_ID_LIST, [TaskId | List]).

del_task_ring_id_list(TaskId) ->
	List = get_task_ring_id_list(),
	put(?TASK_RING_ID_LIST, lists:delete(TaskId, List)).


%% @return list()
get_task_ring_id_list() ->
	case get(?TASK_RING_ID_LIST) of
		undefined -> [];
		Rd -> Rd
	end.


% set_task_ring_db(TaskId, Ring) ->
% 	case get_task_ring(TaskId) of
% 		null -> 
% 			set_task_ring(TaskId, Ring),
% 			cache_task_operation(insert, Ring);
% 		_OldRing ->
% 			update_task_ring(TaskId, Ring)
% 	end.
	% set_task_ring(TaskId, Ring),
	% cache_task_operation(insert, Ring).

update_task_ring(TaskId, Ring) ->
	put(?TASK_RING(TaskId), Ring),
	cache_task_operation(update, Ring).


get_current_setp_and_round(TaskId) ->
	Task = data_task:get(TaskId),
	case Task#task.ring of
		0 -> {0, 0};
		{MasterId, _, _, _, _} ->
			case get_task_ring(MasterId) of
				null ->
					% Rd = make_new_task_ring(MasterId),
					% set_task_ring_db(MasterId, Rd), 
					% ?ERROR_MSG("task_ring get_current_setp_and_round = ~p accepted = ~p, completed = ~p~n",  
					% 	[[TaskId, MasterId], get_trigger(), get_repeat_completed_list()]),
					{0, 0};
				Rd -> {Rd#task_ring.ring, Rd#task_ring.times}
			end
	end.

% 获取最大可获得奖励轮次
get_max_reward_round(TaskId) ->
	Task = data_task:get(TaskId),
	case Task#task.max_reward_round of
		MaxRound when is_integer(MaxRound) ->
			MaxRound;
		_ -> 0
	end.

get_ring_master_id(Rd) ->
	Rd#task_ring.masterId.


%% @retrun RoleTask | {update, NewRoleTask}
login_check_task(RoleTask, Status) when RoleTask#role_task.state =:= ?TASK_ACCEPTED ->
	RoleTask1 = check_task_finish(RoleTask, Status),
	Timing = (data_task:get(RoleTask1#role_task.id))#task.time_limit,
	% Timing = RoleTask1#role_task.timing,
	NewRoleTask = 
		case Timing > 0 of
			true -> 
				Now = util:unixtime(),
				AccTime = RoleTask1#role_task.accept_time,
				case AccTime + Timing < Now of
					true -> 
                        % 悬赏任务发送邮件
                        lib_xs_task:try_send_task_fail_mail(player:id(Status), RoleTask1#role_task.id),
                        RoleTask1#role_task{state = ?TASK_FAIL};
					false -> RoleTask1
				end;
			false -> RoleTask1
		end,
	case NewRoleTask#role_task.state =:= ?TASK_ACCEPTED of
		true -> NewRoleTask;
		false -> {update, NewRoleTask}
	end;
login_check_task(RoleTask, _Status) -> RoleTask.
% login_check_task(#role_task{monNo = {0, _}} = RoleTask, _Status) -> RoleTask;

% login_check_task(#role_task{monNo = {_MonNo, MonId}, id = TaskId, state = State} = RoleTask, Status) ->
% 	Task = data_task:get(TaskId),
% 	case State =:= ?TASK_COMPLETED of
% 		true -> skip;
% 		false ->
% 			case mod_mon:is_exists(MonId) of
% 				true -> skip;
% 				false -> accept_event(Task, Status)
% 			end
% 	end,
% 	RoleTask.

			
%% =======================================================			
%% -------------------- db data --------------------------
%% =======================================================	

%% @doc 下线回写自动触发任务数据
write_auto_task_trigger_db(RoleId) ->
	List = get_auto_task_trigger_new_list(),
	% mod_lgout_svr:common_handle(RoleId, lib_task, write_auto_task_trigger_db, [RoleId, List]).
	[db:replace(RoleId, task_auto_trigger, [{role_id, RoleId}, {task_id, TaskId}]) || 
	 TaskId <- List, is_integer(TaskId)].

% write_auto_task_trigger_db(RoleId, List) ->
% 	[db:replace(RoleId, task_auto_trigger, [{role_id, RoleId}, {task_id, TaskId}]) || 
% 	 TaskId <- List, is_integer(TaskId)].
	% mod_lgout_svr:common_handle(RoleId, lib_task, logout, [PS])	

%% @doc 上线读取自动触发任务数据
load_auto_task_trigger_db(RoleId) ->
	case db:select_all(task_auto_trigger, "task_id", [{role_id, RoleId}]) of
		[] ->skip;
		List -> init_auto_task_trigger(lists:flatten(List))
	end.


%% @doc 定时保存
timing_save(Status) when is_record(Status, player_status) ->
	case lib_comm:is_now_nearby_midnight() of
		true -> skip;
		false -> save_all_1_asyn( player:id(Status))
	end,
	Ref = erlang:start_timer(?SAVE_INTERVAL, player:get_pid(Status), 'timing_save_task'),
	add_timing_ref(Ref);
timing_save(_) -> skip.


%% @doc 保存所有任务数据
save_all(Status) ->
	gen_server:cast( player:get_pid(Status), 
		{apply_cast, ?MODULE, save_all_1_asyn, [player:id(Status)]}).

save_all_1_asyn(RoleId) ->
	case get(?TASK_OPERATION) of
		undefined -> skip;
		List ->
			% 由于新操作在列表最前，故须反转列表
			CorrectList = lists:reverse(List),
			erase(?TASK_OPERATION),		% 清空缓存
			util:actin_new_proc(?MODULE, save_all_1, [RoleId, CorrectList])		% 数据持久化
	end.

save_all_1_syn(RoleId) ->
	case get(?TASK_OPERATION) of
		undefined -> skip;
		List ->
			% 由于新操作在列表最前，故须反转列表
			CorrectList = lists:reverse(List),
			erase(?TASK_OPERATION),		% 清空缓存
			save_all_1(RoleId, CorrectList)
			% mod_lgout_svr:common_handle(RoleId, lib_task, save_all_1, [RoleId, CorrectList])
	end.

save_all_1(RoleId, List) ->
	% ?LDS_TRACE(task, "save all data"),
	[catch save(RoleId, Elm) || Elm <- List].
	% [save(RoleId, Elm) || Elm <- List].

save(RoleId, {insert, Rd}) when is_record(Rd, role_task) ->
	case db:select_row(task_bag, "role_id", [{role_id, RoleId}, {task_id, Rd#role_task.id}]) of
		[] ->
			db:insert(RoleId, task_bag, 
					  [{role_id, RoleId},
					   {task_id, Rd#role_task.id},
					   {state, Rd#role_task.state},
					   {accept_time, Rd#role_task.accept_time},
					   {timing, Rd#role_task.timing},
					   {monNo, util:term_to_bitstring(Rd#role_task.monNo)},
					   {mark, util:term_to_bitstring(Rd#role_task.mark)}
					   ]);
		_ -> skip
	end;

save(RoleId, {insert, Rd}) when is_record(Rd, completed) ->
	case db:select_row(task_completed, "role_id", [{role_id, RoleId}, {task_id, Rd#completed.id}]) of
		[] -> 
			db:insert(RoleId, task_completed,
					  [{role_id, RoleId},
					   {task_id, Rd#completed.id},
					   {date, Rd#completed.date},
					   {times, Rd#completed.times}
					   ]);
		_ -> skip
	end;

save(RoleId, {insert, Rd}) when is_record(Rd, task_ring) ->
	MasterId = get_ring_master_id(Rd),

	% 增加环上限判断 避免出现11个师门任务的情况
	RingMax = case data_task:get(MasterId) of  
		Task when is_record(Task, task) ->
			case Task#task.ring of
				0 -> 0;
				{_, RingCount, _, _, _} -> RingCount
			end;
		_ -> 0
	end,

	Ring = 
	case Rd#task_ring.ring > RingMax of
		false -> Rd#task_ring.ring;
		true -> Rd#task_ring.ring - RingMax
	end,

	?DEBUG_MSG("Ring1=~p,Ring1=~p,Ring1=~p",[RingMax,Ring,Rd#task_ring.ring]),

	db:insert(RoleId, task_ring,
			  [{role_id, RoleId},
			   {master_id, MasterId},
			   {ring, Ring},
			   {seed, Rd#task_ring.seed},
			   {times, Rd#task_ring.times},
			   {date, Rd#task_ring.date}
			   ]);

save(RoleId, {insert, Rd}) when is_record(Rd, completed_unrepeat) ->
	db:insert(RoleId, task_completed_unrepeat,
		[{role_id, RoleId},
		 {task_type, Rd#completed_unrepeat.task_type},
		 {task_id, Rd#completed_unrepeat.id},
		 {date, Rd#completed_unrepeat.date}
		]
		);


save(RoleId, {update, Rd}) when is_record(Rd, role_task) ->
	db:update(RoleId, task_bag,
			  [{state, Rd#role_task.state},
			   {accept_time, Rd#role_task.accept_time},
			   {timing, Rd#role_task.timing},
			   {monNo, util:term_to_bitstring(Rd#role_task.monNo)},
			   {mark, util:term_to_bitstring(Rd#role_task.mark)}],
			  [{role_id, RoleId}, {task_id, Rd#role_task.id}]);
save(RoleId, {update, Rd}) when is_record(Rd, completed) ->
	db:update(RoleId, task_completed,
			  [{date, Rd#completed.date}, {times, Rd#completed.times}],
			  [{role_id, RoleId}, {task_id, Rd#completed.id}]);
save(RoleId, {update, Rd}) when is_record(Rd, task_ring) ->
	MasterId = get_ring_master_id(Rd),
	db:update(RoleId, task_ring,
			  [{ring, Rd#task_ring.ring},
			   {seed, Rd#task_ring.seed},
			   {times, Rd#task_ring.times},
			   {date, Rd#task_ring.date}
			   ],
			  [{role_id, RoleId}, {master_id, MasterId}]);
save(RoleId, {update, Rd}) when is_record(Rd, completed_unrepeat) ->	
	db:update(RoleId, task_completed_unrepeat,
				[{task_id, Rd#completed_unrepeat.id}, {date, Rd#completed_unrepeat.date}],
				[{role_id, RoleId}, {task_type, Rd#completed_unrepeat.task_type}]
		);

save(RoleId, {delete, Rd}) when is_record(Rd, role_task) ->
	db:delete(RoleId, task_bag, [{role_id, RoleId}, {task_id, Rd#role_task.id}]);

save(RoleId, {delete, Rd}) when is_record(Rd, completed) ->
	db:delete(RoleId, task_completed, [{role_id, RoleId}, {task_id, Rd#completed.id}]);

save(_RoleId, _Op) ->
	?ERROR_MSG("fun:save, error:save wrong opertrion type = ~p, ~n ~p~n", [_RoleId, _Op]),
	?ASSERT(false, [_RoleId, _Op]),
	error.

% save_seed(RoleId) ->
% 	Seed = case get_task_seed() of
% 		null -> 
% 			?ASSERT(false),
% 			?ERROR_MSG("get task seed error~n", []),
% 			rand_task_seed();
% 		S -> S
% 	end,
% 	db:update(player, [{task_seed, Seed}], [{id, RoleId}]).


% save_ring(RoleId) ->
% 	List = get_task_ring_id_list(),
% 	redo.

% save_ring(RoleId, Ring) when is_record(Ring, ring_task) ->



%% @doc 任务登录加载
%% @end
login_load_task(Status, role_in_cache) ->
	RoleId = player:id(Status),
	% recover_task_data_from_ets_to_dict(RoleId),
	% recover_task_accepted(RoleId),
	% recover_task_completed(RoleId),
	% recover_task_ring(RoleId),
	% recover_task_auto_accept(RoleId),

	try recover_task_data_from_ets_to_dict(RoleId) of
		_ ->
			trigger(Status),
			set_task_flag(Status),
			timing_save(Status),
			publ_clean_all_dungeon_task(RoleId)
	catch
		_T:_E ->
			?ERROR_MSG("[task] tmp load task data error = ~p~n", [{_T, _E}]),
			clean_all_ets_tmp_data(RoleId),
			set_task_flag(Status),
			login_load_task(Status, not_in_cache)
	end;


login_load_task(Status, _) ->
	RoleId = player:id(Status),
	% load_seed(RoleId),
	load_accepted_task(Status),
	load_completed_task(RoleId),
	load_auto_task_trigger_db(RoleId),
	load_task_ring(RoleId),
	trigger(Status),
	set_task_flag(Status),
	timing_save(Status),
	clean_all_ets_tmp_data(RoleId),
	publ_clean_all_dungeon_task(RoleId).



%% 加载环任务
load_task_ring(RoleId) ->
	case db:select_all(task_ring, "master_id, ring, seed, times, date", [{role_id, RoleId}]) of 
		[] -> init_ring_task(RoleId);
		List when is_list(List) ->
			F = fun([MasterId, Ring, Seed, Times, Date]) ->
				case data_task:get(MasterId) of  
					Task when is_record(Task, task) ->
						set_task_ring(MasterId, 
							#task_ring{masterId = MasterId, ring = Ring, seed = Seed, times = Times, date = Date});
					_ -> db:delete(RoleId, task_ring, [{role_id, RoleId}, {master_id, MasterId}])
				end
			end,
			correct_ring_task(RoleId, List),
			lists:foreach(F, List);
		Error ->
			?ASSERT(false),
			?ERROR_MSG("fun:load_task_ring, error:wrong db data error = ~p~n", [Error]),
			error
	end.


init_ring_task(RoleId) ->
	RingList = data_task:get_ring_head_ids(),
	F = fun(RingId) ->
		Rd = make_new_task_ring(RingId, 0),
		db:insert(RoleId, task_ring,
			  [{role_id, RoleId},
			   {master_id, RingId},
			   {ring, Rd#task_ring.ring},
			   {seed, Rd#task_ring.seed},
			   {times, Rd#task_ring.times},
			   {date, Rd#task_ring.date}
			   ]),
		set_task_ring(RingId, Rd) 
	end,
	lists:foreach(F, RingList).

correct_ring_task(RoleId, List) ->
	RingList = data_task:get_ring_head_ids(),
	{DelList, AddList} = correct_ring_ids([Id || [Id | _] <- List], RingList),
	case AddList =:= [] of
		true -> skip;
		false -> 
			F = fun(RingId) ->
				Rd = make_new_task_ring(RingId, 0),
				db:insert(RoleId, task_ring,
					  [{role_id, RoleId},
					   {master_id, RingId},
					   {ring, Rd#task_ring.ring},
					   {seed, Rd#task_ring.seed},
					   {times, Rd#task_ring.times},
					   {date, Rd#task_ring.date}
					   ]),
				set_task_ring(RingId, Rd) 
			end,
			lists:foreach(F, AddList)
	end,
	case DelList =:= [] of
		true -> skip;
		false -> 
			lists:foreach(
				fun(DelId) -> db:delete(RoleId, task_ring, [{role_id, RoleId}, {master_id, DelId}]) end,
				DelList
				)
	end.


correct_ring_ids(RawList, DataList) ->
	DelList = lists:subtract(RawList, DataList),
	AddList = lists:subtract(DataList, RawList),
	{DelList, AddList}.


% correct_ring_task_1(_RoleId, _List, [], Count) -> Count;
% correct_ring_task_1(RoleId, List, [RingId | Left], Count) ->
% 	case list_find(RingId, 2, List) of
% 		false -> correct_ring_task_1(RoleId, List, Left, [RingId | Count]);
% 		_ -> correct_ring_task_1(RoleId, List, Left, Count)
% 	end.

list_find(_Id, _Index, []) -> false;
list_find(Id, Index, [List | Left]) ->
	case lists:nth(Index, List) =:= Id of
		true -> true;
		false -> list_find(Id, Index, Left)
	end.


%% @doc 加载已接受任务
load_accepted_task(Status) ->
	RoleId = player:id(Status),
	case db:select_all(task_bag, "task_id, state, accept_time, timing, mark, monNo", [{role_id, RoleId}]) of
		[] -> skip;
		List when is_list(List) ->
			F = fun([TaskId, State, AccTime, Timing, Mark, MonNo]) ->
				case data_task:get(TaskId) of
					Task when is_record(Task, task) ->
						TermMark = case util:bitstring_to_term(Mark) of
							T when is_list(T) -> T;
							_ -> 
								% Task = data_task:get(TaskId),
								add_state_mark(Task#task.content)
						end,
						TermMon = case util:bitstring_to_term(MonNo) of
							Tp when is_tuple(Tp) -> Tp;
							_ -> {0, 0}
						end,
						
						Rd = #role_task{id = TaskId, state = State,
										accept_time = AccTime, monNo = TermMon,
										timing = Timing, mark = TermMark},
						case login_check_task(Rd, Status) of
							{update, NewRd} ->
								add_accepted(NewRd),
								cache_task_operation(update, NewRd);
							NewRd -> 
								add_accepted(NewRd)
						end,
						set_task_ring_state(data_task:get(TaskId), accept),
						start_task_timer(Rd);
					_ -> % 任务已不存在，删去
						db:delete(RoleId, task_bag, [{role_id, RoleId}, {task_id, TaskId}])
				end
			end,
			lists:foreach(F, List);
		Error ->
			?ASSERT(false),
			?ERROR_MSG("fun:load_accepted_task_1, error:wrong db data = ~p~n", [Error]),
			error
	end.

              
%% @doc 加载已完成任务
load_completed_task(RoleId) ->
	load_completed_repeat(RoleId),
	load_completed_unrepeat(RoleId).


load_completed_repeat(RoleId) ->
	case db:select_all(task_completed, "task_id, date, times, task_type", [{role_id, RoleId}]) of
		[] -> skip;
		List when is_list(List) ->
			F = fun([TaskId, Date, Times, Type]) ->
				case data_task:get(TaskId) of
					Task when is_record(Task, task) ->
						Rd = #completed{id = TaskId, date = Date, times = Times, task_type = Type},
						add_repeat_completed(Rd);
					_ -> 
						db:delete(RoleId, task_completed, [{role_id, RoleId}, {task_id, TaskId}])
				end
			end,
			lists:foreach(F, List);
		_Error ->
			?ASSERT(false),
			?ERROR_MSG("fun:load_completed_task_1, error:wrong db data~n", []),
			error
	end.


load_completed_unrepeat(RoleId) ->
	case db:select_all(task_completed_unrepeat, "`task_type`, `task_id`, `date`", [{role_id, RoleId}]) of
		[] -> init_unrepeat_task(RoleId);
		List1 when is_list(List1) ->
			F1 = fun([Type1, TaskId1, Date1]) ->
				Rd1 = #completed_unrepeat{id = TaskId1, task_type = Type1, date = Date1},
				add_unrepeat_completed(Rd1)
			end,
			correct_unrepeat_task(RoleId, List1),
			lists:foreach(F1, List1);
		_ ->
			?ASSERT(false),
			?ERROR_MSG("fun:load_completed_task_2, error:wrong db data~n", []),
			error
	end.


init_unrepeat_task(RoleId) ->
	NowDays = get_now_date(),
	F = fun(Type) ->
		db:insert(RoleId, task_completed_unrepeat, [{role_id, RoleId}, {task_type, Type}, {date, NowDays}, {task_id, 0}]),
		Rd = #completed_unrepeat{id = 0, task_type = Type, date = NowDays},
		add_unrepeat_completed(Rd)
	end,
	lists:foreach(F, ?UNREPEAT_TASK_TYPES).

% init_unrepeat_task_in_cache(RoleId) ->
% 	NowDays = get_now_date(),
% 	F = fun(Type) ->
% 		db:replace(RoleId, task_completed_unrepeat, [{role_id, RoleId}, {task_type, Type}, {date, NowDays}, {task_id, 0}]),
% 		Rd = #completed_unrepeat{id = 0, task_type = Type, date = NowDays},
% 		add_unrepeat_completed(Rd)
% 	end,
% 	lists:foreach(F, ?UNREPEAT_TASK_TYPES).

correct_unrepeat_task(RoleId, List) ->
	NewList = correct_unrepeat_task_1(RoleId, List, ?UNREPEAT_TASK_TYPES, []),
	% ?ERROR_MSG("correct_unrepeat_task ~p~n", [NewList]),
	case NewList =:= [] of
		true -> skip;
		false -> 
			NowDays = get_now_date(),
			F = fun(Type) ->
				db:insert(RoleId, task_completed_unrepeat, [{role_id, RoleId}, {task_type, Type}, {date, NowDays}, {task_id, 0}]),
				Rd = #completed_unrepeat{id = 0, task_type = Type, date = NowDays},
				add_unrepeat_completed(Rd)
			end,
			lists:foreach(F, NewList)
	end.


correct_unrepeat_task_1(_RoleId, _List, [], Count) -> Count;
correct_unrepeat_task_1(RoleId, List, [Type | Left], Count) ->	
	case list_find(Type, 1, List) of
		false -> correct_unrepeat_task_1(RoleId, List, Left, [Type | Count]);
		_ -> correct_unrepeat_task_1(RoleId, List, Left, Count)
	end.



%% @doc 下线清除缓存并保存数据
logout_task(Id) ->
	save_all_1_syn(Id),
	% write_auto_task_trigger_db(Id),
	% 清除定时器
	clean_all_timing().
	% save_all(Status).

% 临时下线
tmp_logout_out(RoleId) ->
	transfer_task_data_dict_to_ets(RoleId),
	% 保存缓存中压缩处理的数据
	logout_task(RoleId).

% 最终下线
final_logout_out(RoleId) ->
	clean_all_ets_tmp_data(RoleId),
	logout_task(RoleId),
	skip.


%% 清除ETS中任务临时数据
clean_all_ets_tmp_data(RoleId) ->
	clean_accepted(RoleId),
	clean_completed(RoleId),
	clean_ring_data(RoleId),
	% clean_auto_accept(RoleId),
	ok.


%% 临时下线把任务进程字典数据转移到ETS中
transfer_task_data_dict_to_ets(RoleId) ->
	clean_all_ets_tmp_data(RoleId),
	% 转移已接任务数据
	transfer_accepted(RoleId),
	% 转移已完成任务数据
	transfer_completed(RoleId),
	% 转移环任务数据
	transfer_ring_data(RoleId),
	% 转移自动触发任务数据
	% transfer_auto_accept(RoleId),
	ok.
	

transfer_accepted(RoleId) ->
	List = get_accepted_list(),
	F = fun(TaskId, Count) ->
		case get_accepted(TaskId) of
			null -> 
				?ASSERT(false, [TaskId]), Count;
			Rd ->   
				ets:insert(?ETS_TASK_TMP_ACCEPTED, {{RoleId, TaskId}, Rd}),
				[TaskId | Count]
		end
	end,
	Sum = lists:foldl(F, [], List),
	ets:insert(?ETS_TASK_TMP_ACCEPTED_LIST, {RoleId, Sum}).


transfer_completed(RoleId) ->
	List = get_repeat_completed_list(),
	F = fun(TaskId, Count) ->
		case get_repeat_completed(TaskId) of
			null -> 
				?ASSERT(false, [TaskId]), Count;
			Rd -> 
				ets:insert(?ETS_TASK_TMP_COMPLETED, {{RoleId, TaskId}, Rd}),
				[TaskId | Count]
		end
	end,
	Sum = lists:foldl(F, [], List),
	ets:insert(?ETS_TASK_TMP_COMPLETED_LIST, {RoleId, Sum}),
	% 转移不可重复任务
	F1 = fun(Type) ->
		case get_unrepeat_completed(Type) of
			null -> ?ASSERT(false);
			Rd1 -> ets:insert(?ETS_TASK_TMP_COMPLETED_UNREPEAT, {{RoleId, Type}, Rd1})
		end
	end,
	lists:foreach(F1, ?UNREPEAT_TASK_TYPES).


transfer_ring_data(RoleId) ->
	List = data_task:get_ring_head_ids(),
	F = fun(TaskId) ->
		case get_task_ring(TaskId) of
			null -> 
				?ASSERT(false, [TaskId]);
			Rd -> 
				ets:insert(?ETS_TASK_TMP_RING, {{RoleId, TaskId}, Rd})
		end
	end,
	lists:foreach(F, List).
	% Sum = lists:foldl(F, [], List),
	% ets:insert(?ETS_TASK_TMP_RING_LIST, {RoleId, Sum}).


transfer_auto_accept(RoleId) ->
	List = get_auto_task_trigger_list(),
	ets:insert(?ETS_TASK_TMP_AUTO_TRIGGER, {RoleId, List}).


%% 把ETS中数据恢复到dict中
recover_task_data_from_ets_to_dict(RoleId) ->
	recover_task_accepted(RoleId),
	recover_task_completed(RoleId),
	recover_task_ring(RoleId),
	% recover_task_auto_accept(RoleId),
	ok.


recover_task_accepted(RoleId) ->
	case ets:lookup(?ETS_TASK_TMP_ACCEPTED_LIST, RoleId) of
		[] -> skip;
		[{RoleId, List}] when is_list(List) ->
			F = fun(TaskId) -> 
				case ets:lookup(?ETS_TASK_TMP_ACCEPTED, {RoleId, TaskId}) of
					[] -> ?ASSERT(false, [TaskId]);
					[{_, Rd}] when is_record(Rd, role_task) ->	% 不再重新检查任务
						add_accepted(Rd),
						set_task_ring_state(data_task:get(TaskId), accept),
						start_task_timer(Rd),
						ets:delete(?ETS_TASK_TMP_ACCEPTED, {RoleId, TaskId})
				end
			end,
			lists:foreach(F, List)
	end,
	ets:delete(?ETS_TASK_TMP_ACCEPTED_LIST, RoleId).

clean_accepted(RoleId) ->
	case ets:lookup(?ETS_TASK_TMP_ACCEPTED_LIST, RoleId) of
		[] -> skip;
		[{_, List}] when is_list(List) ->
			[ets:delete(?ETS_TASK_TMP_ACCEPTED, {RoleId, TaskId}) || TaskId <- List]
	end,
	ets:delete(?ETS_TASK_TMP_ACCEPTED_LIST, RoleId).


recover_task_completed(RoleId) ->
	case ets:lookup(?ETS_TASK_TMP_COMPLETED_LIST, RoleId) of
		[{_, List}] when is_list(List) andalso List /= [] ->
			F = fun(TaskId) ->
				case ets:lookup(?ETS_TASK_TMP_COMPLETED, {RoleId, TaskId}) of
					[] -> ?ASSERT(false, [TaskId]), erlang:error({task, recover_task_completed});
					[{_, Rd}] when is_record(Rd, completed) -> 
						add_repeat_completed(Rd),
						ets:delete(?ETS_TASK_TMP_COMPLETED, {RoleId, TaskId})
				end
			end,
			lists:foreach(F, List);
		_ -> load_completed_task(RoleId)
	end,
	ets:delete(?ETS_TASK_TMP_COMPLETED_LIST, RoleId),

	F1 = fun(Type) ->
		case ets:lookup(?ETS_TASK_TMP_COMPLETED_UNREPEAT, {RoleId, Type}) of
			[] -> 
				?ERROR_MSG("task recover_task_completed unrepeat Type = ~p not in cache~n", [Type]),
				case db:select_row(task_completed_unrepeat, "`task_id`, `date`", [{role_id, RoleId}, {task_type, Type}]) of
					[] -> init_unrepeat_task(RoleId);
					[TaskId, Date] -> add_unrepeat_completed(#completed_unrepeat{id = TaskId, task_type = Type, date = Date})
				end;

			[{_, Rd}] when is_record(Rd, completed_unrepeat) -> 
				add_unrepeat_completed(Rd),
				ets:delete(?ETS_TASK_TMP_COMPLETED_UNREPEAT, {RoleId, Type})
		end
	end,
	lists:foreach(F1, ?UNREPEAT_TASK_TYPES).


clean_completed(RoleId) ->
	case ets:lookup(?ETS_TASK_TMP_COMPLETED_LIST, RoleId) of
		[] -> skip;
		[{_, List}] when is_list(List) ->
			[ets:delete(?ETS_TASK_TMP_COMPLETED, {RoleId, TaskId}) || TaskId <- List]
	end,
	ets:delete(?ETS_TASK_TMP_COMPLETED_LIST, RoleId),
	[ets:delete(?ETS_TASK_TMP_COMPLETED_UNREPEAT, {RoleId, Type}) || Type <- ?UNREPEAT_TASK_TYPES].


recover_task_ring(RoleId) ->
	List = data_task:get_ring_head_ids(),
	F = fun(TaskId) ->
		case ets:lookup(?ETS_TASK_TMP_RING, {RoleId, TaskId}) of
			[] -> 
				?ERROR_MSG("task recover_task_ring TaskId = ~p not in cache~n", [TaskId]),
				case db:select_row(task_ring, "*", [{role_id, RoleId}, {master_id, TaskId}]) of
					[] -> ?ASSERT(false);
					[_, _, Ring, Seed, Times, Date] ->
						Rd = #task_ring{masterId = TaskId, ring = Ring, seed = Seed, times = Times, date = Date},
						set_task_ring(TaskId, Rd)
				end;
			[{_, Rd}] when is_record(Rd, task_ring) ->
				MasterId = Rd#task_ring.masterId,
				set_task_ring(MasterId, Rd),
				ets:delete(?ETS_TASK_TMP_RING, {RoleId, TaskId})
		end
	end,
	lists:foreach(F, List).

	% case ets:lookup(?ETS_TASK_TMP_RING_LIST, RoleId) of
	% 	[] -> skip;
	% 	[{_, List}] when is_list(List) ->	
	% 		F = fun(TaskId) ->
	% 			case ets:lookup(?ETS_TASK_TMP_RING, {RoleId, TaskId}) of
	% 				[] -> ?ASSERT(false, [TaskId]);
	% 				[{_, Rd}] when is_record(Rd, task_ring) ->
	% 					MasterId = Rd#task_ring.masterId,
	% 					set_task_ring(MasterId, Rd),
	% 					ets:delete(?ETS_TASK_TMP_RING, {RoleId, TaskId})
	% 			end
	% 		end,
	% 		lists:foreach(F, List)
	% end,
	% ets:delete(?ETS_TASK_TMP_RING_LIST, RoleId).


clean_ring_data(RoleId) ->
	case ets:lookup(?ETS_TASK_TMP_RING_LIST, RoleId) of
		[] -> skip;
		[{_, List}] when is_list(List) ->	
			[ets:delete(?ETS_TASK_TMP_RING, {RoleId, TaskId}) || TaskId <- List]
	end,
	ets:delete(?ETS_TASK_TMP_RING_LIST, RoleId).


recover_task_auto_accept(RoleId) ->
	case ets:lookup(?ETS_TASK_TMP_AUTO_TRIGGER, RoleId) of
		[] -> skip; 
		[{_, List}] when is_list(List) ->
			init_auto_task_trigger(lists:flatten(List))
	end,
	ets:delete(?ETS_TASK_TMP_AUTO_TRIGGER, RoleId).


clean_auto_accept(RoleId) ->
	ets:delete(?ETS_TASK_TMP_AUTO_TRIGGER, RoleId).


%% =========================================================================================


-define(MON_SEED, 10000).
get_mon_seed() ->
	util:rand(1, ?MON_SEED).

refresh_script([], _) -> skip;
refresh_script([Script | List], State) ->
	refresh_script__(Script, State),
	refresh_script(List, State).


refresh_script_dynamic([], _, _) -> skip;
refresh_script_dynamic([Script | List], State, DynamicIdList) ->
	[Type, Scene | Left] = Script,
	case is_list(Scene) of
		true -> refresh_script__([Type, DynamicIdList | Left], State);
		false -> 
			[DynamicId | _] = DynamicIdList,
			refresh_script__([Type, DynamicId | Left], State)
	end,
	refresh_script_dynamic(List, State, DynamicIdList).

refresh_script__([Type | _] = Script, State) when Type =:= single orelse Type =:= random ->
	refresh_monster(Script, State);
refresh_script__([Type | _] = Script, State) when Type =:= single_npc orelse Type =:= random_npc ->
	refresh_npc(Script, State);
refresh_script__(_, _) -> ?ASSERT(false).

%% return [{monNO, monId}]
refresh_monster([single, SceneNo, CoordList, MonRanList, 1], State) ->
	[refresh_single(SceneNo, CoordList, MonRanList, State)];
refresh_monster([single, SceneNo, CoordList, MonRanList, Times], State) ->
	[refresh_single(SceneNo, CoordList, MonRanList, State) |
	 refresh_monster([single, SceneNo, CoordList, MonRanList, Times - 1], State)];


refresh_monster([random, SceneNoList, MonRanList, 1], State) ->
	[refresh_random(SceneNoList, MonRanList, State)];
refresh_monster([random, SceneNoList, MonRanList, Times], State) ->
	[refresh_random(SceneNoList, MonRanList, State) |
	refresh_monster([random, SceneNoList, MonRanList, Times - 1], State)].


refresh_single(SceneNo, CoordList, MonRanList, State) ->
	SeedCoor = get_mon_seed(),
	Length = erlang:length(CoordList),
	{X, Y} = lists:nth(util:rand(1, Length), CoordList),
	MonNo = get_val_by_random(SeedCoor, MonRanList),
	case State of
		sys -> 
			SceneId = 
				case erlang:get(refresh_melee) of
					1 ->
						case lib_melee:get_melee_scene_id() of
							null ->
								SceneNo;
							SceneId0 ->
								SceneId0
						end;
					_ ->
						SceneNo
				end,
			case mod_scene:spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, X, Y) of
				{_, MonId} -> {MonId, MonNo};
				_ -> ?ASSERT(false), {0, 0}
			end;
		Status when is_record(Status, player_status) ->
			case mod_scene:spawn_mon_to_scene_for_player_WNC(Status, MonNo, SceneNo, X, Y) of
				{_, MonId} -> {MonId, MonNo};
				_ -> ?ASSERT(false), {0, 0}
			end;
		_ -> ?ASSERT(false), {0, 0}
	end.


%% 这里需要处理多一种配置情况，场景ID，随机坐标
refresh_random(SceneNoList, MonRanList, State) ->
	SeedCoor = get_mon_seed(),
	Length = erlang:length(SceneNoList),
	{SceneNo, AreaId} = 
		case hd(SceneNoList) of
			S when is_integer(S) ->
				%% 这里的需求是不配刷怪区域，但不要用场景里的区域去随机，而是直接从data_mask里面随机一个无阻挡的区域出来，然后不走areaId的刷怪接口
				{X, Y} = mod_scene:rand_pick_one_spawn_mon_pos_all(S),
				{S, {X, Y}};
			_ ->
				lists:nth(util:rand(1, Length), SceneNoList)
		end,
	MonNo = get_val_by_random(SeedCoor, MonRanList),
	case State of
		sys -> 
			SceneId = 
				case erlang:get(refresh_melee) of
					1 ->
						case lib_melee:get_melee_scene_id() of
							null ->
								SceneNo;
							SceneId0 ->
								SceneId0
						end;
					_ ->
						SceneNo
				end,
			case mod_scene:spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, AreaId) of
				{_, MonId} -> {MonId, MonNo};
				_ -> ?ASSERT(false), {0, 0}
			end;
		Status when is_record(Status, player_status) ->
			case mod_scene:spawn_mon_to_scene_for_player_WNC(Status, MonNo, SceneNo, AreaId) of
				{_, MonId} -> {MonId, MonNo};
				_ -> ?ASSERT(false), {0, 0}
			end;
		_ -> ?ASSERT(false), {0, 0}
	end.



refresh_npc([single_npc, SceneNo, CoordList, NpcRanList, 1], State) ->
	[refresh_single_npc(SceneNo, CoordList, NpcRanList, State)];
refresh_npc([single_npc, SceneNo, CoordList, NpcRanList, Times], State) ->
	[refresh_single_npc(SceneNo, CoordList, NpcRanList, State) |
	 refresh_npc([single_npc, SceneNo, CoordList, NpcRanList, Times - 1], State)];


refresh_npc([random_npc, SceneNoList, NpcRanList, 1], State) ->
	[refresh_random_npc(SceneNoList, NpcRanList, State)];
refresh_npc([random_npc, SceneNoList, NpcRanList, Times], State) ->
	[refresh_random_npc(SceneNoList, NpcRanList, State) |
	refresh_npc([random_npc, SceneNoList, NpcRanList, Times - 1], State)].


refresh_single_npc(SceneNo, CoordList, NpcRanList, State) ->
	SeedCoor = get_mon_seed(),
	
	{X, Y} = get_refresh_npc_xy(SceneNo, CoordList),
	NpcNo = get_val_by_random(SeedCoor, NpcRanList),
	case State of
		sys -> 
			case mod_scene:spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneNo, X, Y) of
				{_, NpcId} -> {NpcId, NpcNo};
				_ -> ?ASSERT(false), {0, 0}
			end;
		_ -> ?ASSERT(false), {0, 0}
	end.

refresh_random_npc(SceneNoList, NpcRanList, State) ->
	SeedCoor = get_mon_seed(),
	Length = erlang:length(SceneNoList),
	SceneNo = lists:nth(util:rand(1, Length), SceneNoList),

%% 	{X, Y} = get_refresh_npc_xy(SceneNo, AreaNo),
	%% 这里的需求是不配刷怪区域，但不要用场景里的区域去随机，而是直接从data_mask里面随机一个无阻挡的区域出来，然后不走areaId接口
	{X, Y} = mod_scene:rand_pick_one_spawn_mon_pos_all(SceneNo),
	NpcNo = get_val_by_random(SeedCoor, NpcRanList),
	case State of
		sys -> 
			case mod_scene:spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneNo, X, Y) of
				{_, NpcId} -> {NpcId, NpcNo};
				_ -> ?ASSERT(false), {0, 0}
			end;
		_ -> ?ASSERT(false), {0, 0}
	end.

get_val_by_random(Seed, List) ->
	get_val_by_random(Seed, List, 0).

get_val_by_random(_, [], _) ->
	?ASSERT(false), error;
get_val_by_random(Seed, [{Val, Num} | Left], Count) ->
	Next = Num + Count,
	case Seed > Count andalso Seed =< Next of
		true -> Val;
		false -> get_val_by_random(Seed, Left, Next)
	end.

%% Para: [{X, Y},...] | [区域编号1,...]
get_refresh_npc_xy(SceneNo, Para) when is_list(Para) ->
	Length = erlang:length(Para),
	SceneTpl = mod_scene_tpl:get_tpl_data(SceneNo),
	X_Max = lib_scene:get_width(SceneTpl),
    Y_Max = lib_scene:get_height(SceneTpl),
	case Length =:= 0 of
		true -> {X_Max, Y_Max};
		false ->
			case erlang:hd(Para) of
				{_X, _Y} ->
					lists:nth(util:rand(1, Length), Para);
				_TAreaNo ->
					AreaNo = lists:nth(util:rand(1, Length), Para),
					get_refresh_npc_xy(SceneNo,AreaNo)
		    end
	end;

get_refresh_npc_xy(SceneNo,AreaNo) when is_integer(AreaNo) ->
	SceneTpl = mod_scene_tpl:get_tpl_data(SceneNo),
	X_Max = lib_scene:get_width(SceneTpl),
    Y_Max = lib_scene:get_height(SceneTpl),

	AreaList = mod_scene_tpl:get_dig_treasure_area(SceneTpl),
	case lists:keyfind(AreaNo, 1, AreaList) of
        false ->
            ?ASSERT(false, {SceneNo, AreaNo}),
            ?WARNING_MSG("get_refresh_npc_xy() failed!! SceneNo:~p, SpawnMonAreaNo:~p", [SceneNo, AreaNo]),
            {X_Max, Y_Max};
        Area ->
        	{AreaNo, X, Y, Width, Height} = Area,
		    X_Max = lib_scene:get_width(SceneTpl),
		    Y_Max = lib_scene:get_height(SceneTpl),

		    % ?ASSERT(X =< X_Max andalso Y =< Y_Max, SceneNo),                    

		    X_Start = X,
		    X_End = min(X + Width, X_Max), % 为避免超出范围，故矫正，下同

		    Y_Start = Y,
		    Y_End = min(Y + Height, Y_Max),

		    RetX = util:rand(X_Start, X_End),
		    RetY = util:rand(Y_Start, Y_End),

		    {RetX, RetY}
    end.



%% 在本服调用的函数
check_cross_accept(TaskId) ->
	case lib_cross:check_is_remote() of
		?true ->
			% 跨服状态
			%% 当前跨服，所有任务都可以接2020 01 20，---- 只准接抓鬼
%% 			case get_task_type(TaskId) of
%% 				?TASK_GOSHT_TYPE ->
%% 					{ok, 1};
%% 				_ ->
%% 					{fail, ?PM_CROSS_BAN_PROTO}
%% 			end;
			{ok, 1};
		_ ->
			{ok, 0}
	end.

%% 接取任务时候判断三界
%%judge_sanjie_task(TaskId, Status) ->
%%    PlyVipLv = player:get_vip_lv(Status),
%%    ExtraStep = data_sanjieyishi_cost:get(sanjieyishi_extra_time, PlyVipLv),
%%    PlyLv = player:get_lv(Status),
%%    case data_sanjieyishi_cost:get(TaskId) of
%%        null ->
%%            false;
%%        Sanjie ->
%%            {MinLv, MaxLv} = Sanjie#sanjieyishi_cost.lv_range,
%%            case PlyLv >= MinLv andalso PlyLv =< MaxLv of
%%                true ->
%%                    {Step, Ring} = get_current_setp_and_round(TaskId),
%%                    {_, _MaxRing, _, MaxStep, _} = data_task:get(TaskId),
%%                    case MaxStep + ExtraStep  >= Step of
%%                        true ->
%%                            {true, Ring};
%%                        false ->
%%                            false
%%                    end;
%%                false ->
%%                    false
%%            end
%%    end.

get_done_main_task(TaskId, Acc, PS) ->

    ?DEBUG_MSG("faction~p~n", [player:get_faction(PS)]),
	case TaskId =:= 0 of
		true ->
			[];
		_ ->
            case (data_task:get(TaskId))#task.prev_id of
                [0] ->
                    Acc;
                [PreId] ->
                    get_done_main_task(PreId, [PreId|Acc], PS);
                _ ->
                    List = (data_task:get(TaskId))#task.prev_id,
                    Faction = PS#player_status.faction,
                    PreId = lists:nth(Faction, List),
                    get_done_main_task(PreId, [PreId|Acc], PS)
            end

	end.



%% 获取已接的抓鬼任务id
get_task_ghost_id(PlayerId) ->
	Self = self(),
	case player:get_pid(PlayerId) of
		null ->
			%% 该玩家不在线
			null;
		Self ->
			%% 本进程直接获取进程字典
			TaskIds = get_accepted_list(),
			filter_ghost_type_task(TaskIds);
		Pid ->
			gen_server:call(Pid, {apply_call, ?MODULE, get_task_ghost_id_call, []})
	end.

get_task_ghost_id_call() ->
	TaskIds = get_accepted_list(),
	filter_ghost_type_task(TaskIds).


filter_ghost_type_task([TaskId|L]) ->
	case data_task:get(TaskId) of
		#task{type = ?TASK_GOSHT_TYPE} ->
			{ok, TaskId};
		_ ->
			filter_ghost_type_task(L)
	end;

filter_ghost_type_task([]) ->
	null.
	
	
%% 让玩家放弃其身上的抓鬼任务
force_abandon_ghost_task(PlayerId) ->
	Self = self(),
	case player:get_pid(PlayerId) of
		null ->
			skip;
		Self ->
			case get_task_ghost_id(PlayerId) of
				{ok, TaskId} ->
					abandon(TaskId, player:get_PS(PlayerId));
				_ ->
					skip
			end;
		Pid ->
			gen_server:cast(Pid, {apply_cast, ?MODULE, force_abandon_ghost_task_cast, [PlayerId]})
	end.


force_abandon_ghost_task_cast(PlayerId) ->
	Self = self(),
	case player:get_pid(PlayerId) of
		null ->
			skip;
		Self ->
			case get_task_ghost_id(PlayerId) of
				{ok, TaskId} ->
					abandon(TaskId, player:get_PS(PlayerId));
				_ ->
					skip
			end;
		Pid ->
			?ERROR_MSG("Erro : ~p~n", [Pid])
	end.
	
	
%% 让玩家接取指定的抓鬼任务
force_accept_ghost_task(PlayerId, TaskId) ->
	Status = player:get_PS(PlayerId),
	case get_task_ghost_id(PlayerId) of
		{ok, TaskId} ->
			abandon(TaskId, Status);
		_ ->
			o
	end,
	force_accept(TaskId, Status).
	

	






