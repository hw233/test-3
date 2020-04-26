%%%-----------------------------------
%%% @Module  : pp_sprd
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.8.6
%%% @Description: 推广系统
%%%-----------------------------------
-module(pp_sprd).
-export([handle/3
		]).

-include("debug.hrl").
-include("pt_35.hrl").
-include("player.hrl").


-define(REQ_BUILD_SPRD_RELA_CD, 2500).  % 请求建立推广关系的冷却时间（单位：毫秒）


handle(?PT_QRY_MY_SPRD_INFO, PS, _) ->
    case ply_sprd:get_sprd_info(PS) of
        null ->
            ?ASSERT(false),
            skip;
        SprdInfo ->
            {ok, Bin} = pack_sprd_info(SprdInfo),
            lib_send:send_to_sock(PS, Bin)
    end,
    void;

handle(?PT_REQ_BUILD_SPRD_RELA, PS, TargetSprdCode) ->
    TimeNow = util:longunixtime(),
    TimeElapsed = TimeNow - get_last_req_build_sprd_rela_time(),
    % 由于协议的处理涉及数据库的操作，故检测间隔
    case TimeElapsed < ?REQ_BUILD_SPRD_RELA_CD of
        true ->
            skip;
        false ->
            set_last_req_build_sprd_rela_time(TimeNow),
            ply_sprd:req_build_sprd_rela(PS, TargetSprdCode)
    end,
    void;

handle(_Cmd, _PS, _Data) ->
    ?ASSERT(false, _Cmd),
    {error, not_match}.






%% --------------------------------------------

pack_sprd_info(SprdInfo) ->
    pt_35:write(?PT_QRY_MY_SPRD_INFO, SprdInfo).




get_last_req_build_sprd_rela_time() ->
    case erlang:get(?PDKN_LAST_REQ_BUILD_SPRD_RELA_TIME) of
        undefined ->
            0;
        Time ->
            Time
    end.

set_last_req_build_sprd_rela_time(Time) ->
    erlang:put(?PDKN_LAST_REQ_BUILD_SPRD_RELA_TIME, Time).