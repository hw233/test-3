%%%-------------------------------------------------------------------
%%% @author wjc
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. 四月 2019 18:27
%%%-------------------------------------------------------------------
-module(lib_limited_task).
-author("wujiancheng").

-include("limitedtask.hrl").
-include("pt_56.hrl").
-include("prompt_msg_code.hrl").
-include("record/battle_record.hrl").
-include("battle.hrl").
-include("partner.hrl").
-include("reward.hrl").

%% API
-export([get_main_info/1,handle_limit_task_feedback/2, update_player_data/2,
  start_battle/2, reset_limit_time_task/1,buy_enter_times/1, send_rank_and_accumulate/1,
  receive_attach_reward/2,send_eattach_data/1, buy_extra_reward/1, check_extra_valid/1,
  receive_extra_reward/2,get_rank_player_data/0,get_player_rank_data/2,send_rank_reward/0]).


%限时任务mod_partner:get_fighting_partner_list(player:get_PS(1000100000000541)). lib_limited_task:get_main_info(1000100000000541).  lib_limited_task:enter_challenge(1000100000000541,2).
%%ets:new(ets_limit_time_task_rank, [{keypos, 1}, named_table, public, set]),
%%ets:new(ets_limit_time_task_player,[{keypos, #limited_time_player.player_id}, named_table, public, set]),
%%ets:new(ets_limit_time_task_player_rank_data, [{keypos, #limited_time_rank.player_id}, named_table, public, set]),

%%ets:new(ets_limited_time_data, [{keypos, #limited_time_data.key}, named_table, public, set]),
%%ets:new(ets_limited_time_attach,[{keypos, #limited_time_attach.key}, named_table, public, set]),
%%ets:new(ets_limited_time_eattach, [{keypos, #limited_time_eattach.key}, named_table, public, set]),

%%获取主界面的信息
get_main_info(PlayerId) ->
  case ets:tab2list(ets_limited_time_data) of
    [] ->
      %数据库拿活动数据
      case db:select_row(admin_sys_activity, " origin_content ,end_timestamp, show_panel", [{sys, 16}, {state, 1}]) of
        [] ->
          lib_send:send_prompt_msg( PlayerId,?PM_ERROR_TASK);
        [OriginContent , EndTime, ShowPanel] ->
          case EndTime >= util:unixtime() of
            true ->

              {ok, DataJsonResult, _}= rfc4627:decode(ShowPanel),
              AttachList = util:bitstring_to_term(find("attach", DataJsonResult)),
              F =
                fun(X, Acc) ->
                  [GoodsList, KeyIndex]= Acc,
                  {Point ,GoodsNo , _BindState, Count ,_} = X,
                  [[{KeyIndex, Point, {GoodsNo,Count}}| GoodsList], KeyIndex+1]
                end,
              [AttachGoods, _] = lists:foldl(F,[[],1],AttachList),
              ets:insert(ets_limited_time_attach, #limited_time_attach{key = attach, end_time =EndTime, lists =  AttachGoods } ),
              EattachList = util:bitstring_to_term(find("eattach", DataJsonResult)),
              [EattachGoods, _] = lists:foldl(F,[[],1],EattachList),
              ets:insert(ets_limited_time_eattach, #limited_time_eattach{key = eattach, end_time =EndTime, lists =  EattachGoods } ),
              TaskData = find("taskData", DataJsonResult),
%%          "degree":"2","taskArg":"7788","taskGoodsNo":"89020","taskGoodsNum1":"10","taskGoodsNum2":"20",
%%          "taskMon":"2048","taskScore":"15","taskTitle":"弄死他","taskType":"battle"
              F2 =
                fun(X2, Acc) ->
                  TaskTitle = find("taskTitle", X2),
                  Degree = util:bitstring_to_term( find("degree", X2) ),
                  TaskArg = util:bitstring_to_term( find("taskArg", X2) ),
                  TaskGoodsNo = util:bitstring_to_term( find("taskGoodsNo", X2) ),
                  TaskGoodsNum1 = util:bitstring_to_term( find("taskGoodsNum1", X2) ),
                  TaskGoodsNum2 = util:bitstring_to_term( find("taskGoodsNum2", X2) ),
                  TaskMon = util:bitstring_to_term( find("taskMon", X2) ),
                  TaskScore = util:bitstring_to_term( find("taskScore", X2) ),
                  TaskType = util:bitstring_to_term( find("taskType", X2) ),
                  ets:insert(ets_limited_time_data, #limited_time_data{key = Acc ,task_title = TaskTitle , level =  Degree, arg = TaskArg, end_time = EndTime,task_goods = [TaskGoodsNo, TaskGoodsNum1, TaskGoodsNum2 ],
                    task_Mon = TaskMon, task_score = TaskScore, task_type = TaskType }),
                  Acc +1
                end,
              lists:foldl(F2, 1 ,TaskData),
              %保存排行榜的数据  ets:tab2list(ets_limit_time_task_rank)
              {ok, DataJsonResult2, _}= rfc4627:decode(OriginContent),
              %{"attach":"[[{\"attach\":\"[{10001,3,1}]\",\"integral\":\"1000\",\"rank\":\"{1,1}\"},
              % {\"attach\":\"[{10002,3,1}]\",\"integral\":\"500\",\"rank\":\"{2,5}\"}]]","content":"test","title":"wjctest"}
              RankList = find("attach",DataJsonResult2),
              %  [ [10002,500,{2,5}],[10001,1000,{1,1}] ]
              {ok, [RankList2], _} = rfc4627:decode(RankList),
              F3 = fun(X3,Acc3) ->
                [{PGoodsNo, _,  Count}] = util:bitstring_to_term(find("attach",X3)),
                NeedIntegral =  util:bitstring_to_term(find("integral",X3)),
                Rank =  util:bitstring_to_term(find("rank",X3)),
                [ [{PGoodsNo, Count}, NeedIntegral, Rank]|Acc3 ]
                   end,
              RankData = lists:foldl(F3, [], RankList2),
              MailContent = find("content",DataJsonResult2),
              MailTiTle = find("title",DataJsonResult2),
              ets:insert(ets_limit_time_task_rank, {rank_data, RankData, MailContent, MailTiTle})
          end;
        false ->
          lib_send:send_prompt_msg(PlayerId,?PM_ERROR_TASK)
      end;
    _ ->
      skip

  end,


  TaskAllData = ets:tab2list(ets_limited_time_data),

  case ets:lookup(ets_limit_time_task_player, PlayerId) of
    [] ->
      case db:select_row(limit_task, "point, remain, cost_remain, times, extra_valid, extra_reward, get_reward, unix_time", [{player_id, PlayerId}]) of
        [] ->
          %初始化
          ets:insert(ets_limit_time_task_player, #limited_time_player{player_id = PlayerId, point = 0, remain = 5, cost_remain = 0, times = 0,
                     extra_valid = 0, extra_reward = [], get_reward = []}),
          db:insert(limit_task, [player_id ,point, remain, cost_remain, times, extra_valid, extra_reward, get_reward],
            [PlayerId, 0, 5, 0 ,0 ,0 , util:term_to_bitstring([]), util:term_to_bitstring([])]),
          {ok, Bin} = pt_56:write(?PT_ENTER_LIMIT_TASK,[0, 5, 0,TaskAllData]),
          lib_send:send_to_uid(PlayerId,Bin );
        [Point, Remain, CostRemain, Times, ExtraValid, ExtraReward, GetReward, UnixTime] ->
          ets:insert(ets_limit_time_task_player, #limited_time_player{player_id = PlayerId, point = Point, remain = Remain, cost_remain = CostRemain, times = Times,
            extra_valid =ExtraValid, extra_reward = util:bitstring_to_term(ExtraReward), get_reward = util:bitstring_to_term(GetReward), unix_time = UnixTime }),
          {ok, Bin} = pt_56:write(?PT_ENTER_LIMIT_TASK,[Point, Remain, Times,TaskAllData]),
          lib_send:send_to_uid(PlayerId,Bin )
      end;
    [R] ->
      Point = R#limited_time_player.point, %玩家的分数
      Remain = R#limited_time_player.cost_remain + R#limited_time_player.remain,
      {ok, Bin} = pt_56:write(?PT_ENTER_LIMIT_TASK,[Point, Remain, R#limited_time_player.times, TaskAllData]),
      lib_send:send_to_uid(PlayerId,Bin )
  end.


%GM命令重置次数
reset_limit_time_task(PlayerId) ->
  [R] = ets:lookup(ets_limit_time_task_player, PlayerId),
  update_player_data(R,R#limited_time_player{remain =  5 }).

%% 开始挑战
start_battle(PlayerId , Index) ->
  %判断玩家的次数是否满足
  [PlayerData] = ets:lookup(ets_limit_time_task_player, PlayerId),
  FreeTimes = PlayerData#limited_time_player.remain,
  CostTimes = PlayerData#limited_time_player.cost_remain,
  case (CostTimes + FreeTimes) > 0 of
    true ->
      case player:is_idle(player:get_PS(PlayerId)) of
        true ->
          case ets:lookup(ets_limited_time_data, Index) of
            [] ->
              lib_send:send_prompt_msg(PlayerId,?PM_LIMIT_TASK_BATTLE_TIMEOUT);
            [R] ->
              %如果为1 只需战前做处理即可，不需要新的战斗类型
              BattleType=
                case R#limited_time_data.task_type of
                  timebattle ->
                    %多少回合内胜利
                    ?BTL_SUB_T_TIMEBATTLE;
                  defense ->
                    %坚持多少回合
                    ?BTL_SUB_T_DEFENSE;
                  hurt ->
                    %造成多少伤害
                    ?BTL_SUB_T_HURT;
                  _ ->
                    1
                end,
              case R#limited_time_data.task_type of
                upset ->
                  HaveFight = length(mod_partner:get_fighting_partner_list(player:get_PS(PlayerId))),
                  case HaveFight  =:= R#limited_time_data.arg of
                    true ->
                      skip;
                    false ->
                      throw(?PM_HAVE_FIGHTING_PARTNER)
                  end;
                designatedpet ->
                  PartnerList = mod_partner:get_fighting_partner_list(player:get_PS(PlayerId)),
                  case lists:foldl(fun(PartnerObj,Acc) ->
                    case PartnerObj#partner.no == R#limited_time_data.arg of
                      true ->
                        true ;
                      false ->
                        Acc
                    end
                              end, false, PartnerList)
                  of
                    true ->
                      skip;
                    false ->
                      throw(?PM_HAVE_SPECIAL_PARTNER)
                  end;
                _ ->
                  skip

              end,

              %扣掉次数，有免费先扣免费的
              case FreeTimes > 0 of
                true ->
                  NewPlayerData = PlayerData#limited_time_player{remain =FreeTimes -1, index = Index },
                  update_player_data(PlayerData,NewPlayerData);
                false ->
                  NewPlayerData = PlayerData#limited_time_player{cost_remain =CostTimes -1 , index = Index },
                  update_player_data(PlayerData,NewPlayerData)
              end,
              %进入战斗
              BMonGroupNo = R#limited_time_data.task_Mon,
              mod_battle:start_limited_battle(player:get_PS(PlayerId), BMonGroupNo, BattleType ,fun lib_limited_task:handle_limit_task_feedback/2,Index)

          end;
        false ->
          lib_send:send_prompt_msg( PlayerId,?PM_OFFLINE_ARENA_CHALL_NOT_TIMES)
      end;
    false ->
      lib_send:send_prompt_msg(PlayerId,?PM_HOME_GRID_DO_BAN)
  end.


find(Key, {obj, List}) ->
  {_, Val} = lists:keyfind(Key, 1, List),
  Val.

%% 需要更新玩家数据表的调用这个方法
update_player_data(#limited_time_player{player_id = PlayerId} = OldLimitData, LimitData) ->
  ets:insert(ets_limit_time_task_player,LimitData),
  F =
    fun({RecordIndex, DbFiled}, Acc) ->
      case element(RecordIndex,  OldLimitData) == element(RecordIndex, LimitData) of
        true ->
          Acc;
        false ->
          case lists:member(DbFiled,[extra_reward, get_reward]) of
            true ->
              [{DbFiled, util:term_to_bitstring(element(RecordIndex, LimitData))}|Acc];
            false ->
              [{DbFiled, element(RecordIndex, LimitData)} |Acc]
          end
      end
    end,

  case
    lists:foldl(F , [], [{#limited_time_player.cost_remain, cost_remain}, {#limited_time_player.remain, remain},
      {#limited_time_player.times, times}, {#limited_time_player.point, point}, {#limited_time_player.extra_reward, extra_reward},
      {#limited_time_player.extra_valid, extra_valid}, {#limited_time_player.get_reward, get_reward}, {#limited_time_player.unix_time, unix_time}]) of
    [] ->
      skip;
    DbFiledData ->
      db:update(limit_task,DbFiledData, [{player_id, PlayerId}] )
  end.

%%战斗回调函数
handle_limit_task_feedback(PlayerId, FeedBack) ->
  case FeedBack#btl_feedback.result of
    win ->
      [PlayerData] = ets:lookup(ets_limit_time_task_player, PlayerId),
      Index = PlayerData#limited_time_player.index,
      [TaskData] = ets:lookup(ets_limited_time_data, Index),
      case TaskData#limited_time_data.end_time > 0 of
        true ->
          [TaskGoodsNo, TaskGoodsNum1, TaskGoodsNum2 ] = TaskData#limited_time_data.task_goods,
          Number = case TaskGoodsNum1 >  TaskGoodsNum2 of
                     true ->
                       util:rand(TaskGoodsNum2, TaskGoodsNum1);
                     false ->
                       util:rand(TaskGoodsNum1, TaskGoodsNum2)
                   end,
          mod_inv:batch_smart_add_new_goods(PlayerId, [{TaskGoodsNo, Number}], [{bind_state, 1}], ["lib_limited_task", "win_battle"]),
          Score = TaskData#limited_time_data.task_score,
          update_player_data(PlayerData, PlayerData#limited_time_player{point = (PlayerData#limited_time_player.point +Score), unix_time = util:unixtime()  }),
          FreeTimes = PlayerData#limited_time_player.remain + PlayerData#limited_time_player.cost_remain,
          {ok, Bin} = pt_56:write(?PT_LT_UPDATE_MAIN_DATA,[PlayerData#limited_time_player.point +Score, FreeTimes]),
          lib_send:send_to_uid(PlayerId,Bin );
        false ->
          lib_send:send_prompt_msg( PlayerId,?PM_ERROR_TASK)
      end;

    _ ->
      [PlayerData] = ets:lookup(ets_limit_time_task_player, PlayerId),
      FreeTimes = PlayerData#limited_time_player.remain + PlayerData#limited_time_player.cost_remain,
      {ok, Bin} = pt_56:write(?PT_LT_UPDATE_MAIN_DATA,[PlayerData#limited_time_player.point, FreeTimes]),
      lib_send:send_to_uid(PlayerId,Bin )

  end.

%%购买挑战次数
buy_enter_times(PlayerId) ->
  [PlayerData] = ets:lookup(ets_limit_time_task_player, PlayerId),
  HavaBuyTimes = PlayerData#limited_time_player.times,
  MulCost = HavaBuyTimes * data_special_config:get(reset),
  NeedCost =  data_special_config:get(reset_start) + MulCost,
  case player:has_enough_integral(player:get_PS(PlayerId), NeedCost) of
    true ->
      player:cost_integral(player:get_PS(PlayerId), NeedCost, ["lib_limited_task","buy_enter_times"]),
      update_player_data(PlayerData, PlayerData#limited_time_player{times =HavaBuyTimes +1, cost_remain = (PlayerData#limited_time_player.cost_remain + 3)}),
      {ok, Bin} = pt_56:write(?PT_LT_BUY_TIMES,[PlayerData#limited_time_player.cost_remain + 3, HavaBuyTimes +1]),
      lib_send:send_to_uid(PlayerId,Bin );
    false -> lib_send:send_prompt_msg(PlayerId, ?PM_INTEGRAL_LIMIT)
  end.

%% 发送排行榜信息和累计奖励信息
send_rank_and_accumulate(PlayerId) ->
  [AttachData] = ets:lookup(ets_limited_time_attach, attach ),
  [PlayerData] = ets:lookup(ets_limit_time_task_player, PlayerId),
  HaveGet  = PlayerData#limited_time_player.get_reward,
%%  {Index,Point,GoodsNo}
  AttachList1 = AttachData#limited_time_attach.lists,
  F =
    fun(X, Acc) ->
      {Index, Ponit,{GoodsNo, Count} } = X,
      case lists:member(Index,HaveGet) of
        true ->
          [{Index, Ponit, {GoodsNo, Count}, 1}|Acc];
        false ->
          [{Index, Ponit, {GoodsNo, Count}, 0}|Acc]
      end
    end,
  AttachList12 = lists:foldl(F , [], AttachList1),
  [{rank_data, RankData, _MailContent, _MailTiTle}] = ets:lookup(ets_limit_time_task_rank, rank_data),
%%  [PGoodsNo, NeedIntegral, Rank]
  F2 =
    fun(X2 , Acc2) ->
      [{GoodsNo, Count}, NeedIntegral, {RankFirst, RankEnd}]= X2,
      [{RankFirst ,RankEnd ,{GoodsNo, Count}, NeedIntegral} |Acc2]
    end,
  RankData2 = lists:foldl(F2, [], RankData),

  {ok, Bin}  = pt_56:write(?PT_LT_POINT_REWARD, [AttachList12,RankData2 ]),
  lib_send:send_to_uid(PlayerId,Bin ).

%%领取累计奖励
receive_attach_reward(PlayerId, Index) ->
  [PlayerData] = ets:lookup(ets_limit_time_task_player, PlayerId),
  GetReward = PlayerData#limited_time_player.get_reward,
  IsGet = lists:member(Index, GetReward),
  case IsGet of
    true ->
      lib_send:send_prompt_msg(PlayerId, ?PM_CHAPTER_TARGET_HAD_GET_REWARD);
    false ->
      %判断是否可领取
      Point = PlayerData#limited_time_player.point,
      [AttachData] = ets:lookup(ets_limited_time_attach, attach ),
      AttachList = AttachData#limited_time_attach.lists,
      case lists:keyfind(Index, 1, AttachList) of
        false ->
          lib_send:send_prompt_msg(PlayerId, ?PM_ERROR_TASK);
        {Index, Score, GoodsList} ->
          case Point >= Score of
            true ->
              update_player_data(PlayerData, PlayerData#limited_time_player{get_reward = [Index|GetReward]}),
              mod_inv:batch_smart_add_new_goods(PlayerId, [GoodsList], [{bind_state, 1}], ["lib_limited_task", "receive_attach_reward"]),
              {ok, Bin}  = pt_56:write(?PT_LT_GET_REWARD, [ Index]),
              lib_send:send_to_uid(PlayerId,Bin ),
              lib_send:send_prompt_msg(PlayerId, ?PM_GET_ATTACH_REWARD_SUCCESS);
            false ->
              lib_send:send_prompt_msg(PlayerId, ?PM_GET_ATTACH_REWARD)
          end
      end

  end.

send_eattach_data(PlayerId) ->
  [EAttachData] = ets:lookup(ets_limited_time_eattach, eattach ),
  [PlayerData] = ets:lookup(ets_limit_time_task_player, PlayerId),
  HaveGet  = PlayerData#limited_time_player.extra_reward,
  %%  {Index,Point,GoodsNo}
  EAttachList1 = EAttachData#limited_time_eattach.lists,
  F =
    fun(X, Acc) ->
      {Index, Ponit, PgkGoodNo} = X,
      case lists:member(Index,HaveGet) of
        true ->
          [{Index, Ponit, PgkGoodNo, 1}|Acc];
        false ->
          [{Index, Ponit, PgkGoodNo, 0}|Acc]
      end
    end,
  EAttachList12 = lists:foldl(F , [], EAttachList1),
  {ok, Bin}  = pt_56:write(?PT_LT_EXTRA_REWARD, [EAttachList12 ]),
  lib_send:send_to_uid(PlayerId,Bin ).


%%购买额外的奖励资格
buy_extra_reward(PlayerId) ->
  [PlayerData] = ets:lookup(ets_limit_time_task_player, PlayerId),
  Valid = PlayerData#limited_time_player.extra_valid, %0为没资格，1为有资格
  case Valid =:= 0 of
    true ->
      IntegralCount = data_special_config:get(timetask_exreward),
      case player:has_enough_integral(player:get_PS(PlayerId), IntegralCount) of
        true ->
          player:cost_integral(player:get_PS(PlayerId), IntegralCount, ["lib_luck","start_luck"]),
          update_player_data(PlayerData, PlayerData#limited_time_player{extra_valid = 1}),
          {ok, Bin}  = pt_56:write(?PT_LT_BUY_EXTRA, [0]),
          lib_send:send_to_uid(PlayerId,Bin);

        false -> lib_send:send_prompt_msg(PlayerId, ?PM_INTEGRAL_LIMIT)
      end;
    false ->
      lib_send:send_prompt_msg(PlayerId, ?PM_BUY_EXTRA_REWARD)

  end.

%% 查询是否已购买格外奖励
check_extra_valid(PlayerId) ->
  [PlayerData] = ets:lookup(ets_limit_time_task_player, PlayerId),
  Valid = PlayerData#limited_time_player.extra_valid, %0为没资格，1为有资格
  case Valid =:= 0 of
    true ->
      {ok, Bin}  = pt_56:write(?PT_LT_EXTRA_LICENCE, [1]),
      lib_send:send_to_uid(PlayerId,Bin);
    false ->
      {ok, Bin}  = pt_56:write(?PT_LT_EXTRA_LICENCE, [0]),
      lib_send:send_to_uid(PlayerId,Bin)
  end.


%%领取额外奖励
receive_extra_reward(PlayerId, Index) ->
  [PlayerData] = ets:lookup(ets_limit_time_task_player, PlayerId),
  Valid = PlayerData#limited_time_player.extra_valid,
  case Valid =:= 0 of
    true ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NEED_BUY_EXTRA_REWARD);
    false ->
      GetReward = PlayerData#limited_time_player.extra_reward,
      IsGet = lists:member(Index, GetReward),
      case IsGet of
        true ->
          lib_send:send_prompt_msg(PlayerId, ?PM_CHAPTER_TARGET_HAD_GET_REWARD);
        false ->
          %判断是否可领取
          Point = PlayerData#limited_time_player.point,
          [EAttachData] = ets:lookup(ets_limited_time_eattach, eattach ),
          EAttachList = EAttachData#limited_time_eattach.lists,
          case lists:keyfind(Index, 1, EAttachList) of
            false ->
              lib_send:send_prompt_msg(PlayerId, ?PM_ERROR_TASK);
            {Index, Score, GoodsList} ->
              case Point >= Score of
                true ->
                  update_player_data(PlayerData, PlayerData#limited_time_player{extra_reward =  [Index|GetReward]}),
                  mod_inv:batch_smart_add_new_goods(PlayerId, [GoodsList], [{bind_state, 1}], ["lib_limited_task", "receive_attach_reward"]),
                  {ok, Bin}  = pt_56:write(?PT_LT_GET_EXTRA_REWARD, [ Index]),
                  lib_send:send_to_uid(PlayerId,Bin ),
                  lib_send:send_prompt_msg(PlayerId, ?PM_GET_ATTACH_REWARD_SUCCESS);
                false ->
                  lib_send:send_prompt_msg(PlayerId, ?PM_GET_ATTACH_REWARD)
              end
          end

      end

  end.

%每半个钟读一次数据库，取最新的排行榜数据
get_rank_player_data() ->
  DBSQL = "SELECT player_id, POINT, unix_time FROM limit_task WHERE POINT > 0  ORDER BY POINT DESC LIMIT 30",

  case db:select_all(limit_task, DBSQL) of
    [] ->ets:insert(ets_limit_time_task_player_rank_data,{rank_data, []});
    DataList ->
      %存到ets
      F =
        fun(X, Acc) ->
          [PlayerId, Point, UnixTime] = X,
          Name = player:get_name(PlayerId),
          [AccList,Rank]= Acc,
          [[{PlayerId,Rank, Name, Point ,UnixTime}|AccList], Rank+ 1]
        end,
      [RankData, _] = lists:foldl(F, [[],1] ,DataList),
      ets:insert(ets_limit_time_task_player_rank_data,{rank_data, RankData})
  end.



%获取玩家排行榜数据
get_player_rank_data(PlayerId,Index) ->
  case ets:lookup(ets_limit_time_task_player_rank_data, rank_data) of
    [] ->
      {ok, Bin}  = pt_56:write(?PT_LT_RANK_DATA, [[],0]),
      lib_send:send_to_uid(PlayerId,Bin );
    [{rank_data, DataList}] ->
      MyRank = case lists:keyfind(PlayerId,1,DataList) of
                 false ->
                   0;
                 {_, Rank, _, _, _ } ->
                   Rank
               end,

      Size = (Index -1) * 10 + 1,
      RankList =
        case length(DataList) >= Size  of
          true ->lists:sublist(lists:reverse(DataList), Size, 10);
          false ->[]
        end,
      {ok, Bin}  = pt_56:write(?PT_LT_RANK_DATA, [RankList,MyRank]),
      lib_send:send_to_uid(PlayerId,Bin )
  end.

%发送排名奖励，并且清掉排名的数据,重置玩家的分数 lib_limited_task:send_rank_reward()
send_rank_reward() ->
  [{rank_data, RankData2, MailContent, MailTiTle}] = ets:lookup(ets_limit_time_task_rank, rank_data),
  get_rank_player_data(),%刷新排行榜
  [{rank_data, RankDataPlayer}] = ets:lookup(ets_limit_time_task_player_rank_data, rank_data),
  ets:delete_all_objects(ets_limited_time_data),
  ets:delete_all_objects(ets_limited_time_attach),
  ets:delete_all_objects(ets_limited_time_eattach),
  ets:delete_all_objects(ets_limit_time_task_rank),
  RankData  = lists:reverse(RankData2),
  F =
    fun(X) ->
      {PlayerId,RankPlayer, _Name, Point ,_UnixTime} = X,
      F2 =
        fun(X2,Acc) ->
          [GoodsList, NeedIntegral, {Rank1,Rank2}] = X2,
          %清除分数，剩余的次数，重置次数
          db:update(limit_task,[{point,0},{remain,5},{cost_remain, 0}, {times, 0}, {extra_valid, 0},
            {extra_reward, util:term_to_bitstring([])}, {get_reward, util:term_to_bitstring([])},{last_rank_data,util:term_to_bitstring([RankPlayer,Point]) }], [{player_id, PlayerId}]),
          ets:insert(ets_limit_time_task_player, #limited_time_player{player_id = PlayerId, point = 0, remain = 5, cost_remain = 0, times = 0,
            extra_valid = 0, extra_reward = [], get_reward = []}),
          case  Rank2 >= RankPlayer  andalso Point >= NeedIntegral  andalso Acc =:= 0 of
            true ->
              {GoodsNo ,Count} = GoodsList ,
              GoodsList2 = [{GoodsNo ,3 ,Count}],
              lib_mail:send_sys_mail(PlayerId, MailTiTle, MailContent, GoodsList2, ["lib_limited_task", "recv_board"]),
              1;
            false ->
              0
          end
        end,
      lists:foldl(F2,0,RankData)
    end,

  lists:foreach(F,RankDataPlayer).



















