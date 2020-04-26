%%%------------------------------------------------
%%% File    : prompt_msg_code.hrl
%%% Author  : huangjf
%%% Created : 2013.5.16
%%% Description: 提示消息的代号
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__PROMPT_MSG_CODE_H__).
-define(__PROMPT_MSG_CODE_H__, 0).



%% 注： PM表示prompt message



% 通用提示（代号范围：从0到599）
-define(PM_UNKNOWN_ERR, 					0).   % 服务器忙，请稍候重试
-define(PM_OP_FREQUENCY_LIMIT, 				1).   % 服务器忙，请勿操作太频繁
-define(PM_PARA_ERROR, 						2).	  % 服务器忙，请稍候重试
-define(PM_DATA_CONFIG_ERROR,               3).   % 数据配置错误，请检查配置
-define(PM_CLI_MSG_ILLEGAL,               	4).   % 服务器忙，请注意您的操作是否合法

-define(PM_MONEY_LIMIT, 					10).   % 你的货币不足
-define(PM_GAMEMONEY_LIMIT, 				11).   % 你的银币不足
-define(PM_YB_LIMIT, 						12).   % 你的水玉不足
-define(PM_BIND_GAMEMONEY_LIMIT, 			13).   % 你的仙玉不足
-define(PM_BIND_YB_LIMIT, 			 		14).   % 你的绑金不足
-define(PM_REPU_LIMIT,                      15).   % 你的声望不足
-define(PM_EXP_LIMIT,                       16).   % 你的经验不足
-define(PM_FEAT_LIMIT,                      17).   % 大侠，你的武勋值不足
-define(PM_GUILD_CONTRI_LIMIT,              18).   % 大侠，你的贡献度不足
-define(PM_BUSY_NOW, 						20).   % 当前状态下，没法进行此操作
-define(PM_LV_LIMIT, 						21).   % 大侠，你的等级不足
-define(PM_RACE_LIMIT, 						22).   % 大侠，你的国家不符合
-define(PM_FACTION_LIMIT, 					23).   % 大侠，你的门派不符合
-define(PM_SEX_LIMIT, 						24).   % 大侠，你的性别不符合
-define(PM_VIP_LIMIT, 						25).   % 大侠，你不是vip，无法使用VIP权限
-define(PM_VIP_LV_LIMIT, 					26).   % 大侠，你的vip等级不足
-define(PM_IS_IN_BATTLING,					27).   % 该目标正在进行战斗中
-define(PM_LITERARY_LIMIT,                  28).   % 你的学分不足
-define(PM_OBJ_BUSY_NOW, 					29).   % 对方正在忙，请稍候重试
-define(PM_TARGET_PLAYER_NOT_ONLINE,		30).   % 对方离线，请稍候重试
-define(PM_US_BAG_FULL_PLZ_ARRANGE_TIMELY,  31).   % 包裹物品格子空间不足，请及时整理，否则无法获得奖励

-define(PM_HAS_JOINED_FACTION,              32).   % 大侠，你有门派了，没法进行此操作。
-define(PM_NOT_JOIN_FACTION_YET,            33).   % 大侠，你还没加入门派。

-define(PM_MP_IS_FULL,                      34).   % 你的魔法值已满，没法使用该物品回复魔法值。
-define(PM_HP_IS_FULL,                      35).   % 你的气血值已满，没法使用该物品回复气血值。

-define(PM_INTEGRAL_LIMIT,                  36).   % 大侠，你的积分不足。

-define(PM_NOT_JOIN_GUILD_YET,            	40).   % 大侠，你还没加入帮派。
-define(PM_UNUS_BAG_FULL_PLZ_ARRANGE_TIMELY,41).   % 你的包裹材料格子已满，先整理下包裹空间吧，否则没法获得奖励。
-define(PM_EQ_BAG_FULL_PLZ_ARRANGE_TIMELY,  42).   % 你的包裹装备格子已满，先整理下包裹空间吧，否则没法获得奖励。

-define(PM_PLAYER_STATE_OFFLINE_GUAJI,      43).   % 对方正在离线挂机

-define(PM_TOO_FAR_FROM_NPC, 44).				   % 你距离NPC太远了

-define(PM_PRIVILEGE_LIMIT, 50).                   % 你的权限不足

-define(PM_PHY_POWER_LIMIT,                 51).   % 大侠，你的体力不足

-define(PM_HORN_NEED_RECHARGE,              60).   % 充值任意金额才可使用喇叭
-define(PM_CHAT_PERSONAL_PAY,				61).	% 充值大于等于12元方可使用私聊功能


-define(PM_CHAT_NEED_RECHARGE,              70).   % 充值任意金额才可发言

-define(PM_CROSS_BAN_PROTO,					80).	% 请先回到原服再进行此操作


%% 绑定手机相关
-define(PM_ACCOUNT_BIND_MOBILE_ALREADY,		90).	% 当月已绑定
-define(PM_ACCOUNT_BIND_CODE_OUTDATE,		91).	% 验证码已失效，请重新获取
-define(PM_ACCOUNT_BIND_CODE_ERROR,			92).	% 验证码错误


-define(PM_LIMIT_COUNT_DAY,					101).	% 今天可操作次数已达到上限，请明天再来。		


%% 修改角色名提示（500-599）
-define(PM_CR_FAIL_ROLE_LIST_FULL,  500).          % 角色列表满了，不能再创建
-define(PM_CR_FAIL_NAME_EMPTY,      501).          % 角色名不能为空
-define(PM_CR_FAIL_NAME_TOO_SHORT,  502).          % 角色名太短
-define(PM_CR_FAIL_NAME_TOO_LONG,   503).          % 角色名太长
-define(PM_CR_FAIL_CHAR_ILLEGAL,    504).          % 角色名包含非法字符
-define(PM_CR_FAIL_NAME_CONFLICT,   505).          % 角色名已经被使用，请重新输入

% 账户相关的提示（代号范围：600~649）
-define(PM_DISCARD_ROLE_FAIL_IN_TEAM, 600).      % 当前处于组队状态，不能删除角色
-define(PM_DISCARD_ROLE_FAIL_TIMES_LIMIT, 601).  % 你删除角色次数已用完，没法继续删除角色




% npc商店 商城 拍卖行 提示（代号范围：从1000到1199）
-define(PM_NPC_NOT_EXISTS, 1000).                   %% 您点击的这个东西已经消失了
-define(PM_GOODS_OVERDUE, 1001).                    %% 已经超过回购时间限制
-define(PM_GOODS_SELL_OVER, 1002).                  %% 先来先到，商品早就被抢光啦！
-define(PM_BUY_COUNT_LIMIT, 1003).                  %% 个人购买数量超出上限，没法再购买。

-define(PM_MK_FAIL_SERVER_BUSY, 1004).                    %% 服务器忙，请稍候重试
-define(PM_MK_SELL_FAIL_BIND_ALREADY, 1005).              %% 物品或货币已绑定，不能挂售
-define(PM_MK_SELL_FAIL_MONEY_NOT_ENOUGH, 1006).          %% 挂售费不足
-define(PM_MK_SELL_FAIL_OVER_SELL_MAX, 1007).             %% 同时出售商品数量不能超过8个
-define(PM_MK_BUY_FAIL_GOODS_EXPIRED, 1008).              %% 物品挂售时间过期
-define(PM_MK_BUY_FAIL_GOODS_NOT_SELLING, 1009).          %% 已下架或被其他玩家抢先买走了。
-define(PM_MK_BUY_FAIL_MY_OWN_GOODS, 1010).               %% 不能购买自己挂售的物品
-define(PM_MK_FAIL_TARGET_GOODS_UNEXPIRED, 1011).     	  %% 物品还没有过期
-define(PM_MK_CANCEL_FAIL_GOODS_EXPIRED, 1012).           %% 物品挂售时间已过期，不能取消
-define(PM_MK_GETBACK_FAIL_GOODS_WAS_SOLD, 1013).         %% 物品已卖出
-define(PM_MK_CANT_BE_RESELLED_NOW, 1014).                %% 摆摊时间不足8小时的物品才可以被续期
-define(PM_MK_PLEASE_WAIT_TO_SEARCH, 1015).               %% 请勿过于频繁搜索
-define(PM_MK_SELL_FAIL_OVER_SELL_HOUR, 1016).            %% 超过了最长可挂售的时间
-define(PM_MK_STONE_LIMIT,  1017).                        %% 请先卸下装备上的宝石
-define(PM_VOUCHERS_NOT_EXISTS,  1018).                   %% 现金券不存在
-define(PM_VOUCHERS_CANNOT_USE,  1019).                   %% 该现金券不满足使用条件

% 雇佣系统提示（代号范围：从1200到1500）
-define(PM_HIRE_NOT_EXISTS, 1200).          %% 天将不存在
-define(PM_HIRE_COUNT_LIMIT, 1201).         %% 天将可被雇佣的次数不足
-define(PM_HAVE_HIRE, 1202).                %% 每个人只能雇佣一位天将呢~
-define(PM_HAVE_SIGN_UP, 1203).             %% 已经报名
-define(PM_HAVE_NOT_SIGN_UP, 1204).         %% 还没有报名
-define(PM_NO_INCOME, 1205).                %% 今天的卖身钱已经被你取光啦。
-define(PM_HAVE_NO_HIRE, 1206).             %% 你还没有雇佣天将哦~
-define(PM_LEFT_TIME_LIMIT, 1207).          %% 剩余次数不足
-define(PM_CANT_HIRE_ONESELF, 1208).        %% 自己雇佣自己是不可以的啦~
-define(PM_PRICE_CHANGE_TRY_AGAIN, 1209).   %% 对方的身价已经变了哦！请重新雇佣吧！
-define(PM_PRICE_CHANGE_COUNT_LIMIT, 1210). %% 修改身价的次数已经用完啦！

