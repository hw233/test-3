%%%-------------------------------------- 
%%% @Module: pp_road
%%% @Author: wjc
%%% @Created: 2018-7-04
%%% @Description: 
%%%-------------------------------------- 


-module(pp_road).


-export([handle/3]).

-include("common.hrl"). 
-include("pt_38.hrl").
-include("prompt_msg_code.hrl").
-include("sys_code.hrl").
-include("road.hrl").
-include("ets_name.hrl").
-include("partner.hrl").
-include("offline_data.hrl").


-compile(export_all).

%% 请求总览信息
handle(?PT_GET_ROAD, PS, []) ->  %PM_NOT_JOIN_FACTION_YET 
     
	case player:get_faction(PS) > 0  of
		true ->
			case player:is_in_team(player:get_id(PS)) of
				false ->
					case mod_road:get_road_from_ets(player:get_id(PS)) of
						null ->
							case mod_road:load_road_info_from_db(player:get_id(PS)) of 
								skip -> case lib_vip:lv(PS) >= 1 of
											true -> {ok, Bin} = pt_38:write(?PT_GET_ROAD, [1,1,[]]),	
													R = #road_info{player_id =player:get_id(PS), now_point = 1, reset_times=1 , unix_time = util:unixtime(),
																   now_battle_partner = [], partner_info = [],pk_info = []  },
													mod_road:update_road_to_ets(R),
													lib_send:send_to_sock(PS, Bin),
													db:insert(road, [player_id, now_point, get_point, reset_times, unix_time,
																	 now_battle_partner,partner_info,pk_info], 
															  [player:get_id(PS), 1, util:term_to_bitstring([]), 1 , util:unixtime(),
															   util:term_to_bitstring([]), util:term_to_bitstring([]), util:term_to_bitstring([])]);
											
											false-> {ok, Bin} = pt_38:write(?PT_GET_ROAD, [1,0,[]]),
													R = #road_info{player_id =player:get_id(PS), now_point = 1, reset_times=0, unix_time = util:unixtime(),
																   now_battle_partner = [], partner_info = [],pk_info = []   },
													mod_road:update_road_to_ets(R),
													lib_send:send_to_sock(PS, Bin),
													db:insert(road, [player_id, now_point, get_point, reset_times, unix_time,
																	 now_battle_partner,partner_info,pk_info], 
															  [player:get_id(PS), 1, util:term_to_bitstring([]), 0 , util:unixtime(),
															   util:term_to_bitstring([]), util:term_to_bitstring([]), util:term_to_bitstring([])])
										end; 
								[NowPoint,ResetTimes,GetPoint,UnixTime] ->
									case util:is_same_day(UnixTime) of
										true -> {ok, Bin} =pt_38:write(?PT_GET_ROAD, [NowPoint,ResetTimes,GetPoint]),lib_send:send_to_sock(PS, Bin);
										false -> lib_road:add_time(PS)
									end	
							
							end;
						R ->
							case util:is_same_day(R#road_info.unix_time)  of
								true ->{ok, Bin} = pt_38:write(?PT_GET_ROAD, [R#road_info.now_point,R#road_info.reset_times,R#road_info.get_point]),
									   lib_send:send_to_sock(PS, Bin);
								false -> lib_road:add_time(PS)
							end
					
					end;
				true ->lib_send:send_prompt_msg(player:get_id(PS), ?PM_TASK_CAN_NO_IN_TEAM)
			end;
		false -> lib_send:send_prompt_msg(player:get_id(PS), ?PM_NOT_JOIN_FACTION_YET)
	end;

%% 战斗准备
handle(?PT_READY_BATTLE, PS, []) ->
	case (mod_road:get_road_from_ets(player:get_id(PS)))#road_info.player_power == 0 andalso ( ((mod_road:get_road_from_ets(player:get_id(PS)))#road_info.now_point == 1) orelse 
																							((mod_road:get_road_from_ets(player:get_id(PS)))#road_info.now_point == 5) orelse
																							  ((mod_road:get_road_from_ets(player:get_id(PS)))#road_info.now_point == 8)   ) of
		true -> %第一次进入取经之路
			RoadETS = mod_road:get_road_from_ets(player:get_id(PS)),
			%lib_road:init_partner_data(PS),
			PlayerPower = ply_attr:get_battle_power(PS),
			%% 			SQLFirst = lists:concat(["SELECT id,nickname,faction,lv,sex FROM player WHERE battle_power >= ",util:ceil(PlayerPower*0.8)," AND  faction > 0  AND battle_power < ",
			%% 								util:ceil(PlayerPower)," ORDER BY RAND()  LIMIT 4"  ]),
			
			% 这三个为匹配规则
            PlayerLV = player:get_lv(player:get_id(PS)) ,
			
%% 			
%% 			< RoadETS = {road_info,1000100000047122,1,[],0,undefined,undefined,0,
%%                        undefined,0,1533885048}


			FirstPK  = 
				case (RoadETS#road_info.now_point) =:= 1  of
					true ->
						case length( RoadETS#road_info.pk_info ) > 1 of
							true ->RoadETS#road_info.pk_info;
							
							false -> 
								case lib_road:get_sql_lookup_opponents_bylv(PlayerLV + 2,4,player:get_id(PS),[])  of
									[] ->
										FirstPKPlayerList0 = lib_road:get_sql_lookup_more_opponents_bylv(PlayerLV,4,player:get_id(PS),[]) , 
										case length( FirstPKPlayerList0 ) =:=4 of
											   true ->FirstPKPlayerList0;
											   false ->  lib_road:get_sql_lookup_most_opponents_bylv(PlayerLV ,4 ,player:get_id(PS),[]) 
									    end;  
											   
									FirstPKPlayerList ->
										case length(FirstPKPlayerList) =:= 4 of
											true -> FirstPKPlayerList;
											false ->FirstPKPlayerList2 =  lib_road:get_sql_lookup_more_opponents_bylv(PlayerLV ,4 ,player:get_id(PS),[]),
													case length(FirstPKPlayerList2) =:= 4 of
														true ->
															FirstPKPlayerList2;
														false ->
															lib_road:get_sql_lookup_most_opponents_bylv(PlayerLV ,4 ,player:get_id(PS),[]) 
													end
														  
										end
								end
						end;
					false -> []
				end,
			
		SecondPK  =	case (RoadETS#road_info.now_point) =:= 5 of
						true ->
							case length( RoadETS#road_info.pk_info ) > 5 of
								true ->RoadETS#road_info.pk_info;
								
								false -> 
									UpdatePar = RoadETS#road_info.pk_info,  %{PlayerId,Name,Faction,Lv,Sex,FivePartner}
									FF = fun(X,Acc) ->
												 {FFPlayerId,_FFName,_FFFaction,_FFLv,_FFSex,_FFFivePartner}  = X ,
												 [FFPlayerId|Acc]
										 end,
									UpdateList1 = lists:foldl(FF, [], UpdatePar),
								    case PlayerLV < 85 of 
										true ->
											
											case lib_road:get_sql_lookup_opponents_bylv( PlayerLV + 3 ,3,player:get_id(PS),UpdateList1) of
												[] -> SecondPKPlayerList00 = lib_road:get_sql_lookup_more_opponents_bylv( PlayerLV , 3 ,player:get_id(PS),UpdateList1),
													  case length(SecondPKPlayerList00) =:= 3 of
														  true -> SecondPKPlayerList00;
														  false -> lib_road:get_sql_lookup_most_opponents_bylv( PlayerLV ,3   ,player:get_id(PS),UpdateList1)
													  end;
												SecondPKPlayerList ->
													case length(SecondPKPlayerList) =:= 3 of
														true -> SecondPKPlayerList;
														false ->  SecondPKPlayerList0 =  lib_road:get_sql_lookup_more_opponents_bylv( PlayerLV ,3,player:get_id(PS),UpdateList1),
																  case length(SecondPKPlayerList0) =:= 3 of
																	  true ->
																		  SecondPKPlayerList0;
																	  false -> lib_road:get_sql_lookup_most_opponents_bylv( PlayerLV  , 3  ,player:get_id(PS),UpdateList1)
																  end
													end
											end;
										false ->
											case lib_road:get_sql_lookup_opponents_bylv( PlayerLV  + 3 ,3,player:get_id(PS),UpdateList1) of
												[] -> SecondPKPlayerList00 = lib_road:get_sql_lookup_more_opponents_bylv( PlayerLV  , 3 ,player:get_id(PS),UpdateList1),
													  case length(SecondPKPlayerList00) =:= 3 of
														  true -> SecondPKPlayerList00;
														  false -> lib_road:get_sql_lookup_most_opponents_bylv( PlayerLV  , 3  ,player:get_id(PS),UpdateList1)
													  end;
												SecondPKPlayerList ->
													case length(SecondPKPlayerList) =:= 3 of
														true -> SecondPKPlayerList;
														false ->  SecondPKPlayerList0 =  lib_road:get_sql_lookup_more_opponents_bylv(  PlayerLV  , 3 , player:get_id(PS),UpdateList1),
																  case length(SecondPKPlayerList0) =:= 3 of 
																	  true ->
																		  SecondPKPlayerList0;
																	  false ->  lib_road:get_sql_lookup_most_opponents_bylv(  PlayerLV  , 3  , player:get_id(PS),UpdateList1)
																  end
													end
											end
									end
											
							end;
				false -> []
			end,
			
			
					
			
			ThirdPK  =	case (RoadETS#road_info.now_point) =:= 8 of
							true ->
								case length( RoadETS#road_info.pk_info ) > 8 of
									true ->RoadETS#road_info.pk_info;
									false ->
										UpdatePar2 = RoadETS#road_info.pk_info,  %{PlayerId,Name,Faction,Lv,Sex,FivePartner}
										FFF = fun(X,Acc) ->
													  {FFFPlayerId,_FFFName,_FFFFaction,_FFFLv,_FFFSex,_FFFFivePartner}  = X ,
													  [FFFPlayerId|Acc]
											  end,
										UpdateList2 = lists:foldl(FFF, [], UpdatePar2),
										case PlayerLV < 85 of
											true ->
												
												case lib_road:get_sql_lookup_opponents_bylv( PlayerLV + 5 ,3,player:get_id(PS),UpdateList2) of
													
													[] -> 
														ThirdPKPlayerList = lib_road:get_sql_lookup_more_opponents_bylv( PlayerLV  ,3,player:get_id(PS),UpdateList2),
														case length(ThirdPKPlayerList)=:=3 of
															true -> ThirdPKPlayerList;
															false -> lib_road:get_sql_lookup_most_opponents_bylv( PlayerLV ,3,player:get_id(PS),UpdateList2)
														end;
															  
													ThirdPKPlayerList ->
														case length(ThirdPKPlayerList) =:= 3 of
															true -> ThirdPKPlayerList;
															false ->  ThirdPKPlayerList2 = lib_road:get_sql_lookup_more_opponents_bylv( PlayerLV ,3,player:get_id(PS),UpdateList2),
																	  case length(ThirdPKPlayerList2) =:=3 of
																		  true ->
																			  ThirdPKPlayerList2;
																		  false -> lib_road:get_sql_lookup_most_opponents_bylv( PlayerLV ,3,player:get_id(PS),UpdateList2)
																	  end																  
														end
												end ;
											false ->
												case lib_road:get_sql_lookup_opponents_bylv( PlayerLV   ,3,player:get_id(PS),UpdateList2) of
													[] ->  lib_road:get_sql_lookup_most_opponents_bylv( PlayerLV  ,3,player:get_id(PS),UpdateList2);
													ThirdPKPlayerList ->
														case length(ThirdPKPlayerList) =:= 3 of
															true -> ThirdPKPlayerList;
															false -> ThirdPKPlayerList2 =  lib_road:get_sql_lookup_more_opponents_bylv( PlayerLV ,3,player:get_id(PS),UpdateList2),
																	 case length(ThirdPKPlayerList2) =:= 3 of
																		 true ->ThirdPKPlayerList2;
																		 false -> lib_road:get_sql_lookup_most_opponents_bylv( PlayerLV ,3,player:get_id(PS),UpdateList2)
																	 end
														end
												end 
										end
								end;
				false -> []
			end,
			
			
			
			
			
			
			
			%	BattleList  =lib_road:get_battle_id_list(PS),
			
			
		
			
			F = fun(X,Acc) ->
						
						[PlayerId,Name,Faction,Lv,Sex] = X, %Name = <<230,174,135,228,184,182>>
						Bo = mod_offline_data:get_offline_bo(PlayerId, ?OBJ_PLAYER, ?SYS_OFFLINE_ARENA),
						
						case  Bo =:= null of 
							true -> [{PlayerId,Name,Faction,Lv,Sex,[]}|Acc];
							false -> 
								
								ParIdList = mod_offline_bo:get_partner_id_list(Bo),
								%   lib_mount:init_mount(PlayerId),
								
								case length(ParIdList) > 0 of
									true ->
										[IsPartnerR] =lists:sublist(ParIdList, 1, 1),
										case lib_partner:get_partner(IsPartnerR) of
											null ->ply_partner:db_load_partner_data(PlayerId);
											_R -> skip
										end;
									false -> ?DEBUG_MSG("RoadBattleParIdList:~p",ParIdList)
								end,
								
								
								%下面函数判断玩家是否在线，如若不在线需要去数据库自己加载到ETS中
								
								
								
								FiveParIdList = lib_road:get_five_partner_info(ParIdList),
								
								
								F1 = fun({PartnerId,_Count,IsMain},Acc1) ->
											 Partner = lib_partner:get_partner(PartnerId),
											 Hp = lib_partner:get_hp_lim(Partner),
											 Mp = lib_partner:get_mp_lim(Partner),
											 [{PartnerId,Hp,Mp,Hp,Mp,IsMain}|Acc1]
									 end,
								FivePartner = lists:foldl(F1, [], FiveParIdList),% [{a,b,c},{a,b,c},...]
								
								[{PlayerId,Name,Faction,Lv,Sex,FivePartner}|Acc]
						end
				end,
			
			PkPlayerData = 
				case (RoadETS#road_info.now_point) < 5  of
					true ->
						 lists:foldl(F, [], FirstPK);
	

					false -> case  (RoadETS#road_info.now_point) < 8 of
								 true ->
									 case length( RoadETS#road_info.pk_info ) > 5 of
										 true ->RoadETS#road_info.pk_info;
										 false -> RoadETS#road_info.pk_info  ++ lists:foldl(F, [], SecondPK)
									 end;
									 						 
								 false -> 	
									 case length( RoadETS#road_info.pk_info ) > 8 of
										 true ->RoadETS#road_info.pk_info;
										 false -> RoadETS#road_info.pk_info  ++ lists:foldl(F, [], ThirdPK)
									 end						 
							 end
				end,
			
			
			case (RoadETS#road_info.now_point) =:= 1 of
				true -> 
					case length(PkPlayerData) =:= 4 of
						true ->
							ParIdListData = player:get_partner_id_list(PS),
							F2 = fun(X,Acc2) ->
										 Partner = lib_partner:get_partner(X),
										 Hp = lib_partner:get_hp_lim(Partner),
										 Mp = lib_partner:get_mp_lim(Partner),  
										 [{X,Hp,Mp,Hp,Mp}|Acc2]
								 end,  
							
							PartnerInfo = lists:foldl(F2, [], ParIdListData),
							
							
							SelfParIdList = lib_road:get_five_self_partner_info(ParIdListData),  
							F3 = fun({PartnerId,_Count,IsMain},Acc3) ->
										 Partner = lib_partner:get_partner(PartnerId),
										 Hp = lib_partner:get_hp_lim(Partner),
										 Mp = lib_partner:get_mp_lim(Partner),
										 [{PartnerId,Hp,Mp,Hp,Mp,IsMain}|Acc3]
								 end,
							NowBattlePartner = lists:foldl(F3, [], SelfParIdList),
							?DEBUG_MSG("Testpp_road2:~pTest~p",[SelfParIdList,NowBattlePartner]),
							Road2 = RoadETS#road_info{partner_info = PartnerInfo,now_battle_partner =NowBattlePartner,pk_info = PkPlayerData,player_power =PlayerPower },
							mod_road:update_road_to_ets(Road2),
							%玩家宠物的Array，对手信息，当前关卡
							{ok, Bin} = pt_38:write(?PT_READY_BATTLE, [Road2#road_info.partner_info,Road2#road_info.now_battle_partner,Road2#road_info.pk_info,Road2#road_info.now_point]),
							lib_send:send_to_sock(PS, Bin),
							%%             db:insert(road, [], Field_Value_List)
							
							db:update(player:get_id(PS), road, [{now_battle_partner,util:term_to_bitstring(Road2#road_info.now_battle_partner)},
																{partner_info,util:term_to_bitstring(Road2#road_info.partner_info)}, {player_power,PlayerPower} , 
																{pk_info,util:term_to_bitstring(Road2#road_info.pk_info) }], 
									  [{player_id, player:get_id(PS)}]);
						false ->lib_send:send_prompt_msg(player:get_id(PS), ?PM_QUJING_NO_DATA)
					end;
							
				false -> 
					case (RoadETS#road_info.now_point) =:= 5 of
						true ->
							case length(PkPlayerData) =:= 7 of
								true ->
									
									Road2 = RoadETS#road_info{pk_info = PkPlayerData,player_power =PlayerPower },
									db:update(player:get_id(PS), road, [{ pk_info ,  util:term_to_bitstring(Road2#road_info.pk_info) },{player_power,PlayerPower }], 
											  [{player_id, player:get_id(PS)}]),
									mod_road:update_road_to_ets(Road2),
									{ok, Bin} = pt_38:write(?PT_READY_BATTLE, [RoadETS#road_info.partner_info,RoadETS#road_info.now_battle_partner,Road2#road_info.pk_info,RoadETS#road_info.now_point]),
									lib_send:send_to_sock(PS, Bin);
								false ->
									lib_send:send_prompt_msg(player:get_id(PS), ?PM_QUJING_NO_DATA2)
							end;
						false ->
							case (RoadETS#road_info.now_point) =:= 8 of
								true ->
									case length(PkPlayerData) =:= 10 of
										true ->
											Road2 = RoadETS#road_info{pk_info = PkPlayerData , player_power =PlayerPower  },
											db:update(player:get_id(PS), road, [{ pk_info ,  util:term_to_bitstring(Road2#road_info.pk_info) }, {player_power,PlayerPower }], 
													  [{player_id, player:get_id(PS)}]),
											mod_road:update_road_to_ets(Road2),
											{ok, Bin} = pt_38:write(?PT_READY_BATTLE, [RoadETS#road_info.partner_info,RoadETS#road_info.now_battle_partner,Road2#road_info.pk_info,RoadETS#road_info.now_point]),
											lib_send:send_to_sock(PS, Bin);
										false ->
											lib_send:send_prompt_msg(player:get_id(PS), ?PM_QUJING_NO_DATA3)
									end;
								false ->
									Road2 = RoadETS#road_info{pk_info = PkPlayerData },
									db:update(player:get_id(PS), road, [{ pk_info ,  util:term_to_bitstring(Road2#road_info.pk_info) }], 
											  [{player_id, player:get_id(PS)}]),
									mod_road:update_road_to_ets(Road2),
									{ok, Bin} = pt_38:write(?PT_READY_BATTLE, [RoadETS#road_info.partner_info,RoadETS#road_info.now_battle_partner,Road2#road_info.pk_info,RoadETS#road_info.now_point]),
									lib_send:send_to_sock(PS, Bin)
							end
					end
			end;
				
			
			
		false  ->
			R=mod_road:get_road_from_ets(player:get_id(PS)),
			NowBattlePartner = R#road_info.now_battle_partner, %[{2000900000045385,738,141,948,141,1},{2000900000045370,0,660,1885,660,0}]
			NowPKPlayer  = lists:sublist( R#road_info.pk_info , R#road_info.now_point , 1),
			[{PlayerId,_Name,_Faction,_Lv,_Sex,FivePartner}]  =  NowPKPlayer,
			case length(FivePartner) > 0  of 
				true ->[{OneParId,_Hp,_Mp,_MaxHp,_MaxMp,_IsMain}] = lists:sublist(FivePartner,1,1),
					   case lib_partner:get_partner(OneParId) of
						   null ->ply_partner:db_load_partner_data(PlayerId);
						   _R -> skip
					   end;
				false -> skip
			end,
			MyPartnerInfo0 = R#road_info.partner_info,
%% 			[{2000900000045385,738,141,948,141},
%% 			 {2000900000045386,0,27,889,141},
%% 			 {2000900000045370,0,660,1885,660}]
			MyParIdList = player:get_partner_id_list(PS),  %[xxx,xxxx,xxx......]
			F = fun(X,Acc) ->
					case lists:keyfind(X, 1, MyPartnerInfo0) of
						false ->
							Partner = lib_partner:get_partner(X),
							GHp = lib_partner:get_hp_lim(Partner),
							GMp = lib_partner:get_mp_lim(Partner),
							[{X,GHp,GMp,GHp,GMp}|Acc];
						_G1 -> Acc
					end
				end,
		
			
			MyPartnerInfo2 =  lists:foldl(F, [], MyParIdList),
			
			MyPartnerInfo1 = MyPartnerInfo0 ++ MyPartnerInfo2,
			
			
			F2 = fun(X2,Acc2) ->
						 
						 case lists:keyfind(X2, 1, MyPartnerInfo1) of
							 false ->
								% 这是没有的 
								 Acc2;
							 G2 ->
                                %这是没有被解雇的
								[G2|Acc2] 
						 end
				 end,
			
			
			MyPartnerInfo = lists:foldl(F2, [], MyParIdList ), % 用于更新玩家是否解雇了门客

			F3 = fun(X3,Acc3) ->
						 case lists:keyfind(X3, 1, NowBattlePartner) of
							 false -> Acc3;
							 G3 -> [G3| Acc3]
						 end
	             end,
	        NewNowBattlePartner  =lists:foldl(F3, [],MyParIdList  ), 
			
		
			
			R2 = R#road_info{ partner_info = MyPartnerInfo,now_battle_partner =NewNowBattlePartner  },
			mod_road:update_road_to_ets(R2),

			{ok, Bin} = pt_38:write(?PT_READY_BATTLE, [MyPartnerInfo,NewNowBattlePartner,R#road_info.pk_info,R#road_info.now_point]),
			lib_send:send_to_sock(PS, Bin)
	
	end;



handle(?PT_START_BATTLE, PS, [IdMainList]) ->
	
	%%更新当前关卡对手的门客信息
    %lib_road:update_road_pk_data(PS),
	RoadData = mod_road:get_road_from_ets(player:get_id(PS)),
	PartnerInfo = RoadData#road_info.partner_info,
	F = fun({X,IsMain},Acc) ->
				case lists:keyfind(X, 1, PartnerInfo) of
					{PartnerId,Hp,Mp,MaxHp,MaxMp} -> [{PartnerId,Hp,Mp,MaxHp,MaxMp,IsMain}|Acc] ;
					false            -> Acc   %防止玩家进去取经之路界面后，又把门客给解雇了等骚操作
				end
		end,
	
	NewBattlePar = lists:foldl(F, [], IdMainList),

	%先将自己选择的宠物加载进战斗数据中
    case lists:keyfind(1, 2, IdMainList)  of
		false ->
			lib_send:send_prompt_msg(player:get_id(PS), ?PM_QUJING_MAIN_PAR);
		_R ->
			case lists:keyfind(0, 2, NewBattlePar) of
				false ->			 
						 RoadData2 = RoadData#road_info{now_battle_partner =NewBattlePar},
						 mod_road:update_road_to_ets(RoadData2),
						 
						 PkerData0 = RoadData#road_info.pk_info,
						 NowPoint = RoadData#road_info.now_point,

						 %lists:keyfind(b, 1, TupleList).lists:map(fun(E) -> E * E end, [1, 2, 3, 4, 5]).
						 PkerData = 
							 case length(PkerData0) >= NowPoint of
								 true -> lists:sublist(PkerData0, NowPoint, 1);
								 false -> ?ASSERT(false,NowPoint)
							 end,
					 
						 [{OpponentId,_PlayerName,_Faction,_PlayerLv,_Sex,_FivePar}] =PkerData,
						 
						 gen_server:cast(player:get_pid(player:id(PS)), {road_battle, OpponentId,RoadData2});
				_T ->
					lib_send:send_prompt_msg(player:get_id(PS), ?PM_QUJING_NO_PAR)
			end
	end;

	
			
   
%% 请求总览信息
handle(?PT_RESET_ROAD, PS, []) ->  %PM_NOT_JOIN_FACTION_YET 
    RoadETS = mod_road:get_road_from_ets(player:get_id(PS)),
	MoneyCount = data_special_config:get('qujing_reset'),
	case RoadETS#road_info.reset_times > 0  of
		true -> 
			%判断水玉
			case player:has_enough_bind_yuanbao(PS, MoneyCount) of
				true ->  
					lib_road:reset_time(PS),
					player:cost_yuanbao(PS, MoneyCount, ["road","roadResetCost"]),
					{ok, Bin2} = pt_38:write(?PT_RESET_ROAD, [0]),
					lib_send:send_to_sock(PS, Bin2);
				false -> lib_send:send_prompt_msg(player:get_id(PS), ?PM_YB_LIMIT)
			end;
		false -> lib_send:send_prompt_msg(player:get_id(PS), ?PM_LEFT_TIME_LIMIT)
	end;


handle(?PT_GET_REWARD, PS, [Step]) ->  %PM_NOT_JOIN_FACTION_YET 
    QuJingReward = data_qujing_reward:get(Step),
	RewardNo = QuJingReward#qujing_reward.reward_no,
	RoadETS = mod_road:get_road_from_ets(player:get_id(PS)),
	NowPoint = RoadETS#road_info.now_point,
	GetPoint = RoadETS#road_info.get_point,
	
	case mod_inv:check_batch_add_goods(player:id(PS), [{RewardNo, 1}]) of
        {fail, _Reason} ->
            lib_send:send_prompt_msg(player:get_id(PS), ?PM_US_BAG_FULL);
        ok ->
			case NowPoint > Step of
				true -> 
					case  lists:member(Step,GetPoint) of
						true ->
							lib_send:send_prompt_msg(player:get_id(PS), ?PM_AD_REPEAT_GET);
						false ->
							
					
							mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{RewardNo, 1}]),
							{ok, Bin} = pt_38:write(?PT_GET_REWARD, [0]),
							lib_send:send_to_sock(PS, Bin),
							
							NewGetPoint = GetPoint ++   [Step], 
							NewRoad = RoadETS#road_info{get_point = NewGetPoint },
							mod_road:update_road_to_ets(NewRoad),
							
							db:update(player:get_id(PS), road, [{get_point,util:term_to_bitstring(NewGetPoint)}], 
									  [{player_id, player:get_id(PS)}]),
							
							
							{ok, Bin2} =pt_38:write(?PT_GET_ROAD, [RoadETS#road_info.now_point,RoadETS#road_info.reset_times,NewGetPoint]),
							lib_send:send_to_sock(PS, Bin2)
					end;
				false -> 
					 lib_send:send_prompt_msg(player:get_id(PS), ?PM_NPC_NOT_EXISTS)
			end
	end;
											
          



%% desc: 容错
handle(_Cmd, _PS, _Data) ->
	?DEBUG_MSG("pp_hire no match", []),
	{error, "pp_hire no match"}.








