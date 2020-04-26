%%%------------------------------------
%%% @Module  : mod_cruise
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.5.28
%%% @Description: 巡游活动服务
%%%------------------------------------
-module(mod_cruise).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start_link/0,

        on_activity_begin/0,
        on_activity_end/0,

        spawn_next_cruise_npc/0,

        player_req_join_cruise/1,
        player_stop_cruise/2,

        c2s_notify_player_pass_quiz/1,

        cur_waiting_npc_start_cruise/0,

        on_inst_finish/3,

        % 仅用于调试
        dbg_force_open_activity/0,
        dbg_force_close_activity/0,
        dbg_get_cur_waiting_npc/0
        ]).

-include("common.hrl").
-include("cruise_activity.hrl").
-include("char.hrl").
-include("debug.hrl").
-include("activity_degree_sys.hrl").
-include("prompt_msg_code.hrl").
-include("abbreviate.hrl").
-include("player.hrl").
-include("sys_code.hrl").


-record(state, {}).


-define(CRUISE_NPC_WAIT_TIME, 60).             % 巡游npc等待玩家报名参与活动的持续时间（单位：秒）
-define(SPAWN_NEXT_CRUISE_NPC_INTERVAL, 15).   % 刷出下一个巡游npc的时间间隔（单位：秒）

%% 进程字典的key名
-define(PDKN_ACTIVITY_OPEN_STATE, pdkn_activity_open_state).
-define(PDKN_CUR_WAITING_NPC_ID, pdkn_cur_waiting_npc_id).
-define(PDKN_DBG_ACTIVITY_OPEN_STATE, pdkn_dbg_activity_open_state).  % 仅用于方便测试活动！
-define(PDKN_INSTANCE_PID, pdkn_instance_pid).
-define(CUR_WAITING_NPC_START_CRUISE_TIME, cur_waiting_npc_start_cruise_time).
-define(PDKN_PLAYER_CUR_CRUISE_NPC, pdkn_player_cur_cruise_npc).
-define(PDKN_REQ_JOIN_PLAYER_LIST, pdkn_req_join_player_list).



start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).



%% 活动开始时的处理
on_activity_begin() ->
    % gen_server:cast(?MODULE, {'on_activity_begin'}).
    do_nothing.  % 已改为全天候开启 -- 2014/9/20


    


on_activity_end() ->
    % 需要更新cur waiting npc到ets globa data？？ -- 不需要！
    
    % update_activity_open_state(closed).


    do_nothing.

    


% update_cur_waiting_npc_bhv_state(NewBhvState) ->
%     gen_server:cast(?MODULE, {'update_cur_waiting_npc_bhv_state', NewBhvState}).


%% @para: NewState => open | closed
% update_activity_open_state(NewState) ->
%     gen_server:cast(?MODULE, {'update_activity_open_state', NewState}).




%% npc开始巡游（作业计划的回调）
cur_waiting_npc_start_cruise() ->
    gen_server:cast(?MODULE, {'cur_waiting_npc_start_cruise'}).


% on_player_tmp_logout(PS) ->
%     gen_server:cast(?MODULE, {'on_player_tmp_logout', PS}).


%% 活动实例结束
on_inst_finish(NpcObj, InstPid, JoiningPlayerList) ->
    gen_server:cast(?MODULE, {'on_inst_finish', NpcObj, InstPid, JoiningPlayerList}).







% %% 刷出第一个巡游npc
% spawn_first_cruise_npc() ->
%     gen_server:cast(?MODULE, {'spawn_first_cruise_npc'}).


%% 刷出下一个巡游npc（作业计划的回调）
spawn_next_cruise_npc() ->
    gen_server:cast(?MODULE, {'spawn_next_cruise_npc'}).





%% 玩家报名参加巡游活动
player_req_join_cruise(PS) ->
	gen_server:cast(?MODULE, {'player_req_join_cruise', PS}).



player_stop_cruise(PS, Reason) ->
    gen_server:cast(?MODULE, {'player_stop_cruise', PS, Reason}).



c2s_notify_player_pass_quiz(PS) ->
    gen_server:cast(?MODULE, {'c2s_notify_player_pass_quiz', PS}).



dbg_force_open_activity() ->
    gen_server:cast(?MODULE, {'dbg_force_open_activity'}).


