

#
# Source for table act_jingyan
#

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `act_jingyan` (
                               `id` bigint(20) unsigned NOT NULL COMMENT '玩家id' ,
                               `info` varchar(2048) NOT NULL DEFAULT '[]' COMMENT '次数记录',
                               PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='找回经验';