
use simserver;


-- Date: 2014年11月27日
-- Author: YanLihong
-- Description: 悬赏任务数据
-- --------------------------------------------------------
DROP TABLE IF EXISTS `xs_task`;
CREATE TABLE `xs_task` (
	`id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT '唯一ID',
	`data` MEDIUMTEXT NOT NULL COMMENT '玩家悬赏任务数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='悬赏任务数据';
-- --------------------------------------------------------

ALTER TABLE `player` ADD COLUMN `xs_task_issue_num` int(11) NOT NULL DEFAULT 0 COMMENT '悬赏任务已经发布次数';
ALTER TABLE `player` ADD COLUMN `xs_task_left_issue_num` int(11) NOT NULL DEFAULT 200 COMMENT '悬赏任务剩余发布次数';
ALTER TABLE `player` ADD COLUMN `xs_task_receive_num` int(11) NOT NULL DEFAULT 0 COMMENT '悬赏任务已经领取次数';
