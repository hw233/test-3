%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.11.5
%%% @doc 圣诞活动.
%%% @end
%%%------------------------------------

-module(pt_29).
-export([write/2, read/2]).

-include("common.hrl").
-include("pt_29.hrl").

%%---------------------------------------------
% 290 跑马场
%%---------------------------------------------
%% 跑马场界面信息
read(?PT_HORSE_RACE_INFO, <<>>) ->
    {ok, []};

%% 跑马场竞猜
read(?PT_HORSE_RACE_GAMBLE, <<HorseNo:8, Num:16>>) ->
    {ok, [HorseNo, Num]};

%% 跑马场使用道具 （10sCD时间，前端也做一下预判）
read(?PT_HORSE_RACE_USE_PROP, <<HorseNo:8, PropType:8, Num:32>>) ->
    {ok, [HorseNo, PropType, Num]};

%% 跑马场领取奖励
read(?PT_HORSE_RACE_REWARD, <<RewardType:8>>) ->
    {ok, [RewardType]};

%% 获取各马的支持数
read(?PT_HORSE_RACE_GET_HOSER_GAMBLE_INFO, <<>>) ->
    {ok, []};

%% 购买跑马卷数量
read(?PT_HORSE_RACE_BUY_GOOD, <<GoodNum:16>>) ->
    {ok, [GoodNum]};

read(29101, _) ->
    {ok, []};

read(29102, _) ->
    {ok, []};

read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.

%%---------------------------------------------
% 290 跑马场
%%---------------------------------------------
%% 跑马场界面信息
write(?PT_HORSE_RACE_INFO, [RaceStatus, Time, RankType, Array, RewardNo, RewardNum, FirstHorseNo,IsCanGambel,CurGambelTime]) ->
    Len = length(Array),
    ArrayBin = << <<HorseNo:8, EventNo:8>> || {HorseNo, EventNo} <- Array >>,
    BinData = <<RaceStatus:8, Time:32, RankType:8, Len:16, ArrayBin/binary, RewardNo:8, RewardNum:16, FirstHorseNo:8, IsCanGambel:8, CurGambelTime:8>>,
    {ok, pt:pack(?PT_HORSE_RACE_INFO, BinData)};


%% 跑马场竞猜
write(?PT_HORSE_RACE_GAMBLE, [Code]) ->
    {ok, pt:pack(?PT_HORSE_RACE_GAMBLE, <<Code:8>>)};

%% 跑马场使用道具 （10sCD时间，前端也做一下预判）
write(?PT_HORSE_RACE_USE_PROP, [Code, RoleName, HorseNo, PropType, Num]) ->
    BinName = pt:string_to_binary(RoleName),
    BinData = <<Code:8, BinName/binary, HorseNo:8, PropType:8, Num:32>>,
    {ok, pt:pack(?PT_HORSE_RACE_USE_PROP, BinData)};

%% 跑马场领取奖励
write(?PT_HORSE_RACE_REWARD, [Code]) ->
    {ok, pt:pack(?PT_HORSE_RACE_REWARD, <<Code:8>>)};

%% 获取各马的支持数
write(?PT_HORSE_RACE_GET_HOSER_GAMBLE_INFO, [S1,S2,S3]) ->
    {ok, pt:pack(?PT_HORSE_RACE_GET_HOSER_GAMBLE_INFO, <<S1:32, S2:32, S3:32>>)};

%% 购买跑马卷数量
write(?PT_HORSE_RACE_BUY_GOOD, [Code]) ->
    {ok, pt:pack(?PT_HORSE_RACE_BUY_GOOD, <<Code:8>>)};

write(29101, [Num]) ->
    {ok, pt:pack(29101, <<Num:32>>)};

write(29102, [Num]) ->
    {ok, pt:pack(29102, <<Num:32>>)};

write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.
