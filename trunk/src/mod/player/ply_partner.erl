%%%--------------------------------------
%%% @Module: ply_partner
%%% @Author: zwq
%%% @Created: 2013.11.12
%%% @Modify:  zhangwq 2013.10.22
%%% @Description: 玩家操作宠物的相关函数
%%%--------------------------------------

-module(ply_partner).

-export([
        check_player_add_partner/2,
        check_player_add_partner/1,
        player_add_partner/2,                       %% 玩家获取宠物 获取宠物会自动通知客户端
		player_add_partner/3,                       %% 玩家获取宠物 获取宠物会自动通知客户端
		player_add_partner_offline/2,
		player_add_partner_offline/3,
        db_load_partner_data/1,                     %% 玩家登陆加载宠物数据
        load_find_par_info_from_db/1,               % 从数据库加载玩家寻妖信息
        set_partner_state/3,                        %% 设置宠物状态
        check_open_carry_partner_num/2,
        open_carry_partner_num/2,                   %% 开启宠物可携带数量
        set_main_partner/2,                         %% 设置主宠
        set_partner_follow_state/3,
        rename/3,                                   %% 改名
        get_partner_list/1,                         %% 获取玩家宠物对象列表return partner结构体列表
        get_partner_equip_list/2,                   %% 获取某个宠物的装备列表
        wash_partner/3,                             %% 洗髓宠物
        evolve_partner/3,                           %% 进化宠物
		evolve_partner_onekey/3,					%% 一键进化宠物
        cultivate_partner/3,                        %% 修炼宠物

        batch_free_partner/2,                       %% 批量放生宠物
        one_key_free_partner/1,                     %% 将玩家携带的白色、绿色品质女妖全部放生
        free_partner_in_hotel/2,                    %% 放生青楼中抽取的女妖
        use_goods/4,                                %% 宠物使用物品
        fulfil_wish/4,                              %% 玩家满足宠物心愿
        change_mood/2,                              %% 改变宠物心情
        get_find_par_info/1,                        %% 获取玩家进入青楼的信息
        find_partner/1,                             %% 寻妖
        find_partner_again/1,                       %% 寻妖再来一次
        adopt_partner/2,                            %% 领养女妖
        enter_hotel/3,                              %% 进入青楼
        parnter_transmit/3,                         %% 女妖传功
        add_postnatal_skill/2,

        update_mood/1,                              %% 0点更新宠物心情
        get_can_fight_partner_count/1,              %% 玩家当前可以出战的宠物数
        expand_fight_par_capacity/2,                %% 扩充玩家可出战女妖的容量
        battle_feedback/1,                          %% 宠物战斗反馈

        del_skill/3,

        notify_when_partner_cultivate_lv_up/1,
        notify_partner_capacity_change/1,
        on_escape_from_battle/1,                    %% 战斗中逃跑反馈
        on_player_login/1,                          %% 玩家上线
        on_player_tmp_logout/1,                     %% 玩家下线处理数据
        adjust_hp_mp_after_battle/4,
        get_counter/2,                              %% 获取寻妖计数器
        get_counter/3,                              %% 获取寻妖计数器
        adjust_partner_fight_state/2,               %% 调整女妖的出战状态
        db_save_find_par_info/1,                    %% 保存寻妖信息
        del_find_par_info_from_ets/1,               %% 从ets删除寻妖信息
        db_save_all_partners/1,
        del_all_my_partners_from_ets/1,              %% 玩家下线处理数据
		check_partner_home_work_ban/1,
		change_skill_page/3,
		expand_skill_slot/2,
		expand_skill_slot_cost/1,
		cultivate_expand_skill_slot/2,
		attr_bonus_by_awake_lv/2,					%% 根据觉醒等级获取宠物属性加成
		partner_awake/2,
		partner_awake_illusion/3,
		partner_refine/5,							%% 宠物精炼
		partner_free/3
    ]).


-include("partner.hrl").
-include("ets_name.hrl").
-include("pt_17.hrl").
-include("record/goods_record.hrl").
-include("prompt_msg_code.hrl").
-include("skill.hrl").
-include("record/battle_record.hrl").
-include("obj_info_code.hrl").
-include("event.hrl").
-include("record.hrl").
-include("pt_12.hrl").
-include("abbreviate.hrl").
-include("effect.hrl").
-include("goods.hrl").
-include("log.hrl").
-include("job_schedule.hrl").
-include("sys_code.hrl").
-include("num_limits.hrl").
-include("player.hrl").
-include("train.hrl").
-include("ref_attr.hrl").


%% 从db加载玩家的武将数据
%% return PartnerIdList
db_load_partner_data(PlayerId) -> 
    % 获取携带中的武将并插入ets
    case db:select_all(partner, ?SQL_GET_PARTNER_INFO, [{player_id, PlayerId}]) of 
        [] -> % 没有
            ?TRACE("sizeof partner: 0~n"),
            [];
        InfoList when is_list(InfoList) ->
            ?TRACE("sizeof partner: ~p~n", [length(InfoList)]),
            
            F0 = fun(X, AccList) ->
                [_Id, _PlayerId, PartnerNo, _Name, _Sex, _Quality, _State, _Lv, _Exp, _Hp, _Intimacy, _IntimacyLv,
                    _Life, _CurBattleNum, _Position, _Follow, _Cultivate, _CultivateLv, _CultivateLayer, SkillsUse, _Skills, _SkillsTwo, SkillsExclusive, _BattlePower, _Loyalty, _NatureNo,
                    _EvolveLv, _Evolve, _AwakeLv, _AwakeIllusion, _BaseTrainAttrs, _BaseTrainAttrsTmp, _MaxPostnatalSkill, _WashCount, _MoodNo, _LastUpdateMoodTime, _UpdateMoodCount, _AddSkillFailCnt, 
				 _Version, _MountId,BaseTalents,FreeTalentPoint,_Five_Element, TsJoinBattle, _JoinBattleOrder, _AttrRefine,_ArtSlot,_CostRefine] = X,
                
                case data_partner:get(PartnerNo) of
                    null ->
                        ?ERROR_MSG("[ply_partner] db_load_partner_data() PartnerNo:~p not exist~n", [PartnerNo]),
                        AccList;
                    _ParCfg ->
                        TPartner = make_partner_info(X),
                        [adjust_id(TPartner, partner) | AccList]
                end
            end,
            % ?DEBUG_MSG("InfoList=~p",[InfoList]),
            PartnerList1 = lists:foldl(F0, [], InfoList),
            F = fun(Partner, {AccL, Sum, ParAcc}) ->
                Partner1 = lib_partner:calc_base_attrs(Partner),
                Partner2 = lib_partner:calc_equip_add_attrs(Partner1),
                % Partner3 = lib_partner:calc_passi_eff_attrs(Partner2),
                % Partner4 = lib_partner:calc_buff_eff_attrs(Partner3),

                Partner5 = lib_partner:init_total_attrs(Partner2),
                Partner6 = lib_partner:set_battle_power(Partner5, lib_partner:calc_battle_power(Partner5)),
                Partner7 = adjust_evole(Partner6),
                mod_partner:add_partner_to_ets(Partner7),

                % ?DEBUG_MSG("Par4 ~p,~p",[lib_partner:get_state(Partner7),lib_partner:get_id(Partner7)]),

                Sum1 =
                    case lib_partner:is_main_partner(Partner7) of
                        true -> 
                            %% 此处仅刷新女妖修炼排行榜（之前按照修炼等级排行，现在添加了修炼层数，目前按等级与层数排行）
                            case lib_partner:get_cultivate_lv(Partner7) > 0 of
                                true -> lib_partner:set_cultivate_layer(Partner7, lib_partner:get_cultivate_layer(Partner7));
                                false -> skip
                            end,
                            Sum + 1;
                        false -> Sum
                    end,
                {[lib_partner:get_id(Partner) | AccL], Sum1, [Partner7 | ParAcc]}
            end,

            {ParIdL, MainParCnt, ParList_New} = lists:foldl(F, {[], 0, []}, PartnerList1),
            case MainParCnt =:= 0 andalso ParList_New =/= [] of
                true ->
                    MainPar = erlang:hd(ParList_New),
                    mod_partner:update_partner_to_ets(MainPar#partner{position = ?PAR_POS_MAIN});
                false -> 
                    case MainParCnt >= 2 of
                        false -> skip;
                        true ->
                            [H | T] = ParList_New,
                            mod_partner:update_partner_to_ets(H#partner{position = ?PAR_POS_MAIN}),
                            F1 = fun(Par) ->
                                case lib_partner:is_main_partner(Par) of
                                    false -> skip;
                                    true -> mod_partner:update_partner_to_ets(Par#partner{position = ?PAR_POS_NOT_MAIN})
                                end
                            end,
                            [F1(Par) || Par <- T]
                    end
            end,

            ParIdL;
        _ -> % db读取出错
            ?ASSERT(false),
            []
    end.


%% 此接口主要用于后台离线获取数据
%% return
db_load_partner_list(PlayerId) ->
    case db:select_all(partner, ?SQL_GET_PARTNER_INFO, [{player_id, PlayerId}]) of
        [] -> % 没有
            [];
        InfoList when is_list(InfoList) ->
            F0 = fun(X, AccList) ->
                [_Id, _PlayerId, PartnerNo, _Name, _Sex, _Quality, _State, _Lv, _Exp, _Hp, _Intimacy, _IntimacyLv,
                    _Life, _CurBattleNum, _Position, _Follow, _Cultivate, _CultivateLv, _CultivateLayer, SkillsUse, _Skills, _SkillsTwo, SkillsExclusive, BattlePower, _Loyalty, _NatureNo,
                    _EvolveLv, _Evolve, _AwakeLv_BaseTrainAttrs, _BaseTrainAttrsTmp, _MaxPostnatalSkill, _WashCount, _MoodNo, _LastUpdateMoodTime, _UpdateMoodCount, _AddSkillFailCnt, 
				 _Version, _MountId,_BaseTalents,_FreeTalentPoint,_Five_Element, TsJoinBattle,_JoinBattleOrder, _AttrRefine,_ArtSlot,_CostRefine] = X,
                case data_partner:get(PartnerNo) of
                    null ->
                        ?ERROR_MSG("[ply_partner] db_load_partner_data() PartnerNo:~p not exist~n", [PartnerNo]),
                        AccList;
                    _ParCfg ->
                        Partner = make_partner_info(X),
                        Partner1 = lib_partner:calc_base_attrs(Partner),
                        Partner2 = lib_partner:calc_equip_add_attrs(Partner1),
                        % Partner3 = lib_partner:calc_passi_eff_attrs(Partner1),
                        % Partner4 = lib_partner:calc_buff_eff_attrs(Partner3),
                        Partner5 = lib_partner:init_total_attrs(Partner2),
                        Partner6 = lib_partner:set_battle_power(Partner5, BattlePower),

                        ?DEBUG_MSG("Par----- ~p,~p",[lib_partner:get_state(Partner6),lib_partner:get_id(Partner6)]),

                        [Partner6 | AccList]
                end
            end,
            lists:foldl(F0, [], InfoList);
        _ -> % db读取出错
            ?ASSERT(false),
            []
    end.


load_find_par_info_from_db(PlayerId) ->
    case db:select_row(find_par, "lv_step, last_free_enter_time, enter_type, last_enter_type, counters", [{player_id, PlayerId}], [], [1]) of
        [] -> null;
        [LvStep, LastFreeEnterTime, EnterType, LastEnterType, Counter_BS] ->
            PartnerList =
                case db:select_all(partner_hotel, ?SQL_GET_PARTNER_INFO, [{player_id, PlayerId}]) of
                    [] -> % 没有
                        [];
                    InfoList when is_list(InfoList) ->
                        F0 = fun(X, AccList) ->
                            [_Id, _PlayerId, PartnerNo, _Name, _Sex, _Quality, _State, _Lv, _Exp, _Hp, _Intimacy, _IntimacyLv,
                                _Life, _CurBattleNum, _Position, _Follow, _Cultivate, _CultivateLv, _CultivateLayer, SkillsUse, _Skills, _SkillsTwo, SkillsExclusive, _BattlePower, _Loyalty, _NatureNo,
                                _EvolveLv, _Evolve, _BaseTrainAttrs, _BaseTrainAttrsTmp, _MaxPostnatalSkill, _WashCount, _MoodNo, _LastUpdateMoodTime, _UpdateMoodCount, _AddSkillFailCnt, 
							 _Version, _MountId,_BaseTalents,_FreeTalentPoint,_Five_Element, TsJoinBattle] = X,
                            case data_partner:get(PartnerNo) of
                                null ->
                                    ?ERROR_MSG("[ply_partner] db_load_partner_data() PartnerNo:~p not exist~n", [PartnerNo]),
                                    AccList;
                                _ParCfg ->
                                    TPartner = make_partner_info(X++[0]),
                                    [adjust_id(TPartner, partner_hotel) | AccList]
                            end
                        end,
                        PartnerList1 = lists:foldl(F0, [], InfoList),
                        F = fun(Partner, AccL) ->
                            Partner1 = lib_partner:calc_base_attrs(Partner),
                            Partner2 = lib_partner:calc_equip_add_attrs(Partner1),
                            % Partner3 = lib_partner:calc_passi_eff_attrs(Partner2),
                            % Partner4 = lib_partner:calc_buff_eff_attrs(Partner3),
                            Partner5 = lib_partner:init_total_attrs(Partner2),
                            Partner6 = lib_partner:set_battle_power(Partner5, lib_partner:calc_battle_power(Partner5)),
                            Partner7 = adjust_evole(Partner6),
                            [Partner7 | AccL]
                        end,

                        lists:foldl(F, [], PartnerList1);
                    _ -> % db读取出错
                        ?ASSERT(false),
                        []
                end,
            FindPar = #find_par{
                    player_id = PlayerId,
                    lv_step = LvStep,
                    last_free_enter_time = LastFreeEnterTime,
                    enter_type = EnterType,
                    last_enter_type = LastEnterType,
                    counter = case util:bitstring_to_term(Counter_BS) of undefined -> []; List -> List end,
                    par_list = PartnerList
            },
            mod_partner:add_find_par_to_ets(FindPar),
            FindPar
    end.


player_add_partner(PS, PartnerNo) ->
	player_add_partner(PS, PartnerNo, []).

player_add_partner(PS, PartnerNo, ExtraInfo) ->
    case check_player_add_partner(PS, PartnerNo) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_player_add_partner(PS, PartnerNo, ExtraInfo)
    end.


player_add_partner_offline(PlayerId, PartnerNo) ->
	player_add_partner_offline(PlayerId, PartnerNo, []).

player_add_partner_offline(PlayerId, PartnerNo, ExtraInfo) ->
	PartnerIdList = db:select_all(partner, "id", [{player_id, PlayerId}]),
	case length(PartnerIdList) >= 50 of %% player:get_partner_capacity(PS) of
        true -> {fail, ?PM_PAR_CARRY_LIMIT};
        false ->
            case data_partner:get(PartnerNo) of
                null ->
                    ?ASSERT(false, PartnerNo),
                    {fail, ?PM_DATA_CONFIG_ERROR};
                _Any ->
					do_player_add_partner_offline(PlayerId, PartnerNo, ExtraInfo)
            end
    end.
	


check_partner_home_work_ban(PartnerId) ->
	case lib_partner:get_partner(PartnerId) of
		null ->
			{fail, ?PM_PAR_NOT_EXISTS};
		Partner ->
			case lib_partner:get_state(Partner) of
				?PAR_STATE_HOME_WORK ->
					{fail, ?PM_HOME_PARTNER_EMPLOY_STATE};
				_ ->
					ok
			end
	end.
				

set_partner_state(PS, PartnerId, State) ->
    case check_set_partner_state(PS, PartnerId, State) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Partner} ->
            do_set_partner_state(PS, Partner, State)
    end.


open_carry_partner_num(PS, Num) ->
    case check_open_carry_partner_num(PS, Num) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_open_carry_partner_num(PS, Num)
    end.


set_main_partner(PS, PartnerId) ->
    case lib_partner:get_partner(PartnerId) of
        null -> {fail, ?PM_PAR_NOT_EXISTS};
        Partner ->
            case lib_partner:is_main_partner(Partner) of
                true -> ok;
                false ->
                    PlayerLvNeed = (data_partner:get(lib_partner:get_no(Partner)))#par_born_data.player_lv_need,
                    case player:get_lv(PS) < PlayerLvNeed of
                        true -> {fail, ?PM_PAR_PLAYER_LV_LIMIT_FOR_MAIN_PAR};
                        false ->
                            case player:has_partner(PS, PartnerId) of
                                false -> {fail, ?PM_PAR_NOT_EXISTS};
                                true ->
                                    CanCount = get_can_fight_partner_count(PS),
                                    case mod_partner:get_main_partner_id(PS) of
                                        ?INVALID_ID -> skip;
                                        MainParId ->
                                            OldMainPar = lib_partner:get_partner(MainParId),
                                            ?ASSERT(OldMainPar /= null),
                                            OldMainPar1 = OldMainPar#partner{position = ?PAR_POS_NOT_MAIN, join_battle_order = Partner#partner.join_battle_order},
                                            mod_partner:update_partner_to_ets(OldMainPar1)
                                    end,

                                    Partner1 = Partner#partner{position = ?PAR_POS_MAIN, join_battle_order = 1},
                                    {Partner2, StateChange} =
                                        case lib_partner:get_state(Partner1) of
                                            ?PAR_STATE_REST_UNLOCKED -> {lib_partner:set_state(Partner1, ?PAR_STATE_JOIN_BATTLE_UNLOCKED), true};
                                            ?PAR_STATE_REST_LOCKED -> {lib_partner:set_state(Partner1, ?PAR_STATE_JOIN_BATTLE_LOCKED), true};
                                            _Any2 -> {Partner1, false}
                                        end,

                                    mod_partner:update_partner_to_ets(Partner2),
                                    case StateChange of
                                        true ->
                                            lib_partner:notify_cli_info_change(Partner2, [{?OI_CODE_PAR_STATE, lib_partner:get_state(Partner2)}]);
                                        false -> skip
                                    end,

                                    lib_event:event(?TAKE_PET, [lib_partner:get_no(Partner2)], PS),
                                    PS1 = player_syn:set_main_partner_id(PS, lib_partner:get_id(Partner2)),

                                    ?DEBUG_MSG("CanCount~p",[CanCount]),
                                    
                                    %% 根据出战上限调整出战宠物数量
                                    adjust_partner_fight_state(PS1, CanCount),

                                    %% 玩家主宠发生变化，需要重新玩家的战斗力
                                    ply_attr:recount_battle_power(PS1),
                                    
                                    notify_other_sys_partner_join_battle(PS1),
                                    mod_rank:partner_clv(Partner2),
                                    mod_rank:partner_battle_power(Partner2),
                                    ok
                            end
                    end
            end
    end.


set_partner_follow_state(PS, PartnerId, Follow) ->
    case lib_partner:get_partner(PartnerId) of
        null -> {fail, ?PM_PAR_NOT_EXISTS};
        Partner ->
            OldParId = player:get_follow_partner_id(PS),
            case OldParId =:= PartnerId andalso lib_partner:get_follow_state(Partner) =:= Follow of
                true -> ok;
                false ->
                    case OldParId =:= ?INVALID_ID of
                        true ->
                            skip;
                        false ->
                            case lib_partner:get_partner(OldParId) of
                                null -> skip;
                                ParOld ->
                                    case Follow =:= ?PAR_UNFOLLOW of
                                        true -> skip;
                                        false ->
                                            ParOld2 = lib_partner:set_follow_state(ParOld, ?PAR_UNFOLLOW),
                                            mod_partner:update_partner_to_ets(ParOld2),
                                            player:set_follow_partner_id(PS, ?INVALID_ID),
                                            lib_partner:notify_main_partner_info_change_to_AOI(PS, ParOld2),
                                            lib_partner:notify_cli_info_change(ParOld2, [{?OI_CODE_PAR_FOLLOW, ?PAR_UNFOLLOW}])
                                    end
                            end
                    end,

                    Partner2 = lib_partner:set_follow_state(Partner, Follow),
                    mod_partner:update_partner_to_ets(Partner2),
                    lib_partner:notify_cli_info_change(Partner2, [{?OI_CODE_PAR_FOLLOW, Follow}]),
                    FollowPartnerId = 
                        case Follow of
                            ?PAR_UNFOLLOW -> ?INVALID_ID;
                            ?PAR_FOLLOW -> lib_partner:get_id(Partner2)
                        end,
                    player:set_follow_partner_id(PS, FollowPartnerId),
                    lib_partner:notify_main_partner_info_change_to_AOI(PS, Partner2),
                    ok
            end
    end.


rename(PS, PartnerId, NewName) ->
    case check_rename(PS, PartnerId, NewName) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_rename(PS, PartnerId, NewName)
    end.


% return partner 结构体列表 | []
get_partner_list(PlayerId) when is_integer(PlayerId) ->
    case player:get_PS(PlayerId) of
        null ->
            case ply_tmplogout_cache:get_tmplogout_PS(PlayerId) of
                null ->
                    List = db_load_partner_list(PlayerId),
                    ?DEBUG_MSG("List ~p",[List]),
                    List;
                PS ->
                    F = fun(PartnerId) ->
                        Partner = lib_partner:get_partner(PartnerId),
                        ?DEBUG_MSG("Par ~p,~p",[lib_partner:get_state(Partner),lib_partner:get_id(Partner)]),

                        ?ASSERT(Partner /= null, PartnerId),
                        Partner
                    end,
                    lists:map(F, player:get_partner_id_list(PS))
            end;
        PS ->
            F = fun(PartnerId) ->
                Partner = lib_partner:get_partner(PartnerId),
                ?DEBUG_MSG("Par2 ~p,~p",[lib_partner:get_state(Partner),lib_partner:get_id(Partner)]),
                ?ASSERT(Partner /= null, PartnerId),
                Partner
            end,
            lists:map(F, player:get_partner_id_list(PS))
    end;

get_partner_list(PS) ->
    F = fun(PartnerId) ->
        Partner = lib_partner:get_partner(PartnerId),
        % ?DEBUG_MSG("Par3 ~p,~p",[lib_partner:get_state(Partner),lib_partner:get_id(Partner)]),
        ?ASSERT(Partner /= null, PartnerId),
        Partner
    end,
    lists:map(F, player:get_partner_id_list(PS)).


% return goods 结构体列表
get_partner_equip_list(PS, PartnerId) ->
    case player:has_partner(PS, PartnerId) of
        false ->
            ?ASSERT(false),
            [];
        true ->
            mod_equip:get_partner_equip_list(player:get_id(PS), PartnerId)
    end.


wash_partner(PS, PartnerId, Type) ->
    case check_wash_partner(PS, PartnerId, Type) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Partner} ->
            do_wash_partner(PS, Partner, Type)
    end.


evolve_partner_onekey(PlayerId, PartnerId, Time) ->
	PS = player:get_PS(PlayerId),
	case check_evolve_next(PartnerId) of
		{ok, Count} ->
			case evolve_partner(PS, PartnerId, Count) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				{ok, Partner, InfoType, SkillId, OldQuality} ->
					{ok, BinData} = pt_17:write(?PT_PARTNER_EVOLVE, [?RES_OK, Partner]),
					lib_send:send_to_sock(PS, BinData),
					
					%% 进化后很多属性发生变化
					lib_partner:notify_cli_info_change(PS, Partner),
					
					case lib_partner:get_quality(Partner) =:= OldQuality of
						true -> skip;
						false ->
							{ok, BinData2} = pt_17:write(?PT_NOTIFY_PARTNER_SKILL_INFO_CHANGE, [lib_partner:get_id(Partner), InfoType, SkillId]),
							lib_send:send_to_sock(PS, BinData2)
					end,
                    NewTime = Time - 1,
                    case NewTime > 0 of
                        true ->
                            gen_server:cast(player:get_pid(PS), {apply_cast, ?MODULE, evolve_partner_onekey, [PlayerId, PartnerId, NewTime]});
                        false -> skip
                    end;
				{ok, null} ->
					ok
			end;
		{fail,Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end.


evolve_partner(PS, PartnerId, 1) ->
    case check_evolve_partner(PS, PartnerId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Partner, MoneyType, NeedMoney, GoodsList} ->
            do_evolve_partner(PS, Partner, MoneyType, NeedMoney, GoodsList)
    end;

%% 一键进化Count为0
evolve_partner(PS, PartnerId, Time) ->
	%% 进入onekey函数，此次不处理
    case Time < 0 orelse Time > 10 of
        true ->
            {fail, ?PM_UNKNOWN_ERR};
        false ->
            evolve_partner_onekey(player:get_id(PS), PartnerId, Time),
            {ok, null}
    end.

evolve_partner_old(PS, PartnerId, IdList) ->
    case check_evolve_partner_old(PS, PartnerId, IdList) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Partner, NeedMoney, ParList} ->
            do_evolve_partner_old(PS, Partner, IdList, NeedMoney, ParList)
    end.


cultivate_partner(PS, PartnerId, Count) ->
	do_cultivate_partner(PS, PartnerId, Count, [], [], []).
	


% free_partner(PS, PartnerId) ->
%     case check_free_partner(PS, PartnerId) of
%         {fail, Reason} ->
%             {fail, Reason};
%         {ok, Partner} ->
%             do_free_partner(PS, Partner)
%     end.


batch_free_partner(PS, PartnerIdList) ->
    case check_batch_free_partner(PS, PartnerIdList) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, PartnerList, GoodsList, PGL} ->
            do_batch_free_partner(PS, PartnerList, GoodsList, PGL)
    end.


%% 将玩家携带的白色、绿色品质女妖全部放生
one_key_free_partner(PS) ->
    case check_one_key_free_partner(PS) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, PartnerList, GoodsList, PGL} ->
            do_batch_free_partner(PS, PartnerList, GoodsList, PGL)
    end.

free_partner_in_hotel(PS, FindPar) when is_record(FindPar, find_par) ->
    F = fun(Partner, Acc) ->
        case is_record(Partner, partner) of
            false -> Acc;
            true -> [lib_partner:get_id(Partner) | Acc]
        end
    end,
    IdList = lists:foldl(F, [], FindPar#find_par.par_list),
    free_partner_in_hotel(PS, IdList);

free_partner_in_hotel(PS, IdList) ->
    case check_free_partner_in_hotel(PS, IdList) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, PartnerList, GoodsList, FindPar, PGL} ->
            do_free_partner_in_hotel(PS, PartnerList, GoodsList, FindPar, PGL)
    end.

