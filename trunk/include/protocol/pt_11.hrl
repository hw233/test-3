%% =========================================================
%% 分类号:11
%% 描述:聊天
%% =========================================================
-define(PT_WORLD, 11001).
% ########### 世界 ##############
% 协议号:11001
% c >> s:
%	  Type   	 u8			 1表示普通, 2表示一键喊话
%     Msg        string      内容
% s >> c:
%     id         u64         用户ID
%     Msg        string      内容
%     identity   u8          身份
%     name       string      名字
%     PrivLv     u8          权限级别（0：普通玩家，1：指导员，2：GM）
%     Dan       u8           玩家段位

-define(PT_PERSONAL, 11002).
% ########### 发送私聊 ##############
% 协议号:11002
% c >> s:
%     ToId           u64         接受方用户ID
%     Msg            string      内容
% s >> c:
%     FromId         u64         发送方用户ID
%     Msg            string      内容
%     identity       u8          身份
%     name           string      名字
%     ToId           u64         接受方用户ID
%     FromPrivLv     u8          发送方的权限级别（0：普通玩家，1：指导员，2：GM）

-define(PT_CURRENT, 11003).
% ########### 场景 ##############
% 协议号:11003
% c >> s:
%     Msg       string      内容
% s >> c:
%     Id        u64         用户ID
%     Msg       string      内容
%     identity  u8          身份
%     name      string      名字
%     PrivLv    u8          权限级别（0：普通玩家，1：指导员，2：GM）

-define(PT_SYS, 11004).
% ########### 系统信息 ##############
% 协议号:11004
% s >> c:
%     Msg       string      内容
    
-define(PT_GUILD, 11005).
% ########### 帮派 ##############
% 协议号:11005
% c >> s:
%     Msg       string      内容 
% s >> c:
%     Id        u64         用户ID
%     Msg       string      内容
%     identity  u8          身份
%     name      string      名字
%     PrivLv    u8          权限级别（0：普通玩家，1：指导员，2：GM）
%     Dan       u8          玩家段位
    
-define(PT_TEAM, 11006).
% ########### 队伍 ##############
% 协议号:11006
% c >> s:
%     Msg       string      内容
% s >> c:
%     Id        u64         用户ID
%     Msg       string      内容
%     identity  u8          身份
%     name      string      名字
%     PrivLv    u8          权限级别（0：普通玩家，1：指导员，2：GM）
%     Race      u8          种族
%     Sex       u8          性别
%     Dan       u8          玩家段位
    
-define(PT_HORN, 11007).
% ########### 喇叭喊话聊天 ##############
% 协议号：11007
% c >> s:
%     Msg       string      内容
% s >> c:
%     Id        u64         用户ID
%     Msg       string      内容 
%     identity  u8          身份
%     name      string      名字
%     PrivLv    u8          权限级别（0：普通玩家，1：指导员，2：GM）

-define(PT_FACTION, 11008).
% ########### 门派聊天 ##############
% 协议号：11008
% c >> s:
%     Msg       string      内容
% s >> c:
%     Id        u64         用户ID
%     Msg       string      内容 
%     identity  u8          身份
%     name      string      名字
%     PrivLv    u8          权限级别（0：普通玩家，1：指导员，2：GM）

-define(PT_GET_ROLE_INFO, 11009).
% ########### 获取玩家聊天相关信息 ##############
% 协议号：11009
% c >> s:
%     Id        u64         用户ID
% s >> c:
%     online    u8          用户在线状态(1->在线 0->不在线)
%     Id        u64         用户ID
%     race      u8          种族
%     sex       u8          性别
%     CaptainState  u8      组队状态
%     TeamId    u32         队伍ID
%     Lv        u16         等级
%     name      string      名字
%	  PeakLv	u16			巅峰等级

-define(PT_CHAT_BAN, 11010).
% ########### 禁言 ##############
% 协议号：11010
% s >> c:
%     time         u32         禁言结束时间长度(sec, 0 -> 永久禁言)
%     reason       string      原因

-define(PT_CHAT_CROSS_SERVER, 11011).
% ######### 跨服聊天 ##########
% 协议号码：11101
% c >> s:
%	  Type   	 u8			1表示普通, 2表示一键喊话
%     Msg       string      内容
% s >> c:
%     Id        u64         用户ID
%     Msg       string      内容
%     identity  u8          身份
%     name      string      名字
%     PrivLv    u8          权限级别（0：普通玩家，1：指导员，2：GM）
%     ServerId  u32         服务器ID
%     Dan       u8          玩家段位

