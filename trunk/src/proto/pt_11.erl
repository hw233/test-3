%%%-----------------------------------
%%% @Module  : pt_11
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.29
%%% @Modified: 2013.10 -- LDS
%%% @Description: 聊天系统
%%%-----------------------------------
-module(pt_11).
-include("common.hrl").
-include("broadcast.hrl").

-include("protocol/pt_11.hrl").

-export([read/2, write/2]).

% %%
% %%客户端 -> 服务端 ----------------------------
% %%

read(?PT_WORLD, <<Type:8, Bin/binary>>) ->
    {ok, [Type, Bin]};

read(?PT_PERSONAL, <<Id:64, Bin/binary>>) ->
    {ok, [Id, Bin]};

read(?PT_CURRENT, Bin) ->
    {ok, [Bin]};

read(?PT_CHAT_CROSS_SERVER, <<Type:8, Bin/binary>>) ->
    {ok, [Type, Bin]};

read(?PT_GUILD, Bin) ->
    {ok, [Bin]};

read(?PT_TEAM, Bin) ->
    {ok, [Bin]};

read(?PT_HORN, Bin) ->
    {ok, [Bin]};

read(?PT_FACTION, Bin) ->
    {ok, [Bin]};

read(?PT_SEND_ACCORSS_PLAYAER, <<RoleId:64, ServerId:32>>) ->
    {ok, [RoleId, ServerId]};

read(?PT_SEND_ACCORSS_PARTNER, <<PartnerId:64, ServerId:32>>) ->
    {ok, [PartnerId, ServerId]};

read(?PT_SEND_ACCORSS_GOODS, <<GoodsId:64, ServerId:32>>) ->
    {ok, [GoodsId, ServerId]};

read(11009, <<RoleId:64>>) ->
    {ok, [RoleId]};

%%---------------------------------------------公告----------------------

read(11201, _) ->
    {ok, []};

read(11202, Bin) ->
    {IdList, _} = pt:read_array(Bin, [u32]),
    {ok, [IdList]};

%% ---------------------------------------------------------------------

read(11300, <<TargetPlayerId:64>>) ->
    {ok, TargetPlayerId};

read(11301, <<TargetPlayerId:64>>) ->
    {ok, TargetPlayerId};

read(_Cmd, _) ->
    ?LDS_TRACE("read protol error : ", _Cmd),
    ?ASSERT(false, _Cmd),
    {error, not_match}.



write(?PT_WORLD, [Id, Msg, Identify, Name, PrivLv,Race,Sex,Dan]) ->
    BinName = pt:string_to_binary(Name),
    BinData = <<Id:64, Msg/binary, Identify:8, BinName/binary, PrivLv:8,Race:8, Sex:8, Dan:8 >>,
    {ok, pt:pack(?PT_WORLD, BinData)};

write(?PT_CHAT_CROSS_SERVER, [Id, Msg, Identify, Name, PrivLv, Race, Sex, ServerId, BeforeMergeServerId, Dan]) ->
    BinName = pt:string_to_binary(Name),
    BinData = <<Id:64, Msg/binary, Identify:8, BinName/binary, PrivLv:8,Race:8, Sex:8, ServerId:32, BeforeMergeServerId:32, Dan:8>>,
    {ok, pt:pack(?PT_CHAT_CROSS_SERVER, BinData)};

write(?PT_PERSONAL, [FromId, Msg, Identify, Name, ToId, FromPrivLv,Race,Sex]) -> 
    BinName = pt:string_to_binary(Name),   
    BinData = <<FromId:64, Msg/binary, Identify:8, BinName/binary, ToId:64, FromPrivLv:8,Race:8, Sex:8 >>,
    {ok, pt:pack(?PT_PERSONAL, BinData)};

write(?PT_CURRENT, [Id, Msg, Identify, Name, PrivLv,Race,Sex]) ->
    BinName = pt:string_to_binary(Name),
    BinData = <<Id:64, Msg/binary, Identify:8, BinName/binary, PrivLv:8,Race:8, Sex:8 >>,
    {ok, pt:pack(?PT_CURRENT, BinData)};

write(?PT_SYS, [Msg]) -> 
    {ok, pt:pack(?PT_SYS, Msg)};

write(?PT_GUILD, [Id, Msg, Identify, Name, PrivLv,Race,Sex,Pos,Dan]) ->
    BinName = pt:string_to_binary(Name),
    BinData = <<Id:64, Msg/binary, Identify:8, BinName/binary, PrivLv:8,Race:8, Sex:8,Pos:8,Dan:8>>,
    {ok, pt:pack(?PT_GUILD, BinData)};

