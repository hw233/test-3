%%%-----------------------------------
%%% @Module  : lib_chat
%%% @Author  :
%%% @Email   :
%%% @Created : 2011.06.11
%%% @Description: 聊天
%%%-----------------------------------
-module(lib_chat).
% -export([send_sys_msg_one/2, chat_in_blacklist/2, broadcast_sys_msg/1,
% 		 notify_cli_chat_banned/2, show_info_in_channel_for_one/3, send_guild_info_to_someone/2,
%          send_to_all_rolling/2, get_end_ban_chat_time/1,
%          send_to_all_flash/2,
%          send_sys_msg_one_id/2
%          ]).
-export([
    send_error_state/3,
    sys_msg/1,
    use_horn/2,
    get_chat_cd/2,
    set_chat_cd/2,
    parse_msg_array/1,
    check_msg_length/1,
    in_chat_cd/3,
    get_identify/1,
    login_chat/2,
    % logout_chat/1,
    ban_chat/3,
    tmp_logout_chat/1,
    final_logout/1,
	cross_chat_data/4
    ]).

-compile(export_all).

-include("offline_data.hrl").
-include("common.hrl").
-include("record.hrl").
-include("protocol/pt_11.hrl").
-include("debug.hrl").
-include("player.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("log.hrl").
-include("priv.hrl").

-define(MSG_LENGTH, 300).
-define(ID_LENGTH, 1).
-define(WORLD_CD, 30).
-define(CHAT_CD(Cmd), {chat, cd, Cmd}).

%% 判断是否可以说话
check_chat_permission(PS) ->
	check_recharge_chat(PS) orelse check_bing_phone().


check_bing_phone() ->
	case get(?BAN_PHONE) of
		2 ->%% 绑定了未被禁言的手机号，可以说话
			?true;
		_ ->
			?false
	end.


%% 判断是否已首充，才能说话
check_chat_first_recharge(PS) ->
	PS#player_status.first_recharge_reward_state > 0.

%% 判断充值金额是否满足发言要求
check_recharge_chat(PS) ->
	Ratio = player:recharge_ratio(),
	PS#player_status.yuanbao_acc >= (50 * Ratio).


%% check_msg_length(Msg::list()) -> true | false
check_msg_length(Msg) when is_list(Msg)->
    msg_length(Msg, 0) =< ?MSG_LENGTH;
check_msg_length(_) -> false.


msg_length([], Length) -> Length;
msg_length([[Id, Msg] | Left], Length) ->
    IdLen = ?BIN_PRED(Id > 0, ?ID_LENGTH, 0),
    MsgLen = length(Msg),
    msg_length(Left, (Length + IdLen + MsgLen)).


%%检查消息长度和修正消息格式
% parse_msg_array(<<Len:16, Bin/binary>>) ->
%     parse_msg_array(Len, Bin, <<Len:16>>, 0).

% parse_msg_array(0, _, Msg, CountLen) ->
%     {CountLen =< ?MSG_LENGTH, Msg};
% parse_msg_array(Count, <<Id:32, Len:16, Bin:Len/binary-unit:8, LeftBin/binary>>, Msg, CountLen) ->
%     NewCountLen = ?BIN_PRED(Id > 0, ?ID_LENGTH, 0) + Len + CountLen,
%     parse_msg_array(Count - 1, LeftBin,
%         <<Msg/binary, Id:32, Len:16, Bin:Len/binary-unit:8>>, NewCountLen).
parse_msg_array(<<Len:16, Bin:Len/binary-unit:8, _/binary>>) when Len =< ?MSG_LENGTH ->
    {true, <<Len:16, Bin:Len/binary-unit:8>>};
parse_msg_array(_) -> {false, <<>>}.

send_error_state(PlayerId, Cmd, State) when is_integer(PlayerId) ->
     {ok, BinData} = pt_11:write(11100, [Cmd, State]),
     lib_send:send_to_uid(PlayerId, BinData);

send_error_state(Status, Cmd, State) ->
     {ok, BinData} = pt_11:write(11100, [Cmd, State]),
     lib_send:send_to_sock(Status#player_status.socket, BinData).


%%系统信息
sys_msg(Msg) when is_list(Msg) ->
    sys_msg(list_to_binary(Msg));
sys_msg(Msg) when is_binary(Msg) ->
    {ok, BinData} = pt_11:write(11004, [Msg]),
    lib_send:send_to_all(BinData);
sys_msg(_) -> ?ASSERT(false).


-define(BOND_HORN, 60021).
% -define(UNBOND_HORN, 60022).
%% @return : true | {false, ErrCode}
use_horn(Status, Num) ->
    RoleId = player:id(Status),
    case mod_inv:get_goods_count_in_bag_by_no(RoleId, ?BOND_HORN) >= Num of
        true ->
            case mod_inv:destroy_goods_WNC(RoleId, [{?BOND_HORN, Num}], [?LOG_GOODS, "use"]) of
                true -> 
                    true;
                false -> {false, ?PM_UNKNOWN_ERR}
            end;
        false -> {false, ?PM_GOODS_NOT_EXISTS}
            % case mod_inv:get_goods_count_in_bag_by_no(RoleId, ?UNBOND_HORN) >= Num of
            %     true ->
            %         case mod_inv:destroy_goods_WNC(RoleId, [{?UNBOND_HORN, Num}], [?LOG_GOODS, "use"]) of
            %             true -> true;
            %             false -> {false, ?PM_UNKNOWN_ERR}
            %         end;
            %     false -> {false, ?PM_GOODS_NOT_EXISTS}
            % end
    end.


in_chat_cd(Cmd, TimeStamp, Status) ->
    case ply_priv:get_priv_lv(Status) >= ?PRIV_GM of
        true -> false;
        false ->
            case get_chat_cd(Cmd, TimeStamp) of
                null -> false;
                Time -> Time < ?WORLD_CD
            end
    end.


get_chat_cd(Cmd, TimeStamp) ->
    case get(?CHAT_CD(Cmd)) of
        undefined -> null;
        Time -> TimeStamp - Time
    end.


set_chat_cd(Cmd, TimeStamp) ->
    put(?CHAT_CD(Cmd), TimeStamp).


get_player_info(Status, RoleId) ->
	 case player:is_online(RoleId) of
        true -> gen_server:cast(player:get_pid(RoleId), {'apply_cast', pp_chat, notify_follower_chat_info, [RoleId, player:id(Status)]});
        false ->
            case mod_offline_data:get_offline_role_brief(RoleId) of
                null -> lib_chat:send_error_state(Status, 11009, 1);
                Rd when is_record(Rd, offline_role_brief) ->
                    {ok, BinData} = pt_11:write(11009, [RoleId, Rd#offline_role_brief.race, Rd#offline_role_brief.sex,
                        Rd#offline_role_brief.lv, Rd#offline_role_brief.name, Rd#offline_role_brief.faction,
                        Rd#offline_role_brief.vip_lv, Rd#offline_role_brief.battle_power, 0
                        ,ply_guild:get_guild_name(Rd#offline_role_brief.id), player:get_peak_lv(RoleId)
                        ]),
                    lib_send:send_to_sock(Status, BinData)
            end
    end.

%%跨服聊天获取人物数据
get_player_info2(StoreId, ServerId,PlayerId) ->
	case player:get_PS(StoreId) of
		FriStatus when is_record(FriStatus, player_status) ->
			{ok, BinData} = 
				pt_11:write(11009, [StoreId, player:get_race(FriStatus),
									player:get_sex(FriStatus), player:get_lv(FriStatus), player:get_name(FriStatus), 
									player:get_faction(FriStatus), player:get_vip_lv(FriStatus), ply_attr:get_battle_power(FriStatus), 
									?BIN_PRED(player:is_chat_banned(StoreId), 1, 0)
									,ply_guild:get_guild_name(StoreId), player:get_peak_lv(StoreId)]),
			sm_cross_server:rpc_cast(ServerId,lib_chat, cross_chat_data, [PlayerId, BinData,StoreId,1]);
%% 															 BinData;
		_ ->
            case mod_offline_data:get_offline_role_brief(StoreId) of
                null -> sm_cross_server:rpc_cast(ServerId,lib_chat, send_error_state, [PlayerId, 11009,1]);
                Rd when is_record(Rd, offline_role_brief) ->
                    {ok, BinData} = pt_11:write(11009, [StoreId, Rd#offline_role_brief.race, Rd#offline_role_brief.sex,
                        Rd#offline_role_brief.lv, Rd#offline_role_brief.name, Rd#offline_role_brief.faction,
                        Rd#offline_role_brief.vip_lv, Rd#offline_role_brief.battle_power, 0
                        ,ply_guild:get_guild_name(Rd#offline_role_brief.id), player:get_peak_lv(StoreId)
                        ]),
                    sm_cross_server:rpc_cast(ServerId,lib_chat, cross_chat_data, [PlayerId, BinData,StoreId,1])
            end
    end.


cross_chat_data(PlayerId, BinData, StoreId, Type) ->

	ets:insert(?ETS_CROSS_CHAT_DATA, {{StoreId,Type}, BinData, util:unixtime()}),
	
	lib_send:send_to_uid(PlayerId,BinData).



login_chat(RoleId, role_in_cache) ->
    case ets:lookup(?ETS_WORLD_CHAT_CD_TMP, RoleId) of
        [] -> skip;
        [{_, Stamp}] ->
            put(?CHAT_CD(?PT_WORLD), Stamp),
            ets:delete(?ETS_WORLD_CHAT_CD_TMP, RoleId)
    end,
    case ets:lookup(?ETS_BANNED_CHAT_TMP, RoleId) of
        [] -> skip;
        [{_, {EndTime, Reason}}] ->
            put(?BAN_CHAT, {EndTime, tool:to_binary(Reason)}),
            ets:delete(?ETS_BANNED_CHAT_TMP, RoleId)
    end;

login_chat(Id, _) ->
    % 不加载聊天CD信息
    % case db:select_one(player, "world_chat_stamp", [{id, Id}]) of
    %     Stamp when is_integer(Stamp) -> put(?CHAT_CD(?PT_WORLD), Stamp);
    %     Ohter ->
    %         ?ASSERT(false),
    %         ?ERROR_MSG("module : chat, method : login_chat, db error = ~p~n", [Ohter])
    % end,
    case db:select_row(t_ban_chat, "end_time, reason", [{role_id, Id}]) of
        [] -> erase(?BAN_CHAT);
        [0, _] -> erase(?BAN_CHAT);
        [1, Reason] -> put(?BAN_CHAT, {1, tool:to_binary(Reason)});
        [EndTime, Reason] ->
            case EndTime > util:unixtime() of
                true -> put(?BAN_CHAT, {EndTime, tool:to_binary(Reason)});
                false -> erase(?BAN_CHAT)
            end;
        Other1 ->
            ?ASSERT(false),
            ?ERROR_MSG("module : chat, method : login_chat_ban, db error = ~p~n", [Other1])
    end.


% logout_chat(Id) ->
%     case get(?CHAT_CD(?PT_WORLD)) of
%         undefined -> skip;
%         0 -> skip;
%         Stamp ->
%             % db:update(player, [{world_chat_stamp, Stamp}], [{id, Id}])
%             mod_lgout_svr:common_handle(Id, db, update, [player, [{world_chat_stamp, Stamp}], [{id, Id}]])
%     end.

tmp_logout_chat(RoleId) ->
    case get(?CHAT_CD(?PT_WORLD)) of
        undefined -> skip;
        0 -> skip;
        Stamp -> ets:insert(?ETS_WORLD_CHAT_CD_TMP, {RoleId, Stamp})
    end,
    case get(?BAN_CHAT) of
        undefined -> skip;
        Rd -> ets:insert(?ETS_BANNED_CHAT_TMP, {RoleId, Rd})
    end.

final_logout(RoleId) ->
    ets:delete(?ETS_WORLD_CHAT_CD_TMP, RoleId),
    ets:delete(?ETS_BANNED_CHAT_TMP, RoleId).


get_identify(Status) ->
    lib_vip:lv(Status).


ban_chat(Time, Reason, Status) ->
    {ok, BinData} = pt_11:write(11010, [Time, Reason]),
    lib_send:send_to_sock(Status, BinData).


chat_filter(RoleId, NewMsg) ->
	ok.
%% 	try
%% 		do_chat_filter(RoleId, NewMsg)
%% 	catch 
%% 		Error:Reason ->
%% 			?ERROR_MSG("{Error, Reason, erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
%% 			ok
%% 	end.


%% 短时间内发4次以上内容雷同且字数较长的屏蔽聊天, 设置权重，发得越多死的越快
do_chat_filter(RoleId, <<_:16,NewMsg/binary>>) when erlang:byte_size(NewMsg) > 40 ->
	%% 检查敏感词
	Key = chat_auto,
	Ts = util:unixtime(),
	case erlang:get(Key) of
		{MsgList, CheckTs} when erlang:is_list(MsgList) andalso CheckTs - Ts < 1200 ->% 一个小时清空一次
			Pred = fun({OldMsg, _Count}) ->
						   check_msg(NewMsg, OldMsg)
				   end,
			MsgList2 = 
				case lists:filter(Pred, MsgList) of
					[] ->
						[{NewMsg, 1}|MsgList];
					[{OldMsg, Count}|_] ->
						Count2 = Count + 1,
						case Count2 >= 3 andalso util:rand(3, 6) =< Count2 of
							?true ->
								Reason = "系统检测到疑似喊话器发广告",
%% 								Reason = case byte_size(OldMsg) > 100 of
%% 											 ?true ->
%% 												 binary:part(OldMsg, 0, 100) ;
%% 											 ?false ->
%% 												 OldMsg
%% 										 end,
								try
									?ERROR_MSG("check chat : ~ts~n", [OldMsg]),
									case config:get_chat_monitor_switch() of
										true ->
											Name = player:get_name(RoleId),
											gen_server:cast(mod_udp, {'chat_monitor', <<RoleId, Name/binary, <<"说了 ">>/binary, NewMsg/binary>>, <<"系统禁言 ">>});
										false -> 
											skip
									end
								catch
									E:R ->
										?ERROR_MSG("{E,R,erlang:get_stacktrace()} : ~p~n", [{E,R,erlang:get_stacktrace()}])
								end,
								player:ban_chat(RoleId, -1, Reason);
							?false ->
								ok
						end,
						[{NewMsg, Count2}|lists:delete({OldMsg, Count}, MsgList)]
				end,
			erlang:put(Key, {MsgList2, CheckTs});
		_ ->
			erlang:put(Key, {[{NewMsg, 1}], Ts})
	end,
	
	case words_verify(NewMsg) of
		?true ->
			ok;
		?false ->
			%% 敏感词
			error
	end;


do_chat_filter(RoleId, _) ->
	ok.

check_msg(NewMsg, NewMsg) ->
	true;
	
check_msg(NewMsg, NewMsgOld) ->
	Size = erlang:byte_size(NewMsg),
	SizeOld = erlang:byte_size(NewMsgOld),
	%% 十分之一长度拆分
	CutLen1 = Size div 10, 
	CutLen2 = SizeOld div 10, 
	List1 = split_list(NewMsg, CutLen1),
	List2 = split_list(NewMsgOld, CutLen2),
	%% 遍历较短的一条消息
	N = erlang:min(length(List1), length(List2)),
	Fun = fun(Idx, Acc) ->
				  case lists:nth(Idx, List1) == lists:nth(Idx, List2) of
					  ?true ->
						  %% 中标,数量加一
						  Acc+1;
					  ?false ->
						  Acc
				  end
		  end,
	%% 			io:format("N : ~p~n", [{lists:seq(1, N),N,CutLen1,List1}]),
	CompareCount = lists:foldl(Fun, 0, lists:seq(1, N)),
	BadCount = util:floor(N * 8 / 10),
	CompareCount >= BadCount.

%% 拆分
split_list(Msg, CutLen) ->
	split_list(Msg, CutLen, []).

split_list(<<>>, _CutLen, Acc) ->
	lists:reverse(Acc);	

split_list(Msg, CutLen, Acc) ->
	case Msg of
		<<MsgData:CutLen/binary, Tail/binary>> ->
%% 			io:format("{MsgData, CutLen, Tail} : ~p~n", [{MsgData, CutLen, Tail}]),
			split_list(Tail, CutLen, [MsgData|Acc]);
		_ ->
			[Msg|Acc]
	end.

%% 敏感词处理
words_filter(Words_for_filter) -> 
%% 	Words_List = data_words:get_words_verlist(),
	Words_List = word_list(),
    
	binary:bin_to_list(
        lists:foldl(fun(Kword, Word)->
                           re:replace(Word, Kword, "*", [global, caseless, {return, binary}])
                   end, Words_for_filter, Words_List)).

%% 是否含有敏感词
words_verify(Words_for_ver) ->
	Words_List = word_list(),
%% 	io:format("~n~n~n~n~n~p~n", [{Words_for_ver, Words_List}]),
    try
        lists:foldl(
        fun(Word,Acc) ->
%%             io:format("fuck: ~p,~p, ~p~n", [Words_for_ver, Word, Acc+1]),
            case re:run(Words_for_ver, Word, [unicode]) of
                nomatch -> 
                    Acc+1;
                _->
                    throw(false)
            end
        end, 0,Words_List),
%% 		re:run(Subject, RE, Options)
        true
    catch
        throw:false ->
            false
    end.

word_list() ->
	[<<"６">>,<<"５">>,<<"２">>,<<"８">>,<<"７">>,<<"６８４">>,<<"７６５３">>,<<"原汁原味">>, <<"无限元宝">>, <<"加群">>, <<"q群">>, <<"Q群">>, <<"加羊君">>,<<"来玩就送">>,<<"来就送">>,<<"私服">>,<<"变态">>,<<"百款安卓">>,<<"百款">>,<<"加ios">>,<<"加裙">>,<<"绝对爽">>,<<"私.服">>,<<"对爽">>,<<"玩就送">>,<<"４８７６５３７">>,<<"6487653">>].

%% 发广告特定处理, 初级软件喊话特征，设定了定时喊话，定性时间间隔，连续喊话10-20次以上，且内容长度较长，不需要完全一样，百分之八十内容相同，长度误差在10个字节以内，
%% kill_fuck_ad(RoleId, Msg) ->
%% 	Key = 'kill_fuck_ad',
%% 	Unixtime = util:unixtime(),
%% 	case erlang:get(Key) of
%% 		?undefined ->
%% 			Val = [{Unixtime, Msg}],
%% 			erlang:put(Key, Val);
%% 		MsgList ->
%% 			Count = 20,
%% 			NewMsgList = lists:sublist([{Unixtime, Msg}|MsgList], Count),
%% 			NewMsgList5 = lists:sublist(NewMsgList, 5),
%% 			NewMsgList10 = lists:sublist(NewMsgList, 10),
%% 			%% 长度在十几个字以上，连续5次长度误差小，大部分内容（百分之八十）雷同，
%% 			Pred = fun({Ts, MsgData}) ->
%% 						   ok
%% 				   end,
%% 			lists:foldl(Pred, {SecsDiff, }, MsgList2),
%% 			ok
%% 	end.






%%发聊天系统信息
%% send_sys_msg(Socket, Msg) ->
%%     {ok, BinData} = pt_11:write(11004, Msg),
%%     lib_send:send_to_scene(Socket, BinData).

% %%发送系统信息给某个玩家
% send_sys_msg_one(Socket, Msg) ->
%     {ok, BinData} = pt_11:write(11004, Msg),
%     lib_send:send_one(Socket, BinData).

% %%私聊返回被加黑名单通知
% chat_in_blacklist(Id, Sid) ->
%     {ok, BinData} = pt_11:write(11007, Id),
%     lib_send:send_to_sid(Sid, BinData).

% %%发聊天公告
% broadcast_sys_msg(Content) ->
% 	{ok, BinData} = pt_11:write(11010, [Content]),
% 	lib_send:send_to_all(BinData).

% %% 通知客户端：被禁言了
% %% @para: LeftTime => 被禁言的剩余时间（秒）
% notify_cli_chat_banned(Id, LeftTime) ->
% 	{ok, BinData} = pt_11:write(11011, [LeftTime]),
% 	lib_send:send_to_uid(Id, BinData).

% %%选择频道信息显示
% %%@Id : 接收信息的玩家的ID
% %%@Channel : 0:世界 1:附近 2:帮派 3:队伍 4:喊话
% show_info_in_channel_for_one(Id, Channel, Msg) ->
% 	IntChannel = tool:to_integer(Channel),
% 	{ok, BinData} = pt_11:write(11015, [IntChannel, Msg]),
% 	lib_send:send_to_uid(Id, BinData).

% %%发送帮派信息给某些成员
% %%@IdList: 要接收信息的玩家ID列表
% %%@Msg: 发送的消息(list or binary) 	格式:
% %%  int32:    ID
% %% 	String:   ID>0?(玩家名or帮会名):文本内容
% %% 	int8:     ID>0?类别:颜色     (类别 : 0->玩家,1->帮派)
% send_guild_info_to_someone(IdList, Msg)
% 	when is_list(Msg) orelse is_binary(Msg) ->
% 	{ok, BinData} = pt_11:write(11014, [[Msg]]),
%     F = fun(PlayerId) -> lib_send:send_to_uid(PlayerId, BinData) end,
% 	[F(X) || X <- IdList, X /= []].

% %% desc: 全服通知(滚动条) ->
% send_to_all_rolling(Type, NameList) ->
%     {ok, Bin} = pt_11:write(11017, [Type, NameList]),
%     lib_send:send_to_all_from_world_node(Bin).

% %% desc: 全服通知(闪现) ->
% send_to_all_flash(Type, NameList) ->
% 	{ok, Bin} = pt_11:write(11018, [Type,NameList]),
% 	lib_send:send_to_all_from_world_node(Bin).


% %% 取得结束禁言时间
% get_end_ban_chat_time(Id) ->
% 	DbEndBanTime = case db:select_row(ban_chat, "end_ban_time", [{player_id,Id}]) of
%         [] -> 0;
%         [Time] -> Time
%     end,
% 	NowTimeStamp = util:unixtime(),
% 	if
% 		DbEndBanTime > NowTimeStamp ->
% 			DbEndBanTime;
% 		true ->
% 			lib_common:actin_new_proc(db, delete, [ban_chat, [{player_id,Id}]]),
% 			0
% 	end.

% send_sys_msg_one_id(Id, Msg) ->
%     {ok, BinData} = pt_11:write(11004, Msg),
%     lib_send:send_to_uid(Id, BinData).

