%%%--------------------------------------
%%% @Module  : pp_relation
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2014.04.14
%%% @Description:  管理玩家间的关系
%%%--------------------------------------
-module(pp_relation).
-export([
            handle/3
         ]).

-include("relation.hrl").
-include("common.hrl").
-include("offline_data.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("pt_14.hrl").

%%请求好友列表
handle(14000, PS, []) ->
    L = ply_relation:get_relation_list(PS, ?FRIEND),
    PlayerId = player:get_id(PS),
    L2 = [pack_relation_list(PlayerId, X) || X <- L],

    L3 = 
        case length(L2) > ?MAX_FRIENDS of
            true -> lists:sublist(L2, ?MAX_FRIENDS);
            false -> L2
        end,

    % 仇人列表
    LE = ply_relation:get_relation_list(PS, ?ENEMY),
    LE2 = [pack_relation_list(PlayerId, X) || X <- LE],

    % 临时好友
    LC = ply_relation:get_relation_list(PS, ?CURRENTLY_CONTACT),
    LC2 = [pack_relation_list(PlayerId, X) || X <- LC],

    {ok,BinData} = pt_14:write(14000, [L3,LE2,LC2]),
    lib_send:send_to_sock(PS, BinData);


%%发送好友请求
handle(14001, PS, [IdList]) ->
    case ply_setting:accept_friend_invite(player:id(PS)) of
        false -> lib_send:send_prompt_msg(PS, ?PM_RELA_YOU_REFUSE);
        true ->
            case ply_relation:can_apply_count_day(PS) < length(IdList) of
                true -> 
                    lib_send:send_prompt_msg(PS, ?PM_APPLY_COUNT_DAY_LIMIT);
                false ->
                    F = fun(Id, {Acc, RetList}) ->
                        case player:get_PS(Id) of
                            null -> {Acc, [{?PM_TARGET_PLAYER_NOT_ONLINE, Id} | RetList]};
                            TPS ->
                                case ply_relation:check_add_friend(PS, TPS) of
                                    ok ->
                                        Data = [
                                                player:id(PS),
                                                player:get_lv(PS),
                                                player:get_race(PS),
                                                player:get_faction(PS),
                                                player:get_vip_lv(PS),
                                                ply_attr:get_battle_power(PS),
                                                player:get_name(PS)
                                            ],

                                        {ok, BinData} = pt_14:write(14006, Data),
                                        lib_send:send_to_sock(TPS, BinData),
                                        {Acc + 1, [{0, Id} | RetList]};
                                    {fail, Reason} ->
                                        {Acc, [{Reason, Id} | RetList]}
                                end
                        end
                    end,
                    {Count, Ret} = lists:foldl(F, {0, []}, IdList),
                    {ok,BinData} = pt_14:write(14001, Ret),
                    lib_send:send_to_sock(PS, BinData),
                    ply_relation:deduct_apply_count_day(PS, Count)
            end
    end;


%% 回应添加好友请求
handle(14002, PS, [Choice, IdList]) ->
    case Choice of
        0 -> skip;
        1 ->
            case length(ply_relation:get_friend_id_list(PS)) + length(IdList) > ?MAX_FRIENDS of
                true -> 
                    lib_send:send_prompt_msg(PS, ?PM_RELA_FRIEND_COUNT_LIMIT);
                false ->
                    mod_relation:add_friend(PS, IdList)
            end
    end;
    

%% 删除好友
handle(14003, PS, [RId]) ->
    mod_relation:del_friend(PS, RId);
    

handle(14010, PS, [PageSize, PageNum, Name]) ->
    case PageNum =< 0 orelse PageSize =< 0 of
        true -> lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
        false ->
            {TotalPage, PSList} = ply_relation:search_player_by_name(PS, Name, PageSize, PageNum),
            {ok, BinData} = pt_14:write(14010, [TotalPage, PageNum, PSList]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(14011, PS, _) ->
    Count = ply_relation:can_apply_count_day(PS),
    {ok, BinData} = pt_14:write(14011, [Count]),
    lib_send:send_to_sock(PS, BinData);    


%%私聊
handle(14012, PS, [Id, Msg]) ->
	case mod_player:check_chat_state(PS) of
		{ok, chat} ->
			case parse_msg_array(Msg) of
				{true, NewMsg} ->
					case player:get_lv(PS) > 40 of
						?true ->
							case lib_chat:check_chat_permission(PS) of
								true ->
									case player:get_sendpid(Id) of
										Pid when is_pid(Pid) ->
											{ok, BinData} = pt_14:write(14012, [Id, NewMsg]),
											lib_send:send_to_sock(PS, BinData),
											
											
											{ok, BinData1} = pt_14:write(14013, [{player:id(PS), NewMsg, util:unixtime()}]),
											lib_send:send_to_sid(Pid, BinData1);
										_ -> %% 保存离线消息
											RelaInfo = ply_relation:get_rela_info(Id),
											case length(RelaInfo#relation_info.offline_msg) >= ?RELA_MAX_OFFLINE_MSG of
												true ->
													lib_send:send_prompt_msg(PS, ?PM_RELA_OBJ_MAX_OFFLINE_MSG);
												false ->
													{ok, BinData} = pt_14:write(14012, [Id, NewMsg]),
													lib_send:send_to_sock(PS, BinData),
													gen_server:cast(?RELATION_PROCESS, {'add_offline_msg', Id, player:id(PS), NewMsg})
											end
									end,
									Channel = ?ENUM_CHAT_TYPE_PERSON,
									PlayerId = player:get_id(PS),
									PlayerId2 = Id,
									ServerId =util:term_to_bitstring(config:get_server_id()),
									PlayerName =  <<ServerId/binary ,   (player:get_name(PS))/binary,"to", (player:get_name(Id))/binary >>,
									Account = player:get_accname(PS),
									%% 私聊消息
									mod_udp:chat_monitor(Channel, Msg, PlayerName, PlayerId, PlayerId2, Account);
								_ ->
									lib_send:send_prompt_msg(PS, ?PM_CHAT_NEED_RECHARGE)
							end;
						?false ->
							lib_send:send_prompt_msg(PS, ?PM_LV_LIMIT)
					end;
				{false, _} ->
					lib_send:send_prompt_msg(PS, ?PM_RELA_MSG_OVERLENGTH)
			end;
		_ ->
			skip
	end;

handle(14013, PS, _) ->
    RelaInfo = ply_relation:get_rela_info(player:id(PS)),
    case RelaInfo#relation_info.offline_msg =:= [] of
        true -> skip;
        false ->
            {ok, BinData} = pt_14:write(14013, RelaInfo#relation_info.offline_msg),
            lib_send:send_to_sock(PS, BinData),
            gen_server:cast(?RELATION_PROCESS, {'clear_offline_msg', player:id(PS)})
    end;


handle(14050, PS, [Type]) ->
    case is_sworn_type_valid(Type) of
        false ->
            lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
        true ->
            case ply_relation:can_sworn(PS, Type) of
                {fail, RetList} ->
                    {ok, BinData} = pt_14:write(14050, [?RES_FAIL, Type, RetList]),
                    lib_send:send_to_sock(PS, BinData);
                ok ->
                    gen_server:cast(?RELATION_PROCESS, {'try_sworn', PS, Type})
            end
    end;


handle(14052, PS, [Type, Choice]) ->
    case is_sworn_type_valid(Type) of
        false ->
            lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
        true ->
            case ply_relation:has_sworn(player:id(PS)) of
                true -> skip;
                false ->
                    case player:is_in_team(PS) of
                        false -> skip;
                        true ->
                            gen_server:cast(?RELATION_PROCESS, {'reply_for_sworn', PS, Type, Choice})     
                    end
            end
    end;


%% 删除结拜关系
handle(14053, PS, _) ->
    case ply_relation:has_sworn(player:id(PS)) of
        false -> 
            lib_send:send_prompt_msg(PS, ?PM_RELA_NO_SWORN);
        true ->
            case player:has_enough_money(PS, ?MNY_T_BIND_GAMEMONEY, ?RELA_DEL_SWORN_NEED_MONEY) of
                false ->
                    lib_send:send_prompt_msg(PS, ?PM_GAMEMONEY_LIMIT);
                true ->
                    player:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, ?RELA_DEL_SWORN_NEED_MONEY, [?LOG_SWORN, "remove"]),
                    gen_server:cast(?RELATION_PROCESS, {'remove_sworn', PS})   
            end
    end;

%% 队长确认、修改称号前缀
handle(14055, PS, [Choice, Prefix]) ->
    Prefix1 = list_to_binary(Prefix),
    case is_sworn_name_valid(Prefix1) of
        {false, len_error} ->
            lib_send:send_prompt_msg(PS, ?PM_SWORN_NAME_LEN_ERROR);
        {false, char_illegal} ->
            lib_send:send_prompt_msg(PS, ?PM_SWORN_NAME_CHAR_ILLEGEL);
        true ->
            case ply_relation:has_sworn(player:id(PS)) of
                false -> 
                    lib_send:send_prompt_msg(PS, ?PM_UNKNOWN_ERR);
                true ->
                    case ply_relation:get_rela_info(player:id(PS)) of
                        null -> skip;
                        RelaInfo ->
                            case RelaInfo#relation_info.free_modify_pre_count =:= 1 of
                                true -> 
                                    case Choice of
                                        0 ->
                                            gen_server:cast(?RELATION_PROCESS, {'modify_sworn_prefix', PS, Choice, Prefix1});
                                        1 ->
                                            MoneyAdd = ?RELA_MAKE_SWORN_PRE_ONLY,
                                            case player:has_enough_money(PS, ?MNY_T_YUANBAO, MoneyAdd) of
                                                false ->
                                                    lib_send:send_prompt_msg(PS, ?PM_YB_LIMIT);
                                                true ->
                                                    case catch gen_server:call(?RELATION_PROCESS, {'modify_sworn_prefix', PS, Choice, Prefix1, 0, MoneyAdd}) of
                                                        {'EXIT', Reason} ->
                                                            ?ERROR_MSG("pp_relation:handle(14055(), exit for reason: ~w~n", [Reason]),
                                                            ?ASSERT(false, Reason),
                                                            lib_send:send_prompt_msg(PS, ?PM_MK_FAIL_SERVER_BUSY);
                                                        _Any -> skip
                                                    end
                                            end
                                    end;
                                false ->
                                    MoneyBase = ?RELA_MODIFY_SWORN_PRE_NEED_MONEY,
                                    MoneyAdd = 
                                        case Choice of
                                            1 -> ?RELA_MAKE_SWORN_PRE_ONLY;
                                            0 -> 0
                                        end,
                                    case player:has_enough_money(PS, ?MNY_T_YUANBAO, MoneyBase + MoneyAdd) of
                                        false ->
                                            lib_send:send_prompt_msg(PS, ?PM_YB_LIMIT);
                                        true ->
                                            case catch gen_server:call(?RELATION_PROCESS, {'modify_sworn_prefix', PS, Choice, Prefix1, MoneyBase, MoneyAdd}) of
                                                {'EXIT', Reason} ->
                                                    ?ERROR_MSG("pp_relation:handle(14055(), exit for reason: ~w~n", [Reason]),
                                                    ?ASSERT(false, Reason),
                                                    lib_send:send_prompt_msg(PS, ?PM_MK_FAIL_SERVER_BUSY);
                                                _Any -> skip
                                            end
                                    end
                            end
                    end
            end
    end;

%% %% 队员领取称号  队长修改称号时，队员修改也通过此协议修改
handle(14057, PS, [Suffix]) ->
    Suffix1 = list_to_binary(Suffix),
    case is_sworn_name_valid1(Suffix1) of
        {false, len_error} ->
            lib_send:send_prompt_msg(PS, ?PM_SWORN_NAME_LEN_ERROR);
        {false, char_illegal} ->
            lib_send:send_prompt_msg(PS, ?PM_SWORN_NAME_CHAR_ILLEGEL);
        true ->
            case ply_relation:has_sworn(player:id(PS)) of
                false -> 
                    lib_send:send_prompt_msg(PS, ?PM_RELA_NO_SWORN);
                true ->
                    RelaInfo = ply_relation:get_rela_info(player:id(PS)),
                    Sworn = lib_relation:get_sworn_relation(RelaInfo#relation_info.sworn_id),
                    case Sworn =:= null of
                        true -> lib_send:send_prompt_msg(PS, ?PM_RELA_NO_SWORN);
                        false ->
                            case lists:member(Suffix, Sworn#sworn.suffix_list) of
                                true ->
                                    {ok, BinData} = pt_14:write(14057, [?RES_FAIL]),
                                    lib_send:send_to_sock(PS, BinData);
                                false ->
                                    case RelaInfo#relation_info.free_modify_suf_count =:= 1 of
                                        true -> 
                                            RelaInfoLeader = ply_relation:get_rela_info(Sworn#sworn.id),
                                            case RelaInfoLeader#relation_info.free_modify_pre_count =:= 1 of
                                                true -> lib_send:send_prompt_msg(PS, ?PM_RELA_WAIT_LEADER_SURE);
                                                false ->
                                                    gen_server:cast(?RELATION_PROCESS, {'modify_sworn_suffix', PS, Suffix1})
                                            end;
                                        false -> 
                                            lib_send:send_prompt_msg(PS, ?PM_RELA_NO_MODIFY_COUNT)
                                    end
                            end
                    end
            end
    end;


handle(14058, PS, [Param]) ->
    RelaInfo = ply_relation:get_rela_info(player:id(PS)),
    Sworn = lib_relation:get_sworn_relation(RelaInfo#relation_info.sworn_id),
    {Type, PrefixOnly, PreFreeCount, SufFreeCount, Prefix, Suffix, SwornId} = 
        case RelaInfo#relation_info.sworn_id =:= ?INVALID_ID orelse Sworn =:= null of
            true ->
                {0, 0, 0, 0, <<>>, <<>>, ?INVALID_ID};
            false ->
                {Sworn#sworn.type, Sworn#sworn.prefix_only, RelaInfo#relation_info.free_modify_pre_count, RelaInfo#relation_info.free_modify_suf_count, 
                Sworn#sworn.prefix, RelaInfo#relation_info.sworn_suffix, RelaInfo#relation_info.sworn_id}
        end,
    {ok, BinData} = pt_14:write(14058, [Type, PrefixOnly, PreFreeCount, SufFreeCount, Prefix, Suffix, Param, SwornId]),
    lib_send:send_to_sock(PS, BinData);


handle(14059, PS, _) ->
    case player:is_in_team(PS) of
        false -> skip;
        true ->
            RelaInfo = ply_relation:get_rela_info(player:id(PS)),
            case lib_relation:get_sworn_relation(RelaInfo#relation_info.sworn_id) of
                null -> skip;
                _Sworn ->
                    F = fun(Id) ->
                        Rela = ply_relation:get_rela_info(Id),
                        case Rela#relation_info.sworn_id =:= RelaInfo#relation_info.sworn_id of
                            false -> skip;
                            true -> 
                                {ok, BinData} = pt_14:write(14059, []),
                                lib_send:send_to_uid(Id, BinData)
                        end
                    end,
                    [F(X) || X <- mod_team:get_all_member_id_list(mod_team:get_team_info(player:get_team_id(PS))) -- [player:id(PS)]]
            end
    end;

%% GoodsList --> [{GoodsId, Count}, ...]
handle(14100, PS, [PlayerId, GoodsList]) ->
    case ply_relation:give_flower(PS, PlayerId, GoodsList) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        _ -> skip
    end;        

%% 赠送道具 --> [{GoodsId, Count}, ...]
handle(?PT_GIVE_GIFTS, PS, [PlayerId, GoodsList]) ->
    case ply_relation:give_gifts(PS, PlayerId, GoodsList) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        _ -> skip
    end;        


handle(_Cmd, _PS, _Data) ->
    ?DEBUG_MSG("pp_relation no match", []),
    {error, "pp_relation no match"}.


%% -----------------------------------Local fun---------------------------------------------------------------


parse_msg_array(<<Len:16, Bin:Len/binary-unit:8, _/binary>>) when Len =< ?RELA_MSG_LENGTH ->
    {true, <<Len:16, Bin:Len/binary-unit:8>>};
parse_msg_array(_) -> {false, <<>>}.


%%组装好友列表
% [Id PlayerId Online Lv Race Faction Sex Name, Intimacy]
pack_relation_list(PlayerId, R) when is_record(R, relation)->
    FId = 
        case R#relation.idA =:= PlayerId of
            true -> R#relation.idB;
            false -> R#relation.idA
        end,

    {Id, Online, Lv, Race, Faction, Sex, BattlePower, Name, Intimacy} =
        case player:get_PS(FId) of
            null ->
                case ply_tmplogout_cache:get_tmplogout_PS(FId) of
                    null ->
                        case mod_offline_data:get_offline_role_brief(FId) of
                            null -> {R#relation.id, 0, 0, 0, 0, 0, 0, <<>>, 0};
                            Brief -> 
                                {   
                                    R#relation.id, 0, Brief#offline_role_brief.lv, Brief#offline_role_brief.race, Brief#offline_role_brief.faction, 
                                    Brief#offline_role_brief.sex, Brief#offline_role_brief.battle_power, Brief#offline_role_brief.name, R#relation.intimacy
                                }
                        end;
                    TPS ->
                        {
                            R#relation.id, 0, player:get_lv(TPS), player:get_race(TPS), player:get_faction(TPS), player:get_sex(TPS), ply_attr:get_battle_power(TPS), 
                            player:get_name(TPS), R#relation.intimacy
                        }
                end;
            PS ->
                {
                    R#relation.id, 1, player:get_lv(PS), player:get_race(PS), player:get_faction(PS), player:get_sex(PS), ply_attr:get_battle_power(PS), player:get_name(PS),
                    R#relation.intimacy
                }
        end,

    [Id, FId, Online, Lv, Race, Faction, Sex, BattlePower, Name, Intimacy].


%% 检查队名长度是否合法
%% @return: true | {false, Reason}
is_sworn_name_valid(Name) ->
    case asn1rt:utf8_binary_to_list(Name) of
        {ok, CharList} ->
            Len = util:string_width(CharList),
            case Len =< (?RELA_MAX_PREFIX_LEN*2) andalso Len >= (?RELA_MIN_PREFIX_LEN) of
                true ->
                    case util:has_illegal_char(CharList) of % 是否包含非法字符（如：空格，反斜杠）
                        true ->
                            {false, char_illegal};
                        false ->
                            true
                    end;
               false ->
                    {false, len_error}
           end;
        {error, _Reason} ->
           % 非法字符
            {false, char_illegal}
   end.

is_sworn_name_valid1(Name) ->
    case asn1rt:utf8_binary_to_list(Name) of
        {ok, CharList} ->
            Len = util:string_width(CharList),
            case Len =< (?RELA_MAX_PREFIX_LEN1*2) andalso Len >= (?RELA_MIN_PREFIX_LEN) of
                true ->
                    case util:has_illegal_char(CharList) of % 是否包含非法字符（如：空格，反斜杠）
                        true ->
                            {false, char_illegal};
                        false ->
                            true
                    end;
               false ->
                    {false, len_error}
           end;
        {error, _Reason} ->
           % 非法字符
            {false, char_illegal}
   end.

is_sworn_type_valid(Type) ->
    lists:member(Type, [?RELA_SWORN_TYPE_COM, ?RELA_SWORN_TYPE_HIGH]).