%%%-------------------------------------- 
%%% @Module: lib_bt_goods
%%% @Author: huangjf
%%% @Created: 2014.1.17
%%% @Description: 战斗中与使用物品相关的业务逻辑
%%%-------------------------------------- 
-module(lib_bt_goods).
-export([
        check_use_goods_on_bo/3,
        use_goods_on_bo/3
    ]).
    
-include("common.hrl").
% -include("battle.hrl").
-include("effect.hrl").
-include("goods.hrl").
-include("buff.hrl").
-include("record/battle_record.hrl").

-import(lib_bt_comm, [
            get_bo_by_id/1,
            is_dead/1,
            is_living/1,
            is_player/1,
            is_hired_player/1,
            is_partner/1
            % is_monster/1,
            % to_enemy_side/1
            ]).


%% 检查给目标bo使用物品
%% @return: {ok, Goods} | {fail, null, Reason} | {fail, Goods, Reason}
check_use_goods_on_bo(Actor, GoodsId, TargetBoId) ->
    case lib_bo:is_under_strong_control(Actor) of  % 稳妥起见，这里判断一次行动者是否处于控制状态
        true ->
            {fail, null, is_under_control};
        false ->
            case lib_bt_misc:find_my_owner_player_bo(Actor) of
                null ->
                    ?ASSERT(false, Actor),
                    {fail, null, unknown_err};
                OwnerPlayerBo ->
                    ?ASSERT(is_record(OwnerPlayerBo, battle_obj)),
                    ?ASSERT(is_player(OwnerPlayerBo)),
                    ?ASSERT(not is_hired_player(OwnerPlayerBo)),

                    % 是否有这个物品？
                    case has_usable_goods(OwnerPlayerBo, GoodsId) of
                        false ->
                            {fail, null, no_such_goods};
                        {true, Goods} ->
                            % 目标bo是否存在？
                            case get_bo_by_id(TargetBoId) of
                                null ->
                                    {fail, Goods, target_not_exists};
                                TargetBo ->
                                    case more_check_use_goods_on_bo(Actor, Goods, TargetBo) of
                                        ok ->
                                            {ok, Goods};
                                        {fail, Reason} ->
                                            {fail, Goods, Reason}
                                    end
                            end
                    end
            end
    end.

            


has_usable_goods(PlayerBo, GoodsId) ->
    case lib_bo:get_goods_info(PlayerBo, GoodsId) of
        null ->
            ?ASSERT(false, {GoodsId, PlayerBo}),
            false;
        Info ->
            case Info#bo_goods_info.count > 0 of
                false ->
                    ?BT_LOG(io_lib:format("has_usable_goods(), PlayerBoId:~p, GoodsId:~p, goods count is 0!!~n", [lib_bo:id(PlayerBo), GoodsId])),
                    false;
                true ->
                    % 严格起见，再检测一遍物品栏中是否有此物品
                    PlayerId = lib_bo:get_parent_obj_id(PlayerBo),
                    case mod_inv:find_goods_by_id(PlayerId, GoodsId, ?LOC_BAG_USABLE) of
                        null ->
                            ?ASSERT(false, {GoodsId, PlayerBo}),
                            false;
                        Goods ->
                            {true, Goods}
                    end
            end
    end.            



    
more_check_use_goods_on_bo(Actor, Goods, TargetBo) ->
    EffNoList = lib_goods:get_effects(Goods),
    check_goods_effs_when_use_goods_on_bo(EffNoList, Actor, Goods, TargetBo, unknown_err).


check_goods_effs_when_use_goods_on_bo([], _Actor, _Goods, _TargetBo, LastFailReason) ->
    {fail, LastFailReason};
