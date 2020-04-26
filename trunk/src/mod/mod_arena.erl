

%%%------------------------------------
%%% @Module  : mod_arena
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2012.1.14
%%% @Description: 竞技场系统
%%%------------------------------------
-module(mod_arena).
% -behaviour(gen_server).

% -export([start_link/0]).
% -export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

% -export([
% 		rpc_db_insert_one_record_to_arena/1,
% 		rpc_query_today_already_chal_times/1,
% 		rpc_refresh_my_opponent_list/1,
% 		rpc_handle_player_logout/1,
% 		rpc_query_my_arena_info/1,
% 		rpc_query_my_battle_history/1,
% 		rpc_query_arena_king_info/0,
		
% 		rpc_asyn_add_acc_points/2,
% 		rpc_sync_add_acc_points/2,
		
% 		rpc_visit_arena_king/2,
% 		rpc_query_my_opponent_list/1,
%         rpc_query_arena_ranking_list_for_rank/0,
% 		rpc_get_player_from_global_cache/1,
% 		rpc_get_partner_from_global_cache/1,
% 		rpc_query_arena_ranking_list/1,
% 		start_challenge/2,
% 		rpc_get_player_arena_rank/1,
% 		rpc_handle_arena_battle_ends/3,
% 		rpc_load_my_arena_info_to_global_cache/1,
% 		rpc_load_my_arena_info_to_global_cache/2,
% 		rpc_add_player_to_global_cache/1,
% 		rpc_add_partner_to_global_cache/1,
% 		rpc_update_player_to_global_cache/1,
% 		%%rpc_sync_update_player_to_global_cache/1,
% 		rpc_update_player_ident_flag_to_global_cache/2,
% 		rpc_update_partner_to_global_cache/1,
% 		rpc_update_arena_info_to_global_cache/1,
		
% 		rpc_get_next_can_chal_time/1,
% 		rpc_set_next_can_chal_time/2,
% 		rpc_get_can_refresh_oppo_list_times/1,
% 		rpc_set_can_refresh_oppo_list_times/2,
		
% 		rpc_clear_already_chal_times/1,
		
% 		query_arena_shop_goods/2,
% 		buy_goods/2,
		
% 		still_has_chal_times_today/1,
		
% 		just_for_test/0
% 		]).


% -include("common.hrl").
% -include("record.hrl").
% -include("player.hrl").
% -include("arena.hrl").
% -include("protocol/pt_23.hrl").
% -include("battle.hrl").
% -include("abbreviation.hrl").
% -include_lib("stdlib/include/ms_transform.hrl").



% -define(NEED_COST_TIMES_YES, 1).
% -define(NEED_COST_TIMES_NO, 0).

% -define(SQL_GET_ARENA_INFO, "date, player_id, battle_capacity, acc_points, rank, cur_opponent_list, already_chal_times, can_refresh_oppo_times, winning_streak, battle_history, can_worship_arena_king, can_admire_arena_king, equip_current").
	
	
% % -------------------------------------------------------------------------
% start_link() ->
%     gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
		
	

% %% 插入玩家对应的一条记录到数据库的arena表
% rpc_db_insert_one_record_to_arena(PS) ->
% 	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'db_insert_one_record_to_arena', PS}).

	    
% %% 从数据库加载玩家的竞技场信息到缓存    
% rpc_load_my_arena_info_to_global_cache(PlayerId) ->
% 	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'load_my_arena_info_to_global_cache', PlayerId}).
	
% %% 从数据库加载玩家的竞技场信息到缓存（等级不够的话则不需加载）
% rpc_load_my_arena_info_to_global_cache(PlayerId, PlayerLv) ->
% 	case PlayerLv < ?START_ARENA_NEED_LV of
% 		true ->
% 			?TRACE("rpc_load_my_arena_info_to_global_cache, lv limit, so skip~n"),
% 			skip;
% 		false ->
% 			gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'load_my_arena_info_to_global_cache', PlayerId})
% 	end.
	
	

% %% 添加玩家信息到全局缓存	
% rpc_add_player_to_global_cache(PlayerStatus) ->
% 	?ASSERT(is_record(PlayerStatus, player_status)),
% 	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'add_player_to_global_cache', PlayerStatus}).
	
% %% 添加武将信息到全局缓存	
% rpc_add_partner_to_global_cache(Partner) ->
% 	?ASSERT(is_record(Partner, ets_partner)),
% 	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'add_partner_to_global_cache', Partner}).

% %% 更新玩家信息到全局缓存（目前简单地调用rpc_add_player_to_global_cache()就可，因为再次添加也即是更新）
% %% @return: 没用
% rpc_update_player_to_global_cache(PlayerStatus) ->
% 	rpc_add_player_to_global_cache(PlayerStatus).

% %% 更新玩家信息到全局缓存（注意：这里是用call，是一个同步的操作）
% %% @return: fail | ok
% %%rpc_sync_update_player_to_global_cache(PlayerStatus) ->
% %%	?ASSERT(is_record(PlayerStatus, player_status)),
% %%	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'update_player_to_global_cache', PlayerStatus}) of
% %%		{'EXIT', _Reason} ->
% %%			?ERROR_MSG("[ARENA_ERR]rpc_sync_update_player_to_global_cache() failed!! reason: ~p", [_Reason]),
% %%			?ASSERT(false, _Reason),
% %%			fail;
% %%		ok ->
% %%			ok
% %%	end.
	
% %% 更新玩家的通缉状态到全局缓存	
% rpc_update_player_ident_flag_to_global_cache(PlayerId, NewIdentFlag) ->
% 	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'update_player_ident_flag_to_global_cache', PlayerId, NewIdentFlag}).
	

% %% 更新武将信息到全局缓存（目前简单地调用rpc_add_partner_to_global_cache()即可，因为再次添加也即是更新）	
% rpc_update_partner_to_global_cache(Partner) ->
% 	?ASSERT(is_record(Partner, ets_partner)),
% 	rpc_add_partner_to_global_cache(Partner).
    
% rpc_update_arena_info_to_global_cache(NewArInfo) ->
% 	?ASSERT(is_record(NewArInfo, arena)),
% 	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'update_arena_info_to_global_cache', NewArInfo}).



% %% 判断玩家当前是否还有次数可以去打竞技场（限本地节点调用，并且暂时只支持判断在线玩家的）
% %% @return: true | false
% still_has_chal_times_today(PS) ->
% 	case rpc_query_my_arena_info(PS) of
% 		{fail} ->
% 			false;
% 		{ok, ArInfo} ->
% 			case lib_arena:get_today_left_can_chal_times(ArInfo) of
% 				{fail} ->
% 					false;
% 				{ok, Times} ->
% 					Times > 0
% 			end
% 	end.
	
	
	
	

% %% 查询玩家当天在竞技场已经打过多少次了
% %% @return: {fail} | {ok, 玩家当天在竞技场已打的次数}
% rpc_query_today_already_chal_times(PS) ->
% 	case rpc_query_my_arena_info(PS) of
% 		{fail} ->
% 			{fail};
% 		{ok, ArInfo} ->
% 			Today = lib_common:date_to_int(erlang:date()),
% 			case ArInfo#arena.date /= Today of
% 				true ->
% 					{ok, 0};
% 				false ->
% 					{ok, ArInfo#arena.already_chal_times}
% 			end
% 	end.


% %% 查询玩家的竞技场数据
% %% @return: {fail} | {ok, arena结构体}
% rpc_query_my_arena_info(PS) when is_record(PS, player_status) ->
% 	case PS#player_status.lv < ?START_ARENA_NEED_LV of
% 		true ->
% 			{fail};
% 		false ->
% 			rpc_query_my_arena_info(PS#player_status.id)
% 	end;
% rpc_query_my_arena_info(PlayerId) ->
% 	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'query_my_arena_info', PlayerId}) of
%         {'EXIT', _Reason} ->
%         	?ASSERT(false, _Reason),
%             {fail};
%         null ->
%             {fail};
%         RetArInfo ->
%         	?ASSERT(is_record(RetArInfo, arena)),
%         	{ok, RetArInfo}
%     end.
    

% %% 刷新对手列表（重新抽取对手）    
% rpc_refresh_my_opponent_list(PlayerId) ->
% 	% 处理超时的情况
% 	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'refresh_my_opponent_list', PlayerId}) of
%         {'EXIT', _Reason} ->
%         	?ASSERT(false, _Reason),
%             {fail, ?AR_REFRESH_OPPO_LIST_FAIL_UNKNOWN};
%        	{fail, Why} ->
%        		{fail, Why};
%         {ok, NewOpponentList} ->
%         	?TRACE("new oppo list len: ~p~n", [length(NewOpponentList)]),
%         	{ok, NewOpponentList}
%     end.
    
    
% %% 查询我的竞技场最近战报记录（注意: 简单起见，函数返回值现在是返回整个竞技场信息）
% rpc_query_my_battle_history(PlayerId) ->
% 	?TRACE("rpc_query_my_battle_history()...~n"),
% 	rpc_query_my_arena_info(PlayerId).
    

% %% 查询战天王（即竞技场排名第一的玩家）的信息  
% rpc_query_arena_king_info() ->
% 	% 处理超时的情况
% 	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'query_arena_king_info'}) of
%         {'EXIT', _Reason} ->
%         	?ASSERT(false, _Reason),
%             {fail};
%         null ->
%         	?ASSERT(false),
%             {fail};
%         RetArInfo ->
%         	?ASSERT(is_record(RetArInfo, arena)),
%         	{ok, RetArInfo}
%     end.  
    
    
% %% 膜拜或钦佩战天王
% rpc_visit_arena_king(PS, OpType) ->
% 	?ASSERT(OpType =:= ?WORSHIP_ARENA_KING orelse OpType =:= ?ADMIRE_ARENA_KING),
% 	% 处理超时的情况
% 	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'visit_arena_king', PS#player_status.id, OpType}) of
%         {'EXIT', _Reason} ->
%         	?ASSERT(false, _Reason),
%             {fail};
%         {fail} ->
%         	?ASSERT(false),
%         	{fail};
%         {ok, AwardRepu, AwardAccPoints} ->
%             {ok, AwardRepu, AwardAccPoints}
%     end.
    
	
% %% 查询对手列表	
% rpc_query_my_opponent_list(PS) ->
% 	% 处理超时的情况
% 	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'query_my_opponent_list', PS#player_status.id}) of
%         {'EXIT', _Reason} ->
%         	?ASSERT(false, _Reason),
%             {fail};
%         RetList ->
%             {ok, RetList}
%     end.
	
	
% %% 查询竞技场排名信息
% rpc_query_arena_ranking_list(PageIdx) ->
% 	?ASSERT(PageIdx < ?MAX_ARENA_RANKING_LIST_PAGE),
% 	case PageIdx < ?MAX_ARENA_RANKING_LIST_PAGE of
% 		false ->
% 			skip;
% 		true ->
% 			% 处理超时的情况
% 			case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'query_arena_ranking_list', PageIdx}) of
%     		    {'EXIT', _Reason} ->
%     		    	?ASSERT(false, _Reason),
%     		        {fail};
%     		    {TotalCount, RetList} ->
%     		        {ok, TotalCount, RetList}
%     		end
% 	end.
	
	
% %% 查询竞技场排名信息,排行榜模块调用
% rpc_query_arena_ranking_list_for_rank() ->
%     case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, query_arena_ranking_list_for_rank) of
%         {'EXIT', _Reason} ->
%             {fail};
%         {TotalCount, RetList} ->
%             {ok, TotalCount, RetList}
%     end.

	

