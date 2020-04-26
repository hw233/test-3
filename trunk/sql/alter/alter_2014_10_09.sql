
use simserver;


ALTER TABLE `player` ADD COLUMN `consume_state` varchar(600) NOT NULL DEFAULT '[]' COMMENT '消费状态 [{钱类型, {累积值, 最近一次叠加的时间戳}}, ..]';
