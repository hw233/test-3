%% @author Administrator
%% @doc @todo Add description to lib_guess.


-module(lib_guess).

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).
-compile(export_all).

-include("record.hrl").
-include("activity.hrl").
-include("prompt_msg_code.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("ets_name.hrl").
-include("log.hrl").
-include("pt_37.hrl").
-include("pt_17.hrl").
-include_lib("stdlib/include/ms_transform.hrl").
-include("goods.hrl").
-include("abbreviate.hrl").
-include("partner.hrl").
-include("record/goods_record.hrl").
-include("pt_comm.hrl").

on_player_login(PS) ->
	ok.


%% 竞猜请求题目动态数据
guess_bet(PS, Id, 0, _, _) ->
	case ets:lookup(?ETS_GUESS_QUESTION, Id) of
		[#guess_question{total_rmb = TotalRmb1, total_cup = TotalCup1}] ->
			{Option, BetCup, BetRmb} = get_my_bet(PS, Id),
			TotalCup = TotalCup1 + data_special_config:get('guess_min_goods_reward'),
			TotalRmb = TotalRmb1 + data_special_config:get('guess_min_money_reward'),
			{ok, Bin} = pt_31:write(31202, [Id, Option, BetRmb, BetCup, TotalRmb, TotalCup]),
			lib_send:send_to_sock(PS, Bin);
		[] ->
			lib_send:send_prompt_msg(PS, ?PM_CLI_MSG_ILLEGAL)
	end;

%% 选择答案
guess_bet(PS, Id, Option, Rmb, Cup) ->
	case ets:lookup(?ETS_GUESS_QUESTION, Id) of
		[#guess_question{total_rmb = TotalRmb, total_cup = TotalCup} = Guess] ->
			case check_guess_bet(Guess) of  %% 检查是否可以竞猜
				ok ->
					case get_my_bet(PS, Id) of
						{0, 0, 0} ->
							%% 可以投注，扣钱扣奖杯
							case guess_bet_cost(PS, Rmb, Cup) of
								ok ->
									set_my_bet(PS, Id, Option, Rmb, Cup),
									mod_guess:add_total(Id, Rmb, Cup),
									TotalCup1 = TotalCup + Cup+ data_special_config:get('guess_min_goods_reward'),
									TotalRmb1 = TotalRmb + Rmb+ data_special_config:get('guess_min_money_reward'),
									{ok, Bin} = pt_31:write(31202, [Id, Option, Rmb, Cup,TotalRmb1 , TotalCup1]),
									lib_send:send_to_sock(PS, Bin);
								{fail, MsgCode} ->
									%% 
									lib_send:send_prompt_msg(PS, MsgCode)
							end;
						{_, _, _} ->
							lib_send:send_prompt_msg(PS, ?PM_CLI_MSG_ILLEGAL)
					end;
				{fail, MsgCode} ->
					%% 
					lib_send:send_prompt_msg(PS, MsgCode)
			end;
		[] ->
			lib_send:send_prompt_msg(PS, ?PM_CLI_MSG_ILLEGAL)
	end.

%% 检查是否可以竞猜此题
check_guess_bet(#guess_question{is_reward = IsReward, time_bet_begin = TimeBetBegin, time_bet_end = TimeBetEnd}) ->
	case IsReward of
		0 ->
			TimeNow = util:unixtime(),
			case TimeNow >= TimeBetBegin andalso TimeNow =< TimeBetEnd of
				true ->
					ok;
				false ->
					%% 当前时间不可竞猜
					{fail, ?PM_GUESS_OUT_TIME}
			end;
		_ ->
			%% 题目已经过期了
			{fail, ?PM_GUESS_OUT_TIP}
	end.
	


%% 竞猜扣除手续费和投注费用
guess_bet_cost(PS, BetRmb, BetCup) ->
	LogInfo = [?LOG_GUESS, "guess_cost"],
	case player:check_need_price(PS, ?MNY_T_YUANBAO, BetRmb) of
		ok ->
			CupNo = data_special_config:get('jiangbei'),
			GoodsList = [{CupNo, BetCup}],
			case mod_inv:check_batch_destroy_goods(PS, GoodsList) of
				ok ->
					player:cost_yuanbao(PS, BetRmb, LogInfo),
					mod_inv:destroy_goods_WNC(PS, GoodsList, LogInfo),
					ok;
				{fail, MsgCode} ->
					{fail, MsgCode}
			end;
		MsgCode ->
			{fail, MsgCode}
	end.


get_all_valid() ->
	List = ets:tab2list(?ETS_GUESS_QUESTION),
	get_all_valid(List).

get_all_novalid() ->
	List = ets:tab2list(?ETS_GUESS_QUESTION),
	get_all_novalid(List).


get_all_valid(List) ->
	lists:filter(fun(#guess_question{is_reward = 0, correct = Correct}) when Correct > 0 ->
						 true;
					(_) ->
						 false
				 end, List).

get_all_novalid(List) ->
	TimeNow = util:unixtime(),
	lists:filter(fun(#guess_question{is_reward = 0, correct = Correct, time_show_end = TimeShowEnd}) when Correct =:= 0 ->
						  TimeNow>=TimeShowEnd ;
					(_) ->
						 false
				 end, List).



%% 定时检测所有未结算但有答案的题目
guess_settle() ->
	List = get_all_valid(),
	ListNoAnswer = get_all_novalid(),
	lists:foreach(fun guess_settle/1, List),
	lists:foreach(fun guess_nosettle/1, ListNoAnswer).


%% 过期没有答案时，结算某道题目
guess_nosettle(GuessId) when erlang:is_integer(GuessId) ->
	case ets:lookup(?ETS_GUESS_QUESTION, GuessId) of
		[Guess] ->
			guess_nosettle(Guess);
		[] ->
			?ERROR_MSG("GuessId Error : ~p~n", [GuessId])
	end;



guess_nosettle(#guess_question{id = Id, title = T, is_reward = IsReward}) ->
	case IsReward of 
		0 ->case db:select_all(guess_bet, "role_id, bet_rmb, bet_cup", [{guess_id, Id}]) of
                 [] -> skip;
                 List ->
						Title = unicode:characters_to_list(data_special_config:get(guess_mail_paybacktitle),utf8),
						Content0 =unicode:characters_to_list(data_special_config:get(guess_mail_paybackcontent),utf8),
						Jiangbei = data_special_config:get('jiangbei'),
						LogInfo = [?LOG_GUESS, "reward"],
						lists:foreach(fun([RoleId, Rmb, Cup]) ->
											  Content = io_lib:format(Content0, [T,Cup,  Rmb]),
											  GoodsList = [{89002, Rmb}, {Jiangbei, Cup}],
											  lib_mail:send_sys_mail(RoleId, util:to_binary(Title), util:to_binary(Content), GoodsList, LogInfo)
									  end, List)
			

            end,
	    ets:update_element(?ETS_GUESS_QUESTION, Id, [{#guess_question.is_reward, 1}]),
		db:update(guess, [{is_reward, 1}], [{id, Id}]);               
        _ ->	%% 已经结算过了
			?ERROR_MSG("guess_settle already : ~p~n", [Id])
	end.
							  
			


%% 结算某道题目
guess_settle(GuessId) when erlang:is_integer(GuessId) ->
	case ets:lookup(?ETS_GUESS_QUESTION, GuessId) of
		[Guess] ->
			guess_settle(Guess);
		[] ->
			?ERROR_MSG("GuessId Error : ~p~n", [GuessId])
	end;

guess_settle(#guess_question{id = Id, title = T, is_reward = IsReward, correct = Correct, commission = Commission}) ->
	case IsReward of 
		0 ->
			case db:select_row(guess_bet, "sum(bet_cup), sum(bet_rmb)", [{guess_id, Id}]) of
				[TotalCup0, TotalRmb0] ->
				    GuessMinGoodsReward = data_special_config:get('guess_min_goods_reward'),
					GuessMinGoldReward = data_special_config:get('guess_min_money_reward'),
					TotalCup = case is_integer(TotalCup0) of
								   true ->
									   TotalCup0;
								   false ->
									   0
							   end,
					TotalRmb = case is_integer(TotalRmb0) of
								   true ->
									   TotalRmb0;
								   false ->
									   0
							   end,
					Ratio = (100 - Commission) / 100,
					TotalCup2 = util:floor((TotalCup + GuessMinGoodsReward) * Ratio),
					TotalRmb2 = util:floor((TotalRmb + GuessMinGoldReward) * Ratio),
					case db:select_row(guess_bet, "sum(bet_cup), sum(bet_rmb)", [{guess_id, Id}, {options, Correct}]) of
						[OTotalCup0, OTotalRmb0] ->
							OTotalCup = case is_integer(OTotalCup0) of
											true ->
												OTotalCup0;
											false ->
												0
										end,
							OTotalRmb = case is_integer(OTotalRmb0) of
											true ->
												OTotalRmb0;
											false ->
												0
										end,
							
							case db:select_all(guess_bet, "role_id, bet_rmb, bet_cup", [{guess_id, Id}, {options, Correct}]) of
								[] ->
									%% 没人猜中
									skip;
								List ->
									Title =unicode:characters_to_list(data_special_config:get(guess_mail_title),utf8),
									Content0 = unicode:characters_to_list(data_special_config:get(guess_mail_content),utf8),
									Jiangbei = data_special_config:get('jiangbei'),
									LogInfo = [?LOG_GUESS, "reward"],
									lists:foreach(fun([RoleId, 0, Cup]) ->
														  RoleRewardCup = util:floor((Cup / OTotalCup) * TotalCup2),
														  Content = io_lib:format(Content0, [T, RoleRewardCup, 0]),
														  GoodsList = [{Jiangbei, RoleRewardCup}],
														  lib_mail:send_sys_mail(RoleId, util:to_binary(Title), util:to_binary(Content), GoodsList, LogInfo);
													 ([RoleId, Rmb, 0]) ->
														  RoleRewardRmb = util:floor((Rmb / OTotalRmb) * TotalRmb2),
														  Content = io_lib:format(Content0, [T, 0, RoleRewardRmb]),
														  GoodsList = [{89002, RoleRewardRmb}],
														 lib_mail:send_sys_mail(RoleId,  util:to_binary(Title), util:to_binary(Content), GoodsList, LogInfo);
													
													 ([RoleId, Rmb, Cup]) ->
														  RoleRewardRmb = util:floor((Rmb / OTotalRmb) * TotalRmb2),
														  RoleRewardCup = util:floor((Cup / OTotalCup) * TotalCup2),
														  Content = io_lib:format(Content0, [T, RoleRewardCup, RoleRewardRmb]),
														  GoodsList = [{89002, RoleRewardRmb}, {Jiangbei, RoleRewardCup}],
														  lib_mail:send_sys_mail(RoleId,  util:to_binary(Title), util:to_binary(Content), GoodsList, LogInfo)
												  end, List)
							
							end;
						[] ->
							%% 没有投注记录，不用结算了，直接忽略了
							skip
					end;
				[] ->
					%% 没有投注记录，不用结算了，直接忽略了
					skip
			end,
			ets:update_element(?ETS_GUESS_QUESTION, Id, [{#guess_question.is_reward, 1}]),
			db:update(guess, [{is_reward, 1}], [{id, Id}]);
		_ ->
			%% 已经结算过了
			?ERROR_MSG("guess_settle already : ~p~n", [Id])
	end.


%% ====================================================================
%% Internal functions
%% ====================================================================
%% 初始化竞猜数据，去中心接口取数据
init_guess_data() ->
	load_guess_data(),
	sync_center_data().



%% 同步中心接口竞猜活动数据
sync_center_data() ->
	try
		do_sync_center_data()
	catch
		E:R ->
			?ERROR_MSG("E,R: ~p~n", [{erlang:get_stacktrace(),E,R}])
	end.

do_sync_center_data() ->
	Ip = config:get_adm_addr(),
    Url = lists:concat(["http://", Ip, ":8080/XQCenter/GuessData/GetList"]),
	case util:request_get(Url, []) of
		 {ok, {{_NewVersion, 200, _NewReasonPhrase}, _NewHeaders, NewBody}} ->
			case rfc4627:decode(NewBody) of
				{ok, List, []} ->
					L = sync_center_data(List, []),
					NowTime = util:unixtime(),
					ValidL = ets:tab2list(?ETS_GUESS_QUESTION),
					ListDel =						
						lists:foldl(fun(GuessQuestion, Acc) ->
											sync_guess_question(GuessQuestion),
											lists:keydelete(GuessQuestion#guess_question.id, #guess_question.id, Acc)
									end, ValidL, L),
					
					lists:foreach(fun(#guess_question{id = Id,time_show_end = TimeShowEnd, is_reward = IsReward,title = T}) ->
										  %% 这里如果还没结算但已有竞猜记录的还需要返还
										  case IsReward of 
											  0 ->case db:select_all(guess_bet, "role_id, bet_rmb, bet_cup", [{guess_id, Id}]) of
													  [] ->?DEBUG_MSG("TestDelete1:~p~n",[IsReward]), skip;
													  DeleteList ->
														  ?DEBUG_MSG("TestDelete2:~p----~p~n",[IsReward,T]),
														  Title = unicode:characters_to_list(data_special_config:get(guess_mail_paybacktitle),utf8),
														  Content0 =unicode:characters_to_list(data_special_config:get(guess_mail_paybackcontent),utf8),
														  Jiangbei = data_special_config:get('jiangbei'),
														  LogInfo = [?LOG_GUESS, "reward"],
														  lists:foreach(fun([RoleId, Rmb, Cup]) ->
																				Content = io_lib:format(Content0, [T,Cup,  Rmb]),
																				GoodsList = [{89002, Rmb}, {Jiangbei, Cup}],
																				lib_mail:send_sys_mail(RoleId, util:to_binary(Title), util:to_binary(Content), GoodsList, LogInfo)
																		end, DeleteList)
												  
												  
												  end,
												  ?DEBUG_MSG("TestDelete4:~p----~p~n",[IsReward,Id]),
												  ets:update_element(?ETS_GUESS_QUESTION, Id, [{#guess_question.is_reward, 1}]),
												  db:update(guess, [{is_reward, 1}], [{id, Id}]);               
											  _ ->	%% 已经结算过了
												 
												  ?ERROR_MSG("guess_settle already : ~p~n", [Id])
										  end,
										  ets:delete(?ETS_GUESS_QUESTION, Id),
										  db:delete(guess, [{id, Id}]),
                                          case NowTime >= TimeShowEnd  of 
											  true -> 
													  skip;
											  false ->
												  {ok, BinDel} = pt_31:write(31204, [Id]),
												  lib_send:send_to_all(BinDel)
										  end
										  
								  end, ListDel);
				Err ->
					?ERROR_MSG("Err : ~p~n", [Err])
			end;
		Err ->
			?ERROR_MSG("Err : ~p~n", [Err])
	end.
	

sync_center_data([], Acc) ->
	Acc;

sync_center_data([{obj, Obj}|List], Acc) ->	
	case rfc4627:decode(sm_admin:get_value_bin("options", Obj)) of
		{ok, OptionsObjList, _} ->
			Id = sm_admin:get_value_int("id", Obj),
			Title = sm_admin:get_value_bin("title", Obj),
			Content = sm_admin:get_value_bin("content", Obj),
			Correct = sm_admin:get_value_int("correct", Obj),
			Commission = sm_admin:get_value_int("commission", Obj),
			TimeBetBegin = sm_admin:get_value_int("time_bet_begin", Obj),
			TimeBetEnd = sm_admin:get_value_int("time_bet_end", Obj),
			TimeShowBegin = sm_admin:get_value_int("time_show_begin", Obj),
			TimeShowEnd = sm_admin:get_value_int("time_show_end", Obj),
			CreateTime = sm_admin:get_value_int("create_time", Obj),
			OptionsList = 
				lists:foldl(fun(ObjOption, AccOp) ->
									{ok, Option} = rfc4627:get_field(ObjOption, "option"),
									{ok, OptionValue} = rfc4627:get_field(ObjOption, "value"),
									[{Option, OptionValue}|AccOp]
							end, [], OptionsObjList),
			
			GuessQuestion = 
				#guess_question{
								id = Id,
								title = Title,
								content = Content,
								options = OptionsList,
								correct = Correct,
								commission = Commission,
								time_bet_begin = TimeBetBegin,
								time_bet_end = TimeBetEnd,
								time_show_begin = TimeShowBegin,
								time_show_end = TimeShowEnd,
								create_time = CreateTime,
								total_cup = 0,
								total_rmb = 0
							   },
			sync_center_data(List, [GuessQuestion|Acc]);
		_ ->
			sync_center_data(List, Acc)
	end.


%% @doc 开服初始化数据
load_guess_data() ->
	Sql = "id, title, content, options, correct, is_reward, commission, time_bet_begin, time_bet_end, time_show_begin, time_show_end, create_time",
	case db:select_all(guess, Sql, []) of
		[] ->
			%% 没有就不管了
			ok;
		DataList ->
			GqList = 
				lists:foldl(fun([Id, Title, Content, Options0, Correct, IsReward, Commission, TimeBetBegin, TimeBetEnd, TimeShowBegin, TimeShowEnd, CreateTime], Acc) ->
									Options = util:bitstring_to_term(Options0),
									GuessQuestion = 
										#guess_question{
														id = Id,
														title = Title,
														content = Content,
														options = Options,
														correct = Correct,
														commission = Commission,
														is_reward = IsReward,
														time_bet_begin = TimeBetBegin,
														time_bet_end = TimeBetEnd,
														time_show_begin = TimeShowBegin,
														time_show_end = TimeShowEnd,
														create_time = CreateTime,
														total_cup = 0, 
														total_rmb = 0
													   },
									[GuessQuestion|Acc]
							end, [], DataList),
			ets:insert(?ETS_GUESS_QUESTION, GqList),
			load_guess_bet_data(GqList)
	end.


%% 初始化奖池数据
load_guess_bet_data([]) ->
	ok;

load_guess_bet_data([Gq|List]) ->
	Id = Gq#guess_question.id,
	case db:select_row(guess_bet, "sum(bet_cup), sum(bet_rmb)", [{guess_id, Id}]) of
		[TotalCup0, TotalRmb0] ->
			GuessMinGoodsReward = data_special_config:get('guess_min_goods_reward'),
			GuessMinMoneyReward = data_special_config:get('guess_min_money_reward'),
			TotalCup = case is_integer(TotalCup0) of
						   true ->
							   TotalCup0 + GuessMinGoodsReward;
						   false ->
							   GuessMinGoodsReward
					   end,
			TotalRmb = case is_integer(TotalRmb0) of
						   true ->
							   TotalRmb0 + GuessMinMoneyReward;
						   false ->
							   GuessMinMoneyReward
					   end,
			ets:update_element(?ETS_GUESS_QUESTION, Id, [{#guess_question.total_cup, TotalCup}, {#guess_question.total_rmb, TotalRmb}]);
		[] ->
			ok
	end,
	load_guess_bet_data(List).


%% 插入或更新问题数据
sync_guess_question(GuessQuestion) ->
	case ets:lookup(?ETS_GUESS_QUESTION, GuessQuestion#guess_question.id) of
		[] ->
			%% 后台新增的，插入本地数据库，同时发布全服在线玩家的广播，通知有新的竞猜
			#guess_question{
							id = Id,
							title = Title,
							content = Content,
							options = Options0,
							correct = Correct,
							commission = Commission,
							is_reward = IsReward,
							time_bet_begin = TimeBetBegin,
							time_bet_end = TimeBetEnd,
							time_show_begin = TimeShowBegin,
							time_show_end = TimeShowEnd,
							create_time = CreateTime
						   } = GuessQuestion,
			Options = util:term_to_bitstring(Options0),
			ets:insert(?ETS_GUESS_QUESTION, GuessQuestion),
			db:insert(guess, [id, title, content, options, correct, commission, is_reward, time_bet_begin, time_bet_end, time_show_begin, time_show_end, create_time], 
					  [Id, Title, Content, Options, Correct, Commission, IsReward, TimeBetBegin, TimeBetEnd, TimeShowBegin, TimeShowEnd, CreateTime]),
			{ok, BinBroad} = pt_31:write(31203, [GuessQuestion]),
			lib_send:send_to_all(BinBroad);
		[OldGuess] ->
			%% 更新
			update_guess(OldGuess, GuessQuestion)
	end.




update_guess(#guess_question{id = Id} = OldGuess, NewGuess) ->
	case lists:foldl(fun({Pos, DbFiled}, {PosValAcc, DbFieldValAcc}) ->
							 NewVal = erlang:element(Pos, NewGuess),
							 case erlang:element(Pos, OldGuess) =/= NewVal of
								 true ->
									 NewValDb = 
										 case lists:member(DbFiled, ?GUESS_DB_FIELD_ESCAPE) of
											 true ->
												 util:term_to_bitstring(NewVal);
											 false ->
												 NewVal
										 end,
									 {[{Pos, NewVal}|PosValAcc], [{DbFiled, NewValDb}|DbFieldValAcc]};
								 _ ->
									 {PosValAcc, DbFieldValAcc}
							 end
					 end, {[], []}, ?GUESS_POS_FIELD_LIST) of
		{[], []} ->
			ok;
		{PosValueL, DbFieldValL} ->
			ets:update_element(?ETS_GUESS_QUESTION, Id, PosValueL),
			db:update(guess, DbFieldValL, [{id, Id}])
	end.


%% 获取我的投注结果，进程字典没有则去数据库查找
get_my_bet(PS, GuessId) ->
	RoleId = player:id(PS),
	Key = {guess, GuessId},
	case erlang:get(Key) of
		?undefined ->
			%% 没有初始化，去数据库找找
			{Option, BetCup, BetRmb} =
				case db:select_row(guess_bet, "options, bet_cup, bet_rmb", [{role_id, RoleId}, {guess_id, GuessId}]) of
					[] ->
						{0, 0, 0};
					[Option0, BetCup0, BetRmb0] ->
						{Option0, BetCup0, BetRmb0}
				end,
			erlang:put(Key, {Option, BetCup, BetRmb}),
			{Option, BetCup, BetRmb};
		{Option, BetCup, BetRmb} ->
			{Option, BetCup, BetRmb}
	end.


set_my_bet(PS, GuessId, Option, BetRmb, BetCup) ->
	RoleId = player:id(PS),
%% 	Field_Value_List = [{role_id, RoleId}, {guess_id, GuessId}, {options, Option}, {bet_cup, BetCup}, {bet_rmb, BetRmb}, {create_time, util:unixtime()}],
	FieldList = ["role_id", "guess_id", "options", "bet_cup", "bet_rmb", "create_time"],
	ValueList = [RoleId, GuessId, Option, BetCup, BetRmb, util:unixtime()],
	TId = db:insert_get_id(guess_bet, FieldList, ValueList),
	adust_id(TId),
	Key = {guess, GuessId},
	erlang:put(Key, {Option, BetCup, BetRmb}).



adust_id(TId) ->
    Id = 
        case lib_account:is_global_uni_id(TId) of 
            true -> TId; 
            false -> 
                GlobalId = lib_account:to_global_uni_id(TId),
                db:update(?DB_SYS, guess_bet, ["id"], [GlobalId], "id", TId), 
                GlobalId
        end,
    Id.