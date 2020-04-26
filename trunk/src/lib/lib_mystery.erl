%%%-------------------------------------------------------------------
%%% @author yinweipei
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. 四月 2019 17:08
%%%-------------------------------------------------------------------
-module(lib_mystery).

%% API
-include("damijing.hrl").
-include("common.hrl").
-include("prompt_msg_code.hrl").
-include("reward.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("battle.hrl").



-export([mystery_open/1,enter_mystery/2,play_on_mystery/2,enter_mirage/2,mystery_fight_callback/1,get_flop_rewards/1
        ,reset_mystery/2,mirage_open/1,play_on_mirage/2,mirage_fight_callback/1,unlock_mirage/2,notify_mirage_in_team/4
        ,confirm_enter_mirage/2,reset_gm/1,mystery_daily_reset/0,handle_leave_team/1,mirage_close/1,set_mystery/2
        ,set_mirage/2]).


%%打开大秘境界面
mystery_open(PlayerId) ->
    Lv = player:get_lv(PlayerId),
    Mystery = data_damijing_config:get_mystery_no(),
    F = fun(X,Acc) ->
            MysteryType = data_damijing_config:get(X),
            case Lv >= MysteryType#damijing_config.lv of
                true ->
                    [1 | Acc];
                false ->
                    [0 | Acc]
            end
        end,
    Difficult = lists:reverse(lists:foldl(F,[],Mystery)),
    PlyMisc = ply_misc:get_player_misc(PlayerId),
    Mijing = PlyMisc#player_misc.mijing,
    Record = PlyMisc#player_misc.mijing_record,

    No = case Record of
             [] ->
                 0;
             MonInfo ->
                 MonInfo#mystery_mon_info.no
         end,

    {ok, Bin} =pt_50:write(50001, [ Mijing, No, Difficult]),
    lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
    io:format("Lv==========~p,Difficult=====~p,Mijing=====~p~n",[Lv,Difficult,Mijing]),

    skip.


%%进入大秘境关卡  No 10001普通 10002困难 10003噩梦
enter_mystery(PlayerId, No) ->
    %% 秘境记录信息
    Mystery = data_damijing_config:get(No),
    Type = Mystery#damijing_config.type,
    Degree = Mystery#damijing_config.degree,
    PlyMisc = ply_misc:get_player_misc(PlayerId),

    case PlyMisc#player_misc.mijing_record of
        [] ->
            Lv = player:get_lv(PlayerId),
            case Lv >= Mystery#damijing_config.lv of
                true ->
                    %% 判断道具是否足够
                    NeedCost = Mystery#damijing_config.cost,
                    case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost])  of
                        ok ->
                            %% 大秘境怪兽关卡列表
                            MonList = case Degree of
                                          1 -> data_damijing_mon:get_normal_mijing_no();
                                          2 -> data_damijing_mon:get_hard_mijing_no();
                                          3 -> data_damijing_mon:get_nightmare_mijing_no()
                                      end,
                            MonLevel = decide_elite_level(MonList,Mystery#damijing_config.mon_pool_elite),
                            F = fun(X,Acc) ->
                                    Mon = data_damijing_mon:get(X),
                                    [Mon#damijing_mon.num | Acc]
                                end,
                            NewEliteList = lists:foldl(F, [], Mystery#damijing_config.mon_pool_elite),
                            mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["lib_mystery", "start_mystery"]),
                            %% 消耗大秘境次数
                            Mijing = PlyMisc#player_misc.mijing,
                            case Mijing of
                                3 ->
                                    %% 添加玩家大秘境信息
                                    NewMisc = PlyMisc#player_misc{mijing = (Mijing-1), mijing_record = #mystery_mon_info{  player_id = PlayerId
                                        , no = No,type = Type,degree = Degree,level = 1,all_level = length(MonLevel)
                                        , mon_pool_elite = NewEliteList, mon_list = MonLevel}},
                                    ply_misc:update_player_misc(NewMisc);
                                _ ->
                                    %% 添加玩家大秘境信息
                                    NewMisc = PlyMisc#player_misc{mijing_record = #mystery_mon_info{  player_id = PlayerId
                                        , no = No,type = Type,degree = Degree,level = 1,all_level = length(MonLevel)
                                        , mon_pool_elite = NewEliteList, mon_list = MonLevel}},
                                    ply_misc:update_player_misc(NewMisc)
                            end,

                            {ok, Bin} =pt_50:write(50002, [ 1 , NewEliteList]),
                            lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                        {fail, Reason} ->
                            lib_send:send_prompt_msg(PlayerId, Reason)
                    end;
                false ->
                    lib_send:send_prompt_msg(PlayerId, ?PM_NEWYEAR_BANQUET_LEVEL_LIMIT)
            end;
        MonInfo ->
            case MonInfo#mystery_mon_info.degree =:= Degree of
                true ->
                    Level = MonInfo#mystery_mon_info.level,
                    MonPoolElite = MonInfo#mystery_mon_info.mon_pool_elite,

                    {ok, Bin} =pt_50:write(50002, [ Level, MonPoolElite]),
                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                false ->
                    lib_send:send_prompt_msg(PlayerId, ?PM_MYSTERY_LIMIT)
            end,
            io:format("MonInfo============~p~n",[MonInfo])
    end.

