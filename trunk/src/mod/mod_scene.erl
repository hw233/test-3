%%%------------------------------------
%%% @Module  : mod_scene
%%% @Author  : huangjf, LDS
%%% @Email   : 
%%% @Created : 2013.6.16
%%% @Description: 场景系统
%%%------------------------------------
-module(mod_scene).

-export([
        create_scene/1, 
        clear_scene/1,
        
        spawn_dynamic_npc_to_scene/4, spawn_dynamic_npc_to_scene/5, spawn_dynamic_npc_to_scene_WNC/4, spawn_dynamic_npc_to_scene_WNC/5,
        clear_dynamic_npc_from_scene/1, clear_dynamic_npc_from_scene_WNC/1,
        clear_spec_no_dynamic_npc_from_scene_WNC/2,

        spawn_mon_to_scene/4, spawn_mon_to_scene_WNC/4,      
        clear_mon_from_scene/1, clear_mon_from_scene_WNC/1,

        spawn_mon_to_scene_for_player_WNC/3,
        spawn_mon_to_scene_for_player_WNC/4,
        spawn_mon_to_scene_for_player_WNC/5,

        spawn_mon_to_scene_for_public_WNC/2,
        spawn_mon_to_scene_for_public_WNC/3,
        spawn_mon_to_scene_for_public_WNC/4,

        spawn_dynamic_teleporter_to_scene_WNC/4,
        clear_dynamic_teleporter_from_scene_WNC/1,

        get_task_mon_pos/3, get_task_mon_pos/2,
        delete_mon_position/1,

        notify_dynamic_npc_cleared_to_players/1,
        notify_dynamic_teleporter_cleared_from_scene/1,
		delete_mon_position__/2,
		
		rand_pick_one_spawn_mon_pos_all/1
        ]).

-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("scene.hrl").
-include("player.hrl").
-include("monster.hrl").
-include("protocol/pt_12.hrl").
-include("abbreviate.hrl").
-include("npc.hrl").


%% 创建场景
%% @para: SceneNo => 场景编号
%% @return：fail | {ok, NewSceneId}
create_scene(SceneNo) ->
    mod_scene_mgr:create_scene(SceneNo).

    
%% 清除场景
clear_scene(SceneId) ->
    mod_scene_mgr:clear_scene(SceneId).

    


%% 刷出动态npc到场景
%% @return: {ok, NewDynamicNpcId} | fail
spawn_dynamic_npc_to_scene(NpcNo, SceneId, X, Y) ->
    spawn_dynamic_npc_to_scene(NpcNo, SceneId, X, Y, []).
    
%% @para: ExtraInitInfo => 额外的初始化信息， 格式如： [{Key, Value}, ...]
spawn_dynamic_npc_to_scene(NpcNo, SceneId, X, Y, ExtraInitInfo) ->
    ?ASSERT(lib_scene:is_exists(SceneId)),
    % SceneObj = lib_scene:get_obj(SceneId),
    case mod_npc:create_dynamic_npc([NpcNo, SceneId, X, Y], ExtraInitInfo) of
        fail ->
            ?ASSERT(false, NpcNo),
            fail;
        {ok, NewDynamicNpc} ->
            NewDynamicNpcId = mod_npc:get_id(NewDynamicNpc),

            ?DEBUG_MSG("[mod_scene] spawn_dynamic_npc_to_scene(), NpcNo:~p, NewDynamicNpc:~w, SceneId:~p, X:~p, Y:~p, ExpireTime:~p", [NpcNo, NewDynamicNpc, SceneId, X, Y, NewDynamicNpc#npc.expire_time]),

            % 添加到ets
            mod_npc:add_npc_to_ets(NewDynamicNpc),

            % 添加到场景对象所记录的动态npc列表（为避免并发问题，统一cast到场景管理进程做处理）
            mod_scene_mgr:add_to_scene_dynamic_npc_id_list(SceneId, NewDynamicNpcId),

            ?Ifc (mod_npc:is_moveable(NewDynamicNpcId))
                % 加到场景格子。 为避免并发问题而引起AOI的相关数据不一致，这里统一cast到go server做处理
                mod_go:npc_enter_scene(NewDynamicNpcId, SceneId, X, Y)
            ?End,

            {ok, NewDynamicNpcId}
    end.


%% 同上，只是多了通知客户端的处理（WNC: with notify client）
%% @return: {ok, NewDynamicNpcId} | fail
spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneId, X, Y) ->
    spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneId, X, Y, []).

spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneId, X, Y, ExtraInitInfo) ->
    case spawn_dynamic_npc_to_scene(NpcNo, SceneId, X, Y, ExtraInitInfo) of
        fail ->
            fail;
        {ok, NewDynamicNpcId} ->
            notify_dynamic_npc_spawned_to_players(NewDynamicNpcId, SceneId),
            {ok, NewDynamicNpcId}
    end.



%% 从场景清除动态NPC
%% @return: 无用
clear_dynamic_npc_from_scene(NpcId) ->
    % 为避免并发问题（如：NPC管理进程和场景管理进程并发执行清除同一个动态NPC的处理），清除的处理统一委托到mod_scene_mgr这个gen_server
    mod_scene_mgr:clear_dynamic_npc_from_scene(NpcId),
    void.


%% 同上，只是多了通知客户端的处理
%% @return: 无用
clear_dynamic_npc_from_scene_WNC(NpcId) ->
    % 为避免并发问题，清除的处理统一委托到mod_scene_mgr这个gen_server
    mod_scene_mgr:clear_dynamic_npc_from_scene_WNC(NpcId),
    void.
    


%% 清除场景中的编号为NpcNo的所有动态npc （spec no dynamic npc: 指定编号的动态npc）
clear_spec_no_dynamic_npc_from_scene_WNC(SceneId, NpcNo) ->
    DynNpcIdList = lib_scene:get_scene_dynamic_npc_ids(SceneId),
    F = fun(NpcId) ->
            case mod_npc:get_obj(NpcId) of
                null ->
                    skip;
                NpcObj ->
                    case mod_npc:get_no(NpcObj) == NpcNo of
                        true ->
                            clear_dynamic_npc_from_scene_WNC(NpcId);
                        false ->
                            skip
                    end
            end
        end,
    lists:foreach(F, DynNpcIdList).




%% 作废！！
% %% 从场景清除动态npc
% clear_dynamic_npc_from_scene(NpcId) ->
%     ?ASSERT(mod_npc:is_exists(NpcId), NpcId),
%     Npc = mod_npc:get_obj(NpcId),
%     ?ASSERT(mod_npc:is_dynamic_npc(Npc), Npc),
    
%     % 先从场景对象所记录的动态npc列表中删除
%     SceneId = mod_npc:get_scene_id(Npc),
%     SceneObj = lib_scene:get_obj(SceneId),
%     List_Old = lib_scene:get_scene_dynamic_npc_ids(SceneObj),
%     ?ASSERT(lists:member(NpcId, List_Old), {NpcId, List_Old, SceneObj}),
%     List_New = List_Old -- [NpcId],
%     lib_scene:set_scene_dynamic_npc_ids(SceneObj, List_New),

%     ?Ifc (mod_npc:is_moveable(Npc))
%         % 从场景格子移除
%         % SceneId = mod_npc:get_scene_id(Npc),
%         {X, Y} = mod_npc:get_xy(Npc),
%         lib_scene:leave_old_scene_grid(npc, NpcId, SceneId, X, Y)
%     ?End,

%     % 清除npc本身
%     mod_npc:clear_npc(NpcId),

%     ok.
    


% %% 同上， 只是多了通知客户端的处理（WNC: with notify client）
% clear_dynamic_npc_from_scene_WNC(NpcId) ->
%     case mod_npc:get_obj(NpcId) of
%         null ->
%             skip;
%         _ ->
%             ?ASSERT(mod_npc:is_exists(NpcId), NpcId),
%             Npc = mod_npc:get_obj(NpcId),
%             clear_dynamic_npc_from_scene(NpcId),
%             notify_dynamic_npc_cleared_to_AOI(Npc),
%             ok
%     end.


% 作废！！
% %% 注意：本接口仅用于调试！以后会删除！ 实际代码中不要调用！
% dbg_spawn_mon_to_scene(MonNo, SceneId, X, Y) ->
%     {ok, NewMonId} = mod_mon:create_mon([MonNo, SceneId, X, Y]),
%     Scene = lib_scene:get_obj(SceneId),
%     Scene2 = Scene#scene{mons = Scene#scene.mons ++ [NewMonId]},
%     lib_scene:update_scene_to_ets(Scene2),
%     {ok, NewMonId}.



