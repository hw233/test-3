
use simserver;


ALTER TABLE `partner` ADD COLUMN `add_skill_fail_cnt` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '新增后天技能失败次数，当成功新增一个技能，次数清零';

ALTER TABLE `partner_hotel` ADD COLUMN `add_skill_fail_cnt` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '新增后天技能失败次数，当成功新增一个技能，次数清零';


ALTER TABLE `player_misc` ADD COLUMN `guild_war_id`  bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '上次参加帮派争霸赛所在帮派id';
ALTER TABLE `player_misc` ADD COLUMN `guild_war_turn` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次参加帮派争霸赛届数';



--  hi, just test --

-- hi , just test again --