dbg_force_close_activity() ->
    gen_server:cast(?MODULE, {'dbg_force_close_activity'}).



dbg_get_cur_waiting_npc() ->
    gen_server:call(?MODULE, {'dbg_get_cur_waiting_npc'}).


%% ===================================================================================================
    
init([]) ->
    process_flag(trap_exit, true),

    do_init_jobs(),

    State = #state{},
    {ok, State}.





% handle_cast({'spawn_first_cruise_npc'} , State) ->
%     spawn_first_cruise_npc(),
%     {noreply, State};




handle_cast({'spawn_next_cruise_npc'} , State) ->
    ?TRY_CATCH(spawn_next_cruise_npc__(), ErrReason),
    {noreply, State};




handle_cast({'player_req_join_cruise', PS} , State) ->
    ?TRY_CATCH(player_req_join_cruise__(PS), ErrReason),
    {noreply, State};




handle_cast({'player_stop_cruise', PS, Reason} , State) ->
    ?TRY_CATCH(player_stop_cruise__(PS, Reason), ErrReason),
    {noreply, State};


handle_cast({'c2s_notify_player_pass_quiz', PS} , State) ->
    PlayerId = player:id(PS),
    case check_c2s_notify_player_pass_quiz(PS) of
        ok ->
            case get_player_cur_cruise_npc_id(PlayerId) of
                ?INVALID_ID ->
                    ?ASSERT(false, PlayerId),
                    skip;
                NpcId ->
                    case get_inst_pid_by_npc_id(NpcId) of
                        null ->
                            ?ASSERT(false, PlayerId),
                            skip;
                        InstPid ->
                            mod_cruise_inst:c2s_notify_player_pass_quiz(InstPid, PS)
                    end
            end;       
        fail ->
            ?DEBUG_MSG("check_c2s_notify_player_pass_quiz() failed!!! PlayerId:~p", [PlayerId]),
            skip
    end,
    {noreply, State};


handle_cast({'dbg_force_open_activity'} , State) ->
    dbg_force_open_activity__(),
    {noreply, State};



handle_cast({'dbg_force_close_activity'} , State) ->
    ?TRACE("handle_cast, dbg_force_close_activity~n"),
    dbg_force_close_activity__(),
    {noreply, State};


% handle_cast({'dbg_set_activity_open_state', OpenState} , State) ->
%     ?DEBUG_MSG("handle_cast, dbg_set_activity_open_state, OpenState:~p", [OpenState]),
%     dbg_set_activity_open_state(OpenState),
%     {noreply, State};


handle_cast({'on_activity_begin'} , State) ->
    ?DEBUG_MSG("[mod_cruise] handle_cast, on_activity_begin", []),
    on_activity_begin__(),
    {noreply, State};








% handle_cast({'update_activity_open_state', NewState} , State) ->
%     set_activity_open_state(NewState),
%     {noreply, State};


    


handle_cast({'cur_waiting_npc_start_cruise'} , State) ->
    % 若活动已结束，则不巡游
    % case is_activity_closed() of
    %     true ->
    %         ?DEBUG_MSG("[mod_cruise] cur_waiting_npc_start_cruise, but activity closed!!!!!!", []),
    %         skip;
    %     false ->
            ?DEBUG_MSG("[mod_cruise] cur_waiting_npc_start_cruise, ok!", []),
            
            NpcId = get_cur_waiting_npc_id(),
            NpcObj = get_cur_waiting_npc(),
            ?ASSERT(NpcObj /= null),

            % 更新npc的行为状态为： 巡游中
            mod_npc:set_bhv_state(NpcObj, ?BHV_CRUISING),


            ReqJoinPlayerList = get_req_join_player_list(NpcId),

            mark_player_cruising(ReqJoinPlayerList),
            
            % 开启巡游活动的一个实例
            case mod_cruise_inst:start(NpcObj, ReqJoinPlayerList) of
                {ok, InstPid} ->
                    NpcId = mod_npc:get_id(NpcObj),
                    add_map_of_npc_id_to_inst_pid(NpcId, InstPid);
                Any ->
                    ?ASSERT(false, {Any, NpcObj}),
                    ?ERROR_MSG("[mod_cruise] start instance failed!!! details:~w, NpcObj:~w", [Any, NpcObj]),
                    skip
            end,

            % 删除，避免数据残余
            erase_req_join_player_list(NpcId),

            % 添加作业计划： N秒后刷出下一个巡游npc
            mod_sys_jobsch:add_sch_spawn_next_cruise_npc(?SPAWN_NEXT_CRUISE_NPC_INTERVAL),
    % end,
    {noreply, State};