% %% 排定：刷出明雷怪到场景，包含通知客户端(WNC: with notify client)
% schedule_spawn_mon_to_scene_WNC(MonNo, SceneId, X, Y) ->
%     mod_scene_mgr:schedule_spawn_mon_to_scene_WNC(MonNo, SceneId, X, Y).








%% 刷出动态明雷怪到场景，不属于任何玩家或队伍
%% @para: MonNo => 明雷怪编号
%%        SceneId, X, Y => 明雷怪刷出的地点：场景id，X坐标，Y坐标
%% @return: {ok, NewMonId} | fail
spawn_mon_to_scene(MonNo, SceneId, X, Y) ->
    ?TRACE("~n~n~n~n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!spawn_mon_to_scene() ...................~n~n"),
    % ?DEBUG_MSG("spawn_mon_to_scene(), MonNo=~p, SceneId=~p, X=~p, Y=~p~n", [MonNo, SceneId, X, Y]),
    ?ASSERT(lib_scene:is_exists(SceneId), SceneId),
    % SceneObj = lib_scene:get_obj(SceneId),
    case mod_mon:create_mon([MonNo, SceneId, X, Y]) of
        fail ->
            ?ASSERT(false, MonNo),
            fail;
        {ok, NewMon} ->
            % 断言动态明雷怪必定是有时限的！
            case mod_mon:is_existing_time_forever(NewMon) of
                true ->
                    ?ASSERT(false, {MonNo, SceneId}),
                    ?ERROR_MSG("[mod_scene] spawn_mon_to_scene(), existing time error!! MonNo:~p, SceneId:~p, X:~p, Y:~p", [MonNo, SceneId, X, Y]);
                false ->
                    skip
            end,

            NewMonId = mod_mon:get_id(NewMon),

            ?DEBUG_MSG("[mod_scene] spawn_mon_to_scene(), MonNo:~p, NewMonId:~p, SceneId:~p, X:~p, Y:~p, ExpireTime:~p", [MonNo, NewMonId, SceneId, X, Y, NewMon#mon.expire_time]),

            % ?DEBUG_MSG("spawn_mon_to_scene(), ok,  MonNo:~p, MonId:~p~n", [MonNo, NewMonId]),

            % 添加到ets
            mod_mon:add_mon_to_ets(NewMon),

            % 添加到场景对象所记录的明雷怪列表（为避免并发问题，统一cast到场景管理进程做处理）
            mod_scene_mgr:add_to_scene_mon_id_list(SceneId, NewMonId),

            % 加到场景格子。 为避免并发问题而引起AOI的相关数据不一致，这里统一cast到go
            mod_go:mon_enter_scene(NewMonId, SceneId, X, Y),
            
            {ok, NewMonId}
    end.



%% 同上，只是多了通知客户端的处理（WNC: with notify client）
%% @return: {ok, NewMonId} | fail
spawn_mon_to_scene_WNC(MonNo, SceneId, X, Y) ->
    ?ASSERT(lib_scene:is_exists(SceneId), SceneId),
    ?TRACE("spawn_mon_to_scene_WNC(), MonNo=~p, SceneId=~p, X=~p, Y=~p~n", [MonNo, SceneId, X, Y]),
    case spawn_mon_to_scene(MonNo, SceneId, X, Y) of
        fail ->
            fail;
        {ok, NewMonId} ->
            ?TRACE("spawn_mon_to_scene_WNC(), NewMonId=~p~n", [NewMonId]),
            mod_go:notify_mon_spawned_to_AOI(NewMonId, SceneId),
            {ok, NewMonId}
    end.


%% 为指定玩家而刷出动态明雷怪，在场景中随机挑选一个刷怪点刷出（刷出后，只有该玩家或该玩家所在队伍的队员能见到它）
%% @return: {ok, NewMonId} | fail
spawn_mon_to_scene_for_player_WNC(PS, MonNo, SceneId) ->
    ?ASSERT(lib_scene:is_exists(SceneId), SceneId),
    SceneObj = lib_scene:get_obj(SceneId),
    {X, Y} = rand_pick_one_spawn_mon_pos(SceneObj),
    spawn_mon_to_scene_for_player_WNC(PS, MonNo, SceneId, X, Y).


%% 为指定玩家而刷出动态明雷怪，在场景指定的刷怪区域中刷出（刷出后，只有该玩家或该玩家所在队伍的队员能见到它）
%% @para: SpawnMonAreaNo => 场景中的刷怪区域编号
%% @return: {ok, NewMonId} | fail
spawn_mon_to_scene_for_player_WNC(PS, MonNo, SceneId, {X, Y}) ->
	spawn_mon_to_scene_for_player_WNC(PS, MonNo, SceneId, X, Y);

spawn_mon_to_scene_for_player_WNC(PS, MonNo, SceneId, SpawnMonAreaNo) ->
    ?ASSERT(lib_scene:is_exists(SceneId), SceneId),
    SceneObj = lib_scene:get_obj(SceneId),
    {X, Y} = rand_pick_one_spawn_mon_pos(SceneObj, SpawnMonAreaNo),
    spawn_mon_to_scene_for_player_WNC(PS, MonNo, SceneId, X, Y).


%% 同上，只是刷怪点的坐标是已经确定的
%% @return: {ok, NewMonId} | fail
spawn_mon_to_scene_for_player_WNC(PS, MonNo, SceneId, X, Y) ->
    ?ASSERT(lib_scene:is_exists(SceneId), SceneId),
    case spawn_mon_to_scene(MonNo, SceneId, X, Y) of
        fail ->
            fail;
        {ok, NewMonId} ->
            PlayerId = player:id(PS),
            mod_mon:set_owner_id(NewMonId, PlayerId),

            IsInTeam = player:is_in_team(PS),
            TeamId = player:get_team_id(PS),
            case IsInTeam of
                true -> mod_mon:set_team_id(NewMonId, TeamId);
                false -> skip
            end,

            % 记录怪的位置，用于辅助实现客户端自动寻路的功能
            case lib_scene:is_copy_scene(SceneId) of
                true ->
                    skip; % 目前不记录刷在拷贝场景的怪，以后有需要的话，再做处理！
                false ->
                    record_mon_position(personal, PlayerId, {MonNo, NewMonId}, {SceneId, X, Y}),
                    ?Ifc (IsInTeam)
                        % 顺带记录到队伍
                        record_mon_position(team, TeamId, {MonNo, NewMonId}, {SceneId, X, Y})
                    ?End
            end,

            mod_go:notify_mon_spawned_to_AOI(NewMonId, SceneId),
            {ok, NewMonId}
    end.






%% 刷出公共的动态明雷怪（所有玩家可见），在场景中随机挑选一个刷怪点刷出
%% @return: {ok, NewMonId} | fail
spawn_mon_to_scene_for_public_WNC(MonNo, SceneId) ->
    ?ASSERT(lib_scene:is_exists(SceneId), SceneId),
    SceneObj = lib_scene:get_obj(SceneId),
    {X, Y} = rand_pick_one_spawn_mon_pos(SceneObj),
    spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, X, Y).


%% 刷出公共的动态明雷怪（所有玩家可见），在场景指定的刷怪区域中刷出
%% @para: SpawnMonAreaNo => 场景中的刷怪区域编号
%% @return: {ok, NewMonId} | fail
spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, {X, Y}) ->
	spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, X, Y);

spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, SpawnMonAreaNo) ->
    ?ASSERT(lib_scene:is_exists(SceneId), SceneId),
    SceneObj = lib_scene:get_obj(SceneId),
    {X, Y} = rand_pick_one_spawn_mon_pos(SceneObj, SpawnMonAreaNo),
    spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, X, Y).


%% 同上，只是刷怪点的坐标是已经确定的
%% @return: {ok, NewMonId} | fail
spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, X, Y) ->
    ?ASSERT(lib_scene:is_exists(SceneId), SceneId),
    ?TRACE("spawn_mon_to_scene_for_public_WNC(),  MonNo:~p~n", [MonNo]),
    case spawn_mon_to_scene(MonNo, SceneId, X, Y) of
        fail ->
            fail;
        {ok, NewMonId} ->
            % ?DEBUG_MSG("[mod_scene] spawn_mon_to_scene_for_public_WNC(), NewMonId:~p, SceneId:~p, X:~p, Y:~p, ExpireTime:~p", 
            %                             [NewMonId, SceneId, X, Y, (mod_mon:get_obj(NewMonId))#mon.expire_time]),        
            % 记录怪的位置，用于辅助实现客户端自动寻路的功能
            case lib_scene:is_copy_scene(SceneId) of
                true ->
                    skip; % 目前不记录刷出在拷贝场景的怪，以后有需要的话，再做处理
                false ->
                    record_mon_position(public, {MonNo, NewMonId}, {SceneId, X, Y})
            end,

            mod_go:notify_mon_spawned_to_AOI(NewMonId, SceneId),
            {ok, NewMonId}
    end.

    


%% 从场景清除明雷怪
%% @return: 无用
clear_mon_from_scene(MonId) ->
    % 为避免并发问题（怪物管理进程和场景管理进程并发执行清除同一个怪的处理），清除的处理统一委托到mod_scene_mgr这个gen_server
    mod_scene_mgr:clear_mon_from_scene(MonId),
    void.


%% 同上，只是多了通知客户端的处理
%% @return: 无用
clear_mon_from_scene_WNC(MonId) ->
    ?DEBUG_MSG("[mod_scene] clear_mon_from_scene_WNC(), MonId:~p~n", [MonId]),
    % 为避免并发问题，清除的处理统一委托到mod_scene_mgr这个gen_server
    mod_scene_mgr:clear_mon_from_scene_WNC(MonId),
    void.
    



%% 获取个人的任务明雷怪对象的位置
%% @return: null | mon_pos结构体
get_task_mon_pos(personal, PlayerId, MonNo) ->
    case ets:lookup(?ETS_MON_POSITION, {personal, PlayerId, MonNo}) of
        [] ->
            null;
        [MonPos] ->
            ?ASSERT(is_record(MonPos, mon_pos), MonPos),
            MonPos
    end;

%% 获取队伍的任务明雷怪对象的位置
%% @return: null | mon_pos结构体
get_task_mon_pos(team, TeamId, MonNo) ->
    case ets:lookup(?ETS_MON_POSITION, {team, TeamId, MonNo}) of
        [] ->
            null;
        [MonPos] ->
            ?ASSERT(is_record(MonPos, mon_pos), MonPos),
            MonPos
    end.


%% 获取公共的任务明雷怪对象的位置
%% @return: null | mon_pos结构体
get_task_mon_pos(public, MonNo) ->
    case ets:lookup(?ETS_MON_POSITION, {public, MonNo}) of
        [] ->
            null;
        [MonPos] ->
            ?ASSERT(is_record(MonPos, mon_pos), MonPos),
            MonPos
    end.




%% 记录个人的明雷怪的位置
record_mon_position(personal, PlayerId, {MonNo, MonId}, {SceneId, X, Y}) ->
    ?TRACE("record_mon_position()~n"),
    ?ASSERT(PlayerId /= ?INVALID_ID),
    R = #mon_pos{
            key = {personal, PlayerId, MonNo},
            mon_no = MonNo,
            mon_id = MonId,
            scene_id = SceneId, 
            x = X,
            y = Y
            },

    ets:insert(?ETS_MON_POSITION, R);

%% 记录队伍的明雷怪的位置
record_mon_position(team, TeamId, {MonNo, MonId}, {SceneId, X, Y}) ->
    ?ASSERT(TeamId /= ?INVALID_ID),
    R = #mon_pos{
            key = {team, TeamId, MonNo},
            mon_no = MonNo,
            mon_id = MonId,
            scene_id = SceneId, 
            x = X,
            y = Y
            },
    ets:insert(?ETS_MON_POSITION, R).
            

