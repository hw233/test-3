

%%% 玩家信息相关协议
%%% Created: 2013.6.9
%%% @author: huangjf

%% pt: 表示protocol，plyr: 表示player






%%----------- 获取玩家自己的简要信息（角色进入游戏成功后，客户端通过发此协议来查询角色的简要信息） ------------
-define(PT_PLYR_GET_MY_BRIEF,  13001).

%% 协议号：13001
%% c >> s:
%%      无（只发协议号）
%% s >> c:
%%      SceneId   	   u32     所在场景唯一ID
%%      SceneNo   	   u32     所在场景编号
%%      X         	   u16     X坐标
%%      Y         	   u16     Y坐标
%%      Hp        	   u32     血量
%%      HpLim     	   u32     血量上限
%%      Mp        	   u32     魔法值
%%      MpLim     	   u32     魔法值上限
%%      Exp       	   u32     当前经验
%%      ExpLim    	   u32     经验上限
%%   	Yuanbao   	   u32     元宝
%%      BindYuanbao    u32     绑定的元宝
%%   	GameMoney      u64     游戏币
%%   	BindGameMoney  u32     绑定的游戏币
%%      Feat           u32     功勋值
%%   	MoveSpeed      u16     移动速度
%%      GuildName      string  所属帮派的名字（如果没有加入帮派，则返回空字符串）
%%      CurTitle       u16      当前的称号id（如果没有称号，则返回0）
%%      BackWear       u32      背饰编号
%%      Weapon         u32      武器编号
%%      Headwear       u32      头饰编号
%%      Clothes        u32      服饰编号
%%      PartnerNo      u32      主宠物编号
%%      ParWeapon      u32      主宠武器编号 影响外形
%%      EvolveLv       u8       宠物进化等级 影响外形
%%      CultivateLv    u8       主宠修炼等级
%%      CultivateLayer u8       主宠修炼层数
%%      ParQuality     u8       主宠品质
%%      ParClothes     u32      主宠画皮 即衣服
%%		ParAwakeIllusion  u8	主宠宠物觉醒幻化等级（0为无）
%%      array(                  当前buff列表
%%           BuffNo    u32
%%           LeftTime  u32     buff剩余时间 单位是秒
%%           OpenState u8      0--不开启 1--开启
%%          )
%%      GuildContri    u32     当前帮派贡献度
%%      PartnerName    string  主宠物名字
%%      CurBattleId    u32     当前的战斗id（如果不在战斗中，则返回0）
%%      VipLv          u8      当前vip等级
%%      Literary       u32     学分
%%      IsLeader       u8      是否是队长 1 是 0 不是
%%		TeamId 		   u32	   队伍id，没有则为0
%%      FPartnerNo     	u32      跟随宠物编号
%%      FParWeapon     	u32      跟随武器编号
%%      FParEvolveLv   	u8       跟随进化等级
%%      FParCultivateLv	u8       跟随修炼等级
%%      FParCultivateLayer u8    跟随修炼等级
%%      FParQuality    	u8       跟随品质
%%      FParName       	string   跟随名字
%%      FParClothes    	u32      跟随画皮 即衣服
%%		FParAwakeIllusion  u8	跟随宠物觉醒幻化等级（0为无）
%%      PrivLv          u8       权限级别（0：普通玩家， 1：指导员，2：GM）
%%      GuildChiefId    u64      所在帮派帮主id，如果还没有加入帮派则为0
%%      SpouseId        u64      配偶id(玩家id)
%%      SpouseName      string   配偶名字
%%      FreeStrenCnt        u8   今天剩余免费强化装备次数
%%      Contri              u32  玩家成就功绩值
%%      MagicKeyNo        u32    法宝编号
%%      MountNo           u32      坐骑编号
%%      MountSkinNo       u16      坐骑皮肤编号
%%      MountStep         u8       坐骑阶数
%%      Copper            u32      铜币
%%		Vitality          u32		活力值
%%		Popular           u32		人气值
%%      Soaring			  u16		飞升次数
%%		PaodianType       u32       泡点类型
%%      Jingwen		      u32		经文
%%      CrossState        u8     跨服状态
%%      Dan               u8    段位
%%      WingNo           u32    翅膀
%%      MiJing           u32    秘境
%%      HuanJing         u32    幻境
%%      Reincarnation    u32    转生货币
%%      ReincarnLV       u32    转身等级
%%      FabaoDisplayer   u32    法宝展示的外观
%%      FabaoDegree      u32    法宝展示的阶数
%%      array {                 玩家拥有的特殊法宝
%%         SpecialNo     u32
%%      }
%%		SetDisplayerNo	 u32		已经佩戴的法宝编号
%%     Show_graph_title  u32
%%     Show_text_title   u32
%%     FashionNo         u16    时装编号

%%----------- 获取指定玩家的信息详情（只支持获取在线的玩家） ------------
-define(PT_PLYR_GET_INFO_DETAILS,  13002).