check_goods_effs_when_use_goods_on_bo([GoodsEffNo | T], Actor, Goods, TargetBo, _LastFailReason) ->
    Eff = lib_goods_eff:get_cfg_data(GoodsEffNo),
    ?ASSERT(Eff /= null, {GoodsEffNo, Goods}),
    case check_goods_one_eff_when_use_goods_on_bo(Eff#goods_eff.name, Eff, Actor, Goods, TargetBo) of
        ok ->
            ok;
        {fail, Reason} ->
            check_goods_effs_when_use_goods_on_bo(T, Actor, Goods, TargetBo, Reason)
    end.



    
check_goods_one_eff_when_use_goods_on_bo(?EN_ADD_HP, _Eff, _Actor, _Goods, TargetBo) ->
    case can_add_hp_to(TargetBo) of
        {false, Reason} ->
            {fail, Reason};
        true ->
            ok
    end;

check_goods_one_eff_when_use_goods_on_bo(?EN_ADD_MP, _Eff, _Actor, _Goods, TargetBo) ->
    case can_add_mp_to(TargetBo) of
        {false, Reason} ->
            {fail, Reason};
        true ->
            ok
    end;

check_goods_one_eff_when_use_goods_on_bo(?EN_ADD_ANGER, _Eff, _Actor, _Goods, TargetBo) ->
    case can_add_anger_to(TargetBo) of
        {false, Reason} ->
            {fail, Reason};
        true ->
            ok
    end;

check_goods_one_eff_when_use_goods_on_bo(?EN_ADD_HP_MP, _Eff, _Actor, _Goods, TargetBo) ->
    case can_add_hp_mp_to(TargetBo) of
        {false, Reason} ->
            {fail, Reason};
        true ->
            ok
    end;

check_goods_one_eff_when_use_goods_on_bo(?EN_REVIVE_AND_ADD_HP, _Eff, _Actor, _Goods, TargetBo) ->
    case can_revive_and_add_hp_to(TargetBo) of
        {false, Reason} ->
            {fail, Reason};
        true ->
            ok
    end;

check_goods_one_eff_when_use_goods_on_bo(?EN_REVIVE_AND_ADD_HP_MP, _Eff, _Actor, _Goods, TargetBo) ->
    case can_revive_and_add_hp_mp_to(TargetBo) of
        {false, Reason} ->
            {fail, Reason};
        true ->
            ok
    end;
    

check_goods_one_eff_when_use_goods_on_bo(?EN_ADD_HP_BY_QUALITY, _Eff, _Actor, _Goods, TargetBo) ->
    case can_add_hp_to(TargetBo) of
        {false, Reason} ->
            {fail, Reason};
        true ->
            ok
    end;

check_goods_one_eff_when_use_goods_on_bo(?EN_ADD_MP_BY_QUALITY, _Eff, _Actor, _Goods, TargetBo) ->
    case can_add_mp_to(TargetBo) of
        {false, Reason} ->
            {fail, Reason};
        true ->
            ok
    end;
    
check_goods_one_eff_when_use_goods_on_bo(?EN_REVIVE_AND_ADD_HP_BY_QUALITY, _Eff, _Actor, _Goods, TargetBo) ->
    case can_revive_and_add_hp_to(TargetBo) of
        {false, Reason} ->
            {fail, Reason};
        true ->
            ok
    end;

check_goods_one_eff_when_use_goods_on_bo(?EN_CLEARANCE_AND_ADD_HP_BY_QUALITY, _Eff, _Actor, _Goods, TargetBo) ->
    case can_add_hp_to(TargetBo) of
        {false, Reason} ->
            {fail, Reason};
        true ->
            ok
    end;
    

check_goods_one_eff_when_use_goods_on_bo(_EffName, _Eff, _Actor, _Goods, _TargetBo) ->
    ?ASSERT(false, {_Eff, _Goods}),
    ?ERROR_MSG("[lib_bt_goods] check_goods_one_eff_when_use_goods_on_bo() error!! Eff:~w, Goods:~w", [_Eff, _Goods]),
    {fail, unknown_err}.
    




%% 给目标使用物品
%% @return: do_nothing | {ok, use_goods_dtl结构体}
use_goods_on_bo(Actor, Goods, TargetBoId) ->
    ?ASSERT(lib_bt_comm:is_bo_exists(TargetBoId)),
    EffNoList = lib_goods:get_effects(Goods),

    F = fun(EffNo) ->
        Eff = lib_goods_eff:get_cfg_data(EffNo),
        ?ASSERT(Eff /= null, {EffNo, Goods}),
        use_goods_on_bo_with_one_eff(Eff#goods_eff.name, Eff, Actor, Goods, TargetBoId)
    end,

    UseGoodsDtlList = [F(X) || X <- EffNoList],
    UseGoodsDtlList2 = [X || X <- UseGoodsDtlList, X /= invalid],

    % 是否有隐身BUFF 有的话移除
    InvisibleBuffRemove = case lib_bo:find_buff_by_name(Actor, ?BFN_INVISIBLE) of
        null -> [];
        ShieldBuff ->
            BuffNo = lib_bo_buff:get_no(ShieldBuff),
            lib_bo:remove_buff(lib_bo:get_id(Actor), ShieldBuff),
            [BuffNo]
    end,

    DtlInvisibleBuffRemove = #use_goods_dtl{ 
        goods_id = lib_goods:get_id(Goods),
        goods_no = lib_goods:get_no(Goods),
        target_bo_id = TargetBoId,
        buffs_removed_myself = InvisibleBuffRemove
    },

    UseGoodsDtlList3 = UseGoodsDtlList2,% ++ DtlInvisibleBuffRemove,

    case UseGoodsDtlList3 of
        [] ->
            do_nothing;
        _ ->
            RetDtl = combine_use_goods_details_list(UseGoodsDtlList3),
            RetDtl3 = combine_two_use_goods_details(RetDtl,DtlInvisibleBuffRemove),

            TargetBo_Latest = get_bo_by_id(TargetBoId),
            RetDtl2 = RetDtl3#use_goods_dtl{
                                hp_new = lib_bo:get_hp(TargetBo_Latest),
                                mp_new = lib_bo:get_mp(TargetBo_Latest),
                                anger_new = lib_bo:get_anger(TargetBo_Latest)
                                },
            {ok, RetDtl2}
    end.

            
    

