
use simserver;


ALTER TABLE `player` ADD COLUMN `recharge_accum_day` varchar(64) NOT NULL DEFAULT '{0, 0, 0}' COMMENT '充值累积状态 {累积值, 最近一次叠加的时间戳, 活动ID}';
