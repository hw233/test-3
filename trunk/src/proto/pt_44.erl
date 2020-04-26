%% @author wujiancheng
%% @doc @todo Add description to pt_44.


-module(pt_44).

-include("common.hrl").
-include("pt_44.hrl").

-export([read/2,write/2]).

read(?PT_GET_WING, <<>>) ->
    {ok,[]};

read(?PT_USE_OR_UNUSE_WING, <<WingId:64, WingNo:32, Num:8>>) ->
    {ok,[WingId, WingNo, Num]};

read(?PT_TRAIN_WING, <<WingId:64, WingNo:32, Feed:8, Count:32>>) ->
    {ok,[WingId, WingNo, Feed, Count]};

read(?PT_NOW_USE_WING, <<>>) ->
    {ok,[]};



read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.



write(?PT_GET_WING, [NowId ,NowNo, WingList, DiyWing]) ->
    Len = erlang:length(WingList),
    F = fun({WingId, WingNo, Lv, Exp, Type}) ->
        NewExp = case  Exp > 1  of
                     true ->
                         Exp -  data_chibang_exp:get(Lv - 1);
                     false ->
                         Exp
                 end,
        <<WingId:64, WingNo:32, Lv:16, NewExp:32, Type:8>>
        end,
    BinData = list_to_binary([F(X) || X <- WingList]),
    Len2 = erlang:length(DiyWing),

    BinWing =
        lists:foldl(
            fun({WingId, WingNo, Lv, Exp, Type, AttrList}, BinAcc) ->
                NewExp = case  Exp > 1  of
                             true ->
                                 Exp -  data_chibang_exp:get(Lv - 1);
                             false ->
                                 Exp
                         end,
                BinAcc2 = <<WingId:64, WingNo:32, Lv:16, NewExp:32, Type:8>>,
                Len3 = erlang:length(AttrList),
                BinAcc3 = lists:foldl(
                    fun(Attr, BinInsideAcc) ->
                        BinInsideAcc2 = << Attr:8>>,
                        <<BinInsideAcc/binary, BinInsideAcc2/binary>>
                    end, <<Len3:16>>, AttrList),
                <<BinAcc/binary,BinAcc2/binary,BinAcc3/binary>>
            end, <<Len2:16>>, DiyWing),
    {ok, pt:pack(?PT_GET_WING, <<NowId:64, NowNo:32, Len:16, BinData/binary, BinWing/binary>>)};


write(?PT_TRAIN_WING, [WingId, WingNo, Lv, Exp]) ->
    {ok, pt:pack(?PT_TRAIN_WING, <<WingId:64, WingNo:32, Lv:16, Exp:32>>)};


write(?PT_NOW_USE_WING, [Type, WingNo]) ->
    {ok, pt:pack(?PT_NOW_USE_WING, <<Type:8, WingNo:32>>)};




write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.