% handle_cast({'on_player_tmp_logout', PS} , State) ->
%     ?DEBUG_MSG("[mod_cruise] handle_cast, on_player_tmp_logout, PlayerId:~p", [player:id(PS)]),


%     PlayerId = player:id(PS),

%     case get_player_cur_cruise_npc_id(PlayerId) of
%         ?INVALID_ID ->
%             ?ASSERT(false, PlayerId),
%             skip;
%         NpcId ->
%             try_del_from_req_join_player_list(NpcId, PlayerId),



%     end,
%     {noreply, State};



handle_cast({'on_inst_finish', NpcObj, _InstPid, JoiningPlayerList} , State) ->
    ?DEBUG_MSG("[mod_cruise] handle_cast, on_inst_finish, NpcObj:~w, InstPid:~p", [NpcObj, _InstPid]),

    F = fun(PlayerId) ->
            case player:get_PS(PlayerId) of
                null -> skip;
                PS ->
                    ply_cruise:notify_cli_inst_finish(PS),
                    do_player_stop_cruise(PS, inst_finish)
            end
        end,

    lists:foreach(F, JoiningPlayerList),


    NpcId = mod_npc:get_id(NpcObj),

    % 删除npc对象
    mod_scene:clear_dynamic_npc_from_scene_WNC(NpcId),

    % 删除npc id到对应的活动实例pid的映射
    del_map_of_npc_id_to_inst_pid(NpcId),


    % todo: 其他处理？？
    % 。。。

    {noreply, State};




handle_cast(_Msg, State) ->
    ?TRACE("!!!!!!!!!!!!!!handle_cast, _Msg:~p~n", [_Msg]),
    ?ASSERT(false, _Msg),
    {noreply, State}.





handle_call({'dbg_get_cur_waiting_npc'} , _From, State) ->
    NpcId = get_cur_waiting_npc_id(),
    NpcObj = get_cur_waiting_npc(),
    {reply, {NpcId, NpcObj}, State};

handle_call(_Msg , _From, State) ->
    ?TRACE("!!!!!!!!!!!!!handle_call, _Msg:~p~n", [_Msg]),
    ?ASSERT(false, _Msg),
    {reply, ok, State}.



handle_info(_Msg, State) ->
    ?TRACE("!!!!!!!!!!handle_info, _Msg:~p~n", [_Msg]),
    {noreply, State}.

terminate(Reason, _State) ->
    ?TRACE("!!!!!!!!!! mod_cruise terminate!! Reason:~w~n", [Reason]),
    case Reason of
        normal -> skip;
        shutdown -> skip;
        {shutdown, _} -> skip;
        _ -> ?ERROR_MSG("[mod_cruise] !!!!!terminate!!!!! for reason:~w", [Reason])
    end,
    % do_terminate_jobs(),
    ok.


code_change(_OldVsn, State, _Extra)->
	{ok, State}.








do_init_jobs() ->
    % set_activity_open_state(closed).  % 初始化活动为关闭状态

    spawn_first_cruise_npc__(),

    on_activity_begin__().


    % % 针对进程崩溃后重启的情况，做恢复处理 ---- 暂时不做！
    % case is_activity_open() of
    %     true ->
                %todo_here...
    %         %%%%on_activity_begin__();
    %     false ->
    %         skip
    % end.




% %% 需删除npc？？
% do_terminate_jobs() ->
%     % case get_cur_waiting_npc() of
%     %     null ->
%     %         skip;
%     %     NpcObj ->
%     %         case is_npc_waiting_player_to_join() of
%     %         end
%     % end.
    
%     void.




%% 刷出第一个巡游活动npc
spawn_first_cruise_npc__() ->
    {ok, NpcId} = spawn_cruise_npc(),
    %%% mod_npc:set_bhv_state(NpcId, ?BHV_WAITING_PLAYER_TO_JOIN_CRUISE),
    set_cur_waiting_npc_id(NpcId),
    ?DEBUG_MSG("spawn_first_cruise_npc(), NpcId:~p", [NpcId]),
    void.