%% 协议号：13002
%% c >> s:
%%      PlayerId            int64  玩家id（如果玩家是查自己，则发自己的id）
%% s >> c:
%%      PlayerId            int64  玩家id
%%      Race                u8     种族
%%      Faction             u8     门派
%%      Sex                 u8     性别
%%      Lv                  u16     等级
%%      Exp       	        u32    当前经验
%%      ExpLim    	        u32    经验上限
%%      Hp        	        u32    血量
%%      HpLim     	        u32    血量上限
%%      Mp        	        u32    魔法值
%%      MpLim     	        u32    魔法值上限
%%      PhyAtt              u32    物理攻击
%%      MagAtt              u32    法术攻击
%%      PhyDef              u32    物理防御
%%      MagDef              u32    法术防御
%%      Hit                 u32    命中
%%      Dodge               u32    闪避
%%      Crit                u32    暴击
%%      Ten                 u32    坚韧（抗暴击）
%%      Anger               u32    怒气
%%      AngerLim            u32    怒气上限
%%      Luck                u32    幸运
%%      ActSpeed            u32    战斗中的出手速度
%%      MoveSpeed           u16    移动速度
%%      Talent_Str          u16    力量(strength)
%%      Talent_Con          u16    体质(constitution)
%%      Talent_Sta          u16    耐力(stamina)
%%      Talent_Spi          u16    灵力(spirit)
%%      Talent_Agi          u16    敏捷(agility)
%%      FreeTalentPoints    u16    自由（未分配的）天赋点数
%%      BattlePower         u32    战斗力
%%      GuildId             u64    帮派id，如果还没有加入帮派则为0
%%      SealHit             u32    封印命中
%%      SealResis           u32    封印抗性
%%      Contri              u32    玩家成就功绩值
%%      FrozenHit           u32    隔绝命中
%%      FrozenResis         u32    隔绝抗性
%%      ChaosHit            u32    混乱命中
%%      ChaosResis          u32    混乱抗性
%%      TranceHit           u32    昏睡命中
%%      TranceResis         u32    昏睡抗性
%%		PhyCrit             u32    物理暴击
%%		PhyTen              u32    抗物理暴击
%%		MagCrit             u32    法术暴击
%%		MagTen              u32    抗法术暴击
%%		PhyCritCoef         u32    物理暴击程度
%%		MagCritCoef         u32    法术暴击程度
%%      Popular				u32    人气值
%%      PhyComboAttProba   u32       物理连击率
%%      StrikebackProba    u32       反击率
%%      MagComboAttProba   u32       法术连击率
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
%%		pursue_att_proba	 u32     追击概率
%%		absorb_hp_coef		 u32     攻击吸血

%%----------- 获取指定玩家累积充值 ------------
-define(PT_PLYR_GET_ACCUM_RECHARGE,  13003).

%% 协议号：13003
%% c >> s:
%%   type       u8      (3:充值额度  6:银子 7:所有银子 8:金子 9:所有金子)
%% S >> C:
%%   type       u8
%%   amount     u32


% ----------------- 分配自由天赋点（手动加天赋点） ---------------------------
-define(PT_PLYR_ALLOT_FREE_TALENT_POINTS,  13008).

%% 协议号: 13008
%% c >> s:
%%     array(
%%            TalentType      u8        天赋类型（1：力量，2：体质，3：耐力，4：灵力，5：敏捷）
%%            AddPoints       u16       要加的点数
%%          )


% 洗点
-define(PT_PLYR_RESET_FREE_TALENT_POINTS,  13112).

%% 协议号: 13112
%% c >> s:


%　经脉相关协议
% -------------------------------------------------------------------------------
% 兑换经脉分配点
-define(PT_PLYR_JINGMAI_EXCHANGE,  13113).

%% 协议号: 13113
%% c >> s:
%%	 count     u8 兑换经脉点的数量
%% s >> c:
%%   Code      u8
%%	 count     u8 兑换经脉点的数量

% 经脉分配点洗点
-define(PT_PLYR_RESET_JINGMAI_POINT,  13114).

%% 协议号: 13114
%% c >> s:
%% s >> c:
%%   Code      u8

% 经脉分配查询
-define(PT_PLYR_GET_JINGMAI,  13115).

%% 协议号: 13115
%% c >> s:
%% s >> c:
%%   CurMaxPoint    u16  当前已经兑换最大点数
%%   LeftPoint    	u16  剩余可分配点
%%     array(
%%            JingMaiClass      u8        经脉类别
%%            Point      		u16       经脉已加点数
%%          )

% 经脉分配执行
-define(PT_PLYR_SET_JINGMAI,  13116).

%% 协议号: 13116
%% c >> s:
%%     array(
%%            JingMaiClass      u8        经脉类别
%%            Point      		u16       经脉增加点数
%%          )
%% s >> c:
%%   Code      u8

