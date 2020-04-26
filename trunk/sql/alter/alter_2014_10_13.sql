
use simserver;

ALTER TABLE `player_misc` ADD COLUMN `guild_dungeon_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次参加帮派副本时间';
ALTER TABLE `player_misc` ADD COLUMN `guild_dungeon_id`  bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '上次参加帮派副本所在帮派id'