
use simserver;


ALTER TABLE `player_misc` ADD COLUMN `free_stren_cnt` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '今天剩余免费强化装备次数';

