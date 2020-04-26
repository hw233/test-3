%%%------------------------------------------------
%%% File    : goods.hrl
%%% Author  : huangjf
%%% Created : 2011-10-17
%%% Description: 物品系统的相关宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__GOODS_H__).
-define(__GOODS_H__, 0).

-include("common.hrl").
%% 物品的最高等级
-define(MAX_GOODS_LV, 150).


%% 物品品质（注意：品质从低到高的数值代号需连续！！ 因为生成新装备时，依据概率判定新装备的品质的处理中默认了该潜规则！）
-define(QUALITY_INVALID,    0).        % 无效品质（用于程序做判定）
-define(QUALITY_WHITE,      1).        % 白
-define(QUALITY_GREEN,      2).        % 绿
-define(QUALITY_BLUE,       3).        % 蓝
-define(QUALITY_PURPLE,     4).        % 紫
-define(QUALITY_ORANGE,     5).        % 橙
-define(QUALITY_RED,        6).        % 红
-define(QUALITY_MIN,        1).        % 品质的最小有效值
-define(QUALITY_MAX,        6).        % 品质的最大有效值



%% 物品所在地（LOC：表示location）
-define(LOC_INVALID,       0).     % 无效所在地（仅用于程序做判定）
-define(LOC_BAG_EQ,        1).     % 装备背包
-define(LOC_BAG_USABLE,    2).     % 可使用物品背包
-define(LOC_BAG_UNUSABLE,  3).     % 不可使用物品背包
-define(LOC_STORAGE,       4).     % 仓库（玩家自己的私人仓库）
-define(LOC_PLAYER_EQP,    5).     % 玩家的装备栏
-define(LOC_PARTNER_EQP,   6).     % 宠物的装备栏
-define(LOC_MAIL,          7).     % 虚拟位置：邮件（用于标记邮件中的附件）
-define(LOC_TEMP_BAG,      8).     % 临时背包

-define(LOC_GUILD_STO,     9).     % 帮派仓库
-define(LOC_MARKET,        10).    % 虚拟位置：市场（用于标记市场中挂售的物品）

-define(LOC_TEMP_RESET,    11).    % 用于修复领取道具用

%% 物品类型
-define(GOODS_T_EQUIP,    		  1).       % 装备类
-define(GOODS_T_ROLE_CONSUME,   2).     % 角色消耗品
-define(GOODS_T_EQ_CONSUME,     3).     % 装备消耗品
-define(GOODS_T_PARTNER_PROP,   4).     % 宠物道具
-define(GOODS_T_LIFE_MATERIAL,  5).     % 生活材料
-define(GOODS_T_TOLLGATE,       6).     % 任务和道具关卡
-define(GOODS_T_FUN_PROP,       7).     % 功能道具
-define(GOODS_T_ACTIVITY_PROP,  8).     % 活动道具
-define(GOODS_T_VIRTUAL,        9).     % 虚拟物品 包括金钱等
-define(GOODS_T_PAR_EQUIP,      10).    % 女妖装备类
-define(GOODS_T_WING,      12).         % 外观类
-define(GOODS_T_AUTO,      13).         % 自动获得物品

-define(GOODS_T_ART, 99).               % 内功

-define(GOODS_T_MOUNT, 11).     

-define(GOODS_T_MAX,      		19).    % 最大值（用于程序做判定）


%% 任务和道具关卡 大类下的 物品子类型
-define(TOLLGATE_T_TASK, 1).  %% 任务道具
% 1.长剑
% 2.鞭子
% 3.大刀
% 4.环
% 5.扇子
% 6.法杖
% 7.护腕
% 8.衣服
% 9.鞋子
% 10.项链
% 11.腰带

% 12.时装（头部）
% 13.时装（身体）
% 14.时装（背部）

%% 玩家装备 大类下 的子类型：武器
-define(EQP_T_WEAPON_BEGIN, 1).        	% 武器：起始
-define(EQP_T_LONGSWORD,    1).        	% 长剑
-define(EQP_T_WHIP,         2).         % 鞭子
-define(EQP_T_BLADE,        3).         % 大刀
-define(EQP_T_HOOP,         4).         % 环
-define(EQP_T_FAN,          5).         % 扇
-define(EQP_T_WAND,         6).        	% 法杖
-define(EQP_T_WEAPON_END,   6).        	% 武器：结束

%% 装备 大类下 的子类型：防具和饰品

-define(EQP_T_GEM, 2).  %% 宝石

-define(EQP_T_BRACER,       7).         % 防具：护腕
-define(EQP_T_BARDE,     	8).         % 防具：策划配置的 衣服 穿在 位置 铠甲上
-define(EQP_T_SHOES,       	9).         % 防具：鞋子 
-define(EQP_T_NECKLACE,    	10).        % 饰品：项链
-define(EQP_T_WAISTBAND,    11).       	% 防具：腰带

