%%%-------------------------------------- 
%%% @Module: lib_robot
%%% @Author: huangjf
%%% @Created: 2012.6.13
%%% @Description: 自动挂机系统相关的接口
%%%-------------------------------------- 
-module(lib_robot).

% -include("common.hrl").
% -include("record.hrl").
% -include("hang.hrl").
% -include("battle.hrl").


% -export([	
% 			get_skill_comb/2,
% 			get_cur_use_skl_comb_id/1,
% 			get_cur_use_skill_comb/1,
% 			get_cur_am_skill_id_list/1,
% 			set_skill_comb/3,
% 			clear_skill_comb/2,
% 			select_skill_comb/2,
% 			set_auto_buy_hp_bag/2,
% 			get_can_add_to_comb_recommend_skills/2,
			
% 			is_auto_buy_hp_bag/1,
			
% 			open_auto_mf_to_player/1,
			
% 			sys_auto_set_cur_use_skill_comb/1,
			
% 			db_save_auto_mf_info/1,
% 			db_load_auto_mf_info/3,
			
% 			get_recommend_skl_comb_set/2,
% 			get_recommend_skl_comb_set/3
% 		]).
		
		

% %% 是否自动购买气血包
% %% @return: true | false		
% is_auto_buy_hp_bag(PS) ->
% 	AMInfo = PS#player_status.auto_mf_info,
% 	AMInfo#role_am.auto_buy_hp_bag.




% %% 获取玩家的挂机推荐技能组合设置（技能id列表）
% %% @para: Career => 玩家的职业
% %% @return: 技能id列表
% get_recommend_skl_comb_set(player, Career) ->
% 	data_am_skill:get_recommend_comb_set(player, 0, Career).
	

% %% 获取武将的挂机推荐技能组合设置（技能id列表）
% %% @para: ParTypeId => 武将类型id, Career => 武将的职业
% %% @return: 技能id列表
% get_recommend_skl_comb_set(partner, ParTypeId, Career) ->
% 	data_am_skill:get_recommend_comb_set(partner, ParTypeId, Career).
	
	

	



	



% %% 系统自动设置当前所使用的技能组合（学习新技能后，或一开始开放挂机系统给玩家时，会调用该接口）
% %% @return: 更新后的玩家状态
% sys_auto_set_cur_use_skill_comb(PS) ->
% 	?ASSERT(is_record(PS, player_status), PS),
% 	case PS#player_status.lv < ?START_AUTO_MF_NEED_LV of
% 		true -> % 未到开放挂机系统所需的等级，不需做处理
% 			PS;
% 		false ->
% 			CurId = get_cur_use_skl_comb_id(PS),
% 			?TRACE("sys_auto_set_cur_use_skill_comb(), OldCombSet: ~w~n", [get_skill_comb(PS, CurId)]),
% 			?DEBUG_MSG("sys_auto_set_cur_use_skill_comb(), OldCombSet: ~w~n", [get_skill_comb(PS, CurId)]),
% 			% 1. 清空技能组合.
% 			NewPS = clear_skill_comb(PS, CurId),
			
% 			% 2. 重新自动添加技能到组合
% 			AllSkills = lib_player:get_learned_skill_id_list(PS),
% 			% 过滤掉不能在战斗中直接使用的技能（比如被动技）
% 			CanAddSkills = [SkillId || SkillId <- AllSkills, lib_skill:is_skill_can_use_in_battle(SkillId)],
			
% 			% 按职业的推荐设置顺序，排序一下
% 			RecommendSet = get_recommend_skl_comb_set(player, PS#player_status.career),
% 			NewCombSet = [X || X <- RecommendSet, lists:member(X, CanAddSkills)],
			
% 			GridList = lists:seq(1, length(NewCombSet)),
% 			% zip一下，使得格式如：[{技能id, 格子位置}, ...]
% 			NewCombSet_WithGrid = lists:zip(NewCombSet, GridList),
			
% 			?DEBUG_MSG("sys_auto_set_cur_use_skill_comb(), NewCombSet_WithGrid: ~w", [NewCombSet_WithGrid]),
			
% 			NewPS2 = set_skill_comb(NewPS, CurId, NewCombSet_WithGrid),
% 			NewPS2
% 	end.
	
	
			
	
	


		

% %% 开放自动挂机系统给玩家
% open_auto_mf_to_player(PS) ->
% 	PlayerId = PS#player_status.id,
% 	?TRACE("open auto mf to player, id: ~p...~n", [PlayerId]),
% 	%%Sql = io_lib:format(<<"SELECT count(*) FROM `skill_comb` WHERE player_id=~p">>, [PlayerId]),
% 	%%case dbxx_esql:get_row(Sql) of
% 	case db:select_row(role_am, "count(*)", [{player_id, PlayerId}]) of
% 		[1] ->
% 			% 已开放挂机系统给玩家了（注：正常流程是不会出现此情况的，除非使用了调等级的gm指令）
% 			?TRACE("already open auto mf to player, so skip...~n"),
% 			skip;
% 		[0] ->
% 			?TRACE("haven't open auto mf to player yet, so open...~n"),
			
% 			% 初始化自动挂机信息
% 			InitAMInfo = #role_am{
% 							skill_combs = make_default_empty_skill_combs(),
% 							cur_use_comb_id = 1,  % 初始为使用第1个技能组合
% 							auto_buy_hp_bag = false
% 							},
% 			PS2 = PS#player_status{auto_mf_info = InitAMInfo},
% 			% 系统自动帮玩家设置一下技能组合
% 			PS3 = sys_auto_set_cur_use_skill_comb(PS2),
			
