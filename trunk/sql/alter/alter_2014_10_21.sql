
use simserver;





ALTER TABLE `relation` ADD COLUMN `intimacy` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '好友度';



ALTER TABLE `relation_info` ADD COLUMN  `get_intimacy` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '每周通过收花获得的好友度';




ALTER TABLE `relation_info` ADD COLUMN  `give_intimacy` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '每周通过送花获得的好友度';




 
  

ALTER TABLE `role_transport` ADD COLUMN `free_times` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '已使用免费次数';

