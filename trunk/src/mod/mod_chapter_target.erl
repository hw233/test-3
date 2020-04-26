-module (mod_chapter_target).

-include("common.hrl").
-include("record.hrl").
-include("achievement.hrl").
-include("ets_name.hrl").
-include("chapter_target.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("reward.hrl").
-include("task.hrl").

-export([
    login_load/1
    ,final_logout/1
    ,get_chapter_info/2
    ,get_chapter_reward/2
    ,get_all_chapter_info/1
	,get_chapter_achive_reward/1
	,take_chapter_achive_reward/1
	,query_day_welfare/2
	,buy_day_welfare/2
	,update_chapter_achievement/2
    ,get_up_lv_list/3
    ,get_experience_list/1
    ,pack/2
    ,get_lilian_chapter/3
    ,notify_lilian/2
    ,notify_lilian/3,
	get_redpoint_chapter/1,
	big_num_to_list/2
    ]).

login_load(RoleId) ->
    case db:select_row(chapter_target_info, "`chapter_reward`, `chapter_achievement`, `buy_and_recharge`, `finish_chapter` ", [{role_id, RoleId}]) of
        [] ->
            ChapterRwd = init_chapter_target(),
            db:insert(RoleId, chapter_target_info, [{role_id, RoleId}, {chapter_reward, util:term_to_bitstring(ChapterRwd)}, {chapter_achievement, util:term_to_bitstring([])}, 
													{buy_and_recharge, util:term_to_bitstring([])} ]),
            set_chapter_reward_info(RoleId, ChapterRwd,[],[], []);
        [BinChapterRwd, BinChapterAchievement, BinBuyAndRecharge, BinFinishChapter] ->
            ChapterRwd = util:bitstring_to_term(BinChapterRwd),
            NewChapterRwd = correct_chapter(ChapterRwd),
			ChapterAchievement = util:bitstring_to_term(BinChapterAchievement),
			BuyAndRecharge = util:bitstring_to_term(BinBuyAndRecharge),
			FinishChapter  = util:bitstring_to_term(BinFinishChapter),
            set_chapter_reward_info(RoleId, NewChapterRwd, ChapterAchievement, BuyAndRecharge,FinishChapter)
    end.


final_logout(RoleId) ->
    clean_chapter_reward_info(RoleId).

%% 取得所有章节信息
get_all_chapter_info(RoleId) when is_integer(RoleId) ->
    case get_chapter_reward_info(RoleId) of
        ChapterInfo when is_record(ChapterInfo, chapter_target) ->
            F = fun({ChapterNo, Flag}) ->
                    case Flag =:= ?CT_RWD_HAD_GET of
                        true -> {ChapterNo, ?CT_GET_RWD};
                        false -> 
                            case data_chapter_target:get_chapter_info(ChapterNo) of
                                ChapterData when is_record(ChapterData, chapter_data) ->
                                    case mod_achievement:get_achievement(RoleId) of
                                        Achi when is_list(Achi) ->
                                            case is_all_finish(ChapterData#chapter_data.target, Achi) of
                                                true -> FinishChapter = ChapterInfo#chapter_target.finish_chapter, 
														
														case lists:member(ChapterNo, FinishChapter) of
															true ->
																FinishChapter;
															false ->
																NewFinishChapter = [ChapterNo|FinishChapter],
																HaveFinishChapter = length(FinishChapter) + 1,
																case HaveFinishChapter of
																	3 ->
																		
																		NewChapter = ChapterInfo#chapter_target{chapter_achievement = [{1, 2}], finish_chapter = NewFinishChapter },
																		update_chapter_achievement(RoleId, NewChapter);
																	5 ->
																		HavaFinishChapter = ChapterInfo#chapter_target.chapter_achievement,
																		HavaFinishChapter2 = lists:keydelete(2, 1, HavaFinishChapter),
																		NewChapter = ChapterInfo#chapter_target{chapter_achievement = [{2,2}|HavaFinishChapter2], finish_chapter = NewFinishChapter },
																		update_chapter_achievement(RoleId, NewChapter);
																	7 ->
																		HavaFinishChapter = ChapterInfo#chapter_target.chapter_achievement,
																		HavaFinishChapter2 = lists:keydelete(3, 1, HavaFinishChapter),
																		NewChapter =  ChapterInfo#chapter_target{chapter_achievement = [{3,2}|HavaFinishChapter2], finish_chapter = NewFinishChapter },
																		update_chapter_achievement(RoleId, NewChapter);
																	_ ->
																		NewChapter = ChapterInfo#chapter_target{finish_chapter = NewFinishChapter },
															        	update_chapter_achievement(RoleId, NewChapter)
																end			
														end,
														
														
														{ChapterNo, ?CT_FINISH_BUT_NOT_RWD};
                                                false -> {ChapterNo, ?CT_UN_FINISH}
                                            end;
                                        _ -> {ChapterNo, ?CT_UN_FINISH}
                                    end;
                                _ -> {ChapterNo, ?CT_UN_FINISH}
                            end
                    end
                end,
            Data = [F(Elem) || Elem <- ChapterInfo#chapter_target.reward_info],
            % ?LDS_TRACE(59003, [Data]),
            {ok, BinData} = pt_59:write(59003, [Data]),
            lib_send:send_to_uid(RoleId, BinData);
        _ -> 
            ?ASSERT(false, [RoleId]),
            lib_send:send_prompt_msg(RoleId, ?PM_CHAPTER_TARGET_NO_FOUND_DATA)
    end;




get_all_chapter_info(Status) when is_record(Status, player_status) ->
    case player:id(Status) of
        RoleId when is_integer(RoleId) -> get_all_chapter_info(RoleId);
        _ -> skip
    end.


get_redpoint_chapter(RoleId) when is_integer(RoleId) ->
    case get_chapter_reward_info(RoleId) of
        ChapterInfo when is_record(ChapterInfo, chapter_target) ->
            F = fun({ChapterNo, Flag}) ->
                    case Flag =:= ?CT_RWD_HAD_GET of
						true -> skip;
						false -> 
							case data_chapter_target:get_chapter_info(ChapterNo) of
								ChapterData when is_record(ChapterData, chapter_data) ->
									case mod_achievement:get_achievement(RoleId) of
										Achi when is_list(Achi) ->
											case is_all_finish(ChapterData#chapter_data.target, Achi) of
												true -> ChapterF = fun(CNo) ->
																		   case lists:keyfind(CNo, 1, ChapterInfo#chapter_target.reward_info) of
																			   {_, 0} -> 
																				   {ok, BinData} = pt_59:write(59007, [1]),
																				   lib_send:send_to_sock(player:get_PS(RoleId), BinData);
																			   _ ->
																				   case  lists:keyfind(2, 2, ChapterInfo#chapter_target.chapter_achievement) of
																					   false ->
																						   skip;
																					   _ ->
																						   {ok, BinData} = pt_59:write(59007, [1]),
																						   lib_send:send_to_sock(player:get_PS(RoleId), BinData)
																				   
																				   end
																		   end
																   end,
														lists:foreach(ChapterF, ChapterInfo#chapter_target.finish_chapter);
												
												false -> skip
											end;
										_ -> skip
									end;
                                _ -> skip
                            end
                    end
                end,
            lists:foreach(F, ChapterInfo#chapter_target.reward_info);
        
        _ -> 
            skip
    end.


    


is_all_finish([], _) -> true;
is_all_finish([{No, MaxNum} | Left], Achi) ->
    case lists:keyfind(No, 1, Achi) of
        false -> false;
        {No, NowNum, _} -> 
            case NowNum >= MaxNum of
                true -> is_all_finish(Left, Achi);
                false -> false
            end
    end.


%% 取得指定章节信息
get_chapter_info(Status, ChapterNo) ->
    RoleId = player:id(Status),
    case get_chapter_reward_info(RoleId) of
        ChapterInfo when is_record(ChapterInfo, chapter_target) ->
            case lists:keyfind(ChapterNo, 1, ChapterInfo#chapter_target.reward_info) of
                false ->
                    ?ASSERT(false, [RoleId, ChapterNo]),
                    lib_send:send_prompt_msg(Status, ?PM_CHAPTER_TARGET_NO_FOUND_DATA);
                {ChapterNo, State} ->
                    case data_chapter_target:get_chapter_info(ChapterNo) of
                        ChapterData when is_record(ChapterData, chapter_data) ->
                            case mod_achievement:get_achievement(RoleId) of
                                Achi when is_list(Achi) ->
                                    F = fun({No, MaxNum}, Sum) ->
                                        case lists:keyfind(No, 1, Achi) of
                                            false -> ?ASSERT(false, [RoleId, ChapterNo, No]), Sum;
                                            {No, NowNum, _} -> [{No, ?BIN_PRED(NowNum > MaxNum, MaxNum, NowNum), MaxNum} | Sum]
                                        end
                                    end,
                                    DataList1 = lists:foldl(F, [], ChapterData#chapter_data.target),
                                    DataList = lists:reverse(DataList1),
                                    % ?LDS_TRACE(chapter_info, [DataList]),
                                    Flag = case is_all_finish(ChapterData#chapter_data.target, Achi) of
                                        true -> ?BIN_PRED(State =:= ?CT_RWD_NOT_GET, ?CT_FINISH_BUT_NOT_RWD, ?CT_GET_RWD); 
                                        false -> ?CT_UN_FINISH
                                    end,
									

                                    {ok, BinData} = pt_59:write(59001, [ChapterNo, Flag, DataList]),
                                    lib_send:send_to_sid(Status, BinData);
                                _ ->
                                    ?ASSERT(false, [RoleId, ChapterNo]),
                                    lib_send:send_prompt_msg(Status, ?PM_CHAPTER_TARGET_NO_FOUND_DATA)
                            end;
                        _ ->
                            ?ASSERT(false, [RoleId, ChapterNo]),
                            lib_send:send_prompt_msg(Status, ?PM_CHAPTER_TARGET_NO_FOUND_DATA)
                    end
            end;
        _ ->
            ?ASSERT(false, [RoleId, ChapterNo]),
            lib_send:send_prompt_msg(Status, ?PM_CHAPTER_TARGET_NO_FOUND_DATA)
    end.





%% 取得章节奖励
get_chapter_reward(Status, ChapterNo) ->
    RoleId = player:id(Status),
    case get_chapter_reward_info(RoleId) of
        ChapterInfo when is_record(ChapterInfo, chapter_target) ->
            case lists:keyfind(ChapterNo, 1, ChapterInfo#chapter_target.reward_info) of
                false ->
                    ?ASSERT(false, [RoleId, ChapterNo]),
                    lib_send:send_prompt_msg(Status, ?PM_CHAPTER_TARGET_NO_FOUND_DATA);
                {ChapterNo, ?CT_RWD_NOT_GET} ->
                    case data_chapter_target:get_chapter_info(ChapterNo) of
                        ChapterData when is_record(ChapterData, chapter_data) ->
                            case mod_achievement:get_achievement(RoleId) of
                                Achi when is_list(Achi) ->
                                    % ?LDS_TRACE(get_chapter_reward, [ChapterData#chapter_data.target, Achi]),
                                    case check_chapter_finish(ChapterData#chapter_data.target, Achi) of
                                        false ->
                                            lib_send:send_prompt_msg(Status, ?PM_CHAPTER_TARGET_NOT_COMPLETED),
                                            ?ASSERT(false, [RoleId, ChapterNo]);
                                        true ->
                                            Rid = ChapterData#chapter_data.reward_id,
                                            case lib_reward:check_bag_space(Status, Rid) of
                                                ok ->
                                                    update_chapter_reward(RoleId, ChapterInfo#chapter_target{reward_info = lists:keyreplace(ChapterNo, 1,
                                                        ChapterInfo#chapter_target.reward_info, {ChapterNo, ?CT_RWD_HAD_GET})}),
                                                    lib_reward:give_reward_to_player(Status, Rid, [?LOG_ACHIEVE, "prize"]),
                                                    {ok, BinData} = pt_59:write(59002, [ChapterNo, 0]),
                                                    lib_send:send_to_sid(Status, BinData);
                                                {fail, Reason} -> lib_send:send_prompt_msg(Status, Reason)
                                            end
                                    end;
                                _ ->
                                    ?ASSERT(false, [RoleId, ChapterNo]),
                                    lib_send:send_prompt_msg(Status, ?PM_CHAPTER_TARGET_NO_FOUND_DATA)
                            end;
                        _ ->
                            ?ASSERT(false, [RoleId, ChapterNo]),
                            lib_send:send_prompt_msg(Status, ?PM_CHAPTER_TARGET_NO_FOUND_DATA)
                    end;
                _ ->
                    ?ASSERT(false, [RoleId, ChapterNo]),
                    lib_send:send_prompt_msg(Status, ?PM_CHAPTER_TARGET_NO_FOUND_DATA)
            end;
        _ ->
            ?ASSERT(false, [RoleId, ChapterNo]),
            lib_send:send_prompt_msg(Status, ?PM_CHAPTER_TARGET_NO_FOUND_DATA)
    end.


%% @return: boolean()
check_chapter_finish([], _) -> true;
check_chapter_finish([{No, MaxNum} | Left], List) ->
    case lists:keyfind(No, 1, List) of
        false -> ?ASSERT(false), false;
        {No, CurNum, _} ->
            case CurNum >= MaxNum of
                true -> check_chapter_finish(Left, List);
                false -> false
            end
    end.


get_chapter_achive_reward(PlayerId) ->
	case get_chapter_reward_info(PlayerId) of
		null ->
			 {ok, BinData} = pt_59:write(59005, [1, 1]),
			  lib_send:send_to_sid(player:get_PS(PlayerId), BinData);
		RewardInfo ->
			ChapterAchievement= RewardInfo#chapter_target.chapter_achievement,
			%章节成就达成  [{no, flag}]   [{4,1},{3,3},{2,2},{1,2}]
			%   	chapter_no         u8    1->三个章节成就达成，2->五个，3->七个  ->4 表示全领取了
			%   	flag               u8    1->未完成 2->完成未领取
           SortChapterAchievement = lists:keysort(1, ChapterAchievement),
			
		   case length(SortChapterAchievement) > 0 of
			   true ->
				   case lists:keyfind(2, 2, SortChapterAchievement) of
					   {No,2} ->
						     {ok, BinData} = pt_59:write(59005, [No, 2]),
				             lib_send:send_to_sid(player:get_PS(PlayerId), BinData);
					   false ->
						   {LastChapterNo,Flag} = lists:last(SortChapterAchievement),
						   case LastChapterNo =:=3  andalso Flag =:= 3 of
							   true ->
								   {ok, BinData} = pt_59:write(59005, [4, 1]),
						           lib_send:send_to_sid(player:get_PS(PlayerId), BinData);
							   false ->
								     {ok, BinData} = pt_59:write(59005, [LastChapterNo, Flag]),
						           lib_send:send_to_sid(player:get_PS(PlayerId), BinData)
						   end
						   
				   end;
				   
			   false ->
				    {ok, BinData} = pt_59:write(59005, [1, 1]),
					lib_send:send_to_sid(player:get_PS(PlayerId), BinData)
		   end
	end.

take_chapter_achive_reward(PlayerId) ->
	case get_chapter_reward_info(PlayerId) of
		null ->
			{ok, BinData} =pt_59:write(59005, [1, 1]),
			lib_send:send_to_sid(player:get_PS(PlayerId), BinData);
		ChapterRewardInfo ->
			ChapterAchievement2 = lists:keysort(1,  ChapterRewardInfo#chapter_target.chapter_achievement),
			case lists:keyfind(2, 2, ChapterAchievement2) of
				{No,2} ->
					ChapterRewardList = data_day_reward:get_no_by_type(4),
					Fun = fun(X) ->
								  RewardInfo =  data_day_reward:get(X),
								  Condition  = RewardInfo#day_reward_cfg.condition,
								  case Condition =:= (No * 2 +1) of
									  true ->
										  case lib_reward:check_bag_space(player:get_PS(PlayerId), RewardInfo#day_reward_cfg.reward_no) of
											  {fail, Reason} ->  lib_send:send_prompt_msg(PlayerId, Reason);
											  ok ->
												  {ok, BinData} = pt_59:write(59005, [No +1, 1]),
												  lib_send:send_to_sid(player:get_PS(PlayerId), BinData),
												  ChangeChapterAchievement = lists:keydelete(1, 2, ChapterRewardInfo#chapter_target.chapter_achievement),
												  {value,{No,2},BeTakeInfo} =  lists:keytake(No, 1, ChangeChapterAchievement),
												  FnishAchievement = [{No,3}|BeTakeInfo],
												  FnishAchievement2 = [{No+1 , 1}|FnishAchievement],
												  lib_reward:give_reward_to_player(player:get_PS(PlayerId), RewardInfo#day_reward_cfg.reward_no, [?LOG_AD, "chapter"]),
												  update_chapter_achievement(PlayerId ,ChapterRewardInfo#chapter_target{chapter_achievement = FnishAchievement2} )
										  end;
									  
									  
									  false ->
										  skip
								  end
						  end,	
					lists:foreach(Fun, ChapterRewardList);
				_ ->
					lib_send:send_prompt_msg(PlayerId, ?PM_AD_REPEAT_GET)
			
			end
		
	
	end.


%% 	type                   u8    0查询，1购买，2充值
%   flag_buy               u32   0为不可购买，其实数值为今日还可购买的数量
%   flag_recharge          u8    大于0为可充值/0为不可充值
query_day_welfare(PlayerId, No) ->
	case get_chapter_reward_info(PlayerId) of
		null ->
%% 			ChapterTarget = data_chapter_target:get(1),
%% 			Count = ChapterTarget#chapter_no.buy_count,
			{ok, BinData} =pt_59:write(59006, [0, 0]),
			lib_send:send_to_sid(player:get_PS(PlayerId), BinData);
		RewardInfo ->
%% 			buy_and_recharge = [] % 章节每日福利 [{no,flag1,falg2,unixtime}]
	        RewardInfoList  = RewardInfo#chapter_target.buy_and_recharge,
			DataResult = case lists:keyfind(No, 1, RewardInfoList) of
							 false ->
								 {No, 1, 1, util:unixtime()};
							 R ->
								 R
						 end,
			{_, BuyFlag, RechargeFlag, UnixTime}= DataResult,
			IsTheSameDay = util:is_same_day(UnixTime),
			{BuyFlag2, RechargeFlag2} = 
				case IsTheSameDay of
					false ->
						ChapterNoInfo = data_chapter_target:get(No),
						{ChapterNoInfo#chapter_no.buy_count, 1};
					true ->
						{BuyFlag, RechargeFlag}
				end,
			{ok, BinData} =pt_59:write(59006, [BuyFlag2, RechargeFlag2]),
			lib_send:send_to_sid(player:get_PS(PlayerId), BinData)
	end.


buy_day_welfare(PlayerId, No) ->
	case get_chapter_reward_info(PlayerId) of
		null ->
			%% 			ChapterTarget = data_chapter_target:get(1),
			%% 			Count = ChapterTarget#chapter_no.buy_count,
			{ok, BinData} =pt_59:write(59006, [0, 2]),
			lib_send:send_to_sid(player:get_PS(PlayerId), BinData);
		RewardInfo ->
			ChapterNoInfo = data_chapter_target:get(No),
			BuyGoodsCount = ChapterNoInfo#chapter_no.buy_count,
			%% 			buy_and_recharge = [] % 章节每日福利 [{no,flag1,falg2,unixtime}]
			RewardInfoList  = RewardInfo#chapter_target.buy_and_recharge,
			DataResult = case lists:keyfind(No, 1, RewardInfoList) of
							 false ->
								 {No, BuyGoodsCount, 1, util:unixtime()};
							 R ->
								 R
						 end,
			{_, BuyFlag, RechargeFlag, UnixTime}= DataResult,
			IsTheSameDay = util:is_same_day(UnixTime),
			{BuyFlag2, RechargeFlag2} = 
				case IsTheSameDay of
					false ->
						{BuyGoodsCount, 1};
					true ->
						{BuyFlag, RechargeFlag}
				end,
			case BuyFlag2 > 0 of
				true ->
					
					BuyGoodsNo = ChapterNoInfo#chapter_no.buy_pkg,
					Price = ChapterNoInfo#chapter_no.discount_price,
					PriceType = ChapterNoInfo#chapter_no.price_type,
					case mod_inv:check_batch_add_goods(PlayerId, [{BuyGoodsNo, 1}]) of
						{fail, _Reason} ->
							lib_send:send_prompt_msg(PlayerId, ?PM_US_BAG_FULL);
						ok ->
							case player:has_enough_money(player:get_PS(PlayerId), PriceType, Price) of
								true ->
									BuyGoodsNo = ChapterNoInfo#chapter_no.buy_pkg,
									player:cost_money(player:get_PS(PlayerId), PriceType, Price, [?LOG_AD, "chapter"]),
									mod_inv:batch_smart_add_new_goods(PlayerId, [{BuyGoodsNo, 1}]),
									{ok, BinData} =pt_59:write(59006, [BuyFlag2 - 1, RechargeFlag2]),
									lib_send:send_to_sid(player:get_PS(PlayerId), BinData),
									NewRechargeStatus 
										= case lists:keyfind(No, 1, RewardInfoList) of
											  false ->
												  [{No,BuyGoodsCount -1 , 1,util:unixtime() }|RewardInfoList];
											  _ ->
												  lists:keyreplace(No, 1, RewardInfoList, {No,BuyFlag2 -1 , RechargeFlag2, util:unixtime() })
										  end,
							
									update_chapter_achievement(PlayerId, RewardInfo#chapter_target{buy_and_recharge = NewRechargeStatus });
								false -> lib_send:send_prompt_msg(PlayerId, ?PM_MONEY_LIMIT)	
							end
					end;
				false ->
					lib_send:send_prompt_msg(PlayerId, ?PM_LEFT_TIME_LIMIT)
			end
	end.



%% @doc 初始化章节数据
init_chapter_target() ->
    ChapterNos = data_chapter_target:get_nos(),
    [{No, ?CT_RWD_NOT_GET} || No <- ChapterNos].

%% @doc 矫正章节数据
correct_chapter(ChapterRwd) ->
    InitData = init_chapter_target(),
    correct_chapter_1(InitData, ChapterRwd).

correct_chapter_1(DataList, []) -> DataList;
correct_chapter_1(DataList, [{No, Flag} | Left]) ->
    correct_chapter_1(lists:keyreplace(No, 1, DataList, {No, Flag}), Left).

% save_chapter_reward_info(RoleId) ->
%     case get_chapter_reward_info(RoleId) of
%         null -> ?ASSERT(false, [RoleId]);
%         List -> db:update(RoleId, chapter_target_info, [{chapter_reward, util:term_to_bitstring(List)}], [{role_id, RoleId}])
%     end.


%% =========================================
%% data
%% =========================================

update_chapter_reward(RoleId, Rd) ->
    ets:insert(?ETS_CHAPTER_TARGET, Rd),
%% 	{util:term_to_bitstring(Rd#chapter_target.chapter_achievement)},  {util:term_to_bitstring(Rd#chapter_target.buy_and_recharge)}, {util:term_to_bitstring(Rd#chapter_target.finish_chapter)}
    db:update(RoleId, chapter_target_info, [{chapter_reward, util:term_to_bitstring(Rd#chapter_target.reward_info)}], [{role_id, RoleId}]).

update_chapter_achievement(RoleId, Rd) ->
    ets:insert(?ETS_CHAPTER_TARGET, Rd),
%% 	{util:term_to_bitstring(Rd#chapter_target.chapter_achievement)},  {util:term_to_bitstring(Rd#chapter_target.buy_and_recharge)}, {util:term_to_bitstring(Rd#chapter_target.finish_chapter)}
    db:update(RoleId, chapter_target_info, [{chapter_achievement ,util:term_to_bitstring(Rd#chapter_target.chapter_achievement) }, {finish_chapter , util:term_to_bitstring(Rd#chapter_target.finish_chapter)},{buy_and_recharge, util:term_to_bitstring(Rd#chapter_target.buy_and_recharge)}], [{role_id, RoleId}]).



set_chapter_reward_info(RoleId, ChapterRwd, ChapterAchievement,BuyAndRecharge, FinishChapter) ->
    ets:insert(?ETS_CHAPTER_TARGET, #chapter_target{id = RoleId, reward_info = ChapterRwd, chapter_achievement= ChapterAchievement , buy_and_recharge = BuyAndRecharge, finish_chapter= FinishChapter }).


%% @return null | list() ets:lookup(ets_chapter_target, 1010800000000114). 
get_chapter_reward_info(RoleId) ->
    case ets:lookup(?ETS_CHAPTER_TARGET, RoleId) of
        [Rd] when is_record(Rd, chapter_target) -> Rd;
        _ -> null
    end.

clean_chapter_reward_info(RoleId) ->
    ets:delete(?ETS_CHAPTER_TARGET, RoleId).


%% =========================================
%% 历练系统
%% =========================================
%%calculate([H | T], Length, Count) ->
%%    case T =:= [] of
%%        true ->
%%            erlang:trunc((Count + H * math:pow(2, Length-1)));
%%        false ->
%%            Count0 = Count + H * math:pow(2, Length-1),
%%            calculate(T, Length - 1, Count0)
%%    end.

pack([H | T], Count) ->
    case T =:= [] of
        true ->
            erlang:trunc((Count + math:pow(2, H-1)));
        false ->
            Count0 = Count + math:pow(2, H-1),
            pack(T, Count0)
    end.

get_up_lv_list([H | T], Lv, Acc) ->
    case T of
        [] ->
            case Lv >= H of
                true ->
                    Lilian = data_lilian_task_no:get(H),
                    ?ASSERT(Lilian#lilian_task_no.type =:= 2),
                    lists:sort(Lilian#lilian_task_no.num ++ Acc);
                false ->
                    lists:sort(Acc)
            end;
        _ ->
            case Lv >= H of
                true ->
                    Lilian = data_lilian_task_no:get(H),
                    ?ASSERT(Lilian#lilian_task_no.type =:= 2),
                    get_up_lv_list(T, Lv, Lilian#lilian_task_no.num ++ Acc);
                false ->
                    get_up_lv_list(T, Lv, Acc)
            end
    end.

get_experience_list(lv) ->
    List = data_lilian_task_no:get_no(),
    Predicate = fun(X) -> (data_lilian_task_no:get(X))#lilian_task_no.type =:= 2 end,
    LvList = lists:filter(Predicate, List),
    lists:sort(LvList);

get_experience_list(task) ->
    List = data_lilian_task_no:get_no(),
    Predicate = fun(X) -> (data_lilian_task_no:get(X))#lilian_task_no.type =:= 1 end,
    LvList = lists:filter(Predicate, List),
    lists:sort(LvList).


%%get_lilian_chapter(Status) ->
%%    Accepted = lib_task:get_accepted_list(),
%%    ?DEBUG_MSG("---------- get_lilian_chapter Accepted----------~p~n", [Accepted]),
%%
%%    NoSortList =
%%        case Accepted of
%%            [] ->
%%                [];
%%            _ ->
%%%%                Predicate = fun(X) -> lib_task:get_task_type(X) =:= 0 end,
%%%%                [MainAccepted] = lists:filter(Predicate, Accepted),
%%                F = fun(X, Acc) ->
%%                        case lib_task:get_task_type(X) =:= 0 of
%%                            true ->
%%                                [X | Acc];
%%                            false ->
%%                                Acc
%%                        end
%%                    end,
%%                [MainAccepted] = lists:foldl(F, [], Accepted),
%%
%%                ?DEBUG_MSG("get_lilian_chapter MainAccepted~p~n", [MainAccepted]),
%%                get_lilian_task_chapter(MainAccepted, 0)
%%        end,
%%
%%    LvList = mod_chapter_target:get_experience_list(lv),
%%    ?DEBUG_MSG("get_lilian_chapter LvList~p~n", [LvList]),
%%    UpLvList = mod_chapter_target:get_up_lv_list(LvList, player:get_lv(Status), []),
%%    ?DEBUG_MSG("get_lilian_chapter UpLvList~p~n", [UpLvList]),
%%
%%
%%    List = lists:sort(NoSortList ++ UpLvList),
%%    PackCount =
%%        case List of
%%            [] ->
%%                0;
%%            _ ->
%%                mod_chapter_target:pack(List, 0)
%%        end,
%%
%%    Lilian = (ply_misc:get_player_misc(player:get_id(Status)))#player_misc.lilian,
%%    {PackCount, Lilian}.

get_lilian_chapter(TaskId, Type, Status) ->

    NoSortList =
        case Type of
            1 ->
                get_lilian_task_chapter(TaskId, 1, Status);
            0 ->
                get_lilian_task_chapter(TaskId, 0, Status)
        end,
%%    NoSortList = get_lilian_task_chapter(TaskId, Type),
    ?DEBUG_MSG("get_lilian_chapter NoSortList~p~n", [NoSortList]),

    LvList = mod_chapter_target:get_experience_list(lv),
    ?DEBUG_MSG("get_lilian_chapter LvList~p~n", [LvList]),
    UpLvList = mod_chapter_target:get_up_lv_list(LvList, player:get_lv(Status), []),
    ?DEBUG_MSG("get_lilian_chapter UpLvList~p~n", [UpLvList]),


%%    mod_chapter_target:get_up_lv_list(mod_chapter_target:get_experience_list(lv), 27, []).

    List = lists:sort(NoSortList ++ UpLvList),
    ?DEBUG_MSG("get_lilian_chapter NoSortList ++ UpLvList~p~n", [List]),
    PackCount =
        case List of
            [] ->
                0;
            _ ->
                mod_chapter_target:pack(List, 0)
        end,
    ?DEBUG_MSG("get_lilian_chapter NoSortList {PackCount}~p~n", [PackCount]),
    ?DEBUG_MSG("get_lilian_chapter get_player_misc~p~n", [ply_misc:get_player_misc(player:get_id(Status))]),

    Lilian = (ply_misc:get_player_misc(player:get_id(Status)))#player_misc.lilian,
    ?DEBUG_MSG("get_lilian_chapter NoSortList {PackCount, Lilian}~p~n", [{PackCount, Lilian}]),
    {PackCount, Lilian}.

%% Flag=0 : 已接未完成   Flag=1：已接已完成
get_lilian_task_chapter(TaskId, Flag, Status)->
    DoneMainList =
        case Flag of
            0 ->
                lib_task:get_done_main_task(TaskId, [], Status);
            1 ->
                [TaskId | lib_task:get_done_main_task(TaskId, [], Status)]
        end,
    ?DEBUG_MSG("get_lilian_task_chapter DoneMainList:~p~n", [DoneMainList]),
%%    [1000230,
%%    1000010,
%%    1000040,
%%    1000050,
%%    1000060,
%%    1000070,
%%    1000100,
%%    1000110,
%%    1000120,
%%    1000160,
%%    1000170]
    TaskNoList = mod_chapter_target:get_experience_list(task),      % [1000230,1000370,1000400,1000764,1001040,1010058,1010061]
    F = fun(MainId, Acc) ->
            case lists:member(MainId, TaskNoList) of
                true ->
                    LilianTask = data_lilian_task_no:get(MainId),
                    case LilianTask#lilian_task_no.type =:= 1 of
                        true ->
                            LilianTask#lilian_task_no.num ++ Acc;
                        false ->
                            Acc
                    end;
                false ->
                    Acc
            end
        end,
    NoList = lists:foldl(F, [], DoneMainList),
    lists:sort(NoList).

notify_lilian(PS, Task) when is_record(Task, task)->
    case Task#task.type =:= 0 andalso lists:member(Task#task.id, mod_chapter_target:get_experience_list(task)) of
        false ->
            skip;
        true ->
            NoSortList = get_lilian_task_chapter(Task#task.id, 1, PS),

            LvList = mod_chapter_target:get_experience_list(lv),
            ?DEBUG_MSG("notify_lilian LvList:~p~n", [LvList]),
            UpLvList = mod_chapter_target:get_up_lv_list(LvList, player:get_lv(PS), []),
            ?DEBUG_MSG("notify_lilian UpLvList:~p~n", [UpLvList]),
            List = lists:sort(NoSortList ++ UpLvList),
            PackCount =
                case List of
                    [] ->
                        0;
                    _ ->
                        mod_chapter_target:pack(List, 0)
                end,
            Lilian = (ply_misc:get_player_misc(player:get_id(PS)))#player_misc.lilian,
            ?DEBUG_MSG("notify_lilian PackCount:~p~n", [PackCount]),
            ?DEBUG_MSG("notify_lilian Lilian:~p~n", [Lilian]),
            {ok, BinData} = pt_59:write(59200, [PackCount, Lilian]),
            lib_send:send_to_sock(PS, BinData)
    end.


notify_lilian(PS, CompleteTaskId, lv) ->
    ?DEBUG_MSG("--------- notify_lilian -----------~p~n", [player:get_lv(PS)]),
    ?DEBUG_MSG("--------- get_experience_list(lv) -----------~p~n", [get_experience_list(lv)]),


    case lists:member(player:get_lv(PS), get_experience_list(lv)) of
        false ->
            skip;
        true ->
            {PackCount, Lilian} = get_lilian_chapter(CompleteTaskId, 1, PS),
            ?DEBUG_MSG("{PackCount, Lilian}~p~n", [{PackCount, Lilian}]),
            {ok, BinData} = pt_59:write(59200, [PackCount, Lilian]),
            lib_send:send_to_sock(PS, BinData)
    end.

%wjc修复
big_num_to_list(Num,InitList) when Num > 0 ->
	BinaryValue =  Num rem 2 ,
	List =[BinaryValue|InitList],
	NewNum =  Num div 2,
	big_num_to_list(NewNum,List);

big_num_to_list(_Num,InitList) ->
	InitList.

	
	





%% mod_chapter_target:get_up_lv_list(mod_chapter_target:get_experience_lv_list(lv), 84, []).


