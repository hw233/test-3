%% @author wujiancheng
%% @doc @todo Add description to pt_54.


-module(pt_50).
-export([write/2, read/2]).

-include("common.hrl").
-include("pt_50.hrl").


%% ====================================================================
%% Internal functions
%% ====================================================================

%秘境
read(?PT_MYSTERIES_OPEN, <<>>) ->
    {ok,[]};

read(?PT_ENTER_MYSTERIES, <<No:32>>) ->
    {ok,[No]};

read(?PT_PLAY_ON_MYSTERIES, <<No:32>>) ->
    {ok, [No]};

read(?PT_MYSTERIES_REWARD, <<>>) ->
    {ok,[]};

read(?PT_MYSTERIES_TIME_RESET, <<>>) ->
    {ok,[]};

%幻境
read(?PT_MIRAGE_OPEN, <<>>) ->
    {ok,[]};

read(?PT_ENTER_MIRAGE, <<No:32>>) ->
    {ok,[No]};

read(?PT_PLAY_ON_MIRAGE, <<No:32>>) ->
    {ok, [No]};

read(?PT_MIRAGE_TIME_RESET, <<>>) ->
    {ok,[]};

read(?PT_NOTIFY_TEAM_MESSAGE, <<Agree:8>>) ->
    {ok,[Agree]};

read(?PT_MIRAGE_UNLOCK, <<Level_no:32>>) ->
    {ok,[Level_no]};

read(?PT_MIRAGE_CLOSE, <<>>) ->
    {ok,[]};

read(?PT_START_REINCARNATION, <<>>) ->
    {ok,[]};

read(?PT_EXP_EXCHANGE_REINCARNATION, <<Count:32>>) ->
    {ok, [Count]};

read(?PT_REINCARNATION_PURCHASE_GOODS, <<No:8,Count:32>>) ->
    {ok, [No,Count]};

read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.


%秘境
write(?PT_MYSTERIES_OPEN, [Count,No,Difficult]) ->
	Len = erlang:length(Difficult),
    F = fun(State) -> 
        <<State:8>>
    end,
	BinData = list_to_binary([F(X) || X <- Difficult]),
    {ok, pt:pack(?PT_MYSTERIES_OPEN, <<Count:8, No:32, Len:16, BinData/binary >>)};

write(?PT_ENTER_MYSTERIES, [Current,LevelList]) ->
    F = fun(Num) ->
        <<Num:16>>
        end,
    Bin = list_to_binary( [F(X) || X <- LevelList] ),
    Bin2 = <<Current:16,
        (length(LevelList)) : 16,
        Bin / binary
    >>,
    {ok, pt:pack(?PT_ENTER_MYSTERIES, Bin2)};

write(?PT_MYSTERIES_FIGHT_RESULT, [Level,Point,Flag,No]) ->
    {ok, pt:pack(?PT_MYSTERIES_FIGHT_RESULT, <<Level:16, Point:8, Flag:16, No:32>>)};

write(?PT_MYSTERIES_REWARD, [Goods_no,Num]) ->
    {ok, pt:pack(?PT_MYSTERIES_REWARD, <<Goods_no:32, Num:16>>)};

write(?PT_MYSTERIES_TIME_RESET, [Count]) ->
    {ok, pt:pack(?PT_MYSTERIES_TIME_RESET, <<Count:8>>)};

%幻境
write(?PT_MIRAGE_OPEN, [Count,No,Difficult]) ->
    Len = erlang:length(Difficult),
    F = fun(State) ->
        <<State:8>>
        end,
    BinData = list_to_binary([F(X) || X <- Difficult]),
    {ok, pt:pack(?PT_MIRAGE_OPEN, <<Count:8, No:32, Len:16, BinData/binary>>)};

write(?PT_ENTER_MIRAGE, [No,Current,LevelList]) ->
    F = fun(Num) ->
        <<Num:16>>
        end,
    Bin = list_to_binary( [F(X) || X <- LevelList] ),
    Bin2 = <<No:32, Current:16,
        (length(LevelList)) : 16,
        Bin / binary
    >>,
    {ok, pt:pack(?PT_ENTER_MIRAGE, Bin2)};

write(?PT_MIRAGE_FIGHT_RESULT, [Level,Point,Flag,No]) ->
    {ok, pt:pack(?PT_MIRAGE_FIGHT_RESULT, <<Level:16, Point:8, Flag:16, No:32>>)};

write(?PT_MIRAGE_UNLOCK_PANEL_OPEN, [All_count,Count,Level_no]) ->
    {ok, pt:pack(?PT_MIRAGE_UNLOCK_PANEL_OPEN, <<All_count:8, Count:8, Level_no:32>>)};

write(?PT_MIRAGE_TIME_RESET, [Count]) ->
    {ok, pt:pack(?PT_MIRAGE_TIME_RESET, <<Count:8>>)};

write(?PT_MIRAGE_UNLOCK, [Final]) ->
    {ok, pt:pack(?PT_MIRAGE_UNLOCK, <<Final:8>>)};

write(?PT_NOTIFY_TEAM_IN_MIRAGE, [Id]) ->
    {ok, pt:pack(?PT_NOTIFY_TEAM_IN_MIRAGE, <<Id:64>>)};

write(?PT_NOTIFY_TEAM_MESSAGE, [Type, Name]) ->
    F = fun(Para) ->
            case is_integer(Para) of
                true ->
                    TmpPara = list_to_binary(integer_to_list(Para)),
                    <<(byte_size(TmpPara)):16, TmpPara / binary>>;
                false ->
                    case is_list(Para) of
                        true -> <<(byte_size(list_to_binary(Para))):16, (list_to_binary(Para)) /binary>>;
                        false -> <<(byte_size(Para)):16, Para /binary>>
                    end
            end
        end,

    List = lists:map(F, Name),
    Len = length(Name),
    Bin = list_to_binary(List),
    {ok, pt:pack(?PT_NOTIFY_TEAM_MESSAGE, <<Type:8, Len:16, Bin/binary>>)};

write(?PT_NOTIFY_LEADER_LV_NOT_ENOUGH, [Name]) ->
    F = fun(Para) ->
        case is_integer(Para) of
            true ->
                TmpPara = list_to_binary(integer_to_list(Para)),
                <<(byte_size(TmpPara)):16, TmpPara / binary>>;
            false ->
                case is_list(Para) of
                    true -> <<(byte_size(list_to_binary(Para))):16, (list_to_binary(Para)) /binary>>;
                    false -> <<(byte_size(Para)):16, Para /binary>>
                end
        end
        end,

    List = lists:map(F, Name),
    Len = length(Name),
    Bin = list_to_binary(List),
    {ok, pt:pack(?PT_NOTIFY_LEADER_LV_NOT_ENOUGH, <<Len:16, Bin/binary>>)};

write(?PT_NOTIFY_RESET_PANEL, [Flag]) ->
    {ok, pt:pack(?PT_NOTIFY_RESET_PANEL, <<Flag:8>>)};

write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.
