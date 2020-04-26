%% =========================================================
%% 28 女妖乱斗活动
%% =========================================================


-define(PT_MELEE_APPLY, 28001).
%% 乱斗活动报名
%% C >> S :
%%      仅发协议号
%% S >> C
%%      code          u8        结果码 （0表示成功，成功则弹窗选择是否立即前往； 失败情况不返回，直接发错误信息协议）

-define(PT_MELEE_ENTER_SCENE, 28002).
%% 进入乱斗场景
%% C >> S :
%%      仅发协议号

-define(PT_MELEE_LEAVE_SCENE, 28003).
%% 退出乱斗场景 （上缴龙珠也发这条）
%% C >> S :
%%      type        u8     类型(0：上交龙珠但不退出场景，1：上交并退出)
%% S >> C :
%%      ball_num    u32      龙珠数量

-define(PT_MELEE_GET_BALL_NUM, 28004).
% 获取玩家龙珠数量
%% C >> S :
%%      id          u64     玩家Id
%% S >> c :
%%      id          u64     玩家Id
%%      ball_num    u8      龙珠数量

-define(PT_MELEE_PLUNDER_BALL_NUM, 28005).
% 掠夺龙珠数量  -- 客户端同步增加或者扣除数量，是自己的变化则并弹提示信息“您（得到）失去x个龙珠”
%% S >> C :
%%      id                      u64     玩家id (是自己的话要弹提示)
%%      type                    u8      掠夺类型（1掠夺 2被掠夺 3从怪物身上掠夺）
%%      ball_num                u8      龙珠数量

-define(PT_MELEE_GET_PK_FORCE_PRE_INFO, 28006).
% 决斗前获取对方队伍信息（龙珠数量）
%% C >> S :
%%      target_player_id        u64     目标玩家Id
%% S >> C : 
%%      target_player_id        u64     目标玩家Id 
%%      array{  队伍中持有龙珠数量
%%          ball_num            u8      龙珠数量
%%      }
%%      rate                    u8      掠夺成功概率（0-100） 












