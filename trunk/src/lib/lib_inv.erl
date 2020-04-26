%%%--------------------------------------
%%% @Module  : lib_inv
%%% @Author  : zhangwq, 
%%% @Email   : 
%%% @Created : 2013.5.29
%%% @Description : 物品系统的相关接口
%%%--------------------------------------
-module(lib_inv).

-export([
        sort_goods/2, %按条件排序物品列表
        common_check_use_goods/2,
        common_check_use_goods/3,
        can_goods_trigger_accept_task/2,
        can_get_goods_effect/4,
        notify_cli_goods_info_change/2,
        notify_cli_goods_added_to_bag/2,
        notify_cli_goods_added/2,
        notify_cli_goods_destroyed_from_bag/3,
        notify_cli_goods_destroyed/3
        % ...        
             
    ]).

-include("pt_15.hrl").
-include("goods.hrl").
-include("record/goods_record.hrl").
-include("inventory.hrl").
-include("abbreviate.hrl").
-include("prompt_msg_code.hrl").
-include("effect.hrl").
-include("mount.hrl").

-include("player.hrl").

%% 整理物品列表, 按条件排序物品列表
%% @return: 排序后的物品列表
sort_goods(GoodsList, Type_SortBy) ->
    F = case Type_SortBy of
        sort_by_slot -> fun(G1, G2) -> G1#goods.slot < G2#goods.slot end;                       % 依据物品的格子位置
        sort_by_no -> fun(G1, G2) -> G1#goods.no < G2#goods.no end;                             % 依据物品编号
        sort_by_count -> fun(G1, G2) -> G1#goods.count < G2#goods.count end;                    % 依据物品的数量
        sort_by_id -> fun(G1, G2) -> G1#goods.id < G2#goods.id end;                             % 依据物品的唯一id
        sort_by_sub_type -> fun(G1, G2) -> lib_goods:get_subtype(G1) < lib_goods:get_subtype(G2) end;
        sort_by_type -> fun(G1, G2) -> lib_goods:get_type(G1) < lib_goods:get_type(G2) end;
        sort_by_quality -> fun(G1, G2) -> lib_goods:get_quality(G1) > lib_goods:get_quality(G2) end;
        sort_by_sell_time -> fun(G1, G2) -> G1#goods.sell_time < G2#goods.sell_time end;         % 依据物品的唯一id
        sort_by_buy_price -> fun(G1, G2) -> lib_goods:get_purchase_price(G1) < lib_goods:get_purchase_price(G2) end;
        sort_by_bind_state -> fun(G1, G2) -> G1#goods.bind_state < G2#goods.bind_state end
    end,
    lists:sort(F, GoodsList).


%% 使用物品的通用检查
%% @return: 无 | 直接throw失败原因（由上层函数去catch）
common_check_use_goods(PS, Goods) ->
    common_check_use_goods(PS, Goods, 1).

