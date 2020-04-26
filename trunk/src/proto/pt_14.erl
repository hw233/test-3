%%%--------------------------------------
%%% @Module  : pt_14
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.06.07
%%% @Description:  14玩家间关系信息
%%%--------------------------------------
-module(pt_14).
-export([read/2, write/2]).

-include("common.hrl").
-include("abbreviate.hrl").
-include("pt_14.hrl").
%%
%%客户端 -> 服务端 ----------------------------
%%

%%请求好友列表
read(14000, _R) ->
    {ok, []};

%%添加好友请求
read(14001, <<Len:16, BinList/binary>>) ->
    IdList = get_id_list(BinList, []),
    case length(IdList) =/= Len of
        true -> 
            ?ASSERT(false),
            ?ERROR_MSG("friend: 14001 error Id number =/= length", []);
        _ -> skip
    end,
    {ok, [IdList]};


%%回应添加好友请求
read(14002,<<Choice:8, Len:16, BinList/binary>>) ->
    IdList = get_id_list(BinList, []),
    case length(IdList) =/= Len of
        true -> 
            ?ASSERT(false),
            ?ERROR_MSG("friend: 14002 error Id number =/= length", []);
        _ -> skip
    end,
    {ok, [Choice, IdList]};

%%删除好友
read(14003, <<Id:64>>) ->
    {ok, [Id]};

%%添加黑名单
read(14004, <<Id:32>>) ->
    {ok, Id};


%%请求黑名单列表
read(14007, _R) ->
    {ok, []};

%%请求仇人列表
read(14008, _R) ->
    {ok, []};

%%移动好友到别的分组
read(14009, <<Uid:32, N:16>>) ->
    {ok, [Uid, N]};

%%查找角色
read(14010, <<PageSize:8, PageNum:16, Bin/binary>>) ->
    {Nick, _} = pt:read_string(Bin),
    {ok, [PageSize, PageNum, Nick]};


read(14011, _) ->
    {ok, []};


read(14012, <<Id:64, Bin/binary>>) ->
    {ok, [Id, Bin]};


read(14013, _) ->
    {ok, []};    

%%设置自动回复
%read(14012, <<AutoRes:16, Bin/binary>>) ->
%    {Msg, _} = pt:read_string(Bin),
%    {ok, [AutoRes, Msg]};


%%删除黑名单
read(14020, <<Id:32>>) ->
    {ok, Id};

%%删除仇人
read(14021, <<Id:32>>) ->
    {ok, Id};

%%最近联系人
read(14032,_R) ->
	{ok, []};

%%关系列表
read(14034,_R) ->
	{ok, []};


read(14050, <<Type:8>>) ->
    {ok, [Type]};

read(14052, <<Type:8, Choice:8>>) ->
    {ok, [Type, Choice]};    

read(14053, _) ->
    {ok, []};    

read(14055, <<Choice:8, Prefix/binary>>) ->
    {Prefix1, _} = pt:read_string(Prefix),
    {ok, [Choice, Prefix1]};

read(14057, <<Suffix/binary>>) ->
    {Suffix1, _} = pt:read_string(Suffix),
    {ok, [Suffix1]};    


read(14058, <<Param:8>>) ->
    {ok, [Param]};

read(14059, _) ->
    {ok, []};

read(14100, <<PlayerId:64, Bin/binary>>) ->
    {InfoList, <<>>} = pt:read_array(Bin, [u64, u16]),
    {ok, [PlayerId, InfoList]};

read(?PT_GIVE_GIFTS, <<PlayerId:64, Bin/binary>>) ->
    {InfoList, <<>>} = pt:read_array(Bin, [u64, u16]),
    {ok, [PlayerId, InfoList]};

read(_Cmd, _R) ->
    {error, not_match}.

get_id_list(<<>>, List) ->
	List;
get_id_list(BinData, List) ->
	<<Id:64, Ret/binary>> = BinData,
	get_id_list(Ret, (List ++ [Id])).
	
%%
%%服务端 -> 客户端 ------------------------------------
%%

% 好友，仇人，临时好友
write(14000,[L,L2,L3]) ->
	N = length(L),
    N2 = length(L2),
    N3 = length(L3),
	F = fun([Id, PlayerId, Online, Lv, Race, Faction, Sex, BattlePower, Name, Intimacy]) ->
            NL = byte_size(Name),
            <<Id:64, PlayerId:64, Online:8, Lv:16, Race:8, Faction:8, Sex:8, BattlePower:32, NL:16, Name/binary, Intimacy:32>>
    end,
    LB = tool:to_binary([F(X) || X <- L, X /= []]),
    LB2 = tool:to_binary([F(X) || X <- L2, X /= []]),
    LB3 = tool:to_binary([F(X) || X <- L3, X /= []]),

    Data = <<N:16, LB/binary,N2:16, LB2/binary,N3:16, LB3/binary>>,
    {ok, pt:pack(14000, Data)};


%%添加好友请求
write(14001, RetList) ->
    F = fun({RetCode, Id}) ->
            <<
                RetCode:16,
                Id : 64
            >>
        end,
    Len = length(RetList),
    Bin = list_to_binary([F(X) || X <- RetList]),
    BinData = <<Len:16, Bin/binary>>,
    {ok, pt:pack(14001, BinData)};


%%回应添加好友请求
write(14002, [Type, Choice, Id]) ->
    Data = <<Type:8, Choice:8, Id:64>>,
    {ok, pt:pack(14002, Data)};

%删除好友
write(14003, [Id]) ->
    Data = <<Id:64>>,
    {ok, pt:pack(14003, Data)};

