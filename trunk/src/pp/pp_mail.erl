%%%--------------------------------------
%%% @Module  : pp_mail
%%% @Author  : LDS
%%% @Email   : 
%%% @Created : 2013.12
%%% @Description:  邮件系统
%%%--------------------------------------
-module(pp_mail).

-include("common.hrl").
-include("record.hrl").
-include("mail.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").

-export([handle/3]).
-compile(export_all).

% % 发邮件pp
handle(19001, Status, [RecvName, Title, Content]) ->
    ?LDS_TRACE(19001, [RecvName, Title, Content]),
    case player:has_enough_money(Status, ?MNY_T_BIND_GAMEMONEY, ?MAIL_COST_MONEY) of
        true -> 
            case lib_mail:send_pri_mail(tool:to_binary(RecvName), tool:to_binary(Title), tool:to_binary(Content), Status, []) of
                true -> 
                    player:cost_bind_gamemoney(Status, ?MAIL_COST_MONEY, [?LOG_MAIL, "send"]),
                    {ok, BinData} = pt_19:write(19001, [1]),
                    lib_send:send_to_sock(Status#player_status.socket, BinData);
                {false, ErrCode} -> 
                    lib_send:send_prompt_msg(Status, ErrCode), 
                    {ok, BinData} = pt_19:write(19001, [0]),
                    lib_send:send_to_sock(Status#player_status.socket, BinData)
            end;
        false -> 
            lib_send:send_prompt_msg(Status, ?PM_GAMEMONEY_LIMIT),
            {ok, BinData} = pt_19:write(19001, [0]),
            lib_send:send_to_sock(Status#player_status.socket, BinData)
    end;

% 查看邮件列表
handle(19002, Status, [Type]) ->
    % ?LDS_TRACE(19002),
    Data = lib_mail:get_mail_list_info(player:id(Status), Type),
    % ?LDS_TRACE(19002, [Data]),
    {ok, BinData} = pt_19:write(19002, [Type, Data]),
    lib_send:send_to_sock(Status#player_status.socket, BinData),
    ok;


%% 查看具体邮件
handle(19003, Status, [MailId]) ->
    ?LDS_TRACE(19002),
    case lib_mail:get_mail(MailId) of
        Mail when is_record(Mail, mail) ->
            lib_mail:set_mail_state_read(Mail),
            ?LDS_TRACE(19003, [Mail]),
            % PackAttach = [{GoodsId, mod_inv:get_goods_no_by_goods_id(player:id(Status), GoodsId)} || GoodsId <- Mail#mail.attach],

            PackAttach = [{GoodsId, lib_goods:get_no_by_id(GoodsId), Num, 
                mod_inv:get_goods_quality_by_id(player:id(Status), GoodsId), mod_inv:get_goods_bind_state_by_id(GoodsId)} || 
                {GoodsId, Num} <- Mail#mail.attach],
            ?LDS_TRACE(19003, [PackAttach, Mail#mail.attach]),
            {ok, BinData} = pt_19:write(19003, [MailId, Mail#mail.send_name, Mail#mail.content, PackAttach]),
            lib_send:send_to_sock(Status#player_status.socket, BinData),
            ok;
        _ -> lib_send:send_prompt_msg(Status, ?PM_MAIL_NOT_EXISTS), ?LDS_TRACE(19003, [?PM_MAIL_NOT_EXISTS])
    end;


% 收取附件
handle(19004, Status, [MailId, GoodsId]) ->
    case lib_mail:get_mail_attach(player:id(Status), MailId, GoodsId) of
        true -> 
            {ok, BinData} = pt_19:write(19004, [MailId, GoodsId]),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        {false, ErrCode} -> 
            lib_send:send_prompt_msg(Status, ErrCode)
    end;


%% 批量收取附件
handle(19005, Status, [MailIdList]) ->
    case lib_mail:batch_get_attach(player:id(Status), MailIdList) of
        {SuccMailIdLIst, ErrMailIdList, ErrCode} -> 
            lib_send:send_prompt_msg(Status, ErrCode),
            {ok, BinData} = pt_19:write(19005, [SuccMailIdLIst, ErrMailIdList]),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        {SuccMailIdLIst, ErrMailIdList} ->
            {ok, BinData} = pt_19:write(19005, [SuccMailIdLIst, ErrMailIdList]),
            lib_send:send_to_sock(Status#player_status.socket, BinData)
    end;


%% 删除邮件
handle(19006, Status, [MailId]) ->
    case lib_mail:delete_singel_mail(player:id(Status), MailId) of
        true -> 
            {ok, BinData} = pt_19:write(19006, [MailId]),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        {false, ErrCode} -> 
            lib_send:send_prompt_msg(Status, ErrCode)
    end;


%% 批量删除邮件
handle(19007, Status, [MailIdList]) ->
    ?LDS_TRACE(19007, [MailIdList]),
    case lib_mail:batch_delete_mail(player:id(Status), MailIdList) of
        {false, ErrCode} -> lib_send:send_prompt_msg(Status, ErrCode);
        {SuccMailIdLIst, ErrMailIdList} ->
            {ok, BinData} = pt_19:write(19007, [SuccMailIdLIst, ErrMailIdList]),
            lib_send:send_to_sock(Status#player_status.socket, BinData)
    end;


handle(_Cmd, _, _) ->
    ?ASSERT(false, [_Cmd]),
    error.


%% ============ test ==============

test_19001(RecvName, Title, Content) -> 
    handle(19001, player:get_PS(1), [tool:to_binary(RecvName), tool:to_binary(Title), tool:to_binary(Content)]).