%　经脉相关协议 结束
% -------------------------------------------------------------------------------
%
% 飞升分配执行
-define(PT_SOARING,  13117).

%% 协议号: 13117
%% c >> s:
%% s >> c:
%%   Code      u8
%%   SoaringLv      u16

% ----------------- 手动升级 ---------------------------
-define(PT_PLYR_MANUAL_UPGRADE,  13009).

%% 协议号: 13009
%% c >> s:
%%     无




% ----------------- 通知客户端：玩家升级了 ---------------------------
-define(PT_PLYR_NOTIFY_UPGRADE,  13010).

%% 协议号: 13010
%% s >> c:
%%     PlayerId  int64    玩家id
%%     NewLv     u16      最新等级



%%----------- 通知客户端：更新玩家的金钱信息 ------------
-define(PT_PLYR_NOTIFY_MONEY_CHANGE,  13011).

%% 协议号：13011
%% s >> c:
%%      MoneyType     u8     钱的类型（详见common.hrl中的宏MNY_T_XXX）
%%		NewNum        u64    当前的新值




%%----------- 通知客户端：更新玩家的一个或多个信息 ------------
-define(PT_PLYR_NOTIFY_INFO_CHANGE,  13012).

%% 协议号：13012
%% s >> c:
%%      array(
%%			Key        u8   信息代号（详见obj_info_code.hrl的宏OI_CODE_XXXX）
%%			NewValue   u32  当前的新值
%%			)

%%------------- 玩家加入门派 ---------------------------------
-define(PT_PLYR_JOIN_FACTION, 13013).

%% 协议号：13013
%% c >> s:
%%      Faction     u8

%% s >> c:
%%      RetCode     u8
%%      Faction     u8

%%------------- 玩家转换门派 ---------------------------------
-define(PT_PLYR_TRANSFORM_FACTION, 13120).
%% 协议号：13120
%% c >> s:
%%      Faction     u8
%% 		Sex         u8
%%      Race        u8

%% s >> c:
%%      RetCode     u8
%%      Faction     u8

%%------------- 获取最后一次转换日期 ---------------------------------
-define(PT_PLYR_GET_LAST_TRANSFORM_TIME, 13121).
%% 协议号：13121
%% c >> s:

%% s >> c:
%%      LastTransformTime     u32

%% -----------------玩家获得东西 包括（ 非装备 装备 等）发送提示给客户端 --------------------

-define(PT_PLYR_NOTIFY_GAIN_ITEM, 13014).

%% 协议号：13014
%%  C >> S:
%%      无

%% S >> C:
%%      Type        u8   获得的东西类型：1.装备 ...详见 goods.hrl 宏定义
%%      Id          u64  如果是物品则表示物品唯一id
%%      No          u32  编号
%%      Count       u32  获得的数量


%% -----------------玩家获得东西 包括（ 货币 等）发送提示给客户端 --------------------

-define(PT_PLYR_NOTIFY_GAIN_MONEY, 13015).

%% 协议号：13015
%%  C >> S:
%%      无

%% S >> C:
%%      Type        u8   获得的东西类型： 1.银子 2.金子 3.绑银 4.绑金 5.功勋值 详见common.hrl宏定义
%%      Count       u32  获得的数量


%%----------- 查询某个玩家是否在线 ------------
-define(PT_PLYR_QUERY_OL_STATE,  13016).

%% 协议号：13016
%% c >> s:
%%      PlayerId            int64  玩家id（如果玩家是查自己，则发自己的id）

%% s >> c:
%%      PlayerId            int64
%%      OLState             u8     0表示不在线，1表示在线



%%------------ 获取玩家的装备面板信息 ------------------------
-define(PT_PLYR_GET_EQUIP_INFO,  13017).

%% 协议号：13017
%% C >> S:
%%     PlayerId              u64  唯一id
%% S >> C:
%%      PlayerId              u64    武将唯一id
%%      Lv                    u16     等级
%%      Race                  u8
%%      Sex                   u8
%%      Faction               u8
%%      BattlePower           u32    战斗力
%%      Name                  string
%%      array(
%%             GoodsId        u64    物品id
%%             GooodsNo       u32    物品类型id
%%             EquipPos       u8     装备的位置
%%             BindState      u8     绑定状态（见本文件开头的宏说明）
%%             Quality        u8     品质（见本文件开头的宏说明）
%%             StrenLv        u8     强化等级
%%          )
%%      array(                        携带的女妖列表
%%              PartnerId     u64
%%          )
%%      array(                  玩家心法信息
%%              Id             u32    心法id
%%              Lv             u8     心法等级
%%          )




%% ----------------------获取玩家气血库与魔法库信息-----------------------
-define(PT_PLYR_GET_STOR_HP_MP, 13018).