% 门客系统(1500~2000)
-define(PM_PAR_CARRY_LIMIT, 1500).                              % 携带门客数量达到可携带上限
-define(PM_PAR_NOT_EXISTS, 1501).                               % 门客信息不存在
-define(PM_PAR_CAPACITY_LIMIT, 1502).                           % 可携带数量达到上限！
-define(PM_PAR_NAME_LEN_ERROR,     1503).                       % 门客名字不能超过六个字
-define(PM_PAR_NAME_CHAR_ILLEGEL,  1504).                       % 名字不能有非法字符
-define(PM_PAR_JOIN_BATTLE_LV_LIMIT, 1505).                     % 参战等级限制
-define(PM_PAR_STATE_ERROR, 1506).                              % 门客状态错误，请稍候重试
-define(PM_PAR_INTIMACY_LIMIT, 1507).                           % 亲密度不足
-define(PM_PAR_WASH_ELIXIR_LIMIT, 1508).                        % 洗炼丹数量不足
-define(PM_PAR_EVOLVE_DAN_LIMIT, 1509).                         % 韬略丹数量不足
-define(PM_PAR_ALCHEMY_LIMIT, 1510).                            % 修炼材料数量不足
-define(PM_PAR_FOSSIL_LIMIT, 1511).                             % 修炼果数量不足！
-define(PM_PAR_LV_LIMIT,     1512).                             % 门客等级不够，请先练级
-define(PM_CULTIVATE_FAIL, 1513).                               % 修炼失败
-define(PM_PAR_LIFE_LIMIT, 1514).                               % 大侠我要吃福寿糕，寿命不够了~
-define(PM_PAR_QUALITY_LIMIT, 1515).                            % 官阶等级限制进化等级
-define(PM_PAR_LOYALTY_LIMIT, 1516).                            % 忠诚度不足
-define(PM_PAR_LV_MAX_LIMIT, 1517).                             % 门客等级达到上限
-define(PM_CANT_FREE_MAIN_PARTNER, 1518).                       % 主将不能解雇
-define(PM_CHANGE_MOOD_COUNT_LIMIT_TODAY, 1519).                % 不要再激励我了，今天我的心态都不会变了
-define(PM_FIGHT_PAR_COUNT_LIMIT1, 1520).                       % 要升到10级才能带2个门客出战
-define(PM_FIGHT_PAR_COUNT_LIMIT2, 1521).                       % 要升到20级才能带3个门客出战
-define(PM_FIGHT_PAR_COUNT_LIMIT3, 1522).                       % 要升到30级才能带4个门客出战
-define(PM_FIGHT_PAR_COUNT_LIMIT4, 1523).                       % 要升到40级才能带5个门客出战
-define(PM_MAIN_PAR_MUST_FIGHT, 1524).                          % 主将必须出战的
-define(PM_PAR_EXTEND_CAPACITY_GOODS_COUNT_LIMIT, 1525).        % 道具不足！
-define(PM_PAR_PLAYER_LV_LIMIT_FOR_BATTLE, 1526).               % 人物等级不足，没法召唤门客出战
-define(PM_PAR_CANT_FREE_WHEN_IN_BATTLE, 1527).                 % 选中门客处于出战状态，不能解雇！
-define(PM_PAR_PLAYER_LV_LIMIT_FOR_MAIN_PAR, 1528).             % 人物等级不足，不能把门客设为主将出战
-define(PM_PAR_CANT_WASH_WHEN_IN_LOCKED_STATE, 1529).           % 已锁定门客不能洗炼，请先解锁
-define(PM_PAR_NOT_ENTER_HOTLE_YET, 1530).                      % 大侠，你没有进入酒馆
-define(PM_PAR_ENTER_HOTEL_FREE_TIME_LIMIT, 1531).              % 大侠，免费进入酒馆招募的时间还没到
-define(PM_PAR_EVOLVE_LV_LIMIT, 1532).                          % 门客已经达到封爵上限
-define(PM_PAR_CANT_EVOLVE_WHEN_IN_LOCKED_STATE, 1533).         % 锁定门客不能封爵，请先解锁
-define(PM_PAR_CANT_SACRIFICE_WHEN_IN_LOCKED_STATE, 1534).      % 锁定门客不能合体，请先解锁
-define(PM_PAR_ENTER_HOTLE_LV_LIMIT,    1535).                  % 人物等级不足，不能进入
-define(PM_FIGHT_PAR_COUNT_LIMIT, 1536).                       	% 出战门客数量达到上限
-define(PM_CANT_SACRIFICE_MAIN_PARTNER, 1537).                  % 主将不能合体
-define(PM_PAR_IS_LOCKED, 1538).								% 大侠，请先解锁再进行操作
-define(PM_PAR_IS_FIGHTING, 1539).								% 门客处于参战状态，请先设置为休息状态
-define(PM_CANT_GET_EXP_BECAUSE_LV_DELTA,           1540).      % 门客等级已达到上限，不能再获取经验
-define(PM_CULTIVATE_MAX, 1541).                                % 修炼已为最高等级，不能再修炼
-define(PM_SKILL_EXPAND_SLOT_MAX, 1542).						% 技能格子已达到上限，无法扩展
-define(PM_AWAKE_BAN, 1543).									% 不可觉醒
-define(PM_AWAKE_EVOLVE, 1544).									% 觉醒所需进化等级不足，不可觉醒
-define(PM_AWAKE_CULTIVATE, 1545).								% 觉醒所需修炼等级不足，不可觉醒
-define(PM_AWAKE_LV_LOW, 1546).									% 觉醒等级不足

% 场景系统的提示（代号范围：从2001到2999）
-define(PM_SCENE_NOT_EXISTS, 2001).								% 场景不存在
-define(PM_BAD_POSITION, 2002).									% 位置非法
-define(PM_SCENE_SWITCH_CROSS_BAN, 2003).						% 请先退出此场景才可进行跨服操作



% 好友系统\结拜系统的提示（代号范围：从3000到3199）
-define(PM_RELA_FRIEND_COUNT_LIMIT, 3000).              % 你的好友人数达到上限。
-define(PM_RELA_OBJ_IS_YOUR_FRIEND, 3001).              % 对方已经是你的好友了
-define(PM_RELA_NOT_BUILT_OR_IS_DEL, 3002).             % 与对方尚未建立关系或对方已经删除好友关系
-define(PM_APPLY_COUNT_DAY_LIMIT, 3003).                % 当天申请添加好友次数已经用完，没法再申请。
-define(PM_RELA_MSG_OVERLENGTH, 3004).                  % 说话太快，请稍候重试。
-define(PM_RELA_CANT_ADD_YOURSELF, 3005).               % 不能添加自己为好友。
-define(PM_RELA_OBJ_REFUSE, 3006).                      % 对方拒绝了你的好友申请。
-define(PM_RELA_YOU_REFUSE, 3007).                      % 大侠你设置了禁止加好友，请检查设置。
-define(PM_OBJ_RELA_FRIEND_COUNT_LIMIT, 3008).          % 对方的好友人数达到上限
-define(PM_RELA_OBJ_MAX_OFFLINE_MSG, 3009).				% 对方离线消息满了，请稍候重试！
-define(PM_RELA_HAS_SWORN, 3010).						% 大侠，你已结拜过了！
-define(PM_RELA_MEMBER_NOT_ENOUGTH, 3011).				% 队伍人数不足哦，多找几个吧！
-define(PM_RELA_NO_SWORN, 3012).						% 大侠，你还没结拜或结拜关系被队长解除了
-define(PM_RELA_NO_MODIFY_COUNT, 3013).					% 大侠，称号不能修改了哦！
-define(PM_RELA_WAIT_LEADER_SURE, 3014).				% 大侠，队长还没确认称号，请稍后！
-define(PM_RELA_HAVE_TRY_SWORN, 3015).					% 大侠，已经发起结拜了，请稍后！
-define(PM_SWORN_NAME_LEN_ERROR, 			3016). 		% 称号长度不正确哦！
-define(PM_SWORN_NAME_CHAR_ILLEGEL, 			3017). 	% 称号不可以有邪恶的字哦！
-define(PM_RELA_CANT_DEL_SPOUSE, 3018).                 % 夫妻双方不能互删好友
-define(PM_RELA_PLEASE_ADD_FRDS, 3019).                 % 请先添加好友！

-define(PM_RELA_OBJ_IS_YOUR_ENEMY, 3020).              % 对方已经是你的仇人了

% 物品系统的提示（代号范围：从4000到4999）
-define(PM_GOODS_NOT_EXISTS, 				4000).   	% 物品不存在
-define(PM_GOODS_CANT_USE, 					4001).   	% 物品不可使用
-define(PM_GOODS_CANT_USE_ON_PLAYER, 		4002).   	% 这个道具不能对玩家使用。
-define(PM_GOODS_CANT_USE_ON_PARTNER, 		4003).   	% 这个道具不能对门客门客使用。
-define(PM_GOODS_CANT_USE_ON_MON, 			4004).   	% 这个道具不能对怪物使用。
-define(PM_US_BAG_FULL, 				    4005).   	% 包裹物品空间不足，请先整理。
-define(PM_STORAGE_FULL, 					4006).   	% 仓库空间满了，请先整理
-define(PM_STORAGE_SLOTS_NOT_ENOUGH, 		4008).   	% 仓库空间不足，请先整理
-define(PM_GOODS_CANT_USE_IN_BATTLE,        4009).      % 这个道具不能在战斗中使用。
-define(PM_LOCATION_ERR, 					4010).	 	% 位置错误
-define(PM_BAG_MAX_CAPACITY_LIMIT, 			4011).		% 包裹格子已达上限，不可再扩展
-define(PM_STORAGE_MAX_CAPACITY_LIMIT,		4012). 		% 仓库格子已达上限，不可再扩展
-define(PM_EQUIQ_POS_ERR, 					4013). 		% 这个装备不能穿这里的！
-define(PM_GOODS_CANT_EQUIPED, 				4014). 		% 这个道具不可装备
-define(PM_GOODS_CANT_DISCARD, 				4015).   	% 这个道具不可丢弃
-define(PM_GOODS_INVALID,					4016).      % 这个道具已经失效
-define(PM_GOODS_NOT_ENOUGH,                4017).      % 道具数量不足
-define(PM_GOODS_CANT_TRADE,                4018).      % 道具不可交易
-define(PM_ACCEPTED_TASK_COUNT_LIMIT,       4019).      % 你已经接了该任务了！
-define(PM_STREN_STONE_COUNT_LIMIT,         4020).      % 非绑定强化石数量不足
-define(PM_BIND_STREN_STONE_COUNT_LIMIT,    4021).      % 已绑定强化石数量不足
-define(PM_UNLOCK_BAG_GOODS_COUNT_LIMIT,    4022).      % 解锁包裹空间需要的神木或银币不足
-define(PM_STRENGTHEN_FAIL,                 4023).      % 强化进度增加，继续努力！
-define(PM_GOODS_USE_AREA_LIMIT,            4024).      % 道具使用区域限制
-define(PM_THE_PAR_HAVE_THE_SKILL,          4025).      % 已有同类技能，不能重复学习同类技能。
-define(PM_PAR_LIFE_IS_FULL,                4026).      % 我的寿命满了，再吃就撑死啦！
-define(PM_PAR_LOYALTY_IS_FULL,             4027).      % 门客忠诚度已满，不能使用该物品添加忠诚度
-define(PM_PAR_MP_IS_FULL,                  4028).      % 魔法值已满，无法使用该道具回复魔法值。
-define(PM_PAR_HP_IS_FULL,                  4029).      % 气血值已满，无法使用该道具回复气血值。
-define(PM_GOODS_NOT_EXISTS_OR_CANT_USE,    4030).      % 物品不存在或者因位置有误不可使用
-define(PM_GOODS_WHITE_CANT_BE_DECOMPOSED,  4031).      % 白色品质的装备不可分解
-define(PM_MAX_STREN_LV_LIMIT,              4032).      % 已达到最大强化等级，不能再强化了
-define(PM_CAN_USE_COUNT_IS_OVER,           4033).      % 该时间段内该道具可用次数已达到上限。
-define(PM_PAR_HAVE_SAME_TYPE_SKILL,        4034).      % 已经有相同类型的技能
-define(PM_GOODS_NOT_EQUIP,                 4035).      % 非装备，不能这样操作！
-define(PM_GOODS_EQUIP_GEM_HOLE_LIMIT,      4036).      % 装备宝石孔达到上限了
-define(PM_GOODS_EQUIP_GEM_HOLE_OPENED,     4037).      % 装备该宝石孔已经开启了
-define(PM_GOODS_EQUIP_NOT_APPLICABLE_GEM,  4038).      % 该宝石不能镶嵌在这个装备上
-define(PM_GOODS_EQUIP_HOLE_NOT_OPENED,     4039).      % 大侠，请先开启装备的宝石孔！
-define(PM_GOODS_EQUIP_NOT_INLAY_GEM,       4040).      % 大侠，装备还没镶嵌宝石
-define(PM_UNUS_BAG_FULL,                   4041).      % 包裹材料格不足，请先整理吧！
-define(PM_EQ_BAG_FULL,                     4042).      % 包裹装备格不足，请先整理吧！
-define(PM_BAG_FULL,                        4043).      % 包裹空间不足，请先整理！
-define(PM_TEMP_BAG_FULL,					4044).		% 临时包裹已满，无法获得物品，请及时清理！
-define(PM_GOODS_CANT_USE_WHEN_IN_TEAM,     4045).      % 在组队状态下不可使用该道具哦！
-define(PM_GOODS_TRS_LIMIT,                 4046).      % 强化转移只能转到同等级或等级更高的装备哦！
-define(PM_GOODS_SRC_EQ_NOT_STREN,          4047).      % 材料装备的强化等级不足！
-define(PM_GOODS_TRS_STREN_LV_LIMIT,        4048).      % 请选择更高强化等级的材料！
-define(PM_GOODS_QUALITY_LIMIT,             4049).      % 你的装备品质过低！
-define(PM_GOODS_QUALITY_MAX,               4050).      % 你的装备已经达到品质最高级了！
-define(PM_GOODS_REFINE_LV_MAX,             4051).      % 该等级的装备已经达到精炼顶级了！
-define(PM_GOODS_LV_MAX,                    4052).      % 大侠，你的装备已经达到等级顶级了！
-define(PM_GOODS_SPAWN_MON_AREA_ERROR,      4053).      % 请找到正确的刷怪位置使用物品！
-define(PM_GOODS_DIG_AREA_ERROR,            4054).      % 藏宝图位置不对！
-define(PM_MK_SKILL_LV_LIMIT,               4055).      % 大侠,法宝技能已达最高级！
-define(PM_MK_QUALITY_LIMIT,                4056).      % 大侠,请先强化品质！
-define(PM_ROLE_CONTRI_LIMIT,               4057).      % 大侠,功绩不够，快点做成就吧！
-define(PM_PAR_INBORN_SKILL_FULL,           4058).      % 主动技能已满！
-define(PM_GOODS_CANT_USE_WITHOUT_FACTION,  4059).      % 大侠，请加入门派后使用
-define(PM_GOODS_NOT_EXCHANGE,              4060).      % 这个道具不能兑换！
-define(PM_GOODS_NOT_TRANSFORM,             4061).      % 这个道具不能转换！
-define(PM_GOODS_EQUIP_NOT_STUNT,           4062).      % 该装备无特技，无法洗炼！
-define(PM_GOODS_EQUIP_NOT_EFFECT,          4063).      % 该装备无特效，无法洗炼！
-define(PM_EQUIP_NOT_ENOUGH_CONDITION,      4064).      % 您的装备不满足洗炼转移条件！

