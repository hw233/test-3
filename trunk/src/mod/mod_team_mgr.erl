%%%------------------------------------
%%% @Module  : mod_team_mgr
%%% @Author  : zhangwq
%%% @Email   :
%%% @Created : 2014.4.3
%%% @Description: server 用于同步处理审批玩家入队 、创建队伍、同意加入队伍操作
%%%------------------------------------


-module(mod_team_mgr).
-behaviour(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([
        create_team/8,                  % 创建普通队伍
        offline/1,                      % 玩家因下线变成在队离线状态
        sys_kick_out_member/2,          %% 系统把玩家提出队伍
        do_quit_team/2,                 %% 退出队伍
        do_quit_team/3,                 %% 退出队伍
        do_quit_team2/1,            %%因为跨服组队退出队伍
        allow_join/3,                   % 队长允许其他玩家入队
        agree_invite/2,                 % 落单玩家同意队长的入队邀请
        check_add_mb/2,
        check_add_mb/3,
        use_zf/2,
        use_exam/2,
        set_zf_pos/2,
        try_clear_data/0,               % 检查并清理残留数据（主要是处理一些异常情况，避免内存泄漏）
        battle_feedback/1               % 处理组队战斗反馈 一个队伍一次战斗只反馈一次
    ]).


-include("team.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("abbreviate.hrl").
-include("common.hrl").
-include("record.hrl").
-include("log.hrl").
-include("pt_24.hrl").
-include("obj_info_code.hrl").
-include("scene.hrl").
-include("sys_code.hrl").
-include("proc_name.hrl").
-include("dungeon.hrl").
-include("record/battle_record.hrl").

create_team(PS, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv, TeamName) ->
    gen_server:cast(?TEAM_PROCESS, {'create_team', PS, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv,  TeamName}).


allow_join(PS, JoinPlayerId, TeamId) ->
    gen_server:cast(?TEAM_PROCESS, {'allow_join', PS, JoinPlayerId, TeamId}).


agree_invite(PS, LeaderId) ->
    gen_server:cast(?TEAM_PROCESS, {'agree_invite', PS, LeaderId}).


offline(PS) ->
    gen_server:cast(?TEAM_PROCESS, {'offline', PS}).    


sys_kick_out_member(TeamId, PS) ->
    gen_server:cast(?TEAM_PROCESS, {'sys_kick_out_member', TeamId, PS}).    


do_quit_team(PS, IsEscape) ->
    gen_server:cast(?TEAM_PROCESS, {'do_quit_team', PS, IsEscape, true}).

do_quit_team(PS, IsEscape, NotifyDun) ->
    gen_server:cast(?TEAM_PROCESS, {'do_quit_team', PS, IsEscape, NotifyDun}).

do_quit_team2(PS) ->
gen_server:cast(?TEAM_PROCESS, {'try_do_quit_team2', PS}).


battle_feedback(FeedbackInfo) ->
    case lib_bt_comm:is_qiecuo_pk_battle(FeedbackInfo) of
        true -> skip;
        false -> 
            gen_server:cast(?TEAM_PROCESS, {'battle_feedback', FeedbackInfo})
    end,
    
    case lib_bt_comm:is_tve_mf_battle(FeedbackInfo) of
        false -> skip;
        true -> mod_tve_mgr:tve_mf_callback(FeedbackInfo)
    end.

use_zf(TeamId, No) ->
    gen_server:cast(?TEAM_PROCESS, {'use_zf', TeamId, No}).

use_exam(TeamId,No) ->
    gen_server:cast(?TEAM_PROCESS, {'use_exam', TeamId, No}).



set_zf_pos(TeamId, IdPosList) ->
    gen_server:cast(?TEAM_PROCESS, {'set_zf_pos', TeamId, IdPosList}). 


try_clear_data() ->
    gen_server:cast(?TEAM_PROCESS, {'try_clear_data'}).            

% -------------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?TEAM_PROCESS}, ?MODULE, [], []).


init([]) ->
    process_flag(trap_exit, true),

    {ok, none}.


