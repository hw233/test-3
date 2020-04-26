
use simserver;


ALTER TABLE `relation_info` ADD COLUMN `spouse_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '配偶玩家id';
ALTER TABLE `relation_info` ADD COLUMN `couple_skill` varchar(512) NOT NULL DEFAULT '' COMMENT '夫妻技能: [id]';
