%%%------------------------------------
%%% @Module  : mod_sys_jobsch (system's job schedule)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.4.8
%%% @Description: 系统相关的作业计划（预定在后面某个指定的时间点需触发和处理的事件）
%%%               注：由于服务器时钟是每2秒滴答一次，所以作业计划的处理最多可能有接近2秒的延迟！不过，通常不必在乎这点误差。
%%%               !!!!另外，为了避免卡住后面作业的处理，对于处理起来比较耗时的作业，不要直接在本进程做处理，应该交由其他合适的进程去做!!!!
%%%------------------------------------
-module(mod_sys_jobsch).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0]).

-export([
		on_server_clock_tick/2,
		add_sch_cleanup_residual_player_proc/3,
		add_sch_cur_waiting_npc_start_cruise/1,
		add_sch_spawn_next_cruise_npc/1,

		add_schedule/4,  % 新版接口：触发作业时，调用所传入的回调函数。新代码应统一使用此接口！
		add_schedule/3,  % 旧版接口：保留是为了兼容旧代码，新代码应统一使用新版接口！

		% 仅仅用于调试的接口！
		dbg_get_state/0
	   ]).

-include("common.hrl").
-include("job_schedule.hrl").
-include("record.hrl").

-record(state, {
		seq_num_so_far = 0, % 至今的流水号
		job_schedules = gb_trees:empty()  % 所有未处理的作业计划
	}).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


%% 获取内部状态，仅用于调试
dbg_get_state() ->
	gen_server:call(?MODULE, 'dbg_get_state').


%% 服务器时钟滴答时做对应处理
on_server_clock_tick(CurTickCount, CurUnixTime) ->
	gen_server:cast(?MODULE, {'handle_job_schedules', CurTickCount, CurUnixTime}).



%% 添加作业计划：清除残余的玩家进程
add_sch_cleanup_residual_player_proc(PlayerId, PlayerPid, DelayTime) ->
	add_schedule(?JSET_CLEANUP_RESIDUAL_PLAYER_PROC, DelayTime, [PlayerId, PlayerPid]).


%% 添加作业计划：巡游活动npc开始巡游
add_sch_cur_waiting_npc_start_cruise(DelayTime) ->
	add_schedule(?JSET_CUR_WAITING_NPC_START_CRUISE, DelayTime, []).


%% 添加作业计划：刷出下一个巡游活动npc
add_sch_spawn_next_cruise_npc(DelayTime) ->
	add_schedule(?JSET_SPAWN_NEXT_CRUISE_NPC, DelayTime, []).




%% 添加作业计划（新版接口）
%% @para：JobSchEventType => 作业计划的事件类型（由自己补充定义在job_schedule.hrl）
%%        DelayTime => 从调用本函数时算起，触发作业的延迟时间（单位：秒）
%%        CallbackFunc => 触发作业时调用的回调函数（由自己定义，此回调函数要求有两个参数：第一个固定是JobSchEventType， 第二个是CallbackPara）
%%        CallbackPara => 回调时，作为CallbackFunc的第二个参数，可以是任意的erlang term
add_schedule(JobSchEventType, DelayTime, CallbackFunc, CallbackPara) when is_function(CallbackFunc, 2) ->
	?ASSERT(util:is_nonnegative_int(DelayTime), DelayTime),
	NewJobSche = #job_sche{
						event_type = JobSchEventType,
						trigger_time = util:unixtime() + DelayTime,
						callback_func = CallbackFunc,
						callback_para = CallbackPara
					},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok.



%% 添加作业计划（旧版接口）
%% @para：事件类型， 触发作业的延迟时间（单位：秒）， 额外的数据（list类型）
add_schedule(?JSET_AUDIT_GUILD_STATE, DelayTime, []) ->
	NewJobSche = #job_sche{
						event_type = ?JSET_AUDIT_GUILD_STATE,
						trigger_time = util:unixtime() + DelayTime,
						player_id = 0
						},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok;

