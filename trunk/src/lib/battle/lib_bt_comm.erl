%%%-------------------------------------- 
%%% @Module: lib_bt_comm
%%% @Author: huangjf
%%% @Created: 2012.5.15
%%% @Description: 战斗系统相关的模块共用的一些小型接口
%%%               !!!!!需特别注意：部分接口会直接被import到战斗系统相关的模块中!!!!!
%%%-------------------------------------- 

-module(lib_bt_comm).
-export([
		get_battle_state/0,
        set_battle_state/1,

        get_battle_id/0,

        get_plot_no/1,

        is_battle_obj_rd/1,
		
		is_cross_3v3_battle/1,
		
		is_cross_3v3_battle_robot/1,

		get_bo_by_id/1,
		get_bo_by_pos/2,
		get_bo_by_player_id/1,
		get_bo_by_partner_id/1,

		update_bo/1,

		get_bo_id_list/1, set_bo_id_list/2,
    get_other_bo_id_list/1,
		get_all_bo_id_list/0,
		get_bo_count/1,
		get_all_bo_count/0,
get_otherside_living_bo_count/1,
get_myside_living_bo_count/1,

		get_all_player_bo_list/0,

		get_all_online_player_bo_id_list/0,

		get_all_online_living_player_bo_list/0,

		get_all_online_player_bo_list/0,

		is_pos_empty/2,
		is_pos_occupied/2,

		can_attack/2,
		can_attack/3,

		get_player_bo_list/1,
		get_player_bo_id_list/1,
		get_player_bo_id_list_except_hired_player/1,
		get_online_player_bo_id_list/1,
		get_living_player_bo_id_list/1,
		get_living_player_bo_id_list_except_hired_player/1,
		get_online_player_bo_id_list_except_hired_player/1,
        get_mon_bo_id_list/1,
        
		get_player_id_list_except_hired_player/1,
		get_hired_player_id_list/1,

		is_PVE_battle/1,
		is_PVP_battle/1,
		is_start_battle_side/1,
		is_mf_battle/1,
		is_normal_mf_battle/1,
		is_world_boss_mf_battle/1,
		is_melee_mf_battle/1,
		is_tve_mf_battle/1,
		is_force_pk_battle/1,
		is_offline_arena_battle/1,
		is_hijack_battle/1,
		is_1v1_online_arena_battle/1,
		is_qiecuo_pk_battle/1,
		is_guild_pk_battle/1,
		is_melee_pk_battle/1,
		is_melee_battle/1,
        is_3v3_online_arena_battle/1,

		is_player/1, is_hired_player/1,
		is_partner/1,
		is_main_partner/1, is_deputy_partner/1,
		is_monster/1,
		is_boss/1,
		is_normal_boss/1,
		is_world_boss/1,
		is_npc/1,
		is_plot_bo/1,

		is_living/1,  % 考虑移到lib_bo模块中??
		is_dead/1,
		is_online/1, is_offline/1,
is_dead2/2,
        
        is_bo_exists/1,
        % is_living_player/1,
        is_online_player/1,
        is_offline_player/1,
        is_online_living_player/1,
        is_online_main_partner/1,
        is_offline_main_partner/1,
        
		to_enemy_side/1,
		get_cur_round/0,

        are_all_dead/1,
        are_all_just_back_to_battle/1,

        get_win_side/0,
        set_win_side/1,
         
        mark_battle_finish/0,
        is_battle_finish/0
	]).
    
-include("common.hrl").
-include("battle.hrl").
-include("record/battle_record.hrl").
-include("scene.hrl").




get_battle_state() ->
    BtlState = get(?KN_BATTLE_STATE),
    ?ASSERT(is_record(BtlState, btl_state)),
    BtlState.

set_battle_state(BtlState) when is_record(BtlState, btl_state) ->
    put(?KN_BATTLE_STATE, BtlState).


get_battle_id() ->
	(get_battle_state())#btl_state.id.


get_plot_no(BtlState) ->
	BtlState#btl_state.plot_no.



%% 是否为battle_obj结构体？
is_battle_obj_rd(R) ->
	is_record(R, battle_obj).





%% 更新bo到进程字典
update_bo(Bo_Latest) ->
    BoId = lib_bo:get_id(Bo_Latest),
    put(BoId, Bo_Latest),
    ok.





% %% 依据skl_brief获取技能配置数据
% get_skill_cfg_data(SklBrief) ->
% 	SkillId = SklBrief#skl_brief.id,
% 	SkillLv = SklBrief#skl_brief.lv,
% 	mod_skill:get_cfg_data(SkillId, SkillLv).

	



%% 标记战斗已结束
mark_battle_finish() ->
    State = get_battle_state(),
    set_battle_state(State#btl_state{is_finish = true}).
	

%% 判断战斗是否已结束
%% @return: true => 已结束； false => 未结束
is_battle_finish() ->
	BtlState = get_battle_state(),
	BtlState#btl_state.is_finish.


    
%% 获取获胜方（战斗结束后调用此接口才有意义，因为战斗结束前实际上是固定返回undefined）
%% @return:  undefined => 战斗未结束，还未分出胜负
%%           ?HOST_SIDE => 主队赢了，
%%           ?GUEST_SIDE => 客队赢了，
%%           ?NO_SIDE => 平局
get_win_side() ->
    % case get(battle_state) of
    %     undefined -> 
    %         none;
    %     BattleState ->
    %         BattleState#state.win_side
    % end.	

    State = get_battle_state(),
    ?TRACE("~nState in get_win_side(): ~p~n", [State]),
    State#btl_state.win_side.


%% 设置胜利方    
set_win_side(Side) ->
    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE orelse Side == ?NO_SIDE),
    State = get_battle_state(),
    set_battle_state(State#btl_state{win_side = Side}).






can_attack(BoId_A, BoId_B) ->
	can_attack__(BoId_A, BoId_B, false).


can_attack(BoId_A, BoId_B, strikeback) ->
	can_attack__(BoId_A, BoId_B, true).


%% 判断A是否可以攻击B
%% @para: IsStrikeBack => 此次攻击是否为反击
%% @return: true | false
can_attack__(BoId_A, BoId_B, IsStrikeBack) ->
	?ASSERT(is_bo_exists(BoId_A), BoId_A),

	% BoIdList_AlreadyAtted = lib_bo:get_bo_ids_already_attacked(A),

	case BoId_A == BoId_B of
		true -> 
			false; % 不能攻击自己
		false ->
			% 防守者是否存在？
			case get_bo_by_id(BoId_B) of
				null ->
					false;
				Bo_B ->
					case is_dead(Bo_B) of
						true ->
							false;  % 目标死了则不能攻击
						false ->
							% 防守者是否无法被攻击？
							case lib_bo:cannot_be_attacked(Bo_B) of
								true ->
									false;
								false ->
									Bo_A = get_bo_by_id(BoId_A),
									case (not IsStrikeBack) andalso lib_bo:is_already_attacked(Bo_A, BoId_B) of
										true ->
											false; % 此次不是反击，并且当前回合已经攻击过了
										false ->
											% 隐身效果是否达成？
											case lib_bo:is_invisible(Bo_B) andalso (not lib_bo:can_anti_invisible(Bo_A)) of
												true ->
													false;
												false ->
													% 其他条件检测
													% ...

													true
											end
									end
							end	
					end
			end
	end.

			

			

	




% %% 判断战斗对象是否装备了指定技能
% %% @return: true | false
% has_equipped_skill(Bo, SkillId) ->
% 	EqSkillList = get_eq_skill_list(Bo),
% 	case lists:keyfind(SkillId, ?SKLBRF_ID_FIELD_POS, EqSkillList) of
% 		false ->
% 			false;
% 		_SklBrief ->
% 			true
% 	end.


%% 判断某一方的bo是否全都死亡了
are_all_dead(Side) ->
    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE),
    BoIdList = get_bo_id_list(Side),
    are_all_dead__(BoIdList).

    % BoList = [get(X) || X <- BoIdList],
    % RetBool = ([dummy || Bo <- BoList, is_living(Bo)] == []),
    % RetBool.