% 组队系统、阵法相关提示（代号范围：从5000到5500）
-define(PM_ALREADY_IN_TEAM, 				5000). 		% 你已经在队伍中了
-define(PM_TEAM_NOT_EXISTS, 				5001). 		% 队伍不存在或者已经被解散了
-define(PM_TEAM_IS_FULL, 					5002). 		% 队伍已经满人了
-define(PM_HAVE_APPLIED, 					5003). 		% 已经向该队发出申请入队消息，正在处理
-define(PM_NOT_TEAM_LEADER, 				5004). 		% 你不是队长
-define(PM_TEAM_IN_BATTLE, 					5005). 		% 队伍正在战斗中。
-define(PM_PLAYER_TMP_LEAVE, 				5006). 		% 玩家暂时离开队伍
-define(PM_PLAYER_OFFLINE_OR_NOT_EXISTS, 	5007). 		% 对方已下线或不存在
-define(PM_NOT_IN_TEAM, 					5008). 		% 你不在队伍中或已被队长请离了
-define(PM_IS_ALREADY_LEADER, 				5009). 		% 你已是队长
-define(PM_REFUSE_YOUR_LEADER_APPLY, 		5010). 		% 队长拒绝你申当队长的申请。
-define(PM_LEADER_CANT_TMP_LEAVE, 			5011). 		% 队长是不能暂离
-define(PM_TEAM_NAME_LEN_ERROR, 			5013). 		% 队伍名字长度需要1~9个汉字哦！
-define(PM_TEAM_NAME_CHAR_ILLEGEL, 			5014). 		% 队伍名字不能有非法字符！
-define(PM_HAVE_INVITED,					5015).		% 已发出邀请消息，请耐心等候！
-define(PM_NOT_IN_SAME_SCENE,               5016).      % 不在同一个场景
-define(PM_CANT_TMP_LEAVE_WHEN_IN_DUNGEON,  5017).      % 在副本里不能暂离
-define(PM_CANT_APPLY_WHEN_IN_DUNGEON,      5018).      % 在副本中不能申请加入哦！
-define(PM_CANT_JOIN_WHEN_IN_DUNGEON,       5019).      % 该玩家在副本中不可加入队伍
-define(PM_ALREADY_IN_OTHER_TEAM,           5020).      % 该玩家已有队伍了。
-define(PM_OBJ_NOT_IN_TEAM,                 5021).      % 对方不在队伍中
-define(PM_TEAM_NEED_LV_LIMIT,              5022).      % 对方等级不够，不能组队
-define(PM_HAVE_RETURN_TEAM_OK,             5023).      % 归队成功
-define(PM_TM_OBJ_REFUSE_TEAM,              5024).      % 对方拒绝和你组队
-define(PM_TM_OBJ_REFUSE_LEADER,            5025).      % 对方拒绝担任队长
-define(PM_CANT_RETURN_TM_WHEN_TM_IN_DUNGEON,   5026).  % 队伍在副本中不能归队
-define(PM_CANT_RETURN_TM_WHEN_YOU_IN_DUNGEON,  5027).  % 在副本中不能归队
-define(PM_CANT_CREATE_TM_WHEN_YOU_IN_DUNGEON,  5028).  % 在副本中不能创建队伍
-define(PM_CANT_JOIN_WHEN_IN_GUILD,       	5029).      % 你在帮派场景中，不可以允许其他帮派玩家入队！
-define(PM_CANT_AGREE_WHEN_IN_GUILD,       	5030).      % 队长在帮派场景中，你不是对方的帮派同学不能入队！
-define(PM_TM_LEADER_OFFLINE,       		5031).      % 队长断线重连中，请耐心等候！
-define(PM_TM_OBJ_IN_TEAM,                 	5032).      % 对方已在队伍中了
-define(PM_CANT_JOIN_WHEN_LEADER_IN_MELEE,  5033).      % 队长在门客乱斗场景中，不可以入队！
-define(PM_CANT_RETURN_WHEN_LEADER_IN_MELEE,5034).		% 队长在门客乱斗场景中，不可以归队！
-define(PM_CANT_AGREE_WHEN_IN_MELEE,       	5035).      % 你在门客乱斗场景中，不可以允许其他场景的玩家入队！
-define(PM_TM_WAIT_MB_CONFIRM,              5036).      % 正在等待队伍队员确认进入活动，请耐心等候！
-define(PM_TM_AIM_NOT_THE_SAME,             5037).      % 组队目标不一样
-define(PM_TM_LEAVE_TEAM_FIRST,             5038).      % 请先离开队伍!
-define(PM_TM_BUSY_NOW,                     5039).      % 队伍正在忙，请稍候再试！
-define(PM_TM_ZF_LEARN_PRE_ZF_FIRST,        5040).      % 请先学习前置阵法！
-define(PM_TM_ZF_HAVE_LEARN_ZF,             5041).      % 你已经学习了该阵法！
-define(PM_TM_ZF_NOT_USABLE,                5042).      % 当前阵法不可用哦！

% 战斗系统的提示（代号范围：从5501到6000）
-define(PM_BT_MON_BATTLING,   					5501).      % 怪物已经在战斗中
-define(PM_BT_TARGET_BO_NOT_EXISTS,   			5502).      % 目标不存在
-define(PM_BT_TARGET_BO_ALRDY_DEAD,   			5503).      % 目标已经死亡
-define(PM_BT_MON_ALRDY_EXPIRED,   			    5504).      % 怪物已失效，没法操作。
-define(PM_BT_ALRDY_AUTO_BATTLE,   				5505).      % 已经是自动战斗了
-define(PM_BT_NOT_AUTO_BATTLING,   				5506).      % 你不处于自动战斗状态，操作无效
-define(PM_BT_SERVER_NOT_WAITING_CLIENTS_FOR_SHOW_BR_DONE, 5507). % 服务器忙
-define(PM_BT_SERVER_NOT_WAITING_CLIENTS_FOR_PREPARE_CMD_DONE, 5508). % 服务器忙


-define(PM_BT_FAIL_FOR_ALRDY_DEAD, 			5510). 		% 你已经死亡，没法操作
-define(PM_BT_FAIL_FOR_BATTLE_FINISHED, 	5511).		% 战斗已经结束，没法操作
-define(PM_BT_FAIL_FOR_ALRDY_PREPARED_CMD, 	5512).		% 你已经下达过指令了，没法操作
-define(PM_BT_FAIL_FOR_CDING, 				5513).		% 行动冷却中，没法操作
-define(PM_BT_FAIL_FOR_XULIING, 			5514).		% 行动冷却中，没法操作
-define(PM_BT_FAIL_FOR_CANNOT_ACT, 			5515).		% 当前回合不能行动，没法操作
-define(PM_BT_FAIL_FOR_FORCE_AUTO_ATTACK, 	5516).		% 处于自动攻击状态，没法操作


-define(PM_REQ_USE_SKL_FAIL_CONDITION_LIMIT, 5520).    	% 不符合所选技能的使用条件
-define(PM_REQ_USE_SKL_FAIL_IS_TRANCE, 5521).    	    % 你处于异常状态，不能使用技能。
-define(PM_REQ_USE_SKL_FAIL_HP_NOT_ENOUGH, 	5522).		% 气血不足，不能使用技能。
-define(PM_REQ_USE_SKL_FAIL_HP_TOO_MUCH, 	5523).		% 气血不符合施放技能的要求。

-define(PM_PROTECT_FAIL_IS_TRANCE, 5530).    	        % 处于异常状态中，不能保护别人。

