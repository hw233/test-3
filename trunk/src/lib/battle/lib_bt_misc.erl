%%%------------------------------------
%%% @Module  : lib_bt_misc
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2012.4.21
%%% @Modified : 2013.7.27
%%% @Description: 战斗系统的相关接口
%%%------------------------------------

-module(lib_bt_misc).

-export([
		generate_player_bo/2,
		generate_battle_road_player_bo/4,
		generate_partner_bo/2,
generate_partner_bo2/3,
		generate_partner_bo_robot/2,
		generate_monster_bo/3,
        generate_monster_bo/5,

        build_bo_info_bin/1,
        build_battle_feedback_for_escaped_bo/1,

        build_partner_bo_extra_bin/1,

        cfg_pos_to_server_logic_pos/1,
        cfg_pos_to_server_logic_pos/3,
        server_logic_pos_to_cfg_pos/1,
        add_one_monster/4,
        add_one_monster/6,
		find_guild_boss_bo/0,

        % to_partner_rd/1,
        post_add_partner_to_battle_field/4,
        post_replace_old_par_from_battle_field/2,
        find_my_owner_player_bo/1,
        find_world_boss_bo/0,
        is_battle_subtype_valid/1,
        pick_mon_from_group/2,
        build_buff_details/2,
        filter_bo_by_rule/3,
        get_zf_no_by_side/1,
		generate_battle_road_partner_bo/4,
		generate_partner_bo_qujing/10,
  apply_add_buff_on_kill_bo/2

     ]).

-import(lib_bt_comm, [
            get_battle_state/0,
            set_battle_state/1,
            get_bo_by_id/1,
            to_enemy_side/1,
            is_dead/1,
            is_living/1,
            is_player/1,
            is_hired_player/1,
            is_partner/1,
            is_monster/1
			]).

-include("common.hrl").
-include("debug.hrl").
-include("record.hrl").
-include("battle.hrl").
-include("road.hrl").
% -include("pt_20.hrl").
-include("record/battle_record.hrl").
-include("monster.hrl").
-include("buff.hrl").
-include("effect.hrl").
-include("offline_data.hrl").
% -include("skill.hrl").
-include("abbreviate.hrl").
-include("partner.hrl").
-include("attribute.hrl").
-include("pt.hrl").
-include("zf.hrl").
-include("faction.hrl").


get_zf_no_by_side(Side) ->
    List = lib_bt_comm:get_bo_id_list(Side),
    case List =:= [] of
        true -> ply_zf:get_common_zf();
        false ->
            Bo = get_bo_by_id(erlang:hd(List)),
            case lib_bt_comm:is_mf_battle(get_battle_state()) andalso (Side =:= ?GUEST_SIDE) of
                true ->
                    ZfNo = lib_bmon_group:get_zf_no(lib_bo:get_bmon_group_no(Bo)),
                    case data_zf:get(ZfNo) of
                        null -> ply_zf:get_common_zf();
                        DataCfg ->
                            case DataCfg#zf_cfg.cnt_limit =< length(List) of
                                true -> ZfNo;
                                false -> ply_zf:get_common_zf()
                            end
                    end;
                false ->
                    PlayerL = lib_bt_comm:get_player_bo_id_list_except_hired_player(Side),
                    case length(PlayerL) =< 1 of
                        true -> ply_zf:get_common_zf();
                        false ->
                            PlayerBo = get_bo_by_id(erlang:hd(PlayerL)),
                            PlayerId = lib_bo:get_parent_obj_id(PlayerBo),
                            lib_team:get_troop_no_by_player_id(PlayerId)
                    end
            end
    end.


%% 查找所属的玩家bo
%% @return: null | battle_obj结构体
find_my_owner_player_bo(Bo) ->
    case is_partner(Bo) orelse is_hired_player(Bo) of
        true ->
            MyOwnerPlayerBoId = lib_bo:get_my_owner_player_bo_id(Bo),
            case get_bo_by_id(MyOwnerPlayerBoId) of
                null ->
                    null;
                OwnerPlayerBo ->
                    OwnerPlayerBo
            end;
        false ->
            case is_player(Bo) of
                true ->
                    Bo;   % 对于正常玩家，其所属的玩家就是他自己
                false ->
                    null
            end
    end.




%% 查找世界boss bo
%% @return: null | battle_obj结构体
find_world_boss_bo() ->
    L = lib_bt_comm:get_bo_id_list(?GUEST_SIDE),
    find_world_boss_bo__(L).


find_world_boss_bo__([BoId | T]) ->
    Bo = get_bo_by_id(BoId),
    case lib_bt_comm:is_world_boss(Bo) of
        true ->
            Bo;
        false ->
            find_world_boss_bo__(T)
    end;
find_world_boss_bo__([]) ->
    null.


%% %查找帮派副本第七关的BOSS
 find_guild_boss_bo() ->
	L = lib_bt_comm:get_bo_id_list(?GUEST_SIDE),
	find_guild_boss_bo__(L).

    find_guild_boss_bo__([BoId | T]) ->
 	Bo = get_bo_by_id(BoId),
	case lib_bo:get_type(Bo) =:= 4 of
		true ->
 			Bo;
 		false ->
 			find_guild_boss_bo__(T)
 	end;

 find_guild_boss_bo__([]) ->
 	null.









%% 战斗子类型是否有效？
is_battle_subtype_valid(BtlSubType) ->
    util:in_range(BtlSubType, ?BTL_SUB_T_MIN, ?BTL_SUB_T_MAX).





%% 获取下一个可用的战斗对象id
get_next_avail_bo_id() ->
	State = get_battle_state(),
	RetId = State#btl_state.next_avail_bo_id,
	State2 = State#btl_state{next_avail_bo_id = RetId + 1}, % 自动递增
	set_battle_state(State2),
	RetId.




%% 是否要加新手技能？
need_to_add_newbie_skill(PS) ->
    (not player:is_in_faction(PS)) andalso (player:get_lv(PS) >= 1).




%% 确定玩家bo的初始血量和蓝量
decide_player_init_hp_mp(PS) ->
    State = get_battle_state(),
    case lib_bt_comm:is_PVP_battle(State) of
        true ->  % PVP
            {player:get_hp_lim(PS), player:get_mp_lim(PS)};
        false -> % PVE

            % 如果不是满血，并且有气血包， 则自动帮玩家补满血
            case player:get_hp_lim(PS) > player:get_hp(PS) orelse player:get_mp_lim(PS) > player:get_mp(PS) of
                true ->
                    gen_server:cast(player:get_pid(PS), 'adjust_player_hp_mp'),

                    {min(player:get_store_hp(PS) + player:get_hp(PS), player:get_hp_lim(PS)),
                     min(player:get_mp(PS) + player:get_store_mp(PS), player:get_mp_lim(PS))
                    };
                false ->
                    {player:get_hp(PS), player:get_mp(PS)}
            end
    end.

%% 确定宠物bo的初始血量和蓝量
decide_partner_init_hp_mp(Partner) ->
    State = get_battle_state(),
    case lib_bt_comm:is_PVP_battle(State) of
        true ->  % PVP
            {lib_partner:get_hp_lim(Partner), lib_partner:get_mp_lim(Partner)};
        false -> % PVE
            % {lib_partner:get_hp(Partner), lib_partner:get_mp(Partner)}

            case lib_partner:is_owner_online(Partner) of
                true ->
                    PlayerId = lib_partner:get_owner_id(Partner),
                    PS = player:get_PS(PlayerId),

                    case lib_partner:get_hp_lim(Partner) > lib_partner:get_hp(Partner) orelse lib_partner:get_mp_lim(Partner) > lib_partner:get_mp(Partner) of
                        true ->
                            gen_server:cast(player:get_pid(PS), {'adjust_partner_hp_mp', Partner}),

                            {min(player:get_store_par_hp(PS) + lib_partner:get_hp(Partner), lib_partner:get_hp_lim(Partner)),
                             min(player:get_store_par_mp(PS) + lib_partner:get_mp(Partner), lib_partner:get_mp_lim(Partner))
                            };
                        false ->
                            {lib_partner:get_hp(Partner), lib_partner:get_mp(Partner)}
                    end;
                false ->
                     {lib_partner:get_hp(Partner), lib_partner:get_mp(Partner)}
            end
    end.



%% 生成玩家战斗对象
%% @para: OnlineFlag => 在线标记：online | offline
%% @return: {NewBoId, NewBo}
generate_player_bo(PS, [Side, Pos, OnlineFlag]) when is_record(PS, player_status) ->
    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),

    NewBoId = get_next_avail_bo_id(),

    FactionBaseInfo =
      case player:get_faction(PS) == 0 of
        true ->null;
        false ->data_faction:get(player:get_faction(PS))
        end,
    PlayerFiveElement =case FactionBaseInfo of
                         null ->
                           0;
                         _ ->
                           FactionBaseInfo#faction_base.five_elements
                       end,

  {InitHp, InitMp} = decide_player_init_hp_mp(PS),

    IsOnline =  case OnlineFlag of
                    online -> true;
                    offline -> false
                end,
    IsAutoBattle = player:is_auto_battle(PS),

    ?ASSERT(player:get_hp(PS) =< player:get_hp_lim(PS), {ply_attr:get_total_attrs(PS), PS}),
    ?ASSERT(player:get_mp(PS) =< player:get_mp_lim(PS), {ply_attr:get_total_attrs(PS), PS}),

    Attrs = ply_attr:get_total_attrs(PS),

    % ?DEBUG_MSG("Attrs = ~p",[Attrs]),

    Attrs2 = Attrs#attrs{
                hp = InitHp,
                mp = InitMp,
                anger = ?ANGER_INIT,
				anger_lim = ?ANGER_LIM,
				hit = 0,
				dodge = 0
                },

    ?BT_LOG(io_lib:format("generate_player_bo() PS, Attrs:~w, Anger:~p~n", [Attrs2, Attrs2#attrs.anger])),

    % 记录初始值（计算被动技或主动技buff的百分比效果时，以这些初始值作为乘法的基数）
    InitAttrs = Attrs2,

    PlayerId = player:id(PS),

    XfBriefList = ply_xinfa:get_player_xinfa_brief_list(PlayerId),

    InitiaSkillList = ply_skill:get_initiative_skill_list(PlayerId),   %%%%get_skill_list(PlayerId),
    BoInitiaSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiaSkillList],

    BoInitiaSkillBrfList2 = case need_to_add_newbie_skill(PS) of
                                true ->
                                    NewBieSkill = lib_bt_skill:to_bo_skill_brief(?NEWBIE_SKILL_ID),
                                    [NewBieSkill | BoInitiaSkillBrfList];
                                false ->
                                    BoInitiaSkillBrfList
                            end,
    ?ASSERT(util:is_tuple_list(BoInitiaSkillBrfList2)),

    PassiSkillList = ply_skill:get_passive_skill_list(PlayerId) ,  %%1000001
    BoPassiSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiSkillList],

    ?DEBUG_MSG("wujianchengtestjineng=~p",[PassiSkillList]),

    AIList = ply_amf:get_AI_list(PlayerId),  %%%lib_skill:build_AI_list_from(InitiaSkillList)
    ?ASSERT(util:is_integer_list(AIList)),

    Titles = #bo_titles{
                    graph_title = player:get_graph_title(PS),
                    text_title = player:get_text_title(PS),
                    user_def_title = player:get_user_def_title(PS)
                    },

  put({get_bo_id_by_player_id,PlayerId },NewBoId),

    NewBo = #battle_obj{
                        id = NewBoId,
                        parent_obj_id = player:get_id(PS),

                        type = ?OBJ_PLAYER,

                        name = player:get_name(PS),

                        transfiguration_no = player:get_transfiguration_no(PS),

                        sendpid = player:get_sendpid(PS),
                        is_online = IsOnline,

                        side = Side,
                        pos = Pos,

                        race = player:get_race(PS),
                        faction = player:get_faction(PS),
                        sex = player:get_sex(PS),
                        lv = player:get_lv(PS),
                        gamemoney = player:get_gamemoney(PS),
                        when_spawn_round = lib_bt_comm:get_cur_round(),

                        is_auto_battle = IsAutoBattle,  % TODO：目前都设为不自动战斗， 以后如有离线竞技场之类的玩法，则需调整！

                        attrs = Attrs2,
                        init_attrs = InitAttrs,

                        xinfa_brief_list = XfBriefList,
                        initiative_skill_list = BoInitiaSkillBrfList2,
                        passi_skill_list = BoPassiSkillBrfList,
                        ai_list = AIList,

                        showing_equips = player:get_showing_equips_base_setting(PS),
                        suit_no = player:get_suit_no(PS),
                        titles = Titles,
                        five_elements = {PlayerFiveElement,0}
                        },

    ?BT_LOG(io_lib:format("player showing equips:~w~n", [player:get_showing_equips_base_setting(PS)])),

    % 应用被动技的效果
    NewBo2 = apply_passi_skill_effs_to_bo(PassiSkillList, NewBo),
    ?ASSERT(is_record(NewBo2, battle_obj), NewBo2),

    {NewBoId, NewBo2};


%% 生成离线玩家战斗对象
%% @return: {NewBoId, NewBo}
generate_player_bo(OfflineBo, [Side, Pos, IsHiredPlayer]) when is_record(OfflineBo, offline_bo) ->
    ?ASSERT(mod_offline_bo:is_player(OfflineBo)),
    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),

    NewBoId = get_next_avail_bo_id(),

  FactionBaseInfo = case mod_offline_bo:get_faction(OfflineBo)==0 of
                      true ->
                        null;
                      false ->
                        data_faction:get(mod_offline_bo:get_faction(OfflineBo))
                    end,
  FiveElementv =
    case FactionBaseInfo of
      null ->
        0;
      _ ->
        FactionBaseInfo#faction_base.five_elements
    end,

    BoType = case IsHiredPlayer of  % 是否雇佣玩家？
                true ->?OBJ_HIRED_PLAYER;
                false -> ?OBJ_PLAYER
            end,

    Attrs = mod_offline_bo:get_attrs(OfflineBo),

	BePhyDamR  = case  Attrs#attrs.be_phy_dam_reduce_coef >= 0.95 of
					 true -> Attrs#attrs.be_phy_dam_reduce_coef/3;
					 false -> Attrs#attrs.be_phy_dam_reduce_coef
				 end,
	BeMagDamR = case Attrs#attrs.be_mag_dam_reduce_coef >= 0.95 of
					true -> Attrs#attrs.be_mag_dam_reduce_coef/3;
					false -> Attrs#attrs.be_mag_dam_reduce_coef
				end,


    ?BT_LOG(io_lib:format("generate_player_bo() offline_bo, Attrs:~w~n", [Attrs])),

    Attrs2 = Attrs#attrs{  % 目前都设为满血满蓝
                hp = Attrs#attrs.hp_lim,
                mp = Attrs#attrs.mp_lim,
                anger = ?ANGER_INIT,
                anger_lim = ?ANGER_LIM,
				be_phy_dam_reduce_coef = BePhyDamR,
				be_mag_dam_reduce_coef = BeMagDamR
                },

    % 记录初始值（计算被动技或主动技buff的百分比效果时，以这些初始值作为乘法的基数）
    InitAttrs = Attrs2,

    PlayerId = mod_offline_bo:get_id(OfflineBo),

    XfBriefList = mod_offline_bo:get_xinfa_brief_list(OfflineBo),

    InitiaSkillList = mod_offline_bo:get_initiative_skill_list(OfflineBo),  %%%get_skill_list(OfflineBo),
    BoInitiaSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiaSkillList],

    PassiSkillList = mod_offline_bo:get_passive_skill_list(OfflineBo),
    BoPassiSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiSkillList],

    AIList = mod_offline_bo:get_AI_list(OfflineBo),
    ?ASSERT(util:is_integer_list(AIList)),

    ShowingEqs = mod_offline_bo:get_showing_equips(OfflineBo),

    NewBo = #battle_obj{
                        id = NewBoId,
                        parent_obj_id = PlayerId,

                        type = BoType,

                        name = mod_offline_bo:get_name(OfflineBo),
                        race = mod_offline_bo:get_race(OfflineBo),
                        faction = mod_offline_bo:get_faction(OfflineBo),
                        sex = mod_offline_bo:get_sex(OfflineBo),
                        lv = mod_offline_bo:get_lv(OfflineBo),

                        is_online = false,  % 固定为非在线

                        side = Side,
                        pos = Pos,

                        when_spawn_round = lib_bt_comm:get_cur_round(),

                        is_auto_battle = false,

                        attrs = Attrs2,
                        init_attrs = InitAttrs,

                        xinfa_brief_list = XfBriefList,
                        initiative_skill_list = BoInitiaSkillBrfList,
                        passi_skill_list = BoPassiSkillBrfList,
                        ai_list = AIList,

                        showing_equips = ShowingEqs,
                        suit_no = ShowingEqs#showing_equip.suit_no,
      five_elements = { FiveElementv,0}
                        },

    % 应用被动技的效果
    NewBo2 = apply_passi_skill_effs_to_bo(PassiSkillList, NewBo),
    ?ASSERT(is_record(NewBo2, battle_obj), NewBo2),

    {NewBoId, NewBo2}.

