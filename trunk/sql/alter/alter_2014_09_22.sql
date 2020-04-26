
use simserver;

ALTER TABLE `partner` ADD COLUMN `version` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '数据版本,用于调整线上数据(规则调整等情况)';

ALTER TABLE `partner_hotel` ADD COLUMN `version` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '数据版本,用于调整线上数据(规则调整等情况)';
