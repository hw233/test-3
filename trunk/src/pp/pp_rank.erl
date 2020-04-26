%%%-----------------------------------
%%% @Module  : pp_rank
%%% @Author  : mo
%%% @Email   :
%%% @Created : 2014.4
%%% @Description: 排行榜
%%%-----------------------------------

-module(pp_rank).

-include("common.hrl").
-include("record.hrl").
-include("pt_22.hrl").

-export ([handle/3]).

%% 玩家个人榜
%% 女妖排行榜
%% 装备排行榜
%% 竞技场排行榜
handle(Proto, Status, [RankId, Page]) when Proto > 22000 andalso Proto < 22010 ->
    mod_rank:send_rank(Status, RankId, Page),
    ok;

%% 装备详情
handle(?PT_RANK_EQUIP_DETAIL, Status, [GoodsID]) ->
    mod_rank:get_equip_detail(Status, GoodsID),
    ok;

handle(_Cmd, _, _) ->
    ?WARNING_MSG("unknown pp ~p", [_Cmd]),
    error.