%% 刷出下一个巡游活动npc
spawn_next_cruise_npc__() ->
    {ok, NpcId} = spawn_cruise_npc(),
    %%% mod_npc:set_bhv_state(NpcId, ?BHV_WAITING_PLAYER_TO_JOIN_CRUISE),
    update_cur_waiting_npc_id(NpcId),
    % ?DEBUG_MSG("spawn_next_cruise_npc, NpcId:~p", [NpcId]),

    case is_activity_closed() of
        true ->
            skip;
        false ->
            mod_npc:set_bhv_state(NpcId, ?BHV_WAITING_PLAYER_TO_JOIN_CRUISE),

            schedule_cur_waiting_npc_start_cruise()
    end.



schedule_cur_waiting_npc_start_cruise() ->
    set_cur_waiting_npc_start_cruise_time( util:unixtime() + ?CRUISE_NPC_WAIT_TIME),
    % 添加作业计划：npc开始巡游（N秒之后）
    mod_sys_jobsch:add_sch_cur_waiting_npc_start_cruise(?CRUISE_NPC_WAIT_TIME).



      

%% 刷出巡游npc
spawn_cruise_npc() ->
    NpcNo = mod_global_data:get_cruise_activity_npc_no(),
    {SceneNo, X, Y} = get_cruise_npc_init_pos(),
    InitBhvState = ?BHV_IDLE, % 初始为空闲
    mod_scene:spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneNo, X, Y, [{bhv_state, InitBhvState}]).



on_activity_begin__() ->
    case get_dbg_activity_open_state() of
        open ->  % 已经通过调试手段（比如使用gm指令）开启了活动，则直接skip，以避免重复处理！
            ?DEBUG_MSG("on_activity_begin__(), already open by debug hacking, so skip! cur_waiting_npc_obj:~w", [get_cur_waiting_npc()]),
            skip;
        _ ->
            ?TRACE("!!!!!!!!!!!on_activity_begin__()"),

            ?ASSERT(get_cur_waiting_npc() /= null),
            %%%mod_npc:set_bhv_state(NpcObj, ?BHV_WAITING_PLAYER_TO_JOIN_CRUISE),

            NpcId = get_cur_waiting_npc_id(),
            mod_npc:set_bhv_state(NpcId, ?BHV_WAITING_PLAYER_TO_JOIN_CRUISE),

            schedule_cur_waiting_npc_start_cruise()            
    end.


            






dbg_force_open_activity__() ->
    case is_activity_open() of
        true ->  % 已开启，则skip
            ?TRACE("cruise activity already open, so skip!!!~n"),
            skip;
        false ->
            on_activity_begin__(),
            set_dbg_activity_open_state(open)
    end.
    

dbg_force_close_activity__() ->
    set_dbg_activity_open_state(closed).




get_dbg_activity_open_state() ->
    erlang:get(?PDKN_DBG_ACTIVITY_OPEN_STATE).

set_dbg_activity_open_state(OpenState) ->
    ?DEBUG_MSG("set_dbg_activity_open_state(), OpenState:~p", [OpenState]),
    erlang:put(?PDKN_DBG_ACTIVITY_OPEN_STATE, OpenState).



% get_activity_open_state() ->
%     erlang:get(?PDKN_ACTIVITY_OPEN_STATE).

% set_activity_open_state(State) ->
%     ?ASSERT(NewState == open orelse NewState == closed),
%     erlang:put(?PDKN_ACTIVITY_OPEN_STATE, State).


is_activity_open() ->
    case get_dbg_activity_open_state() of
        undefined ->
            ?DEBUG_MSG("get_dbg_activity_open_state() ret undefined", []),
            % mod_activity:publ_is_activity_alive(?AD_CRUISE);
            true;  % 现在已经是改为全天候开放
        open ->
            ?DEBUG_MSG("get_dbg_activity_open_state() ret open", []),
            true;
        closed ->
            ?DEBUG_MSG("get_dbg_activity_open_state() ret closed", []),
            false
    end.


            


is_activity_closed() ->
    not is_activity_open().