% %% 玩家下线时，如果玩家的排名在竞技场的最大缓存数量范围内，则更新世界节点中的玩家缓存和他的武将缓存
% rpc_handle_player_logout(PS) ->
% 	?ASSERT(is_record(PS, player_status), PS),
% 	case PS#player_status.lv >= ?START_ARENA_NEED_LV of
% 		true ->
% 			FightingParList = lib_partner:get_my_fighting_partner_list(PS),
% 			?TRACE("mod_arena: ready to handle player logout, lv:~p, fighting par count: ~p...~n", [PS#player_status.lv, length(FightingParList)]),
% 			EquipCurrent = lib_equip:get_battle_equip_icons(PS) ++ [0],   % 这里的0表示坐骑，todo 以后竞技场的equip_current字段需要修改
%             gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'handle_player_logout', PS, FightingParList, EquipCurrent});
% 		false ->
% 			?TRACE("mod_arena: NOT Need to handle player logout, lv:~p...~n", [PS#player_status.lv]),
% 			skip
% 	end.
	
	

	
	
	
% %% 开始挑战对手
% start_challenge(PS, OpponentId) ->
% 	case lib_player:is_in_battle(PS) of
% 		true ->  % 非法：当前在战斗中
% 			?ASSERT(false),
% 			{fail, ?AR_START_CHAL_FAIL_UNKNOWN};
% 		false ->
% 			case rpc_check_can_start_challenge(PS, OpponentId) of
% 				{fail, Why} ->
% 					{fail, Why};
% 				{ok} ->
% 					OpponentPS = case lib_player:get_online_pid(OpponentId) of
% 						none ->
% 							?TRACE("oppo is not online, so get from global cache...~n"),
% 							rpc_get_player_from_global_cache(OpponentId);
% 						Pid ->
% 							?TRACE("oppo is online, so call get player status...~n"),
% 							case catch gen_server:call(Pid, 'PLAYER') of
%     				    		{'EXIT', _Reason} ->
%     				    			?ERROR_MSG("[ARENA]start_challenge(), id: ~p, get player fail for reason ~p~n", [OpponentId, _Reason]),
%     				    			?ASSERT(false, {OpponentId, _Reason}),
%     				    			null;
%     				    		RetPS ->
%     				    			?ASSERT(is_record(RetPS, player_status), {OpponentId, RetPS}),
%     				    			RetPS
% 							end
% 					end,
% 					% 补充判断对手是否可以被挑战
% 					case check_can_be_challenged(OpponentPS) of
% 						{fail, Reason} ->
% 							%%?ASSERT(false),
% 							{fail, Reason};
% 						{ok} ->
% 							% TODO: 
% 							% 如果OpponentPS不是player_status结构，也可能是其他bug导致数据出错了，
% 							% 这时，可以考虑主动重新从db加载该对手的数据到全局玩家缓存，
% 							% 以避免出bug后，该对手一直处于无效状态！！
							
% 							?ASSERT(is_record(OpponentPS, player_status), {OpponentId, OpponentPS}),
% 							?TRACE("my eq skills:~p~n", [PS#player_status.eq_skill]),
% 							?TRACE("oppo eq skills: ~p~n", [OpponentPS#player_status.eq_skill]),
							
% 							% 锁定挑战方和被挑战方
% 							rpc_lock_player_for_arena_battle(PS#player_status.id),
% 							rpc_lock_player_for_arena_battle(OpponentId),
							
% 							% 更新挑战方下次可以挑战的时间点
% 							?TRACE("update next can chal time...~n"),
% 							TimeNow = util:unixtime(),
% 							NextCanChalTime = TimeNow + ?ARENA_CHALLENGE_CD_TIME,
% 							rpc_set_next_can_chal_time(PS#player_status.id, NextCanChalTime),
							
% 							% 战斗前添加挑战方的所有出战武将到全局缓存
% 							MyFightingParList = lib_partner:get_my_fighting_partner_list(PS),
% 							?TRACE("start challenge(), my fighting par count: ~p~n", [length(MyFightingParList)]),
% 							[rpc_add_partner_to_global_cache(X) || X <- MyFightingParList],
							
% 							% 触发战斗
% 							mod_battle:pk_offline(PS#player_status.bid, [PS, OpponentPS], ?BAT_SUB_T_ARENA_PK_OFFLINE),
% 							{ok, lib_player:enter_battle(PS, PS#player_status.bid)}
% 					end
% 			end
% 	end.
	

		
	
	
% %% 锁定玩家	
% rpc_lock_player_for_arena_battle(PlayerId) ->
% 	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'lock_player_for_arena_battle', PlayerId}).
	
	
% %% 竞技场战斗结束后的相关处理
% rpc_handle_arena_battle_ends(ChallengerPS, PassiveId, WinOrLose) ->
% 	ChallengerId = ChallengerPS#player_status.id,
% 	?TRACE("rpc_handle_arena_battle_ends(), ~p vs ~p, ~p~n", [ChallengerId, PassiveId, WinOrLose]),
% 	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'handle_arena_battle_ends', [ChallengerPS, PassiveId, WinOrLose]}).
        
        

% %% 获取下次可以挑战的时间点
% rpc_get_next_can_chal_time(PlayerId) ->
% 	% 处理超时的情况
% 	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'get_next_can_chal_time', PlayerId}) of
%         {'EXIT', _Reason} ->
%         	?ASSERT(false, _Reason),
%             {fail};
%         {fail} ->
%         	?ASSERT(false),
%         	{fail};
%         {ok, NexCanChalTime} ->
%         	{ok, NexCanChalTime}
%     end.
    
    

% %% 获取可重新抽取对手的次数
% rpc_get_can_refresh_oppo_list_times(PlayerId) ->
% 	% 处理超时的情况
% 	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'get_can_refresh_oppo_list_times', PlayerId}) of
%         {'EXIT', _Reason} ->
%         	?ASSERT(false, _Reason),
%             {fail};
%         {fail} ->
%         	?ASSERT(false),
%         	{fail};
%         {ok, CanRefreshOppoTimes} ->
%         	{ok, CanRefreshOppoTimes}
%     end.
	
    
% %% 重置下次可以挑战的时间点
% rpc_set_next_can_chal_time(PlayerId, NewTime) ->
% 	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'set_next_can_chal_time', PlayerId, NewTime}).
	

% %% 增加竞技场积分（异步操作，用cast），如果参数AddNum为负数，则表示是扣积分	
% rpc_asyn_add_acc_points(PlayerId, AddNum) ->
% 	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'asyn_add_acc_points', PlayerId, AddNum}).
	
	

% %% 增加竞技场积分（同步操作，用call），如果参数AddNum为负数，则表示是扣积分
% %% @return: ok | fail
% rpc_sync_add_acc_points(PlayerId, AddNum) ->
% 	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'sync_add_acc_points', PlayerId, AddNum}) of
% 		{'EXIT', _Reason} ->
% 			?ERROR_MSG("[ARENA]rpc_sync_add_acc_points() fail for reason: ~w", [_Reason]),
%         	?ASSERT(false, _Reason),
%             fail;
%         fail ->
%         	fail;
%         ok ->
%         	ok
% 	end.
	

% %% 设置当天剩余可挑战次数（目前暂时只有gm指令会调用该接口）
% %%rpc_set_can_chal_times(PlayerId, NewTimes) ->
% %%	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'set_can_chal_times', PlayerId, NewTimes}).



% %% 清零当天已挑战次数（目前仅用于gm指令）
% rpc_clear_already_chal_times(PlayerId) ->
% 	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'clear_already_chal_times', PlayerId}).

	
% %% 设置可刷新对手列表的次数
% rpc_set_can_refresh_oppo_list_times(PlayerId, NewTimes) ->
% 	gen_server:cast({global, ?GLOBAL_ARENA_PROCESS}, {'set_can_refresh_oppo_list_times', PlayerId, NewTimes}).



% %% 查询竞技场商店物品列表	
% query_arena_shop_goods(ShopType, PageIdx) ->
% 	IdList = data_arena_shop:get_goods_type_id_list(ShopType),
% 	% 获取所有物品
% 	GoodsList = [data_arena_shop:get(ShopType, X) || X <- IdList],
% 	TotalCount = length(GoodsList),
% 	Start = PageIdx * ?AR_SHOP_GOODS_COUNT_PER_PAGE + 1,
% 	End = Start + ?AR_SHOP_GOODS_COUNT_PER_PAGE - 1,
% 	case Start =< TotalCount of
% 		false ->
% 			?ASSERT(false, [Start, TotalCount]),
% 			{TotalCount, []};
% 		true ->
% 			NewEnd = case End =< TotalCount of
% 					 	true -> End;
% 					 	false -> TotalCount
% 				  	 end,
% 			OnePageGoodsList = lists:sublist(GoodsList, Start, NewEnd - Start + 1),
% 			{TotalCount, OnePageGoodsList}
% 	end.
	
% %% 购买竞技场商店的物品	
% buy_goods(PS, [ShopType, GoodsTypeId, BuyCount]) ->
% 	case rpc_query_my_arena_info(PS) of
% 		{fail} ->
% 			{fail, ?AR_BUY_FAIL_SERVER_BUSY};
% 		{ok, MyArInfo} ->
% 			% TODO： 处理call超时的情况
% 			GoodsStatus = gen_server:call(?GET_GOODS_PID(PS), {'STATUS'}),
% 			% 单次购买数量是否太多了？
% 			case BuyCount > ?AR_MAX_BUY_COUNT_EACH_TIME of
% 				true ->
% 					{fail, ?AR_BUY_FAIL_BUY_COUNT_OVERFLOW};
% 				false ->
% 					% 玩家的背包空间是否足够？
% 					case goods_util:can_put_into_bag(PS, [{GoodsTypeId, BuyCount}]) of %%   length(goods_util:get_bag_null_cells(PS)) < BuyCount of
% 						false ->
% 							{fail, ?AR_BUY_FAIL_BAG_FULL};
% 						true ->
% 							% 商店是否有目标物品？
% 							case data_arena_shop:get(ShopType, GoodsTypeId) of
% 								null ->
% 									?ASSERT(false, [ShopType, GoodsTypeId]),
% 									{fail, ?AR_BUY_FAIL_UNKNOWN};
% 								TargetGoods ->
% 									?ASSERT(is_record(TargetGoods, ar_shop_goods)),
% 									% 目前断言：不会同时需要花费勇勋值和战功值，但必定需要花费两者中的一种
% 									?ASSERT(not (TargetGoods#ar_shop_goods.cost_acc_points > 0 andalso TargetGoods#ar_shop_goods.cost_battle_contrib > 0)),
% 									?ASSERT(not (TargetGoods#ar_shop_goods.cost_acc_points == 0 andalso TargetGoods#ar_shop_goods.cost_battle_contrib == 0)),
									
									
% 									% 钱是否足够？
% 									NeedMoney = TargetGoods#ar_shop_goods.price * BuyCount, % 勿忘：乘上购买数量，下同!!!
% 									PriceType = TargetGoods#ar_shop_goods.price_type,
% 									% 注意：不一定需花费钱
% 									case NeedMoney > 0 andalso (not lib_money:has_enough_money(PS, NeedMoney, PriceType)) of
% 										true ->
% 											{fail, ?AR_BUY_FAIL_MONEY_LIMIT};
% 										false ->
% 											NeedAccPoints = TargetGoods#ar_shop_goods.cost_acc_points * BuyCount,
% 											% 积分是否足够？
% 											case MyArInfo#arena.acc_points < NeedAccPoints of
% 												true ->
% 													{fail, ?AR_BUY_FAIL_ACC_POINTS_LIMIT};
% 												false ->
% 													NeedBattleContrib = TargetGoods#ar_shop_goods.cost_battle_contrib * BuyCount,
% 													% 判断战功值是否够？
% 													case PS#player_status.battle_contrib >= NeedBattleContrib of
% 														false ->
% 															{fail, ?AR_BUY_FAIL_BAT_CONTRIB_LIMIT};
% 														true ->
% 															% 判断功勋值是否够？
% 															NeedGongxun = TargetGoods#ar_shop_goods.need_gongxun * BuyCount,
% 															case PS#player_status.gongxun >= NeedGongxun of
% 																false ->
% 																	{fail, ?AR_BUY_FAIL_GONGXUN_LIMIT};
% 																true ->
% 																	buy_goods_ok(PS, MyArInfo, GoodsStatus, TargetGoods, BuyCount)
% 															end
% 													end
% 											end
% 									end
% 							end
% 					end
% 			end
% 	end.
	


	
	
	
	
% %% 从全局缓存获取玩家数据
% %% @return: null | player_status结构体
% rpc_get_player_from_global_cache(PlayerId) ->
% 	?TRACE("rpc_get_player_from_global_cache(), id: ~p~n", [PlayerId]),
% 	% 处理超时的情况
% 	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'get_player_from_global_cache', PlayerId}) of
%         {'EXIT', _Reason} ->
%         	?ERROR_MSG("rpc_get_player_from_global_cache(), PlayerId: ~p, exit for reason: ~p", [PlayerId, _Reason]),
%         	?ASSERT(false, _Reason),
%             null;
%         null ->
%         	null;
%         RetPlayerStatus ->
%             RetPlayerStatus
%     end.
    

% %% 从全局缓存获取武将数据
% %% @return: null | ets_partner结构体  
% rpc_get_partner_from_global_cache(PartnerId) ->
% 	?TRACE("rpc_get_partner_from_global_cache(), id: ~p~n", [PartnerId]),
% 	% 处理超时的情况
% 	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'get_partner_from_global_cache', PartnerId}) of
%         {'EXIT', _Reason} ->
%         	?ERROR_MSG("[ARENA]rpc_get_partner_from_global_cache(), PartnerId: ~p, exit for reason: ~p", [PartnerId, _Reason]),
%         	?ASSERT(false, _Reason),
%             null;
%         RetPartner ->
%         	?ASSERT(is_record(RetPartner, ets_partner), RetPartner),
%             RetPartner
%     end.
    
