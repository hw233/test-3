%%%-----------------------------------
%%% @Module  : lib_reward
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.11.4
%%% @Description: 奖励相关的接口
%%%-----------------------------------
-module(lib_reward).
-export([
        is_reward_pkg_valid/1,
        check_bag_space/2,
        check_bag_space/3,
    	give_reward_to_player/3,
        give_reward_to_player/4,
        give_reward_to_player/5,    %% 专用于循环任务 给予玩家奖励
        give_reward_to_player/6,    %% 专用于循环任务 给予玩家奖励
        decide_goods_by_prob/1,
        calc_reward_to_player/2,    %% 计算某个奖励，玩家获得的物品列表，还没有发给玩家.(如果可以通过物品使用获得奖励则没必要使用这个接口)
        calc_reward_to_player/3,    %% 计算某个奖励，玩家获得的物品列表，还没有发给玩家.(如果可以通过物品使用获得奖励则没必要使用这个接口)
        calc_all_exp_to_partners/2, %% 计算所有宠物获得的经验总和
        get_lv_delta_coef/1,
        get_reward_by_gosht_faction_task/0
        
    ]).

-include("common.hrl").
-include("record.hrl").
-include("reward.hrl").
-include("goods.hrl").
-include("event.hrl").
-include("prompt_msg_code.hrl").
-include("buff.hrl").
-include("task.hrl").
-include("protocol/pt_30.hrl").


get_reward_pkg_cfg_data(RewardPkgNo) ->
    data_reward_pkg:get(RewardPkgNo).



is_reward_pkg_valid(RewardPkgNo) ->
    get_reward_pkg_cfg_data(RewardPkgNo) /= null.

check_bag_space(PS_Or_PlayerId, Para) ->
    check_bag_space(PS_Or_PlayerId, Para, 1).

%% （给奖励前）判断玩家的背包空间是否足够
%% @return: ok（够） | {fail, Reason}（不够）
check_bag_space(_PS, [], _Multiple) ->
    ok;
%% 此函数要求:奖励产出的物品，同一个编号的物品，绑定状态需要一致
check_bag_space(PS, RewardPkgNoList, Multiple) when is_record(PS, player_status) andalso is_list(RewardPkgNoList) ->
    F = fun(RewardPkgNo, Acc) ->
        RewardDtl = calc_reward_to_player(PS, RewardPkgNo, Multiple),
        RewardDtl#reward_dtl.calc_goods_list ++ Acc
    end,
    RetList = lists:foldl(F, [], RewardPkgNoList),
    F1 = fun(GoodsInfo, Acc) ->
        case GoodsInfo of
            {GoodsNo, GoodsCount, _Quality, _BindState} ->
                case is_virtual_goods_no(GoodsNo) of
                    true -> Acc;
                    false -> [{GoodsNo, GoodsCount} | Acc]
                end;
            {GoodsNo, GoodsCount, _Quality, _BindState,_Notice} ->
                case is_virtual_goods_no(GoodsNo) of
                    true -> Acc;
                    false -> [{GoodsNo, GoodsCount} | Acc]
                end
        end
    end,
    RetList1 = lists:foldl(F1, [], RetList),
    mod_inv:check_batch_add_goods(player:id(PS), RetList1);

check_bag_space(PS, RewardPkgNo, Multiple) when is_record(PS, player_status) andalso is_integer(RewardPkgNo) ->
    ?ASSERT(is_reward_pkg_valid(RewardPkgNo), RewardPkgNo),
    PlayerId = player:id(PS),
    check_bag_space(PlayerId, RewardPkgNo, Multiple);

