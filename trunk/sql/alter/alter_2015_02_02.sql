
use simserver;


ALTER TABLE `player` ADD COLUMN `one_recharge_reward` varchar(512) NOT NULL DEFAULT '[]' COMMENT '上次领取单笔充值奖励信息[{充值钱的数量, 时间戳}]';

