%%%------------------------------------
%%% @Module  : mod_ply_jobsch (player's job schedule)
%%% @Author  : huangjf
%%% @Email   :
%%% @Created : 2013.6.20
%%% @Description: 玩家相关的作业计划（预定在后面某个指定的时间点需触发和处理的事件）
%%%               注：由于服务器时钟是每2秒滴答一次，所以作业计划的处理最多可能有接近2秒的延迟！不过，通常不必在乎这点误差。
%%%               !!!!另外，为了避免卡住后面作业计划的处理，对于处理起来比较耗时的作业，不要直接在本进程做处理，应该交由其他合适的进程去做!!!!

%%%            
%%%      TODO（完善、优化）:
%%%           job schedule进程每“帧”的触发改为不依赖于'on_server_clock_tick'消息，而是依赖于自身独立的erlang:send_after()，
%%%           以避免每“帧”处理的耗时大于server clock tick的间隔时，进程的msg queue堆积。 
%%%           另外，处理单个job时，可考虑统一spawn进程去做异步处理，以彻底避免某个job阻塞后面其他job的处理。 -- huangjf 2015.2.28
%%%                                                                            
%%%------------------------------------
-module(mod_ply_jobsch).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0]).

-export([
		on_server_clock_tick/2,

		add_sch_reconnect_timeout/1,
		remove_sch_reconnect_timeout/1,
		add_sch_game_logic_reconn_timeout/1,
		remove_sch_game_logic_reconn_timeout/1,

		add_schedule/4,  % 新版接口：触发作业时，调用所传入的回调函数。新代码应统一使用此接口！
		add_schedule/3,  % 旧版接口：保留是为了兼容旧代码，新代码应统一使用新版接口！
		add_mfa_schedule/3,
		remove_all_schs/1,
		remove_one_sch/2,


		force_handle_reconnect_timeout_sch/1,
		force_handle_all_reconnect_timeout_schs/0,

		% 仅仅用于调试的接口！
		dbg_find_schs/2,
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


%% 添加角色重连超时的作业计划（有一定时间的随机浮动，以避免过于集中处理final logout）
add_sch_reconnect_timeout(PlayerId) ->
	Time = config:get_role_reconn_timeout_time(),
	TimeFloating = util:rand(0, config:get_role_reconn_timeout_time_floating()),
	?TRACE("add_sch_reconnect_timeout(), Time: ~p, TimeFloating: ~p~n~n", [Time, TimeFloating]),
	add_schedule(?JSET_RECONNECT_TIMEOUT, Time + TimeFloating, [PlayerId]).


%% 添加游戏逻辑（如：队伍，副本等）重连超时的作业计划
add_sch_game_logic_reconn_timeout(PlayerId) ->
	Time = config:get_game_logic_reconn_timeout_time(),
	add_schedule(?JSET_GAME_LOGIC_RECONN_TIMEOUT, Time, [PlayerId]).


%% 添加{Mod, Func, Arg}或是Func()型的作业
add_mfa_schedule(PlayerId, DelayTime, Func) ->
	NewJobSche = #job_sche{
						event_type = mfa,
						trigger_time = util:unixtime() + DelayTime,
						player_id = PlayerId,
						extra = Func
					},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}).





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

%% 添加作业计划：角色重连超时
add_schedule(?JSET_RECONNECT_TIMEOUT, DelayTime, [PlayerId]) ->
	%%?ASSERT(dbg_find_schs(PlayerId, ?JSET_RECONNECT_TIMEOUT) == []),
	NewJobSche = #job_sche{
						event_type = ?JSET_RECONNECT_TIMEOUT,
						trigger_time = util:unixtime() + DelayTime,
						player_id = PlayerId
					},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok;

%% 添加作业计划：取消buff
%%  @para: BuffNo => buff编号，
%%         DelayTime => 延迟时间（单位：秒）
add_schedule(?JSET_CANCEL_BUFF, DelayTime, [PlayerId, PartnerId, BuffNo]) ->
	NewJobSche = #job_sche{
						event_type = ?JSET_CANCEL_BUFF,
						trigger_time = util:unixtime() + DelayTime,
						player_id = PlayerId,
						extra = #js_extra{buff_no = BuffNo, partner_id = PartnerId}
					},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok;


