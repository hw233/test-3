%%%--------------------------------------
%%% @Module: lib_partner
%%% @Author: huangjf
%%% @Created: 2013.7.27
%%% @Modify:  zhangwq 201310.22
%%% @Description: 宠物的相关函数
%%%--------------------------------------


-module(lib_partner).

-export([
        get_partner/1,
        get_no/1,
        get_id/1,
        get_exp_lim/1,
		get_total_exp/1,
		get_goods_cost_sum_cultivate/1,
		get_goods_cost_sum_evolve/1,
		get_goods_cost_sum_awake/1,
		get_goods_cost_sum_refine/1,
        get_exp/1, set_exp/2,
        get_lv/1, set_lv/2,
        add_exp/4, add_exp_without_world_lv/4,
        get_nature/1,
        get_quality/1, set_quality/2,
        get_name/1,
        get_race/1, get_faction/1,
        get_sex/1,
        get_intimacy/1, set_intimacy/2, get_intimacy_lim/1,
        get_intimacy_lv/1, set_intimacy_lv/2, add_intimacy/3,
        get_evolve_lv/1, set_evolve_lv/2, get_evolve/1, set_evolve/2, add_evolve/3, 
		get_awake_lv/1, set_awake_lv/2, get_awake_illusion/1, set_awake_illusion/2,
		get_exclusive_skill/1, set_exclusive_skill/2,
        get_cultivate_lv/1, set_cultivate_lv/2, get_cultivate_layer/1, set_cultivate_layer/2,
        get_cultivate/1, get_cultivate_lim/2, set_cultivate/2, add_cultivate_level/2,
        get_state/1, set_state/2, set_join_battle_time/1,
        get_battle_power/1,
        get_loyalty/1, get_loyalty_lim/1, set_loyalty/2,
        get_cur_battle_num/1, set_cur_battle_num/2,
        get_life/1, set_life/2, get_life_lim/1,

        get_max_postnatal_skill_slot/1, set_max_postnatal_skill_slot/2,
        get_equip_skill/1,get_skill_list/1, set_skill_list/2,  % 获取宠物的所有技能列表 return skl_brief结构体列表
        get_skill_name_list/1,
        get_initiative_skill_list/1,
        get_passive_skill_list/1,
        get_passive_skill_list_of_mount/1,
        get_postnatal_skill_list/1,
        get_inborn_skill_name_list/1,
        get_postnatal_skill_name_list/1,
        get_AI_list/1,
        is_main_partner/1,                   % 判断是否主宠
        is_follow_partner/1,
        get_position/1, set_position/2,
        get_follow_state/1, set_follow_state/2,
        is_fighting/1, set_rest_state/1,
        is_locked/1,
		is_home_work/1,
        get_owner_id/1,
        get_mood_no/1, set_mood_no/2,                                       % 获取设置女妖心情编号
        get_last_update_mood_time/1, set_last_update_mood_time/2,           % 获取设置上次女妖更新心情时间
        get_update_mood_count/1, set_update_mood_count/2,
        get_wash_count/1, set_wash_count/2,                                 % 洗髓次数
        decide_mood_no/0,
        get_buff_no_list/1,
        get_ref_lv/1, get_ref_lv_step/1, get_evolve_coef/1,

        get_base_grow/1,
        get_base_life_aptitude/1,
        get_base_mag_aptitude/1,
        get_base_phy_att_aptitude/1,
        get_base_mag_att_aptitude/1,
        get_base_phy_def_aptitude/1,
        get_base_mag_def_aptitude/1,
        get_base_speed_aptitude/1,
		
		get_base_grow_tmp/1,
        get_base_life_aptitude_tmp/1,
        get_base_mag_aptitude_tmp/1,
        get_base_phy_att_aptitude_tmp/1,
        get_base_mag_att_aptitude_tmp/1,
        get_base_phy_def_aptitude_tmp/1,
        get_base_mag_def_aptitude_tmp/1,
        get_base_speed_aptitude_tmp/1,
		
		
        set_base_train_attrs/2,

        get_cur_grow/1,
        get_cur_life_aptitude/1,
        get_cur_mag_aptitude/1,
        get_cur_phy_att_aptitude/1,
        get_cur_mag_att_aptitude/1,
        get_cur_phy_def_aptitude/1,
        get_cur_mag_def_aptitude/1,
        get_cur_speed_aptitude/1,
		get_partner_info_from_crossing/3,

        get_max_grow/1,
        get_max_life_aptitude/1,
        get_max_mag_aptitude/1,
        get_max_phy_att_aptitude/1,
        get_max_mag_att_aptitude/1,
        get_max_phy_def_aptitude/1,
        get_max_mag_def_aptitude/1,
        get_max_speed_aptitude/1,

        get_version/1, set_version/2, set_dirty_flag/2,
        get_add_skill_fail_cnt/1, set_add_skill_fail_cnt/2,

        % --- interfaces about attributes ---
        set_equip_add_attrs/2,
        init_total_attrs/1,
        get_total_attrs/1, set_total_attrs/2,
        get_hp_lim/1,
        get_hp/1, set_hp/2, add_hp/2, set_hp_mp/3,
        get_mp_lim/1, get_base_mp_lim/1,
        get_mp/1, set_mp/2, add_mp/2,
        get_phy_att/1, get_mag_att/1,
        get_phy_def/1, get_mag_def/1,

        get_phy_crit/1, get_mag_crit/1,
        get_phy_ten/1, get_mag_ten/1,

        get_hit/1, get_dodge/1, get_crit/1, get_ten/1,
        get_anger/1, get_anger_lim/1,
        get_act_speed/1,
        get_luck/1,

        get_frozen_hit/1, get_frozen_resis/1,
        get_trance_hit/1, get_trance_resis/1,
        get_chaos_hit/1, get_chaos_resis/1,
        get_seal_hit/1, get_seal_resis/1,

        get_heal_value/1,

        get_do_phy_dam_scaling/1, get_do_mag_dam_scaling/1,
        get_crit_coef/1,

        has_skill/2,                                %%  判断某个宠物是否有某个技能
        has_skill/3,

        can_goto_fight_once/1,                      %% 判定一次是否可以实际出战

        get_showing_equips/1, set_showing_equips/2, get_showing_equips_base_setting/1,

        decide_new_quality_evolve_lv/2,

        calc_base_attrs/1,                          %% 计算宠物基本属性
        recount_equip_add_and_total_attrs/2,        %% 重算装备的加成属性和总属性
        recount_total_attrs/1,                      %% 重算总属性（调用此函数时，须事先重算好所有其他的属性，如基础属性、装备的加成属性）
        recount_equip_add_attrs/1,                  %% 重新计算装备的加成属性
        calc_equip_add_attrs/1,

        calc_battle_power/1,
        set_battle_power/2,
        recount_battle_power/1,

        % calc_passi_eff_attrs/1,                     %% 计算被动技能效果加成
        % recount_passi_eff_attrs/1,                  %% 重新被动技能效果加成

        % calc_buff_eff_attrs/1,                      %% 计算buff效果加成
        % recount_buff_eff_attrs/1,                   %% 重新buff效果加成

        change_lv_by_exp/3,
        notify_main_partner_info_change_to_AOI/2,
        notify_cli_info_change/2,
        on_attr_change/2,                       %   当关联的坐骑属性发生变化时调用（包括坐骑关联或取消关联宠物时)
        get_mount_id/1, set_mount_id/2,         %   得到或设置关联坐骑id

        get_base_str/1, get_base_agi/1, get_base_stam/1, get_base_con/1, get_base_spi/1,
        get_total_str/1, get_total_agi/1, get_total_stam/1, get_total_con/1, get_total_spi/1,
        get_free_talent_points/1, set_free_talent_points/2,
        reset_lv_to_1/1,
        set_base_str/2, set_base_con/2, set_base_stam/2, set_base_spi/2, set_base_agi/2,
        get_base_talents/1,get_total_talents/1,allot_free_talent_points/3,reset_free_talent_points/2,
        build_talents_bitstring/1,
        reset_art_total_attrs/2,
        is_owner_online/1,

		get_skills_use/1,
		set_skills_use/2,
		
		get_attr_refine/1,
		set_attr_refine/2,
    	get_arts/1,
		set_arts/2,
		get_cost_refine/1,
		set_cost_refine/2

	]).


-include("record.hrl").
-include("partner.hrl").
-include("ets_name.hrl").
-include("pt_17.hrl").
-include("record/goods_record.hrl").
-include("prompt_msg_code.hrl").
-include("attribute.hrl").
-include("obj_info_code.hrl").
-include("skill.hrl").
-include("bo.hrl").
-include("prompt_msg_code.hrl").
-include("common.hrl").
-include("buff.hrl").
-include("effect.hrl").
-include("xinfa.hrl").
-include("goods.hrl").
-include("abbreviate.hrl").
-include("pt_12.hrl").
-include("num_limits.hrl").
-include("player.hrl").
-include("five_elements.hrl").

-include("record/guild_record.hrl").

-include("ref_attr.hrl").
-include("mount.hrl").

get_no(Partner) ->
    Partner#partner.no.

get_id(Partner) ->
    Partner#partner.id.


%% 依据宠物id获取宠物对象
%% @return： null | partner结构体
get_partner(PartnerId) ->
	case ets:lookup(?ETS_PARTNER, PartnerId) of
		[] -> null;
		[Partner] -> Partner
	end.




%% 获取武将对应等级经验上限
get_exp_lim(Lv) ->
    case Lv =:= 0 of
        true -> 0;
        false -> data_par_lv_relate:get_exp_lim(Lv)
    end.

get_intimacy_lim(Lv) ->
    Data = data_intimacy_lv_relate:get(Lv),
    Data#intimacy_lv_relate_data.intimacy_lim.


get_exp(Partner) ->
    Partner#partner.exp.


%% 获取宠物当前总经验值, 用于计算放生时返还的道具数量 2020.02.25
get_total_exp(Partner) ->
	Lv = get_lv(Partner),
	Exp = get_exp(Partner),
	get_total_exp2(Lv, Exp).

get_total_exp2(Lv, Exp) ->
	case get_exp_lim(Lv) of
		0 ->
			Exp;
		ExpLim ->
			get_total_exp2(Lv - 1, Exp + ExpLim)
	end.


%% 获取宠物当前修炼等级总共已消耗的修炼丹的数量
%% @return : [{GoodsNo, GoodsNum}]
get_goods_cost_sum_cultivate(Partner) ->
	CultivateLv = get_cultivate_lv(Partner),
	CultivateLayer = get_cultivate_layer(Partner),
	Nos = data_partner_cultivate:get_all_cultivate_no_list(),
	case get_cultivate_lv_layer_to_no(Nos, {CultivateLv, CultivateLayer}) of
		null ->
			[];
		NoCurrent ->
			lists:foldl(fun(No, Acc) when No =< NoCurrent ->
								{Lv, Layer} = data_partner_cultivate:get(No),
								#partner_cultivate{alchemy_no = AlchemyNo, alchemy_num = AlchemyNum} = data_partner_cultivate:get(Lv, Layer),
								case lists:keytake(AlchemyNo, 1, Acc) of
									{value, {AlchemyNo, Count}, Acc2} ->
										[{AlchemyNo, Count + AlchemyNum}|Acc2];
									?false ->
										[{AlchemyNo, AlchemyNum}|Acc]
								end;
						   (_No, Acc) ->
								Acc
						end, [], Nos)
	end.


get_cultivate_lv_layer_to_no([No|Nos], {CultivateLv, CultivateLayer}) ->
	case data_partner_cultivate:get(No) of
		{CultivateLv, CultivateLayer} ->
			No;
		_ ->
			get_cultivate_lv_layer_to_no(Nos, {CultivateLv, CultivateLayer})
	end;

get_cultivate_lv_layer_to_no([], _) ->
	null.
	


%% 根据宠物进化等级获取消耗的进化丹总数量
%% @return : [{GoodsNo, GoodsNum}]
get_goods_cost_sum_evolve(Partner) ->
	Quality = get_quality(Partner),
	EvolveLv = get_evolve_lv(Partner),
	case data_partner_evolve:get(Quality, EvolveLv) of
		#partner_evolve{no = NoCurrent} ->
			Nos = data_partner_evolve:get_all_evolve_no_list(),
			lists:foldl(fun(No, Acc) when No =< NoCurrent ->
								{QualityN, EvolveLvN} = data_partner_evolve:get(No),
								#partner_evolve{consume_goods = ConsumeGoods} = data_partner_evolve:get(QualityN, EvolveLvN),
								lists:foldl(fun({GoodsNo, GoodsNum}, AccIn) ->
													case lists:keytake(GoodsNo, 1, AccIn) of
														{value, {GoodsNo, GoodsSum}, AccIn2} ->
															[{GoodsNo, GoodsSum + GoodsNum}|AccIn2];
														?false ->
															[{GoodsNo, GoodsNum}|AccIn]
													end
											end, Acc, ConsumeGoods);
						   (_No, Acc) ->
								Acc
						end, [], Nos);
		_ ->
			?ERROR_MSG("unknown error : ~p~n", [{Quality, EvolveLv}]),
			[]
	end.
	

%% 根据宠物觉醒等级获取消耗的觉醒丹总数量
%% @return : [{GoodsNo, GoodsNum}]
get_goods_cost_sum_awake(Partner) ->
	AwakeLv = get_awake_lv(Partner),
	Nos = data_partner_awake:get_nos(),
	case get_awake_no_by_lv(Nos, AwakeLv) of
		null ->
			[];
		NoCurrent ->
			lists:foldl(fun(No, Acc) when No =< NoCurrent ->
								#partner_awake{goods = GoodsNoL} = data_partner_awake:get(No),
								lists:foldl(fun({GoodsNo, GoodsNum}, AccIn) ->
													case lists:keytake(GoodsNo, 1, AccIn) of
														{value, {GoodsNo, GoodsSum}, AccIn2} ->
															[{GoodsNo, GoodsSum + GoodsNum}|AccIn2];
														?false ->
															[{GoodsNo, GoodsNum}|AccIn]
													end
											end, Acc, GoodsNoL);
						   (_No, Acc) ->
								Acc
						end, [], Nos)
	end.


get_awake_no_by_lv([No|Nos], AwakeLv) ->
	case data_partner_awake:get(No) of
		#partner_awake{awake_lv = AwakeLv} ->
			No;
		_ ->
			get_awake_no_by_lv(Nos, AwakeLv)
	end;

get_awake_no_by_lv([], _AwakeLv) ->
	null.



%% 获取宠物精炼丹总消耗数
%% @return : [{GoodsNo, GoodsNum}]
get_goods_cost_sum_refine(Partner) ->
	CostRefine = get_cost_refine(Partner),
	CostRefine.


	
set_exp(Partner, Exp) when is_record(Partner, partner) ->
    Partner#partner{exp = Exp};

set_exp(PartnerId, Exp) ->
    case get_partner(PartnerId) of
        null -> skip;
        Partner ->
            set_exp(Partner, Exp)
    end.

%%宠物关联坐骑
get_mount_id(Partner) ->
    Partner#partner.mount_id.

set_mount_id(Partner, MountId) when is_record(Partner, partner) ->
    Partner#partner{mount_id = MountId};

set_mount_id(PartnerId, MountId) ->
    case get_partner(PartnerId) of
        null -> skip;
        Partner ->
            set_mount_id(Partner, MountId)
    end.


get_lv(Partner) ->
    Partner#partner.lv.