%% 协议号：13018
%% C >> S:
%%     无
%% S >> C:
%%      IsAutoAddHpMp     u8 玩家是否开启使用物品自动补给血库和魔法库 1--是，0--否
%%      StoreHp           u32
%%      StoreMp           u32
%%      StoreHpMpMax      u32 血和魔法包上限
%%      IsAutoAddParHpMp  u8  玩家是否开启使用物品自动补给宠物血库和宠物魔法库 1--是，0--否
%%      StoreParHp        u32
%%      StoreParMp        u32
%%      StoreParHpMpMax   u32 宠物血和魔法包上限


%% ---------------------- 设置自动补血补蓝 -----------------------
-define(PT_PLYR_SET_AUTO_ADD_HP_MP_STATE, 13019).
%% 协议号：13019
%% C >> S:
%%      Type             u8  1-->设置玩家的 2-->设置玩家宠物用的
%%      State            u8  是否开启使用物品自动补给血库和魔法库 1--是，0--否

%% S >> C:
%%      Type             u8  1-->设置玩家的 2-->设置玩家宠物用的
%%      State            u8  是否开启使用物品自动补给血库和魔法库 1--是，0--否


%% 通知客户端buff的变化：新增 删除 时间变化等
-define(PT_PLYR_BUFF_CHANGE, 13020).
%% 协议号：13020
%% C >> S:
%%      无

%% S >> C:
%%      BuffNo    u32
%%      LeftTime  u32     buff剩余时间 单位是秒  当 为0 的时候，客户端自动把这个buff删除
%%      OpenState u8      0--不开启 1--开启



%% 玩家设置buff状态：开启与关闭
-define(PT_PLYR_SET_BUFF_STATE, 13021).
%% 协议号：13021
%% C >> S:
%%      BuffNo    u32
%%      OpenState u8      0--不开启 1--开启

%% S >> C:
%%      RetCode   u8      0-- 成功
%%      BuffNo    u32
%%      OpenState u8      0--不开启 1--开启




%% ---------------------- 设置是否允许被请求担任队长 -----------------------
-define(PT_PLYR_SET_CAN_BE_LEADER_STATE, 13022).
%% 协议号：13022
%% C >> S:
%%      State            u8  是否允许被请求担任队长  0--允许，1--不允许

%% S >> C:
%%      State            u8  是否允许被请求担任队长  0--允许，1--不允许


%% ---------------------- 设置是否接收加入队伍邀请 -----------------------
-define(PT_PLYR_SET_TEAM_INVITE_STATE, 13023).
%% 协议号：13023
%% C >> S:
%%      State            u8  是否接收加入队伍邀请   0--接收，1--不接收

%% S >> C:
%%      State            u8  是否接收加入队伍邀请   0--接收，1--不接收


%% ---------------------- 设置是否接收加为好友请求 -----------------------
-define(PT_PLYR_SET_RELA_STATE, 13024).
%% 协议号：13024
%% C >> S:
%%      State            u8  是否接收加为好友请求   0--接收，1--不接收

%% S >> C:
%%      State            u8  是否接收加为好友请求   0--接收，1--不接收



%% -----------------------获取玩家的系统设置-----------------
-define(PT_PLYR_GET_SYS_SET, 13025).
%% 协议号：13025
%% C >> S:
%%      无
%% S >> C:
%%      array(
%%           Type               u8     1 -> 被请求担任队长设置；2-> 是否接收加入队伍邀请 3->是否接收加为好友请求 4 ->是否接受pk邀请 5-> 女妖画皮 6-> 角色面具，7->角色时装，8->角色背饰
%%           SetState           u8     0--允许，1--不允许 或 0--接收，1--不接收 0->展示，1不展示
%%          )


%% ---------------------- 设置是否接受pk邀请 -----------------------
-define(PT_PLYR_SET_ACCEPT_PK_STATE, 13026).
%% 协议号：13024
%% C >> S:
%%      State            u8  是否接受pk邀请   0--接收，1--不接收

%% S >> C:
%%      State            u8  是否接受pk邀请   0--接收，1--不接收


%% ---------------------- 设置玩家或女妖某些部位是否显示在场景中 -----------------------
-define(PT_PLYR_SET_SHOWING_EQUIP, 13027).
%% 协议号：13027
%% C >> S:
%%		Type 		     u8 	5-> 女妖画皮 6-> 角色面具，7->角色时装，8->角色背饰
%%      State            u8  	是否展示  0--展示，1--不展示

%% S >> C:
%%		Type 		     u8 	5-> 女妖画皮 6-> 角色面具，7->角色时装，8->角色背饰
%%      State            u8  	是否展示  0--展示，1--不展示

%% ---------------------- 设置泡点方式 -----------------------
-define(PT_PLYR_SET_PAODIAN_TYPE, 13028).
%% 协议号：13028
%% C >> S:
%%      State            u32  	 0--普通 1-N 泡点方式

%% S >> C:
%%      State            u32  	 0--普通 1-N 泡点方式

