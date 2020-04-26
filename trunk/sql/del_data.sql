-- 永久清理流失玩家数据
-- 1，等级<50级
-- 2，角色未充过值
-- 3，合服当天算起，18天内未登陆过
-- 4，未结婚、未结拜
-- 以上条件全部符合的号才删除
-- 注意：玩家表必须最后删除

use simserver;

-- 删除宠物数据
DELETE FROM `partner` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0 AND `partner`.player_id = p.id);

-- 删除物品数据
DELETE FROM `goods` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0 AND `goods`.player_id = p.id);

-- 删除邮件数据
DELETE FROM `mail` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0 AND `mail`.recv_id = p.id);

-- 删除关系数据
DELETE FROM `relation` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0 AND `relation`.idA = p.id) OR ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0  AND `relation`.idB = p.id);

-- 删除成就相关数据记录
DELETE FROM `achievement_data` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0  AND `achievement_data`.role_id = p.id);

-- 删除系统活跃度信息
DELETE FROM `activity_degree` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0 AND `activity_degree`.id = p.id);


-- 删除玩家的章节目标数据信息
DELETE FROM `chapter_target_info` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0 AND `chapter_target_info`.role_id = p.id);

-- 删除玩家每日签到与在线奖励
DELETE FROM `day_reward` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0 AND `day_reward`.player_id = p.id);

-- 删除玩家角色副本CD记录
DELETE FROM `dungeon_cd` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0 AND `dungeon_cd`.role_id = p.id);

-- 删除角色副本通关记录
DELETE FROM `role_dungeon` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0 AND `role_dungeon`.role_id = p.id);


-- 删除任务表
DELETE FROM `task_bag` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0 AND `task_bag`.role_id = p.id);

-- 删除任务完成表
DELETE FROM `task_completed` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0  AND `task_completed`.role_id = p.id);


-- 删除任务环记录
DELETE FROM `task_ring` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0  AND `task_ring`.role_id = p.id);

-- 删除商会数据
DELETE FROM `business` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0  AND `business`.id = p.id);

-- 删除玩家拓展数据
DELETE FROM `player_ext` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0  AND `player_ext`.player_id = p.id);

-- 删除玩家坐骑数据
DELETE FROM `mount` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0  AND `mount`.player_id = p.id);

-- 删除玩家心法数据
DELETE FROM `xinfa` WHERE ExistS (SELECT p.id FROM `player` p, `relation_info` r
WHERE p.lv < 50 AND p.yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(p.last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND p.id = r.id AND r.sworn_id <= 0 AND r.spouse_id <= 0  AND `xinfa`.player_id = p.id);

-- 最后删除玩家数据
DELETE FROM `player`
WHERE lv < 50 AND yuanbao_acc <= 0
AND DATEDIFF(now(), FROM_UNIXTIME(last_logout_time,'%Y-%m-%d %H:%i:%S')) > 18 
AND id in (SELECT id FROM relation_info WHERE sworn_id <= 0 AND spouse_id <= 0);