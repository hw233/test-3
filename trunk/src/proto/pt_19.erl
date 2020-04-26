%%%-----------------------------------
%%% @Module  : pt_19
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2013.12
%%% @Description: 邮件信息
%%%-----------------------------------
-module(pt_19).
-compile(export_all).
-include("common.hrl").
%%
%%客户端 -> 服务端 ----------------------------
%%
read(19001, BinMsg) ->
    {RecvName, Left1} = pt:read_string(BinMsg),
    {Title, Left2} = pt:read_string(Left1),
    {Content, _} = pt:read_string(Left2),
    {ok, [RecvName, Title, Content]};

read(19002, <<Type:8>>) ->
    {ok, [Type]};

read(19003, <<MailId:64>>) ->
    {ok, [MailId]};

read(19004, <<MailId:64, GoodsId:64>>) ->
    {ok, [MailId, GoodsId]};

read(19005, BinMsg) ->
    {IdList, _} = pt:read_array(BinMsg, [u64]),
    {ok, [IdList]};

read(19006, <<MailId:64>>) ->
    {ok, [MailId]};

read(19007, BinMsg) ->
    {IdList, _} = pt:read_array(BinMsg, [u64]),
    {ok, [IdList]};


read(_Cmd, _) ->
    ?LDS_TRACE("pt_19 read error", [_Cmd]),
    ?ASSERT(false, [_Cmd]),
    {error, []}.



write(19001, [Flag]) ->
    {ok, pt:pack(19001, <<Flag:8>>)};

write(19002, [Type, List]) ->
    % F = fun({MailId, Type, State, Title, LeftTime}) ->
    %         Tlen = byte_size(Title),
    %         <<MailId:64, Type:8, Tlen:16, Title/binary, State:8, LeftTime:32>>
    %     end,
    % Data = [F(X) || X <- List],
    Data = [begin Tlen = byte_size(Title), <<MailId:64, Tlen:16, Title/binary, State:8, StartTime:32, LeftTime:32, HadAttach:8>> end 
            || {MailId, _Type, State, Title, StartTime, LeftTime, HadAttach} <- List],
    Len = erlang:length(Data),
    BinData = list_to_binary(Data),            
    {ok, pt:pack(19002, <<Type:8, Len:16, BinData/binary>>)};

write(19003, [MailId, Name, Content, Attach]) ->
    AttachData = [<<GoodsId:64, No:32, Num:32, Qua:8, Bind:8>> || {GoodsId, No, Num, Qua, Bind} <- Attach],
    AttachLen = erlang:length(AttachData),
    AttachBinData = list_to_binary(AttachData),
    NameLen = byte_size(Name),
    ContentLen = byte_size(Content),
    {ok, pt:pack(19003, <<MailId:64, NameLen:16, Name/binary, ContentLen:16, Content/binary, AttachLen:16, AttachBinData/binary>>)};

write(19004, [MailId, GoodsId]) ->
    {ok, pt:pack(19004, <<MailId:64, GoodsId:64>>)};

write(19005, [SuccMailIdLIst, ErrMailIdList]) ->
    SucLen = erlang:length(SuccMailIdLIst),
    ErrLen = erlang:length(ErrMailIdList),
    SucBin = list_to_binary([<<Sid:64>> || Sid <- SuccMailIdLIst]),
    ErrBin = list_to_binary([<<Eid:64>> || Eid <- ErrMailIdList]),
    {ok, pt:pack(19005, <<SucLen:16, SucBin/binary, ErrLen:16, ErrBin/binary>>)};

write(19006, [MailId]) ->
    {ok, pt:pack(19006, <<MailId:64>>)};

write(19007, [SuccMailIdLIst, ErrMailIdList]) ->
    SucLen = erlang:length(SuccMailIdLIst),
    ErrLen = erlang:length(ErrMailIdList),
    SucBin = list_to_binary([<<Sid:64>> || Sid <- SuccMailIdLIst]),
    ErrBin = list_to_binary([<<Eid:64>> || Eid <- ErrMailIdList]),
    {ok, pt:pack(19007, <<SucLen:16, SucBin/binary, ErrLen:16, ErrBin/binary>>)};

write(19008, [MailId, Type, Title, Timestamp, Sec, HadAttach]) ->
    Tlen = byte_size(Title),
    {ok, pt:pack(19008, <<MailId:64, Type:8, Tlen:16, Title/binary, Timestamp:32, Sec:32, HadAttach:8>>)};

write(19010, [MailId, Type, Title, Timestamp, Sec, HadAttach, State]) ->
    Tlen = byte_size(Title),
    {ok, pt:pack(19010, <<MailId:64, Type:8, Tlen:16, Title/binary, Timestamp:32, Sec:32, HadAttach:8, State:8>>)};

write(_Cmd, _) ->
    ?LDS_TRACE("pt_19 write error", [_Cmd]),
    ?ASSERT(false, [_Cmd]),
    {error, []}.




%% @retrun : {[data], LeftBin}
% read_times(Times, ByteSize, Bin) ->
%     read_times(Times, ByteSize, Bin, []).

% read_times(0, _, LeftBin, Sum) -> {Sum, LeftBin};
% read_times(Times, ByteSize, Bin, Sum) ->
%     <<Data:ByteSize, Left/binary>> = Bin
%     read_times(Times - 1, ByteSize, Left, [Data | Sum]).