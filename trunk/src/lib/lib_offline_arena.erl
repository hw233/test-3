%%%-----------------------------------
%%% @Module  : mod_offline_arena
%%% @Author  : lds
%%% @Email   :
%%% @Created : 2013.12
%%% @Description: 离线竞技场
%%%-----------------------------------
-module (lib_offline_arena).

-include("common.hrl").
-include("record.hrl").
-include("offline_arena.hrl").
-include("offline_data.hrl").
-include("prompt_msg_code.hrl").
-include("activity_degree_sys.hrl").
-include("log.hrl").
-include("sys_code.hrl").

-compile(export_all).

%% ====================================================================
%% API functions
%% ====================================================================

%% @doc 登录时进行因升级流程没有通知竞技场进行相应处理的容错措施
login_correct(Status) ->
    save_arena_offline_data(Status),
    gen_server:cast(player:get_pid(Status), {'apply_cast', ?MODULE, correct_group, [player:id(Status)]}).

correct_group(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) -> 
            Group = get_actual_group(RoleId),
            fix_arena_group(Group, get_group(Status), Status);
            % case Group =:= get_group(Status) of
            %     true -> skip;
            %     false -> 
            %         case Group =:= null of
            %             true -> novice_debut(Status);
            %             false -> change_arena_group(Status)
            %         end
            % end;
        _ -> ?ERROR_MSG("[offline_arena] no find PS by RoleId = ~p~n", [RoleId])
    end.



%% @doc 取得竞技场组别
get_actual_group(RoleId) ->
    case get_offline_arena_rd(RoleId) of
        Arena when is_record(Arena, offline_arena) ->
            Arena#offline_arena.group;
        _ -> null
    end.


%% @doc 取得个人竞技场组别
%% @return  null | group::integer()
get_group(Status) ->
	%% 屏蔽其他组，都用新手组
%% 	?OA_NOVICE.
    Lv = player:get_lv(Status),
    EnterNoviceLv = ?ENTER_NOVICE_LV,

	%% 只用新手组
	if 
		Lv < EnterNoviceLv ->
			null;
		true ->
			?OA_NOVICE
	end.
	
%%     if  Lv < EnterNoviceLv -> null;
%%         Lv < ?ENTER_BRONZE_LV -> ?OA_NOVICE;
%%         Lv < ?ENTER_SILVER_LV -> ?OA_BRONZE;
%%         Lv < ?ENTER_GOLD_LV -> ?OA_SILVER;
%%         Lv < ?ENTER_DIAMOND_LV -> ?OA_GOLD;
%%         Lv < ?ENTER_EMPEROR_LV -> ?OA_DIAMOND;
%%         true -> ?OA_EMPEROR
%%     end.


fix_arena_group(Group, Group, _Status) -> skip;
fix_arena_group(null, ?OA_NOVICE, Status) -> novice_debut(Status);
fix_arena_group(null, Group, Status) when Group > ?OA_NOVICE ->
    span_to_group(null, Group, Status);
fix_arena_group(OldGroup, NewGroup, Status) -> 
    span_to_group(OldGroup, NewGroup, Status).


