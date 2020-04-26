use simserver;

DROP TABLE IF EXISTS `global_activity_data`;
CREATE TABLE `global_activity_data`(
  `no` int unsigned NOT NULL COMMENT '活动编号',
  `data` mediumblob COMMENT '活动数据',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='全局活动大型数据';