% %%    
% rpc_get_player_arena_rank(PlayerId) ->
% 	?TRACE("rpc_get_player_arena_rank(), id: ~p~n", [PlayerId]),
% 	% 处理超时的情况
% 	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'get_player_arena_rank', PlayerId}) of
%         {'EXIT', _Reason} ->
%         	?ERROR_MSG("rpc_get_player_arena_rank(), PlayerId: ~p, exit for reason: ~p", [PlayerId, _Reason]),
%         	?ASSERT(false, _Reason),
%             {fail};
%         Ret ->
%            	Ret
%     end.
	
	
	
	

% init([]) ->
%     process_flag(trap_exit, true),
% 	misc:register(global, ?GLOBAL_ARENA_PROCESS, self()),
% 	ets:new(?ETS_GLOBAL_ARENA_INFO, [{keypos,#arena.id}, named_table, public, set]), % 全局竞技场的信息
% 	ets:new(?ETS_GLOBAL_PLAYER_CACHE, [{keypos,#player_status.id}, named_table, public, set]), % 全局玩家缓存（用于竞技场离线pk）
% 	ets:new(?ETS_GLOBAL_PARTNER_CACHE, [{keypos,#ets_partner.id}, named_table, public, set]), % 全局武将缓存（用于竞技场离线pk）
% 	% 准备做初始化的工作
% 	erlang:send_after(100, self(), {'do_init_jobs'}),
%     {ok, none}.
    




				




				
				   
% %% 从db加载前XX名玩家的战斗数据到全局缓存
% %% consider rename to: init_global_player_cache()???
% load_players_to_global_cache() ->
% 	F = fun(PlayerId) ->
% 			case lib_player:load_battle_data_from_db(PlayerId) of
% 				{fail} ->
% 					?ERROR_MSG("[ARENA]load_players_to_global_cache() ERR!! player id: ~p", [PlayerId]),
% 					?ASSERT(false, PlayerId),
% 					skip;
% 				{ok, PlayerStatus} ->
% 					% 添加到全局缓存				
% 					add_player_to_global_cache(PlayerStatus)
% 			end
% 		end,
% 	GlobalArInfoList = ets:tab2list(?ETS_GLOBAL_ARENA_INFO),
% 	%%?TRACE("GlobalArInfoList size: ~p, ~p~n", [length(GlobalArInfoList), ets:info(?ETS_GLOBAL_ARENA_INFO, size)]),
	
% 	PlayerIdList = [ArInfo#arena.id || ArInfo <- GlobalArInfoList],
% 	lists:foreach(F, PlayerIdList),
% 	% TODO: 下面代码为调试验证代码， 以后可以删掉 ---- huangjf
% 	_Size1 = ets:info(?ETS_GLOBAL_ARENA_INFO, size),
% 	_Size2 = ets:info(?ETS_GLOBAL_PLAYER_CACHE, size),
% 	?TRACE("size: ~p, ~p~n", [_Size1, _Size2]),
% 	?ASSERT(_Size1 =:= _Size2).
	


	
% %% 遍历ETS_GLOBAL_PLAYER_CACHE, 依据player_status里的battler_list字段，加载出战的武将的战斗数据	
% load_partners_to_global_cache() ->
% 	F1 = fun(PartnerId) ->
% 			case lib_partner:load_battle_data_from_db(PartnerId) of
% 				{fail} ->
% 					?ERROR_MSG("[ARENA]load_partners_to_global_cache() ERR!! partner id: ~p", [PartnerId]),
% 					?ASSERT(false, PartnerId),
% 					skip;
% 				{ok, Partner} ->
% 			 		% 添加到全局缓存				
% 			 		add_partner_to_global_cache(Partner)
% 			end
% 		 end,
		 
% 	F2 = fun(PS) ->
% 			 FightingObjs = PS#player_status.battler_list,
% 			 %%?TRACE("FightingObjs: ~p~n", [FightingObjs]),
% 			 % 断言出战对象列表中必包含玩家
% 			 ?ASSERT(lists:keyfind(?BO_PLAYER, 1, FightingObjs) /= false, {PS#player_status.id, FightingObjs}),
% 			 % 去掉玩家，只剩下武将
% 			 FightingPartners = lists:keydelete(?BO_PLAYER, 1, FightingObjs),
% 			 case FightingPartners =:= [] of
% 			 	 true ->
% 			 	 	%%?TRACE("player ~p has not fighting partners...~n", [PS#player_status.id]), 
% 			 	 	skip;
% 			 	 false ->
% 			 	 	PartnerIdList = [Id || {_Type, Id, _PosInTroop} <- FightingPartners],
% 			 	 	lists:foreach(F1, PartnerIdList)
% 			 end
% 		 end,
% 	PlayerStatusList = ets:tab2list(?ETS_GLOBAL_PLAYER_CACHE),
% 	lists:foreach(F2, PlayerStatusList).
	
	
    
    
    
% %% 统一模块+过程调用(call)
% handle_call({apply_call, Module, Method, Args}, _From, State) -> 
% 	Reply = 
% 		case (catch apply(Module, Method, Args)) of
% 			{'EXIT', Info} ->
% 				?WARNING_MSG("mod_arena_apply_call error: Module=~p, Method=~p, Reason=~p", [Module, Method, Info]),
%   				error;
%   			DataRet -> 
% 				DataRet
% 		end,
%     {reply, Reply, State};
    
    
% %% 判断是否可以发起挑战 
% handle_call({'check_can_start_challenge', ChallengerPS, PassiveId}, _From, State) ->
% 	ChallengerId = ChallengerPS#player_status.id,
% 	ChallengerAr = get_arena_info_from_global_cache(ChallengerId),
% 	case ChallengerAr =:= null of
% 		true ->  % 出错：挑战方的竞技场数据不存在
% 			?ASSERT(false, [ChallengerId, PassiveId]),
% 			{reply, {fail, ?AR_START_CHAL_FAIL_UNKNOWN}, State};
% 		false ->
% 			case ChallengerId =:= PassiveId of
% 				true ->  % 非法：自己挑战自己
% 					?ASSERT(false),
% 					{reply, {fail, ?AR_START_CHAL_FAIL_UNKNOWN}, State};
% 				false ->
% 					% 判断剩余可挑战次数
% 					VipLv = ChallengerPS#player_status.vip,
% 					TotalCanChalTimes = ?TIMES_CAN_CHAL_ONE_DAY + lib_arena:get_more_chal_times_by_vip_lv(VipLv),
% 					LeftCanChalTimes = TotalCanChalTimes - ChallengerAr#arena.already_chal_times,  % 注：结果有可能为负数
% 					case LeftCanChalTimes =< 0 of
% 						true ->
% 							{reply, {fail, ?AR_START_CHAL_FAIL_TIMES_LIMIT}, State};
% 						false ->
% 							% 判断被挑战方是否在挑战方的当前对手列表中（防止客户端欺骗）
% 							case lists:member(PassiveId, ChallengerAr#arena.cur_opponent_list) of
% 								false ->
% 									?ASSERT(false),
% 									{reply, {fail, ?AR_START_CHAL_FAIL_UNKNOWN}, State};
% 								true ->
% 									% 被挑战方是否存在
% 									case get_arena_info_from_global_cache(PassiveId) of
% 										null ->
% 											?TRACE("not in global arena info cache...~n"),
% 											{reply, {fail, ?AR_START_CHAL_FAIL_OPPO_NOT_EXIST}, State};
% 										PassiveAr ->
% 											case get_player_from_global_cache(PassiveId) of
% 												null ->
% 													?TRACE("passive not in global PLAYER  cache...~n"),
% 													{reply, {fail, ?AR_START_CHAL_FAIL_UNKNOWN}, State};
% 												_PassivePS ->
% 													% 检查cd时间
% 													TimeNow = util:unixtime(),
% 													%%[ArInfo] = ets:lookup(?ETS_GLOBAL_ARENA_INFO, PlayerId),
% 													case TimeNow >= ChallengerAr#arena.next_can_chal_time of
% 														false ->
% 															{reply, {fail, ?AR_START_CHAL_FAIL_CDING}, State};
% 														true ->
% 															% 判断被挑战方是否处于锁定状态
% 															case is_locked_for_arena_battle(PassiveAr) of
% 																true ->
% 																	{reply, {fail, ?AR_START_CHAL_FAIL_OPPO_IS_LOCKED}, State};
% 																false ->
% 																	{reply, {ok}, State}
% 															end
% 													end
% 											end
% 									end
% 							end
% 					end
% 			end
% 	end;
			
    
    
% %% 获取玩家的竞技场信息 
% handle_call({'query_my_arena_info', PlayerId}, _From, State) ->
% 	% 若ets没有玩家对应的arena数据缓存，则从db加载到ets
% 	case get_arena_info_from_global_cache(PlayerId) of
% 		null ->
% 			%%% 没有则先从db加载
% 			%%load_my_arena_info_to_global_cache(PlayerId),
% 			%%% 然后再尝试获取一次
% 			%%case get_arena_info_from_global_cache(PlayerId) of
% 			%%	null ->
% 			%%		?TRACE("try load from db fail...~n"),
% 			%%		{reply, null, State};
% 			%%	R ->
% 			%%		?ASSERT(is_record(R, arena)),
% 			%%		{reply, R, State}
% 			%%end;
			
% 			{reply, null, State};
% 		ArInfo ->
% 			?ASSERT(is_record(ArInfo, arena)),
% 			% 隔天则自动重置可挑战次数、可刷新对手列表次数、可膜拜和钦佩战天王标记，并更新当前日期
% 			Today = lib_common:date_to_int(erlang:date()),
% 			RetArInfo = case ArInfo#arena.date =/= Today of
% 				false ->
% 					ArInfo;
% 				true ->
% 					?TRACE("reset arena times for new date!!!!!!!!!!!!!!!!!!!~n"),
% 					NewArInfo = ArInfo#arena{
% 									already_chal_times = 0, 
% 									can_refresh_oppo_times = ?TIMES_CAN_REFRESH_OPPO_LIST_ONE_DAY,
% 									can_worship_arena_king = 1,
% 									can_admire_arena_king = 1,
% 									date = Today
% 									},
% 					update_arena_info_to_global_cache(NewArInfo),
% 					NewArInfo
% 			end,
% 			{reply, RetArInfo, State}
% 	end;
	
	
% %% 获取战天王信息
% handle_call({'query_arena_king_info'}, _From, State) ->
% 	Pattern = #arena{ rank= 1,  _ = '_'},
% 	case ets:match_object(?ETS_GLOBAL_ARENA_INFO, Pattern) of
% 		[] ->
% 			{reply, null, State};
% 		[ArInfo] ->
% 			{reply, ArInfo, State};
% 		_Any ->
% 			?TRACE("error: other match...~p~n", [_Any]),
% 			?ASSERT(false),
% 			{reply, null, State}
% 	end;
	
	
% %% 膜拜或钦佩战天王
% %% TODO：暂时是固定奖励5声望和5积分
% handle_call({'visit_arena_king', PlayerId, OpType}, _From, State) ->
% 	AwardRepu = 5,
% 	AwardAccPoints = 5,
% 	case get_arena_info_from_global_cache(PlayerId) of
% 		null ->
% 			?TRACE("can NOT found arena info from global cache, id:~p~n", [PlayerId]),
% 			{reply, {fail}, State};
% 		ArInfo ->
% 			case OpType of
% 				% 膜拜
% 				?WORSHIP_ARENA_KING ->
% 					if	ArInfo#arena.can_worship_arena_king =:= 0 ->
% 							{reply, {fail}, State};
% 						true ->
% 							% 更新可膜拜标记和积分
% 							NewArInfo = ArInfo#arena{
% 											can_worship_arena_king = 0,
% 											acc_points =  ArInfo#arena.acc_points + AwardAccPoints
% 											},
% 							update_arena_info_to_global_cache(NewArInfo),
% 							{reply, {ok, AwardRepu, AwardAccPoints}, State}
% 					end;
% 				% 钦佩
% 				?ADMIRE_ARENA_KING ->
% 					if	ArInfo#arena.can_admire_arena_king =:= 0 ->
% 							{reply, {fail}, State};
% 						true ->
% 							% 更新可钦佩标记和积分
% 							NewArInfo = ArInfo#arena{
% 											can_admire_arena_king = 0,
% 											acc_points =  ArInfo#arena.acc_points + AwardAccPoints
% 											},
% 							update_arena_info_to_global_cache(NewArInfo),
% 							{reply, {ok, AwardRepu, AwardAccPoints}, State}
% 					end
% 			end
% 	end;
% % 刷新我的对手列表
% handle_call({'refresh_my_opponent_list', PlayerId}, _From, State) ->
% 	case check_can_refresh_my_opponent_list(PlayerId) of
% 		{fail, Why} ->
% 			{reply, {fail, Why}, State};
% 		{ok} ->
% 			NewOpponentList = refresh_my_opponent_list(PlayerId, ?NEED_COST_TIMES_YES),
% 			{reply, {ok, NewOpponentList}, State}
% 	end;
	
	
% %% 查看排行榜
% handle_call({'query_arena_ranking_list', PageIdx}, _From, State) ->
% 	?TRACE("handle call : query_arena_ranking_list()...~n"),
% 	Min = PageIdx * ?MAX_PLAYER_SHOWED_PER_PAGE + 1,
% 	Max = (PageIdx + 1) * ?MAX_PLAYER_SHOWED_PER_PAGE,
% 	Ms = ets:fun2ms(fun(T) when (T#arena.rank >= Min
% 								andalso T#arena.rank =< Max) -> T 
% 					end),
					
% 	RetList = ets:select(?ETS_GLOBAL_ARENA_INFO, Ms),
% 	Size = ets:info(?ETS_GLOBAL_ARENA_INFO, size),
% 	TotalCount = case Size > ?MAX_ARENA_RANKING_LIST_PAGE * ?MAX_PLAYER_SHOWED_PER_PAGE of
% 					true ->  ?MAX_ARENA_RANKING_LIST_PAGE * ?MAX_PLAYER_SHOWED_PER_PAGE;
% 					false -> Size
% 				 end,
% 	?TRACE("query ranking,  total count: ~p, ret ar ranking list len:~p~n", [TotalCount, length(RetList)]),
	
% 	% 依据排名进行排序
% 	F = fun(A, B) -> 
% 			A#arena.rank =< B#arena.rank 
% 		end,
% 	RetList2 = lists:sort(F, RetList),
% 	{reply , {TotalCount, RetList2}, State};


% %% 查看排行榜...
% handle_call(query_arena_ranking_list_for_rank, _From, State) ->
% 	Min = 1,
% 	Max = ?MAX_ARENA_RANKING_LIST_PAGE * ?MAX_PLAYER_SHOWED_PER_PAGE,
% 	Ms = ets:fun2ms(fun(T) when (T#arena.rank >= Min
% 								andalso T#arena.rank =< Max) -> T 
% 					end),
					
% 	RetList = ets:select(?ETS_GLOBAL_ARENA_INFO, Ms),
% 	Size = ets:info(?ETS_GLOBAL_ARENA_INFO, size),
% 	TotalCount = case Size > ?MAX_ARENA_RANKING_LIST_PAGE * ?MAX_PLAYER_SHOWED_PER_PAGE of
% 					true ->  ?MAX_ARENA_RANKING_LIST_PAGE * ?MAX_PLAYER_SHOWED_PER_PAGE;
% 					false -> Size
% 				 end,
	
% 	% 依据排名进行排序
% 	F = fun(A, B) -> 
% 			A#arena.rank =< B#arena.rank 
% 		end,
% 	RetList2 = lists:sort(F, RetList),
% 	{reply , {TotalCount, RetList2}, State};

	
% %% 查询我的对手列表
% handle_call({'query_my_opponent_list', PlayerId}, _From, State) ->
% 	?TRACE("ETS_GLOBAL_ARENA_INFO size: ~p~n", [ets:info(?ETS_GLOBAL_ARENA_INFO, size)]),
% 	Ret = case get_arena_info_from_global_cache(PlayerId) of
% 			null ->
% 				?ASSERT(false, PlayerId),
% 				[];
% 			_ArInfo ->
% 				get_my_opponent_list(PlayerId)
% 		end,
% 	{reply, Ret, State};
	
	
% %% 获取下次可以挑战的时间点
% handle_call({'get_next_can_chal_time', PlayerId}, _From, State) ->
% 	Ret = case get_arena_info_from_global_cache(PlayerId) of
% 		null ->
% 			{fail};
% 		ArInfo ->
% 			{ok, ArInfo#arena.next_can_chal_time}
% 	end,
% 	{reply, Ret, State};
	
	

% %% 获取可重新抽取对手的次数
% handle_call({'get_can_refresh_oppo_list_times', PlayerId}, _From, State) ->
% 	Ret = case get_arena_info_from_global_cache(PlayerId) of
% 		null ->
% 			{fail};
% 		ArInfo ->
% 			{ok, ArInfo#arena.can_refresh_oppo_times}
% 	end,
% 	{reply, Ret, State};


	
	
% %% 从全局缓存获取玩家数据
% handle_call({'get_player_from_global_cache', PlayerId}, _From, State) ->
% 	case get_player_from_global_cache(PlayerId) of
% 		null ->
% 			{reply, null, State};
% 		PS ->
% 			?ASSERT(is_record(PS, player_status), PS),
% 			{reply, PS, State}
% 	end;
	
	
% %% 从全局缓存获取武将数据
% handle_call({'get_partner_from_global_cache', PartnerId}, _From, State) ->
% 	case get_partner_from_global_cache(PartnerId) of %%ets:lookup(?ETS_GLOBAL_PARTNER_CACHE, PartnerId) of
% 		null ->
% 			{reply, null, State};
% 		Partner ->
% 			?ASSERT(is_record(Partner, ets_partner)),
% 			{reply, Partner, State}
% 	end;
	

	
% %% 从全局缓存获取武将数据
% handle_call({'get_player_arena_rank', PlayerId}, _From, State) ->
% 	case ets:lookup(?ETS_GLOBAL_ARENA_INFO, PlayerId) of
% 		[] ->
% 			{reply, {fail}, State};
% 		[ArInfo] ->
% 			{reply, {ok, ArInfo#arena.rank}, State}
% 	end;
	
	


% %% 更新玩家到全局缓存
% handle_call({'update_player_to_global_cache', PS}, _From, State) ->
% 	?TRACE("handle call : update_player_to_global_cache, id:~p...~n", [PS#player_status.id]),
% 	update_player_to_global_cache(PS),
% 	{reply, ok, State};
	
	

% %% 增加竞技场积分，如果参数AddNum为负数，则表示是扣积分
% %% @return: fail | ok
% handle_call({'sync_add_acc_points', PlayerId, AddNum}, _From, State) ->
% 	?TRACE("handle_call, sync_add_acc_points, PlayerId: ~p, AddNum: ~p...~n", [PlayerId, AddNum]),
% 	ArInfo = %%case get_arena_info_from_global_cache(PlayerId) of
% 				%%null ->
% 				%%	% 没有则先从db加载
% 				%%	load_my_arena_info_to_global_cache(PlayerId),
% 				%%	% 然后再尝试获取一次
% 				%%	get_arena_info_from_global_cache(PlayerId);
% 				%%RetArInfo ->
% 				%%	RetArInfo
% 			 %%end,
% 			 get_arena_info_from_global_cache(PlayerId),
% 	case ArInfo of
% 		null ->
% 			?TRACE("sync_add_acc_points, no ArInfo...~n"),
% 			{reply, fail, State};
% 		_ ->
% 			NewAccPoints = max(ArInfo#arena.acc_points + AddNum, 0), % 做一下范围矫正（以防万一）
% 			?TRACE("NewAccPoints: ~p~n", [NewAccPoints]),
% 			NewArInfo = ArInfo#arena{acc_points = NewAccPoints},
% 			update_arena_info_to_global_cache(NewArInfo),
			
% 			lib_arena:notify_my_arena_info_changed(world_node, NewArInfo),
			
% 			if 
% 				AddNum > 0 ->  % 加积分
% 					lib_player:display_gain_item(PlayerId, ?DISPLAY_AR_ACC_POINTS, AddNum);
% 				AddNum < 0 ->  % 扣加分
% 					AbsoluteNum = util:absolute(AddNum),
% 					log:log_currency_consume(PlayerId, acc_points, AbsoluteNum);
% 				true ->
% 					skip	
% 			end,
			
% 			{reply, ok, State}
% 	end;
	
	
% handle_call(_Request, _From, State) ->
% 	?ASSERT(false, _Request),
%     {reply, null, State}.
    
    
    
    
% check_can_refresh_my_opponent_list(PlayerId) ->
% 	case get_arena_info_from_global_cache(PlayerId) of
% 		null ->
% 			{fail, ?AR_REFRESH_OPPO_LIST_FAIL_UNKNOWN};
% 		MyArInfo ->
% 			% 判断次数
% 			case MyArInfo#arena.can_refresh_oppo_times =:= 0 of
% 				true ->
% 					{fail, ?AR_REFRESH_OPPO_LIST_FAIL_TIMES_LIMIT};
% 				false ->
% 					{ok}
% 			end
% 	end.


% %% 刷新对手列表
% %% @para: IfNeedCostTimes表示是否需要扣除玩家的可刷新对手列表的次数，NEED_COST_TIMES_YES => 是， NEED_COST_TIMES_NO => 否
% %% @return: 新的对手列表（arena结构体列表）
% refresh_my_opponent_list(PlayerId, IfNeedCostTimes) ->
% 	TotalList = ets:tab2list(?ETS_GLOBAL_ARENA_INFO),
% 	CurCacheSize = ets:info(?ETS_GLOBAL_ARENA_INFO, size),
% 	?ASSERT(CurCacheSize =:= length(TotalList)),
% 	?TRACE("refresh_my_opponent_list(), CurCacheSize: ~p~n", [CurCacheSize]),
% 	MyArInfo = get_arena_info_from_global_cache(PlayerId),
% 	?ASSERT(MyArInfo /= null),
% 	% 筛选出新的对手列表
% 	NewOppoList = case CurCacheSize =< ?MAX_OPPONENT_LIST_SIZE of
% 		true ->
% 			% 过滤掉自己
% 			F = fun(X) -> X#arena.id =/= PlayerId end,
% 			lists:filter(F, TotalList);
% 		false ->
% 			% TODO: 这段代码目前有点乱，有待整理!
% 			MyRank = MyArInfo#arena.rank,
% 			RangeMax = 	case CurCacheSize =< ?MAX_RANK_NEED_CACHE of
% 							true -> CurCacheSize;
% 							false -> ?MAX_RANK_NEED_CACHE
% 						end,
% 			Max = 	case (MyRank + 5) =< RangeMax of
% 						true ->	MyRank + 5;
% 						false -> RangeMax
% 					end, 
% 			TmpMin = if MyRank < 150 ->
% 							case (MyRank - 30) =< 0 of
% 								true -> 1;
% 								false -> MyRank - 30
% 							end;
% 						MyRank < 300 ->
% 							MyRank - 50;
% 						true ->
% 							MyRank - 100
% 					 end,
% 			Min = 	case TmpMin =< RangeMax - ?MAX_OPPONENT_LIST_SIZE of
% 						true -> TmpMin;
% 						false -> RangeMax - ?MAX_OPPONENT_LIST_SIZE - 10 % 从最后15名中选取
% 					end,
% 			?ASSERT(Min >= 1, {RangeMax, Max, TmpMin, Min}),
% 			?TRACE("select oppo range!!! min: ~p, max: ~p~n", [Min, Max]),		
% 			% 依据min, max过滤
% 			Ms = ets:fun2ms(fun(T) when (T#arena.rank >= Min
% 										andalso T#arena.rank =< Max
% 										andalso T#arena.rank /= MyRank) -> T
% 							end),
% 			MatchRes = ets:select(?ETS_GLOBAL_ARENA_INFO, Ms),
% 			?TRACE("match oppo list len: ~p~n", [length(MatchRes)]),
% 			?ASSERT(length(MatchRes) >= ?MAX_OPPONENT_LIST_SIZE),
			
% 			% TODO: 暂时用暴力算法随机挑选5名对手，以后考虑做优化
% 			N = length(MatchRes),
% 			OppoAr1 = lists:nth(random:uniform(N), MatchRes),
% 			?ASSERT(is_record(OppoAr1, arena)),
% 			OppoAr2 = lists:nth(random:uniform(N-1), MatchRes -- [OppoAr1]),
% 			OppoAr3 = lists:nth(random:uniform(N-2), MatchRes -- [OppoAr1, OppoAr2]),
% 			OppoAr4 = lists:nth(random:uniform(N-3), MatchRes -- [OppoAr1, OppoAr2, OppoAr3]),
% 			OppoAr5 = lists:nth(random:uniform(N-4), MatchRes -- [OppoAr1, OppoAr2, OppoAr3, OppoAr4]),
% 			[OppoAr1, OppoAr2, OppoAr3, OppoAr4, OppoAr5]
% 	end,
	
% 	% 依据排名进行排序
% 	F2 = fun(A, B) -> 
% 			A#arena.rank =< B#arena.rank 
% 		end,
% 	RetNewOppoList = lists:sort(F2, NewOppoList),
% 	% 更新玩家的当前对手id列表和可刷新对手列表的次数
% 	MyNewArInfo = 
% 		case IfNeedCostTimes of
% 			?NEED_COST_TIMES_YES ->
% 				MyArInfo#arena{
% 					cur_opponent_list = [X#arena.id || X <- RetNewOppoList],
% 					can_refresh_oppo_times = MyArInfo#arena.can_refresh_oppo_times - 1
% 					};
% 			?NEED_COST_TIMES_NO ->
% 				MyArInfo#arena{cur_opponent_list = [X#arena.id || X <- RetNewOppoList]}
% 		end,
	
% 	?TRACE("new cur oppo id list: ~p, can_refresh_oppo_times: ~p~n", [MyNewArInfo#arena.cur_opponent_list, MyNewArInfo#arena.can_refresh_oppo_times]),
% 	update_arena_info_to_global_cache(MyNewArInfo),
% 	% 返回新的对手列表
% 	RetNewOppoList.
	
	
	
% %% 获取对手列表
% get_my_opponent_list(PlayerId) ->
% 	MyArInfo = get_arena_info_from_global_cache(PlayerId),
% 	?ASSERT(MyArInfo /= null),
% 	?TRACE("cur opponent id list: ~p~n", [MyArInfo#arena.cur_opponent_list]),
% 	case MyArInfo#arena.cur_opponent_list == [] of
% 		true ->  % 为空则自动帮玩家刷新（不扣玩家的可刷新对手列表的次数）
% 			?TRACE("auto refresh oppo list, because my cur oppo list is []!!~n"),
% 			refresh_my_opponent_list(PlayerId, ?NEED_COST_TIMES_NO);
% 		false ->
% 			OpponentList = [get_arena_info_from_global_cache(X) || X <- MyArInfo#arena.cur_opponent_list],
% 			% 过滤掉null
% 			%%F = fun(X) -> X /= null end,
% 			%%OpponentList2 = lists:filter(F, OpponentList),
% 			OpponentList2 = [X || X <- OpponentList, X /= null],
			
% 			case OpponentList2 == [] of
% 				true -> % 为空则自动帮玩家刷新
% 					?TRACE("auto refresh oppo list 22222~n"),
% 					refresh_my_opponent_list(PlayerId, ?NEED_COST_TIMES_NO);
% 				false ->
% 					% 依据排名进行排序
% 					F2 = fun(A, B) ->  A#arena.rank =< B#arena.rank end,
% 					lists:sort(F2, OpponentList2)
% 			end
% 	end.
		
			
			
			
	
					
    
 
% %% 统一模块+过程调用(cast)
% handle_cast({apply_cast, Module, Method, Args}, State) -> 
% 	case (catch apply(Module, Method, Args)) of
%  		{'EXIT', Info} ->
%  			?ASSERT(false),
%  			?WARNING_MSG("mod_arena_apply_cast error: Module=~p, Method=~p, Reason=~p", [Module, Method, Info]),
%  			error;
%  		_ ->
%  			ok
% 	end,
%     {noreply, State}; 
   


% %% 插入玩家对应的一条记录到数据库的arena表
% handle_cast({'db_insert_one_record_to_arena', PS}, State) ->
% 	?TRACE("[ARENA]handle cast : db_insert_one_record_to_arena!!!...~n"),
% 	lib_arena:db_insert_one_record_to_arena(PS),
%     {noreply, State};
    
% %% 从数据库加载玩家的竞技场信息到缓存  
% handle_cast({'load_my_arena_info_to_global_cache', PlayerId}, State) ->
% 	?TRACE("handle cast : load_my_arena_info_to_global_cache...~n"),
% 	case get_arena_info_from_global_cache(PlayerId) of
% 		null ->
% 			_Ret = load_my_arena_info_to_global_cache(PlayerId),
% 			?ASSERT(_Ret == ok, PlayerId);
% 		_ArInfo -> % 已经在缓存中了，不需再加载，故跳过
% 			skip
% 	end,
%     {noreply, State};
    
% handle_cast({'add_player_to_global_cache', PS}, State) ->
% 	?TRACE("handle cast : add_player_to_global_cache, id:~p...~n", [PS#player_status.id]),
% 	add_player_to_global_cache(PS),
%     {noreply, State};
    
% handle_cast({'add_partner_to_global_cache', Partner}, State) ->
% 	?TRACE("handle cast : add_partner_to_global_cache, id:~p...~n", [Partner#ets_partner.id]),
% 	add_partner_to_global_cache(Partner),
%     {noreply, State};
 
% handle_cast({'update_arena_info_to_global_cache', NewArInfo}, State) ->
% 	?TRACE("handle cast : update_arena_info_to_global_cache~n"),
% 	update_arena_info_to_global_cache(NewArInfo),
%     {noreply, State};   

    
    

% %% 玩家下线时做相关的处理    
% handle_cast({'handle_player_logout', PS, FightingParList, EquipCurrent}, State) ->
% 	% 稳妥起见，下线时解除锁定状态，以避免出bug后玩家可能一直处于锁定状态
% 	unlock_player_for_arena_battle(PS#player_status.id),
% 	case PS#player_status.cur_opponent_id /= 0 of
% 		true -> unlock_player_for_arena_battle(PS#player_status.cur_opponent_id);
% 		false -> skip
% 	end,
	
% 	case get_arena_info_from_global_cache(PS#player_status.id) of
% 		null ->
% 			?TRACE("mod_arena: handle_player_logout, player ~p is NOT in global arena info cache!!!!!!...~n", [PS#player_status.id]),
% 			skip;
% 		ArInfo ->
% 			?TRACE("mod_arena: handle_player_logout, player ~p is in global arena info cache!!!!, rank: ~p, FightingParList len: ~p...~n", [PS#player_status.id, ArInfo#arena.rank, length(FightingParList)]),
% 			?ASSERT(ArInfo#arena.id =:= PS#player_status.id),
			
% 			NewArInfo = ArInfo#arena{
% 							equip_current = EquipCurrent,  
% 							battle_capacity = PS#player_status.battle_capacity,
% 							vip = PS#player_status.vip,
% 							guild_name = lib_common:make_sure_binary(PS#player_status.guild_name)
% 							},  
% 			% 竞技场数据存到db
% 			save_arena_info_to_db(NewArInfo),
			 
% 			% 排名是否在最大缓存数量范围内？
% 			case ArInfo#arena.rank > ?MAX_RANK_NEED_CACHE of
% 				true -> % 排名不在最大缓存数量范围内
% 					?TRACE("id: ~p, out of ar rank range, so del from cache...~n", [PS#player_status.id]),
% 					% 简单起见，玩家排名超出最大缓存数量范围，则下线时就从全局缓存删掉
% 					del_arena_info_from_global_cache(ArInfo#arena.id),
					
% 					del_player_from_global_cache(ArInfo#arena.id),
% 					del_partners_from_global_cache_by_owner_id(ArInfo#arena.id);  %全局缓存删除玩家的武将
% 				false ->  % 排名在最大缓存数量范围内
% 					?TRACE("id: ~p, inside ar rank range, so update to cache...~n", [PS#player_status.id]),
% 					% 更新玩家的竞技场信息
% 					update_arena_info_to_global_cache(NewArInfo),
					
% 					% 如果不是处于播放剧情战斗CG状态，则更新数据到全局缓存
% 					% 注：播放剧情战斗CG时，玩家的状态数据有些是临时的（比如：battler_list），所以不应该更新到全局缓存
% 					case lib_player:is_playing_CG_battle(PS) of
% 						true ->
% 							?TRACE("id: ~p,, playing CG battle, so skip...~n", [PS#player_status.id]),
% 							skip;
% 						false ->
% 							% 更新玩家状态数据到全局玩家缓存
% 							?TRACE("id: ~p, do update to global cache, lv is: ~p !!~n", [PS#player_status.id, PS#player_status.lv]),
% 							update_player_to_global_cache(PS),
% 							% 更新目前出战的武将到全局武将缓存
% 							[update_partner_to_global_cache(X) || X <- FightingParList]
% 					end
% 			end
% 	end,
%     {noreply, State};
    
 

% %% 锁定玩家 
% handle_cast({'lock_player_for_arena_battle', PlayerId}, State) ->
% 	lock_player_for_arena_battle(PlayerId),
% 	{noreply, State};
	
	

% %% 更新玩家的通缉状态到全局缓存 
% handle_cast({'update_player_ident_flag_to_global_cache', PlayerId, NewIdentFlag}, State) ->
% 	case get_player_from_global_cache(PlayerId) of
% 		null ->
% 			skip;
% 		PS ->
% 			NewPS = PS#player_status{wanted_ident = NewIdentFlag},
% 			update_player_to_global_cache(NewPS)
% 	end,
% 	{noreply, State};

    

% %% 竞技场战斗结束后的相关处理 
% handle_cast({'handle_arena_battle_ends', [ChallengerPS, PassiveId, WinOrLose]}, State) ->
% 	ChallengerId = ChallengerPS#player_status.id,
% 	?TRACE("handle cast, handle_arena_battle_ends, ~p vs ~p, ~p...~n", [ChallengerId, PassiveId, WinOrLose]),
% 	% 1. 更新双方的global arena info
% 	case get_arena_info_from_global_cache(ChallengerId) of
% 		null ->
% 			?ASSERT(false),
% 			skip;
% 		ChallengerAr0 ->
% 			case get_arena_info_from_global_cache(PassiveId) of
% 				null ->
% 					?ASSERT(false),
% 					skip;
% 				PassiveAr ->
% 					?ASSERT(ChallengerAr0#arena.rank /= PassiveAr#arena.rank),
% 					% 同步一下挑战方的战斗力信息
% 					ChallengerAr = ChallengerAr0#arena{battle_capacity = ChallengerPS#player_status.battle_capacity},
% 					case WinOrLose of
% 						win ->
% 							?TRACE("challenger rank: ~p, Passive rank: ~p~n", [ChallengerAr#arena.rank, PassiveAr#arena.rank]),
% 							%TODO: 这里仅仅用于验证， 以后可以删掉
% 							?ASSERT(get_player_from_global_cache(PassiveId) /= null),
% 							case ChallengerAr#arena.rank =< ?MAX_RANK_NEED_CACHE of
% 								true -> ?ASSERT(get_player_from_global_cache(ChallengerId) /= null);
% 								false -> skip
% 							end,
							
% 							% 挑战赢了则奖励积分
% 							ChallengerRank = ChallengerAr#arena.rank,
% 							PassiveRank = PassiveAr#arena.rank,
% 							AwardAccPoints = lib_arena:calc_award_acc_points(ChallengerRank, PassiveRank),
% 							?TRACE("AwardAccPoints after win: ~p~n", [AwardAccPoints]),
							
% 							lib_player:display_gain_item(ChallengerPS, ?DISPLAY_AR_ACC_POINTS, AwardAccPoints),

% 							% 挑战赢了之后自动刷新对手列表
% 							gen_server:cast(self(), {'refresh_my_opponent_list_after_win', ChallengerId}),
% 							% 如果是挑战赢了战天王，则广播给所有在线玩家
% 							case PassiveRank =:= 1 of
% 								false -> skip;
% 								true -> gen_server:cast(self(), {'broadcast_arena_king_changed', ChallengerId})
% 							end,
% 							case ChallengerRank < PassiveRank of
% 								true ->
% 									% 挑战方的排名更靠前，则双方排名不变
% 									?TRACE("NOT need to change rank each other...~n"),
% 									NewChallengerAr = ChallengerAr#arena{
% 														acc_points = ChallengerAr#arena.acc_points + AwardAccPoints,
% 														already_chal_times = ChallengerAr#arena.already_chal_times + 1, % 已挑战次数加1
% 														winning_streak = ChallengerAr#arena.winning_streak + 1
% 														},
% 									NewPassiveAr = PassiveAr; % TODO： 被挑战方暂时不变，以后依据策划文档做修改
% 								false ->
% 									% 挑战方的排名落后于被挑战方，则双方排名互换
% 									NewChallengerAr = ChallengerAr#arena{
% 														acc_points = ChallengerAr#arena.acc_points + AwardAccPoints,
% 														rank = PassiveRank,
% 														% 这里记得更新等级段和称号
% 														grade = lib_arena:get_grade_by_rank(PassiveRank),
% 														title = lib_arena:get_title_by_rank(PassiveRank),
% 														already_chal_times = ChallengerAr#arena.already_chal_times + 1, % 已挑战次数加1
% 														winning_streak = ChallengerAr#arena.winning_streak + 1
% 														},
% 									NewPassiveAr = PassiveAr#arena{ % 被挑战方目前只是互换排名
% 														rank = ChallengerRank,
% 														% 这里记得更新等级段和称号
% 														grade = lib_arena:get_grade_by_rank(ChallengerRank),
% 														title = lib_arena:get_title_by_rank(ChallengerRank)
% 														}
% 							end,
                            
% 							% 虽然玩家下线时会保存其竞技场数据到db，
% 							% 但对于挑战方赢了的情况，因双方排名互换了，为了稳妥起见，这里即时存到db
% 							save_arena_info_to_db(NewChallengerAr),
% 							save_arena_info_to_db(NewPassiveAr);
% 						lose ->
% 							% 挑战输了则不奖励积分
% 							AwardAccPoints = 0,
% 							NewChallengerAr = ChallengerAr#arena{
% 													already_chal_times = ChallengerAr#arena.already_chal_times + 1, % 已挑战次数加1
% 													winning_streak = 0 % 重置连胜次数
% 													},
% 							NewPassiveAr = PassiveAr  % 被挑战方不变
% 					end,
					
% 					% 更新到ets
% 					update_arena_info_to_global_cache(NewChallengerAr),
% 					update_arena_info_to_global_cache(NewPassiveAr),

%                     % 通知排行榜
%                     gen_server:cast({global, mod_rank}, {event_arena,  ChallengerPS, WinOrLose, NewChallengerAr, NewPassiveAr}),
					
% 					% 2. 生成并更新战报记录
% 					update_battle_history_for_both(ChallengerAr, PassiveAr, NewChallengerAr, NewPassiveAr, WinOrLose),
					
% 					% 3. 通知挑战结果给双方
% 					lib_arena:notify_battle_result_to_both(ChallengerAr, PassiveAr, NewChallengerAr, NewPassiveAr, WinOrLose, [AwardAccPoints]),
					
% 					% 4. 通知竞技场新信息给双方		
% 					lib_arena:notify_new_arena_info_to_both(NewChallengerAr, NewPassiveAr)
% 			end
% 	end,
	
% 	% 解除双方的锁定状态
% 	unlock_player_for_arena_battle(ChallengerId),
% 	unlock_player_for_arena_battle(PassiveId),
% 	{noreply, State};




% %% 设置下次可以挑战的时间点
% handle_cast({'set_next_can_chal_time', PlayerId, NewTime}, State) ->
% 	?TRACE("handle cast, set_next_can_chal_time, new time: ~p...~n", [NewTime]),
% 	case get_arena_info_from_global_cache(PlayerId) of
% 		null ->
% 			?ASSERT(false),
% 			skip;
% 		ArInfo ->
% 			NewArInfo = ArInfo#arena{next_can_chal_time = NewTime},
% 			update_arena_info_to_global_cache(NewArInfo)
% 	end,
%     {noreply, State};
    


% %% 增加竞技场积分，如果参数AddNum为负数，则表示是扣积分
% handle_cast({'asyn_add_acc_points', PlayerId, AddNum}, State) ->
% 	?TRACE("handle cast, asyn_add_acc_points, PlayerId: ~p, AddNum: ~p...~n", [PlayerId, AddNum]),
% 	case get_arena_info_from_global_cache(PlayerId) of
% 		null ->
% 			?ASSERT(false, PlayerId),
% 			skip;
% 		ArInfo ->
% 			NewAccPoints = max(ArInfo#arena.acc_points + AddNum, 0), % 做一下范围矫正（以防万一）
% 			?TRACE("NewAccPoints: ~p~n", [NewAccPoints]),
% 			NewArInfo = ArInfo#arena{acc_points = NewAccPoints},
% 			update_arena_info_to_global_cache(NewArInfo),
			
% 			if 
% 				AddNum > 0 ->  % 加积分
% 					lib_player:display_gain_item(PlayerId, ?DISPLAY_AR_ACC_POINTS, AddNum);
% 				AddNum < 0 ->  % 扣加分
% 					AbsoluteNum = util:absolute(AddNum),
% 					log:log_currency_consume(PlayerId, acc_points, AbsoluteNum);
% 				true ->
% 					skip	
% 			end
% 	end,
%     {noreply, State};


    

% %% 设置当天剩余可挑战次数
% %%handle_cast({'set_can_chal_times', PlayerId, NewTimes}, State) ->
% %%	?TRACE("handle cast, set_can_chal_times, new times: ~p...~n", [NewTimes]),
% %%	case get_arena_info_from_global_cache(PlayerId) of
% %%		null ->
% %%			?ASSERT(false, PlayerId), skip;
% %%		ArInfo ->
% %%			NewArInfo = ArInfo#arena{can_chal_times = NewTimes},
% %%			update_arena_info_to_global_cache(NewArInfo)
% %%	end,
% %%    {noreply, State};


% %% 清零当天已挑战次数（目前仅用于gm指令）
% handle_cast({'clear_already_chal_times', PlayerId}, State) ->
% 	?TRACE("handle cast, clear_already_chal_times...~n"),
% 	case get_arena_info_from_global_cache(PlayerId) of
% 		null ->
% 			skip;
% 		ArInfo ->
% 			NewArInfo = ArInfo#arena{already_chal_times = 0},
% 			update_arena_info_to_global_cache(NewArInfo)
% 	end,
%     {noreply, State};



    
    
% %% 设置可刷新对手列表的次数
% handle_cast({'set_can_refresh_oppo_list_times', PlayerId, NewTimes}, State) ->
% 	?TRACE("handle cast, set_can_refresh_oppo_list_times...~n"),
% 	case get_arena_info_from_global_cache(PlayerId) of
% 		null ->
% 			?ASSERT(false), skip;
% 		ArInfo ->
% 			NewArInfo = ArInfo#arena{can_refresh_oppo_times = NewTimes},
% 			update_arena_info_to_global_cache(NewArInfo)
% 	end,
%     {noreply, State};

    
% %% 广播给所有在线玩家：战天王改了
% handle_cast({'broadcast_arena_king_changed', NewArenaKingId}, State) ->
% 	?TRACE("handle cast, broadcast_arena_king_changed...~n"),
% 	case get_arena_info_from_global_cache(NewArenaKingId) of
% 		null ->
% 			?ASSERT(false),
% 			skip;
% 		ArInfo ->
% 			{ok, BinData} = pt_23:write(?PT_AR_QUERY_ARENA_KING, ArInfo),
% 			lib_send:send_to_all_from_world_node(BinData)
% 	end,
%     {noreply, State};
    
    
% %% 挑战赢了之后自动刷新对手列表
% handle_cast({'refresh_my_opponent_list_after_win', PlayerId}, State) ->
% 	?TRACE("handle cast, refresh_my_opponent_list_after_win...~n"),
% 	case get_arena_info_from_global_cache(PlayerId) of
% 		null ->
% 			?ASSERT(false),
% 			skip;
% 		ArInfo ->
% 			NewOpponentList = refresh_my_opponent_list(PlayerId, ?NEED_COST_TIMES_NO),
% 			NewArInfo = ArInfo#arena{cur_opponent_list = [X#arena.id || X <- NewOpponentList]},
% 			update_arena_info_to_global_cache(NewArInfo),
% 			lib_arena:notify_my_opponent_list_changed(PlayerId, NewOpponentList)
% 	end,
%     {noreply, State};


% handle_cast(_Msg, State) ->
% 	?ASSERT(false),
%     {noreply, State}.
    
    

    


% %% 做一些初始化的工作
% handle_info({'do_init_jobs'}, State) ->
% 	load_global_arena_info(),
%     load_players_to_global_cache(),
%     load_partners_to_global_cache(),
% 	{noreply, State};
	
% handle_info(_Info, State) ->
%     {noreply, State}.

% terminate(_Reason, _State) ->
%     ok.

% code_change(_OldVsn, State, _Extra) ->
%     {ok, State}.


	
	
% %% 更新双方的战报记录
% %% @para: Challenger => 挑战方， Passive => 被挑战方， 
% %%        WinOrLose=> 挑战方是赢了还是输了
% update_battle_history_for_both(OldChalgr, OldPassive, Challenger, Passive, WinOrLose) ->
%   	?TRACE("update_battle_history_for_both...~n"),
%   	ResCode = case WinOrLose of
% 		win -> 1;
% 		lose -> 0
% 	end,
% 	?TRACE("update chalgr bat his: old rank: ~p, new rank: ~p, rescode: ~p~n", [OldChalgr#arena.rank, Challenger#arena.rank, ResCode]),
% 	TimeNow = util:unixtime(),
% 	% 生成挑战方的战报记录
% 	ArBattleHistory1 = #ar_battle_history{
% 		is_passive = 0,
% 		opponent_id = Passive#arena.id,
% 		opponent_name = Passive#arena.name,
% 		win_or_lose = ResCode,
% 		old_rank_then = OldChalgr#arena.rank,
% 		new_rank_then = Challenger#arena.rank,
% 		occur_time = TimeNow
% 		},
% 	case length(Challenger#arena.battle_history) =:= ?MAX_BATTLE_HISTORY_SHOWED of
% 		true ->
% 			% 去掉最早的战报记录
% 			[_H1 | T1] = Challenger#arena.battle_history,
% 			NewBattleHisList1 = T1 ++ [ArBattleHistory1],
% 			% 更新
% 			update_arena_info_to_global_cache(Challenger#arena{battle_history = NewBattleHisList1});
% 		false ->
% 			NewBattleHisList1 = Challenger#arena.battle_history ++ [ArBattleHistory1],
% 			% 更新
% 			update_arena_info_to_global_cache(Challenger#arena{battle_history = NewBattleHisList1})
% 	end,
	
% 	% 被挑战方的输赢标记和挑战方是反过来的
% 	ResCode2 = case WinOrLose of
% 		win -> 0;
% 		lose -> 1
% 	end,
% 	?TRACE("update passive bat his: old rank: ~p, new rank: ~p, rescode: ~p~n", [OldPassive#arena.rank, Passive#arena.rank, ResCode2]),
% 	% 生成被挑战方的战报记录
% 	ArBattleHistory2 = #ar_battle_history{
% 		is_passive = 1,
% 		opponent_id = Challenger#arena.id,
% 		opponent_name = Challenger#arena.name,
% 		win_or_lose = ResCode2,
% 		old_rank_then = OldPassive#arena.rank,
% 		new_rank_then = Passive#arena.rank,
% 		occur_time = TimeNow
% 		},
% 	case length(Passive#arena.battle_history) =:= ?MAX_BATTLE_HISTORY_SHOWED of
% 		true ->
% 			% 去掉最早的战报记录
% 			[_H2 | T2] = Passive#arena.battle_history,
% 			NewBattleHisList2 = T2 ++ [ArBattleHistory2],
% 			% 更新
% 			update_arena_info_to_global_cache(Passive#arena{battle_history = NewBattleHisList2});
% 		false ->
% 			NewBattleHisList2 = Passive#arena.battle_history ++ [ArBattleHistory2],
% 			% 更新
% 			update_arena_info_to_global_cache(Passive#arena{battle_history = NewBattleHisList2})
% 	end.
	
	
	
	

% %% 从数据库加载前xxx名玩家的竞技场数据到缓存
% load_global_arena_info() ->
% 	% 依据排名先后的顺序select数据
% 	case db:select_all(arena, "player_id", [], [{rank}], [?MAX_RANK_NEED_CACHE]) of
% 		[] ->
% 			?TRACE("there are not any arena record!!!~n"),
% 			skip;
% 		RetList when is_list(RetList) ->
% 			?TRACE("load_global_arena_info(), ret player id list: ~p~n", [RetList]),
			
% 			PlayerIdList = lists:flatten(RetList),
% 			FirstLoop = 1, % 第一次循环
% 			lists:foldl(fun loop_load_arena_info_to_global_cache/2, FirstLoop, PlayerIdList);
% 		_ -> % db操作出错
% 			?ASSERT(false),
% 			skip
% 	end.
	
		

	
	



% %% ====================================== Local Functions ====================================================
	
	
% %% TODO: 此接口应该重命一个更好的名字
% %%make_global_arena_info_and_insert_to_ets(InfoList, CurLoop) ->
% %%	[Date, PlayerId, _AccPoints, Rank | _T] = InfoList,
% %%	
% %%	[Date | InfoList2] = InfoList,
% %%	?TRACE("make global arena info, rank : ~p, cur loop: ~p, playerid: ~p~n", [Rank, CurLoop, PlayerId]),
% %%	% 这里断言排名和本次是第几次循环一致，从而间接断言了排名是连贯的，中间没有空缺
% %%	?ASSERT(Rank =:= CurLoop),
% %%	%%ArenaBrief = make_global_arena_brief([PlayerId, AccPoints, Rank]),
% %%	ArenaInfo = lib_arena:make_arena_base_info(InfoList2),
% %%	case get_player_extra_info_from_db(PlayerId) of
% %%		{fail} ->
% %%%% 			?ASSERT(false),
% %%			skip;
% %%		{ok, [Name, Lv, Career]} ->
% %%			NewArenaInfo = ArenaInfo#arena{name = binary_to_list(Name), lv = Lv, career = Career},
% %%			ets:insert(?ETS_GLOBAL_ARENA_INFO, NewArenaInfo)
% %%	end,
% %%	
% %% 	%%ets:insert(?ETS_GLOBAL_ARENA_BRIEF, ArenaBrief),
% %% 	CurLoop + 1.
 	

% %% 循环load竞技场信息到全局缓存
% loop_load_arena_info_to_global_cache(PlayerId, CurLoop) ->
% 	load_my_arena_info_to_global_cache(PlayerId),
% 	% 做断言验证
% 	case get_arena_info_from_global_cache(PlayerId) of
% 		null ->
% 			?ASSERT(false, PlayerId),
% 			skip;
% 		ArInfo ->
% 			Rank = ArInfo#arena.rank,
% 			%%?TRACE("load arena info to cache ok! rank: ~p, cur loop: ~p, playerid: ~p~n", [Rank, CurLoop, PlayerId]),
% 			% 这里断言排名和本次是第几次循环一致，从而间接断言了排名是连贯的，中间没有空缺
% 			?ASSERT(Rank =:= CurLoop, {Rank, CurLoop, PlayerId}),
			
% 			% 以防万一，做矫正排名的容错处理
% 			?IFC (Rank =/= CurLoop)
% 				NewArInfo = ArInfo#arena{rank = CurLoop},
% 				update_arena_info_to_global_cache(NewArInfo)
% 			?END
% 	end,
% 	CurLoop + 1.
 	
 	
% %%make_global_arena_brief([PlayerId, AccPoints, Rank]) ->
% %%	?TRACE("this is make_global_arena_brief/1~n"),
% %%	% 获取名字
% %%	PlayerName = case lib_player:get_role_name_by_id(PlayerId) of
% %%		[] ->
% %%			?TRACE("~p~n", [PlayerId]),
% %%			?ASSERT(false),
% %%			skip;
% %%		Name ->
% %%			?ASSERT(is_list(Name)),
% %%			Name
% %%	end,
% %%	#g_arena_brief{
% %%			id = PlayerId,
% %%			name = PlayerName,
% %%			acc_points = AccPoints,
% %%			grade = lib_arena:calc_grade_by_rank(Rank),
% %%			rank = Rank
% %% 		}.
	
	
% %% TODO:...
% %%update_global_player_cache(PS) ->
% %%	?TRACE("update_global_player_cache() ...~n"),
% %%	todo_here.
	
	
	
% %%rpc_update_global_player_cache(_PS) ->
% %%	todo_here.



% %%rpc_update_global_partner_cache() ->
% %%	todo_here.
	
	
	
	
	
	
	
% %% 保存玩家的竞技场数据到db	
% save_arena_info_to_db(ArInfo) ->
% 	?TRACE("save_arena_info_to_db()...~n"),
% 	?TRACE("battle history count: ~p~n", [length(ArInfo#arena.battle_history)]),
	
% 	BattleHisCount = length(ArInfo#arena.battle_history),
% 	?ASSERT(BattleHisCount =< ?MAX_BATTLE_HISTORY_SHOWED, {ArInfo#arena.id, BattleHisCount}),
% 	BattleHisBitStr = case util:term_to_bitstring(ArInfo#arena.battle_history) of <<"undefined">> -> <<>>; _Any -> _Any end,
% 	?ASSERT(byte_size(BattleHisBitStr) < 1600, byte_size(BattleHisBitStr)),
	
% 	db:update(arena, 
% 			  ["date", "battle_capacity", "acc_points", "rank", "cur_opponent_list", "already_chal_times", "can_refresh_oppo_times", "winning_streak", "battle_history", "can_worship_arena_king", "can_admire_arena_king", "equip_current"],
% 			  [ArInfo#arena.date,
% 						 ArInfo#arena.battle_capacity,
% 						 max(ArInfo#arena.acc_points, 0),
% 						 ArInfo#arena.rank,
% 						 case util:term_to_bitstring(ArInfo#arena.cur_opponent_list) of <<"undefined">> -> <<>>; Any -> Any end,
% 						 ArInfo#arena.already_chal_times,
% 						 ArInfo#arena.can_refresh_oppo_times,
% 						 ArInfo#arena.winning_streak,
% 						 BattleHisBitStr,
% 						 ArInfo#arena.can_worship_arena_king,
% 						 ArInfo#arena.can_admire_arena_king,
% 						 case util:term_to_bitstring(ArInfo#arena.equip_current) of <<"undefined">> -> <<>>; Any -> Any end
% 						],
% 			  "player_id",
% 			  ArInfo#arena.id).
	
	
	



% %% 从数据库加载玩家的竞技场信息并插入ets作为缓存
% %% @return: fail | ok
% load_my_arena_info_to_global_cache(PlayerId) ->
% 	?TRACE("load arena info from db, id: ~p~n", [PlayerId]),
% 	case catch lib_player:get_player_extra_info_from_db(PlayerId) of
% 		{fail} ->
% 			?TRACE("can not get player extra ...~n"),
% 			fail;
% 		{ok, [Name, Lv, Sex, Career, _WantedIdent, VipLv, GuildName]} ->
% 			case db:select_row(arena, ?SQL_GET_ARENA_INFO, [{player_id,PlayerId}]) of
% 				[] ->
% 					?TRACE("no arena record in db...~n"),
% 					fail;
% 				InfoList when is_list(InfoList) ->
% 					ArInfo = lib_arena:make_arena_base_info(InfoList),
% 					Today = lib_common:date_to_int(erlang:date()),
% 					case Today =/= ArInfo#arena.date of
% 						true -> 
% 							% 第二天自动重置已挑战次数、可刷新对手列表次数、可膜拜战天王以及可钦佩战天王标记
% 							NewArInfo = ArInfo#arena{
% 											name = binary_to_list(Name), 
% 											lv = Lv,
% 											sex = Sex,
% 											career = Career, 
% 											guild_name = lib_common:make_sure_binary(GuildName),
% 											vip = VipLv,
% 											already_chal_times = 0, 
% 											can_refresh_oppo_times = ?TIMES_CAN_REFRESH_OPPO_LIST_ONE_DAY,
% 											can_worship_arena_king = 1,
% 											can_admire_arena_king = 1,
% 											date = Today
% 											};
% 						false ->
% 							NewArInfo = ArInfo#arena{
% 											name = binary_to_list(Name),
% 											lv = Lv, 
% 											sex = Sex, 
% 											career = Career,
% 											guild_name = lib_common:make_sure_binary(GuildName),
% 											vip = VipLv
% 											}
% 					end,
% 					% 插入ets_global_arena_info作为全局缓存
% 					add_arena_info_to_global_cache(NewArInfo),
% 					ok;
% 				Error ->
% 					?ERROR_MSG("load_my_arena_info_to_global_cache() failed--player_id:~p, reason:~p", [PlayerId, Error]),
% 					?ASSERT(false, Error),
% 					fail
% 			end
% 	end.
	
	
	



	
	

% %% 添加玩家的竞技场信息到缓存
% add_arena_info_to_global_cache(ArInfo) ->
% 	?ASSERT(is_record(ArInfo, arena)),
% 	ets:insert(?ETS_GLOBAL_ARENA_INFO, ArInfo).


% %% 从缓存获取玩家的竞技场信息	
% get_arena_info_from_global_cache(PlayerId) ->
% 	case ets:lookup(?ETS_GLOBAL_ARENA_INFO, PlayerId) of
% 		[] -> null;
% 		[ArInfo] -> ArInfo
% 	end.

% %% 更新玩家的竞技场信息到缓存	
% update_arena_info_to_global_cache(NewArInfo) ->
% 	?ASSERT(is_record(NewArInfo, arena)),
% 	ets:insert(?ETS_GLOBAL_ARENA_INFO, NewArInfo).
	

% %% 从缓存删掉指定玩家的竞技场信息	
% del_arena_info_from_global_cache(PlayerId) ->
% 	ets:delete(?ETS_GLOBAL_ARENA_INFO, PlayerId),
% 	?ASSERT(get_arena_info_from_global_cache(PlayerId) =:= null).
	
	
	
	


	
% %% 添加玩家到(全局玩家)缓存	
% add_player_to_global_cache(PlayerStatus) ->
% 	?ASSERT(is_record(PlayerStatus, player_status)),
% 	ets:insert(?ETS_GLOBAL_PLAYER_CACHE, PlayerStatus).
	
% %% 添加武将到(全局武将)缓存	
% add_partner_to_global_cache(Partner) ->
% 	?ASSERT(is_record(Partner, ets_partner)),
% 	ets:insert(?ETS_GLOBAL_PARTNER_CACHE, Partner).
	
	
% %% 从缓存获取玩家数据
% %% @return: null | player_status结构体	
% get_player_from_global_cache(PlayerId) ->
% 	case ets:lookup(?ETS_GLOBAL_PLAYER_CACHE, PlayerId) of
% 		[] -> null;
% 		[PlayerStatus] -> PlayerStatus
% 	end.

% %% 从缓存获取武将数据
% %% @return: null | ets_partner结构体	
% get_partner_from_global_cache(PartnerId) ->
% 	case ets:lookup(?ETS_GLOBAL_PARTNER_CACHE, PartnerId) of
% 		[] -> null;
% 		[Partner] -> Partner
% 	end.
	
% %% 更新玩家到(全局玩家)缓存	
% update_player_to_global_cache(NewPS) ->
% 	ets:insert(?ETS_GLOBAL_PLAYER_CACHE, NewPS).
	
	
% %% 更新武将到(全局武将)缓存	
% update_partner_to_global_cache(NewParInfo) ->
% 	ets:insert(?ETS_GLOBAL_PARTNER_CACHE, NewParInfo).
	
	
% %% 从(全局玩家)缓存删除玩家	
% del_player_from_global_cache(PlayerId) ->
% 	ets:delete(?ETS_GLOBAL_PLAYER_CACHE, PlayerId),
% 	?ASSERT(get_player_from_global_cache(PlayerId) =:= null).
	
	
% %% 从(全局武将)缓存删除武将	
% %%del_partner_from_global_cache(PartnerId) ->
% %%	ets:delete(?ETS_GLOBAL_PARTNER_CACHE, PartnerId).


% %% 从(全局武将)缓存删除玩家的所有武将
% del_partners_from_global_cache_by_owner_id(PlayerId) ->
% 	?TRACE("del_partners_from_global_cache_by_owner_id()..., player id: ~p~n", [PlayerId]),
% 	Pattern = #ets_partner{player_id = PlayerId,  _ = '_'},
% 	ets:match_delete(?ETS_GLOBAL_PARTNER_CACHE, Pattern),
% 	?ASSERT(ets:match_object(?ETS_GLOBAL_PARTNER_CACHE, Pattern) =:= []).
	



% %% 判断挑战方是否可以发起挑战	
% rpc_check_can_start_challenge(ChallengerPS, PassiveId) ->
% 	?TRACE("rpc_check_can_start_challenge...~n"),
% 	% 处理超时的情况
% 	case catch gen_server:call({global, ?GLOBAL_ARENA_PROCESS}, {'check_can_start_challenge', ChallengerPS, PassiveId}) of
%         {'EXIT', _Reason} ->
%         	?TRACE("rpc_check_can_start_challenge(), exit for reason: ~p~n", [_Reason]),
%         	?ERROR_MSG("rpc_check_can_start_challenge(), exit for reason: ~p~n", [_Reason]),
%         	?ASSERT(false, _Reason),
%             {fail, ?AR_START_CHAL_FAIL_UNKNOWN};
%         Ret ->
%         	Ret
%     end.
    
    
% %% 发起挑战时， 补充判断对手是否可以被挑战	
% check_can_be_challenged(OpponentPS) ->
% 	if	OpponentPS == null ->
% 			?ERROR_MSG("[ARENA]check_can_be_challenged(), OpponentPS is null!!!", []),
% 			{fail, ?AR_START_CHAL_FAIL_SERVER_BUSY};
% 		not is_record(OpponentPS, player_status) ->
% 			?ASSERT(false, OpponentPS),
% 			?ERROR_MSG("[ARENA]check_can_be_challenged(), OpponentPS is not player_status but ~p!!!", [OpponentPS]),
% 			{fail, ?AR_START_CHAL_FAIL_UNKNOWN};
% 		OpponentPS#player_status.cur_state == ?PS_PLAYING_CG_BATTLE ->
% 			{fail, ?AR_START_CHAL_FAIL_OPPO_IS_LOCKED};
% 		true ->
% 			{ok}
% 	end.
	
		


% %% 是否处于锁定状态			
% is_locked_for_arena_battle(ArenaInfo) ->
% 	ArenaInfo#arena.is_locked.
	
% %% 锁定玩家	
% lock_player_for_arena_battle(PlayerId) ->
% 	?TRACE("lock_player(), id:~p...~n", [PlayerId]),
% 	ArInfo = get_arena_info_from_global_cache(PlayerId),
% 	?ASSERT(ArInfo /= null),
% 	NewArInfo = ArInfo#arena{is_locked = true},
% 	update_arena_info_to_global_cache(NewArInfo).  %%ets:insert(?ETS_GLOBAL_ARENA_INFO, NewArInfo).

% %% 解除对玩家的锁定	    
% unlock_player_for_arena_battle(PlayerId) ->
% 	?TRACE("unlock_player(), id:~p...~n", [PlayerId]),
% 	ArInfo = get_arena_info_from_global_cache(PlayerId),
% 	case ArInfo == null of
% 		true ->
% 			?DEBUG_MSG("[ARENA]unlock_player_for_arena_battle(), got ar info NULL!!! player id: ~p~n", [PlayerId]),
% 			skip;
% 		false ->
% 			NewArInfo = ArInfo#arena{is_locked = false},
% 			update_arena_info_to_global_cache(NewArInfo)
% 	end.
			
	
	
% %% 处理购买竞技场商店的物品	
% buy_goods_ok(PS, MyArInfo, GoodsStatus, TargetGoods, BuyCount) ->
% 	GoodsTypeId = TargetGoods#ar_shop_goods.goods_type_id,
% 	InitBindState = TargetGoods#ar_shop_goods.init_bind_state,
% 	% 暂定给予即绑定
% 	case lib_bag:add_goods_to_role_bag(clean, PS, GoodsStatus, InitBindState, [{GoodsTypeId, BuyCount}]) of
% 		{fail, _Reason} ->
% 			{fail, ?AR_BUY_FAIL_UNKNOWN};
% 		{ok} ->
% 			NeedMoney = TargetGoods#ar_shop_goods.price * BuyCount,
% 			PriceType = TargetGoods#ar_shop_goods.price_type,
% 			% 扣钱（注意：不一定需花费钱）
% 			NewPS = case NeedMoney > 0 of
% 						true ->
% 							TmpNewPS = lib_money:cost_money(PS, NeedMoney, PriceType),
% 							lib_money:notify_player_money_changed(TmpNewPS),
% 							TmpNewPS;
% 						false ->
% 							PS
% 					end,
			
% 			CostAccPoints = TargetGoods#ar_shop_goods.cost_acc_points * BuyCount,
% 			% 扣积分（第二个参数传入负值，表示是扣积分）
% 			?IFC (CostAccPoints > 0)
% 				rpc_asyn_add_acc_points(PS#player_status.id, -CostAccPoints)
% 			?END,
			
% 			CostBattleContrib = TargetGoods#ar_shop_goods.cost_battle_contrib * BuyCount,
% 			% 扣战功值
% 			NewPS2 = case CostBattleContrib > 0 of
% 						true ->
% 							% 以防万一，做一下矫正
% 							NewBattleContrib = max(NewPS#player_status.battle_contrib - CostBattleContrib, 0),
% 							NewPS#player_status{battle_contrib = NewBattleContrib};
% 						false ->
% 							NewPS
% 					 end,
					 			
% 			lib_player:notify_player_attr_changed(NewPS2),
% 			% 返回玩家的新状态
% 			{ok, NewPS2, MyArInfo#arena.acc_points - CostAccPoints}
% 	end.
	








% %% 仅仅用于调试	
% just_for_test() ->
% 	_Size1 = ets:info(?ETS_GLOBAL_ARENA_INFO, size),
% 	_Size2 = ets:info(?ETS_GLOBAL_PLAYER_CACHE, size),
% 	_Size3 = ets:info(?ETS_GLOBAL_PARTNER_CACHE, size),
% 	?TRACE("ar cache size: ~p~n player cache size: ~p~n par cache size: ~p~n", [_Size1, _Size2, _Size3]).
	
