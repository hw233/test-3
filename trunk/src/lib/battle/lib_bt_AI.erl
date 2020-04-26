%%%-------------------------------------- 
%%% @Module: lib_bt_AI
%%% @Author: huangjf
%%% @Created: 2013.12.23
%%% @Description: 战斗AI的相关函数
%%%-------------------------------------- 

-module(lib_bt_AI).
-export([
% 		monster_sel_skill/1,
% 		tmp_AI_sel_skill/1,
% 		auto_mf_AI_sel_skill/1,
%         sel_born_skill/1
		get_cfg_data/1,
		is_talk_AI/1,
		bo_prepare_cmd_by_AI/1,
		decide_bo_cur_round_talk_AI/1,
		check_one_condition/2
    ]).
    
-import(lib_bt_comm, [
			get_bo_by_id/1
% 			is_player/1,
% 			is_partner/1,
% 			is_sequence_use_skill/1,
% 			get_bo_skill_lv/2,
% 			check_can_use_skill/3,
% 			to_skill_brief/1,
% 			get_eq_normal_skill_list/1,
% 			get_eq_skill_list/1,
% 			get_bo_skill_brief/2,
% 			is_monster/1,
% 			decide_proba_once/1,
% 			get_cur_turn_index/0
			]).
    
    
-include("common.hrl").
-include("battle.hrl").
-include("battle_AI.hrl").
-include("effect.hrl").
-include("record/battle_record.hrl").






%% @return: null | bo_ai结构体
get_cfg_data(AINo) ->
	data_AI:get(AINo).
	

is_talk_AI(AINo) ->
	AI = get_cfg_data(AINo),
	case AI#bo_ai.action_content of
		{?AI_CONT_TALK, _, _} ->
			true;
		_ ->
			false
	end.


bo_prepare_cmd_by_AI(BoId) ->
	Bo = get_bo_by_id(BoId),
	L0 = lib_bo:get_AI_no_list(Bo),
	L1 = [X || X <- L0, not is_talk_AI(X)],  % 过滤掉对话气泡ai
	?BT_LOG(io_lib:format("bo_prepare_cmd_by_AI(), CurRound: ~p, BoId:~p, non talk AI no list:~p~n", [lib_bt_comm:get_cur_round(), BoId, L1])),
	L2 = [X || X <- L1, check_AI_conditions(Bo, X) == ok],
	?BT_LOG(io_lib:format("bo_prepare_cmd_by_AI(), BoId:~p, check condition ok AI no list:~p~n", [BoId, L2])),

	L3 = [X || X <- L2, check_AI_action_targets(Bo, X) == ok],
	?BT_LOG(io_lib:format("bo_prepare_cmd_by_AI(), BoId:~p, check action targets ok AI no list:~p~n", [BoId, L3])),

	case L3 of
		[] ->
			?BT_LOG(io_lib:format("bo_prepare_cmd_by_AI(), no AI is ok, so prepare default cmd! BoId:~p~n", [BoId])),
			lib_bo:prepare_default_cmd(BoId);
		_ ->
			L4 = [data_AI:get(X) || X <- L3],
			case decide_which_AI_to_pick(L4) of
				null ->
					?ASSERT(false, L4),
					lib_bo:prepare_default_cmd(BoId);
				PickedAI ->
					?BT_LOG(io_lib:format("bo_prepare_cmd_by_AI(), BoId:~p, PickedAI:~w, Bo:~w~n", [BoId, PickedAI, Bo])),
					?ASSERT(is_record(PickedAI, bo_ai)),
					do_prepare_cmd_by_spec_AI(BoId, PickedAI)
			end	
	end.


%% 确定bo的当前回合的对话气泡ai
decide_bo_cur_round_talk_AI(BoId) ->
	Bo = get_bo_by_id(BoId),
	L = lib_bo:get_talk_AI_no_list(Bo),
	L2 = [X || X <- L, check_AI_conditions(Bo, X) == ok],
	lib_bo:set_cur_round_talk_AI_list(BoId, L2).  
	


%% 检测AI条件
%% @return：ok | fail
check_AI_conditions(Bo, AINo) ->
	?BT_LOG(io_lib:format("check_AI_conditions(), CurRound:~p, BoId:~p, AI no:~p~n", [lib_bt_comm:get_cur_round(), lib_bo:id(Bo), AINo])),
	case get_cfg_data(AINo) of
		null ->  % 容错
			?ASSERT(false, AINo),
			?ERROR_MSG("[lib_bt_AI] check_AI_conditions() error!! AI not exists! AINo:~p", [AINo]),
			fail;
		AI ->
			CondList = AI#bo_ai.condition_list,
			check_AI_conditions__(Bo, CondList)
	end.

			


check_AI_conditions__(_Bo, []) ->
	ok;
check_AI_conditions__(Bo, [CondNo | T]) ->
	case check_one_condition(Bo, CondNo) of
		ok ->
			check_AI_conditions__(Bo, T);
		fail ->
			fail
	end.



%% @return: ok | fail
check_one_condition(dummy_bo, CondNo) ->
	try
		check_one_condition__(dummy_bo, CondNo)
	catch
		_:Reason ->
			?ASSERT(false, Reason),
			?ERROR_MSG("check_one_condition() error!! Reason:~w", [Reason]),
			fail
	end;
	
check_one_condition(Bo, CondNo) when is_record(Bo, battle_obj) ->
	check_one_condition__(Bo, CondNo).
	

