%%%------------------------------------
%%% @author 吴剑c
%%% @copyright JKYL 2018.08.21
%%% @doc 帮派副本.
%%% @end
%%%------------------------------------



-module(pt_53).
-export([write/2, read/2]).

-include("common.hrl").
-include("pt_53.hrl").




%% 帮派副本总览
read(?PT_GET_GUILD_INFO, <<>>) ->
    {ok, []};

read(?PT_GET_POINT_INFO, <<Point:8>>) ->
    {ok,[Point]};

read(?PT_ENTER_DUNGEON, <<Point:8>>) ->
    {ok,[Point]};

read(?PT_GET_REWARD, <<Point:8, Reward:8 >>) ->
    {ok,[Point,Reward]};


read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.


write(?PT_GET_GUILD_INFO, [FinishPoint,FinalAward]) ->
	Week = util:get_week(),
	BinData = <<Week:8, FinishPoint:8, FinalAward:8>>,
    {ok, pt:pack(?PT_GET_GUILD_INFO, BinData)};

write(?PT_GET_POINT_INFO, [SelectPoint, Progress, Contribution,FinishValue,PreAwardS]) ->
    Len = length(PreAwardS),
    Bin = list_to_binary([<< X:8 >> || X <- PreAwardS]),
	BinData = <<SelectPoint:8, Progress:16, Contribution:16, FinishValue:32, Len:16, Bin/binary  >>,
	{ok, pt:pack(?PT_GET_POINT_INFO, BinData)};

write(?PT_COLLECTION_RESPOND, [Point]) ->
	BinData = <<Point:8>>,
    {ok, pt:pack(?PT_COLLECTION_RESPOND, BinData)};

write(?PT_ENTER_DUNGEON, [BossHp]) ->
	BinData = <<BossHp:32>>,
    {ok, pt:pack(?PT_ENTER_DUNGEON, BinData)};

write(?PT_DUNGEON_DETAIL, [Count,Kill,Boss]) ->
	BinData = <<Count:16, Kill:16, Boss:8 >>,
    {ok, pt:pack(?PT_DUNGEON_DETAIL, BinData)};

write(?PT_DUNGEON_RANK, [Point,List]) ->
	Len = erlang:length(List),
    F = fun({_PlayerId,Name, Value}) -> 
        BinName = tool:to_binary(Name),
        Size = byte_size(BinName),
        <<Size:16, BinName/binary, Value:32>>
    end,
	BinData = list_to_binary([F(X) || X <- List]),
    {ok, pt:pack(?PT_DUNGEON_RANK, <<Point:8, Len:16, BinData/binary >>)};

write(?PT_GET_REWARD, [Result]) ->
	BinData = <<Result:8>>,
    {ok, pt:pack(?PT_GET_REWARD, BinData)};

write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.




