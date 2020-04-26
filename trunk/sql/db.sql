# MySQL-Front 5.1  (Build 4.13)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;


# Host: localhost    Database: simserver
# ------------------------------------------------------
# Server version 5.5.30


USE `simserver`;

#
# Source for table account
#

DROP TABLE IF EXISTS `__dummy_table_name__`; 
CREATE TABLE `account` (
  `accname` varchar(50) NOT NULL DEFAULT '' COMMENT '平台账户名（不管是否合服，都具备唯一性，即全局唯一）',
  `discard_role_times` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '删除角色的次数',
  PRIMARY KEY (`accname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户信息';

#
# Source for table achievement_data
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `achievement_data` (
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `achievement` blob COMMENT '成就相关数据记录',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家的成就数据信息';

#
# Source for table activity_degree
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `activity_degree` (
  `id` bigint(20) unsigned NOT NULL COMMENT '玩家ID',
  `daystamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '日期戳',
  `reward_list` varchar(256) NOT NULL DEFAULT '[]' COMMENT '奖励列表',
  `sys_info` blob COMMENT '系统活跃度信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家活跃度表';


#
# Source for table wing
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `wing` (
  `wing_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '翅膀ID',
  `player_id` bigint(20) unsigned NOT NULL COMMENT '玩家ID',
  `wing_no` int (8) unsigned NOT NULL DEFAULT '0' COMMENT '翅膀编号',
  `exp` int (12) unsigned NOT NULL DEFAULT '0' COMMENT '翅膀经验',
  `lv` int (8) unsigned NOT NULL DEFAULT '0' COMMENT '翅膀等级',
  `use_state` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用中，1为是，0为否',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '类型，0为非定制，1为SR,2为SSR',
  `attrs` varchar(1024) NOT NULL DEFAULT '[]' COMMENT '附加属性编号',
  PRIMARY KEY (`wing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='翅膀';



#
# Source for table fabao
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `fabao` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '法宝ID',
  `player_id` BIGINT(20) UNSIGNED NOT NULL COMMENT '玩家ID',
  `no` INT (8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '法宝编号',
  `star` INT (4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '星数',
  `degree` INT (4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '阶数',
  `type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '相性',
  `sp_value` INT (8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '灵力值',
  `displayer` TINYINT (2) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否展示 1是展示',
  `battle` TINYINT (2) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否出战 1是出战',
  `degree_num` INT (4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '当前阶数几重',
  `degree_pro` INT (8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '进阶修炼进度',
  `cultivate_pro` INT (8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '成长率',
  `is_identify` INT (8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否鉴定。1表示已鉴定',
  `eight_diagrams` VARCHAR(2048) NOT NULL DEFAULT '[]' COMMENT '八卦属性',
  `skill_num` INT (8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '技能点',
  `skill_array_1` INT (8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上阵技能1',
  `skill_array_2` INT (8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上阵技能2',
  `skill_array_3` INT (8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上阵技能3',
  `magic_power` VARCHAR(2048) NOT NULL DEFAULT '[]' COMMENT '神通',
  `element` VARCHAR(1024) NOT NULL DEFAULT '[]' COMMENT '符印',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='法宝';

#
# Source for table fabao_goods
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `fabao_goods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '法宝物品ID',
  `player_id` bigint(20) unsigned NOT NULL COMMENT '玩家ID',
  `no` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '物品编号',
  `fabao_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '法宝id',
  `count` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '符印类型：1风2林3火4山5阴6雷',
  `lv` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '符印等级',
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '符印镶嵌位置：123',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法宝物品';



#
# Source for table answer
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `answer` (
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `join_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '参与活动时间戳',
  `cur_question` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前题号',
  `cur_index` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前题目进度号',
  `correct_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前答对题数',
  `his_cor_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '历史答对题数',
  `literary` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学分',
  `exp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '经验',
  `reward_info` varchar(128) NOT NULL DEFAULT '' COMMENT '奖励信息',
  `acepack_info` varchar(64) NOT NULL DEFAULT '' COMMENT '锦囊信息',
  `questions_info` varchar(128) NOT NULL DEFAULT '' COMMENT '已经抽取的题目信息',
  `score_streak` int(11) NOT NULL DEFAULT '0' COMMENT '接连答对题数',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家答题数据信息';


#
# Source for table lottery
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `lottery` (
  `player_id` bigint (20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
	`token` bigint (18) unsigned NOT NULL DEFAULT '0' COMMENT '玩家点券',
	`free_time` int (11) unsigned NOT NULL DEFAULT '0' COMMENT '抽奖免费时间戳',
	`time` int (11) unsigned NOT NULL DEFAULT '0' COMMENT '抽奖时间戳',
	`reward` varchar (64) NOT NULL DEFAULT '' COMMENT '领取箱子记录',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家限时转盘信息';


#
# Source for table luckdraw
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `luckdraw` (
   `player_id` bigint (20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
   `treasure_value` int (8) unsigned NOT NULL DEFAULT '0' COMMENT '寻宝幸运值',
   `desire_value` int (8) unsigned NOT NULL DEFAULT '0' COMMENT '许愿幸运值',
   `treasure_weekly_value` int (16) unsigned NOT NULL DEFAULT '0' COMMENT '寻宝周累计次数',
   `have_treasure_weekly` varchar (1024) NOT NULL DEFAULT '[]' COMMENT '寻宝周累计领取箱子记录',
   `have_desire` varchar(1024) NOT NULL DEFAULT '[]' COMMENT '许愿池累计领取奖励记录',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家寻宝许愿信息';


#
# Source for table limit_task
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `limit_task` (
  `player_id` bigint (20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `point` int (8) unsigned NOT NULL DEFAULT '0' COMMENT '玩家的分数',
  `remain` int (8) unsigned NOT NULL DEFAULT '0' COMMENT '玩家剩余的免费次数',
  `cost_remain` int (8) unsigned NOT NULL DEFAULT '0' COMMENT '玩家剩余的免费次数',
  `times` int (8) unsigned NOT NULL DEFAULT '0' COMMENT '玩家累计购买的次数',
  `extra_valid` int (8) unsigned NOT NULL DEFAULT '0' COMMENT '额外奖励是否购买了',
  `extra_reward` varchar (2048) NOT NULL DEFAULT '[]' COMMENT '已经领取的额外奖励',
  `get_reward` varchar (2048) NOT NULL DEFAULT '[]' COMMENT '已经领取的累计奖励',
  `unix_time` int (11) unsigned NOT NULL DEFAULT '0' COMMENT '玩家更新分数的时间戳',
  `last_rank_data` varchar (1024) NOT NULL DEFAULT '[]' COMMENT '上次排名数据，[排名，分数]',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家限时任务信息';




#
# Source for table chapter_target_info
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `chapter_target_info` (
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `chapter_reward` varchar(1024) NOT NULL DEFAULT '[]' COMMENT '章节目标奖励信息 [{章节No, 0/1(是否领取奖励)}]',
  `chapter_achievement` varchar(1024) NOT NULL DEFAULT '[]' COMMENT '章节成就达成 ',
  `buy_and_recharge` varchar(1024) NOT NULL DEFAULT '[]' COMMENT '章节每日福利 ',
  `finish_chapter` varchar(1024) NOT NULL DEFAULT '[]' COMMENT '完成的章节 ',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家的章节目标数据信息';

#
# Source for table day_reward
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `day_reward` (
  `player_id` bigint(18) unsigned NOT NULL COMMENT 'id',
  `sign_info` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '整数的低31位（二进制位），分别对应本月的签到情况，1表示当天有签到，0表示当天没有签到，从右边算起',
  `sign_reward_info` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '整数的低31位（二进制位），分别对应本月签到n次的奖励情况，右边算起第n位是1表示签到n次的奖励已经领取，0表示还没有领取',
  `last_sign_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次签到时间',
  `cur_no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前奖励编号 可能是可以领取的，也可能是还不能领取的，客户端根据上次领取时间，判断是否可以领取了',
  `last_get_reward_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次领取在线奖励时间',
  `seven_day_reward` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '整数的低7位（二进制位），对应创号7天礼包的领取情况，0表示还没有领取，1表示已经领取',
  `lv_reward_no_list` varchar(512) NOT NULL DEFAULT '' COMMENT '已经领取的等级奖励编号列表',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家每日签到与在线奖励';

#
# Source for table dungeon_cd
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `dungeon_cd` (
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `dun_group` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '副本组',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '冷却时间内第一次创建副本记录的时间戳',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '冷却时间内的次数',
  PRIMARY KEY (`role_id`,`dun_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色副本CD记录';

#
# Source for table find_par
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `find_par` (
  `player_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `lv_step` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '寻妖系统进入青楼的等级段编号',
  `last_free_enter_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次更新心情时间，一天一更新',
  `enter_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '当前进入青楼的类型 0表示还没有进入;1表示普通进入；2表示高级进入',
  `last_enter_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '当前进入青楼的类型 0表示还没有进入;1表示普通进入；2表示高级进入',
  `counters` varchar(512) NOT NULL DEFAULT '' COMMENT '计数器信息，用于实现需要保底功能',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家的寻妖信息';

#
# Source for table goods
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `goods` (
  `id` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT '物品唯一ID',
  `no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '物品编号',
  `player_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '所属玩家的Id',
  `partner_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '武将Id（装备穿在武将身上时对应的武将唯一Id）',
  `bind_state` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '当前的绑定状态',
  `usable_times` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前剩余的可使用次数',
  `location` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '物品所在位置，如：背包，仓库，市场等',
  `slot` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '物品所在的格子位置（从1开始算起）',
  `count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '物品的叠加数量',
  `quality` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '物品品质',
  `first_use_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '第一次使用该物品的时间',
  `valid_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '有效时间',
  `expire_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间点',
  `base_equip_add` varchar(512) NOT NULL DEFAULT '' COMMENT '装备的基本属性加成，格式如：空字串 | [{属性名，属性值}, ...]',
  `addi_equip_add` varchar(512) NOT NULL DEFAULT '' COMMENT '装备的附加属性加成，格式如：空字串 | [{Index, 属性名，属性加成的值, 属性加成精炼等级}, ...]',
  `stren_equip_add` varchar(512) NOT NULL DEFAULT '' COMMENT '装备的强化属性加成，格式如：空字串 | [{属性名，属性值}, ...]',
  `equip_prop` varchar(512) NOT NULL DEFAULT '' COMMENT '装备自身的额外特性（如：强化等级等），格式如：空字串 | [{特性名，特性值}, ...]',
  `battle_power` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '装备战力',
  `custom_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0非定制 (1~5)定制',
  `extra` varchar(512) NOT NULL DEFAULT '' COMMENT '其他额外数据，格式也是为空字串或者key-value形式的元组列表',
  `show_base_attr` varchar(512) NOT NULL DEFAULT '' COMMENT '显示基础属性，例如[{key,value}]',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间戳',
  PRIMARY KEY (`id`),
  KEY `player_id_location` (`player_id`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='物品表';

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `equip_fashion` (
  `id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `data` blob NOT NULL COMMENT '装备时装',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='坐骑皮肤信息';

#
# Source for table guild
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `guild` (
  `id` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT '帮会id',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '帮会名称',
  `brief` varchar(64) NOT NULL DEFAULT '' COMMENT '帮会简介',
  `lv` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '帮派等级',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '帮派创建时间（unix时间戳）',
  `chief_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '帮主id',
  `counsellor_list` varchar(1024) NOT NULL DEFAULT '' COMMENT '帮派军师列表（玩家id列表）',
  `shaozhang_list` varchar(1024) NOT NULL DEFAULT '' COMMENT '帮派哨长列表（玩家id列表）',
  `rank` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '帮派排名',
  `prosper` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '帮派繁荣度',
  `member_list` blob NOT NULL COMMENT '帮派成员列表（玩家id列表）',
  `request_joining_list` blob NOT NULL COMMENT '申请入帮的列表， 有数量上限，形如：[{申请人的id，申请人的性别，申请人的等级}, ...]',
  `prosper_today` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '帮派今天获得的繁荣度',
  `last_add_prosper_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '帮派上次添加繁荣度时间（unix时间戳）',
  `fund` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '帮派资金',
  `login_id_list` blob NOT NULL COMMENT '24小时内登录过的帮派成员id列表（玩家id列表）',
  `liveness` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当日活跃度',
  `battle_power` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '帮派战力',
  `donate_rank` varchar(512) NOT NULL DEFAULT '' COMMENT '累计捐献排名：[{Name, Money},...]',
  `total_bid` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '本周帮派争夺战投标的总money(绑银),比赛结束或分组后没有比赛时清空',
  `bid_id_list` blob NOT NULL COMMENT '本周报名帮派争夺战的玩家id列表,比赛结束或分组后没有比赛时清空',
  `join_control` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '控制选项：1无需审核入帮,2需要审核入帮,3禁止玩家加入',
  `guild_shop` varchar(1024) NOT NULL DEFAULT '' COMMENT '转生货币',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间戳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮会信息表';



#
# Source for table clock_data
#
CREATE TABLE `clock_data` (
  `player_id` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT '玩家ID',
  `fanli` varchar(2048) NOT NULL DEFAULT '{0,0,[]}'  COMMENT '{当日累充,活动期间累充,已经领取的累充记录}',
    PRIMARY KEY (`player_id`)
  )ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='此表用于按时间结算的各类数据';



#
# Source for table guild_member
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `guild_member` (
  `id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '帮派成员id（即玩家id）',
  `guild_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '帮会ID',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '玩家名字',
  `lv` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '玩家等级',
  `vip_lv` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '玩家vip等级',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '玩家性别',
  `race` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '玩家种族',
  `faction` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '玩家门派',
  `join_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '加入帮会的时间（unix时间戳）',
  `contri` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '累计帮派贡献度',
  `title_id` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '帮派称号id',
  `battle_power` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '战斗力',
  `left_contri` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前剩余帮派贡献度',
  `contri_today` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当天帮派贡献度',
  `last_add_contri_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成员上次贡献时间（unix时间戳）',
  `donate_today` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当天捐献银子数量',
  `donate_total` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '累计捐献银子数量',
  `last_donate_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次捐献时间 （unix时间戳）',
  `pay_today` varchar(100) NOT NULL DEFAULT '' COMMENT '当日可以领取的工资，[{基本工资,领取状态},{职位薪资,领取状态},{贡献度薪资,领取状态},{贡献度排行薪资,领取状态}] 一天一次,1已经领取,0还没有领取',
  `position` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '玩家在帮派中的职位',
  `bid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '本周为帮派争夺战投标的money(绑银),比赛结束或分组后没有比赛时清空',
  PRIMARY KEY (`id`),
  KEY `index_guild_id` (`guild_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮派成员表';

#
# Source for table hire
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `hire` (
  `id` bigint(18) unsigned NOT NULL COMMENT '天将玩家id',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '角色名',
  `lv` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '等级',
  `faction` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '门派',
  `battle_power` int(11) NOT NULL DEFAULT '0' COMMENT '战斗力',
  `left_time` tinyint(11) NOT NULL DEFAULT '0' COMMENT '当天剩余可被雇佣的的次数 24点清0',
  `price` int(11) NOT NULL DEFAULT '0' COMMENT '被雇佣一次（参加一次战斗）的价格（绑银）',
  `par_list` varchar(4096) NOT NULL DEFAULT '[]' COMMENT 'par_brief 列表',
  `hire_history` varchar(2048) NOT NULL DEFAULT '[]' COMMENT '{雇主玩家id，名字，雇佣次数} 列表',
  `get_income` int(11) NOT NULL DEFAULT '0' COMMENT '已经领取的收益',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='可以供雇佣的天将数据';

#
# Source for table hirer
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `hirer` (
  `id` bigint(18) unsigned NOT NULL COMMENT '雇主玩家id',
  `hire_id` bigint(18) unsigned NOT NULL COMMENT '雇佣的玩家id',
  `hire_name` varchar(20) NOT NULL DEFAULT '' COMMENT '角色名',
  `hire_lv` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '等级',
  `hire_battle_power` int(11) NOT NULL DEFAULT '0' COMMENT '战斗力',
  `left_time` tinyint(11) NOT NULL DEFAULT '0' COMMENT '当天剩余可被雇佣的的次数 24点清0',
  `hire_par_list` varchar(4096) NOT NULL DEFAULT '[]' COMMENT 'par_brief 列表',
  `is_fight` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '雇佣的天将是否出战',
  `hire_sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '雇佣的天将的性别',
  `hire_faction` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '雇佣的天将的门派',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='雇主雇佣情况数据';


#
# Source for table home
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `home` (
	`id` BIGINT(18) UNSIGNED NOT NULL DEFAULT '0' COMMENT '玩家id',
	`degree` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '豪华度',
	`lv_home` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '家园等级',
	`lv_land` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '土地等级',
	`lv_dan` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '炼丹炉等级',
	`lv_mine` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '矿井等级',
	`achievement_value` VARCHAR(1024) NULL DEFAULT NULL,
	`achievement_reward_nos` VARCHAR(1024) NULL DEFAULT NULL,
	`create_time` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '建造时间戳',
	PRIMARY KEY (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家家园系统基本信息';


#
# Source for table home_data
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `home_data` (
	`id` BIGINT(18) UNSIGNED NOT NULL DEFAULT '0' COMMENT '玩家id',
	`type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '类型(土地炼丹炉矿井)',
	`no` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '格子编号',
	`goods_no` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '道具ID',
	`partner_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '雇佣的门客',
	`start_time` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '目标道具开始的时间戳',
	`count_action_speedup` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '加速行为次数',
	`count_action_multi` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '翻倍行为次数',
	`count_action_lvlup` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '奖励的升级等级行为次数',
	`time_speedup` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '加速的秒数',
	`reward_multi` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '收获的翻倍数',
	`reward_lvlup` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '奖励的升级礼包编号0为空',
	`is_refresh_mon` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`is_mon_steal` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`create_time` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '开启格子时间戳',
	`is_steal` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用于记录偷取',
	UNIQUE INDEX `id_type_no` (`id`, `type`, `no`),
	INDEX `id_type_no2` (`id`, `type`, `no`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家家园系统格子信息';

#
# Source for table mail
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `mail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '信件id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类型（1系统/2私人）',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态（1已读/0未读）',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Unix时间戳',
  `send_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发件人id',
  `send_name` varchar(50) NOT NULL DEFAULT '0' COMMENT '发件人姓名',
  `recv_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '收件人id',
  `title` varchar(50) NOT NULL COMMENT '信件标题',
  `content` text NOT NULL COMMENT '信件正文',
  `attach` varchar(500) NOT NULL COMMENT '附件',
  PRIMARY KEY (`id`),
  KEY `recv_id` (`recv_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信件信息';

#
# Source for table market_selling
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `market_selling` (
  `id` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT '挂售记录唯一id',
  `seller_id` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '卖家的id',
  `goods_id` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '物品唯一id',
  `goods_no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '物品类型id',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '物品名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '物品类型',
  `sub_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '物品子类型',
  `subsub_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '物品二级子类型',
  `quality` tinyint(3) unsigned NOT NULL DEFAULT '99' COMMENT '物品品质',
  `level` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '物品等级',
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '物品种族',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '物品性别限制',
  `stack_num` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '堆叠数量',
  `money_to_sell` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '挂售货币的数量，挂售货币时才用到',
  `money_to_sell_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '挂售货币的类型, 挂售货币时才用到（游戏币或元宝，必定与price_type是相反的）',
  `price` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '挂售价格',
  `price_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '挂售价格的类型（游戏币或元宝）',
  `start_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '挂售的开始时间',
  `end_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '挂售的结束时间',
  `lock_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '记录加锁的时间点，用于防止多个玩家同时购买同一上架物品时出现异常',
  `status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '挂售记录的状态，0：无效状态，1：正在挂售中，2：已卖出，待取钱',
  PRIMARY KEY (`id`),
  KEY `seller_id` (`seller_id`),
  KEY `goods_type` (`type`,`sub_type`,`quality`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='市场的上架物品（挂售记录）';

#
# Source for table obj_buff
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `obj_buff` (
  `player_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '玩家Id',
  `partner_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '宠物Id,若是玩家自己的buff则此字段是0',
  `buff_list` varchar(1024) NOT NULL DEFAULT '' COMMENT '玩家or宠物buff信息列表，格式如：空字串 | []',
  UNIQUE KEY `obj_id` (`player_id`,`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家or宠物身上的buff列表';

#
# Source for table offline_arena
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `offline_arena` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `arena_group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '组别',
  `rank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排名',
  `rank_seed` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '刷新名次随机值',
  `refresh_stamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '刷新排名时间戳',
  `reward_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '刷新时间内领奖次数',
  `reward_stamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '领取奖励时间戳',
  `challange_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '挑战次数',
  `challange_stamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '剩余挑战时间戳',
  `winning_streak` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '连胜场次',
  `reward_ws` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '领取连胜奖励的场次',
  `battle_history` varchar(3072) NOT NULL DEFAULT '[]' COMMENT '战报',
  `create_stamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入竞技场时间戳',
  `update_stamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新记录时间戳',
  `challenge_buy_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买挑战次数',
  `reward_chal` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '领取挑战次数奖励的场次',
  `his_max_ws_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '历史最大连胜的场次',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间戳',
  PRIMARY KEY (`id`),
  KEY `offline_arena_key` (`id`,`arena_group`,`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家的离线竞技场数据';

#
# Source for table offline_arena_group_rank
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `offline_arena_group_rank` (
  `arena_group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '组别',
  `rank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排名',
  PRIMARY KEY (`arena_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='离线竞技场组别最后排名';

#
# Source for table offline_bo
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `offline_bo` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家或宠物的ID',
  `bo_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类型（以区分是玩家还是宠物）',
  `sys_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '系统类型',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '名字',
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '种族',
  `faction` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '门派',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `lv` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `attrs` varchar(1024) NOT NULL DEFAULT '' COMMENT '属性，对应attrs结构体',
  `skills` varchar(512) NOT NULL DEFAULT '[]' COMMENT '技能列表',
  `xinfa` varchar(512) NOT NULL DEFAULT '[]' COMMENT '心法列表',
  `showing_equips` varchar(256) NOT NULL DEFAULT 'null' COMMENT '玩家或宠物外形展示的装备编号，格式如：null | [{信息名， 值}, ...]',
  `partners` varchar(2048) NOT NULL DEFAULT '{}' COMMENT '宠物Id列表',
  `par_property` varchar(256) NOT NULL DEFAULT 'null' COMMENT '宠物特性信息，若非宠物，则固定为null，格式如：null | [{信息名， 值}, ...]',
  PRIMARY KEY (`id`,`bo_type`,`sys_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='离线战斗对象的数据';

#
# Source for table partner
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `partner` (
  `id` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT '宠物唯一id',
  `player_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '所属玩家id',
  `no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '宠物编号，由策划制定',
  `name` varchar(15) NOT NULL DEFAULT '' COMMENT '宠物名称',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '宠物性别',
  `quality` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '宠物品质',
  `state` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '宠物状态，详见partner.hrl文件',
  `lv` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '宠物等级',
  `exp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '宠物当前经验',
  `hp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '宠物气血',
  `intimacy` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '亲密度',
  `intimacy_lv` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '亲密度等级',
  `life` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '寿命',
  `cur_battle_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前战斗场数',
  `position` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否主宠物,为1表示是',
  `follow` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否跟随 1表示跟随',
  `cultivate` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修炼值',
  `cultivate_lv` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '修炼等级',
  `cultivate_layer` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '修炼层数',
  `skills_use` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '1为skills，2为skills_two',
  `skills` varchar(512) NOT NULL DEFAULT '[]' COMMENT '技能列表, 格式为：[] | skl_brief 结构体列表',
  `skills_two` varchar(512) NOT NULL DEFAULT '[]' COMMENT '技能列表2, 格式为：[] | skl_brief 结构体列表',
  `skills_exclusive` varchar(512) NOT NULL DEFAULT '[]' COMMENT '专属技能列表, 格式为：[] | skl_brief 结构体列表',
  `battle_power` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '武将战力',
  `loyalty` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '忠诚度',
  `nature_no` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '性格编号',
  `evolve_lv` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '进化等级',
  `evolve` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '进化值',
  `awake_lv` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '觉醒等级',
  `awake_illusion` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '觉醒幻化等级',
  `base_train_attrs` varchar(256) NOT NULL DEFAULT '' COMMENT '宠物出生培养相关值(基础值): {成长，生命资质，法力资质，物攻资质，法功资质，物防资质，法防资质，速度资质}',
  `base_train_attrs_tmp` varchar(256) NOT NULL DEFAULT '' COMMENT '(洗练临存)宠物出生培养相关值(基础值): {成长，生命资质，法力资质，物攻资质，法功资质，物防资质，法防资质，速度资质}',
  `max_postnatal_skill` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '最大后天技能格数',
  `wash_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '宠物累计的洗髓次数',
  `mood_no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前心情编号',
  `last_update_mood_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次更新心情时间，一天一更新',
  `update_mood_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '当天更新心情次数',
  `add_skill_fail_cnt` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '新增后天技能失败次数，当成功新增一个技能，次数清零',
  `version` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '数据版本,用于调整线上数据(规则调整等情况)',
  `mount_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '关联坐骑的唯一id',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间戳',
  `base_talents` varchar(100) NOT NULL DEFAULT '' COMMENT '已分配的天赋属性点: {力量，体质，耐力，灵力，敏捷}',
  `free_talent_points` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '未分配的天赋属性点数',
  `five_element` varchar(500) NOT NULL DEFAULT '{0,0}' COMMENT '{五行，五行等级}',
   `ts_join_battle` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '宠物出战毫秒时间戳(用于出战顺序排序)',
  `join_battle_order` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT '(用于出战顺序排序)12345排序主将默认为1',
  `attr_refine` VARCHAR(512) NOT NULL DEFAULT '[]' COMMENT '宠物精炼属性',
  `art_slot` VARCHAR(512) NOT NULL DEFAULT '[]' COMMENT '宠物功法格子开启数',
  `cost_refine` VARCHAR(128) NOT NULL DEFAULT '[]' COMMENT '宠物精炼消耗的精炼丹数',
  PRIMARY KEY (`id`),
  KEY `index_player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='宠物信息';

#
# Source for table partner_hotel
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `partner_hotel` (
  `id` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT '宠物唯一id',
  `player_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '所属玩家id',
  `no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '宠物编号，由策划制定',
  `name` varchar(15) NOT NULL DEFAULT '' COMMENT '宠物名称',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '宠物性别',
  `quality` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '宠物品质',
  `state` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '宠物状态，详见partner.hrl文件',
  `lv` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '宠物等级',
  `exp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '宠物当前经验',
  `hp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '宠物气血',
  `intimacy` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '亲密度',
  `intimacy_lv` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '亲密度等级',
  `life` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '寿命',
  `cur_battle_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前战斗场数',
  `position` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否主宠物,为1表示是',
  `follow` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否跟随 1表示跟随',
  `cultivate` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修炼值',
  `cultivate_lv` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '修炼等级',
  `cultivate_layer` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '修炼层数',
  `skills_use` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '1为skills，2为skills_two',
  `skills` varchar(512) NOT NULL DEFAULT '[]' COMMENT '技能列表, 格式为：[] | skl_brief 结构体列表',
  `skills_two` varchar(512) NOT NULL DEFAULT '[]' COMMENT '技能列表2, 格式为：[] | skl_brief 结构体列表',
  `skills_exclusive` varchar(512) NOT NULL DEFAULT '[]' COMMENT '专属技能列表, 格式为：[] | skl_brief 结构体列表',
  `battle_power` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '武将战力',
  `loyalty` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '忠诚度',
  `nature_no` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '性格编号',
  `evolve_lv` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '进化等级',
  `evolve` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '进化值',
  `base_train_attrs` varchar(256) NOT NULL DEFAULT '' COMMENT '宠物出生培养相关值(基础值): {成长，生命资质，法力资质，物攻资质，法功资质，物防资质，法防资质，速度资质}',
  `max_postnatal_skill` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '最大后天技能格数',
  `wash_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '宠物累计的洗髓次数',
  `mood_no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前心情编号',
  `last_update_mood_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次更新心情时间，一天一更新',
  `update_mood_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '当天更新心情次数',
  `add_skill_fail_cnt` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '新增后天技能失败次数，当成功新增一个技能，次数清零',
  `version` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '数据版本,用于调整线上数据(规则调整等情况)',
  `mount_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '关联坐骑的唯一id',
  `base_talents` varchar(100) NOT NULL DEFAULT '' COMMENT '已分配的天赋属性点: {力量，体质，耐力，灵力，敏捷}',
  `free_talent_points` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '未分配的天赋属性点数',
  `five_element` varchar(500) NOT NULL DEFAULT '{0,0}' COMMENT '{五行，五行等级}',
  `ts_join_battle` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '宠物出战毫秒时间戳(用于出战顺序排序)',
  PRIMARY KEY (`id`),
  KEY `index_player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家在青楼抽取的女妖信息';

#
# Source for table player
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `player` (
  `local_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '玩家在服务器内部的流水id，不具备全局唯一性',
  `id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '玩家的全局唯一id，形如：001000100000000001（十进制），其中前三位数表示平台号，后续4位数表示平台内的服务器编号，最后的11位数字表示服务器内的流水号',
  `accname` varchar(50) NOT NULL DEFAULT '' COMMENT '账户名（全局唯一）',
  `nickname` varchar(20) NOT NULL DEFAULT '' COMMENT '角色名',
  `is_banned` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '该角色是否被封禁（1：是，0：否）',
  `create_date` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建日期',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间（unix时间戳）',
  `from_server_id` int(6) unsigned NOT NULL DEFAULT '0' COMMENT '表示角色是在哪个服创建的，server_id = 平台号*10000 + 平台下的服务器流水编号',
  `is_discarded` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '该角色是否被废弃了（1：是，0：否）',
  `discard_date` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '废弃该角色时的日期',
  `discard_phone_model` varchar(40) NOT NULL DEFAULT '' COMMENT '废弃角色时所用手机的型号',
  `discard_phone_mac` char(17) NOT NULL DEFAULT '' COMMENT '废弃角色时所用手机的MAC地址',
  `retrieve_date` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '取回该角色时的日期',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '上次登录时间',
  `last_login_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '上次登录所在的IP',
  `last_logout_time` int(11) NOT NULL DEFAULT '0' COMMENT '上一次退出游戏时间',
  `priv_lv` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '权限级别（0：普通玩家，1：指导员，2：GM）',
  `race` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '种族',
  `faction` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '门派',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '性别',
  `lv` int(8) unsigned NOT NULL DEFAULT '1' COMMENT '等级',
  `exp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '经验',
  `yuanbao` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '元宝',
  `bind_yuanbao` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '绑定的元宝',
  `gamemoney` BIGINT(20) unsigned NOT NULL DEFAULT '0' COMMENT '游戏币',
  `bind_gamemoney` BIGINT(20) unsigned NOT NULL DEFAULT '0' COMMENT '绑定的游戏币',
  `integral` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '积分',
  `copper` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '专用游戏币铜币',
  `jingwen` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '经文',
  `dan` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '段位',
  `mijing` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '秘境点数',
  `huanjing` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '幻境点数',
  `chivalrous` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '侠义值',
  `vitality` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活力值',  
  `yuanbao_acc` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '累积充值元宝',
  `feat` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '功勋值',
  `literary` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '学分',
  `literary_clear_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '学分清零时间戳',
  `scene_type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '所在场景类型',
  `scene_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在场景id',
  `x` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'X坐标',
  `y` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Y坐标',
  `hp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '气血',
  `mp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '魔法值',
  `anger` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '怒气值',
  `bag_eq_capacity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '当前装备背包的容量',
  `storage_capacity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '当前仓库的容量',
  `bag_usable_capacity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '当前可用物品背包的容量',
  `bag_unusable_capacity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '当前不可用物品背包的容量',
  `guild_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '所属帮派的id',
  `vip_lv` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'VIP',
  `vip_exp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'vip经验',
  `vip_active_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'vip激活时间',
  `vip_expire_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'vip过期时间',
  `daily_reset_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次执行日重置的时间点',
  `weekly_reset_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次执行周重置的时间点',
  -- `newbie_guide_step` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '表示当前进行到了哪一步新手指导阶段？',
  `base_talents` varchar(100) NOT NULL DEFAULT '' COMMENT '已分配的天赋属性点: {力量，体质，耐力，灵力，敏捷}',
  `free_talent_points` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '未分配的天赋属性点数',
  `team_target_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '组队目的之目标类型',
  `team_condition1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '组队目的之条件一：任务类型或副本难度',
  `team_condition2` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '组队目的之条件二：怪物等级或副本编号',
  `world_chat_stamp` int(11) NOT NULL DEFAULT '0' COMMENT '世界聊天时间戳',
  `partner_capacity` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '玩家允许携带的最大宠物数',
  `fight_par_capacity` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '玩家允许出战的最大宠物数',
  `task_seed` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '任务随机种子',
  `dun_info` varchar(150) NOT NULL DEFAULT '{0, 0, 0, null}' COMMENT '副本信息',
  `prev_pos` varchar(150) NOT NULL DEFAULT '{0, {0, 0}}' COMMENT '进入副本前位置信息',
  `battle_power` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '战斗力',
  `store_hp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '玩家气血库',
  `store_mp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '玩家魔法库',
  `store_par_hp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '玩家宠物专用血库',
  `store_par_mp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '玩家宠物专用魔法库',
  `accum_online_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家累积在线时间',
  `update_mood_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '当天更新宠物心情次数',
  `last_update_mood_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次更新宠物心情时间',
  `opened_sys` varchar(600) NOT NULL DEFAULT '{}' COMMENT '玩家自身的已开放的系统',
  `recharge_state` varchar(512) NOT NULL DEFAULT '[]' COMMENT '充值各档次状态[{档次, 首充时间戳, 最后一次返利时间戳}]',
  `month_card_state` varchar(256) NOT NULL DEFAULT '[]' COMMENT '月卡状态[{月卡编号, 剩余发放天数, 最后一次返利日期数}]',
  `first_recharge_reward_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '首充礼包状态0->不可领取 1->可领取 2->已领取',
  `recharge_accum` varchar(2048) NOT NULL DEFAULT '{0, 0}' COMMENT '充值累积状态 {累积值, 最近一次叠加的时间戳}',
  `consume_state` varchar(2048) NOT NULL DEFAULT '[]' COMMENT '消费状态 [{钱类型, {累积值, 最近一次叠加的时间戳}}, ..]',
  `admin_acitvity_state` varchar(2048) NOT NULL DEFAULT '[]' COMMENT '后台活动状态 [{活动类型, 累计值, 最近一次叠加的时间戳, 活动标志} | _]',
  `exp_slot` varchar(50) NOT NULL DEFAULT '[]' COMMENT '储备槽经验',
  `guild_attrs` varchar(1500) NOT NULL DEFAULT '[]' COMMENT '帮派点修属性列表：[{技能编号,技能等级},...]',
  `cultivate_attrs` varchar(1500) NOT NULL DEFAULT '[]' COMMENT '帮派点修属性列表：[{点修编号,点修等级,点修值},...]',  
  `xs_task_issue_num` int(11) NOT NULL DEFAULT 0 COMMENT '悬赏任务已经发布次数',
  `xs_task_left_issue_num` int(11) NOT NULL DEFAULT 200 COMMENT '悬赏任务剩余发布次数',
  `xs_task_receive_num` int(11) NOT NULL DEFAULT 0 COMMENT '悬赏任务已经领取次数',
  `one_recharge_reward` varchar(2048) NOT NULL DEFAULT '[]' COMMENT '上次领取单笔充值奖励信息[{充值钱的数量, 时间戳}]',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间戳',
  `zf_state` varchar(1500) NOT NULL DEFAULT '[]' COMMENT '玩家阵法学习信息[0, 1, 2, 3,....]',
  `contri` int(11) NOT NULL DEFAULT '0' COMMENT '玩家成就功绩值',
  `recharge_accum_day` varchar(2048) NOT NULL DEFAULT '{0, 0, 0}' COMMENT '充值累积状态 {累积值, 最近一次叠加的时间戳, 活动ID}',
  `mount` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '玩家当前骑乘的坐骑id',
  `last_transform_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后一次转职时间',
  `day_transform_times` int(11) NOT NULL DEFAULT '0' COMMENT '当天已转换门派次数',
  `jingmai_infos` varchar(1500) NOT NULL DEFAULT '[]' COMMENT '经脉信息：[{筋脉编号,等级},...]',
  `jingmai_point` int(4) NOT NULL DEFAULT 0 COMMENT '经脉兑换点数',
  `first_recharge_reward` varchar(1500) NOT NULL DEFAULT '[]' COMMENT '新首冲礼包',
  `login_reward_day` INT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '登陆天数不连续',
  `login_reward_time` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '登陆领取时间戳',
  `leave_guild_time` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '离开帮派时间戳',
  `peak_lv` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '巅峰等级',
  `reincarnation` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '转生货币',
  `unlimited_resources` varchar(1500) NOT NULL DEFAULT '[]' COMMENT '无线资源',
  `faction_skills` varchar(512) NOT NULL DEFAULT '[]' COMMENT '门派技能列表',
  PRIMARY KEY (`local_id`),
  UNIQUE KEY `nickname` (`nickname`),
  KEY `accname` (`accname`),
  KEY `global_unique_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家数据';

#
# Source for table player_misc
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `player_misc` (
  `player_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `buy_goods_from_npc` varchar(1024) NOT NULL DEFAULT '' COMMENT 'npc商店某些物品的购买列表，格式如：[{GoodsNo, Count}, ...]',
  `buy_goods_from_shop` varchar(1024) NOT NULL DEFAULT '' COMMENT '商城某些物品的购买列表，格式如：[{GoodsNo, Count,LastBuyTime,LastBuyTime}, ...]',
  `buy_goods_from_op_shop` blob NOT NULL COMMENT '运营后台商店某些物品的购买列表，格式如：[{GoodsNo, Count,LastBuyTime}, ...]',
  `use_goods` varchar(1024) NOT NULL DEFAULT '' COMMENT '某些物品的使用列表，格式如：[{GoodsNo, Count, LastUseTime}, ...]',
  `grow_fund` varchar(3078) NOT NULL DEFAULT '' COMMENT '成长基金，格式如：[{基金编号,购买基金时间戳,[{领取等级，领取时间}]},...]',
  `guild_dungeon_id`  bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '上次参加帮派副本所在帮派id',
  `guild_dungeon_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次参加帮派副本所在帮派id',
  `guild_war_id`  bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '上次参加帮派争霸赛所在帮派id',
  `guild_war_turn` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次参加帮派争霸赛届数',
  `free_stren_cnt` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '今天剩余免费强化装备次数',
  `lv_train` varchar(50) NOT NULL DEFAULT '[]'  COMMENT '练功房激活的等级，[Lv]',
  `reset_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '练功更新的时间戳',
  `lilian`  bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '历练系统领取',
  `monopoly` varchar(1024) NOT NULL DEFAULT '[2,5]'  COMMENT '大富翁每日次数',
  `monopoly_reset_time` int(11) NOT NULL DEFAULT '0' COMMENT '上次重置时间',
  `mijing` tinyint(3) unsigned NOT NULL DEFAULT '3' COMMENT '每日大秘境剩余次数', 
  `mijing_record` varchar(2048) NOT NULL DEFAULT '[]'  COMMENT '秘境进度记录',
  `huanjing` tinyint(3) unsigned NOT NULL DEFAULT '3' COMMENT '每日幻境剩余次数',
  `huanjing_record` varchar(2048) NOT NULL DEFAULT '[]'  COMMENT '幻境进度记录', 
  `lockno` varchar(1024) NOT NULL DEFAULT '[]'  COMMENT '幻境解锁关卡',
  `mystery_reset_time` int(11) NOT NULL DEFAULT '0' COMMENT '上次重置时间',
  `fabao_special` varchar(512) NOT NULL DEFAULT '[]'  COMMENT '法宝特殊外观',
  `fabao_displayer` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '玩家展示的外观编号',
  `fabao_degree` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '玩家目前展示法宝的阶数',
  `recharge_unixtime` varchar(100) NOT NULL DEFAULT '{0,0}' COMMENT '用在连充活动 {上次充值时间，上次领取的天数}',
  `strengthen_info` varchar(2048) NOT NULL DEFAULT '[]'  COMMENT '[{1, Level, [宝石Id1,宝石Id2,宝石Id3···]},···] [{部位NO,强化LV,宝石镶嵌}]',
  `create_role_reward` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '创号奖励领取状态',
  `recharge_accumulated` VARCHAR(256) NOT NULL DEFAULT '[]' COMMENT '已领取的常驻累充奖励',
  `dungeon_reward_time` VARCHAR(1024)  NOT NULL DEFAULT '[]' COMMENT '控制是否可获得副本通关奖励的次数',
  `rank_data_current` VARCHAR(1024) NOT NULL DEFAULT '[]' COMMENT '排行榜当前数据',
  `liangong_bag` varchar(1024) NOT NULL DEFAULT '[]'  COMMENT '功法临时背包',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家的杂项信息';

#
# Source for table rank
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `rank` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排行榜ID',
  `data` mediumblob NOT NULL COMMENT '排行榜数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='排行榜数据信息';

#
# Source for table relation
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `relation` (
  `id` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `idA` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT 'idA',
  `idB` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT 'idB',
  `rela` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '玩家的双向关系(0:没关系 1:好友 2:黑名单 3:仇人)',
  `intimacy_bt` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通过战斗获得的好友度',
  `intimacy` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '好友度',
  PRIMARY KEY (`id`),
  KEY `idA` (`idA`),
  KEY `idB` (`idB`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家关系';


#
# Source for table guild_dungeon
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `guild_dungeon` (
	`guild_week` bigint(20) unsigned NOT NULL  COMMENT '帮派id加上week', 
	`week_point` tinyint(2) unsigned COMMENT '第几关卡',
	`progress` int(8) unsigned  COMMENT '关卡对应的进度', 
	`guild_id` bigint(20) unsigned NOT NULL COMMENT '帮派id',
	`collection`  int(8) unsigned COMMENT '采集数',
	`kill_count`  int(8) unsigned  COMMENT '击杀数',
	`boss_hp` int(16) unsigned  COMMENT '最终boss剩余的血量' ,
	`rank`  text COMMENT '[{username,value}]',
	 PRIMARY KEY (`guild_week`),
	 KEY `guild_id` (`guild_id`),
	 KEY `progress` (`progress`)	
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮派副本帮派信息'; 


#
# Source for table guild_dungeon_data
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `guild_dungeon_data` (
	`player_id` bigint(20) unsigned NOT NULL  COMMENT '玩家id', 
    `guild_id` bigint(20) unsigned NOT NULL COMMENT '帮派id',
	`get_progress` varchar(256)  DEFAULT '[]' COMMENT '已经领取的进度奖励',
	`contribution` varchar(256)  DEFAULT '[]' COMMENT '贡献[{1，50},{2,300}...]',
	`get_award` tinyint(2) unsigned NOT NULL  DEFAULT '0' COMMENT '玩家战斗力' ,
	`collection` int(8) unsigned DEFAULT '0' COMMENT '收集总数' ,
	`kill_count` int(8) unsigned DEFAULT '0' COMMENT '击杀总数' ,
	`damage_value` int(11) unsigned DEFAULT '0' COMMENT '伤害总数' ,
	 PRIMARY KEY (`player_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮派副本个人信息';



#
# Source for table road
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `road` (
	`player_id` bigint(18)  NOT NULL  COMMENT '玩家id', 
	`now_point` int(11)  COMMENT '当前关卡',
	`get_point` varchar(1024)  COMMENT '领取的关卡奖励[]', 
	`reset_times` int(11)  COMMENT '剩余重置次数',
	`now_battle_partner` varchar(1024) COMMENT '当前出战门客',
	`partner_info`  text  COMMENT '门客信息',
	`player_power` int(11)  DEFAULT '0' COMMENT '玩家战斗力' ,
	`pk_info`  text COMMENT '对手信息',
	`unix_time` int(11)  COMMENT '时间戳', 
	PRIMARY KEY (`player_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='取经之路'; 


#
# Source for table arts
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `arts` (
	`id` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT '内功id' ,
	`art_no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '物品编号', 
	`player_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id' ,
	`partner_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '门客id' ,
	`bind_state` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '当前的绑定状态',
	`star` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '内功品质(1~5星)' ,
	`lv` int(11) unsigned NOT NULL DEFAULT '1' COMMENT '内功等级' ,
	`exp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '内功当前经验'  ,
	`attr_add` varchar(1024) NOT NULL DEFAULT '' COMMENT '内功属性加成,格式如：空字符串|[{属性名,绝对值,相对值},...]',
    `position` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '槽位' ,
	PRIMARY KEY (`id`),
	KEY `player_id` (`player_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='练功'; 


#
# Source for table guess
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `guess` (
	`id` int(11) unsigned NOT NULL COMMENT '竞猜活动ID' ,
	`title` varchar(40) NOT NULL DEFAULT '' COMMENT '竞猜活动标题', 
	`content` text (196605) NOT NULL  COMMENT '竞猜活动内容', 
	`options` text (196605) COMMENT '竞猜选项',
	`correct` int(10) unsigned NOT NULL  DEFAULT '0' COMMENT '正确答案选项' ,
	`commission` int(10) unsigned NOT NULL  DEFAULT '0' COMMENT  '手续费费率' ,
	`is_reward` int(10) unsigned NOT NULL  DEFAULT '0' COMMENT  '0:未结算|1:已结算'  ,
	`time_bet_begin` int(11)  NOT NULL COMMENT '投注开始时间' ,
	`time_bet_end` int(11)  NOT NULL COMMENT '投注结束时间' ,
	`time_show_begin` int(11)  NOT NULL COMMENT '图标展示开始时间' ,
	`time_show_end` int(11)  NOT NULL COMMENT '图标展示结束时间' ,
	`create_time` int(11)  NOT NULL COMMENT '创建日期' ,
	PRIMARY KEY (`id`),
	KEY  `time` (`time_bet_begin`,`time_bet_end`,`time_show_begin`,`time_show_end`),
	KEY `is_reward` (`is_reward`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='竞猜选项'; 


#
# Source for table guess_bet
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `guess_bet` (
	`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id' ,
	`role_id` bigint(20) unsigned NOT NULL  COMMENT '玩家ID' ,
	`guess_id` int(10) unsigned NOT NULL  COMMENT  '题目ID' ,
	`options` tinyint(3) unsigned NOT NULL  COMMENT '选项' ,
	`bet_cup` int(10) unsigned NOT NULL  COMMENT  '投注奖杯' ,
	`bet_rmb` int(10) unsigned NOT NULL  COMMENT  '投注水玉' ,
	`create_time` int(10) unsigned NOT NULL  COMMENT  '投注时间' ,
	PRIMARY KEY (`id`),
	KEY  `role_id_guess_uq` (`role_id`,`guess_id`),
	KEY `role_id_guess_id` (`role_id`,`guess_id`,`options`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家竞猜'; 



#
# Source for table relation_info
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `relation_info` (
  `id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `apply_count_day` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当天剩余申请加为好友次数',
  `last_apply_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次申请加好友时间',
  `offline_msg` blob NOT NULL COMMENT '离线消息',
  `sworn_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '结拜唯一id，目前保存队长的id，如果没有结拜则为0',
  `free_modify_pre_count` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '剩余免费修改前缀次数 队长专用',
  `free_modify_suf_count` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '剩余免费修改后缀次数',
  `sworn_suffix` varchar(128) NOT NULL DEFAULT '' COMMENT '结拜关系称号后缀 1到3个字符',
  `get_intimacy` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '每周通过收花获得的好友度',
  `give_intimacy` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '每周通过送花获得的好友度',
  `spouse_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '配偶玩家id',
  `couple_skill` varchar(512) NOT NULL DEFAULT '' COMMENT '夫妻技能: [id]',
  `time_marry` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上次结婚时间',
  `time_divorce` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上次离婚时间',
  `last_divorce_force` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上次离婚是否为强制离婚',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家好友系统信息';

#
# Source for table role_dungeon
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `role_dungeon` (
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `dun_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '副本编号',
  `pass` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否(1/0)通关',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '冷却时间内第一次创建副本记录的时间戳',
  PRIMARY KEY (`role_id`,`dun_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色副本通关记录';

#
# Source for table server
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `server` (
  `id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '线路id',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'ip地址',
  `port` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '端口号',
  `node` varchar(50) NOT NULL DEFAULT '' COMMENT '节点',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务器列表';

#
# Source for table shop
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `shop` (
  `goods_no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '物品编号',
  `last_refresh_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次刷新时间',
  `expire_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `left_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '表示限量物品当前剩余数量',
  PRIMARY KEY (`goods_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商城表';

#
# Source for table sys_set
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `sys_set` (
  `player_id` bigint(18) unsigned NOT NULL COMMENT 'id',
  `is_auto_add_hp_mp` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '玩家是否开启使用物品自动补给血库和魔法库 1--是，0--否',
  `is_auto_add_par_hp_mp` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '玩家是否开启使用物品自动补给宠物血库和宠物魔法库 1--是，0--否',
  `is_accepted_leader` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许被请求担任队长  0--允许，1--不允许',
  `is_accepted_team_mb` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否接收加入队伍邀请   0--接收，1--不接收',
  `is_accepted_friend` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否接收加为好友请求   0--接收，1--不接收',
  `is_accepted_pk` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否接受pk邀请 0--接收，1--不接收',
  `is_par_clothes_hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '女妖画皮  0 表示展示，1表示隐藏',
  `is_headwear_hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '角色面具  0 表示展示，1表示隐藏',
  `is_backwear_hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '角色背饰  0 表示展示，1表示隐藏',
  `is_clothes_hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '角色时装  0 表示展示，1表示隐藏',
  `paodian_type` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '泡点类型',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家系统设置';

#
# Source for table t_ban_chat
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `t_ban_chat` (
  `role_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '结束禁言时间',
  `reason` varchar(100) NOT NULL DEFAULT '' COMMENT '禁言原因',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='禁言列表';

#
# Source for table t_ban_ip_list
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `t_ban_ip_list` (
  `ip` varchar(15) NOT NULL COMMENT 'IP',
  `end_time` int(11) NOT NULL COMMENT '封禁结束时间',
  `operator` varchar(50) NOT NULL COMMENT '操作员',
  `ban_reason` varchar(256) DEFAULT NULL COMMENT '封禁原因',
  PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='已封禁IP列表';

#
# Source for table t_ban_role
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `t_ban_role` (
  `role_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '结束禁言时间',
  `reason` varchar(100) NOT NULL DEFAULT '' COMMENT '禁角色原因',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='禁角色列表';

#
# Source for table t_broadcast
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `t_broadcast` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型(1->运营后台走马灯,2->其他公告)',
  `priority` tinyint(3) unsigned NOT NULL COMMENT '优先级(1：立即,2：高,3：低)',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '结束时间',
  `interval_time` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '时间间隔(秒)',
  `content` varchar(1024) NOT NULL COMMENT '消息内容',
  `op_type` tinyint(3) unsigned NOT NULL COMMENT '操作类型((1->insert,2->update,3->delete))',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广播消息表（后台公告）';

#
# Source for table task_auto_trigger
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `task_auto_trigger` (
  `role_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务ID',
  PRIMARY KEY (`role_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务自动触发记录';

#
# Source for table task_bag
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `task_bag` (
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务ID',
  `state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '任务状态',
  `accept_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '接受任务时间戳',
  `timing` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '计时器启动时间戳',
  `mark` varchar(2550) NOT NULL DEFAULT '' COMMENT '任务内容',
  `monNo` varchar(50) NOT NULL DEFAULT '' COMMENT '动态任务刷新需寻路的怪',
  PRIMARY KEY (`role_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务表';

#
# Source for table task_completed
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `task_completed` (
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务ID',
  `date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务完成日期',
  `times` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '完成次数',
  `task_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '任务类型',
  PRIMARY KEY (`role_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务完成表';

#
# Source for table task_completed_unrepeat
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `task_completed_unrepeat` (
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `task_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '任务类型',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务ID',
  `date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务完成日期',
  PRIMARY KEY (`role_id`,`task_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单线不可重复任务完成表';

#
# Source for table task_ring
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `task_ring` (
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `master_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '环首任务ID',
  `ring` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '环数',
  `seed` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '随机种子',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '次数',
  `date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '日数',
  PRIMARY KEY (`role_id`,`master_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务环记录';

#
# Source for table tower
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `tower` (
  `id` bigint(20) unsigned NOT NULL COMMENT '玩家ID',
  `floor` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '层数',
  `chal_boss_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '挑战当层BOSS次数',
  `buy_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '购买次数',
  `schedule_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '进度次数',
  `refresh_stamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '刷新时间标记',
  `span_exp_floor` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '领取跨级经验所在层数',
  `best_floor` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '历史最佳进度层数',
  `have_jump` tinyint(3)  unsigned NOT NULL DEFAULT 0 COMMENT '是否已跳层，0否/1是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='爬塔信息表';

#
# Source for table tower_ghost
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `tower_ghost` (
	`player_id` BIGINT(20) UNSIGNED NOT NULL,
	`floor` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '当前层数',
	`times` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '可用次数',
	`last_time_restore` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上次回复次数时间戳',
	PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='伏魔塔';


#
# Source for table hardtower
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `hardtower` (
  `id` bigint(20) unsigned NOT NULL COMMENT '玩家ID',
  `tower_no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '噩梦爬塔副本编号',
  `floor` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '层数',
  `chal_boss_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '挑战当层BOSS次数',
  `buy_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '购买次数',
  `schedule_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '进度次数',
  `refresh_stamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '刷新时间标记',
  `span_exp_floor` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '领取跨级经验所在层数',
  `best_floor` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '历史最佳进度层数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='噩梦爬塔信息表';

#
# Source for table xinfa
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `xinfa` (
  `player_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `xinfa_list` varchar(1024) NOT NULL DEFAULT '' COMMENT '心法列表，格式如：[{心法id，心法等级}, ...]',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家的心法信息';

#
# Source for table offstate
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `offstate`(
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `data` BLOB NOT NULL COMMENT '离线状态数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家的离线挂机等数据';


#
# Source for table activity_data
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `activity_data` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `data` blob NOT NULL COMMENT '活动数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家的活动数据';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `recharge_order`(
  `order_id` varchar(50) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `role_id` bigint unsigned NOT NULL DEFAULT 0 COMMENT '角色id',
  `amount` int unsigned NOT NULL DEFAULT 0 COMMENT '充值数额',
  `state` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '订单状态 0:未处理 1:已处理',
  `timestamp` int unsigned NOT NULL DEFAULT 0 COMMENT '充值时间戳',
  PRIMARY KEY (`order_id`),
  KEY `role_id_state` (`role_id`, `state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值订单数据';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `tve_data` (
  `lv_step` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '等级段',
  `data` blob NOT NULL COMMENT '排名数据',
  PRIMARY KEY (`lv_step`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组队兵临城下数据';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `dungeon_plot_target`(
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `data` BLOB NOT NULL COMMENT '剧情副本目标数据 [{副本编号, 领奖次数, 领奖时间戳}, ...]',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='剧情副本目标信息';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `sys_data` (
  `id` int unsigned NOT NULL DEFAULT '0' COMMENT '业务逻辑系统代号',
  `data` blob NOT NULL COMMENT '业务逻辑系统数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务逻辑系统数据';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `title` (
  `id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `data` blob NOT NULL COMMENT '称号数据',
  `diy_title` blob COMMENT '定制称号',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `offcast` (
  `id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `data` blob NOT NULL COMMENT '离线cast数据',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `admin_activity`(
  `order_id` bigint unsigned NOT NULL DEFAULT 0 COMMENT '活动订单ID',
  `start_time` int unsigned NOT NULL DEFAULT 0 COMMENT '活动开始时间',
  `end_time` int unsigned NOT NULL DEFAULT 0 COMMENT '活动结束时间',
  `mail_title` varchar(50) NOT NULL DEFAULT '' COMMENT '邮件标题',
  `mail_content` varchar(300) NOT NULL DEFAULT '' COMMENT '邮件内容',
  `mail_attach` varchar(300) NOT NULL DEFAULT '[]' COMMENT '邮件附件',
  `client_start_time` int unsigned NOT NULL DEFAULT 0 COMMENT '客户端图标出现时间',
  `client_end_time` int unsigned NOT NULL DEFAULT 0 COMMENT '客户端图标关闭时间',
  `client_content` blob COMMENT '客户端显示活动详细内容',
  PRIMARY KEY (`order_id`),
  KEY `time` (`end_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运营活动数据';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `role_admin_activity`(
  `role_id` bigint unsigned NOT NULL DEFAULT 0 COMMENT '角色ID',
  `order_id_list` blob COMMENT '玩家已经参与的运营活动订单ID列表',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色参与运营活动信息';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `offline_arena_daily_rank`(
  `role_id` bigint unsigned NOT NULL DEFAULT 0 COMMENT '角色ID',
  `rank` int unsigned NOT NULL DEFAULT 0 COMMENT '排名',
  `arena_group` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '分组',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='离线竞技场每日保存的排名信息';



DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `first_open_server_time`(
  first_timestamp int unsigned NOT NULL DEFAULT 0 COMMENT '首次开服时间戳'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='首次开服时间';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `recharge_feedback`(
  `order_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `accname` varchar(50) NOT NULL DEFAULT '' COMMENT 'UCID',
  `amount` int NOT NULL DEFAULT 0 COMMENT '金额',
  `order_type` tinyint  NOT NULL DEFAULT 0 COMMENT '订单类型(0->普通订单,1->总额订单)',
  `state` tinyint NOT NULL DEFAULT 0 COMMENT '订单状态(0->正常,1->异常)',
  PRIMARY KEY (`order_id`),
  KEY `acc_state` (`accname`, `state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值返还';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `admin_sys_activity`(
  `order_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '活动订单ID',
  `trigger_timestamp` int unsigned NOT NULL DEFAULT 0 COMMENT '活动触发时间戳',
  `end_timestamp` int unsigned NOT NULL DEFAULT 0 COMMENT '活动结束时间戳',
  `content` blob COMMENT '活动数据内容',
  `origin_content` blob COMMENT '活动原始数据',
  `show_panel` blob COMMENT '客户端展示内容',
  `sys` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '系统类型',
  `state` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '活动状态(0:未开启,1:正在开启,2:过期)',
  `display` tinyint unsigned NOT NULL DEFAULT 1 COMMENT '是否显示(0:否 1:是)',
  PRIMARY KEY (`order_id`),
  KEY `time` (`end_timestamp`, `state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台与游戏系统相关活动';

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;


#
# Source for table sworn
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `sworn` (
  `id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '结拜id,用队长id唯一标识',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '结拜类型 1 普通结拜，2 生死结拜',
  `prefix_only` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '前缀是否唯一，1表示唯一',
  `prefix` varchar(128) NOT NULL DEFAULT '' COMMENT '结拜关系称号后缀 1到3个字符',
  `suffix_list` varchar(1024) NOT NULL DEFAULT '' COMMENT '后缀列表',
  `members` varchar(256) NOT NULL DEFAULT '' COMMENT '好友id列表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家结拜数据';



DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `rank_history` (
  `id` SERIAL COMMENT '流水号',
  `rank_id` int unsigned NOT NULL DEFAULT '0' COMMENT '排行榜ID',
  `rank` int unsigned NOT NULL DEFAULT '0' COMMENT '排名',
  `player_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `data` varchar(255) NOT NULL DEFAULT '' COMMENT '数值',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='历史排行榜';



DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `sprd` (
  `player_id` bigint(18) unsigned NOT NULL COMMENT '玩家id',
  `code` char(8) NOT NULL COMMENT '8位的推广码',
  `sprdee_list` varchar(512) NOT NULL DEFAULT '{}' COMMENT '玩家的被推广人列表（存储时先转为tuple格式再存）',
  `sprder_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '玩家的推广人的id',
  PRIMARY KEY (`player_id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家的推广信息';



DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `cdk_8` (
  `cdk` char(8) NOT NULL COMMENT '',
  UNIQUE KEY (`cdk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='已生成的8位激活码';



DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `cdk_misc` (
  `reserve_cdk_8_count` int unsigned NOT NULL DEFAULT '0' COMMENT '已生成的保留的8位激活码的数量',
  `reserve_cdk_16_count` int unsigned NOT NULL DEFAULT '0' COMMENT '已生成的保留的16位激活码的数量'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='激活码相关的信息';

# 初始化cdk_misc表
insert into `cdk_misc` set `reserve_cdk_8_count` = 0, `reserve_cdk_16_count` = 0;



DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `role_transport`(
  `role_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色ID',
  `truck_lv` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '镖车等级',
  `transport_times` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '运输次数',
  `hijack_times` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '劫车次数',
  `refresh_times` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '刷新次数',
  `days_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '公元1年到当天日数',
  `news` varchar(2048) NOT NULL DEFAULT '[]' COMMENT '新闻信息',
  `attentives` varchar(512) NOT NULL DEFAULT '[]' COMMENT '关注列表',
  `free_times` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '已使用免费次数',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运镖个人信息';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `truck_info`(
  `role_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色ID',
  `role_lv` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色等级',
  `truck_lv` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '镖车等级',
  `start_timestamp` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '开始运车时间戳',
  `be_hijacked_times` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '被劫次数',
  `cur_stage` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '当前阶段',
  `cur_stage_timestamp` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '当前阶段开始时的时间戳',
  `cur_event` varchar(64) NOT NULL DEFAULT '[]' COMMENT '当前发生的事件集合',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运镖镖车信息';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `admin_festival_activity`(
  `order_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '活动订单ID',
  `no` int unsigned NOT NULL DEFAULT 0 COMMENT '活动编号',
  `start_timestamp` int unsigned NOT NULL DEFAULT 0 COMMENT '活动开始时间戳',
  `end_timestamp` int unsigned NOT NULL DEFAULT 0 COMMENT '活动结束时间戳',
  `content` blob COMMENT '活动数据内容',
  `type` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '活动类型',
  `state` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '活动状态(0:未开启,1:正在开启,2:过期)',
  PRIMARY KEY (`order_id`),
  KEY `time` (`end_timestamp`, `state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台节日活动';

-- ----------------------------
-- 商会信息数据
-- ----------------------------
DROP TABLE IF EXISTS `business`;
CREATE TABLE `business` (
  `id` bigint(20) unsigned NOT NULL COMMENT '玩家ID',
  `data` blob NOT NULL COMMENT '商会数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商会信息';

-- Date: 2014年10月17日
-- Author: YanLihong
-- Description: 女妖选美-抽奖活动
-- --------------------------------------------------------
--
-- 表的结构 `beauty_contest`
--
DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `beauty_contest` (
	`id` bigint(20) unsigned NOT NULL COMMENT '玩家ID',
	`data` blob NOT NULL COMMENT '抽奖数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='女妖选美-抽奖活动';
-- --------------------------------------------------------
-- Date: 2014年10月23日
-- Author: YanLihong
-- Description: 女妖选美-抽奖活动 数据统计
-- --------------------------------------------------------
--
--
DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `beauty_contest_counter` (
	`id` bigint(20) unsigned NOT NULL COMMENT '活动ID',
	`data` mediumblob NOT NULL COMMENT '玩家抽奖统计数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='女妖选美-抽奖活动 玩家抽奖统计';
-- --------------------------------------------------------
DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `beauty_contest_goods_record` (
	`id` bigint(20) unsigned NOT NULL COMMENT '活动ID',
	`data` blob NOT NULL COMMENT '重要物品记录数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='女妖选美-抽奖活动 重要物品记录';
-- --------------------------------------------------------

-- Date: 2014年11月6日
-- Author: YanLihong
-- Description: 女妖乱斗 玩家数据
-- --------------------------------------------------------
--
--
DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `role_melee_info` (
	`id` bigint(20) unsigned NOT NULL COMMENT '玩家ID',
	`status` tinyint(1) unsigned NOT NULL COMMENT '玩家活动状态 (0未报名 1已报名 2已提交完成)',
	`ball_num` int(11) unsigned NOT NULL COMMENT '玩家龙珠数量',
	`scene_no` int(11) unsigned NOT NULL COMMENT '玩家分配的场景编号',
	`create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='女妖乱斗 玩家数据';
-- --------------------------------------------------------


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `global_sys_var` (
  `sys` int unsigned NOT NULL COMMENT '系统类型',
  `var` blob COMMENT '变量值',
  PRIMARY KEY (`sys`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统变量表';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `global_activity_data`(
  `no` int unsigned NOT NULL COMMENT '活动编号',
  `data` mediumblob COMMENT '活动数据',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='全局活动大型数据';


-- Date: 2014年11月27日
-- Author: YanLihong
-- Description: 悬赏任务数据
-- --------------------------------------------------------
DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `xs_task` (
	`id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT '唯一ID',
	`data` MEDIUMTEXT NOT NULL COMMENT '玩家悬赏任务数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='悬赏任务数据';
-- --------------------------------------------------------

-- Date: 2015年01月16日
-- Author: liufang
-- Description: 年夜宴会数据
-- --------------------------------------------------------
DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `newyear_banquet` (
  `id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT '唯一ID',
  `banquet_lv` int unsigned NOT NULL COMMENT '宴会等级',
  `banquet_exp` int(11) unsigned NOT NULL COMMENT '宴会经验',
  `data` mediumblob NOT NULL COMMENT '玩家加菜数据',
  `create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='年夜宴会数据';

-- Date: 2015年03月25日
-- Author: liufang
-- Description: 幸运转盘数据
-- --------------------------------------------------------
DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `ernie` (
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `ernie_times` int unsigned NOT NULL COMMENT '玩家转盘次数',
  `ernie_add_time` int(11) unsigned NOT NULL COMMENT '最后一次增加时间',
  `ernie_sub_time` int(11) unsigned NOT NULL COMMENT '最后一次减少时间',
  `data` BLOB NULL COMMENT '转盘数据',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家的幸运转盘数据信息';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `pvp_cross_player_info` (
	`player_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id' ,
	`server_id` int(6) unsigned NOT NULL DEFAULT '0' COMMENT '角色所在服务器ID' ,
	`player_name` varchar(20) NOT NULL DEFAULT '' COMMENT '玩家名字' ,
	`sex`  tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '性别' ,
	`race` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '种族' ,
	`faction` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '门派' ,
	`win` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '赢场数' ,
	`lose` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '输场数' ,
	`escape` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '逃场数' ,
	`daytimes` int(6) unsigned NOT NULL DEFAULT '0' COMMENT '每天参与的次数' ,
	`tiemstamp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最新匹配时间戳' ,
	`dan` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '段位' ,
	`score` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分数' ,
	`reward` varchar(2048)  DEFAULT '[]' COMMENT '玩家已经分数领取的奖励' ,
	`dayreward` varchar(2048)  DEFAULT '[]' COMMENT '每日参与领取的奖励' 
); 

#
# Source for table partner
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `mount` (
  `id` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT '坐骑唯一id',
  `player_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '所属玩家id',
  `no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑编号，由策划制定',
  `name` varchar(15) NOT NULL DEFAULT '' COMMENT '坐骑名称',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑类型[t1,t2,t3三种类型]', 
  `quality` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑星级[五个星级档次]',
  `level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑等级',
  `exp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑成长值',
  `attribute_1` smallint(5) NOT NULL DEFAULT '0' COMMENT '坐骑属性编号1',
  `attribute_2` smallint(5) NOT NULL DEFAULT '0' COMMENT '坐骑属性编号2',
  `attribute_3` smallint(5) NOT NULL DEFAULT '0' COMMENT '坐骑属性编号3',
  `attribute_add1` int(11) NOT NULL DEFAULT '8' COMMENT '坐骑增益属性比率[800~1200]',
  `attribute_add2` int(11) NOT NULL DEFAULT '8' COMMENT '坐骑增益属性比率[800~1200]',
  `attribute_sub` int(11) NOT NULL DEFAULT '5' COMMENT '坐骑减益属性比率[500~800]',
  `attributeList` varchar(512) NOT NULL DEFAULT '[]' COMMENT '坐骑属性[{编号1,编号2，编号3，增益比率，减益比率}]',
  `skillNum` smallint(5) NOT NULL DEFAULT '0' COMMENT '坐骑技能格子数',
  `skill` varchar(512) NOT NULL DEFAULT '[0,0,0,0]' COMMENT '坐骑技能[技能id,技能id]',
  `step` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑阶数',
  `step_value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑阶数值',
  `is_partner` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑是否有关联宠物',
  `partner_num` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑关联宠物数量',
  `partner1` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑关联宠物1的id',
  `partner2` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑关联宠物2的id',
  `partner3` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑关联宠物3的id',
  `partner4` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑关联宠物4的id',
  `partner5` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑关联宠物5的id',
  `feed` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑喂养次数',
  `feed_timestamp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次喂养坐骑时间',
  `status`  tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑是否骑乘',
  `battle_power` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑战斗力',
  `custom_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '定制类型 0非定制 1SR 2SSR 3SSS 4SSSR',
  `partner_maxnum` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '坐骑关联宠物数量上限',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间戳',
  PRIMARY KEY (`id`),
  KEY `index_player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='坐骑信息';

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `mount_skin` (
  `id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `data` blob NOT NULL COMMENT '皮肤数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='坐骑皮肤信息';

-- Date: 2015年10月24日
-- Author: duan
-- Description: 玩家拓展信息
DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `player_ext` (
`id`  bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
`player_id`  bigint(18) NOT NULL DEFAULT 0 COMMENT '玩家id' ,
`key`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段key' ,
`value`  int(11) NOT NULL DEFAULT 0 COMMENT '值' ,
PRIMARY KEY (`id`),
KEY `index_player_id` (`player_id`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家拓展信息表格';

-- Date: 2015年10月29日
-- Author: duan
-- Description: 老虎机
DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `slotmachine` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `rounds` int(11) NOT NULL DEFAULT '0' COMMENT '轮次',
  `player_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `change` int(11) NOT NULL DEFAULT '0' COMMENT '购买的类别',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT '期货购买的数量',
  `infos` text CHARACTER SET utf8 NOT NULL COMMENT '购买信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `player_rounds` (`rounds`,`player_id`),
  KEY `player` (`player_id`) USING BTREE,
  KEY `rounds` (`rounds`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='老虎机信息';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `slotmachine_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `rounds` int(11) NOT NULL DEFAULT '0' COMMENT '轮次',
  `no` int(11) NOT NULL DEFAULT '0' COMMENT '开出记录',
  `change` int(11) NOT NULL DEFAULT '0' COMMENT '大盘涨跌',
  `open_time` int(11) NOT NULL DEFAULT '0' COMMENT '开奖日期',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rounds` (`rounds`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='老虎机历史开奖信息';


-- Date: 2015年10月29日
-- Author: duan
-- Description: 帮战信息

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `guild_battle_player_info` (
`id`  bigint(18) NOT NULL AUTO_INCREMENT COMMENT '唯一id' ,
`player_id`  bigint(18) NOT NULL COMMENT '玩家id' ,
`rounds`  int(11) NOT NULL DEFAULT 0 COMMENT '轮次' ,
`guild_id`  bigint(18) NOT NULL COMMENT '帮派id' ,
`guild_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '帮派名称' ,
`halt_time`  int(11) NOT NULL DEFAULT 0 COMMENT '等待时间' ,
`enter1_count`  int(11) NOT NULL DEFAULT 0 COMMENT '进入第一区域次数' ,
`enter1_time`  int(11) NOT NULL DEFAULT 0 COMMENT '进入第一区域时间' ,
`enter2_count`  int(11) NOT NULL DEFAULT 0 COMMENT '进入第二区域次数' ,
`enter2_time`  int(11) NOT NULL DEFAULT 0 COMMENT '进入第二区域时间' ,
`enter3_count`  int(11) NOT NULL DEFAULT 0 COMMENT '进入第三区域次数' ,
`enter3_time`  int(11) NOT NULL DEFAULT 0 COMMENT '进入第三区域时间' ,
`touch_throne`  int(11) NOT NULL DEFAULT 0 COMMENT '触摸王座次数' ,
`interrupt_load`  int(11) NOT NULL COMMENT '打断别人读条次数' ,
`battle_win`  int(11) NOT NULL DEFAULT 0 COMMENT '战斗胜利次数' ,
`battle_lose`  int(11) NOT NULL DEFAULT 0 COMMENT '战斗失败次数' ,
`max_winning_streak`  int(11) NOT NULL DEFAULT 0 COMMENT '最大连胜次数' ,
`quick_enetr2_count`  int(11) NOT NULL DEFAULT 0 COMMENT '快速进入2层次数' ,
`quick_clear_halt_time_count`  int(11) NOT NULL DEFAULT 0 COMMENT '快速清理冷却时间次数' ,
`point`  int(11) NOT NULL COMMENT '积分用于排名计算' ,
`rank`  int(11) NOT NULL COMMENT '排名' ,
PRIMARY KEY (`id`),
UNIQUE INDEX `player_id_rounds` (`player_id`, `rounds`) USING BTREE 
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮派战玩家信息';

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `guild_battle_history` (
`rounds`  int(11) NOT NULL DEFAULT 0 COMMENT '轮次' ,
`join_battle_player_count`  int(11) NOT NULL DEFAULT 0 COMMENT '参与帮战人数' ,
`join_battle_guild_count`  int(11) NOT NULL DEFAULT 0 COMMENT '参战帮派数量' ,
`better_fighter_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '战斗王' ,
`better_fighter_player_id`  bigint(18) NOT NULL COMMENT '战斗王id' ,
`better_touch_throne_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '偷鸡王' ,
`better_touch_throne_player_id`  bigint(18) NOT NULL ,
`better_trouble_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '捣蛋王' ,
`better_trouble_player_id`  bigint(18) NOT NULL COMMENT '捣蛋王id' ,
`better_streak_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '连杀王' ,
`better_streak_player_id`  bigint(18) NOT NULL COMMENT '最大连胜王id' ,
`better_try_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '尽力王' ,
`better_try_player_id`  bigint(18) NOT NULL COMMENT '尽力王玩家id' ,
`better_defend_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '防守王',
`better_defend_player_id`  bigint(18) NOT NULL COMMENT '防守王id',
`join_battle_max_rate`  int(4) NOT NULL COMMENT '最佳参战率帮派参战率' ,
`join_battle_max_rate_guild_id`  bigint(18) NOT NULL COMMENT '最佳参战率帮派id' ,
`join_battle_max_rate_guild_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '最佳参战率帮派名称' ,
`join_battle_max_count`  int(4) NOT NULL COMMENT '参战人数最多的帮派参战人数' ,
`join_battle_max_count_guild_id`  bigint(18) NOT NULL COMMENT '参战人数最多的帮派id' ,
`join_battle_max_count_guild_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参战人数最多的帮派名称' ,
`win_guild_id`  bigint(18) NOT NULL COMMENT '获得胜利的帮派id' ,
`win_guild_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '获得胜利的帮派名字' ,
`take_throne_player_id`  bigint(18) NOT NULL COMMENT '最后获得王座的玩家id' ,
`take_throne_player_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '最后获得王座的玩家名称' ,
PRIMARY KEY (`rounds`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮派战历史记录';

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `guild_battle_guild_info` (
`id`  bigint(18) NOT NULL AUTO_INCREMENT COMMENT 'id' ,
`rounds`  bigint(18) NOT NULL ,
`guild_id`  bigint(18) NOT NULL COMMENT '帮派id' ,
`guild_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '帮派名称' ,
`rank`  int(11) NOT NULL COMMENT '排名' ,
`join_battle_player_count`  int(11) NOT NULL COMMENT '参战人数' ,
`battle_count`  int(11) NOT NULL COMMENT '战斗次数' ,
`battle_win_count`  int(11) NOT NULL COMMENT '战斗胜利次数' ,
`touch_throne`  int(11) NOT NULL DEFAULT 0 COMMENT '触摸王座次数' ,
`point`  int(11) NOT NULL COMMENT '积分' ,
PRIMARY KEY (`id`),
UNIQUE INDEX `rounds_guild_id` (`rounds`, `guild_id`) USING BTREE 
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮派战帮派信息';


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `db_version` (
`id`  int(10) NOT NULL DEFAULT 1 COMMENT 'id' ,
`version`  bigint(18) NOT NULL DEFAULT 0 COMMENT 'version',
PRIMARY KEY (`id`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据库版本号';



#
# Source for table act_jingyan
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `act_jingyan` (
                        `id` bigint(20) unsigned NOT NULL COMMENT '玩家id' ,
                        `info` varchar(2048) NOT NULL DEFAULT '[]' COMMENT '次数记录',
                        PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='找回经验';
