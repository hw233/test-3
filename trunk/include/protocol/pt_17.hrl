

%%% 宠物系统相关协议
%%% 2013.10.31
%%% @author: zhangwq

%% pt: 表示protocol


%%--------获取宠物(不包括玩家通过使用宠物蛋获获取的情况，使用宠物蛋服务器会主动通知玩家获得宠物) -------------
-define(PT_GET_PARTNER, 17000).

%% 协议号:17000
%% c >> s:
%%    PartnerNo         u32      宠物编号

%% s >> c:
%%      PartnerId            u64   武将唯一id
%%      PartnerNo          u32     宠物编号
%%      Name               string  武将名字
%%      Quality            u8      武将品质
%%      State              u8      休息or参战状态 锁定or非锁定状态   100-->休息非锁定 101-->休息锁定 110-->参战非锁定 111-->参战锁定
%%      Position           u8      是否主宠：1表示主宠
%%      Hp                 u32     气血
%%      Mp                 u32     魔法（法力）
%%      Exp                u32     经验
%%      HpLim              u32     气血上限
%%      MpLim              u32     魔法（法力）上限
%%      ExpLim             u32     经验 上限
%%      Lv                 u16     武将等级
%%		  Follow			       u8      1表示跟随 0 表示不跟随
%%      FiveElement        u8      五行属性
%%      FiveElementLv      u8      五行等级


%%----------------设置宠物出战、休息、锁定 状态-----------------------------
-define(PT_SET_PARTNER_STATE, 17001).
%% 协议号:17001
%% C >> S:
%%      PartnerId       u64
%%      State           u8       休息or参战状态 锁定or非锁定状态   100-->休息非锁定 101-->休息锁定 110-->参战非锁定 111-->参战锁定

%% S >> C:
%%      RetCode         u8       0--成功
%%      PartnerId       u64
%%      State           u8       休息or参战状态 锁定or非锁定状态   100-->休息非锁定 101-->休息锁定 110-->参战非锁定 111-->参战锁定112-->家园雇佣


%%----------------开启宠物携带数量 携带数量：（记在人物表）以通过使用道具女妖栏来扩充此数量，最大上限为8个，初始默认为3个-----------------------
-define(PT_OPEN_CARRY_PARTNER_NUM, 17002).
%% 协议号:17002
%% c >> s:
%%      Num             u8         要开启的数量

%% s >> c:
%%      RetCode         u8          0--成功
%%      CurNum          u8          当前玩家可携带宠物数量


%%----------------设置宠物为主宠-------------------------
-define(PT_SET_MAIN_PARTNER, 17003).
%% 协议号:17003
%% C >> S:
%%      PartnerId       u64       

%% s >> c:
%%      RetCode         u8       0--成功
%%      PartnerId       u64    当前玩家主宠id


%%-----------------洗髓-----------------------------------
-define(PT_WASH_PARTNER, 17004).
%% 协议号:17004
%% c >> s:
%%      PartnerId       u64
%%      Type            u8          1：洗练 | 2:替换            
%%									废弃-洗髓类型 1表示普通洗髓，2表示高级洗髓

%% s >> c:
%%      通过本协议返回PT_GET_PARTNER_ATTR_INFO 17009协议的字段


%%-----------------培养(暂时没用)-----------------------------------
-define(PT_TRAIN_PARTNER, 17005).
%% 协议号:17005
%% c >> s:
%%      PartnerId       u64

%% s >> c:
%%      待定

%%------------------放生-----------------------------------
-define(PT_FREE_PARTNER, 17006).
%% 协议号:17006
%% c >> s:
%%      PartnerId       u64

%% s >> c:
%%      RetCode         u8
%%      PartnerId       u64


%%-------------------宠物改名 名字的长度最多为6个汉字-------------------------------
-define(PT_PARTNER_RENAME, 17007).
%% 协议号:17007
%% c >> s:
%%      PartnerId       u64
%%      NewName         string

%% s >> c:
%%      RetCode         u8
%%      PartnerId       u64
%%      NewName         string


%%-------- 获取玩家携带中的武将列表-------------
-define(PT_GET_PARTNER_LIST,  17008).

%% 协议号:17008
%% c >> s:
%%      无

