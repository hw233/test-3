%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com> and zhangwq
%%% @copyright UCweb 2014.12.9
%%% @doc 结婚系统协议设计.
%%% @end
%%%------------------------------------

-define(PT_COUPLE_APPLY_MARRIAGE, 33000).
%% 申请结婚 
%% C >> S :
%%      type        u8      结婚类型（）
%% S >> C
%%      code        u8      结果码(0 成功，并向对方发送求婚协议)

-define(PT_COUPLE_ASK_MARRIAGE, 33001).
%% 求婚
%% S >> C
%%      ObjPlayerName   string          对方名字

-define(PT_COUPLE_RESPOND_MARRIAGE, 33002).
%% 回应求婚
%% C >> S
%%      respond     u8      (1-yes 2-no)

-define(YES_I_DO, 1).                  % 同意求婚
-define(YOU_ARE_A_GOOD_PERSON, 2).     % 拒绝求婚（你是个好人）


-define(PT_COUPLE_MARRIAGE_BROADCAST, 33003).
%% 结婚广播 （只发给结婚当事人）
%% S >> C
%%      Type        u8      婚礼类型 读表
%%      id1         u64     Id1
%%      id2         u64     Id2


%% ---------- 查询夫妻技能 (如果没有结婚,则返回空)-----------------
-define(PT_COUPLE_QUERY_SKILL_INFO, 33005).

%% 协议号: 33005
%% c >> s:
%%     无

%% s >> c:
%%     array(                       
%%            SkillId               u32     id
%%            State                 u8      状态 0 表示未学习,1表示已经学习
%%          )


%% ---------- 学习夫妻技能 -----------------
-define(PT_COUPLE_LEARN_SKILL, 33006).

%% 协议号: 33006
%% c >> s:
%%        SkillId               u32     id

%% s >> c:
%%      RetCode                 u8      0表示成功

    

-define(PT_COUPLE_APPLY_CRUISE, 33007).
%% 夫妻申请花车巡游
%% C >> S :
%%      type        u8      花车类型 1 普通; 2 豪华; 3 奢华 
%% S >> C
%%      无


%% 服务器通知巡游开始 (只发送给结婚当事人)
-define(PT_COUPLE_NOTIFY_CRUISE_BEGIN, 33008).
%% C >> S :
%%      无
%% S >> C
%%      type        u8      花车类型 1 普通; 2 豪华; 3 奢华
%%      NpcId       u32     

%% 服务器通知巡游结束 (暂时没用)
-define(PT_COUPLE_NOTIFY_CRUISE_END, 33009).
%% C >> S :
%%      无
%% S >> C
%%      type        u8      花车类型 1 普通; 2 豪华; 3 奢华  


%% 夫妻放烟花
-define(PT_COUPLE_FIREWORKS, 33010).
%% C >> S :
%%      无
%% S >> C
%%      无

%% 烟花表现(在花车aoi范围内的玩家收到此协议)
-define(PT_COUPLE_SHOW_FIREWORKS, 33004).
%% C >> S :
%%      无
%% S >> C
%%      Type                u8      烟花类型
%%      SceneId             u32     场景编号
%%      X                   u32
%%      Y                   u32

%% ----------------- 参加花车巡游 -----------------------
-define(PT_COUPLE_REQ_JOIN_CRUISE, 33011).
%% 协议号：33011
%% C >> S:
%%      无
%%
%% S >> C:
%%      RetCode      u8     如果报名成功则返回0，否则不返回，而是直接发送失败提示消息协议

%% ----------------- 中断花车巡游活动 -----------------------
-define(PT_COUPLE_REQ_STOP_CRUISE, 33012).
%% 协议号：33012
%% C >> S:
%%      无
%%
%% S >> C:
%%      RetCode      u8     如果中断成功则返回0，否则不返回，而是直接发送失败提示消息协议
%%      Type         u8     1 手动中断；2 系统中断

-define(PT_COUPLE_APPLY_DEVORCE, 33013).
%% 申请离婚
%% C >> S :
%%      type        u8      (1协议离婚 2强制离婚 3单方申请离婚)
%% S >> C:
%%      RetCode     u8      0表示申请成功
%%      type        u8      (1协议离婚 2强制离婚 3单方申请离婚)


%% 协议离婚 求离婚
-define(PT_COUPLE_ASK_DEVORCE, 33014).
%% S >> C
%%      ObjPlayerName   string          对方名字 （其实就是队长向你求离婚）


%% 协议离婚 回应离婚
-define(PT_COUPLE_RESPOND_DEVORCE, 33015).
%% C >> S
%%      respond     u8      (1-yes 2-no)  60秒内无操作视为“不同意”


%% 通知双方离婚成功
-define(PT_COUPLE_DEVORCE_OK, 33016).
%% S >> C
%%      无


%% ----------------- 花车巡游活动开始  (只发送给结婚当事人以外且符合条件的在线玩家)-----------------------
-define(PT_COUPLE_BROADCAST_CRUISE_BEGIN, 33017).
%% 协议号：33017

%% S >> C:
%%      PlayerName1     string
%%      PlayerName2     string


%% 查询婚车的位置信息
-define(PT_COUPLE_CAR_POS, 33018).

%% 协议号: 33018
%% c >> s:
%%      无
%% s >> c:
%%       NpcId        u32      Npc id
%%       SceneId      u32      场景id
%%       X            u32      所在场景的坐标x
%%       Y            u32      所在场景的坐标y

%% 夫妻双方上线通知处于花车巡游状态
-define(PT_COUPLE_CRUISE_STATE, 33019).
%% S >> C
%%      无