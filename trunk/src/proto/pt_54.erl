%% @author wujiancheng
%% @doc @todo Add description to pt_54.


-module(pt_54).
-export([write/2, read/2]).

-include("common.hrl").
-include("pt_54.hrl").


%% ====================================================================
%% Internal functions
%% ====================================================================

%寻宝
read(?PT_START_AWARD_HUNTING, <<Type:8>>) ->
    {ok,[Type]};

read(?PT_GET_WEEKLY_AWARD, <<Type:8>>) ->
    {ok,[Type]};

read(?PT_ON_AWARD_HUNTING_PANEL_OPEN, <<Type:8>>) ->
    {ok,[Type]};

read(?PT_ON_AWARD_HUNTING_PANEL_CLOSE, <<Type:8>>) ->
    {ok,[Type]};

read(?PT_PUSH_HUNTING_RECORD, <<>>) ->
    {ok,[]};


%许愿
read(?PT_START_AWARD_TREASURE, <<Type:8>>) ->
    {ok,[Type]};

read(?PT_GET_FULL_TREASURE, <<Index:8>>) ->
    {ok,[Index]};

read(?PT_ON_AWARD_TREASURE_PANEL_OPEN, <<Type:8>>) ->
    {ok,[Type]};

read(?PT_ON_AWARD_TREASURE_PANEL_CLOSE, <<Type:8>>) ->
    {ok,[Type]};

read(?PT_PUSH_TREASURE_RECORD, <<>>) ->
    {ok,[]};

%大富翁玩法
read(?PT_ENTER_CHESS_CHECK_PANEL, <<>>) ->
    {ok,[]};

read(?PT_REQUEST_ENTER_CHESS_GAME, <<>>) ->
    {ok,[]};

read(?PT_CHESS_ENTER_INVALID, <<Type:8>>) ->
    {ok,[Type]};

read(?PT_CHESS_NOTIFY_INVALID, <<>>) ->
    {ok,[]};

read(?PT_CHESS_THROW_DICE, <<Type:8>>) ->
    {ok,[Type]};

read(?PT_CHESS_STAND_ON_CELL, <<Type:8>>) ->
    {ok,[Type]};

read(?PT_EXIT_CHESS_GAME, <<>>) ->
    {ok,[]};

read(?PT_OPEN_AWARD_OPTIONAL, <<>>) ->
    {ok,[]};

read(?PT_START_AWARD_OPTIONAL, <<Type:8>>) ->
    {ok,[Type]};

read(?PT_RESET_FULL_TREASURE, <<ReFresh:8>>) ->
    {ok,[ReFresh]};

read(?PT_OPTIONAL_TREASURE_NO, Bin) ->
    {IdList, _} = pt:read_array(Bin, [u8]),
    {ok, [IdList]};

read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.


%寻宝
write(?PT_START_AWARD_HUNTING, [Results, LuckyValue, WeeklyAward]) ->
	Len = erlang:length(Results),
    F = fun({Index,_}) -> 
        <<Index:8>>
    end,
	BinData = list_to_binary([F(X) || X <- Results]),
    {ok, pt:pack(?PT_START_AWARD_HUNTING, <<Len:16, BinData/binary ,LuckyValue:16, WeeklyAward:16 >>)};

write(?PT_GET_WEEKLY_AWARD, [AwardState]) ->
	Len = erlang:length(AwardState),
    F = fun(State) -> 
        <<State:8>>
    end,
	BinData = list_to_binary([F(X) || X <- AwardState]),
    {ok, pt:pack(?PT_GET_WEEKLY_AWARD, <<Len:16, BinData/binary  >>)};

write(?PT_ON_AWARD_HUNTING_PANEL_OPEN, [ LuckyValue, WeeklyAward ,Results]) ->
	Len = erlang:length(Results),
    F = fun(State) -> 
        <<State:8>>
    end,
	BinData = list_to_binary([F(X) || X <- Results]),
    {ok, pt:pack(?PT_ON_AWARD_HUNTING_PANEL_OPEN, <<LuckyValue:16, WeeklyAward:16, Len:16, BinData/binary  >>)};

write(?PT_PUSH_HUNTING_RECORD, [Records]) ->
	Len = erlang:length(Records),
    F = fun({Name, GoodsNo, Amount,Quality}) -> 
	    BinName = tool:to_binary(Name),
        Size = byte_size(BinName),
        <<Size:16, BinName/binary, GoodsNo:32, Amount:32,Quality:8 >>
    end,
	BinData = list_to_binary([F(X) || X <- Records]),
    {ok, pt:pack(?PT_PUSH_HUNTING_RECORD, <<Len:16, BinData/binary >>)};

%许愿