%% 装备 大类下 的子类型：时装
-define(EQP_T_HEADWEAR, 12).    	% 时装：头部
-define(EQP_T_CLOTHES, 13).         % 时装：身体
-define(EQP_T_BACKWEAR, 14).    	% 时装：背部

%% 装备 大类下 的子类型：法宝
-define(EQP_T_MAGIC_KEY, 15).       % 法宝

%% 女妖装备大类下的 子类型
-define(PEQP_T_NECKLACE, 1).                  %%   项圈
-define(PEQP_T_MAGIC_KEY, 2).                 %%   法宝
-define(PEQP_T_KEEPSAKE, 3).                  %%   信物
-define(PEQP_T_SKIN, 4).                      %%   画皮
-define(PEQP_T_YAODAN, 5).                    %%   妖丹
-define(PEQP_T_SEAL, 6).                      %%   封印
    

%% 女妖道具大类下的子类
-define(PARTNER_PROP_T_CONSUME, 3).     %% 3宠物消耗品
-define(PARTNER_PROP_T_SKILL_BOOK, 4).  %% 4宠物技能书
-define(PARTNER_PROP_T_OTHER_BOOK, 5).  %% 5其他书籍
-define(PARTNER_PROP_T_BOTTLE, 6).      %% 6宠物蛋


% 角色消耗品 大类下的子类
-define(ROLE_CONSUME_T_DRUG,   1).       %% "1.药品
-define(ROLE_CONSUME_T_BUFF,   2).       %% 2.buff道具
-define(ROLE_CONSUME_T_DEBUFF,   3).     %% 3.debuff道具
-define(ROLE_CONSUME_T_TREASURE,   4).   %% 4.宝藏
-define(ROLE_CONSUME_T_SYMBOL,   5).     %% 5.悬赏令
-define(ROLE_CONSUME_T_BLOOD,   6).      %% 6.血包道具
                                



%% 玩家装备位置 最好与客户端对应
% 1.项链    2.护腕    3.武器
% 4.铠甲    5.腰带    6.靴子
% 7.头饰    8.身体    9.背饰

-define(EQP_POS_NECKLACE,   1).         % 项链
-define(EQP_POS_BRACER,     2).         % 护腕
-define(EQP_POS_WEAPON,     3).         % 武器
-define(EQP_POS_BARDE,      4).         % 铠甲
-define(EQP_POS_WAISTBAND,  5).         % 腰带
-define(EQP_POS_SHOES,      6).         % 鞋子
%% 时装位置
-define(EQP_POS_HEADWEAR,   7).         % 头部
-define(EQP_POS_CLOTHES,    8).         % 身体 （服饰)
-define(EQP_POS_BACKWEAR,   9).         % 背部
-define(EQP_POS_MAGIC_KEY, 10).         % 法宝

%% 女妖装备位置
-define(PEQP_POS_NECKLACE, 1).       %%   项圈
-define(PEQP_POS_MAGIC_KEY, 2).      %%   法宝
-define(PEQP_POS_KEEPSAKE, 3).       %%   信物
% -define(PEQP_POS_SKIN, 4).           %%   画皮
-define(PEQP_POS_SKIN, 7).           %%   画皮
-define(PEQP_POS_YAODAN, 5).         %%   妖丹
-define(PEQP_POS_SEAL, 6).           %%   封印


%% GOODS_T_VIRTUAL,        9).     % 虚拟物品 包括金钱等 子类型
-define(VGOODS_T_GAMEMONEY, 1).     % 银子
-define(VGOODS_T_VOUCHERS, 2).      % 代金券
-define(VGOODS_T_ARTS, 12).          % 内功



%% 绑定状态
-define(BIND_ALREADY,    1).      		% 已绑定
-define(BIND_NEVER,      2).          	% 永不绑定
-define(BIND_ON_GET,     3).      		% 获取即绑定
-define(BIND_ON_USE,     4).      		% 使用后绑定
-define(BIND_MIN,    	1).      		% 绑定状态的最小有效值
-define(BIND_MAX,    	4).      		% 绑定状态的最大有效值





%% 交易状态
-define(TRADE_BAN, 0).   % 不可交易
-define(TRADE_CAN, 1).   % 可以交易

%% 出售状态
-define(SELL_BAN, 0).   % 不可出售
-define(SELL_CAN, 1).   % 可以出售

%% 丢弃状态
-define(DISCARD_BAN, 0).   % 不可丢弃
-define(DISCARD_CAN, 1).   % 可以丢弃



%% 固定花费铜钱
-define(COST_EXTEND_BAG, 60).   % 扩展背包花费元宝
-define(COST_EXTEND_STORE, 60).   % 扩展仓库花费铜钱数