-define(PM_BT_TARGET_CANNOT_FIGHT_WITH_YOU, 	5540).						% 对方正在忙
% -%%define(PM_BT_START_FORCE_PK_FAIL_FOR_IN_TEAM, 	5541).						% 组队状态下不能发起决斗
-define(PM_BT_TARGET_NOT_ACCEPT_QIECUO_PK,      5542).      				% 对方没有接受切磋要求
-define(PM_BT_PK_LV_LIMIT,                    	5543).      				% 请提升等级再PK吧！
-define(PM_BT_TARGET_PK_LV_LIMIT,               5544).      				% 对方还没达到PK等级，换个对手吧！
-define(PM_BT_TARGET_PK_PROTECT,               	5545).      				% 对方处于PK保护阶段，请耐心等候！
-define(PM_BT_START_FORCE_PK_FAIL, 				5546).      				% 必须双方都在野外才可以进行偷袭！
-define(PM_BT_NOT_IN_LEITAI_AREA, 				5547).      				% 只有在邯郸的擂台内才能进行切磋
-define(PM_BT_TARGET_NOT_IN_LEITAI_AREA, 		5548).      				% 对方不在邯郸城的擂台内，无法切磋
-define(PM_BT_CANNOT_START_PK_TO_TEAMMATE,      5549).      				% 不能向队友发起切磋或决斗
% -%%define(PM_BT_START_QIECUO_FAIL_FOR_TARGET_IN_TEAM_BUT_NOT_LEADER, 5550). 	% 对方在队伍中但不是队长，无法向其发起切磋
-define(PM_BT_PK_IN_CD,                         5550).                      % 你的魔法值不足，请稍候重试！
-define(PM_BT_PK_DELTA_LV_LIMIT,                5551).                      % 你挑战的玩家等级过低，不能决斗


% 帮派系统的提示（代号范围：从6001到6500）
-define(PM_GUILD_NAME_LEN_ERROR,                6001).      % 你输入的帮派名称过长，请检查帮派名称后重试。
-define(PM_HAVE_IN_GUILD,                       6002).      % 玩家已加入其他帮派了。
-define(PM_GUILD_NAME_OCCUPIED,                 6003).      % 帮派名称已被占用，请重试取名。
-define(PM_HAVE_APPLIED_THE_GUILD,              6004).      % 你的申请正在审核中。
-define(PM_GUILD_MEMBER_COUNT_LIMIT,            6005).      % 帮派人数满了，快快升级帮派吧！
-define(PM_GUILD_APPLY_COUNT_LIMIT,             6006).      % 帮派申请人数达到申请最高上限。
-define(PM_GUILD_POWER_LIMIT,                   6007).      % 你没有权限。
-define(PM_NOT_APPLY_THE_GUILD,                 6008).      % 玩家没有申请入帮。
-define(PM_GUILD_NOT_EXISTS,                    6009).      % 帮派不存在或已经解散了。
-define(PM_NOT_IN_GUILD,                        6010).      % 你没有加入帮派，请先加入帮派
-define(PM_TENET_LEN_ERROR,                     6011).      % 帮派宗旨过长，请检查宗旨内容后重试！
-define(PM_TENET_CHAR_ILLEGEL,                  6012).      % 帮派宗旨包含非法字符
-define(PM_GUILD_NAME_CHAR_ILLEGEL,             6013).      % 帮派名称包含非法字符
-define(PM_GUILD_BRIEF_LEN_ERROR,               6014).      % 帮派简介的长度有误
-define(PM_GUILD_BRIEF_CHAR_ILLEGEL,            6015).      % 帮派简介包含非法字符
-define(PM_POS_MEMBER_COUNT_LIMIT,              6016).      % 当前职务已达到最大人数，不能再设置。
-define(PM_CANT_ENTER_GUILD_SCENE_WHEN_IN_TEAM, 6017).      % 组队状态下不能进入帮派地图。
-define(PM_ALRDY_IN_GUILD_SCENE, 				6018).      % 你已在帮派场景中了
-define(PM_NO_GUILD_PAY_CAN_GET,                6019).      % 没有帮派分红可以领取
-define(PM_HAVE_GOT_THE_PAY,                    6020).      % 今天已领取过了
-define(PM_GUILD_PARTY_NOT_OPENED,              6021).      % 帮派大会没开始或已经结束，请稍候重试
-define(PM_GUILD_DUNGEON_NOT_OPENED,            6022).      % 帮派副本没开始或已经结束，请稍候重试
-define(PM_GUILD_DUNGEON_HAVE_COLLECTED,        6023).      % 你慢了一步，已经被采集
-define(PM_GUILD_ATTR_NOT_OPENED_YET,           6024).      % 点修技能还没开放
-define(PM_GUILD_CULTIVATE_LV_LIMIT,            6025).      % 点修技能达到本帮派的上限！
-define(PM_GUILD_DONATE_TODAY_LIMIT,            6026).      % 今天捐献额度不足
-define(PM_GUILD_PARTY_HAVE_THE_DISHES,         6027).      % 帮派大会已插上这个战旗，请选其他战旗。
-define(PM_GUILD_APPOINT_POSITION_OK,           6028).      % 已任命成功
-define(PM_GUILD_HAVE_JOIN_DUNGEON,             6029).      % 你已参加过帮派副本
-define(PM_OBJ_NOT_IN_GUILD,                    6030).      % 对方没有加入帮派
-define(PM_GUILD_WAR_NOT_OPENED,                6031).      % 帮派争夺战还没开始或已经结束了
-define(PM_GUILD_PRE_WAR_NOT_OPENED,            6032).      % 帮派争夺战还没开始签到，稍后再来吧！
-define(PM_GUILD_NOT_SIGN_IN,                   6033).      % 帮派没有报名参加帮派争夺战哦！
-define(PM_GUILD_NOT_SIGN_IN_TIME,              6034).      % 帮派争夺战这个时间点不能报名哦！
-define(PM_GUILD_WAR_OVER,                      6035).      % 帮派争夺战结束了，下次再来吧！
-define(PM_GUILD_CANT_ENTER_WAR_IN_TEAM,        6036).      % 组队状态下不能进入帮派争霸赛！
-define(PM_GUILD_HAVE_JOINED_THE_TURN_WAR,      6037).      % 你已参加过本届帮派争霸赛，下届再来吧！
-define(PM_GUILD_OBJ_IS_ONE_OF_US,              6038).      % 对方是你的战友！
-define(PM_GUILD_OBJ_BUSY_NOW,                  6039).      % 对方正在应战，请选择其他对手！
-define(PM_GUILD_PRE_WAR_END,                   6040).      % 帮派争夺战签到结束了，下次按时过来哦！
-define(PM_GUILD_WAR_ING,                       6041).      % 在本届帮派争霸赛结束后才可以解散帮派
-define(PM_GUILD_IN_WAR,                        6042).      % 正在参加帮派争霸赛的队员，不能离队哦
-define(PM_GUILD_MB_PHY_POWER_LIMIT,            6043).      % 你的队友体力不足!
-define(PM_GUILD_PROHIBIT_MB_JOIN,              6044).      % 该帮派禁止申请入帮
-define(PM_GUILD_MB_JOIN_CD,                    6045).      % 还在加入帮派冷却时间
-define(PM_GUILD_SHOP_PURVHARE_CD,              6046).      % 重新加入帮派12小时后才能购买！

% 心法、技能系统的提示（代号范围：从6501到6999）
-define(PM_XF_ALRDY_MAX_LV,         		6501).      % 心法已达最高等级
-define(PM_XF_LOCKED,         				6502).      % 这心法还没解锁
-define(PM_XF_ALRDY_ACTIVATED,         		6503).      % 心法已觉醒
-define(PM_XF_UPGRADE_FAIL_FOR_PLAYER_LV_LIMIT,    6504).     % 心法等级不能超过玩家等级
-define(PM_XF_UPGRADE_FAIL_FOR_MASTER_XF_LV_LIMIT, 6505).     % 副心法等级不能超过主心法等级

% 运镖
-define(PM_TS_TRUCK_NOTEXISTS, 6600).           % 大侠，该镖车不存在
-define(PM_TS_INFO_NOTEXISTS, 6601).                 % 大侠，没有相关运镖信息
-define(PM_TS_MAX_LV, 6602).                 % 大侠，镖车已达最高等级
-define(PM_TS_NOT_IN_FREE, 6603).               % 大侠，已有镖车在运输
-define(PM_TS_MAX_BEHIJACK, 6604).               % 大侠，镖车已到达被劫上限
-define(PM_TS_MAX_HIJACK, 6605).               % 大侠，已到达劫镖次数上限
-define(PM_TS_MAX_TRANSPORT, 6606).             % 大侠，已到达运镖最大次数上限
-define(PM_TS_IMMUNE_ATTACK, 6607).             % 大侠，镖车免疫劫镖事件生效中
-define(PM_TS_TRUCK_OUT, 6608).                 % 大侠，镖车在战斗胜利前已经到达终点
-define(PM_TS_SELF_TRUCK, 6609).                % 大侠，不能劫自己镖车
-define(PM_TS_LOST_TRUCK, 6610).                % 大侠，镖车已经被别人捷足先登
-define(PM_TS_TEAM, 6611).                      % 大侠，不能组队劫镖
-define(PM_TS_FREE_TIMESOUT, 6612).             % 大侠，免费次数已用光

% 内功
-define(PM_ART_NOT_EXISTS, 6700).                   % 内功信息不存在
-define(PM_ART_LV_MAX_LIMIT, 6703).                 % 内功等级达到上限
-define(PM_CANT_GET_EXP_BECAUSE_LV_TOP, 6704).      % 内功等级已达到上限，不能再获取经验
-define(PM_ART_NUM_FULL, 6705).                     % 内功已满，请先强化内功
-define(PM_ART_SLOT_FULL, 6706).                    % 没有可装备的内功格子，请先提升等级
-define(PM_EAT_ART_MAX_NUM, 6707).                  % 每次只能吞噬10个内功
-define(PM_ART_ISEQUIPED_PARTNER, 6708).            % 请先脱下门客佩戴的所有内功再来解雇门客
-define(PM_ART_BIGGER_PARTNER_LV, 6709).            % 内功等级不能超过门客等级，请卸下再升级
-define(PM_ART_ISEQUIPED_PARTNER_TRANSMIT, 6710).   % 请先脱下门客佩戴的所有内功再来传承门客
-define(PM_ART_SAME_NOT_EQUIP, 6711).               % 相同类型的内功只能佩戴一个
-define(PM_ART_OPEN_LV_NOT_ENOUGH, 6712).           % 宠物等级未达到功法格子解锁等级要求
-define(PM_ART_NOT_REPEAT, 6713).                   % 不能重复解锁
-define(PM_ART_NUM_FULL_1, 6714).                   % 内功已满，请先拾取

% 装备幻化
-define(PM_TAR_EQUIP_NOT_EXISTS, 6800).             % 目标装备不存在
-define(PM_EQUIP_NOT_EXISTS, 6801).                 % 材料装备不存在
-define(PM_EQUIP_IS_NOT_BUILD, 6802).               % 目标装备必须是打造出来的
-define(PM_EQUIP_LV_NOT_SAME, 6803).                % 目标装备和材料装备等级不同
-define(PM_EQUIP_TYPE_NOT_SAME, 6804).              % 目标装备和材料装备类型不同
-define(PM_TAR_EQUIP_STREN_LV_NOT_CONFORM, 6805).   % 目标装备必须强化到20级
-define(PM_NOT_HAVE_REF_ATTRS_AND_EFFNO, 6806).     % 没有可获取的附加属性和特效
-define(PM_GOOD_HAS_GEM, 6807).                     % 此材料装备已镶嵌宝石，请摘除后再来