%% 注：统一不检查效果的触发概率，固定认为必定会触发
%% @return: invalid | use_goods_dtl结构体
use_goods_on_bo_with_one_eff(?EN_ADD_HP, Eff, _Actor, Goods, TargetBoId) ->
    TargetBo = get_bo_by_id(TargetBoId),
    ?ASSERT(TargetBo /= null),
    case can_add_hp_to(TargetBo) of
        {false, _Reason} ->
            invalid;
        true ->
            AddVal = Eff#goods_eff.para,
            ?ASSERT(util:is_positive_int(AddVal), Eff),
            TargetBo2 = lib_bo:add_hp(TargetBoId, AddVal),

            RealAddedVal = lib_bo:get_hp(TargetBo2) - lib_bo:get_hp(TargetBo),
            #use_goods_dtl{
                goods_id = lib_goods:get_id(Goods),
                goods_no = lib_goods:get_no(Goods),
                target_bo_id = TargetBoId,
                % eff_type = to_goods_eff_code(?EN_ADD_HP),
                heal_val_hp = AddVal,
                hp_added = RealAddedVal
                }
    end;

use_goods_on_bo_with_one_eff(?EN_ADD_MP, Eff, _Actor, Goods, TargetBoId) ->
    TargetBo = get_bo_by_id(TargetBoId),
    ?ASSERT(TargetBo /= null),
    case can_add_mp_to(TargetBo) of
        {false, _Reason} ->
            invalid;
        true ->
            AddVal = Eff#goods_eff.para,
            ?ASSERT(util:is_positive_int(AddVal), Eff),
            TargetBo2 = lib_bo:add_mp(TargetBoId, AddVal),

            RealAddedVal = lib_bo:get_mp(TargetBo2) - lib_bo:get_mp(TargetBo),
            #use_goods_dtl{
                goods_id = lib_goods:get_id(Goods),
                goods_no = lib_goods:get_no(Goods),
                target_bo_id = TargetBoId,
                % eff_type = to_goods_eff_code(?EN_ADD_MP),
                heal_val_mp = AddVal,
                mp_added = RealAddedVal
                }
    end;