% 			NewInitAMInfo = PS3#player_status.auto_mf_info,
			
% 			?TRACE("open_auto_mf_to_player()!!! NewInitAMInfo: ~p~n", [NewInitAMInfo]),
% 			% 插入一条记录到数据库的skill_comb表
% 			insert_one_record_to_skill_comb(PlayerId, NewInitAMInfo),
			
% 			% cast更新到玩家进程
% 			gen_server:cast(PS#player_status.pid, {'SET_AUTO_MF_INFO', NewInitAMInfo});
% 		_Any -> % db操作出错
% 			?ASSERT(false, _Any),
% 			skip	
% 	end.
	
	
	
	

% %% 保存玩家的挂机信息到db
% db_save_auto_mf_info(PS) ->
% 	?TRACE("db_save_auto_mf_info()....~n"),
% 	case PS#player_status.lv < ?START_AUTO_MF_NEED_LV of
% 		true -> % 还没到开放自动挂机功能的等级，则跳过
% 			skip;
% 		false ->
% 			AMInfo =  PS#player_status.auto_mf_info,
% 			SkillCombs = AMInfo#role_am.skill_combs,
% 			%%Sql = io_lib:format("UPDATE `skill_comb` SET combs='~s', cur_use_comb_id=~p, anger_lim=~p WHERE player_id=~p", 
% 			%%						[case util:term_to_bitstring(SkillCombs) of <<"undefined">> -> <<>>; Any -> Any end,
% 			%%						 AMInfo#role_am.cur_use_comb_id,
% 			%%						 AMInfo#role_am.anger_lim,
% 			%%						 PS#player_status.id
% 			%%						 ]),
% 			%%dbxx_esql:execute(Sql)
			
% 			db:update(role_am,
% 						["skill_combs", "cur_use_comb_id", "auto_buy_hp_bag"],
% 						[case util:term_to_bitstring(SkillCombs) of <<"undefined">> -> <<>>; Any -> Any end,
% 						 AMInfo#role_am.cur_use_comb_id,
% 						 util:bool_to_int(AMInfo#role_am.auto_buy_hp_bag)
% 						],
% 						"player_id",
% 						PS#player_status.id)
% 	end.
	


% %% 从数据库加载玩家的自动挂机信息
% %% @para: PlayerPid => 玩家进程pid， PlayerId => 玩家id
% %% @return: 没用
% db_load_auto_mf_info(PlayerPid, PlayerId, PlayerLv) ->
% 	case PlayerLv < ?START_AUTO_MF_NEED_LV of
% 		true -> % 还没到开放自动挂机功能的等级，则跳过
% 			skip;
% 		false ->
% 			%%Sql = io_lib:format("SELECT combs, cur_use_comb_id, anger_lim FROM `skill_comb` WHERE player_id=~p", [PlayerId]),
% 			%%case dbxx_esql:get_row(Sql) of
% 			case db:select_row(role_am, "skill_combs, cur_use_comb_id, auto_buy_hp_bag", [{player_id, PlayerId}]) of
% 				[] ->
% 					?ERROR_MSG("[HANG]load_auto_mf_info_from_db() failed!!! player id: ~p", [PlayerId]),
% 					?ASSERT(false, PlayerId),
% 					skip;
% 				[Str_SkillCombs, CurUseCombId, AutoBuyHpBag] ->
% 					SkillCombs = case util:bitstring_to_term(Str_SkillCombs) of
%  									undefined -> make_default_empty_skill_combs();
%  									RetList -> ?ASSERT(is_list(RetList)), RetList
%  								 end,
 								 
%  					SkillCombs2 = adjust_skill_combs(SkillCombs),
 					
% 					AMInfo = #role_am{
% 								skill_combs = SkillCombs2,
% 								cur_use_comb_id = CurUseCombId,
% 								auto_buy_hp_bag = util:int_to_bool(AutoBuyHpBag)
% 								},
% 					?TRACE("load_auto_mf_info_from_db(), auto mf info: ~p~n", [AMInfo]),
% 					gen_server:cast(PlayerPid, {'SET_AUTO_MF_INFO', AMInfo});
% 				_ ->
% 					?ASSERT(false, PlayerId),
% 					skip	
% 			end
% 	end.
	



% %% 获取玩家当前使用的挂机技能组合
% %% @return: [] | [{技能id, Grid}, ...]
% get_cur_use_skill_comb(PS) ->
% 	AMInfo = PS#player_status.auto_mf_info,
% 	CurUseCombId = AMInfo#role_am.cur_use_comb_id,
% 	get_skill_comb(PS, CurUseCombId).
	

% %% 获取玩家当前使用的挂机技能组合的技能id列表
% %% @return: [] | 技能id列表
% get_cur_am_skill_id_list(PS) ->
% 	SkillComb = get_cur_use_skill_comb(PS),
% 	% 按格子顺序排序一下（从小到大）
% 	F = fun(A, B) ->
% 			{_SkillId1, Grid1} = A,
% 			{_SkillId2, Grid2} = B,
% 			Grid1 < Grid2
% 		end,
% 	SortedSkillComb = lists:sort(F, SkillComb),
% 	L = [SkillId || {SkillId, _Grid} <- SortedSkillComb],
% 	% 纠错（同时也是为了容错）：过滤掉不在已学技能列表中的技能
% 	LrnSkillIdList = lib_player:get_learned_skill_id_list(PS),
% 	[SkillId || SkillId <- L, lists:member(SkillId, LrnSkillIdList)].
	


% %% 获取玩家的第xx个挂机技能组合
% %% @return: [] | [{技能id, Grid}, ...]
% get_skill_comb(PS, CombId) ->
% 	case util:is_in_range(CombId, 1, ?MAX_SKILL_COMB_COUNT) of
% 		true ->
% 			AMInfo = PS#player_status.auto_mf_info,
% 			lists:nth(CombId, AMInfo#role_am.skill_combs);
% 		false ->
% 			?ASSERT(false, CombId),
% 			[]
% 	end.
	
	
% %% 获取玩家当前所使用的技能组合id
% get_cur_use_skl_comb_id(PS) ->
% 	AMInfo = PS#player_status.auto_mf_info,
% 	AMInfo#role_am.cur_use_comb_id.
	
	
% %% 设置挂机的技能组合
% %% @para: CombId => 组合id， NewComb => 新的技能组合信息，格式如：[{技能id, Grid}, ...]
% %% @return: 新的玩家状态
% set_skill_comb(PS, CombId, NewComb) ->
% 	?ASSERT(util:is_in_range(CombId, 1, ?MAX_SKILL_COMB_COUNT)),
% 	?ASSERT(length(NewComb) =< ?MAX_SKILL_IN_COMB),
	
% 	AMInfo = PS#player_status.auto_mf_info,
% 	OldSkillCombs = AMInfo#role_am.skill_combs,
	
% 	{CombList1, CombList2} = lists:split(CombId - 1, OldSkillCombs),
	
% 	[_OldComb | T] = CombList2,
	
% 	NewCombList2 = [NewComb | T],
	
% 	NewSkillCombs = CombList1 ++ NewCombList2,
% 	?TRACE("set_skill_comb(), NewSkillCombs:~p~n", [NewSkillCombs]),
	
% 	NewAMInfo = AMInfo#role_am{skill_combs = NewSkillCombs},
% 	PS#player_status{auto_mf_info = NewAMInfo}.
	

	
% %% 清空挂机的技能组合
% %% @return: 新的玩家状态
% clear_skill_comb(PS, CombId) ->
% 	?ASSERT(util:is_in_range(CombId, 1, ?MAX_SKILL_COMB_COUNT)),
% 	set_skill_comb(PS, CombId, []).
	
	




	
	
% %% 选择挂机所使用的技能组合
% %% @return: 新的玩家状态
% select_skill_comb(PS, CombId) ->
% 	?ASSERT(util:is_in_range(CombId, 1, ?MAX_SKILL_COMB_COUNT)),
% 	AMInfo = PS#player_status.auto_mf_info,
% 	NewAMInfo = AMInfo#role_am{cur_use_comb_id = CombId},
% 	PS#player_status{auto_mf_info = NewAMInfo}.
	
	
% %% 设置挂机的怒气上限	
% %%set_anger_lim(PS, AngerLim) ->
% %%	?ASSERT(util:is_in_range(AngerLim, 1, ?MAX_BO_ANGER)),
% %%	AMInfo = PS#player_status.auto_mf_info,
% %%	NewAMInfo = AMInfo#role_am{anger_lim = AngerLim},
% %%	PS#player_status{auto_mf_info = NewAMInfo}.


% %% 设置是否自动购买气血包
% %% @return: 新的玩家状态
% set_auto_buy_hp_bag(PS, Flag) ->
% 	?ASSERT(is_boolean(Flag), Flag),
% 	AMInfo = PS#player_status.auto_mf_info,
% 	NewAMInfo = AMInfo#role_am{auto_buy_hp_bag = Flag},
% 	PS#player_status{auto_mf_info = NewAMInfo}.
	


% %% 获取可添加到技能组合的新的已学技能id列表（这些技能同时也需在挂机推荐技能组合中）
% %% @return: [] | 技能id列表
% get_can_add_to_comb_recommend_skills(PS, CurSkillIdList) ->
% 	AvailGridCount = ?MAX_SKILL_IN_COMB - length(CurSkillIdList), % 空闲格子的数量
	
% 	case AvailGridCount of
% 		0 ->
% 			[];
% 		_ ->
% 			AllSkills = [SkillId || {SkillId, _SkillLv, _Grid} <- PS#player_status.skill],
% 			NewSkills = AllSkills -- CurSkillIdList,
% 			% 过滤掉不能在战斗中直接使用的技能（比如被动技）
% 			CanAddSkills = [SkillId || SkillId <- NewSkills, lib_skill:is_skill_can_use_in_battle(SkillId)],
			
% 			% 按职业的推荐设置顺序，排序一下
% 			RecommendSet = get_recommend_skl_comb_set(player, PS#player_status.career),
% 			L = [X || X <- RecommendSet, lists:member(X, CanAddSkills)],
% 			lists:sublist(L, AvailGridCount)
% 	end.
	
			
	
	
	


% %% =================================== Local Functions ====================================


% %% 构造玩家的初始自动挂机设置
% %%make_init_auto_mf_info() ->
% %%	%%SkillIdList = lib_player:get_equipped_skill_id_list(PS), 
% %%	%%GridList = lists:seq(1, length(SkillIdList)),
% %%	
% %%	%%SkillComb = lists:zip(SkillIdList, GridList),  % zip一下，使得格式如：[{技能id, 格子位置}, ...]
% %%	%%InitSkillCombs = [SkillComb, []],  % 初始第一个组合和玩家的eq_skill对应，第2个组合为空
% %%	#role_am{
% %%		%%skill_combs = InitSkillCombs,
% %%		skill_combs = make_default_empty_skill_combs(),
% %%		cur_use_comb_id = 1,
% %%		auto_buy_hp_bag = false
% %%		}.
		

% %% 构造默认的技能组合列表（默认都为空组合，形如：[[], [], ...]）
% make_default_empty_skill_combs() ->
% 	lists:duplicate(?MAX_SKILL_COMB_COUNT, []).


% %% 插入一条记录到数据库的skill_comb表
% insert_one_record_to_skill_comb(PlayerId, InitAMInfo) ->
% 	?TRACE("insert_one_record_to_skill_comb(), player id: ~p~n", [PlayerId]),
% 	SkillCombs = case util:term_to_bitstring(InitAMInfo#role_am.skill_combs) of
% 					<<"undefined">> -> 
% 						<<>>;
% 					Any -> Any
% 				 end,
% 	%%AngerLim = InitAMInfo#role_am.anger_lim,
% 	%%Sql = dbxx_esql:make_insert_sql(skill_comb, ["player_id", "combs", "anger_lim"], [PlayerId, SkillCombs, AngerLim]),
% 	%%_SqlRet = dbxx_esql:execute(Sql),
% 	%%?ASSERT(_SqlRet =:= 1),
	
% 	_SqlRet = db:insert(role_am, ["player_id", "skill_combs"], [PlayerId, SkillCombs]),
% 	?ASSERT(_SqlRet =:= 1),
% 	void.	
	
	
% %% 矫正技能组合列表，把组合个数矫正为MAX_SKILL_COMB_COUNT个，以应对策划对技能组合数做更改的变化（比如：玩家原来最多有两个技能组合，后来策划改为玩家可以有3个技能组合）
% %% @para: 待矫正的技能组合列表
% %% @return：矫正后的技能组合列表
% adjust_skill_combs(SkillCombs) ->
% 	if 
% 		length(SkillCombs) == ?MAX_SKILL_COMB_COUNT -> % 不需矫正
% 			SkillCombs;
% 		length(SkillCombs) < ?MAX_SKILL_COMB_COUNT -> % 需填充空组合，以凑满MAX_SKILL_COMB_COUNT个
% 			Diff = ?MAX_SKILL_COMB_COUNT - length(SkillCombs),
% 			SkillCombs ++ lists:duplicate(Diff, []);
% 		true -> % 需裁剪超出的组合（只取前面MAX_SKILL_COMB_COUNT个组合）
% 			lists:sublist(SkillCombs, ?MAX_SKILL_COMB_COUNT)
%  	end.