% task
-define(TASK_NO_FIND_MON, 7000).        %怪物不存在
-define(PM_TASK_CAN_NO_IN_TEAM, 7001).  % 不可在组队状态下
-define(PM_TASK_TASK_NOT_ACCEPT, 7002). % 任务未接取
-define(PM_TASK_GOODS_CAN_FINISH_NOT_ACCEPTED, 7003). % 你还没领取使用物品可完成的任务！

% mail
-define(PM_MAIL_NOT_EXISTS, 7101).      %邮件不存在
-define(PM_ATTACH_NOT_EXISTS, 7102).    %附件不存在
-define(PM_ROLE_NOT_EXISTS, 7103).      %玩家不存在
-define(PM_MAIL_SEND_SELF, 7104).       %不可给自己发邮件
-define(PM_MAIL_WRONG_TITLE, 7105).     %标题错误
-define(PM_MAIL_WRONG_CONTENT, 7106).   %内容错误



%% activity degree
-define(PM_AD_REPEAT_GET, 7201).        % 重复领取




%% offline_arena
-define(PM_OFFLINE_ARENA_TEAM_LIMIT, 7301).     % 组队状态下不能参加竞技场挑战
-define(PM_OFFLINE_ARENA_RANKING_UN_OPEN, 7302). % 你的竞技场排名尚未统计
-define(PM_OFFLINE_ARENA_RANKING_CALING, 7303).  % 你的排名结算中，请稍候
-define(PM_OFFLINE_ARENA_CHALL_NOT_CD, 7304).    % 你的挑战不在冷却中
-define(PM_OFFLINE_ARENA_CHALL_NOT_TIMES, 7305). % 你的挑战次数不足
-define(PM_OFFLINE_ARENA_BUY_CHALL_NOT_TIMES, 7306). % 你可购买挑战次数不足
-define(PM_OFFLINE_ARENA_REWARD_NOT_ENGOUTH_CONDITION, 7307). % 你领取奖励的条件不足
-define(PM_OFFLINE_ARENA_CHALL_IN_CD, 7308).    % 挑战在冷却中
-define(PM_OFFLINE_ARENA_NOT_FOUND_REWARD, 7309).    % 找不到你的奖励，请检查你的网络。
-define(PM_OFFLINE_ARENA_RANK_TIMEOUT, 7310).   % 当前竞技场数据已失效，请重新打开竞技场界面获得最新数据


%% 离线挂机
-define(PM_OFFLINE_AWARD_0_MINUTE, 7331).    % 挂机不足1分钟，不能获得经验
-define(PM_OFFLINE_AWARD_NOT_ENOUGH_MONEY, 7332).    % 银币不足，请使用免费领取。
-define(PM_OFFLINE_AWARD_NOT_IDLE, 7333).    % 非空闲状态不能离线挂机。

%% dungeon
-define(PM_DUNGEON_TIMES_OVERFLOW, 7350).       % 进入副本次数已满，副本令可增加次数。

-define(PM_DUNGEON_TEAM_STATUS, 7351).          % 队伍状态异常
-define(PM_DUNGEON_BOX_NO_FOUND, 7352).         % 你的操作太频繁了
-define(PM_DUNGEON_BOSS_CD, 7353).                  %% 处于挑战世界BOSS冷却时间中
-define(PM_DUNGEON_NOT_EXISTS, 7354).               %% 副本活动已经结束
-define(PM_DUNGEON_OUSIDE, 7355).               % 已经在副本外
-define(PM_DUNGEON_INSIDE, 7356).               % 已经在副本内
-define(PM_DUNGEON_NOT_LEADER, 7358).               % 必须由队长才能操作

-define(PM_TOWER_NO_CHAL_TIMES, 7380).          % 所在进度层挑战次数已用光，先清除进度再来吧
-define(PM_DUNGEON_PLEASE_LEAVE, 7381).         % 请先离开副本！
-define(PM_DUNGEON_BOSS_YIJIR_CD, 7383).        % 处于挑战异界统领BOSS冷却时间中



%% 战斗外buff系统
-define(PM_BUFF_NOT_EXISTS, 7401).              % buff状态不存在或已过期
-define(PM_BUFF_IS_OVERLAP, 7402).              % buff状态已经达到最大重叠上限

%% 每日签到与在线奖励
-define(PM_HAVE_SIGN_IN_TODAY, 7501).               %% 已签到过了
-define(PM_HAVE_GET_THE_REWARD, 7502).              %% 已领取过这个奖励
-define(PM_HAVE_NOT_SIGN_IN, 7503).                 %% 还没有签过到
-define(PM_GET_ONLINE_REWARD_OVER, 7504).           %% 已经领取完当天的在线奖励
-define(PM_GET_REWARD_ONLINE_TIME_LIMIT, 7505).     %% 未达到领取在线奖励的时间
-define(PM_GET_SIGN_REWARD_TIME_LIMIT, 7506).       %% 签到次数还没达到领取奖励的要求
-define(PM_GET_SEVEN_DAY_REWARD_TIME_LIMIT, 7507).  %% 还没达到领取注册7天奖励的时间
-define(PM_SEVEN_DAY_REWARD_EXPIRE, 7508).          %% 该注册7天奖励已过期



%% 章节目标
-define(PM_CHAPTER_TARGET_NO_FOUND_DATA, 7601).     %% 找不到指定章节成就
-define(PM_CHAPTER_TARGET_HAD_GET_REWARD, 7602).    %% 已经领取过奖励
-define(PM_CHAPTER_TARGET_NOT_COMPLETED, 7603).     %% 章节成就未完成


%% 活动相关
-define(PM_ACTIVITY_ANSWER_NOT_OPEN, 7701).         %% 答题活动未开启
-define(PM_ACTIVITY_ANSWER_UNKNOW_ACEPACK, 7702).   %% 非法锦囊
-define(PM_ACTIVITY_ANSWER_ACEPACK_USED, 7703).     %% 锦囊已被使用，同一题目不可多个使用
-define(PM_ACTIVITY_ANSWER_ACEPACK_RUNOUT, 7704).   %% 锦囊次数不足
-define(PM_ACTIVITY_ANSWER_QU_NOMATCH, 7705).       %% 题目与服务器不匹配
-define(PM_ACTIVITY_ANSWER_OVER, 7706).             %% 答题活动已经结束
-define(PM_ACTIVITY_ANSWER_REWARD_ERROR1, 7707).    %% 答题奖励还不能领取
-define(PM_ACTIVITY_ANSWER_REWARD_ERROR2, 7708).    %% 答题奖励已经领取过
-define(PM_ACTIVITY_ANSWER_LV_NO_ENOUGH, 7709).     %% 未达到参加答题需要的等级

-define(PM_ACTIVITY_OVER, 7710).                    %% 活动已关闭

-define(PM_ACTIVITY_SNOWMAN_LIMIT, 7711).           %% 雪球数已达到上限

-define(PM_LOTTERY_LIMIT, 7712).                    %% 大侠，你的彩票不足
-define(PM_ACTIVITY_LOTTERY_OVER, 7713).                        %% 限时抽奖活动已经结束
-define(PM_LOTTERY_FREE_TIMES_LIMIT, 7714).                     %% 大侠，你已经免费抽奖过了



%% 充值相关
-define(PM_RECHARGE_NOT_RECHARGE, 7801).            %% 没有充值过
-define(PM_RECHARGE_FIRST_REWARD_ALREADY, 7802).	%% 不可领取

%% 巡游活动相关（代号范围：8000~8099）
-define(PM_CRUISE_TIMES_LIMIT, 8000).     					%% 你已经完成活动了，下次再来找我哟！
-define(PM_CRUISE_ACTIVITY_NOT_OPEN, 8001). 				%% 活动还未开启，没法参与活动
-define(PM_CRUISE_NPC_NOT_WAITING_PLAYER_TO_JOIN, 8002).  	%% npc当前不接受玩家报名参与活动
-define(PM_ALRDY_REQ_JOIN_CRUISE, 8003).					%% 已经报过名了，无需重复报名
-define(PM_REQ_JOIN_FAIL_FOR_QUOTA_LIMIT, 8004).			%% 报名人数已满，请等待下一波的报名
-define(PM_REQ_JOIN_FAIL_FOR_IN_TEAM, 8005).				%% 组队状态下无法加入活动，请先离开队伍



%% 推广系统相关（代号范围：8100~8199）
-define(PM_INVALID_SPRD_CODE, 8100).     					%% 邀请码无效
-define(PM_TARGET_SPRD_RELA_FULL, 8101).     				%% 该名玩家的邀请次数已用完，请换个人邀请你吧
-define(PM_SELF_SPRD_CODE, 8102).                           %% 你输入的好友邀请码为本人的邀请，请核对后重新输入
-define(PM_SPRD_FAIL_LV_LIMIT, 8103).                       %% 大侠，你已经超过24级，不能被邀请啦~

%% 门客选美相关（代号范围:8200~8299）
-define(PM_BEAUTY_CONTEST_ERROR_NO_OPEN, 8200).                     %% 活动未开启
-define(PM_BEAUTY_CONTEST_GAMBLE_ERROR_UNKNOWN, 8201).              %% 抽奖失败
-define(PM_BEAUTY_CONTEST_GAMBLE_ERROR_GOODS_NO_ENOUGH, 8202).      %% 抽奖道具不足
-define(PM_BEAUTY_CONTEST_GAMBLE_ERROR_BYUANBAO_NO_ENOUGH, 8203).   %% 抽奖绑金不足
-define(PM_BEAUTY_CONTEST_GAMBLE_ERROR_BAG_FULL, 8204).             %% 格子空间不足
-define(PM_BEAUTY_CONTEST_RESET_ERROR_UNKNOWN, 8205).               %% 重置失败
-define(PM_BEAUTY_CONTEST_RESET_ERROR_BYUANBAO_NO_ENOUGH, 8206).    %% 重置绑金不足

%% 门客乱斗相关 （代号范围: 8300~8399）
-define(PM_MELEE_ERROR_NO_OPEN, 8300).                      %% 乱斗活动未开启
-define(PM_MELEE_ERROR_LV_LIMIT, 8301).                     %% 等级不够
-define(PM_MELEE_ERROR_ALREADY_FINISH, 8302).               %% 你或者队伍中有人已经完成门客乱斗
-define(PM_MELEE_ERROR_ALREADY_APPLY, 8303).                %% 你或者队伍中有人已经报名门客乱斗
-define(PM_MELEE_ERROR_NO_APPLY, 8304).                     %% 你或者队伍中有人未报名门客乱斗
-define(PM_MELEE_ERROR_APPLY_NOT_LEADER, 8305).             %% 在队伍中需要队长才能操作
-define(PM_MELEE_ERROR_APPLY_TEAM_STATUS, 8306).            %% 队伍状态异常
-define(PM_MELEE_ERROR_APPLY_TEAM_LV_LIMIT, 8307).          %% 你或者队伍中有人等级不符合
-define(PM_MELEE_ERROR_TM_NO_RETURN, 8308).                 %% 有队员未归队不能参加门客乱斗
-define(PM_MELEE_ERROR_BALL_NUM_ENOUGH, 8309).              %% 大侠，打宝宝最多获取4颗龙珠
-define(PM_MELEE_ERROR_LEAVE_TEAM_CANT_BATTLE, 8310).       %% 大侠，离队后1分钟内无法发起决斗
-define(PM_MELEE_ERROR_TICK_TEAM_MEMBER_CANT_BATTLE, 8311). %% 大侠，踢出队员后1分钟内无法发起决斗

