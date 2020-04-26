
use simserver;


ALTER TABLE `find_par` DROP `counter`;

ALTER TABLE `find_par` ADD COLUMN `counters` varchar(512) NOT NULL DEFAULT '' COMMENT '计数器信息，用于实现需要保底功能';