%% @doc 加载个人基本信息
get_self_base_info(Status) ->
    RoleId = player:id(Status),
    case get_offline_arena_rd(RoleId) of
        OldArena when is_record(OldArena, offline_arena) ->
            % fix_ranking(RoleId, OldArena#offline_arena.group),
            Arena = update_arena_cd(OldArena, Status),
            % ?LDS_TRACE(get_self_base_info, {Arena#offline_arena.rank, get_ranking_by_role_id(Arena)}),
            % Now = util:unixtime(),
            {WS, RewardWS} = {Arena#offline_arena.winning_streak, Arena#offline_arena.reward_ws},
            {HisGroup, HisRank} =
                case mod_offline_arena:get_ranking_stamp(RoleId) of
                    null -> {Arena#offline_arena.group, 0};
                    RankStamp when is_record(RankStamp, ranking_stamp) ->
                        {RankStamp#ranking_stamp.group, RankStamp#ranking_stamp.rank}
                end,
            Info = [Arena#offline_arena.group, Arena#offline_arena.rank,
                ?MAX_CHALLANGE_TIMES(player:get_vip_lv(Status)), get_left_challenge_times(Arena, Status),
                WS, RewardWS, Arena#offline_arena.refresh_stamp + ?REFRESH_RANKING_CD,
                get_ranking_reward_state(Arena), Arena#offline_arena.challange_stamp + get_challenge_cd(Status),
                get_challange_times(Arena, Status), Arena#offline_arena.reward_chal, Arena#offline_arena.his_max_ws_no,
                HisGroup, HisRank
                ],
            % ?LDS_DEBUG(get_self_base_info, Info),
            {ok, BinData} = pt_23:write(23001, Info),
            lib_send:send_to_sock(Status#player_status.socket, BinData),
            ok;
        _T -> ?ASSERT(false, [_T, player:id(Status), player:get_lv(Status)]), skip
    end.


%% @doc 加载个人战报
get_self_combat_info(Status) ->
    RoleId = player:id(Status),
    case get_offline_arena_rd(RoleId) of
        Arena when is_record(Arena, offline_arena) ->
            {ok, BinData} = pt_23:write(23002, [Arena#offline_arena.battle_history]),
            lib_send:send_to_sock(Status, BinData),
            ok;
        _ -> ?ASSERT(false), skip
    end.

%% @doc 加载单条个人战报
get_single_combat_info(Bh, Status) ->
    {ok, BinData} = pt_23:write(23003, [Bh]),
    lib_send:send_to_sock(Status#player_status.socket, BinData).


%% @doc 加载个人奖励信息
% get_self_reward_info(Status) ->
%     RoleId = player:id(Status),
%     case get_offline_arena_rd(RoleId) of
%         OldArena when is_record(OldArena, offline_arena) ->
%             Arena = update_arena_cd(OldArena, Status),
%             Now = util:unixtime(),
%             case util:is_refresh_daily_hour(Now, Arena#offline_arena.reward_stamp, ?REWARD_REFRESH_TIME) of
%                 false -> {ok, BinData} = pt_23:write(23004, [Arena#offline_arena.reward_stamp + ?REWARD_CD,
%                             ?MAX_REWARD_TIMES - Arena#offline_arena.reward_times]),
%                         lib_send:send_to_sock(Status#player_status.socket, BinData);
%                 true ->
%                         NewArena = Arena#offline_arena{reward_times = 0, reward_stamp = 0},
%                         update_offline_arena(NewArena),
%                         {ok, BinData} = pt_23:write(23004, [NewArena#offline_arena.reward_stamp, ?MAX_REWARD_TIMES]),
%                         lib_send:send_to_sock(Status#player_status.socket, BinData)
%             end;
%         _ -> ?ASSERT(false), skip
%     end.


%% @doc 加载排名信息
get_arena_ranking_info(Status) ->
    case get_offline_arena_rd(player:id(Status)) of
        Arena when is_record(Arena, offline_arena) ->
            Rank = Arena#offline_arena.rank,
            RankSeed = Arena#offline_arena.rank_seed,
            GapRanking = get_arena_ranking_gap_info(Rank, RankSeed, Arena#offline_arena.group),
            {ok, BinData} = pt_23:write(23005, [GapRanking]),
            lib_send:send_to_sock(Status#player_status.socket, BinData),
            ok;
        _ -> ?ASSERT(false), skip
    end.


%% @doc 加载英雄榜信息并广播
%% @return  [#offline_arena_role_info{}]
get_hero_ranking_info_broadcast(Group, RankList, Status) ->
    F = fun(Rank, Sum) ->
            case get_offline_arena_role_info(Rank, Group) of
                Rd when is_record(Rd, offline_arena_role_info) -> [Rd | Sum];
                _ -> Sum
            end
        end,
    Data = lists:foldl(F, [], RankList),
    {ok, BinData} = pt_23:write(23006, [Data]),
    lib_send:send_to_sock(Status#player_status.socket, BinData).



%% @doc 加载英雄榜信息
%% @return  [#offline_arena_role_info{}]
get_hero_ranking_info(Group, RankList) ->
    F = fun(Rank, Sum) ->
            case get_offline_arena_role_info(Rank, Group) of
                Rd when is_record(Rd, offline_arena_role_info) -> [Rd | Sum];
                _ -> Sum
            end
        end,
    % ?LDS_TRACE(get_hero_ranking_info, [RankList]),
    lists:foldl(F, [], RankList).


%% @doc 领取连胜奖励
get_winning_streak_reward(Status, Index) ->
    RoleId = player:id(Status),
    case get_offline_arena_rd(RoleId) of
        OldArena when is_record(OldArena, offline_arena) ->
            Arena = update_arena_cd(OldArena, Status),
            case Arena#offline_arena.his_max_ws_no >= Index andalso Arena#offline_arena.reward_ws < Index of
                true ->
                    case data_offline_arena:get_ws_reward(Index) of
                        Rid when is_integer(Rid) ->
                            case lib_reward:check_bag_space(Status, Rid) of
                                ok ->
                                    update_offline_arena(Arena#offline_arena{reward_ws = Index}),
                                    lib_reward:give_reward_to_player(common, Status, Rid, [], [?LOG_OA, "winning"]),
                                    {ok, BinData} = pt_23:write(23007, [?WINNING_STREAK_TYPE, ?OA_SUCCESS, Arena#offline_arena.winning_streak, Index]),
                                    lib_send:send_to_sock(Status#player_status.socket, BinData);
                                {fail, Reason} ->
                                    lib_send:send_prompt_msg(Status, Reason)
                            end;
                        _ -> lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_NOT_FOUND_REWARD)
                    end;
                false ->
                    lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_REWARD_NOT_ENGOUTH_CONDITION)
            end;
        _ -> ?ASSERT(false), skip
    end.

%% @doc 领取场次奖励
get_challange_times_reward(Status, Index) ->
    RoleId = player:id(Status),
    case get_offline_arena_rd(RoleId) of
        OldArena when is_record(OldArena, offline_arena) ->
            Arena = update_arena_cd(OldArena, Status),
            case get_challange_times(Arena, Status) >= Index andalso Arena#offline_arena.reward_chal < Index of
                true ->
                    case data_offline_arena:get_chal_times_reward(Index) of
                        Rid when is_integer(Rid) ->
                            case lib_reward:check_bag_space(Status, Rid) of
                                ok ->
                                    update_offline_arena(Arena#offline_arena{reward_chal = Index}),
                                    lib_reward:give_reward_to_player(common, Status, Rid, [], [?LOG_OA, "winning"]),
                                    {ok, BinData} = pt_23:write(23007, [?CHALENGE_TIMES_TYPE, ?OA_SUCCESS, get_challange_times(Arena, Status), Index]),
                                    lib_send:send_to_sock(Status#player_status.socket, BinData);
                                {fail, Reason} ->
                                    lib_send:send_prompt_msg(Status, Reason)
                            end;
                        _ -> lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_NOT_FOUND_REWARD)
                    end;
                false ->
                    lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_REWARD_NOT_ENGOUTH_CONDITION)
            end;
        _ -> ?ASSERT(false), skip
    end.


%% 取消挑战CD
cancel_challenge_cd(Status) ->
    RoleId = player:id(Status),
    case get_offline_arena_rd(RoleId) of
        TmpArena when is_record(TmpArena, offline_arena) ->
            Arena = update_arena_cd(TmpArena, Status),
            Now = util:unixtime(),
            case get_left_challenge_times(Arena, Status) > 0 of
                false -> lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_CHALL_NOT_TIMES);
                true ->
                    case (Now - Arena#offline_arena.challange_stamp) > get_challenge_cd(Status) of
                        true -> lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_CHALL_NOT_CD);
                        false ->
							case player:has_enough_money(Status, ?MNY_T_BIND_YUANBAO, ?CANCEL_CHALL_CD_MONEY) of
%%                             case player:has_enough_gamemoney(Status, ?CANCEL_CHALL_CD_MONEY) of
                                true ->
                                    player:cost_money(Status, ?MNY_T_BIND_YUANBAO, ?CANCEL_CHALL_CD_MONEY, [?LOG_OA, "clear_CD"]),
%%                             		player:cost_gamemoney(Status, ?CANCEL_CHALL_CD_MONEY, [?LOG_OA, "clear_CD"]),
                                    update_offline_arena(Arena#offline_arena{challange_stamp = 0}),
                                    get_self_base_info(Status);
                                false -> lib_send:send_prompt_msg(Status, ?PM_GAMEMONEY_LIMIT)
                            end
                    end
            end;
        _ -> ?ASSERT(false)
    end.


%%　购买挑战次数
buy_challenge_times(Status) ->
    RoleId = player:id(Status),
    case get_offline_arena_rd(RoleId) of
        TmpArena when is_record(TmpArena, offline_arena) ->
            Arena = update_arena_cd(TmpArena, Status),
            case Arena#offline_arena.challenge_buy_times >= get_max_challenge_buy_times(Status) of
                true -> lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_BUY_CHALL_NOT_TIMES);
                false ->
                    case player:has_enough_money(Status, ?MNY_T_BIND_YUANBAO, ?BUY_CHALLANGE_TIMES_MONEY) of
                        true ->
                            player:cost_money(Status, ?MNY_T_BIND_YUANBAO, ?BUY_CHALLANGE_TIMES_MONEY, [?LOG_OA, "buy_times"]),
                            update_offline_arena(Arena#offline_arena{challenge_buy_times = Arena#offline_arena.challenge_buy_times + 1}),
                            get_self_base_info(Status);
                        false -> lib_send:send_prompt_msg(Status, ?PM_GAMEMONEY_LIMIT)
                    end
            end;
        _ -> ?ASSERT(false)
    end.


%% @doc 领取奖励
% get_reward(Status) ->
%     RoleId = player:id(Status),
%     case get_offline_arena_rd(RoleId) of
%         Arena when is_record(Arena, offline_arena) ->
%             Now = util:unixtime(),
%             NewArena =
%                 case util:is_refresh_daily_hour(Now, Arena#offline_arena.reward_stamp, ?REWARD_REFRESH_TIME) of
%                     false -> Arena;
%                     true ->
%                         Arena1 = Arena#offline_arena{reward_times = 0, reward_stamp = 0},
%                         update_offline_arena(Arena1),
%                         Arena1
%                 end,
%             {Flag, Times, Stamp} = send_reward(NewArena, Now, Status),
%             NewTimes = ?BIN_PRED(?MAX_REWARD_TIMES >= Times, ?MAX_REWARD_TIMES - Times, 0),
%             NewStamp =
%                 case NewTimes =:= 0 of
%                     true -> ?ONE_DAY_SECONDS - calendar:time_to_seconds(time()) + ?REWARD_REFRESH_TIME * 3600 + Now;
%                     false -> Stamp + ?REWARD_CD
%                 end,

%             {ok, BinData} = pt_23:write(23008, [Flag, NewTimes, NewStamp]),
%             lib_send:send_to_sock(Status#player_status.socket, BinData);
%         _ -> ?ASSERT(false), skip
%     end.

%% @doc 领取排名奖励
get_ranking_reward(Status) ->
    RoleId = player:id(Status),
    case get_offline_arena_rd(RoleId) of
        OldArena when is_record(OldArena, offline_arena) ->
            Arena = update_arena_cd(OldArena, Status),
            case can_get_ranking_reward(Arena) of
                true -> query_cal_ranking_state(Arena#offline_arena.group);
                false -> lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_RANKING_UN_OPEN)
            end,
            redo;
        _ ->
            ?ASSERT(false),
            lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR)
    end.

%% 查询排名快照状态
query_cal_ranking_state(_Group) ->
    gen_server:cast(?OA_MANAGE, {'query_cal_ranking', self()}).

%% 是否能领取排名奖励
%% @return integer()
can_get_ranking_reward(Arena) ->
    if  Arena#offline_arena.update_stamp =:= Arena#offline_arena.create_stamp -> false;
        Arena#offline_arena.update_stamp =:= Arena#offline_arena.reward_stamp -> false;
        true -> true
    end.


get_ranking_reward_state(Arena) ->
    if  Arena#offline_arena.update_stamp =:= Arena#offline_arena.create_stamp -> 0;
        Arena#offline_arena.update_stamp =:= Arena#offline_arena.reward_stamp -> 2;
        true -> 1
    end.


%% 经过确认安全情况下发送奖励
ensure_to_send_reward(Status) ->
    RoleId = player:id(Status),
    case get_offline_arena_rd(RoleId) of
        Arena when is_record(Arena, offline_arena) ->
            case mod_offline_arena:get_ranking_stamp(RoleId) of
                null ->
                    case get_reward_id_by_rank(Arena#offline_arena.group, ?RANKING_OUTER_VAL) of
                        null -> ?ASSERT(false, [Arena]);
                        Rid ->
                            case lib_reward:check_bag_space(Status, Rid) of
                                ok ->
                                    update_offline_arena(Arena#offline_arena{reward_stamp = Arena#offline_arena.update_stamp}),
                                    lib_reward:give_reward_to_player(Status, Rid, [?LOG_OA, "prize"]),
                                    get_self_base_info(Status);
                                {fail, Reason} -> lib_send:send_prompt_msg(Status, Reason)
                            end
                    end;  % 发送榜外奖励
                Rd when is_record(Rd, ranking_stamp) ->
                    case get_reward_id_by_rank(Rd#ranking_stamp.group, Rd#ranking_stamp.rank) of
                        null -> ?ASSERT(false, [Arena]);
                        Rid ->
                            case lib_reward:check_bag_space(Status, Rid) of
                                ok ->
                                    mod_offline_arena:delete_ranking_stamp(Rd#ranking_stamp.id),
                                    update_offline_arena(Arena#offline_arena{reward_stamp = Arena#offline_arena.update_stamp}),
                                    lib_reward:give_reward_to_player(Status, Rid, [?LOG_OA, "prize"]),
                                    get_self_base_info(Status);
                                {fail, Reason} -> lib_send:send_prompt_msg(Status, Reason)
                            end
                    end
            end;
        _ -> ?ASSERT(false)
    end.

%% 取得当天挑战场次
get_challange_times(Arena, _Status) ->
    Times = Arena#offline_arena.challange_times,
    ?BIN_PRED(Times > 0, Times, 0).


get_challenge_cur_times(_Timestamp, Status) ->
    case get_offline_arena_rd(player:id(Status)) of
        TmpArena when is_record(TmpArena, offline_arena) ->
            Arena = update_arena_cd(TmpArena, Status),
            get_challange_times(Arena, Status);
        _ -> 0
    end.

%% @doc 刷新排名
refresh_ranking_list(Status) ->
    case get_offline_arena_rd(player:id(Status)) of
        Arena when is_record(Arena, offline_arena) ->
            Now = util:unixtime(),
            case (Now - ?REFRESH_RANKING_CD) > Arena#offline_arena.refresh_stamp of
                true ->
                    NewArena = Arena#offline_arena{refresh_stamp = Now,
                        rank_seed = get_new_rank_seed(Arena#offline_arena.rank_seed)},
                    update_offline_arena(NewArena),
                    get_arena_ranking_info(Status),
                    {ok, BinData} = pt_23:write(23009, [Now + ?REFRESH_RANKING_CD]),
                    lib_send:send_to_sock(Status#player_status.socket, BinData);
                false ->
                    {ok, BinData} = pt_23:write(23009, [Arena#offline_arena.refresh_stamp + ?REFRESH_RANKING_CD]),
                    lib_send:send_to_sock(Status#player_status.socket, BinData)
            end;
        _ -> ?ASSERT(false), skip
    end.


%% 处理广播
broadcast_first_place_change(Group, LostId, WinId) ->
    % ?LDS_DEBUG(broadcast_first_place_change, [WinId, LostId]),
    ply_tips:send_sys_tips(null, {arena_top_1, [player:get_name(WinId), WinId, 
        player:get_name(LostId), LostId, Group]}).

broadcast_win_streak(RoleId, Streak) when is_integer(RoleId) andalso Streak =:= 10 ->
    ply_tips:send_sys_tips(null, {arena_win_last_10, [player:get_name(RoleId), RoleId]});
broadcast_win_streak(Status, Streak) when Streak =:= 10 ->
    ply_tips:send_sys_tips(null, {arena_win_last_10, [player:get_name(Status), player:id(Status)]});
broadcast_win_streak(_, _) -> skip.


%% @doc 处理占坑成功的数据更新
handle_occupy_scuess(Status, Ranking) ->
    case get_offline_arena_rd(player:id(Status)) of
        OldArena when is_record(OldArena, offline_arena) ->
            Arena = update_arena_cd(OldArena, Status),
            Money = send_battle_reward(Status, 1, Arena#offline_arena.group),
            Bh = make_occupy_bh(Arena, Money),
            InivAllBh = add_bh(Arena#offline_arena.battle_history, Bh),
            % TimeStamp = util:unixtime(),
            {WS, RewardWS} = {Arena#offline_arena.winning_streak + 1, Arena#offline_arena.reward_ws},
            Arena1 = Arena#offline_arena{battle_history = InivAllBh, winning_streak = WS, reward_ws = RewardWS},
            NewArena = send_win_streak_reward(Arena1, Status),

            update_offline_arena(NewArena#offline_arena{rank = Ranking}),

            update_arena_offline_data(Status),

            %% 日志统计
            % lib_log:statis_offline_arena(Status, NewArena#offline_arena.group, NewArena#offline_arena.rank),
            catch mod_achievement:notify_achi(win_offline_arena, [], Status),

            lib_offline_arena:get_single_combat_info(Bh, Status),
            lib_offline_arena:get_self_base_info(Status),
            broadcast_win_streak(Status, NewArena#offline_arena.winning_streak),
            lib_offline_arena:get_arena_ranking_info(Status);
        _ -> ?ASSERT(false)
    end.


%% @doc 接受玩家挑战对手请求
handle_challenge_warrior_request(ChalRoleId, Rank, Status) ->
    RoleId = player:id(Status),
    case get_offline_arena_rd(RoleId) of
        OldArena when is_record(OldArena, offline_arena) ->
            Arena = update_arena_cd(OldArena, Status),
            case ChalRoleId =:= get_role_id_by_ranking(Rank, Arena#offline_arena.group) of
                true -> challenge_warrior(ChalRoleId, Rank, Status, Arena);
                false -> lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_RANK_TIMEOUT)
            end;
        _ -> lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR)
    end.



%% @doc 挑战玩家
challenge_warrior(ChalRoleId, Rank, Status, Arena) when ChalRoleId =:= ?RANKING_BLANK_VAL ->
    RoleId = player:id(Status),
    ChalTimes = get_left_challenge_times(Arena, Status),
    case ChalTimes > 0 of
        true ->
            Now = util:unixtime(),
            case Arena#offline_arena.challange_stamp =:= 0 orelse (Now - Arena#offline_arena.challange_stamp) > get_challenge_cd(Status) of
                false -> lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_CHALL_IN_CD);
                true ->
                    MyRank = Arena#offline_arena.rank,
                    case MyRank =< Rank andalso MyRank =/= ?RANKING_OUTER_VAL of
                        true -> skip;
                        false ->
                            gen_server:cast(?GET_PROC_NAME(Arena#offline_arena.group),
                                {occupy_ranking, {Arena#offline_arena.rank, RoleId, self()}, {Rank, ?RANKING_BLANK_VAL}}),							
                            update_offline_arena(Arena#offline_arena{challange_times = Arena#offline_arena.challange_times + 1,
                                challange_stamp = Now}),
                            lib_event:event(offline_arena_battle, [], Status),
                            lib_activity_degree:publ_add_sys_activity_times(?AD_DUN_ARENA, Status)
                    end
            end;
        false -> lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_CHALL_NOT_TIMES) 
    end;

challenge_warrior(ChalRoleId, Rank, Status, Arena) ->
    RoleId = player:id(Status),
    case get_lock(?OA_LOCK) of
        ?RANK_LOCK -> lib_send:send_prompt_msg(Status, ?PM_OP_FREQUENCY_LIMIT);
        ?UN_RANK_LOCK ->
            ChalTimes = get_left_challenge_times(Arena, Status),
            case ChalTimes > 0 of
                true ->
                    Now = util:unixtime(),
                    case Arena#offline_arena.challange_stamp =:= 0 orelse (Now - Arena#offline_arena.challange_stamp) > get_challenge_cd(Status) of
                        true ->
                            Group = Arena#offline_arena.group,
                            RealRoleId = get_role_id_by_ranking(Rank, Group),
                            case RealRoleId =:= ChalRoleId of
                                true ->
                                    case start_arena_battle(Status, ChalRoleId, Group) of
                                        true -> 
                                            save_temp_ranking(RoleId, ChalRoleId, Rank),
                                            update_offline_arena(Arena#offline_arena{challange_times = Arena#offline_arena.challange_times + 1,
                                                challange_stamp = Now}),
                                            lib_activity_degree:publ_add_sys_activity_times(?AD_DUN_ARENA, Status),
                                            lock_choice(?OA_LOCK);
                                        false -> skip
                                    end;
                                false ->
                                    {ok, BinData} = pt_23:write(23010, [?WRONG_ROLE]),
                                    lib_send:send_to_sock(Status#player_status.socket, BinData)
                            end;
                        false -> lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_CHALL_IN_CD)
                    end;
                false ->
                    {ok, BinData} = pt_23:write(23010, [?NOT_ECOUGHT_TIMES]),
                    lib_send:send_to_sock(Status#player_status.socket, BinData)
            end
    end.


start_arena_battle(Status, ChalRoleId, Group) ->
    case mod_offline_data:get_offline_bo(ChalRoleId, ?OBJ_PLAYER, ?SYS_OFFLINE_ARENA) of
        null ->false;
        Bo -> 
            mod_offline_arena:set_except_ranking(player:id(Status), ChalRoleId, get_ranking_by_role_id(ChalRoleId, Group)),
            mod_battle:start_offline_arena(Status, Bo), 
            true
    end.



%% @doc 根据等级触发自动进入某一组竞技场
enter_arena_group(Status) ->
    % Lv = player:get_lv(Status),
    save_arena_offline_data(Status),
    % ChangeRankFlag = lists:member(Lv, ?OA_CHANGE_RANK_LV),
    % OpenLv = ?OA_OPEN_LV,
    case player:get_lv(Status) >= ?OA_OPEN_LV of
        false -> skip;
        true -> 
            case get_offline_arena_rd(player:id(Status)) of
                Arena when is_record(Arena, offline_arena) -> 
                    Group = get_actual_group(player:id(Status)),
                    fix_arena_group(Group, get_group(Status), Status);  
                    % ?BIN_PRED(lists:member(Lv, ?OA_CHANGE_RANK_LV), change_arena_group(Status), skip);
                _ -> novice_debut(Status)
            end
    end.


%% @doc 更新个人排行榜数据
update_offline_arena(Arena) ->
    case Arena#offline_arena.winning_streak >= Arena#offline_arena.his_max_ws_no of
        true -> ets:insert(?ETS_ROLE_OFFLINE_ARENA, Arena#offline_arena{his_max_ws_no = Arena#offline_arena.winning_streak});
        false -> ets:insert(?ETS_ROLE_OFFLINE_ARENA, Arena)
    end.

del_offline_arena(Arena) ->
    ets:delete(?ETS_ROLE_OFFLINE_ARENA, Arena#offline_arena.id).

%% @doc 并发进程存储offline_arena数据
spawn_save_offline_arena(Arena) ->
    util:actin_new_proc(?MODULE, db_save_offline_arena, [Arena]).


%% @doc 竞技场战斗结束反馈
% battle_feekback(InivRoleId, PasiRoleId, Result, Status) when Result =:= win ->
%     release_lock(?OA_LOCK),
%     ?LDS_DEBUG("[offline_arena] battle_feekback", [InivRoleId, PasiRoleId, Result]),
%     InivArena = get_offline_arena_rd(InivRoleId),
%     InivRank = InivArena#offline_arena.rank,
%     Group = InivArena#offline_arena.group,
%     case get_temp_ranking(InivRoleId, PasiRoleId) of
%         null -> ?ASSERT(false, [InivRoleId, PasiRoleId]);
%         PasiRank ->
%             case InivRank > PasiRank orelse InivRank =:= ?RANKING_OUTER_VAL of
%                 true -> 
%                     gen_server:cast(?GET_PROC_NAME(Group), {battle_feekback, InivRoleId, InivRank, PasiRoleId, PasiRank});
%                 false ->
%                     TimeStamp = util:unixtime(),
%                     case get_offline_arena_rd(InivRoleId) of
%                         OldArena when is_record(OldArena, offline_arena) ->
%                             Arena = update_arena_cd(OldArena, Status),
%                             PasiBref = mod_offline_data:get_offline_role_brief(PasiRoleId),
%                             PasiName = PasiBref#offline_role_brief.name,
%                             % Feat = data_offline_arena:get_feat(Group, win_point),
%                             % player:add_feat(Status, Feat),
%                             Money = data_offline_arena:get_feat(Group, win_point),       % feat -> bind_gamemoney (new)
%                             player:add_money(Status, ?MNY_T_BIND_GAMEMONEY, Money, [?LOG_OA, "battle"]),
%                             InivBh = make_battle_history(TimeStamp, PasiName, ?OA_BATTLE_WIN, Money, Group, ?INIV_BATTLE, ?OA_RANK_STATIC, InivRank, 0),
%                             InivAllBh = add_bh(Arena#offline_arena.battle_history, InivBh),
%                             {WS, RewardWS} = {Arena#offline_arena.winning_streak + 1, Arena#offline_arena.reward_ws},
%                             Arena1 = Arena#offline_arena{battle_history = InivAllBh, winning_streak = WS, reward_ws = RewardWS},
%                             NewArena = send_win_streak_reward(Arena1, Status),
%                             update_offline_arena(NewArena),
%                             get_single_combat_info(InivBh, Status),
%                             broadcast_win_streak(Status, NewArena#offline_arena.winning_streak),
%                             get_self_base_info(Status);
%                         _T -> ?ASSERT(false, [_T])
%                     end,
%                     %% 日志统计
%                     lib_log:statis_offline_arena(Status, Group, InivRank),
%                     InivName = player:get_name(Status),
%                     PasiBh = make_battle_history(TimeStamp, InivName, ?OA_BATTLE_LOSE, 0, Group, ?PASI_BATTLE, ?OA_RANK_STATIC, PasiRank, 0),
%                     case player:is_online(PasiRoleId) of
%                         true ->
%                             case get_offline_arena_rd(PasiRoleId) of
%                                 PasiArena when is_record(PasiArena, offline_arena) ->
%                                     PasiAllBh = add_bh(PasiArena#offline_arena.battle_history, PasiBh),
%                                     update_offline_arena(PasiArena#offline_arena{battle_history = PasiAllBh});
%                                 _ -> ?ASSERT(false), db_save_offline_arena(PasiRoleId, PasiBh)
%                             end;
%                         _ -> db_save_offline_arena(PasiRoleId, PasiBh)
%                     end
%             end
%     end,
%     del_temp_ranking(InivRoleId, PasiRoleId);
% battle_feekback(InivRoleId, PasiRoleId, _Result, Status) ->
%     release_lock(?OA_LOCK),
    
%     del_temp_ranking(InivRoleId, PasiRoleId),
%     TimeStamp = util:unixtime(),
%     case get_offline_arena_rd(InivRoleId) of
%         Arena when is_record(Arena, offline_arena) ->
%             Group = Arena#offline_arena.group,
%             PasiBref = mod_offline_data:get_offline_role_brief(PasiRoleId),
%             PasiName = PasiBref#offline_role_brief.name,
%             % Feat = data_offline_arena:get_feat(Group, lost_point),
%             % player:add_feat(Status, Feat),
%             Money = data_offline_arena:get_feat(Group, win_point),       % feat -> bind_gamemoney (new)
%             player:add_money(Status, ?MNY_T_BIND_GAMEMONEY, Money, [?LOG_OA, "battle"]),
%             InivBh = make_battle_history(TimeStamp, PasiName, ?OA_BATTLE_LOSE, Money, Group, ?INIV_BATTLE, ?OA_RANK_STATIC, 0, 0),
%             InivAllBh = add_bh(Arena#offline_arena.battle_history, InivBh),
%             update_offline_arena(Arena#offline_arena{winning_streak = 0, battle_history = InivAllBh, rank_seed = get_new_rank_seed(Arena#offline_arena.rank_seed)}),

%             %% 日志统计
%             lib_log:statis_offline_arena(Status, Group, Arena#offline_arena.rank),

%             InivName = player:get_name(Status),
%             PasiBh = make_battle_history(TimeStamp, InivName, ?OA_BATTLE_WIN, 0, Group, ?PASI_BATTLE, ?OA_RANK_STATIC, 0, 0),
%             case player:is_online(PasiRoleId) of
%                 true ->
%                     case get_offline_arena_rd(PasiRoleId) of
%                         PasiArena when is_record(PasiArena, offline_arena) ->

%                             PasiAllBh = add_bh(PasiArena#offline_arena.battle_history, PasiBh),
%                             update_offline_arena(PasiArena#offline_arena{battle_history = PasiAllBh});
%                         _ -> ?ASSERT(false), db_save_offline_arena(PasiRoleId, PasiBh)
%                     end;
%                 _ -> db_save_offline_arena(PasiRoleId, PasiBh)
%             end,
%             get_single_combat_info(InivBh, Status),
%             get_self_base_info(Status),
%             % get_self_reward_info(Status),
%             get_arena_ranking_info(Status);
%         _ -> ?ASSERT(false)
%     end.



% currect_battle_feekback(InivRoleId, InivRank, NewInivRank, PasiRoleId, PasiRank, NewPasiRank, Group, Status) ->
%     release_lock(?OA_LOCK),
%     TimeStamp = util:unixtime(),
%     ?LDS_TRACE("currect_battle_feekback", [InivRank, NewInivRank , PasiRank, NewPasiRank]),
%     %% 若战斗后排名与战斗前自身排名不同,通知玩家
%     case InivRank =:= NewInivRank andalso PasiRank =:= NewPasiRank of
%         true -> skip;
%         false ->
%             {ok, BinData} = pt_23:write(23011, [InivRank, NewInivRank, PasiRank, NewPasiRank]),
%             lib_send:send_to_sock(Status#player_status.socket, BinData)
%     end,
%     % 战斗胜利,排名交换
%     NowInivRank = NewPasiRank,
%     NowPasiRank = NewInivRank,

%     %% 日志统计
%     lib_log:statis_offline_arena(Status, Group, NowInivRank),

%     case NowInivRank < NowPasiRank orelse NowPasiRank =:= ?RANKING_OUTER_VAL of
%         true ->
%             case get_offline_arena_rd(InivRoleId) of
%                 OldArena when is_record(OldArena, offline_arena) ->
%                     Arena = update_arena_cd(OldArena, Status),
%                     PasiBref = mod_offline_data:get_offline_role_brief(PasiRoleId),
%                     PasiName = PasiBref#offline_role_brief.name,
%                     % Feat = 10,  %todo
%                     % Feat = data_offline_arena:get_feat(Group, win_point),
%                     % player:add_feat(Status, Feat),
%                     Money = data_offline_arena:get_feat(Group, win_point),       % feat -> bind_gamemoney (new)
%                     player:add_money(Status, ?MNY_T_BIND_GAMEMONEY, Money, [?LOG_OA, "battle"]),
%                     InivBh = make_battle_history(TimeStamp, PasiName, ?OA_BATTLE_WIN, Money, Group, ?INIV_BATTLE, ?OA_RANK_ASC, NowInivRank, 0),
%                     InivAllBh = add_bh(Arena#offline_arena.battle_history, InivBh),
%                     {WS, RewardWS} = {Arena#offline_arena.winning_streak + 1, Arena#offline_arena.reward_ws},

%                     Arena1 = Arena#offline_arena{rank = NowInivRank, battle_history = InivAllBh,
%                         winning_streak = WS, reward_ws = RewardWS},
%                     NewArena = send_win_streak_reward(Arena1, Status),
%                     broadcast_win_streak(Status, NewArena#offline_arena.winning_streak),
%                     update_offline_arena(NewArena),
%                     get_single_combat_info(InivBh, Status);
%                 _ -> ?ASSERT(false)
%             end,


%             InivName = player:get_name(Status),
%             PasiBh = make_battle_history(TimeStamp, InivName, ?OA_BATTLE_LOSE, 0, Group, ?PASI_BATTLE, ?OA_RANK_DESC, NowPasiRank, 0),
%             case player:is_online(PasiRoleId) of
%                 true ->
%                     case get_offline_arena_rd(PasiRoleId) of
%                         PasiArena when is_record(PasiArena, offline_arena) ->
%                             PasiAllBh = add_bh(PasiArena#offline_arena.battle_history, PasiBh),
%                             update_offline_arena(PasiArena#offline_arena{rank = NowPasiRank, battle_history = PasiAllBh});
%                         _ -> ?ASSERT(false), db_save_offline_arena(PasiRoleId, NowPasiRank, PasiBh)
%                     end;
%                 _ -> db_save_offline_arena(PasiRoleId, NowPasiRank, PasiBh)
%             end;
%         false ->
%             case get_offline_arena_rd(InivRoleId) of
%                 OldArena when is_record(OldArena, offline_arena) ->
%                     Arena = update_arena_cd(OldArena, Status),
%                     PasiBref = mod_offline_data:get_offline_role_brief(PasiRoleId),
%                     PasiName = PasiBref#offline_role_brief.name,
%                     % Feat = 10,  %todo
%                     % Feat = data_offline_arena:get_feat(Group, win_point),
%                     % player:add_feat(Status, Feat),
%                     Money = data_offline_arena:get_feat(Group, win_point),       % feat -> bind_gamemoney (new)
%                     player:add_money(Status, ?MNY_T_BIND_GAMEMONEY, Money, [?LOG_OA, "battle"]),
%                     InivBh = make_battle_history(TimeStamp, PasiName, ?OA_BATTLE_WIN, Money, Group, ?INIV_BATTLE, ?OA_RANK_STATIC, NowInivRank, 0),
%                     InivAllBh = add_bh(Arena#offline_arena.battle_history, InivBh),
%                     {WS, RewardWS} = {Arena#offline_arena.winning_streak + 1, Arena#offline_arena.reward_ws},

%                     Arena1 = Arena#offline_arena{battle_history = InivAllBh, winning_streak = WS, reward_ws = RewardWS},
%                     NewArena = send_win_streak_reward(Arena1, Status),
%                     broadcast_win_streak(Status, NewArena#offline_arena.winning_streak),
%                     update_offline_arena(NewArena),
%                     get_single_combat_info(InivBh, Status);
%                 _ -> ?ASSERT(false)
%             end,

%             InivName = player:get_name(Status),
%             PasiBh = make_battle_history(TimeStamp, InivName, ?OA_BATTLE_LOSE, 0, Group, ?PASI_BATTLE, ?OA_RANK_STATIC, NowPasiRank, 0),
%             case player:is_online(PasiRoleId) of
%                 true ->
%                     case get_offline_arena_rd(PasiRoleId) of
%                         PasiArena when is_record(PasiArena, offline_arena) ->
%                             PasiAllBh = add_bh(PasiArena#offline_arena.battle_history, PasiBh),
%                             update_offline_arena(PasiArena#offline_arena{battle_history = PasiAllBh});
%                         _ -> ?ASSERT(false), db_save_offline_arena(PasiRoleId, PasiBh)
%                     end;
%                 _ -> db_save_offline_arena(PasiRoleId, PasiBh)
%             end
%     end,
%     get_self_base_info(Status),
%     % get_self_reward_info(Status),
%     get_arena_ranking_info(Status).


%% 上线加载
login(Status, role_in_cache) -> login_correct(Status);
login(Status, _) ->
    case player:get_lv(Status) >=  80 of  %?OA_OPEN_LV
        true ->
            RoleId = player:id(Status),
            case db:select_row(offline_arena, "`id`, `arena_group`, `rank`, `rank_seed`, `refresh_stamp`, `reward_times`, `reward_stamp`, `challange_times`,"
                "`challange_stamp`, `winning_streak`, `reward_ws`, `battle_history`, `create_stamp`, `update_stamp`, `challenge_buy_times`,"
                "`reward_chal`, `his_max_ws_no`", [{id, RoleId}]) of
                [] -> skip;
                List ->
                    Arena = make_offline_arena(List),
                    % ?LDS_TRACE(offline_arena_login, [Arena, get_role_id_by_ranking(Arena#offline_arena.rank, Arena#offline_arena.group)]),
                    %% 修正可能存在的异步排名问题
                    case RoleId =:= get_role_id_by_ranking(Arena#offline_arena.rank, Arena#offline_arena.group) of
                        true ->
                            update_offline_arena(Arena),
                            update_arena_cd(Arena, Status); % update_offline_arena(Arena);
                        false ->
                            NewRank = get_ranking_by_role_id(RoleId, Arena#offline_arena.group),
                            update_offline_arena(Arena#offline_arena{rank = NewRank}),
                            update_arena_cd(Arena#offline_arena{rank = NewRank}, Status)
                    end
            end;
        false -> skip
    end,
    login_correct(Status).


%% 下线处理
logout(Status) ->
    case player:get_lv(Status) >= 80 of  %?OA_OPEN_LV
        true ->
            RoleId = player:id(Status),
            case get_offline_arena_rd(RoleId) of
                Arena when is_record(Arena, offline_arena) ->
                    db_update_offline_arena(Arena),
                    del_offline_arena(Arena);
                _ -> skip
            end;
        false -> skip
    end.


%% @doc 达到进入等级保存玩家及其宠物离线数据
save_arena_offline_data(Status) ->
    case player:get_lv(Status) >= 80 of  %?OA_OPEN_LV
        true ->
            case mod_offline_data:get_offline_bo(player:id(Status), ?OBJ_PLAYER, ?SYS_OFFLINE_ARENA) of
                null -> mod_offline_data:db_replace_role_offline_bo(Status, ?SYS_OFFLINE_ARENA);
                _ -> skip
            end;
        false -> skip
    end.


%% @doc 删除竞技场玩家宠物离线数据
del_partner_offline_data(PartnerId, Status) ->
    case player:get_lv(Status) >= 80 of  %?OA_OPEN_LV 
        true -> mod_offline_data:db_del_offline_bo(PartnerId, ?OBJ_PARTNER, ?SYS_OFFLINE_ARENA);
        false -> skip
    end.


publ_update_arena_offline_data(RoleId) ->
    case player:is_online(RoleId) of
        true -> gen_server:cast(player:get_pid(RoleId), {apply_cast, ?MODULE, update_arena_offline_data, [RoleId]});
        false -> skip
    end.


%% @doc 更新竞技场离线数据
update_arena_offline_data(RoleId) when is_integer(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) -> update_arena_offline_data(Status);
        _ -> skip
    end;
update_arena_offline_data(Status) when is_record(Status, player_status) ->
    case player:get_lv(Status) >= 80  of  % ?OA_OPEN_LV
        true ->
            case mod_offline_data:get_offline_bo(player:id(Status), ?OBJ_PLAYER, ?SYS_OFFLINE_ARENA) of
                null -> mod_offline_data:db_replace_role_offline_bo(Status, ?SYS_OFFLINE_ARENA);
                OfflineBo ->
                    mod_offline_data:db_update_role_offline_bo(Status, ?SYS_OFFLINE_ARENA),
                    NewPartnerList = player:get_partner_id_list(Status),
                    lists:foreach(
                        fun(PartnerId) ->
                            Partner = lib_partner:get_partner(PartnerId),
                            mod_offline_data:db_replace_partner_offline_bo(Partner, ?SYS_OFFLINE_ARENA)
                        end,
                        NewPartnerList
                    ),
                    lists:foreach(
                        fun(ParId) -> 
                            mod_offline_data:db_del_offline_bo(ParId, ?OBJ_PARTNER, ?SYS_OFFLINE_ARENA)
                        end,
                        lists:subtract(OfflineBo#offline_bo.partners, NewPartnerList)
                    )
            end;
        false -> skip
    end.


%% ====================================================================
%% internal functions
%% ====================================================================

% create_new_battle_history()
make_occupy_bh(Arena, Feat) ->
    make_battle_history(util:unixtime(), <<>>, ?OA_BATTLE_WIN, Feat,
        Arena#offline_arena.group, ?INIV_BATTLE, ?OA_RANK_STATIC, Arena#offline_arena.rank, 0).


db_save_offline_arena(PasiRoleId, NewInivRank, PasiBh) ->
    util:actin_new_proc(?MODULE, db_save_offline_arena_1, [PasiRoleId, NewInivRank, PasiBh]).

db_save_offline_arena_1(PasiRoleId, NewInivRank, PasiBh) ->
    case db:select_one(offline_arena, "battle_history", [{id, PasiRoleId}]) of
        null -> ?ASSERT(false);
        Data ->
            BhList = util:bitstring_to_term(Data),
            PasiAllBh = add_bh(BhList, PasiBh),
            db:update(PasiRoleId, offline_arena, [{rank, NewInivRank}, {battle_history, util:term_to_bitstring(PasiAllBh)}], [{id, PasiRoleId}])
    end.


db_save_offline_arena(PasiRoleId, PasiBh) ->
    util:actin_new_proc(?MODULE, db_save_offline_arena_1, [PasiRoleId, PasiBh]).

db_save_offline_arena_1(PasiRoleId, PasiBh) ->
    case db:select_one(offline_arena, "battle_history", [{id, PasiRoleId}]) of
        null -> ?ASSERT(false);
        Data ->
            BhList = util:bitstring_to_term(Data),
            PasiAllBh = add_bh(BhList, PasiBh),
            db:update(PasiRoleId, offline_arena, [{battle_history, util:term_to_bitstring(PasiAllBh)}], [{id, PasiRoleId}])
    end.


add_bh(List, Elm) ->
    case length(List) >= ?MAX_BATTLE_HISTORY_LENGTH of
        true ->
            {NewList, _} = lists:split(?MAX_BATTLE_HISTORY_LENGTH - 1, List),
            [Elm | NewList];
        false -> [Elm | List]
    end.


%% 保存玩家临时排名
save_temp_ranking(RoleId, ChalRoleId, Rank) ->
    ets:insert(?ETS_OFFLINE_ARENA_TEMP_RANKING, #temp_ranking{id = {RoleId, ChalRoleId}, rank = Rank}).

%% 取得玩家临时排名
%% @return null | integer()
get_temp_ranking(RoleId, ChalRoleId) ->
    case ets:lookup(?ETS_OFFLINE_ARENA_TEMP_RANKING, {RoleId, ChalRoleId}) of
        [Rank] when is_record(Rank, temp_ranking) -> Rank#temp_ranking.rank;
        _  -> null
    end.

%% 删除临时排名
del_temp_ranking(RoleId, ChalRoleId) ->
    ets:delete(?ETS_OFFLINE_ARENA_TEMP_RANKING, {RoleId, ChalRoleId}).

%% @doc 取得荣誉点
get_feat(_Group, _Result) ->
    redo,
    10.


%% @return : addValue
send_battle_reward(RoleId, Result, Group) when is_integer(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) -> send_battle_reward(Status, Result, Group);
        _ -> skip
    end;
send_battle_reward(Status, Result, Group) when is_record(Status, player_status) ->
    case data_offline_arena:get_battle_reward(Group, Result) of
        {Type, {C1, C2, C3, C4, C5}} ->
            Lv = player:get_lv(Status),
            Num = erlang:trunc(C1 * math:pow(Lv, C4) + C2 * math:pow(Lv, C5) + C3),
            case Num > 0 of
                true ->
                    if 
                        Type =:= ?MNY_T_EXP -> 
                            player:add_exp(Status, Num, [?LOG_OA, "battle"]);
                        Type =:= ?MNY_T_GUILD_CONTRI -> 
                            % mod_guild_mgr:add_member_contri(Status, Num, [?LOG_OA, "battle"]);
                            player:add_guild_contri(Status, Num, [?LOG_OA, "battle"]);
                        Type >= ?MNY_T_GAMEMONEY andalso Type =< ?MNY_T_LITERARY ->
                            player:add_money(Status, Type, Num, [?LOG_OA, "battle"]);
                        true -> ?ASSERT(false, [Type]), error
                    end,
                    Num;
                false -> 0
            end;
        _T -> ?ASSERT(false, [_T]), 0
    end.


%% @doc 构造战报数据
make_battle_history(TimeStamp, Name, Result, Feat, Group, CombatType, State, Ranking, BattleId) ->
    #battle_history{
    id = BattleId
    ,timestamp = TimeStamp
    ,challenger = Name
    ,combat_type = CombatType
    ,result = Result
    ,state = State
    ,rank = Ranking
    ,feat = Feat
    ,group = Group
    }.


%% @doc 锁定挑战玩家
lock_choice(Lock) ->
    put(Lock, ?RANK_LOCK).

get_lock(Lock) ->
    case get(Lock) of
        ?RANK_LOCK -> ?RANK_LOCK;
        _ -> ?UN_RANK_LOCK
    end.

release_lock(Lock) ->
    erase(Lock).

%% @doc 新手进入竞技场
novice_debut(Status) ->
    % ?ERROR_MSG("novice_debut ~p~n", [player:id(Status)]),
    case get_offline_arena_rd(player:id(Status)) of
        Arena when is_record(Arena, offline_arena) -> skip;
        _ -> gen_server:cast(?GET_PROC_NAME(?OA_NOVICE), {novice_enter, player:id(Status)})
    end.


%% @doc 老手晋升换榜
change_arena_group(Status) ->
    case get_offline_arena_rd(player:id(Status)) of
        Arena when is_record(Arena, offline_arena) ->
            Group = Arena#offline_arena.group,
            gen_server:cast(?GET_PROC_NAME(Group), {group_graduation, player:id(Status), Arena#offline_arena.rank});
        _ -> ?ASSERT(false, [Status])
    end.


%% @doc 跨组换榜
span_to_group(null, NewGroup, Status) ->
    gen_server:cast(?GET_PROC_NAME(NewGroup), {novice_enter, player:id(Status)});
span_to_group(_OldGroup, NewGroup, Status) ->
    case get_offline_arena_rd(player:id(Status)) of
        Arena when is_record(Arena, offline_arena) ->
            Group = Arena#offline_arena.group,
            gen_server:cast(?GET_PROC_NAME(Group), {'span_group', player:id(Status), Arena#offline_arena.rank, NewGroup});
        _ -> span_to_group(null, NewGroup, Status)
    end.


%% @doc 创建新offline_arena记录体
%% @return  offline_arena{}
make_new_offline_arena_record(RoleId, Group, Ranking) ->
    % Now = util:unixtime(),
    NowDays = util:get_now_days(),
    #offline_arena{
        id = RoleId
        ,rank = Ranking
        ,group = Group
        ,refresh_stamp = 0
        ,reward_stamp = NowDays
        ,challange_times = 0
        ,challange_stamp = 0
        % ,reward_ws_stamp = Now
        ,update_stamp = NowDays
        ,create_stamp = NowDays
    }.


% %% @doc 取得排行榜组排名最后一名, 榜满则返回0
% %% @doc 0 | ranking::integer()
% get_group_last_ranking(Group) ->
%     Ranking = ets:info(?ETS_OFFLINE_ARENA_RANKING(Group), size) + 1,
%     ?BIN_PRED(Ranking > ?MAX_RANk_COUNT, ?RANKING_OUTER_VAL, Ranking).


%% @doc 取得挑战CD
get_challenge_cd(Status) ->
    lib_vip:welfare(arena_challenge_cd, Status).


%% @doc 根据玩家信息取得玩家竞技场排名奖励包
%% @spec get_reward_id_by_rank(Arena::#offline_arena{}) -> rewardId::integer() || null
get_reward_id_by_rank(Arena) when is_record(Arena, offline_arena) ->
    case get_rank_gap(Arena#offline_arena.rank) of
        null -> ?ASSERT(false), null;
        R -> 
            List = data_offline_arena:get_rank_reward(R),
            ?LDS_DEBUG("arena", [lists:nth(Arena#offline_arena.group, List)]),
            lists:nth(Arena#offline_arena.group, List)
    end.

get_reward_id_by_rank(Group, Rank) when is_integer(Rank) ->
    case get_rank_gap(Rank) of
        null -> ?ASSERT(false), null;
        R -> 
            List = data_offline_arena:get_rank_reward(R),
            ?LDS_DEBUG("arena", [lists:nth(Group, List)]),
            lists:nth(Group, List)
    end.


get_rank_gap(Rank) ->
    get_rank_gap(Rank, data_offline_arena:get_ranks()).

get_rank_gap(_Rank, []) -> null;
get_rank_gap(_Rank, [Gap]) -> Gap;
get_rank_gap(Rank, [Gap1, Gap2 | Left]) ->
    case Rank >= Gap1 andalso Rank < Gap2 of
        true -> Gap1;
        false -> get_rank_gap(Rank, [Gap2 | Left])
    end.


%% 发放连胜奖励并更新数据
%% @retrun {?OA_SUCCESS | ErrCode, NewTimes}
send_winning_streak_reward(Arena, Status) ->
    WinStreak = Arena#offline_arena.winning_streak,
    Times = Arena#offline_arena.reward_ws,
    case WinStreak >= ?WINNING_STREAK_1 of
        true ->
            {Flag, NewTimes} = send_winning_streak_reward(WinStreak, Times, Status, ?WINNING_STREAK_LIST),
            update_offline_arena(Arena#offline_arena{reward_ws = NewTimes}),
            {Flag, NewTimes};
        false -> {?OA_SUCCESS, Times}
    end.


%% @doc 根据连胜数发放奖励
%% @retrun {?OA_SUCCESS | ErrCode, NewTimes}
send_winning_streak_reward(_WinStreak, Times, _Status, []) -> {?OA_SUCCESS, Times};
send_winning_streak_reward(WinStreak, Times, Status, [Part | Left]) ->
    case WinStreak >= Part andalso Times < Part of
        true ->
            case ?GET_WINNING_STREAK_REWARD(Part) of
                null -> skip;
                Rid ->
                    case lib_reward:check_bag_space(Status, Rid) of
                        ok -> lib_reward:give_reward_to_player(Status, Rid, [?LOG_OA, "winning"]),
                                send_winning_streak_reward(WinStreak, Part, Status, Left);
                        {fail, Reason} -> {Reason, Times}
                    end
            end;
        false -> send_winning_streak_reward(WinStreak, Part, Status, Left)
    end.

%% @doc 根据连胜数发放奖励
%% @return New #offline_arena{}
send_win_streak_reward(Arena, _Status) ->
    % WinStreak = Arena#offline_arena.winning_streak,
    % RewardWS = Arena#offline_arena.reward_ws,
    % case WinStreak > RewardWS andalso lists:member(WinStreak, data_offline_arena:get_ws_event()) of
    %     true ->
    %         case data_offline_arena:get_ws_reward(WinStreak) of
    %             Rid when is_integer(Rid) andalso Rid > 0 ->
    %                 case lib_reward:check_bag_space(Status, Rid) of
    %                     ok -> lib_reward:give_reward_to_player(Status, Rid, [?LOG_OA, "winning"]);
    %                     {fail, _Reason} -> todo
    %                 end,
    %                 Arena#offline_arena{reward_ws = WinStreak};
    %             _ERR -> ?ASSERT(false, [_ERR]), Arena
    %         end;
    %     false -> Arena
    % end.

    % 以上为自动根据连胜数发奖励，现在需求改为手动领取
    Arena.


-define(SEED_BORDER, 19).

%% @doc 返回区间排名玩家具体信息列表
%% @return  [#offline_arena_role_info{}]
get_arena_ranking_gap_info(Rank, RankSeed, Group) ->
    GrapList = get_gap_list(Rank, RankSeed),
    % ?LDS_DEBUG("[offline_arena] rankList", [Group, GrapList]),
    get_hero_ranking_info(Group, GrapList).


%% @doc 返回区间排名列表
%% @return  rankList::list()
get_gap_list(Rank, RankSeed) ->
    if  Rank =< 10 andalso Rank >= 1 -> ?RANKING_LEADER;
        Rank < 100 andalso Rank > 10 -> create_rank_seq(Rank, 1, (RankSeed rem (Rank - 9)), 9) ++ [Rank];
        Rank < 1000 andalso Rank >= 100 -> create_rank_seq(Rank, 10, RankSeed, 9) ++ [Rank];
        true -> create_rank_seq(1100, 100, RankSeed, 10)
    end.

%% @Rank::排名  @Inteval::提取间隔  @RankSeed::位移距离  @Num::提取数量
create_rank_seq(_Rank, _Inteval, _RankSeed, 0) -> [];
create_rank_seq(Rank, Inteval, RankSeed, Num) when Num > 0 ->
    [(Rank - Inteval* Num - RankSeed) | create_rank_seq(Rank, Inteval, RankSeed, Num - 1)].


%% @doc 排名种子+1
get_new_rank_seed(RankSeed) ->
    (RankSeed + 1) rem 10.



%% -----------------------------------------
%% data
%% -----------------------------------------

%% @doc 取得内存中offline_arena记录体
%% @retrun  null | #offline_arena{}
get_offline_arena_rd(RoleId) ->
    case ets:lookup(?ETS_ROLE_OFFLINE_ARENA, RoleId) of
        [Rd] when is_record(Rd, offline_arena) -> Rd#offline_arena{rank = get_ranking_by_role_id(Rd)};
        _ -> null
    end.


%% @doc 根据排行榜名次取得玩家ID
%% @retrun  null | RoleId::integer()
get_role_id_by_ranking(Rank, _) when Rank =:= ?RANKING_OUTER_VAL -> null;
get_role_id_by_ranking(Rank, Group) ->
    % ?LDS_TRACE(get_role_id_by_ranking, [Rank, Group]),
    case ets:lookup(?ETS_OFFLINE_ARENA_RANKING(Group), Rank) of
        [Rd] when is_record(Rd, offline_arena_ranking) -> Rd#offline_arena_ranking.id;
        _T -> null
    end.


%% @doc 根据玩家ID取得排行榜名次
%% @retrun  ?RANKING_OUTER_VAL | RoleId::integer()
get_ranking_by_role_id(?RANKING_BLANK_VAL, _Group) -> ?RANKING_OUTER_VAL;
get_ranking_by_role_id(RoleId, Group) ->
    % case ets:match(?ETS_OFFLINE_ARENA_RANKING(Group), {'_', '$1', RoleId}, 1) of
    %     {[[Ranking]], _} -> Ranking;
    %     _ -> ?RANKING_OUTER_VAL
    % end.
    case ets:lookup(?ETS_OFFLINE_ARENA_ROLE_RANKING(Group), RoleId) of
        [Rd | _] when is_record(Rd, offline_arena_role_ranking) -> 
            Rd#offline_arena_role_ranking.rank;
        _ -> ?RANKING_OUTER_VAL
    end.

get_ranking_by_role_id(Arena) when is_record(Arena, offline_arena) ->
    get_ranking_by_role_id(Arena#offline_arena.id, Arena#offline_arena.group);
get_ranking_by_role_id(_) -> erlang:error({offline_arena, get_ranking_by_role_id}), ?RANKING_OUTER_VAL.


fix_ranking(?RANKING_BLANK_VAL, _Group) -> skip;
fix_ranking(RoleId, Group) ->
    case ets:lookup(?ETS_OFFLINE_ARENA_ROLE_RANKING(Group), RoleId) of
        [Rd | _] when is_record(Rd, offline_arena_role_ranking) -> 
            Rank = Rd#offline_arena_role_ranking.rank,
            case get_role_id_by_ranking(Rank, Group) of
                RoleId -> skip;
                _OtherId -> 
                    ?ERROR_MSG("[offline_arena] ranking error !!! info = ~p~n", [{RoleId, Rank, Group, _OtherId}]),
                    gen_server:cast(?GET_PROC_NAME(Group), {'fix_ranking_error', RoleId, Rank, self()})
            end;
        _ -> skip
    end.


%% @doc 根据排行榜名次取得玩家排行榜信息
%% @return  null | #offline_arena_role_info{}
get_offline_arena_role_info(Rank, Group) ->
    case get_role_id_by_ranking(Rank, Group) of
        null -> null;
        ?RANKING_BLANK_VAL ->
            #offline_arena_role_info{
                id = ?RANKING_BLANK_VAL
                ,rank = Rank
                ,lv = 0
                ,name = <<>>
                ,race = 0
                ,faction = 0
                ,battle_power = 0
                ,vip_lv = 0
                ,peak_lv = 0
            };
        RoleId ->
            case mod_offline_data:get_offline_role_brief(RoleId) of
                Brief when is_record(Brief, offline_role_brief) ->
                    #offline_arena_role_info{
                        id = RoleId
                        ,rank = Rank
                        ,lv = Brief#offline_role_brief.lv
                        ,name = Brief#offline_role_brief.name
                        ,race = Brief#offline_role_brief.race
                        ,faction = Brief#offline_role_brief.faction
                        ,battle_power = Brief#offline_role_brief.battle_power
                        ,vip_lv = Brief#offline_role_brief.vip_lv
                        ,peak_lv = Brief#offline_role_brief.peak_lv
                    };
                _ -> null
            end
    end.


%% @doc 更新挑战次数
%% @return  new #offline_arena{}
update_arena_cd(Arena, _Status) ->
    NowDays = util:get_now_days(),
    case Arena#offline_arena.update_stamp =:= NowDays of
        true -> Arena;
        false ->
            NewArena = Arena#offline_arena{challange_times = 0, update_stamp = NowDays,
                winning_streak = 0, reward_ws = 0, challenge_buy_times = 0, reward_chal = 0, his_max_ws_no = 0},
            update_offline_arena(NewArena),
            NewArena
    end.


%% 根据玩家类型返回最大可挑战次数
get_max_challenge_times(_Status) -> ?INIT_CHALLANGE_TIMES.

%% 根据玩家类型返回最大可购买的挑战次数
get_max_challenge_buy_times(Status) ->
    lib_vip:welfare(arena_extra_buy_times, Status).


%% @doc 取得玩家剩余挑战次数
get_left_challenge_times(Arena, Status) ->
    get_max_challenge_times(Status) + Arena#offline_arena.challenge_buy_times - Arena#offline_arena.challange_times.


%% @doc 存储offline_arena数据
db_save_offline_arena(Arena) ->
    db:replace(Arena#offline_arena.id, offline_arena,
        [
        {id, Arena#offline_arena.id}
        ,{arena_group, Arena#offline_arena.group}
        ,{rank, Arena#offline_arena.rank}
        ,{rank_seed, Arena#offline_arena.rank_seed}
        ,{refresh_stamp, Arena#offline_arena.refresh_stamp}
        ,{reward_times, Arena#offline_arena.reward_times}
        ,{reward_stamp, Arena#offline_arena.reward_stamp}
        ,{challange_times, Arena#offline_arena.challange_times}
        ,{challange_stamp, Arena#offline_arena.challange_stamp}
        % ,{offline_stamp, Arena#offline_arena.offline_stamp}
        ,{winning_streak, Arena#offline_arena.winning_streak}
        ,{reward_ws, Arena#offline_arena.reward_ws}
        % ,{reward_ws_stamp, Arena#offline_arena.reward_ws_stamp}
        ,{battle_history, util:term_to_bitstring(Arena#offline_arena.battle_history)}
        ,{create_stamp, Arena#offline_arena.create_stamp}
        ,{update_stamp, Arena#offline_arena.update_stamp}
        ,{challenge_buy_times, Arena#offline_arena.challenge_buy_times}
        ,{reward_chal, Arena#offline_arena.reward_chal}
        ,{his_max_ws_no, Arena#offline_arena.his_max_ws_no}
        ]).


%% @doc 更新offline_arena数据
db_update_offline_arena(Arena) ->
    db:update(Arena#offline_arena.id, offline_arena,
        [
        {arena_group, Arena#offline_arena.group}
        ,{rank, Arena#offline_arena.rank}
        ,{rank_seed, Arena#offline_arena.rank_seed}
        ,{refresh_stamp, Arena#offline_arena.refresh_stamp}
        ,{reward_times, Arena#offline_arena.reward_times}
        ,{reward_stamp, Arena#offline_arena.reward_stamp}
        ,{challange_times, Arena#offline_arena.challange_times}
        ,{challange_stamp, Arena#offline_arena.challange_stamp}
        % ,{offline_stamp, Arena#offline_arena.offline_stamp}
        ,{winning_streak, Arena#offline_arena.winning_streak}
        ,{reward_ws, Arena#offline_arena.reward_ws}
        % ,{reward_ws_stamp, Arena#offline_arena.reward_ws_stamp}
        ,{battle_history, util:term_to_bitstring(Arena#offline_arena.battle_history)}

        ,{create_stamp, Arena#offline_arena.create_stamp}
        ,{update_stamp, Arena#offline_arena.update_stamp}
        ,{challenge_buy_times, Arena#offline_arena.challenge_buy_times}
        ,{reward_chal, Arena#offline_arena.reward_chal}
        ,{his_max_ws_no, Arena#offline_arena.his_max_ws_no}
        ],
        [{id, Arena#offline_arena.id}]),
    ok.


%% @doc 加载并返回#offline_arena_ranking{}到缓存
%% @retrun  #offline_arena_ranking{}
% load_offline_arena_ranking(RoleId, Rank) ->
%     case db:select_row(player, "nickname, lv, career, faction, battle_power", [{id, RoleId}]) of
%         [Name, Lv, Carrer, Faction, BattlePower] ->
%             #offline_arena_ranking{rank = Rank, id = RoleId}


make_offline_arena([Id, Group, Rank, RankSeed, RefreshStamp, RewTimes, RewStamp,
        LeftCT, ChalStamp, WS, RewWS, Bh, CreateStamp, UpdateStamp, BuyChalTimes, RwdChal, MaxWs]) ->
    #offline_arena{
        id = Id
        ,group = Group
        ,rank = Rank
        ,rank_seed = RankSeed
        ,refresh_stamp = RefreshStamp
        ,reward_times = RewTimes
        ,reward_stamp = RewStamp
        ,challange_times = LeftCT
        ,challange_stamp = ChalStamp
        % ,{offline_stamp, Arena#offline_arena.offline_stamp}
        ,winning_streak = WS
        ,reward_ws = RewWS
        % ,reward_ws_stamp = WSstamp
        ,battle_history = convert_bh(util:bitstring_to_term(Bh))
        ,create_stamp = CreateStamp
        ,update_stamp = UpdateStamp
        ,challenge_buy_times = BuyChalTimes
        ,reward_chal = RwdChal
        ,his_max_ws_no = MaxWs
    }.


convert_bh([]) -> [];
convert_bh([BhData | Left]) ->
    [convert_bh_1(BhData) | convert_bh(Left)].

convert_bh_1({_, Id, Time, Challenger, Combat, Result, State, Rank, Feat, Group}) -> 
    #battle_history{
        id = Id
        ,timestamp = Time      %% 战报时间戳
        ,challenger = Challenger  %% 挑战者名字
        ,combat_type = Combat    %% 战斗类型(0->主动挑战 1->被动)
        ,result = Result         %% 结果(0->lose 1-win)
        ,state = State          %% 排名状态
        ,rank = Rank           %% 排名
        ,feat = Feat           %% 获得功勋
        ,group = Group          %% 所在组别
        ,except = 0         %% 异常状态 (0:正常 1:异常)
    };
convert_bh_1({_, Id, Time, Challenger, Combat, Result, State, Rank, Feat, Group, Except}) -> 
    #battle_history{
        id = Id
        ,timestamp = Time      %% 战报时间戳
        ,challenger = Challenger  %% 挑战者名字
        ,combat_type = Combat    %% 战斗类型(0->主动挑战 1->被动)
        ,result = Result         %% 结果(0->lose 1-win)
        ,state = State          %% 排名状态
        ,rank = Rank           %% 排名
        ,feat = Feat           %% 获得功勋
        ,group = Group          %% 所在组别
        ,except = Except         %% 异常状态 (0:正常 1:异常)
    }.