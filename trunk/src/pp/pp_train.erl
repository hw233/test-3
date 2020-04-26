%%%-------------------------------------------------------------------
%%% @author lizhipeng
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. 七月 2018 18:37
%%%-------------------------------------------------------------------
-module(pp_train).
-include("train.hrl").
-include("debug.hrl").
-include("ets_name.hrl").
-include("record.hrl").
-include("common.hrl").
-include("protocol/pt_39.hrl").

%% API
-export([handle/3]).

%% 获取练功房总览信息
handle(?PT_TRAIN_INVENTORY, PS, _) ->
    mod_train:get_train_info(PS),
    ok;

%% 玩家练功请求
handle(?PT_START_TRAIN, PS, [CostType, Lv]) ->
    mod_train:evolve_train_with_money(PS,CostType, Lv),
    ok;

%% 获取内功详细信息
handle(?PT_ARTS_INVENTORY, PS, _) ->
    RoleArtsList = lib_train:get_arts_by_role(),
%%    ?DEBUG_MSG("-----------RoleArtsList-------------~p", [RoleArtsList]),
    LinshiBag = lib_train:get_linshi_arts(),
    F = fun(RoleArt, ArtsAcc) ->
            #role_arts{
                id = Id,
                art_no =  ArtNo,
                partner_id = PartnerId,
                bind_state = BindState,
                star = Star,
                lv = Lv,
                exp = Exp,
                pos = Index
            } = RoleArt,
            [{Id, ArtNo, PartnerId, BindState, Star, Lv, Exp,Index} | ArtsAcc]
        end,
    RoleArtsData0 = lists:foldl(F, [], RoleArtsList),
    RoleArtsData = [In|| In <- RoleArtsData0, lists:member(element(1,In), LinshiBag) /= true],
%%    ?DEBUG_MSG("-----------RoleArtsData-------------~p", [RoleArtsData]),
    {ok, BinData} = pt_39:write(?PT_ARTS_INVENTORY, [RoleArtsData]),
    lib_send:send_to_sock(PS, BinData);

%% 玩家脱下内功
handle(?PT_TAKEOFF_ARTS, PS, [PartnerId, ArtId, Index]) ->
    case PartnerId =:= 0 of
        true ->
            case mod_train:takeoff_art(for_player, PS, ArtId, Index) of
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PS, Reason);
                {ok, ResCode, ArtId} ->
                    {ok, BinData} = pt_39:write(?PT_TAKEOFF_ARTS, [ResCode, PartnerId, ArtId,Index]),
                    lib_send:send_to_sock(PS, BinData)
            end;
        false ->
            case mod_train:takeoff_art(for_partner, PS, PartnerId, ArtId, Index) of
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PS, Reason);
                {ok, ResCode, ArtId} ->
                    {ok, BinData} = pt_39:write(?PT_TAKEOFF_ARTS, [ResCode, PartnerId, ArtId,Index]),
                    lib_send:send_to_sock(PS, BinData)
            end,
            ok
    end;

%% 玩家佩戴内功
handle(?PT_PUTON_ARTS, PS, [PartnerId, ArtId, Index]) ->
    case PartnerId =:= 0 of
        true ->
            case mod_train:puton_art(for_player, PS, ArtId, Index) of
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PS, Reason);
                {ok, _RoleArt} ->
                    {ok, BinData} = pt_39:write(?PT_PUTON_ARTS, [?RES_OK, PartnerId, ArtId, Index]),
                    lib_send:send_to_sock(PS, BinData)
            end;
        false ->
            case mod_train:puton_art(for_partner, PS, PartnerId, ArtId, Index) of
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PS, Reason);
                {ok, _RoleArt} ->
                    {ok, BinData} = pt_39:write(?PT_PUTON_ARTS, [?RES_OK, PartnerId, ArtId, Index]),
                    lib_send:send_to_sock(PS, BinData)
            end
    end;

%% 玩家丢弃内功
%%handle(?PT_DISCARD_ARTS, PS, [ArtId]) ->
%%    case lib_train:get_art_by_id(ArtId) of
%%        null ->
%%            ?ASSERT(false, ArtId),
%%            skip;
%%        RoleArt when RoleArt#role_arts.bind_state =:= 0->
%%            lib_train:del_artno_in_dict(RoleArt#role_arts.id),
%%            lib_train:del_role_arts(RoleArt),
%%            lib_train:db_delete_arts(RoleArt),
%%            {ok, BinData} = pt_39:write(?PT_DISCARD_ARTS, [?RES_OK, ArtId]),
%%            lib_send:send_to_sock(PS, BinData)
%%    end;


handle(?PT_UNLOCK_ART_SLOT, PS, [PartnerId, Lv]) ->
    lib_train:set_art_slot(lib_partner:get_partner(PartnerId),player:id(PS),Lv);



%% 内功升级
handle(?PT_ARTS_TRANSMIT, PS, [TargetArtId, IdList]) ->
    ?DEBUG_MSG("-----------------------------IdList-------------------------~n~p", [IdList]),
    case mod_train:art_transmit(PS, TargetArtId, IdList) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_39:write(?PT_ARTS_TRANSMIT, [TargetArtId, IdList]),
            lib_send:send_to_sock(PS, BinData)
    end;

%% 内功拾取
handle(?PT_GET_ART_SLOT, PS, [IdList]) ->
    lib_train:get_art_slot(IdList, PS);

handle(_Cmd, _Status, _) ->
    ?ASSERT(false, [_Cmd]),
    not_match.