%% 记录公共的明雷怪的位置
record_mon_position(public, {MonNo, MonId}, {SceneId, X, Y}) ->
    R = #mon_pos{
            key = {public, MonNo},
            mon_no = MonNo,
            mon_id = MonId,
            scene_id = SceneId, 
            x = X,
            y = Y
            },
    ets:insert(?ETS_MON_POSITION, R).



%% 删除明雷怪的位置记录
delete_mon_position(MonObj) ->
    ?ASSERT(is_record(MonObj, mon), MonObj),
    MonNo = mod_mon:get_no(MonObj),
    case mod_mon:has_owner(MonObj) of
        true ->
            OwnerId = mod_mon:get_owner_id(MonObj),
            delete_mon_position__(personal, OwnerId, MonNo);
        false ->
            delete_mon_position__(public, MonNo)
    end,
    case mod_mon:has_team(MonObj) of
        true ->
            TeamId = mod_mon:get_team_id(MonObj),
            delete_mon_position__(team, TeamId, MonNo);
        false ->
            skip
    end.



%% 删除个人的明雷怪的位置记录
delete_mon_position__(personal, PlayerId, MonNo) ->
    ets:delete(?ETS_MON_POSITION, {personal, PlayerId, MonNo});

%% 删除队伍的明雷怪的位置记录
delete_mon_position__(team, TeamId, MonNo) ->
    ets:delete(?ETS_MON_POSITION, {team, TeamId, MonNo}).


