%%%------------------------------------
%%% @author 
%%% @copyright UCweb 2014.12.10
%%% @doc 
%%% @end
%%%------------------------------------

-module(pt_34).
-export([write/2, read/2]).

-include("common.hrl").
-include("pt_34.hrl").


read(?PT_AD_GET_GOODS, _) ->
    {ok, []};


read(?PT_AD_GIVE_GIFT, <<PlayerId:64, BlessingNo:32, Type:8>>) ->
    {ok, [PlayerId, BlessingNo, Type]};    



read(?PT_AD_GET_GIFT, _) ->
    {ok, []};


read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.




write(?PT_AD_GET_GOODS, [RetCode]) ->
    {ok, pt:pack(?PT_AD_GET_GOODS, <<RetCode:8>>)};      



write(?PT_AD_GIVE_GIFT, [RetCode, Type]) ->
    {ok, pt:pack(?PT_AD_GIVE_GIFT, <<RetCode:8, Type:8>>)};      


write(?PT_AD_GET_GIFT, [RetCode]) ->
    {ok, pt:pack(?PT_AD_GET_GIFT, <<RetCode:8>>)};      


write(?PT_AD_SHOW_BRESS, [BlessingNo, FromPlayerId, FromPlayerName]) ->
    {ok, pt:pack(?PT_AD_SHOW_BRESS, <<BlessingNo:32, FromPlayerId:64, (byte_size(FromPlayerName)):16, FromPlayerName/binary>>)};          


write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.