%% s >> c:
%%    array(
%%            PartnerId       	 u64     武将唯一id
%%            PartnerNo          u32     宠物编号
%%            Name     	         string  武将名字
%%			  Quality            u8      武将品质
%%            State              u8      休息or参战状态 锁定or非锁定状态   100-->休息非锁定 101-->休息锁定 110-->参战非锁定 111-->参战锁定
%%            Position           u8      是否主宠：1表示主宠
%%            Hp                 u32     气血
%%            Mp                 u32     魔法（法力）
%%            Loyalty            u32     忠诚度
%%            HpLim              u32     气血上限
%%            MpLim              u32     魔法（法力）上限
%%            LoyaltyLim         u32     忠诚度 上限
%%            Lv                 u16     武将等级
%%			      Follow			       u8      1表示跟随 0 表示不跟随
%% 		   	    five_elements			 u8      0代表无属性，1-6分别代表金木水火土幽灵属性
%% 		   	    five_elements_lv	 u8      五行等级
%%            battle_order       u8      (12345分别代表五个顺序1是主将，2是副将1···)
%%          array(
%%            slot	 u16      已解锁的功法格子列表
%%          )
%%         )


%%----------  获取玩家自己的单个武将的属性信息-------
%% 
-define(PT_GET_PARTNER_ATTR_INFO,  17009).


%% 协议号:17009
%% c >> s:
%%      PartnerId          u64     武将唯一id
%%{1001, 1200100000000285, 1, "熊猫酒仙", 1, 0, 41403, 0, 4577, 5039, 11937, 5053, 595, 0, 300, 0, 948, 965, 1, {{1213, 0}, {30005, 0}, {20034, 0}, {20043, 0}}, {{30005, 0}, {20034, 0}, {20043, 0}}, {}, 100, 1, 41403, 0, 0, 1, 0, 0, 0, 682, 1008, 0, 505, 2325, 1490, 1539, 812, 6, 1600, 84045, 5, 0, 0, 0, 0, 0, 200, 200, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
%%[INFO] <=-<-=-< R: 17009
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
%%      BaseGrowTmp             u32     成长基础值(洗练临时的)
%%      BaseHpAptitudeTmp       u32     生命资质基础值(洗练临时的)
%%      BaseMagAptitudeTmp      u32     法力资质基础值(洗练临时的)
%%      BasePhyAttAptitudeTmp   u32     物攻资质基础值(洗练临时的)
%%      BaseMagAttAptitudeTmp   u32     法功资质基础值(洗练临时的)
%%      BasePhyDefAptitudeTmp   u32     物防资质基础值(洗练临时的)
%%      BaseMagDefAptitudeTmp   u32     法防资质基础值(洗练临时的)
%%      BaseSpeedAptitudeTmp    u32     速度资质基础值(洗练临时的)
%%      MaxPostnatalSkillSlot u8     最大后天技能格数
%%      Life                  u32    当前寿命
%%      BattlePower           u32    当前战斗力
%%      MoodNo                u16    当前心情编号
%%      Evolve                u32    进化值
%%		AwakeLv				  u8	 觉醒等级
%%		AwakeIllusion		  u8	 觉醒幻化等级
%%      Clothes               u32    画皮编号 即衣服
%%      Layer                 u8     最后的修炼层数
%%		PhyCrit				 u16     物理暴击几率
%%		MagCrit				 u16     法术暴击几率
%%		PhyTen				 u16     物理暴击抗性
%%		MagTen				 u16     法术暴击抗性
%%		FiveElements	     u8      五行属性
%%		FiveElementslv		 U8     五行属性等级
%%		neglect_phy_def		 u32     忽视物防
%%		neglect_mag_def		 u32     忽视法防
%%		be_phy_dam_reduce_coef		 u32     物伤减免
%%		be_mag_dam_reduce_coef		 u32     法伤减免
%%		neglect_seal_resis		 u32     忽视封抗
%%		ret_dam_proba		 u32     反震概率
%%		ret_dam_coef		 u32     反震伤害
%%		neglect_ret_dam_proba		 u32     忽视反震
%%		do_phy_dam_scaling		 u32     物理伤害放缩系数
%%		do_mag_dam_scaling		 u32     法术伤害放缩系数
%%		phy_crit_coef		 u32     物理暴伤
%%		mag_crit_coef		 u32     法术暴伤
%%		pursue_att_proba	 u32     追击概率
%%		absorb_hp_coef		 u32     攻击吸血
%%          array(
%%            slot	 u16      已解锁的功法格子列表
%%          )


%%------------ 获取武将的装备列表 ------------------------
-define(PT_GET_PARTNER_EQUIP_LIST,  17010).

%% 协议号：17010
%% C >> S: 
%%     PartnerId              u64  武将唯一id
%% S >> C:
%%     PartnerId    	      u64  武将唯一id
%%     array(
%%             GoodsId        u64   物品id
%%             GooodsNo       u32    物品类型id  
%%             EquipPos       u8     装备的位置
%%			   StrengthenLv   u8	 装备强化等级
%%			   BindState	  u8    装备的绑定状态       1).      % 永不绑定   2).      % 获取即绑定 3).      % 使用后绑定 4).      % 已绑定
%%          )


