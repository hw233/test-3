
use simserver;

-- 修改银币字段类型
ALTER TABLE `player` CHANGE COLUMN `gamemoney` `gamemoney` BIGINT UNSIGNED NOT NULL DEFAULT '0' AFTER `bind_yuanbao`;
ALTER TABLE `player` CHANGE COLUMN `bind_gamemoney` `bind_gamemoney` BIGINT UNSIGNED NOT NULL DEFAULT '0' AFTER `gamemoney`;