-define(PT_PLYR_GET_PAODIAN_TYPE, 13029).
%% 协议号：13029 返回13028
%% C >> S:
%%      State            u8  	 0--普通 1-N 泡点方式



%% ---------------------- 自己拥有的所有称号列表 -----------------------
-define(PT_PLYR_ALL_TITLE, 13030). 
%% 协议号：13030
%% C >> S: (仅协议号)
%% S >> C:
%%      array(
%%				u32   ID
%%				u32   unixtime    获取时间戳
%%				array(		        --定制的属性
%%                   u8     --属性编号
%%              )
%%		  )          			    --所有称号列表
%%      array(              --自定义称号列表
%%              u32               ID
%%              string            自定义称号
%%      )
%%      array(
%%              u16            定制称号编号
%%              array(
%%                   string    属性名称
%%                   u32       属性1
%%                   u32       属性2
%%              )
%%      )


%% ---------------------- 使用称号 -----------------------
-define(PT_PLYR_USE_TITLE, 13031).
%% 协议号：13031
%% C >> S:
%%      u32

%% ---------------------- 不使用称号 -----------------------
-define(PT_PLYR_NO_USE_TITLE, 13032).
%% 协议号：13032
%% C >> S:
%%      u32

%% ---------------------- 展示称号 -----------------------
-define(PT_PLYR_DISPLAY_TITLE, 13033).
%% 协议号：13033
%% C >> S:
%%      u32

%% ---------------------- 不展示称号 -----------------------
-define(PT_PLYR_NO_DISPLAY_TITLE, 13034).
%% 协议号：13034
%% C >> S:
%%      u32


%%--------------------玩家获得自己已学习的阵法列表--------------------------
-define(PT_PLYR_ALL_ZF, 13035).
%% 协议号: 13035
%% C >> S: (仅协议号)

%% S >> C: 
%%      array(u32)   所有阵法列表

%%--------------------玩家学习阵法--------------------------
-define(PT_PLYR_LEARN_ZF, 13036).
%% 协议号: 13036
%% C >> S: 
%%      No      u32   阵法编号
%% S >> C: 
%%      Code    u8    成功返回0， 否则，直接发送失败提示消息
%%      No      u32   阵法编号

%%----------- 通知客户端：更新玩家的一个或多个信息 ------------
-define(PT_PLYR_NOTIFY_INFO_CHANGE_2,  13040).

%% 协议号：13040
%% s >> c:
%%      array(
%%          Key        u8   信息代号（详见obj_info_code.hrl的宏OI_CODE_XXXX）
%%          NewValue   u64  当前的新值
%%          )


%% ----------------- 每日签到 -----------------------
-define(PT_PLYR_SIGN_IN, 13050).
%% 协议号：13050
%% C >> S:
%%      无

%% S >> C:
%%      RetCode   u8   如果签到成功，则返回0，否则，直接发送失败提示消息


%% ----------------- 查询本月的每日签到以及奖励领取情况 -----------------------
-define(PT_PLYR_GET_SIGN_IN_INFO, 13051).
%% 协议号：13051
%% C >> S:
%%      无

%% S >> C:
%%      SignInfo   u32    整数的低31位（二进制位），分别对应本月的签到情况，1表示当天有签到，0表示当天没有签到，从右边算起
%%      RewardInfo u32    整数的低31位（二进制位），分别对应本月签到n次的奖励情况，右边算起第n位是1表示签到n次的奖励已经领取，0表示还没有领取


%% ----------------- 领取每日签到的奖励 -----------------------
-define(PT_PLYR_ASK_FOR_SIGN_IN_REWARD, 13052).
%% 协议号：13052
%% C >> S:
%%      No        u32   奖励编号

%% S >> C:
%%      RetCode   u8    领取成功则返回0，否则，直接发送失败提示消息
%%      No        u32   已经领取的奖励编号



%% ----------------- 查询当前的在线奖励情况 -----------------------
-define(PT_PLYR_GET_ONLINE_REWARD_INFO, 13053).
%% 协议号：13053
%% C >> S:
%%      无

%% S >> C:
%%      CurNo       u32   当前奖励编号 可能是可以领取的，也可能是还不能领取的，客户端根据上次领取时间，判断是否可以领取了
%%      LastGetTime u32   今天上次领取在线奖励时间，如果当天还没有领取过在线奖励，则该时间为0


%% ----------------- 领取当前的在线奖励 -----------------------
-define(PT_PLYR_GET_ONLINE_REWARD, 13054).
%% 协议号：13054
%% C >> S:
%%      CurNo       u32   当前可以领取的奖励编号

%% S >> C:
%%      RetCode     u8    领取成功则返回0，否则，直接发送失败提示消息
%%      NextNo      u32   相对于刚领取的奖励，下一个奖励编号 可能是可以领取的，也可能是还不能领取的，客户端根据上次领取时间，判断是否可以领取了
%%      LastGetTime u32   今天上次领取在线奖励时间，如果当天还没有领取过在线奖励，则该时间为0