%% 获取巡游npc的初始位置
get_cruise_npc_init_pos() ->
    MainCitySceneNo = mod_global_data:get_main_city_scene_no(),
    {X, Y} = data_npc_cruise_path:get(0),
    {MainCitySceneNo, X, Y}.



get_cur_waiting_npc() ->
    % 从ets global data获取当前等待玩家报名的巡游npc的id（开服时即初始化）
    % NpcId = mod_global_data:get_cur_waiting_cruise_npc_id(),

    NpcId = get_cur_waiting_npc_id(),
    mod_npc:get_obj(NpcId).




get_cur_waiting_npc_id() ->
    case erlang:get(?PDKN_CUR_WAITING_NPC_ID) of
        undefined -> ?INVALID_ID;
        NpcId -> NpcId
    end.

set_cur_waiting_npc_id(NpcId) ->
    erlang:put(?PDKN_CUR_WAITING_NPC_ID, NpcId).


update_cur_waiting_npc_id(NewNpcId) ->
    set_cur_waiting_npc_id(NewNpcId).




get_cur_waiting_npc_start_cruise_time() ->
    erlang:get(?CUR_WAITING_NPC_START_CRUISE_TIME).

set_cur_waiting_npc_start_cruise_time(UnixTime) ->
    erlang:put(?CUR_WAITING_NPC_START_CRUISE_TIME, UnixTime).





%% 获取npc对应的活动实例进程的pid
%% @return: null | 进程Pid
get_inst_pid_by_npc_id(NpcId) ->
    case erlang:get({?PDKN_INSTANCE_PID, NpcId}) of
        undefined -> null;  % 如果创建活动实例失败，则可能进入此分支
        Pid -> ?ASSERT(is_pid(Pid)), Pid
    end.

%% 添加映射：npc id -> 对应活动实例进程的pid
add_map_of_npc_id_to_inst_pid(NpcId, InstPid) when is_pid(InstPid) ->
    ?ASSERT(get_inst_pid_by_npc_id(NpcId) == null, {NpcId, InstPid}),
    erlang:put({?PDKN_INSTANCE_PID, NpcId}, InstPid).


%% 删除映射
del_map_of_npc_id_to_inst_pid(NpcId) ->
    erlang:erase({?PDKN_INSTANCE_PID, NpcId}).



player_req_join_cruise__(PS) ->
    case check_player_req_join_cruise(PS) of
        ok ->
            do_player_join_cruise(PS);
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason)
    end.


player_stop_cruise__(PS, Reason) ->
    case check_player_stop_cruise(PS) of
        ok ->
            do_player_stop_cruise(PS, Reason);
        {fail, FailReason} ->
            lib_send:send_prompt_msg(PS, FailReason)
    end.



%% check时需注意到：玩家有可能重复报名（协议连续发多次）！！！
check_player_req_join_cruise(PS) ->
    % 是否空闲？
    case player:is_idle(PS) of
    	false ->
    		{fail, ?PM_BUSY_NOW};
    	true ->
            % 是否在队伍中？
            case player:is_in_team(PS) of
                true ->
                    {fail, ?PM_REQ_JOIN_FAIL_FOR_IN_TEAM};
                false ->
                    % 系统是否已对玩家开放？
                    case ply_sys_open:is_open(PS, ?SYS_CRUISE) of
                        false ->
                            {fail, ?PM_LV_LIMIT};
                        true ->
                            % 是否次数已用完
                            case ply_cruise:has_join_times(PS) of
                                false ->
                                    {fail, ?PM_CRUISE_TIMES_LIMIT};
                                true ->
                                    % 是否处于活动时间内
                                    case is_activity_open() of
                                        false ->
                                            {fail, ?PM_CRUISE_ACTIVITY_NOT_OPEN};
                                        true ->
                                            % 当前巡游npc是否存在？
                                            case get_cur_waiting_npc() of %%%get_cur_cruise_npc() of
                                                null ->
                                                    ?ASSERT(false),
                                                    {fail, ?PM_UNKNOWN_ERR};
                                                NpcObj ->
                                                    % 玩家是否距离npc太远？
                                                    case is_too_far(PS, NpcObj) of
                                                        true ->
                                                            {fail, ?PM_TOO_FAR_FROM_NPC};
                                                        false ->
                                                            NpcId = get_cur_waiting_npc_id(),
                                                            PlayerId = player:id(PS),
                                                            % 是否已报过名了？
                                                            case is_in_req_join_player_list(PlayerId, NpcId) of
                                                                true ->
                                                                    {fail, ?PM_ALRDY_REQ_JOIN_CRUISE};
                                                                false ->
                                                                    % npc是否处于等待玩家报名的时间段内
                                                                    case is_npc_waiting_player_to_join(NpcObj) of
                                                                        false ->
                                                                            {fail, ?PM_CRUISE_NPC_NOT_WAITING_PLAYER_TO_JOIN};
                                                                        true ->
                                                                            % 报名人数是否已满？
                                                                            ReqJoinPlayerList = get_req_join_player_list(NpcId),
                                                                            case length(ReqJoinPlayerList) >= ?MAX_JOIN_PLAYER_COUNT_EACH_TIME of
                                                                                true ->
                                                                                    {fail, ?PM_REQ_JOIN_FAIL_FOR_QUOTA_LIMIT};
                                                                                false ->
                                                                                    ok
                                                                            end
                                                                    end
                                                            end 
                                                    end
                                            end
                                    end 
                            end
                    end 
            end     	
    end.