%% 装备附加属性涉及到的常量类型
-define(CON_TYPE_HP,            1).   % 血常量
-define(CON_TYPE_ATT,           2).   % 攻常量
-define(CON_TYPE_DEF,           3).   % 防常量
-define(CON_TYPE_CRIT,          4).   % 暴击常量
-define(CON_TYPE_TEN,           5).   % 抗暴击常量
-define(CON_TYPE_HIT,           6).   % 命中常量
-define(CON_TYPE_DODGE,         7).   % 闪避常量
-define(CON_TYPE_SPEED,         8).   % 速度常量
-define(CON_TYPE_SEAL_HIT,      9).   % 封印命中常量
-define(CON_TYPE_SEAL_RESIS,    10).  % 抗封印命中常量
-define(CON_TYPE_MP,            11).  % 魔法常量
-define(CON_TYPE_FROZEN_HIT,    12).  % .冰封命中常量
-define(CON_TYPE_CHAOS_HIT,     13).  % .混乱命中常量
-define(CON_TYPE_TRANCE_HIT,    14).  % .昏睡命中常量
-define(CON_TYPE_FROZEN_RESIS,  15).  % .冰封抵抗常量
-define(CON_TYPE_CHAOS_RESIS,   16).  % .混乱抵抗常量
-define(CON_TYPE_TRANCE_RESIS,  17).  



% -define(BIND_GOODS_NO_UNLOCK_BAG, 60011).
-define(GOODS_NO_UNLOCK_BAG, 60011).


%% sql查询物品基本信息
-define(SQL_QRY_GOODS_INFO, "id, no, player_id, partner_id, bind_state, usable_times, location, slot, count, quality, first_use_time, valid_time, expire_time, base_equip_add, addi_equip_add, stren_equip_add, equip_prop, custom_type, extra, show_base_attr").


%% 虚拟物品的话， 到时对其编号定义对应的宏， 如：

-define(VGOODS_GAMEMONEY, 89000).       % 银币
-define(VGOODS_BIND_GAMEMONEY, 89002).  % 仙玉
-define(VGOODS_YB, 89001).              % 水玉
-define(VGOODS_BIND_YB, 89003).         % 绑金
-define(VGOODS_EXP, 89004).
-define(VGOODS_STR, 89005).             	% 力量：str
-define(VGOODS_CON, 89006).             	% 体质：con
-define(VGOODS_STA, 89007).             	% 耐力：sta
-define(VGOODS_SPI, 89008).             	% 灵力：spi
-define(VGOODS_AGI, 89009).             	% 敏捷：agi
-define(VGOODS_FEAT, 89010).            	% 功勋
-define(VGOODS_CONTRI, 89011).          	% 帮派贡献度
-define(VGOODS_LITERARY, 89016).			% 学分
-define(VGOODS_PAR_EXP, 89017).         	% 宠物经验
-define(VGOODS_SYS_ACTIVITY_TIMES, 89018).	% 系统活跃度
-define(VGOODS_FREE_TALENT_POINTS, 89019).  % 自由天赋点（潜能点）
-define(VGOODS_COPPER, 89020).  % 铜币
-define(VGOODS_VITALITY, 89021).  % 活力值
-define(VGOODS_CHIVALROUS, 89027).  % 侠义值


-define(VGOODS_QUJING, 89060).  % 经文

-define(VGOODS_MYSTERY, 89070). %秘境
-define(VGOODS_MIRAGE, 89071). %幻境
-define(VGOODS_REINCARNATION, 89133). % 转生


-define(VGOODS_CHIP, 89028).  % 龙头小票

-define(VGOODS_GAMEMONEY_10000, 89030).  % 银币1W
-define(VGOODS_COPPER_100, 89031).  % 金币100

-define(VGOODS_INTEGRAL, 89058).  % 积分

-define(GOODS_RESET_VERSION, 2).  % 金币100

% 货币对应道具编号映射表
-define(MONEY_TO_GOODS, [
    {?MNY_T_GAMEMONEY, ?VGOODS_GAMEMONEY},
    {?MNY_T_YUANBAO, ?VGOODS_YB},
    {?MNY_T_BIND_GAMEMONEY, ?VGOODS_BIND_GAMEMONEY},
    {?MNY_T_BIND_YUANBAO, ?VGOODS_BIND_YB},
    {?MNY_T_FEAT, ?VGOODS_FEAT},
    {?MNY_T_GUILD_CONTRI, ?VGOODS_CONTRI},
    {?MNY_T_EXP, ?VGOODS_EXP},
    {?MNY_T_LITERARY, ?VGOODS_LITERARY},
    {?MNY_T_COPPER, ?VGOODS_COPPER},
    {?MNY_T_VITALITY, ?VGOODS_VITALITY},
    {?MNY_T_CHIVALROUS, ?VGOODS_CHIVALROUS},
    {?MNY_T_CHIP, ?VGOODS_CHIP},
    {?MNY_T_INTEGRAL, ?VGOODS_INTEGRAL},
    {?MNY_T_QUJING, ?VGOODS_QUJING},
    {?MNY_T_MYSTERY, ?VGOODS_MYSTERY},
    {?MNY_T_MIRAGE, ?VGOODS_MIRAGE},
    {?MNY_T_REINCARNATION, ?VGOODS_REINCARNATION}
]).



-endif.  %% __GOODS_H__