%% @return: invalid | use_goods_dtl结构体
use_goods_on_bo_with_one_eff(?EN_ADD_HP_BY_QUALITY, Eff, _Actor, Goods, TargetBoId) ->
    TargetBo = get_bo_by_id(TargetBoId),
    ?ASSERT(TargetBo /= null),
    case can_add_hp_to(TargetBo) of
        {false, _Reason} ->
            invalid;
        true ->
            {BaseAdd,QualityAdd} = Eff#goods_eff.para,
            AddVal = util:ceil(BaseAdd + (QualityAdd * lib_goods:get_quality_lv(Goods))),

            ?ASSERT(util:is_positive_int(AddVal), Eff),
            TargetBo2 = lib_bo:add_hp(TargetBoId, AddVal),

            RealAddedVal = lib_bo:get_hp(TargetBo2) - lib_bo:get_hp(TargetBo),
            #use_goods_dtl{
                goods_id = lib_goods:get_id(Goods),
                goods_no = lib_goods:get_no(Goods),
                target_bo_id = TargetBoId,
                % eff_type = to_goods_eff_code(?EN_ADD_HP),
                heal_val_hp = AddVal,
                hp_added = RealAddedVal
                }
    end;

% 法力品质药
use_goods_on_bo_with_one_eff(?EN_ADD_MP_BY_QUALITY, Eff, _Actor, Goods, TargetBoId) ->
    TargetBo = get_bo_by_id(TargetBoId),
    ?ASSERT(TargetBo /= null),
    case can_add_mp_to(TargetBo) of
        {false, _Reason} ->
            invalid;
        true ->
            {BaseAdd,QualityAdd} = Eff#goods_eff.para,
            AddVal = util:ceil(BaseAdd + (QualityAdd * lib_goods:get_quality_lv(Goods))),

            ?ASSERT(util:is_positive_int(AddVal), Eff),
            TargetBo2 = lib_bo:add_mp(TargetBoId, AddVal),

            RealAddedVal = lib_bo:get_mp(TargetBo2) - lib_bo:get_mp(TargetBo),
            #use_goods_dtl{
                goods_id = lib_goods:get_id(Goods),
                goods_no = lib_goods:get_no(Goods),
                target_bo_id = TargetBoId,
                % eff_type = to_goods_eff_code(?EN_ADD_MP),
                heal_val_mp = AddVal,
                mp_added = RealAddedVal
                }
    end;

% 复活品质药
use_goods_on_bo_with_one_eff(?EN_REVIVE_AND_ADD_HP_BY_QUALITY, Eff, _Actor, Goods, TargetBoId) ->
    TargetBo = get_bo_by_id(TargetBoId),
    ?ASSERT(TargetBo /= null),
    case can_revive_and_add_hp_to(TargetBo) of
        {false, _Reason} ->
            invalid;
        true ->
            {BaseAdd,QualityAdd} = Eff#goods_eff.para,
            AddVal = util:ceil(BaseAdd + (QualityAdd * lib_goods:get_quality_lv(Goods))),

            ?ASSERT(util:is_positive_int(AddVal), Eff),
            TargetBo2 = lib_bo:add_hp(TargetBoId, AddVal),

            ?ASSERT(is_living(TargetBo2), {AddVal, TargetBo2}),

            % 重置死亡状态为未死亡!
            lib_bo:reset_die_status(TargetBoId),

            RealAddedVal = lib_bo:get_hp(TargetBo2) - lib_bo:get_hp(TargetBo),
            #use_goods_dtl{
                goods_id = lib_goods:get_id(Goods),
                goods_no = lib_goods:get_no(Goods),
                target_bo_id = TargetBoId,
                has_revive_eff = true,  % 带复活效果！
                % eff_type = to_goods_eff_code(?EN_REVIVE_AND_ADD_HP),
                heal_val_hp = AddVal,
                hp_added = RealAddedVal
                }
    end;