check_one_condition__(Bo, CondNo) ->
	AICond = data_AI_condition:get(CondNo),
	?ASSERT(AICond /= null, CondNo),
	case AICond of
		null ->	 % 容错
			?ERROR_MSG("[lib_bt_AI] check_one_condition() error! AICond not exists! CondNo:~p, Bo:~w", [CondNo, Bo]),
			fail;
		_ ->
			% 求左边的值列表
			LeftValList = evaluate_AI_condition_left_values(Bo, AICond),
			%%%%?ASSERT(util:is_integer_list(LeftValList) andalso LeftValList /= [], LeftValList),

			% 求右边的值列表
			RightValList = evaluate_AI_condition_right_values(Bo, AICond),
			%%%%?ASSERT(util:is_integer_list(RightValList) andalso RightValList /= [], RightValList),

			% 随机挑选一个右值
			RightVal = list_util:rand_pick_one(RightValList),

			CmpSymbol = AICond#ai_cond.cmp_symbol,

			% 做判定（只要有一个左值使得判定等式成立，就返回ok）
			Ret = check_equation(LeftValList, CmpSymbol, RightVal),

			?BT_LOG(io_lib:format("check_one_condition(), CurRound:~p, CondNo:~p, Ret:~p, Bo:~w~n", [lib_bt_comm:get_cur_round(), CondNo, Ret, Bo])),

			Ret
	end.

			


check_equation([], _CmpSymbol, _RightVal) ->
	fail;
check_equation([LeftVal | T], CmpSymbol, RightVal) ->
	Bool = 	case CmpSymbol of
				">"  -> LeftVal > RightVal;
				"<"  -> LeftVal < RightVal;
				"="  -> LeftVal == RightVal;
				">=" -> LeftVal >= RightVal;
				"<=" -> LeftVal =< RightVal;
				_    -> ?ASSERT(false, CmpSymbol), false
			end,

	case Bool of
		true -> ok;
		false -> check_equation(T, CmpSymbol, RightVal)
	end.



%% 求AI条件的判定不等式的左边的值列表
evaluate_AI_condition_left_values(Bo, AICond) ->
	BaseValList = evaluate_AI_condition_left_base_values(Bo, AICond),
	?ASSERT(util:is_integer_list(BaseValList) andalso BaseValList /= [], {BaseValList, AICond}),
	F = fun(BaseVal) ->
			{OpSymbol, AddiVal} = AICond#ai_cond.addi_value_L,
			%%%%?ASSERT(is_integer(AddiVal), AICond),  有可能为小数，断言不再适用
			% 加/减/乘附加值
			case OpSymbol of
				"+" -> BaseVal + AddiVal;
				"-" -> BaseVal - AddiVal;
				"*" -> BaseVal * AddiVal
			end
		end,
	[F(X) || X <- BaseValList].


%% 求AI条件的判定不等式的右边的值列表
evaluate_AI_condition_right_values(Bo, AICond) ->
	BaseValList = evaluate_AI_condition_right_base_values(Bo, AICond),
	?ASSERT(util:is_integer_list(BaseValList) andalso BaseValList /= [], {BaseValList, AICond}),
	F = fun(BaseVal) ->
			{OpSymbol, AddiVal} = AICond#ai_cond.addi_value_R,
			%%%%?ASSERT(is_integer(AddiVal), AICond),
			% 加/减/乘附加值
			case OpSymbol of
				"+" -> BaseVal + AddiVal;
				"-" -> BaseVal - AddiVal;
				"*" -> BaseVal * AddiVal
			end
		end,
	[F(X) || X <- BaseValList].
	





%% 判定所依据的属性(JDG: judge)
-define(JDG_ATTR_NO_ATTR, no_attr).													% 无
-define(JDG_ATTR_IS_MY_ALLY, is_my_ally).        									% 是否属于我方
-define(JDG_ATTR_IS_MY_ENEMY, is_my_enemy).      									% 是否属于敌方
-define(JDG_ATTR_IS_UNDEAD, is_undead).          									% 是否未死亡
-define(JDG_ATTR_IS_DEAD, is_dead).              									% 是否已死亡
-define(JDG_ATTR_IS_GHOST, is_ghost).              									% 是否处于鬼魂状态
-define(JDG_ATTR_IS_FALLEN, is_fallen).    											% 是否处于倒地状态
-define(JDG_ATTR_HAS_INVISIBLE_EFF, has_invisible_eff).              				% 是否有隐身效果
-define(JDG_ATTR_HAS_NOT_INVISIBLE_EFF, has_not_invisible_eff).      				% 是否没有隐身效果
-define(JDG_ATTR_IS_INVISIBLE_TO_ME, is_invisible_to_me).            				% 对我而言，目标的隐身效果是否成立
-define(JDG_ATTR_IS_NOT_INVISIBLE_TO_ME, is_not_invisible_to_me).    				% 对我而言，目标的隐身效果是否不成立
-define(JDG_ATTR_LV, lv).    														% 等级
-define(JDG_ATTR_CUR_HP, cur_hp).    												% 当前血量
-define(JDG_ATTR_CUR_MP, cur_mp).    												% 当前蓝量
-define(JDG_ATTR_CUR_ANGER, cur_anger).    											% 当前怒气
-define(JDG_ATTR_PHY_ATT, phy_att).    												% 物理攻击（物攻）
-define(JDG_ATTR_MAG_ATT, mag_att).    												% 法术攻击（法攻）
-define(JDG_ATTR_PHY_DEF, phy_def).    												% 物理防御（物防）
-define(JDG_ATTR_MAG_DEF, mag_def).    												% 法术防御（法防）
-define(JDG_ATTR_ACT_SPEED, act_speed).    											% 出手速度
-define(JDG_ATTR_SEAL_HIT, seal_hit).    											% 封印命中
-define(JDG_ATTR_SEAL_RESIS, seal_resis).    										% 封印抗性
-define(JDG_ATTR_CUR_HP_PERCENTAGE, cur_hp_percentage).  							% 当前血量的百分比
-define(JDG_ATTR_CUR_MP_PERCENTAGE, cur_mp_percentage).    							% 当前蓝量的百分比
-define(JDG_ATTR_CUR_ANGER_PERCENTAGE, cur_anger_percentage).    					% 当前怒气的百分比
-define(JDG_ATTR_HAS_SPEC_NO_BUFF, has_spec_no_buff).    							% 是否有指定编号的buff
-define(JDG_ATTR_HAS_SPEC_CATEGORY_BUFF, has_spec_category_buff).    				% 是否有指定类别的buff
-define(JDG_ATTR_HAS_SPEC_EFF_TYPE_BUFF, has_spec_eff_type_buff). 					% 是否有指定效果类型（增益|减益|中性）的buff
-define(JDG_ATTR_CUR_ROUND, cur_round).    											% 当前回合数
-define(JDG_ATTR_REMAINDER_OF_CUR_ROUND_DIV_BY_N, remainder_of_cur_round_div_by_N). % 当前回合数除以N所得的余数
-define(JDG_ATTR_MON_NO, mon_no). 													% 战斗怪的编号
-define(JDG_ATTR_POS, pos). 														% 战位编号
-define(JDG_ATTR_FILTERED_BO_COUNT, filtered_bo_count). 							% 符合所有筛选条件的目标数量
-define(JDG_ATTR_IS_CAN_USE_SKILL, is_can_use_skill). 								% 当前是否满足使用指定技能的条件
-define(JDG_ATTR_ROUND_COUNT_SINCE_SPAWNED, round_count_since_spawned). 			% 自从刷出后开始算起的回合计数
-define(JDG_ATTR_DIFF_BETWEEN_MY_PHY_ATT_AND_TARGET_PHY_DEF, diff_between_my_phy_att_and_target_phy_def).  % 我的物攻与目标的物防的差值
-define(JDG_ATTR_DIFF_BETWEEN_MY_MAG_ATT_AND_TARGET_MAG_DEF, diff_between_my_mag_att_and_target_mag_def).  % 我的法攻与目标的法防的差值


