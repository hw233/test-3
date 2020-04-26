%%%------------------------------------
%%% @Module  : mod_skill
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2012.8.14
%%% @Description: 技能类（技能配置数据）
%%%------------------------------------

-module(mod_skill).

-export([
		get_cfg_data/1,
		is_valid_skill_id/1,
		is_newbie_skill/1,
		get_id/1,
		get_name_by_id/1,
		get_att_type/1,
		get_target_count_type/1,
		get_att_eff/1,
		get_pre_effs/1,
		get_in_effs/1,
		get_crit_effs/1,
		get_post_effs/1,
		get_passive_effs/1,
		get_use_condition_list/1,

		get_cost_hp_coef/1,
		get_cost_mp_coef/1,

		get_cost_hp/1,
		get_cost_mp/1,
		get_cost_anger/1,
		get_cost_gamemoney/1,
		base_on_which_when_cost_hp/1,

		get_cd_rounds/1,

		get_innate_dam/1,
		get_skill_scaling/1,
		get_attack_scaling/1,
		get_defend_scaling/1,
		get_att_times_scaling/1,
		get_std_dam_scaling/1,
		get_xinfa_related_coef/1,

		get_dam_to_mp_scaling/1,

		get_inverse_dam_proba/1,
		get_inverse_dam_coef/1,

		get_faction/1,
		get_owner_xinfa_id/1,
		get_min_target_count/1,
		get_target_count_constant/1,

		get_AI_list/1,

		get_ext_coef/1,
		get_ext_coef_lv/1,

		is_can_combo/1,
		is_initiative/1,
		is_passive/1,
		is_couple_skill/1,
		is_magic_key_skill/1,
		is_single_target_phy_att_skill/1,
		is_inborn_skill/1 					%% 判断是否是先天技能 主要是判断宠物技能

%         get_skill/1
%         ,chg_cell/3
%         ,get_eq_skill/1
%         ,get_eq_skill_list/1
%         ,get_passive_skill_list/1
%         ,clear_skill/2
%         ,get_partner_skill/1
%         ,db_load_player_skill_info/1
%         ,update_skill_lv/3
%         ,upgrade_partner_skill/1
%         ,make_new_skills/4
%         ,upgrade_skill/2
%         ,equip_skill/3
%         ,is_skillball_type/1
%         ,is_normal_skill/1
%         ,is_passive_skill/1
%         ,is_stunt_skill/1
%         ,is_awake_stunt_skill/1
%         ,is_pursue_skill/1
%         ,is_cooperate_skill/1
%         ,calc_player_skill_point/1
%         ,get_cur_lv/2
%         ,get_max_lv/1
% 		,calc_skill_point/1
% 		,calc_use_skill_point/1
% 		,add_partner_profi_by_gold/4
% 		,add_partner_profi/4
% 		,partner_skill_can_upgrade/3
% 		,learn_partner_skill_by_book/3
% 		,get_learn_book_partner/2
% 		,change_skillcast_seq/2
% 		,equip_partner_skill/3
% 		,change_partner_skill/3
% %% 		,get_skill_maxLv/1
% 		,get_skill_condition/2
% 		,is_skill_can_use_in_battle/1
% 		,get_skill_by_book/1
% 		,is_skill_point_leave/1
% 		,auto_learn_skill/1
% 		,extract_eq_skill_list/2
% 		,get_SkillList_by_recommend_skills/2
% 		,get_partner_manual_skill/1
% 		,get_partner_eq_skill/1
    ]).
% -include("common.hrl").
% -include("record.hrl").
% -include("player.hrl"). 
% -include("macro_skill.hrl").
-include("skill.hrl").
-include("debug.hrl").
% -include("common_log.hrl").

% %% ======================================================接口部分======================================



%% 获取技能配置数据
%% @return: null | skl_cfg结构体
get_cfg_data(SkillId) ->
	% case is_partner_skill(SkillId) of
	% 	true ->  % 宠物技能
	% 		case data_skill:get(SkillId) of
	% 			null ->
	% 				null;
	% 			SkillCfgData when is_record(SkillCfgData, skl_cfg) ->
	% 				SkillCfgData
	% 		end;
	% 	false -> % 其他技能
			case data_skill:get(SkillId) of
				null ->
					null;
				SkillCfgData when is_record(SkillCfgData, skl_cfg) ->
					SkillCfgData
			end.
	% end.

			




% %% 获取技能配置数据
% %% @return: null | skl_cfg结构体
% get_cfg_data(SkillId, SkillLv) ->
% 	case data_skill:get(SkillId, SkillLv) of
% 		null ->
% 			null;
% 		SkillCfgData when is_record(SkillCfgData, skl_cfg) ->
% 			SkillCfgData
% 	end.


is_valid_skill_id(SkillId) ->
	get_cfg_data(SkillId) /= null.


% is_partner_skill(SkillId) ->
% 	SkillId >= ?PARTNER_SKILL_START_ID.


is_newbie_skill(SkillId) when is_integer(SkillId) ->
	SkillId == ?NEWBIE_SKILL_ID;
is_newbie_skill(SklCfg) ->
	SklCfg#skl_cfg.id == ?NEWBIE_SKILL_ID.



get_id(SklCfg) ->
	SklCfg#skl_cfg.id.

get_name_by_id(Id) ->
	case get_cfg_data(Id) of
		null -> <<>>;
		SklCfg -> SklCfg#skl_cfg.name
	end.

get_att_type(SklCfg) ->
	SklCfg#skl_cfg.att_type.

get_target_count_type(SklCfg) ->
	SklCfg#skl_cfg.target_count_type.


get_att_eff(SklCfg) ->
	SklCfg#skl_cfg.att_eff.


get_pre_effs(SklCfg) ->
	SklCfg#skl_cfg.pre_effs.


get_in_effs(SklCfg) ->
	SklCfg#skl_cfg.in_effs.

get_crit_effs(SklCfg)->
	SklCfg#skl_cfg.crit_effs.


get_post_effs(SklCfg) ->
	SklCfg#skl_cfg.post_effs.

get_passive_effs(SklCfg) ->
	SklCfg#skl_cfg.passive_effs.

get_use_condition_list(SklCfg) ->
	SklCfg#skl_cfg.use_conditions.


get_cost_hp_coef(SklCfg) ->
	SklCfg#skl_cfg.cost_hp_coef.

get_cost_mp_coef(SklCfg) ->
	SklCfg#skl_cfg.cost_mp_coef.


get_cost_hp(SklCfg) ->
	SklCfg#skl_cfg.cost_hp.

get_cost_mp(SklCfg) ->
	SklCfg#skl_cfg.cost_mp.

get_cost_anger(SklCfg) ->
	SklCfg#skl_cfg.cost_anger.

get_cost_gamemoney(SklCfg) ->
	SklCfg#skl_cfg.cost_gamemoney.

base_on_which_when_cost_hp(SklCfg) ->
	SklCfg#skl_cfg.base_on_which_when_cost_hp.


get_cd_rounds(SklCfg) ->
	SklCfg#skl_cfg.cd_rounds.

get_innate_dam(SklCfg) ->
	SklCfg#skl_cfg.innate_dam.

get_skill_scaling(SklCfg) ->
	SklCfg#skl_cfg.skill_scaling.


% 
get_ext_coef(SklCfg) ->
	SklCfg#skl_cfg.ext_coef.

get_ext_coef_lv(SklCfg) ->
	SklCfg#skl_cfg.ext_coef_lv.
	

get_attack_scaling(SklCfg) ->
	SklCfg#skl_cfg.attack_scaling.

get_defend_scaling(SklCfg) ->
	SklCfg#skl_cfg.defend_scaling.

get_att_times_scaling(SklCfg) ->
	SklCfg#skl_cfg.att_times_scaling.

get_std_dam_scaling(SklCfg) ->
	SklCfg#skl_cfg.std_dam_scaling.

get_xinfa_related_coef(SklCfg) ->
	SklCfg#skl_cfg.xinfa_related_coef.


get_dam_to_mp_scaling(SklCfg) ->
	SklCfg#skl_cfg.dam_to_mp_scaling.



get_inverse_dam_proba(SklCfg) ->  % 概率是一个放大了1000倍的整数值
	SklCfg#skl_cfg.inverse_dam_proba.

get_inverse_dam_coef(SklCfg) ->
	SklCfg#skl_cfg.inverse_dam_coef.




get_faction(SklCfg) ->
	SklCfg#skl_cfg.faction.

get_owner_xinfa_id(SklCfg) ->
	SklCfg#skl_cfg.owner_xinfa_id.



get_min_target_count(SklCfg) ->
	SklCfg#skl_cfg.min_target_count.


get_target_count_constant(SklCfg) ->
	SklCfg#skl_cfg.target_count_constant.


get_AI_list(SklCfg) ->
	SklCfg#skl_cfg.ai_list.



