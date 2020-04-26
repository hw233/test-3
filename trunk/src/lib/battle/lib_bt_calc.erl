%%%-------------------------------------- 
%%% @Module: lib_bt_calc
%%% @Author: huangjf
%%% @Created: 2013.11.28
%%% @Description: 战斗系统相关的数值计算
%%%-------------------------------------- 
-module(lib_bt_calc).
-export([
        calc_use_skill_cost_hp/2,
        calc_use_skill_cost_mp/2,
        calc_use_skill_cost_anger/2,
        calc_use_skill_cost_gamemoney/2,

        calc_dead_player_count_of_side/1,
        calc_avg_player_lv_of_side/1,

        calc_tmp_rand_act_speed_once/1,

        calc_skill_eff_target_count/2,

        calc_phy_damage/4,
        calc_mag_damage/4,

        calc_poison_damage_duan/4,
        calc_phy_damage_duan/4,
        calc_mag_damage_duan/3,

        calc_heal_value_duan/4,

        % 反弹伤害
        calc_ret_damage/3,
        adjust_damage/2,

        calc_damage_to_mp_on_do_skill_att/2,
        calc_fix_dam_to_mp_on_do_skill_att/2,

        decide_xinfa_lv_of_actor/3,
        
		calc_heal_value/4,

        % calc_reduce_mp_by_xinfa_lv/1,

		calc_buff_lasting_round_on_add/5,
        calc_o2o_battle_guest_attribute_add/2,
        calc_buff_eff_para/3
    ]).
    
-include("common.hrl").
-include("buff.hrl").
-include("record/battle_record.hrl").
-include("attribute.hrl").
-include("effect.hrl").
-include("num_limits.hrl").
-include("abbreviate.hrl").
-include("partner.hrl").
-include("five_elements.hrl").


%% 技能消耗=心法等级（或者女妖和怪物的通常等级）对应的标准值*消耗系数+消耗固定值
calc_use_skill_cost_hp(Bo, CurSklCfg) ->
    CostCoef = mod_skill:get_cost_hp_coef(CurSklCfg),
    XinfaLv = decide_xinfa_lv_of_actor(Bo, CurSklCfg, false),
    ?ASSERT(XinfaLv > 0, {CurSklCfg, Bo}),
    StdVal = mod_xinfa:get_std_value(XinfaLv, ?ATTR_HP),
    CostVal1 = erlang:round(StdVal * CostCoef),
    CostVal2 =  case mod_skill:get_cost_hp(CurSklCfg) of
                    null ->
                        0;
                    {rate, Rate} ->
                        ?ASSERT(Rate > 0 andalso Rate =< 1, {Rate, CurSklCfg}),
                        case mod_skill:base_on_which_when_cost_hp(CurSklCfg) of
                            base_on_hp_lim ->
                                InitHpLim = lib_bo:get_init_hp_lim(Bo),
                                util:ceil(InitHpLim * Rate);
                            base_on_cur_hp ->
                                CurHp = lib_bo:get_hp(Bo),
                                util:ceil(CurHp * Rate)
                        end;
                                
                    {int, CostHp} ->
                        CostHp
                end,

    ?ASSERT(util:is_nonnegative_int(CostVal1), CurSklCfg),
    ?ASSERT(util:is_nonnegative_int(CostVal2), CurSklCfg),
    erlang:round(CostVal1 + CostVal2).  % 做round取整以容错
    

calc_use_skill_cost_mp(Bo, CurSklCfg) ->
    CostCoef = mod_skill:get_cost_mp_coef(CurSklCfg),
    XinfaLv = decide_xinfa_lv_of_actor(Bo, CurSklCfg, false),
    ?ASSERT(XinfaLv > 0, {CurSklCfg, Bo}),
    StdVal = mod_xinfa:get_std_value(XinfaLv, ?ATTR_MP),
    CostVal1 = erlang:round(StdVal * CostCoef),

    InitMpLim = lib_bo:get_init_mp_lim(Bo),            
    CostVal2 =  case mod_skill:get_cost_mp(CurSklCfg) of
                    null ->
                        0;
                    {rate, Rate} ->
                        util:ceil(InitMpLim * Rate);
                    {int, CostMp} ->
                        CostMp
                end,

    ?ASSERT(util:is_nonnegative_int(CostVal1), CurSklCfg),
    ?ASSERT(util:is_nonnegative_int(CostVal2), CurSklCfg),
    erlang:round(CostVal1 + CostVal2).  % 做round取整以容错

%%应用减怒气的buff wjc
calc_use_skill_cost_anger(Bo, CurSklCfg) ->
    InitAngerLim = lib_bo:get_init_anger_lim(Bo),
    ReduceRate =
        case lib_bo:find_buff_by_name(Bo, ?BFN_REDUCE_ANGER_COST ) of
            null ->
                0;
            CostAngerBuff ->
                RatePara = lib_bo_buff:get_buff_tpl_para(CostAngerBuff),
                ?DEBUG_MSG("wjcTestBFN_REDUCE_ANGER_COST ~p~n",[RatePara]),
                RatePara
        end,
    CostVal =   case mod_skill:get_cost_anger(CurSklCfg) of
                    null ->
                        0;
                    {rate, Rate} ->
                        util:ceil(InitAngerLim * Rate * (1 - ReduceRate));
                    {int, CostAnger} ->
                        util:ceil(CostAnger * (1 - ReduceRate) )
                end,
                
    ?ASSERT(util:is_nonnegative_int(CostVal), CurSklCfg),
    erlang:round(CostVal).  % 做round取整以容错


calc_use_skill_cost_gamemoney(_Bo, CurSklCfg) ->
    CostVal =   case mod_skill:get_cost_gamemoney(CurSklCfg) of
                    null ->
                        0;
                    {int, Cost} ->
                        Cost
                end,
    ?ASSERT(util:is_nonnegative_int(CostVal), CurSklCfg),
    erlang:round(CostVal).  % 做round取整以容错


%% 计算某一方已死亡的玩家数
calc_dead_player_count_of_side(Side) ->
    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE),
    L = lib_bt_comm:get_bo_id_list(Side),
    F = fun(BoId) ->
            Bo = lib_bt_comm:get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bt_comm:is_player(Bo) andalso lib_bt_comm:is_dead(Bo)
        end,
    length( [dummy || X <- L , F(X)] ).


        

%% 计算某一方所有玩家的平均等级
calc_avg_player_lv_of_side(Side) ->
    case lib_bt_comm:get_player_bo_id_list(Side) of
        [] ->
            0;
        L ->
            F = fun(BoId, Sum) ->
                    Bo = lib_bt_comm:get_bo_by_id(BoId),
                    Sum + lib_bo:get_lv(Bo)
                end,
            SumLv = lists:foldl(F, 0, L),
            erlang:round(SumLv / length(L))
    end.



%% 计算乱敏：15%范围的上下浮动
calc_tmp_rand_act_speed_once(Bo) ->
    ActSpd = lib_bo:get_act_speed(Bo),
    
    Val = max(util:ceil(ActSpd * 0.15), 0),
    Val2 = util:rand(0, Val),
    case util:decide_proba_once(0.5) of
        success ->
            Val2;
        fail ->
            - Val2
    end.


%% 计算技能效果的目标数量
calc_skill_eff_target_count(Actor, SklEff) ->
    case lib_bo:is_using_normal_att(Actor) of
        true ->
            1;  % 普通攻击的目标个数固定为1
        false ->
            SklCfg = lib_bo:get_cur_skill_cfg(Actor),
            ?ASSERT(SklCfg /= null, {SklEff, lib_bo:id(Actor), Actor}),

            case SklEff#skl_eff.target_count of
                infinite ->
                    ?MAX_U8;  % 返回一个足够大的数以表示无限
                xinfa_related -> % 和心法等级相关
                    
                    % PlayerId = lib_bo:get_parent_obj_id(Actor),

                    % XfId = mod_skill:get_owner_xinfa_id(SklCfg),
                    % XfLv = ply_xinfa:get_player_xinfa_lv(PlayerId, XfId),
                    % ?ASSERT(XfLv /= error, {PlayerId, XfId, Actor}),

                    XfLv = decide_xinfa_lv_of_actor(Actor, SklCfg, false),

                    TargetCountConst = mod_skill:get_target_count_constant(SklCfg),

                    MyTargetCount= case mod_skill:get_min_target_count(SklCfg) of
                        [] -> 1;
                        List when is_list(List) ->

                            F = fun(Info, Sum) ->
                                case Info of
                                    {Lv,Count} ->
                                        case Lv =< XfLv of
                                            true ->
                                                Count;
                                            false ->
                                               Sum
                                        end;
                                    Count when is_integer(Count) -> Count;
                                    _ -> 1
                                end
                            end,

                            Count = lists:foldl(F, 1, List),
                            Count;
                        _ -> 1
                    end,
                    % ?ASSERT(TargetCountConst /= 0, SklCfg),
                    case TargetCountConst =:= 0 of
                        true -> 
                            % ?ERROR_MSG("lib_bt_calc:calc_skill_eff_target_count,SklCfg=~w~n", [SklCfg]),
                            1;
                        false -> 
                            % 公式： int（心法等级/等差常数（配置））+最低目标数（配置）
                            % RetCount = XfLv div TargetCountConst + MinTargetCount,
                            % ?DEBUG_MSG("calc_skill_eff_target_count(), RetCount=~p, XfLv=~p, TargetCountConst=~p, MinTargetCount=~p~n", 
                            %         [RetCount, XfLv, TargetCountConst, MinTargetCount]),
                            MyTargetCount
                    end;
                TargetCount ->
                    ?ASSERT(util:is_positive_int(TargetCount), {TargetCount, SklEff, Actor}),
                    TargetCount
            end
    end.


get_coef_by_five_element(Actor,SklCfg) ->
    %%五行技能加成
    {FiveElement,FiveElementLv}  = Actor#battle_obj.five_elements,
        case FiveElement == SklCfg#skl_cfg.five_elements of
            true ->
                F =
                    fun(_,Acc) ->
                        FiveElementData = data_five_elements_level:get(FiveElement,FiveElementLv),
                        case FiveElementData#five_elements_level.effect == skill_eff_up  of
                            true ->
                                Acc + FiveElementData#five_elements_level.effect_num;
                            false ->
                                Acc
                        end
                    end,

                lists:foldl(F ,0,lists:seq(1, FiveElementLv));

            false ->
                0
        end.


decide_coef_for_calc_dam(poison, Actor, SklCfg, IsUsingNormalAtt) ->
    case IsUsingNormalAtt of
        true ->
            0;
        false ->
            XinfaLv = decide_xinfa_lv_of_actor(Actor, SklCfg, IsUsingNormalAtt),
            LvCoef = mod_skill:get_ext_coef_lv(SklCfg),
            Coef = mod_skill:get_ext_coef(SklCfg),

            Coef + XinfaLv * LvCoef
    end;


%% 确定攻击放大系数
decide_coef_for_calc_dam(attack_scaling, Actor, SklCfg, IsUsingNormalAtt) ->
    case IsUsingNormalAtt of
        true ->
            data_special_config:get(normal_attack_scaling);
        false ->
            % ?ASSERT(is_record(SklCfg, skl_cfg), {_Atter, IsUsingNormalAtt}),
            XinfaLv = decide_xinfa_lv_of_actor(Actor, SklCfg, IsUsingNormalAtt),
            LvAddScaling = decide_coef_for_calc_dam(skill_scaling, Actor, SklCfg, IsUsingNormalAtt),
            %%五行技能加成
            {FiveElement,FiveElementLv}  = Actor#battle_obj.five_elements,
            FiveElemntCoef = case FiveElement == SklCfg#skl_cfg.five_elements of
                                 true ->
                                     F = fun(_,Acc) ->
                                         FiveElementData = data_five_elements_level:get(FiveElement,FiveElementLv),
                                         case FiveElementData#five_elements_level.effect == skill_eff_up  of
                                             true ->
                                                 Acc + FiveElementData#five_elements_level.effect_num;
                                             false ->
                                                 Acc
                                         end
                                         end,

                                     lists:foldl(F ,0,lists:seq(1, FiveElementLv));

                                 false ->
                                     0
                             end,
            mod_skill:get_attack_scaling(SklCfg) + XinfaLv * LvAddScaling
    end;


%% 确定防御放缩系数
decide_coef_for_calc_dam(defend_scaling, Actor, SklCfg, IsUsingNormalAtt) ->
    case IsUsingNormalAtt of
        true ->
            1;
        false ->
            ?ASSERT(is_record(SklCfg, skl_cfg), {Actor, IsUsingNormalAtt}),
            mod_skill:get_defend_scaling(SklCfg)
    end;

% 修改后为等级额外增加系数
decide_coef_for_calc_dam(skill_scaling, Actor, SklCfg, IsUsingNormalAtt) ->
    case IsUsingNormalAtt of
        true -> 0;
        false ->
            mod_skill:get_skill_scaling(SklCfg)
    end;

decide_coef_for_calc_dam(xinfa_related_coef, Actor, SklCfg, IsUsingNormalAtt) ->
    case IsUsingNormalAtt of
        true -> 0;
        false -> mod_skill:get_xinfa_related_coef(SklCfg)
    end;

decide_coef_for_calc_dam(att_times_scaling, Actor, SklCfg, IsUsingNormalAtt) ->
    % 普通攻击连击伤害递减0.8
    case IsUsingNormalAtt of
        true -> 0.6;
        false -> mod_skill:get_att_times_scaling(SklCfg)
    end;

decide_coef_for_calc_dam(std_dam_scaling, Actor, SklCfg, IsUsingNormalAtt) ->
    % 标准伤害放缩系数默认为0
    case IsUsingNormalAtt of
        true -> 0;
        false -> mod_skill:get_std_dam_scaling(SklCfg)
    end.




%% 暴击系数
decide_crit_coef_for_calc_dam(Atter, CritInfo) ->
    case CritInfo of
        crit -> lib_bo:get_crit_coef(Atter);
        not_crit -> 1
    end.


%% 技能固有伤害值
decide_skill_innate_dam(SklCfg, IsUsingNormalAtt) ->
    case IsUsingNormalAtt of
        true -> {0,0};
        false -> mod_skill:get_innate_dam(SklCfg)
    end.





% 这里加算装备特效计算
decice_equip_add_skill_lv(Actor,SklCfg,IsUsingNormalAtt) ->
    case IsUsingNormalAtt of
        true ->
            0;
        false ->
            Type = lib_bo:get_type(Actor),
            case Type of
                % 如果是宠物
                ?OBJ_PARTNER ->
                    PartnerId = lib_bo:get_parent_obj_id(Actor),
                    case lib_partner:get_partner(PartnerId) of 
                        Partner when is_record(Partner,partner) ->
                            TEqpList = mod_equip:get_partner_equip_list(lib_partner:get_owner_id(Partner), PartnerId ),

                            F = fun(Equip,Acc) ->
                                lib_goods:get_skill_lv_eff(Equip,mod_skill:get_id(SklCfg)) + Acc
                            end,

                            lists:foldl(F,0,TEqpList);
                        _ ->
                            0
                    end;

                % 如果是玩家
                ?OBJ_PLAYER ->
                    PlayerId = lib_bo:get_parent_obj_id(Actor),
                    case player:is_online(PlayerId) of
                        true ->
                            TEqpList = mod_equip:get_player_equip_list(PlayerId),

                            F = fun(Equip,Acc) ->
                                lib_goods:get_skill_lv_eff(Equip,mod_skill:get_id(SklCfg)) + Acc
                            end,

                            lists:foldl(F,0,TEqpList);
                        false ->
                            0
                    end;

                _ -> 0

            end
    end.


