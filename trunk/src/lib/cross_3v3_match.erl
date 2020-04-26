%% @author wujiancheng
%% @doc @todo Add description to cross_3v3_match:send_rank_reward().


-module(cross_3v3_match).

-export([filter_pool/0,insert_data/0,show_battle_info/1,
		 start_3V3/1,matching_overtime/1,insert_data2/0, 
		 check_over_time_match/0,send_rank_reward/0,become_legend/0]).

-include("pvp.hrl").
-include("record/battle_record.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("char.hrl").
-include("common.hrl").
-include("protocol/pt_43.hrl").
-include("prompt_msg_code.hrl").
-include("offline_data.hrl").
-include("partner.hrl").
-include("reward.hrl").
%% 
%% %% 跨服聊天窗口查看玩家数据
%% -define(ETS_CROSS_CHAT_DATA, ets_cross_chat_DATA).
%% 
%% -define(ETS_CROSS_PLAYER,	ets_cross_player).					% 跨服玩家的player数据
%% 
%% -define(ETS_PVP_3V3_SUP_POOL, ets_pvp_3v3_sup_pool).					% 跨服3v3战斗房间匹配池
%% 
%% -define(ETS_PVP_3V3_ROOM, ets_pvp_3v3_room).					% 跨服3v3创建房间
%% 
%% -define(ETS_PVP_RANK_DATA, ets_pvp_rank_data).					% 跨服3v3战斗全服排名
%% 
%% -define(ETS_PVP_CROSS_PLAYER_DATA, pvp_cross_player_data).      % 跨服3v3玩家数据
%% 
%% -define(CROSS_TYPE_POOL, cross_type_pool).



%存入一些测试数据

%% -record(room, {
%%     captain = 0,        % 队长(均是保存玩家Id)
%%     teammates = [],     % 队友(同上)
%%     timestamp = 0,      % 房间创建时间戳
%%     state2 = 0,          % 0：表示可加入队伍 1：表示不可加入队伍(表示正在匹配)
%%     grade = 0,          % 队伍评分(目前只是把房间队员的score相加)
%%     counters = 1,       % 房间默认人数(即是队长)
%%     cur_troop = 0,      % 当前阵法
%%     petlists = []       % 形式{captain, partnerID}
%% }).
%% 
%% -record(sup_pool, {
%%     dan = 0,            % 段位
%%     pool = []           % 存放房间已经开始匹配的room
%% }).

insert_data2() ->
	
	Data3 =  #match_room{captain = 1000300000047253, teammates = [1000300000047261, 1000300000047262], counters =3, timestamp =util:unixtime() + 1  },
	ets:insert(?ETS_PVP_MATCH_ROOM, Data3),
	matching_overtime(Data3).


insert_data() ->
	%测试结果应该符合 青铜三排一组1 2 3  青铜与白银组成一组645   白银一组12 13 7 {room,12,[[7,6],13]
	F = fun(Counter) ->
				Data = #pvp_cross_player_data{player_id = Counter, player_name ="wjc", timestamp =util:unixtime() + 1    },
				ets:insert(?ETS_PVP_CROSS_PLAYER_DATA, Data)
		end,
	lists:foreach(F, [1000300000047253,1000300000047261,1000300000047262,1885300000047269,1885300000047270,1885300000047271]),
	Data =  #room{captain = 1000300000047253, teammates = [], counters =1, timestamp =util:unixtime() + 1  },
	Data2 = #room{captain = 1885300000047269, counters =3, teammates = [1885300000047270,1885300000047271], timestamp =util:unixtime() + 2  },
	%% 	Data3 = #room{captain = 1885300000047271, counters =1, timestamp =util:unixtime() + 3  },
	%% 	Data4 = #room{captain = 7, counters =1, timestamp =util:unixtime() + 1  },
	%% 	Data5 = #room{captain = 8, counters =2,teammates = [9],  timestamp = util:unixtime() + 2  },
	%% 	Data6 = #room{captain = 10, counters =2,teammates = [11], timestamp =util:unixtime() + 3  },
	%% 	Data7 = #room{captain = 12, counters =2,teammates = [13],  timestamp = util:unixtime() + 2  },
	%% 	Data8 = #room{captain = 14, counters =1, timestamp =util:unixtime() + 3  },
	
	%% 	Data4= #sup_pool{ dan = 1, pool = [] },
	Sup1= #sup_pool{ dan = 1, pool = [Data] },
	ets:insert(?ETS_PVP_3V3_ROOM, Data),
	%% 	Sup2= #sup_pool{ dan = 3, pool = [Data2] },
	%% 	Sup4= #sup_pool{ dan = 4, pool = [Data8] },
	%% 	ets:insert(?ETS_PVP_3V3_SUP_POOL, Data4),
	%%  	ets:insert(?ETS_PVP_3V3_SUP_POOL, Sup2),
	ets:insert(?ETS_PVP_3V3_SUP_POOL, Sup1).
%% 	ets:insert(?ETS_PVP_3V3_SUP_POOL, Sup2),
%% 	ets:insert(?ETS_PVP_3V3_SUP_POOL, Sup4).



%  三个低段位单排的测试结果
%% ets:lookup(ets_pvp_3v3_sup_pool, 1).
%% [{sup_pool,1,[{room,3,[2,1],1545387162,1,0,3,0,[]}]}]
%%
%% ets:lookup(cross_type_pool , {1,3}).
%% [{type_pool,{1,3},[3]}]

%  两个低段位单排， 一个高段位双排  ets:lookup(ets_pvp_3v3_sup_pool , Type + 1)
%%  ets:lookup(ets_pvp_3v3_room, 1100300005000289).
%% [{sup_pool,1,[{room,3,[2,1],15 45400253,1,0,3,0,[]}]}]  ets_pvp_3v3_sup_pool ets_pvp_3v3_room
%% [{type_pool,{1,3},[3]}]  ets:tab2list(cross_type_pool). cross_type_pool
%                             ets_pvp_3v3_room    ets:tab2list(ets_pvp_3v3_sup_pool). ets_pvp_3v3_sup_pool

%  一个低段位单排， 两个个高段位双排
%%  ets:lookup(ets_pvp_3v3_sup_pool, 1).
%% [{sup_pool,1,[{room,3,[2,1],1545400253,1,0,3,0,[]}]}]
%% [{type_pool,{1,3},[3]}]

%   三个高段位单排排
%%  ets:lookup(ets_pvp_3v3_sup_pool, 2).
%%  ets:lookup(cross_type_pool, {2 ,3}).
%% [{sup_pool,2,[{room,2,[3,1],1545446604,1,0,3,0,[]}]}]
%% [{type_pool,{2,3},[2]}]

%%双排低段位一组， 单排高段位3个 ，双排高段位两组
%% c:l(cross_3v3_match).
%%c:l(mod_battle).
%% cross_3v3_match:show_battle_info({1885300000047269,1000300000047253}).
%% cross_3v3_match:insert_data2().  ets:tab2list(cross_type_pool).  ets:tab2list(ets_pvp_match_room).
%% cross_3v3_match:insert_data().    ets:insert(cross_type_pool,#room{type = {1,3}, player_id = [1000300000047253] } ).
%% cross_3v3_match:start_timer().   cross_3v3_match:filter_pool().
%% cross_3v3_match:check_over_time_match().  cross_3v3_match:start_3V3({1885300000047269,1000300000047253}).

grouping(PlayerIds) ->
	grouping(PlayerIds, []).

grouping([P1,P2|T], Pairs) ->
	grouping(T, [{P1,P2}|Pairs]);

grouping([], Pairs) ->
	Pairs.


arrange_robot_to_battle(PlayerId, OfflineBo, ShowName) ->
	%队长的player_id
	show_battle_robot_info(PlayerId,ShowName),
	timer:sleep(2900),
	PS =player:get_PS(PlayerId),
	mod_battle:start_3v3_robot(PS, OfflineBo, fun cross_pk_callback/2).



%如果加测到人数超过两队进入战斗安排
arrange_players_to_battle(PlayerIds) ->
	%% 	分队,两人为一组
	Pairs = grouping(PlayerIds),
	
	lists:foreach(fun show_battle_info/1, Pairs),
	timer:sleep(2900),
	%进入战斗
	lists:foreach(fun start_3V3/1, Pairs),
	
	%% 	  Player_Ids = [1,2,3,4] 长度为二的倍数 ， 截取两个即可进入战斗 
	%发送给玩家 双方的头像展示  lists:foreach(fun show_rival/1, Pairs),
	?DEBUG_MSG("aaaaaaa ~p~n",[Pairs]).



show_battle_info({P1, P2}) ->
	show_battle_info(P1, P2),
	show_battle_info(P2, P1).

show_battle_info(PlayerId1, PlayerId2) ->
	[OpponentRoom] = ets:lookup(?ETS_PVP_MATCH_ROOM, PlayerId2),
	OpponentTeams = OpponentRoom#match_room.teammates,
	AllOpponentList = [PlayerId2|OpponentTeams],
	
	OpponentF = fun(X , Acc0) ->
						%不在线pid返回null  ets:delete(ets_pvp_3v3_room).
						case player:get_pid(X) of
							null ->
								Player_Status =  ply_tmplogout_cache:get_tmplogout_PS(X),			
								%玩家离线数据跨服一个钟前的数据，确保能找到且符合最新的数据
								[{player:get_faction(Player_Status),player:get_sex(Player_Status)} | Acc0];
							_Pid ->
								[{player:get_faction(X),player:get_sex(X)} | Acc0]
						end
				end,																			
	OpponentList = lists:foldl(OpponentF, [], AllOpponentList),
	
	[SelfRoom] = ets:lookup(?ETS_PVP_MATCH_ROOM, PlayerId1),
	SelfTeams = SelfRoom#match_room.teammates,
	AllSelfList = [PlayerId1|SelfTeams],
	SelfF = fun(X , Acc0) ->
					%不在线pid返回null
					[PlayerCrossData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, X),
					Dan = PlayerCrossData#pvp_cross_player_data.dan,
					case player:get_pid(X) of
						null ->
							Player_Status =  ply_tmplogout_cache:get_tmplogout_PS(X),							
							Partner = lib_partner:get_partner( player:get_main_partner_id(Player_Status)),
							PartnerNo = lib_partner:get_no(Partner),
							PartnerLv = lib_partner:get_lv(Partner),
							%玩家离线数据跨服一个钟前的数据，确保能找到且符合最新的数据
							[{ player:get_name(Player_Status), player:get_faction(Player_Status),player:get_sex(Player_Status),Dan,PartnerNo,PartnerLv} | Acc0];
						_Pid ->
							%获取玩家的主宠	
							Player_Status = player:get_PS(X),							
							Partner = lib_partner:get_partner( player:get_main_partner_id(Player_Status)),
							PartnerNo = lib_partner:get_no(Partner),
							PartnerLv = lib_partner:get_lv(Partner),
							[{player:get_name(X),player:get_faction(X),player:get_sex(X),Dan,PartnerNo,PartnerLv} | Acc0]
					end
			end,																			
	SelfList = lists:foldl(SelfF, [], AllSelfList),
	F = fun(PlayerId) ->
				{ok, Bin} = pt_43:write(?PT_READY_CROSS_3V3, [ SelfList, OpponentList]),
				lib_send:send_to_uid(PlayerId, Bin)
		end,
	[F(X) || X <- AllSelfList].


show_battle_robot_info(PlayerId , ShowName) ->
	[MatchRoom] = ets:lookup(?ETS_PVP_MATCH_ROOM, PlayerId), 
	case MatchRoom#match_room.counters of
		1 ->
			OpponentData = {player:get_faction(PlayerId ),player:get_sex(PlayerId)},
			OpponentLists = [OpponentData, OpponentData, OpponentData],
			[PlayerCrossData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId),
			Dan = PlayerCrossData#pvp_cross_player_data.dan,
			MyselfData = case player:get_pid(PlayerId) of
							 null ->
								 Player_Status =  ply_tmplogout_cache:get_tmplogout_PS(PlayerId),							
								 Partner = lib_partner:get_partner( player:get_main_partner_id(Player_Status)),
								 PartnerNo = lib_partner:get_no(Partner),
								 PartnerLv = lib_partner:get_lv(Partner),
								 %玩家离线数据跨服一个钟前的数据，确保能找到且符合最新的数据
								 [ player:get_faction(Player_Status),player:get_sex(Player_Status),Dan,PartnerNo,PartnerLv];
							 _Pid ->
								 %获取玩家的主宠	
								 Player_Status = player:get_PS(PlayerId),							
								 Partner = lib_partner:get_partner( player:get_main_partner_id(Player_Status)),
								 PartnerNo = lib_partner:get_no(Partner),
								 PartnerLv = lib_partner:get_lv(Partner),
								 [ player:get_faction(PlayerId),player:get_sex(PlayerId),Dan,PartnerNo,PartnerLv]
						 end,
			[Name1,Name2,_] = ShowName,
			MyselfData1 = list_to_tuple([ player:get_name(PlayerId)| MyselfData]),
			MyselfData2 = list_to_tuple([ list_to_binary(Name1)  | MyselfData]),
			MyselfData3 = list_to_tuple([ list_to_binary(Name2)  | MyselfData]),
			
			MyselfLists = [MyselfData1, MyselfData2, MyselfData3],
			{ok, Bin} = pt_43:write(?PT_READY_CROSS_3V3, [ MyselfLists, OpponentLists]),
			lib_send:send_to_uid(PlayerId, Bin);
		2 ->
			%按照高段位的生成机器人对方两个，低段位一个。自己方是低段位的一个
			[TeamMateId] = MatchRoom#match_room.teammates,
			[PlayerCrossData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId),
			Dan = PlayerCrossData#pvp_cross_player_data.dan,
			OpponentData = {player:get_faction(PlayerId),player:get_sex(PlayerId)},
			[Name , IsOne] = ShowName,
			MyselfData = case player:get_pid(PlayerId) of
							 null ->
								 Player_Status =  ply_tmplogout_cache:get_tmplogout_PS(PlayerId),							
								 Partner = lib_partner:get_partner( player:get_main_partner_id(Player_Status)),
								 PartnerNo = lib_partner:get_no(Partner),
								 PartnerLv = lib_partner:get_lv(Partner),
								 %玩家离线数据跨服一个钟前的数据，确保能找到且符合最新的数据
								 { player:get_name(Player_Status), player:get_faction(Player_Status),player:get_sex(Player_Status),Dan,PartnerNo,PartnerLv};
							 _Pid ->
								 %获取玩家的主宠	
								 Player_Status = player:get_PS(PlayerId),							
								 Partner = lib_partner:get_partner( player:get_main_partner_id(Player_Status)),
								 PartnerNo = lib_partner:get_no(Partner),
								 PartnerLv = lib_partner:get_lv(Partner),
								 {player:get_name(PlayerId),player:get_faction(PlayerId),player:get_sex(PlayerId),Dan,PartnerNo,PartnerLv}
						 end,
			
			
			[PlayerCrossData2] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, TeamMateId),
			Dan2 = PlayerCrossData2#pvp_cross_player_data.dan,
			OpponentData2 = {player:get_faction(TeamMateId),player:get_sex(TeamMateId)},
			MyselfData2 = case player:get_pid(TeamMateId) of
							  null ->
								  Player_Status2 =  ply_tmplogout_cache:get_tmplogout_PS(TeamMateId),							
								  Partner2 = lib_partner:get_partner( player:get_main_partner_id(Player_Status2)),
								  PartnerNo2 = lib_partner:get_no(Partner2),
								  PartnerLv2 = lib_partner:get_lv(Partner2),
								  %玩家离线数据跨服一个钟前的数据，确保能找到且符合最新的数据
								  { player:get_name(Player_Status2), player:get_faction(Player_Status2),player:get_sex(Player_Status2),Dan2,PartnerNo2,PartnerLv2};
							  _Pid2 ->
								  %获取玩家的主宠	
								  Player_Status2 = player:get_PS(TeamMateId),							
								  Partner2 = lib_partner:get_partner( player:get_main_partner_id(Player_Status2)),
								  PartnerNo2 = lib_partner:get_no(Partner2),
								  PartnerLv2 = lib_partner:get_lv(Partner2),
								  {player:get_name(TeamMateId),player:get_faction(TeamMateId),player:get_sex(TeamMateId),Dan2,PartnerNo2,PartnerLv2}
						  end,
			
			OpponentLists = case IsOne of
								true ->
									[OpponentData,OpponentData,OpponentData2];
								false ->
									[OpponentData,OpponentData2,OpponentData2]
							end,
			
			
			MyselfData3 = case IsOne of
							  true ->
								  MyselfDataList = tuple_to_list(MyselfData),
								  [_ | T]  =MyselfDataList,
								  MyselfDataList2 = [list_to_binary(Name) | T],
								  list_to_tuple(MyselfDataList2);
							  false ->
								  MyselfDataList = tuple_to_list(MyselfData2),
								  [_ | T]  =MyselfDataList,
								  MyselfDataList2 = [list_to_binary(Name) | T],
								  list_to_tuple(MyselfDataList2)
						  end,
			
			
			MyselfLists = [MyselfData,MyselfData2,MyselfData3] ,
			
			{ok, Bin} = pt_43:write(?PT_READY_CROSS_3V3, [ MyselfLists, OpponentLists]),
			lib_send:send_to_uid(TeamMateId, Bin),
			lib_send:send_to_uid(PlayerId, Bin);
		3 ->
			%最高战力的1个，中间战力2个
			[TeamMateId1, TeamMateId2] = MatchRoom#match_room.teammates,			
			BattlePower1 = ply_attr:get_battle_power(PlayerId),
			BattlePower2 = ply_attr:get_battle_power(TeamMateId1),
			BattlePower3 = ply_attr:get_battle_power(TeamMateId2),
			PowerSortLists = [{PlayerId,BattlePower1},{TeamMateId1,BattlePower2},{TeamMateId2,BattlePower3}],
			[_, {NeedId1, _}, {NeedId2, _} ] = lists:keysort(2, PowerSortLists),
			OpponentData1 = {player:get_faction(NeedId1),player:get_sex(NeedId1)},
			OpponentData2 =  {player:get_faction(NeedId2),player:get_sex(NeedId2)},
			OpponentLists = [OpponentData1,OpponentData1,OpponentData2],
			SelfTeams = MatchRoom#match_room.teammates,
			AllSelfList = [PlayerId|SelfTeams],
			SelfF = fun(X , Acc0) ->
							%不在线pid返回null
							[PlayerCrossData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, X),
							Dan = PlayerCrossData#pvp_cross_player_data.dan,
							case player:get_pid(X) of
								null ->
									Player_Status =  ply_tmplogout_cache:get_tmplogout_PS(X),							
									Partner = lib_partner:get_partner( player:get_main_partner_id(Player_Status)),
									PartnerNo = lib_partner:get_no(Partner),
									PartnerLv = lib_partner:get_lv(Partner),
									%玩家离线数据跨服一个钟前的数据，确保能找到且符合最新的数据
									[{ player:get_name(Player_Status), player:get_faction(Player_Status),player:get_sex(Player_Status),Dan,PartnerNo,PartnerLv} | Acc0];
								_Pid ->
									%获取玩家的主宠	
									Player_Status = player:get_PS(X),							
									Partner = lib_partner:get_partner( player:get_main_partner_id(Player_Status)),
									PartnerNo = lib_partner:get_no(Partner),
									PartnerLv = lib_partner:get_lv(Partner),
									[{player:get_name(X),player:get_faction(X),player:get_sex(X),Dan,PartnerNo,PartnerLv} | Acc0]
							end
					end,																			
			SelfList = lists:foldl(SelfF, [], AllSelfList),
			{ok, Bin} = pt_43:write(?PT_READY_CROSS_3V3, [ SelfList, OpponentLists]),
			lib_send:send_to_uid(TeamMateId1, Bin),
			lib_send:send_to_uid(PlayerId, Bin),
			lib_send:send_to_uid(TeamMateId2, Bin)
	
	end.





start_3V3({P1, P2}) ->
	
	PS1 = player:get_PS(P1),
	PS2 = player:get_PS(P2),
	[RoomData1] =  ets:lookup(?ETS_PVP_MATCH_ROOM, P1),
	[RoomData2] =  ets:lookup(?ETS_PVP_MATCH_ROOM, P2),
	[PlayerData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, P1),
	ServerId  =  PlayerData#pvp_cross_player_data.server_id,
	[PlayerData2] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, P2),
	ServerId2  =  PlayerData2#pvp_cross_player_data.server_id,
	sm_cross_server:rpc_call(ServerId, player, mark_cross_remote, [P1]),
	sm_cross_server:rpc_call(ServerId2, player, mark_cross_remote, [P2]),
	case player:is_online(player:id(PS1)) andalso
			 player:is_online(player:id(PS2)) of
		true ->			
			Team1 = RoomData1#match_room.teammates,
			Team2 = RoomData2#match_room.teammates,
			F = fun(X) ->
						[PlayerData3] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, X),
						ServerId3  =  PlayerData3#pvp_cross_player_data.server_id,
						sm_cross_server:rpc_call(ServerId3, player, mark_cross_remote, [X])
				end,
			lists:foreach(F, Team1),
			lists:foreach(F, Team2),
			try mod_battle:start_cross_3v3_pk(PS1, PS2, fun cross_pk_callback/2)
			catch R:E ->
					  
					  ?ERROR_MSG("{E,R,erlang:get_stacktrace()} : ~p~n", [{E,R,erlang:get_stacktrace()}])
			end;
		fasle ->
			Team1 = RoomData1#match_room.teammates ++ P1,
			Team2 = RoomData2#match_room.teammates ++ P2,
			ets:delete(?ETS_PVP_MATCH_ROOM, P1),
			ets:delete(?ETS_PVP_MATCH_ROOM, P2),
			[lib_send:send_prompt_msg(X, ?PM_TARGET_PLAYER_NOT_ONLINE)|| X <- Team1 ],
			[lib_send:send_prompt_msg(X, ?PM_TARGET_PLAYER_NOT_ONLINE)|| X <- Team2],
			?ERROR_MSG("Cross 3V3 start_3V3 error ~n", []),
			skip
	end.




