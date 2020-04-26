use simserver;

ALTER TABLE `partner` ADD COLUMN `cultivate_layer` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '修炼层数';
ALTER TABLE `partner_hotel` ADD COLUMN `cultivate_layer` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '修炼层数';

alter table `rank` modify `data` mediumblob NOT NULL;