%% 悬赏任务相关 （代号范围: 8400~8419）
-define(PM_XS_TASK_ERROR_SYS, 8400).                    %% 悬赏任务操作失败
-define(PM_XS_TASK_ERROR_ISSUE_LV_LIMIT, 8401).         %% 大侠，你的等级不够,不能发布悬赏任务
-define(PM_XS_TASK_ERROR_ISSUE_NUM_LIMIT, 8402).        %% 大侠，你的剩余发布次数不足，不能发布悬赏任务
-define(PM_XS_TASK_ERROR_ISSUE_MONEY_LIMIT, 8403).      %% 大侠，你的金子不足，不能发布悬赏任务
-define(PM_XS_TASK_ERROR_RECEIVE_NO_EXIST, 8404).       %% 大侠，该悬赏任务已经被领取完
-define(PM_XS_TASK_ERROR_HAS_XS_TASK, 8405).            %% 大侠，你身上还有未完成的悬赏任务，无法再次领取悬赏任务
-define(PM_XS_TASK_ERROR_RECEIVE_NUM_LIMIT, 8406).      %% 大侠，你可领取悬赏任务的次数不足，不能领取悬赏任务
-define(PM_XS_TASK_ERROR_RECEIVE_YOUR_TASK, 8407).      %% 大侠，这是你发布的悬赏任务，不能领取
-define(PM_XS_TASK_ERROR_RECEIVE_LV_LIMIT, 8408).       %% 大侠，你的等级不够，不能领取该悬赏任务

%% 跑马场相关 （代号范围: 8420~8439）
-define(PM_HORSE_RACE_ERROR_SYS, 8420).                     %% 跑马场系统错误
-define(PM_HORSE_RACE_ERROR_CLOSE, 8421).                   %% 大侠，跑马场已经结束，请下次再来参加
-define(PM_HORSE_RACE_ERROR_NO_OPEN, 8422).                 %% 大侠，跑马场还未开启，请稍后再来参加
-define(PM_HORSE_RACE_ERROR_LV_LIMIT, 8423).                %% 大侠，你的等级不够，不能参加竞猜
-define(PM_HORSE_RACE_ERROR_MONEY_LIMIT, 8424).             %% 大侠，你的金子不足，不能继续竞猜
-define(PM_HORSE_RACE_ERROR_ALREADY_JOIN, 8425).            %% 大侠，你已经参加过竞猜，不能再次竞猜
-define(PM_HORSE_RACE_ERROR_HAS_REWARD, 8426).              %% 大侠，你还有奖励未领取，不能继续竞猜
-define(PM_HORSE_RACE_ERROR_RACE, 8427).                    %% 大侠，当前比赛已经开启，请等下一场开启再竞猜
-define(PM_HORSE_RACE_ERROR_USE_PROP_GOODS_LIMIT, 8428).    %% 大侠，你的跑马券不足，不能使用道具
-define(PM_HORSE_RACE_ERROR_USE_PROP_IN_GAMBLE, 8429).      %% 大侠，竞猜阶段不能使用道具
-define(PM_HORSE_RACE_ERROR_NO_REWARD, 8030).               %% 大侠，你没有奖励，不能领取
-define(PM_HORSE_RACE_ERROR_MAX_LIMIT, 8031).               %% 大侠，你已经参加10次了，不能参加竞猜
-define(PM_HORSE_RACE_ERROR_MAX_USE_PROP_CD_TIME, 8032).    %% 大侠，道具使用需要10秒冷却时间

%% 兵临城下副本提示（8500~8699）
-define(PM_TVE_LEADER_CHANGE, 8500).                    %% 大侠，原队长掉线了，请重新进入！
-define(PM_TVE_MB_FREE_TIME_OVER, 8501).                %% 大侠，队员的免费进入次数已用完，请退出副本后进入！
-define(PM_TVE_GIVING_REWARD, 8502).                    %% 大侠，正在为你发奖，请稍后！


%% 结婚系统相关 （代号范围: 8700~8799）
-define(PM_COUPLE_ERROR_SYS, 8700).                             %% 系统错误
-define(PM_COUPLE_APPLY_MARRIAGE_SUCCESS, 8701).                %% 大侠，你申请结婚成功，请等待对方抉择
-define(PM_COUPLE_ERROR_MARRIAGE_NO_TEAM, 8702).                %% 大侠，你必须和伴侣组队才能申请哦
-define(PM_COUPLE_ERROR_MARRIAGE_NOT_LEADER, 8703).             %% 大侠，只有队长才可以申请哦
-define(PM_COUPLE_ERROR_MARRIAGE_NO_RETURN, 8704).              %% 大侠，你的队友未归队不能申请哦
-define(PM_COUPLE_ERROR_MARRIAGE_TOO_MANY_MEMBER, 8705).        %% 大侠，请跟一个伴侣组队前来申请！
-define(PM_COUPLE_ERROR_MARRIAGE_MY_LV_LIMIT, 8706).            %% 大侠，你的等级不够，不能申请结婚
-define(PM_COUPLE_ERROR_MARRIAGE_MEMBER_LV_LIMIT, 8707).        %% 大侠，你队友的等级不够，不能申请结婚
-define(PM_COUPLE_ERROR_MARRIAGE_SAME_SEX, 8708).               %% 大侠，同性之间不能结婚哦
-define(PM_COUPLE_ERROR_MARRIAGE_YOU_HAVE_SPOUSE, 8709).        %% 大侠，你已有配偶了，不能再申请结婚
-define(PM_COUPLE_ERROR_MARRIAGE_MEMBER_HAVE_SPOUSE, 8710).     %% 大侠，你的队友已经有配偶了，不能申请结婚
-define(PM_COUPLE_ERROR_MARRIAGE_INTIMACY_LIMIT, 8711).         %% 大侠，你和队友的好友度不足，不能申请结婚
-define(PM_COUPLE_ERROR_MARRIAGE_MONEY_LIMIT, 8712).            %% 大侠，你的银子不足，不能申请结婚
-define(PM_COUPLE_ERROR_RESPOND_MEMBER_REFUSE, 8720).           %% 大侠，你的队友拒绝了你的求婚
-define(PM_COUPLE_ERROR_RESPOND_SOMEONE_ESCAPE, 8721).          %% 大侠，求婚者逃婚了
-define(PM_COUPLE_ERROR_RESPOND_NO_TEAM, 8722).                 %% 大侠，你不在队伍中不能回应哦
-define(PM_COUPLE_ERROR_RESPOND_TOO_MANY_MEMBER, 8723).         %% 大侠，请跟一个伴侣组队前来申请！
-define(PM_COUPLE_ERROR_RESPOND_NOT_APPLY_MARRIAGE, 8724).      %% 大侠，队长并没有向你求婚
-define(PM_COUPLE_CRUISE_WAIT, 8725).                           %% 大侠, 现有别的夫妻在花轿巡游，请稍后再申请
-define(PM_COUPLE_INTIMACY_LIMIT_FOR_SKILL, 8726).              %% 大侠，你们夫妻俩好友度不足哦
-define(PM_COUPLE_FIREWORKS_CD, 8727).                          %% 大侠, 请稍后再放烟花
-define(PM_COUPLE_NOT_MARRY, 8728).                             %% 大侠, 你还没有结婚哦!
-define(PM_COUPLE_CANT_DEVORCE_NOW, 8729).                      %% 大侠, 配偶离线时间不足7日
-define(PM_COUPLE_RESPOND_MEMBER_REFUSE_DEVORCE, 8730).         %% 大侠，你的配偶拒绝离婚哦!
-define(PM_COUPLE_PULL_BACK_DEVORCE, 8731).                     %% 大侠，你的配偶反悔离婚了!
-define(PM_COUPLE_NO_SPOUSE, 8732).                             %% 大侠, 你还没有配偶,赶紧脱单吧!
-define(PM_COUPLE_OBJ_NOT_YOUR_SPOUSE, 8733).                   %% 大侠, 队友不是你的配偶,不能申请哦!
-define(PM_COUPLE_CRUISE_FINISHED, 8734).                       %% 大侠，花车游结束了！
-define(PM_COUPLE_APPLY_WITH_SPOUSE, 8735).                     %% 大侠，请跟伴侣一起前来申请！
-define(PM_COUPLE_CANT_DEVORCE_THREE_DAYS, 8736).               %% 大侠，结婚不足三天不能离婚
-define(PM_COUPLE_CANT_DEVORCE_LAST_THREE_DAYS, 8737).          %% 大侠，队伍里有人上次强制离婚还不足三天所以不能结婚

%% 春节活动相关 （代号范围: 8800~8819）
-define(PM_F_ACT_PLEASE_WAIT, 8800).                            %% 大侠，请休息一会再拾取！      
-define(PM_F_ACT_CNT_LIMIT, 8801).                              %% 大侠，今天拾取红包次数已足够了，请留机会给其他朋友哦！
-define(PM_F_ACT_NOT_START, 8802).                              %% 大侠，活动未开始或已结束！
-define(PM_F_ACT_DAY_CNT_LIMIT, 8803).                          %% 大侠，今天的赠送次数达到上限了！
-define(PM_F_ACT_CNT_LIMIT_BETWEEN_FRDS, 8804).                 %% 每天两好友之间，只能互相送礼物一次!
-define(PM_F_ACT_BLESS_WAIT, 8805).                             %% 两个以上的好友还没领取你送出的礼物，请稍后！
-define(PM_F_ACT_GIFT_OVER, 8806).                              %% 大侠，暂时没有礼物可领取！
-define(PM_F_GIFT_COUNT_LIMIT_1, 8807).                         %% 你的朋友被普通赠送次数已达到上限，请明天再赠送。
-define(PM_F_GIFT_COUNT_LIMIT_2, 8808).                         %% 你的朋友被诚意赠送次数已达到上限，请明天再赠送。
-define(PM_F_NO_GUILD, 8809).                                   %% 你的朋友没有加入帮派，不能赠送哦！
-define(PM_F_TASK_CAN_NOT_IN_TEAM, 8810).                       %% 大侠，不能组队领取这个任务哦！

