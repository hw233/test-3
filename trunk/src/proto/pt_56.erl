%%%-------------------------------------------------------------------
%%% @author wujiancheng
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. 四月 2019 18:06
%%%-------------------------------------------------------------------
-module(pt_56).
-author("wujiancheng").

-include("pt_56.hrl").

-include("common.hrl").
-include("limitedtask.hrl").

%% API
-export([read/2, write/2]).

read(?PT_ENTER_LIMIT_TASK, _) ->
  {ok ,[]};

read(?PT_LT_ENTER_TASK, <<Index:8>>) ->
  {ok ,[Index ]};

read(?PT_LT_BUY_TIMES, _) ->
  {ok ,[]};

read(?PT_LT_POINT_REWARD, _) ->
  {ok ,[]};


read(?PT_LT_GET_REWARD, <<Index:8>>) ->
  {ok ,[Index ]};

read(?PT_LT_EXTRA_REWARD, _) ->
  {ok ,[]};

read(?PT_LT_BUY_EXTRA, _) ->
  {ok ,[]};

read(?PT_LT_EXTRA_LICENCE, _) ->
  {ok ,[]};

read(?PT_LT_GET_EXTRA_REWARD,  <<Index:8>>) ->
  {ok ,[Index]};

read(?PT_LT_RANK_DATA, <<Index:8>>) ->
  {ok ,[Index]};





read(_Cmd, _R) ->
  ?ASSERT(false, {_Cmd, _R}),
  {error, not_match}.



%%      point           u32     		玩家分数
%%      array{
%%          key            u8           唯一值
%%      	  level          u8  		    难度
%%          content        string       挑战描述
%%          point          u32          分数
%%          goodsno        u32          物品编号
%%		}
%%      remain         	   u8      		剩余次数
%%      reset_times		   u8           今天已经重置的次数

write(?PT_ENTER_LIMIT_TASK,[Point, Remain,ResetTimes, TaskDataList]) ->
  Len  = length(TaskDataList),
  F =
    fun(X , Acc) ->
      Content = tool:to_binary(X#limited_time_data.task_title),
      Size =  byte_size(Content),
      Key = X#limited_time_data.key,
      Level = X#limited_time_data.level,
      Score = X#limited_time_data.task_score,
      [GoodsNo , _ , _] = X#limited_time_data.task_goods,
      [<< Key:8, Level:8,
        Size:16, Content/binary, Score:32,
      GoodsNo:32 >>| Acc]
    end,
  BinData  = list_to_binary(lists:foldl(F, [] , TaskDataList)),
  Data = <<Point:32,Len:16,BinData/binary, Remain:8, ResetTimes:8>>,
  {ok, pt:pack(?PT_ENTER_LIMIT_TASK, Data)};


write(?PT_LT_UPDATE_MAIN_DATA,[Point, FreeTimes]) ->
  Data = <<Point:32, FreeTimes:8>>,
  {ok, pt:pack(?PT_LT_UPDATE_MAIN_DATA, Data)};

write(?PT_LT_BUY_TIMES,[FreeTimes, HaveResetTimes]) ->
  Data = <<FreeTimes:8, HaveResetTimes:8>>,
  {ok, pt:pack(?PT_LT_BUY_TIMES, Data)};

write(?PT_LT_POINT_REWARD,[AttachLists, RankLists]) ->
  Len1 = length(AttachLists),
  F =
    fun({Index, Ponit,{PgkGoodNo, Count} , IsGet}, Acc) ->
      [<< Index:8, Ponit:32, PgkGoodNo:32,Count:8, IsGet:8 >>|Acc]
    end,
  BinData1  = list_to_binary(lists:foldl(F, [], AttachLists)),
  Len2 = length(RankLists),

%%
%%  < RankLists = [{1,1,10001,1000},{2,5,10002,500}]
%%< AttachLists = [{1,20,89005,0},{2,50,89006,0}]

F2 =
    fun({Rankfirst, Rankend, {PgkGoodNo, Count}, Point}, Acc2) ->
      [<< Rankfirst:16, Rankend:16, PgkGoodNo:32, Count:8, Point:32 >>|Acc2]
    end,
  BinData2  = list_to_binary(lists:foldl(F2, [], RankLists)),
  Data = <<Len1:16,BinData1/binary, Len2:16,BinData2/binary>>,
  {ok, pt:pack(?PT_LT_POINT_REWARD, Data)};


write(?PT_LT_GET_REWARD,[Index]) ->
  Data = <<Index:8>>,
  {ok, pt:pack(?PT_LT_GET_REWARD, Data)};



%%      array{
%%          Index          u8       奖励编号
%%			    point		       u32			所需分数
%%          goods_no       u32			奖励包编号
%%          is_get         u8       当前是否已领取 0是未领取/1是已领取
%%		}
write(?PT_LT_EXTRA_REWARD,[EAttachLists]) ->
  Len = length(EAttachLists),
  F =
    fun({Index, Ponit, {GoodsNo, Count}, IsGet}, Acc) ->
      [<< Index:8, Ponit:32, GoodsNo:32, Count:8 , IsGet:8 >>|Acc]
    end,
  BinData  = list_to_binary(lists:foldl(F, [], EAttachLists)),
  Data = <<Len:16,BinData/binary>>,
  {ok, pt:pack(?PT_LT_EXTRA_REWARD, Data)};


write(?PT_LT_BUY_EXTRA,[Result]) ->
  Data = <<Result:8>>,
  {ok, pt:pack(?PT_LT_BUY_EXTRA, Data)};

write(?PT_LT_EXTRA_LICENCE,[Result]) ->
  Data = <<Result:8>>,
  {ok, pt:pack(?PT_LT_EXTRA_LICENCE, Data)};

write(?PT_LT_GET_EXTRA_REWARD,[Index]) ->
  Data = <<Index:8>>,
  {ok, pt:pack(?PT_LT_GET_EXTRA_REWARD, Data)};


%% 协议号:56008
%% c >> s:
%% s >> c:
%%      array{
%%			rank		   u8		   	排名
%%			name		   string		名字
%%			point		   u32			分数
%%			time		   u32			到达的时间戳
%%		}
%%		rank		   u8			我的排名 0为榜外
%%		time		   u32		到达的时间戳

write(?PT_LT_RANK_DATA,[RankData, MyRank]) ->
  Len = length(RankData),
  F =
    fun({_PlayerId,Rank,Name, Point, Time}, Acc) ->
      Size = byte_size(Name),
      [<< Rank:8, Size:16, Name/binary, Point:32,
        Time:32 >>|Acc]
    end,
  BinData = list_to_binary(lists:reverse(lists:foldl(F, [], RankData))),
  BinData2 = <<Len:16,BinData/binary, MyRank:8>>,
  {ok, pt:pack(?PT_LT_RANK_DATA, BinData2)};


write(_Cmd, _R) ->
  ?ASSERT(false, {_Cmd, _R}),
  %%%{ok, pt:pack(0, <<>>)}.
  {error, not_match}.


