%% @author JKYL
%% @doc @todo Add description to lib_guild_dungeon.


-module(lib_guild_dungeon).


-export([server_start_init/0,
		 db_insert_point/1,
		 update_point/2,
		 create_dungeon_point/1,
		 get_point/1,
		 check_point_scnene_exits/1,
		 enter_guild_scene/2,
		 load_guild_person/1,
		 db_insert_person_data/1,
		 update_guild_person_data/2,
		 get_person_data/1,
		 allow_enter_scene2/3,
		 enter_dungeon/2,
		 create_dungeon_point/2,
		 send_detail_info/7 ,
		 send_detail_info2/7,
		 send_detail_info3/6,
		 send_detail_info4/6,
		 on_scene_login/1,
		 collect_point/2,
		 kill_count/2,
		 drop_count/3,
		 kill_boss_count/1,
		 cal_boss_hp/2,
		 count_contribution/1,
		 refresh_data/0,
		 gm_collect_point/3,
		 gm_kill_count/3,
		 gm_drop_count/3
		 ]).

-include("common.hrl").
-include("record.hrl").
-include("guild_dungeon.hrl").
-include("ets_name.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("pt_53.hrl").
-include("dungeon.hrl").
-include("ets_name.hrl").


server_start_init() ->
	case db:select_all(guild_dungeon, "guild_week", []) of
		List when is_list(List) ->
			[ load_guild_dungeon(GuildWeek) || [GuildWeek] <- List];
		Err ->
			?ERROR_MSG("server_start_init Err : ~p~n", [Err])
	end.


%%帮派成员第一个人第一次进入的时候创建
create_dungeon_point(PS) ->
	GuildId = player:get_guild_id(player:get_id(PS)),
	Week = util:get_week(),
	GuildWeek = list_to_integer(lists:concat([GuildId,Week])),
	case has_point(GuildWeek) of 
		false ->
			Init = 0,
			GuildDungeon = 
				#guild_dungeon_point{
									 guild_week = GuildWeek ,
									 guild_scene_id =Init , 
									 week_point = Week,  
									 progress = Init,     
									 guild_id = GuildId,   
									 collection = Init,  
									 kill_count = Init , 
									 boss_hp = Init,
									 rank = []
									},
			db_insert_point(GuildDungeon),
			mod_guild_dungeon:update_guild_dungeon_point_to_ets(GuildDungeon);
		true ->
			ok
	end.

%%帮派成员第一个人第一次进入的时候创建
create_dungeon_point(PS,Point) ->
	GuildId = player:get_guild_id(player:get_id(PS)),
	GuildWeek = list_to_integer(lists:concat([GuildId,Point])),
	case has_point(GuildWeek) of 
		false ->
			Init = 0,
			DataDungeon = data_guild_new_dungeon:get(Point),
			BossHp = DataDungeon#guild_new_dungeon.boss_hp,
			GuildDungeon = 
				#guild_dungeon_point{
									 guild_week = GuildWeek ,
									 guild_scene_id =Init , 
									 week_point = Point,  
									 progress = Init,     
									 guild_id = GuildId,   
									 collection = Init,  
									 kill_count = Init , 
									 boss_hp = 0,
									 rank = []
									},
			db_insert_point(GuildDungeon),
			mod_guild_dungeon:update_guild_dungeon_point_to_ets(GuildDungeon);
		true ->
			ok
	end.

%%玩家第一次进入，或者数据为空时，初始化数据
create_player_data(PlayerId) ->
	case player:get_guild_id(PlayerId) of
		0 -> fail; %没有帮派
		GuildId ->
			Init = 0,
			TotalPoint = lists:concat([GuildId,7]),
			GetAward = case mod_guild_dungeon:get_guild_dungeon_point_from_ets(TotalPoint) of
						   null -> 2;
						   R -> case R#guild_dungeon_point.progress =:= 1000 of
									true -> 0;
									false -> 2
								end
					   end,
			
			GuildPerson =
				#guild_person{
							  player_id = PlayerId,
							  guild_id = GuildId , %帮派id
							  get_progress = [], %已经领取的关卡进步奖励
							  contribution = [], %贡献值
							  get_award = GetAward, %是否已经领取通关大奖
							  collection = Init,  %采集数
							  kill_count = Init , %击杀数
							  damage_value = Init %对boss造成的伤害血量
							  },
			db_insert_person_data(GuildPerson),
			mod_guild_dungeon:add_guild_person_to_ets(GuildPerson)
	end.


enter_dungeon(PS,Point) -> 
	PlayerId = player:get_id(PS),
	GuildId = player:get_guild_id(PlayerId),
	GuildWeek = list_to_integer(lists:concat([GuildId,Point])),
	case lib_guild_dungeon:enter_guild_scene( PS, Point) of
		{ok,SceneId} -> lib_guild_dungeon:allow_enter_scene2(PS,SceneId,GuildWeek);
		{fail, Reason} -> lib_send:send_prompt_msg(PS, Reason)
	end.

% 登录时判断帮派副本场景
on_scene_login(PS) ->
	%% 判断是否在帮派副本场景，是则退出场景，飞到主城?
	SceneId = player:get_scene_id(PS),
	case lib_scene:is_guild_dungeon_scene(SceneId) of
		true ->
			{SceneId2, X, Y} = ply_scene:get_adjusted_pos(player:get_race(PS), player:get_lv(PS)),
			gen_server:cast(player:get_pid(PS), {'do_single_teleport', SceneId2, X, Y});
		false ->
			ok
	end,
	ok.

			



allow_enter_scene(PS,Point,SceneId) ->
	{Type,Count} = (data_guild_new_dungeon:get(Point))#guild_new_dungeon.price_cost,
	case player:check_need_price(PS, Type, Count) of
		ok ->
			player:cost_money(PS, Type, Count, [?LOG_GUILD_DUNGEON, "enter"]),
%% 			case get(?DUNGEON_PLAYER_NUM) of
%% 				PlayerNum when is_integer(PlayerNum) -> put(?DUNGEON_PLAYER_NUM, PlayerNum + 1);
%% 				_ -> put(?DUNGEON_PLAYER_NUM, 1)
%% 			end,
			{ok,SceneId};
		Reason ->
			{fail, Reason}
	end.

