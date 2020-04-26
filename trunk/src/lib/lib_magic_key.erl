%%%--------------------------------------
%%% @Module  : lib_magic_key
%%% @Author  : zhangwq
%%% @Email   :
%%% @Created : 2015.3.17
%%% @Description : 玩家的法宝相关操作
%%%
%%%--------------------------------------
-module(lib_magic_key).

-include("debug.hrl").
-include("inventory.hrl").
-include("goods.hrl").
-include("record.hrl").
-include("prompt_msg_code.hrl").
-include("record/goods_record.hrl").
-include("abbreviate.hrl").
-include("obj_info_code.hrl").
-include("log.hrl").
-include("num_limits.hrl").

-export([
        upgrade_skill_lv/3,
        xilian/3,
        stren_magic_key/3
    ]).




upgrade_skill_lv(PS, GoodsId, SkillId) ->
    case check_upgrade_skill_lv(PS, GoodsId, SkillId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods} ->
            do_upgrade_skill_lv(PS, Goods, SkillId)
    end.


xilian(PS, GoodsId, IdList) ->
    case check_xilian(PS, GoodsId, IdList) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods, CostMoney, CostGoodsL} ->
            do_xilian(PS, Goods, IdList, CostMoney, CostGoodsL)
    end.


stren_magic_key(PS, GoodsId, IdList) ->
    case check_stren_magic_key(PS, GoodsId, IdList) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods, GetExp, MoneyList} ->
            do_stren_magic_key(PS, Goods, IdList, GetExp, MoneyList)
    end.    



%% --------------------------------------------local------------------------------------------------------   


