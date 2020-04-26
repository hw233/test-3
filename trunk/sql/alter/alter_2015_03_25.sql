
use simserver;

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `ernie` (
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `ernie_times` int unsigned NOT NULL COMMENT '玩家转盘次数',
  `ernie_add_time` int(11) unsigned NOT NULL COMMENT '最后一次增加时间',
  `ernie_sub_time` int(11) unsigned NOT NULL COMMENT '最后一次减少时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家的幸运转盘数据信息';
