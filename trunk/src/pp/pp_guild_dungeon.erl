%% @author JKYL
%% @doc @todo Add description to pp_guild_dungeon.


-module(pp_guild_dungeon).

%% ====================================================================
%% API functions
%% ====================================================================
-export([handle/3]).
-compile(export_all).

-include("common.hrl").
-include("pt_53.hrl").
-include("guild_dungeon.hrl").
-include("prompt_msg_code.hrl").
-include("reward.hrl").
-include("log.hrl").



handle(?PT_GET_GUILD_INFO,PS,[]) ->
	PlayerId = player:get_id(PS),
	case player:get_lv(PlayerId) >= ?GUILD_NEW_DUNGEON_OPEN_LV of 
		true ->
			case player:get_guild_id(PlayerId) of
				?INVALID_ID -> lib_send:send_prompt_msg(PS, ?PM_NOT_JOIN_GUILD_YET);
				_ID ->		
					GuildId = player:get_guild_id(PlayerId),
					DataGuildInfo = data_guild_new_dungeon:get(7),
					DataBossHp = DataGuildInfo#guild_new_dungeon.boss_hp,
					GuildPerson = lib_guild_dungeon:get_person_data(PS),
					IsAward = case util:get_week() of 
								  7 ->
									  
									  {ok , GuildPointData} =
										  case lib_guild_dungeon:get_point(list_to_integer(lists:concat([GuildId,7]))) of
											  {ok , GDP} -> {ok , GDP};
											  false -> lib_guild_dungeon:create_dungeon_point(PS,7),
													   lib_guild_dungeon:get_point(list_to_integer(lists:concat([GuildId,7])))
										  end,
									  Progress = GuildPointData#guild_dungeon_point.progress,
									  BoosHp = GuildPointData#guild_dungeon_point.boss_hp,
									  GetAward =GuildPerson#guild_person.get_award,
									  case GetAward of
										  1 ->  1 ;
										  _ -> case Progress >= 1000 orelse BoosHp >= DataBossHp of
												   true -> 0 ;
												   false -> 2
											   end
									  end;
								  
								  
								  
								  _ -> 2
							  end,
					
						
					Sql = lists:concat(["select week_point from guild_dungeon where guild_id = ", GuildId  ," AND ( progress = ",1000 , " or boss_hp = ",DataBossHp," )"]),
					case db:select_all(guild_dungeon,Sql) of
						List when is_list(List) ->
							FinishPoint = length(List),
							{ok,Bin} = pt_53:write(?PT_GET_GUILD_INFO, [FinishPoint,IsAward]),
							lib_send:send_to_sock(PS, Bin);
						Err ->
							?ERROR_MSG("server_start_init Err : ~p~n", [Err])
					end
			end;
		
		false ->
			lib_send:send_prompt_msg(PS, ?PM_LV_LIMIT)
	end;


  
handle(?PT_GET_POINT_INFO,PS,[Point]) ->
	PlayerId = player:get_id(PS),
	case player:get_guild_id(PlayerId) of
		?INVALID_ID -> lib_send:send_prompt_msg(PS, ?PM_NOT_JOIN_GUILD_YET);
		_ID ->			
			GuildId = player:get_guild_id(PlayerId),
			GuildPerson = lib_guild_dungeon:get_person_data(PS),
			ContributionLits = GuildPerson#guild_person.contribution,
			Contribution =  case lists:keyfind(Point, 1, ContributionLits) of
								false -> 0;
								{_Point,Value} -> Value
							end,
			GetProgressLists =GuildPerson#guild_person.get_progress,
			GetProgress00 =  case lists:keyfind(Point, 1, GetProgressLists) of
								 false -> {};
								 HaveValue -> HaveValue
							 end,
			GetProgress0 = tuple_to_list(GetProgress00),
			
			GetProgress = case length(GetProgress0) > 0 of
							  true -> lists:sublist(GetProgress0, 2, length(GetProgress0) - 1);
							  false -> []
						  end,
			{ok , GuildPersonDungeon} =
				case lib_guild_dungeon:get_point(list_to_integer(lists:concat([GuildId,Point]))) of
					{ok , GDP} -> {ok , GDP};
					false -> lib_guild_dungeon:create_dungeon_point(PS,Point),
							 lib_guild_dungeon:get_point(list_to_integer(lists:concat([GuildId,Point])))
				end,
			Progress = GuildPersonDungeon#guild_dungeon_point.progress,
			FinishValue = case Point =:= 7 of
							  true -> 
								  GuildPersonDungeon#guild_dungeon_point.boss_hp;
							  false -> GuildPersonDungeon#guild_dungeon_point.collection + GuildPersonDungeon#guild_dungeon_point.kill_count 
						  end,
			{ok,Bin} = pt_53:write(?PT_GET_POINT_INFO, [Point,Progress,Contribution,FinishValue,GetProgress]),
			lib_send:send_to_sock(PS, Bin)
	end;


