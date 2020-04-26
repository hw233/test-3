%%%-----------------------------------
%%% @Module  : lib_arena
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2012.1.14
%%% @Description: 竞技场系统
%%%-----------------------------------

-module(lib_arena).

% -export([
% 		db_insert_one_record_to_arena/1,
% 		db_insert_one_record_to_battle_data/2,
% 		get_today_left_can_chal_times/1,
% 		get_grade_by_rank/1,
% 		make_arena_base_info/1,
% 		notify_battle_result_to_both/6,
% 		notify_new_arena_info_to_both/2,
% 		notify_my_arena_info_changed/2,
% 		calc_cancel_chal_cd_need_money/1,
% 		get_title_by_rank/1,
% 		calc_award_acc_points/2,
% 		notify_my_opponent_list_changed/2,
% 		get_more_chal_times_by_vip_lv/1
% 		]).
		
			
% -include("common.hrl").
% -include("record.hrl").
% -include("arena.hrl").
% -include("protocol/pt_23.hrl").
% -include("player.hrl").
% -include("abbreviate.hrl").



% % VIP玩家额外多出的每天可挑战次数
% get_more_chal_times_by_vip_lv(VipLv) ->
% 	case VipLv of
% 		?VIP_LV_0 -> 	0;  % 非vip没有多出的次数
% 		?VIP_LV_1 ->	5;
% 		?VIP_LV_2 ->	3;
% 		?VIP_LV_3 ->	5;
% 		?VIP_LV_4 ->	8;
% 		?VIP_LV_5 ->	10
% 	end.
	
	
% %% 获取玩家当天在竞技场的剩余可挑战次数（限本地节点调用，并且暂时只支持获取在线玩家的）
% %% @para: PS => 玩家状态（player_status结构体）， ArInfo => 玩家的竞技场信息（arena结构体）
% %% @return: {fail} | {ok, 剩余可挑战次数}
% get_today_left_can_chal_times(ArInfo) ->
% 	PlayerId = ArInfo#arena.id,
% 	case get_today_total_can_chal_times(PlayerId) of
% 		{fail} ->
% 			{fail};
% 		{ok, TotalCanChalTimes} ->
% 			AlreadyChalTimes = ArInfo#arena.already_chal_times,
% 			LeftCanChalTimes = max(TotalCanChalTimes - AlreadyChalTimes, 0),  % 做范围矫正，避免出现负数的情况
% 			{ok, LeftCanChalTimes}
% 	end.

	

% % 插入一条记录到数据库的arena表
% db_insert_one_record_to_arena(PS) ->
% 	?TRACE("db_insert_one_record_to arnea...~n"),
% 	PlayerId = PS#player_status.id,
% 	% 获取全服当前的最后排名
% 	CurLastRank = case db:select_count(arena, []) of
% 		[] ->
% 			?ASSERT(false),
% 			?AR_RANK_INVALID;
% 		[RetRank] ->
% 			?ASSERT(is_integer(RetRank)),
% 			RetRank
% 	end,
% 	% 初始化排名为全服最后一名
% 	MyInitRank = CurLastRank + 1,
% 	?TRACE("player id: ~p, init rank: ~p~n", [PlayerId, MyInitRank]),
% 	Date = lib_common:date_to_int(erlang:date()),
	