%% 生成离线玩家战斗对象
%% @return: {NewBoId, NewBo}
generate_battle_road_player_bo(OfflineBo, [Side, Pos, IsHiredPlayer],NowPoint,Lv) when is_record(OfflineBo, offline_bo) ->
    ?ASSERT(mod_offline_bo:is_player(OfflineBo)),
    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),

    NewBoId = get_next_avail_bo_id(),

    BoType = case IsHiredPlayer of  % 是否雇佣玩家？
                true ->?OBJ_HIRED_PLAYER;
                false -> ?OBJ_PLAYER
            end,
  FactionBaseInfo = case  mod_offline_bo:get_faction(OfflineBo) == 0 of
                      true ->
                        null;
                      false ->
                        data_faction:get(mod_offline_bo:get_faction(OfflineBo))
                        end,
  FiveElementLv = case FactionBaseInfo of
                    null ->
                      0;
                    _ ->
                      FactionBaseInfo#faction_base.five_elements
                  end,
    Attrs = mod_offline_bo:get_attrs(OfflineBo),
	OppLv = mod_offline_bo:get_lv(OfflineBo),
	BePhyDamR  = case  Attrs#attrs.be_phy_dam_reduce_coef >= 0.95 of
					 true -> Attrs#attrs.be_phy_dam_reduce_coef/3;
					 false -> Attrs#attrs.be_phy_dam_reduce_coef
				 end,
	BeMagDamR = case Attrs#attrs.be_mag_dam_reduce_coef >= 0.95 of
					true -> Attrs#attrs.be_mag_dam_reduce_coef/3;
					false -> Attrs#attrs.be_mag_dam_reduce_coef
				end,

    ?BT_LOG(io_lib:format("generate_player_bo() offline_bo, Attrs:~w~n", [Attrs])),

   Attrs2 =case Lv - OppLv >= 10 of
				true ->
					CoeRoad = (data_qujing_battle_coef:get(NowPoint))#qujing_battle_coef.ratio_min,
					case NowPoint of
						1 -> cac_attrs_to_qujing(Attrs,CoeRoad);
						2 -> cac_attrs_to_qujing(Attrs,CoeRoad);
						3 ->  cac_attrs_to_qujing(Attrs,CoeRoad);
						4 ->  cac_attrs_to_qujing(Attrs,CoeRoad);
						5 ->  cac_attrs_to_qujing(Attrs,CoeRoad);
						6 ->  cac_attrs_to_qujing(Attrs,CoeRoad);
						7 -> cac_attrs_to_qujing(Attrs,CoeRoad);
						8 -> cac_attrs_to_qujing(Attrs,CoeRoad);
						9 -> cac_attrs_to_qujing(Attrs,CoeRoad);
						_ -> cac_attrs_to_qujing(Attrs,CoeRoad)
					end;
				false ->
					CoeRoad = (data_qujing_battle_coef:get(NowPoint))#qujing_battle_coef.ratio_max,
					case NowPoint of
						1 -> cac_attrs_to_qujing(Attrs,CoeRoad);
						2 -> cac_attrs_to_qujing(Attrs,CoeRoad);
						3 ->  cac_attrs_to_qujing(Attrs,CoeRoad);
						4 ->  cac_attrs_to_qujing(Attrs,CoeRoad);
						5 ->  cac_attrs_to_qujing(Attrs,CoeRoad);
						6 ->  cac_attrs_to_qujing(Attrs,CoeRoad);
						7 -> cac_attrs_to_qujing(Attrs,CoeRoad);
						8 -> cac_attrs_to_qujing(Attrs,CoeRoad);
						9 -> cac_attrs_to_qujing(Attrs,CoeRoad);
						_ -> cac_attrs_to_qujing(Attrs,CoeRoad)
					end
			end,
    InitAttrs0 = Attrs2#attrs{
							 hp = Attrs#attrs.hp_lim,
							 mp = Attrs#attrs.mp_lim,
                             hp_lim = Attrs#attrs.hp_lim,
							 mp_lim = Attrs#attrs.mp_lim,
							 be_phy_dam_reduce_coef = BePhyDamR,
							 be_mag_dam_reduce_coef = BeMagDamR,
							 hit = 0,
							 dodge = 0

					   },

    % 记录初始值（计算被动技或主动技buff的百分比效果时，以这些初始值作为乘法的基数）
    InitAttrs = InitAttrs0,

    PlayerId = mod_offline_bo:get_id(OfflineBo),

    XfBriefList = mod_offline_bo:get_xinfa_brief_list(OfflineBo),

    InitiaSkillList = mod_offline_bo:get_initiative_skill_list(OfflineBo),  %%%get_skill_list(OfflineBo),
    BoInitiaSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiaSkillList],

    PassiSkillList = mod_offline_bo:get_passive_skill_list(OfflineBo),
    BoPassiSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiSkillList],

    AIList = mod_offline_bo:get_AI_list(OfflineBo),
    ?ASSERT(util:is_integer_list(AIList)),

    ShowingEqs = mod_offline_bo:get_showing_equips(OfflineBo),

    NewBo = #battle_obj{
                        id = NewBoId,
                        parent_obj_id = PlayerId,

                        type = BoType,

                        name = mod_offline_bo:get_name(OfflineBo),
                        race = mod_offline_bo:get_race(OfflineBo),
                        faction = mod_offline_bo:get_faction(OfflineBo),
                        sex = mod_offline_bo:get_sex(OfflineBo),
                        lv = mod_offline_bo:get_lv(OfflineBo),

                        is_online = false,  % 固定为非在线

                        side = Side,
                        pos = Pos,

                        when_spawn_round = lib_bt_comm:get_cur_round(),

                        is_auto_battle = false,

                        attrs = Attrs2,
                        init_attrs = InitAttrs,

                        xinfa_brief_list = XfBriefList,
                        initiative_skill_list = BoInitiaSkillBrfList,
                        passi_skill_list = BoPassiSkillBrfList,
                        ai_list = AIList,

                        showing_equips = ShowingEqs,
                        suit_no = ShowingEqs#showing_equip.suit_no,
      five_elements =  {FiveElementLv,0}
                        },

    % 应用被动技的效果
    NewBo2 = apply_passi_skill_effs_to_bo(PassiSkillList, NewBo),
    ?ASSERT(is_record(NewBo2, battle_obj), NewBo2),

    {NewBoId, NewBo2}.


%% 取经之路生成宠物战斗对象
%% @return: {NewBoId, NewBo}
generate_battle_road_partner_bo(PS,Partner, [Side, Pos],Type) when is_record(Partner, partner) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
	RoadData = mod_road:get_road_from_ets(player:get_id(PS)),
	ParInfo = RoadData#road_info.now_battle_partner,
	NowPoint = RoadData#road_info.now_point,

	ParInfoOffline = RoadData#road_info.pk_info,
	%{PlayerId,Name,Faction,Lv,Sex,FivePartner}
	[{_PlayerID,_Name,_Faction,_Lv,_Sex,FivePartner}] = lists:sublist(ParInfoOffline, NowPoint, 1),



    NewBoId = get_next_avail_bo_id(),

	NowParId = lib_partner:get_id(Partner),

	{_,InitHp,InitMp,_MaxHp,_MpHp,MainPar}=case Type of
				  1 ->	lists:keyfind(NowParId, 1, ParInfo);
				  2 ->  lists:keyfind(NowParId, 1, FivePartner)
			  end,

    case MainPar =:= 1  of
        true ->
            IsMainPartner = true,
            IsOnline = true,          % 主宠初始为在线
            IsAutoBattle = false;     % 主宠初始为非自动战斗
        false ->
            IsMainPartner = false,
            IsOnline = false,         % 副宠固定为离线
            IsAutoBattle = true       % 副宠固定为自动战斗
    end,

    Attrs = lib_partner:get_total_attrs(Partner),
    Attrs2 = Attrs#attrs{
                hp = InitHp,
                mp = InitMp,
                anger = ?ANGER_INIT,
                anger_lim = ?ANGER_LIM,
				hit = 0,
				dodge = 0
                },

    % 记录初始值（计算被动技或主动技buff的百分比效果时，以这些初始值作为乘法的基数）
    InitAttrs = Attrs2,

    InitiaSkillList = lib_partner:get_initiative_skill_list(Partner), %%get_skill_list(Partner),
    ?BT_LOG(io_lib:format("generate_partner_bo(), PartnerId=~p, InitiaSkillList:~w, do_phy_dam_scaling=~p~n", [lib_partner:get_id(Partner), InitiaSkillList, Attrs2#attrs.do_phy_dam_scaling])),
    BoInitiaSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiaSkillList],

    PassiSkillList = lib_partner:get_passive_skill_list(Partner),
    BoPassiSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiSkillList],


    AIList = lib_partner:get_AI_list(Partner),
    ?ASSERT(util:is_integer_list(AIList)),

    ParExtra = #par_bo_extra{
                    cultivate_lv = lib_partner:get_cultivate_lv(Partner),
                    cultivate_layer = lib_partner:get_cultivate_layer(Partner),
                    evolve_lv = lib_partner:get_evolve_lv(Partner),
                    nature = lib_partner:get_nature(Partner),
                    quality = lib_partner:get_quality(Partner),
					awake_illusion = lib_partner:get_awake_illusion(Partner)
                    },

    NewBo = #battle_obj{
                        id = NewBoId,
                        parent_obj_id = lib_partner:get_id(Partner),
                        type = ?OBJ_PARTNER,
                        name = lib_partner:get_name(Partner),

                        parent_partner_no = lib_partner:get_no(Partner),

                        sendpid = null,
                        is_online = IsOnline,

                        side = Side,
                        pos = Pos,

                        race = lib_partner:get_race(Partner),
                        faction = lib_partner:get_faction(Partner),
                        sex = lib_partner:get_sex(Partner),
                        lv = lib_partner:get_lv(Partner),

                        when_spawn_round = lib_bt_comm:get_cur_round(),

                        is_auto_battle = IsAutoBattle,  % TODO：目前都设为不自动战斗， 以后如有离线竞技场之类的玩法，则需调整！

                        attrs = Attrs2,
                        init_attrs = InitAttrs,

                        initiative_skill_list = BoInitiaSkillBrfList,
                        passi_skill_list = BoPassiSkillBrfList,
                        ai_list = AIList,

                        is_main_partner = IsMainPartner,

                        showing_equips = lib_partner:get_showing_equips_base_setting(Partner),

                        par_extra = ParExtra,
                        five_elements = Partner#partner.five_element
                        },

    ?BT_LOG(io_lib:format("ParNo:~p, partner showing equips:~w, BeHealEffCoef:~p~n",
                        [lib_partner:get_no(Partner), lib_partner:get_showing_equips_base_setting(Partner), lib_bo:get_be_heal_eff_coef(NewBo)])),
    % 应用被动技的效果
    NewBo2 = apply_passi_skill_effs_to_bo(PassiSkillList, NewBo),
    ?ASSERT(is_record(NewBo2, battle_obj), NewBo2),

    {NewBoId, NewBo2}.






%% 生成宠物战斗对象
%% @return: {NewBoId, NewBo}
generate_partner_bo(Partner, [Side, Pos]) when is_record(Partner, partner) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),

    NewBoId = get_next_avail_bo_id(),

    {InitHp, InitMp} = decide_partner_init_hp_mp(Partner),

    case lib_partner:is_main_partner(Partner) of
        true ->
            IsMainPartner = true,
            IsOnline = true,          % 主宠初始为在线
            IsAutoBattle = false;     % 主宠初始为非自动战斗
        false ->
            IsMainPartner = false,
            IsOnline = false,         % 副宠固定为离线
            IsAutoBattle = true       % 副宠固定为自动战斗
    end,

    Attrs = lib_partner:get_total_attrs(Partner),
    Attrs2 = Attrs#attrs{
                hp = InitHp,
                mp = InitMp,
                anger = ?ANGER_INIT,
                anger_lim = ?ANGER_LIM
                },

    % 记录初始值（计算被动技或主动技buff的百分比效果时，以这些初始值作为乘法的基数）
    InitAttrs = Attrs2,

    InitiaSkillList = lib_partner:get_initiative_skill_list(Partner), %%get_skill_list(Partner),
    ?BT_LOG(io_lib:format("generate_partner_bo(), PartnerId=~p, InitiaSkillList:~w, do_phy_dam_scaling=~p~n", [lib_partner:get_id(Partner), InitiaSkillList, Attrs2#attrs.do_phy_dam_scaling])),
    BoInitiaSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiaSkillList],

    PassiSkillList = lib_partner:get_passive_skill_list(Partner),
    BoPassiSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiSkillList],


    AIList = lib_partner:get_AI_list(Partner),
    ?ASSERT(util:is_integer_list(AIList)),

    ParExtra = #par_bo_extra{
                    cultivate_lv = lib_partner:get_cultivate_lv(Partner),
                    cultivate_layer = lib_partner:get_cultivate_layer(Partner),
                    evolve_lv = lib_partner:get_evolve_lv(Partner),
                    nature = lib_partner:get_nature(Partner),
                    quality = lib_partner:get_quality(Partner),
					awake_illusion = lib_partner:get_awake_illusion(Partner)
                    },

    NewBo = #battle_obj{
                        id = NewBoId,
                        parent_obj_id = lib_partner:get_id(Partner),
                        type = ?OBJ_PARTNER,
                        name = lib_partner:get_name(Partner),

                        parent_partner_no = lib_partner:get_no(Partner),

                        sendpid = null,
                        is_online = IsOnline,

                        side = Side,
                        pos = Pos,

                        race = lib_partner:get_race(Partner),
                        faction = lib_partner:get_faction(Partner),
                        sex = lib_partner:get_sex(Partner),
                        lv = lib_partner:get_lv(Partner),

                        when_spawn_round = lib_bt_comm:get_cur_round(),

                        is_auto_battle = IsAutoBattle,  % TODO：目前都设为不自动战斗， 以后如有离线竞技场之类的玩法，则需调整！

                        attrs = Attrs2,
                        init_attrs = InitAttrs,

                        initiative_skill_list = BoInitiaSkillBrfList,
                        passi_skill_list = BoPassiSkillBrfList,
                        ai_list = AIList,

                        is_main_partner = IsMainPartner,

                        showing_equips = lib_partner:get_showing_equips_base_setting(Partner),

                        par_extra = ParExtra,
      five_elements = Partner#partner.five_element
                        },

    ?BT_LOG(io_lib:format("ParNo:~p, partner showing equips:~w, BeHealEffCoef:~p~n",
                        [lib_partner:get_no(Partner), lib_partner:get_showing_equips_base_setting(Partner), lib_bo:get_be_heal_eff_coef(NewBo)])),
    % 应用被动技的效果
    NewBo2 = apply_passi_skill_effs_to_bo(PassiSkillList, NewBo),
  ?DEBUG_MSG("wjctestbattle ~p~n",[{PassiSkillList}]),
    ?ASSERT(is_record(NewBo2, battle_obj), NewBo2),

    {NewBoId, NewBo2};




%% 生成离线宠物bo
generate_partner_bo(OfflineBo, [Side, Pos]) when is_record(OfflineBo, offline_bo) ->
    ?ASSERT(mod_offline_bo:is_partner(OfflineBo)),

    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),

    NewBoId = get_next_avail_bo_id(),

    IsMainPartner = mod_offline_bo:is_main_partner(OfflineBo),
    % IsOnline = false,
    % IsAutoBattle = true,

    Attrs = mod_offline_bo:get_attrs(OfflineBo),

	BePhyDamR  = case  Attrs#attrs.be_phy_dam_reduce_coef >= 0.95 of
					 true -> Attrs#attrs.be_phy_dam_reduce_coef/3;
					 false -> Attrs#attrs.be_phy_dam_reduce_coef
				 end,
	BeMagDamR = case Attrs#attrs.be_mag_dam_reduce_coef >= 0.95 of
					true -> Attrs#attrs.be_mag_dam_reduce_coef/3;
					false -> Attrs#attrs.be_mag_dam_reduce_coef
				end,

    Attrs2 = Attrs#attrs{ % 暂时都是初始化为满血满蓝
                    hp = Attrs#attrs.hp_lim,
                    mp = Attrs#attrs.mp_lim,
                    anger = ?ANGER_INIT,
                    anger_lim = ?ANGER_LIM,
					be_phy_dam_reduce_coef = BePhyDamR,
					be_mag_dam_reduce_coef = BeMagDamR,
					hit = 0,
					dodge = 0
                    },

    InitAttrs = Attrs2,

    InitiaSkillList = mod_offline_bo:get_initiative_skill_list(OfflineBo),  %%%get_skill_list(OfflineBo),   %%lib_partner:get_initiative_skill_list(Partner), %%get_skill_list(Partner),
    %%%SkillList_Initia = lib_skill:pick_initiative_skill_list_from(InitiaSkillList),

    ?BT_LOG(io_lib:format("generate_partner_bo(), offline par bo PartnerId=~p, InitiaSkillList:~w~n", [mod_offline_bo:get_id(OfflineBo), InitiaSkillList])),
    BoInitiaSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiaSkillList],

    PassiSkillList = mod_offline_bo:get_passive_skill_list(OfflineBo),
    BoPassiSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiSkillList],

    AIList = mod_offline_bo:get_AI_list(OfflineBo),
    ?ASSERT(util:is_integer_list(AIList)),

    ParExtra = #par_bo_extra{
                    cultivate_lv = mod_offline_bo:get_par_cultivate_lv(OfflineBo),
                    cultivate_layer = mod_offline_bo:get_par_cultivate_layer(OfflineBo),
                    evolve_lv = mod_offline_bo:get_par_evolve_lv(OfflineBo),
                    nature = mod_offline_bo:get_par_nature(OfflineBo),
                    quality = mod_offline_bo:get_par_quality(OfflineBo),
					awake_illusion = mod_offline_bo:get_par_awake_illusion(OfflineBo)
                    },

    NewBo = #battle_obj{
                        id = NewBoId,
                        parent_obj_id = mod_offline_bo:get_id(OfflineBo),
                        type = ?OBJ_PARTNER,
                        name = mod_offline_bo:get_name(OfflineBo),

                        parent_partner_no = mod_offline_bo:get_par_no(OfflineBo),

                        sendpid = null,
                        is_online = false,       % 固定为非在线
                        is_auto_battle = true,

                        side = Side,
                        pos = Pos,

                        race = mod_offline_bo:get_race(OfflineBo),
                        faction = mod_offline_bo:get_faction(OfflineBo),
                        sex = mod_offline_bo:get_sex(OfflineBo),
                        lv = mod_offline_bo:get_lv(OfflineBo),

                        when_spawn_round = lib_bt_comm:get_cur_round(),

                        attrs = Attrs2,
                        init_attrs = InitAttrs,

                        initiative_skill_list = BoInitiaSkillBrfList,
                        passi_skill_list = BoPassiSkillBrfList,
                        ai_list = AIList,

                        is_main_partner = IsMainPartner,

                        showing_equips = mod_offline_bo:get_showing_equips(OfflineBo),

                        par_extra = ParExtra,
      five_elements =OfflineBo#offline_bo.par_property#par_prop.five_elment
                        },

    % 应用被动技的效果
    NewBo2 = apply_passi_skill_effs_to_bo(PassiSkillList, NewBo),
    ?ASSERT(is_record(NewBo2, battle_obj), NewBo2),

    {NewBoId, NewBo2}.