handle_call(Request, From, State) ->
    try
        handle_call_2(Request, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {reply, error, State}
    end.



handle_call_2(_Request, _From, State) ->
    {reply, State, State}.


handle_cast(Request, State) ->
    try
        handle_cast_2(Request, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
            {noreply, State}
    end.


handle_cast_2({'create_team', PS, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv, TeamName}, State) ->
    ?TRY_CATCH(try_create_team(PS, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv, TeamName), ErrReason),
    {noreply, State};


handle_cast_2({'allow_join', PS, JoinPlayerId, TeamId}, State) ->
    ?TRY_CATCH(try_allow_join(PS, JoinPlayerId, TeamId), ErrReason),
    {noreply, State};


handle_cast_2({'agree_invite', PS, LeaderId}, State) ->
    ?TRY_CATCH(try_agree_invite(PS, LeaderId), ErrReason),
    {noreply, State};


handle_cast_2({'offline', PS}, State) ->
    ?TRY_CATCH(try_offline(PS), ErrReason),
    {noreply, State};    

handle_cast_2({'sys_kick_out_member', TeamId, PS}, State) when is_record(PS, player_status) ->
    ?TRY_CATCH(try_sys_kick_out_member(TeamId, PS), ErrReason),
    % 标记处理队伍重连超时完毕，勿忘！
    mod_lginout_TSL:mark_handle_game_logic_reconn_timeout_done(?SYS_TEAM, player:id(PS)),
    {noreply, State};        


handle_cast_2({'do_quit_team', PS, IsEscape, NotifyDun}, State) ->
    ?TRY_CATCH(try_do_quit_team(PS, IsEscape, NotifyDun), skip),
    {noreply, State};

handle_cast_2({'try_do_quit_team2', PS}, State) ->
    ?TRY_CATCH(try_do_quit_team2(PS), skip),
    {noreply, State};



handle_cast_2({'on_player_quit_dungeon', PS}, State) ->
    ?TRY_CATCH(on_player_quit_dungeon(PS), ErrReason),
    {noreply, State};


handle_cast_2({'do_tem_leave_team', PS}, State) ->
    case mod_team:get_team_by_id(player:get_team_id(PS)) of
        null -> fail;
        Team ->
            case player:id(PS) =:= mod_team:get_leader_id(Team) of
                true -> fail;
                false ->
                    case lib_team:get_member_by_id(player:get_id(PS), Team#team.members) of
                        null -> fail;
                        Mb ->
                            case player:is_in_dungeon(PS) of
                                false -> 
                                    NewMb = Mb#mb{state = ?MB_STATE_TEM_LEAVE},
                                    NewMemberList = lists:keyreplace(player:get_id(PS), #mb.id, Team#team.members, NewMb),
                                    NewTeam = Team#team{members = NewMemberList},
                                    mod_team:update_team_to_ets(NewTeam),
                                    lib_team:notify_member_temp_leave(NewTeam, player:get_id(PS));
                                {true, _Pid} -> 
                                    %% 策划需求调整
                                    DunType = lib_dungeon:get_dungeon_type(player:get_dungeon_no(PS)),
                                    if
                                        DunType =:= ?DUNGEON_TYPE_GUILD_PREPARE orelse DunType =:= ?DUNGEON_TYPE_GUILD_BATTLE ->
                                            NewMb = Mb#mb{state = ?MB_STATE_TEM_LEAVE},
                                            NewMemberList = lists:keyreplace(player:get_id(PS), #mb.id, Team#team.members, NewMb),
                                            NewTeam = Team#team{members = NewMemberList},
                                            mod_team:update_team_to_ets(NewTeam),
                                            lib_team:notify_member_temp_leave(NewTeam, player:get_id(PS));
                                      true ->
                                            NewMember = Mb#mb{state = ?MB_STATE_IN},  % 更新队员状态为在队状态
                                            NewMemberList = lists:keyreplace(NewMember#mb.id, #mb.id, Team#team.members, NewMember),
                                            NewTeam = Team#team{members = NewMemberList},
                                            mod_team:update_team_to_ets(NewTeam),

                                            %% 立即飞到队长身边
                                            SceneId = player:get_scene_id(Team#team.leader_id),
                                            {X, Y} = player:get_xy(Team#team.leader_id),
                                            case SceneId =:= ?INVALID_ID of
                                                true -> skip;
                                                false -> do_single_teleport(PS, SceneId, X, Y)
                                            end,
                                            
                                            lib_team:notify_member_return(NewTeam, player:get_id(PS)),
                                            lib_team:notify_player_enter_team_aoi(NewTeam, player:id(PS))
                                    end
                            end
                    end
            end
    end,
    {noreply, State};


handle_cast_2({'do_return_team', PS, TeamId}, State) ->
    case mod_team:get_team_by_id(TeamId) of
        null -> % 多进程并发引起这个分支
            skip;
        Team ->
            case lib_team:get_member_by_id(player:get_id(PS), Team#team.members) of
                null -> % 多进程并发引起这个分支
                    skip;
                Mb ->
                    NewMember = Mb#mb{state = ?MB_STATE_IN},  % 更新队员状态为在队状态
                    NewMemberList = lists:keyreplace(NewMember#mb.id, #mb.id, Team#team.members, NewMember),
                    NewTeam = Team#team{members = NewMemberList},
                    mod_team:update_team_to_ets(NewTeam),

                    %% 立即飞到队长身边
                    SceneId = player:get_scene_id(Team#team.leader_id),
                    {X, Y} = player:get_xy(Team#team.leader_id),
                    case SceneId =:= ?INVALID_ID of
                        true -> skip;
                        false -> do_single_teleport(PS, SceneId, X, Y)
                    end,
                    lib_team:notify_member_return(NewTeam, player:get_id(PS)),
                    lib_team:notify_player_enter_team_aoi(NewTeam, player:id(PS)),
                    ok
            end
    end,
    {noreply, State};


handle_cast_2({'do_apply_join', PS, TeamId}, State) ->
    ?TRY_CATCH(try_do_apply_join(PS, TeamId), ErrReason),
    {noreply, State};    


handle_cast_2({'do_agree_promote_leader', PS, TeamId, SendMsgLeaderId}, State) ->
    ?TRY_CATCH(try_do_agree_promote_leader(PS, TeamId, SendMsgLeaderId), ErrReason),
    {noreply, State};        


handle_cast_2({'clear_apply_list', TeamId}, State) ->
    case mod_team:get_team_by_id(TeamId) of
        null ->
            skip;
        Team ->
            NewTeam = Team#team{apply_list = []},
            mod_team:update_team_to_ets(NewTeam),
            ok
    end,
    {noreply, State};


%% 当队伍所以成员掉线，玩家上线调整在线玩家为队长
handle_cast_2({'change_leader_on_player_login', PS}, State) ->
    ?TRY_CATCH(try_change_leader_on_player_login(PS), ErrReason),
    {noreply, State};    


handle_cast_2({'battle_feedback', FeedbackInfo}, State) ->
    List = [FeedbackInfo#btl_feedback.player_id | FeedbackInfo#btl_feedback.teammate_id_list],
    
    TList = [{X, Y} || X <- List, Y <- List, X < Y],
    [mod_relation:add_intimacy_between_AB(IdA, IdB, 1) || {IdA, IdB} <- TList],

    {noreply, State};        


handle_cast_2({'use_zf', TeamId, No}, State) ->
    case mod_team:get_team_by_id(TeamId) of
        null ->
            skip;
        Team ->
            NewTeam = Team#team{troop_no = No},
            mod_team:update_team_to_ets(NewTeam),
            lib_team:notify_team_info_change(NewTeam, lib_team:get_learned_zf_nos(NewTeam)),
            ok
    end,
    {noreply, State};

handle_cast_2({'use_exam', TeamId, No}, State) ->
    case mod_team:get_team_by_id(TeamId) of
        null ->
            skip;
        Team ->
            NewTeam = Team#team{is_exam  = No},
            mod_team:update_team_to_ets(NewTeam),
            {ok, BinData} = pt_24:write(?PT_TM_IS_EXAM, [No]),
            lib_send:send_to_uid(Team#team.leader_id, BinData),
            ok
    end,
    {noreply, State};



handle_cast_2({'set_zf_pos', TeamId, IdPosList}, State) ->
    case mod_team:get_team_by_id(TeamId) of
        null ->
            skip;
        Team ->
            F = fun(Mb, Acc) ->
                case lists:keyfind(Mb#mb.id, 1, IdPosList) of
                    false -> Acc;
                    {_, Pos} -> [Mb#mb{troop_pos = Pos} | Acc]
                end
            end,

            Mbs = lists:foldl(F, [], Team#team.members),
            NewTeam = Team#team{members = Mbs},
            mod_team:update_team_to_ets(NewTeam),
            lib_team:notify_team_zf_pos_change(NewTeam, IdPosList),
            ok
    end,
    {noreply, State};    


handle_cast_2({'try_clear_data'}, State) ->
    List = mod_team:get_team_list(),
    F = fun(Team) ->
        case player:is_online(Team#team.leader_id) of
            true -> skip;
            false ->
                case player:in_tmplogout_cache(Team#team.leader_id) of
                    true -> skip;
                    false -> mod_team:delete_team_from_ets(Team#team.team_id)
                end
        end
    end,
    [F(X) || X <- List],
    {noreply, State};        


handle_cast_2(_Msg, State) ->
    ?ASSERT(false, _Msg),
    {noreply, State}.


handle_info(Request, State) ->
    try
        handle_info_2(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {noreply, State}
    end.

handle_info_2(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

% %%-------------------------------------------------------------------------------------------------

% 切换队长
try_change_leader_on_player_login(PS) ->
    TeamId = player:get_team_id(PS),
    case mod_team:get_team_info(TeamId) of
        null -> skip;
        Team ->
            case lib_team:get_member_by_id(player:get_id(PS), Team#team.members) of
                null -> skip;
                HMb ->
                    NewLeaderOldTrainPos = HMb#mb.train_pos,
                    F = fun(Member) ->
                        if
                            Member#mb.id =:= HMb#mb.id -> % 现任队长
                                Member#mb{train_pos = 1, state = ?MB_STATE_IN};
                            (NewLeaderOldTrainPos /= 1) andalso (Member#mb.train_pos > NewLeaderOldTrainPos) ->
                                Pos = Member#mb.train_pos - 1,
                                Member#mb{train_pos = Pos};
                            (Member#mb.train_pos =:= 1) andalso (Member#mb.id /= HMb#mb.id) ->
                                Member#mb{train_pos = length(Team#team.members)};
                            true ->
                                Member
                        end
                    end,

                    % 切换队长
                    NewTeam = Team#team{
                                        leader_id = player:id(PS),
                                        leader_pid = player:get_pid(PS),
                                        leader_name = player:get_name(PS),
                                        team_name = list_to_binary(binary_to_list(player:get_name(PS)) ++ binary_to_list(<<"的队伍">>)),
                                        members = lists:map(F, Team#team.members)
                                        },

                    mod_team:update_team_to_ets(NewTeam),
                    % 向组队成员提示：YY成为了新的队长。
                    % lib_team:notify_leader_changed(NewTeam, ?INVALID_ID)

                    ZfL = lib_team:get_learned_zf_nos(NewTeam),
                    NewTeam1 = lib_team:adjust_cur_zf(NewTeam, ZfL),
                    mod_team:update_team_to_ets(NewTeam1),
                    lib_team:notify_team_info_change(NewTeam1, ZfL),
                    lib_team:notify_member_aoi_change(NewTeam1, player:get_id(PS)),
                    lib_team:notify_leader_changed(NewTeam1, ?INVALID_ID)
            end
    end.

try_do_agree_promote_leader(PS, TeamId, SendMsgLeaderId) ->
    case mod_team:get_team_by_id(TeamId) of
        null -> fail;
        Team ->
            case lib_team:get_member_by_id(player:get_id(PS), Team#team.members) of
                null ->
                    fail;
                Mb ->
                    % 取消原队长的资格
                    OldLeaderId = Team#team.leader_id,
                    case (OldLeaderId =:= player:id(PS) orelse SendMsgLeaderId =/= OldLeaderId) of
                        true -> skip;
                        false ->
                            OldLeaderMb = lib_team:get_member_by_id(OldLeaderId, Team#team.members),
                            ?ASSERT(OldLeaderMb /= null),
                            Mb1 = Mb#mb{troop_pos = OldLeaderMb#mb.troop_pos, train_pos = OldLeaderMb#mb.train_pos},
                            OldLeaderMb1 = OldLeaderMb#mb{troop_pos = Mb#mb.troop_pos, train_pos = Mb#mb.train_pos},
                            % 队长站在最前，其他的依次后移一个位置
                            NewMemberList = lists:keydelete(Mb#mb.id, #mb.id, Team#team.members), % 先把新队长删除
                            NewMemberList1 = [Mb1] ++ NewMemberList, % 把新队长放在首位
                            % 更新原队长的站位
                            NewMemberList2 = lists:keyreplace(OldLeaderMb1#mb.id, #mb.id, NewMemberList1, OldLeaderMb1),

                            % 切换队长
                            NewTeam = Team#team{
                                        leader_id = Mb1#mb.id,
                                        leader_pid = Mb1#mb.pid,
                                        leader_name = Mb1#mb.name,
                                        team_name = list_to_binary(binary_to_list(Mb1#mb.name) ++ binary_to_list(<<"的队伍">>)),
                                        members = NewMemberList2
                                        },
                            %%如果在玩大富翁时处理
%%                            lib_luck:agree_chess_leader(PS,TeamId),

                            player:clear_leader_flag(OldLeaderId),
                            player:mark_leader_flag(PS),

                            ZfL = lib_team:get_learned_zf_nos(NewTeam),
                            NewTeam1 = lib_team:adjust_cur_zf(NewTeam, ZfL),
                            mod_team:update_team_to_ets(NewTeam1),
                            lib_team:notify_team_info_change(NewTeam1, ZfL),
                            lib_team:notify_member_aoi_change(NewTeam1, player:get_id(PS)),
                            lib_team:notify_leader_changed(NewTeam1, OldLeaderId)
                    end
            end
    end.


try_do_apply_join(PS, TeamId) ->
    case mod_team:get_team_by_id(TeamId) of
        null -> fail;
        Team ->
            case Team#team.is_exam of
                0 ->
                    %不需要审核
                    case mod_team:is_team_full(TeamId) of
                        true ->
                            fail;
                        false ->
                            mod_team_mgr:allow_join(player:get_PS(Team#team.leader_id), player:get_id(PS), TeamId),
                            ok
                    end;
                1 ->
                    ShowEquips = player:get_showing_equips(PS),
                    BackWear = ShowEquips#showing_equip.backwear,
                    Weapon = ShowEquips#showing_equip.weapon,
                    Headwear = ShowEquips#showing_equip.headwear,
                    Clothes = ShowEquips#showing_equip.clothes,
                    NewApply = #apply{
                        player_id = player:get_id(PS),
                        player_name = player:get_name(PS),
                        race = player:get_race(PS),
                        lv = player:get_lv(PS),
                        sex = player:get_sex(PS),
                        faction = player:get_faction(PS),
                        back_wear =BackWear,
                        weapon = Weapon,
                        headwear = Headwear,
                        clothes = Clothes,
                        magic_key = ShowEquips#showing_equip.magic_key,
                        suit_no = player:get_suit_no(PS),
                        battle_power = PS#player_status.battle_power
                    },

                    ApplyList = Team#team.apply_list ++ [NewApply],
                    NewTeam = Team#team{apply_list = ApplyList},
                    mod_team:update_team_to_ets(NewTeam),
                    % 向队长发送申请列表
                    send_team_apply_info(NewTeam),
                    ok
            end
    end.

% 尝试执行退出队伍操作
try_do_quit_team(PS, IsEscape, NotifyDun) ->
    Team = mod_team:get_team_by_id(player:get_team_id(PS)),
    ?ASSERT(Team /= null, IsEscape), %% 逃跑的的时候队伍已经被解散？待验证
    case Team =:= null of
        true -> skip;
        false ->
            OldMbCount = mod_team:get_online_member_count(Team),
            IsLeader = (player:id(PS) =:= mod_team:get_leader_id(Team)),
            if
                OldMbCount < 2 andalso IsLeader andalso IsEscape -> %% 队伍少于2人是队长且是战斗逃跑
                    skip;
                OldMbCount < 2 andalso IsLeader andalso (not IsEscape) -> %% 队伍少于2人是队长且不是战斗逃跑
                    % 系统向组队成员提示：XX离开了队
                    lib_team:notify_member_quit(Team, player:get_id(PS), 0),
                    %% 解散队伍的情况，需要另外发送给aoi
                    lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_LEADER_FLAG, 0}]),
                    % 更新队员玩家状态,设置is_leader为false,team_id为0
                    mod_team:set_member_no_team_state(Team),
                    ?TRACE("leader quit, Team disband!~n", []),
                    lib_team:notify_member_aoi_change(Team, player:get_id(PS)),
                    % 解散队伍
                    mod_team:delete_team_from_ets(Team#team.team_id);
                true -> % 队伍大于2人
                    OldMbList = Team#team.members,
                    case lists:keyfind(player:get_id(PS), #mb.id, OldMbList) of
                        false -> skip;
                        Mb ->
                            ?ASSERT(is_record(Mb, mb), Mb),
                            NewMbList = OldMbList -- [Mb],
                            case NewMbList =:= [] of %% 检测队伍人数，如果没人了，及时解散队伍，避免内存泄漏
                                true ->
                                    lib_team:notify_member_quit(Team, player:get_id(PS), 0),
                                    % 更新队员玩家状态,设置is_leader为false,team_id为0
                                    mod_team:set_member_no_team_state(Team),
                                    % 解散队伍
                                    mod_team:delete_team_from_ets(Team#team.team_id);
                                false ->
                                    case player:id(PS) =:= mod_team:get_leader_id(Team) of
                                        true ->
                                            ?TRACE("leader quit, new member list: ~p~n", [NewMbList]),
                                            % 从剩下的队员中挑选第一个在队在线的作为新队长

                                            % 切换队长
                                            HMb =
                                                case mod_team:pick_first_member(mod_team:sort_member_by_train_pos(NewMbList, train_pos), ?MB_STATE_IN) of
                                                    null ->
                                                        mod_team:pick_first_member(mod_team:sort_member_by_train_pos(NewMbList, train_pos), ?MB_STATE_TEM_LEAVE);
                                                    H -> H
                                                end,
                                            case HMb =:= null of
                                                true -> %% 其他队员是在队离线的
                                                    % 系统向组队成员提示：XX离开了队
                                                    lib_team:notify_member_quit(Team, player:get_id(PS), 0),
                                                    % 更新队员玩家状态,设置is_leader为false,team_id为0
                                                    mod_team:set_member_no_team_state(Team),
                                                    ?TRACE("leader quit, Team disband!~n", []),
                                                    % 解散队伍
                                                    mod_team:delete_team_from_ets(Team#team.team_id);
                                                false ->
                                                    % 切换队长操作
                                                    NewLeaderOldTrainPos = HMb#mb.train_pos,
                                                    F = fun(Member) ->
                                                        if
                                                            Member#mb.id =:= HMb#mb.id -> % 现任队长
                                                                Member#mb{train_pos = 1, state = ?MB_STATE_IN};
                                                            Member#mb.train_pos > NewLeaderOldTrainPos ->
                                                                Pos = Member#mb.train_pos - 1,
                                                                ?ASSERT(Pos /= 1, NewMbList),
                                                                Member#mb{train_pos = Pos};
                                                            true ->
                                                                Member
                                                        end
                                                    end,
                                                    
                                                    NewTeam = Team#team{
                                                                        leader_id = HMb#mb.id,
                                                                        leader_pid = HMb#mb.pid,
                                                                        leader_name = HMb#mb.name,
                                                                        troop_no = 0,
                                                                        team_name = list_to_binary(binary_to_list(HMb#mb.name) ++ binary_to_list(<<"的队伍">>)),
                                                                        members = lists:map(F, NewMbList)},

                                                    player:clear_leader_flag(PS),
                                                    player:clear_team_id(PS),
                                                    player:mark_leader_flag(HMb#mb.id),
                                                    % 向组队成员提示：XX离开了队伍，YY成为了新的队长。
                                                    lib_team:notify_member_quit(Team, player:get_id(PS), NewTeam#team.leader_id),
                                                    ZfL = lib_team:get_learned_zf_nos(NewTeam),
                                                    NewTeam1 = lib_team:adjust_cur_zf(NewTeam, ZfL),
                                                    mod_team:update_team_to_ets(NewTeam1),
                                                    lib_team:notify_team_info_change(NewTeam1, ZfL),
                                                    lib_team:notify_member_aoi_change(NewTeam1, player:get_id(PS)),
                                                    case NotifyDun of
                                                        false -> skip;
                                                        true -> lib_dungeon:notify_dungeon_quit_team(PS, mod_team:get_leader_id(NewTeam1))
                                                    end
                                            end;
                                        false ->
                                            ?TRACE("member quit, new member list: ~p~n", [NewMbList]),
                                            QuitTeamMbTrainPos = Mb#mb.train_pos,
                                            F = fun(Member) ->
                                                if
                                                    Member#mb.train_pos > QuitTeamMbTrainPos ->
                                                        Member#mb{train_pos = Member#mb.train_pos - 1};
                                                    true ->
                                                        Member
                                                end
                                            end,
                                            NewTeam = Team#team{members = lists:map(F, NewMbList)},
                                            player:clear_team_id(PS),
                                            % 向组队成员提示：XX离开了队伍
                                            lib_team:notify_member_quit(Team, player:get_id(PS), 0),
                                            ZfL = lib_team:get_learned_zf_nos(NewTeam),
                                            NewTeam1 = lib_team:adjust_cur_zf(NewTeam, ZfL),
                                            mod_team:update_team_to_ets(NewTeam1),
                                            lib_team:notify_team_info_change(NewTeam1, ZfL),
                                            lib_team:notify_member_aoi_change(NewTeam1, player:get_id(PS)),
                                            case NotifyDun of
                                                false -> skip;
                                                true -> lib_dungeon:notify_dungeon_quit_team(PS, mod_team:get_leader_id(NewTeam1))
                                            end
                                    end
                            end
                    end
            end,
			%% 离开了队伍，放弃抓鬼任务
			lib_task:force_abandon_ghost_task(player:id(PS))
    end.



% 尝试执行退出队伍操作
try_do_quit_team2(PS) ->
    Team = mod_team:get_team_by_id(player:get_team_id(PS)),
    case Team =:= null of
        true -> skip;
        false ->
            mod_team:set_member_no_team_state(Team),
            mod_team:delete_team_from_ets(Team#team.team_id)
    end.

%% 如果是队长且只有一个人，则不处理，否则把退出副本的玩家踢出队伍
on_player_quit_dungeon(PS) ->
    case player:get_team_id(PS) of
        ?INVALID_ID -> skip;
        TeamId ->
            case mod_team:get_team_by_id(TeamId) of
                null -> skip;
                Team ->
                    OldMbCount = mod_team:get_member_count(Team),
                    IsLeader = (player:id(PS) =:= mod_team:get_leader_id(Team)),
                    if
                        OldMbCount < 2 andalso IsLeader ->
                            skip;
                        true -> 
                            OldMbList = Team#team.members,
                            case lists:keyfind(player:get_id(PS), #mb.id, OldMbList) of
                                false -> skip;
                                Mb ->
                                    ?ASSERT(is_record(Mb, mb), Mb),
                                    NewMbList = OldMbList -- [Mb],
                                    case NewMbList =:= [] of %% 检测队伍人数，如果没人了，及时解散队伍，避免内存泄漏
                                        true ->
                                            lib_team:notify_member_quit(Team, player:get_id(PS), 0),
                                            % 更新队员玩家状态,设置is_leader为false,team_id为0
                                            mod_team:set_member_no_team_state(Team),
                                            % 解散队伍
                                            mod_team:delete_team_from_ets(Team#team.team_id);
                                        false ->
                                            case IsLeader of
                                                true ->
                                                    skip;
                                                false ->
                                                    QuitTeamMbTrainPos = Mb#mb.train_pos,
                                                    F = fun(Member) ->
                                                        if
                                                            Member#mb.train_pos > QuitTeamMbTrainPos ->
                                                                Member#mb{train_pos = Member#mb.train_pos - 1};
                                                            true ->
                                                                Member
                                                        end
                                                    end,
                                                    NewTeam = Team#team{members = lists:map(F, NewMbList)},
                                                    player:clear_team_id(PS),
                                                    % 向组队成员提示：XX离开了队伍
                                                    lib_team:notify_member_quit(Team, player:get_id(PS), 0),
                                                    ZfL = lib_team:get_learned_zf_nos(NewTeam),
                                                    NewTeam1 = lib_team:adjust_cur_zf(NewTeam, ZfL),
                                                    mod_team:update_team_to_ets(NewTeam1),

                                                    lib_team:notify_team_info_change(NewTeam1, ZfL),
                                                    lib_team:notify_member_aoi_change(NewTeam1, player:get_id(PS))
                                            end
                                    end
                            end
                    end
            end
    end.

try_sys_kick_out_member(TeamId, PS) ->
    TargetPlayerId = player:id(PS),
    case mod_team:get_team_by_id(TeamId) of
        null -> skip;
        Team ->
            OldMbList = Team#team.members,
            case lists:keyfind(TargetPlayerId, #mb.id, OldMbList) of
                false -> skip; %% 玩家下线后，有可能队长已经把该玩家踢出队伍
                Mb ->
                    NewMbList = OldMbList -- [Mb],
                    case NewMbList =:= [] of %% 检测队伍人数，如果没人了，及时解散队伍，避免内存泄漏
                        true ->
                            lib_team:notify_member_quit(Team, player:get_id(PS), 0),
                            % 更新队员玩家状态,设置is_leader为false,team_id为0
                            mod_team:set_member_no_team_state(Team),
                            % 解散队伍
                            mod_team:delete_team_from_ets(Team#team.team_id);
                        false ->
                            lib_dungeon:notify_dungeon_quit_team(PS, mod_team:get_leader_id(Team)), %% 当队伍有还有人的时候需要通知副本
                            case player:is_online(TargetPlayerId) of
                                true ->
                                    player:clear_team_id(TargetPlayerId);
                                false ->
                                    case player:in_tmplogout_cache(TargetPlayerId) of
                                        false -> skip;
                                        true ->
                                            TmpLogoutPS = ply_tmplogout_cache:get_tmplogout_PS(TargetPlayerId),
                                            ply_tmplogout_cache:set_team_id(TmpLogoutPS, ?INVALID_ID)
                                    end
                            end,

                            case player:is_leader(PS) of
                                true ->
                                    NewTeam = Team#team{members = NewMbList},
                                    % 向组队成员提示：XX离开了队伍，YY成为了新的队长。
                                    lib_team:notify_member_quit(Team, player:get_id(PS), NewTeam#team.leader_id),
                                    mod_team:update_team_to_ets(NewTeam);
                                false ->
                                    QuitTeamMbTrainPos = Mb#mb.train_pos,
                                    F = fun(Member) ->
                                        if
                                            Member#mb.train_pos > QuitTeamMbTrainPos ->
                                                Member#mb{train_pos = Member#mb.train_pos - 1};
                                            true ->
                                                Member
                                        end
                                    end,
                                    NewTeam = Team#team{members = lists:map(F, NewMbList)},
                                    ZfL = lib_team:get_learned_zf_nos(NewTeam),
                                    NewTeam1 = lib_team:adjust_cur_zf(NewTeam, ZfL),
                                    
                                    lib_team:notify_member_quit(Team, player:get_id(PS), 0),
                                    lib_team:notify_team_info_change(NewTeam1, ZfL),
                                    mod_team:update_team_to_ets(NewTeam1)
                            end
                    end
            end
    end.


try_offline(PS) ->
    case mod_team:get_team_info(PS) of
        null -> skip;
        Team ->
            case lib_team:get_member_by_id(player:get_id(PS), Team#team.members) of
                null -> skip;
                Mb ->
                    NewMb = Mb#mb{state = ?MB_STATE_OFFLINE},
                    NewMbList = lists:keyreplace(player:get_id(PS), #mb.id, Team#team.members, NewMb),
                    NewTeam = Team#team{members = NewMbList},
                    mod_team:update_team_to_ets(NewTeam),
                    lib_team:notify_member_offline(NewTeam, player:get_id(PS)),

                    % 如果是队长离线则马上更换队长
                    case player:is_leader(PS) of
                        false -> skip;
                        true ->
                            HMb =
                                case mod_team:pick_first_member(mod_team:sort_member_by_train_pos(NewMbList, train_pos), ?MB_STATE_IN) of
                                    null ->
                                        mod_team:pick_first_member(mod_team:sort_member_by_train_pos(NewMbList, train_pos), ?MB_STATE_TEM_LEAVE);
                                    TmpMb ->
                                        TmpMb
                                end,
                            ?Ifc (HMb /= null)
                                ?TRACE("mod_team:offline() Leader:~p offline, NewLeaderId:~p ~n", [player:get_id(PS), HMb#mb.id]),
                                NewLeaderOldTrainPos = HMb#mb.train_pos,

                                F = fun(Member) ->
                                    if
                                        Member#mb.id =:= HMb#mb.id -> % 现任队长
                                            Member#mb{train_pos = 1, state = ?MB_STATE_IN};
                                        (NewLeaderOldTrainPos /= 1) andalso (Member#mb.train_pos > NewLeaderOldTrainPos) ->
                                            Pos = Member#mb.train_pos - 1,
                                            ?ASSERT(Pos /= 1, NewMbList),
                                            Member#mb{train_pos = Pos};
                                        (Member#mb.train_pos =:= 1) andalso (Member#mb.id /= HMb#mb.id) ->
                                            ?ASSERT(length(NewMbList) /= 1),
                                            Member#mb{train_pos = length(NewMbList)};
                                        true ->
                                            Member
                                    end
                                end,
                                NewTeam1 = NewTeam#team{
                                                    leader_id = HMb#mb.id,
                                                    leader_pid = HMb#mb.pid,
                                                    leader_name = HMb#mb.name,
                                                    team_name = list_to_binary(binary_to_list(HMb#mb.name) ++ binary_to_list(<<"的队伍">>)),
                                                    members = lists:map(F, NewMbList)},
                                player:mark_leader_flag(HMb#mb.id),
                                % 向组队成员提示：YY成为了新的队长。
                                lib_team:notify_leader_changed(NewTeam1, player:get_id(PS)),
                                ?TRACE("mod_team:offline,NewTeam is ~p~n", [NewTeam1]),
                                mod_team:update_team_to_ets(NewTeam1)
                            ?End
                    end
                    % void
            end
    end.

try_agree_invite(PS, LeaderId) ->
    case check_agree_invite(PS, LeaderId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(player:id(PS), Reason);
        ok ->
            do_agree_invite(PS, LeaderId)
    end.


check_agree_invite(PS, LeaderId) ->
    try check_agree_invite__(PS, LeaderId) of
        ok -> ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_agree_invite__(PS, LeaderId) ->
    ?Ifc (player:is_in_team(PS))
        throw(?PM_ALREADY_IN_TEAM)
    ?End,
    LeaderPS = player:get_PS(LeaderId),
    ?Ifc (LeaderPS == null)
        throw(?PM_PLAYER_OFFLINE_OR_NOT_EXISTS)
    ?End,
    Team = mod_team:get_team_by_id(player:get_team_id(LeaderId)),
    ?Ifc (Team == null)
        throw(?PM_TEAM_NOT_EXISTS)
    ?End,

%%    ?Ifc(lib_scene:is_home_scene(player:get_scene_id(PS)))
%%                     throw(?PM_CANT_APPLY_WHEN_IN_DUNGEON)
%%    ?End,

%%    ?Ifc(lib_scene:is_guild_dungeon_scene(player:get_scene_id(PS)))
%%                     throw(?PM_CANT_APPLY_WHEN_IN_DUNGEON)
%%    ?End,
%%

    ?Ifc (lib_team:get_member_by_id(player:get_id(PS), Team#team.members) =/= null)
        throw(?PM_ALREADY_IN_TEAM)
    ?End,

    ?Ifc (mod_team:is_team_full(Team))
        throw(?PM_TEAM_IS_FULL)
    ?End,
%%
%%    ?Ifc (not player:is_idle(PS))
%%        throw(?PM_BUSY_NOW)
%%    ?End,
    
    SceneType = case lib_scene:get_obj(player:get_scene_id(LeaderPS)) of
                    null -> ?SCENE_T_INVALID;
                    SceneObj -> lib_scene:get_type(SceneObj)
                end,
%%
%%    % 队长在帮派场景中 但是我不是他的帮派成员
%%    ?Ifc (SceneType =:= ?SCENE_T_GUILD andalso player:get_guild_id(PS) =/= player:get_guild_id(LeaderPS))
%%        throw(?PM_CANT_AGREE_WHEN_IN_GUILD)
%%    ?End,
%%
%%    % 队长在乱斗场景中，而我不在则不能同意他的邀请
%%    ?Ifc (player:is_in_melee(LeaderPS) andalso (player:get_scene_id(PS) =/= player:get_scene_id(LeaderPS)))
%%        throw(?PM_CANT_JOIN_WHEN_LEADER_IN_MELEE)
%%    ?End,

%%    %% 判断队长是否在幻境中(同意邀请入队)
%%    PlayerList = case ets:lookup(ets_mirage_player,mirage_player) of
%%                    [] ->
%%                        [];
%%                    [{mirage_player,MiragePlayer}] ->
%%                        MiragePlayer
%%                 end,
%%    ?Ifc (lists:member(LeaderId, PlayerList))
%%        throw(?PM_MIRAGE_AGREE_INVITE)
%%    ?End,

    ok.


do_agree_invite(PS, LeaderId) ->
    case player:get_PS(LeaderId) of
        null -> 
            ?ASSERT(false),
            {fail, ?PM_UNKNOWN_ERR};
        LeaderPS ->
            case mod_team:get_team_by_id(player:get_team_id(LeaderPS)) of
                null -> 
                    ?ASSERT(false),
                    {fail, ?PM_TEAM_NOT_EXISTS};
                Team ->
                    % HeadEmptyPos = mod_team:get_head_empty_pos_in_troop(Team),
                    NewMember = #mb{
                                    id = player:get_id(PS), 
                                    pid = player:get_pid(PS), 
                                    troop_pos = find_first_empty_pos(Team), 
                                    train_pos = length(Team#team.members) + 1,
                                    name = player:get_name(PS), 
                                    state = ?MB_STATE_TEM_LEAVE},
                    NewMemberList = 
                        case lists:keyfind(player:id(PS), #mb.id, Team#team.members) of
                            false -> Team#team.members ++ [NewMember];
                            _ -> Team#team.members
                        end,

                    NewInvitedList = Team#team.invited_list -- [player:get_id(PS)],
                    %% 如果该玩家在申请列表则在申请列表删除
                    NewApplyList = 
                        case lists:keyfind(player:get_id(PS), #apply.player_id, Team#team.apply_list) of
                            false -> Team#team.apply_list;
                            _Any -> lists:keydelete(player:get_id(PS), #apply.player_id, Team#team.apply_list)
                        end,
                    NewTeam = Team#team{members = NewMemberList, invited_list = NewInvitedList, apply_list = NewApplyList},
                    mod_team:update_team_to_ets(NewTeam),

                    player:set_team_id(PS, Team#team.team_id),
                    
                    % 通知队长邀请结果
                    lib_team:notify_leader_invite_result(LeaderId, 1, player:get_name(PS)),
                    lib_team:notify_member_join(NewTeam, NewMember),
					
					%% 如果队长身上有抓鬼任务，让对方自动接取
%% 					case lib_task:get_task_ghost_id(LeaderId) of
%% 						{ok, TaskId} ->
%% 							lib_task:force_accept_ghost_task(player:get_id(PS), TaskId);
%% 						_ ->
%% 							ok
%% 					end,
                    ok
            end
    end.


try_allow_join(PS, JoinPlayerId, TeamId) ->
    case check_allow_join(PS, JoinPlayerId, TeamId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(player:id(PS), Reason);
        ok ->
            do_allow_join(PS, JoinPlayerId, TeamId)
    end.


check_allow_join(PS, JoinPlayerId, TeamId) ->
    try check_allow_join__(PS, JoinPlayerId, TeamId) of
        ok -> ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_allow_join__(PS, JoinPlayerId, TeamId) ->
    ?Ifc (player:get_pid(JoinPlayerId) == null)
        throw(?PM_PLAYER_OFFLINE_OR_NOT_EXISTS)
    ?End,
    ?Ifc (not player:is_leader(PS))
        throw(?PM_NOT_TEAM_LEADER)
    ?End,

    ObjPlayerTeamId = player:get_team_id(JoinPlayerId),

    ?Ifc (ObjPlayerTeamId =:= TeamId)
        throw(?PM_ALREADY_IN_TEAM)
    ?End,

    ?Ifc (ObjPlayerTeamId /= TeamId andalso ObjPlayerTeamId /= ?INVALID_ID)
        throw(?PM_ALREADY_IN_OTHER_TEAM)
    ?End,

    Team = mod_team:get_team_by_id(TeamId),
    ?Ifc (Team == null)
        throw(?PM_TEAM_NOT_EXISTS)
    ?End,

    ?Ifc (lib_team:get_member_by_id(JoinPlayerId, Team#team.members) =/= null)
        throw(?PM_ALREADY_IN_TEAM)
    ?End,

%%    ?Ifc (not mod_team:is_player_in_apply_list(JoinPlayerId, TeamId))
%%        throw(?PM_PARA_ERROR)
%%    ?End,
    ?Ifc (mod_team:is_team_full(TeamId))
        throw(?PM_TEAM_IS_FULL)
    ?End,

    SceneType = case lib_scene:get_obj(player:get_scene_id(PS)) of
                    null -> ?SCENE_T_INVALID;
                    SceneObj -> lib_scene:get_type(SceneObj)
                end,

    ObjPS = player:get_PS(JoinPlayerId),
    ?Ifc (ObjPS =:= null)
        throw(?PM_TARGET_PLAYER_NOT_ONLINE)
    ?End,

    % 玩家在帮派场景切双方帮派不一样
    ?Ifc (SceneType =:= ?SCENE_T_GUILD andalso (player:get_guild_id(PS) =/= player:get_guild_id(ObjPS)))
        throw(?PM_CANT_JOIN_WHEN_IN_GUILD)
    ?End,


    ?Ifc (not player:is_idle(ObjPS))
        throw(?PM_OBJ_BUSY_NOW)
    ?End,

    % 队长在女妖乱斗场景中，不能同意其他场景的玩家入队
    ?Ifc (player:is_in_melee(PS) andalso (player:get_scene_id(PS) =/= player:get_scene_id(ObjPS)))
        throw(?PM_CANT_AGREE_WHEN_IN_MELEE)
    ?End,

    check_add_mb(PS, ObjPS).


do_allow_join(PS, JoinPlayerId, TeamId) ->
    ?ASSERT(player:get_team_id(PS) =:= TeamId),
    case mod_team:get_team_by_id(TeamId) of
        null -> fail;
        Team ->
            % 新加入的玩家默认摆放在阵型的最正面的空位
            % HeadEmptyPos = mod_team:get_head_empty_pos_in_troop(Team),
            % ?TRACE("HeadEmptyPos: ~p~n", [HeadEmptyPos]),
            NewMember = #mb{
                            id = JoinPlayerId, 
                            pid = player:get_pid(JoinPlayerId), 
                            troop_pos = find_first_empty_pos(Team), 
                            train_pos = length(Team#team.members) + 1,
                            name = player:get_name(JoinPlayerId), 
                            state = ?MB_STATE_TEM_LEAVE},
            % 重新生成队员列表
            NewMemberList = 
                case lists:keyfind(JoinPlayerId, #mb.id, Team#team.members) of % 安全起见，先判断队伍里面是否已经有该队员
                    false -> Team#team.members ++ [NewMember];
                    _Any -> Team#team.members
                end,
            ?TRACE("after join, new member list: ~p~n", [NewMemberList]),
            NewApplyList = lists:keydelete(JoinPlayerId, #apply.player_id, Team#team.apply_list),

            %% 如果该玩家在邀请列表则在列表删除
            NewInvitedL = 
                case lists:member(JoinPlayerId, Team#team.invited_list) of
                    false -> Team#team.invited_list;
                    true -> Team#team.invited_list -- [JoinPlayerId]
                end,

            NewTeam = Team#team{apply_list = NewApplyList, members = NewMemberList, invited_list = NewInvitedL},
            mod_team:update_team_to_ets(NewTeam),

            player:set_team_id(JoinPlayerId, TeamId),

            lib_team:notify_member_join(NewTeam, NewMember),
			%% 如果自身有抓鬼任务，让对方自动接取
%% 			case lib_task:get_task_ghost_id(player:get_id(PS)) of
%% 				{ok, TaskId} ->
%% 					lib_task:force_accept_ghost_task(JoinPlayerId, TaskId);
%% 				_ ->
%% 					ok
%% 			end,
            ok
    end.


%% 创建队伍
%% TeamActivityType ->队伍活动类型
%% TargetMonLevel   ->目标怪物等级
%% TeamName         -> 队伍名称
%% @return: {ok, 玩家新状态, 玩家初始在队伍阵型的位置, 队伍当前启用的阵法编号} | {fail, Reason} | ok
try_create_team(PS, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv, TeamName) ->
    case check_create_team(PS, SceneNo, TeamActivityType, Condition1, Condition2, TeamName) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, NewTeamId} ->
            {ok, InitPos, CurUseTroop} = do_create_team(PS, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv, TeamName, NewTeamId),
            {ok, BinData} = pt_24:write(?PT_TM_CREATE, [?RES_OK, NewTeamId, SceneNo, TeamActivityType, Condition1, Condition2, InitPos, CurUseTroop ,MinLv,MaxLv, TeamName, player:get_zf_state(PS)]),
            lib_send:send_to_sock(PS, BinData)
    end.

check_create_team(PS, SceneNo, TeamActivityType, Condition1, Condition2, TeamName) ->
    try check_create_team__(PS, SceneNo, TeamActivityType, Condition1, Condition2, TeamName) of
        {ok, NewTeamId} -> 
            {ok, NewTeamId}
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.

%% @return: {ok, 新队伍id} | throw失败原因（由上层去catch）
check_create_team__(PS, _SceneNo, TeamActivityType, Condition1, Condition2, TeamName) ->
    ?Ifc (not util:in_range(TeamActivityType, ?TM_TYPE_MIN, ?TM_TYPE_MAX))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not util:in_range(Condition1, ?TM_CON1_MIN, ?TM_CON1_MAX))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc ( (not util:in_range(Condition2, ?TM_MON_LV_STEP_MIN, ?TM_MON_LV_STEP_MAX)) )
        throw(?PM_PARA_ERROR)
    ?End,

    % ?ASSERT(is_list(TeamName), TeamName),
    % ?Ifc (not mod_scene_tpl:is_tpl_exists(SceneNo)) 
    %   throw(?PM_SCENE_NOT_EXISTS)
    % ?End,

    % 是否已经加入队伍了？
    ?Ifc (player:is_in_team(PS))
        throw(?PM_ALREADY_IN_TEAM)
    ?End,
    % 是否在战斗中？
    ?Ifc (player:is_battling(PS))
        ?ASSERT(false),     % 正常逻辑不会出现此情况，所以断言失败并且统一throw未知错误
        throw(?PM_UNKNOWN_ERR)
    ?End,

    ?Ifc (not player:is_idle(PS))
        throw(?PM_BUSY_NOW)
    ?End,

    case mod_team:is_team_name_valid(TeamName) of
        {false, len_error} ->
            throw(?PM_TEAM_NAME_LEN_ERROR);
        {false, char_illegal} ->
            throw(?PM_TEAM_NAME_CHAR_ILLEGEL);
        true ->
            %家园不属于副本，通过场景id去判断能否组队
             
               ?Ifc(lib_scene:is_home_scene(player:get_scene_id(PS)))
                     throw(?PM_CANT_CREATE_TM_WHEN_YOU_IN_DUNGEON)
               ?End,

               ?Ifc(lib_scene:is_guild_dungeon_scene(player:get_scene_id(PS)))
                    throw(?PM_CANT_CREATE_TM_WHEN_YOU_IN_DUNGEON)
               ?End,
            case player:is_in_dungeon(PS) of
                {true, _Pid} -> 
                    DunType = lib_dungeon:get_dungeon_type(player:get_dungeon_no(PS)),
                    if
                        DunType =:= ?DUNGEON_TYPE_BOSS ->
                            NewId = mod_id_alloc:next_comm_id(),
                            {ok, NewId};
                        DunType =:= ?DUNGEON_TYPE_GUILD_PREPARE ->
                            NewId = mod_id_alloc:next_comm_id(),
                            {ok, NewId};
                        DunType =:= ?DUNGEON_TYPE_GUILD_BATTLE ->
                            NewId = mod_id_alloc:next_comm_id(),
                            {ok, NewId};
                        true ->
                            throw(?PM_CANT_CREATE_TM_WHEN_YOU_IN_DUNGEON)
                    end;
                false ->
                    % 请求获取一个新id，用于标识队伍
                    NewId = mod_id_alloc:next_comm_id(),
                    {ok, NewId}
            end
    end.


do_create_team(PS, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv,  TeamName, NewTeamId) ->
    % 默认选第一个阵法，并排在最正面的位置
    % CurUseTroop = lib_troop:get_my_cur_use_troop_cfgdata(player:get_id(PS)), % 阵法数据策划还没定
    %%?TRACE("CurUseTroop: ~p~n", [CurUseTroop]),
    %?ASSERT(CurUseTroop /= null), 暂时屏蔽
    %[HeadPos | _TailPos] = CurUseTroop#troop_cfg.battle_order,
    HeadPos = 1, % 测试写死
    Mb = #mb{
        id = player:get_id(PS),             % 队员id
        pid = player:get_pid(PS),           % 队员pid
        troop_pos = HeadPos,                % 队员在队伍阵型中的位置(1~9)
        train_pos = 1,
        name = player:get_name(PS),         % 队员名字
        state = ?MB_STATE_IN                % 玩家状态：1 暂离，2 在队在线 3 在队离线
        },

    NewTeam = #team{
                    team_id = NewTeamId,
                    leader_id = player:get_id(PS),
                    leader_pid = player:get_pid(PS),
                    leader_name = player:get_name(PS),
                    scene = SceneNo,
                    create_time = svr_clock:get_unixtime(),
                    members = [Mb],
                    troop_no = ply_zf:get_common_zf(), % 普通阵法
                    team_activity_type = TeamActivityType,
                    condition1 = Condition1,
                    condition2 = Condition2,
                    lv_range = {MinLv,MaxLv},
                    team_name = list_to_binary(TeamName)
                    },

    mod_team:add_team_to_ets(NewTeam),
            
    player:set_team_id(PS, NewTeamId),
    player:mark_leader_flag(PS),

    % 通知邻近的玩家
    lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_LEADER_FLAG, 1}, {?OI_CODE_TEAM_ID, NewTeamId}]),
    %lib_team:notify_leader_flag_changed_to_neig(PS, 1),
    % 广播给全服：新增了一个队伍 ?? -- 目前不做，以后看需求是否做
    %{ok, HeadPos, CurUseTroop#troop_cfg.id}.
    {ok, HeadPos, NewTeam#team.troop_no}.


% 向队长发送申请列表
send_team_apply_info(NewTeam) ->
    case player:get_PS(NewTeam#team.leader_id) of
        null -> skip;
        PS ->
            case mod_team:query_apply_list(PS, NewTeam#team.team_id) of
                {fail, Reason} ->
                    {fail, Reason};
                DataList ->
                    {ok, BinData} = pt_24:write(?PT_TM_QRY_APPLY_LIST, DataList),
                    lib_send:send_to_uid(NewTeam#team.leader_id, BinData)
            end
    end.

%% ok | throw:FailReason
check_add_mb(PS, ObjPS) ->
    check_add_mb(PS, ObjPS, ?PM_CANT_JOIN_WHEN_IN_DUNGEON).

check_add_mb(PS, ObjPS, LimitTips) ->
    case player:is_in_dungeon(ObjPS) of
        {true, _DungeonPid} ->
            DunType = lib_dungeon:get_dungeon_type(player:get_dungeon_no(ObjPS)),
            if
                DunType =:= ?DUNGEON_TYPE_BOSS orelse DunType =:= ?DUNGEON_TYPE_GUILD_PREPARE orelse DunType =:=  ?DUNGEON_TYPE_GUILD_BATTLE ->
                    case player:is_in_dungeon(PS) of
                        {true, _} ->
                            DunType1 = lib_dungeon:get_dungeon_type(player:get_dungeon_no(PS)),
                            if
                                DunType1 =:= ?DUNGEON_TYPE_BOSS ->
                                    ok;
                                DunType1 =:= ?DUNGEON_TYPE_GUILD_PREPARE andalso DunType =:= DunType1 ->
                                    case player:get_guild_id(PS) =:= player:get_guild_id(ObjPS) of
                                        false -> throw(?PM_TM_AIM_NOT_THE_SAME);
                                        true -> ok
                                    end;
                                DunType1 =:= ?DUNGEON_TYPE_GUILD_BATTLE andalso DunType =:= DunType1 ->
                                    case player:get_guild_id(PS) =:= player:get_guild_id(ObjPS) of
                                        false -> throw(?PM_TM_AIM_NOT_THE_SAME);
                                        true -> ok
                                    end;
                                true ->
                                    throw(LimitTips)
                            end;
                        false -> throw(LimitTips)
                    end;
                true ->
                    throw(LimitTips)
            end;
        false ->
            case player:is_in_dungeon(PS) of
                {true, _Any} ->
                    throw(LimitTips);
                false ->
                    ok
            end
    end.

do_single_teleport(PS, SceneId, X, Y) ->
    case player:get_pid(PS) of
        null -> skip;
        Pid -> gen_server:cast(Pid, {'do_single_teleport', SceneId, X, Y})
    end.


find_first_empty_pos(Team) ->
    L = [1, 2, 3, 4, 5],
    F = fun(Mb, Acc) ->
        [Mb#mb.troop_pos | Acc]
    end,
    UseL = lists:foldl(F, [], Team#team.members),
    RetL = L -- UseL,
    case RetL =:= [] of
        true ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_team_mgr:find_first_empty_pos error!~n", []),
            ?INVALID_NO;
        false ->
            erlang:hd(lists:sort(RetL))
    end.