write(?PT_TEAM, [Id, Msg, Identify, Name, PrivLv,Race,Sex,Dan]) ->
    BinName = pt:string_to_binary(Name),
    BinData = <<Id:64, Msg/binary, Identify:8, BinName/binary, PrivLv:8,Race:8, Sex:8, Dan:8>>,
    {ok, pt:pack(?PT_TEAM, BinData)};

write(?PT_HORN, [Id, Msg, Identify, Name, PrivLv,Race,Sex]) ->
    BinName = pt:string_to_binary(Name),
    BinData = <<Id:64, Msg/binary, Identify:8, BinName/binary, PrivLv:8,Race:8, Sex:8>>,
    {ok, pt:pack(?PT_HORN, BinData)};

write(?PT_FACTION, [Id, Msg, Identify, Name, PrivLv,Race,Sex]) ->
    BinName = pt:string_to_binary(Name),
    BinData = <<Id:64, Msg/binary, Identify:8, BinName/binary, PrivLv:8,Race:8, Sex:8 >>,
    {ok, pt:pack(?PT_FACTION, BinData)};

write(11009, [Id, Race, Sex, Lv, Name, Faction, Vip, BattlePower, BanChat, GuildName, PeakLv]) ->
    BinName = pt:string_to_binary(Name),
    BinGuildName = pt:string_to_binary(GuildName),
    {ok, pt:pack(11009, <<Id:64, Race:8, Sex:8, Lv:16, BinName/binary, Faction:8, Vip:8, BattlePower:32, BanChat:8, BinGuildName/binary, PeakLv:16>>)};

write(11010, [Time, Reason]) ->
    BinReason = tool:to_binary(Reason),
    Len = byte_size(BinReason),
    {ok, pt:pack(11010, <<Time:32, Len:16, BinReason/binary>>)};

write(11100, [Cmd, State]) -> 
    BinData = <<Cmd:16, State:8>>,
    {ok, pt:pack(11100, BinData)};


write(11201, IdList) -> 
    F = fun(Id) -> <<Id:32>> end, 
    List = lists:map(F, IdList),
    Len = length(List),
    Bin = list_to_binary(List),
    {ok, pt:pack(11201, <<Len:16, Bin/binary>>)};


write(11202, BroadcastList) ->
    F = fun(Broadcast) -> broadcast_to_binary(Broadcast) end, 
    List = lists:map(F, BroadcastList),
    Len = length(List),
    Bin = list_to_binary(List),
    {ok, pt:pack(11202, <<Len:16, Bin/binary>>)};


write(11203, [Id]) ->
    Bin = <<Id:32>>,
    {ok, pt:pack(11203, <<Bin/binary>>)};


write(11204, [Broadcast]) ->
    Bin = broadcast_to_binary(Broadcast),
    {ok, pt:pack(11204, <<Bin/binary>>)};    


% write(11205, [No, ParaList]) ->
%     ParaInt = [X || X <- ParaList, is_integer(X)],
%     ParaString = ParaList -- ParaInt,
%     F = fun(Para) ->
%         Index = get_index(Para, ParaList),
%         case is_integer(Para) of
%             true -> <<Index:8, Para:32>>;
%             false ->
%                 case is_list(Para) of
%                     true -> <<Index:8, (byte_size(list_to_binary(Para))):16, (list_to_binary(Para)) /binary>>;
%                     false -> <<Index:8, (byte_size(Para)):16, Para /binary>>
%                 end
%         end
%     end,

%     List1 = lists:map(F, ParaInt),
%     Len1 = length(ParaInt),
%     Bin1 = list_to_binary(List1),

%     List2 = lists:map(F, ParaString),
%     Len2 = length(ParaString),
%     Bin2 = list_to_binary(List2),

%     {ok, pt:pack(11205, <<No:32, Len1:16, Bin1/binary, Len2:16, Bin2/binary>>)};

% write(11205, [No, ParaList]) ->
%     Para = list_to_binary(ParaList),
%     Len = byte_size(Para),
%     {ok, pt:pack(11205, <<No:32, Len:16, Para/binary>>)};

