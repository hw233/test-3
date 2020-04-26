

%%% NPC、明雷怪的相关协议
%%% 2013.7.15
%%% @author: huangjf
%%% 分类号：32

%% pt: 表示protocol
				 

%% ================================ NPC相关的协议 =============================================

%%----------- 查询npc的功能列表 ------------
-define(PT_QRY_NPC_FUNC_LIST,  32000).

%% 协议号：32000
%% C >> S: 
%%     NpcId             u32       npc唯一id
%%  
%% S >> C: 
%%     NpcId             u32	   npc唯一id
%%	   array(	功能列表
%%		   FuncCode      u8        功能代号
%%         FuncArg       u32       功能参数（参数意义见下面说明）
%%	       )


%% 功能代号     功能说明        			客户端对应显示的文字              					 参数意义
%% ------------------------------------------------------------------------------------------------------
%%  1           出售物品         			购买物品                         					 表示npc商店的编号
%%  2           传送             			前往XXX（根据传送编号，从《传送配置表》读取）		 表示传送编号
%%  3           强化装备         			强化装备                         					 无意义，固定返回0
%%  4           教授技能         			学习技能                         				 	 无意义，固定返回0
%%  5           副本             			副本                             				 	 无意义，固定返回0
%%  6           触发打怪         			进入战斗                         					 表示所打的怪物组编号
%%  7           副本专用传送     			。。。                                               无意义，固定返回0
%%  8           雇佣天将         			。。。												 无意义，固定返回0
%%  9           进入爬塔         			。。。												 无意义，固定返回0
%%  10          进入离线竞技场       		竞技场                                               无意义，固定返回0
%%  11          离线竞技场功勋兑换      	功勋兑换                                             对应的商店编号
%%  12          领取礼包输入激活码入口                                                           无意义，固定返回0
%%  13          帮派加菜入口                                                                     无意义，固定返回0
%%  14          物品合成入口
%%  15          帮派副本入口
%%  16          学分兑换                                                                        对应的商店编号
%%  17          帮派点修入口                                                                      无意义，固定返回0
%%  18          帮派捐献入口                                                                      无意义，固定返回0
%%	19 			报名参加巡游活动																  无意义，固定返回0
%%  20          比武大会入口 																	  无意义，固定返回0
%%	21         	世界boss入口 																	  无意义，固定返回0
%%	22          世界boss排名入口																  无意义，固定返回0
%%  23          删除角色																		  无意义，固定返回0
%%  24       	进入结拜																		  无意义，固定返回0
%%	25       	修改结拜																		  无意义，固定返回0
%%	26       	删除结拜																		  无意义，固定返回0
%%  27          进入商城                                                                          无意义，固定返回0
%%  28          进入运镖                                                                          无意义，固定返回0  
%%  29          进入仓库                                                                          无意义，固定返回0 
%%  30          npc物品兑换功能入口                                                               表示兑换编号
%%  31          女妖乱斗入口                                                                      无意义，固定返回0
%%  32          女妖乱斗出口（上缴龙珠）                                                          无意义，固定返回0
%%  34          兵临城下入口                                                                      无意义，固定返回0
%%  35          结婚入口                                                                          无意义，固定返回0
%%  36          婚车入口                                                                          无意义，固定返回0
%%  37          关闭弹出的窗口                                                                    无意义，固定返回0
%%  38          年夜饭加菜入口                                                                    无意义，固定返回0
%%  39          新年宴会入口                                                                      无意义，固定返回0
%%  40          祝福界面入口                                                                      无意义，固定返回0
%%  41          领取祝福                                                                          无意义，固定返回0
%%  42          领取物品（领取新年红包）                                                          无意义，固定返回0
%%  43          进入噩梦爬塔                                                                      无意义，固定返回0
%%  44          进入比武3v3                                                                       无意义，固定返回0
%%  45          跨服3v3战斗                                                                      无意义，固定返回0

% 作废！！！
% %%----------- 查询npc的传送列表 ------------
% -define(PT_QRY_NPC_TELEPORT_LIST,  32001).

% %% 协议号：32001
% %% C >> S: 
% %%     NpcId             u32       npc唯一id
% %%  
% %% S >> C: 
% %%     NpcId             u32	   npc唯一id
% %%	   array(
% %%		   TeleportNo    u32       传送编号
% %%	       )


%%----------- 查询npc的教授技能列表 ------------
-define(PT_QRY_NPC_TEACH_SKILL_LIST,  32002).