%% 是否为主动技？
is_initiative(SklCfg) when is_record(SklCfg, skl_cfg) ->
	SklCfg#skl_cfg.type == ?SKL_T_INITIATIVE;

is_initiative(SklId) when is_integer(SklId) ->
	?ASSERT(is_valid_skill_id(SklId), SklId),
	SklCfg = get_cfg_data(SklId),
	SklCfg#skl_cfg.type == ?SKL_T_INITIATIVE.

is_can_combo(SklCfg) when is_record(SklCfg, skl_cfg) ->
	SklCfg#skl_cfg.can_combo == 1;

is_can_combo(SklId) when is_integer(SklId) ->
	SklCfg = get_cfg_data(SklId),
	SklCfg#skl_cfg.can_combo == 1.



%% 是否为被动技？
is_passive(SklCfg) when is_record(SklCfg, skl_cfg) ->
	% ?DEBUG_MSG("SklCfg#skl_cfg.passive_effs=~p,id=~p",[SklCfg#skl_cfg.passive_effs,SklCfg#skl_cfg.id]),
	length(SklCfg#skl_cfg.passive_effs) > 0 orelse SklCfg#skl_cfg.type == ?SKL_T_PASSIVE;

is_passive(SklId) when is_integer(SklId) ->
	?ASSERT(is_valid_skill_id(SklId), SklId),
	SklCfg = get_cfg_data(SklId),
	length(SklCfg#skl_cfg.passive_effs) > 0 orelse SklCfg#skl_cfg.type == ?SKL_T_PASSIVE.


%% 是否夫妻技能？
is_couple_skill(SklCfg) when is_record(SklCfg, skl_cfg) ->
	SklCfg#skl_cfg.sub_type == ?SKL_SUB_T_COUPLE;

is_couple_skill(SklId) when is_integer(SklId) ->
	?ASSERT(is_valid_skill_id(SklId), SklId),
	SklCfg = get_cfg_data(SklId),
	SklCfg#skl_cfg.sub_type == ?SKL_SUB_T_COUPLE.


%% 是否法宝技能？
is_magic_key_skill(SklCfg) when is_record(SklCfg, skl_cfg) ->
	SklCfg#skl_cfg.sub_type == ?SKL_SUB_T_TALISMAN;

is_magic_key_skill(SklId) when is_integer(SklId) ->
	?ASSERT(is_valid_skill_id(SklId), SklId),
	SklCfg = get_cfg_data(SklId),
	is_magic_key_skill(SklCfg).

%% 是否单体物理攻击技能？
is_single_target_phy_att_skill(SklCfg) ->
	SklCfg#skl_cfg.att_type == ?ATT_T_PHY
	andalso SklCfg#skl_cfg.target_count_type == ?TARGET_COUNT_SINGLE.




%% 宠物技能
-define(SKL_INBORN, 1).      % （宠物）先天技能
-define(SKL_POSTNATAL, 0).   % （宠物）后天技能

is_inborn_skill(SklCfg) ->
	SklCfg#skl_cfg.is_inborn =:= ?SKL_INBORN.
	 

% %%自动学习第一个技能
% auto_learn_skill(Status) when Status#player_status.lv == ?AUTO_LEARN_LV_1 ->
% 	case Status#player_status.career of
% 		?CAREER_TR -> learn_equip_skill(Status, 11001, 1);
% 		?CAREER_CHK -> learn_equip_skill(Status, 12001, 1);
% 		?CAREER_FL -> learn_equip_skill(Status, 13001, 1);
% 		?CAREER_SHL -> learn_equip_skill(Status, 14001, 1);
% 		_ -> Status
% 	end;
% auto_learn_skill(Status) when Status#player_status.lv == ?AUTO_LEARN_LV_2 ->
% 	case Status#player_status.career of
% 		?CAREER_TR -> learn_equip_skill(Status, 11019, 2);
% 		?CAREER_CHK -> learn_equip_skill(Status, 12019, 2);
% 		?CAREER_FL -> learn_equip_skill(Status, 13005, 2);
% 		?CAREER_SHL -> learn_equip_skill(Status, 14003, 2);
% 		_ -> Status
% 	end;
% auto_learn_skill(Status) ->
% 	Status.


% %% 判断技能是否可以在战斗中直接使用
% is_skill_can_use_in_battle(SkillId) when is_integer(SkillId) ->
% 	case data_skill:get(SkillId, 1) of
% 		[] ->
% 			?ASSERT(false, SkillId),
% 			false;
% 		SkillData ->
% 			is_skill_can_use_in_battle(SkillData)
% 	end;
% is_skill_can_use_in_battle(SkillData) ->
% 	SkillData#ets_skill.type == ?SKL_T_COMM
% 	orelse SkillData#ets_skill.type == ?SKL_T_STUNT
% 	orelse SkillData#ets_skill.type == ?SKL_T_COOPERATE
% 	orelse SkillData#ets_skill.type == ?SKL_T_PURSUE
% 	orelse SkillData#ets_skill.type == ?SKL_T_AWAKE_STUNT.
                   



% %% 取得技能列表
% %% @spec(人物状态) -> false|{true, SkillPoint, SkillList}
% %% SkillList:{id, cur_lv, max_lv, can_study, is_eq}
% get_skill(Status) ->
% 	Skill = Status#player_status.skill,
% 	EqSkill = Status#player_status.eq_skill,
%     Skills = data_skill:get_skill_ids(Status#player_status.career),
%     ?ASSERT(Skills =/= []),
%     SkillPoint = Status#player_status.skill_point,
%     F = fun(Id) ->
%             CurLv = get_cur_lv(Id, Skill),
%             MaxLv = get_max_lv(Id),
%             CanStudy = is_can_study(Status, Id),
%             IsEquit = is_equip(Id, EqSkill),
%             {Id, CurLv, MaxLv, util:bool_to_int(CanStudy), util:bool_to_int(IsEquit)}
%     end,
%     SkillsInfo = lists:map(F, Skills),
%     {true, SkillPoint, SkillsInfo}.

% %% 学习/升级技能
% %%  {true, NewStatus}|{false, ErrCode}
% %% 技能学习/升级,Skillid表示要升级的技能id
% upgrade_skill(Status,SkillId) ->
%     case check_upgrade(Status, SkillId) of
%         {false, Code} ->
%             {false, Code};
%         {true, Status1, Coin, Soul, Book, SkillInfo} ->
%             Status2 =	lib_player:update_task_state0({skill,SkillInfo#ets_skill.id}, Status1),
%             lib_task:event(learn_skill, SkillId, Status2),
% 			lib_achievement:do(skill, SkillId,1,Status2),
%             {ok, Status3} = upgrade(Status2, SkillInfo, Coin, Soul, Book),
%             lib_player:refresh_client(Status3#player_status.id, ?REFRESH_BAG),
%             {true, Status3}
%     end.

% %% 装备技能函数
% %% {false, ErrCode}|{true, NewStatus} 
% equip_skill(PlayerStatus, SkillId, Equip) ->
%     case check_equip_skill(SkillId, Equip, PlayerStatus#player_status.skill) of
%         {fail, Res} ->
%             {false, Res};
%         {ok, Result} when Equip =/= 0 ->
%             {SkillId, _SkillLv, OldEquip} = Result,
%             Skills = PlayerStatus#player_status.skill,
%             F = fun({Id, Lv, Eq}) ->
%                 if 
%                     SkillId =:= Id andalso Eq =:= Equip ->
%                         {Id, Lv, Eq};
%                     SkillId =:= Id ->
%                         {Id, Lv, Equip};
%                     Eq =:= Equip ->
%                         change_skill_status(PlayerStatus#player_status.id, Id, OldEquip),   % 更新数据库
%                         {Id, Lv, OldEquip};
%                     true ->
%                         {Id, Lv, Eq}
%                 end
%             end,    
%             NewSkills = lists:map(F, Skills),
%             EqList = get_eq_skill(NewSkills),
%             NewPlayerStatus = PlayerStatus#player_status{eq_skill = EqList, skill = NewSkills},
%             change_skill_status(PlayerStatus#player_status.id, SkillId, Equip),
%             {true, NewPlayerStatus};
%         {ok, Result} when Equip =:= 0 ->
%             {SkillId1, _SkillLv, _Equip} = Result,
%             List = lists:keyreplace(SkillId, 1, PlayerStatus#player_status.skill, {SkillId, _SkillLv, 0}),
%             EqList = get_eq_skill(List),
%             NewPlayerStatus = PlayerStatus#player_status{eq_skill = EqList, skill = List},
%             change_skill_status(PlayerStatus#player_status.id, SkillId1, Equip),
%             {true, NewPlayerStatus}
%       end.

% %% 互换格子技能
% %% @spec() -> {false, ErrCode}|{true, NewStatus}
% chg_cell(Status, Cell1, Cell2) ->
% 	Skill = Status#player_status.skill,
%     {Id1, Lv1, _Eq1} = get_cell_skill_id(Cell1, Skill),
%     {Id2, Lv2, _Eq2} = get_cell_skill_id(Cell2, Skill),
%     Skill1 = replace_skill(Status#player_status.id, {Id1,Lv1, Cell2}, Skill),
%     Skill2 = replace_skill(Status#player_status.id, {Id2,Lv2, Cell1}, Skill1),
%     {true, Status#player_status{skill = Skill2, eq_skill = get_eq_skill(Skill2)}}.

% %% 取得已装备的列表
% %% @spec-> {false, _ErrCode}|{true, Eqskill}
% get_eq_skill_list(Status) ->
% 	EqSkill = Status#player_status.eq_skill,
%     List = [{Id, Eq}||{Id, _Lv, Eq} <- EqSkill], 
%     {true, List}.
    
% %% 获取被动技列表
% %% @spec-> [] | [{Id, Lv}, ...]
% get_passive_skill_list(Status) ->
%     AllSkillList = Status#player_status.skill,
%     [{Id, Lv} || {Id, Lv, _Grid} <- AllSkillList, is_passive_skill(Id)].

% %% 洗点
% %%  {true, NewStatus}|{false, ErrCode}
% clear_skill(Status, Type) ->
%     case Status#player_status.lv > ?CLEAR_SKILL_FREE_LV of
%         true -> %% 大于25级要用元宝洗点
% 			Flag = if Type == 1 -> 
% 						  lib_money:has_enough_money(Status, ?CLEAR_SKILL_NEED_GOLD, gold);
% 					  true -> 
% 						  Ztb = lib_money:rmb_to_zt_money(?CLEAR_SKILL_NEED_GOLD),
% 						  lib_money:has_enough_money(Status, Ztb, bcoin)
% 				   end,
%             case Flag of
%                 false -> {false, 2};
%                 true -> do_clear_skill(Status, ?CLEAR_SKILL_NEED_GOLD, Type)
%             end;
%         false ->
%             do_clear_skill(Status, 0, Type)
%     end.
    
    
    

% %% 从数据库加载玩家的技能信息
% %% @spec() -> [Skill, EqSkill]
% db_load_player_skill_info(Id) ->
%     case db:select_all(skill, "skill_id, lv, equip", [{id,Id}]) of
%         [] ->
%             [[], []];
%         Data ->
%             List1 = [list_to_tuple(D) || D <- Data],  % 已学的技能列表
%             List2 = extract_eq_skill_list(player, List1),     % 已装备的技能列表
%             [List1, List2]
%     end.
    

% %% 从玩家的已学技能列表提取出已装备的技能列表    
% extract_eq_skill_list(player, SrcSkillList) ->
% 	[{SkillId, SkillLv, Grid} || {SkillId, SkillLv, Grid} <- SrcSkillList, Grid > 0];
% %% 从武将的已学技能列表提取出已装备的技能列表   
% extract_eq_skill_list(partner, SrcSkillList) ->
% 	[{SkillId, SkillLv, Grid, Profi} || {SkillId, SkillLv, Grid, Profi} <- SrcSkillList, Grid > 0].
	
    

% %%是否有技能点剩余
% is_skill_point_leave(Status) -> 
% 	case Status#player_status.lv >= 14 of
% 		true ->
% 			Flag = case Status#player_status.skill_point > 0 of
% 			   		true -> 1;
% 			   		_ -> 0
% 		   		end,
% 			?TRACE("is_skill_point_leave = ~p~n", [Flag]),
% 			{ok, BinData} = pt_21:write(21010, [Flag]),
% 			lib_send:send_one(Status#player_status.socket, BinData);
% 		false ->
% 			skip
% 	end.

% %%%%%%%%%%%%%%%%%%%%%%%%武将技能%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%提升熟练度
% %%@retrun: 1=>成功, 2=>失败
% add_partner_profi_by_gold(Status, PartnerId, SkillId, Type) ->
% 	IntType = tool:to_integer(Type),
% 	case IntType of
% 		1 ->
% 			if
% 				Status#player_status.gold >= ?PROFI_TYPE_1 * ?PROFI_GOLD ->
% 					case add_partner_profi(Status, PartnerId, SkillId, ?PROFI_TYPE_1) of
% 						1 ->
% 							NewStatus = cost_money(Status, ?PROFI_TYPE_1 * ?PROFI_GOLD, 0),
% 							{1, NewStatus};
% 						_ ->
% 							{2, Status}
% 					end;
% 				true ->
% 					{2, Status}
% 			end;
% 		2 ->
% 			case lib_partner:get_alive_partner(PartnerId) of
% 				null ->
% 					{2, Status};
% 				Partner ->
% 			SkillList = Partner#ets_partner.skills,
% 			case lists:keyfind(SkillId, 1, SkillList) of
% 				false ->
% 					{2, Status};
% 				{_Id, SkillLv, _Grid, CurProfi} ->
% 					{_, MaxProfi} = get_skill_condition(SkillId, SkillLv),
% 					AddProfi = MaxProfi - CurProfi,
% 					if
% 						Status#player_status.gold >= AddProfi * ?PROFI_GOLD ->
% 							case add_partner_profi(Status, PartnerId, SkillId, AddProfi) of
% 								1 ->
% 									NewStatus = cost_money(Status, AddProfi * ?PROFI_GOLD, 0),
% 									{1, NewStatus};
% 								_ ->
% 									{2, Status}
% 							end;
% 						true ->
% 							{2, Status}
% 					end
% 			end
% 			end
% 	end.
				

% %%提升熟练度
% %%@retrun: 1=>成功, 2=>失败
% add_partner_profi(Status, PartnerId, SkillId, AddProfi) ->
% 	case lib_partner:get_alive_partner(PartnerId) of
% 		null ->
% 			2;
% 		Partner ->
% 			SkillList = Partner#ets_partner.skills,
% 			case lists:keyfind(SkillId, 1, SkillList) of
% 				false ->
% 					2;
% 				{_Id, SkillLv, Grid, Profi} -> 
% 					NewProfi = Profi + AddProfi,
% 					{NeedPartnerLv, NeedProfi} = get_skill_condition(SkillId, SkillLv + 1),
% 					if
% 						NewProfi >= NeedProfi andalso Partner#ets_partner.lv >= NeedPartnerLv ->
% 							MaxSkillLv = get_max_lv(SkillId),
% 							%%符合升级条件
% 							case MaxSkillLv > SkillLv of
% 								false ->
% 									skip;
% 								_ ->
% 									partner_upgrade_skill(PartnerId, SkillId),
% 									{ok, BinData} = pt_21:write(21101, [PartnerId, SkillId, (SkillLv + 1)]),
% 								    lib_send:send_one(Status#player_status.socket,BinData)
% 							end;
% 						true ->
% 							NewProfi1 = 
% 								if
% 									NewProfi >= NeedProfi ->
% 										NeedProfi;
% 									true ->
% 										NewProfi
% 								end,
% 							NewSkillList = lists:keyreplace(SkillId, 1, SkillList, 
% 															{SkillId, SkillLv, Grid, NewProfi1}),
% 							NewEqSkillList = get_partner_eq_skill(NewSkillList),
% 							NewPartner = Partner#ets_partner{skills = NewSkillList, 
% 															 eq_skills = NewEqSkillList},
% 							ets:insert(?ETS_PARTNER_ALIVE, NewPartner),
% 							DbSkill = case util:term_to_bitstring(NewSkillList) of
% 										  <<"undefined">> -> <<>>;
% 										  SkAny -> SkAny
% 									  end,
% 							DbEqSkill = case util:term_to_bitstring(NewEqSkillList) of
% 											<<"undefined">> -> <<>>;
% 											EqAny -> EqAny
% 										end,
% 							%%保存DB  redo:统一保存?
% 							if
% 								AddProfi == 1 ->
% 									lib_common:actin_new_proc(db, update, [partner, 
% 											  ["skills", "eq_skills"], [DbSkill, DbEqSkill], 
% 											  "id", PartnerId]);
% 								true ->
% 									db:update(partner, 
% 											  ["skills", "eq_skills"], [DbSkill, DbEqSkill], 
% 											  "id", PartnerId)
% 							end
% 					end,
% 					1
% 			end
% 	end.

% %%武将升级时判断是否能升级技能
% partner_skill_can_upgrade(Status, Partner, Lv) ->
% 	?TRACE("partner lv up\n"),
% 	SkillList = Partner#ets_partner.skills,
% %% 	Exp = Partner#ets_partner.exp,
% 	F = fun({SkillId, SkillLv, _Cell, Profi}, PartnerTmp) ->
% 				MaxLv = get_max_lv(SkillId),
% 				if
% 					MaxLv =< SkillLv ->
% 						PartnerTmp;
% 					true ->
% 						{NeedPartnerLv, NeedProfi} = 
% 							get_skill_condition(SkillId, SkillLv + 1),
% 						?TRACE("Lds\n SkillId = ~p, SkillLv = ~p, NeedProfi = ~p, NeedPartnerLv = ~p~n", 
% 							   [SkillId, SkillLv, NeedProfi, NeedPartnerLv]),
% 						if
% 							Profi >= NeedProfi andalso Lv >= NeedPartnerLv ->
% 								?TRACE("Partner can lv up\n"),
% 								NewPartnerTmp = partner_auto_upgrade_skill(PartnerTmp, SkillId),
% 								{ok, BinData} = pt_21:write(21101, [NewPartnerTmp#ets_partner.id, SkillId, (SkillLv + 1)]),
% 								lib_send:send_one(Status#player_status.socket,BinData),
% 								NewPartnerTmp;
% 							true ->
% 								PartnerTmp
% 						end
% 				end
% 		end,
% %% 	lists:foreach(F, SkillList),
% 	lists:foldl(F, Partner, SkillList).
% %% 	?TRACE("partner skill upgrade = ~p~n", [ets:lookup(?ETS_PARTNER_ALIVE, Partner#ets_partner.id)]),
% %% 	[Rd] = ets:lookup(?ETS_PARTNER_ALIVE, Partner#ets_partner.id),
% %% 	Rd#ets_partner{exp = Exp, lv = Lv}.
	
	

% %%武将通过书本学习技能
% %%@retrun: 1=>成功  2=>失败 3=>已学该技能
% learn_partner_skill_by_book(Status, BookId, PartnerId) ->
% 	%根据技能书取得该书习得的技能
% 	SkillId = get_skill_by_book(BookId),
% 	?TRACE("learn_partner_skill_by_book  SkillId=~p~n", [SkillId]),
% 	%根据技能ID取得其学习/升级条件
% 	{Lv, _Profi} = get_skill_condition(SkillId, 1),
% 	{Career, Type, Color} = get_learn_skill_condition(BookId),
% 	?TRACE("need LV=~p, Career=~p, Type=~p~n", [Lv, Career, Type]),
% 	%% 	Partner = lib_partner:get_alive_partner(PartnerId),
% 	case lib_partner:get_alive_partner(PartnerId) of
% 		null -> 2;
% 		Partner ->
% 	PartnerIdList = Status#player_status.par_alive,
% 	PartnerList = get_partner_list(PartnerIdList, [Lv, Career, Type, Color], []),
% 	case lists:member(Partner, PartnerList) of
% 		true ->
% 			SkillList = Partner#ets_partner.skills,
% 			case lists:keyfind(SkillId, 1, SkillList) of
% 				false -> 
% 					%%符合条件,学习该技能
% 					partner_upgrade_skill(PartnerId, SkillId),
% 					case Partner#ets_partner.cast_seq of
% 						0 -> skip;
% 						Seq -> change_skillcast_seq(PartnerId, Seq)
% 					end,
% 					1;
% 				_ -> 3
% 			end;
% 		_ ->
% 			2
% 	end
% 	end.

% %%武将学习/升级技能
% partner_upgrade_skill(PartnerId, SkillId) ->
% 	case lib_partner:get_alive_partner(PartnerId) of
% 		null ->
% 			skip;
% 		Partner ->
% 			SkillList = Partner#ets_partner.skills,
% 			NewSkillList = case lists:keyfind(SkillId, 1, SkillList) of
% 				false ->
% 					%%学习技能
% 					NewSkill = {SkillId, 1, 0, 0},
% 					SkillList ++ [NewSkill];
% 				{Id, Lv, Grid, _Profi} ->
% 					%%升级技能
% 					NewLv = Lv + 1,
% 					%%判断技能是否达到最高级
% %% 					{PartnerLv, _Profi} = get_skill_condition(Id, NewLv),
% 					MaxSkillLv = get_max_lv(SkillId),
% 					case MaxSkillLv > Lv of
% 						false ->  %没有该等级技能
% 							SkillList;
% 						_ ->
% 							lists:keyreplace(Id, 1, SkillList, {Id, NewLv, Grid, 0})
% 					end
% 			end,
% 			NewEqSkillList = get_partner_eq_skill(NewSkillList),
% 			NewPartner = Partner#ets_partner{skills = NewSkillList, eq_skills = NewEqSkillList},
% 			ets:insert(?ETS_PARTNER_ALIVE, NewPartner),
% 			%%保存DB
% 			DbSkill = case util:term_to_bitstring(NewSkillList) of
% 					   <<"undefined">> -> <<>>;
% 					   SkAny -> SkAny
% 					  end,
% 			DbEqSkill = case util:term_to_bitstring(NewEqSkillList) of
% 					   <<"undefined">> -> <<>>;
% 					   EqAny -> EqAny
% 					  end,
% 			db:update(partner, ["skills", "eq_skills"], 
% 					  [DbSkill, DbEqSkill], "id", PartnerId)
% 	end.

% %%武将学习/升级技能
% %%@return: NewPartner
% partner_auto_upgrade_skill(Partner, SkillId) ->
% 	SkillList = Partner#ets_partner.skills,
% 	NewSkillList = case lists:keyfind(SkillId, 1, SkillList) of
% 				false ->
% 					SkillList;
% 				{Id, Lv, Grid, _Profi} ->
% 					%%升级技能
% 					NewLv = Lv + 1,
% 					%%判断技能是否达到最高级
% %% 					{PartnerLv, _Profi} = get_skill_condition(Id, NewLv),
% 					MaxSkillLv = get_max_lv(SkillId),
% 					case MaxSkillLv > Lv of
% 						false ->  %没有该等级技能
% 							SkillList;
% 						_ ->
% 							lists:keyreplace(Id, 1, SkillList, {Id, NewLv, Grid, 0})
% 					end
% 			end,
% 	NewEqSkillList = get_partner_eq_skill(NewSkillList),
% 	Partner#ets_partner{skills = NewSkillList, eq_skills = NewEqSkillList}.

	

% %%取得能习得该技能书的武将列表
% %%@return: [Partner1,Partner2..]
% get_learn_book_partner(Status, BookId) ->
% 	%根据技能书取得该书习得的技能
% 	SkillId = get_skill_by_book(BookId),
% 	%根据技能ID取得其学习/升级条件
% 	{Lv, _Profi} = get_skill_condition(SkillId, 1),
% 	{Career, Type, Color} = get_learn_skill_condition(BookId),
% 	PartnerIdList = Status#player_status.par_alive,
% 	get_partner_list(PartnerIdList, [Lv, Career, Type, Color], []).

% %%根据条件取得武将列表
% get_partner_list([], [_Lv, _Career, _Type, _Color], PartnerList) ->
% 	PartnerList;
% get_partner_list(PartnerIdList, [Lv, Career, Type, Color], PartnerList) ->
% 	[PartnerId | LeftId] = PartnerIdList,
% 	case lib_partner:get_partner(PartnerId) of
% 		null ->
% 			get_partner_list(LeftId, [Lv, Career, Type, Color], PartnerList);
% 		Partner ->
% 			ColFlag = lists:member(0, Color) orelse lists:member(Partner#ets_partner.quality, Color),
% 			if
% 				Partner#ets_partner.lv >= Lv 
% 				  andalso Partner#ets_partner.career == Career
% 				  andalso ColFlag
% 				  andalso (Type == 0 orelse Type == Partner#ets_partner.par_type_id) ->
% 					get_partner_list(LeftId, [Lv, Career, Type, Color], PartnerList ++ [Partner]);
% 				true ->
% 					get_partner_list(LeftId, [Lv, Career, Type, Color], PartnerList)
% 			end
% 	end.

% %%取得武将装备技能
% get_partner_eq_skill(Skills) ->
%     [{SkillId, SkillLv, Equip, Profi} || {SkillId, SkillLv, Equip, Profi} <- Skills, Equip > 0].

% %%取得手动装备列表
% get_partner_manual_skill(Skills) ->
% 	[{SkillId, Equip} || {SkillId, _SkillLv, Equip, _Profi} <- Skills, Equip > 0].

% %%通过手动装备列表更新技能列表
% get_partner_skill_by_manual_skill(Skills, ManualSkills) ->
% 	F = fun({SkillId, SkillLv, _Equip, Profi}) ->
% 				case lists:keyfind(SkillId, 1, ManualSkills) of
% 					{_ManSkillId, ManEquip} -> {SkillId, SkillLv, ManEquip, Profi};
% 					_ -> {SkillId, SkillLv, 0, Profi}
% 				end
% 		end,
% 	[F(X) || X <- Skills, X =/= []].

% %% get_skill_maxLv(SkillId) ->
% %% 	get_skill_maxLv(SkillId, 1).
% %% get_skill_maxLv(SkillId, SkillLv) ->
% %% 	{PartnerLv, _} = get_skill_condition(SkillId, SkillLv),
% %% 	case PartnerLv of
% %% 		0 ->
% %% 			SkillLv - 1;
% %% 		_ ->
% %% 			get_skill_maxLv(SkillId, SkillLv + 1)
% %% 	end.

% %%更改技能释放顺序
% %%@retrun: 1=>成功 2=>失败
% change_skillcast_seq(PartnerId, Seq) -> 
% 	case lib_partner:get_alive_partner(PartnerId) of
% 		null ->
% 			2;
% 		Partner ->
% 			if Partner#ets_partner.cast_seq == Seq -> 1;
% 			   true ->
% 			%%取得并把所有已学武将技能并重置所有已装备技能
			
% 			NewSkillList = 
% 				case Seq of
% 					0 -> get_partner_skill_by_manual_skill(Partner#ets_partner.skills, Partner#ets_partner.manual_skills);
% 					_ ->
% %% 						SkillList = [{SId, SLv, 0, Profi} || {SId, SLv, _Equip, Profi} <- Partner#ets_partner.skills],
% %% 						RecomIds = lib_hang:get_recommend_skl_comb_set(partner, 
% %% 																	   Partner#ets_partner.par_type_id,
% %% 																	   Partner#ets_partner.career),
% 						RecomIds = data_am_skill:get_recommend_comb_set(partner, 
% 																		Partner#ets_partner.par_type_id,
% 																		Partner#ets_partner.career),
% 						?TRACE("RecomIds = ~p~n", [RecomIds]),
% 						get_SkillList_by_recommend_skills(Partner#ets_partner.skills, RecomIds)
% %% 						F = fun(SkillId, {Clist, Index}) -> 
% %% 									case lists:keyfind(SkillId, 1, Clist) of
% %% 										false -> {Clist, Index};
% %% 										{CId, CLv, _CGrid, CPr} -> 
% %% 											Nlist = lists:keyreplace(CId, 1, Clist, {CId, CLv, Index, CPr}),
% %% 											{Nlist, Index + 1}
% %% 									end
% %% 							end,
% %% 						{NewList, _} = lists:foldl(F, {SkillList, 1}, RecomIds),
% %% 						NewList
% 				end,
% 			NewEqList = get_partner_eq_skill(NewSkillList),
% 			NewPartner = Partner#ets_partner{cast_seq = Seq, skills = NewSkillList, eq_skills = NewEqList},
% 			ets:insert(?ETS_PARTNER_ALIVE, NewPartner),
% 			DbSkill = case util:term_to_bitstring(NewSkillList) of
% 					   <<"undefined">> -> <<>>;
% 					   SkAny -> SkAny
% 					  end,
% 			DbEqSkill = case util:term_to_bitstring(NewEqList) of
% 					   <<"undefined">> -> <<>>;
% 					   EqAny -> EqAny
% 					  end,
% 			db:update(partner, ["cast_seq", "skills", "eq_skills"], [Seq, DbSkill, DbEqSkill], 
% 					  "id", Partner#ets_partner.id),
% 			1
% 			end
% 	end.

% get_SkillList_by_recommend_skills(Skills, RecomIds) ->
% 	SkillList = [{SId, SLv, 0, Profi} || {SId, SLv, _Equip, Profi} <- Skills],
% 	F = fun(SkillId, {Clist, Index}) -> 
% 				case lists:keyfind(SkillId, 1, Clist) of
% 					false -> {Clist, Index};
% 					{CId, CLv, _CGrid, CPr} -> 
% 						Nlist = lists:keyreplace(CId, 1, Clist, {CId, CLv, Index, CPr}),
% 						{Nlist, Index + 1}
% 				end
% 		end,
% 	{NewList, _} = lists:foldl(F, {SkillList, 1}, RecomIds),
% 	NewList.
	

% %% 装备武将技能函数
% %% Flag
% equip_partner_skill(PartnerId, SkillId, Equip) ->
% 	case lib_partner:get_alive_partner(PartnerId) of
% 		null ->
% 			0;
% 		Partner ->
%     case check_partner_equip_skill(SkillId, Equip, Partner#ets_partner.skills) of
%         {fail, Res} ->
% 			?TRACE("check equip error=~p~n", [Res]),
%             Res;
%         {ok, Result} when Equip =/= 0 ->
% 			?TRACE("CLOSE \n"),
%             {SkillId, _SkillLv, OldEquip, _} = Result,
%             Skills = Partner#ets_partner.skills,
%             F = fun({Id, Lv, Eq, Profi}) ->
%                 if 
%                     SkillId =:= Id andalso Eq =:= Equip ->
%                         {Id, Lv, Eq, Profi};
%                     SkillId =:= Id ->
%                         {Id, Lv, Equip, Profi};
%                     Eq =:= Equip ->
%                         {Id, Lv, OldEquip, Profi};
%                     true ->
%                         {Id, Lv, Eq, Profi}
%                 end
%             end,    
%             NewSkills = lists:map(F, Skills),
%             EqList = get_partner_eq_skill(NewSkills),
% 			ManualList = get_partner_manual_skill(NewSkills),
% %%             NewPlayerStatus = PlayerStatus#player_status{eq_skill = EqList, skill = NewSkills},
% 			NewPartner = Partner#ets_partner{skills = NewSkills, eq_skills = EqList, manual_skills = ManualList},
% 			ets:insert(?ETS_PARTNER_ALIVE, NewPartner),
%             %%保存装备技能信息
% 			DbSkill = case util:term_to_bitstring(NewSkills) of
% 					   <<"undefined">> -> <<>>;
% 					   SkAny -> SkAny
% 					  end,
% 			DbEqSkill = case util:term_to_bitstring(EqList) of
% 					   <<"undefined">> -> <<>>;
% 					   EqAny -> EqAny
% 					  end,
% 			DbManSkill = case util:term_to_bitstring(ManualList) of
% 							 <<"undefined">> -> <<>>;
% 							 ManAny -> ManAny
% 						 end,
% 			db:update(partner, ["skills", "eq_skills", "manual_skills"], [DbSkill, DbEqSkill, DbManSkill], 
% 					  "id", PartnerId),
% 			1;
%         {ok, Result} when Equip =:= 0 ->
% 			?TRACE("take off \n"),
%             {SkillId1, _SkillLv, _Equip, Profi} = Result,
%             List = lists:keyreplace(SkillId, 1, Partner#ets_partner.skills, {SkillId1, _SkillLv, 0, Profi}),
%             EqList = get_partner_eq_skill(List),
% 			ManualList = get_partner_manual_skill(List),
% %%             NewPlayerStatus = PlayerStatus#player_status{eq_skill = EqList, skill = List},
% %%             change_skill_status(PlayerStatus#player_status.id, SkillId1, Equip),
% 			NewPartner = Partner#ets_partner{skills = List, eq_skills = EqList, manual_skills = ManualList},
% 			ets:insert(?ETS_PARTNER_ALIVE, NewPartner),
% 			%%保存装备技能信息
% 			DbSkill = case util:term_to_bitstring(List) of
% 					   <<"undefined">> -> <<>>;
% 					   SkAny -> SkAny
% 					  end,
% 			DbEqSkill = case util:term_to_bitstring(EqList) of
% 					   <<"undefined">> -> <<>>;
% 					   EqAny -> EqAny
% 					  end,
% 			DbManSkill = case util:term_to_bitstring(ManualList) of
% 							 <<"undefined">> -> <<>>;
% 							 ManAny -> ManAny
% 						 end,
% 			db:update(partner, ["skills", "eq_skills", "manual_skills"], [DbSkill, DbEqSkill, DbManSkill], 
% 					  "id", PartnerId),
% 			1
%       end
% 	end.

% %%武将技能交换
% change_partner_skill(PartnerId, Cell1, Cell2) ->
% 	case lib_partner:get_alive_partner(PartnerId) of
% 		null ->
% 			0;
% 		Partner ->
% 			SkillList = Partner#ets_partner.skills,
% %% 			EqSkillList = Partner#ets_partner.eq_skills,
% 			{SkillId1, Lv1, _, Profi1} = get_partner_cell_skill_id(Cell1, SkillList),
% 			{SkillId2, Lv2, _, Profi2} = get_partner_cell_skill_id(Cell2, SkillList),
% 			SkillList1 = replace_partner_skill({SkillId1, Lv1, Cell2, Profi1}, SkillList),
% 			NewSkillList = replace_partner_skill({SkillId2, Lv2, Cell1, Profi2}, SkillList1),
% 			NewEqSkillList = get_partner_eq_skill(NewSkillList),
% 			ManualList = get_partner_manual_skill(NewSkillList),
% 			NewPartner = Partner#ets_partner{skills = NewSkillList, eq_skills = NewEqSkillList, manual_skills = ManualList},
% 			ets:insert(?ETS_PARTNER_ALIVE, NewPartner),
% 			%%保存装备技能信息
% 			DbSkill = case util:term_to_bitstring(NewSkillList) of
% 					   <<"undefined">> -> <<>>;
% 					   SkAny -> SkAny
% 					  end,
% 			DbEqSkill = case util:term_to_bitstring(NewEqSkillList) of
% 					   <<"undefined">> -> <<>>;
% 					   EqAny -> EqAny
% 					  end,
% 			DbManSkill = case util:term_to_bitstring(ManualList) of
% 							 <<"undefined">> -> <<>>;
% 							 ManAny -> ManAny
% 						 end,
% 			db:update(partner, ["skills", "eq_skills", "manual_skills"], [DbSkill, DbEqSkill, DbManSkill], 
% 					  "id", PartnerId),
% 			1
% 	end.
			
			

% %% ======================================================函数部分======================================

% %%判断该技能是否已学
% %% is_skill_learn(SkillList, SkillId) ->
% %% 	case lists:keyfind(SkillId, 1, SkillList) of
% %% 		false -> false;
% %% 		_ -> true 
% %% 	end.

% %%学习并装备技能
% learn_equip_skill(Status, SkillId, Cell) ->
% 	?TRACE("lds\n learn_equip_skill ID = ~p Plv = ~p~n", [SkillId, Status#player_status.lv]),
% 	case upgrade_skill(Status, SkillId) of
% 		{false, ErrCode} -> 
% 			?ERROR_MSG("skill : auto learn skill learn ErrCode = ~p", [ErrCode]),
% 			?ASSERT(false),
% 			Status;
% 		{true, NewStatus} ->
% 			case equip_skill(NewStatus, SkillId, Cell) of
% 				{false, EqErrCode} ->
% 					?ERROR_MSG("skill : auto learn skill equip ErrCode = ~p", [EqErrCode]),
% 					?ASSERT(false),
% 					Status;
% 				{true, EqNewStatus} ->
% 					EqNewStatus
% 			end
% 	end.

% %%取得技能习得条件
% %%retrun: {PartnerLv, Profi}
% get_skill_condition(Id, Lv) ->
% 	SkillRd = data_skill:get(Id, Lv),
% 	?TRACE("SkillId=~p, SkillLv=~p~n", [Id, Lv]),
% 	case is_record(SkillRd, ets_skill) of
% 		false -> ?ASSERT(false, Id),
% 				 ?ERROR_MSG("Partner learn skill id = ~p not exist", [Id]),
% 				 {99999, 0};
% 		_ ->
% 			case (SkillRd#ets_skill.data)#rd_skill_data.study_cond of
% 				[{lv, PartnerLv}, {profi, Profi}] ->
% 					{PartnerLv, Profi};
% 				[{lv, PartnerLv}] ->
% 					{PartnerLv, 0};
% 				_ ->
% 					{99999, 0}
% 			end
% 	end.

% %%取得学习技能条件
% %%@return: {Career, PartnerId, Color}
% get_learn_skill_condition(BookId) ->
% 	SkillBookRd = data_book:get(BookId),
% 	{SkillBookRd#rd_skill_book.career_limit, SkillBookRd#rd_skill_book.spec_partner, SkillBookRd#rd_skill_book.color}.

% %%取得技能书学习的技能
% get_skill_by_book(BookId) ->
% 	SkillBookRd = data_book:get(BookId),
% 	SkillBookRd#rd_skill_book.skill_id.

% %%消费金钱
% cost_money(Status, Gold, Coin) ->
% 	NewGold = Status#player_status.gold - Gold,
% 	NewCoin = Status#player_status.coin - Coin,
% 	NewStatus = Status#player_status{gold = NewGold, coin = NewCoin},
% 	db:update(player, ["gold", "coin"], [NewGold, NewCoin], 
% 					  "id", NewStatus#player_status.id),
% 	{ok, BinMoney} = pt_13:write(13013, NewStatus),
% 	lib_send:send_to_uid(NewStatus#player_status.id, BinMoney),
% 	NewStatus.

% %% 取得武将格子内的技能ID
% get_partner_cell_skill_id(Cell, Skill) ->
%     case lists:keyfind(Cell, 3, Skill) of
%         false -> {0, 0, 0, 0};
%         {Id, Lv, Cell, Profi} -> {Id, Lv, Cell, Profi};
%         _ -> ?ASSERT(false)
%     end.

% %% 替换技能
% replace_partner_skill({Id, Lv, Eq, Profi}, Skill) ->
%     case Id =:= 0 of
%         true ->
%             Skill;
%         false ->
%             lists:keyreplace(Id, 1, Skill, {Id, Lv, Eq, Profi})
%     end.

% %% 自动装技能
% auto_eq_skill(Status, SkillId) ->
%     case get_free_cell(Status#player_status.skill, 1) of
%         0 -> 
%             Status;
%         Cell -> 
%             case equip_skill(Status, SkillId, Cell) of
%                 {false, _ErrCode} ->
%                     Status;
%                 {true, NewStatus} ->
%                     {ok,Bdata} = pt_21:write(21003, [1, 1, SkillId, Cell]),
%                     ?TRACE("21003_1:BinData=~p~n", [Bdata]),
%                     lib_send:send_one(Status#player_status.socket,Bdata),
%                     NewStatus
%             end
%     end.

% %% 取得空闲的格子
% %% @spec() -> int 0表示没法装了
% get_free_cell(_Skill, ?EQ_SKILL_MAX_CELL + 1) -> 
%     0;
% get_free_cell(Skill, N) ->
%     case lists:keyfind(N, 3, Skill) of 
%         false -> 
%             N;
%         _ -> 
%             get_free_cell(Skill, N + 1)
%     end.

% %% 替换技能
% replace_skill(RoleId, {Id, Lv, Eq}, Skill) ->
%     case Id =:= 0 of
%         true ->
%             Skill;
%         false ->
%             NewSkill = lists:keyreplace(Id, 1, Skill, {Id, Lv, Eq}),
%             change_skill_status(RoleId, Id, Eq),
%             NewSkill
%     end.

% %% 取得格子内的技能ID
% get_cell_skill_id(Cell, Skill) ->
%     case lists:keyfind(Cell, 3, Skill) of
%         false -> {0, 0, 0};
%         {Id, Lv, Cell} -> {Id, Lv, Cell};
%         _ -> ?ASSERT(false)
%     end.

% %% 清技能函数
% do_clear_skill(Status, Gold, Type) ->
%     NowSkillPoint = calc_skill_point(Status#player_status.lv),
%     del_skill(Status#player_status.id, all),
%     NewStatus = Status#player_status{skill_point = NowSkillPoint, skill = [], eq_skill = []},
% %% 	NewStatus1 = cost_money(NewStatus, Gold, 0),
% 	NewStatus1 = if Type == 1 ->
% 						lib_money:cost_money(statistic, NewStatus, Gold, gold, ?LOG_SKILL_WASH);
% 					true ->
% 						Ztb = lib_money:rmb_to_zt_money(Gold),
% 						lib_money:cost_money(statistic, NewStatus, Ztb, bcoin, ?LOG_SKILL_WASH)
% 				 end,
%     {true, NewStatus1}.

% %% 取技能的最大等级
% %% @spec -> int
% get_max_lv(Id) ->
%     get_max_lv(Id, 1).
% get_max_lv(Id, Lv) ->
%     Skill = data_skill:get(Id, Lv),
%     ?ASSERT(Skill =/= []),
%     case Skill#ets_skill.data of 
%         [] -> Lv - 1;
%         _ -> get_max_lv(Id, Lv + 1)
%     end.

% %% 取得当前等级
% %% @spec -> int
% get_cur_lv(SkillId, PS) when is_record(PS, player_status) ->
% 	get_cur_lv(SkillId, PS#player_status.skill);
% get_cur_lv(SkillId, SkillList) ->
%     case lists:keyfind(SkillId, 1, SkillList) of
%         false -> 0;
%         {SkillId, SkillLv, _Grid} -> SkillLv;
%         _ -> ?ASSERT(false)
%     end.

% %% 判断是否能学习
% %% @spec() -> true|false 
% is_can_study(Status, Id) ->
%     case check_upgrade(Status, Id) of
%         {false, _} -> false;
%         {true, _, _, _, _, _} -> true
%     end.

% %% 是否已经装备
% is_equip(Id, EqSkill) ->
%     case lists:keyfind(Id, 1, EqSkill) of
%         false -> false;
%         {Id, _Lv, _Eq} -> true;
%         _ -> ?ASSERT(false)
%     end.

% %% 检测是否能升级
% %% @spec() -> {false, Reason}|{true, NewStatus, Coin, Soul, Book, SkillInfo}
% check_upgrade(PlayerStatus, SkillId) ->
%     SkillList = data_skill:get_skill_ids(PlayerStatus#player_status.career),
%     case lists:member(SkillId, SkillList) of
%         false ->
%             % 技能不存在
%             {false, 2};
%         true ->
%             case PlayerStatus#player_status.skill_point > 0 of
%                 false->
%                     {false, 10}; % 没技能点
%                 true ->
%                     SkillInfo = get_next_lv_info(SkillId, PlayerStatus#player_status.skill),
%                     case is_record(SkillInfo, ets_skill) of
%                         false ->
%                             % 技能不存在
%                             {false, 2};
%                         true when SkillInfo#ets_skill.data =:= [] ->
%                             % 技能已达最高级
%                             {false, 3};
%                         true ->
%                             [_, Res, Coin, Soul, Book] = check_upgrade_condition(SkillInfo#ets_skill.data#rd_skill_data.study_cond, PlayerStatus, 0, 0, 0),
%                             case is_integer(Res) of
%                                 true ->
%                                     {false, Res};
%                                 false ->
%                                     {true, Res, Coin, Soul, Book, SkillInfo}
%                             end
%                     end
%             end
%     end.   

% %% 检查是否能装备技能
% check_equip_skill(SkillId, Equip, PlayerSkills) ->
%     Result = lists:keyfind(SkillId, 1, PlayerSkills),
%     Skill = data_skill:get(SkillId, 1),
%     if 
%         Skill =:= [] orelse Result =:= false -> % 技能不存在
%             {fail, 3};
%         Equip > ?EQ_SKILL_MAX_CELL orelse Equip < 0 -> % 技能格子编号不对
%             {fail, 2};
% 		Skill#ets_skill.type =:= ?SKL_T_PASSIVE ->   % 被动技能不能拖放
% %%         Skill#ets_skill.type =:= ?SKL_T_PASSIVE orelse Skill#ets_skill.type =:= ?SKL_T_PURSUE ->  % 被动技能追加技不能拖放
%             {fail, 4}; 
%         true ->
%             {ok, Result}
%     end.

% %% 检查是否能装备技能
% check_partner_equip_skill(SkillId, Equip, PartnerSkills) ->
%     Result = lists:keyfind(SkillId, 1, PartnerSkills),
%     Skill = data_skill:get(SkillId, 1),
%     if 
%         Skill =:= [] orelse Result =:= false -> % 技能不存在
%             {fail, 3};
%         Equip > ?EQ_PARTNER_SKILL_MAX_CELL orelse Equip < 0 -> % 技能格子编号不对
%             {fail, 2};
% 		Skill#ets_skill.type =:= ?SKL_T_PASSIVE ->
% %%         Skill#ets_skill.type =:= ?SKL_T_PASSIVE orelse Skill#ets_skill.type =:= ?SKL_T_PURSUE ->  % 被动技能追加技不能拖放
%             {fail, 4};
% %% 		(Skill#ets_skill.type =:= ?SKL_T_COMM andalso Equip > ?EQ_NORMAL_SKILL_CELL)
% %% 		  orelse (Skill#ets_skill.type =:= ?SKL_T_STUNT andalso (Equip =/= ?EQ_STUN_CELL andalso Equip =/= 0)) ->
% %% 			{fail, 5};
%         true ->
%             {ok, Result}
%     end.

% get_eq_skill(Skills) ->
%     [{SkillId, SkillLv, Equip} || {SkillId, SkillLv, Equip} <- Skills, Equip > 0].

% %% 取得下等级信息
% get_next_lv_info(SkillId, PlayerSkills) ->
%    case [{Sid, Slv, Equip} || {Sid, Slv, Equip} <- PlayerSkills, Sid =:= SkillId] of
%        [] ->
%            % 未学过
%            data_skill:get(SkillId, 1);
%        [Info] when is_tuple(Info) ->
%            % 已学过
%            {SkillId, SkillLv, _} = Info,
%            NextLv = SkillLv + 1,
%            data_skill:get(SkillId, NextLv);
%        _ ->
%            {}
%    end.

% %% To-Do: 扣钱不应该放在检查学习条件里
% check_upgrade_condition([], PlayerStatus, Coin, Soul, Book) ->
%     %% 	NewPlayerStatus = goods_util:get_cost(PlayerStatus, Coin, coin),
%     [ok, PlayerStatus, Coin, Soul, Book];
% check_upgrade_condition([{Cond, Val} | T], PlayerStatus, Coin, Soul, Book)  ->
%     case Cond of
%         lv -> 
%             if 
%                 % 等级不足
%                 PlayerStatus#player_status.lv < Val ->
% %%                     io:format("~p:~p-----------------------~n", [PlayerStatus#player_status.lv, Val]),
%                     [fail, 4, Coin, Soul, Book];
%                 true ->
%                     check_upgrade_condition(T, PlayerStatus, Coin, Soul, Book)
%             end;
%         coin ->
%             if
%                 % 金额不足
%                 PlayerStatus#player_status.coin < Val ->
%                     [fail, 5, Coin, Soul, Book];
%                 true ->
%                     check_upgrade_condition(T, PlayerStatus, Val, Soul, Book)
%             end;
%         book -> % TODO
%             case goods_util:get_type_goods_list(PlayerStatus#player_status.id, Val, ?LOCATION_BAG) of
%                 [] -> % 没有此书 
%                     [fail, 6, Coin, Soul, Book];
%                 [BookInfo|_] ->
%                     check_upgrade_condition(T, PlayerStatus, Coin, Soul, BookInfo#goods.id)
%             end;
%         task ->
%             case ets:lookup(?ETS_ROLE_TASK, {PlayerStatus#player_status.id,Val}) of
%                 [] -> % 没有此任务
%                     case  lib_task:in_finish(Val, PlayerStatus) of
%                         true ->
%                             check_upgrade_condition(T, PlayerStatus, Coin, Soul, Book);
%                         false ->
%                             [fail, 8, Coin, Soul, Book]
%                     end;
%                 [_TaskInfo|_] ->
%                     check_upgrade_condition(T, PlayerStatus, Coin, Soul, Book)
%             end;
%         soul_power ->
%             if
%                 % 战魂点不足 
%                 PlayerStatus#player_status.soul_power < Val ->
%                     [fail, 9, Coin, Soul, Book];
%                 true ->
%                     check_upgrade_condition(T, PlayerStatus, Coin, Val, Book)
%             end;
%         _ ->
%             check_upgrade_condition(T, PlayerStatus, Coin, Soul, Book)
%     end;

% check_upgrade_condition([{Cond, Skill, Lv} | T], PlayerStatus, Coin, Soul, Book)  ->
%     case Cond of
%         left_skill -> %% 需要前置技能
%             case lists:keyfind(Skill, 1, PlayerStatus#player_status.skill) of
%                 false ->
%                     [fail, 7, Coin, Soul, Book];    %% 没学前置技能
%                 {_Skill, Lv1, _} ->
%                     if 
%                         Lv1 < Lv ->     %% 前置技能等级不够
%                             [fail, 7, Coin, Soul, Book];
%                         true ->
%                             check_upgrade_condition(T, PlayerStatus, Coin, Soul, Book)
%                     end
%             end;
%         _ ->
%             check_upgrade_condition(T, PlayerStatus, Coin, Soul, Book)
%     end.

% %% 删除技能书
% delete_book(Status, Book) ->
%     if 
%         Book =:= 0 ->
%             ok;
%         true ->
%             case gen_server:call(?GET_GOODS_PID(Status), {'delete_one', Status, Book, 1}) of
%                 [1, _GoodsNumNew] ->
%                     ok;
%                 [GoodsModuleCode, 0] ->
%                     ?DEBUG_MSG("upgrade_skill:Call goods module faild, result code=[~p]", [GoodsModuleCode]),
%                     {false, GoodsModuleCode}
%             end
%     end.

% upgrade(Status, SkillInfo, Coin, Soul, Book) ->
%     % 升级/学习技能扣书
%     delete_book(Status, Book),
%     % 升级/学习技能扣钱
%     PlayerStatus = Status#player_status{coin = Status#player_status.coin - Coin
%                                         ,soul_power = Status#player_status.soul_power - Soul
%                                         ,skill_point = Status#player_status.skill_point - 1 
%                                     },
%     SkillId = SkillInfo#ets_skill.id,
%     NewPlayerStatus = case lists:keyfind(SkillId, 1, PlayerStatus#player_status.skill) of
%         false ->
%             % 未学过，添加
%             add_new_skill(SkillInfo, PlayerStatus),
%             NewSkill = [{SkillId, 1, 0} | PlayerStatus#player_status.skill],
%             NewStatus = PlayerStatus#player_status{skill = NewSkill},
%             NewStatus2 = auto_eq_skill(NewStatus, SkillId),
%             lib_hang:sys_auto_set_cur_use_skill_comb(NewStatus2); % 学习新技能后，系统自动帮玩家设置一下挂机技能组合
%         {SkillId, SkillLv, Equip} ->
%             % 已学会，等级加1
%             NewLv = SkillLv + 1,
%             update_skill_lv(SkillId, PlayerStatus#player_status.id, NewLv),
%             NewSkill = lists:keyreplace(SkillId, 1, PlayerStatus#player_status.skill, {SkillId, NewLv, Equip}),
%             PlayerStatus#player_status{skill = NewSkill};
%         _ ->
%             PlayerStatus
%     end,
%     ?ASSERT(is_record(NewPlayerStatus, player_status), NewPlayerStatus),
%     {ok, NewPlayerStatus}.


% change_skill_status(PlayerId, SkillId, Equip) ->
% 	db:update(skill, [{equip,Equip}], [{id,PlayerId}, {skill_id,SkillId}]).

% add_new_skill(SkillInfo, PlayerStatus) ->
%     PlayerId = PlayerStatus#player_status.id,
%     SkillId = SkillInfo#ets_skill.id,
    
% 	db:insert(skill, [id, skill_id, lv, equip], [PlayerId, SkillId, 1, 0]).

% %% 增加新技能等级
% %% @spec() -> ok.
% update_skill_lv(SkillId, PlayerId, SkillLv) ->
% 	db:update(skill, [{lv,SkillLv}], [{skill_id,SkillId}, {id,PlayerId}]).

% %% 删除人物技能
% del_skill(PlayerId, all) ->
% 	db:delete(skill, [{id,PlayerId}]);
% del_skill(PlayerId, SkillId) ->
% 	db:delete(skill, [{id,PlayerId}, {skill_id,SkillId}]).

% %% 生成武将的出生技能数据（初始时把出生技能全都装备上去）
% make_new_skills([], _Grid, Acc, _Plv) ->
%     F = fun({Id, Lv, Eq}) ->
%         case Lv =:= 0 of
%             true -> {Id, 1, 0};
%             false -> {Id, Lv, Eq}
%         end
%     end,
%     lists:map(F, Acc); 
% make_new_skills([{Id, _Lv, Eq} | T], Grid, Acc, Plv) ->
%     NewLv = get_skill_lv(Id, 0, Plv),
%     case is_normal_skill(Id) of
%         true when Eq =/= 0-> % 普通技已装备
%             NewAcc = [{Id, NewLv, Eq}|Acc],
%             make_new_skills(T, Grid, NewAcc, Plv);
%         true -> % 普通技未装备
%             if 
%                 Grid > ?EQ_SKILL_MAX_CELL -> % 已经装满了
%                     NewAcc = [{Id, NewLv, 0}|Acc],
%                     make_new_skills(T, Grid, NewAcc, Plv);
%                 true -> % 没装满
%                     NewAcc = [{Id, NewLv, Grid}|Acc],
%                     make_new_skills(T, Grid + 1, NewAcc, Plv)
%             end;
%         false when Eq =/= 0-> % 必杀技已装备
%             NewAcc = [{Id, NewLv, Eq}|Acc],
%             make_new_skills(T, Grid, NewAcc, Plv);
%         false -> % 必杀技未装备
%             NewAcc = [{Id, NewLv, 4}|Acc],
%             make_new_skills(T, Grid, NewAcc, Plv);
%         _  -> 
%             ?ASSERT(false)
%     end.


% %% 取升级后的等级
% get_skill_lv(Id, Lv, Plv) ->
%     case Plv >= get_study_lv(Id, Lv + 1) of
%         true ->  get_skill_lv(Id, Lv + 1, Plv);
%         false -> Lv
%     end.

% %% 升级武将技能
% %% spec(武将结构, 武将等级) -> #ets_partner{}
% upgrade_partner_skill(ParInfo) ->
%     SkL = make_new_skills(ParInfo#ets_partner.skills, 1, [], ParInfo#ets_partner.lv),
%     ParInfo#ets_partner{skills = SkL, eq_skills = [{Id, Lv, Eq} || {Id, Lv, Eq} <- SkL, Eq =/= 0]}.

% %% 取得学技能需要的等级
% get_study_lv(SkillId, SkillLv) ->
%     case data_skill:get(SkillId, SkillLv) of
%         [] ->
%             9999999999; 
%         SkillInfo ->
%             case SkillInfo#ets_skill.data of
%                 [] ->
%                     9999999999; 
%                 SkillData ->
%                     StudyCond = SkillData#rd_skill_data.study_cond,
%                     case lists:keyfind(lv, 1, StudyCond) of
%                         false ->
%                             9999999999;
%                         {lv, NeedLv} ->
%                             NeedLv
%                     end
%             end
% 	end.

% %% 获取武将所学技能列表
% get_partner_skill(PartnerId) ->
%     case lib_partner:get_alive_partner(PartnerId) of
%         null ->
%             [[],[],[]];	
%         PartnerInfo ->
%             Skills = PartnerInfo#ets_partner.skills,
%             AllSkill = [Id || {Id, _lv, _eq} <- Skills],
%             EqSkill = [{Id, Lv, Eq} || {Id, Lv, Eq} <- Skills, Eq =/= 0],
%             [AllSkill, Skills, EqSkill]
%     end.

% %% 判断是否普通技
% is_normal_skill(SklId) when is_integer(SklId) ->
%     case data_skill:get(SklId, 1) of
%     	[] ->
%     		?ASSERT(false, SklId),
%             false;
%     	SklData ->
%     		SklData#ets_skill.type =:= ?SKL_T_COMM
%     end;
% is_normal_skill(SklData) ->
%     SklData#ets_skill.type =:= ?SKL_T_COMM.

% %% exports
% %% @desc: 判断是否觉醒必杀技
% %% @returns: true | false
% is_awake_stunt_skill(SklId) when is_integer(SklId) ->
%     case data_skill:get(SklId, 1) of
%         [] ->
%             ?ASSERT(false, SklId),
%             false;
%         SklData ->
%             is_awake_stunt_skill(SklData)
%     end;
% is_awake_stunt_skill(SklData) ->
%     SklData#ets_skill.type =:= ?SKL_T_AWAKE_STUNT. 
    
 
% %% 判断是否必杀技    
% is_stunt_skill(SklId) when is_integer(SklId) ->
% 	case data_skill:get(SklId, 1) of
%     	[] ->
%     		?ASSERT(false, SklId),
%             false;
%     	SklData ->
%     		SklData#ets_skill.type =:= ?SKL_T_STUNT
%     end;
% is_stunt_skill(SklData) ->
%     SklData#ets_skill.type =:= ?SKL_T_STUNT.
	

% %% 判断是否追击技
% is_pursue_skill(SklId) when is_integer(SklId) ->
% 	case data_skill:get(SklId, 1) of
%     	[] ->
%     		?ASSERT(false, SklId),
%             false;
%     	SklData ->
%     		SklData#ets_skill.type =:= ?SKL_T_PURSUE
%     end;
% is_pursue_skill(SklData) ->
% 	SklData#ets_skill.type =:= ?SKL_T_PURSUE.


% %% 判断是否合体技
% is_cooperate_skill(SklId) when is_integer(SklId) ->
% 	case data_skill:get(SklId, 1) of
%     	[] ->
%     		?ASSERT(false, SklId),
%             false;
%     	SklData ->
%     		SklData#ets_skill.type =:= ?SKL_T_COOPERATE
%     end;
% is_cooperate_skill(SklData) ->
% 	SklData#ets_skill.type =:= ?SKL_T_COOPERATE.
	
		
   
% %% 判断是否被动技
% is_passive_skill(SklId) when is_integer(SklId) ->
% 	case data_skill:get(SklId, 1) of
%     	[] ->
%     		?ASSERT(false, SklId),
%             false;
%     	SklData ->
%     		SklData#ets_skill.type =:= ?SKL_T_PASSIVE
%     end;
% is_passive_skill(SklData) ->
% 	SklData#ets_skill.type =:= ?SKL_T_PASSIVE.

% %% exports
% %% @desc: 判断该技能是否属于技能球类型的技能
% %% @returns: true|false
% is_skillball_type(SkillId) when is_integer(SkillId) ->
%     case data_skill:get(SkillId, 1) of
%         [] ->
%             ?ASSERT(false, SkillId),
%             false;
%         SklData ->
%             is_skillball_type(SklData)
%     end;
% is_skillball_type(SklData) ->
%     SklData#ets_skill.type =:= ?SKL_T_SKILLBALL.

	
	

% %% 计算技能点
% calc_skill_point(Lv) -> Lv div 2.

% %% 重新计算人物技能点
% calc_player_skill_point(Status) ->
%     TotalPoint = Status#player_status.lv div 2,
% %% 	Skill = Status#player_status.skill,
% %%     F = fun({_Id, Lv, _Eq}, N) ->
% %%         Lv +  N
% %%     end,
% %%     UsePoint = lists:foldl(F, 0, Skill),
% 	UsePoint = calc_use_skill_point(Status),
%     NewPoint = max(TotalPoint - UsePoint, 0),
%     Status#player_status{skill_point = NewPoint}.

% %% 计算已使用技能点
% calc_use_skill_point(Status) ->
% 	Skill = Status#player_status.skill,
%     F = fun({_Id, Lv, _Eq}, N) ->
%         Lv +  N
%     end,
% 	lists:foldl(F, 0, Skill).