%%----------- 通知客户端：更新宠物的一个或多个信息 ------------
-define(PT_NOTIFY_PARTNER_INFO_CHANGE,  17011).

%% 协议号：17011
%% s >> c:
%%     PartnerId              u64  武将唯一id
%%     array(
%%          Key               u16   信息代号（详见obj_info_code.hrl的宏OI_CODE_XXXX）
%%          NewValue          u32  当前的新值
%%          )


%%------------ 获取武将天赋 (此协议已经没用了)------------------------
-define(PT_GET_PARTNER_NATURE_ATTR,  17012).

%% 协议号：17012
%% C >> S: 
%%     PartnerId           u64  武将唯一id
%% S >> C:
%%     PartnerId           u64  武将唯一id
%%     NatureNo            u32     性格编号百分比之分子
%%     PhyAtt              u8     物理攻击百分比之分子
%%     MagAtt              u8     法术攻击百分比之分子
%%     Speed               u8     速度百分比之分子
%%     PhyDef              u8     物理防御百分比之分子
%%     Hp                  u8     气血百分比之分子
%%     MagDef              u8     法术防御百分比之分子
%%     Life                u8     生命百分比之分子


%%-----------------进化-----------------------------------
-define(PT_PARTNER_EVOLVE, 17014).

%% 协议号:17014
%% c >> s:
%%      PartnerId           u64         需要进化的女妖id
%%      GoodsCount			u16			物品数量

%% s >> c:
%%      RetCode         u8          0--成功 1--失败
%%      PartnerId       u64
%%      EvolveLv        u16         当前进化等级
%%      Evolve          u32         当前进化值

%%-----------------修炼-----------------------------------
-define(PT_PARTNER_CULTIVATE, 17015).

%% 协议号:17015
%% c >> s:
%%      PartnerId       u64
%%      Count           u8          修炼次数

%% s >> c:
%%      PartnerId       u64
%%      array(
%%             RetCode         u16  % 0--成功，1--成功暴击  其他如：PM_PAR_LV_LIMIT 见prompt_msg_code.hrl
%              AddCultivate    u32   本次增加的值
%%            )
%%      Cultivate              u32  最后的修炼值
%%      CultivateLv            u16  最后的修炼等级
%%      Layer                  u8  最后的修炼层数


%%-----------------请求进化信息-----------------------------------
-define(PT_PARTNER_EVOLVE_INFO, 17016).

%% 协议号:17016
%% c >> s:
%%      PartnerId       u64

%% s >> c:
%%      PartnerId       u64
%%      BattlePower     u32         进化前当前战斗力
%%      EvolveLv        u16         进化前进化等级
%%      CurGrow         u32         进化前当前成长值
%%      AddedGrow       u32         进化前附加成长值
%%      BattlePower1     u32         进化后当前战斗力
%%      EvolveLv1        u16         进化后进化等级
%%      CurGrow1         u32         进化后当前成长值
%%      AddedGrow1       u32         进化后附加成长值


%%-----------------------请求可携带数量可出战数量 当可出战数量发生变化时服务端也主动推送这信息----------------------------
-define(PT_GET_NUM_LIMIT, 17017).

%% 协议号：17017
%% c >> s:
%%      无

%% s >> c:
%%      CurCarryNum     u8          当前玩家可以携带的最大宠物数
%%      CurFightNum     u8          当前玩家可出战的最大宠物数