allow_enter_scene2(PS,SceneId,GuildWeek) ->
	

	case get_point(GuildWeek) of
		false ->lib_send:send_prompt_msg(PS, ?PM_NEWYEAR_BANQUET_SYS_ERR);
		{ok, GDP} -> BossHp = 
						 case util:get_week() =:= 7 of
							 true -> GDP#guild_dungeon_point.boss_hp ;
							 false -> 0
						 end,
					 CollectionCount = GDP#guild_dungeon_point.collection,
					 KillCount =  GDP#guild_dungeon_point.kill_count,
					 Point = GDP#guild_dungeon_point.week_point,
					 Rank = GDP#guild_dungeon_point.rank,
					 ets:update_element(?ETS_GUILD_PERSON_INFO, player:get_id(PS), [{#guild_person.doing_point,Point}]),					 
					 DungeonNo = (data_guild_new_dungeon:get(Point))#guild_new_dungeon.dungeon_no,
					 {_map,X,Y} = (data_dungeon:get(DungeonNo))#dungeon_data.init_pos,
					 case lib_scene:get_scene_mon_count(SceneId) < 3   of
						 true ->
							 #guild_new_dungeon{
												target = Target,
												position = Position} = data_guild_new_dungeon:get(Point),
							 F = fun({Type, Mon, Count}) ->
										 case Mon =/= 35171 andalso Type =:= 2  of %Boss要特殊处理
											 true ->
												 
												 mod_guild_dungeon:for_list_count(2,Count,Mon,SceneId,Position);
											 false -> skip
										 end
								 end,
							 lists:foreach(F, Target);
						 false -> case lib_scene:get_scene_mon_count(SceneId) < 12 andalso  Point =:=6 of 
									  true ->
										  #guild_new_dungeon{
															 target = Target,
															 position = Position} = data_guild_new_dungeon:get(Point),
										  F = fun({Type, Mon, Count}) ->
													  case Mon =:= 35172 andalso Type =:= 2  of %Boss要特殊处理
														  true ->
															  
															  mod_guild_dungeon:for_list_count(2,Count,Mon,SceneId,Position);
														  false -> skip
													  end
											  end,
										  lists:foreach(F, Target);
									  false -> skip
								  end
					 end,				 
					 ply_scene:do_teleport(PS, SceneId, X, Y),
					 send_detail_info3(PS, BossHp ,CollectionCount,KillCount,Point,Rank),
					 ok
	end.

send_detail_info(PS,BossHp ,CollectionCount,KillCount,Point,Rank,SceneId) ->
	IdList = lib_scene:get_scene_player_ids(SceneId),
	
	{ok, BinData} =pt_53:write(?PT_ENTER_DUNGEON, [BossHp]),
	{ok, BinData2} =pt_53:write(?PT_DUNGEON_DETAIL, [CollectionCount,KillCount,0]),
	{ok, BinData3} = pt_53:write(?PT_DUNGEON_RANK, [Point,Rank]),
	F = fun(X) ->
				case X =:= player:get_id(PS) of
					true -> skip;
					false -> lib_send:send_to_uid(X, BinData),
							 lib_send:send_to_uid(X, BinData2),
							 lib_send:send_to_uid(X, BinData3)
				end
		
		end,
	lists:foreach(F,IdList ),
	lib_send:send_to_sock(PS, BinData),
	lib_send:send_to_sock(PS, BinData2),
	lib_send:send_to_sock(PS, BinData3)	.

send_detail_info2(PS, BossHp ,CollectionCount,KillCount,Point,Rank,SceneId) ->
	{ok, BinData} =pt_53:write(?PT_ENTER_DUNGEON, [BossHp]),
	{ok, BinData2} =pt_53:write(?PT_DUNGEON_DETAIL, [CollectionCount,KillCount,0]),
	{ok, BinData3} = pt_53:write(?PT_DUNGEON_RANK, [Point,Rank]),
	IdList = lib_scene:get_scene_player_ids(SceneId),
	F = fun(X) ->
				case X =:= player:get_id(PS) of
					true -> skip;
					false -> lib_send:send_to_uid(X, BinData),
							 lib_send:send_to_uid(X, BinData2),
							 lib_send:send_to_uid(X, BinData3),
							 lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_PASS)
				end
		
		end,
	lists:foreach(F,IdList ),
	lib_send:send_to_sock(PS, BinData),
	lib_send:send_to_sock(PS, BinData2),
	lib_send:send_to_sock(PS, BinData3)	.

send_detail_info3(PS, BossHp ,CollectionCount,KillCount,Point,Rank) ->
	{ok, BinData} =pt_53:write(?PT_ENTER_DUNGEON, [BossHp]),
	{ok, BinData2} =pt_53:write(?PT_DUNGEON_DETAIL, [CollectionCount,KillCount,0]),
	{ok, BinData3} = pt_53:write(?PT_DUNGEON_RANK, [Point,Rank]),
	lib_send:send_to_uid(player:get_id(PS), BinData),lib_send:send_to_uid(player:get_id(PS), BinData2),
	lib_send:send_to_uid(player:get_id(PS), BinData3).

%用于第七关
send_detail_info4(PS, BossHp ,BossCount ,KillCount,SceneId,Rank) ->
	{ok, BinData} =pt_53:write(?PT_ENTER_DUNGEON, [BossHp]),
	{ok, BinData2} =pt_53:write(?PT_DUNGEON_DETAIL, [0,KillCount,BossCount]),
	{ok, BinData3} = pt_53:write(?PT_DUNGEON_RANK, [7,Rank]),
	IdList = lib_scene:get_scene_player_ids(SceneId),
	F = fun(X) ->
				case X =:= player:get_id(PS) of
					true -> skip;
					false -> lib_send:send_to_uid(X, BinData),
							 lib_send:send_to_uid(X, BinData2),
							 lib_send:send_to_uid(X, BinData3)
				end
		
		end,
	lists:foreach(F,IdList ),
	lib_send:send_to_sock(PS, BinData),
	lib_send:send_to_sock(PS, BinData2),
	lib_send:send_to_sock(PS, BinData3)	.




enter_guild_scene(PS,Point) ->
	case mod_guild:get_info(player:get_guild_id(player:get_id(PS))) =/= null of
		true ->
			case player:is_in_team(player:get_id(PS)) of
				true ->
					{fail,?PM_TM_LEAVE_TEAM_FIRST};
				
				false ->
					case player:get_guild_id(player:get_id(PS)) of
						?INVALID_ID -> lib_send:send_prompt_msg(PS, ?PM_NOT_JOIN_GUILD_YET);
						_Id ->
							
					
							%判断帮派副本是否已经通关
							GuildId = player:get_guild_id(player:get_id(PS)),
							GuildWeek = list_to_integer(lists:concat([GuildId,Point])),
							GDP = mod_guild_dungeon:get_guild_dungeon_point_from_ets(GuildWeek),
							SceneId = GDP#guild_dungeon_point.guild_scene_id,
							LastGuildWeek = list_to_integer(lists:concat([GuildId,Point - 1])),
							LastGDP = mod_guild_dungeon:get_guild_dungeon_point_from_ets(LastGuildWeek),
							case   util:get_week() >= Point     of
								false ->
									{fail,?PM_GUILD_DUNGEON_CLOSE};
								true ->
									case Point =:=1 orelse  LastGDP#guild_dungeon_point.progress =:= 1000 of
										true ->
											case GDP#guild_dungeon_point.progress =:= 1000 of
												false ->
													%判断场景是否存在
													case check_point_scnene_exits(GDP) of
														true ->
															%判断需要的消耗
															allow_enter_scene(PS,Point,SceneId);
														false ->
															%创建场景
															case mod_guild_dungeon:create_point_scene(GuildWeek, Point) of
																{ok, SceneId2} ->
																	allow_enter_scene(PS,Point,SceneId2);
																fail ->
																	
																	{fail, ?PM_CREATE_GUILD_SCENE_FAIL}
															end
													end;
												
												true ->
													{fail,?PM_GUILD_DUNGEON_FINISHI}
											end;
										false -> {fail,?PM_GUILD_DUNGEON_FINISHI_BEFORE}
									end
							end
					end
			end;
		false ->
			{fail,?PM_GUILD_NOT_EXISTS}
	end.
		