% 解控品质药
use_goods_on_bo_with_one_eff(?EN_CLEARANCE_AND_ADD_HP_BY_QUALITY, Eff, _Actor, Goods, TargetBoId) ->
    TargetBo = get_bo_by_id(TargetBoId),
    ?ASSERT(TargetBo /= null),

    % case can_add_hp_to(TargetBo) of
    %     {false, _Reason} ->
    %         invalid;
    %     true ->
            {BaseAdd,QualityAdd,PurgeBuffRule} = Eff#goods_eff.para,
            {ok, PurgeBuffsDtl} = lib_bo:purge_buff(TargetBoId, PurgeBuffRule),

            AddVal = util:ceil(BaseAdd + (QualityAdd * lib_goods:get_quality_lv(Goods))),

            ?ASSERT(util:is_positive_int(AddVal), Eff),
            TargetBo2 = lib_bo:add_hp(TargetBoId, AddVal),

            RealAddedVal = lib_bo:get_hp(TargetBo2) - lib_bo:get_hp(TargetBo),
            #use_goods_dtl{
                goods_id = lib_goods:get_id(Goods),
                goods_no = lib_goods:get_no(Goods),
                target_bo_id = TargetBoId,
                % eff_type = to_goods_eff_code(?EN_ADD_HP),
                heal_val_hp = AddVal,
                hp_added = RealAddedVal,
                buffs_removed = PurgeBuffsDtl#purge_buffs_dtl.defer_buffs_removed
                };
    % end

use_goods_on_bo_with_one_eff(?EN_ADD_ANGER, Eff, _Actor, Goods, TargetBoId) ->
    TargetBo = get_bo_by_id(TargetBoId),
    ?ASSERT(TargetBo /= null),
    case can_add_anger_to(TargetBo) of
        {false, _Reason} ->
            invalid;
        true ->
            AddVal = Eff#goods_eff.para,
            ?ASSERT(util:is_positive_int(AddVal), Eff),
            TargetBo2 = lib_bo:add_anger(TargetBoId, AddVal),

            RealAddedVal = lib_bo:get_anger(TargetBo2) - lib_bo:get_anger(TargetBo),
            #use_goods_dtl{
                goods_id = lib_goods:get_id(Goods),
                goods_no = lib_goods:get_no(Goods),
                target_bo_id = TargetBoId,
                % eff_type = to_goods_eff_code(?EN_ADD_ANGER),
                heal_val_anger = AddVal,
                anger_added = RealAddedVal
                }
    end;

use_goods_on_bo_with_one_eff(?EN_ADD_HP_MP, Eff, _Actor, Goods, TargetBoId) ->
    TargetBo = get_bo_by_id(TargetBoId),
    ?ASSERT(TargetBo /= null),
    case can_add_hp_mp_to(TargetBo) of
        {false, _Reason} ->
            invalid;
        true ->
            {AddVal_Hp, AddVal_Mp} = Eff#goods_eff.para,
            ?ASSERT(util:is_positive_int(AddVal_Hp), Eff),
            ?ASSERT(util:is_positive_int(AddVal_Mp), Eff),

            TargetBo2 = lib_bo:add_hp(TargetBoId, AddVal_Hp),
            TargetBo3 = lib_bo:add_mp(TargetBoId, AddVal_Mp),

            RealAddedVal_Hp = lib_bo:get_hp(TargetBo2) - lib_bo:get_hp(TargetBo),
            RealAddedVal_Mp = lib_bo:get_mp(TargetBo3) - lib_bo:get_mp(TargetBo),

            #use_goods_dtl{
                goods_id = lib_goods:get_id(Goods),
                goods_no = lib_goods:get_no(Goods),
                target_bo_id = TargetBoId,
                % eff_type = to_goods_eff_code(?EN_ADD_HP_MP),
                heal_val_hp = AddVal_Hp,
                heal_val_mp = AddVal_Mp,

                hp_added = RealAddedVal_Hp,
                mp_added = RealAddedVal_Mp
                }
    end;
    