%% --------------------宠物使用物品---------------
-define(PT_PARTNER_USE_GOODS, 17018).
%% 协议号：17018
%% C >> S:
%%      PartnerId       u64       宠物id
%%      GoodsId         u64       物品唯一id
%%      Count           u16       使用个数

%% S >> C:
%%      RetCode          u8     若成功则返回0， 否则不返回，而是直接发送失败提示消息协议（涉及的失败原因见如下说明）
%%      GoodsId          u64    物品唯一id
%%      Count            u16    使用个数
%%      GoodsNo          u32 


%%-----------------------改变宠物心情----------------------------
-define(PT_PAR_CHANGE_MOOD, 17019).

%% 协议号：17019
%% c >> s:
%%      PartnerId       u64       宠物id

%% s >> c:
%%      Count           u16       已经主动更新心情次数


%%-----------------------获取已经改变宠物心情的次数----------------------------
-define(PT_GET_CHANGE_MOOD_COUNT, 17020).

%% 协议号：17020
%% c >> s:
%%      无

%% s >> c:
%%      Count           u16       已经主动更新心情次数


%%------------------批量放生----------------------------------- 2020.02.25 这个作废不用了
-define(PT_BATCH_FREE_PARTNER, 17021).
%% 协议号:17006
%% c >> s:
%%      array(
%%            PartnerId       u64
%%           )

%% s >> c:
%%      RetCode               u16      0表示成功 其他表示失败原因
%%      array(
%%            PartnerId       u64
%%          )


%%------------------一键放生----------------------------------- 2020.02.25 这个作废不用了
-define(PT_ONE_KEY_FREE_PARTNER, 17022).
%% 协议号:17006
%% c >> s:

%% s >> c:
%%      RetCode               u16      0表示成功 其他表示失败原因
%%      array(
%%            PartnerId       u64
%%          )

%% ----------------------进入青楼---------------------------
-define(PT_PAR_ENTER_HOTEL, 17023).
%% 协议号:17023
%% c >> s:
%%      LvStep              u8      等级段编号    1 --> 1-29级。   2 --> 30-49级。    3 --> 50-69级。    4 --> 70-99级。    
%%      EnterType           u8      进入青楼的类型 1表示普通进入；2表示高级进入；3表示免费普通进入

%% s >> c:
%%      RetCode             u8      0表示成功 失败通过998协议返回
%%      EnterType           u8      进入青楼的类型 1表示普通进入；2表示高级进入；3表示免费普通进入

%%------------------放生青楼中自己抽取出来的女妖（包括放生与一键放生）-----------------------------------
-define(PT_PAR_FREE_IN_HOTEL, 17024).
%% 协议号:17024
%% c >> s:
%%      array(
%%            PartnerId       u64   要放生的女妖id
%%           )

%% s >> c:
%%      array(
%%            PartnerId       u64   成功放生的女妖id
%%          )


%%------------------领养青楼中自己抽取出来的女妖（包括领养与一键领养）-----------------------------------
-define(PT_PAR_ADOPT_IN_HOTEL, 17025).
%% 协议号:17025
%% c >> s:
%%      array(
%%            PartnerId       u64   要领养的女妖id
%%           )

%% s >> c:
%%      array(
%%            PartnerId       u64   成功领养的女妖id
%%          )

%% ------------------------获取上次抽取的信息 or 开始寻妖 or 再来一次--------------------------------
-define(PT_PAR_FIND_PAR_INFO, 17026).
%% 协议号:17026
%% c >> s:
%%      Type                    u8       操作类型：0--表示请求上次抽取的信息，1--开始寻妖 2--再来一次