write(?PT_ON_AWARD_TREASURE_PANEL_OPEN, [ PoolIntegral, NowAccAmount, RewardList ]) ->
    Len = erlang:length(RewardList),
    F = fun({No,Num}) ->
        <<No:8, Num:16>>
        end,
    BinData = list_to_binary([F(X) || X <- RewardList]),
    {ok, pt:pack(?PT_ON_AWARD_TREASURE_PANEL_OPEN, <<PoolIntegral:32, NowAccAmount:16, Len:16, BinData/binary >>)};

write(?PT_START_AWARD_TREASURE, [Results, PoolIntegral, NowAccAmount]) ->
%%       	goods_no			u32			道具编号
%%			amount				u32			道具数量
%%          quality             u8          道具品质
	Len = erlang:length(Results),
    F = fun({_ , {_, GoodsNo,Amount,Quality}}) -> 
        <<GoodsNo:32, Amount:32, Quality:8>>
    end,
	BinData = list_to_binary([F(X) || X <- Results]),
    {ok, pt:pack(?PT_START_AWARD_TREASURE, <<Len:16, BinData/binary ,PoolIntegral:32, NowAccAmount:16 >>)};

write(?PT_GET_FULL_TREASURE, [ Flag, TotalIntegral, NowAccAmount, RewardList]) ->
    Len = erlang:length(RewardList),
    F = fun({No,Num}) ->
        <<No:8, Num:16>>
        end,
    BinData = list_to_binary([F(X) || X <- RewardList]),
    {ok, pt:pack(?PT_GET_FULL_TREASURE, <<Flag:8, TotalIntegral:32, NowAccAmount:16, Len:16, BinData/binary >>)};

write(?PT_PUSH_TREASURE_RECORD, [Records]) ->
	Len = erlang:length(Records),
    F = fun({Name, GoodsNo, Amount,Quality}) -> 
	    BinName = tool:to_binary(Name),
        Size = byte_size(BinName),
        <<Size:16, BinName/binary, GoodsNo:32, Amount:32,Quality:8 >>
    end,
	BinData = list_to_binary([F(X) || X <- Records]),
    {ok, pt:pack(?PT_PUSH_TREASURE_RECORD, <<Len:16, BinData/binary >>)};

%大富翁玩法
write(?PT_ENTER_CHESS_CHECK_PANEL, [ Free, Total]) ->
    {ok, pt:pack(?PT_ENTER_CHESS_CHECK_PANEL, <<Free:8, Total:8 >>)};

write(?PT_REQUEST_ENTER_CHESS_GAME, [ Results, Position]) ->
    Len = erlang:length(Results),
    F = fun(State) ->
        <<State:32>>
        end,
    BinData = list_to_binary([F(X) || X <- Results]),
    {ok, pt:pack(?PT_REQUEST_ENTER_CHESS_GAME, <<Len:16, BinData/binary ,Position:8 >>)};


write(?PT_CHESS_NOTIFY_INVALID, [ Type, Name]) ->
    BinData = tool:to_binary(Name),
    Size = byte_size(BinData),
    {ok, pt:pack(?PT_CHESS_NOTIFY_INVALID, <<Type:8, Size:16, BinData/binary >>)};

write(?PT_CHESS_THROW_DICE , [ Type, Position ]) ->
    {ok, pt:pack(?PT_CHESS_THROW_DICE, <<Type:8, Position:8 >>)};

write(?PT_CHESS_ENTER_INVALID , []) ->
    {ok, pt:pack(?PT_CHESS_ENTER_INVALID, <<>>)};
%%
write(?PT_CHESS_STAND_ON_CELL, [ Type ]) ->
    {ok, pt:pack(?PT_CHESS_STAND_ON_CELL, <<Type:8 >>)};

write(?PT_EXIT_CHESS_GAME, [ Id ]) ->
    {ok, pt:pack(?PT_EXIT_CHESS_GAME, <<Id:64 >>)};

write(?PT_CHESS_GET_REWARD, [ No, Amount]) ->
    {ok, pt:pack(?PT_CHESS_GET_REWARD, <<No:32, Amount:32 >>)};


write(?PT_OPEN_AWARD_OPTIONAL,  DataList) ->
    Len = erlang:length(DataList),
    F = fun(No) ->
        <<No:8>>
        end,
    BinData = list_to_binary([F(X) || X <- DataList]),
    {ok, pt:pack(?PT_OPEN_AWARD_OPTIONAL, <<Len:16, BinData/binary >>)};


write(?PT_START_AWARD_OPTIONAL,  DataList) ->
    Len = erlang:length(DataList),
    F = fun(No) ->
        <<No:8>>
        end,
    BinData = list_to_binary([F(X) || X <- DataList]),
    {ok, pt:pack(?PT_START_AWARD_OPTIONAL, <<Len:16, BinData/binary >>)};

write(?PT_OPTIONAL_TREASURE_NO,Num) ->
    {ok, pt:pack(?PT_OPTIONAL_TREASURE_NO, <<Num:8>>)};

write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.