-define(PT_STATE, 11100).
% ########### 聊天状态返回 ##############
% 协议号：11100
% s >> c:
%     cmd       u16         协议号
%     state     int8        状态(0:消息过长 other:)

%%协议对应失败原因
%   11001   1:CD未到
%   11002   1:对方不在线
%   11005   1:没有帮派
%   11006   1:没有队伍
%   11007   1:没有喇叭


%% 玩家进入游戏后获取当前用到的广播id列表
-define(PT_GET_BACKGROUND_ID_LIST, 11201).
% 协议号：11201
% s >> c:
%%      无

%% s >> c:
%%      array(
%%              Id       u32     
%%          )


%% 玩家获取运营后台广播信息详细信息
-define(PT_GET_DETAIL_OF_BROADCAST, 11202).
% 协议号：11202
% c >> s:
%%      array(
%%              Id       u32     
%%          )

%% s >> c:
%%      array(
%%              Id          u32     id
%%              Type        u8      公告类型 1.后台运营走马灯 2.系统走马灯 3.聊天框信息 4.私聊信息
%%              Interval    u32     间隔(sec) 
%%              StartTime   u32     开始时间 当type=3时，表示每天从0点开始经过StartTime秒后开始显示
%%              EndTime     u32     结束时间 当type=3时，表示每天从0点开始经过EndTime-StartTime秒后结束显示
%%              Priority    u8      优先级
%%              Content     string  公告内容
%%          )

%% 删除某条运营后台广播信息 
-define(PT_DEL_BROADCAST, 11203).
% 协议号：11203
% c >> s:
%%      无

% s >> c:
%%      Id          u32

%% 新增运营后台广播信息
-define(PT_ADD_BROADCAST, 11204).
% 协议号：11204
% c >> s:
%%      无

% s >> c:
%%      Id          u32     id
%%      Type        u8      公告类型 1.后台运营走马灯 2.系统走马灯 3.聊天框信息 4.私聊信息
%%      Interval    u32     间隔(sec)
%%      StartTime   u32     开始时间
%%      EndTime     u32     结束时间
%%      Priority    u8      优先级(1：立即,2：高,3：低)
%%      Content     string  公告内容


%% 发送系统广播信息（包括个人提示、队伍与全服提示信息）
-define(PT_SEND_SYS_BROADCAST, 11205).
% 协议号：11205
% c >> s:
%%      无

% s >> c:
%%      No          u32
%%      array(
%%           Value  string 字符串参数
%%          )

%% 跨服聊天个人信息
-define(PT_SEND_ACCORSS_PLAYAER, 11206).
% 协议号：11206
% c >> s:
%     Id        u64         用户ID
%     ServerId  u32         服ID         
% s >> c:
%     online    u8          用户在线状态(1->在线 0->不在线)
%     Id        u64         用户ID
%     race      u8          种族
%     sex       u8          性别
%     CaptainState  u8      组队状态
%     TeamId    u32         队伍ID
%     Lv        u16         等级
%     name      string      名字


%% 跨服聊天门客信息
-define(PT_SEND_ACCORSS_PARTNER, 11207).
% 协议号：11207
%% c >> s:
%%    PartnerId             u64        武将唯一id
%     ServerId              u32        服ID         
%% s >> c:
%%      PartnerNo            u32       将类编号
%%      PartnerId            u64     武将唯一id
%%      Lv                   u16       武将等级
%%      Name                 string    武将名字
%%      Quality              u8        品质
%%      Exp                  u32       武将经验值
%%      Hp                   u32       武将血量
%%      Mp                   u32       魔法（法力）
%%      PhyAtt              u32       物理攻击  
%%      PhyDef              u32       物理防御
%%      MagAtt              u32       法术攻击
%%      MagDef              u32       法术防御
%%      ActSpeed           u32       出手速度

%%      PhyComboAttProba   u32       物理连击率
%%      StrikebackProba    u32       反击率
%%      MagComboAttProba   u32       法术连击率   

%%      ResisHit        u32         封印抗性
%%      ResisSeal         u32         封印抗性

