
use simserver;


ALTER TABLE `player` ADD COLUMN `mount` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '玩家当前骑乘的坐骑id';
ALTER TABLE `partner` ADD COLUMN `mount_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '宠物关联坐骑id';
ALTER TABLE `partner_hotel` ADD COLUMN `mount_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '宠物关联坐骑id';