%% ----------------- 查询当前的7天礼包奖励情况 -----------------------
-define(PT_PLYR_GET_SEVEN_DAY_REWARD_INFO, 13055).
%% 协议号：13055
%% C >> S:
%%      无

%% S >> C:
%%      Index               u8   创号后可以领取的第几天礼包 1到7 当没有可以领取的礼包是返回0
%%      SevenDayReward      u8   整数的低7位（二进制位），对应创号7天礼包的领取情况，0表示还没有领取，1表示已经领取


%% ----------------- 领取当前的7天登陆奖励 -----------------------
-define(PT_PLYR_GET_SEVEN_DAY_REWARD, 13056).
%% 协议号：13056
%% C >> S:
%%      CurNo               u32   当前奖励编号

%% S >> C:
%%      RetCode             u8    领取成功则返回0，否则，直接发送失败提示消息
%%      SevenDayReward      u8    整数的低7位（二进制位），对应创号7天礼包的领取情况，0表示还没有领取，1表示已经领取


%% ----------------- 查询当前的等级奖励情况 -----------------------
-define(PT_PLYR_GET_LV_REWARD_INFO, 13057).
%% 协议号：13057
%% C >> S:
%%      无

%% S >> C:
%%		array(
%%      		No       u8   已经领取的等级奖励列表
%%			 )

%% ----------------- 领取等级奖励 -----------------------
-define(PT_PLYR_GET_LV_REWARD, 13058).
%% 协议号：13058
%% C >> S:
%%      No       u8   成功领取的等级奖励编号 如果领取不成功则通过998返回

%% S >> C:
%%      No       u8   成功领取的等级奖励编号 如果领取不成功则通过998返回


% % =========================
% % 玩家战斗反馈发送客户端的相关信息
-define(PT_PLYR_NOTIFY_BTL_FEEDBACK, 13060).
% % 协议号：13060
% S >> C:
%       WinState                  u8          0 表示失败，1表示成功
%       MonId                     u32         所打明雷怪的id，如果不是打明雷怪，则为0
%       MonLeftCanBeKilledTimes   u16         明雷怪的剩余可被杀死次数，如果不是打明雷怪，则固定返回0
%       array(
%           GoodsId     u64
%           GoodsNo     u32
%           GoodsNum    u32
%           GoodsQua    u8
%           )




%% --------------- 查询自身的已开放的系统列表 ---------------------
-define(PT_PLYR_QRY_MY_OPENED_SYS_LIST, 13070).
%% 协议号：13070
%% C >> S:
%%      无

%% S >> C:
%%      array(
%%           SysCode        u8    系统代号（详见如下说明）
%%			)


%% ----------------- 通知客户端：新系统开放 -----------------------
-define(PT_PLYR_NOTIFY_NEW_SYS_OPEN, 13071).
%% 协议号：13071
%% S >> C:
%%      SysCode        u8    系统代号（详见如下说明）




%% 系统代号         系统名
%% -------------------------
%%  1               技能
%%  2               目标
%%  3               挂机
%%  4               日常
%%  5               雇佣
%%  6               组队
%%  7               拍卖
%%  8               帮派
%%  9               仙园
%%  10              寻妖


%% ----------------- 通知客户端：VIP信息 -----------------------
-define(PT_PLYR_NOTIFY_VIP, 13081).
%% 协议号：13081
%% C >> S
%%      只发协议号
%% 协议号：13081
%% S >> C:
%%      VipLv        u8    VIP等级
%%      VipExp       u32   VIP经验

%% ----------------- 激活VIP  -----------------------
-define(PT_PLYR_VIP_ACTIVED, 13082).
%% 协议号：13082
%% S >> C:
%%      VipLv        u8    VIP等级

%% ----------------- 体验VIP  -----------------------
-define(PT_PLYR_VIP_EXPERIENCE, 13083).
%% 协议号：13082
%% S >> C:
%%      State        u8    0=结束, 1=开启

%% ----------------- 请求离线挂机状态 -----------------------
-define(PT_PLYR_OFFLINE_AWARD_INFO, 13090).
%% 协议号：13090
%% C >> S
%%      只发协议号

%% ----------------- 开始离线挂机 -----------------------
-define(PT_PLYR_OFFLINE_AWARD_BEGIN, 13091).
%% 协议号：13091
%% C >> S
%%      只发协议号

%% ----------------- 结束离线挂机 -----------------------
-define(PT_PLYR_OFFLINE_AWARD_END, 13092).
%% 协议号：13092
%% C >> S
%%      UseMoney     u8    1=使用游戏币

%% ----------------- 离线挂机状态 -----------------------
-define(PT_PLYR_OFFLINE_AWARD_STATE, 13093).
%% 协议号：13081
%% S >> C:
%%      State        u8    1=离线挂机中
%%      Second       u32   离线挂机时长(秒)
%%      Exp          u32   获得经验
%%      Cost         u32   额外经验需付游戏币