use_goods_on_bo_with_one_eff(?EN_REVIVE_AND_ADD_HP, Eff, _Actor, Goods, TargetBoId) ->
    TargetBo = get_bo_by_id(TargetBoId),
    ?ASSERT(TargetBo /= null),
    case can_revive_and_add_hp_to(TargetBo) of
        {false, _Reason} ->
            invalid;
        true ->
            AddVal = Eff#goods_eff.para,
            ?ASSERT(util:is_positive_int(AddVal), Eff),
            TargetBo2 = lib_bo:add_hp(TargetBoId, AddVal),

            ?ASSERT(is_living(TargetBo2), {AddVal, TargetBo2}),

            % 重置死亡状态为未死亡!
            lib_bo:reset_die_status(TargetBoId),

            RealAddedVal = lib_bo:get_hp(TargetBo2) - lib_bo:get_hp(TargetBo),
            #use_goods_dtl{
                goods_id = lib_goods:get_id(Goods),
                goods_no = lib_goods:get_no(Goods),
                target_bo_id = TargetBoId,
                % eff_type = to_goods_eff_code(?EN_REVIVE_AND_ADD_HP),
                heal_val_hp = AddVal,
                hp_added = RealAddedVal
                }
    end;

use_goods_on_bo_with_one_eff(?EN_REVIVE_AND_ADD_HP_MP, Eff, _Actor, Goods, TargetBoId) ->
    TargetBo = get_bo_by_id(TargetBoId),
    ?ASSERT(TargetBo /= null),
    case can_revive_and_add_hp_mp_to(TargetBo) of
        {false, _Reason} ->
            invalid;
        true ->
            {AddVal_Hp, AddVal_Mp} = Eff#goods_eff.para,
            ?ASSERT(util:is_positive_int(AddVal_Hp), Eff),
            ?ASSERT(util:is_positive_int(AddVal_Mp), Eff),

            TargetBo2 = lib_bo:add_hp(TargetBoId, AddVal_Hp),
            TargetBo3 = lib_bo:add_mp(TargetBoId, AddVal_Mp),

            ?ASSERT(is_living(TargetBo2), {AddVal_Hp, TargetBo2}),

            % 重置死亡状态为未死亡!
            lib_bo:reset_die_status(TargetBoId),

            RealAddedVal_Hp = lib_bo:get_hp(TargetBo2) - lib_bo:get_hp(TargetBo),
            RealAddedVal_Mp = lib_bo:get_mp(TargetBo3) - lib_bo:get_mp(TargetBo),

            #use_goods_dtl{
                goods_id = lib_goods:get_id(Goods),
                goods_no = lib_goods:get_no(Goods),
                target_bo_id = TargetBoId,
                % eff_type = to_goods_eff_code(?EN_REVIVE_AND_ADD_HP_MP),

                heal_val_hp = AddVal_Hp,
                heal_val_mp = AddVal_Mp,

                hp_added = RealAddedVal_Hp,
                mp_added = RealAddedVal_Mp
                }
    end;

use_goods_on_bo_with_one_eff(_EffName, _Eff, _Actor, _Goods, _TargetBoId) ->
    ?ASSERT(false, _EffName),
    ?ERROR_MSG("[lib_bt_goods] use_goods_on_bo_with_one_eff() error!! Eff:~w, Goods:~w", [_Eff, _Goods]),
    invalid.
    




can_add_hp_to(TargetBo) ->
    case is_dead(TargetBo) of
        true -> {false, target_dead};
        false ->
            case lib_bo:cannot_be_heal(TargetBo) of
                true -> {false, target_cannot_be_heal};
                false ->
                    true
            end
    end.

can_add_mp_to(TargetBo) -> % 逻辑判断等同can_add_hp_to()
    can_add_hp_to(TargetBo).

can_add_anger_to(TargetBo) -> % 逻辑判断等同can_add_hp_to()
    can_add_hp_to(TargetBo).

can_add_hp_mp_to(TargetBo) ->  % 逻辑判断等同can_add_hp_to()
    can_add_hp_to(TargetBo).
    

