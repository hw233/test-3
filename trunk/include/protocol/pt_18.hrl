%%% 坐骑系统相关协议
%%% 2015.05.05
%%% @author: lf

%%-------- 打开坐骑界面----------------------------------------------------
-define(PT_GET_MOUNT, 18000).
%%协议号：18000
%% c >> s:
%%      无
%% s >> c:
%%      MountNum            u8      坐骑数量（0表示没有坐骑）
%%      array(
%%          MountId         u64     坐骑id
%%          MountNo         u32     坐骑编号
%%          Name            string  坐骑名字
%%          Type            u8      坐骑类型
%%          Quality         u8      坐骑品质
%%          Level           u16     坐骑等级
%%          Exp             u16     成长值
%%          SkillNum        u8      坐骑技能格子数
%%          array(
%%             SkillNo     u32          技能编号
%%           )
%%          AttributeNo1    u8     坐骑属性编号1
%%          AttributeNo2    u8     坐骑属性编号1
%%          AttributeNo3    u8     坐骑属性编号1
%%          Attribute_add1   u16      增益比率（8~12）
%%          Attribute_add2   u16      增益比率（8~12）
%%          Attribute_sub   u16      减益比率（5~8）
%%          array(
%%              AttributeNo1     u8
%%              AttributeNo2     u8
%%              AttributeNo3     u8
%%              AttributeAdd1    u16
%%              AttributeAdd2    u16
%%              AttributeSub    u16
%%				BattlePower 	u32
%%          )
%%          Step            u8      阶数
%%          StepValue       u16     阶数经验值
%%          Status          u8      是否骑乘（0表示否，1表示是）
%%          PartnerNum      u8      关联宠物数量
%%          Partner1        u64     关联宠物1（0表示没有关联）
%%          Partner2        u64     关联宠物2
%%          Partner3        u64     关联宠物3
%%          Partner4        u64     关联宠物4
%%          Partner5        u64     关联宠物5
%%          Feed            u32     可喂养次数
%%          FeedTimestamp   u32     最后一次喂养时间
%%          BattlePower     u32     坐骑战斗力
%%          CustomType      u8      定制类型 0非定制 1SR 2SSR 3SSS 4SSSR
%%          PartnerMaxNum   u8      关联宠物上限数量
%%      )  

%%---------骑乘/卸下------------------------------------
-define(PT_ONOFF_MOUNT, 18001).
%% 协议号：18001
%% c >> s:
%%          MountId     u64     坐骑唯一id
%%          IsOn        u8      0表示卸下，1表示骑乘
%% s >> c:
%%          IsOn        u8      结果码（0表示卸下，1表示骑乘）
%%          OldMountId  u64     表示之前骑乘的坐骑id
%%          MountId     u64

%%---------坐骑改名 名字的长度最多为6个汉字-------------------------------
-define(PT_RENAME_MOUNT, 18002).
%% 协议号:18002
%% c >> s:
%%      MountId         u64     
%%      NewName         string  
%% s >> c:
%%      RetCode         u8
%%      MountId         u64
%%      NewName         string

%%----------坐骑重修----------------
-define(PT_RESET_ATTR_MOUNT, 18003).
%% 协议号：18003
%% c >> s:
%%      MountId         u64
%%      ResetType       u8    重修类型（0银子，1金子）
%%      Times           u8    重修次数（1重修1次， 8重修8次）
%% s >> c:
%%      MountId         u64
%%      Len             u8    重修长度（1， 8）
%%      array(
%%          AttributeNo1        u8   重修编号
%%          AttributeNo2        u8   重修编号
%%          AttributeNo3        u8   重修编号
%%          AttributeAddRatio1   u16    重修增益比率（300~1000）
%%          AttributeAddRatio2   u16    重修增益比率（300~1000）
%%          AttributeSubRatio   u16    重修减益比率（200~300)
%%			BattlePower 		u32    评分
%%      )

%%----------重修替换--------------------
-define(PT_SET_ATTR_MOUNT, 18004).
%% 协议号：18004
%% c >> s:
%%      MountId             u64 
%%      AttributeNo1        u8   重修编号
%%      AttributeNo2        u8   重修编号
%%      AttributeNo3        u8   重修编号
%%      AttributeAddRatio1   u16
%%      AttributeAddRatio2   u16
%%      AttributeSubRatio   u16 
%% s >> s:
%%      Code                u8  
%%      MountId             u64
%%      AttributeNo1        u8   重修编号
%%      AttributeNo2        u8   重修编号
%%      AttributeNo3        u8   重修编号
%%      AttributeAddRatio1   u16
%%      AttributeAddRatio2   u16
%%      AttributeSubRatio   u16 
%%      BattlePower         u32 战斗力
 

%%---------喂养----------------------
-define(PT_FEED_MOUNT, 18005).
%% 协议号：18005
%%  c >> s:
%%      MountId        u64  坐骑ID
%%      FeedGoodsNo    u32  喂养道具
%%      FeedCount      u32  喂养次数

%% s >> c:
%%      MountId        u64  坐骑ID
%%      Level          u16  坐骑等级
%%      Exp            u32  成长值
%%      BattlePower    u32

