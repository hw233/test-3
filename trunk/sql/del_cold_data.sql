
-- 删除游戏数据库中的冷数据，冷数据是指已流失玩家的相关数据
-- 目前已流失玩家的定义是：
-- 1，等级≤30级
-- 2，角色未充过值
-- 3，合服当天算起，30天内未登陆过
-- 4，未结婚、未结拜


-- 注意事项：
-- 1,数据库服务器时间是正确的；
-- 2,玩家表必须最后删除;
-- 3,同一条语句不能使用两次临时表;

-- 创建并向临时表入数据 (不是 TEMPORARY TABLE，经过测试mysql5.6可以建立TEMPORARY TABLE，但查询时找不到临时表)
CREATE TABLE `tmp_ids` (`id` bigint(18) unsigned NOT NULL DEFAULT '0' COMMENT 'id', PRIMARY KEY(`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='临时玩家id'
SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0;

-- 删除宠物数据
DELETE FROM `partner` WHERE player_id in (SELECT * FROM `tmp_ids`);

-- 删除物品数据
DELETE FROM `goods` WHERE player_id in (SELECT * FROM `tmp_ids`);

-- 删除邮件数据
DELETE FROM `mail` WHERE recv_id in (SELECT * FROM `tmp_ids`);

-- 删除关系数据
DELETE FROM `relation` WHERE idA in (SELECT * FROM `tmp_ids`) OR idB in (SELECT * FROM `tmp_ids`);

-- 删除成就相关数据记录
DELETE FROM `achievement_data` WHERE role_id in (SELECT * FROM `tmp_ids`);

-- 删除系统活跃度信息
DELETE FROM `activity_degree` WHERE id in (SELECT * FROM `tmp_ids`);

-- 删除玩家的章节目标数据信息
DELETE FROM `chapter_target_info` WHERE role_id in (SELECT * FROM `tmp_ids`);

-- 删除玩家每日签到与在线奖励
DELETE FROM `day_reward` WHERE player_id in (SELECT * FROM `tmp_ids`);

-- 删除玩家角色副本CD记录
DELETE FROM `dungeon_cd` WHERE role_id in (SELECT * FROM `tmp_ids`);

-- 删除角色副本通关记录
DELETE FROM `role_dungeon` WHERE role_id in (SELECT * FROM `tmp_ids`);

-- 删除任务表
DELETE FROM `task_bag` WHERE role_id in (SELECT * FROM `tmp_ids`);

-- 删除任务完成表
DELETE FROM `task_completed` WHERE role_id in (SELECT * FROM `tmp_ids`);

-- 删除任务环记录
DELETE FROM `task_ring` WHERE role_id in (SELECT * FROM `tmp_ids`);

---------------------------------添加
-- 删除商会数据
DELETE FROM `business` WHERE id in (SELECT * FROM `tmp_ids`);
-- 删除玩家拓展数据
DELETE FROM `player_ext` WHERE player_id in (SELECT * FROM `tmp_ids`);
-- 删除玩家坐骑数据
DELETE FROM `mount` WHERE player_id in (SELECT * FROM `tmp_ids`);
-- 删除玩家心法数据
DELETE FROM `xinfa` WHERE player_id in (SELECT * FROM `tmp_ids`);

-- 最后删除玩家表数据
DELETE FROM `player` WHERE id in (SELECT * FROM `tmp_ids`);

DROP TABLE IF EXISTS `tmp_ids`;