%%      array(
%%             SkillType   u8           技能类别：1--先天；2--后天
%%             SkillNo     u32          技能编号
%%             SkillLv     u16          技能等级
%%           )
%%      Loyalty            u32          忠诚度
%%      NatureNo           u32           性格
%%      HpLim              u32          武将血量上限
%%      MpLim              u32          法力上限
%%      Intimacy            u32     亲密度
%%      IntimacyLv          u16     亲密度等级
%%      EvolveLv            u16     进化等级
%%      Cultivate           u32     修炼值
%%      CultivateLv         u16     修炼等级
%%      BaseGrow             u32     成长基础值
%%      BaseHpAptitude       u32     生命资质基础值
%%      BaseMagAptitude      u32     法力资质基础值
%%      BasePhyAttAptitude   u32     物攻资质基础值
%%      BaseMagAttAptitude   u32     法功资质基础值
%%      BasePhyDefAptitude   u32     物防资质基础值 
%%      BaseMagDefAptitude   u32     法防资质基础值
%%      BaseSpeedAptitude    u32     速度资质基础值
%%      MaxPostnatalSkillSlot u8     最大后天技能格数
%%      Life                  u32    当前寿命
%%      BattlePower           u32    当前战斗力
%%      MoodNo                u16    当前心情编号
%%      Evolve                u32    进化值
%%      Clothes               u32    画皮编号 即衣服
%%      Layer                 u8     最后的修炼层数
%%		PhyCrit				 u16     物理暴击几率
%%		MagCrit				 u16     法术暴击几率
%%		PhyTen				 u16     物理暴击抗性
%%		MagTen				 u16     法术暴击抗性	


%% 跨服聊天物品信息
-define(PT_SEND_ACCORSS_GOODS, 11208).
% 协议号：11208
% c >> s:
%     Id                    u64         物品ID
%     ServerId              u32         服ID         
%
%% S >> C:
%%      PartnerId           u64       宠物唯一id，如果是获取玩家的，则此字段是0
%%      Location            u8        物品所在地  如果是镶嵌在装备上的宝石的话，该字段是 ?LOC_PLAYER_EQP
%%      GoodsId             u64       物品唯一id
%%      GoodsNo             u32       物品编号
%%		Slot          		u8	              新的格子位置（从1开始算起）如果是宝石的话 Slot=0
%%    	Count         		u32                新的叠加数量
%%		BindState     		u8                   新的绑定状态
%%      Quality             u8        品质
%%      UsableTimes         u16       当前剩余的可使用次数（不可使用物品固定为0, 可无限使用的物品则为-1，有限次数的可使用物品则为具体的次数）
%%      BattlePower         u32       装备战斗力 对于非装备则为0
%% 		MakerName			String	  制作者名字
%%      array(                        物品属性相关
%%             InfoType     u8        11--基础属性-没替换 12 --附加属性-没替换 1--基础属性 2--附加属性值 3--强化相关 4--过期时间
%%                                    5--挖宝区域信息 6--附加属性精炼等级（注意：2 和 6 的顺序需要一样且从小到大）7--法宝信息
%%             ObjInfoCode  u16       表示 信息代号（如： 攻击属性加成，防御属性加成， 强化等级，剩余有效时间等， 用数值代号表示，详见obj_info_code.hrl中的宏）
%%             Value        u32       对应的值
%%          )
%%      array(                         宝石镶嵌
%%             HoleNo      u8     已经开启的宝石孔编号 没有开启的不列在内
%%             GoodsId     u64    宝石物品唯一id 为0 时表示没有镶嵌宝石
%%             GoodsNo     u32    宝石物品编号（由策划制定的编号）为0 时表示没有镶嵌宝石
%%          )
%%      EquipEffNo     u32 	特效编号




%% 使某人禁言
-define(PT_BAN_CHAT, 11300).
% 协议号：11300
% c >> s:
%%      TargetPlayerId    u64      目标玩家id

% s >> c:
%%      RetCode           u8       禁言成功则返回0，否则不返回，而是直接发送失败提示消息协议
%%      TargetPlayerId    u64      目标玩家id



%% 解除某人的禁言
-define(PT_CANCEL_BAN_CHAT, 11301).
% 协议号：11301
% c >> s:
%%      TargetPlayerId    u64      目标玩家id

% s >> c:
%%      RetCode           u8       解除成功则返回0，否则不返回，而是直接发送失败提示消息协议
%%      TargetPlayerId    u64      目标玩家id