%%添加黑名单
write(14004, [RetCode, Id]) ->
    Data = <<RetCode:8, Id:64>>,
    {ok, pt:pack(14004,Data)};


write(14005, [Id, PlayerId, Online, Lv, Race, Faction, Sex, BattlePower, Name]) ->
    NL = byte_size(Name),
    Data = <<Id:64, PlayerId:64, Online:8, Lv:16, Race:8, Faction:8, Sex:8, BattlePower:32, NL:16, Name/binary>>,
    {ok, pt:pack(14005, Data)};    


write(?PT_CHANGE_NAME,[Id, Name]) ->
    NL = byte_size(Name),
    Data = <<Id:64, NL:16, Name/binary>>,
    {ok, pt:pack(?PT_CHANGE_NAME, Data)};   


write(14006, [Id, Lv, Race, Faction, VipLv, BattlePower, Name]) ->
    Len = byte_size(Name),
    Data = <<Id:64, Lv:16, Race:8, Faction:8, VipLv:8, BattlePower:32, Len:16, Name/binary>>,
    {ok, pt:pack(14006, Data)};


write(14010, [TotalPage, PageNum, PSList]) ->
    F = fun(PS) ->
            <<
                (player:id(PS)): 64,
                (player:get_lv(PS)) : 16,
                (player:get_race(PS)) :8,
                (player:get_faction(PS)):8,
                (player:get_sex(PS)):8,
                (ply_attr:get_battle_power(PS)):32,
                (player:get_vip_lv(PS)) : 8,
                (byte_size(player:get_name(PS))):16,
                (player:get_name(PS)) /binary
            >>
        end,
    Len = length(PSList),
    Data = list_to_binary([F(X) || X <- PSList]),
    {ok, pt:pack(14010, <<TotalPage:16, PageNum:16, Len:16, Data/binary>>)};


write(14011, [Count]) ->
    Data = <<Count:8>>,
    {ok, pt:pack(14011, Data)};


write(14012, [Id, Msg]) -> 
    BinData = <<Id:64, Msg/binary>>,
    {ok, pt:pack(14012, BinData)};


write(14013, List) -> 
    F = fun({Id, Msg, TimeStamp}) ->
        <<Id:64, Msg/binary, TimeStamp:32>>
    end,
    Len = length(List),
    Data = list_to_binary([F(X) || X <- List]),
    {ok, pt:pack(14013, <<Len:16, Data/binary>>)};


%%好友上下线通知
write(14030, [Action, PlayerId]) ->
    Data = <<Action:8, PlayerId:64>>,
    {ok, pt:pack(14030, Data)};


%%好友升级通知
write(14036, [Id, Lv]) ->
	Data = <<Id:64, Lv:16>>,
	{ok, pt:pack(14036, Data)};

write(14050, [RetCode, Type, RetList]) ->
    F = fun({Id, Reason}) ->
        <<Id:64, Reason:8>>
    end,
    Len = length(RetList),
    Data = list_to_binary([F(X) || X <- RetList]),
    {ok, pt:pack(14050, <<RetCode:8, Type:8, Len:16, Data/binary>>)};    


write(14051, [Type]) ->
    {ok, pt:pack(14051, <<Type:8>>)};    

write(14053, [RetCode]) ->
    {ok, pt:pack(14053, <<RetCode:8>>)};        

write(14055, [RetCode]) ->
    {ok, pt:pack(14055, <<RetCode:8>>)};        

write(14056, [Type, Choice, PreFreeCount, SufFreeCount, Prefix, Suffix, SwornId]) ->
    Data = <<Type:8, Choice:8, PreFreeCount:8, SufFreeCount:8, (byte_size(Prefix)):16, Prefix/binary, (byte_size(Suffix)):16, Suffix/binary, SwornId:64>>,
    {ok, pt:pack(14056, Data)};        

write(14057, [RetCode]) ->
    {ok, pt:pack(14057, <<RetCode:8>>)};            

write(14058, [Type, Choice, PreFreeCount, SufFreeCount, Prefix, Suffix, Param, SwornId]) ->
    Data = <<Type:8, Choice:8, PreFreeCount:8, SufFreeCount:8, (byte_size(Prefix)):16, Prefix/binary, (byte_size(Suffix)):16, Suffix/binary, Param:8, SwornId:64>>,
    {ok, pt:pack(14058, Data)};  


write(14059, []) ->
    {ok, pt:pack(14059, <<>>)};      

write(14100, [GetIntimacy, PlayerId, PlayerName]) ->
    {ok, pt:pack(14100, <<GetIntimacy:32, PlayerId:64, (byte_size(PlayerName)):16, PlayerName/binary>>)};                


write(14101, [ObjPlayerId, GetIntimacy]) ->
    {ok, pt:pack(14101, <<ObjPlayerId:64, GetIntimacy:32>>)};     

write(?PT_GIVE_GIFTS, [Code]) ->
    {ok, pt:pack(?PT_GIVE_GIFTS, <<Code:8>>)};     

write(?PT_ADD_ENEMY, [Id, PlayerId, Online, Lv, Race, Faction, Sex, BattlePower, Name]) ->
    NL = byte_size(Name),
    Data = <<Id:64, PlayerId:64, Online:8, Lv:8, Race:8, Faction:8, Sex:8, BattlePower:32, NL:16, Name/binary>>,
    {ok, pt:pack(?PT_ADD_ENEMY, Data)};                   


write(_Cmd, _R) ->
    {error, not_match}.