%% 确定心法等级
decide_xinfa_lv_of_actor(Actor, SklCfg, IsUsingNormalAtt) ->
    Lv1 = case IsUsingNormalAtt of
        true ->
            0;
        false ->
            case mod_skill:is_couple_skill(SklCfg) of
                true ->  % 夫妻技能特殊处理
                    decide_xinfa_lv_of_actor_on_use_couple_skill(Actor);
                false ->
                    case mod_skill:is_magic_key_skill(SklCfg) of
                        true -> lib_bo:get_lv(Actor);       %% 直接用等级
                        false ->
                            Type = lib_bo:get_type(Actor),
                            if 
                                Type == ?OBJ_PLAYER
                                orelse Type == ?OBJ_HIRED_PLAYER ->
                                    case mod_skill:is_newbie_skill(SklCfg) of
                                        true ->
                                            min(lib_bo:get_lv(Actor), 10);  % 新手技能对应的心法等级为bo的等级，并且不超过10级！
                                        false ->
                                            %%%PlayerId = lib_bo:get_parent_obj_id(Actor),
                                            ?BT_LOG(io_lib:format("ActorId=~p, SkillId=~p~n", [lib_bo:id(Actor), mod_skill:get_id(SklCfg)])),
                                            XinfaId = mod_skill:get_owner_xinfa_id(SklCfg),
                                            XinfaLv = lib_bo:get_xinfa_lv(Actor, XinfaId),  %%%ply_xinfa:get_player_xinfa_lv(PlayerId, XinfaId),
                                            ?BT_LOG(io_lib:format("ActorId=~p, SkillId=~p, XinfaLv=~p~n", [lib_bo:id(Actor), mod_skill:get_id(SklCfg), XinfaLv])),
                                            ?ASSERT(XinfaLv /= error, {lib_bo:get_parent_obj_id(Actor), XinfaId, Actor}),
                                            XinfaLv
                                    end;

                                Type == ?OBJ_PARTNER -> % 对于宠物，直接以其等级作为心法等级
                                    lib_bo:get_lv(Actor);

                                Type == ?OBJ_MONSTER
                                orelse Type == ?OBJ_NORMAL_BOSS
                                orelse Type == ?OBJ_WORLD_BOSS -> % 对于怪物，直接以其等级作为心法等级
                                    lib_bo:get_lv(Actor);

                                true ->
                                    % ?ASSERT(false, Type),
                                    lib_bo:get_lv(Actor)
                            end
                    end
            end
    end,
    Lv2 = decice_equip_add_skill_lv(Actor,SklCfg,IsUsingNormalAtt),

    % ?DEBUG_MSG("Lv1 = ~p,Lv2 = ~p",[Lv1,Lv2]),
    Lv1 + Lv2.


decide_phy_att_times_for_calc_dam(Atter, IsUsingNormalAtt, IsStrikeback) ->
    case IsStrikeback of
        true ->
            1;   % 反击时固定只攻击一次
        false ->
            case IsUsingNormalAtt orelse lib_bo:is_using_single_target_phy_att(Atter) of
                true ->
                    lib_bo:get_acc_phy_combo_att_times(Atter) + 1;
                false ->
                    lib_bo:get_acc_hit_obj_count(Atter) + 1
            end
    end.

            



decide_xinfa_std_HP_value_by_xinfa_lv(XinfaLv) ->
    case XinfaLv > 0 of
        true -> mod_xinfa:get_std_value(XinfaLv, ?ATTR_HP);
        false -> 0
    end.


decide_xinfa_std_MP_value_by_xinfa_lv(XinfaLv) ->
    case XinfaLv > 0 of
        true -> mod_xinfa:get_std_value(XinfaLv, ?ATTR_MP);
        false -> 0
    end.

    

%% 确定驱鬼系数
%% 驱鬼成立的条件： 攻击者有驱鬼能力，并且防守者有鬼魂预备状态
decide_qugui_coef(Atter, Defer) ->
    case lib_bo:can_qugui(Atter) andalso lib_bo:has_ghost_prep_status(Defer) of
        true ->
            lib_bo:get_qugui_coef(Atter);
        false ->
            ?DEFAULT_QUGUI_COEF
    end.




%% 确定一次伤害的浮动比率
%% 默认波动区间（0.95, 1.05）之间随机，精度至万分之一
decide_dam_floating_once() ->
    1. %% 策划需求改
    % Precision = 10000,

    % Floating_Max = 1.05,
    % Floating_Min = 0.95,
    % Delta = (Floating_Max - Floating_Min) / Precision,

    % Rand = util:rand(0, Precision),
    % Floating_Min + Rand * Delta.





%% 确定反转伤害系数
% @return {InverseDamFlag, InverseDamCoef} = {是否是反转伤害效果，效果参数}
decide_inverse_dam_coef(_Atter, SklCfg, IsUsingNormalAtt) ->
    case IsUsingNormalAtt of
        true ->
            {false, 1};
        false ->
            InverseDamProba = mod_skill:get_inverse_dam_proba(SklCfg),
            ?ASSERT(util:is_nonnegative_int(InverseDamProba), SklCfg),
            case InverseDamProba=:=0 of
                true -> % 
                    {false, 1};
                false ->
                    case lib_bt_util:test_proba(InverseDamProba) of
                        fail ->
                            {true, 1};
                        success ->
                            {true, mod_skill:get_inverse_dam_coef(SklCfg)}
                    end    
            end
    end.






% decide_protecting_share_dam_coef(Defer) ->
%     case lib_bo:get_one_protector(Defer) of
%         null ->
%             1;
%         Protector ->
%             0.3
%     end.
    

% calc_phy_damage_to_protector(Atter, Defer, CritInfo) ->
%     % 保护者分担70%的伤害
%     ProtectingShareDamCoef = 0.7,  %%decide_protecting_share_dam_coef(Defer),
%     calc_phy_damage__(Atter, Defer, CirtInfo, ProtectingShareDamCoef).





%% 使用防御时所减轻的伤害比例
-define(REDUCE_DAM_RATE_BY_USING_DEFEND, 0.5).




%% 确定使用防御时的伤害减轻比例            
decide_reduce_dam_rate_by_using_defend(Defer) ->
    case lib_bo:is_using_defend(Defer) 
    andalso (not lib_bo:is_under_control(Defer)) of
        true ->
            ?REDUCE_DAM_RATE_BY_USING_DEFEND;
        false ->
            0
    end.


%% 确定追击伤害系数
decide_pursue_att_dam_coef(Atter, IsPursueAtt) ->
    case IsPursueAtt of
        true ->
            Val = lib_bo:get_pursue_att_dam_coef(Atter),
            case Val > 0 of
                true ->
                    Val;
                false ->
                    % ?ASSERT(false, Atter),
                    ?ERROR_MSG("decide_pursue_att_dam_coef() error!! pursue att dam coef is 0, Atter:~w", [Atter]),
                    0
            end;
       false ->
           0
    end.


%% 魔法伤害计算 攻击者 被攻击者 暴击信息
calc_mag_damage_duan(Atter, Defer, CritInfo) ->
    ?ASSERT(not lib_bo:is_using_normal_att(Atter), Atter),

    IsUsingNormalAtt = false,  % 肯定不是用普通攻击！

    ExtDam = case lib_bo:is_do_dam_by_defer_hp_rate_with_limit(Atter) andalso (not IsUsingNormalAtt) of
        true -> calc_dam_by_defer_hp_rate_with_limit_new(Atter, Defer);
        false -> 0
    end,
    % 攻击者物理攻击
    AtterAtt = lib_bo:get_mag_att(Atter),
    % 被攻击者物理防御
    DeferDef = lib_bo:get_mag_def(Defer),


