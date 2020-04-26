%%%-----------------------------------
%%% @Module  : pt_16
%%% @Author  : 
%%% @Email   :
%%% @Created : 2011.11
%%% @Description: 兵临城下信息
%%%-----------------------------------
-module(pt_16).
-compile(export_all).
-include("common.hrl").
-include("pt_16.hrl").
-include("tve.hrl").

%%
%%客户端 -> 服务端 ----------------------------
%%

read(?PT_TVE_ENTER, <<LvStep:8>>) ->
    {ok, [LvStep]};


read(?PT_TVE_REPLY, <<LvStep:8, Flag:8>>) ->
    {ok, [LvStep, Flag]};


read(?PT_TVE_REFRESH_REWARD, _) ->
    {ok, []};

read(?PT_TVE_GET_RANK, <<LvStep:8, RankCount:8>>) ->
    {ok, [LvStep, RankCount]};    

read(?PT_TVE_GET_REWARD, _) ->
    {ok, []};    

read(?PT_TVE_GET_ENTER_TIMES, _) ->
    {ok, []};


read(?PT_TVE_START_MF, <<BMonGroupNo:32>>) ->
    {ok, [BMonGroupNo]};    


read(_Cmd, _Data) ->
    ?ASSERT(false, [_Cmd]).


write(?PT_TVE_ENTER, RetList) ->
    Len = erlang:length(RetList),
    Bin = tool:to_binary([<<RetCode:8, (byte_size(PlayerName)):16, PlayerName/binary>> || {RetCode, PlayerName} <- RetList]),
    {ok, pt:pack(?PT_TVE_ENTER, <<Len:16, Bin/binary>>)};


write(?PT_TVE_SHOW_TIPS, [LvStep, State]) ->
    {ok, pt:pack(?PT_TVE_SHOW_TIPS, <<LvStep:8, State:8>>)};


write(?PT_TVE_REPLY, [LvStep, Flag, List]) ->
    Len = erlang:length(List),
    Bin = tool:to_binary([<<Id:64, State:8>> || {Id, State} <- List, is_integer(Id)]),
    {ok, pt:pack(?PT_TVE_REPLY, <<LvStep:8, Flag:8, Len:16, Bin/binary>>)};


write(?PT_TVE_REFRESH_REWARD, [MoneyType, MoneyCount, GoodsList]) ->
    Len = erlang:length(GoodsList),
    Bin = tool:to_binary([<<GoodsNo:32, GoodsCount:32, Quality:8, BindState:8, Flag:8>> || {GoodsNo, GoodsCount, Quality, BindState, Flag} <- GoodsList]),
    {ok, pt:pack(?PT_TVE_REFRESH_REWARD, <<MoneyType:8, MoneyCount:32, Len:16, Bin/binary>>)};


write(?PT_TVE_SHOW_RESULT, [Win, Rounds, MoneyType, MoneyCount, GoodsList]) ->
    Len = erlang:length(GoodsList),
    Bin = tool:to_binary([<<GoodsNo:32, GoodsCount:32, Quality:8, BindState:8, Flag:8>> || {GoodsNo, GoodsCount, Quality, BindState, Flag} <- GoodsList]),
    {ok, pt:pack(?PT_TVE_SHOW_RESULT, <<Win:8, Rounds:8, MoneyType:8, MoneyCount:32, Len:16, Bin/binary>>)};


write(?PT_TVE_GET_RANK, [LvStep, RankList]) ->
    Len = length(RankList),
    F = fun(Rank, Acc) ->
            NameLen = byte_size(Rank#tve_rank.leader_name),
            FactionListLen = length(Rank#tve_rank.faction_list),
            FactionListBin = list_to_binary([<<Faction:8>> || Faction <- Rank#tve_rank.faction_list]),
            TBin = 
                <<
                    (length(Acc) + 1) : 8,
                    NameLen : 16,
                    (Rank#tve_rank.leader_name) / binary,
                    (Rank#tve_rank.win) : 8,
                    (Rank#tve_rank.rounds) : 16,
                    (Rank#tve_rank.leader_vip_lv) : 8,
                    FactionListLen : 16,
                    FactionListBin / binary
                >>,
            [TBin | Acc]
        end,
    BinInfo = list_to_binary(lists:foldl(F, [], RankList)),
    Data = <<LvStep:8, Len:16, BinInfo/binary>>,
    {ok, pt:pack(?PT_TVE_GET_RANK, Data)};


write(?PT_TVE_GET_ENTER_TIMES, [Times]) ->
    {ok, pt:pack(?PT_TVE_GET_ENTER_TIMES, <<Times:8>>)};    

write(?PT_TVE_GET_REWARD, [RetCode]) ->
    {ok, pt:pack(?PT_TVE_GET_REWARD, <<RetCode:8>>)};

write(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]).


read_array(1, <<Id:32, _/binary>>) -> [Id];
read_array(Len, <<Id:32, Left/binary>>) ->
    [Id | read_array(Len - 1, Left)].