%% s >> c:
%%    EnterType                 u8       当前进入青楼的类型 0表示还没有进入;1表示普通进入；2表示高级进入
%%    LastEnterType             u8       上次进入青楼的类型 0表示还没有进入;1表示普通进入；2表示高级进入
%%    LastFreeEnterTime         u32      上次免费普通进入的青楼的时间戳
%%    LvStep                    u8       等级段编号    1 --> 1-29级。   2 --> 30-49级。    3 --> 50-69级。    4 --> 70-99级。
%%    array(
%%            LvStep            u8
%%	          Counter			u8 		 计数器，表示再寻多少个必出紫色女妖
%%         )
%%    array(
%%            PartnerId          u64     武将唯一id
%%            PartnerNo          u32     宠物编号
%%            Name               string  武将名字
%%            Quality            u8      武将品质
%%            State              u8      休息or参战状态 锁定or非锁定状态   100-->休息非锁定 101-->休息锁定 110-->参战非锁定 111-->参战锁定
%%            Position           u8      是否主宠：1表示主宠
%%            Hp                 u32     气血
%%            Mp                 u32     魔法（法力）
%%            Loyalty            u32     忠诚度
%%            HpLim              u32     气血上限
%%            MpLim              u32     魔法（法力）上限
%%            LoyaltyLim         u32     忠诚度 上限
%%            Lv                 u16     武将等级
%%         )


%%-----------------获取青楼中自己抽取的女妖详细信息-----------------------------------
-define(PT_PAR_GET_ATTR_OF_PAR_HOTEL, 17027).
%% 协议号:17027
%% c >> s:
%%      PartnerId       u64

%% s >> c:
%%      通过本协议返回PT_GET_PARTNER_ATTR_INFO 17009协议的字段


%%----------  获取玩家自己的或者别人的单个武将的属性信息-------
%% 
-define(PT_GET_PARTNER_ATTR_INFO1,  17028).

%% 协议号:17028
%% c >> s:
%%      PartnerId       u64

%% s >> c:
%%      通过本协议返回PT_GET_PARTNER_ATTR_INFO 17009协议的字段


%%------------ 获取宠物的装备面板信息 ------------------------
-define(PT_PAR_GET_EQUIP_INFO,  17029).

%% 17029
%% C >> S:
%%      PartnerId             u64
%% S >> C:
%%      PartnerId             u64
%%      ParNo                 u32
%%      Quality               u8 
%%      Lv                    u16     等级
%%      EvolveLv              u8     进化等级
%%      State                 u8      休息or参战状态 锁定or非锁定状态   100-->休息非锁定 101-->休息锁定 110-->参战非锁定 111-->参战锁定
%%      Position              u8      是否主宠：1表示主宠                 
%%      BattlePower           u32    战斗力
%%      Name                  string
%%      CultivateLv           u16  最后的修炼等级
%%      CultivateLayer        u8   最后的修炼层数
%%      array(
%%             GoodsId        u64    物品id
%%             GooodsNo       u32    物品类型id
%%             EquipPos       u8     装备的位置
%%             BindState      u8     绑定状态（见本文件开头的宏说明）
%%             Quality        u8     品质（见本文件开头的宏说明）
%%             StrenLv        u8     强化等级
%%          )


%%----------- 通知客户端：更新宠物的技能信息 ------------
-define(PT_NOTIFY_PARTNER_SKILL_INFO_CHANGE,  17030).

%% 协议号：17030
%% s >> c:
%%     PartnerId              u64  武将唯一id
%%     InfoType               u8   信息类型：1表示增加后天技能格子；2表示增加后天技能
%%     SkillId                u32  技能id  当InfoType=1时，此字段没用


%%----------------设置宠物为跟随状态-------------------------
-define(PT_SET_PARTNER_FOLLOW_STATE, 17031).
%% 协议号:17003
%% C >> S:
%%      PartnerId       u64       
%%	    Follow			u8      1表示跟随 0 表示不跟随

%% s >> c:
%%      PartnerId       u64    当前宠id
%%	    Follow			u8      1表示跟随 0 表示不跟随

%%------------------女妖传功-----------------------------------
-define(PT_PAR_TRANSMIT, 17032).
%% 协议号:17032
%% c >> s:
%%		TargetParId			  u64 		传递目标女妖id
%%      array( 							被传递的女妖列表
%%            PartnerId       u64
%%           )

%% s >> c:
%%		TargetParId			  u64 		传递目标女妖id
%%      array( 							被传递的女妖列表
%%            PartnerId       u64
%%           )

%% -----------------使用道具立刻增加后天技能--------------------------
-define(PT_PAR_ADD_SKILL, 17033).
%% 协议号:17033
%% C >> S:
%%      PartnerId       u64       

%% s >> c:
%%      返回 17011 通知技能数据发生变化


