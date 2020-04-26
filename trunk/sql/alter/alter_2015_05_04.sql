
use simserver;

DROP TABLE IF EXISTS `__dummy_table_name__`;
CREATE TABLE `mount` (
  `id` bigint(18) unsigned NOT NULL AUTO_INCREMENT COMMENT '坐骑唯一id',
  `player_id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '所属玩家id',
  `no` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑编号，由策划制定',
  `name` varchar(15) NOT NULL DEFAULT '' COMMENT '坐骑名称',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑类型[t1,t2,t3三种类型]', 
  `quality` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑星级[五个星级档次]',
  `level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑等级',
  `exp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑成长值',
  `attribute_1` smallint(5) NOT NULL DEFAULT '0' COMMENT '坐骑属性编号1',
  `attribute_2` smallint(5) NOT NULL DEFAULT '0' COMMENT '坐骑属性编号2',
  `attribute_3` smallint(5) NOT NULL DEFAULT '0' COMMENT '坐骑属性编号3',
  `attribute_add1` int(11) NOT NULL DEFAULT '8' COMMENT '坐骑增益属性比率[800~1200]',
  `attribute_add2` int(11) NOT NULL DEFAULT '8' COMMENT '坐骑增益属性比率[800~1200]',
  `attribute_sub` int(11) NOT NULL DEFAULT '5' COMMENT '坐骑减益属性比率[500~800]',
  `attributeList` varchar(512) NOT NULL DEFAULT '[]' COMMENT '坐骑属性[{编号1,编号2，编号3，增益比率，减益比率}]',
  `skillNum` smallint(5) NOT NULL DEFAULT '0' COMMENT '坐骑技能格子数',
  `skill` varchar(512) NOT NULL DEFAULT '[0,0,0,0]' COMMENT '坐骑技能[技能id,技能id]',
  `step` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑阶数',
  `step_value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑阶数值',
  `is_partner` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑是否有关联宠物',
  `partner_num` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑关联宠物数量',
  `partner1` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑关联宠物1的id',
  `partner2` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑关联宠物2的id',
  `feed` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑喂养次数',
  `feed_timestamp` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次喂养坐骑时间',
  `status`  tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑是否骑乘',
  `battle_power` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐骑战斗力',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间戳',
  PRIMARY KEY (`id`),
  KEY `index_player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='坐骑信息';
