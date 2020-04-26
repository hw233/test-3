
use simserver;

ALTER TABLE `player` ADD COLUMN `priv_lv` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '权限级别（0：普通玩家，1：指导员，2：GM）';