check_point_scnene_exits(#guild_dungeon_point{guild_scene_id = SceneId}) when is_integer(SceneId) ->
	lib_scene:is_exists(SceneId);

check_point_scnene_exits(GuildWeek) when is_integer(GuildWeek) ->
	
	case get_point(GuildWeek) of
		{ok, GDP} ->
			check_point_scnene_exits(GDP);
		false ->
			false
	end;

check_point_scnene_exits(_) ->
	false.


%% load_player_data(PS) ->
%% 	PlayerId = player:get_id(PS),
%% 	GuildPerson = mod_guild_dungeon:get_guild_person_from_ets(PlayerId),
%% 	case GuildPerson of
%% 		null ->
			
	
	
	

load_guild_dungeon(GuildWeek) ->
	Fields = "week_point,progress,guild_id,collection,kill_count,boss_hp,rank",
	case db:select_row(guild_dungeon, Fields, [{guild_week, GuildWeek}]) of
		[] ->
			%% 没有就不管了
			ok;
		[WeekPoint,Progress,GuildId,Collection,KillCount,BossHp,Rank] ->
			GuildDungeon = 
				#guild_dungeon_point{
									 guild_week = GuildWeek ,
									 week_point = WeekPoint,  
									 progress = Progress,     
									 guild_id = GuildId,   
									 collection = Collection,  
									 kill_count = KillCount , 
									 boss_hp = BossHp,
									 rank = util:bitstring_to_term(Rank)
									},
			mod_guild_dungeon:add_guild_dungeon_point_to_ets(GuildDungeon)
	end.




%周日零点重置
refresh_data() ->
	case ets:tab2list(?ETS_GUILD_POINT_INFO) of
		[] ->
			ok;
		GuildWeekETSs -> 
			F = fun(GuildDungeonPoint) ->
						SceneId = GuildDungeonPoint#guild_dungeon_point.guild_scene_id,
						IdList = lib_scene:get_scene_player_ids(SceneId),
						F2 = fun(X) ->
									 case player:is_battling(player:get_PS(X)) of
										 true -> catch mod_battle:force_end_battle(player:get_PS(X));
										 false -> skip
									 end,
									 lib_dungeon:quit_dungeon(player:get_PS(X))
							 end,
						lists:foreach(F2,IdList ),
						case SceneId =:= 0 of
							true -> skip;
							false ->
								mod_scene:clear_scene(SceneId)
						end
						
				end,
			
			lists:foreach(F, GuildWeekETSs),
			
			ets:delete_all_objects(?ETS_GUILD_POINT_INFO),
			ets:delete_all_objects(?ETS_GUILD_PERSON_INFO),
			db:delete(guild_dungeon, []),
			db:delete(guild_dungeon_data, []),
			mod_rank_gift:daily_title(9001),
			mod_rank_gift:daily_title(9002),
			mod_rank_gift:daily_title(9003),
			mod_rank:send_rank_goods(9004)
	end.





db_insert_point(GuildDungeon) ->
	#guild_dungeon_point{
									 guild_week = GuildWeek ,
									 week_point = WeekPoint,  
									 progress = Progress,     
									 guild_id = GuildId,   
									 collection = Collection,  
									 kill_count = KillCount , 
									 boss_hp = BossHp ,
									 rank = Rank
									} = GuildDungeon,
	db:insert(guild_dungeon, [guild_week, week_point, progress, guild_id, collection, kill_count, boss_hp, rank], 
			  [GuildWeek, WeekPoint, Progress, GuildId, Collection, KillCount, BossHp, util:term_to_bitstring(Rank)]).

update_point(#guild_dungeon_point{guild_week = GuildWeek} = OldPoint, NewPoint) ->
	case lists:foldl(fun({Pos, DbFiled}, {PosValAcc, DbFieldValAcc}) ->
							 NewVal = erlang:element(Pos, NewPoint),
							 case erlang:element(Pos, OldPoint) =/= NewVal of
								 true ->
									 case lists:member(DbFiled, [rank]) of
										 true -> {[{Pos, NewVal}|PosValAcc], [{DbFiled,  util:term_to_bitstring(NewVal)}|DbFieldValAcc]};
										 false ->{[{Pos, NewVal}|PosValAcc], [{DbFiled,  NewVal}|DbFieldValAcc]}
									 end;							 
								 _ ->
									 {PosValAcc, DbFieldValAcc}
							 end
					 end, {[], []}, ?GUILD_DUNGEON_POS_FIELD_LIST) of
		{[], []} ->
			ok;
		{PosValueL, DbFieldValL} ->
			ets:update_element(?ETS_GUILD_POINT_INFO, GuildWeek, PosValueL),
			db:update(guild_dungeon, DbFieldValL, [{guild_week, GuildWeek}])
	end.


load_guild_person(PlayerId) ->
	Fields = "player_id, guild_id, get_progress, contribution, get_award, collection, kill_count, damage_value",
	case db:select_row(guild_dungeon_data, Fields, [{player_id,PlayerId}]) of
		[] ->
			%% 没有就不管了
			ok;
		[PlayerId, GuildId2, GetProgress0, Contribution0, GetAward, Collection, KillCount, DamageValue] ->
			GuildId = 
				case GuildId2 of
					0 ->
						player:get_guild_id(PlayerId);
					_ ->
						GuildId2
				end,
            GetProgress = util:bitstring_to_term(GetProgress0),
			Contribution = util:bitstring_to_term(Contribution0),
			GuildPerson = #guild_person{
										
										player_id = PlayerId,
										guild_id = GuildId , %帮派id
										get_progress = GetProgress, %已经领取的关卡进步奖励
										contribution = Contribution, %贡献值
										get_award = GetAward, %是否已经领取通关大奖
										collection = Collection,  %采集数
										kill_count = KillCount , %击杀数
										damage_value = DamageValue %对boss造成的伤害血量
										},
			mod_guild_dungeon:update_guild_person_to_ets(GuildPerson)
	end.

db_insert_person_data(PersonGuild) ->
	#guild_person{
				  
				  player_id = PlayerId,
				  guild_id = GuildId , %帮派id
				  get_progress = GetProgress0, %已经领取的关卡进步奖励
				  contribution = Contribution0, %贡献值
				  get_award = GetAward, %是否已经领取通关大奖
				  collection = Collection,  %采集数
				  kill_count = KillCount , %击杀数
				  damage_value = DamageValue %对boss造成的伤害血量
				 } = PersonGuild ,
	
	
	db:insert(guild_dungeon_data, [player_id, guild_id, get_progress, contribution, get_award, collection, kill_count, damage_value], 
			  [PlayerId, GuildId, util:term_to_bitstring(GetProgress0), util:term_to_bitstring(Contribution0), GetAward, Collection, KillCount, DamageValue]).