%% ----------------- 充值各档次首充状态 -----------------------
-define(PT_PLYR_RECHARGE_STATE, 13095).
%% 协议号：13095
%% C >> S:
%% S >> C:
%%      array(No      u16         充值编号)
%%		
%%      array(
%%          No      u16         月卡编号
%%          state   u8          是否显示(0:否 1:是)
%%          days    u16         剩余天数
%%    )


%% ----------------- 领取首充礼包状态 -----------------------
-define(PT_PLYR_RECHARGE_REWARD_STATE, 13096).
%% 协议号：13096
%% C >> S:
%% S >> C:
%%      State       u8      0->不可领取 1->可领取 2->已领取



%% ----------------- 领取首充礼包 -----------------------
-define(PT_PLYR_RECHARGE_REWARD, 13097).
%% 协议号：13097
%% C >> S:

%% ----------------- 查询月卡信息 -----------------------
-define(PT_PLYR_CHECK_MONTH_CARD, 13098).
%% 协议号：13098
%% C >> S:
%%      无
%%
%% S >> C:
%%      array(
%%			type         u8        1.月卡   2.周卡   3.终身卡
%%      	Day          u32
%%      	State 		 u8       月卡领取状态, 0->可领取   1->已领取
%%		)


%% ----------------- 领取月卡每日奖励 -----------------------
-define(PT_PLYR_REWARD_MONTH_CARD, 13099).
%% 协议号：13099
%% C >> S:
%%		type         u8        1.月卡   2.周卡   3.终身卡
%%
%% S >> C:
%%      State 		 u8       0->领取成功     错误通过998返回






%% ----------------- 报名参加巡游活动 -----------------------
-define(PT_PLYR_REQ_JOIN_CRUISE, 13100).
%% 协议号：13100
%% C >> S:
%%      无
%%
%% S >> C:
%%      RetCode      u8     如果报名成功则返回0，否则不返回，而是直接发送失败提示消息协议
%%      DiffTime     u16    距离开始巡游的时间（单位：秒）




%% ----------------- 中断巡游活动 -----------------------
-define(PT_PLYR_STOP_CRUISE, 13101).
%% 协议号：13101
%% C >> S:
%%      无
%%
%% S >> C:
%%      RetCode      u8     如果中断成功则返回0，否则不返回，而是直接发送失败提示消息协议




%% ----------------- 通知客户端：巡游结束（到终点了） -----------------------
-define(PT_PLYR_NOTIFY_CRUISE_FINISH, 13102).
%% 协议号：13102
%% S >> C:
%%      无



%% ----------------- 通知客户端：巡游事件触发了 -----------------------
-define(PT_PLYR_NOTIFY_CRUISE_EVENT_TRIGGERED, 13103).
%% 协议号：13103
%% S >> C:
%%      NpcId        u32      Npc的id
%%      EventNo      u16      事件编号
%%      QuestionNo   u16      题目编号（如果不是互动答题事件，则固定返回0）
%%      X            u16      触发事件地点的X坐标
%%      Y            u16      触发事件地点的Y坐标



%% ----------------- 客户端通知服务端：巡游活动互动答题的结果 -----------------------
-define(PT_PLYR_C2S_NOTIFY_CRUISE_QUIZ_RES, 13104).
%% 协议号：13104
%% C >> S:
%%      Result    u8       1表示回答正确，0表示回答错误



%% ----------------- 客户端通知服务端：剧情播放状态 -----------------------
-define(PT_PLYR_C2S_LOG_PLOT, 13110).
%% 协议号：13110
%% C >> S:
%%      state    u8       0->跳过剧情, 1->完整看剧情


%% ----------------- 获取世界等级相关信息 -----------------------
-define(PT_PLYR_WORLD_LV_INFO, 13111).
%% 协议号：13111
%% C >> S:
%% S >> C:
%%  cur_lv      u16     当前世界等级
%%  open_time   u32     世界等级开放时间戳
%%  cur_exp     u64     当前储备经验

%% ----------------- 变身 -----------------------
-define(PT_PLYR_TRANSFIGURATION, 13118).
%% 13118
%% C >> S:
%% S >> C:
%%  TransfigurationNo      u32     变身编号

%% ----------------- 查询基金信息 -----------------------
-define(PT_PLYR_CHECK_FUND, 13122).
%% 协议号：13119
%% C >> S:
%%      无
%%
%% S >> C:
%%      array(
%%			type         u8       1.经济    2.豪华    3.至尊
%%			array(
%%      			lv           u16       例如(10,20,30...)
%% 	   				State        u8   1->不可领取 
%%				  )
%%			)  