%% para -> -record(btl_feedback
battle_feedback(Feedback) ->
    ?TRACE("ply_partner:battle_feedback...~n"),
    ?ASSERT(is_record(Feedback, btl_feedback)),
    PS = player:get_PS(Feedback#btl_feedback.player_id),
    F = fun({PartnerId, LeftHp, LeftMp}) ->
        Partner = lib_partner:get_partner(PartnerId),
        ?ASSERT(Partner =/= null),
        case Partner =:= null of
            true -> skip;
            false ->
                % Data = data_intimacy_lv_relate:get(lib_partner:get_intimacy_lv(Partner)),
                % ?ASSERT(Data#intimacy_lv_relate_data.battle_num > 0, Data#intimacy_lv_relate_data.battle_num),
                {NewHp, NewMp} = adjust_hp_mp_after_battle(PS, Partner, LeftHp, LeftMp),
                Partner0 = lib_partner:set_hp_mp(Partner, NewHp, NewMp),
                case LeftHp =< 0 of
                    true -> % 死亡
                        % Partner1 = Partner0,
                        % case lib_partner:get_lv(Partner0) =< ?PAR_CONSUME_LOYALTY_LV_LIMIT of
                        %     true ->
                        %         Partner0;
                        %     false ->
                        %         lib_partner:set_loyalty(Partner0, erlang:max(0, (lib_partner:get_loyalty(Partner0) - Data#intimacy_lv_relate_data.consume_loyalty_die)))
                        % end,

                        % Partner2 = lib_partner:set_life(Partner1, erlang:max(0, lib_partner:get_life(Partner1) - ?PAR_LIFE_POINT_BATTLE_DIE)),
                        % Partner3 = may_force_change_state(Partner0),
                        mod_partner:update_partner_to_ets(Partner0);
                        % lib_partner:notify_cli_info_change(Partner3, [{?OI_CODE_PAR_LOYALTY, lib_partner:get_loyalty(Partner3)}, {?OI_CODE_PAR_LIFE, lib_partner:get_life(Partner3)}]);
                        % lib_partner:notify_cli_info_change(Partner3, [{?OI_CODE_PAR_LIFE, lib_partner:get_life(Partner3)}]);
                    false ->
                        CurBattleNum = lib_partner:get_cur_battle_num(Partner),

                        % Partner1 = Partner0,
                        % case (CurBattleNum + 1) div Data#intimacy_lv_relate_data.battle_num >= 1 andalso
                        %     (CurBattleNum + 1) rem Data#intimacy_lv_relate_data.battle_num =:= 0 of
                        %     true -> lib_partner:set_loyalty(Partner0, erlang:max(0, lib_partner:get_loyalty(Partner0) - ?PAR_LOYALTY_POINT_BATTLE));
                        %     false -> Partner0
                        % end,
                        Partner2 = lib_partner:set_cur_battle_num(Partner0, CurBattleNum + 1),
                        ?TRACE("ply_partner battle_feedback: CurBattleNum:~p~n", [lib_partner:get_cur_battle_num(Partner2)]),
                        % Partner3 = lib_partner:set_life(Partner2, erlang:max(0, lib_partner:get_life(Partner1) - ?PAR_LIFE_POINT_BATTLE)),
                        % Partner4 = may_force_change_state(Partner3),
                        mod_partner:update_partner_to_ets(Partner2)
                        % lib_partner:notify_cli_info_change(Partner4, [{?OI_CODE_PAR_LOYALTY, lib_partner:get_loyalty(Partner4)}, {?OI_CODE_PAR_LIFE, lib_partner:get_life(Partner4)}])
                        % lib_partner:notify_cli_info_change(Partner4, [{?OI_CODE_PAR_LIFE, lib_partner:get_life(Partner4)}])
                end
        end
    end,

    F1 = fun(P1, P2) -> element(2, P1) > element(2, P2) end,
    SortParInfoList = lists:sort(F1, Feedback#btl_feedback.partner_info_list),
    lists:foreach(F, SortParInfoList).


on_escape_from_battle(PartnerId) ->
    case lib_partner:get_partner(PartnerId) of
        null -> skip;
        Partner ->
            % Data = data_intimacy_lv_relate:get(lib_partner:get_intimacy_lv(Partner)),
            CurBattleNum = lib_partner:get_cur_battle_num(Partner),

            % Partner1 = Partner,
            % case (CurBattleNum + 1) div Data#intimacy_lv_relate_data.battle_num >= 1 andalso
            %     (CurBattleNum + 1) rem Data#intimacy_lv_relate_data.battle_num =:= 0 of
            %     true -> lib_partner:set_loyalty(Partner, erlang:max(0, lib_partner:get_loyalty(Partner) - ?PAR_LOYALTY_POINT_BATTLE));
            %     false -> Partner
            % end,
            Partner2 = lib_partner:set_cur_battle_num(Partner, CurBattleNum + 1),
            ?TRACE("ply_partner on_escape_from_battle: CurBattleNum:~p~n", [lib_partner:get_cur_battle_num(Partner2)]),
            % Partner3 = lib_partner:set_life(Partner2, erlang:max(0, lib_partner:get_life(Partner1) - ?PAR_LIFE_POINT_BATTLE)),
            % Partner4 = may_force_change_state(Partner3),
            mod_partner:update_partner_to_ets(Partner2)
            % lib_partner:notify_cli_info_change(Partner4, [{?OI_CODE_PAR_LOYALTY, lib_partner:get_loyalty(Partner4)}, {?OI_CODE_PAR_LIFE, lib_partner:get_life(Partner4)}]).
            % lib_partner:notify_cli_info_change(Partner4, [{?OI_CODE_PAR_LIFE, lib_partner:get_life(Partner4)}]).
    end.


% may_force_change_state(Partner) ->
%     % Partner1 =
%     % case (lib_partner:get_life(Partner) =< 0) of
%     %     true ->
%     %         case lib_partner:get_state(Partner) of
%     %             ?PAR_STATE_JOIN_BATTLE_UNLOCKED -> lib_partner:set_state(Partner, ?PAR_STATE_REST_UNLOCKED);
%     %             ?PAR_STATE_JOIN_BATTLE_LOCKED -> lib_partner:set_state(Partner, ?PAR_STATE_REST_LOCKED);
%     %             _Any -> Partner
%     %         end;
%     %     false ->
%     %         Partner
%     % end,
%     Partner.


%% 玩家下线时从ets清除玩家的武将
del_all_my_partners_from_ets(PS) ->
    ?TRACE("ply_partner: del_all_my_partners_from_ets(), player id :~p~n", [player:get_id(PS)]),
    F = fun(PartnerId) ->
        mod_partner:del_partner_from_ets(PartnerId)
    end,
    lists:foreach(F, player:get_partner_id_list(PS)).


db_save_find_par_info(PlayerId) ->
    case mod_partner:get_find_par_from_ets(PlayerId) of
        null -> skip;
        R ->
            case R#find_par.is_dirty of
                false -> skip;
                true ->
                    Counter_BS = util:term_to_bitstring(R#find_par.counter),
                    db:replace(PlayerId, find_par, [{player_id, PlayerId}, {lv_step, R#find_par.lv_step}, {counters, Counter_BS},
                        {last_free_enter_time, R#find_par.last_free_enter_time}, {enter_type, R#find_par.enter_type}, {last_enter_type, R#find_par.last_enter_type}])
            end
    end.



adjust_partner_fight_state(PS, FightParCount) ->
    ParList = mod_partner:get_fighting_partner_list(PS),
    NowFightCount = length(ParList),
    case NowFightCount =< FightParCount of
        true -> skip;
        false ->
            F = fun(P1, P2) ->
                lib_partner:get_battle_power(P1) < lib_partner:get_battle_power(P2)
            end,
            ParListSort = lists:sort(F, ParList),
            ?DEBUG_MSG("NowFightCount=~p,FightParCount=~p",[NowFightCount , FightParCount]),
            adjust_partner_fight_state__(ParListSort, NowFightCount - FightParCount)
    end.

%% 依次把战斗力最低的设置为休息状态
adjust_partner_fight_state__([], _) ->
    skip;
adjust_partner_fight_state__(_, 0) ->
    skip;
adjust_partner_fight_state__([H | T], DeCount) when DeCount > 0 ->
    case lib_partner:is_main_partner(H) of
        true -> adjust_partner_fight_state__(T, DeCount);
        false ->
            Partner = lib_partner:set_rest_state(H),
            mod_partner:update_partner_to_ets(Partner),
            lib_partner:notify_cli_info_change(Partner, [{?OI_CODE_PAR_STATE, lib_partner:get_state(Partner)}]),
            adjust_partner_fight_state__(T, DeCount - 1)
    end;

adjust_partner_fight_state__(_Any, _Any2) ->
    ?ASSERT(false, {_Any, _Any2}),
    skip.

del_find_par_info_from_ets(PlayerId) ->
    mod_partner:del_find_par_from_ets(PlayerId).

on_player_login(PS) ->
    update_mood(PS),
    adust_lv(PS),
    DelayTime = 24*3600 - (svr_clock:get_unixtime() - util:calc_today_0_sec()) - 60,
    mod_ply_jobsch:add_schedule(?JSET_UPDATE_PAR_MOOD, DelayTime, [player:id(PS)]).


get_max_partner_capacity(PS) ->
    Lv = player:get_lv(PS),
    if
        Lv >= 1 andalso Lv  =< 39 -> 30;
        Lv >= 40 andalso Lv =< 49 -> 40;
        Lv >= 50 andalso Lv =< 59 -> 50;
        Lv >= 60 andalso Lv =< 69 -> 60;
        Lv >= 70 andalso Lv =< 79 -> 70;
        Lv >= 80 andalso Lv =< 89 -> 80;
        Lv >= 90 andalso Lv =< 99 -> 90;
        true -> 100
    end.

on_player_tmp_logout(PS) ->
    PlayerId = player:get_id(PS),
    mod_ply_jobsch:remove_one_sch(PlayerId, ?JSET_UPDATE_PAR_MOOD).


db_save_all_partners(PS) ->
    F = fun(PartnerId) ->
        case lib_partner:get_partner(PartnerId) of
            null -> skip;
            Partner ->
                case Partner#partner.is_dirty of
                    false -> skip; %% 鉴于宠物比较多，只保存有数据改变的
                    true -> mod_partner:db_save_partner(Partner)  % 保存武将数据到db
                end
        end
    end,
    lists:foreach(F, player:get_partner_id_list(PS)).


use_goods(PS, PartnerId, Goods, Count) ->
    case check_use_goods(PS, PartnerId, Goods, Count) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_use_goods(PS, PartnerId, Goods, Count)
    end.


%% 玩家满足宠物心愿
fulfil_wish(PS, PartnerId, GoodsNo1, GoodsNo2) ->
    case check_fulfil_wish(PS, PartnerId, GoodsNo1, GoodsNo2) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, GoodsCount} ->
            do_fulfil_wish(PS, PartnerId, GoodsNo1, GoodsNo2, GoodsCount)
    end.


change_mood(PS, PartnerId) ->
    case check_change_mood(PS, PartnerId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Partner} ->
            do_change_mood(PS, Partner)
    end.


update_mood(PS) ->
    F = fun(PartnerId) ->
        case lib_partner:get_partner(PartnerId) of
            null -> skip;
            Partner ->
                case util:is_same_day(lib_partner:get_last_update_mood_time(Partner)) of
                    true -> skip;
                    false ->
                        MoodNo = lib_partner:decide_mood_no(),
                        Partner1 = lib_partner:set_mood_no(Partner, MoodNo),
                        Partner2 = lib_partner:set_last_update_mood_time(Partner1, svr_clock:get_unixtime()),

                        % Partner3 = lib_partner:recount_buff_eff_attrs(Partner2),
                        Partner4 = lib_partner:recount_total_attrs(Partner2),
                        Partner5 = lib_partner:recount_battle_power(Partner4),
                        
                        mod_partner:update_partner_to_ets(Partner5),

                        lib_partner:notify_cli_info_change(Partner2, [{?OI_CODE_PAR_MOOD_NO, MoodNo}])
                end
        end
    end,
    [F(X) || X <- player:get_partner_id_list(PS)],
    ply_attr:recount_battle_power(PS).


%% return null | find_par 结构体
get_find_par_info(PlayerId) ->
    case mod_partner:get_find_par_from_ets(PlayerId) of
        null ->
            load_find_par_info_from_db(PlayerId);
        R -> R
    end.

find_partner(PS) ->
    case get_find_par_info(player:id(PS)) of
        null -> {fail, ?PM_PAR_NOT_ENTER_HOTLE_YET};
        FindPar ->
            try_free_last_find_par(PS, FindPar),
            case FindPar#find_par.enter_type of
                ?ENTER_HOTLE_TYPE_NONE -> {fail, ?PM_PAR_NOT_ENTER_HOTLE_YET};
                ?ENTER_HOTLE_TYPE_COM ->
                    {ParNoList, ResetCount, RetsetMoney} = rand_get_par_no_list(PS,FindPar#find_par.lv_step, ?PAR_FIND_TYPE_CON, FindPar),
                    ?DEBUG_MSG("ply_partner:find_partner Ret No List:~p~n", [ParNoList]),
                    ParList = do_add_partner_to_hotel(PS, ParNoList),
                    ParList1 = 
                        case length(ParList) > ?PAR_FIND_COUNT_CON of
                            true -> 
                                ?WARNING_MSG("ply_partner:find_partner error!PlayerId:~p~n", [player:id(PS)]),
                                lists:sublist(ParList, 1, ?PAR_FIND_COUNT_CON);
                            false -> ParList
                        end,

                    NewCounter = set_counter(FindPar, ParNoList, ResetCount, RetsetMoney),
                    
                    FindPar1 = FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_NONE, last_enter_type = FindPar#find_par.enter_type, par_list = ParList1, counter = NewCounter},
                    mod_partner:update_find_par_to_ets(FindPar1),
                    lib_event:event(find_partner, [], PS),
                    {ok, FindPar1};
                ?ENTER_HOTLE_TYPE_HIGH ->
                    {ParNoList, ResetCount, RetsetMoney} = rand_get_par_no_list(PS,FindPar#find_par.lv_step, ?PAR_FIND_TYPE_HIGH, FindPar),
                    ?DEBUG_MSG("ply_partner:find_partner Ret No List:~p~n", [ParNoList]),
                    ParList = do_add_partner_to_hotel(PS, ParNoList),
                    ParList1 = 
                        case length(ParList) > ?PAR_FIND_COUNT_HIGH of
                            true -> 
                                ?WARNING_MSG("ply_partner:find_partner error!PlayerId:~p~n", [player:id(PS)]),
                                lists:sublist(ParList, 1, ?PAR_FIND_COUNT_HIGH);
                            false -> ParList
                        end,

                    NewCounter = set_counter(FindPar, ParNoList, ResetCount, RetsetMoney),
                    
                    FindPar1 = FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_NONE, last_enter_type = FindPar#find_par.enter_type, par_list = ParList1, counter = NewCounter},
                    mod_partner:update_find_par_to_ets(FindPar1),
                    lib_event:event(find_partner, [], PS),
                    {ok, FindPar1};

                ?ENTER_HOTLE_TYPE_HIGH10 ->
                    {ParNoList, ResetCount, RetsetMoney} = rand_get_par_no_list(PS,FindPar#find_par.lv_step, ?PAR_FIND_TYPE_HIGH10, FindPar),
                    ?DEBUG_MSG("ply_partner:find_partner Ret No List:~p~n", [ParNoList]),
                    ParList = do_add_partner_to_hotel(PS, ParNoList),
                    ParList1 = 
                        case length(ParList) > ?PAR_FIND_COUNT_HIGH10 of
                            true -> 
                                ?WARNING_MSG("ply_partner:find_partner error!PlayerId:~p~n", [player:id(PS)]),
                                lists:sublist(ParList, 1, ?PAR_FIND_COUNT_HIGH10);
                            false -> ParList
                        end,

                    NewCounter = set_counter(FindPar, ParNoList, ResetCount, RetsetMoney),
                    
                    FindPar1 = FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_NONE, last_enter_type = FindPar#find_par.enter_type, par_list = ParList1, counter = NewCounter},
                    mod_partner:update_find_par_to_ets(FindPar1),
                    lib_event:event(find_partner, [], PS),
                    {ok, FindPar1};
                ?ENTER_HOTLE_TYPE_COM_FREE ->
                    {ParNoList, ResetCount, RetsetMoney} = rand_get_par_no_list(PS,FindPar#find_par.lv_step, ?PAR_FIND_TYPE_CON, FindPar),
                    ?DEBUG_MSG("ply_partner:find_partner Ret No List:~p~n", [ParNoList]),
                    ParList = do_add_partner_to_hotel(PS, ParNoList),
                    ParList1 = 
                        case length(ParList) > ?PAR_FIND_COUNT_CON of
                            true -> 
                                ?WARNING_MSG("ply_partner:find_partner error!PlayerId:~p~n", [player:id(PS)]),
                                lists:sublist(ParList, 1, ?PAR_FIND_COUNT_CON);
                            false -> ParList
                        end,
                    NewCounter = set_counter(FindPar, ParNoList, ResetCount, RetsetMoney),
                    
                    FindPar1 = FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_NONE, last_enter_type = FindPar#find_par.enter_type, par_list = ParList1, counter = NewCounter},
                    mod_partner:update_find_par_to_ets(FindPar1),
                    lib_event:event(find_partner, [], PS),
                    {ok, FindPar1};
                _Any ->
                    ?ASSERT(false, FindPar#find_par.enter_type),
                    {fail, ?PM_UNKNOWN_ERR}
            end
    end.

%% 尝试放生掉上次残留的女妖，防止数据库残留数据
try_free_last_find_par(PS, FindPar) ->
    F = fun(Partner, Acc) ->
        PartnerId = lib_partner:get_id(Partner),
        mod_partner:db_delete_partner_hotel(player:id(PS), PartnerId),
        [PartnerId | Acc]
    end,

    F1 = fun({Partner, GoodsL}, Acc) ->
        PartnerId = lib_partner:get_id(Partner),
        mod_partner:db_delete_partner_hotel(player:id(PS), PartnerId),
        lib_log:statis_role_action(PS, [], ?LOG_PARTNER, "release", [lib_partner:get_name(Partner),lib_partner:get_quality(Partner), 
            lib_partner:get_lv(Partner), util:term_to_string(GoodsL)]),
        [PartnerId | Acc]
    end,
    
    case check_free_partner_in_hotel(PS, FindPar) of
        {fail, _Reason} -> 
            lists:foldl(F, [], FindPar#find_par.par_list);
        {ok, _PartnerList, GoodsList, PGL} -> 
            lists:foldl(F1, [], PGL),
            case GoodsList =:= [] of
                true -> skip;
                false -> mod_inv:batch_smart_add_new_goods(player:get_id(PS), GoodsList, [{bind_state, ?BIND_ALREADY}], [?LOG_PARTNER, "release"])
            end
    end.


find_partner_again(PS) ->
    case check_find_partner_again(PS) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, PartnerList, GoodsList, FindPar, Price, PGL} ->
            do_find_partner_again(PS, PartnerList, GoodsList, FindPar, Price, PGL)
    end.


check_find_partner_again(PS) ->
    try 
        check_find_partner_again__(PS)
    catch
        FailReason ->
            {fail, FailReason}
    end.

check_find_partner_again__(PS) ->
    FindPar = get_find_par_info(player:id(PS)),
    ?Ifc (FindPar =:= null)
        throw(?PM_PAR_NOT_ENTER_HOTLE_YET)
    ?End,

    Data = data_find_par:get(FindPar#find_par.lv_step),
    ?Ifc (Data =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    if
        FindPar#find_par.last_enter_type =:= ?ENTER_HOTLE_TYPE_COM orelse FindPar#find_par.last_enter_type =:= ?ENTER_HOTLE_TYPE_COM_FREE ->
            Price = 1000,

            case Data#find_par_cfg.goods_need_com =:= [] of
                true ->
                    case player:has_enough_integral(PS, Price) of
                        true -> skip;
                        false -> throw(?PM_INTEGRAL_LIMIT)
                    end;
                false ->
                    case mod_inv:check_batch_destroy_goods(player:id(PS), Data#find_par_cfg.goods_need_com) of
                        ok -> skip;
                        {fail, _Reason} ->
                            case player:has_enough_integral(PS, Price) of
                                true -> skip;
                                false -> throw(?PM_INTEGRAL_LIMIT)
                            end
                    end
            end,
            case check_free_partner_in_hotel(PS, FindPar) of
                {fail, Reason1} -> throw(Reason1);
                {ok, PartnerList, GoodsList, PGL} -> {ok, PartnerList, GoodsList, FindPar, Price, PGL}
            end;
        FindPar#find_par.last_enter_type =:= ?ENTER_HOTLE_TYPE_HIGH ->
            Price = 4500,
            case Data#find_par_cfg.goods_need_high =:= [] of
                true ->
                    case player:has_enough_integral(PS, Price) of
                        true -> skip;
                        false -> throw(?PM_INTEGRAL_LIMIT)
                    end;
                false ->
                    case mod_inv:check_batch_destroy_goods(player:id(PS), Data#find_par_cfg.goods_need_high) of
                        ok -> skip;
                        {fail, _Reason} ->
                            case player:has_enough_integral(PS, Price) of
                                true -> skip;
                                false -> throw(?PM_INTEGRAL_LIMIT)
                            end
                    end
            end,
            case check_free_partner_in_hotel(PS, FindPar) of
                {fail, Reason1} -> throw(Reason1);
                {ok, PartnerList, GoodsList, PGL} -> {ok, PartnerList, GoodsList, FindPar, Price, PGL}
            end;

        FindPar#find_par.last_enter_type =:= ?ENTER_HOTLE_TYPE_HIGH10 ->
            Price = 9000,

            case Data#find_par_cfg.goods_need_high =:= [] of
                true ->
                    case player:has_enough_integral(PS, Price) of
                        true -> skip;
                        false -> throw(?PM_INTEGRAL_LIMIT)
                    end;
                false ->
                    case mod_inv:check_batch_destroy_goods(player:id(PS), Data#find_par_cfg.goods_need_high) of
                        ok -> skip;
                        {fail, _Reason} ->
                            case player:has_enough_integral(PS, Price) of
                                true -> skip;
                                false -> throw(?PM_INTEGRAL_LIMIT)
                            end
                    end
            end,
            case check_free_partner_in_hotel(PS, FindPar) of
                {fail, Reason1} -> throw(Reason1);
                {ok, PartnerList, GoodsList, PGL} -> {ok, PartnerList, GoodsList, FindPar, Price, PGL}
            end;

        true ->
            ?ASSERT(false, FindPar#find_par.last_enter_type),
            throw(?PM_UNKNOWN_ERR)
    end.


do_find_partner_again(PS, PartnerList, GoodsList, FindPar, Price, PGL) ->
    do_free_partner_in_hotel(PS, PartnerList, GoodsList, FindPar, PGL),
    Data = data_find_par:get(FindPar#find_par.lv_step),
    if
        FindPar#find_par.last_enter_type =:= ?ENTER_HOTLE_TYPE_COM orelse FindPar#find_par.last_enter_type =:= ?ENTER_HOTLE_TYPE_COM_FREE ->
            case Data#find_par_cfg.goods_need_com =:= [] of
                true ->
                    player_syn:cost_money(PS, ?MNY_T_INTEGRAL, Price, [?LOG_PARTNER, "lottery"]),
                    MoneyCounter = get_counter(money, FindPar),
                    NewCounter = update_counter(money, FindPar, Data#find_par_cfg.money_need_com + MoneyCounter),
                    mod_partner:update_find_par_to_ets(FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_COM, counter = NewCounter, par_list = []}),
                    find_partner(PS);
                false ->
                    case mod_inv:destroy_goods_WNC(player:id(PS), Data#find_par_cfg.goods_need_com, [?LOG_PARTNER, "lottery"]) of
                        true ->
                            mod_partner:update_find_par_to_ets(FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_COM, par_list = []}),
                            find_partner(PS);
                        false ->
                            player_syn:cost_money(PS, ?MNY_T_INTEGRAL, Price, [?LOG_PARTNER, "lottery"]),
                            MoneyCounter = get_counter(money, FindPar),
                            NewCounter = update_counter(money, FindPar, Data#find_par_cfg.money_need_com + MoneyCounter),
                            mod_partner:update_find_par_to_ets(FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_COM, counter = NewCounter, par_list = []}),
                            find_partner(PS)
                    end
            end;
        FindPar#find_par.last_enter_type =:= ?ENTER_HOTLE_TYPE_HIGH ->
            case Data#find_par_cfg.goods_need_high =:= [] of
                true ->
                    player_syn:cost_money(PS, ?MNY_T_INTEGRAL, Price, [?LOG_PARTNER, "lottery"]),
                    MoneyCounter = get_counter(money, FindPar),
                    NewCounter = update_counter(money, FindPar, Data#find_par_cfg.money_need_high + MoneyCounter),
                    mod_partner:update_find_par_to_ets(FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_HIGH, counter = NewCounter, par_list = []}),
                    find_partner(PS);
                false ->
                    case mod_inv:destroy_goods_WNC(player:id(PS), Data#find_par_cfg.goods_need_high, [?LOG_PARTNER, "lottery"]) of
                        true ->
                            mod_partner:update_find_par_to_ets(FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_HIGH, par_list = []}),
                            find_partner(PS);
                        false ->
                            player_syn:cost_money(PS, ?MNY_T_INTEGRAL, Price, [?LOG_PARTNER, "lottery"]),
                            MoneyCounter = get_counter(money, FindPar),
                            NewCounter = update_counter(money, FindPar, Data#find_par_cfg.money_need_high + MoneyCounter),
                            mod_partner:update_find_par_to_ets(FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_HIGH, counter = NewCounter, par_list = []}),
                            find_partner(PS)
                    end
            end;

        FindPar#find_par.last_enter_type =:= ?ENTER_HOTLE_TYPE_HIGH10 ->
            case Data#find_par_cfg.goods_need_high =:= [] of
                true ->
                    player_syn:cost_money(PS, ?MNY_T_INTEGRAL, Price, [?LOG_PARTNER, "lottery"]),
                    MoneyCounter = get_counter(money, FindPar),
                    NewCounter = update_counter(money, FindPar, Data#find_par_cfg.money_need_high + MoneyCounter),
                    mod_partner:update_find_par_to_ets(FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_HIGH10, counter = NewCounter, par_list = []}),
                    find_partner(PS);
                false ->
                    case mod_inv:destroy_goods_WNC(player:id(PS), Data#find_par_cfg.goods_need_high, [?LOG_PARTNER, "lottery"]) of
                        true ->
                            mod_partner:update_find_par_to_ets(FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_HIGH10, par_list = []}),
                            find_partner(PS);
                        false ->
                            player_syn:cost_money(PS, ?MNY_T_INTEGRAL, Price, [?LOG_PARTNER, "lottery"]),
                            MoneyCounter = get_counter(money, FindPar),
                            NewCounter = update_counter(money, FindPar, Data#find_par_cfg.money_need_high + MoneyCounter),
                            mod_partner:update_find_par_to_ets(FindPar#find_par{enter_type = ?ENTER_HOTLE_TYPE_HIGH10, counter = NewCounter, par_list = []}),
                            find_partner(PS)
                    end
            end;


            
        true ->
            ?ASSERT(false, FindPar#find_par.last_enter_type),
            {fail, ?PM_UNKNOWN_ERR}
    end.


adopt_partner(PS, IdList) ->
    case length(player:get_partner_id_list(PS)) + length(IdList) > player:get_partner_capacity(PS) of
        true -> {fail, ?PM_PAR_CARRY_LIMIT};
        false ->
            case get_find_par_info(player:id(PS)) of
                null -> {fail, ?PM_UNKNOWN_ERR};
                FindPar ->
                    F = fun(Id, {AccPS, AccId, AccPar}) ->
                        case lists:keyfind(Id, #partner.id, FindPar#find_par.par_list) of
                            false -> {AccPS, AccId, AccPar};
                            Partner ->
                                {ok, PS1} = do_player_add_partner(AccPS, Partner),
                                mod_partner:db_delete_partner_hotel(player:id(AccPS), lib_partner:get_id(Partner)),
                                {PS1, [Id | AccId], [Partner | AccPar]}
                        end
                    end,
                    {PS_Latest, RetIdList, ParList} = lists:foldl(F, {PS, [], []}, IdList),
                    player_syn:update_PS_to_ets(PS_Latest),
                    FindPar1 = FindPar#find_par{par_list = FindPar#find_par.par_list -- ParList},
                    mod_partner:update_find_par_to_ets(FindPar1),

                    {ok, RetIdList}
            end
    end.


enter_hotel(PS, LvStep, EnterType) ->
    case check_enter_hotel(PS, LvStep, EnterType) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, FindPar, Price} ->
            do_enter_hotel(PS, LvStep, EnterType, FindPar, Price)
    end.


parnter_transmit(PS, TargetParId, IdList) ->
    case check_parnter_transmit(PS, TargetParId, IdList) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, TargetPar, PartnerList, TotalExp, NeedMoney} ->
            do_parnter_transmit(PS, TargetPar, PartnerList, TotalExp, NeedMoney)
    end.

add_postnatal_skill(PS, PartnerId) ->
    case check_add_postnatal_skill(PS, PartnerId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Partner, GoodsList} ->
            do_add_postnatal_skill(PS, Partner, GoodsList)
    end.

notify_partner_capacity_change(PS) ->
    {ok, BinData} = pt_17:write(?PT_OPEN_CARRY_PARTNER_NUM, [?RES_OK, player:get_partner_capacity(PS)]),
    lib_send:send_to_sock(PS, BinData).


%% -------------------------------------------------Local Function--------------------------------------------------------------


check_add_postnatal_skill(PS, PartnerId) ->
    try 
        check_add_postnatal_skill__(PS, PartnerId)
    catch
        FailReason ->
            {fail, FailReason}
    end.


check_add_postnatal_skill__(PS, PartnerId) ->
    ?Ifc (PartnerId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Partner = lib_partner:get_partner(PartnerId),
    ?Ifc (Partner =:= null)
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    ?Ifc (not player:has_partner(PS, PartnerId))
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    PosSkillList = lib_partner:get_postnatal_skill_list(Partner),
    MaxSlot = lib_partner:get_max_postnatal_skill_slot(Partner),
    CurPSkillCnt = length(PosSkillList),

    Data = data_par_change_skill:get(MaxSlot, CurPSkillCnt),
    ?Ifc (Data =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ?Ifc (not is_list(Data#change_skill_cfg.goods_list))
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    case mod_inv:check_batch_destroy_goods(PS, Data#change_skill_cfg.goods_list) of
        {fail, Reason} ->
            throw(Reason);
        ok -> {ok, Partner, Data#change_skill_cfg.goods_list}
    end.


do_add_postnatal_skill(PS, Partner, GoodsList) ->
    {List, ReserveL} = 
        case data_partner:get(lib_partner:get_no(Partner)) of
            null -> {[], []};
            ParBornData -> {ParBornData#par_born_data.postnatal_skill_pool, ParBornData#par_born_data.reserve_skill_pool}
        end,

    F = fun(X) ->
        (data_skill:get(X))#skl_cfg.type =:= 2
    end,

    List1 = [X || X <- List, F(X)],

    {L1, L2, L3, L4} = classify_postnatal_skill_by_rarity(List1),
    AddPostnatalSkillL = get_postnatal_skill([], 1, L1, L2, L3, L4, lib_partner:get_skill_name_list(Partner)),
    Skill = 
        case AddPostnatalSkillL =:= [] of
            true -> 
                {L11, L22, L33, L44} = classify_postnatal_skill_by_rarity(ReserveL),
                AddSkillL = get_postnatal_skill([], 1, L11, L22, L33, L44, lib_partner:get_skill_name_list(Partner)),
                case AddSkillL =:= [] of
                    true ->
                        ?ERROR_MSG("ply_partner:do_add_postnatal_skill fail!~n", []),
                        null;
                    false -> erlang:hd(AddSkillL)
                end;
            false -> erlang:hd(AddPostnatalSkillL)
        end,
    
    case Skill =:= null of
        true -> skip;
        false ->
            mod_inv:destroy_goods_WNC(player:id(PS), GoodsList, [?LOG_PARTNER, "add_postnatal_skill"]),
            Partner1 = lib_partner:set_skill_list(Partner, lib_partner:get_skill_list(Partner) ++ [Skill]),
            mod_partner:update_partner_to_ets(Partner1),
            mod_partner:db_save_partner(Partner1),

            lib_partner:notify_cli_info_change(Partner1, [{?OI_CODE_PAR_ADD_SKILL, Skill#skl_brief.id}])
    end,
    ok.

check_parnter_transmit(PS, TargetParId, IdList) ->
    try check_parnter_transmit__(PS, TargetParId, IdList) of
        {ok, TargetPar, PartnerList, TotalExp, NeedMoney} ->
            {ok, TargetPar, PartnerList, TotalExp, NeedMoney}
    catch
        FailReason ->
            {fail, FailReason}
    end.



do_parnter_transmit(PS, TargetPar, PartnerList, TotalExp, NeedMoney) ->
    player:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, NeedMoney, []),

    F = fun(Partner) ->
        Partner1 = lib_partner:set_lv(Partner, 1),
        Partner2 = lib_partner:set_exp(Partner1, 0),

        NewPar5 = lib_partner:reset_lv_to_1(Partner2),
        
        Partner3 = lib_partner:calc_base_attrs(NewPar5),
        Partner4 = lib_partner:recount_total_attrs(Partner3),
        Partner5 = lib_partner:recount_battle_power(Partner4),
        mod_partner:update_partner_to_ets(Partner5),
        % 通知客户端武将属性已更新
        lib_partner:notify_cli_info_change(PS, Partner5)
    end,

    [F(X) || X <- PartnerList],

    lib_partner:add_exp_without_world_lv(TargetPar, TotalExp, PS, [?LOG_PARTNER, "parnter_transmit"]),
    ok.


check_parnter_transmit__(PS, TargetParId, IdList) ->
    ?Ifc (not player:has_partner(PS, TargetParId))
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    ?Ifc (length(IdList) > ?PAR_MAX_TRANSMITED_OBJ)
        throw(?PM_PARA_ERROR)
    ?End,

    TargetPar = lib_partner:get_partner(TargetParId),
    ?Ifc (TargetPar =:= null)
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    F1 = fun(Id, {Sum, AccList}) ->
        case lib_partner:get_partner(Id) of
            null -> {Sum, AccList};
            Partner -> 
                case lib_partner:is_locked(Partner) of
                    true -> {Sum + 1, AccList};
                    false -> {Sum, [Partner | AccList]}
                end
        end
    end,
    {LockCount, PartnerList} = lists:foldl(F1, {0, []}, IdList),

    ?Ifc (LockCount > 0)
        throw(?PM_PAR_IS_LOCKED)
    ?End,

    F2 = fun(P, Sum) ->
        case lib_partner:is_fighting(P) of
            true -> Sum + 1;
            false -> Sum
        end
    end,
    FightParCount = lists:foldl(F2, 0, PartnerList),

    ?Ifc (FightParCount > 0)
        throw(?PM_PAR_IS_FIGHTING)
    ?End,

    F3 = fun(Partner, {SumExp, SumMon}) ->
        ParLv = lib_partner:get_lv(Partner),
        {
        SumExp + lists:foldl(fun(Lv, Acc) -> Acc + lib_partner:get_exp_lim(Lv) end, 0, lists:seq(1, ParLv - 1)) + lib_partner:get_exp(Partner),
        SumMon + data_par_lv_relate:get_transmit_money(ParLv)
        }
    end,

    {AllExp, NeedMoney} = lists:foldl(F3, {0,0}, PartnerList),
    TotalExp = util:ceil(AllExp * 0.7),

    % 作出判断：先脱下内功，再传功
    IsEquippedArts = lib_train:get_isequipped_arts_by_role(),
    F4 = fun(Art) ->
            PartnerId = Art#role_arts.partner_id,
            lists:foreach(fun(X) ->
                            case X =:= PartnerId of
                                true -> throw(?PM_ART_ISEQUIPED_PARTNER_TRANSMIT);
                                false -> skip
                            end end, IdList)
    end,
    lists:foreach(F4, IsEquippedArts),

    % NeedMoney = util:ceil(5000 + AllExp * 0.9),

    ?Ifc (not player:has_enough_bind_gamemoney(PS, NeedMoney))
        throw(?PM_GAMEMONEY_LIMIT)
    ?End,

    ?Ifc ( lib_partner:get_lv(TargetPar) >= (player:get_player_max_lv(PS)) )
        throw(?PM_PAR_LV_MAX_LIMIT)
    ?End,

    {NewLv, _LeftExp} = lib_partner:change_lv_by_exp(PS,lib_partner:get_lv(TargetPar), lib_partner:get_exp(TargetPar) + TotalExp),

    ?Ifc (NewLv - player:get_lv(PS) >= ?DELTA_LV_PLAYER_PAR)
        throw(?PM_CANT_GET_EXP_BECAUSE_LV_DELTA)
    ?End,

    {ok, TargetPar, PartnerList, TotalExp, NeedMoney}.



check_enter_hotel(PS, LvStep, EnterType) ->
    try check_enter_hotel__(PS, LvStep, EnterType) of
        {ok, FindPar, Price} ->
            {ok, FindPar, Price}
    catch
        FailReason ->
            {fail, FailReason}
    end.


check_enter_hotel__(PS, LvStep, EnterType) ->
    Data = data_find_par:get(LvStep),

    % ?DEBUG_MSG("DATA=~p",[Data]),
    
    ?Ifc (Data =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ?Ifc (not lists:member(LvStep, data_find_par:get_all_lv_step_list()))
        throw(?PM_PARA_ERROR)
    ?End,

    % ?Ifc (length(Data#find_par_cfg.lv_range) =/= 2)
    %     throw(?PM_DATA_CONFIG_ERROR)
    % ?End,

    ?Ifc (player:get_lv(PS) < lists:nth(1, Data#find_par_cfg.lv_range))
        throw(?PM_PAR_ENTER_HOTLE_LV_LIMIT)
    ?End,

    case get_find_par_info(player:id(PS)) of
        null ->
            case EnterType =:= ?ENTER_HOTLE_TYPE_HIGH of
                true ->
                    Price = 4500,

                    case Data#find_par_cfg.goods_need_high =:= [] of
                        true ->
                            case player:has_enough_integral(PS, Price) of
                                true ->
                                    {ok, null, Price};
                                false -> throw(?PM_INTEGRAL_LIMIT)
                            end;
                        false ->
                            case mod_inv:check_batch_destroy_goods(player:id(PS), Data#find_par_cfg.goods_need_high) of
                                ok -> {ok, null, 0};
                                {fail, _Reason} ->
                                    case player:has_enough_integral(PS, Price) of
                                        true ->
                                            {ok, null, Price};
                                        false -> throw(?PM_INTEGRAL_LIMIT)
                                    end
                            end
                    end;
                false -> {ok, null, 0}
            end;
        FindPar ->
            if
                EnterType =:= ?ENTER_HOTLE_TYPE_COM_FREE ->
                    case svr_clock:get_unixtime() - FindPar#find_par.last_free_enter_time >= 24 * 3600 of
                        true -> {ok, FindPar, 0};
                        false -> throw(?PM_PAR_ENTER_HOTEL_FREE_TIME_LIMIT)
                    end;
                EnterType =:= ?ENTER_HOTLE_TYPE_COM ->
                    Price = 1000,

                    case Data#find_par_cfg.goods_need_com =:= [] of
                        true ->
                            case player:has_enough_integral(PS, Price) of
                                true ->
                                    {ok, FindPar, Price};
                                false -> throw(?PM_INTEGRAL_LIMIT)
                            end;
                        false ->
                            case mod_inv:check_batch_destroy_goods(player:id(PS), Data#find_par_cfg.goods_need_com) of
                                ok -> {ok, FindPar, 0};
                                {fail, _Reason} ->
                                    case player:has_enough_integral(PS, Price) of
                                        true ->
                                            {ok, FindPar, Price};
                                        false -> throw(?PM_INTEGRAL_LIMIT)
                                    end
                            end
                    end;
                EnterType =:= ?ENTER_HOTLE_TYPE_HIGH ->
                    Price = 4500,
                    case Data#find_par_cfg.goods_need_high =:= [] of
                        true ->
                            case player:has_enough_integral(PS, Price) of
                                true ->
                                    {ok, FindPar, Price};
                                false -> throw(?PM_INTEGRAL_LIMIT)
                            end;
                        false ->
                            % case mod_inv:check_batch_destroy_goods(player:id(PS), Data#find_par_cfg.goods_need_high) of
                            %     ok -> {ok, FindPar, 0};
                                % {fail, _Reason} ->
                                    case player:has_enough_integral(PS, Price) of
                                        true ->
                                            {ok, FindPar, Price};
                                        false -> throw(?PM_INTEGRAL_LIMIT)
                                    end
                            % end
                    end;

                EnterType =:= ?ENTER_HOTLE_TYPE_HIGH10 ->
                    Price = 9000,

                    case Data#find_par_cfg.goods_need_high =:= [] of
                        true ->
                            case player:has_enough_integral(PS, Price) of
                                true ->
                                    {ok, FindPar, Price};
                                false -> throw(?PM_INTEGRAL_LIMIT)
                            end;
                        false ->
                            % case mod_inv:check_batch_destroy_goods(player:id(PS), Data#find_par_cfg.goods_need_high) of
                            %     ok -> {ok, FindPar, 0};
                                % {fail, _Reason} ->
                                    case player:has_enough_integral(PS, Price) of
                                        true ->
                                            {ok, FindPar, Price};
                                        false -> throw(?PM_INTEGRAL_LIMIT)
                                    end
                            % end
                    end;
                true ->
                    ?ASSERT(false, EnterType),
                    {fail, ?PM_UNKNOWN_ERR}
            end
    end.


do_enter_hotel(PS, LvStep, EnterType, FindPar, Price) ->
    Data = data_find_par:get(LvStep),
    FindPar1 =
        case FindPar =:= null of
            true -> #find_par{player_id = player:id(PS), lv_step = LvStep, enter_type = EnterType};
            false -> FindPar
        end,
    ?ASSERT(is_record(FindPar1, find_par), FindPar1),
    if
        EnterType =:= ?ENTER_HOTLE_TYPE_COM_FREE ->
            FindPar2 = FindPar1#find_par{last_free_enter_time = svr_clock:get_unixtime(), enter_type = ?ENTER_HOTLE_TYPE_COM, lv_step = LvStep},
            MoneyCounter = get_counter(money, FindPar2, LvStep),
            NewCounter = update_counter(money, FindPar2, Price + MoneyCounter, LvStep),

            FindPar3 = FindPar2#find_par{enter_type = ?ENTER_HOTLE_TYPE_COM, lv_step = LvStep, counter = NewCounter},

            mod_partner:update_find_par_to_ets(FindPar3),
            ok;
        EnterType =:= ?ENTER_HOTLE_TYPE_COM ->
            CostMoneyFlag = 
                case Data#find_par_cfg.goods_need_com =:= [] of
                    true -> 
                        player_syn:cost_money(PS, ?MNY_T_INTEGRAL, Price, [?LOG_PARTNER, "lottery"]),
                        true;
                    false ->
                        case mod_inv:destroy_goods_WNC(player:id(PS), Data#find_par_cfg.goods_need_com, [?LOG_PARTNER, "lottery"]) of
                            true -> false;
                            false ->
                                player_syn:cost_money(PS, ?MNY_T_INTEGRAL, Price, [?LOG_PARTNER, "lottery"]),
                                true;
                            _Any1 -> 
                                ?ASSERT(false, _Any1),
                                false
                        end
                end,
            
            FindPar2 = 
                case CostMoneyFlag of
                    false -> FindPar1#find_par{enter_type = ?ENTER_HOTLE_TYPE_COM, lv_step = LvStep};
                    true ->
                        MoneyCounter = get_counter(money, FindPar1, LvStep),
                        NewCounter = update_counter(money, FindPar1, Price + MoneyCounter, LvStep),
                        FindPar1#find_par{enter_type = ?ENTER_HOTLE_TYPE_COM, lv_step = LvStep, counter = NewCounter}
                end,
            mod_partner:update_find_par_to_ets(FindPar2),
            ok;
        EnterType =:= ?ENTER_HOTLE_TYPE_HIGH ->
            CostMoneyFlag = 
                case Data#find_par_cfg.goods_need_high =:= [] of
                    true -> 
                        player_syn:cost_money(PS, ?MNY_T_INTEGRAL, Price, [?LOG_PARTNER, "lottery"]),
                        true;
                    false ->
                        case mod_inv:destroy_goods_WNC(player:id(PS), Data#find_par_cfg.goods_need_high, [?LOG_PARTNER, "lottery"]) of
                            true -> false;
                            false ->
                                player_syn:cost_money(PS, ?MNY_T_INTEGRAL, Price, [?LOG_PARTNER, "lottery"]),
                                true;
                            _Any2 -> 
                                ?ASSERT(false, _Any2),
                                false
                        end
                end,

            FindPar2 = 
                case CostMoneyFlag of
                    false -> FindPar1#find_par{enter_type = ?ENTER_HOTLE_TYPE_HIGH, lv_step = LvStep};
                    true ->
                        MoneyCounter = get_counter(money, FindPar1, LvStep),
                        NewCounter = update_counter(money, FindPar1, Price + MoneyCounter, LvStep),
                        FindPar1#find_par{enter_type = ?ENTER_HOTLE_TYPE_HIGH, lv_step = LvStep, counter = NewCounter}
                end,
			mod_achievement:notify_achi(senior_find_par, [], PS),
            mod_partner:update_find_par_to_ets(FindPar2),
            ok;

        EnterType =:= ?ENTER_HOTLE_TYPE_HIGH10 ->
            % Price1 = util:ceil(Price * 9.5),
            CostMoneyFlag = 
                case Data#find_par_cfg.goods_need_high =:= [] of
                    true -> 
                        player_syn:cost_money(PS, ?MNY_T_INTEGRAL, Price, [?LOG_PARTNER, "lottery"]),
                        true;
                    false ->
                        case mod_inv:destroy_goods_WNC(player:id(PS), Data#find_par_cfg.goods_need_high, [?LOG_PARTNER, "lottery"]) of
                            true -> false;
                            false ->
                                player_syn:cost_money(PS, ?MNY_T_INTEGRAL, Price, [?LOG_PARTNER, "lottery"]),
                                true;
                            _Any2 -> 
                                ?ASSERT(false, _Any2),
                                false
                        end
                end,

            FindPar2 = 
                case CostMoneyFlag of
                    false -> FindPar1#find_par{enter_type = ?ENTER_HOTLE_TYPE_HIGH10, lv_step = LvStep};
                    true ->
                        MoneyCounter = get_counter(money, FindPar1, LvStep),
                        NewCounter = update_counter(money, FindPar1, Price + MoneyCounter, LvStep),
                        FindPar1#find_par{enter_type = ?ENTER_HOTLE_TYPE_HIGH10, lv_step = LvStep, counter = NewCounter}
                end,
			mod_achievement:notify_achi(perfect_find_par, [], PS),
            mod_partner:update_find_par_to_ets(FindPar2),
            ok;


        true ->
            ?ASSERT(false, {EnterType, LvStep}),
            {fail, ?PM_UNKNOWN_ERR}
    end.

% 计算范围
calc_get_par_prob_range(PS,LvStep, Type) ->
    PlayerLv = player:get_lv(PS),
    case data_find_par:get(LvStep) of
        null ->
            ?ASSERT(false, LvStep), 1;
        Data ->
            PoolInfo =
                case Type of
                    1 -> Data#find_par_cfg.common_pool;
                    2 -> Data#find_par_cfg.high_pool;
                    3 -> Data#find_par_cfg.minimum_pool;
                    4 -> Data#find_par_cfg.high_pool10;
                    _Any -> ?ASSERT(false, Type), []
                end,
            F = fun({_No, Widget,Lv}, Sum) -> 
                case PlayerLv >= Lv of
                    true ->
                        Widget + Sum;
                    false ->
                        Sum
                end
            end,
            lists:foldl(F, 0, PoolInfo)
    end.

%% return {NoList, NeedResetCount, NeedResetMoney} --> NeedReset 为true | false
rand_get_par_no_list(PS,LvStep, FindType, FindPar) ->
    Count = case FindType of
        ?PAR_FIND_TYPE_CON -> ?PAR_FIND_COUNT_CON;
        ?PAR_FIND_TYPE_HIGH -> ?PAR_FIND_COUNT_HIGH;
        ?PAR_FIND_TYPE_HIGH10 -> ?PAR_FIND_COUNT_HIGH10
    end,
 
    {CountCounterCmp, MoneyCounterCmp} = 
        case data_find_par:get(LvStep) of
            null -> 
                ?ASSERT(false, LvStep),
                {?PAR_FIND_PURPLE_COUNTER, ?MAX_U32};
            Data ->
                {Data#find_par_cfg.minimum_count, Data#find_par_cfg.minimum_money}
        end,
    CountCounter = get_counter(count, FindPar, LvStep),
    MoneyCounter = get_counter(money, FindPar, LvStep),

    ?DEBUG_MSG("MoneyCounter=~p",[MoneyCounter]),

    case Count =:= 1 of
        true ->
            case MoneyCounter >= MoneyCounterCmp of
                true ->
                    Range3 = calc_get_par_prob_range(PS,LvStep, 3),
                    {rand_get_par_no_list_minimum(LvStep, Range3, 1, [], 0), false, true};
                false ->
                    % 第一次抽取送一次紫色以上的宠物
                    if 
                        CountCounter + 1 >= CountCounterCmp orelse MoneyCounter == 0 ->
                            Range2 = calc_get_par_prob_range(PS,LvStep, 4),
                            {rand_get_par_no_list_high10(PS,LvStep, Range2, 1, [], 0), true, false};
                        true ->
                            Range1 = 
                                case FindType of 
                                    ?PAR_FIND_TYPE_CON -> calc_get_par_prob_range(PS,LvStep, 1);
                                    _ -> calc_get_par_prob_range(PS,LvStep, 2)
                            end,

                            % 高级寻妖用高级
                            Ret = case FindType of 
                                    ?PAR_FIND_TYPE_CON -> rand_get_par_no_list_com(PS,LvStep, Range1, Count, [], 0);
                                    _ -> rand_get_par_no_list_high(PS,LvStep, Range1, Count, [], 0)
                            end,
                            {Ret, false, false}
                    end
            end;
        false ->
            ?ASSERT(Count > 1, Count),
            case MoneyCounter >= MoneyCounterCmp of
                true ->
                    Range1 = 
                        case FindType of 
                            ?PAR_FIND_TYPE_CON -> calc_get_par_prob_range(PS,LvStep, 1);
                            _ -> calc_get_par_prob_range(PS,LvStep, 2)
                    end,

                    Range3 = calc_get_par_prob_range(PS,LvStep, 3),

                    L1 = case FindType of 
                            ?PAR_FIND_TYPE_CON -> rand_get_par_no_list_com(PS,LvStep, Range1, Count-1, [], 0);
                            _ -> rand_get_par_no_list_high(PS,LvStep, Range1, Count-1, [], 0)
                    end,

                    L2 = rand_get_par_no_list_minimum(LvStep, Range3, 1, [], 0),
                    ?DEBUG_MSG("ply_partner:rand_get_par_no_list,comList:~w, HighList:~w~n", [L1, L2]),
                    {L1 ++ L2, false, true};
                false ->
                    if 
                        CountCounter + Count >= CountCounterCmp orelse MoneyCounter < 200 ->
                            Range1 = 
                                case FindType of 
                                    ?PAR_FIND_TYPE_CON -> calc_get_par_prob_range(PS,LvStep, 1);
                                    _ -> calc_get_par_prob_range(PS,LvStep, 2)
                            end,

                            HighCount = 
                            if 
                                MoneyCounter < 500 -> Count/5 + 1;
                                true -> 1
                            end,

                            Range2 = calc_get_par_prob_range(PS,LvStep, 4),
                            % L1 = rand_get_par_no_list_com(LvStep, Range1, Count - HighCount, [], 0),
                            L1 = case FindType of 
                                ?PAR_FIND_TYPE_CON -> rand_get_par_no_list_com(PS,LvStep, Range1, Count-HighCount, [], 0);
                                _ -> rand_get_par_no_list_high(PS,LvStep, Range1, Count-HighCount, [], 0)
                            end,

                            L2 = rand_get_par_no_list_high10(PS,LvStep, Range2, HighCount, [], 0),
                            % ?DEBUG_MSG("ply_partner:rand_get_par_no_list,comList:~w, HighList:~w~n", [L1, L2]),
                            {L1 ++ L2, true, false};
                        true ->
                            Range1 = 
                                case FindType of 
                                    ?PAR_FIND_TYPE_CON -> calc_get_par_prob_range(PS,LvStep, 1);
                                    _ -> calc_get_par_prob_range(PS,LvStep, 2)
                            end,

                            % 高级寻妖用高级
                            Ret = case FindType of 
                                    ?PAR_FIND_TYPE_CON -> rand_get_par_no_list_com(PS,LvStep, Range1, Count, [], 0);
                                    _ -> rand_get_par_no_list_high(PS,LvStep, Range1, Count, [], 0)
                            end,
                            {Ret, false, false}

                            % {rand_get_par_no_list_com(LvStep, Range1, Count, [], 0), false, false}
                    end
            end
    end.


decide_par_no_by_prob(Pool, RandNum) ->
    decide_par_no_by_prob(Pool, RandNum, 0).

decide_par_no_by_prob([H | T], RandNum, SumToCompare) ->
    SumToCompare_2 = element(2, H) + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true ->
             element(1, H);
        false ->
            decide_par_no_by_prob(T, RandNum, SumToCompare_2)
    end;
decide_par_no_by_prob([], _RandNum, _) ->
    ?ASSERT(false),
    ?INVALID_NO.

% 计算列表
get_list_by_lv(PS, List) ->
    PlayerLv = player:get_lv(PS),
    F = fun({ParNo, Widget,Lv}, Acc) -> 
        case PlayerLv >= Lv of
            true ->
                [{ParNo,Widget}| Acc];
            false ->
                Acc
        end
    end,
    Ret = lists:foldl(F, [], List),

    Ret.

rand_get_par_no_list_com(_PS,_LvStep, _Range, Count, RetList, TryTimes) when length(RetList) >= Count orelse TryTimes >= 50 ->
    RetList;
rand_get_par_no_list_com(PS,LvStep, Range, Count, RetList, TryTimes) ->
    case Range < 1 of
        true -> RetList;
        false ->
            case data_find_par:get(LvStep) of
                null ->
                    rand_get_par_no_list_com(PS,LvStep, Range, Count, RetList, TryTimes + 1);
                Data ->
                    RandNum = util:rand(1, Range),
                    List = get_list_by_lv(PS,Data#find_par_cfg.common_pool),
                    case decide_par_no_by_prob(List, RandNum) of
                        ?INVALID_NO ->
                            rand_get_par_no_list_com(PS,LvStep, Range, Count, RetList, TryTimes + 1);
                        No ->
                            rand_get_par_no_list_com(PS,LvStep, Range, Count, [No | RetList], TryTimes + 1)
                    end
            end
    end.

rand_get_par_no_list_high(_PS,_LvStep, _Range, Count, RetList, TryTimes) when length(RetList) >= Count orelse TryTimes >= 50 ->
    RetList;
rand_get_par_no_list_high(PS,LvStep, Range, Count, RetList, TryTimes) ->
    case Range < 1 of
        true -> RetList;
        false ->
            case data_find_par:get(LvStep) of
                null ->
                    rand_get_par_no_list_high(PS,LvStep, Range, Count, RetList, TryTimes + 1);
                Data ->
                    RandNum = util:rand(1, Range),

                    List = get_list_by_lv(PS,Data#find_par_cfg.high_pool),

                    case decide_par_no_by_prob(List, RandNum) of
                        ?INVALID_NO ->
                            rand_get_par_no_list_high(PS,LvStep, Range, Count, RetList, TryTimes + 1);
                        No ->
                            rand_get_par_no_list_high(PS,LvStep, Range, Count, [No | RetList], TryTimes + 1)
                    end
            end
    end.

rand_get_par_no_list_high10(_PS,_LvStep, _Range, Count, RetList, TryTimes) when length(RetList) >= Count orelse TryTimes >= 50 ->
    RetList;

rand_get_par_no_list_high10(PS,LvStep, Range, Count, RetList, TryTimes) ->
    case Range < 1 of
        true -> RetList;
        false ->
            case data_find_par:get(LvStep) of
                null ->
                    rand_get_par_no_list_high10(PS,LvStep, Range, Count, RetList, TryTimes + 1);
                Data ->
                    RandNum = util:rand(1, Range),

                    List = get_list_by_lv(PS,Data#find_par_cfg.high_pool10),

                    case decide_par_no_by_prob(List, RandNum) of
                        ?INVALID_NO ->
                            rand_get_par_no_list_high10(PS,LvStep, Range, Count, RetList, TryTimes + 1);
                        No ->
                            rand_get_par_no_list_high10(PS,LvStep, Range, Count, [No | RetList], TryTimes + 1)
                    end
            end
    end.



%% 累计话费x元宝，保底出的女妖池
rand_get_par_no_list_minimum(_LvStep, _Range, Count, RetList, TryTimes) when length(RetList) >= Count orelse TryTimes >= 50 ->
    RetList;
rand_get_par_no_list_minimum(LvStep, Range, Count, RetList, TryTimes) ->
    case Range < 1 of
        true -> RetList;
        false ->
            case data_find_par:get(LvStep) of
                null ->
                    rand_get_par_no_list_minimum(LvStep, Range, Count, RetList, TryTimes + 1);
                Data ->
                    RandNum = util:rand(1, Range),
                    case decide_par_no_by_prob(Data#find_par_cfg.minimum_pool, RandNum) of
                        ?INVALID_NO ->
                            rand_get_par_no_list_minimum(LvStep, Range, Count, RetList, TryTimes + 1);
                        No ->
                            rand_get_par_no_list_minimum(LvStep, Range, Count, [No | RetList], TryTimes + 1)
                    end
            end
    end.


adjust_hp_mp_after_battle(PS, Partner, LeftHp, LeftMp) ->
    % NewHp =
    %     case LeftHp < lib_partner:get_hp_lim(Partner) of
    %         false -> LeftHp;
    %         true ->
    %             case player:get_lv(PS) =< 100 of
    %                 true -> 
    %                     lib_partner:get_hp_lim(Partner);
    %                 false ->
    %                     NeedAddHp = lib_partner:get_hp_lim(Partner) - LeftHp,
    %                     case player:get_store_par_hp(PS) > NeedAddHp of
    %                         true ->
    %                             player:add_store_par_hp(PS, 0 - NeedAddHp),
    %                             lib_partner:get_hp_lim(Partner);
    %                         false ->
    %                             StoreHp = player:get_store_par_hp(PS),
    %                             player:add_store_par_hp(PS, 0 - StoreHp),
    %                             case ply_setting:is_auto_add_store_par_hp_mp(player:id(PS)) of
    %                                 false -> skip;
    %                                 true -> mod_inv:auto_use_goods_for_add_store_par_hp(PS)
    %                             end,
    %                             max(LeftHp + StoreHp, 1) % 至少保留1点血
    %                     end
    %             end
    %     end,

    % NewMp =
    %     case LeftMp < lib_partner:get_mp_lim(Partner) of
    %         false -> LeftMp;
    %         true ->
    %             case player:get_lv(PS) =< 100 of
    %                 false -> 
    %                     lib_partner:get_mp_lim(Partner);
    %                 true ->

    %                     NeedAddMp = lib_partner:get_mp_lim(Partner) - LeftMp,
    %                     case player:get_store_par_mp(PS) > NeedAddMp of
    %                         true ->
    %                             player:add_store_par_mp(PS, 0 - NeedAddMp),
    %                             lib_partner:get_mp_lim(Partner);
    %                         false ->
    %                             StoreMp = player:get_store_par_mp(PS),
    %                             player:add_store_par_mp(PS, 0 - StoreMp),
    %                             case ply_setting:is_auto_add_store_par_hp_mp(player:id(PS)) of
    %                                 false -> skip;
    %                                 true -> mod_inv:auto_use_goods_for_add_store_par_mp(PS)
    %                             end,
    %                             max(LeftMp + StoreMp, 1) % 至少保留1点蓝
    %                     end
    %             end
    %     end,

    % {NewHp, NewMp}.
    {lib_partner:get_hp_lim(Partner),lib_partner:get_mp_lim(Partner)}.


check_change_mood(PS, PartnerId) ->
    try check_change_mood__(PS, PartnerId) of
        {ok, Partner} ->
            {ok, Partner}
    catch
        FailReason ->
            {fail, FailReason}
    end.

check_change_mood__(PS, PartnerId) ->
    Partner = lib_partner:get_partner(PartnerId),
    ?Ifc(Partner =:= null)
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    ?Ifc (not lists:member(PartnerId, player:get_partner_id_list(PS)))
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    ?Ifc ( (not player:is_vip(PS)) andalso (player:get_update_mood_count(PS) >= ?PAR_CHANGE_MOOD_COUNT_LIMIT) )
        throw(?PM_CHANGE_MOOD_COUNT_LIMIT_TODAY)
    ?End,

    ?Ifc ( player:is_vip(PS) andalso (player:get_update_mood_count(PS) >= ?PAR_VIP_CHANGE_MOOD_COUNT_LIMIT) )
        throw(?PM_CHANGE_MOOD_COUNT_LIMIT_TODAY)
    ?End,

    case mod_inv:check_batch_destroy_goods(player:id(PS), [{?GOODS_NO_FOR_CHANGE_MOOD, 1}]) of
        {fail, Reason} -> throw(Reason);
        ok -> {ok, Partner}
    end.


do_change_mood(PS, Partner) ->
    mod_inv:destroy_goods_WNC(player:id(PS), [{?GOODS_NO_FOR_CHANGE_MOOD, 1}], [?LOG_PARTNER, "intimacy"]),

    MoodNo = lib_partner:decide_mood_no(),
    Partner1 = lib_partner:set_mood_no(Partner, MoodNo),
    Partner2 = lib_partner:set_last_update_mood_time(Partner1, svr_clock:get_unixtime()),
    Partner3 = lib_partner:set_update_mood_count(Partner2, lib_partner:get_update_mood_count(Partner2)),

    % Partner4 = lib_partner:recount_buff_eff_attrs(Partner3),
    Partner5 = lib_partner:recount_total_attrs(Partner3),
    Partner6 = lib_partner:recount_battle_power(Partner5),
    
    mod_partner:update_partner_to_ets(Partner6),

    lib_partner:notify_cli_info_change(Partner6, [{?OI_CODE_PAR_MOOD_NO, MoodNo}]),
    player:set_update_mood_count(PS, player:get_update_mood_count(PS) + 1),
    player:set_last_update_mood_time(PS, svr_clock:get_unixtime()),
    ply_attr:recount_battle_power(PS),
    {ok, player:get_update_mood_count(PS) + 1}.


check_fulfil_wish(PS, PartnerId, GoodsNo1, GoodsNo2) ->
    try check_fulfil_wish__(PS, PartnerId, GoodsNo1, GoodsNo2) of
        {ok, GoodsCount} ->
            {ok, GoodsCount}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

get_intimacy_lv_step(_IntimacyLv, []) ->
    ?ASSERT(false),
    ?INVALID_NO;
get_intimacy_lv_step(IntimacyLv, [Step | T]) ->
    case data_par_fulfil_wish:get(Step) of
        null ->
            get_intimacy_lv_step(IntimacyLv, T);
        Data ->
            Range = Data#fulfil_wish.intimacy_lv_region,
            case util:in_range(IntimacyLv, lists:nth(1, Range), lists:nth(2, Range)) of
                true ->
                    Step;
                false ->
                    get_intimacy_lv_step(IntimacyLv, T)
            end
    end.


check_fulfil_wish__(PS, PartnerId, GoodsNo1, GoodsNo2) ->
    %% 普通玩家每日可提交3次，VIP玩家可提交5次 todo
    ?Ifc (not player:has_partner(PS, PartnerId))
        throw(?PM_PARA_ERROR)
    ?End,
    Partner = lib_partner:get_partner(PartnerId),
    ?Ifc (Partner =:= null)
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    IntimacyLv = lib_partner:get_intimacy_lv(Partner),
    Step = get_intimacy_lv_step(IntimacyLv, data_par_fulfil_wish:get_all_intimacy_lv_step()),
    Data = data_par_fulfil_wish:get(Step),
    GoodsList = [Data#fulfil_wish.goods_no1, Data#fulfil_wish.goods_no2, Data#fulfil_wish.goods_no3, Data#fulfil_wish.goods_no4,
                    Data#fulfil_wish.goods_no5, Data#fulfil_wish.goods_no6],
    ?Ifc ( not (lists:member(GoodsNo1, GoodsList) andalso lists:member(GoodsNo1, GoodsList)) )
        throw(?PM_PARA_ERROR)
    ?End,
    ?Ifc (mod_inv:get_goods_count_in_bag_by_no(player:get_id(PS), GoodsNo1) < Data#fulfil_wish.count)
        throw(?PM_GOODS_NOT_ENOUGH)
    ?End,
    ?Ifc (mod_inv:get_goods_count_in_bag_by_no(player:get_id(PS), GoodsNo2) < Data#fulfil_wish.count)
        throw(?PM_GOODS_NOT_ENOUGH)
    ?End,
    {ok, Data#fulfil_wish.count}.

get_weight_list([]) ->
    [];
get_weight_list([No | T]) ->
    get_weight_list([No | T], []).

get_weight_list([], AccList) ->
    AccList;
get_weight_list([No | T], AccList) ->
    case data_partner_surprise:get(No) of
        null ->
            get_weight_list(T, AccList);
        Data ->
            get_weight_list(T, [Data#surprise.weight] ++ AccList)
    end.

decide_surprise_no(WeightList, RandNum) ->
    decide_surprise_no(WeightList, RandNum, 0, 1).

decide_surprise_no([H | T], RandNum, SumToCompare, CurNo) ->
    SumToCompare_2 = H + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true ->
            CurNo;
        false ->
            decide_surprise_no(T, RandNum, SumToCompare_2, CurNo + 1)
    end;
decide_surprise_no([], _RandNum, _SumToCompare, _CurNo) ->
    ?ASSERT(false), 1.


do_fulfil_wish(PS, PartnerId, GoodsNo1, GoodsNo2, GoodsCount) ->
    mod_inv:destroy_goods_WNC(player:get_id(PS), [{GoodsNo1, GoodsCount}, {GoodsNo2, GoodsCount}], [?LOG_PARTNER, ?LOG_UNDEFINED]),
    Partner = lib_partner:get_partner(PartnerId),
    {ok, Partner1} = lib_partner:add_intimacy(Partner, util:rand(5,10), PS),

    WeightList = get_weight_list(data_partner_surprise:get_all_surprise_no()),
    No = decide_surprise_no(WeightList, util:rand(1, ?PROBABILITY_BASE)),
    Data = data_partner_surprise:get(No),
    case No of
        1 ->
            lib_partner:add_exp(Partner1, util:ceil(lib_partner:get_exp_lim(lib_partner:get_lv(Partner)) * Data#surprise.para), PS, [?LOG_UNDEFINED, ?LOG_UNDEFINED]);
        2 -> %% 全服公告 todo
            Skill = #skl_brief{id = Data#surprise.para},
            Partner2 = lib_partner:set_skill_list(Partner1, [Skill] ++ lib_partner:get_skill_list(Partner1)),
            mod_partner:update_partner_to_ets(Partner2),
            lib_partner:notify_cli_info_change(Partner2, [{?OI_CODE_PAR_ADD_SKILL, Skill#skl_brief.id}]);
        3 ->
            % Partner2 = lib_partner:set_loyalty(Partner1, lib_partner:get_loyalty(Partner1) + Data#surprise.para),
            % mod_partner:update_partner_to_ets(Partner2);
            do_nothing;
        4 ->
            Partner2 = lib_partner:set_life(Partner1, lib_partner:get_life(Partner1) + Data#surprise.para),
            mod_partner:update_partner_to_ets(Partner2);
        5 ->
            skip;
        _Any ->
            skip
    end.


check_use_goods(PS, PartnerId, Goods, Count) ->
    try check_use_goods__(PS, PartnerId, Goods, Count) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


%% 宠物使用物品检测
check_use_goods__(PS, PartnerId, Goods, Count) ->
    ?Ifc (Count =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not lists:member(PartnerId, player:get_partner_id_list(PS)))
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    % 物品是否可使用？
    ?Ifc (not lib_goods:is_can_use(Goods))
        throw(?PM_GOODS_CANT_USE)
    ?End,
    % 物品是否可用于玩家身上？
    ?Ifc (not lib_goods:is_can_use_on_obj_type(Goods, ?OBJ_PARTNER))
        throw(?PM_GOODS_CANT_USE_ON_PARTNER)
    ?End,
    ?Ifc (lib_goods:get_count(Goods) < Count)
        throw(?PM_GOODS_NOT_ENOUGH)
    ?End,

    % 等级是否足够？
    GoodsTpl = lib_goods:get_tpl_data(Goods#goods.no),
    Partner = lib_partner:get_partner(PartnerId),
    ?Ifc (lib_partner:get_lv(Partner) < lib_goods:get_lv(GoodsTpl))
        throw(?PM_LV_LIMIT)
    ?End,

    EffectList = lib_goods:get_effects(Goods),
    case EffectList /= [] of
        true ->
            EffCfg = lib_goods_eff:get_cfg_data(erlang:hd(EffectList)),
            Para = EffCfg#goods_eff.para,
            if
                EffCfg#goods_eff.name =:= ?EN_CHANGE_SKILL ->% 打书的时候要判断学习格子要满足且没学习过，否则不给打书
                    ?ASSERT(Count =:= 1, Count),

                    _SklCfg = mod_skill:get_cfg_data(Para),
%%                     IsInborn = mod_skill:is_inborn_skill(_SklCfg),
%%                     InbornCount =  lists:foldl(fun(_X, Sum) -> Sum + 1 end, 0, lib_partner:get_inborn_skill_name_list(Partner)),
		
					SkillList = lib_partner:get_skill_list(Partner),
					case length(SkillList) < lib_partner:get_max_postnatal_skill_slot(Partner) of
						?true ->% 有空格子
							skip;
						?false ->
							throw(?PM_PAR_INBORN_SKILL_FULL)
					end,
					
                    % 主动技能已满
%%                     case IsInborn andalso InbornCount >= ?MAX_INBORN_COUNT of
%%                         true ->
%%                             throw(?PM_PAR_INBORN_SKILL_FULL);
%%                         false ->
%%                             skip
%%                     end,
					%% 判断没有这个技能
                    case lib_partner:has_skill(Partner, Para,noequip) of
                        true -> throw(?PM_THE_PAR_HAVE_THE_SKILL);
                        false ->
								ok
%%                             case has_skill_with_same_type(Partner, Para) of
%%                                 true -> throw(?PM_PAR_HAVE_SAME_TYPE_SKILL);
%%                                 false -> 
%%                                     case ply_sys_open:is_open(Partner, ?SYS_PAR_CHANGE_SKILL) of
%%                                         false -> throw(?PM_PAR_LV_LIMIT);
%%                                         true -> ok
%%                                     end
%%                             end
                    end;
                EffCfg#goods_eff.name =:= ?EN_ADD_LIFE ->
                    case lib_partner:get_life(Partner) >= lib_partner:get_life_lim(Partner) of
                        true -> throw(?PM_PAR_LIFE_IS_FULL);
                        false -> ok
                    end;
                EffCfg#goods_eff.name =:= ?EN_ADD_EXP ->
                    case lib_partner:get_lv(Partner) >= (player:get_player_max_lv(PS)) of
                        true -> throw(?PM_PAR_LV_MAX_LIMIT);
                        false ->
                            %%计算后面五级的经验
                             CalExpFun = fun(CalExpLv, CalExpAcc ) ->
                                        lib_partner:get_exp_lim(lib_partner:get_lv(Partner) + CalExpLv) + CalExpAcc
                                     end,
                             DeltaExp = lists:foldl(CalExpFun,0,lists:seq(1,?DELTA_LV_PLAYER_PAR)),
                            case lib_partner:get_exp(Partner)  >= DeltaExp andalso lib_partner:get_lv(Partner) >= player:get_lv(PS)  of
                                true -> throw(?PM_CANT_GET_EXP_BECAUSE_LV_DELTA);
                                false -> ok
                            end
                    end;
                EffCfg#goods_eff.name =:= ?EN_ADD_MP ->
                    case lib_partner:get_mp(Partner) >= lib_partner:get_mp_lim(Partner) of
                        true -> throw(?PM_PAR_MP_IS_FULL);
                        false -> ok
                    end;
                EffCfg#goods_eff.name =:= ?EN_ADD_HP ->
                    case lib_partner:get_hp(Partner) >= lib_partner:get_hp_lim(Partner) of
                        true -> throw(?PM_PAR_HP_IS_FULL);
                        false -> ok
                    end;

                % 洗点道具判断
                EffCfg#goods_eff.name =:= ?EN_SUB_STR ->
                    case lib_partner:get_base_str(Partner) < util:ceil(Para * Count) + lib_partner:get_lv(Partner) of
                        true -> throw(?PM_PAR_BASE_STR_LIMIT);
                        false -> ok
                    end;
                EffCfg#goods_eff.name =:= ?EN_SUB_CON->
                    case lib_partner:get_base_con(Partner) < util:ceil(Para * Count) + lib_partner:get_lv(Partner)  of
                        true -> throw(?PM_PAR_BASE_CON_LIMIT);
                        false -> ok
                    end;
                EffCfg#goods_eff.name =:= ?EN_SUB_STA ->
                    case lib_partner:get_base_stam(Partner) < util:ceil(Para * Count) + lib_partner:get_lv(Partner)  of
                        true -> throw(?PM_PAR_BASE_STA_LIMIT);
                        false -> ok
                    end;
                EffCfg#goods_eff.name =:= ?EN_SUB_SPI ->
                    case lib_partner:get_base_spi(Partner) < util:ceil(Para * Count) + lib_partner:get_lv(Partner)  of
                        true -> throw(?PM_PAR_BASE_SPI_LIMIT);
                        false -> ok
                    end;
                EffCfg#goods_eff.name =:= ?EN_SUB_AGI ->
                    case lib_partner:get_base_agi(Partner) < util:ceil(Para * Count) + lib_partner:get_lv(Partner)  of
                        true -> throw(?PM_PAR_BASE_AGI_LIMIT);
                        false -> ok
                    end;
                EffCfg#goods_eff.name =:= ?EN_TURN_TALENT_TO_FREE ->
                    case lib_partner:get_free_talent_points(Partner) =:= (lib_partner:get_lv(Partner) * 5 - 5)  of
                        true -> throw(?PM_NOT_FREE_WASH_POINT);
                        false -> ok
                    end;
                true ->
                    ok
            end;
        false ->
            ok
    end.

do_use_goods(PS, PartnerId, Goods, Count) ->
    EffectList = lib_goods:get_effects(Goods),
    case EffectList =:= [] of
        true ->
            mod_inv:do_use_goods(PS, PartnerId, Goods, Count),
            {ok, Count};
        false ->
            EffCfg = lib_goods_eff:get_cfg_data(erlang:hd(EffectList)),
            EffectName = EffCfg#goods_eff.name,
            if
                EffectName =:= ?EN_ADD_EXP -> %% 单个使用
                    mod_inv:do_use_goods(PS, PartnerId, Goods),
                    F = fun(_X, {Sum, Ret}) ->
                        case check_use_goods(PS, PartnerId, Goods, 1) of
                            ok ->
                                mod_inv:do_use_goods(PS, PartnerId, Goods),
                                {Sum + 1, Ret};
                            {fail, Reason} ->
                                {Sum, Reason}
                        end
                    end,
                    {TemTotal, Result} = lists:foldl(F, {0, ?RES_OK}, lists:seq(1, Count - 1)),
                    case Result =:= ?RES_OK of
                        true -> skip;
                        false -> lib_send:send_prompt_msg(PS, Result)
                    end,
                    {ok, TemTotal+1};
                true ->
                    mod_inv:do_use_goods(PS, PartnerId, Goods, Count),
                    {ok, Count}
            end
    end.


check_batch_free_partner(PS, PartnerIdList) ->
    try 
        check_batch_free_partner__(PS, PartnerIdList)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_batch_free_partner__(PS, PartnerIdList) ->
    ?Ifc(lists:member(mod_partner:get_main_partner_id(PS), PartnerIdList))
        throw(?PM_CANT_FREE_MAIN_PARTNER)
    ?End,

    F = fun(Id, Acc) ->
        case player:has_partner(PS, Id) of
            false -> Acc;
            true ->
                case lib_partner:get_partner(Id) of
                    null -> Acc;
                    Partner -> [Partner | Acc]
                end
        end
    end,
    PartnerList = lists:foldl(F, [], PartnerIdList),

    ?Ifc (length(PartnerIdList) =/= length(PartnerList))
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    F0 = fun(ParObj, AccList) ->
        case lib_partner:is_main_partner(ParObj) orelse lib_partner:is_fighting(ParObj) of
            true -> AccList;
            false -> [ParObj | AccList]
        end
    end,

    ParObjRest = lists:foldl(F0, [], PartnerList),
    ?Ifc (length(ParObjRest) =/= length(PartnerList))
        throw(?PM_PAR_CANT_FREE_WHEN_IN_BATTLE)
    ?End,

    IsEquippedArts = lib_train:get_isequipped_arts_by_role(),
    F2 = fun(Art) ->
            PartnerId = Art#role_arts.partner_id,
            lists:foreach(fun(X) ->
                            case X =:= PartnerId of
                                true -> throw(?PM_ART_ISEQUIPED_PARTNER);
                                false -> skip
                            end end, PartnerIdList)
    end,
    lists:foreach(F2, IsEquippedArts),

    {GoodsList, AllEqList, PGL} = get_return_goods_for_free(player:id(PS), PartnerList),
    case mod_inv:check_batch_add_goods(player:get_id(PS), GoodsList ++ AllEqList) of
        {fail, Reason} -> throw(Reason);
        ok -> {ok, PartnerList, GoodsList, PGL}
    end.


check_free_partner_in_hotel(PS, IdList) when is_list(IdList) ->
    case get_find_par_info(player:id(PS)) of
        null -> {fail, ?PM_PAR_NOT_EXISTS};
        FindPar ->
            F0 = fun(Id, Acc) ->
                case lists:keyfind(Id, #partner.id, FindPar#find_par.par_list) of
                    false -> Acc;
                    Partner -> [Partner | Acc]
                end
            end,
            PartnerList = lists:foldl(F0, [], IdList),
            
            {GoodsList, AllEqList, PGL} = get_return_goods_for_free(player:id(PS), PartnerList),
            
            case mod_inv:check_batch_add_goods(player:get_id(PS), GoodsList ++ AllEqList) of
                {fail, Reason} -> {fail, Reason};
                ok -> {ok, PartnerList, GoodsList, FindPar, PGL}
            end
    end;

check_free_partner_in_hotel(PS, FindPar) ->
    PartnerList = FindPar#find_par.par_list,
    
    {GoodsList, AllEqList, PGL} = get_return_goods_for_free(player:id(PS), PartnerList),

    case mod_inv:check_batch_add_goods(player:get_id(PS), GoodsList ++ AllEqList) of
        {fail, Reason} -> {fail, Reason};
        ok -> {ok, PartnerList, GoodsList, PGL}
    end.


check_one_key_free_partner(PS) ->
    try 
        check_one_key_free_partner__(PS)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


%% 将玩家携带的白色、绿色品质女妖全部放生
check_one_key_free_partner__(PS) ->
    F = fun(Id, Acc) ->
        case player:has_partner(PS, Id) of
            false -> Acc;
            true ->
                case lib_partner:get_partner(Id) of
                    null -> Acc;
                    Partner ->
                        case lib_partner:get_ref_lv(Partner) < 60 of
                            false ->
                                Acc;
                            true ->
                                case lib_partner:get_quality(Partner) of
                                    ?QUALITY_WHITE -> [Partner | Acc];
                                    ?QUALITY_GREEN -> [Partner | Acc];
                                    _Any -> Acc
                                end
                        end
                end
        end
    end,
    TPartnerList = lists:foldl(F, [], player:get_partner_id_list(PS)),

    F1 = fun(ParObj, AccList) ->
        case lib_partner:is_main_partner(ParObj) orelse lib_partner:is_fighting(ParObj) orelse lib_partner:is_locked(ParObj) of
            true -> AccList;
            false -> [ParObj | AccList]
        end
    end,

    ParObjList = lists:foldl(F1, [], TPartnerList),
    {GoodsList, AllEqList, PGL} = get_return_goods_for_free(player:id(PS), ParObjList),

    IsEquippedArts = lib_train:get_isequipped_arts_by_role(),
    F2 = fun(Art) ->
        PartnerId = Art#role_arts.partner_id,
        lists:foreach(fun(X) ->
                        case lib_partner:get_id(X) =:= PartnerId of
                            true -> throw(?PM_ART_ISEQUIPED_PARTNER);
                            false -> skip
                        end end, ParObjList)
    end,
    lists:foreach(F2, IsEquippedArts),

    case mod_inv:check_batch_add_goods(player:get_id(PS), GoodsList ++ AllEqList) of
        {fail, Reason} -> throw(Reason);
        ok -> {ok, ParObjList, GoodsList, PGL}
    end.
    

do_batch_free_partner(PS, PartnerList, GoodsList, PGL) ->
    PlayerId = player:id(PS),
    F = fun({Partner, GoodsL}, Acc) ->
        PartnerId = lib_partner:get_id(Partner),
        mod_partner:db_delete_partner(player:id(PS), PartnerId),
        mod_partner:del_partner_from_ets(PartnerId),
        %% 删除离线竞技场宠物数据
        % lib_offline_arena:del_partner_offline_data(PartnerId, PS),

        lib_log:statis_role_action(PS, [], ?LOG_PARTNER, "release", [lib_partner:get_name(Partner),lib_partner:get_quality(Partner), 
            lib_partner:get_lv(Partner), util:term_to_string(GoodsL)]),

        
        lib_log:partner_release(PartnerId, lib_partner:get_no(Partner), PS),
        [mod_equip:takeoff_equip(for_partner, PlayerId, PartnerId, EquipingGoods) || EquipingGoods <- mod_equip:get_partner_equip_list(PlayerId, PartnerId)],
        case lib_partner:get_mount_id(Partner) of
            ?INVALID_ID -> skip;
            MountId -> lib_mount:concel_connect_partner(PS, MountId, PartnerId, 0)
        end,
        [PartnerId | Acc]
    end,
    IdList = lists:foldl(F, [], PGL),

    case PartnerList =:= [] of
        true ->
            {ok, []};
        false ->
            OldList = player:get_partner_id_list(PS),
        PS1 = player_syn:set_partner_id_list(PS, OldList -- IdList),

            %% 玩家宠物放生，需要重新玩家的战斗力
            ply_attr:recount_battle_power(PS1),

            {ok,RetGoods} = mod_inv:batch_smart_add_new_goods(player:get_id(PS1), GoodsList, [{bind_state, ?BIND_ALREADY}], [?LOG_PARTNER, "release"]),

            % 增加分解提示
            F1 = fun({Id, No, Cnt}) ->
                    case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                        null -> skip;
                        Goods ->
                            ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt,Id]})
                    end
            end,
            [F1(X) || X <- RetGoods],

            mod_achievement:notify_achi(free_partner, [], PS1),
            lib_event:event(free_partner, [], PS1),

            case lists:member(player:get_follow_partner_id(PS1), IdList) of
                false -> skip;
                true -> handle_for_del_follow_partner(PS1)
            end,

            {ok, IdList}
    end.


do_free_partner_in_hotel(PS, PartnerList, GoodsList, FindPar, PGL) ->
    F = fun({Partner, GoodsL}, Acc) ->
        PartnerId = lib_partner:get_id(Partner),
        mod_partner:db_delete_partner_hotel(player:id(PS), PartnerId),
        lib_log:statis_role_action(PS, [], ?LOG_PARTNER, "release", [lib_partner:get_name(Partner),lib_partner:get_quality(Partner), 
            lib_partner:get_lv(Partner), util:term_to_string(GoodsL)]),
        [PartnerId | Acc]
    end,
    IdList = lists:foldl(F, [], PGL),
    case PartnerList =:= [] of
        true -> {ok, IdList};
        false ->
            mod_inv:batch_smart_add_new_goods(player:get_id(PS), GoodsList, [{bind_state, ?BIND_ALREADY}], [?LOG_PARTNER, "release"]),
            FindPar1 = FindPar#find_par{par_list = FindPar#find_par.par_list -- PartnerList},
            mod_partner:update_find_par_to_ets(FindPar1),
            {ok, IdList}
    end.


%% 检查单次修炼是否成功
check_cultivate_partner(PS, PartnerId, AccMoney, AccGoodsL) ->
    try check_cultivate_partner__(PS, PartnerId, AccMoney, AccGoodsL) of
        {ok, Partner, DataCultivate} ->
            {ok, Partner, DataCultivate}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_cultivate_partner__(PS, PartnerId, AccMoney, AccGoodsL) ->
    ?Ifc (not player:has_partner(PS, PartnerId))
        throw(?PM_PAR_NOT_EXISTS)
    ?End,
    Partner = lib_partner:get_partner(PartnerId),

    ?Ifc (not ply_sys_open:is_open(Partner, ?SYS_CULTIVATE_PARTNER))
        throw(?PM_PAR_LV_LIMIT)
    ?End,

	CultivateLv = lib_partner:get_cultivate_lv(Partner),
	CultivateLayer = lib_partner:get_cultivate_layer(Partner),
	PartnerLv = lib_partner:get_lv(Partner),
	case data_partner_cultivate:get(CultivateLv, CultivateLayer) of
		#partner_cultivate{need_lv = NeedLv} ->
			if  
				PartnerLv >= NeedLv ->
					ok;
				true ->
					throw(?PM_PAR_LV_LIMIT)
			end;
		null ->
			throw(?PM_CULTIVATE_MAX)
	end,

    No = (data_partner_cultivate:get(lib_partner:get_cultivate_lv(Partner), lib_partner:get_cultivate_layer(Partner)))#partner_cultivate.no,
    NextData = data_partner_cultivate:get(No + 1),
    ?Ifc (NextData =:= null)
        throw(?PM_CULTIVATE_MAX)
    ?End,

    {NextLv, NextLayer} = NextData,
    DataCultivate = data_partner_cultivate:get(NextLv, NextLayer),
	
	?Ifc (PartnerLv < DataCultivate#partner_cultivate.need_lv)
        throw(?PM_PAR_LV_LIMIT)
    ?End,

    ?Ifc (lib_partner:get_state(Partner) /= ?PAR_STATE_REST_UNLOCKED  andalso lib_partner:get_state(Partner) /= ?PAR_STATE_JOIN_BATTLE_UNLOCKED)
        throw(?PM_PAR_STATE_ERROR)
    ?End,
    {MoneyType, NeedMoney} = DataCultivate#partner_cultivate.bind_yuanbao,

    LastMoney = case AccMoney =:= [] of
                    true -> 0;
                    false ->
                        [{_, Money}] = AccMoney,
                        Money
                end,
    TotalMoney = NeedMoney + LastMoney,

    RetMoney = check_money(PS, [{MoneyType, TotalMoney}]),

    ?Ifc (RetMoney =/= 0)
        throw(RetMoney)
    ?End,

    GoodsList = [{DataCultivate#partner_cultivate.alchemy_no, DataCultivate#partner_cultivate.alchemy_num} | AccGoodsL],

    case mod_inv:check_batch_destroy_goods(player:get_id(PS), GoodsList) of
        {fail, _Reason} -> throw(?PM_PAR_ALCHEMY_LIMIT);
        ok -> {ok, Partner, DataCultivate}
    end.

    


do_cultivate_partner(PS, _PartnerId, 0, AccMoney, AccGoodsL, RetList) ->
    PS1 =
        case AccMoney =/= [] of
            true ->
                [{MoneyType, CostMoney}] = AccMoney,
                player_syn:cost_money(PS, MoneyType, CostMoney, [?LOG_PARTNER, "cultivate"]);
            false -> PS
        end,

    mod_inv:destroy_goods_WNC(player:get_id(PS1), AccGoodsL, [?LOG_PARTNER, "cultivate"]),
    {RetList, PS1};

do_cultivate_partner(PS, PartnerId, Count, AccMoney, AccGoodsL, RetList) when Count > 0 ->
    case check_cultivate_partner(PS, PartnerId, AccMoney, AccGoodsL) of
        {fail, Reason} ->
            PS1 =
                case AccMoney =/= [] of
                    true ->
                        [{MoneyType, CostMoney}] = AccMoney,
                        player_syn:cost_money(PS, MoneyType, CostMoney, [?LOG_PARTNER, "cultivate"]);
                    false -> PS
                end,

            mod_inv:destroy_goods_WNC(player:get_id(PS1), AccGoodsL, [?LOG_PARTNER, "cultivate"]),
            {RetList ++ [{Reason, 0}], PS1}; %% {结果代码, 本次获得修炼值}
        {ok, Partner, DataCultivate} ->
            LastMoney = case AccMoney =:= [] of
                            true -> 0;
                            false ->
                                [{_, Money}] = AccMoney,
                                Money
                        end,
            {MoneyType, AccMoney1} = DataCultivate#partner_cultivate.bind_yuanbao,
            AccMoney2 = LastMoney + AccMoney1,
            AccGoodsL1 = [{DataCultivate#partner_cultivate.alchemy_no, DataCultivate#partner_cultivate.alchemy_num} | AccGoodsL],

            OldCultivateLv = lib_partner:get_cultivate_lv(Partner),
            {RetCode, LevelToUp} = {0, 1},

            Partner2 =
                case lib_partner:add_cultivate_level(lib_partner:get_id(Partner), LevelToUp) of
                    {fail, _Reason} -> Partner;
                    {ok, Partner3} -> Partner3
                end,

            NowCultivateLv = lib_partner:get_cultivate_lv(Partner2),

            case OldCultivateLv of
                NowCultivateLv ->
                    mod_partner:update_partner_to_ets(Partner2),
                    skip;
                _ ->
                    % 2关联战力系统刷新，战力发生变化
                    Partner4 = lib_partner:calc_base_attrs(Partner2),
                    Partner5 = lib_partner:recount_total_attrs(Partner4),
                    Partner6 = lib_partner:recount_battle_power(Partner5),
                    mod_partner:update_partner_to_ets(Partner6)
            end,
			%% 修炼概率扩展格子
			cultivate_expand_skill_slot(PS, PartnerId),
            RetList1 = RetList ++ [{RetCode, LevelToUp}],
            do_cultivate_partner(PS, PartnerId, Count - 1, [{MoneyType, AccMoney2}], AccGoodsL1, RetList1)

    end.


check_evolve_partner(PS, PartnerId) ->
    try check_evolve_partner__(PS, PartnerId) of
        {ok, Partner, MoneyType, NeedMoney, GoodsList} ->
            {ok, Partner, MoneyType, NeedMoney, GoodsList}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_evolve_partner_old(PS, PartnerId, IdList) ->
    try check_evolve_partner_old__(PS, PartnerId, IdList) of
        {ok, Partner, NeedMoney, ParList} ->
            {ok, Partner, NeedMoney, ParList}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


calc_evolve_goods(PartnerId) ->
	Partner = lib_partner:get_partner(PartnerId),
    ?Ifc (Partner =:= null)
        throw(?PM_PAR_NOT_EXISTS)
    ?End,
	RefLv = lib_partner:get_ref_lv(Partner),
	EvolveCoef = lib_partner:get_evolve_coef(RefLv),
	EvolveCur = lib_partner:get_evolve(Partner),
    Quality = lib_partner:get_quality(Partner),
    EvolveLv = lib_partner:get_evolve_lv(Partner),
	case data_partner_evolve:get(Quality, EvolveLv) of
		#partner_evolve{no = No, evolve = Evolve} ->
			NoNext = No + 1,
			case data_partner_evolve:get(NoNext) of
				null ->
					throw(?PM_PAR_EVOLVE_LV_LIMIT);
				{QualityNext, EvolveLvNext} ->
					#partner_evolve{evolve = EvolveNext} = data_partner_evolve:get(QualityNext, EvolveLvNext),
					NeedEvolve = util:ceil((EvolveNext - Evolve) * EvolveCoef),
					HaveEvolve = EvolveCur - util:ceil(Evolve * EvolveCoef),
					Count = NeedEvolve - HaveEvolve,
					if Count =< 0 ->
							throw(?PM_PAR_EVOLVE_LV_LIMIT);
						true ->
							Count
  					end
			end;
		null ->
			throw(?PM_PAR_EVOLVE_LV_LIMIT)
	end.

check_evolve_partner__(PS, PartnerId) ->
    Partner = lib_partner:get_partner(PartnerId),

    ?Ifc (Partner =:= null)
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    ?Ifc (lib_partner:is_locked(Partner))
        throw(?PM_PAR_CANT_EVOLVE_WHEN_IN_LOCKED_STATE)
    ?End,

    ?Ifc (not ply_sys_open:is_open(Partner, ?SYS_EVOLVE_PARTNER))
        throw(?PM_PAR_LV_LIMIT)
    ?End,

    CurEvolveLv = lib_partner:get_evolve_lv(Partner),
    Quality = lib_partner:get_quality(Partner),
    DataEvolve = data_partner_evolve:get(Quality, CurEvolveLv),

    %% 获取下一官阶数据
    NoList = data_partner_evolve:get_all_evolve_no_list(),
    NoNext = DataEvolve#partner_evolve.no + 1,
    [{MoneyType, NeedMoney}, GoodsList] = case lists:member(NoNext, NoList) of
                                                true ->
                                                    {QualityNext, EvolveLvNext} =  data_partner_evolve:get(NoNext),
                                                    DataEvolveNext = data_partner_evolve:get(QualityNext, EvolveLvNext),
                                                    [DataEvolveNext#partner_evolve.bind_yuanbao, DataEvolveNext#partner_evolve.consume_goods];
                                                false ->
                                                    %% 当前已经是最高官阶
                                                    [{null, null}, null]
                                          end,
    RetMoney = check_money(PS, [{MoneyType, NeedMoney}]),

    ?Ifc (RetMoney =/= 0)
        throw(RetMoney)
    ?End,

    ?Ifc (DataEvolve =:= null orelse MoneyType =:= null )
        throw(?PM_PAR_EVOLVE_LV_LIMIT)
    ?End,

    ?Ifc (lib_partner:get_lv(Partner) < DataEvolve#partner_evolve.par_lv_need)
        throw(?PM_PAR_LV_LIMIT)
    ?End,

    case mod_inv:check_batch_destroy_goods(player:get_id(PS), GoodsList) of
        {fail, Reason} -> throw(Reason);
        ok -> {ok, Partner, MoneyType, NeedMoney, GoodsList}
    end.

check_money(_PS, []) ->
    0;
check_money(PS, [{MoneyType, Count} | T]) ->
    ?DEBUG_MSG("check_money=~p,~p",[MoneyType, Count]),
    case player:has_enough_money(PS, MoneyType, Count) of
        false ->
            case MoneyType of
                ?MNY_T_GAMEMONEY -> ?PM_GAMEMONEY_LIMIT;
                ?MNY_T_YUANBAO -> ?PM_YB_LIMIT;
                ?MNY_T_BIND_GAMEMONEY -> ?PM_BIND_GAMEMONEY_LIMIT;
                ?MNY_T_BIND_YUANBAO -> ?PM_BIND_YB_LIMIT;
                ?MNY_T_INTEGRAL -> ?PM_INTEGRAL_LIMIT;
                ?MNY_T_VITALITY -> ?PM_VITALITY_LIMIT;
                ?MNY_T_COPPER -> ?PM_COPPER_LIMIT;
                ?MNY_T_CHIVALROUS -> ?PM_CHIVALROUS_LIMIT;
                ?MNY_T_EXP -> ?PM_EXP_LIMIT;
                ?MNY_T_GUILD_CONTRI -> ?PM_GUILD_CONTRI_LIMIT;
                ?MNY_T_QUJING       ->  ?PM_JINGWEN_LIMIT

            end;
        true -> check_money(PS, T)
    end;
check_money(_PS, _) ->
    ?PM_DATA_CONFIG_ERROR.

check_evolve_partner_old__(PS, PartnerId, IdList) ->
    ?Ifc (not player:has_partner(PS, PartnerId))
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    ?Ifc(lists:member(mod_partner:get_main_partner_id(PS), IdList))
        throw(?PM_CANT_SACRIFICE_MAIN_PARTNER)
    ?End,

    F = fun(Id, Sum) ->
        case player:has_partner(PS, Id) of
            true -> Sum + 1;
            false -> Sum
        end
    end,

    ?Ifc (lists:foldl(F, 0, IdList) =/= length(IdList))
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    Partner = lib_partner:get_partner(PartnerId),
    ?Ifc (Partner =:= null)
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    ?Ifc (lib_partner:is_locked(Partner))
        throw(?PM_PAR_CANT_EVOLVE_WHEN_IN_LOCKED_STATE)
    ?End,

    ?Ifc (not ply_sys_open:is_open(Partner, ?SYS_EVOLVE_PARTNER))
        throw(?PM_PAR_LV_LIMIT)
    ?End,

    CurEvolveLv = lib_partner:get_evolve_lv(Partner),
    Quality = lib_partner:get_quality(Partner),
    DataEvolve = data_partner_evolve:get(Quality, CurEvolveLv),

    ?Ifc (DataEvolve =:= null)
        throw(?PM_PAR_EVOLVE_LV_LIMIT)
    ?End,

    F1 = fun(Id, {Sum, Acc, AccEq}) ->
        case lib_partner:get_partner(Id) of
            null -> {Sum, Acc, AccEq};
            ParObj ->
                case lib_partner:is_locked(ParObj) of
                    true -> {Sum, Acc, AccEq};
                    false ->
                        Q = lib_partner:get_quality(ParObj),
                        Lv = lib_partner:get_evolve_lv(ParObj),
                        case data_partner_evolve:get(Q, Lv) of
                            null -> {Sum, Acc, AccEq};
                            Data -> 
                                EqList = mod_equip:get_partner_equip_list(player:id(PS), Id),
                                {Data#partner_evolve.bind_yuanbao + Sum, [ParObj | Acc], EqList ++ AccEq}
                        end
                end
        end
    end,
    
    {NeedMoney, ParList, AllEqList} = lists:foldl(F1, {0, [], []}, IdList),

    ?Ifc (length(ParList) =/= length(IdList))
        throw(?PM_PAR_CANT_SACRIFICE_WHEN_IN_LOCKED_STATE)
    ?End,
    
    ?Ifc (not player:has_enough_bind_gamemoney(PS, NeedMoney))
        throw(?PM_GAMEMONEY_LIMIT)
    ?End,

    ?Ifc (lib_partner:get_lv(Partner) < DataEvolve#partner_evolve.par_lv_need)
        throw(?PM_PAR_LV_LIMIT)
    ?End,

    case mod_inv:check_batch_add_goods(player:id(PS), AllEqList) of
        {fail, Reason} -> throw(Reason);
        ok -> {ok, Partner, NeedMoney, ParList}
    end.

%% 计算下一官阶需要的进化值
check_evolve_next(PartnerId) ->
	Partner = lib_partner:get_partner(PartnerId),
	PartnerLv = lib_partner:get_lv(Partner),
	Quality = lib_partner:get_quality(Partner),
	EvolveLv = lib_partner:get_evolve_lv(Partner),
	%% 获取下一官阶数据
    DataEvolve = data_partner_evolve:get(Quality, EvolveLv),
	NoList = data_partner_evolve:get_all_evolve_no_list(),
	NoNext = DataEvolve#partner_evolve.no + 1,
	case lists:member(NoNext, NoList) of
		true ->
			{QualityNext, EvolveLvNext} =  data_partner_evolve:get(NoNext),  
			DataEvolveNext = data_partner_evolve:get(QualityNext, EvolveLvNext),
			case PartnerLv >= DataEvolveNext#partner_evolve.par_lv_need of
				true ->
					%% 满足条件，计算是否足够修炼丹和游戏币
                    {ok, 1};
				false ->
					{fail, ?PM_PAR_LV_LIMIT}
			end;
		false ->
			%% 当前已经是最高官阶
			{fail, ?PM_PAR_EVOLVE_LV_LIMIT}
	end.
    

do_evolve_partner(PS, Partner, MoneyType, NeedMoney, GoodsList) ->
    player:cost_money(PS, MoneyType, NeedMoney, [?LOG_PARTNER, "evolve"]),

    mod_inv:destroy_goods_WNC(player:get_id(PS), GoodsList, [?LOG_PARTNER, "evolve"]),
   
	OldQuality = lib_partner:get_quality(Partner),

    AddEvolveLv = 1,
    {NewQuality, _NewEvolveLv} = lib_partner:decide_new_quality_evolve_lv(Partner, AddEvolveLv),

    Partner1 =
        case NewQuality =/= OldQuality of
            %change_base_aptitude(Partner, OldQuality, NewQuality);
            true -> Partner ;
            false -> Partner
        end,

    {Partner2, InfoType, SkillId} = 
        case NewQuality =/= OldQuality of
            true ->
				%% 进化不在获得技能，注释掉20191115
				%% try_add_postnatal_skill(Partner1);
				{Partner1, 0, 0};
            false -> {Partner1, 0, 0}
        end,

    Partner3 = lib_partner:add_evolve(PS, Partner2, AddEvolveLv),

    PS1 = PS,
    % PS1 = player_syn:set_partner_id_list(PS, player:get_partner_id_list(PS) -- IdList),

    mod_achievement:notify_achi(evolve_partner, [], PS1),
    lib_event:event(evolve_partner, [], PS),

    case lib_partner:is_fighting(Partner3) of
        true -> ply_attr:recount_battle_power(PS1);
        false -> skip
    end,

    case lib_partner:is_follow_partner(Partner3) of
        false -> skip;
        true -> lib_partner:notify_main_partner_info_change_to_AOI(PS, Partner3)
    end,

    lib_log:statis_role_action(PS, [], ?LOG_PARTNER, "evolve", [lib_partner:get_name(Partner), OldQuality, lib_partner:get_quality(Partner3), 
            util:term_to_string([{?VGOODS_BIND_GAMEMONEY, NeedMoney}]), lib_partner:get_id(Partner)]),

    {ok, Partner3, InfoType, SkillId, OldQuality}.

do_evolve_partner_old(PS, Partner, IdList, NeedMoney, ParList) ->
    player:cost_bind_gamemoney(PS, NeedMoney, [?LOG_PARTNER, "evolve"]),
    
    OldQuality = lib_partner:get_quality(Partner),
    F = fun(ParObj, Sum) ->
        Id = lib_partner:get_id(ParObj),
        Q = lib_partner:get_quality(ParObj),
        Lv = lib_partner:get_evolve_lv(ParObj),

        mod_partner:del_partner_from_ets(Id),
        mod_partner:db_delete_partner(player:id(PS), Id),

        [mod_equip:takeoff_equip(for_partner, player:id(PS), Id, EquipingGoods) || EquipingGoods <- mod_equip:get_partner_equip_list(player:id(PS), Id)],
 
        %% 删除离线竞技场宠物数据
        % lib_offline_arena:del_partner_offline_data(Id, PS),
        case lib_partner:get_mount_id(ParObj) of
            ?INVALID_ID -> skip;
            MountId -> lib_mount:concel_connect_partner(PS, MountId, Id, 0)
        end,

        case data_partner_evolve:get(Q, Lv) of
            null -> Sum;
            Data -> Data#partner_evolve.evolve_support + Sum
        end
    end,
    
    GetEvolve = lists:foldl(F, 0, ParList),
    NowEvolve = lib_partner:get_evolve(Partner),
    {NewQuality, _NewEvolveLv} = lib_partner:decide_new_quality_evolve_lv(Partner, GetEvolve + NowEvolve),

    Partner1 =
        case NewQuality =/= OldQuality of
            true -> Partner; %%change_base_aptitude(Partner, OldQuality, NewQuality);
            false -> Partner
        end,

    {Partner2, InfoType, SkillId} = 
        case NewQuality =/= OldQuality of
            true -> try_add_postnatal_skill(Partner1);
            false -> {Partner1, 0, 0}
        end,

    Partner3 = lib_partner:add_evolve(PS, Partner2, GetEvolve),

    PS1 = player_syn:set_partner_id_list(PS, player:get_partner_id_list(PS) -- IdList),

    mod_achievement:notify_achi(evolve_partner, [], PS1),
    lib_event:event(evolve_partner, [], PS),

    case lib_partner:is_fighting(Partner3) of
        true -> ply_attr:recount_battle_power(PS1);
        false -> skip
    end,

    case lib_partner:is_follow_partner(Partner3) of
        false -> skip;
        true -> lib_partner:notify_main_partner_info_change_to_AOI(PS, Partner3)
    end,

    case lists:member(player:get_follow_partner_id(PS1), IdList) of
        false -> skip;
        true -> handle_for_del_follow_partner(PS1)
    end,

    lib_log:statis_role_action(PS, [], ?LOG_PARTNER, "evolve", [lib_partner:get_name(Partner), OldQuality, lib_partner:get_quality(Partner3), 
            util:term_to_string([{?VGOODS_BIND_GAMEMONEY, NeedMoney}]), lib_partner:get_id(Partner)]),

    {ok, Partner3, InfoType, SkillId, OldQuality}.
   

try_add_postnatal_skill(Partner) ->
    Count = lib_partner:get_max_postnatal_skill_slot(Partner),
    PS = player:get_PS(Partner#partner.player_id),
    case Count < ?PAR_MAX_POSTNATAL_SKILL_SLOT of
        false -> {Partner, 0, 0};
        true ->
            RandNum = util:rand(1, ?PROBABILITY_BASE),
            case 1 =< RandNum andalso RandNum =< ?PAR_PROB_EVOLVE_ADD_SKILL_SLOT of
                true -> 
                    Partner1 = lib_partner:set_max_postnatal_skill_slot(Partner, min(Count + 1, ?PAR_MAX_POSTNATAL_SKILL_SLOT)),
                    RandNum1 = util:rand(1, ?PROBABILITY_BASE),
                    case 1 =< RandNum1 andalso RandNum1 =< ?PAR_PROB_EVOLVE_ADD_SKILL of
                        false -> 
                            % 获得技能格子
                            ply_tips:send_sys_tips(PS, {partner_add_skill1, [
                                                player:get_name(PS),
                                                player:id(PS),
                                                lib_partner:get_name(Partner),
                                                lib_partner:get_id(Partner), 
                                                lib_partner:get_quality(Partner),
                                                lib_partner:get_no(Partner)
                                            ]}),

                            {Partner1, 1, 0};
                        true ->
                            ParBornData = data_partner:get(lib_partner:get_no(Partner)),
                            % 改成获得更多技能
                            {L11, L22, L33, L44} = classify_postnatal_skill_by_rarity(ParBornData#par_born_data.reserve_skill_pool),
                            AddPostnatalSkillL = get_postnatal_skill([], 1, L11, L22, L33, L44, lib_partner:get_skill_name_list(Partner1)),
                            case AddPostnatalSkillL =:= [] of
                                true -> 
                                    ?ASSERT(false),

                                    % 获得技能格子
                                    ply_tips:send_sys_tips(PS, {partner_add_skill1, [
                                                        player:get_name(PS),
                                                        player:id(PS),
                                                        lib_partner:get_name(Partner),
                                                        lib_partner:get_id(Partner), 
                                                        lib_partner:get_quality(Partner),
                                                        lib_partner:get_no(Partner)
                                                    ]}),

                                    {Partner1, 1, 0};
                                false ->
                                    Skill = erlang:hd(AddPostnatalSkillL),
                                    case lib_partner:has_skill(Partner1, Skill#skl_brief.id,noequip) of
                                        true -> 
                                            % 获得技能格子
                                            ply_tips:send_sys_tips(PS, {partner_add_skill1, [
                                                                player:get_name(PS),
                                                                player:id(PS),
                                                                lib_partner:get_name(Partner),
                                                                lib_partner:get_id(Partner), 
                                                                lib_partner:get_quality(Partner),
                                                                lib_partner:get_no(Partner)
                                                            ]}),

                                            {Partner1, 1, 0};
                                        false ->
                                            % 获得技能
                                            ply_tips:send_sys_tips(PS, {partner_add_skill2, [
                                                                player:get_name(PS),
                                                                player:id(PS),
                                                                lib_partner:get_name(Partner),
                                                                lib_partner:get_id(Partner), 
                                                                lib_partner:get_quality(Partner),
                                                                lib_partner:get_no(Partner),
                                                                Skill#skl_brief.id
                                                            ]}),

                                            {lib_partner:set_skill_list(Partner1, lib_partner:get_skill_list(Partner1) ++ AddPostnatalSkillL), 2, Skill#skl_brief.id}
                                    end
                            end
                    end;
                false -> {Partner, 0, 0}
            end
    end.


change_base_aptitude(Partner, OldQuality, NowQuality) ->
    NatureNo = lib_partner:get_nature(Partner),
    PartnerNo = lib_partner:get_no(Partner),
    PlayerLvNeed = (data_partner:get(PartnerNo))#par_born_data.ref_lv,

    MinOld =
        case OldQuality of
            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_min;
            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_min;
            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_min;
            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_min;
            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_min;
            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_min;
            _Any1 -> ?ASSERT(false, 0)
        end,

    MinNow =
        case NowQuality of
            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_min;
            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_min;
            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_min;
            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_min;
            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_min;
            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_min;
            _Any2 -> ?ASSERT(false, 0)
        end,

    Add = MinNow - MinOld,

    GrowBase = lib_partner:get_base_grow(Partner) + Add,
    LifeAptBase = lib_partner:get_base_life_aptitude(Partner) + Add,
    MagAptBase = lib_partner:get_base_mag_aptitude(Partner) + Add,
    PhyAttAptBase = lib_partner:get_base_phy_att_aptitude(Partner) + Add,
    PhyDefAptBase = lib_partner:get_base_phy_def_aptitude(Partner) + Add,
    MagAttAptBase = lib_partner:get_base_mag_att_aptitude(Partner) + Add,
    MagDefAptBase = lib_partner:get_base_mag_def_aptitude(Partner) + Add,
    SpeedAptBase = lib_partner:get_base_speed_aptitude(Partner) + Add,

    TrainAttrs = 
    to_base_train_attrs_record(PartnerNo, NowQuality, NatureNo, {GrowBase,LifeAptBase,MagAptBase,PhyAttAptBase,MagAttAptBase,PhyDefAptBase,MagDefAptBase,SpeedAptBase}),
    lib_partner:set_base_train_attrs(Partner, TrainAttrs).


check_wash_partner(PS, PartnerId, Type) ->
    case lists:member(Type, [1, 2]) of
        false -> {fail, ?PM_PARA_ERROR};
        true ->
            case player:has_partner(PS, PartnerId) of
                false -> {fail, ?PM_PAR_NOT_EXISTS};
                true ->
                    Partner = lib_partner:get_partner(PartnerId),
                    Data = data_quality_relate:get(lib_partner:get_quality(Partner)),
                    case lib_partner:is_locked(Partner) of
                        true ->
                            {fail, ?PM_PAR_CANT_WASH_WHEN_IN_LOCKED_STATE};
                        false ->
                            WashCoef = 
                                case get_partner_coef_cfg(Partner) of
                                    null -> 1;
                                    CoefCfg -> CoefCfg#ability_lv_cfg.wash_goods_count_coef
                                end,
                            if
                                Type =:= 3 ->  %% 这里不会用到,故特意改为 3
                                    GoodsCount = util:ceil(Data#quality_relate_data.wash_elixir_count * WashCoef),
                                    case mod_inv:get_goods_count_in_bag_by_no(player:get_id(PS), Data#quality_relate_data.wash_elixir_no) < GoodsCount of
                                        true -> {fail, ?PM_PAR_WASH_ELIXIR_LIMIT};
                                        false -> {ok, Partner, WashCoef}
                                    end;
								Type =:= 2 ->
									{ok, Partner};
                                true ->
                                    {GoodsNo, GoodsCount} = data_special_config:get(partner_wash_cost),
                                    case mod_inv:get_goods_count_in_bag_by_no(player:get_id(PS), GoodsNo) < GoodsCount of
                                        true -> {fail, ?PM_PAR_WASH_ELIXIR_LIMIT};
                                        false -> {ok, Partner}
                                    end
                            end
                    end
            end
    end.

%% 洗练
do_wash_partner(PS, Partner, 1) ->
%%    Data = data_quality_relate:get(lib_partner:get_quality(Partner)),
    {GoodsNo, GoodsCount} = data_special_config:get(partner_wash_cost),
	mod_inv:destroy_goods_WNC(player:get_id(PS), [{GoodsNo, GoodsCount}], [?LOG_PARTNER, "wash"]),

    BaseTrainAttrs = init_base_train_attrs(lib_partner:get_no(Partner), lib_partner:get_nature(Partner), lib_partner:get_quality(Partner), 1),
    Partner6 = Partner#partner{base_train_attrs_tmp = BaseTrainAttrs},

    Partner7 = lib_partner:calc_base_attrs(Partner6),
    Partner8 = lib_partner:recount_total_attrs(Partner7),
    Partner9 = lib_partner:recount_battle_power(Partner8),
    Partner10 = lib_partner:set_wash_count(Partner9, lib_partner:get_wash_count(Partner9) + 1),
    mod_partner:update_partner_to_ets(Partner10),
    
    ply_attr:recount_battle_power(PS),
    lib_event:event(wash_partner, [], PS),
    ok;

%% 替换
do_wash_partner(PS, Partner, 2) ->
	 Bta0 = #base_train_attrs{},
	IsValid = case Partner#partner.base_train_attrs_tmp of
				  #base_train_attrs{} = Bta ->
					  Bta =/= Bta0;
				  _ ->
					  ?false
			  end,
	 case IsValid of
		 ?true ->
			 Partner2 = Partner#partner{base_train_attrs = Partner#partner.base_train_attrs_tmp, base_train_attrs_tmp = Bta0},
			 Partner3 = lib_partner:calc_base_attrs(Partner2),
			 Partner4 = lib_partner:recount_total_attrs(Partner3),
			 Partner5 = lib_partner:recount_battle_power(Partner4),
			 Partner6 = lib_partner:set_wash_count(Partner5, lib_partner:get_wash_count(Partner5) + 1),
			 mod_partner:update_partner_to_ets(Partner6),
			 ply_attr:recount_battle_power(PS),
			 lib_event:event(wash_partner, [], PS),
			 ok;

		?false ->
			%% 暂时忽略处理
			ok
	end.


check_player_add_partner(PS, PartnerNo) ->
    case length(player:get_partner_id_list(PS)) >= player:get_partner_capacity(PS) of
        true -> {fail, ?PM_PAR_CARRY_LIMIT};
        false ->
            case data_partner:get(PartnerNo) of
                null ->
                    ?ASSERT(false, PartnerNo),
                    {fail, ?PM_DATA_CONFIG_ERROR};
                _Any -> ok
            end
    end.

check_player_add_partner(PS) ->
    case length(player:get_partner_id_list(PS)) >= player:get_partner_capacity(PS) of
        true -> {fail, ?PM_PAR_CARRY_LIMIT};
        false -> ok
    end.



do_player_add_partner(PS, PartnerNo, ExtraInfo) ->
    PartnerBornData = data_partner:get(PartnerNo),
    ?ASSERT(PartnerBornData /= null),

    Partner = make_partner_info(PS, PartnerBornData, ExtraInfo),
    
    Partner1 = lib_partner:calc_base_attrs(Partner),
    % Partner2 = lib_partner:calc_passi_eff_attrs(Partner1),

    MoodNo = lib_partner:decide_mood_no(),
    Partner3 = lib_partner:set_mood_no(Partner1, MoodNo),
    Partner4 = lib_partner:set_last_update_mood_time(Partner3, svr_clock:get_unixtime()),
    Partner5 = mod_partner:db_insert_partner(Partner4),

    % MoodCfg = data_partner_mood:get(MoodNo),
    % [lib_buff:partner_add_buff(player:id(PS), Partner5#partner.id, BuffNo) || BuffNo <- MoodCfg#mood_cfg.buff_no_list],
    % Partner6 = lib_partner:calc_buff_eff_attrs(Partner5),

    Partner7 = lib_partner:init_total_attrs(Partner5),
    Partner8 = lib_partner:set_battle_power(Partner7, lib_partner:calc_battle_power(Partner7)),
    
    Partner9 = 
        case length(player:get_partner_id_list(PS)) =:= 0 of %% 当前一个默认是主宠
            true ->
                lib_event:event(?TAKE_PET, [PartnerNo], PS),

                player:set_main_partner_id(PS, lib_partner:get_id(Partner8)),
                player:set_follow_partner_id(PS, lib_partner:get_id(Partner8)),

                TPartner1 = lib_partner:set_position(Partner8, ?PAR_POS_MAIN),
                TPartner2 = lib_partner:set_follow_state(TPartner1, ?PAR_FOLLOW),
                TPartner3 = lib_partner:set_state(TPartner2, ?PAR_STATE_JOIN_BATTLE_UNLOCKED),
                lib_partner:notify_main_partner_info_change_to_AOI(PS, TPartner3),
                TPartner3;
            false -> Partner8
        end,

    mod_partner:db_save_partner(Partner9),
    mod_partner:add_partner_to_ets(Partner9),
    ply_attr:recount_battle_power(PS, Partner9#partner.id),
    case lists:member(lib_partner:get_id(Partner9), player:get_partner_id_list(PS)) of
        true ->
            ?ASSERT(false),
            ?ERROR_MSG("ply_partner:do_player_add_partner() error!", []);
        false ->
            player:set_partner_id_list(PS, player:get_partner_id_list(PS) ++ [lib_partner:get_id(Partner9)])
    end,

    lib_log:partner_get(Partner9#partner.id, Partner9#partner.no, PS, "open"),
    notify_cli_get_partner(PS, Partner9),

    ply_tips:send_sys_tips(PS, {add_partner, [lib_partner:get_name(Partner9), lib_partner:get_id(Partner9), lib_partner:get_quality(Partner9),lib_partner:get_no(Partner9)]}),
    {ok, Partner9#partner.id}.

%%  ply_attr:recount_battle_power(player:get_PS(1000100000000599)),

do_player_add_partner(PS, PartnerNo) when is_integer(PartnerNo) ->
	do_player_add_partner(PS, PartnerNo, []);


%% return {ok, PS} 注意需要上层函数保存最新的PS
do_player_add_partner(PS, Partner) ->
    Partner1 = mod_partner:db_insert_partner(Partner),
    % MoodNo = lib_partner:get_mood_no(Partner),
    % MoodCfg = data_partner_mood:get(MoodNo),
    % [lib_buff:partner_add_buff(player:id(PS), Partner1#partner.id, BuffNo) || BuffNo <- MoodCfg#mood_cfg.buff_no_list],

    {Partner2, PS1} = 
        case length(player:get_partner_id_list(PS)) =:= 0 of %% 当前一个默认是主宠
            true ->
                lib_event:event(?TAKE_PET, [lib_partner:get_no(Partner1)], PS),

                TPartner1 = lib_partner:set_position(Partner1, ?PAR_POS_MAIN),
                TPartner2 = lib_partner:set_follow_state(TPartner1, ?PAR_FOLLOW),
                TPartner3 = lib_partner:set_state(TPartner2, ?PAR_STATE_JOIN_BATTLE_UNLOCKED),
                
                lib_partner:notify_main_partner_info_change_to_AOI(PS, TPartner3),
                {TPartner3, PS#player_status{main_partner_id = lib_partner:get_id(Partner1), follow_partner_id = lib_partner:get_id(Partner1)}};
            false -> {Partner1, PS}
        end,
    mod_partner:update_partner_to_ets(Partner2),

    PS2 = 
        case lists:member(lib_partner:get_id(Partner2), PS#player_status.partner_id_list) of
            true ->
                ?ASSERT(false),
                ?ERROR_MSG("ply_partner:do_player_add_partner error!", []),
                PS1;
            false ->
                PS1#player_status{partner_id_list = [lib_partner:get_id(Partner2) | PS#player_status.partner_id_list]}
        end,

    % lib_log:partner_get(Partner2#partner.id, Partner2#partner.no, PS1, "lottery"),
    notify_cli_get_partner(PS2, Partner2),
    ply_tips:send_sys_tips(PS2, {add_partner, [lib_partner:get_name(Partner2), lib_partner:get_id(Partner2), lib_partner:get_quality(Partner2),lib_partner:get_no(Partner2)]}),
    {ok, PS2}.


do_player_add_partner_offline(PlayerId, PartnerNo) ->
	do_player_add_partner_offline(PlayerId, PartnerNo, []).

do_player_add_partner_offline(PlayerId, PartnerNo, ExtraInfo) ->
    PartnerBornData = data_partner:get(PartnerNo),
    ?ASSERT(PartnerBornData /= null),

    Partner = make_partner_info(PlayerId, PartnerBornData, ExtraInfo),
    
    Partner1 = lib_partner:calc_base_attrs(Partner),
    % Partner2 = lib_partner:calc_passi_eff_attrs(Partner1),

    MoodNo = lib_partner:decide_mood_no(),
    Partner3 = lib_partner:set_mood_no(Partner1, MoodNo),
    Partner4 = lib_partner:set_last_update_mood_time(Partner3, svr_clock:get_unixtime()),
    Partner5 = mod_partner:db_insert_partner(Partner4),

    % MoodCfg = data_partner_mood:get(MoodNo),
    % [lib_buff:partner_add_buff(player:id(PS), Partner5#partner.id, BuffNo) || BuffNo <- MoodCfg#mood_cfg.buff_no_list],
    % Partner6 = lib_partner:calc_buff_eff_attrs(Partner5),

    Partner7 = lib_partner:init_total_attrs(Partner5),
    Partner8 = lib_partner:set_battle_power(Partner7, lib_partner:calc_battle_power(Partner7)),
    
    mod_partner:db_save_partner(Partner8),

    lib_log:partner_get(Partner8#partner.id, Partner8#partner.no, PlayerId, "offline_get"),
    {ok, Partner8#partner.id}.


do_add_partner_to_hotel(PS, ParNoList) ->
    F = fun(PartnerNo, Acc) ->
        PartnerBornData = data_partner:get(PartnerNo),
        ?ASSERT(PartnerBornData /= null),

        Partner = make_partner_info(PS, PartnerBornData),
        
        Partner1 = lib_partner:calc_base_attrs(Partner),
        % Partner2 = lib_partner:calc_passi_eff_attrs(Partner1),

        MoodNo = lib_partner:decide_mood_no(),
        Partner3 = lib_partner:set_mood_no(Partner1, MoodNo),
        Partner4 = lib_partner:set_last_update_mood_time(Partner3, svr_clock:get_unixtime()),
        % Partner5 = lib_partner:calc_buff_eff_attrs(Partner4),

        Partner6 = lib_partner:init_total_attrs(Partner4),
        Partner7 = lib_partner:set_battle_power(Partner6, lib_partner:calc_battle_power(Partner6)),
        Partner8 = lib_partner:set_position(Partner7, ?PAR_POS_NOT_MAIN),
        Partner9 = mod_partner:db_insert_partner_hotel(Partner8),

        lib_log:partner_get(Partner9#partner.id, Partner9#partner.no, PS, "lottery"),

        case lib_partner:get_quality(Partner9) >= ?QUALITY_PURPLE andalso lib_partner:get_ref_lv(Partner9) >= 10  of
            true ->
                case lib_partner:get_quality(Partner9) >= ?QUALITY_ORANGE of
                    false ->
                        ply_tips:send_sys_tips(PS, {find_par, [player:get_name(PS), player:id(PS), lib_partner:get_name(Partner9), lib_partner:get_id(Partner9), lib_partner:get_quality(Partner9),lib_partner:get_no(Partner9)]});
                    true ->
                        ply_tips:send_sys_tips(PS, {find_par_orange, [player:get_name(PS), player:id(PS), lib_partner:get_name(Partner9), lib_partner:get_id(Partner9), lib_partner:get_quality(Partner9),lib_partner:get_no(Partner9)]})                    
                end;
            false -> skip
        end,
        [Partner9 | Acc]
    end,
    lists:foldl(F, [], ParNoList).


check_set_partner_state(PS, PartnerId, State) ->
    try check_set_partner_state__(PS, PartnerId, State) of
        {ok, Partner} ->
            {ok, Partner}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_set_partner_state__(PS, PartnerId, State) ->
    Partner = lib_partner:get_partner(PartnerId),
    ?Ifc (Partner =:= null)
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    ?Ifc ( not player:has_partner(PS, PartnerId) )
        throw(?PM_PAR_NOT_EXISTS)
    ?End,

    ?Ifc (not lists:member(State, [?PAR_STATE_REST_UNLOCKED, ?PAR_STATE_REST_LOCKED, ?PAR_STATE_JOIN_BATTLE_UNLOCKED, ?PAR_STATE_JOIN_BATTLE_LOCKED, ?PAR_STATE_HOME_WORK]))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc ( (State =:= ?PAR_STATE_JOIN_BATTLE_UNLOCKED orelse State =:= ?PAR_STATE_JOIN_BATTLE_LOCKED)
                        andalso (lib_partner:get_life(Partner) =< 0) )
        throw(?PM_PAR_LIFE_LIMIT)
    ?End,

    PlayerLvNeed = (data_partner:get(lib_partner:get_no(Partner)))#par_born_data.player_lv_need,
    ?Ifc ( (State =:= ?PAR_STATE_JOIN_BATTLE_UNLOCKED orelse State =:= ?PAR_STATE_JOIN_BATTLE_LOCKED)
                        andalso (player:get_lv(PS) < PlayerLvNeed) )
        ply_tips:send_sys_tips(PS, {par_join_battle, [PlayerLvNeed, lib_partner:get_name(Partner), lib_partner:get_id(Partner), lib_partner:get_quality(Partner),lib_partner:get_no(Partner)]}),
        throw(?PM_PAR_PLAYER_LV_LIMIT_FOR_BATTLE)
    ?End,

    % ?Ifc ( (State =:= ?PAR_STATE_JOIN_BATTLE_UNLOCKED orelse State =:= ?PAR_STATE_JOIN_BATTLE_LOCKED)
    %                     andalso (lib_partner:get_loyalty(Partner) =< 0) )
    %     throw(?PM_PAR_LOYALTY_LIMIT)
    % ?End,

    ?Ifc ( (State =:= ?PAR_STATE_JOIN_BATTLE_UNLOCKED orelse State =:= ?PAR_STATE_JOIN_BATTLE_LOCKED)
                        andalso (lib_partner:get_lv(Partner) - player:get_lv(PS) >= ?DELTA_LV_JOIN_BATTLE_LIMIT) )
        throw(?PM_PAR_JOIN_BATTLE_LV_LIMIT)
    ?End,

    CanCount = get_can_fight_partner_count(PS),
    HaveFightCount = mod_partner:get_fighting_partner_count(PS),

    OldState = lib_partner:get_state(Partner),
    ?Ifc ( (State =:= ?PAR_STATE_JOIN_BATTLE_UNLOCKED orelse State =:= ?PAR_STATE_JOIN_BATTLE_LOCKED)
    andalso (HaveFightCount >= CanCount) andalso (OldState =:= ?PAR_STATE_REST_UNLOCKED orelse OldState =:= ?PAR_STATE_REST_LOCKED) )
        % case CanCount of
        %     1 -> throw(?PM_FIGHT_PAR_COUNT_LIMIT1);
        %     2 -> throw(?PM_FIGHT_PAR_COUNT_LIMIT2);
        %     3 -> throw(?PM_FIGHT_PAR_COUNT_LIMIT3);
        %     4 -> throw(?PM_FIGHT_PAR_COUNT_LIMIT4);
        %     _Any -> ?ASSERT(false, _Any)
        % end
        throw(?PM_FIGHT_PAR_COUNT_LIMIT)
    ?End,

    ?Ifc (lib_partner:is_main_partner(Partner) andalso lists:member(State, [?PAR_STATE_REST_UNLOCKED, ?PAR_STATE_REST_LOCKED]))
        throw(?PM_MAIN_PAR_MUST_FIGHT)
    ?End,

    {ok, Partner}.


get_can_fight_partner_count(PS) ->
    % Lv = player:get_lv(PS),
    % if
    %     Lv < 5 -> 1;
    %     Lv < 30 -> 2;
    %     Lv < 50 -> 3;
    %     Lv < 60 -> 4;
    %     true -> 5
    % end.
    player:get_fight_par_capacity(PS).


expand_fight_par_capacity(PlayerId, Num) when is_integer(PlayerId) ->
    case player:get_PS(PlayerId) of
        null -> 
            ?ASSERT(false, PlayerId),
            skip;
        PS -> 
            case player:get_fight_par_capacity(PS) >= 5 of
                true -> skip;
                false ->
                    player:set_fight_par_capacity(PS, erlang:min(player:get_fight_par_capacity(PS) + Num, 5)),
                    {ok, BinData} = pt_17:write(?PT_GET_NUM_LIMIT, [player:get_partner_capacity(PS), player:get_fight_par_capacity(PS) + Num]),
                    lib_send:send_to_sock(PS, BinData)
            end
    end;

%% 此函数：必须是玩家进程调用
expand_fight_par_capacity(PS, Num) ->
    case player:get_fight_par_capacity(PS) >= 5 of
        true -> skip;
        false ->
            PS_New = player_syn:set_fight_par_capacity(PS, erlang:min(player:get_fight_par_capacity(PS) + Num, 5)),
            PlayerId = player:id(PS_New),
            db:update(PlayerId, player, ["fight_par_capacity"], [player:get_fight_par_capacity(PS_New)], "id", PlayerId),
            {ok, BinData} = pt_17:write(?PT_GET_NUM_LIMIT, [player:get_partner_capacity(PS), player:get_fight_par_capacity(PS) + Num]),
            lib_send:send_to_sock(PS, BinData)
    end.


do_set_partner_state(PS, Partner, State) ->
    ?ASSERT(lists:member(lib_partner:get_id(Partner), player:get_partner_id_list(PS)), Partner),
    Partner0 = lib_partner:set_state(Partner, State),
	Partner1 = lib_partner:set_join_battle_time(Partner0),
    mod_partner:update_partner_to_ets(Partner1),
    lib_partner:notify_cli_info_change(Partner1, [{?OI_CODE_PAR_STATE, lib_partner:get_state(Partner1)}]),
    case lib_partner:get_state(Partner) of
        ?PAR_STATE_REST_LOCKED ->
            case lists:member(State, [?PAR_STATE_JOIN_BATTLE_LOCKED, ?PAR_STATE_JOIN_BATTLE_UNLOCKED]) of
                true ->
                    ply_attr:recount_battle_power(PS),
                    notify_other_sys_partner_join_battle(PS);
                false -> skip
            end;
        ?PAR_STATE_REST_UNLOCKED ->
            case lists:member(State, [?PAR_STATE_JOIN_BATTLE_LOCKED, ?PAR_STATE_JOIN_BATTLE_UNLOCKED]) of
                true ->
                    ply_attr:recount_battle_power(PS),
                    notify_other_sys_partner_join_battle(PS);
                false -> skip
            end;
        ?PAR_STATE_JOIN_BATTLE_UNLOCKED ->
            case lists:member(State, [?PAR_STATE_REST_UNLOCKED, ?PAR_STATE_REST_LOCKED]) of
                true ->
                    ply_attr:recount_battle_power(PS);
                false -> skip
            end;
        ?PAR_STATE_JOIN_BATTLE_LOCKED ->
            case lists:member(State, [?PAR_STATE_REST_UNLOCKED, ?PAR_STATE_REST_LOCKED]) of
                true ->
                    ply_attr:recount_battle_power(PS);
                false -> skip
            end;
        _Any -> skip
    end,

    db_save_all_partners(PS),

    {ok, lib_partner:get_id(Partner1)}.


check_open_carry_partner_num(PS, Num) ->
    case Num =< 0 of
        true -> {fail, ?PM_PARA_ERROR};
        false ->
            case player:get_partner_capacity(PS) + Num > get_max_partner_capacity(PS) of
                true -> {fail, ?PM_PAR_CAPACITY_LIMIT};
                false ->
                    Count = mod_inv:get_goods_count_in_bag_by_no(player:get_id(PS), ?PAR_EXTEND_CAPACITY_GOODS_NO),
                    case Count < Num * 1 of
                        true -> {fail, ?PM_PAR_EXTEND_CAPACITY_GOODS_COUNT_LIMIT};
                        false -> ok
                    end
            end
    end.


do_open_carry_partner_num(PS, Num) ->
    mod_inv:destroy_goods_WNC(player:get_id(PS), [{?PAR_EXTEND_CAPACITY_GOODS_NO, Num * 1}], [?LOG_PARTNER, "add_field"]),
    player:set_partner_capacity(PS, player:get_partner_capacity(PS) + Num),
    {ok, player:get_partner_capacity(PS) + Num}.


check_rename(PS, PartnerId, NewName) ->
    case player:has_partner(PS, PartnerId) of
        false -> {fail, ?PM_PAR_NOT_EXISTS};
        true ->
            case is_partner_name_valid(NewName) of
                {false, len_error} ->
                    {fail, ?PM_PAR_NAME_LEN_ERROR};
                {false, char_illegal} ->
                    {fail, ?PM_PAR_NAME_CHAR_ILLEGEL};
                true ->
                    ok
            end
    end.


do_rename(PS, PartnerId, NewName) ->
    case lib_partner:get_partner(PartnerId) of
        null -> {fail, ?PM_PAR_NOT_EXISTS};
        Partner ->
            Partner1 = Partner#partner{name = list_to_binary(NewName)},
            mod_partner:update_partner_to_ets(Partner1),
            case lib_partner:is_follow_partner(Partner1) of
                false -> skip;
                true -> lib_partner:notify_main_partner_info_change_to_AOI(PS, Partner1)
            end,
            ok
    end.


%% 检查队名长度是否合法
%% @return: true | {false, Reason}
is_partner_name_valid(Name) ->
    case asn1rt:utf8_binary_to_list(list_to_binary(Name)) of
        {ok, CharList} ->
            Len = util:string_width(CharList),
            ?TRACE("is_partner_name_valid,Name:~p, Len=:~p~n", [Name, Len]),
            % 最大长度：最多能输入6个字符
            case Len < ?MAX_NAME_LEN * 2 + 1 andalso Len > 1 of
                true ->
                    case util:has_illegal_char(CharList) of % 是否包含非法字符（如：空格，反斜杠）
                        true ->
                            {false, char_illegal};
                        false ->
                            true
                    end;
                false ->
                   {false, len_error}
            end;
        {error, _Reason} ->
            % 非法字符
            {false, char_illegal}
   end.


%% return partner 结构体
make_partner_info(SrcData) when is_list(SrcData) ->
    [Id, PlayerId, PartnerNo, Name, Sex, Quality, State, Lv, Exp, _Hp, Intimacy, IntimacyLv, Life, CurBattleNum, Position, Follow, Cultivate, CultivateLv, CultivateLayer, SkillsUse, 
	 Skills, SkillsTwo, SkillsExclusive, BattlePower, Loyalty, NatureNo, EvolveLv,Evolve,AwakeLv,AwakeIllusion, BaseTrainAttrs_0, BaseTrainAttrsTmp_0,MaxPostnatalSkill, WashCount, MoodNo, 
	 LastUpdateMoodTime, UpdateMoodCount, AddSkillFailCnt, Version, MountId,BaseTalents_BS,FreeTalentPoints1,Five_Element,TsJoinBattle,JoinBattleOrder,AttrRefine,ArtSlot,CostRefine] = SrcData,
    % 字符串转成列表
    BaseTrainAttrs = if
                         is_tuple(BaseTrainAttrs_0)->  BaseTrainAttrs_0;
                         true ->   list_to_tuple([base_train_attrs|tuple_to_list(util:bitstring_to_term(BaseTrainAttrs_0))])
                     end,
	BaseTrainAttrsTmp = if
                         is_tuple(BaseTrainAttrsTmp_0)->  BaseTrainAttrsTmp_0;
                         true ->   list_to_tuple([base_train_attrs|tuple_to_list(util:bitstring_to_term(BaseTrainAttrsTmp_0))])
                     end,
	
	F = fun (SkillsFun) ->
				 case is_list(SkillsFun) of
					 true -> SkillsFun;
        false ->
						 case util:bitstring_to_term(SkillsFun) of
                undefined -> [];
                RetList when is_list(RetList) -> %% 数据容错
                    [X || X <- RetList, data_skill:get(X#skl_brief.id) =/= null];
                _Any -> ?ASSERT(false, _Any), []
            end
				 end
    end,
	SkillList = F(Skills),
	SkillListTwo = F(SkillsTwo),
	SkillsListExclusive = F(SkillsExclusive),

    BaseAttrs1 = init_base_attr(Quality, Lv),

    ?DEBUG_MSG("BaseTalents_BS=~p",[BaseTalents_BS]),
    BaseTalents_Tup1 = case BaseTalents_BS of
        {_A1,_A2,_A3,_A4,_A5} -> BaseTalents_BS;
        _ -> util:bitstring_to_term(BaseTalents_BS)
    end,

    {A1,A2,A3,A4,A5} = BaseTalents_Tup1,

    ?DEBUG_MSG("BaseTalents_Tup1=~p",[BaseTalents_Tup1]),
    Sum = Lv * 5 - 5 + Lv * 5, 
    CurSum = A1+A2+A3+A4+A5 + FreeTalentPoints1,

    ?DEBUG_MSG("CurSum=~p",[CurSum]),

    {BaseTalents_Tup,FreeTalentPoints} = 
    case Sum /= CurSum of
%%         true -> 
%%             % 数据异常
%%             {{Lv,Lv,Lv,Lv,Lv},Lv * 5 - 5};
%%         false ->
		   _ ->% 有特殊定制需求，暂时不判断
            % 数据正常
            {BaseTalents_Tup1,FreeTalentPoints1}
    end, 

    ?DEBUG_MSG("BaseTalents_Tup=~p",[BaseTalents_Tup]),
    BaseTalents = lib_attribute:to_talents_record(BaseTalents_Tup),

    % 赋值基础天赋信息
    BaseAttrs = BaseAttrs1#attrs{
                        talent_str = BaseTalents#talents.str,
                        talent_con = BaseTalents#talents.con,
                        talent_sta = BaseTalents#talents.sta,
                        talent_spi = BaseTalents#talents.spi,
                        talent_agi = BaseTalents#talents.agi
                        },

    % to {成长，生命资质，法力资质，物攻资质，法功资质，物防资质，法防资质，速度资质}
    BaseTrainAttrs1 =
    case is_record(BaseTrainAttrs, base_train_attrs) of
        false ->
            init_base_train_attrs(PartnerNo, Quality, NatureNo, util:bitstring_to_term(BaseTrainAttrs));
        true ->
            BaseTrainAttrs
    end,
	
	BaseTrainAttrsTmp1 =
		case is_record(BaseTrainAttrsTmp, base_train_attrs) of
			false ->
				init_base_train_attrs(PartnerNo, Quality, NatureNo, util:bitstring_to_term(BaseTrainAttrsTmp));
			true ->
				BaseTrainAttrsTmp
		end,
	
	

    ShowEquip =
        case Id =:= ?INVALID_ID of
            true ->
                #showing_equip{};
            false ->
                mod_equip:build_partner_showing_equips(PlayerId, Id)
        end,

    MoodNoList = data_partner_mood:get_all_mood_no_list(),
    MoodNo1 = 
        case lists:member(MoodNo, MoodNoList) of
            false -> lists:nth(1, MoodNoList); %% 登录容错
            true -> MoodNo
        end,

    {No, LeftCultivate} = decide_cultivate(CultivateLv, CultivateLayer, Cultivate),
    {NewCultivateLv, NewCultivateLayer} = data_partner_cultivate:get(No),
    case NewCultivateLv - CultivateLv >= 2 orelse NewCultivateLayer > NewCultivateLv of
        true -> ?ERROR_MSG("ply_partner:make_partner_info error!Old:~w, New:~w, Cultivate:~p, LeftCultivate:~p, No:~p~n", [{CultivateLv, CultivateLayer}, {NewCultivateLv, NewCultivateLayer}, Cultivate, LeftCultivate, No]);
        false -> ?DEBUG_MSG("ply_partner:make_partner_info: OldNewLv:~w, OldNewLayer:~w, Cultivate:~p, LeftCultivate:~p,No:~p~n", [{CultivateLv, CultivateLayer}, {NewCultivateLv, NewCultivateLayer}, Cultivate, LeftCultivate, No])
    end,
	
	AttrRefine2 = 
		case is_list(AttrRefine) of
			?true ->
				AttrRefine;
			?false ->
				util:bitstring_to_term(AttrRefine)
		end,

    ArtSlot2 =
        case is_list(ArtSlot) of
            ?true ->
                ArtSlot;
            ?false ->
                util:bitstring_to_term(ArtSlot)
        end,
	
	CostRefine2 =
		case is_list(CostRefine) of
			?true ->
				CostRefine;
			?false ->
				util:bitstring_to_term(CostRefine)
		end,
	
    #partner{
                id = Id,
                no = PartnerNo,
                player_id = PlayerId,
                name = Name,
                sex = Sex,
                state = State,
                quality = Quality,
                lv = Lv,
                exp = Exp,
                intimacy = Intimacy,
                intimacy_lv = IntimacyLv,
                life = Life,
                cur_battle_num = CurBattleNum,
                position = Position,
                follow = Follow,
                cultivate = LeftCultivate,
                cultivate_lv = NewCultivateLv,
                cultivate_layer = NewCultivateLayer,
                base_attrs = BaseAttrs,
				skills_use = SkillsUse,
                skills = SkillList,
                skills_two = SkillListTwo,
				skills_exclusive = SkillsListExclusive,
                battle_power = BattlePower,
                loyalty = Loyalty,
                nature_no = NatureNo,
                evolve_lv = EvolveLv,
                evolve = Evolve,
				awake_lv = AwakeLv,
				awake_illusion = AwakeIllusion,
                base_train_attrs = BaseTrainAttrs1,
				base_train_attrs_tmp = BaseTrainAttrsTmp1,
                max_postnatal_skill = MaxPostnatalSkill,
                showing_equips = ShowEquip,
                wash_count = WashCount,
                mood_no = MoodNo1,
                last_update_mood_time = LastUpdateMoodTime,
                update_mood_count = UpdateMoodCount,
                add_skill_fail_cnt = AddSkillFailCnt,
                version = Version,
                mount_id = MountId,
                free_talent_points = FreeTalentPoints,
                five_element = util:bitstring_to_term(Five_Element),
				ts_join_battle = TsJoinBattle,
                join_battle_order =  JoinBattleOrder,
				attr_refine = AttrRefine2,
        		art_slot = ArtSlot2,
				cost_refine = CostRefine2
                }.


adjust_id(Partner, partner) ->
    case lib_account:is_global_uni_id(Partner#partner.id) of 
        true -> Partner; 
        false -> 
            GlobalId = lib_account:to_global_uni_id(Partner#partner.id),
            db:update(Partner#partner.player_id, partner, ["id"], [GlobalId], "id", Partner#partner.id), 
            Partner#partner{id = GlobalId}
    end;

adjust_id(Partner, partner_hotel) ->
    case lib_account:is_global_uni_id(Partner#partner.id) of 
        true -> Partner; 
        false -> 
            GlobalId = lib_account:to_global_uni_id(Partner#partner.id),
            db:update(Partner#partner.player_id, partner_hotel, ["id"], [GlobalId], "id", Partner#partner.id), 
            Partner#partner{id = GlobalId}
    end.
                
%% 扩展一个ExtraInfo字段定制属性
make_partner_info(PS_Or_PlayerId, ParBornData) ->
	make_partner_info(PS_Or_PlayerId, ParBornData, []).

make_partner_info(PS_Or_PlayerId, ParBornData, ExtraInfo) ->
    Id = 0, % 先默认初始化为0
    ?DEBUG_MSG("this partner error ~p~n",[ParBornData]),
    PartnerNo = ParBornData#par_born_data.no,
    % HeadResId = ParBornData#par_born_data.head_res,
    % BackResId = ParBornData#par_born_data.back_res,
    Name = ParBornData#par_born_data.name,
    Sex = ParBornData#par_born_data.sex,
    Quality = ParBornData#par_born_data.quality,
    ?TRACE("Quality:~p~n", [Quality]),
    DataQualityRelate = data_quality_relate:get(Quality),

    State = ?PAR_STATE_REST_UNLOCKED,
    Lv = 1, % 默认等级是1级
    Exp = 0,
	#ref_attr{hp_lim = Hp} = data_ref_attr:get(ParBornData#par_born_data.ref_attr),
%%     Hp = ParBornData#par_born_data.hp,
    Intimacy = 0,
    IntimacyLv = 1,
    Life = DataQualityRelate#quality_relate_data.life,

    CurBattleNum = 0,
	PartnerIdList = 
		case player:get_pid(PS_Or_PlayerId) of
			_Pid when is_pid(_Pid) ->% 玩家在线
				player:get_partner_id_list(PS_Or_PlayerId);
			_ ->% 玩家离线
				db:select_all(partner, "id", [{player_id, PS_Or_PlayerId}])
					
		end,
	Position =
		case length(PartnerIdList) =:= 0 of %% 当前一个默认是主宠
			true -> ?PAR_POS_MAIN;
			false -> ?PAR_POS_NOT_MAIN
		end,
    Cultivate = 0,
    CultivateLv = 0, %% 修炼等级
    CultivateLayer = 0,
    ?ASSERT(length(DataQualityRelate#quality_relate_data.inborn_skill_num_region) =:= 2),
    % ?ASSERT(length(ParBornData#par_born_data.inborn_skill_pool) /= 0),
    ?TRACE("inborn_skill_pool:~p~n", [ParBornData#par_born_data.inborn_skill_pool]),
%%     InbornSkillCnt = 
%%         case ParBornData#par_born_data.fix =:= 1 of
%%             false ->
%%                 rand_get_skill_count(lists:nth(1, DataQualityRelate#quality_relate_data.inborn_skill_num_region), 
%%                     lists:nth(2, DataQualityRelate#quality_relate_data.inborn_skill_num_region));
%%             true ->
%%                 ParBornData#par_born_data.inborn_skill_num
%%         end,

%%     {L1, L2, L3, L4} = case lists:keyfind(inborn_skill, 1, ExtraInfo) of
%%                            {inborn_skill, InbornSkill} ->
%%                                classify_inborn_skill_by_rarity(InbornSkill);
%%                            false ->
%%                                classify_inborn_skill_by_rarity(ParBornData#par_born_data.inborn_skill_pool)
%%                        end,

	%% 策划现在要改成出生技能直接简单粗暴从inborn_skill_pool技能池中拿出小于等于inborn_skill_slot个数量的技能就可以了
%%     InbornSkillL = get_inborn_skill([], InbornSkillCnt, L1, L2, L3, L4),
	InbornSkillIds = case erlang:length(ParBornData#par_born_data.inborn_skill_pool) > ParBornData#par_born_data.inborn_skill_slot of
					   ?true ->
						   %% 截取
						   lists:sublist(ParBornData#par_born_data.inborn_skill_pool, ParBornData#par_born_data.inborn_skill_slot);
					   ?false ->
						   ParBornData#par_born_data.inborn_skill_pool
				   end,
	InbornSkillL = [#skl_brief{id = SkillId} || SkillId <- InbornSkillIds],
    % 所有宠物技能上限都是固定配置表配置的，所以MaxPostnatalSkill1用来表示inborn_skill_slot当前最大格子数即可，后续扩展的时候最大不超过配置表的max_postnatal_skill_slot
	MaxPostnatalSkill = ParBornData#par_born_data.inborn_skill_slot,
%%     MaxPostnatalSkill1 = 
%%         case ParBornData#par_born_data.fix =:= 1 of
%%             false ->
%%                 rand_get_skill_count(lists:nth(1, DataQualityRelate#quality_relate_data.postnatal_skill_slot_region), 
%%                     lists:nth(2, DataQualityRelate#quality_relate_data.postnatal_skill_slot_region));
%%             true ->
%%                 ParBornData#par_born_data.max_postnatal_skill_slot
%%         end,

    % 特殊宠物全部8技能上限 其他最少也有4个
%%     TempMaxSkill = 
%%     if 
%%         PartnerNo > 5000 -> 12;
%%         PartnerNo > 2000 -> 8;
%%         true -> 4
%%     end,
%%     MaxPostnatalSkill = erlang:max(MaxPostnatalSkill1,TempMaxSkill),
        
%%     MinPostnatalSkill = min(lists:nth(1, DataQualityRelate#quality_relate_data.postnatal_skill_num_region), MaxPostnatalSkill),

%%     InitPostnatalSkillCnt = 
%%         case ParBornData#par_born_data.fix =:= 1 of
%%             false -> rand_get_skill_count(MinPostnatalSkill, MaxPostnatalSkill);
%%             true -> ParBornData#par_born_data.postnatal_skill_num
%%         end,

%%     {L11, L22, L33, L44} = classify_postnatal_skill_by_rarity(ParBornData#par_born_data.postnatal_skill_pool),
%% 
%%     PostnatalSkillL = get_postnatal_skill([], InitPostnatalSkillCnt, L11, L22, L33, L44, []),

%%     Skills = InbornSkillL ++ PostnatalSkillL,
	Skills = InbornSkillL,
	
    BattlePower = 0,
    Loyalty = DataQualityRelate#quality_relate_data.loyalty_max,

    ?ASSERT(ParBornData#par_born_data.character_pool /= []),
    RandNum = util:rand(1, length(ParBornData#par_born_data.character_pool)),
    NatureNo = lists:nth(RandNum, ParBornData#par_born_data.character_pool),

    EvolveCoef = lib_partner:get_evolve_coef(ParBornData#par_born_data.ref_lv),

    AwakeLv = 0,			% 觉醒等级
    EvolveLv = 0,           % 进化等级
	Evolve =
        case data_partner_evolve:get(Quality, EvolveLv) of
            null -> 0;
            EvolveCfg -> util:ceil(EvolveCfg#partner_evolve.evolve*EvolveCoef)
        end,

    BaseTrainAttrs = init_base_train_attrs(PartnerNo, NatureNo, Quality, 1),
	BaseTrainAttrsTmp = #base_train_attrs{},    %% 初始化一个空的
	
    PlayerId = 
        case is_integer(PS_Or_PlayerId) of
            true -> PS_Or_PlayerId;
            false -> player:id(PS_Or_PlayerId)
        end,

	BaseTalents_BS = 
		case lists:keyfind(talent, 1, ExtraInfo) of
			{talent, {Str, Con, Sta, Spi, Agi}} ->
				{Str, Con, Sta, Spi, Agi};
			false ->
				{1,1,1,1,1}
		end,
	
	Skills2 = 
		case lists:keyfind(skill, 1, ExtraInfo) of
			{skill, Skills0} ->
				lists:foldl(fun(SkillId, AccIn) ->
									case data_skill:get(SkillId) of
										SkillCfg when is_record(SkillCfg, skl_cfg) ->
											[#skl_brief{id = SkillId}|AccIn];
										_ ->
											AccIn
									end
							end, [], Skills0);
			false ->
				Skills
		end,
	
	SkillsExclusive = lists:foldl(fun(SkillId, Acc) ->
										  [#skl_brief{id = SkillId}|Acc]
								  end, [], ParBornData#par_born_data.exclusive_skill),
	
	MaxPostnatalSkill2 = 
		case lists:keyfind(count_skill_passive, 1, ExtraInfo) of
			{count_skill_passive, MaxPostnatalSkill0} ->
				MaxPostnatalSkill0;
			false ->
				MaxPostnatalSkill
		end,
	CultivateLv2 = 
		case lists:keyfind(pet_cultivate, 1, ExtraInfo) of
			{pet_cultivate, CultivateLv0} ->
				CultivateLv0;
			false ->
				CultivateLv
		end,
	EvolveLv2 = 
		case lists:keyfind(pet_grow, 1, ExtraInfo) of
			{pet_grow, EvolveLv0} ->
				EvolveLv0;
			false ->
				EvolveLv
		end,
	
    InfoList = [Id, PlayerId, PartnerNo, Name, Sex, Quality, State, Lv, Exp, Hp,
        Intimacy, IntimacyLv, Life, CurBattleNum, Position, ?PAR_UNFOLLOW, Cultivate, CultivateLv2, CultivateLayer, 1, Skills2, Skills2, SkillsExclusive, BattlePower, Loyalty, NatureNo,
        EvolveLv2, Evolve, AwakeLv, 0, BaseTrainAttrs, BaseTrainAttrsTmp, MaxPostnatalSkill2, 0, 0, 0, 0, 0, ?PAR_DATA_VERSION_NEW, 0, BaseTalents_BS, 0, <<"{0,0}">>, 0 ,0, [],[],[]],

    make_partner_info(InfoList).


%% @return: attrs结构体
init_base_attr(Quality, Lv) ->
    DataStandard = data_par_standard:get(Quality, Lv),
    #attrs{
            hp = util:ceil(DataStandard#par_standard_dt.hp),
            mp = util:ceil(DataStandard#par_standard_dt.mp),
            mp_lim = util:ceil(DataStandard#par_standard_dt.mp),
            phy_att = util:ceil(DataStandard#par_standard_dt.phy_att),
            phy_def = util:ceil(DataStandard#par_standard_dt.phy_def),
            mag_att = util:ceil(DataStandard#par_standard_dt.mag_att),
            mag_def = util:ceil(DataStandard#par_standard_dt.mag_def),
            act_speed = util:ceil(DataStandard#par_standard_dt.act_speed),

            hit =  util:ceil(DataStandard#par_standard_dt.hit),
            crit = util:ceil(DataStandard#par_standard_dt.crit),

            seal_hit = util:ceil(DataStandard#par_standard_dt.seal_hit),
            seal_resis = util:ceil(DataStandard#par_standard_dt.seal_resis),

            ten  = util:ceil(DataStandard#par_standard_dt.ten),
            dodge = util:ceil(DataStandard#par_standard_dt.dodge)
    }.


notify_cli_get_partner(PS, Partner_Or_PartnerId) ->
    {ok, BinData} = pt_17:write(?PT_GET_PARTNER, [Partner_Or_PartnerId]),
    lib_send:send_to_sock(PS, BinData).


to_base_train_attrs_record(ParNo, Quality, NatureNo, {Grow, LifeAptitude, MagAptitude, PhyAttAptitude, MagAttAptitude, PhyDefAptitude, MagDefAptitude, SpeedAptitude}) ->
    %% 数据容错与矫正
    Grow1 =
        case Grow > get_max_grow(ParNo, Quality) of
            true -> get_max_grow(ParNo, Quality);
            false ->
                case Grow < get_min_grow(ParNo, Quality) of
                    true -> get_min_grow(ParNo, Quality);
                    false -> Grow
                end
        end,

    LifeAptitude1 =
        case LifeAptitude > get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_LIFE) of
            true -> get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_LIFE);
            false ->
                case LifeAptitude < get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_LIFE) of
                    true -> get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_LIFE);
                    false -> LifeAptitude
                end
        end,

    MagAptitude1 =
        case MagAptitude > get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_MAG) of
            true -> get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_MAG);
            false ->
                case MagAptitude < get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_MAG) of
                    true -> get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_MAG);
                    false -> MagAptitude
                end
        end,

    PhyAttAptitude1 =
        case PhyAttAptitude > get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_PHY_ATT) of
            true -> get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_PHY_ATT);
            false ->
                case PhyAttAptitude < get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_PHY_ATT) of
                    true -> get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_PHY_ATT);
                    false -> PhyAttAptitude
                end
        end,

    MagAttAptitude1 =
        case MagAttAptitude > get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_MAG_ATT) of
            true -> get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_MAG_ATT);
            false ->
                case MagAttAptitude < get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_MAG_ATT) of
                    true -> get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_MAG_ATT);
                    false -> MagAttAptitude
                end
        end,

    PhyDefAptitude1 =
        case PhyDefAptitude > get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_PHY_DEF) of
            true -> get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_PHY_DEF);
            false ->
                case PhyDefAptitude < get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_PHY_DEF) of
                    true -> get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_PHY_DEF);
                    false -> PhyDefAptitude
                end
        end,

    MagDefAptitude1 =
        case MagDefAptitude > get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_MAG_DEF) of
            true -> get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_MAG_DEF);
            false ->
                case MagDefAptitude < get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_MAG_DEF) of
                    true -> get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_MAG_DEF);
                    false -> MagDefAptitude
                end
        end,

    SpeedAptitude1 =
        case SpeedAptitude > get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_SPEED) of
            true -> get_max_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_SPEED);
            false ->
                case SpeedAptitude < get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_SPEED) of
                    true -> get_min_aptitude(ParNo, Quality, NatureNo, ?APTITUDE_SPEED);
                    false -> SpeedAptitude
                end
        end,
    #base_train_attrs{
            grow = Grow1,
            life_aptitude = LifeAptitude1,
            mag_aptitude = MagAptitude1,  %%这个不要了，20191030
            phy_att_aptitude = PhyAttAptitude1,
            mag_att_aptitude = MagAttAptitude1,
            phy_def_aptitude = PhyDefAptitude1,
            mag_def_aptitude = MagDefAptitude1,
            speed_aptitude = SpeedAptitude1
    }.

% 以下四个数据容错用
get_max_grow(ParNo, Quality) ->
    PlayerLvNeed = (data_partner:get(ParNo))#par_born_data.ref_lv,
    case Quality of
        ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_max;
        ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_max;
        ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_max;
        ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_max;
        ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_max;
        ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_max;
        _Any -> ?ASSERT(false, _Any), 0
    end.

get_min_grow(ParNo, Quality) ->
    PlayerLvNeed = (data_partner:get(ParNo))#par_born_data.ref_lv,
    case Quality of
        ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_min;
        ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_min;
        ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_min;
        ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_min;
        ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_min;
        ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_min;
        _Any -> ?ASSERT(false, _Any), 0
    end.


get_max_aptitude(ParNo, Quality, NatureNo, Type) ->
    Data = data_nature_relate:get(NatureNo),
    PlayerLvNeed = (data_partner:get(ParNo))#par_born_data.ref_lv,
    Max =
        case Quality of
            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_max;
            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_max;
            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_max;
            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_max;
            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_max;
            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_max;
            _Any -> ?ASSERT(false, _Any), 0
        end,
    Coef =
        case Type of
            ?APTITUDE_LIFE -> Data#nature_relate_data.life_lean;
            ?APTITUDE_MAG -> Data#nature_relate_data.super_power_lean;
            ?APTITUDE_PHY_ATT -> Data#nature_relate_data.phy_att_lean;
            ?APTITUDE_MAG_ATT -> Data#nature_relate_data.mag_att_lean;
            ?APTITUDE_PHY_DEF -> Data#nature_relate_data.phy_def_lean;
            ?APTITUDE_MAG_DEF -> Data#nature_relate_data.mag_def_lean;
            ?APTITUDE_SPEED -> Data#nature_relate_data.speed_lean;
            _Any1 -> ?ASSERT(false, _Any1), 0
        end,
    util:ceil(Coef * Max).


get_min_aptitude(ParNo, Quality, NatureNo, Type) ->
    Data = data_nature_relate:get(NatureNo),
    PlayerLvNeed = (data_partner:get(ParNo))#par_born_data.ref_lv,
    Min =
        case Quality of
            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_min;
            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_min;
            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_min;
            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_min;
            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_min;
            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_min;
            _Any -> ?ASSERT(false, _Any), 0
        end,
    Coef =
        case Type of
            ?APTITUDE_LIFE -> Data#nature_relate_data.life_lean;
            ?APTITUDE_MAG -> Data#nature_relate_data.super_power_lean;
            ?APTITUDE_PHY_ATT -> Data#nature_relate_data.phy_att_lean;
            ?APTITUDE_MAG_ATT -> Data#nature_relate_data.mag_att_lean;
            ?APTITUDE_PHY_DEF -> Data#nature_relate_data.phy_def_lean;
            ?APTITUDE_MAG_DEF -> Data#nature_relate_data.mag_def_lean;
            ?APTITUDE_SPEED -> Data#nature_relate_data.speed_lean;
            _Any1 -> ?ASSERT(false, _Any1), 0
        end,
    util:ceil(Coef * Min).

% return base_train_attrs 结构体
% 计算方法参考策划文档
init_base_train_attrs(PartnerNo, NatureNo, Quality, Type) ->
    ?TRACE("ply_partner:init_base_train_attrs: NatureNo:~p~n", [NatureNo]),
%%    Data = data_nature_relate:get(NatureNo),
%%    PlayerLvNeed = (data_partner:get(PartnerNo))#par_born_data.ref_lv,
%%    Min =
%%        case Quality of
%%            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_min;
%%            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_min;
%%            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_min;
%%            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_min;
%%            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_min;
%%            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_min;
%%            _Any1 -> ?ASSERT(false, 0)
%%        end,
%%    Max =
%%        case Quality of
%%            ?QUALITY_WHITE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.white_max;
%%            ?QUALITY_GREEN -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.green_max;
%%            ?QUALITY_BLUE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.blue_max;
%%            ?QUALITY_PURPLE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.purple_max;
%%            ?QUALITY_ORANGE -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.orange_max;
%%            ?QUALITY_RED -> (data_par_aptitude:get(PlayerLvNeed))#par_aptitude.red_max;
%%            _Any2 -> ?ASSERT(false, 0)
%%        end,
%%
%%    TotalPartCount =
%%        case Type of
%%            1 -> length(data_wash_prob_cfg:get_all_no_list());
%%            2 -> length(data_wash_prob_cfg:get_all_no_list()) - 5
%%        end,

%%    PartCount1 = decide_wash_attr_part_count(Type, TotalPartCount),
    GrowBase = decide_wash_attr_part_count2(data_special_config:get(partner_grow_coef)),

    LifeAptBase =decide_wash_attr_part_count2(data_special_config:get(partner_aptitude_coef)),

    PhyAttAptBase = decide_wash_attr_part_count2(data_special_config:get(partner_aptitude_coef)),

    PhyDefAptBase = decide_wash_attr_part_count2(data_special_config:get(partner_aptitude_coef)),

    MagAttAptBase = decide_wash_attr_part_count2(data_special_config:get(partner_aptitude_coef)),

    MagDefAptBase = decide_wash_attr_part_count2(data_special_config:get(partner_aptitude_coef)),

    SpeedAptBase = decide_wash_attr_part_count2(data_special_config:get(partner_aptitude_coef)),

    #base_train_attrs{
        grow = GrowBase,
        life_aptitude = LifeAptBase,
        phy_att_aptitude = PhyAttAptBase,
        mag_att_aptitude = MagAttAptBase,
        phy_def_aptitude = PhyDefAptBase,
        mag_def_aptitude = MagDefAptBase,
        speed_aptitude = SpeedAptBase
    }.




classify_postnatal_skill_by_rarity(SkillIdList) ->
    F = fun(X) ->
        SklCfg = data_skill:get(X),
        case SklCfg#skl_cfg.is_inborn of
            0 ->
                case lists:member(X, SkillIdList) of
                    true -> X;
                    false -> ?INVALID_ID
                end;
            1 -> ?INVALID_ID
        end
    end,

    AllRarityNoList = sets:to_list(sets:from_list(data_skill:get_all_rarity_no_list())),
    ValidRarityNoList = AllRarityNoList -- [?INVALID_NO],
    L11 =
        case lists:member(1, ValidRarityNoList) of
            false ->
                [];
            true ->
                L1 = [F(X) || X <- data_skill:get_skill_id_list_by_rarity(1)],
                [X || X <- L1, X /= ?INVALID_ID]
        end,
    L22 =
        case lists:member(2, ValidRarityNoList) of
            false ->
                [];
            true ->
                L2 = [F(X) || X <- data_skill:get_skill_id_list_by_rarity(2)],
                [X || X <- L2, X /= ?INVALID_ID]
        end,

    L33 =
        case lists:member(3, ValidRarityNoList) of
            false ->
                [];
            true ->
                L3 = [F(X) || X <- data_skill:get_skill_id_list_by_rarity(3)],
                [X || X <- L3, X /= ?INVALID_ID]
        end,

    L44 =
        case lists:member(4, ValidRarityNoList) of
            false ->
                [];
            true ->
                L4 = [F(X) || X <- data_skill:get_skill_id_list_by_rarity(4)],
                [X || X <- L4, X /= ?INVALID_ID]
        end,
    {L11, L22, L33, L44}.


%５５％　２５％　１５％　５％的概率分别获得稀有度分别是 4 3 2 1 的技能
%% return skl_brief 结构体列表
get_postnatal_skill(AccList, SkillCount, L1, L2, L3, L4, SkillNameL) ->
    get_postnatal_skill(AccList, SkillCount, L1, L2, L3, L4, SkillNameL, 1000).

get_postnatal_skill(AccList, 0, _L1, _L2, _L3, _L4, _SkillNameL, _) ->
    AccList;
get_postnatal_skill(AccList, _SkillCount, [], [], [], [], _SkillNameL, _) ->
    AccList;
get_postnatal_skill(AccList, _SkillCount, _, _, _, _, _SkillNameL, 0) ->
    AccList;

get_postnatal_skill(AccList, SkillCount, L1, L2, L3, L4, SkillNameL, TryTimes) ->
    RandNum = util:rand(1, 100),
    if
        1 =< RandNum andalso RandNum =< 55 ->
            case L4 =:= [] of
                false ->
                    SkillId = lists:nth(util:rand(1, length(L4)), L4),
                    Name = mod_skill:get_name_by_id(SkillId),
                    case has_skill_with_same_type(SkillNameL, Name) of
                        false ->
                            AccList1 = [#skl_brief{id = SkillId}] ++ AccList,
                            get_postnatal_skill(AccList1, SkillCount - 1, L1, L2, L3, L4 -- [SkillId], [Name | SkillNameL], TryTimes-1);
                        true ->
                            get_postnatal_skill(AccList, SkillCount, L1, L2, L3, L4 -- [SkillId], SkillNameL, TryTimes-1)
                    end;
                true ->
                    get_postnatal_skill(AccList, SkillCount, L1, L2, L3, L4, SkillNameL, TryTimes-1)
            end;
        55 < RandNum andalso RandNum =< 80 ->
            case L3 =:= [] of
                false ->
                    SkillId = lists:nth(util:rand(1, length(L3)), L3),
                    Name = mod_skill:get_name_by_id(SkillId),
                    case has_skill_with_same_type(SkillNameL, Name) of
                        false ->
                            AccList1 = [#skl_brief{id = SkillId}] ++ AccList,
                            get_postnatal_skill(AccList1, SkillCount - 1, L1, L2, L3 -- [SkillId], L4, [Name | SkillNameL], TryTimes-1);
                        true ->
                            get_postnatal_skill(AccList, SkillCount, L1, L2, L3 -- [SkillId], L4, SkillNameL, TryTimes-1)
                    end;
                true ->
                    get_postnatal_skill(AccList, SkillCount, L1, L2, L3, L4, SkillNameL, TryTimes-1)
            end;
        80 < RandNum andalso RandNum =< 95 ->
            case L2 =:= [] of
                false ->
                    SkillId = lists:nth(util:rand(1, length(L2)), L2),
                    Name = mod_skill:get_name_by_id(SkillId),
                    case has_skill_with_same_type(SkillNameL, Name) of
                        false ->
                            AccList1 = [#skl_brief{id = SkillId}] ++ AccList,
                            get_postnatal_skill(AccList1, SkillCount - 1, L1, L2 -- [SkillId], L3, L4, [Name | SkillNameL], TryTimes-1);
                        true ->
                            get_postnatal_skill(AccList, SkillCount, L1, L2 -- [SkillId], L3, L4, SkillNameL, TryTimes-1)
                    end;
                true ->
                    get_postnatal_skill(AccList, SkillCount, L1, L2, L3, L4, SkillNameL, TryTimes-1)
            end;
        95 < RandNum andalso RandNum =< 100 ->
            case L1 =:= [] of
                false ->
                    SkillId = lists:nth(util:rand(1, length(L1)), L1),
                    Name = mod_skill:get_name_by_id(SkillId),
                    case has_skill_with_same_type(SkillNameL, Name) of
                        false ->
                            AccList1 = [#skl_brief{id = SkillId}] ++ AccList,
                            get_postnatal_skill(AccList1, SkillCount - 1, L1 -- [SkillId], L2, L3, L4, [Name | SkillNameL], TryTimes-1);
                        true ->
                            get_postnatal_skill(AccList, SkillCount, L1 -- [SkillId], L2, L3, L4, SkillNameL, TryTimes-1)
                    end;
                true ->
                    get_postnatal_skill(AccList, SkillCount, L1, L2, L3, L4, SkillNameL, TryTimes-1)
            end;
        true ->
            get_postnatal_skill(AccList, SkillCount, L1, L2, L3, L4, SkillNameL, TryTimes-1)
    end.


%５５％　２５％　１５％　５％ 的概率分别获得稀有度分别是 4 3 2 1 的技能
%% return skl_brief 结构体列表
get_inborn_skill(AccList, SkillCount, L1, L2, L3, L4) ->
    get_inborn_skill(AccList, SkillCount, L1, L2, L3, L4, 1000).

get_inborn_skill(AccList, 0, _L1, _L2, _L3, _L4, _) ->
    AccList;
get_inborn_skill(AccList, _SkillCount, [], [], [], [], _) ->
    AccList;
get_inborn_skill(AccList, _, _L1, _L2, _L3, _L4, 0) ->
    AccList;

get_inborn_skill(AccList, SkillCount, L1, L2, L3, L4, TryTimes) ->
    RandNum = util:rand(1, 100),
    if
        1 =< RandNum andalso RandNum =< 55 ->
            case L4 =:= [] of
                false ->
                    SkillId = lists:nth(util:rand(1, length(L4)), L4),
                    AccList1 = [#skl_brief{id = SkillId}] ++ AccList,
                    get_inborn_skill(AccList1, SkillCount - 1, L1, L2, L3, L4 -- [SkillId], TryTimes-1);
                true ->
                    get_inborn_skill(AccList, SkillCount, L1, L2, L3, L4, TryTimes-1)
            end;
        55 < RandNum andalso RandNum =< 80 ->
            case L3 =:= [] of
                false ->
                    SkillId = lists:nth(util:rand(1, length(L3)), L3),
                    AccList1 = [#skl_brief{id = SkillId}] ++ AccList,
                    get_inborn_skill(AccList1, SkillCount - 1, L1, L2, L3 -- [SkillId], L4, TryTimes-1);
                true ->
                    get_inborn_skill(AccList, SkillCount, L1, L2, L3, L4, TryTimes-1)
            end;
        80 < RandNum andalso RandNum =< 95 ->
            case L2 =:= [] of
                false ->
                    SkillId = lists:nth(util:rand(1, length(L2)), L2),
                    AccList1 = [#skl_brief{id = SkillId}] ++ AccList,
                    get_inborn_skill(AccList1, SkillCount - 1, L1, L2 -- [SkillId], L3, L4, TryTimes-1);
                true ->
                    get_inborn_skill(AccList, SkillCount, L1, L2, L3, L4, TryTimes-1)
            end;
        95 < RandNum andalso RandNum =< 100 ->
            case L1 =:= [] of
                false ->
                    SkillId = lists:nth(util:rand(1, length(L1)), L1),
                    AccList1 = [#skl_brief{id = SkillId}] ++ AccList,
                    get_inborn_skill(AccList1, SkillCount - 1, L1 -- [SkillId], L2, L3, L4, TryTimes-1);
                true ->
                    get_inborn_skill(AccList, SkillCount, L1, L2, L3, L4, TryTimes-1)
            end;
        true ->
            get_inborn_skill(AccList, SkillCount, L1, L2, L3, L4, TryTimes-1)
    end.


%% return {L1, L2, L3, L4} 分别表示稀有度分别是1 2 3 4 的技能列表
classify_inborn_skill_by_rarity(SkillIdList) ->
    AllRarityNoList = sets:to_list(sets:from_list(data_skill:get_all_rarity_no_list())),
    ValidRarityNoList = AllRarityNoList -- [?INVALID_NO],

    F1 = fun(X) ->
        case data_skill:get(X) of
            null -> ?INVALID_ID;
            _SkillCfg ->
%%                ?ASSERT(_SkillCfg#skl_cfg.is_inborn =:= 1, X), 策划说不用先天后天了
                List =
                    case lists:member(1, ValidRarityNoList) of
                        false -> [];
                        true -> data_skill:get_skill_id_list_by_rarity(1)
                    end,
                case lists:member(X, List) of
                    true -> X;
                    false -> ?INVALID_ID
                end
        end
    end,
    L1 = [F1(X) || X <- SkillIdList],
    L11 = [X || X <- L1, X /= ?INVALID_ID],

    F2 = fun(X) ->
        List =
            case lists:member(2, ValidRarityNoList) of
                false -> [];
                true -> data_skill:get_skill_id_list_by_rarity(2)
            end,
        case lists:member(X, List) of
            true -> X;
            false -> ?INVALID_ID
        end
    end,
    L2 = [F2(X) || X <- SkillIdList],
    L22 = [X || X <- L2, X /= ?INVALID_ID],

    F3 = fun(X) ->
        List =
            case lists:member(3, ValidRarityNoList) of
                false -> [];
                true -> data_skill:get_skill_id_list_by_rarity(3)
            end,
        case lists:member(X, List) of
            true -> X;
            false -> ?INVALID_ID
        end
    end,
    L3 = [F3(X) || X <- SkillIdList],
    L33 = [X || X <- L3, X /= ?INVALID_ID],

    F4 = fun(X) ->
        List =
            case lists:member(4, ValidRarityNoList) of
                false -> [];
                true -> data_skill:get_skill_id_list_by_rarity(4)
            end,
        case lists:member(X, List) of
            true -> X;
            false -> ?INVALID_ID
        end
    end,
    L4 = [F4(X) || X <- SkillIdList],
    L44 = [X || X <- L4, X /= ?INVALID_ID],
    {L11, L22, L33, L44}.


notify_other_sys_partner_join_battle(PS) ->
    F = fun(Id, Acc) ->
        case lib_partner:get_partner(Id) of
            null -> Acc;
            Partner ->
                Quality = lib_partner:get_quality(Partner),
                case lists:member(Quality, Acc) of
                    true -> Acc;
                    false -> [Quality | Acc]
                end
        end
    end,
    QualityList = lists:foldl(F, [], player:get_partner_id_list(PS)),

    F1 = fun(Q, Acc) ->
         F2 = fun(Id, Sum) ->
            case lib_partner:get_partner(Id) of
                null -> Sum;
                Partner ->
                    case lib_partner:get_quality(Partner) =:= Q andalso lists:member(lib_partner:get_state(Partner), [?PAR_STATE_JOIN_BATTLE_LOCKED, ?PAR_STATE_JOIN_BATTLE_UNLOCKED]) of
                        true -> Sum + 1;
                        false -> Sum
                    end
            end
        end,
        Num = lists:foldl(F2, 0, player:get_partner_id_list(PS)),
        [[{quality, Q}, {num, Num}] | Acc]
    end,
    InfoList = lists:foldl(F1, [], QualityList),
    mod_achievement:notify_achi(partner_join_battle, InfoList, PS),

    %扩展通知成就
    F4 = fun(Id, Acc) ->
        case lib_partner:get_partner(Id) of
            null -> Acc;
            Partner ->
                PlayerLvNeed = (data_partner:get(lib_partner:get_no(Partner)))#par_born_data.player_lv_need,
                [[{quality, lib_partner:get_quality(Partner)}, {lv,PlayerLvNeed}] | Acc]
        end   
    end,
    InfoList2 = lists:foldl(F4, [], player:get_partner_id_list(PS)),
    mod_achievement:notify_achi(partner_join_battle_ex, InfoList2, PS),

    mod_achievement:notify_achi(set_pet_battler, [{num, length(player:get_partner_id_list(PS))}], PS),

    F3 = fun(Id, Acc) ->
        case lib_partner:get_partner(Id) of
            null -> Acc;
            Partner ->
                case lib_partner:is_fighting(Partner) of
                    false -> Acc;
                    true -> [[{cultivate_lv, lib_partner:get_cultivate_lv(Partner)}] | Acc]
                end
        end
    end,
    InfoList1 = lists:foldl(F3, [], player:get_partner_id_list(PS)),
    mod_achievement:notify_achi(partner_join_battle, InfoList1, PS).


%% 通知成就等其他系统
notify_when_partner_cultivate_lv_up(PS) ->
    F = fun(Id, Acc) ->
        case lib_partner:get_partner(Id) of
            null -> Acc;
            Partner ->
                case lib_partner:is_fighting(Partner) of
                    false -> Acc;
                    true -> [[{cultivate_lv, lib_partner:get_cultivate_lv(Partner)}] | Acc]
                end
        end
    end,
    InfoList = lists:foldl(F, [], player:get_partner_id_list(PS)),
    mod_achievement:notify_achi(partner_join_battle, InfoList, PS).

% has_high_skill_with_same_type(Partner, SkillId) when is_integer(SkillId) ->
%     case data_skill:get(SkillId) of
%         null -> false;
%         SklCfg -> has_high_skill_with_same_type(lib_partner:get_skill_name_list(Partner), binary_to_list(SklCfg#skl_cfg.name))
%     end;
% has_high_skill_with_same_type([H | T], Name) ->
%     case string:str(binary_to_list(H), Name) =/= 0 of
%         true -> true;
%         false -> has_high_skill_with_same_type(T, Name)
%     end;
% has_high_skill_with_same_type([], _Name) ->
%     false.


% 判断是否有相同类型技能
has_low_skill_with_same_type(NameList, SkillId) when is_integer(SkillId) andalso is_list(NameList) ->
    case data_skill:get(SkillId) of
        null -> false;
        SklCfg ->
            has_low_skill_with_same_type(NameList, SklCfg#skl_cfg.name)
    end;

has_low_skill_with_same_type(Partner, SkillId) when is_integer(SkillId) ->
    case data_skill:get(SkillId) of
        null -> false;
        SklCfg -> has_low_skill_with_same_type(lib_partner:get_skill_name_list(Partner), binary_to_list(SklCfg#skl_cfg.name))
    end;

has_low_skill_with_same_type([H | T], Name) when is_binary(Name) ->
    Name1 = binary_to_list(Name),
    has_low_skill_with_same_type([H | T], Name1);

has_low_skill_with_same_type([H | T], Name) ->
    case string:str(binary_to_list(H), Name) =/= 0 orelse string:str(Name, binary_to_list(H)) =/= 0 of
        true -> true;
        false -> has_low_skill_with_same_type(T, Name)
    end;
has_low_skill_with_same_type([], _Name) ->
    false.


%% 判断是否有相同技能
has_skill_with_same_type(NameList, SkillId) when is_integer(SkillId) andalso is_list(NameList) ->
    case data_skill:get(SkillId) of
        null -> false;
        SklCfg ->
            has_skill_with_same_type(NameList, SklCfg#skl_cfg.name)
    end;

has_skill_with_same_type(Partner, SkillId) when is_integer(SkillId) ->
    case data_skill:get(SkillId) of
        null -> false;
        SklCfg -> has_skill_with_same_type(lib_partner:get_skill_name_list(Partner), binary_to_list(SklCfg#skl_cfg.name))
    end;

has_skill_with_same_type([H | T], Name) when is_binary(Name) ->
    Name1 = binary_to_list(Name),
    has_skill_with_same_type([H | T], Name1);

has_skill_with_same_type([H | T], Name) ->
    case binary_to_list(H) == Name of
        true -> true;
        false -> has_skill_with_same_type(T, Name)
    end;
has_skill_with_same_type([], _Name) ->
    false.


make_count_prob_list(Index, List) ->
    make_count_prob_list(Index, List, []).

make_count_prob_list(_Index, [], RetList) ->
    RetList;
make_count_prob_list(_Index, List, RetList) when length(List) =< length(RetList) ->
    RetList;
make_count_prob_list(Index, List, RetList) when Index > length(List) ->
    RetList;
make_count_prob_list(Index, List, RetList) ->
    Count = lists:nth(Index, List),
    Prob = lists:nth(length(List) - Index + 1, List),
    make_count_prob_list(Index + 1, List, [{Count, Prob} | RetList]).


rand_get_skill_count(Min, Max) ->
    List = lists:seq(Min, Max),
    Range = lists:foldl(fun(X, Sum) -> Sum + X end, 0, List),
    CountProbL = make_count_prob_list(1, List),
    rand_get_skill_count(Range, CountProbL, 0).


rand_get_skill_count(_Range, [], _SumToCompare) ->
    ?ASSERT(false, _Range), 1;
rand_get_skill_count(Range, [{Count, Prob} | T], SumToCompare) ->
    RandNum = util:rand(1, Range),
    SumToCompare_2 = Prob + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true -> Count;
        false -> rand_get_skill_count(Range, T, SumToCompare_2)
    end.


get_counter(money, FindPar) when is_record(FindPar, find_par) ->
    LvStep = FindPar#find_par.lv_step,
    case lists:keyfind(LvStep, 1, FindPar#find_par.counter) of
        false -> 0;
        {_, _Count, Money} -> Money
    end;
get_counter(count, FindPar) when is_record(FindPar, find_par) ->
    LvStep = FindPar#find_par.lv_step,
    case lists:keyfind(LvStep, 1, FindPar#find_par.counter) of
        false -> 0;
        {_, Count, _Money} -> Count
    end.


get_counter(money, FindPar, LvStep) when is_record(FindPar, find_par) ->
    case lists:keyfind(LvStep, 1, FindPar#find_par.counter) of
        false -> 0;
        {_, _Count, Money} -> Money
    end;
get_counter(count, FindPar, LvStep) when is_record(FindPar, find_par) ->
    case lists:keyfind(LvStep, 1, FindPar#find_par.counter) of
        false -> 0;
        {_, Count, _Money} -> Count
    end.

update_counter(money, FindPar, Value) when is_record(FindPar, find_par) ->
    LvStep = FindPar#find_par.lv_step,
    case lists:keyfind(LvStep, 1, FindPar#find_par.counter) of
        false -> [{LvStep, 0, Value} | FindPar#find_par.counter];
        {_, Count, _Money} -> lists:keyreplace(LvStep, 1, FindPar#find_par.counter, {LvStep, Count, Value})
    end.    


update_counter(money, FindPar, Value, LvStep) when is_record(FindPar, find_par) ->
    case lists:keyfind(LvStep, 1, FindPar#find_par.counter) of
        false -> [{LvStep, 0, Value} | FindPar#find_par.counter];
        {_, Count, _Money} -> lists:keyreplace(LvStep, 1, FindPar#find_par.counter, {LvStep, Count, Value})
    end;
update_counter(count, FindPar, Value, LvStep) when is_record(FindPar, find_par) ->
    case lists:keyfind(LvStep, 1, FindPar#find_par.counter) of
        false -> [{LvStep, Value, 0} | FindPar#find_par.counter];
        {_, _Count, Money} -> lists:keyreplace(LvStep, 1, FindPar#find_par.counter, {LvStep, Value, Money})
    end.


set_counter(FindPar, ParNoList, ResetCount, RetsetMoney) when is_record(FindPar, find_par) ->
    NewCount = 
        case ResetCount of
            false -> get_counter(count, FindPar) + length(ParNoList);
            true -> 0
        end,
    NewMoney = 
        case RetsetMoney of
            false -> get_counter(money, FindPar);
            true -> 0
        end,

    case RetsetMoney of
        false -> update_counter(count, FindPar, NewCount, FindPar#find_par.lv_step);
        true -> 
            NewCounter = update_counter(count, FindPar, NewCount, FindPar#find_par.lv_step),
            update_counter(money, FindPar#find_par{counter = NewCounter}, NewMoney, FindPar#find_par.lv_step)
    end.

%% 获取宠物相关系数配置数据
%% return ability_lv_cfg 结构体 | null
get_partner_coef_cfg(Partner) ->
    Lv = lib_partner:get_ref_lv(Partner),
    List = data_ability_lv_cfg:get_all_lv_step_list(),
    get_partner_coef_cfg__(List, Lv).

get_partner_coef_cfg__([], _RefLv) ->
    ?ASSERT(false, _RefLv),
    null;
get_partner_coef_cfg__([H | T], RefLv) ->
    case data_ability_lv_cfg:get(H) of
        null ->
            get_partner_coef_cfg__(T, RefLv);
        Data ->
            RangeList = Data#ability_lv_cfg.range,
            ?ASSERT(length(RangeList) =:= 2),
            case length(RangeList) =:= 2 of
                false -> 
                    ?ASSERT(false, RangeList),
                    get_partner_coef_cfg__(T, RefLv);
                true ->
                    case util:in_range(RefLv, lists:nth(1, RangeList), lists:nth(2, RangeList)) of
                        true -> Data;
                        false -> get_partner_coef_cfg__(T, RefLv)
                    end
            end
    end.

decide_wash_attr_part_count( TotalPartCount) ->
    util:rand(50, 100)/100.


decide_wash_attr_part_count2({Min,Max}) ->
    util:rand(Min, Max).

% %%１是普通洗髓 2 是高级洗髓
% decide_wash_attr_part_count(Type, Len) ->
%     List = 
%         case Type of
%             1 -> data_wash_prob_cfg:get_all_no_list();
%             2 -> lists:sublist(data_wash_prob_cfg:get_all_no_list(), 2, Len-1)
%         end,

%     F = fun(X, Sum) ->
%         case data_wash_prob_cfg:get(X) of
%             null -> Sum;
%             Data -> Data#wash_prob_cfg.prob + Sum
%         end
%     end,
%     Range = lists:foldl(F, 0, List),
%     RandNum = util:rand(1, Range),
%     decide_wash_attr_part_count(List, RandNum, 0).
    

% decide_wash_attr_part_count([H | T], RandNum, SumToCompare) ->
%     Data = data_wash_prob_cfg:get(H),
%     SumToCompare_2 = Data#wash_prob_cfg.prob + SumToCompare,
%     case RandNum =< SumToCompare_2 of
%         true ->
%             Data#wash_prob_cfg.no;
%         false ->
%             decide_wash_attr_part_count(T, RandNum, SumToCompare_2)
%     end;
% decide_wash_attr_part_count([], _RandNum, _SumToCompare) ->
%     ?ASSERT(false), 0.  % 正常逻辑不会触发此分支，返回0以容错！


free_get_goods_list_for_evolve(Data, ParObj) ->
    case lib_partner:get_ref_lv_step(ParObj) of
        1 -> Data#partner_evolve.free_get_goods_1;
        2 -> Data#partner_evolve.free_get_goods_2;
        3 -> Data#partner_evolve.free_get_goods_3;
        4 -> Data#partner_evolve.free_get_goods_4;
        5 -> Data#partner_evolve.free_get_goods_5;
        6 -> Data#partner_evolve.free_get_goods_6;
        7 -> Data#partner_evolve.free_get_goods_7;
        _ -> ?ASSERT(false),[]
    end.

free_get_goods_list_for_cultivate(Data, ParObj) ->
    case lib_partner:get_ref_lv_step(ParObj) of
        1 -> Data#partner_cultivate.free_get_goods_1;
        2 -> Data#partner_cultivate.free_get_goods_2;
        3 -> Data#partner_cultivate.free_get_goods_3;
        4 -> Data#partner_cultivate.free_get_goods_4;
        5 -> Data#partner_cultivate.free_get_goods_5;
        6 -> Data#partner_cultivate.free_get_goods_6;
        7 -> Data#partner_cultivate.free_get_goods_7;
        _ -> ?ASSERT(false),[]
    end.


%% 因为策划进化规则调整，需要调整女妖的进化值，防止玩家旧女妖进化时，发生进化等级倒退 (已经过时，故注释掉)
adjust_evole(Partner) ->
    Partner.
    % case lib_partner:get_version(Partner) =:= ?PAR_DATA_VERSION_NEW of
    %     true -> Partner;
    %     false ->
    %         EvolveCoef = 
    %             case get_partner_coef_cfg(Partner) of
    %                 null -> ?ASSERT(false), 1;
    %                 AbilityLvCfg ->
    %                     AbilityLvCfg#ability_lv_cfg.evolve_coef
    %             end,

    %         NowEvolve = lib_partner:get_evolve(Partner),
    %         {BaseEvole, EvolveNo} = 
    %             case data_partner_evolve:get(lib_partner:get_quality(Partner), lib_partner:get_evolve_lv(Partner)) of
    %                 null -> 
    %                     ?ASSERT(false), 
    %                     ?ERROR_MSG("ply_partner:adjust_evole error!{Quality, evolve_lv}:~p~n", [{lib_partner:get_quality(Partner), lib_partner:get_evolve_lv(Partner)}]),
    %                     {?MAX_U32, 0};
    %                 EvolveCfg -> {EvolveCfg#partner_evolve.evolve, EvolveCfg#partner_evolve.no}
    %             end,

    %         %% 进化当前值（进化到某个等级，多余的进化值
    %         CurAddEvole = max(NowEvolve - BaseEvole, 0),
    %         NextEvolveNo = EvolveNo + 1,
    %         {NextQ, NextEvolveLv} = 
    %             case data_partner_evolve:get(NextEvolveNo) of
    %                 null -> {?QUALITY_INVALID, 0};
    %                 {TNextQ, TNextEvolveLv} -> {TNextQ, TNextEvolveLv}
    %             end,

    %         NextBaseEvole =
    %             case data_partner_evolve:get(NextQ, NextEvolveLv) of
    %                 null -> 
    %                     ?ASSERT(false), 
    %                     ?ERROR_MSG("ply_partner:adjust_evole error!{NextQ, NextEvolveLv}:~p~n", [{NextQ, NextEvolveLv}]),
    %                     ?MAX_U32;
    %                 NextEvolveCfg -> NextEvolveCfg#partner_evolve.evolve
    %             end,

    %         NewEvolve = util:ceil(BaseEvole * EvolveCoef + (NextBaseEvole * EvolveCoef) * (CurAddEvole / NextBaseEvole)),
    %         ?DEBUG_MSG("ply_partner:adjust_evole info, NowEvolve:~p, NewEvolve:~p, EvolveNo:~p, NextEvolveNo:~p ~n", [NowEvolve, NewEvolve, EvolveNo, NextEvolveNo]),
    %         case NewEvolve - NowEvolve >= 2000 of
    %             true -> ?WARNING_MSG("ply_partner:adjust_evole error!NowEvolve:~p, NewEvolve:~p~n", [NowEvolve, NewEvolve]);
    %             false -> skip
    %         end,
    %         case NextQ =:= ?QUALITY_INVALID of
    %             true -> lib_partner:set_version(Partner, ?PAR_DATA_VERSION_NEW);
    %             false -> 
    %                 Partner1 = lib_partner:set_evolve(Partner, NewEvolve),
    %                 Partner2 = lib_partner:set_version(Partner1, ?PAR_DATA_VERSION_NEW),
    %                 lib_partner:set_dirty_flag(Partner2, true)
    %         end
    % end.

%% return 放生获得物品列表 、身上穿的装备列表 和 [{Partner, GoodsList}...]
%% 获得物品->返还新增规则
get_return_goods_for_free(PlayerId, ParObjList) ->
    F = fun(ParObj, {AccList, AccEq, AccKVL}) ->
        L1 = 
            case data_partner_evolve:get(lib_partner:get_quality(ParObj), lib_partner:get_evolve_lv(ParObj)) of
                null -> [];
                Data1 -> 
                    ?ASSERT(is_list(Data1#partner_evolve.free_get_goods_1), Data1#partner_evolve.free_get_goods_1),
                    free_get_goods_list_for_evolve(Data1, ParObj)
            end,
        L2 = 
            case data_partner_cultivate:get(lib_partner:get_cultivate_lv(ParObj), lib_partner:get_cultivate_layer(ParObj)) of
                null -> [];
                Data2 -> 
                    ?ASSERT(is_list(Data2#partner_cultivate.free_get_goods_1), Data2#partner_cultivate.free_get_goods_1),
                    free_get_goods_list_for_cultivate(Data2, ParObj)
            end,
        TEqList = mod_equip:get_partner_equip_list(PlayerId, lib_partner:get_id(ParObj)),
        EqList = lists:foldl(fun(Goods, Acc) -> [{lib_goods:get_no(Goods), 1} | Acc] end, [], TEqList),

        {L1 ++ L2 ++ AccList, EqList ++ AccEq, [{ParObj, L1++L2} | AccKVL]}
    end,

    lists:foldl(F, {[],[],[]}, ParObjList).



%% 如果删除了跟随宠物则把主宠顶上
handle_for_del_follow_partner(PS) ->
    case mod_partner:get_main_partner_obj(PS) of
        null -> ?ASSERT(false), skip;
        MainPar ->
            player:set_follow_partner_id(PS, lib_partner:get_id(MainPar)),
            MainPar2 = lib_partner:set_follow_state(MainPar, ?PAR_FOLLOW),
            mod_partner:update_partner_to_ets(MainPar2),
            lib_partner:notify_cli_info_change(MainPar2, [{?OI_CODE_PAR_FOLLOW, ?PAR_FOLLOW}]),
            lib_partner:notify_main_partner_info_change_to_AOI(PS, MainPar2)
    end.


decide_cultivate(CultivateLv, CultivateLayer, Cultivate) ->
    case CultivateLv =:= 0 of
        true ->
            ?ASSERT(CultivateLayer =:= 0, CultivateLayer),
            {erlang:hd(data_partner_cultivate:get_all_cultivate_no_list()), Cultivate};
        false ->
            case CultivateLayer =:= 0 of
                false ->
                    {(data_partner_cultivate:get(CultivateLv, CultivateLayer))#partner_cultivate.no, Cultivate};
                true ->
                    MinNo = 
                        case data_partner_cultivate:get(CultivateLv, 1) of
                            null ->
                                ?ASSERT(false, CultivateLv),
                                ?ERROR_MSG("ply_partner:decide_cultivate error!CultivateLv:~p~n", [CultivateLv]),
                                1;
                            DataMin ->
                                DataMin#partner_cultivate.no
                        end,
                    MaxNo = 
                        case data_partner_cultivate:get(CultivateLv+1, 1) of
                            null ->
                                lists:last(data_partner_cultivate:get_all_cultivate_no_list());
                            DataMax ->
                                DataMax#partner_cultivate.no
                        end,
                    NoList = lists:seq(MinNo, MaxNo),
                    ?DEBUG_MSG("ply_partner:MinNo:~p, MaxNo:~p~n", [MinNo, MaxNo]),
                    decide_cultivate__(Cultivate, NoList, MaxNo)
            end
    end.

decide_cultivate__(Cultivate, [], MaxNo) ->
    {MaxNo, Cultivate};

decide_cultivate__(Cultivate, [H | T], MaxNo) ->
    {Lv, Layer} = data_partner_cultivate:get(H),
    case data_partner_cultivate:get(Lv, Layer) of
        null -> {H, Cultivate};
        Data ->
            case Cultivate < (Data#partner_cultivate.cultivate_next_lv_need) of
                true -> {H, Cultivate};
                false -> decide_cultivate__(Cultivate - (Data#partner_cultivate.cultivate_next_lv_need), T, MaxNo)
            end
    end.
    

%% 纠正女妖等级，如果线上没有数据等级异常，可以不调用这个函数    
adust_lv(PS) ->
    IdList = player:get_partner_id_list(PS),
    F = fun(PartnerId) ->
        case lib_partner:get_partner(PartnerId) of
            null ->
                skip;
            Partner ->
                case lib_partner:get_lv(Partner) - player:get_lv(PS) > ?DELTA_LV_PLAYER_PAR of
                    true ->
                        Lv = player:get_lv(PS) + ?DELTA_LV_PLAYER_PAR,
                        ExpLim = lib_partner:get_exp_lim(Lv),
                        Partner1 = lib_partner:set_lv(Partner, Lv),
                        Partner2 = lib_partner:set_exp(Partner1, ExpLim-10),
                        mod_partner:update_partner_to_ets(Partner2);
                    false ->
                        skip
                end
        end
    end,
    [F(X) || X <- IdList].


del_skill(PS,PartnerId,SkillId) ->
    case check_del_skill(PS, PartnerId,SkillId) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_del_skill(PS,PartnerId, SkillId)
    end.

check_del_skill(PS, PartnerId,SkillId) ->
    case lib_partner:get_partner(PartnerId) of
        null -> {fail, ?PM_PAR_NOT_EXISTS};
        Partner ->
            case lib_partner:has_skill(Partner,SkillId,noequip) of
                true -> 
					%% 遗忘技能不需要判断这些了，有就可以了，而且也不需要消耗了
					   ok;
%%                     InbornCount =  lists:foldl(fun(_X, Sum) -> Sum + 1 end, 0, lib_partner:get_inborn_skill_name_list(Partner)),
%%                     NeedMoney = util:ceil((2000+math:pow(2000,(InbornCount*0.5)))/1000)*1000,
%% 
%%                     case player:has_enough_bind_gamemoney(PS, NeedMoney) of
%%                         false ->
%%                             {fail, ?PM_GAMEMONEY_LIMIT};
%%                         true ->
%%                             ok
%%                     end;
                false -> {fail, ?PM_PAR_NOT_HAVE_SKILL}
            end
    end.
    
do_del_skill(_PS,PartnerId,SkillId) ->
    Partner = lib_partner:get_partner(PartnerId),

%%     InbornCount =  lists:foldl(fun(_X, Sum) -> Sum + 1 end, 0, lib_partner:get_inborn_skill_name_list(Partner)),
%%     NeedMoney = util:ceil((2000+math:pow(2000,(InbornCount*0.5)))/1000)*1000,

    SkillList = lib_partner:get_skill_list(Partner),
    NewSkillList = lists:keydelete(SkillId, #skl_brief.id, SkillList),
    Partner1 = lib_partner:set_skill_list(Partner, NewSkillList),
    Partner3 = lib_partner:recount_total_attrs(Partner1),
    Partner4 = lib_partner:recount_battle_power(Partner3),

%%     player_syn:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, NeedMoney, [?LOG_PARTNER, "del_skill"]),
    
    mod_partner:update_partner_to_ets(Partner4),
    mod_partner:db_save_partner(Partner4),
    lib_partner:notify_cli_info_change(Partner4, [{?OI_CODE_PAR_DEL_SKILL, SkillId}]),
    ok.


%% 切换宠物使用的技能页
change_skill_page(PS, PartnerId, SkillsUse) ->
	case check_change_skill_page(PS, PartnerId,SkillsUse) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_change_skill_page(PS,PartnerId, SkillsUse)
    end.

check_change_skill_page(_PS, PartnerId,_SkillsUse) ->
    case lib_partner:get_partner(PartnerId) of
        null -> {fail, ?PM_PAR_NOT_EXISTS};
        _Partner ->
            ok
    end.

do_change_skill_page(_PS,PartnerId,SkillsUse0) ->
	SkillsUse = case SkillsUse0 of
					1 ->
						1;
					_ ->
						2
				end,
    Partner = lib_partner:get_partner(PartnerId),
	Partner1 = lib_partner:set_skills_use(Partner, SkillsUse),
    Partner2 = lib_partner:recount_total_attrs(Partner1),
    Partner3 = lib_partner:recount_battle_power(Partner2),
    
    mod_partner:update_partner_to_ets(Partner3),
    mod_partner:db_save_partner(Partner3),
    ok.


%% 扩展宠物技能格子数
expand_skill_slot(PS, PartnerId) ->
	case check_expand_skill_slot(PS, PartnerId) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_expand_skill_slot(PS,PartnerId)
    end.

check_expand_skill_slot(PS, PartnerId) ->
    case lib_partner:get_partner(PartnerId) of
        null -> {fail, ?PM_PAR_NOT_EXISTS};
        Partner ->
			#par_born_data{max_postnatal_skill_slot = Max_postnatal_skill_slot} = data_partner:get(lib_partner:get_no(Partner)),
			SlotCurrent = lib_partner:get_max_postnatal_skill_slot(Partner),
			case SlotCurrent < Max_postnatal_skill_slot of
				?true ->
					IdCountL = expand_skill_slot_cost(SlotCurrent),
					case mod_inv:check_batch_destroy_goods(player:id(PS), IdCountL) of
						{fail, Reason} -> 
							{fail, Reason};
						ok -> 
							ok
					end;
				?false ->
					{fail, ?PM_SKILL_EXPAND_SLOT_MAX}
			end 
    end.
    
do_expand_skill_slot(PS,PartnerId) ->
	do_expand_skill_slot(PS, PartnerId, true).

do_expand_skill_slot(PS, PartnerId, IsCost) ->
	Partner = lib_partner:get_partner(PartnerId),
	SlotCurrent = lib_partner:get_max_postnatal_skill_slot(Partner),
	#par_born_data{max_postnatal_skill_slot = Max_postnatal_skill_slot} = data_partner:get(lib_partner:get_no(Partner)),
	case SlotCurrent < Max_postnatal_skill_slot of
		?true ->
			IdCountL = expand_skill_slot_cost(SlotCurrent),
			case IsCost of
				true ->
					mod_inv:destroy_goods_WNC(player:id(PS), IdCountL, [?LOG_PARTNER, "expand_skill_slot"]);
				_ ->
					skip
			end,
			Partner2 = lib_partner:set_max_postnatal_skill_slot(Partner, SlotCurrent + 1),
			mod_partner:update_partner_to_ets(Partner2),
			mod_partner:db_save_partner(Partner2),
			{ok, BinData} = pt_17:write(?PT_PARTNER_SKILL_SLOT_EXPAND, [PartnerId]),
			{ok, BinData};
		_ ->
			{fail, ?PM_SKILL_EXPAND_SLOT_MAX}
	end.

expand_skill_slot_cost(SlotCurrent) ->
	L0 = data_special_config:get(partner_expend_skill_goods),
	L = lists:keysort(1, L0),
	case erlang:is_list(L) andalso length(L) > 0 of
		?true ->
			expand_skill_slot_cost(SlotCurrent, L, []);
		?false ->
			[]
	end.

expand_skill_slot_cost(_SlotCurrent, [], Last) ->
	Last;

expand_skill_slot_cost(SlotCurrent, [{N, GoodsNo, Count}|L], _Last) ->
	case N >= SlotCurrent of
		?true ->
			[{GoodsNo, Count}];
		?false ->
			expand_skill_slot_cost(SlotCurrent, L, [{GoodsNo, Count}])
	end.
	


%% 修炼概率扩展格子
cultivate_expand_skill_slot(PS, PartnerId) ->
	case lib_partner:get_partner(PartnerId) of
		null ->
			%% 宠物不存在
			skip;
		Partner ->
			case data_special_config:get(partner_expend_skill_cult) of
				L when is_list(L) ->
					#par_born_data{max_postnatal_skill_slot = Max_postnatal_skill_slot} = data_partner:get(lib_partner:get_no(Partner)),
					SlotCurrent = lib_partner:get_max_postnatal_skill_slot(Partner),
					case SlotCurrent < Max_postnatal_skill_slot of
						?true ->
							case cultivate_expand_skill_slot_prob(SlotCurrent) of
								null ->
									skip;
								Proba ->
									%% 判断概率，然后开格子
									case util:decide_proba_once(Proba) of
										fail -> skip  ;
										success ->
											case do_expand_skill_slot(PS, PartnerId, false) of
												{ok, BinData} ->
													lib_send:send_to_sock(PS, BinData);
												_ ->
													skip
											end
									end
							
							end;
						?false ->
							skip
					end ;
				_ ->
					skip
			end
	end.
	

cultivate_expand_skill_slot_prob(SlotCurrent) ->
	L0 = data_special_config:get(partner_expend_skill_cult),
	L = lists:keysort(1, L0),
	case erlang:is_list(L) andalso length(L) > 0 of
		?true ->
			cultivate_expand_skill_slot_prob(SlotCurrent, L, null);
		?false ->
			null
	end.

cultivate_expand_skill_slot_prob(_SlotCurrent, [], LastProba) ->
	LastProba;

cultivate_expand_skill_slot_prob(SlotCurrent, [{N, Proba}|L], _Last) ->
	case N >= SlotCurrent of
		?true ->
			Proba;
		?false ->
			cultivate_expand_skill_slot_prob(SlotCurrent, L, Proba)
	end.


%% 宠物觉醒
partner_awake(PS, PartnerId) ->
	case lib_partner:get_partner(PartnerId) of
		null -> {fail, ?PM_PAR_NOT_EXISTS};
		Partner ->
			PartnerNo = lib_partner:get_no(Partner),
			%% 判断进化等级是否满足条件和觉醒条件是否满足
			AwakeLv = lib_partner:get_awake_lv(Partner),
			AwakeLvNext = AwakeLv + 1,
			case get_config_awake_lv(PartnerNo, AwakeLvNext) of
				{ok, #partner_awake{need_lv1 = NeedLvEvolve, need_lv2 = NeedLvCultivate, goods = GoodsList, skills = SkillsAdd}} ->
					{Quality, EvolveLv} = data_partner_evolve:get(NeedLvEvolve),
					case lib_partner:get_evolve_lv(Partner) >= EvolveLv andalso lib_partner:get_quality(Partner) >= Quality of
						?true ->
							case lib_partner:get_cultivate_lv(Partner) >= NeedLvCultivate of
								?true ->
									PlayerId = player:id(PS),
									case mod_inv:check_batch_destroy_goods(PlayerId, GoodsList) of
										{fail, Reason} ->
											{fail, Reason};
										ok ->
											mod_inv:destroy_goods_WNC(PlayerId, GoodsList, [?LOG_PARTNER, "awake"]),
											Partner2 = lib_partner:set_awake_lv(Partner, AwakeLvNext),
											SkillsExclusiveOld = lib_partner:get_exclusive_skill(Partner2),
											SkillsExclusive = 
												lists:foldl(fun(SkillId, Acc) ->
																	case lists:keymember(SkillId, #skl_brief.id, Acc) of
																		?true ->
																			Acc;
																		?false ->
																			[#skl_brief{id = SkillId}|Acc]
																	end
															end, SkillsExclusiveOld, SkillsAdd),
											Partner3 = lib_partner:set_exclusive_skill(Partner2, SkillsExclusive),
											Partner4 = lib_partner:recount_total_attrs(Partner3),
											Partner5 = lib_partner:recount_battle_power(Partner4),
											mod_partner:update_partner_to_ets(Partner5),
											mod_partner:db_save_partner(Partner5),
											{ok, AwakeLvNext}
									end;
								?false ->
									{fail, ?PM_AWAKE_CULTIVATE}
							end;
						?false ->
							{fail, ?PM_AWAKE_EVOLVE}
					end;
				null ->
					{fail, ?PM_AWAKE_BAN}
			end
	end.


%% 获取觉醒数据
get_config_awake_lv(PartnerNo, AwakeLv) ->
	Nos = data_partner_awake:get_nos(),
	Datas = 
		lists:foldl(fun(No, Acc) ->
							case data_partner_awake:get(No) of
								#partner_awake{par_no = PartnerNo, awake_lv = AwakeLv} = PartnerAwake ->
									[PartnerAwake|Acc];
								_ ->
									Acc
							end
					end, [], Nos),
	case Datas of
		[DataPartnerAwake|_] ->
			{ok, DataPartnerAwake};
		_ ->
			null
	end.



%% 根据宠物觉醒等级获取加成总属性？
attr_bonus_by_awake_lv(_PartnerNo, 0) ->
	[];

attr_bonus_by_awake_lv(PartnerNo, AwakeLv) ->
	Nos = data_partner_awake:get_nos(),
	case lists:foldl(fun(No, Acc) ->
							 case data_partner_awake:get(No) of
								 #partner_awake{par_no = PartnerNo, awake_lv = AwakeLvConfig} = PartnerAwake when AwakeLvConfig =< AwakeLv ->
									 [PartnerAwake|Acc];
								 _ ->
									 Acc
							 end
					 end, [], Nos) of
		[] ->
			[];
		Datas ->
			Datas2 = lists:keysort(#partner_awake.no, Datas),
			Datas3 = lists:sublist(Datas2, AwakeLv),
			lists:foldl(fun(#partner_awake{attrs = Attrs}, Acc) ->
								lists:append(Acc, Attrs)
						end, [], Datas3)
	end.
	


%% 宠物觉醒幻化
partner_awake_illusion(PS, PartnerId, AwakeLv) ->
	case lib_partner:get_partner(PartnerId) of
		null -> {fail, ?PM_PAR_NOT_EXISTS};
		Partner ->
			case lib_partner:get_awake_lv(Partner) >= AwakeLv of
				?true ->
					Partner2 = lib_partner:set_awake_illusion(Partner, AwakeLv),
					mod_partner:update_partner_to_ets(Partner2),
					mod_partner:db_save_partner(Partner2),
                    case lib_partner:is_follow_partner(Partner2) of
                        false -> skip;
                        true -> lib_partner:notify_main_partner_info_change_to_AOI(PS, Partner2)
                    end,
					ok;
				?false ->
					{fail, ?PM_AWAKE_LV_LOW}
			end
	end.
	


%% 宠物精炼
partner_refine(PS, PartnerId, 0, GoodsNo, Count) ->
	case lib_partner:get_partner(PartnerId) of
		#partner{} = Partner ->
			{ok, Partner};
		_ ->
			{fail, ?PM_PAR_NOT_EXISTS}
	end;

partner_refine(PS, PartnerId, AttrCode, GoodsNo, Count) ->
	case lib_partner:get_partner(PartnerId) of
		#partner{} = Partner ->
			case lib_attribute:obj_info_code_to_attr_name(AttrCode) of
				null ->
					{fail, ?PM_CLI_MSG_ILLEGAL};
				AttrName ->
					case check_partner_refine(PS, Partner, AttrName, GoodsNo, Count) of
						ok ->
							do_partner_refine(PS, Partner, AttrName, GoodsNo, Count);
						{fail, Reason} ->
							{fail, Reason} 
					end
			end;
		_ ->
			{fail, ?PM_PAR_NOT_EXISTS}
	end.


check_partner_refine(PS, Partner, AttrName, GoodsNo, Count) ->
	PlayerId = player:get_id(PS),
	case data_partner_refine:get(GoodsNo, AttrName) of
		#partner_refine{add_top = AddTop} ->
			GoodsList = [{GoodsNo, Count}],
			case mod_inv:check_batch_destroy_goods(PlayerId, GoodsList) of
				ok ->
					%% 判断未超过上限
					AttrRefine = lib_partner:get_attr_refine(Partner),
					case lists:keyfind(AttrName, 1, AttrRefine) of
						{AttrName, AttrValue} ->
							if 
								AttrValue < AddTop ->
									ok;
								?true ->
									{fail, ?PM_GUILD_CULTIVATE_LV_MAX}
							end;
						?false ->
							ok
					end;
				{fail, Reason} ->
					{fail, Reason}
			end;
		_ ->
			?ERROR_MSG("GoodsNo, AttrName : ~p~n", [{GoodsNo, AttrName}]),
			{fail, ?PM_DATA_CONFIG_ERROR}
	end.


do_partner_refine(PS, Partner, AttrName, GoodsNo, Count) ->
	PlayerId = player:get_id(PS),
	#partner_refine{add_range = {Min, Max}, add_top = AddTop} = data_partner_refine:get(GoodsNo, AttrName),
	GoodsList = [{GoodsNo, Count}],
	mod_inv:destroy_goods_WNC(PlayerId, GoodsList, [?LOG_PARTNER, "partner_refine"]),
	AddValue = util:rand(Min, Max) * Count,
	AttrRefine = lib_partner:get_attr_refine(Partner),
	AttrRefine3 = 
		case lists:keytake(AttrName, 1, AttrRefine) of
			{value, {AttrName, AttrValue}, AttrRefine2} ->
				AttrValue2 = erlang:min(AddTop, AttrValue + AddValue),
				[{AttrName, AttrValue2}|AttrRefine2];
			false ->
				AttrValue2 = erlang:min(AddTop, AddValue),
				[{AttrName, AttrValue2}|AttrRefine]
		end,
	CostRefine = lib_partner:get_cost_refine(Partner),
	CostRefine3 = 
		case lists:keytake(GoodsNo, 1, CostRefine) of
			{value, {GoodsNo, GoodsNum}, CostRefine2} ->
				[{GoodsNo, GoodsNum + Count}|CostRefine2];
			?false ->
				[{GoodsNo, Count}|CostRefine]
		end,
	Partner2 = lib_partner:set_cost_refine(Partner, CostRefine3),
	Partner3 = lib_partner:set_attr_refine(Partner2, AttrRefine3),
	Partner4 = lib_partner:recount_total_attrs(Partner3),
	Partner5 = lib_partner:recount_battle_power(Partner4),
	mod_partner:update_partner_to_ets(Partner5),
	mod_partner:db_save_partner(Partner5),
	{ok, Partner5}.



%% 宠物放生(2020.02.26 zjy)
%% @return : {ok, ReturnGoodsNoList} | {fail, Reason}
partner_free(PS, PartnerId, Type) ->
	case check_partner_free(PS, PartnerId) of
		ok ->
			Partner = lib_partner:get_partner(PartnerId),
			ReturnGoodsNoList = get_partner_free_return_goods(Partner),
			case Type of
				0 ->
					ok;
				1 ->
					do_partner_free(PS, Partner, ReturnGoodsNoList)
			end,
			{ok, ReturnGoodsNoList};
		{fail, Reason} ->
			{fail, Reason}
	end.


%% 检查是否可以放生宠物
%% @return : ok | {fail, Reason}
check_partner_free(PS, PartnerId) ->
	case mod_partner:get_main_partner_id(PS) of
		PartnerId ->
			{fail, ?PM_CANT_FREE_MAIN_PARTNER};
		_ ->
			case player:has_partner(PS, PartnerId) of
				false -> 
					{fail, ?PM_PAR_NOT_EXISTS};
				true ->
					case lib_partner:get_partner(PartnerId) of
						null -> 
							{fail, ?PM_PAR_NOT_EXISTS};
						Partner -> 
							case lib_partner:is_main_partner(Partner) orelse lib_partner:is_fighting(Partner) of
								true -> 
									{fail, ?PM_PAR_CANT_FREE_WHEN_IN_BATTLE};
								false ->
									IsEquippedArts = lib_train:get_isequipped_arts_by_role(),
									case lists:any(fun(Art) ->
														   Art#role_arts.partner_id == PartnerId
												   end, IsEquippedArts) of
										?true ->
											{fail, ?PM_ART_ISEQUIPED_PARTNER};
										?false ->
											PlayerId = player:id(PS),
											TEqList = mod_equip:get_partner_equip_list(PlayerId, PartnerId),
											ReturnGoods = get_partner_free_return_goods(Partner),
											CheckGoods = lists:foldl(fun(Goods, Acc) ->
																			 [{lib_goods:get_no(Goods), 1}|Acc]
																	 end, ReturnGoods, TEqList),
											case mod_inv:check_batch_add_goods(player:get_id(PS), CheckGoods) of
												{fail, Reason} ->
													{fail, Reason};
												ok -> 
													ok
											end
									end											
							end
					end
			end 
	end.

do_partner_free(PS, PartnerId) when is_integer(PartnerId) ->
	Partner = lib_partner:get_partner(PartnerId),
	do_partner_free(PS, Partner);

do_partner_free(PS, Partner) ->
	ReturnGoodsNoList = get_partner_free_return_goods(Partner),
	do_partner_free(PS, Partner, ReturnGoodsNoList).

do_partner_free(PS, Partner, ReturnGoodsNoList) ->
    PlayerId = player:id(PS),
	PartnerId = lib_partner:get_id(Partner),
	mod_partner:db_delete_partner(PlayerId, PartnerId),
	mod_partner:del_partner_from_ets(PartnerId),
	%% 删除离线竞技场宠物数据
	% lib_offline_arena:del_partner_offline_data(PartnerId, PS),
	lib_log:statis_role_action(PS, [], ?LOG_PARTNER, "release", [
																 PartnerId,
																 lib_partner:get_no(Partner),
																 lib_partner:get_name(Partner),
																 lib_partner:get_quality(Partner), 
																 lib_partner:get_lv(Partner), 
																 util:term_to_string(ReturnGoodsNoList)
																]),
	
	
	lib_log:partner_release(PartnerId, lib_partner:get_no(Partner), PS),
	[mod_equip:takeoff_equip(for_partner, PlayerId, PartnerId, EquipingGoods) || EquipingGoods <- mod_equip:get_partner_equip_list(PlayerId, PartnerId)],
	case lib_partner:get_mount_id(Partner) of
		?INVALID_ID -> skip;
		MountId -> lib_mount:concel_connect_partner(PS, MountId, PartnerId, 0)
	end,

	OldList = player:get_partner_id_list(PS),
	PS1 = player_syn:set_partner_id_list(PS, lists:delete(PartnerId, OldList)),
	
	%% 玩家宠物放生，需要重新玩家的战斗力
	ply_attr:recount_battle_power(PS1),
	
	{ok,RetGoods} = mod_inv:batch_smart_add_new_goods(player:get_id(PS1), ReturnGoodsNoList, [{bind_state, ?BIND_ALREADY}], [?LOG_PARTNER, "release"]),
	
	% 增加分解提示
	F1 = fun({Id, No, Cnt}) ->
				 case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
					 null -> skip;
					 Goods ->
						 ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt,Id]})
				 end
		 end,
	[F1(X) || X <- RetGoods],
	
	mod_achievement:notify_achi(free_partner, [], PS1),
	lib_event:event(free_partner, [], PS1),
	case player:get_follow_partner_id(PS1) of
		PartnerId ->
			handle_for_del_follow_partner(PS1);
		_ ->
			skip
	end,
	ok.


%% 获取放生宠物返还的材料道具
%% @return : [{GoodsNo, Count}]
get_partner_free_return_goods(Partner) ->
	PetFree1 = data_special_config:get('pet_free_1'),
	PetFree2 = data_special_config:get('pet_free_2'),
	PetFeedGoodsNo = data_special_config:get('pet_feed_goods_no'),
	ExpTotal = lib_partner:get_total_exp(Partner),
	CostEvolve = lib_partner:get_goods_cost_sum_evolve(Partner),
	CostCultivate = lib_partner:get_goods_cost_sum_cultivate(Partner),
	CostRefine = lib_partner:get_goods_cost_sum_refine(Partner),
	CostAwake = lib_partner:get_goods_cost_sum_awake(Partner),
	%% 1、2、3、4、5分别代表喂养、修炼、进化、觉醒、精炼
	{1, CoefExp} 		= lists:keyfind(1, 1, PetFree2),
	{2, CoefCultivate} 	= lists:keyfind(2, 1, PetFree2),
	{3, CoefEvolve} 	= lists:keyfind(3, 1, PetFree2),
	{4, CoefAwake} 		= lists:keyfind(4, 1, PetFree2),
	{5, CoefRefine} 	= lists:keyfind(5, 1, PetFree2),
	Fun = fun({GoodsNo, GoodsNum}, {Acc, RateCoef}) ->
				  GoodsNum2 = util:floor(GoodsNum * RateCoef),
				  case lists:keytake(GoodsNo, 1, Acc) of
					  {value, {GoodsNo, GoodsCount}, Acc2} ->
						  [{GoodsNo, GoodsCount +  + GoodsNum2}|Acc2];
					  ?false ->
						  {[{GoodsNo, GoodsNum2}|Acc], RateCoef}
				  end
		  end,
	GoodsTpl = lib_goods:get_tpl_data(PetFeedGoodsNo),
	EffectList = lib_goods:get_effects(GoodsTpl),
	#goods_eff{name = ?EN_ADD_EXP, para = Para} = lib_goods_eff:get_cfg_data(erlang:hd(EffectList)),
	ReturnFeedGoodsNum = util:floor(ExpTotal * CoefExp / Para),
	%% 养成材料返还
	ReturnFeed = [{PetFeedGoodsNo, ReturnFeedGoodsNum}],
	{ReturnEvolve, _} = lists:foldl(Fun, {[], CoefEvolve}, CostEvolve),
	{ReturnCultivate, _} = lists:foldl(Fun, {[], CoefCultivate}, CostCultivate),
	{ReturnAwake, _} = lists:foldl(Fun, {[], CoefAwake}, CostAwake),
	{ReturnRefine, _} = lists:foldl(Fun, {[], CoefRefine}, CostRefine),
	%% 基础返还
	#par_born_data{grade = Grade} = data_partner:get(lib_partner:get_no(Partner)),
	ReturnBase = 
		case lists:keyfind(Grade, 1, PetFree1) of
			{Grade, GoodsNo, GoodsNum} ->% 返还的基础物品
				[{GoodsNo, GoodsNum}];
			?false ->
				[]
		end,
	ReturnGoods = lists:append([ReturnFeed, ReturnEvolve, ReturnCultivate, ReturnAwake, ReturnRefine, ReturnBase]),
	ReturnGoods2 = 
		lists:foldl(fun({GoodsNo, GoodsNum}, Acc) ->
							case lists:keytake(GoodsNo, 1, Acc) of
								{value, {GoodsNo, GoodsCount}, Acc2} ->
									[{GoodsNo, GoodsCount + GoodsNum}|Acc2];
								?false ->
									[{GoodsNo, GoodsNum}|Acc]
							end
					end, [], ReturnGoods),
	lists:filter(fun({_, C}) ->
						 C > 0
				 end, ReturnGoods2).