evaluate_AI_condition_left_base_values(Bo, AICond) ->
	case AICond#ai_cond.attr_L of
		?JDG_ATTR_NO_ATTR -> % 无属性则返回[0]
			[0];
		?JDG_ATTR_CUR_ROUND ->
			[lib_bt_comm:get_cur_round()];
		{?JDG_ATTR_REMAINDER_OF_CUR_ROUND_DIV_BY_N, N} ->
			?ASSERT(util:is_positive_int(N), N),
			CurRound = lib_bt_comm:get_cur_round(),
			[CurRound rem N];
		Attr ->
			% 筛选出判定主体（bo列表）
			Rules = AICond#ai_cond.rules_filter_bo_L,
			case filter_bo_by_rules(Bo, Rules) of
				[] -> % 无主体则返回[0]
					[0];
				BoIdList_Filtered ->
					evaluate_AI_condition_base_values(Attr, BoIdList_Filtered, Bo)
			end	
	end.



evaluate_AI_condition_right_base_values(Bo, AICond) ->
	case AICond#ai_cond.attr_R of
		?JDG_ATTR_NO_ATTR -> % 无属性则固定为[0]
			[0];
		?JDG_ATTR_CUR_ROUND ->
			[lib_bt_comm:get_cur_round()];
		{?JDG_ATTR_REMAINDER_OF_CUR_ROUND_DIV_BY_N, N} ->
			?ASSERT(util:is_positive_int(N), N),
			CurRound = lib_bt_comm:get_cur_round(),
			[CurRound rem N];
		Attr ->
			% 筛选出判定主体（bo列表）
			Rules = AICond#ai_cond.rules_filter_bo_R,
			case filter_bo_by_rules(Bo, Rules) of
				[] -> % 无主体则返回[0]
					[0];
				BoIdList_Filtered ->
					evaluate_AI_condition_base_values(Attr, BoIdList_Filtered, Bo)
			end	
	end.






%% 按规则筛选bo
filter_bo_by_rules(Actor, RuleList) ->
	AllBoIdList = lib_bt_comm:get_all_bo_id_list(),
	filter_bo_by_rules__(Actor, RuleList, AllBoIdList).
	
filter_bo_by_rules__(_Actor, [], SrcBoIdList) ->
	SrcBoIdList;
filter_bo_by_rules__(Actor, [Rule | T], SrcBoIdList) ->
	case lib_bt_misc:filter_bo_by_rule(Rule, Actor, SrcBoIdList) of
		[] ->
			[];
		SrcBoIdList2 ->
			?ASSERT(is_list(SrcBoIdList2), {SrcBoIdList2, Rule}),
			filter_bo_by_rules__(Actor, T, SrcBoIdList2)
	end.