is_too_far(PS, NpcObj) ->
    PlayerPos = player:get_position(PS),
    NpcSceneId = mod_npc:get_scene_id(NpcObj),
    {NpcX, NpcY} = mod_npc:get_xy(NpcObj),

    case PlayerPos#plyr_pos.scene_id /= NpcSceneId of
        true ->
            ?ASSERT(false, {PlayerPos, NpcSceneId}),
            true;
        false ->
            Dist = util:calc_manhattan_distance(PlayerPos#plyr_pos.x, PlayerPos#plyr_pos.y, NpcX, NpcY),
            Dist > 40
    end.


    



is_npc_waiting_player_to_join(NpcObj) ->
    mod_npc:is_waiting_player_to_join_cruise(NpcObj).


is_npc_cruising(NpcObj) ->
    mod_npc:is_cruising(NpcObj).



do_player_join_cruise(PS) ->
    PlayerId = player:id(PS),
    NpcId = get_cur_waiting_npc_id(),

    ?DEBUG_MSG("do_player_join_cruise(), PlayerId:~p", [PlayerId]),

    ?ASSERT(get_player_cur_cruise_npc_id(PlayerId) == ?INVALID_ID, PS),
    ?ASSERT(not is_in_req_join_player_list(PlayerId, NpcId), {PlayerId, NpcId, PS}),

    add_to_req_join_player_list(NpcId, PlayerId),
    add_map_of_player_to_cruise_npc(PlayerId, NpcId),

    ply_cruise:mark_waiting_to_start_cruise(PS),  % 更新行为状态
	ply_cruise:incr_join_times(PS),


    TimeNow = util:unixtime(),
    DiffTime = max(get_cur_waiting_npc_start_cruise_time() - TimeNow, 0),
    ply_cruise:notify_cli_req_join_success(PS, [DiffTime]).



	






check_player_stop_cruise(PS) ->
    case ply_cruise:is_waiting_to_start_cruise(PS) orelse ply_cruise:is_cruising(PS) of
        false ->
            ?ASSERT(false, PS),
            {fail, ?PM_UNKNOWN_ERR};
        true ->
            % todo: 确认是否需要其他检测？？
            % ...

            ok
    end.
    


check_c2s_notify_player_pass_quiz(PS) ->
    case ply_cruise:is_waiting_to_start_cruise(PS) orelse ply_cruise:is_cruising(PS) of
        false ->
            ?ASSERT(false, PS),
            fail;
        true ->
            % todo: 确认是否需要其他检测？？
            % ...

            ok
    end. 

    



%% 注意：由于并发原因（如：玩家主动中断巡游与玩家下线的并发），同一个玩家可能会重复调用此函数！
%% @para: Reason => inst_finish（活动实例结束） | stop_by_player（玩家主动中断） | logout（玩家下线）
do_player_stop_cruise(PS, Reason) ->    
    PlayerId = player:id(PS),

    ?DEBUG_MSG("do_player_stop_cruise(), PlayerId:~p", [PlayerId]),

    case Reason of
        inst_finish ->
            skip;
        _ ->
            case get_player_cur_cruise_npc_id(PlayerId) of
                ?INVALID_ID ->
                    ?ASSERT(false, PlayerId),  % todo: 由于并发原因，执行此分支有可能是正常的， 但触发概率很小，故暂时仍然断言，以后再去掉！
                    skip;
                NpcId ->
                    % 不管玩家是在等待开始巡游还是已经在巡游中，都尝试将其从已报名的列表中删除，以避免数据残余！
                    try_del_from_req_join_player_list(NpcId, PlayerId),

                    case get_inst_pid_by_npc_id(NpcId) of
                        null ->  % 如果npc还未开始巡游（即正在等待玩家报名），则进入此分支
                            ?ASSERT(is_npc_waiting_player_to_join( mod_npc:get_obj(NpcId)), {NpcId, PlayerId}),
                            skip;
                        InstPid ->
                            ?ASSERT(is_pid(InstPid), {InstPid, NpcId, PlayerId}),
                            ?ASSERT(is_npc_cruising( mod_npc:get_obj(NpcId)), {NpcId, PlayerId}),
                            % 通知对应的活动实例进程
                            mod_cruise_inst:player_stop_cruise(InstPid, PlayerId)
                    end
            end      
    end,

    ?Ifc (Reason /= logout)
        player:mark_idle(PS),
        ply_scene:notify_bhv_state_changed_to_aoi(PlayerId, ?BHV_IDLE),

        case ply_cruise:has_join_times(PS) of
            true -> skip;
            false -> mod_activity:notify_close_activity([PlayerId], ?AD_CRUISE)
        end
    ?End,

    % 删除，避免数据残余
    del_map_of_player_to_cruise_npc(PlayerId),

    ply_cruise:notify_cli_stop_cruise_success(PS).
    


%% 标记玩家为巡游中
mark_player_cruising(ReqJoinPlayerList) ->
    F = fun(PlayerId) ->
            case player:get_PS(PlayerId) of
                null ->
                    ?ASSERT(false, PlayerId),  % todo: 以后要去掉此断言！
                    skip;
                PS ->
                    ?DEBUG_MSG("[mod_cruise] mark_player_cruising(), PlayerId:~p", [PlayerId]),
                    ply_cruise:mark_cruising(PS)
            end
        end,
    lists:foreach(F, ReqJoinPlayerList).

    



%% 获取玩家当前所跟随的巡游活动npc的id
get_player_cur_cruise_npc_id(PlayerId) ->
    case erlang:get({?PDKN_PLAYER_CUR_CRUISE_NPC, PlayerId}) of
        undefined ->
            ?INVALID_ID;
        NpcId ->
            NpcId
    end.
    

%% 添加映射：玩家 -> 玩家当前所跟随的巡游活动npc
add_map_of_player_to_cruise_npc(PlayerId, NpcId) ->
    erlang:put({?PDKN_PLAYER_CUR_CRUISE_NPC, PlayerId}, NpcId).


del_map_of_player_to_cruise_npc(PlayerId) ->
    erlang:erase({?PDKN_PLAYER_CUR_CRUISE_NPC, PlayerId}).





is_in_req_join_player_list(PlayerId, NpcId) ->
    L = get_req_join_player_list(NpcId),
    lists:member(PlayerId, L).



get_req_join_player_list(NpcId) ->
    case erlang:get({?PDKN_REQ_JOIN_PLAYER_LIST, NpcId}) of
        undefined ->
            [];
        List ->
            List
    end.

set_req_join_player_list(NpcId, PlayerList) when is_list(PlayerList) ->
    erlang:put({?PDKN_REQ_JOIN_PLAYER_LIST, NpcId}, PlayerList).

add_to_req_join_player_list(NpcId, PlayerId) ->
    OldList = get_req_join_player_list(NpcId),
    NewList = OldList ++ [PlayerId],
    set_req_join_player_list(NpcId, NewList).


try_del_from_req_join_player_list(NpcId, PlayerId) ->
    case erlang:get({?PDKN_REQ_JOIN_PLAYER_LIST, NpcId}) of
        undefined ->
            skip;
        OldList ->
            NewList = OldList -- [PlayerId],
            set_req_join_player_list(NpcId, NewList)
    end.

erase_req_join_player_list(NpcId) ->
    erlang:erase({?PDKN_REQ_JOIN_PLAYER_LIST, NpcId}).


