%%%-----------------------------------
%%% @Module  : pt_35
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.8.6
%%% @Description: 推广系统
%%%-----------------------------------
-module(pt_35).
-export([read/2, write/2]).

-include("common.hrl").
-include("pt_35.hrl").
-include("debug.hrl").
-include("pt.hrl").
-include("sprd.hrl").
-include("offline_data.hrl").

%%
%%客户端 -> 服务端 ----------------------------
%%

read(?PT_QRY_MY_SPRD_INFO, _) ->
    {ok, dummy};


read(?PT_REQ_BUILD_SPRD_RELA, Bin) ->
    {TargetSprdCode, _} = pt:read_string(Bin),
    {ok, TargetSprdCode};


read(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.




%%
%%服务端 -> 客户端 ------------------------------------
%%

write(?PT_QRY_MY_SPRD_INFO, SprdInfo) ->
    Bin1 = build_sprdee_list_info_bin(SprdInfo),
    Bin2 = build_sprder_info_bin(SprdInfo),
    SprdCode_BS = list_to_binary(SprdInfo#sprd.code),
    Bin3 =  <<
                Bin1 / binary,
                ?P_BITSTR(SprdCode_BS),
                Bin2 / binary
            >>,
    {ok, pt:pack(?PT_QRY_MY_SPRD_INFO, Bin3)};

write(?PT_NOTIFY_NEW_SPRD_RELA_BUILDED, [SprderId, SprdeeId]) ->
    Bin1 = build_one_sprd_player_info_bin(SprderId),
    Bin2 = build_one_sprd_player_info_bin(SprdeeId),
    Bin3 =  <<
                Bin1 / binary,
                Bin2 / binary
            >>,
    {ok, pt:pack(?PT_NOTIFY_NEW_SPRD_RELA_BUILDED, Bin3)};

write(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.









%% ======================================================================

build_sprdee_list_info_bin(SprdInfo) ->
    SprdeeList = SprdInfo#sprd.sprdee_list,
    F = fun(SprdeeId) ->
            build_one_sprd_player_info_bin(SprdeeId)
        end,
    BinInfoL = [F(X) || X <- SprdeeList],
    BinInfo = list_to_binary(BinInfoL),
    <<(length(BinInfoL)):16, BinInfo/binary>>.


build_sprder_info_bin(SprdInfo) ->
    case SprdInfo#sprd.sprder_id of
        ?INVALID_ID ->
            build_dummy_sprd_player_info_bin();
        _ ->
            build_one_sprd_player_info_bin(SprdInfo#sprd.sprder_id)
    end.


build_one_sprd_player_info_bin(PlayerId) ->
    case player:is_online(PlayerId) of
        true ->
            PS = player:get_PS(PlayerId),
            Name = player:get_name(PS),
            <<
                PlayerId : 64,
                (player:get_race(PS)) : 8,
                (player:get_sex(PS)) : 8,
                ?P_BITSTR(Name),
                (player:get_lv(PS)) : 8
            >>;
        false ->
            case mod_offline_data:get_offline_role_brief(PlayerId) of
                null ->
                    ?ASSERT(false, PlayerId),
                    build_dummy_sprd_player_info_bin();
                Brf ->
                    Name = Brf#offline_role_brief.name,
                    <<
                        PlayerId : 64,
                        (Brf#offline_role_brief.race) : 8,
                        (Brf#offline_role_brief.sex) : 8,
                        ?P_BITSTR(Name),
                        (Brf#offline_role_brief.lv) : 8
                    >>
            end
    end.



build_dummy_sprd_player_info_bin() ->
    <<
        0 : 64,
        0 : 8,
        0 : 8,
        ?P_BITSTR(<<"">>),
        0 : 8
    >>.