write(11205, [No, ParaList]) ->
    F = fun(Para) ->
        case is_integer(Para) of
            true -> 
                TmpPara = list_to_binary(integer_to_list(Para)),
                <<(byte_size(TmpPara)):16, TmpPara / binary>>;
            false ->
                case is_list(Para) of
                    true -> <<(byte_size(list_to_binary(Para))):16, (list_to_binary(Para)) /binary>>;
                    false ->
                        Para2 = case  Para < 0 of
                                    true ->
                                        0;
                                    false ->
                                        Para
                                end,
                        <<(byte_size(Para2)):16, Para /binary>>
                end
        end
    end,

    List = lists:map(F, ParaList),
    Len = length(ParaList),
    Bin = list_to_binary(List),

    {ok, pt:pack(11205, <<No:32, Len:16, Bin/binary>>)};



write(11300, [RetCode, TargetPlayerId]) ->
    Bin = <<RetCode:8, TargetPlayerId:64>>,
    {ok, pt:pack(11300, Bin)};

write(11301, [RetCode, TargetPlayerId]) ->
    Bin = <<RetCode:8, TargetPlayerId:64>>,
    {ok, pt:pack(11301, Bin)};


write(_Cmd, _) ->
    ?LDS_TRACE("write protol error : ", _Cmd),
    ?ASSERT(false, _Cmd),
    {error, not_match}.


% get_index(Para, ParaList) ->
%     get_index(Para, ParaList, 1).

% get_index(Para, [H | T], Index) ->
%     case Para =:= H of
%         true -> Index;
%         false -> get_index(Para, T, Index + 1)
%     end;

% get_index(_Para, [], _Index) ->
%     ?ASSERT(false),
%     ?INVALID_NO.

broadcast_to_binary(Broadcast) ->
    Id = Broadcast#broadcast.id,
    Type = Broadcast#broadcast.type,
    Interval = Broadcast#broadcast.interval,
    StartTime = Broadcast#broadcast.start_time,
    EndTime = Broadcast#broadcast.end_time,
    Priority = Broadcast#broadcast.priority,
    Content = Broadcast#broadcast.content,

    <<
        Id :                    32,
        Type :                  8,
        Interval :              32,
        StartTime :             32,
        EndTime :               32,
        Priority :              8,
        (byte_size(Content)) :  16,
        Content                 /binary
    >>.

% %%世界聊天
% read(?PT_WORLD, <<Color:8, Bin/binary>>) ->
%     {ChatMsg, _} = pt:read_string(Bin),
%     {ok, [Color, ChatMsg]};

% %%私聊
% read(?PT_PERSONAL, <<Color:8, Id:32, Bin/binary>>) ->
%     {Nick, Bin1} = pt:read_string(Bin),
%     {Msg, _} = pt:read_string(Bin1),
%     {ok, [Color, Id, Nick, Msg]};

% %%场景聊天
% read(?PT_CURRENT, <<Color:8, Bin/binary>>) ->
%     {Msg, _} = pt:read_string(Bin),
%     {ok, [Color, Msg]};

% %%帮派聊天
% read(?PT_GUILD, <<Color:8, Bin/binary>>) ->
% %% 	io:format("**** read a ?PT_GUILD\n"),
%     {Msg, _} = pt:read_string(Bin),
%     {ok, [Color, Msg]};

% %%队伍聊天
% read(?PT_TEAM, <<Color:8, Bin/binary>>) ->
% %% 	io:format("**** read a ?PT_TEAM\n"),
%     {Msg, _} = pt:read_string(Bin),
%     {ok, [Color, Msg]};

% %% GM命令
% read(?PT_HORN, <<Bin/binary>>) ->
%     {Msg, _} = pt:read_string(Bin),
%     {ok, [Msg]};

% %%喇叭喊话
% read(?PT_FACTION, <<Color:8, Bin/binary>>) ->
% 	{Msg, _} = pt:read_string(Bin),
% 	{ok, [Color, Msg]};

% %% GM命令
% read(11009, <<Type:32, Bin/binary>>) ->
%     {Msg, _} = pt:read_string(Bin),
%     {ok, [Type, Msg]};

% %%玩家禁言
% read(11011, _Data) ->
% 	{ok, []};

% read(_Cmd, _R) ->
%     ?ASSERT(fasle, {_Cmd, _R}),
%     {error, no_match}.




    

% % %%
% % %%服务端 -> 客户端 ------------------------------------
% % %%

% %% 世界聊天
% write(?PT_WORLD, [PS, Color, ChatMsg]) ->
%     PlayerName = player:get_name(PS),
%     ChatMsg_Bin = list_to_binary(ChatMsg),
%     Data =  <<
%                 Color : 8,
%                 (player:id(PS)) : 64,
%                 (byte_size(PlayerName)) : 16, 
%                 PlayerName / binary,
%                 (byte_size(ChatMsg_Bin)) : 16, 
%                 ChatMsg_Bin / binary
%             >>,
%     {ok, pt:pack(?PT_WORLD, Data)};