%% 协议号：32002
%% C >> S: 
%%     NpcId             u32       npc唯一id
%%  
%% S >> C: 
%%     NpcId             u32	   npc唯一id
%%	   array(
%%		   SkillId       u32       技能id
%%	       )




%%-----------商店--向NPC购买物品---------
-define(PT_BUY_GOODS_FROM_NPC, 32003).

%% 协议号: 32003
%% C >> S:
%%      NpcId                u32     NPC商人ID 
%%      GoodsNo              u32     购买物品编号
%%      Count                u8      数量
%%      ShopNo               u32     商店编号

%%  S >> C:
%%      RetCode              u8      若成功则返回0，1--该物品已经卖光，2--超过限制的购买数量
%%      GoodsNo              u32     购买物品编号
%%      Count                u8      数量


%%-----------根据NPC查询可以购买的物品列表(目前是发动态商品)---------
-define(PT_QUERY_GOODS_BY_NPC, 32004).

%% 协议号: 32004
%% C >> S:
%%      NpcId                u32     NPC商人ID
%%      ShopNo               u32     商店编号

%% s >> c:
%%      NpcId                u32     NPC商人ID
%%      array(
%%            GoodsNo        u32
%%            Quality        u8     品质
%%            PriceType      u8     1.游戏币 2.元宝 3.绑定的游戏币 4.绑定的元宝
%%            Price          u32    
%%            BuyLimit       u8     1 -- 限购的 0 -- 不限购 
%%            NumberLimit    u32    当 BuyLimit = 1 时表示玩家限制购买该物品的个数
%%            GoodsType      u8     0：表示普通商品 1：表示限时物品，无限个物品x时间下架 2：表示限量物品，上架x个
%%            LeftCount      u32    该编号的物品当前剩余个数
%%            ExpireTime     u32    到期时间
%%            BindState      u8     绑定状态
%%           )


%%----------- 查询回购物品信息（服务端会返回物品列表） ------------
-define(PT_QRY_BUY_BACK_LIST,  32005).

%% 协议号：32005
%% C >> S: 
%%      无
%%  
%% S >> C: 
%%     array( 
%%             GoodsId     int64  物品唯一id(注意此id是玩家在回购列表的唯一id)
%%             GoodsNo     u32    物品编号（由策划制定的编号）
%%             Count       u16    物品叠加数量
%%             BindState   u8     绑定状态
%%             Quality     u8     品质
%%             UsableTimes u16    当前剩余的可使用次数（不可使用物品固定为0, 可无限使用的物品则为-1，有限次数的可使用物品则为具体的次数）
%%             SellTime    u32    卖出时间
%%          )


%% 从回购列表回购物品 购买成功物品添加到背包，会另外通知客户端
-define(PT_BUY_BACK, 32006).

%% 协议号：32006
%% C >> S: 
%%      GoodsId         int64    物品唯一id(注意此id是玩家在回购列表的唯一id)
%%      StackCount      u16      回购数量
%%  
%% S >> C: 
%%      RetCode         u8       0--成功
%%      GoodsId         int64    物品唯一id(注意此id是玩家在回购列表的唯一id)
%%      StackCount      u16      回购数量


%%----------- 玩家加物品到回购列表后，通知客户端（服务端主动通知）------------

-define(PT_NOTIFY_BUY_BACK_GOODS_ADDED, 32007).

%% 协议号：32007
%% S >> C:
%%    GoodsId       int64      物品唯一id(注意此id是玩家在回购列表的唯一id)
%%    GoodsNo       u32        物品编号
%%    Count         u16        叠加数量
%%    BindState     u8         绑定状态：0 未绑定；1 已绑定
%%    Quality       u8         品质
%%    UsableTimes   u16        当前剩余的可使用次数（不可使用物品固定为0, 可无限使用的物品则为-1，有限次数的可使用物品则为具体的次数）
%%    SellTime      u32        卖出时间


%%----------- 通知客户端：回购列表中的物品被销毁了（服务端主动通知）------------
%% 注：如果有需要服务端主动通知的话，则可以使用该协议。
-define(PT_NOTIFY_BUY_BACK_GOODS_DESTROYED,  32008).

%% 协议号：32008
%% S >> C:
%%    GoodsId       int64      物品唯一id (注意此id是玩家在回购列表的唯一id)


%% 玩家跑任务去npc采集完毕，向服务器发送采集完毕协议
-define(PT_COLLECT_OK, 32009).

%% 协议号：32009
%% C >> S:
%%      NpcId             u32       npc唯一id