%% 新年宴会（代码范围8820~8840）
-define(PM_NEWYEAR_BANQUET_SYS_ERR, 8820).                      %% 系统错误
-define(PM_NEWYEAR_BANQUET_IS_NOT_OPEN, 8821).                  %% 大侠，活动还未开始
-define(PM_NEWYEAR_BANQUET_TIMES_NOT_ENOUGH, 8822).             %% 大侠，此时间段加菜次数不足了，下次抢先加菜哦！
-define(PM_NEWYEAR_BANQUET_SCENE_IS_NOT_OPEN, 8823).            %% 大侠，活动场景没有开始
-define(PM_NEWYEAR_BANQUET_IN_TEAM, 8824).                      %% 大侠，你在队伍中
-define(PM_NEWYEAR_BANQUET_LEVEL_LIMIT, 8825).                  %% 大侠，你的等级不够
-define(PM_NEWYEAR_BANQUET_ALREADY_MAX, 8826).                  %% 大侠，当前宴会档次已经达到最大档次了

%%比武大会提示
-define(PM_ARARE_REASON, 8900).                                 %% 大侠，你的等级不足或在队伍中！

%% 3V3比武竞技
-define(PM_ARENA_3V3_NOT_LEADER, 8901).             %% 需要队长才能操作
-define(PM_ARENA_3V3_TEAM_STATUS, 8902).            %% 队伍状态异常，请稍候重试
-define(PM_ARENA_3V3_TEAM_LV_LIMIT, 8903).          %% 队伍中队员等级不符合
-define(PM_ARENA_3V3_NOT_IN_TEAM, 8904).            %% 不在队伍中，请组队参加
-define(PM_ARENA_3V3_NOT_ENOUGH_TIMES, 8905).      %% 队伍中有队员次数达到最大参与次数
-define(PM_ARENA_3V3_NOT_ENOUGH_PLAYERS, 8906).    %% 队伍必须只能是3个人
-define(PM_ARENA_3V3_NOT_OPEN, 8907).               %%活动没有开启
-define(PM_ARENA_3V3_ALREADY_JOIN, 8908).           %% 你的队伍已经加入

%% 坐骑系统
-define(PM_MOUNT_SYS_ERR, 9000).         %%坐骑系统错误
-define(PM_MOUNT_OFF_ERR, 9001).         %%坐骑卸下错误
-define(PM_MOUNT_RESET_ATTR_ERR, 9002).   %%坐骑重置失败
-define(PM_MOUNT_RENAME_ERR, 9003).       %%坐骑重命名失败
-define(PM_MOUNT_SET_ATTR_ERR, 9004).     %%坐骑替换属性失败
-define(PM_MOUNT_OVER_MAX_LV, 9005).        %%坐骑已达到最大等级
-define(PM_MOUNT_FEED_TIMES_LIMIT, 9006). %%坐骑喂养次数不足
-define(PM_MOUNT_DATA_SYS_ERR, 9007). %%坐骑数据出错
-define(PM_MOUNT_OPEN_LIMIT_LV, 9008). %%坐骑等级不足
-define(PM_MOUNT_ALREADY_LEARN, 9009). %%已经学习了技能
-define(PM_MOUNT_SKILL_NUM_LIMIT, 9010). %%该坐骑格子数不对
-define(PM_MOUNT_OVER_SKILL_LV, 9011). %%坐骑已超过最大等级
-define(PM_MOUNT_MAX_CONNECT_PARTNER, 9012). %%坐骑关联门客超过最大值，请取消关联再试
-define(PM_OPEN_MOUNT_LIMIT, 9013).   %%玩家需要达到60级才能开启坐骑系统
-define(PM_MOUNT_CONNET_PRTNER_ALREADY, 9014). %玩家已经关联坐骑
-define(PM_MOUNT_OVER_MAX_COUNT, 9015).  %超过最大拥有坐骑数
-define(PM_MOUNT_OVER_MAX_STEP_LV, 9016). %超过最大进化值
-define(PM_MOUNT_LEFT_LV_MORE_RIGHT, 9017). %吞噬者比被吞噬者等级还高
-define(PM_MOUNT_LEFT_LV_TOO, 9018). %30级以下的坐骑才可以吞噬其他坐骑
-define(PM_MOUNT_WORKING, 9019). 	 %被吞噬者关联了门客无法被吞噬
-define(PM_MOUNT_RIGHT_LV_NOT, 9020).%被吞噬坐骑等级不足30级
-define(PM_YOU_HAVE_MOUNT, 9021). 	 % 您已经有了这个坐骑了，不过你可以用这个道具来进化您的坐骑
-define(PM_YOU_NOT_HAVE_MOUNT, 9022). 	 % 请先激活坐骑再来激活皮肤
-define(PM_YOU_HAVE_MOUNT_SKIN, 9023). 	 % 您已经激活这个坐骑皮肤，不能重复激活
-define(PM_NOT_HAVE_TRANSFORM_SKILL, 9024). 	% 被转换技能不存在
-define(PM_YOU_HAVE_EQUIP_FASHION, 9025). 	 % 您已经激活这个人物时装，不能重复激活

%% 转职相关
-define(PM_XINFA_LV_LIMIT, 9100).		% 转职心法等级不满足


%% 商会相关
-define(PM_NOT_STOCK, 9200).				% 库存不足
-define(PM_GLOBAL_BUY_MAX_LIMIT, 9201).		% 全服购买限制上限
-define(PM_SINGLE_BUY_MAX_LIMIT, 9202).		% 个人购买限制上限

-define(PM_GLOBAL_SELL_MAX_LIMIT, 9203).		% 全服出售限制上限
-define(PM_SINGLE_SELL_MAX_LIMIT, 9204).		% 个人出售限制上限
-define(PM_COPPER_LIMIT, 		9205).   % 你的金币不足
-define(PM_VITALITY_LIMIT, 		9206).   % 你的活力值不足

-define(PM_BIND_CAN_NOT_GIFT, 	9207).   % 绑定道具不能作为礼物赠送
-define(PM_IS_NOT_RIGHT_PRICE_RANGE, 	9208).   % 价格范围非法
-define(PM_IS_NOT_FOR_MARKET_SELL, 	9209).   % 物品无法再拍卖行出售


-define(PM_GUILD_LEVEL_IS_MAX, 	9210).   % 技能等级不能超过玩家等级
-define(PM_GUILD_CULTIVATE_LV_MAX, 	9211).   % 修炼等级超过上限

-define(PM_CHIVALROUS_LIMIT, 		9212).   % 侠义值不足

-define(PM_HAVEBETING1, 		9213).   % 您已经购买了本期期货了
-define(PM_HAVEBETING2, 		9214).   % 您已经购买了本期大盘了
-define(PM_CHIP_LIMIT, 		9215).   % 筹码不足

-define(PM_IN_PRISON, 		9216).   % 您当前的PK值过高，必须呆在监狱中一段时间了

-define(PM_GOODS_SRC_EQ_NOT_BUILD,          9217).      % 您的打造材料不足


-define(PM_PAR_BASE_STR_LIMIT,          9218).      % 力量不足
-define(PM_PAR_BASE_CON_LIMIT,          9219).      % 体质不足
-define(PM_PAR_BASE_STA_LIMIT,          9220).      % 耐力不足
-define(PM_PAR_BASE_SPI_LIMIT,          9221).      % 魔力不足
-define(PM_PAR_BASE_AGI_LIMIT,          9222).      % 敏捷不足

-define(PM_FREE_WASH_POINT_LV_LIMIT,          9223).      % 等级大于50级无法使用免费洗点服务
-define(PM_PAR_NOT_HAVE_SKILL, 9224).                           % 你的门客没有这个技能
-define(PM_SELL_TIME_CD, 9225).                           % 这个道具还没有到可以出售的时间


-define(PM_GUILD_BATTLE_NOT_OPEN, 9226).                           % 帮派战现在没有开始

-define(PM_YOU_GUILD_INUSE, 9227).                           % 你的帮派成员正在使用这个
-define(PM_GUILD_IN_DUEL, 9228).                           % 帮战已经进入决战期间无法再进入场景
-define(PM_GUILD_BATTLE_YOU_TEAM_IS_IN_BATTLE, 9230).      % 你的队长正在帮战中


-define(PM_JINGMAI_POINT_MAX_LIMIT, 9229).                           % 经脉分配点已经到最大

-define(PM_QIANGHUAHOUWUFAJIAOYI, 9231).                           % 你的这个装备强化过了无法交易
-define(PM_YOUBAOSHIWUFAJIAOYI, 9232).                           % 你的这个装备镶嵌了宝石无法交易
-define(PM_NOT_HAVE_GOODS_CAN_REWARD, 9233).                           % 你没有道具可以领取
-define(PM_NOT_YET_ENTER_3, 9234).                           % 暂时还无法进入第三层
-define(PM_CAN_NOT_EQUIP_WEAPON, 9235).                           % 携带武器无法转职

-define(PM_NOT_HAVE_ATTRS, 9236).                           % 没有要替换的附加属性

-define(PM_NOT_FREE_WASH_POINT,          9237).      % 当前没有可重置的潜力点，无法使用

%% 家园（代码范围9300~9499）
-define(PM_HOME_ALREADY_HAS, 9300).					% 已有家园
-define(PM_HOME_NOT_YET, 9301).					% 未有家园
-define(PM_HOME_NULL,	9302).					% 家园数据不存在
-define(PM_HOME_NOT_IN_SCENE, 9303).			% 当前不在家园场景内
-define(PM_HOME_LV_MAX,		9304).				% 等级已达到最高上限
-define(PM_HOME_LV_LIMIT,		9305).			% 家园等级不足
-define(PM_HOME_GRID_INVALID,	9306).			% 当前格子还没开启
-define(PM_HOME_GRID_DO_BAN,	9307).			% 当前状态禁止此操作
-define(PM_HOME_ACTION_COUNT_MAX,	9308).		% 操作次数已达到上限
-define(PM_HOME_PARTNER_EMPLOY_STATE,	9309).		% 门客正在家园工作中
-define(PM_HOME_ACHI_REWARD_ALREADY,	9310).		% 你已经领过奖励了
-define(PM_HOME_ACHI_REWARD_UNFINISH,	9311).		% 你还未达成该成就

-define(PM_HOME_SERCH_NAME,	9312).		% 输入的名字查不到角色的存在
-define(PM_HOME_SERCH_NO_EXIST,	9313).		% 该玩家还未建造家园

-define(PM_HOME_GOODS_IS_STEAL,	9314).		% 该物品已经被偷过了

-define(PM_HOME_GOODS_STEAL_FAIL, 9315).		% 战斗失败，请重新尝试

-define(PM_HOME_VISIT, 9316).		% 请先建造自己的家园，才能访问

-define(PM_GUESS_OUT_TIME, 9317).   % 当前活动竞猜已结束

-define(PM_GUESS_OUT_TIP, 9318).    % 题目已经过期


-define(PM_JINGWEN_LIMIT,  9319).   % 大侠，你的经文不足
-define(PM_YOU_ARE_BEST,  9320).     % 老铁，你这战力是GM吧，找不到对手啊
-define(PM_QUJING_NO_PAR,  9321).    % 门客阵亡不能再参与哦
-define(PM_QUJING_MAIN_PAR,  9322).  % 请在更换门客，选择心仪的门客
-define(PM_QUJING_NO_DATA,   9323).   % 目前您在第1关就找不到对手
-define(PM_QUJING_NO_DATA2,  9324).   % 目前您在第5关找不到对手
-define(PM_QUJING_NO_DATA3,  9325).   % 目前您在第8关找不到对手
-define(PM_SYSTEM_TEST_QUJING_ERRO,9326). %你的对手已逃走，请关闭界面重试


