%%%------------------------------------
%%% @author liufang
%%% @copyright UCweb 2015.01.07
%%% @doc 年夜宴会活动.
%%% @end
%%%------------------------------------

-module(pt_36).
-export([write/2, read/2]).

-include("common.hrl").
-include("protocol/pt_36.hrl").

%% 进入年夜宴会场景
read(?PT_NEWYEAR_BANQUET_ENTER_SCENE, <<>>) ->
    {ok, []};

%% 退出年夜宴会场景
read(?PT_NEWYEAR_BANQUET_LEAVE_SCENE, <<>>) ->
    {ok, []};

%% 年夜宴会界面信息
read(?PT_GET_NEWYEAR_BANQUET, <<>>) ->
    {ok, []};

%% 年夜宴会加菜
read(?PT_ADD_NEWYEAR_DISHES, <<DishesNo:8, Num:16>>) ->
    {ok, [DishesNo, Num]};

%% 日常充值幸运转盘活动协议
% 幸运转盘信息
read(?PT_ERNIE_INFO, <<>>) ->
    {ok, []};

% 幸运转盘抽奖
read(?PT_ERNIE_GET, <<>>) ->
    {ok, []};

% 通知前端有幸运转盘抽奖次数
read(?PT_ERNIE_NOTIFY, <<>>) ->
    {ok, []};

read(?PT_ENTER_LUCKY_DRAW, <<Type: 8>>) ->
    {ok, [Type]};

read(?PT_GET_LOTTERY_REWARD, <<Step:32>>) ->
    {ok, [Step]};


% 限时转盘玩家排行榜
read(?PT_LUCKY_PLAYER_RANK,<<Type:8>> ) ->
	{ok, [Type] };

read(?PT_LUCKY_RANK_AWARD,<<>>) ->
	{ok, []};

read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.

% 获取年夜宴会面板信息
write(?PT_GET_NEWYEAR_BANQUET, [Banquet_lv, Banquet_exp, Refesh_time, My_dish_num1, My_dish_num2, My_dish_num3, Array1, Array2]) ->
    Len1 = length(Array1),
    Len2 = length(Array2),
    {ok, pt:pack(?PT_GET_NEWYEAR_BANQUET, <<Banquet_lv:8
                         ,Banquet_exp:32
                         ,Refesh_time:32
                         ,My_dish_num1:8
                         ,My_dish_num2:8
                         ,My_dish_num3:8
                         ,Len1:16, (<< <<PlayerId:64,(byte_size(Name)):16,Name/binary,Dish1_num:8,Dish2_num:8,Dish3_num:8>> || {PlayerId,Name,Dish1_num,Dish2_num,Dish3_num,_Time} <- Array1>>)/binary
                         ,Len2:16, (<< <<PlayerId:64,(byte_size(Name)):16,Name/binary,Dish_no:8>> || {PlayerId,Name, Dish_no} <- Array2>>)/binary
                         >>
                     )};

% 年夜宴会加菜
write(?PT_ADD_NEWYEAR_DISHES, [Banquet_lv,Banquet_exp]) ->
    {ok, pt:pack(?PT_ADD_NEWYEAR_DISHES, <<Banquet_lv:8, Banquet_exp:32>>)};

% 通过前端刷新加菜次数
write(?PT_NEWYEAR_BANQUET_REFRESH_ADD_DISH, []) ->
    {ok, pt:pack(?PT_NEWYEAR_BANQUET_REFRESH_ADD_DISH, <<>>)};

%% 日常充值幸运转盘活动协议
% 幸运转盘信息
write(?PT_ERNIE_INFO, [Ernie_times, Array1, Array2]) ->
    % ?ylh_Debug("PT_ERNIE_INFO Ernie_times=~p, Array1=~p, Array2=~p~n", [Ernie_times, Array1, Array2]),
    Len1 = length(Array1), 
    Len2 = length(Array2),
    % F = fun({No, Goods_no, Num, Quality, Bind}) ->
    %         <<No:8,Goods_no:32,Num:32,Quality:8,Bind:8>>
    %     end,
    % Bin = list_to_binary(lists:map(F, Array2)),
    {ok, pt:pack(?PT_ERNIE_INFO, <<Ernie_times:8
                    ,Len1:16, (<< <<PlayerId:64,(byte_size(Name)):16,Name/binary,Goods_no:32,Num:32,Quality:8,Bind:8>> || {PlayerId,Name,Goods_no,Num, Quality,Bind} <- Array1>>)/binary
                    ,Len2:16, (<< <<No:8,Goods_no:32,Num:32,Quality:8,Bind:8,Gain:8>> || {No, Goods_no, Num, Quality, Bind, Gain} <- Array2>>)/binary
                    >>
                    )};

% 幸运转盘抽奖
write(?PT_ERNIE_GET, [Code, No]) ->
    {ok, pt:pack(?PT_ERNIE_GET, <<Code:8, No:8>>)};

% 通知前端有幸运转盘抽奖次数
write(?PT_ERNIE_NOTIFY, [Ernie_times]) ->
    {ok, pt:pack(?PT_ERNIE_NOTIFY, <<Ernie_times:8>>)};

% 限时转盘玩家排行榜
write(?PT_LUCKY_PLAYER_RANK,[RankList]) ->
	Len = length(RankList),
	Bin = list_to_binary([<<Rank:8,(byte_size(Name)):16,Name/binary,Token:32>>|| {_PlayerId, Name, Rank, Token} <-RankList]),
	BinData = <<Len:16,Bin/binary>>,
	{ok, pt:pack(?PT_LUCKY_PLAYER_RANK, BinData)};

write(?PT_GET_LOTTERY_REWARD, [RetCode]) ->
    {ok, pt:pack(?PT_GET_LOTTERY_REWARD, <<RetCode:8>>)};

write(?PT_ENTER_LUCKY_DRAW, [LastFreeEnterTime, Token, Rank, Array]) ->
    Len = length(Array),
    {ok, pt:pack(?PT_ENTER_LUCKY_DRAW, <<LastFreeEnterTime:32, Token:32, Rank:16, Len:16,
        (<< <<No:32>> || No <- Array>>)/binary>>)};

write(?PT_LUCKY_RANK_AWARD, [RankList]) ->
	Len = length(RankList),
	F = fun(X) ->
				{Start, End, Token, GoodsNo} = X,
				GoodsNoLen = length(GoodsNo),
				F2 = fun(X2) ->
						{GoodNo , Count}  = X2,
						<<GoodNo:32,Count:32>>
					 end,
				GoodsNoInfo = list_to_binary([F2(X2) ||  X2 <- GoodsNo]),
				<<Start:8,
				  End:8 ,
				  Token:32,
				  GoodsNoLen:16,GoodsNoInfo/binary
				  >>
		end,
	Bin = list_to_binary([ F(X) || X <-RankList]),
	BinData = <<Len:16,Bin/binary>>,
	{ok, pt:pack(?PT_LUCKY_RANK_AWARD, BinData)};


write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.

    

