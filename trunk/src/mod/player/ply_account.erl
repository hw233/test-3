%%%--------------------------------------
%%% @Module  : ply_account
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.7.30
%%% @Description: 玩家账户相关的业务逻辑
%%%--------------------------------------
-module(ply_account).
-export([
		 discard_role/2,
		 retrieve_role/1,
		 modify_nickname/3,
		 mobile_bind_sms_code/2,
		 account_bind_mobile/3,
		 check_account_bind_phone/1,
		 feedback/3
		]).

-include("common.hrl").
-include("account.hrl").
-include("ets_name.hrl").
-include("pt_10.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("obj_info_code.hrl").
-include("guild.hrl").

-include("record.hrl").

-include("pt_14.hrl").

-include("goods.hrl").

%% 删除角色
discard_role(PS, TargetRoleId) ->
	case check_discard_role(PS, TargetRoleId) of
		{fail, cli_msg_illegal} ->
			skip;
		{fail, Reason} ->
			?TRACE("check_discard_role() ret fail~n"),
			notify_cli_discard_role_result(PS, TargetRoleId, ?RES_FAIL),
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			?TRACE("check_discard_role() ret ok~n"),
			PhoneInfo = ply_phone:get_phone_info(),
			do_discard_role(PS, TargetRoleId, PhoneInfo)
	end.


%% 恢复角色
%% @return: ok | fail
retrieve_role(RoleId) ->
	lib_account:retrieve_role(RoleId).


modify_nickname(PS, GoodsId, Name) ->
	case mod_inv:check_batch_destroy_goods_by_id(player:id(PS), [GoodsId]) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			case lib_account:new_role_name_legal(Name) of
				{false, Reason} ->
					{fail, Reason};
				true ->
					mod_inv:destroy_goods_by_id_WNC(player:id(PS), [{GoodsId, 1}], [?LOG_GOODS, "use"]),
					RetName = list_to_binary(Name),
					PS1 = player_syn:set_name(PS, RetName),
					db:update(player:id(PS), player, ["nickname"], [RetName], "id", player:id(PS)),
					lib_scene:notify_string_info_change_to_aoi(player:id(PS), [{?OI_CODE_NICKNAME, RetName}]),
					gen_server:cast(?GUILD_PROCESS, {'modify_mb_name', PS1}),
					ply_hire:update_info(PS1),
					
					mod_broadcast:send_sys_broadcast(133, [player:get_name(PS), player:id(PS), RetName, player:id(PS)]),
					
					F = fun(X) ->  
								?DEBUG_MSG("ChangeName =~p,~p,~p",[X,Name,RetName]),
								case player:get_PS(X) of
									APS when is_record(APS,player_status) ->
										{ok, BinData} = pt_14:write(?PT_CHANGE_NAME,[player:id(PS),RetName]),
										lib_send:send_to_sock(APS, BinData);
									_ -> skip
								end
						end,
					
					lists:foreach(F,ply_relation:get_friend_id_list(PS)),
					
					spawn(fun() -> send_mail_to_friends(ply_relation:get_friend_id_list(PS), player:get_name(PS), RetName) end),
					{ok, RetName}
			end
	end.

check_discard_role(PS, TargetRoleId) ->
	case TargetRoleId /= player:id(PS) of
		true ->
			?ASSERT(false, TargetRoleId),
			{fail, cli_msg_illegal};
		false ->
			case player:is_in_team(PS) of
				true ->
					{fail, ?PM_DISCARD_ROLE_FAIL_IN_TEAM};
				false ->
					% 检测次数，避免频繁删除
					case get_discard_role_times(PS) >= ?MAX_DISCARD_ROLE_TIMES of
						true ->
							?WARNING_MSG("discard role reach max times!! Account:~p, PlayerId:~p, TargetRoleId:~p", [player:get_accname(PS), player:id(PS), TargetRoleId]),
							{fail, ?PM_DISCARD_ROLE_FAIL_TIMES_LIMIT};
						false ->
							ok
					end
			end	
	end.



do_discard_role(PS, TargetRoleId, PhoneInfo) ->
	Res = case lib_account:discard_role(TargetRoleId, PhoneInfo) of
			  ok ->
				  incr_discard_role_times(PS),
				  % TODO: 记录删除角色的行为日志
				  % ...
				  ?RES_OK;
			  _ ->
				  ?RES_FAIL
		  end,
	notify_cli_discard_role_result(PS, TargetRoleId, Res).




get_discard_role_times(PS) ->
	AccName = player:get_accname(PS),
	case ets:lookup(?ETS_DISCARD_ROLE_TIMES, AccName) of
		[] ->
			Times = lib_account:db_get_discard_role_times(AccName),
			NewR = #discard_role_times{accname = AccName, times = Times},
			ets:insert_new(?ETS_DISCARD_ROLE_TIMES, NewR),
			Times;
		[R] ->
			R#discard_role_times.times
	end.


incr_discard_role_times(PS) ->
	AccName = player:get_accname(PS),
	[R] = ets:lookup(?ETS_DISCARD_ROLE_TIMES, AccName),
	NewTimes = R#discard_role_times.times + 1,
	% 更新到DB
	lib_account:db_update_discard_role_times(AccName, NewTimes),
	% 更新到内存
	NewR = R#discard_role_times{times = NewTimes},
	ets:insert(?ETS_DISCARD_ROLE_TIMES, NewR).




notify_cli_discard_role_result(PS, TargetRoleId, Result) ->
	{ok, Bin} = pt_10:write(?PT_DISCARD_ROLE, [Result, TargetRoleId]),
	lib_send:send_to_sock(PS, Bin, true).


send_mail_to_friends(FriendIdL, OldName, NewName) ->
	Title = <<"好友改名通知">>,
	Content = list_to_binary(io_lib:format(<<"您的好友 ~s 改名为~s 了。">>, [OldName, NewName])),
	F = fun(X) ->  
				% ?DEBUG_MSG("ChangeName =~p,~p,~p",[X,OldName,NewName]),
				lib_mail:send_sys_mail(X, Title, Content, [], [])
		end,
	[F(X) || X <- FriendIdL].




%% 账号绑定手机发送验证码 
%% @return : ok | {fail, Reason}
mobile_bind_sms_code(PS, Mobile) ->
	%% 判断当月是否已绑定 
	PlayerId = player:id(PS),
	case check_account_bind_phone(PS) of
		true ->
			ControlUrl = config:get_admin_addr_control_server(),
			Path = "/servlet/SmsBindAccount",
			Url = lists:concat([ControlUrl, Path]),
			Code = util:rand(1000, 9999),
			Unixtime = util:unixtime(),
			SignSrc = lists:concat([Mobile, Code, Unixtime, ?TICKET]),
			Sign = util:md5(SignSrc),
			Params = [{mobile, Mobile}, {code, Code}, {unixtime, Unixtime}, {sign, Sign}], 
			case abs(get_last_sms_time(PlayerId) - Unixtime) > 120 of
				?true ->
					case get_today_sms_count(PlayerId) > 10 of
						?false ->
							case util:request_get(Url, Params) of
								{ok, {{_NewVersion, 200, _NewReasonPhrase}, _NewHeaders, NewBody}} ->
									case util:to_binary(NewBody) of
										<<"Success">> ->% 发送成功
											Object = {PlayerId, Code, Unixtime, get_today_sms_count(PlayerId) + 1},
											ets:insert(?ETS_ACCOUNT_BIND_MOBILE_SMS, Object),
											set_last_sms_time(),
											ok;
										<<"Faild">> ->% 失败
											?ERROR_MSG("Err : Faild ~n", []),
											{fail, ?PM_UNKNOWN_ERR}
									end;
								Err ->
									?ERROR_MSG("Err : ~p~n", [{PlayerId, Err}]),
									{fail, ?PM_UNKNOWN_ERR}
							end;
						?true ->% 每日限制10条
							?ERROR_MSG("Err : ~p~n", [PlayerId]),
							{fail, ?PM_OP_FREQUENCY_LIMIT}
					end;
				?false ->% 冷却中
					?ERROR_MSG("Err : ~p~n", [PlayerId]),
					{fail, ?PM_OP_FREQUENCY_LIMIT}
			end;
		false ->% 当月已绑定
			?ERROR_MSG("Err : ~p~n", [PlayerId]),
			{fail, ?PM_ACCOUNT_BIND_MOBILE_ALREADY}
	end.


account_bind_mobile(PS, Mobile, Code) -> 
	PlayerId = player:id(PS),
	%% 判断当月是否已绑定
	case check_account_bind_phone(PS) of
		true ->
			case ets:lookup(?ETS_ACCOUNT_BIND_MOBILE_SMS, PlayerId) of
				[{PlayerId, CodeSms, Unixtime, _Count}] ->
					Now = util:unixtime(),
					case abs(Now - Unixtime) > 300 of
						?true ->% 5分钟失效
							{fail, ?PM_ACCOUNT_BIND_CODE_OUTDATE};
						?false ->
							case CodeSms of
								Code ->
									%% 判断背包是否满足
									RewardPkg = data_special_config:get(get_bangding),
									GoodsList = [{RewardPkg, 1}],
									case mod_inv:check_batch_add_goods(PlayerId, GoodsList) of
										{fail, _Reason} ->
											{fail, ?PM_US_BAG_FULL};
										ok ->
											case update_account_bind_phone_time(PS) of
												ok ->
													mod_inv:batch_smart_add_new_goods(PlayerId, GoodsList, [{bind_state, ?BIND_ALREADY}], [?LOG_PAY, "account_bind_mobile"]),
													Account = player:get_accname(PS),
													ControlUrl = config:get_admin_addr_control_server(),
													Path = "/servlet/AccountBindMobile",
													Url = lists:concat([ControlUrl, Path]),
													SignSrc = lists:concat([Account, Mobile, Now, ?TICKET]),
													Sign = util:md5(SignSrc),
													Arguments = [{account, Account}, {mobile, Mobile}, {unixtime, Now}, {sign, Sign}],
													util:request_get(Url, Arguments),
													ets:delete(?ETS_ACCOUNT_BIND_MOBILE_SMS, PlayerId),
													% 初始化手机号禁言
													mod_chat:init_ban_phone(player:get_accname(PS), self()),

													ok;
												_ ->% 内部错误
													{fail, ?PM_UNKNOWN_ERR}
											end
									end;
								_ ->% 验证码错误
									{fail, ?PM_ACCOUNT_BIND_CODE_ERROR}
							end
					end;
				[] ->% 验证码错误
					{fail, ?PM_ACCOUNT_BIND_CODE_ERROR}
			end;
		false ->% 当月已绑定
			{fail, ?PM_ACCOUNT_BIND_MOBILE_ALREADY}
	end.


%% 检查是否可以绑定，每月绑定一次
%% @return : boolean() true 可绑定 | false 未绑定
check_account_bind_phone(PS) ->
	Key = account_bind_time,
	case lib_player_ext:try_load_data(PS, Key) of
		{ok, 0} ->
			true;
		{ok, Unixtime} ->
			case util:is_same_month(Unixtime) of
				?true ->
					% 当月已绑定
					false;
				?false ->
					true
			end;
		E ->% 未知错误
			?ERROR_MSG("E : ~p~n", [E]),
			false
	end.


%% 更新绑定时间
update_account_bind_phone_time(PS) ->
	Key = account_bind_time,
	lib_player_ext:try_update_data(PS, Key, util:unixtime()).


get_today_sms_count(PlayerId) ->
	case ets:lookup(?ETS_ACCOUNT_BIND_MOBILE_SMS, PlayerId) of
		[{PlayerId, _Code, Unixtime, Count}] ->
			case util:is_same_day(Unixtime) of
				?true ->
					Count;
				?false ->
					0
			end;
		
		[] ->
			0
	end.

get_last_sms_time(PlayerId) ->
	case erlang:get(last_sms_time) of
		?undefined ->
			case ets:lookup(?ETS_ACCOUNT_BIND_MOBILE_SMS, PlayerId) of
				[{PlayerId, _Code, Unixtime, _Count}] ->
					Unixtime;
				[] ->
					0
			end;
		LastTime ->
			LastTime
	end.

get_last_feedback_time() ->
	case erlang:get(last_feedback_time) of
		?undefined ->
			0;
		LastTime ->
			LastTime
	end.



set_last_sms_time() ->
	set_last_sms_time(util:unixtime()).

set_last_sms_time(Unixtime) ->
	set_last_time(last_sms_time, Unixtime).

set_last_feedback_time() ->
	set_last_feedback_time(util:unixtime()).

set_last_feedback_time(Unixtime) ->
	set_last_time(last_feedback_time, Unixtime).

set_last_time(Key) ->
	set_last_time(Key, util:unixtime()).

set_last_time(Key, Unixtime) ->
	erlang:put(Key, Unixtime).




%% 玩家反馈游戏意见
feedback(PS, Type0, Feedback0) ->
	ServerId = player:get_from_server_id(PS),
	Account = player:get_accname(PS),
	PlayerId = player:get_id(PS),
	ControlUrl = config:get_admin_addr_control_server(),
	Path = "/servlet/gameFeedback",
	Url = lists:concat([ControlUrl, Path]),
	Unixtime = util:unixtime(),
	Type = min(6, max(1, Type0)),
	SignSrc = lists:concat([ServerId, Account, PlayerId, Unixtime, Type, ?TICKET]),
	Sign = util:md5(SignSrc),
 	Feedback = unicode:characters_to_list(Feedback0, utf8),
	Param = [{server_id, ServerId}, {account, Account}, {player_id, PlayerId}, {type, Type}, {feedback, Feedback}, {unixtime, Unixtime}, {sign, Sign}],
	case abs(get_last_feedback_time() - Unixtime) > 120 of
		?true ->
			case util:request_post(Url, Param) of
				{ok, {{_NewVersion, 200, _NewReasonPhrase}, _NewHeaders, NewBody}} ->
					case util:to_binary(NewBody) of
						<<"Success">> ->% 成功
							set_last_feedback_time(),
							ok;
						<<"Faild">> ->% 失败
							?ERROR_MSG("Err : Faild ~n", []),
							{fail, ?PM_UNKNOWN_ERR}
					end;
				Err ->
					?ERROR_MSG("Err : ~p~n", [{PlayerId, Err}]),
					{fail, ?PM_UNKNOWN_ERR}
			end;
		?false ->% 冷却中
			?ERROR_MSG("Err : ~p~n", [PlayerId]),
			{fail, ?PM_OP_FREQUENCY_LIMIT}
	end.
	









