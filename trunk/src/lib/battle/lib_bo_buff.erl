%%%-----------------------------------
%%% @Module  : lib_bo_buff (battle object's buff)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.8.21
%%% @Description: 战斗对象身上所带的buff
%%%-----------------------------------
-module(lib_bo_buff).
-export([
        get_no/1, get_name/1, 
        get_from_bo_id/1, get_from_skill_id/1,
        get_category/1,

        get_buff_tpl_para/1,

        get_eff_type/1,  get_expire_round/1,
        get_cur_overlap/1, get_max_overlap/1,
        get_priority/1, get_icon/1,
        get_expire_events/1,

        get_xinfa_coef/1,
        get_rate_coef/1,
        get_fix_value/1,
        get_attr_rate/1,
        get_caster_attr_type/1,
        get_receptor_attr_type/1,
        get_upper_limit_coef/1,

        get_eff_para/1,
        get_eff_real_value/1,
        get_eff_real_value_2/1,

        get_replacement_rule/1,

    	can_overlap/1,
        can_overlap_new_to_old/2,

        % is_xuli_buff/1,
        
        % is_permanent/1,
        is_removed_after_died/1,
        is_expired/2,

        is_good/1,
        is_bad/1,
        
        is_hot/1,
        is_dot/1,

        is_shield/1,

        is_trance/1,

        get_shield_buff_layer/1,
        set_shield_buff_layer/2,

        get_proba_of_undead_buff/1,
        get_proba_of_undead_but_heal_hp_shield/1,
        get_op_mode/1,
        


        get_dlmw_add_phy_combo_att_proba/1,
        get_dlmw_add_max_combo_att_times/2,
        get_dlmw_add_phy_dam_scaling/1, 

        get_mingwang_buff_force_change_skill_scaling_para/1,

        compare_buff/2,
        sum_eff_para/2,
  trigger_passi_buff_on_lowHP/4,
  trigger_passi_buff_begin_friend_survival/3,
  trigger_passi_buff_begin_enemy_survival/3,
  trigger_passi_buff_while_enemy_die/3,
  trigger_passi_buff_while_arrive_layer/3
    ]).

-include("record/battle_record.hrl").
-include("buff.hrl").




get_no(Buff) -> Buff#bo_buff.buff_no.

get_name(Buff) -> Buff#bo_buff.buff_name.

get_from_bo_id(Buff) -> Buff#bo_buff.from_bo_id.

get_from_skill_id(Buff) -> Buff#bo_buff.from_skill_id.

get_category(Buff) ->
    % 从buff模板获取
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_category(BuffTpl).


%% 获取buff对应的buff模板的参数
get_buff_tpl_para(Buff) ->
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_para(BuffTpl).
    


get_eff_type(Buff) -> Buff#bo_buff.eff_type.

get_expire_round(Buff) -> Buff#bo_buff.expire_round.

get_cur_overlap(Buff) -> Buff#bo_buff.cur_overlap.

get_max_overlap(Buff) -> Buff#bo_buff.max_overlap.

get_priority(Buff) ->
    % 从buff模板获取
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_priority(BuffTpl).

get_icon(Buff) ->
    % 从buff模板获取
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_icon(BuffTpl).

get_expire_events(Buff) ->
    % 从buff模板获取
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_expire_events(BuffTpl).




get_xinfa_coef(Buff) ->
    % 从buff模板获取
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_xinfa_coef(BuffTpl).


get_rate_coef(Buff) ->
    % 从buff模板获取
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_rate_coef(BuffTpl).



get_fix_value(Buff) ->
    % 从buff模板获取
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_fix_value(BuffTpl).


get_attr_rate(Buff) ->
    % 从buff模板获取
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_attr_rate(BuffTpl).



get_caster_attr_type(Buff) ->
    % 从buff模板获取
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_caster_attr_type(BuffTpl).

get_receptor_attr_type(Buff) ->
	% 从buff模板获取
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_receptor_attr_type(BuffTpl).

get_op_mode(Buff) ->
    % 从buff模板获取
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_op_mode(BuffTpl).


get_upper_limit_coef(Buff) ->
    % 从buff模板获取
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:get_upper_limit_coef(BuffTpl).


get_eff_para(Buff) -> Buff#bo_buff.eff_para.



get_eff_real_value(Buff) ->
    EffPara = get_eff_para(Buff),
    EffPara#buff_eff_para.eff_real_value.


get_eff_real_value_2(Buff) ->
    EffPara = get_eff_para(Buff),
    EffPara#buff_eff_para.eff_real_value_2.




%% 
get_replacement_rule(Buff) ->
    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    case lib_buff_tpl:get_replacement_rule(BuffTpl) of
        1 ->
            coexist;  % 共存
        2 ->
            replace;  % 替换
        3 ->
            occupy;    % 挤占
        _Any ->  % 做容错
            ?ASSERT(false, BuffTpl),
            occupy
    end.




% %% 是否蓄力类buff？
% is_xuli_buff(Buff) ->
%     Buff#bo_buff.buff_name == ?BFN_XULI.






% %% buff是否永久性buff？(永久是指死亡后或战斗结束后才移除)
% is_permanent(Buff) ->
%     Buff#bo_buff.expire_round >= ?PERMANENT_LASTING_ROUND.



%% buff是否死亡后移除？
is_removed_after_died(Buff) ->
    % Buff#bo_buff.buff_name == ?BFN_TRANS_PHY_DEF_TO_ATT_TILL_DIE
    %orelse ...
    % orelse false.

    BuffTpl = lib_buff_tpl:get_tpl_data(Buff#bo_buff.buff_no),
    lib_buff_tpl:is_removed_after_died(BuffTpl).

    



%% buff是否已到期？
is_expired(Buff, CurRound) ->
    % case is_permanent(Buff) of
    %     true ->
    %         false;
    %     false ->
            CurRound >= get_expire_round(Buff).
    % end.

%% 作废！
% %% buff是否可以被移除了？
% can_be_removed(Buff, CurRound) ->
%     case is_xuli_buff(Buff) of
%         true ->
%             % 蓄力类buff，为配合客户端的表现需要，到期后延迟一回合再删除
%             CurRound >= get_expire_round(Buff) + 1;
%         false ->
%             % 非蓄力buff，过期即可以移除
%             is_expired(Buff, CurRound)
%     end.


%% 是否为增益buff？
is_good(Buff) ->
    Buff#bo_buff.eff_type == good.

%% 是否为减益buff？
is_bad(Buff) ->
    Buff#bo_buff.eff_type == bad.
            

%% 是否HOT类buff？
is_hot(Buff) ->
    BuffName = Buff#bo_buff.buff_name,
    BuffName == ?BFN_HOT_HP 
    orelse BuffName == ?BFN_HOT_MP
    orelse BuffName == ?BFN_HOT_HP_MP.

 
%% 是否DOT类buff？
is_dot(Buff) ->
    BuffName = Buff#bo_buff.buff_name,
    BuffName == ?BFN_DOT_HP
    orelse BuffName == ?BFN_DOT_MP
    orelse BuffName == ?BFN_DOT_HP_MP.

%% 是否昏睡类buff?
is_trance(Buff) ->
    BuffName = Buff#bo_buff.buff_name,
    BuffName == ?BFN_TRANCE.


%% 是否护盾类buff？
is_shield(Buff) ->
    BuffName = Buff#bo_buff.buff_name,
    BuffName == ?BFN_REDUCE_BE_PHY_DAM_SHIELD orelse BuffName == ?BFN_ABSORB_PHY_DAM_TO_MP_SHIELD orelse BuffName == ?BFN_REDUCE_BE_DAM_SHIELD.


%% 获取护盾类buff当前剩余的层数
get_shield_buff_layer(ShieldBuff) ->
    % ShieldBuff#bo_buff.eff_real_value_2. 
    EffPara = get_eff_para(ShieldBuff),
    EffPara#buff_eff_para.cur_layer.
    

%% 设置护盾类buff当前剩余的层数
set_shield_buff_layer(ShieldBuff, NewLayer) ->
    EffPara = get_eff_para(ShieldBuff),
    NewEffPara = EffPara#buff_eff_para{cur_layer = NewLayer},
    ShieldBuff#bo_buff{eff_para = NewEffPara}.




%% 获取不死buff的抵挡死亡的概率（放大了1000倍）
get_proba_of_undead_buff(Buff) ->
    ?ASSERT(Buff#bo_buff.buff_name == ?BFN_UNDEAD),
    {proba, Proba} = get_buff_tpl_para(Buff),
    ?ASSERT(util:is_nonnegative_int(Proba), Buff),
    Proba.



%% 获取不死护盾buff的抵抗死亡的概率（放大了1000倍）
get_proba_of_undead_but_heal_hp_shield(Buff) ->
    ?ASSERT(Buff#bo_buff.buff_name == ?BFN_UNDEAD_BUT_HEAL_HP_SHIELD),
    {{proba, Proba}, _} = get_buff_tpl_para(Buff),
    ?ASSERT(util:is_nonnegative_int(Proba), Buff),
    Proba.







% %% buff是否最多只能有一个？
% can_only_have_one(BuffName) ->
    
%     ...



%% 大力冥王buff所提升的连击率（放大了1000倍）
get_dlmw_add_phy_combo_att_proba(DLMW_Buff) ->
    BuffTplPara = get_buff_tpl_para(DLMW_Buff),
    {{combo_att_proba, Proba}, _, _, _,_} = BuffTplPara,
    ?ASSERT(util:is_nonnegative_int(Proba), DLMW_Buff),
    Proba.

%% 大力冥王buff所提升的最大连击数
get_dlmw_add_max_combo_att_times(Bo,DLMW_Buff) ->
    BuffTplPara = get_buff_tpl_para(DLMW_Buff),

    Lv = lib_bo:get_lv(Bo),
    {_, {max_combo_att_times, AddTimes}, _, _,{lv_add,LvAdd}} = BuffTplPara,
    AddTimes_ = AddTimes + erlang:round(erlang:max(0, util:ceil(Lv/LvAdd))),

    ?DEBUG_MSG("Lv=~p,LvAdd=~p,AddTimes=~p,AddTimes_=~p",[Lv,LvAdd,AddTimes,AddTimes_]),
    ?ASSERT(util:is_nonnegative_int(AddTimes), DLMW_Buff),
    AddTimes_.

%% 大力冥王buff所提升的物理伤害系数
get_dlmw_add_phy_dam_scaling(DLMW_Buff) ->
    BuffTplPara = get_buff_tpl_para(DLMW_Buff),
    {_, _, _, {add_do_phy_dam_scaling, ScalingVal},_} = BuffTplPara,
    ScalingVal.

get_mingwang_buff_force_change_skill_scaling_para(Buff) ->
    BuffName = get_name(Buff),
    BuffTplPara = get_buff_tpl_para(Buff),
    case BuffName of
        ?BFN_YOUYING_MINGWANG ->
            {_, _, {force_change_skill_scaling, _SkillId, _ForceSkillScaling}=RetPara, _} = BuffTplPara,
            ?ASSERT(mod_skill:is_valid_skill_id(_SkillId)),
            RetPara;
        ?BFN_SHIXUE_MINGWANG ->
            {_, {force_change_skill_scaling, _SkillId, _ForceSkillScaling}=RetPara} = BuffTplPara,
            ?ASSERT(mod_skill:is_valid_skill_id(_SkillId)),
            RetPara;
        ?BFN_DALI_MINGWANG ->
            {_, _, {force_change_skill_scaling, _SkillId, _ForceSkillScaling}=RetPara, _,_} = BuffTplPara,
            ?ASSERT(mod_skill:is_valid_skill_id(_SkillId)),
            RetPara;
        _ ->
            error
    end.



can_overlap(Buff) ->
    Buff#bo_buff.max_overlap > 1.



%% buff层数是否叠加满了？
is_overlap_full(Buff) ->
    Buff#bo_buff.cur_overlap >= Buff#bo_buff.max_overlap.





%% 判断新buff是否可以叠加到旧buff
can_overlap_new_to_old(NewBuff, OldBuff) ->
    case two_are_same_type(NewBuff, OldBuff) of
        false ->
            false;
        true ->
            case can_overlap(OldBuff) andalso can_overlap(NewBuff) of
                false ->
                    false;
                true ->
                    % 旧buff是否叠加满了？
                    case is_overlap_full(OldBuff) of
                        true ->
                            false;
                        false ->
                            true
                    end
            end
    end.


    
    



%% 两个bo_buff是否同类型？
two_are_same_type(A, B) ->
    A#bo_buff.buff_name == B#bo_buff.buff_name.



%% 对同类型的两个buff的效果参数求和
%% @return: 新的效果参数
sum_eff_para(A, B) ->
    ?ASSERT(two_are_same_type(A, B), {A, B}),

    BuffName = A#bo_buff.buff_name,

    case BuffName of

        % TODO: 对非数值类型的效果参数做特定处理（不能只是简单的相加）
        %?BFN_XXX ->
            % ...


        _ ->  % 默认参数效果是数值类型

            ?ASSERT(is_number(A#bo_buff.eff_para), A#bo_buff.eff_para),
            ?ASSERT(is_number(B#bo_buff.eff_para), B#bo_buff.eff_para),

            A#bo_buff.eff_para + B#bo_buff.eff_para
    end.



% %% 比较同类型的两个buff的效果参数
% %% @return: equal, larger, smaller
% compare_eff_para(A, B) ->

%     ?ASSERT(two_are_same_type(A, B), {A, B}),

%     BuffName = A#bo_buff.buff_name,

%     case BuffName of

%         % TODO: 对特殊类型的效果参数做特定的判断
%         %?BFN_XXX ->
%             % ...


%         _ ->  % 默认判断方式
%             if 
%                 A#bo_buff.eff_para > B#bo_buff.eff_para ->
%                     larger;
%                 A#bo_buff.eff_para < B#bo_buff.eff_para ->
%                     smaller;
%                 true ->
%                     equal
%             end
%     end.

            



%% 比较两个bo_buff的优先级
%% @return: higher =>  A比B高级
%%          lower  =>  A比B低级
%%          equal  =>  优先级相等
compare_buff(A, B) ->
    ?ASSERT(is_record(A, bo_buff), A),
    ?ASSERT(is_record(B, bo_buff), B),

    PrioA = get_priority(A),
    PrioB = get_priority(B),

    if 
        PrioA > PrioB ->
            higher;
        PrioA < PrioB ->
            lower;
        true  ->
            equal
    end.


%%触发被动buff
trigger_passi_buff_on_lowHP(DeferHpLeft,Defer3,AtterId, BeEffList1) ->
  FBeBuff = fun(BeBuffX,Acc) ->
    case BeBuffX#bo_peff.judge_type of
      0 ->
        %%小于等于
        case util:ceil(DeferHpLeft / Defer3#battle_obj.attrs#attrs.hp_lim* 1000) =< BeBuffX#bo_peff.target_for_add_buff of
          true ->
            do_handle_trigger_passi(Defer3,AtterId, BeBuffX, Acc);
          false ->
            Acc
        end;
      1 ->
        case util:ceil(DeferHpLeft / Defer3#battle_obj.attrs#attrs.hp_lim* 1000) >= BeBuffX#bo_peff.target_for_add_buff of
          true ->
            %%判断触发次数是否已满
            do_handle_trigger_passi(Defer3,AtterId, BeBuffX, Acc);
          false ->
            Acc
        end
    end
            end,
  %%返回对象和buff表的数组
  lists:foldl(FBeBuff,[],BeEffList1).

%% 友方存活单位数量
trigger_passi_buff_begin_friend_survival(Defer3,AtterId, BeEffList1) ->
  FBeBuff = fun(BeBuffX,Acc) ->
    case BeBuffX#bo_peff.judge_type of
      0 ->
        %%小于等于
        case lib_bt_comm:get_myside_living_bo_count(lib_bo:get_side(Defer3)) =< BeBuffX#bo_peff.target_for_add_buff of
          true ->
            do_handle_trigger_passi(Defer3,AtterId, BeBuffX, Acc);
          false ->
            Acc
        end;
      1 ->
        case lib_bt_comm:get_myside_living_bo_count(lib_bo:get_side(Defer3)) >= BeBuffX#bo_peff.target_for_add_buff of
          true ->
            do_handle_trigger_passi(Defer3,AtterId, BeBuffX, Acc);
          false ->
            Acc
        end
    end
            end,
  %%返回对象和buff表的数组
  lists:foldl(FBeBuff,[],BeEffList1).


%% 敌方方存活单位数量
trigger_passi_buff_begin_enemy_survival(Defer3,AtterId, BeEffList1) ->
  FBeBuff = fun(BeBuffX,Acc) ->
    case BeBuffX#bo_peff.judge_type of
      0 ->
        %%小于等于
        case lib_bt_comm:get_otherside_living_bo_count(lib_bo:get_side(Defer3)) =< BeBuffX#bo_peff.target_for_add_buff of
          true ->
            do_handle_trigger_passi(Defer3,AtterId, BeBuffX, Acc);
          false ->
            Acc
        end;
      1 ->
        case lib_bt_comm:get_otherside_living_bo_count(lib_bo:get_side(Defer3)) >= BeBuffX#bo_peff.target_for_add_buff of
          true ->
            do_handle_trigger_passi(Defer3,AtterId, BeBuffX, Acc);
          false ->
            Acc
        end
    end
            end,
  %%返回对象和buff表的数组
  lists:foldl(FBeBuff,[],BeEffList1).

%%敌方死亡时加buff
trigger_passi_buff_while_enemy_die(Defer3,AtterId, BeEffList1) ->
  FBeBuff = fun(BeBuffX,Acc) ->

    do_handle_trigger_passi(Defer3,AtterId, BeBuffX, Acc)

            end,
  %%返回对象和buff表的数组
  lists:foldl(FBeBuff,[],BeEffList1).

%%拥有某buff并达到规定的层数触发
trigger_passi_buff_while_arrive_layer(Defer3,AtterId, BeEffList1) ->
  FBeBuff =
    fun(BeBuffX,Acc) ->
      {BuffNo, Overlap} = BeBuffX#bo_peff.target_for_add_buff,
      case lib_bo:find_buff_by_no(Defer3, BuffNo) of
        null -> Acc;
        BuffData -> case BuffData#bo_buff.cur_overlap >= Overlap of
                      true ->
                        do_handle_trigger_passi(Defer3,AtterId, BeBuffX, Acc);
                      false ->
                        Acc
                    end
      end
    end,
  %%返回对象和buff表的数组
  lists:foldl(FBeBuff,[],BeEffList1).

do_handle_trigger_passi(Defer3,AtterId, BeBuffX, Acc) ->
%%判断触发次数是否已满
  TriggerTimes =
    case get({BeBuffX#bo_peff.eff_no, Defer3#battle_obj.id}) of
      undefined ->
        put({BeBuffX#bo_peff.eff_no, Defer3#battle_obj.id}, 1),
        0;
      HavedTriggerTimes ->
        HavedTriggerTimes
    end,
  case  TriggerTimes >  (BeBuffX#bo_peff.trigger_times - 1) of
    true ->
      Acc;
    false ->
      case lib_bt_util:test_proba( BeBuffX#bo_peff.trigger_proba) of
        fail ->
          [];
        success ->
          put({BeBuffX#bo_peff.eff_no, Defer3#battle_obj.id}, TriggerTimes + 1),
          Acc ++ lib_bo:try_apply_passi_eff_add_buff_on_condition(Defer3,AtterId , BeBuffX)
      end
  end.


    % case two_are_same_type(A, B) of
    %     false ->
    %         diff;
    %     true ->
    %         % 同类型buff，则先依据剩余回合数做比较，再依据效果值做比较
    %         % if
    %         %     A#bo_buff.expire_turn > B#bo_buff.expire_turn ->
    %         %         greater;
    %         %     A#bo_buff.expire_turn < B#bo_buff.expire_turn ->
    %         %         less;
    %         %     true ->
    %         %         if
    %         %             A#bo_buff.eff_value > B#bo_buff.eff_value ->
    %         %                 greater;
    %         %             A#bo_buff.eff_value < B#bo_buff.eff_value ->
    %         %                 less;
    %         %             true ->
    %         %                 equal
    %         %         end
    %         % end

            
    %         % TODO： 简单的非正式规则：依据效果值和持续回合数比较
    %         A_IsPermanent = is_permanent(A),
    %         B_IsPermanent = is_permanent(B),

    %         CmpEffParaResult = compare_eff_para(A, B),

    %         if
    %             CmpEffParaResult == larger ->
    %                 higher;
    %             CmpEffParaResult == smaller ->
    %                 lower;
    %             true ->  % eff para are equal
    %                 if
    %                     A_IsPermanent andalso (not B_IsPermanent) ->
    %                         higher;
    %                     (not A_IsPermanent) andalso B_IsPermanent ->
    %                         lower;
    %                     true ->
    %                         equal
    %                 end
    %         end
    % end.



