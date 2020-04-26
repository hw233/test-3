%% @author wujiancheng
%% @doc @todo Add description to lib_luck.  lib_luck:start_desire(1000100000000334,2).


-module(lib_luck).

-include("luck_info.hrl").
-include("common.hrl").
-include("prompt_msg_code.hrl").
-include("reward.hrl").
-include("monopoly.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("optional_turntable.hrl").
-include("pt_54.hrl").


-export([take_xuyuanchi_extra_reward/2,start_hunting/2,
		 open_hunting_interface/2,receive_weekly_reward/2,
		 close_hunting_interface/2,start_desire/2,weekly_clear_hunting/0,refresh_luck/2,
        open_face/1,enter_game/1,free_time_no_enough/2,get_rich_table/0,team_leader_dice/2
		,stand_on_chess/2,rich_info_reset/0,check_optional/2]).



%Type 1代表寻宝、2代表许愿 玩家数据同时点开界面可能存在丢失
open_hunting_interface(PlayerId,Type) ->
	case ets:lookup(ets_luck_player_info, PlayerId) of
		[] ->
			%从数据库里加载
			case db:select_row(luckdraw, "treasure_value,desire_value,treasure_weekly_value,have_treasure_weekly,have_desire", [{player_id,  PlayerId}]) of
				[TreasureValue, DesireValue,TreasureWeeklyValue, HaveTreasureWeekly, HaveDesire] ->
					ets:insert(ets_luck_player_info, #luck_player_info{  player_id = PlayerId
																		 ,treasure_value = TreasureValue
																		 ,desire_value = DesireValue
																		 ,treasure_weekly_value = TreasureWeeklyValue
																		 ,have_treasure_weekly = util:bitstring_to_term(HaveTreasureWeekly)
																		 ,have_desire = util:bitstring_to_term(HaveDesire)}),
					case Type of
						2 ->
							case ets:lookup(ets_desire_integral_pool, desire_integral) of
								[] ->
									case db:select_row(global_sys_var, "var", [{sys,  1005}]) of
										[Var] ->
											ets:insert(ets_desire_integral_pool, {desire_integral, util:bitstring_to_term(Var) }),
											{ok, Bin} =pt_54:write(54010, [ util:bitstring_to_term(Var), DesireValue, util:bitstring_to_term(HaveDesire)]),
			                                lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
										[] ->
											db:insert(global_sys_var, [sys,var],[1005,util:term_to_bitstring(0)]),
											ets:insert(ets_desire_integral_pool, {desire_integral, 0 }),
											{ok, Bin} =pt_54:write(54010, [ 0 , DesireValue, util:bitstring_to_term(HaveDesire)]),
			                                lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
									end;
								[{desire_integral,Var}] ->
									{ok, Bin} =pt_54:write(54010, [ Var, DesireValue, util:bitstring_to_term(HaveDesire)]),
									lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
							end;
						1 ->
							{ok, Bin} =pt_54:write(54003, [ TreasureValue, TreasureWeeklyValue,util:bitstring_to_term(HaveTreasureWeekly)]),
							lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
					end;
					
				[] ->
					%初始化玩家数据<<>>
					db:insert(luckdraw, [player_id, treasure_value, desire_value,treasure_weekly_value, have_treasure_weekly, have_desire],
							  [PlayerId, 0, 0, 0, util:term_to_bitstring([]), util:term_to_bitstring([])] ),
					ets:insert(ets_luck_player_info, #luck_player_info{  player_id = PlayerId
																		 ,treasure_value = 0
																		 ,desire_value = 0
																		 ,treasure_weekly_value = 0
																		 ,have_treasure_weekly = []
																		 ,have_desire = []}),
					
					case Type of
						2 ->
							case ets:lookup(ets_desire_integral_pool, desire_integral) of
								[] ->
									case db:select_row(global_sys_var, "var", [{sys,  1005}]) of
										[Var] ->
											ets:insert(ets_desire_integral_pool, {desire_integral, util:bitstring_to_term(Var) }),
											{ok, Bin} =pt_54:write(54010, [ util:bitstring_to_term(Var), 0, []]),
											lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
										[] ->
											db:insert(global_sys_var, [sys,var],[1005,util:term_to_bitstring(0)]),
											ets:insert(ets_desire_integral_pool, {desire_integral, 0 }),
											{ok, Bin} =pt_54:write(54010, [ 0 , 0, []]),
											lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
									end;
								[{desire_integral,Var}] ->
									{ok, Bin} =pt_54:write(54010, [ Var, 0, []]),
									lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
							end;
						1 ->
							{ok, Bin2} =pt_54:write(54003, [ 0, 0,[]]),
							lib_send:send_to_sock(player:get_PS(PlayerId), Bin2)
					end
					
			end;
		_ -> skip
	end,
	case ets:lookup(ets_open_interface, Type) of
		[] -> ets:insert(ets_open_interface, {Type,[PlayerId]});
		[{_,PlayerList}] ->
			%防止同个玩家存在多次的情况  
			PlayerList2 = lists:delete(PlayerId, PlayerList),
			PlayerList3 = [PlayerId|PlayerList2],
			ets:insert(ets_open_interface, {Type,PlayerList3}),
			[PlayerInfo] = ets:lookup(ets_luck_player_info, PlayerId),
			PlayerHaveDesire = PlayerInfo#luck_player_info.have_desire,
			case Type of
				2 ->
					case ets:lookup(ets_desire_integral_pool, desire_integral) of
						[] ->
							case db:select_row(global_sys_var, "var", [{sys,  1005}]) of
								[Var2] ->
									ets:insert(ets_desire_integral_pool, {desire_integral, util:bitstring_to_term(Var2) }),
									{ok, Bin0} =pt_54:write(54010, [ util:bitstring_to_term(Var2), PlayerInfo#luck_player_info.desire_value, PlayerHaveDesire]),
									lib_send:send_to_sock(player:get_PS(PlayerId), Bin0);
								[] ->
									db:insert(global_sys_var, [sys,var],[1005,util:term_to_bitstring(0)]),
									ets:insert(ets_desire_integral_pool, {desire_integral, 0 }),
									{ok, Bin0} =pt_54:write(54010, [ 0, PlayerInfo#luck_player_info.desire_value, PlayerHaveDesire]),
									lib_send:send_to_sock(player:get_PS(PlayerId), Bin0)
							end;
						[{desire_integral,Var2}] ->
							{ok, Bin0} =pt_54:write(54010, [ Var2, PlayerInfo#luck_player_info.desire_value, PlayerHaveDesire]),
							lib_send:send_to_sock(player:get_PS(PlayerId), Bin0)
					end;
				1 ->
					{ok, BinData3} =pt_54:write(54003, [ PlayerInfo#luck_player_info.treasure_value, PlayerInfo#luck_player_info.treasure_weekly_value,PlayerInfo#luck_player_info.have_treasure_weekly]),
					lib_send:send_to_sock(player:get_PS(PlayerId), BinData3)
			end,
			%推送寻宝记录ets:lookup(ets_lottery_record, 2).
            case ets:lookup(ets_lottery_record, Type) of
				[] ->
					skip;
				[HistoryR] ->
					case Type of
						1 ->
							
							History =lists:sublist( HistoryR#ets_lottery_history.lottery_history, 9) ,
							History2 = lists:reverse(History),
							{ok, BinData2} =pt_54:write(54005, [History2]),
							lib_send:send_to_sock(player:get_PS(PlayerId), BinData2);
						2 ->
							
							History =lists:sublist(HistoryR#ets_lottery_history.lottery_history, 9),
							History2 = lists:reverse(History),
							{ok, BinData2} =pt_54:write(54011, [History2]),
							lib_send:send_to_sock(player:get_PS(PlayerId), BinData2)
					end
			end
            
	end.

start_hunting(PlayerId, Type) ->
	 XunBaoList = data_xunbao_xuyuanchi_cost:get_xunbao_no(),
	 case lists:member(Type, XunBaoList) of
		 true ->	 
			 [PlayerInfo] = ets:lookup(ets_luck_player_info, PlayerId),
			 XunBaoInfo = data_xunbao_xuyuanchi_cost:get(Type),
			 NeedCost = XunBaoInfo#xunbao_xuyuanchi_cost.draw_cost,
			 {_, YuanBaoCount}  = NeedCost,
			 case Type of
				 3 -> case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost])  of
						  ok ->
							  mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["lib_luck", "start_luck"]),
							  do_start(PlayerId,XunBaoInfo,PlayerInfo,1);

						  {fail, Reason} ->
							  lib_send:send_prompt_msg(PlayerId, Reason)
					  end;
				 _ ->
					 case player:has_enough_bind_yuanbao(player:get_PS(PlayerId), YuanBaoCount) of
						 true ->
							 player:cost_yuanbao(player:get_PS(PlayerId), YuanBaoCount, ["lib_luck","start_luck"]),
							 do_start(PlayerId,XunBaoInfo,PlayerInfo,1);
						 false -> lib_send:send_prompt_msg(PlayerId, ?PM_YB_LIMIT)
					 end
			 end
	 end.

start_desire(PlayerId, Type) ->
	 DesireList = data_xunbao_xuyuanchi_cost:get_xuyuanchi_no(),
	 case lists:member(Type, DesireList) of
		 true ->
			 [PlayerInfo] = ets:lookup(ets_luck_player_info, PlayerId),
			 %% 许愿池累积奖励领取后才能许愿
			 HaveDesire = PlayerInfo#luck_player_info.have_desire,
			 DesireValue = PlayerInfo#luck_player_info.desire_value,
			 case erlang:length(HaveDesire) < 5 andalso DesireValue >= data_special_config:get('wish_num') of
				 true -> skip;
				 false ->
					  DesireInfo = data_xunbao_xuyuanchi_cost:get(Type),
					  StartNum = DesireInfo#xunbao_xuyuanchi_cost.num,
					  NeedCost = DesireInfo#xunbao_xuyuanchi_cost.draw_cost,
					  {_, IntegralCount}  = NeedCost,
					  case Type of
						  6 ->
							  case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost])  of
								  ok ->
									  mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["lib_luck", "start_luck"]),
									  WishScore = data_special_config:get(wish_score),
									  gen_server:cast(mod_global_collection, {'set_desire_integral',( WishScore * StartNum), 1}),
									  do_start(PlayerId,DesireInfo,PlayerInfo,2);
								  {fail, Reason} ->
									  lib_send:send_prompt_msg(PlayerId, Reason)
							  end;
						  _ ->
							  case player:has_enough_integral(player:get_PS(PlayerId), IntegralCount) of
								  true ->
									  player:cost_integral(player:get_PS(PlayerId), IntegralCount, ["lib_luck","start_luck"]),
									  WishScore = data_special_config:get(wish_score),
									  gen_server:cast(mod_global_collection, {'set_desire_integral',( WishScore * StartNum), 1}),
									  do_start(PlayerId,DesireInfo,PlayerInfo,2);
								  false -> lib_send:send_prompt_msg(PlayerId, ?PM_INTEGRAL_LIMIT)
							  end
					  end
			 end;
		 _ -> skip
	 end.


check_optional(PlayerId,Type) ->
	case Type of
		1 ->
			NeedCost = data_special_config:get(optional_draw_one_cost),
			case player:has_enough_integral(player:get_PS(PlayerId), NeedCost) of
				true ->
					player:cost_integral(player:get_PS(PlayerId), NeedCost, ["lib_luck","optional"]),
					do_start_optional(PlayerId,Type);
				false -> lib_send:send_prompt_msg(PlayerId, ?PM_INTEGRAL_LIMIT)
			end;
		2 ->
			NeedCost = data_special_config:get(optional_draw_ten_cost),
			case player:has_enough_integral(player:get_PS(PlayerId), NeedCost) of
				true ->
					player:cost_integral(player:get_PS(PlayerId), NeedCost, ["lib_luck","optional"]),
					do_start_optional(PlayerId,Type);
				false -> lib_send:send_prompt_msg(PlayerId, ?PM_INTEGRAL_LIMIT)
			end

	end.

do_start_optional(PlayerId,Type) ->
	%默认玩家转盘有物品
	[Op] = ets:lookup(ets_player_optional_reward,PlayerId),
	case Type of
		1 ->
			Range = Op#player_optional_data.total_rate,
			DataList = Op#player_optional_data.optional_list,
			RandNum = util:rand(1, Range),
			OpNo = decide_reward_no_by_prob2(DataList,RandNum,0),
			OpData = data_optional_turntable:get(OpNo),
			Notice = OpData#optional_turntable.notice,
			[{DrawGoodsNo,DrawCount,BinState,DrawQuality}]=OpData#optional_turntable.reward,
			{ok, Bin} =pt_54:write(?PT_START_AWARD_OPTIONAL, [OpNo]),
			lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
			case Notice of
				0 ->
					skip;
				_ ->
					mod_broadcast:send_sys_broadcast(Notice, [player:get_name(PlayerId),
						PlayerId, DrawGoodsNo, DrawQuality, DrawCount,BinState])
			end,
			mod_inv:batch_smart_add_new_goods(PlayerId, [{DrawGoodsNo,DrawCount}], [{bind_state, BinState},{quality, DrawQuality}], ["lib_luck", "get_optional"]);
		2 ->
			F = fun(_NoUse , Acc) ->
				Range = Op#player_optional_data.total_rate,
				DataList = Op#player_optional_data.optional_list,
				RandNum = util:rand(1, Range),
				OpNo = decide_reward_no_by_prob2(DataList,RandNum,0),
				OpData = data_optional_turntable:get(OpNo),
				Notice = OpData#optional_turntable.notice,
				[{DrawGoodsNo,DrawCount,BinState,DrawQuality}]=OpData#optional_turntable.reward,
				case Notice of
					0 ->
						skip;
					_ ->
						mod_broadcast:send_sys_broadcast(Notice, [player:get_name(PlayerId),
							PlayerId, DrawGoodsNo, DrawQuality, DrawCount,BinState])
				end,
				[OpNo|Acc]
				end,
			NotifyDataList = lists:foldl(F, [], lists:seq(1, 10)),

			{ok, Bin} =pt_54:write(?PT_START_AWARD_OPTIONAL, NotifyDataList),
			lib_send:send_to_sock(player:get_PS(PlayerId), Bin),

			F2 = fun(X) ->
				OpData2 = data_optional_turntable:get(X),
				[{DrawGoodsNo2,DrawCount2,BinState2,DrawQuality2}]=OpData2#optional_turntable.reward,
				mod_inv:batch_smart_add_new_goods(PlayerId, [{DrawGoodsNo2,DrawCount2}], [{bind_state, BinState2},{quality, DrawQuality2}], ["lib_luck", "get_optional"])
				 end,

			lists:foreach(F2,NotifyDataList)

	end.
							   
			  


do_start(PlayerId,LotteryInfo,PlayerInfo,StartType) ->
	%先算出总权重
	RangeList = case  StartType of
					1 ->
						data_xunbao_xuyuanchi_draw:get_xunbao_no();
					2 ->
						data_xunbao_xuyuanchi_draw:get_xuyuanchi_no()
				end,
	F = fun(X,Acc) ->
				DrawRecord = data_xunbao_xuyuanchi_draw:get(X),
				Acc + DrawRecord#xunbao_xuyuanchi_draw.prob
		end,
	Range = lists:foldl(F, 0, RangeList),
	
	F2 = fun(X,Acc2) ->
				 DrawRecord = data_xunbao_xuyuanchi_draw:get(X),
				 
				 [{DrawRecord#xunbao_xuyuanchi_draw.reward, DrawRecord#xunbao_xuyuanchi_draw.prob, DrawRecord#xunbao_xuyuanchi_draw.goods_type, X} |Acc2]
		 end,
	RewardPool = lists:foldl(F2, [], RangeList),
	
	F2_0 = fun(X,Acc) ->
				DrawRecord = data_xunbao_xuyuanchi_draw:get(X),
				case DrawRecord#xunbao_xuyuanchi_draw.goods_type > 2 of
					true ->
						Acc + DrawRecord#xunbao_xuyuanchi_draw.prob;
					false ->
						Acc
				end
				
		end,
	Range2 = lists:foldl(F2_0, 0, RangeList),
	
	F2_1 = fun(X,Acc) ->
				 DrawRecord = data_xunbao_xuyuanchi_draw:get(X),
				 case DrawRecord#xunbao_xuyuanchi_draw.goods_type > 2 of
					 true ->
						  [{DrawRecord#xunbao_xuyuanchi_draw.reward, DrawRecord#xunbao_xuyuanchi_draw.prob, DrawRecord#xunbao_xuyuanchi_draw.goods_type, X} |Acc];
					 false ->
						 Acc
				 end
		 end,
	%寻宝幸运值满一百获取的物品
	RewardPool2 = lists:foldl(F2_1, [], RangeList),
%%	io:format("Range=~p,RewardPool=~p,Range2=~p,RewardPool2=~p~n",[Range,RewardPool,Range2,RewardPool2]),
%%	io:format("sssssssssssssssssssssssssssss=~p~n",[util:rand(1, 10)]),
	Times = LotteryInfo#xunbao_xuyuanchi_cost.num,
	F3 = fun(_,Acc3) ->
				 [PlayerInfo0] = ets:lookup(ets_luck_player_info, PlayerId),
				 case PlayerInfo0#luck_player_info.treasure_value + Times > data_special_config:get(lucky_value) andalso StartType == 1  of
					 true ->
						 io:format("wujianchengRange ~p~n", [Range2]),
						 RandNum = util:rand(1, Range2),
						 {GoodsList, ProType, Index} = decide_reward_no_by_prob(RewardPool2, RandNum),
						 [{DrawGoodsNo,DrawCount,DrawQuality,DrawBindState}] = GoodsList,
						 case ProType =:= 4 of
							 true ->
								 case ets:lookup(ets_lottery_record, 1) of
									 [] ->
										 ets:insert(ets_lottery_record, {1,[ {player:get_name(PlayerId), DrawGoodsNo,DrawCount,DrawQuality} ] });
									 [HistoryR] ->
										 ets:insert(ets_lottery_record,HistoryR#ets_lottery_history{lottery_history = [{player:get_name(PlayerId), DrawGoodsNo,DrawCount,DrawQuality}|HistoryR#ets_lottery_history.lottery_history]})
								 end;
							 false -> skip
						 end,
						 PlayerInfo2_0 = PlayerInfo#luck_player_info{treasure_value =(PlayerInfo#luck_player_info.treasure_value + Times -data_special_config:get(lucky_value)-1),
													  treasure_weekly_value = (PlayerInfo#luck_player_info.treasure_weekly_value + Times)},
						 
						 ets:insert(ets_luck_player_info, PlayerInfo2_0),
						 
						
						 BroadDrawInfo = data_xunbao_xuyuanchi_draw:get(Index),
						 Notice = BroadDrawInfo#xunbao_xuyuanchi_draw.notice,
						 case Notice == 0 of
							 true ->
								 skip;
							 false ->
								  mod_broadcast:send_sys_broadcast(Notice, [player:get_name(PlayerId),
																			PlayerId, DrawGoodsNo, DrawQuality, DrawCount,0])
						 end,
						 mod_inv:batch_smart_add_new_goods(PlayerId, [{DrawGoodsNo,DrawCount}], [{bind_state, DrawBindState},{quality, DrawQuality}], ["lib_luck", "get_luck"]),
						 [{Index,{player:get_name(PlayerId), DrawGoodsNo,DrawCount,ProType}}|Acc3];
					 false ->
%% 						 get('auto_use_goods') ->
%%                       		[{89127,2},{89128,5},{89129,8},{89130,12}]
						 
						 RandNum = util:rand(1, Range),
						 {GoodsList, ProType, Index} = decide_reward_no_by_prob(RewardPool, RandNum),
						 [{DrawGoodsNo,DrawCount,DrawQuality,DrawBindState}] = GoodsList,
						 case ProType =:= 4 andalso StartType == 1 of
							 true ->
								 case ets:lookup(ets_lottery_record, 1) of
									 [] ->
										  ets:insert(ets_lottery_record, #ets_lottery_history{type = 1,lottery_history = [{player:get_name(PlayerId), DrawGoodsNo,DrawCount,DrawQuality}] });
									 [HistoryR] ->
										 ets:insert(ets_lottery_record,HistoryR#ets_lottery_history{lottery_history = [{player:get_name(PlayerId), DrawGoodsNo,DrawCount,DrawQuality}|HistoryR#ets_lottery_history.lottery_history]})
								 end;
							 false -> 
								  case ProType =:= 4 of
									  true ->
										  case ets:lookup(ets_lottery_record, 2) of
											  [] ->
												  ets:insert(ets_lottery_record, #ets_lottery_history{type = 2,lottery_history = [{player:get_name(PlayerId), DrawGoodsNo,DrawCount,DrawQuality}] });
											  [HistoryR] ->
												  ets:insert(ets_lottery_record,HistoryR#ets_lottery_history{lottery_history = [{player:get_name(PlayerId), DrawGoodsNo,DrawCount,DrawQuality}|HistoryR#ets_lottery_history.lottery_history]})
										  end;
									  false ->
										  skip
								  end
						 end,
						 
						 IntegralRewards = data_special_config:get('auto_use_goods'),
						 BroadDrawInfo = data_xunbao_xuyuanchi_draw:get(Index),
						 Notice = BroadDrawInfo#xunbao_xuyuanchi_draw.notice,
						 case Notice == 0 of
							 true ->
								 skip;
							 false ->
								 mod_broadcast:send_sys_broadcast(Notice, [player:get_name(PlayerId),
																			PlayerId, DrawGoodsNo, DrawQuality, DrawCount,0])
						 end,
						 case lists:keyfind(DrawGoodsNo, 1, IntegralRewards) of
							 false ->
								 mod_inv:batch_smart_add_new_goods(PlayerId, [{DrawGoodsNo,DrawCount}], [{bind_state, DrawBindState},{quality, DrawQuality}], ["lib_luck", "get_luck"]);
							 {_, IntegralPro} ->
								 [{_,PoolCount}] = ets:lookup(ets_desire_integral_pool, desire_integral) ,
								 GetIntegral = util:ceil(PoolCount * (IntegralPro/100)),
								 gen_server:call(mod_global_collection, {'set_desire_integral', GetIntegral, 2}),
								 player:add_integral(player:get_PS(PlayerId), GetIntegral, ["lib_luck:desireIntegral"])
						 end,
						  [{Index,{player:get_name(PlayerId), DrawGoodsNo,DrawCount,ProType}}|Acc3]
								 
				 end
		 end,
	RawardIndex = lists:foldl(F3, [], lists:seq(1, Times)),
	
	PlayerInfo2 = case PlayerInfo#luck_player_info.treasure_value + Times > data_special_config:get(lucky_value) andalso StartType == 1   of
					  true ->
						   [PlayerInfo3] = ets:lookup(ets_luck_player_info, PlayerId),
						   PlayerInfo3;
					  false ->
						  case  StartType == 1  of
							  true ->
								  PlayerInfo#luck_player_info{treasure_value =(PlayerInfo#luck_player_info.treasure_value + Times),
															  treasure_weekly_value = (PlayerInfo#luck_player_info.treasure_weekly_value + Times)};
							  false ->
								   PlayerInfo#luck_player_info{desire_value =(PlayerInfo#luck_player_info.desire_value + Times)}
						  end
				  end,
	ets:insert(ets_luck_player_info, PlayerInfo2),
	
	%更新到数据库中
	db:update(luckdraw, [{treasure_value, PlayerInfo2#luck_player_info.treasure_value}, 
						 {treasure_weekly_value, PlayerInfo2#luck_player_info.treasure_weekly_value},
						 {desire_value, PlayerInfo2#luck_player_info.desire_value}], [{player_id, PlayerId}]),
	%推送协议给前端
	{ok, BinData} =
		case StartType == 1  of
			true ->
				pt_54:write(54001, [RawardIndex, PlayerInfo2#luck_player_info.treasure_value, PlayerInfo2#luck_player_info.treasure_weekly_value]);
			false ->
				[{_,IntegralPoolVar}] = ets:lookup(ets_desire_integral_pool, desire_integral),
				pt_54:write(54012, [RawardIndex, IntegralPoolVar, PlayerInfo2#luck_player_info.desire_value])
		end,
	lib_send:send_to_sock(player:get_PS(PlayerId), BinData),
	%推送寻宝记录给所有打开页面的玩家
	case ets:lookup(ets_open_interface, StartType) of
		[] ->
			skip;
		[{_,OpenPlayerList}]  ->
			F4 = fun(X4) ->
						 F5 = fun({_,NeedHistory},Acc5) ->
									  [NeedHistory|Acc5]
							  end,
						 OpenHistory = lists:foldl(F5, [], RawardIndex),
						 {ok, BinData4} =case StartType == 1 of
											 true ->
												 pt_54:write(54005, [OpenHistory]);
											 false ->
												 pt_54:write(54011, [OpenHistory])
										 end,
						 lib_send:send_to_sock(player:get_PS(X4), BinData4)
				 end,
			lists:foreach(F4, OpenPlayerList)
	end.

decide_reward_no_by_prob(Pool, RandNum) ->

	io:format("wujianchengluck ~p~n", [{?LINE ,Pool}]),
    decide_reward_no_by_prob(Pool, RandNum, 0).

decide_reward_no_by_prob([H | T], RandNum, SumToCompare) ->
	io:format("wujianchengluck ~p~n", [{?LINE ,H}]),
    SumToCompare_2 = element(2, H) + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true ->
             {element(1, H),element(3, H),element(4, H)};
        false ->
            decide_reward_no_by_prob(T, RandNum, SumToCompare_2)
    end;
decide_reward_no_by_prob([], _RandNum, _) ->
    ?ASSERT(false),
    [].

%prob , No
decide_reward_no_by_prob2([H | T], RandNum, SumToCompare) ->
	io:format("wujianchengluck ~p~n", [{?LINE ,H}]),
	SumToCompare_2 = element(1, H) + SumToCompare,
	case RandNum =< SumToCompare_2 of
		true ->
			element(2, H);
		false ->
			decide_reward_no_by_prob2(T, RandNum, SumToCompare_2)
	end;
decide_reward_no_by_prob2([], _RandNum, _) ->
	?ASSERT(false),
	[].

%寻宝幸运值满一百获取的物品
%%		flag 					u8   		1：领取成功，0：领取失败
%%  	Total_integral      	u32     	奖池总积分
%%		Total_amount      		u16      	玩家当前抽取次数	
take_xuyuanchi_extra_reward(PlayerId, No) ->
	[PlayerInfo] = ets:lookup(ets_luck_player_info, PlayerId),
	DesireValue = PlayerInfo#luck_player_info.desire_value,
	XuyuanchiExtraInfo = data_xuyuanchi_extra_reward:get(No),
	XuyuanNum = XuyuanchiExtraInfo#xuyuanchi_extra_reward.xuyuan_num,
	case  DesireValue > XuyuanNum - 1 of
		true ->
			HaveDesire = PlayerInfo#luck_player_info.have_desire,
			case lists:keymember(XuyuanNum, 2, HaveDesire) of
				true ->
					lib_send:send_prompt_msg(PlayerId, ?PM_AD_REPEAT_GET);
				false ->
					GoodsList = XuyuanchiExtraInfo#xuyuanchi_extra_reward.reward,
					Fun = fun(X) ->
							{GoodsNo,Count,Quality,BindState} = X,
							mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo,Count}], [{bind_state, BindState},{quality, Quality}], ["lib_luck", "get_xuyuan_extra"])
						  end,
					lists:foreach(Fun, GoodsList),
					[{desire_integral,Value}] = ets:lookup(ets_desire_integral_pool, desire_integral),
					%% 判断个人许愿值已满
					case erlang:length(HaveDesire) >= 4 andalso DesireValue >= data_special_config:get('wish_num') of
						true ->
							ets:insert(ets_luck_player_info, PlayerInfo#luck_player_info{desire_value = (DesireValue - data_special_config:get('wish_num')), have_desire = []}),
							db:update(luckdraw, [{desire_value, DesireValue - data_special_config:get('wish_num')}, {have_desire, util:term_to_bitstring([])}], [{player_id, PlayerId}]),
							{ok,Bin} = pt_54:write(54013, [1,Value,DesireValue - data_special_config:get('wish_num'),[]]),
							lib_send:send_to_uid(PlayerId, Bin);
						false ->
							ets:insert(ets_luck_player_info, PlayerInfo#luck_player_info{have_desire = [{No,XuyuanNum}|HaveDesire]}),
							db:update(luckdraw, [{have_desire, util:term_to_bitstring([{No,XuyuanNum}|HaveDesire])}], [{player_id, PlayerId}]),
							{ok,Bin} = pt_54:write(54013, [1,Value,DesireValue,[{No,XuyuanNum}|HaveDesire]]),
							lib_send:send_to_uid(PlayerId, Bin)
					end
			end;
		false ->
			lib_send:send_prompt_msg(PlayerId, ?PM_GET_HUNTING_WEEKLY)
	end.
	 

receive_weekly_reward(PlayerId, Position) ->
	[PlayerInfo] = ets:lookup(ets_luck_player_info, PlayerId),
	ReceiveWeeklyList = PlayerInfo#luck_player_info.have_treasure_weekly,
	case lists:member(Position, ReceiveWeeklyList) of
		true -> 
			lib_send:send_prompt_msg(PlayerId, ?PM_AD_REPEAT_GET);
		false ->
			
            ExtraReward = data_xunbao_extra_reward:get(Position),
			case PlayerInfo#luck_player_info.treasure_weekly_value >=  ExtraReward#xunbao_extra_reward.num of
				true ->
					Rewardpkg   = data_reward_pkg:get(ExtraReward#xunbao_extra_reward.reward),
					PkgGoods    = Rewardpkg#reward_pkg.goods_list,
					Fun2 = fun({_Q, RewardNo, Count, _, _ },Acc4) ->
								   [{RewardNo,Count}|Acc4]
						   end,
					GoodsList = lists:foldl(Fun2, [], PkgGoods),
					case mod_inv:check_batch_add_goods(PlayerId, GoodsList) of
						{fail, _Reason} ->
							lib_send:send_prompt_msg(PlayerId, ?PM_US_BAG_FULL);
						_ ->
							ets:insert(ets_luck_player_info, PlayerInfo#luck_player_info{ have_treasure_weekly = [Position|ReceiveWeeklyList] }),
							db:update(luckdraw, [{have_treasure_weekly, util:term_to_bitstring([Position|ReceiveWeeklyList])}],[{player_id, PlayerId}] ),
							mod_inv:batch_smart_add_new_goods(PlayerId, GoodsList, [{bind_state, 1}], ["lib_luck", "get_week_reward"]),
							%发送前端协议
							ReceiveWeeklyList2 = [Position|ReceiveWeeklyList],
							{ok, Bin} = pt_54:write(54002, [ReceiveWeeklyList2]),
							lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
					
					end;
				false ->
					lib_send:send_prompt_msg(PlayerId, ?PM_GET_HUNTING_WEEKLY)
			end
					
	
	end.

close_hunting_interface(PlayerId,Type) ->
	case ets:lookup(ets_open_interface, Type) of
		[] ->
			skip;
		[{_,OpenPlayerList}]  ->
			PlayerList = lists:delete(PlayerId, OpenPlayerList),
			ets:insert(ets_open_interface, {Type,PlayerList})
	end.

%% [[1000100000000334,10,31,10,<<"[]">>],
%%  [1010800000000442,70,0,676,<<"[5,4,3,2,1]">>],
%%  [1010800000000443,55,0,1166,<<"[3,4,5,2,1]">>],
%%  [1010800000000633,0,104,0,<<"[]">>],
%%  [1010800000000657,0,109,0,<<"[]">>],
%%  [1010800000000658,0,20,0,<<"[]">>],
%%  [1010800000000660,0,62,0,<<"[]">>],
%%  [1010800000000661,0,10,0,<<"[]">>]] [{luck_player_info,1010800000000660,0,62,0,[]}]
weekly_clear_hunting() ->
	case db:select_all(luckdraw , "player_id, treasure_value, desire_value,treasure_weekly_value, have_treasure_weekly, have_desire",[]) of
		List when is_list(List) ->
			Fun = fun(X) ->
						  [PlayerId,TreasureValue, DesireValue,TreasureWeeklyValue, HaveTreasureWeekly, HaveDesire] = X,
						  case ets:lookup(ets_luck_player_info, PlayerId) of
							  [] -> 
								  ets:insert(ets_luck_player_info, #luck_player_info{  player_id = PlayerId
																					   ,treasure_value = TreasureValue
																					   ,desire_value = DesireValue
																					   ,treasure_weekly_value = TreasureWeeklyValue
																					   ,have_treasure_weekly = util:bitstring_to_term(HaveTreasureWeekly)
									  												   ,have_desire = util:bitstring_to_term(HaveDesire)});
							  _ ->
								  skip
						  end
				  end,
			lists:foreach(Fun, List),
			
			case ets:tab2list(ets_luck_player_info) of
				[] ->
					ojbk;
				LuckPlayerInfos ->
					Fun2 = fun(PlayerInfo) ->
								   ets:insert(ets_luck_player_info, PlayerInfo#luck_player_info{treasure_weekly_value = 0,have_treasure_weekly = []}),
								   db:update(luckdraw, [{treasure_weekly_value,0},{have_treasure_weekly,util:term_to_bitstring([])}], [{player_id, PlayerInfo#luck_player_info.player_id}])
						   end,
					
					lists:foreach(Fun2, LuckPlayerInfos)
			end;
		
		Err ->
			?ERROR_MSG("lib_luck:week_refresh: ~p~n",[{?MODULE,?LINE,Err}])
	end.

%GM权限，刷新周奖励，刷新积分池
refresh_luck(PlayerId,Type) ->
	%1带便刷新周奖励， 2代表刷新积分池
    case Type  of
		1 ->
			[PlayerInfo] = ets:lookup(ets_luck_player_info, PlayerId),
			ets:insert(ets_luck_player_info, PlayerInfo#luck_player_info{ have_treasure_weekly = [], treasure_weekly_value = 0}),
							db:update(luckdraw, [{have_treasure_weekly, util:term_to_bitstring([])}, {treasure_weekly_value , 0}],[{player_id, PlayerId}] );
		2 ->
			db:update(global_sys_var, [{var, 0}], [{sys, 1005}]),
			ets:insert(ets_desire_integral_pool, {desire_integral, 0 })
	end.

%%打开大富翁界面
open_face(PlayerId) ->
	Misc_Status = ply_misc:get_player_misc(PlayerId),
	NowTime = Misc_Status#player_misc.monopoly_reset_time,
	case util:is_same_day(NowTime) of
		true ->
			[FreeTimes,CostTimes]= Misc_Status#player_misc.monopoly,
			io:format("This is the save day"),
			{ok, Bin} =pt_54:write(54101, [ FreeTimes , CostTimes]),
			lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
		false ->
			New_misc = Misc_Status#player_misc{monopoly = [2,5], monopoly_reset_time = util:unixtime()},
			ply_misc:update_player_misc(New_misc),
			io:format("This is the different day"),
			{ok, Bin} =pt_54:write(54101, [ 2 , 5]),
			lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
	end.

%%点击进入游戏
enter_game(PlayerId) ->
	case ets:lookup(ets_rich_map_record, PlayerId) of
		[] ->
			Misc_Status = ply_misc:get_player_misc(PlayerId),
			[FreeTimes,CostTimes]= Misc_Status#player_misc.monopoly,
			case FreeTimes of
				0 ->
					io:format("dan ren mian fei ci shu buzu"),
					{ok, Bin} =pt_54:write(54103, []),
					lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
				_ ->
					io:format("dan ren enter game"),
					TableList = get_rich_table(),
					ets:insert(ets_rich_map_record, #rich_map_record{  player_id = PlayerId
						,is_use = 1,position = 0, is_get=0, table = TableList}),

					%正在玩游戏玩家添加
					case ets:lookup(ets_rich_player,rich_player) of
						[] ->
							ets:insert(ets_rich_player, {rich_player, [PlayerId] });
						[{rich_player,RichPlayer}] ->
							RichPlayer1 = lists:delete(PlayerId,RichPlayer),
							RichPlayer2 = [PlayerId|RichPlayer1],
							ets:insert(ets_rich_player, {rich_player, RichPlayer2 })
					end,
					New_misc = Misc_Status#player_misc{monopoly = [FreeTimes-1,CostTimes]},
					ply_misc:update_player_misc(New_misc),

					{ok, Bin} =pt_54:write(54102, [TableList , 1]),
					lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
			end;
		[MapRecord] ->
			case MapRecord#rich_map_record.position of
				33 ->
					ets:delete(ets_rich_map_record,PlayerId),
					Misc_Status = ply_misc:get_player_misc(PlayerId),
					[FreeTimes,CostTimes]= Misc_Status#player_misc.monopoly,
					case FreeTimes of
						0 ->
							io:format("dan ren mian fei ci shu buzu"),
							{ok, Bin} =pt_54:write(54103, []),
							lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
						_ ->
							io:format("dan ren enter game"),
							TableList = get_rich_table(),
							ets:insert(ets_rich_map_record, #rich_map_record{  player_id = PlayerId
								,is_use = 1,position = 0, is_get=0, table = TableList}),

							%正在玩游戏玩家添加
							case ets:lookup(ets_rich_player,rich_player) of
								[] ->
									ets:insert(ets_rich_player, {rich_player, [PlayerId] });
								[{rich_player,RichPlayer}] ->
									RichPlayer1 = lists:delete(PlayerId,RichPlayer),
									RichPlayer2 = [PlayerId|RichPlayer1],
									ets:insert(ets_rich_player, {rich_player, RichPlayer2 })
							end,
							New_misc = Misc_Status#player_misc{monopoly = [FreeTimes-1,CostTimes]},
							ply_misc:update_player_misc(New_misc),

							{ok, Bin} =pt_54:write(54102, [TableList , 1]),
							lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
					end;
				_  ->
					TableList2 = MapRecord#rich_map_record.table,
					Position = MapRecord#rich_map_record.position + 1,
					{ok, Bin} =pt_54:write(54102, [TableList2 , Position]),
					lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
			end
	end.

%免费次数不足 玩家选择Type 1.使用水玉 2.不使用
free_time_no_enough(PlayerId ,Type) ->
%%	PlayerId = 1000100000000759,
	PS = player:get_PS(PlayerId),
	Name = player:get_name(PlayerId),

	case Type of
		1 ->
			Misc_Status = ply_misc:get_player_misc(PlayerId),
			[FreeTimes,CostTimes]= Misc_Status#player_misc.monopoly,
			case CostTimes > 0 of
				true ->
					case player:has_enough_money(PS,?MNY_T_INTEGRAL,data_special_config:get('monopoly_ticket')) of
						true ->
							TableList = get_rich_table(),
							ets:insert(ets_rich_map_record, #rich_map_record{  player_id = PlayerId
								,is_use = 1,position = 0, is_get=0,table = TableList}),

							player:cost_integral(player:get_PS(PlayerId), data_special_config:get('monopoly_ticket'), ["lib_luck","enter_rich_game"]),
							New_misc = Misc_Status#player_misc{monopoly = [FreeTimes,CostTimes-1]},
							ply_misc:update_player_misc(New_misc),
							%正在玩游戏玩家添加
							case ets:lookup(ets_rich_player,rich_player) of
								[] ->
									ets:insert(ets_rich_player, {rich_player, [PlayerId] });
								[{rich_player,RichPlayer}] ->
									RichPlayer1 = lists:delete(PlayerId,RichPlayer),
									RichPlayer2 = [PlayerId|RichPlayer1],
									ets:insert(ets_rich_player, {rich_player, RichPlayer2 })
							end,
							{ok, Bin} =pt_54:write(54102, [TableList , 1]),
							lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
							io:format("one person enter game");
						false ->
							{ok, Bin} =pt_54:write(54104, [ 2 , Name]),
							lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
							io:format("not enougn yuanbao")
					end;
				false ->
					io:format("total num enough"),
					{ok, Bin} =pt_54:write(54104, [ 1 , Name]),
					lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
			end;
		2 ->
			io:format("refuse use yuanbao"),
			{ok, Bin} =pt_54:write(54104, [ 1 , Name]),
			lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
	end.

%$%队长抛骰子 PS Type
team_leader_dice(PlayerId,Type)->
	PS = player:get_PS(PlayerId),
	Name = player:get_name(PlayerId),
	%%防止到达终点报错
	MapRecord = case ets:lookup(ets_rich_map_record, PlayerId) of
					[] ->
						[];
					[Map] ->
						Map
				end,
	case MapRecord of
		[] ->
			skip;
		_  ->
			case Type of
				0 ->
					RandNum = util:rand(1,6),
					io:format("RandNum-------------------------------------~p~n",[RandNum]),
					io:format("MapRecord==========~p~n",[MapRecord]),
					Position = case (MapRecord#rich_map_record.position + RandNum) > 31 of
								   true ->
									   33;
								   false ->
									   MapRecord#rich_map_record.position +RandNum
							   end,
					ets:insert(ets_rich_map_record,MapRecord#rich_map_record{position=Position, is_use = 1,is_get=0}),
					{ok, Bin} =pt_54:write(54105, [ RandNum , Position+1]),
					lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
				_ ->
					Position2 = case (MapRecord#rich_map_record.position + Type) > 31 of
									true ->
										33;
									false ->
										MapRecord#rich_map_record.position +Type
								end,
					case MapRecord#rich_map_record.is_use of
						2 ->
							ets:insert(ets_rich_map_record,MapRecord#rich_map_record{position=Position2, is_use = 1,is_get=0}),
							{ok, Bin} =pt_54:write(54105, [ Type , Position2+1]),
							lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
						1 ->
							case player:has_enough_money(PS,?MNY_T_INTEGRAL,data_special_config:get('monopoly_dice_price')) of
								true ->
									player:cost_integral(player:get_PS(PlayerId), data_special_config:get('monopoly_dice_price'), ["lib_luck","play_rich_game"]),
									io:format("Type-------------------------------------~p~n",[Type]),
									io:format("MapRecord==========~p~n",[MapRecord]),
									ets:insert(ets_rich_map_record,MapRecord#rich_map_record{position=Position2,is_use = 1,is_get=0}),

									{ok, Bin} =pt_54:write(54105, [ Type , Position2+1]),
									lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
								false ->
									io:format("dsadasdasd---------------"),
									{ok, Bin} =pt_54:write(54104, [ 2 , Name]),
									lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
							end;
						0 ->
							lib_send:send_prompt_msg(PlayerId, ?PM_GET_HUNTING_WEEKLY)
					end
			end
	end.

%%玩家走到某个格子
stand_on_chess(PlayerId,Type) ->
	PS = player:get_PS(PlayerId),
	[MapRecord] = ets:lookup(ets_rich_map_record, PlayerId),
	%%防止玩家重复领取奖励
	case MapRecord#rich_map_record.is_get of
		0 ->
			%%判断是否获得最终奖励
			case MapRecord#rich_map_record.position of
				33 ->
					Endreward = data_monopoly_endreward:get(1),
					mod_inv:batch_smart_add_new_goods(PlayerId, [{Endreward#monopoly_endreward.reward,1}], [{bind_state, 1}], ["lib_luck", "get_rich_endreward"]),
					{ok, Bin} =pt_54:write(54108, [ Endreward#monopoly_endreward.reward , 1]),
					lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
					ets:delete(ets_rich_map_record,PlayerId),
					%%删除退出玩家
					[{rich_player,RichPlayer}] = ets:lookup(ets_rich_player,rich_player),
					RichPlayer1 = lists:delete(PlayerId,RichPlayer),
					ets:insert(ets_rich_player, {rich_player, RichPlayer1 }),
					io:format("Endraer = ~p~n",[Endreward#monopoly_endreward.reward]),
					io:format("------------Test=~p---------------~n",[Endreward]);
				_ ->
					TableList = MapRecord#rich_map_record.table,
					Position = MapRecord#rich_map_record.position,
					GoodsNum = lists:nth(Position,TableList),
					case GoodsNum of
						0 ->
							RandNum = util:rand(1,6),
							Event = data_monopoly_event:get(RandNum),
							EventType = lists:nth(1,Event#monopoly_event.event),
							case EventType of
								nocontrol ->
									ets:insert(ets_rich_map_record,MapRecord#rich_map_record{is_use = 0,is_get=1}),
									{ok, Bin} =pt_54:write(54106, [ 1 ]),
									lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
								freecontrol ->
									ets:insert(ets_rich_map_record,MapRecord#rich_map_record{is_use = 2,is_get=1}),
									{ok, Bin} =pt_54:write(54106, [ 2 ]),
									lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
								battle ->
									ets:insert(ets_rich_map_record,MapRecord#rich_map_record{is_get=1}),
									EventNum = lists:nth(2,lists:nth(2,Event#monopoly_event.event)),
									Fun = fun mod_guild_dungeon:handle_fight_callback/2,
									mod_battle:start_mf(PS, EventNum, Fun),
									io:format("go to fight")
							end;
						_ ->
							GoodsInfo = data_monopoly_reward:get(GoodsNum),
							Num = util:rand(lists:nth(1,GoodsInfo#monopoly_reward.number),lists:nth(2,GoodsInfo#monopoly_reward.number)),
							mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNum,Num}], [{bind_state, 1}], ["lib_luck", "get_rich_reward"]),
							ets:insert(ets_rich_map_record,MapRecord#rich_map_record{is_get=1}),
							{ok, Bin} =pt_54:write(54108, [ GoodsNum , Num]),
							lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
							io:format("TableList==~p~n,GoodsNum=~p,GoodsInfo=~p,Num=~p~n",[TableList,GoodsNum,GoodsInfo,Num])
					end
			end;
		1 ->
			lib_send:send_prompt_msg(PlayerId, ?PM_AD_REPEAT_GET)
	end.


rich_info_reset() ->
	RichRecords = ets:tab2list(?ETS_PLAYER_MISC),
	ResetTime = util:unixtime(),
	F = fun(Misc_Status) ->
		New_misc = Misc_Status#player_misc{monopoly = [2,5], monopoly_reset_time = ResetTime},
		ply_misc:update_player_misc(New_misc)
		end,
	lists:foreach(F,RichRecords).

%%获取骰子地图的格子列表
get_rich_table() ->
	%配置不同类型物品的算法
	MonopolyNo = data_monopoly:get_monopoly_no(),
	F = fun(X,Acc) ->
			Monopoly = data_monopoly:get(X),
			MonopolyPro = Monopoly#monopoly.probability,
			Acc + lists:nth(1,MonopolyPro)
		end,
	Num = lists:foldl(F, 0, MonopolyNo),

	ShuffleNum = 31 -Num,

	F2 = fun(X,Acc) ->
			Monopoly = data_monopoly:get(X),
			MonopolyPro = Monopoly#monopoly.probability,
			lists:duplicate((lists:nth(2,MonopolyPro)-lists:nth(1,MonopolyPro)),Monopoly#monopoly.type) ++ Acc
		 end,
	ShuffleList = lists:sublist(shuffle(lists:foldl(F2, [], MonopolyNo)),ShuffleNum),

	F3 = fun(X,Acc) ->
			Monopoly = data_monopoly:get(X),
			MonopolyPro = Monopoly#monopoly.probability,
			[{Monopoly#monopoly.type,lists:nth(1,MonopolyPro)}|Acc]
		 end,
	SectionTable = lists:reverse(lists:foldl(F3, [], MonopolyNo)),

	%%获取不同类型物品的总次数
	TotalTable = decide_lattice_number(SectionTable,ShuffleList,ShuffleNum),
	io:format("TotalTable===~p~n",[TotalTable]),
	F4 = fun(X,Acc) ->
			Reward = data_monopoly_reward:get(X),
			Probability = Reward#monopoly_reward.probability,
			lists:duplicate(lists:nth(2,Probability),Reward#monopoly_reward.no) ++ Acc
		 end,

	F5 = fun({Type,Num},Acc) ->
			case Type of
				1 ->
					First = data_monopoly_reward:get_first_type(),
					FirstList = lists:sublist(shuffle(lists:foldl(F4, [], First)),Num),
					FirstList ++ Acc;
				2 ->
					Second = data_monopoly_reward:get_second_type(),
					SecondList = lists:sublist(shuffle(lists:foldl(F4, [], Second)),Num),
					SecondList ++ Acc;
				3 ->
					Third = data_monopoly_reward:get_third_type(),
					ThirdList = lists:sublist(shuffle(lists:foldl(F4, [], Third)),Num),
					ThirdList ++ Acc;
				4 ->
					lists:duplicate(Num,0) ++ Acc
			end
		 end,
	TableList = shuffle(lists:foldl(F5,[],TotalTable)),
%%	io:format("ShuffleList = === ~p,SectionTable=~p,TotalTable=~p,TableList=~p,Length=~p~n",[ShuffleList,SectionTable,TotalTable,TableList,erlang:length(TableList)]),

	TableList.

%%获取大富翁不同类型格子的数量
decide_lattice_number(SectionTable,ShuffleList,Num) ->
	decide_lattice_number(SectionTable,ShuffleList,Num,1).

decide_lattice_number(SectionTable,ShuffleList,Num,Total) ->
	case Total > Num of
		false ->
			[{Type1,One},{Type2,Two},{Type3,Three},{Type4,Four}] = SectionTable,
			case lists:nth(Total,ShuffleList) of
				1 ->
					SectionTable1 = [{Type1,One+1},{Type2,Two},{Type3,Three},{Type4,Four}];
				2 ->
					SectionTable1 = [{Type1,One},{Type2,Two+1},{Type3,Three},{Type4,Four}];
				3 ->
					SectionTable1 = [{Type1,One},{Type2,Two},{Type3,Three+1},{Type4,Four}];
				4 ->
					SectionTable1 = [{Type1,One},{Type2,Two},{Type3,Three},{Type4,Four+1}]
			end,

%%			io:format("2134rqwedqa=~p~n",SectionTable1),
%%			io:format("One=~p,Two=~p,Three=~p,Four=~p,ShuffleList=~p~n",[One,Two,Three,Four,lists:nth(Total,ShuffleList)]),
			decide_lattice_number(SectionTable1,ShuffleList,Num,Total+1);
		true ->
			SectionTable
	end.


%获取随机顺序的列表
shuffle(L) ->
	shuffle(L,[]).
shuffle([],L) ->
	L;
shuffle(L1,L2) ->
	Len = length(L1),
	if
		Len > 1 ->
		NL = lists:split(random:uniform(Len-1), L1),
		{[H1|T1],[H2|T2]} = NL,
		NL2 = lists:flatten([T1],[H1|T2]),
		L11 = lists:append(L2,[H2]),
		shuffle(NL2, L11);
	true ->
		shuffle([],lists:append(L2,L1))
	end.

			
	
					 
	 



