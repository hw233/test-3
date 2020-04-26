%%%--------------------------------------------------------
%%% @author Lzz <liuzhongzheng2012@gmail.com>
%%% @doc 按排行榜发奖
%%%
%%% @end
%%%--------------------------------------------------------

-module(mod_rank_gift).

-export([
        parse_web_gift/1,
        gift_for_rank/2,
        daily_title/0,
        daily_title/1,
		limit_gift_for_rank/1
    ]).

-include("common.hrl").
-include("rank.hrl").
-include("log.hrl").
-include("title.hrl").
-include("reward.hrl").


find(Key, {obj, List}) ->
    {_, Val} = lists:keyfind(Key, 1, List),
    Val.

parse_web_gift(Json) ->
    try
        {ok, Obj1, _} = rfc4627:decode(Json),
        Cont = find("content", Obj1),
        Title = find("title", Obj1),
        RankID = binary_to_integer(find("type", Obj1)),
        Json2 = find("attach", Obj1),
        {ok, [Objs2], _} = rfc4627:decode(Json2),
        F = fun(Key, Obj) -> util:bitstring_to_term(find(Key, Obj)) end,
        Gifts = [{F("rank", Ob), F("attach", Ob)} || Ob <- Objs2],
        {?true, {RankID, Title, Cont, Gifts}}
    catch
        _:_ -> ?false
    end.

limit_gift_for_rank({Title, Cont, Gifts}) ->
	LimitRankData = lib_newyear_banquet:get_time_limit_rank(),
	%[{1,token},{2,token}···]
    Fb = fun({{_Min, _Max}, Goods,TokenCount},AccFb) ->
				 [{TokenCount,Goods} | AccFb]
		 end,	 
	
%% 	{{1,10},[{30001,3,99}],5000},
%%                       {{11,20},[{30001,3,88}],4500},
%%                       {{21,30},[{30001,3,77}],4000},
%%                       {{31,45},[{30001,3,50}],2000},
%%                       {{46,50},[{30001,3,10}],1000}]},
    TokeList0 = lists:foldl(Fb, [], Gifts),
	TokeList = lists:reverse(TokeList0),
	F = fun({PlayerId, _Name, Rank, Token} ) ->
				F2 = fun({{Min, Max}, Goods,TokenCount}) ->
							 case Rank >= Min andalso Rank =< Max  of
								 true -> case Token >= TokenCount of
											 true -> Cont1 = binary:replace(Cont, <<"%d">>, integer_to_binary(Rank)),
													 lib_mail:send_sys_mail(PlayerId, Title, Cont1, Goods, [?LOG_MAIL, "recv_board"]);
											 false -> 
												 F3 = fun({TokenCount,Goods},Acc3) ->
															  case Token >= TokenCount andalso Acc3 =:=0 of
																  true -> 
																	  Cont1 = binary:replace(Cont, <<"%d">>, integer_to_binary(Rank)),
																	  lib_mail:send_sys_mail(PlayerId, Title, Cont1, Goods, [?LOG_MAIL, "recv_board"]),
																	  Acc3 + 1;
																  false ->
																	  Acc3
															  end
													  end,
												 lists:foldl(F3, 0, TokeList)
										 end;
								 false ->
									 skip
							 end
					 end,
				lists:foreach(F2, Gifts)
		end,
	
	
	lists:foreach(F, LimitRankData).


gift_for_rank({RankID, Title, Cont, Gifts}, OrderId) ->
    case RankID =:= 1066 of
        true ->
            gen_server:cast(mod_rank, {get_RMB_rank_name, 1066});
        false ->
            skip
    end,
    Func = fun(RList) -> proc_lib:spawn(fun() -> gift_for_rank(RList, {Title, Cont, Gifts}, {OrderId,RankID}) end) end,
    mod_rank:exe(RankID, Func);
gift_for_rank(_E,_O) ->
    ?ERROR_MSG("Invalid rank gift: ~p", [_E]).
 
  
find_goods(Rank, [{{Min, Max}, Goods}|_]) when Rank >= Min andalso Rank =< Max ->
    Goods;
find_goods(Rank, [_|T]) ->
    find_goods(Rank, T);
find_goods(_Rank, []) ->
    none.