check_upgrade_skill_lv(PS, GoodsId, SkillId) ->
    try 
        check_upgrade_skill_lv__(PS, GoodsId, SkillId)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_upgrade_skill_lv__(PS, GoodsId, SkillId) ->
    ?Ifc (GoodsId =< 0)
        ?DEBUG_MSG("lib_magic_key:check_upgrade_skill_lv__:~p~n", [GoodsId]),
        throw(?PM_PARA_ERROR)
    ?End,

    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (not lib_goods:is_magic_key(Goods))
        ?DEBUG_MSG("lib_magic_key:check_upgrade_skill_lv__:~w~n", [Goods]),
        throw(?PM_PARA_ERROR)
    ?End,

    DataSkillCfg = data_skill:get(SkillId),
    ?Ifc (DataSkillCfg =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    DataCfg = data_mk_skill_up:get(SkillId),
    ?Ifc (DataCfg =:= null)
        throw(?PM_MK_SKILL_LV_LIMIT)
    ?End,

    ?Ifc (DataCfg#mk_skill_up_cfg.next_id =:= ?INVALID_NO)
        throw(?PM_MK_SKILL_LV_LIMIT)
    ?End,

    DataSkillCfg1 = data_skill:get(DataCfg#mk_skill_up_cfg.next_id),
    ?Ifc (DataSkillCfg1 =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    Quality = lib_goods:get_quality(Goods),
    ?Ifc (Quality < DataCfg#mk_skill_up_cfg.quality_need)
        throw(?PM_MK_QUALITY_LIMIT)
    ?End,

    ?Ifc (player:get_exp(PS) < DataCfg#mk_skill_up_cfg.consume_role_exp)
        throw(?PM_EXP_LIMIT)
    ?End,

    ?Ifc (not lists:member(SkillId, lib_goods:get_mk_skill_list(Goods)))
        ?DEBUG_MSG("lib_magic_key:check_upgrade_skill_lv__:SkillId:~p SkillIdL:~w~n", [SkillId, lib_goods:get_mk_skill_list(Goods)]),
        throw(?PM_PARA_ERROR)
    ?End,
    {ok, Goods}.


do_upgrade_skill_lv(PS, Goods, SkillId) ->
    DataCfg = data_mk_skill_up:get(SkillId),
    player:cost_exp(PS, DataCfg#mk_skill_up_cfg.consume_role_exp, [?LOG_EQUIP, "skill_up"]),

    F = fun(Id, Acc) ->
        case Id =:= SkillId of
            true -> Acc ++ [DataCfg#mk_skill_up_cfg.next_id];
            false -> Acc ++ [Id]
        end
    end,

    Goods1 = lib_goods:set_mk_skill_list(Goods, lists:foldl(F, [], lib_goods:get_mk_skill_list(Goods))),
    Goods2 = lib_goods:set_bind_state(Goods1, ?BIND_ALREADY),
    mod_inv:mark_dirty_flag(player:get_id(PS), Goods2),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods2),

    case mod_equip:is_equip_put_on(player:get_id(PS), lib_goods:get_id(Goods2)) andalso mod_skill:is_passive(SkillId) of
        true -> %% 改变相关属性
            ply_attr:recount_equip_add_and_total_attrs(PS);
        false ->
            skip
    end,

    {ok, DataCfg#mk_skill_up_cfg.next_id}.



check_xilian(PS, GoodsId, IdList) ->
    try
        check_xilian__(PS, GoodsId, IdList)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_xilian__(PS, GoodsId, IdList) ->
    ?Ifc (GoodsId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (not lib_goods:is_magic_key(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    SkillIdL = lib_goods:get_mk_skill_list(Goods),
    F = fun(Id, Sum) ->
        case lists:member(Id, SkillIdL) of
            true -> Sum;
            false -> Sum + 1
        end
    end,

    ?Ifc (lists:foldl(F, 0, IdList) =/= 0)
        throw(?PM_PARA_ERROR)
    ?End,

    DataCfg = data_mk_relate:get(lib_goods:get_no(Goods)),
    ?Ifc (DataCfg =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,
    LockSkillCnt = length(IdList),
    CostMoney = [{Type, util:ceil(Count* math:pow(DataCfg#mk_relate_cfg.need_money_ratio, LockSkillCnt))} || {Type, Count} <- DataCfg#mk_relate_cfg.need_money],
    RetMoney = lib_couple:check_money(PS, CostMoney),

    ?Ifc (RetMoney =/= 0)
        throw(RetMoney)
    ?End,

    CostGoodsL = [{No, util:ceil(Count*math:pow(DataCfg#mk_relate_cfg.need_goods_ratio, LockSkillCnt))} || {No, Count} <- DataCfg#mk_relate_cfg.need_goods],
    case mod_inv:check_batch_destroy_goods(PS, CostGoodsL) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            {ok, Goods, CostMoney, CostGoodsL}
    end.


do_xilian(PS, Goods, IdList, MoneyList, CostGoodsL) ->
    lib_comm:cost_money_now(PS, MoneyList, [?LOG_EQUIP, "magic_key_xilian"]),
    mod_inv:destroy_goods_WNC(PS, CostGoodsL, [?LOG_EQUIP, "magic_key_xilian"]),
    
    F = fun(Id, Acc) ->
        case mod_skill:is_passive(Id) of
            true -> Acc;
            false -> [Id | Acc]
        end
    end,

    F1 = fun(Id, Acc) ->
        case mod_skill:is_passive(Id) of
            true -> [Id | Acc];
            false -> Acc
        end
    end,

    OldL = lib_goods:get_mk_skill_list(Goods),
    LockL1 = lists:foldl(F1, [], lib_goods:get_mk_skill_list(Goods)),
    LockL2 = lists:foldl(F, [], IdList),

    {L1, L2} = lib_goods:mk_magic_key_skill_list(lib_goods:get_no(Goods), lib_goods:get_quality(Goods), LockL1, LockL2, true),

    L3 = 
        case LockL2 =:= [] of
            true -> L2;
            false ->
                IdPosL = [{Id, get_pos_by_id(Id, OldL--LockL1)} || Id <- LockL2],
                ?DEBUG_MSG("do_xilian(), IdPosL=~w~n", [IdPosL]),
                adjust_pos(IdPosL, L2)
        end,

    ?DEBUG_MSG("do_xilian(), OldL=~w, NewL=~w, {L1, L2, L3}=~w, {LockL1, LockL2}=~w~n", [OldL, L1 ++ L3, {L1, L2, L3}, {LockL1, LockL2}]),

    Goods1 = lib_goods:set_mk_skill_list(Goods, L1 ++ L3),
    Goods2 = lib_goods:set_bind_state(Goods1, ?BIND_ALREADY),
    mod_inv:mark_dirty_flag(player:get_id(PS), Goods2),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods2),

    case mod_equip:is_equip_put_on(player:get_id(PS), lib_goods:get_id(Goods2)) of
        true -> %% 改变相关属性
            ply_attr:recount_equip_add_and_total_attrs(PS);
        false ->
            skip
    end,
    ok.

%% 调整位置，使客户端洗练的时候，锁定的位置不变
adjust_pos([], _L) ->
    _L;
adjust_pos(IdPosL, L) ->
    adjust_pos(IdPosL, L, 1, []).

adjust_pos(_IdPosL, L, Index, RetL) when Index > length(L) ->
    RetL;
adjust_pos(IdPosL, L, Index, RetL) ->
    NewRetL = 
        case lists:keyfind(Index, 2, IdPosL) of
            false -> 
                RetL ++ get_one_except(L, IdPosL, RetL);
            {Id, _} ->
                 RetL ++ [Id]
        end,
    adjust_pos(IdPosL, L, Index+1, NewRetL).

%% 在L中随机中一个，要求这个元素不在IdPosL中
%% return [Id] | []
get_one_except(L, IdPosL, RetL) ->
    ExceptL = [Id || {Id, _} <- IdPosL],
    get_one_except__(L, ExceptL, RetL).

get_one_except__([], _ExceptL, _RetL) ->
    [];
get_one_except__([H | T], ExceptL, RetL) ->
    case lists:member(H, ExceptL) of
        true -> get_one_except__(T, ExceptL, RetL);
        false -> 
            case lists:member(H, RetL) of
                false -> [H];
                true -> get_one_except__(T, ExceptL, RetL)
            end
    end.

get_pos_by_id(_Id, []) ->
    ?INVALID_NO;
get_pos_by_id(Id, L) ->
    get_pos_by_id(Id, L, 1).

get_pos_by_id(Id, L, Index) ->
    case Index > length(L) of
        true -> ?INVALID_NO;
        false ->
            case lists:nth(Index, L) =:= Id of
                true -> Index;
                false -> get_pos_by_id(Id, L, Index + 1)
            end
    end.

check_stren_magic_key(PS, GoodsId, IdList) ->
    try
        check_stren_magic_key__(PS, GoodsId, IdList)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_stren_magic_key__(PS, GoodsId, IdList) ->
    ?Ifc (GoodsId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (not lib_goods:is_magic_key(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    F = fun(Id, Acc) ->
        case mod_inv:find_goods_by_id_from_bag(player:get_id(PS), Id) of
            null -> Acc;
            TGoods -> [TGoods | Acc]
        end
    end,

    CostGoodsL = lists:foldl(F, [], IdList),
    ?Ifc (length(CostGoodsL) =/= length(IdList))
        throw(?PM_PARA_ERROR)
    ?End,

    CfgList = data_mk_stren:get(lib_goods:get_no(Goods)),
    ?Ifc (CfgList =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    TData = lists:last(CfgList),
    ?Ifc (lib_goods:get_quality(Goods) >= TData#mk_stren_cfg.quality andalso lib_goods:get_quality_lv(Goods) >= TData#mk_stren_cfg.layer)
        throw(?PM_GOODS_QUALITY_MAX)
    ?End,

    F1 = fun(G, Sum) ->
        get_exp_support(G) + Sum
    end,

    GetExp = util:ceil(lists:foldl(F1, 0, CostGoodsL)*0.7),


    MoneyList = [{Type, util:ceil(Coef*GetExp)} || {Type, Coef} <- TData#mk_stren_cfg.need_money],

    RetMoney = lib_couple:check_money(PS, MoneyList),

    ?Ifc (RetMoney =/= 0)
        throw(RetMoney)
    ?End,

    {ok, Goods, GetExp, MoneyList}.



get_exp_support(Goods) ->
    GoodsNo = lib_goods:get_no(Goods), 
    Quality = lib_goods:get_quality(Goods), 
    Layer = lib_goods:get_quality_lv(Goods),

    CfgList = data_mk_stren:get(GoodsNo),
    EndIndex = decide_start_index(Quality, Layer, CfgList),
    F = fun(Index, Sum) ->
        Data = lists:nth(Index, CfgList),
        Data#mk_stren_cfg.exp_need + Sum
    end,
    lists:foldl(F, 0, lists:seq(1, EndIndex)) + lib_goods:get_stren_exp(Goods).


do_stren_magic_key(PS, Goods, IdList, GetExp, MoneyList) ->
    lib_comm:cost_money_now(PS, MoneyList, [?LOG_EQUIP, "magic_key_stren"]),
    mod_inv:destroy_goods_by_id_WNC(player:id(PS), [{Id, 1} || Id <- IdList], [?LOG_EQUIP, "magic_key_stren"]),

    AllExp = GetExp + lib_goods:get_stren_exp(Goods),

    CfgList = data_mk_stren:get(lib_goods:get_no(Goods)),
    StartIndex = decide_start_index(lib_goods:get_quality(Goods), lib_goods:get_quality_lv(Goods), CfgList),
    {NewQuality, NewLayer, LeftExp} = decide_quality_and_layer(StartIndex, length(CfgList), AllExp, CfgList),
    
    ?DEBUG_MSG("do_stren_magic_key(), {AllExp, LeftExp}=~w~n", [{AllExp, LeftExp}]),
    Goods1 = lib_goods:set_quality(Goods, NewQuality),
    Goods2 = lib_goods:set_quality_lv(Goods1, NewLayer),
    Goods3 = lib_goods:set_stren_exp(Goods2, util:ceil(LeftExp)),
    Goods4 = lib_goods:set_bind_state(Goods3, ?BIND_ALREADY),

    Goods5 = 
        case NewQuality =:= lib_goods:get_quality(Goods) of
            true -> Goods4;
            false ->
                BaseEquipAdd = lib_equip:decide_base_equip_add(lib_goods:get_tpl_data(lib_goods:get_no(Goods4)), NewQuality),
                BaseEquipAdd2 = lib_attribute:to_attrs_record(BaseEquipAdd),
                TGoods5 = lib_goods:set_base_equip_add(Goods4, BaseEquipAdd2),

                F = fun(Id, {Acc1, Acc2}) ->
                    case mod_skill:is_passive(Id) of
                        true -> {[Id | Acc1], Acc2};
                        false -> {Acc1, [Id | Acc2]}
                    end
                end,

                {LockL1, LockL2} = lists:foldl(F, {[], []}, lib_goods:get_mk_skill_list(TGoods5)),

                {L1, L2} = lib_goods:mk_magic_key_skill_list(lib_goods:get_no(TGoods5), lib_goods:get_quality(TGoods5), LockL1, LockL2, false),

                TGoods6 = lib_goods:set_mk_skill_list(TGoods5, L1 ++ L2),
                lib_goods:set_battle_power(TGoods6, lib_equip:recount_battle_power(TGoods6))
        end,

    mod_inv:mark_dirty_flag(player:get_id(PS), Goods5),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods5),

    case mod_equip:is_equip_put_on(player:get_id(PS), lib_goods:get_id(Goods5)) andalso (NewQuality =/= lib_goods:get_quality(Goods5)) of
        true -> %% 改变相关属性
            ply_attr:recount_equip_add_and_total_attrs(PS);
        false ->
            skip
    end,

    ok.


decide_start_index(_Quality, _Layer, []) ->
    ?ASSERT(false, {_Quality, _Layer}),
    ?INVALID_NO + 1;
decide_start_index(Quality, Layer, CfgList) ->
    decide_start_index(Quality, Layer, CfgList, 1, length(CfgList)).


decide_start_index(_Quality, _Layer, [], Index, _) ->
    Index;
decide_start_index(Quality, Layer, CfgList, Index, EndIndex) ->
    case Index >= EndIndex of
        true -> Index;
        false ->
            DataCfg = lists:nth(Index, CfgList),
            case Quality =:= DataCfg#mk_stren_cfg.quality andalso DataCfg#mk_stren_cfg.layer =:= Layer of
                true -> Index;
                false -> decide_start_index(Quality, Layer, CfgList, Index + 1, EndIndex)
            end
    end.

decide_quality_and_layer(CurIndex, LastIndex, Exp, CfgList) ->
    case CurIndex >= LastIndex of
        true -> 
            DataCfg = lists:nth(CurIndex, CfgList),
            {DataCfg#mk_stren_cfg.quality, DataCfg#mk_stren_cfg.layer, Exp};
        false ->
            Data1 = lists:nth(CurIndex, CfgList),
            Data2 = lists:nth(CurIndex+1, CfgList),
            case Exp < Data2#mk_stren_cfg.exp_need of
                true -> {Data1#mk_stren_cfg.quality, Data1#mk_stren_cfg.layer, Exp};
                false -> decide_quality_and_layer(CurIndex + 1, LastIndex, Exp - Data2#mk_stren_cfg.exp_need, CfgList)
            end
    end.