update_guild_person_data(#guild_person{player_id = PlayerId} = OldPersonGuild, NewPersonGuild ) ->
	case lists:foldl(fun({Pos, DbFiled}, {PosValAcc, DbFieldValAcc}) ->
							 NewVal = erlang:element(Pos, NewPersonGuild), 
							 case erlang:element(Pos, OldPersonGuild) =/= NewVal of
								 true ->
									 case lists:member(DbFiled, ?PERSON_TERM_POS_FIELD_LIST) of
										 true -> 
											 {[{Pos, NewVal}|PosValAcc], [{DbFiled, util:term_to_bitstring(NewVal)}|DbFieldValAcc]};
										 false -> 
											 {[{Pos, NewVal}|PosValAcc], [{DbFiled, NewVal}|DbFieldValAcc]}
									 end; 
								 _ ->
									 {PosValAcc, DbFieldValAcc}
							 end
					 end, {[], []}, ?PERSON_DATA_POS_FIELD_LIST) of
		
		{[], []} ->
			ok;
		{PosValueL, DbFieldValL} ->
			ets:update_element(?ETS_GUILD_PERSON_INFO, PlayerId, PosValueL),
			db:update(guild_dungeon_data, DbFieldValL, [{player_id, PlayerId}])
	end.



			
has_point(GuildWeek)  ->
	ets:member(?ETS_GUILD_POINT_INFO, GuildWeek).


get_point(GuildWeek) when is_integer(GuildWeek) ->
	case ets:lookup(?ETS_GUILD_POINT_INFO, GuildWeek) of
		[GDP] ->
			{ok, GDP};
		[] ->
			%% 没有则从db里查询？
			load_guild_dungeon(GuildWeek),
			case ets:lookup(?ETS_GUILD_POINT_INFO, GuildWeek) of
				[GDP] ->
					{ok, GDP};
				[] ->
					false
			end
	end.

gm_collect_point(PS,Point,Value) ->
	PlayerId = player:get_id(PS),
	GuildId =  player:get_guild_id(PlayerId),
	GuildPerson = mod_guild_dungeon:get_guild_person_from_ets(PlayerId),
	GuildWeek = list_to_integer(lists:concat([GuildId,Point])) ,
	Contribution = GuildPerson#guild_person.contribution,
	GuildPoint = mod_guild_dungeon:get_guild_dungeon_point_from_ets(GuildWeek),
	GuildNewDugeonData = data_guild_new_dungeon:get(Point), 
	Condition = GuildNewDugeonData#guild_new_dungeon.collect_num,
	Condition2 = GuildNewDugeonData#guild_new_dungeon.kill_num,
	case GuildPoint#guild_dungeon_point.collection >= Condition of
		false ->
			SceneId = GuildPoint#guild_dungeon_point.guild_scene_id,
			{ConValue2,Contribution2} = 
				case lists:keyfind(Point,1,Contribution) of
					false ->
						{Value,Contribution};
					{Point,ConValue} ->
						{ConValue + Value,lists:keydelete(Point,1,Contribution)}
				end,
			GuildPerson2 = GuildPerson#guild_person{
													collection = GuildPerson#guild_person.collection + Value,
													contribution = [{Point,ConValue2}] ++ Contribution2
												   },
			lib_guild_dungeon:update_guild_person_data(GuildPerson, GuildPerson2),
			DugeonRank = GuildPoint#guild_dungeon_point.rank,
			{RankValue2, DugeonRank2} = 
				case lists:keyfind(PlayerId, 1 ,DugeonRank) of
					false ->
						{Value,DugeonRank};
					{Key, _UserName, RankValue} ->
						{RankValue + Value,lists:keydelete(Key,1,DugeonRank)}
				end,
			DugeonRank3 = [{ PlayerId, player:get_name(PlayerId),RankValue2 }] ++ DugeonRank2,
			SortRankFun = fun({_PlayerId,_Name,Value},{_PlayerId2,_Name2,Value2}) ->
								  Value > Value2
						  end,
			DugeonRank4 = lists:sort(SortRankFun, DugeonRank3),
			ContributionRank = count_contribution(GuildPerson2),
			ColCount = GuildPoint#guild_dungeon_point.collection + Value,
			KillCount = GuildPoint#guild_dungeon_point.kill_count,
			mod_rank:role_dungeon_col_degree(PS, GuildPerson2#guild_person.collection),
			mod_rank:role_dungeon_contri_degree(PS, ContributionRank),
			GuildPoint2 = 
				case ColCount >= Condition  andalso  KillCount >= Condition2 of
					true ->
						%60秒后关
						Target = GuildNewDugeonData#guild_new_dungeon.target,
						F = fun({Type,No,_Count}) ->
									case Type =:= 1 of
										true ->
											mod_scene:clear_spec_no_dynamic_npc_from_scene_WNC(SceneId,No);%clearNPC
										false -> skip
									end
							end,
						lists:foreach(F, Target),
						mod_guild_dungeon:start_timer({point,SceneId,GuildWeek}),
						lib_guild_dungeon:send_detail_info2(player:get_PS(PlayerId), 0 ,ColCount, KillCount,Point,DugeonRank4,SceneId),
						GuildPoint#guild_dungeon_point{
													   progress = 1000,
													   collection = ColCount,
													   rank = DugeonRank4
													  };
					false ->
						lib_guild_dungeon:send_detail_info(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
						GuildPoint#guild_dungeon_point{
													   progress =GuildPoint#guild_dungeon_point.progress +  util:floor(Value/(Condition+Condition2) * 1000), %随便算的一个值，跟1000区分开来
													   collection = ColCount,
													   rank = DugeonRank4
													  }
				end,
			lib_guild_dungeon:update_point(GuildPoint, GuildPoint2);	
		true -> lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_POINT_PASS)
	end.

gm_kill_count(PS, Point, Value) ->
	PlayerId = player:get_id(PS),
	GuildId = player:get_guild_id(PlayerId),
	GuildPerson = mod_guild_dungeon:get_guild_person_from_ets(PlayerId),
	GuildWeek = list_to_integer(lists:concat([GuildId,Point])) ,
	Contribution = GuildPerson#guild_person.contribution,
	GuildPoint = mod_guild_dungeon:get_guild_dungeon_point_from_ets(GuildWeek),
	GuildNewDugeonData = data_guild_new_dungeon:get(Point), 
	Condition = GuildNewDugeonData#guild_new_dungeon.kill_num,
	Condition2 = GuildNewDugeonData#guild_new_dungeon.collect_num,
	case GuildPoint#guild_dungeon_point.kill_count >= Condition of
		false ->
			SceneId = GuildPoint#guild_dungeon_point.guild_scene_id,
			{ConValue2,Contribution2} = 
				case lists:keyfind(Point,1,Contribution) of
					false ->
						{Value,Contribution};
					{Point,ConValue} ->
						{ConValue + Value,lists:keydelete(Point,1,Contribution)}
				end,
			GuildPerson2 = GuildPerson#guild_person{
													kill_count = GuildPerson#guild_person.kill_count + Value,
													contribution = [{Point,ConValue2}] ++ Contribution2
												   },
			lib_guild_dungeon:update_guild_person_data(GuildPerson, GuildPerson2),
			
			ContributionRank = count_contribution(GuildPerson2),
			mod_rank:role_dungeon_contri_degree(PS, ContributionRank),
			
			DugeonRank = GuildPoint#guild_dungeon_point.rank,
			{RankValue2, DugeonRank2} = 
				case lists:keyfind(PlayerId,1,DugeonRank) of
					false ->
						{Value,DugeonRank};
					{Key, _UserName, RankValue} ->
						{RankValue + Value,lists:keydelete(Key,1,DugeonRank)}
				end,
			DugeonRank3 = [{ PlayerId, player:get_name(PlayerId),RankValue2 }] ++ DugeonRank2,
			SortRankFun = fun({_PlayerId,_Name,Value},{_PlayerId2,_Name2,Value2}) ->
								  Value > Value2
						  end,
			DugeonRank4 = lists:sort(SortRankFun, DugeonRank3),
			
			KillCount = GuildPoint#guild_dungeon_point.kill_count + Value,
			ColCount = GuildPoint#guild_dungeon_point.collection,
			mod_rank:role_dungeon_kill_degree(PS, GuildPerson2#guild_person.kill_count),
			GuildPoint2 = 
				case KillCount >= Condition andalso ColCount >= Condition2  of
					true ->
						%60秒后关
						mod_guild_dungeon:start_timer({point,SceneId,GuildWeek}),
						lib_guild_dungeon:send_detail_info2(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
						GuildPoint#guild_dungeon_point{
													   progress = 1000,
													   kill_count = KillCount,
													   rank = DugeonRank4
													  };
					false ->
						lib_guild_dungeon:send_detail_info(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
						GuildPoint#guild_dungeon_point{
													   progress =GuildPoint#guild_dungeon_point.progress +  util:floor(Value/(Condition+Condition2) * 1000), %随便算的一个值，跟1000区分开来
													   kill_count = KillCount,
													   rank = DugeonRank4
													  }
				end,
			lib_guild_dungeon:update_point(GuildPoint, GuildPoint2);	
		true -> lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_POINT_PASS)
	end.