%% S >> C:
%%      无


%%-----------NPC物品兑换---------
-define(PT_EXCHANGE_GOODS_FROM_NPC, 32010).

%% 协议号: 32010
%% C >> S:
%%      NpcId                u32     NPCID 
%%      No                   u32     物品兑换编号

%%  S >> C:
%%      RetCode              u32      若成功则返回1
%%      No                   u32      物品兑换编号

%%-----------兑换商店系统---------
-define(PT_EXCHANGE_GOODS_FROM_SHOP, 32011).

%% 协议号: 32011
%% C >> S:
%%      ExChangeNo           u32     兑换的No 例如1，2，3，···按照策划配置
%%      Num                  u32     物品兑换的数量，（一次最多不能超过2的32次方 - 1）

%%  S >> C:
%%      ExChangeNo           u32      成功返回兑换的No，失败则通过998告知

%% ---------- 通过对话NPC直接打指定编号的怪物组 -----------------
-define(PT_START_MF_BY_TALK_TO_NPC, 32015).

%% 协议号: 32015
%% c >> s:
%%     NpcId          u32    关联的npc id
%%     BMonGroupNo    u32    怪物组编号






%% ================================ 明雷怪相关的协议 =============================================


%%----------- 对话明雷怪 ---------
-define(PT_TALK_TO_MON, 32050).

%% 协议号: 32050
%% C >> S:
%%      MonId                u32     明雷怪id
%% 		Difficulty			 u8		 难度，无多项选择默认发1

%%  S >> C:
%%      RetCode              u8      若符合触发战斗的条件，则返回0，否则返回不符合条件的原因代号
%%      MonId                u32     明雷怪id
%% 		Difficulty			 u8		 难度，无多项选择默认发1


%%-----------特殊NPC物品兑换---------
-define(PT_EXCHANGE_SPECIAL_GOODS_FROM_NPC, 32060).

%% 协议号: 32060
%% C >> S:
%%      NpcId                u32     NPCID 
%%      No                   u32     物品兑换编号
%%		Num 				 u16            特殊配置表读数量

%%  S >> C:
%%      RetCode              u32      若成功则返回1
%%      No                   u32      物品兑换编号

%%-----------商店--向NPC购买物品---------
-define(PT_BUY_GOODS_FROM_CREDIT_NPC, 32070).

%% 协议号: 32070
%% C >> S:
%%      Id              u8      物品id
%%      Count           u8      数量

%%  S >> C:
%%      RetCode         u8      若成功则返回0
%%      Id              u8      物品id




%% TTM: talk to monster
-define(TTM_FAIL_UNKNOWN, 		1).              % 未知错误
-define(TTM_FAIL_LV_LIMIT, 		2).              % 等级不够
-define(TTM_FAIL_HAS_NOT_TASK, 	3).     	     % 没有接取指定的任务
-define(TTM_FAIL_HAS_NOT_ONE_OF_TASKS, 	4).      % 不符合：需要已经接取指定任务列表中的任意一个任务
-define(TTM_FAIL_NOT_ALL_HAS_UNFINISHED_TASK, 5). % 不符合：队伍中所有非暂离的队员都有未完成的指定id的任务
-define(TTM_FAIL_IN_TEAM_BUT_NOT_LEADER, 6). 	 % 在队伍中但不是队长，操作无效
-define(TTM_FAIL_NOT_YOUR_MON, 	7).              % 明雷怪并不属于你
-define(TTM_FAIL_IS_IN_TEAM, 8).				 % 在队伍中，操作无效
-define(TTM_FAIL_IS_NOT_IN_TEAM, 9).			 % 不在队伍中，操作无效
-define(TTM_FAIL_NON_TMP_LEAVE_MEMBER_COUNT_NOT_ENOUGH, 10).   % 队伍中非暂离（在队）的人数不够
-define(TTM_FAIL_HAS_UNFINISHED_TASK_MEMBER_COUNT_NOT_ENOUGH, 11).   % 队伍中非暂离（在队）并且有未完成的指定id的任务的队员的人数不够
-define(TTM_FAIL_LV_NOT_FIT, 12).   % 等级不适合
-define(TTM_FAIL_MEMBER_LV_NOT_FIT, 13).   % 有队员的等级不适合

-define(TTM_FAIL_MON_BATTLING, 20).        % 怪物已经在战斗中
-define(TTM_FAIL_MON_ALRDY_EXPIRED, 21).   % 怪物已过期，操作无效