% %%私聊
% %% write(?PT_PERSONAL, [Flag, Id, Nick]) ->
% %% 	Nick1 = tool:to_binary(Nick),
% %%     Len = byte_size(Nick1),
% %% 	Data = <<Flag:8, Id:32, Len:16, Nick1/binary>>,
% %% 	{ok, pt:pack(?PT_PERSONAL, Data)};

% write(?PT_PERSONAL, [Flag, TargetId, TargetNick, Id, Nick, Bin, Color]) ->
% 	TargetNick1 = tool:to_binary(TargetNick),
% 	Tlen = byte_size(TargetNick1),
%     Nick1 = list_to_binary(Nick),
%     Len = byte_size(Nick1),
%     Bin1 = tool:to_binary(Bin),
%     Len1 = byte_size(Bin1),
%     Data = <<Flag:8, TargetId:32, Tlen:16, TargetNick1/binary, Id:32, Len:16, Nick1/binary, Len1:16, Bin1/binary, Color:8>>,
%     {ok, pt:pack(?PT_PERSONAL, Data)};

% %%场景聊天
% write(?PT_CURRENT, [Id, Nick, Bin, Color]) ->
%     Nick1 = tool:to_binary(Nick),
%     Len = byte_size(Nick1),
%     Bin1 = tool:to_binary(Bin),
%     Len1 = byte_size(Bin1),
%     Data = <<Id:32, Len:16, Nick1/binary, Len1:16, Bin1/binary, Color:8>>,
%     {ok, pt:pack(?PT_CURRENT, Data)};

% %%聊天系统信息
% write(?PT_SYS, Msg) ->
%     Msg1 = tool:to_binary(Msg),
%     Len1 = byte_size(Msg1),
%     Data = <<Len1:16, Msg1/binary>>,
%     {ok, pt:pack(?PT_SYS, Data)};

% %%帮派系统信息
% write(?PT_GUILD, [PlayerId, PlayerName, MsgContent, Color]) ->
%     PlayerNameBin  = tool:to_binary(PlayerName),
%     PlayerNameLen  = byte_size(PlayerNameBin),
%     MsgContentBin = tool:to_binary(MsgContent),
%     MsgContentLen = byte_size(MsgContentBin),
%     Data = <<PlayerId:32, PlayerNameLen:16, PlayerNameBin/binary, MsgContentLen:16, MsgContentBin/binary, Color:8>>,
%     {ok, pt:pack(?PT_GUILD, Data)};

% %%队伍聊天
% write(?PT_TEAM, [Id, Nick, Bin, Color]) ->
%     Nick1 = tool:to_binary(Nick),
%     Len = byte_size(Nick1),
%     Bin1 = tool:to_binary(Bin),
%     Len1 = byte_size(Bin1),
%     Data = <<Id:32, Len:16, Nick1/binary, Len1:16, Bin1/binary, Color:8>>,
%     {ok, pt:pack(?PT_TEAM, Data)};

% %% GM命令
% write(?PT_HORN, [Code]) ->
%     Data = <<Code:16>>,
%     {ok, pt:pack(?PT_HORN, Data)}; 

% %%私聊返回黑名单通知
% write(?PT_HORN, Id) ->
%     {ok, pt:pack(?PT_HORN, <<Id:32>>)};

% %%悬浮提示
% write(11082, Msg) ->
%     Msg1 = tool:to_binary(Msg),
%     Len1 = byte_size(Msg1),
%     Data = <<Len1:16, Msg1/binary>>,
%     {ok, pt:pack(11082, Data)};

% %%喇叭喊话
% write(?PT_FACTION, [Flag, Id, Nick, Data, Color, Title]) ->
% 	BinNick = tool:to_binary(Nick),
% 	BinData = tool:to_binary(Data),
% 	NickLen = byte_size(BinNick),
% 	DataLen = byte_size(BinData),
% 	Msg = <<Flag:8, Id:32, NickLen:16, BinNick/binary, DataLen:16, BinData/binary, Color:8, Title:32>>,
% 	{ok, pt:pack(?PT_FACTION, Msg)};

% %%GM指令返回
% write(11009, Msg) ->
%     Msg1 = tool:to_binary(Msg),
%     Len1 = byte_size(Msg1),
%     Data = <<Len1:16, Msg1/binary>>,
%     {ok, pt:pack(11009, Data)};

