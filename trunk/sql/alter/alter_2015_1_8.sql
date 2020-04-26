
use simserver;


ALTER TABLE `player` ADD COLUMN `from_server_id` int(6) unsigned NOT NULL DEFAULT '0' COMMENT '表示角色是在哪个服创建的，server_id = 平台号*10000 + 平台下的服务器流水编号';

