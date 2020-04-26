

%%% 物品系统相关协议
%%% 2013.5.15
%%% @author: huangjf, zhangwq

%% pt: 表示protocol


%% ============== 所涉及的宏 ===================

% %% 物品所在地（LOC：表示location）
% -define(LOC_INVALID,       0).     % 无效所在地（仅用于程序做判定）
% -define(LOC_BAG_EQ,        1).     % 装备背包
% -define(LOC_BAG_USABLE,    2).     % 可使用物品背包
% -define(LOC_BAG_UNUSABLE,  3).     % 不可使用物品背包
% -define(LOC_STORAGE,       4).     % 仓库（玩家自己的私人仓库）
% -define(LOC_PLAYER_EQP,    5).     % 玩家的装备栏
% -define(LOC_PARTNER_EQP,   6).     % 宠物的装备栏
% -define(LOC_MAIL,          7).     % 虚拟位置：邮件（用于标记邮件中的附件）
% -define(LOC_TEMP_BAG,      8).     % 临时背包

% -define(LOC_GUILD_STO,     9).     % 帮派仓库
% -define(LOC_MARKET,        10).    % 虚拟位置：市场（用于标记市场中挂售的物品）

%% 绑定状态
% -define(BIND_ALREADY,    1).      		% 已绑定
% -define(BIND_NEVER,      2).          	% 永不绑定
% -define(BIND_ON_GET,     3).      		% 获取即绑定
% -define(BIND_ON_USE,     4).      		% 使用后绑定

% -define(QUALITY_INVALID,    0).        % 无效品质（用于程序做判定）
% -define(QUALITY_WHITE,      1).        % 白
% -define(QUALITY_GREEN,      2).        % 绿
% -define(QUALITY_BLUE,       3).        % 蓝
% -define(QUALITY_PURPLE,     4).        % 紫
% -define(QUALITY_ORANGE,     5).        % 橙
% -define(QUALITY_RED,        6).        % 红
% -define(QUALITY_MIN,        1).        % 品质的最小有效值
% -define(QUALITY_MAX,        6).        % 品质的最大有效值




%%----------- 查询物品栏信息（服务端会返回物品列表） ------------
-define(PT_QRY_INVENTORY,  15000).

%% 协议号：15000
%% C >> S:
%%     PartnerId           u64    宠物唯一id，如果是获取玩家的，则此字段是0
%%     Location            u8     物品所在地（见本文件开头的宏说明）
%%
%% S >> C:
%%     PartnerId           u64    宠物唯一id，如果是获取玩家的，则此字段是0
%%     Location            u8     物品所在地
%%     Capacity            u16    背包或仓库当前容量
%%     array(
%%             GoodsId     u64    物品唯一id
%%             GoodsNo     u32    物品编号（由策划制定的编号）
%%             Slot        u8     物品所在格子
%%             Count       u32    物品叠加数量
%%             BindState   u8     绑定状态（见本文件开头的宏说明）
%%             Quality     u8     品质（见本文件开头的宏说明）
%%             UsableTimes u16    当前剩余的可使用次数（不可使用物品固定为0, 可无限使用的物品则为-1，有限次数的可使用物品则为具体的次数）
%%             BattlePower u32    装备战斗力 对于非装备则为0
%% 			   MakerName   String 制作者名字
%%             CustomType  u8 	  定制类型大于0 ,非定制等于0
%%          )
%%		array(
%%			array(					  当是装备时，发送的额外信息，其他则数组是空的
%%				ObjInfoCode  u16   表示 信息代号  详见obj_info_code.hrl中的宏
%%				Value        u32  对应的值
%%				)
%%			)