%掉落 1为杀怪掉落类型,2为采集掉落类型
gm_drop_count(PS,Point,Value) ->
	RandomValue = 10, %二分之的机会获得掉落的物品
	case RandomValue > 5 of
		true ->
			lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_DROP),
			PlayerId = player:get_id(PS),
			GuildId =  player:get_guild_id(PlayerId),
			GuildPerson = mod_guild_dungeon:get_guild_person_from_ets(PlayerId),
			Point = GuildPerson#guild_person.doing_point,
			GuildWeek = list_to_integer(lists:concat([GuildId,Point])) ,
			Contribution = GuildPerson#guild_person.contribution,
			GuildPoint = mod_guild_dungeon:get_guild_dungeon_point_from_ets(GuildWeek),
			GuildNewDugeonData = data_guild_new_dungeon:get(Point), 
			Condition = GuildNewDugeonData#guild_new_dungeon.kill_num,
			Condition2 = GuildNewDugeonData#guild_new_dungeon.collect_num,
			case Point of
				3 ->	
					case GuildPoint#guild_dungeon_point.kill_count =:= Condition of
						false ->
							SceneId = GuildPoint#guild_dungeon_point.guild_scene_id,
							{ConValue2,Contribution2} = 
								case lists:keyfind(Point,1,Contribution) of
									false ->
										{Value,Contribution};
									{Point,ConValue} ->
										{ConValue + Value,lists:keydelete(Point,1,Contribution)}
								end,
							GuildPerson2 = GuildPerson#guild_person{
																	collection = GuildPerson#guild_person.collection + Value,
																	contribution = [{Point,ConValue2}] ++ Contribution2
																   },
							lib_guild_dungeon:update_guild_person_data(GuildPerson, GuildPerson2),
							DugeonRank = GuildPoint#guild_dungeon_point.rank,
							{RankValue2, DugeonRank2} = 
								case lists:keyfind(PlayerId,1,DugeonRank) of
									false ->
										{Value,DugeonRank};
									{Key, _UserName, RankValue} ->
										{RankValue + Value,lists:keydelete(Key,1,DugeonRank)}
								end,
							DugeonRank3 = [{ PlayerId, player:get_name(PlayerId),RankValue2 }] ++ DugeonRank2,
							SortRankFun = fun({_PlayerId,_Name,Value},{_PlayerId2,_Name2,Value2}) ->
												  Value > Value2
										  end,
							DugeonRank4 = lists:sort(SortRankFun, DugeonRank3),
							
							KillCount = GuildPoint#guild_dungeon_point.kill_count + Value,
							ColCount = GuildPoint#guild_dungeon_point.collection,
							mod_rank:role_dungeon_col_degree(PS, GuildPerson2#guild_person.collection),
							ContributionRank = count_contribution(GuildPerson2),
							mod_rank:role_dungeon_contri_degree(PS, ContributionRank),
							GuildPoint2 = 
								case KillCount >= Condition andalso ColCount >= Condition2  of
									true ->
										%60秒后关
										mod_guild_dungeon:start_timer({point,SceneId,GuildWeek}),
										lib_guild_dungeon:send_detail_info2(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
										GuildPoint#guild_dungeon_point{
																	   progress = 1000,
																	   kill_count = KillCount,
																	   rank = DugeonRank4
																	  };
									false ->
										lib_guild_dungeon:send_detail_info(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
										GuildPoint#guild_dungeon_point{
																	   progress =GuildPoint#guild_dungeon_point.progress +  util:floor(Value/(Condition+Condition2) * 1000), %随便算的一个值，跟1000区分开来
																	   kill_count = KillCount,
																	   rank = DugeonRank4
																	  }
								end,
							lib_guild_dungeon:update_point(GuildPoint, GuildPoint2);	
						true -> lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_POINT_PASS)
					end;
				
				6 ->
					case GuildPoint#guild_dungeon_point.collection =:= Condition2 of
						false ->
							SceneId = GuildPoint#guild_dungeon_point.guild_scene_id,
							{ConValue2,Contribution2} = 
								case lists:keyfind(Point,1,Contribution) of
									false ->
										{Value,Contribution};
									{Point,ConValue} ->
										{ConValue + Value,lists:keydelete(Point,1,Contribution)}
								end,
							GuildPerson2 = GuildPerson#guild_person{
																	collection = GuildPerson#guild_person.collection + Value,
																	contribution = [{Point,ConValue2}] ++ Contribution2
																   },
							lib_guild_dungeon:update_guild_person_data(GuildPerson, GuildPerson2),
							DugeonRank = GuildPoint#guild_dungeon_point.rank,
							{RankValue2, DugeonRank2} = 
								case lists:keyfind(PlayerId,1,DugeonRank) of
									false ->
										{Value,DugeonRank};
									{Key, _UserName, RankValue} ->
										{RankValue + Value,lists:keydelete(Key,1,DugeonRank)}
								end,
							DugeonRank3 = [{ PlayerId, player:get_name(PlayerId),RankValue2 }] ++ DugeonRank2,
							SortRankFun = fun({_PlayerId,_Name,Value},{_PlayerId2,_Name2,Value2}) ->
												  Value > Value2
										  end,
							DugeonRank4 = lists:sort(SortRankFun, DugeonRank3),
							
							KillCount = GuildPoint#guild_dungeon_point.kill_count ,
							ColCount = GuildPoint#guild_dungeon_point.collection + Value,
							mod_rank:role_dungeon_col_degree(PS, GuildPerson2#guild_person.collection),
							ContributionRank = count_contribution(GuildPerson2),
							mod_rank:role_dungeon_contri_degree(PS, ContributionRank),
							GuildPoint2 = 
								case KillCount >= Condition andalso ColCount >= Condition2  of
									true ->
										%60秒后关
										mod_guild_dungeon:start_timer({Point,SceneId,GuildWeek}),
										lib_guild_dungeon:send_detail_info2(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
										GuildPoint#guild_dungeon_point{
																	   progress = 1000,
																	   collection = ColCount,
																	   rank = DugeonRank4
																	  };
									false ->
										lib_guild_dungeon:send_detail_info(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
										GuildPoint#guild_dungeon_point{
																	   progress =GuildPoint#guild_dungeon_point.progress +  util:floor(Value/(Condition+Condition2) * 1000), %随便算的一个值，跟1000区分开来
																	   collection = ColCount,
																	   rank = DugeonRank4
																	  }
								end,
							lib_guild_dungeon:update_point(GuildPoint, GuildPoint2);	
						true -> lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_POINT_PASS)
					end;
				_ ->skip
			end
	end.