cacul_get_score(Poor, Times,Type) ->
	SttlementInfo = data_ranking3v3_settlement:get(Times),
	Min = SttlementInfo#ranking3v3_settlement.min,
	Max = SttlementInfo#ranking3v3_settlement.max,
	case  Poor  >= Min andalso Poor =< Max of
		true -> 
			BonusPoints = SttlementInfo#ranking3v3_settlement.bonus_points,
			Minus_points = SttlementInfo#ranking3v3_settlement.minus_points,
			case Type of
				lose ->
					Minus_points;
				win ->
					BonusPoints
			end;
		
		
		false ->
			cacul_get_score(Poor, Times + 1,Type)
	end.



cross_pk_callback(UID, Feedback) ->
	ets:delete(?ETS_PVP_MATCH_ROOM, UID),
	ServerId = player:get_server_id(player:get_PS(UID)),
	sm_cross_server:rpc_cast(ServerId, player, mark_cross_local, [UID]),
	case Feedback#btl_feedback.result of
		lose ->
			OppoList = Feedback#btl_feedback.oppo_player_id_list,
			OppoFun = fun(X,Acc) ->
							  case ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, X) of
								  [] ->  0 + Acc ;
								  [R] -> R#pvp_cross_player_data.score + Acc
							  end
					  end,									  
			OppoScore = lists:foldl(OppoFun, 0, OppoList),
			
			TeamList = Feedback#btl_feedback.teammate_id_list,
			
			TeamFun = fun(X,Acc) ->
							  case ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, X) of
								  [] ->  0 + Acc ;
								  [R] ->  R#pvp_cross_player_data.score + Acc
							  end
					  end,									  
			TeamScore = lists:foldl(TeamFun, 0, TeamList),
			
			Poor = case OppoScore of
					   0 ->
						   OppoScore;
					   _ ->
						   OppoScore - TeamScore
				   end,
			[PlayerCrossData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, UID),
			RealDan = PlayerCrossData#pvp_cross_player_data.dan,
			Score1 =case RealDan < 6 of
						true ->
							0;
						false ->
							cacul_get_score(Poor,1,lose)
					end,
			Score2 = 
				case  (PlayerCrossData#pvp_cross_player_data.score - Score1) < 0  of
					true ->
						1;
					false ->
						PlayerCrossData#pvp_cross_player_data.score - Score1
				end,
			
			
			case ets:lookup(ets_3v3_escape, UID) of
				[{_,1}] ->
					Score3 = 
						case Score2 =:= 0 of
							true ->
								0;
							false ->
								case PlayerCrossData#pvp_cross_player_data.score - 15 >= 0 of
									true -> PlayerCrossData#pvp_cross_player_data.score - 15;
									false -> 1
								end
						end,
					ReduceScore = case PlayerCrossData#pvp_cross_player_data.score - 15 >= 0 of
									  true ->
										  15;
									  false ->
										  PlayerCrossData#pvp_cross_player_data.score
								  end,
					
					ets:insert(ets_3v3_escape, {UID,0}),
					case  PlayerCrossData#pvp_cross_player_data.dan > 31 of
						true ->
							{ok, Bin} = pt_43:write(?PT_CROSS_3V3_RESULT, [ 0,ReduceScore,  PlayerCrossData#pvp_cross_player_data.dan ]),
							lib_send:send_to_uid(UID, Bin),
							lib_pvp:update_pvp_player_info_from_battle(UID, 1,  PlayerCrossData#pvp_cross_player_data.dan, Score3, [], 0);
						false ->
							
							Dan = lib_pvp:get_dan_by_score(Score3),	
							{ok, Bin} = pt_43:write(?PT_CROSS_3V3_RESULT, [ 0,ReduceScore, Dan ]),
							lib_send:send_to_uid(UID, Bin),
							lib_pvp:update_pvp_player_info_from_battle(UID, 1, Dan, Score3, [], 0)
					end;
				_->
					case  PlayerCrossData#pvp_cross_player_data.dan > 31 of
						true ->
							lib_pvp:update_pvp_player_info_from_battle(UID, 1, PlayerCrossData#pvp_cross_player_data.dan, Score2, [], 1),
							
							{ok, Bin} = pt_43:write(?PT_CROSS_3V3_RESULT, [ 0,Score1, PlayerCrossData#pvp_cross_player_data.dan ]),
							lib_send:send_to_uid(UID, Bin);
						false ->
							
							Dan = lib_pvp:get_dan_by_score(Score2),	
							lib_pvp:update_pvp_player_info_from_battle(UID, 1, Dan, Score2, [], 1),
							
							{ok, Bin} = pt_43:write(?PT_CROSS_3V3_RESULT, [ 0,Score1, Dan ]),
							lib_send:send_to_uid(UID, Bin)
					end
					
			end;
		win ->
			OppoList = Feedback#btl_feedback.oppo_player_id_list,
			OppoFun = fun(X,Acc) ->
							  case ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, X) of
								  [] ->  0 + Acc ;
								  [R] -> R#pvp_cross_player_data.score + Acc
							  end
					  end,									  
			OppoScore = lists:foldl(OppoFun, 0, OppoList),
			
			TeamList = Feedback#btl_feedback.teammate_id_list,
			
			TeamFun = fun(X,Acc) ->
							  case ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, X) of
								  [] ->  0 + Acc ;
								  [R] ->  R#pvp_cross_player_data.score + Acc
							  end
					  end,									  
			TeamScore = lists:foldl(TeamFun, 0, TeamList),
			
			Poor = case OppoScore of
					   0 ->
						   OppoScore;
					   _ ->
						   OppoScore - TeamScore
				   end,
			
			Score1 =cacul_get_score(Poor,1,win),
			[PlayerCrossData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, UID),
			Score2 = PlayerCrossData#pvp_cross_player_data.score + Score1,
			Dan = lib_pvp:get_dan_by_score(Score2),
			OldDan = PlayerCrossData#pvp_cross_player_data.dan,
			NewReward = case (Dan - OldDan) > 0 orelse Dan == 1 of
							true ->
								%检测一下是否已经领取过奖励
								Reward = PlayerCrossData#pvp_cross_player_data.reward,
								case lists:member(Dan, Reward) of
									true ->
										
										PlayerCrossData#pvp_cross_player_data.reward;
									false ->
										ScoreRewardInfo =  data_ranking3v3_score:get(Dan),
										PackageNo = ScoreRewardInfo#ranking3v3_score.reward,
										PackageInfo = data_reward_pkg:get(PackageNo),
										ModifyGoods = PackageInfo#reward_pkg.goods_list,
										F = fun({_Q, GoodsNo, Count, _Z , _B}, Acc) ->
													[{GoodsNo,1,Count}|Acc]
											end,	
										GoodsList = lists:foldl(F, [], ModifyGoods),
										Title = "段位奖励邮件",
										Title2 = unicode:characters_to_list(Title,utf8),
										Name = ScoreRewardInfo#ranking3v3_score.name,
										Content =lists:concat(["恭喜少侠段位达到",binary_to_list(Name), ",在此为您奉上段位奖励~希望能再看到您更出色的表现"]),
										Content2 = unicode:characters_to_list(Content,utf8),
										sm_cross_server:rpc_call( PlayerCrossData#pvp_cross_player_data.server_id, lib_mail, send_sys_mail, [UID, util:to_binary(Title2), util:to_binary(Content2), GoodsList, ["Duanwei","finishDuanwei"]]),
										[Dan|Reward]
								end;
							false ->
								PlayerCrossData#pvp_cross_player_data.reward
						end,

			% (0：赢    1：输     2：逃跑)
			case  PlayerCrossData#pvp_cross_player_data.dan > 31 of
				true ->
					lib_pvp:update_pvp_player_info_from_battle(UID,0, PlayerCrossData#pvp_cross_player_data.dan, Score2,NewReward,1),
					{ok, Bin} = pt_43:write(?PT_CROSS_3V3_RESULT, [ 1,Score1, PlayerCrossData#pvp_cross_player_data.dan ]),
					lib_send:send_to_uid(UID, Bin);
				false ->
					
					lib_pvp:update_pvp_player_info_from_battle(UID,0, Dan, Score2,NewReward,1),
					{ok, Bin} = pt_43:write(?PT_CROSS_3V3_RESULT, [ 1,Score1, Dan ]),
					lib_send:send_to_uid(UID, Bin)
			end;

		_ ->skip
	end,
	
	case lib_pvp:get_room_by_captain_id(UID) of
		null ->
			skip;
		Room ->
			NewRoom = Room#room{state = 0},
			lib_pvp:update_room_to_ets(NewRoom),
			F2 = fun(PlayerId, Acc) ->
						 PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
						 NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{status = 1},
						 lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo),
						 case lib_pvp:is_captain(PlayerId) of
							 true ->
								 Acc;
							 false ->
								 [{PlayerId, NewPvpPlyInfo#pvp_cross_player_data.status} | Acc]
						 end
				 end,
			List = lists:foldl(F2, [], Room#room.teammates ++ [Room#room.captain]),
			{ok, BinData} = pt_43:write(?PT_PVP_CROSS_PLAYER_PREPARE, [List]),
			lib_pvp:send_message_to_all_players_in_room(NewRoom, BinData)
	end.

%%匹配超时，如果玩家一个人则生成五个机器人，如果玩家两人组，则生成各取二的数据生成机器人， 如果玩家三人组则各取一的数据生成机器人
matching_overtime(MatchRoomRec) ->
	%先生成数据，确认战斗的环境数据
	Counter = MatchRoomRec#match_room.counters,
	PlayerId = MatchRoomRec#match_room.captain,
	Teammates = MatchRoomRec#match_room.teammates,
	case Counter of
		1 ->	
			PS = player:get_PS(PlayerId),
			lib_cross:init_offline_bo(PS),
			MainPartner = player:get_main_partner_id(PS),
			case ets:lookup(?ETS_OFFLINE_BO, {PlayerId,1,26}) of
				[] -> ?ERROR_MSG("cross_3v3_match:matching_overtime mod_offline_data:get_offline_bo is null  error!~n", []);
				[Bo] ->
					%随机取出五个人物名字
					Index = length(?RANDOM_NAME_PLAYER) - 5,
					Start = random:uniform(Index),
					[Name1, Name2, Name3, Name4, Name5] = lists:sublist(?RANDOM_NAME_PLAYER, Start, 5),
					ChangePartner =  MainPartner + 100000000, %加一亿确保唯一
					ChangePlayer =   PlayerId + 10000000, %加一千万确保唯一
					OfflineBo1 = Bo#offline_bo{key = {ChangePlayer , 1, 26}, name = list_to_binary(Name1) , partners = [ChangePartner]},
					ets:insert(?ETS_OFFLINE_BO, OfflineBo1),
					
					ShowInfoName = [Name1, Name2, Name3],
					
					ChangePartner2 =  MainPartner + 200000000,
					ChangePlayer2 =   PlayerId +20000000,
					OfflineBo2 = Bo#offline_bo{key = {ChangePlayer2 , 1, 26}, name =list_to_binary(Name2) , partners = [ChangePartner2]},
					ets:insert(?ETS_OFFLINE_BO, OfflineBo2),
					
					%修改boy +player,Id 10000000 * n  
					ChangePartner3 =  MainPartner + 300000000,
					ChangePlayer3 =   PlayerId +30000000,
					OfflineBo3 = Bo#offline_bo{key = {ChangePlayer3 , 1, 26}, name = list_to_binary(Name3) , partners = [ChangePartner3]},
					
					ets:insert(?ETS_OFFLINE_BO, OfflineBo3),
					ChangePartner4 =  MainPartner + 400000000,
					ChangePlayer4 =   PlayerId +40000000,
					OfflineBo4 = Bo#offline_bo{key = {ChangePlayer4 , 1, 26}, name = list_to_binary(Name4) , partners = [ChangePartner4]},
					ets:insert(?ETS_OFFLINE_BO, OfflineBo4),
					
					ChangePartner5 =  MainPartner + 500000000,
					ChangePlayer5 =   PlayerId +50000000,
					OfflineBo5 = Bo#offline_bo{key = {ChangePlayer5 , 1, 26}, name = list_to_binary(Name5) , partners = [ChangePartner5]},
					ets:insert(?ETS_OFFLINE_BO, OfflineBo5),
					%随机取出五个门客名字
					Index2 = length(?RANDOM_NAME_PARTNER) - 5,
					Start2 = random:uniform(Index2),
					[PartnerName1, PartnerName2, PartnerName3, PartnerName4, PartnerName5] = lists:sublist(?RANDOM_NAME_PARTNER, Start2, 5),
					%修改门客数据
					Partner = lib_partner:get_partner( MainPartner),
					ChangePartnerRec1 = Partner#partner{id = ChangePartner,  name = list_to_binary(PartnerName1) , player_id = ChangePlayer },
					ets:insert(?ETS_PARTNER, ChangePartnerRec1),
					ChangePartnerRec2 = Partner#partner{id = ChangePartner2, name = list_to_binary(PartnerName2) , player_id = ChangePlayer2 },
					ets:insert(?ETS_PARTNER, ChangePartnerRec2),
					ChangePartnerRec3 = Partner#partner{id = ChangePartner3, name = list_to_binary(PartnerName3) , player_id = ChangePlayer3 },
					ets:insert(?ETS_PARTNER, ChangePartnerRec3),
					ChangePartnerRec4 = Partner#partner{id = ChangePartner4, name = list_to_binary(PartnerName4) ,player_id = ChangePlayer4 },
					ets:insert(?ETS_PARTNER, ChangePartnerRec4),
					ChangePartnerRec5 = Partner#partner{id = ChangePartner5, name = list_to_binary(PartnerName5) ,player_id = ChangePlayer5 },
					ets:insert(?ETS_PARTNER, ChangePartnerRec5),
					%进入战斗
					proc_lib:spawn(fun() -> arrange_robot_to_battle(PlayerId,OfflineBo3,ShowInfoName) end)
			
			end;
		2 ->
			%按照高段位的生成机器人对方两个，低段位一个。自己方是低段位的一个
			PS = player:get_PS(PlayerId),
			MainPartner = player:get_main_partner_id(PS),
			lib_cross:init_offline_bo(PS),
			[PlayerId2] = Teammates,
			PS2 = player:get_PS(PlayerId2),
			MainPartner2 = player:get_main_partner_id(PS2),
			lib_cross:init_offline_bo(PS2),
			double_match_robot(PlayerId, PlayerId2, MainPartner, MainPartner2, PS);
		3 ->
			PS = player:get_PS(PlayerId),
			MainPartner = player:get_main_partner_id(PS),
			%随机取出3个人物名字
			Index = length(?RANDOM_NAME_PLAYER) - 3,
			Start = random:uniform(Index),
			[Name1, Name2, Name3] = lists:sublist(?RANDOM_NAME_PLAYER, Start, 3),
			[TeamId2, TeamId3 ] = Teammates,
			TeamPower1 = ply_attr:get_battle_power(PlayerId),
			TeamPower2 = ply_attr:get_battle_power(TeamId2),
			TeamPower3 = ply_attr:get_battle_power(TeamId3),
			BattlePowers = [{PlayerId, TeamPower1}, {TeamId2, TeamPower2}, {TeamId3, TeamPower3}],
			%排序
			BattlePowerLists = lists:keysort(2, BattlePowers),
			[_ , {CopyPlayer, _}, {CopyPlayer2, _}] = BattlePowerLists,
			
			PS2 = player:get_PS(CopyPlayer2),
			MainPartner2 = player:get_main_partner_id(PS2),
			PS3 = player:get_PS(CopyPlayer),
			MainPartner3 = player:get_main_partner_id(PS3),
			lib_cross:init_offline_bo(PS2),
			lib_cross:init_offline_bo(PS3),
			
			[Bo] = ets:lookup(?ETS_OFFLINE_BO, {CopyPlayer2,1,26}),
			
			ChangePartner =  MainPartner + 100000000, %加一亿确保唯一
			ChangePlayer =   PlayerId + 10000000, %加一千万确保唯一
			OfflineBo1 = Bo#offline_bo{key = {ChangePlayer , 1, 26}, name = list_to_binary(Name1) , partners = [ChangePartner]},
			ets:insert(?ETS_OFFLINE_BO, OfflineBo1),
			
			ChangePartner2 =  MainPartner + 200000000,
			ChangePlayer2 =   PlayerId +20000000,
			OfflineBo2 = Bo#offline_bo{key = {ChangePlayer2 , 1, 26}, name =list_to_binary(Name2) , partners = [ChangePartner2]},
			ets:insert(?ETS_OFFLINE_BO, OfflineBo2),
			
			[Bo2] =  ets:lookup(?ETS_OFFLINE_BO, {CopyPlayer,1,26}) ,
			
			%修改boy +player,Id 10000000 * n  
			ChangePartner3 =  MainPartner + 300000000,
			ChangePlayer3 =   PlayerId +30000000,
			OfflineBo3 = Bo2#offline_bo{key = {ChangePlayer3 , 1, 26}, name = list_to_binary(Name3) , partners = [ChangePartner3]},
			ets:insert(?ETS_OFFLINE_BO, OfflineBo3),
			
			
			%随机取出3个门客名字
			Index2 = length(?RANDOM_NAME_PARTNER) - 3,
			Start2 = random:uniform(Index2),
			[PartnerName1, PartnerName2, PartnerName3] = lists:sublist(?RANDOM_NAME_PARTNER, Start2, 3),
			%修改门客数据
			Partner = lib_partner:get_partner(MainPartner2),
			%修改门客数据2
			Partner2 = lib_partner:get_partner(MainPartner3),
			ChangePartnerRec1 = Partner#partner{id = ChangePartner,  name = list_to_binary(PartnerName1) , player_id = ChangePlayer },
			ets:insert(?ETS_PARTNER, ChangePartnerRec1),
			ChangePartnerRec2 = Partner#partner{id = ChangePartner2, name = list_to_binary(PartnerName2) , player_id = ChangePlayer2 },
			ets:insert(?ETS_PARTNER, ChangePartnerRec2),
			ChangePartnerRec3 = Partner2#partner{id = ChangePartner3, name = list_to_binary(PartnerName3) , player_id = ChangePlayer3 },
			ets:insert(?ETS_PARTNER, ChangePartnerRec3),
			proc_lib:spawn(fun() -> arrange_robot_to_battle(PlayerId,OfflineBo3,[]) end)
	
	
	end.


%双排遇到机器人
double_match_robot(PlayerId, PlayerId2, MainPartner, MainPartner2, _PS) ->
	
	case ets:lookup(?ETS_OFFLINE_BO, {PlayerId,1,26}) of
		[] -> ?ERROR_MSG("cross_3v3_match:matching_overtime mod_offline_data:get_offline_bo is null  error!~n", []);
		[Bo] ->
			%随机取出4个人物名字
			Index = length(?RANDOM_NAME_PLAYER) - 4,
			Start = random:uniform(Index),
			[Name1, Name2, Name3,Name4] = lists:sublist(?RANDOM_NAME_PLAYER, Start, 4),
			ChangePartner =  MainPartner + 100000000, %加一亿确保唯一
			ChangePlayer =   PlayerId + 10000000, %加一千万确保唯一
			OfflineBo1 = Bo#offline_bo{key = {ChangePlayer , 1, 26}, name = list_to_binary(Name1) , partners = [ChangePartner]},
			ets:insert(?ETS_OFFLINE_BO, OfflineBo1),
			
			ChangePartner2 =  MainPartner + 200000000,
			ChangePlayer2 =   PlayerId +20000000,
			OfflineBo2 = Bo#offline_bo{key = {ChangePlayer2 , 1, 26}, name =list_to_binary(Name2) , partners = [ChangePartner2]},
			ets:insert(?ETS_OFFLINE_BO, OfflineBo2),
			
			[PlayerIdData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId),
			[PlayerIdData2] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId2),
			
			Score = PlayerIdData#pvp_cross_player_data.score,
			Score2 = PlayerIdData2#pvp_cross_player_data.score,
			
			
			
			[Bo2] = ets:lookup(?ETS_OFFLINE_BO, {PlayerId2,1,26}),
			
			%修改boy +player,Id 10000000 * n  
			ChangePartner3 =  MainPartner + 300000000,
			ChangePlayer3 =   PlayerId +30000000,
			OfflineBo3 = Bo2#offline_bo{key = {ChangePlayer3 , 1, 26}, name = list_to_binary(Name3) , partners = [ChangePartner3]},
			ets:insert(?ETS_OFFLINE_BO, OfflineBo3),
			%修改boy +player,Id 10000000 * n  
			ChangePartner4 =  MainPartner + 400000000,
			ChangePlayer4 =   PlayerId +40000000,
			OfflineBo4 = Bo2#offline_bo{key = {ChangePlayer4 , 1, 26}, name = list_to_binary(Name4) , partners = [ChangePartner4]},
			ets:insert(?ETS_OFFLINE_BO, OfflineBo4),
			
			%随机取出3个门客名字
			Index2 = length(?RANDOM_NAME_PARTNER) - 4,
			Start2 = random:uniform(Index2),
			[PartnerName1, PartnerName2, PartnerName3, PartnerName4] = lists:sublist(?RANDOM_NAME_PARTNER, Start2, 4),
			%修改门客数据
			Partner = lib_partner:get_partner(MainPartner),
			%修改门客数据2
			Partner2 = lib_partner:get_partner(MainPartner2),
			ChangePartnerRec1 = Partner#partner{id = ChangePartner,  name = list_to_binary(PartnerName1) , player_id = ChangePlayer },
			ets:insert(?ETS_PARTNER, ChangePartnerRec1),
			ChangePartnerRec2 = Partner#partner{id = ChangePartner2, name = list_to_binary(PartnerName2) , player_id = ChangePlayer2 },
			ets:insert(?ETS_PARTNER, ChangePartnerRec2),
			ChangePartnerRec3 = Partner2#partner{id = ChangePartner3, name = list_to_binary(PartnerName3) , player_id = ChangePlayer3 },
			ets:insert(?ETS_PARTNER, ChangePartnerRec3),
			ChangePartnerRec4 = Partner2#partner{id = ChangePartner4, name = list_to_binary(PartnerName4) ,player_id = ChangePlayer4 },
			ets:insert(?ETS_PARTNER, ChangePartnerRec4),
			ShowInfoName =case Score > Score2 of
							  true ->	  
								  [Name4,true];
							  false ->
								  [Name2,false]
						  end,
			
			%进入战斗
			proc_lib:spawn(fun() -> arrange_robot_to_battle(PlayerId,OfflineBo3, ShowInfoName) end)
	end.


choose_type_pool(SupPool,Type) ->
	%% 	Type = 1.青铜  2.白银  3.黄金  4.铂金  5.钻石  6.无双  7.王者 8.传奇
	SupFun = fun(PoolLists) ->
					 Is_PlayerId = PoolLists#room.captain,
					 ExistData = ets:lookup(?ETS_PVP_MATCH_ROOM, Is_PlayerId),
					 io:format("TestMatchRoomIsDelete ~p ~n", [ExistData]),
					 IsExistData = (length(ExistData) == 0) ,
					 [SupPoolData] = ets:lookup(?ETS_PVP_3V3_SUP_POOL, Type),
					 NeedModifyPool = SupPoolData#sup_pool.pool,
					 {value,_,NeedModifyPool2} = lists:keytake(Is_PlayerId, 2, NeedModifyPool),
					 SupPoolData2 =  SupPoolData#sup_pool{pool =NeedModifyPool2},
					 ets:insert(?ETS_PVP_3V3_SUP_POOL, SupPoolData2),
					 case IsExistData andalso PoolLists#room.counters > 0  of
						 true -> 
							 ChangeTypePool = ets:lookup(?CROSS_TYPE_POOL, {Type,PoolLists#room.counters}),
							 case length(ChangeTypePool) == 0 of
								 true ->
									 case PoolLists#room.counters == 3 of
										 true ->
											 MatchRoomRec = #match_room{captain=Is_PlayerId, teammates =PoolLists#room.teammates, timestamp = PoolLists#room.timestamp, counters = 3,cur_troop =PoolLists#room.cur_troop  },
											 ets:insert(?ETS_PVP_MATCH_ROOM, MatchRoomRec);
										 false ->
											 skip
									 end,
									 ets:insert(?CROSS_TYPE_POOL, #type_pool{type = {Type,PoolLists#room.counters}, player_id =[PoolLists#room.captain] });
								 false ->	 
									 [TypePool] = ChangeTypePool,
									 case lists:member(PoolLists#room.captain, TypePool#type_pool.player_id) of
										 true->
											 skip;
										 false ->
											 case PoolLists#room.counters == 3 of
												 true ->
													 MatchRoomRec = #match_room{captain=Is_PlayerId, teammates =PoolLists#room.teammates, timestamp = PoolLists#room.timestamp, counters = 3,cur_troop = PoolLists#room.cur_troop  },
													 ets:insert(?ETS_PVP_MATCH_ROOM, MatchRoomRec);			 
												 false ->
													 skip
											 end,
											 ChangeTypePool2 = [PoolLists#room.captain|TypePool#type_pool.player_id],
											 ets:insert(?CROSS_TYPE_POOL, TypePool#type_pool{player_id =ChangeTypePool2 })
									 end
							 end;
						 false ->
							 skip
					 end
			 
			 end,
	lists:foreach(SupFun, SupPool).

match_rule(Type) ->
	%三排安排一下
	ThirdPool2 = ets:lookup(?CROSS_TYPE_POOL, {Type,3}),
	[ThirdPool] =case length(ThirdPool2) > 0 of
					 true -> ThirdPool2;
					 false -> [#type_pool{player_id = []}]
				 end,
	case length( ThirdPool#type_pool.player_id) > 0 of
		true ->
			[ThirdPlayerId | ThirdTail] = ThirdPool#type_pool.player_id,
			case length(ThirdTail) > 0 of
				true ->
					ets:insert(?CROSS_TYPE_POOL, ThirdPool#type_pool{player_id = ThirdTail}),
					ThirdPool3 = ThirdPool#type_pool{player_id = ThirdTail},
					matching_players(Type , ThirdPlayerId , ThirdPool3);
				false ->
					ets:delete(?CROSS_TYPE_POOL, {Type,3}),
					matching_players(Type , ThirdPlayerId , #type_pool{player_id = []})
			end;
		false -> skip
	end,
	
	%优先给双排的找队伍
	DoublePool2  = ets:lookup(?CROSS_TYPE_POOL, {Type,2}),
	[DoublePool] =case length(DoublePool2) > 0 of
					  true -> DoublePool2;
					  false -> [#type_pool{player_id = []}]
				  end,
	case  length(DoublePool#type_pool.player_id) > 0 of
		true ->			
			SinglePool2  = ets:lookup(?CROSS_TYPE_POOL, {Type,1}),	
			[SinglePool] =case length(SinglePool2) > 0 of
							  true -> SinglePool2;
							  false -> [#type_pool{player_id = []}]
						  end,
			case  length(SinglePool#type_pool.player_id) > 0 of
				true ->
					%拿出一个双人池的玩家
					[Double_Take_Player] = lists:sublist(DoublePool#type_pool.player_id, 1, 1),
					%拿出一个单人池的玩家
					[Single_Take_Player] = lists:sublist(SinglePool#type_pool.player_id, 1, 1),
					%更新总池
					%% 					BronzePool =SupPool#sup_pool.pool,
					%%                     [{room,1099600000000002,[],1550795198,1,570,1,0,1550795198,[],[],
					%%                     []},
					%%               {room,1888800000001752,
					%%                     [1099500000000001],
					%%                     1550795197,1,1205,2,1,1550795191,[],[],[]}]
					%%                     io:format("TestPoolData ~p ~n", [SupPool#sup_pool.pool]),
					%% 					BronzePool2 = lists:keydelete(Single_Take_Player, 2, BronzePool),
					%%                    
					%% 					BronzePoolChange = lists:keyfind(Double_Take_Player, 2, BronzePool2),
					
					%% 					BronzePoolChange2 =BronzePoolChange#room{teammates =[Single_Take_Player|BronzePoolChange#room.teammates], counters = 3 },
					[DoubleRoom] = ets:lookup(?ETS_PVP_3V3_ROOM, Double_Take_Player),
                    io:format("TestZhengFaData1 ~p ~n",[ DoubleRoom#room.cur_troop]),
					BronzePoolChange =#match_room{captain =Double_Take_Player,teammates =[Single_Take_Player|DoubleRoom#room.teammates], counters = 3,
												  timestamp= DoubleRoom#room.timestamp, cur_troop=DoubleRoom#room.cur_troop   },
					ets:insert(?ETS_PVP_MATCH_ROOM, BronzePoolChange),
					%% 					ets:delete(?ETS_PVP_3V3_ROOM, Single_Take_Player),
					%% 					ChangeSupPool2 =case lists:keytake(Double_Take_Player, 2, BronzePool2) of
					%% 										false ->
					%% 											skip; %这里应该抛出错误
					%% 										{value,_,ChangeSupPool} ->
					%% 											[BronzePoolChange2|ChangeSupPool]
					%% 									end,
					%% 					ets:insert(?ETS_PVP_3V3_SUP_POOL , SupPool#sup_pool{pool = ChangeSupPool2 } ),
					%需要将单人池和双人池拿出的玩家删掉
					ChangeSinglePool = lists:delete(Single_Take_Player , SinglePool#type_pool.player_id),
					ets:insert(?CROSS_TYPE_POOL, SinglePool#type_pool{player_id =ChangeSinglePool }),
					ChangeDoublePool = lists:delete(Double_Take_Player , DoublePool#type_pool.player_id),
					ets:insert(?CROSS_TYPE_POOL, DoublePool#type_pool{player_id =ChangeDoublePool }) ,
					%三人池插入一组 要删除掉已有的player_id
					FinishBronzePool2  = ets:lookup(?CROSS_TYPE_POOL, {Type,3}),
					[FinishBronzePool] =
						case length(FinishBronzePool2) > 0 of
							true -> FinishBronzePool2;
							false -> [#type_pool{player_id = []}]
						end,
					matching_players(Type , Double_Take_Player , FinishBronzePool);	
				
				false ->
					%单人池一个人都没有,拿高级组的可以一起组队
					SilverSinglePool2 = ets:lookup(?CROSS_TYPE_POOL, {Type + 1 ,1}),
					[SilverSinglePool] =case length(SilverSinglePool2) > 0 of
											true -> SilverSinglePool2;
											false -> [#type_pool{player_id = []}]
										end,
					case  length(SilverSinglePool#type_pool.player_id) > 0 of
						true ->
							[SilverSinglePlayer] = lists:sublist(SilverSinglePool#type_pool.player_id, 1, 1),
							ChangeSilverPlayers = lists:delete(SilverSinglePlayer , SilverSinglePool#type_pool.player_id),
							%更新提出去的白银单人组
							ets:insert(?CROSS_TYPE_POOL, SilverSinglePool#type_pool{player_id = ChangeSilverPlayers}),
							%拿出一个双人池的玩家
							[Double_Take_Player] = lists:sublist(DoublePool#type_pool.player_id, 1, 1),
							ChangeDoublePool = lists:delete(Double_Take_Player , DoublePool#type_pool.player_id),
							ets:insert(?CROSS_TYPE_POOL, DoublePool#type_pool{player_id =ChangeDoublePool }),
							
							%% 							%更新总池
							%% 							BronzePool =SupPool#sup_pool.pool,
							
							%% 							[SilverSupPool] = ets:lookup(?ETS_PVP_3V3_SUP_POOL, Type+1),
							%% 							SilverPool = SilverSupPool#sup_pool.pool,
							%% 							SilverPool2 = lists:keydelete(SilverSinglePlayer, 2, SilverPool),
							%高段位的组的队长会到青铜池中去，因为三个队友以最低队友的段位池为准
							%% 							ets:insert(?ETS_PVP_3V3_SUP_POOL, SilverSupPool#sup_pool{pool = SilverPool2 }),
							%% 							BronzePoolChange = lists:keyfind(Double_Take_Player, 2, BronzePool),
							[DoubleRoom] = ets:lookup(?ETS_PVP_3V3_ROOM, Double_Take_Player),
							[SeniorSingleRoom] = ets:lookup(?ETS_PVP_3V3_ROOM, SilverSinglePlayer),
							{Captain,Teammate1 }= {DoubleRoom#room.captain, DoubleRoom#room.teammates} ,
							[SilverPlayerData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, SilverSinglePlayer),
							Timestamp = SilverPlayerData#pvp_cross_player_data.timestamp,
							%% 							BronzePoolChange2 =DoubleRoom#room{captain =SilverSinglePlayer,teammates =[Captain|Teammate1],counters = 3,
							%% 																	 timestamp= Timestamp},
                            io:format("TestZhengFaData2 ~p ~n",[ SeniorSingleRoom#room.cur_troop]),
							BronzePoolChange22 =#match_room{captain =SilverSinglePlayer,teammates =[Captain|Teammate1],counters = 3,
															timestamp= Timestamp, cur_troop=SeniorSingleRoom#room.cur_troop   },
							ets:insert(?ETS_PVP_MATCH_ROOM, BronzePoolChange22),
							%% 							ChangeSupPool2 =case lists:keytake(Double_Take_Player, 2, BronzePool) of
							%% 												false ->
							%% 													skip; %这里应该抛出错误
							%% 												{value,_,ChangeSupPool} ->
							%% 													[BronzePoolChange2|ChangeSupPool]
							%% 											end,
							%% 							%组合成完成的三人组，以高段位为队长
							%% 							ets:insert(?ETS_PVP_3V3_SUP_POOL, SupPool#sup_pool{pool = ChangeSupPool2 } ),
							FinishBronzePool2 = ets:lookup(?CROSS_TYPE_POOL, {Type,3}),
							[FinishBronzePool] =
								case length(FinishBronzePool2) > 0 of
									true -> FinishBronzePool2;
									false -> [#type_pool{player_id = []}]
								end,							
							matching_players(Type , SilverSinglePlayer , FinishBronzePool);
						false -> skip
					end
			end;
		false -> skip
	end,
	match_rule2(Type).

match_rule2(Type) ->
	%改到这里 2019/2/22 中午
	%单排池
	SinglePool2  = ets:lookup(?CROSS_TYPE_POOL, {Type,1}),
	[SinglePool] =case length(SinglePool2) > 0 of
					  true -> SinglePool2;
					  false -> [#type_pool{player_id = []}]
				  end,
	case  length(SinglePool#type_pool.player_id) > 2 of
		true ->
			%凑成一队
			{Satisfy,Surplus} = lists:split(3, SinglePool#type_pool.player_id),
			%更新取出的人
			ets:insert(?CROSS_TYPE_POOL, SinglePool#type_pool{player_id = Surplus}),
			%将三个单人组成一队并且更新，以最高匹配分数的为队长
			SingleF = fun(PlayerId, Acc) ->
							  [BronzePlayerData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId),
							  BronzePlayerData#pvp_cross_player_data.score,
							  [{PlayerId,BronzePlayerData#pvp_cross_player_data.score}|Acc]
					  end,
			SingleSort =lists:foldl(SingleF, [], Satisfy),
			SingleSortF = fun({_, AScore},{_, BScore}) ->
								  AScore > BScore
						  end,
			%排在第一的分数为最高
			SingleSort2 = lists:sort(SingleSortF, SingleSort),
			%将三人组成一队
			[{PlayerId1, _}, {PlayerId2, _}, {PlayerId3, _}] = SingleSort2,
%% 			[BronzePlayerData2] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId1),
			[PlayerRoomData] = ets:lookup(?ETS_PVP_3V3_ROOM, PlayerId1),
			io:format("TestZhengFaData ~p ~n",[ PlayerRoomData#room.cur_troop]),
			Timestamp = PlayerRoomData#room.timestamp,
			%% 					BronzePool =#room{captain = PlayerId1, teammates = [PlayerId2, PlayerId3] , timestamp = Timestamp  , counters = 3 },
			BronzePool2 = #match_room{captain =PlayerId1,teammates =[PlayerId2, PlayerId3], counters = 3,timestamp= Timestamp,cur_troop = PlayerRoomData#room.cur_troop  },
			ets:insert(?ETS_PVP_MATCH_ROOM, BronzePool2),
			%% 					BronzeSupPool = SupPool#sup_pool.pool,
			%% 					BronzeSupPool2 =lists:keydelete(PlayerId1,  2,BronzeSupPool),
			%% 					BronzeSupPool3 = lists:keydelete(PlayerId2, 2,BronzeSupPool2),
			%% 					BronzeSupPool4 = lists:keydelete(PlayerId3, 2,BronzeSupPool3),
			%% 					BronzeSupPool5 = [BronzePool | BronzeSupPool4 ],
			%% 					ets:insert(?ETS_PVP_3V3_SUP_POOL, SupPool#sup_pool{pool = BronzeSupPool5 }),
			%插入段位三人池
			FinishBronzePool2 = ets:lookup(?CROSS_TYPE_POOL, {Type,3}),
			[FinishBronzePool] =
				case length(FinishBronzePool2) > 0 of
					true -> FinishBronzePool2;
					false -> [#type_pool{player_id = []}]
				end,
			io:format("TestThreadSingleData ~p kkp ~p ~n", [PlayerId1,FinishBronzePool]),
			matching_players(Type , PlayerId1 , FinishBronzePool);
		
		false ->
			case length(SinglePool2) > 0 andalso length(SinglePool#type_pool.player_id) == 2 of
				true ->
					%检测到低段位队中有两个单人的，此时需要看看高级单人池是否有人
					SilverSinglePool2 = ets:lookup(?CROSS_TYPE_POOL, {Type + 1 ,1}),
					[SilverSinglePool] =
						case length(SilverSinglePool2) > 0 of
							true -> SilverSinglePool2;
							false ->[#type_pool{player_id = []}]
						end,
					case  length(SilverSinglePool#type_pool.player_id) > 0 of
						true ->
							{[SilverPlayerId],Surplus} = lists:split(1,SilverSinglePool#type_pool.player_id),
							%更新提取出来的人
							ets:insert(?CROSS_TYPE_POOL, SilverSinglePool#type_pool{player_id = Surplus}),
							%将三人组成一队，队长为高段位的的
							SinglePlayers = SinglePool#type_pool.player_id,
							%% 									[ PlayerId1,PlayerId2] = SinglePlayers,
							ets:insert(?CROSS_TYPE_POOL, SinglePool#type_pool{player_id = []}),							
%% 							[PlayerData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, SilverPlayerId),
                            [PlayerRoomData] = ets:lookup(?ETS_PVP_3V3_ROOM, SilverPlayerId),
							Timestamp = PlayerRoomData#room.timestamp,
							BronzePool22 =#match_room{captain = SilverPlayerId, teammates = SinglePlayers , timestamp = Timestamp  , counters = 3, cur_troop = PlayerRoomData#room.cur_troop},
							ets:insert(?ETS_PVP_MATCH_ROOM, BronzePool22),
							%% 									BronzeSupPool = SupPool#sup_pool.pool,
							%% 									BronzeSupPool2 =lists:keydelete(PlayerId1,  2,BronzeSupPool),
							%% 									BronzeSupPool3 = lists:keydelete(PlayerId2, 2,BronzeSupPool2),
							%% 									BronzeSupPool4 = [BronzePool | BronzeSupPool3],
							%% 									ets:insert(?ETS_PVP_3V3_SUP_POOL, SupPool#sup_pool{pool = BronzeSupPool4 }),
							%% 									%删掉高段位的总池
							%% 									[SilverSupPool] = ets:lookup(?ETS_PVP_3V3_SUP_POOL, Type + 1),
							%% 									SilverPool = SilverSupPool#sup_pool.pool,
							%% 									SilverPool2 = lists:keydelete(SilverPlayerId, 2, SilverPool),
							%% 									%高段位的组的队长会到青铜池中去，因为三个队友以最低队友的段位池为准
							%% 									ets:insert(?ETS_PVP_3V3_SUP_POOL, SilverSupPool#sup_pool{pool = SilverPool2 }),
							%插入段位三人池
							FinishBronzePool2 = ets:lookup(?CROSS_TYPE_POOL, {Type,3}),
							[FinishBronzePool] =
								case length(FinishBronzePool2) > 0 of
									true -> FinishBronzePool2;
									false -> [#type_pool{player_id = []}]
								end,
							
							matching_players(Type , SilverPlayerId , FinishBronzePool);
						
						
						false ->
							%寻找白银双排
							SilverDoublePool2  = ets:lookup(?CROSS_TYPE_POOL, {Type + 1,2}),
							[SilverDoublePool] =
								case length(SilverDoublePool2) > 0 of
									true -> SilverDoublePool2;
									false -> [#type_pool{player_id = []}]
								end,
							case length(SilverDoublePool#type_pool.player_id) > 0 of
								true ->
									{[SilverPlayerId],Surplus} = lists:split(1,SilverDoublePool#type_pool.player_id),
									ets:insert(?CROSS_TYPE_POOL, SilverDoublePool#type_pool{player_id = Surplus}),
									SinglePlayers = SinglePool#type_pool.player_id,
									[PlayerId1 ,PlayerId2] = SinglePlayers,
									ets:insert(?CROSS_TYPE_POOL, SinglePool#type_pool{player_id = [PlayerId2]}),
									%删掉低段位的池
									%% 											BronzeSupPool = SupPool#sup_pool.pool,
									%% 											BronzeSupPool2 =lists:keydelete(PlayerId1,  2,BronzeSupPool),
									FinishBronzePool2 = ets:lookup(?CROSS_TYPE_POOL, {Type,3}),
									
									%删掉高段位池
									%% 											SilverSupPool = ets:lookup(?ETS_PVP_3V3_SUP_POOL, Type + 1),
									%% 											SilverPool = SilverSupPool#sup_pool.pool,
									%% 											ChangeSilverPool = lists:keydelete(SilverPlayerId,  2,SilverPool),
									%% 											SaveSilverPool = lists:keyfind(SilverPlayerId, 2, SilverPool),
									[PlayerRoomData] = ets:lookup(?ETS_PVP_3V3_ROOM, SilverPlayerId),
									%% 											SaveSilverPool2 =SaveSilverPool#room{teammates =  [PlayerId1|SaveSilverPool#room.teammates], counters = 3},
									SaveSilverPool22 =#match_room{captain = SilverPlayerId, teammates =  [PlayerId1|PlayerRoomData#room.teammates], counters = 3, timestamp =PlayerRoomData#room.timestamp  ,cur_troop = PlayerRoomData#room.cur_troop},											
									ets:insert(?ETS_PVP_MATCH_ROOM, SaveSilverPool22),
									%% 											BronzeSupPool3 = [SaveSilverPool2 | BronzeSupPool2],
									[FinishBronzePool] =
										case length(FinishBronzePool2) > 0 of
											true -> FinishBronzePool2;
											false -> [#type_pool{player_id = []}]
										end,																					
									%插入高段位为队长的新池
									%% 											ets:insert(?ETS_PVP_3V3_SUP_POOL, SupPool#sup_pool{pool = BronzeSupPool3 }),
									%% 											ets:insert(?ETS_PVP_3V3_SUP_POOL, SilverSupPool#sup_pool{pool =ChangeSilverPool }),
									matching_players(Type , SilverPlayerId , FinishBronzePool);
								false ->
									skip %高段位组单双排都不符合
							end
					end;
				false ->
					%检测到低段位只有一个单人的，此时需要看看高段位双人人池是否有人
					case  length(SinglePool#type_pool.player_id) > 0  of
						true ->
							SilverDoublePool2  = ets:lookup(?CROSS_TYPE_POOL , {Type + 1 ,2}),
							[SilverDoublePool] =
								case length(SilverDoublePool2) > 0 of
									true -> SilverDoublePool2;
									false ->[#type_pool{player_id = []}]
								end,
							%%                                     [IsSilverSupPool] = ets:lookup(?ETS_PVP_3V3_SUP_POOL , Type + 1),
							case length(SilverDoublePool#type_pool.player_id) >0 andalso  length(SinglePool#type_pool.player_id) >0 of
								true ->
									[BronzePlayerId] = SinglePool#type_pool.player_id,
									SilverDoublePlayers = SilverDoublePool#type_pool.player_id,
									{[SilverPlayerId],Surplus} = lists:split(1,SilverDoublePlayers),
									ets:insert(?CROSS_TYPE_POOL , SilverDoublePool#type_pool{player_id = Surplus}),         	
									%凑成一组，高段位的是组长，先删除低段位的池
									%% 											BronzeSupPool = SupPool#sup_pool.pool,
									%% 											BronzeSupPool2 =lists:keydelete(BronzePlayerId,  2,BronzeSupPool),	   
									%删掉高段位池 SilverSupPool = [{sup_pool,6,[]}]
									
									%% 											[SilverSupPool] = ets:lookup(?ETS_PVP_3V3_SUP_POOL , Type + 1),
									%% 											SilverPool = SilverSupPool#sup_pool.pool,
									%% 											ChangeSilverPool = lists:keydelete(SilverPlayerId,  2,SilverPool),
									%% 											SaveSilverPool = lists:keyfind(SilverPlayerId, 2, SilverPool),
									%% 											ets:insert(?ETS_PVP_3V3_SUP_POOL , SilverSupPool#sup_pool{pool =ChangeSilverPool }),
									[PlayerRoomData] = ets:lookup(?ETS_PVP_3V3_ROOM, SilverPlayerId),
									%% 											SaveSilverPool2 =SaveSilverPool#room{teammates =  [BronzePlayerId|SaveSilverPool#room.teammates], counters = 3},
									SaveSilverPool22 =#match_room{captain = SilverPlayerId , teammates =  [BronzePlayerId|PlayerRoomData#room.teammates], counters = 3, timestamp =PlayerRoomData#room.timestamp, cur_troop = PlayerRoomData#room.cur_troop},
									ets:insert(?ETS_PVP_MATCH_ROOM, SaveSilverPool22),
									%% 											BronzeSupPool3 = [SaveSilverPool2 | BronzeSupPool2],
									FinishBronzePool2 = ets:lookup(?CROSS_TYPE_POOL, {Type,3}),
									[FinishBronzePool] =
										case length(FinishBronzePool2) > 0 of
											true -> FinishBronzePool2;
											false -> [#type_pool{player_id = []}]
										end,
									
									%插入高段位为队长的新池
									%% 											ets:insert(?ETS_PVP_3V3_SUP_POOL, SupPool#sup_pool{pool = BronzeSupPool3 }),
									ets:insert(?CROSS_TYPE_POOL, SinglePool#type_pool{player_id = []}),
									matching_players(Type , SilverPlayerId , FinishBronzePool);
								false ->
									%此时需要看看白银单人池是否有人,需要两个高段位的人
									SilverSinglePool2  = ets:lookup(?CROSS_TYPE_POOL, {Type + 1 ,1}),
									[SilverSinglePool] = 
										case length(SilverSinglePool2) > 0 of
											true -> SilverSinglePool2;
											false -> [#type_pool{player_id = []}]
										end,
									%%                                             test1291 {type_pool,{5,1},[]} kkp [{type_pool,{5,1},[]}]
									case length(SilverSinglePool#type_pool.player_id) > 1 of
										
										true ->
											{[SilverPlayerId1,SilverPlayerId2],Surplus} = lists:split(2,SilverSinglePool#type_pool.player_id),
											%更新提取出来的人
											ets:insert(?CROSS_TYPE_POOL, SilverSinglePool#type_pool{player_id = Surplus}),
											%将三人组成一队，队长为高段位最高分的
											SinglePlayers = SinglePool#type_pool.player_id,
											ets:insert(?CROSS_TYPE_POOL, SinglePool#type_pool{player_id = []}),
											[BronzePlayerId] = SinglePlayers,
											[PlayerData]  =  ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, SilverPlayerId1),
											[PlayerData2] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, SilverPlayerId2),
											Score1 = PlayerData#pvp_cross_player_data.score,
											Score2 = PlayerData2#pvp_cross_player_data.score,
											[CaptainPlayerId,Teammate1] = 
												case Score1 > Score2 of
													true ->
														[SilverPlayerId1,SilverPlayerId2];
													false ->
														[SilverPlayerId2,SilverPlayerId1]
												
												end,
											[PlayerRoomData] = ets:lookup(?ETS_PVP_3V3_ROOM, CaptainPlayerId),
											%% 													BronzePool =#room{captain = CaptainPlayerId, teammates =[Teammate1, BronzePlayerId] , timestamp = Timestamp  , counters = 3 },
											BronzePool22 =#match_room{captain = CaptainPlayerId, teammates =[Teammate1, BronzePlayerId] , timestamp = PlayerRoomData#room.timestamp  , counters = 3, cur_troop = PlayerRoomData#room.cur_troop},												   
											ets:insert(?ETS_PVP_MATCH_ROOM, BronzePool22),
											%% 													BronzeSupPool = SupPool#sup_pool.pool,
											%% 													BronzeSupPool2 =lists:keydelete(BronzePlayerId,  2,BronzeSupPool),
											%% 													BronzeSupPool3 = [BronzePool | BronzeSupPool2],
											%% 													ets:insert(?ETS_PVP_3V3_SUP_POOL, SupPool#sup_pool{pool = BronzeSupPool3 }),
											%插入段位三人池
											FinishBronzePool2 = ets:lookup(?CROSS_TYPE_POOL, {Type,3}),
											[FinishBronzePool] =
												case length(FinishBronzePool2) > 0 of
													true -> FinishBronzePool2;
													false -> [#type_pool{player_id = []}]
												end,
											
											
											%% 													case length(FinishBronzePool2) > 0 of
											%% 														true ->							
											%% 															ChangeFinishBronzePool = [CaptainPlayerId|FinishBronzePool#type_pool.player_id ],
											%% 															ets:insert(?CROSS_TYPE_POOL, FinishBronzePool#type_pool{player_id =ChangeFinishBronzePool });
											%% 														false ->
											%% 															ets:insert(?CROSS_TYPE_POOL, #type_pool{type ={Type,3}, player_id =[CaptainPlayerId] })
											%% 													end,
											%% 													%删掉高段位的总池
											%% 													SilverSupPool = ets:lookup(?ETS_PVP_3V3_SUP_POOL, Type + 1),
											%% 													SilverPool = SilverSupPool#sup_pool.pool,
											%% 													SilverPool2 = lists:keydelete(SilverPlayerId1, 2, SilverPool),
											%% 													SilverPool3 = lists:keydelete(SilverPlayerId2, 2, SilverPool2),		
											%% 													
											%% 													%高段位的组的队长会到青铜池中去，因为三个队友以最低队友的段位池为准
											%% 													ets:insert(?ETS_PVP_3V3_SUP_POOL, SilverSupPool#sup_pool{pool = SilverPool3 }),
											matching_players(Type , CaptainPlayerId , FinishBronzePool);
										false ->
											skip
									end
							end;
						false ->
							skip
					end
			end
	end.


filter_pool() ->
	PoolList = ets:tab2list(?ETS_PVP_3V3_SUP_POOL),
	Fp = fun(SupPool) ->
				 choose_type_pool(SupPool#sup_pool.pool , SupPool#sup_pool.dan),
				 match_rule(SupPool#sup_pool.dan)
		 end,	
	lists:foreach(Fp, PoolList).
%% ThirdPool4 = [ThirdPool3],
%% 					matching_players(Type , ThirdPlayerId , ThirdPool3, ThirdPool4);
%matching_players(Type , ThirdPlayerId , ThirdPool3, ThirdPool4);
matching_players(Type , SilverPlayerId , FinishBronzePool) ->
	%因为确保有一组是在三人池里，所以需要删掉它，确保两组不是同一组人
	JudgePlayerId0 = FinishBronzePool#type_pool.player_id, 
	JudgePlayerId =lists:delete(SilverPlayerId, JudgePlayerId0),
	
	case length(JudgePlayerId) > 0  of
		true ->	
			ChangeFinishBronzePool = [SilverPlayerId|FinishBronzePool#type_pool.player_id ],
			IsListLength = length(ChangeFinishBronzePool) rem 2,
			WaitList = 
				case IsListLength =:= 0 of
					true -> ets:delete(?CROSS_TYPE_POOL, {Type,3}),
							ChangeSupPoolFun = fun(PlayerId) ->						 
													   [SupPool] = ets:lookup(?ETS_PVP_3V3_SUP_POOL , Type),
													   RoomData = SupPool#sup_pool.pool,
													   case RoomData =:= [] of
														   true ->skip;
														   false ->
															   
															   {value,_TakeData,SurplusData} = lists:keytake(PlayerId, 2, RoomData),
															   FinishChangeData = SupPool#sup_pool{pool =  SurplusData },
															   ets:insert(?ETS_PVP_3V3_SUP_POOL, FinishChangeData)
													   end
											   end,																										 											
							lists:foreach(ChangeSupPoolFun ,ChangeFinishBronzePool),
							ChangeFinishBronzePool;
					false -> 
						[H|Tail] = JudgePlayerId,
						ChangeSupPoolFun = fun(PlayerId) ->						 
												   [SupPool] = ets:lookup(?ETS_PVP_3V3_SUP_POOL , Type),
												   RoomData = SupPool#sup_pool.pool,
												   {value,_TakeData,SurplusData} = lists:keytake(PlayerId, 2, RoomData),
												   FinishChangeData =  SupPool#sup_pool{pool =  SurplusData},
												   ets:insert(?ETS_PVP_3V3_SUP_POOL, FinishChangeData)
										   end,																										 											
						lists:foreach(ChangeSupPoolFun ,Tail),
						ets:insert(?CROSS_TYPE_POOL, FinishBronzePool#type_pool{player_id =[H] }),
						Tail
				end,
			proc_lib:spawn(fun() -> arrange_players_to_battle(WaitList) end);
		false ->
			%高段位里面找组 [{type_pool,{5,3},[]}]
			AdvancedTypePool2 = ets:lookup(?CROSS_TYPE_POOL, {Type + 1,3}),	
			[AdvancedTypePool4] = case length(AdvancedTypePool2) > 0  of
									  true -> AdvancedTypePool2;
									  false ->
										  [{type_pool,{},[]}]
								  end,
			case length(AdvancedTypePool2) >0 of
				true -> 
					case  length(AdvancedTypePool4#type_pool.player_id) > 0 of
						true ->
							[AdvancedTypePool] = AdvancedTypePool2,
							[AdvancedH|AdvancedTail] = AdvancedTypePool#type_pool.player_id,
							[SupPool] = ets:lookup(?ETS_PVP_3V3_SUP_POOL , Type + 1),
							RoomData = SupPool#sup_pool.pool,
							case RoomData =:= [] of
								true ->skip;
								false ->{value,_TakeData,SurplusData} = lists:keytake(AdvancedH, 2, RoomData),
										FinishChangeData =  SupPool#sup_pool{pool =  SurplusData},
										ets:insert(?ETS_PVP_3V3_SUP_POOL, FinishChangeData)
							end,
							case length(AdvancedTail) =:= 0 of
								true ->				
									ets:delete(?CROSS_TYPE_POOL, {Type + 1,3});
								false ->
									ets:insert(?CROSS_TYPE_POOL, #type_pool{type ={Type + 1,3}, player_id =AdvancedTail })
							end,
							proc_lib:spawn(fun() -> arrange_players_to_battle([AdvancedH,SilverPlayerId]) end);
						false ->ets:insert(?CROSS_TYPE_POOL, #type_pool{type ={Type,3}, player_id =[SilverPlayerId] })
					end;
				
				false ->  ets:insert(?CROSS_TYPE_POOL, #type_pool{type ={Type,3}, player_id =[SilverPlayerId] })
			end
	end.


%玩家匹配超时检测, 区分三人组，因为三人组要去match_pool拿数据， 其他的都从room拿数据
%进入战斗前判断玩家的状态，并且清除type_pool
check_over_time_match() ->
	AllTypePool = ets:tab2list(?CROSS_TYPE_POOL),
	Fp = fun(TypePool ) ->
					 {Type , Counter} = TypePool#type_pool.type,
					 try delete_error_type( Type , Counter, TypePool)
					 catch E:R -> [PlayerId|Tail] = TypePool#type_pool.player_id,
									ets:insert(?CROSS_TYPE_POOL, TypePool#type_pool{player_id = Tail }),
									ets:delete(?ETS_PVP_MATCH_ROOM, PlayerId),
									?ERROR_MSG("{E,R,erlang:get_stacktrace()} : ~p~n", [{E,R,erlang:get_stacktrace()}])

					 end
			 end,
	lists:foreach(Fp, AllTypePool).

%简单容错处理，有些玩家的type存在但matchETS不存在
delete_error_type( Type , Counter, TypePool) ->
	case Counter == 3 andalso length(TypePool#type_pool.player_id) > 0 of
		true ->
			[PlayerId|Tail] = TypePool#type_pool.player_id,
			
			[Data] = ets:lookup(?ETS_PVP_MATCH_ROOM, PlayerId),
			Time  = util:unixtime() - Data#match_room.timestamp,
			case Time >=  30 of
				true ->io:format("TestOncePkErrorData ~p  kkp ~p ~n", [Time,Data]),
					
					[SupPool] = ets:lookup(?ETS_PVP_3V3_SUP_POOL, Type),
					SupRoom = SupPool#sup_pool.pool,
					
					SupRoom2= lists:keydelete(PlayerId, 2, SupRoom),
					
					ets:insert(?ETS_PVP_3V3_SUP_POOL, SupPool#sup_pool{pool = SupRoom2}),
					ets:insert(?CROSS_TYPE_POOL, TypePool#type_pool{player_id = Tail }),				 
					matching_overtime(Data);
				false ->
					skip
			end;
		
		false ->
			case length(TypePool#type_pool.player_id) > 0 of
				true ->
					
					%构建match_room
					[PlayerId|Tail] = TypePool#type_pool.player_id,
					[Data] = ets:lookup(?ETS_PVP_3V3_ROOM, PlayerId),
					Timestamp = Data#room.timestamp,
					Time  = util:unixtime() - Timestamp,
					case Time >=  30 of
						true ->
							[SupPool] = ets:lookup(?ETS_PVP_3V3_SUP_POOL, Type),
							SupRoom = SupPool#sup_pool.pool,
							
							SupRoom2= lists:keydelete(PlayerId, 2, SupRoom),
							
							ets:insert(?ETS_PVP_3V3_SUP_POOL, SupPool#sup_pool{pool = SupRoom2}),
							
							ets:insert(?CROSS_TYPE_POOL, TypePool#type_pool{player_id = Tail }),				 
							
							Data3 =  #match_room{captain = Data#room.captain, teammates = Data#room.teammates, counters = Data#room.counters, timestamp =Timestamp,cur_troop =Data#room.cur_troop  },
							ets:insert(?ETS_PVP_MATCH_ROOM, Data3),
							matching_overtime(Data3);
						false ->
							skip
					end;
				false ->
					skip
			end
	
	end.

get_rank_package_no(Rank,No,NoLength) when No < NoLength  ->
	RankRewardInfo = data_ranking3v3_rank_reward:get(No),
	Beging = RankRewardInfo#ranking3v3_rank_reward.begin_ranking,
	End = RankRewardInfo#ranking3v3_rank_reward.end_ranking,
	case Rank >= Beging  andalso End >= Rank of
		true ->
			RankRewardInfo#ranking3v3_rank_reward.reward;
		false ->
			get_rank_package_no(Rank,No +1, NoLength)
	end;

get_rank_package_no(_Rank,_No,NoLength)  ->
	RankRewardInfo = data_ranking3v3_rank_reward:get(NoLength),
	RankRewardInfo#ranking3v3_rank_reward.reward.

send_to_rank_reward(ServerId, PlayerId, GoodsList) ->
	Title = "段位排名奖励邮件",
	Content = "亲爱的少侠，由于您在跨服3V3比赛中的出色表现，特根据排名颁发奖励，祝您游戏愉快！",
	Title2 = unicode:characters_to_list(Title,utf8),
	Content2 = unicode:characters_to_list(Content,utf8),
	sm_cross_server:rpc_call( ServerId, lib_mail, send_sys_mail, [PlayerId, util:to_binary(Title2), util:to_binary(Content2), GoodsList, ["Duanwei","RankReward"]]).


send_rank_reward() ->
	case lib_pvp:get_ets_pvp_rank_data_from_ets(pvp_cross_rank_data) of
		null -> skip;
		R ->
			case R#pvp_rank_data.ranklist =:= [] of
				true ->
					skip;
				false ->
					RankLsts = R#pvp_rank_data.ranklist,
					Fun = fun(Term) ->
								  {PlayerId, _ ,ServerId , Rank, _, _} = Term,
								  NoList = data_ranking3v3_rank_reward:get_group(),
								  NoLength = length(NoList),
								  PackageNo = get_rank_package_no(Rank,1,NoLength),
								  Rewardpkg = data_reward_pkg:get(PackageNo),
								  PkgGoods = Rewardpkg#reward_pkg.goods_list,
								  Fun2 = fun({_Q, RewardNo, Count, _, _ },Acc4) ->
												 [{RewardNo, 1 ,Count}|Acc4]
										 end,
								  GoodsList = lists:foldl(Fun2, [], PkgGoods),
								  send_to_rank_reward(ServerId, PlayerId, GoodsList)
						  end,
					
					lists:foreach(Fun, RankLsts)
			end
	end.

%大于1500分的王者玩家前10名就变为传奇
become_legend() ->
	{NeedRank,NeedScore} = data_special_config:get('3V3_chuanqi_score'),
	case lib_pvp:get_ets_pvp_rank_data_from_ets(pvp_cross_rank_data) of
		null -> skip;
		R ->
			case R#pvp_rank_data.ranklist =:= [] of
				true ->
					skip;
				false ->
					RankLsts = R#pvp_rank_data.ranklist,
					Fun = fun(Term) ->
								  {PlayerId, _ ,_ServerId , Rank, _Dan, Score} = Term,
								  case Score >= NeedScore andalso Rank < NeedRank + 1 of
									  true -> legend_result(PlayerId);
									  false -> skip
								  end
						  end,
					
					lists:foreach(Fun, RankLsts)
			end
	end.

%传奇段位生成  lib_pvp:get_pvp_cross_player_info( 1100300005000289).
legend_result(UID) ->
	PlayerCrossData = lib_pvp:get_pvp_cross_player_info(UID),
	Dan0 = lib_pvp:get_dan_by_score(PlayerCrossData#pvp_cross_player_data.score),
	Dan = Dan0 + 1,
	PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(UID),
	NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{dan = Dan},
	lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo),
	lib_pvp:db_update_pvp_player_info(NewPvpPlyInfo),
	sm_cross_server:rpc_cast(PvpPlyInfo#pvp_cross_player_data.server_id, lib_pvp, notify_dan_change, [UID, Dan]),
	OldDan = PlayerCrossData#pvp_cross_player_data.dan,
	NewReward = case (Dan - OldDan) > 0 orelse Dan == 1 of
					true ->
						%检测一下是否已经领取过奖励
						Reward = PlayerCrossData#pvp_cross_player_data.reward,
						case lists:member(Dan, Reward) of
							true ->
								
								PlayerCrossData#pvp_cross_player_data.reward;
							false ->
								ScoreRewardInfo =  data_ranking3v3_score:get(Dan),
								PackageNo = ScoreRewardInfo#ranking3v3_score.reward,
								PackageInfo = data_reward_pkg:get(PackageNo),
								ModifyGoods = PackageInfo#reward_pkg.goods_list,
								F = fun({_Q, GoodsNo, Count, _Z , _B}, Acc) ->
											[{GoodsNo,1,Count}|Acc]
									end,	
								GoodsList = lists:foldl(F, [], ModifyGoods),
								Title = "段位奖励邮件",
								Title2 = unicode:characters_to_list(Title,utf8),
								Name = ScoreRewardInfo#ranking3v3_score.name,
								Content =lists:concat(["恭喜少侠段位达到",binary_to_list(Name), ",在此为您奉上段位奖励~希望能再看到您更出色的表现"]),
								Content2 = unicode:characters_to_list(Content,utf8),
								sm_cross_server:rpc_call( PlayerCrossData#pvp_cross_player_data.server_id, lib_mail, send_sys_mail, [UID, util:to_binary(Title2), util:to_binary(Content2), GoodsList, ["Duanwei","finishDuanwei"]]),
								[Dan|Reward]
						end;
					false ->
						PlayerCrossData#pvp_cross_player_data.reward
				end,
	lib_pvp:update_pvp_player_info_from_battle(UID,0, Dan, PlayerCrossData#pvp_cross_player_data.score,NewReward,0).
















