%%%-------------------------------------------------
%%% @Module  : mod_go
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.3.5
%%% @Description: go进程, 专用于处理场景AOI，一个场景对应一个go进程
%%% 
%%% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%%%  可参看云风的blog：http://blog.codingnow.com/2008/07/aoi.html
%%% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%%%-------------------------------------------------
-module(mod_go).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
% -export([start_link/1]).

-export([
		player_move/4,
        enter_scene_on_login/2,
        leave_scene_on_logout/2,
        player_teleport/3,        

        mon_enter_scene/4,
        mon_leave_scene/1,

        npc_move/4,
        npc_enter_scene/4,
        npc_leave_scene/1,

        notify_mon_spawned_to_AOI/2,
        notify_mon_cleared_to_AOI/1,

        notify_npc_spawned_to_AOI/2,
        notify_npc_cleared_to_AOI/1,
        
        notify_AOI_info_to_player/2,

        send_to_AOI/3, send_to_AOI/2,
        send_to_AOI_except_me/3,
        send_to_AOI_by_scene_line_or_team_except_me/4,
        
        notify_player_enter_team_aoi/2,

        on_scene_created/1,
        on_scene_destroyed/1

        % clear_scene_grids_data/1
        ]).

-include("common.hrl").
-include("record.hrl").
-include("go.hrl").
-include("scene.hrl").
-include("player.hrl").
-include("ets_name.hrl").
-include("pt_12.hrl").
-include("abbreviate.hrl").
-include("aoi.hrl").
-include("scene_line.hrl").
-include("npc.hrl").


-record(state, {
            scene_id = 0
        }).


start_link(NewSceneObj) ->
    SceneId = lib_scene:get_id(NewSceneObj),
	ProcName = to_go_proc_name(SceneId),  %%list_to_atom("mod_go_" ++ integer_to_list(SceneId)),
	% ?TRACE("go proc name: ~p~n", [ProcName]),
    gen_server:start_link({local, ProcName}, ?MODULE, [NewSceneObj], []).


stop(SceneId) ->
    ?TRACE("mod_go:stop(), SceneId:~p~n", [SceneId]),
    ProcName = to_go_proc_name(SceneId),
    gen_server:cast(ProcName, {'stop'}).
    


%% 玩家移动
player_move(PS, SceneId, OldPlayerPos, NewPlayerPos) ->
    ?ASSERT(is_record(OldPlayerPos, plyr_pos)),
    ?ASSERT(is_record(NewPlayerPos, plyr_pos)),

	ProcName = to_go_proc_name(SceneId),

    % ?TRACE("mod_go, PlayerId:~p, SceneId:~p, ProcName:~p~n", [player:id(PS), SceneId, ProcName]),

    % 对于副本，此断言不一定适用，故屏蔽掉！
	% ?ASSERT(is_go_proc_alive(ProcName), {ProcName, player:id(PS), SceneId, OldPlayerPos, NewPlayerPos}),

	gen_server:cast(ProcName, {'player_move', PS, SceneId, OldPlayerPos, NewPlayerPos}).


% TODO: 处理怪物移动
% mon_move(_MonId, _NewX, _NewY) ->
% 	todo_here;



%% npc移动
npc_move(NpcObj, SceneId, OldPos, NewPos) ->
    ?ASSERT(is_record(OldPos, coord)),
    ?ASSERT(is_record(NewPos, coord)),
    ProcName = to_go_proc_name(SceneId),
    gen_server:cast(ProcName, {'npc_move', NpcObj, SceneId, OldPos, NewPos}).






enter_scene_on_login(PS, PlayerPos) ->
    ?ASSERT(is_record(PlayerPos, plyr_pos)),
    SceneId = PlayerPos#plyr_pos.scene_id,
    ProcName = to_go_proc_name(SceneId),
    %% ?ASSERT(is_go_proc_alive(ProcName), {ProcName, PlayerPos}),
    gen_server:cast(ProcName, {'enter_scene_on_login', PS, PlayerPos}).

    
leave_scene_on_logout(PS, PlayerPos) ->
    SceneId = PlayerPos#plyr_pos.scene_id,
    ProcName = to_go_proc_name(SceneId), 
    ?ASSERT(is_go_proc_alive(ProcName), {ProcName, PlayerPos}),
    gen_server:cast(ProcName, {'leave_scene_on_logout', PS, PlayerPos}).

    
    