%%----------进阶-----------------
-define(PT_STREN_MOUNT, 18006).
%% 协议号：18006
%% c >> s:
%%      MountId        u64
%%      GoodsId        u64  碎片或瓶子物品的id
%%      Num            u16   数量
%% s >> s:
%%      MountId        u64
%%      Step           u8   进阶阶数
%%      StepValue      u16  进阶进阶值
%%      BattlePower    u32

%%---------打开技能---------------
-define(PT_OPEN_MOUNT_SKILL, 18007).
%% 协议号：18007
%% c >> s:
%%      MountId        u64
%%      Order          u8   坐骑技能第几个格子
%% s >> c:
%%      MountId        u64
%%      Order          u8
%%      array(
%%          SkillId    u32    技能id
%%      )

%%--------选择觉醒技能-----------------
-define(PT_LERAN_MOUNT_SKILL, 18008).
%% 协议号：18008
%% c >> s:
%%      MountId        u64
%%      SkillId        u32
%%      Order          u8 坐骑技能第几个格子（1，2，3，4）
%% s >> c:
%%      Code           u8 结果
%%      MountId        u64
%%      SkillId        u32
%%      Order          u8 坐骑技能第几个格子（1，2，3，4）

%%---------升级技能---------
-define(PT_UP_MOUNT_SKILL, 18009).
%% 协议号：18009
%% c >> s:
%%      MountId       u64
%%      SkillId       u32
%%      Order         u8
%% s >> c:
%%      MountId       u64
%%      Order         u8
%%      NewSkillId    u32

%%----------关联/取消关联宠物---------
-define(PT_CONNECT_PARTNER, 18010).
%% 协议号：18010
%% c >> s:
%%      MountId      u64
%%      PartnerId    u64   宠物的id
%%      IsConnect    u8    是否关联（0否1是）
%% s >> c:
%%      IsConnect    u8
%%      MountId      u64
%%      PartnerId    u64

-define(PT_DELETE_MOUNT_SKILL, 18011).
%% 协议号：18011
%% c >> s:
%%      MountId        u64
%%      Order          u8 坐骑技能第几个格子（1，2，3，4）
%% s >> c:
%%      Code           u8 结果
%%      MountId        u64
%%      Order          u8 坐骑技能第几个格子（1，2，3，4）

%%---------喂养----------------------
-define(PT_INHERITANCE_MOUNT, 18012).
%% 协议号：18005
%%  c >> s:
%%      Type				u8	吞噬类型 1付费 2免费
%%      LeftMountId			u64	吞噬者id
%%      RightMountId		u64   被吞噬者id
%% s >> c:
%%      Type				u8 	吞噬类型 1付费 2免费
%%      MountId				u64 	吞噬者id
%%      RemainFeed			u8   吞噬者剩余喂养次数 
%%      Level				u16   吞噬者坐骑等级
%%      Exp					u32  吞噬者成长值
%%      BattlePower			u32	吞噬者战力
%%      BMountId			u64 	被吞噬者ID
%%      BRemainFeed			u8   被吞噬者剩余喂养次数 
%%      BLevel				u16   被吞噬者坐骑等级
%%      BExp				u32  被吞噬者成长值
%%      BBattlePower		u32	被吞噬者战力

%%--------激活坐骑----------
-define(PT_ACTIVE_MOUNT, 18013).
%% 协议号：18013
%% c >> s:
%%      MountNo       u32
%% s >> c:
%%      Retcode       u8   激活成功返回0，失败发998协议提示
%%      MountNo       u32
%%      MountId       u64

%%--------激活坐骑皮肤----------
-define(PT_ACTIVE_MOUNT_SKIN, 18014).
%% 协议号：18014
%% c >> s:
%%      No            u16  皮肤编号
%%      GoodsNo       u16  物品编号
%% s >> c:
%%      Retcode       u8   激活成功返回0，并返回12017，失败发998协议提示
%%      No            u16  皮肤编号

%%--------切换坐骑皮肤----------
-define(PT_CHANGE_MOUNT_SKIN, 18015).
%% 协议号：18015
%% c >> s:
%%      No            u16  皮肤编号
%% s >> c:
%%      Retcode       u8   激活成功返回0，并返回12017，失败发998协议提示
%%      No            u16  皮肤编号

%%--------坐骑皮肤激活信息----------
-define(PT_MOUNT_SKIN_INFO, 18016).
%% 协议号：18016
%% c >> s:
%%      无
%% s >> c:
%%      array(					激活的皮肤列表
%%			No 					u16   皮肤编号
%%			RemainTime 			u32   剩余时间
%% 		)

%%--------技能转换-----------------
-define(PT_TRANSFORM_MOUNT_SKILL, 18017).
%% 协议号：18017
%% c >> s:
%%      MountId        u64
%%      OldSkillId     u32
%%      NewSkillId     u32
%%      Order          u8 坐骑技能第几个格子（1，2，3，4）
%% s >> c:
%%      MountId        u64
%%      OldSkillId     u32
%%      NewSkillId     u32
%%      Order          u8 坐骑技能第几个格子（1，2，3，4）