% 	AlreadyChalTimes = 0,
% 	_SqlRet = db:insert(arena, ["player_id", "battle_capacity", "rank", "already_chal_times", "can_refresh_oppo_times", "can_worship_arena_king", "can_admire_arena_king", "date"], 
%     									[PlayerId, PS#player_status.battle_power, MyInitRank, AlreadyChalTimes, ?TIMES_CAN_REFRESH_OPPO_LIST_ONE_DAY, 1, 1, Date]),
% 	?ASSERT(_SqlRet =:= 1).
	
	
	
% % 插入一条记录到数据库的battle_data表
% db_insert_one_record_to_battle_data(Id, BattleObjType) ->
% 	?TRACE("db_insert_one_record_to_battle_data(), id: ~p, type:~p~n", [Id, BattleObjType]),
% 	?ASSERT(BattleObjType =:= ?BO_PLAYER orelse BattleObjType =:= ?BO_PARTNER),
% 	_SqlRet = db:insert(battle_data, ["id", "type"], [Id, BattleObjType]),
% 	?ASSERT(_SqlRet =:= 1).
	
	
	
	
% %% 依据积分计算对应等级段
% %%calc_grade_by_acc_points(AccPoints) ->
% %%	if  AccPoints < 10 ->
% %%			?AR_GRADE_WHITE; % 白带
% %%		true ->
% %%			if  AccPoints < 20 ->
% %%					?AR_GRADE_BLUE; % 蓝带
% %%				true ->
% %%					if  AccPoints < 30 ->
% %%							?AR_GRADE_PURPLE; % 紫带
% %%						true ->
% %%							if  AccPoints < 40 ->
% %%									?AR_GRADE_ORANGE; % 橙带
% %%								true ->
% %%									?AR_GRADE_BLACK   % 黑带
% %%							end
% %%					end
% %%			end
% %%	end.

% %% 依据排名计算对应等级段	
% get_grade_by_rank(Rank) ->
% 	if  Rank < 3 ->
% 			?AR_GRADE_YELLOW; % 黄带
% 		true ->
% 			if  Rank < 5 ->
% 					?AR_GRADE_ORANGE; % 橙带
% 				true ->
% 					if  Rank < 7 ->
% 							?AR_GRADE_PURPLE; % 紫带
% 						true ->
% 							if  Rank < 9 ->
% 									?AR_GRADE_BLUE;   % 蓝带
% 								true ->
% 									?AR_GRADE_GREEN   % 绿带
% 							end
% 					end
% 			end
% 	end.
	
	
% %% 依据排名获取称号
% get_title_by_rank(Rank) ->
% 	if  Rank =:= 1 ->
% 			<<"战天神">>;
% 		true ->
% 			if  Rank =< 10 ->
% 					<<"战天王">>;
% 				true ->
% 					if  Rank =< 20 ->
% 							<<"战天侯">>;
% 						true ->
% 							if  Rank =< 30 ->
% 									<<"战天爵">>;
% 								true ->
% 									if  Rank =< 40 ->
% 											<<"战天将">>;
% 										true ->
% 											if  Rank =< 50 ->
% 													<<"战天士">>;
% 												true ->
% 													<<"战天勇者">>
% 											end
% 									end
% 							end
% 					end
% 			end
% 	end.	



% %% 通知竞技场的战斗结果给挑战方
% %% @para: Challenger => 挑战方， Passive => 被挑战方， 
% %%        WinOrLose=> 挑战方是赢了还是输了，ExtraData => 额外数据（如奖励的积分，声望等）
% notify_battle_result_to_both(OldChalgr, OldPassive, Challenger, Passive, WinOrLose, ExtraData) ->
% 	?TRACE("notify_battle_result_to_both....~n"),
% 	case WinOrLose of
% 		win ->
% 			ResCode = 1,
% 			AwardRepu = 10;
% 		lose ->
% 			ResCode = 0,
% 			AwardRepu = 2
% 	end,
% 	[AwardAccPoints]  = ExtraData,
% 	PassiveNameBin = list_to_binary(Passive#arena.name),
% 	ChalgrNameBin = list_to_binary(Challenger#arena.name),
% 	Data = <<
% 				ResCode : 8,
% 				(OldChalgr#arena.rank) : 32,  % 原来的排名
% 				(Challenger#arena.rank) : 32, % 新的排名 
% 				AwardRepu : 16,
% 				AwardAccPoints : 16,
% 				(byte_size(PassiveNameBin)): 16,
% 				PassiveNameBin /binary,
% 				(Passive#arena.lv) : 16,
% 				(Passive#arena.id) : 32
% 		  >>,
% 	RespData = pt:pack(?PT_AR_NOTIFY_BATTLE_RES_TO_CHALLENGER, Data),
% 	lib_send:send_to_uid(Challenger#arena.id, RespData),
	
% 	% 注意这里ResCode和通知挑战方的情况是反过来的
% 	ResCode2 = case WinOrLose of
% 		win -> 0;
% 		lose -> 1
% 	end,
% 	Data2 = <<
% 				(ResCode2) : 8,
% 				(OldPassive#arena.rank) : 32,  % 原来的排名
% 				(Passive#arena.rank) : 32,     % 新的排名
% 				(byte_size(ChalgrNameBin)): 16,
% 				ChalgrNameBin /binary,
% 				(Challenger#arena.lv) : 16,
% 				(Challenger#arena.id) : 32
% 		  >>,
% 	RespData2 = pt:pack(?PT_AR_NOTIFY_BATTLE_RES_TO_PASSIVE, Data2),
% 	lib_send:send_to_uid(Passive#arena.id, RespData2).
	
	

% %% 通知新的竞技场数据给挑战方和被挑战方
% notify_new_arena_info_to_both(NewChallengerArInfo, NewPassiveArInfo) ->
% 	?TRACE("notify_new_arena_info_to_both...~n"),
% 	% 通知挑战方
% 	notify_my_arena_info_changed(world_node, NewChallengerArInfo),
% 	% 通知被挑战方
% 	notify_my_arena_info_changed(world_node, NewPassiveArInfo).
	
	

% %% 通知客户端刷新竞技场信息（用于在世界节点上调用）
% notify_my_arena_info_changed(world_node, NewArInfo) ->
% 	PlayerId = NewArInfo#arena.id,
% 	PlayerProcName = misc:player_process_name(PlayerId),
% 	gen_server:cast({global, PlayerProcName}, {'NOTIFY_MY_ARENA_INFO_CHANGED', NewArInfo});
	
% %% 通知客户端刷新竞技场信息（用于在本地节点上调用）
% notify_my_arena_info_changed(local_node, NewArInfo) ->
% 	case pt_23:write(?PT_AR_QUERY_MY_ARENA_INFO, NewArInfo) of
% 		{fail} ->
% 			skip;
% 		{ok, BinData} ->
% 			?TRACE("do notify_my_arena_info_changed in local node...~n"),
% 			lib_send:send_to_uid(NewArInfo#arena.id, BinData)
% 	end.
	
	
			
	
	

	

% %% 计算取消挑战cd所需的元宝	
% calc_cancel_chal_cd_need_money(CDLeftTime_Sec) ->
% 	util:ceil(CDLeftTime_Sec / (5*60)).
	

% %% 计算挑战赢了后奖励的积分
% %% @para: ChalgrRank => 挑战方的排名， PassiveRank => 被挑战方的排名
% calc_award_acc_points(ChalgrRank, PassiveRank) ->	
% 	Points = case ChalgrRank > ?MAX_RANK_NEED_CACHE of
% 				true ->
% 					util:floor((?MAX_RANK_NEED_CACHE - PassiveRank)/10) + 15;
% 				false ->
% 					util:floor((ChalgrRank - PassiveRank)/10) + 15
% 			end,
% 	% 范围矫正为5~25（注意到：上面算出的Points有可能为负数）
% 	util:minmax(Points, 5, 25).
	
	
	
	

% make_arena_base_info(SrcData) ->
% 	[Date, PlayerId, BattleCapacity, AccPoints, Rank, CurOppoListStr, AlreadyChalTimes, CanRefreshOppoTimes, WinningStreak, BattleHistoryStr, 
% 		CanWorshipArenaKing, CanAdmireArenaKing, EquipCurrentStr] = SrcData,
% 	Grade = get_grade_by_rank(Rank),
	
% 	% 当前对手的id列表
% 	CurOpponentList = case util:bitstring_to_term(CurOppoListStr) of
%  					undefined -> [];
%  					RetList -> ?ASSERT(is_list(RetList)), RetList
%  				end,
% 	%%?TRACE("cur opponent id list: ~p~n", [CurOpponentList]),
% 	% 战报记录
%  	BattleHistory = case util:bitstring_to_term(BattleHistoryStr) of
%  					undefined -> [];
%  					RetList2 -> ?ASSERT(is_list(RetList2)), RetList2
%  				end,
% 	%%?TRACE("battle his count: ~p,  ~p~n", [length(BattleHistory), BattleHistory]),
%  	% 当前装备:[武器，衣服，时装，坐骑]
%  	EquipCurrent = case util:bitstring_to_term(EquipCurrentStr) of
%  					undefined -> [];
%  					RetList3 -> ?ASSERT(is_list(RetList3)), RetList3
%  				end,
% 	%%?TRACE("equip current: ~p~n", [EquipCurrent]),
%  	% TODO： 这里做断言验证，以后可以去掉  ---- huangjf
%  	?Ifc (length(BattleHistory) > 0)
%  			[H| _T] = BattleHistory,
%  			?TRACE("got battle history record: ~p~n", [H]),
%  			?ASSERT(is_record(H, ar_battle_history))
%  	?End,
 	
% 	#arena{
% 			id = PlayerId,
% 			battle_capacity = BattleCapacity,
% 			acc_points = AccPoints,
% 			grade = Grade,
% 			rank = Rank,
% 			title = get_title_by_rank(Rank),
% 			cur_opponent_list = CurOpponentList,
% 			already_chal_times = AlreadyChalTimes,
% 			can_refresh_oppo_times = CanRefreshOppoTimes,
% 			winning_streak = WinningStreak,
% 			battle_history = BattleHistory,
% 			can_worship_arena_king = CanWorshipArenaKing,
% 			can_admire_arena_king = CanAdmireArenaKing,
% 			equip_current = EquipCurrent,
% 			date = Date
% 		}.
	



% %% 通知客户端刷新我的对手列表
% notify_my_opponent_list_changed(PlayerId, NewOppoArInfoList) ->
% 	{ok, BinData} = pt_23:write(?PT_AR_QUERY_MY_OPPONENT_LIST, NewOppoArInfoList),
%    	lib_send:send_to_uid(PlayerId, BinData).




% %% ====================================== local function ====================================================



% %% 获取玩家当天可以在竞技场挑战的总次数（限本地节点调用，并且暂时只支持获取在线玩家的）
% %% @return: {fail} | {ok, 当天可挑战的总次数}
% get_today_total_can_chal_times(PlayerId) ->
% 	case lib_player:get_online_info_fields(PlayerId, [vip]) of
% 		[] ->  % 玩家不在线，获取失败
% 			{fail};
% 		[VipLv] ->
% 			TotalTimes = ?TIMES_CAN_CHAL_ONE_DAY + lib_arena:get_more_chal_times_by_vip_lv(VipLv),
% 			{ok, TotalTimes}
% 	end.	