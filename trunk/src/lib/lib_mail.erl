%%%-----------------------------------
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2013.11
%%% @Description: 邮件
%%%-----------------------------------

-module(lib_mail).

-include("common.hrl").
-include("record.hrl").
-include("mail.hrl").
-include("ets_name.hrl").
-include("prompt_msg_code.hrl").
-include("goods.hrl").
-include("record/goods_record.hrl").
-include("log.hrl").

-export([
    send_sys_mail/6
    ,send_sys_mail/5
    ,batch_send_sys_mail/5
    ,send_pri_mail/5
    ,notify_del_mail/2
    ,notify_new_mail/7
    ,spawn_del_mail/2
    ,spawn_del_mail_list/2
    ,login/1
    ,start_mail_timer/1
    ,get_mail_list_info/2
    ,set_mail_state_read/1
    ,get_mail_attach/3
    ,batch_send_sys_mail_time/4
    ]).
-compile(export_all).

%% ==========================================================
%% interface faction
%% ==========================================================

%% 系统发邮件
%% @spec send_sys_mail(RecvId::integer(), Title::binary(), Content::binary()
%%                     GoodsList::[{goodsNo, Num}]) -> 
%%       true | {false, ErrCode::integer()}

send_sys_mail(tranfer_goods, RecvId, Title, Content, GoodsObjectList, _LogInfo) ->
    case check_sys_mail(RecvId, Title, Content) of
        true -> 
            case GoodsObjectList =:= [] of
                true -> 
                    send_mail(RecvId, Title, Content, ?MAIL_SYS, [], ?MAIL_SYS_ID, ?MAIL_SYS_NAME);
                false ->
                    GoodsList = tranfer_goods_to_mail(RecvId, GoodsObjectList),
                    AttachList = split_attach_by_limit_count(GoodsList),
                    [send_mail(RecvId, Title, Content, ?MAIL_SYS, Attach, ?MAIL_SYS_ID, ?MAIL_SYS_NAME) || Attach <- AttachList]
            end,
            true;
        {false, ErrCode} -> {false, ErrCode}
    end.

send_sys_mail(RecvId, Title, Content, GoodsList, LogInfo) -> 
    case check_sys_mail(RecvId, Title, Content) of
        true -> 
            % AttachList = split_attach_by_limit_count(TmpAttachList),
            case GoodsList =:= [] of
                true -> 
                    send_mail(RecvId, Title, Content, ?MAIL_SYS, [], ?MAIL_SYS_ID, ?MAIL_SYS_NAME);
                false -> 
                    TmpAttachList = create_goods_to_role_mail(RecvId, GoodsList),
                    AttachList = split_attach_by_limit_count(TmpAttachList),
                    [send_mail(RecvId, Title, Content, ?MAIL_SYS, Attach, ?MAIL_SYS_ID, ?MAIL_SYS_NAME) || Attach <- AttachList],
                    ?DEBUG_MSG("LogInfo=~p",[LogInfo]),
                    pack_produce_goods_log(RecvId, LogInfo, GoodsList)
            end,
            true;
        {false, ErrCode} -> {false, ErrCode}
    end.

batch_send_sys_mail_time(Title, Content, GoodsList, LogInfo) ->
    case check_batch_send_all_mail(Title, Content, GoodsList) of
        true ->
            F = fun() ->
                MysqlInfo = lists:concat(["select id from player where last_login_time >= ",  util:unixtime() - 604800]),
                case db:select_all(player, MysqlInfo) of
                    IdList when is_list(IdList) ->
                        ErrList = admin_batch_send_sys_mail(lists:flatten(IdList), Title, Content, GoodsList, [], LogInfo),
                        ?BIN_PRED(ErrList =:= [], skip,
                            ?ERROR_MSG("admin send all mail error, timestamp = ~p, fail_list = ~p~n", [util:unixtime(), ErrList]));
                    Err ->
                        ?ERROR_MSG("admin send all mail error, timestamp = ~p, db_error = ~p~n", [util:unixtime(), Err])
                end
                end,
            spawn(F),
            {ok, []};
        {false, ErrCode} ->
            {fail, ErrCode}
    end.

%% 系统群发邮件
%% @return 
% 全服发送
batch_send_sys_mail([], Title, Content, GoodsList, LogInfo) ->
    case check_batch_send_all_mail(Title, Content, GoodsList) of
        true ->
            F = fun() ->
                case db:select_all(player, "id", []) of
                    IdList when is_list(IdList) ->
                        ErrList = admin_batch_send_sys_mail(lists:flatten(IdList), Title, Content, GoodsList, [], LogInfo),
                        ?BIN_PRED(ErrList =:= [], skip, 
                            ?ERROR_MSG("admin send all mail error, timestamp = ~p, fail_list = ~p~n", [util:unixtime(), ErrList]));
                    Err ->
                        ?ERROR_MSG("admin send all mail error, timestamp = ~p, db_error = ~p~n", [util:unixtime(), Err])
                end
            end,
            spawn(F),
            {ok, []};
        {false, ErrCode} -> 
            {fail, ErrCode}
    end;

% 指定ID发送
batch_send_sys_mail(IdList, Title, Content, GoodsList, LogInfo) ->
    case check_batch_send_mail(IdList, Title, Content, GoodsList) of
        true -> 
            F = fun() ->
                ErrList = admin_batch_send_sys_mail(IdList, Title, Content, GoodsList, [], LogInfo),
                ?BIN_PRED(ErrList =:= [], skip, ?ERROR_MSG("admin send assign mail error, timestamp = ~p, fail_list = ~p~n", [util:unixtime(), ErrList]))
            end,
            spawn(F),
            {ok, []};
        {false, ErrCode} -> 
            {fail, ErrCode}
    end.


admin_batch_send_sys_mail([], _, _, _, ErrList, _) -> ErrList;

admin_batch_send_sys_mail([RoleId | Left], Title, Content, [], ErrList, LogInfo) ->
    case catch admin_send_mail(RoleId, Title, Content, ?MAIL_SYS, [], ?MAIL_SYS_ID, ?MAIL_SYS_NAME, LogInfo) of
        true -> admin_batch_send_sys_mail(Left, Title, Content, [], ErrList, LogInfo);
        _ -> admin_batch_send_sys_mail(Left, Title, Content, [], [RoleId | ErrList], LogInfo)
    end;
    
admin_batch_send_sys_mail([RoleId | Left], Title, Content, GoodsList, ErrList, LogInfo) ->
    TmpAttachList = create_goods_to_role_mail(RoleId, GoodsList),
    AttachList = split_attach_by_limit_count(TmpAttachList),
    ?LDS_TRACE("batch mail", [{TmpAttachList, AttachList}]),
    case catch [admin_send_mail(RoleId, Title, Content, ?MAIL_SYS, Attach, ?MAIL_SYS_ID, ?MAIL_SYS_NAME, LogInfo) || Attach <- AttachList] of
        Result when is_list(Result) -> 
            pack_produce_goods_log(RoleId, LogInfo, GoodsList),
            admin_batch_send_sys_mail(Left, Title, Content, GoodsList, ErrList, LogInfo);
        _ -> admin_batch_send_sys_mail(Left, Title, Content, GoodsList, [RoleId | ErrList], LogInfo)
    end.




