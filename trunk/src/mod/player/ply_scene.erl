%%%--------------------------------------
%%% @Module  : ply_scene
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.8.5
%%% @Description: 玩家的与场景相关的业务逻辑（如：进入场景，离开场景等）
%%%--------------------------------------
-module(ply_scene).
-export([
        get_born_place/1,
        get_born_scene_type/1,
        get_adjusted_pos/2,
        enter_scene_on_login/1,
        leave_scene_on_logout/1,
        switch_between_normal_scenes/2,
        get_teleport_cfg_data/1,

        try_teleport/2,
        do_teleport/2, do_teleport/4,
        do_single_teleport/4,

        teleport_after_die/1,
        goto_hell/1,
        goto_born_place/1,

        is_in_leitai_area/1,

        try_trigger_trap/3,

        reset_step_counter/1,

        notify_bhv_state_changed_to_aoi/2,

        query_task_mon_pos/2,
        query_task_mon_pos/3,
        check_teleport/2,
		goto_host_city/1,

        decide_my_scene_line/1
		
    ]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("pt_12.hrl").
-include("scene.hrl").
-include("monster.hrl").
-include("prompt_msg_code.hrl").
-include("abbreviate.hrl").
-include("buff.hrl").
-include("scene_line.hrl").
-include("guild_battle.hrl").
-include("obj_info_code.hrl").
-include("faction.hrl").

%% 角色的出生点
get_born_place(PS) when is_record(PS, player_status) ->
	Faction = player:get_faction(PS),
	get_born_place(Faction);
%%     Race = player:get_race(PS),
%%     get_born_place(Race);

get_born_place(Faction) ->
	#faction_base{scene_no = SceneNo} = data_faction:get(Faction),
	{SceneNo, ?BORN_POS_X, ?BORN_POS_Y}.
		

%% get_born_place(_Race) ->
    % case Race of
    %     ?RACE_REN ->
    %         {?BORN_SCENE_NO, ?BORN_POS_X, ?BORN_POS_Y};
    %     ?RACE_MO ->
    %         {?BORN_SCENE_NO, ?BORN_POS_X, ?BORN_POS_Y};
    %     ?RACE_XIAN ->
    %         {?BORN_SCENE_NO, ?BORN_POS_X, ?BORN_POS_Y};
    %     ?RACE_YAO ->
    %         {?BORN_SCENE_NO, ?BORN_POS_X, ?BORN_POS_Y}
    % end.
%%     {?BORN_SCENE_NO, ?BORN_POS_X, ?BORN_POS_Y}.


%% 出生场景的类型
get_born_scene_type(Race) ->
    {BornSceneNo, _X, _Y} = get_born_place(Race),
    mod_scene_tpl:get_scene_type(BornSceneNo).
    

%% 获取（当玩家处于非法位置时，）矫正后的正常位置
%% @return: {SceneNo, X, Y}
get_adjusted_pos(Race, Lv) ->
    if 
        Lv >= 11 ->
            ?REBORN_POS_OF_MAIN_CITY;
        Lv >= 5 ->
            ?REBORN_POS_OF_TAOYUANZHEN;
        true ->
            get_born_place(Race)
    end.


%% 进入场景，专用于玩家上线刚进入游戏时的情况
enter_scene_on_login(PS) ->
    PlayerId = player:id(PS),
    Pos = player:get_position(PS),
    ?ASSERT(Pos /= null, PS),

%%     {ok, Value} = lib_player_ext:try_load_data(PlayerId,tuhaobang),
%%     case Value of
%%         0 ->
%%             skip;
%%         _ ->
%%             mod_rank:role_RMB(PS, Value)
%%     end,

    % 玩家的位置
    RealNewSceneId = pre_enter_scene(PS, Pos#plyr_pos.scene_id),

    RealPos = case RealNewSceneId == Pos#plyr_pos.scene_id of
                    true ->
                        Pos;
                    false ->
                        % 重新初始化位置
                        player:init_position(PlayerId, {RealNewSceneId, Pos#plyr_pos.x, Pos#plyr_pos.y})
                end,

    % ?TRACE("ply_scene, enter_scene_on_login(), PlayerId:~p, SceneId:~p, RealNewSceneId:~p, RealPos:~w~n", [PlayerId, Pos#plyr_pos.scene_id, RealNewSceneId, RealPos]),

    % 通知go进程
    mod_go:enter_scene_on_login(PS, RealPos),
    
    % 添加到场景对象所记录的玩家列表
    SceneLine = RealPos#plyr_pos.scene_line,
    mod_scene_mgr:add_to_scene_player_list(RealNewSceneId, PlayerId, SceneLine).






%% 离开场景，专用于玩家下线退出游戏时的情况
leave_scene_on_logout(PS) ->
    Pos = player:get_position(PS),
    ?ASSERT(Pos /= null, PS),

    % 通知go进程
    mod_go:leave_scene_on_logout(PS, Pos),
    % 从场景对象所记录的玩家列表删除玩家
    SceneId = Pos#plyr_pos.scene_id,
    PlayerId = player:get_id(PS),
    mod_scene_mgr:del_from_scene_player_list(SceneId, PlayerId).




get_teleport_cfg_data(TeleportNo) ->
    data_teleport:get(TeleportNo).


%% 尝试传送
%% @return: ok | {fail, Reason}
try_teleport(PS, TeleportNo) ->
    case check_teleport(PS, TeleportNo) of
        ok ->
            do_teleport(PS, TeleportNo),
            ok;
        {fail, Reason} ->
            {fail, Reason}
    end.



%% 检查是否可以传送
%% @return: ok | {fail, Reason}
check_teleport(PS, TeleportNo) ->
    try
        check_teleport__(PS, TeleportNo)
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.


%% 普通场景之间跳转（从一个普通场景进入另一个普通场景）
%% @return: ok | {fail, Reason}
switch_between_normal_scenes(PS, NewSceneId) ->
    % 断言新、旧场景都是普通场景
    ?ASSERT(begin 
                _OldPos = player:get_position(player:id(PS)),
                lib_scene:is_normal_scene(_OldPos#plyr_pos.scene_id)
            end),
    ?ASSERT(lib_scene:is_normal_scene(NewSceneId)),
    
    % 检查是否可以进入场景
    case check_enter_normal_scene(PS, NewSceneId) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            {NewX, NewY} = lib_scene:get_default_xy(NewSceneId),
            do_teleport(PS, NewSceneId, NewX, NewY),
            ok
    end.
 



%% 执行传送
%% !!!!!!! 注意：只能在玩家进程中调用 !!!!!!!
%% @para: TeleportNo => 传送编号
do_teleport(PS, TeleportNo) ->
    TelepCfg = get_teleport_cfg_data(TeleportNo),

    NewSceneId1 = TelepCfg#teleport.target_scene_no,
    {NewX1, NewY1} = TelepCfg#teleport.target_xy,
    do_teleport(PS, NewSceneId1, NewX1, NewY1).

    % 传送的时候如果该玩家的PK值大于一定数值则不可以传送到指定地方只能传送到监狱
    % case player:get_popular(PS) >= ?PRISON_POPULAR of
    %     false ->
    %         case player:get_scene_no(PS) of 
    %             ?SCENE_PRISON_NO ->
    %                 case player:get_popular(PS) >= ?LEAVE_PRISON_POPULAR of
    %                     false ->
    %                         lib_send:send_prompt_msg(PS, ?PM_IN_PRISON);
    %                     true ->
    %                         NewSceneId1 = TelepCfg#teleport.target_scene_no,
    %                         {NewX1, NewY1} = TelepCfg#teleport.target_xy,

    %                         do_teleport(PS, NewSceneId1, NewX1, NewY1)
    %                 end;
    %             _ ->
    %                 NewSceneId = TelepCfg#teleport.target_scene_no,
    %                 {NewX, NewY} = TelepCfg#teleport.target_xy,

    %                 do_teleport(PS, NewSceneId, NewX, NewY)
    %         end;
    %     true ->
    %         % 如果玩家本来在监狱则不做处理
    %         case player:get_scene_no(PS) of 
    %             ?SCENE_PRISON_NO ->
    %                 skip;
    %             _ ->   
    %                 % 处理玩家暂离
    %                 case mod_team:tem_leave_team(PS) of
    %                     {fail, Reason} ->
    %                         skip;
    %                     ok ->
    %                         void
    %                 end,
                    
    %                 % 通知玩家PK值过高只能呆在监狱
    %                 {SceneId,X,Y} = ?REBORN_POS_OF_PRISON,
    %                 lib_send:send_prompt_msg(PS, ?PM_IN_PRISON),
    %                 do_teleport(PS, SceneId, X, Y)
    %         end        
    % end.

                   

    


%% 执行传送，直接跳转到目标位置。如果是队长，则同时会处理跟随的队员（上层函数需确保传入的位置是合法的！！）
%% !!!!!!! 注意：只能在玩家进程中调用 !!!!!!!
%% @para:   NewSceneId => 目标场景的唯一id
%%          NewX, NewY => 目标地点的x，y坐标
%% @return: 无用
do_teleport(PS, NewSceneId, NewX, NewY) ->
    ?ASSERT(is_integer(NewSceneId) andalso is_integer(NewX) andalso is_integer(NewY)),
    do_single_teleport(PS, NewSceneId, NewX, NewY),
    mod_team:leader_change_scene(PS),
    %% 处理玩家在帮派地图撤换添加/删除战斗外buff
    ply_guild:try_change_guild_buff(PS),
    % 处理跟随的队员
    post_do_teleport(PS, NewSceneId, NewX, NewY).
    
%% 执行单人传送，不处理跟随的队员
%% !!!!!!! 注意：离线玩家调用 !!!!!!!
do_single_teleport(PlayerId, NewSceneId1, NewX1, NewY1) when is_integer(PlayerId) ->
    player:db_save_position(PlayerId,NewSceneId1,NewX1,NewY1);

    %% 执行单人传送，不处理跟随的队员
%% !!!!!!! 注意：只能在玩家进程中调用 !!!!!!! 
do_single_teleport(PS, NewSceneId1, NewX1, NewY1) ->
    ?ASSERT(is_integer(NewSceneId1) andalso is_integer(NewX1) andalso is_integer(NewY1)),
    
    PlayerId = player:id(PS),
    OldPos = player:get_position(PlayerId),
    OldSceneId = OldPos#plyr_pos.scene_id,

    case NewSceneId1 == OldSceneId
    andalso NewX1 == OldPos#plyr_pos.x
    andalso NewY1 == OldPos#plyr_pos.y of
%%         true ->
%%             skip;
%%         false ->
		_ ->
            {NewSceneId,NewX,NewY} 
            % 玩家的PK值是否大于150
            = case player:get_popular(PS) >= ?PRISON_POPULAR of
                false ->
                    % 没有大于150 则判断当前是否是在 监狱地图
                    case player:get_scene_no(PS) of 
                        % 如果是监狱地图
                        ?SCENE_PRISON_NO ->
                            % 判断是否达到出狱要求
                            case player:get_popular(PS) < ?LEAVE_PRISON_POPULAR of
                                false ->
                                    case mod_team:tem_leave_team(PS) of
                                        {fail, Reason} ->
                                            skip;
                                        ok ->
                                            void
                                    end,

                                    lib_send:send_prompt_msg(PS, ?PM_IN_PRISON),
                                    {0,0,0};
                                true ->
                                    {NewSceneId1, NewX1, NewY1}
                            end;
                        % 如果不是监狱地图 正常传送
                        _ ->
                            {NewSceneId1, NewX1, NewY1}
                    end;
                true ->
                    % 如果玩家本来在监狱则不做处理
                    case player:get_scene_no(PS) of 
                        ?SCENE_PRISON_NO ->
                            case mod_team:tem_leave_team(PS) of
                                {fail, Reason} ->
                                    skip;
                                ok ->
                                    void
                            end,
                            
                            lib_send:send_prompt_msg(PS, ?PM_IN_PRISON),
                                    
                            {0,0,0};
                        _ ->   
                            % 处理玩家暂离
                            case mod_team:tem_leave_team(PS) of
                                {fail, Reason} ->
                                    skip;
                                ok ->
                                    void
                            end,
                            
                            % 通知玩家PK值过高只能呆在监狱
                            lib_send:send_prompt_msg(PS, ?PM_IN_PRISON),
                            ?REBORN_POS_OF_PRISON
                    end        
            end,

            ?DEBUG_MSG("NewSceneId=~p,NewX=~p,NewY=~p",[NewSceneId,NewX,NewY]),

            case NewSceneId of 
                0 -> skip;
                _ ->
                    RealNewSceneId = pre_enter_scene(PS, NewSceneId),
                    NewPos = player:remake_position_rd(PlayerId, RealNewSceneId, NewX, NewY), 
                    player:set_position(PlayerId, NewPos),
                    
                    ?Ifc (RealNewSceneId /= OldSceneId)
                        reset_step_counter(PlayerId),
                        player:mark_idle(PS)
                    ?End,

                    % 通知go进程

                    mod_go:player_teleport(PS, OldPos, NewPos),
                    ?Ifc (RealNewSceneId /= OldSceneId)
                        mod_scene_mgr:del_from_scene_player_list(OldSceneId, PlayerId),
                        mod_scene_mgr:add_to_scene_player_list(RealNewSceneId, PlayerId, NewPos#plyr_pos.scene_line)
                    ?End,

                    notify_cli_switch_to_new_scene(PlayerId, RealNewSceneId, NewX, NewY)

            end
    end.



%% 通知客户端：切换到新场景
notify_cli_switch_to_new_scene(PlayerId, NewSceneId, NewX, NewY) ->
    % ?TRACE("~n....notify_cli_switch_to_new_scene(), PlayerId=~p, TeamId=~p, IsLeader:~p, NewSceneId=~p, NewX=~p, NewY=~p~n~n", 
    %                 [PlayerId, player:get_team_id(PlayerId), player:is_leader(PlayerId), NewSceneId, NewX, NewY]),
    case lib_scene:get_obj(NewSceneId) of
        null ->
            % ?ASSERT(false, {PlayerId, NewSceneId, NewX, NewY}),
            ?ERROR_MSG("[ply_scene] notify_cli_switch_to_new_scene() error!! PlayerId:~p, NewSceneId:~p, NewX:~p, NewY:~p, stacktrace:~w", [PlayerId, NewSceneId, NewX, NewY, erlang:get_stacktrace()]),
            skip;
        SceneObj ->
            SceneNo = lib_scene:get_no(SceneObj),
            {ok, BinData} = pt_12:write(?PT_NOTIFY_SWITCH_TO_NEW_SCENE, [NewSceneId, SceneNo, NewX, NewY]),
            lib_send:send_to_uid(PlayerId, BinData)
    end.

            




%% 重置玩家的计步器
reset_step_counter(PlayerId) ->
    case player:get_position(PlayerId) of
        null ->
            ?ASSERT(false, PlayerId),
            skip;
        Pos ->
            Pos2 = Pos#plyr_pos{
                        step_counter = {0, util:rand(?REGEN_STEP_COUNT_MIN, ?REGEN_STEP_COUNT_MAX)}
                        },
            player:set_position(PlayerId, Pos2)
    end. 




%% 通知aoi：我的行为状态改变了
notify_bhv_state_changed_to_aoi(PlayerId, NewBhvState) ->
    lib_scene:notify_int_info_change_to_aoi(player, PlayerId, [{?OI_CODE_BHV_STATE, NewBhvState}]).



% 死亡后，
% lv10以上（含lv10）玩家送入长安城 126,67
% lv10以下玩家送入桃源镇 64,95
% lv5以下玩家送入玩家出生点
teleport_after_die(PlayerId) when is_integer(PlayerId) ->
    Lv = player:get_lv(PlayerId),
    Popular = player:get_popular(PlayerId),

    {SceneId, X, Y} =
        if 
            (Popular >= ?PRISON_POPULAR) ->
                ?REBORN_POS_OF_PRISON;
            Lv >= 10 ->
                ?REBORN_POS_OF_MAIN_CITY;
            Lv >= 5 ->
                ?REBORN_POS_OF_TAOYUANZHEN;
            true ->
                {?BORN_SCENE_NO, ?BORN_POS_X, ?BORN_POS_Y}
        end,
    do_single_teleport(PlayerId, SceneId, X, Y);


teleport_after_die(PS) ->
    Lv = player:get_lv(PS),

    ?DEBUG_MSG("teleport_after_die",[]),

    Popular = player:get_popular(PS),

    {SceneId, X, Y} =
        if 
            (Popular >= ?PRISON_POPULAR) ->
                ?REBORN_POS_OF_PRISON;
            Lv >= 10 ->
                ?REBORN_POS_OF_MAIN_CITY;
            Lv >= 5 ->
                ?REBORN_POS_OF_TAOYUANZHEN;
            true ->
                get_born_place(PS)
        end,
    do_single_teleport(PS, SceneId, X, Y).





%% 地府场景编号
-define(HELL_SCENE_NO, 6001).
-define(HELL_SCENE_DEFAULT_X, 32).
-define(HELL_SCENE_DEFAULT_Y, 23).

%% 传送到地府场景
goto_hell(PS) ->
    case config:need_to_goto_hell_after_die() of
        true ->
            do_single_teleport(PS, ?HELL_SCENE_NO, ?HELL_SCENE_DEFAULT_X, ?HELL_SCENE_DEFAULT_Y);
        false ->
            skip
    end.
            
goto_host_city(PS) ->
do_single_teleport(PS, 1304, 208, 147).


%% 传送到出生地点
goto_born_place(PS) ->
    Race = player:get_race(PS),
    {BornSceneNo, X, Y} = get_born_place(Race),
    do_single_teleport(PS, BornSceneNo, X, Y).






%% 跳转场景后，处理跟随的队员
post_do_teleport(PS, NewSceneId, NewX, NewY) ->
    case player:is_leader(PS) of
        false ->
            skip;
        true ->
            TeamId = player:get_team_id(PS),
            ?ASSERT(TeamId /= ?INVALID_ID, PS),
            L = mod_team:get_normal_member_id_list(TeamId),
            MyId = player:id(PS),
            ?DEBUG_MSG("testcorss2 ~p~n",[{TeamId, L,MyId ,mod_team:get_team_info(TeamId)}]),
            ?ASSERT(lists:member(MyId, L), {MyId, L}),
            L2 = L -- [MyId],
            F = fun(MemberId) ->
                    % 稳妥起见，再次判断是否在线
                    case player:is_online(MemberId) of
                        false ->
                            skip;
                        true ->
                            % MemberPS = player:get_PS(MemberId),    
                            ?TRACE("post_do_teleport(), before cast do_single_teleport,  MemberId:~p~n", [MemberId]),

                            % do_single_teleport(MemberPS, NewSceneId, NewX, NewY)

                            % 为避免并发问题，cast回对应的玩家进程做处理
                            gen_server:cast(player:get_pid(MemberId), {'do_single_teleport', NewSceneId, NewX, NewY})
                    end
                end,
            lists:foreach(F, L2)
    end.







%% 尝试触发场景的暗雷
%% @return: 无用
try_trigger_trap(SceneTpl, PS, NewPos) when is_record(NewPos, plyr_pos) ->
    case check_trigger_trap(SceneTpl, PS, NewPos) of
        fail ->
            skip;
        ok ->
            % SceneId = NewPos#plyr_pos.scene_id,
            % Scene = lib_scene:get_obj(SceneId),
            case mod_scene_tpl:get_trap_list(SceneTpl) of
                [] ->
                    skip;
                TrapList ->
                    % ?TRACE("TrapList:~p~n", [TrapList]),
                    % 触发优先级从高到低：任务暗雷 -> 活动暗雷 -> 普通暗雷 
                    case try_trigger_task_trap(PS, TrapList) of
                        ok ->
                            done;
                        fail ->
                            case try_trigger_activity_trap(PS, TrapList) of
                                ok ->
                                    done;
                                fail ->
                                    try_trigger_normal_trap(PS, TrapList)
                            end
                    end
            end         
    end.




%% 查询个人的任务明雷怪的位置，用于辅助实现客户端的自动寻路
%% @para: PlayerId => 玩家id
%%        MonNo => 明雷怪编号
%% @return: {ok, MonId, SceneId, X, Y} | fail
query_task_mon_pos(personal, PlayerId, MonNo) ->
    case mod_scene:get_task_mon_pos(personal, PlayerId, MonNo) of
        null ->
            fail;
        MonPos ->
            {ok, MonPos#mon_pos.mon_id, MonPos#mon_pos.scene_id, MonPos#mon_pos.x, MonPos#mon_pos.y}
    end;

%% 查询队伍的任务明雷怪的位置，用于辅助实现客户端的自动寻路
%% @para: TeamId => 队伍id
%%        MonNo => 明雷怪编号
%% @return: {ok, MonId, SceneId, X, Y} | fail
query_task_mon_pos(team, TeamId, MonNo) ->
    case mod_scene:get_task_mon_pos(team, TeamId, MonNo) of
        null ->
            fail;
        MonPos ->
            {ok, MonPos#mon_pos.mon_id, MonPos#mon_pos.scene_id, MonPos#mon_pos.x, MonPos#mon_pos.y}
    end.


%% 查询公共的任务明雷怪的位置，用于辅助实现客户端的自动寻路
%% @para: MonNo => 明雷怪编号
%% @return: {ok, MonId, SceneId, X, Y} | fail
query_task_mon_pos(public, MonNo) ->
    case mod_scene:get_task_mon_pos(public, MonNo) of
        null ->
            fail;
        MonPos ->
            {ok, MonPos#mon_pos.mon_id, MonPos#mon_pos.scene_id, MonPos#mon_pos.x, MonPos#mon_pos.y}
    end.




%% 确定所属的场景分线
decide_my_scene_line(SceneId) ->
    case lib_scene:get_obj(SceneId) of
        null ->
            ?DEFAULT_SCENE_LINE;  % 容错
        SceneObj ->
            L = lib_scene:get_scene_player_list(SceneId),
            decide_my_scene_line__(SceneObj, L, ?FIRST_SCENE_LINE)
    end.

            


decide_my_scene_line__(SceneObj, _L, CurTrialLine) when CurTrialLine > ?MAX_SCENE_LINE ->
    ?WARNING_MSG("[ply_scene] decide_my_scene_line__() MAX_SCENE_LINE!!!!!  SceneObj:~p", [SceneObj]),
    ?MAX_SCENE_LINE;
decide_my_scene_line__(SceneObj, L, CurTrialLine) ->
    Count = length( [dummy || X <- L, X#scene_ply.scene_line == CurTrialLine] ),
    case Count >= get_scene_line_max_player_count(SceneObj) of
        true ->
            decide_my_scene_line__(SceneObj, L, CurTrialLine + 1); % 尝试下一条分线
        false ->
            CurTrialLine
    end.





%% ================================== Local Functions =========================================


get_scene_line_max_player_count(SceneObj) ->
    SceneId = lib_scene:get_id(SceneObj),
    case SceneId == mod_global_data:get_main_city_scene_no() of
        true ->
            ?SCENE_LINE_MAX_PLAYER_COUNT_FOR_MAIN_CITY;
        false ->
            case lib_scene:is_copy_scene(SceneId) of
                true ->
                    ?SCENE_LINE_MAX_PLAYER_COUNT_FOR_COPY_SCENE;
                false ->
                    ?SCENE_LINE_MAX_PLAYER_COUNT
            end
    end.
            



check_enter_normal_scene(_PS, _NewSceneId) ->
    todo_here,
    ok.




check_teleport__(PS, TeleportNo) ->
    % 传送编号是否合法？
    TelepCfg = get_teleport_cfg_data(TeleportNo),
    case TelepCfg of
        null ->
            ?ASSERT(false, TeleportNo),
            throw(?PM_UNKNOWN_ERR);
        _ ->
            pass
    end,

    % % 是否空闲？
    % case player:is_idle(PS) of
    %     false ->
    %         throw(?PM_BUSY_NOW);
    %     true ->
    %         pass
    % end,


    % 是否在参加巡游活动中
    case ply_cruise:is_cruising(PS) of
        true ->
            throw(?PM_CLI_MSG_ILLEGAL);
        false ->
            pass
    end,


    CurPos = player:get_position(PS),
    TargetSceneNo = TelepCfg#teleport.target_scene_no,
    {TargetX, TargetY} = TelepCfg#teleport.target_xy,

    case mod_scene_tpl:is_tpl_exists(TargetSceneNo) of
        false ->
            ?ASSERT(false, TeleportNo),
            throw(?PM_UNKNOWN_ERR);
        true ->
            pass
    end,
 
    case CurPos#plyr_pos.scene_id == TargetSceneNo
    andalso CurPos#plyr_pos.x == TargetX
    andalso CurPos#plyr_pos.y == TargetY of
        true ->
            throw(?PM_OP_FREQUENCY_LIMIT);
        false ->
            pass
    end,

    % 玩家等级是否够？
    case player:get_lv(PS) >= TelepCfg#teleport.lv_need of
        false ->
            throw(?PM_LV_LIMIT);
        true ->
            pass
    end,

    % 组队并且非暂离状态下，只能由队长来操作
    case player:is_in_team(PS) andalso (not player:is_tmp_leave_team(PS)) andalso (not player:is_leader(PS)) of
        true ->
            ?ASSERT(false, player:id(PS)),
            throw(?PM_NOT_TEAM_LEADER);
        false ->
            pass
    end,

    CondList = TelepCfg#teleport.extra_conditions,
    case check_teleport_extra_conditions(CondList, PS) of
        ok ->
            pass;
        {fail, Reason} ->
            throw(Reason)
    end,

    ok.


% 检测额外的传送条件
check_teleport_extra_conditions([], _PS) ->
    ok;
check_teleport_extra_conditions([Cond | T], PS) ->
    case check_teleport_extra_one_cond(Cond, PS) of
        ok ->
            check_teleport_extra_conditions(T, PS);
        {fail, Reason} ->
            {fail, Reason}
    end.


check_teleport_extra_one_cond(already_joined_faction, PS) ->
    case player:is_in_faction(PS) of
        true ->
            ok;
        false ->
            {fail, ?PM_NOT_JOIN_FACTION_YET}
    end;
check_teleport_extra_one_cond(already_joined_guild, PS) ->
    case player:is_in_guild(PS) of
        true ->
            ok;
        false ->
            {fail, ?PM_NOT_JOIN_GUILD_YET}
    end;
check_teleport_extra_one_cond(_Other, _PS) ->
    ?ASSERT(false, _Other),
    {fail, ?PM_UNKNOWN_ERR}.







%% 玩家是否处于暗雷区？
is_in_trap_area(SceneTpl, Pos) when is_record(SceneTpl, scene_tpl) ->
    % SceneId = Pos#plyr_pos.scene_id,
    X = Pos#plyr_pos.x,
    Y = Pos#plyr_pos.y,
    % ?TRACE("before decide is_trap_area: ~p~n", [{SceneId, X , Y}]),
    mod_scene_tpl:is_trap_area(SceneTpl, X, Y).
    
    
%% 玩家是否处于擂台区？
is_in_leitai_area(PS) ->
    case player:get_position(PS) of
        null ->
            false;
        Pos ->
            lib_scene:is_leitai_area(Pos#plyr_pos.scene_id, Pos#plyr_pos.x, Pos#plyr_pos.y)
    end.


%% 触发暗雷的时间间隔
-define(TRIGGER_TRAP_INTV, 10).

%% @return: ok | fail
check_trigger_trap(SceneTpl, PS, NewPos) when is_record(NewPos, plyr_pos) ->
    {AccSteps, MaxSteps} = NewPos#plyr_pos.step_counter,
    % 累计步数是否已达最大值？
    case AccSteps >= MaxSteps of
        false -> fail;
        true ->
            % 是否空闲？
            case player:is_idle(PS) of
                false -> fail;
                true ->
                    % 是否处于暗雷区？
                    case is_in_trap_area(SceneTpl, NewPos) of
                        % false -> ?TRACE("no in trap area~n"), fail;
                        false ->
                            fail;
                        true ->
                            % 检测时间间隔，防挂！
                            TimeElapsed = svr_clock:get_unixtime() - ply_battle:get_last_battle_finish_time(),
                            case TimeElapsed < ?TRIGGER_TRAP_INTV of
                                true ->
                                    ?TRACE("check_trigger_trap(), fail for TimeElapsed:~p~n", [TimeElapsed]),
                                    fail;
                                false ->
                                    ok
                            end
                    end
            end     
    end.


%% @return: ok | fail
check_trigger_trap_2(PS, Trap) ->
    ConditionList = Trap#trap.conditions,
    check_trigger_trap_2__(PS, ConditionList).

check_trigger_trap_2__(PS, [Condition | T]) ->
    case Condition of
        {lv, LvNeed} ->
            case player:get_lv(PS) >= LvNeed of
                false ->
                    fail;
                true ->
                    check_trigger_trap_2__(PS, T)
            end;
        {has_task, TaskId} ->
            case lib_task:publ_is_accepted(TaskId, PS) of
                false ->
                    fail;
                true ->
                    check_trigger_trap_2__(PS, T)
            end;
        {has_unfinished_task, TaskId} ->
            case lib_task:publ_is_accepted(TaskId, PS) andalso (not lib_task:publ_is_completed(TaskId, PS)) of
                false ->
                    fail;
                true ->
                    check_trigger_trap_2__(PS, T)
            end;          
        {has_goods, _GoodsNo} ->
            % TODO:
            todo_here,
            check_trigger_trap_2__(PS, T);
        mid_autumn_activity_is_opening ->
            case is_mid_autumn_activity_opening() of
                false ->
                    fail;
                true ->
                    check_trigger_trap_2__(PS, T)
            end
    end;
check_trigger_trap_2__(_PS, []) ->
    ok.





%% @return: ok | fail
try_trigger_normal_trap(PS, TrapList) ->
    % ?TRACE("Player:~p try_trigger_normal_trap~n", [player:get_id(PS)]),
    % 检测是否有屏蔽触发暗雷的buff
    PlayerId = player:id(PS),
	HasBuffAvoidTrap = 
		case lib_cross:check_is_mirror() of
			true ->
				ServerId = player:get_server_id(PS),
				{ok, true} == sm_cross_server:rpc_call(ServerId, mod_buff, has_buff, [player, PlayerId, ?BFN_AVOID_TRAP]);
			false ->
				mod_buff:has_buff(player, PlayerId, ?BFN_AVOID_TRAP)
		end,
	case HasBuffAvoidTrap of	
        true -> 
            % ?TRACE("player:~p not trigger_trap because has avoid trop buff!~n", [player:id(PS)]),
            fail;
        false -> 
            % ?TRACE("player:~p trigger_trap~n", [player:id(PS)]),
            % TargetTrapType = ?TRAP_T_NORMAL,
            % try_trigger_trap__(PS, TargetTrapType, TrapList)

            F = fun(Trap) ->
                    case Trap#trap.type of
                        ?TRAP_T_NORMAL ->
                            case check_trigger_trap_2(PS, Trap) of
                                ok -> ok;
                                fail -> pass
                            end;
                        _ ->
                            pass
                    end     
                end,

            NormalTrapList_CanTrigger = [X || X <- TrapList, F(X) == ok],
            case NormalTrapList_CanTrigger of
                [] ->
                    fail;
                _ ->
                    % 随机挑一个
                    PickedTrap = list_util:rand_pick_one(NormalTrapList_CanTrigger),
                    do_trigger_trap(PS, PickedTrap),
                    ok
            end            
    end.


    
    


%% @return: ok | fail
try_trigger_task_trap(PS, TrapList) ->
    TargetTrapType = ?TRAP_T_TASK,
    try_trigger_trap__(PS, TargetTrapType, TrapList).


%% @return: ok | fail
try_trigger_activity_trap(PS, TrapList) ->
    TargetTrapType = ?TRAP_T_ACTIVITY,
    try_trigger_trap__(PS, TargetTrapType, TrapList).



%% @return: ok | fail
try_trigger_trap__(PS, TargetTrapType, [Trap | T]) ->
    case Trap#trap.type of
        TargetTrapType ->
            case check_trigger_trap_2(PS, Trap) of
                ok ->
                    do_trigger_trap(PS, Trap),
                    ok;
                fail ->
                    try_trigger_trap__(PS, TargetTrapType, T)
            end;
        _ ->
            try_trigger_trap__(PS, TargetTrapType, T)
    end;
try_trigger_trap__(_PS, _TargetType, []) ->
    fail.




do_trigger_trap(PS, Trap) ->
    BMonGroupNo = Trap#trap.bmon_group_no,
    ?TRACE("do_trigger_trap(), TrapNo = ~p, BMonGroupNo=~p~n", [Trap#trap.no, BMonGroupNo]),
    mod_battle:start_mf(PS, BMonGroupNo, null).







%% 进场景前的处理
pre_enter_scene(_PS, SceneId) ->
    case lib_scene:is_copy_scene(SceneId) of
        true ->
            SceneId;  % nothing to do
        false ->
            PlayerCount = lib_scene:get_scene_player_count(SceneId),
            case PlayerCount >= ?MAX_ALLOWED_PLAYER_EACH_SCENE of
                true ->
                    case lib_scene:is_reserve_scene_exists(SceneId) of
                        true ->
                            % ?TRACE("[ply_scene] reserve scene already exists! SceneId:~p~n", [SceneId]),
                            ReserveSceneId = lib_scene:get_reserve_scene_id(SceneId),
                            ?ASSERT(ReserveSceneId /= ?INVALID_ID),
                            ReserveSceneId;
                        false ->
                            % ?TRACE("[ply_scene] reserve scene NOT exists, so create it! SceneId:~p~n", [SceneId]),
                            mod_scene_mgr:create_reserve_scene(SceneId),
                            SceneId
                    end;
                false ->
                    % 判断玩家是否在帮战地图
                    {Scene1,_,_} =  ?GUILD_ENTER1_CONFIG,
                    {Scene2,_,_} =  ?GUILD_ENTER2_CONFIG,
                    {Scene3,_,_} =  ?GUILD_ENTER3_CONFIG,

                    % 参数 是否在帮战期间 
                    case (mod_guild_battle:get_state() =/= ?GUILD_BATTLE_OPEN andalso lists:member(SceneId,[Scene1,Scene2,Scene3])) of
                        true ->
                            1304;
                        _Other1 ->
                            SceneId
                    end                    
            end
    end.

%% 是否处于中秋节活动的时间中？
%% 2014年的中秋节活动时间：始于9月6日0点整，结束于9月9日0点整
is_mid_autumn_activity_opening() ->
    BeginDate = 20140906,
    EndDate = 20140909,
    TodayDate = util:today_date(),
    (TodayDate >= BeginDate) andalso (TodayDate < EndDate).
    



% 废弃！！
% %% 通知客户端：场景中的动态npc列表（不包括巡逻npc!!）
% notify_cli_dynamic_npc_list(PS, NewSceneId) ->
%     ?TRACE("....notify_cli_dynamic_npc_list(), PlayerId=~p NewSceneId=~p~n", [player:id(PS), NewSceneId]),
%     % CurPos = player:get_position(player:get_id(PS)),
%     % SceneId = CurPos#plyr_pos.scene_id,
%     % ?ASSERT(__SceneId =:= SceneId, {__SceneId, SceneId}),  % 客户端发的场景id只是用来做调试验证的！
%     SceneInfo = lib_scene:get_obj(NewSceneId),
%     ?ASSERT(SceneInfo /= null, NewSceneId),
            
%     DynNpcIdList = lib_scene:get_scene_dynamic_npc_ids(SceneInfo),

%     % 过滤掉巡逻npc
%     DynNpcIdList2 = [X || X <- DynNpcIdList, not lib_npc:is_patrol_npc(X)],

%     {ok, BinData} = pt_12:write(?PT_GET_SCENE_DYNAMIC_NPC_LIST, DynNpcIdList2),
%     lib_send:send_to_sock(PS, BinData).


% 废弃！！
% %% 通知客户端：场景AOI范围的信息
% notify_cli_AOI_info(PS, NewPos) ->
%     ?TRACE("....notify_cli_AOI_info(), PlayerId=~p NewPos=~p~n", [player:id(PS), NewPos]),
%     mod_scene:notify_AOI_info_to_player(PS, NewPos).  % todo: 可以考虑将此函数移到本模块。
