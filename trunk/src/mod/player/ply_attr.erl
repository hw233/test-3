%%%--------------------------------------
%%% @Module  : ply_attr
%%% @Author  : huangjf
%%% @Email   :
%%% @Created : 2013.10.16
%%% @Description: 玩家属性相关的一些接口
%%%--------------------------------------
-module(ply_attr).
-export([
		notify_my_info_details_to_client/1,
		allot_free_talent_points/2,

		get_born_talents/1,

		get_total_attrs/1,

		calc_born_base_attrs/2, calc_base_attrs/2,
		calc_equip_add_attrs/1,

		recount_base_and_total_attrs/1, recount_base_and_total_attrs/2,
		recount_equip_add_and_total_attrs/1, recount_equip_add_and_total_attrs/2,
		recount_xinfa_add_and_total_attrs/1, recount_xinfa_add_and_total_attrs/2,
		recount_all_attrs/1, recount_all_attrs/2,


		build_xinfa_add_attrs_KV_list/2,

		get_battle_power/1,
		calc_battle_power/2,
		recount_battle_power/1,
recount_battle_power/2,

		tst_add_attrs/2 %% 仅供gm命令测试用,在线生效,下线重新上线失效
    ]).


-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("attribute.hrl").
-include("record/goods_record.hrl").
-include("xinfa.hrl").
-include("pt_13.hrl").
-include("obj_info_code.hrl").
-include("bo.hrl").
-include("offline_data.hrl").
-include("transfiguration.hrl").
-include("jingmai.hrl").
-include("ref_attr.hrl").
-include("faction.hrl").
-include("skill.hrl").
-include("effect.hrl").

notify_my_info_details_to_client(PS) ->
	{ok, BinData} = pt_13:write(?PT_PLYR_GET_INFO_DETAILS, PS),
    lib_send:send_to_sock(PS, BinData).




%% 分配自由天赋点
allot_free_talent_points(PS, AllotInfoList) ->
	F = fun(AllotInfo, Sum) ->
			{_TalentCode, Points} = AllotInfo,
			Sum + Points
		end,
	TotalPointsToAllot = lists:foldl(F, 0, AllotInfoList),
	?ASSERT(TotalPointsToAllot > 0),
	% 先扣点数
	player:add_free_talent_points(PS, - TotalPointsToAllot),
	allot_free_talent_points__(PS, AllotInfoList, TotalPointsToAllot).


allot_free_talent_points__(PS, [{TalentCode, Points} | T], TotalPointsToAllot) ->
	case Points of
		0 ->
			skip;
		_ ->
			case TalentCode of
				?TALENT_CODE_STR ->
					player:add_base_str(PS, Points);
				?TALENT_CODE_CON ->
					player:add_base_con(PS, Points);
				?TALENT_CODE_STA ->
					player:add_base_stam(PS, Points);
				?TALENT_CODE_SPI ->
					player:add_base_spi(PS, Points);
				?TALENT_CODE_AGI ->
					player:add_base_agi(PS, Points)
			end
	end,
	allot_free_talent_points__(PS, T, TotalPointsToAllot);
allot_free_talent_points__(_PS, [], _TotalPointsToAllot) ->
	skip. %% 已经优化为在添加的函数里面完成下面的操作，防止单独添加其中一种天赋时，漏了存盘等
	% % 通知客户端更新
	% player:notify_cli_talents_change(PS),
	% % 重算属性
	% recount_base_and_total_attrs(PS),
	% % 天赋信息更新到DB
	% player:db_save_talents(PS).



%% 获取玩家的出生天赋属性 将初始属性调整为0
get_born_talents(Race) ->
    case Race of
        ?RACE_REN ->
            #talents{str = 1, con = 1, sta = 1, spi = 1, agi = 1};
        ?RACE_MO ->
            #talents{str = 1, con = 1, sta = 1, spi = 1, agi = 1};
        ?RACE_XIAN ->
            #talents{str = 1, con = 1, sta = 1, spi = 1, agi = 1};
        ?RACE_YAO ->
			#talents{str = 1, con = 1, sta = 1, spi = 1, agi = 1}
%%             ?ASSERT(false) % TODO: 待定
    end.


%% 计算出生时的基础属性
calc_born_base_attrs(Race, BornTalents) ->
	calc_base_attrs(Race, BornTalents).


