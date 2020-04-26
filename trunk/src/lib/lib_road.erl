%%%-----------------------------------
%%% @Module  : lib_road
%%% @Author  : wujianhcneg
%%% @Email   : 
%%% @Created : 2018.7.17
%%% @Description: 取经之路系统相关函数
%%%-----------------------------------
-module(lib_road).
-export([
		get_five_partner_info/1,
		update_road_pk_data/1,
		get_five_self_partner_info/1,
		get_battle_id_list/1,
		reset_time/1,
		add_time/1,
		get_sql_lookup_opponents_bylv/4,
		get_sql_lookup_more_opponents_bylv/4,
		get_sql_lookup_most_opponents_bylv/4,
		refresh_data/2
		
		
		]).

-compile(export_all).

-include("record.hrl").
-include("prompt_msg_code.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("ets_name.hrl").
-include("log.hrl").
-include("pt_38.hrl").
-include_lib("stdlib/include/ms_transform.hrl").
-include("partner.hrl").
-include("record/goods_record.hrl").
-include("road.hrl").
-include("sys_code.hrl").

%%用于重置或者首次取经
%% init_partner_data(PS) ->
%% 	ParIdList = player:get_partner_id_list(PS),
%% 	F= fun(X,Acc)->
%% 			  Partner = lib_partner:get_partner(X),
%% 			  Hp = lib_partner:get_hp_lim(Partner),
%% 			  Mp = lib_partner:get_mp_lim(Partner),  
%%               [{X,Hp,Mp}|Acc]
%% 	   end,
%% 	InitList = lists:foldl(F, [], ParIdList),
%% 
%% 	F1= fun(X,Acc)->
%% 			  Partner = lib_partner:get_partner(X),
%% 			  Hp = lib_partner:get_hp_lim(Partner),
%% 			  Mp = lib_partner:get_mp_lim(Partner),
%%               case Partner#partner.state =:= ?PAR_STATE_JOIN_BATTLE_UNLOCKED of
%% 				  true -> [{X,Hp,Mp}|Acc];
%% 			      false -> Acc
%% 			  end
%% 	   end,
%% 	BattleList = lists:foldl(F1, [], ParIdList),
%% 	case lib_vip:lv(PS) >= 3 of
%% 		true -> RoadInfo = #road_info{player_id = player:get_id(PS),now_point=1,reset_times =1, partner_info = InitList,now_battle_partner = BattleList};
%% 		false-> RoadInfo =#road_info{player_id = player:get_id(PS),now_point=1,reset_times =0, partner_info = InitList,now_battle_partner = BattleList}
%% 	end,
%%     mod_road:update_road_to_ets(RoadInfo),
%% 	BattleList.

%%获取五个最高评分门客的数据
get_five_partner_info(PartnerIdList) ->
	
	F= fun(X,Acc)->
			  
			  Y = lib_partner:get_partner(X),
			  ?DEBUG_MSG("TestFivePartner:Y=~p,X=~p~n",[Y,X]),
			  PartnerBattlePower = 
				  case Y of
					  null -> 
						  0;
					  _R ->lib_partner:get_battle_power(Y)
				  end ,
%% 			  case lib_partner:is_main_partner(Y) of 
%% 				  true -> Main = 1;
%% 				  false -> Main = 0
%% 			  end,
			  [{X,PartnerBattlePower}|Acc] 
	   end,
	BattlePowerList = lists:foldl(F, [], PartnerIdList),
	
	case length(BattlePowerList) > 0 of
		true ->
			SortList1 = lists:keysort(2, BattlePowerList),  %按照战力排序
            SortList = lists:reverse(SortList1),
			TotalList0 = case length(SortList) < 5  of 
							 true -> SortList;  %[{id,count},{id2,count2},...]
							 false -> lists:sublist(SortList,5)  %[{id,count},{id2,count2},...]刚好五个
						 end,
			
			F2 = fun({Id,Count} , Acc) ->
						 case Count > 0 of
							 true ->
								 case length(Acc) =:= 0 of
									 true -> [{Id,Count,1} |Acc];
									 false -> [{Id,Count,0} |Acc]    
								 end;
							 false -> Acc
						 end
				 end,
			lists:foldl(F2, [], TotalList0);
		false -> []
	end.

	
%% 
%% %战力、左边、右边、个数 返回对手数据
%% get_sql_lookup_opponents(PlayerPower,Left,Right,Limit,PlayerId,SameIdList0) ->
%% 	%[1000100000047144, <<228,184,156,233,131,173,231,142,132,233,155,133>>,  6,70,2]
%%                 
%%                  
%% 	
%% 	SQLList =  case length(SameIdList0) of   %AND opened_sys  LIKE  '%26%' 
%% 				   0 -> 
%% 					   lists:concat(["SELECT id,nickname,faction,lv,sex FROM player WHERE lv > 50 AND opened_sys  LIKE  '%26%'   AND store_par_hp > 1   AND  id NOT IN( ",PlayerId ,")  AND  battle_power >= ",util:ceil(PlayerPower*Left)," AND  faction > 0  AND battle_power < ",
%% 									 util:ceil(PlayerPower*Right)," ORDER BY RAND()  LIMIT  ",Limit ]);
%% 				   4 -> [ SameId1,SameId2,SameId3,SameId4] = SameIdList0,
%% 						lists:concat(["SELECT id,nickname,faction,lv,sex FROM player WHERE lv > 50 AND opened_sys  LIKE  '%26%'   AND   store_par_hp > 1  AND  id NOT IN( ",PlayerId,
%% 									   "," ,SameId1, "," ,SameId2 , "," ,SameId3 , "," ,SameId4 , ")  AND   battle_power >= ",util:ceil(PlayerPower*Left)," AND  faction > 0  AND battle_power < ",
%% 									 util:ceil(PlayerPower*Right)," ORDER BY RAND()  LIMIT  ",Limit ]); 
%% 				   7 -> [SameId1,SameId2,SameId3,SameId4,SameId5,SameId6,SameId7] = SameIdList0, 
%% 						lists:concat(["SELECT id,nickname,faction,lv,sex FROM player WHERE lv > 50 AND opened_sys  LIKE  '%26%'    AND store_par_hp > 1  AND  id NOT IN( ",PlayerId,
%% 									   "," ,SameId1, "," ,SameId2 , "," ,SameId3 ,
%% 									   "," ,SameId4 , "," ,SameId5 , "," ,SameId6 , "," ,SameId7, ")  AND  battle_power >= ",util:ceil(PlayerPower*Left)," AND  faction > 0  AND battle_power < ",
%% 									 util:ceil(PlayerPower*Right)," ORDER BY RAND()  LIMIT  ",Limit ])
%% 			   end,
%% 					   
%% 	
%% 	case db:select_all(player,SQLList) of
%% 		[] ->[];
%% 		PlayerList -> PlayerList
%% 						
%% 	end.


%战力、左边、右边、个数 返回对手数据
get_sql_lookup_opponents_bylv(Lv,Limit,PlayerId,SameIdList0) ->
	%[1000100000047144, <<228,184,156,233,131,173,231,142,132,233,155,133>>,  6,70,2]
                
                 
	
	SQLList =  case length(SameIdList0) of   %AND opened_sys  LIKE  '%26%' 
				   0 -> 
					   lists:concat(["SELECT id,name,faction,lv,sex FROM offline_bo WHERE bo_type = 1 AND faction > 0  AND  sys_type = 26 AND id != ", PlayerId,"  AND   lv > "  ,(Lv - 15) ,"   AND  lv < " ,(Lv + 9), "
									 ORDER BY RAND()  LIMIT  ",Limit ]);
				   4 -> [ SameId1,SameId2,SameId3,SameId4] = SameIdList0,
						lists:concat(["SELECT id,name,faction,lv,sex FROM offline_bo WHERE bo_type = 1 AND faction > 0  AND sys_type = 26 AND lv > " ,(Lv - 10) ," AND lv < " ,(Lv + 15), "  AND  id NOT IN( ",PlayerId,
									   "," ,SameId1, "," ,SameId2 , "," ,SameId3 , "," ,SameId4 , ") ORDER BY RAND()  LIMIT  ",Limit ]); 
				   7 -> [SameId1,SameId2,SameId3,SameId4,SameId5,SameId6,SameId7] = SameIdList0, 
						lists:concat(["SELECT id,name,faction,lv,sex FROM offline_bo WHERE bo_type = 1 AND faction > 0  AND sys_type = 26  AND lv > " ,(Lv - 5) ," AND lv < " ,(Lv + 30), "  AND  id NOT IN( ",PlayerId,
									   "," ,SameId1, "," ,SameId2 , "," ,SameId3 ,
									   "," ,SameId4 , "," ,SameId5 , "," ,SameId6 , "," ,SameId7, ")  ORDER BY RAND()  LIMIT  ",Limit ])
			   end,
					   
	
	case db:select_all(offline_bo,SQLList) of
		[] ->[];
		PlayerList -> PlayerList
						
	end.

%战力、左边、右边、个数 返回对手数据
get_sql_lookup_more_opponents_bylv(Lv,Limit,PlayerId,SameIdList0) ->
	%[1000100000047144, <<228,184,156,233,131,173,231,142,132,233,155,133>>,  6,70,2]
                
                 
	
	SQLList =  case length(SameIdList0) of   %AND opened_sys  LIKE  '%26%' 
				   0 -> 
					   lists:concat(["SELECT id,name,faction,lv,sex FROM offline_bo WHERE bo_type = 1 AND faction > 0  AND  sys_type = 26 AND id != ", PlayerId,"  AND   lv > "  ,(Lv - 45) ,"   AND  lv < " ,(Lv + 45), "
									 ORDER BY RAND()  LIMIT  ",Limit ]);
				   4 -> [ SameId1,SameId2,SameId3,SameId4] = SameIdList0,
						lists:concat(["SELECT id,name,faction,lv,sex FROM offline_bo WHERE bo_type = 1 AND faction > 0  AND sys_type = 26 AND lv > " ,(Lv - 50) ," AND lv < " ,(Lv + 50), "  AND  id NOT IN( ",PlayerId,
									   "," ,SameId1, "," ,SameId2 , "," ,SameId3 , "," ,SameId4 , ") ORDER BY RAND()  LIMIT  ",Limit ]); 
				   7 -> [SameId1,SameId2,SameId3,SameId4,SameId5,SameId6,SameId7] = SameIdList0, 
						lists:concat(["SELECT id,name,faction,lv,sex FROM offline_bo WHERE bo_type = 1 AND faction > 0  AND sys_type = 26  AND lv > " ,(Lv - 45) ," AND lv < " ,(Lv + 60), "  AND  id NOT IN( ",PlayerId,
									   "," ,SameId1, "," ,SameId2 , "," ,SameId3 ,
									   "," ,SameId4 , "," ,SameId5 , "," ,SameId6 , "," ,SameId7, ")  ORDER BY RAND()  LIMIT  ",Limit ])
			   end,
					   
	
	case db:select_all(offline_bo,SQLList) of
		[] ->[];
		PlayerList -> PlayerList
						
	end.

%战力、左边、右边、个数 返回对手数据
get_sql_lookup_most_opponents_bylv(Lv,Limit,PlayerId,SameIdList0) ->
	%[1000100000047144, <<228,184,156,233,131,173,231,142,132,233,155,133>>,  6,70,2]
                
                 
	
	SQLList =  case length(SameIdList0) of   %AND opened_sys  LIKE  '%26%' 
				   0 -> 
					   lists:concat(["SELECT id,name,faction,lv,sex FROM offline_bo WHERE bo_type = 1 AND faction > 0  AND  sys_type = 26 AND id != ", PlayerId,"  AND   lv > "  ,(Lv - 150) ,"   AND  lv < " ,(Lv + 200), "
									 ORDER BY RAND()  LIMIT  ",Limit ]);
				   4 -> [ SameId1,SameId2,SameId3,SameId4] = SameIdList0,
						lists:concat(["SELECT id,name,faction,lv,sex FROM offline_bo WHERE bo_type = 1 AND faction > 0  AND sys_type = 26 AND lv > " ,(Lv - 150) ," AND lv < " ,(Lv + 200), "  AND  id NOT IN( ",PlayerId,
									   "," ,SameId1, "," ,SameId2 , "," ,SameId3 , "," ,SameId4 , ") ORDER BY RAND()  LIMIT  ",Limit ]); 
				   7 -> [SameId1,SameId2,SameId3,SameId4,SameId5,SameId6,SameId7] = SameIdList0, 
						lists:concat(["SELECT id,name,faction,lv,sex FROM offline_bo WHERE bo_type = 1 AND faction > 0  AND sys_type = 26  AND lv > " ,(Lv - 150) ," AND lv < " ,(Lv + 200), "  AND  id NOT IN( ",PlayerId,
									   "," ,SameId1, "," ,SameId2 , "," ,SameId3 ,
									   "," ,SameId4 , "," ,SameId5 , "," ,SameId6 , "," ,SameId7, ")  ORDER BY RAND()  LIMIT  ",Limit ])
			   end,
					   
	
	case db:select_all(offline_bo,SQLList) of
		[] ->[];
		PlayerList -> PlayerList
						
	end.



get_battle_id_list(PlayerId) ->
	SQLList = lists:concat(["SELECT partners  FROM offline_bo WHERE sys_type = 26 AND id = ",PlayerId ]),
	
	db:select_row(offline_bo,SQLList).
		  
    
%% 
%% 
%% %用于防止竞技场的符合条件的玩家不够十个
%% get_ten_battle_id_list(IdList,[]) -> 
%%     IdList ;
%% 
%% get_ten_battle_id_list(IdList,no) -> 
%% 	case length(IdList) < 10 of 
%% 		true ->
%% 			List0 = lists:sublist(IdList, 1, 1),
%% 		    get_ten_battle_id_list((IdList ++ List0),no);
%% 		
%% 		false -> get_ten_battle_id_list(IdList,[])
%% 	end.

reset_time(PS) ->
	{ok, Bin} = pt_38:write(?PT_GET_ROAD, [1,0,[]]),
	R = #road_info{player_id =player:get_id(PS), now_point = 1, reset_times=0 , unix_time = util:unixtime(),
				   now_battle_partner = [], partner_info = [],pk_info = []  },
	mod_road:update_road_to_ets(R),
	db:delete(road, [{player_id, player:get_id(PS)}]),
	lib_send:send_to_sock(PS, Bin),	
	db:insert(road, [player_id, now_point, get_point, reset_times, unix_time,
					 now_battle_partner,partner_info,pk_info], 
			  [player:get_id(PS), 1, util:term_to_bitstring([]), 0 , util:unixtime(),
			   util:term_to_bitstring([]), util:term_to_bitstring([]), util:term_to_bitstring([])]).


add_time(PS) ->
	{ok, Bin} = pt_38:write(?PT_GET_ROAD, [1,1,[]]),
	R = #road_info{player_id =player:get_id(PS), now_point = 1, reset_times=1 , unix_time = util:unixtime(),
				   now_battle_partner = [], partner_info = [],pk_info = []  },
	mod_road:update_road_to_ets(R),
	db:delete(road, [{player_id, player:get_id(PS)}]),
	lib_send:send_to_sock(PS, Bin),	
	db:insert(road, [player_id, now_point, get_point, reset_times, unix_time,
					 now_battle_partner, partner_info, pk_info], 
			  [player:get_id(PS), 1, util:term_to_bitstring([]), 1 , util:unixtime(),
			   util:term_to_bitstring([]), util:term_to_bitstring([]), util:term_to_bitstring([])]).

%用于刷新数据，保留原次数
refresh_data(PlayerId,RoadData) ->
    ResetTime = RoadData#road_info.reset_times,
	OldUnixTime = RoadData#road_info.unix_time,
    NewPoint = 1,

	{ok, Bin} = pt_38:write(?PT_GET_ROAD, [NewPoint,ResetTime,[]]),
	R = #road_info{player_id =PlayerId, now_point = NewPoint, reset_times=ResetTime , unix_time = OldUnixTime,
				   now_battle_partner = [], partner_info = [],pk_info = []  },
	mod_road:update_road_to_ets(R),
	db:delete(road, [{player_id, PlayerId}]),
	lib_send:send_to_sock(player:get_PS(PlayerId), Bin),	
	db:insert(road, [player_id, now_point, get_point, reset_times, unix_time,
					 now_battle_partner, partner_info, pk_info], 
			  [PlayerId, NewPoint, util:term_to_bitstring([]), ResetTime , OldUnixTime,
			   util:term_to_bitstring([]), util:term_to_bitstring([]), util:term_to_bitstring([])]).

		
	



%%获取五个最高评分门客的数据
get_five_self_partner_info(PartnerIdList) ->
	F= fun(X,Acc)->
			   
			  Y = lib_partner:get_partner(X),
			  ?DEBUG_MSG("TestFivePartner:Y=~p,X=~p~n",[Y,X]),
			  PartnerBattlePower = lib_partner:get_battle_power(Y),
			  case lib_partner:is_main_partner(Y) of 
				  true -> Main = 1;
				  false -> Main = 0
			  end,
			  case lib_partner:is_fighting(Y) of 
				  true ->
					  [{X,PartnerBattlePower,Main}|Acc];
				  false -> Acc
			  end
			  	
	   end,
	BattlePowerList = lists:foldl(F, [], PartnerIdList),
	SortList = lists:keysort(2, BattlePowerList),
	case length(SortList) < 5  of 
		true -> SortList;  %[{id,count},{id2,count2},...]
        false -> lists:sublist(SortList,5)  %[{id,count},{id2,count2},...]刚好五个
	end.

%% @doc 更新取经之路对手的最新数据
update_road_pk_data(RoleId) when is_integer(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) -> update_road_pk_data(Status);
        _ -> skip
    end;
update_road_pk_data(Status) when is_record(Status, player_status) ->
  %Partner#partner{total_attrs = Partner#partner.total_attrs#attrs{hp = NewCurHp, mp = NewCurMp}},
	case mod_offline_data:get_offline_bo(player:id(Status), ?OBJ_PLAYER, 26) of
		null -> mod_offline_data:db_replace_role_offline_bo(Status, 26);
		_OfflineBo ->
			%更新对手的角色
			mod_offline_data:db_update_role_offline_bo(Status, ?SYS_OFFLINE_ARENA),
			
			RoadRecord = mod_road:get_road_from_ets(player:get_id(Status)),
			PkerData = RoadRecord#road_info.pk_info,
			NowPoint = RoadRecord#road_info.now_point,
			OpponentPartner = 
				case length(PkerData) >= NowPoint of
					true -> lists:sublist(PkerData, NowPoint, 1);
					false -> ?ASSERT(false,NowPoint)
				end,
			
	
			[{_PlayerId,_PlayerName,_Faction,_PlayerLv,_Sex,PkPartner}] =OpponentPartner,
			lists:foreach(
			  fun({PartnerId,Hp,Mp,_MaxHp,_MaxMp,_IsMain}) ->
					  Partner = lib_partner:get_partner(PartnerId),
					  %更新敌方的的门客
					  Partner1= Partner#partner{total_attrs = Partner#partner.total_attrs#attrs{hp = Hp, mp = Mp}},
					  mod_offline_data:db_replace_partner_offline_bo(Partner1, 26)
			  end, PkPartner)
	
	end.
    
	




	
	














