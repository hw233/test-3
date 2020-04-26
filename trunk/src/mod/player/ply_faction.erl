%%%--------------------------------------
%%% @Module  : ply_faction
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.11.14
%%% @Description: 玩家的与门派相关的业务逻辑
%%%--------------------------------------
-module(ply_faction).
-export([
        can_join_faction/2,
        join_faction/2,
        on_player_login/1,
        on_player_tmp_logout/1,
        get_faction_player_list/1,
        get_faction_xinfa_ids_config/1,
        transform_faction/4,
        transform_faction_by_rein/2,
        transform_faction_for_gmorder/2,
        check_can_transform_faction/1,
		levelup_unlock_faction_skill/1,
		get_faction_skills/1,
		upgrade_faction_skill/2,
		transform_faction/2,
		transform_faction_cost/1,
	finish_skill_achivement/1
    ]).

-include("common.hrl").
-include("prompt_msg_code.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("player.hrl").
-include("faction.hrl").
-include("abbreviate.hrl").
-include("task.hrl").
-include("skill.hrl").
-include("xinfa.hrl").
-include("log.hrl").


%% 加入门派所需的等级
-define(JOIN_FACTION_NEED_LV, 10).

%% 判断是否可以加入门派？
can_join_faction(PS, Faction) ->
    FactionBase = data_faction:get(Faction),
    case player:get_lv(PS) < ?JOIN_FACTION_NEED_LV of
        true ->
            {fail, ?PM_LV_LIMIT};
        false ->
            case player:is_in_faction(PS) of
                true ->
                    {fail, ?PM_HAS_JOINED_FACTION};
                false ->
                    case FactionBase#faction_base.race_limit =:= player:get_race(PS) of
                        false -> {fail, ?PM_RACE_LIMIT};
                        true ->
                            case FactionBase#faction_base.sex_limit /= 0 andalso FactionBase#faction_base.sex_limit /= player:get_sex(PS) of
                                true -> {fail, ?PM_SEX_LIMIT};
                                false -> ok
                            end
                    end
            end
    end.


cost_money_for_transform_faction(_PS, []) ->
    ok;
cost_money_for_transform_faction(PS, [{MoneyType, Count} | T]) ->
    player:cost_money(PS, MoneyType, Count,[]),
    cost_money_for_transform_faction(PS, T).

%% 判断是否是门派任务
check_and_complete_is_faction_task_elite([], _PS) ->
    void;

check_and_complete_is_faction_task_elite([H|T], PS) ->
    TmpTask = data_task:get(H),
    TmpTaskType = TmpTask#task.type,
    %% 如果是精英师门任务
    ?Ifc (TmpTaskType =:= ?TASK_FACTION_FIGHT_TYPE)
        %% 完成任务
         lib_task:force_submit(H, PS)
    ?End,

    check_and_complete_is_faction_task_elite(T,PS),
    void.

% 转生而引起的门派转换
transform_faction_by_rein(PS,NewFaction) ->
    PlayerId = player:id(PS),

    %% 执行心法转换
    ply_xinfa:transform_xinfa(PS,faction,NewFaction),

    %% 从原门派列表删除
    del_from_faction_player_list(player:get_faction(PS), player:id(PS)),
    %% 添加到新门派
    add_to_faction_player_list(NewFaction, player:id(PS)),

    %% 设置PS的门派
    player:set_faction(PS, NewFaction),
    %% 保存门派到数据库
    db_save_faction(PlayerId,NewFaction),
    %% 从新计算心法加成属性
    void.
    % ply_attr:recount_xinfa_add_and_total_attrs(PS),
    %% TimeNow = svr_clock:get_unixtime(),

%% 门派转换 新门派 新性别 新种族
transform_faction(PS, NewFaction, NewSex, NewRace) ->
    %% 上一次转职时间
    LastTansformTime = player:get_last_transform_time(PS),
    TimeNow = util:unixtime(),

    Interval = TimeNow - LastTansformTime,
    %
    Day = util:ceil(Interval/60/60/24),
    Data = get_transform_config(1,Day),   

    % 扣除消耗货币
    cost_money_for_transform_faction(PS,Data#transform_faction.money),
    PlayerId = player:id(PS),

    %% 执行心法转换
    ply_xinfa:transform_xinfa(PS,faction,NewFaction),

    %% 更新最后一次转职时间为现在
    db:update(PlayerId, player,["last_transform_time"],[TimeNow],"id",PlayerId),

    player:set_last_transform_time(PS,TimeNow),

    %% 从原门派列表删除
    del_from_faction_player_list(player:get_faction(PS), player:id(PS)),
    %% 添加到新门派
    add_to_faction_player_list(NewFaction, player:id(PS)),

    % ------------------------------计算重置数据点
    %% 设置PS的门派
    player:set_faction(PS, NewFaction),
    player:set_sex(PS,NewSex),
    player:set_race(PS,NewRace),

    lib_mail:send_sys_mail(PlayerId, <<"转职成功">>, 
                                <<"由于您转职了特送您一个重置属性道具,感谢您对梦幻加强版的支持">>, 
                                [{10040,1}], ["mail", "transform_faction"]),

    % 保存性别到数据库
    player:db_save_sex(PlayerId,NewSex),
    % 保存种族到数据库
    player:db_save_race(PlayerId,NewRace),
    % 保存门派到数据库
    db_save_faction(PlayerId,NewFaction),
    void.

%% 门派转换 通过gm命令
transform_faction_for_gmorder(PS, NewFaction) ->
    %% 上一次转职时间
    PlayerId = player:id(PS),

    %% 执行心法转换
    ply_xinfa:transform_xinfa(PS,faction,NewFaction),
    %% 从原门派列表删除
    del_from_faction_player_list(player:get_faction(PS), player:id(PS)),
    %% 添加到新门派
    add_to_faction_player_list(NewFaction, player:id(PS)),

    %% 设置PS的门派
    player:set_faction(PS, NewFaction),
    %% 保存门派到数据库
    db_save_faction(PlayerId,NewFaction),
    %% 从新计算心法加成属性
    ply_attr:recount_xinfa_add_and_total_attrs(PS),

    void.

%% 转换门派所需的等级
-define(TRANSFORM_FACTION_NEED_LV, 50).

%% 检测是否符合门派转换条件
check_can_transform_faction(PS) ->
    %FactionBase = data_faction:get(Faction),    

    % 判断玩家是否携带武器
    ShowEquips = player:get_showing_equips(PS),

    case ShowEquips#showing_equip.weapon of 
        ?INVALID_NO ->
            case player:get_lv(PS) < ?TRANSFORM_FACTION_NEED_LV of
                true ->
                    {fail, ?PM_LV_LIMIT};
                false ->
                    case check_transform_cons(PS) of
                        {fail, FailReason} -> {fail, FailReason};
                        ok -> ok
                    end
            end;
        _ ->
            {fail, ?PM_CAN_NOT_EQUIP_WEAPON}

    end.

%% 检测转换门派消耗
check_transform_cons(PS) ->
    try check_transform_cons__(PS) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

%% 检测转换门派消耗
check_transform_cons__(PS) ->
    LastTansformTime = player:get_last_transform_time(PS),
    TimeNow = util:unixtime(),

    Interval = TimeNow - LastTansformTime,
    %921961
    Day = util:floor(Interval/60/60/24),

    Data = get_transform_config(1,Day), %%获取需要的配置

    ?DEBUG_MSG("Day = ~p Data = ~p",[Day,Data]),

    ?Ifc(Data =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    RetMoney = check_money_for_transform_faction(PS, Data),    

    ?Ifc (RetMoney =/= ok)
        throw(RetMoney)
    ?End,

    ok.


% 检测转换门派
check_money_for_transform_faction(PS, Data) ->

    [{MoneyType, Count}] = Data#transform_faction.money,    
    Ret = case player:has_enough_money(PS,MoneyType,Count) of
        false ->
            case MoneyType of
                ?MNY_T_GAMEMONEY -> ?PM_GAMEMONEY_LIMIT;
                ?MNY_T_YUANBAO -> ?PM_YB_LIMIT;
                ?MNY_T_BIND_GAMEMONEY -> ?PM_BIND_GAMEMONEY_LIMIT;
                ?MNY_T_BIND_YUANBAO -> ?PM_BIND_YB_LIMIT
            end;
        true -> 
            ok
    end,
    Ret.


%% 获取配置
get_transform_config(No, Day) ->
    case data_transform_faction:get(No) of
        null -> 
            null;
        Data ->
            [MinDay,MaxDay] = Data#transform_faction.time_range,

            case util:in_range(Day, MinDay, MaxDay) of
                true -> Data;
                false -> get_transform_config(No+1,Day)   
            end
    end.



%% 加入门派
join_faction(PS, Faction) ->
    ?TRACE("[ply_faction] join faction(), Faction:~p~n", [Faction]),
    ?ASSERT(lib_comm:is_valid_faction(Faction), Faction),
    player:set_faction(PS, Faction),
	%% 20191112 屏蔽了心法，简单在这里处理一下不解锁主心法
%%     ply_xinfa:unlock_master_xinfa(PS, Faction),
    add_to_faction_player_list(Faction, player:id(PS)),
    db_save_faction( player:id(PS), Faction).




db_save_faction(PlayerId, Faction) ->
    db:update(PlayerId, player, ["faction"], [Faction], "id", PlayerId).



on_player_login(PS) ->
    case player:is_in_faction(PS) of
        true -> add_to_faction_player_list(player:get_faction(PS), player:id(PS));
        false -> skip
    end.


on_player_tmp_logout(PS) ->
    case player:is_in_faction(PS) of
        true -> del_from_faction_player_list(player:get_faction(PS), player:id(PS));
        false -> skip
    end.




%% 获取门派的玩家列表
get_faction_player_list(Faction) ->
    ?ASSERT(lib_comm:is_valid_faction(Faction), Faction),
    case ets:lookup(?ETS_FACTION_PLAYER_LIST, Faction) of
        [] ->
            [];
        [Rd] ->
            Rd#faction_players.player_list
    end.





%% 添加玩家到门派玩家列表
add_to_faction_player_list(Faction, PlayerId) ->
    case ets:lookup(?ETS_FACTION_PLAYER_LIST, Faction) of
        [] ->
            ets:insert(?ETS_FACTION_PLAYER_LIST, #faction_players{faction = Faction, player_list = [PlayerId]});
        [Rd] ->
            case lists:member(PlayerId, Rd#faction_players.player_list) of
                true ->
                    ?WARNING_MSG("[ply_faction] add_to_faction_player_list(), player already in list!! Faction:~p, PlayerId:~p", [Faction, PlayerId]),
                    skip;
                false ->
                    NewList = [PlayerId | Rd#faction_players.player_list],
                    ets:insert(?ETS_FACTION_PLAYER_LIST, Rd#faction_players{player_list = NewList})
            end
    end.


%% 从门派玩家列表中删除玩家
del_from_faction_player_list(Faction, PlayerId) ->
    case ets:lookup(?ETS_FACTION_PLAYER_LIST, Faction) of
        [] ->
            ?WARNING_MSG("[ply_faction] del_from_faction_player_list(), no faction player list!! Faction:~p, PlayerId:~p", [Faction, PlayerId]),
            skip;
        [Rd] ->
            NewList = lists:delete(PlayerId, Rd#faction_players.player_list),
            ets:insert(?ETS_FACTION_PLAYER_LIST, Rd#faction_players{player_list = NewList})
    end.



%% 获取该门派的心法编号
get_faction_xinfa_ids_config(Faction) ->
    FactionBase = data_faction:get(Faction),
    ?DEBUG_MSG("FactionBase~p",[FactionBase]), 
    case FactionBase of 
        null ->
            [];
        _ -> FactionBase#faction_base.xinfa_list
            
    end.


%% 玩家加入了门派之后升级会学习相应的门派技能?
levelup_unlock_faction_skill(PS) ->
	Faction = player:get_faction(PS), 
	case data_faction:get(Faction) of
		#faction_base{skills = Skills} ->
			Pred = fun({_SkillId, Lv}) ->
						   player:get_lv(PS) >= Lv
				   end,
			case lists:filter(Pred, Skills) of
				[] ->
					void;
				L ->
					SkillBriefs = 
						lists:foldl(fun({SkillId, _Lv}, Acc) ->
											case lists:keymember(SkillId, #skl_brief.id, Acc) of
												?false ->
													[#skl_brief{id = SkillId, lv = 1}|Acc];
												?true ->
													Acc
											end
									end, PS#player_status.faction_skills, L),
					PS2 = PS#player_status{faction_skills = SkillBriefs},
					%% 发协议通知前端，保存数据
%% 					io:format("?MODULE, ?LINE, L : ~p~n", [{?MODULE, ?LINE, PS2#player_status.faction_skills}]),
					player_syn:update_PS_to_ets(PS2)
			end;
		_ ->
			void
	end. 


%% 获取玩家门派技能列表信息(因为门派技能可以随时转换？所以保存已开技能的等级，然后按ID大小对应相应的技能?)
get_faction_skills(PS) ->
	PS#player_status.faction_skills.


%% 设置玩家门派技能列表信息
set_faction_skills(PS, FactionSkills) ->
	PS#player_status{faction_skills = FactionSkills}.


%% 获取最低等级的门派技能
get_lowest_faction_skill(PS) ->
	FactionSkills = get_faction_skills(PS),
	Fun = fun(#skl_brief{id = Id, lv = Lv} = SklBrief, #skl_brief{id = IdAcc, lv = LvAcc} = Acc) ->
				  case Lv < LvAcc of
					  ?true ->
						  SklBrief;
					  ?false ->
						  case Lv == LvAcc andalso Id < IdAcc of
							  ?true ->
								  SklBrief;
							  ?false ->
								  Acc
						  end
				  end;
			 (SklBrief, _Acc) ->
				  SklBrief
		  end,
	lists:foldl(Fun, null, FactionSkills).


%% 一键升级的话先模拟升？在最后不满足条件的时候再做扣除升级处理？
upgrade_faction_skill_onekey(PS, IsFirst, CostGameMoneyAcc, CostExpAcc) ->
	case get_lowest_faction_skill(PS) of
		#skl_brief{id = SkillId} ->
			case upgrade_faction_skill(PS, SkillId, CostGameMoneyAcc, CostExpAcc) of
				{ok, PS2, CostGameMoneyAcc2, CostExpAcc2} ->
					upgrade_faction_skill_onekey(PS2, ?false, CostGameMoneyAcc2, CostExpAcc2);
				{fail, Reason} ->
					case IsFirst of
						?true ->
							%% 第一次就不满足了
							{fail, Reason};
						?false ->
							%% 做实际扣除和保存
							% 修改为同步扣钱
%%							?WARNING_MSG("222222222?MNY_T_GAMEMONEY=~p, ~p~n",[?MNY_T_GAMEMONEY, CostGameMoneyAcc]),
							PS2 = player_syn:cost_money(PS, ?MNY_T_GAMEMONEY, CostGameMoneyAcc, [?LOG_ROLE, "skill_up"]),
							% 扣经验
							player:cost_exp(PS2, CostExpAcc, [?LOG_ROLE, "skill_up"]),
							player_syn:update_PS_to_ets(PS2),
							{ok, PS2}
					end
			end;
		_ ->
			%% 没有技能？
			{ok, PS}
	end.

%%是否完成任务成就
finish_skill_achivement(PS) ->
	SklBriefs = ply_faction:get_faction_skills(PS),
	%%取所有技能中最低的那个
	case SklBriefs == [] of
		true ->
			skip;
		false ->
			SortFun = 
				fun(First,Next) ->
						First#skl_brief.lv < Next#skl_brief.lv
				end,
			case lists:sort(SortFun, SklBriefs) of
				[LowestSkl|_] ->
					mod_achievement:notify_achi(upgrade_role_skill, [{num, LowestSkl#skl_brief.lv}], PS);
				_ ->
					skip
			end
	end.


%% 门派技能升级
upgrade_faction_skill(PS, 0) ->% 一键升级
	upgrade_faction_skill_onekey(PS, ?true, 0, 0);

upgrade_faction_skill(PS, SkillId) ->% 升级特定门派技能
	case upgrade_faction_skill(PS, SkillId, 0, 0) of
		{ok, PS2, CostGameMoney, CostExp} ->
			%% 做实际扣除和PS保存
			
			% 修改为同步扣钱
    		PS3 = player_syn:cost_money(PS2, ?MNY_T_GAMEMONEY, CostGameMoney, [?LOG_ROLE, "skill_up"]),
    		% 扣经验
    		player:cost_exp(PS3, CostExp, [?LOG_ROLE, "skill_up"]),
			player_syn:update_PS_to_ets(PS2),
			{ok, PS2};
		{fail, Reason} ->
			%% 升级一次就不满足条件返回错误码
			{fail, Reason}
	end.
		


%% 这里不做实际扣除和升级保存，返回新PS和累计扣除值在外面最终执行实际扣除操作
upgrade_faction_skill(PS, SkillId, CostGameMoneyAcc, CostExpAcc) ->
	FactionSkills = ply_faction:get_faction_skills(PS),
	case lists:keytake(SkillId, #skl_brief.id, FactionSkills) of
		{value, #skl_brief{id = SkillId, lv = SkillLv} = Skill, FactionSkills2} ->
			case check_upgrade_faction_skill_costs(PS, Skill, CostGameMoneyAcc, CostExpAcc) of
				{ok, CostGameMoneyAcc2, CostExpAcc2} ->
					SkillLv2 = SkillLv + 1,
					case SkillLv2 =< player:get_lv(PS) of
						?true ->
							Skill2 = Skill#skl_brief{lv = SkillLv2},
							FactionSkills3 = [Skill2|FactionSkills2],
							PS2 = set_faction_skills(PS, FactionSkills3),
							{ok, PS2, CostGameMoneyAcc2, CostExpAcc2};
						?false ->
							{fail, ?PM_XF_UPGRADE_FAIL_FOR_PLAYER_LV_LIMIT}
					end;
				{fail, Reason} ->
					{fail, Reason}
			end;
		false ->
			{fail, ?PM_PARA_ERROR}
	end.


 %% 检查是否满足升级所需的消耗(这里做一下处理扩展一个外面进来的累加值)
%% @return: {ok, CostGameMoney, CostExp} | {fail, Reason}
check_upgrade_faction_skill_costs(PS, Skill, CostGameMoneyAcc, CostExpAcc) ->
	case data_xinfa_upg_costs:get(Skill#skl_brief.lv) of
		#xf_upg_costs{gamemoney = CostGameMoney0, exp = CostExp0} ->
			CostGameMoney = CostGameMoneyAcc + CostGameMoney0,
			CostExp = CostExpAcc + CostExp0,
			% 钱是否够？
			?ASSERT(util:is_nonnegative_int(CostGameMoney), Skill),
%%			?WARNING_MSG("?MNY_T_GAMEMONEY=~p, ~p~n",[?MNY_T_GAMEMONEY, CostGameMoney]),
			case player:has_enough_money(PS, ?MNY_T_GAMEMONEY, CostGameMoney) of
				false ->
					{fail, ?PM_MONEY_LIMIT};
				true ->
					% 经验是否够？
					?ASSERT(util:is_nonnegative_int(CostExp), Skill),
					case player:get_exp(PS) >= CostExp of
						false ->
							{fail, ?PM_EXP_LIMIT};
						true ->
							{ok, CostGameMoney, CostExp}
					end
			end;
		_ ->
			{fail, ?PM_XF_ALRDY_MAX_LV}
	end.
		


%% 转换门派
transform_faction(_PS, 0) ->
	{fail, ?PM_PARA_ERROR};

transform_faction(PS, Faction) ->
	%% 检查门派参数是否存在，且不为0，检查门派转换次数是否达到当天最大次数和转换消耗是否足够
	case player:get_faction(PS) of
		Faction ->
			% 直接返回成功或者忽略？
			ok;
		_FactionOld ->
			PlayerId = player:get_id(PS),
			case data_faction:get(Faction) of
				#faction_base{skills = Skills} ->
					case data_special_config:get(faction_change_cost) of
						[] ->
							{fail, ?PM_DATA_CONFIG_ERROR};
						CostList ->
							DayTransformTimes = player:get_day_transform_times(PS),
							case get_transform_cost(CostList, DayTransformTimes) of
								{PriceType, Price} ->
									case player:check_need_price(PS, PriceType, Price) of
										ok ->
											player:cost_money(PS, PriceType, Price, [?LOG_ROLE, "transform_faction"]),
											%% 从原门派列表删除
											del_from_faction_player_list(player:get_faction(PS), player:id(PS)),
											%% 添加到新门派
											add_to_faction_player_list(Faction, player:id(PS)),

											FactionBase = data_faction:get(Faction),


											%% 设置PS的门派
											player:set_faction(PS, Faction),
											%% 保存门派到数据库
											db_save_faction(PlayerId,Faction),
											%% 设置性别
											player:set_sex(PS, FactionBase#faction_base.sex_limit),
											% 保存性别到数据库
											player:db_save_sex(PlayerId,FactionBase#faction_base.sex_limit),
											player:set_last_transform_time(PS, util:unixtime()),
											player:set_day_transform_times(PS, DayTransformTimes + 1),
											
											%% 替换门派技能数据
											Pred = fun({SkillId, Lv}, Acc) ->
														   case player:get_lv(PS) >= Lv of
															   ?true ->
																   [SkillId|Acc];
															   ?false ->
																   Acc
														   end
												   end,
											case lists:foldl(Pred, [], Skills) of
												[] ->
													ok;
												L0 ->
													case get_faction_skills(PS) of
														[] ->
															ok;
														FactionSkills ->
															FactionSkills2 = lists:keysort(#skl_brief.id, FactionSkills),
															L = lists:sort(L0),
															Max = min(length(L), length(FactionSkills2)),    %% 因为是按id大小替换对应的技能，这里做个数量不一致的容错处理?
															FactionSkills3 = 
																lists:foldl(fun(N, Acc) ->
																					NewSkillId = lists:nth(N, L),
																					Skill = lists:nth(N, FactionSkills2),
																					[Skill#skl_brief{id = NewSkillId}|Acc]
																			end, [], lists:seq(1, Max)),
															PS2 = set_faction_skills(PS, FactionSkills3),
															player_syn:update_PS_to_ets(PS2),
															ok
													end
											end,

											% 放弃原来师门任务，然后按同等级接受新师门任务，避免刷师门任务
											case lib_task:get_trigger() of
												L1 when L1 /= [] ->
													NewL =
														lists:filter(
															fun({TaskId,_State}) ->
																case data_task:get(TaskId) of
																	#task{type = ?TASK_FACTION_TYPE} -> false;
																	_ -> true
																end
															 end, L1),
													lib_task:set_trigger(NewL);
												_ ->
													skip
											end,
											case lib_task:get_accepted_list() of
												L2 when L2 /= [] ->
													Ret1 = lists:foldl(
														fun(TaskId,Acc) ->
															case data_task:get(TaskId) of
																#task{type = ?TASK_FACTION_TYPE, ring = R} ->
																	OldRing0 = lib_task:get_task_ring(element(1,R)),
																	lib_task:abandon(TaskId, PS),
																	[{OldRing0,TaskId}|Acc];
																_ -> Acc
															end
														end, {[],0}, L2),
													case Ret1 of
														[{OldRing,OldFacTaskId}|_] ->
															% 特殊处理，把任务进度转移到新的师门任务
															NewFacTaskId = 1040000 + Faction * 1000 + OldFacTaskId rem 1000,
															FacMasterId = 1040000 + Faction * 1000 + 100,
															lib_task:set_task_ring(FacMasterId, OldRing#task_ring{masterId = FacMasterId}),
															lib_task:force_accept(NewFacTaskId, PS);
														_ ->
															skip
													end;

												_ ->
													skip
											end,
											ok;
										Reason ->
											{fail, Reason}
									end;
								_ ->
									%% 参数错误
									{fail, ?PM_PARA_ERROR}
							end
					end;
				_ ->
					%% 参数错误
					{fail, ?PM_PARA_ERROR}
			end
	end.


%% 获取转换消耗
get_transform_cost(CostList, SlotCurrent) ->
	L = lists:keysort(1, CostList),
	get_transform_cost(SlotCurrent, L, null).

get_transform_cost(_SlotCurrent, [], Last) ->
	Last;

get_transform_cost(SlotCurrent, [{N, T, V}|L], _Last) ->
	case N >= SlotCurrent of
		?true ->
			{T, V};
		?false ->
			get_transform_cost(SlotCurrent, L, {T, V})
	end.


%% 玩家获取转换消耗信息
transform_faction_cost(PS) ->
	case data_special_config:get(faction_change_cost) of
		[] ->
			{fail, ?PM_DATA_CONFIG_ERROR};
		CostList ->
			DayTransformTimes = player:get_day_transform_times(PS),
			case get_transform_cost(CostList, DayTransformTimes) of
				{PriceType, Price} ->
					{ok, PriceType, Price};	
				_ ->
					{fail, ?PM_PARA_ERROR}
			end
	end.
	


