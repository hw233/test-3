
use simserver;

-- 增加结婚系统新字段
ALTER TABLE `relation_info` ADD COLUMN `time_marry` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上次结婚时间';
ALTER TABLE `relation_info` ADD COLUMN `time_divorce` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上次离婚时间';
ALTER TABLE `relation_info` ADD COLUMN `last_divorce_force` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上次离婚是否为强制离婚';