%% 删除公共的明雷怪的位置记录
delete_mon_position__(public, MonNo) ->
    ets:delete(?ETS_MON_POSITION, {public, MonNo}).    


    

%% 废弃！！
% %% 为指定的队伍而刷出明雷怪（刷出后，只有该队伍的玩家能见到它）
% %% @return: {ok, NewMonId} | fail
% spawn_mon_to_scene_for_team_WNC(TeamId, MonNo, SceneId, X, Y) ->
%     case spawn_mon_to_scene(MonNo, SceneId, X, Y) of
%         fail ->
%             fail;
%         {ok, NewMonId} ->
%             mod_mon:set_team_id(NewMonId, TeamId),
%             notify_mon_spawned_to_AOI(NewMonId, SceneId, X, Y),
%             {ok, NewMonId}
%     end.











%% 刷出动态传送点到场景（注意：须确保传入的坐标是合法的，否则统一返回fail!!）
%% @para: TeleportNo => 动态传送点对应的传送编号
%%        SceneId =>  动态传送点所在的场景唯一id
%%        X => 动态传送点所在的X坐标
%%        Y => 动态传送点所在的Y坐标
%% @return: fail | {ok, teleporter结构体}
spawn_dynamic_teleporter_to_scene_WNC(TeleportNo, SceneId, X, Y) ->
    case lib_scene:get_obj(SceneId) of
        null ->
            ?ASSERT(false, {TeleportNo, SceneId}),
            fail;
        SceneObj ->
            case lib_scene:is_xy_valid(SceneObj, X, Y) of
                false ->
                    ?ASSERT(false, {X, Y, SceneObj}),
                    fail;
                true ->
                    NewTeleporter = make_teleporter_rd(TeleportNo, SceneId, X, Y),
                    % 记录到场景对象
                    mod_scene_mgr:add_to_scene_dynamic_teleporter_list(SceneId, NewTeleporter),  % add_dynamic_teleporter(SceneObj, NewTeleporter),
                    % 通知给场景中的玩家， 因为是通知给整个场景，故不交由go server做处理
                    notify_dynamic_teleporter_spawned_to_scene(NewTeleporter),
                    {ok, NewTeleporter}     
            end     
    end.


%% 从场景删除动态传送点
%% @para: DynamicTeleporter => teleporter结构体
%% @return: 无用
clear_dynamic_teleporter_from_scene_WNC(DynamicTeleporter) ->
    mod_scene_mgr:clear_dynamic_teleporter_from_scene_WNC(DynamicTeleporter),
    void.



    




    
	

    
% %% 怪物走动
% mon_move(_MonId, _X2, _Y2) ->
%     todo_here;

% %% 巡逻npc走动
% npc_move(_NpcId, _X2, _Y2) ->
%     todo_here.


% % 通知场景AOI范围的信息给玩家
% notify_AOI_info_to_player(PS, Pos) ->
%     ?ASSERT(is_record(Pos, plyr_pos), Pos),
%     PlayerId = player:get_id(PS),
%     SceneLine = player:get_scene_line(PlayerId),
%     ?TRACE("notify_AOI_info_to_player()..~n"),



%     {PlayerIdList, MonIdList, NpcIdList} = lib_aoi:get_AOI_all_obj_ids_by_scene_line_or_team_except_me(PlayerId, Pos, SceneLine),

%     ?ASSERT( length(gb_sets:to_list(gb_sets:from_list(PlayerIdList))) == length(PlayerIdList), {PlayerIdList, PlayerId, Pos}), 

%     % 通知AOI内的玩家信息
%     ?Ifc (PlayerIdList /= [])
%         {ok, Bin_EnterNotice} = pt_12:write(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, PlayerIdList),
%         lib_send:send_to_sid(PS, Bin_EnterNotice)
%     ?End,

%     % 通知AOI内的怪物信息
%     ?Ifc (MonIdList /= [])
%         {ok, Bin_EnterNotice2} = pt_12:write(?PT_NOTIFY_OBJS_ENTER_MY_AOI, {mon, MonIdList}),
%         lib_send:send_to_sid(PS, Bin_EnterNotice2)
%     ?End,