are_all_dead__([BoId | T]) ->
	Bo = get_bo_by_id(BoId),
	case is_living(Bo) of
		true -> false;
		false -> are_all_dead__(T)
	end;
are_all_dead__([]) ->
	true.




	
%% 判断是否全都是（断线重连后）刚回归到战斗？
are_all_just_back_to_battle([BoId | T]) ->
	Bo = get_bo_by_id(BoId),
	case lib_bo:is_just_back_to_battle(Bo) of
		false -> false;
		true -> are_all_just_back_to_battle(T)
	end;
are_all_just_back_to_battle([]) ->
	true.
	



% %% 获取战斗对象的指定技能的简要信息
% %% 特别注意：应从battle_obj的src_skill_list字段中获取，因为技能信息（比如cd结束回合）的变化是统一只同步保存在该字段中!!
% %% @return: null | skl_brief结构体
% get_bo_skill_brief(Bo, SkillId) ->
% 	case is_bo_born_skill(Bo, SkillId) of
% 		true ->
% 			Bo#battle_obj.born_skill;
% 		false ->
% 			case lists:keyfind(SkillId, ?SKLBRF_ID_FIELD_POS, Bo#battle_obj.src_skill_list) of
% 				false ->
% 					null;
% 				SklBrief ->
% 					?ASSERT(is_record(SklBrief, skl_brief), SklBrief),
% 					SklBrief
% 			end
% 	end.
			

% %% 获取bo已装备的技能列表
% get_eq_skill_list(Bo) ->
% 	Bo#battle_obj.skill.
	

% %% 获取bo已装备的普通技能列表
% get_eq_normal_skill_list(Bo) ->
% 	EqSkillList = get_eq_skill_list(Bo),
% 	[X || X <- EqSkillList, lib_skill:is_normal_skill(X#skl_brief.id)].
	

		

% %% 同步技能信息的变化到bo的src_skill_list字段
% %% @return: 更新后的bo
% update_bo_skill_brief(Bo, SkillId, NewSklBrief) ->
% 	?ASSERT(is_record(NewSklBrief, skl_brief), NewSklBrief),
% 	?ASSERT(lists:keyfind(SkillId, ?SKLBRF_ID_FIELD_POS, Bo#battle_obj.src_skill_list) /= false, {SkillId, Bo}),
% 	NewSrcSklList = lists:keyreplace(SkillId, ?SKLBRF_ID_FIELD_POS, Bo#battle_obj.src_skill_list, NewSklBrief),
% 	Bo#battle_obj{src_skill_list = NewSrcSklList}.
	

% %% 判断技能是否是bo的出生技能
% %% @return: true | false
% is_bo_born_skill(Bo, SkillId) ->
%     SkillId == (Bo#battle_obj.born_skill)#skl_brief.id.
    


% %% 获取不同职业对应学习的第一个主动技
% get_first_skill_by_career(Career) ->
% 	case Career of
% 		?CAREER_TR ->  % 天刃
% 			11001;
% 		?CAREER_CHK -> % 长空
% 			12001;
% 		?CAREER_FL -> % 飞翎
% 			13001;
% 		?CAREER_SHL -> % 朔灵
% 			14001
% 	end.


% %% exports
% %% @desc: 判断战斗对象是否是先手值较高的一方
% %% @returns: true | false
% is_fight_order_factor_higher(BoId) ->
%     case get(BoId) of
%         undefined -> false;
%         Bo ->
%             case get(battle_state) of
%                 undefined -> false;
%                 State ->
%                     Bo#battle_obj.side == State#state.high_fight_order_side
%             end
%     end.
		
% %% exports  
% %% @desc: 计算伤害随机系数
% %% @returns: number()  
% get_dam_random_factor() ->
% 	(950 + random:uniform(100)) / 1000.

% %% exports  
% %% @desc: 判定一次攻击结果，主要用于决定本次攻击是否打到玩家或其他结果
% %% @returns: number()    0~4
% decide_attack_result(Nhit, Dodge, Crit, Blockb) ->
%     X = util:rand(1, 1000),
%     if  
%         X < Nhit ->
%             ?AR_NOHIT;  % 未命中（miss）
%         X < Nhit + Dodge ->
%             ?AR_DODGE;  % 闪避
%         X < Nhit + Dodge + Blockb ->
%             ?AR_BLOCK;  % 格挡
%         X < Nhit + Dodge + Blockb + Crit ->
%             ?AR_CRIT;   % 暴击
%         true ->
%             ?AR_NORMAL  % 普通攻击伤害
%     end.
	

% %% 从技能的即时效果列表查找指定的效果
% %% @return: null | 所查找的技能即时效果
% find_eff_from_skill_fx(SkillFx, ToSide, EffName) ->
% 	?ASSERT(ToSide == myside orelse ToSide == enemy orelse ToSide == dummy, ToSide),
% 	F = fun(SklFx) ->
% 			case SklFx of
% 				{ToSide1, EffName1, _EffValue, _Proba} ->
% 					ToSide1 == ToSide andalso EffName1 == EffName;
% 				{?EN_DECIDE_CAST_TARGET, _ToSide, _Type, _Count, _Proba} ->
% 					EffName == ?EN_DECIDE_CAST_TARGET;
% 				_Any ->
% 					false
% 			end
% 		end,
% 	case lists:filter(F, SkillFx) of
% 		[] ->
% 			null;
% 		[SkillFxFound] ->
% 			SkillFxFound;
% 		_Any -> % 表明技能配置表填写格式有误
% 			?ASSERT(false, _Any),
% 			null
% 	end.

	
	
% %% 判断是否属于剧情CG战斗	
% is_CG_battle(BattleState) ->
% 	BattleState#state.battle_sub_type == ?BAT_SUB_T_CG.
	

% %% 判断bo是否处于眩晕状态
% is_stunned(Bo) ->
% 	case lib_battle_buff:get_bo_buff_by_eff_name(Bo, ?EN_STUN) of
% 		[] ->
% 			false;
% 		[_StunBuff] ->
% 			true;
% 		_Any ->
% 			?ERROR_MSG("[BATTLE_ERR]is_stunned() ERR!!! _Any: ~p, bo: ~w", [_Any, Bo]),
% 			?ASSERT(false, {_Any, Bo}),
% 			false
% 	end.
	

% %% 判断bo是否处于被沉默（无法使用任何技能）状态
% is_silenced(Bo) ->
% 	case lib_battle_buff:get_bo_buff_by_eff_name(Bo, ?EN_SILENCE) of
% 		[] ->
% 			false;
% 		[_SilenceBuff | _] ->
% 			true;
% 		_Any ->
% 			?ERROR_MSG("is_silenced() ERR!!! _Any: ~p, bo: ~w", [_Any, Bo]),
% 			?ASSERT(false, {_Any, Bo}),
% 			false
% 	end.


% %% 判断是否必杀技
% %%is_stunt_skill(SkillData) ->
% %%	SkillData#ets_skill.type == ?SKL_T_STUNT.

% %% 判断是否追击技
% %%is_pursue_skill(SkillData) ->
% %%	SkillData#ets_skill.type == ?SKL_T_PURSUE.
	
	
% %% 判断是否合体技
% %%is_cooperate_skill(SkillData) ->
% %%	SkillData#ets_skill.type == ?SKL_T_COOPERATE.
	

% %% 判断技能的buff效果是否对boss无效
% is_buff_invalid_to_boss_skill(SkillData) ->
% 	SkillData#ets_skill.buff_invalid_to_boss == 1.
	
	
	
	
% %% 判断技能是否有对应的追击技
% has_following_skill(SkillData) ->
% 	SkillData#ets_skill.following_skill > 0.

% %% @desc: 判断是否有后续技能球
% has_skill_ball(SkillData) ->
%     (SkillData#ets_skill.data)#rd_skill_data.ball_end > 0.
	

% %% 获取技能所对应的追击技
% %% @returns: skillId( integer() )
% get_following_skill(SkillData) ->
% 	SkillData#ets_skill.following_skill.
	


is_online(Bo) ->
	Bo#battle_obj.is_online.

is_offline(Bo) ->
	not is_online(Bo).
	

	
% %% 判断战斗对象是否处于觉醒状态
% %% @return: true => 是； false => 否
% is_awake(Bo) -> 
% 	Bo#battle_obj.is_awake.


% %% 判断bo是否使用自动挂机的战斗AI
% %% 目前是：
% %%       武将固定返回true，
% %%       离线玩家、在线并自动战斗的玩家也返回true，
% %%       其余情况返回false， 以后可以根据具体情况再做调整
% %% @return: true | false
% is_use_auto_mf_AI(Bo) ->
% 	case is_player(Bo) of
% 		true ->
% 			(not is_online(Bo))
% 			orelse (is_online(Bo) andalso is_auto_battle(Bo));
% 		false ->
% 			is_partner(Bo)
% 	end.
	
	
    

	

	

% %% 是否按顺序使用技能
% is_sequence_use_skill(Bo) ->
% 	Bo#battle_obj.is_sequence_use_skill.	


% %% 判断战斗对象是否仍活着的玩家
is_living_player(Bo) ->
	is_player(Bo) andalso is_living(Bo). 

is_online_player(Bo) ->
	is_player(Bo) andalso is_online(Bo).

is_offline_player(Bo) ->
	is_player(Bo) andalso is_offline(Bo).


is_online_living_player(Bo) ->
	is_player(Bo) andalso is_online(Bo) andalso is_living(Bo).



is_online_main_partner(Bo) ->
	is_main_partner(Bo) andalso is_online(Bo).


is_offline_main_partner(Bo) ->
	is_main_partner(Bo) andalso is_offline(Bo).



% %% 判断战斗对象是否仍活着的武将
% is_living_partner(Bo) ->
% 	is_living(Bo) andalso is_partner(Bo).
	


%% 判断bo是否还活着
%% @return: true | false
is_living(BoId) when is_integer(BoId) ->
    case get_bo_by_id(BoId) of
        null ->
        	%%?ASSERT(false, BoId),
        	false;   % 不存在，则认为死了，返回false
        Bo ->
        	lib_bo:get_hp(Bo) > 0
    end;
is_living(Bo) when is_record(Bo, battle_obj) ->
    %%List = lib_chessboard:get_bo_grid_ojblist(Bo),
	%%Bo#battle_obj.hp > 0 andalso lists:member(Bo#battle_obj.bo_id, List).   % todo--简单起见，这里默认一个对象只占据一格，目前也是这样的

	lib_bo:get_hp(Bo) > 0.


%% 判断bo是否已死亡
is_dead(BoId) when is_integer(BoId) ->
	case get_bo_by_id(BoId) of
		null ->
			true;  % 目前某些bo（比如怪物）死亡后会被清掉， 故bo不存在时也认为是死了
		Bo ->
			not is_living(Bo)
	end;
	
is_dead(Bo) when is_record(Bo, battle_obj) ->
	not is_living(Bo).

%% 判断bo是否已死亡
is_dead2(BoId,_) when is_integer(BoId) ->
	case get_bo_by_id(BoId) of
		null ->
			true;  % 目前某些bo（比如怪物）死亡后会被清掉， 故bo不存在时也认为是死了
		Bo ->
			case lib_bo:get_cur_skill_cfg(Bo) of
				null ->
					not is_living(Bo);
				SkillCfgData ->
					case (not is_living(Bo)) of
						true ->
							case lib_bo:can_use_skill(Bo, SkillCfgData) of
								true ->   not lists:member(dead ,SkillCfgData#skl_cfg.special_state_can_use);
								{false, _Reason} -> true
							end;
						false ->
							false
					end
			end
	end;

is_dead2(Bo,_) when is_record(Bo, battle_obj) ->
	case lib_bo:get_cur_skill_cfg(Bo) of
		null ->
			not is_living(Bo);
		SkillCfgData ->
			case (not is_living(Bo)) of
				true ->
					not lists:member(dead ,SkillCfgData#skl_cfg.special_state_can_use);
				false ->
					false
			end
	end.



% %% 判断战斗对象是否已死亡
% is_dead(BoId) when is_integer(BoId) ->
% 	case get(BoId) of
% 		undefined -> true;
% 		Bo -> is_dead(Bo)
% 	end;
% is_dead(Bo) ->
% 	?ASSERT(is_record(Bo, battle_obj), Bo),
% 	not is_living(Bo).
	
	

%% 判断bo是否玩家
is_player(Bo) ->
	% Bo#battle_obj.type == ?OBJ_PLAYER.
	lib_bo:get_main_type(Bo) == ?OBJ_PLAYER.


%% 判断bo是否雇佣的玩家
is_hired_player(Bo) ->
	Bo#battle_obj.type == ?OBJ_HIRED_PLAYER.


%% 判断bo是否宠物
is_partner(Bo) ->
	Bo#battle_obj.type == ?OBJ_PARTNER.

%% 判断bo是否主宠
is_main_partner(Bo) ->
	RetBool = Bo#battle_obj.is_main_partner,
	?ASSERT(begin
				case RetBool of
					true -> is_partner(Bo); % 如果是主宠，那么必定也是宠物
					false -> true
				end
			end, Bo),
	RetBool.


%% 判断bo是否副宠
is_deputy_partner(Bo) ->
	is_partner(Bo) andalso (not is_main_partner(Bo)).


	
%% 判断bo是否怪物（注意：boss也认为属于怪物）
is_monster(Bo) ->
	Bo#battle_obj.type == ?OBJ_MONSTER
	orelse is_boss(Bo).



%% 判断bo是否boss
is_boss(Bo) ->
	is_normal_boss(Bo) orelse is_world_boss(Bo).
	

%% 判断bo是否普通boss
is_normal_boss(Bo) ->
	Bo#battle_obj.type == ?OBJ_NORMAL_BOSS.

%% 判断bo是否世界boss
is_world_boss(Bo) ->
	Bo#battle_obj.type == ?OBJ_WORLD_BOSS.


%% 判断bo是否NPC
is_npc(Bo) ->
	Bo#battle_obj.type == ?OBJ_NPC.
	

%% 判断是否为剧情bo
is_plot_bo(Bo) ->
	Bo#battle_obj.is_plot_bo.


% %% 获取左方或右方的第一个玩家对象
% %% @return: null | 玩家战斗对象
% get_first_player_bo(Side) ->
%     BoList = [get(X) || X <- lib_battle:get_dict_side_idlist(Side), is_player(get(X))],
%     case BoList == [] of
%         true ->
%             null;
%         false ->
%             [FirstPlayerBo | _T] = BoList,
%             FirstPlayerBo
%     end.

% %% exports
% %% @desc: 检测当前技能是不是随机攻击类型
% %% @returns: true | false
% is_rand_hit_skill(SkillId, SkillLv) ->
%     case data_skill:get(SkillId, SkillLv) of
%         [] -> false;
%         SkillInfo ->
%             SkillRdSeg = (SkillInfo#ets_skill.data)#rd_skill_data.segment,
%             SkillFx = SkillRdSeg#rd_skill_segment.fx,
%             find_eff_from_skill_fx(SkillFx, myside, random_hit_objs) =/= null
%     end.
% is_rand_hit_skill(SkillFx) ->
%     find_eff_from_skill_fx(SkillFx, myside, random_hit_objs) =/= null.

% % 判定一次概率是否成功
% % @return：success => 成功，fail => 失败
% decide_proba_once(0) -> fail;
% decide_proba_once(?PROBABILITY_BASE) -> success;   % Proba表示概率（概率基数为1000）
% decide_proba_once(Proba) ->
%     case random:uniform(?PROBABILITY_BASE) =< Proba of
%         true ->
%             success;
%         false ->
%             fail
%     end.





is_bo_exists(BoId) ->
	get_bo_by_id(BoId) /= null. 
	


% %% exports
% %% @desc: 初始化战斗信息时，在 battle_state 中设置先手值更高的一方的标记
% %% @returns: #battle_state{} | undefined
% set_fight_order_factor_flag(Flag) ->
%     set_fight_order_factor_flag(Flag, get(battle_state)).

% set_fight_order_factor_flag(_Flag, undefined) ->
%     undefined;
% set_fight_order_factor_flag(Flag, State) ->
%     ?ASSERT(Flag == l orelse Flag == r, Flag),
%     NewState = State#state{high_fight_order_side = Flag},
%     put(battle_state, NewState),
%     NewState.

% %% exports
% %% desc: 获取初始战斗角色的怒气值
% get_init_anger(Lv) when Lv =< 10 -> 30;
% get_init_anger(_) -> 0.

% %% exports
% %% desc: 获取初始战斗角色的觉醒值
% get_init_arousal(_, _PS) -> 0.  %%%%PS#player_status.arousal.



get_player_bo_list(Side) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
	BoIdList = get_bo_id_list(Side),
	BoList = [get_bo_by_id(X) || X <- BoIdList],
	[X || X <- BoList, is_player(X)].


%% 同上，但排除掉雇佣的玩家
get_player_bo_list_except_hired_player(Side) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
	BoIdList = get_bo_id_list(Side),
	BoList = [get_bo_by_id(X) || X <- BoIdList],
	[X || X <- BoList, is_player(X) andalso (not is_hired_player(X))].


get_hired_player_bo_list(Side) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
	BoIdList = get_bo_id_list(Side),
	BoList = [get_bo_by_id(X) || X <- BoIdList],
	[X || X <- BoList, is_hired_player(X)].



%% 获取左方或右方的玩家战斗对象id列表	
get_player_bo_id_list(Side) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
	BoIdList = get_bo_id_list(Side),
	[X || X <- BoIdList, is_player(get_bo_by_id(X))].


%% 同上，但排除掉雇佣的玩家
get_player_bo_id_list_except_hired_player(Side) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
	BoIdList = get_bo_id_list(Side),
	[X || X <- BoIdList, begin
							Bo_ = get_bo_by_id(X),
							is_player(Bo_) andalso (not is_hired_player(Bo_)) 
					   	 end].



%% 获取左方或右方的在线玩家战斗对象id列表
get_online_player_bo_id_list(Side) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
	BoIdList = get_bo_id_list(Side),
	[X || X <- BoIdList, is_online_player(get_bo_by_id(X))].


%% 获取左方或右方的未死亡玩家战斗对象id列表
get_living_player_bo_id_list(Side) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
	BoIdList = get_bo_id_list(Side),
	[X || X <- BoIdList, is_living_player(get_bo_by_id(X))].


%% 同上，但排除掉雇佣的玩家
get_living_player_bo_id_list_except_hired_player(Side) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
	BoIdList = get_bo_id_list(Side),
	[X || X <- BoIdList, begin 
							Bo = get_bo_by_id(X), 
							is_living_player(Bo) andalso (not is_hired_player(Bo))
						 end].

%% 获取左方或右方的在线玩家战斗对象id列表（排除掉雇佣的玩家）
get_online_player_bo_id_list_except_hired_player(Side) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
	BoIdList = get_bo_id_list(Side),
	[X || X <- BoIdList, begin 
							Bo = get_bo_by_id(X), 
							is_online_player(Bo) andalso (not is_hired_player(Bo))
						 end].

%% 获取左方或右方的怪物战斗对象id列表
get_mon_bo_id_list(Side) ->
    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
    BoIdList = get_bo_id_list(Side),
    [X || X <- BoIdList, begin
                            Bo_ = get_bo_by_id(X),
                            is_monster(Bo_) 
                         end].

%% 获取左方或右方的玩家id列表（排除掉雇佣的玩家），注意：是获取玩家id列表，而不是bo id列表！
get_player_id_list_except_hired_player(Side) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
	L = get_player_bo_list_except_hired_player(Side),
	[lib_bo:get_parent_obj_id(X) || X <- L].


%% 获取左方或右方的雇佣的玩家id列表，注意：是获取玩家id列表，而不是bo id列表！
get_hired_player_id_list(Side) ->
	?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),
	L = get_hired_player_bo_list(Side),
	?ASSERT(length(L) =< 1),  % 目前断言：一方最多只有一个雇佣的玩家
	[lib_bo:get_parent_obj_id(X) || X <- L].




%% 战斗是否属于PVE？
is_PVE_battle(R) when is_record(R, btl_state) ->
	R#btl_state.type == ?BTL_T_PVE;
is_PVE_battle(R) when is_record(R, btl_feedback) ->
	R#btl_feedback.battle_type == ?BTL_T_PVE.


%% 战斗是否属于PVP？
is_PVP_battle(R) when is_record(R, btl_state) ->
	R#btl_state.type == ?BTL_T_PVP;
is_PVP_battle(R) when is_record(R, btl_feedback) ->
	R#btl_feedback.battle_type == ?BTL_T_PVP.

% 是否是战斗发起队
is_start_battle_side(Feedback) when is_record(Feedback, btl_feedback) ->
	Feedback#btl_feedback.side =:= ?HOST_SIDE.



%% 战斗是否属于打怪？  ----- 目前只要是PVE，都认为是打怪
is_mf_battle(R) when is_record(R, btl_state) ->
	R#btl_state.type == ?BTL_T_PVE;
is_mf_battle(R) when is_record(R, btl_feedback) ->
	R#btl_feedback.battle_type == ?BTL_T_PVE.


%% 战斗是否为普通打怪？
is_normal_mf_battle(R) when is_record(R, btl_state) ->
	is_mf_battle(R) andalso R#btl_state.subtype == ?BTL_SUB_T_NORMAL_MF;
is_normal_mf_battle(R) when is_record(R, btl_feedback) ->
	is_mf_battle(R) andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_NORMAL_MF.



%% 战斗是否为打世界boss？
is_world_boss_mf_battle(R) ->
	R#btl_state.type == ?BTL_T_PVE
	andalso R#btl_state.subtype == ?BTL_SUB_T_WORLD_BOSS_MF.


%% 战斗是否为女妖乱斗活动打怪？
is_melee_mf_battle(R) when is_record(R, btl_state) ->
	is_mf_battle(R) andalso R#btl_state.subtype == ?BTL_SUB_T_MELEE_MF;
is_melee_mf_battle(R) when is_record(R, btl_feedback) ->
	is_mf_battle(R) andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_MELEE_MF.


%% 战斗是否三界副本打怪？
is_tve_mf_battle(R) when is_record(R, btl_state) ->
	is_mf_battle(R) andalso R#btl_state.subtype == ?BTL_SUB_T_TVE_MF;
is_tve_mf_battle(R) when is_record(R, btl_feedback) ->
	is_mf_battle(R) andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_TVE_MF.


%% 战斗是否属于强行pk？
is_force_pk_battle(R) when is_record(R, btl_state) ->
	R#btl_state.type == ?BTL_T_PVP
	andalso R#btl_state.subtype == ?BTL_SUB_T_PK_FORCE;
is_force_pk_battle(R) when is_record(R, btl_feedback) ->
	R#btl_feedback.battle_type == ?BTL_T_PVP
	andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_PK_FORCE.



%% 战斗是否属于离线竞技场战斗？
is_offline_arena_battle(R) when is_record(R, btl_state) ->
	R#btl_state.type == ?BTL_T_PVP
	andalso R#btl_state.subtype == ?BTL_SUB_T_OFFLINE_ARENA;
is_offline_arena_battle(R) when is_record(R, btl_feedback) ->
	R#btl_feedback.battle_type == ?BTL_T_PVP
	andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_OFFLINE_ARENA.

%% 战斗是否属于劫镖战斗？
is_hijack_battle(R) when is_record(R, btl_state) ->
	R#btl_state.type == ?BTL_T_PVP
	andalso R#btl_state.subtype == ?BTL_SUB_T_HIJACK;
is_hijack_battle(R) when is_record(R, btl_feedback) ->
	R#btl_feedback.battle_type == ?BTL_T_PVP
	andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_HIJACK.


%% 战斗是否属于1v1在线竞技场（比武大会）战斗？
is_1v1_online_arena_battle(R) when is_record(R, btl_state) ->
	R#btl_state.type == ?BTL_T_PVP
	andalso R#btl_state.subtype == ?BTL_SUB_T_1V1_ONLINE_ARENA;
is_1v1_online_arena_battle(R) when is_record(R, btl_feedback) ->
	R#btl_feedback.battle_type == ?BTL_T_PVP
	andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_1V1_ONLINE_ARENA.


%% 战斗是否为切磋类型的pk？
is_qiecuo_pk_battle(R) when is_record(R, btl_state) ->
	R#btl_state.type == ?BTL_T_PVP
	andalso R#btl_state.subtype == ?BTL_SUB_T_PK_QIECUO;
is_qiecuo_pk_battle(R) when is_record(R, btl_feedback) ->
	R#btl_feedback.battle_type == ?BTL_T_PVP
	andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_PK_QIECUO.

%% 是否是帮战
is_guild_pk_battle(R) when is_record(R, btl_state) ->
	R#btl_state.type == ?BTL_T_PVP
	andalso R#btl_state.subtype == ?BTL_SUB_T_GUILD_WAR;
is_guild_pk_battle(R) when is_record(R, btl_feedback) ->
	R#btl_feedback.battle_type == ?BTL_T_PVP
	andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_GUILD_WAR.



is_melee_pk_battle(R) when is_record(R, btl_state) ->
	R#btl_state.type == ?BTL_T_PVP
	andalso R#btl_state.subtype == ?BTL_SUB_T_MELEE_PK;
is_melee_pk_battle(R) when is_record(R, btl_feedback) ->
	R#btl_feedback.battle_type == ?BTL_T_PVP
	andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_MELEE_PK.



%% 战斗是否为女妖乱斗活动时的打怪或pk？
is_melee_battle(R) when is_record(R, btl_state) ->
	is_melee_mf_battle(R) orelse is_melee_pk_battle(R);
is_melee_battle(R) when is_record(R, btl_feedback) ->
	is_melee_mf_battle(R) orelse is_melee_pk_battle(R).


%% 战斗是否属于3v3在线竞技场（比武大会）战斗？
is_3v3_online_arena_battle(R) when is_record(R, btl_state) ->
    R#btl_state.type == ?BTL_T_PVP
    andalso R#btl_state.subtype == ?BTL_SUB_T_3V3_ONLINE_ARENA;
is_3v3_online_arena_battle(R) when is_record(R, btl_feedback) ->
    R#btl_feedback.battle_type == ?BTL_T_PVP
    andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_3V3_ONLINE_ARENA.

%% 战斗是否属于3v3在线竞技场（比武大会）战斗？
is_cross_3v3_battle(R) when is_record(R, btl_state) ->
    R#btl_state.type == ?BTL_T_PVP
    andalso R#btl_state.subtype == ?BTL_SUB_T_CROSS_3V3;
is_cross_3v3_battle(R) when is_record(R, btl_feedback) ->
    R#btl_feedback.battle_type == ?BTL_T_PVP
    andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_CROSS_3V3.

%% 战斗是否属于3v3在线竞技场（比武大会）战斗？
is_cross_3v3_battle_robot(R) when is_record(R, btl_state) ->
    R#btl_state.type == ?BTL_T_PVP
    andalso R#btl_state.subtype == ?BTL_SUB_T_CROSS_3V3_ROBORT;
is_cross_3v3_battle_robot(R) when is_record(R, btl_feedback) ->
    R#btl_feedback.battle_type == ?BTL_T_PVP
    andalso R#btl_feedback.battle_subtype == ?BTL_SUB_T_CROSS_3V3_ROBORT.


% %% exports
% %% @desc: 通过玩家ID查询战斗对象ID
% %% @returns: BoId | null 
% get_boid_by_playerid(PlayerId) ->
%     BoIdList = lib_battle:get_dict_side_idlist(r) ++ lib_battle:get_dict_side_idlist(l),
%     get_boid_by_playerid(BoIdList, PlayerId).
% %% internal
% %% 根据玩家id找到对应的战斗对象id（To-Do: 是否不要这个，提高效率？）
% %% 返回值：BoId - 找到；none - 找不到
% get_boid_by_playerid([], _PlayerId) ->
%     null;
% get_boid_by_playerid([BoId|T], PlayerId) ->
%     Bo = get(BoId),
%     case is_record(Bo, battle_obj) andalso is_player(Bo) andalso Bo#battle_obj.id =:= PlayerId of
%         true -> BoId;
%         false -> get_boid_by_playerid(T, PlayerId)
%     end.
                        



% %% 获取左方或右方还未死亡的战斗对象id列表
% get_living_bo_id_list(Side) ->
% 	?ASSERT(Side == l orelse Side == r, Side),
% 	BoIdList = lib_battle:get_dict_side_idlist(Side),
% 	?ASSERT(is_list(BoIdList), {Side, BoIdList, get(battle_state)}),
% 	[BoId || BoId <- BoIdList, is_living(get(BoId))].

% %% 获取左方或右方还未死亡的玩家战斗对象id列表
% get_living_player_bo_id_list(Side) ->
% 	?ASSERT(Side == l orelse Side == r, Side),
% 	BoIdList = lib_battle:get_dict_side_idlist(Side),
% 	[BoId || BoId <- BoIdList, is_living_player(get(BoId))].

% %% desc: 获取左方或右方还未死亡的武将战斗对象id列表
% get_living_partner_bo_id_list(Side) ->
%     ?ASSERT(Side == l orelse Side == r, Side),
%     BoIdList = lib_battle:get_dict_side_idlist(Side),
%     [BoId || BoId <- BoIdList, is_living_partner(get(BoId))].
    


% %% 获取某一方在线并且仍存活的玩家战斗对象列表
% get_online_living_player_bo_list(Side) ->
% 	?ASSERT(Side == l orelse Side == r),
% 	BoIdList = lib_battle:get_dict_side_idlist(Side),
% 	BoList = [get(X) || X <- BoIdList],
% 	[Bo || Bo <- BoList, is_player(Bo), is_online(Bo), is_living(Bo)].



get_all_player_bo_list() ->
	L = get_all_bo_id_list(),
	BoList = [get_bo_by_id(BoId) || BoId <- L],
	[Bo || Bo <- BoList, is_player(Bo)].


%% 获取战场上所有在线并且未死亡的玩家bo列表
get_all_online_living_player_bo_list() ->
	L = get_all_bo_id_list(),
	BoList = [get_bo_by_id(BoId) || BoId <- L],
	[Bo || Bo <- BoList, is_player(Bo), is_online(Bo), is_living(Bo)].


%% 获取战场上所有在线的玩家bo列表
get_all_online_player_bo_list() ->
	L = get_all_bo_id_list(),
	BoList = [get_bo_by_id(BoId) || BoId <- L],
	[Bo || Bo <- BoList, is_player(Bo), is_online(Bo)].




%% 判断位置是否为空闲
is_pos_empty(Side, Pos) ->
	get_bo_by_pos(Side, Pos) == null.

%% 判断位置是否已经被占了
is_pos_occupied(Side, Pos) ->
	not is_pos_empty(Side, Pos).



% 作废！！
% %% 获取战场上所有在线的玩家和主宠bo列表
% get_all_online_player_and_main_partner_bo_list() ->
% 	L = get_all_bo_id_list(),
% 	BoList = [get_bo_by_id(BoId) || BoId <- L],
% 	[Bo || Bo <- BoList, is_online_player(Bo) orelse is_online_main_partner(Bo)].

	

% %% 获取某一方在线并且仍存活的玩家战斗对象id列表	
% get_online_living_player_bo_id_list(Side) ->
% 	?ASSERT(Side == l orelse Side == r),
% 	BoIdList = lib_battle:get_dict_side_idlist(Side),
% 	BoList = [get(X) || X <- BoIdList],
% 	[Bo#battle_obj.bo_id || Bo <- BoList, is_player(Bo), is_online(Bo), is_living(Bo)].
	

% %% 获取某一方在线并且仍存活的玩家的数量
% get_online_living_player_count(Side) ->
% 	?ASSERT(Side == l orelse Side == r),
% 	%%BoIdList = get(Side),
% 	%%BoList = [get(X) || X <- BoIdList],
% 	%%length([dummy || Bo <- BoList, is_player(Bo), is_online(Bo), is_living(Bo)]).
% 	length(get_online_living_player_bo_list(Side)).
			


%% 获取一方的敌对方
to_enemy_side(Side) ->
	case Side of
		?HOST_SIDE -> ?GUEST_SIDE;
		?GUEST_SIDE -> ?HOST_SIDE
	end.


%% 获取当前的回合数
get_cur_round() ->
	(get_battle_state())#btl_state.round_counter.
	

% %% 获取当前的半回合数	
% get_cur_half_turn_index() ->
% 	(get(battle_state))#state.half_turn_index. 
	

% %% exports
% %% desc: 判断当前半回合是否在战斗中
% is_half_turn_battling() ->
%     BattleState = get(battle_state),
%     BattleState#state.half_turn_state =/= idle.

% %% exports
% %% @desc: 将0和1转换为 ?TURN_OFF 和 ?TURN_ON
% %% @returns: ?TURN_OFF | ?TURN_ON
% int_to_onoff(0) -> ?TURN_OFF;
% int_to_onoff(1) -> ?TURN_ON;
% int_to_onoff(_Err) -> ?ASSERT(false, _Err), ?TURN_OFF.

% %% exports
% %% desc: 将当前半回合状态设置为空闲
% %% set_half_turn_idle() ->
% %%     BattleState = get(battle_state),
% %%     case BattleState#state.half_turn_state == idle of
% %%         true -> skip;
% %%         false ->
% %%             NewState = BattleState#state{half_turn_state = idle},
% %%             put(battle_state, NewState)
% %%     end.
% %% exports
% %% desc: 将当前半回合状态设置为战斗中
% %% set_half_turn_battling() ->
% %%     BattleState = get(battle_state),
% %%     case BattleState#state.half_turn_state == battling of
% %%         true -> skip;
% %%         false ->
% %%             NewState = BattleState#state{half_turn_state = battling},
% %%             put(battle_state, NewState)
% %%     end.
    
% %% exports
% %% desc: 获取某追积技能的对应觉醒值
% get_pursue_data_arousal(SkillData) ->
%     {
%      SkillData#ets_skill.data#rd_skill_data.gain_arousal,
%      SkillData#ets_skill.data#rd_skill_data.cost_arousal
%     }.

% %% exports
% %% desc: 获取追击技能的对应怒气值
% get_pursue_data_anger(SkillData) ->
%     {
%      SkillData#ets_skill.data#rd_skill_data.gain_anger,
%      SkillData#ets_skill.data#rd_skill_data.cost_anger
%     }.
	
	
% %% 获取当前的攻击方
% %% @return： l（左方） | r（右方）
% get_cur_att_side() ->
% 	BattleState = get(battle_state),
% 	BattleState#state.aer_side.

% get_cur_att_dir() ->
% 	case get_cur_att_side() of
% 		l -> r;
% 		r -> l
% 	end.

% %% 获取左方所有玩家的send pid
% %% TODO：实现方式考虑改为遍历左方战斗对象，然后筛选出在线玩家的send pid
% get_l_side_send_pids() ->
% 	BattleState = get(battle_state),
% 	BattleState#state.ler_send_pid.

% %% 获取右方所有玩家的send pid
% get_r_side_send_pids() ->
% 	BattleState = get(battle_state),
% 	BattleState#state.rer_send_pid.

% %% 获取战场内所有玩家的send pid
% get_all_send_pids() ->
% 	BattleState = get(battle_state),
% 	BattleState#state.ler_send_pid ++ BattleState#state.rer_send_pid.
	




%% 依据bo的id获取bo
%% @return: null | battle_obj结构体
get_bo_by_id(BoId) ->
	?ASSERT(util:is_positive_int(BoId) orelse (BoId == ?INVALID_ID), BoId),
    case get(BoId) of
        undefined ->
            null;
        Bo when is_record(Bo, battle_obj) ->
            Bo
    end.




%% 依据玩家id获取玩家战斗对象
%% @return: null | 玩家战斗对象
get_bo_by_player_id(PlayerId) ->
	L = get_all_bo_id_list(),
	get_bo_by_player_id__(L, PlayerId).
	
get_bo_by_player_id__([], _PlayerId) ->
	null;
get_bo_by_player_id__([BoId | T], PlayerId) ->
	Bo = get_bo_by_id(BoId),
	case is_player(Bo) andalso lib_bo:get_parent_obj_id(Bo) == PlayerId of
		true ->
			Bo;
		false ->
			get_bo_by_player_id__(T, PlayerId)
	end.
	


%% 依据玩家id获取玩家战斗对象
%% @return: null | 玩家战斗对象
get_bo_by_partner_id(PartnerId) ->
	L = get_all_bo_id_list(),
	get_bo_by_partner_id__(L, PartnerId).
	
get_bo_by_partner_id__([], _PlayerId) ->
	null;
get_bo_by_partner_id__([BoId | T], PartnerId) ->
	Bo = get_bo_by_id(BoId),
	case is_partner(Bo) andalso lib_bo:get_parent_obj_id(Bo) == PartnerId of
		true ->
			Bo;
		false ->
			get_bo_by_partner_id__(T, PartnerId)
	end.



	
%% 依据位置获取bo
%% @return: null | battle_obj结构体
get_bo_by_pos(Side, Pos) ->
	BoIdList = get_bo_id_list(Side),
	get_bo_by_pos__(BoIdList, Pos).


get_bo_by_pos__([BoId | T], Pos) ->
	case get_bo_by_id(BoId) of
		null ->
			get_bo_by_pos__(T, Pos);
		Bo ->
			case lib_bo:get_pos(Bo) of
				Pos -> Bo;
				_ -> get_bo_by_pos__(T, Pos)
			end
	end;
get_bo_by_pos__([], _Pos) ->
	null.


%%获取我方还活着的bo总数
get_myside_living_bo_count(Side) ->
	BoIdList = get_bo_id_list(Side),
	length([BoId || BoId <- BoIdList,  is_living(BoId)]).

%%获取不是我方还活着的bo总数
get_otherside_living_bo_count(Side) ->
	BoIdList = get_other_bo_id_list(Side),
	length([BoId || BoId <- BoIdList,  is_living(BoId)]).

get_bo_id_list(Side) ->
	case Side of
		?HOST_SIDE ->
			get(?KN_HOST_SIDE_BO_ID_LIST);
		?GUEST_SIDE ->
			get(?KN_GUEST_SIDE_BO_ID_LIST)
	end.

%%获取另外一方的boidlist
get_other_bo_id_list(Side) ->
	case Side of
		?HOST_SIDE ->
			get(?KN_GUEST_SIDE_BO_ID_LIST);
		?GUEST_SIDE ->
			get(?KN_HOST_SIDE_BO_ID_LIST)
	end.
set_bo_id_list(Side, BoIdList) ->
	?ASSERT(util:is_integer_list(BoIdList), {Side, BoIdList, get_battle_state()}),
	case Side of
		?HOST_SIDE ->
			put(?KN_HOST_SIDE_BO_ID_LIST, BoIdList);
		?GUEST_SIDE ->
			put(?KN_GUEST_SIDE_BO_ID_LIST, BoIdList)
	end.


get_all_bo_id_list() ->
	get(?KN_HOST_SIDE_BO_ID_LIST) ++ get(?KN_GUEST_SIDE_BO_ID_LIST).	



%% 获取某一方的bo数量
get_bo_count(Side) ->
	length(get_bo_id_list(Side)).






%% 获取战斗双方的bo总数
get_all_bo_count() ->
	length(get_all_bo_id_list()).





get_all_online_player_bo_id_list() ->
	L = get_all_bo_id_list(),
	[BoId || BoId <- L, is_online_player( get_bo_by_id(BoId))].





% %% 发送给左方的所有在线玩家	
% send_to_l_side(BinData) ->
% 	SendPidList = get_l_side_send_pids(),
% 	send_to_client(SendPidList, BinData).
	
% %% 发送给右方的所有在线玩家
% send_to_r_side(BinData) ->
% 	SendPidList = get_r_side_send_pids(),
% 	send_to_client(SendPidList, BinData).
	
	

% %% 发送给左方所有未死亡并且在线的玩家
% send_to_l_living_players(BinData) ->
% 	SendPidList = get_l_living_player_send_pids(),
% 	?TRACE("l living player SendPidList : ~p~n", [SendPidList]),
% 	send_to_client(SendPidList, BinData).
	
% %% 发送给右方所有未死亡并且在线的玩家	
% send_to_r_living_players(BinData) ->
% 	SendPidList = get_r_living_player_send_pids(),
% 	?TRACE("r living player SendPidList : ~p~n", [SendPidList]),
% 	send_to_client(SendPidList, BinData).
	
	

% %% 发送给战场上的所有在线玩家
% send_to_all(BinData) ->
% 	SendPidList = get_all_send_pids(),
% 	send_to_client(SendPidList, BinData).
	
	


% %% 发送二进制流数据给一个或多个客户端	, 战斗系统向客户端统一调用这个接口，不能调用其他接口发送
% send_to_client(SendPidList, BinData) ->
% 	?ASSERT(lists:member(none, SendPidList) == false, SendPidList),
% 	F = fun(SendPid) ->
% 			lib_send:send_to_sid(SendPid, BinData)
%         end,
% 	[F(SendPid) || SendPid <- SendPidList, SendPid /= none]. % 做容错：过滤掉none	









% %% 通知自己：更新战斗对象的属性（这个只通知给玩家自己）
% %%notify_bo_attr_changed_to_self(Bo) ->
% %%	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_BO_ATTR_CHANGED, Bo),
% %%	send_to_client([Bo#battle_obj.send_pid], BinData).
	
% %% 通知某一方的所有玩家：更新战斗对象的属性
% %%notify_bo_attr_changed_to_side(Side, Bo) ->
% %%	%%SendPids = 	case Side of
% %%	%%				l -> get_l_side_send_pids();
% %%	%%				r -> get_r_side_send_pids()
% %%	%%			end,
% %%	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_BO_ATTR_CHANGED, Bo),
% %%	%%send_to_client(SendPids, BinData).
% %%	case Side of
% %%		l -> send_to_l_side(BinData);
% %%		r -> send_to_r_side(BinData)
% %%	end.

% %% 通知战场上的所有玩家：更新战斗对象的属性
% %%notify_bo_attr_changed_to_all(Bo) ->
% %%	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_BO_ATTR_CHANGED, Bo),
% %%	send_to_all(BinData).

% notify_bo_attr_changed_to_all(Target, ChangeReason) ->
%     Bo = case is_integer(Target) of
%              true -> get(Target);
%              false -> Target
%          end,
%     ?ASSERT(is_record(Bo, battle_obj) /=  false),
%     notify_bo_attr_changed_to_all(Bo, ChangeReason, Bo#battle_obj.bo_id, 0).
% notify_bo_attr_changed_to_all(Target, ChangeReason, AddHpFixNum, HelpAddHpBoId) ->
%     Bo = case is_integer(Target) of
%             true -> get(Target);
%             false -> Target
%          end,
%     case is_record(Bo, battle_obj) of
%         false -> skip;
%         true ->
%             % todo--矫正血量，如果确认没问题了，应该在这里取消矫正的步骤
%             NewBo = case Bo#battle_obj.hp > Bo#battle_obj.hp_lim of
%                         true -> 
%                             ?ERROR_MSG("calc error, hp > hp_lim:~p", [{Bo#battle_obj.hp, Bo#battle_obj.hp_lim, Bo#battle_obj.sign, ChangeReason}]),
%                             Bo#battle_obj{hp = Bo#battle_obj.hp_lim};
%                         false ->
%                             Bo
%                     end,
%             put(Bo#battle_obj.bo_id, NewBo),
            
%             {ok, BinData} = pt_20:write(?PT_BT_NOTIFY_BO_ATTR_CHANGED, [NewBo, ChangeReason, AddHpFixNum, HelpAddHpBoId]),
%             send_to_all(BinData)
%     end.



% %% exports
% %% 更新战斗对象的当前怒气值
% %% 注：对于玩家bo，如果是自动挂机状态并且怒气已达所设定的上限，则变为按顺序使用挂机技能组合
% %% @desc: 如果有怒气冻结增长的buff处理，此处处理
% %% @return: {ChangeAnger, NewBo}
% update_bo_anger(BoId, NewAnger) ->
%     ?ASSERT(0 =< NewAnger andalso NewAnger =< ?MAX_BO_ANGER),
%     Bo = get(BoId),
    
%     NewAnger1 = 
%         case Bo#battle_obj.anger < NewAnger of
%             true -> 
%                 % 怒气恢复速度处理
%                 case lib_battle_buff:get_bo_buff_by_eff_name(Bo, ?EN_CHANGE_ANGER_SPEED) of
%                     [] -> 
%                         NewAnger;
%                     [Buff | _] ->
%                         util:ceil((1 + Buff#bo_buff.eff_value * Buff#bo_buff.cur_overlap) * NewAnger)
%                 end;
%             false ->
%                 NewAnger
%         end,
    
% 	NewBo = Bo#battle_obj{anger = util:minmax(NewAnger1, 0, ?MAX_BO_ANGER)},
%     % 为写代码方便，这里顺带更新到进程字典
%     put(BoId, NewBo),
%     NewBo.
	
% %% exports
% %% 更新战斗对象的当前觉醒值，并且依据特定条件，更新其觉醒状态
% %% @return: 更新后的bo
% update_bo_arousal(BoId, NewArousal) when is_integer(BoId) ->
%     Bo = get(BoId),
%     case Bo#battle_obj.arousal < NewArousal of
%         true -> 
%             case Bo#battle_obj.is_awake of
%                 true ->  Bo;
%                 false -> update_bo_arousal(Bo, NewArousal)
%             end;
%         false ->
%             update_bo_arousal(Bo, NewArousal)
%     end;
% %% internal
% %% @desc: 更新对象觉醒值 
% %% @returns: Bo
% update_bo_arousal(Bo, NewArousal) when Bo#battle_obj.arousal == NewArousal ->
%     Bo;
% update_bo_arousal(Bo, NewArousal) ->    
%     NewBo1 = if 
%                 NewArousal == 0 ->
%                     % 变为未觉醒状态
%                     Bo#battle_obj{is_awake = false};
%                 NewArousal == ?MAX_BO_AROUSAL ->
%                     % 变为觉醒状态， 扣减觉醒状态设置为false，正常情况下不允许扣减
%                     Bo#battle_obj{is_awake = true, sub_awake_state = ?BOOL_FALSE};
%                 true ->
%                     Bo
%              end,
    
%     NewBo2 = NewBo1#battle_obj{arousal = NewArousal},
%     % 为写代码方便，这里顺带更新到进程字典
%     put(NewBo2#battle_obj.bo_id, NewBo2),
%     NewBo2.	
	
% %% exports
% %% @desc: 判断技能的即时效果元组的类型
% %% @returns: atom() 
% get_skill_fx_atom_type(SkillFxTuple) ->
%     case SkillFxTuple of
%         {decide_cast_target, _, _, _, _} ->
%             decide_cast_target;
%         {_, Atom, _, _} when is_atom(Atom) ->
%             Atom;
%         _ ->
%             null
%     end.

% %% exports
% %% @desc: 在每一回合结束时判断能否扣减觉醒值，这里只检测扣减的条件：本次满觉醒后是否有使用过追击或者消耗觉醒的技能
% %% @returns: true | false
% can_sub_bo_arousal(Bo) ->
%     Bo#battle_obj.sub_awake_state == ?BOOL_TRUE.


	
	

% %% 判断bo当前是否可以使用指定的技能，不检查技能的cd，仅用于战斗初始时调用!
% %% 说明：战斗初始化过程中，因battle_state还未put到进程字典，故不检查技能的cd，
% %%       因为检查技能cd的处理中会调用get_cur_turn_index()，而该函数是在战斗过程中（即battle_state被put到进程字典后）才能被调用，
% %%       所以战斗初始时不检查cd（也没必要去检查），故特此新加本接口
% check_can_use_skill(without_check_cd, Bo, SkillId, SkillLv) ->
% 	case lib_skill:get_cfg_data(SkillId, SkillLv) of
%         null ->
%             ?ASSERT(false),
%             false;
%         SkillData ->
%             LvData = SkillData#ets_skill.data, % 技能每个等级的细化数据
% 			CostAnger = LvData#rd_skill_data.cost_anger,
% 			CostArousal = LvData#rd_skill_data.cost_arousal,
% 			% 判断怒气和觉醒值是否够
% 			case (Bo#battle_obj.anger < CostAnger)
% 			orelse (Bo#battle_obj.arousal < CostArousal) of
% 				true ->
% 					false;
% 				false ->
% 					case lib_skill:is_cooperate_skill(SkillData) orelse lib_skill:is_pursue_skill(SkillData) orelse lib_skill:is_awake_stunt_skill(SkillData) of
% 						true ->
% 							is_awake(Bo);
% 						false ->
% 							true
% 					end
% 			end
%     end.

% %% exports
% %% @desc: 判断技能的buff效果元组的类型
% %% @returns: atom() 
% get_skill_buff_atom_type(SkillFxTuple) ->
%     case SkillFxTuple of
%         {_, Atom, _, _, _} when is_atom(Atom) ->
%             Atom;
%         _ ->
%             null
%     end.

	
	
% %% 判断bo当前是否可以使用指定的技能
% %% @return: true => 可使用， false => 不可使用
% check_can_use_skill(Bo, SkillId, SkillLv) ->
%     case lib_skill:get_cfg_data(SkillId, SkillLv) of
%         null ->
%             ?ERROR_MSG("bad skill data, check_can_use_skill/3, SkillId:~p, SkillLv:~p", [SkillId, SkillLv]),
%             ?ASSERT(false),
%             false;
%         SkillData ->
%         	% 加错误日志，方便技能配置数据出错的时候查原因
% 			case is_record(SkillData#ets_skill.data, rd_skill_data) of
% 				false ->
% 					?ERROR_MSG("[BATTLE_ERR]check_can_use_skill()!! BoType: ~p, id: ~p, BoId: ~p, SkillId: ~p, SkillLv: ~p, SrcSkillList: ~w", 
% 									[Bo#battle_obj.sign, Bo#battle_obj.id, Bo#battle_obj.bo_id, SkillId, SkillLv, Bo#battle_obj.src_skill_list]),
% 					?ASSERT(false, {SkillId, SkillLv}),
% 					false;
% 				true ->
% 					check_can_use_skill(Bo, SkillData)
% 			end
%     end.


% check_can_use_skill(Bo, SkillData) when is_record(SkillData, ets_skill) ->
% 	LvData = SkillData#ets_skill.data, % 技能每个等级的细化数据
% 	CostAnger = LvData#rd_skill_data.cost_anger,
% 	CostArousal = LvData#rd_skill_data.cost_arousal,
% 	IsCDroundOK = lib_battle:is_cdround_ok(Bo, SkillData),
                      
% 	% 判断怒气和觉醒值是否够，是否还在cd中
% 	case (Bo#battle_obj.anger < CostAnger)
% 	orelse (Bo#battle_obj.arousal < CostArousal)
% 	orelse (not IsCDroundOK) of
% 		true ->
% 			false;
% 		false ->
% 			case lib_skill:is_cooperate_skill(SkillData) orelse lib_skill:is_pursue_skill(SkillData) orelse lib_skill:is_awake_stunt_skill(SkillData) of
% 				true ->
% 					is_awake(Bo);
% 				false ->
% 					true
% 			end
% 	end;
% check_can_use_skill(_Bo, SkillData) ->
%     ?ERROR_MSG("bad skill data, check_can_use_skill/3, skill_data:~w", [SkillData]),
%     ?ASSERT(false),
%     false.
	
	

	
	
	

% %% ==================================== Local Functons ===================================================	
	
	
	
% %% 获取左方所有未死亡并且在线的玩家的send_pid列表
% %% TODO: 考虑合并为get_alive_player_send_pids(Side) ??
% get_l_living_player_send_pids() -> 
% 	BoIdList = get_living_bo_id_list(l), %%get(l),
% 	BoList = [get(X) || X <- BoIdList],
	
% 	% TODO：这里做断言验证，所以代码啰嗦点，以后确认无bug后就做简化.
% 	RetSendPidList = [Bo#battle_obj.send_pid || Bo <- BoList, is_player(Bo), is_online(Bo)],
% 	?ASSERT(lists:member(none, RetSendPidList) == false),
% 	RetSendPidList.

% %% 获取右方所有未死亡并且在线的玩家的send_pid列表	
% get_r_living_player_send_pids() ->
% 	BoIdList = get_living_bo_id_list(r), %%get(r),
% 	BoList = [get(X) || X <- BoIdList],
% 	RetSendPidList = [Bo#battle_obj.send_pid || Bo <- BoList, is_player(Bo), is_online(Bo)],
% 	?ASSERT(lists:member(none, RetSendPidList) == false),
% 	RetSendPidList.	
	
	
	