%%采集关卡
collect_point(PS,NpcId) ->
	PlayerId = player:get_id(PS),
	GuildId =  player:get_guild_id(PlayerId),
	GuildPerson = mod_guild_dungeon:get_guild_person_from_ets(PlayerId),
	Point = GuildPerson#guild_person.doing_point,
	GuildWeek = list_to_integer(lists:concat([GuildId,Point])) ,
	Contribution = GuildPerson#guild_person.contribution,
	GuildPoint = mod_guild_dungeon:get_guild_dungeon_point_from_ets(GuildWeek),
	GuildNewDugeonData = data_guild_new_dungeon:get(Point), 
	Condition = GuildNewDugeonData#guild_new_dungeon.collect_num,
	Condition2 = GuildNewDugeonData#guild_new_dungeon.kill_num,
	case GuildPoint#guild_dungeon_point.collection =:= Condition of
		false ->
			SceneId = GuildPoint#guild_dungeon_point.guild_scene_id,
			{ConValue2,Contribution2} = 
				case lists:keyfind(Point,1,Contribution) of
					false ->
						{1,Contribution};
					{Point,ConValue} ->
						{ConValue + 1,lists:keydelete(Point,1,Contribution)}
				end,
			GuildPerson2 = GuildPerson#guild_person{
													collection = GuildPerson#guild_person.collection + 1,
													contribution = [{Point,ConValue2}] ++ Contribution2
												   },
			lib_guild_dungeon:update_guild_person_data(GuildPerson, GuildPerson2),
			DugeonRank = GuildPoint#guild_dungeon_point.rank,
			{RankValue2, DugeonRank2} = 
				case lists:keyfind(PlayerId, 1 ,DugeonRank) of
					false ->
						{1,DugeonRank};
					{Key, _UserName, RankValue} ->
						{RankValue + 1,lists:keydelete(Key,1,DugeonRank)}
				end,
			DugeonRank3 = [{ PlayerId, player:get_name(PlayerId),RankValue2 }] ++ DugeonRank2,
			SortRankFun = fun({_PlayerId,_Name,Value},{_PlayerId2,_Name2,Value2}) ->
								  Value > Value2
						  end,
			DugeonRank4 = lists:sort(SortRankFun, DugeonRank3),
			ContributionRank = count_contribution(GuildPerson2),
			mod_rank:role_dungeon_contri_degree(PS, ContributionRank),
			
			ColCount = GuildPoint#guild_dungeon_point.collection + 1,
			KillCount = GuildPoint#guild_dungeon_point.kill_count,
			mod_rank:role_dungeon_col_degree(PS, GuildPerson2#guild_person.collection),
			GuildPoint2 = 
				case ColCount =:= Condition  andalso  KillCount =:= Condition2 of
					true ->
						%60秒后关
                        case Point of
							1 -> mod_broadcast:send_sys_broadcast(398 , [mod_guild:get_guild_name_by_playerid(PlayerId)]);
							3 -> mod_broadcast:send_sys_broadcast(400 , [mod_guild:get_guild_name_by_playerid(PlayerId)]);
							5 -> mod_broadcast:send_sys_broadcast(402 , [mod_guild:get_guild_name_by_playerid(PlayerId)]);
							_ -> skip
						end,
				
						Target = GuildNewDugeonData#guild_new_dungeon.target,
						F = fun({Type,No,_Count}) ->
									case Type =:= 1 of
										true ->
											mod_scene:clear_spec_no_dynamic_npc_from_scene_WNC(SceneId,No);%clearNPC
										false -> skip
									end
							end,
						lists:foreach(F, Target),
						mod_guild_dungeon:start_timer({point,SceneId,GuildWeek}),
						lib_guild_dungeon:send_detail_info2(player:get_PS(PlayerId), 0 ,ColCount, KillCount,Point,DugeonRank4,SceneId),
						GuildPoint#guild_dungeon_point{
													   progress = 1000,
													   collection = ColCount,
													   rank = DugeonRank4
													  };
					false ->
						lib_guild_dungeon:send_detail_info(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
						GuildPoint#guild_dungeon_point{
													   progress =GuildPoint#guild_dungeon_point.progress +  util:floor(1/(Condition+Condition2) * 1000), %随便算的一个值，跟1000区分开来
													   collection = ColCount,
													   rank = DugeonRank4
													  }
				end,
			mod_scene_mgr:force_clear_dynamic_npc_from_scene_WNC(NpcId),
			mod_guild_dungeon:refresh_mon({refresh, 1 ,mod_npc:get_no_by_id(NpcId),Point,SceneId}),
			lib_guild_dungeon:update_point(GuildPoint, GuildPoint2);	
		true -> lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_POINT_PASS)
	end.

kill_count(PS, MonId) ->
	PlayerId = player:get_id(PS),
	GuildId = player:get_guild_id(PlayerId),
	GuildPerson = mod_guild_dungeon:get_guild_person_from_ets(PlayerId),
	Point = GuildPerson#guild_person.doing_point,
	GuildWeek = list_to_integer(lists:concat([GuildId,Point])) ,
	Contribution = GuildPerson#guild_person.contribution,
	GuildPoint = mod_guild_dungeon:get_guild_dungeon_point_from_ets(GuildWeek),
	GuildNewDugeonData = data_guild_new_dungeon:get(Point), 
	Condition = GuildNewDugeonData#guild_new_dungeon.kill_num,
	Condition2 = GuildNewDugeonData#guild_new_dungeon.collect_num,
	case GuildPoint#guild_dungeon_point.kill_count =:= Condition of
		false ->
			SceneId = GuildPoint#guild_dungeon_point.guild_scene_id,
			{ConValue2,Contribution2} = 
				case lists:keyfind(Point,1,Contribution) of
					false ->
						{1,Contribution};
					{Point,ConValue} ->
						{ConValue + 1,lists:keydelete(Point,1,Contribution)}
				end,
			GuildPerson2 = GuildPerson#guild_person{
													kill_count = GuildPerson#guild_person.kill_count + 1,
													contribution = [{Point,ConValue2}] ++ Contribution2
												   },
			lib_guild_dungeon:update_guild_person_data(GuildPerson, GuildPerson2),
			
			ContributionRank = count_contribution(GuildPerson2),
			mod_rank:role_dungeon_contri_degree(PS, ContributionRank),
			
			DugeonRank = GuildPoint#guild_dungeon_point.rank,
			{RankValue2, DugeonRank2} = 
				case lists:keyfind(PlayerId,1,DugeonRank) of
					false ->
						{1,DugeonRank};
					{Key, _UserName, RankValue} ->
						{RankValue + 1,lists:keydelete(Key,1,DugeonRank)}
				end,
			DugeonRank3 = [{ PlayerId, player:get_name(PlayerId),RankValue2 }] ++ DugeonRank2,
			SortRankFun = fun({_PlayerId,_Name,Value},{_PlayerId2,_Name2,Value2}) ->
								  Value > Value2
						  end,
			DugeonRank4 = lists:sort(SortRankFun, DugeonRank3),
			
			KillCount = GuildPoint#guild_dungeon_point.kill_count + 1,
			ColCount = GuildPoint#guild_dungeon_point.collection,
			mod_rank:role_dungeon_kill_degree(PS, GuildPerson2#guild_person.kill_count),
			GuildPoint2 = 
				case KillCount =:= Condition andalso ColCount =:= Condition2  of
					true ->
						%60秒后关
						case Point of
							2 -> mod_broadcast:send_sys_broadcast(399 , [mod_guild:get_guild_name_by_playerid(PlayerId)]);
							6 -> mod_broadcast:send_sys_broadcast(403 , [mod_guild:get_guild_name_by_playerid(PlayerId)]);
							4 -> mod_broadcast:send_sys_broadcast(401 , [mod_guild:get_guild_name_by_playerid(PlayerId)]);
							_ -> skip
						end,
						mod_guild_dungeon:start_timer({point,SceneId,GuildWeek}),
						lib_guild_dungeon:send_detail_info2(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
						GuildPoint#guild_dungeon_point{
													   progress = 1000,
													   kill_count = KillCount,
													   rank = DugeonRank4
													  };
					false ->
						lib_guild_dungeon:send_detail_info(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
						GuildPoint#guild_dungeon_point{
													   progress =GuildPoint#guild_dungeon_point.progress +  util:floor(1/(Condition+Condition2) * 1000), %随便算的一个值，跟1000区分开来
													   kill_count = KillCount,
													   rank = DugeonRank4
													  }
				end,
			mod_guild_dungeon:refresh_mon({refresh, 2 , MonId ,Point,SceneId}),
			lib_guild_dungeon:update_point(GuildPoint, GuildPoint2);	
		true -> lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_POINT_PASS)
	end.