common_check_use_goods(PS, Goods, UseCount) ->
    ?ASSERT(is_record(Goods, goods), Goods),

    GoodsTpl = lib_goods:get_tpl_data(Goods#goods.no),

    % 等级是否足够？
    ?Ifc (player:get_lv(PS) < lib_goods:get_lv(Goods)) 
        throw(?PM_LV_LIMIT)
    ?End,

    % 种族是否相符？
    Race = lib_goods:get_race(GoodsTpl),
    ?Ifc (Race /= ?RACE_NONE andalso player:get_race(PS) /= Race)
        throw(?PM_RACE_LIMIT)
    ?End,

    % 门派是否相符？
    Faction = lib_goods:get_faction(GoodsTpl),
    ?Ifc (Faction /= ?FACTION_NONE andalso player:get_faction(PS) /= Faction andalso player:get_lv(PS) >= ?USE_GOODS_CHECK_FACTION_LV )
        throw(?PM_FACTION_LIMIT)
    ?End,

    % vip等级是否符合？
    ?Ifc (player:get_vip_lv(PS) < lib_goods:get_vip_lv(GoodsTpl))
        throw(?PM_VIP_LV_LIMIT)
    ?End,

    % 性别是否相符
    Sex = lib_goods:get_sex(GoodsTpl),
    ?Ifc (Sex /= ?SEX_NONE andalso player:get_sex(PS) /= Sex)
        throw(?PM_SEX_LIMIT)
    ?End,

    ?Ifc (lib_goods:is_in_timekeeping(Goods) andalso lib_goods:is_expired(Goods))
        throw(?PM_GOODS_INVALID)
    ?End,
    
    ?Ifc (lib_goods:get_count(Goods) < UseCount)
        throw(?PM_GOODS_NOT_ENOUGH)
    ?End,
    % TODO: 如有必要，补充其他通用检查。。。
    % ...
    void.

can_goods_trigger_accept_task(PS, Goods) ->
    EffectList = lib_goods:get_effects(Goods),
    F = fun(X) ->
        EffCfg = lib_goods_eff:get_cfg_data(X),
        case EffCfg#goods_eff.name =:= ?EN_ACCEPT_TASK of
            true -> X;
            false -> null
        end
    end,
    EffectList1 = [F(X) || X <- EffectList],
    EffectList2 = [Y || Y <- EffectList1, Y /= null],
    case EffectList2 =:= [] of
        true -> false;
        false ->
            EffCfg1 = lib_goods_eff:get_cfg_data(erlang:hd(EffectList2)),
            Task = EffCfg1#goods_eff.para,
            case is_integer(Task) of
                true ->
                    lib_task:publ_can_item_task_accept(Task, PS);
                false ->
                    can_goods_trigger_accept_task__(PS, Task)
            end
    end.


can_goods_trigger_accept_task__(_PS, []) ->
    false;
can_goods_trigger_accept_task__(PS, [H | T]) ->
    {TaskId, _Prob} = H,
    case lib_task:publ_is_can_accept(TaskId, PS) of
        true -> true;
        false -> can_goods_trigger_accept_task__(PS, T)
    end.

%% 判断 玩家 能否添加指定的效果，如果没有效果则返回true
can_get_goods_effect(PS, Goods, EffectName, UseCount) when is_record(Goods, goods) ->
    EffectList = lib_goods:get_effects(Goods),
    F = fun(X) ->
        EffCfg = lib_goods_eff:get_cfg_data(X),
        case EffCfg#goods_eff.name =:= EffectName of
            true -> X;
            false -> null
        end
    end,
    EffectList1 = [F(X) || X <- EffectList],
    EffectList2 = [Y || Y <- EffectList1, Y /= null],
    can_get_goods_effect(PS, EffectList2, UseCount, Goods);


can_get_goods_effect(_PS, [], _, _) ->
    true;
can_get_goods_effect(PS, [EffectNo | T], UseCount, Goods) ->
    EffCfg = lib_goods_eff:get_cfg_data(EffectNo),
    case EffCfg#goods_eff.name of
        ?EN_GET_REWARD ->
            ?ASSERT(UseCount =:= 1, UseCount),
            case lib_reward:check_bag_space(PS, EffCfg#goods_eff.para) of
                ok ->
                    can_get_goods_effect(PS, T, UseCount, Goods);
                {fail, _} ->
                    false
            end;
        ?EN_FINISH_TASK ->
            ?ASSERT(is_tuple(EffCfg#goods_eff.para)),
            ?ASSERT(UseCount =:= 1, UseCount),
            {_TaskId, SceneNo, AreaNo} = EffCfg#goods_eff.para,
            {X, Y} = player:get_xy(PS),
            PlayerSceneNo = player:get_scene_no(PS),
            {_AreaNoNeed, XNeed, YNeed, W, H} = lib_task:get_explore_area(SceneNo, AreaNo),
            case lib_task:is_in_same_range({SceneNo, XNeed, YNeed, W, H}, {PlayerSceneNo, X, Y}) of
                true ->
                    can_get_goods_effect(PS, T, UseCount, Goods);
                false ->
                    false
            end;
        ?EN_GET_PARTNER ->
            ?ASSERT(UseCount =:= 1, UseCount),
            case ply_partner:check_player_add_partner(PS, EffCfg#goods_eff.para) of
                ok -> 
                    can_get_goods_effect(PS, T, UseCount, Goods);
                {fail, _Reason} -> 
                    false
            end;
        ?EN_GET_MOUNTS ->
            ?ASSERT(UseCount =:= 1, UseCount),
            case lib_mount:check_player_add_mount(PS, EffCfg#goods_eff.para) of
                {fail,_} -> false;
                ok -> can_get_goods_effect(PS, T, UseCount, Goods)
            end;
        ?EN_RAND_GET_PAR ->
            ?ASSERT(UseCount =:= 1, UseCount),
            case ply_partner:check_player_add_partner(PS) of
                ok -> 
                    can_get_goods_effect(PS, T, UseCount, Goods);
                {fail, _Reason} -> 
                    false
            end;
        ?EN_ADD_WING ->
            ?ASSERT(UseCount =:= 1, UseCount),
            case lib_wing:check_player_add_wing(player:get_id(PS), EffCfg#goods_eff.para) of
                ok ->
                    can_get_goods_effect(PS, T, UseCount, Goods);
                {fail, _Reason} ->
                    false
            end;
        ?EN_ADD_HP ->
            case player:get_hp(PS) + EffCfg#goods_eff.para * UseCount > player:get_hp_lim(PS) of
                false ->
                    can_get_goods_effect(PS, T, UseCount, Goods);
                true ->
                    false
            end;
        ?EN_ADD_MP ->
            case player:get_mp(PS) + EffCfg#goods_eff.para * UseCount > player:get_mp_lim(PS) of
                false ->
                    can_get_goods_effect(PS, T, UseCount, Goods);
                true ->
                    false
            end;
        ?EN_ADD_HP_MP ->
            case (player:get_mp(PS) + EffCfg#goods_eff.para * UseCount > player:get_mp_lim(PS)) 
                orelse (player:get_hp(PS) + EffCfg#goods_eff.para * UseCount > player:get_hp_lim(PS)) of
                false ->
                    can_get_goods_effect(PS, T, UseCount, Goods);
                true ->
                    false
            end;
        ?EN_REVIVE_AND_ADD_HP ->
            case player:get_hp(PS) + EffCfg#goods_eff.para * UseCount > player:get_hp_lim(PS) of
                false ->
                    can_get_goods_effect(PS, T, UseCount, Goods);
                true ->
                    false
            end;
        ?EN_REVIVE_AND_ADD_HP_MP ->
            case (player:get_mp(PS) + EffCfg#goods_eff.para * UseCount > player:get_mp_lim(PS)) 
                orelse (player:get_hp(PS) + EffCfg#goods_eff.para * UseCount > player:get_hp_lim(PS)) of
                false ->
                    can_get_goods_effect(PS, T, UseCount, Goods);
                true ->
                    false
            end;
        ?EN_RAND_GET_GOODS ->
            ?ASSERT(UseCount =:= 1, UseCount),
            {EquipCount, UsCount, UnUsCount} = get_prob_diff_type_goods_tpl_count(EffCfg#goods_eff.para),
            case mod_inv:calc_empty_slots(player:id(PS), ?LOC_BAG_EQ) >= EquipCount andalso mod_inv:calc_empty_slots(player:id(PS), ?LOC_BAG_USABLE) >= UsCount  andalso
            mod_inv:calc_empty_slots(player:id(PS), ?LOC_BAG_UNUSABLE) >= UnUsCount of
                true ->
                    can_get_goods_effect(PS, T, UseCount, Goods);
                false ->
                    false
            end;
        ?EN_ADD_BUFF ->
            BuffNo = EffCfg#goods_eff.para,
            ?ASSERT(UseCount =:= 1, UseCount),
            case lib_buff:is_max_overlap(player:id(PS), BuffNo) of
                true -> false;
                false -> can_get_goods_effect(PS, T, UseCount, Goods)
            end;
        ?EN_EXTEND_PAR_CAPACITY ->
            case ply_partner:check_open_carry_partner_num(PS, EffCfg#goods_eff.para * UseCount) of
                ok -> can_get_goods_effect(PS, T, UseCount, Goods);
                {fail, _} -> false
            end;
        ?EN_TRIGGER_DIG_TREASURE -> %% 目前只判断挖宝区域 场景
            % {X, Y} = player:get_xy(PS),
            PlayerSceneNo = player:get_scene_no(PS),
            case lib_goods:get_extra(Goods, dig_treasure) of
                null -> false;
                {dig_treasure, {SceneNo, _X, _Y}} ->
                    case PlayerSceneNo =:= SceneNo of
                        true ->
                            can_get_goods_effect(PS, T, UseCount, Goods);
                        false ->
                            false
                    end
            end;
        ?EN_SPAWN_MON -> %% 目前只判断挖宝区域 场景
            % {X, Y} = player:get_xy(PS),
            PlayerSceneNo = player:get_scene_no(PS),
            case lib_goods:get_extra(Goods, dig_treasure) of
                null -> false;
                {dig_treasure, {SceneNo, _X, _Y}} ->
                    case PlayerSceneNo =:= SceneNo of
                        true ->
                            can_get_goods_effect(PS, T, UseCount, Goods);
                        false ->
                            false
                    end
            end;
        ?EN_MARK_FINISH_TASK ->
            List = lib_task:get_accepted_list(),
            case check_finish_task(List, EffCfg#goods_eff.para) of
                false -> false;
                true ->
                    can_get_goods_effect(PS, T, UseCount, Goods)
            end;
        _Any ->
            can_get_goods_effect(PS, T, UseCount, Goods)
    end.


%% 通知客户端：物品信息更改了
%% 注：简单起见，实现方法就是重新发送物品的详细信息给客户端
notify_cli_goods_info_change(PlayerId, Goods_Latest) ->
    ?ASSERT(is_record(Goods_Latest, goods)),
    case player:get_PS(PlayerId) of
        null -> skip;
        PS ->
            {ok, BinData} = pt_15:write(?PT_GET_GOODS_DETAIL, Goods_Latest),
            lib_send:send_to_sock(PS, BinData)
    end.


%% 玩家获得物品（到背包）后，通知客户端
notify_cli_goods_added_to_bag(PlayerId, GoodsAdded) ->
    notify_cli_goods_added(PlayerId, GoodsAdded).
    
notify_cli_goods_added(PlayerId, GoodsAdded) ->
    {ok, BinData} = pt_15:write(?PT_NOTIFY_INV_GOODS_ADDED, GoodsAdded),
    case player:get_PS(PlayerId) of
        null -> skip;
        PS -> lib_send:send_to_sock(PS, BinData)
    end.

% %% 玩家批量获得物品（到背包）后，通知客户端
% notify_cli_goods_batch_added_to_bag(PlayerId, GoodsList) ->
%     [notify_cli_goods_added_to_bag(PlayerId, Goods) || Goods <- GoodsList].



%% 通知客户端：背包中的物品被销毁了
%% @para: GoodsId => 被销毁的物品唯一id
notify_cli_goods_destroyed_from_bag(PlayerId, GoodsId, Location) ->
    notify_cli_goods_destroyed(PlayerId, GoodsId, Location).




%% 通知客户端：背包或仓库中的物品被销毁了
%% @para: GoodsId => 被销毁的物品唯一id
%%        Location => 被销毁的物品的所在地
notify_cli_goods_destroyed(PlayerId, GoodsId, Location) ->
    case player:get_PS(PlayerId) of
        null -> skip;
        PS ->    
            {ok, BinData} = pt_15:write(?PT_NOTIFY_INV_GOODS_DESTROYED, [GoodsId, Location]),
            lib_send:send_to_sock(PS, BinData)
    end.

%% 获取不同类别的物品数，类别指按背包分类的类别：装备 物品 材料
%% return {Count1, Count2, Count3} 因为是随机获得一个物品，所以大于1的，就返回1
get_prob_diff_type_goods_tpl_count(GoodsNoProbList) ->
    F = fun({GoodsNo, _}, Acc) ->
        [lib_goods:get_tpl_data(GoodsNo) | Acc]
    end,
    GoodsTplList = lists:foldl(F, [], GoodsNoProbList),
    {get_prob_diff_type_goods_tpl__(GoodsTplList, ?LOC_BAG_EQ), get_prob_diff_type_goods_tpl__(GoodsTplList, ?LOC_BAG_USABLE)
        ,get_prob_diff_type_goods_tpl__(GoodsTplList, ?LOC_BAG_UNUSABLE)}.


get_prob_diff_type_goods_tpl__(GoodsTplList, Location) ->
    F = fun(GoodsTpl, Acc) ->
        case lib_goods:decide_bag_location(GoodsTpl) =:= Location of
            true -> [GoodsTpl | Acc];
            false -> Acc
        end
    end,
    List = lists:foldl(F, [], GoodsTplList),
    case length(List) > 0 of
        true -> 1;
        false -> 0
    end.

check_finish_task([], _) ->
    false;
check_finish_task([H | T], CfgTaskIdL) ->
    case lists:member(H, CfgTaskIdL) of
        true -> true;
        false -> check_finish_task(T, CfgTaskIdL)
    end.