check_bag_space(PlayerId, RewardPkgNo, Multiple) when is_integer(PlayerId) andalso is_integer(RewardPkgNo) ->
    ?ASSERT(is_reward_pkg_valid(RewardPkgNo), RewardPkgNo),
    RewardPkgCfg = get_reward_pkg_cfg_data(RewardPkgNo),
    RewardGoodsList = RewardPkgCfg#reward_pkg.goods_list,
    
    F = fun(X, GoodsList) ->
        {GoodsNo, GoodsCount} = 
            case X of
                {_TempProba, TempNo, TempCount, _TBindState} -> {TempNo, TempCount*Multiple};
                {_TempProba, TempNo, TempCount, _TempQuality, _TBindState} -> {TempNo, TempCount*Multiple};
                {_TempProba, TempNo, TempCount, _TempQuality, _TBindState, _} -> {TempNo, TempCount*Multiple}
            end,
        [{GoodsNo, GoodsCount}] ++ GoodsList
    end,

    TotalGoodsList1 = lists:foldl(F, [], [X || X <- RewardGoodsList]),

    %% 根据性别种族额外给予的物品统计
    F1 = fun(Para) ->
        {_Proba, GoodsNoList, Count} = 
            case Para of
                {TProba, TGoodsNoList, TCount, _TBindState} -> {TProba, TGoodsNoList, TCount*Multiple};
                {TProba, TGoodsNoList, TCount, _TQuality, _TBindState} -> {TProba, TGoodsNoList, TCount*Multiple};
                {TProba, TGoodsNoList, TCount, _TQuality, _TBindState,_} -> {TProba, TGoodsNoList, TCount*Multiple}
            end,
        Index = get_index(Para, RewardPkgCfg#reward_pkg.goods_added),


        {Race, Sex, Faction} = 
        case lists:nth(Index, RewardPkgCfg#reward_pkg.condition) of
            {_Race,_Sex} -> {_Race,_Sex,0};
            {_Race,_Sex,_Faction} -> {_Race,_Sex,_Faction}
        end,

        ?DEBUG_MSG("Race=~p, Sex=~p, Faction=~p",[Race, Sex, Faction]),
        Fadd = fun(GoodsNo,Acc) ->
            SexB = (Sex =:= 0 orelse player:get_sex(PlayerId) =:= lib_goods:get_sex(GoodsNo) orelse 0 =:= lib_goods:get_sex(GoodsNo)),
            RaceB = (Race =:= 0 orelse player:get_race(PlayerId) =:= lib_goods:get_race(GoodsNo) orelse 0 =:= lib_goods:get_race(GoodsNo)),
            FactionB = (Faction =:= 0 orelse player:get_faction(PlayerId)  =:= lib_goods:get_faction(GoodsNo) orelse 0 =:= lib_goods:get_faction(GoodsNo)),

            ?DEBUG_MSG("SexB=~p,RaceB=~p,FactionB=~p, SexB=~p,RaceB=~p,FactionB=~p ",
                [SexB,RaceB,FactionB, lib_goods:get_sex(GoodsNo),
                lib_goods:get_race(GoodsNo),lib_goods:get_faction(GoodsNo) ]),
            Ret = 
            if
               SexB andalso RaceB andalso FactionB -> [GoodsNo|Acc];
               true -> Acc
            end,


            Ret
        end,

        AddGoodsNoList = lists:foldl(Fadd, [], GoodsNoList),

        % AddGoodsNoList = 
        %     case Race =:= 0 of
        %         true ->
        %             case Sex =:= 0 of
        %                 true -> GoodsNoList;
        %                 false -> [GoodsNo || GoodsNo <- GoodsNoList, lib_goods:get_sex(GoodsNo) =:= player:get_sex(PlayerId)]
        %             end;
        %         false ->
        %             case Sex =:= 0 of
        %                 true -> [GoodsNo || GoodsNo <- GoodsNoList, lib_goods:get_race(GoodsNo) =:= player:get_race(PlayerId)];
        %                 false -> [GoodsNo || GoodsNo <- GoodsNoList, lib_goods:get_race(GoodsNo) =:= player:get_race(PlayerId), lib_goods:get_sex(GoodsNo) =:= player:get_sex(PlayerId)]
        %             end
        %     end,

        F2 = fun(X, List) ->
            case lib_goods:get_tpl_data(X) of
                null -> 
                    List;
                _ ->
                    [{X, Count}] ++ List
            end
        end,
        lists:foldl(F2, [], AddGoodsNoList)
    end,
    
    TotalGoodsList2 = 
        case RewardPkgCfg#reward_pkg.goods_added =:= [] of
            true -> [];
            false -> 
                ListList = lists:map(F1, RewardPkgCfg#reward_pkg.goods_added),
                F3 = fun(L, Acc) -> 
                    L ++ Acc
                end,
                lists:foldl(F3, [], ListList)
        end,

    case RewardPkgCfg#reward_pkg.goods_rule  of
        0 ->
            TotalGoodsList3 = TotalGoodsList1 ++ TotalGoodsList2,
            mod_inv:check_batch_add_goods(PlayerId, TotalGoodsList3);
        Other -> %% 按概率总和是1，抽取一个物品
            case Other >random:uniform() of
                true ->
                    F11 = fun({No1, _Cnt1}, Sum1) ->
                        GoodsTpl1 = lib_goods:get_tpl_data(No1),
                        case lib_goods:is_equip(GoodsTpl1) of
                            true -> Sum1 + 1*Multiple;
                            false -> Sum1
                        end
                          end,
                    EquipCount1 = case lists:foldl(F11, 0, TotalGoodsList1) >= 1 of true -> 1; false -> 0 end,
                    EquipCount2 = lists:foldl(F11, 0, TotalGoodsList2),

                    F22 = fun({No2, _Cnt2}, Sum2) ->
                        GoodsTpl2 = lib_goods:get_tpl_data(No2),
                        case lib_goods:is_equip(GoodsTpl2) of
                            true ->
                                Sum2;
                            false ->
                                case lib_goods:is_can_use(GoodsTpl2) of
                                    true -> Sum2 + 1;
                                    false -> Sum2
                                end
                        end
                          end,
                    UsCount1 = case lists:foldl(F22, 0, TotalGoodsList1) >= 1 of true -> 1; false -> 0 end,
                    UsCount2 = lists:foldl(F22, 0, TotalGoodsList2),

                    F33 = fun({No3, _Cnt3}, Sum3) ->
                        GoodsTpl3 = lib_goods:get_tpl_data(No3),
                        case lib_goods:is_equip(GoodsTpl3) of
                            true ->
                                Sum3;
                            false ->
                                case lib_goods:is_can_use(GoodsTpl3) of
                                    false -> Sum3 + 1;
                                    true -> Sum3
                                end
                        end
                          end,
                    UnUsCount1 = case lists:foldl(F33, 0, TotalGoodsList1) >= 1 of true -> 1; false -> 0 end,
                    UnUsCount2 = lists:foldl(F33, 0, TotalGoodsList2),
                    RetBool1 = mod_inv:calc_empty_slots(PlayerId, ?LOC_BAG_EQ) >= EquipCount1 + EquipCount2,
                    RetBool2 = mod_inv:calc_empty_slots(PlayerId, ?LOC_BAG_USABLE) >= UsCount1 + UsCount2,
                    RetBool3 = mod_inv:calc_empty_slots(PlayerId, ?LOC_BAG_UNUSABLE) >= UnUsCount1 + UnUsCount2,
                    case RetBool1 andalso RetBool2 andalso RetBool3 of
                        true -> ok;
                        false ->
                            if
                                RetBool1 =:= false -> {fail, ?PM_EQ_BAG_FULL};
                                RetBool2 =:= false -> {fail, ?PM_US_BAG_FULL};
                                true -> {fail, ?PM_UNUS_BAG_FULL}
                            end
                    end;
                false ->
                    ok
            end

    end.


%% 循环任务 给予玩家奖励（注意：给奖励前应该先调用check_bag_space()以检查玩家的背包空间是否够！）
%% @para: RewardPkgNo => 奖励包编号
%% @para: TaskDifficultyCoef => 任务难度系数
%% @para: Ring => 环数
%% @para: Time => 用时，单位：s 如果没有用到则传入0
%% @return: reward_dtl结构体
%% 经验or金钱 = （系数A*(队伍平均等级的平方)+系数B*队伍平均等级+常数C）*任务难度系数*（环数增益系数*环数+1）*等级差减益系数 * （时间系数*时间+1）* 轮数系数
give_reward_to_player(task, PS, RewardPkgNo, [TaskNo, Ring, Time], LogInfo) ->
    give_reward_to_player(task, PS, RewardPkgNo, [TaskNo, Ring, Time], LogInfo, 1);

give_reward_to_player(tower, PS, RewardPkgNo, [Floor, BattlePower], LogInfo) ->
    give_reward_to_player(tower, PS, RewardPkgNo, [Floor, BattlePower], LogInfo, 1);

give_reward_to_player(common, PS, RewardPkgNo, [], LogInfo) ->
    give_reward_to_player(common, PS, RewardPkgNo, [], LogInfo, 1);

% --------------------
give_reward_to_player(dungeon,NewTime,PS, RewardPkgNo, LogInfo) ->
    Multiple = 1,
    case NewTime > 3 of
        true ->
            give_reward_to_player(PS, RewardPkgNo, LogInfo, Multiple);
        false ->
            % 给全绑定道具
            ?ASSERT(is_reward_pkg_valid(RewardPkgNo), RewardPkgNo),
            case get_reward_pkg_cfg_data(RewardPkgNo) of
                null -> 
                    ?ERROR_MSG("lib_reward:give_reward_to_player error!PlayerId:~p,RewardPkgNo:~p,LogInfo:~w~n", [player:id(PS), RewardPkgNo, LogInfo]),
                    #reward_dtl{};
                RewardPkgCfg ->
                    % 给钱
                    RewardMoneyList = give_reward_to_player__(money, PS, RewardPkgCfg#reward_pkg.money, LogInfo, Multiple),
                    % 给经验
                    Reward2 = give_reward_to_player__(exp, PS, RewardPkgCfg, LogInfo, Multiple),

                    % 给天赋属性
                    Reward3 = give_reward_to_player__(talents, PS, RewardPkgCfg#reward_pkg.talents, LogInfo, Multiple),

                    % 给物品
                    RewardList = 
                    case RewardPkgCfg#reward_pkg.goods_rule of
                        0 ->
                            F = fun(RewardGoods) ->
                                case RewardGoods of
                                {ProbaMY,GetGoodsNo, GetGoodsCount, GetQuality, GetBindState} ->
                                    case util:decide_proba_once(ProbaMY) of
                                        fail ->
                                            #reward_dtl{};
                                        success ->
                                            case GetQuality =:= ?QUALITY_INVALID of
                                                true ->
                                                    give_reward_to_player__(goods, PS, {GetGoodsNo, GetGoodsCount, ?BIND_ALREADY}, LogInfo, Multiple);
                                                false ->
                                                    give_reward_to_player__(goods, PS, {GetGoodsNo, GetGoodsCount, GetQuality, ?BIND_ALREADY}, LogInfo, Multiple)
                                            end
                                    end;

                                {ProbaMY,GetGoodsNo, GetGoodsCount, GetQuality, GetBindState,NeedBroadcast} ->
                                    case util:decide_proba_once(ProbaMY) of
                                        fail ->
                                            #reward_dtl{};
                                        success ->
                                            case GetQuality =:= ?QUALITY_INVALID of
                                                true ->
                                                    ?DEBUG_MSG("NeedBroadcast=~p",[NeedBroadcast]),
                                                    give_reward_to_player__(goods, PS, {need_broadcast,GetGoodsNo, GetGoodsCount, ?BIND_ALREADY,NeedBroadcast}, LogInfo, Multiple);
                                                false ->
                                                    give_reward_to_player__(goods, PS, {need_broadcast,GetGoodsNo, GetGoodsCount, GetQuality, ?BIND_ALREADY,NeedBroadcast}, LogInfo, Multiple)
                                            end
                                    end;
                                    
                                _ ->
                                    give_reward_to_player__(goods, PS, RewardGoods, LogInfo, Multiple)
                                end
                            end,
                            RewardGoodsList = RewardPkgCfg#reward_pkg.goods_list,
                            lists:map(F, RewardGoodsList);
                        Other -> %% 按概率抽取一个物品
                          case Other > random:uniform() of
                            true ->
                              case decide_goods_by_prob(RewardPkgCfg#reward_pkg.goods_list) of
                                null ->
                                  ?ERROR_MSG("lib_reward:give_reward_to_player error!RewardPkgNo:~p, goods_list:~w~n", [RewardPkgNo, RewardPkgCfg#reward_pkg.goods_list]),
                                  case RewardPkgCfg#reward_pkg.goods_list =:= [] of
                                    true -> #reward_dtl{};
                                    false ->
                                      case erlang:hd(RewardPkgCfg#reward_pkg.goods_list) of
                                        {_TProba, TGoodsNo, TGoodsCount, TBindState} ->
                                          [give_reward_to_player__(goods, PS, {TGoodsNo, TGoodsCount, ?BIND_ALREADY}, LogInfo, Multiple)];
                                        {_TProba, TGoodsNo, TGoodsCount, TQuality, TBindState} ->
                                          [give_reward_to_player__(goods, PS, {TGoodsNo, TGoodsCount, TQuality, ?BIND_ALREADY}, LogInfo, Multiple)]
                                      end
                                  end;
                                {GetGoodsNo, GetGoodsCount, GetQuality, GetBindState} ->
                                  case GetQuality =:= ?QUALITY_INVALID of
                                    true ->
                                      [give_reward_to_player__(goods, PS, {GetGoodsNo, GetGoodsCount, ?BIND_ALREADY}, LogInfo, Multiple)];
                                    false ->
                                      [give_reward_to_player__(goods, PS, {GetGoodsNo, GetGoodsCount, GetQuality, ?BIND_ALREADY}, LogInfo, Multiple)]
                                  end;

                                {GetGoodsNo, GetGoodsCount, GetQuality, GetBindState,NeedBroadcast} ->
                                  case GetQuality =:= ?QUALITY_INVALID of
                                    true ->
                                      ?DEBUG_MSG("NeedBroadcast=~p",[NeedBroadcast]),

                                      [give_reward_to_player__(goods, PS, {need_broadcast,GetGoodsNo, GetGoodsCount, ?BIND_ALREADY,NeedBroadcast}, LogInfo, Multiple)];
                                    false ->
                                      [give_reward_to_player__(goods, PS, {need_broadcast,GetGoodsNo, GetGoodsCount, GetQuality, ?BIND_ALREADY,NeedBroadcast}, LogInfo, Multiple)]
                                  end
                              end;
                            false ->
                                []
                          end
                            % ?ASSERT(dbg_is_valid_goods_list(RewardPkgCfg#reward_pkg.goods_list), {RewardPkgNo, RewardPkgCfg#reward_pkg.goods_list}),

                    end,
                    
                    ?TRACE("lib_reward:give_reward_to_player:~p~n", [RewardList]),

                    %% 处理按种族性别的不同给予不同 物品
                    Reward4 = give_reward_to_player__(goods, PS, RewardPkgCfg, LogInfo, Multiple),

                    %% 给帮派成员贡献度
                    Reward5 = give_reward_to_player__(contribute, PS, RewardPkgCfg#reward_pkg.contribute, LogInfo, Multiple),

                    Reward6 = give_reward_to_player__(vip_exp, PS, RewardPkgCfg#reward_pkg.vip_exp, LogInfo, Multiple),

                    Reward7 = give_extra_reward_to_player(RewardPkgCfg#reward_pkg.extra_reward, PS, LogInfo, Multiple),

                    Reward8 = give_reward_to_player__(sys_activity_times, PS, RewardPkgCfg#reward_pkg.sys_activity_times, LogInfo, Multiple),

                    RewardList1 = RewardList ++ RewardMoneyList ++ [Reward2] ++ [Reward3] ++ [Reward4] ++ [Reward5] ++ [Reward6] ++ [Reward7] ++ [Reward8],
                    lib_event:event(?GET_ASSIGN_REWARD, [RewardPkgNo], PS),
                    mod_achievement:notify_achi(get_reward, [{no, RewardPkgNo}], PS),
                    
                    sum_reward(RewardList1)
            end

        end;

% -------------------------
give_reward_to_player(task, PS, RewardPkgNo, [TaskNo, Ring, Time, Round], LogInfo) ->
    give_reward_to_player(task, PS, RewardPkgNo, [TaskNo, Ring, Time, Round], LogInfo, 1).

give_reward_to_player(task, PS, RewardPkgNo, [TaskNo, Ring, Time], LogInfo, Multiple) ->
    give_reward_to_player(task, PS, RewardPkgNo, [TaskNo, Ring, Time, 1], LogInfo, Multiple);

give_reward_to_player(task, PS, RewardPkgNo, [TaskNo, Ring, Time, Round], LogInfo, Multiple) ->
    TaskDifficultyCoef = lib_task:get_task_hard_lv(TaskNo),
    RewardPkgCfg = get_reward_pkg_cfg_data(RewardPkgNo),
    PlyVipLv = player:get_vip_lv(PS),

    ExtraTimes =
        case (data_task:get(TaskNo))#task.type of
            ?TASK_SANJIE_TYPE ->
                data_vip_welfare:get(sanjieyishi_extra_time, PlyVipLv);
            ?TASK_GOSHT_TYPE ->
                data_vip_welfare:get(daily_catch_ghost_time, PlyVipLv);
            _ ->
                0
        end,

    ?DEBUG_MSG("(~p)(~p)(~p)",[
        (lib_task:get_max_reward_round(TaskNo) =:= 0 orelse (lib_task:get_max_reward_round(TaskNo) + ExtraTimes) =< Round)
        ,lib_task:get_max_reward_round(TaskNo)
        ,Round
        ]),
    case data_reward_con:get(RewardPkgNo) of
        null ->
            case (lib_task:get_max_reward_round(TaskNo) =:= 0 orelse (lib_task:get_max_reward_round(TaskNo) + ExtraTimes) >= Round) of
                true ->
                    %% 根据特定条件给予额外奖励
                    RewardExtra = give_extra_reward_to_player(RewardPkgCfg#reward_pkg.extra_reward, PS, [{ring, Ring}, {round, Round}], LogInfo, Multiple),
                    
                    %% 添加物品等其他东西
                    Reward = give_reward_to_player(PS, RewardPkgNo, LogInfo, Multiple),
                    
                    Reward#reward_dtl{goods_list = Reward#reward_dtl.goods_list ++ RewardExtra#reward_dtl.goods_list};
                false ->
                    % 增加任务没奖励提示
                    ply_tips:send_sys_tips(PS, {task_max_limit, [lib_task:get_task_type(TaskNo)]}),
                    #reward_dtl{}
            end;
        RewardCon ->
            case (lib_task:get_max_reward_round(TaskNo) == 0 orelse (lib_task:get_max_reward_round(TaskNo) + ExtraTimes) >= Round) of

                true ->
                    ?ASSERT(length(RewardCon#reward_con.coef_a) == 5), %% 常量配置表里有四个五维的列表
                    ?ASSERT(length(RewardCon#reward_con.coef_b) == 5),
                    ?ASSERT(length(RewardCon#reward_con.constant_c) == 5),
                    ?ASSERT(length(RewardCon#reward_con.ring_add_coef) == 5),
                    ?ASSERT(length(RewardCon#reward_con.round_add) =:= 5),
                    ?ASSERT(length(RewardCon#reward_con.round_add_coef) =:= 5),
                    ?ASSERT(length(RewardCon#reward_con.round_dec_coef) =:= 5),

                    {Type1, Lv1} = get_lv(task, 1, PS, RewardPkgNo, TaskNo),
                    {Type2, Lv2} = get_lv(task, 2, PS, RewardPkgNo, TaskNo),
                    {Type3, Lv3} = get_lv(task, 3, PS, RewardPkgNo, TaskNo),
                    
                    Lv = 
                    if 
                        Type1 =:= ?LV_TEAM_AVE -> Lv1;
                        Type2 =:= ?LV_TEAM_AVE -> Lv2;
                        Type3 =:= ?LV_TEAM_AVE -> Lv3;
                        true -> player:get_lv(PS) % 其他时候等级差默认是0
                    end,
                    
                    % 世界等级系数
                    LvDelTaCoef = get_lv_delta_coef(abs(player:get_lv(PS) - Lv)),
                    F = fun(Index, _Res) ->

                        % 轮次系数
                        RoundCoef = 
                            case (lists:nth(Index, RewardCon#reward_con.round_add)) >= Round of
                                true -> 
                                    % 初始轮次 - ((轮次-1) * 递减)
                                    erlang:max(0,lists:nth(Index, RewardCon#reward_con.round_add_coef)) ;
                                false ->
                                    lists:nth(Index, RewardCon#reward_con.round_dec_coef)
                            end,
                        
                        BaseValue = 
                            lists:nth(Index, RewardCon#reward_con.coef_a) * Lv1 * Lv2 + 
                            lists:nth(Index, RewardCon#reward_con.coef_b) * Lv3 + 
                            lists:nth(Index, RewardCon#reward_con.constant_c)  ,

                        RingCoef = (lists:nth(Index, RewardCon#reward_con.ring_add_coef) * Ring + 1),

                        % 基础经验值 * 环增加 * 难度系数 * 世界等级系数 * 轮次系数
                        Ret = ( BaseValue * RingCoef * TaskDifficultyCoef * LvDelTaCoef) * RoundCoef,

                        ?DEBUG_MSG("Ret = ~p, RoundCoef = ~p ~n",[Ret,RoundCoef]),

                        Ret
                    end,

                    TempExpAdd = lists:foldl(F, 0, lists:seq(1, 1)),
                    TempGMoneyAdd = lists:foldl(F, 0, lists:seq(2, 2)),
                    TempYBAdd = lists:foldl(F, 0, lists:seq(3, 3)), 
                    TempBindGmoneyAdd = lists:foldl(F, 0, lists:seq(4, 4)), 
                    TempBindYBAdd = lists:foldl(F, 0, lists:seq(5, 5)), 

                    % 计算经验值加成
                    ExpToAdd = may_get_team_leader_weal(PS, TempExpAdd) * RewardCon#reward_con.player_coef,
                    ExpToAdd1 = 
                        if 
                            RewardCon#reward_con.buff =:= [] -> ExpToAdd;
                            true ->
                                case lists:nth(1, RewardCon#reward_con.buff) of
                                    0 -> ExpToAdd;
                                    1 -> 
                                        case mod_buff:has_buff(player, player:id(PS), ?BFN_ADD_EXP) of
                                            false -> ExpToAdd;
                                            true ->
                                                case mod_buff:get_buff_state_by_name(player, player:id(PS), ?BFN_ADD_EXP) of
                                                    0 -> ExpToAdd;
                                                    1 ->
                                                        BuffPara = mod_buff:get_buff_para_by_name(player, player:id(PS), ?BFN_ADD_EXP),
                                                        ?ASSERT(BuffPara =/= null andalso is_integer(BuffPara)),
                                                        ExpToAdd * BuffPara
                                                end
                                        end
                                end
                        end,  
                    
                    GMoneyAdd = util:ceil(TempGMoneyAdd)*Multiple,
                    YBAdd = util:ceil(TempYBAdd)*Multiple, 
                    Vitality = util:ceil(TempBindGmoneyAdd)*Multiple, 
                    Copper = util:ceil(TempBindYBAdd)*Multiple,

                    ?DEBUG_MSG("GMoneyAdd=~p,YBAdd=~p,Vitality=~p,Copper=~p",[GMoneyAdd,YBAdd,Vitality,Copper]),

                    GoodsL1 = 
                    case ExpToAdd1 > 0 of
                        false -> [];
                        true -> 
                            player:add_exp(PS, ExpToAdd1*Multiple, LogInfo),
                            [{?INVALID_ID, ?VGOODS_EXP, ExpToAdd1*Multiple}]
                    end,
                    GoodsL2 = 
                    case GMoneyAdd > 0 of
                        false -> [];
                        true ->
                            player:add_money(PS, ?MNY_T_GAMEMONEY, GMoneyAdd, LogInfo),
                            [{?INVALID_ID, ?VGOODS_GAMEMONEY, GMoneyAdd}]
                    end,
                    GoodsL3 = 
                    case YBAdd > 0 of
                        false -> [];
                        true ->
                            player:add_money(PS, ?MNY_T_YUANBAO, YBAdd, LogInfo),
                            [{?INVALID_ID, ?VGOODS_YB, YBAdd}]
                    end,
                    GoodsL4 = 
                    case Vitality > 0 of
                        false -> [];
                        true ->
                            player:add_money(PS, ?MNY_T_VITALITY, Vitality, LogInfo),
                            [{?INVALID_ID, ?VGOODS_VITALITY, Vitality}]
                    end,
                    GoodsL5 = 
                    case Copper > 0 of
                        false -> [];
                        true ->
                            player:add_money(PS, ?MNY_T_COPPER, Copper, LogInfo),
                            [{?INVALID_ID, ?VGOODS_COPPER, Copper}]
                    end,

                    %% 宠物经验奖励计算
                    Fpar = fun(PartnerId, Acc) ->
                        case lib_partner:get_partner(PartnerId) of
                            null -> Acc;
                            Partner ->
                                case lib_partner:is_fighting(Partner) of
                                    false -> Acc;
                                    true ->
                                        LvPar = 
                                            if 
                                                Type1 =:= ?LV_TASK -> Lv1;
                                                Type2 =:= ?LV_TASK -> Lv2;
                                                Type3 =:= ?LV_TASK -> Lv3;
                                                true -> lib_partner:get_lv(Partner) % 其他时候等级差默认是0
                                            end,
                                        LvDelTaCoefPar = get_lv_delta_coef(abs(lib_partner:get_lv(Partner) - LvPar)),

                                        F1 = fun(Index, _Res) ->
                                            % 轮次系数
                                            RoundCoef =
                                                case (lists:nth(Index, RewardCon#reward_con.round_add)) >= Round of
                                                    true ->
                                                        % 初始轮次 - ((轮次-1) * 递减)
                                                        erlang:max(0,lists:nth(Index, RewardCon#reward_con.round_add_coef)) ;
                                                    false ->
                                                        lists:nth(Index, RewardCon#reward_con.round_dec_coef)
                                                end,
                                            
                                            BaseValue = 
                                                lists:nth(Index, RewardCon#reward_con.coef_a) * Lv1 * Lv2 + 
                                                lists:nth(Index, RewardCon#reward_con.coef_b) * Lv3 + 
                                                lists:nth(Index, RewardCon#reward_con.constant_c)  ,

                                            RingCoef = (lists:nth(Index, RewardCon#reward_con.ring_add_coef) * Ring + 1),

                                            % 基础经验值 * 环增加 * 难度系数 * 世界等级系数 * 轮次系数
                                            Ret = ( BaseValue * RingCoef * TaskDifficultyCoef * LvDelTaCoef) * RoundCoef,

                                            ?DEBUG_MSG("Ret = ~p, RoundCoef = ~p ~n",[Ret,RoundCoef]),
                                            Ret
                                        end,
                                        
                                        TempExpAddPar = 
                                            RewardCon#reward_con.par_coef *
                                            case lib_partner:is_main_partner(Partner) of
                                                true -> (lists:foldl(F1, 0, lists:seq(1, 1)));
                                                false -> (lists:foldl(F1, 0, lists:seq(1, 1))) * RewardPkgCfg#reward_pkg.ratio_of_par_get / 100
                                            end,
                                        ExpAddPar = util:ceil(TempExpAddPar)*Multiple,
                                        
                                        case ExpAddPar > 0 of
                                            true -> 
                                                lib_partner:add_exp(Partner, ExpAddPar, PS, LogInfo),
                                                Acc + ExpToAdd;
                                            false -> Acc
                                        end
                                end
                        end
                    end,
                    
                    TotalParExp = lists:foldl(Fpar, 0, player:get_partner_id_list(PS)),
                    GoodsLPar = [{?INVALID_ID, ?VGOODS_PAR_EXP, TotalParExp}],


                    %% 添加10次抓鬼活动奖励
                    Type = (data_task:get(TaskNo))#task.type,
                    case Ring =:= ?TASK_TIMES andalso (Type =:= 4 orelse Type =:= 6) of
                        true ->
                            erlang:put(?TASK_REWARD, true),
                            {ok, BinData} = pt_30:write(?PT_IS_CAN_GET_REWARD_BY_TIMES, [0]),
                            lib_send:send_to_sock(PS, BinData);
                        false ->
                            skip
%%                            lib_send:send_prompt_msg(PS, ?PM_TM_ZF_NOT_USABLE)
                    end,

                    %% 根据特定条件给予额外奖励
                    RewardExtra = give_extra_reward_to_player(RewardPkgCfg#reward_pkg.extra_reward, PS, [{ring, Ring}, {round, Round}], LogInfo, Multiple),
                    
                    %% 添加物品等其他东西
                    Reward = give_reward_to_player(PS, RewardPkgNo, LogInfo, Multiple),
                    
                    Reward#reward_dtl{goods_list = Reward#reward_dtl.goods_list ++ GoodsL1 ++ GoodsL2 ++ GoodsL3 ++ GoodsL4 ++ GoodsL5 ++ RewardExtra#reward_dtl.goods_list ++ GoodsLPar};

                false -> 
                    % 增加任务没奖励提示
                    % lib_send:send_prompt_msg(Status, ?PM_ACTIVITY_ANSWER_NOT_OPEN);
                    ply_tips:send_sys_tips(PS, {task_max_limit, [lib_task:get_task_type(TaskNo)]}),

                    #reward_dtl{} 
            end
    end;


%% Floor 所在层数
%% BattlePower --> 推荐战力
give_reward_to_player(tower, PS, RewardPkgNo, [Floor, BattlePower], LogInfo, Multiple) ->
    case data_reward_con:get(RewardPkgNo) of
        null ->
            %% 添加物品等其他东西
            give_reward_to_player(PS, RewardPkgNo, LogInfo, Multiple);
        RewardCon ->
            ?ASSERT(length(RewardCon#reward_con.coef_a) == 5), %% 常量配置表里有四个五维的列表
            ?ASSERT(length(RewardCon#reward_con.coef_b) == 5),
            ?ASSERT(length(RewardCon#reward_con.constant_c) == 5),
            ?ASSERT(length(RewardCon#reward_con.ring_add_coef) == 5),
            ?ASSERT(length(RewardCon#reward_con.round_add) =:= 5),
            ?ASSERT(length(RewardCon#reward_con.round_add_coef) =:= 5),
            ?ASSERT(length(RewardCon#reward_con.round_dec_coef) =:= 5),

            {Type1, Lv1Use} = get_lv(tower, 1, PS, RewardPkgNo),
            {Type2, Lv2Use} = get_lv(tower, 2, PS, RewardPkgNo),
            {Type3, Lv3Use} = get_lv(tower, 3, PS, RewardPkgNo),

            Lv1 = 
                case Type1 of
                    ?VALUE_TOWER_FLOOR -> Floor;
                    ?VALUE_RECOMMEND_BATTLE_POWER -> BattlePower / ply_attr:get_battle_power(PS);
                    ?VALUE_DEFAULT -> Lv1Use;
                    ?LV_PLAYER -> player:get_lv(PS);
                    _Any1 -> ?ASSERT(false, Type1)
                end,

            Lv2 = 
                case Type2 of
                    ?VALUE_TOWER_FLOOR -> Floor;
                    ?VALUE_RECOMMEND_BATTLE_POWER -> BattlePower / ply_attr:get_battle_power(PS);
                    ?VALUE_DEFAULT -> Lv2Use;
                    ?LV_PLAYER -> player:get_lv(PS);
                    _Any2 -> ?ASSERT(false, Type2)
                end,

            Lv3 = 
                case Type3 of
                    ?VALUE_TOWER_FLOOR -> Floor;
                    ?VALUE_RECOMMEND_BATTLE_POWER -> BattlePower / ply_attr:get_battle_power(PS);
                    ?VALUE_DEFAULT -> Lv3Use;
                    ?LV_PLAYER -> player:get_lv(PS);
                    _Any3 -> ?ASSERT(false, Type3)
                end,

            %% 计算等级差
            Lv = 
            if 
                Type1 =:= ?LV_TEAM_AVE -> Floor;
                Type2 =:= ?LV_TEAM_AVE -> BattlePower;
                Type3 =:= ?LV_TEAM_AVE -> Lv3Use;
                true -> player:get_lv(PS) % 其他时候等级差默认是0
            end,

            LvDelTaCoef = get_lv_delta_coef(abs(player:get_lv(PS) - Lv)),

            F = fun(Index, _Res) ->
                RoundCoef = 1,
                
                BaseValue = 
                    lists:nth(Index, RewardCon#reward_con.coef_a) * Lv1 * Lv2 + 
                    lists:nth(Index, RewardCon#reward_con.coef_b) * Lv3 + 
                    lists:nth(Index, RewardCon#reward_con.constant_c)  ,

                RingCoef = 1,

                % 基础经验值 * 环增加 * 难度系数 * 世界等级系数 * 轮次系数
                Ret = ( BaseValue * RingCoef * LvDelTaCoef) * RoundCoef,

                Ret
            end,

            TempExpAdd = lists:foldl(F, 0, lists:seq(1, 1)),
            TempGMoneyAdd = lists:foldl(F, 0, lists:seq(2, 2)),
            TempYBAdd = lists:foldl(F, 0, lists:seq(3, 3)), 
            TempBindGmoneyAdd = lists:foldl(F, 0, lists:seq(4, 4)), 
            TempBindYBAdd = lists:foldl(F, 0, lists:seq(5, 5)), 

            ExpToAdd = may_get_team_leader_weal(PS, TempExpAdd) * RewardCon#reward_con.player_coef,
            ExpToAdd1 = 
                if 
                    RewardCon#reward_con.buff =:= [] -> ExpToAdd;
                    true ->
                        case lists:nth(1, RewardCon#reward_con.buff) of
                            0 -> ExpToAdd*Multiple;
                            1 -> 
                                case mod_buff:has_buff(player, player:id(PS), add_exp) of
                                    false -> ExpToAdd*Multiple;
                                    true ->
                                        BuffPara = mod_buff:get_buff_para_by_name(player, player:id(PS), add_exp),
                                        ?ASSERT(BuffPara =/= null andalso is_integer(BuffPara)),
                                        ExpToAdd * BuffPara*Multiple
                                end
                        end
                end,

            GMoneyAdd = util:ceil(TempGMoneyAdd)*Multiple,
            YBAdd = util:ceil(TempYBAdd)*Multiple, 
            Vitality = util:ceil(TempBindGmoneyAdd)*Multiple, 
            Copper = util:ceil(TempBindYBAdd)*Multiple,

            GoodsL1 = 
            case ExpToAdd1 > 0 of
                false -> [];
                true -> 
                    player:add_exp(PS, ExpToAdd1, LogInfo),
                    [{?INVALID_ID, ?VGOODS_EXP, ExpToAdd1}]
            end,
            GoodsL2 = 
            case GMoneyAdd > 0 of
                false -> [];
                true ->
                    player:add_money(PS, ?MNY_T_GAMEMONEY, GMoneyAdd, LogInfo),
                    [{?INVALID_ID, ?VGOODS_GAMEMONEY, GMoneyAdd}]
            end,
            GoodsL3 = 
            case YBAdd > 0 of
                false -> [];
                true ->
                    player:add_money(PS, ?MNY_T_YUANBAO, YBAdd, LogInfo),
                    [{?INVALID_ID, ?VGOODS_YB, YBAdd}]
            end,

            GoodsL4 = 
            case Vitality > 0 of
                false -> [];
                true ->
                    player:add_money(PS, ?MNY_T_VITALITY, Vitality, LogInfo),
                    [{?INVALID_ID, ?VGOODS_VITALITY, Vitality}]
            end,
            GoodsL5 = 
            case Copper > 0 of
                false -> [];
                true ->
                    player:add_money(PS, ?MNY_T_COPPER, Copper, LogInfo),
                    [{?INVALID_ID, ?VGOODS_COPPER, Copper}]
            end,

            ExpToParAdd = may_get_team_leader_weal(PS, TempExpAdd),
            %% 宠物经验奖励计算
            Fpar = fun(PartnerId, Acc) ->
                case lib_partner:get_partner(PartnerId) of
                    null -> Acc;
                    Partner ->
                        case lib_partner:is_fighting(Partner) of
                            false -> Acc;
                            true ->
                                % LvPar = 
                                %     if 
                                %         Type1 =:= ?LV_TASK -> Lv1;
                                %         Type2 =:= ?LV_TASK -> Lv2;
                                %         Type3 =:= ?LV_TASK -> Lv3;
                                %         true -> lib_partner:get_lv(Partner) % 其他时候等级差默认是0
                                %     end,
                                % LvDelTaCoefPar = get_lv_delta_coef(abs(lib_partner:get_lv(Partner) - LvPar)),
                                % F1 = fun(Index, _Res) ->
                                %     RoundCoef = 1,
                                %     ( lists:nth(Index, RewardCon#reward_con.coef_a) * Lv1 * Lv2 + lists:nth(Index, RewardCon#reward_con.coef_b) * Lv3 + 
                                %         lists:nth(Index, RewardCon#reward_con.constant_c) ) * 
                                %             1 * (lists:nth(Index, RewardCon#reward_con.ring_add_coef) * 1 + 1) * 
                                %             LvDelTaCoefPar * (RewardCon#reward_con.coef_time * 1 + 1) * RoundCoef
                                % end,
                                RewardPkgCfg = get_reward_pkg_cfg_data(RewardPkgNo),
                                TempExpAddPar = 
                                    RewardCon#reward_con.par_coef *
                                    case lib_partner:is_main_partner(Partner) of
                                        true -> ExpToParAdd; % (lists:foldl(F1, 0, lists:seq(1, 1)));
                                        false -> ExpToParAdd * RewardPkgCfg#reward_pkg.ratio_of_par_get / 100
                                    end,
                                ExpAddPar = util:ceil(TempExpAddPar)*Multiple,

                                ?DEBUG_MSG("TempExpAddPar=~p,RewardCon#reward_con.par_coef =~p",[TempExpAddPar,RewardCon#reward_con.par_coef]),
                                case ExpAddPar > 0 of
                                    true -> 
                                        lib_partner:add_exp(Partner, ExpAddPar, PS, LogInfo),
                                        Acc + ExpAddPar;
                                    false -> Acc
                                end
                        end
                end
            end,
            TotalParExp = lists:foldl(Fpar, 0, player:get_partner_id_list(PS)),
            GoodsLPar = [{?INVALID_ID, ?VGOODS_PAR_EXP, TotalParExp}],
            %% 添加物品等其他东西
            Reward = give_reward_to_player(PS, RewardPkgNo, LogInfo, Multiple),
            Reward#reward_dtl{goods_list = Reward#reward_dtl.goods_list ++ GoodsL1 ++ GoodsL2 ++ GoodsL3 ++ GoodsL4 ++ GoodsL5 ++ GoodsLPar}
    end;

%% 用于帮派副本奖励 等 引用等级全部是玩家等级情况下奖励的发放
give_reward_to_player(common, PS, RewardPkgNo, [], LogInfo, Multiple) ->
    case data_reward_con:get(RewardPkgNo) of
        null ->
            give_reward_to_player(PS, RewardPkgNo, LogInfo, Multiple);
        RewardCon ->
            ?ASSERT(length(RewardCon#reward_con.coef_a) == 5), %% 常量配置表里有四个五维的列表
            ?ASSERT(length(RewardCon#reward_con.coef_b) == 5),
            ?ASSERT(length(RewardCon#reward_con.constant_c) == 5),
            ?ASSERT(length(RewardCon#reward_con.ring_add_coef) == 5),
            ?ASSERT(length(RewardCon#reward_con.round_add) =:= 5),
            ?ASSERT(length(RewardCon#reward_con.round_add_coef) =:= 5),
            ?ASSERT(length(RewardCon#reward_con.round_dec_coef) =:= 5),

            {_Type1, Lv1Use} = get_lv(1, PS, RewardPkgNo),
            {_Type2, Lv2Use} = get_lv(2, PS, RewardPkgNo),
            {_Type3, Lv3Use} = get_lv(3, PS, RewardPkgNo),

            Lv1 = Lv1Use,
            Lv2 = Lv2Use,
            Lv3 = Lv3Use,

            LvDelTaCoef = get_lv_delta_coef(0),

            F = fun(Index, _Res) ->
                RoundCoef = 1,
                ( lists:nth(Index, RewardCon#reward_con.coef_a) * Lv1 * Lv2 + lists:nth(Index, RewardCon#reward_con.coef_b) * Lv3 + 
                    lists:nth(Index, RewardCon#reward_con.constant_c) ) * 
                        1 * (lists:nth(Index, RewardCon#reward_con.ring_add_coef) * 1 + 1) * 
                        LvDelTaCoef * (RewardCon#reward_con.coef_time * 1 + 1) * RoundCoef
            end,

            TempExpAdd = lists:foldl(F, 0, lists:seq(1, 1)),
            TempGMoneyAdd = lists:foldl(F, 0, lists:seq(2, 2)),
            TempYBAdd = lists:foldl(F, 0, lists:seq(3, 3)), 
            TempBindGmoneyAdd = lists:foldl(F, 0, lists:seq(4, 4)), 
            TempBindYBAdd = lists:foldl(F, 0, lists:seq(5, 5)), 

            ExpToAdd = may_get_team_leader_weal(PS, TempExpAdd) * RewardCon#reward_con.player_coef,
            ExpToAdd1 = 
                if 
                    RewardCon#reward_con.buff =:= [] -> ExpToAdd;
                    true ->
                        case lists:nth(1, RewardCon#reward_con.buff) of
                            0 -> ExpToAdd*Multiple;
                            1 -> 
                                case mod_buff:has_buff(player, player:id(PS), add_exp) of
                                    false -> ExpToAdd*Multiple;
                                    true ->
                                        BuffPara = mod_buff:get_buff_para_by_name(player, player:id(PS), add_exp),
                                        ?ASSERT(BuffPara =/= null andalso is_integer(BuffPara)),
                                        ExpToAdd * BuffPara * Multiple
                                end
                        end
                end,    
                
            GMoneyAdd = util:ceil(TempGMoneyAdd)*Multiple,
            YBAdd = util:ceil(TempYBAdd)*Multiple, 
            Vitality = util:ceil(TempBindGmoneyAdd)*Multiple, 
            Copper = util:ceil(TempBindYBAdd)*Multiple,

            GoodsL1 = 
            case ExpToAdd1 > 0 of
                false -> [];
                true -> 
                    player:add_exp(PS, ExpToAdd1, LogInfo),
                    [{?INVALID_ID, ?VGOODS_EXP, ExpToAdd1}]
            end,
            GoodsL2 = 
            case GMoneyAdd > 0 of
                false -> [];
                true ->
                    player:add_money(PS, ?MNY_T_GAMEMONEY, GMoneyAdd, LogInfo),
                    [{?INVALID_ID, ?VGOODS_GAMEMONEY, GMoneyAdd}]
            end,
            GoodsL3 = 
            case YBAdd > 0 of
                false -> [];
                true ->
                    player:add_money(PS, ?MNY_T_YUANBAO, YBAdd, LogInfo),
                    [{?INVALID_ID, ?VGOODS_YB, YBAdd}]
            end,
            
            GoodsL4 = 
            case Vitality > 0 of
                false -> [];
                true ->
                    player:add_money(PS, ?MNY_T_VITALITY, Vitality, LogInfo),
                    [{?INVALID_ID, ?VGOODS_VITALITY, Vitality}]
            end,
            GoodsL5 = 
            case Copper > 0 of
                false -> [];
                true ->
                    player:add_money(PS, ?MNY_T_COPPER, Copper, LogInfo),
                    [{?INVALID_ID, ?VGOODS_COPPER, Copper}]
            end,

            %% 宠物经验奖励计算
            Fpar = fun(PartnerId, Acc) ->
                case lib_partner:get_partner(PartnerId) of
                    null -> Acc;
                    Partner ->
                        case lib_partner:is_fighting(Partner) of
                            false -> Acc;
                            true ->
                                LvDelTaCoefPar = get_lv_delta_coef(0),
                                F1 = fun(Index, _Res) ->
                                    RoundCoef = 1,
                                    ( lists:nth(Index, RewardCon#reward_con.coef_a) * Lv1 * Lv2 + lists:nth(Index, RewardCon#reward_con.coef_b) * Lv3 + 
                                        lists:nth(Index, RewardCon#reward_con.constant_c) ) * 
                                            1 * (lists:nth(Index, RewardCon#reward_con.ring_add_coef) * 1 + 1) * 
                                            LvDelTaCoefPar * (RewardCon#reward_con.coef_time * 1 + 1) * RoundCoef
                                end,
                                RewardPkgCfg = get_reward_pkg_cfg_data(RewardPkgNo),
                                TempExpAddPar = 
                                    RewardCon#reward_con.par_coef * 
                                    case lib_partner:is_main_partner(Partner) of
                                        true -> (lists:foldl(F1, 0, lists:seq(1, 1)));
                                        false -> (lists:foldl(F1, 0, lists:seq(1, 1))) * RewardPkgCfg#reward_pkg.ratio_of_par_get / 100
                                    end,
                                ExpAddPar = util:ceil(TempExpAddPar)*Multiple,
                                
                                case ExpAddPar > 0 of
                                    true -> 
                                        lib_partner:add_exp(Partner, ExpAddPar, PS, LogInfo),
                                        Acc + ExpAddPar;
                                    false -> Acc
                                end
                        end
                end
            end,
            TotalParExp = lists:foldl(Fpar, 0, player:get_partner_id_list(PS)),
            GoodsLPar = [{?INVALID_ID, ?VGOODS_PAR_EXP, TotalParExp}],
            %% 添加物品等其他东西
            Reward = give_reward_to_player(PS, RewardPkgNo, LogInfo, Multiple),
            Reward#reward_dtl{goods_list = Reward#reward_dtl.goods_list ++ GoodsL1 ++ GoodsL2 ++ GoodsL3 ++ GoodsL4 ++ GoodsL5 ++ GoodsLPar}
    end.


%% 给予玩家奖励（注意：给奖励前应该先调用check_bag_space()以检查玩家的背包空间是否够！）
%% @para: RewardPkgNo => 奖励包编号
%% @return: reward_dtl结构体
give_reward_to_player(PS, RewardPkgNo, LogInfo) ->
    give_reward_to_player(PS, RewardPkgNo, LogInfo, 1).

give_reward_to_player(PS, RewardPkgNo, LogInfo, Multiple) ->
    ?ASSERT(is_reward_pkg_valid(RewardPkgNo), RewardPkgNo),
    case get_reward_pkg_cfg_data(RewardPkgNo) of
        null -> 
            ?ERROR_MSG("lib_reward:give_reward_to_player error!PlayerId:~p,RewardPkgNo:~p,LogInfo:~w~n", [player:id(PS), RewardPkgNo, LogInfo]),
            #reward_dtl{};
        RewardPkgCfg ->
            % 给钱
            RewardMoneyList = give_reward_to_player__(money, PS, RewardPkgCfg#reward_pkg.money, LogInfo, Multiple),
            % 给经验
            Reward2 = give_reward_to_player__(exp, PS, RewardPkgCfg, LogInfo, Multiple),

            % 给天赋属性
            Reward3 = give_reward_to_player__(talents, PS, RewardPkgCfg#reward_pkg.talents, LogInfo, Multiple),

            % 给物品
            RewardList = 
            case RewardPkgCfg#reward_pkg.goods_rule of
                0 ->
                    F = fun(RewardGoods) ->
                        case RewardGoods of
                        {ProbaMY,GetGoodsNo, GetGoodsCount, GetQuality, GetBindState} ->
                            case util:decide_proba_once(ProbaMY) of
                                fail ->
                                    #reward_dtl{};
                                success ->
                                    case GetQuality =:= ?QUALITY_INVALID of
                                        true ->
                                            give_reward_to_player__(goods, PS, {GetGoodsNo, GetGoodsCount, GetBindState}, LogInfo, Multiple);
                                        false ->
                                            give_reward_to_player__(goods, PS, {GetGoodsNo, GetGoodsCount, GetQuality, GetBindState}, LogInfo, Multiple)
                                    end
                            end;

                        {ProbaMY,GetGoodsNo, GetGoodsCount, GetQuality, GetBindState,NeedBroadcast} ->
                            case util:decide_proba_once(ProbaMY) of
                                fail ->
                                    #reward_dtl{};
                                success ->
                                    case GetQuality =:= ?QUALITY_INVALID of
                                        true ->
                                            ?DEBUG_MSG("NeedBroadcast=~p",[NeedBroadcast]),
                                            give_reward_to_player__(goods, PS, {need_broadcast,GetGoodsNo, GetGoodsCount, GetBindState,NeedBroadcast}, LogInfo, Multiple);
                                        false ->
                                            give_reward_to_player__(goods, PS, {need_broadcast,GetGoodsNo, GetGoodsCount, GetQuality, GetBindState,NeedBroadcast}, LogInfo, Multiple)
                                    end
                            end;
                            
                        _ ->
                            give_reward_to_player__(goods, PS, RewardGoods, LogInfo, Multiple)
                        end
                    end,
                    RewardGoodsList = RewardPkgCfg#reward_pkg.goods_list,
                    lists:map(F, RewardGoodsList);
                Other -> %% 按概率抽取一个物品
                    % ?ASSERT(dbg_is_valid_goods_list(RewardPkgCfg#reward_pkg.goods_list), {RewardPkgNo, RewardPkgCfg#reward_pkg.goods_list}),
                   case Other > random:uniform() of
                       false -> [];
                       true ->
                           case decide_goods_by_prob(RewardPkgCfg#reward_pkg.goods_list) of
                               null ->
                                   ?ERROR_MSG("lib_reward:give_reward_to_player error!RewardPkgNo:~p, goods_list:~w~n", [RewardPkgNo, RewardPkgCfg#reward_pkg.goods_list]),
                                   case RewardPkgCfg#reward_pkg.goods_list =:= [] of
                                       true -> #reward_dtl{};
                                       false ->
                                           case erlang:hd(RewardPkgCfg#reward_pkg.goods_list) of
                                               {_TProba, TGoodsNo, TGoodsCount, TBindState} ->
                                                   [give_reward_to_player__(goods, PS, {TGoodsNo, TGoodsCount, TBindState}, LogInfo, Multiple)];
                                               {_TProba, TGoodsNo, TGoodsCount, TQuality, TBindState} ->
                                                   [give_reward_to_player__(goods, PS, {TGoodsNo, TGoodsCount, TQuality, TBindState}, LogInfo, Multiple)]
                                           end
                                   end;
                               {GetGoodsNo, GetGoodsCount, GetQuality, GetBindState} ->
                                   case GetQuality =:= ?QUALITY_INVALID of
                                       true ->
                                           [give_reward_to_player__(goods, PS, {GetGoodsNo, GetGoodsCount, GetBindState}, LogInfo, Multiple)];
                                       false ->
                                           [give_reward_to_player__(goods, PS, {GetGoodsNo, GetGoodsCount, GetQuality, GetBindState}, LogInfo, Multiple)]
                                   end;

                               {GetGoodsNo, GetGoodsCount, GetQuality, GetBindState,NeedBroadcast} ->
                                   case GetQuality =:= ?QUALITY_INVALID of
                                       true ->
                                           ?DEBUG_MSG("NeedBroadcast=~p",[NeedBroadcast]),

                                           [give_reward_to_player__(goods, PS, {need_broadcast,GetGoodsNo, GetGoodsCount, GetBindState,NeedBroadcast}, LogInfo, Multiple)];
                                       false ->
                                           [give_reward_to_player__(goods, PS, {need_broadcast,GetGoodsNo, GetGoodsCount, GetQuality, GetBindState,NeedBroadcast}, LogInfo, Multiple)]
                                   end
                           end
                   end

            end,
            
            ?TRACE("lib_reward:give_reward_to_player:~p~n", [RewardList]),

            %% 处理按种族性别的不同给予不同 物品
            Reward4 = give_reward_to_player__(goods, PS, RewardPkgCfg, LogInfo, Multiple),

            %% 给帮派成员贡献度
            Reward5 = give_reward_to_player__(contribute, PS, RewardPkgCfg#reward_pkg.contribute, LogInfo, Multiple),

            Reward6 = give_reward_to_player__(vip_exp, PS, RewardPkgCfg#reward_pkg.vip_exp, LogInfo, Multiple),

            Reward7 = give_extra_reward_to_player(RewardPkgCfg#reward_pkg.extra_reward, PS, LogInfo, Multiple),

            Reward8 = give_reward_to_player__(sys_activity_times, PS, RewardPkgCfg#reward_pkg.sys_activity_times, LogInfo, Multiple),

            RewardList1 = RewardList ++ RewardMoneyList ++ [Reward2] ++ [Reward3] ++ [Reward4] ++ [Reward5] ++ [Reward6] ++ [Reward7] ++ [Reward8],
            lib_event:event(?GET_ASSIGN_REWARD, [RewardPkgNo], PS),
            mod_achievement:notify_achi(get_reward, [{no, RewardPkgNo}], PS),
            
            sum_reward(RewardList1)
    end.
    
%% return reward_dtl 结构体，该结构体的calc_goods_list字段是奖励获得的物品列表
%% calc_goods_list 为：{GoodsNo, GoodsCount, Quality, BindState} 元组列表
calc_reward_to_player(PS_Or_PlayerId, RewardPkgNo) ->
    calc_reward_to_player(PS_Or_PlayerId, RewardPkgNo, 1).

calc_reward_to_player(PS_Or_PlayerId, RewardPkgNo,[dungeon,NewTime]) ->
    Multiple = 1,
    case NewTime > 3 of
        true ->
            calc_reward_to_player(PS_Or_PlayerId, RewardPkgNo, 1);
        false ->

            case get_reward_pkg_cfg_data(RewardPkgNo) of
                null -> #reward_dtl{};
                RewardPkgCfg ->
                    % 给钱
                    RewardMoneyList = calc_reward_to_player__(money, PS_Or_PlayerId, RewardPkgCfg#reward_pkg.money, Multiple),
                    ?TRACE("lib_reward:calc_reward_to_player Reward1:~p~n", [RewardMoneyList]),
                    % 给经验
                    Reward2 = calc_reward_to_player__(exp, PS_Or_PlayerId, RewardPkgCfg, Multiple),
                    ?TRACE("lib_reward:calc_reward_to_player Reward2:~p~n", [Reward2]),

                    % 给天赋属性
                    Reward3 = calc_reward_to_player__(talents, PS_Or_PlayerId, RewardPkgCfg#reward_pkg.talents, Multiple),
                    ?TRACE("lib_reward:calc_reward_to_player Reward3:~p~n", [Reward3]),

                    % 给物品
                    RewardList = 
                    case RewardPkgCfg#reward_pkg.goods_rule of
                        0 ->
                            F = fun(RewardGoods) ->
                                    RewardGoods_ = 
                                    case RewardGoods of
                                        {Proba, GoodsNo, GoodsCount, BindState} -> {Proba, GoodsNo, GoodsCount, ?BIND_ALREADY};
                                        {Proba, GoodsNo, GoodsCount, Quality, BindState} -> {Proba, GoodsNo, GoodsCount, Quality, ?BIND_ALREADY};
                                        {Proba, GoodsNo, GoodsCount, Quality, BindState,NeedBroadcast} -> {Proba, GoodsNo, GoodsCount, Quality, ?BIND_ALREADY,NeedBroadcast};
                                        _O -> _O
                                    end,

                                    calc_reward_to_player__(goods, PS_Or_PlayerId, RewardGoods_, Multiple)
                                end,

                            RewardGoodsList = RewardPkgCfg#reward_pkg.goods_list,
                            lists:map(F, RewardGoodsList);
                        Other -> %% 按概率抽取一个物品
                            % ?ASSERT(dbg_is_valid_goods_list(RewardPkgCfg#reward_pkg.goods_list), {RewardPkgNo, RewardPkgCfg#reward_pkg.goods_list}),
                            case Other > random:uniform() of
                                false ->
                                    [];
                                true ->
                                    case decide_goods_by_prob(RewardPkgCfg#reward_pkg.goods_list) of
                                        null ->
                                            ?ERROR_MSG("lib_reward:calc_reward_to_player error!RewardPkgNo:~p, goods_list:~w~n", [RewardPkgNo, RewardPkgCfg#reward_pkg.goods_list]),
                                            case RewardPkgCfg#reward_pkg.goods_list =:= [] of
                                                true -> [];
                                                false ->
                                                    case erlang:hd(RewardPkgCfg#reward_pkg.goods_list) of
                                                        {_TProba, TGoodsNo, TGoodsCount, TBindState} ->
                                                            [calc_reward_to_player__(goods, PS_Or_PlayerId, {TGoodsNo, TGoodsCount, ?BIND_ALREADY}, Multiple)];
                                                        {_TProba, TGoodsNo, TGoodsCount, TQuality, TBindState} ->
                                                            [calc_reward_to_player__(goods, PS_Or_PlayerId, {TGoodsNo, TGoodsCount, TQuality, ?BIND_ALREADY}, Multiple)]
                                                    end
                                            end;
                                        {GetGoodsNo, GetGoodsCount, GetQuality, GetBindState} ->
                                            case GetQuality =:= ?QUALITY_INVALID of
                                                true ->
                                                    [calc_reward_to_player__(goods, PS_Or_PlayerId, {GetGoodsNo, GetGoodsCount, ?BIND_ALREADY}, Multiple)];
                                                false ->
                                                    [calc_reward_to_player__(goods, PS_Or_PlayerId, {GetGoodsNo, GetGoodsCount, GetQuality, ?BIND_ALREADY}, Multiple)]
                                            end;
                                        {GetGoodsNo, GetGoodsCount, GetQuality, GetBindState,NeedBroadcast} ->
                                            case GetQuality =:= ?QUALITY_INVALID of
                                                true ->
                                                    [calc_reward_to_player__(goods, PS_Or_PlayerId, {need_broadcast,GetGoodsNo, GetGoodsCount, ?BIND_ALREADY,NeedBroadcast}, Multiple)];
                                                false ->
                                                    [calc_reward_to_player__(goods, PS_Or_PlayerId, {need_broadcast,GetGoodsNo, GetGoodsCount, GetQuality, ?BIND_ALREADY,NeedBroadcast}, Multiple)]
                                            end
                                    end
                            end
                    end,

                    ?TRACE("lib_reward:calc_reward_to_player:~p~n", [RewardList]),

                    %% 处理按种族性别的不同给予不同 物品
                    Reward4 = calc_reward_to_player__(goods, PS_Or_PlayerId, RewardPkgCfg, Multiple),

                    %% 给帮派成员贡献度
                    Reward5 = calc_reward_to_player__(contribute, PS_Or_PlayerId, RewardPkgCfg#reward_pkg.contribute, Multiple),

                    Reward6 = calc_reward_to_player__(vip_exp, PS_Or_PlayerId, RewardPkgCfg#reward_pkg.vip_exp, Multiple),

                    Reward7 = calc_extra_reward_to_player(RewardPkgCfg#reward_pkg.extra_reward, PS_Or_PlayerId, Multiple),

                    RewardList1 = RewardList ++ RewardMoneyList ++ [Reward2] ++ [Reward3] ++ [Reward4] ++ [Reward5] ++ [Reward6] ++ [Reward7],
                    
                    sum_reward(RewardList1)
            end
    end;

calc_reward_to_player(PS_Or_PlayerId, RewardPkgNo, Multiple) ->
    ?ASSERT(is_reward_pkg_valid(RewardPkgNo), RewardPkgNo),
    case get_reward_pkg_cfg_data(RewardPkgNo) of
        null -> #reward_dtl{};
        RewardPkgCfg ->
            % 给钱
            RewardMoneyList = calc_reward_to_player__(money, PS_Or_PlayerId, RewardPkgCfg#reward_pkg.money, Multiple),
            ?TRACE("lib_reward:calc_reward_to_player Reward1:~p~n", [RewardMoneyList]),
            % 给经验
            Reward2 = calc_reward_to_player__(exp, PS_Or_PlayerId, RewardPkgCfg, Multiple),
            ?TRACE("lib_reward:calc_reward_to_player Reward2:~p~n", [Reward2]),

            % 给天赋属性
            Reward3 = calc_reward_to_player__(talents, PS_Or_PlayerId, RewardPkgCfg#reward_pkg.talents, Multiple),
            ?TRACE("lib_reward:calc_reward_to_player Reward3:~p~n", [Reward3]),

            % 给物品
            RewardList = 
            case RewardPkgCfg#reward_pkg.goods_rule of
                0 ->
                    F = fun(RewardGoods) ->
                            calc_reward_to_player__(goods, PS_Or_PlayerId, RewardGoods, Multiple)
                        end,
                    RewardGoodsList = RewardPkgCfg#reward_pkg.goods_list,
                    lists:map(F, RewardGoodsList);
                Other -> %% 按概率抽取一个物品
                    % ?ASSERT(dbg_is_valid_goods_list(RewardPkgCfg#reward_pkg.goods_list), {RewardPkgNo, RewardPkgCfg#reward_pkg.goods_list}),
                   case Other > random:uniform() of
                       true ->
                           case decide_goods_by_prob(RewardPkgCfg#reward_pkg.goods_list) of
                               null ->
                                   ?ERROR_MSG("lib_reward:calc_reward_to_player error!RewardPkgNo:~p, goods_list:~w~n", [RewardPkgNo, RewardPkgCfg#reward_pkg.goods_list]),
                                   case RewardPkgCfg#reward_pkg.goods_list =:= [] of
                                       true -> [];
                                       false ->
                                           case erlang:hd(RewardPkgCfg#reward_pkg.goods_list) of
                                               {_TProba, TGoodsNo, TGoodsCount, TBindState} ->
                                                   [calc_reward_to_player__(goods, PS_Or_PlayerId, {TGoodsNo, TGoodsCount, TBindState}, Multiple)];
                                               {_TProba, TGoodsNo, TGoodsCount, TQuality, TBindState} ->
                                                   [calc_reward_to_player__(goods, PS_Or_PlayerId, {TGoodsNo, TGoodsCount, TQuality, TBindState}, Multiple)]
                                           end
                                   end;
                               {GetGoodsNo, GetGoodsCount, GetQuality, GetBindState} ->
                                   case GetQuality =:= ?QUALITY_INVALID of
                                       true ->
                                           [calc_reward_to_player__(goods, PS_Or_PlayerId, {GetGoodsNo, GetGoodsCount, GetBindState}, Multiple)];
                                       false ->
                                           [calc_reward_to_player__(goods, PS_Or_PlayerId, {GetGoodsNo, GetGoodsCount, GetQuality, GetBindState}, Multiple)]
                                   end;
                               {GetGoodsNo, GetGoodsCount, GetQuality, GetBindState,NeedBroadcast} ->
                                   case GetQuality =:= ?QUALITY_INVALID of
                                       true ->
                                           [calc_reward_to_player__(goods, PS_Or_PlayerId, {need_broadcast,GetGoodsNo, GetGoodsCount, GetBindState,NeedBroadcast}, Multiple)];
                                       false ->
                                           [calc_reward_to_player__(goods, PS_Or_PlayerId, {need_broadcast,GetGoodsNo, GetGoodsCount, GetQuality, GetBindState,NeedBroadcast}, Multiple)]
                                   end
                           end;
                       false ->
                           []
                   end

            end,

            ?TRACE("lib_reward:calc_reward_to_player:~p~n", [RewardList]),

            %% 处理按种族性别的不同给予不同 物品
            Reward4 = calc_reward_to_player__(goods, PS_Or_PlayerId, RewardPkgCfg, Multiple),

            %% 给帮派成员贡献度
            Reward5 = calc_reward_to_player__(contribute, PS_Or_PlayerId, RewardPkgCfg#reward_pkg.contribute, Multiple),

            Reward6 = calc_reward_to_player__(vip_exp, PS_Or_PlayerId, RewardPkgCfg#reward_pkg.vip_exp, Multiple),

            Reward7 = calc_extra_reward_to_player(RewardPkgCfg#reward_pkg.extra_reward, PS_Or_PlayerId, Multiple),

            RewardList1 = RewardList ++ RewardMoneyList ++ [Reward2] ++ [Reward3] ++ [Reward4] ++ [Reward5] ++ [Reward6] ++ [Reward7],
            
            sum_reward(RewardList1)
    end.


%% 根据人物获得经验，计算所有宠物获得经验
calc_all_exp_to_partners(PS, AddExp) ->
    F = fun(X, Acc) ->
        case lib_partner:get_partner(X) of
            null ->
                ?ASSERT(false, X),
                ?ERROR_MSG("lib_reward:calc_all_exp_to_partners error!~p~n", [X]),
                Acc;
            Partner ->
                case lib_partner:is_fighting(Partner) of
                    true ->
                        case lib_partner:is_main_partner(Partner) of
                            true -> Acc + AddExp;
                            false -> Acc + AddExp
                        end;
                    false ->
                        Acc
                end
        end     
    end,

    ParIdList = player:get_partner_id_list(PS),
    lists:foldl(F, 0, ParIdList).

%% 给奖励：钱
give_reward_to_player__(money, _PS, [], _, _Multiple) ->
    [];
give_reward_to_player__(money, PS, MoneyList, LogInfo, Multiple) ->
    F = fun(X) ->
        {Proba, MoneyType, MoneyAmount} = X,
        ?ASSERT(util:is_probability(Proba), X),
        ?ASSERT(lib_comm:is_valid_money_type(MoneyType) , X),
        ?ASSERT(is_integer(MoneyAmount) andalso MoneyAmount > 0, X),
        case util:decide_proba_once(Proba) of
            fail ->
                #reward_dtl{};
            success ->
                ?TRACE("give_reward_to_player(), money, MoneyType=~p, MoneyAmount=~p~n", [MoneyType, MoneyAmount]),
                player:add_money(PS, MoneyType, MoneyAmount*Multiple, LogInfo),
                GoodsNo = 
                case MoneyType of
                    ?MNY_T_GAMEMONEY -> ?VGOODS_GAMEMONEY;
                    ?MNY_T_VITALITY -> ?VGOODS_VITALITY;
                    ?MNY_T_COPPER -> ?VGOODS_COPPER;
                    ?MNY_T_BIND_GAMEMONEY -> ?VGOODS_BIND_GAMEMONEY;
                    ?MNY_T_YUANBAO -> ?VGOODS_YB;
                    ?MNY_T_BIND_YUANBAO -> ?VGOODS_BIND_YB;
                    _ -> ?ASSERT(false), ?INVALID_NO
                end,

                #reward_dtl{goods_list = [{?INVALID_ID, GoodsNo, MoneyAmount*Multiple}]}
        end
    end,
    [F(X) || X <- MoneyList];

%% 给奖励：经验
give_reward_to_player__(exp, _PS, null, _, _Multiple) ->
    #reward_dtl{};
give_reward_to_player__(exp, PS, RewardPkgCfg, LogInfo, Multiple) ->
    case RewardPkgCfg#reward_pkg.exp of
        null -> #reward_dtl{};
        {Proba, ExpToAdd} ->
            ?ASSERT(is_integer(ExpToAdd) andalso ExpToAdd >= 0, {Proba, ExpToAdd}),
            case util:decide_proba_once(Proba) of
                fail ->
                    #reward_dtl{};
                success ->
                    RetExpToAdd = may_get_team_leader_weal(PS, ExpToAdd),
                        
                    ?TRACE("give_reward_to_player(), exp, ExpToAddBase=~p, ExpToAdd=~p~n", [ExpToAdd, RetExpToAdd]),
                    player:add_exp(PS, RetExpToAdd*Multiple, LogInfo),

                    ParReward = try_give_reward_to_partner__(exp, PS, RewardPkgCfg, LogInfo, Multiple),

                    #reward_dtl{goods_list = [{?INVALID_ID, ?VGOODS_EXP, RetExpToAdd*Multiple}] ++ ParReward#reward_dtl.goods_list}    
            end
    end;

%% 给予玩家所在帮派奖励繁荣度
give_reward_to_player__(contribute, _PS, null, _, _Multiple) ->
    #reward_dtl{};
give_reward_to_player__(contribute, PS, Contribute, LogInfo, Multiple) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID ->
            #reward_dtl{};
        _GuildId ->
            case player:get_guild_id(PS) =:= ?INVALID_ID of
                true ->
                    #reward_dtl{goods_list = []};
                false ->
                    % 增加玩家个人属性
                    player:add_guild_contri(PS, Contribute*Multiple, LogInfo),

                    % 增加玩家累计属性
                    mod_guild_mgr:add_member_contri(PS, Contribute*Multiple, LogInfo),
                    #reward_dtl{goods_list = [{?INVALID_ID, ?VGOODS_CONTRI, Contribute*Multiple}]}  
            end
    end;


give_reward_to_player__(sys_activity_times, _PS, null, _, _Multiple) ->
    #reward_dtl{};
give_reward_to_player__(sys_activity_times, PS, Add, _LogInfo, Multiple) ->
    case Add of
        {Sys, Num} ->
            lib_activity_degree:publ_add_sys_activity_times(Sys, Num*Multiple, PS),
            #reward_dtl{goods_list = [{?INVALID_ID, ?VGOODS_SYS_ACTIVITY_TIMES, Num*Multiple}]};
        _Any ->
            ?ASSERT(false, _Any),
            #reward_dtl{}
    end;

give_reward_to_player__(vip_exp, _PS, null, _, _Multiple) ->
    #reward_dtl{};
give_reward_to_player__(vip_exp, PS, VipExp, _LogInfo, Multiple) ->
    mod_vip:add_exp(VipExp*Multiple, PS),
    #reward_dtl{goods_list = [{?INVALID_ID, ?VGOODS_CONTRI, VipExp*Multiple}]};

%% 给奖励：天赋属性
give_reward_to_player__(talents, _PS, null, _, _Multiple) ->
    #reward_dtl{};
give_reward_to_player__(talents, PS, RewardTalents, _, Multiple) ->
    ?ASSERT(is_list(RewardTalents), RewardTalents),
    
    F = fun({TalentType, TPoints}) ->
            ?ASSERT(is_integer(TPoints) andalso TPoints > 0, {TalentType, TPoints}),
            ?TRACE("give_reward_to_player__(), talents, TalentType=~p, Points=~p~n", [TalentType, TPoints]),
            Points = TPoints*Multiple,
            case TalentType of
                str ->
                    player:add_base_str(PS, Points),
                    #reward_dtl{goods_list = [{?INVALID_ID, ?VGOODS_STR, Points}]};
                con ->
                    player:add_base_con(PS, Points),
                    #reward_dtl{goods_list = [{?INVALID_ID, ?VGOODS_CON, Points}]}; 
                sta ->
                    player:add_base_stam(PS, Points),
                    #reward_dtl{goods_list = [{?INVALID_ID, ?VGOODS_STA, Points}]};
                spi ->
                    player:add_base_spi(PS, Points),
                    #reward_dtl{goods_list = [{?INVALID_ID, ?VGOODS_SPI, Points}]};
                agi ->
                    player:add_base_agi(PS, Points),
                    #reward_dtl{goods_list = [{?INVALID_ID, ?VGOODS_AGI, Points}]}
            end
        end,
    % 添加点数
    RewardList = lists:map(F, RewardTalents),

    ?TRACE("give_reward_to_player__(), talents, RewardList=~p~n", [RewardList]),

    % 重算属性
    ply_attr:recount_base_and_total_attrs(PS),
    % 天赋信息更新到DB
    player:db_save_talents(PS),
    sum_reward(RewardList);

% 给予物品
give_reward_to_player__(goods, PS, {need_broadcast,GoodsNo, GoodsCount, Quality, BindState,NeedBroadcast}, LogInfo, Multiple) when is_integer(GoodsNo) andalso GoodsNo > 1 ->
    Ret = #reward_dtl{goods_list = RetGoods} = give_reward_to_player__(goods, PS, {GoodsNo, GoodsCount, Quality, BindState}, LogInfo, Multiple),

    ?DEBUG_MSG("RetGood=~p",[RetGoods]),
    case NeedBroadcast of
        0 -> skip;
        _ -> mod_broadcast:send_sys_broadcast(NeedBroadcast, [player:get_name(PS), player:id(PS), GoodsNo, Quality, GoodsCount,0])
    end,

    Ret;

give_reward_to_player__(goods, PS, {need_broadcast,Proba, GoodsNo, GoodsCount, BindState,NeedBroadcast}, LogInfo, Multiple) ->
    Ret = #reward_dtl{goods_list = RetGoods} = give_reward_to_player__(goods, PS, {Proba, GoodsNo, GoodsCount, BindState}, LogInfo, Multiple),

    ?DEBUG_MSG("RetGood=~p",[RetGoods]),
    case NeedBroadcast of
        0 -> skip;
        _ -> mod_broadcast:send_sys_broadcast(NeedBroadcast, [player:get_name(PS), player:id(PS), GoodsNo, lib_goods:get_quality(GoodsNo), GoodsCount,0])
    end,
    
    Ret;

give_reward_to_player__(goods, PS, {need_broadcast,GoodsNo, GoodsCount, BindState,NeedBroadcast}, LogInfo, Multiple) ->
    Ret = #reward_dtl{goods_list = RetGoods} = give_reward_to_player__(goods, PS, {GoodsNo, GoodsCount, BindState}, LogInfo, Multiple),
    
    ?DEBUG_MSG("RetGood=~p",[RetGoods]),
    case NeedBroadcast of
        0 -> skip;
        _ -> mod_broadcast:send_sys_broadcast(NeedBroadcast, [player:get_name(PS), player:id(PS), GoodsNo, lib_goods:get_quality(GoodsNo), GoodsCount,0])
    end,

    Ret;

give_reward_to_player__(goods, PS, {GoodsNo, GoodsCount, Quality, BindState}, LogInfo, Multiple) when is_integer(GoodsNo) andalso GoodsNo > 1 ->
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo)),
    PlayerId = player:id(PS),
    % case mod_inv:check_batch_add_goods(PlayerId, [{GoodsNo, GoodsCount}]) of
    %     {fail, _Reason} ->  % 背包满了则不给
    %         #reward_dtl{};
    %     ok ->
            ?TRACE("give_reward_to_player(), goods, GoodsNo=~p, GoodsCount=~p~n", [GoodsNo, GoodsCount]),
            RetAddGoods = 
                case Quality =:= ?QUALITY_INVALID of
                    false ->
                        mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount*Multiple}], [{quality, Quality}, {bind_state, BindState}], LogInfo);
                    true ->
                        mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount*Multiple}], [{bind_state, BindState}], LogInfo)
                end,
            case RetAddGoods of
                {fail, _Reason} ->
                    ?ERROR_MSG("lib_reward:give_reward_to_player__ add_goods error!Reason:~p~n", [_Reason]),
                    #reward_dtl{};
                {ok, RetGoods} ->
                    F = fun({Id, No, Cnt}) ->
                        case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                            null -> skip;
                            Goods ->
                                ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt,Id]})
                        end
                    end,
                    [F(X) || X <- RetGoods],
                    #reward_dtl{goods_list = RetGoods}
            end;
    % end;

%% 给奖励：物品
give_reward_to_player__(goods, PS, {Proba, GoodsNo, GoodsCount, BindState}, LogInfo, Multiple) ->
    ?ASSERT(util:is_probability(Proba), Proba),
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0, GoodsCount),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo), GoodsNo),
    PlayerId = player:id(PS),
    % case mod_inv:check_batch_add_goods(PlayerId, [{GoodsNo, GoodsCount}]) of
    %     {fail, _Reason} ->  % 背包满了则不给
    %         #reward_dtl{};
    %     ok ->
            case util:decide_proba_once(Proba) of
                fail ->
                    #reward_dtl{};
                success ->
                    ?TRACE("give_reward_to_player(), goods, GoodsNo=~p, GoodsCount=~p~n", [GoodsNo, GoodsCount]),
                    RetAddGoods = 
                        mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount*Multiple}], [{bind_state, BindState}], LogInfo),
                    case RetAddGoods of
                        {fail, _Reason} ->
                            ?ERROR_MSG("lib_reward:give_reward_to_player__ add_goods error!Reason:~p~n", [_Reason]),
                            #reward_dtl{};
                        {ok, RetGoods} ->
                            F = fun({Id, No, Cnt}) ->
                                case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                                    null -> skip;
                                    Goods ->
                                        ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt,Id]})
                                end
                            end,
                            [F(X) || X <- RetGoods],
                            #reward_dtl{goods_list = RetGoods}
                    end
            end;
    % end;

%% 给奖励：物品
give_reward_to_player__(goods, PS, {Proba, GoodsNo, GoodsCount, Quality, BindState}, LogInfo, Multiple) ->
    ?ASSERT(util:is_probability(Proba), Proba),
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0, GoodsCount),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo), GoodsNo),
    PlayerId = player:id(PS),
    % case mod_inv:check_batch_add_goods(PlayerId, [{GoodsNo, GoodsCount}]) of
    %     {fail, _Reason} ->  % 背包满了则不给
    %         #reward_dtl{};
    %     ok ->
            case util:decide_proba_once(Proba) of
                fail ->
                    #reward_dtl{};
                success ->
                    ?TRACE("give_reward_to_player(), goods, GoodsNo=~p, GoodsCount=~p, Quality = ~p ~n", [GoodsNo, GoodsCount, Quality]),
                    RetAddGoods = 
                        case Quality =:= ?QUALITY_INVALID of
                            false ->
                                mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount*Multiple}], [{quality, Quality}, {bind_state, BindState}], LogInfo);
                            true ->
                                mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount*Multiple}], [{bind_state, BindState}], LogInfo)
                        end,
                    case RetAddGoods of
                        {fail, _Reason} ->
                            ?ERROR_MSG("lib_reward:give_reward_to_player__ add_goods error!Reason:~p~n", [_Reason]),
                            #reward_dtl{};
                        {ok, RetGoods} ->
                            F = fun({Id, No, Cnt}) ->
                                case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                                    null -> skip;
                                    Goods ->
                                        ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt,Id]})
                                end
                            end,
                            [F(X) || X <- RetGoods],
                            #reward_dtl{goods_list = RetGoods}
                    end
            end;
    % end;

give_reward_to_player__(goods, PS, {GoodsNo, GoodsCount, BindState}, LogInfo, Multiple) ->
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0, {GoodsNo, GoodsCount, BindState}),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo)),
    PlayerId = player:id(PS),
    % case mod_inv:check_batch_add_goods(PlayerId, [{GoodsNo, GoodsCount}]) of
    %     {fail, _Reason} ->  % 背包满了则不给
    %         #reward_dtl{};
    %     ok ->
            ?TRACE("give_reward_to_player(), goods, GoodsNo=~p, GoodsCount=~p~n", [GoodsNo, GoodsCount]),
            RetAddGoods = 
                mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount*Multiple}], [{bind_state, BindState}], LogInfo),
            case RetAddGoods of
                {fail, _Reason} ->
                    ?ERROR_MSG("lib_reward:give_reward_to_player__ add_goods error!Reason:~p~n", [_Reason]),
                    #reward_dtl{};
                {ok, RetGoods} ->
                    F = fun({Id, No, Cnt}) ->
                        case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                            null -> skip;
                            Goods ->
                                ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt,Id]})
                        end
                    end,
                    [F(X) || X <- RetGoods],
                    #reward_dtl{goods_list = RetGoods}
            end;
    % end;

give_reward_to_player__(goods, PS, RewardPkgCfg, LogInfo, Multiple) when is_record(RewardPkgCfg, reward_pkg) ->  % 处理按种族性别的不同给予不同 物品
    case ((RewardPkgCfg#reward_pkg.condition =:= []) orelse (RewardPkgCfg#reward_pkg.goods_added =:= [])) of
        true -> 
            #reward_dtl{};
        false ->
            ?ASSERT(length(RewardPkgCfg#reward_pkg.condition) =:= length(RewardPkgCfg#reward_pkg.goods_added)),
            F = fun(Para) ->
                {Proba, GoodsNoList, GoodsCount, Quality, BindState} = 
                    case Para of
                        {TProba, TGoodsNoList, TGoodsCount, TBindState} -> {TProba, TGoodsNoList, TGoodsCount, ?QUALITY_INVALID, TBindState};
                        {TProba, TGoodsNoList, TGoodsCount, TQuality, TBindState} -> {TProba, TGoodsNoList, TGoodsCount, TQuality, TBindState}
                    end,

                case util:decide_proba_once(Proba) of
                    fail ->
                        #reward_dtl{};
                    success ->
                        Index = get_index(Para, RewardPkgCfg#reward_pkg.goods_added),

                        {Race, Sex, Faction} = 
                        case lists:nth(Index, RewardPkgCfg#reward_pkg.condition) of
                            {_Race,_Sex} -> {_Race,_Sex,0};
                            {_Race,_Sex,_Faction} -> {_Race,_Sex,_Faction}
                        end,

                        ?DEBUG_MSG("Race=~p, Sex=~p, Faction=~p",[Race, Sex, Faction]),

                        Fadd = fun(GoodsNo,Acc) ->
                            SexB = (Sex =:= 0 orelse player:get_sex(PS) =:= lib_goods:get_sex(GoodsNo) orelse 0 =:= lib_goods:get_sex(GoodsNo)),
                            RaceB = (Race =:= 0 orelse player:get_race(PS) =:= lib_goods:get_race(GoodsNo) orelse 0 =:= lib_goods:get_race(GoodsNo)),
                            FactionB = (Faction =:= 0 orelse player:get_faction(PS)  =:= lib_goods:get_faction(GoodsNo) orelse 0 =:= lib_goods:get_faction(GoodsNo)),

                            Ret = 
                                if
                                   SexB andalso RaceB andalso FactionB -> [GoodsNo|Acc];
                                   true -> Acc
                                end,


                                Ret
                        end,

                        AddGoodsNoList = lists:foldl(Fadd, [], GoodsNoList),

                        F1 = fun(X, GoodsCountList) ->
                            case lib_goods:get_tpl_data(X) of
                                null -> 
                                    GoodsCountList;
                                _ ->
                                    [{X, GoodsCount*Multiple}] ++ GoodsCountList
                            end
                        end,
                        TotalGoodsCountList = lists:foldl(F1, [], AddGoodsNoList),
                        
                        RetAddGoods = 
                        case Quality =:= ?QUALITY_INVALID of
                            true -> mod_inv:batch_smart_add_new_goods(player:get_id(PS), TotalGoodsCountList, [{bind_state, BindState}], LogInfo);
                            false -> mod_inv:batch_smart_add_new_goods(player:get_id(PS), TotalGoodsCountList, [{quality, Quality}, {bind_state, BindState}], LogInfo)
                        end,
                        case RetAddGoods of
                            {fail, _Reason} ->
                                ?ERROR_MSG("lib_reward:give_reward_to_player__ add_goods error!Reason:~p~n", [_Reason]),
                                #reward_dtl{};
                            {ok, RetGoods} ->
                                F2 = fun({Id, N, C}) ->
                                    case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                                        null -> skip;
                                        Goods ->
                                            ply_tips:send_sys_tips(PS, {get_goods, [N, lib_goods:get_quality(Goods), C,Id]})
                                    end
                                end,
                                [F2(X) || X <- RetGoods],
                                #reward_dtl{goods_list = RetGoods}
                        end
                end
            end,
            RewardList = lists:map(F, RewardPkgCfg#reward_pkg.goods_added),
            ?TRACE("lib_reward:give_reward_to_player__(goods, PS, RewardPkgCfg):~p~n", [RewardList]),
            sum_reward(RewardList)
    end.


try_give_reward_to_partner__(exp, PS, RewardPkgCfg, LogInfo, Multiple) ->
    ?TRACE("lib_reward:try_give_reward_to_partner__():~n", []),
    F = fun(PartnerId, Sum) ->
        case lib_partner:get_partner(PartnerId) of
            null -> Sum;
            Partner ->
                case lib_partner:is_fighting(Partner) of
                    false -> Sum;
                    true ->
                        case RewardPkgCfg#reward_pkg.exp of
                            null -> Sum;
                            {_Proba, ExpToAdd} ->
                                ExpToAdd1 = 
                                    case lib_partner:is_main_partner(Partner) of
                                        true -> util:ceil(ExpToAdd*Multiple);
                                        false -> util:ceil(ExpToAdd * RewardPkgCfg#reward_pkg.ratio_of_par_get / 100*Multiple)
                                    end,
                                lib_partner:add_exp(Partner, ExpToAdd1, PS, LogInfo),
                                ?TRACE("lib_reward:try_give_reward_to_partner__():~p~n", [ExpToAdd1]),
                                Sum + ExpToAdd1
                        end
                end
        end
    end,
    TotalExp = lists:foldl(F, 0, player:get_partner_id_list(PS)),
    #reward_dtl{goods_list = [{?INVALID_ID, ?VGOODS_PAR_EXP, TotalExp}]}.


give_extra_reward_to_player(null, _PS, _ParaList, _, _Multiple) ->
    #reward_dtl{};
give_extra_reward_to_player([], _PS, _ParaList, _, _Multiple) ->
    #reward_dtl{};
%% Para:格式：[{[{条件1名称,条件1参数},{条件2名称,条件2参数}], 奖励id},...] 
give_extra_reward_to_player(Para, PS, ParaList, LogInfo, Multiple) when is_list(Para) ->
    F = fun({ConditionList, RewardPkgNo}, Acc) ->
        Reward = 
            case accord_with_condition(ConditionList, ParaList, PS) of
                false -> #reward_dtl{};
                true -> give_reward_to_player(PS, RewardPkgNo, LogInfo, Multiple)
            end,
        sum_reward([Acc, Reward])
    end,
    lists:foldl(F, #reward_dtl{}, Para);

give_extra_reward_to_player(_, _PS, _ParaList, _, _Multiple) ->
    #reward_dtl{}.

%% ParaList --> [ {min1, max1, 奖励id1}, {min2, max2, 奖励id2} ]
give_extra_reward_to_player(null, _PS, _LogInfo, _Multiple) ->
    #reward_dtl{};
give_extra_reward_to_player([], _PS, _LogInfo, _Multiple) ->
    #reward_dtl{};
give_extra_reward_to_player([{lv_range,  ParaList}], PS, LogInfo, Multiple) ->
    case get_reward_no_by_lv(ParaList, player:get_lv(PS)) of
        ?INVALID_NO ->
            ?ASSERT(false),
            #reward_dtl{};
        RewardPkgNo -> 
            case data_reward_con:get(RewardPkgNo) of
                null ->
                    give_reward_to_player(PS, RewardPkgNo, LogInfo, Multiple);
                _ConData -> %% 若果有配公式参数，需要把公式计算的奖励也计算在内
                    give_reward_to_player(common, PS, RewardPkgNo, [], LogInfo, Multiple)
            end
    end;
give_extra_reward_to_player(_, _PS, _LogInfo, _Multiple) ->
    #reward_dtl{}.


%% ----------------------计算奖励begin

%% 给奖励：钱
calc_reward_to_player__(money, _PS, [], _Multiple) ->
    [];
calc_reward_to_player__(money, _PS, MoneyList, Multiple) ->
    F = fun(X) ->
        {Proba, MoneyType, MoneyAmount} = X,
        ?ASSERT(util:is_probability(Proba), X),
        ?ASSERT(lib_comm:is_valid_money_type(MoneyType) , X),
        ?ASSERT(is_integer(MoneyAmount) andalso MoneyAmount > 0, X),
        case util:decide_proba_once(Proba) of
            fail ->
                #reward_dtl{};
            success ->
                ?TRACE("calc_reward_to_player(), money, MoneyType=~p, MoneyAmount=~p~n", [MoneyType, MoneyAmount]),
                
                GoodsNo = 
                case MoneyType of
                    ?MNY_T_GAMEMONEY -> ?VGOODS_GAMEMONEY;
                    ?MNY_T_COPPER -> ?VGOODS_COPPER;
                    ?MNY_T_VITALITY -> ?VGOODS_VITALITY;
                    ?MNY_T_BIND_GAMEMONEY -> ?VGOODS_BIND_GAMEMONEY;
                    ?MNY_T_YUANBAO -> ?VGOODS_YB;
                    ?MNY_T_BIND_YUANBAO -> ?VGOODS_BIND_YB;
                    _ -> ?ASSERT(false), ?INVALID_NO
                end,

                #reward_dtl{calc_goods_list = [{GoodsNo, MoneyAmount*Multiple, ?QUALITY_INVALID, ?INVALID_NO}]}
        end
    end,
    [F(X) || X <- MoneyList];

%% 给奖励：经验
calc_reward_to_player__(exp, _PS, null, _Multiple) ->
    #reward_dtl{};
calc_reward_to_player__(exp, PS_Or_PlayerId, RewardPkgCfg, Multiple) ->
    case RewardPkgCfg#reward_pkg.exp of
        null -> #reward_dtl{};
        {Proba, ExpToAdd} ->
            ?ASSERT(is_integer(ExpToAdd) andalso ExpToAdd > 0, {Proba, ExpToAdd}),
            case util:decide_proba_once(Proba) of
                fail ->
                    #reward_dtl{};
                success ->
                    RetExpToAdd = may_get_team_leader_weal(PS_Or_PlayerId, ExpToAdd),
                        
                    ?TRACE("calc_reward_to_player(), exp, ExpToAddBase=~p, ExpToAdd=~p~n", [ExpToAdd, RetExpToAdd]),

                    % ParReward = try_calc_reward_to_partner__(exp, PS, RewardPkgCfg),

                    #reward_dtl{calc_goods_list = [{?VGOODS_EXP, RetExpToAdd*Multiple, ?QUALITY_INVALID, ?INVALID_NO}]}    
            end
    end;

%% 给予玩家所在帮派奖励繁荣度
calc_reward_to_player__(contribute, _PS, null, _Multiple) ->
    #reward_dtl{};
calc_reward_to_player__(contribute, PS_Or_PlayerId, Contribute, Multiple) ->
    case player:get_guild_id(PS_Or_PlayerId) of
        ?INVALID_ID ->
            #reward_dtl{};
        _GuildId ->
            #reward_dtl{calc_goods_list = [{?VGOODS_CONTRI, Contribute*Multiple, ?QUALITY_INVALID, ?INVALID_NO}]}  
    end;


calc_reward_to_player__(vip_exp, _PS, null, _Multiple) ->
    #reward_dtl{};
calc_reward_to_player__(vip_exp, _PS, VipExp, Multiple) ->
    #reward_dtl{calc_goods_list = [{?VGOODS_CONTRI, VipExp*Multiple, ?QUALITY_INVALID, ?INVALID_NO}]};

%% 给奖励：天赋属性
calc_reward_to_player__(talents, _PS, null, _Multiple) ->
    #reward_dtl{};
calc_reward_to_player__(talents, _PS, RewardTalents, Multiple) ->
    ?ASSERT(is_list(RewardTalents), RewardTalents),
    
    F = fun({TalentType, Points}) ->
            ?ASSERT(is_integer(Points) andalso Points > 0, {TalentType, Points}),
            ?TRACE("calc_reward_to_player__(), talents, TalentType=~p, Points=~p~n", [TalentType, Points]),
            case TalentType of
                str ->
                    #reward_dtl{calc_goods_list = [{?VGOODS_STR, Points*Multiple, ?QUALITY_INVALID, ?INVALID_NO}]};
                con ->
                    #reward_dtl{calc_goods_list = [{?VGOODS_CON, Points*Multiple, ?QUALITY_INVALID, ?INVALID_NO}]}; 
                sta ->
                    #reward_dtl{calc_goods_list = [{?VGOODS_STA, Points*Multiple, ?QUALITY_INVALID, ?INVALID_NO}]};
                spi ->
                    #reward_dtl{calc_goods_list = [{?VGOODS_SPI, Points*Multiple, ?QUALITY_INVALID, ?INVALID_NO}]};
                agi ->
                    #reward_dtl{calc_goods_list = [{?VGOODS_AGI, Points*Multiple, ?QUALITY_INVALID, ?INVALID_NO}]}
            end
        end,
    % 添加点数
    RewardList = lists:map(F, RewardTalents),

    ?TRACE("calc_reward_to_player__(), talents, RewardList=~p~n", [RewardList]),
    sum_reward(RewardList);

calc_reward_to_player__(goods, _PS, {need_broadcast,GoodsNo, GoodsCount, Quality, BindState,NeedBroadcast}, Multiple) when is_integer(GoodsNo) andalso GoodsNo > 1 ->
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo)),
    #reward_dtl{calc_goods_list = [{GoodsNo, GoodsCount*Multiple, Quality, BindState,NeedBroadcast}]};

calc_reward_to_player__(goods, _PS, {need_broadcast,GoodsNo, GoodsCount, BindState,NeedBroadcast}, Multiple) ->
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo)),
    #reward_dtl{calc_goods_list = [{GoodsNo, GoodsCount*Multiple, ?QUALITY_INVALID, BindState,NeedBroadcast}]};

calc_reward_to_player__(goods, _PS, {GoodsNo, GoodsCount, Quality, BindState}, Multiple) when is_integer(GoodsNo) andalso GoodsNo > 1 ->
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo)),
    #reward_dtl{calc_goods_list = [{GoodsNo, GoodsCount*Multiple, Quality, BindState}]};



%% 给奖励：物品
calc_reward_to_player__(goods, _PS, {Proba, GoodsNo, GoodsCount, BindState}, Multiple) ->
    ?ASSERT(util:is_probability(Proba), Proba),
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0, GoodsCount),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo), GoodsNo),
    case util:decide_proba_once(Proba) of
        fail ->
            #reward_dtl{};
        success ->
            ?TRACE("calc_reward_to_player(), goods, GoodsNo=~p, GoodsCount=~p~n", [GoodsNo, GoodsCount]),
            #reward_dtl{calc_goods_list = [{GoodsNo, GoodsCount*Multiple, ?QUALITY_INVALID, BindState}]}
    end;

%% 给奖励：物品
calc_reward_to_player__(goods, _PS, {Proba, GoodsNo, GoodsCount, Quality, BindState}, Multiple) ->
    ?ASSERT(util:is_probability(Proba), Proba),
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0, GoodsCount),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo), GoodsNo),
    case util:decide_proba_once(Proba) of
        fail ->
            #reward_dtl{};
        success ->
            ?TRACE("calc_reward_to_player(), goods, GoodsNo=~p, GoodsCount=~p, Quality = ~p ~n", [GoodsNo, GoodsCount, Quality]),
            #reward_dtl{calc_goods_list = [{GoodsNo, GoodsCount*Multiple, Quality, BindState}]}
    end;

%% 给奖励：物品
calc_reward_to_player__(goods, _PS, {Proba, GoodsNo, GoodsCount, Quality, BindState,NeedBroadcast}, Multiple) when is_integer(NeedBroadcast) ->
    ?ASSERT(util:is_probability(Proba), Proba),
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0, GoodsCount),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo), GoodsNo),
    case util:decide_proba_once(Proba) of
        fail ->
            #reward_dtl{};
        success ->
            ?TRACE("calc_reward_to_player(), goods, GoodsNo=~p, GoodsCount=~p, Quality = ~p ~n", [GoodsNo, GoodsCount, Quality]),
            #reward_dtl{calc_goods_list = [{GoodsNo, GoodsCount*Multiple, Quality, BindState,NeedBroadcast}]}
    end;

calc_reward_to_player__(goods, _PS, {GoodsNo, GoodsCount, BindState}, Multiple) ->
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo)),
    #reward_dtl{calc_goods_list = [{GoodsNo, GoodsCount*Multiple, ?QUALITY_INVALID, BindState}]};

calc_reward_to_player__(goods, PS_Or_PlayerId, RewardPkgCfg, Multiple) when is_record(RewardPkgCfg, reward_pkg) ->  % 处理按种族性别的不同给予不同 物品
    case ((RewardPkgCfg#reward_pkg.condition =:= []) orelse (RewardPkgCfg#reward_pkg.goods_added =:= [])) of
        true -> 
            #reward_dtl{};
        false ->
            ?ASSERT(length(RewardPkgCfg#reward_pkg.condition) =:= length(RewardPkgCfg#reward_pkg.goods_added)),
            F = fun(Para) ->
                {Proba, GoodsNoList, GoodsCount, Quality, BindState} = 
                    case Para of
                        {TProba, TGoodsNoList, TGoodsCount, TBindState} -> {TProba, TGoodsNoList, TGoodsCount, ?QUALITY_INVALID, TBindState};
                        {TProba, TGoodsNoList, TGoodsCount, TQuality, TBindState} -> {TProba, TGoodsNoList, TGoodsCount, TQuality, TBindState}
                    end,

                case util:decide_proba_once(Proba) of
                    fail ->
                        #reward_dtl{};
                    success ->
                        Index = get_index(Para, RewardPkgCfg#reward_pkg.goods_added),

                        {Race, Sex, Faction} = 
                        case lists:nth(Index, RewardPkgCfg#reward_pkg.condition) of
                            {_Race,_Sex} -> {_Race,_Sex,0};
                            {_Race,_Sex,_Faction} -> {_Race,_Sex,_Faction}
                        end,

                        ?DEBUG_MSG("Race=~p, Sex=~p, Faction=~p",[Race, Sex, Faction]),

                        Fadd = fun(GoodsNo,Acc) ->
                            SexB = (Sex =:= 0 orelse player:get_sex(PS_Or_PlayerId) =:= lib_goods:get_sex(GoodsNo) orelse 0 =:= lib_goods:get_sex(GoodsNo)),
                            RaceB = (Race =:= 0 orelse player:get_race(PS_Or_PlayerId) =:= lib_goods:get_race(GoodsNo) orelse 0 =:= lib_goods:get_race(GoodsNo)),
                            FactionB = (Faction =:= 0 orelse player:get_faction(PS_Or_PlayerId)  =:= lib_goods:get_faction(GoodsNo) orelse 0 =:= lib_goods:get_faction(GoodsNo)),

                            Ret = 
                            if
                               SexB andalso RaceB andalso FactionB -> [GoodsNo | Acc];
                               true -> Acc
                            end,


                            Ret
                        end,

                        AddGoodsNoList = lists:foldl(Fadd, [], GoodsNoList),

                        F1 = fun(X, GoodsCountList) ->
                            case lib_goods:get_tpl_data(X) of
                                null -> 
                                    GoodsCountList;
                                _ ->
                                    [{X, GoodsCount*Multiple, Quality, BindState}] ++ GoodsCountList
                            end
                        end,
                        TotalGoodsCountList = lists:foldl(F1, [], AddGoodsNoList),
                        
                        #reward_dtl{calc_goods_list = TotalGoodsCountList}
                end
            end,
            RewardList = lists:map(F, RewardPkgCfg#reward_pkg.goods_added),
            ?TRACE("lib_reward:calc_reward_to_player__(goods, PS, RewardPkgCfg):~p~n", [RewardList]),
            sum_reward(RewardList)
    end.


% try_calc_reward_to_partner__(exp, PS, RewardPkgCfg) ->
%     ?TRACE("lib_reward:try_calc_reward_to_partner__():~n", []),
%     F = fun(PartnerId, Sum) ->
%         case lib_partner:get_partner(PartnerId) of
%             null -> Sum;
%             Partner ->
%                 case RewardPkgCfg#reward_pkg.exp of
%                     null -> Sum;
%                     {_Proba, ExpToAdd} ->
%                         ExpToAdd1 = 
%                             case lib_partner:is_main_partner(Partner) of
%                                 true -> util:ceil(ExpToAdd * RewardPkgCfg#reward_pkg.ratio_of_par_get / 100);
%                                 false -> util:ceil(ExpToAdd * RewardPkgCfg#reward_pkg.ratio_of_par_get / 100)
%                             end,
%                         lib_partner:add_exp(Partner, ExpToAdd1, PS),
%                         ?TRACE("lib_reward:try_calc_reward_to_partner__():~p~n", [ExpToAdd1]),
%                         Sum + ExpToAdd1
%                 end
%         end
%     end,
%     TotalExp = lists:foldl(F, 0, player:get_partner_id_list(PS)),
%     #reward_dtl{goods_list = [{?INVALID_ID, ?VGOODS_PAR_EXP, TotalExp}]}.


% calc_extra_reward_to_player(null, _PS, _ParaList) ->
%     #reward_dtl{};
% calc_extra_reward_to_player({ConditionList, RewardPkgNo}, PS, ParaList) ->
%     case accord_with_condition(ConditionList, ParaList, PS) of
%         false -> skip;
%         true -> calc_reward_to_player(PS, RewardPkgNo)
%     end.

%% ParaList --> [ {min1, max1, 奖励id1}, {min2, max2, 奖励id2} ]
calc_extra_reward_to_player(null, _PS, _Multiple) ->
    #reward_dtl{};
calc_extra_reward_to_player([], _PS, _Multiple) ->
    #reward_dtl{};
calc_extra_reward_to_player([{lv_range,  ParaList}], PS, Multiple) ->
    case get_reward_no_by_lv(ParaList, player:get_lv(PS)) of
        ?INVALID_NO ->
            ?ASSERT(false),
            #reward_dtl{};
        RewardPkgNo -> calc_reward_to_player(PS, RewardPkgNo, Multiple)
    end;
calc_extra_reward_to_player(_, _PS, _Multiple) ->
    #reward_dtl{}.

%% -----------------------计算奖励end

get_reward_no_by_lv([], _Lv) ->
    ?ASSERT(false, _Lv),
    ?INVALID_NO;
get_reward_no_by_lv([H | T], Lv) ->
    {Min, Max, No} = H,
    case util:in_range(Lv, Min, Max) of
        true -> No;
        false -> get_reward_no_by_lv(T, Lv)
    end.


accord_with_condition([], _ParaList, _PS) ->
    true;
accord_with_condition([H | T], ParaList, PS) ->
    case H of
        {ring, Ring} ->
            case lists:keyfind(ring, 1, ParaList) of
                false -> false;
                {ring, Ring1} -> 
                    case Ring1 =:= Ring of
                        false -> false;
                        true -> accord_with_condition(T, ParaList, PS)
                    end
            end;
        {team_leader, IsLeader} ->
            case IsLeader of
                0 -> accord_with_condition(T, ParaList, PS);
                1 ->
                    case player:is_leader(PS) of
                        false -> false;
                        true -> accord_with_condition(T, ParaList, PS)
                    end
            end;
        {round, RoundList} ->
            case lists:keyfind(round, 1, ParaList) of
                false -> false;
                {round, Round} -> 
                    case lists:member(Round, RoundList) of
                        false -> false;
                        true -> accord_with_condition(T, ParaList, PS)
                    end
            end;
        {lv_min, LvMin} ->
            case player:get_lv(PS) >= LvMin of
                false -> false;
                true -> accord_with_condition(T, ParaList, PS)
            end;
        {lv_max, LvMax} ->
            case player:get_lv(PS) =< LvMax of
                false -> false;
                true -> accord_with_condition(T, ParaList, PS)
            end;
        {vip_lv_min, VipLvMin} ->
            case player:get_vip_lv(PS) >= VipLvMin of
                false -> false;
                true -> accord_with_condition(T, ParaList, PS)
            end;
        _Any ->
            ?ASSERT(false),
            false
    end.

    

% 等级差 奖励比例
% 等级差≤5   100%
% 5<等级差≤10    90%
% 10<等级差≤15   80%
% 15<等级差≤20   70%
% 20<等级差≤25   60%
% 25<等级差≤30   50%
% 30<等级差≤200  50%
% 其余： 统一用保底值（目前是50%）
get_lv_delta_coef(LvDelta) ->
    Ret = 
    if 
        LvDelta =< 5 -> 1;
        5 < LvDelta andalso LvDelta =< 10 -> 0.9;
        10 < LvDelta andalso LvDelta =< 15 -> 0.8;
        15 < LvDelta andalso LvDelta =< 20 -> 0.7;
        20 < LvDelta andalso LvDelta =< 25 -> 0.6;
        25 < LvDelta andalso LvDelta =< 30 -> 0.5;
        30 < LvDelta andalso LvDelta =< 200 -> 0.5;
        true -> 0.5
    end,
    Ret.


get_index(Tup, List) ->
    GoodsList = element(2, Tup),
    F = fun(Index, L) ->
        Tup1 = lists:nth(Index, List),
        GoodsList1 = element(2, Tup1),
        case Tup =:= Tup1 andalso GoodsList =:= GoodsList1 of
            false -> 
                L;
            true ->
                L ++ [Index]
        end
    end,
    IndexList = lists:foldl(F, [], [X || X <- lists:seq(1, length(List))]),
    ?ASSERT(length(IndexList) =:= 1, IndexList),
    erlang:hd(IndexList).


%return {type, Value}
get_lv(task, Index, PS, RewardPkgNo, TaskNo) ->
    RewardCon = data_reward_con:get(RewardPkgNo),
    ?ASSERT(length(RewardCon#reward_con.lv_need) == 3),

    case lists:nth(Index, RewardCon#reward_con.lv_need) of
        ?LV_PLAYER -> {?LV_PLAYER, player:get_lv(PS)};                                                 % 角色等级
        ?LV_TEAM_AVE -> {?LV_TEAM_AVE, mod_team:get_member_average_lv(player:get_id(PS))};                 % 队伍平均等级
        ?LV_TEAM_MAX  -> {?LV_TEAM_MAX, mod_team:get_member_max_lv(PS)};                                   % 队伍最大等级
        ?LV_TEAM_MIN  -> {?LV_TEAM_MIN, mod_team:get_member_min_lv(PS)};                                   % 队伍最低等级
        ?LV_ENEMY_AVE  -> ?ASSERT(false), {?LV_ENEMY_AVE, 0};                                                % 敌方平均等级
        ?LV_MON_AVE  ->  ?ASSERT(false), {?LV_MON_AVE, 0};                                               % 怪物平均等级
        ?LV_GUILD  ->  ?ASSERT(false), {?LV_GUILD, 0};                                               % 帮派等级
        ?LV_FARM  ->   ?ASSERT(false), {?LV_FARM, 0};                                              % 农场等级
        ?LV_PARTNER  ->   ?ASSERT(false), {?LV_PARTNER, 0};                                              % 宠物等级
        ?LV_PAR_AVE ->   ?ASSERT(false), {?LV_PAR_AVE, 0};                                              % 宠物平均等级
        ?LV_TASK ->  {?LV_TASK, lib_task:get_task_lv(TaskNo)};                                   % 任务等级
        ?VALUE_TOTAL_CONTRI ->   ?ASSERT(false), {?VALUE_TOTAL_CONTRI, 0};                                             % 总帮贡
        ?VALUE_LOGIN_CONTINU ->   ?ASSERT(false), {?VALUE_LOGIN_CONTINU, 0};                                             % 连续登陆天数
        ?VALUE_RANK_LADDER ->   ?ASSERT(false), {?VALUE_RANK_LADDER, 0}; 
        ?VALUE_TOWER_FLOOR -> ?ASSERT(false), {?VALUE_TOWER_FLOOR, true}; 
        ?VALUE_RECOMMEND_BATTLE_POWER -> ?ASSERT(false), {?VALUE_RECOMMEND_BATTLE_POWER, true}; 
        ?VALUE_DEFAULT -> {?VALUE_DEFAULT, 1};                                            
        _Any -> ?ASSERT(false, _Any), {0, 0}
    end.                                               


get_lv(tower, Index, PS, RewardPkgNo) ->
    RewardCon = data_reward_con:get(RewardPkgNo),
    ?ASSERT(length(RewardCon#reward_con.lv_need) == 3),
    case lists:nth(Index, RewardCon#reward_con.lv_need) of
        ?LV_PLAYER -> {?LV_PLAYER, player:get_lv(PS)};                                                 % 角色等级
        ?LV_TEAM_AVE -> {?LV_TEAM_AVE, mod_team:get_member_average_lv(player:get_id(PS))};                 % 队伍平均等级
        ?LV_TEAM_MAX  -> {?LV_TEAM_MAX, mod_team:get_member_max_lv(PS)};                                   % 队伍最大等级
        ?LV_TEAM_MIN  -> {?LV_TEAM_MIN, mod_team:get_member_min_lv(PS)};                                   % 队伍最低等级
        ?LV_ENEMY_AVE  -> ?ASSERT(false), {?LV_ENEMY_AVE, 0};                                                % 敌方平均等级
        ?LV_MON_AVE  ->  ?ASSERT(false), {?LV_MON_AVE, 0};                                               % 怪物平均等级
        ?LV_GUILD  ->  ?ASSERT(false), {?LV_GUILD, 0};                                               % 帮派等级
        ?LV_FARM  ->   ?ASSERT(false), {?LV_FARM, 0};                                              % 农场等级
        ?LV_PARTNER  ->   ?ASSERT(false), {?LV_PARTNER, 0};                                              % 宠物等级
        ?LV_PAR_AVE ->   ?ASSERT(false), {?LV_PAR_AVE, 0};                                              % 宠物平均等级
        ?VALUE_TOTAL_CONTRI ->   ?ASSERT(false), {?VALUE_TOTAL_CONTRI, 0};                                             % 总帮贡
        ?VALUE_LOGIN_CONTINU ->   ?ASSERT(false), {?VALUE_LOGIN_CONTINU, 0};                                             % 连续登陆天数
        ?VALUE_RANK_LADDER ->   ?ASSERT(false), {?VALUE_RANK_LADDER, 0};                                             % 天梯排名
        ?VALUE_TOWER_FLOOR -> {?VALUE_TOWER_FLOOR, true};
        ?VALUE_RECOMMEND_BATTLE_POWER -> {?VALUE_RECOMMEND_BATTLE_POWER, true};
        ?VALUE_DEFAULT -> {?VALUE_DEFAULT, 1};
        _Any -> ?ASSERT(false, _Any), {0, 0}
    end.


get_lv(Index, PS, RewardPkgNo) ->
    RewardCon = data_reward_con:get(RewardPkgNo),
    ?ASSERT(length(RewardCon#reward_con.lv_need) == 3),

    case lists:nth(Index, RewardCon#reward_con.lv_need) of
        ?LV_PLAYER -> {?LV_PLAYER, player:get_lv(PS)};                                                 % 角色等级
        ?LV_TEAM_AVE -> {?LV_TEAM_AVE, mod_team:get_member_average_lv(player:get_id(PS))};                 % 队伍平均等级
        ?LV_TEAM_MAX  -> {?LV_TEAM_MAX, mod_team:get_member_max_lv(PS)};                                   % 队伍最大等级
        ?LV_TEAM_MIN  -> {?LV_TEAM_MIN, mod_team:get_member_min_lv(PS)};                                   % 队伍最低等级
        ?LV_ENEMY_AVE  -> ?ASSERT(false), {?LV_ENEMY_AVE, 0};                                                % 敌方平均等级
        ?LV_MON_AVE  ->  ?ASSERT(false), {?LV_MON_AVE, 0};                                               % 怪物平均等级
        ?LV_GUILD  ->  ?ASSERT(false), {?LV_GUILD, 0};                                                  % 帮派等级
        ?LV_FARM  ->   ?ASSERT(false), {?LV_FARM, 0};                                              % 农场等级
        ?LV_PARTNER  ->   ?ASSERT(false), {?LV_PARTNER, 0};                                              % 宠物等级
        ?LV_PAR_AVE ->   ?ASSERT(false), {?LV_PAR_AVE, 0};                                              % 宠物平均等级
        ?VALUE_TOTAL_CONTRI ->   ?ASSERT(false), {?VALUE_TOTAL_CONTRI, 0};                                             % 总帮贡
        ?VALUE_LOGIN_CONTINU ->   ?ASSERT(false), {?VALUE_LOGIN_CONTINU, 0};                                             % 连续登陆天数
        ?VALUE_RANK_LADDER ->   ?ASSERT(false), {?VALUE_RANK_LADDER, 0};                                             % 天梯排名
        ?VALUE_TOWER_FLOOR -> {?VALUE_TOWER_FLOOR, true};
        ?VALUE_RECOMMEND_BATTLE_POWER -> {?VALUE_RECOMMEND_BATTLE_POWER, true};
        ?VALUE_DEFAULT -> {?VALUE_DEFAULT, 1};
        _Any -> ?ASSERT(false, _Any), {0, 0}
    end.

%% 多个reward_dtl结构体的对应字段相加，返回结果
%% @return: reward_dtl结构体
sum_reward([]) ->
    #reward_dtl{};
sum_reward([Reward]) ->
    ?ASSERT(is_record(Reward, reward_dtl)),
    Reward;
sum_reward([Reward1, Reward2 | T]) ->
    TmpReward = sum_two_reward(Reward1, Reward2),
    sum_reward([TmpReward | T]).

sum_two_reward(Reward1, Reward2) ->
    ?ASSERT(is_record(Reward1, reward_dtl), Reward1),
    ?ASSERT(is_record(Reward2, reward_dtl), Reward2),
    #reward_dtl{
        goods_list = Reward1#reward_dtl.goods_list ++ Reward2#reward_dtl.goods_list,
        calc_goods_list = Reward1#reward_dtl.calc_goods_list ++ Reward2#reward_dtl.calc_goods_list
        }.


may_get_team_leader_weal(PS_Or_PlayerId, ExpAddBase) ->
    case player:is_leader(PS_Or_PlayerId) of
        false ->
            util:ceil(ExpAddBase);
        true ->
            util:ceil(ExpAddBase) %% 策划暂时屏蔽
            % MbCount = mod_team:get_normal_member_count(player:get_team_id(PS)),
            % if
            %     MbCount =:= 1 ->
            %         util:ceil(ExpAddBase);
            %     MbCount =:= 2 ->
            %         util:ceil(ExpAddBase * (1 + 0.04));
            %     MbCount =:= 3 ->
            %         util:ceil(ExpAddBase * (1 + 0.06));
            %     MbCount =:= 4 ->
            %         util:ceil(ExpAddBase * (1 + 0.08));
            %     MbCount =:= 5 ->
            %         util:ceil(ExpAddBase * (1 + 0.1));
            %     true ->
            %         util:ceil(ExpAddBase)
            % end
    end.


% dbg_is_valid_goods_list(GoodsList) ->
%     F = fun(X, Sum) ->
%         Proba = 
%             case X of
%                 {TProba, _GoodsNo, _GoodsCount, _BindState} -> TProba;
%                 {TProba, _GoodsNo, _GoodsCount, _Quality, _BindState} -> TProba
%             end,
%         Proba + Sum
%     end,
%     TmpRet = lists:foldl(F, 0, GoodsList),
%     Ret = round(TmpRet),
%     Ret =:= 1.


decide_goods_by_prob(GoodsList) ->
    case GoodsList =:= [] of
        true -> null;
        false ->
            Range = util:ceil(get_rand_range(GoodsList)),
            case Range < 1 of
                true -> 
                    ?ERROR_MSG("lib_reward:decide_goods_by_prob error!GoodsList:~p~n", [GoodsList]),
                    null;
                false ->
                    RandNum = util:rand(1, Range),
                    decide_goods_by_prob(GoodsList, RandNum, 0)
            end
    end.


decide_goods_by_prob([], _RandNum, _SumToCompare) ->
    null;
decide_goods_by_prob([H | T], RandNum, SumToCompare) ->
    {Proba, GoodsNo, GoodsCount, Quality, BindState,NeedBroadcast} = 
        case H of
            {TProba, TGoodsNo, TGoodsCount, TBindState} -> {TProba, TGoodsNo, TGoodsCount, ?QUALITY_INVALID, TBindState,0};
            {TProba, TGoodsNo, TGoodsCount, TQuality, TBindState} -> {TProba, TGoodsNo, TGoodsCount, TQuality, TBindState,0};
            {TProba, TGoodsNo, TGoodsCount, TQuality, TBindState,TNeedBroadcast} -> {TProba, TGoodsNo, TGoodsCount, TQuality, TBindState,TNeedBroadcast}
        end,
    SumToCompare_2 = Proba * (?PROBABILITY_BASE*10) + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true ->
            {GoodsNo, GoodsCount, Quality, BindState,NeedBroadcast};
        false ->
            decide_goods_by_prob(T, RandNum, SumToCompare_2)
    end.

%% 这里把概率放大一定的倍数
get_rand_range(GoodsList) ->
    F = fun(X, Sum) ->
        case X of
            {TProba, _TGoodsNo, _TGoodsCount, _TBindState} -> TProba * (?PROBABILITY_BASE * 10) + Sum;
            {TProba, _TGoodsNo, _TGoodsCount, _TQuality, _TBindState} -> TProba * (?PROBABILITY_BASE * 10)  + Sum;
            {TProba, _TGoodsNo, _TGoodsCount, _TQuality, _TBindState,_} -> TProba * (?PROBABILITY_BASE * 10)  + Sum
        end
    end,
    lists:foldl(F, 0, GoodsList).


is_virtual_goods_no(GoodsNo) ->
    case GoodsNo of
        ?VGOODS_GAMEMONEY -> true;
        ?VGOODS_BIND_GAMEMONEY -> true;
        ?VGOODS_YB -> true;
        ?VGOODS_BIND_YB -> true;
        ?VGOODS_EXP -> true;
        ?VGOODS_STR -> true;
        ?VGOODS_CON -> true;
        ?VGOODS_STA -> true;
        ?VGOODS_SPI -> true;
        ?VGOODS_AGI -> true;
        ?VGOODS_FEAT -> true;
        ?VGOODS_CONTRI -> true;
        ?VGOODS_LITERARY -> true;
        ?VGOODS_PAR_EXP -> true;
        ?VGOODS_SYS_ACTIVITY_TIMES -> true;
        ?VGOODS_FREE_TALENT_POINTS -> true;
        ?VGOODS_COPPER -> true;
        ?VGOODS_VITALITY -> true;
        ?VGOODS_CHIVALROUS -> true;
        ?VGOODS_CHIP -> true;
        _ -> false
    end.

%% 抓鬼和师门任务额外奖励
get_reward_by_gosht_faction_task() ->
    ErnieNoL = data_task_ernie:get_no(),
    F0 = fun(No, Acc) ->
            (data_task_ernie:get(No))#task_ernie.prob + Acc
         end,
    WeightSum = lists:foldl(F0, 0, ErnieNoL),
    Seed = random:uniform(WeightSum),
    get_ernie_no(Seed, ErnieNoL, 0).

get_ernie_no(Seed, [H|T], SumCount0) ->
    SumCount = (data_task_ernie:get(H))#task_ernie.prob + SumCount0,
    case SumCount >= Seed of
        true -> H;
        false ->
            get_ernie_no(Seed, T, SumCount)
    end.