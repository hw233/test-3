%%%-----------------------------------
%%% @Module  : lib_hardtower
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2014.1
%%% @Description: 噩梦爬塔函数
%%%-----------------------------------
-module(lib_hardtower).

-include("common.hrl").
-include("record.hrl").
-include("dungeon.hrl").
-include("tower.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("reward.hrl").
-include("proc_name.hrl").
-include("goods.hrl").

-export ([
    get_tower_info/1
    ,enter_tower/4
    ,re_enter_tower/2
    ,get_tower_dungeon_info/1
    ,notify_event/3
    ,add_chal_times/1
    ,close_tower/1
    ,reset_close_tower/1
    ,set_next_floor/2
    ,open_tower_system/1
    ,login/2
    ,logout/1
    ,re_enter_tower_1/3
    ,reset_tower_rd/1
    ,clean_schedule/1
    ,notify_tower_info/1
    ,send_reward/3
    ,handle_tower_login/2
    ,notify_tower_battle_lost/1
    ,gm_enter_tower/3
    ,is_in_tower/1
    % ,gm_clean_schedule/1
    ]).


%% ====================================================================
%% API functions
%% ====================================================================

%% @doc 取得爬塔信息
get_tower_info(Status) ->
    RoleId = player:id(Status),
    case get_tower_rd(RoleId) of
        Tower when is_record(Tower, hardtower) ->
            NewTower = refresh_tower_rd(Tower, util:get_now_days()),
            Times = ?BIN_PRED(?MAX_TOWER_TIMES > NewTower#hardtower.schedule_times, ?MAX_TOWER_TIMES - NewTower#hardtower.schedule_times, 0),
            {ok, BinData} = pt_62:write(62001, [NewTower#hardtower.tower_no, NewTower#hardtower.floor, get_max_floor(), Times, NewTower#hardtower.best_floor]),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        _ ->
            lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR)
    end.


%% @doc 取得塔的最高层层数
get_max_floor() ->
    data_hardtower:get_max_floor().


-define(ERROR_FLOOR, 5).
-define(VIP_LIMIT, 6).   

%% @doc 进入爬塔副本
enter_tower(TowerNo, Floor, Status, State) ->
    TeamFlag = player:is_in_team(Status),
    DunFlag = is_in_tower(Status),
    % LvFlag = not_fit_tower_lv(Floor, player:get_lv(Status)),
    if  
        TeamFlag ->
            {ok, BinData} = pt_62:write(62003, [?TEAM_LIMIT]),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        % LvFlag ->
        %     {ok, BinData} = pt_62:write(62003, [?LV_NOT_ENGOUTH]),
        %     lib_send:send_to_sock(Status#player_status.socket, BinData);
        DunFlag ->
            {ok, BinData} = pt_62:write(62003, [?ERROR]),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        true ->
            RoleId = player:id(Status),
            case get_tower_rd(RoleId) of
                OldTower when is_record(OldTower, hardtower) ->
                    Tower1 = refresh_tower_rd(OldTower, util:get_now_days()),
                    %判断是否上次进入的噩梦副本与这次噩梦副本相同
                    case Tower1#hardtower.tower_no =/= 0 andalso Tower1#hardtower.tower_no =/= TowerNo of
                        true ->
                            {ok, BinData} = pt_62:write(62003, [?DUN_NOT_SAME]),
                            lib_send:send_to_sock(Status#player_status.socket, BinData);
                        false ->
                            Tower = Tower1#hardtower{tower_no = TowerNo},
                            case check_floor(Floor, Tower, Status) of
                                {false, ErrCode} -> 
                                    {ok, BinData} = pt_62:write(62003, [ErrCode]),
                                    lib_send:send_to_sock(Status#player_status.socket, BinData);
                                true ->
                                    Now = util:unixtime(),
                                    % Nowdays = util:get_now_days(),
                                    case lib_dungeon:can_create_dungeon(TowerNo, Now, Status) of
                                        {true, _} -> 
                                            case Tower#hardtower.chal_boss_times - Tower#hardtower.buy_times >= get_chal_boss_times(Status) of
                                                true -> lib_send:send_prompt_msg(Status, ?PM_TOWER_NO_CHAL_TIMES);
                                                false -> 
                                                    case recv_span_exp(Floor, Status, State, Tower#hardtower.floor, Tower#hardtower{floor = Floor}) of
                                                        true ->
                                                            % 添加统计
                                                            % case Tower#hardtower.floor =:= ?DEF_FLOOR andalso Floor > 1 of
                                                            %     true -> catch lib_log:statis_tower(Status, "span_floor", Floor);
                                                            %     false -> skip
                                                            % end,
                                                            % update_tower_rd(Tower#hardtower{floor = Floor}),
                                                            gen_server:cast(?DUNGEON_MANAGE, {'create_tower_dungeon', TowerNo, Now, RoleId, ?FLOOR_TO_ID(Floor)});
                                                        false -> skip
                                                    end
                                            end;
                                        {false, [{_, Code} | _]} ->
                                            {ok, BinData} = pt_62:write(62003, [Code]),
                                            lib_send:send_to_sock(Status#player_status.socket, BinData)
                                    end
                            end
                    end;
                _ ->
                    {ok, BinData} = pt_62:write(62003, [?PM_UNKNOWN_ERR]),
                    lib_send:send_to_sock(Status#player_status.socket, BinData)
            end
    end.


gm_enter_tower(TowerNo, Floor, RoleId) ->
    gen_server:cast(?DUNGEON_MANAGE, {'create_tower_dungeon', TowerNo, util:unixtime(), RoleId, ?FLOOR_TO_ID(Floor)}).


%% 登录重进爬塔处理
handle_tower_login(Now, Status) ->
    case get(?HARD_TOWER_POSITION_FALG) of
        Value when Value >= ?HARD_TOWER_DUNGEON_NO1 andalso Value =< ?HARD_TOWER_DUNGEON_NO3 -> 
            % ?LDS_TRACE(handle_tower_login),
            erase(?HARD_TOWER_POSITION_FALG), 
            re_enter_tower(Now, Status);
        _ -> skip
    end.


%% @doc 重新进入爬塔
re_enter_tower(Now, Status) ->
    RoleId = player:id(Status),
    case get_tower_rd(RoleId) of
        Tower when is_record(Tower, hardtower) ->
            ?LDS_TRACE("re_enter_tower"),
            gen_server:cast(player:get_pid(Status), {apply_cast, ?MODULE, re_enter_tower_1, [Now, RoleId, Tower]});
            % gen_server:cast(?DUNGEON_MANAGE, {'create_tower_dungeon', ?HARD_TOWER_DUNGEON_NO, Now, RoleId, ?FLOOR_TO_ID(Tower#hardtower.floor)});
        _ -> ?ASSERT(false)
    end.


re_enter_tower_1(Now, RoleId, Tower) ->
    gen_server:cast(?DUNGEON_MANAGE, {'create_tower_dungeon', Tower#hardtower.tower_no, Now, RoleId, ?FLOOR_TO_ID(Tower#hardtower.floor)}).


reset_tower_rd(Status) ->
    case get_tower_rd(player:id(Status)) of
        OldTower when is_record(OldTower, hardtower) ->
            Tower = #hardtower{id = player:id(Status), best_floor = OldTower#hardtower.best_floor},
            update_tower_rd(Tower),
            db:update(player:id(Status), hardtower, [
                {tower_no, Tower#hardtower.tower_no}
                ,{floor, Tower#hardtower.floor}
                ,{chal_boss_times, Tower#hardtower.chal_boss_times}
                ,{buy_times, Tower#hardtower.buy_times}
                ,{schedule_times, Tower#hardtower.schedule_times}
                ,{refresh_stamp, Tower#hardtower.refresh_stamp}
                ,{span_exp_floor, Tower#hardtower.span_exp_floor}
                ,{best_floor, Tower#hardtower.best_floor}
            ], [{id, Tower#hardtower.id}]
            );
            % update_tower_rd(Tower#hardtower{floor = ?DEF_FLOOR, chal_boss_times = 0, buy_times = 0});
        _ -> ?ASSERT(false)
    end.



%% 通知爬塔界面信息
notify_tower_info(RoleId) ->
    case player:get_pid(RoleId) of
        Pid when is_pid(Pid) -> gen_server:cast(Pid, 'notify_hardtower_info');
        _ -> skip
    end.

%% @doc 爬塔副本内信息
get_tower_dungeon_info(Status) ->
    RoleId = player:id(Status),
    case is_in_tower(Status) of
        true ->
            case get_tower_rd(RoleId) of
                Tower when is_record(Tower, hardtower) ->
                    % ?LDS_TRACE(62002, get_chal_boss_times(Status)),
                    {ok, BinData} = pt_62:write(62002, 
                        [Tower#hardtower.tower_no, Tower#hardtower.floor, Tower#hardtower.chal_boss_times, get_chal_boss_times(Status), Tower#hardtower.buy_times, get_max_buy_times(Status)]),
                    lib_send:send_to_sock(Status#player_status.socket, BinData);
                _ -> ?ASSERT(false)
            end;
        false -> skip
    end.


%% @doc 爬塔事件通知
notify_event(EventType, _Args, Status) ->
    case is_in_tower(Status) of
        true -> event(EventType, Status);
        false -> skip
    end.


%% @doc 投币增加打BOSS次数
add_chal_times(Status) ->
    RoleId = player:id(Status),
    case get_tower_rd(RoleId) of
        Tower when is_record(Tower, hardtower) ->
            case Tower#hardtower.chal_boss_times =:= 0 orelse Tower#hardtower.buy_times >= get_max_buy_times(Status) of
                true -> ?ASSERT(false);
                false ->
                    case player:has_enough_bind_yuanbao(Status, ?BUY_TIMES_MONEY) of
                        true -> 
                            player:cost_bind_yuanbao(Status, ?BUY_TIMES_MONEY, [?LOG_TOWER, "buy_times"]),
                            update_tower_rd(Tower#hardtower{buy_times = Tower#hardtower.buy_times + 1}),
                            get_tower_dungeon_info(Status);
                        false -> 
                            lib_send:send_prompt_msg(Status, ?PM_MONEY_LIMIT),
                            close_tower(Status)
                    end
            end;
        _ -> lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR)
    end.


%% @doc 关闭爬塔
close_tower(Status) ->
    lib_dungeon:quit_dungeon(Status).   %% 通知爬塔副本关闭


%% @doc 凌晨重置爬塔时关闭爬塔
reset_close_tower(Status) -> 
    case is_in_tower(Status) of
        true -> 
            case player:is_battling(Status) of
                true -> catch mod_battle:force_end_battle(Status);
                false -> skip
            end,
            {ok, BinData} = pt_62:write(62008, []),
            lib_send:send_to_uid(player:id(Status), BinData),
            close_tower(Status);
        false -> skip
    end.


%% @doc 设置通关当层信息
%% @return boolean()
set_next_floor(RoleId, ListenerId) ->
    CurFloor = ?ID_TO_FLOOR(ListenerId),
    NextFloor = CurFloor + 1,
    ?ylh_Debug("set_next_floor CurFloor=~p,NextFloor=~p~n", [CurFloor, NextFloor]),
    case CurFloor > get_max_floor() of
        true -> false;
        false ->
            case get_tower_rd(RoleId) of
                Tower when is_record(Tower, hardtower) ->
                    ?ASSERT((Tower#hardtower.floor + 1) =:= NextFloor, [Tower#hardtower.floor, NextFloor]),
                    Nowdays = util:get_now_days(),
                    BestFloor = ?BIN_PRED(Tower#hardtower.best_floor < CurFloor, CurFloor, Tower#hardtower.best_floor),
                    NewTowerRd = 
                        case Nowdays =:= Tower#hardtower.refresh_stamp of
                            true -> Tower#hardtower{floor = NextFloor, chal_boss_times = 0, buy_times = 0, best_floor = BestFloor};
                            false -> Tower#hardtower{floor = ?DEF_FLOOR + 1, chal_boss_times = 0, buy_times = 0, span_exp_floor = 0, best_floor = BestFloor}

                        end,
                    update_tower_rd(NewTowerRd),
                    db_update_tower(NewTowerRd),

                    % case player:get_PS(RoleId) of
                    %     null -> skip;
                    %     PS ->
                    %         %% 统计爬塔
                    %         % CurFloor = NextFloor - 1,
                    %         catch lib_log:statis_tower(PS, "battle", CurFloor),
                    %         catch mod_rank:role_tower(PS, CurFloor),
                    %         case Tower#hardtower.best_floor < CurFloor of
                    %             true ->
                    %                 case CurFloor of
                    %                     10 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_10, [player:get_name(PS), RoleId]});
                    %                     20 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_20, [player:get_name(PS), RoleId]});
                    %                     30 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_30, [player:get_name(PS), RoleId]});
                    %                     40 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_40, [player:get_name(PS), RoleId]});
                    %                     50 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_50, [player:get_name(PS), RoleId]});
                    %                     60 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_60, [player:get_name(PS), RoleId]});
                    %                     70 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_70, [player:get_name(PS), RoleId]});
                    %                     80 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_80, [player:get_name(PS), RoleId]});
                    %                     90 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_90, [player:get_name(PS), RoleId]});
                    %                     100 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_100, [player:get_name(PS), RoleId]});
                    %                     _Any -> skip
                    %                 end;
                    %             false -> skip
                    %         end
                    % end,

                    true;
                _ -> false
            end
    end.
    % ?ERROR_MSG("TOWER set_next_floor !!!!!!!!! ~p~n ", [NextFloor]),
    


%% @return new #hardtower{}
refresh_tower_rd(Tower, Nowdays) ->
    case Nowdays =:= Tower#hardtower.refresh_stamp of
        true -> Tower;
        false -> 
            case player:get_PS(Tower#hardtower.id) of
                Status when is_record(Status, player_status) ->
                    reset_close_tower(Status);
                _ -> skip
            end,
            NewTower = #hardtower{refresh_stamp = Nowdays, schedule_times = 0, tower_no = 0,
                id = Tower#hardtower.id, floor =?DEF_FLOOR, span_exp_floor = 0, best_floor = Tower#hardtower.best_floor},
            update_tower_rd(NewTower),
            NewTower
    end.


%% @doc 给予爬塔奖励
send_reward(TowerNo, RoleId, ListenerId) ->
    Floor = ?ID_TO_FLOOR(ListenerId),
    Config = lib_dungeon:get_config_hardtower_reward_data(TowerNo, Floor),
    Status = player:get_PS(RoleId),
    case is_record(Config, tower_config) andalso is_record(Status, player_status) of
        true ->
            case lib_reward:check_bag_space(Status, Config#tower_config.reward_id) of
                ok -> 
                    case lib_reward:give_reward_to_player(tower, Status, Config#tower_config.reward_id, [Floor, Config#tower_config.battle_power], [?LOG_TOWER, "box"]) of
                        Rwd when is_record(Rwd, reward_dtl) ->
                            List = [{Id, No, Num, mod_inv:get_goods_quality_by_id(RoleId, Id), mod_inv:get_goods_bind_state_by_id(Id)} 
                                || {Id, No, Num} <- Rwd#reward_dtl.goods_list],
                            notify_tower_reward(Status, List),
                            ok;
                        _ -> ?ASSERT(false)
                    end;
                {fail, Reason} -> lib_send:send_prompt_msg(Status, Reason)
            end;
        _ -> ?ASSERT(false)
    end.


%% @doc 领取爬塔跨级经验
recv_span_exp(_, _, 0, _, Tower) -> update_tower_rd(Tower), true;
recv_span_exp(Floor, Status, 1, CurFloor, Tower) when Floor > 0 -> 
    case (Floor rem ?HARD_SPAN_FLOOR_COEF) =:= 1 andalso CurFloor =:= ?DEF_FLOOR of
        true -> 
            case lib_vip:welfare(climb_tower_quick_enter_layer, Status) >= Floor of
                true -> 
                    % NeedMoney = data_tower_reward:get_span_money(Floor),
                    NeedMoney = case Tower#hardtower.tower_no of
                        ?HARD_TOWER_DUNGEON_NO1 -> data_hardtower_reward1:get_span_money(Floor);
                        ?HARD_TOWER_DUNGEON_NO2 -> data_hardtower_reward2:get_span_money(Floor);
                        ?HARD_TOWER_DUNGEON_NO3 -> data_hardtower_reward3:get_span_money(Floor);
                        _ -> ?ASSERT(false), 0
                    end,
                    case get_span_money_and_type(Floor, Tower) of
                        {MoneyType, NeedMoney} ->
                            case player:has_enough_money(Status, MoneyType, NeedMoney) of
                                true ->
                                    update_tower_rd(Tower), 
                                    db_update_tower(Tower),
                                    player:cost_money(Status, MoneyType, NeedMoney, [?LOG_TOWER, "span_floor"]),
                                    % CalExp = data_tower_reward:get_span_exp(Floor),
                                    CalExp = case Tower#hardtower.tower_no of
                                                ?HARD_TOWER_DUNGEON_NO1 -> data_hardtower_reward1:get_span_exp(Floor);
                                                ?HARD_TOWER_DUNGEON_NO2 -> data_hardtower_reward2:get_span_exp(Floor);
                                                ?HARD_TOWER_DUNGEON_NO3 -> data_hardtower_reward3:get_span_exp(Floor);
                                                _ -> ?ASSERT(false), 0
                                            end,
                                    player:add_all_exp(Status, CalExp, [?LOG_TOWER, "span_floor"]),
                                    PetAllExp = lib_reward:calc_all_exp_to_partners(Status, CalExp),
                                    % Config = lib_dungeon:get_config_hardtower_reward_data(Floor),
                                    % SpanReward = data_tower_reward:get_span_reward(Floor),
                                    SpanReward = case Tower#hardtower.tower_no of
                                                ?HARD_TOWER_DUNGEON_NO1 -> data_hardtower_reward1:get_span_reward(Floor);
                                                ?HARD_TOWER_DUNGEON_NO2 -> data_hardtower_reward2:get_span_reward(Floor);
                                                ?HARD_TOWER_DUNGEON_NO3 -> data_hardtower_reward3:get_span_reward(Floor);
                                                _ -> ?ASSERT(false), 0
                                            end,
                                    RoleId = player:id(Status),
                                    F = fun(RewardId, Sum) ->
                                        RewardRd = lib_reward:give_reward_to_player(Status, RewardId, [?LOG_TOWER, "span_floor"]),
                                        List = [{Id, No, Num, mod_inv:get_goods_quality_by_id(RoleId, Id), mod_inv:get_goods_bind_state_by_id(Id)}
                                            || {Id, No, Num} <- RewardRd#reward_dtl.goods_list],
                                        Sum ++ List
                                    end,
                                    CountList = lists:reverse(lists:foldl(F, [], SpanReward)),
                                    % ?LDS_DEBUG(62007, [{0, ?VGOODS_EXP, CalExp, 0} | CountList]),
                                    {ok, BinData} = pt_62:write(62007, [[{0, ?VGOODS_EXP, CalExp, 0, ?BIND_NEVER}, 
                                        {0, ?VGOODS_PAR_EXP, PetAllExp, 0, ?BIND_NEVER} | CountList]]),
                                    lib_send:send_to_uid(RoleId, BinData),

                                    true;
                                false -> lib_send:send_prompt_msg(Status, ?PM_MONEY_LIMIT), false
                            end;
                        _ -> lib_send:send_prompt_msg(Status, ?PM_DATA_CONFIG_ERROR), false
                    end;
                false -> lib_send:send_prompt_msg(Status, ?PM_VIP_LV_LIMIT), false
            end;
        false -> lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR), false
    end;
recv_span_exp(_, _, _, _, _) -> ?ASSERT(false), false.


%% return : {MoneyType, MoneyNum} | null
get_span_money_and_type(Floor, Tower) ->
    case Tower#hardtower.tower_no of
        ?HARD_TOWER_DUNGEON_NO1 ->
            case data_hardtower_reward1:get_span_money(Floor) of
                Int when is_integer(Int) andalso Int > 0 -> {?MNY_T_BIND_YUANBAO, Int};
                _ -> 
                    case data_hardtower_reward1:get_span_coin(Floor) of
                        Int when is_integer(Int) -> {?MNY_T_BIND_GAMEMONEY, Int};
                        _ -> null
                    end
            end;
        ?HARD_TOWER_DUNGEON_NO2 ->
            case data_hardtower_reward2:get_span_money(Floor) of
                Int when is_integer(Int) andalso Int > 0 -> {?MNY_T_BIND_YUANBAO, Int};
                _ -> 
                    case data_hardtower_reward2:get_span_coin(Floor) of
                        Int when is_integer(Int) -> {?MNY_T_BIND_GAMEMONEY, Int};
                        _ -> null
                    end
            end;
        ?HARD_TOWER_DUNGEON_NO3 ->
            case data_hardtower_reward3:get_span_money(Floor) of
                Int when is_integer(Int) andalso Int > 0 -> {?MNY_T_BIND_YUANBAO, Int};
                _ -> 
                    case data_hardtower_reward3:get_span_coin(Floor) of
                        Int when is_integer(Int) -> {?MNY_T_BIND_GAMEMONEY, Int};
                        _ -> null
                    end
            end;
        _ ->
            ?ASSERT(false), null
    end.
    % case data_tower_reward:get_span_money(Floor) of
    %     Int when is_integer(Int) andalso Int > 0 -> {?MNY_T_BIND_YUANBAO, Int};
    %     _ -> 
    %         case data_tower_reward:get_span_coin(Floor) of
    %             Int when is_integer(Int) -> {?MNY_T_BIND_GAMEMONEY, Int};
    %             _ -> null
    %         end
    % end.


%% @doc 清除爬塔进度
clean_schedule(Status) ->
    RoleId = player:id(Status),
    case get_tower_rd(RoleId) of
        Tower when is_record(Tower, hardtower) ->
            NewTower = refresh_tower_rd(Tower, util:get_now_days()),
            SchduleTimes = NewTower#hardtower.schedule_times,
            case SchduleTimes < ?MAX_TOWER_TIMES of
                true -> update_tower_rd(NewTower#hardtower{tower_no = 0,floor = ?DEF_FLOOR, schedule_times = SchduleTimes + 1, span_exp_floor = 0,
                            chal_boss_times = 0, buy_times = 0});
                false -> skip
            end,
            get_tower_info(Status);
        _ -> ?ASSERT(false)
    end.


%% @doc 开通爬塔
open_tower_system(Status) ->
    RoleId = player:id(Status),
    case ply_sys_open:is_open(Status, ?SYS_HARD_TOWER) of
        true ->
            case get_tower_rd(RoleId) of
                Tower when is_record(Tower, hardtower) -> skip;
                _ -> save_new_tower_record(Status)
            end;
        false -> skip
    end.


%% @doc 登录加载
login(_Status, role_in_cache) ->
    skip;
login(Status, _) ->
    RoleId = player:id(Status),
    case ply_sys_open:is_open(Status, ?SYS_HARD_TOWER) of
        true ->
            ?ylh_Debug("lib_hardtower login"), 
            case db:select_row(hardtower, "`tower_no`,`floor`, `chal_boss_times`, `buy_times`, `schedule_times`, `refresh_stamp`, `span_exp_floor`, `best_floor`", 
                [{id, RoleId}]) of
                [TowerNo, Floor, ChalTimes, BuyTimes, SchduleTimes, RefreshStamp, SpanFloor, BestFloor] ->
                    update_tower_rd(#hardtower{id = RoleId, tower_no = TowerNo, floor = Floor, chal_boss_times = ChalTimes, buy_times = BuyTimes,
                        schedule_times = SchduleTimes, refresh_stamp = RefreshStamp, span_exp_floor = SpanFloor, best_floor = BestFloor});
                _ ->
                    ?ylh_Debug("lib_hardtower login ex"), 
                    save_new_tower_record(Status) %?ASSERT(false, [Status])
            end;
        false -> skip
    end.


logout(Status) ->
    RoleId = player:id(Status),
    case ply_sys_open:is_open(Status, ?SYS_HARD_TOWER) of
        true -> 
            case get_tower_rd(RoleId) of
                Tower when is_record(Tower, hardtower) -> 
                    del_tower_rd(Tower),
                    db_update_tower(Tower);
                _ ->
                    ?ylh_Debug("lib_hardtower logout"), 
                    ?ASSERT(false)
            end;
        false -> skip
    end.


%% 通知爬塔战斗失败
notify_tower_battle_lost(Status) ->
    case is_in_tower(Status) of
        true ->
            {ok, BinData} = pt_62:write(62006, []),
            lib_send:send_to_sid(Status, BinData);
        false -> skip
    end.


%% 通知爬塔奖励获取
notify_tower_reward(Status, GoodsList) ->
    {ok, BinData} = pt_62:write(62007, [GoodsList]),
    lib_send:send_to_sid(Status, BinData).



%% ====================================================================
%% Intenal functions
%% ====================================================================

%% 是否满足进入爬塔条件
%% @return true | {false, Errcode}
check_fit_tower_lv(TowerNo, Floor, Status) -> 
    case lib_vip:welfare(climb_tower_quick_enter_layer, Status) >= Floor of
        true -> 
            Lv = player:get_lv(Status),
            TowerConfig = lib_dungeon:get_config_hardtower_reward_data(TowerNo, Floor),
            FitLv = TowerConfig#tower_config.lv,
            ?BIN_PRED(Lv >= FitLv, true, {false, ?LV_NOT_ENGOUTH});
        false -> {false, ?VIP_LIMIT}
    end.

% get_tower_dun() ->
%     lib_dungeon:get_config_data(?HARD_TOWER_DUNGEON_NO).


%% @doc 爬塔事件
event(EventType, Status) when EventType =:= ?BATTLE_FAIL_GROUP orelse EventType =:= ?BATTLE_ESCAPE ->
    RoleId = player:id(Status),
    case get_tower_rd(RoleId) of
        Tower when is_record(Tower, hardtower) ->
            NewTower = Tower#hardtower{chal_boss_times = Tower#hardtower.chal_boss_times + 1},
            update_tower_rd(NewTower),
            case NewTower#hardtower.chal_boss_times =< (get_chal_boss_times(Status) + NewTower#hardtower.buy_times) of
                true -> 
                    {ok, BinData} = pt_62:write(62002, [NewTower#hardtower.tower_no, NewTower#hardtower.floor, NewTower#hardtower.chal_boss_times, 
                        get_chal_boss_times(Status), NewTower#hardtower.buy_times, get_max_buy_times(Status)]),
                    lib_send:send_to_sock(Status#player_status.socket, BinData);
                false -> 
                    close_tower(Status)
            end;
        _ -> ?ASSERT(false)
    end;

event(_, _) -> skip.


%% @doc 是否在爬塔副本中
%% @return boolean()
is_in_tower(Status) ->
    case player:is_in_dungeon(Status) of
        {true, _} -> player:get_dungeon_type(Status) =:= ?DUNGEON_TYPE_HARD_TOWER;
        false -> false
    end.

-define(FLOOR_NOT_REACH, 7). % 未通关此层 
%% @doc 检查选择的层数是否合法
%% @return : true | {false, ErrCode}
check_floor(0, _Tower, _) -> false;
check_floor(Floor, Tower, Status) ->
    CurFloor = Tower#hardtower.floor,
    case CurFloor =:= ?DEF_FLOOR of
        true ->
            case Floor =:= 1 orelse (Floor rem ?HARD_SPAN_FLOOR_COEF) =:= 1 of
            % case Floor =:= 1 of
                false -> {false, ?ERROR_FLOOR};
                true ->
                    case (Tower#hardtower.best_floor + 1) >= Floor orelse Floor =:= 1 of
                        true ->
                            case check_fit_tower_lv(Tower#hardtower.tower_no, Floor, Status) of
                                true -> 
                                    MaxFloor = get_max_floor(),
                                    case Floor =< MaxFloor of
                                        true -> true;
                                        false -> {false, ?ERROR_FLOOR}
                                    end;
                                {false, ErrCode} -> {false, ErrCode}
                            end;
                        false -> {false, ?FLOOR_NOT_REACH}
                    end
            end;
        false -> 
            ?BIN_PRED(CurFloor =:= Floor, true, {false, ?ERROR_FLOOR})
    end.


%% @doc 取得爬塔最大次数
% get_max_chal_times(_Status) ->
%     redo,
%     ?MAX_TOWER_TIMES.


%% @doc 取得最大挑战次数
get_chal_boss_times(Status) ->
    case player:get_vip_lv(Status) =:= 0 of
        true -> ?HARD_TOWER_MAX_CHAL_TIMES;
        false -> ?HARD_TOWER_MAX_CHAL_TIMES
    end. 


%% @doc 取得最大可购买次数
get_max_buy_times(Status) ->
    case player:get_vip_lv(Status) =:= 0 of
        true -> ?HARD_TOWER_MAX_BUY_TIMES;
        false -> ?HARD_TOWER_MAX_BUY_TIMES
    end.


update_tower_rd(Tower) ->
    ets:insert(?ETS_HARD_TOWER, Tower).

del_tower_rd(Tower) ->
    ets:delete(?ETS_HARD_TOWER, Tower#hardtower.id).


%% @return null | #hardtower{}
get_tower_rd(RoleId) ->
    case ets:lookup(?ETS_HARD_TOWER, RoleId) of
        [Tower] when is_record(Tower, hardtower) -> Tower;
        _ -> null
    end.


%% @doc 设置新的爬塔记录并保存
save_new_tower_record(Status) ->
    Tower = #hardtower{id = player:id(Status)},
    update_tower_rd(Tower),
    db:insert(player:id(Status), hardtower, [
        {id, Tower#hardtower.id}
        ,{tower_no, Tower#hardtower.tower_no}
        ,{floor, Tower#hardtower.floor}
        ,{chal_boss_times, Tower#hardtower.chal_boss_times}
        ,{buy_times, Tower#hardtower.buy_times}
        ,{schedule_times, Tower#hardtower.schedule_times}
        ,{refresh_stamp, Tower#hardtower.refresh_stamp}
        ,{span_exp_floor, Tower#hardtower.span_exp_floor}
        ,{best_floor, Tower#hardtower.best_floor}
    ]).
  

%% @doc 更新爬塔信息进度
db_update_tower(Tower) ->
    db:update(Tower#hardtower.id, hardtower, 
        [
        {tower_no, Tower#hardtower.tower_no}
        ,{floor, Tower#hardtower.floor}
        ,{chal_boss_times, Tower#hardtower.chal_boss_times}
        ,{buy_times, Tower#hardtower.buy_times}
        ,{schedule_times, Tower#hardtower.schedule_times}
        ,{refresh_stamp, Tower#hardtower.refresh_stamp}
        ,{span_exp_floor, Tower#hardtower.span_exp_floor}
        ,{best_floor, Tower#hardtower.best_floor}
        ],
        [{id, Tower#hardtower.id}]
    ).