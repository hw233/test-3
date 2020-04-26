%%%------------------------------------------------
 %%% File    : guild_dungeon.hrl
%%% Author  : wujc
%%% Created : 2018-08-21
%%% Description: 帮派副本的相关宏定义
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__GUILD_DUNGEON_H__).
-define(__GUILD_DUNGEON__, 0).



-define(GUILD_NEW_DUNGEON_OPEN_LV, 45).


-record(guild_dungeon_point, {
							  guild_week = 0 ,
							  guild_scene_id =0 , 
							  week_point = 0,  %第几关卡
							  progress = 0,    %关卡进度
							  guild_id = 0,    %帮派Id
							  collection = 0,  %采集数
							  kill_count = 0 , %击杀数
							  boss_hp = 0,%最终boss剩余的血量
                              rank = []       % [{key,username,value}]		key = {playerid, type}		 
							  }).

-record(guild_person, {
					   player_id = 0,
					   guild_id = 0 , %帮派id
					   get_progress = [],%已经领取的关卡进步奖励[{1,1,2,3,5},{2,5,1,3}···]
					   contribution = [], %贡献值
					   get_award = 0, %是否已经领取通关大奖
					   collection = 0,  %采集数
					   kill_count = 0 , %击杀数
					   damage_value = 0, %对boss造成的伤害血量
                       doing_point = 0   % 当前进入的关卡
					   
					   }).



-define(GUILD_DUNGEON_POS_FIELD_LIST,	[
										 {#guild_dungeon_point.guild_week, guild_week},
										 {#guild_dungeon_point.week_point, week_point},
										 {#guild_dungeon_point.progress, progress},
										 {#guild_dungeon_point.guild_id, guild_id},
										 {#guild_dungeon_point.collection, collection},
										 {#guild_dungeon_point.kill_count, kill_count},
										 {#guild_dungeon_point.boss_hp, boss_hp},
										 {#guild_dungeon_point.rank, rank}
										]).





-define(PERSON_DATA_POS_FIELD_LIST,	[
										 {#guild_person.player_id, player_id},
										 {#guild_person.guild_id, guild_id},
										 {#guild_person.get_progress, get_progress},
										 {#guild_person.contribution, contribution},
										 {#guild_person.get_award, get_award},
										 {#guild_person.collection, collection},
										 {#guild_person.kill_count, kill_count},
										 {#guild_person.damage_value, damage_value}
										]).

-define(PERSON_TERM_POS_FIELD_LIST, [get_progress, contribution]).


-record(guild_new_dungeon, {
							no = 0,
							map_no = 0,
							dungeon_no = 0,
							lv = 0,
							price_cost = {},
							reward = [],
							total_reward = 0,
							condition = [],
							boss_hp = 0,
							target = [],
							position = [],
							boss_position = 0,
							collect_num = 0,
						    drop_num = 0,
						    kill_num = 0					} ).

-record(guild_dungeon_rank_reward, {
									group = 0,
									begin_ranking =0,
									end_ranking = 0,
									reward = 0
								   }).


-endif.  %% 
