%%%-------------------------------------------------------------------
%%% @author yinweipei
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. 四月 2019 16:39
%%%-------------------------------------------------------------------
-module(pp_mystery).

%% API
-export([handle/3]).

-include("common.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("pt_50.hrl").

%%--------打开大秘境 -------------
handle(?PT_MYSTERIES_OPEN, PS, []) ->
    lib_mystery:mystery_open(player:get_id(PS));

%%-----------进入哪个大秘境关卡---------
handle(?PT_ENTER_MYSTERIES, PS, [No]) ->
    lib_mystery:enter_mystery(player:get_id(PS),No);

%%-----------进入大秘境第几关---------
handle(?PT_PLAY_ON_MYSTERIES, PS, [No]) ->
    lib_mystery:play_on_mystery(player:get_id(PS), No);

%%-----------大秘境通关翻牌奖励---------
handle(?PT_MYSTERIES_REWARD, PS, []) ->
    lib_mystery:get_flop_rewards(player:get_id(PS));

%%-------------秘境重置-------------
handle(?PT_MYSTERIES_TIME_RESET, PS, []) ->
    lib_mystery:reset_mystery(player:get_id(PS), 1);

%%-------------------幻境部分------------------------

%%-----------打开幻境界面---------
handle(?PT_MIRAGE_OPEN, PS, []) ->
    lib_mystery:mirage_open(player:get_id(PS));

%%-----------进入哪个幻境关卡---------
handle(?PT_ENTER_MIRAGE, PS, [No]) ->
    lib_mystery:enter_mirage(player:get_id(PS), No);

%%-----------进入幻境第几关---------
handle(?PT_PLAY_ON_MIRAGE, PS, [No]) ->
    lib_mystery:play_on_mirage(player:get_id(PS), No);

%%-----------秘境/幻境重置---------
handle(?PT_MIRAGE_TIME_RESET, PS, []) ->
    lib_mystery:reset_mystery(player:get_id(PS), 2);

%%-------------幻境解锁-------------
handle(?PT_MIRAGE_UNLOCK, PS, [Level_no]) ->
    lib_mystery:unlock_mirage(player:get_id(PS), Level_no);

%%-------------通知队员进入幻境-------------
handle(?PT_NOTIFY_TEAM_MESSAGE, PS, [Agree]) ->
    lib_mystery:confirm_enter_mirage(player:get_id(PS), Agree);

%%-------------关闭幻境面板-------------
handle(?PT_MIRAGE_CLOSE, PS, []) ->
    lib_mystery:mirage_close(player:get_id(PS));

%%-------------开启转生-------------
handle(?PT_START_REINCARNATION, PS, []) ->
    lib_mystery:start_rein(PS);

%%-------------经验兑换转生货币-------------
handle(?PT_EXP_EXCHANGE_REINCARNATION, PS, [Count]) ->
    lib_mystery:exp_exchange_rein(PS, Count);

%%-------------经验兑换转生货币-------------
handle(?PT_REINCARNATION_PURCHASE_GOODS, PS, [No,Count]) ->
    lib_mystery:rein_purchase_goods(PS, No, Count);


%% desc: 容错
handle(_Cmd, _PS, _Data) ->
    ?DEBUG_MSG("pp_mystery no match", []),
    {error, "pp_mystery no match"}.