%% 添加作业计划：时效物品过期
add_schedule(?JSET_GOODS_EXPIRE, DelayTime, [PlayerId, GoodsId]) ->
	NewJobSche = #job_sche{
						event_type = ?JSET_GOODS_EXPIRE,
						trigger_time = util:unixtime() + DelayTime,
						player_id = PlayerId,
						extra = #js_extra{goods_id = GoodsId}
					},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok;


%% 添加作业计划：游戏逻辑（如：队伍，副本等）重连超时
add_schedule(?JSET_GAME_LOGIC_RECONN_TIMEOUT, DelayTime, [PlayerId]) ->
	NewJobSche = #job_sche{
						event_type = ?JSET_GAME_LOGIC_RECONN_TIMEOUT,
						trigger_time = util:unixtime() + DelayTime,
						player_id = PlayerId
					},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok;


add_schedule(?JSET_BUY_BACK_GOODS_EXPIRE, DelayTime, [PlayerId, GoodsId]) ->
	NewJobSche = #job_sche{
						event_type = ?JSET_BUY_BACK_GOODS_EXPIRE,
						trigger_time = util:unixtime() + DelayTime,
						player_id = PlayerId,
						extra = #js_extra{goods_id = GoodsId}
					},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok;


add_schedule(?JSET_CLEAR_HIRE_DATA, DelayTime, []) ->
	NewJobSche = #job_sche{
						event_type = ?JSET_CLEAR_HIRE_DATA,
						trigger_time = util:unixtime() + DelayTime,
						player_id = 0
					},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok;


%% 添加作业计划：0点更新玩家宠物心情
%%         DelayTime => 延迟时间（单位：秒）
add_schedule(?JSET_UPDATE_PAR_MOOD, DelayTime, [PlayerId]) ->
	NewJobSche = #job_sche{
						event_type = ?JSET_UPDATE_PAR_MOOD,
						trigger_time = util:unixtime() + DelayTime,
						player_id = PlayerId
					},
	gen_server:cast(?MODULE, {'add_schedule', NewJobSche}),
	ok.






%% 查找指定玩家的特定事件类型的所有作业计划
%% @return: [] | job_sche结构体列表
dbg_find_schs(PlayerId, EventType) ->
	gen_server:call(?MODULE, {'find_schs_for_player', PlayerId, EventType}).



%% 删除指定玩家的所有作业计划
remove_all_schs(PlayerId) ->
	gen_server:cast(?MODULE, {'remove_all_schs_for_player', PlayerId}),
	ok.


%% 删除指定玩家的一个特定事件类型的作业计划
remove_one_sch(PlayerId, EventType) ->
	?ASSERT(begin
				case EventType of
					?JSET_RECONNECT_TIMEOUT ->
						_ScheList = dbg_find_schs(PlayerId, EventType),
						length(_ScheList) == 1;
					_ ->
						_ScheList = dummy,
						true
				end
			end, _ScheList),
	gen_server:cast(?MODULE, {'remove_one_sch_for_player', PlayerId, EventType}),
	ok.




%% 作废！！
% %% 同步移除玩家的重连超时作业计划
% sync_remove_reconnect_timeout_sche(PlayerId) ->
% 	gen_server:call(?MODULE, {'sync_remove_reconnect_timeout_sche', PlayerId}),
% 	ok.



%% 异步移除角色重连超时作业计划
remove_sch_reconnect_timeout(PlayerId) ->
	gen_server:cast(?MODULE, {'remove_sch_reconnect_timeout', PlayerId}),
	ok.


remove_sch_game_logic_reconn_timeout(PlayerId) ->
	gen_server:cast(?MODULE, {'remove_sch_game_logic_reconn_timeout', PlayerId}),
	ok.


%% 作废！！
% %% 同步移除踢出队伍作业计划
% sync_remove_kick_out_team_sche(PlayerId) ->
% 	gen_server:call(?MODULE, {'sync_remove_kick_out_team_sche', PlayerId}),
% 	ok.

%% 作废！！
% %% 异步移除踢出队伍作业计划
% remove_kick_out_team_sche(PlayerId) ->
% 	gen_server:cast(?MODULE, {'remove_kick_out_team_sche', PlayerId}),
% 	ok.


%% 强行立即处理角色重连超时的作业计划
force_handle_reconnect_timeout_sch(PlayerId) ->
	gen_server:cast(?MODULE, {'force_handle_reconnect_timeout_sch', PlayerId}),
	ok.


