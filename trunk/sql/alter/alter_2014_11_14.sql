
use simserver;


-- Date: 2014��11��6��
-- Author: YanLihong
-- Description: Ů���Ҷ� �������
-- --------------------------------------------------------
--
--
DROP TABLE IF EXISTS `role_melee_info`;
CREATE TABLE `role_melee_info` (
	`id` bigint(20) unsigned NOT NULL COMMENT '���ID',
	`status` tinyint(1) unsigned NOT NULL COMMENT '��һ״̬ (0δ���� 1�ѱ��� 2���ύ���)',
	`ball_num` int(11) unsigned NOT NULL COMMENT '�����������',
	`scene_no` int(11) unsigned NOT NULL COMMENT '��ҷ���ĳ������',
	`create_time` int(11) unsigned NOT NULL COMMENT '����ʱ��',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ů���Ҷ� �������';
-- --------------------------------------------------------