evaluate_AI_condition_base_values(?JDG_ATTR_IS_MY_ALLY, BoIdList, Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			Bool = (lib_bo:get_side(Bo) == lib_bo:get_side(Actor)),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_IS_MY_ENEMY, BoIdList, Actor) ->
	MySide = lib_bo:get_side(Actor),
	EnemySide = lib_bt_comm:to_enemy_side(MySide),
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			Bool = (lib_bo:get_side(Bo) == EnemySide),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_IS_UNDEAD, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bool = lib_bt_comm:is_living(BoId),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_IS_DEAD, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bool = lib_bt_comm:is_dead(BoId),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_IS_GHOST, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			Bool = lib_bo:in_ghost_status(Bo),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_IS_FALLEN, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			Bool = lib_bo:in_fallen_status(Bo),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_HAS_INVISIBLE_EFF, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			Bool = lib_bo:is_invisible(Bo),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_HAS_NOT_INVISIBLE_EFF, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			Bool = not lib_bo:is_invisible(Bo),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_IS_INVISIBLE_TO_ME, BoIdList, Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			Bool = lib_bo:is_invisible(Bo) andalso (not lib_bo:can_anti_invisible(Actor)),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_IS_NOT_INVISIBLE_TO_ME, BoIdList, Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			Bool = (not lib_bo:is_invisible(Bo)) orelse lib_bo:can_anti_invisible(Actor),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_LV, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_lv(Bo)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_CUR_HP, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_hp(Bo)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_CUR_MP, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_mp(Bo)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_CUR_ANGER, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_anger(Bo)
		end,
	[F(X) || X <- BoIdList];