-define(PM_GUILD_DUNGEON_FINISHI,9330). %帮派副本该关卡已经完成
-define(PM_GUILD_DUNGEON_CLOSE,9331). %帮派副本该关卡未开启
-define(PM_CREATE_GUILD_SCENE_FAIL,9332). %帮派副本场景创建失败
-define(PM_GUILD_DUNGEON_PASS,9333). %该关卡通关了，副本将在一分钟后关闭
-define(PM_GUILD_DUNGEON_POINT_PASS,9334). %目标已达到，不记录数据
-define(PM_GUILD_DUNGEON_DROP,9335). %击杀小怪获得1个掉落物品
-define(PM_GUILD_DUNGEON_GET_REWARD,9336). %全部关卡通关才可以领取
-define(PM_GUILD_DUNGEON_FINISHI_BEFORE,9337). %通关前面的关卡才可以进入

-define(PM_RECHARGE_ACC_NOT_OPEN, 9338).    % 累充活动未开启，暂时不能使用

%% 跨服3V3
-define(PM_PVP_3V3_ROOM_NOT_EXIT, 9500).    % 房间不存在
-define(PM_PVP_3V3_ROOM_TEAM_NOT_SATISFY, 9501).   % 组队不符合条件
-define(PM_PVP_3V3_ROOM_IS_FULL, 9502).         % 房间已满员
-define(PM_NOT_IN_ROOM, 9503). 		% 你不在房间中或已被队长请离了
-define(PM_NOT_IS_CAPTAIN, 9504).   % 你不是房主
-define(PM_QUERY_ERROR, 9505).      % 查询的信息不存在
-define(PM_PVP_CREATE_ROOM_FAIL, 9506).      % 创建房间失败
-define(PM_PVP_3V3_PLAYER_IS_IN_ROOM, 9507).    % 该玩家已在房间
-define(PM_PVP_ERROR_OPERATE, 9508).            % 正在匹配，无法进行操作
-define(PM_PVP_ROOM_NOT_EXIST_PLAYER, 9509).    % 房间不存在该成员
-define(PM_PVP_ALREADY_APPLY_TO_JOIN_ROOM, 9510).   % 你已经申请过，请等待
-define(PM_PVP_3V3_IS_IN_ROOM, 9511).           % 请先退出房间再进行单人匹配
-define(PM_PLAYER_NOT_IN_3V3_PVP, 9512).        % 3v3 战斗不存在该玩家
-define(PM_PVP_ALREADY_INVITE_TO_JOIN_ROOM, 9513).   % 你已经邀请过，请等待
-define(PM_PVP_EXIT_TEAM, 9514).                    % 请先退出队伍再进行操作
-define(PM_PVP_HAVE_TAKE, 9515).                    % 已经帮你匹配到队友，无法取消匹配
-define(PM_HAS_PLAYER_NOT_PREPARE, 9516).           % 还有成员没有准备
-define(PM_PVP_3V3_PLAYER_NOT_PREPARE, 9517).       % 你还未准备，无法进行操作
-define(PM_PVP_3V3_NOT_FOUND_REWARD, 9518).         % 找不到你的奖励
-define(PM_PVP_3V3_HAS_GET_REWARD, 9519).           % 你已经领取过奖励，明天再来
-define(PM_PVP_3V3_ACTIVITY_IS_NOT_OPEN, 9520).     % 活动未开启
-define(PM_IS_IN_3V3_PVP, 9521).                    % 该玩家正在跨服战斗，无法发起决斗
-define(PM_PVP_3V3_LV_NOT_SATISFY, 9522).           % 您的等级不符合
-define(PM_PLAYER_IN_TEAM, 9523).                   % 该玩家在队伍中
-define(PM_PLAYER_IN_BATTLEING, 9524).              % 该玩家在战斗中
-define(PM_PLAYER_IN_SPECIAL_SCENE, 9525).                % 该玩家在特殊场景，暂时无法加入

%寻宝及许愿
-define(PM_GET_HUNTING_WEEKLY, 9600).                % 当前的累计次数不足
-define(PM_GET_RICH_FREE_NUM, 9601).                % 当前免费次数不足
-define(PM_GET_RICH_TOTAL_NUM, 9602).                % 当前总剩余次数不足
-define(PM_PERSON_PLAY_CHESS, 9603).                 %该玩家暂时不能入队

%翅膀
-define(PM_USE_WING_REPEAT, 9701).                % 您已拥有该翅膀,请勿重复使用

%限时任务
-define(PM_ERROR_TASK, 9710).                     % 任务配置无效或已过期
-define(PM_LIMIT_TASK_BATTLE_TIMEOUT, 9711).      % 任务无效，无法挑战
-define(PM_HAVE_FIGHTING_PARTNER, 9712).          % 您出战的门客数量不符
-define(PM_HAVE_SPECIAL_PARTNER, 9713).           % 您出战没有含有特殊门客
-define(PM_GET_ATTACH_REWARD, 9714).              % 当前累积分数不足
-define(PM_GET_ATTACH_REWARD_SUCCESS, 9715).      % 领取成功
-define(PM_BUY_EXTRA_REWARD, 9716).               % 亲，已经购买过了，不需再次购买
-define(PM_NEED_BUY_EXTRA_REWARD, 9718).          % 亲，请先购买额外奖励资格即可领取奖励
%秘境&幻境
-define(PM_MIJING_LIMIT,  9800).                 % 大侠，你的秘境点数不足
-define(PM_HUANJING_LIMIT,  9801).               % 大侠，你的幻境点数不足
-define(PM_MYSTERY_LIMIT, 9802).                 % 大侠，你还有尚未完成的关卡，请先完成再进入
-define(PM_MYSTERY_LEVEL_LIMIT, 9803).           % 大侠，该关卡不存在
-define(PM_MIRAGE_TMP_LEVEL, 9804).              % 队伍中有队员暂离，请尽快归队
-define(PM_MIRAGE_AGREE_INVITE, 9805).           % 队长正在幻境中，无法加入队伍
-define(PM_MIRAGE_APPLY_JOIN, 9806).             % 队长正在幻境中，无法申请入队
-define(PM_MIRAGE_APPLY_FOR_LEADER, 9807).       % 队伍正在幻境中，不能申当队长
-define(PM_MIRAGE_LEAVE_TEAM, 9808).             % 队伍正在幻境中，不能暂离
-define(PM_MYSTERY_TIME_LIMIT, 9809).            % 当前没有进度可重置
-define(PM_WAIT_UNLONE, 9810).                   % 大侠，有队员掉线了，请重新进入！

%无限资源
-define(PM_GET_LIMIT_RESOURCE, 9610).                % 您补充的货币充足，无需补充

%定制系统
-define(PM_DIY_TITLE_ATTRS_NOT_CORRECT,  9630).  %选择属性数量不正确
-define(PM_DIY_PARTNERNO_NOT_IN_GROUP,  9631).      % 当前选择下存在不可定制的门客，请重新选择
-define(PM_DIY_PARTNERSKILLNO_NOT_IN_GROUP,  9632). % 当前选择下存在不可定制的技能，请重新选择
-define(PM_DIY_EFFECTNO_NOT_IN_GROUP,  9633). % 当前选择下存在不可定制的特效，请重新选择
-define(PM_DIY_FASHION_NOT_IN_GROUP,  9634). % 当前选择下存在不可定制的时装，请重新选择
-define(PM_DIY_WING_NOT_IN_GROUP,  9635). % 当前选择下存在不可定制的翅膀，请重新选择
-define(PM_DIY_MOUNT_NOT_IN_GROUP,  9636). % 当前选择下存在不可定制的坐骑，请重新选择
-define(PM_DIY_EQUIP_NOT_IN_GROUP,  9637). % 当前选择下存在不可定制的装备，请重新选择
-define(PM_YOU_HAVE_DIY_MOUNT, 9638). 	 % 您已经有了这个坐骑了，不可重复定制

%转生系统
-define(PM_REINCARNATION_LIMIT,  9820).                 % 大侠，你的转生点数不足

%法宝系统
-define(PM_NO_HAVE_THIS,  9830).                 % 大侠，你未拥有该法宝
-define(PM_NO_HAPPEN_DO, 9831).                  % 法宝数据错误，请反馈
-define(PM_HAVE_THIS,  9832).                    % 大侠，你已拥有该法宝
-define(PM_LIMIT_GAMEMONEY_ADVANCE,  9833).      % 你的银币不足,无法继续一键进阶
-define(PM_SPIRIT_LIMIT,  9834).                 % 大侠，你的法宝灵气已满，不需要充灵
-define(PM_LIMIT_GOODS_ADVANCE,  9835).          % 材料数量不足,无法继续一键进阶
-define(PM_HAVE_SPECIAL_NO,  9836).              % 大侠，你已拥有该特殊幻化外观
-define(PM_NO_HAVE_THIS_FUYIN,  9837).           % 大侠，你未拥有该符印
-define(PM_FUYIN_TYPE_INCONSIS,  9838).          % 符印类型不一致
-define(PM_FUYIN_TAKEON_LIMIT,  9839).           % 符印镶嵌上限
-define(PM_FUYIN_SELECTED_NUM_LIMIT, 9840).      % 只能选择一组符印合成
-define(PM_FUYIN_NOT_ENOUGH, 9841).              % 符印材料不足，不能合成
-define(PM_FABAO_STAR_NOT_ENOUGH, 9842).         % 大侠，你的法宝星数不足，请先升星再镶嵌
-define(PM_MK_FUYIN_LIMIT,  9843).               % 请先卸下符印再镶嵌
-define(PM_FABAO_SKILL_COUNT_LIMIT, 9850).       % 大侠，你的技能点数不足
-define(PM_FABAO_SKILL_HAVE_LEARN, 9851).        % 大侠，该技能已经领悟过了
-define(PM_FABAO_SKILL_IS_CLOCK, 9852).          % 大侠，请先解锁前置条件
-define(PM_FABAO_DIAGRAM_STAR_LIMIT, 9853).      % 大侠，当前法宝还未达到该属性鉴定需要的星数
-define(PM_FABAO_NO_ENOUGH_SP, 9855).            % 法宝灵力值将耗尽，请尽快补充
-define(PM_FABAO_AOTU_DOWN_BATTLE, 9856).        % 法宝灵力值不足，已自动卸下
-define(PM_FABAO_SPVALUE_LOW, 9857).             % 法宝灵力值不足，无法佩戴
-define(PM_FABAO_ARRAY_LIMIT, 9858).             % 最多上阵三个主动技能

%经验找回 9900-10000
-define(PM_JINGYAN_NO_OPEN, 9900).               % 活动未开启
-define(PM_JINGYAN_NOT_ALLOW, 9901).             % 活动不允许找回经验
-define(PM_JINGYAN_NULL, 9902).                  % 没有经验可找回

-endif.  %% __PROMPT_MSG_CODE_H__