-define(PT_PAR_ALLOT_FREE_TALENT_POINTS,  17034).

%% 协议号: 17034
%% c >> s:
%%     PartnerId       u64    
%%     array(
%%            TalentType      u8        天赋类型（1：力量，2：体质，3：耐力，4：灵力，5：敏捷）
%%            AddPoints       u16       要加的点数
%%          )


-define(PT_PAR_RESET_FREE_TALENT_POINTS,  17035).

%% 协议号: 17035
%% c >> s:
%%     PartnerId       u64    


%% 删除技能
-define(PT_PAR_DEL_SKILL,  17036).

%% 协议号: 17036
%% c >> s:
%%		PartnerId       u64 
%%		SkillId			u32

%% 切换宠物技能页
-define(PT_PAR_CHANGE_SKILL_PAGE,	17037).

%% 协议号: 17037
%% c >> s:
%%		PartnerId       u64 
%%		SkillsUse		u8			1:技能页1  |  2：技能页2

%% s >> c:
%%		PartnerId       u64 
%%		SkillsUse		u8			1:技能页1  |  2：技能页2

%% 宠物觉醒
-define(PT_PAR_AWAKE,	17038).

%% 协议号: 17038
%% c >> s:
%%		PartnerId       u64 

%% s >> c:
%%		PartnerId       u64 
%%		AwakeLv			u8			觉醒等级

%% 宠物幻化
-define(PT_PAR_AWAKE_ILLUSION,	17039).

%% 协议号: 17039
%% c >> s:   
%%		PartnerId       u64 
%%		AwakeLv			u8			幻化的觉醒等级(发0表示取消幻化)

%% s >> c:
%%		PartnerId       u64 
%%		AwakeLv			u8			觉醒等级






%% 五行鉴定/洗练
-define(PT_PAR_FIVE_ELMENT_START,  17100).
%% 协议号: 17100
%% c >> s:
%%		  type            u8            1鉴定，2洗练
%%      partnerId       u64           门客id
%%
%% s >> c
%%		  last_elements   u8            上一次的五行属性
%%      elements        u8            服务端发1-6代表金、木、水、火、土、幽灵

%% 五行升级
-define(PT_PAR_FIVE_ELMENT_LV,  17101).
%% 协议号: 17101
%% c >> s:
%%      partnerId       u64           门客id
%%
%% s >> c
%%      level        	u8            返回当前等级

%%设置出战顺序（只能更改已出战的门客顺序）
-define(PT_CHANGE_PARTNER_BATTLE_ORDER,  17200).
%% 协议号: 17200
%% c >> s:
%%     array{
%%       partnerId       u64           门客id
%%      }
%%
%% s >> c
%%      code        	u8            0成功 / 1失败
%%      array{
%%       partnerId       u64           门客id
%%      }按顺序返回 第一条代表位置1的门客

%% 开启宠物技能最大可学习格子数
-define(PT_PARTNER_SKILL_SLOT_EXPAND, 17210).
%% 协议号: 17210
%% c >> s:
%%     partnerId       u64           门客id
%%
%% s >> c
%%     partnerId       u64           门客id



%% 宠物属性精炼/请求数据
-define(PT_PARTNER_ATTR_REFINE, 17220).
%% 协议号: 17220
%% c >> s:
%%     partnerId       u64           门客id
%%	   attr_code	   u16			 属性代号(这个字段发0则不做精炼操作，只返回当前精炼属性列表)
%%	   goodsNo		   u32			 物品编号
%%	   count		   u16			 倍数

%%
%% s >> c
%%     partnerId       u64           门客id
%% 	   array (
%%			attr_code  u16			属性代号
%%			attr_value u32			属性值
%%			 )


%% 宠物放生（新2020.02.25）
-define(PT_PARTNER_FREE, 17221).
%% 协议号: 17220
%% c >> s:
%%     partnerId       u64           门客id
%%	   type			   u8			 0:查询放生可获得的返还物品 | 1:确定放生

%%
%% s >> c
%%     partnerId       u64           门客id
%%	   type			   u8			 0:查询放生可获得的返还物品 | 1:确定放生
%% 	   array (
%%			 goods_no  u32			道具编号
%%			 count     u32			数量
%%			 )



