use simserver;

ALTER TABLE `player` ADD COLUMN `admin_acitvity_state` varchar(2048) NOT NULL DEFAULT '[]' COMMENT '后台活动状态 [{活动类型, 累计值, 最近一次叠加的时间戳, 活动标志} | _]';

ALTER TABLE `player` ADD COLUMN `exp_slot` varchar(50) NOT NULL DEFAULT '[]' COMMENT '储备槽经验';


DROP TABLE IF EXISTS `global_sys_var`;
CREATE TABLE `global_sys_var` (
  `sys` int unsigned NOT NULL COMMENT '系统类型',
  `var` blob COMMENT '变量值',
  PRIMARY KEY (`sys`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统变量表';
