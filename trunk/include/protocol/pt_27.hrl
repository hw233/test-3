%% =========================================================
%% 27 竞技场协议
%% =========================================================

-define(PT_ARENA_1V1_INFO, 27000).

%% 比武大会状态
%% C >> S :
%%      仅发协议号
%% S >> C
%%      day_wins       u8        日胜利场
%%      day_losts      u8        日败场次
%%      week_wins      u16       周胜场次
%%      week_losts     u16       周败场次

-define(PT_ARENA_1V1_JOIN, 27001).

%% 参加比武大会
%% C >> S :
%%      仅发协议号

-define(PT_ARENA_1V1_LEAVE, 27002).

%% 离开比武大会
%% C >> S :
%%      仅发协议号

-define(PT_ARENA_1V1_READY, 27003).

%% 战斗即将开始
%% S >> C :
%%      id          u64         对方ID
%%      name        string      对方名字
%%      race        u8          对方种族
%%      sex         u8          对方性别
%%      lv          u16         对方等级


-define(PT_ARENA_1V1_REPORTS, 27004).

%% 战报
%% C >> S :
%%      type        u8          类型(个人1, 全局2)
%% S >> C :
%%      type        u8          类型(个人1, 全局2)
%%      array(
%%          win_id      u64         胜方ID
%%          win_name    string      胜方名字
%%          lost_id     u64         负方ID
%%          lost_name   string      负方名字
%%          wins        u16         胜方胜利次数
%%          time        u32         时间
%%      )

-define(PT_ARENA_1V1_WEEK_TOP, 27005).

% C >> S:
%     空协议
% S >> C:
%       uint64     玩家ID
%       string     姓名


%%==========================================================================
%% 3V3比武大会
%%==========================================================================
-define(PT_ARENA_3V3_INFO, 27010).

%% 比武大会状态
%% C >> S :
%%      仅发协议号
%% S >> C
%%      day_wins       u8        日胜利场
%%      day_losts      u8        日败场次
%%      week_wins      u16       周胜场次
%%      week_losts     u16       周败场次
%%      jifen          u16       积分

-define(PT_ARENA_3V3_JOIN, 27011).

%% 参加比武大会
%% C >> S :
%%      仅发协议号
%% S >> C :
%%       code       u8          0表示队长点击匹配，通知队员打开界面;1表示有队员离开，不能继续战斗

-define(PT_ARENA_3V3_LEAVE, 27012).

%% 离开比武大会
%% C >> S :
%%      仅发协议号
%% S >> C :
%%       code       u8          0表示队长点击取消，通知队员可以关闭界面

-define(PT_ARENA_3V3_READY, 27013).

%% 战斗即将开始
%% S >> C :
%%      teamid      u64         对方队伍ID
%%      name        string      对方队伍名字
%%      array(
%%          id          u64         对方ID
%%          name        string      对方名字
%%          race        u8          对方种族
%%          sex         u8          对方性别
%%          lv          u16         对方等级
%%      )

-define(PT_ARENA_3V3_REPORTS, 27014).

%% 战报
%% C >> S :
%%      type        u8          类型(个人1, 全局2)
%% S >> C :
%%      type        u8          类型(个人1, 全局2)
%%      array(
%%          win_id      u64         胜方ID
%%          win_name    string      胜方名字
%%          lost_id     u64         负方ID
%%          lost_name   string      负方名字
%%          wins        u16         胜方胜利次数
%%          time        u32         时间
%%      )

-define(PT_ARENA_3V3_WEEK_TOP, 27015).

% C >> S:
%     空协议
% S >> C:
%       uint64     玩家ID
%       string     姓名