%% 生成宠物战斗对象
%% @return: {NewBoId, NewBo}
generate_partner_bo2(Partner, [Side, Pos],IsMainPartner) when is_record(Partner, partner) ->
  ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),

  NewBoId = get_next_avail_bo_id(),

  {InitHp, InitMp} = decide_partner_init_hp_mp(Partner),

  case IsMainPartner of
    true ->
      IsMainPartner = true,
      IsOnline = true,          % 主宠初始为在线
      IsAutoBattle = false;     % 主宠初始为非自动战斗
    false ->
      IsMainPartner = false,
      IsOnline = false,         % 副宠固定为离线
      IsAutoBattle = true       % 副宠固定为自动战斗
  end,

  Attrs = lib_partner:get_total_attrs(Partner),
  Attrs2 = Attrs#attrs{
    hp = InitHp,
    mp = InitMp,
    anger = ?ANGER_INIT,
    anger_lim = ?ANGER_LIM
  },

  % 记录初始值（计算被动技或主动技buff的百分比效果时，以这些初始值作为乘法的基数）
  InitAttrs = Attrs2,

  InitiaSkillList = lib_partner:get_initiative_skill_list(Partner), %%get_skill_list(Partner),
  ?BT_LOG(io_lib:format("generate_partner_bo(), PartnerId=~p, InitiaSkillList:~w, do_phy_dam_scaling=~p~n", [lib_partner:get_id(Partner), InitiaSkillList, Attrs2#attrs.do_phy_dam_scaling])),
  BoInitiaSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiaSkillList],

  PassiSkillList = lib_partner:get_passive_skill_list(Partner),
  BoPassiSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiSkillList],


  AIList = lib_partner:get_AI_list(Partner),
  ?ASSERT(util:is_integer_list(AIList)),

  ParExtra = #par_bo_extra{
    cultivate_lv = lib_partner:get_cultivate_lv(Partner),
    cultivate_layer = lib_partner:get_cultivate_layer(Partner),
    evolve_lv = lib_partner:get_evolve_lv(Partner),
    nature = lib_partner:get_nature(Partner),
    quality = lib_partner:get_quality(Partner),
	awake_illusion = lib_partner:get_awake_illusion(Partner)
  },

  NewBo = #battle_obj{
    id = NewBoId,
    parent_obj_id = lib_partner:get_id(Partner),
    type = ?OBJ_PARTNER,
    name = lib_partner:get_name(Partner),

    parent_partner_no = lib_partner:get_no(Partner),

    sendpid = null,
    is_online = IsOnline,

    side = Side,
    pos = Pos,

    race = lib_partner:get_race(Partner),
    faction = lib_partner:get_faction(Partner),
    sex = lib_partner:get_sex(Partner),
    lv = lib_partner:get_lv(Partner),

    when_spawn_round = lib_bt_comm:get_cur_round(),

    is_auto_battle = IsAutoBattle,  % TODO：目前都设为不自动战斗， 以后如有离线竞技场之类的玩法，则需调整！

    attrs = Attrs2,
    init_attrs = InitAttrs,

    initiative_skill_list = BoInitiaSkillBrfList,
    passi_skill_list = BoPassiSkillBrfList,
    ai_list = AIList,

    is_main_partner = IsMainPartner,

    showing_equips = lib_partner:get_showing_equips_base_setting(Partner),

    par_extra = ParExtra,
    five_elements = Partner#partner.five_element
  },

  ?BT_LOG(io_lib:format("ParNo:~p, partner showing equips:~w, BeHealEffCoef:~p~n",
    [lib_partner:get_no(Partner), lib_partner:get_showing_equips_base_setting(Partner), lib_bo:get_be_heal_eff_coef(NewBo)])),
  % 应用被动技的效果
  NewBo2 = apply_passi_skill_effs_to_bo(PassiSkillList, NewBo),
  ?DEBUG_MSG("wjctestbattle ~p~n",[{PassiSkillList}]),
  ?ASSERT(is_record(NewBo2, battle_obj), NewBo2),

  {NewBoId, NewBo2}.

%离线
generate_partner_bo_robot(Partner, [Side, Pos]) when is_record(Partner, partner) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),

    NewBoId = get_next_avail_bo_id(),

    {InitHp, InitMp} = decide_partner_init_hp_mp(Partner),

    case lib_partner:is_main_partner(Partner) of
        true ->
            IsMainPartner = true,
            IsOnline = false,          % 主宠初始为在线
            IsAutoBattle = true;     % 主宠初始为非自动战斗
        false ->
            IsMainPartner = false,
            IsOnline = false,         % 副宠固定为离线
            IsAutoBattle = true       % 副宠固定为自动战斗
    end,

    Attrs = lib_partner:get_total_attrs(Partner),
    Attrs2 = Attrs#attrs{
                hp = InitHp,
                mp = InitMp,
                anger = ?ANGER_INIT,
                anger_lim = ?ANGER_LIM
                },

    % 记录初始值（计算被动技或主动技buff的百分比效果时，以这些初始值作为乘法的基数）
    InitAttrs = Attrs2,

    InitiaSkillList = lib_partner:get_initiative_skill_list(Partner), %%get_skill_list(Partner),
    ?BT_LOG(io_lib:format("generate_partner_bo(), PartnerId=~p, InitiaSkillList:~w, do_phy_dam_scaling=~p~n", [lib_partner:get_id(Partner), InitiaSkillList, Attrs2#attrs.do_phy_dam_scaling])),
    BoInitiaSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiaSkillList],

    PassiSkillList = lib_partner:get_passive_skill_list(Partner),
    BoPassiSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiSkillList],


    AIList = lib_partner:get_AI_list(Partner),
    ?ASSERT(util:is_integer_list(AIList)),

    ParExtra = #par_bo_extra{
                    cultivate_lv = lib_partner:get_cultivate_lv(Partner),
                    cultivate_layer = lib_partner:get_cultivate_layer(Partner),
                    evolve_lv = lib_partner:get_evolve_lv(Partner),
                    nature = lib_partner:get_nature(Partner),
                    quality = lib_partner:get_quality(Partner),
					awake_illusion = lib_partner:get_awake_illusion(Partner)
                    },

    NewBo = #battle_obj{
                        id = NewBoId,
                        parent_obj_id = lib_partner:get_id(Partner),
                        type = ?OBJ_PARTNER,
                        name = lib_partner:get_name(Partner),

                        parent_partner_no = lib_partner:get_no(Partner),

                        sendpid = null,
                        is_online = IsOnline,

                        side = Side,
                        pos = Pos,

                        race = lib_partner:get_race(Partner),
                        faction = lib_partner:get_faction(Partner),
                        sex = lib_partner:get_sex(Partner),
                        lv = lib_partner:get_lv(Partner),

                        when_spawn_round = lib_bt_comm:get_cur_round(),

                        is_auto_battle = IsAutoBattle,  % TODO：目前都设为不自动战斗， 以后如有离线竞技场之类的玩法，则需调整！

                        attrs = Attrs2,
                        init_attrs = InitAttrs,

                        initiative_skill_list = BoInitiaSkillBrfList,
                        passi_skill_list = BoPassiSkillBrfList,
                        ai_list = AIList,

                        is_main_partner = IsMainPartner,

                        showing_equips = lib_partner:get_showing_equips_base_setting(Partner),

                        par_extra = ParExtra,
      five_elements = Partner#partner.five_element
                        },

    ?BT_LOG(io_lib:format("ParNo:~p, partner showing equips:~w, BeHealEffCoef:~p~n",
                        [lib_partner:get_no(Partner), lib_partner:get_showing_equips_base_setting(Partner), lib_bo:get_be_heal_eff_coef(NewBo)])),
    % 应用被动技的效果
    NewBo2 = apply_passi_skill_effs_to_bo(PassiSkillList, NewBo),
    ?ASSERT(is_record(NewBo2, battle_obj), NewBo2),

    {NewBoId, NewBo2}.