evaluate_AI_condition_base_values(?JDG_ATTR_PHY_ATT, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_phy_att(Bo)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_MAG_ATT, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_mag_att(Bo)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_PHY_DEF, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_phy_def(Bo)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_MAG_DEF, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_mag_def(Bo)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_ACT_SPEED, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_act_speed(Bo)
		end,
	[F(X) || X <- BoIdList];


evaluate_AI_condition_base_values(?JDG_ATTR_SEAL_HIT, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_seal_hit(Bo)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_SEAL_RESIS, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_seal_resis(Bo)
		end,
	[F(X) || X <- BoIdList];

% 当前血量的百分比，返回四舍五入取整后的分子（如：若是5%，则返回5，若是5.2%，则返回5，若是5.6%，则返回6）
evaluate_AI_condition_base_values(?JDG_ATTR_CUR_HP_PERCENTAGE, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			CurVal = lib_bo:get_hp(Bo),
			ValLim = lib_bo:get_hp_lim(Bo),
			?ASSERT(CurVal =< ValLim, {CurVal, ValLim, Bo}),
			erlang:round(CurVal * 100 / ValLim)
		end,
	[F(X) || X <- BoIdList];

% 当前蓝量的百分比，返回四舍五入取整后的分子
evaluate_AI_condition_base_values(?JDG_ATTR_CUR_MP_PERCENTAGE, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			CurVal = lib_bo:get_mp(Bo),
			ValLim = lib_bo:get_mp_lim(Bo),
			?ASSERT(CurVal =< ValLim, {CurVal, ValLim, Bo}),
			erlang:round(CurVal * 100 / ValLim)
		end,
	[F(X) || X <- BoIdList];

% 当前怒气的百分比，返回四舍五入取整后的分子
evaluate_AI_condition_base_values(?JDG_ATTR_CUR_ANGER_PERCENTAGE, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			CurVal = lib_bo:get_anger(Bo),
			ValLim = lib_bo:get_anger_lim(Bo),
			?ASSERT(CurVal =< ValLim, {CurVal, ValLim, Bo}),
			erlang:round(CurVal * 100 / ValLim)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values({?JDG_ATTR_HAS_SPEC_NO_BUFF, BuffNo}, BoIdList, _Actor) ->
	?ASSERT(util:is_positive_int(BuffNo), BuffNo),
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			Bool = lib_bo:has_spec_no_buff(Bo, BuffNo),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values({?JDG_ATTR_HAS_SPEC_CATEGORY_BUFF, Category}, BoIdList, _Actor) ->
	?ASSERT(util:is_positive_int(Category), Category),
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			Bool = lib_bo:has_spec_category_buff(Bo, Category),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values({?JDG_ATTR_HAS_SPEC_EFF_TYPE_BUFF, EffType}, BoIdList, _Actor) ->
	?ASSERT(EffType == good orelse EffType == bad orelse EffType == neutral, EffType),
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			Bool = lib_bo:has_spec_eff_type_buff(Bo, EffType),
			util:bool_to_oz(Bool)
		end,
	[F(X) || X <- BoIdList];

% evaluate_AI_condition_base_values(?JDG_ATTR_CUR_ROUND, _BoIdList, _Actor) ->
% 	[lib_bt_comm:get_cur_round()];

% evaluate_AI_condition_base_values({?JDG_ATTR_REMAINDER_OF_CUR_ROUND_DIV_BY_N, N}, _BoIdList, _Actor) ->
% 	?ASSERT(util:is_positive_int(N), N),
% 	CurRound = lib_bt_comm:get_cur_round(),
% 	[CurRound rem N];

evaluate_AI_condition_base_values(?JDG_ATTR_MON_NO, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			case lib_bt_comm:is_monster(Bo) of
				true ->
					lib_bo:get_parent_obj_id(Bo);
				false ->
					0     % 非怪物则固定取0
			end
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_POS, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bt_misc:server_logic_pos_to_cfg_pos(lib_bo:get_pos(Bo)) % 注意：需对应转为策划所认为的站位
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_FILTERED_BO_COUNT, BoIdList, _Actor) ->
	[length(BoIdList)];

evaluate_AI_condition_base_values({?JDG_ATTR_IS_CAN_USE_SKILL, SkillId}, BoIdList, _Actor) ->
	?ASSERT(util:is_positive_int(SkillId), SkillId),
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			case lib_bo:can_use_skill(Bo, SkillId) of
				true -> 1;
				{false, _Reason} -> 0
			end
		end,
	[F(X) || X <- BoIdList];


evaluate_AI_condition_base_values(?JDG_ATTR_ROUND_COUNT_SINCE_SPAWNED, BoIdList, _Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bt_comm:get_cur_round() - lib_bo:get_when_spawn_round(Bo) + 1
		end,
	[F(X) || X <- BoIdList];


evaluate_AI_condition_base_values(?JDG_ATTR_DIFF_BETWEEN_MY_PHY_ATT_AND_TARGET_PHY_DEF, BoIdList, Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_phy_att(Actor) - lib_bo:get_phy_def(Bo)
		end,
	[F(X) || X <- BoIdList];

evaluate_AI_condition_base_values(?JDG_ATTR_DIFF_BETWEEN_MY_MAG_ATT_AND_TARGET_MAG_DEF, BoIdList, Actor) ->
	F = fun(BoId) ->
			Bo = get_bo_by_id(BoId),
			lib_bo:get_mag_att(Actor) - lib_bo:get_mag_def(Bo)
		end,
	[F(X) || X <- BoIdList];


evaluate_AI_condition_base_values(_JdgAttr, _BoIdList, _Actor) ->
	?ASSERT(false, {_JdgAttr, _BoIdList, _Actor}),
	erlang:error({unknown_jdg_attr, _JdgAttr}).
	












decide_which_AI_to_pick(AIList) ->
	% 按优先级排序
	AIList2 = sort_AI_by_prio_desc(AIList),

	HighestPrioAI = erlang:hd(AIList2),
	HighestPrio = HighestPrioAI#bo_ai.priority,
	AIList3 = [X || X <- AIList2, X#bo_ai.priority == HighestPrio],

	decide_which_AI_to_pick_by_weight(AIList3).



%% 按权重做圆桌理论的随机挑选
decide_which_AI_to_pick_by_weight(AIList) ->
	TotalWeight = max(calc_total_AI_weight(AIList), 1),  % max矫正是为了容错
	Rand = util:rand(1, TotalWeight),
	decide_which_AI_to_pick_by_weight__(AIList, Rand, 0).


decide_which_AI_to_pick_by_weight__([CurAI | T], RandWeight, SumWeightToCmp) ->
	?ASSERT(util:is_positive_int(CurAI#bo_ai.weight), CurAI),
	SumWeightToCmp_2 = SumWeightToCmp + CurAI#bo_ai.weight,
	case RandWeight =< SumWeightToCmp_2 of
		true ->
			CurAI;
		false ->
			decide_which_AI_to_pick_by_weight__(T, RandWeight, SumWeightToCmp_2)
	end;
decide_which_AI_to_pick_by_weight__([], _RandWeight, _SumWeightToCmp) ->
    ?ASSERT(false, {_RandWeight, _SumWeightToCmp}),
    null.  % 正常逻辑不会触发此分支，返回null以容错！



	

calc_total_AI_weight(AIList) ->
	F = fun(AI, SumWeight) ->
			?ASSERT(AI#bo_ai.weight > 0, AI),
			SumWeight + AI#bo_ai.weight
		end,
	lists:foldl(F, 0, AIList).




%% 按优先级降序排序AI
sort_AI_by_prio_desc(AIList) ->
	F = fun(AI_1, AI_2) ->
			is_higher(AI_1, AI_2)
		end,
	lists:sort(F, AIList).




%% AI_1是否比AI_2更高级？
is_higher(AI_1, AI_2) ->
	AI_1#bo_ai.priority > AI_2#bo_ai.priority.












%% 检测AI的行为目标
check_AI_action_targets(Bo, AINo) ->
	AI = get_cfg_data(AINo),

	case AI#bo_ai.action_content of
		?AI_CONT_DEFEND ->
			ok;
		{?AI_CONT_ESCAPE, _Proba} ->
			ok;
		{?AI_CONT_SUMMON_MON, _MonL } -> ok;

		{?AI_CONT_TALK, _, _} ->
			ok;
		_ ->
			case decide_AI_action_targets(Bo, AI) of
				[] ->
					fail;
				_TarBoIdList ->
					ok
			end		
	end.

			



% mon_prepare_cmd_by_default_AI(MonBoId) ->
% 	?BT_LOG(io_lib:format("mon_prepare_cmd_by_default_AI()... MonBoId:~p~n", [MonBoId])),
% 	AI = #bo_ai{
% 	        no = 0,   % dummy AI number
% 	        priority = 1,
% 	        weight = 1,
% 	        rules_filter_action_target = [?RDT_ENEMY_SIDE, ?RDT_UNDEAD],
% 	        action_content = ?AI_CONT_DO_NORMAL_ATT,
% 	        condition_list = []
% 	        },
% 	do_prepare_cmd_by_spec_AI(MonBoId, AI).



%% 按指定的AI下达指令
do_prepare_cmd_by_spec_AI(BoId, AI) ->
	Bo = get_bo_by_id(BoId),
	% % 判定ai的行为目标
	% case decide_AI_action_targets(Bo, AI) of
	% 	[] ->
	% 		lib_bo:prepare_default_cmd(BoId);
	% 	TarBoIdList ->


			TarBoIdList = decide_AI_action_targets(Bo, AI),

			?ASSERT(is_list(TarBoIdList), TarBoIdList),

			% case more_decide_AI_action_targets_by_content(TarBoIdList, Bo, AI#bo_ai.action_content) of
			% 	[] ->

			% 	TarBoIdList2 ->

			% end

			ActionContent = AI#bo_ai.action_content,
			do_prepare_cmd_by_spec_AI(ActionContent, Bo, TarBoIdList).

	% end.



%% 选定ai的行为目标列表
decide_AI_action_targets(Bo, AI) ->
	Rules = AI#bo_ai.rules_filter_action_target,
	filter_bo_by_rules(Bo, Rules).




%% 刷出剧情bo
add_bo(FromBMonNo, Pos) ->
	case lib_bt_misc:add_one_monster(FromBMonNo, ?GUEST_SIDE, Pos, []) of
		fail ->
			skip;
		{ok, NewBo} ->
			NewBo2 = lib_bo:init_tmp_rand_act_speed( lib_bo:id(NewBo) ),  % 初始化乱敏
			case lib_bt_comm:get_cur_round() of
				1 ->  % 在战斗开始时刷出，不主动通知客户端
					skip;
				_ ->
					lib_bt_send:notify_cli_new_bo_spawned(NewBo2)
			end
	end.

% 召唤怪物
do_prepare_cmd_by_spec_AI({?AI_CONT_SUMMON_MON,MonL}, Bo, _TarBoIdList) ->
	lib_bo:prepare_cmd_summon_mon( lib_bo:id(Bo), MonL);
	% F = fun({FromBMonNo, Pos},_) ->
	% 	% add_bo(FromBMonNo,Pos)
	% end,
	% lists:foldl(F,0,MonL);



do_prepare_cmd_by_spec_AI(?AI_CONT_DO_NORMAL_ATT, Bo, TarBoIdList) ->
	TarBoId = list_util:rand_pick_one(TarBoIdList),
	?BT_LOG(io_lib:format("do_prepare_cmd_by_spec_AI()... BoId:~p, TarBoIdList:~w, TarBoId:~p~n", [lib_bo:id(Bo), TarBoIdList, TarBoId])),
    lib_bo:prepare_cmd_normal_att( lib_bo:id(Bo), TarBoId);

do_prepare_cmd_by_spec_AI({?AI_CONT_USE_SKILL, SkillId}, Bo, TarBoIdList) ->
	?ASSERT(mod_skill:is_valid_skill_id(SkillId), SkillId),
	% 稳妥起见，判断是否有该技能
	case lib_bo:has_initiative_skill(Bo, SkillId) of
		true ->
			TarBoId = list_util:rand_pick_one(TarBoIdList),
			lib_bo:prepare_cmd_use_skill( lib_bo:id(Bo), SkillId, TarBoId);
		false ->
			?ASSERT(false, {SkillId, Bo}),
			lib_bo:prepare_default_cmd( lib_bo:id(Bo) ) % 做容错，转为默认的指令
	end;

do_prepare_cmd_by_spec_AI(?AI_CONT_PROTECT_OTHERS, Bo, TarBoIdList) ->
	TarBoId = list_util:rand_pick_one(TarBoIdList),
	% 稳妥起见，判断是否可以保护
	case check_protect(Bo, TarBoId) of
		ok ->
			lib_bo:prepare_cmd_protect_others( lib_bo:id(Bo), TarBoId);
		fail ->
			?ASSERT(false, {TarBoId, TarBoIdList, Bo}),
			lib_bo:prepare_default_cmd( lib_bo:id(Bo) ) % 做容错，转为默认的指令
	end;

do_prepare_cmd_by_spec_AI({?AI_CONT_ESCAPE, Proba}, Bo, _TarBoIdList) ->
	?ASSERT(util:is_positive_int(Proba), Proba),
	BoId = lib_bo:id(Bo),
	lib_bo:set_tmp_force_escape_success_proba(BoId, Proba),
	lib_bo:prepare_cmd_escape(BoId);

do_prepare_cmd_by_spec_AI(?AI_CONT_DEFEND, Bo, _TarBoIdList) ->
	lib_bo:prepare_cmd_defend( lib_bo:id(Bo)).








	



%% 检测是否可以保护目标
check_protect(Protector, TargetBoId) ->
    case get_bo_by_id(TargetBoId) of
    	null -> fail;
    	TargetBo ->
    		case TargetBoId == lib_bo:id(Protector) of
    			true -> fail;
    			false ->
    				case lib_bo:get_side(TargetBo) /= lib_bo:get_side(Protector) of
    					true -> fail;
    					false -> ok
    				end
    		end
    end.

    

    



















% %% 怪物选择技能
% monster_sel_skill(Bo) ->
% 	?ASSERT(is_monster(Bo), Bo),
% 	?DEBUG_MSG("monster_sel_skill(), cur turn: ~p", [get_cur_turn_index()]),
% 	case get_eq_skill_list(Bo) of
% 		[] -> % 没有其他技能则用默认的出生技
% 			?DEBUG_MSG("monster_sel_skill(), monster sel born skill", []),
% 			sel_born_skill(Bo);
% 		EqSkillList ->
% 			% 遍历，选第一个可使用的技能
% 			case get_monster_first_can_use_skill(Bo, EqSkillList) of
% 				null ->
% 					?DEBUG_MSG("monster_sel_skill(), monster sel born skill", []),
% 					sel_born_skill(Bo);
% 				SklBrief ->
% 					?DEBUG_MSG("monster_sel_skill() : ~w", [SklBrief]),
% 					?ASSERT(is_record(SklBrief, skl_brief)),
% 					NewBo = Bo#battle_obj{cur_skill = SklBrief},
% 					put(Bo#battle_obj.bo_id, NewBo)
% 			end
% 	end.


% %% 临时简单AI选择技能（目前主要用于离线bo） ———— 若可以放装备的第1个必杀技，就放，否则就在装备的普通技里随机选一个
% %% TODO：AI还有待完善（策划也暂时还没完全确定好这部分的AI规则）
% tmp_AI_sel_skill(Bo) ->
% 	BoId = Bo#battle_obj.bo_id,
% 	?DEBUG_MSG("tmp_AI_sel_skill(), boid: ~p", [BoId]),
% 	case is_sequence_use_skill(Bo) of
% 		false ->   % 不是按顺序使用技能
% 			% 是否可以放第一个必杀技？
%             case battle_util:is_can_use_first_stunt(Bo) of
%                 true ->
%                     Bo2 = Bo#battle_obj{cur_skill = Bo#battle_obj.first_stunt},
%                     put(BoId, Bo2);
%                 false ->
%                 	% 不能放第一个必杀技，则随机选一个普通技来用
%                     SelSkill = rand_sel_normal_skill(Bo),
%                     Bo2 = Bo#battle_obj{cur_skill = SelSkill},
%                     put(BoId, Bo2)
%             end;
% 		true -> % 按顺序使用技能（目前，剧情CG战斗中的武将，就是按这样来）
%             Bo2 = sequence_sel_skill(Bo),
% 			put(BoId, Bo2)
% 	end.
	
	


% %% am: auto mf（自动打怪，引申为自动挂机的意思）
% %%is_am_skill_comb_empty(Bo) -> 
% %%	Bo#battle_obj.am_skill_comb == [].
	

	
	

% %% 从挂机技能组合中获取当前使用的技能id
% %% @return: 0 | 技能id
% %% am: auto mf（自动打怪）
% %%get_cur_skill_from_am_skill_comb(Bo) -> 
% %%	case is_am_skill_comb_empty(Bo) of
% %%		true ->
% %%			0;
% %%		false ->
% %%			CurIdx = Bo#battle_obj.am_cur_skill_idx,
% %%			SkillComb = Bo#battle_obj.am_skill_comb,
% %%			?ASSERT(CurIdx =< length(SkillComb), {CurIdx, SkillComb, Bo}),
% %%			lists:nth(CurIdx, SkillComb)
% %%	end.


% %% 选择普通攻击
% sel_born_skill(Bo) ->
% 	NewBo = Bo#battle_obj{cur_skill = Bo#battle_obj.born_skill},
% 	put(Bo#battle_obj.bo_id, NewBo).
	

% %% 选择职业的第一个主动技
% sel_career_first_skill(Bo) ->
% 	?ASSERT(Bo#battle_obj.career_first_skill /= none, Bo),
% 	NewBo = Bo#battle_obj{cur_skill = Bo#battle_obj.career_first_skill},
% 	put(Bo#battle_obj.bo_id, NewBo).
		

% %%auto_mf_player_default_AI_for_sel_skill(Bo) ->
% %%	%%case normal——skl为空 of
% %%	%%			true ->
% %%	%%				cur——skill = 普通攻击
% %%	%%			false ->
% %%	%%				cur_skill = 职业的第一个主动技
% %%	%%		end
% %%	
% %%	%%case Bo#battle_obj.normal == [] of %% normal——skl为空 of
% %%	case Bo#battle_obj.career_first_skill == none of
% %%		true ->
% %%			sel_born_skill(Bo);  %%cur——skill = 选普通攻击
% %%		false ->
% %%			%% cur_skill = 选职业的第一个主动技
% %%			sel_career_first_skill(Bo)		
% %%	end.



	
	
	
% %% 递增bo的am_cur_skill_idx字段
% %% @return: 更新后的bo
% %%incr_am_cur_skill_idx(Bo) ->
% %%	?ASSERT(is_player(Bo), Bo),
% %%	NewIdx = Bo#battle_obj.am_cur_skill_idx + 1,
% %%	NewIdx2 = 	case NewIdx > ?MAX_SKILL_IN_COMB of
% %%					true -> % 自增到超过上限则重新回归到1
% %%						1;
% %%					false ->
% %%						NewIdx
% %%			  	end,
% %%	Bo#battle_obj{am_cur_skill_idx = NewIdx2}.
	

% %% 自动挂机的玩家依据AI选择技能
% %%auto_mf_player_auto_sel_skill(Bo) ->
% %%	?ASSERT(is_player(Bo)),
% %%	case is_sequence_use_skill(Bo) of
% %%		false ->
% %%			auto_mf_player_default_AI_for_sel_skill(Bo);
% %%		true ->
% %%			case get_cur_skill_from_am_skill_comb(Bo) of
% %%				0 ->
% %%					auto_mf_player_default_AI_for_sel_skill(Bo);
% %%				SkillId ->
% %%					SkillLv = get_bo_skill_lv(Bo, SkillId),
% %%					% 是否可以使用技能组合中的第idx个技能？
% %%					case check_can_use_skill(Bo, SkillId, SkillLv) of
% %%						true ->
% %%							% 更新cur_skill为当前idx的技能
% %%							NewCurSkill = {SkillId, SkillLv, ?GRID_0, ?CAN_USE},
% %%							NewBo = Bo#battle_obj{cur_skill = NewCurSkill},
% %%							% idx递增1
% %%							NewBo2 = incr_am_cur_skill_idx(NewBo),
% %%							put(Bo#battle_obj.bo_id, NewBo2);
% %%						false ->
% %%							%%is_seq——use——skill标记变为false
% %%							%%skill idx = 1, % 重置为1，从头开始
% %%							NewBo = Bo#battle_obj{is_sequence_use_skill = false, am_cur_skill_idx = 1},
% %%							auto_mf_player_default_AI_for_sel_skill(NewBo)
% %%					end
% %%			end
% %%	end.







% %% 自动挂机AI选择技能
% auto_mf_AI_sel_skill(Bo) ->
% 	AMSkillIdList = Bo#battle_obj.am_skill_id_list,
% 	case AMSkillIdList == [] of
% 		true ->
% 			?DEBUG_MSG("auto_mf_AI_sel_skill(), boid: ~p, AMSkillIdList is []", [Bo#battle_obj.bo_id]),
% 			simple_default_AI_sel_skill(Bo);
% 		false -> % 遍历AMSkillIdList，选择第一个可用的
% 			case get_first_can_use_am_skill(Bo) of
% 				null ->
% 					?DEBUG_MSG("auto_mf_AI_sel_skill(), boid: ~p, first can use am skill is null", [Bo#battle_obj.bo_id]),
% 					simple_default_AI_sel_skill(Bo);
% 				{SkillId, SkillLv} ->
% 					?DEBUG_MSG("auto_mf_AI_sel_skill(), boid: ~p, first can use am skill: ~p", [Bo#battle_obj.bo_id, {SkillId, SkillLv}]),
% 					NewCurSkill = to_skill_brief({SkillId, SkillLv}),
% 					NewBo = Bo#battle_obj{cur_skill = NewCurSkill},
% 					put(Bo#battle_obj.bo_id, NewBo)
% 			end
% 	end.	










% %% ============================================ Local Functions =============================================================	


% %% 随机选取普通技能中的一个（如果有已装备的普通技，则从中随机选一个，否则选取出生技（即普通攻击））
% %% @return: skl_brief结构体
% rand_sel_normal_skill(Bo) ->
%     case get_eq_normal_skill_list(Bo) of
%         [] ->
%         	Bo#battle_obj.born_skill;
%         L ->
%         	RandNum = util:rand(1, length(L)),
%         	lists:nth(RandNum, L)
%     end.
    
    

% %% 按顺序选择下一个技能，选到最后则会循环从头开始选（注意：直接选取，不检查是否满足使用技能的条件）
% %% @return: 更新后的bo
% sequence_sel_skill(Bo) ->
% 	case Bo#battle_obj.skill == [] of
% 		true -> % 没有装备任何技能则用出生技（普通攻击）
% 			Bo#battle_obj{cur_skill = Bo#battle_obj.born_skill};
% 		false ->
% 			BoId = Bo#battle_obj.bo_id,
%     		OldSeqIdx = get({seq_use_skill_index, BoId}),
%     		CurSeqIdx =	if
%     						OldSeqIdx == undefined ->
%     							1;
%     						OldSeqIdx < length(Bo#battle_obj.skill) ->
%     							OldSeqIdx + 1;
%     						true -> % 循环，从头开始
%     							1
%     					end,
%     		put({seq_use_skill_index, BoId}, CurSeqIdx), % 更新
%     		SklBrief = lists:nth(CurSeqIdx, Bo#battle_obj.skill),
%     		Bo#battle_obj{cur_skill = SklBrief}
% 	end.
	    	


% %% 默认简单AI选择技能（如果有职业的第一个主动技，则使用它，否则，使用普通攻击）
% simple_default_AI_sel_skill(Bo) ->
% 	case Bo#battle_obj.career_first_skill == none of
% 		true ->
% 			sel_born_skill(Bo);  % 选普通攻击
% 		false ->
% 			sel_career_first_skill(Bo) % 选职业的第一个主动技	
% 	end.
	
	

% %% 遍历bo的自动挂机所使用的技能id列表，获取第一个可使用的技能
% %% @return: null | {SkillId, SkillLv}
% get_first_can_use_am_skill(Bo) ->
% 	AMSkillIdList = Bo#battle_obj.am_skill_id_list,
% 	try_get_first_can_use_am_skill(AMSkillIdList, Bo).

% try_get_first_can_use_am_skill([], _Bo) ->
% 	null;	
% try_get_first_can_use_am_skill([SkillId | T], Bo) ->
% 	SkillLv = get_bo_skill_lv(Bo, SkillId),
% 	case check_can_use_skill(Bo, SkillId, SkillLv) of
% 		true ->
% 			{SkillId, SkillLv};
% 		false ->
% 			try_get_first_can_use_am_skill(T, Bo)
% 	end.
	
	



% %% 选取怪物可以使用的第一个技能
% %% @return: null | skl_brief结构体
% get_monster_first_can_use_skill(_Bo, []) ->
% 	null;
% get_monster_first_can_use_skill(Bo, [EqSkill | T]) ->
% 	?ASSERT(is_monster(Bo), Bo),
	
% 	% 注意：虽然EqSkill是skl_brief结构体，但这里应该获取动态的技能简要信息，原因见get_bo_skill_brief()函数的说明
% 	SklBrief = get_bo_skill_brief(Bo, EqSkill#skl_brief.id),
% 	?ASSERT(SklBrief /= null, {Bo, EqSkill#skl_brief.id}),
	
% 	case check_monster_can_use_skill(Bo, SklBrief) of
% 		true ->
% 			SklBrief;
% 		false ->
% 			get_monster_first_can_use_skill(Bo, T)
% 	end.



% check_monster_can_use_skill(_Bo, SklBrief) ->
% 	CurTurnIdx = get_cur_turn_index(),
	
% 	% 判断是否满足：起始使用回合数
% 	case CurTurnIdx >= SklBrief#skl_brief.start_turn of
% 		false ->
% 			false;
% 		true ->
% 			% 判断是否满足：每xx回合才使用一次
% 			?ASSERT(is_integer(CurTurnIdx), CurTurnIdx),
% 			?ASSERT(SklBrief#skl_brief.every_xx_turn /= 0, _Bo),
% 			case (CurTurnIdx rem SklBrief#skl_brief.every_xx_turn) == 0 of
% 				false ->
% 					false;
% 				true ->
% 					% 判断技能cd
% 					case CurTurnIdx >= SklBrief#skl_brief.cd_finish_turn of
% 						false ->
% 							false;
% 						true ->
% 							% 判定使用概率
% 							case decide_proba_once(SklBrief#skl_brief.proba) of
% 								fail ->
% 									false;
% 								success ->
% 									true
% 							end
% 					end
% 			end
% 	end.
% 	