%%    连击伤害系数=连击或攻击次数放缩系数^(连击或攻击次数-1)
    AttTimes = max(Atter#battle_obj.tmp_status#bo_tmp_stat.acc_mag_combo_att_times,1),

    % 当前技能配置
    SklCfg = lib_bo:get_cur_skill_cfg(Atter),

    %%攻击者当前回合的法术连击
    % 连续攻击放缩系数
    BaseAttTimesScaling = decide_coef_for_calc_dam(att_times_scaling, Atter, SklCfg, IsUsingNormalAtt),
    AttTimesScaling = math:pow(BaseAttTimesScaling, AttTimes-1),
    % 心法等级
    XinfaLv = decide_xinfa_lv_of_actor(Atter, SklCfg, IsUsingNormalAtt),
    % 对应等级的标准值
    XinfaStdValHp = decide_xinfa_std_HP_value_by_xinfa_lv(XinfaLv),
    % 标准值缩放
    StdDamScaling = decide_coef_for_calc_dam(std_dam_scaling, Atter, SklCfg, IsUsingNormalAtt),
    SkillNo  = case SklCfg of
                   null ->
                       0;
                   _ ->
                       SklCfg#skl_cfg.id
               end,
    SkillLv = case Atter#battle_obj.type == 1 of
                  true ->
                      case lib_bo:get_cur_skill_brief(Atter) of
                          null ->
                              1;
                          CurSklBrf ->
                              CurSklBrf#bo_skl_brf.lv
                      end;
                  false ->
                      Atter#battle_obj.lv
              end,
    % 攻击放大系数 大于1 放大 小于1 缩小 攻击加成比率
    AttScaling = decide_coef_for_calc_dam(attack_scaling, Atter, SklCfg, IsUsingNormalAtt),
    % 防御放大系数 大于1 放大 小于1 缩小 一般是配置无视防御
    DefScaling = decide_coef_for_calc_dam(defend_scaling, Atter, SklCfg, IsUsingNormalAtt),

%%    物伤加成系数=max(物伤&法伤加成最小值，己.物伤增加 - 敌.物伤减免)
%%% 攻击者 伤害放大系数
    DamScaling = lib_bo:get_do_mag_dam_scaling(Atter),
    % 被攻击减免伤害系数
    BeDamReduceCoef = lib_bo:get_be_mag_dam_reduce_coef(Defer),

    {InitSkillDam, SkillExtrLv} = decide_skill_innate_dam(SklCfg, IsUsingNormalAtt),
    % 技能伤害值
    SkillDam = InitSkillDam + SkillExtrLv* SkillLv ,

    % 计算基础攻击伤害 攻击- 防御+ 标准参考值*标准系数
    RealAtt = erlang:max( AtterAtt,1),

    % 计算忽视防御
    NeglectDef = util:minmax(1-lib_bo:get_neglect_mag_def(Atter),0,1),
    RealDef = erlang:max(1,DefScaling * DeferDef * NeglectDef),
    % RealDef = erlang:max(DefScaling * DeferDef,1),

    BaseDamValue = erlang:max(1,(math:pow(RealAtt,2)/(RealAtt + RealDef * 3) * AttScaling + SkillDam)),

    ScalingValue = erlang:max(DamScaling - BeDamReduceCoef,data_special_config:get(min_dam_scaling)),
    ?DEBUG_MSG("ScalingValue = ~p,DamScaling = ~p,BeDamReduceCoef = ~p",[ScalingValue,DamScaling,BeDamReduceCoef]),
    % 伤害值 非暴击技能伤害=基础技能伤害 * （1+物伤加成系数） * 连击伤害系数  * 95% ~105%
    DamValue = (BaseDamValue) * (1 + ScalingValue) * AttTimesScaling * (util:rand(95,105)/100),

    % 乘以次数放缩伤害
    DamVal2 = erlang:max(DamValue, 1),

    CritCoef = case CritInfo of
                   crit -> min(lib_bo:get_mag_crit_coef(Atter) / 1000 , data_special_config:get(max_crit_coef)) + data_special_config:get(init_crit_coef);
                   _ -> 0
               end,

    % 驱鬼系数
    QuguiCoef = decide_qugui_coef(Atter, Defer),

%%    % 计算暴击+驱鬼的伤害
%%    DamVal2_ = erlang:round(DamVal2 * (1+CritCoef) * QuguiCoef),

%%    % 暴击伤害程度
%%    CritCoef = case CritInfo of
%%        crit -> lib_bo:get_mag_crit_coef(Atter) / 1000;
%%        _ -> 0
%%    end,

    QuguiCoef = decide_qugui_coef(Atter, Defer),  % 驱鬼系数

    % 计算暴击+驱鬼的伤害
    DamVal3 = erlang:round(DamVal2 * (1+CritCoef) * QuguiCoef),

    {ok,Bin} = pt_20:write(20200,[2,SkillNo,util:floor(AttScaling * 1000),util:floor(SkillDam),
        util:floor(ScalingValue*1000),util:floor(AttTimesScaling*1000),util:floor(CritCoef*1000),0,util:floor(DamVal3) ,0,0,0 ,0]),
    AtterPlayerId = case Atter#battle_obj.type == 1 of
                        true ->
                            Atter#battle_obj.parent_obj_id;
                        false ->
                            case Atter#battle_obj.type == 2 of
                                true ->
                                    get({get_player_id_by_bo,Atter#battle_obj.id});
                                false ->
                                    0
                            end
                    end,

    case AtterPlayerId ==0  orelse AtterPlayerId == undefined of
        true ->
            skip;
        false ->
            ?SEND_BIN(AtterPlayerId, Bin)
    end,

    DefferPlayerId = case Defer#battle_obj.type == 1 of
                        true ->
                            Defer#battle_obj.parent_obj_id;
                        false ->
                            case Defer#battle_obj.type == 2 of
                                true ->
                                    get({get_player_id_by_bo,Defer#battle_obj.id});
                                false ->
                                    0
                            end
                    end,

    case DefferPlayerId ==0  orelse DefferPlayerId == undefined  of
        true ->
            skip;
        false ->
            ?SEND_BIN(DefferPlayerId, Bin)
    end,

    % 吸收伤害值
    DamAbsorb = lib_bo:get_mag_dam_absorb(Defer),
    % 物理伤害减少固定值
    DamShrink = lib_bo:get_be_mag_dam_shrink(Defer), 
    DamValFinal1 = erlang:max(DamVal3 - (DamAbsorb + DamShrink),1),

    % 计算类别加成
    DamValFinal2 = 
    case lib_bo:get_main_type(Defer) of
        ?OBJ_PARTNER -> (1+lib_bo:get_mag_dam_to_partner(Atter)) * DamValFinal1;
        ?OBJ_MONSTER -> (1+lib_bo:get_mag_dam_to_mon(Atter)) * DamValFinal1;
        _ -> DamValFinal1
    end,

    % 速度类加成计算
    DamValFinal = 
    case lib_bo:get_act_speed(Atter) < lib_bo:get_act_speed(Defer) of
        true -> (1+lib_bo:get_mag_dam_to_speed_1(Atter)) * DamValFinal2;
        false -> (1+lib_bo:get_mag_dam_to_speed_2(Atter)) * DamValFinal2
    end,

    ?DEBUG_MSG("DamValFinal = ~p,[~p]",[DamValFinal,ExtDam]),

    Ret = case lib_bo:is_invincible(Defer) of
        true -> 0;
        _ -> DamValFinal + ExtDam
    end,

    Ret2 =
        case lib_bo:find_buff_by_name(Atter,?BFN_ADD_INSTABLE_DAM) of
            ExrtDamBuff when is_record(ExrtDamBuff, bo_buff) ->
                ?DEBUG_MSG("wjctestbuff ~p~n",[ExrtDamBuff#bo_buff.eff_para#buff_eff_para.eff_real_value]),
                BuffData = data_buff:get(ExrtDamBuff#bo_buff.buff_no),
                {MinDamRate,MaxDamRate} = BuffData#buff_tpl.para,
                GetDamRate = util:rand(MinDamRate,MaxDamRate),
                util:ceil(Ret * GetDamRate / 1000);
            _ ->
                Ret
        end,

    Ret2.

%% 计算物理伤害    攻击者 被攻击者 暴击信息 攻击类型（反击、追击、普通）
calc_phy_damage_duan(Atter, Defer, CritInfo, AttSubType) ->
    IsStrikeback = (AttSubType == ?ATT_SUB_T_STRIKEBACK),  % 是否是反击
    IsPursueAtt = (AttSubType == ?ATT_SUB_T_PURSUE),       % 此次攻击是否为追击？
    IsUsingNormalAtt = IsStrikeback orelse lib_bo:is_using_normal_att(Atter), % 是否使用普通攻击

    ?DEBUG_MSG("[[][][][][][]~p]",[lib_bo:is_do_dam_by_defer_hp_rate_with_limit(Atter)]),
    
    ExtDam = case lib_bo:is_do_dam_by_defer_hp_rate_with_limit(Atter) andalso (not IsUsingNormalAtt) of
        true -> calc_dam_by_defer_hp_rate_with_limit_new(Atter, Defer);
        false -> 0
    end,
    ?DEBUG_MSG("wjctestext ~p",[ExtDam]),

    % 攻击者物理攻击
    AtterAtt = lib_bo:get_phy_att(Atter),
    % 被攻击者物理防御
    DeferDef = lib_bo:get_phy_def(Defer),
    % 攻击次数
    AttTimes = erlang:max(decide_phy_att_times_for_calc_dam(Atter, IsUsingNormalAtt, IsStrikeback), 1), % 做max矫正仅仅是为了容错 

    % 当前技能配置
    SklCfg = lib_bo:get_cur_skill_cfg(Atter),
    % 心法等级
    XinfaLv = decide_xinfa_lv_of_actor(Atter, SklCfg, IsUsingNormalAtt),
    % 对应等级的标准值
    XinfaStdValHp = decide_xinfa_std_HP_value_by_xinfa_lv(XinfaLv),
    % 标准值缩放
    StdDamScaling = decide_coef_for_calc_dam(std_dam_scaling, Atter, SklCfg, IsUsingNormalAtt),

    % 攻击放大系数 大于1 放大 小于1 缩小 攻击加成比率
    AttScaling = decide_coef_for_calc_dam(attack_scaling, Atter, SklCfg, IsUsingNormalAtt),
    % 防御放大系数 大于1 放大 小于1 缩小 一般是配置无视防御
    DefScaling = decide_coef_for_calc_dam(defend_scaling, Atter, SklCfg, IsUsingNormalAtt),

    % 攻击者 物理伤害放大系数
    DamScaling = lib_bo:get_do_phy_dam_scaling(Atter),
    % 被物理攻击减免伤害系数
    BeDamReduceCoef = lib_bo:get_be_phy_dam_reduce_coef(Defer),



    % 计算基础攻击伤害 攻击- 防御+ 标准参考值*标准系数
    RealAtt = erlang:max(1, AtterAtt), %RealAtt = erlang:max(1,AttScaling * AtterAtt),
    % 计算忽视防御
    NeglectDef = util:minmax(1-lib_bo:get_neglect_phy_def(Atter),0,1),

    RealDef = erlang:max(1,DefScaling * DeferDef * NeglectDef),
    {InitSkillDam, SkillExtrLv} = decide_skill_innate_dam(SklCfg, IsUsingNormalAtt),
    % 技能伤害值
    SkillLv = case Atter#battle_obj.type == 1 of
                  true ->
                      case lib_bo:get_cur_skill_brief(Atter) of
                          null ->
                              1;
                          CurSklBrf ->
                              CurSklBrf#bo_skl_brf.lv
                      end;
                  false ->
                      Atter#battle_obj.lv
              end,
    ?DEBUG_MSG("wjctestSkilllv~p~n",[{lib_bo:get_cur_skill_brief(Atter), SkillLv}]),
    SkillDam = InitSkillDam + SkillExtrLv* SkillLv , %%暂时等级默认为1
    ?DEBUG_MSG("NeglectDef=~p,RealDef=~p,DeferDef=~p",[NeglectDef,RealDef,DeferDef]),
    %%己.物理攻击*己.物理攻击/(己.物理攻击+3*敌.物理防御) * 技能伤害放缩系数 + 技能伤害等级提升值 * 技能等级 + 技能伤害初始值 2019.11.7
    BaseDamValue = erlang:max(1,(math:pow(RealAtt,2)/(RealAtt + RealDef * 3) * AttScaling + SkillDam)),
    ?DEBUG_MSG("wjc_test_battle_value=~p~n",[{RealAtt,RealDef,AttScaling,SkillDam,BaseDamValue}]),
    % 连续攻击放缩系数
    BaseAttTimesScaling = decide_coef_for_calc_dam(att_times_scaling, Atter, SklCfg, IsUsingNormalAtt),

    % 缩放基础 ^ 攻击次数 如果大于1就是越来越高 如果小于1就越来越小
    %%    连击伤害系数=连击或攻击次数放缩系数^(连击或攻击次数-1)
    AttTimesScaling = math:pow(BaseAttTimesScaling, AttTimes-1),

    % ScalingValue = (1 - DamScaling) + (1 - BeDamReduceCoef),
    % 物伤加成系数=max(物伤&法伤加成最小值，己.物伤增加 - 敌.物伤减免)
    ScalingValue = erlang:max(DamScaling - BeDamReduceCoef,data_special_config:get(min_dam_scaling)), ?DEBUG_MSG("DamScaling,BeDamReduceCoef ~p~n",[{DamScaling - BeDamReduceCoef}]),
    % ?DEBUG_MSG("ScalingValue = ~p,DamScaling = ~p,BeDamReduceCoef = ~p",[ScalingValue,DamScaling,BeDamReduceCoef]),
    % ?DEBUG_MSG("RealAtt = ~p,RealDef = ~p,SkillDam = ~p",[RealAtt,RealDef,SkillDam]),
    % ?DEBUG_MSG("StdDamScaling = ~p,XinfaStdValHp = ~p,XinfaLv = ~p",[StdDamScaling,XinfaStdValHp,XinfaLv]),

    SkillNo  = case SklCfg of
                   null ->
                       0;
                   _ ->
                       SklCfg#skl_cfg.id
               end,
    % 物理伤害值
    DamValue = (BaseDamValue) * (1 + ScalingValue),

    ?DEBUG_MSG("wjc_test_battle_value2=~p~n",[{ScalingValue,DamValue }]),
%%    追击伤害系数=max(追击伤害加成最小值，己.追击伤害增加-敌.追击伤害减免)  追击伤害减免reduce_pursue_att_dam_coef 这是个新增的系数
    PursueAttDamCoef = max(data_special_config:get(min_pursue_att_dam_coef), decide_pursue_att_dam_coef(Atter, IsPursueAtt) - Defer#battle_obj.attrs#attrs.reduce_pursue_att_dam_coef),
%%    非暴击技能伤害=基础技能伤害 * （1+物伤加成系数） * 连击伤害系数 * （1+追击伤害系数） * 95% ~105%

    % 乘以次数放缩伤害
    DamVal2 = erlang:max(DamValue * AttTimesScaling * (1+ PursueAttDamCoef) * (util:rand(95,105)/100), 1),
    ?DEBUG_MSG("wjc_test_battle_value3=~p~n",[{DamValue,AttTimesScaling,PursueAttDamCoef }]),
    ?DEBUG_MSG("wjctestDam ~p~n",[DamVal2]),


    % 物理暴击伤害程度       最终物理暴伤=min(物理暴伤&法术暴伤最大值，己.物理暴伤）+ 初始物理暴伤
    CritCoef = case CritInfo of
        crit -> min(lib_bo:get_phy_crit_coef(Atter) / 1000 , data_special_config:get(max_crit_coef)) + data_special_config:get(init_crit_coef);
        _ -> 0
    end,

    % 驱鬼系数
    QuguiCoef = decide_qugui_coef(Atter, Defer),  

    % 计算暴击+驱鬼的伤害
    DamVal2_ = erlang:round(DamVal2 * (1+CritCoef) * QuguiCoef),
    {ok,Bin} = pt_20:write(20200,[1,SkillNo,util:floor(AttScaling * 1000),util:floor(SkillDam),
        util:floor(ScalingValue*1000),util:floor(AttTimesScaling*1000),util:floor(CritCoef*1000),util:floor(PursueAttDamCoef*1000),util:floor(DamVal2_) ,0,0,0 ,0]),
    AtterPlayerId = case Atter#battle_obj.type == 1 of
                        true ->
                            Atter#battle_obj.parent_obj_id;
                        false ->
                            case Atter#battle_obj.type == 2 of
                                true ->
                                    get({get_player_id_by_bo,Atter#battle_obj.id});
                                false ->
                                    0
                            end
                    end,

    case AtterPlayerId ==0 orelse AtterPlayerId == undefined of
        true ->
            skip;
        false ->
            ?SEND_BIN(AtterPlayerId, Bin)
    end,

    DeferPlayerId = case Defer#battle_obj.type == 1 of
                        true ->
                            Defer#battle_obj.parent_obj_id;
                        false ->
                            case Defer#battle_obj.type == 2 of
                                true ->
                                    get({get_player_id_by_bo,Defer#battle_obj.id});
                                false ->
                                    0
                            end
                    end,

    case DeferPlayerId ==0  orelse DeferPlayerId == undefined  of
        true ->
            skip;
        false ->
            ?SEND_BIN(DeferPlayerId, Bin)
    end,


    ?DEBUG_MSG("wjc_test_battle_value3=~p~n",[{QuguiCoef,CritCoef,DamVal2_}]),
    ?DEBUG_MSG("wjctestDam2 ~p~n",[DamVal2_]),
    % 计算防御后的伤害值
    ReduceDamRateByUsingDefend = decide_reduce_dam_rate_by_using_defend(Defer),
    DamVal3 = erlang:round( DamVal2_ * (1 - ReduceDamRateByUsingDefend) ),
    ?DEBUG_MSG("wjctestDam3 ~p~n",[DamVal3]),
    % 吸收伤害值
    PhyDamAbsorb = lib_bo:get_phy_dam_absorb(Defer), 

    % 物理伤害减少固定值
    PhyDamShrink = lib_bo:get_be_phy_dam_shrink(Defer), 

    % 计算减少伤害后的值 增加额外伤害
    DamVal4 = DamVal3 - (PhyDamAbsorb + PhyDamShrink),
    ?DEBUG_MSG("wjctestDam4 ~p~n",[DamVal4]),
    % 如果目标是队友且自己没有被混乱则是打怒气或者打醒昏睡状态，伤害为1.
    IsAlli = lib_bo:get_side(Defer) =:= lib_bo:get_side(Atter),
    IsChaos = lib_bo:is_chaos(Atter), 

    DamValFinal1 =
        if 
            IsAlli =:= true andalso not IsChaos ->
                1;
            % 如果是队友被混乱则判断是否有对队友加成伤害属性
            IsAlli =:= true andalso IsChaos ->
                DamVal5 = (1 + lib_bo:get_be_chaos_att_team_phy_dam(Defer)) * DamVal4,
                erlang:max(DamVal5, 1);
            true -> 
                erlang:max(DamVal4, 1)
        end,
    ?DEBUG_MSG("wjctestDam5 ~p~n",[DamValFinal1]),
    % 计算类别加成
    DamValFinal2 = case lib_bo:get_main_type(Defer) of
        ?OBJ_PARTNER -> (1+lib_bo:get_phy_dam_to_partner(Atter)) * DamValFinal1;
        ?OBJ_MONSTER -> (1+lib_bo:get_phy_dam_to_mon(Atter)) * DamValFinal1;
        _ -> DamValFinal1
    end,
    ?DEBUG_MSG("wjctestDam6 ~p~n",[DamValFinal2]),
    % 速度类加成计算
    DamValFinal = 
    case lib_bo:get_act_speed(Atter) < lib_bo:get_act_speed(Defer) of
        true -> (1+lib_bo:get_phy_dam_to_speed_1(Atter)) * DamValFinal2;
        false -> (1+lib_bo:get_phy_dam_to_speed_2(Atter)) * DamValFinal2
    end,

    ?DEBUG_MSG("wjctestDam67 = ~p,[~p]",[DamValFinal,ExtDam]),

    Ret = case lib_bo:is_invincible(Defer) of
        true -> 0;
        _ -> DamValFinal + ExtDam
    end,

    Ret2 =
        case lib_bo:find_buff_by_name(Atter,?BFN_ADD_INSTABLE_DAM) of
            ExrtDamBuff when is_record(ExrtDamBuff, bo_buff) ->
                ?DEBUG_MSG("wjctestbuff ~p~n",[ExrtDamBuff#bo_buff.eff_para#buff_eff_para.eff_real_value]),
                BuffData = data_buff:get(ExrtDamBuff#bo_buff.buff_no),
                {MinDamRate,MaxDamRate} = BuffData#buff_tpl.para,
                GetDamRate = util:rand(MinDamRate,MaxDamRate),
                util:ceil(Ret * GetDamRate / 1000);
            _ ->
                Ret
        end,
    Ret2.

%% 计算物理伤害
%% 伤害值=   ( 
%%                max[攻击方攻击力*0.05, (攻击放大系数*攻击方攻击力 - 防御放缩系数*受击方防御力)] * 技能放缩系数 * (1+心法等级*心法关联系数) * [(连击或攻击次数放缩系数)^(攻击或连击次数-1)] * 攻击方伤害放缩系数
%%              + 心法等级对应标准血量*标准伤害放缩系数
%%              + 技能固有伤害值
%%           ) 
%%          
%%          *暴击系数*驱鬼系数*(1-受击方伤害减免系数)*波动区间/(1+受击方物理伤害缩小数值/1000)*追击伤害系数
%%             
%%          - 物理伤害吸收值
%% !!!!! 注意：反转伤害时，返回的伤害值可能是负值!!!!!!
calc_phy_damage(Atter, Defer, CritInfo, AttSubType) ->
    case lib_bo:get_dbg_force_fix_dam(Atter) of
        DbgForceFixDamVal when is_integer(DbgForceFixDamVal) ->
            DbgForceFixDamVal;
        invalid ->
            IsStrikeback = (AttSubType == ?ATT_SUB_T_STRIKEBACK),  % 此次攻击是否为反击（反击是属于最多只攻击一次的普通攻击）？
            IsUsingNormalAtt = IsStrikeback orelse lib_bo:is_using_normal_att(Atter),
            % ?BT_LOG(io_lib:format("calc_phy_damage(), AtterId:~p, IsStrikeback:~p, IsUsingNormalAtt:~p~n", [lib_bo:id(Atter), IsStrikeback, IsUsingNormalAtt])),

            case lib_bo:is_do_dam_by_defer_hp_rate_with_limit(Atter) andalso (not IsUsingNormalAtt) of
                true ->
                    calc_dam_by_defer_hp_rate_with_limit(Atter, Defer, IsUsingNormalAtt);
                false ->
                    SklCfg = lib_bo:get_cur_skill_cfg(Atter),

                    IsPursueAtt = (AttSubType == ?ATT_SUB_T_PURSUE),       % 此次攻击是否为追击？
                    
                    AttScaling = decide_coef_for_calc_dam(attack_scaling, Atter, SklCfg, IsUsingNormalAtt),
                    AtterAtt = lib_bo:get_phy_att(Atter),

                    DefScaling = decide_coef_for_calc_dam(defend_scaling, Atter, SklCfg, IsUsingNormalAtt),
                    DeferDef = lib_bo:get_phy_def(Defer),

                    SkillScaling = decide_coef_for_calc_dam(skill_scaling, Atter, SklCfg, IsUsingNormalAtt),

                    XinfaLv = decide_xinfa_lv_of_actor(Atter, SklCfg, IsUsingNormalAtt),
                    XinfaRelatedCoef = decide_coef_for_calc_dam(xinfa_related_coef, Atter, SklCfg, IsUsingNormalAtt),

                    AttTimesScaling = decide_coef_for_calc_dam(att_times_scaling, Atter, SklCfg, IsUsingNormalAtt),

                    _AttTimes = erlang:max(decide_phy_att_times_for_calc_dam(Atter, IsUsingNormalAtt, IsStrikeback), 1), % 做max矫正仅仅是为了容错
                    ?ASSERT(decide_phy_att_times_for_calc_dam(Atter, IsUsingNormalAtt, IsStrikeback) >= 1, Atter),

                    DoDamScaling = lib_bo:get_do_phy_dam_scaling(Atter),

                    XinfaStdVal_Hp = decide_xinfa_std_HP_value_by_xinfa_lv(XinfaLv),

                    StdDamScaling = decide_coef_for_calc_dam(std_dam_scaling, Atter, SklCfg, IsUsingNormalAtt),

                    SkillInnateDam = decide_skill_innate_dam(SklCfg, IsUsingNormalAtt),

                    CritCoef =  decide_crit_coef_for_calc_dam(Atter, CritInfo),

                    QuguiCoef = decide_qugui_coef(Atter, Defer),  % 驱鬼系数

                    BeDamReduceCoef = lib_bo:get_be_phy_dam_reduce_coef(Defer),   % 受击方的物理伤害减免系数
                    ?ASSERT(BeDamReduceCoef =< 1, BeDamReduceCoef),

                    DamFloagting = decide_dam_floating_once(),  % 波动值

                    BeDamShrink = lib_bo:get_be_phy_dam_shrink(Defer),

                    PursueAttDamCoef = decide_pursue_att_dam_coef(Atter, IsPursueAtt),

                    PhyDamAbsorb = lib_bo:get_phy_dam_absorb(Defer),  % 物理伤害吸收值
                    % math:pow(AttTimesScaling, AttTimes - 1) 2015.05.20 由duanshihe改成AttTimesScaling
                    DamVal = erlang:round(
                                            (  erlang:max(AtterAtt*0.05, AttScaling*AtterAtt - DefScaling*DeferDef) * SkillScaling * (1 + XinfaLv*XinfaRelatedCoef) * AttTimesScaling * DoDamScaling
                                              + XinfaStdVal_Hp*StdDamScaling
                                              + SkillInnateDam  )
                                          * CritCoef*QuguiCoef*(1-BeDamReduceCoef)*DamFloagting/(1+BeDamShrink/1000)*PursueAttDamCoef
                                          - PhyDamAbsorb
                                        ),

                    DamVal2 = erlang:max(DamVal, 1),

                    ReduceDamRateByUsingDefend = decide_reduce_dam_rate_by_using_defend(Defer),
                    DamVal3 = erlang:round( DamVal2 * (1 - ReduceDamRateByUsingDefend) ),

                    % 最后处理技能反转伤害系数
                    {InverseDamFlag, InverseDamCoef} = decide_inverse_dam_coef(Atter, SklCfg, IsUsingNormalAtt),
                    DefCanPreventInverseDam = lib_bo:can_prevent_inverse_dam(Defer),
                    DamVal4 = case InverseDamFlag=:=true andalso DefCanPreventInverseDam=:=true of
                        true -> 
                            % 该技能具有“反转伤害”效果并且防御者具有防御该效果的能力，
                            % 则伤害公式中：攻击放大系数=1 防御放缩系数=1 技能放缩系数=1 心法关联系数=0 ，标准伤害放缩系数=1 技能固有伤害=0 心法等级对应标准血量=0
                            % math:pow(AttTimesScaling, AttTimes - 1) 2015.05.20 由duanshihe改成AttTimesScaling
                            DamVal_prevent_inverse_dam = 
                            erlang:round(
                                            (  erlang:max(AtterAtt*0.05, 1*AtterAtt - 1*DeferDef) * 1 * (1 + 0) * AttTimesScaling * DoDamScaling
                                              + 0*1
                                              + 0  )
                                          * CritCoef*QuguiCoef*(1-BeDamReduceCoef)*DamFloagting/(1+BeDamShrink/1000)*PursueAttDamCoef
                                          - PhyDamAbsorb
                                        ),
                            DamVal2_prevent_inverse_dam = erlang:max(DamVal_prevent_inverse_dam, 1),
                            erlang:round( DamVal2_prevent_inverse_dam * (1 - ReduceDamRateByUsingDefend) );
                        false -> 
                            erlang:round(DamVal3 * InverseDamCoef)
                    end,
                    
                      
                    % 如果目标是队友且自己没有被混乱则是打怒气或者打醒昏睡状态，伤害为1.
                    IsAlli = lib_bo:get_side(Defer) =:= lib_bo:get_side(Atter),
                    IsChaos = lib_bo:is_chaos(Atter), 

                    DamVal_Final =
                        if 
                            IsAlli =:= true andalso not IsChaos ->
                                1;
                            true -> 
                                case DefCanPreventInverseDam =:= false andalso InverseDamCoef < 0 of
                                    true -> erlang:min(DamVal4, -1);
                                    false -> erlang:max(DamVal4, 1)
                                end
                        end,

                    ?ASSERT(is_integer(DamVal_Final), {DamVal_Final, Atter, Defer, CritInfo}),
                    ?Ifc (lib_bt_comm:is_partner(Atter))
                        ?BT_LOG(io_lib:format("calc_phy_damage(), AtterId=~p DeferId=~p CritInfo=~p IsStrikeback=~p IsUsingNormalAtt=~p~n"
                                    "AttScaling=~p AtterAtt=~p DefScaling=~p DeferDef=~p SkillScaling=~p XinfaLv=~p XinfaRelatedCoef=~p AttTimesScaling=~p AttTimes=~p~n"
                                    "DoDamScaling=~p XinfaStdVal_Hp=~p StdDamScaling=~p CritCoef=~p QuguiCoef=~p BeDamReduceCoef=~p DamFloagting=~p PhyDamAbsorb=~p~n"
                                    "IsPursueAtt=~p PursueAttDamCoef=~p~n"
                                    "DamVal=~p DamVal2=~p DamVal3(after apply defend)=~p InverseDamCoef=~p DamVal4=~p DamVal_Final=~p~n", 
                                    [lib_bo:id(Atter), lib_bo:id(Defer), CritInfo, IsStrikeback, IsUsingNormalAtt, 
                                    AttScaling, AtterAtt, DefScaling, DeferDef, SkillScaling, XinfaLv, XinfaRelatedCoef, AttTimesScaling, AttTimes, 
                                    DoDamScaling, XinfaStdVal_Hp, StdDamScaling, CritCoef, QuguiCoef, BeDamReduceCoef, DamFloagting, PhyDamAbsorb,
                                    IsPursueAtt, PursueAttDamCoef,
                                    DamVal, DamVal2, DamVal3, InverseDamCoef, DamVal4, DamVal_Final]))
                    ?End,

                    DamVal_Final
            end
    end.

    
            

















% %% 计算法术攻击的伤害值
% %% @para: CritInfo => 是否暴击（crit:是，not_crit：否）
% calc_mag_damage(Atter, Defer, CritInfo) ->
%     % TODO: 临时性十分简单的计算：
%     % ?TRACE("calc_mag_damage(), Atter:~p, mag att: ~p, Defer:~p,  mag def: ~p~n", 
%     %               [?BOID(Atter), lib_bo:get_total_mag_att(Atter), ?BOID(Defer), lib_bo:get_total_mag_def(Defer)]),

%     case lib_bo:is_do_fix_Hp_dam_by_xinfa_lv(Atter) of
%         true ->
%             calc_fix_mag_dam_by_xinfa_lv(Atter);
%         false ->
%             Dam = max(lib_bo:get_total_mag_att(Atter) - lib_bo:get_total_mag_def(Defer), 0),  % 改为max矫正至少为1？

%             Dam2 = case CritInfo of
%                 crit -> Dam * 2;
%                 not_crit -> Dam
%             end,
%             RandDam = util:rand(0, 20),
%             Dam3 = case util:rand(1, 2) of
%                 1 ->
%                     max(Dam2 + RandDam, 1);
%                 2 ->
%                     max(Dam2 - RandDam, 1)
%             end,

%             % TODO: 处理atter的伤害增加， defer的受伤害增加的buff效果。。
            

%             % 计算防守方的被伤害加成
%             DoDamEnhance = lib_bo:calc_do_mag_dam_enhance(Atter),
%             BeDamEnhance = lib_bo:calc_be_mag_dam_enhance(Defer),
%             BeDamEnhance_Rate = lib_bo:calc_be_mag_dam_enhance_rate(Defer),


%             % ?TRACE("calc_mag_damage(), Dam=~p Dam2=~p, RandDam=~p Dam3=~p, BeDamEnhance_Rate=~p~n", [Dam, Dam2, RandDam, Dam3, BeDamEnhance_Rate]),
%             Dam3 + DoDamEnhance + BeDamEnhance + util:ceil(Dam3 * BeDamEnhance_Rate)
%     end.


calc_poison_damage_duan(Atter, Defer, _TargetCount, _CritInfo) ->
    ?ASSERT(not lib_bo:is_using_normal_att(Atter), Atter),
    Ret = calc_dam_by_defer_hp_rate_with_limit_new(Atter, Defer),
    ?DEBUG_MSG("calc_poison_damage_duan=~p",[Ret]),
    Ret.

%%   (   max[攻击方攻击力*0.05, (攻击放大系数*攻击方攻击力- 防御放缩系数*受击方防御力)] * 技能放缩系数 * (1+心法等级*心法关联系数) * 攻击方伤害放缩系数
%%      + 心法等级对应标准血量*标准伤害放缩系数
%%      + 技能固有伤害值
%%   )
%%   
%%   * (1/(实际目标数量^(1/2))) 修改为固定系数 暂定0.8
%%
%%   * 暴击系数*驱鬼系数*(1-受击方伤害减免系数)*波动区间/(1+受击方法术伤害缩小数值/1000)
%%
%%   - 法术伤害吸收值 --duanshihe 2015.05.25 调整算法

%% !!!!! 注意：反转伤害时，返回的伤害值可能是负值!!!!!!
calc_mag_damage(Atter, Defer, TargetCount, CritInfo) ->
    ?ASSERT(not lib_bo:is_using_normal_att(Atter), Atter),

    case lib_bo:get_dbg_force_fix_dam(Atter) of
        DbgForceFixDamVal when is_integer(DbgForceFixDamVal) ->
            DbgForceFixDamVal;
        invalid ->
            case lib_bo:is_do_fix_Hp_dam_by_xinfa_lv(Atter) of
                true ->
                    calc_fix_mag_dam_by_xinfa_lv(Atter);
                false ->
                    IsUsingNormalAtt = false,  % 肯定不是用普通攻击！
                    case lib_bo:is_do_dam_by_defer_hp_rate_with_limit(Atter) of
                        true ->
                            calc_dam_by_defer_hp_rate_with_limit(Atter, Defer, IsUsingNormalAtt);
                        false ->
                            SklCfg = lib_bo:get_cur_skill_cfg(Atter),

                            ?BT_LOG(io_lib:format("calc damage..... calc_mag_damage(), AtterId:~p, is_using_normal_att:~p~n", [lib_bo:id(Atter), lib_bo:is_using_normal_att(Atter)])),

                            AttScaling = decide_coef_for_calc_dam(attack_scaling, Atter, SklCfg, IsUsingNormalAtt),
                            AtterAtt = lib_bo:get_mag_att(Atter),

                            DefScaling = decide_coef_for_calc_dam(defend_scaling, Atter, SklCfg, IsUsingNormalAtt),
                            DeferDef = lib_bo:get_mag_def(Defer),

                            SkillScaling = decide_coef_for_calc_dam(skill_scaling, Atter, SklCfg, IsUsingNormalAtt),

                            XinfaLv = decide_xinfa_lv_of_actor(Atter, SklCfg, IsUsingNormalAtt),
                            XinfaRelatedCoef = decide_coef_for_calc_dam(xinfa_related_coef, Atter, SklCfg, IsUsingNormalAtt),

                            % AttTimesScaling = decide_coef_for_calc_dam(att_times_scaling, Atter, SklCfg, IsUsingNormalAtt),

                            % AttTimes = erlang:max(decide_phy_att_times_for_calc_dam(Atter, IsUsingNormalAtt), 1), % 做max矫正仅仅是为了容错
                            % ?ASSERT(decide_phy_att_times_for_calc_dam(Atter, IsUsingNormalAtt) >= 1, Atter),

                            DoDamScaling = lib_bo:get_do_mag_dam_scaling(Atter),

                            XinfaStdVal_Hp = decide_xinfa_std_HP_value_by_xinfa_lv(XinfaLv),

                            StdDamScaling = decide_coef_for_calc_dam(std_dam_scaling, Atter, SklCfg, IsUsingNormalAtt),

                            SkillInnateDam = decide_skill_innate_dam(SklCfg, IsUsingNormalAtt),

                            CritCoef =  decide_crit_coef_for_calc_dam(Atter, CritInfo),

                            QuguiCoef = decide_qugui_coef(Atter, Defer),  % 驱鬼系数

                            BeDamReduceCoef = lib_bo:get_be_mag_dam_reduce_coef(Defer),   % 受击方的法术伤害减免系数
                            ?ASSERT(BeDamReduceCoef =< 1, BeDamReduceCoef),

                            % 群体技能固定衰弱
                            TargetCountCoe = 
                                if 
                                    TargetCount > 1 ->
                                        0.78;
                                    true ->
                                        1                                          
                                end,

                            % 非玩家衰弱 暂定0.7
                            % is_player
                            % is_hired_player\
                            IsPlayer = lib_bt_comm:is_player(Atter),
                            IsHiredPlayer = lib_bt_comm:is_hired_player(Atter),

                            NoPlayerCoe = 
                                if 
                                    (IsPlayer orelse IsHiredPlayer) ->
                                        1;
                                    true ->
                                        0.65
                                end,


                            % MagDamAbsorbCoef = lib_bo:get_mag_dam_absorb_coef(Defer),
                            % (1 / math:pow(TargetCount, 0.5)) 修改为 TargetCountCoe

                            DamFloagting = decide_dam_floating_once(),  % 波动值

                            BeDamShrink = lib_bo:get_be_mag_dam_shrink(Defer),

                            MagDamAbsorb = lib_bo:get_mag_dam_absorb(Defer),  % 法术伤害吸收值

                            DamVal = erlang:round(
                                                    (  erlang:max(AtterAtt*0.05, AttScaling*AtterAtt - DefScaling*DeferDef) * SkillScaling * (1 + XinfaLv*XinfaRelatedCoef) * DoDamScaling
                                                      + XinfaStdVal_Hp*StdDamScaling
                                                      + SkillInnateDam  )
                                                  * TargetCountCoe * NoPlayerCoe
                                                  * CritCoef*QuguiCoef*(1-BeDamReduceCoef)*DamFloagting/(1+BeDamShrink/1000)
                                                  - MagDamAbsorb
                                                ),

                            DamVal2 = erlang:max(DamVal, 1),

                            ReduceDamRateByUsingDefend = decide_reduce_dam_rate_by_using_defend(Defer),
                            DamVal3 = erlang:round( DamVal2 * (1 - ReduceDamRateByUsingDefend) ),

                            % 最后处理技能反转伤害系数
                            {_InverseDamFlag, InverseDamCoef} = decide_inverse_dam_coef(Atter, SklCfg, IsUsingNormalAtt),
                            DamVal4 = erlang:round(DamVal3 * InverseDamCoef),
                            
                            DamVal_Final =  case InverseDamCoef < 0 of
                                                true -> erlang:min(DamVal4, -1);
                                                false -> erlang:max(DamVal4, 1)
                                            end,
                            ?ASSERT(is_integer(DamVal_Final), {DamVal_Final, Atter, Defer, CritInfo}),

                            %%% 调试
                            % case mod_skill:get_id(SklCfg) of
                            %     47 ->
                            %         ?BT_LOG(io_lib:format("47 skill: TargetCount:~p, DamVal:~p, DamVal_Final:~p~n", [TargetCount, DamVal, DamVal_Final]));
                            %     _ ->
                            %         skip
                            % end,

                            DamVal_Final
                    end
            end
    end.


%% 调整伤害值   
adjust_damage(Defer, DamVal) ->
    Ret = case lib_bo:is_frozen(Defer) of
        true ->
            0;  % 冰冻状态下不受伤害
        false ->
            case DamVal > 0 of
                true ->
                    case lib_bo:test_immu_dam_once(Defer) of
                        success ->
                            0;
                        fail ->
                            DamVal
                    end;
                false ->
                    DamVal
            end
    end,

    round(Ret).
    
            
    





%% 固定伤害部分=心法等级对应标准血量*标准伤害放缩系数
calc_fix_mag_dam_by_xinfa_lv(Atter) ->
    ?ASSERT(lib_bt_comm:is_player(Atter), Atter),
    CurSklCfg = lib_bo:get_cur_skill_cfg(Atter),
    ?ASSERT(CurSklCfg /= null, Atter),

    % CurSklId = mod_skill:get_id(CurSklCfg),
    %%XinfaId = mod_skill:get_owner_xinfa_id(CurSklCfg),

    %%%PlayerId = lib_bo:get_parent_obj_id(Atter),

    %%XinfaLv = lib_bo:get_xinfa_lv(Atter, XinfaId),   %%%ply_xinfa:get_player_xinfa_lv(PlayerId, XinfaId),

    XinfaLv = decide_xinfa_lv_of_actor(Atter, CurSklCfg, false),

    XinfaStdVal_Hp = mod_xinfa:get_std_value(XinfaLv, ?ATTR_HP),

    StdDamScaling = mod_skill:get_std_dam_scaling(CurSklCfg),

    DamVal = erlang:round(XinfaStdVal_Hp*StdDamScaling),

    erlang:max(DamVal, 1).

    % % TODO: 要确定计算公式。。。

    % ?TRACE("calc_fix_mag_dam_by_xinfa_lv(), AtterId=~p, PlayerId=~p, XinfaLv=~p~n", [?BOID(Atter), PlayerId, XinfaLv]),

    % XinfaLv * 20.



calc_dam_by_defer_hp_rate_with_limit(Atter, Defer, IsUsingNormalAtt) ->
    0.
    % SklCfg = lib_bo:get_cur_skill_cfg(Atter),
    % XinfaLv = decide_xinfa_lv_of_actor(Atter, SklCfg, IsUsingNormalAtt),
    % XinfaStdVal_Hp = decide_xinfa_std_HP_value_by_xinfa_lv(XinfaLv),

    % {HpRate1, LvAdd,Type,UpperLimCoef} = lib_bo:get_do_dam_by_defer_hp_rate_with_limit_para(Atter),
    % HpRate = HpRate1 + LvAdd * XinfaLv,

    % DamVal = erlang:round(lib_bo:get_hp_lim(Defer) * HpRate),
    % UpperLimVal = erlang:round(XinfaStdVal_Hp * UpperLimCoef),
    % ?BT_LOG(io_lib:format("calc_dam_by_defer_hp_rate_with_limit(), AtterId:~p, IsUsingNormalAtt:~p, SklCfg:~p, XinfaLv:~p, XinfaStdVal_Hp:~p, DamVal:~p, UpperLimVal:~p~n", 
    %                                 [lib_bo:id(Atter), IsUsingNormalAtt, SklCfg, XinfaLv, XinfaStdVal_Hp, DamVal, UpperLimVal])),
    % erlang:max( erlang:min(DamVal, UpperLimVal), 1).


% 按照当前百分比计算伤害
calc_dam_by_defer_hp_rate_with_limit_new(Atter, Defer) ->
    SklCfg = lib_bo:get_cur_skill_cfg(Atter),
    XinfaLv = decide_xinfa_lv_of_actor(Atter, SklCfg, false),
    _XinfaStdVal_Hp = decide_xinfa_std_HP_value_by_xinfa_lv(XinfaLv),

    {AtterAttrType,DeferAttrType,OpMode2,UpperLimCoef} = lib_bo:get_do_dam_by_defer_hp_rate_with_limit_para(Atter),

    HpRate = decide_coef_for_calc_dam(poison, Atter, SklCfg, false),

    % 施法者属性类型
    CasterAttrVal = get_caster_attr_total_value(Atter,AtterAttrType),
    % 目标属性类型
    ReceptorAttrVal = get_caster_attr_total_value(Defer,DeferAttrType),

    {OpMode,IsInt} = 
    case OpMode2 > 100 of
        true ->
            {OpMode2 - 100,true};
        false -> 
            {OpMode2,false}
    end,

    AttrVal = calc_attr_value(CasterAttrVal,ReceptorAttrVal,OpMode),

    DamVal = erlang:round(AttrVal * HpRate),
    UpperLimVal = erlang:round(CasterAttrVal * UpperLimCoef),

    case IsInt of
        true -> util:ceil(erlang:max( erlang:min(DamVal, UpperLimVal), 1));
        false ->  erlang:min(DamVal, UpperLimVal)
    end.


%% 计算反弹伤害
%% 反弹伤害值 = 受击方伤害*反震者反震系数-攻击方提供伤害吸收数
%% 反弹伤害修改为实际伤害不运算任何减少伤害
calc_ret_damage(Atter, Defer, DamToDefer) ->
    ?ASSERT(DamToDefer > 0, {DamToDefer, Atter, Defer}),
    RetDamCoef = lib_bo:get_ret_dam_coef(Defer),
    % QuguiCoef = decide_qugui_coef(Atter, Defer),
    % PhyDamAbsorb = lib_bo:get_phy_dam_absorb(Atter),  % 攻击者的物理伤害吸收值

    % 吸收反震的属性可以在这里计算
    PhyDamAbsorb = lib_bo:get_phy_dam_absorb(Atter),  % 玄冰障吸收
    DamVal = erlang:round(DamToDefer*RetDamCoef - PhyDamAbsorb),
    ?DEBUG_MSG("RetDamCoef=~p,~p",[RetDamCoef,DamVal]),

    erlang:max(DamVal, 1).





%% 计算执行技能攻击时附带伤蓝的效果值
%% 蓝量伤害 = 攻击方攻击力*技能放缩系数*(1+心法等级*心法关联系数) +心法等级对应标准蓝量*伤蓝放缩系数
calc_damage_to_mp_on_do_skill_att(Atter, SkillId) ->
    SklCfg = mod_skill:get_cfg_data(SkillId),
    AtterAtt =  case mod_skill:get_att_type(SklCfg) of
                    ?ATT_T_PHY ->
                        lib_bo:get_phy_att(Atter);
                    ?ATT_T_MAG ->
                        lib_bo:get_mag_att(Atter)
                end,
    SkillScaling = mod_skill:get_skill_scaling(SklCfg),
    XinfaLv = decide_xinfa_lv_of_actor(Atter, SklCfg, false),
    XinfaRelatedCoef = mod_skill:get_xinfa_related_coef(SklCfg),
    XinfaStdVal_Mp = decide_xinfa_std_MP_value_by_xinfa_lv(XinfaLv),
    %%% StdDamScaling = mod_skill:get_std_dam_scaling(SklCfg),
    DamToMpScaling = mod_skill:get_dam_to_mp_scaling(SklCfg),

    DamToMp = erlang:round( AtterAtt*SkillScaling*(1 + XinfaLv*XinfaRelatedCoef) + XinfaStdVal_Mp*DamToMpScaling ),
    ?BT_LOG(io_lib:format("calc_damage_to_mp_on_do_skill_att(), AtterId:~p, SkillId:~p, AtterAtt:~p, SkillScaling:~p, XinfaLv:~p, XinfaRelatedCoef:~p, XinfaStdVal_Mp:~p, DamToMpScaling:~p, DamToMp:~p~n",
                     [lib_bo:id(Atter), SkillId, AtterAtt, SkillScaling, XinfaLv, XinfaRelatedCoef, XinfaStdVal_Mp, DamToMpScaling, DamToMp])),
    erlang:max(DamToMp, 1).





%% 计算执行技能攻击时附带固定伤蓝的效果值
%% 固定蓝量伤害 = 心法等级对应标准蓝量*伤蓝放缩系数
calc_fix_dam_to_mp_on_do_skill_att(Atter, SkillId) ->
    SklCfg = mod_skill:get_cfg_data(SkillId),
    XinfaLv = decide_xinfa_lv_of_actor(Atter, SklCfg, false),
    XinfaStdVal_Mp = decide_xinfa_std_MP_value_by_xinfa_lv(XinfaLv),
    DamToMpScaling = mod_skill:get_dam_to_mp_scaling(SklCfg),

    DamToMp = erlang:round(XinfaStdVal_Mp*DamToMpScaling),

    ?BT_LOG(io_lib:format("calc_fix_dam_to_mp_on_do_skill_att(), AtterId:~p, SkillId:~p, XinfaLv:~p, XinfaStdVal_Mp:~p, DamToMpScaling:~p, DamToMp:~p~n",
                     [lib_bo:id(Atter), SkillId, XinfaLv, XinfaStdVal_Mp, DamToMpScaling, DamToMp])),

    erlang:max(DamToMp, 1).

%% 技能基础治疗量=己.法术攻击 * 技能伤害放缩系数 + 技能伤害等级提升值 * 技能等级 + 技能伤害初始值
%% 最终治疗量=技能基础治疗量 * （1+治疗加成系数+被治疗加成系数）
% 计算治疗效果
calc_heal_value_duan(ActorId, TargetBo, SkillId, _TargetCount) ->
    Atter = lib_bt_comm:get_bo_by_id(ActorId),
    SklCfg = mod_skill:get_cfg_data(SkillId),
    ?ASSERT(SklCfg /= null, SkillId),

    MagValue = lib_bo:get_mag_att(Atter),

    IsUsingNormalAtt = false,

     % 心法等级
    XinfaLv = decide_xinfa_lv_of_actor(Atter, SklCfg, IsUsingNormalAtt),
    % 对应等级的标准值
    XinfaStdValHp = decide_xinfa_std_HP_value_by_xinfa_lv(XinfaLv),
    % 标准值缩放
    StdDamScaling = decide_coef_for_calc_dam(std_dam_scaling, Atter, SklCfg, IsUsingNormalAtt),
    % 技能伤害值
    SkillLv = case Atter#battle_obj.type == 1 of
                  true ->
                      case lib_bo:get_cur_skill_brief(Atter) of
                          null ->
                              1;
                          CurSklBrf ->
                              CurSklBrf#bo_skl_brf.lv
                      end;
                  false ->
                      Atter#battle_obj.lv
              end,

    SkillNo  = case SklCfg of
                   null ->
                       0;
                   _ ->
                       SklCfg#skl_cfg.id
               end,
    % 攻击放大系数 大于1 放大 小于1 缩小 攻击加成比率
    AttScaling = decide_coef_for_calc_dam(attack_scaling, Atter, SklCfg, IsUsingNormalAtt),
    {InitSkillDam, SkillExtrLv} = decide_skill_innate_dam(SklCfg, IsUsingNormalAtt),
    HealValue1 = MagValue * AttScaling + SkillExtrLv *SkillLv + InitSkillDam,  %%等级由于还没做，目前默认为1

    % 治疗加成
    BeHealEffCoef = lib_bo:get_be_heal_eff_coef(TargetBo),

    HealVal = erlang:round((1 + BeHealEffCoef + Atter#battle_obj.attrs#attrs.heal_eff_coef) * HealValue1),

    {ok,Bin} = pt_20:write(20200,[3,SkillNo,0,0,
       0,0,0,0,0 ,util:floor(BeHealEffCoef * 1000),util:floor(HealVal),0 ,0]),
    AtterPlayerId = case Atter#battle_obj.type == 1 of
                        true ->
                            Atter#battle_obj.parent_obj_id;
                        false ->
                            case Atter#battle_obj.type == 2 of
                                true ->
                                    get({get_player_id_by_bo,Atter#battle_obj.id});
                                false ->
                                    0
                            end
                    end,
    case AtterPlayerId ==0 orelse AtterPlayerId == undefined  of
        true ->
            skip;
        false ->
            ?SEND_BIN(AtterPlayerId, Bin)
    end,

    TargetBoPlayerId = case TargetBo#battle_obj.type == 1 of
                        true ->
                            TargetBo#battle_obj.parent_obj_id;
                        false ->
                            case TargetBo#battle_obj.type == 2 of
                                true ->
                                    get({get_player_id_by_bo,TargetBo#battle_obj.id});
                                false ->
                                    0
                            end
                    end,
    case TargetBoPlayerId ==0 orelse TargetBoPlayerId == undefined  of
        true ->
            skip;
        false ->
            ?SEND_BIN(TargetBoPlayerId, Bin)
    end,
    erlang:max(HealVal, 1).



%% 计算治疗效果值
%% (
%%     攻击方法术攻击力*技能放缩系数*(1+心法等级*心法关联系数)* ( 1/(实际目标数量^(1/2))) *攻击方伤害放缩系数
%%   + 心法等级对应标准血量*标准伤害放缩系数
%% ) 
%%
%% * 被治疗者治疗增益

calc_heal_value(ActorId, TargetBo, SkillId, TargetCount) ->
	Actor = lib_bt_comm:get_bo_by_id(ActorId),
    SklCfg = mod_skill:get_cfg_data(SkillId),
    ?ASSERT(SklCfg /= null, SkillId),

    MagAtt = lib_bo:get_mag_att(Actor),
    SkillScaling = mod_skill:get_skill_scaling(SklCfg),

    XinfaLv = decide_xinfa_lv_of_actor(Actor, SklCfg, false),
    ?ASSERT(is_integer(XinfaLv), XinfaLv),

    XinfaRelatedCoef = mod_skill:get_xinfa_related_coef(SklCfg),

    DoDamScaling = lib_bo:get_do_mag_dam_scaling(Actor),  % 取法术伤害放缩系数

    XinfaStdVal_Hp = decide_xinfa_std_HP_value_by_xinfa_lv(XinfaLv),

    StdDamScaling = mod_skill:get_std_dam_scaling(SklCfg),

    BeHealEffCoef = lib_bo:get_be_heal_eff_coef(TargetBo),
    HealVal = erlang:round(
                            (   MagAtt * SkillScaling * (1 + XinfaLv*XinfaRelatedCoef) * (1 / (math:pow(TargetCount, 0.4))) * DoDamScaling
                              + XinfaStdVal_Hp*StdDamScaling
                            )
                            * BeHealEffCoef
                          ),

    ?BT_LOG(io_lib:format("calc_heal_value(), ActorId:~p, SkillId:~p, BeHealEffCoef:~p, HealVal:~p~n", [ActorId, SkillId, BeHealEffCoef, HealVal])),
    erlang:max(HealVal, 1).




decide_xinfa_lv_of_actor_on_use_couple_skill(Actor) ->
    XinfaLv_First = erlang:hd( data_couple_heal_eff_xinfa_lv_and_intimacy:get_xinfa_lv_list() ),
    XinfaLv_Last = lists:last( data_couple_heal_eff_xinfa_lv_and_intimacy:get_xinfa_lv_list() ),

    ?ASSERT(util:is_positive_int(XinfaLv_First)),
    ?ASSERT(util:is_positive_int(XinfaLv_Last)),
    ?ASSERT(XinfaLv_Last >= XinfaLv_First),
    ?ASSERT( lists:seq(XinfaLv_First, XinfaLv_Last) =:= data_couple_heal_eff_xinfa_lv_and_intimacy:get_xinfa_lv_list() ),

    Intimacy = lib_bo:get_intimacy_with_spouse(Actor),

    RetXinfaLv = case XinfaLv_Last < XinfaLv_First of
                    true ->  % 容错
                        1;
                    false ->
                        case Intimacy < data_couple_heal_eff_xinfa_lv_and_intimacy:get(XinfaLv_First) of
                            true ->
                                XinfaLv_First;
                            false ->
                                case Intimacy > data_couple_heal_eff_xinfa_lv_and_intimacy:get(XinfaLv_Last) of
                                    true ->
                                        XinfaLv_Last;
                                    false ->
                                        % 和中间值做对比
                                        XinfaLv_Middle = XinfaLv_First + (XinfaLv_Last - XinfaLv_First) div 2,
                                        MiddleIntimacy = data_couple_heal_eff_xinfa_lv_and_intimacy:get(XinfaLv_Middle),
                                        if
                                            Intimacy < MiddleIntimacy ->
                                                % 返回的心法等级所属范围：XinfaLv_First~XinfaLv_Middle
                                                loop_decide_xinfa_lv_of_actor_on_use_couple_skill(Intimacy, XinfaLv_First, {XinfaLv_First, XinfaLv_Middle});
                                            Intimacy > MiddleIntimacy ->
                                                % 返回的心法等级所属范围：XinfaLv_Middle~XinfaLv_Last
                                                loop_decide_xinfa_lv_of_actor_on_use_couple_skill(Intimacy, XinfaLv_Middle, {XinfaLv_Middle, XinfaLv_Last});
                                            true ->
                                                XinfaLv_Middle
                                        end
                                end
                        end
                end,

    ?BT_LOG(io_lib:format("decide_xinfa_lv_of_actor_on_use_couple_skill(), ActorBoId:~p, Intimacy:~p, RetXinfaLv:~p", 
                            [lib_bo:id(Actor), Intimacy, RetXinfaLv])),

    RetXinfaLv.



loop_decide_xinfa_lv_of_actor_on_use_couple_skill(Intimacy, CurCmpXinfaLv, {XinfaLv_Begin, XinfaLv_End}) when CurCmpXinfaLv < XinfaLv_End ->
    CurCmpIntimacy = data_couple_heal_eff_xinfa_lv_and_intimacy:get(CurCmpXinfaLv),
    if
        Intimacy > CurCmpIntimacy ->
            loop_decide_xinfa_lv_of_actor_on_use_couple_skill(Intimacy, CurCmpXinfaLv+1, {XinfaLv_Begin, XinfaLv_End});
        Intimacy < CurCmpIntimacy ->
            ?ASSERT(CurCmpXinfaLv-1 >= XinfaLv_Begin),
            max(CurCmpXinfaLv-1, XinfaLv_Begin);  % max矫正以容错
        true ->
            CurCmpXinfaLv
    end;

loop_decide_xinfa_lv_of_actor_on_use_couple_skill(Intimacy, CurCmpXinfaLv, {XinfaLv_Begin, _XinfaLv_End}) ->
    CurCmpIntimacy = data_couple_heal_eff_xinfa_lv_and_intimacy:get(CurCmpXinfaLv),
    case Intimacy == CurCmpIntimacy of
        true ->
            CurCmpXinfaLv;
        false ->
            ?ASSERT(CurCmpXinfaLv-1 >= XinfaLv_Begin),
            max(CurCmpXinfaLv-1, XinfaLv_Begin)  % max矫正以容错
    end.










    














% %% TODO：
% calc_reduce_mp_by_xinfa_lv(_XinfaLv) ->
%     % 读取心法标准参数配置表，得到一个标准数值，然后套用到公式中计算出结果

%     % FomulaCoefList = data_formula:get(btl_calc_recude_mp_by_xinfa_lv).
%     % ...

%     50.





% %% 添加buff时计算buff的到期回合（到第几回合就过期？）
% calc_buff_expire_round_on_add(FromBoId, ToBoId, BuffTpl) ->
%     % case lib_buff_tpl:get_lasting_round(BuffTpl) of
%     %     0 ->
%     %         0;  % 表示是永久性buff（死亡或战斗结束后才移除）
%     %     LastingRound ->
%     %         get_cur_round() + LastingRound
%     % end.

%     RealLastingRound = calc_buff_real_lasting_round(FromBoId, ToBoId, BuffTpl),    
%     lib_bt_comm:get_cur_round() + RealLastingRound.




%% 添加buff时，计算buff的持续回合数 --duanshihe 2015.05.25 调整算法
calc_buff_lasting_round_on_add(FromBoId, ToBoId, FromSkillId, BuffTpl, TotalTargetCount) ->
    ?ASSERT(TotalTargetCount >= 1, {FromSkillId, BuffTpl, TotalTargetCount}),

    case mod_skill:is_couple_skill(FromSkillId) andalso lib_buff_tpl:is_be_protect_buff(BuffTpl) of
        true ->
            calc_be_protect_buff_rounds_on_use_couple_skill(FromBoId, ToBoId, FromSkillId, BuffTpl, TotalTargetCount);
        false ->
            BaseLastingRound = lib_buff_tpl:get_base_lasting_round(BuffTpl),

            Bo_Caster = lib_bt_comm:get_bo_by_id(FromBoId),
            Bo_Receptor = lib_bt_comm:get_bo_by_id(ToBoId),

            RetRounds = case lib_buff_tpl:get_calc_lasting_round_mode(BuffTpl) of
                            3 -> % 按照心法等级计算
                                calc_round_value_by_xinfalv_for_add_buff(BuffTpl,Bo_Caster, FromSkillId);
                            1 -> % 固定为基础持续回合数
                                ?ASSERT(util:is_positive_int(BaseLastingRound), BuffTpl),
                                BaseLastingRound;
                            2 -> % 按控制类buff的公式计算

                                % 命中率参考值
                                ResistVal = calc_resist_value_for_add_buff(Bo_Caster, Bo_Receptor, BuffTpl),

                                % 技能加成回合
                                SkillAddRoundCoe = calc_fine_round_value_for_add_buff(Bo_Caster, FromSkillId),

                                %基础回合数量根据技能等级修正
                                BaseLastingRound2 = BaseLastingRound * (1 + SkillAddRoundCoe),

                                % 群体衰弱系数
                                HitWeakCoe = 0.75,
                                HitWeakCoe1 = 0.95,

                                HitAdd = case lib_bo:is_avatar(Bo_Caster) of
                                    true -> 
                                        if 
                                            TotalTargetCount > 1 ->
                                                0.1;
                                            true ->
                                                0.3                                        
                                        end;
                                    false -> 
                                        if 
                                            TotalTargetCount > 1 ->
                                                0;
                                            true ->
                                                0.1                                        
                                        end
                                end,

                                % 命中率 如果是群体则衰弱
                                Hit = 
                                    if 
                                        TotalTargetCount > 1 ->
                                            erlang:min(ResistVal * HitWeakCoe * math:pow(HitWeakCoe1,TotalTargetCount),1);
                                        true ->
                                            erlang:min(ResistVal,1)                                           
                                    end + HitAdd,

                                % 回合数修正
                                RoundCorrect = calc_round_value_for_add_buff(Bo_Caster, Bo_Receptor, BuffTpl),   

                                % TagResis = lib_bo:get_frozen_resis(Bo_Receptor),                          

                                % 群体衰弱系数
                                RoundWeakCoe = 0.7,

                                % 最大回合参考值 如果是群体就乘以衰弱值
                                MaxRound = 
                                    if 
                                        TotalTargetCount > 1 ->                              
                                            (BaseLastingRound2 + RoundCorrect) * RoundWeakCoe;                                            
                                        true -> 
                                            BaseLastingRound2 + RoundCorrect 
                                    end,

                                % 最小回合参考
                                MinRound = erlang:min(MaxRound*(0.35+util:rand(0,450)/1000),MaxRound),

                                ?DEBUG_MSG("calc_buff_lasting_round_on_add(), SkillAddRoundCoe=~p BaseLastingRound=~p BaseLastingRound2=~p ResistVal=~p Hit=~p RoundCorrect=~p MaxRound=~p MinRound=~p~n", [SkillAddRoundCoe,BaseLastingRound,BaseLastingRound2, ResistVal, Hit, RoundCorrect, MaxRound, MinRound]),  

                                % 期望值
                                ExpectedVal =
                                    case util:decide_proba_once(Hit) of
                                        fail -> 0  ;
                                        success -> 
                                            if
                                                (MinRound > 0 andalso MaxRound >= MinRound) ->
                                                    util:rand(util:floor(MinRound*100000) -1,util:floor(MaxRound*100000))/100000;
                                                true ->
                                                    0
                                            end                                 
                                    end,

                                % 期望值的整数部分
                                ExpectedVal_IntPart = util:floor(ExpectedVal),
                                % 期望值的小数部分
                                ExpectedVal_DecimalPart = ExpectedVal - ExpectedVal_IntPart,
                                
                                % 期望值
                                % ExpectedVal = BaseLastingRound + RoundCorrect,%% ResistVal * BaseLastingRound / (math:pow(TotalTargetCount, 0.5)),  % 注意：此处的BaseLastingRound有可能为小数
                                % 期望值的整数部分
                                % ExpectedVal_IntPart = util:floor(ExpectedVal),
                                % 期望值的小数部分
                                % ExpectedVal_DecimalPart = ExpectedVal - ExpectedVal_IntPart,

                                %Tmp = erlang:round(
                                %              util:rand(12500, 75000) / 100000 * 2 * ExpectedVal_IntPart
                                %              ),

                                Tmp2 =  case util:decide_proba_once(ExpectedVal_DecimalPart) of
                                            success -> 1;
                                            fail -> 0
                                        end,

                                %?BT_LOG(io_lib:format("calc_buff_lasting_round_on_add(), ResistVal=~p ExpectedVal=~p Tmp=~p Tmp2=~p BaseLastingRound=~p~n", [ResistVal, ExpectedVal, Tmp, Tmp2, BaseLastingRound])),

                                % 定义最大的回合上线
                                CostMaxRound = erlang:min(BaseLastingRound2 * 4.5 ,7) * RoundWeakCoe,
                                ?DEBUG_MSG("calc_buff_lasting_round_on_add(),ExpectedVal=~p CostMaxRound=~p Tmp2=~p ExpectedVal_DecimalPart=~p ExpectedVal_IntPart=~p,RoundCorrect=~p,BaseLastingRound=~p", [ExpectedVal,  CostMaxRound, Tmp2,ExpectedVal_DecimalPart,ExpectedVal_IntPart,RoundCorrect,BaseLastingRound]), 
                                
                                erlang:min(ExpectedVal_IntPart + Tmp2, CostMaxRound)
                        end,

            RetRounds2 = erlang:round(RetRounds),

            RetRounds3 = adjust_buff_lasting_round_by_passi_eff(Bo_Receptor, BuffTpl, RetRounds2),
            ?ASSERT(util:is_nonnegative_int(RetRounds3), RetRounds3),

            ?BT_LOG(io_lib:format("calc_buff_lasting_round_on_add(), FromBoId=~p ToBoId=~p BuffNo=~p RetRounds=~p RetRounds2=~p RetRounds3=~p~n", [FromBoId, ToBoId, lib_buff_tpl:get_no(BuffTpl), RetRounds, RetRounds2, RetRounds3])),

            ?DEBUG_MSG("calc_buff_lasting_round_on_add(), FromBoId=~p ToBoId=~p BuffNo=~p RetRounds=~p RetRounds2=~p RetRounds3=~p~n", [FromBoId, ToBoId, lib_buff_tpl:get_no(BuffTpl), RetRounds, RetRounds2, RetRounds3]),

            RetRounds3
    end.



calc_be_protect_buff_rounds_on_use_couple_skill(FromBoId, ToBoId, _FromSkillId, _BuffTpl, _TotalTargetCount) ->
    FromBo = lib_bt_comm:get_bo_by_id(FromBoId),
    ToBo = lib_bt_comm:get_bo_by_id(ToBoId),
    Intimacy = lib_bt_rela:get_intimacy(FromBo, ToBo),

    L = data_couple_be_protect_buff_rounds_and_intimacy:get_round_count_list(),

    RoundCnt_First = erlang:hd(L),
    RoundCnt_Last = lists:last(L),

    ?ASSERT(util:is_positive_int(RoundCnt_First)),
    ?ASSERT(util:is_positive_int(RoundCnt_Last)),
    ?ASSERT(RoundCnt_Last >= RoundCnt_First),
    ?ASSERT(lists:seq(RoundCnt_First, RoundCnt_Last) =:= L),

    RetRoundCnt = loop_decide_be_protect_buff_rounds_on_use_couple_skill(Intimacy, RoundCnt_First, {RoundCnt_First, RoundCnt_Last}),
    ?BT_LOG(io_lib:format("calc_be_protect_buff_rounds_on_use_couple_skill(), FromBoId:~p, ToBoId:~p, Intimacy:~p, RetRoundCnt:~p", [FromBoId, ToBoId, Intimacy, RetRoundCnt])),
    RetRoundCnt.



loop_decide_be_protect_buff_rounds_on_use_couple_skill(Intimacy, CurCmpRoundCnt, {RoundCnt_First, RoundCnt_Last}) when CurCmpRoundCnt < RoundCnt_Last ->
    CurCmpIntimacy = data_couple_be_protect_buff_rounds_and_intimacy:get(CurCmpRoundCnt),
    if 
        Intimacy > CurCmpIntimacy ->
            loop_decide_be_protect_buff_rounds_on_use_couple_skill(Intimacy, CurCmpRoundCnt+1, {RoundCnt_First, RoundCnt_Last});
        Intimacy < CurCmpIntimacy ->
            max(CurCmpRoundCnt-1, RoundCnt_First);
        true ->
            CurCmpRoundCnt
    end;

loop_decide_be_protect_buff_rounds_on_use_couple_skill(Intimacy, CurCmpRoundCnt, {RoundCnt_First, RoundCnt_Last}) ->
    CurCmpIntimacy = data_couple_be_protect_buff_rounds_and_intimacy:get(CurCmpRoundCnt),
    case Intimacy >= CurCmpIntimacy of
        true ->
            RoundCnt_Last;
        false ->
            max(RoundCnt_Last-1, RoundCnt_First)
    end.






        	



adjust_buff_lasting_round_by_passi_eff(BuffReceptor, BuffTpl, OldRoundCount) ->
    case lib_buff_tpl:is_good(BuffTpl) of
        true ->
            adjust_good_buff_lasting_round_by_passi_eff(BuffReceptor, OldRoundCount);
        false ->
            case lib_buff_tpl:is_bad(BuffTpl) of
                true ->
                    adjust_bad_buff_lasting_round_by_passi_eff(BuffReceptor, OldRoundCount);
                false ->
                    OldRoundCount  % 无需矫正，原值返回
            end
    end.


adjust_good_buff_lasting_round_by_passi_eff(BuffReceptor, OldRoundCount) ->
    NewRoundCount = case lib_bo:find_passi_eff_by_name(BuffReceptor, ?EN_FORCE_CHANGE_GOOD_BUFF_LASTING_ROUND) of
                        null ->
                            case lib_bo:find_passi_eff_by_name(BuffReceptor, ?EN_LENGTHEN_GOOD_BUFF_LASTING_ROUND) of
                                null ->
                                    OldRoundCount;
                                Eff ->
                                    PassiEffCfg = lib_passi_eff:get_cfg_data(Eff#bo_peff.eff_no),
                                    LengthenCount = PassiEffCfg#passi_eff.para,
                                    ?ASSERT(util:is_positive_int(LengthenCount), PassiEffCfg),
                                    OldRoundCount + LengthenCount
                            end;
                        Eff ->
                            PassiEffCfg = lib_passi_eff:get_cfg_data(Eff#bo_peff.eff_no),
                            ForceCount = PassiEffCfg#passi_eff.para,
                            ?ASSERT(util:is_positive_int(ForceCount), PassiEffCfg),
                            ForceCount
                    end,

    erlang:max( erlang:round(NewRoundCount), 1).  % 容错（取整，并且 >= 1）


adjust_bad_buff_lasting_round_by_passi_eff(BuffReceptor, OldRoundCount) ->
    NewRoundCount = case lib_bo:find_passi_eff_by_name(BuffReceptor, ?EN_FORCE_CHANGE_BAD_BUFF_LASTING_ROUND) of
                        null ->
                            case lib_bo:find_passi_eff_by_name(BuffReceptor, ?EN_SHORTEN_BAD_BUFF_LASTING_ROUND) of
                                null ->
                                    OldRoundCount;
                                Eff ->
                                    PassiEffCfg = lib_passi_eff:get_cfg_data(Eff#bo_peff.eff_no),
                                    ShortenCount = PassiEffCfg#passi_eff.para,
                                    ?ASSERT(util:is_positive_int(ShortenCount), PassiEffCfg),
                                    OldRoundCount - ShortenCount
                            end;
                        Eff ->
                            PassiEffCfg = lib_passi_eff:get_cfg_data(Eff#bo_peff.eff_no),
                            ForceCount = PassiEffCfg#passi_eff.para,
                            ?ASSERT(util:is_nonnegative_int(ForceCount), PassiEffCfg),
                            ForceCount
                    end,

    erlang:max( erlang:round(NewRoundCount), 0).  % 容错（取整，并且 >= 0）



% 计算回合数量参考值
% 技能等级*系数/(1+系数*技能等级)
calc_fine_round_value_for_add_buff(Bo_Caster, FromSkillId) ->
    SkillCfg = mod_skill:get_cfg_data(FromSkillId),

    XinfaLv = decide_xinfa_lv_of_actor(Bo_Caster, SkillCfg, false),
    XiShuA = 0.05,
    XiShuB = 0.4,

    XinfaLv*XiShuA/(1+XiShuA*XinfaLv)*XiShuB.


calc_round_value_by_xinfalv_for_add_buff(BuffTpl, Bo_Caster, FromSkillId) ->
    SkillCfg = mod_skill:get_cfg_data(FromSkillId),

    XinfaLv = decide_xinfa_lv_of_actor(Bo_Caster, SkillCfg, false),
    
    case lib_buff_tpl:get_base_lasting_round(BuffTpl) of
        List when is_list(List) ->
            F = fun({Lv,Round}, Sum) ->
                case Lv =< XinfaLv of
                    true ->
                        Round;
                    false ->
                       Sum
                end
            end,

            Round = lists:foldl(F, 1, List),
            Round;
        LastingRound when is_integer(LastingRound) ->
            LastingRound
    end.


%% 对抗值 = (施法者对应封印命中/受击者对应封印抵抗 * 1.4 )^2
%% 其中： 施法者对应封印命中 = 技能放缩系数*施法者原有的所有封印命中+心法等级对应的标准封印值*标准伤害放缩系数
calc_resist_value_for_add_buff(Bo_Caster, Bo_Receptor, BuffTpl) ->

%%    % 如果行动者速度比目标慢 则体现加成属性
%%    SpeedP = case lib_bo:get_act_speed(Bo_Caster) < lib_bo:get_act_speed(Bo_Receptor) of
%%        true ->
%%            1 + lib_bo:get_seal_hit_to_speed(Bo_Caster);
%%        false -> 1
%%    end,

%%    % 是否有指定种类的加成
%%    BoP = case lib_bo:get_type(Bo_Receptor) of
%%        ?OBJ_MONSTER -> 1 + lib_bo:get_seal_hit_to_mon(Bo_Caster);
%%        ?OBJ_PARTNER -> 1 + lib_bo:get_seal_hit_to_partner(Bo_Caster);
%%        _ -> 1
%%    end,
%%    2019.11.8 wjc修改
%%    封印命中率=（max(0,min(1,a*己.封印命中/(己.封印命中+b*敌.封印抗性)+额外封印命中率)*c)+d）*封印状态系数（默认为1）

    Neglect = lib_bo:get_neglect_seal_resis(Bo_Caster),
    XishuN = util:minmax(1-Neglect,0,1),
    Resis = round(lib_bo:get_seal_resis(Bo_Receptor) * XishuN),
    {A,B,C,D} = data_special_config:get('seal_operation_coef'),
    Hit = (max(0,min(1,A * lib_bo:get_raw_seal_hit(Bo_Caster)/( lib_bo:get_raw_seal_hit(Bo_Caster) + B *  Resis) ) * C) + D),
    ?DEBUG_MSG("SpeedP=~p,Hit=~p,Neglect=~p,XishuN=~p,Resis=~p,RawSealHit=~p~n",[lib_bo:get_seal_hit_to_speed(Bo_Caster),Hit,Neglect,XishuN,Resis, lib_bo:get_raw_seal_hit(Bo_Caster) ]),

    TypeCoef = data_special_config:get(seal_type_coef),
    BuffName =  lib_buff_tpl:get_name(BuffTpl),
    {RealHit,XiShu2} = case lists:keyfind(BuffName,1,TypeCoef) of
        false ->
            {Hit,1};
        {_,XiShu} ->
            {Hit * XiShu,XiShu}
%%        ?BFN_FROZEN ->
%%            XiShuA = 1.35,
%%            math:pow(Hit / (Resis * XiShuA), 2);
%%        ?BFN_TRANCE ->
%%            XiShuA = 1.3,
%%            math:pow(Hit / (Resis * XiShuA), 2);
%%        ?BFN_CHAOS ->
%%            XiShuA = 1.45,
%%            math:pow(Hit / (Resis * XiShuA), 2);
%%        _ ->
%%            0    % 其他统一返回0
    end,
    {ok,Bin} = pt_20:write(20200,[4,0,0,0,
        0,0,0,0,0 ,0,0,util:floor(XiShu2*1000) ,util:floor(RealHit*1000)]),
    AtterPlayerId = case Bo_Caster#battle_obj.type == 1 of
                        true ->
                            Bo_Caster#battle_obj.parent_obj_id;
                        false ->
                            case Bo_Caster#battle_obj.type == 2 of
                                true ->
                                    get({get_player_id_by_bo,Bo_Caster#battle_obj.id});
                                false ->
                                    0
                            end
                    end,

    DeferPlayerId = case Bo_Receptor#battle_obj.type == 1 of
                        true ->
                            Bo_Receptor#battle_obj.parent_obj_id;
                        false ->
                            case Bo_Receptor#battle_obj.type == 2 of
                                true ->
                                    get({get_player_id_by_bo,Bo_Receptor#battle_obj.id});
                                false ->
                                    0
                            end
                    end,
    case AtterPlayerId ==0  orelse AtterPlayerId == undefined of
        true ->
            skip;
        false ->
            ?SEND_BIN(AtterPlayerId, Bin)
    end,

    case DeferPlayerId ==0 orelse DeferPlayerId == undefined of
        true ->
            skip;
        false ->
            ?SEND_BIN(DeferPlayerId, Bin)
    end,

    RealHit.



%% 回合数修正 = (0 - 受击者对应封印抵抗/施法者对应封印命中)^3
calc_round_value_for_add_buff(Bo_Caster, Bo_Receptor, BuffTpl) ->
    % 如果行动者速度比目标慢 则体现加成属性
    SpeedP = case lib_bo:get_act_speed(Bo_Caster) < lib_bo:get_act_speed(Bo_Receptor) of
        true -> 
            1 + lib_bo:get_seal_hit_to_speed(Bo_Caster);
        false -> 1
    end,

    % 是否有指定种类的加成
    BoP = case lib_bo:get_type(Bo_Receptor) of
        ?OBJ_MONSTER -> 1 + lib_bo:get_seal_hit_to_mon(Bo_Caster);
        ?OBJ_PARTNER -> 1 + lib_bo:get_seal_hit_to_partner(Bo_Caster);
        _ -> 1
    end,   
    

    Hit = round(lib_bo:get_frozen_hit(Bo_Caster)*SpeedP * BoP),
    Neglect = lib_bo:get_neglect_seal_resis(Bo_Caster),
    XishuN = util:minmax(1-Neglect,0,1),
    Resis = round(lib_bo:get_frozen_resis(Bo_Receptor) * XishuN),

    XiShuC = 1,
    Ret = case lib_buff_tpl:get_name(BuffTpl) of
        ?BFN_FROZEN ->
            (-(1/(Hit/Resis))+(Hit/Resis)) - lib_bo:get_be_froze_round_repair(Bo_Receptor) + lib_bo:get_froze_round_repair(Bo_Caster);
        ?BFN_TRANCE ->
            (-(1/(Hit/Resis))+(Hit/Resis));
        ?BFN_CHAOS ->
            (-(1/(Hit/Resis))+(Hit/Resis)) - lib_bo:get_be_chaos_round_repair(Bo_Receptor) + lib_bo:get_chaos_round_repair(Bo_Caster);
        _ ->
            0    % 其他统一返回0
    end,    

    Ret.


%% 计算buff的实际效果值，目前最多只考虑有两个值
%% @para: Bo_Caster => 施法者
%%        Bo_Receptor => 受法者
%% @return: buff_eff_para结构体
calc_buff_eff_para(Bo_Caster, Bo_Receptor, NewBuff) ->
    BuffName = lib_bo_buff:get_name(NewBuff),
    calc_buff_eff_para(BuffName, Bo_Caster, Bo_Receptor, NewBuff).


calc_buff_eff_para(?BFN_REDUCE_BE_PHY_DAM_SHIELD, Bo_Caster, Bo_Receptor, NewBuff) ->
    {EffRealVal, EffRealVal_2} = calc_buff_eff_real_value__(Bo_Caster, Bo_Receptor, NewBuff),
    % 护盾的剩余层数的初始值为对应的buff模板的参数
    {layer, Layer} = lib_bo_buff:get_buff_tpl_para(NewBuff),
    % ?DEBUG_MSG("calc_buff_eff_para(), BFN_REDUCE_BE_PHY_DAM_SHIELD, EffRealVal:~p, EffRealVal_2:~p, Layer:~p~n", [EffRealVal, EffRealVal_2, Layer]),
    #buff_eff_para{
        eff_real_value = EffRealVal,
        eff_real_value_2 = EffRealVal_2,
        cur_layer = Layer
        };

calc_buff_eff_para(?BFN_REDUCE_BE_DAM_SHIELD, Bo_Caster, Bo_Receptor, NewBuff) ->
    {EffRealVal, EffRealVal_2} = calc_buff_eff_real_value__(Bo_Caster, Bo_Receptor, NewBuff),
    % 护盾的剩余层数的初始值为对应的buff模板的参数
    {layer, Layer} = lib_bo_buff:get_buff_tpl_para(NewBuff),
    % ?DEBUG_MSG("calc_buff_eff_para(), BFN_REDUCE_BE_PHY_DAM_SHIELD, EffRealVal:~p, EffRealVal_2:~p, Layer:~p~n", [EffRealVal, EffRealVal_2, Layer]),
    #buff_eff_para{
        eff_real_value = EffRealVal,
        eff_real_value_2 = EffRealVal_2,
        cur_layer = Layer
    };

calc_buff_eff_para(?BFN_ABSORB_PHY_DAM_TO_MP_SHIELD, Bo_Caster, Bo_Receptor, NewBuff) ->
    {EffRealVal, EffRealVal_2} = calc_buff_eff_real_value__(Bo_Caster, Bo_Receptor, NewBuff),
    % 护盾的剩余层数的初始值为对应的buff模板的参数
    {layer, Layer} = lib_bo_buff:get_buff_tpl_para(NewBuff),
    % ?DEBUG_MSG("calc_buff_eff_para(), BFN_ABSORB_PHY_DAM_TO_MP_SHIELD, EffRealVal:~p, EffRealVal_2:~p, Layer:~p~n", [EffRealVal, EffRealVal_2, Layer]),
    #buff_eff_para{
        eff_real_value = EffRealVal,
        eff_real_value_2 = EffRealVal_2,
        cur_layer = Layer
        };

calc_buff_eff_para(?BFN_UNDEAD_BUT_HEAL_HP_SHIELD, Bo_Caster, Bo_Receptor, NewBuff) ->
    {EffRealVal, EffRealVal_2} = calc_buff_eff_real_value__(Bo_Caster, Bo_Receptor, NewBuff),
    % 护盾的剩余层数的初始值从对应的buff模板的参数中获取
    {_, {layer, Layer}} = lib_bo_buff:get_buff_tpl_para(NewBuff),
    % ?DEBUG_MSG("calc_buff_eff_para(), BFN_UNDEAD_BUT_HEAL_HP_ShIELD, EffRealVal:~p, EffRealVal_2:~p, Layer:~p~n", [EffRealVal, EffRealVal_2, Layer]),
    #buff_eff_para{
        eff_real_value = EffRealVal,
        eff_real_value_2 = EffRealVal_2,
        cur_layer = Layer
        };




% calc_buff_eff_para(?BFN_YOU_YING_MING_WANG, Bo_Caster, Bo_Receptor, NewBuff) ->
%     {EffRealVal, _} = calc_buff_eff_real_value__(Bo_Caster, Bo_Receptor, NewBuff),

%     BuffTplPara = lib_bo_buff:get_buff_tpl_para(NewBuff),

%     {{proba, Proba}, {purge_count, PurgeCount}} = BuffTplPara,

%     % 护盾的剩余层数的初始值为对应的buff模板的参数
%     Layer = lib_bo_buff:get_buff_tpl_para(NewBuff),
%     ?DEBUG_MSG("calc_buff_eff_para(), BFN_YOU_YING_MING_WANG, EffRealVal:~p, EffRealVal_2:~p, Layer:~p~n", [EffRealVal, EffRealVal_2, Layer]),
%     #buff_eff_para{
%         eff_real_value = EffRealVal,
%         eff_real_value_2 = EffRealVal_2,
%         cur_layer = Layer
%         };


% 计算buff参数
calc_buff_eff_para(_BuffName, Bo_Caster, Bo_Receptor, NewBuff) ->
    {EffRealVal, EffRealVal_2} = calc_buff_eff_real_value__(Bo_Caster, Bo_Receptor, NewBuff),
    ?BT_LOG(io_lib:format("calc_buff_lasting_round_on_add(), _BuffName:~p, EffRealVal:~p, EffRealVal_2:~p~n", [_BuffName, EffRealVal, EffRealVal_2])),

    #buff_eff_para{
        eff_real_value = EffRealVal,
        eff_real_value_2 = EffRealVal_2,
        cur_layer = 0   % 无意义，统一为0
        }.


% 原则上每个BUFF仅影响一种属性变化
calc_buff_eff_real_value__(Bo_Caster, Bo_Receptor, NewBuff) ->
    AttrToChangeList = decide_which_attr_to_change(NewBuff),
    % 目前只考虑最多涉及两个属性
    OpMode = lib_bo_buff:get_op_mode(NewBuff),

    case AttrToChangeList of
        [] ->
            EffRealValue =
                case OpMode of
                %特殊1类
                   1 -> do_calc_buff_eff_real_value_duan1(Bo_Caster, NewBuff);
                   2 -> do_calc_buff_eff_real_value_duan2(Bo_Caster, NewBuff);
                   3 -> do_calc_buff_eff_real_value_duan3(Bo_Caster, NewBuff);
                   0 -> 0;
                   _ -> do_calc_buff_eff_real_value_duan4(Bo_Caster, Bo_Receptor, NewBuff)
                end,
            EffRealValue_2 = 0;
        [OneAttrOnly] ->
            EffRealValue =
                case OpMode of
                   1 -> do_calc_buff_eff_real_value_duan1(Bo_Caster, NewBuff);
                   2 -> do_calc_buff_eff_real_value_duan2(Bo_Caster, NewBuff);
                   3 -> do_calc_buff_eff_real_value_duan3(Bo_Caster, NewBuff);
                   0 -> do_calc_buff_eff_real_value(Bo_Caster, Bo_Receptor, NewBuff, OneAttrOnly);
                   _ -> do_calc_buff_eff_real_value_duan4(Bo_Caster, Bo_Receptor, NewBuff)
                end,
            EffRealValue_2 = 0;
        [Attr1, Attr2] ->
            EffRealValue =
                case OpMode of
                   1 -> do_calc_buff_eff_real_value_duan1(Bo_Caster, NewBuff);
                   2 -> do_calc_buff_eff_real_value_duan2(Bo_Caster, NewBuff);
                   3 -> do_calc_buff_eff_real_value_duan3(Bo_Caster, NewBuff);
                   0 -> do_calc_buff_eff_real_value(Bo_Caster, Bo_Receptor, NewBuff, Attr1);
                   _ -> do_calc_buff_eff_real_value_duan4(Bo_Caster, Bo_Receptor, NewBuff)
                end,

            EffRealValue_2 =
                case OpMode of
                   1 -> do_calc_buff_eff_real_value_duan1(Bo_Caster, NewBuff);
                   2 -> do_calc_buff_eff_real_value_duan2(Bo_Caster, NewBuff);
                   3 -> do_calc_buff_eff_real_value_duan3(Bo_Caster, NewBuff);
                   0 -> do_calc_buff_eff_real_value(Bo_Caster, Bo_Receptor, NewBuff, Attr2);
                   _ -> do_calc_buff_eff_real_value_duan4(Bo_Caster, Bo_Receptor, NewBuff)
                end
    end,

    % 叠加类BUFF直接相乘
    CurOverlap = lib_bo_buff:get_cur_overlap(NewBuff),
    ?DEBUG_MSG("wjcTestretbuff ~p~n",[{CurOverlap,EffRealValue}]),

    {EffRealValue * CurOverlap, EffRealValue_2 * CurOverlap}.

% 运算方式1 心法系数 * 等级 （废弃可以使用2）
do_calc_buff_eff_real_value_duan1(Bo_Caster, NewBuff) ->
            XinfaCoef = lib_bo_buff:get_xinfa_coef(NewBuff),
            XinfaLv = get_caster_xinfa_lv_for_add_buff(Bo_Caster, NewBuff),
            util:ceil(XinfaLv * XinfaCoef).

% 运算方式2 整数（心法系数*等级+固定值）
do_calc_buff_eff_real_value_duan2(Bo_Caster, NewBuff) ->
            XinfaCoef = lib_bo_buff:get_xinfa_coef(NewBuff),
            FixValue = lib_bo_buff:get_fix_value(NewBuff),
            XinfaLv = get_caster_xinfa_lv_for_add_buff(Bo_Caster, NewBuff),
            util:ceil(XinfaLv * XinfaCoef + FixValue).

% 运算方式3 小数（心法系数*等级+固定值）
do_calc_buff_eff_real_value_duan3(Bo_Caster, NewBuff) ->
            XinfaCoef = lib_bo_buff:get_xinfa_coef(NewBuff),
            FixValue = lib_bo_buff:get_fix_value(NewBuff),
            XinfaLv = get_caster_xinfa_lv_for_add_buff(Bo_Caster, NewBuff),
            XinfaLv * XinfaCoef + FixValue.   


% 计算参考值
calc_attr_value(A,B,OpMode) ->
	case OpMode of
		11 -> A - B;
		12 -> B - A;
		13 -> util:avg([A,B]);
		14 -> erlang:max(A,B);
		15 -> erlang:min(A,B);
		16 -> A;
		17 -> B;
		18 -> A/B;
		19 -> B/A;
		20 -> A + B;
		21 -> A * B;
		22 -> math:pow(A,2)/(A + B * 3);
		23 -> math:pow(A,2)/(A + B * 3);
        24 -> abs(A - B);
		_ -> 0
	end.

% 运算方式4 参数 施法者 被施法者 buff信息 属性变化
do_calc_buff_eff_real_value_duan4(Bo_Caster, Bo_Receptor, NewBuff) ->
	XinfaCoef = lib_bo_buff:get_xinfa_coef(NewBuff),

    % 心法增加比率
    RateCoef = lib_bo_buff:get_rate_coef(NewBuff),
    FixValue = lib_bo_buff:get_fix_value(NewBuff),
    AttrRate = lib_bo_buff:get_attr_rate(NewBuff),

    % 施法者属性类型
    CasterAttrType = lib_bo_buff:get_caster_attr_type(NewBuff),
    CasterAttrVal = get_caster_attr_total_value(Bo_Caster,CasterAttrType),
    % 目标属性类型
    ReceptorAttrType = lib_bo_buff:get_receptor_attr_type(NewBuff),
    ReceptorAttrVal = get_caster_attr_total_value(Bo_Receptor,ReceptorAttrType),

    % 计算类型
    OpMode2 = lib_bo_buff:get_op_mode(NewBuff),

    {OpMode,IsInt} = 
    case OpMode2 > 100 of
        true ->
            {OpMode2 - 100,true};
        false -> 
            {OpMode2,false}
    end,

    AttrVal = calc_attr_value(CasterAttrVal,ReceptorAttrVal,OpMode),

    ?DEBUG_MSG("OpMode=~p,AttrVal=~p,IsInt=~p",[OpMode,AttrVal,IsInt]),

    % 心法等级
    XinfaLv = get_caster_xinfa_lv_for_add_buff(Bo_Caster, NewBuff),

    % 可能任何一项都可以是 0
    Ret1 = 
    case IsInt of
        true -> util:ceil((XinfaCoef * XinfaLv + FixValue) + ((XinfaLv * RateCoef + AttrRate) * AttrVal));
        false ->          (XinfaCoef * XinfaLv + FixValue) + ((XinfaLv * RateCoef + AttrRate) * AttrVal)
    end,

    % 技能上限
    UpperLimCoef = 
    case IsInt of
        true -> util:ceil(lib_bo_buff:get_upper_limit_coef(NewBuff));
        false -> lib_bo_buff:get_upper_limit_coef(NewBuff)
    end,

    Ret2 = 
    case UpperLimCoef of
        0 -> Ret1;
        _ -> erlang:min(CasterAttrVal * UpperLimCoef,Ret1)
    end,
        
    % ?DEBUG_MSG("Ret1=~p,Ret2=~p,UpperLimCoef=~p,XinfaCoef=~p,XinfaLv=~p,FixValue=~p,AttrRate=~p",[Ret1,Ret2,UpperLimCoef,XinfaCoef,XinfaLv,FixValue,AttrRate]),

    Ret2.

   
do_calc_buff_eff_real_value(Bo_Caster, Bo_Receptor, NewBuff, AttrToChange) ->
            XinfaCoef = lib_bo_buff:get_xinfa_coef(NewBuff),
            RateCoef = lib_bo_buff:get_rate_coef(NewBuff),
            FixValue = lib_bo_buff:get_fix_value(NewBuff),
            AttrRate = lib_bo_buff:get_attr_rate(NewBuff),
            CasterAttrType = lib_bo_buff:get_caster_attr_type(NewBuff),

            CasterXinfaStdVal = get_caster_xinfa_std_value_for_add_buff(Bo_Caster, NewBuff, AttrToChange),

            % 施法者对应属性是取当前的最新值
            CasterAttrVal = get_caster_attr_total_value(Bo_Caster, CasterAttrType),

            % 受法者对应属性是取（进战斗时的）初始值
            ReceptorAttrVal = get_receptor_attr_initial_value(Bo_Receptor, AttrToChange),

            % 属性改变值=心法参数*BUFF释放者对应指定心法等级的标准数值+比例参数*BUFF受者的对应属性+BUFF释放者的某个属性值（通常为物攻或者法攻）*属性比例+ 固定数值
            % 目前对结果向上取整
            RetVal = util:ceil(XinfaCoef*CasterXinfaStdVal + RateCoef*ReceptorAttrVal + CasterAttrVal*AttrRate + FixValue),
            
            case lib_bo_buff:is_dot(NewBuff) of
                true ->  % 策划要求DOT类buff有上限值
                    UpperLimCoef = lib_bo_buff:get_upper_limit_coef(NewBuff),
                    UpperLimVal = util:ceil(CasterXinfaStdVal * UpperLimCoef),
                    erlang:min(RetVal, UpperLimVal);
                false ->
                    RetVal
            end.
    

   

%% 判定buff具体是会影响bo的哪些属性（依据buff名字判断）
decide_which_attr_to_change(Buff) ->
    BuffName = lib_bo_buff:get_name(Buff),
    case BuffName of
        ?BFN_HOT_HP -> [?ATTR_HP];
        ?BFN_HOT_MP -> [?ATTR_MP];
        ?BFN_HOT_HP_MP -> [?ATTR_HP, ?ATTR_MP];
        ?BFN_DOT_HP -> [?ATTR_HP];
        ?BFN_DOT_MP -> [?ATTR_MP];
        ?BFN_DOT_HP_MP -> [?ATTR_HP, ?ATTR_MP];
        ?BFN_ADD_PHY_ATT -> [?ATTR_PHY_ATT];
        ?BFN_ADD_MAG_ATT -> [?ATTR_MAG_ATT];
        ?BFN_REDUCE_PHY_ATT -> [?ATTR_PHY_ATT];
        ?BFN_REDUCE_MAG_ATT -> [?ATTR_MAG_ATT];
        ?BFN_ADD_PHY_DEF -> [?ATTR_PHY_DEF];
        ?BFN_ADD_MAG_DEF -> [?ATTR_MAG_DEF];
        ?BFN_ADD_PHY_MAG_DEF -> [?ATTR_PHY_DEF, ?ATTR_MAG_DEF];
        ?BFN_REDUCE_PHY_DEF -> [?ATTR_PHY_DEF];
        ?BFN_REDUCE_MAG_DEF -> [?ATTR_MAG_DEF];
        ?BFN_REDUCE_PHY_MAG_DEF -> [?ATTR_PHY_DEF, ?ATTR_MAG_DEF];
        ?BFN_ABSORB_PHY_DAM_TO_MP_SHIELD -> [?ATTR_MP];
        ?BFN_REDUCE_BE_PHY_DAM_SHIELD -> [?ATTR_HP];
        ?BFN_REDUCE_BE_DAM_SHIELD -> [?ATTR_HP];
        % ?BFN_DO_PHY_DAM_ENHANCE -> [?ATTR_PHY_ATT];
        ?BFN_ADD_DODGE -> [?ATTR_DODGE];
        ?BFN_REDUCE_DODGE -> [?ATTR_DODGE];
        ?BFN_REDUCE_TEN -> [?ATTR_TEN]; 
        ?BFN_YOUYING_MINGWANG -> [?ATTR_ACT_SPEED];
        ?BFN_SHIXUE_MINGWANG -> [?ATTR_SEAL_RESIS];
        ?BFN_DALI_MINGWANG -> [?ATTR_CRIT];
        ?BFN_ADD_ACT_SPEED -> [?ATTR_ACT_SPEED];
        ?BFN_REDUCE_ACT_SPEED -> [?ATTR_ACT_SPEED];
        ?BFN_ADD_CRIT -> [?ATTR_CRIT];
        ?BFN_TRANS_PHY_DEF_TO_PHY_ATT -> [?ATTR_PHY_ATT];
        ?BFN_TRANS_PHY_MAG_DEF_TO_PHY_ATT -> [?ATTR_PHY_ATT];
        ?BFN_UNDEAD_BUT_HEAL_HP_SHIELD -> [?ATTR_HP];
        ?BFN_REDUCE_SEAL_RESIS -> [?ATTR_SEAL_RESIS];
        ?BFN_ANTI_INVISIBLE_AND_ADD_PHY_MAG_ATT -> [?ATTR_PHY_ATT, ?ATTR_MAG_ATT];


        % ?BFN_PURGE_GOOD_BUFFS_BY_DO_PHY_DAM -> [?xxxxxxxx];


        % TODO: 其他。。。 
        % 

        _ -> []
    end.





%% BUFF释放者对应指定心法等级的标准数值
get_caster_xinfa_std_value_for_add_buff(Bo_Caster, NewBuff, AttrType) ->
    FromSkillId = lib_bo_buff:get_from_skill_id(NewBuff),
    SkillCfg = mod_skill:get_cfg_data(FromSkillId),
    XinfaLv = decide_xinfa_lv_of_actor(Bo_Caster, SkillCfg, false),
    mod_xinfa:get_std_value(XinfaLv, AttrType).

%% BUFF释放者对应的心法等级
get_caster_xinfa_lv_for_add_buff(Bo_Caster, NewBuff) ->
   FromSkillId = lib_bo_buff:get_from_skill_id(NewBuff),
    SkillCfg = mod_skill:get_cfg_data(FromSkillId),
    XinfaLv = decide_xinfa_lv_of_actor(Bo_Caster, SkillCfg, false),
    XinfaLv.

            
% 计算属性参照值
% [
%			hp = 0,                 		% 气血
%           hp_lim = 0,             		% 气血上限
%           loss_hp = 0,            		% 损失气血 = 气血上限-气血
%           mp = 0,                 		% 魔法
%           mp_lim = 0,             		% 魔法上限
%           loss_mp = 0,            		% 损失魔法 = 魔法上限-魔法			
%           phy_att = 0,            		% 物理攻击
%           mag_att = 0,            		% 法术攻击
%           phy_def = 0,            		% 物理防御
%           mag_def = 0,            		% 法术防御
%			act_speed = 0,          		% 出手速度
%			seal_hit = 0,                	% 封印命中（同时影响冰封命中、昏睡命中和混乱命中）
%			seal_resis = 0,              	% 封印抗性（同时影响冰封抗性、昏睡抗性和混乱抗性）%			
%			phy_combo_att_proba = 0,     	% 物理连击概率（是一个放大1000倍的整数）
%			mag_combo_att_proba = 0,     	% 法术连击概率（是一个放大1000倍的整数）
%			strikeback_proba = 0,        	% 反击概率（是一个放大1000倍的整数）
%			pursue_att_proba = 0,        	% 追击概率（是一个放大1000倍的整数）%			
%			do_phy_dam_scaling = 0,      	% 物理伤害放缩系数
%			do_mag_dam_scaling = 0,      	% 法术伤害放缩系数%			
%			ret_dam_proba = 0,           	% 反震（即反弹）概率（是一个放大1000倍的整数）
%			ret_dam_coef = 0,            	% 反震（即反弹）系数%			
%			be_heal_eff_coef = 0,        	% 被治疗效果系数%			
%			be_phy_dam_reduce_coef = 0,  	% 物理伤害减免系数
%			be_mag_dam_reduce_coef = 0,  	% 法术伤害减免系数%			
%			be_phy_dam_shrink = 0,       	% （受）物理伤害缩小值（整数）
%			be_mag_dam_shrink = 0,       	% （受）法术伤害缩小值（整数）%			
%			pursue_att_dam_coef = 0,     	% 追击伤害系数%			
%			absorb_hp_coef = 0,           	% 吸血系数%			
%			qugui_coef = 0,               	% 驱鬼系数
%			phy_crit = 0,                 	% 物理暴击              
%			phy_ten = 0,                  	% 抗物理暴击            
%			mag_crit = 0,                 	% 法术暴击              
%			mag_ten = 0,                  	% 抗法术暴击             
%			phy_crit_coef = 0,            	% 物理暴击程度      
%			mag_crit_coef = 0,            	% 法术暴击程度%			
%			heal_value = 0             		% 治疗强度
%           lv = 0                          % 等级
%     
% ]

get_caster_attr_total_value(Bo_Caster, AttrType) ->

    case AttrType of
    	hp -> lib_bo:get_hp(Bo_Caster);
		hp_lim -> lib_bo:get_hp_lim(Bo_Caster);
		loss_hp -> lib_bo:get_hp_lim(Bo_Caster) - lib_bo:get_hp(Bo_Caster);
		mp -> lib_bo:get_mp(Bo_Caster);
		mp_lim -> lib_bo:get_mp_lim(Bo_Caster);
        anger_lim -> lib_bo:get_anger_lim(Bo_Caster);
		loss_mp -> lib_bo:get_mp_lim(Bo_Caster) - lib_bo:get_mp(Bo_Caster);
		phy_att -> lib_bo:get_phy_att(Bo_Caster);
		mag_att -> lib_bo:get_mag_att(Bo_Caster);
		phy_def -> lib_bo:get_phy_def(Bo_Caster);
		mag_def -> lib_bo:get_mag_def(Bo_Caster);
		act_speed -> lib_bo:get_act_speed(Bo_Caster);
		seal_hit -> lib_bo:get_seal_hit(Bo_Caster);
		seal_resis -> lib_bo:get_seal_resis(Bo_Caster);
		phy_combo_att_proba -> lib_bo:get_phy_combo_att_proba(Bo_Caster);
		mag_combo_att_proba -> lib_bo:get_mag_combo_att_proba(Bo_Caster);
		strikeback_proba -> lib_bo:get_strikeback_proba(Bo_Caster);
		pursue_att_proba -> lib_bo:get_pursue_att_proba(Bo_Caster);
		do_phy_dam_scaling -> lib_bo:get_do_phy_dam_scaling(Bo_Caster);
		do_mag_dam_scaling -> lib_bo:get_do_mag_dam_scaling(Bo_Caster);
		ret_dam_proba -> lib_bo:get_ret_dam_proba(Bo_Caster);
		ret_dam_coef -> lib_bo:get_ret_dam_coef(Bo_Caster);
		be_heal_eff_coef -> lib_bo:get_be_heal_eff_coef(Bo_Caster);
		be_phy_dam_reduce_coef -> lib_bo:get_be_phy_dam_reduce_coef(Bo_Caster);
		be_mag_dam_reduce_coef -> lib_bo:get_be_mag_dam_reduce_coef(Bo_Caster);
		be_phy_dam_shrink -> lib_bo:get_be_phy_dam_shrink(Bo_Caster);
		be_mag_dam_shrink -> lib_bo:get_be_mag_dam_shrink(Bo_Caster);
		pursue_att_dam_coef -> lib_bo:get_pursue_att_dam_coef(Bo_Caster);
		absorb_hp_coef -> lib_bo:get_absorb_hp_coef(Bo_Caster);
		qugui_coef -> lib_bo:get_qugui_coef(Bo_Caster);
		phy_crit -> lib_bo:get_phy_crit(Bo_Caster);
		phy_ten -> lib_bo:get_phy_ten(Bo_Caster);
		mag_crit -> lib_bo:get_mag_crit(Bo_Caster);
		mag_ten -> lib_bo:get_mag_ten(Bo_Caster);
		phy_crit_coef -> lib_bo:get_phy_crit_coef(Bo_Caster);
		mag_crit_coef -> lib_bo:get_mag_crit_coef(Bo_Caster);
		heal_value -> lib_bo:get_heal_value(Bo_Caster);
		lv -> lib_bo:get_lv(Bo_Caster);
        null ->
            0
    end.




get_receptor_attr_initial_value(Bo_Receptor, AttrType) ->
    case AttrType of
        ?ATTR_HP -> lib_bo:get_init_hp_lim(Bo_Receptor);  % 取hp上限，而不是当前值
        ?ATTR_MP -> lib_bo:get_init_mp_lim(Bo_Receptor);  % 取mp上限，而不是当前值

        ?ATTR_PHY_ATT -> lib_bo:get_init_phy_att(Bo_Receptor);
        ?ATTR_MAG_ATT -> lib_bo:get_init_mag_att(Bo_Receptor);
        ?ATTR_PHY_DEF -> lib_bo:get_init_phy_def(Bo_Receptor);
        ?ATTR_MAG_DEF -> lib_bo:get_init_mag_def(Bo_Receptor);

        ?ATTR_HIT -> lib_bo:get_init_hit(Bo_Receptor);
        ?ATTR_DODGE -> lib_bo:get_init_dodge(Bo_Receptor);

        ?ATTR_CRIT -> lib_bo:get_init_crit(Bo_Receptor);
        ?ATTR_TEN -> lib_bo:get_init_ten(Bo_Receptor);

        ?ATTR_ACT_SPEED -> lib_bo:get_init_act_speed(Bo_Receptor);

        ?ATTR_SEAL_HIT -> lib_bo:get_init_seal_hit(Bo_Receptor);
        ?ATTR_SEAL_RESIS -> lib_bo:get_init_seal_resis(Bo_Receptor);

        _ -> ?ASSERT(false, AttrType), 0
    end.
 
%% ---------------------------------
%% 在线对离线战斗中客队属性加成计算
%% ---------------------------------
calc_o2o_battle_guest_attribute_add(Attrs, O2O_BT_TypeCode) ->
    % 获取加成系数配置
    case data_o2o_battle_add_attrs:get(O2O_BT_TypeCode) of
        AddAttrs when is_record(AddAttrs, o2o_bt_add_attrs) ->
            % 根据配置的加成系数计算新的attrs
            Attrs#attrs{
                do_phy_dam_scaling      = calc_add(Attrs#attrs.do_phy_dam_scaling, AddAttrs#o2o_bt_add_attrs.do_phy_dam_scaling)
                ,do_mag_dam_scaling     = calc_add(Attrs#attrs.do_mag_dam_scaling, AddAttrs#o2o_bt_add_attrs.do_mag_dam_scaling)
                ,be_phy_dam_reduce_coef = calc_add(Attrs#attrs.be_phy_dam_reduce_coef, AddAttrs#o2o_bt_add_attrs.be_phy_dam_reduce_coef)
                ,be_mag_dam_reduce_coef = calc_add(Attrs#attrs.be_mag_dam_reduce_coef, AddAttrs#o2o_bt_add_attrs.be_mag_dam_reduce_coef)
                ,be_heal_eff_coef       = calc_add(Attrs#attrs.be_heal_eff_coef, AddAttrs#o2o_bt_add_attrs.be_heal_eff_coef)
                ,act_speed              = calc_rate(Attrs#attrs.act_speed, AddAttrs#o2o_bt_add_attrs.act_speed_rate)
                ,seal_hit               = calc_rate(Attrs#attrs.seal_hit, AddAttrs#o2o_bt_add_attrs.seal_hit_rate)
                ,seal_resis             = calc_rate(Attrs#attrs.seal_resis, AddAttrs#o2o_bt_add_attrs.seal_resis_rate)
            };
        _ ->
            ?ASSERT(false, O2O_BT_TypeCode),
            Attrs
    end.

calc_add(Base, Add) -> Base + Add.
calc_rate(Base, Rate) when is_integer(Base) -> erlang:round( Base * (1 + Rate) );
calc_rate(Base, Rate) when is_float(Base) -> Base * (1 + Rate);
calc_rate(Base, _Rate) -> Base.