cac_attrs_to_qujing(Attrs,Count,MaxHp,MaxMp,TrueHp,TrueMp) ->
	PhyAtt = util:ceil(Attrs#attrs.phy_att * Count)  ,
	MagAtt = util:ceil(Attrs#attrs.mag_att * Count)  ,
	PhyDef = util:ceil(Attrs#attrs.phy_def * Count) ,
	MagDef = util:ceil(Attrs#attrs.mag_def * Count) ,
	Crit  = util:ceil(Attrs#attrs.crit * Count) ,
	Ten   = util:ceil(Attrs#attrs.ten * Count) ,
	ActSpeed = util:ceil(Attrs#attrs.act_speed * Count) ,
	HealValue = util:ceil(Attrs#attrs.heal_value * Count) ,

	Attrs#attrs{ % 暂时都是初始化为满血满蓝
				 hp = TrueHp,
				 mp = TrueMp,
				 hp_lim = MaxHp,
				 mp_lim = MaxMp,
				 anger = ?ANGER_INIT,
				 anger_lim = ?ANGER_LIM,
				 phy_att = PhyAtt,
				 mag_att = MagAtt,
				 phy_def = PhyDef,
				 mag_def = MagDef,
				 crit = Crit ,
				 ten =  Ten ,
				 hit = 0,
				 dodge = 0   ,
				 act_speed =  ActSpeed ,
				 heal_value = HealValue
			   }.

%人物的属性
cac_attrs_to_qujing(Attrs,Count) ->
	PhyAtt = util:ceil(Attrs#attrs.phy_att * Count)  ,
	MagAtt = util:ceil(Attrs#attrs.mag_att * Count)  ,
	PhyDef = util:ceil(Attrs#attrs.phy_def * Count) ,
	MagDef = util:ceil(Attrs#attrs.mag_def * Count) ,
	Crit  = util:ceil(Attrs#attrs.crit * Count) ,
	Ten   = util:ceil(Attrs#attrs.ten * Count) ,
	ActSpeed = util:ceil(Attrs#attrs.act_speed * Count) ,
	HealValue = util:ceil(Attrs#attrs.heal_value * Count) ,

	Attrs#attrs{ % 暂时都是初始化为满血满蓝
				 anger = ?ANGER_INIT,
				 anger_lim = ?ANGER_LIM,
				 phy_att = PhyAtt,
				 mag_att = MagAtt,
				 phy_def = PhyDef,
				 mag_def = MagDef,
				 crit = Crit ,
				 ten =  Ten ,
				 hit = 0,
				 dodge = 0   ,
				 act_speed =  ActSpeed ,
				 heal_value = HealValue
			   }.


%% 生成离线宠物bo
generate_partner_bo_qujing(OfflineBo, [Side, Pos],TrueHp,TrueMp,MaxHp,MaxMp,IsMainPartner,NowPoint,Lv,OppLv) when is_record(OfflineBo, offline_bo) ->
    ?ASSERT(mod_offline_bo:is_partner(OfflineBo)),

    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),

    NewBoId = get_next_avail_bo_id(),

   % IsMainPartner = mod_offline_bo:is_main_partner(OfflineBo),
    % IsOnline = false,
    % IsAutoBattle = true,



    Attrs = mod_offline_bo:get_attrs(OfflineBo),

	BePhyDamR  = case  Attrs#attrs.be_phy_dam_reduce_coef >= 0.95 of
					 true -> Attrs#attrs.be_phy_dam_reduce_coef/3;
					 false -> Attrs#attrs.be_phy_dam_reduce_coef
				 end,
	BeMagDamR = case Attrs#attrs.be_mag_dam_reduce_coef >= 0.95 of
					true -> Attrs#attrs.be_mag_dam_reduce_coef/3;
					false -> Attrs#attrs.be_mag_dam_reduce_coef
				end,
	Attrs2 =case Lv - OppLv >= 10 of
				true ->
					CoeRoad = (data_qujing_battle_coef:get(NowPoint))#qujing_battle_coef.ratio_min,
					case NowPoint of
						1 -> cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						2 -> cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						3 ->  cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						4 ->  cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						5 ->  cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						6 ->  cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						7 -> cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						8 -> cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						9 -> cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						_ -> cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp)
					end;
				false ->
					CoeRoad = (data_qujing_battle_coef:get(NowPoint))#qujing_battle_coef.ratio_max,
					case NowPoint of
						1 -> cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						2 -> cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						3 ->  cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						4 ->  cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						5 ->  cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						6 ->  cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						7 -> cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						8 -> cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						9 -> cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp);
						_ -> cac_attrs_to_qujing(Attrs,CoeRoad,MaxHp,MaxMp,TrueHp,TrueMp)
					end
			end,
    InitAttrs = Attrs2#attrs{
							 be_phy_dam_reduce_coef = BePhyDamR,
							 be_mag_dam_reduce_coef = BeMagDamR,
							 hit = 0,
							 dodge = 0
					   },

    InitiaSkillList = mod_offline_bo:get_initiative_skill_list(OfflineBo),  %%%get_skill_list(OfflineBo),   %%lib_partner:get_initiative_skill_list(Partner), %%get_skill_list(Partner),
    %%%SkillList_Initia = lib_skill:pick_initiative_skill_list_from(InitiaSkillList),

    ?BT_LOG(io_lib:format("generate_partner_bo(), offline par bo PartnerId=~p, InitiaSkillList:~w~n", [mod_offline_bo:get_id(OfflineBo), InitiaSkillList])),
    BoInitiaSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiaSkillList],

    PassiSkillList = mod_offline_bo:get_passive_skill_list(OfflineBo),
    BoPassiSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiSkillList],

    AIList = mod_offline_bo:get_AI_list(OfflineBo),
    ?ASSERT(util:is_integer_list(AIList)),

    ParExtra = #par_bo_extra{
                    cultivate_lv = mod_offline_bo:get_par_cultivate_lv(OfflineBo),
                    cultivate_layer = mod_offline_bo:get_par_cultivate_layer(OfflineBo),
                    evolve_lv = mod_offline_bo:get_par_evolve_lv(OfflineBo),
                    nature = mod_offline_bo:get_par_nature(OfflineBo),
                    quality = mod_offline_bo:get_par_quality(OfflineBo),
					awake_illusion = lib_partner:get_awake_illusion(OfflineBo)
                    },

    NewBo = #battle_obj{
                        id = NewBoId,
                        parent_obj_id = mod_offline_bo:get_id(OfflineBo),
                        type = ?OBJ_PARTNER,
                        name = mod_offline_bo:get_name(OfflineBo),

                        parent_partner_no = mod_offline_bo:get_par_no(OfflineBo),

                        sendpid = null,
                        is_online = false,       % 固定为非在线
                        is_auto_battle = true,

                        side = Side,
                        pos = Pos,

                        race = mod_offline_bo:get_race(OfflineBo),
                        faction = mod_offline_bo:get_faction(OfflineBo),
                        sex = mod_offline_bo:get_sex(OfflineBo),
                        lv = mod_offline_bo:get_lv(OfflineBo),

                        when_spawn_round = lib_bt_comm:get_cur_round(),

                        attrs = Attrs2,
                        init_attrs = InitAttrs,

                        initiative_skill_list = BoInitiaSkillBrfList,
                        passi_skill_list = BoPassiSkillBrfList,
                        ai_list = AIList,

                        is_main_partner = IsMainPartner,

                        showing_equips = mod_offline_bo:get_showing_equips(OfflineBo),

                        par_extra = ParExtra,
                        five_elements = OfflineBo#offline_bo.par_property#par_prop.five_elment
                        },

    % 应用被动技的效果
    NewBo2 = apply_passi_skill_effs_to_bo(PassiSkillList, NewBo),
    ?ASSERT(is_record(NewBo2, battle_obj), NewBo2),

    {NewBoId, NewBo2}.


decide_mon_init_hp_mp(BMonTpl, ExtraInfo, OldAttrs) ->
    case lib_Bmon_tpl:is_world_boss(BMonTpl) of
        true ->
            {_, WorldBossHp} = proplists:lookup(world_boss_hp, ExtraInfo),
            ?ASSERT(util:is_positive_int(WorldBossHp), WorldBossHp),
            ?BT_LOG(io_lib:format("decide_mon_init_hp_mp(), WorldBossHp:~p~n", [WorldBossHp])),
            {WorldBossHp, OldAttrs#attrs.mp};
        false ->
			case lists:keyfind(guild_dungeon_boss_hp, 1, ExtraInfo) of
				{guild_dungeon_boss_hp,Hp} ->
					{Hp, OldAttrs#attrs.mp};
				false ->
					{OldAttrs#attrs.hp, OldAttrs#attrs.mp}
			end

    end.



%% 生成怪物战斗对象 -DUAN
generate_monster_bo(BtlMonNo, AttrRandomRange,AttrStreng,[Side, Pos], ExtraInfo) ->
    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),

    BMonTpl = lib_Bmon_tpl:get_tpl_data(BtlMonNo),
    ?TRACE("generate_monster_bo(), BMonTpl:~p~n", [BMonTpl]),
    ?ASSERT(BMonTpl /= null, BtlMonNo),

    ?Ifc (BMonTpl == null)
        ?ERROR_MSG("generate_monster_bo() failed!! battle mon not exists! BtlMonNo:~p", [BtlMonNo])
    ?End,

    NewBoId = get_next_avail_bo_id(),

    IsPlotBo =  case proplists:lookup(is_plot_bo, ExtraInfo) of
                    none -> false;
                    {_, _Val1} -> ?ASSERT(is_boolean(_Val1)), _Val1
                end,
    CanBeCtrled =   case proplists:lookup(can_be_ctrled, ExtraInfo) of
                        none -> false;
                        {_, _Val2} -> ?ASSERT(is_boolean(_Val2)), _Val2
                    end,
    BMonGroupNo =   case proplists:lookup(bmon_group_no, ExtraInfo) of
                        none -> ?INVALID_NO;
                        {_, _Val3} -> ?ASSERT(is_integer(_Val3)), _Val3
                    end,

    MonLv = case proplists:lookup(bmon_lv, ExtraInfo) of
        none -> ?INVALID_NO;
        {_, Lv} -> ?ASSERT(is_integer(Lv)), Lv
    end,

    %%IsOnline = true,   % 如果为离线战斗，则有可能为false，暂时固定写为true
    RefAttrData = data_ref_attr:get(BMonTpl#battle_mon.ref),

    Attrs = lib_Bmon_tpl:make_attrs_rd_from(RefAttrData,AttrRandomRange,AttrStreng),

    {InitHp, InitMp} = decide_mon_init_hp_mp(BMonTpl, ExtraInfo, Attrs),
    Attrs2 = Attrs#attrs{
                hp = InitHp,
                mp = InitMp,
                hp_lim = InitHp,
                mp_lim = InitMp
                },

    % 记录初始值（计算被动技或主动技buff的百分比效果时，以这些初始值作为乘法的基数）
    InitAttrs = Attrs2,

    InitiaSkillList = lib_Bmon_tpl:get_initiative_skill_list(BMonTpl,MonLv),
    BoInitiaSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiaSkillList],

    PassiSkillList = lib_Bmon_tpl:get_passive_skill_list(BMonTpl,MonLv),
    BoPassiSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiSkillList],

    AIList = lib_Bmon_tpl:get_AI_list(BMonTpl,MonLv),
    ?ASSERT(util:is_integer_list(AIList)),

    % todo: 暂时没考虑普通boss
    BoType = case lib_Bmon_tpl:is_world_boss(BMonTpl) of
                true -> ?OBJ_WORLD_BOSS;
                false -> ?OBJ_MONSTER
            end,

    NewBo = #battle_obj{
                        id = NewBoId,
                        parent_obj_id = BtlMonNo,

                        look_idx = util:rand(1, lib_Bmon_tpl:get_action_res_count(BMonTpl)),

                        type = BoType,

                        name = lib_Bmon_tpl:get_name(BMonTpl),

                        sendpid = null,
                        is_online = false,   % 怪物固定认为非在线

                        side = Side,
                        pos = Pos,

                        is_plot_bo = IsPlotBo,
                        can_be_ctrled = CanBeCtrled,

                        race = lib_Bmon_tpl:get_race(BMonTpl),
                        faction = lib_Bmon_tpl:get_faction(BMonTpl),
                        sex = lib_Bmon_tpl:get_sex(BMonTpl),
                        lv = case MonLv of
                            ?INVALID_NO ->
                            lib_Bmon_tpl:get_lv(BMonTpl);
                            _ -> MonLv
                        end,

                        when_spawn_round = lib_bt_comm:get_cur_round(),

                        is_auto_battle = true,  % 怪物固定是自动战斗！

                        attrs = Attrs2,
                        init_attrs = InitAttrs,

                        initiative_skill_list = BoInitiaSkillBrfList,
                        passi_skill_list = BoPassiSkillBrfList,
                        ai_list = AIList,
                        bmon_group_no = BMonGroupNo,
                        has_fallen_prep_status = lib_Bmon_tpl:has_fallen_prep_status(BMonTpl),
                        five_elements =  {BMonTpl#battle_mon.five_elements,0}
                        },

    ?DEBUG_MSG("NewBo look ~p",[NewBo#battle_obj.look_idx]),
    % 应用被动技的效果
    NewBo2 = apply_passi_skill_effs_to_bo(PassiSkillList, NewBo),
    ?ASSERT(is_record(NewBo2, battle_obj), NewBo2),

    {NewBoId, NewBo2}.


%% 生成怪物战斗对象
generate_monster_bo(BtlMonNo, [Side, Pos], ExtraInfo) ->
    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),

    BMonTpl = lib_Bmon_tpl:get_tpl_data(BtlMonNo),
    ?TRACE("generate_monster_bo(), BMonTpl:~p~n", [BMonTpl]),
    ?ASSERT(BMonTpl /= null, BtlMonNo),

    ?Ifc (BMonTpl == null)
        ?ERROR_MSG("generate_monster_bo() failed!! battle mon not exists! BtlMonNo:~p", [BtlMonNo])
    ?End,

    NewBoId = get_next_avail_bo_id(),

    IsPlotBo =  case proplists:lookup(is_plot_bo, ExtraInfo) of
                    none -> false;
                    {_, _Val1} -> ?ASSERT(is_boolean(_Val1)), _Val1
                end,
    CanBeCtrled =   case proplists:lookup(can_be_ctrled, ExtraInfo) of
                        none -> false;
                        {_, _Val2} -> ?ASSERT(is_boolean(_Val2)), _Val2
                    end,
    BMonGroupNo =   case proplists:lookup(bmon_group_no, ExtraInfo) of
                        none -> ?INVALID_NO;
                        {_, _Val3} -> ?ASSERT(is_integer(_Val3)), _Val3
                    end,

    MonLv = lib_Bmon_tpl:get_lv(BMonTpl),

    %%IsOnline = true,   % 如果为离线战斗，则有可能为false，暂时固定写为true
    RefAttrData = data_ref_attr:get(BMonTpl#battle_mon.ref),
    Attrs = lib_Bmon_tpl:make_attrs_rd_from(RefAttrData),

    {InitHp, InitMp} = decide_mon_init_hp_mp(BMonTpl, ExtraInfo, Attrs),
    Attrs2 = Attrs#attrs{
                hp = InitHp,
                mp = InitMp,
                hp_lim = InitHp,
                mp_lim = InitMp
                },

    % 记录初始值（计算被动技或主动技buff的百分比效果时，以这些初始值作为乘法的基数）
    InitAttrs = Attrs2,

    InitiaSkillList = lib_Bmon_tpl:get_initiative_skill_list(BMonTpl,MonLv),
    BoInitiaSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiaSkillList],

    PassiSkillList = lib_Bmon_tpl:get_passive_skill_list(BMonTpl,MonLv),
    BoPassiSkillBrfList = [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiSkillList],

    AIList = lib_Bmon_tpl:get_AI_list(BMonTpl,MonLv),
    ?ASSERT(util:is_integer_list(AIList)),

    % todo: 暂时没考虑普通boss
    BoType = case lib_Bmon_tpl:is_world_boss(BMonTpl) of
                true -> ?OBJ_WORLD_BOSS;
                false -> ?OBJ_MONSTER
            end,

    NewBo = #battle_obj{
                        id = NewBoId,
                        parent_obj_id = BtlMonNo,

                        look_idx = util:rand(1, lib_Bmon_tpl:get_action_res_count(BMonTpl)),

                        type = BoType,

                        name = lib_Bmon_tpl:get_name(BMonTpl),

                        sendpid = null,
                        is_online = false,   % 怪物固定认为非在线

                        side = Side,
                        pos = Pos,

                        is_plot_bo = IsPlotBo,
                        can_be_ctrled = CanBeCtrled,

                        race = lib_Bmon_tpl:get_race(BMonTpl),
                        faction = lib_Bmon_tpl:get_faction(BMonTpl),
                        sex = lib_Bmon_tpl:get_sex(BMonTpl),
                        lv = lib_Bmon_tpl:get_lv(BMonTpl),

                        when_spawn_round = lib_bt_comm:get_cur_round(),

                        is_auto_battle = true,  % 怪物固定是自动战斗！

                        attrs = Attrs2,
                        init_attrs = InitAttrs,

                        initiative_skill_list = BoInitiaSkillBrfList,
                        passi_skill_list = BoPassiSkillBrfList,
                        ai_list = AIList,
                        bmon_group_no = BMonGroupNo,
                        has_fallen_prep_status = lib_Bmon_tpl:has_fallen_prep_status(BMonTpl),
      five_elements = {BMonTpl#battle_mon.five_elements,0}
                        },

    ?DEBUG_MSG("NewBo look ~p",[NewBo#battle_obj.look_idx]),
    % 应用被动技的效果
    NewBo2 = apply_passi_skill_effs_to_bo(PassiSkillList, NewBo),
    ?ASSERT(is_record(NewBo2, battle_obj), NewBo2),

    {NewBoId, NewBo2}.


apply_passi_skill_effs_to_bo([], Bo) ->
    Bo;
apply_passi_skill_effs_to_bo([PassiSkl | T], Bo) ->
    Bo2 = apply_one_passi_skill_effs_to_bo(PassiSkl, Bo),
    apply_passi_skill_effs_to_bo(T, Bo2).



%% 应用单个被动技的一或多个被动效果到bo
apply_one_passi_skill_effs_to_bo(PassiSkl, Bo) when is_record(PassiSkl, skl_brief) ->
    SklId = PassiSkl#skl_brief.id,
    apply_one_passi_skill_effs_to_bo(SklId, Bo);
apply_one_passi_skill_effs_to_bo(SklId, Bo) when is_integer(SklId) ->
    ?ASSERT(mod_skill:is_valid_skill_id(SklId), SklId),
    case mod_skill:get_cfg_data(SklId) of
        null ->
            ?ERROR_MSG("[lib_bt_misc] apply_one_passi_skill_effs_to_bo() error!! skill not exists!! SklId:~p", [SklId]),
            Bo;
        SklCfg ->
            ?ASSERT(mod_skill:is_passive(SklCfg), {SklCfg, Bo}),
            ?DEBUG_MSG("wjctestbattle ~p~n",[{SklId}]),
            PassiEffNoList = mod_skill:get_passive_effs(SklCfg),
            ?BT_LOG(io_lib:format("apply_one_passi_skill_effs_to_bo(), SklId:~p, PassiEffNoList:~w~n", [SklId, PassiEffNoList])),
            apply_one_passi_skill_effs_to_bo__(SklId, PassiEffNoList, Bo)
    end.




apply_one_passi_skill_effs_to_bo__(_SklId, [], Bo) ->
    Bo;
apply_one_passi_skill_effs_to_bo__(SklId, [PassiEffNo | T], Bo) ->
    Bo2 = apply_one_passi_eff_to_bo(Bo, SklId, PassiEffNo),
    apply_one_passi_skill_effs_to_bo__(SklId, T, Bo2).




apply_one_passi_eff_to_bo(Bo, SklId, PassiEffNo) ->
    PassiEff = lib_passi_eff:get_cfg_data(PassiEffNo),
    case PassiEff of
        null ->
            ?ASSERT(false, PassiEffNo),
            ?ERROR_MSG("[lib_bt_misc] apply_one_passi_eff_to_bo() error! passi eff not exists!! PassiEffNo:~p", [PassiEffNo]),
            Bo;
        _ ->
            BoLv = Bo#battle_obj.lv,
            apply_one_passi_eff_to_bo(PassiEff#passi_eff.name, Bo, SklId, PassiEff, BoLv)
    end.




apply_one_passi_eff_to_bo(?EN_ADD_HP_LIM, Bo, _SklId, _PassiEff, _BoLv) ->
    Bo;    % 目前不需做处理，直接返回Bo

apply_one_passi_eff_to_bo(?EN_ADD_PHY_ATT, Bo, _SklId, PassiEff, BoLv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, ?ATTR_PHY_ATT),
    % OldVal = Bo#battle_obj.attrs#attrs.phy_att,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{phy_att = NewVal},


    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_PHY_ATT, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


apply_one_passi_eff_to_bo(?EN_ADD_ACT_SPEED_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->
  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_ACT_SPEED_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_ACT_SPEED_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->
  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_ACT_SPEED_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_MAG_DEF_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->
  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_MAG_DEF_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_ADD_MAG_DEF_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->
  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_MAG_DEF_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_PHY_DEF_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->
  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_PHY_DEF_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_ADD_PHY_DEF_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->
  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_PHY_DEF_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_MAG_ATT_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->
  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_MAG_ATT_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_ADD_MAG_ATT_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->
  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_MAG_ATT_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_PHY_ATT_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->
  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_PHY_ATT_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_ADD_PHY_ATT_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->
  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_PHY_ATT_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;


apply_one_passi_eff_to_bo(?EN_REDUCE_HP_LIM_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->
  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_HP_LIM_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_ADD_HP_LIM_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->
  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_HP_LIM_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;






apply_one_passi_eff_to_bo(?EN_ADD_MAG_ATT, Bo, _SklId, PassiEff, BoLv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, ?ATTR_MAG_ATT),
    % OldVal = Bo#battle_obj.attrs#attrs.mag_att,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{mag_att = NewVal},

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_MAG_ATT, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;



apply_one_passi_eff_to_bo(?EN_ADD_PHY_DEF, Bo, _SklId, PassiEff, BoLv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, ?ATTR_PHY_DEF),
    % OldVal = Bo#battle_obj.attrs#attrs.phy_def,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{phy_def = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_PHY_DEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_MAG_DEF, Bo, _SklId, PassiEff, BoLv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, ?ATTR_MAG_DEF),
    % OldVal = Bo#battle_obj.attrs#attrs.mag_def,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{mag_def = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_MAG_DEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_NEGLECT_RER_DAM, Bo, _SklId, PassiEff, BoLv) ->
  % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, ?ATTR_MAG_DEF),
  % OldVal = Bo#battle_obj.attrs#attrs.mag_def,
  % NewVal = OldVal + AddVal,
  % NewAttrs = Bo#battle_obj.attrs#attrs{mag_def = NewVal},
  % Bo#battle_obj{attrs = NewAttrs};

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_NEGLECT_RER_DAM, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;



apply_one_passi_eff_to_bo(?EN_ADD_ACT_SPEED, Bo, _SklId, PassiEff, BoLv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, ?ATTR_ACT_SPEED),
    % OldVal = Bo#battle_obj.attrs#attrs.act_speed,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{act_speed = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_ACT_SPEED, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_REDUCE_ACT_SPEED, Bo, _SklId, PassiEff, BoLv) ->
    % ReduceVal = calc_passi_eff_reduce_value(PassiEff, BoLv, ?ATTR_ACT_SPEED),
    % OldVal = Bo#battle_obj.attrs#attrs.act_speed,
    % NewVal = max(OldVal - ReduceVal, 0),  % max矫正一下，避免为负值
    % NewAttrs = Bo#battle_obj.attrs#attrs{act_speed = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_ACT_SPEED, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


apply_one_passi_eff_to_bo(?EN_ADD_HIT, Bo, _SklId, PassiEff, BoLv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, ?ATTR_HIT),
    % OldVal = Bo#battle_obj.attrs#attrs.hit,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{hit = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_HIT, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_DODGE, Bo, _SklId, PassiEff, BoLv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, ?ATTR_DODGE),
    % OldVal = Bo#battle_obj.attrs#attrs.dodge,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{dodge = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_DODGE, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_CRIT, Bo, _SklId, PassiEff, BoLv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, ?ATTR_CRIT),
    % OldVal = Bo#battle_obj.attrs#attrs.crit,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{crit = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_CRIT, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_PHY_CRIT, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_PHY_CRIT, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_PHY_CRIT, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_PHY_CRIT, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_ADD_MAG_CRIT, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_MAG_CRIT, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_MAG_CRIT, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_MAG_CRIT, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_ADD_PHY_TEN, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_PHY_TEN, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_PHY_TEN, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_PHY_TEN, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;


apply_one_passi_eff_to_bo(?EN_ADD_MAG_TEN, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_MAG_TEN, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_MAG_TEN, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_MAG_TEN, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_ADD_SEAL_HIT, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_SEAL_HIT, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_ADD_SEAL_HIT_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_SEAL_HIT_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_SEAL_HIT_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_SEAL_HIT_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_ADD_SEAL_RESIS, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_SEAL_RESIS, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_ADD_SEAL_RESIS_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_SEAL_RESIS_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_SEAL_RESIS_BY_RATE, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_SEAL_RESIS_BY_RATE, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;


apply_one_passi_eff_to_bo(?EN_ADD_NEGLECT_SEAL_RESIS, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_NEGLECT_SEAL_RESIS, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;



apply_one_passi_eff_to_bo(?EN_ADD_TEN, Bo, _SklId, PassiEff, BoLv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, ?ATTR_TEN),
    % OldVal = Bo#battle_obj.attrs#attrs.ten,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{ten = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_TEN, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_CHAOS_RESIS, Bo, _SklId, PassiEff, BoLv) ->
    % AttrName = ?ATTR_SEAL_RESIS,   % 取标准值时， 统一对应取封印抗性
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, AttrName),
    % OldVal = Bo#battle_obj.attrs#attrs.chaos_resis,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{chaos_resis = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_CHAOS_RESIS, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_TRANCE_RESIS, Bo, _SklId, PassiEff, BoLv) ->
    % AttrName = ?ATTR_SEAL_RESIS,   % 取标准值时， 统一对应取封印抗性
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, AttrName),
    % OldVal = Bo#battle_obj.attrs#attrs.trance_resis,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{trance_resis = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_TRANCE_RESIS, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_FROZEN_RESIS, Bo, _SklId, PassiEff, BoLv) ->
    % AttrName = ?ATTR_SEAL_RESIS,   % 取标准值时， 统一对应取封印抗性
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, AttrName),
    % OldVal = Bo#battle_obj.attrs#attrs.frozen_resis,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{frozen_resis = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_FROZEN_RESIS, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_SEAL_RESIS, Bo, _SklId, PassiEff, BoLv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, BoLv, ?ATTR_SEAL_RESIS),
    % OldVal = Bo#battle_obj.attrs#attrs.seal_resis,
    % NewVal = OldVal + AddVal,
    % NewAttrs = Bo#battle_obj.attrs#attrs{seal_resis = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_SEAL_RESIS, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;



apply_one_passi_eff_to_bo(?EN_ADD_STRIKEBACK_PROBA, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, PassiEff),

    % OldVal = Bo#battle_obj.attrs#attrs.strikeback_proba,
    % NewVal = min(OldVal + Para, ?PROBABILITY_BASE),  % 做min矫正，避免溢出
    % NewAttrs = Bo#battle_obj.attrs#attrs{strikeback_proba = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_STRIKEBACK_PROBA, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_PHY_COMBO_ATT_PROBA, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, PassiEff),

    % OldVal = Bo#battle_obj.attrs#attrs.combo_att_proba,
    % NewVal = min(OldVal + Para, ?PROBABILITY_BASE),  % 做min矫正，避免溢出
    % NewAttrs = Bo#battle_obj.attrs#attrs{combo_att_proba = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_PHY_COMBO_ATT_PROBA, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_MAG_COMBO_ATT_PROBA, Bo, _SklId, PassiEff, BoLv) ->
    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_MAG_COMBO_ATT_PROBA, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


apply_one_passi_eff_to_bo(?EN_ADD_PURSUE_ATT_PROBA, Bo, _SklId, PassiEff, BoLv) ->
    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_PURSUE_ATT_PROBA, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_RET_DAM_PROBA, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, PassiEff),

    % OldVal = Bo#battle_obj.attrs#attrs.ret_dam_proba,
    % NewVal = min(OldVal + Para, ?PROBABILITY_BASE),  % 做min矫正，避免溢出
    % NewAttrs = Bo#battle_obj.attrs#attrs{ret_dam_proba = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->

            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_RET_DAM_PROBA, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


apply_one_passi_eff_to_bo(?EN_ADD_BE_HEAL_EFF_COEF, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0, PassiEff),

    % OldVal = Bo#battle_obj.be_heal_eff_coef,
    % NewVal = OldVal + Para,
    % Bo#battle_obj{be_heal_eff_coef = NewVal};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_BE_HEAL_EFF_COEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_ADD_HEAL_EFF_COEF, Bo, _SklId, PassiEff, BoLv) ->
  % Para = PassiEff#passi_eff.para,
  % ?ASSERT(Para > 0, PassiEff),

  % OldVal = Bo#battle_obj.be_heal_eff_coef,
  % NewVal = OldVal + Para,
  % Bo#battle_obj{be_heal_eff_coef = NewVal};

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_HEAL_EFF_COEF, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;


apply_one_passi_eff_to_bo(?EN_REDUCE_HEAL_EFF_COEF, Bo, _SklId, PassiEff, BoLv) ->

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_HEAL_EFF_COEF, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;


apply_one_passi_eff_to_bo(?EN_ADD_REVIVE_HEAL_COEF, Bo, _SklId, PassiEff, BoLv) ->
  % Para = PassiEff#passi_eff.para,
  % ?ASSERT(Para > 0, PassiEff),

  % OldVal = Bo#battle_obj.be_heal_eff_coef,
  % NewVal = OldVal + Para,
  % Bo#battle_obj{be_heal_eff_coef = NewVal};

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_REVIVE_HEAL_COEF, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_PURSUE_ATT_DAM_COEF, Bo, _SklId, PassiEff, BoLv) ->
  % Para = PassiEff#passi_eff.para,
  % ?ASSERT(Para > 0, PassiEff),

  % OldVal = Bo#battle_obj.be_heal_eff_coef,
  % NewVal = OldVal + Para,
  % Bo#battle_obj{be_heal_eff_coef = NewVal};

  case is_player(Bo) orelse is_partner(Bo) of
    true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
      Bo;
    false ->
      OldAttrs = Bo#battle_obj.attrs,
      NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_PURSUE_ATT_DAM_COEF, OldAttrs, PassiEff, BoLv),
      Bo#battle_obj{attrs = NewAttrs}
  end;

apply_one_passi_eff_to_bo(?EN_REDUCE_BE_HEAL_EFF_COEF, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    % OldVal = Bo#battle_obj.be_heal_eff_coef,
    % NewVal = max(OldVal - Para, 0),  % 做max矫正，避免为负值
    % Bo#battle_obj{be_heal_eff_coef = NewVal};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_BE_HEAL_EFF_COEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;





apply_one_passi_eff_to_bo(?EN_ADD_DO_PHY_DAM_SCALING, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0, PassiEff),

    % OldVal = Bo#battle_obj.attrs#attrs.do_phy_dam_scaling,
    % NewVal = OldVal + Para,
    % NewAttrs = Bo#battle_obj.attrs#attrs{do_phy_dam_scaling = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_DO_PHY_DAM_SCALING, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


apply_one_passi_eff_to_bo(?EN_ADD_DO_MAG_DAM_SCALING, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0, PassiEff),

    % OldVal = Bo#battle_obj.attrs#attrs.do_mag_dam_scaling,
    % NewVal = OldVal + Para,
    % NewAttrs = Bo#battle_obj.attrs#attrs{do_mag_dam_scaling = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_DO_MAG_DAM_SCALING, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


apply_one_passi_eff_to_bo(?EN_ADD_DO_DAM_SCALING, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0, PassiEff),

    % OldVal1 = Bo#battle_obj.attrs#attrs.do_phy_dam_scaling,
    % OldVal2 = Bo#battle_obj.attrs#attrs.do_mag_dam_scaling,

    % NewVal1 = OldVal1 + Para,
    % NewVal2 = OldVal2 + Para,
    % NewAttrs = Bo#battle_obj.attrs#attrs{
    %                         do_phy_dam_scaling = NewVal1,
    %                         do_mag_dam_scaling = NewVal2
    %                         },
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_DO_DAM_SCALING, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;






apply_one_passi_eff_to_bo(?EN_REDUCE_DO_PHY_DAM_SCALING, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    % OldVal = Bo#battle_obj.attrs#attrs.do_phy_dam_scaling,
    % NewVal = max(OldVal - Para, 0),  % 做max矫正，避免为负值
    % NewAttrs = Bo#battle_obj.attrs#attrs{do_phy_dam_scaling = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_DO_PHY_DAM_SCALING, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


apply_one_passi_eff_to_bo(?EN_REDUCE_DO_MAG_DAM_SCALING, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    % OldVal = Bo#battle_obj.attrs#attrs.do_mag_dam_scaling,
    % NewVal = max(OldVal - Para, 0),  % 做max矫正，避免为负值
    % NewAttrs = Bo#battle_obj.attrs#attrs{do_mag_dam_scaling = NewVal},
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_DO_MAG_DAM_SCALING, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


apply_one_passi_eff_to_bo(?EN_REDUCE_DO_DAM_SCALING, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    % OldVal1 = Bo#battle_obj.attrs#attrs.do_phy_dam_scaling,
    % OldVal2 = Bo#battle_obj.attrs#attrs.do_mag_dam_scaling,

    % NewVal1 = max(OldVal1 - Para, 0),  % 做max矫正，避免为负值
    % NewVal2 = max(OldVal2 - Para, 0),  % 做max矫正，避免为负值
    % NewAttrs = Bo#battle_obj.attrs#attrs{
    %                         do_phy_dam_scaling = NewVal1,
    %                         do_mag_dam_scaling = NewVal2
    %                         },
    % Bo#battle_obj{attrs = NewAttrs};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_DO_DAM_SCALING, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;






apply_one_passi_eff_to_bo(?EN_ADD_BE_PHY_DAM_REDUCE_COEF, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    % OldVal = Bo#battle_obj.be_phy_dam_reduce_coef,
    % NewVal = min(OldVal + Para, 1),  % 做矫正，避免溢出
    % Bo#battle_obj{be_phy_dam_reduce_coef = NewVal};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_BE_PHY_DAM_REDUCE_COEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


apply_one_passi_eff_to_bo(?EN_ADD_BE_MAG_DAM_REDUCE_COEF, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    % OldVal = Bo#battle_obj.be_mag_dam_reduce_coef,
    % NewVal = min(OldVal + Para, 1),  % 做矫正，避免溢出
    % Bo#battle_obj{be_mag_dam_reduce_coef = NewVal};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_BE_MAG_DAM_REDUCE_COEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


apply_one_passi_eff_to_bo(?EN_ADD_BE_DAM_REDUCE_COEF, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    % OldVal1 = Bo#battle_obj.be_phy_dam_reduce_coef,
    % OldVal2 = Bo#battle_obj.be_mag_dam_reduce_coef,

    % NewVal1 = min(OldVal1 + Para, 1),  % 做矫正，避免溢出
    % NewVal2 = min(OldVal2 + Para, 1),  % 做矫正，避免溢出
    % Bo#battle_obj{
    %         be_phy_dam_reduce_coef = NewVal1,
    %         be_mag_dam_reduce_coef = NewVal2
    %         };

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_BE_DAM_REDUCE_COEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


apply_one_passi_eff_to_bo(?EN_REDUCE_BE_PHY_DAM_REDUCE_COEF, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0, PassiEff),

    % OldVal = Bo#battle_obj.be_phy_dam_reduce_coef,
    % NewVal = OldVal - Para,
    % Bo#battle_obj{be_phy_dam_reduce_coef = NewVal};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_BE_PHY_DAM_REDUCE_COEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


apply_one_passi_eff_to_bo(?EN_REDUCE_BE_MAG_DAM_REDUCE_COEF, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0, PassiEff),

    % OldVal = Bo#battle_obj.be_mag_dam_reduce_coef,
    % NewVal = OldVal - Para,
    % Bo#battle_obj{be_mag_dam_reduce_coef = NewVal};

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_BE_MAG_DAM_REDUCE_COEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

apply_one_passi_eff_to_bo(?EN_REDUCE_BE_DAM_REDUCE_COEF, Bo, _SklId, PassiEff, BoLv) ->
    % Para = PassiEff#passi_eff.para,
    % ?ASSERT(Para > 0, PassiEff),

    % OldVal1 = Bo#battle_obj.be_phy_dam_reduce_coef,
    % OldVal2 = Bo#battle_obj.be_mag_dam_reduce_coef,
    % NewVal1 = OldVal1 - Para,
    % NewVal2 = OldVal2 - Para,
    % Bo#battle_obj{
    %         be_phy_dam_reduce_coef = NewVal1,
    %         be_mag_dam_reduce_coef = NewVal2
    %         };

    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_REDUCE_BE_DAM_REDUCE_COEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;





%% 提升物理连击次数上限
apply_one_passi_eff_to_bo(?EN_ADD_MAX_PHY_COMBO_ATT_TIMES, Bo, _SklId, PassiEff, _BoLv) ->
    AddVal = PassiEff#passi_eff.para,
    ?ASSERT(util:is_positive_int(AddVal), PassiEff),
    OldVal = Bo#battle_obj.max_phy_combo_att_times,
    NewVal = OldVal + AddVal,
    Bo#battle_obj{max_phy_combo_att_times = NewVal};




%% 提升法术连击次数上限
apply_one_passi_eff_to_bo(?EN_ADD_MAX_MAG_COMBO_ATT_TIMES, Bo, _SklId, PassiEff, _BoLv) ->
    AddVal = PassiEff#passi_eff.para,
    ?ASSERT(util:is_positive_int(AddVal), PassiEff),
    OldVal = Bo#battle_obj.max_mag_combo_att_times,
    NewVal = OldVal + AddVal,
    Bo#battle_obj{max_mag_combo_att_times = NewVal};


%% 提升追击次数上限
apply_one_passi_eff_to_bo(?EN_ADD_MAX_PURSUE_ATT_TIMES, Bo, _SklId, PassiEff, _BoLv) ->
    AddVal = PassiEff#passi_eff.para,
    ?ASSERT(util:is_positive_int(AddVal), PassiEff),
    OldVal = Bo#battle_obj.max_pursue_att_times,
    NewVal = OldVal + AddVal,
    Bo#battle_obj{max_pursue_att_times = NewVal};


%% 提升反震系数
apply_one_passi_eff_to_bo(?EN_ADD_RET_DAM_COEF, Bo, _SklId, PassiEff, BoLv) ->
    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            % AddVal = PassiEff#passi_eff.para,
            % OldVal = Bo#battle_obj.attrs#attrs.ret_dam_coef,
            % NewVal = OldVal + AddVal,
            % NewAttrs = Bo#battle_obj.attrs#attrs{ret_dam_coef = NewVal},
            % Bo#battle_obj{attrs = NewAttrs}

            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_RET_DAM_COEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;

%% 提升追击伤害系数
apply_one_passi_eff_to_bo(?EN_ADD_PURSUE_ATT_DAM_COEF, Bo, _SklId, PassiEff, BoLv) ->
    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_PURSUE_ATT_DAM_COEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


%% 提升吸血系数
apply_one_passi_eff_to_bo(?EN_ADD_ABSORB_HP_COEF, Bo, _SklId, PassiEff, BoLv) ->
    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            % AddVal = PassiEff#passi_eff.para,
            % OldVal = Bo#battle_obj.attrs#attrs.absorb_hp_coef,
            % NewVal = OldVal + AddVal,
            % NewAttrs = Bo#battle_obj.attrs#attrs{absorb_hp_coef = NewVal},
            % Bo#battle_obj{attrs = NewAttrs}

            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_ABSORB_HP_COEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;


%% 提升驱鬼系数
apply_one_passi_eff_to_bo(?EN_ADD_QUGUI_COEF, Bo, _SklId, PassiEff, BoLv) ->
    case is_player(Bo) orelse is_partner(Bo) of
        true -> % 对于玩家或宠物，在战斗外已经应用过效果了，故这里不需再应用
            Bo;
        false ->
            % AddVal = PassiEff#passi_eff.para,
            % OldVal = Bo#battle_obj.attrs#attrs.qugui_coef,
            % NewVal = OldVal + AddVal,
            % NewAttrs = Bo#battle_obj.attrs#attrs{qugui_coef = NewVal},
            % Bo#battle_obj{attrs = NewAttrs}

            OldAttrs = Bo#battle_obj.attrs,
            NewAttrs = lib_passi_eff:calc_one_passi_eff(?EN_ADD_QUGUI_COEF, OldAttrs, PassiEff, BoLv),
            Bo#battle_obj{attrs = NewAttrs}
    end;



%% 添加鬼魂预备状态
apply_one_passi_eff_to_bo(?EN_ADD_GHOST_PREP_STATUS, Bo, _SklId, PassiEff, _BoLv) ->
    ?ASSERT(0 < PassiEff#passi_eff.para andalso PassiEff#passi_eff.para =< 1, PassiEff),
    ?ASSERT(util:is_positive_int(PassiEff#passi_eff.para2), PassiEff),

    case lib_bo:has_ghost_prep_status(Bo)
    orelse lib_bo:has_reborn_prep_status(Bo) of
        true ->
            Bo;
        false ->
            NewEff = #bo_peff{
                            eff_no = PassiEff#passi_eff.no,
                            eff_name = PassiEff#passi_eff.name,
                            hp_rate_on_revive = util:minmax(PassiEff#passi_eff.para, 0, 1),
                            wait_revive_round_count = PassiEff#passi_eff.para2
                            },
            NewEffList = [NewEff | Bo#battle_obj.passi_effs],
            Bo#battle_obj{passi_effs = NewEffList}
    end;


%% 添加重生预备状态
apply_one_passi_eff_to_bo(?EN_ADD_REBORN_PREP_STATUS, Bo, _SklId, PassiEff, _BoLv) ->
    ?ASSERT(0 < PassiEff#passi_eff.para andalso PassiEff#passi_eff.para =< 1, PassiEff),
    ?ASSERT(util:is_positive_int(PassiEff#passi_eff.para2), PassiEff),

    case lib_bo:has_reborn_prep_status(Bo) of
        true ->
            Bo;
        false ->
            Bo2 =   case lib_bo:has_ghost_prep_status(Bo) of
                        true ->
                            % 重生预备状态会屏蔽鬼魂预备状态
                            TmpNewPassiEffList = lists:keydelete(?EN_ADD_GHOST_PREP_STATUS, #bo_peff.eff_name, Bo#battle_obj.passi_effs),
                            Bo#battle_obj{passi_effs = TmpNewPassiEffList};
                        false ->
                            Bo
                    end,

            NewEff = #bo_peff{
                            eff_no = PassiEff#passi_eff.no,
                            eff_name = PassiEff#passi_eff.name,
                            hp_rate_on_revive = util:minmax(PassiEff#passi_eff.para, 0, 1),
                            reborn_proba = PassiEff#passi_eff.para2
                            },
            NewEffList = [NewEff | Bo2#battle_obj.passi_effs],
            Bo2#battle_obj{passi_effs = NewEffList}
    end;



%% 添加隐身状态
apply_one_passi_eff_to_bo(?EN_ADD_INVISIBLE_STATUS, Bo, _SklId, PassiEff, _BoLv) ->
    ?ASSERT(util:is_positive_int(PassiEff#passi_eff.para), PassiEff),
    ExpireRound = lib_bt_comm:get_cur_round() + erlang:round(PassiEff#passi_eff.para),  % 做四舍五入取整是为了容错
    NewEff = #bo_peff{
                    eff_no = PassiEff#passi_eff.no,
                    eff_name = PassiEff#passi_eff.name,
                    expire_round = ExpireRound
                    },
    NewEffList = [NewEff | Bo#battle_obj.passi_effs],
    Bo#battle_obj{passi_effs = NewEffList};


%% 添加死亡支援状态
apply_one_passi_eff_to_bo(?EN_DIE_TRRIGER_SUPPORT, Bo, _SklId, PassiEff, _BoLv) ->
  ?ASSERT(util:is_positive_int(PassiEff#passi_eff.para), PassiEff),
  ExpireRound = lib_bt_comm:get_cur_round() + erlang:round(PassiEff#passi_eff.para),  % 做四舍五入取整是为了容错
  NewEff = #bo_peff{
    trigger_proba = PassiEff#passi_eff.para2,
    eff_no = PassiEff#passi_eff.no,
    eff_name = PassiEff#passi_eff.name,
    expire_round = ExpireRound
  },
  NewEffList = [NewEff | Bo#battle_obj.passi_effs],
  Bo#battle_obj{passi_effs = NewEffList};



%% 添加BUFF
apply_one_passi_eff_to_bo(?EN_ADD_BUFF, Bo, SklId, PassiEff, _BoLv) ->
    ?ASSERT(util:is_positive_int(PassiEff#passi_eff.para), PassiEff),
    BuffNo = PassiEff#passi_eff.para,
    ProbValue = case PassiEff#passi_eff.para2 of
        null -> 1000;
        Prob_ when is_integer(Prob_) -> Prob_;
        _ -> 1000
    end,

    Count = case PassiEff#passi_eff.para3 of
        null -> 1;
        Count_ when is_integer(Count_) -> Count_;
        _ -> 1
    end,

    add_buff_by_start_battle(Count,Bo,ProbValue,SklId,BuffNo);


%% 添加隐身状态
apply_one_passi_eff_to_bo(?EN_ADD_ANTI_INVISIBLE_STATUS, Bo, _SklId, PassiEff, _BoLv) ->
    NewEff = #bo_peff{
                    eff_no = PassiEff#passi_eff.no,
                    eff_name = PassiEff#passi_eff.name
                    },
    NewEffList = [NewEff | Bo#battle_obj.passi_effs],
    Bo#battle_obj{passi_effs = NewEffList};


%% 添加驱鬼状态
apply_one_passi_eff_to_bo(?EN_ADD_QUGUI_STATUS, Bo, _SklId, PassiEff, _BoLv) ->
    NewEff = #bo_peff{
                    eff_no = PassiEff#passi_eff.no,
                    eff_name = PassiEff#passi_eff.name
                    },
    NewEffList = [NewEff | Bo#battle_obj.passi_effs],
    Bo#battle_obj{passi_effs = NewEffList};

%% 添加防“反转伤害”状态 ： 所有对其使用的几率性反转伤害的物理技能被强制更改为普通伤害。
apply_one_passi_eff_to_bo(?EN_ADD_PREVENT_INVERSE_DAM_STATUS, Bo, _SklId, PassiEff, _BoLv) ->
    NewEff = #bo_peff{
                    eff_no = PassiEff#passi_eff.no,
                    eff_name = PassiEff#passi_eff.name
                    },
    NewEffList = [NewEff | Bo#battle_obj.passi_effs],
    Bo#battle_obj{passi_effs = NewEffList};

% %% 设定追击时的伤害衰减系数
% apply_one_passi_eff_to_bo(?EN_SET_DAM_REDUCE_COEF_ON_PURSUE_ATT, Bo, _SklId, PassiEff, _BoLv) ->
%     ?ASSERT(0 < PassiEff#passi_eff.para andalso PassiEff#passi_eff.para < 1, PassiEff),
%     Bo#battle_obj{dam_reduce_coef_on_pursue_att = PassiEff#passi_eff.para};


%% 隐身时降低物理伤害放缩系数
apply_one_passi_eff_to_bo(?EN_REDUCE_DO_PHY_DAM_SCALING_WHEN_INVISIBLE, Bo, _SklId, PassiEff, _BoLv) ->
    ?ASSERT(0 < PassiEff#passi_eff.para andalso PassiEff#passi_eff.para =< 1, PassiEff),
    NewEff = #bo_peff{
                    eff_no = PassiEff#passi_eff.no,
                    eff_name = PassiEff#passi_eff.name,
                    do_phy_dam_scaling_reduce = util:minmax(PassiEff#passi_eff.para, 0, 1)  % 矫正以容错
                    },
    NewEffList = [NewEff | Bo#battle_obj.passi_effs],
    Bo#battle_obj{passi_effs = NewEffList};

% 物理命中添加BUFF
apply_one_passi_eff_to_bo(?EN_ADD_BUFF_ON_PHY_ATT_HIT, Bo, SklId, PassiEff, _BoLv) ->
    apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);

% 血量低于多少百分比时触发buff
apply_one_passi_eff_to_bo(?EN_ADD_BUFF_ON_HP_LOW, Bo, SklId, PassiEff, _BoLv) ->
  apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);

% 法术命中添加BUFF
apply_one_passi_eff_to_bo(?EN_ADD_BUFF_ON_MAG_ATT_HIT, Bo, SklId, PassiEff, _BoLv) ->
    apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);

% 被物理命中添加BUFF
apply_one_passi_eff_to_bo(?EN_ADD_BUFF_ON_BE_PHY_ATT_HIT, Bo, SklId, PassiEff, _BoLv) ->
    apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);

% 被法术命中添加BUFF
apply_one_passi_eff_to_bo(?EN_ADD_BUFF_ON_BE_MAG_ATT_HIT, Bo, SklId, PassiEff, _BoLv) ->
    apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);


% 回合开始时友方存活单位数量
apply_one_passi_eff_to_bo(?EN_ADD_BUFF_BEGIN_FRIEND_SURVIVAL, Bo, SklId, PassiEff, _BoLv) ->
  apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);

% 回合开始时敌方存活单位数量
apply_one_passi_eff_to_bo(?EN_ADD_BUFF_BEGIN_ENEMY_SURVIVAL, Bo, SklId, PassiEff, _BoLv) ->
  apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);

% 自身行动时友方存活单位数量
apply_one_passi_eff_to_bo(?EN_ADD_BUFF_ACTION_FRIEND_SURVIVAL, Bo, SklId, PassiEff, _BoLv) ->
  apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);

% 自身行动时敌方存活单位数量
apply_one_passi_eff_to_bo(?EN_ADD_BUFF_ACTION_ENEMY_SURVIVAL, Bo, SklId, PassiEff, _BoLv) ->
  apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);

apply_one_passi_eff_to_bo(?EN_ENEMY_WHILE_DIE, Bo, SklId, PassiEff, _BoLv) ->
  apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);

apply_one_passi_eff_to_bo(?EN_FRIEND_WHILE_DIE, Bo, SklId, PassiEff, _BoLv) ->
  apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);

apply_one_passi_eff_to_bo(?EN_SELF_WHILE_DIE, Bo, SklId, PassiEff, _BoLv) ->
  apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);

apply_one_passi_eff_to_bo(?EN_BUFF_ARRIVE_LAYER, Bo, SklId, PassiEff, _BoLv) ->
  apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);


apply_one_passi_eff_to_bo(?EN_REDUCE_ANGER_ON_PHY_ATT_HIT, Bo, _SklId, _PassiEff, _BoLv) ->
    Bo;

apply_one_passi_eff_to_bo(?EN_REDUCE_ANGER_ON_MAG_ATT_HIT, Bo, _SklId, _PassiEff, _BoLv) ->
    Bo;

% 所有攻击命中添加BUFF
apply_one_passi_eff_to_bo(?EN_ADD_BUFF_ON_ATT_HIT, Bo, SklId, PassiEff, _BoLv) ->
    apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);

% 被所有攻击命中添加BUFF
apply_one_passi_eff_to_bo(?EN_ADD_BUFF_ON_BE_ATT_HIT, Bo, SklId, PassiEff, _BoLv) ->
    apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff);


%% hot: 回血
apply_one_passi_eff_to_bo(?EN_HOT_HP, Bo, _SklId, PassiEff, _BoLv) ->
    apply_hot_passi_eff_to_bo(Bo, PassiEff);

%% hot: 回蓝
apply_one_passi_eff_to_bo(?EN_HOT_MP, Bo, _SklId, PassiEff, _BoLv) ->
    apply_hot_passi_eff_to_bo(Bo, PassiEff);

apply_one_passi_eff_to_bo(?EN_HOT_PHY_ATT, Bo, _SklId, PassiEff, _BoLv) ->
    apply_hot_passi_eff_to_bo(Bo, PassiEff);


apply_one_passi_eff_to_bo(?EN_HOT_MAG_ATT, Bo, _SklId, PassiEff, _BoLv) ->
    apply_hot_passi_eff_to_bo(Bo, PassiEff);

apply_one_passi_eff_to_bo(?EN_LENGTHEN_GOOD_BUFF_LASTING_ROUND, Bo, _SklId, PassiEff, _BoLv) ->
    apply_change_buff_lasting_round_passi_eff_to_bo(Bo, PassiEff);

apply_one_passi_eff_to_bo(?EN_SHORTEN_BAD_BUFF_LASTING_ROUND, Bo, _SklId, PassiEff, _BoLv) ->
    apply_change_buff_lasting_round_passi_eff_to_bo(Bo, PassiEff);

apply_one_passi_eff_to_bo(?EN_FORCE_CHANGE_GOOD_BUFF_LASTING_ROUND, Bo, _SklId, PassiEff, _BoLv) ->
    apply_change_buff_lasting_round_passi_eff_to_bo(Bo, PassiEff);

apply_one_passi_eff_to_bo(?EN_FORCE_CHANGE_BAD_BUFF_LASTING_ROUND, Bo, _SklId, PassiEff, _BoLv) ->
    apply_change_buff_lasting_round_passi_eff_to_bo(Bo, PassiEff);


apply_one_passi_eff_to_bo(_Other, Bo, _SklId, _PassiEff, _BoLv) ->  % 有些被动效果是在战斗中应用的，这里不处理 zhangwq
    %%?ASSERT(false, {_Other, _PassiEff}),
    % ?ERROR_MSG("[lib_bt_misc] apply_one_passi_eff_to_bo() error!!! _Other:~p, _PassiEff:~w, Bo:~w", [_Other, _PassiEff, Bo]),
    Bo.


%%修改为效果对象根据筛选规则来 2019.9.18 wjc
apply_add_buff_on_att_hit_passi_eff_to_bo(Bo, SklId, PassiEff) ->
  BuffNo = PassiEff#passi_eff.para,
  TriggerProba = PassiEff#passi_eff.para2,
  Target = PassiEff#passi_eff.para3,

  ?ASSERT(lib_buff:is_buff_no_valid(BuffNo), PassiEff),
  ?ASSERT(util:is_positive_int(TriggerProba), PassiEff),

  case lib_buff:is_buff_no_valid(BuffNo) of
    false ->  % 容错
      ?ERROR_MSG("[lib_bt_misc] invalid buff no!! BuffNo:~p, PassiEff:~w", [BuffNo, PassiEff]),
      Bo;
    true ->
      NewEff = #bo_peff{
        eff_no = PassiEff#passi_eff.no,
        eff_name = PassiEff#passi_eff.name,
        from_skill_id = SklId,
        buff_no = BuffNo,
        trigger_proba = TriggerProba,
        target_for_add_buff = Target,
        op = PassiEff#passi_eff.op,
        rules_filter_target =  PassiEff#passi_eff.rules_filter_target,
        rules_sort_target = PassiEff#passi_eff.rules_sort_target,
        target_count =  PassiEff#passi_eff.target_count,
        trigger_times = PassiEff#passi_eff.para4,
        judge_type = PassiEff#passi_eff.para5,
        judge_action_moment = PassiEff#passi_eff.para6
      },
      NewEffList = [NewEff | Bo#battle_obj.passi_effs],
      Bo#battle_obj{passi_effs = NewEffList}
  end.

apply_add_buff_on_kill_bo(SklId, PassiEff) ->
  BuffNo = PassiEff#passi_eff.para,
  TriggerProba = PassiEff#passi_eff.para2,
  Target = PassiEff#passi_eff.para3,

  ?ASSERT(lib_buff:is_buff_no_valid(BuffNo), PassiEff),
  ?ASSERT(util:is_positive_int(TriggerProba), PassiEff),

  case lib_buff:is_buff_no_valid(BuffNo) of
    false ->  % 容错
      [];
    true ->
      NewEff = #bo_peff{
        eff_no = PassiEff#passi_eff.no,
        eff_name = PassiEff#passi_eff.name,
        from_skill_id = SklId,
        buff_no = BuffNo,
        trigger_proba = TriggerProba,
        target_for_add_buff = Target,
        op = PassiEff#passi_eff.op,
        rules_filter_target =  PassiEff#passi_eff.rules_filter_target,
        rules_sort_target = PassiEff#passi_eff.rules_sort_target,
        target_count =  PassiEff#passi_eff.target_count,
        trigger_times = PassiEff#passi_eff.para4,
        judge_type = PassiEff#passi_eff.para5,
        judge_action_moment = PassiEff#passi_eff.para6
      }
  end.


apply_hot_passi_eff_to_bo(Bo, PassiEff) ->
    ?ASSERT(PassiEff#passi_eff.para > 0, PassiEff),
    NewEff = #bo_peff{
                    eff_no = PassiEff#passi_eff.no,
                    eff_name = PassiEff#passi_eff.name
                    },
    NewEffList = [NewEff | Bo#battle_obj.passi_effs],
    Bo#battle_obj{passi_effs = NewEffList}.



apply_change_buff_lasting_round_passi_eff_to_bo(Bo, PassiEff) ->
    ?ASSERT(util:is_nonnegative_int(PassiEff#passi_eff.para), PassiEff),
    NewEff = #bo_peff{
                    eff_no = PassiEff#passi_eff.no,
                    eff_name = PassiEff#passi_eff.name
                    },
    NewEffList = [NewEff | Bo#battle_obj.passi_effs],
    Bo#battle_obj{passi_effs = NewEffList}.




% calc_passi_eff_add_value(PassiEff, BoLv, AttrName) ->
%     Para = PassiEff#passi_eff.para,
%     ?ASSERT(Para > 0, PassiEff),
%     StdVal = mod_xinfa:get_std_value(BoLv, AttrName), % 将bo等级当做心法等级，取对应的标准值
%     AddVal = erlang:round(Para * StdVal),
%     ?ASSERT(AddVal >= 0, {AddVal, Para, StdVal, PassiEff}),
%     AddVal.



% calc_passi_eff_reduce_value(PassiEff, BoLv, AttrName) ->
%     Para = PassiEff#passi_eff.para,
%     ?ASSERT(Para > 0, PassiEff),
%     StdVal = mod_xinfa:get_std_value(BoLv, AttrName), % 将bo等级当做心法等级，取对应的标准值
%     ReduceVal = erlang:round(Para * StdVal),
%     ?ASSERT(ReduceVal >= 0, {ReduceVal, Para, StdVal, PassiEff}),
%     ReduceVal.




% %% offline_bo结构体转为partner结构体
% to_partner_rd(Src) when is_record(Src, offline_bo) ->
%     ?ASSERT(mod_offline_bo:is_partner(Src)),


%     #partner{
%         id = mod_offline_bo:get_id(),
%         no = mod_offline_bo:get_par_no(),
%         name = mod_offline_bo:get_name(),

%         attrs = mod_offline_bo:get_attrs(),


%         race
%         faction
%         sex
%         lv

%         skills =

%         loyalty

%         quality


%         }.



build_bo_info_bin(Bo) ->
    NameBin = lib_bo:get_name(Bo),
    ShowingEqs = lib_bo:get_showing_equips(Bo),

    ParExtra_Bin = build_partner_bo_extra_bin(Bo),
    IsMainPar = lib_bt_comm:is_main_partner(Bo),
    IsPlotBo = lib_bt_comm:is_plot_bo(Bo),
    CanBeCtrled = lib_bo:can_be_ctrled(Bo),

    ?BT_LOG(io_lib:format("build_bo_info_bin(), Side:~p, BoId:~p, Type:~p, IsMainPar:~p, pos:~p, Anger:~p~n", [lib_bo:get_side(Bo), lib_bo:id(Bo), lib_bo:get_type(Bo), IsMainPar, lib_bo:get_pos(Bo), lib_bo:get_anger(Bo)])),

    {IsInvisible, InvisibleExpireRound} =
            case lib_bo:is_invisible(Bo) of
                true -> {true, lib_bo:get_invisible_expire_round(Bo)};
                false -> {false, 0}
            end,

    UserDefTitle = lib_bo:get_user_def_title(Bo),

    F = fun(Buff) ->
            <<
                (lib_bo_buff:get_no(Buff)) : 32,
                (lib_bo_buff:get_expire_round(Buff)) : 16
            >>
        end,
    BuffsInfo_List = [F(X) || X <- lib_bo:get_buff_list(Bo)],
    BuffsInfo_Bin = list_to_binary(BuffsInfo_List),
  {FiveElement, _} = Bo#battle_obj.five_elements,


    % Id = lib_bo:get_id(Bo),
    % Type = lib_bo:get_type(Bo),

    % Pos = lib_bo:get_pos(Bo),

    % Sex = lib_bo:get_sex(Bo),

    % Race = lib_bo:get_race(Bo),
    % Faction = lib_bo:get_faction(Bo),
    % Lv = lib_bo:get_lv(Bo),
    % ParentObjId = lib_bo:get_parent_obj_id(Bo),
    % Hp = lib_bo:get_hp(Bo),
    % HpLim = lib_bo:get_hp_lim(Bo),
    % Mp = lib_bo:get_mp(Bo),
    % MpLim = lib_bo:get_mp_lim(Bo),
    % Anger = lib_bo:get_anger(Bo),
    % AngerLim = lib_bo:get_anger_lim(Bo),

    LookIdx = case is_monster(Bo) of
        true ->
            lib_bo:get_look_idx(Bo);
        false ->
            0
    end,

    WingNo = lib_wing:get_use_wing_no(lib_bo:get_parent_obj_id(Bo)),

    <<
        (lib_bo:get_id(Bo)) : 16,
        (lib_bo:get_type(Bo)) : 8,
        (lib_bo:get_my_owner_player_bo_id(Bo)) : 16,
        (lib_bo:get_pos(Bo)) : 8,
        (byte_size(NameBin)) : 16,
        NameBin /binary,
        (lib_bo:get_sex(Bo)) : 8,
        (lib_bo:get_race(Bo)) : 8,
        (lib_bo:get_faction(Bo)) : 8,
        (lib_bo:get_lv(Bo)) : 16,
        (lib_bo:get_parent_obj_id(Bo)) : 64,
        (lib_bo:get_parent_partner_no(Bo)) : 32,
        (lib_bo:get_hp(Bo)) : 32,
        (lib_bo:get_hp_lim(Bo)) : 32,
        (lib_bo:get_mp(Bo)) : 32,
        (lib_bo:get_mp_lim(Bo)) : 32,
        (lib_bo:get_anger(Bo)) : 32,
        (lib_bo:get_anger_lim(Bo)) : 32,
        (ShowingEqs#showing_equip.weapon) : 32,
        (ShowingEqs#showing_equip.headwear) : 32,
        (ShowingEqs#showing_equip.clothes) : 32,
        (ShowingEqs#showing_equip.backwear) : 32,
        ParExtra_Bin / binary,
        (util:bool_to_oz(IsMainPar)) : 8,
        (util:bool_to_oz(IsInvisible)) : 8,
        InvisibleExpireRound : 16,
        (lib_bo:get_suit_no(Bo)) : 8,
        (lib_bo:get_graph_title(Bo)) : 32,
        (lib_bo:get_text_title(Bo)) : 32,
        ?P_BITSTR(UserDefTitle),
        (lib_bo:get_online_flag(Bo)) : 8,
        (util:bool_to_oz(IsPlotBo)) : 8,
        (util:bool_to_oz(CanBeCtrled)) : 8,
        (length(BuffsInfo_List)) : 16,
        BuffsInfo_Bin / binary,
        (ShowingEqs#showing_equip.magic_key) : 32,
        (lib_bo:get_phy_att(Bo)) :32,
        (lib_bo:get_mag_att(Bo)) :32,
        (lib_bo:get_phy_def(Bo)) :32,
        (lib_bo:get_mag_def(Bo)) :32,
        (lib_bo:get_heal_value(Bo)) :32,
        LookIdx : 8,
        (lib_bo:get_transfiguration_no(Bo)):32,
         WingNo:32,
      FiveElement:8
    >>.




%% 针对指定的bo，构造战斗简要信息结构体
build_battle_feedback_for_escaped_bo(Bo) ->
    State = lib_bt_comm:get_battle_state(),
    #btl_feedback{
            battle_type = State#btl_state.type,
            battle_subtype = State#btl_state.subtype,
            result = lose,  % 固定为失败
            oppo_player_id_list = lib_bo:get_my_pvp_oppo_player_id_list(Bo),
            callback = State#btl_state.callback
            }.





build_partner_bo_extra_bin(Bo) ->
    case lib_bt_comm:is_partner(Bo) of
        true ->
            ParExt = lib_bo:get_par_extra(Bo),
            <<
                (ParExt#par_bo_extra.cultivate_lv) : 8,
                (ParExt#par_bo_extra.cultivate_layer) : 8,
                (ParExt#par_bo_extra.evolve_lv) : 8,
                (ParExt#par_bo_extra.nature) : 8,
                (ParExt#par_bo_extra.quality) : 8,
				(ParExt#par_bo_extra.awake_illusion) : 8
            >>;
        false ->
            % 非宠物则统一为0
            <<
                0 : 8,
                0 : 8,
                0 : 8,
                0 : 8,
                0 : 8,
				0 : 8
            >>
    end.



% 递归方法
get_pos_bo(DeferSide,Pos,Count,L) ->
    case Count < 50 of
        true ->
            case lib_bt_comm:get_bo_by_pos(DeferSide, Pos) of
                null ->
                    % L = ?BATTLE_POS_ORDER_PER_SIDE,
                    RPos = util:rand(1,length(L)),
                    MPos = lists:nth(RPos, L),
                    get_pos_bo(DeferSide,MPos,Count + 1,L);
                Bo -> Bo
            end;
        false ->
            null
    end.

%% “策划所配置的站位”转为“服务器逻辑所用的站位”
cfg_pos_to_server_logic_pos(DeferSide,DefPos,Pos) ->
    ?DEBUG_MSG("Pos=~p",[Pos]),
    case Pos of
        ?INVALID_BATTLE_POS ->
            Pos;
        random ->
            L2 = ?BATTLE_POS_ORDER_PER_SIDE -- [DefPos],
            RPos = util:rand(1,length(L2)),
            MPos = lists:nth(RPos, L2),

            Bo = get_pos_bo(DeferSide,MPos,0,L2),
            case Bo of
                null -> Pos;
                _ -> lib_bo:get_pos(Bo)
            end;
        _ ->
            ?ASSERT(is_integer(Pos), Pos),
            ?ASSERT(Pos >= ?MIN_BATTLE_POS andalso Pos =< ?MAX_BATTLE_POS_PER_SIDE, Pos),
            L = ?BATTLE_POS_ORDER_PER_SIDE,
            lists:nth(Pos, L)
    end.

cfg_pos_to_server_logic_pos(Pos) ->
    ?DEBUG_MSG("Pos=~p",[Pos]),
    case Pos of
        ?INVALID_BATTLE_POS ->
            Pos;
        random ->
            L = ?BATTLE_POS_ORDER_PER_SIDE,
            RPos = util:rand(1,length(L)),
            lists:nth(RPos, L);
        _ ->
            ?ASSERT(is_integer(Pos), Pos),
            ?ASSERT(Pos >= ?MIN_BATTLE_POS andalso Pos =< ?MAX_BATTLE_POS_PER_SIDE, Pos),
            L = ?BATTLE_POS_ORDER_PER_SIDE,
            lists:nth(Pos, L)
    end.

%% “服务器逻辑所用的站位”转为“策划所配置的站位”
server_logic_pos_to_cfg_pos(Pos) ->
    case Pos of
        ?INVALID_BATTLE_POS ->
            Pos;
        _ ->
            ?ASSERT(is_integer(Pos), Pos),
            ?ASSERT(Pos >= ?MIN_BATTLE_POS andalso Pos =< ?MAX_BATTLE_POS_PER_SIDE, Pos),
            L = ?BATTLE_POS_ORDER_CFG_SIDE, % [9, 7, 6, 8, 10, 4, 2, 1, 4, 5]
            lists:nth(Pos, L)
    end.



%% @para: ExtraInfo => 形如：[{Key, Value}, ...]
%% @return: {ok, NewBo} | fail
add_one_monster(BtlMonNo, Side, Pos, ExtraInfo) ->
    %%Side = ?GUEST_SIDE, % 怪物固定是在客队方

    Pos2 =  case (Pos == ?INVALID_BATTLE_POS)
            orelse (lib_bt_comm:is_pos_occupied(Side, Pos)) of
                true -> find_first_empty_battle_pos_for_mon(Side);
                false -> Pos
            end,

    case Pos2 of
        null ->
            % ?ASSERT(false, {BtlMonNo, Side, Pos, ExtraInfo}),
            ?BT_LOG(io_lib:format("lib_bt_misc, add_one_monster fail for Pos2 is null, BtlMonNo:~p, Side:~p, Pos:~p, ExtraInfo:~p~n", [BtlMonNo, Side, Pos, ExtraInfo])),
            fail;   % 没空位了，不添加
        _ ->
            % 生成monster bo
            {NewBoId, NewBo} = generate_monster_bo(BtlMonNo, [Side, Pos2], ExtraInfo),

            lib_bt_dict:add_bo_to_battle_field(NewBoId, NewBo, Side),

            ?Ifc (not lib_bt_comm:is_plot_bo(NewBo))
                lib_bt_dict:add_to_spawned_bmon_list(BtlMonNo, 1)  % 记录战斗中已经刷出的战斗怪
            ?End,

            {ok, NewBo}
    end.

% 随机范围
add_one_monster(BtlMonNo, Side, Pos,AttrRandomRange,AttrStreng, ExtraInfo) ->
    % 找位置
    Pos2 =  case (Pos == ?INVALID_BATTLE_POS)
            orelse (lib_bt_comm:is_pos_occupied(Side, Pos)) of
                true -> find_first_empty_battle_pos_for_mon(Side);
                false -> Pos
            end,

    % 没有找到位置
    case Pos2 of
        null ->
            fail;   % 没空位了，不添加
        _ ->
            {NewBoId, NewBo} = generate_monster_bo(BtlMonNo, AttrRandomRange,AttrStreng,[Side, Pos2], ExtraInfo),

            lib_bt_dict:add_bo_to_battle_field(NewBoId, NewBo, Side),

            ?Ifc (not lib_bt_comm:is_plot_bo(NewBo))
                lib_bt_dict:add_to_spawned_bmon_list(BtlMonNo, 1)  % 记录战斗中已经刷出的战斗怪
            ?End,

            {ok, NewBo}
    end.


%% 查找第一个空闲的站位给怪物
find_first_empty_battle_pos_for_mon(Side) ->
    L = lib_bt_comm:get_bo_id_list(Side),
    %%?TRACE("LLLLLL: ~p~n", [L]),
    CurOccupyPosList = [lib_bo:get_pos(get_bo_by_id(BoId)) || BoId <- L],

    % ?BT_LOG(io_lib:format("lib_bt_misc, find_first_empty_battle_pos_for_mon(), L:~p, CurOccupyPosList:~p, DieStatus:~p~n",
    %             [L, CurOccupyPosList, [lib_bo:get_die_status(get_bo_by_id(X)) || X <- L]])),

    EmptyPosList = ?BATTLE_POS_ORDER_PER_SIDE -- CurOccupyPosList,

    case EmptyPosList == [] of
        true -> null;    % 位置已被占满，返回null
        false -> erlang:hd(EmptyPosList)
    end.



%% 添加宠物到战场后的额外处理
%% @para: IsMainPar => 是否为主宠
post_add_partner_to_battle_field(PartnerId, NewParBoId, OwnerPlayerBo, IsMainPar) ->
    ?ASSERT(is_integer(PartnerId)),
    OwnerPlayerBoId = lib_bo:id(OwnerPlayerBo),
    % PartnerId = lib_partner:get_id(ParObj),
    % 记录宠物bo对应所属的玩家bo
    lib_bo:set_my_owner_player_bo_id(NewParBoId, OwnerPlayerBoId),

    lib_bo:add_to_my_partner_bo_info_list(OwnerPlayerBoId, {NewParBoId, PartnerId}),

    lib_bo:add_to_my_already_joined_battle_par_list(OwnerPlayerBoId, PartnerId),

    case IsMainPar of
        true ->
            % 记录玩家bo对应的主宠bo
            lib_bo:set_my_main_partner_bo_id(OwnerPlayerBoId, NewParBoId);
        false ->
            skip
    end.



%% 从战场替换掉旧宠物后的额外处理
post_replace_old_par_from_battle_field(OldParBoId, OwnerPlayerBo) ->
    OwnerPlayerBoId = lib_bo:id(OwnerPlayerBo),
    lib_bo:remove_from_my_partner_bo_info_list(OwnerPlayerBoId, OldParBoId).







%% 刷怪方式
-define(SPAWN_MON_T_FIXED, 1).   % 固定
-define(SPAWN_MON_T_RANDOM, 2).  % 随机


%% 从战斗怪物组中挑选怪物
%% @return: [{战斗怪编号，战斗位置}, ...]
pick_mon_from_group(BMonGroup, PickCount) ->
    MonPoolFixed = BMonGroup#bmon_group.mon_pool_fixed,
    case BMonGroup#bmon_group.spawn_mon_type of
        ?SPAWN_MON_T_FIXED ->
            ?ASSERT(BMonGroup#bmon_group.mon_pool_fixed /= []),
            MonPoolFixed;
        ?SPAWN_MON_T_RANDOM ->
            FixedCount = length(MonPoolFixed),
            LeftCount = PickCount - FixedCount,
            case LeftCount > 0 of
                true ->
                    ?TRACE("try more_pick_mon_from_group(), LeftCount = ~p~n", [LeftCount]),
                    % old: more_pick_mon_from_group(rare, BMonGroup, LeftCount, MonPoolFixed);

                    MorePickedMonL = more_pick_mon_from_group(BMonGroup, LeftCount),
                    MonPoolFixed ++ MorePickedMonL;
                false ->
                    MonPoolFixed
            end
    end.


%% 刷怪概率的基数，因目前刷怪概率的下限是十万分之一，故基数设为十万
-define(SPAWN_MON_PROBA_BASE, 100000).


more_pick_mon_from_group(BMonGroup, PickCount) ->
    MonPoolList_NonNormal = BMonGroup#bmon_group.mon_pool_elite ++ BMonGroup#bmon_group.mon_pool_chief ++ BMonGroup#bmon_group.mon_pool_rare,
    WeightList = [tool:to_integer(Proba * ?SPAWN_MON_PROBA_BASE) || {_BtlMonNo, Proba} <- MonPoolList_NonNormal],

    % 先挑出非普通怪
    TryTimes = PickCount,
    PickedMonList_NonNormal = [do_more_pick_mon_from_group_once(MonPoolList_NonNormal, WeightList) || _X <- lists:duplicate(TryTimes, dummy)],
    PickedMonList_NonNormal_2 = [X || X <- PickedMonList_NonNormal, X /= invalid],

    case length(PickedMonList_NonNormal_2) >= PickCount of
        true ->
            PickedMonList_NonNormal_2;
        false ->
            % 不足的，再补充挑出普通怪
            LeftCount = PickCount - length(PickedMonList_NonNormal_2),
            PickedMonList_Normal = more_pick_mon_from_group(normal, BMonGroup, LeftCount),
            PickedMonList_NonNormal_2 ++ PickedMonList_Normal
    end.



do_more_pick_mon_from_group_once(MonPoolList, WeightList) ->
    case util:rand_pick_one_by_weight(WeightList, ?SPAWN_MON_PROBA_BASE) of
        -1 ->
            invalid;
        Nth ->
            {BtlMonNo, _Proba} = lists:nth(Nth, MonPoolList),
            {BtlMonNo, ?INVALID_BATTLE_POS}
    end.


%% 最后，进一步挑选普通怪
more_pick_mon_from_group(normal, BMonGroup, PickCount) ->
    MonPoolNormal = BMonGroup#bmon_group.mon_pool_normal,
    case MonPoolNormal of
        [] ->
            [];
        _ ->
            PickedMonList_Normal = more_pick_normal_mon_from_group__(PickCount, MonPoolNormal, []),
            PickedMonList_Normal
    end.


more_pick_normal_mon_from_group__(0, _MonPoolNormal, AccMonList_Picked) ->
    AccMonList_Picked;
more_pick_normal_mon_from_group__(PickCount, MonPoolNormal, AccMonList_Picked) ->
    Count = length(MonPoolNormal),
    Rand = util:rand(1, Count),
    MonNoPicked = lists:nth(Rand, MonPoolNormal),
    ?ASSERT(is_integer(MonNoPicked), MonNoPicked),
    more_pick_normal_mon_from_group__(PickCount - 1, MonPoolNormal, [{MonNoPicked, ?INVALID_BATTLE_POS} | AccMonList_Picked]).




add_buff_by_start_battle(0,Bo,_ProbValue,_SklId,_BuffNo) ->
    Bo;

    % 增加添加多个BUFF
add_buff_by_start_battle(Count1,Bo3,ProbValue,SklId,BuffNo) ->
    case Count1 > 0 of
        true ->
            Prob = util:minmax(ProbValue/1000, 0, 1),
            case util:decide_proba_once(Prob) of
                success ->
                    BoId = lib_bo:get_id(Bo3),

                    % 由于这个时候还没有写入的进程字段所以会获取不到 就只能提前写入先了
                    lib_bt_comm:update_bo(Bo3),
                    lib_bo:add_buff(BoId, BoId, BuffNo, SklId, 1),
                    Bo4 = get_bo_by_id(BoId),
                    lib_bt_comm:update_bo(Bo4),

                    add_buff_by_start_battle(Count1 - 1,Bo4,ProbValue,SklId,BuffNo);
                fail -> Bo3
            end;
        false ->
            Bo3
    end.





% pick_mon_by_proba__({BtlMonNo, Proba}, AccMonList_Picked) ->
%             ?ASSERT(0 < Proba andalso Proba =< 1),
%             ?ASSERT(Proba >= (1 / ?SPAWN_MON_PROBA_BASE), {BtlMonNo, Proba, AccMonList_Picked}),
%             case util:decide_proba_once(Proba, ?SPAWN_MON_PROBA_BASE) of
%                 success ->
%                     AccMonList_Picked ++ [{BtlMonNo, ?INVALID_BATTLE_POS}];
%                 fail ->
%                     AccMonList_Picked
%             end.


% %% 进一步挑选稀有怪
% more_pick_mon_from_group(rare, BMonGroup, PickCount, AccMonList_Picked) ->
%     MonPoolRare = BMonGroup#bmon_group.mon_pool_rare,

%     RareMonList_Picked = lists:foldl(fun pick_mon_by_proba__/2, [], MonPoolRare),
%     ?TRACE("RareMonList_Picked=~p~n", [RareMonList_Picked]),

%     case length(RareMonList_Picked) >= PickCount of
%         true ->
%             AccMonList_Picked ++ lists:sublist(RareMonList_Picked, PickCount);
%         false ->
%             LeftCount = PickCount - length(RareMonList_Picked),
%             more_pick_mon_from_group(elite, BMonGroup, LeftCount, AccMonList_Picked ++ RareMonList_Picked)
%     end;

% %% 进一步挑选精英怪
% more_pick_mon_from_group(elite, BMonGroup, PickCount, AccMonList_Picked) ->
%     MonPoolElite = BMonGroup#bmon_group.mon_pool_elite,

%     EliteMonList_Picked = lists:foldl(fun pick_mon_by_proba__/2, [], MonPoolElite),
%     ?TRACE("EliteMonList_Picked=~p~n", [EliteMonList_Picked]),

%     case length(EliteMonList_Picked) >= PickCount of
%         true ->
%             AccMonList_Picked ++ lists:sublist(EliteMonList_Picked, PickCount);
%         false ->
%             LeftCount = PickCount - length(EliteMonList_Picked),
%             more_pick_mon_from_group(chief, BMonGroup, LeftCount, AccMonList_Picked ++ EliteMonList_Picked)
%     end;

% %% 进一步挑选头领怪
% more_pick_mon_from_group(chief, BMonGroup, PickCount, AccMonList_Picked) ->
%     MonPoolChief = BMonGroup#bmon_group.mon_pool_chief,

%     ChiefMonList_Picked = lists:foldl(fun pick_mon_by_proba__/2, [], MonPoolChief),
%     ?TRACE("ChiefMonList_Picked=~p~n", [ChiefMonList_Picked]),

%     case length(ChiefMonList_Picked) >= PickCount of
%         true ->
%             AccMonList_Picked ++ lists:sublist(ChiefMonList_Picked, PickCount);
%         false ->
%             LeftCount = PickCount - length(ChiefMonList_Picked),
%             more_pick_mon_from_group(normal, BMonGroup, LeftCount, AccMonList_Picked ++ ChiefMonList_Picked)
%     end;

% %% 最后，进一步挑选普通怪
% more_pick_mon_from_group(normal, BMonGroup, PickCount, AccMonList_Picked) ->
%     MonPoolNormal = BMonGroup#bmon_group.mon_pool_normal,

%     case MonPoolNormal of
%         [] ->
%             AccMonList_Picked;
%         _ ->
%             NormalMonList_Picked = more_pick_normal_mon_from_group__(PickCount, MonPoolNormal, []),
%             AccMonList_Picked ++ NormalMonList_Picked
%     end.






%% 构建buff的详情
build_buff_details(BuffOwner_BoId, BuffNo) when is_integer(BuffOwner_BoId) ->
    case get_bo_by_id(BuffOwner_BoId) of
        null ->
            % ?ASSERT(false, {BuffOwner_BoId, BuffNo}),
            ?DUMMY_BUFF_DETAILS;  % 返回伪详情，是为了容错（用于填充正确的二进制流消息包），下同
        Bo ->
            build_buff_details(Bo, BuffNo)
    end;

build_buff_details(BuffOwner, BuffNo) when is_record(BuffOwner, battle_obj) ->
    case lib_bo:find_buff_by_no(BuffOwner, BuffNo) of
        null ->
            ?DEBUG_MSG("[BATTLE] build_buff_details(), buff not exists!! BuffNo=~p, BuffOwner=~w, BattleState=~w", [BuffNo, BuffOwner, get_battle_state()]),
            ?DUMMY_BUFF_DETAILS;
        Buff ->
          ?DEBUG_MSG("wjctestbuff ~p ~n", [Buff]),
            % ?DEBUG_MSG("build_buff_details(), BuffNo:~p, Buff:~w, BuffOwner:~w", [BuffNo, Buff, BuffOwner]),
            ParaBin = case lib_bo_buff:can_overlap(Buff) of
                        true ->
                            % TODO: 对于可叠加buff， 构造参数信息！
                            <<0:8, 0:32, 0:8, 0:32>>;
                        false ->
                            <<0:8, 0:32, 0:8, 0:32>>
                    end,

            OverlapCount =  case lib_bo_buff:is_shield(Buff) of
                                true ->
                                    lib_bo_buff:get_shield_buff_layer(Buff);
                                false ->
                                    lib_bo_buff:get_cur_overlap(Buff)
                            end,

            <<
                BuffNo : 32,
                (lib_bo_buff:get_expire_round(Buff)) : 16,
                OverlapCount : 8,
                ParaBin / binary
            >>
    end.








%% ----------------------- 筛选战斗对象 -----------------------------------
%% ------------------ RDT: rules of deciding target -----------------------
%% @return: 所筛选出的bo id列表

%% 筛选：空结果
filter_bo_by_rule(?RDT_NONE, _Actor, _Src_TargetBoIdList) ->
    [];

%% 筛选：目标为自己
filter_bo_by_rule(?RDT_MYSELF, Actor, _Src_TargetBoIdList) ->
    ActorId = lib_bo:id(Actor),
    [ActorId];


filter_bo_by_rule(?RDT_NOT_MYSELF, Actor, Src_TargetBoIdList) ->
    ActorId = lib_bo:id(Actor),
    Src_TargetBoIdList -- [ActorId];

%% 筛选：目标为当前所攻击的目标
filter_bo_by_rule(?RDT_CUR_ATT_TARGET, Actor, _Src_TargetBoIdList) ->
    case lib_bo:get_cur_att_target(Actor) of
        ?INVALID_ID ->
            [];
        CurAttTarget_BoId ->
            ?ASSERT(is_integer(CurAttTarget_BoId), CurAttTarget_BoId),
          case get({cur_att_target,Actor#battle_obj.id}) of
            undefined ->
              [CurAttTarget_BoId];
            HaveAttTarget ->
              erase({cur_att_target,Actor#battle_obj.id}),
              HaveAttTarget
          end

    end;


%% 筛选：目标为当前嘲讽我的bo
filter_bo_by_rule(?RDT_HE_WHO_TAUNT_ME, Actor, _Src_TargetBoIdList) ->
    case lib_bo:get_he_who_taunt_me(Actor) of
        ?INVALID_ID ->
            [];
        BoId_HeWhoTauntMe ->
            ?ASSERT(is_integer(BoId_HeWhoTauntMe), BoId_HeWhoTauntMe),
            ?BT_LOG(io_lib:format("filter_bo_by_rule(), RDT_HE_WHO_TAUNT_ME, ActorId=~p, BoId_HeWhoTauntMe=~p~n", [lib_bo:id(Actor), BoId_HeWhoTauntMe])),
            [BoId_HeWhoTauntMe]
    end;


%% 筛选：筛选出当前回合所选的目标
filter_bo_by_rule(?RDT_CUR_PICK_TARGET, Actor, Src_TargetBoIdList) ->
    CurPickTarget_BoId = lib_bo:get_cur_pick_target(Actor),
    RetL = [X || X <- Src_TargetBoIdList, X == CurPickTarget_BoId],
    ?ASSERT(length(RetL) =< 1, {RetL, CurPickTarget_BoId, Src_TargetBoIdList, Actor}),
    ?BT_LOG(io_lib:format("filter_bo_by_rule(), RDT_CUR_PICK_TARGET, ActorId=~p, CurPickTarget_BoId=~p, Src_TargetBoIdList=~p, RetL=~p~n",
                    [lib_bo:id(Actor), CurPickTarget_BoId, Src_TargetBoIdList, RetL])),
    RetL;


%% 筛选出敌方的bo
filter_bo_by_rule(?RDT_ENEMY_SIDE, Actor, Src_TargetBoIdList) ->
    MySide = lib_bo:get_side(Actor),
    EnemySide = to_enemy_side(MySide),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_side(Bo) == EnemySide
        end,
    [X || X <- Src_TargetBoIdList, F(X)];


%% 筛选出我方的bo
filter_bo_by_rule(?RDT_ALLY_SIDE, Actor, Src_TargetBoIdList) ->
    MySide = lib_bo:get_side(Actor),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, {BoId, Actor}),
            lib_bo:get_side(Bo) == MySide
        end,
    [X || X <- Src_TargetBoIdList, F(X)];


%% 筛选出指定的某一方的bo （TODO： specific_side改为统一用宏 -- huangjf）
filter_bo_by_rule({specific_side, Side}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_side(Bo) == Side
        end,
    [X || X <- Src_TargetBoIdList, F(X)];



%% 筛选出已死亡的bo
filter_bo_by_rule(?RDT_DEAD, _Actor, Src_TargetBoIdList) ->
    [X || X <- Src_TargetBoIdList, is_dead(X)];


%% 筛选出未死亡的bo
filter_bo_by_rule(?RDT_UNDEAD, _Actor, Src_TargetBoIdList) ->
    [X || X <- Src_TargetBoIdList, is_living(X)];


%% 筛选出玩家bo
filter_bo_by_rule(?RDT_IS_PLAYER, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            is_player(Bo)
        end,
    [X || X <- Src_TargetBoIdList, F(X)];



%% 筛选出非玩家bo
filter_bo_by_rule(?RDT_IS_NOT_PLAYER, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not is_player(Bo)
        end,
    [X || X <- Src_TargetBoIdList, F(X)];


%% 筛选出宠物bo
filter_bo_by_rule(?RDT_IS_PARTNER, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            is_partner(Bo)
        end,
    [X || X <- Src_TargetBoIdList, F(X)];

%% 筛选出宠物bo
filter_bo_by_rule(?RDT_IS_NOT_PARTNER, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not is_partner(Bo)
        end,
    [X || X <- Src_TargetBoIdList, F(X)];





%% 筛选出怪物bo
filter_bo_by_rule(?RDT_IS_MONSTER, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            is_monster(Bo)
        end,
    [X || X <- Src_TargetBoIdList, F(X)];



filter_bo_by_rule(?RDT_IS_NOT_MONSTER, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not is_monster(Bo)
        end,
    [X || X <- Src_TargetBoIdList, F(X)];


%% 筛选出处于鬼魂状态的bo
filter_bo_by_rule(?RDT_IS_GHOST, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:in_ghost_status(Bo)
        end,
    [X || X <- Src_TargetBoIdList, F(X)];


%% 筛选出不处于鬼魂状态的bo
filter_bo_by_rule(?RDT_IS_NOT_GHOST, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:in_ghost_status(Bo)
        end,
    [X || X <- Src_TargetBoIdList, F(X)];


%% 筛选出处于倒地状态的bo
filter_bo_by_rule(?RDT_IS_FALLEN, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:in_fallen_status(Bo)
        end,
    [X || X <- Src_TargetBoIdList, F(X)];


%% 筛选出不处于倒地状态的bo
filter_bo_by_rule(?RDT_IS_NOT_FALLEN, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:in_fallen_status(Bo)
        end,
    [X || X <- Src_TargetBoIdList, F(X)];


%% 筛选出自己的主人bo（用于宠物）
filter_bo_by_rule(?RDT_MY_OWNER, Actor, Src_TargetBoIdList) ->
    case is_partner(Actor) of
        false ->  % 非宠物则统一返回空列表
            [];
        true ->
            F = fun(BoId) ->
                    BoId == lib_bo:get_my_owner_player_bo_id(Actor)
                end,
            RetL = [X || X <- Src_TargetBoIdList, F(X)],
            ?ASSERT(length(RetL) =< 1, {RetL, Actor}),
            RetL
    end;

%% 筛选出自己的配偶bo
filter_bo_by_rule(?RDT_SPOUSE, Actor, _Src_TargetBoIdList) ->
    case lib_bo:get_spouse_bo_id(Actor) of
        ?INVALID_ID ->
            [];
        SpouseBoId ->
            ?ASSERT(is_integer(SpouseBoId), SpouseBoId),
            case lib_bt_comm:is_bo_exists(SpouseBoId) of
                true ->
                    ?BT_LOG(io_lib:format("filter_bo_by_rule(), RDT_SPOUSE, ActorId=~p, SpouseBoId=~p~n", [lib_bo:id(Actor), SpouseBoId])),
                    [SpouseBoId];
                false ->
                    []
            end
    end;

%% 筛选出有隐身效果的bo
filter_bo_by_rule(?RDT_HAS_INVISIBLE_EFF, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:is_invisible(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


%% 筛选出没有隐身效果的bo
filter_bo_by_rule(?RDT_HAS_NOT_INVISIBLE_EFF, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:is_invisible(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

%% ---- 随机集火
filter_bo_by_rule(?RDT_SJJH_PRINCIPLE, _Actor, Src_TargetBoIdList) ->
    Src_TargetBoIdList;


%% 筛选出对自己而言隐身效果成立的bo
filter_bo_by_rule(?RDT_INVISIBLE_TO_ME, Actor, Src_TargetBoIdList) ->
    ActorId = lib_bo:id(Actor),
    CanAntiInvisible = lib_bo:can_anti_invisible(Actor),

    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            IsInvisibleToMe = (not CanAntiInvisible) andalso lib_bo:is_invisible(Bo),
            (BoId /= ActorId) andalso IsInvisibleToMe
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    ?BT_LOG(io_lib:format("filter_bo_by_rule(), RDT_INVISIBLE_TO_ME, RetL:~w~n", [RetL])),
    RetL;

%% 筛选出对自己而言隐身效果不成立的bo
filter_bo_by_rule(?RDT_NOT_INVISIBLE_TO_ME, Actor, Src_TargetBoIdList) ->
    ActorId = lib_bo:id(Actor),
    CanAntiInvisible = lib_bo:can_anti_invisible(Actor),

    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            IsInvisibleToMe = (not CanAntiInvisible) andalso lib_bo:is_invisible(Bo),
            (BoId /= ActorId) andalso (not IsInvisibleToMe)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    ?BT_LOG(io_lib:format("filter_bo_by_rule(), RDT_NOT_INVISIBLE_TO_ME, RetL:~w~n", [RetL])),
    RetL;

filter_bo_by_rule({?RDT_BELONG_TO_FACTION, Faction1}, _Actor, Src_TargetBoIdList) ->
    Faction =
    case Faction1 of
        {Fac} when is_integer(Fac) -> Fac;
        Fac1 when is_integer(Fac1) -> Fac1;
        _G -> 1
    end,

    ?ASSERT(lib_comm:is_valid_faction(Faction), Faction),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_faction(Bo) == Faction
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_HAS_SPEC_NO_BUFF, BuffNo}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_positive_int(BuffNo), BuffNo),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:has_spec_no_buff(Bo, BuffNo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule({?RDT_HAS_NOT_SPEC_NO_BUFF, BuffNo}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_positive_int(BuffNo), BuffNo),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:has_spec_no_buff(Bo, BuffNo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_HAS_SPEC_CATEGORY_BUFF, Category}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_positive_int(Category), Category),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:has_spec_category_buff(Bo, Category)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_HAS_SPEC_EFF_TYPE_BUFF, EffType}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(EffType == good orelse EffType == bad orelse EffType == neutral, EffType),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:has_spec_eff_type_buff(Bo, EffType)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_HAS_NOT_SPEC_CATEGORY_BUFF, Category}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_positive_int(Category), Category),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:has_spec_category_buff(Bo, Category)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_MON_NO_EQUAL_TO, BMonNo}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_positive_int(BMonNo), BMonNo),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            is_monster(Bo) andalso (lib_bo:get_parent_obj_id(Bo) == BMonNo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_POS_EQUAL_TO, Pos}, _Actor, Src_TargetBoIdList) -> % 注意：Pos为策划所认为的站位
    ?ASSERT(util:is_positive_int(Pos), Pos),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            server_logic_pos_to_cfg_pos(lib_bo:get_pos(Bo)) == Pos
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_HAS_SPEC_SKILL, SkillId}, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:has_skill(Bo, SkillId)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_HAS_NOT_SPEC_SKILL, SkillId}, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:has_skill(Bo, SkillId)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_IS_CAN_USE_SKILL, SkillId}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(mod_skill:is_initiative(SkillId), {SkillId, _Actor}),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            case lib_bo:can_use_skill(Bo, SkillId) of
                true -> true;
                {false, _Reason} -> false
            end
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_IS_FROZEN, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:is_frozen(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_IS_NOT_FROZEN, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:is_frozen(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_NOT_INVINCIBLE, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            % ?ASSERT(Bo /= null, BoId),
            Bo /= null andalso not lib_bo:is_invincible(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_IS_TRANCE, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:is_trance(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_IS_NOT_TRANCE, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:is_trance(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_IS_CHAOS, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:is_chaos(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_IS_NOT_CHAOS, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:is_chaos(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_IS_CDING, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:is_cding(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_IS_NOT_CDING, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:is_cding(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_IS_XULIING, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:is_xuliing(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_IS_NOT_XULIING, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:is_xuliing(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_IS_UNDER_CONTROL, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:is_under_control(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_IS_NOT_UNDER_CONTROL, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:is_under_control(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule(?RDT_CAN_ANTI_INVISIBLE, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:can_anti_invisible(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(?RDT_CANNOT_ANTI_INVISIBLE, _Actor, Src_TargetBoIdList) ->
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            not lib_bo:can_anti_invisible(Bo)
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule(?RDT_LV_HIGHEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_lv(A) > lib_bo:get_lv(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;

filter_bo_by_rule(?RDT_CUR_HP_HIGHEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_hp(A) > lib_bo:get_hp(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;

filter_bo_by_rule(?RDT_CUR_MP_HIGHEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_mp(A) > lib_bo:get_mp(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;

filter_bo_by_rule(?RDT_CUR_ANGER_HIGHEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_anger(A) > lib_bo:get_anger(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;


filter_bo_by_rule(?RDT_PHY_ATT_HIGHEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_phy_att(A) > lib_bo:get_phy_att(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;


filter_bo_by_rule(?RDT_MAG_ATT_HIGHEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_mag_att(A) > lib_bo:get_mag_att(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;


filter_bo_by_rule(?RDT_PHY_DEF_HIGHEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_phy_def(A) > lib_bo:get_phy_def(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;


filter_bo_by_rule(?RDT_MAG_DEF_HIGHEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_mag_def(A) > lib_bo:get_mag_def(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;


filter_bo_by_rule(?RDT_SEAL_HIT_HIGHEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_seal_hit(A) > lib_bo:get_seal_hit(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;

filter_bo_by_rule(?RDT_SEAL_RESIS_HIGHEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_seal_resis(A) > lib_bo:get_seal_resis(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;


filter_bo_by_rule(?RDT_ACT_SPEED_HIGHEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_act_speed(A) > lib_bo:get_act_speed(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;

filter_bo_by_rule(?RDT_NOT_ACT_BO, _Actor, Src_TargetBoIdList) ->
  AllNotActBo = lib_bt_dict:get_cur_actor_list(),
  lists:foldl(fun(X,Acc) ->  case lists:member(X,Src_TargetBoIdList) of
                               true ->
                                 [X|Acc];
                               false ->
                                 Acc
                             end
              end,[],AllNotActBo);



filter_bo_by_rule(?RDT_LV_LOWEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_lv(A) < lib_bo:get_lv(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;

filter_bo_by_rule(?RDT_CUR_HP_LOWEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_hp(A) < lib_bo:get_hp(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;

filter_bo_by_rule(?RDT_CUR_MP_LOWEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_mp(A) < lib_bo:get_mp(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;

filter_bo_by_rule(?RDT_CUR_ANGER_LOWEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_anger(A) < lib_bo:get_anger(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;


filter_bo_by_rule(?RDT_PHY_ATT_LOWEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_phy_att(A) < lib_bo:get_phy_att(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;


filter_bo_by_rule(?RDT_MAG_ATT_LOWEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_mag_att(A) < lib_bo:get_mag_att(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;


filter_bo_by_rule(?RDT_PHY_DEF_LOWEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_phy_def(A) < lib_bo:get_phy_def(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;


filter_bo_by_rule(?RDT_MAG_DEF_LOWEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_mag_def(A) < lib_bo:get_mag_def(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;



filter_bo_by_rule(?RDT_SEAL_HIT_LOWEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_seal_hit(A) < lib_bo:get_seal_hit(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;

filter_bo_by_rule(?RDT_SEAL_RESIS_LOWEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_seal_resis(A) < lib_bo:get_seal_resis(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;


filter_bo_by_rule(?RDT_ACT_SPEED_LOWEST, _Actor, Src_TargetBoIdList) ->
    case Src_TargetBoIdList of
        [] -> [];
        _ ->
            F = fun(BoId_A, BoId_B) ->
                    A = get_bo_by_id(BoId_A),  B = get_bo_by_id(BoId_B),
                    lib_bo:get_act_speed(A) < lib_bo:get_act_speed(B)
                end,
            L = lists:sort(F, Src_TargetBoIdList),
            [erlang:hd(L)]
    end;



filter_bo_by_rule({?RDT_LV_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_lv(Bo) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule({?RDT_CUR_HP_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_hp(Bo) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule({?RDT_CUR_MP_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_mp(Bo) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;



filter_bo_by_rule({?RDT_CUR_ANGER_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_anger(Bo) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_PHY_ATT_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_phy_att(Bo) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;



filter_bo_by_rule({?RDT_MAG_ATT_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_mag_att(Bo) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule({?RDT_PHY_DEF_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_phy_def(Bo) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_MAG_DEF_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_mag_def(Bo) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_SEAL_HIT_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_seal_hit(Bo) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule({?RDT_SEAL_RESIS_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_seal_resis(Bo) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule({?RDT_ACT_SPEED_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_act_speed(Bo) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;



filter_bo_by_rule({?RDT_LV_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_lv(Bo) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_CUR_HP_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_hp(Bo) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule({?RDT_CUR_MP_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_mp(Bo) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_CUR_ANGER_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_anger(Bo) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_PHY_ATT_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_phy_att(Bo) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_MAG_ATT_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_mag_att(Bo) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_PHY_DEF_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_phy_def(Bo) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_MAG_DEF_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_mag_def(Bo) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_SEAL_HIT_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_seal_hit(Bo) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_SEAL_RESIS_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_seal_resis(Bo) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_ACT_SPEED_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_act_speed(Bo) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;



filter_bo_by_rule({?RDT_LV_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_lv(Bo) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_CUR_HP_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_hp(Bo) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule({?RDT_CUR_MP_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_mp(Bo) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_CUR_ANGER_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_anger(Bo) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_PHY_ATT_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_phy_att(Bo) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_MAG_ATT_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_mag_att(Bo) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_PHY_DEF_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_phy_def(Bo) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_MAG_DEF_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_mag_def(Bo) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_SEAL_HIT_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_seal_hit(Bo) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule({?RDT_SEAL_RESIS_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_seal_resis(Bo) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_ACT_SPEED_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            lib_bo:get_act_speed(Bo) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

%% 注：Val为所比较百分比的分子，比如：若是50%，则Val为50，下两个同理
filter_bo_by_rule({?RDT_CUR_HP_PERCENTAGE_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            CurVal = lib_bo:get_hp(Bo),
            ValLim = lib_bo:get_hp_lim(Bo),
            ?ASSERT(CurVal =< ValLim, {CurVal, ValLim, Bo}),
            erlang:round(CurVal * 100 / ValLim) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule({?RDT_CUR_MP_PERCENTAGE_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            CurVal = lib_bo:get_mp(Bo),
            ValLim = lib_bo:get_mp_lim(Bo),
            ?ASSERT(CurVal =< ValLim, {CurVal, ValLim, Bo}),
            erlang:round(CurVal * 100 ) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_CUR_ANGER_PERCENTAGE_HIGHER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            CurVal = lib_bo:get_anger(Bo),
            ValLim = lib_bo:get_anger_lim(Bo),
            ?ASSERT(CurVal =< ValLim, {CurVal, ValLim, Bo}),
            erlang:round(CurVal * 100 / ValLim) > Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


%% 注：Val为所比较百分比的分子，比如：若是50%，则Val为50，下两个同理
filter_bo_by_rule({?RDT_CUR_HP_PERCENTAGE_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            CurVal = lib_bo:get_hp(Bo),
            ValLim = lib_bo:get_hp_lim(Bo),
            ?ASSERT(CurVal =< ValLim, {CurVal, ValLim, Bo}),
            erlang:round(CurVal * 100 / ValLim) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule({?RDT_CUR_MP_PERCENTAGE_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            CurVal = lib_bo:get_mp(Bo),
            ValLim = lib_bo:get_mp_lim(Bo),
            ?ASSERT(CurVal =< ValLim, {CurVal, ValLim, Bo}),
            erlang:round(CurVal * 100 / ValLim) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_CUR_ANGER_PERCENTAGE_EQUAL_TO, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            CurVal = lib_bo:get_anger(Bo),
            ValLim = lib_bo:get_anger_lim(Bo),
            ?ASSERT(CurVal =< ValLim, {CurVal, ValLim, Bo}),
            erlang:round(CurVal * 100 / ValLim) == Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


%% 注：Val为所比较百分比的分子，比如：若是50%，则Val为50，下两个同理
filter_bo_by_rule({?RDT_CUR_HP_PERCENTAGE_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            CurVal = lib_bo:get_hp(Bo),
            ValLim = lib_bo:get_hp_lim(Bo),
            ?ASSERT(CurVal =< ValLim, {CurVal, ValLim, Bo}),
            erlang:round(CurVal * 100 / ValLim) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;


filter_bo_by_rule({?RDT_CUR_MP_PERCENTAGE_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            CurVal = lib_bo:get_mp(Bo),
            ValLim = lib_bo:get_mp_lim(Bo),
            ?ASSERT(CurVal =< ValLim, {CurVal, ValLim, Bo}),
            erlang:round(CurVal * 100 ) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule({?RDT_CUR_ANGER_PERCENTAGE_LOWER_THAN, Val}, _Actor, Src_TargetBoIdList) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            ?ASSERT(Bo /= null, BoId),
            CurVal = lib_bo:get_anger(Bo),
            ValLim = lib_bo:get_anger_lim(Bo),
            ?ASSERT(CurVal =< ValLim, {CurVal, ValLim, Bo}),
            erlang:round(CurVal * 100 / ValLim) < Val
        end,
    RetL = [X || X <- Src_TargetBoIdList, F(X)],
    RetL;

filter_bo_by_rule(_Rule, _Actor, _Src_TargetBoIdList) ->
    ?ASSERT(false, {_Rule, _Actor, _Src_TargetBoIdList}),
    [].