set_lv(#partner{lv=Lv}=Partner, Lv) ->
    Partner;
set_lv(#partner{}=Partner, Lv) ->
    Partner#partner{lv = Lv};
set_lv(PartnerId, Lv) ->
    case get_partner(PartnerId) of
        null -> skip;
        Partner ->
            set_lv(Partner, Lv)
    end.

get_arts(Partner) ->
    Partner#partner.art_slot.

set_arts(Partner, Arts) ->
	Partner#partner{art_slot = Arts}.


%% 获取血量上限
get_hp_lim(Partner) -> Partner#partner.total_attrs#attrs.hp_lim.


%% 获取当前血量
get_hp(Partner) -> Partner#partner.total_attrs#attrs.hp.


%% 设置武将的当前血量
%% @para: PartnerId => 武将唯一id,  Hp => 新的当前血量
set_hp(Partner, Hp) when is_record(Partner, partner) ->
    NewCurHp = util:minmax(Hp, 0, get_hp_lim(Partner)),
    Partner1 = Partner#partner{total_attrs = Partner#partner.total_attrs#attrs{hp = NewCurHp}},
    notify_cli_total_attrs_change(Partner1, [{?ATTR_HP, NewCurHp}]),
    Partner1;

set_hp(PartnerId, Hp) ->
    case get_partner(PartnerId) of
        null -> skip;
        Partner ->
            set_hp(Partner, Hp)
    end.

set_hp_mp(Partner, Hp, Mp) when is_record(Partner, partner) ->
    NewCurHp = util:minmax(Hp, 0, get_hp_lim(Partner)),
    NewCurMp = util:minmax(Mp, 0, get_mp_lim(Partner)),
    Partner1 = Partner#partner{total_attrs = Partner#partner.total_attrs#attrs{hp = NewCurHp, mp = NewCurMp}},
    notify_cli_total_attrs_change(Partner1, [{?ATTR_HP, NewCurHp}, {?ATTR_MP, NewCurMp}]),
    Partner1.

has_skill(Partner, SkillId) ->
    case lists:keyfind(SkillId, #skl_brief.id, (get_equip_skill(Partner) ++ get_skill_list(Partner))) of
        false -> false;
        _Any -> true
    end.

has_skill(Partner, SkillId,noequip) ->
    case lists:keyfind(SkillId, #skl_brief.id, (get_skill_list(Partner))) of
        false -> false;
        _Any -> true
    end.


%% 判定一次是否可以实际出战
%% @return：true | false
can_goto_fight_once(_Partner) ->
    % case decide_proba_once_for_goto_fight(Partner) of
    %     success ->
    %         true;
    %     fail ->
    %         false
    % end.
    true.


%% @return: success | fail
% decide_proba_once_for_goto_fight(Partner) ->
%     LoyaltyLim = get_loyalty_lim(Partner),
%     RandNum = util:rand(1, 100),
%     Loyalty = get_loyalty(Partner),
%     NumCmp =
%         if
%             Loyalty > LoyaltyLim * 0.9 ->
%                 100;
%             Loyalty >= LoyaltyLim * 0.7 ->
%                 90;
%             Loyalty >= LoyaltyLim * 0.5 ->
%                 70;
%             Loyalty >= LoyaltyLim * 0.3 ->
%                 50;
%             Loyalty >= LoyaltyLim * 0.1 ->
%                 30;
%             true ->
%                 10
%         end,

%     case RandNum =< NumCmp of
%         true ->
%             success;
%         false ->
%             fail
%     end.


%% 加/减血（如果是减血，则参数HpAdd传入负值）
add_hp(_Partner, HpAdd) when HpAdd == 0 ->
    skip;
add_hp(Partner, HpAdd) ->
    NewHp = util:minmax(get_hp(Partner) + HpAdd, 0, get_hp_lim(Partner)), % 避免溢出
    set_hp(Partner, NewHp).


% 获取魔法上限
get_mp_lim(Partner) -> Partner#partner.total_attrs#attrs.mp_lim.

%% 获取基础魔法上限
get_base_mp_lim(Partner) -> Partner#partner.base_attrs#attrs.mp_lim.

%% 获取当前魔法值
get_mp(Partner) -> Partner#partner.total_attrs#attrs.mp.

%% 设置当前魔法值
set_mp(Partner, NewMp) ->
    NewCurMp = util:minmax(NewMp, 0, get_mp_lim(Partner)),
    NewParInfo = Partner#partner{total_attrs = Partner#partner.total_attrs#attrs{mp = NewCurMp}},
    notify_cli_total_attrs_change(NewParInfo, [{?ATTR_MP, NewCurMp}]),
    NewParInfo.


%% 加/减魔法值（如果是减魔法值，则参数MpAdd传入负值）
add_mp(_Partner, MpAdd) when MpAdd == 0 ->
    skip;
add_mp(Partner, MpAdd) ->
    NewMp = util:minmax(get_mp(Partner) + MpAdd, 0, get_mp_lim(Partner)), % 避免溢出
    set_mp(Partner, NewMp).


%% 获取物理攻击
get_phy_att(Partner) -> Partner#partner.total_attrs#attrs.phy_att.
%% 获取法术攻击
get_mag_att(Partner) -> Partner#partner.total_attrs#attrs.mag_att.
%% 获取物理防御
get_phy_def(Partner) -> Partner#partner.total_attrs#attrs.phy_def.
%% 获取法术防御
get_mag_def(Partner) -> Partner#partner.total_attrs#attrs.mag_def.

%% 获取物理攻击
get_phy_crit(Partner) -> Partner#partner.total_attrs#attrs.phy_crit.
%% 获取法术攻击
get_mag_crit(Partner) -> Partner#partner.total_attrs#attrs.mag_crit.
%% 获取物理防御
get_phy_ten(Partner) -> Partner#partner.total_attrs#attrs.phy_ten.
%% 获取法术防御
get_mag_ten(Partner) -> Partner#partner.total_attrs#attrs.mag_ten.


%% 获取命中
get_hit(Partner) -> Partner#partner.total_attrs#attrs.hit.
%% 获取闪避
get_dodge(Partner) -> Partner#partner.total_attrs#attrs.dodge.
%% 获取暴击
get_crit(Partner) -> Partner#partner.total_attrs#attrs.crit.
%% 获取坚韧（抗暴击）
get_ten(Partner) -> Partner#partner.total_attrs#attrs.ten.

%% 怒气/怒气上限
get_anger(Partner) -> Partner#partner.total_attrs#attrs.anger.
get_anger_lim(Partner) -> Partner#partner.total_attrs#attrs.anger_lim.


%% 获取战斗中的出手速度
get_act_speed(Partner) -> Partner#partner.total_attrs#attrs.act_speed.

%% 幸运
get_luck(Partner) -> Partner#partner.total_attrs#attrs.luck.

%% 冰封=隔绝
%% 冰封命中/抗性
get_frozen_hit(Partner) -> Partner#partner.total_attrs#attrs.frozen_hit + get_seal_hit(Partner).
get_frozen_resis(Partner) -> Partner#partner.total_attrs#attrs.frozen_resis + get_seal_resis(Partner).

%% 昏睡命中/抗性
get_trance_hit(Partner) -> Partner#partner.total_attrs#attrs.trance_hit + get_seal_hit(Partner).
get_trance_resis(Partner) -> Partner#partner.total_attrs#attrs.trance_resis + get_seal_resis(Partner).

%% 混乱命中/抗性
get_chaos_hit(Partner) -> Partner#partner.total_attrs#attrs.chaos_hit + get_seal_hit(Partner).
get_chaos_resis(Partner) -> Partner#partner.total_attrs#attrs.chaos_resis + get_seal_resis(Partner).

%% 封印命中/抗性
get_seal_hit(Partner) -> Partner#partner.total_attrs#attrs.seal_hit.
get_seal_resis(Partner) -> Partner#partner.total_attrs#attrs.seal_resis.

% 获得治疗强度
get_heal_value(Partner) -> Partner#partner.total_attrs#attrs.heal_value.

%------------------------------------------------------%------------------------------------------------------%------------------------------------------------------
% 获取基础天赋
%% @return: talents结构体
get_base_talents(Partner) ->
    lib_attribute:to_talents_record(Partner#partner.base_attrs).
%% 获取总天赋
%% @return: talents结构体
get_total_talents(Partner) ->
    lib_attribute:to_talents_record(Partner#partner.total_attrs).

%% 获取基础天赋：力量（strength）
get_base_str(Partner) -> Partner#partner.base_attrs#attrs.talent_str.
%% 获取基础天赋：% 体质（constitution）
get_base_con(Partner) -> Partner#partner.base_attrs#attrs.talent_con.
%% 获取基础天赋：% 耐力（stamina）
get_base_stam(Partner) -> Partner#partner.base_attrs#attrs.talent_sta.
%% 获取基础天赋：% 灵力（spirit）
get_base_spi(Partner) -> Partner#partner.base_attrs#attrs.talent_spi.
%% 获取基础天赋：敏捷（agility）
get_base_agi(Partner) -> Partner#partner.base_attrs#attrs.talent_agi.

%% 获取总天赋：力量（strength）
get_total_str(Partner) -> Partner#partner.total_attrs#attrs.talent_str.
%% 获取总天赋：% 体质（constitution）
get_total_con(Partner) -> Partner#partner.total_attrs#attrs.talent_con.
%% 获取总天赋：% 耐力（stamina）
get_total_stam(Partner) -> Partner#partner.total_attrs#attrs.talent_sta.
%% 获取总天赋：% 灵力（spirit）
get_total_spi(Partner) -> Partner#partner.total_attrs#attrs.talent_spi.
%% 获取总天赋：敏捷（agility）
get_total_agi(Partner) -> Partner#partner.total_attrs#attrs.talent_agi.
%% 获取自由（未分配的）天赋点数
get_free_talent_points(Partner) -> Partner#partner.free_talent_points.


%% 获取当前使用的技能页
get_skills_use(Partner) ->
	Partner#partner.skills_use.

%% 获取精炼属性列表
get_attr_refine(Partner) ->
	Partner#partner.attr_refine.

%% 设置精炼属性
set_attr_refine(Partner, AttrRefine) ->
	Partner#partner{attr_refine = AttrRefine}.


get_cost_refine(Partner) ->
	Partner#partner.cost_refine.

set_cost_refine(Partner, CostRefine) when is_list(CostRefine) ->
	Partner#partner{cost_refine = CostRefine};

set_cost_refine(Partner, CostRefine) ->
	?ERROR_MSG("Error CostRefine : ~p~n", [{get_id(Partner), CostRefine}]),
	Partner.


set_base_str(Par, Val) ->
    NewPar = Par#partner{base_attrs = Par#partner.base_attrs#attrs{talent_str = Val}},
    mod_partner:update_partner_to_ets(NewPar),
    NewPar.

set_base_con(Par, Val) ->
    NewPar = Par#partner{base_attrs = Par#partner.base_attrs#attrs{talent_con = Val}},
    mod_partner:update_partner_to_ets(NewPar),
    NewPar.

set_base_stam(Par, Val) ->
    NewPar = Par#partner{base_attrs = Par#partner.base_attrs#attrs{talent_sta = Val}},
    mod_partner:update_partner_to_ets(NewPar),
    NewPar.

set_base_spi(Par, Val) ->
    NewPar = Par#partner{base_attrs = Par#partner.base_attrs#attrs{talent_spi = Val}},
    mod_partner:update_partner_to_ets(NewPar),
    NewPar.

set_base_agi(Par, Val) ->
    NewPar = Par#partner{base_attrs = Par#partner.base_attrs#attrs{talent_agi = Val}},
    mod_partner:update_partner_to_ets(NewPar),
    NewPar.

reset_lv_to_1(Par) ->
            Par1 = set_base_str(Par,1),
            Par2 = set_base_con(Par1,1),
            Par3 = set_base_stam(Par2,1),
            Par4 = set_base_spi(Par3,1),
            Par5 = set_base_agi(Par4,1),

            NewPar = Par5#partner{free_talent_points = 0},
            mod_partner:update_partner_to_ets(NewPar),
            NewPar.

set_free_talent_points(Par, Val) ->
    case get_lv(Par) < ?MANUAL_ALLOT_FREE_TALENT_POINTS_START_LV of
        true ->
%%            DataNature = data_nature_relate:get(get_nature(Par)),
%%            Str = DataNature#nature_relate_data.str,
%%            Con = DataNature#nature_relate_data.con,
%%            Sta = DataNature#nature_relate_data.sta,
%%            Spi = DataNature#nature_relate_data.spi,
%%            Agi = DataNature#nature_relate_data.agi,
          %%自动加点改成读下面表
          [Con,Spi,Str,Sta,Agi] = (data_partner:get(Par#partner.no))#par_born_data.add_point,
%%          talent_str = 0,         % 天赋：力量（strength）
%%          talent_con = 0,         % 天赋：体质（constitution）
%%          talent_sta = 0,         % 天赋：耐力（stamina）
%%          talent_spi = 0,         % 天赋：灵力（spirit）
%%          talent_agi = 0,         % 天赋：敏捷（agility）
            Par1 = set_base_str(Par, get_base_str(Par) + util:floor(Str * Val/5)),
            Par2 = set_base_con(Par1, get_base_con(Par1) + util:floor(Con* Val/5)),
            Par3 = set_base_stam(Par2, get_base_stam(Par2) + util:floor(Sta* Val/5)),
            Par4 = set_base_spi(Par3, get_base_spi(Par3) + util:floor(Spi* Val/5)),
            NewPar = set_base_agi(Par4, get_base_agi(Par4) + util:floor(Agi* Val/5)),

            mod_partner:update_partner_to_ets(NewPar),
            NewPar;
        false ->

            NewPar = Par#partner{free_talent_points = Val},
            mod_partner:update_partner_to_ets(NewPar),
            NewPar
        end.


set_free_talent_points2(Par, Val, OldLv) ->
  case get_lv(Par) < ?MANUAL_ALLOT_FREE_TALENT_POINTS_START_LV of
    true ->
%%            DataNature = data_nature_relate:get(get_nature(Par)),
%%            Str = DataNature#nature_relate_data.str,
%%            Con = DataNature#nature_relate_data.con,
%%            Sta = DataNature#nature_relate_data.sta,
%%            Spi = DataNature#nature_relate_data.spi,
%%            Agi = DataNature#nature_relate_data.agi,
      %%自动加点改成读下面表
      [Con,Spi,Str,Sta,Agi] = (data_partner:get(Par#partner.no))#par_born_data.add_point,
%%          talent_str = 0,         % 天赋：力量（strength）
%%          talent_con = 0,         % 天赋：体质（constitution）
%%          talent_sta = 0,         % 天赋：耐力（stamina）
%%          talent_spi = 0,         % 天赋：灵力（spirit）
%%          talent_agi = 0,         % 天赋：敏捷（agility）
      Par1 = set_base_str(Par, get_base_str(Par) + util:floor(Str * Val/5)),
      Par2 = set_base_con(Par1, get_base_con(Par1) + util:floor(Con* Val/5)),
      Par3 = set_base_stam(Par2, get_base_stam(Par2) + util:floor(Sta* Val/5)),
      Par4 = set_base_spi(Par3, get_base_spi(Par3) + util:floor(Spi* Val/5)),
      NewPar = set_base_agi(Par4, get_base_agi(Par4) + util:floor(Agi* Val/5)),

      mod_partner:update_partner_to_ets(NewPar),
      NewPar;
    false ->
        case ?MANUAL_ALLOT_FREE_TALENT_POINTS_START_LV - OldLv > 0 of
          true ->
            AutoFree = ?MANUAL_ALLOT_FREE_TALENT_POINTS_START_LV - OldLv,
            [Con,Spi,Str,Sta,Agi] = (data_partner:get(Par#partner.no))#par_born_data.add_point,
            Par1 = set_base_str(Par, get_base_str(Par) + util:floor(Str * AutoFree)),
            Par2 = set_base_con(Par1, get_base_con(Par1) + util:floor(Con* AutoFree)),
            Par3 = set_base_stam(Par2, get_base_stam(Par2) + util:floor(Sta* AutoFree)),
            Par4 = set_base_spi(Par3, get_base_spi(Par3) + util:floor(Spi* AutoFree)),
            NewPar = set_base_agi(Par4, get_base_agi(Par4) + util:floor(Agi* AutoFree)),
            Val2 = Val - (AutoFree * 5),
            NewPar2 = NewPar#partner{free_talent_points = Val2},
            mod_partner:update_partner_to_ets(NewPar2),
            NewPar2;
          false ->
            NewPar = Par#partner{free_talent_points = Val},
            mod_partner:update_partner_to_ets(NewPar),
            NewPar
        end

  end.

% 洗点
reset_free_talent_points(PS,PartnerId) ->
    Par = get_partner(PartnerId),

    Lv = get_lv(Par),
    % BasrStr = get_base_str(Par),
    % BasrCon = get_base_con(Par),
    % BasrSta = get_base_stam(Par),
    % BasrSpi = get_base_spi(Par),
    % BasrAgi = get_base_agi(Par),

    Sum = Lv * 5 - 5,

    NewPar = set_base_str(Par,Lv),
    NewPar1 = set_base_con(NewPar,Lv),
    NewPar2 = set_base_stam(NewPar1,Lv),
    NewPar3 = set_base_spi(NewPar2,Lv),
    NewPar4 = set_base_agi(NewPar3,Lv),

    NewPar5 = set_free_talent_points(NewPar4,Sum),

    NewPar6 = calc_base_attrs(NewPar5),
    NewPar7 = recount_total_attrs(NewPar6),
    NewPar8 = recount_battle_power(NewPar7),

    mod_partner:update_partner_to_ets(NewPar8),
    mod_partner:db_save_partner(NewPar8),
    notify_cli_info_change(PS, NewPar8).

% 内功
reset_art_total_attrs(PS,PartnerId) ->
    Partner = get_partner(PartnerId),
    NewPar1 = recount_total_attrs(Partner),
    NewPar2 = recount_battle_power(NewPar1),
    mod_partner:update_partner_to_ets(NewPar2),
    mod_partner:db_save_partner(NewPar2),
    notify_cli_info_change(PS, NewPar2).


%% 分配自由天赋点
allot_free_talent_points(PS, PartnerId,AllotInfoList) ->
    F = fun(AllotInfo, Sum) ->
            {_TalentCode, Points} = AllotInfo,
            Sum + Points
        end,

    Par = get_partner(PartnerId),
    TotalPointsToAllot = lists:foldl(F, 0, AllotInfoList),
    % ?DEBUG_MSG("Par=~p,TotalPointsToAllot=~p",[Par,TotalPointsToAllot]),
    ?ASSERT(TotalPointsToAllot > 0),
    % 先扣点数
    ParNew1 = set_free_talent_points(Par,get_free_talent_points(Par) - TotalPointsToAllot),
    ParNew = allot_free_talent_points__(PS, ParNew1 ,AllotInfoList, TotalPointsToAllot),
    % ParNew = get_partner(PartnerId),

    NewPar4 = calc_base_attrs(ParNew),
    NewPar5 = recount_total_attrs(NewPar4),
    NewPar6 = recount_battle_power(NewPar5),

    mod_partner:update_partner_to_ets(NewPar6),
    mod_partner:db_save_partner(NewPar6),
    notify_cli_info_change(PS, NewPar6).

allot_free_talent_points__(PS, Par,[{TalentCode, Points} | T], TotalPointsToAllot) ->

    % ?DEBUG_MSG("Par=~p",[Par]),
    Par1 = case Points of
        0 ->
            Par;
        _ ->
            case TalentCode of
                ?TALENT_CODE_STR ->
                    set_base_str(Par, get_base_str(Par) + Points);
                ?TALENT_CODE_CON ->
                    set_base_con(Par, get_base_con(Par) + Points);
                ?TALENT_CODE_STA ->
                    set_base_stam(Par, get_base_stam(Par) + Points);
                ?TALENT_CODE_SPI ->
                    set_base_spi(Par, get_base_spi(Par) + Points);
                ?TALENT_CODE_AGI ->
                    set_base_agi(Par, get_base_agi(Par) + Points)
            end
    end,
    allot_free_talent_points__(PS,Par1, T, TotalPointsToAllot);
allot_free_talent_points__(_PS,Par, [], _TotalPointsToAllot) ->
    Par.

build_talents_bitstring(Talents) ->
    ?ASSERT(is_record(Talents, talents)),
    % 顺序：{力量，体质，耐力，灵力， 敏捷}， 顺序不要调换，因为存到DB时默认是这个顺序！
    Tup = {Talents#talents.str, Talents#talents.con, Talents#talents.sta, Talents#talents.spi, Talents#talents.agi},
    util:term_to_bitstring(Tup).

%------------------------------------------------------------------------------------------------------------


%% 获取物理伤害放缩系数
get_do_phy_dam_scaling(Partner) ->
    Partner#partner.total_attrs#attrs.do_phy_dam_scaling.

%% 获取法术伤害放缩系数
get_do_mag_dam_scaling(Partner) ->
    Partner#partner.total_attrs#attrs.do_mag_dam_scaling.


%% 获取暴击系数
get_crit_coef(Partner) ->
    Partner#partner.total_attrs#attrs.crit_coef.

%% 出战的武将获取经验（TODO： 是否需补充处理连续升级的情况，比如从1级直接升到3级？？）
%% @PartnerId: 武将的唯一id， @ExpToAdd: 增加的经验值
%% 受世界等级影响
add_exp(PartnerId, ExpToAdd, PS, LogInfo) when is_integer(PartnerId) ->
    ?ASSERT(lists:member(PartnerId, player:get_partner_id_list(PS))),
    case get_partner(PartnerId) of
        null ->
            ?ASSERT(false),
            {fail, ?PM_PAR_NOT_EXISTS};
        Partner ->
            add_exp(Partner, ExpToAdd, PS, LogInfo)
    end;
add_exp(Partner, AddVal, PS, LogInfo) ->
    ExtraParExp = mod_world_lv:cal_par_exp(PS, AddVal),
    add_exp(Partner, AddVal, ExtraParExp, PS, LogInfo).

add_exp_without_world_lv(PartnerId, ExpToAdd, PS, LogInfo) when is_integer(PartnerId) ->
    add_exp(PartnerId, ExpToAdd, 0, PS, LogInfo);

add_exp_without_world_lv(Partner, AddVal, PS, LogInfo) ->
    add_exp(Partner, AddVal, 0, PS, LogInfo).

add_exp(PartnerId, ExpToAdd, ExtraParExp, PS, LogInfo) when is_integer(PartnerId) ->
    ?ASSERT(lists:member(PartnerId, player:get_partner_id_list(PS))),
    case get_partner(PartnerId) of
        null ->
            ?ASSERT(false),
            {fail, ?PM_PAR_NOT_EXISTS};
        Partner ->
            add_exp(Partner, ExpToAdd, ExtraParExp, PS, LogInfo)
    end;

add_exp(Partner, AddVal, ExtraParExp, PS, LogInfo) ->
  ExpToAdd = util:ceil(AddVal + ExtraParExp),

  CurExp = get_exp(Partner),
  CurLv = get_lv(Partner),
  NewPar = set_exp(Partner, CurExp + ExpToAdd),
  ExpLim = get_exp_lim(CurLv),
  % 统计经验
  case ExpToAdd > 0 of
    true -> lib_log:statis_produce_currency(PS, ?VGOODS_PAR_EXP, ExpToAdd, LogInfo);
    false -> lib_log:statis_consume_currency(PS, ?VGOODS_PAR_EXP, (0 - ExpToAdd), LogInfo)
  end,
  case lib_partner:get_lv(Partner) >= player:get_player_max_lv(PS) orelse lib_partner:get_lv(Partner) >= player:get_lv(PS)  of
    true ->
      %%计算后面五级的经验
      CalExpFun = fun(CalExpLv, CalExpAcc ) ->
        get_exp_lim(lib_partner:get_lv(Partner) + CalExpLv) + CalExpAcc
        end,
      DeltaExp = lists:foldl(CalExpFun,0,lists:seq(1,?DELTA_LV_PLAYER_PAR)),
      case CurExp < ExpLim of
        true ->
          % 更新到ets
          mod_partner:update_partner_to_ets(NewPar),
          notify_cli_info_change(NewPar, [{?OI_CODE_EXP, get_exp(NewPar)}]),
          if
            ExpToAdd > 0 andalso ExtraParExp =:= 0 ->
              ply_tips:send_sys_tips(PS, {par_add_exp, [get_name(NewPar), get_id(NewPar), get_quality(NewPar),get_no(NewPar), ExpToAdd]});
            ExpToAdd > 0 andalso ExtraParExp > 0 ->
              ply_tips:send_sys_tips(PS, {par_add_exp_1, [get_name(NewPar), get_id(NewPar), get_quality(NewPar),get_no(NewPar), ExpToAdd, ExtraParExp]});
            ExpToAdd > 0 andalso ExtraParExp < 0 ->
              ply_tips:send_sys_tips(PS, {par_add_exp_2, [get_name(NewPar), get_id(NewPar), get_quality(NewPar),get_no(NewPar), ExpToAdd, -ExtraParExp]});
            true ->
              skip
          end,
          {ok, NewPar};
        false ->
          NewPar2 = set_exp(Partner, CurExp),
          notify_cli_info_change(NewPar, [{?OI_CODE_EXP, get_exp(NewPar2)}]),
          mod_partner:update_partner_to_ets(NewPar2),
          lib_send:send_prompt_msg(PS, ?PROMPT_MSG_TYPE_TIPS, ?PM_CANT_GET_EXP_BECAUSE_LV_DELTA),
          {ok, NewPar2}
      end;
    false ->
      % 判断是否升级
      case get_exp(NewPar) < ExpLim  of
        true ->  % 没升级
          % 更新到ets
          mod_partner:update_partner_to_ets(NewPar),
          notify_cli_info_change(NewPar, [{?OI_CODE_EXP, get_exp(NewPar)}]),
          if
            ExpToAdd > 0 andalso ExtraParExp =:= 0 ->
              ply_tips:send_sys_tips(PS, {par_add_exp, [get_name(NewPar), get_id(NewPar), get_quality(NewPar),get_no(NewPar), ExpToAdd]});
            ExpToAdd > 0 andalso ExtraParExp > 0 ->
              ply_tips:send_sys_tips(PS, {par_add_exp_1, [get_name(NewPar), get_id(NewPar), get_quality(NewPar),get_no(NewPar), ExpToAdd, ExtraParExp]});
            ExpToAdd > 0 andalso ExtraParExp < 0 ->
              ply_tips:send_sys_tips(PS, {par_add_exp_2, [get_name(NewPar), get_id(NewPar), get_quality(NewPar),get_no(NewPar), ExpToAdd, -ExtraParExp]});
            true ->
              skip
          end,
          {ok, NewPar};
        false -> % 升级
          {ForecastLv, LeftExp} = change_lv_by_exp(PS,get_lv(NewPar), get_exp(NewPar)),
          NewLv = min(ForecastLv, player:get_player_max_lv(PS)),
          OldLv = get_lv(NewPar),
          UpdateLv = NewLv - OldLv,

          NewCurExp =
            case NewLv >= player:get_player_max_lv(PS) of
              false -> LeftExp;
              true -> 0 %% 开放新等级时，保证起跑线同步
            end,

          NewPar1 = set_exp(NewPar, NewCurExp),
          NewPar2 = set_lv(NewPar1, NewLv ),

          % 增加每升一级5点可分配点 全属性加1
          BasrStr = get_base_str(NewPar2),
          BasrCon = get_base_con(NewPar2),
          BasrSta = get_base_stam(NewPar2),
          BasrSpi = get_base_spi(NewPar2),
          BasrAgi = get_base_agi(NewPar2),

          NewPar2_0 = set_base_str(NewPar2,BasrStr + UpdateLv),
          NewPar2_1 = set_base_con(NewPar2_0,BasrCon + UpdateLv),
          NewPar2_2 = set_base_stam(NewPar2_1,BasrSta + UpdateLv),
          NewPar2_3 = set_base_spi(NewPar2_2,BasrSpi + UpdateLv),
          NewPar2_4 = set_base_agi(NewPar2_3,BasrAgi + UpdateLv),

          NewPar3 = set_free_talent_points2(NewPar2_4,get_free_talent_points(NewPar2_4) + 5 * UpdateLv, OldLv ),

          NewPar4 = calc_base_attrs(NewPar3),
          NewPar5 = recount_total_attrs(NewPar4),
          NewPar6 = recount_battle_power(NewPar5),

          %% 宠物战斗力发生变化，需要重新玩家的战斗力
          ply_attr:recount_battle_power(PS),

          % 通知客户端武将属性已更新
          notify_cli_info_change(PS, NewPar6),

          % 更新到ets
          mod_partner:update_partner_to_ets(NewPar6),

          % 存到db
          db:update(get_owner_id(NewPar6), partner, ["lv", "exp"], [NewLv, NewCurExp], "id", get_id(NewPar6)),
          if
            ExpToAdd > 0 andalso ExtraParExp =:= 0 ->
              ply_tips:send_sys_tips(PS, {par_add_exp, [get_name(NewPar6), get_id(NewPar6), get_quality(NewPar6), ExpToAdd]});
            ExpToAdd > 0 andalso ExtraParExp > 0 ->
              ply_tips:send_sys_tips(PS, {par_add_exp_1, [get_name(NewPar6), get_id(NewPar6), get_quality(NewPar6), ExpToAdd, ExtraParExp]});
            ExpToAdd > 0 andalso ExtraParExp < 0 ->
              ply_tips:send_sys_tips(PS, {par_add_exp_2, [get_name(NewPar6), get_id(NewPar6), get_quality(NewPar6), ExpToAdd, -ExtraParExp]});
            true ->
              skip
          end,
          {ok, NewPar6}
      end
  end.


%% @PartnerId: 武将的唯一id， @IntimacyToAdd: 增加的经验值
add_intimacy(PartnerId, IntimacyToAdd, _PS) ->
    ?TRACE("PartnerId:~p add Intimacy:~p~n", [PartnerId, IntimacyToAdd]),
    ?ASSERT(lists:member(PartnerId, player:get_partner_id_list(_PS))),
    case get_partner(PartnerId) of
        null ->
            ?ASSERT(false),
            {fail, ?PM_PAR_NOT_EXISTS};
        Partner ->
            case lib_partner:get_intimacy_lv(Partner) >= ?PARTNER_MAX_INTIMACY_LV of
                true -> skip;
                false ->
                    CurIntimacy = get_intimacy(Partner),
                    CurIntimacyLv = get_intimacy_lv(Partner),
                    NewPar = set_intimacy(Partner, CurIntimacy + IntimacyToAdd),
                    IntimacyLim = get_intimacy_lim(CurIntimacyLv),
                    % 判断是否升级
                    case get_intimacy(NewPar) < IntimacyLim  of
                        true ->  % 没升级
                            % 更新到ets
                            mod_partner:update_partner_to_ets(NewPar),
                            {ok, NewPar};
                        false -> % 升级
                            {NewIntimacyLv, LeftIntimacy} = change_intimacy_lv_by_intimacy(get_intimacy_lv(NewPar), get_intimacy(NewPar)),

                            ?TRACE("PartnerId:~p upgrade intimacy_lv to ~p~n", [PartnerId, NewIntimacyLv]),

                            NewCurIntimacy = LeftIntimacy,
                            NewPar1 = set_intimacy(NewPar, NewCurIntimacy),
                            NewPar2 = set_intimacy_lv(NewPar1, NewIntimacyLv),

                            % 通知客户端武将属性已更新
                            notify_cli_info_change(NewPar2, [{?OI_CODE_PAR_INTIMACY, NewCurIntimacy}, {?OI_CODE_PAR_INTIMACY_LV, NewIntimacyLv}]),

                            % 更新到ets
                            mod_partner:update_partner_to_ets(NewPar2),

                            % % 存到db
                            % db:update(partner, ["lv", "exp"], [NewLv, NewCurExp], "id", PartnerId),

                            {ok, NewPar2}
                    end
            end
    end.


get_cultivate_lim(CultivateLv, CultivateLayer) ->
    case data_partner_cultivate:get(CultivateLv, CultivateLayer) of
        null -> ?MAX_U32;
        Data -> Data#partner_cultivate.cultivate_next_lv_need
    end.

add_cultivate_level(PartnerId, LevelToAdd) ->
    case get_partner(PartnerId) of
        null ->
            ?ASSERT(false),
            {fail, ?PM_PAR_NOT_EXISTS};
        Partner ->
            {MaxLv, MaxLayer} = data_partner_cultivate:get(lists:last(data_partner_cultivate:get_all_cultivate_no_list())),
            case lib_partner:get_cultivate_lv(Partner) >= MaxLv andalso get_cultivate_layer(Partner) >= MaxLayer of
                true -> {fail, ?PM_CULTIVATE_MAX};
                false ->
                    No = (data_partner_cultivate:get(get_cultivate_lv(Partner), get_cultivate_layer(Partner)))#partner_cultivate.no,

                    {NewCultivateLv, NextLayer} = change_layer_lv_by_cultivate_lv(No + LevelToAdd),

                    NewPar1 = set_cultivate_lv(Partner, NewCultivateLv),
                    NewPar2 = set_cultivate_layer(NewPar1, NextLayer),

                    % 通知客户端武将属性已更新
                    %notify_cli_info_change(NewPar2, [{?OI_CODE_PAR_CULTIVATE, NewCultivate}, {?OI_CODE_PAR_CULTIVATE_LV, NewCultivateLv}]),

                    % 更新到ets
                    mod_partner:update_partner_to_ets(NewPar2),

                    % % 存到db
                    % db:update(partner, ["lv", "exp"], [NewLv, NewCurExp], "id", PartnerId),

                    {ok, NewPar2}
            end
    end.


%% 获取/设置总属性
get_total_attrs(Partner) ->
    Partner#partner.total_attrs.
set_total_attrs(Partner, TotalAttrs) ->
    ?ASSERT(is_record(TotalAttrs, attrs)),
    Partner#partner{total_attrs = TotalAttrs}.


get_nature(Partner) ->
    Partner#partner.nature_no.

get_quality(Partner) ->
    Partner#partner.quality.

set_quality(Partner, Value) ->
    Partner#partner{quality = Value}.

get_name(Partner) ->
    Partner#partner.name.

get_race(_Partner) ->
    ?RACE_NONE.  % 宠物目前无种族之分

get_faction(_Partner) ->
    ?FACTION_NONE.  % 宠物目前无门派之分

get_sex(Partner) ->
    Partner#partner.sex.


get_intimacy(Partner) ->
    Partner#partner.intimacy.
set_intimacy(Partner, Value) ->
    Partner#partner{intimacy = Value}.

get_intimacy_lv(Partner) ->
    Partner#partner.intimacy_lv.

set_intimacy_lv(Partner, Value) ->
    Partner#partner{intimacy_lv = Value}.

get_evolve_lv(Partner) ->
    Partner#partner.evolve_lv.

set_evolve_lv(Partner, Value) ->
    Partner#partner{evolve_lv = Value}.

get_evolve(Partner) ->
    Partner#partner.evolve.

set_evolve(Partner, Value) ->
    Partner#partner{evolve = Value}.

add_evolve(PS, Partner, Value) ->
    case Value =< 0 of
        true -> Partner;
        false ->
            NowQuality = get_quality(Partner),
            {NewQuality, NewEvolveLv} = decide_new_quality_evolve_lv(Partner, Value),
            ?DEBUG_MSG("NewQuality====~p,NewEvolveLv====~p~n",[NewQuality,NewEvolveLv]),
            Partner2 = set_quality(Partner, NewQuality),
            Partner3 = set_evolve_lv(Partner2, NewEvolveLv),

%%            ply_tips:send_sys_tips(PS, {par_add_evolve, [get_name(Partner3), get_id(Partner3), NewQuality,get_no(Partner3), Value]}),
            case NewQuality - NowQuality > 2 of
                true ->
                    ?WARNING_MSG("lib_partner:PlayerId:~p, ParNo=~p,add_evolve,NowQuality:~p, NewQuality:~p, AddEvolve=~p~n", [player:id(PS), get_no(Partner), NowQuality, NewQuality,Value]);
                false -> skip
            end,

            Partner4 = calc_base_attrs(Partner3),
            Partner5 = recount_total_attrs(Partner4),

            Partner6 = recount_battle_power(Partner5),
            mod_partner:update_partner_to_ets(Partner6),
            mod_partner:db_save_partner(Partner6),

            %% 进化后很多属性发生变化
            notify_cli_info_change(PS, Partner6),

            case lib_partner:is_fighting(Partner6) of
                true -> ply_attr:recount_battle_power(PS);
                false -> skip
            end,

            case lib_partner:is_follow_partner(Partner6) of
                false -> skip;
                true -> notify_main_partner_info_change_to_AOI(PS, Partner6)
            end,

            case NewQuality =/= NowQuality of
                false -> skip;
                true ->
                    case NewQuality of
                        ?QUALITY_PURPLE ->
                            ply_tips:send_sys_tips(PS, {evolve_partner_purple, [player:get_name(PS), player:id(PS), lib_partner:get_name(Partner6), lib_partner:get_id(Partner6), lib_partner:get_quality(Partner6)-1,lib_partner:get_no(Partner6)]});
                        ?QUALITY_ORANGE ->
                            ply_tips:send_sys_tips(PS, {evolve_partner_orange, [player:get_name(PS), player:id(PS), lib_partner:get_name(Partner6), lib_partner:get_id(Partner6), lib_partner:get_quality(Partner6)-1,lib_partner:get_no(Partner6)]});
                        ?QUALITY_RED ->
                            ply_tips:send_sys_tips(PS, {evolve_partner_red, [player:get_name(PS), player:id(PS), lib_partner:get_name(Partner6), lib_partner:get_id(Partner6), lib_partner:get_quality(Partner6)-1,lib_partner:get_no(Partner6)]});
                        _ -> skip
                    end
            end,
            Partner6
    end.


get_awake_lv(Partner) ->
    Partner#partner.awake_lv.

set_awake_lv(Partner, Value) ->
    Partner#partner{awake_lv = Value}.


get_awake_illusion(Partner) ->
    Partner#partner.awake_illusion.

set_awake_illusion(Partner, Value) ->
    Partner#partner{awake_illusion = Value}.


get_cultivate_lv(Partner) ->
    Partner#partner.cultivate_lv.

set_cultivate_lv(#partner{cultivate_lv=Value}=Partner, Value) ->
    Partner;
set_cultivate_lv(#partner{cultivate_lv=OldValue}=Partner, Value) when Value > OldValue->
    Partner#partner{cultivate_lv = Value};

set_cultivate_lv(Partner, Value) ->
    Partner#partner{cultivate_lv = Value}.


get_cultivate_layer(Partner) ->
    Partner#partner.cultivate_layer.

set_cultivate_layer(Partner, Value) ->
    Partner1 = Partner#partner{cultivate_layer = Value},
    mod_rank:partner_clv(Partner1),
    Partner1.


get_cultivate(Partner) ->
    Partner#partner.cultivate.

set_cultivate(Partner, Value) ->
    Partner#partner{cultivate = Value}.


get_state(Partner) ->
    Partner#partner.state.

is_locked(Partner) ->
    get_state(Partner) =:= ?PAR_STATE_REST_LOCKED orelse get_state(Partner) =:= ?PAR_STATE_JOIN_BATTLE_LOCKED.

is_home_work(Partner) ->
	get_state(Partner) =:= ?PAR_STATE_HOME_WORK.

get_battle_power(Partner) ->
    Partner#partner.battle_power.


get_loyalty(Partner) ->
    Partner#partner.loyalty.

get_loyalty_lim(Partner) ->
    DataQualityRelate = data_quality_relate:get(get_quality(Partner)),
    DataQualityRelate#quality_relate_data.loyalty_max.

set_loyalty(Partner, Value) ->
    NewValue = util:minmax(Value, 0, get_loyalty_lim(Partner)),
    Partner1 = Partner#partner{loyalty = NewValue},
    notify_cli_info_change(Partner1, [{?OI_CODE_PAR_LOYALTY, NewValue}]),
    Partner1.

get_life(Partner) ->
    Partner#partner.life.

get_max_postnatal_skill_slot(Partner) ->
    Partner#partner.max_postnatal_skill.

set_max_postnatal_skill_slot(Partner, Value) ->
    Partner#partner{max_postnatal_skill = Value}.


%% 获取宠物的技能列表(在接口这里做当前使用页判断，后面考虑是否在这里把专属技能加上还是分开处理)
%% @return: [] | skl_brief结构体列表
get_skill_list(Partner) ->
	case Partner#partner.skills_use of
		1 ->
			Partner#partner.skills;
		_ ->
			Partner#partner.skills_two
	end.

% 获取宠物装备技能
get_equip_skill(Partner) ->
    TEqpList = mod_equip:get_partner_equip_list(Partner#partner.player_id, get_id(Partner)),
    % 计算战力时，把位置错误的装备过滤掉
    Skills = [#skl_brief{id = lib_goods:get_equip_stunt(Goods),lv=get_lv(Partner)} || Goods <- TEqpList, lib_goods:get_equip_stunt(Goods) =/= 0],
    ?DEBUG_MSG("Skills=~p",[Skills]),
    Skills.

% 获取宠物专属技能
get_exclusive_skill(Partner) ->
	Partner#partner.skills_exclusive.


set_exclusive_skill(Partner, SkillsExclusive) ->?DEBUG_MSG("xxxxxxxx : ~p~n", [{?MODULE, ?LINE}]),
	Partner#partner{skills_exclusive = SkillsExclusive}.



%% 因为加了技能页，所以暂时决定在这个接口判断当前使用的技能页吧，后面再想下有没有更好的做法
set_skill_list(Partner, List) when Partner#partner.skills_use =:= 1 ->
    Partner#partner{skills = List};

set_skill_list(Partner, List) ->
    Partner#partner{skills_two = List}.


set_state(Partner, Value) ->
  case Value == ?PAR_STATE_JOIN_BATTLE_UNLOCKED of
    true ->
      PS = player:get_PS(Partner#partner.player_id),
      Index = find_order_index(PS),
      Partner#partner{state = Value, join_battle_order = Index};
    false ->
      Partner#partner{state = Value,join_battle_order = 0}
  end.

%%找一个按顺序空缺的位置
find_order_index(PS) ->
  ParList = mod_partner:get_fighting_partner_list(PS),
  F = fun(Partner, Acc) ->
    [Partner#partner.join_battle_order|Acc]
      end,
  IndexLists = lists:foldl(F,[], ParList),
  F2 = fun(Index, Acc2) ->
    case lists:member(Index, IndexLists) of
      true ->
        Acc2;
      false ->
        Index
    end
       end,
  lists:foldl(F2,5,[4,3,2,1]).




%% 设置出战时间戳(出战先后顺序排序需要用到)
set_join_battle_time(Partner) ->
	{MegaSecs, Secs, MicroSecs} = erlang:now(),
	Unixtime = tool:to_integer(lists:concat([MegaSecs, Secs, MicroSecs])),
	Partner#partner{ts_join_battle = Unixtime}.


get_mood_no(Partner) ->
    Partner#partner.mood_no.

set_mood_no(Partner, No) ->
    Partner#partner{mood_no = No}.

get_last_update_mood_time(Partner) ->
    Partner#partner.last_update_mood_time.

set_last_update_mood_time(Partner, Time) ->
    Partner#partner{last_update_mood_time = Time}.

get_update_mood_count(Partner) ->
    case util:is_same_day(get_last_update_mood_time(Partner)) of
        true -> Partner#partner.update_mood_count;
        false -> 0
    end.

set_update_mood_count(Partner, Count) ->
    Partner#partner{update_mood_count = Count}.

get_wash_count(Partner) ->
    Partner#partner.wash_count.

set_wash_count(Partner, Count) ->
    Partner#partner{wash_count = Count}.


get_buff_no_list(Partner) ->
    % BuffList = mod_buff:get_buff_list(partner, get_id(Partner)), %% 目前没有需要保存数据库的宠物buff，都是心情编号对应的buff列表
    % [Buff#buff.no || Buff <- BuffList].
    case data_partner_mood:get(get_mood_no(Partner)) of
        null -> [];
        Data -> Data#mood_cfg.buff_no_list
    end.


%% 获取主动技能列表(因为加了技能页，这个接口要判断一下skills_use字段然后返回对应技能页的技能列表，还要加上专属技能栏的)
%% @return: [] | skl_brief结构体列表
get_initiative_skill_list(Partner) ->
    L = get_equip_skill(Partner) ++ get_skill_list(Partner) ++ get_exclusive_skill(Partner),
    F = fun(SklBrief) ->
            SkillId = SklBrief#skl_brief.id,
            mod_skill:is_initiative(SkillId)
        end,
    [X || X <- L, F(X)].

get_mount_step_skill(Partner) ->
    case get_mount_id(Partner) of
        ?INVALID_ID -> [];
        MountId ->
            case lib_mount:get_mount(MountId) of
                Mount when is_record(Mount, ets_mount) ->
                    SkillList = (data_mount:get_mount_info(Mount#ets_mount.no))#mount_info.step_skill,
                    {StepSkill, _Step} = lists:nth(Mount#ets_mount.step, SkillList),
                    [#skl_brief{id = StepSkill}];
                _ -> []
            end
    end.

%% 获取被动技能列表(因为加了技能页，这个接口要判断一下skills_use字段然后返回对应技能页的技能列表，还要加上专属技能栏的)
%% @return: [] | skl_brief结构体列表
get_passive_skill_list(Partner) ->

    T0 = get_equip_skill(Partner),
    T1 = get_skill_list(Partner),
    T2 = get_passive_skill_list_of_mount(Partner),
	T3 = get_exclusive_skill(Partner),

    L = T0 ++ T1 ++ T2 ++ T3  ++ get_mount_step_skill(Partner),
	?DEBUG_MSG("aaaaaaaaaaaa : ~p~n", [{?MODULE, ?LINE, T0, T1, T2, T3, get_mount_step_skill(Partner)}]),
    F = fun(SklBrief) ->
            SkillId = SklBrief#skl_brief.id,
            case mod_skill:get_cfg_data(SkillId) of
                null -> false;
                SklCfg -> mod_skill:is_passive(SklCfg)
            end
        end,
    L1 = [X || X <- L, F(X)],
    % ?DEBUG_MSG("L1=~p",[L1]),

    % 按照id排序 高级技能将被排到下面
    FSort = fun(S1, S2) -> S1#skl_brief.id > S2#skl_brief.id end,
    L2 = lists:sort(FSort, L1),

    % ?DEBUG_MSG("L2=~p",[L2]),

    Filter = fun(SklBrief,Acc) ->
        % 过滤掉相同的技能
        HaveFun = fun(SklBrief1,Acc1) ->
            Id1 = SklBrief1#skl_brief.id rem 100000,
            Id = SklBrief#skl_brief.id rem 100000,

            SklCfg = data_skill:get(SklBrief#skl_brief.id),
            SklCfg1 = data_skill:get(SklBrief1#skl_brief.id),

            if (Id1 == Id) ->
                    ?DEBUG_MSG("have tow skill ~p,~p",[SklBrief1#skl_brief.id,SklBrief#skl_brief.id]);
                true ->
                    skip
            end,

            % 只计算被动技能
            Acc1 andalso (not(Id1 == Id) orelse SklCfg#skl_cfg.type /= 2 orelse SklCfg1#skl_cfg.type /= 2)
        end,

        NotHave = lists:foldl(HaveFun,true,Acc),

        case NotHave of
            true ->
                [SklBrief | Acc];
            false -> Acc
        end
    end,

    Ret = lists:foldl(Filter,[],L2),
    ?DEBUG_MSG("Ret=~p",[Ret]),

    Ret.


%% 获取关联的坐骑被动技能列表
%% @return: [] | skl_brief结构体列表
get_passive_skill_list_of_mount(Partner)  ->
    case get_mount_id(Partner) of
        ?INVALID_ID -> [];
        MountId ->
			List = lib_mount:get_mount_skill(MountId),
			List2 =   %因为取经之路可能取到的玩家数据坐骑没有初始化导致出错
				case List =:= 0 of
					true ->
						PlayerId=  Partner#partner.player_id,
						lib_mount:init_mount(PlayerId),
						lib_mount:get_mount_skill(MountId);
					false -> List
				end,


			Fun = fun(?INVALID_NO, Acc) ->
						  Acc;
					 (X, Acc) ->
						  [#skl_brief{id = X}|Acc]
				  end,
			lists:foldl(Fun, [], List2)
%% 			[#skl_brief{id = X} || X <- lib_mount:get_mount_skill(MountId), X =/= ?INVALID_NO]
    end.


get_postnatal_skill_list(Partner) ->
    get_postnatal_skill_list(Partner, get_skill_list(Partner), []).

get_postnatal_skill_list(_Partner, [], AccList) ->
    AccList;
get_postnatal_skill_list(Partner, [H | T], AccList) ->
    SklCfg = data_skill:get(H#skl_brief.id),
    case SklCfg#skl_cfg.is_inborn of
        1 ->
            get_postnatal_skill_list(Partner, T, AccList);
        0 ->
            get_postnatal_skill_list(Partner, T, [H] ++ AccList)
    end.


get_skill_name_list(Partner) ->
    List = get_skill_list(Partner),
    F = fun(SklBrief, Acc) ->
        SklCfg = data_skill:get(SklBrief#skl_brief.id),
        [SklCfg#skl_cfg.name | Acc]
    end,
    lists:foldl(F, [], List).


get_inborn_skill_name_list(Partner) ->
    List = get_skill_list(Partner) -- get_postnatal_skill_list(Partner),
    F = fun(SklBrief, Acc) ->
        SklCfg = data_skill:get(SklBrief#skl_brief.id),
        case SklCfg#skl_cfg.is_inborn of
            1 -> [SklCfg#skl_cfg.name | Acc];
            0 -> Acc
        end
    end,
    lists:foldl(F, [], List).


get_postnatal_skill_name_list(Partner) ->
    List = get_postnatal_skill_list(Partner),
    F = fun(SklBrief, Acc) ->
        SklCfg = data_skill:get(SklBrief#skl_brief.id),
        case SklCfg#skl_cfg.is_inborn of
            1 -> [SklCfg#skl_cfg.name | Acc];
            0 -> []
        end
    end,
    lists:foldl(F, [], List).

%% 获取宠物的ai列表
%% @return：ai编号列表
get_AI_list(Partner) ->
    ?ASSERT(is_record(Partner, partner), Partner),
    case (get_equip_skill(Partner) ++ get_skill_list(Partner)) of
        [] ->
            [];
        SklBriefList ->
            lib_skill:build_AI_list_from(SklBriefList)
    end.


%% 判断是否主宠
is_main_partner(Partner) ->
    Partner#partner.position =:= ?PAR_POS_MAIN.

is_follow_partner(Partner) ->
    Partner#partner.follow =:= ?PAR_FOLLOW.

get_position(Partner) ->
    Partner#partner.position.

set_position(Partner, Value) ->
    Partner#partner{position = Value}.

get_follow_state(Partner) ->
    Partner#partner.follow.

set_follow_state(Partner, Value) ->
    Partner#partner{follow = Value}.

%% 因规则调整，调整数据版本用
get_version(Partner) ->
    Partner#partner.version.

set_version(Partner, Value) ->
    Partner#partner{version = Value}.

set_dirty_flag(Partner, Value) ->
    Partner#partner{is_dirty = Value}.


get_add_skill_fail_cnt(Partner) ->
    Partner#partner.add_skill_fail_cnt.

set_add_skill_fail_cnt(Partner, Value) ->
    Partner#partner{add_skill_fail_cnt = Value}.

%% 判断宠物是否参战
is_fighting(Partner) ->
    case get_state(Partner) of
        ?PAR_STATE_JOIN_BATTLE_UNLOCKED -> true;
        ?PAR_STATE_JOIN_BATTLE_LOCKED -> true;
        _ -> false
    end.

set_rest_state(Partner) ->
    Value =
        case get_state(Partner) of
        ?PAR_STATE_JOIN_BATTLE_UNLOCKED -> ?PAR_STATE_REST_UNLOCKED;
        ?PAR_STATE_JOIN_BATTLE_LOCKED -> ?PAR_STATE_REST_LOCKED;
        _ -> get_state(Partner)
    end,
    Partner#partner{state = Value, join_battle_order = 0}.

%% 获取宠物的主人（玩家）的id
get_owner_id(Partner) ->
    Partner#partner.player_id.


%% 主人是否在线？（true | false）
is_owner_online(Partner) ->
    OwnerId = get_owner_id(Partner),
    player:is_online(OwnerId).


get_life_lim(Partner) ->
    DataQuality = data_quality_relate:get(get_quality(Partner)),
    DataQuality#quality_relate_data.life.


set_life(Partner, Value) ->
    NewValue = util:minmax(Value, 0, get_life_lim(Partner)),
    Partner1 = Partner#partner{life = NewValue},
    notify_cli_info_change(Partner1, [{?OI_CODE_PAR_LIFE, NewValue}]),
    Partner1.

get_cur_battle_num(Partner) ->
    Partner#partner.cur_battle_num.

set_cur_battle_num(Partner, Value) ->
    Partner#partner{cur_battle_num = Value}.


get_base_grow(Partner) ->
    Partner#partner.base_train_attrs#base_train_attrs.grow.

get_base_life_aptitude(Partner) ->
    Partner#partner.base_train_attrs#base_train_attrs.life_aptitude.

get_base_mag_aptitude(Partner) ->
    Partner#partner.base_train_attrs#base_train_attrs.mag_aptitude.

get_base_phy_att_aptitude(Partner) ->
    Partner#partner.base_train_attrs#base_train_attrs.phy_att_aptitude.

get_base_mag_att_aptitude(Partner) ->
    Partner#partner.base_train_attrs#base_train_attrs.mag_att_aptitude.

get_base_phy_def_aptitude(Partner) ->
    Partner#partner.base_train_attrs#base_train_attrs.phy_def_aptitude.

get_base_mag_def_aptitude(Partner) ->
    Partner#partner.base_train_attrs#base_train_attrs.mag_def_aptitude.

get_base_speed_aptitude(Partner) ->
    Partner#partner.base_train_attrs#base_train_attrs.speed_aptitude.


get_base_grow_tmp(Partner) ->
    Partner#partner.base_train_attrs_tmp#base_train_attrs.grow.

get_base_life_aptitude_tmp(Partner) ->
    Partner#partner.base_train_attrs_tmp#base_train_attrs.life_aptitude.

get_base_mag_aptitude_tmp(Partner) ->
    Partner#partner.base_train_attrs_tmp#base_train_attrs.mag_aptitude.

get_base_phy_att_aptitude_tmp(Partner) ->
    Partner#partner.base_train_attrs_tmp#base_train_attrs.phy_att_aptitude.

get_base_mag_att_aptitude_tmp(Partner) ->
    Partner#partner.base_train_attrs_tmp#base_train_attrs.mag_att_aptitude.

get_base_phy_def_aptitude_tmp(Partner) ->
    Partner#partner.base_train_attrs_tmp#base_train_attrs.phy_def_aptitude.

get_base_mag_def_aptitude_tmp(Partner) ->
    Partner#partner.base_train_attrs_tmp#base_train_attrs.mag_def_aptitude.

get_base_speed_aptitude_tmp(Partner) ->
    Partner#partner.base_train_attrs_tmp#base_train_attrs.speed_aptitude.



set_base_train_attrs(Partner, TrainAttrs) when is_record(TrainAttrs, base_train_attrs) ->
    Partner#partner{base_train_attrs = TrainAttrs}.

set_base_train_attrs_tmp(Partner, TrainAttrs) when is_record(TrainAttrs, base_train_attrs) ->
    Partner#partner{base_train_attrs_tmp = TrainAttrs}.


set_skills_use(Partner, SkillsUse) ->
	Partner#partner{skills_use = SkillsUse}.


% 基础成长值+附加成长值(读进化等级相关的表)
get_cur_grow(Partner) ->
    Quality = get_quality(Partner),
    % F = fun(Lv, Sum) ->
    %     case data_partner_evolve:get(Quality, Lv) of
    %         null -> Sum;
    %         DataEvolve -> DataEvolve#partner_evolve.grow_add + Sum
    %     end
    % end,
    Lv = get_evolve_lv(Partner),
    EvolveGrow =
        case data_partner_evolve:get(Quality, Lv) of
            null -> 0;
            DataEvolve -> DataEvolve#partner_evolve.grow_add
        end,
    % EvolveGrow = lists:foldl(F, 0, lists:seq(1, get_evolve_lv(Partner))),
    get_base_grow(Partner) *(1 + EvolveGrow) .


% 基础资质值(随机获取，随机范围读表 已经保存在base_train_attrs结构体中)+附加资质值(公式) : 附加部分资质上限*（11-修炼等级）*2/110 * 资质品质参数上限
%% 改成 累加修炼表result*性格表data2对应的系数
get_cur_life_aptitude(Partner) ->
    DataNature = data_nature_relate:get(get_nature(Partner)+1000),
    NatureCoef = DataNature#nature_relate_data.life_lean,
    F = fun(No, Sum) ->
        {Lv, Layer} = data_partner_cultivate:get(No),
        case data_partner_cultivate:get(Lv, Layer) of
            null -> Sum;
            Data -> Data#partner_cultivate.result * NatureCoef + Sum
        end
    end,

    NoMax =
        case data_partner_cultivate:get(get_cultivate_lv(Partner), get_cultivate_layer(Partner)) of
            null -> lists:last(data_partner_cultivate:get_all_cultivate_no_list());
            DataCultivate -> DataCultivate#partner_cultivate.no
        end,

    Add = util:ceil(lists:foldl(F, 0, lists:seq(1, NoMax))),
    get_base_life_aptitude(Partner) + Add.


% 基础资质值(随机获取，随机范围读表 已经保存在base_train_attrs结构体中)+附加资质值(公式)
get_cur_mag_aptitude(Partner) ->
    DataNature = data_nature_relate:get(get_nature(Partner)+1000),
    NatureCoef = DataNature#nature_relate_data.super_power_lean,
    F = fun(No, Sum) ->
        {Lv, Layer} = data_partner_cultivate:get(No),
        case data_partner_cultivate:get(Lv, Layer) of
            null -> Sum;
            Data -> Data#partner_cultivate.result * NatureCoef + Sum
        end
    end,

    NoMax =
        case data_partner_cultivate:get(get_cultivate_lv(Partner), get_cultivate_layer(Partner)) of
            null -> lists:last(data_partner_cultivate:get_all_cultivate_no_list());
            DataCultivate -> DataCultivate#partner_cultivate.no
        end,

    Add = util:ceil(lists:foldl(F, 0, lists:seq(1, NoMax))),
    get_base_mag_aptitude(Partner) + Add.


% 基础资质值(随机获取，随机范围读表 已经保存在base_train_attrs结构体中)+附加资质值(公式)
get_cur_phy_att_aptitude(Partner) ->
    DataNature = data_nature_relate:get(get_nature(Partner)+1000),
    NatureCoef = DataNature#nature_relate_data.phy_att_lean,
    F = fun(No, Sum) ->
        {Lv, Layer} = data_partner_cultivate:get(No),
        case data_partner_cultivate:get(Lv, Layer) of
            null -> Sum;
            Data -> Data#partner_cultivate.result * NatureCoef + Sum
        end
    end,

    NoMax =
        case data_partner_cultivate:get(get_cultivate_lv(Partner), get_cultivate_layer(Partner)) of
            null -> lists:last(data_partner_cultivate:get_all_cultivate_no_list());
            DataCultivate -> DataCultivate#partner_cultivate.no
        end,

    Add = util:ceil(lists:foldl(F, 0, lists:seq(1, NoMax))),
    get_base_phy_att_aptitude(Partner) + Add.


% 基础资质值(随机获取，随机范围读表 已经保存在base_train_attrs结构体中)+附加资质值(公式)
get_cur_mag_att_aptitude(Partner) ->
    DataNature = data_nature_relate:get(get_nature(Partner)+1000),
    NatureCoef = DataNature#nature_relate_data.mag_att_lean,
    F = fun(No, Sum) ->
        {Lv, Layer} = data_partner_cultivate:get(No),
        case data_partner_cultivate:get(Lv, Layer) of
            null -> Sum;
            Data -> Data#partner_cultivate.result * NatureCoef + Sum
        end
    end,

    NoMax =
        case data_partner_cultivate:get(get_cultivate_lv(Partner), get_cultivate_layer(Partner)) of
            null -> lists:last(data_partner_cultivate:get_all_cultivate_no_list());
            DataCultivate -> DataCultivate#partner_cultivate.no
        end,

    Add = util:ceil(lists:foldl(F, 0, lists:seq(1, NoMax))),
    get_base_mag_att_aptitude(Partner) + Add.


% 基础资质值(随机获取，随机范围读表 已经保存在base_train_attrs结构体中)+附加资质值(公式)
get_cur_phy_def_aptitude(Partner) ->
    DataNature = data_nature_relate:get(get_nature(Partner)+1000),
    NatureCoef = DataNature#nature_relate_data.phy_def_lean,
    F = fun(No, Sum) ->
        {Lv, Layer} = data_partner_cultivate:get(No),
        case data_partner_cultivate:get(Lv, Layer) of
            null -> Sum;
            Data -> Data#partner_cultivate.result * NatureCoef + Sum
        end
    end,

    NoMax =
        case data_partner_cultivate:get(get_cultivate_lv(Partner), get_cultivate_layer(Partner)) of
            null -> lists:last(data_partner_cultivate:get_all_cultivate_no_list());
            DataCultivate -> DataCultivate#partner_cultivate.no
        end,

    Add = util:ceil(lists:foldl(F, 0, lists:seq(1, NoMax))),
    get_base_phy_def_aptitude(Partner) + Add.


% 基础资质值(随机获取，随机范围读表 已经保存在base_train_attrs结构体中)+附加资质值(公式
get_cur_mag_def_aptitude(Partner) ->
    DataNature = data_nature_relate:get(get_nature(Partner)+1000),
    NatureCoef = DataNature#nature_relate_data.mag_def_lean,
    F = fun(No, Sum) ->
        {Lv, Layer} = data_partner_cultivate:get(No),
        case data_partner_cultivate:get(Lv, Layer) of
            null -> Sum;
            Data -> Data#partner_cultivate.result * NatureCoef + Sum
        end
    end,

    NoMax =
        case data_partner_cultivate:get(get_cultivate_lv(Partner), get_cultivate_layer(Partner)) of
            null -> lists:last(data_partner_cultivate:get_all_cultivate_no_list());
            DataCultivate -> DataCultivate#partner_cultivate.no
        end,

    Add = util:ceil(lists:foldl(F, 0, lists:seq(1, NoMax))),
    get_base_mag_def_aptitude(Partner) + Add.


% 基础资质值(随机获取，随机范围读表 已经保存在base_train_attrs结构体中)+附加资质值(公式)
get_cur_speed_aptitude(Partner) ->
    DataNature = data_nature_relate:get(get_nature(Partner)+1000),
    NatureCoef = DataNature#nature_relate_data.speed_lean,
    F = fun(No, Sum) ->
        {Lv, Layer} = data_partner_cultivate:get(No),
        case data_partner_cultivate:get(Lv, Layer) of
            null -> Sum;
            Data -> Data#partner_cultivate.result * NatureCoef + Sum
        end
    end,

    NoMax =
        case data_partner_cultivate:get(get_cultivate_lv(Partner), get_cultivate_layer(Partner)) of
            null -> lists:last(data_partner_cultivate:get_all_cultivate_no_list());
            DataCultivate -> DataCultivate#partner_cultivate.no
        end,

    Add = util:ceil(lists:foldl(F, 0, lists:seq(1, NoMax))),
    get_base_speed_aptitude(Partner) + Add.


%%读表，和品质相关
get_max_grow(Partner) ->
    % DataQualityRelate = data_quality_relate:get(get_quality(Partner)),
    % lists:nth(2, DataQualityRelate#quality_relate_data.growth_value_region).
    PlayerLvNeed = (data_partner:get(get_no(Partner)))#par_born_data.ref_lv,
    case get_quality(Partner) of
        ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_max;
        ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_max;
        ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_max;
        ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_max;
        ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_max;
        ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_max;
        _Any -> ?ASSERT(false, _Any), 0
    end.

%% 基础部分资质上限=对应出战等级对应品质的读表值上限*性格偏向
get_max_life_aptitude(Partner) ->
    % DataQualityRelate = data_quality_relate:get(get_quality(Partner)),
    % lists:nth(1, DataQualityRelate#quality_relate_data.one_aptitude_min_max).
    % DataQuality = data_quality_relate:get(get_quality(Partner)),
    % QualityCoef = DataQuality#quality_relate_data.one_aptitude_region,

    Data = data_nature_relate:get(get_nature(Partner)),
    PlayerLvNeed = (data_partner:get(get_no(Partner)))#par_born_data.ref_lv,
    Max =
        case get_quality(Partner) of
            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_max;
            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_max;
            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_max;
            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_max;
            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_max;
            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_max;
            _Any -> ?ASSERT(false, _Any), 0
        end,
    util:ceil(Data#nature_relate_data.life_lean * Max).

get_max_mag_aptitude(Partner) ->
    % DataQualityRelate = data_quality_relate:get(get_quality(Partner)),
    % lists:nth(2, DataQualityRelate#quality_relate_data.one_aptitude_min_max).
    % DataQuality = data_quality_relate:get(get_quality(Partner)),
    % QualityCoef = DataQuality#quality_relate_data.one_aptitude_region,
    Data = data_nature_relate:get(get_nature(Partner)),
    PlayerLvNeed = (data_partner:get(get_no(Partner)))#par_born_data.ref_lv,
    Max =
        case get_quality(Partner) of
            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_max;
            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_max;
            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_max;
            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_max;
            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_max;
            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_max;
            _Any -> ?ASSERT(false, _Any), 0
        end,
    util:ceil(Data#nature_relate_data.super_power_lean*Max).

get_max_phy_att_aptitude(Partner) ->
    % DataQualityRelate = data_quality_relate:get(get_quality(Partner)),
    % lists:nth(3, DataQualityRelate#quality_relate_data.one_aptitude_min_max).
    % DataQuality = data_quality_relate:get(get_quality(Partner)),
    % QualityCoef = DataQuality#quality_relate_data.one_aptitude_region,
    Data = data_nature_relate:get(get_nature(Partner)),
    PlayerLvNeed = (data_partner:get(get_no(Partner)))#par_born_data.ref_lv,
    Max =
        case get_quality(Partner) of
            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_max;
            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_max;
            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_max;
            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_max;
            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_max;
            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_max;
            _Any -> ?ASSERT(false, _Any), 0
        end,
    util:ceil(Data#nature_relate_data.phy_att_lean*Max).

get_max_mag_att_aptitude(Partner) ->
    % DataQualityRelate = data_quality_relate:get(get_quality(Partner)),
    % lists:nth(5, DataQualityRelate#quality_relate_data.one_aptitude_min_max).
    % DataQuality = data_quality_relate:get(get_quality(Partner)),
    % QualityCoef = DataQuality#quality_relate_data.one_aptitude_region,
    Data = data_nature_relate:get(get_nature(Partner)),
    PlayerLvNeed = (data_partner:get(get_no(Partner)))#par_born_data.ref_lv,
    Max =
        case get_quality(Partner) of
            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_max;
            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_max;
            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_max;
            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_max;
            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_max;
            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_max;
            _Any -> ?ASSERT(false, _Any), 0
        end,
    util:ceil(Data#nature_relate_data.mag_att_lean*Max).

get_max_phy_def_aptitude(Partner) ->
    % DataQualityRelate = data_quality_relate:get(get_quality(Partner)),
    % lists:nth(4, DataQualityRelate#quality_relate_data.one_aptitude_min_max).
    % DataQuality = data_quality_relate:get(get_quality(Partner)),
    % QualityCoef = DataQuality#quality_relate_data.one_aptitude_region,
    Data = data_nature_relate:get(get_nature(Partner)),
    PlayerLvNeed = (data_partner:get(get_no(Partner)))#par_born_data.ref_lv,
    Max =
        case get_quality(Partner) of
            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_max;
            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_max;
            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_max;
            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_max;
            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_max;
            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_max;
            _Any -> ?ASSERT(false, _Any), 0
        end,
    util:ceil(Data#nature_relate_data.phy_def_lean*Max).

get_max_mag_def_aptitude(Partner) ->
    % DataQualityRelate = data_quality_relate:get(get_quality(Partner)),
    % lists:nth(6, DataQualityRelate#quality_relate_data.one_aptitude_min_max).
    % DataQuality = data_quality_relate:get(get_quality(Partner)),
    % QualityCoef = DataQuality#quality_relate_data.one_aptitude_region,
    Data = data_nature_relate:get(get_nature(Partner)),
    PlayerLvNeed = (data_partner:get(get_no(Partner)))#par_born_data.ref_lv,
    Max =
        case get_quality(Partner) of
            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_max;
            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_max;
            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_max;
            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_max;
            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_max;
            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_max;
            _Any -> ?ASSERT(false, _Any), 0
        end,
    util:ceil(Data#nature_relate_data.mag_def_lean*Max).

get_max_speed_aptitude(Partner) ->
    % DataQualityRelate = data_quality_relate:get(get_quality(Partner)),
    % lists:nth(7, DataQualityRelate#quality_relate_data.one_aptitude_min_max).
    % DataQuality = data_quality_relate:get(get_quality(Partner)),
    % QualityCoef = DataQuality#quality_relate_data.one_aptitude_region,
    Data = data_nature_relate:get(get_nature(Partner)),
    PlayerLvNeed = (data_partner:get(get_no(Partner)))#par_born_data.ref_lv,
    Max =
        case get_quality(Partner) of
            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_max;
            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_max;
            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_max;
            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_max;
            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_max;
            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_max;
            _Any -> ?ASSERT(false, _Any), 0
        end,
    util:ceil(Data#nature_relate_data.speed_lean*Max).


% 过滤无效装备
is_work(Goods) ->
    %装备位置是否符合
    case lib_goods:get_equip_pos(Goods) =:= lib_goods:get_slot(Goods) of
    true ->
        %装备是否是不需要计算时间的
        case lib_goods:get_expire_time(Goods) == 0 of
        true ->
            true;
        _ ->
            %限时装备获得剩余时间
            case lib_goods:get_expire_time(Goods) /= 0 of
            true ->
                case lib_goods:get_left_valid_time(Goods) /= 0 of
                true ->
                    true;
                __ -> false
                end
            end
        end
    end.

%% 计算装备的加成属性
%% @return: partner结构体
calc_equip_add_attrs(Partner) ->
    % 遍历装备栏的装备，对各个装备的加成属性求和，并返回
    TEqpList = mod_equip:get_partner_equip_list(Partner#partner.player_id, get_id(Partner)),
    % 计算战力时，把位置错误的装备过滤掉
    EqpList = [Goods || Goods <- TEqpList, is_work(Goods)],

    % 宠物的装备基本属性以及装备强化属性只能获得70%
    AttrsList1 = [lib_attribute:calc_attrs_for_coef(Goods#goods.base_equip_add,?PAR_EQUIP_BASE_ATTR_COEF) || Goods <- EqpList, Goods#goods.base_equip_add /= null],
    AttrsList2 = [Goods#goods.addi_equip_add || Goods <- EqpList, Goods#goods.addi_equip_add /= null],
    AttrsList3 = [lib_attribute:calc_attrs_for_coef(Goods#goods.stren_equip_add,?PAR_EQUIP_STRENGTHEN_ATTR_COEF) || Goods <- EqpList, Goods#goods.stren_equip_add /= null],

    F = fun(Goods, Acc) ->
        AddiEquipEffNo = Goods#goods.addi_equip_eff,
        TransmoEffNo = lib_goods:get_transmo_eff_no(Goods),

        Ret = case TransmoEffNo of
                  0 ->
                      case AddiEquipEffNo of
                          0 ->
                              #attrs{};
                          null ->
                              #attrs{};
                          _ ->
                              lib_attribute:to_addi_equip_eff(AddiEquipEffNo)
                      end;
                  _ ->
                      case AddiEquipEffNo of
                          0 ->
                              lib_attribute:to_addi_equip_eff(TransmoEffNo);
                          null ->
                              lib_attribute:to_addi_equip_eff(TransmoEffNo);
                          _ ->
                              EquipEffCfg = data_equip_speci_effect:get(AddiEquipEffNo),
                              EquipEffName = EquipEffCfg#equip_speci_effect_tpl.eff_name,
                              Value1 = EquipEffCfg#equip_speci_effect_tpl.value,

                              TransmoEffCfg = data_equip_speci_effect:get(TransmoEffNo),
                              TransmoEffName = TransmoEffCfg#equip_speci_effect_tpl.eff_name,
                              Value2 = TransmoEffCfg#equip_speci_effect_tpl.value,
                              case EquipEffName =:= TransmoEffName of
                                  true ->
                                      if
                                          Value1 > Value2 ->
                                              lib_attribute:to_addi_equip_eff(AddiEquipEffNo);
                                          Value1 < Value2 ->
                                              lib_attribute:to_addi_equip_eff(TransmoEffNo);
                                          true ->
                                              lib_attribute:to_addi_equip_eff(TransmoEffNo)
                                      end;
                                  false ->
                                      Attr1 = lib_attribute:to_addi_equip_eff(AddiEquipEffNo),
                                      Attr2 = lib_attribute:to_addi_equip_eff(TransmoEffNo),
                                      lib_attribute:sum_two_attrs(Attr1, Attr2)

                              end
                      end
              end,
        [Ret | Acc]
    end,
    AttrsList4 = lists:foldl(F, [], EqpList),

    %% 幻化附加属性
    F2 = fun(Equip, Acc) ->
        AddiList =
            case lib_goods:get_transmo_ref_attr(Equip) of
                null ->
                    #attrs{};
                AttrList ->
                    lib_attribute:to_addi_equip_add_attrs_record(AttrList)
            end,
        [AddiList | Acc]
         end,
    AttrsList5 = lists:foldl(F2, [], EqpList),
    ?DEBUG_MSG("---------------------------Partner AttrsList5----------------------------- = ~p~n",[AttrsList5]),

    AttrsList = AttrsList1 ++ AttrsList2 ++ AttrsList3 ++ AttrsList4 ++ AttrsList5,
    EquipAddAttrs = lib_attribute:sum_attrs(AttrsList),
    Partner#partner{equip_add_attrs = EquipAddAttrs}.


%% 重新计算装备的加成属性
%% @return: partner结构体
recount_equip_add_attrs(Partner_Latest) when is_record(Partner_Latest, partner) ->
    calc_equip_add_attrs(Partner_Latest).


%% 计算被动技能效果加成 return attrs
calc_passi_eff_attrs(Partner, TotalAttrs) ->
    PSkillList = get_passive_skill_list(Partner),
    F = fun(PSkill, Attrs) ->
        SklCfg = mod_skill:get_cfg_data(PSkill#skl_brief.id),
        PassiEffNoList = mod_skill:get_passive_effs(SklCfg),
        lib_passi_eff:calc_passi_eff(Attrs, get_lv(Partner), PassiEffNoList)
    end,
    lists:foldl(F, TotalAttrs, PSkillList).
    % ?ASSERT(is_record(PassiEffAttrs, attrs), PassiEffAttrs),
    % Partner#partner{passi_eff_attrs = PassiEffAttrs}.

% recount_passi_eff_attrs(Partner) ->
%     calc_passi_eff_attrs(Partner).


%% 计算buff效果加成 return attrs
calc_buff_eff_attrs(Partner, TotalAttrs) ->
    F = fun(BuffNo, Attrs) ->
        lib_buff_eff:calc_one_buff_eff(Attrs, BuffNo)
    end,

    lists:foldl(F, TotalAttrs, get_buff_no_list(Partner)).

    % Partner#partner{buff_eff_attrs = BuffEffAttrs}.

% recount_buff_eff_attrs(Partner) ->
%     calc_buff_eff_attrs(Partner).


%% 重算装备的加成属性和总属性
recount_equip_add_and_total_attrs(PlayerId, PartnerId) ->
    ?ASSERT(lists:member(PartnerId, player:get_partner_id_list(PlayerId))),
    Partner_Latest = get_partner(PartnerId),
    Partner_Latest2 = recount_equip_add_attrs(Partner_Latest),
    Partner_Latest3 = recount_total_attrs(Partner_Latest2),
    recount_battle_power(Partner_Latest3).

calc_gem_add_attrs(PlayerId, Partner_Latest, Attrs) ->
  PSkillList = get_passive_skill_list(Partner_Latest),
  PasiiEffNoFun = fun(Skill, PasiiEffNoAcc) ->
    SklCfg = mod_skill:get_cfg_data(Skill#skl_brief.id),
    PasiiEffNoAcc ++  mod_skill:get_passive_effs(SklCfg)
                  end,
  PassiEffNoList = lists:foldl(PasiiEffNoFun, [], PSkillList),
  IsGemPassi = find_gem_passi(PassiEffNoList),

    F = fun(GemNo, AccAttrs) ->
        lib_equip:calc_one_gem_attrs(AccAttrs, GemNo,?PAR_EQUIP_BASE_ATTR_COEF,IsGemPassi)
    end,
    List = mod_equip:get_partner_equip_gem_list(PlayerId,get_id(Partner_Latest)),
    % ?DEBUG_MSG("calc_gem_add_attrs,GemNos=~p~n", [List]),
    lists:foldl(F, Attrs, List).

find_gem_passi([EffNo|T]) ->
  PassiEff = data_passi_eff:get(EffNo),
  case PassiEff#passi_eff.name  == ?EN_ADD_GEM_ATTE_RATE of
    true ->
      {true, PassiEff#passi_eff.para};
    false ->
      find_gem_passi(T)
  end;

find_gem_passi([]) ->
  {false, 0}.


%% 计算宝石额外的战力加成
calc_gem_add_battle(PlayerId,Partner_Latest) ->
    StandardHp = mod_xinfa:get_std_value(get_lv(Partner_Latest), ?ATTR_HP),
    F = fun(GemNo, Sum) ->
        case data_gem_add:get(GemNo) of
            null -> Sum;
            Data -> Data#gem_add.coef * StandardHp + Sum
        end
    end,
    lists:foldl(F, 0, mod_equip:get_partner_equip_gem_list(PlayerId,get_id(Partner_Latest))).


% 计算属性点增加属性
calc_talents_attrs(OldAtt,Talents) ->
    Con = Talents#talents.con,
    Str = Talents#talents.str,
    Agi = Talents#talents.agi,
    Spi = Talents#talents.spi,
    Sta = Talents#talents.sta,

  ConCfg = data_attr_growth_coef:get(1),
  StrCfg = data_attr_growth_coef:get(2),
  AgiCfg = data_attr_growth_coef:get(3),
  SpiCfg = data_attr_growth_coef:get(4),
  StaCfg = data_attr_growth_coef:get(5),

    % 现在的计算与种族无关
    HpLim     =OldAtt#attrs.hp_lim + max( util:floor(Con*ConCfg#attr_growth_coef.hp         + Str*StrCfg#attr_growth_coef.hp         + Agi*AgiCfg#attr_growth_coef.hp         + Spi*SpiCfg#attr_growth_coef.hp         + Sta*StaCfg#attr_growth_coef.hp), 1),  % 血量上限至少为1
    MpLim     =OldAtt#attrs.mp_lim + util:floor(Con*ConCfg#attr_growth_coef.mp         + Str*StrCfg#attr_growth_coef.mp         + Agi*AgiCfg#attr_growth_coef.mp         + Spi*SpiCfg#attr_growth_coef.mp         + Sta*StaCfg#attr_growth_coef.mp),
    PhyAtt    =OldAtt#attrs.phy_att + util:floor(Con*ConCfg#attr_growth_coef.phy_att    + Str*StrCfg#attr_growth_coef.phy_att    + Agi*AgiCfg#attr_growth_coef.phy_att    + Spi*SpiCfg#attr_growth_coef.phy_att    + Sta*StaCfg#attr_growth_coef.phy_att),
    MagAtt    =OldAtt#attrs.mag_att + util:floor(Con*ConCfg#attr_growth_coef.mag_att    + Str*StrCfg#attr_growth_coef.mag_att    + Agi*AgiCfg#attr_growth_coef.mag_att    + Spi*SpiCfg#attr_growth_coef.mag_att    + Sta*StaCfg#attr_growth_coef.mag_att),
    PhyDef    =OldAtt#attrs.phy_def + util:floor(Con*ConCfg#attr_growth_coef.phy_def    + Str*StrCfg#attr_growth_coef.phy_def    + Agi*AgiCfg#attr_growth_coef.phy_def    + Spi*SpiCfg#attr_growth_coef.phy_def    + Sta*StaCfg#attr_growth_coef.phy_def),
    MagDef    =OldAtt#attrs.mag_def + util:floor(Con*ConCfg#attr_growth_coef.mag_def    + Str*StrCfg#attr_growth_coef.mag_def    + Agi*AgiCfg#attr_growth_coef.mag_def    + Spi*SpiCfg#attr_growth_coef.mag_def    + Sta*StaCfg#attr_growth_coef.mag_def),
    ActSpeed  =OldAtt#attrs.act_speed + util:floor(Con*ConCfg#attr_growth_coef.act_speed  + Str*StrCfg#attr_growth_coef.act_speed  + Agi*AgiCfg#attr_growth_coef.act_speed  + Spi*SpiCfg#attr_growth_coef.act_speed  + Sta*StaCfg#attr_growth_coef.act_speed),
    % Hit       =OldAtt#attrs.     util:floor(Con*ConCfg#attr_growth_coef.hit        + Str*StrCfg#attr_growth_coef.hit        + Agi*AgiCfg#attr_growth_coef.hit        + Spi*SpiCfg#attr_growth_coef.hit        + Sta*StaCfg#attr_growth_coef.hit),
    % Dodge     =OldAtt#attrs.     util:floor(Con*ConCfg#attr_growth_coef.dodge      + Str*StrCfg#attr_growth_coef.dodge      + Agi*AgiCfg#attr_growth_coef.dodge      + Spi*SpiCfg#attr_growth_coef.dodge      + Sta*StaCfg#attr_growth_coef.dodge),
    SealResis =OldAtt#attrs.seal_resis + util:floor(Con*ConCfg#attr_growth_coef.seal_resis + Str*StrCfg#attr_growth_coef.seal_resis + Agi*AgiCfg#attr_growth_coef.seal_resis + Spi*SpiCfg#attr_growth_coef.seal_resis + Sta*StaCfg#attr_growth_coef.seal_resis),

    SealHit =OldAtt#attrs.seal_hit + util:floor(Con*ConCfg#attr_growth_coef.seal_hit + Str*StrCfg#attr_growth_coef.seal_hit + Agi*AgiCfg#attr_growth_coef.seal_hit + Spi*SpiCfg#attr_growth_coef.seal_hit + Sta*StaCfg#attr_growth_coef.seal_hit),
    HealValue =OldAtt#attrs.heal_value + util:floor(Con*ConCfg#attr_growth_coef.heal_value + Str*StrCfg#attr_growth_coef.heal_value + Agi*AgiCfg#attr_growth_coef.heal_value + Spi*SpiCfg#attr_growth_coef.heal_value + Sta*StaCfg#attr_growth_coef.heal_value),

    OldAtt#attrs{
        hp_lim =  HpLim,
        mp_lim =  MpLim,
        % hp =    OldAtt#attrs.hp,
        % mp =    OldAtt#attrs.mp,
        phy_att =  PhyAtt,
        mag_att =  MagAtt,
        phy_def =  PhyDef,
        mag_def =  MagDef,
        act_speed =  ActSpeed,
        seal_resis = SealResis,
        seal_hit = SealHit,
        heal_value = HealValue
        }.


recount_talents_attrs2(Partner_Latest, TotalAttrs) ->
  Talents = lib_attribute:to_talents_record(TotalAttrs),

  BaseTalents = get_base_talents(Partner_Latest),

  #talents{
    str = Str,
    con = Con,
    sta = Sta,
    spi = Spi,
    agi = Agi
  } = BaseTalents,

  EqTalets =
    #talents{
      str = Talents#talents.str - Str,
      con = Talents#talents.con - Con,
      sta = Talents#talents.sta - Sta,
      spi = Talents#talents.spi - Spi,
      agi = Talents#talents.agi - Agi
    },

  % 判断属性是否非法
  Lv = get_lv(Partner_Latest),
  Sum = Lv * 5 - 5 + Lv * 5 ,
  MySum = Str + Con + Sta + Spi + Agi + get_free_talent_points(Partner_Latest),


  ?DEBUG_MSG("Sum=~p,MySum=~p",[Sum,MySum]),
  MyTalents =
    case Sum >= MySum of
      true ->
        Talents;
      _ ->
%%            % 加点不正常
%%            % 从新计算比率
%%            ?ERROR_MSG("Point is Error = ~p",[{get_id(Partner_Latest),Sum,MySum, Str,Con,Sta, Spi,Agi,get_free_talent_points(Partner_Latest)}]),
%%            % 异常宠物只计算装备附加属性以及等级属性 不计算加点属性
%%            #talents{
%%                str = EqTalets#talents.str + Lv,
%%                con = EqTalets#talents.con + Lv,
%%                sta = EqTalets#talents.sta + Lv,
%%                spi = EqTalets#talents.spi + Lv,
%%                agi = EqTalets#talents.agi + Lv
%%            }
        Talents
    end,

  ?DEBUG_MSG("MyTalents =~p",[MyTalents]),

  Con = Talents#talents.con,
  Str = Talents#talents.str,
  Agi = Talents#talents.agi,
  Spi = Talents#talents.spi,
  Sta = Talents#talents.sta,

  ConCfg = data_attr_growth_coef:get(1),
  StrCfg = data_attr_growth_coef:get(2),
  AgiCfg = data_attr_growth_coef:get(3),
  SpiCfg = data_attr_growth_coef:get(4),
  StaCfg = data_attr_growth_coef:get(5),

  % 现在的计算与种族无关
  HpLim     =max( util:floor(Con*ConCfg#attr_growth_coef.hp         + Str*StrCfg#attr_growth_coef.hp         + Agi*AgiCfg#attr_growth_coef.hp         + Spi*SpiCfg#attr_growth_coef.hp         + Sta*StaCfg#attr_growth_coef.hp), 1),  % 血量上限至少为1
  MpLim     =util:floor(Con*ConCfg#attr_growth_coef.mp         + Str*StrCfg#attr_growth_coef.mp         + Agi*AgiCfg#attr_growth_coef.mp         + Spi*SpiCfg#attr_growth_coef.mp         + Sta*StaCfg#attr_growth_coef.mp),
  PhyAtt    = util:floor(Con*ConCfg#attr_growth_coef.phy_att    + Str*StrCfg#attr_growth_coef.phy_att    + Agi*AgiCfg#attr_growth_coef.phy_att    + Spi*SpiCfg#attr_growth_coef.phy_att    + Sta*StaCfg#attr_growth_coef.phy_att),
  MagAtt    = util:floor(Con*ConCfg#attr_growth_coef.mag_att    + Str*StrCfg#attr_growth_coef.mag_att    + Agi*AgiCfg#attr_growth_coef.mag_att    + Spi*SpiCfg#attr_growth_coef.mag_att    + Sta*StaCfg#attr_growth_coef.mag_att),
  PhyDef    = util:floor(Con*ConCfg#attr_growth_coef.phy_def    + Str*StrCfg#attr_growth_coef.phy_def    + Agi*AgiCfg#attr_growth_coef.phy_def    + Spi*SpiCfg#attr_growth_coef.phy_def    + Sta*StaCfg#attr_growth_coef.phy_def),
  MagDef    = util:floor(Con*ConCfg#attr_growth_coef.mag_def    + Str*StrCfg#attr_growth_coef.mag_def    + Agi*AgiCfg#attr_growth_coef.mag_def    + Spi*SpiCfg#attr_growth_coef.mag_def    + Sta*StaCfg#attr_growth_coef.mag_def),
  ActSpeed  =  util:floor(Con*ConCfg#attr_growth_coef.act_speed  + Str*StrCfg#attr_growth_coef.act_speed  + Agi*AgiCfg#attr_growth_coef.act_speed  + Spi*SpiCfg#attr_growth_coef.act_speed  + Sta*StaCfg#attr_growth_coef.act_speed),
  SealResis =  util:floor(Con*ConCfg#attr_growth_coef.seal_resis + Str*StrCfg#attr_growth_coef.seal_resis + Agi*AgiCfg#attr_growth_coef.seal_resis + Spi*SpiCfg#attr_growth_coef.seal_resis + Sta*StaCfg#attr_growth_coef.seal_resis),
  SealHit = util:floor(Con*ConCfg#attr_growth_coef.seal_hit + Str*StrCfg#attr_growth_coef.seal_hit + Agi*AgiCfg#attr_growth_coef.seal_hit + Spi*SpiCfg#attr_growth_coef.seal_hit + Sta*StaCfg#attr_growth_coef.seal_hit),
  {HpLim,MpLim,PhyAtt,MagAtt,PhyDef,MagDef,ActSpeed,SealResis,SealHit}.


recount_talents_attrs(Partner_Latest, TotalAttrs) ->
    Talents = lib_attribute:to_talents_record(TotalAttrs),

    BaseTalents = get_base_talents(Partner_Latest),

    #talents{
        str = Str,
        con = Con,
        sta = Sta,
        spi = Spi,
        agi = Agi
        } = BaseTalents,

    EqTalets =
    #talents{
        str = Talents#talents.str - Str,
        con = Talents#talents.con - Con,
        sta = Talents#talents.sta - Sta,
        spi = Talents#talents.spi - Spi,
        agi = Talents#talents.agi - Agi
        },

    % 判断属性是否非法
    Lv = get_lv(Partner_Latest),
    Sum = Lv * 5 - 5 + Lv * 5 ,
    MySum = Str + Con + Sta + Spi + Agi + get_free_talent_points(Partner_Latest),


    ?DEBUG_MSG("Sum=~p,MySum=~p",[Sum,MySum]),
    MyTalents =
    case Sum >= MySum of
        true ->
            Talents;
        _ ->
%%            % 加点不正常
%%            % 从新计算比率
%%            ?ERROR_MSG("Point is Error = ~p",[{get_id(Partner_Latest),Sum,MySum, Str,Con,Sta, Spi,Agi,get_free_talent_points(Partner_Latest)}]),
%%            % 异常宠物只计算装备附加属性以及等级属性 不计算加点属性
%%            #talents{
%%                str = EqTalets#talents.str + Lv,
%%                con = EqTalets#talents.con + Lv,
%%                sta = EqTalets#talents.sta + Lv,
%%                spi = EqTalets#talents.spi + Lv,
%%                agi = EqTalets#talents.agi + Lv
%%            }
            Talents
    end,

    ?DEBUG_MSG("MyTalents =~p",[MyTalents]),
    calc_talents_attrs(TotalAttrs,MyTalents).


%% 重算总属性（调用此函数时，须事先重算好所有其他的属性，如基础属性、装备的加成属性）
recount_total_attrs(Partner_Latest) ->
    OldTotalAttrs = get_total_attrs(Partner_Latest),
   ?DEBUG_MSG("wjcTestParAttr2 OldTotalAttrs ~p~n",[OldTotalAttrs#attrs.phy_att] ),

    L = ?PARTNER_ATTRS_FIELD_LIST(Partner_Latest),
    NewTotalAttrs = lib_attribute:sum_attrs(L),
    NewTotalAttrs1 = calc_passi_eff_attrs(Partner_Latest, NewTotalAttrs),
    NewTotalAttrs2 = calc_buff_eff_attrs(Partner_Latest, NewTotalAttrs1),
    PlayerId = Partner_Latest#partner.player_id,
    NewTotalAttrs3 = calc_gem_add_attrs(PlayerId, Partner_Latest, NewTotalAttrs2),
    NewTotalAttrs4_1 = calc_cultivate_attrs(Partner_Latest, NewTotalAttrs3),   % 帮派点修属性加成
    PartnerId = Partner_Latest#partner.id,
    NewTotalAttrs4 = calc_mount_attr(Partner_Latest, NewTotalAttrs4_1),
    NewTotalAttrs5 = lib_attribute:calc_rate_attrs(NewTotalAttrs4, NewTotalAttrs4),

  %% wjc 2019.11.6 加点的算法改变了，这里弃用
    % 计算属性点带来的属性
%%    NewTotalAttrs6 = recount_talents_attrs(Partner_Latest,NewTotalAttrs5),
%%    case get(arts) of
%%        ?undefined ->
%%            lib_train:login_update_art_data(PlayerId),
%%            AttrList = lib_train:login_init_server_by_data(PlayerId, PartnerId);
%%        _ArtsIdList ->
%%            AttrList = lib_train:attr_bonus_by_data(PartnerId)
%%    end,
%%  ?DEBUG_MSG("wjcTestParAttr2 NewTotalAttrs6  ~p~n",[NewTotalAttrs6#attrs.hp_lim] ),
  case get(arts) of
    ?undefined ->
      lib_train:login_update_art_data(PlayerId),
      AttrList = lib_train:login_init_server_by_data(PlayerId, PartnerId);
    _ArtsIdList ->
      AttrList = lib_train:attr_bonus_by_data(PartnerId)
  end,

  %% 门客内功属性加成
    NewTotalAttrs4_2 = lib_attribute:attr_bonus(NewTotalAttrs5, AttrList),
  ?DEBUG_MSG("wjcTestParAttr2 NewTotalAttrs4_2  ~p~n",[NewTotalAttrs4_2#attrs.phy_att] ),

  %计算五行属性
  NewTotalAttrs4_3 = calc_five_element_attr(Partner_Latest,NewTotalAttrs4_2),
  ?DEBUG_MSG("wjcTestParAttr2 NewTotalAttrs4_3  ~p~n",[NewTotalAttrs4_3#attrs.phy_att] ),

  %计算修炼属性
  NewTotalAttrs4_4 = cacl_cultivate_attrs(NewTotalAttrs4_3, Partner_Latest),
	
  % 计算宠物觉醒属性
  PartnerNo = get_no(Partner_Latest),
  AwakeLv = get_awake_lv(Partner_Latest),
  NewTotalAttrs4_5 = lib_attribute:attr_bonus(NewTotalAttrs4_4, ply_partner:attr_bonus_by_awake_lv(PartnerNo, AwakeLv)),
	
  %% 最终属性和精炼属性直接加成，这里要确定下是放到前面的总属性还是这里和最终属性简单相加？2020.01.11 zjy
  AttrRefine = lib_attribute:to_attrs_record(Partner_Latest#partner.attr_refine),

  NewTotalAttrs4_6 = lib_attribute:sum_two_attrs(NewTotalAttrs4_5, AttrRefine),

  NewTotalAttrs7 = lib_attribute:adjust_attrs(NewTotalAttrs4_6),
  ?DEBUG_MSG("wjcTestParAttr2 NewTotalAttrs7  ~p~n",[NewTotalAttrs7#attrs.phy_att] ),

    % 增加计算属性点属性
    Partner_Latest1 = set_total_attrs(Partner_Latest, NewTotalAttrs7),
    % 重算完总属性后，主动通知客户端
    notify_cli_total_attrs_change(Partner_Latest1, OldTotalAttrs, NewTotalAttrs7),
    Partner_Latest1.


%%计算五行属性加成
calc_five_element_attr(Partner,OldTotalAttrs) ->
  {FiveElement, FiveElementLv} = Partner#partner.five_element,
  case FiveElementLv > 2 of
    true ->
      F =
        fun(X, Acc) ->
          FiveElementData = data_five_elements_level:get(FiveElement, X),
          case FiveElementData#five_elements_level.effect of
            act_speed_rate ->
              ?DEBUG_MSG("act_speed_rate old: ~p, new: ~p, rate:~p ~n",[Acc#attrs.act_speed,
                (FiveElementData#five_elements_level.effect_num *Acc#attrs.act_speed ), FiveElementData#five_elements_level.effect_num]),
              Acc#attrs{act_speed = util:ceil(Acc#attrs.act_speed +
                (FiveElementData#five_elements_level.effect_num *Acc#attrs.act_speed ) )};
            crit_rate ->
              ?DEBUG_MSG("crit_rate old: ~p, new: ~p, rate:~p ~n",[Acc#attrs.mag_crit,
                (FiveElementData#five_elements_level.effect_num *Acc#attrs.mag_crit ), FiveElementData#five_elements_level.effect_num]),
              Acc#attrs{phy_crit = util:ceil(Acc#attrs.phy_crit +FiveElementData#five_elements_level.effect_num ),
                mag_crit =   util:ceil(Acc#attrs.mag_crit +FiveElementData#five_elements_level.effect_num )};
            crit_coef ->
              ?DEBUG_MSG("crit_coef old: ~p, new: ~p, rate:~p ~n",[Acc#attrs.phy_crit_coef,
                (FiveElementData#five_elements_level.effect_num *Acc#attrs.phy_crit_coef ), FiveElementData#five_elements_level.effect_num]),
              %%2代表两倍？那0.05就代表提升百分之五
              Acc#attrs{phy_crit_coef = (Acc#attrs.phy_crit_coef +FiveElementData#five_elements_level.effect_num ),
                mag_crit_coef = (Acc#attrs.mag_crit_coef +FiveElementData#five_elements_level.effect_num ) };
            hp_lim_rate ->
              ?DEBUG_MSG("hp_lim_rate old: ~p, new: ~p, rate:~p ~n",[Acc#attrs.hp_lim,
                (FiveElementData#five_elements_level.effect_num *Acc#attrs.hp_lim ), FiveElementData#five_elements_level.effect_num]),
              Acc#attrs{hp_lim = util:ceil(Acc#attrs.hp_lim +(Acc#attrs.hp_lim * FiveElementData#five_elements_level.effect_num) )};
            be_dam_reduce_coef ->
              ?DEBUG_MSG("be_dam_reduce_coef old: ~p, new: ~p, rate:~p ~n",[Acc#attrs.be_phy_dam_reduce_coef,
                (FiveElementData#five_elements_level.effect_num *Acc#attrs.be_phy_dam_reduce_coef ), FiveElementData#five_elements_level.effect_num]),
              Acc#attrs{be_phy_dam_reduce_coef = (Acc#attrs.be_phy_dam_reduce_coef +FiveElementData#five_elements_level.effect_num ),
                be_mag_dam_reduce_coef = (Acc#attrs.be_mag_dam_reduce_coef +FiveElementData#five_elements_level.effect_num )
              };
            heal_value ->
              ?DEBUG_MSG("heal_value old: ~p, new: ~p, rate:~p ~n",[Acc#attrs.heal_value,
                (FiveElementData#five_elements_level.effect_num *Acc#attrs.heal_value ), FiveElementData#five_elements_level.effect_num]),
              Acc#attrs{heal_value = util:ceil(Acc#attrs.heal_value +(FiveElementData#five_elements_level.effect_num *
                Acc#attrs.heal_value)) };
            be_heal_eff_coef ->
              ?DEBUG_MSG("be_heal_eff_coef old: ~p, new: ~p, rate:~p ~n",[Acc#attrs.be_heal_eff_coef,
                (FiveElementData#five_elements_level.effect_num *Acc#attrs.be_heal_eff_coef ), FiveElementData#five_elements_level.effect_num]),
              Acc#attrs{be_heal_eff_coef =  (Acc#attrs.be_heal_eff_coef +FiveElementData#five_elements_level.effect_num ) };
            mag_att_rate ->
              ?DEBUG_MSG("mag_att_rate old: ~p, new: ~p, rate:~p ~n",[Acc#attrs.mag_att,
                (FiveElementData#five_elements_level.effect_num *Acc#attrs.mag_att ), FiveElementData#five_elements_level.effect_num]),
              Acc#attrs{mag_att =   util:ceil(Acc#attrs.mag_att +(Acc#attrs.mag_att * FiveElementData#five_elements_level.effect_num) ) };
            do_mag_dam_scaling ->
              ?DEBUG_MSG("do_mag_dam_scaling old: ~p, new: ~p, rate:~p ~n",[Acc#attrs.do_mag_dam_scaling,
                (FiveElementData#five_elements_level.effect_num *Acc#attrs.do_mag_dam_scaling ), FiveElementData#five_elements_level.effect_num]),
              Acc#attrs{do_mag_dam_scaling =  (Acc#attrs.do_mag_dam_scaling +FiveElementData#five_elements_level.effect_num ) };
            phy_att_rate ->
              ?DEBUG_MSG("phy_att_rate old: ~p, new: ~p, rate:~p ~n",[Acc#attrs.phy_att,
                (FiveElementData#five_elements_level.effect_num *Acc#attrs.phy_att ), FiveElementData#five_elements_level.effect_num]),
              Acc#attrs{phy_att =  util:ceil((Acc#attrs.phy_att + (Acc#attrs.phy_att * FiveElementData#five_elements_level.effect_num) )) };
            do_phy_dam_scaling ->
              ?DEBUG_MSG("do_phy_dam_scaling old: ~p, new: ~p, rate:~p ~n",[Acc#attrs.do_phy_dam_scaling,
                (FiveElementData#five_elements_level.effect_num *Acc#attrs.do_phy_dam_scaling ), FiveElementData#five_elements_level.effect_num]),
              Acc#attrs{do_phy_dam_scaling =  (Acc#attrs.do_phy_dam_scaling +FiveElementData#five_elements_level.effect_num ) };
            _ ->
              ?DEBUG_MSG("this is no ~p~n",[FiveElementData#five_elements_level.effect]),
              Acc
          end
        end,
      lists:foldl(F,OldTotalAttrs,lists:seq(3,FiveElementLv));
    false ->
      OldTotalAttrs
  end.


%% 帮派修炼属性计算
calc_cultivate_attrs(Partner_Latest, Attrs) ->
    PS = player:get_PS(Partner_Latest#partner.player_id),
    CultivateAttrsL = player:get_cultivate_attrs(PS),

    F = fun({No, Lv,_Point}, AccAttrs) ->
        if
            Lv > 0 ->
                Data = data_guild_cultivate_learn_config:get(No),
                IncludeAttrs = Data#guild_cultivate_learn_cfg.include_attrs,

                Type = Data#guild_cultivate_learn_cfg.type,

                if
                    Type == 2 ->
                        LvData = data_guild_cultivate_config:get(Lv),
                        F1 = fun(AttrName,AccAttrs_) ->
                            case AttrName of
                                ?ATTR_DO_PHY_DAM_SCALING        -> AccAttrs_#attrs{do_phy_dam_scaling=AccAttrs_#attrs.do_phy_dam_scaling + LvData#guild_cultivate_lv_cfg.do_phy_dam_scaling};
                                ?ATTR_DO_MAG_DAM_SCALING        -> AccAttrs_#attrs{do_mag_dam_scaling = AccAttrs_#attrs.do_mag_dam_scaling + LvData#guild_cultivate_lv_cfg.do_mag_dam_scaling};
                                ?ATTR_HEAL_VALUE                -> AccAttrs_#attrs{heal_value = util:ceil(AccAttrs_#attrs.heal_value + LvData#guild_cultivate_lv_cfg.heal_value)};
                                ?ATTR_SEAL_HIT                  -> AccAttrs_#attrs{seal_hit_rate = AccAttrs_#attrs.seal_hit_rate + LvData#guild_cultivate_lv_cfg.seal_hit};
                                ?ATTR_BE_PHY_DAM_REDUCE_COEF    -> AccAttrs_#attrs{be_phy_dam_reduce_coef = AccAttrs_#attrs.be_phy_dam_reduce_coef + LvData#guild_cultivate_lv_cfg.be_phy_dam_reduce_coef};
                                ?ATTR_BE_MAG_DAM_REDUCE_COEF    -> AccAttrs_#attrs{be_mag_dam_reduce_coef = AccAttrs_#attrs.be_mag_dam_reduce_coef + LvData#guild_cultivate_lv_cfg.be_mag_dam_reduce_coef};
                                ?ATTR_SEAL_RESIS                -> AccAttrs_#attrs{seal_resis_rate = AccAttrs_#attrs.seal_resis_rate + LvData#guild_cultivate_lv_cfg.seal_resis};
                                _ -> AccAttrs_
                            end
                        end,

                        lists:foldl(F1, AccAttrs, IncludeAttrs);
                    true ->
                        AccAttrs
                end;
            true ->  AccAttrs
        end
    end,
    lists:foldl(F, Attrs, CultivateAttrsL).


calc_mount_attr(Partner_Latest, TotalAttrs) ->
    case get_mount_id(Partner_Latest) of
        ?INVALID_ID -> TotalAttrs;
        MountId ->
            case lib_mount:get_mount(MountId) of
                null -> TotalAttrs;
                Mount ->
                    BaseAttrs = lib_attribute:sum_two_attrs(TotalAttrs, lib_mount:get_mount_attribute(Mount)),
                    lib_attribute:attr_bonus(BaseAttrs, lib_mount:get_mount_skin_attr(Partner_Latest#partner.player_id))
            end
    end.

cacl_grow_value(Rate,Value) ->
  Value * Rate.


%% 已经改成：
% 宠物的每项单项数值（二级属性）== 对应紫色等级标准数值*(对应资质/2000 + 成长/1675*0.4）-->
% 对应等级标准数值* (（性格基础资质+性格附加资质）/2000+成长/1675*0.4)
%% return Partner
calc_base_attrs(Partner) ->
    DataStandard = data_par_standard:get(?QUALITY_PURPLE, get_lv(Partner)), %% 目前是用了紫色的标准数值，实际上每个品质都一样的
    PartnerBornData = data_partner:get(lib_partner:get_no(Partner)),
	RefAttr = PartnerBornData#par_born_data.ref_attr,
  %%策划起的abcd
  {A, B, C ,D} =  data_special_config:get(partner_attribute_coef),
  PartnerData = data_partner:get(Partner#partner.no),
	RefAttrData = data_ref_attr:get(RefAttr),
  {HpLim,MpLim,PhyAtt,MagAtt,PhyDef,MagDef,ActSpeed,SealResis,SealHit} = recount_talents_attrs2(Partner,Partner#partner.base_attrs),
  ?DEBUG_MSG("wjcTestParAttr ~p~n",[lib_attribute:to_talents_record(Partner#partner.base_attrs)]),
  GrowValue = cacl_grow_value(get_cur_grow(Partner),PartnerData#par_born_data.grow ),

  NewHp =      RefAttrData#ref_attr.hp_lim +  HpLim * (A + GrowValue/B ) * (C + get_base_life_aptitude(Partner)*PartnerData#par_born_data.hp_aptitude/D ) ,
  NewMag =     0  , %% 这个不要了
  NewPhyAtt =  RefAttrData#ref_attr.phy_att + PhyAtt* (A + GrowValue/B ) *    (C + get_base_phy_att_aptitude(Partner)*PartnerData#par_born_data.phy_att_aptitude/D),
  NewMagAtt =  RefAttrData#ref_attr.mag_att + MagAtt*  (A + GrowValue/B ) *    (C +get_base_mag_att_aptitude(Partner)*PartnerData#par_born_data.mag_att_aptitude/D ),
  NewPhyDef =  RefAttrData#ref_attr.phy_def + PhyDef*   (A + GrowValue/B ) *   (C + get_base_phy_def_aptitude(Partner)*PartnerData#par_born_data.phy_def_aptitude/D ),
  NewMagDef =  RefAttrData#ref_attr.mag_def + MagDef*    (A + GrowValue/B ) *  (C + get_base_mag_def_aptitude(Partner)*PartnerData#par_born_data.mag_def_aptitude/D ),
  NewSpeed =   RefAttrData#ref_attr.act_speed + ActSpeed*   (A + GrowValue/B ) *   (C + get_base_speed_aptitude(Partner)*PartnerData#par_born_data.speed_aptitude/D ),

%%  {41000,1200,
%%    0.15,
%%    783.4112,
%%    1000,0,
%%    0.5551,1051,
%%    2500,
%%    41758.871683898935}]
    NewBaseAttrs = Partner#partner.base_attrs#attrs{
        hp = util:ceil(NewHp),
        hp_lim = util:ceil(NewHp),
        mp = NewMag,
        mp_lim = NewMag,
        phy_att = util:ceil(NewPhyAtt),
        mag_att = util:ceil(NewMagAtt),
        phy_def = util:ceil(NewPhyDef),
        mag_def = util:ceil(NewMagDef),
        act_speed = util:ceil(NewSpeed),

        hit =  util:ceil(DataStandard#par_standard_dt.hit),
        crit = util:ceil(DataStandard#par_standard_dt.crit),
        % seal_hit = util:ceil(DataStandard#par_standard_dt.seal_hit),
        % seal_resis = util:ceil(DataStandard#par_standard_dt.seal_resis),
        seal_hit = util:ceil(RefAttrData#ref_attr.seal_hit +  SealHit * (A + GrowValue/B )),
        seal_resis =  util:ceil( RefAttrData#ref_attr.seal_resis+ SealResis *  (A + GrowValue/B )),
        ten  = util:ceil(DataStandard#par_standard_dt.ten),
        dodge = util:ceil(DataStandard#par_standard_dt.dodge),

        % 勿忘赋值以下字段！
		do_phy_dam_scaling = RefAttrData#ref_attr.do_phy_dam_scaling,
        do_mag_dam_scaling = RefAttrData#ref_attr.do_mag_dam_scaling,
        crit_coef = RefAttrData#ref_attr.crit_coef,
        be_heal_eff_coef = RefAttrData#ref_attr.be_heal_eff_coef,
        be_phy_dam_reduce_coef = RefAttrData#ref_attr.be_phy_dam_reduce_coef,
        be_mag_dam_reduce_coef = RefAttrData#ref_attr.be_mag_dam_reduce_coef,
        absorb_hp_coef = RefAttrData#ref_attr.absorb_hp_coef,
        qugui_coef = RefAttrData#ref_attr.qugui_coef,

        phy_crit = RefAttrData#ref_attr.phy_crit,
        phy_ten = RefAttrData#ref_attr.phy_ten,
        mag_crit = RefAttrData#ref_attr.mag_crit,
        mag_ten = RefAttrData#ref_attr.mag_ten,
        phy_crit_coef = RefAttrData#ref_attr.phy_crit_coef,
        mag_crit_coef = RefAttrData#ref_attr.mag_crit_coef
%%         do_phy_dam_scaling = ?DEFAULT_DO_DAM_SCALING,
%%         do_mag_dam_scaling = ?DEFAULT_DO_DAM_SCALING,
%%         crit_coef = ?DEFAULT_CRIT_COEF,
%%         be_heal_eff_coef = ?DEFAULT_BE_HEAL_EFF_COEF,
%%         be_phy_dam_reduce_coef = ?DEFAULT_BE_DAM_REDUCE_COEF,
%%         be_mag_dam_reduce_coef = ?DEFAULT_BE_DAM_REDUCE_COEF,
%%         absorb_hp_coef = ?DEFAULT_ABSORB_HP_COEF,
%%         qugui_coef = ?DEFAULT_QUGUI_COEF,
%%
%%         phy_crit = ?PLAYER_BORN_PHY_CRIT,
%%         phy_ten = ?PLAYER_BORN_PHY_TEN,
%%         mag_crit = ?PLAYER_BORN_MAG_CRIT,
%%         mag_ten = ?PLAYER_BORN_MAG_TEN,
%%         phy_crit_coef = ?PLAYER_BORN_PHY_CRIT_COEF,
%%         mag_crit_coef = ?PLAYER_BORN_MAG_CRIT_COEF
    },

    Partner#partner{base_attrs = NewBaseAttrs}.


%% 宠物修炼附加基础属性
cacl_cultivate_attrs(Attrs, Partner) ->
    PartnerNo = lib_partner:get_no(Partner),
    CultivateLv = lib_partner:get_cultivate_lv(Partner),
    Layer = lib_partner:get_cultivate_layer(Partner),
    case data_partner_cultivate:get(CultivateLv, Layer) of
        null -> Attrs;
        Data ->
            case Data#partner_cultivate.no =:= 0 of
                true -> Attrs;
                false ->
                    case lists:keyfind(PartnerNo, 1, Data#partner_cultivate.attrs_add) of
                        false ->
                            ?ASSERT(fasle, PartnerNo),
                            Attrs;
                        {_, RefNo} ->
                            RefAttr = data_ref_attr:get(RefNo),
                            Attrs#attrs{
                                hp = Attrs#attrs.hp + RefAttr#ref_attr.hp,
                                hp_lim = Attrs#attrs.hp_lim + RefAttr#ref_attr.hp_lim,
                                mp = Attrs#attrs.mp + RefAttr#ref_attr.mp,
                                mp_lim = Attrs#attrs.mp_lim + RefAttr#ref_attr.mp_lim,
                                phy_att = Attrs#attrs.phy_att + RefAttr#ref_attr.phy_att,
                                mag_att = Attrs#attrs.mag_att + RefAttr#ref_attr.mag_att,
                                phy_def = Attrs#attrs.phy_def + RefAttr#ref_attr.phy_def,
                                mag_def = Attrs#attrs.mag_def + RefAttr#ref_attr.mag_def,
                                act_speed = Attrs#attrs.act_speed + RefAttr#ref_attr.act_speed,

                                hit = Attrs#attrs.hit,
                                crit = Attrs#attrs.crit,
                                seal_hit = Attrs#attrs.seal_hit + RefAttr#ref_attr.seal_hit,
                                seal_resis = Attrs#attrs.seal_resis + RefAttr#ref_attr.seal_resis,
                                ten = Attrs#attrs.ten + RefAttr#ref_attr.ten,
                                dodge = Attrs#attrs.dodge,

                                % 勿忘赋值以下字段！
                                do_phy_dam_scaling = Attrs#attrs.do_phy_dam_scaling + RefAttr#ref_attr.do_phy_dam_scaling,
                                do_mag_dam_scaling = Attrs#attrs.do_mag_dam_scaling + RefAttr#ref_attr.do_mag_dam_scaling,
                                crit_coef = Attrs#attrs.crit_coef + RefAttr#ref_attr.crit_coef,
                                be_heal_eff_coef = Attrs#attrs.be_heal_eff_coef + RefAttr#ref_attr.be_heal_eff_coef,
                                be_phy_dam_reduce_coef = Attrs#attrs.be_phy_dam_reduce_coef + RefAttr#ref_attr.be_phy_dam_reduce_coef,
                                be_mag_dam_reduce_coef = Attrs#attrs.be_mag_dam_reduce_coef + RefAttr#ref_attr.be_mag_dam_reduce_coef,
                                absorb_hp_coef = Attrs#attrs.absorb_hp_coef + RefAttr#ref_attr.absorb_hp_coef,
                                qugui_coef = Attrs#attrs.qugui_coef + RefAttr#ref_attr.qugui_coef,

                                phy_crit = Attrs#attrs.phy_crit + RefAttr#ref_attr.phy_crit,
                                phy_ten = Attrs#attrs.phy_ten + RefAttr#ref_attr.phy_ten,
                                mag_crit = Attrs#attrs.mag_crit + RefAttr#ref_attr.mag_crit,
                                mag_ten = Attrs#attrs.mag_ten + RefAttr#ref_attr.mag_ten,
                                phy_crit_coef = Attrs#attrs.phy_crit_coef + RefAttr#ref_attr.phy_crit_coef,
                                mag_crit_coef = Attrs#attrs.mag_crit_coef + RefAttr#ref_attr.mag_crit_coef,
                                neglect_phy_def = Attrs#attrs.neglect_phy_def + RefAttr#ref_attr.neglect_phy_def,
                                neglect_mag_def = Attrs#attrs.neglect_mag_def + RefAttr#ref_attr.neglect_mag_def,
                                neglect_seal_resis = Attrs#attrs.neglect_seal_resis + RefAttr#ref_attr.neglect_seal_resis
                            }
                    end
            end
    end.


%% 初始总属性（调用此函数时，须事先重算好所有其他的属性，如基础属性、装备的加成属性）
init_total_attrs(Partner_Latest) ->
    PartnerId = get_id(Partner_Latest),
	PartnerNo = get_no(Partner_Latest),
	AwakeLv = get_awake_lv(Partner_Latest),
    L = ?PARTNER_ATTRS_FIELD_LIST(Partner_Latest),
    NewTotalAttrs = lib_attribute:sum_attrs(L),
    NewTotalAttrs1 = calc_passi_eff_attrs(Partner_Latest, NewTotalAttrs),
    NewTotalAttrs2 = calc_buff_eff_attrs(Partner_Latest, NewTotalAttrs1),
    NewTotalAttrs2_0 = calc_mount_attr(Partner_Latest, NewTotalAttrs2),
    NewTotalAttrs2_1 = lib_attribute:calc_rate_attrs(NewTotalAttrs2_0, NewTotalAttrs2_0),
    PlayerId = Partner_Latest#partner.player_id,
    NewTotalAttrs2_2 = calc_gem_add_attrs(PlayerId, Partner_Latest, NewTotalAttrs2_1),
    NewTotalAttrs2_3 = lib_attribute:attr_bonus(NewTotalAttrs2_2, lib_train:attr_bonus(PartnerId)), %% 门客内功属性加成
	NewTotalAttrs2_4 = lib_attribute:attr_bonus(NewTotalAttrs2_3, ply_partner:attr_bonus_by_awake_lv(PartnerNo, AwakeLv)), %% 宠物觉醒属性加成
    NewTotalAttrs3 = lib_attribute:adjust_attrs(NewTotalAttrs2_4),  % 勿忘做矫正!  宠物没有属性上限？

    set_total_attrs(Partner_Latest, NewTotalAttrs3).


calc_battle_power(Partner) ->
    Coef = data_formula:get(par_cal_battle_power),
    Attrs = get_total_attrs(Partner),

    BattlePower =
    Coef#formula.hp_lim * Attrs#attrs.hp_lim +
    Coef#formula.mp_lim * Attrs#attrs.mp_lim +
    Coef#formula.phy_att * Attrs#attrs.phy_att +
    Coef#formula.mag_att * Attrs#attrs.mag_att +
    Coef#formula.phy_def * Attrs#attrs.phy_def +
    Coef#formula.mag_def * Attrs#attrs.mag_def +
    Coef#formula.talent_str * Attrs#attrs.talent_str +
    Coef#formula.talent_con * Attrs#attrs.talent_con +
    Coef#formula.talent_sta * Attrs#attrs.talent_sta +
    Coef#formula.talent_spi * Attrs#attrs.talent_spi +
    Coef#formula.talent_agi * Attrs#attrs.talent_agi +
    Coef#formula.act_speed * Attrs#attrs.act_speed +
    Coef#formula.seal_hit * Attrs#attrs.seal_hit +
    Coef#formula.seal_resis * Attrs#attrs.seal_resis +
    Coef#formula.do_phy_dam_scaling * Attrs#attrs.do_phy_dam_scaling +
    Coef#formula.do_mag_dam_scaling * Attrs#attrs.do_mag_dam_scaling +
    Coef#formula.be_heal_eff_coef * Attrs#attrs.be_heal_eff_coef +
    Coef#formula.be_phy_dam_reduce_coef * Attrs#attrs.be_phy_dam_reduce_coef +
    Coef#formula.be_mag_dam_reduce_coef * Attrs#attrs.be_mag_dam_reduce_coef +
    Coef#formula.be_phy_dam_shrink * Attrs#attrs.be_phy_dam_shrink +
    Coef#formula.be_mag_dam_shrink * Attrs#attrs.be_mag_dam_shrink +
    Coef#formula.phy_crit * Attrs#attrs.phy_crit +
    Coef#formula.phy_ten * Attrs#attrs.phy_ten +
    Coef#formula.mag_crit * Attrs#attrs.mag_crit +
    Coef#formula.mag_ten * Attrs#attrs.mag_ten +
    Coef#formula.phy_crit_coef * Attrs#attrs.phy_crit_coef +
    Coef#formula.mag_crit_coef * Attrs#attrs.mag_crit_coef +
    Coef#formula.heal_value * Attrs#attrs.heal_value +
    Coef#formula.be_chaos_att_team_paoba * Attrs#attrs.be_chaos_att_team_paoba +
    Coef#formula.be_chaos_att_team_phy_dam * Attrs#attrs.be_chaos_att_team_phy_dam +
    Coef#formula.seal_hit_to_partner * Attrs#attrs.seal_hit_to_partner +
    Coef#formula.seal_hit_to_mon * Attrs#attrs.seal_hit_to_mon +
    Coef#formula.phy_dam_to_partner * Attrs#attrs.phy_dam_to_partner +
    Coef#formula.phy_dam_to_mon * Attrs#attrs.phy_dam_to_mon +
    Coef#formula.mag_dam_to_partner * Attrs#attrs.mag_dam_to_partner +
    Coef#formula.mag_dam_to_mon * Attrs#attrs.mag_dam_to_mon +
    Coef#formula.be_chaos_round_repair * Attrs#attrs.be_chaos_round_repair +
    Coef#formula.chaos_round_repair * Attrs#attrs.chaos_round_repair +
    Coef#formula.be_froze_round_repair * Attrs#attrs.be_froze_round_repair +
    Coef#formula.froze_round_repair * Attrs#attrs.froze_round_repair +
    Coef#formula.neglect_phy_def * Attrs#attrs.neglect_phy_def +
    Coef#formula.neglect_mag_def * Attrs#attrs.neglect_mag_def +
    Coef#formula.neglect_seal_resis * Attrs#attrs.neglect_seal_resis +
    Coef#formula.phy_dam_to_speed_1 * Attrs#attrs.phy_dam_to_speed_1 +
    Coef#formula.phy_dam_to_speed_2 * Attrs#attrs.phy_dam_to_speed_2 +
    Coef#formula.mag_dam_to_speed_1 * Attrs#attrs.mag_dam_to_speed_1 +
    Coef#formula.mag_dam_to_speed_2 * Attrs#attrs.mag_dam_to_speed_2 +
    Coef#formula.seal_hit_to_speed * Attrs#attrs.seal_hit_to_speed +
      Coef#formula.ret_dam_proba * Attrs#attrs.ret_dam_proba    +
      Coef#formula.ret_dam_coef * Attrs#attrs.ret_dam_coef +
      Coef#formula.phy_combo_att_proba * Attrs#attrs.phy_combo_att_proba +
      Coef#formula.mag_combo_att_proba * Attrs#attrs.mag_combo_att_proba +
      Coef#formula.absorb_hp_coef * Attrs#attrs.absorb_hp_coef +
      Coef#formula.strikeback_proba * Attrs#attrs.strikeback_proba +
      Coef#formula.neglect_ret_dam * Attrs#attrs.neglect_ret_dam +
      Coef#formula.pursue_att_proba * Attrs#attrs.pursue_att_proba,

    erlang:max(util:ceil(BattlePower),0).


%% 重算战斗力
recount_battle_power(Partner) ->
    BattlePower = calc_battle_power(Partner),
    Partner_Latest = set_battle_power(Partner, BattlePower),
    notify_cli_info_change(Partner_Latest, [{?OI_CODE_BATTLE_POWER, get_battle_power(Partner_Latest)}]),

    % 属性变化都会计算战力 那么在设置一下血量
    PlayerId = Partner_Latest#partner.player_id,
    PS = player:get_PS(PlayerId),
    {NewHp, NewMp} = ply_partner:adjust_hp_mp_after_battle(PS, Partner_Latest, get_hp_lim(Partner_Latest), get_mp_lim(Partner_Latest)),
    Partner_Latest2 = set_hp_mp(Partner_Latest, NewHp, NewMp),

    mod_partner:update_partner_to_ets(Partner_Latest2),
  Partner_Latest2.

%% 当关联的坐骑属性发生变化时调用（包括坐骑关联或取消关联宠物 后，注意：关联或者取消关联后需要 在 mod_partner:update_partner_to_ets 后调用)
on_attr_change(PS, PartnerId) ->
    case PartnerId =:= ?INVALID_ID of
        true -> skip;
        false ->
            case get_partner(PartnerId) of
                null -> skip;
                Partner ->
                    Partner1 = recount_total_attrs(Partner),
                    Partner2 = recount_battle_power(Partner1),
                    mod_partner:update_partner_to_ets(Partner2),

                    ply_attr:recount_all_attrs(PS)
            end
    end.


%% -------------------------------------------------Local Function--------------------------------------------------------------
%% 根据稀有度获取先天技能列表
% get_inborn_skill_by_rarity(Partner, Rarity) ->
%     [X || X <- Partner#partner.skills, (data_skill:get(X#skl_brief.id))#skl_cfg.rarity_no =:= Rarity, (data_skill:get(X#skl_brief.id))#skl_cfg.is_inborn =:= 1].


%% 根据稀有度获取后天技能列表
% get_postnatal_skill_by_rarity(Partner, Rarity) ->
%     [X || X <- Partner#partner.skills, (data_skill:get(X#skl_brief.id))#skl_cfg.rarity_no =:= Rarity, (data_skill:get(X#skl_brief.id))#skl_cfg.is_inborn =:= 0].

set_battle_power(#partner{battle_power=BattlePower}=Partner, BattlePower) ->
    Partner;
set_battle_power(#partner{}=Partner, BattlePower) ->
    Partner1 = Partner#partner{battle_power = BattlePower},

    % 因更新排行需要主人的信息，故主人在线时才尝试更新排行 -- huangjf
    ?Ifc (is_owner_online(Partner1))
        mod_rank:partner_battle_power(Partner1)
    ?End,
    Partner1.


%%根据武将获得的经验来改变武将等级
%%@return: {升级后的等级, 剩余经验}
change_lv_by_exp(PS, Lv, Exp) ->
    PlayerLv = player:get_lv(PS),
    % 判断满级
    NotIsMax = Lv  < PlayerLv,

    % ?DEBUG_MSG("IsMax=~p,Exp=~p,Lv=~p",[IsMax,Exp,Lv]),
    case NotIsMax of
        true ->
          ExpLim = get_exp_lim(Lv),
          case Exp < ExpLim  of
              true ->
                  {Lv, Exp};
              _ ->
                  change_lv_by_exp(PS, Lv + 1, Exp - ExpLim)
          end;
        false ->
            {Lv, Exp}
    end.

change_intimacy_lv_by_intimacy(Lv, Intimacy) ->
  IntimacyLim = get_intimacy_lim(Lv),
  case Intimacy < IntimacyLim of
      true ->
          {Lv, Intimacy};
      _ ->
          change_intimacy_lv_by_intimacy(Lv + 1, Intimacy - IntimacyLim)
  end.

change_layer_lv_by_cultivate_lv(No) ->
    case data_partner_cultivate:get(No) of
        null ->
            ?DEBUG_MSG("error ~~ error ~~ no : ~p~n",[No]),

            {Lv, Layer} = data_partner_cultivate:get(No - 1),
            {Lv, Layer};
        {NextLv, NextLayer} ->
            {NextLv, NextLayer}
    end.

change_cultivate_lv_by_cultivate(No, Cultivate) ->
    case data_partner_cultivate:get(No + 1) of
        null ->
            {Lv, Layer} = data_partner_cultivate:get(No),
            {Lv, Layer, Cultivate};
        {NextLv, NextLayer} ->
            CultivateLim = get_cultivate_lim(NextLv, NextLayer),
            case Cultivate < CultivateLim of
                true ->
                    {Lv, Layer} = data_partner_cultivate:get(No),
                    {Lv, Layer, Cultivate};
                _ ->
                    change_cultivate_lv_by_cultivate(No + 1, Cultivate - CultivateLim)
            end
    end.


%% return Partner 结构体
set_equip_add_attrs(Partner_Latest, EquipAddAttrs) when is_record(Partner_Latest, partner) ->
    Partner_Latest1 = Partner_Latest#partner{equip_add_attrs = EquipAddAttrs},
    mod_partner:update_partner_to_ets(Partner_Latest1),
    Partner_Latest1.



get_showing_equips(Partner) ->
    Partner#partner.showing_equips.

set_showing_equips(Partner, ShowingEquips) when is_record(ShowingEquips, showing_equip) ->
    Partner#partner{showing_equips = ShowingEquips}.


get_showing_equips_base_setting(Partner) ->
    ShowingEquips = get_showing_equips(Partner),
    PlayerId = get_owner_id(Partner),
    ShowingEquips#showing_equip{
        clothes = case ply_setting:is_par_clothes_hide(PlayerId) of true -> ?INVALID_NO; false -> ShowingEquips#showing_equip.clothes end
    }.


decide_mood_no() ->
    RandNum = util:rand(1, 100),
    List = data_partner_mood:get_all_mood_no_list(),
    decide_mood_no(List, RandNum, 0).

decide_mood_no([H | T], RandNum, SumToCompare) ->
    Cfg = data_partner_mood:get(H),
    SumToCompare_2 = Cfg#mood_cfg.weight + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true ->
            Cfg#mood_cfg.no;
        false ->
            decide_mood_no(T, RandNum, SumToCompare_2)
    end;
decide_mood_no([], _RandNum, _SumToCompare) ->
    ?ASSERT(false),
    ?INVALID_NO.


%% 通知客户端：宠物总属性中的某些属性(attr结构体里面的)改了
notify_cli_total_attrs_change(Partner, OldTotalAttrs, NewTotalAttrs) ->
    AttrList_Changed = lib_attribute:compare_attrs(OldTotalAttrs, NewTotalAttrs),
    % ?DEBUG_MSG("Partner:~p notify_cli_total_attrs_change(),  AttrList_Changed: ~p~n", [Partner#partner.id, AttrList_Changed]),
    F = fun(AttrName) ->
            AttrValue =
            case AttrName of
                ?ATTR_FROZEN_HIT -> get_frozen_hit(Partner);
                ?ATTR_FROZEN_RESIS -> get_frozen_resis(Partner);
                ?ATTR_TRANCE_HIT -> get_trance_hit(Partner);
                ?ATTR_TRANCE_RESIS -> get_trance_resis(Partner);
                ?ATTR_CHAOS_HIT -> get_chaos_hit(Partner);
                ?ATTR_CHAOS_RESIS -> get_chaos_resis(Partner);
                _ ->
                    Index = lib_attribute:get_field_index_in_attrs(AttrName),
                    element(Index, NewTotalAttrs)
            end,
            {AttrName, AttrValue}
        end,
    KV_TupleList = [F(X) || X <- AttrList_Changed],
    notify_cli_total_attrs_change(Partner, KV_TupleList).


%% 通知客户端：更新玩家宠物的一个或多个属性(attr结构体里面的)
%% @para: KV_TupleList => 格式如：[{属性名，新的值}, ...]
notify_cli_total_attrs_change(Partner, KV_TupleList) ->
    ?TRACE("notify_cli_total_attrs_change(),  PlayerId=~p, PartnerId=~p, KV_TupleList=~p~n", [Partner#partner.player_id, Partner#partner.id, KV_TupleList]),
    ?ASSERT(util:is_tuple_list(KV_TupleList)),
    KV_TupleList2 = [{lib_attribute:attr_name_to_obj_info_code(AttrName), NewValue} || {AttrName, NewValue} <- KV_TupleList],
    notify_cli_info_change(Partner, KV_TupleList2).


%% 通知客户端：更新玩家的一个或多个信息 (attr结构体外面的)
%% @para: KV_TupleList => 格式如：[{信息代号，新的值}, ...]
notify_cli_info_change(Partner, KV_TupleList) when is_record(Partner, partner) ->
    ?ASSERT(util:is_tuple_list(KV_TupleList)),
    case player:get_PS(Partner#partner.player_id) of
        null -> skip;
        PS ->
            {ok, BinData} = pt_17:write(?PT_NOTIFY_PARTNER_INFO_CHANGE, [lib_partner:get_id(Partner), KV_TupleList]),
            lib_send:send_to_sock(PS, BinData)
    end;

%% 通知客户端：女妖大部分属性已改变
notify_cli_info_change(PS, Partner) ->
    {ok, BinData} = pt_17:write(?PT_GET_PARTNER_ATTR_INFO, [Partner]),
    lib_send:send_to_sock(PS, BinData).


%% 获取主动技能参数，计算战力用
% 主动技能参数  [(宠物主动技能个数-1)×0.3+1]×有无主动技能×宠物等级对应标准血量
% 有无主动技能= 0或1
get_initiative_skill_para(Partner) ->
    Len = length(get_initiative_skill_list(Partner)),
    case Len =:= 0 of
        true -> 0;
        false ->
            case data_par_standard:get(get_quality(Partner), get_lv(Partner)) of
                null -> 0;
                ParStdCfg ->
                    util:ceil((Len - 1) * 0.3 * 1 * ParStdCfg#par_standard_dt.hp)
            end
    end.


% ∏ (被动技能效果配置表系数×女妖等级所对应的心法标准血量)
get_passive_skill_para(Partner) ->
    SkillList = get_passive_skill_list(Partner),
    Lv = get_lv(Partner),
    F = fun(SklBrief, Sum) ->
            SkillId = SklBrief#skl_brief.id,
            case mod_skill:get_cfg_data(SkillId) of
                null -> Sum;
                SklCfg ->
                    F1 = fun(No, Acc) ->
                        case data_passi_eff:get(No) of
                            null -> Acc;
                            EffCfg -> EffCfg#passi_eff.battle_power_coef * (data_xinfa_std_value:get(Lv))#xinfa_std_val.hp + Acc
                        end
                    end,
                    lists:foldl(F1, 0, mod_skill:get_passive_effs(SklCfg)) + Sum
            end
        end,
    util:ceil(lists:foldl(F, 0, SkillList)).


decide_new_quality_evolve_lv(Partner, AddEvolveLv) ->
    Quality = lib_partner:get_quality(Partner),
    EvolveLv = lib_partner:get_evolve_lv(Partner),
    DataEvolve = data_partner_evolve:get(Quality, EvolveLv),
    NoList = data_partner_evolve:get_all_evolve_no_list(),
    case NoList =:= [] of
        true -> {Quality, EvolveLv};
        false ->
            CurNo = DataEvolve#partner_evolve.no,
            LastNo = lists:last(NoList),
            No = decide_evole_no(CurNo, LastNo, AddEvolveLv),
            data_partner_evolve:get(No)
    end.

%% 跟随宠物的信息发生变化
notify_main_partner_info_change_to_AOI(PS, Partner) ->
    {PartnerNo, ParWeapon, EvolveLv, ParName, CultivateLv, CultivateLayer, ParQuality, ParClothes, ParAwakeIllusion} =
        case lib_partner:is_follow_partner(Partner) of
            false -> {?INVALID_NO, ?INVALID_NO, 0, <<>>, 0, 0, ?QUALITY_INVALID, ?INVALID_NO, ?INVALID_NO};
            true ->
                ?TRACE("lib_partner:notify_main_partner_info_change_to_AOI():PlayerId:~p~n", [player:get_id(PS)]),
                case Partner =:= null of
                    true -> {?INVALID_NO, ?INVALID_NO, 0, <<>>, 0, 0, ?QUALITY_INVALID, ?INVALID_NO, ?INVALID_NO};
                    false ->
                        ParShowEquips = lib_partner:get_showing_equips(Partner),
                        TParClothes =
                            case ply_setting:is_par_clothes_hide(player:id(PS)) of
                                true -> ?INVALID_NO;
                                false -> ParShowEquips#showing_equip.clothes
                            end,
                        {
                        lib_partner:get_no(Partner),
                        ParShowEquips#showing_equip.weapon,
                        lib_partner:get_evolve_lv(Partner),
                        lib_partner:get_name(Partner),
                        lib_partner:get_cultivate_lv(Partner),
                        lib_partner:get_cultivate_layer(Partner),
                        lib_partner:get_quality(Partner),
                        TParClothes,
						get_awake_illusion(Partner)
                        }
                end
        end,

    {ok, BinData} = pt_12:write(?PT_NOTIFY_MAIN_PAR_CHANGE, [player:get_id(PS), PartnerNo, ParWeapon, EvolveLv, CultivateLv, CultivateLayer, ParQuality, ParName, ParClothes, ParAwakeIllusion]),
    lib_send:send_to_AOI(player:get_id(PS), BinData).


decide_evole_no(CurNo, LastNo, AddEvolveLv) ->
    case CurNo >= LastNo of
        true -> CurNo;
        false ->
            case data_partner_evolve:get(CurNo + AddEvolveLv) of
                null ->
                    decide_evole_no(CurNo, LastNo, AddEvolveLv - 1);
                {_Quality, _EvolveLv} ->
                    CurNo + AddEvolveLv
            end
    end.


%% 获取能力等级
get_ref_lv(Partner) ->
    case data_partner:get(get_no(Partner)) of
        null -> 0;
        DataCfg -> DataCfg#par_born_data.ref_lv
    end.

%跨服聊天获取门客详细信息
get_partner_info_from_crossing(PartnerId,ServerId,PlayerId) ->
	case lib_partner:get_partner(PartnerId) of
		null -> sm_cross_server:rpc_cast(ServerId,lib_send, send_prompt_msg, [PlayerId,?PM_PAR_NOT_EXISTS]);
		Partner ->
			{ok, BinData} = pt_17:write(17028, [Partner]),
			sm_cross_server:rpc_cast(ServerId,lib_chat, cross_chat_data, [PlayerId, BinData,PartnerId,2])
	end.


get_evolve_coef(RefLv) ->
    List = data_ability_lv_cfg:get_all_lv_step_list(),
    get_evolve_coef__(List, RefLv).


get_evolve_coef__([], _RefLv) ->
    ?ASSERT(false, _RefLv),
    1;
get_evolve_coef__([H | T], RefLv) ->
    case data_ability_lv_cfg:get(H) of
        null ->
            get_evolve_coef__(T, RefLv);
        Data ->
            RangeList = Data#ability_lv_cfg.range,
            ?ASSERT(length(RangeList) =:= 2, RangeList),
            case length(RangeList) =:= 2 of
                false ->
                    ?ASSERT(false, RangeList),
                    get_evolve_coef__(T, RefLv);
                true ->
                    case util:in_range(RefLv, lists:nth(1, RangeList), lists:nth(2, RangeList)) of
                        true -> Data#ability_lv_cfg.evolve_coef;
                        false -> get_evolve_coef__(T, RefLv)
                    end
            end
    end.

get_ref_lv_step(Partner) ->
    RefLv = get_ref_lv(Partner),
    List = data_ability_lv_cfg:get_all_lv_step_list(),
    get_ref_lv_step__(List, RefLv).

get_ref_lv_step__([], _RefLv) ->
    ?ASSERT(false, _RefLv),1;

get_ref_lv_step__([H | T], RefLv) ->
    case data_ability_lv_cfg:get(H) of
        null ->
            get_ref_lv_step__(T, RefLv);
        Data ->
            RangeList = Data#ability_lv_cfg.range,
            ?ASSERT(length(RangeList) =:= 2),
            case length(RangeList) =:= 2 of
                false ->
                    ?ASSERT(false, RangeList),
                    get_ref_lv_step__(T, RefLv);
                true ->
                    case util:in_range(RefLv, lists:nth(1, RangeList), lists:nth(2, RangeList)) of
                        true -> H;
                        false -> get_ref_lv_step__(T, RefLv)
                    end
            end
    end.