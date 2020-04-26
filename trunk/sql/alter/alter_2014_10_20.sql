
use simserver;

-- Date: 2014年10月17日
-- Author: YanLihong
-- Description: 女妖选美-抽奖活动
-- --------------------------------------------------------
--
-- 表的结构 `beauty_contest`
--
DROP TABLE IF EXISTS `beauty_contest`;
CREATE TABLE `beauty_contest` (
	`id` bigint(20) unsigned NOT NULL COMMENT '玩家ID',
	`data` blob NOT NULL COMMENT '抽奖数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='女妖选美-抽奖活动';
-- --------------------------------------------------------

ALTER TABLE `guild` ADD COLUMN `total_bid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '本周帮派争夺战投标的总money(绑银) 周日0点清空';
ALTER TABLE `guild` ADD COLUMN `bid_id_list` blob NOT NULL COMMENT '本周报名帮派争夺战的玩家id列表 周日0点清空';


ALTER TABLE `guild_member` ADD COLUMN `bid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '本周为帮派争夺战投标的money(绑银) 周日0点清空';


ALTER TABLE `relation` ADD COLUMN `intimacy_bt` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通过战斗获得的好友度';



