%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.11.5
%%% @doc 女妖乱斗.
%%% @end
%%%------------------------------------

-module(pt_28).
-export([write/2, read/2]).

-include("common.hrl").
-include("pt_28.hrl").


%% 乱斗活动报名
read(?PT_MELEE_APPLY, <<>>) ->
    {ok, []};

%% 进入乱斗场景
read(?PT_MELEE_ENTER_SCENE, <<>>) ->
    {ok, []};

%% 退出乱斗场景 （上缴龙珠也发这条）
read(?PT_MELEE_LEAVE_SCENE, <<Type:8>>) ->
    {ok, [Type]};

%% 获取玩家龙珠数量
read(?PT_MELEE_GET_BALL_NUM, <<Id:64>>) ->
    {ok, [Id]};

%% 决斗前获取对方队伍信息（龙珠数量）
read(?PT_MELEE_GET_PK_FORCE_PRE_INFO, <<TargetId:64>>) ->
    {ok, [TargetId]};

read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.

%% 退出乱斗场景 （上缴龙珠也发这条）
write(?PT_MELEE_LEAVE_SCENE, [BallNum]) ->
    {ok, pt:pack(?PT_MELEE_LEAVE_SCENE, <<BallNum:32>>)};

%% 乱斗活动报名
write(?PT_MELEE_APPLY, [Code]) ->
    {ok, pt:pack(?PT_MELEE_APPLY, <<Code:8>>)};


%% 获取玩家龙珠数量
write(?PT_MELEE_GET_BALL_NUM, [Id, Num]) ->
    {ok, pt:pack(?PT_MELEE_GET_BALL_NUM, <<Id:64, Num:8>>)};

%% 掠夺龙珠数量
write(?PT_MELEE_PLUNDER_BALL_NUM, [Id, Type, Num]) ->
    {ok, pt:pack(?PT_MELEE_PLUNDER_BALL_NUM, <<Id:64, Type:8, Num:8>>)};

%% 决斗前获取对方队伍信息（龙珠数量）
write(?PT_MELEE_GET_PK_FORCE_PRE_INFO, [TargetId, BallNumList, Rate]) ->
    Len = length(BallNumList),
    ArrayBin = << <<Num:8>> || Num <- BallNumList >>,
    BinData = <<TargetId:64, Len:16, ArrayBin/binary, Rate:8>>,
    {ok, pt:pack(?PT_MELEE_GET_PK_FORCE_PRE_INFO, BinData)};


write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.