can_revive_and_add_hp_to(TargetBo) ->
    case lib_bo:cannot_be_heal(TargetBo) of
        true ->
            {false, target_cannot_be_heal};
        false ->
            case is_living(TargetBo) of
                true ->
                    true;
                false ->
                    case lib_bo:in_ghost_status(TargetBo) of
                        true ->
                            case lib_bo:is_soul_shackled(TargetBo) of
                                true ->
                                    {false, target_soul_shackled};
                                false ->
                                    true
                            end;
                        false ->
                            case lib_bo:in_fallen_status(TargetBo) of 
                                true ->
                                    case lib_bo:is_soul_shackled(TargetBo) of
                                        true ->
                                            {false, target_soul_shackled};
                                        false ->
                                            true
                                    end;
                                false ->
                                    ?ASSERT(false, TargetBo),
                                    true
                            end
                    end
            end 
    end.

can_revive_and_add_hp_mp_to(TargetBo) -> % 逻辑判断等同can_revive_and_add_hp_to()
    can_revive_and_add_hp_to(TargetBo).
    






% %% 物品效果类型： 1: 加血，2：加蓝，3：加怒气，4：加血加蓝，5：复活并加血，6：复活并加血加蓝，7：加buff
% to_goods_eff_code(GoodsEffName) ->
%     case GoodsEffName of
%         ?EN_ADD_HP ->
%             1;
%         ?
%     end.
    






%% 多个cast_buffs_dtl结构体的buff相关的字段相加，返回结果
%% @return: cast_buffs_dtl结构体
combine_use_goods_details_list([UseGoodsDtl]) ->
    ?ASSERT(is_record(UseGoodsDtl, use_goods_dtl)),
    UseGoodsDtl;
combine_use_goods_details_list([Dtl1, Dtl2 | T]) ->
    TmpDtl = combine_two_use_goods_details(Dtl1, Dtl2),
    combine_use_goods_details_list([TmpDtl | T]).


combine_two_use_goods_details(Dtl1, Dtl2) ->
    ?ASSERT(Dtl1#use_goods_dtl.goods_id == Dtl2#use_goods_dtl.goods_id),
    ?ASSERT(Dtl1#use_goods_dtl.target_bo_id == Dtl2#use_goods_dtl.target_bo_id),
    #use_goods_dtl{
        goods_id = Dtl1#use_goods_dtl.goods_id,
        goods_no = Dtl1#use_goods_dtl.goods_no,
        target_bo_id = Dtl1#use_goods_dtl.target_bo_id,

        has_revive_eff = Dtl1#use_goods_dtl.has_revive_eff orelse Dtl2#use_goods_dtl.has_revive_eff,

        heal_val_hp = Dtl1#use_goods_dtl.heal_val_hp + Dtl2#use_goods_dtl.heal_val_hp,
        heal_val_mp = Dtl1#use_goods_dtl.heal_val_mp + Dtl2#use_goods_dtl.heal_val_mp,
        heal_val_anger = Dtl1#use_goods_dtl.heal_val_anger + Dtl2#use_goods_dtl.heal_val_anger,

        hp_added = Dtl1#use_goods_dtl.hp_added + Dtl2#use_goods_dtl.hp_added,
        mp_added = Dtl1#use_goods_dtl.mp_added + Dtl2#use_goods_dtl.mp_added,
        anger_added = Dtl1#use_goods_dtl.anger_added + Dtl2#use_goods_dtl.anger_added,

        buffs_added = Dtl1#use_goods_dtl.buffs_added ++ Dtl2#use_goods_dtl.buffs_added,
        buffs_removed = Dtl1#use_goods_dtl.buffs_removed ++ Dtl2#use_goods_dtl.buffs_removed,

        buffs_added_myself = Dtl1#use_goods_dtl.buffs_added_myself ++ Dtl2#use_goods_dtl.buffs_added_myself,
        buffs_removed_myself = Dtl1#use_goods_dtl.buffs_removed_myself ++ Dtl2#use_goods_dtl.buffs_removed_myself

        }.