%%----------- 获取(自己或者其他玩家的）物品详细信息（注：当物品信息有改变时，服务端会通过此协议主动通知客户端） ------------
-define(PT_GET_GOODS_DETAIL,  15001).
-define(PT_GET_GOODS_DETAIL_ON_RANK,  15201).  %% 排行榜物品信息

%% 协议号：15001
%% C >> S:
%%     GoodsId              u64     物品唯一id
%%
%% S >> C:
%%      PartnerId           u64       宠物唯一id，如果是获取玩家的，则此字段是0
%%      Location            u8        物品所在地  如果是镶嵌在装备上的宝石的话，该字段是 ?LOC_PLAYER_EQP
%%      GoodsId             u64       物品唯一id
%%      GoodsNo             u32       物品编号
%%		Slot          		u8	      新的格子位置（从1开始算起）如果是宝石的话 Slot=0
%%    	Count         		u32       新的叠加数量
%%		BindState     		u8        新的绑定状态
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
%%      EquipEffNo         u32 	      特效编号
%%      EquipSkillNo       u32  	  特技id
%%      EquipEffTempNo     u32 	      临时特效id
%%      EquipSkillTempNo   u32  	  临时特技id
%%      CustomType         u8 	      定制类型大于0 ,非定制等于0



%% --------------------从背包出售物品--------------------------
-define(PT_SELL_GOODS_FROM_BAG, 15002).

%% 协议号：15002
%% C >> S:
%%      GoodsId              u64     物品唯一id
%%      SellCount            u32       物品数量
%% S >> C:
%%      如果把物品堆叠的数量全部卖出则返回 define(PT_NOTIFY_INV_GOODS_DESTROYED,  15061).
%%      如果仅卖出部分 则 返回 -define(PT_GET_GOODS_DETAIL,  15001).


%% 从临时背包一键出售物品
-define(PT_SELL_ALL_GOODS_FROM_TEMP_BAG, 15003).
%% 协议号：15003
%% C >> S:
%%      无
%% S >> C:
%%      RetCode         u8


%% 从临时背包一键获取物品
-define(PT_GET_ALL_GOODS_FROM_TEMP_BAG, 15004).
%% 协议号：15004
%% C >> S:
%%      无
%% S >> C:
%%      RetCode         u8  0表示成功，失败通过998协议返回


%%----------- 扩充背包或仓库的容量 也就是解锁物品框------------
-define(PT_EXTEND_CAPACITY, 15022).

%%	C >> S:
%%		Location   	  u8     扩充位置（表示是扩充背包还是仓库）
%%		ExtendNum     u8     扩充的格子数量

%%	S >> C:
%%		RetCode       u8      若成功则返回0，否则不返回，而是直接发送失败提示消息协议（涉及的失败原因见如下说明）
%%		Location      u8      扩充位置
%%		ExtendNum     u8      扩充的格子数量
%%		NewCapacity   u8      新的容量（格子总数）


%%-----------穿装备------------

-define(PT_PUTON_EQUIP,  15030).

%% 协议号：15030
%% C >> S:
%%      PartnerId    u64        宠物唯一id，如果是获取玩家的，则此字段是0
%%      GoodsId      u64        物品唯一id（指明穿的是哪一件装备）

%% S >> C:
%%      RetCode      u8         若成功则返回0，否则不返回，而是直接发送失败提示消息协议（涉及的失败原因见如下说明）
%%      PartnerId    u64        宠物唯一id，如果是获取玩家的，则此字段是0
%%      GoodsId      u64        物品唯一id（指明穿的是哪一件装备）
%%      ToSlot       u8         新格子（从1开始算起）


%% 失败原因：（宏定义在prompt_msg_code.hrl）
%% PM_UNKNOWN_ERR -- 未知错误
%% PM_GOODS_NOT_EXISTS -- 物品不存在
%% PM_LV_LIMIT -- 等级不够
%% PM_CAREER_LIMIT -- 职业不符合


%%-----------脱装备------------
-define(PT_TAKEOFF_EQUIP,  15031).

%% 协议号：15031
%% C >> S:
%%      PartnerId    u64        宠物唯一id，如果是获取玩家的，则此字段是0
%%		EquipPos	 u8	        装备的位置（指明脱的是哪一件装备， EquipPos的宏见goods.hrl）

%% S >> C:
%%      RetCode      u8         若成功则返回0，否则不返回，而是直接发送提示消息的协议（涉及的失败原因见如下说明）
%%      PartnerId    u64        宠物唯一id，如果是获取玩家的，则此字段是0
%%      GoodsId      u64        物品唯一id
%%      NewSlot      u8         装备脱下后在背包所处的格子
%%      EquipPos     u8         装备的位置（指明脱的是哪一件装备， EquipPos的宏见goods.hrl）


%% 失败原因：（宏定义在prompt_msg_code.hrl）
%% PM_UNKNOWN_ERR -- 未知错误
%% PM_BAG_FULL -- 背包满了

%% TODO: 其他失败原因.....


%% --------------------批量使用物品：是使用可叠加 但只可使用一次的物品---------------
-define(PT_BATCH_USE_GOODS, 15049).
%% 协议号：15049
%% C >> S:
%%      GoodsId         u64  物品唯一id
%%      Count           u32       使用个数
%% S >> C:
%%      RetCode          u8     若成功则返回0， 否则不返回，而是直接发送失败提示消息协议（涉及的失败原因见如下说明）
%%      GoodsId          u64  物品唯一id
%%      Count            u32    使用个数


%%-----------使用单个物品（战斗外使用，并且是玩家为自己而使用），至于战斗内使用物品、为其他对象（如宠物）使用物品之类的，则用另外相应的独立协议------------
-define(PT_USE_GOODS,  15050).

%% 协议号：15050
%% C >> S:
%%     	GoodsId         u64  物品唯一id
%% S >> C:
%%     RetCode          u8   若成功则返回0， 否则不返回，而是直接发送失败提示消息协议（涉及的失败原因见如下说明）
%%     GoodsId          u64  物品唯一id
%%     GoodsNo          u32

%% 失败原因：
%% PM_NO_SUCH_GOODS  -- 物品不存在
%% PM_LV_LIMIT  -- 等级不够
%% PM_CAREER_LIMIT -- 职业不符合
%% ..其他原因。。。
%% ...




%%-----------丢弃物品------------
-define(PT_DISCARD_GOODS,  15051).

%% 协议号：15051
%% C >> S:
%%     	Location    u8       物品所在地
%%     	GoodsId     u64    物品唯一id

%% S >> C:
%%     	RetCode     u8       若成功则返回0，若失败则不返回， 而是直接发送失败提示消息协议（涉及的失败原因见如下说明）
%%     	Location    u8       物品所在地
%%     	GoodsId     u64    物品唯一id


%% 失败原因：
%% PM_CAN_NOT_DISCARD_GOODS -- 该物品不能丢弃





%%-----------拖动物品（从原来格子到另一个格子,同在背包或同在仓库内）------------
-define(PT_DRAG_GOODS,  15052).

%% 协议号：15052
%% C >> S:
%%     Location        u8      物品所在地（背包或仓库）
%%     GoodsId         u64   物品唯一id
%%     ToSlot          u8      新格子（从1开始算起，下同），表示拖到哪一格
%%
%% S >> C:
%%     RetCode         u8      若成功则返回0，否则不返回
%%     Location        u8      物品所在地（背包或仓库）
%%     GoodsId         u64   物品唯一id
%%     ToSlot          u8      新格子（从1开始算起）




%%-----------搬移物品（从背包移到仓库，或从仓库移到背包）------------
-define(PT_MOVE_GOODS,  15053).

%% 协议号：15053
%% C >> S:
%%     GoodsId         u64    物品唯一id
%%     Count           u32    物品数量
%%     ToLocation      u8     目标所在地（指明要搬移到哪里：仓库或背包）
%%
%% S >> C:
%%     RetCode         u8     若成功则返回0，否则不返回，而是直接发送失败提示消息协议（涉及的失败原因见如下说明）
%%     GoodsId         u64    物品唯一id
%%     Count           u32    物品数量







%%----------- 玩家获得物品（放到背包）后，通知客户端（服务端主动通知）------------
%% 注：如果有需要服务端主动通知的话，则可以使用该协议。
-define(PT_NOTIFY_INV_GOODS_ADDED,  15060).

%% 协议号：15060
%% S >> C:
%%	  PartnerId     u64			宠物id
%%    Location      u8         物品所在地（背包或仓库）
%%    GoodsId       u64        物品唯一id
%%    GoodsNo       u32        物品编号
%%    Slot          u8         所在格子位置
%%    Count         u32         叠加数量
%%    BindState     u8         绑定状态：绑定状态（见本文件开头的宏说明）
%%    Quality       u8         品质
%%    UsableTimes   u16        当前剩余的可使用次数（不可使用物品固定为0, 可无限使用的物品则为-1，有限次数的可使用物品则为具体的次数）
%%    BattlePower   u32        装备战斗力 对于非装备则为0
%%    array(                    当是装备时，发送的额外信息，其他则数组是空的
%%              ObjInfoCode  u16   表示 信息代号  详见obj_info_code.hrl中的宏
%%              Value        u32  对应的值
%%         )
%%    CustomType    u8 	定制类型大于0 ,非定制等于0


%%----------- 通知客户端：背包或仓库中的物品被销毁了（服务端主动通知）------------
%% 注：如果有需要服务端主动通知的话，则可以使用该协议。
-define(PT_NOTIFY_INV_GOODS_DESTROYED,  15061).

%% 协议号：15061
%% S >> C:
%%    Location      u8         物品所在地（背包或仓库）
%%    GoodsId       u64      物品唯一id







%%-----------整理背包------------
-define(PT_ARRANGE_BAG,  15070).

%% 协议号：15070
%% C >> S:
%%    无（只发协议号）
%% S >> C:
%%    RetCode      u8    返回0表示成功，返回1表示已经整理过，无需再整理。
%%                         如果成功，客户端收到回复后，则发送查询物品栏（背包）信息的协议，即15000协议，以更新背包


%%-----------装备强化------------
-define(PT_STRENTHEN_EQUIP,  15071).

%% 协议号：15071
%% C >> S:
%%     GoodsId         u64  物品唯一id
%%     Count           u8     强化次数 0 --表示一键升级
%%     UseBindStone    u8     是否使用绑定的强化石 0 -- 不使用 1-- 使用  2  混合使用

%% S >> C:
%%     GoodsId         u64  物品唯一id
%%     Count           u8     强化次数 0 --表示一键升级
%%     UseBindStone    u8     是否使用绑定的强化石 0 -- 不使用 1-- 使用  2  混合使用
%%     array(                 结果列表
%%             RetCode         u16  % 0--成功  其他如：PM_PAR_LV_LIMIT 见prompt_msg_code.hrl
%%             StrenLv         u8     当前强化等级
%%             StrenExp        u32    当前强化经验
%%            )


%%--------------道具合成与提炼------------------
-define(PT_COMPOSE_GOODS, 15072).

%% 协议号：15072
%% C >> S:
%%     GoodsNo         u32    物品编号
%%     Count           u32    合成or提炼次数
%%     UseBindGoods    u8     是否使用绑定的物品 0 -- 不使用 1-- 使用  2  优先使用非绑定，3  优先使用绑定

%% S >> C:
%%     RetCode      u8    返回0表示成功
%%     GoodsNo      u32   物品编号
%%     Count        u32   合成or提炼次数
%%	   OpNo 		u8	  操作类型
%%     UseBindGoods u8    是否使用绑定的物品 0 -- 不使用 1-- 使用  2  优先使用非绑定，3  优先使用绑定

%%--------------道具转换------------------
-define(PT_CHANGE_GOODS, 15084).

%% 协议号：15084
%% C >> S:
%% 		GoodsId         u64    物品唯一id
%%		ChangeToGoodsNo 		u32		要转换为物品编号

%% S >> C:
%%     RetCode      u8    返回0表示成功

%%--------------装备打造-----------------
-define(PT_EQUIP_BUILD, 15085).

%% 协议号：15085
%% C >> S:
%% 		GoodsNo     u32    物品编号
%%		Type 		u8	   打造类型

%% S >> C:
%%     GoodsId      u64    物品id

%%--------------装备分解------------------
-define(PT_EQUIP_DECOMPOSE, 15073).

%% 协议号：15073
%% C >> S:
%%     array(
%%     		 GoodsId          u64  物品唯一id
%%          )

%% S >> C:
%%     RetCode          u8    返回0表示成功
%%     array(
%%     		 GoodsId          u64  物品唯一id
%%          )

%% ----------------------开宝石孔--------------
-define(PT_EQ_OPEN_GEMSTONE, 15074).
%% 协议号：15074
%% C >> S:
%%     GoodsId          u64  物品唯一id
%%     HoleNo           u8   孔的编号

%% S >> C:
%%     GoodsId          u64  物品唯一id
%%     HoleNo           u8   孔的编号


%% ----------------------宝石镶嵌--------------
-define(PT_EQ_INLAY_GEMSTONE, 15075).
%% 协议号：15075
%% C >> S:
%%     EqGoodsId        u64  装备物品唯一id
%%     GemGoodsId       u64  宝石物品id
%%     HoleNo           u8   孔的编号

%% S >> C:
%%     EqGoodsId        u64  装备物品唯一id
%%     GemGoodsId       u64  宝石物品id
%%     HoleNo           u8   孔的编号


%% ----------------------摘下宝石--------------
-define(PT_EQ_UNLOAD_GEMSTONE, 15076).
%% 协议号：15076
%% C >> S:
%%     EqGoodsId        u64  装备物品唯一id
%%     GemGoodsId       u64  宝石物品id
%%     HoleNo           u8   孔的编号

%% S >> C:
%%     EqGoodsId        u64  装备物品唯一id
%%     GemGoodsId       u64  宝石物品id
%%     HoleNo           u8   孔的编号

%%-----------整理仓库------------
-define(PT_ARRANGE_STORAGE,  15077).

%% 协议号：15077
%% C >> S:
%%    无（只发协议号）
%% S >> C:
%%    RetCode      u8       返回0表示成功，返回1表示已经整理过，无需再整理。
%%                          如果成功，客户端收到回复后，则发送查询物品栏（背包）信息的协议，即15000协议，以更新仓库


%% ----------------强化转移-------------------------
-define(PT_STREN_TRS, 15078).
%% 协议号：15078
%% C >> S:
%%     SrcEqId          u64  材料装备id
%%     ObjEqId          u64  目标装备id

%% S >> C:
%%      RetCode           u8     0表示成功
%%      SrcEqId           u64  材料装备id
%%      ObjEqId           u64  目标装备id


%% ----------------装备品质提升-------------------------
-define(PT_EQ_UPGRADE_QUALITY, 15079).
%% 协议号：15079
%% C >> S:
%%      GoodsId           u64  装备id

%% S >> C:
%%      RetCode           u8   0表示成功
%%      GoodsId           u64  装备id


%% ----------------装备重铸-------------------------
-define(PT_EQ_RECAST, 15080).
%% 协议号：15080
%% C >> S:
%%      GoodsId           u64   装备id
%%      Type              u8    0 重铸附加属性 1 重铸基础属性

%% S >> C:
%%      RetCode           u8   0表示成功
%%      GoodsId           u64  装备id


%% ----------------装备精炼-------------------------
-define(PT_EQ_REFINE, 15081).
%% 协议号：15080
%% C >> S:
%%      GoodsId           u64   装备id
%%      Count             u8    次数
%%      Index             u8    第几天属性

%% S >> C:
%%      RetCode           u8   0表示成功
%%      GoodsId           u64  装备id
%%      Count             u8   次数
%%      Index             u8   第几条属性


%% ----------------装备升级-------------------------
-define(PT_EQ_UPGRADE_LV, 15082).
%% 协议号：15082
%% C >> S:
%%      GoodsId           u64  装备id

%% S >> C:
%%      RetCode           u8   0表示成功
%%      GoodsId           u64  装备id


%%--------------物品熔炼------------------
-define(PT_GOODS_SMELT, 15083).

%% 协议号：15083
%% C >> S:      %% 数组必定四个元素，每组个数是1
%%      array(
%%            GoodsNo       u32   消耗的物品编号
%%            BindState     u8    
%%           )

%% S >> C:
%%     RetCode      u8    返回0表示成功
%%     OpNo         u8    操作类型
%%%    GoodsId      u64   熔炼处理的物品id


%%--------------领取遗失的宝石------------------
-define(PT_GOODS_RESET_REWARD, 15086).

%% 协议号：15086
%% C >> S:   

%% S >> C:
%%     RetCode      u8    返回0表示成功



%% ----------------装备重铸(新的可以选择是否保存属性)-------------------------
-define(PT_EQ_RECAST_NEW, 15087).
%% 协议号：15080
%% C >> S:
%%      GoodsId           u64   装备id
%%      Type              u8    0 重铸附加属性 1 重铸基础属性

%% S >> C:
%%      Type              u8    0 重铸附加属性 1 重铸基础属性
%%      GoodsId           u64  装备id
%%      Array(
%%	          goods_no     u32 属性编号
%%	          num          u32 属性值
%%	     )

% 是否选择重铸后的属性
-define(PT_EQ_RECAST_SAVE, 15088).
%% 协议号：15080
%% C >> S:
%%      GoodsId           u64   装备id
%%      Type              u8    0 附加属性 1 基础属性
%%      Action            u8    0 放弃 1替换

%% S >> C:
%%      RetCode           u8   0表示成功
%%      GoodsId           u64  装备id
%%      Action            u8    0 放弃 1替换

% 打开箱子
-define(PT_OPEN_BOX, 15089).
%% 协议号：15089
%% C >> S:
%%      Type              u8    0 金箱子 1 银箱子
%%      No            	  u16   祈福奖励编号
%%      NpcId             u32

%% S >> C:
%%      RetCode           u8   0表示成功
%%      RewardNo          u16   奖励编号

%% ----------------------挖宝结果--------------
-define(PT_DIG_TREASURE_RESULT, 15101).
%% S >> C:
%%     Type              u8  事件类型
%%     array(
%%          goods_no     u32 物品编号
%%          num          u32 物品数量
%%  )
%%     scene_id          u32 场景ID
%%     goods_no          u32 物品编号


%%-----------------------------------法宝相关-----------------------------

%% 品质强化
-define(PT_MAGIC_KEY_QUALITY_UPGRADE, 15150).

%% 协议号:15150
%% c >> s:
%%      GoodsId           u64           要强化的法宝id
%%      array(
%%            GoodsId     u64           法宝id
%%          )

%% s >> c:
%%      GoodsId           u64           要强化的法宝id


%% 法宝洗练
-define(PT_MAGIC_KEY_XILIAN, 15151).

%% 协议号:15151
%% c >> s:
%%      GoodsId           u64           要强化的法宝id
%%      array(
%%            SkillId     u32           锁定的技能id
%%          )

%% s >> c:
%%      GoodsId           u64           要洗练的法宝id


%% 法宝技能升级
-define(PT_MAGIC_KEY_SKILL_LV_UP, 15152).

%% 协议号:15152
%% c >> s:
%%      GoodsId           u64           法宝id
%%      SkillId           u32           准备升级的技能id

%% s >> c:
%%      GoodsId           u64           法宝id
%%      SkillId           u32           升级后的技能id


%% 装备特效洗练
-define(PT_EQ_EFF_REFRESH, 15153).

%% 协议号:15153
%% c >> s:
%%      GoodsId           u64           装备id
%%		Type			  u8			操作类型 1:洗练 | 2:替换

%% s >> c:
%%      GoodsId           u64           装备id
%%		Type			  u8			操作类型 1:洗练 | 2:替换


%% 装备幻化
-define(PT_EQ_TRANSMOGRIFY_NEW, 15155).

%% 协议号:15155
%% c >> s:
%%      TargetGoodsId           u64             目标装备id
%%      GoodsId                 u64             材料装备id
%%		Type			        u8			    幻化类型 0：无保护符 | 1：有保护符

%% s >> c:
%%      ResCode                 u8              0表示成功 | 1表示失败
%%      自动发送一条15001协议内容

%% 是否选择幻化后的属性 
-define(PT_EQ_TRANSMOGRIFY_GET, 15156).

%% 协议号:15156
%% c >> s:
%%      TargetGoodsId           u64             目标装备id

%% s >> c:
%%      直接发15001协议的内容


%%-----------记录强化位置和强化等级-----------------------
-define(PT_NEW_EQUIP_ARRAY, 15202).
%% 协议号：15202
%% C >> S:
%%   上线发空请求一次
%% S >> C:
%%	{
%%		Location    u8	   强化的位置
%%		Level		u8	       强化等级
%%		{
%%			Position      u8   部位
%%          GemstoneId    u64  宝石id
%%          GemstoneNo    u32  宝石no
%%		}
%%	}
%%

%%--------新装备普通强化 -------------
-define(PT_NEW_EQUIP_COMMON_STRENGTHEN, 15203).
%% 协议号：15203
%% C >> S:
%%		Location    u8	   强化的位置(项链、武器、腰带、头部、衣服、鞋子, 分别为1, 2, 3, 4, 5，6)
%%		Auto	    	u8	   是否选择自动购买(1是没有选择, 2是选择)

%% S >> C:
%%    Location    u8	   强化的位置
%%		Level		    u8	   强化等级
%%		刷新战力
%%	    失败:998

%%--------新装备一键强化-----------
-define(PT_NEW_EQUIP_ONE_STRENGTHEN, 15204).
%% 协议号：15204
%% C >> S:
%%		Auto		u8	   是否选择自动购买(1是没有选择, 2是选择)		
%% S >> C:
%%     array {
%%        Location    u8	   强化的位置
%%	  	  Level		u8	   强化等级
%%      }
%%
%%		 刷新战力   13012  信息代号62, 后面如此类推
%%	    失败:998

%% ----------------------新宝石镶嵌--------------
-define(PT_BODY_INLAY_GEMSTONE, 15300).
%% 协议号：15300
%% C >> S:
%%     BodyNo           u8   部位编号
%%     GemStoneId       u64  宝石物品id
%%     HoleNo           u8   孔的编号

%% S >> C:
%%     BodyNo           u8   部位编号
%%     GemStoneId       u64  宝石物品id
%%     HoleNo           u8   孔的编号
%%     GemStoneNo       u32   孔的编号


%% ----------------------新摘下宝石--------------
-define(PT_BODY_UNLOAD_GEMSTONE, 15301).
%% 协议号：15301
%% C >> S:
%%     BodyNo           u8   部位编号
%%     GemStoneId       u64  宝石物品id
%%     HoleNo           u8   孔的编号
%% S >> C:
%%     BodyNo           u8   部位编号
%%     GemStoneId       u64  宝石物品id
%%     HoleNo           u32   孔的编号

%% ----------------新装备重铸(新的可以选择是否保存属性)-------------------------
-define(PT_EQ_NEW_RECAST, 15400).
%% 协议号：15400
%% C >> S:
%%      GoodsId           u64   装备id
%%      Type              u8    0代表重铸附加属性 1代表重铸基础属性
%%		Auto              u8    1表示不自动洗练,2表示自动洗练
%%      Array(
%%          attr_no       u32   属性编号
%%      )
%% S >> C:
%%      GoodsId           u64   装备id
%%      Type              u8    0代表重铸附加属性 1代表重铸基础属性
%%      Attention         u8    0代表未洗炼出关注属性 1代表洗炼出关注属性
%%      RetCode           u8    0代表成功 1代表失败
%%      Array(
%%	          attr_no     u32   属性编号
%%	          value       u32   属性值
%%	     )

% 是否选择重铸后的属性
-define(PT_EQ_NEW_RECAST_SAVE, 15401).
%% 协议号：15401
%% C >> S:
%%      GoodsId           u64   装备id
%%      Type              u8    0 附加属性 1 基础属性
%%      Action            u8    0 放弃 1替换

%% S >> C:
%%      RetCode           u8   0表示成功
%%      GoodsId           u64  装备id
%%      Action            u8    0 放弃 1替换

%% 停止洗练
-define(PT_EQ_NEW_STOP_SUCCINCT_SAVE, 15402).
%% 协议号：15402
%% C >> S:
%%      GoodsId           u64   装备id
%%      Type              u8    0 附加属性 1 基础属性

%% 自选洗炼
-define(PT_EQ_NEW_SPECIAL_SUCCINCT, 15403).
%% 协议号：15403
%% C >> S:
%%		GoodsId           u64   装备id
%%      Array(
%%          attr_no       u32   属性编号
%%      )

%% 装备特技洗练
-define(PT_EQ_STUNT_REFRESH, 15501).

%% 协议号:15501
%% c >> s:
%%      GoodsId           u64           装备id
%%		Type			  u8			操作类型 1:洗练 | 2:替换
%%      Action            u8            洗炼类型 0普通洗炼 | 1高级洗炼

%% s >> c:
%%      GoodsId           u64           装备id
%%		Type			  u8			操作类型 1:洗练 | 2:替换
%%      equip_skill_no     		u32 	特技id
%%      equip_skill_temp_no     u32 	临时特技id
%%      Action            u8            洗炼类型 0普通洗炼 | 1高级洗炼

%%特效洗炼
-define(PT_EQ_NEW_EFF_REFRESH, 15600).
%% 协议号：15600
%% C >> S:
%%      GoodsId           u64   装备id
%%		Auto              u8    1表示不自动洗炼,2表示自动洗炼
%%		AttrLv            u8	特效等级
%%      AttrNo            u32   特效编号
%%      Action            u8    洗炼类型 0普通洗炼 | 1高级洗炼
%% S >> C:
%%      GoodsId           u64   装备id
%%      Auto              u8    1表示不自动洗炼，2表示自动洗炼
%%      Attention         u8    0代表未洗炼出关注属性，1代表洗炼出关注属性
%%      RetCode           u8    0代表成功 1代表失败
%%		EquipEffNo     	  u32 	特效编号
%%      EquipEffTempNo    u32 	临时特效id
%%      Action            u8    洗炼类型 0普通洗炼 | 1高级洗炼

% 替换洗炼后的特效
-define(PT_EQ_NEW_EFF_REFRESH_SAVE, 15601).
%% 协议号：15601
%% C >> S:
%%      GoodsId           u64   装备id

%% S >> C:
%%      RetCode           u8    0 表示成功
%%      GoodsId           u64   装备id
%%		EquipEffNo     	  u32 	特效编号
%%      EquipEffTempNo    u32 	临时特效id


% 替换洗炼后的特效
-define(PT_GOODS_EFF_SELECT, 15700).
%% 协议号：15700
%% C >> S:
%%     	GoodsId         u64  物品唯一id
%%		No              u32  效果编号(物品效果配置表)
%% S >> C:
%%     RetCode          u8   若成功则返回0， 否则不返回，而是直接发送失败提示消息协议（涉及的失败原因见如下说明）
%%     GoodsId          u64  物品唯一id
%%     GoodsNo          u32

% 装备洗练属性转移
-define(PT_GOODS_WASH_ATTR_TRANSFER, 15701).
%% 协议号：15701
%% C >> S:
%%     	GoodsId         u64  转移物品唯一id（主）
%%     	TargetId        u64  目标物品唯一id（从）
%%      Array(
%%          attr_no       u8   1附加属性，2特技，3特效
%%      )
%% S >> C:
%%      RetCode         u8   若成功则返回0，两个物品的150001;否则不返回，而是直接发送失败提示消息协议（涉及的失败原因见如下说明）
%%     	GoodsId         u64  转移物品唯一id（主）
%%     	TargetId        u64  目标物品唯一id（从）
%%      Array(
%%          attr_no       u8   1附加属性，2特技，3特效
%%      )

%%--------激活人物时装----------
-define(PT_ACTIVE_PERSON_FASHION, 15800).
%% 协议号：15800
%% c >> s:
%%      No            u16  时装编号
%%      GoodsNo       u16  物品编号
%% s >> c:
%%      Retcode       u8   激活成功返回0，并返回12017，失败发998协议提示
%%      No            u16  时装编号

%%--------切换人物时装----------
-define(PT_CHANGE_PERSON_FASHION, 15801).
%% 协议号：15801
%% c >> s:
%%      No            u16  时装编号
%% s >> c:
%%      Retcode       u8   激活成功返回0，并返回12017，代号码为333，失败发998协议提示
%%      No            u16  时装编号

%%--------人物时装激活信息----------
-define(PT_PERSON_FASHION_INFO, 15802).
%% 协议号：15802
%% c >> s:
%%      无
%% s >> c:
%%      array(					激活的时装列表
%%			No 					u16   时装编号
%%			RemainTime 			u32   剩余时间
%% 		)