%掉落 1为杀怪掉落类型,2为采集掉落类型
drop_count(PS, MonId,Type) ->
	RandomValue = random:uniform(10), %二分之的机会获得掉落的物品
	case RandomValue > 5 of
		true ->
			lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_DROP),
			PlayerId = player:get_id(PS),
			GuildId =  player:get_guild_id(PlayerId),
			GuildPerson = mod_guild_dungeon:get_guild_person_from_ets(PlayerId),
			Point = GuildPerson#guild_person.doing_point,
			GuildWeek = list_to_integer(lists:concat([GuildId,Point])) ,
			Contribution = GuildPerson#guild_person.contribution,
			GuildPoint = mod_guild_dungeon:get_guild_dungeon_point_from_ets(GuildWeek),
			GuildNewDugeonData = data_guild_new_dungeon:get(Point), 
			Condition = GuildNewDugeonData#guild_new_dungeon.kill_num,
			Condition2 = GuildNewDugeonData#guild_new_dungeon.collect_num,
			case Type of
				1 ->	
					case GuildPoint#guild_dungeon_point.kill_count =:= Condition of
						false ->
							SceneId = GuildPoint#guild_dungeon_point.guild_scene_id,
							{ConValue2,Contribution2} = 
								case lists:keyfind(Point,1,Contribution) of
									false ->
										{1,Contribution};
									{Point,ConValue} ->
										{ConValue + 1,lists:keydelete(Point,1,Contribution)}
								end,
							GuildPerson2 = GuildPerson#guild_person{
																	collection = GuildPerson#guild_person.collection +1,
																	contribution = [{Point,ConValue2}] ++ Contribution2
																   },
							lib_guild_dungeon:update_guild_person_data(GuildPerson, GuildPerson2),
							DugeonRank = GuildPoint#guild_dungeon_point.rank,
							{RankValue2, DugeonRank2} = 
								case lists:keyfind(PlayerId,1,DugeonRank) of
									false ->
										{1,DugeonRank};
									{Key, _UserName, RankValue} ->
										{RankValue + 1,lists:keydelete(Key,1,DugeonRank)}
								end,
							DugeonRank3 = [{ PlayerId, player:get_name(PlayerId),RankValue2 }] ++ DugeonRank2,
							SortRankFun = fun({_PlayerId,_Name,Value},{_PlayerId2,_Name2,Value2}) ->
												  Value > Value2
										  end,
							DugeonRank4 = lists:sort(SortRankFun, DugeonRank3),
							ColCount = GuildPoint#guild_dungeon_point.collection,
							KillCount = GuildPoint#guild_dungeon_point.kill_count + 1 ,
							RankColCount = GuildPerson2#guild_person.collection,
							mod_rank:role_dungeon_col_degree(PS, RankColCount),
							ContributionRank = count_contribution(GuildPerson2),
							mod_rank:role_dungeon_contri_degree(PS, ContributionRank),
							mod_guild_dungeon:refresh_mon({refresh, 2 , MonId ,Point,SceneId}),
							GuildPoint2 = 
								case KillCount =:= Condition andalso ColCount =:= Condition2  of
									true ->
										%60秒后关
										case Point of
											3 -> mod_broadcast:send_sys_broadcast(400 , [mod_guild:get_guild_name_by_playerid(PlayerId)]);									
											_ -> skip
										end,
										mod_guild_dungeon:start_timer({point,SceneId,GuildWeek}),
										lib_guild_dungeon:send_detail_info2(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
										GuildPoint#guild_dungeon_point{
																	   progress = 1000,
																	   kill_count = KillCount,
																	   rank = DugeonRank4
																	  };
									false ->
										lib_guild_dungeon:send_detail_info(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
										GuildPoint#guild_dungeon_point{
																	   progress =GuildPoint#guild_dungeon_point.progress +  util:floor(1/(Condition+Condition2) * 1000), %随便算的一个值，跟1000区分开来
																	   kill_count = KillCount,
																	   rank = DugeonRank4
																	  }
								end,
							lib_guild_dungeon:update_point(GuildPoint, GuildPoint2);	
						true -> lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_POINT_PASS)
					end;
				
				2 ->
					case GuildPoint#guild_dungeon_point.collection =:= Condition2 of
						false ->
							SceneId = GuildPoint#guild_dungeon_point.guild_scene_id,
							{ConValue2,Contribution2} = 
								case lists:keyfind(Point,1,Contribution) of
									false ->
										{1,Contribution};
									{Point,ConValue} ->
										{ConValue + 1,lists:keydelete(Point,1,Contribution)}
								end,
							GuildPerson2 = GuildPerson#guild_person{
																	collection = GuildPerson#guild_person.collection + 1,
																	contribution = [{Point,ConValue2}] ++ Contribution2
																   },
							lib_guild_dungeon:update_guild_person_data(GuildPerson, GuildPerson2),
							DugeonRank = GuildPoint#guild_dungeon_point.rank,
							{RankValue2, DugeonRank2} = 
								case lists:keyfind(PlayerId,1,DugeonRank) of
									false ->
										{1,DugeonRank};
									{Key, _UserName, RankValue} ->
										{RankValue + 1,lists:keydelete(Key,1,DugeonRank)}
								end,
							DugeonRank3 = [{ PlayerId, player:get_name(PlayerId),RankValue2 }] ++ DugeonRank2,
							SortRankFun = fun({_PlayerId,_Name,Value},{_PlayerId2,_Name2,Value2}) ->
												  Value > Value2
										  end,
							DugeonRank4 = lists:sort(SortRankFun, DugeonRank3),
							
							KillCount = GuildPoint#guild_dungeon_point.kill_count ,
							RankColCount = GuildPerson2#guild_person.collection,
							ColCount = GuildPoint#guild_dungeon_point.collection + 1,
							mod_rank:role_dungeon_col_degree(PS, RankColCount),
							ContributionRank = count_contribution(GuildPerson2),
							mod_rank:role_dungeon_contri_degree(PS, ContributionRank),
							mod_guild_dungeon:refresh_mon({refresh, 2 , MonId ,Point,SceneId}),
							GuildPoint2 = 
								case KillCount =:= Condition andalso ColCount =:= Condition2  of
									true ->
										%60秒后关
										case Point of
											6 -> mod_broadcast:send_sys_broadcast(403 , [mod_guild:get_guild_name_by_playerid(PlayerId)]);
											_ -> skip
										end,
										mod_guild_dungeon:start_timer({point,SceneId,GuildWeek}),
										lib_guild_dungeon:send_detail_info2(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
										GuildPoint#guild_dungeon_point{
																	   progress = 1000,
																	   collection = ColCount,
																	   rank = DugeonRank4
																	  };
									false ->
										lib_guild_dungeon:send_detail_info(player:get_PS(PlayerId), 0 ,ColCount,KillCount,Point,DugeonRank4,SceneId),
										GuildPoint#guild_dungeon_point{
																	   progress =GuildPoint#guild_dungeon_point.progress +  util:floor(1/(Condition+Condition2) * 1000), %随便算的一个值，跟1000区分开来
																	   collection = ColCount,
																	   rank = DugeonRank4
																	  }
								end,
							lib_guild_dungeon:update_point(GuildPoint, GuildPoint2);	
						true -> lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_POINT_PASS)
					end
			end;
		false -> skip
	end.

