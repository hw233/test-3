-module(sm_admin).
-export([handle/2, get_value_int/2, get_value_bin/2,rebate_function/2]).

-include("debug.hrl").
-include("common.hrl").
-include("record.hrl").
-include("scene.hrl").
-include("record/goods_record.hrl").
-include("goods.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("admin_activity.hrl").
-include("player.hrl").
-include("global_sys_var.hrl").
-include("chapter_target.hrl").
-include("reward.hrl").

-define(ERROR, 0).
-define(SUCCESS, 1).
-define(RESULT, "result").

-define(IMMED_ADMIN_ACTIVITY, [1,2,5]).
-define(DURATION_ADMIN_ACTIVITY, [3]).

% parse_args(Args) ->
%         my_eapi:lists_foreach(string:tokens(Args, "&"),
%                               fun(Token, State) ->
%                                 case string:tokens(Token, "=") of
%                                         [Key, Value] ->
%                                                 lists:append(State, [{Key, Value}]);
%                                         _Other ->
%                                                 State
%                                 end
%                               end,
%                               []).

% test(_Env, Input) ->
%         Args = parse_args(Input),
%         ?TRACE("test input: ~p~n", [Args]),
%         case util:json_parse(Input) of
%             {ok, Protol, Args, _} -> handle_msg(Protol, Args);
%             _Other -> error_back(0)
%         end.



%% @doc处理http 请求
%% @return json()
handle(Env, Input) ->
	try handle_request(Env, Input) of
		Result -> Result
	catch
		Type:Err ->
			?ERROR_MSG("[sm_admin] handle_request error, Arg = ~w~n, Err = ~w~n", [{Env, Input}, {Type, Err}]),
			error_back(0)
	end.
% sm_admin:test(6,1010800000000367,0,25,0).





handle_request(Env, Input) ->
	case check_security(Env) of
		true ->
			?LDS_TRACE("sm_admin method & input", [{parse_request_type(Env), Input}]),
			case parse_request_type(Env) of
				post ->
					%% 处理post请求
					case util:json_parse(Input) of
						{ok, Protol, Args, _} ->
							try handle_msg(Protol, Args) of
								Result -> Result
							catch
								T:E ->
									?ERROR_MSG("[sm_admin] handle_msg protocol = ~p~n Args = ~p~n, error_type = ~w~n error = ~w~n stacktrace : ~p~n", [Protol, Args, T, E, erlang:get_stacktrace()]),
									error_back(0)
							end;
						_Other -> error_back(0)
					end;
				get ->
					%% 处理get请求
					case util:json_parse(http_lib:url_decode(Input)) of
						{ok, Protol, Args, _} ->
							handle_msg(Protol, Args);
						_Other -> error_back(0)
					end
			end;
		false -> error_back(0)
	end.


%% 检查是否需要url decoding
%% 暂定post请求不decoding, get请求decoding
parse_request_type(Env) ->
	case lists:keyfind(request_method, 1, Env) of
		false ->
			?ERROR_MSG("[sm_admin] prase HTTP HEAD list error, Env = ~w~n", [Env]),
			%% 默认当post处理
			post;
		{request_method, "POST"} -> post;
		_ -> get
	end.


%% @doc HTTP请求安全检查
%% @return : boolean()
check_security(Env) ->
	% 获取安全性验证开关
	case config:check_admin_security_switch() of
		_ -> true;
		true ->
			% 目前只添加IP白名单验证,
			% 由于后台请求不使用代理服务器, 且remote_addr不像HTTP_CLIENT_IP和HTTP_X_FORWARDED_FOR容易伪造, 故只取remote_addr作为来源IP
			case lists:keyfind(remote_addr, 1, Env) of
				false -> false;
				{remote_addr, Ip} ->
					?LDS_DEBUG(check_security, Ip),
					misc:check_ip_validity(misc:to_ip_string(Ip))
			end;
		false -> true
	end.


%% @doc 检查IP合法性
%% @return : boolean()
% -define(SECURITY_IP, security_ip).
% check_ip_validity(Ip) ->
%     % 暂定直接读取文件验证
%     % todo : 加载到ETS中直接在ETS中取出验证, 更新配置文件的时候需同步更新ETS
%     case get_config_info() of
%         null -> false;
%         Config ->
%             case lists:keyfind(?SECURITY_IP, 1, Config) of
%                 {?SECURITY_IP, IpList} when is_list(IpList) -> lists:member(Ip, IpList);
%                 _ -> false
%             end
%     end.




%% @doc 后台公告
handle_msg(1001, Args) ->
	Type = get_value("opType", Args),
	case Type =:= 3 of
		true ->
			Result = mod_broadcast:del_broadcast(get_value("id", Args)),
			call_back_result(1001, Result);
		false ->
			BroadCastRd = mod_broadcast:to_broadcast_record([
				get_value("id", Args), get_value("type", Args), get_value("priority", Args),
				get_value("content", Args), tool:to_integer(get_value("intervalTime", Args)), tool:to_integer(get_value("startTime", Args)),
				tool:to_integer(get_value("endTime", Args)), get_value("opType", Args)]),
			?LDS_TRACE(1001, BroadCastRd),
			Result = mod_broadcast:add_or_update_broadcast(BroadCastRd),
			?LDS_TRACE(result, Result),
			call_back_result(1001, Result)
	end;


%% @doc 查询在线人数
handle_msg(1002, _Args) ->
	Num = mod_svr_mgr:get_total_online_num(),
	call_back_args(1002, [{num, ?BIN_PRED(Num =:= undefined, 0, Num)}, {time, util:unixtime()}]);


%% @doc 在线发邮件
handle_msg(1003, Args) ->
	IdList = util:bitstring_to_term(get_value("playerId", Args)),
	Attch = util:bitstring_to_term(get_value("attach", Args)),
	Content = tool:to_binary(get_value("content", Args)),
	Title = tool:to_binary(get_value("title", Args)),
	{Result, Msg} = lib_mail:batch_send_sys_mail(IdList, Title, Content, Attch, [?LOG_MAIL, "recv_gm"]),
	Json = call_back({obj, [{"state", ?BIN_PRED(Result =:= ok, 1, 2)}, {"errorList", ?BIN_PRED(Msg =:= [], <<>>, util:term_to_bitstring(Msg)) }]}),
	?LDS_TRACE(1003, Json),
	Json;



%% ==================== 角色相关操作 ==========================

%% @doc 查看角色基础属性/金钱等
handle_msg(1101, Args) ->
	RoleId = get_value_int("roleId", Args),
	PsFlag =
		case player:get_PS(RoleId) of
			PS when is_record(PS, player_status) -> {1, PS};
			_ ->
				case ply_tmplogout_cache:get_tmplogout_PS(RoleId) of
					PS when is_record(PS, player_status) -> {2, PS};
					_ -> null
				end
		end,
	case PsFlag of
		{Online, Status} ->
			call_back([
				{"roleId", RoleId}
				,{"name", player:get_name(Status)}
				,{"silver", player:get_gamemoney(Status)}
				,{"bindSilver", player:get_bind_gamemoney(Status)}
				,{"gold", player:get_yuanbao(Status)}
				,{"bindGold", player:get_bind_yuanbao(Status)}
				,{"exp", player:get_exp(Status)}
				,{"con", player:get_base_con(Status)}
				,{"str", player:get_base_str(Status)}
				,{"spi", player:get_base_spi(Status)}
				,{"sta", player:get_base_stam(Status)}
				,{"agi", player:get_base_agi(Status)}
				,{"talent", player:get_free_talent_points(Status)}
				,{"online", Online}
			]);
		_ ->
			case db:select_row(player,
				"nickname, gamemoney, bind_gamemoney, yuanbao, bind_yuanbao, exp, base_talents, free_talent_points", [{id, RoleId}]) of
				[Name, Silver, BindSilver, Gold, BindGold, Exp, Talent, Point] ->
					{Str, Con, Sta, Spi, Agi} = util:bitstring_to_term(Talent),
					call_back([ {"roleId", RoleId}, {"name", Name},
						{"silver", Silver}, {"bindSilver", BindSilver}, {"gold", Gold}, {"bindGold", BindGold}
						,{"exp", Exp}, {"con", Con}, {"str", Str}, {"spi", Spi}, {"sta", Sta}, {"agi", Agi}, {"talent", Point}
						,{"online", 3}
					]);
				Err ->
					?ERROR_MSG("admin 1101 load player data roleId = ~p error = ~p~n", [RoleId, Err]),
					call_back_result(?ERROR)
			end
	end;

%% 查看角色被禁止状态
handle_msg(1102, Args) ->
	RoleId = get_value_int("roleId", Args),
	Now = util:unixtime(),
	{ChatTime, ChatReason} =
		case db:select_row(t_ban_chat, "end_time, reason", [{role_id, RoleId}]) of
			[] -> {0, <<>>};
			[Time, Reason] when is_integer(Time) -> {Time, tool:to_binary(Reason)};
			_ -> {error, error}
		end,
	{RoleTime, RoleReason} =
		case db:select_row(t_ban_role, "end_time, reason", [{role_id, RoleId}]) of
			[] -> {0, <<>>};
			[Time1, Reason1] when is_integer(Time1) -> {Time1, tool:to_binary(Reason1)};
			_ -> {error, error}
		end,
	RoleName =
		case db:select_row(player, "nickname", [{id, RoleId}]) of
			[Name] -> Name; %% util:term_to_bitstring(Name);
			_ -> error
		end,

	call_back([
		{"roleId", RoleId},
		{"name", RoleName},
		{"banChatTime", transform_banned_time(ChatTime, Now)},
		{"banChatReason", ChatReason},
		{"banRoleTime", transform_banned_time(RoleTime, Now)},
		{"banRoleReason", RoleReason}
	]);


%% @doc 设置禁言
handle_msg(1103, Args) ->
	RoleId = get_value_int("roleId", Args),
	Time = get_value_int("time", Args),
	Reason = get_value_bin("reason", Args),
	player:ban_chat(RoleId, Time, Reason),
	mod_chat:ban_chat_phone(RoleId, Time),
	call_back_result(?SUCCESS);


%% @doc 设置封禁角色
handle_msg(1104, Args) ->
	RoleId = get_value_int("roleId", Args),
	Time = get_value_int("time", Args),
	Reason = get_value_bin("reason", Args),
	?LDS_TRACE(1104, Time),
	player:ban_role(RoleId, Time, Reason),
	call_back_result(?SUCCESS);


%% @doc 修改属性
handle_msg(1105, Args) ->
	RoleId = get_value_int("roleId", Args),
	Silver = get_value_int("silver", Args),
	BindSilver = get_value_int("bindSilver", Args),
	Gold = get_value_int("gold", Args),
	BindGold = get_value_int("bindGold", Args),
	Exp = get_value_int("exp", Args),
	Con = get_value_int("con", Args),
	Str = get_value_int("str", Args),
	Sta = get_value_int("sta", Args),
	Spi = get_value_int("spi", Args),
	Agi = get_value_int("agi", Args),
	Talent = get_value_int("talent", Args),
	Json = case player:kick_role_offline_immediate(RoleId) of
					 ok ->
						 db:update(player,
							 [{gamemoney, Silver}, {bind_gamemoney, BindSilver}, {yuanbao, Gold}, {bind_yuanbao, BindGold},
								 {exp, Exp}, {free_talent_points, Talent}, {base_talents, util:term_to_bitstring({Str, Con, Sta, Spi, Agi})}],
							 [{id, RoleId}]),
						 call_back_result(?SUCCESS);
					 wait ->
						 receive
							 'ok' ->
								 db:update(player,
									 [{gamemoney, Silver}, {bind_gamemoney, BindSilver}, {yuanbao, Gold}, {bind_yuanbao, BindGold},
										 {exp, Exp}, {free_talent_points, Talent}, {base_talents, util:term_to_bitstring({Str, Con, Sta, Spi, Agi})}],
									 [{id, RoleId}]),
								 call_back_result(?SUCCESS)
						 after 3000 ->
							 call_back_result(?ERROR)
						 end
				 end,
	?LDS_TRACE(1105, Json),
	Json;


%% @doc 传送位置
handle_msg(1106, Args) ->
	RoleId = get_value_int("roleId", Args),
	SceneId = get_value_int("sceneId", Args),
	X = get_value_int("x", Args),
	Y = get_value_int("y", Args),
	?LDS_TRACE("1106", {RoleId, SceneId, X, Y}),
	case data_scene:get(SceneId) of
		Scene when is_record(Scene, scene_tpl) ->
			SceneType = Scene#scene_tpl.type,
			case player:kick_role_offline_immediate(RoleId) of
				ok ->
					db:update(player, [{scene_id, SceneId}, {scene_type, SceneType}, {x, X}, {y, Y}], [{id, RoleId}]),
					call_back_result(?SUCCESS);
				wait ->
					receive
						'ok' ->
							db:update(player, [{scene_id, SceneId}, {scene_type, SceneType}, {x, X}, {y, Y}], [{id, RoleId}]),
							call_back_result(?SUCCESS)
					after 3000 ->
						call_back_result(?ERROR)
					end
			end;
		_ -> call_back_result(?ERROR)
	end;


%% @doc 取得宠物信息
handle_msg(1108, Args) ->
	RoleId = get_value_int("roleId", Args),
	PetList = ply_partner:get_partner_list(RoleId),
	List = [pack_json_obj(
		[{"state", lib_partner:get_state(Pet)}, {"no", lib_partner:get_no(Pet)}, {"nickName", lib_partner:get_name(Pet)},
			{"lv", lib_partner:get_lv(Pet)}, {"life", lib_partner:get_life(Pet)}, {"battlePower", lib_partner:get_battle_power(Pet)},
			{"natureNo", lib_partner:get_nature(Pet)}, {"aptitude", pack_list_to_string([lib_partner:get_cur_life_aptitude(Pet),
			lib_partner:get_cur_mag_aptitude(Pet), lib_partner:get_cur_phy_att_aptitude(Pet), lib_partner:get_cur_mag_att_aptitude(Pet),
			lib_partner:get_cur_phy_def_aptitude(Pet), lib_partner:get_cur_mag_def_aptitude(Pet), lib_partner:get_cur_speed_aptitude(Pet),
			lib_partner:get_cur_grow(Pet)], "|")},
			{"cultivate", pack_list_to_string([lib_partner:get_cultivate_lv(Pet),
				?BIN_PRED(lib_partner:get_cultivate_lim(lib_partner:get_cultivate_lv(Pet), lib_partner:get_cultivate_layer(Pet)) =:= 0, "0%",
					tool:to_list(util:ceil(lib_partner:get_cultivate(Pet) / lib_partner:get_cultivate_lim(lib_partner:get_cultivate_lv(Pet), lib_partner:get_cultivate_layer(Pet)) * 100)) ++ "%")],  "|")},
			{"cultivateLv", lib_partner:get_evolve_lv(Pet)}, {"equip", <<>>},
			{"skills", pack_list_to_string(lib_partner:get_inborn_skill_name_list(Pet), "|")},
			{"postnatalSkill", pack_list_to_string(lib_partner:get_postnatal_skill_name_list(Pet), "|")},
			{"moodNo", lib_partner:get_mood_no(Pet)},
			{"quality", lib_partner:get_quality(Pet)}
			% {"test", 1}
		]
	) || Pet <- PetList],
	call_back([{"petInfo", List}]);


%% @doc 根据玩家uid获取角色rid（暂时是因为185sy补单需要通过uid或者角色rid）
handle_msg(1110, Args) ->
	Uid = get_value_int("uid", Args),
	case db:select_row(player, "local_id, id", [{accname, Uid}]) of
		[LocalId, Rid] ->
			call_back([{"role_id", Rid}, {"local_id", LocalId}]);
		Err ->
			?ERROR_MSG("admin 1110 get player uid = ~p error = ~p~n", [Uid, Err]),
			call_back_result(?ERROR)
	end;

% ==========================
%% @doc  充值
handle_msg(1111, Args) ->

	RoleId = get_value_int("rid", Args),
	Money = get_value_int("money", Args),
	GameMoney = get_value_int("gamemoney", Args),
	OrderId = get_value("orderId", Args),
	Sign = get_value("sign", Args),
	TimeStamp = get_value_int("orderTime", Args),
	%bao存到自动返利以及执行返利功能
	rebate_function(RoleId,GameMoney div 100),
	?DEBUG_MSG("testbudan ~p ~n",[{Money, GameMoney, RoleId }]),
	case check_recharge_sign(OrderId, Sign, TimeStamp) of
		true ->?DEBUG_MSG("wujiancheng1",[]),
			GameMoney2 =
				case ets:lookup(?ETS_PLAYER_VOUCHERS_INFO, RoleId) of
					[Vouchers] when is_record(Vouchers, player_vouchers_info) ->?DEBUG_MSG("wujiancheng5",[]),
						VouchersNo = Vouchers#player_vouchers_info.vouchers_no,
						case mod_inv:has_goods_in_bag_by_no(RoleId, VouchersNo) of
							false ->
								GameMoney;
							true ->
								Discount = data_cash_coupon_use_condition:get(VouchersNo),

								case Discount#cash_coupon_use_condition.type of
									1 ->
										case (GameMoney div 100 + Discount#cash_coupon_use_condition.value) >= (data_cash_coupon_use_condition:get(VouchersNo))#cash_coupon_use_condition.condition of
											true ->
												mod_inv:destroy_goods_WNC(RoleId, [{VouchersNo, 1}], [?LOG_VOUCHERS, "vouchers"]),
												ets:delete(?ETS_PLAYER_VOUCHERS_INFO, RoleId),
												GameMoney +  Discount#cash_coupon_use_condition.value * 100;
											false ->
												GameMoney
										end;
									2 ->
										case (GameMoney/100 / (1 -( Discount#cash_coupon_use_condition.value / 100))) >= (data_cash_coupon_use_condition:get(VouchersNo))#cash_coupon_use_condition.condition of
											true ->
												mod_inv:destroy_goods_WNC(RoleId, [{VouchersNo, 1}], [?LOG_VOUCHERS, "vouchers"]),
												ets:delete(?ETS_PLAYER_VOUCHERS_INFO, RoleId),
												case trunc(GameMoney / (1 -( Discount#cash_coupon_use_condition.value / 100))) >=(Vouchers#player_vouchers_info.step_num  * 100) of
													true ->
														Vouchers#player_vouchers_info.step_num * 100;
													false ->
														%%因为前端发过来的金额是向上取整过的
														trunc(GameMoney / (1 -( Discount#cash_coupon_use_condition.value / 100)))
												end;
											false ->
												GameMoney
										end

								end

						end;
					[] ->?DEBUG_MSG("wujiancheng4",[]),
						GameMoney
				end,
			%% 			GameMoney/100  88,168,598    1.经济    2.豪华    3.至尊
			Misc_Status = ply_misc:get_player_misc(RoleId),
			case GameMoney2 of
				12800 -> player:use_grow_fund(player:get_PS(RoleId),Misc_Status, 1);
%%				16800 -> player:use_grow_fund(player:get_PS(RoleId),Misc_Status, 2);
%%				58800 -> player:use_grow_fund(player:get_PS(RoleId),Misc_Status, 3);
				1800 -> player:use_month_card(player:get_PS(RoleId), ?MONTH_CARD_WEEK);
				2500 ->  player:use_month_card(player:get_PS(RoleId), ?MONTH_CARD);
				6800 -> player:use_month_card(player:get_PS(RoleId), ?MONTH_CARD_LIFE);
				18800 ->
					{_, _, _,PkgNo0} =  data_special_config:get('fudai'),
					RewardPkgCfg = data_reward_pkg:get(PkgNo0),
					{No_0,_,_,_,_} = lib_reward:decide_goods_by_prob(RewardPkgCfg#reward_pkg.goods_list),
					Title = data_special_config:get('fudai_mail_title'),
					Title2 =unicode:characters_to_list(Title,utf8),
					Content = data_special_config:get('fudai_mail'),
					Content2 =unicode:characters_to_list(Content,utf8),
					lib_mail:send_sys_mail(RoleId,util:to_binary(Title2), util:to_binary(Content2), [{No_0, 1 , 1 }], ["Fudai","onefudai"]);
				_    -> skip
			end,
			mod_achievement:notify_achi(involve_recharge, [], player:get_PS(RoleId)),
			?DEBUG_MSG("wujiancheng6",[]),
			ChapterMount = data_chapter_target:get_recharge_amount(),
			case  lists:member(GameMoney2 div 100, ChapterMount) of
				true ->?DEBUG_MSG("wujiancheng7",[]),
					case ets:lookup(ets_player_chapter_recharge, RoleId) of
						[{PlayerId,No}] ->?DEBUG_MSG("wujiancheng8",[]),
							case ets:lookup(?ETS_CHAPTER_TARGET, RoleId) of
								[R] ->?DEBUG_MSG("wujiancheng9",[]),
									RewardInfoList  = R#chapter_target.buy_and_recharge,
									DataResult = case lists:keyfind(No, 1, RewardInfoList) of
																 false ->
																	 {No, 1, 1, util:unixtime()};
																 RewardInfoReCord ->
																	 RewardInfoReCord
															 end,
									{_, BuyFlag, RechargeFlag, UnixTime}= DataResult,
									IsTheSameDay = util:is_same_day(UnixTime),
									{BuyFlag2, RechargeFlag2} =
										case IsTheSameDay of
											false ->
												{1 , 1};
											true ->
												{BuyFlag, RechargeFlag}
										end,
									case RechargeFlag2 > 0 of
										true ->
											ChapterNoInfo = data_chapter_target:get(No),
											RechargeGoodsNo = ChapterNoInfo#chapter_no.recharge_pkg,
											RechargeCount = ChapterNoInfo#chapter_no.recharge_count,
											lib_mail:send_sys_mail(RoleId, <<"七日盛典章节充值">>,
												<<"七日盛典章节充值内容">>,
												[{RechargeGoodsNo,1,RechargeCount}], [?LOG_MAIL, "achievement_recharge"]),


											NewRechargeStatus
												= case lists:keyfind(No, 1, RewardInfoList) of
														false ->
															[{No,BuyFlag2 , RechargeFlag2 - 1,util:unixtime() }|RewardInfoList];
														_ ->
															lists:keyreplace(No, 1, RewardInfoList, {No,BuyFlag2 , RechargeFlag2 -1, util:unixtime() })
													end,

											{ok, RMBValue} = lib_player_ext:try_load_data(RoleId,tuhaobang),
											mod_rank:role_RMB(player:get_PS(RoleId), RMBValue + (GameMoney2 div 100) ),
											lib_player_ext:try_update_data(RoleId,tuhaobang, RMBValue +  (GameMoney2 div 100) ),

											mod_chapter_target:update_chapter_achievement(PlayerId, R#chapter_target{buy_and_recharge = NewRechargeStatus }),
											db:update(recharge_order, [{state, ?RECHARGE_DEAL}], [{order_id, OrderId}]),
											mod_chapter_target:query_day_welfare(RoleId, No),
											call_back_result(?SUCCESS);
										false ->
											case player:admin_recharge(RoleId, GameMoney2/100, Money, OrderId, TimeStamp) of
												true ->
													call_back_result(?SUCCESS);
												{false, ErrCode} -> call_back_result(ErrCode)
											end
									end;


								[] ->
									case player:admin_recharge(RoleId, GameMoney2/100, Money, OrderId, TimeStamp) of
										true ->
											call_back_result(?SUCCESS);
										{false, ErrCode} -> call_back_result(ErrCode)
									end
							end;


						_ ->
							case player:admin_recharge(RoleId, GameMoney2/100, Money, OrderId, TimeStamp) of
								true ->?DEBUG_MSG("wujiancheng10",[]),
									call_back_result(?SUCCESS);
								{false, ErrCode} -> call_back_result(ErrCode)
							end
					end;
				false ->
					case player:admin_recharge(RoleId, GameMoney2/100, Money, OrderId, TimeStamp) of
						true ->?DEBUG_MSG("wujiancheng10",[]),
							call_back_result(?SUCCESS);
						{false, ErrCode} -> call_back_result(ErrCode)
					end
			end;

		false -> call_back_result(3)

	end;




% ==========================
%% @doc  查询背包
handle_msg(1120, Args) ->
	RoleId = get_value_int("roleId", Args),
	% RoleId = 1000100000000001,
	EqList = mod_inv:get_goods_list(RoleId, ?LOC_BAG_EQ),
	UseList = mod_inv:get_goods_list(RoleId, ?LOC_BAG_USABLE),
	UnUseList = mod_inv:get_goods_list(RoleId, ?LOC_BAG_UNUSABLE),
	JsonEq = {"equipBag", [pack_json_obj([{"goodsNo", Goods#goods.no}, {"goodsNum", Goods#goods.count}, {"slot", Goods#goods.slot}]) ||
		Goods <- EqList]},
	JsonUs = {"goodsBag", [pack_json_obj([{"goodsNo", Goods#goods.no}, {"goodsNum", Goods#goods.count}, {"slot", Goods#goods.slot}]) ||
		Goods <- UseList]},
	JsonUn = {"unuseBag", [pack_json_obj([{"goodsNo", Goods#goods.no}, {"goodsNum", Goods#goods.count}, {"slot", Goods#goods.slot}]) ||
		Goods <- UnUseList]},
	call_back([JsonEq, JsonUs, JsonUn]);


% ==========================
%% @doc  删除物品
handle_msg(1121, Args) ->
	RoleId = get_value_int("roleId", Args),
	GoodsNo = get_value_int("goodsNo", Args),
	Num = get_value_int("goodsNum", Args),
	case player:is_online(RoleId) of
		true ->
			Result = gen_server:call(player:get_pid(RoleId), {'destroy_goods_WNC', RoleId, [{GoodsNo, Num}]}),
			call_back_result(transform_result(Result));
		false ->
			Result = mod_inv:destroy_goods_offline(RoleId, [{GoodsNo, Num}], [?LOG_ADMIN, "gm_action"]),
			call_back_result(transform_result(Result))
	end;


% ==========================
%% @doc  恢复角色
handle_msg(1123, Args) ->
	RoleId = get_value_int("roleId", Args),
	case ply_account:retrieve_role(RoleId) of
		ok -> call_back_result(1);
		_ -> call_back_result(0)
	end;


% ==========================
%% @doc  设置玩家身份权限
handle_msg(1124, Args) ->
	RoleId = get_value_int("roleId", Args),
	State = get_value_int("state", Args),
	case State >= 0 andalso State =< 2 of
		true ->
			ply_priv:set_priv_lv(RoleId, State),
			call_back_result(1);
		false -> call_back_result(0)
	end;



% ==========================
%% @doc  运营活动
handle_msg(1201, Args) ->
	OrderId = get_value_int("orderId", Args),
	StartTime = get_value_int("activityStartTime", Args),
	EndTime = get_value_int("activityEndTime", Args),
	ClientStartTime = get_value_int("clientStartTime", Args),
	ClientEndTime = get_value_int("clientEndTime", Args),
	MailTitle = tool:to_binary(get_value("mailTitle", Args)),
	MailContent = tool:to_binary(get_value("mailContent", Args)),
	MailAttach = util:bitstring_to_term(get_value("mailAttach", Args)),
	ClientContent = tool:to_binary(get_value("clientContent", Args)),
	% ?LDS_DEBUG("[sm_admin] 1201 ", [OrderId, StartTime, EndTime, MailTitle, MailContent,
	%     MailAttach, ClientStartTime, ClientEndTime, ClientContent]),
	State = mod_admin_activity:add_new_admin_activity(OrderId, StartTime, EndTime, MailTitle, MailContent,
		MailAttach, ClientStartTime, ClientEndTime, ClientContent),
	call_back_result(State);



% ==========================
%% @doc  查看服务器开服时间
handle_msg(1202, _) ->
	case util:get_server_first_open_stamp() of
		Timestamp when is_integer(Timestamp) -> call_back_result(Timestamp);
		_ -> call_back_result(0)
	end;


% ==========================
%% @doc  修改服务器开服时间
handle_msg(1203, Args) ->
	Timestamp = get_value_int("timestamp", Args),
	case Timestamp > 0 of
		true ->
			case util:set_server_first_open_stamp(Timestamp) of
				ok -> call_back_result(1);
				_ -> call_back_result(0)
			end;
		false ->
			call_back_result(0)
	end;


% ==========================
%% @doc  后台-游戏系统活动
handle_msg(1204, Args) ->
	?LDS_DEBUG_W(1204, Args),
	RangeTime = ?AA_TIMER_INTERVAL div 1000,
	OrderId = get_value_int("orderId", Args),
	Op = get_value_int("op", Args),
	Sys = get_value_int("sys", Args),
	case Sys =:= 15 of
		true ->
			?DEBUG_MSG("qingkongshuju",[]),
			ets:delete_all_objects(?ETS_TIME_LIMIT_RANK),
			ets:delete_all_objects(?ETS_PLAYER_LOTTERY_INFO),
			db:delete(lottery, []);
		false -> skip
	end,
	EndTime = get_value_int("endTime", Args),
	Timestamp = ?BIN_PRED(lists:member(Sys, ?IMMED_ADMIN_ACTIVITY), EndTime, (get_value_int("activityTime", Args) - RangeTime)),
	Content = get_value_bin("content", Args),
	ShowPanel = get_value_bin("showPanel", Args),
	Display = get_value_int("display", Args),
	?LDS_DEBUG_W(12041, Content),
	case EndTime >= Timestamp of
		true ->
			case Op =/= 2 of
				true ->
					case check_admin_activity_content(Sys, Content) of
						{true, TermContent} ->
							?LDS_DEBUG("term", TermContent),
							R = handle_admin_sys_activity(Op, OrderId, Timestamp, EndTime, Sys, quote(Content),
								util:term_to_bitstring(TermContent), TermContent, quote(ShowPanel), Display),
							call_back_result(R);
						_ ->
							call_back_result(2)
					end;
				false ->
					R = handle_admin_sys_activity(Op, OrderId, Timestamp, EndTime, Sys, [], [], [], ShowPanel, Display),
					call_back_result(R)
			end;
		false ->
			call_back_result(6)
	end;


% ==========================
%% @doc 添加节日活动
handle_msg(1205, Args) ->

	List = get_value("activity", Args),
	% F = fun(Obj, Count) -> 
	%     case rfc4627:decode(Json) of
	%         {ok, {obj, ParseData}, _Remainder} ->
	%             [ParseData | Count];
	%         _ -> Count
	%     end
	% end,
	% ActivityList = lists:foldl(F, [], List),
	ActivityList = [Obj || {obj, Obj} <- List],
	?LDS_DEBUG(1205001, ActivityList),
	State = add_festival_activity(ActivityList),
	?LDS_DEBUG(1205, State),
	call_back_result(State);
% case rfc4627:decode(Json) of
%     {ok, {obj, ActivityList}, _Remainder} ->
%         State = add_festival_activity(ActivityList),
%         ?LDS_DEBUG(1205, State),
%         call_back_result(State);
%     _ -> call_back_result(0)
% end;


%% @doc 更新节日活动
handle_msg(1206, Args) ->
	OrderId = get_value_int("id", Args),
	Op = get_value_int("op", Args),
	No = get_value_int("no", Args),
	StartTime = get_value_int("startTime", Args),
	EndTime = get_value_int("endTime", Args),
	Type = get_value_int("type", Args),
	Content = get_value_bin("content", Args),
	?LDS_DEBUG(1206, {Op, OrderId, No, Type, StartTime, EndTime, Content}),
	State = update_festival_activity(Op, OrderId, No, Type, StartTime, EndTime, Content),
	?LDS_DEBUG(1206, {State}),
	call_back_result(State);

%% @doc 删除所有节日活动
handle_msg(1207, _Args) ->
	?LDS_DEBUG(1207),
	case mod_admin_activity:delete_all_festival_activity() of
		true -> call_back_result(?SUCCESS);
		{false, Code} -> call_back_result(Code)
	end;


%% @doc 查看奖励池信息
handle_msg(1208, _Args) ->
	RewardPool = mod_reward_pool:query_pool(),
	RewardPool;

%% @doc 设置奖励池
handle_msg(1209, Args) ->
	RewardNo = get_value_int("rewardId", Args),
	Stock = get_value_int("stock", Args),
	Result = mod_reward_pool:set_pool_stock(RewardNo, Stock),
	call_back_result(transform_result(Result));

%% @doc 重置服务器所有玩家首冲状态
handle_msg(1301, Args) ->
	Timestamp = get_value_int("timestamp", Args),
	GlobalSysVar = #global_sys_var{sys = ?SEND_FIRST_RECHARGE, var = Timestamp},
	mod_svr_mgr:set_global_sys_var(GlobalSysVar);


handle_msg(1210, Args) ->
	Time = get_value_int("time", Args),
	Result = mod_world_lv:open_world_lv(Time),
	call_back_result(transform_result(Result));


%% ============================  other =======================================


% ==========================
%% @doc  查询报警
handle_msg(2001, _Args) ->
	Warn = mod_sys_checker:get_warn(),
	WarnBin = util:term_to_bitstring(Warn),
	call_back_result(WarnBin);

%%添加自定义警报信息
handle_msg(2002, [{"content", Content}, {"err_code", ErrCode}]) ->
	handle_msg(2002, [{"err_code", ErrCode}, {"content", Content}]);

handle_msg(2002, [{"err_code", ErrCode}, {"content", Content}]) ->
	Uid = mod_sys_checker:add_alert({ErrCode, binary_to_list(Content)}),
	call_back_result(Uid);

%%删除自定义警报信息
handle_msg(2003, [{"uid", Uid}]) ->
	mod_sys_checker:del_alert(Uid),
	call_back_result(1);

%%获取自定义警报信息
handle_msg(2004, _) ->
	AlertBin = util:term_to_bitstring(mod_sys_checker:get_alerts()),
	call_back_result(AlertBin);

%%清除所有自定义警报信息
handle_msg(2005, _) ->
	mod_sys_checker:clear_alerts(),
	call_back_result(1);

handle_msg(_Cmd, _Arg) ->
	error_back(_Cmd).

%% ==========================================================================
%% Inteval faction
%% ==========================================================================

pack_json_obj(List) when is_list(List) ->
	{obj, List};
pack_json_obj(_) -> ?ASSERT(false), [].

%% JSON 回调
call_back(List) ->
	util:json_pack(List).

call_back_args(Protol, Lists) ->
	util:json_pack(Protol, [{"args", {obj, Lists}}]).

call_back_result(Result) ->
	util:json_pack([{"result", Result}]).
call_back_result(Protol, Result) ->
	util:json_pack(Protol, [{"result", transform_result(Result)}]).


error_back(Protol) ->
	util:json_pack(Protol, [{"result", ?ERROR}]).


%% @return null | value
get_value(Key, List) ->
	case lists:keyfind(Key, 1, List) of
		false -> null;
		{Key, Val} -> Val
	end.

get_value_int(Key, List) ->
	tool:to_integer(get_value(Key, List)).

get_value_bin(Key, List) ->
	tool:to_binary(get_value(Key, List)).

% get_value_float(Key, List) ->
%     tool:to_float(get_value(Key, List)).

% get_value_list(Key, List) ->
%     tool:to_list(get_value(Key, List)).


-define(SUCCESS_RESULT_SET, [ok, true, success, 1]).
%% 转换不同格式的返回结果统一改为0,1
transform_result(Result) ->
	case lists:member(Result, ?SUCCESS_RESULT_SET) of
		true -> 1;
		false -> 0
	end.


%% @doc 计算剩余禁止状态时间并转换时间格式
%% @return : integer() | error
transform_banned_time(null, _) -> 0;
transform_banned_time(0, _) -> 0;
transform_banned_time(1, _) -> -1;
transform_banned_time(Time, Now) when is_integer(Time) ->
	?BIN_PRED(Time > Now, Time - Now, 0);
transform_banned_time(_, _) -> error.


%% @doc 把列表元素按格式拼装成string
%% @Connector :: list()
%% @return : binary()
pack_list_to_string(List, Connector) when is_list(List), is_list(Connector) ->
	tool:to_binary(pack_list_to_string_1(List, Connector)).

pack_list_to_string_1([], _) -> [];
pack_list_to_string_1([Elem], _Connector) -> tool:to_list(Elem);
pack_list_to_string_1([Elem | Left], Connector) when is_list(Connector) ->
	tool:to_list(Elem) ++ Connector ++ pack_list_to_string_1(Left, Connector).


%% 检查充值签名认证
%% @return : boolean()
% -define(RECHARGE_KEY, recharge_key).
% check_recharge_sign(OrderId, Sign, TimeStamp) ->
%     case get_config_info() of
%         null -> false;
%         Config ->
%             case lists:keyfind(?RECHARGE_KEY, 1, Config) of
%                 {?RECHARGE_KEY, [Key | _]} ->
%                     Str = tool:md5(tool:to_list(OrderId) ++ tool:to_list(TimeStamp) ++ Key),
%                     tool:to_list(Str) == tool:to_list(Sign);
%                 _ -> false
%             end
%     end.
-define(MD5_KEY, "df9f79e24bf967b747a7e504d3596e036e5cbfc5ebbcd9dd1ad55e324772b0f076f11ccc5cc952785591a3596098b14a").
check_recharge_sign(OrderId, Sign, TimeStamp) ->
	Str = tool:md5(tool:to_list(OrderId) ++ tool:to_list(TimeStamp) ++ ?MD5_KEY),
	tool:to_list(Str) == tool:to_list(Sign).



%% 处理后台系统活动
%% @return : integer()
handle_admin_sys_activity(0, _, Timestamp, EndStamp, Sys, OriginContent, Content, TermContent, ShowPanel, Display) ->     % 新增
	case
		case EndStamp =:= Timestamp of
			true -> true;
			false ->
				case db:select_all(admin_sys_activity, "order_id", [{sys, Sys}, {state, "<>", 2}]) of
					[] -> true;
					_ -> false
				end
		end of
		true ->
			try db:insert_get_id(admin_sys_activity, ["trigger_timestamp", "end_timestamp", "sys", "origin_content",  "content","show_panel", "display"],
				[Timestamp, EndStamp, Sys, OriginContent, Content, ShowPanel, Display]) of
				OrderId when is_integer(OrderId) ->
					mod_admin_activity:add_new_admin_sys_activity(OrderId, Timestamp, EndStamp, Sys, TermContent, ShowPanel, Display),
					1;
				_ -> 0
			catch
				_:_ -> 0
			end;
		false -> 5
	end;
handle_admin_sys_activity(1, OrderId, Timestamp, EndStamp, Sys, OriginContent, Content, TermContent, ShowPanel, Display) ->       % 更新
	case mod_admin_activity:check_update(OrderId, Timestamp) of
		true ->
			case handle_admin_sys_activity(2, OrderId, Timestamp, EndStamp, Sys, OriginContent, Content, TermContent, ShowPanel, Display) of
				1 -> handle_admin_sys_activity(0, OrderId, Timestamp, EndStamp, Sys, OriginContent, Content, TermContent, ShowPanel, Display);
				ErrCode -> ErrCode
			end;
		{false, ErrCode} -> ErrCode
	end;
handle_admin_sys_activity(2, OrderId, _Timestamp, _EndStamp,  _Sys, _OriginContent, _Content, _TermContent, _ShowPanel, _Display) ->       % 删除
	% db:delete(admin_sys_activity, [{order_id, OrderId}]),

	case mod_admin_activity:check_delete(OrderId) of
		true ->
			mod_admin_activity:delete_admin_sys_activity(OrderId),
			1;
		{false, ErrCode} -> ErrCode
	end.


%% @return : false | {true, NewContent}
check_admin_activity_content(1, Content) ->
	mod_rank_gift:parse_web_gift(Content);
check_admin_activity_content(2, Content) ->
	lib_guild:check_activity_data(Content);
%% 将需要处理有效次数的活动分开解析
check_admin_activity_content(13, Content) ->
	player:parse_web_recharge_data2(Content);
%% check_admin_activity_content(Sys, Content) when Sys =:= 3 orelse (Sys >= 6 andalso Sys =< 9) orelse Sys =:= 13 orelse Sys =:= 14 ->
check_admin_activity_content(Sys, Content) when Sys =:= 3 orelse (Sys >= 6 andalso Sys =< 9) orelse Sys =:= 14 orelse (Sys >= 17 andalso Sys =< 21)  ->
	player:parse_web_recharge_data(Content);
check_admin_activity_content(5, _Content) ->
	{true, []};
check_admin_activity_content(10, Content) ->
	lib_beauty_contest:check_activity_data(Content);
check_admin_activity_content(11, Content) ->
	lib_shop:check_op_shop_activity_data(Content);
check_admin_activity_content(12, Content) ->
	player:parse_web_recharge_data(Content);
check_admin_activity_content(15, Content) ->
	%新活动开始，清空限时转盘上次的数据
	player:parse_lotto_data(Content);
check_admin_activity_content(_, _) ->
	false.



%% @doc 添加后台活动
%% @return : Code::integer()
add_festival_activity(ActivityList) ->
	F = fun(Activity, Count) ->
		No = get_value_int("no", Activity),
		StartTime = get_value_int("startTime", Activity),
		EndTime = get_value_int("endTime", Activity),
		Type = get_value_int("type", Activity),
		Content = get_value_bin("content", Activity),
		[[Type, No, StartTime, EndTime, Content] | Count]
			end,
	NewActivitys = lists:sort(lists:foldl(F, [], ActivityList)),
	% ?LDS_DEBUG(add_festival_activity, NewActivitys),
	case mod_admin_activity:check_add_all_festival_activity(NewActivitys) of
		true -> add_festival_activity_1(NewActivitys), ?SUCCESS;
		{false, Code} -> Code
	end.


add_festival_activity_1([]) -> ok;
add_festival_activity_1([[Type, No, StartTime, EndTime, Content] | Left]) ->
	mod_admin_activity:add_db_festival_activity(No, StartTime, EndTime, Type, Content),
	add_festival_activity_1(Left);
add_festival_activity_1(_) -> error.


%% @doc 更新节日活动
%% @return : Code::integer()
update_festival_activity(0, OrderId, No, Type, StartTime, EndTime, _Content) ->     % 删除
	case mod_admin_activity:check_update_festival(OrderId, No, Type, StartTime, EndTime) of
		true ->
			case mod_admin_activity:delete_festival_activity(No, OrderId) of
				true -> ?SUCCESS;
				{false, Code} -> Code
			end;
		{false, Code} -> Code
	end;
update_festival_activity(1, _OrderId, No, Type, StartTime, EndTime, Content) ->     % 新增
	case mod_admin_activity:single_add_festival_activity(No, Type, StartTime, EndTime, Content) of
		true -> ?SUCCESS;
		{false, Code} -> Code
	end;
update_festival_activity(2, OrderId, No, Type, StartTime, EndTime, Content) ->     % 修改
	?LDS_DEBUG(update_festival_activity, [{OrderId, No, Type}]),
	case update_festival_activity(0, OrderId, No, Type, StartTime, EndTime, Content) of
		?SUCCESS -> update_festival_activity(1, OrderId, No, Type, StartTime, EndTime, Content);
		Code -> Code
	end.





%%
%%sm_admin:rebate_function(1000100000000105,501),
rebate_function(PlayerId, Money) ->
	%如果单充活动开启，则判断是否符合单充活动的
	F =
		fun(X) ->
			case db:select_row(admin_sys_activity, "order_id", [{sys,  X}, {state,1}]) of
				[] ->
					skip;
				[OrderId] ->
					case ets:lookup(ets_admin_sys_activity, OrderId) of
						[] ->
							skip;
						[R] ->
							{Title,Content, RewardList} = R#admin_sys_activity.content,
							case lists:keyfind(Money,1,RewardList) of
								false ->
									skip;
								{Money, Reward} ->
									lib_mail:send_sys_mail(PlayerId, Title, Content, Reward, [?LOG_MAIL, "single_recharge"])
							end
					end
			end
		end,
	lists:foreach(F ,[]),


	F2 =
		fun(Sys) ->
			case db:select_row(admin_sys_activity, "order_id", [{sys,  Sys}, {state,1}]) of
				[] ->
					skip;
				[OrderId] ->
					case ets:lookup(ets_admin_sys_activity, OrderId) of
						[] ->
							skip;
						[R] ->
							{HaveRechargeMoney, HaveGetReward} =
								case ets:lookup(ets_player_acc_recharge, PlayerId) of
									[] ->ets:insert(ets_player_acc_recharge, {PlayerId, Money, [] }), {Money, []};
									[{PlayerId, RechargeMoney, GetReward}] ->
										ets:insert(ets_player_acc_recharge, {PlayerId, Money + RechargeMoney,GetReward}),  {Money + RechargeMoney,GetReward}
								end,

							{Title,Content, RewardList} = R#admin_sys_activity.content,

							DayRecharge=
								case ets:lookup(ets_player_day_recharge, PlayerId) of
									[] ->
										%%初始化一次数据
										case db:select_row(clock_data, "fanli", [{player_id,PlayerId}]) of
											[] ->
												db:insert(clock_data,[player_id, fanli], [ PlayerId,  util:term_to_bitstring({Money,Money,[]})] );
											_ ->
												skip
										end,
										ets:insert(ets_player_day_recharge, {PlayerId, Money}),Money;
									[{PlayerId,DayRecharge2}] ->
										ets:insert(ets_player_day_recharge, {PlayerId, Money + DayRecharge2}),Money + DayRecharge2
								end,

							case Sys =/= 21 of
								true ->
									AccRechargeF =
										fun(X,Acc) ->
											{MoneyPosition,Reward }=X,
											case lists:member(MoneyPosition, HaveGetReward) of
												true ->
													skip;
												false ->
													case HaveRechargeMoney >= MoneyPosition of
														true ->
															lib_mail:send_sys_mail(PlayerId, Title, Content, Reward, [?LOG_MAIL, "Acc_recharge"]),
															[MoneyPosition|Acc];
														false ->
															Acc
													end
											end
										end,
									AllGetReward = lists:foldl(AccRechargeF ,HaveGetReward , RewardList),
									Fanli = util:term_to_bitstring( {PlayerId, HaveRechargeMoney,AllGetReward}),
									db:update(PlayerId, clock_data, [{fanli, Fanli}], [{player_id,PlayerId}]),
									ets:insert(ets_player_acc_recharge, {PlayerId, HaveRechargeMoney,AllGetReward});
								false ->
									Fanli =util:term_to_bitstring({DayRecharge, HaveRechargeMoney, HaveGetReward}),
									db:update(PlayerId, clock_data, [{fanli, Fanli}],
										[{player_id,PlayerId}])
							end

					end
			end
		end,
	lists:foreach(F2,[17,18,21]).








quote(String) when is_list(String) ->
	lists:reverse(quote(String, [])); %% 39 is $'
quote(Bin) when is_binary(Bin) ->
	list_to_binary(quote(binary_to_list(Bin))).

quote([], Acc) ->
	Acc;
quote([$\\ | Rest], Acc) ->
	quote(Rest, [$\\ , $\\ | Acc]);
quote([C | Rest], Acc) ->
	quote(Rest, [C | Acc]).