gift_for_rank([#ranker{rank=Rank, player_id=UID}|T], {Title, Cont, Gifts}=Data, {OrderId, RankID}) ->
    case find_goods(Rank, Gifts) of
        none ->
            skip;
        Goods ->
            case RankID =:= 1066 of
                true ->
                    DataJson = db:select_one(admin_sys_activity, "origin_content", [{order_id, OrderId}]),
                    {ok, DataJsonResult, _}= rfc4627:decode(DataJson),
                    AttachJson = find("attach", DataJsonResult),
                    {ok, [AttachJson2Result], _} = rfc4627:decode(AttachJson), %[[josn]] util:bitstring_to_term(<<"[[1]]">>).
                    F = fun (X, Acc) ->
                        Integral = util:bitstring_to_term( find("integral", X) ),
                        RankTuple = util:bitstring_to_term( find("rank", X) ),
                        [{RankTuple,Integral}|Acc]
                        end,
                    OriginContent = lists:foldl(F, [], AttachJson2Result),
                    Condition = find_suit_rmb(Rank, OriginContent,UID) ,
                    case Condition of
                        skip ->
                            skip;
                        NewRank ->
                            case find_goods(NewRank, Gifts) of
                                none ->
                                    skip;
                                NewGoods ->
                                    NewCont1 = binary:replace(Cont, <<"%d">>, integer_to_binary(NewRank)),
                                    lib_mail:send_sys_mail(UID, Title, NewCont1, NewGoods, [?LOG_MAIL, "recv_board"])
                            end

                    end;
                %[{{3,8},2222},{{1,2},1314}]
                false ->
                    Cont1 = binary:replace(Cont, <<"%d">>, integer_to_binary(Rank)),
                    lib_mail:send_sys_mail(UID, Title, Cont1, Goods, [?LOG_MAIL, "recv_board"])
            end
    end,
       gift_for_rank(T, Data,{OrderId, RankID});
gift_for_rank([], _, _) ->
    ok.

find_suit_rmb(Rank, OriginContent,UID)  ->
    case find_goods(Rank, OriginContent) of
        none ->
            skip;
        Counter ->
            {ok, Value} = lib_player_ext:try_load_data(UID,tuhaobang),
            case Value >= Counter of
                true ->
                    Rank;
                false ->
                    find_suit_rmb(Rank+1,  OriginContent,UID )
            end
    end.

%% 每天的排行榜发称号
daily_title() ->
    % 4002 排行称号（比武大会称号武神）改为活动结束时刻发，故不需每天检查发称号
    IDs = data_rank_title:get_ids() -- [4002, 6001,9001,9002,9003],
    lists:foreach(fun daily_title/1, IDs).

daily_title(RankID) ->
    #rank_title{rewards = Titles} = data_rank_title:get(RankID),
    Func = fun(RList) -> daily_title(RankID, RList, Titles) end,
    mod_rank:exe(RankID, Func).

daily_title(_RankID, _, []=_Titles) ->
    ok;
daily_title(RankID, [#ranker{rank=Rank, player_id=UID}|T], Titles) ->
	%% 获取区间排名奖励
	case get_data_by_rank(Rank, Titles) of
		RewardNo when is_integer(RewardNo) ->
			%% 发邮件
			RoleId = UID,
			RewardRd = lib_reward:calc_reward_to_player(RoleId, RewardNo),
			case RewardRd#reward_dtl.calc_goods_list =/= [] of
				true ->
					#rank_title{title = Title, content = Content} = data_rank_title:get(RankID),
					Title2 = 
						case is_binary(Title) of
							?true ->
								unicode:characters_to_binary(Title, utf8);
							?false ->
								unicode:characters_to_list(Title, utf8)
						end,
					Content2 = 
						case is_binary(Content) of
							?true ->
								unicode:characters_to_binary(Content, utf8);
							?false ->
								unicode:characters_to_list(Content, utf8)
						end,
					Content3 = io_lib:format(Content2, [Rank]),
					lib_mail:send_sys_mail(RoleId, tool:to_binary(Title2), util:to_binary(Content3), RewardRd#reward_dtl.calc_goods_list, [?LOG_TOWER_GHOST, "tower_ghost"]);
				false ->
					skip
			end;
		_ ->
			skip
	end,
%%     case lists:keyfind(Rank, 1, Titles) of
%%         {Rank, Title} ->
%%             give_title(UID, Title);
%%         _ ->
%%             skip
%%     end,
    daily_title(RankID, T, Titles); 
daily_title(RankID, [], _) ->
    ok.


%% 根据排名获取区间的奖励, 排序后按大于等于来处理，如果都不符合取最后一个
get_data_by_rank(Rank, Titles) ->
	Titles2 = lists:keysort(1, Titles),
	get_data_by_rank(Rank, Titles2, null).


get_data_by_rank(Rank, [{Rank2, RewardNo}|Titles], _Last) ->
	case Rank =< Rank2 of
		?true ->
			RewardNo;
		?false ->
			get_data_by_rank(Rank, Titles, RewardNo)
	end;

get_data_by_rank(_Rank, [], Acc) ->
	Acc.




%% 策划改了需求，这里的Title不再是称号，而是道具编号
give_title(UID, Title) ->
    WeekDay = calendar:day_of_the_week(date()),
    case data_title:get(Title) of
        #data_title{valid_minute=2880} when WeekDay =:= 1 ->
            lib_offcast:cast(UID, {add_title, Title, util:unixtime()});
        #data_title{valid_minute=2880} -> % 有效期一周的只在周一凌晨发
            skip;
        _ ->
            lib_offcast:cast(UID, {add_title, Title, util:unixtime()})
    end.