add_schedule(?JSET_CLEANUP_RESIDUAL_PLAYER_PROC, DelayTime, [PlayerId, PlayerPid]) ->
	?ASSERT(is_pid(PlayerPid), PlayerPid),
	NewJobSche = #job_sche{
						event_type = ?JSET_CLEANUP_RESIDUAL_PLAYER_PROC,
						trigger_time = util:unixtime() + DelayTime,
						player_id = PlayerId,
						extra = #js_extra{player_pid = PlayerPid}
						},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok;

add_schedule(?JSET_ADD_GUILD_BUFF, DelayTime, []) ->
	NewJobSche = #job_sche{
						event_type = ?JSET_ADD_GUILD_BUFF,
						trigger_time = util:unixtime() + DelayTime,
						player_id = 0
						},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok;

add_schedule(?JSET_CUR_WAITING_NPC_START_CRUISE, DelayTime, []) ->
	NewJobSche = #job_sche{
						event_type = ?JSET_CUR_WAITING_NPC_START_CRUISE,
						trigger_time = util:unixtime() + DelayTime
						},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok;

add_schedule(?JSET_SPAWN_NEXT_CRUISE_NPC, DelayTime, []) ->
	NewJobSche = #job_sche{
						event_type = ?JSET_SPAWN_NEXT_CRUISE_NPC,
						trigger_time = util:unixtime() + DelayTime
						},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok;


add_schedule(?JSET_GIVE_TVE_RANK_REWARD, DelayTime, []) ->
	NewJobSche = #job_sche{
						event_type = ?JSET_GIVE_TVE_RANK_REWARD,
						trigger_time = util:unixtime() + DelayTime
						},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok.








%% ---------------------------------------------------------------------------

