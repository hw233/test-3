%% =========================================================
%% 29 圣诞活动
%% =========================================================

%%---------------------------------------------
% 290 跑马场
%%---------------------------------------------
-define(PT_HORSE_RACE_INFO, 29000).
%% 跑马场界面信息
%% C >> S :
%%      仅发协议号
%% S >> C
%%      status              u8      比赛状态（0-竞猜阶段 1-比赛阶段 2-比赛结束）   
%%      pass_time           u32     时间（秒） : 阶段开始后到当前的秒数 
%%      rank_type           u8      当前排名类型 （0-12，详情见下方解释）  
%%      array{  事件信息
%%          horse_no        u8      马的编号 （1,2,3）
%%          event_no        u8      事件编号
%%      }
%%      reward_horse_no     u8      中奖的马号（1,2,3  0表示未中奖）
%%      reward_num          u16     中奖的购买数量
%%      first_horse_no      u8      中奖的马号（1,2,3  0表示上一轮刚刚开始，没有中奖马号）
%%      is_can_gamble       u8      是否可以竞猜（1表示可以，0表示不可以）
%%      cur_gamble_num      u8      已经竞猜了多少次（最大不能超过10次）
    
% 排名类型
% 0 : 空
% 1 : 123  1号马先到，接着2号马，然后3号马
% 2 : 132
% 3 : 213
% 4 : 231
% 5 : 312
% 6 : 321
% 7 : 12
% 8 : 21
% 9 : 13
% 10: 31
% 11: 23
% 12: 32

%% 特殊事件
-define(HORSE_EVENT_WING, 1).   % 顺丰而行
-define(HORSE_EVENT_LOSE, 2).   % 迷失方向
-define(HORSE_EVENT_SAVE, 3).   % 养精蓄锐
-define(HORSE_EVENT_RUSH, 4).   % 狂野冲锋
-define(HORSE_EVENT_STRIKE, 5). % 罢赛

-define(PT_HORSE_RACE_GAMBLE, 29001).
%% 跑马场竞猜
%% C >> S :
%%      horse_no            u8      马号
%%      num                 u16     购买数量 （券数）
%% S >> C
%%      code                u8      结果码（0表示成功 失败发送错误tips）

-define(PT_HORSE_RACE_USE_PROP, 29002).
%% 跑马场使用道具 （10sCD时间，前端也做一下预判）
%% C >> S :
%%      horse_no            u8      马号
%%      type                u8      道具类型（1神奇草料 2绊马钉）
%%      num                 u32     道具份数（对应消耗券数）
%% S >> C （全服广播）
%%      code                u8      结果码（0 成功,全服广播贴战报;失败发送错误tips ）
%%      role_name           string  玩家名字
%%      horse_no            u8      马号
%%      type                u8      道具类型（1神奇草料 2绊马钉）
%%      num                 u32     道具份数

-define(HORSE_PROP_GOOD, 1).    % 神奇草料
-define(HORSE_PROP_BAD, 2).     % 绊马钉

-define(PT_HORSE_RACE_REWARD, 29003).
%% 跑马场领取奖励
%% C >> S :
%%      RewardType          u8      奖励类型（1奖励跑马券 2奖励绑银）
%% S >> C
%%      code                u8      结果码（0 成功;失败发送错误tips ）

-define(PT_HORSE_RACE_GET_HOSER_GAMBLE_INFO, 29004).
%% 获取各马的支持数
%% C >> S :
%%      仅发协议号
%% S >> C
%%      surport_num1     u32      1号马支持数
%%      surport_num2     u32      2号马支持数
%%      surport_num3     u32      3号马支持数

-define(PT_HORSE_RACE_BUY_GOOD, 29005).
%% 购买跑马卷
%% C >> S :
%%      good_num        u16     跑马卷数量
%% S >> C
%%      code            u8      结果码（0 成功;失败发送错误tips ）


%%---------------------------------------------
% 291 xxx
%%---------------------------------------------


%% 协议 ： 29101
%% 查询当前雪球数
%% C >> S :
%% S >> C ：
%%  num         u32         


%% 协议 ：29102
%% 提交雪球
%% C >> S :
%% S >> C :
%%  num         u32 