kill_boss_count(PS) ->
	PlayerId = player:get_id(PS),
	GuildId = player:get_guild_id(PlayerId),
	GuildPerson = mod_guild_dungeon:get_guild_person_from_ets(PlayerId),
	Point = GuildPerson#guild_person.doing_point,
	GuildWeek = list_to_integer(lists:concat([GuildId,Point])) ,
	GuildPoint = mod_guild_dungeon:get_guild_dungeon_point_from_ets(GuildWeek),
	GuildNewDugeonData = data_guild_new_dungeon:get(Point), 
	Condition = GuildNewDugeonData#guild_new_dungeon.kill_num,
	%Condition2 = GuildNewDugeonData#guild_new_dungeon.collect_num,
	case GuildPoint#guild_dungeon_point.kill_count =:= Condition of
		false ->
			SceneId = GuildPoint#guild_dungeon_point.guild_scene_id,
			%ColCount = GuildPoint#guild_dungeon_point.collection,
			KillCount = GuildPoint#guild_dungeon_point.kill_count + 1,
			GuildPoint2 = 
				case KillCount =:= Condition  of
					true ->
						%60秒后关
						%mod_guild_dungeon:start_timer({Point,SceneId,GuildWeek}),
						%开启第七关的BOSS
						mod_guild_dungeon:refresh_boss( { boss, 35171,Point ,SceneId} ),
						GuildPoint#guild_dungeon_point{
													   progress = 0,
													   kill_count = KillCount
													  };
					false ->
						GuildPoint#guild_dungeon_point{
													   progress =0,
													   kill_count = KillCount
													  }
				end,
			lib_guild_dungeon:send_detail_info4(PS, 0 ,0 ,KillCount,SceneId,[]),
			lib_guild_dungeon:update_point(GuildPoint, GuildPoint2);	
		true -> lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_POINT_PASS)
	end.


cal_boss_hp(PS,Value) ->
	PlayerId = player:get_id(PS),
	GuildId = player:get_guild_id(PlayerId),
	GuildPerson = mod_guild_dungeon:get_guild_person_from_ets(PlayerId),
	Point = GuildPerson#guild_person.doing_point,
	GuildWeek = list_to_integer(lists:concat([GuildId,Point])) ,
	GuildPoint = mod_guild_dungeon:get_guild_dungeon_point_from_ets(GuildWeek),
	GuildNewDugeonData = data_guild_new_dungeon:get(Point), 
	Condition = GuildNewDugeonData#guild_new_dungeon.boss_hp, 
	%Condition = GuildNewDugeonData#guild_new_dungeon.kill_num,
	%Condition2 = GuildNewDugeonData#guild_new_dungeon.collect_num,
	Contribution = GuildPerson#guild_person.contribution,
	SceneId = GuildPoint#guild_dungeon_point.guild_scene_id,
	DamageCount =  Value,
	{ConValue2,Contribution2} = 
		case lists:keyfind(Point, 1 ,Contribution) of
			false ->
				{ util:floor((Value/Condition) * 1000) , Contribution};
			{Point,ConValue} ->
				{ConValue + util:floor((Value/Condition) * 1000) ,lists:keydelete(Point,1,Contribution)}
		end,
	GuildPerson2 = GuildPerson#guild_person{
											damage_value = DamageCount,
											contribution = [{Point,ConValue2}] ++ Contribution2
										   },
	lib_guild_dungeon:update_guild_person_data(GuildPerson, GuildPerson2),
	DugeonRank = GuildPoint#guild_dungeon_point.rank,
	{RankValue2, DugeonRank2} = 
		case lists:keyfind(PlayerId,1,DugeonRank) of
			false ->
				{Value,DugeonRank};
			{Key, _UserName, RankValue} ->
				mod_rank:role_dungeon_damage_degree(PS, RankValue + Value),
				{RankValue + Value,lists:keydelete(Key,1,DugeonRank)}
		end,
	DugeonRank3 = [{ PlayerId, player:get_name(PlayerId),RankValue2 }] ++ DugeonRank2,
	SortRankFun = fun({_PlayerId,_Name,Value},{_PlayerId2,_Name2,Value2}) ->
						  Value > Value2
				  end,
	DugeonRank4 = lists:sort(SortRankFun, DugeonRank3),
	ContributionRank = count_contribution(GuildPerson2),
	mod_rank:role_dungeon_contri_degree(PS, ContributionRank),	
	
	%ColCount = GuildPoint#guild_dungeon_point.collection,
	GuildPoint2 = 
		case (GuildPoint#guild_dungeon_point.boss_hp +  DamageCount) >= Condition  of
			true ->
				%60秒后关
				%mod_guild_dungeon:start_timer({Point,SceneId,GuildWeek}),
				%开启第七关的BOSS
				case Point of
					7 -> mod_broadcast:send_sys_broadcast(404 , [mod_guild:get_guild_name_by_playerid(PlayerId)]);
					_ -> skip
				end,
				mod_guild_dungeon:finish_boss( { finishboss ,SceneId} ),
				mod_guild_dungeon:quit_boss( { quitboss ,SceneId,GuildWeek} ),
				GuildPoint#guild_dungeon_point{
											   progress = 1000,
											   boss_hp =Condition ,                                             
											   kill_count = 1,
											   rank = DugeonRank4
											  };
			false ->
				GuildPoint#guild_dungeon_point{
											   progress =GuildPoint#guild_dungeon_point.progress +  util:floor( (DamageCount/Condition) *1000 ),
											   boss_hp =GuildPoint#guild_dungeon_point.boss_hp +  DamageCount,
                                               rank = DugeonRank4
											  }
		end,
	LeftHp = (Condition - GuildPoint#guild_dungeon_point.boss_hp -  DamageCount),
	KillCount = 
		case LeftHp == 0 of
			true ->
				1;
			false -> 0
		end,
	%PS, BossHp ,BossCount ,KillCount,SceneId
	lib_guild_dungeon:send_detail_info4(PS, GuildPoint#guild_dungeon_point.boss_hp +  DamageCount ,KillCount ,20,SceneId,DugeonRank4),
	lib_guild_dungeon:update_point(GuildPoint, GuildPoint2).


%统计玩家所有关卡的贡献值
count_contribution(GuildPerson) ->
	Contribution =GuildPerson#guild_person.contribution,
	F = fun({_Point,Value},Acc) ->
				Acc + Value
		end,
	lists:foldl(F, 0, Contribution).
	


%创建数据，在有帮派的基础上
get_person_data(PS) ->
	PlayerId = player:get_id(PS),
	case mod_guild_dungeon:get_guild_person_from_ets(PlayerId) of
		null -> 
			load_guild_person(PlayerId),
			case mod_guild_dungeon:get_guild_person_from_ets(PlayerId) of
				null ->
					create_player_data(PlayerId),
					case mod_guild_dungeon:get_guild_person_from_ets(PlayerId) of
						null -> fail;
						GuildPerson ->
							GuildPerson
					end;
				GuildPerson ->
							GuildPerson
			end;
		GuildPerson ->
			case GuildPerson#guild_person.guild_id of
				0 ->
					load_guild_person(PlayerId),
					case mod_guild_dungeon:get_guild_person_from_ets(PlayerId) of
						null ->
							create_player_data(PlayerId),
							case mod_guild_dungeon:get_guild_person_from_ets(PlayerId) of
								null -> fail;
								GuildPerson ->
									GuildPerson
							end;
						GuildPerson ->
							GuildPerson
					end;
				_ ->
					GuildPerson
			end
	end.
	
					
