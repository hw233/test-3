
use simserver;


DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `hardtower` (
  `id` bigint(20) unsigned NOT NULL COMMENT '玩家ID',
  `tower_no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '噩梦爬塔副本编号'
  `floor` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '层数',
  `chal_boss_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '挑战当层BOSS次数',
  `buy_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '购买次数',
  `schedule_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '进度次数',
  `refresh_stamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '刷新时间标记',
  `span_exp_floor` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '领取跨级经验所在层数',
  `best_floor` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '历史最佳进度层数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='噩梦爬塔信息表';
