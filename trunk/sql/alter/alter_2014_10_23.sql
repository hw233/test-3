
use simserver;


-- Date: 2014年10月23日
-- Author: YanLihong
-- Description: 女妖选美-抽奖活动 数据统计
-- --------------------------------------------------------
--
--
DROP TABLE IF EXISTS `beauty_contest_counter`;
CREATE TABLE `beauty_contest_counter` (
	`id` bigint(20) unsigned NOT NULL COMMENT '活动ID',
	`data` mediumblob NOT NULL COMMENT '玩家抽奖统计数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='女妖选美-抽奖活动 玩家抽奖统计';
-- --------------------------------------------------------
DROP TABLE IF EXISTS `beauty_contest_goods_record`;
CREATE TABLE `beauty_contest_goods_record` (
	`id` bigint(20) unsigned NOT NULL COMMENT '活动ID',
	`data` blob NOT NULL COMMENT '重要物品记录数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='女妖选美-抽奖活动 重要物品记录';
-- --------------------------------------------------------