%% 计算玩家的基础属性（按策划给的公式计算）
%% @para: Race => 种族， TotalTalents => 当前的总天赋属性
%% @return: attrs结构体
calc_base_attrs(Race, TotalTalents) ->
	?ASSERT(lib_comm:is_valid_race(Race), Race),

	Con = TotalTalents#talents.con,
	Str = TotalTalents#talents.str,
	Agi = TotalTalents#talents.agi,
	Spi = TotalTalents#talents.spi,
	Sta = TotalTalents#talents.sta,
	
	ConCfg = data_attr_growth_coef:get(1),
	StrCfg = data_attr_growth_coef:get(2),
	AgiCfg = data_attr_growth_coef:get(3),
	SpiCfg = data_attr_growth_coef:get(4),
	StaCfg = data_attr_growth_coef:get(5),

	% 现在的计算与种族无关
	HpLim     =  max(
	                util:floor(Con*ConCfg#attr_growth_coef.hp         + Str*StrCfg#attr_growth_coef.hp         + Agi*AgiCfg#attr_growth_coef.hp         + Spi*SpiCfg#attr_growth_coef.hp         + Sta*StaCfg#attr_growth_coef.hp), 
	                1
	                ),  % 血量上限至少为1

	MpLim     =	    util:floor(Con*ConCfg#attr_growth_coef.mp         + Str*StrCfg#attr_growth_coef.mp         + Agi*AgiCfg#attr_growth_coef.mp         + Spi*SpiCfg#attr_growth_coef.mp         + Sta*StaCfg#attr_growth_coef.mp),
	PhyAtt    =     util:floor(Con*ConCfg#attr_growth_coef.phy_att    + Str*StrCfg#attr_growth_coef.phy_att    + Agi*AgiCfg#attr_growth_coef.phy_att    + Spi*SpiCfg#attr_growth_coef.phy_att    + Sta*StaCfg#attr_growth_coef.phy_att),
	MagAtt    =     util:floor(Con*ConCfg#attr_growth_coef.mag_att    + Str*StrCfg#attr_growth_coef.mag_att    + Agi*AgiCfg#attr_growth_coef.mag_att    + Spi*SpiCfg#attr_growth_coef.mag_att    + Sta*StaCfg#attr_growth_coef.mag_att),
	PhyDef    =     util:floor(Con*ConCfg#attr_growth_coef.phy_def    + Str*StrCfg#attr_growth_coef.phy_def    + Agi*AgiCfg#attr_growth_coef.phy_def    + Spi*SpiCfg#attr_growth_coef.phy_def    + Sta*StaCfg#attr_growth_coef.phy_def),
	MagDef    =     util:floor(Con*ConCfg#attr_growth_coef.mag_def    + Str*StrCfg#attr_growth_coef.mag_def    + Agi*AgiCfg#attr_growth_coef.mag_def    + Spi*SpiCfg#attr_growth_coef.mag_def    + Sta*StaCfg#attr_growth_coef.mag_def),
	ActSpeed  =     util:floor(Con*ConCfg#attr_growth_coef.act_speed  + Str*StrCfg#attr_growth_coef.act_speed  + Agi*AgiCfg#attr_growth_coef.act_speed  + Spi*SpiCfg#attr_growth_coef.act_speed  + Sta*StaCfg#attr_growth_coef.act_speed),
	Hit 	  =     util:floor(Con*ConCfg#attr_growth_coef.hit        + Str*StrCfg#attr_growth_coef.hit        + Agi*AgiCfg#attr_growth_coef.hit        + Spi*SpiCfg#attr_growth_coef.hit        + Sta*StaCfg#attr_growth_coef.hit),
	Dodge 	  =     util:floor(Con*ConCfg#attr_growth_coef.dodge      + Str*StrCfg#attr_growth_coef.dodge      + Agi*AgiCfg#attr_growth_coef.dodge      + Spi*SpiCfg#attr_growth_coef.dodge      + Sta*StaCfg#attr_growth_coef.dodge),
	SealResis =     util:floor(Con*ConCfg#attr_growth_coef.seal_resis + Str*StrCfg#attr_growth_coef.seal_resis + Agi*AgiCfg#attr_growth_coef.seal_resis + Spi*SpiCfg#attr_growth_coef.seal_resis + Sta*StaCfg#attr_growth_coef.seal_resis),
	SealHit =     util:floor(Con*ConCfg#attr_growth_coef.seal_hit + Str*StrCfg#attr_growth_coef.seal_hit + Agi*AgiCfg#attr_growth_coef.seal_hit + Spi*SpiCfg#attr_growth_coef.seal_hit + Sta*StaCfg#attr_growth_coef.seal_hit),
	HealValue = 	util:floor(Con*ConCfg#attr_growth_coef.heal_value + Str*StrCfg#attr_growth_coef.heal_value + Agi*AgiCfg#attr_growth_coef.heal_value + Spi*SpiCfg#attr_growth_coef.heal_value + Sta*StaCfg#attr_growth_coef.heal_value),
	#faction_base{init_attr = RefId} = data_faction:get(Race),
	#ref_attr{hp_lim = HpLimBorn,
			  mp_lim = MpLimBorn,
			  phy_att = PhyAttBorn,
			  mag_att = MagAttBorn,
			  phy_def = PhyDefBorn,
			  mag_def = MagDefBorn,
			  act_speed = ActSpeedBorn,
			  seal_hit = SealHitBorn,
			  seal_resis = SealResisBorn,
			  heal_value = HealValueBorn,
			  do_phy_dam_scaling = DoPhyDamScalingBorn,
			  do_mag_dam_scaling = DoMagDamScalingBorn,
			  be_phy_dam_reduce_coef = BePhyDamReduceCoefBorn,
			  be_mag_dam_reduce_coef = BeMagDamReduceCoefBorn,
			  be_heal_eff_coef = BeHealEffCoefBorn,
			  crit = CritBorn,
			  ten = TenBorn,
			  crit_coef = CritCoefBorn,
			  phy_crit = PhyCritBorn,
			  phy_ten = PhyTenBorn,
			  mag_crit = MagCritBorn,
			  mag_ten = MagTenBorn,
			  phy_crit_coef = PhyCritCoefBorn,
			  mag_crit_coef = MagCritCoefBorn,
			  neglect_phy_def = NeglectPhyDefBorn,
			  neglect_mag_def = NeglectMagDefBorn,
			  neglect_seal_resis = NeglectSealResisBorn,
			  absorb_hp_coef = AbsorbHpCoefBorn,
			  qugui_coef = QuguiCoefBorn
			  } = data_ref_attr:get(RefId),
	#attrs{
		hp_lim = HpLimBorn + HpLim,
		mp_lim = MpLimBorn + MpLim,
		phy_att = PhyAttBorn + PhyAtt,
		mag_att = MagAttBorn + MagAtt,
		phy_def = PhyDefBorn + PhyDef,
		mag_def = MagDefBorn + MagDef,
		act_speed = ActSpeedBorn + ActSpeed,
		hit = Hit,
		dodge = Dodge,
		seal_resis = SealResisBorn + SealResis,
		seal_hit = SealHitBorn + SealHit,
		crit = CritBorn,
		ten = TenBorn,
		% 勿忘赋值以下字段！
		do_phy_dam_scaling = DoPhyDamScalingBorn,
		do_mag_dam_scaling = DoMagDamScalingBorn,
		crit_coef = CritCoefBorn,
		be_heal_eff_coef = BeHealEffCoefBorn,
		be_phy_dam_reduce_coef = BePhyDamReduceCoefBorn,
		be_mag_dam_reduce_coef = BeMagDamReduceCoefBorn,
		absorb_hp_coef = AbsorbHpCoefBorn,
		qugui_coef = QuguiCoefBorn,

		phy_crit = PhyCritBorn,
		phy_ten = PhyTenBorn,
		mag_crit = MagCritBorn,
		mag_ten = MagTenBorn,
		phy_crit_coef = PhyCritCoefBorn,
		mag_crit_coef = MagCritCoefBorn,
		heal_value = HealValue
%% 		hp_lim = ?PLAYER_BORN_HP_LIMIT + HpLim,
%% 		mp_lim = ?PLAYER_BORN_MP_LIMIT + MpLim,
%% 		phy_att = ?PLAYER_BORN_PHY_ATT + PhyAtt,
%% 		mag_att = ?PLAYER_BORN_MAG_ATT + MagAtt,
%% 		phy_def = ?PLAYER_BORN_PHY_DEF + PhyDef,
%% 		mag_def = ?PLAYER_BORN_MAG_DEF + MagDef,
%% 		act_speed = ?PLAYER_BORN_SPEED + ActSpeed,
%% 		hit = Hit,
%% 		dodge = Dodge,
%% 		seal_resis = ?PLAYER_BORN_SEAL_RESIS + SealResis,
%% 		seal_hit = ?PLAYER_BORN_SEAL_HIT + SealHit,
%% 		crit = ?PLAYER_BORN_CRIT,
%% 		ten = ?PLAYER_BORN_TEN,
%% 		% 勿忘赋值以下字段！
%% 		do_phy_dam_scaling = ?DEFAULT_DO_DAM_SCALING,
%% 		do_mag_dam_scaling = ?DEFAULT_DO_DAM_SCALING,
%% 		crit_coef = ?DEFAULT_CRIT_COEF,
%% 		be_heal_eff_coef = ?DEFAULT_BE_HEAL_EFF_COEF,
%% 		be_phy_dam_reduce_coef = ?DEFAULT_BE_DAM_REDUCE_COEF,
%% 		be_mag_dam_reduce_coef = ?DEFAULT_BE_DAM_REDUCE_COEF,
%% 		absorb_hp_coef = ?DEFAULT_ABSORB_HP_COEF,
%% 		qugui_coef = ?DEFAULT_QUGUI_COEF,
%% 
%% 		phy_crit = ?PLAYER_BORN_PHY_CRIT,
%% 		phy_ten = ?PLAYER_BORN_PHY_TEN,
%% 		mag_crit = ?PLAYER_BORN_MAG_CRIT,
%% 		mag_ten = ?PLAYER_BORN_MAG_TEN,
%% 		phy_crit_coef = ?PLAYER_BORN_PHY_CRIT_COEF,
%% 		mag_crit_coef = ?PLAYER_BORN_MAG_CRIT_COEF,
%% 		heal_value = HealValue
		}.



%% 计算玩家的基础属性（内部函数，不导出作为接口）
%% @para: PS_Latest => 当前最新的玩家结构体
%% @return: attrs结构体
calc_base_attrs__(PS_Latest) ->
	?ASSERT(is_record(PS_Latest, player_status)),
	Race = player:get_race(PS_Latest),
	TotalTalents = player:get_total_talents(PS_Latest),
	NewAttrs = calc_base_attrs(Race, TotalTalents),

	OldBaseAttrs = get_base_attrs(PS_Latest),
	% 为避免丢失原有的当前hp、当前mp以及基础天赋属性信息，故只更新必要的字段!
	OldBaseAttrs#attrs{
			hp_lim = NewAttrs#attrs.hp_lim,
			mp_lim = NewAttrs#attrs.mp_lim,
			phy_att = NewAttrs#attrs.phy_att,
			mag_att = NewAttrs#attrs.mag_att,
			phy_def = NewAttrs#attrs.phy_def,
			mag_def = NewAttrs#attrs.mag_def,
			act_speed = NewAttrs#attrs.act_speed,
			hit = NewAttrs#attrs.hit,
			dodge = NewAttrs#attrs.dodge,
			seal_resis = NewAttrs#attrs.seal_resis,
			seal_hit = NewAttrs#attrs.seal_hit,
			crit = NewAttrs#attrs.crit,
			ten = NewAttrs#attrs.ten,
			do_phy_dam_scaling = NewAttrs#attrs.do_phy_dam_scaling,
			do_mag_dam_scaling = NewAttrs#attrs.do_mag_dam_scaling,
			crit_coef = NewAttrs#attrs.crit_coef,
			be_heal_eff_coef = NewAttrs#attrs.be_heal_eff_coef,
			be_phy_dam_reduce_coef = NewAttrs#attrs.be_phy_dam_reduce_coef,
			be_mag_dam_reduce_coef = NewAttrs#attrs.be_mag_dam_reduce_coef,
			absorb_hp_coef = NewAttrs#attrs.absorb_hp_coef,
			qugui_coef = NewAttrs#attrs.qugui_coef,
			phy_crit = NewAttrs#attrs.phy_crit,
			phy_ten = NewAttrs#attrs.phy_ten,
			mag_crit = NewAttrs#attrs.mag_crit,
			mag_ten = NewAttrs#attrs.mag_ten,
			phy_crit_coef = NewAttrs#attrs.phy_crit_coef,
			mag_crit_coef = NewAttrs#attrs.mag_crit_coef,
			heal_value = NewAttrs#attrs.heal_value

			}.

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
%% @return: attrs结构体
calc_equip_add_attrs(PlayerId) ->
	% 遍历装备栏的装备，对各个装备的加成属性求和，并返回
	TEqpList = mod_equip:get_player_equip_list(PlayerId),
	% 计算战力时，把位置错误的装备过滤掉 以及 剩余时间过期的装备
	EqpList = [Goods || Goods <- TEqpList, is_work(Goods)],

	AttrsList1 = [Goods#goods.base_equip_add || Goods <- EqpList, Goods#goods.base_equip_add /= null],
	AttrsList2 = [Goods#goods.addi_equip_add || Goods <- EqpList, Goods#goods.addi_equip_add /= null],
	AttrsList3 = [Goods#goods.stren_equip_add || Goods <- EqpList, Goods#goods.stren_equip_add /= null],

%%	F = fun(Goods, Acc) ->
%%		AddiEquipEffNo = Goods#goods.addi_equip_eff,
%%		Ret = case AddiEquipEffNo of
%%            0 -> #attrs{};
%%            null -> #attrs{};
%%            _ -> lib_attribute:to_addi_equip_eff(AddiEquipEffNo)
%%        end,
%%
%%        [ Ret| Acc]
%%    end,
%%    AttrsList4 = lists:foldl(F, [], EqpList),

    % 2018/8/27编写，增加装备幻化，产生新的特效，但是只能允许一条同类型特效
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

    ?DEBUG_MSG("---------------------------Player AttrsList4----------------------------- = ~p~n",[AttrsList4]),

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
	AttrsList = AttrsList1 ++ AttrsList2 ++ AttrsList3 ++ AttrsList4 ++ AttrsList5 ++ mod_strengthen:recount_all_equip_attrs(PlayerId),
	lib_attribute:sum_attrs(AttrsList).



%% 重算基础属性和总属性（异步），下几个类似的接口同理
recount_base_and_total_attrs(PS) ->
	gen_server:cast( player:get_pid(PS), 'recount_base_and_total_attrs').

%% 重算基础属性和总属性（同步），注意：传入的玩家PS须是最新的！ 下几个类似的接口同理
recount_base_and_total_attrs(imme, PS_Latest) -> % imme: immediately
	recount_base_and_total_attrs__(PS_Latest).



%% 重算装备的加成属性和总属性
recount_equip_add_and_total_attrs(PS) ->
	gen_server:cast( player:get_pid(PS), 'recount_equip_add_and_total_attrs').

recount_equip_add_and_total_attrs(imme, PS_Latest) -> % imme: immediately
	recount_equip_add_and_total_attrs__(PS_Latest).


%% 重算心法的加成属性和总属性
recount_xinfa_add_and_total_attrs(PS) ->
	gen_server:cast( player:get_pid(PS), 'recount_xinfa_add_and_total_attrs').

recount_xinfa_add_and_total_attrs(imme, PS_Latest) -> % imme: immediately
	recount_xinfa_add_and_total_attrs__(PS_Latest).


%% 重算所有属性（包括基础属性、装备的加成属性... 以及总属性）
recount_all_attrs(PS) ->
	gen_server:cast( player:get_pid(PS), 'recount_all_attrs').

recount_all_attrs(imme, PS_Latest) -> % imme: immediately
	recount_all_attrs__(PS_Latest).




%% 重算基础属性，然后重算总属性
recount_base_and_total_attrs__(PS_Latest) ->
	PS_Latest2 = recount_base_attrs(PS_Latest),
	PS_Latest_TotalNew = recount_total_attrs(PS_Latest2),
	recount_battle_power(PS_Latest_TotalNew).


%% 重算装备的加成属性，然后重算总属性
recount_equip_add_and_total_attrs__(PS_Latest) ->
	PS_Latest2 = recount_equip_add_attrs(PS_Latest),
	PS_Latest_TotalNew = recount_total_attrs(PS_Latest2),
	recount_battle_power(PS_Latest_TotalNew).


%% 重算心法的加成属性，然后重算总属性
recount_xinfa_add_and_total_attrs__(PS_Latest) ->
	PS_Latest2 = recount_xinfa_add_attrs(PS_Latest),
	PS_Latest_TotalNew = recount_total_attrs(PS_Latest2),
	recount_battle_power(PS_Latest_TotalNew).



%% 重算基础属性，然后重算装备、心法的加成属性等... 最后重算总属性
recount_all_attrs__(PS_Latest) ->
	PS_Latest2 = recount_base_attrs(PS_Latest),
	PS_Latest3 = recount_equip_add_attrs(PS_Latest2),
	PS_Latest4 = recount_xinfa_add_attrs(PS_Latest3),

	% todo: 重算其他（如果有需要的话）
	% ...

	PS_Latest_TotalNew = recount_total_attrs(PS_Latest4),
	recount_battle_power(PS_Latest_TotalNew).


%% 总属性的组成列表： [基础属性，装备的加成属性，心法的加成属性]
-define(PS_ATTRS_FIELD_LIST(PS), [get_base_attrs(PS), get_equip_add_attrs(PS), get_xinfa_add_attrs(PS), lib_fabao:cal_diagrams_attrs(player:get_id(PS))]).

%% 重算总天赋
recount_total_talents(PS_Latest) ->
	L = ?PS_ATTRS_FIELD_LIST(PS_Latest),
	NewTotalTalents = lib_attribute:sum_talents_from_attrs_list(L),

	% 返回临时最新的玩家结构体， 是为了方便后续进一步做其他属性的重算!
	NewTotalAttrs_Tmp = PS_Latest#player_status.total_attrs#attrs{
								talent_str = NewTotalTalents#talents.str,
								talent_con = NewTotalTalents#talents.con,
								talent_sta = NewTotalTalents#talents.sta,
								talent_spi = NewTotalTalents#talents.spi,
								talent_agi = NewTotalTalents#talents.agi
								},
	PS_Latest#player_status{
		total_attrs = NewTotalAttrs_Tmp
		}.


%% 重算基础属性
recount_base_attrs(PS_Latest) ->
	PS_Latest_Tmp = recount_total_talents(PS_Latest), % 先重算总天赋，因为天赋直接影响基础属性的计算
	NewBaseAttrs = calc_base_attrs__(PS_Latest_Tmp),
	PS_Latest2 = player_syn:set_base_attrs(PS_Latest, NewBaseAttrs),

	% 返回最新的玩家结构体， 是为了方便后续进一步做其他属性的重算!
	PS_Latest2.

%% 重算装备的加成属性
recount_equip_add_attrs(PS_Latest) ->
	NewEquipAddAttrs = calc_equip_add_attrs(PS_Latest#player_status.id),
	PS_Latest2 = player_syn:set_equip_add_attrs(PS_Latest, NewEquipAddAttrs),

	% 因为装备的加成属性可能会影响天赋，故重算基础属性
	PS_Latest3 = recount_base_attrs(PS_Latest2),

	% 返回最新的玩家结构体， 是为了方便后续进一步做其他属性的重算!
	PS_Latest3.


%% 重算心法的加成属性
recount_xinfa_add_attrs(PS_Latest) ->
	PlayerId = player:id(PS_Latest),
	NewXinfaAttrs = calc_xinfa_add_attrs(PlayerId),
	?ASSERT(is_record(NewXinfaAttrs, attrs)),
	?TRACE("recount_xinfa_add_attrs(), NewXinfaAttrs=~p~n", [NewXinfaAttrs]),
	PS_Latest2 = player_syn:set_xinfa_add_attrs(PS_Latest, NewXinfaAttrs),

	% 因为心法的加成属性可能会影响天赋，故重算基础属性
	PS_Latest3 = recount_base_attrs(PS_Latest2),

	% 返回最新的玩家结构体， 是为了方便后续进一步做其他属性的重算!
	PS_Latest3.


% 递归计算属性
recursion_class_and_point(_Class,0,Acc) ->
	Acc;

recursion_class_and_point(Class,Point,Acc) ->
	case data_jingmai:get(Class,Point) of
		JingmaiConfig when is_record(JingmaiConfig,jinmai_config) ->
			recursion_class_and_point(Class,Point - 1,JingmaiConfig#jinmai_config.add_attr ++ Acc);
		null -> Acc
	end.

%% [{1,4},{2,5},{3,5},{4,4},{5,4},{6,4},{7,4}]
% 计算经脉属性
get_my_jingmai_attrs(PS_Latest) ->
	% 如果没有经脉这初始化
	MyInfos = 
	case player:get_jingmai_infos(PS_Latest) of
		[] -> [{1,0},{2,0},{3,0},{4,0},{5,0},{6,0},{7,0}];
		Infos -> Infos
	end,

	%　10043

	% 计算
	F = fun({Class,Point},Acc) ->
		recursion_class_and_point(Class,Point,[]) ++ Acc
	end,

	MyAttrs = lists:foldl(F, [], MyInfos),

	?DEBUG_MSG("MyAttrs=~p",[MyAttrs]),
	MyAttrs.

% 计算坐骑
calc_mount_attr(PS_Latest, TotalAttrs) ->
    case player:get_mount(PS_Latest) of
    	null -> TotalAttrs;
        ?INVALID_ID -> TotalAttrs;
        MountId ->
            case lib_mount:get_mount(MountId) of
                null -> TotalAttrs;
                Mount ->
					BaseAttrs = lib_attribute:sum_two_attrs(TotalAttrs, lib_mount:get_mount_attribute(Mount)),
					lib_attribute:attr_bonus(BaseAttrs, lib_mount:get_mount_skin_attr(PS_Latest#player_status.id))
            end
    end.


%% 重算总属性（调用此函数时，须事先重算好所有其他的属性，如基础属性，装备、心法的加成属性等）
recount_total_attrs(PS_Latest) ->
	OldTotalAttrs = get_total_attrs(PS_Latest),
	OldHp = OldTotalAttrs#attrs.hp,
	OldMp = OldTotalAttrs#attrs.mp,
	?TRACE("recount_total_attrs(), OldTotalAttrs: ~p~n", [OldTotalAttrs]),
	% ?DEBUG_MSG("[ply_attr] recount_total_attrs(), OldTotalAttrs=~w", [OldTotalAttrs]),
	L = ?PS_ATTRS_FIELD_LIST(PS_Latest),
	NewTotalAttrs = lib_attribute:sum_attrs(L),
	NewTotalAttrs1 = calc_body_gem_add_attrs(PS_Latest, NewTotalAttrs), 			   	% 宝石属性加成
	NewTotalAttrs2 = lib_attribute:calc_guild_attrs(PS_Latest, NewTotalAttrs1),	% 帮派技能属性加成
	NewTotalAttrs2_1 = lib_attribute:calc_cultivate_attrs(PS_Latest, NewTotalAttrs2),	% 帮派点修属性加成	

	NewTotalAttrs3 = lib_attribute:calc_equip_suit_attrs(PS_Latest, NewTotalAttrs2_1),
	MyArtAttrs = lib_attribute:attr_bonus(NewTotalAttrs3, lib_train:attr_bonus_by_data()),      % 内功加成属性
%%	NewTotalAttrs4_1 = lib_attribute:attr_bonus(MyArtAttrs, ply_title:attr_bonus(player:id(PS_Latest))),
	NewTotalAttrs4_1 = lib_attribute:attr_bonus(MyArtAttrs, ply_title:attr_all_titles(player:id(PS_Latest))), %所有称号加成

	%%此处增加法宝属性加成
	NewTotalAttrs4_1_1 = lib_attribute:attr_bonus(NewTotalAttrs4_1, lib_fabao:attr_all_fabao(player:id(PS_Latest))),

    %此处增加了翅膀属性
    MyWingAttrs   = lib_wing:cacul_all_wing(player:get_id(PS_Latest)),
	NewTotalAttrs4_2_1 = lib_attribute:attr_bonus(NewTotalAttrs4_1_1, MyWingAttrs),
	% 此处增加经脉属性
	MyJingMaiAttrs = get_my_jingmai_attrs(PS_Latest),
%%    ?DEBUG_MSG("------------------------PS_Latest-----------------=~p",[PS_Latest]),
	?DEBUG_MSG("get_my_jingmai_attrs(PS_Latest)=~p",[MyJingMaiAttrs]),
	NewTotalAttrs4_2 = lib_attribute:attr_bonus(NewTotalAttrs4_2_1, MyJingMaiAttrs),

	% 此处增加坐骑属性
	NewTotalAttrs4_3 = calc_mount_attr(PS_Latest, NewTotalAttrs4_2),

	% ?ylh_Debug("recount_total_attrs NewTotalAttrs4_1:~p~n", [NewTotalAttrs4_1]),
	NewTotalAttrs4 = lib_attribute:attr_bonus(NewTotalAttrs4_3, mod_achievement:attr_bonus(player:id(PS_Latest))),
	% ?ylh_Debug("recount_total_attrs NewTotalAttrs4:~p~n", [NewTotalAttrs4]),
	NewTotalAttrs5 = NewTotalAttrs4#attrs{hp = OldHp, mp = OldMp}, 				% 当前hp,mp不变，故重新赋值回去

	NewTotalAttrs6_1 = lib_attribute:calc_passi_eff_attrs(PS_Latest, NewTotalAttrs5),
	NewTotalAttrs6_2 = lib_attribute:calc_rate_attrs(NewTotalAttrs6_1, NewTotalAttrs6_1),


	% 此处增加变身卡计算
	TransfigurationAttrs = case player:get_transfiguration_no(PS_Latest) of
		0 -> [];
		TNo when is_integer(TNo) ->
			case data_transfiguration:get(TNo) of
				TConfig when is_record(TConfig,transfiguration_config) ->
					TConfig#transfiguration_config.add_attr;
				_ ->
					[]
			end;
		_O -> []
	end,
	FabaoMagicPowerAttr = lib_fabao:cacul_magic_base_attrs(PS_Latest#player_status.id),
	NewTotalAttrs6_3 = lib_attribute:attr_bonus(NewTotalAttrs6_2, FabaoMagicPowerAttr),
	NewTotalAttrs6 = lib_attribute:attr_bonus(NewTotalAttrs6_3, TransfigurationAttrs),
	
	NewTotalAttrs7 = lib_attribute:adjust_attrs(NewTotalAttrs6),  % 勿忘做矫正!

	?TRACE("recount_total_attrs(), NewTotalAttrs3: ~p~n", [NewTotalAttrs7]),
	% ?DEBUG_MSG("[ply_attr] recount_total_attrs(), NewTotalAttrs3=~w", [NewTotalAttrs3]),

	PS_Latest2 = player_syn:set_total_attrs(PS_Latest, NewTotalAttrs7),   % 同步更新
	% 重算总属性后， 主动通知客户端
	notify_cli_total_attrs_change(PS_Latest2, OldTotalAttrs, NewTotalAttrs7),

	% 返回最新的PS，以便于上层函数后续重算战斗力
	PS_Latest2.



%% 通知客户端：总属性中的某些属性改了
notify_cli_total_attrs_change(PS, OldTotalAttrs, NewTotalAttrs) ->
	AttrList_Changed = lib_attribute:compare_attrs(OldTotalAttrs, NewTotalAttrs),
	?TRACE("notify_cli_total_attrs_change(),  AttrList_Changed: ~p~n", [AttrList_Changed]),
	F = fun(AttrName) ->
			AttrValue = 
            case AttrName of
                ?ATTR_FROZEN_HIT -> player:get_frozen_hit(PS);  
                ?ATTR_FROZEN_RESIS -> player:get_frozen_resis(PS); 
                ?ATTR_TRANCE_HIT -> player:get_trance_hit(PS); 
                ?ATTR_TRANCE_RESIS -> player:get_trance_resis(PS); 
                ?ATTR_CHAOS_HIT -> player:get_chaos_hit(PS);  
                ?ATTR_CHAOS_RESIS -> player:get_chaos_resis(PS);
                _ ->
                    Index = lib_attribute:get_field_index_in_attrs(AttrName),
					element(Index, NewTotalAttrs)
            end,
			{AttrName, AttrValue}
		end,
	KV_TupleList = [F(X) || X <- AttrList_Changed],
	player:notify_cli_attrs_change(PS, KV_TupleList).



%% 计算战斗力
calc_battle_power(PS,PartnerId) ->
	Coef = data_formula:get(player_cal_battle_power),
	Attrs = get_total_attrs(PS),
	
	BattlePowerPlayer = 
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
	Coef#formula.seal_hit_to_speed * Attrs#attrs.seal_hit_to_speed  +
		Coef#formula.ret_dam_proba * Attrs#attrs.ret_dam_proba    +
	Coef#formula.ret_dam_coef * Attrs#attrs.ret_dam_coef +
		Coef#formula.phy_combo_att_proba * Attrs#attrs.phy_combo_att_proba +
		Coef#formula.mag_combo_att_proba * Attrs#attrs.mag_combo_att_proba +
		Coef#formula.absorb_hp_coef * Attrs#attrs.absorb_hp_coef +
		Coef#formula.strikeback_proba * Attrs#attrs.strikeback_proba +
		Coef#formula.neglect_ret_dam * Attrs#attrs.neglect_ret_dam +
		Coef#formula.pursue_att_proba * Attrs#attrs.pursue_att_proba,


	%%   Coef#formula. * Attrs#attrs. ,
	MainParBattePower =
		case mod_partner:get_main_partner_obj(PS) of
			null -> case PartnerId of
								0 ->
									0;
								_ -> lib_partner:get_battle_power(lib_partner:get_partner(PartnerId))
							end;
			MainPar -> 
				case lib_partner:is_fighting(MainPar) of
					false -> 0;
					true -> lib_partner:get_battle_power(MainPar)
				end
		end,

	DeputyParIdL = player:get_partner_id_list(PS) -- [mod_partner:get_main_partner_id(PS)],

	F = fun(Id, Sum) ->
		case lib_partner:get_partner(Id) of
			null -> Sum;
			Partner -> 
				case lib_partner:is_fighting(Partner) of
					false -> Sum;
					true -> lib_partner:get_battle_power(Partner) + Sum
				end
		end
	end,

	DeputyParBattlePower = lists:foldl(F, 0, DeputyParIdL),

	erlang:max(util:ceil(BattlePowerPlayer) + MainParBattePower + util:ceil(DeputyParBattlePower / 5),0).

%% 重算战斗力
recount_battle_power(PS_Latest) ->
	?TRACE("recount_battle_power begin, BattlePower:~p~n", [get_battle_power(PS_Latest)]),
    BattlePower = calc_battle_power(PS_Latest,0),
    ?TRACE("recount_battle_power end, BattlePower:~p~n", [BattlePower]),
    player:notify_cli_info_change(PS_Latest, ?OI_CODE_BATTLE_POWER, BattlePower),

    PS_Latest2 = player_syn:set_battle_power(PS_Latest, BattlePower),

    PS_Latest2.

%% 重算战斗力2
recount_battle_power(PS_Latest,PartnerId) ->
	?TRACE("recount_battle_power begin, BattlePower:~p~n", [get_battle_power(PS_Latest)]),
	BattlePower = calc_battle_power(PS_Latest,PartnerId),
	?TRACE("recount_battle_power end, BattlePower:~p~n", [BattlePower]),
	player:notify_cli_info_change(PS_Latest, ?OI_CODE_BATTLE_POWER, BattlePower),

	PS_Latest2 = player_syn:set_battle_power(PS_Latest, BattlePower),

	PS_Latest2.











%% 计算玩家的心法的加成属性
%% @return: attrs结构体
calc_xinfa_add_attrs(PlayerId) ->
	case ply_xinfa:get_player_xinfa_info(PlayerId) of
		null ->
			#attrs{};
		PlyXfInfo ->
			?TRACE("PlyXfInfo: ~p~n", [PlyXfInfo]),
			XfBriefList = PlyXfInfo#ply_xinfa.info_list,
			calc_xinfa_add_attrs__(XfBriefList, #attrs{})
	end.

calc_xinfa_add_attrs__([], AccAttrs) ->
	AccAttrs;
calc_xinfa_add_attrs__([XfBrief | T], AccAttrs) ->
	XfId = XfBrief#xinfa_brief.id,
	XfLv = XfBrief#xinfa_brief.lv,
	XfCfg = mod_xinfa:get_cfg_data(XfId),

	AddAttrsNameList = mod_xinfa:get_add_attrs_name_list(XfCfg),

	AddAttrs_KV_TupleList = build_xinfa_add_attrs_KV_list(AddAttrsNameList, XfLv),
	?TRACE("calc_xinfa_add_attrs__(), AddAttrs_KV_TupleList:~p~n", [AddAttrs_KV_TupleList]),

	% 转为attrs结构体
	AddAttrs = lib_attribute:to_attrs_record(AddAttrs_KV_TupleList),

	AccAttrs2 = lib_attribute:sum_two_attrs(AddAttrs, AccAttrs),

	calc_xinfa_add_attrs__(T, AccAttrs2).



%% KV：表示key-value
build_xinfa_add_attrs_KV_list(AddAttrsNameList, XfLv) ->
	XfAddAttrsVal = data_xinfa_add_attrs_value:get(XfLv),
	?ASSERT(XfAddAttrsVal /= null, XfLv),

	F = fun(AttrName) ->
			AddValue = case AttrName of
							?ATTR_HP_LIM -> XfAddAttrsVal#xinfa_add_attrs_val.hp_lim;
							?ATTR_MP_LIM -> XfAddAttrsVal#xinfa_add_attrs_val.mp_lim;
							?ATTR_PHY_ATT -> XfAddAttrsVal#xinfa_add_attrs_val.phy_att;
							?ATTR_MAG_ATT -> XfAddAttrsVal#xinfa_add_attrs_val.mag_att;
							?ATTR_PHY_DEF -> XfAddAttrsVal#xinfa_add_attrs_val.phy_def;
							?ATTR_MAG_DEF -> XfAddAttrsVal#xinfa_add_attrs_val.mag_def;
							?ATTR_HIT -> XfAddAttrsVal#xinfa_add_attrs_val.hit;
							?ATTR_DODGE -> XfAddAttrsVal#xinfa_add_attrs_val.dodge;
							?ATTR_CRIT -> XfAddAttrsVal#xinfa_add_attrs_val.crit;
							?ATTR_TEN -> XfAddAttrsVal#xinfa_add_attrs_val.ten;
							?ATTR_ACT_SPEED -> XfAddAttrsVal#xinfa_add_attrs_val.act_speed;
							?ATTR_SEAL_HIT -> XfAddAttrsVal#xinfa_add_attrs_val.seal_hit;
							?ATTR_SEAL_RESIS -> XfAddAttrsVal#xinfa_add_attrs_val.seal_resis;
							_ -> ?ASSERT(false, AttrName), 0
						end,

			?ASSERT(util:is_positive_int(AddValue), {AttrName, XfLv}),
			{AttrName, AddValue}
		end,
	[F(X) || X <- AddAttrsNameList].








%% 获取基础属性
get_base_attrs(PS) ->
	PS#player_status.base_attrs.


%% 获取装备的加成属性
get_equip_add_attrs(_PS) ->
	?ASSERT(player:this_is_my_own_proc(player:id(_PS))),
	case erlang:get(?PDKN_EQUIP_ADD_ATTRS) of
    	undefined -> #attrs{};
        Attrs -> Attrs
    end.


% 获取心法的加成属性
get_xinfa_add_attrs(_PS) ->
	?ASSERT(player:this_is_my_own_proc(player:id(_PS))),
	case erlang:get(?PDKN_XINFA_ADD_ATTRS) of
    	undefined -> #attrs{};
        Attrs -> Attrs
    end.



%% 获取总属性
get_total_attrs(PS) ->
	PS#player_status.total_attrs.

%% 获取战斗力
get_battle_power(PlayerId) when is_integer(PlayerId) ->
	case player:get_PS(PlayerId) of
        null -> 
            case ply_tmplogout_cache:get_tmplogout_PS(PlayerId) of
                null ->
                    case mod_offline_data:get_offline_role_brief(PlayerId) of
                        null -> 0;
                        OfflineRoleBrief -> OfflineRoleBrief#offline_role_brief.battle_power
                    end;
                TPS -> get_battle_power(TPS)
            end;
        PS -> get_battle_power(PS)
    end;

get_battle_power(PS) ->
	PS#player_status.battle_power.


%% 主心法对应的标准血量
get_master_xinfa_lv_std_hp(PS) ->
	case player:is_in_faction(PS) of
		false -> 0;
		true ->
			Faction = player:get_faction(PS),
			%?DEBUG_MSG("cur Faction = ~p",[Faction]),
			XfId = ply_xinfa:get_faction_master_xinfa_id(Faction),
			%?DEBUG_MSG("cur XfId = ~p",[XfId]),
			XfLv = ply_xinfa:get_player_xinfa_lv(player:id(PS), XfId),
			%?DEBUG_MSG("cur XfLv = ~p",[XfLv]),
			case data_xinfa_std_value:get(XfLv) of
				null -> 0;
				XinfaStdCfg -> XinfaStdCfg#xinfa_std_val.hp
			end
	end.

%% 辅心法对应的标准血量之和
get_assisted_xinfa_lv_std_sum_hp(PS) ->
	case player:is_in_faction(PS) of
		false -> 0;
		true ->
			MasterXfId = ply_xinfa:get_faction_master_xinfa_id(player:get_faction(PS)),
			case ply_xinfa:get_player_xinfa_info(player:id(PS)) of
				null -> 0;
				PlyXfInfo ->
					XfList =
						case lists:keyfind(MasterXfId, #xinfa_brief.id, PlyXfInfo#ply_xinfa.info_list) of
							false -> PlyXfInfo#ply_xinfa.info_list;
							MasterXf -> PlyXfInfo#ply_xinfa.info_list -- [MasterXf]
						end,
					F = fun(XfBrief, Sum) ->
						Lv = XfBrief#xinfa_brief.lv,
						case data_xinfa_std_value:get(Lv) of
							null -> Sum;
							XinfaStdCfg -> XinfaStdCfg#xinfa_std_val.hp + Sum
						end
					end,
					lists:foldl(F, 0, XfList)
			end
	end.


%%calc_gem_add_attrs(PS, Attrs) ->
%%	F = fun(GemNo, AccAttrs) ->
%%        lib_equip:calc_one_gem_attrs(AccAttrs, GemNo)
%%    end,
%%    lists:foldl(F, Attrs, mod_equip:get_player_equip_gem_list(player:id(PS))).

calc_body_gem_add_attrs(PS, Attrs) ->
	PlyMisc = ply_misc:get_player_misc(player:get_id(PS)),
	StrengthList = PlyMisc#player_misc.strengthen_info,
	F = fun({_BobyId, _StrengthLV, GemList}, AccNo) ->
		F0 = fun({_HoleNo, Id, _No}, Acc) ->
			case Id =:= ?INVALID_ID of
				true -> Acc;
				false -> [lib_goods:get_no_by_id(Id) | Acc]
			end
			 end,
		lists:foldl(F0, [], GemList) ++ AccNo
		end,
	NoList = lists:foldl(F, [], StrengthList),

	SkillList = ply_skill:get_passive_skill_list(player:id(PS)),
	PasiiEffNoFun = fun(Skill, PasiiEffNoAcc) ->
		SklCfg = mod_skill:get_cfg_data(Skill#skl_brief.id),
		PasiiEffNoAcc ++  mod_skill:get_passive_effs(SklCfg)
			end,
	PassiEffNoList = lists:foldl(PasiiEffNoFun, [], SkillList),
	IsGemPassi = find_gem_passi(PassiEffNoList),
	F2 = fun(GemNo, AccAttrs) ->
			lib_equip:calc_one_gem_attrs(AccAttrs, GemNo,IsGemPassi)
		end,
	lists:foldl(F2, Attrs, NoList).

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
calc_gem_add_battle(PS) ->
	StandardHp = mod_xinfa:get_std_value(player:get_lv(PS), ?ATTR_HP),
	F = fun(GemNo, Sum) ->
        case data_gem_add:get(GemNo) of
        	null -> Sum;
        	Data -> Data#gem_add.coef * StandardHp + Sum
        end
    end,
    lists:foldl(F, 0, mod_equip:get_player_equip_gem_list(player:id(PS))).


tst_add_attrs(PS, KV_TupleList) ->
	OldTotalAttrs = get_total_attrs(PS),
	F = fun({Key, Value}, Attrs) ->
		case lib_attribute:attr_name_to_obj_info_code(Key) of
			?INVALID_NO -> Attrs;
			_ -> 
				Index = lib_attribute:get_field_index_in_attrs(Key),
            	setelement(Index, Attrs, Value)
		end
	end,
	NewTotalAttrs = lists:foldl(F, OldTotalAttrs, KV_TupleList),
	PS_Latest2 = player_syn:set_total_attrs(PS, NewTotalAttrs),   % 同步更新
	% 重算总属性后， 主动通知客户端
	notify_cli_total_attrs_change(PS_Latest2, OldTotalAttrs, NewTotalAttrs).