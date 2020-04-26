%%%-----------------------------------
%%% @Module  : lib_dungeon
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2013.10
%%% @Description: 副本函数
%%%-----------------------------------
-module(lib_dungeon).

-include("common.hrl").
-include("record.hrl").
-include("dungeon.hrl").
-include("player.hrl").
-include("scene.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("sys_code.hrl").
-include("proc_name.hrl").
-include("attribute.hrl").
-include("reward.hrl").
-include("tower.hrl").
-include("record/goods_record.hrl").

% -export([insert_role_dungeon/1
%         ,can_create_dungeon/3
%         ,exec_condition/4
%         ,exec_action/3
%         ,dun_debug/2
%         ,dungeon_login/1
%         ,dungeon_logout/2
%         ,get_npc_dungeon_list/1
%         ,quit_dungeon/1
%         ,insert_new_role_dungeon/3
%         ,update_role_dungeon/1
%         ,get_role_dungeon_cd_info/2
%         ,create_dungeon/2
%         ,get_role_dungeon_mem_info/2
%         ,listen_state_list_del/2
%         ,db_update_dungeon/1
%         ]).
-compile(export_all).
%% ====================================================================
%% API functions
%% ====================================================================
%% @return true | {false, Errcode}
cost_dungeon_props(Status, DunNo) when is_record(Status, player_status) ->
    RoleId = player:id(Status),
    case player:is_in_team(Status) of
        true -> 
            case player:is_leader(Status) of
                false -> {false, [{RoleId, ?ERROR}]};
                true -> 
                    IdList = mod_team:get_normal_member_id_list(player:get_team_id(Status)),
                    case cost_dungeon_props_1(RoleId, [Id || Id <- IdList, Id =/= RoleId], DunNo) of
                        true -> true;
                        {false, Code} -> {false, Code};
                        {true, List} -> [mod_team:kick_out_member(Status, TargetId) || TargetId <- List, TargetId =/= RoleId], true
                    end
            end;
        false -> 
            case can_consume_props(RoleId, DunNo) of
                true -> ?BIN_PRED(consume_props(RoleId, DunNo), true, {false, [{RoleId, ?NOT_ENGOUTH_DUN_PROPS}]});
                false -> {false, [{RoleId, ?NOT_ENGOUTH_DUN_PROPS}]}
            end
    end;
cost_dungeon_props(_, _) -> {false, [{0, ?ERROR}]}.


%% @return : true | {false, [{RoleId, ErrCode}|_]} | {true, [KickId]}
cost_dungeon_props_1(CaptainId, [], DunNo) ->
    case can_consume_props(CaptainId, DunNo) of
        true -> ?BIN_PRED(consume_props(CaptainId, DunNo), true, {false, [{CaptainId, ?NOT_ENGOUTH_DUN_PROPS}]});
        false -> {false, [{CaptainId, ?NOT_ENGOUTH_DUN_PROPS}]}
    end;
cost_dungeon_props_1(CaptainId, MemberIdList, DunNo) ->
    case can_consume_props(CaptainId, DunNo) of
        false -> {false, [{CaptainId, ?NOT_ENGOUTH_DUN_PROPS}]};
        true -> 
            F = fun(RoleId, Count) ->
                case can_consume_props(RoleId, DunNo) of
                    true -> Count;
                    false -> [RoleId | Count]
                end
            end,
            case lists:foldl(F, [], MemberIdList) of
                [] -> 
                    case consume_props(CaptainId, DunNo) of
                        false -> {false, [{CaptainId, ?NOT_ENGOUTH_DUN_PROPS}]};
                        true -> 
                            F1 = fun(RoleId, Count) ->
                                case consume_props(RoleId, DunNo) of 
                                    true -> Count;
                                    false -> [RoleId | Count]
                                end
                            end,
                            case lists:foldl(F1, [], MemberIdList) of
                                [] -> true;
                                KickList -> {true, KickList}
                            end
                    end;
                FailList -> {false, [{T, ?NOT_ENGOUTH_DUN_PROPS} || T <- FailList]}
            end
    end.


%% @doc 是否需要消耗英雄令
%% @return : boolean()
is_need_to_consume_props(RoleId, DunNo) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) ->
            Dun = get_config_data(DunNo),
            % Times = get_dungeon_used_times(RoleId, Dun),
            Times = get_update_dungeon_used_times(Status, util:unixtime(), Dun),
            Times >= get_free_dun_times(Status, Dun);
        _ -> true
    end.


can_consume_props(RoleId, DunNo) ->
    case is_need_to_consume_props(RoleId, DunNo) of
        false -> true;
        true -> mod_inv:get_goods_count_in_bag_by_no(RoleId, ?BOND_RESUME_ITEM) > 0,
            true
    end.