%% 私人发邮件
%% @spec send_pri_mail(RecName::binary(), Title::binary(), Content::binary(), Type::integer(),
%%                     Status::#player_status{}) -> 
%%       true | {false, ErrCode::integer()}
send_pri_mail(RecName, Title, Content, Status, _LogInfo) -> 
    BinName = tool:to_binary(player:get_name(Status)),
    case check_priv_mail(RecName, Title, Content, BinName) of
        {true, RecvId} -> 
            send_mail(RecvId, Title, Content, ?MAIL_PRI, [], player:id(Status), BinName);
        {false, ErrCode} -> {false, ErrCode}
    end.


%% 通知邮件更新
%% return : void

notify_del_mail(RoleId, MailId) -> 
    {ok, BinData} = pt_19:write(19006, [MailId]),
    lib_send:send_to_uid(RoleId, BinData).

notify_new_mail(RoleId, MailId, Type, Title, Timestamp, Sec, HadAttach) ->
    {ok, BinData} = pt_19:write(19008, [MailId, Type, Title, Timestamp, Sec, HadAttach]),
    lib_send:send_to_uid(RoleId, BinData).

%% 通知删除邮件后客户端显示的候补显示邮件
notify_backup_mail(MailId) ->
    case get_mail(MailId) of
        Mail when is_record(Mail, mail) ->
            notify_backup_mail(Mail#mail.recv_id, Mail#mail.id, Mail#mail.type, Mail#mail.title, Mail#mail.timestamp,
                Mail#mail.timestamp + get_mail_lifetime(Mail#mail.type), ?BIN_PRED(Mail#mail.attach =:= [], 0, 1), Mail#mail.state);
        _ -> ?ASSERT(false, [MailId])
    end.
notify_backup_mail(RoleId, MailId, Type, Title, Timestamp, Sec, HadAttach, State) ->
    {ok, BinData} = pt_19:write(19010, [MailId, Type, Title, Timestamp, Sec, HadAttach, State]),
    lib_send:send_to_uid(RoleId, BinData).


%% 并发删除邮件
%% return : void
spawn_del_mail(MailId, RoleId) when is_integer(MailId) ->
    db:delete(RoleId, mail, [{id, MailId}]),
    {ok, BinData} = pt_19:write(19006, [MailId]),
    lib_send:send_to_uid(RoleId, BinData).

spawn_del_mail_list([], _) -> ok;    
spawn_del_mail_list([MailId | Left], RoleId) ->
    spawn_del_mail(MailId, RoleId),
    spawn_del_mail_list(Left, RoleId).

%% 邮件登录处理
login(Status) ->
    start_mail_timer(Status).


start_mail_timer(Status) ->
    check_expired_mail(player:id(Status), util:unixtime()),
    _Ref = erlang:start_timer(?MAIL_TIMING, self(), 'timer_mail').
    % add_mail_timer(Ref).


%% 取得邮件列表信息
%% @return : [{MailId, State, Title, LeftTime}] 
get_mail_list_info(RoleId, Type) -> 
    case get_mail_brief(RoleId, Type) of
        null -> [];
        Brief -> 
            MailIdList = [MailId || {MailId, _} <- Brief#mail_brief.mails],
            Num = get_mail_show_num(Type),
            % ShowIdList = 
            %     case length(MailIdList) > Num of
            %         true -> 
            %             {Left, _} = lists:split(Num, MailIdList),
            %             Left;
            %         false -> MailIdList
            %     end,
            F = fun(MailId, {DelList, DataList}) ->
                    case get_mail_brief_info(MailId) of
                        null -> {[MailId | DelList], DataList};
                        Data -> {DelList, [Data | DataList]}
                    end
                end,
            {DelList, TmpDataList} = lists:foldl(F, {[], []}, MailIdList),
            DataList = lists:reverse(TmpDataList),
            F1 = fun(Key, List) -> lists:keydelete(Key, 1, List) end,
            NewList = lists:foldl(F1, Brief#mail_brief.mails, DelList),
            update_mail_brief(Brief#mail_brief{mails = NewList}),
            ShowList = 
                case length(DataList) > Num of
                    true -> {Left, _} = lists:split(Num, DataList), Left;
                    false -> DataList
                end,

            % List = [get_mail_brief_info(MailId) || MailId <- ShowIdList],
            [Elm || Elm <- ShowList, is_tuple(Elm)]
    end.


%% @doc 根据邮件类型取得显示数量
get_mail_show_num(Type) ->
    case Type of
        ?MAIL_SYS -> ?MAIL_MAX_SYS_SHOW_COUNT;
        ?MAIL_PRI -> ?MAIL_MAX_PRI_SHOW_COUNT
    end.

%% 设置邮件已读
%% @retruen New #mail{}
set_mail_state_read(Mail) ->
    case Mail#mail.state =:= ?READ of
        true -> Mail;
        false -> 
            NewMail = Mail#mail{state = ?READ},
            update_mail(NewMail),
            NewMail
    end.


%% 收取附件物品,针对单个附件
%% @return : true | {false, ErrCode}
get_mail_attach(RoleId, MailId, GoodsId) ->
    case get_mail(MailId) of
        Mail when is_record(Mail, mail) andalso Mail#mail.recv_id =:= RoleId ->
            Attach = Mail#mail.attach,
            case lists:keymember(GoodsId, 1, Attach) of
                false -> {false, ?PM_ATTACH_NOT_EXISTS};
                true ->
					LogAttachList = 
						case lib_goods:get_goods_by_id(GoodsId) of
							null ->
								?ERROR_MSG("Error Mail Attach {RoleId, MailId, GoodsId} : ~p~n", [{RoleId, MailId, GoodsId}]),
								[];
							Goods ->
								[{lib_goods:get_no(Goods), lib_goods:get_count(Goods)}]
						end,
                    case give_attach_to_role_bag(Mail#mail.recv_id, [GoodsId]) of
                        true ->
                            NewAttach = lists:keydelete(GoodsId, 1, Attach),
                            case Mail#mail.state =:= ?READ of
                                true -> spawn_update_attach(Mail#mail{attach = NewAttach});
                                false ->
                                    NewMail = Mail#mail{state = ?READ, attach = NewAttach},
                                    update_mail(NewMail),
                                    spawn_update_attach(NewMail)
                            end,
							%% 领取了附件，记录日志
							erlang:spawn(fun() ->
												 log_get_attach(RoleId, LogAttachList)
%% 												 log_get_attach(RoleId, [lists:keyfind(GoodsId, 1, Attach)])
										 end),
                            true;
                        {false, ErrCode} -> {false, ErrCode}
                    end
            end;
        _ -> {false, ?PM_MAIL_NOT_EXISTS}
    end.


%% 收取单个邮件所有附件
%% @return : true | {false, ErrCode}
get_mail_all_attach(RoleId, MailId) ->
    case get_mail(MailId) of
        Mail when is_record(Mail, mail) andalso Mail#mail.recv_id =:= RoleId ->
			case [Id || {Id, _} <- Mail#mail.attach] of
				[] ->
					{false, ?PM_ATTACH_NOT_EXISTS};
				Attach ->
					Fun = fun(GoodsId, Acc) ->
								  case lib_goods:get_goods_by_id(GoodsId) of
									  null ->
										  ?ERROR_MSG("Error Mail Attach {RoleId, MailId, GoodsId} : ~p~n", [{RoleId, MailId, GoodsId}]),
										  Acc;
									  Goods ->
										  [{lib_goods:get_no(Goods), lib_goods:get_count(Goods)}|Acc]
								  end
						  end,
					LogAttachList = lists:foldl(Fun, [], Attach),
					case give_attach_to_role_bag(Mail#mail.recv_id, Attach) of
						true ->
							case Mail#mail.state =:= ?READ of
								true -> spawn_update_attach(Mail#mail{attach = []});
								false ->
									NewMail = Mail#mail{state = ?READ, attach = []},
									update_mail(NewMail),
									spawn_update_attach(NewMail)
							end,
							%% 领取了附件，记录日志
							erlang:spawn(fun() ->
												 log_get_attach(RoleId, LogAttachList)
										 %% 										 log_get_attach(RoleId, Attach)
										 end),
							true;
						{false, ErrCode} -> {false, ErrCode}
					end
			end;
        _ -> 
			{false, ?PM_MAIL_NOT_EXISTS}
    end.


log_get_attach(RoleId, AttachList0) ->
	AttachList = 
		lists:foldl(fun({GoodsNo, Count}, Acc) ->
							[{GoodsNo, Count}|Acc];
					   (GoodsId, Acc) ->
						%% 不能在这里找物品编号和数量了？有可能叠加到背包已有物品数量了，从外面传进来编号和数量?
						case lib_goods:get_goods_by_id(GoodsId) of
							null ->
								?ERROR_MSG("Error Mail Attach Goods Id : ~p~n", [{RoleId, GoodsId}]),
								Acc;
							Goods ->
								[{lib_goods:get_no(Goods), lib_goods:get_count(Goods)}|Acc]
						end
				end, [], AttachList0),
	pack_produce_goods_log(RoleId, [?LOG_MAIL, "get_attach"], AttachList).
	

%% 批量收取附件物品
%% @! 只有系统邮件拥有该权限
%% @return : {SuccessMailIdList, ErrorMailIdList} | {SuccessMailIdList, ErrorMailIdList, ErrCode}
batch_get_attach(RoleId, MailIdList) ->
    batch_get_attach(RoleId, MailIdList, [], []).

batch_get_attach(_, [], SuccList, ErrList) -> {SuccList, ErrList};
batch_get_attach(RoleId, [MailId | Left] = MailIdList, SuccList, ErrList) ->
    case get_mail_all_attach(RoleId, MailId) of
        true -> batch_get_attach(RoleId, Left, [MailId | SuccList], ErrList);
        {false, ErrCode} -> {SuccList, MailIdList ++ ErrList, ErrCode}
    end.

% batch_get_attach(RoleId, MailIdList) ->
%     case get_mail_brief(RoleId, ?MAIL_SYS) of
%         Brief when is_record(Brief, mail_brief) ->
%             F = fun(MailId, {SuccList, ErrList}) ->
%                     case get_mail_all_attach(RoleId, MailId) of
%                         true -> {[MailId | SuccList], ErrList};
%                         _ -> {SuccList, [MailId | ErrList]}
%                     end
%                 end,
%             lists:foldl(F, {[], []}, Brief#mail_brief.mails);
%         _ -> {false, ?PM_UNKNOWN_ERR}
%     end.


%% 删除单个邮件
%% @return : true | {false, ErrCode}
% notify_delete_single_mail(RoleId, MailId) ->
%     case delete_singel_mail(RoleId, MailId) of
%         true ->
%             case get_mail_brief(RoleId, Mail#mail.type) of
%                 Brief when is_record(Brief, mail_brief) ->
%                     MailList = Brief#mail_brief.mails,
%                     case length(MailList) >= get_mail_show_num()
%             true;
%         Other -> Other
%     end.

delete_singel_mail(RoleId, MailId) ->
    case get_mail(MailId) of
        Mail when is_record(Mail, mail) andalso Mail#mail.recv_id =:= RoleId ->
            case Mail#mail.attach of
                [] -> skip;
                Attach when is_list(Attach) -> 
                    IdList = [GoodsId || {GoodsId, _} <- Attach],
                    mod_inv:destroy_goods_by_id(RoleId, IdList, [?LOG_MAIL, "discard"])
            end,
            delete_mail(MailId),
            case get_mail_brief(RoleId, Mail#mail.type) of
                Brief when is_record(Brief, mail_brief) ->
                    MailList = lists:keydelete(MailId, 1, Brief#mail_brief.mails),
                    NewMailBref = Brief#mail_brief{mails = MailList},
                    update_mail_brief(NewMailBref),
                    Num = get_mail_show_num(Mail#mail.type),
                    case length(MailList) >= Num of
                        true -> 
                            {BackupId, _} = lists:nth(Num, MailList),
                            notify_backup_mail(BackupId);
                        false -> skip
                    end;
                _ -> ?ASSERT(false, [RoleId])
            end,
            true;
        _ -> {false, ?PM_MAIL_NOT_EXISTS}
    end.


%% 批量删除邮件
%% @return {success_list, error_list}
batch_delete_mail(RoleId, MailIdList) ->
    batch_delete_mail__(RoleId, MailIdList, [], []).

batch_delete_mail__(_RoleId, [], SuccList, ErrList) -> {SuccList, ErrList};
batch_delete_mail__(RoleId, [MailId | Left] = List, SuccList, ErrList) ->
    case delete_singel_mail(RoleId, MailId) of
        true -> batch_delete_mail__(RoleId, Left, [MailId | SuccList], ErrList);
        _ -> {SuccList, List ++ ErrList}
    end.


%% 检查过期邮件
check_expired_mail(RoleId, Timestamp) when is_integer(RoleId) ->
    check_expired_mail(RoleId, ?MAIL_SYS, Timestamp),
    check_expired_mail(RoleId, ?MAIL_PRI, Timestamp).

check_expired_mail(RoleId, Type, Timestamp) when is_integer(RoleId) ->
    case get_mail_brief(RoleId, Type) of
        MailBrief when is_record(MailBrief, mail_brief) -> 
            {Flag, NewList} = check_expired_mail_1(lists:reverse(MailBrief#mail_brief.mails), Timestamp, Type, [], 0, RoleId),
            ?BIN_PRED(Flag =/= 0, ?LDS_TRACE(check_expired_mail_1, [Flag, NewList, MailBrief#mail_brief.mails]), skip),
            ?BIN_PRED(Flag =:= 0, skip, update_mail_brief(MailBrief#mail_brief{mails = NewList}));
        _ -> skip
    end.



check_expired_mail_1([], _, _Type, List, Flag, _RoleId) -> {Flag, List};
check_expired_mail_1([{MailId, Timestamp} | Left] = MailList, NowStamp, Type, List, Flag, RoleId) ->
    case Timestamp + get_mail_lifetime(Type) > NowStamp of
        true -> {Flag, lists:reverse(MailList) ++ List};
        false ->
            util:actin_new_proc(?MODULE, spawn_del_mail, [MailId, RoleId]),
            check_expired_mail_1(Left, NowStamp, Type, List, Flag + 1, RoleId)
    end.


    % case get_mail(MailId) of
    %     Mail when is_record(Mail, mail) ->
    %         case Mail#mail.timestamp + get_mail_lifetime(Mail#mail.type) > Timestamp of
    %             true -> 
    %                 {Flag, lists:reverse(List) ++ [MailId | Left]};
    %             false ->
    %                 util:actin_new_proc(?MODULE, spawn_del_mail, [MailId]),
    %                 check_expired_mail_1(Left, Timestamp, List, Flag + 1)
    %         end;
    %     _ -> 
    %         ?ASSERT(false, [MailId]), 
    %         check_expired_mail_1(Left, Timestamp, List, Flag + 1)
    % end.


%% ==========================================================
%% local faction
%% ==========================================================


%% 根据邮箱最大格子数拆分附件
%% @return  [Attach1, Attach2, ...]
split_attach_by_limit_count(GoodsList) ->
    split_attach_by_limit_count(GoodsList, []).

split_attach_by_limit_count(GoodsList, Sum) ->
    case erlang:length(GoodsList) > ?MAX_ATTACH_NUM of
        true -> {L, Left} = lists:split(?MAX_ATTACH_NUM, GoodsList),
                split_attach_by_limit_count(Left, Sum ++ [L]);
        false -> Sum ++ [GoodsList]
    end.



%% @doc 把物品从玩家邮箱放进背包
%% GoodsList::[GoodsId]
%% @retrun true | {false, ErrCode}
give_attach_to_role_bag(RoleId, GoodsList) ->
    case mod_inv:check_batch_add_goods(RoleId, GoodsList) of
        ok ->
            F = fun(GoodsId) -> 
                Event = [buy, drop_kill, drop_kill_dark, collect, catch_pet],
                case player:get_PS(RoleId) of
                    null -> skip;
                    PS -> 
                        case lib_goods:get_goods_by_id(GoodsId) of
                            null ->
                                ?ASSERT(false, GoodsId),
                                ?ERROR_MSG("give_attach_to_role_bag: get_goods_by_id error: GoodsId:~p~n", [GoodsId]);
                            Goods ->
                                [lib_event:event(E, [lib_goods:get_no_by_id(GoodsId), lib_goods:get_count(Goods)], PS) || E <- Event]
                        end
                end
            end,
            [F(GoodsId) || GoodsId <- GoodsList],
            %% 注意！ 邮件收取由于跟装备转移同一个接口，日志记录无法公用，故单独记录日志
            mod_inv:add_goods_to_bag(RoleId, GoodsList, [?LOG_SKIP]),
            % ?LDS_DEBUG("[mail] give_attach_to_role_bag", [GoodsList, "log"]),
            % LogInfo = [?LOG_MAIL, "recv"],
            % F = fun(GoodsId) -> 
            %     Goods = lib_goods:get_goods_by_id(GoodsId),
            %     case lib_goods:get_type(Goods) =:= ?GOODS_T_VIRTUAL of
            %         true -> lib_log:statis_produce_currency(RoleId, lib_goods:get_no(Goods), lib_goods:get_count(Goods), LogInfo);
            %         false -> lib_log:statis_produce_goods(RoleId, GoodsId, lib_goods:get_no(Goods), lib_goods:get_count(Goods), LogInfo)
            %     end
            % end,
            % lists:foreach(F, GoodsList),

            % case player:get_PS(RoleId) of
            %     Status when is_record(Status, player_status) -> 

            %         Goods = lib_goods:get_goods_by_id(GoodsId),
            %         case lib_goods:get_type() =:= ?GOODS_T_VIRTUAL of
            %             true ->
            %                 lib_log:statis_produce_currency(RoleId, MoneyType, AddNum, LogInfo);

            %     _ -> skip
            % end,
            true;
        {fail, Reason} -> {false, Reason}
    end.


%% @doc 创建物品到玩家邮箱
%% GoodsList::[{GoodsNo, Num}]
%% @retrun [{goodsId, NewNum}]
create_goods_to_role_mail(RoleId, Attach) ->
    create_goods_to_role_mail_1(RoleId, Attach, []).

create_goods_to_role_mail_1(_RoleId, [], List) -> lists:reverse(lists:flatten(List));
create_goods_to_role_mail_1(RoleId, [{GoodsNo, Num} | Left], List) -> 
    Goods = mod_inv:add_new_goods_to_player(RoleId, [{GoodsNo, Num}], [{location, ?LOC_MAIL}]),
    create_goods_to_role_mail_1(RoleId, Left, [Goods | List]);
create_goods_to_role_mail_1(RoleId, [{GoodsNo, State, Num} | Left], List) ->
    Goods = mod_inv:add_new_goods_to_player(RoleId, [{GoodsNo, Num}], [{bind_state, State}, {location, ?LOC_MAIL}]),
    create_goods_to_role_mail_1(RoleId, Left, [Goods | List]);
create_goods_to_role_mail_1(RoleId, [{GoodsNo, Num, Quality, State} | Left], List) ->
    Goods = mod_inv:add_new_goods_to_player(RoleId, [{GoodsNo, Num}], [{bind_state, State}, {location, ?LOC_MAIL}, {quality, Quality}]),
    create_goods_to_role_mail_1(RoleId, Left, [Goods | List]);
create_goods_to_role_mail_1(RoleId, [{GoodsNo, Num, Quality, State,NeedBroadcast} | Left], List) ->
    Goods = mod_inv:add_new_goods_to_player(RoleId, [{GoodsNo, Num}], [{bind_state, State}, {location, ?LOC_MAIL}, {quality, Quality}]),

    case NeedBroadcast of
        0 -> skip;
        _ -> mod_broadcast:send_sys_broadcast(NeedBroadcast, [player:get_name(RoleId), RoleId, GoodsNo, Quality, Num,0])
    end,
    
    create_goods_to_role_mail_1(RoleId, Left, [Goods | List]);
    
create_goods_to_role_mail_1(_R, _L, List) -> ?ASSERT(false, [{_R, _L}]), List.


%% @doc 把物品归属改成邮箱
%% GoodsObjectList::[#goods{}]
%% @return [{goodsId, Num}]
tranfer_goods_to_mail(RoleId, GoodsObjectList) ->
    mod_inv:add_new_goods_to_player(RoleId, GoodsObjectList, [{location, ?LOC_MAIL}]).



% single_pack_produce_goods_log(RoleId, GoodsId, Num, LogInfo) ->
%     Goods = mod_inv:get_goods_from_ets(GoodsId),
%     lib_log:statis_produce_goods(RoleId, GoodsId, Goods#goods.no, Num, LogInfo).


pack_produce_goods_log(_RoleId, _LogInfo, []) -> skip;
pack_produce_goods_log(RoleId, LogInfo, [{GoodsNo, Num} | Left]) ->
    lib_log:statis_produce_goods(RoleId, [], GoodsNo, Num, LogInfo),
    pack_produce_goods_log(RoleId, LogInfo, Left);
pack_produce_goods_log(RoleId, LogInfo, [{GoodsNo, _State, Num} | Left]) ->
    lib_log:statis_produce_goods(RoleId, [], GoodsNo, Num, LogInfo),
    pack_produce_goods_log(RoleId, LogInfo, Left);
pack_produce_goods_log(RoleId, LogInfo, [{GoodsNo, Num, _Quality, _State} | Left]) ->
    lib_log:statis_produce_goods(RoleId, [], GoodsNo, Num, LogInfo),
    pack_produce_goods_log(RoleId, LogInfo, Left);

pack_produce_goods_log(RoleId, LogInfo, [{GoodsNo, Num, _Quality, _State,_B} | Left]) ->
    lib_log:statis_produce_goods(RoleId, [], GoodsNo, Num, LogInfo),
    pack_produce_goods_log(RoleId, LogInfo, Left).

    

%% --------------
    % {false, ?PM_ATTACH_NOT_EXISTS}.


%% 检查私人邮件 
%% @return : {true, recvID} | {false, ErrCode}
check_priv_mail(RecName, Title, Content, SendName) ->
    case SendName =:= RecName of
        true -> {false, ?PM_MAIL_SEND_SELF};
        false ->
            case get_id_by_name(RecName) of
                RecvId when is_integer(RecvId) ->
                    CheckList = 
                        [{fun check_title/1, Title, ?PM_MAIL_WRONG_TITLE}, 
                         {fun check_content/1, Content, ?PM_MAIL_WRONG_CONTENT}],
                    case polling(CheckList) of
                        true -> {true, RecvId};
                        Err -> Err
                    end;
                null -> {false, ?PM_ROLE_NOT_EXISTS}
            end
    end.


%% 检查系统邮件 
%% @return : true | {false, ErrCode}
%% @! 暂不检查ID合法性
check_sys_mail(_RecId, Title, Content) ->
    CheckList = [{fun check_title/1, Title, ?PM_MAIL_WRONG_TITLE},
                 {fun check_content/1, Content, ?PM_MAIL_WRONG_CONTENT}],
    polling(CheckList).


%% 检查后台批量发送邮件
%% @return 
check_batch_send_mail(IdList, Title, Content, GoodsList) ->
    case check_batch_send_all_mail(Title, Content, GoodsList) of
        true ->
            case check_id_list(IdList) of
                false -> {false, IdList};
                true -> true
            end;
        Other -> Other
    end.

    % case check_title(Title) of
    %     false -> {false, Title};
    %     true -> 
    %         case check_content(Content) of
    %             false -> {false, Content};
    %             true ->
    %                 case check_attach(GoodsList) of
    %                     false -> {false, GoodsList};
    %                     true -> 
    %                         case check_id_list(IdList) of
    %                             false -> {false, IdList};
    %                             true -> true
    %                         end
    %                 end
    %         end
    % end.

check_batch_send_all_mail(Title, Content, GoodsList) ->
    case check_title(Title) of
        false -> {false, Title};
        true -> 
            case check_content(Content) of
                false -> {false, Content};
                true ->
                    case check_attach(GoodsList) of
                        false -> {false, GoodsList};
                        true -> true
                    end
            end
    end.


%% @doc 检查Id列表是否合法
%% @return boolean()
check_id_list([]) -> true;
check_id_list([RoleId | Left]) ->
    case player:is_player_exist(RoleId) of
        true -> check_id_list(Left);
        false -> false
    end.


%% @spec check_content(Content::binary()) -> true | false
%% 检查信件内容合法性
check_content(Content) when is_binary(Content) ->
    check_length(Content, ?CONTENT_LENGTH);
check_content(Content) -> check_content(tool:to_binary(Content)).


%% @spec check_title(Title::binary()) -> true | false
%% 检查信件标题合法性
check_title(Title) when is_binary(Title) ->
    check_length(Title, ?TITLE_LENGTH);
check_title(Title) -> check_title(tool:to_binary(Title)).


%% @spec check_name(Name::binary()) -> true | false
%% 检查信件姓名合法性
check_name(Name) when is_binary(Name) ->
    check_length(Name, ?NAME_LENGTH);
check_name(Name) -> check_name(tool:to_binary(Name)).


% @spec check_attach(Attach::list()) -> true | false
% 检查信件附件合法性
check_attach([]) -> true;
check_attach([{GoodsNo, _State, Num} | Left]) ->
    case data_goods:get(GoodsNo) of
        Good when is_record(Good, goods_tpl) ->
            case Num =< Good#goods_tpl.max_stack of
                true -> check_attach(Left);
                false -> false
            end;
        _ -> false
    end;
check_attach(_) -> false.  



%% 根据名字寻找ID
%% @return id::integer() | null
get_id_by_name(Name) when is_binary(Name) ->
    case check_name(Name) of
        true -> get_id_by_name_1(Name);
        false -> null
    end;
get_id_by_name(Name) when is_list(Name) ->
    get_id_by_name(list_to_binary(Name));
get_id_by_name(_Name) -> ?ASSERT(false, [_Name]), null.


get_id_by_name_1(Name) ->
    case get_id_in_memory(Name) of
        RoleId when is_integer(RoleId) -> RoleId;
        _ -> null
    end.


%% 从内存中根据玩家名字查找id，查询不到则到数据库中查询，并加载到内存中
%% @return : id::integer() | null
get_id_in_memory(Name) ->
    case ets:lookup(?ETS_ROLE_NAME, Name) of
        [{_, RoleId} | _] when is_integer(RoleId) -> RoleId;
        [] -> 
            case get_id_in_db(Name) of
                Id when is_integer(Id) -> 
                    set_name_id_map(Id, Name),
                    Id;
                _ -> null
            end;
        _ -> ?ASSERT(false), null
    end.


%% 从数据库中根据玩家名字查询玩家id
%% @retrun : id::integer() | null
get_id_in_db(Name) ->
    case catch db:select_one(player, "id", [{nickname, tool:to_list(Name)}]) of
        Id when is_integer(Id) -> Id;
        _ -> null
    end.


set_name_id_map(RoleId, Name) ->
    true = ets:insert(?ETS_ROLE_NAME, {Name, RoleId}).


get_mail_count(Type) ->
    case Type of
        ?MAIL_SYS -> ?MAIL_MAX_SYS_COUNT;
        ?MAIL_PRI -> ?MAIL_MAX_PRI_COUNT
    end.

% get_mail_count_memory(RoleId) -> redo.
    % case ets:lookup(?MAIL_COUNT, RoleId) of
    %     [Count | _] -> Count;
    %     _ -> redo
    % end.



%% @spec check_length(Bin::binary(), Length::integer()) -> true | false
%% 检查utf8字节流长度是否超出限制
check_length(<<>>, _) -> true;
check_length(Bin, Length) ->
    case asn1rt:utf8_binary_to_list(Bin) of
        {ok, UnicodeList} -> 
            %% 所有类型字符都当作占1个长度
            erlang:length(UnicodeList) =< Length;
        Err -> 
            ?ASSERT(false),
            ?ERROR_MSG("check_length Err = ~p~n", [Err]),
            false
    end.


%% 发送邮件统一接口
%% @spec send_mail(SendId::integer(), RecvId::integer()/RecName::binary(), Title::binary(),  Attatch::list()
%%                 Content::binary(), Type::integer()) -> true | {false, ErrCode}

send_mail(RecName, Title, Content, Type, Attach, SendId, SendName) when is_binary(RecName) ->
    case get_id_by_name(RecName) of
        RecvId when is_integer(RecvId) ->
            send_mail(RecvId, Title, Content, Type, Attach, SendId, SendName);
        _ -> {false, ?PM_ROLE_NOT_EXISTS}
    end;
%% @return true
send_mail(RecvId, Title, Content, Type, Attach, SendId, SendName) when is_integer(RecvId) ->
    Timestamp = util:unixtime(),
    BinAttach = util:term_to_bitstring(Attach),
    % {ok, BinAttach} = asn1rt:utf8_list_to_binary(Attach),
    MailId = save_mail(Type, ?UN_READ, Timestamp, SendId, SendName, RecvId, Title, Content, BinAttach),
    update_target_mail_brief(RecvId, MailId, Type, Timestamp),
    del_old_mail(RecvId, Type),
    MailRd = make_mail_record(MailId, Type, ?UN_READ, Timestamp, SendId, SendName, RecvId, Title, Content, Attach),
    notify_target_recv_mail(MailRd),
    true.

%% 后台发送的邮件不判断邮件数是否达到上限
admin_send_mail(RecvId, Title, Content, Type, Attach, SendId, SendName, _LogInfo) when is_integer(RecvId) ->
    Timestamp = util:unixtime(),
    BinAttach = util:term_to_bitstring(Attach),
    MailId = save_mail(Type, ?UN_READ, Timestamp, SendId, SendName, RecvId, Title, Content, BinAttach),
    update_target_mail_brief(RecvId, MailId, Type, Timestamp),
    MailRd = make_mail_record(MailId, Type, ?UN_READ, Timestamp, SendId, SendName, RecvId, Title, Content, Attach),
    notify_target_recv_mail(MailRd),
    true.


%% 更新收件人的 #mail_brief{} 
%% @return void
update_target_mail_brief(RoleId, MailId, Type, Timestamp) ->
    case get_mail_brief(RoleId, Type) of
        MailBrief when is_record(MailBrief, mail_brief) ->
            case lists:keymember(MailId, 1, MailBrief#mail_brief.mails) of
                true -> skip;
                false -> update_mail_brief(MailBrief#mail_brief{mails = [{MailId, Timestamp} | MailBrief#mail_brief.mails]})
            end;
        _ -> ?ASSERT(false)
    end.


%% 通知收件人新邮件
%% @spec notify_target_recv_mail(MailRd::#mail{}) -> void
notify_target_recv_mail(MailRd) ->
    RecvId = MailRd#mail.recv_id,
    case player:is_online(RecvId) of 
        true -> gen_server:cast(player:get_pid(RecvId), 
                    {apply_cast, ?MODULE, notify_new_mail, 
                    [RecvId, MailRd#mail.id, MailRd#mail.type, MailRd#mail.title, MailRd#mail.timestamp,
                     MailRd#mail.timestamp + get_mail_lifetime(MailRd#mail.type), ?BIN_PRED(MailRd#mail.attach =:= [], 0, 1)]});
        false -> skip
    end.


%% 判断收件人邮件数到达上限后删除最老的邮件
%% @spec del_old_mail(RoleId::integer(), Type::integer()) -> void
del_old_mail(RoleId, Type) ->
    case player:is_online(RoleId) of
        true -> gen_server:cast(player:get_pid(RoleId), {del_old_mail, Type});
        false -> 
            case get_mail_brief(RoleId, Type) of
                MailBrief when is_record(MailBrief, mail_brief) ->
                    MaxCount = get_mail_count(Type),
                    ?LDS_TRACE(del_old_mail, [erlang:length(MailBrief#mail_brief.mails), MaxCount]),
                    case erlang:length(MailBrief#mail_brief.mails) > MaxCount of
                        true ->
                            {List, DelList} = lists:split(MaxCount, MailBrief#mail_brief.mails),
                            % [MailId | Left] = MailBrief#mail_brief.mails,
                            util:actin_new_proc(?MODULE, spawn_del_mail_list, [[DelId || {DelId, _} <- DelList], RoleId]),
                            update_mail_brief(MailBrief#mail_brief{mails = List});
                        false -> skip
                    end;
                _ -> ?ASSERT(false)
            end
    end.


%% @retuen : #mail_brief{} | null
get_mail_brief(RoleId, Type) ->
    case ets:lookup(?ETS_MAIL_BRIEF, {RoleId, Type}) of
        [Brief | _] when is_record(Brief, mail_brief) ->
            %% 纠正内存邮件的id为长id
            F = fun({MailId, Timestamp}, Acc) ->
                [{adust_id(MailId), Timestamp} | Acc]
            end,
            NewMails = lists:foldl(F, [], Brief#mail_brief.mails),
            case Brief#mail_brief.mails =:= NewMails of
                true -> Brief;
                false ->
                    NewMailBref = Brief#mail_brief{mails = NewMails},
                    update_mail_brief(NewMailBref),
                    NewMailBref
            end;
        [] -> 
            case query_mail_brief(RoleId, Type) of
                Brief when is_record(Brief, mail_brief) ->
                    update_mail_brief(Brief),
                    Brief;
                _ -> null
            end
    end.


set_mail_brief(MailBrief) ->
    true = ets:insert(?ETS_MAIL_BRIEF, MailBrief). 


update_mail_brief(Brief) ->
    true = ets:insert(?ETS_MAIL_BRIEF, Brief).


%% 数据库中加载所有邮件简要信息
%% @retuen : #mail_brief{} | error
query_mail_brief(RoleId, Type) ->
    case db:select_all(mail, "id, timestamp", [{recv_id, RoleId}, {type, Type}], [{timestamp, desc}], []) of
        Result when is_list(Result) -> 
            % Mails = lists:flatten(Result),
            NewMails = check_mails_count(Result, Type, RoleId),
            #mail_brief{id = {RoleId, Type}, mails = NewMails};
        _Err -> % ?ERROR_MSG("mail query_mail_brief err = ~p~n", [Err]), 
               ?ASSERT(false), error
    end.


%% 检查邮件数量，过长则删除旧邮件
%% @retrun [{MailId, Timestamp}]
check_mails_count(Mails, Type, RoleId) ->
    case erlang:length(Mails) =< get_mail_count(Type) of
        true -> [{adust_id(MailId), Timestamp} || [MailId, Timestamp] <- Mails];
        false ->
            {L1, L2} = lists:split(get_mail_count(Type), Mails),
            ?LDS_TRACE(check_mails_count, [MailId || [MailId, _] <- L2]),
            util:actin_new_proc(?MODULE, spawn_del_mail_list, [[MailId || [MailId, _] <- L2], RoleId]),
            [{adust_id(MailId), Timestamp} || [MailId, Timestamp] <- L1]
    end.


%% 轮询遍历
polling([]) -> true;
polling([{Fun, Args, ErrCode} | Left]) ->
    case Fun(Args) of
        true -> polling(Left);
        false -> {false, ErrCode}
    end.


%% -------------------- data ------------------------

%% @retrun #mail{}
make_mail_record(MailId, Type, State, Timestamp, SendId, SendName, RecvId, Title, Content, Attach) ->
    F = fun({Id, Count}, Acc) ->
        NewId = case lib_account:is_global_uni_id(Id) of true -> Id; false -> lib_account:to_global_uni_id(Id) end,
        [{NewId, Count} | Acc]
    end,

    NewAttach = lists:foldl(F, [], Attach),
    #mail{
        id = adust_id(MailId)
        ,send_id = SendId
        ,send_name = SendName
        ,recv_id = RecvId
        ,title = Title
        ,content = Content
        ,type = Type
        % ,display_type = DisplayType
        ,state = State
        ,timestamp = Timestamp
        ,attach = NewAttach
    }.


adust_id(TId) ->
    Id = 
        case lib_account:is_global_uni_id(TId) of 
            true -> TId; 
            false -> 
                GlobalId = lib_account:to_global_uni_id(TId),
                db:update(?DB_SYS, mail, ["id"], [GlobalId], "id", TId), 
                GlobalId
        end,
    Id.

%% @retrun MailId
save_mail(Type, State, Timestamp, SendId, SendName, RecvId, Title, Content, BinAttach) ->
    MailId = db:insert_get_id(mail, 
        ["type", "state", "timestamp", "send_id", "send_name", "recv_id", "title", "content", "attach"],
        [Type, State, Timestamp, SendId, SendName, RecvId, Title, Content, BinAttach]),
    adust_id(MailId).


%% @doc 取得邮件生命周期
get_mail_lifetime(Type) ->
    case Type of
        ?MAIL_SYS -> ?MAIL_SYS_LIFETIME;
        ?MAIL_PRI -> ?MAIL_PRI_LIFETIME
    end. 

%% ------------------------------------------------------------------
%% 邮件具体信息采用进程字典存储在玩家进程当中，以下函数必须在玩家进程内执行

%% 取得邮件计时器
%% @return list()
% get_all_mail_timer_ref() ->
%     case get(?MAIL_TIMER_LIST) of
%         undefined -> [];
%         List -> List
%     end.

% add_mail_timer(Ref) ->
%     List = get_all_mail_timer_ref(),
%     put(?MAIL_TIMER_LIST, [Ref | List]).


%% 获取客户端需要的邮件列表简要信息
%% @retrun : {MailId, Type, State, Title, startTime, LeftTime, HadAttach} | null
get_mail_brief_info(MailId) ->
    case get_mail(MailId) of
        null -> ?ASSERT(false, MailId), null;
        Mail -> 
            {MailId, Mail#mail.type, Mail#mail.state, Mail#mail.title, Mail#mail.timestamp,
             Mail#mail.timestamp + get_mail_lifetime(Mail#mail.type), ?BIN_PRED(Mail#mail.attach =:= [], 0, 1)}
    end.


%% @retrun #mail{} | null
get_mail(MailId) ->
    case get(?MAIL(MailId)) of
        undefined -> load_mail(MailId);
            % case get_del_mail_in_cache(MailId) of
            %     null -> load_mail(MailId);
            %     Val -> ?ERROR_MSG("get_del_mail_in_cache ~p~n", [Val]), null
            % end;
        Mail when is_record(Mail, mail) -> Mail;
        _ -> ?ASSERT(false), null
    end.


%% @return null | MailId
get_del_mail_in_cache(MailId) ->
    case get(?DEL_MAIL(MailId)) of 
        undefined -> null;
        Obj -> Obj
    end.

set_del_mail_in_cache(MailId) ->
    put(?DEL_MAIL(MailId), MailId).


%% @return #mail{}
load_mail(MailId) ->
    case db:select_all(mail, "*", [{id, MailId}]) of
        [] -> 
            case db:select_all(mail, "*", [{id, lib_account:to_local_id(MailId)}]) of
                [] -> null;
                [[LocMailId, Type, State, Timestamp, SendId, SendName, RecvId, Title, Content, Attach]] ->
                    % NewAttach = asn1rt:utf8_binary_to_list(Attach),
                    NewAttach = util:bitstring_to_term(Attach),
                    % ?LDS_TRACE(load_mail, [NewAttach]),
                    Mail = make_mail_record(LocMailId, Type, State, Timestamp, SendId, SendName, RecvId, Title, Content, NewAttach),
                    add_mail(Mail),
                    Mail;
                Err -> 
                    ?ASSERT(false, lib_account:to_local_id(MailId)), 
                    ?ERROR_MSG("mail load_mail error = ~p~n", [Err]),
                    null
            end;
        % MailList when is_list(MailList) ->
        %     lists:foreach(fun() -> end, MailList);
        [[MailId, Type, State, Timestamp, SendId, SendName, RecvId, Title, Content, Attach]] ->
            % NewAttach = asn1rt:utf8_binary_to_list(Attach),
            NewAttach = util:bitstring_to_term(Attach),
            % ?LDS_TRACE(load_mail, [NewAttach]),
            Mail = make_mail_record(MailId, Type, State, Timestamp, SendId, SendName, RecvId, Title, Content, NewAttach),
            add_mail(Mail),
            Mail;
        Err -> 
            ?ASSERT(false), 
            ?ERROR_MSG("mail load_mail error = ~p~n", [Err]),
            null
    end.


add_mail(Mail) when is_record(Mail, mail) ->
    put(?MAIL(Mail#mail.id), Mail);
add_mail(_) -> ?ASSERT(false).


update_mail(Mail) when is_record(Mail, mail) ->
    case get_mail(Mail#mail.id) of
        null -> 
            ?ASSERT(false);
        _ -> 
            add_mail(Mail),
            cache_mail_operation(update, Mail)
    end.
    

delete_mail(MailId) when is_integer(MailId) ->
    erlang:erase(?MAIL(MailId)),
    % set_del_mail_in_cache(MailId),
    cache_mail_operation(delete, MailId),
    save().


get_mail_cache() ->
    case get(?MAIL_CACHE) of
        undefined -> [];
        List when is_list(List) -> List;
        _ -> ?ASSERT(false), []
    end.


set_mail_cache(Cache) ->
    put(?MAIL_CACHE, Cache).


del_mail_cache() ->
    erase(?MAIL_CACHE).


%% @doc 转换#mail{} 为 #mail_cache{}
get_mail_cache_by_mail_rd(Mail) ->
    #mail_cache{id = Mail#mail.id, state = Mail#mail.state, attach = Mail#mail.attach}.
    

%% 采用list缓存操作，必须保持队列FILO特性
%% 在添加操作项后马上执行压缩
cache_mail_operation(Operation, Mail) ->
    List = get_mail_cache(),
    Arg = 
        case is_record(Mail, mail) of
            true -> get_mail_cache_by_mail_rd(Mail);
            false -> Mail
        end,
    NewList = compress({Operation, Arg}, List),
    set_mail_cache(NewList).


%% 压缩cache
%% @return new mailCache
compress({Operation, Mail}, []) -> [{Operation, Mail}];
compress({Operation, Mail}, List) ->
    compress({Operation, Mail}, List, []). 


compress(MailOperation, [], Sum) -> [MailOperation | lists:reverse(Sum)];

%% insert
% compress({insert, #mail{id = MailId} = NewMail}, [{_, #mail{id = MailId} = Mail} | Left], Sum) ->
%     ?ASSERT(false),
%     ?ERROR_MSG("cache mail error : insert a insert mail, NewMail = ~p, OldMail = ~p~n", [NewMail, Mail]),
%     [{insert, NewMail} | (lists:reverse(Sum) ++ Left)];
% compress({insert, #mail{id = MailId} = NewMail}, []) ->
%     [{insert, NewMail} | (lists:reverse(Sum) ++ Left)];

%% update
compress({update, #mail_cache{id = MailId} = NewMail}, [{update, #mail_cache{id = MailId} = _Mail} | Left], Sum) ->
    compress({update, NewMail}, Left, Sum);
compress({update, #mail_cache{id = MailId} = NewMail}, [{delete, MailId} | Left], Sum) ->
    ?ERROR_MSG("cache mail error : update a delete mail, NewMail = ~p, OldMail = ~p~n", [NewMail, MailId]),
    ?ASSERT(false),
    [{update, NewMail} | (lists:reverse(Sum) ++ Left)];
% compress({update, #mail{id = MailId} = NewMail}, [{insert, #mail{id = MailId} = Mail} | Left], Sum) ->
%     compress({insert, NewMail}, Left, Sum);

%% delete
compress({delete, MailId}, [{_, #mail_cache{id = MailId} = _Mail} | Left], Sum) ->
    compress({delete, MailId}, Left, Sum);

compress(NewOperation, [OldOperation | Left], Sum) ->
    compress(NewOperation, Left, [OldOperation | Sum]).


spawn_save() ->
    CacheList = get_mail_cache(),
    del_mail_cache(),
    util:actin_new_proc(?MODULE, save_1, [CacheList]).

save_1([]) -> skip;
save_1([Cache | Left]) ->
    save(Cache),
    save_1(Left).


save() ->
    CacheList = get_mail_cache(),
    ?LDS_TRACE("save_mail", [CacheList]),
    del_mail_cache(),
    save_1(CacheList).


spawn_update_attach(Mail) ->
    add_mail(Mail),
    util:actin_new_proc(db, update, [mail, [{attach, util:term_to_bitstring(Mail#mail.attach)}], [{id, Mail#mail.id}]]).

% spawn_update_attach_1([]) -> ok;
% spawn_update_attach_1([{MailId, Attach} | List]) ->
%     db:update(mail, [{attach, Attach}], [id, MailId]);
%     spawn_update_attach_1(List).


logout(_RoleId) ->
    CacheList = get_mail_cache(),
    del_mail_cache(),
    save_1(CacheList).
    % clean_mail_timer().


% clean_mail_timer() ->
%     case get_all_mail_timer_ref() of
%         [] -> skip;
%         List when is_list(List) -> [erlang:cancel_timer(Ref) || Ref <- List]
%     end.


%% ------------------------------------------------------------------

% save({update_attach, #mail{id = MailId, attach = Attach} = _Mail}) ->
%     db:update(mail, [{attach, Attach}], [id, MailId]);
% save({update, #mail{id = MailId, type = ?MAIL_SYS, state = State, attach = Attach} = _Mail}) ->
%     db:update(mail, [{state, State}, {attach, Attach}], [id, MailId]);
save({update, #mail_cache{id = MailId, state = State} = _Mail}) ->
    db:update(?DB_SYS, mail, [{state, State}], [{id, MailId}]);
save({delete, MailId}) ->
    db:delete(?DB_SYS, mail, [{id, MailId}]).


pack_log_goods_list([], _) -> [];
pack_log_goods_list(_, []) -> [];
pack_log_goods_list([{No, _} | Left], [{Id, Num} | Right]) ->
    [{No, Id, Num} | pack_log_goods_list(Left, Right)];
pack_log_goods_list([{No, _, _} | Left], [{Id, Num} | Right]) ->
    [{No, Id, Num} | pack_log_goods_list(Left, Right)];
pack_log_goods_list([{No, _, _, _} | Left], [{Id, Num} | Right]) ->
    [{No, Id, Num} | pack_log_goods_list(Left, Right)];
pack_log_goods_list(_, _) -> [].