% write(?PT_FACTION, [Flag]) ->
% 	{ok, pt:pack(?PT_FACTION, <<Flag:8>>)};

% %% 系统公告
% write(11010, [Msg]) ->
%     Msg1 = tool:to_binary(Msg),
%     Len1 = byte_size(Msg1),
%     Data = <<Len1:16, Msg1/binary>>,
%     {ok, pt:pack(11010, Data)};

% %%玩家被禁言
% write(11011, [BanTime]) ->
% 	{ok, pt:pack(11011, <<BanTime:32>>)};

% %% 公告
% write(11012, [Msg]) ->
%     Msg1 = tool:to_binary(Msg),
%     Len1 = byte_size(Msg1),
%     Data = <<Len1:16, Msg1/binary>>,
%     {ok, pt:pack(11012, Data)};

% %% 虚拟物品掉落的淡入淡出公告
% write(11013, [Msg]) ->
%     Msg1 = tool:to_binary(Msg),
%     Len1 = byte_size(Msg1),
%     Data = <<Len1:16, Msg1/binary>>,
%     {ok, pt:pack(11013, Data)};

% %%帮会信息
% write(11014, [List]) ->
% 	Len = length(List),
%     F = fun([Id, Content, Type]) ->
% 				BinContent = tool:to_binary(Content),
% 				ContentLen = byte_size(BinContent),
% 				<<Id:32, ContentLen:16, BinContent/binary, Type:8>>
% 		end,
% 	ConvertList = tool:to_binary([F(X) || X <- List, X /= []]),
% %% 	io:format("@@@LDS: the ConvertList is ~p~n", [ConvertList]),
%     Data = <<Len:16, ConvertList/binary>>,
% 	{ok, pt:pack(11014, Data)};

% %% 只在信息框中显示
% write(11015, [Channel, Msg]) ->
%     Msg1 = tool:to_binary(Msg),
%     Len1 = byte_size(Msg1),
%     Data = <<Channel:16, Len1:16, Msg1/binary>>,
%     {ok, pt:pack(11015, Data)};

% %% 淡入淡出提示框
% write(11016, [Msg]) ->
%     Msg1 = tool:to_binary(Msg),
%     Len1 = byte_size(Msg1),
%     Data = <<Len1:16, Msg1/binary>>,
%     {ok, pt:pack(11016, Data)};

% %% desc: 全服通知(滚动条)
% write(11017, [Type, NameArray]) ->
%     NameBin = pack_name_list(NameArray),
%     {ok, pt:pack(11017, <<Type:8, NameBin/binary>>)};

% %% desc: 全服通知(闪现)
% write(11018, [Type, NameArray]) ->
%     NameBin = pack_name_list(NameArray),
%     {ok, pt:pack(11018, <<Type:8, NameBin/binary>>)};

% %% 全服通知(聊天框)
% write(11019, [Msg]) ->
%     BinMsg = tool:to_binary(Msg),
%     Len = byte_size(BinMsg),
%     {ok, pt:pack(11019, <<Len:16, BinMsg/binary>>)};

% %% 任务完成提示
% write(11020, Msg) ->
%     Msg1 = tool:to_binary(Msg),
%     Len1 = byte_size(Msg1),
%     Data = <<Len1:16, Msg1/binary>>,
%     {ok, pt:pack(11020, Data)};

% %% desc: 诸神战场通知
% write(11021, [Type, Msg]) ->
%     MsgBin = tool:to_binary(Msg),
%     Len = byte_size(MsgBin),
%     {ok, pt:pack(11021, <<Type:32, Len:16, MsgBin/binary>>)};

% write(_Cmd, _R) ->
%     ?ASSERT(fasle, {_Cmd, _R}),
%     {error, no_match}.



% %% desc: 名字列表
% pack_name_list(NameList) ->
%     F = fun(Element) ->
%                 [Color, Name] = 
%                     case is_list(Element) of
%                         true ->    [?COLOR_YELLOW, Element];
%                         false ->   tuple_to_list(Element)
%                     end,
%                 BinNameArray = lib_common:make_sure_binary(Name),
%                 NameLen = byte_size(BinNameArray),
%                 <<Color:8, NameLen:16, BinNameArray/binary>>
%         end,
%     Len = length(NameList),
%     Bin = list_to_binary( lists:map(F, NameList) ),
%     <<Len:16, Bin/binary>>.

    

