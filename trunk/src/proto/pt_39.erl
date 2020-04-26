%%%-------------------------------------------------------------------
%%% @author lizhipeng
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. 七月 2018 18:02
%%%-------------------------------------------------------------------
-module(pt_39).

-include("common.hrl").
-include("protocol/pt_39.hrl").
-include("obj_info_code.hrl").
-include("train.hrl").



%% API
-export([read/2, write/2]).

read(?PT_TRAIN_INVENTORY, _) ->
    {ok, []};

read(?PT_START_TRAIN, <<CostType:8,Lv:8>>) ->
    {ok, [CostType,Lv]};

read(?PT_PUTON_ARTS, <<PartnerId:64, ArtsId:64, Index:8>>) ->
    {ok, [PartnerId, ArtsId, Index]};

read(?PT_TAKEOFF_ARTS, <<PartnerId:64, ArtsId:64, Index:8>>) ->
    {ok, [PartnerId, ArtsId, Index]};

read(?PT_DISCARD_ARTS, <<ArtsId:64>>) ->
    {ok, [ArtsId]};

read(?PT_UNLOCK_ART_SLOT, <<PartenrId:64,Lv:16>>) ->
    {ok, [PartenrId,Lv]};


read(?PT_ARTS_INVENTORY, _) ->
    {ok, []};

read(?PT_ARTS_TRANSMIT, <<TargetArtsId:64, Bin/binary>>) ->
    {IdList, _} = pt:read_array(Bin, [u64]),
    {ok, [TargetArtsId, IdList]};

read(?PT_GET_ART_SLOT, <<Bin/binary>>) ->
    {IdList, _} = pt:read_array(Bin, [u64]),
    {ok, [IdList]};

read(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.

write(?PT_GET_ART_SLOT, [Ids]) ->
    Tuples = lists:map(
        fun(Id) ->
            Art = lib_train:get_art_by_id(Id),
            {Id, Art#role_arts.art_no}
        end, Ids),
    Bin = pt:pack_array(Tuples, [u64, u32]),
    {ok, pt:pack(?PT_GET_ART_SLOT, <<Bin/binary>>)};
write(?PT_TRAIN_INVENTORY, [LvTrain, ArtsNum,LiangongBag]) ->
    Bin = pt:pack_array([{A}||A<-LvTrain], [u8]),
    Tuples = lists:map(
        fun(Id) ->
            Art = lib_train:get_art_by_id(Id),
            {Id, Art#role_arts.art_no}
        end, LiangongBag),
    Data = <<Bin/binary, ArtsNum:16, (pt:pack_array(Tuples,[u64, u32]))/binary>>,
    {ok, pt:pack(?PT_TRAIN_INVENTORY, Data)};

write(?PT_START_TRAIN, [ArtId, ArtNo, LvTrain]) ->
    Bin = pt:pack_array([{A}||A<-LvTrain], [u8]),
    {ok, pt:pack(?PT_START_TRAIN, <<ArtId:64, ArtNo:32, Bin/binary>>)};

write(?PT_PUTON_ARTS, [RetCode, PartnerId, ArtsId, Index]) ->
    {ok, pt:pack(?PT_PUTON_ARTS, <<RetCode:8, PartnerId:64, ArtsId:64, Index:8>>)};

write(?PT_TAKEOFF_ARTS, [RetCode, PartnerId, ArtsId, Index]) ->
    {ok, pt:pack(?PT_TAKEOFF_ARTS, <<RetCode:8, PartnerId:64, ArtsId:64,Index:8>>)};

write(?PT_DISCARD_ARTS, [RetCode, ArtId]) ->
    {ok, pt:pack(?PT_DISCARD_ARTS, <<RetCode:8, ArtId:64>>)};

write(?PT_UNLOCK_ART_SLOT, [PartnerId, Lv]) ->
    {ok, pt:pack(?PT_UNLOCK_ART_SLOT, <<PartnerId:64, Lv:16>>)};



write(?PT_ARTS_INVENTORY, [List]) ->
    F = fun({ArtId, ArtNo, PartnerId, BindState, Star, Lv, Exp,Index}) ->
        <<ArtId:64, ArtNo:32, PartnerId:64, BindState:8, Star:8, Lv:16, Exp:16,Index:8>>
        end,
    BinInfo = list_to_binary([F(X) || X <- List]),
    ListLen = length(List),
    Data = <<ListLen:16, BinInfo/binary>>,
    {ok, pt:pack(?PT_ARTS_INVENTORY, Data)};

write(?PT_ARTS_TRANSMIT, [TargetArtsId, RetList]) ->

    Len = length(RetList),
    F = fun(ArtId) ->
        <<ArtId:64>>
        end,

    Bin = list_to_binary([F(X) || X <- RetList]),
    Data = <<TargetArtsId:64, Len:16, Bin/binary>>,
    {ok, pt:pack(?PT_ARTS_TRANSMIT, Data)};

write(?PT_NOTIFY_ARTS_INFO_CHANGE, [ArtId, KV_TupleList]) ->
    ?DEBUG_MSG("------------------------KV_TupleList------------------~p~n", [KV_TupleList]),
    F = fun({ObjInfoCode, Value}) ->
        Value2 = lib_attribute:ajust_value_for_send_to_client(ObjInfoCode, Value),
        ?DEBUG_MSG("------------------------Value------------------~p~n", [Value]),
        ?ASSERT(is_integer(Value2),{ObjInfoCode, Value, Value2}),
        <<ObjInfoCode:8, Value:32>>
        end,
    Bin = list_to_binary([F(X) || X <- KV_TupleList]),
    Bin2 = <<(length(KV_TupleList)):16, Bin/binary>>,
    Bin3 = <<ArtId:64, Bin2/binary>>,
    {ok, pt:pack(?PT_NOTIFY_ARTS_INFO_CHANGE, Bin3)};

write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.