%% 强行立即处理所有的角色重连超时的作业计划（关服时调用）
force_handle_all_reconnect_timeout_schs() ->
	gen_server:cast(?MODULE, {'force_handle_all_reconnect_timeout_schs'}),
	ok.





%% ---------------------------------------------------------------------------

init([]) ->
    process_flag(trap_exit, true),
    {ok, #state{}}.


% handle_call({'sync_remove_reconnect_timeout_sche', PlayerId}, _From, State) ->
% 	EventType = ?JSET_RECONNECT_TIMEOUT,
% 	JobSchsLeft = remove_one_sch_for_player__(State#state.job_schedules, PlayerId, EventType),
% 	{reply, ok, State#state{job_schedules = JobSchsLeft}};


% handle_call({'sync_remove_kick_out_team_sche', PlayerId}, _From, State) ->
% 	EventType = ?JSET_KICK_OUT_TEAM,
% 	JobSchsLeft = remove_one_sch_for_player__(State#state.job_schedules, PlayerId, EventType),
% 	{reply, ok, State#state{job_schedules = JobSchsLeft}};


handle_call({'find_schs_for_player', PlayerId, EventType}, _From, State) ->
	Ret = find_schs_for_player__(State#state.job_schedules, PlayerId, EventType),
	{reply, Ret, State};

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

	?TRACE("[mod_ply_jobsch] add_schedule, NewJobSche:~w~n JobSchedules2:~w~n", [NewJobSche, JobSchedules2]),
	{noreply, State#state{
					seq_num_so_far = SeqNumSoFar2,
					job_schedules = JobSchedules2}};



%% 删除和指定玩家相关的所有作业计划
handle_cast({'remove_all_schs_for_player', PlayerId}, State) ->
	JobSchsLeft = remove_all_schs_for_player__(State#state.job_schedules, PlayerId),
	{noreply, State#state{job_schedules = JobSchsLeft}};



%% 删除玩家的一个指定的作业计划
handle_cast({'remove_one_sch_for_player', PlayerId, EventType}, State) ->
	JobSchsLeft = remove_one_sch_for_player__(State#state.job_schedules, PlayerId, EventType),
	{noreply, State#state{job_schedules = JobSchsLeft}};


handle_cast({'remove_sch_reconnect_timeout', PlayerId}, State) ->
	EventType = ?JSET_RECONNECT_TIMEOUT,
	JobSchsLeft = remove_one_sch_for_player__(State#state.job_schedules, PlayerId, EventType),
	{noreply, State#state{job_schedules = JobSchsLeft}};

handle_cast({'remove_sch_game_logic_reconn_timeout', PlayerId}, State) ->
	EventType = ?JSET_GAME_LOGIC_RECONN_TIMEOUT,
	JobSchsLeft = remove_one_sch_for_player__(State#state.job_schedules, PlayerId, EventType),
	{noreply, State#state{job_schedules = JobSchsLeft}};

handle_cast({'force_handle_reconnect_timeout_sch', PlayerId}, State) ->
	EventType = ?JSET_RECONNECT_TIMEOUT,
	JobSchsLeft = remove_one_sch_for_player__(State#state.job_schedules, PlayerId, EventType),
	mod_login:final_logout(PlayerId),
	{noreply, State#state{job_schedules = JobSchsLeft}};

handle_cast({'force_handle_all_reconnect_timeout_schs'}, State) ->
	JobSchsLeft = force_handle_all_reconnect_timeout_schs__(State#state.job_schedules),
	{noreply, State#state{job_schedules = JobSchsLeft}};


%% 处理作业计划
handle_cast({'handle_job_schedules', _CurTickCount, CurUnixTime}, State) ->
	UndoneJobSchs = handle_job_schedules(State#state.job_schedules, CurUnixTime),
	{noreply, State#state{job_schedules = UndoneJobSchs}};



handle_cast(_Msg, State) ->
	?WARNING_MSG("unhandle cast ~p", [_Msg]),
	?ASSERT(false, _Msg),
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
	case Reason of
		normal -> skip;
		shutdown -> skip;
		_ -> ?ERROR_MSG("[mod_ply_jobsch] !!!!!terminate!!!!! for reason: ~w", [Reason])
	end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.





%%========================================== Local Functions ===============================================

find_schs_for_player__(JobSchedules, PlayerId, EventType) ->
	Iter = gb_trees:iterator(JobSchedules),
	find_schs_for_player__(gb_trees:next(Iter), PlayerId, EventType, []).


find_schs_for_player__(none, _PlayerId, _EventType, AccSchList) ->
	AccSchList;
find_schs_for_player__({_Key, Val, Iter}, PlayerId, EventType, AccSchList) ->
	% ?TRACE("find_schs_for_player__(), PlayerId=~p~n", [PlayerId]),
	% {_TriggerTime, _SeqNum} = _Key,
	?ASSERT(is_record(Val, job_sche)),
	case (Val#job_sche.player_id == PlayerId)
	andalso (Val#job_sche.event_type == EventType) of
		true ->
			AccSchList_2 = [Val | AccSchList],
			find_schs_for_player__(gb_trees:next(Iter), PlayerId, EventType, AccSchList_2);
		false ->
			find_schs_for_player__(gb_trees:next(Iter), PlayerId, EventType, AccSchList)
	end.





%% 移除玩家的一个特定事件类型的作业计划，返回剩余的作业计划
remove_one_sch_for_player__(JobSchedules, PlayerId, EventType) ->
	Iter = gb_trees:iterator(JobSchedules),
	remove_one_sch_for_player__(gb_trees:next(Iter), JobSchedules, PlayerId, EventType).

remove_one_sch_for_player__(none, JobSchedules, _PlayerId, _EventType) ->
	JobSchedules;
remove_one_sch_for_player__({Key, Val, Iter}, JobSchedules, PlayerId, EventType) ->
	% ?TRACE("remove_one_sch_for_player__(), PlayerId=~p~n", [PlayerId]),
	% {_TriggerTime, _SeqNum} = Key,
	?ASSERT(is_record(Val, job_sche)),
	case (Val#job_sche.player_id == PlayerId)
	andalso (Val#job_sche.event_type == EventType) of
		true ->
			JobSchedules_2 = gb_trees:delete(Key, JobSchedules),
			JobSchedules_2;
		false ->
			remove_one_sch_for_player__(gb_trees:next(Iter), JobSchedules, PlayerId, EventType)
	end.





%% 删除指定玩家的所有作业计划，返回剩余的作业计划
remove_all_schs_for_player__(JobSchedules, PlayerId) ->
	Iter = gb_trees:iterator(JobSchedules),
	remove_all_schs_for_player__(gb_trees:next(Iter), JobSchedules, PlayerId).

remove_all_schs_for_player__(none, JobSchedules, _PlayerId) ->
	JobSchedules;
remove_all_schs_for_player__({Key, Val, Iter}, JobSchedules, PlayerId) ->
	% ?TRACE("remove_all_schs_for_player__(), PlayerId=~p~n", [PlayerId]),
	% {_TriggerTime, _SeqNum} = Key,
	?ASSERT(is_record(Val, job_sche)),
	case Val#job_sche.player_id == PlayerId of
		true ->
			JobSchedules_2 = gb_trees:delete(Key, JobSchedules),
			remove_all_schs_for_player__(gb_trees:next(Iter), JobSchedules_2, PlayerId);
		false ->
			remove_all_schs_for_player__(gb_trees:next(Iter), JobSchedules, PlayerId)
	end.




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



%% 强行处理所有的重连超时作业计划，返回剩余的作业计划
force_handle_all_reconnect_timeout_schs__(JobSchedules) ->
	Iter = gb_trees:iterator(JobSchedules),
	force_handle_all_reconnect_timeout_schs__(gb_trees:next(Iter), JobSchedules).

force_handle_all_reconnect_timeout_schs__(none, JobSchedules) ->
	JobSchedules;
force_handle_all_reconnect_timeout_schs__({Key, Val, Iter}, JobSchedules) ->
	%%?TRACE("force_handle_all_reconnect_timeout_schs__()~n", []),
	%%{_TriggerTime, _SeqNum} = Key,
	?ASSERT(is_record(Val, job_sche)),
	case Val#job_sche.event_type == ?JSET_RECONNECT_TIMEOUT of
		true ->
			PlayerId = Val#job_sche.player_id,
			?TRACE("force_handle_all_reconnect_timeout_schs__(), PlayerId:~p~n", [PlayerId]),
			mod_login:final_logout(PlayerId),
			JobSchedules_2 = gb_trees:delete(Key, JobSchedules),
			force_handle_all_reconnect_timeout_schs__(gb_trees:next(Iter), JobSchedules_2);
		false ->
			force_handle_all_reconnect_timeout_schs__(gb_trees:next(Iter), JobSchedules)
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


%% 处理作业计划：重连超时
handle_job_sch(?JSET_RECONNECT_TIMEOUT, JobSch) ->
	PlayerId = JobSch#job_sche.player_id,
	% old:
	% case mod_svr_mgr:get_tmplogout_player_brief(PlayerId) of
	% 	null ->
	% 		?ERROR_MSG("[mod_ply_jobsch] handle_job_sch failed(can't find player)!!! JobSch: ~w", [JobSch]),
	% 		?ASSERT(false, JobSch),
	% 		skip;
	% 	PB ->
	% 		Pid = PB#plyr_brief.pid,
	% 		?ASSERT(is_process_alive(Pid)),
	% 		gen_server:cast(Pid, {'job_sche_feedback', JobSch})
	% end;
	mod_login:final_logout(PlayerId);


%% 处理作业计划：取消buff
handle_job_sch(?JSET_CANCEL_BUFF, JobSch) ->
	PlayerId = JobSch#job_sche.player_id,
	case player:get_pid(PlayerId) of
		null ->
			?ERROR_MSG("[mod_ply_jobsch] handle_job_sch failed(can't find player)!!! JobSch:~w", [JobSch]),
			?ASSERT(false, JobSch),
			skip;
		Pid ->
			gen_server:cast(Pid, {'job_sche_feedback', JobSch})
	end;


handle_job_sch(?JSET_GOODS_EXPIRE, JobSch) ->
	PlayerId = JobSch#job_sche.player_id,
	case player:get_pid(PlayerId) of
		null ->
			?ERROR_MSG("[mod_ply_jobsch] handle_job_sch failed(can't find player)!!! JobSch:~w", [JobSch]),
			?ASSERT(false, JobSch),
			skip;
		Pid ->
			gen_server:cast(Pid, {'job_sche_feedback', JobSch})
	end;


handle_job_sch(?JSET_GAME_LOGIC_RECONN_TIMEOUT, JobSch) ->
	?TRACE("[mod_ply_jobsch] handle_job_sch, JSET_GAME_LOGIC_RECONN_TIMEOUT JobSch:~w~n~n", [JobSch]),
	PlayerId = JobSch#job_sche.player_id,
	case ply_tmplogout_cache:get_tmplogout_PS(PlayerId) of
		null ->
			?ASSERT(false, PlayerId),
			?ERROR_MSG("[mod_ply_jobsch] handle_job_sch failed!!! PlayerId:~p, JobSch:~w", [PlayerId, JobSch]);
		PS ->
			mod_lgout_svr:handle_game_logic_reconn_timeout(PS)
	end;


handle_job_sch(?JSET_CLEAR_HIRE_DATA, _JobSch) ->
	?TRACE("[mod_ply_jobsch] handle_job_sch, JSET_CLEAR_HIRE_DATA JobSch:~w~n", [_JobSch]),
	mod_hire_mgr:on_job_schedule();


handle_job_sch(?JSET_BUY_BACK_GOODS_EXPIRE, JobSch) ->
	PlayerId = JobSch#job_sche.player_id,
	case player:get_pid(PlayerId) of
		null ->
			?ERROR_MSG("[mod_ply_jobsch] handle_job_sch failed(can't find player)!!! JobSch:~w", [JobSch]),
			?ASSERT(false, JobSch),
			skip;
		Pid ->
			gen_server:cast(Pid, {'job_sche_feedback', JobSch})
	end;

handle_job_sch(?JSET_UPDATE_PAR_MOOD, JobSch) ->
	PlayerId = JobSch#job_sche.player_id,
	case player:get_pid(PlayerId) of
		null -> skip;
		Pid -> gen_server:cast(Pid, {'job_sche_feedback', JobSch})
	end;

handle_job_sch(mfa, JobSch) ->
	PlayerId = JobSch#job_sche.player_id,
	case player:get_pid(PlayerId) of
		null -> skip;
		Pid -> gen_server:cast(Pid, {'job_sche_feedback', JobSch})
	end;

handle_job_sch(_EventType, JobSch) ->
	?ERROR_MSG("[mod_ply_jobsch] handle_job_sch failed(unknown event type)!!! JobSch:~w", [JobSch]),
	?ASSERT(false, JobSch),
	void.