%     % 通知AOI内的巡逻NPC信息
%     ?Ifc (NpcIdList /= [])
%         {ok, Bin_EnterNotice3} = pt_12:write(?PT_NOTIFY_OBJS_ENTER_MY_AOI, {npc, NpcIdList}),
%         lib_send:send_to_sid(PS, Bin_EnterNotice3)
%     ?End.











%% 通知场景中的玩家：场景中刷出了动态npc
notify_dynamic_npc_spawned_to_players(NpcId, SceneId) ->
    NpcObj = mod_npc:get_obj(NpcId),
    case mod_npc:is_moveable(NpcObj) of
        true ->
            % 通知给aoi（统一交由mod_go处理）
            mod_go:notify_npc_spawned_to_AOI(NpcObj, SceneId);
        false ->
            % 通知给整个场景（目前认为不需交由mod_go处理）
            {X, Y} = mod_npc:get_xy(NpcObj),
            {ok, Bin} = pt_12:write(?PT_NOTIFY_OBJ_SPAWNED, {npc, NpcObj, X, Y}),
            lib_send:send_to_scene(SceneId, Bin)
    end.

            

%% 通知场景中的玩家：场景中的动态npc被清除了
notify_dynamic_npc_cleared_to_players(NpcObj) ->
    case mod_npc:is_moveable(NpcObj) of
        true ->
            % 通知给aoi（统一交由mod_go处理）
            mod_go:notify_npc_cleared_to_AOI(NpcObj);
        false ->
            % 通知给整个场景（目前认为不需交由mod_go处理）
            NpcId = mod_npc:get_id(NpcObj),
            SceneId = mod_npc:get_scene_id(NpcObj),
            {ok, Bin} = pt_12:write(?PT_NOTIFY_OBJ_CLEARED, {npc, NpcId}),
            lib_send:send_to_scene(SceneId, Bin)
    end.


            










%% ============================================================ Local Functions ===============================================================
















% %% 通知AOI：场景刷出了明雷怪
% notify_mon_spawned_to_AOI(MonId, SceneId, X, Y) ->
%     {ok, Bin} = pt_12:write(?PT_NOTIFY_OBJ_SPAWNED, {mon, MonId}),
%     lib_send:send_to_AOI({SceneId, X, Y}, Bin).



%% 从场景中随机挑一个刷怪点
%% @return: {X, Y} | none
rand_pick_one_spawn_mon_pos(SceneObj) ->
    SceneNo = lib_scene:get_no(SceneObj),
    SceneTpl = mod_scene_tpl:get_tpl_data(SceneNo),
    case mod_scene_tpl:get_spawn_mon_area_list(SceneTpl) of
        [] ->
            ?ASSERT(false, SceneNo), % 目前严格些，断言失败！
            ?WARNING_MSG("rand_pick_one_spawn_mon_pos() failed!! SceneNo:~p", [SceneNo]),
            none;
        AreaList ->
            ?ASSERT(is_list(AreaList), SceneNo),
            % 先随机挑一个刷怪区域
            Rand = util:rand(1, length(AreaList)),
            Area = lists:nth(Rand, AreaList),
            {_AreaNo, X, Y, Width, Height} = Area,

            X_Max = lib_scene:get_width(SceneObj),
            Y_Max = lib_scene:get_height(SceneObj),

            ?ASSERT(X =< X_Max andalso Y =< Y_Max, SceneNo),

            X_Start = X,
            X_End = min(X + Width, X_Max), % 为避免超出范围，故矫正，下同

            Y_Start = Y,
            Y_End = min(Y + Height, Y_Max),

            RetX = util:rand(X_Start, X_End),
            RetY = util:rand(Y_Start, Y_End),

            {RetX, RetY}
    end.

    