handle(?PT_GET_REWARD,PS,[Point,Reward]) ->
	PlayerId = player:get_id(PS),
	case player:get_guild_id(PlayerId) of
		?INVALID_ID -> lib_send:send_prompt_msg(PS, ?PM_NOT_JOIN_GUILD_YET);
		_Id ->
			
			case Reward of 
				0 ->
					%判断是否完成了所有关卡
					GuildId = player:get_guild_id(PlayerId),
					LastGuildWeek = list_to_integer(lists:concat([GuildId,7])),
					LastGuildData = mod_guild_dungeon:get_guild_dungeon_point_from_ets(LastGuildWeek),
					Progress = LastGuildData#guild_dungeon_point.progress,
					BossHp = LastGuildData#guild_dungeon_point.boss_hp,
					DataGuildInfo = data_guild_new_dungeon:get(7),
					DataBossHp = DataGuildInfo#guild_new_dungeon.boss_hp,
					case Progress =:= 1000 orelse BossHp =:= DataBossHp  of
						true ->
							%判断是否领取过
							PersonData = mod_guild_dungeon:get_guild_person_from_ets(PlayerId),
							DataGuild = data_guild_new_dungeon:get(7),
							RewardNo = DataGuild#guild_new_dungeon.total_reward,
							Datapkg = data_reward_pkg:get(RewardNo),
							GoodsList = Datapkg#reward_pkg.goods_list,
							F = fun({_Q, GoodsNo, Count, _Z , _B,_S}, Acc) ->
										[{GoodsNo,Count}|Acc]
								end,	
							GoodsList2 = lists:foldl(F, [], GoodsList),
							case PersonData#guild_person.get_award of
								1 ->
									lib_send:send_prompt_msg(PS, ?PM_HAVE_GET_THE_REWARD);
								_ ->
									case mod_inv:check_batch_add_goods(player:id(PS), GoodsList2) of
										{fail, _Reason} ->
											lib_send:send_prompt_msg(player:get_id(PS), ?PM_US_BAG_FULL);
										ok ->
											mod_inv:batch_smart_add_new_goods(player:get_id(PS), GoodsList2),
											PersonData2 = PersonData#guild_person{
																				  get_award = 1
																				 },
											lib_guild_dungeon:update_guild_person_data(PersonData, PersonData2),
											{ok,Bin} = pt_53:write(?PT_GET_REWARD, [1]),
											lib_send:send_to_sock(PS, Bin)
									end
							end;
						_ ->
							lib_send:send_prompt_msg(PS, ?PM_GUILD_DUNGEON_GET_REWARD)
					end;
				_ ->
					%判断是否领取过
					PersonData = mod_guild_dungeon:get_guild_person_from_ets(PlayerId),
					GetProgress000 = PersonData#guild_person.get_progress, %[{1,2,3,1,4,5}···]
					NewGetProgress00 = lists:keydelete(Point, 1, GetProgress000),
					GetProgress00 =
						case lists:keyfind(Point, 1, GetProgress000) of
							false -> %完全没领取过
								{};
							RewardValue ->
								RewardValue
						end,	
					GetProgress0 = tuple_to_list(GetProgress00),
					
					GetProgress = case length(GetProgress0) > 0 of
									  true -> lists:sublist(GetProgress0, 2, length(GetProgress0) - 1);
									  false -> []
								  end,
					case lists:member(Reward, GetProgress) of
						false ->
							DataGuild = data_guild_new_dungeon:get(Point),
							RewardNo0 = DataGuild#guild_new_dungeon.reward,
							[{_,RewardNo}] = lists:sublist(RewardNo0, Reward, 1),
%% 							Datapkg = data_reward_pkg:get(RewardNo),
%% 							GoodsList = Datapkg#reward_pkg.goods_list,
%% 							F = fun({_Q, GoodsNo, Count, _Z , _B, _S}, Acc) ->
%% 										[{GoodsNo,Count}|Acc]
%% 								end,	
%% 							GoodsList2 = lists:foldl(F, [], GoodsList),
							case lib_reward:check_bag_space(PS, RewardNo) of
								{fail, _Reason} ->
									lib_send:send_prompt_msg(player:get_id(PS), ?PM_US_BAG_FULL);
								ok ->
									 lib_reward:give_reward_to_player(PS, RewardNo, [?LOG_GUILD_DUNGEON, "prize"]),
									NewGetProgress0 = 
										case GetProgress0 of
											[] -> [Point ,Reward];
											_ -> GetProgress0  ++ [Reward]
										end,
									NewGetProgress2 = [list_to_tuple(NewGetProgress0)],  
									NewGetProgress = NewGetProgress00 ++  NewGetProgress2,
									PersonData2 = PersonData#guild_person{
																		  get_progress = NewGetProgress
																		 },
									lib_guild_dungeon:update_guild_person_data(PersonData, PersonData2),
									{ok,Bin} = pt_53:write(?PT_GET_REWARD, [1]),
									lib_send:send_to_sock(PS, Bin)
							end;
						true ->
							
							lib_send:send_prompt_msg(PS, ?PM_HAVE_GET_THE_REWARD)
					end
			end
		end;
					
					
					

%% desc: 容错
handle(_Cmd, _PS, _Data) ->
	?DEBUG_MSG("pp_hire no match", []),
	{error, "pp_hire no match"}.