consume_props(RoleId, DunNo) ->
    Dun = get_config_data(DunNo),
    case is_need_to_consume_props(RoleId, DunNo) of
        false -> true;
        true -> mod_inv:destroy_goods_WNC(RoleId, [{?BOND_RESUME_ITEM, 1}], [?LOG_DUNGEON, Dun#dungeon_data.group])
    end.


had_enough_dun_props(Status) ->
    mod_inv:get_goods_count_in_bag_by_no(player:id(Status), ?BOND_RESUME_ITEM) > 0,
    true.


%% @return true | {false, Errcode}
% resume_dungeon_cd(Status, Group) ->
%     RoleId = player:id(Status),
%     case get_dungeon_cd(RoleId, Group) of
%         Rd when is_record(Rd, dungeon_cd) ->
%             TimeStamp = util:unixtime(),
%             Times = Rd#dungeon_cd.times,
%             case Times >= get_max_dun_times(Status, Group) of
%                 true -> {false, ?PM_DUNGEON_TIMES_OVERFLOW};
%                 false ->
%                     case mod_inv:get_goods_count_in_bag_by_no(RoleId, ?BOND_RESUME_ITEM) > 0 of
%                         true ->
%                             case mod_inv:destroy_goods_WNC(RoleId, [{?BOND_RESUME_ITEM, 1}], [?LOG_DUNGEON, Group]) of
%                                 true -> update_dungeon_cd(Rd#dungeon_cd{times = Times - 1, timestamp = TimeStamp}),
%                                         true;
%                                 false -> {false, ?PM_UNKNOWN_ERR}
%                             end;
%                         false -> 
%                             case mod_inv:get_goods_count_in_bag_by_no(RoleId, ?UN_BOND_RESUME_ITEM) > 0 of
%                                 true ->
%                                     case mod_inv:destroy_goods_WNC(RoleId, [{?UN_BOND_RESUME_ITEM, 1}], [?LOG_DUNGEON, Group]) of
%                                         true -> update_dungeon_cd(Rd#dungeon_cd{times = Times - 1, timestamp = TimeStamp}),
%                                                 true;
%                                         false -> {false, ?PM_UNKNOWN_ERR}
%                                     end;
%                                 false -> {false, ?PM_GOODS_NOT_EXISTS}
%                             end
%                     end
%             end;
%         _ -> {false, ?PM_UNKNOWN_ERR}
%     end.


%% @retrurn [dungeonNO]
get_same_group_dungeon_no(Group) ->
    NoList = data_dungeon:get_nos(),
    [No || No <- NoList, (get_config_data(No))#dungeon_data.group =:= Group].


%% @spec create_dungeon -> true | {false, ErrCode}
create_dungeon(DunNo, Status) ->
    TimeStamp = util:unixtime(),
    RoleId = player:id(Status),
    % ?LDS_TRACE(create_dungeon, [DunNo]),
    case enter_dungeon_check(DunNo, player:get_PS(RoleId)) of
        {true, IdList} ->
            gen_server:cast(?DUNGEON_MANAGE, {'create_dungeon', DunNo, TimeStamp, RoleId, IdList}),
            {true, ?SUCCESS};
        {false, Resaon} ->
            {false, Resaon}
    end.


%% @retrun {true, [IdList]} | {false, [{Id, ErrCode}]}
can_create_dungeon(DunNo, TimeStamp, Status) ->
    % Dun = get_config_data(DunNo),
    case get_config_data(DunNo) of
        Dun when is_record(Dun, dungeon_data) ->
            case Dun#dungeon_data.listener of
                [] -> {false, [{player:id(Status), ?ERROR}]};
                _ ->
                    case team_limit(Dun, Status) of
                        false -> {false, [{player:id(Status), ?TEAM_LIMIT}]};
                        {true, IdList} ->
                            F = fun(Rid, Sum) ->
                                    Rps = player:get_PS(Rid),
                                    case role_dungeon_limit(Rps, Dun) of
                                        true ->
                                            case role_dungeon_cd(Rid, Dun, TimeStamp) of
                                                {_, true} -> Sum;
                                                {_, ErrCode} -> [{Rid, ErrCode} | Sum]
                                            end;
                                        {false, ErrCode} ->
                                            [{Rid, ErrCode} | Sum]
                                    end
                                end,
                            Count = lists:foldl(F, [], IdList),
                            ?BIN_PRED(Count =:= [], {true, IdList}, {false, Count})
                    end
            end;
        Other ->
            ?ERROR_MSG("dungeon config error dunNO = ~p, record = ~p~n", [DunNo, Other]),
            {false, [{player:id(Status), ?ERROR}]}
    end.


enter_dungeon_check(DunNo, Status) ->
    case get_config_data(DunNo) of
        Dun when is_record(Dun, dungeon_data) ->
            case Dun#dungeon_data.listener of
                [] -> {false, [{player:id(Status), ?ERROR}]};
                _ ->
                    case team_limit(Dun, Status) of
                        false -> {false, [{player:id(Status), ?TEAM_LIMIT}]};
                        {true, IdList} -> {true, IdList}
                    end
            end;
        Other -> 
            ?ERROR_MSG("dungeon config error dunNO = ~p, record = ~p~n", [DunNo, Other]),
            {false, [{player:id(Status), ?ERROR}]}
    end.

% all_role_dungeon_cd(IdList, Dun, NowStamp) ->
%     all_role_dungeon_cd(IdList, Dun, NowStamp, []).

% all_role_dungeon_cd([], _Dun, _NowStamp, R) -> {true, R};
% all_role_dungeon_cd([Id | Left], Dun, NowStamp, R) ->
%     case role_dungeon_cd(Id, Dun, NowStamp) of
%         {_, false, _} -> {false, ?CD_LIMIT};
%         {Type, true, _} -> all_role_dungeon_cd(Left, Dun, NowStamp, [{Id, Type, NowStamp} | R])
%     end.

%% 副本内传送阵传送
do_dungeon_teleport(Status, TpNo, Dun) ->
    case ply_scene:check_teleport(Status, TpNo) of
        ok ->
            TelepCfg = ply_scene:get_teleport_cfg_data(TpNo),
            case lists:keyfind(TelepCfg#teleport.target_scene_no, 1, Dun#dungeon.map_index) of
                {_, SceneId} ->
                    {X, Y} = TelepCfg#teleport.target_xy,
                    gen_server:cast(player:get_pid(Status), {'do_teleport', SceneId, X, Y});
                    % ply_scene:do_teleport(Status, SceneId, X, Y);
                false -> 
                    lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR)
            end;
        {fail, Reason} ->
            lib_send:send_prompt_msg(Status, Reason)
    end.


%% 是否在副本中(副本进程内使用)
%% @retrun : true | false
is_in_dungeon(Dun, Status) ->
    lists:member(player:id(Status), Dun#dungeon.actives).

%% @doc 退出副本 
quit_dungeon(Status) ->
    case player:is_in_dungeon(Status) of
        {true, Pid} -> gen_server:cast(Pid, {'quit_dungeon', Status});
        _ -> 
            ply_scene:goto_host_city(Status),
            {ok, BinData} = pt_57:write(57002, [?SUCCESS]),
            lib_send:send_to_sock(Status#player_status.socket, BinData)
    end.


close_dungeon(Pid) when is_pid(Pid) -> Pid ! 'close_dungeon';
close_dungeon(_) -> skip.


%% 从当前副本转移到另一个副本
transfer_dungeon(Status, ToDunPid) ->
    case player:is_in_dungeon(Status) of
        {true, Pid} -> gen_server:cast(Pid, {'transfer_dungeon', ToDunPid, player:id(Status)});
        _ -> skip
    end.


%% 通知副本组队里更换队长
notify_dungeon_change_captain(NewCaptainStatus) ->
    case player:is_in_dungeon(NewCaptainStatus) of
        false -> skip;
        {true, DunPid} when is_pid(DunPid) ->  
            gen_server:cast(DunPid, {'change_captain', player:id(NewCaptainStatus)});
        _ -> ?ASSERT(false)
    end.

%% 通知副本组队里成员退出
notify_dungeon_quit_team(Status) ->
    case player:is_in_dungeon(Status) of
        false -> skip;
        {true, DunPid} when is_pid(DunPid) -> 
            gen_server:cast(DunPid, {'quit_team', player:id(Status)})
    end.

notify_dungeon_quit_team(Status, CaptainId) ->
    case player:is_in_dungeon(Status) of
        false -> skip;
        {true, DunPid} when is_pid(DunPid) -> 
            gen_server:cast(DunPid, {'quit_team', player:id(Status), CaptainId})
    end.


%% ==================================================================================
%% condition
%% ==================================================================================

% %% @执行监听器 retrun: true | false
% exec_listener(Listener, Dungeon, [EventType, Args]) ->
%     case exec_conditions(Listener#listener.condition, Dungeon, [EventType, Args]) of
%         true ->
%             exec_actions(Listener#listener.action, Dungeon, [EventType, Args]),
%             true;    %% @redo ??
%         false ->
%             false
%     end.

% %% ==================================================================================
% %% condition
% %% ==================================================================================
% %% 条件监听对象只能为个人/队长/副本自身
% exec_conditions([], _, _) -> true;
% exec_conditions([Con | Left], Dungeon, [EventType, Args]) ->
%     BuilderId = Dungeon#dungeon.builder,
%     case get_id_by_object(Con#condition.object, BuilderId) of
%         false -> false;
%         [_, _ | _] -> false;
%         List ->
%             case exec_condition(Con#condition.type, Con, List, Dungeon, [EventType, Args]) of
%                 true -> exec_conditions(Left, Dungeon, [EventType, Args]);
%                 false -> false
%             end
%     end.

% exec_condition(Type, Con, Id) when is_integer(Id) ->
%     case get_id_by_object(Con#condition.object, Id) of
%         false -> false;
%         Val -> exec_condition(Type, Con, Val)
%     end;

% exec_condition(Type, Con, [EventType, Args], Dungeon) ->
%     BuilderId = Dungeon#dungeon.builder,
%     case get_id_by_object(Con#condition.object, BuilderId) of
%         false -> false;
%         [_, _ | _] -> false;
%         List ->
%             exec_condition(Type, Con, List, Dungeon, [EventType, Args])
%     end.    


%% 执行具体监听条件
%% @return : NewCon
exec_condition(EventType, Con, Dun, Args) ->
    case get_id_by_object(Con#condition.object, Dun#dungeon.builder, Dun#dungeon.actives) of
        false -> ?ERROR_MSG("get_id_by_object false", []), Dun#dungeon.pid ! 'close_dungeon',  Con;
        [RoleId | _] -> exec_condition(EventType, Con, Dun, RoleId, Args)
    end.


%% 具体条件处理  条件监听对象只能为个人/队长/副本自身
%% @return : NewCon

%% 任务可接
exec_condition(?TASK_CAN_ACCEPT_EVENT, Con, _, _, [?TASK_CAN_ACCEPT_EVENT, [TaskId]]) ->
    % TargetList = Con#condition.target,
    Con#condition{target = lists:delete(TaskId, Con#condition.target)};
exec_condition(?TASK_CAN_ACCEPT_EVENT, Con, _, RoleId, ?AHEAD_CHECK) ->
    TargetList = Con#condition.target,
    F = fun(TaskId, List) ->
            case lib_task:publ_is_can_accept(TaskId, RoleId) of
                true -> List;
                false -> [TaskId | List]
            end
        end,
    NewList = lists:foldl(F, [], TargetList),
    Con#condition{target = NewList};

%% 指定任务已领取
exec_condition(?TASK_ACCEPTED_EVENT, Con, _, _, [?TASK_ACCEPTED_EVENT, [TaskId]]) ->
    % [TargetId] = Con#condition.target,
    Con#condition{target = lists:delete(TaskId, Con#condition.target)};
    % lib_task:publ_is_accepted(TaskId, RoleId);
exec_condition(?TASK_ACCEPTED_EVENT, Con, _, RoleId, ?AHEAD_CHECK) ->
    % [TaskId] = Con#condition.target,
    % lib_task:publ_is_accepted(TaskId, RoleId);
    TargetList = Con#condition.target,
    F = fun(TaskId, List) ->
            case lib_task:publ_is_accepted(TaskId, RoleId) of
                true -> List;
                false -> [TaskId | List]
            end
        end,
    NewList = lists:foldl(F, [], TargetList),
    Con#condition{target = NewList};

%% 指定任务目标已达成
exec_condition(?TASK_COMPLETED_EVENT, Con, _, _, [?TASK_COMPLETED_EVENT, [TaskId]]) ->
    % [TargetId] = Con#condition.target,
    % TargetId =:= TaskId;
    Con#condition{target = lists:delete(TaskId, Con#condition.target)};
% exec_condition(?TASK_COMPLETED_EVENT, Con, _, RoleId, ?AHEAD_CHECK) ->
%     % [TaskId] = Con#condition.target,
%     % lib_task:publ_is_completed(TaskId, RoleId);
%     TargetList = Con#condition.target,
%     F = fun(TaskId, List) ->
%             case lib_task:publ_is_completed(TaskId, RoleId) of
%                 true -> List;
%                 false -> [TaskId | List]
%             end
%         end,
%     NewList = lists:foldl(F, [], TargetList),
%     Con#condition{target = NewList};

%% 指定任务已提交
exec_condition(?TASK_SUBMIT_EVENT, Con, _, _, [?TASK_SUBMIT_EVENT, [TaskId]]) ->
    % [TargetId] = Con#condition.target,
    % TargetId =:= TaskId;
    Con#condition{target = lists:delete(TaskId, Con#condition.target)};
% exec_condition(?TASK_SUBMIT_EVENT, Con, _, RoleId, ?AHEAD_CHECK) ->
%     % [TaskId] = Con#condition.target,
%     % lib_task:publ_is_submit(TaskId, RoleId);
%     TargetList = Con#condition.target,
%     F = fun(TaskId, List) ->
%             case lib_task:publ_is_submit(TaskId, RoleId) of
%                 true -> List;
%                 false -> [TaskId | List]
%             end
%         end,
%     NewList = lists:foldl(F, [], TargetList),
%     Con#condition{target = NewList};

%% 指定任务已失败
exec_condition(?TASK_FAIL_EVENT, Con, _, _, [?TASK_FAIL_EVENT, [TaskId]]) ->
    % [TargetId] = Con#condition.target,
    % TargetId =:= TaskId;
    Con#condition{target = lists:delete(TaskId, Con#condition.target)};
% exec_condition(?TASK_FAIL_EVENT, Con, _, RoleId, ?AHEAD_CHECK) ->
%     % [TaskId] = Con#condition.target,
%     % lib_task:publ_is_fail(TaskId, RoleId);
%     TargetList = Con#condition.target,
%     F = fun(TaskId, List) ->
%             case lib_task:publ_is_fail(TaskId, RoleId) of
%                 true -> List;
%                 false -> [TaskId | List]
%             end
%         end,
%     NewList = lists:foldl(F, [], TargetList),
%     Con#condition{target = NewList};

%% 包裹中有指定物品
exec_condition(?HAVE_BAG_ITEM, Con, _, _RoleId, [?HAVE_BAG_ITEM, [ItemNo]]) ->
    % [TargetId | _] = Con#condition.target,
    % TargetId =:= ItemNo;
    Con#condition{target = lists:delete(ItemNo, Con#condition.target)};
exec_condition(?HAVE_BAG_ITEM, Con, _, RoleId, ?AHEAD_CHECK) ->
    ItemList = Con#condition.target,
    case mod_inv:has_goods_in_bag_by_no(RoleId, ItemList) of
        true -> Con#condition{target = []};
        false -> Con
    end;

%% 携带了某宠物
exec_condition(?TAKE_PET, Con, _, _RoleId, [?TAKE_PET, [PetNo]]) ->
    % [TargetId | _] = Con#condition.target,
    % TargetId =:= PetNo;
    Con#condition{target = lists:delete(PetNo, Con#condition.target)};
exec_condition(?TAKE_PET, Con, _, RoleId, ?AHEAD_CHECK) ->
    PetList = Con#condition.target,
    TakePet = lib_partner:get_partner_no_list(RoleId),
    case util:list_member(PetList, TakePet) of
        true -> Con#condition{target = []};
        false -> Con
    end;

% %% 拥有指定数量金钱
% exec_condition(?HAVE_MONEY, Con, _, RoleId, ?AHEAD_CHECK) ->
%     [Number] = Con#condition.target,
%     Status = player:get_PS(RoleId),
%     Number =:= (player:get_gamemoney(Status) + player:get_bind_gamemoney(Status));

% %% 在副本场景中
% exec_condition(?IN_DUNGEON, Con, Dungeon, _, _) ->
%     [DunNo] = Con#condition.target,
%     DunNo =:= Dungeon#dungeon.no;


%% 在普通场景中 
% exec_condition(?IN_SCENE, Con, [RoleId], Dungeon) ->
%     [SceneId] = Con#condition.target,

%% 在某张地图的某个位置上
exec_condition(?IN_POSITION, Con, Dungeon, RoleId, [?IN_POSITION, []]) ->
    F = fun({SceneNo, ExpId}, List) ->
            case is_in_explore_area(RoleId, SceneNo, ExpId, Dungeon) of
                true -> List;
                false -> [{SceneNo, ExpId} | List]
            end
        end,
    NewList = lists:foldl(F, [], Con#condition.target),
    Con#condition{target = NewList};
    % Pos = player:get_position(RoleId),
    % Pos#plyr_pos.scene_id =:= No andalso 
    %     Pos#plyr_pos.x =:= X andalso
    %     Pos#plyr_pos.y =:= Y.
    
%% 指定战斗已经胜利
exec_condition(?BATTLE_WIN, Con, _Dungeon, _, [?BATTLE_WIN, [MonGid]]) ->
    % [TargetId] = Con#condition.target,
    % TargetId =:= MonGid;
    Con#condition{target = lists:delete(MonGid, Con#condition.target)};

%% 随机战斗已经胜利
exec_condition(?RAND_BATTLE_WIN, Con, _Dungeon, _, [?RAND_BATTLE_WIN, [MonGid]]) ->
    ?LDS_TRACE(?RAND_BATTLE_WIN, {MonGid}),
    case lists:member(MonGid, Con#condition.target) of
        true -> Con#condition{target = []};
        false -> Con
    end;


%% 指定怪物组ID已杀
exec_condition(?BATTLE_WIN_GROUP, Con, _Dungeon, _, [?BATTLE_WIN_GROUP, [MonGid]]) ->
    % [TargetId] = Con#condition.target,
    % TargetId =:= MonGid;
    ?LDS_TRACE(?BATTLE_WIN_GROUP, {MonGid, lists:delete(MonGid, Con#condition.target)}),
    Con#condition{target = lists:delete(MonGid, Con#condition.target)};

%% 随机战斗已经胜利
exec_condition(?RAND_BATTLE_WIN_GROUP, Con, _Dungeon, _, [?RAND_BATTLE_WIN_GROUP, [MonGid]]) ->
    ?LDS_TRACE(?RAND_BATTLE_WIN_GROUP, {group_id, MonGid}),
    case lists:member(MonGid, Con#condition.target) of
        true -> Con#condition{target = []};
        false -> Con
    end;


%% 指定战斗已经失败
exec_condition(?BATTLE_FAIL, Con, _Dungeon, _, [?BATTLE_FAIL, [MonGid]]) ->
    % [TargetId] = Con#condition.target,
    % TargetId =:= MonGid;
    Con#condition{target = lists:delete(MonGid, Con#condition.target)};

%% 指定怪物组ID已经失败
exec_condition(?BATTLE_FAIL_GROUP, Con, _Dungeon, _, [?BATTLE_FAIL_GROUP, [MonGid]]) ->
    % [TargetId] = Con#condition.target,
    % TargetId =:= MonGid;
    Con#condition{target = lists:delete(MonGid, Con#condition.target)};
    

%% 客户端战斗结束
exec_condition(?CLIENT_BATTLE_END, Con, _Dungeon, _, [?CLIENT_BATTLE_END, []]) ->
    Con#condition{target = []};


%% 指定动画播放完成
exec_condition(?PLOT_FINISH, Con, _Dungeon, _, [?PLOT_FINISH, [_]]) ->
    redo,
    Con;

%% 前往下一层爬塔副本
exec_condition(?NEXT_FLOOR, Con, _, _RoleId, [?NEXT_FLOOR, []]) ->
    % [NextFloor] = Con#condition.target,
    % lib_tower:set_next_floor(RoleId, NextFloor),

    Con#condition{target = []};   

%% 获得指定奖励包
exec_condition(?GET_ASSIGN_REWARD, Con, _, _RoleId, [?GET_ASSIGN_REWARD, [Rid]]) ->
    Con#condition{target = lists:delete(Rid, Con#condition.target)};


%% 计时是否到期
exec_condition(?DUN_TIMER_TIMEOUT, Con, _, _, [?DUN_TIMER_TIMEOUT, [Time]]) ->
    ?LDS_DEBUG(?DUN_TIMER_TIMEOUT),
    Con#condition{target = lists:delete(Time, Con#condition.target)};


%% 副本点数到达阈值
exec_condition(?DUN_POINTS_THRESHOLD, Con, _, _, [?DUN_POINTS_THRESHOLD, [Points]]) ->
    [Threshold | _] = Con#condition.target,
    CurPoints = case get(?DUN_POINTS_THRESHOLD) of
        undefined -> Points;
        P -> P + Points
    end,
    ?LDS_TRACE("DUN_POINTS_THRESHOLD", CurPoints),
    put(?DUN_POINTS_THRESHOLD, CurPoints),
    case CurPoints >= Threshold of
        true -> Con#condition{target = []};
        false -> Con
    end;


%% 副本到达限定层数 (系统指定限定层数)
exec_condition(?DUN_MAX_FLOOR, Con, _, _, [?DUN_MAX_FLOOR, _]) ->
    Con#condition{target = []};

%% 副本未到达限定层数 (系统指定限定层数)
exec_condition(?DUN_NOT_MAX_FLOOR, Con, _, _, [?DUN_NOT_MAX_FLOOR, _]) ->
    Con#condition{target = []};

%% 世界BOSS被击杀
exec_condition(?DUNGEON_BOSS_KILLED, Con, _, _, [?DUNGEON_BOSS_KILLED, [MonNo]]) ->
    Con#condition{target = lists:delete(MonNo, Con#condition.target)};

exec_condition(_, Con, _Dungeon, _, _) -> 
    Con.


%% ===================== condition end ===============================

is_in_explore_area(RoleId, SceneNo, ExploreId, Dun) ->
    Pos = player:get_position(RoleId),
    case get_explore_area(SceneNo, ExploreId) of
        {ExploreId, OldX, OldY, Width, Height} ->
            case lists:keyfind(Pos#plyr_pos.scene_id, 2, Dun#dungeon.map_index) of
                false -> false;
                {NowSceneNo, _} ->
                    is_in_same_range({SceneNo, OldX, OldY, Width, Height}, {NowSceneNo, Pos#plyr_pos.x, Pos#plyr_pos.y})
            end;
        false -> false
    end.


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

%% ==================================================================================
%% action
%% ==================================================================================
% exec_actions([Action | Left], Dungeon) ->
%     case exec_action(Action, Dungeon) of
%         true -> skip;
%         false -> 
%             ?ERROR_MSG("dungeon exec action error dungeon record = ~p, action = ~p~n",
%                 [Dungeon, Action]),
%             ?DUN_DEBUG(io:format(<<"exec action fail, dungeon = ~p, action = ~p~n", 
%                 [Dungeon, Action]>>), Dungeon#dungeon.builder)
%     end,
%     exec_actions(Left, Dungeon).


% %% @ retrun true | false
% exec_action(Action, Dungeon) ->
%     exec_action(Action#action.type, Action, Dungeon).

exec_action(Type, Action, Dungeon) ->
    case get_id_by_object(Action#action.object, Dungeon#dungeon.builder, Dungeon#dungeon.actives) of
        false -> ?ERROR_MSG("get_id_by_object false", []), Dungeon#dungeon.pid ! 'close_dungeon', {false, Dungeon};
        Val -> exec_action(Type, Action, Val, Dungeon)
    end.

%% 具体事件处理
%% 添加副本监听器
exec_action(?PUSH_ID, Action, _Object, Dungeon) ->
    {true, Dungeon, {push, Action#action.target}};
    % [Id] = Action#action.target,
    % ListenerList = Dungeon#dungeon.listening,
    % F = fun(Listener, Sum) ->
    %         case Listener#listen_state.id =:= Id of
    %             true -> Sum + 1;
    %             false -> Sum
    %         end
    %     end,
    % Count = lists:foldl(F, 0, ListenerList),
    % case Count > 0 of
    %     true -> 
    %         ?ERROR_MSG("dungeon push id error", []), 
    %         % ?ASSERT(false),
    %         {error, Dungeon};
    %     false -> {true, Dungeon, {push, Action#action.target}}
    % end;

%% 删除副本监听器
exec_action(?POP_ID, Action, _Object, Dungeon) ->
    {true, Dungeon, {pop, Action#action.target}};

%% 恢复所有血蓝
exec_action(?RESUME_HP_MP, _Action, RoleList, Dungeon) ->
    F = fun(RoleId) ->
            Status = player:get_PS(RoleId),
            player:set_full_hp_mp(Status)
        end,
    lists:foreach(F, RoleList),
    {true, Dungeon};

%% 打开一个特定界面
exec_action(?OPEN_PANEL, Action, RoleList, Dungeon) ->
    TargetList = Action#action.target,
    [gen_server:cast(player:get_pid(RoleId), {'open_penal', PenalId}) || RoleId <- RoleList, PenalId <- TargetList],
    {true, Dungeon};

%% 添加一个指定ID的BUFF
exec_action(?ADD_BUFF, Action, RoleList, Dungeon) ->
    TargetList = Action#action.target,
    F = fun(RoleId1, BuffId1) -> 
            lib_buff:player_add_buff(RoleId1, BuffId1)
        end,
    [F(RoleId, BuffId) || RoleId <- TargetList, BuffId <- RoleList],
    {true, Dungeon};

%% 去掉指定ID的BUFF
exec_action(?DEL_BUFF, Action, RoleList, Dungeon) ->
    TargetList = Action#action.target,
    F = fun(RoleId1, BuffId1) -> 
            lib_buff:player_del_buff(RoleId1, BuffId1)
        end,
    [F(RoleId, BuffId) || RoleId <- TargetList, BuffId <- RoleList],
    {true, Dungeon};

%% 传送出副本
exec_action(?CONVEY_OUT_DUN, _Action, RoleList, Dungeon) ->
    F = fun(RoleId, Dun) ->
            {_, NewDun} = convey_out_dun(Dun, player:get_PS(RoleId)),
            NewDun
        end,
    NewDungeon = lists:foldl(F, Dungeon, RoleList),
    % [convey_out_dun(Dungeon, player:get_PS(RoleId)) || RoleId <- TargetList],
    {true, NewDungeon};

%% 进入指定ID的战斗
exec_action(?TRIGGER_BATTLE, Action, RoleList, Dungeon) ->
    [MonGNo] = Action#action.target,
    [RoleId | _] = RoleList,
    case get_captain_id(RoleId) of
        false -> {false, Dungeon};
        CaptainId ->
            case lists:member(CaptainId, RoleList) of
                true -> mod_battle:start_mf(player:get_PS(CaptainId), MonGNo, null),
                        {true, Dungeon};
                false -> {false, Dungeon}
            end
    end;

%% 传送到副本外指定地图的指定坐标
exec_action(?CONVEY_SCENE, Action, RoleList, Dungeon) ->
    [{SceneId, X, Y}] = Action#action.target,
    F = fun(RoleId, Dun) ->
        Status = player:get_PS(RoleId),
        case is_in_dungeon(Dun, Status) of
            true -> 
                % ply_scene:do_single_teleport(Status, SceneId, X, Y),
                gen_server:cast(player:get_pid(Status), {'do_single_teleport', SceneId, X, Y}),
                Dun;
            false ->
                {_, NewDun} = convey_out_dun(Dun, Status, {SceneId, {X, Y}}),
                NewDun
        end
    end,
    NewDungeon = lists:foldl(F, Dungeon, RoleList),
    {true, NewDungeon};


%% 传送到副本内指定地图的指定坐标
exec_action(?CONVEY_DUNGEON, Action, RoleList, Dungeon) ->
    [{MapNo, X, Y}] = Action#action.target,
    case lists:keyfind(MapNo, 1, Dungeon#dungeon.map_index) of
        false -> 
            ?ASSERT(false),
            {false, Dungeon};
        {MapNo, SceneId} ->
            F = fun(RoleId) ->
                    case player:get_PS(RoleId) of
                        Status when is_record(Status, player_status) ->
                            case Dungeon#dungeon.lv =/= 0 andalso (player:get_lv(Status) < Dungeon#dungeon.lv) of
                                true -> mod_team_mgr:sys_kick_out_member(player:get_team_id(Status), Status);
                                false ->
                                    %% 如果在爬塔副本中，同时发送爬塔副本界面信息（特殊处理）在传送前发送,提前更新客户端
                                    case is_tower_dungeon(Dungeon#dungeon.no) of
                                        % true -> lib_tower:notify_tower_info(RoleId);
                                        true -> lib_tower:get_tower_dungeon_info(Status);
                                        false -> skip
                                    end,

                                    %% 噩梦爬塔副本中
                                    case is_hardtower_dungeon(Dungeon#dungeon.no) of
                                        true -> lib_hardtower:get_tower_dungeon_info(Status);
                                        false -> skip
                                    end,
                                    gen_server:cast(player:get_pid(Status), {'do_single_teleport', SceneId, X, Y}),
                                    % ply_scene:do_single_teleport(Status, SceneId, X, Y),
                                    send_dungeon_info(RoleId, Dungeon),
                                    
                                    gen_server:cast(player:get_pid(Status), {apply_cast, lib_task, trigger, [Status]})
                            end;
                        _ -> skip
                    end
                end,
            lists:foreach(F, RoleList),
            {true, Dungeon}
    end;

%% 添加指定ID的任务
exec_action(?ADD_TASK, Action, RoleList, Dungeon) ->
    TaskList = Action#action.target,
    F = fun(TaskId) ->
            [gen_server:cast(player:get_pid(RoleId), {'force_accept_task', TaskId}) || RoleId <- RoleList, is_integer(RoleId)]
        end,
    lists:foreach(F, TaskList),
    {true, Dungeon};

%% 添加指定ID的任务
% exec_action(?FORCE_ADD_TASK, Action, RoleList, Dungeon) ->
%     TaskList = Action#action.target,
%     F = fun(TaskId) ->
%             [gen_server:cast(player:get_pid(RoleId), {'force_accept_task', TaskId}) || RoleId <- RoleList, is_integer(RoleId)]
%         end,
%     lists:foreach(F, TaskList),
%     {true, Dungeon};

%% 创建指定ID的NPC
exec_action(?ADD_NPC, Action, _RoleList, Dungeon) ->
    F = fun({NpcNo, MapNo, X, Y}) -> 
            case lists:keyfind(MapNo, 1, Dungeon#dungeon.map_index) of
                false -> ?ASSERT(false);
                {MapNo, SceneId} ->
                    case mod_scene:spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneId, X, Y) of
                        {ok, NpcId} -> put(?DUN_NPC(MapNo, NpcNo, X, Y), NpcId);
                        _ -> ?ASSERT(false)
                    end
            end
        end,
    lists:foreach(F, Action#action.target),
    {true, Dungeon};

%% 删除指定NPC
exec_action(?DEL_NPC, Action, _RoleList, Dungeon) ->
    F = fun({NpcNo, MapNo, X, Y}) ->
            case get(?DUN_NPC(MapNo, NpcNo, X, Y)) of
                NpcId when is_integer(NpcId) -> 
                    mod_scene:clear_dynamic_npc_from_scene_WNC(NpcId),
                    erlang:erase(?DUN_NPC(MapNo, NpcNo, X, Y));
                _ -> ?ASSERT(false)
            end
        end,
    lists:foreach(F, Action#action.target),
    {true, Dungeon};


%% 创建某ID的副本地图
exec_action(?CREATE_MAP, Action, _RoleList, Dungeon) ->
    F = fun(MapNo, Dun) ->
            case mod_scene:create_scene(MapNo) of
                fail -> Dun;
                {ok, SceneId} -> 
                    Index = Dun#dungeon.map_index,
                    Dun#dungeon{map_index = [{MapNo, SceneId} | Index]}
            end
        end,
    NewDun = lists:foldl(F, Dungeon, Action#action.target),
    {true, NewDun};

%% 创建爬塔副本地图，在创建的同时把所有副本场景放进待删除队列中等待删除
exec_action(?CREATE_TOWER_MAP, Action, _RoleList, Dungeon) ->
    put(?WAIT_TO_RECLAIM, Dungeon#dungeon.map_index),
    Dungeon1 = Dungeon#dungeon{map_index = []},      
    F = fun(MapNo, Dun) ->
            case mod_scene:create_scene(MapNo) of
                fail -> Dun;
                {ok, SceneId} -> 
                    Index = Dun#dungeon.map_index,
                    Dun#dungeon{map_index = [{MapNo, SceneId} | Index]}
            end
        end,
    NewDun = lists:foldl(F, Dungeon1, Action#action.target),
    % ?ERROR_MSG("DUNGEON CREATE_MAP = ~p, = ~p~n", [Action#action.target, NewDun#dungeon.map_index]),
    {true, NewDun};


% #action{type = create_guild_map, object=nil, target=[MapNo]}


%% 关闭副本
exec_action(?CLOSE_DUN, _Action, _RoleList, Dungeon) ->
    Dungeon#dungeon.pid ! 'close_dungeon',
    {true, Dungeon};

% %% 在指定ID地图创建指定ID的动态阻挡
% exec_action(?ADD_BLOCK, Action, _RoleList, Dungeon) ->
%     TargetList = Action#action.target,
%     redo,
%     {true, Dungeon};

% %% 在指定ID地图删除指定ID的动态阻挡
% exec_action(?DEL_BLOCK, Action, _RoleList, Dungeon) ->
%     TargetList = Action#action.target,
%     redo,
%     {true, Dungeon};

%% 创建指定ID的传送热区
exec_action(?ADD_CONVEY, Action, _RoleList, Dungeon) ->
    F = fun({TpNo, MapNo, X, Y}) ->
            case lists:keyfind(MapNo, 1, Dungeon#dungeon.map_index) of
                false -> ?ASSERT(false);
                {MapNo, SceneId} -> 
                    case mod_scene:spawn_dynamic_teleporter_to_scene_WNC(TpNo, SceneId, X, Y) of
                        {ok, TpRd} -> put(?DUN_TP(MapNo, TpNo, X, Y), TpRd);
                        _ -> ?ASSERT(false)
                    end
            end
        end,
    lists:foreach(F, Action#action.target),
    {true, Dungeon};

%% 删除指定ID的传送热区
exec_action(?DEL_CONVEY, Action, _RoleList, Dungeon) ->
    F = fun({TpNo, MapNo, X, Y}) -> 
            case get(?DUN_TP(MapNo, TpNo, X, Y)) of
                undefined -> ?ASSERT(false);
                TpRd when is_record(TpRd, teleporter) ->
                    mod_scene:clear_dynamic_teleporter_from_scene_WNC(TpRd),
                    erlang:erase(?DUN_TP(MapNo, TpNo, X, Y));
                _ -> ?ASSERT(false)
            end
        end,
    lists:foreach(F, Action#action.target),
    {true, Dungeon};

%% 添加地图明怪
exec_action(?ADD_SEEMON, Action, _RoleList, Dungeon) ->
    MonList = Action#action.target,
    F = fun({MonNo, MapNo, X, Y}) ->
            case lists:keyfind(MapNo, 1, Dungeon#dungeon.map_index) of
                false -> ?ASSERT(false);
                {MapNo, SceneId} -> 
                    case mod_scene:spawn_mon_to_scene_WNC(MonNo, SceneId, X, Y) of
                        {ok, MonId} -> put(?DUN_MON(MapNo, MonNo, X, Y), MonId);
                        _ -> ?ASSERT(false)
                    end
            end
        end,
    lists:foreach(F, MonList),
    {true, Dungeon};


%% 随机添加一个地图明怪
exec_action(?ADD_RAND_SEEMON, Action, _RoleList, Dungeon) ->
    MonList = Action#action.target,
    Len = erlang:length(MonList),
    ?LDS_DEBUG(add_rand_seemon1, {MonList, Len}),
    case Len > 0 of
        true -> 
            {MonNo, MapNo, X, Y} = lists:nth(util:rand(1, Len), MonList),
            ?LDS_DEBUG(add_rand_seemon2, {MonNo, MapNo, X, Y}),
            case lists:keyfind(MapNo, 1, Dungeon#dungeon.map_index) of
                false -> ?ASSERT(false);
                {MapNo, SceneId} -> 
                    case mod_scene:spawn_mon_to_scene_WNC(MonNo, SceneId, X, Y) of
                        {ok, MonId} -> ?LDS_DEBUG(add_rand_seemon3, {MonId}), put(?DUN_MON(MapNo, MonNo, X, Y), MonId);
                        _ -> ?ASSERT(false)
                    end
            end;
        false -> ?ASSERT(false)
    end,
    {true, Dungeon};


%% 删除一个地图明怪
exec_action(?DEL_SEEMON, Action, _RoleList, Dungeon) ->
    TupList = Action#action.target,
    F = fun({MonNo, MapNo, X, Y}) ->   
            case get(?DUN_MON(MapNo, MonNo, X, Y)) of
                MonId when is_integer(MonId) ->
                    mod_scene:clear_mon_from_scene_WNC(MonId),
                    erlang:erase(?DUN_MON(MapNo, MonNo, X, Y));
                _ -> ?ASSERT(false)
            end
        end,
    [F(X) || X <- TupList],
    {true, Dungeon};

%% 设定副本通关
exec_action(?SET_DUNGEON_PASS, _Action, _RoleList, Dungeon) ->
    DunNo = Dungeon#dungeon.no,
    F = fun(RoleId) ->
        case is_integer(RoleId) of
            false -> skip;
            true -> 
                Flag = set_dungeon_pass(RoleId, Dungeon),
                ?DEBUG_MSG("wujianchengtestdungeonFlag ~p~n",[{Flag,Dungeon#dungeon.had_pass_reward}]),
                case Dungeon#dungeon.had_pass_reward =/= 0 of
                    true -> ?BIN_PRED(Flag, calculate_dungeon_pass(RoleId, Dungeon), skip);
                    false -> skip
                end,
                case player:get_PS(RoleId) of
                    Status when is_record(Status, player_status) ->
                        lib_event:event(pass_dungeon, [DunNo, 1], player:get_PS(RoleId));
                    _ -> skip
                end,
                mod_achievement:notify_achi(pass_dun, [{no, DunNo}], RoleId),
                mod_dungeon_plot:publ_notify_dungeon_pass(DunNo, RoleId)
        end
    end,
    lists:foreach(F, Dungeon#dungeon.actives),
    Dungeon#dungeon.pid ! 'close_dungeon',
    {true, Dungeon#dungeon{pass = ?PASS}};


%% 设定副本通关并且不走副本外围路线
exec_action(?SET_DUNGEON_PASS_2, _Action, _RoleList, Dungeon) ->
    DunNo = Dungeon#dungeon.no,
    F = fun(RoleId) ->
        case is_integer(RoleId) of
            false -> skip;
            true -> 
                set_dungeon_pass(RoleId, Dungeon),
                lib_event:event(pass_dungeon, [DunNo, 1], player:get_PS(RoleId)),
                mod_dungeon_plot:publ_notify_dungeon_pass(DunNo, RoleId)
        end
    end,
    lists:foreach(F, Dungeon#dungeon.actives),
    Dungeon#dungeon.pid ! 'close_dungeon',
    {true, Dungeon#dungeon{pass = ?PASS}};


%% 通关爬塔当层
exec_action(?SET_FLOOR_PASS, Action, _, Dungeon) ->
    % DunNo = Dungeon#dungeon.no,
    RoleId = Dungeon#dungeon.builder,
    [Floor] = Action#action.target,
    case Dungeon#dungeon.no =:= ?TOWER_DUNGEON_NO of
        true ->
            case lib_tower:set_next_floor(RoleId, Floor) of
                true -> catch lib_tower:send_reward(RoleId, Floor);
                _ -> skip
            end;
        false -> 
            skip
    end,

    % 噩梦爬塔
    case lists:member(Dungeon#dungeon.no, ?HARD_TOWER_DUNGEON_NO_LIST) of
        true ->
            case lib_hardtower:set_next_floor(RoleId, Floor) of
                true -> catch lib_hardtower:send_reward(Dungeon#dungeon.no, RoleId, Floor);
                _ -> skip
            end;
        false -> 
            skip
    end,
    
    {true, Dungeon};


%% 回收旧场景资源
exec_action(?RECLAIM_MAP, Action, _, Dungeon) ->
    case Action#action.target of
        [] ->
            case get(?WAIT_TO_RECLAIM) of
                undefined -> 
                    ?ASSERT(false),
                    {false, Dungeon};
                List -> 
                    F = fun(SceneId) ->
                            case lib_scene:is_exists(SceneId) of
                                true -> mod_scene:clear_scene(SceneId);
                                false -> ?ERROR_MSG("dungeon reclaim_map clean scene error MapList = ~p~n", [List])
                            end
                        end,
                    [F(SceneId) || {_, SceneId} <- List],
                    erase(?WAIT_TO_RECLAIM),
                    {true, Dungeon}
            end;
        MapList ->
            F = fun(MapNo, Dun) ->
                case lists:keyfind(MapNo, 1, Dun#dungeon.map_index) of
                    false -> Dun;
                    {MapNo, SceneId} -> 
                        mod_scene:clear_scene(SceneId),
                        NewIndex = lists:keydelete(MapNo, 1, Dun#dungeon.map_index),
                        Dun#dungeon{map_index = NewIndex}
                end
            end,
            NewDun = lists:foldl(F, Dungeon, MapList),
            {true, NewDun}
    end;
            
%% 爬塔到顶层
exec_action(?TOWER_TOP, _Action, _, Dungeon) ->
    redo,
    {true, Dungeon};


%% 添加计时器
exec_action(?ADD_DUN_TIMER, Action, _, Dungeon) ->
    F = fun(Time) ->
        Ref = erlang:start_timer(Time * 1000, Dungeon#dungeon.pid, {?ADD_DUN_TIMER, Time}),
        put(?DUN_TIMER_REF(Time), Ref)
    end,
    lists:foreach(F, Action#action.target),
    {true, Dungeon};


%% 执行地图随机刷怪脚本
exec_action(?REFRESH_DUN_SCRIPT, Action, _, Dungeon) ->
    F = fun({{_, Script}, MapNo}) ->
        case lists:keyfind(MapNo, 1, Dungeon#dungeon.map_index) of
            false -> ?ASSERT(false);
            {MapNo, SceneId} -> lib_guild:refresh_script(Script, sys, SceneId)
        end
    end,
    lists:foreach(F, Action#action.target),
    {true, Dungeon};


%% 清理副本点数
exec_action(?CLEAR_DUN_POINTS, _Action, _, Dungeon) ->
    erase(?DUN_POINTS_THRESHOLD),
    {true, Dungeon};


%% 检查是否到达系统指定限定层
exec_action(?CHECK_DUN_MAX_FLOOR, Action, _, Dungeon) ->
    case get(?DUN_GUILD_MAX_FLOOR) of
        Floor when is_integer(Floor) ->
            [CurFloor] = Action#action.target,
            case CurFloor >= Floor of
                true -> Dungeon#dungeon.pid ! {notify_public_event, [?DUN_MAX_FLOOR, [sys]]};
                false -> Dungeon#dungeon.pid ! {notify_public_event, [?DUN_NOT_MAX_FLOOR, [sys]]}
            end,
            {true, Dungeon};
        Other ->
            ?ERROR_MSG("[dungeon] check_dun_max_floor can not find, data = ~p~n", [Other]),
            Dungeon#dungeon.pid ! close_dungeon,
            {false, Dungeon}
    end;


%% 通知帮派系统到达哪一层副本
exec_action(?DUN_NOTIFY_GUILD_FLOOR, Action, _, Dungeon) ->
    case get(?DUN_GUILD_Id) of
        undefined -> ?ERROR_MSG("[dungeon] notify_guild_floor can not find, data = ~p~n", [undefined]);
        GuildId ->
            [Floor] = Action#action.target,
            lib_guild:update_dungeon_info(GuildId, [Dungeon#dungeon.pid, Floor, win, Dungeon#dungeon.actives]),
            ok
    end,
    {true, Dungeon};


%% 通知帮派系统副本失败
exec_action(?DUN_NOTIFY_GUILD_FAIL, Action, _, Dungeon) ->
    case get(?DUN_GUILD_Id) of
        undefined -> ?ERROR_MSG("[dungeon] notify_guild_floor can not find, data = ~p~n", [undefined]);
        GuildId ->
            [Floor] = Action#action.target,
            lib_guild:update_dungeon_info(GuildId, [Dungeon#dungeon.pid, Floor, lose, Dungeon#dungeon.actives]),
            ok
    end,
    {true, Dungeon};


%% 清除地图上所有怪物
exec_action(?CLEAR_ALL_MON, Action, _, Dungeon) ->
    F = fun(MapNo) ->
        case lists:keyfind(MapNo, 1, Dungeon#dungeon.map_index) of 
            {MapNo, SceneId} -> 
                MonIdList = lib_scene:get_scene_mon_ids(SceneId),
                [mod_scene:clear_mon_from_scene_WNC(MonId) || MonId <- MonIdList];
            false -> ?ERROR_MSG("[dungeon] clear_all_mon error~n", [])
        end
    end,
    lists:foreach(F, Action#action.target),
    {true, Dungeon};


%% 清除地图上所有动态的NPC
exec_action(?CLEAR_ALL_DYNAMIC_NPC, Action, _, Dungeon) ->
    F = fun(MapNo) ->
        case lists:keyfind(MapNo, 1, Dungeon#dungeon.map_index) of 
            {MapNo, SceneId} -> 
                NpcIdList = lib_scene:get_scene_dynamic_npc_ids(SceneId),
                [mod_scene:clear_dynamic_npc_from_scene_WNC(NpcId) || NpcId <- NpcIdList];
            false -> ?ERROR_MSG("[dungeon] clear_all_dynamic_npc error~n", [])
        end
    end,
    lists:foreach(F, Action#action.target),
    {true, Dungeon};


%% 添加世界BOSS
exec_action(?ADD_DUNGEON_BOSS, Action, _, Dungeon) ->
    [{MonNo, MapNo, X, Y}] = Action#action.target,
    ?LDS_DEBUG(?ADD_DUNGEON_BOSS, [{MonNo, MapNo, X, Y}]),
    case lists:keyfind(MapNo, 1, Dungeon#dungeon.map_index) of
        false -> ?ASSERT(false);
        {MapNo, SceneId} ->
            case mod_scene:spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, X, Y) of
                {ok, MonId} -> 
					%世界BOSS血量
                  %  BMonTpl=data_Bmon:get(58031),
                    {MinHp,CoefHp} = data_special_config:get(world_boss_hp),
                    Hp = min(MinHp,CoefHp * gen_server:call(mod_rank,get_max_lv)) ,
                 %   Hp = init_dungeon_boss_hp(Dungeon),
                    % Hp = 10000,
                    put(?DUNGEON_BOSS_HP, {MonNo, Hp, Hp}),
                    put(?DUN_MON(MapNo, MonNo, X, Y), MonId),
                    put(?DUNGEON_BOSS_TIME, util:unixtime()),
                    Dungeon#dungeon.pid ! 'broadcast_boss_hp',
					case MonNo of
						13200 -> mod_broadcast:send_sys_broadcast(77, []);
						13201 -> mod_broadcast:send_sys_broadcast(375, [])
					end;
                _ -> ?ASSERT(false)
            end
    end,
    {true, Dungeon};


%% TRACE
exec_action(trace, _, _, Dungeon) ->
    ?LDS_TRACE("dungeon trace"),
    {true, Dungeon};

exec_action(_E, _, _, Dungeon) ->
    ?ASSERT(false, [_E]),
    {false, Dungeon}.



%% ====================================================================
%% Internal functions
%% ====================================================================

%% 初始化BOSS血量
init_dungeon_boss_hp(Dungeon) ->
    {SumLv, Num} = calculate_lv(Dungeon#dungeon.actives),
    {AvgLv, PlayerNum} = case Num >= ?DEFAULT_BOSS_PLAYER_NUM of
        true -> {util:ceil(SumLv / Num), Num};
        false -> 
            case Num > 0 of
                true -> {util:ceil(SumLv / Num), ?DEFAULT_BOSS_PLAYER_NUM};
                false -> {?DEFAULT_BOSS_PLAYER_LV, ?DEFAULT_BOSS_PLAYER_NUM}
            end
    end,
    StandardHp = mod_xinfa:get_std_value(?BIN_PRED(AvgLv =< ?MAX_BOSS_PLAYER_LV, AvgLv, ?MAX_BOSS_PLAYER_LV), ?ATTR_HP),
    StandardHp * PlayerNum * ?BOSS_HP_COEF.


calculate_lv(List) ->
    calculate_lv_1(List, 0, 0).

calculate_lv_1([], Sum, Count) -> {Sum, Count};
calculate_lv_1([RoleId | Left], Sum, Count) ->
    case player:get_lv(RoleId) of
        Lv when is_integer(Lv) andalso Lv > 0 ->
            calculate_lv_1(Left, Sum + Lv, Count + 1);
        _ -> calculate_lv_1(Left, Sum, Count)
    end.


%% @doc 是否爬塔副本
is_tower_dungeon(No) ->
    % lib_dungeon:get_dungeon_type(No) =:= ?DUNGEON_TYPE_TOWER.
    No =:= ?TOWER_DUNGEON_NO.

%% @doc 是否噩梦爬塔副本
is_hardtower_dungeon(No) ->
    lists:member(No, ?HARD_TOWER_DUNGEON_NO_LIST).

%% @doc 是否帮派副本
is_guild_dungeon(No) ->
    lists:member(No, ?GUILD_DUNGEON_LIST).
    % get_dungeon_type(No) =:= ?DUNGEON_TYPE_GUILD.

%% 获取通关标志
get_dungeon_is_pass(RoleId,Dun) ->
    DunNo = Dun#dungeon_data.no,
    case get_role_dungeon(RoleId, DunNo) of
        null -> 
            0;
        Rd ->
            case Rd#role_dungeon.pass of 
                ?PASS -> 1;
                _ -> 0
            end
    end.

%% 设置副本标志为通关
%% @return : boolean()
set_dungeon_pass(RoleId, Dungeon) ->
    DunNo = Dungeon#dungeon.no,
    DunData = lib_dungeon:get_config_data(DunNo),
    Group = DunData#dungeon_data.group,
    case get_role_dungeon(RoleId, DunNo) of
        null -> 
            ?ERROR_MSG("set_dungeon_pass ERROR, RoleId = ~p, DunNo = ~p~n", [RoleId, DunNo]);
        Rd ->
            case Rd#role_dungeon.pass =:= ?PASS of 
                true -> skip;
                false -> update_role_dungeon(Rd#role_dungeon{pass = ?PASS})
            end
    end,
    %带领队员完成多少次副本通知成就
    case player:is_in_team(RoleId) andalso player:is_leader(RoleId) of
        true ->
            mod_achievement:notify_achi(team_dun, [], player:get_PS(RoleId));
        false ->
            skip
    end,
    case DunData#dungeon_data.type =:= ?DUNGEON_TYPE_TOWER orelse DunData#dungeon_data.type =:= ?DUNGEON_TYPE_HARD_TOWER orelse Dungeon#dungeon.proc_type =:= ?DUN_PUB  of
        false ->
            case lib_dungeon:get_dungeon_cd(RoleId, Group) of
                null ->
                    ?DEBUG_MSG("wujianchengtestdungeonNULL  ~n",[]),
                    false;
                    % ?ASSERT(false),orelse (not lib_dungeon:is_need_to_check_cd(DunData))
                    % lib_dungeon:insert_new_role_dungeon(RoleId, DunNo, Stamp),
                    % lib_dungeon:insert_new_dungeon_cd(RoleId, Group, util:unixtime());
                CdRd ->
                    NewTime = ?BIN_PRED(CdRd#dungeon_cd.times > 0, CdRd#dungeon_cd.times, 0) + 1,
                    lib_dungeon:update_dungeon_cd(CdRd#dungeon_cd{times = NewTime}),
                    %%检测是否还能发奖  一个字段两个不同的奖励都用到。 [{type,Times,unixtime}···]
                    PlayerTimes = (ply_misc:get_player_misc(RoleId))#player_misc.dungeon_reward_time,
                    GetRewardTimes
                        = case lists:keyfind(DunData#dungeon_data.type, 1, PlayerTimes) of
                             false ->
                                 0;
                             RewardTimeData ->
                                 {_DungeonType, RewardTimes, LastUnixTime} = RewardTimeData,
                                 %%判断是否同一天
                                 case util:is_same_day(LastUnixTime) of
                                     true ->
                                        RewardTimes;
                                     false ->
                                          0
                                 end
                         end,
                    try
                        case  DunData#dungeon_data.reward_times > GetRewardTimes  of
                            true ->
                                send_pass_dungeon_reward(RoleId, DunNo,NewTime);
                            false ->
                                skip
                        end

                    catch 
                        _T:_E -> ?ERROR_MSG("[mod_dungeon] send_pass_dungeon_reward error = ~p~n", [{_T, _E}])
                    end,
                    mod_dungeon:notify_activity_degree_pass(DunData#dungeon_data.type, RoleId),
                    %% 通知客户端副本进入次数   没有次数限制的副本不推送
                    {ok, BinData} = pt_57:write(57009, [Group, NewTime]),
                    lib_send:send_to_uid(RoleId, BinData),
                    case  DunData#dungeon_data.reward_times > GetRewardTimes  of
                        true ->
                            true;
                        false ->
                            false
                    end
            end;
        true ->  true       %% 爬塔/公共副本不在进入时保存进度
    end.


%% @doc 发送通关必得奖励
send_pass_dungeon_reward(RoleId, DunNo,NewTime) ->
    case data_dungeon:get_pass_reward_no(DunNo) of
        null -> skip;
        Rno when is_integer(Rno) andalso Rno > 0 ->
            case player:get_PS(RoleId) of
                Status when is_record(Status, player_status) ->
                    lib_reward:give_reward_to_player(dungeon,NewTime,Status, Rno, [?LOG_DUNGEON, DunNo]);
                _ -> 
                    RewardRd = lib_reward:calc_reward_to_player(RoleId, Rno,[dungeon,NewTime]),
                    case RewardRd#reward_dtl.calc_goods_list =/= [] of
                        true ->
                            lib_mail:send_sys_mail(RoleId, <<"副本奖励">>, 
                                <<"您上次尚未领取的奖励。">>, 
                                RewardRd#reward_dtl.calc_goods_list, [?LOG_MAIL, "recv_dungeon"]);
                        false -> skip
                    end
            end;
            % lib_reward:give_reward_to_player(common, Status, Rno, [], [?LOG_DUNGEON, DunNo]);
        _ -> skip
    end.

 
%% 计算通关奖励并发送给玩家进程
calculate_dungeon_pass(RoleId, Dungeon) ->
    DunData = lib_dungeon:get_config_data(Dungeon#dungeon.no),
    BoutPoints = max(0, DunData#dungeon_data.bout_max_points - (Dungeon#dungeon.bouts * ?BOUT_SUB_POINTS)),
    DeadPoints = max(0, DunData#dungeon_data.dead_max_points - (Dungeon#dungeon.deads * ?DEAD_SUB_POINTS)),
    Lv = get_point_lv(BoutPoints + DeadPoints, DunData#dungeon_data.point_lv),
    Info = #dungeon_pass_info{id = RoleId, no = Dungeon#dungeon.no, lv = Lv, box = ?POINTS_LV(Lv),
         bouts = Dungeon#dungeon.bouts, deads = Dungeon#dungeon.deads,
         bout_points = BoutPoints, dead_points = DeadPoints
        },
    put(?PASS_LV, Lv),
    case player:is_online(RoleId) of
        true ->
            case DunData#dungeon_data.had_pass_reward =:= 1 of
                true -> gen_server:cast(player:get_pid(RoleId), {send_dungeon_pass, Info});
                false -> skip
            end;
        false ->
            case lib_dungeon:get_config_reward_data(Dungeon#dungeon.no, lists:nth(util:rand(1, erlang:length(Info#dungeon_pass_info.box)), 
                Info#dungeon_pass_info.box)) of
                0 -> skip;
                RewardId when is_integer(RewardId) ->
                    RewardRd = lib_reward:calc_reward_to_player(RoleId, RewardId),
                    lib_mail:send_sys_mail(RoleId, <<"副本奖励">>, 
                        <<"门客副本的奖励你没及时领取，现在通过邮件发放给您！">>, 
                        RewardRd#reward_dtl.calc_goods_list, [?LOG_MAIL, "recv_dungeon"]);
                _ -> skip
            end
    end.


get_point_lv(_, []) -> ?DIAMOND_BOX;
get_point_lv(Points, List) ->
    get_point_lv(Points, List, ?COPPER_BOX).

get_point_lv(_, [_], Lv) -> ?BIN_PRED(Lv >= ?DIAMOND_BOX, Lv, ?DIAMOND_BOX);
get_point_lv(Points, [Degree | Left], Lv) ->
    case Points =< Degree of
        true -> Lv;
        false -> get_point_lv(Points, Left, Lv - 1)
    end.


send_dungeon_pass(RoleId, Info) ->
    % ?LDS_TRACE(57007),
    {ok, BinData} = pt_57:write(57007, [Info#dungeon_pass_info.lv, 
        Info#dungeon_pass_info.bouts, Info#dungeon_pass_info.bout_points, 
        Info#dungeon_pass_info.deads, Info#dungeon_pass_info.dead_points]),
    lib_send:send_to_uid(RoleId, BinData).


send_quit_dungeon_msg(RoleId, State) ->
    {ok, BinData} = pt_57:write(57002, [State]),
    lib_send:send_to_uid(RoleId, BinData).


%% 重置玩家通关信息
% reset_dungeon_pass_mem() ->
%     erase(?DUNGEON_PASS_MEM)
    

%% @doc 设置玩家通关副本信息
set_dungeon_pass_mem(Info) ->
    ?DEBUG_MSG("wjctestdungeonpass2 ~p~n",[Info]),
    put(?DUNGEON_PASS_MEM, Info).

%% @doc 获取玩家通关副本信息
get_dungeon_pass_mem() ->
    case get(?DUNGEON_PASS_MEM) of
        undefined -> null;
        Rd -> Rd
    end.

%% @doc 保存玩家通关副本抽奖箱子
set_dungeon_pass_box(Box, DunNo) ->
    put(?DUNGEON_PASS_MEM_BOX, {Box, DunNo}).

%% @doc 获取玩家通关副本抽奖箱子
get_dungeon_pass_box() ->
    case get(?DUNGEON_PASS_MEM_BOX) of
        undefined -> null;
        Rd -> Rd
    end.

%% @doc 重置箱子
reset_dungeon_pass_box() ->
    erase(?DUNGEON_PASS_MEM_BOX).

%% @retrun false | list()
get_id_by_object(nil, _, _) -> [];
get_id_by_object(self, RoleId, Actives) -> 
    case lists:member(RoleId, Actives) of
        true -> [RoleId];
        false -> get_id_by_object(captain, RoleId, Actives)
    end;
get_id_by_object(captain, _, Actives) -> 
    get_real_captain_id(Actives);
    % [RoleId | _] = Actives,
    % case player:is_in_team(RoleId) of
    %     true -> 
    %         TeamId = player:get_team_id(RoleId),
    %         case mod_team:get_leader_id(TeamId) of
    %             CaptainId when is_integer(CaptainId) -> 
    %                 case lists:member(CaptainId, Actives) of
    %                     true -> [CaptainId];
    %                     false -> false
    %                 end;
    %             _ -> false
    %         end;
    %     false -> false
    % end;
get_id_by_object(all, _RoleId, Actives) -> 
    Actives.

get_real_captain_id([]) -> false;
get_real_captain_id([RoleId | Left] = Actives) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) ->
            case player:is_in_dungeon(Status) of
                {true, _} -> 
                    TeamId = player:get_team_id(RoleId),
                    case mod_team:get_leader_id(TeamId) of
                        CaptainId when is_integer(CaptainId) -> 
                            case lists:member(CaptainId, Actives) of
                                true -> [CaptainId];
                                false -> get_real_captain_id(Left)
                            end;
                        _ -> get_real_captain_id(Left)
                    end;
                false -> get_real_captain_id(Left)
            end;
        _ -> get_real_captain_id(Left)
    end;
get_real_captain_id(_) -> false.



    % case player:is_in_team(RoleId) of
    %     true -> Actives;
    %         % TeamId = player:get_team_id(RoleId),
    %         % mod_team:get_all_member_id_list(TeamId);
    %     false -> false
    % end.


dun_debug(BinMsg, Id) ->
    ?ERROR_MSG("dun_debug Id = ~p, Info = ~p~n", [Id, tool:to_list(BinMsg)]).
    % {ok, BinData} = pt_57:write(57900, [BinMsg]),
    % lib_send:send_to_uid(Id, BinData).


set_ensure_list(DunNo, List) ->
    put(?ENSURE_LIST, {DunNo, List}).


del_ensure_list(Elm) ->
    case get_ensure_list() of
        null -> skip;
        {DunNo, List} ->
            NewList = lists:delete(Elm, List),
            set_ensure_list(DunNo, NewList)
    end.


get_ensure_list() ->
    case get(?ENSURE_LIST) of
        undefined -> null;
        Rd -> Rd
    end.

cancel_ensure() -> 
    erlang:erase(?ENSURE_LIST).


send_ensure_msg(List, DunNo) ->
    lists:foreach(fun(Id) -> 
        State = ?BIN_PRED(is_need_to_consume_props(Id, DunNo), 0, 1),
        {ok, BinData} = pt_57:write(57005, [DunNo, State]),
        lib_send:send_to_uid(Id, BinData)
         end, List).


get_left_times_by_group(RoleId, Group) ->
    case get_dungeon_no_by_group(Group) of
        null -> ?ASSERT(false), 0;
        DunNo -> get_left_times(RoleId, DunNo)
    end.

get_dungeon_no_by_group(Group) ->
    case data_dungeon:get_group(Group) of
        null -> null;
        [{_, No} | _] -> No
    end.

    % List = data_dungeon:get_nos(),
    % get_dungeon_no_by_group(Group, List).

% get_dungeon_no_by_group(_Group, []) -> null;
% get_dungeon_no_by_group(Group, [No | Left]) ->
%     case (get_config_data(No))#dungeon_data.group =:= Group of
%         true -> No;
%         false -> get_dungeon_no_by_group(Group, Left)
%     end.

%% @doc 取得副本已经参与次数
get_dungeon_used_times(RoleId, Dun) when is_record(Dun, dungeon_data) ->
    case is_need_to_check_cd(Dun) of
        false -> 0;
        true ->
            case get_dungeon_cd(RoleId, Dun#dungeon_data.group) of
                null -> ?ASSERT(false), 0;
                Rd -> Rd#dungeon_cd.times
            end
    end;
get_dungeon_used_times(RoleId, DunNo) when is_integer(DunNo) ->
    case get_config_data(DunNo) of
        Dun when is_record(Dun, dungeon_data) ->
            get_dungeon_used_times(RoleId, Dun);
        _ -> ?ASSERT(false), 0
    end.


%% 更新副本数据并取得参与次数
%% @return : integer()
get_update_dungeon_used_times(Status, TimeStamp, DunNo) when is_integer(DunNo) ->
    case get_config_data(DunNo) of
        Dun when is_record(Dun, dungeon_data) ->
            get_update_dungeon_used_times(Status, TimeStamp, Dun);
        _ -> ?ASSERT(false), 0
    end;
get_update_dungeon_used_times(Status, TimeStamp, Dun) when is_record(Dun, dungeon_data) ->
    RoleId = player:id(Status),
    role_dungeon_cd(RoleId, Dun, TimeStamp),
    get_dungeon_used_times(RoleId, Dun).
    % case lib_dungeon:role_dungeon_limit(Status, Dun) of
    %     true ->
    %         role_dungeon_cd(RoleId, Dun, TimeStamp),
    %         ?LDS_DEBUG("get_update_dungeon_used_times", [Dun#dungeon_data.no, get_dungeon_used_times(RoleId, Dun)]),
    %         get_dungeon_used_times(RoleId, Dun);
    %     {false, _Err} -> 0
    % end.


%% @doc 取得副本剩余次数
get_left_times(RoleId, DunNo) ->
    Dun = get_config_data(DunNo),
    case get_dungeon_cd(RoleId, Dun#dungeon_data.group) of
        null -> ?ASSERT(false), 0;
        Rd -> 
            
            Times = 
                case Dun#dungeon_data.cd of
                    {_, T} -> T;
                    {_, _, _, _, T} -> T;
                    _ -> 0
                end,
            Count = Times - Rd#dungeon_cd.times,
            ?BIN_PRED(Count >= 0, Count, 0)
    end.


%% @doc 取得副本免费次数
get_free_dun_times(Status, DunNo) when is_integer(DunNo) ->
    case get_config_data(DunNo) of
        Dun when is_record(Dun, dungeon_data) -> get_free_dun_times(Status, Dun);
        _ -> ?ASSERT(false), 0
    end;
get_free_dun_times(_Status, Dun) when is_record(Dun, dungeon_data) ->
    case Dun#dungeon_data.cd of
        {_, Times} -> Times;
		{_, _, _, _, Times} -> Times;
        _ -> 1
    end.


%% @doc 取得上限次数
get_max_dun_times(Status, DunNo) when is_integer(DunNo) ->
    case get_config_data(DunNo) of
        Dun when is_record(Dun, dungeon_data) -> get_max_dun_times(Status, Dun);
        _ -> ?ASSERT(false), 0
    end;
get_max_dun_times(Status, Dun) when is_record(Dun, dungeon_data) ->
    get_free_dun_times(Status, Dun) + lib_vip:welfare(dungeon_buy_times, Status).



get_box_quality_by_points_lv(Info) ->
    List = Info#dungeon_pass_info.box,
    Seed = util:rand(1, erlang:length(List)),
    Quality = lists:nth(Seed, List),
    % NewList = lists:delete(Quality, List),
    % set_dungeon_pass_mem(Info#dungeon_pass_info{box = NewList}),
    Quality.
            % Section = ?POINTS_LV(Lv),
            % select_section(Seed, Section, 0).

% select_section(_Seed, [{Quality, _Rand}], _Sum) -> Quality;
% select_section(Seed, [{Quality, Rand} | Left], Sum) ->
%     Count = Sum + Rand,
%     case Seed > Sum andalso Seed =< Count of
%         true -> Quality;
%         false -> select_section(Seed, Left, Count)
%     end.


notify_dungeon_time_out(RoleId) ->
    {ok, BinData} = pt_57:write(57010, []),
    lib_send:send_to_uid(RoleId, BinData).


%% --------------- time ------------------
%% 精确到秒 return: now()
timestamp_to_now(TimeStamp) ->
    Ksec = TimeStamp div 1000000,
    Sec  = TimeStamp rem 1000000,
    {Ksec, Sec, 0}.

%% @spec get_daytime_by_timestamp(TimeStamp::integer()) -> {date(), time()}.
get_daytime_by_timestamp(TimeStamp) ->
    calendar:now_to_local_time(timestamp_to_now(TimeStamp)).

%% @spec get_day_no_by_timestamp(TimeStamp::integer()) -> No::integer().
get_day_no_by_timestamp(TimeStamp) ->
    {Date, _} = get_daytime_by_timestamp(TimeStamp),
    calendar:date_to_gregorian_days(Date).

%% @spec get_week_no_by_timestamp(TimeStamp::integer()) -> {Year::integer(), No::integer()}.
get_week_no_by_timestamp(TimeStamp) ->
    {Date, _} = get_daytime_by_timestamp(TimeStamp),
    calendar:iso_week_number(Date).

%% @spec get_month_no_by_timestamp(TimeStamp::integer()) -> {Year::integer(), Month::integer()}
get_month_no_by_timestamp(TimeStamp) ->
    {{Y, M, _}, _} = get_daytime_by_timestamp(TimeStamp),
    {Y, M}.

%% @spec get_year_by_timestamp(TimeStamp::integer()) -> Y::integer().
get_year_by_timestamp(TimeStamp) ->
    {{Y, _, _}, _} = get_daytime_by_timestamp(TimeStamp),
    Y.

%% @spec get_time_by_timestamp(TimeStamp::integer()) -> Time::time().
get_time_by_timestamp(TimeStamp) ->
    {_, Time} = get_daytime_by_timestamp(TimeStamp),
    Time.

%% @spec get_date_by_timestamp(TimeStamp::integer()) -> date()
get_date_by_timestamp(TimeStamp) ->
    {Date, _} = get_daytime_by_timestamp(TimeStamp),
    Date.


%% are the NewStamp and OldStamp in same time range
%% retrun: true | false | error
in_time_range(day, NewStamp, OldStamp) ->
    NewDayNo = get_day_no_by_timestamp(NewStamp),
    OldDayNo = get_day_no_by_timestamp(OldStamp),
    NewDayNo =:= OldDayNo;
in_time_range(week, NewStamp, OldStamp) ->
    NewWeekNo = get_week_no_by_timestamp(NewStamp),
    OldWeekNo = get_week_no_by_timestamp(OldStamp),
    NewWeekNo =:= OldWeekNo;
in_time_range(month, NewStamp, OldStamp) ->
    NewMonthNo = get_month_no_by_timestamp(NewStamp),
    OldMonthNo = get_month_no_by_timestamp(OldStamp),
    NewMonthNo =:= OldMonthNo;
in_time_range(year, NewStamp, OldStamp) ->
    get_year_by_timestamp(NewStamp) =:= get_year_by_timestamp(OldStamp);
in_time_range(slot, {{Shour, Smin}, {Ehour, Emin}}, NewStamp) ->
    {Nhour, Nmin, _} = get_time_by_timestamp(NewStamp),
    Nmins = Nhour * 60 + Nmin,
    (Shour * 60 + Smin) =< Nmins andalso (Ehour * 60 + Emin) >= Nmins;
in_time_range(_, _, _) ->
    ?ASSERT(false), error.

in_time_range(slot, Type, NoList, {{Shour, Smin}, {Ehour, Emin}}, NewStamp, OldStamp, Times, AllTimes, FreeTimes, Status) ->
    case in_time_range(slot, {{Shour, Smin}, {Ehour, Emin}}, NewStamp) of
        true ->
            {Nyear, NewNo, NewDayNo} = get_date_type_no(Type, NewStamp),
            {Oyear, OldNo, OldDayNo} = get_date_type_no(Type, OldStamp),
            case lists:member(NewDayNo, NoList) of
                true ->
                    case Nyear =:= Oyear andalso NewNo =:= OldNo of
                        true ->
                            case NewDayNo =:= OldDayNo of
                                true -> 
                                    if  Times < FreeTimes -> {old, true};
                                        Times < AllTimes -> 
                                            case had_enough_dun_props(Status) of
                                                true -> {old, true};
                                                false -> {old, ?NOT_ENGOUTH_DUN_PROPS}
                                            end;
                                        true -> {old, ?DUN_TIMES_USED_OUT}
                                    end;
                                false -> {new, true}
                            end;
                        false -> {new, true}
                    end;
                false ->
                    {cd, ?CD_LIMIT}
            end;
        false -> {cd, ?CD_LIMIT}
    end.


get_date_type_no(week, TimeStamp) ->
    Date = get_date_by_timestamp(TimeStamp),
    DayNo = calendar:day_of_the_week(Date),
    {Y, W} = get_week_no_by_timestamp(TimeStamp),
    {Y, W, DayNo};
get_date_type_no(month, TimeStamp) ->    
    get_date_by_timestamp(TimeStamp).


%% @doc 是否需要检查CD
%% @return : boolean()
is_need_to_check_cd(Dun) when is_record(Dun, dungeon_data) ->
    Dun#dungeon_data.cd =/= 0;
is_need_to_check_cd(_) -> ?ASSERT(false), true.


%% @return {new/old/cd/null (新CD/旧CD/CD冷却中/没有该副本记录), true (满足CD/次数需求) | ErrCode::integer() (不满足)}
role_dungeon_cd(RoleId, Dun, TimeStamp) ->
    case is_need_to_check_cd(Dun) of
        false -> {old, true};
        true ->
            case get_dungeon_cd(RoleId, Dun#dungeon_data.group) of
                Rd when is_record(Rd, dungeon_cd) ->
                    OldStamp = Rd#dungeon_cd.timestamp, 
                    Times = Rd#dungeon_cd.times,
                    case player:get_PS(RoleId) of
                        Status when is_record(Status, player_status) ->
                            MaxTimes = get_max_dun_times(Status, Dun),
                            FreeTimes = get_free_dun_times(Status, Dun),
                            case Dun#dungeon_data.cd of
                                {DateType1, _T1} ->
                                    case in_time_range(DateType1, TimeStamp, OldStamp) of
                                        true -> 
                                            if  Times < FreeTimes -> {old, true};
                                                Times < MaxTimes -> 
                                                    case had_enough_dun_props(Status) of
                                                        true -> {old, true};
                                                        false -> {old, ?NOT_ENGOUTH_DUN_PROPS}
                                                    end;
                                                true -> {old, ?DUN_TIMES_USED_OUT}
                                            end;
                                        false -> 
                                            update_dungeon_cd(Rd#dungeon_cd{times = 0, timestamp = TimeStamp}),
                                            {new, true}
                                    end;
                                {slot, DateType2, NoList, Slot, _T2} ->
                                    {Type, Flag} = in_time_range(slot, DateType2, NoList, Slot, 
                                        TimeStamp, OldStamp, Times, MaxTimes, FreeTimes, Status),
                                    case Type of
                                        new -> update_dungeon_cd(Rd#dungeon_cd{times = 0, timestamp = TimeStamp});
                                        _ -> skip
                                    end,
                                    {Type, Flag}
                            end;
                        _ -> {old, ?DUN_TIMES_USED_OUT}
                    end;
                null ->
                    insert_new_dungeon_cd(RoleId, Dun#dungeon_data.group, TimeStamp),
                    {null, true}
            end
    end.

%% @return true | {false, Errcode}
role_dungeon_limit(Status, Dun) ->
    RoleId = player:id(Status),
    Lv = player:get_lv(Status),
    case Status#player_status.dun_info of
        ?DEF_DUN_INFO ->
            case Lv >= Dun#dungeon_data.lv of
                true ->
                    Type = Dun#dungeon_data.diff,
                    case Type =< ?EASY of
                        true -> true;
                        false ->  
                            case get_prev_hard_dun(Dun) of
                                false -> {false, ?DUN_LIMIT};
                                PrevNo when is_integer(PrevNo) ->
                                    case get_role_dungeon(RoleId, PrevNo) of
                                        null -> {false, ?DUN_LIMIT};
                                        Rd -> ?BIN_PRED(Rd#role_dungeon.pass =:= ?PASS, true, {false, ?DUN_LIMIT})
                                    end
                            end
                    end;
                false -> {false, ?LV_NOT_ENGOUTH}
            end;
        _ -> {false, ?ERROR}
    end.


%% ----------------------- logic --------------------------

%% @doc 返回当前副本前一难度的副本ID
%% @return DunId::integer() | false
get_prev_hard_dun(Dun) ->
    Group = Dun#dungeon_data.pass_group,
    Type = Dun#dungeon_data.diff,
    List = data_dungeon:get_pass_group(Group),
    PrevType = Type - 1,
    case lists:keyfind(PrevType, 1, List) of
        {PrevType, PrevNo} -> PrevNo;
        false -> false
    end.


% get_prev_hard_id_1(Dun) ->
%     List = data_dungeon:get_ids(),
%     get_prev_hard_id_1(Dun, List).

% get_prev_hard_id_1(_Dun, []) -> null;
% get_prev_hard_id_1(Dun, [Id | Left]) ->
%     NewDun = lib_dungeon:get_config_data(Id),
%     case NewDun#dungeon_data.group =:= Dun#dungeon_data.group andalso
%         NewDun#dungeon_data.lv =:= Dun#dungeon_data.lv andalso
%         NewDun#dungeon_data.type =:= (Dun#dungeon_data.type - 1) of
%         true -> NewDun;
%         false -> get_prev_hard_id_1(Dun, Left)
%     end.



%% @retrun {true, IdList} | false
team_limit(Dun, Status) ->
    case Dun#dungeon_data.role_num of
        0 ->
            TeamId = player:get_team_id(Status),
            case player:is_in_team(Status) of
                true -> 
                    case player:is_leader(Status) andalso 
                        mod_team:is_all_member_in_normal_state(TeamId) of
                        true ->
                            {true, mod_team:get_normal_member_id_list(player:get_team_id(Status))};
                        false -> false
                    end;
                false ->
                    {true, [player:id(Status)]}
            end;
        1 ->
            case player:is_in_team(Status) of
                true -> false;
                false -> {true, [player:id(Status)]}
            end;
        M when M > 1 ->
            TeamId = player:get_team_id(Status),
            case player:is_leader(Status) andalso 
                mod_team:is_all_member_in_normal_state(TeamId) andalso
                (mod_team:get_member_count(TeamId) >= M) of
                true ->
                    {true, mod_team:get_normal_member_id_list(TeamId)};
                false ->
                    false
            end;
        _ -> 
            ?ASSERT(false), false
    end.


make_new_role_dungeon(RoleId, DunNo, TimeStamp) ->
    #role_dungeon{id = { RoleId, DunNo}, timestamp = TimeStamp}.

make_new_dungeon_cd(RoleId, Group, TimeStamp) ->
    #dungeon_cd{id = {RoleId, Group}, timestamp = TimeStamp, times = 0}.


%% 传送出副本，地点为进副本前的坐标 return: {true | false , NewDungeon}
convey_out_dun(Dungeon, Status) ->
    case Status#player_status.dun_info of
        ?DEF_DUN_INFO -> 
            {false, Dungeon};
        #dun_info{state = in} ->
            {SceneId, {X, Y}} = Status#player_status.prev_pos,
            % ply_scene:do_single_teleport(Status, SceneId, X, Y),
            gen_server:cast(player:get_pid(Status), {'do_single_teleport', SceneId, X, Y}),
            % NewStatus = Status#player_status{dun_info = ?DEF_DUN_INFO},
            % mod_svr_mgr:update_online_player_status_to_ets(NewStatus),
            gen_server:cast(player:get_pid(Status), 'reset_dun_info'),
            NewActives = lists:delete(player:id(Status), Dungeon#dungeon.actives),
            {true, Dungeon#dungeon{actives = NewActives}};
        _Df -> 
            ?ASSERT(false),
            ?ERROR_MSG("DUNGEON convey_out_dun error = ~p~n", [_Df]),
            {SceneId, {X, Y}} = Status#player_status.prev_pos,
            % ply_scene:do_single_teleport(Status, SceneId, X, Y),
            gen_server:cast(player:get_pid(Status), {'do_single_teleport', SceneId, X, Y}),
            % NewStatus = Status#player_status{dun_info = ?DEF_DUN_INFO},
            % mod_svr_mgr:update_online_player_status_to_ets(NewStatus),
            gen_server:cast(player:get_pid(Status), 'reset_dun_info'),
            NewActives = lists:delete(player:id(Status), Dungeon#dungeon.actives),
            {true, Dungeon#dungeon{actives = NewActives}}
    end.


%% 传送出副本，地点为{SceneId, {X, Y}
convey_out_dun(Dungeon, Status, {SceneId, {X, Y}}) ->
    case Status#player_status.dun_info of
        ?DEF_DUN_INFO -> 
            {false, Dungeon};
        #dun_info{state = in} ->
            % ply_scene:do_single_teleport(Status, SceneId, X, Y),
            gen_server:cast(player:get_pid(Status), {'do_single_teleport', SceneId, X, Y}),
            % NewStatus = Status#player_status{dun_info = ?DEF_DUN_INFO},
            % mod_svr_mgr:update_online_player_status_to_ets(NewStatus),
            gen_server:cast(player:get_pid(Status), 'reset_dun_info'),
            NewActives = lists:delete(player:id(Status), Dungeon#dungeon.actives),
            {true, Dungeon#dungeon{actives = NewActives}};
        _Df -> 
            ?ASSERT(false),
            ?ERROR_MSG("DUNGEON convey_out_dun error = ~p~n", [_Df]),
            % ply_scene:do_single_teleport(Status, SceneId, X, Y),
            gen_server:cast(player:get_pid(Status), {'do_single_teleport', SceneId, X, Y}),
            % NewStatus = Status#player_status{dun_info = ?DEF_DUN_INFO},
            % mod_svr_mgr:update_online_player_status_to_ets(NewStatus),
            gen_server:cast(player:get_pid(Status), 'reset_dun_info'),
            NewActives = lists:delete(player:id(Status), Dungeon#dungeon.actives),
            {true, Dungeon#dungeon{actives = NewActives}}
    end.



% notify_dungeon_convey_out(RoleId, Dungeon) ->
%     Dungeon#dungeon.pid ! {'role_convey_out', RoleId}.


%% 通过队员/队长id获得队长id
%% retrun CaptainId | false
get_captain_id(RoleId) ->
    Status = 
        case player:is_online(RoleId) of
            true -> player:get_PS(RoleId);
            false -> 
                case player:in_tmplogout_cache(RoleId) of
                    true -> mod_svr_mgr:get_tmplogout_player_status(RoleId);
                    false -> null
                end
        end,
    case is_record(Status, player_status) of
        true ->
            case player:is_in_team(Status) of
                false -> RoleId;
                true ->
                    TeamId = player:get_team_id(Status),
                    case mod_team:get_leader_id(TeamId) of
                        CaptainId when is_integer(CaptainId) ->
                            CaptainId;
                        _ -> false
                    end
            end;
        _ -> false
    end.


listen_state_list_del([], Listening) -> Listening;
listen_state_list_del([Id | Left], Listening) ->
    case lists:keyfind(Id, 2, Listening) of
        false -> skip;
        ListState ->
            case lists:keyfind(?DUN_TIMER_TIMEOUT, 2, ListState#listen_state.condition) of
                false -> skip;
                #condition{target=[Time]} -> 
                    case get(?DUN_TIMER_REF(Time)) of
                        undefined -> skip;
                        Ref -> erlang:cancel_timer(Ref), erase(?DUN_TIMER_REF(Time))
                    end
            end
    end,
    NewListening = lists:keydelete(Id, 2, Listening),
    listen_state_list_del(Left, NewListening). 


send_dungeon_info(RoleId, Dungeon) ->
    NowStamp = util:unixtime(),
    StartTime = Dungeon#dungeon.create_timestamp,
    Living = Dungeon#dungeon.living_time,
    LeftTime = StartTime + Living - NowStamp,
    Time = ?BIN_PRED(LeftTime > 0, LeftTime, 0),
    {ok, BinData} = pt_57:write(57006, [Dungeon#dungeon.no, Time]),
    lib_send:send_to_uid(RoleId, BinData).

%% ----------------------- memory/db operation --------------------------

make_dun_info(DunNo, DunId, DunPid, BuilderId, State) ->
    #dun_info{dun_no = DunNo, dun_id = DunId, dun_pid = DunPid, builder = BuilderId, state = State}.

% make_dun_info({DunNo, DunPid, BuilderId, State}) ->
%     #dun_info{dun_no = DunNo, dun_pid = DunPid, builder = BuilderId, state = State}.


make_db_dun_info(DunInfo) when is_record(DunInfo, dun_info) ->
    {DunInfo#dun_info.dun_no, DunInfo#dun_info.dun_pid, DunInfo#dun_info.builder, DunInfo#dun_info.state}. 


get_role_dungeon(RoleId, DunNo) -> 
    case ets:lookup(?ETS_ROLE_DUNGEON, {RoleId, DunNo}) of
        [] -> null;
        [Rd] -> Rd;
        _ -> ?ASSERT(false), null
    end.

get_dungeon_cd(RoleId, Group) ->
    case ets:lookup(?ETS_DUNGEON_CD, {RoleId, Group}) of
        [] -> null;
        [Rd] -> Rd;
        _ -> ?ASSERT(false), null
    end.


update_role_dungeon(Rd) when is_record(Rd, role_dungeon) ->
    ets:insert(?ETS_ROLE_DUNGEON, Rd),
    util:actin_new_proc(?MODULE, db_update_dungeon, [Rd]);
update_role_dungeon(_) -> 
    ?ASSERT(false), error.


update_dungeon_cd(Rd) when is_record(Rd, dungeon_cd) ->
    ?DEBUG_MSG("wujianchengtestdungeonRd ~p ~n",[Rd]),
    ets:insert(?ETS_DUNGEON_CD, Rd),
    util:actin_new_proc(?MODULE, db_update_dungeon_cd, [Rd]);
update_dungeon_cd(_) -> 
    ?ASSERT(false), error.


insert_new_role_dungeon(RoleId, DunNo, TimeStamp) ->
    Rd = make_new_role_dungeon(RoleId, DunNo, TimeStamp),
    ets:insert(?ETS_ROLE_DUNGEON, Rd),
    util:actin_new_proc(?MODULE, insert_role_dungeon, [Rd]).


insert_role_dungeon(Rd) when is_record(Rd, role_dungeon) ->
    {RoleId, DunNo} = Rd#role_dungeon.id,
    db:insert(RoleId, role_dungeon, 
        [{role_id, RoleId},
         {dun_no, DunNo},
         {pass, Rd#role_dungeon.pass},
         {timestamp, Rd#role_dungeon.timestamp}
        ]);
insert_role_dungeon(Rd) ->
    ?ASSERT(false), 
    ?ERROR_MSG("insert_role_dungeon error = ~p~n", [Rd]),
    error.


insert_new_dungeon_cd(RoleId, Group, TimeStamp) ->
    Rd = make_new_dungeon_cd(RoleId, Group, TimeStamp),
    ?DEBUG_MSG("wujianchengtestdungeonRd ~p ~n",[Rd]),
    ets:insert(?ETS_DUNGEON_CD, Rd),
    util:actin_new_proc(?MODULE, insert_new_dungeon_cd, [Rd]).


insert_new_dungeon_cd(Rd) when is_record(Rd, dungeon_cd) ->
    {RoleId, Group} = Rd#dungeon_cd.id,
    db:insert(RoleId, dungeon_cd, 
        [{role_id, RoleId},
         {dun_group, Group},
         {timestamp, Rd#dungeon_cd.timestamp},
         {times, Rd#dungeon_cd.times}  
        ]);
insert_new_dungeon_cd(Rd) ->
    ?ASSERT(false), 
    ?ERROR_MSG("insert_new_dungeon_cd error = ~p~n", [Rd]),
    error.


db_update_dungeon(Rd) when is_record(Rd, role_dungeon) ->
    {RoleId, DunNo} = Rd#role_dungeon.id,
    db:update(RoleId, role_dungeon, 
        [
         {pass, Rd#role_dungeon.pass},
         {timestamp, Rd#role_dungeon.timestamp}
        ],
        [{role_id, RoleId},
         {dun_no, DunNo}
        ]
    );
db_update_dungeon(Rd) ->
    ?ASSERT(false), 
    ?ERROR_MSG("db_update_dungeon error = ~p~n", [Rd]),
    error.


db_update_dungeon_cd(Rd) when is_record(Rd, dungeon_cd) ->
    {RoleId, Group} = Rd#dungeon_cd.id,
    db:update(RoleId, dungeon_cd, 
        [
         {timestamp, Rd#dungeon_cd.timestamp},
         {times, Rd#dungeon_cd.times}  
        ],
        [{role_id, RoleId},
         {dun_group, Group}
        ]
    );
db_update_dungeon_cd(Rd) ->
    ?ASSERT(false), 
    ?ERROR_MSG("db_update_dungeon_cd error = ~p~n", [Rd]),
    error.



%% @doc 判断玩家是否在帮派预备场景
%% @return : boolean()
is_in_guild_prepare_dungeon(Status) ->
    case player:get_dungeon_no(Status) of
        DunNo when is_integer(DunNo) ->
            case get_config_data(DunNo) of
                Dun when is_record(Dun, dungeon_data) -> Dun#dungeon_data.type =:= ?DUNGEON_TYPE_GUILD_PREPARE;
                _ -> false
            end;
        _ -> false
    end.

%% @doc 判断玩家是否在帮派战斗场景副本中
%% @return : boolean()
is_in_guild_battle_dungeon(Status) ->
    case player:get_dungeon_no(Status) of
        DunNo when is_integer(DunNo) ->
            case get_config_data(DunNo) of
                Dun when is_record(Dun, dungeon_data) -> Dun#dungeon_data.type =:= ?DUNGEON_TYPE_GUILD_BATTLE;
                _ -> false
            end;
        _ -> false
    end.


%% @doc 取得配置表数据
get_config_data(No) ->
    case is_tower_dungeon(No) of
        true -> data_tower:get(No);
        false ->
            case is_hardtower_dungeon(No) of
                true -> data_hardtower:get(No);
                false -> data_dungeon:get(No)      
             end 
    end.

get_config_reward_data(No, BoxLv) ->
    case is_tower_dungeon(No) orelse is_hardtower_dungeon(No) of
        true -> ?ASSERT(false), null;
        false -> data_dungeon:get(No, BoxLv)
    end. 

get_config_tower_reward_data(Floor) ->
    data_tower_reward:get(Floor).

get_config_hardtower_reward_data(TowerNo, Floor) ->
    case TowerNo of
        ?HARD_TOWER_DUNGEON_NO1 ->
            data_hardtower_reward1:get(Floor);
        ?HARD_TOWER_DUNGEON_NO2 ->
            data_hardtower_reward2:get(Floor);
        ?HARD_TOWER_DUNGEON_NO3 ->
            data_hardtower_reward3:get(Floor);
        _ ->
            ?ASSERT(false, TowerNo)
    end.
    


-define(DUN_DICT_ROLE_DUNGEON, {dungeon, dict_role_dungeon}).
-define(DUN_DICT_DUNGEON_CD, {dungeon, dict_dungeon_cd}).    


dungeon_load_data(RoleId) ->
    case db:select_all(role_dungeon, "*", [{role_id, RoleId}]) of
        [] -> skip;
        List ->
            F = fun([_, DunNo, Pass, Stamp]) ->
                Rd = #role_dungeon{id = {RoleId, DunNo}, 
                    pass = Pass,
                    timestamp = Stamp},
                ets:insert(?ETS_ROLE_DUNGEON, Rd),
                add_role_dungeon_list({RoleId, DunNo})
            end,
            lists:foreach(F, List)
    end,
    case db:select_all(dungeon_cd, "*", [{role_id, RoleId}]) of
        [] -> skip;
        List2 ->
            F2 = fun([_, Group, Stamp, Times]) ->
                Rd = #dungeon_cd{id = {RoleId, Group}, 
                    times = Times,
                    timestamp = Stamp},
                ?DEBUG_MSG("wujianchengtestdungeonRd ~p ~n",[Rd]),
                ets:insert(?ETS_DUNGEON_CD, Rd),
                add_dungeon_cd_list({RoleId, Group})
            end,
            lists:foreach(F2, List2)
    end.


%% 用户登录
dungeon_login(Status, role_in_cache) ->
    handle_dungeon_login(Status, role_in_cache);
dungeon_login(Status, Cache) ->
    dungeon_load_data(player:id(Status)),
    handle_dungeon_login(Status, Cache).


handle_dungeon_login(Status, Cache) ->
    % RoleId = player:id(Status),
    % Status = player:get_PS(RoleId),
    RoleId = player:id(Status),
    lib_tower:login(Status, Cache),
    lib_hardtower:login(Status, Cache),

    case Status#player_status.dun_info of
        ?DEF_DUN_INFO -> skip; %% lib_task:publ_clean_all_dungeon_task(RoleId);
        #dun_info{dun_pid = Pid, dun_no = DunNo} ->
            case is_pid(Pid) andalso is_process_alive(Pid) of
                true -> pp_dungeon:handle(57011, Status, []);
                false -> 

                    % Now = util:unixtime(),
                    NewStatus = Status#player_status{dun_info = ?DEF_DUN_INFO},
                    % mod_svr_mgr:update_online_player_status_to_ets(NewStatus),
                    gen_server:cast(player:get_pid(Status), 'reset_dun_info'),
                    #plyr_pos{scene_id = PrevScene} = player:get_position(RoleId),
                    case PrevScene < ?COPY_SCENE_START_ID of
                        true -> skip;
                        false -> 
                            {SceneId, {X, Y}} = NewStatus#player_status.prev_pos,
                            % ply_scene:do_single_teleport(NewStatus, SceneId, X, Y)
                            gen_server:cast(player:get_pid(NewStatus), {'do_single_teleport', SceneId, X, Y})
                    end,
                    ?BIN_PRED(is_tower_dungeon(DunNo), put(?TOWER_POSITION_FALG, ?TOWER_DUNGEON_NO), skip),
                    ?BIN_PRED(is_hardtower_dungeon(DunNo), put(?HARD_TOWER_POSITION_FALG, DunNo), skip)
                    
            end
        
    end.


tranform_dun_info_to_save(DunInfo) when is_record(DunInfo, dun_info) ->
    {DunInfo#dun_info.dun_no, DunInfo#dun_info.dun_id, DunInfo#dun_info.builder, DunInfo#dun_info.state}.


%% @return #dun_info
tranform_dun_info_to_load({0, _, _, _}) -> ?DEF_DUN_INFO;
tranform_dun_info_to_load({No, Id, BuilderId, State}) ->
    case catch gen_server:call(?DUNGEON_MANAGE, {'get_dungeon_pid', Id}, 2000) of
        0 -> case is_tower_dungeon(No) orelse is_hardtower_dungeon(No) of
                false -> ?DEF_DUN_INFO;
                true -> #dun_info{dun_no = No, dun_id = Id, dun_pid = 0, builder = BuilderId, state = State}
             end;
        Pid when is_pid(Pid) -> #dun_info{dun_no = No, dun_id = Id, dun_pid = Pid, builder = BuilderId, state = State};
        Err -> ?ASSERT(false),
               ?ERROR_MSG("dungeon login get dungeon pid timeout Err = ~p~n", [Err]),
               ?DEF_DUN_INFO
    end.
    

%% @doc 处理副本重连超时
dungeon_reconn_timeout(Status) ->
    ?LDS_TRACE("handle dungeon logout"),
    #dun_info{dun_no = No, dun_pid = Pid} = Status#player_status.dun_info,
    
    RoleId = player:id(Status),
    case No =:= 0 orelse (not is_tower_dungeon(No)) orelse (not is_hardtower_dungeon(No)) of        %% 爬塔副本保留进度，以备当天内上线重新创建副本
        true -> db:update(RoleId, player, [{dun_info, tranform_dun_info_to_save(?DEF_DUN_INFO)}], [{id, RoleId}]);
        false -> db:update(RoleId, player, [{dun_info, tranform_dun_info_to_save(Status#player_status.dun_info)}], [{id, RoleId}])
    end,
    [ets:delete(?ETS_ROLE_DUNGEON, Key) || Key <- get_role_dungeon_key_list()],
    [ets:delete(?ETS_DUNGEON_CD, Key1) || Key1 <- get_dungeon_cd_key_list()],

    case is_pid(Pid) of
        true -> gen_server:cast(Pid, {'quit_dungeon', Status});
        false ->
            % 副本进程已不在，则直接标记处理副本重连超时完毕，勿忘！
            mod_lginout_TSL:mark_handle_game_logic_reconn_timeout_done(?SYS_DUNGEON, RoleId)
    end.


%% @doc 玩家临时退出
temp_logout(Status) ->
    case player:is_in_dungeon(Status) of
        {true, Pid} -> Pid ! 'temp_logout_dungeon';
        false -> skip
    end.


%% 进程字典操作
add_role_dungeon_list(Key) ->
    List = get_role_dungeon_key_list(),
    put(?DUN_DICT_ROLE_DUNGEON, [Key | List]).

get_role_dungeon_key_list() ->
    case get(?DUN_DICT_ROLE_DUNGEON) of
        undefined -> [];
        Rd -> Rd
    end.

add_dungeon_cd_list(Key) ->
    List = get_dungeon_cd_key_list(),
    put(?DUN_DICT_DUNGEON_CD, [Key | List]).

get_dungeon_cd_key_list() ->
    case get(?DUN_DICT_DUNGEON_CD) of
        undefined -> [];
        Rd -> Rd
    end.


%%创建帮派副本
create_guild_dungeon(DunNo, Stamp, StartFloor, MaxFloor, GuildId) ->
    gen_server:cast(?DUNGEON_MANAGE, {'create_guild_dungeon', DunNo, Stamp, StartFloor, MaxFloor, GuildId}).   

%% 进入公共副本
%% @DunPid::pid()
enter_public_dungeon(DunPid, RoleId, Timestamp, MapNo, X, Y) when is_pid(DunPid) ->
    DunPid ! {'enter_public_dungeon', RoleId, Timestamp, MapNo, X, Y};
enter_public_dungeon(_, _, _, _, _, _) -> ?ASSERT(false).


enter_public_dungeon(DunPid, RoleId) when is_pid(DunPid) ->
    DunPid ! {'enter_public_dungeon', RoleId, util:unixtime()};
enter_public_dungeon(_, _) -> ?ASSERT(false).


%% 取得副本类型
%% @return : null | integer()
get_dungeon_type(DunNo) ->
    case get_config_data(DunNo) of
        Dungeon when is_record(Dungeon, dungeon_data) ->
            Dungeon#dungeon_data.type;
        _ -> null
    end.


%% @doc 取得副本随机位置
get_random_pos([]) -> {};
get_random_pos(Pos) when is_list(Pos) ->
    lists:nth(util:rand(1, erlang:length(Pos)), Pos);
get_random_pos(Pos) -> Pos.



%%关于镇妖塔
update_tower_rd(Tower) ->
  ets:insert(?ETS_TOWER, Tower).

del_tower_rd(Tower) ->
  ets:delete(?ETS_TOWER, Tower#tower.id).

%% @return null | #tower{}
get_tower_rd(RoleId) ->
    case ets:lookup(?ETS_TOWER, RoleId) of
        [Tower] when is_record(Tower, tower) -> Tower;
        _ -> null
    end.

%%进入某层挑战
enter_floor_tower(PS,Floor) ->
    DungeonTowerData = data_dungeon_tower:get(Floor),
    DungeonData = data_dungeon:get(DungeonTowerData#dungeon_tower.fuben_id),
    [Bmon] = DungeonData#dungeon_data.listen_bout_battle,
    put(tower,{Floor,DungeonTowerData#dungeon_tower.fuben_id,Bmon}),
    case player:is_idle(PS) of
        false ->
            lib_send:send_prompt_msg(player:get_id(PS), ?PM_PARA_ERROR);
        true ->
            mod_battle:start_mf(PS, Bmon, null)
    end.
%%  send_reward_by_floor(1000100000000290,1,20).
send_reward_by_floor(PlayerId, StartFloor, EndFloor) ->
    F = fun(X,Acc) ->
        DungeonTower = data_dungeon_tower:get(X),
        DungeonNo =DungeonTower#dungeon_tower.fuben_id,
        DungeonData = data_dungeon:get(DungeonNo),
        TowerReward =
            case data_dungeon:get_pass_reward_no(DungeonNo) of
                null -> [];
                Rno when is_integer(Rno) andalso Rno > 0 ->
                    RewardDtl = lib_reward:give_reward_to_player(dungeon, 1, player:get_PS(PlayerId), Rno, [?LOG_DUNGEON, DungeonNo]),
                    RewardDtl#reward_dtl.goods_list;
                _ -> []
            end,
        TowerReward2 =
            case DungeonData#dungeon_data.first_reward > 0 of
                true ->
                    RewardDtl2 = lib_reward:give_reward_to_player(dungeon, 1, player:get_PS(PlayerId), DungeonData#dungeon_data.first_reward, [?LOG_DUNGEON, DungeonNo]),
                    RewardDtl2#reward_dtl.goods_list;
                false ->
                    []
            end,
        (TowerReward ++ TowerReward2) ++ Acc
        end,
    AllRewardList = lists:foldl(F, [], lists:seq(StartFloor, EndFloor - 1)),
    List = [{ No, Num}
        || {_, No, Num} <- AllRewardList ],
    %%将重复的排列一下
    F2 = fun(Para) ->
        case Para of
            {No,_Count} -> No
        end
        end,
    GoodsNoList = sets:to_list(sets:from_list([F2(X) || X <- List])),

    F3 = fun(X1,Acc1) ->
        F4 =
            fun({GoodsNo, GoodsNum}, {InitGoodsNo, InitGoodsNum}) ->
                case GoodsNo =:= X1  of
                    true ->
                        {X1,InitGoodsNum + GoodsNum};
                    false -> {InitGoodsNo, InitGoodsNum}
                end
            end,
        [lists:foldl(F4, {X1,0}, List)|Acc1]
         end,
    NewList = lists:foldl(F3,[],GoodsNoList),
 %   GoodsType = data_goods:get(GoodsNo), andalso GoodsType#goods_tpl.type =/= 1
    NewList2 =
        lists:foldl(
        fun({GoodsNo2,GoodsNum2},Acc2) ->
            GoodsData = data_goods:get(GoodsNo2),
            case GoodsData#goods_tpl.type =/= 1 of
                true ->
                    [{GoodsNo2,GoodsNum2}|Acc2];
                false ->
                   lists:foldl(
                       fun(_,Acc3) ->
                           [{GoodsNo2,1}|Acc3]
                       end,
                       [],lists:seq(1,GoodsNum2)
                   ) ++ Acc2
            end
        end,
        [],NewList
    ),

    ?DEBUG_MSG("DungeonTowerNewList ~p~n",[NewList2]),
    lib_tower:set_next_floor(PlayerId, EndFloor),
    lib_tower:back_event(player:get_PS(PlayerId)),
    %%再发一边49001给前端刷新信息
    lib_tower:get_tower_info(player:get_PS(PlayerId)),
%%    {ok, BinData} = pt_49:write(49001, [EndFloor, data_hardtower:get_max_floor(), 0, Tower#tower.best_floor]),
%%    lib_send:send_to_uid(PlayerId, BinData),
    {ok, BinData2} = pt_49:write(49003, [NewList2]),
    lib_send:send_to_uid(PlayerId, BinData2).

%% 战斗特殊处理，进入战斗的时候记录玩家的信息，用于打赢发送奖励，自动进入下一场战斗，通关及更新数据等
%              lib_dungeon:test(1000100000000283,0).
enter_tower_dungeon(PlayerId, Floor, Type) ->
    %%判断是否可以进入该层 {tower,1000100000000289,0,0,0,0,737793,0,37}]
    case get_tower_rd(PlayerId) of
        Tower when is_record(Tower, tower) ->
            case Tower#tower.have_jump ==1 andalso Type =/=0 of
                true ->
                    lib_send:send_prompt_msg(PlayerId, ?PM_HAVE_GOT_THE_PAY);
                false ->
                    LastFloor = case Tower#tower.floor of
                                    0 ->
                                        1;
                                    _ ->
                                        Tower#tower.floor
                                end,
                    PS = player:get_PS(PlayerId),
                    case Type of
                        0 -> %%不跳层
                            case Floor =< LastFloor + 1  of
                                true ->
                                    enter_floor_tower(PS,Floor);
                                false ->
                                    lib_send:send_prompt_msg(PlayerId, ?PM_OP_FREQUENCY_LIMIT)
                            end;
                        1 ->%%普通跳层
                            %%消耗相应的物品
                            %%发送层数奖励
                            CommonFloor = util:ceil(Tower#tower.best_floor * data_special_config:get('zhenyaota_tiaoceng') ),
                            F = fun(X,{CostType,CostCount}) ->
                                DungeonTower = data_dungeon_tower:get(X),
                                {Cost,Count} =DungeonTower#dungeon_tower.cost1,
                                {Cost,Count+ CostCount}
                                end,
                            {MoneyType,MoneyCount} = lists:foldl(F, {0,0}, lists:seq(LastFloor, CommonFloor - 1)),
                            case player:check_need_price(PS, MoneyType, MoneyCount)  of
                                ok ->
                                    NewTowerRd = Tower#tower{have_jump = 1},
                                    player:cost_money(PS, MoneyType, MoneyCount,["lib_dungeon", "jump_tower"]),
                                    update_tower_rd(NewTowerRd),
                                    lib_tower:db_update_tower(NewTowerRd),
                                    send_reward_by_floor(PlayerId,LastFloor,CommonFloor);
                                %%通知前端刷新层数
                                %% 不需要进入战斗
%%                            enter_floor_tower(PS,CommonFloor);
                                MsgCode ->
                                    lib_send:send_prompt_msg(PlayerId, MsgCode)
                            end;

                        2 ->%%完美跳层
                            BestFloor = Tower#tower.best_floor ,

                            F = fun(X,{CostType,CostCount}) ->
                                DungeonTower = data_dungeon_tower:get(X),
                                {Cost,Count} =DungeonTower#dungeon_tower.cost2,
                                {Cost,Count+ CostCount}
                                end,
                            {MoneyType,MoneyCount} = lists:foldl(F, {0,0}, lists:seq(LastFloor, BestFloor - 1)),
                            case  player:check_need_price(PS, MoneyType, MoneyCount)  of
                                ok ->
                                    NewTowerRd = Tower#tower{have_jump = 1},
                                    player:cost_money(PS, MoneyType, MoneyCount,["lib_dungeon", "jump_tower"]),
                                    update_tower_rd(NewTowerRd),
                                    lib_tower:db_update_tower(NewTowerRd),
                                    send_reward_by_floor(PlayerId,LastFloor,BestFloor);
                                MsgCode ->
                                    lib_send:send_prompt_msg(PlayerId, MsgCode)
                            end

                    end
            end;

        _ ->
            lib_send:send_prompt_msg(PlayerId, ?PM_UNKNOWN_ERR)
    end.

test(PlayerId,Floor) ->
    PS = player:get_PS(PlayerId),
    PS#player_status.pid ! {test_tower, PlayerId, Floor}.

%%重置爬塔和副本
reset_all_dungeon(PlayerId) ->
    PlayerMiscData= ply_misc:get_player_misc(PlayerId),
    ply_misc:update_player_misc(PlayerMiscData#player_misc{dungeon_reward_time =[] }),
    Tower = get_tower_rd(PlayerId),
    update_tower_rd(Tower#tower{refresh_stamp = 0}).






