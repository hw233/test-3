%%%-------------------------------------------------------------------
%%% @author wujiancheng
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. 四月 2019 17:38
%%%-------------------------------------------------------------------
-module(pp_limit_task).
-author("wujiancheng").
-include("pt_56.hrl").
-include("common.hrl").


%% API
-export([handle/3]).


%%--------获取或者更新主界面信息 -------------
handle(?PT_ENTER_LIMIT_TASK, PS, []) ->
  lib_limited_task:get_main_info(player:get_id(PS));

%%--------进入挑战 -------------
handle(?PT_LT_ENTER_TASK, PS, [Index]) ->
  case player:is_in_team(PS) of
    true ->
      lib_send:send_prompt_msg(player:get_id(PS),7001);
    false ->

      try lib_limited_task:start_battle(player:get_id(PS), Index) of
        ok ->
          ok
      catch
        throw: FailReason ->
          lib_send:send_prompt_msg( player:get_id(PS),FailReason)
      end
  end;

%%--------购买挑战次数 -------------
handle(?PT_LT_BUY_TIMES, PS, []) ->
  lib_limited_task:buy_enter_times(player:get_id(PS));


handle(?PT_LT_POINT_REWARD, PS, []) ->
  lib_limited_task:send_rank_and_accumulate(player:id(PS));


handle(?PT_LT_EXTRA_REWARD, PS, []) ->
  lib_limited_task:send_eattach_data(player:id(PS));

%%--------领取累积奖励 -------------
handle(?PT_LT_GET_REWARD, PS, [Index]) ->
  lib_limited_task:receive_attach_reward(player:get_id(PS),Index);

%%--------排行榜数据 -------------
handle(?PT_LT_RANK_DATA, PS, [Index]) ->
  lib_limited_task:get_player_rank_data(player:get_id(PS),Index);

%%--------购买额外奖励资格-------------
handle(?PT_LT_BUY_EXTRA, PS, []) ->
  lib_limited_task:buy_extra_reward(player:get_id(PS));

%%--------领取额外奖励 -------------
handle(?PT_LT_GET_EXTRA_REWARD, PS, [Index]) ->
  lib_limited_task:receive_extra_reward(player:get_id(PS),Index);

%%--------查询额外奖励资格 -------------
handle(?PT_LT_EXTRA_LICENCE, PS, []) ->
  lib_limited_task:check_extra_valid(player:get_id(PS));


handle(_CMD, _, _) ->
  ?ASSERT(false, [_CMD]),
  no_match.




