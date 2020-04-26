-- 永久清理流失玩家数据
-- 1，等级≤30级
-- 2，角色未充过值
-- 3，合服当天算起，30天内未登陆过
-- 4，未结婚、未结拜
-- 以上条件全部符合的号才删除
-- 注意：玩家表必须最后删除


-- 删除宠物数据
DELETE FROM `partner` WHERE player_id in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);

-- 删除物品数据
DELETE FROM `goods` WHERE player_id in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);

-- 删除邮件数据
DELETE FROM `mail` WHERE recv_id in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);

-- 删除关系数据
DELETE FROM `relation` WHERE idA in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0) OR idB in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);

-- 删除成就相关数据记录
DELETE FROM `achievement_data` WHERE role_id in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);

-- 删除系统活跃度信息
DELETE FROM `activity_degree` WHERE id in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);


-- 删除玩家的章节目标数据信息
DELETE FROM `chapter_target_info` WHERE role_id in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);

-- 删除玩家每日签到与在线奖励
DELETE FROM `day_reward` WHERE player_id in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);

-- 删除玩家角色副本CD记录
DELETE FROM `dungeon_cd` WHERE role_id in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);

-- 删除角色副本通关记录
DELETE FROM `role_dungeon` WHERE role_id in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);


-- 删除任务表
DELETE FROM `task_bag` WHERE role_id in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);

-- 删除任务完成表
DELETE FROM `task_completed` WHERE role_id in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);


-- 删除任务环记录
DELETE FROM `task_ring` WHERE role_id in (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv <= 30 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0);

-- 最后删除玩家数据
DELETE FROM `player`
WHERE lv <= 30 AND yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(last_logout_time,'%Y-%m-%d %H:%i:%S')) > 30 
AND id in (SELECT id FROM relation_info WHERE sworn_id <= 0 AND spouse_id <= 0);