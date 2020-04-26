
use simserver;


-- Date: 2014年11月6日
-- Author: YanLihong
-- Description: 女妖乱斗 玩家数据
-- --------------------------------------------------------
--
--
DROP TABLE IF EXISTS `role_melee_info`;
CREATE TABLE `role_melee_info` (
	`id` bigint(20) unsigned NOT NULL COMMENT '玩家ID',
	`status` tinyint(1) unsigned NOT NULL COMMENT '玩家活动状态 (0未报名 1已报名 2已提交完成)',
	`ball_num` int(11) unsigned NOT NULL COMMENT '玩家龙珠数量',
	`scene_no` int(11) unsigned NOT NULL COMMENT '玩家分配的场景编号',
	`create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='女妖乱斗 玩家数据';
-- --------------------------------------------------------