%% ----------------- 领取基金等级奖励 -----------------------
-define(PT_PLYR_GET_FUND, 13123).
%% 协议号：13120
%% C >> S:
%%		type         u8       1.经济    2.豪华    3.至尊
%%		Lv 			 u16              例如(10,20,30...)
%%
%% S >> C:
%%      State 		 u8       0->领取成功     错误通过998返回

%% ----------------- 现金券使用 -----------------------
-define(PT_CAN_USE_CASH_COUPON, 13124).
%% 协议号：13124
%% C >> S:
%%		step                    u16		            充值档位
%%		type 			        u32                 现金券编号
%%
%% S >> C:
%%      Retcode 		        u8                  0->成功     错误通过998返回


%% ----------------- 现金券不使用 -----------------------
-define(PT_CAN_NOT_USE_CASH_COUPON, 13127).
%% 协议号：13127
%% C >> S
%% S >> C


%% ------------------ 累计充值总额 ---------------------
-define(PT_RECHARGE_SUM, 13130).
%% 协议号：13130
%% C >> S
%% S >> C:
%% 		money					u32			充值总额

%% ------------------ 首冲3天礼包已领取的档次------------
-define(PT_FIRST_RECHARGE_REWARD_ALREADY,	13131).
%% 协议号：13131
%% C >> S
%% S >> C：
%% 		array(n
%%			money				u32			充值档次
%%			day					u8			已领天数
%%			unixtime			u32			上次领取时间戳
%%			)

%% ------------------- 领取首充礼包 -------------------
-define(PT_FIRST_RECHARGE_REWARD,	13132).
%% 协议号：13132
%% C >> S
%%			money				u32			充值档次
%%
%% S >> C：
%%			money				u32			充值档次
%%


%% ------------------- 连续登陆数据 -------------------
-define(PT_LOGIN_REWARD,	13133).
%% 协议号：13133
%% C >> S
%%
%% S >> C：
%%			days				u32			已领取的连续登陆天数(0代表可以领第一天，1代表已领了一天了)
%%			unixtime			u32			上次领取时间戳


%% ------------------- 领取首充礼包 -------------------
-define(PT_LOGIN_REWARD_GET,	13134).
%% 协议号：13132
%% C >> S
%%
%% S >> C：
%%			days				u32			已领取的连续登陆天数(0代表可以领第一天，1代表已领了一天了)
%%			unixtime			u32			上次领取时间戳		


%%---无限资源协议
-define(PT_INFINITE_RESOURCES, 13135).
%% 协议号：13135
%% 玩家进入游戏时,主动推送一次;当玩家通过充值要求或消耗积分获取武勋值无限等成功时返回
%% S >> C:
%%      array(
%%			type				u16			类型(银币为1,金币为9,武勋为5,侠义为11,学分为8)
%%			value 				u8			返回值(0为没有达到条件,1为达到条件)
%%			)

-define(PT_INFINITE_RESOURCES_SUPPLEMENT, 13136).
%% 协议号：13136
%% 前端会检查是否有这么多积分,默认消耗是10万积分,要返回13011
%% C >> S:
%%    type				  u16			类型(银币为1,2水玉 ，金币为9,武勋为5,侠义为11)
%%		value 				u8			值(2为购买, 3为补充资源)

% ----------------- 通知客户端：玩家巅峰等级升级了 ---------------------------
-define(PT_PLYR_NOTIFY_PEAK_UPGRADE,  13200).

%% 协议号: 13200
%% s >> c:
%%     PlayerId  int64    玩家id
%%     NewLv     u16      最新巅峰等级


% ------------------ 查询创号奖励领取状态 ---------------------------------
-define(PT_PLYR_CREATE_ROLE_REWARD,  13210).

%% 协议号: 13210
%% s >> c:
%%     type     u8      类型（0：查询状态 | 1：领取奖励）

%% c >> s:
%%	   state	u8		状态(0:未领取 | 1：已领取了)




% ------------------ 常驻累充查询|领取 ---------------------------------
-define(PT_PLYR_RECHARGE_ACCUMULATED,  13220).

%% 协议号: 13220
%% c >> s:
%%     args     u32      类型（0：查询已领取状态 | 领取的金额）

%% s >> c:
%%      array(
%%			money				u32			已领取的金额档次
%%			)

% ------------------ 定制称号重置属性 ---------------------------------
-define(PT_CUSTOM_TITLE_RESET,  13300).

%% 协议号: 13300
%% c >> s:
%%	   title_no  u32     称号编号
%% s >> c:
%%	   rec	u8			成功返回0
%%	   title_no  u32     称号编号

% ------------------ 定制称号重置属性 ---------------------------------
-define(PT_CUSTOM_TITLE_START,  13301).

%% 协议号: 13301
%% c >> s:
%%	   title_no  u32     称号编号
%%	   array(
%%         no            属性编号
%%      )
%% s >> c:
%%	   rec	u8		状态(0:未领取 | 1：已领取了
%%	   title_no  u32     称号编号
%%	   array(
%%         no            属性编号











