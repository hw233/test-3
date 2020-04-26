
use simserver;


ALTER TABLE `player` ADD COLUMN `zf_state` varchar(64) NOT NULL DEFAULT '[]' COMMENT '玩家阵法学习信息[0, 1, 2, 3,....]';