init([]) ->
    process_flag(trap_exit, true),
    {ok, #state{}}.

handle_call('dbg_get_state', _From, State) ->
	{reply, State, State};
	
handle_call(_Request, _From, State) ->
	?ASSERT(false, _Request),
    {reply, State, State}.
    
%% 添加作业计划
handle_cast({'add_schedule', NewJobSche}, State) ->
	SeqNumSoFar2 = State#state.seq_num_so_far + 1,

	% key: {触发时间，流水号}，即先按触发时间比较，若相等，再按流水号比较
	Key = {NewJobSche#job_sche.trigger_time, SeqNumSoFar2},

		JobSchedules2 = gb_trees:enter(Key, NewJobSche, State#state.job_schedules),

	?TRACE("[mod_sys_jobsch] add_schedule, NewJobSche:~w~n JobSchedules2:~w~n", [NewJobSche, JobSchedules2]),
	{noreply, State#state{
					seq_num_so_far = SeqNumSoFar2, 
					job_schedules = JobSchedules2}};

%% 处理作业计划
handle_cast({'handle_job_schedules', _CurTickCount, CurUnixTime}, State) ->
	UndoneJobSchs = handle_job_schedules(State#state.job_schedules, CurUnixTime),
	{noreply, State#state{job_schedules = UndoneJobSchs}};

    
handle_cast(_Msg, State) ->
	?ASSERT(false, _Msg),
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
	case Reason of
		normal -> skip;
		shutdown -> skip;
		_ -> ?ERROR_MSG("[mod_sys_jobsch] !!!!!terminate!!!!! for reason: ~w", [Reason])
	end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.





%%========================================== Local Functions ===============================================







%% 处理到期的作业计划，返回未处理的作业计划
handle_job_schedules(JobSchedules, CurUnixTime) ->
	Iter = gb_trees:iterator(JobSchedules),
	handle_job_schedules(gb_trees:next(Iter), JobSchedules, CurUnixTime).

handle_job_schedules(none, JobSchedules, _CurUnixTime) ->
	?ASSERT(gb_trees:is_empty(JobSchedules), JobSchedules),
	JobSchedules;
handle_job_schedules({Key, Val, Iter}, JobSchedules, CurUnixTime) ->
	{TriggerTime, _SeqNum} = Key,
	?ASSERT(is_record(Val, job_sche)),
	?ASSERT(gb_trees:is_defined(Key, JobSchedules)),
	case TriggerTime =< CurUnixTime of
		true ->
			% 为避免因异常而导致job schedule服务进程崩溃，故catch -- huangjf
			?TRY_CATCH(handle_job_sch(Val), ErrReason),
			JobSchedules_2 = gb_trees:delete(Key, JobSchedules),
			handle_job_schedules(gb_trees:next(Iter), JobSchedules_2, CurUnixTime);
		false ->
			JobSchedules
	end.
	




%% 处理单个作业计划
handle_job_sch(JobSch) ->
	F = JobSch#job_sche.callback_func,
	case is_function(F, 2) of
		true ->  % 对应新版的接口add_schedule/4，调用回调函数
			F(JobSch#job_sche.event_type, JobSch#job_sche.callback_para);
		false -> % 对应旧版的接口add_schedule/3，进一步细化处理
			handle_job_sch(JobSch#job_sche.event_type, JobSch)
	end,
	void.


handle_job_sch(?JSET_AUDIT_GUILD_STATE, _JobSch) ->
	?TRACE("[mod_sys_jobsch] handle_job_sch, JSET_AUDIT_GUILD_STATE, JobSch: ~w~n", [_JobSch]),
	% spawn(fun() -> mod_guild:on_job_schedule() end);
	mod_guild_mgr:on_guild_job_schedule();


handle_job_sch(?JSET_CLEANUP_RESIDUAL_PLAYER_PROC, JobSch) ->
	PlayerId = JobSch#job_sche.player_id,
	PlayerPid = JobSch#job_sche.extra#js_extra.player_pid,
	% ?DEBUG_MSG("[mod_sys_jobsch] handle_job_sch, JSET_CLEANUP_RESIDUAL_PLAYER_PROC, PlayerId:~p, PlayerPid:~p, JobSch:~w", [PlayerId, PlayerPid, JobSch]),
	mod_svr_mgr:cleanup_residual_player_proc(PlayerId, PlayerPid);


handle_job_sch(?JSET_ADD_GUILD_BUFF, _JobSch) ->
	?TRACE("[mod_sys_jobsch] handle_job_sch, JSET_ADD_GUILD_BUFF, JobSch: ~w~n", [_JobSch]),
	mod_guild_mgr:add_guild_buff();


handle_job_sch(?JSET_CUR_WAITING_NPC_START_CRUISE, _JobSch) ->
	?TRACE("[mod_sys_jobsch] handle_job_sch, JSET_CUR_WAITING_NPC_START_CRUISE, JobSch: ~w~n", [_JobSch]),
	mod_cruise:cur_waiting_npc_start_cruise();

handle_job_sch(?JSET_SPAWN_NEXT_CRUISE_NPC, _JobSch) ->
	?TRACE("[mod_sys_jobsch] handle_job_sch, JSET_SPAWN_NEXT_CRUISE_NPC, JobSch: ~w~n", [_JobSch]),
	mod_cruise:spawn_next_cruise_npc();
	

handle_job_sch(?JSET_GIVE_TVE_RANK_REWARD, _JobSch) ->
	mod_tve_mgr:on_job_schedule();

% %% 处理作业计划：开启活动
% handle_job_sch(?JSET_OPEN_ACTIVITY, _JobSche) ->
% 	todo_here;

% %% 处理作业计划：关闭活动
% handle_job_sch(?JSET_CLOSE_ACTIVITY, _JobSche) ->
% 	todo_here;

handle_job_sch(_EventType, JobSch) ->
	?ERROR_MSG("[mod_sys_jobsch] handle_job_sch failed(unknown event type)!!! JobSch: ~w", [JobSch]),
	?ASSERT(false, JobSch),
	void.