%%进入大秘境第几关
play_on_mystery(PlayerId, No) ->
    PS = player:get_PS(PlayerId),
    Mystery = data_damijing_config:get(No),
    Degree = Mystery#damijing_config.degree,

    PlyMisc = ply_misc:get_player_misc(PlayerId),
    MonInfo = PlyMisc#player_misc.mijing_record,
    %% 是否重置
    case MonInfo of
        [] ->
            {ok, Bin} =pt_50:write(50021, [ 1 ]),
            lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
        _  ->
            case MonInfo#mystery_mon_info.degree =:= Degree of
                true ->
                    MonList = MonInfo#mystery_mon_info.mon_list,
                    LevelNo = MonInfo#mystery_mon_info.level,
                    MonsterNo = element(1, lists:nth(LevelNo,MonList)),
                    %%战斗回调处理
                    Fun = fun mod_guild_dungeon:handle_mystery_callback/2,
                    mod_battle:start_mf(PS, null, MonsterNo, ?BTL_SUB_T_MYSTREY, Fun, []);
                _ ->
                    lib_send:send_prompt_msg(PlayerId, ?PM_MYSTERY_LEVEL_LIMIT)
            end
    end.

%%秘境战斗回调处理
mystery_fight_callback(PlayerId) ->
    PlyMisc = ply_misc:get_player_misc(PlayerId),
    MonInfo = PlyMisc#player_misc.mijing_record,
    %% 是否重置
    case MonInfo of
        [] ->
            {ok, Bin} =pt_50:write(50021, [ 1 ]),
            lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
        _ ->
            MonList = MonInfo#mystery_mon_info.mon_list,
            AllLevel = MonInfo#mystery_mon_info.all_level,
            Level = MonInfo#mystery_mon_info.level,
            Money = element(2, lists:nth(Level,MonList)),
            %%是否通过所有关卡
            case Level =:= AllLevel of
                true ->
                    %%添加玩家大秘境信息
                    MysteryList = data_damijing_config:get_mystery_no(),
                    [RewardList,CostList] = decide_flop_card_reward(MysteryList, MonInfo#mystery_mon_info.type, MonInfo#mystery_mon_info.degree),

                    ets:insert(ets_flop_rewards_info, #flop_rewards_info{  player_id = PlayerId
                        , time = 0, box = RewardList, cost = CostList}),
                    %%解锁对应幻境关卡
                    MirageList = data_damijing_config:get_mriage_no(),
                    MirageNo = get_mirage_by_mystery(MirageList, MonInfo#mystery_mon_info.type,MonInfo#mystery_mon_info.degree),
                    NewMisc = case PlyMisc#player_misc.unlock of
                                  [] ->
                                      PlyMisc#player_misc{mijing_record = MonInfo#mystery_mon_info{level = 0 }, unlock = [MirageNo]};
                                  Unlock ->
                                      Unlock1 = lists:delete(MirageNo, Unlock),
                                      NewUnlock = [MirageNo | Unlock1],
                                      PlyMisc#player_misc{mijing_record = MonInfo#mystery_mon_info{level = 0 }, unlock = NewUnlock}
                              end,

                    ply_misc:update_player_misc(NewMisc),
                    {ok, Bin} =pt_50:write(50004, [ 0, Money, 1, MonInfo#mystery_mon_info.no]),
                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
                    io:format("go to fan pai-----------------------");
                false ->
                    NewMisc = PlyMisc#player_misc{mijing_record = MonInfo#mystery_mon_info{level = Level+1 }},
                    ply_misc:update_player_misc(NewMisc),
                    {ok, Bin} =pt_50:write(50004, [ (Level+1), Money, 0, MonInfo#mystery_mon_info.no]),
                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
            end,
            player:add_mijing(PlayerId, Money, ["lib_mystery", "mystery fight win"])
    end.

%%大秘境关卡重置
reset_mystery(PlayerId, Type) ->
    PS = player:get_PS(PlayerId),
    PlyMisc = ply_misc:get_player_misc(PlayerId),
    %% 1秘境 2幻境
    case Type of
        1 ->
            %判断是否有足够的积分
            case player:has_enough_money(PS,?MNY_T_INTEGRAL,data_special_config:get('mijing_reset_cost')) of
                true ->
                    Mijing = PlyMisc#player_misc.mijing,
                    case Mijing of
                        2 ->
                            player:cost_integral(player:get_PS(PlayerId), data_special_config:get('mijing_reset_cost'), ["lib_mystery","reset_mystery_time"]),
                            NewMisc = PlyMisc#player_misc{mijing = (Mijing-1), mijing_record = []},
                            ply_misc:update_player_misc(NewMisc),
                            {ok, Bin} =pt_50:write(50006, [ 1 ]),
                            lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                        1 ->
                            Lv = player:get_vip_lv(PS),
                            case Lv =:= 6 of
                                true ->
                                    player:cost_integral(player:get_PS(PlayerId), data_special_config:get('mijing_reset_cost'), ["lib_mystery","reset_mystery_time"]),
                                    NewMisc = PlyMisc#player_misc{mijing = (Mijing-1), mijing_record = []},
                                    ply_misc:update_player_misc(NewMisc),
                                    {ok, Bin} =pt_50:write(50006, [ 0 ]),
                                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                                false ->
                                    lib_send:send_prompt_msg(PlayerId, ?PM_VIP_LV_LIMIT)
                            end;
                        3 ->
                            lib_send:send_prompt_msg(PlayerId, ?PM_MYSTERY_TIME_LIMIT);
                        0 ->
                            lib_send:send_prompt_msg(PlayerId, ?PM_GET_RICH_TOTAL_NUM)
                    end;
                false ->
                    lib_send:send_prompt_msg(PlayerId, ?PM_INTEGRAL_LIMIT)
            end;
        2 ->
            %判断是否有足够的积分
            case player:has_enough_money(PS,?MNY_T_INTEGRAL, data_special_config:get('huanjing_reset_cost')) of
                true ->
                    Huanjing = PlyMisc#player_misc.huanjing,
                    case Huanjing of
                        2 ->
                            player:cost_integral(player:get_PS(PlayerId), data_special_config:get('huanjing_reset_cost'), ["lib_mystery","reset_mystery_time"]),
                            NewMisc = PlyMisc#player_misc{huanjing = (Huanjing-1), huanjing_record = []},
                            ply_misc:update_player_misc(NewMisc),
                            {ok, Bin} =pt_50:write(50016, [ 1 ]),
                            lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                        1 ->
                            Lv = player:get_vip_lv(PS),
                            case Lv =:= 6 of
                                true ->
                                    player:cost_integral(player:get_PS(PlayerId), data_special_config:get('huanjing_reset_cost'), ["lib_mystery","reset_mystery_time"]),
                                    NewMisc = PlyMisc#player_misc{huanjing = (Huanjing-1), huanjing_record = []},
                                    ply_misc:update_player_misc(NewMisc),
                                    {ok, Bin} =pt_50:write(50016, [ 0 ]),
                                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                                false ->
                                    lib_send:send_prompt_msg(PlayerId, ?PM_VIP_LV_LIMIT)
                            end;
                        3 ->
                            lib_send:send_prompt_msg(PlayerId, ?PM_MYSTERY_TIME_LIMIT);
                        0 ->
                            lib_send:send_prompt_msg(PlayerId, ?PM_GET_RICH_TOTAL_NUM)
                    end;
                false ->
                    lib_send:send_prompt_msg(PlayerId, ?PM_INTEGRAL_LIMIT)
            end
    end.

%%切换大幻境界面
mirage_open(PlayerId) ->
    PlyMisc = ply_misc:get_player_misc(PlayerId),
    Huanjing = PlyMisc#player_misc.huanjing,
    Record = PlyMisc#player_misc.huanjing_record,

    No = case Record of
             [] ->
                 0;
             MonInfo ->
                 MonInfo#mystery_mon_info.no
         end,
    Lv = player:get_lv(PlayerId),
    Mirage = data_damijing_config:get_mriage_no(),
    F = fun(X,Acc) ->
            MirageType = data_damijing_config:get(X),
            case Lv >= MirageType#damijing_config.lv of
                true ->
                    [1 | Acc];
                false ->
                    [0 | Acc]
            end
        end,
    Difficult = lists:reverse(lists:foldl(F,[],Mirage)),

    {ok, Bin} =pt_50:write(50011, [ Huanjing, No, Difficult]),
    lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
    io:format("Huanjing=====~p,Difficult====~p~n",[Huanjing,Difficult]).


%% 进入大幻境关卡  Degree 1普通 2困难 3噩梦
enter_mirage(PlayerId, No) ->
    %% 幻境记录信息
    Mirage = data_damijing_config:get(No),
    Type = Mirage#damijing_config.type,
    Degree = Mirage#damijing_config.degree,
    PlyMisc = ply_misc:get_player_misc(PlayerId),
    Record = PlyMisc#player_misc.huanjing_record,
    % 是否已解锁
    Unlock = PlyMisc#player_misc.unlock,
    case lists:member(Mirage#damijing_config.no, Unlock) of
        true ->
            %% 是否组队进入
            case player:is_in_team(PlayerId) of
                true ->
                    notify_mirage_in_team(PlayerId, Mirage, Type, Degree);
                false ->
                    case Record of
                        [] ->
                            %% 判断道具是否足够
                            NeedCost = Mirage#damijing_config.cost,
                            case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost])  of
                                ok ->
                                    do_enter_mirage(PlayerId, Mirage, Type, Degree);
                                {fail, Reason} ->
                                    lib_send:send_prompt_msg(PlayerId, Reason)
                            end;
                        MonInfo ->
                            case MonInfo#mystery_mon_info.degree =:= Degree of
                                true ->
                                    Level = MonInfo#mystery_mon_info.level,
                                    MonPoolElite = MonInfo#mystery_mon_info.mon_pool_elite,

                                    io:format("one person enter game"),
                                    % 添加拥有进入幻境机会的玩家
                                    case Level =:= 0 of
                                        true -> skip;
                                        false ->
                                            case ets:lookup(ets_mirage_player,mirage_player) of
                                                [] ->
                                                    ets:insert(ets_mirage_player, {mirage_player, [PlayerId] });
                                                [{mirage_player,MiragePlayer}] ->
                                                    MiragePlayer1 = lists:delete(PlayerId,MiragePlayer),
                                                    MiragePlayer2 = [PlayerId | MiragePlayer1],
                                                    ets:insert(ets_mirage_player, {mirage_player, MiragePlayer2 })
                                            end
                                    end,
                                    {ok, Bin} =pt_50:write(50012, [No, Level, MonPoolElite]),
                                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                                false ->
                                    lib_send:send_prompt_msg(PlayerId, ?PM_MYSTERY_LIMIT)
                            end
                    end
            end;
        false ->
            %% 打开解锁面板
            MijingRecord = PlyMisc#player_misc.mijing_record,
            case MijingRecord of
                [] ->
                    {ok, Bin} =pt_50:write(50015, [ 0, 0, No ]),
                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                _  ->
                    case MijingRecord#mystery_mon_info.degree =:= Degree of
                        true ->
                            {ok, Bin} =pt_50:write(50015, [ MijingRecord#mystery_mon_info.all_level, MijingRecord#mystery_mon_info.level, No ]),
                            lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                        false ->
                            {ok, Bin} =pt_50:write(50015, [ 0, 0, No ]),
                            lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
                    end

            end
    end.

%% 通知玩家确认进入幻境 lib_mystery:notify_mirage_in_team().
notify_mirage_in_team(PlayerId, Mirage, Type, Degree) ->
    %% 是否队长
    case player:is_leader(PlayerId) of
        true ->
            TeamId = player:get_team_id(PlayerId),
            Team = mod_team:get_team_info(TeamId),
            TeamList = mod_team:get_all_member_id_list(Team),
            PlayerList = lists:delete(PlayerId,TeamList),
            PlyMisc = ply_misc:get_player_misc(PlayerId),
            Record = PlyMisc#player_misc.huanjing_record,
            %% 队伍人数不能少于2人
            case length(TeamList) < 2 of
                true ->
                    case Record of
                        [] ->
                            %% 判断道具是否足够
                            NeedCost = Mirage#damijing_config.cost,
                            case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost])  of
                                ok ->
                                    do_enter_mirage(PlayerId, Mirage, Type, Degree);
                                {fail, Reason} ->
                                    lib_send:send_prompt_msg(PlayerId, Reason)
                            end;
                        MonInfo ->
                            case MonInfo#mystery_mon_info.degree =:= Degree of
                                true ->
                                    Level = MonInfo#mystery_mon_info.level,
                                    MonPoolElite = MonInfo#mystery_mon_info.mon_pool_elite,

                                    io:format("one person in team enter game"),
                                    % 添加拥有进入幻境机会的玩家
                                    case Level =:= 0 of
                                        true -> skip;
                                        false ->
                                            case ets:lookup(ets_mirage_player,mirage_player) of
                                                [] ->
                                                    ets:insert(ets_mirage_player, {mirage_player, [PlayerId] });
                                                [{mirage_player,MiragePlayer}] ->
                                                    MiragePlayer1 = lists:delete(PlayerId,MiragePlayer),
                                                    MiragePlayer2 = [PlayerId | MiragePlayer1],
                                                    ets:insert(ets_mirage_player, {mirage_player, MiragePlayer2 })
                                            end
                                    end,
                                    {ok, Bin} =pt_50:write(50012, [MonInfo#mystery_mon_info.no, Level, MonPoolElite]),
                                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                                false ->
                                    lib_send:send_prompt_msg(PlayerId, ?PM_MYSTERY_LIMIT)
                            end
                    end;
                false ->
                    case Record of
                        [] ->
                            %% 判断道具是否足够
                            NeedCost = Mirage#damijing_config.cost,
                            case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost])  of
                                ok ->
                                    %% 判断是否有队员暂离
                                    LeaveTeam = lists:filter(fun(X) -> player:is_tmp_leave_team(X) end, TeamList),
                                    case LeaveTeam of
                                        [] ->
                                            F = fun(X, Acc) ->
                                                    Lv = player:get_lv(X),
                                                    case Lv < Mirage#damijing_config.lv of
                                                        true ->
                                                            [X | Acc];
                                                        false ->
                                                            Acc
                                                    end
                                                end,
                                            WaitList = lists:foldl(F, [], PlayerList),
                                            %% 等级不满足进入幻境
                                            case WaitList of
                                                [] ->
                                                    io:format("wait person enter game~n"),
                                                    F1 = fun(X) ->
                                                            {ok, Bin} =pt_50:write(50018, [ X ]),
                                                            lib_send:send_to_sock(player:get_PS(X), Bin)
                                                         end,
                                                    lists:foreach(F1, PlayerList),
                                                    ets:insert(ets_mirage_wait_info, #mirage_wait_info{team_id = TeamId, player_ids = PlayerList,
                                                        leader_id = PlayerId, no = Mirage#damijing_config.no});
                                                _  ->
                                                    F2 = fun(X, Acc) ->
                                                            Name = player:get_name(X),
                                                            [Name | Acc]
                                                         end,
                                                    NameList = lists:foldl(F2, [], WaitList),
                                                    {ok, Bin} =pt_50:write(50020, [ NameList ]),
                                                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
                                            end,
                                            io:format("TeamList===~p,TeamId===~p,PlayerList===~p,WaitList==~p~n",[TeamList,TeamId,PlayerList,WaitList]);
                                        _  ->
                                            F = fun(X) ->
                                                    lib_send:send_prompt_msg(X, ?PM_PLAYER_TMP_LEAVE)
                                                end,
                                            lists:foreach(F, TeamList)
                                    end;
                                {fail, Reason} ->
                                    lib_send:send_prompt_msg(PlayerId, Reason)
                            end;
                        MonInfo ->
                            case MonInfo#mystery_mon_info.degree =:= Degree of
                                true ->
                                    %% 判断是否有队员暂离
                                    LeaveTeam = lists:filter(fun(X) -> player:is_tmp_leave_team(X) end, TeamList),
                                    case LeaveTeam of
                                        [] ->
                                            F = fun(X, Acc) ->
                                                    Lv = player:get_lv(X),
                                                    case Lv < Mirage#damijing_config.lv of
                                                        true ->
                                                            [X | Acc];
                                                        false ->
                                                            Acc
                                                    end
                                                end,
                                            WaitList = lists:foldl(F, [], PlayerList),
                                            %% 等级不满足进入幻境
                                            case WaitList of
                                                [] ->
                                                    io:format("wait person enter game~n"),
                                                    F1 = fun(X) ->
                                                            {ok, Bin} =pt_50:write(50018, [ X ]),
                                                            lib_send:send_to_sock(player:get_PS(X), Bin)
                                                         end,
                                                    lists:foreach(F1, PlayerList),
                                                    ets:insert(ets_mirage_wait_info, #mirage_wait_info{team_id = TeamId, player_ids = PlayerList,
                                                        leader_id = PlayerId, no = Mirage#damijing_config.no});
                                                _  ->
                                                    F2 = fun(X, Acc) ->
                                                        Name = player:get_name(X),
                                                        [Name | Acc]
                                                         end,
                                                    NameList = lists:foldl(F2, [], WaitList),
                                                    {ok, Bin} =pt_50:write(50020, [ NameList ]),
                                                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
                                            end,
                                            io:format("TeamList===~p,TeamId===~p,PlayerList===~p,WaitList==~p~n",[TeamList,TeamId,PlayerList,WaitList]);
                                        _  ->
                                            F = fun(X) ->
                                                    lib_send:send_prompt_msg(X, ?PM_PLAYER_TMP_LEAVE)
                                                end,
                                            lists:foreach(F, TeamList)
                                    end;
                                false ->
                                    lib_send:send_prompt_msg(PlayerId, ?PM_MYSTERY_LIMIT)
                            end
                    end
            end;
        false ->
            lib_send:send_prompt_msg(PlayerId, ?PM_DUNGEON_NOT_LEADER)
    end.

%% 队友确认进入幻境   Type 1同意  0不同意
confirm_enter_mirage(PlayerId, Agree) ->
    PS = player:get_PS(PlayerId),
    TeamId = player:get_team_id(PlayerId),
    [Wait] = ets:lookup(ets_mirage_wait_info,TeamId),
    WaitList = lists:delete(PlayerId, Wait#mirage_wait_info.player_ids),
    %% 不能进入名单
    PlayerNameList = case Agree of
                     1 ->
                         Wait#mirage_wait_info.player_names;
                     0 ->
                         Name = player:get_name(PS),
                         PlayerName = Wait#mirage_wait_info.player_names,
                         [Name | PlayerName]
                 end,
    %% 是否是最后一个确认
    case WaitList of
        [] ->
            case PlayerNameList of
                [] ->
                    LeaderId = player:get_leader_id(PS),
                    %% 判断队伍队长是否一样
                    case LeaderId =:= Wait#mirage_wait_info.leader_id of
                        true ->
                            No = Wait#mirage_wait_info.no,
                            Mirage = data_damijing_config:get(No),
                            Type = Mirage#damijing_config.type,
                            Degree = Mirage#damijing_config.degree,
                            PlyMisc = ply_misc:get_player_misc(LeaderId),
                            Record = PlyMisc#player_misc.huanjing_record,
                            %% 队长进入游戏
                            case Record of
                                [] ->
                                    ets:delete(ets_mirage_wait_info, TeamId),
                                    do_enter_mirage(LeaderId, Mirage, Type, Degree);
                                MonInfo ->
                                    case MonInfo#mystery_mon_info.degree =:= Degree of
                                        true ->
                                            Level = MonInfo#mystery_mon_info.level,
                                            MonPoolElite = MonInfo#mystery_mon_info.mon_pool_elite,

                                            ets:delete(ets_mirage_wait_info, TeamId),
                                            io:format("many people enter game"),
                                            % 添加拥有进入幻境机会的玩家
                                            case Level =:= 0 of
                                                true -> skip;
                                                false ->
                                                    case ets:lookup(ets_mirage_player,mirage_player) of
                                                        [] ->
                                                            ets:insert(ets_mirage_player, {mirage_player, [LeaderId] });
                                                        [{mirage_player,MiragePlayer}] ->
                                                            MiragePlayer1 = lists:delete(LeaderId,MiragePlayer),
                                                            MiragePlayer2 = [LeaderId | MiragePlayer1],
                                                            ets:insert(ets_mirage_player, {mirage_player, MiragePlayer2 })
                                                    end
                                            end,

                                            {ok, Bin} =pt_50:write(50012, [MonInfo#mystery_mon_info.no, Level, MonPoolElite]),
                                            lib_send:send_to_sock(player:get_PS(LeaderId), Bin);
                                        false ->
                                            lib_send:send_prompt_msg(LeaderId, ?PM_MYSTERY_LIMIT)
                                    end
                            end;
                        false ->
                            lib_send:send_prompt_msg(LeaderId, ?PM_TVE_LEADER_CHANGE)
                    end;
                _  ->
                    ets:delete(ets_mirage_wait_info, TeamId),
                    Team = mod_team:get_team_info(TeamId),
                    TeamList = mod_team:get_all_member_id_list(Team),
                    {ok, Bin} =pt_50:write(50019, [1, PlayerNameList]),
                    F = fun(X) ->
                            lib_send:send_to_sock(player:get_PS(X), Bin)
                        end,
                    lists:foreach(F, TeamList)
            end;
        _  ->
            ets:insert(ets_mirage_wait_info,Wait#mirage_wait_info{player_ids = WaitList, player_names = PlayerNameList}),
            io:format("wait other person confirm")
    end,
    io:format("TeamId=====~p~n",[TeamId]).

%% 幻境关卡生成
%% PlayerId  玩家ID    Mirage   当前幻境记录
%% Type 1秘境 2幻境     Degree 1普通 2困难 3噩梦
do_enter_mirage(PlayerId,Mirage,Type,Degree) ->
    %% 大幻境怪兽关卡列表
    MonList = case Degree of
                  1 -> data_damijing_mon:get_normal_huanjing_no();
                  2 -> data_damijing_mon:get_hard_huanjing_no();
                  3 -> data_damijing_mon:get_nightmare_huanjing_no()
              end,
    NewEliteList = decide_shuffle_elite_level(Mirage#damijing_config.mon_pool_elite),
    MonLevel = decide_elite_level(MonList,NewEliteList),
    F = fun(X,Acc) ->
            Mon = data_damijing_mon:get(X),
            [Mon#damijing_mon.num | Acc]
        end,
    NewEliteList2 = lists:foldl(F, [], NewEliteList),
    %% 幻境次数
    PlyMisc = ply_misc:get_player_misc(PlayerId),
    Huanjing = PlyMisc#player_misc.huanjing,
    case Huanjing of
        3 ->
            %%消耗大秘境次数
            NewMisc = PlyMisc#player_misc{huanjing = (Huanjing-1), huanjing_record = #mystery_mon_info{  player_id = PlayerId
                , no = Mirage#damijing_config.no, type = Type,degree = Degree,level = 1,all_level = length(MonLevel)
                , mon_pool_elite = NewEliteList2, mon_list = MonLevel}},
            ply_misc:update_player_misc(NewMisc);
        _ ->
            %%添加玩家大秘境信息
            NewMisc = PlyMisc#player_misc{huanjing_record = #mystery_mon_info{  player_id = PlayerId
                , no = Mirage#damijing_config.no, type = Type,degree = Degree,level = 1,all_level = length(MonLevel)
                , mon_pool_elite = NewEliteList2, mon_list = MonLevel}},
            ply_misc:update_player_misc(NewMisc)
    end,
    %%判断道具是否足够
    NeedCost = Mirage#damijing_config.cost,
    mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["lib_mystery", "start_mystery"]),
    % 添加拥有进入幻境机会的玩家
    case ets:lookup(ets_mirage_player,mirage_player) of
        [] ->
            ets:insert(ets_mirage_player, {mirage_player, [PlayerId] });
        [{mirage_player,MiragePlayer}] ->
            MiragePlayer1 = lists:delete(PlayerId,MiragePlayer),
            MiragePlayer2 = [PlayerId | MiragePlayer1],
            ets:insert(ets_mirage_player, {mirage_player, MiragePlayer2 })
    end,

    {ok, Bin} =pt_50:write(50012, [Mirage#damijing_config.no, 1, NewEliteList2]),
    lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
    io:format("start new time enter game").

%%进入大秘境第几关
play_on_mirage(PlayerId, No) ->
    PS = player:get_PS(PlayerId),
    Mirage = data_damijing_config:get(No),
    Degree = Mirage#damijing_config.degree,
    PlyMisc = ply_misc:get_player_misc(PlayerId),
    MonInfo = PlyMisc#player_misc.huanjing_record,
    %% 是否重置
    case MonInfo of
        [] ->
            {ok, Bin} =pt_50:write(50021, [ 2 ]),
            lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
        _ ->
            case MonInfo#mystery_mon_info.degree =:= Degree of
                true ->
                    MonList = MonInfo#mystery_mon_info.mon_list,
                    LevelNo = MonInfo#mystery_mon_info.level,
                    MonsterNo = element(1, lists:nth(LevelNo,MonList)),
                    %%战斗回调处理
                    Fun = fun mod_guild_dungeon:handle_mirage_callback/2,
                    mod_battle:start_mf(PS, null, MonsterNo, ?BTL_SUB_T_MYSTREY, Fun, []),
                    io:format("MonList=======~p,MonsterNo===~p~n",[MonList,MonsterNo]);
                _ -> skip
            end
    end.

%% 幻境战斗回调
mirage_fight_callback(PlayerId) ->
    PS = player:get_PS(PlayerId),
    LearderId = case player:is_in_team(PS) of
                    true ->
                        player:get_leader_id(PS);
                    false ->
                        PlayerId
                end,
    PlyMisc = ply_misc:get_player_misc(LearderId),
    MonInfo = PlyMisc#player_misc.huanjing_record,
    %% 是否重置
    case MonInfo of
        [] ->
            {ok, Bin} =pt_50:write(50021, [ 2 ]),
            lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
        _ ->
            MonList = MonInfo#mystery_mon_info.mon_list,
            AllLevel = MonInfo#mystery_mon_info.all_level,
            Level = MonInfo#mystery_mon_info.level,
            Money = element(2, lists:nth(Level,MonList)),
            %% 判断是否为消耗幻境进入次数的人
            case player:is_in_team_but_not_leader(PS) of
                true ->
                    player:add_huanjing(PlayerId, Money, ["lib_mystery","mirage_fight_win"]);
                false ->
                    %%是否通过所有关卡
                    case Level =:= AllLevel of
                        true ->
                            %%获取玩家翻牌奖励包
                            MirageList = data_damijing_config:get_mriage_no(),
                            [RewardList,CostList] = decide_flop_card_reward(MirageList, MonInfo#mystery_mon_info.type, MonInfo#mystery_mon_info.degree),
                            %% 是否组队
                            case player:is_in_team(PlayerId) of
                                true ->
                                    TeamId = player:get_team_id(PlayerId),
                                    Team = mod_team:get_team_info(TeamId),
                                    TeamList = mod_team:get_all_member_id_list(Team),
                                    F = fun(X) ->
                                        ets:insert(ets_flop_rewards_info, #flop_rewards_info{  player_id = X
                                            , time = 0, box = RewardList, cost = CostList}),

                                        {ok, Bin} =pt_50:write(50014, [ 0, Money, 1, MonInfo#mystery_mon_info.no]),
                                        lib_send:send_to_sock(player:get_PS(X), Bin)
                                        end,
                                    lists:foreach(F, TeamList),
                                    io:format("TeamList===~p~n",[TeamList]),
                                    NewMisc = PlyMisc#player_misc{huanjing_record = MonInfo#mystery_mon_info{level = 0 }},
                                    ply_misc:update_player_misc(NewMisc);
                                false ->
                                    ets:insert(ets_flop_rewards_info, #flop_rewards_info{  player_id = PlayerId
                                        , time = 0, box = RewardList, cost = CostList}),

                                    NewMisc = PlyMisc#player_misc{huanjing_record = MonInfo#mystery_mon_info{level = 0 }},
                                    ply_misc:update_player_misc(NewMisc),
                                    {ok, Bin} =pt_50:write(50014, [ 0, Money, 1, MonInfo#mystery_mon_info.no]),
                                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
                            end,
                            io:format("go to fan pai-----------------------");
                        false ->
                            NewMisc = PlyMisc#player_misc{huanjing_record = MonInfo#mystery_mon_info{level = Level+1 }},
                            ply_misc:update_player_misc(NewMisc),
                            {ok, Bin} =pt_50:write(50014, [ (Level+1), Money, 0, MonInfo#mystery_mon_info.no]),
                            lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
                    end,
                    player:add_huanjing(PlayerId, Money, ["lib_mystery","mirage_fight_win"]),
                    io:format("MonInfo====~p~n",[MonInfo])
            end
    end.


%% 队长以及队员在幻境途中离队
handle_leave_team(PS) ->
    PlayerId = player:get_id(PS),
    %% 正在幻境中关卡中（强退或网络不好）
    case ets:lookup(ets_mirage_player,mirage_player) of
        [] -> skip;
        [{mirage_player,MiragePlayer}] ->
            LeaderId = player:get_leader_id(PS),
            % 判断队长(强退玩家)是否在玩幻境
            case lists:member(LeaderId, MiragePlayer) orelse lists:member(PlayerId, MiragePlayer) of
                true ->
                    % 判断强退玩家是否原队长
                    case lists:member(PlayerId, MiragePlayer) of
                        true ->
                            mod_team:team_reconn_timeout(PS),
                            MiragePlayer1 = lists:delete(PlayerId,MiragePlayer),
                            ets:insert(ets_mirage_player, {mirage_player, MiragePlayer1 });
                        false -> skip
                    end;
                false -> skip
            end
    end,
    %% 等待进入幻境倒计时（强退和网络不好）
    case player:is_in_team(PlayerId) of
        true ->
            TeamId = player:get_team_id(PlayerId),
            case ets:lookup(ets_mirage_wait_info,TeamId) of
               [] -> skip;
               [Wait] ->
                   TeamLeader = Wait#mirage_wait_info.leader_id,
                   lib_send:send_prompt_msg(TeamLeader, ?PM_WAIT_UNLONE),
                   ets:delete(ets_mirage_wait_info, TeamId)
            end;
        false -> skip
    end.

%% gm命令(个人重置)
reset_gm(PlayerId) ->
%%    lib_mystery:reset_gm(1000100000000759).
    PlyMisc = ply_misc:get_player_misc(PlayerId),
    NewMisc = PlyMisc#player_misc{mijing = 3, huanjing = 3, mijing_record = [], huanjing_record = [], unlock = []},
    ply_misc:update_player_misc(NewMisc),
    ets:delete(ets_flop_rewards_info,PlayerId).

%% gm命令(跳转秘境关卡)
set_mystery(PlayerId, Level) ->
    PlyMisc = ply_misc:get_player_misc(PlayerId),
    MysteryInfo = PlyMisc#player_misc.mijing_record,
    case Level > MysteryInfo#mystery_mon_info.all_level of
        true ->
            ?TRACE("handle_gm_cmd(), ERROR ERROR ERROR ERROR");
        false ->
            NewMisc = PlyMisc#player_misc{mijing_record = MysteryInfo#mystery_mon_info{level = Level }},
            ply_misc:update_player_misc(NewMisc)
    end.

%% gm命令(跳转秘境关卡)
set_mirage(PlayerId, Level) ->
    PlyMisc = ply_misc:get_player_misc(PlayerId),
    MirageInfo = PlyMisc#player_misc.huanjing_record,
    case Level > MirageInfo#mystery_mon_info.all_level of
        true ->
            ?TRACE("handle_gm_cmd(), ERROR ERROR ERROR ERROR");
        false ->
            NewMisc = PlyMisc#player_misc{huanjing_record = MirageInfo#mystery_mon_info{level = Level }},
            ply_misc:update_player_misc(NewMisc)
    end.

%% 关闭幻境面板
mirage_close(PlayerId) ->
    %   lib_mystery:mirage_close(1000100000000759).
    case ets:lookup(ets_mirage_player,mirage_player) of
        [] ->
            void;
        [{mirage_player,MiragePlayer}] ->
            case lists:member(PlayerId, MiragePlayer) of
                true ->
                    NewPlayers = lists:delete(PlayerId,MiragePlayer),
                    ets:insert(ets_mirage_player, {mirage_player, NewPlayers });
                false ->
                    void
            end
    end.

%% 秘境/幻境每日重置
mystery_daily_reset() ->
    case ets:tab2list(?ETS_PLAYER_MISC) of
        [] ->
            skip;
        PlyMiscList ->
            F = fun(PlyMisc) ->
                    PlayerId = PlyMisc#player_misc.player_id,
                    NewMisc = PlyMisc#player_misc{mijing = 3, huanjing = 3, mijing_record = [], huanjing_record = [], unlock = []},
                    ply_misc:update_player_misc(NewMisc),
                    ets:delete(ets_flop_rewards_info,PlayerId)
                end,
            lists:foreach(F, PlyMiscList)
    end,
    db:update(player_misc, lists:concat(["update player_misc set mijing=3, huanjing=3, mijing_record=","'[]', ", "huanjing_record=","'[]', ", "lockno=","'[]'"])).

%% 幻境解锁
unlock_mirage(PlayerId, MirageNo) ->
%%    lib_mystery:unlock_mirage(1000100000000759, 10011).
    MirageInfo = data_damijing_config:get(MirageNo),
    %%判断是否满足等级和道具
    Lv = player:get_lv(PlayerId),
    case Lv >= MirageInfo#damijing_config.lv of
        true ->
            %% 判断道具是否足够
            NeedCost = case MirageNo of
                           10011 ->
                               data_special_config:get('normal_huanjing');
                           10012 ->
                               data_special_config:get('hard_huanjing');
                           10013 ->
                               data_special_config:get('nightmare_huanjing')
                       end,
            case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost])  of
                ok ->
                    %% 消耗道具
                    mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["lib_mystery", "unlock_mirage"]),
                    %% 解锁记录
                    PlyMisc = ply_misc:get_player_misc(PlayerId),
                    Unlock = PlyMisc#player_misc.unlock,
                    Unlock2 = lists:delete(MirageNo, Unlock),
                    NewUnlock = [MirageNo | Unlock2],
                    NewMisc = PlyMisc#player_misc{unlock = NewUnlock},
                    ply_misc:update_player_misc(NewMisc),
                    %% 通知前端
                    {ok, Bin} =pt_50:write(50017, [ 1 ]),
                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
                    io:format("NewUnlock====~p~n",[NewUnlock]);
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PlayerId, Reason)
            end;
        false ->
            lib_send:send_prompt_msg(PlayerId, ?PM_NEWYEAR_BANQUET_LEVEL_LIMIT)
    end.

%%大秘境/幻境通关后翻牌奖励
get_flop_rewards(PlayerId) ->
%%    lib_mystery:get_flop_rewards(1000100000000759).
    PS = player:get_PS(PlayerId),
    %% 判断奖励领取次数
    [RewardInfo] = ets:lookup(ets_flop_rewards_info,PlayerId),
    case RewardInfo#flop_rewards_info.time >= 4 of
        true ->
            lib_send:send_prompt_msg(PlayerId, ?PM_AD_REPEAT_GET);
        false ->
            Times = RewardInfo#flop_rewards_info.time + 1,
            RewardCard = RewardInfo#flop_rewards_info.box,
            RewardNum = lists:nth(Times, RewardCard),
            CostCard = RewardInfo#flop_rewards_info.cost,

            {_, MoneyType, Num} = lists:nth(Times , CostCard),
            case player:has_enough_money(PS, MoneyType, Num) of
                true ->
                    player:cost_money(PS, MoneyType, Num,["lib_mystery","flop_rewards"]),
                    Result = lib_reward:give_reward_to_player(PS, RewardNum, ["lib_mystery","flop_reward_goods"]),
                    ets:insert(ets_flop_rewards_info, RewardInfo#flop_rewards_info{time = Times}),

                    [{_ , GoodsNo , GoodsCount}] = Result#reward_dtl.goods_list,
                    {ok, Bin} =pt_50:write(50005, [ GoodsNo , GoodsCount]),
                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
                    io:format("Result=====~p,GoodsNo===~p,GoodsCount=~p~n",[Result,GoodsNo,GoodsCount]);
                false ->
                    case MoneyType of
                        ?MNY_T_GAMEMONEY ->
                            lib_send:send_prompt_msg(PlayerId, ?PM_GAMEMONEY_LIMIT);
                        ?MNY_T_YUANBAO ->
                            lib_send:send_prompt_msg(PlayerId, ?PM_YB_LIMIT);
                        ?MNY_T_INTEGRAL ->
                            lib_send:send_prompt_msg(PlayerId, ?PM_INTEGRAL_LIMIT)
                    end
            end
    end.

%%决定是否精英关卡
decide_elite_level(MonList,EliteList) ->
    F = fun(X,Acc) ->
            Mon = data_damijing_mon:get(X),
            case lists:member(X,EliteList) of
                true ->
                    [ {Mon#damijing_mon.elite_mon_group, Mon#damijing_mon.victory_points} | Acc];
                false ->
                    [ {Mon#damijing_mon.mon_group, Mon#damijing_mon.victory_points} | Acc ]
            end
        end,
    Result = lists:foldl(F,[],MonList),
    lists:reverse(Result).

%%决定随机精英关卡
decide_shuffle_elite_level(Mirage) ->
    Elite = lists:nth(1,Mirage),
    Num = lists:nth(2,Mirage),
    case length(Elite) >= Num of
        true ->
            NewEliteList = lists:sublist(shuffle(Elite),Num),
            NewEliteList;
        false ->
            ?ERROR_MSG("lib_mystery:decide_shuffle_elite_level: ~p~n",[{?MODULE,?LINE}])
    end.

%%获取随机顺序的列表
shuffle(L) ->
    shuffle(L,[]).
shuffle([],L) ->
    L;
shuffle(L1,L2) ->
    Len = length(L1),
    if
        Len > 1 ->
            NL = lists:split(random:uniform(Len-1), L1),
            {[H1|T1],[H2|T2]} = NL,
            NL2 = lists:flatten([T1],[H1|T2]),
            L11 = lists:append(L2,[H2]),
            shuffle(NL2, L11);
        true ->
            shuffle([],lists:append(L2,L1))
    end.

%%获取秘境对应幻境的关卡号
get_mirage_by_mystery([H | T], Type, Degree) ->
    Mirage = data_damijing_config:get(H),
    MirageType = Mirage#damijing_config.type,
    MirageDegree = Mirage#damijing_config.degree,
    case (MirageType =:= (Type+1)) andalso (MirageDegree =:= Degree) of
        true ->
            Mirage#damijing_config.no;
        false ->
            get_mirage_by_mystery(T,Type,Degree)
    end;

get_mirage_by_mystery([], _Type, _Degree) ->
    ?ASSERT(false),
    [].

%%匹配翻牌奖励包和消耗
decide_flop_card_reward([H | T], Type, Degree) ->
    Mystery = data_damijing_config:get(H),
    MysteryType = Mystery#damijing_config.type,
    MysteryDegree = Mystery#damijing_config.degree,
    case (MysteryType =:= Type) andalso (MysteryDegree =:= Degree) of
        true ->
            [[Mystery#damijing_config.copper_card,Mystery#damijing_config.silver_card,Mystery#damijing_config.gold_card,Mystery#damijing_config.diamond_card],Mystery#damijing_config.more_card_price];
        false ->
            decide_flop_card_reward(T, Type, Degree)
    end;

decide_flop_card_reward([], _Type , _Degree) ->
    ?ASSERT(false),
    [].
