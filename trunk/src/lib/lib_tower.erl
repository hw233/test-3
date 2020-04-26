%%%-----------------------------------
%%% @Module  : lib_tower
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2014.1
%%% @Description: 爬塔函数
%%%-----------------------------------
-module(lib_tower).

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
    ,enter_tower/3
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
    ,send_reward/2
    ,handle_tower_login/2
    ,notify_tower_battle_lost/1
  ,gm_enter_tower/2
  ,is_in_tower/1
  ,back_event/1
,notify_tower_reward/2,db_update_tower/1
  % ,gm_clean_schedule/1
]).


%% ====================================================================
%% API functions
%% ====================================================================

%% @doc 取得爬塔信息
get_tower_info(Status) ->
    RoleId = player:id(Status),
    case get_tower_rd(RoleId) of
        Tower when is_record(Tower, tower) ->
            NewTower = refresh_tower_rd(Tower, util:get_now_days()),
            Times = ?BIN_PRED(?MAX_TOWER_TIMES > NewTower#tower.schedule_times, ?MAX_TOWER_TIMES - NewTower#tower.schedule_times, 0),
            {ok, BinData} = pt_49:write(49001, [NewTower#tower.floor, get_max_floor(), Times, NewTower#tower.best_floor,NewTower#tower.have_jump]),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        _ ->
            lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR)
    end.


%% @doc 取得塔的最高层层数
get_max_floor() ->
    data_tower:get_max_floor().


-define(ERROR_FLOOR, 5).
-define(VIP_LIMIT, 6).   

%% @doc 进入爬塔副本
enter_tower(Floor, Status, State) ->
    TeamFlag = player:is_in_team(Status),
    DunFlag = is_in_tower(Status),
    % LvFlag = not_fit_tower_lv(Floor, player:get_lv(Status)),
    if  
        TeamFlag ->
            {ok, BinData} = pt_49:write(49003, [?TEAM_LIMIT]),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        % LvFlag ->
        %     {ok, BinData} = pt_49:write(49003, [?LV_NOT_ENGOUTH]),
        %     lib_send:send_to_sock(Status#player_status.socket, BinData);
        DunFlag ->
            {ok, BinData} = pt_49:write(49003, [?ERROR]),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        true ->
            RoleId = player:id(Status),
            case get_tower_rd(RoleId) of
                OldTower when is_record(OldTower, tower) ->
                    Tower = refresh_tower_rd(OldTower, util:get_now_days()),
                    case check_floor(Floor, Tower, Status) of
                        {false, ErrCode} -> 
                            {ok, BinData} = pt_49:write(49003, [ErrCode]),
                            lib_send:send_to_sock(Status#player_status.socket, BinData);
                        true ->
                            Now = util:unixtime(),
                            % Nowdays = util:get_now_days(),
                            case lib_dungeon:can_create_dungeon(?TOWER_DUNGEON_NO, Now, Status) of
                                {true, _} -> 
                                    case Tower#tower.chal_boss_times - Tower#tower.buy_times >= get_chal_boss_times(Status) of
                                        true -> lib_send:send_prompt_msg(Status, ?PM_TOWER_NO_CHAL_TIMES);
                                        false -> 
                                            case recv_span_exp(Floor, Status, State, Tower#tower.floor, Tower#tower{floor = Floor}) of
                                                true ->
                                                    % 添加统计
                                                    case Tower#tower.floor =:= ?DEF_FLOOR andalso Floor > 1 of
                                                        true -> catch lib_log:statis_tower(Status, "span_floor", Floor);
                                                        false -> skip
                                                    end,

                                                    % 通关爬塔
                                                    mod_achievement:notify_achi(pass_tower, [{num, Floor}], player:get_PS(RoleId)), 
                                                    catch mod_rank:role_tower(Status, Floor),

                                                    % update_tower_rd(Tower#tower{floor = Floor}),
                                                    gen_server:cast(?DUNGEON_MANAGE, {'create_tower_dungeon', ?TOWER_DUNGEON_NO, Now, RoleId, ?FLOOR_TO_ID(Floor)});
                                                false -> skip
                                            end
                                    end;
                                {false, [{_, Code} | _]} ->
                                    {ok, BinData} = pt_49:write(49003, [Code]),
                                    lib_send:send_to_sock(Status#player_status.socket, BinData)
                            end
                    end;
                _ ->
                    {ok, BinData} = pt_49:write(49003, [?PM_UNKNOWN_ERR]),
                    lib_send:send_to_sock(Status#player_status.socket, BinData)
            end
    end.


gm_enter_tower(Floor, RoleId) ->
    gen_server:cast(?DUNGEON_MANAGE, {'create_tower_dungeon', ?TOWER_DUNGEON_NO, util:unixtime(), RoleId, ?FLOOR_TO_ID(Floor)}).


%% 登录重进爬塔处理
handle_tower_login(Now, Status) ->
    case get(?TOWER_POSITION_FALG) of
        ?TOWER_DUNGEON_NO -> 
            % ?LDS_TRACE(handle_tower_login),
            erase(?TOWER_POSITION_FALG), 
            re_enter_tower(Now, Status);
        _ -> skip
    end.


%% @doc 重新进入爬塔
re_enter_tower(Now, Status) ->
    RoleId = player:id(Status),
    case get_tower_rd(RoleId) of
        Tower when is_record(Tower, tower) ->
            ?LDS_TRACE("re_enter_tower"),
            gen_server:cast(player:get_pid(Status), {apply_cast, ?MODULE, re_enter_tower_1, [Now, RoleId, Tower]});
            % gen_server:cast(?DUNGEON_MANAGE, {'create_tower_dungeon', ?TOWER_DUNGEON_NO, Now, RoleId, ?FLOOR_TO_ID(Tower#tower.floor)});
        _ -> ?ASSERT(false)
    end.


re_enter_tower_1(Now, RoleId, Tower) ->
    gen_server:cast(?DUNGEON_MANAGE, {'create_tower_dungeon', ?TOWER_DUNGEON_NO, Now, RoleId, ?FLOOR_TO_ID(Tower#tower.floor)}).


reset_tower_rd(Status) ->
    case get_tower_rd(player:id(Status)) of
        OldTower when is_record(OldTower, tower) ->
            Tower = #tower{id = player:id(Status), best_floor = OldTower#tower.best_floor},
            update_tower_rd(Tower),
            db:update(player:id(Status), tower, [
                {floor, Tower#tower.floor}
                ,{chal_boss_times, Tower#tower.chal_boss_times}
                ,{buy_times, Tower#tower.buy_times}
                ,{schedule_times, Tower#tower.schedule_times}
                ,{refresh_stamp, Tower#tower.refresh_stamp}
                ,{span_exp_floor, Tower#tower.span_exp_floor}
                ,{best_floor, Tower#tower.best_floor}
            ], [{id, Tower#tower.id}]
            );
            % update_tower_rd(Tower#tower{floor = ?DEF_FLOOR, chal_boss_times = 0, buy_times = 0});
        _ -> ?ASSERT(false)
    end.



%% 通知爬塔界面信息
notify_tower_info(RoleId) ->
    case player:get_pid(RoleId) of
        Pid when is_pid(Pid) -> gen_server:cast(Pid, 'notify_tower_info');
        _ -> skip
    end.

%% @doc 爬塔副本内信息
get_tower_dungeon_info(Status) ->
    RoleId = player:id(Status),
    case is_in_tower(Status) of
        true ->
            case get_tower_rd(RoleId) of
                Tower when is_record(Tower, tower) ->
                    % ?LDS_TRACE(49002, get_chal_boss_times(Status)),
                    {ok, BinData} = pt_49:write(49002, 
                        [Tower#tower.floor, Tower#tower.chal_boss_times, get_chal_boss_times(Status), Tower#tower.buy_times, get_max_buy_times(Status)]),
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
        Tower when is_record(Tower, tower) ->
            case Tower#tower.chal_boss_times =:= 0 orelse Tower#tower.buy_times >= get_max_buy_times(Status) of
                true -> ?ASSERT(false);
                false ->
                    case player:has_enough_bind_yuanbao(Status, ?BUY_TIMES_MONEY) of
                        true -> 
                            player:cost_bind_yuanbao(Status, ?BUY_TIMES_MONEY, [?LOG_TOWER, "buy_times"]),
                            update_tower_rd(Tower#tower{buy_times = Tower#tower.buy_times + 1}),
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
            {ok, BinData} = pt_49:write(49008, []),
            lib_send:send_to_uid(player:id(Status), BinData),
            close_tower(Status);
        false -> skip
    end.


%% @doc 设置通关当层信息
%% @return boolean()
set_next_floor(RoleId, CurFloor) ->
    NextFloor = CurFloor + 1,
    case CurFloor > get_max_floor() of
        true -> false;
        false ->
            case get_tower_rd(RoleId) of
                Tower when is_record(Tower, tower) ->
%%                    ?ASSERT((Tower#tower.floor + 1) =:= NextFloor, [Tower#tower.floor, NextFloor]),
                    Nowdays = util:get_now_days(),
                    BestFloor = ?BIN_PRED(Tower#tower.best_floor < CurFloor, CurFloor, Tower#tower.best_floor),
                    NewTowerRd = 
                        case Nowdays =:= Tower#tower.refresh_stamp of
                            true -> Tower#tower{floor = NextFloor, chal_boss_times = 0, buy_times = 0, best_floor = BestFloor};
                            false -> Tower#tower{floor = ?DEF_FLOOR + 1, chal_boss_times = 0, buy_times = 0, span_exp_floor = 0, best_floor = BestFloor}

                        end,
                    update_tower_rd(NewTowerRd),
                    db_update_tower(NewTowerRd),
                    %爬塔通过指定层数
                    mod_achievement:notify_achi(pass_tower, [{num, CurFloor}], player:get_PS(RoleId)), 
                    case player:get_PS(RoleId) of
                        null -> skip;
                        PS ->
                            %% 统计爬塔
                            % CurFloor = NextFloor - 1,
                            catch lib_log:statis_tower(PS, "battle", CurFloor),
                            catch mod_rank:role_tower(PS, CurFloor),
                            case Tower#tower.best_floor < CurFloor of
                                true ->
                                    % case CurFloor of
                                    %     10 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_10, [player:get_name(PS), RoleId]});
                                    %     20 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_20, [player:get_name(PS), RoleId]});
                                    %     30 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_30, [player:get_name(PS), RoleId]});
                                    %     40 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_40, [player:get_name(PS), RoleId]});
                                    %     50 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_50, [player:get_name(PS), RoleId]});
                                    %     60 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_60, [player:get_name(PS), RoleId]});
                                    %     70 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_70, [player:get_name(PS), RoleId]});
                                    %     80 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_80, [player:get_name(PS), RoleId]});
                                    %     90 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_90, [player:get_name(PS), RoleId]});
                                    %     100 -> catch ply_tips:send_sys_tips(PS, {tower_pass_floor_100, [player:get_name(PS), RoleId]});
                                    %     _Any -> skip
                                    % end;

                                    % 40层以上开始广播                                    
                                    if 
                                        CurFloor > 40 ->
                                            catch ply_tips:send_sys_tips(PS, {tower_pass_floor, [player:get_name(PS), RoleId,CurFloor]});
                                        true -> skip
                                    end;
                                false -> skip
                            end
                    end,

                    true;
                _ -> false
            end
    end.
    % ?ERROR_MSG("TOWER set_next_floor !!!!!!!!! ~p~n ", [NextFloor]),
    


%% @return new #tower{}
refresh_tower_rd(Tower, Nowdays) ->
    case Nowdays =:= Tower#tower.refresh_stamp of
        true -> Tower;
        false -> 
            case player:get_PS(Tower#tower.id) of
                Status when is_record(Status, player_status) ->
                    reset_close_tower(Status);
                _ -> skip
            end,
            NewTower = #tower{refresh_stamp = Nowdays, schedule_times = 0, 
                id = Tower#tower.id, floor =?DEF_FLOOR, span_exp_floor = 0, best_floor = Tower#tower.best_floor},
            update_tower_rd(NewTower),
            NewTower
    end.


%% @doc 给予爬塔奖励
send_reward(RoleId, ListenerId) ->
    Floor = ?ID_TO_FLOOR(ListenerId),
    Config = lib_dungeon:get_config_tower_reward_data(Floor),
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
    case (Floor rem ?SPAN_FLOOR_COEF) =:= 1 andalso CurFloor =:= ?DEF_FLOOR of
        true -> 
            case lib_vip:welfare(climb_tower_quick_enter_layer, Status) >= Floor of
                true -> 
                    NeedMoney = data_tower_reward:get_span_coin(Floor),

                    ?DEBUG_MSG("NeedMoney=~p",[NeedMoney]),

                    case get_span_money_and_type(Floor) of

                        {MoneyType, NeedMoney} ->
                            case player:has_enough_money(Status, MoneyType, NeedMoney) of
                                true ->
                                    update_tower_rd(Tower), 
                                    db_update_tower(Tower),
                                    player:cost_money(Status, MoneyType, NeedMoney, [?LOG_TOWER, "span_floor"]),
                                    CalExp = data_tower_reward:get_span_exp(Floor),
                                    % 去掉人物经验
                                    % player:add_all_exp(Status, CalExp, [?LOG_TOWER, "span_floor"]),
                                    PetAllExp = lib_reward:calc_all_exp_to_partners(Status, CalExp),
                                    % Config = lib_dungeon:get_config_tower_reward_data(Floor),
                                    SpanReward = data_tower_reward:get_span_reward(Floor),
                                    RoleId = player:id(Status),
                                    F = fun(RewardId, Sum) ->
                                        RewardRd = lib_reward:give_reward_to_player(Status, RewardId, [?LOG_TOWER, "span_floor"]),
                                        List = [{Id, No, Num, mod_inv:get_goods_quality_by_id(RoleId, Id), mod_inv:get_goods_bind_state_by_id(Id)}
                                            || {Id, No, Num} <- RewardRd#reward_dtl.goods_list],
                                        Sum ++ List
                                    end,
                                    CountList = lists:reverse(lists:foldl(F, [], SpanReward)),

                                    Fpar = fun(PartnerId, Acc) ->
                                        case lib_partner:get_partner(PartnerId) of
                                            null -> Acc;
                                            Partner ->
                                                case lib_partner:is_fighting(Partner) of
                                                    false -> Acc;
                                                    true ->                                                                                                                
                                                        case PetAllExp > 0 of
                                                            true -> 
                                                                lib_partner:add_exp(Partner, PetAllExp, Status, [?LOG_TOWER, "span_floor"]),
                                                                Acc;
                                                            false -> Acc
                                                        end
                                                end
                                        end
                                    end,
                                    lists:foldl(Fpar, 0, player:get_partner_id_list(Status)),

                                    % ?LDS_DEBUG(49007, [{0, ?VGOODS_EXP, CalExp, 0} | CountList]),
                                    {ok, BinData} = pt_49:write(49007, [[{0, ?VGOODS_EXP, 0, 0, ?BIND_NEVER}, 
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
get_span_money_and_type(Floor) ->
    % case data_tower_reward:get_span_money(Floor) of
        % Int when is_integer(Int) andalso Int > 0 -> {?MNY_T_BIND_YUANBAO, Int};
        % _ -> 
            case data_tower_reward:get_span_coin(Floor) of
                Int when is_integer(Int) -> {?MNY_T_BIND_GAMEMONEY, Int};
                _ -> null
            % end
    end.


%% @doc 清除爬塔进度
clean_schedule(Status) ->
    RoleId = player:id(Status),
    case get_tower_rd(RoleId) of
        Tower when is_record(Tower, tower) ->
            NewTower = refresh_tower_rd(Tower, util:get_now_days()),
            SchduleTimes = NewTower#tower.schedule_times,
            case SchduleTimes < ?MAX_TOWER_TIMES of
                true -> update_tower_rd(NewTower#tower{floor = ?DEF_FLOOR, schedule_times = SchduleTimes + 1, span_exp_floor = 0,
                            chal_boss_times = 0, buy_times = 0});
                false -> skip
            end,
            get_tower_info(Status);
        _ -> ?ASSERT(false)
    end.


%% @doc 开通爬塔
open_tower_system(Status) ->
    RoleId = player:id(Status),
    case ply_sys_open:is_open(Status, ?SYS_TOWER) of
        true ->
            case get_tower_rd(RoleId) of
                Tower when is_record(Tower, tower) -> skip;
                _ -> save_new_tower_record(Status)
            end;
        false -> skip
    end.


%% @doc 登录加载
login(_Status, role_in_cache) ->
    skip;
login(Status, _) ->
    RoleId = player:id(Status),
    case ply_sys_open:is_open(Status, ?SYS_TOWER) of
        true -> 
            case db:select_row(tower, "`floor`, `chal_boss_times`, `buy_times`, `schedule_times`, `refresh_stamp`, `span_exp_floor`, `best_floor`,`have_jump`",
                [{id, RoleId}]) of
                [Floor, ChalTimes, BuyTimes, SchduleTimes, RefreshStamp, SpanFloor, BestFloor,HaveJump] ->
                    update_tower_rd(#tower{id = RoleId, floor = Floor, chal_boss_times = ChalTimes, buy_times = BuyTimes,
                        schedule_times = SchduleTimes, refresh_stamp = RefreshStamp, span_exp_floor = SpanFloor, best_floor = BestFloor,have_jump = HaveJump});
                _ -> save_new_tower_record(Status) %?ASSERT(false, [Status])
            end;
        false -> skip
    end.


logout(Status) ->
    RoleId = player:id(Status),
    case ply_sys_open:is_open(Status, ?SYS_TOWER) of
        true -> 
            case get_tower_rd(RoleId) of
                Tower when is_record(Tower, tower) -> 
                    del_tower_rd(Tower),
                    db_update_tower(Tower);
                _ -> ?ASSERT(false)
            end;
        false -> skip
    end.


%% 通知爬塔战斗失败
notify_tower_battle_lost(Status) ->
  {ok, BinData} = pt_49:write(49006, []),
  lib_send:send_to_sid(Status, BinData).



%% 通知爬塔奖励获取
notify_tower_reward(Status, GoodsList) ->
    {ok, BinData} = pt_49:write(49007, [GoodsList]),
    lib_send:send_to_sid(Status, BinData).



%% ====================================================================
%% Intenal functions
%% ====================================================================

%% 是否满足进入爬塔条件
%% @return true | {false, Errcode}
check_fit_tower_lv(Floor, Status) -> 
    case lib_vip:welfare(climb_tower_quick_enter_layer, Status) >= Floor of
        true -> 
            Lv = player:get_lv(Status),
            TowerConfig = lib_dungeon:get_config_tower_reward_data(Floor),
            FitLv = TowerConfig#tower_config.lv,
            ?BIN_PRED(Lv >= FitLv, true, {false, ?LV_NOT_ENGOUTH});
        false -> {false, ?VIP_LIMIT}
    end.

% get_tower_dun() ->
%     lib_dungeon:get_config_data(?TOWER_DUNGEON_NO).


%% @doc 爬塔事件
event(EventType, Status) when EventType =:= ?BATTLE_FAIL_GROUP orelse EventType =:= ?BATTLE_ESCAPE ->
    RoleId = player:id(Status),
    case get_tower_rd(RoleId) of
        Tower when is_record(Tower, tower) ->
            NewTower = Tower#tower{chal_boss_times = Tower#tower.chal_boss_times + 1},
            update_tower_rd(NewTower),
            case NewTower#tower.chal_boss_times =< (get_chal_boss_times(Status) + NewTower#tower.buy_times) of
                true -> 
                    {ok, BinData} = pt_49:write(49002, [NewTower#tower.floor, NewTower#tower.chal_boss_times, 
                        get_chal_boss_times(Status), NewTower#tower.buy_times, get_max_buy_times(Status)]),
                    lib_send:send_to_sock(Status#player_status.socket, BinData);
                false -> 
                    close_tower(Status)
            end;
        _ -> ?ASSERT(false)
    end;

event(_, _) -> skip.


back_event(Status)  ->
  RoleId = player:id(Status),
  case get_tower_rd(RoleId) of
    Tower when is_record(Tower, tower) ->
      NewTower = Tower#tower{chal_boss_times = Tower#tower.chal_boss_times + 1},
      update_tower_rd(NewTower),
      case NewTower#tower.chal_boss_times =< (get_chal_boss_times(Status) + NewTower#tower.buy_times) of
        true ->
          {ok, BinData} = pt_49:write(49002, [NewTower#tower.floor, NewTower#tower.chal_boss_times,
            get_chal_boss_times(Status), NewTower#tower.buy_times, get_max_buy_times(Status)]),
          lib_send:send_to_sock(Status#player_status.socket, BinData);
        false ->
          close_tower(Status)
      end;
    _ -> ?ASSERT(false)
  end.


%% @doc 是否在爬塔副本中
%% @return boolean()
is_in_tower(Status) ->
    case player:is_in_dungeon(Status) of
        {true, _} -> player:get_dungeon_type(Status) =:= ?DUNGEON_TYPE_TOWER;
        false -> false
    end.

-define(FLOOR_NOT_REACH, 7). % 未通关此层 
%% @doc 检查选择的层数是否合法
%% @return : true | {false, ErrCode}
check_floor(0, _Tower, _) -> false;
check_floor(Floor, Tower, Status) ->
    CurFloor = Tower#tower.floor,
    case CurFloor =:= ?DEF_FLOOR of
        true ->
            case Floor =:= 1 orelse (Floor rem ?SPAN_FLOOR_COEF) =:= 1 of
                false -> {false, ?ERROR_FLOOR};
                true ->
                    case (Tower#tower.best_floor + 1) >= Floor orelse Floor =:= 1 of
                        true ->
                            case check_fit_tower_lv(Floor, Status) of
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
        true -> ?MAX_CHAL_TIMES;
        false -> ?VIP_EXTRA_CHAL_TIMES + ?MAX_CHAL_TIMES
    end. 


%% @doc 取得最大可购买次数
get_max_buy_times(Status) ->
    case player:get_vip_lv(Status) =:= 0 of
        true -> ?MAX_BUY_TIMES;
        false -> ?MAX_BUY_TIMES + ?VIP_EXTRA_BUY_TIMES
    end.


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


%% @doc 设置新的爬塔记录并保存
save_new_tower_record(Status) ->
    Tower = #tower{id = player:id(Status)},
    update_tower_rd(Tower),
    db:insert(player:id(Status), tower, [
        {id, Tower#tower.id}
        ,{floor, Tower#tower.floor}
        ,{chal_boss_times, Tower#tower.chal_boss_times}
        ,{buy_times, Tower#tower.buy_times}
        ,{schedule_times, Tower#tower.schedule_times}
        ,{refresh_stamp, Tower#tower.refresh_stamp}
        ,{span_exp_floor, Tower#tower.span_exp_floor}
        ,{best_floor, Tower#tower.best_floor}
      ,{have_jump,Tower#tower.have_jump}
    ]).
  

%% @doc 更新爬塔信息进度
db_update_tower(Tower) ->
    db:update(Tower#tower.id, tower, 
        [
        {floor, Tower#tower.floor}
        ,{chal_boss_times, Tower#tower.chal_boss_times}
        ,{buy_times, Tower#tower.buy_times}
        ,{schedule_times, Tower#tower.schedule_times}
        ,{refresh_stamp, Tower#tower.refresh_stamp}
        ,{span_exp_floor, Tower#tower.span_exp_floor}
        ,{best_floor, Tower#tower.best_floor}
          ,{have_jump,Tower#tower.have_jump}
        ],
        [{id, Tower#tower.id}]
    ).
