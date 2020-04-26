
use simserver;

DROP TABLE IF EXISTS `role_transport`;
CREATE TABLE `role_transport`(
  `role_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色ID',
  `truck_lv` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '镖车等级',
  `transport_times` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '运输次数',
  `hijack_times` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '劫车次数',
  `refresh_times` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '刷新次数',
  `days_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '公元1年到当天日数',
  `news` varchar(2048) NOT NULL DEFAULT '[]' COMMENT '新闻信息',
  `attentives` varchar(512) NOT NULL DEFAULT '[]' COMMENT '关注列表',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运镖个人信息';


DROP TABLE IF EXISTS `truck_info`;
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


DROP TABLE IF EXISTS `admin_festival_activity`;
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