%% 玩家单人执行传送
player_teleport(PS, OldPlayerPos, NewPlayerPos) ->
    ?ASSERT(is_record(OldPlayerPos, plyr_pos)),
    ?ASSERT(is_record(NewPlayerPos, plyr_pos)),

    OldGoProc = to_go_proc_name(OldPlayerPos#plyr_pos.scene_id), 
    gen_server:cast(OldGoProc, {'player_leave_old_scene_for_teleport', PS, OldPlayerPos, NewPlayerPos}),

    NewGoProc = to_go_proc_name(NewPlayerPos#plyr_pos.scene_id), 
    gen_server:cast(NewGoProc, {'player_enter_new_scene_for_teleport', PS, OldPlayerPos, NewPlayerPos}).


% %% 
% reset_step_counter(PlayerId) ->
%     SceneId = player:get_scene_id(PlayerId),
%     ProcName = to_go_proc_name(SceneId),
%     ?ASSERT(is_go_proc_alive(ProcName), {PlayerId, SceneId}),
%     gen_server:cast(ProcName, {'reset_step_counter', PlayerId}).





npc_enter_scene(NpcId, SceneId, X, Y) ->
    ProcName = to_go_proc_name(SceneId),
    ?ASSERT(is_go_proc_alive(ProcName), {NpcId, SceneId}),
    gen_server:cast(ProcName, {'npc_enter_scene', NpcId, SceneId, X, Y}).


npc_leave_scene(NpcObj) ->  %%%NpcId, SceneId, X, Y) ->
    SceneId = mod_npc:get_scene_id(NpcObj),
    ProcName = to_go_proc_name(SceneId),
    ?ASSERT(is_go_proc_alive(ProcName), NpcObj),
    gen_server:cast(ProcName, {'npc_leave_scene', NpcObj}).



mon_enter_scene(MonId, SceneId, X, Y) ->
    ProcName = to_go_proc_name(SceneId),
    ?ASSERT(is_go_proc_alive(ProcName), {MonId, SceneId}),
    gen_server:cast(ProcName, {'mon_enter_scene', MonId, SceneId, X, Y}).


mon_leave_scene(MonObj) ->
    SceneId = mod_mon:get_scene_id(MonObj),
    ProcName = to_go_proc_name(SceneId),
    ?ASSERT(is_go_proc_alive(ProcName), MonObj),
    gen_server:cast(ProcName, {'mon_leave_scene', MonObj}).



notify_mon_spawned_to_AOI(MonId, SceneId) ->
    ProcName = to_go_proc_name(SceneId),
    ?ASSERT(is_go_proc_alive(ProcName), {MonId, SceneId}),
    gen_server:cast(ProcName, {'notify_mon_spawned_to_AOI', MonId}).




notify_mon_cleared_to_AOI(MonObj) ->
    SceneId = mod_mon:get_scene_id(MonObj),
    ProcName = to_go_proc_name(SceneId),
    ?ASSERT(is_go_proc_alive(ProcName), {SceneId, MonObj}),
    gen_server:cast(ProcName, {'notify_mon_cleared_to_AOI', MonObj}).



notify_npc_spawned_to_AOI(NpcId_Or_NpcObj, SceneId) ->
    ProcName = to_go_proc_name(SceneId),
    ?ASSERT(is_go_proc_alive(ProcName), {NpcId_Or_NpcObj, SceneId}),
    gen_server:cast(ProcName, {'notify_npc_spawned_to_AOI', NpcId_Or_NpcObj}).    


notify_npc_cleared_to_AOI(NpcObj) ->
    SceneId = mod_npc:get_scene_id(NpcObj),
    ProcName = to_go_proc_name(SceneId),
    ?ASSERT(is_go_proc_alive(ProcName), {SceneId, NpcObj}),
    gen_server:cast(ProcName, {'notify_npc_cleared_to_AOI', NpcObj}).




% 通知场景AOI范围的信息给玩家
notify_AOI_info_to_player(PS, PlayerPos) ->
    ?ASSERT(is_record(PlayerPos, plyr_pos), PlayerPos),
    SceneId = PlayerPos#plyr_pos.scene_id,
    ProcName = to_go_proc_name(SceneId),
    ?ASSERT(is_go_proc_alive(ProcName), {SceneId, PlayerPos}),
    gen_server:cast(ProcName, {'notify_AOI_info_to_player', PS, PlayerPos}).



    
%% 发送消息给玩家对应的AOI范围内的所有客户端（九宫格区域）
send_to_AOI(0, PlayerId, Bin) ->
    skip;

%% 发送消息给玩家对应的AOI范围内的所有客户端（九宫格区域）
send_to_AOI(SceneId, PlayerId, Bin) ->
    ProcName = to_go_proc_name(SceneId),
    ?ASSERT(is_go_proc_alive(ProcName), {SceneId}),
    gen_server:cast(ProcName, {'send_to_AOI', SceneId, PlayerId, Bin}).

%% 发送消息给指定位置对应的AOI范围内的所有客户端（九宫格区域）
send_to_AOI({SceneId, X, Y}, Bin) ->
    ProcName = to_go_proc_name(SceneId),
    %%?ASSERT(is_go_proc_alive(ProcName), {SceneId}),
    gen_server:cast(ProcName, {'send_to_AOI', {SceneId, X, Y}, Bin}).

    
   
send_to_AOI_except_me(SceneId, MyId, Bin) ->
    ProcName = to_go_proc_name(SceneId),
    ?ASSERT(is_go_proc_alive(ProcName), {SceneId}),
    gen_server:cast(ProcName, {'send_to_AOI_except_me', SceneId, MyId, Bin}).



send_to_AOI_by_scene_line_or_team_except_me(SceneId, MyId, SceneLine, Bin) ->
    ProcName = to_go_proc_name(SceneId),
    ?ASSERT(is_go_proc_alive(ProcName), {SceneId}),
    gen_server:cast(ProcName, {'send_to_AOI_by_scene_line_or_team_except_me', SceneId, MyId, SceneLine, Bin}).
    
    

% send_to_AOI_by_scene_line_or_team_except_me_TOL(MyId, Pos, SceneLine, Bin) ->
%     SceneId = Pos#plyr_pos.scene_id,
%     ProcName = to_go_proc_name(SceneId),
%     ?ASSERT(is_go_proc_alive(ProcName), {SceneId}),
%     gen_server:cast(ProcName, {'send_to_AOI_by_scene_line_or_team_except_me_TOL', MyId, Pos, SceneLine, Bin}).
    



on_scene_created(NewSceneObj) ->
    % 开启场景对应的go进程
    case start_link(NewSceneObj) of
        {ok, _Pid} ->
            skip;
        Any ->
            ?ASSERT(false, NewSceneObj),
            ?ERROR_MSG("[mod_go] on_scene_created() error!! start_link() ret:~w, NewSceneObj:~w", [Any, NewSceneObj])
    end.





on_scene_destroyed(SceneId) ->
    stop(SceneId).
    



% %% （销毁场景时）清除场景的九宫格记录数据
% clear_scene_grids_data(SceneObj) ->
%     SceneId = lib_scene:get_id(SceneObj),
%     ProcName = to_go_proc_name(SceneId),
%     ?ASSERT(is_go_proc_alive(ProcName), {SceneId}),
%     gen_server:cast(ProcName, {'clear_scene_grids_data', SceneObj}).


    

%% （回归队伍时）通知进入队友的AOI
notify_player_enter_team_aoi(Team, PlayerId) ->
    case player:get_scene_id(PlayerId) of
        ?INVALID_SCENE_ID ->
            ?ASSERT(false, {PlayerId, Team}),
            skip;
        SceneId ->
            ProcName = to_go_proc_name(SceneId),
            ?ASSERT(is_go_proc_alive(ProcName), {SceneId, PlayerId, Team}),
            gen_server:cast(ProcName, {'notify_player_enter_team_aoi', Team, PlayerId})
    end.
    


   



%% ---------------------------------------------------------------------------

init([NewSceneObj]) ->
    process_flag(trap_exit, true),
    
    SceneId = lib_scene:get_id(NewSceneObj),
    % ?TRACE("[mod_go] init(), SceneId:~p~n", [SceneId]),
    SceneInfo = #aoi_scene{
                    scene_id = SceneId,
                    width = lib_scene:get_width(NewSceneObj),
                    height = lib_scene:get_height(NewSceneObj)
                    },
    lib_aoi:init_scene_info(SceneId, SceneInfo),
    {ok, #state{scene_id = SceneId}}.



	
handle_call(_Request, _From, State) ->
	?ASSERT(false, _Request),
    {reply, State, State}.


handle_cast({'player_move', PS, SceneId, OldPlayerPos, NewPlayerPos}, State) ->
    case check_player_move(SceneId, OldPlayerPos, NewPlayerPos) of
        fail ->
            skip;
        ok ->
            ?TRY_CATCH(handle_player_move(PS, SceneId, OldPlayerPos, NewPlayerPos), ErrReason)
    end,
    {noreply, State};



handle_cast({'npc_move', NpcObj, SceneId, OldPos, NewPos}, State) ->
    case check_npc_move(SceneId, OldPos, NewPos) of
        fail ->
            % ?DEBUG_MSG("check npc move failed!!! NpcId:~p, OldPos:~w, NewPos:~w", [mod_npc:get_id(NpcObj), OldPos, NewPos]),
            skip;
        ok ->
            ?TRY_CATCH(handle_npc_move(NpcObj, SceneId, OldPos, NewPos), ErrReason)
    end,   
    {noreply, State};



handle_cast({'enter_scene_on_login', PS, PlayerPos}, State) ->
    % case player:get_PS(PlayerId) of
    %     null -> skip;
    %     PS ->
            ?TRY_CATCH(enter_scene_on_login__(PS, PlayerPos), ErrReason),
    % end,         
    {noreply, State};


handle_cast({'leave_scene_on_logout', PS, PlayerPos}, State) ->
    ?TRY_CATCH(leave_scene_on_logout__(PS, PlayerPos), ErrReason),
    {noreply, State};

handle_cast({'player_leave_old_scene_for_teleport', PS, OldPlayerPos, NewPlayerPos}, State) ->
    ?TRY_CATCH(player_leave_old_scene_for_teleport__(PS, OldPlayerPos, NewPlayerPos), ErrReason),       
    {noreply, State};


handle_cast({'player_enter_new_scene_for_teleport', PS, _OldPlayerPos, NewPlayerPos}, State) ->
    ?TRY_CATCH(player_enter_new_scene_for_teleport__(PS, NewPlayerPos), ErrReason),
    % ?DEBUG_MSG("player_enter_new_scene_for_teleport__(), PlayerId:~p, OldSceneId:~p, NewSceneId:~p", [player:id(PS), _OldPlayerPos#plyr_pos.scene_id, NewPlayerPos#plyr_pos.scene_id]),
    {noreply, State};





% handle_cast({'enter_new_scene_by_teleport', PS, NewPlayerPos}, State) ->
%     ?TRY_CATCH(enter_new_scene__(PS, NewPlayerPos), ErrReason),       
%     {noreply, State};


% handle_cast({'reset_step_counter', PlayerId}, State) ->
%     reset_step_counter__(PlayerId),
%     {noreply, State};



handle_cast({'npc_enter_scene', NpcId, SceneId, X, Y}, State) ->
    ?TRY_CATCH(npc_enter_scene__(NpcId, SceneId, X, Y), ErrReason),
    {noreply, State};



        
handle_cast({'npc_leave_scene', NpcObj}, State) ->
    ?TRY_CATCH(npc_leave_scene__(NpcObj), ErrReason),
    {noreply, State};



handle_cast({'mon_enter_scene', MonId, SceneId, X, Y}, State) ->
    ?TRY_CATCH(mon_enter_scene__(MonId, SceneId, X, Y), ErrReason),
    {noreply, State};




handle_cast({'mon_leave_scene', MonObj}, State) ->
    ?TRY_CATCH(mon_leave_scene__(MonObj), ErrReason),
    {noreply, State};





handle_cast({'notify_mon_spawned_to_AOI', MonId}, State) ->
    ?TRY_CATCH(notify_mon_spawned_to_AOI__(MonId), ErrReason),
    {noreply, State};


handle_cast({'notify_mon_cleared_to_AOI', Mon}, State) ->
    ?TRY_CATCH(notify_mon_cleared_to_AOI__(Mon), ErrReason),
    {noreply, State};




handle_cast({'notify_npc_spawned_to_AOI', NpcId_Or_NpcObj}, State) ->
    ?TRY_CATCH(notify_npc_spawned_to_AOI__(NpcId_Or_NpcObj), ErrReason),
    {noreply, State};


handle_cast({'notify_npc_cleared_to_AOI', NpcObj}, State) ->
    ?TRY_CATCH(notify_npc_cleared_to_AOI__(NpcObj), ErrReason),
    {noreply, State};



handle_cast({'notify_AOI_info_to_player', PS, PlayerPos}, State) ->
    ?TRY_CATCH(notify_AOI_info_to_player__(PS, PlayerPos), ErrReason),
    {noreply, State};


handle_cast({'send_to_AOI', SceneId, PlayerId, Bin}, State) ->
    %%% ?ASSERT(is_record(PlayerPos, plyr_pos), PlayerPos),
    ?TRY_CATCH(send_to_AOI__(SceneId, PlayerId, Bin), ErrReason),
    {noreply, State};


handle_cast({'send_to_AOI', {SceneId, X, Y}, Bin}, State) ->
    ?TRY_CATCH(send_to_AOI__({SceneId, X, Y}, Bin), ErrReason),
    {noreply, State};


handle_cast({'send_to_AOI_except_me', SceneId, MyId, Bin}, State) ->
    ?TRY_CATCH(send_to_AOI_except_me__(SceneId, MyId, Bin), ErrReason),
    {noreply, State};


handle_cast({'send_to_AOI_by_scene_line_or_team_except_me', _SceneId, MyId, SceneLine, Bin}, State) ->
    %%% AoiPos = lib_aoi:to_aoi_pos(PlayerPos),
    ?TRY_CATCH(send_to_AOI_by_scene_line_or_team_except_me__(MyId, SceneLine, Bin), ErrReason),
    {noreply, State};




% handle_cast({'send_to_AOI_by_scene_line_or_team_except_me_TOL', MyId, Pos, SceneLine, Bin}, State) ->
%     send_to_AOI_by_scene_line_or_team_except_me_TOL__(MyId, Pos, SceneLine, Bin),
%     {noreply, State};




handle_cast({'notify_player_enter_team_aoi', Team, PlayerId}, State) ->
    ?TRY_CATCH(notify_player_enter_team_aoi__(Team, PlayerId)),
    {noreply, State};


% handle_cast({'on_scene_created', NewSceneObj}, State) ->
%     on_scene_created__(NewSceneObj),
%     {noreply, State};





handle_cast({'stop'}, State) ->
    % ?TRACE("[mod_go] stop!!!!!!!!!!!!  SceneId:~p~n", [State#state.scene_id]),
    % ?DEBUG_MSG("[mod_go] stop!!!!! SceneId:~p", [State#state.scene_id]),
    {stop, normal, State};



% handle_cast({'clear_scene_grids_data', SceneObj}, State) ->
%     clear_scene_grids_data__(SceneObj),
%     {noreply, State};


    
handle_cast(Msg, State) ->
	?ASSERT(false, Msg),
    ?ERROR_MSG("[mod_go] !!!unknown cast Msg:~w", [Msg]),
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(Reason, State) ->
    % ?TRACE("[mod_go] terminate for reason: ~w, SceneId:~p~n", [Reason, State#state.scene_id]),
    ?DEBUG_MSG("[mod_go] terminate for reason: ~w, SceneId:~p", [Reason, State#state.scene_id]),
	case Reason of
		normal -> skip;
		shutdown -> skip;
        {shutdown, _} -> skip;
		_ ->
            ?ERROR_MSG("[mod_go] !!!!!terminate!!!!! for reason: ~w, SceneId:~p", [Reason, State#state.scene_id]),
            % 按需重新开启go进程
            case lib_scene:is_copy_scene(State#state.scene_id) of
                true -> skip;
                false ->
                    case lib_aoi:get_scene_info() of
                        null -> skip;
                        SceneInfo ->
                            ?ERROR_MSG("[mod_go] !!!!!restart go proc!!!!! SceneInfo:~w", [SceneInfo]),
                            SceneObj = lib_aoi:to_scene_obj(SceneInfo),
                            mod_scene_mgr:restart_go_proc(SceneObj)
                    end
            end
	end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.





%%========================================== Local Functions ===============================================

is_go_proc_alive(ProcName) ->
    Pid = erlang:whereis(ProcName),
    is_pid(Pid) andalso is_process_alive(Pid).



% %% 是否主城场景？
% is_main_city_scene(SceneId) ->
%     L = mod_global_data:get_city_scene_no_list(),
%     %%?TRACE("city scene no list:~p~n", [L]),
%     lists:member(SceneId, L).



to_go_proc_name(SceneId) ->
    list_to_atom("mod_go_" ++ integer_to_list(SceneId)).








check_player_move(_SceneId, OldPlayerPos, NewPlayerPos) ->
    case (NewPlayerPos#plyr_pos.x == OldPlayerPos#plyr_pos.x)
    andalso (NewPlayerPos#plyr_pos.y == OldPlayerPos#plyr_pos.y) of
        true ->  % 坐标相同，不需移动
            fail;
        false ->
            ok
    end.




check_npc_move(_SceneId, OldPos, NewPos) ->
    case (NewPos#coord.x == OldPos#coord.x)
    andalso (NewPos#coord.y == OldPos#coord.y) of
        true ->  % 坐标相同，不需移动
            fail;
        false ->
            ok
    end.




% %% 处理玩家移动
% %% 终点为NewX，NewY
% handle_player_move(PS, SceneObj, OldPos, NewX, NewY) ->
%     ?ASSERT(OldPos#plyr_pos.scene_id == lib_scene:get_id(SceneObj)),
%     PlayerId = player:id(PS),
%     SendPid = player:get_sendpid(PlayerId),
%     ?ASSERT(is_pid(SendPid), {SendPid, PlayerId}),
    
%     OldX = OldPos#plyr_pos.x,   % 原x坐标
%     OldY = OldPos#plyr_pos.y,   % 原y坐标
%     OldGridIdx = OldPos#plyr_pos.scene_grid_index,
%     {AccSteps, MaxSteps} = OldPos#plyr_pos.step_counter,
    
%     NewGridIdx = update_player_grid_data(SceneObj, OldGridIdx, PlayerId, OldX, OldY, NewX, NewY, SendPid),

%     % TODO: 调整为在暗雷区走动时，才需要计步
%     StepsMoved = util:calc_manhattan_distance(OldX, OldY, NewX, NewY),

%     NewAccSteps = min(AccSteps + StepsMoved, MaxSteps),

%     NewStepCounter = {NewAccSteps, MaxSteps},

%     NewPos = OldPos#plyr_pos{x = NewX, y = NewY, scene_grid_index = NewGridIdx, step_counter = NewStepCounter},
%     player:set_position(PlayerId, NewPos),
    
%     SceneId = lib_scene:get_id(SceneObj),
%     lib_aoi:move_aoi_broadcast(PS, SceneId, NewX, NewY, OldGridIdx, NewGridIdx),

%     % 累计步数是否已达最大值？
%     case NewAccSteps == MaxSteps of
%         false ->
%             skip;
%         true ->
%             gen_server:cast( player:get_pid(PS), {'try_trigger_trap_after_move', PS, NewPos})
%     end.






%% 处理玩家移动
%% 起点为OldPlayerPos， 终点为NewPlayerPos
handle_player_move(PS, SceneId, OldPlayerPos, NewPlayerPos) ->
    PlayerId = player:id(PS),

    case lib_aoi:get_player_pos(PlayerId) of
        null ->  % 容错
            InitX = NewPlayerPos#plyr_pos.x,
            InitY = NewPlayerPos#plyr_pos.y,
            InitGridIdx = lib_aoi:calc_grid_index(SceneId, InitX, InitY),
            InitAoiPos = #aoi_pos{
                            scene_id = SceneId,
                            x = InitX,
                            y = InitY,
                            scene_line = NewPlayerPos#plyr_pos.scene_line,
                            scene_grid_index = InitGridIdx
                            },
            lib_aoi:set_player_pos(PlayerId, InitAoiPos),

            ?DEBUG_MSG("[mod_go] handle_player_move() error!! no aoi pos! PlayerId:~p, SceneId:~p, OldPlayerPos:~w, NewPlayerPos:~w, RealPos:~w",
                            [PlayerId, SceneId, OldPlayerPos, NewPlayerPos, player:get_position(PlayerId)]);

        OldAoiPos ->

            % todo： 确认：什么情况有可能会引起断言失败？ 传送时（场景内，场景间传送）？？
            case (OldAoiPos#aoi_pos.scene_id /= OldPlayerPos#plyr_pos.scene_id)
            orelse (OldAoiPos#aoi_pos.x /= OldPlayerPos#plyr_pos.x)
            orelse (OldAoiPos#aoi_pos.y /= OldPlayerPos#plyr_pos.y)
            orelse (OldAoiPos#aoi_pos.scene_line /= OldPlayerPos#plyr_pos.scene_line) of
                true ->
                    % 不再记录错误日志，故注释掉！
                    % ?ERROR_MSG("[mod_go] handle_player_move() error!! OldAoiPos and OldPlayerPos not match!! PlayerId:~p ~nOldAoiPos:~w ~nOldPlayerPos:~w ~nNewPlayerPos:~w ~nRealPos:~w",
                    %                         [PlayerId, OldAoiPos, OldPlayerPos, NewPlayerPos, player:get_position(PlayerId)]);
                    skip;
                false ->
                    ok
            end,

            SendPid = player:get_sendpid(PlayerId),
            %%?ASSERT(is_pid(SendPid), {SendPid, PlayerId}), % 下线后SendPid实际取到的是null，故此断言不适用，屏蔽掉！
            
            OldGridIdx = OldAoiPos#aoi_pos.scene_grid_index,

            NewX = NewPlayerPos#plyr_pos.x,
            NewY = NewPlayerPos#plyr_pos.y,
            

            NewGridIdx = lib_aoi:calc_grid_index(SceneId, NewX, NewY),

            update_grid_data_for_player_move(SceneId, OldGridIdx, NewGridIdx, PlayerId, SendPid),

            NewAoiPos = OldAoiPos#aoi_pos{
                                    x = NewX, 
                                    y = NewY, 
                                    scene_grid_index = NewGridIdx,
                                    scene_line = NewPlayerPos#plyr_pos.scene_line  % 重新赋值分线，是为了容错并矫正
                                    },
            lib_aoi:set_player_pos(PlayerId, NewAoiPos),
            
            lib_aoi:player_move_aoi_broadcast(PS, SceneId, NewX, NewY, OldGridIdx, NewGridIdx)
    end.





                        

update_grid_data_for_player_move(SceneId, OldGridIdx, NewGridIdx, PlayerId, SendPid) ->
    case NewGridIdx == OldGridIdx of
        true ->
            skip;
        false ->
            lib_aoi:del_player_from_grid(SceneId, OldGridIdx, PlayerId),
            lib_aoi:add_player_to_grid(SceneId, NewGridIdx, PlayerId, SendPid)
    end.










%% 处理npc移动
%% 起点为OldPos， 终点为NewPos
handle_npc_move(NpcObj, SceneId, OldPos, NewPos) ->
    NpcId = mod_npc:get_id(NpcObj),

    % ?DEBUG_MSG("[mod_go] handle_npc_move(), NpcId:~p, OldPos:~w, NewPos:~w", [NpcId, OldPos, NewPos]),

    case lib_aoi:get_npc_pos(NpcId) of
        null ->
            ?ASSERT(false, {NpcId, SceneId, OldPos, NewPos, NpcObj}),
            skip;

        OldAoiPos ->
            % todo：构思：什么情况下有可能断言失败？
            case (OldAoiPos#aoi_pos.x /= OldPos#coord.x)
            orelse (OldAoiPos#aoi_pos.y /= OldPos#coord.y) of
                true ->
                    ?ERROR_MSG("[mod_go] handle_npc_move() error!! OldAoiPos and OldPos not match!! NpcId:~p ~nOldAoiPos:~w ~nOldPos:~w ~nNewPos:~w ~nRealPos:~w",
                                            [NpcId, OldAoiPos, OldPos, NewPos, mod_npc:get_xy(NpcObj)]),
                    ?ASSERT(false);
                false ->
                    ok
            end,
            
            OldGridIdx = OldAoiPos#aoi_pos.scene_grid_index,

            NewX = NewPos#coord.x,
            NewY = NewPos#coord.y,
            NewGridIdx = lib_aoi:calc_grid_index(SceneId, NewX, NewY),

            update_grid_data_for_npc_move(SceneId, OldGridIdx, NewGridIdx, NpcId),

            NewAoiPos = OldAoiPos#aoi_pos{
                                    x = NewX, 
                                    y = NewY, 
                                    scene_grid_index = NewGridIdx
                                    },
            lib_aoi:set_npc_pos(NpcId, NewAoiPos),

            lib_aoi:npc_move_aoi_broadcast(NpcObj, SceneId, NewX, NewY, OldGridIdx, NewGridIdx)
    end.

                        
%% 
update_grid_data_for_npc_move(SceneId, OldGridIdx, NewGridIdx, NpcId) ->
    case NewGridIdx == OldGridIdx of
        true ->
            skip;
        false ->
            lib_aoi:del_npc_from_grid(SceneId, OldGridIdx, NpcId),
            lib_aoi:add_npc_to_grid(SceneId, NewGridIdx, NpcId)
    end.






enter_scene_on_login__(PS, PlayerPos) ->
    ?ASSERT(is_record(PlayerPos, plyr_pos), PlayerPos),

    _PlayerId = player:id(PS),
    ?TRACE("[mod_go] enter_scene_on_login__(), PlayerId:~p, PlayerPos:~w~n", [_PlayerId, PlayerPos]),

    ?ASSERT(lib_aoi:get_player_pos(_PlayerId) == null, _PlayerId),

    enter_new_scene__(PS, PlayerPos).



leave_scene_on_logout__(PS, PlayerPos) ->
    ?ASSERT(is_record(PlayerPos, plyr_pos), {PlayerPos, PS}),

    PlayerId = player:id(PS),
    ?TRACE("[mod_go] leave_scene_on_logout__(), PlayerId:~p, PlayerPos:~w~n", [PlayerId, PlayerPos]),

    case lib_aoi:get_player_pos(PlayerId) of
        null ->
            ?ERROR_MSG("[mod_go] leave_scene_on_logout__() error!! no aoi pos! PlayerId:~p, PlayerPos:~w", [PlayerId, PlayerPos]),
            skip;
        AoiPos ->
            % ?ASSERT(AoiPos#aoi_pos.scene_id == PlayerPos#plyr_pos.scene_id),
            % ?ASSERT(AoiPos#aoi_pos.x == PlayerPos#plyr_pos.x),
            % ?ASSERT(AoiPos#aoi_pos.y == PlayerPos#plyr_pos.y),
            % ?ASSERT(AoiPos#aoi_pos.scene_line == PlayerPos#plyr_pos.scene_line),

            % ?Ifc (AoiPos#aoi_pos.scene_id /= PlayerPos#plyr_pos.scene_id)
            %     % ?ERROR_MSG("OldAoiPos#aoi_pos.scene_id == _OldPlayerPos#plyr_pos.scene_id【~p,~p,~p,~p】",[PlayerId, OldAoiPos, _OldPlayerPos, _NewPlayerPos])
            %     ?ERROR_MSG("OldAoiPos#aoi_pos.scene_id == _OldPlayerPos#plyr_pos.scene_id【~p】",[PlayerId])
            % ?End,

            % ?Ifc (AoiPos#aoi_pos.x /= PlayerPos#plyr_pos.x)
            %     % ?ERROR_MSG("OldAoiPos#aoi_pos.x == _OldPlayerPos#plyr_pos.x【~p,~p,~p,~p】",[PlayerId, OldAoiPos, _OldPlayerPos, _NewPlayerPos])
            %     ?ERROR_MSG("OldAoiPos#aoi_pos.x == _OldPlayerPos#plyr_pos.x ~p】",[PlayerId])
            % ?End,

            % ?Ifc (AoiPos#aoi_pos.y /= PlayerPos#plyr_pos.y)
            %     % ?ERROR_MSG("OldAoiPos#aoi_pos.y == _OldPlayerPos#plyr_pos.y【~p,~p,~p,~p】",[PlayerId, OldAoiPos, _OldPlayerPos, _NewPlayerPos])
            %     ?ERROR_MSG("OldAoiPos#aoi_pos.y == _OldPlayerPos#plyr_pos.y【~p】",[PlayerId])
            % ?End,

            % ?Ifc (AoiPos#aoi_pos.scene_line /= PlayerPos#plyr_pos.scene_line)
            %     % ?ERROR_MSG("OldAoiPos#aoi_pos.scene_line == _OldPlayerPos#plyr_pos.scene_line【~p,~p,~p,~p】",[PlayerId, OldAoiPos, _OldPlayerPos, _NewPlayerPos])
            %     ?ERROR_MSG("OldAoiPos#aoi_pos.scene_line == _OldPlayerPos#plyr_pos.scene_line~p】",[PlayerId])
            % ?End,

            leave_old_scene__(PS, AoiPos)
    end.

            




del_player_aoi_data(PlayerId, AoiPos) ->
    SceneGridKey = lib_scene:to_scene_grid_key(AoiPos),
    lib_aoi:del_player_from_grid(SceneGridKey, PlayerId),
    lib_aoi:del_player_pos(PlayerId).


%% 玩家进入新场景
enter_new_scene__(PS, NewPlayerPos) ->
    ?ASSERT(is_record(NewPlayerPos, plyr_pos), {NewPlayerPos, PS}),

    PlayerId = player:id(PS), 

    % 做容错：清除残余数据
    case lib_aoi:get_player_pos(PlayerId) of
        null ->
            ok;
        AoiPos_ ->
            ?DEBUG_MSG("[mod_go] enter_new_scene__() error! residual player data!! PlayerId:~p, AoiPos_:~w, NewPlayerPos:~w", [PlayerId, AoiPos_, NewPlayerPos]),
            del_player_aoi_data(PlayerId, AoiPos_)
    end,
    

    %%?ASSERT(lib_aoi:get_player_pos(PlayerId) == null, {PlayerId, NewPlayerPos}),


    NewSceneId = NewPlayerPos#plyr_pos.scene_id,
    NewX = NewPlayerPos#plyr_pos.x,
    NewY = NewPlayerPos#plyr_pos.y,
    % {SceneWid, SceneHei} = lib_aoi:get_scene_width_height(NewSceneId),

    NewGridIdx = lib_aoi:calc_grid_index(NewSceneId, NewX, NewY),


    NewAoiPos = #aoi_pos{
                    scene_id = NewSceneId,
                    x = NewX,
                    y = NewY,
                    scene_line = NewPlayerPos#plyr_pos.scene_line,
                    scene_grid_index = NewGridIdx
                    },

    %%NewAoiPos = lib_aoi:to_aoi_pos(NewPlayerPos),  %%player:remake_position_rd(PlayerId, NewSceneId, NewX, NewY), %%%OldPos#plyr_pos{scene_id = NewSceneId, x = NewX, y = NewY, scene_grid_index = NewSceneGridIdx},
    lib_aoi:set_player_pos(PlayerId, NewAoiPos),  % 注意：须先更新位置信息，然后再做进入他人AOI的通知，否则打包通知进入AOI的协议包时，位置信息是旧的！
            
    SceneGridKey = lib_scene:to_scene_grid_key(NewSceneId, NewGridIdx), %%%NewAoiPos),
    % 进入新场景格子
    enter_new_scene_grid(player, PS, SceneGridKey),

    % PlayerId = player:get_id(PS),
    % NewSceneId = NewPos#plyr_pos.scene_id,
    % NewLine = NewPos#plyr_pos.scene_line,

    %%%NewLine = decide_my_scene_line(NewSceneId),
    %%%?DEBUG_MSG("...(),  PlayerId: ~p, NewLine:~p~n", [PlayerId, NewLine]),
    %%%player:set_scene_line(PlayerId, NewLine),

    % 通知给AOI: 我进入了场景
    notify_my_enter_scene_to_AOI(PS, NewAoiPos).

    




%% 玩家离开旧场景
%% 特别注意：旧场景有可能已经被清除了（比如：副本超时时，会把玩家强行传送到副本外，然后清除副本，而这两个操作实际上是并发的）！
leave_old_scene__(PS, OldAoiPos) ->
    SceneGridKey = lib_scene:to_scene_grid_key(OldAoiPos),
    PlayerId = player:get_id(PS),
    % 离开旧场景格子
    leave_old_scene_grid(player, PlayerId, SceneGridKey),

    %%?DEBUG_MSG("leave_old_scene__(),  PlayerId: ~p, Line:~p~n", [PlayerId, player:get_scene_line(PlayerId)]),

    % 通知给AOI: 我离开了场景
    notify_my_leave_scene_to_AOI(PS, OldAoiPos),

    % 删除位置记录
    lib_aoi:del_player_pos(PlayerId).





%% 通知场景AOI范围内的玩家：我进入了场景
notify_my_enter_scene_to_AOI(PS, NewPos) ->
    ?ASSERT(is_record(NewPos, aoi_pos)),
    PlayerId = player:get_id(PS),
    NewSceneLine = NewPos#aoi_pos.scene_line,  %%NewPos#plyr_pos.scene_line,
    ?TRACE("notify_my_enter_scene_to_AOI(), PlayerId=~p~n", [PlayerId]),
    % 断言
    ?ASSERT(lists:member(PlayerId, lib_aoi:get_AOI_player_ids_by_scene_line(NewPos, NewSceneLine)),  {PlayerId, NewPos}),
    {ok, Bin_EnterNotice} = pt_12:write(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, PS),
    send_to_AOI_by_scene_line_or_team_except_me__(PlayerId, NewPos, NewSceneLine, Bin_EnterNotice).
            
            


%% 通知场景AOI范围内的玩家：我离开了场景
notify_my_leave_scene_to_AOI(PS, OldPos) ->
    ?ASSERT(is_record(OldPos, aoi_pos)),
    PlayerId = player:get_id(PS),
    SceneLine = OldPos#aoi_pos.scene_line,  %%player:get_scene_line(PlayerId),
    {ok, Bin_LeaveNotice} = pt_12:write(?PT_NOTIFY_PLAYERS_LEAVE_MY_AOI, [PlayerId]),
    send_to_AOI_by_scene_line_or_team_except_me__(PlayerId, OldPos, SceneLine, Bin_LeaveNotice).
            




%%
player_leave_old_scene_for_teleport__(PS, _OldPlayerPos, _NewPlayerPos) ->
    %%?ASSERT(is_integer(NewSceneId) andalso is_integer(NewX) andalso is_integer(NewY)),
    
    PlayerId = player:id(PS),

    % ?DEBUG_MSG("player_leave_old_scene_for_teleport__(), PlayerId:~p, OldSceneId:~p, NewSceneId:~p", [PlayerId, OldPlayerPos#plyr_pos.scene_id, NewPlayerPos#plyr_pos.scene_id]),

    % ?TRACE("[mod_go] player_leave_old_scene_for_teleport__(), PlayerId=~p, IsLeader=~p, NewSceneId=~p, NewX=~p, NewY=~p~n", 
    %                     [PlayerId, player:is_leader(PS), NewPlayerPos#plyr_pos.scene_id, NewPlayerPos#plyr_pos.x, NewPlayerPos#plyr_pos.y]),


    case lib_aoi:get_player_pos(PlayerId) of
        null ->
            skip;
        OldAoiPos ->
            %%% ?ASSERT(OldAoiPos /= null, {PlayerId, OldPlayerPos, NewPlayerPos}),
            % ?Ifc (OldAoiPos#aoi_pos.scene_id /= _OldPlayerPos#plyr_pos.scene_id)
            %     % ?ERROR_MSG("OldAoiPos#aoi_pos.scene_id == _OldPlayerPos#plyr_pos.scene_id【~p,~p,~p,~p】",[PlayerId, OldAoiPos, _OldPlayerPos, _NewPlayerPos])
            %     ?ERROR_MSG("OldAoiPos#aoi_pos.scene_id == _OldPlayerPos#plyr_pos.scene_id【~p】",[PlayerId])
            % ?End,

            % ?Ifc (OldAoiPos#aoi_pos.x /= _OldPlayerPos#plyr_pos.x)
            %     % ?ERROR_MSG("OldAoiPos#aoi_pos.x == _OldPlayerPos#plyr_pos.x【~p,~p,~p,~p】",[PlayerId, OldAoiPos, _OldPlayerPos, _NewPlayerPos])
            %     ?ERROR_MSG("OldAoiPos#aoi_pos.x == _OldPlayerPos#plyr_pos.x ~p】",[PlayerId])
            % ?End,

            % ?Ifc (OldAoiPos#aoi_pos.y /= _OldPlayerPos#plyr_pos.y)
            %     % ?ERROR_MSG("OldAoiPos#aoi_pos.y == _OldPlayerPos#plyr_pos.y【~p,~p,~p,~p】",[PlayerId, OldAoiPos, _OldPlayerPos, _NewPlayerPos])
            %     ?ERROR_MSG("OldAoiPos#aoi_pos.y == _OldPlayerPos#plyr_pos.y【~p】",[PlayerId])
            % ?End,

            % ?Ifc (OldAoiPos#aoi_pos.scene_line /= _OldPlayerPos#plyr_pos.scene_line)
            %     % ?ERROR_MSG("OldAoiPos#aoi_pos.scene_line == _OldPlayerPos#plyr_pos.scene_line【~p,~p,~p,~p】",[PlayerId, OldAoiPos, _OldPlayerPos, _NewPlayerPos])
            %     ?ERROR_MSG("OldAoiPos#aoi_pos.scene_line == _OldPlayerPos#plyr_pos.scene_line~p】",[PlayerId])
            % ?End,

            % ?ASSERT(OldAoiPos#aoi_pos.scene_id == _OldPlayerPos#plyr_pos.scene_id, {PlayerId, OldAoiPos, _OldPlayerPos, _NewPlayerPos}),
            % ?ASSERT(OldAoiPos#aoi_pos.x == _OldPlayerPos#plyr_pos.x, {PlayerId, OldAoiPos, _OldPlayerPos, _NewPlayerPos}),
            % ?ASSERT(OldAoiPos#aoi_pos.y == _OldPlayerPos#plyr_pos.y, {PlayerId, OldAoiPos, _OldPlayerPos, _NewPlayerPos}),
            % ?ASSERT(OldAoiPos#aoi_pos.scene_line == _OldPlayerPos#plyr_pos.scene_line, {PlayerId, OldAoiPos, _OldPlayerPos, _NewPlayerPos}),

            leave_old_scene__(PS, OldAoiPos)
    end.



player_enter_new_scene_for_teleport__(PS, NewPlayerPos) ->
    enter_new_scene__(PS, NewPlayerPos).
            









mon_enter_scene__(MonId, SceneId, X, Y) ->
    ?DEBUG_MSG("[mod_go] mon_enter_scene__(), MonId:~p, SceneId:~p, X:~p, Y:~p", [MonId, SceneId, X, Y]),
    ?ASSERT(lib_aoi:get_mon_pos(MonId) == null, {MonId, SceneId, X, Y}),

    GridIdx = lib_aoi:calc_grid_index(SceneId, X, Y),

    InitAoiPos = #aoi_pos{
                    scene_id = SceneId,
                    x = X,
                    y = Y,
                    scene_grid_index = GridIdx
                    },    
    lib_aoi:set_mon_pos(MonId, InitAoiPos),  % 初始化位置记录

    SceneGridKey = lib_scene:to_scene_grid_key(SceneId, GridIdx),
    enter_new_scene_grid(mon, MonId, SceneGridKey).
    


mon_leave_scene__(MonObj) ->
    MonId = mod_mon:get_id(MonObj),
    ?DEBUG_MSG("[mod_go] mon_leave_scene__(), MonId:~p", [MonId]),
    leave_old_scene_grid(mon, MonObj),
    lib_aoi:del_mon_pos(MonId).  % 删除位置记录



npc_enter_scene__(NpcId, SceneId, X, Y) ->
    ?DEBUG_MSG("[mod_go] npc_enter_scene__(), NpcId:~p, SceneId:~p, X:~p, Y:~p", [NpcId, SceneId, X, Y]),
    ?ASSERT(lib_aoi:get_npc_pos(NpcId) == null, {NpcId, SceneId, X, Y}),

    GridIdx = lib_aoi:calc_grid_index(SceneId, X, Y),

    InitAoiPos = #aoi_pos{
                    scene_id = SceneId,
                    x = X,
                    y = Y,
                    scene_grid_index = GridIdx
                    },    
    lib_aoi:set_npc_pos(NpcId, InitAoiPos),  % 初始化位置记录

    SceneGridKey = lib_scene:to_scene_grid_key(SceneId, GridIdx),
    enter_new_scene_grid(npc, NpcId, SceneGridKey).



npc_leave_scene__(NpcObj) ->
    NpcId = mod_npc:get_id(NpcObj),
    ?DEBUG_MSG("[mod_go] npc_leave_scene__(), NpcId:~p", [NpcId]),
    leave_old_scene_grid(npc, NpcObj),
    lib_aoi:del_npc_pos(NpcId).  % 删除位置记录




%% 玩家进入新场景格子
enter_new_scene_grid(player, PS, NewSceneGridKey) ->
    ?ASSERT(is_record(PS, player_status), PS),
    PlayerId = player:get_id(PS),
    SendPid = player:get_sendpid(PS),
    lib_aoi:add_player_to_grid(NewSceneGridKey, PlayerId, SendPid);

%% 怪物进入新场景格子
enter_new_scene_grid(mon, MonId, NewSceneGridKey) ->
    lib_aoi:add_mon_to_grid(NewSceneGridKey, MonId);

%% 可移动npc进入新场景格子
enter_new_scene_grid(npc, NpcId, NewSceneGridKey) ->
    lib_aoi:add_npc_to_grid(NewSceneGridKey, NpcId).



% %% 怪物进入新场景格子
% enter_new_scene_grid(mon, MonId, SceneId, X, Y) ->
%     GridIdx = lib_aoi:calc_grid_index(SceneId, X, Y),
%     SceneGridKey = lib_scene:to_scene_grid_key(SceneId, GridIdx),
%     enter_new_scene_grid(mon, MonId, SceneGridKey);

% %% 可移动npc进入新场景格子
% enter_new_scene_grid(npc, NpcId, SceneId, X, Y) ->
%     GridIdx = lib_aoi:calc_grid_index(SceneId, X, Y),
%     SceneGridKey = lib_scene:to_scene_grid_key(SceneId, GridIdx),
%     enter_new_scene_grid(npc, NpcId, SceneGridKey).





%% 玩家离开原场景格子
leave_old_scene_grid(player, PlayerId, OldSceneGridKey) ->
    lib_aoi:del_player_from_grid(OldSceneGridKey, PlayerId);

%% 怪物离开原场景格子
leave_old_scene_grid(mon, MonId, OldSceneGridKey) ->
    lib_aoi:del_mon_from_grid(OldSceneGridKey, MonId);

%% 可移动npc离开原场景格子
leave_old_scene_grid(npc, NpcId, OldSceneGridKey) ->
    lib_aoi:del_npc_from_grid(OldSceneGridKey, NpcId).



%% 怪物离开原场景格子
leave_old_scene_grid(mon, MonObj) ->
    MonId = mod_mon:get_id(MonObj),
    case lib_aoi:get_mon_pos(MonId) of
        null ->
            ?ASSERT(false, MonObj),
            skip;
        AoiPos ->
            SceneGridKey = lib_scene:to_scene_grid_key(AoiPos),
            leave_old_scene_grid(mon, MonId, SceneGridKey)
    end;

            

%% 可移动npc离开原场景格子
leave_old_scene_grid(npc, NpcObj) ->
    NpcId = mod_npc:get_id(NpcObj),
    case lib_aoi:get_npc_pos(NpcId) of
        null ->
            ?ASSERT(false, NpcObj),
            skip;
        AoiPos ->
            SceneGridKey = lib_scene:to_scene_grid_key(AoiPos),
            leave_old_scene_grid(npc, NpcId, SceneGridKey)
    end.

            



%% 发送给玩家对应的aoi范围
send_to_AOI__(_SceneId, PlayerId, Bin) ->
    % ?ASSERT(is_record(PlayerPos, plyr_pos), PlayerPos),
    case lib_aoi:get_player_pos(PlayerId) of %%%lib_aoi:to_aoi_pos(PlayerPos),
        null ->
            skip;
        AoiPos ->
            PlayerIdList = lib_aoi:get_AOI_player_ids(AoiPos),
            % ?ASSERT( length(gb_sets:to_list(gb_sets:from_list(PlayerIdList))) == length(PlayerIdList), {PlayerIdList, PlayerPos}),
            send_to_players(PlayerIdList, Bin)
    end.


%% 发送给指定位置对应的aoi范围
send_to_AOI__({SceneId, X, Y}, Bin) ->
    PlayerIdList = lib_aoi:get_AOI_player_ids(SceneId, X, Y),
    % ?DEBUG_MSG("[mod_go] send_to_AOI__(), SceneId:~p, X:~p, Y:~p, PlayerIdList:~p, Bin:~w~n", [SceneId, X, Y, PlayerIdList, Bin]),
    send_to_players(PlayerIdList, Bin).




send_to_AOI_except_me__(_SceneId, MyId, Bin) ->
    case lib_aoi:get_player_pos(MyId) of  %%%lib_aoi:to_aoi_pos(PlayerPos),
        null ->
            skip;
        AoiPos ->
            PlayerIdList = lib_aoi:get_AOI_player_ids_except_me(MyId, AoiPos),
            % ?ASSERT( length(gb_sets:to_list(gb_sets:from_list(PlayerIdList))) == length(PlayerIdList), {PlayerIdList, MyId, AoiPos}),
            send_to_players(PlayerIdList, Bin)
    end.

            


send_to_AOI_by_scene_line_or_team_except_me__(MyId, SceneLine, Bin) ->
    case lib_aoi:get_player_pos(MyId) of
        null ->
            skip;
        AoiPos ->
            send_to_AOI_by_scene_line_or_team_except_me__(MyId, AoiPos, SceneLine, Bin)
    end.


send_to_AOI_by_scene_line_or_team_except_me__(MyId, AoiPos, SceneLine, Bin) ->
    PlayerIdList = lib_aoi:get_AOI_player_ids_by_scene_line_or_team_except_me(MyId, AoiPos, SceneLine),
    % ?ASSERT( length(gb_sets:to_list(gb_sets:from_list(PlayerIdList))) == length(PlayerIdList), {PlayerIdList, MyId, AoiPos}),
    send_to_players(PlayerIdList, Bin).
    
            


% send_to_AOI_by_scene_line_or_team_except_me_TOL__(MyId, Pos, SceneLine, Bin) ->
%     PlayerIdList = lib_aoi:get_AOI_player_ids_by_scene_line_or_team_except_me_TOL(MyId, Pos, SceneLine),
%     ?ASSERT( length(gb_sets:to_list(gb_sets:from_list(PlayerIdList))) == length(PlayerIdList), {PlayerIdList, MyId, Pos}),
%     send_to_players(PlayerIdList, Bin).

          

send_to_players(PlayerIdList, Bin) ->
    ?ASSERT(is_list(PlayerIdList), PlayerIdList),
    ?ASSERT(is_binary(Bin), Bin),
    % 调试代码：
    % <<Cmd:16, _Comp:8, Body/binary>> = Bin,
    % if 
    %     Cmd == 12002 orelse Cmd == 12003 ->
    %         ?DEBUG_MSG("send_to_AOI__(), PlayerIdList: ~w, Cmd:~p, Body:~w~n", [PlayerIdList, Cmd, Body]);
    %     true ->
    %         skip
    % end,

    % ?TRACE("send_to_AOI__(), PlayerIdList: ~p, Bin:~w~n", [PlayerIdList, Bin]),

    % ?ASSERT( length(gb_sets:to_list(gb_sets:from_list(PlayerIdList))) == length(PlayerIdList), PlayerIdList), 
    F = fun(Id) -> lib_send:send_to_uid(Id, Bin) end,
    lists:foreach(F, PlayerIdList).




%% 通知AOI：场景刷出了明雷怪
notify_mon_spawned_to_AOI__(MonId) ->
    ?TRACE("[mod_go] notify_mon_spawned_to_AOI__(), MonId=~p~n", [MonId]),
    case lib_aoi:get_mon_pos(MonId) of
        null ->
            ?ASSERT(false, MonId),
            skip;
        AoiPos ->
            SceneId = AoiPos#aoi_pos.scene_id,
            X = AoiPos#aoi_pos.x,
            Y = AoiPos#aoi_pos.y,

            {ok, Bin} = pt_12:write(?PT_NOTIFY_OBJ_SPAWNED, {mon, MonId}),
            send_to_AOI__({SceneId, X, Y}, Bin)
    end.


            




%% 通知AOI： 场景中的明雷怪被清除了
notify_mon_cleared_to_AOI__(MonObj) ->
    MonId = mod_mon:get_id(MonObj),
    ?TRACE("[mod_go] notify_mon_cleared_to_AOI__(), MonId=~p~n", [MonId]),

    case lib_aoi:get_mon_pos(MonId) of
        null ->
            ?ASSERT(false, MonObj),
            skip;
        AoiPos ->
            SceneId = AoiPos#aoi_pos.scene_id,
            ?ASSERT(SceneId == mod_mon:get_scene_id(MonObj)),  % 假定怪物不会跳转场景！
            X = AoiPos#aoi_pos.x,
            Y = AoiPos#aoi_pos.y,

            % SceneId = mod_mon:get_scene_id(MonObj),
            % {X, Y} = mod_mon:get_xy(MonObj),

            % ?DEBUG_MSG("[mod_go] notify_mon_cleared_to_AOI__(), MonId:~p, SceneId:~p, XY:~p, AoiPos:~w", 
            %                 [MonId, mod_mon:get_scene_id(MonObj), mod_mon:get_xy(MonObj), AoiPos]),

            {ok, Bin} = pt_12:write(?PT_NOTIFY_OBJ_CLEARED, {mon, MonId}),
            send_to_AOI__({SceneId, X, Y}, Bin)
    end.


            



notify_npc_spawned_to_AOI__(NpcId) when is_integer(NpcId) ->
    case lib_aoi:get_npc_pos(NpcId) of
        null ->
            ?ASSERT(false, NpcId),
            skip;
        AoiPos ->
            SceneId = AoiPos#aoi_pos.scene_id,
            X = AoiPos#aoi_pos.x,
            Y = AoiPos#aoi_pos.y,

            {ok, Bin} = pt_12:write(?PT_NOTIFY_OBJ_SPAWNED, {npc, NpcId}),
            % ?DEBUG_MSG("[mod_go] notify_npc_spawned_to_AOI__(), NpcId=~p, AoiPos:~w, Bin:~w~n", [NpcId, AoiPos, Bin]),
            send_to_AOI__({SceneId, X, Y}, Bin)
    end;


            

notify_npc_spawned_to_AOI__(NpcObj) when is_record(NpcObj, npc) ->
    NpcId = mod_npc:get_id(NpcObj),
    case lib_aoi:get_npc_pos(NpcId) of
        null ->
            ?ASSERT(false, NpcId),
            skip;
        AoiPos ->
            SceneId = AoiPos#aoi_pos.scene_id,
            X = AoiPos#aoi_pos.x,
            Y = AoiPos#aoi_pos.y,

            {ok, Bin} = pt_12:write(?PT_NOTIFY_OBJ_SPAWNED, {npc, NpcObj}),
            % ?DEBUG_MSG("[mod_go] notify_npc_spawned_to_AOI__(), NpcId=~p, AoiPos:~w, NpcSceneId:~p, NpcXY:~p, Bin:~w~n", 
            %                             [NpcId, AoiPos, mod_npc:get_scene_id(NpcObj), mod_npc:get_xy(NpcObj), Bin]),
            send_to_AOI__({SceneId, X, Y}, Bin)
    end.


            





notify_npc_cleared_to_AOI__(NpcObj) ->
    NpcId = mod_npc:get_id(NpcObj),
    ?TRACE("[mod_go] notify_npc_cleared_to_AOI__(), NpcId=~p~n", [NpcId]),

    case lib_aoi:get_npc_pos(NpcId) of
        null ->
            ?ASSERT(false, NpcObj),
            skip;
        AoiPos ->
            SceneId = AoiPos#aoi_pos.scene_id,
            ?ASSERT(SceneId == mod_npc:get_scene_id(NpcObj)), % 假定NPC不会跳转场景！
            X = AoiPos#aoi_pos.x,
            Y = AoiPos#aoi_pos.y,

            % SceneId = mod_npc:get_scene_id(NpcObj),
            % {X, Y} = mod_npc:get_xy(NpcObj),

            % ?DEBUG_MSG("[mod_go] notify_npc_cleared_to_AOI__(), NpcId:~p, SceneId:~p, XY:~p, AoiPos:~w", 
            %                 [NpcId, mod_npc:get_scene_id(NpcObj), mod_npc:get_xy(NpcObj), AoiPos]),

            {ok, Bin} = pt_12:write(?PT_NOTIFY_OBJ_CLEARED, {npc, NpcId}),
            send_to_AOI__({SceneId, X, Y}, Bin)
    end.
    





notify_AOI_info_to_player__(PS, _PlayerPos) ->
    ?TRACE("notify_AOI_info_to_player__(), PlayerPos:~p~n", [_PlayerPos]),

    PlayerId = player:id(PS),

    case lib_aoi:get_player_pos(PlayerId) of
        null ->
            % ?ERROR_MSG("[mod_go] notify_AOI_info_to_player__() error,  aoi pos null!! PlayerId:~p, PlayerPos:~w", [PlayerId, PlayerPos]),
            %%?ASSERT(false, {PlayerId, PlayerPos}),
            skip;
        AoiPos ->

            % AoiPos = lib_aoi:to_aoi_pos(PlayerPos),

            
            SceneLine = lib_aoi:get_player_scene_line(PlayerId),  %%PlayerPos#plyr_pos.scene_line,  %%player:get_scene_line(PlayerId),
            ?ASSERT(SceneLine /= ?INVALID_SCENE_LINE),
            
            {PlayerIdList, MonIdList, NpcIdList} = lib_aoi:get_AOI_all_obj_ids_by_scene_line_or_team_except_me(PlayerId, AoiPos, SceneLine),
            % ?TRACE("notify_AOI_info_to_player__(), PlayerId:~p, AoiPos:~p, {PlayerIdList, MonIdList, NpcIdList}:~p~n", [PlayerId, AoiPos, {PlayerIdList, MonIdList, NpcIdList}]),

            % ?ASSERT( length(gb_sets:to_list(gb_sets:from_list(PlayerIdList))) == length(PlayerIdList), {PlayerIdList, PlayerId, AoiPos}), 

            % 通知AOI内的玩家信息
            ?Ifc (PlayerIdList /= [])
                {ok, Bin_EnterNotice} = pt_12:write(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, PlayerIdList),
                lib_send:send_to_sid(PS, Bin_EnterNotice)
            ?End,

            % 通知AOI内的怪物信息
            ?Ifc (MonIdList /= [])
                {ok, Bin_EnterNotice2} = pt_12:write(?PT_NOTIFY_OBJS_ENTER_MY_AOI, {mon, MonIdList}),
                lib_send:send_to_sid(PS, Bin_EnterNotice2)
            ?End,

            % 通知AOI内的可移动NPC信息
            ?Ifc (NpcIdList /= [])
                {ok, Bin_EnterNotice3} = pt_12:write(?PT_NOTIFY_OBJS_ENTER_MY_AOI, {npc, NpcIdList}),
                % ?DEBUG_MSG("notify_AOI_info_to_player__(), PlayerId:~p, NpcIdList:~p, Bin_EnterNotice3:~w", [PlayerId, NpcIdList, Bin_EnterNotice3]),
                lib_send:send_to_sid(PS, Bin_EnterNotice3)
            ?End

    end.


            

notify_player_enter_team_aoi__(Team, PlayerId) ->
    ?TRACE("~n~n~n!!!!!!!!!!!!!!!!!!!!!!!!!!!notify_player_enter_team_aoi__(),  PlayerId:~p, AoiPos:~w, Team:~w~n", [PlayerId, lib_aoi:get_player_pos(PlayerId), Team]),
    {ok, Bin_EnterNotice} = pt_12:write(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, [PlayerId]),
    lib_send:send_to_team(Team, Bin_EnterNotice).




% on_scene_created__(NewSceneObj) ->
%     SceneId = lib_scene:get_id(NewSceneObj),
%     SceneInfo = #aoi_scene{
%                     scene_id = SceneId,
%                     width = lib_scene:get_width(NewSceneObj),
%                     height = lib_scene:get_height(NewSceneObj)
%                     },
%     lib_aoi:init_scene_info(SceneId, SceneInfo).
    




% clear_scene_grids_data__(SceneObj) ->
%     SceneId = lib_scene:get_id(SceneObj),
%     Width = lib_scene:get_width(SceneObj),
%     Height = lib_scene:get_height(SceneObj),
%     GridIndex_X_Max = lib_scene:calc_max_grid_index_X(Width),
%     GridIndex_Y_Max = lib_scene:calc_max_grid_index_Y(Height),
%     ?TRACE("clear_scene_grids_data__(), GridIndex_X_Max:~p, GridIndex_Y_Max:~p, SceneId:~p, SceneNo:~p~n", 
%                             [GridIndex_X_Max, GridIndex_Y_Max, SceneId, lib_scene:get_no(SceneObj)]),
%     clear_scene_grids_data__(SceneId, GridIndex_X_Max, GridIndex_Y_Max, ?GRID_SEQ_START, ?GRID_SEQ_START).


% clear_scene_grids_data__(_SceneId, GridIndex_X_Max, _GridIndex_Y_Max, CurX, _CurY) when CurX > GridIndex_X_Max ->
%     done;
% clear_scene_grids_data__(SceneId, GridIndex_X_Max, GridIndex_Y_Max, CurX, CurY) when CurY > GridIndex_Y_Max ->
%     clear_scene_grids_data__(SceneId, GridIndex_X_Max, GridIndex_Y_Max, CurX + 1, ?GRID_SEQ_START);
% clear_scene_grids_data__(SceneId, GridIndex_X_Max, GridIndex_Y_Max, CurX, CurY) ->
%     Key = lib_scene:to_scene_grid_key(SceneId, {CurX, CurY}),
%     _OldVal = lib_aoi:del_scene_grid_data(Key),
%     ?TRACE("clear_scene_grids_data__(), Key:~p, _OldVal:~w~n", [Key, _OldVal]),
%     clear_scene_grids_data__(SceneId, GridIndex_X_Max, GridIndex_Y_Max, CurX, CurY + 1).















