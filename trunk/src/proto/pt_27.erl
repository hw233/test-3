%%%-----------------------------------
%%% @Module  : pt_27
%%% @Author  : Liuzhongzheng2012@gmail.com
%%% @Email   :
%%% @Created : 2014.6
%%% @Description: 在线竞技场
%%%-----------------------------------
-module (pt_27).

-include("common.hrl").
-include("pt_27.hrl").
-include("arena_1v1.hrl").
-include("pt.hrl").


-export([write/2, read/2]).

read(?PT_ARENA_1V1_INFO, <<>>) ->
    {ok, []};

read(?PT_ARENA_1V1_JOIN, <<>>) ->
    {ok, []};

read(?PT_ARENA_1V1_LEAVE, <<>>) ->
    {ok, []};

read(?PT_ARENA_1V1_REPORTS, <<Type:8>>) ->
    {ok, [Type]};

read(?PT_ARENA_1V1_WEEK_TOP, <<>>) ->
    {ok, []};

read(?PT_ARENA_3V3_INFO, <<>>) ->
    {ok, []};

read(?PT_ARENA_3V3_JOIN, <<>>) ->
    {ok, []};

read(?PT_ARENA_3V3_LEAVE, <<>>) ->
    {ok, []};

read(?PT_ARENA_3V3_REPORTS, <<Type:8>>) ->
    {ok, [Type]};

read(?PT_ARENA_3V3_WEEK_TOP, <<>>) ->
    {ok, []};

read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.

write(?PT_ARENA_1V1_INFO, [DW, DL, WW, WL]) ->
    {ok, pt:pack(?PT_ARENA_1V1_INFO, <<DW:8, DL:8, WW:16, WL:16>>)};

write(?PT_ARENA_1V1_READY, [ID, Name, Race, Sex, Lv]) ->
    {ok, pt:pack(?PT_ARENA_1V1_READY, <<ID:64, ?P_BITSTR(Name), Race:8, Sex:8, Lv:16>>)};

write(?PT_ARENA_1V1_REPORTS, [Type, Recs]) ->
    Len = length(Recs),
    F = fun(#rec{
                winer      = WinID,
                winer_name = WinName,
                loser      = LostID,
                loser_name = LostName,
                time       = Time,
                winer_wins = Wins
                },
            BinAcc) ->
            <<BinAcc/binary,
                WinID:64,
                ?P_BITSTR(WinName),
                LostID:64,
                ?P_BITSTR(LostName),
                Wins:16,
                Time:32>>
        end,
    Bin = lists:foldl(F, <<>>, Recs),
    {ok, pt:pack(?PT_ARENA_1V1_REPORTS, <<Type:8, Len:16, Bin/binary>>)};

write(?PT_ARENA_1V1_WEEK_TOP, [ID, Name]) ->
    {ok, pt:pack(?PT_ARENA_1V1_WEEK_TOP, <<ID:64, ?P_BITSTR(Name)>>)};


write(?PT_ARENA_3V3_JOIN, Code) ->
    {ok, pt:pack(?PT_ARENA_3V3_JOIN, <<Code:8>>)};

write(?PT_ARENA_3V3_LEAVE, Code) ->
    {ok, pt:pack(?PT_ARENA_3V3_LEAVE, <<Code:8>>)};

write(?PT_ARENA_3V3_INFO, [DW, DL, WW, WL, JF]) ->
    {ok, pt:pack(?PT_ARENA_3V3_INFO, <<DW:8, DL:8, WW:16, WL:16, JF:16>>)};

write(?PT_ARENA_3V3_READY, [ID, Name, List]) ->
    Len = erlang:length(List),
    BinData = <<<<Id:64, ?P_BITSTR(Name1), Race:8, Sex:8, Lv:16>> || {Id, Name1, Race, Sex, Lv} <- List>>,
    {ok, pt:pack(?PT_ARENA_3V3_READY, <<ID:64, ?P_BITSTR(Name), Len:16, BinData/binary>>)};

write(?PT_ARENA_3V3_REPORTS, [Type, Recs]) ->
    Len = length(Recs),
    F = fun(#rec{
                winer      = WinID,
                winer_name = WinName,
                loser      = LostID,
                loser_name = LostName,
                time       = Time,
                winer_wins = Wins
                },
            BinAcc) ->
            <<BinAcc/binary,
                WinID:64,
                ?P_BITSTR(WinName),
                LostID:64,
                ?P_BITSTR(LostName),
                Wins:16,
                Time:32>>
        end,
    Bin = lists:foldl(F, <<>>, Recs),
    {ok, pt:pack(?PT_ARENA_3V3_REPORTS, <<Type:8, Len:16, Bin/binary>>)};

write(?PT_ARENA_3V3_WEEK_TOP, [ID, Name]) ->
    {ok, pt:pack(?PT_ARENA_3V3_WEEK_TOP, <<ID:64, ?P_BITSTR(Name)>>)};

write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.