%% 从场景的指定刷怪区域中随机挑一个刷怪点
%% @return: {X, Y} | none
rand_pick_one_spawn_mon_pos(SceneObj, SpawnMonAreaNo) ->
    SceneNo = lib_scene:get_no(SceneObj),
    SceneTpl = mod_scene_tpl:get_tpl_data(SceneNo),
    case mod_scene_tpl:get_spawn_mon_area_list(SceneTpl) of
        [] ->
            ?ASSERT(false, SceneNo), % 目前严格些，断言失败！
            ?WARNING_MSG("rand_pick_one_spawn_mon_pos() failed!! SceneNo:~p, SpawnMonAreaNo:~p", [SceneNo, SpawnMonAreaNo]),
            none;
        AreaList ->
            ?ASSERT(is_list(AreaList), SceneNo),
            case lists:keyfind(SpawnMonAreaNo, 1, AreaList) of
                false ->
                    ?ASSERT(false, {SceneNo, SpawnMonAreaNo}),
                    ?WARNING_MSG("rand_pick_one_spawn_mon_pos() failed!! SceneNo:~p, SpawnMonAreaNo:~p", [SceneNo, SpawnMonAreaNo]),
                    none;
                Area ->
                    {SpawnMonAreaNo, X, Y, Width, Height} = Area,

                    X_Max = lib_scene:get_width(SceneObj),
                    Y_Max = lib_scene:get_height(SceneObj),

                    ?ASSERT(X =< X_Max andalso Y =< Y_Max, SceneNo),                    

                    X_Start = X,
                    X_End = min(X + Width, X_Max), % 为避免超出范围，故矫正，下同

                    Y_Start = Y,
                    Y_End = min(Y + Height, Y_Max),

                    RetX = util:rand(X_Start, X_End),
                    RetY = util:rand(Y_Start, Y_End),

                    {RetX, RetY}
            end
    end.

    

%% 20191121 策划不再维护刷怪点区域，所以要从新弄个接口获取一个随机坐标来刷怪，要求刷在非阻挡位置，目前想到的做法是在mask随机？
rand_pick_one_spawn_mon_pos_all(SceneNo) ->
	SceneTpl = mod_scene_tpl:get_tpl_data(SceneNo),
	X_Max = lib_scene:get_width(SceneTpl),
	Tuple = data_mask:get(SceneNo),
	List = tuple_to_list(Tuple),
	L = [?BLOCK_T_NONE, ?BLOCK_T_TRAP, ?BLOCK_T_SAFE, ?BLOCK_T_LEITAI],
	{PosL, _} = 
		lists:foldl(fun(Flag, {Acc, N}) ->
							case lists:member(Flag, L) of
								?true ->
									{[N|Acc], N + 1};
								?false ->
									{Acc, N + 1}
							end
					end, {[], 1}, List),
	Pos = list_util:rand_pick_one(PosL),
	X = Pos rem X_Max - 1,
	Y = Pos div X_Max,
	{X, Y}.
%% 	{X, Y, lib_scene:to_server_xy_index(SceneTpl, X, Y),Pos, lib_scene:is_xy_valid(SceneTpl, X, Y)}.
	
	











% %% 玩家移动后的额外处理（如：判定是否触发暗雷）
% post_player_move(PS, NewPos) ->
%     % ?TRACE("post_obj_move(), NewPos=~p~n", [NewPos]),
%     case player:is_in_team(PS)
%     andalso (not player:is_leader(PS)) 
%     andalso (not player:is_tmp_leave_team(PS)) of
%         true ->
%             skip;
%         false ->
%             ply_scene:try_trigger_trap(PS, NewPos)
%     end.

            
    





%% 构造teleporter结构体
make_teleporter_rd(TeleportNo, SceneId, X, Y) ->
    #teleporter{
        teleport_no = TeleportNo,   % 对应的传送编号
        scene_id = SceneId,         % 所在的场景id
        x = X,                      % 所在的X坐标
        y = Y                       % 所在的Y坐标
        }.












notify_dynamic_teleporter_spawned_to_scene(Teleporter) ->
    ?TRACE("notify_dynamic_teleporter_spawned_to_scene(), Teleporter=~w~n", [Teleporter]),
    SceneId = Teleporter#teleporter.scene_id,
    %%X = Teleporter#teleporter.x,
    %%Y = Teleporter#teleporter.y,
    {ok, Bin} = pt_12:write(?PT_NOTIFY_DYNAMIC_TELEPORTER_SPAWNED, Teleporter),
    lib_send:send_to_scene(SceneId, Bin).
    
    


notify_dynamic_teleporter_cleared_from_scene(Teleporter) ->
    ?TRACE("notify_dynamic_teleporter_cleared_from_scene(), Teleporter=~w~n", [Teleporter]),
    SceneId = Teleporter#teleporter.scene_id,
    %%X = Teleporter#teleporter.x,
    %%Y = Teleporter#teleporter.y,
    {ok, Bin} = pt_12:write(?PT_NOTIFY_DYNAMIC_TELEPORTER_CLEARED, Teleporter),
    lib_send:send_to_scene(SceneId, Bin).
