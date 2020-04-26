%%%------------------------------------------------
%%% File    : home.hrl
%%% Author  : zhengjy
%%% Created : 2018-05-17
%%% Description: 家园系统的相关宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__HOME_H__).
-define(__HOME_H__, 0).
-include("sys_code.hrl").
%% 帮派职位（pos： 表示position ）
-define(HOME_DATA_TYPE_HOME,		0).        % 家园数据类型--家园
-define(HOME_DATA_TYPE_LAND,		1).        % 家园数据类型--土地
-define(HOME_DATA_TYPE_DAN,     	2).        % 家园数据类型--炼丹炉
-define(HOME_DATA_TYPE_MINE,       	3).        % 家园数据类型--矿井


-define(HOME_DATA_STATE_SEED,		1).			% 状态--幼苗期
-define(HOME_DATA_STATE_GROW,		2).			% 状态--成长期
-define(HOME_DATA_STATE_RIPE,		3).			% 状态--成熟期
-define(HOME_DATA_STATE_DIE,		4).			% 状态--枯萎期

-define(HOME_STEAL_SYSCODE, ?SYS_HOME).         % 家园系统代号


-record(home_id,		{
					 player_id = 0,
					 id = 0,                  %用于判断是否为自己的家园，方便偷菜
                     type = 0,
					 no = 0,                  %type和no是用于保存获取的哪个物品，用于战斗结束后使用
                     battle_result=0          %战斗的结果 0表示战斗失败，1表示战斗成功， 10表示无需进入战斗 
					}).


-record(home,		{
					 id = 0,
					 degree = 0,
					 lv_home = 1,
					 lv_land = 1,
					 lv_dan = 1,
					 lv_mine = 1,
					 achievement_value = [],
					 achievement_reward_nos = [],
					 create_time = 0,
					 scene_id = 0		%% 家园场景ID，动态创建回收，进入之前先判断是否存在，不存在则创建
                     
					}).

-define(HOME_DB_FIELD_ESCAPE,	[achievement_value, achievement_reward_nos]).

-define(HOME_POS_FIELD_LIST,	[
								 {#home.degree, degree},
								 {#home.lv_home, lv_home},
								 {#home.lv_land, lv_land},
								 {#home.lv_dan, lv_dan},
								 {#home.lv_mine, lv_mine},
								 {#home.achievement_value, achievement_value},
								 {#home.achievement_reward_nos, achievement_reward_nos},
								 {#home.create_time, create_time},
								 {#home.scene_id, scene_id}
								 ]).

-record(home_data,		{
						 key,
						 id = 0,
						 type = 0,
						 no = 0,
						 goods_no = 0,
						 partner_id = 0,
						 start_time = 0,
						 count_action_speedup = 0,
						 count_action_multi = 0,
						 count_action_lvlup = 0,
						 time_speedup = 0,
						 reward_multi = 0,
						 reward_lvlup = 0,
						 is_refresh_mon = 0,
						 is_mon_steal = 0,
						 is_steal = 0,
						 create_time = 0
						 }).

-define(HOME_DATA_POS_FIELD_LIST,	[
									 {#home_data.goods_no, goods_no},
									 {#home_data.partner_id, partner_id},
									 {#home_data.start_time, start_time},
									 {#home_data.count_action_speedup, count_action_speedup},
									 {#home_data.count_action_multi, count_action_multi},
									 {#home_data.count_action_lvlup, count_action_lvlup},
									 {#home_data.time_speedup, time_speedup},
									 {#home_data.reward_multi, reward_multi},
									 {#home_data.reward_lvlup, reward_lvlup},
									 {#home_data.create_time, create_time},
									 {#home_data.is_steal, is_steal},
									 {#home_data.is_mon_steal, is_mon_steal}
							 		]).

-record(home_achievement,	{
							 no = 1,
							 achievement = <<"家园升到高级">>,
							 type = 1,
							 num = 1,
							 partner_id = 0,
							 reward = 30,
                             goods =0
							}).

-record(home_dan,		{
						 no = 2,
						 lv = 2,
						 home_lv_limit = 1,
						 upgrade_money = {2, 100},
						 lattice_num = 2,
						 pellet = {50366,50038},
						 force_time = {0,30,60,120},
						 force_proba = {70,60,20,5},
						 inject_effect = {0,5,10,20},
						 inject_effect_proba = {70,60,20,5}
						}).


-record(home_land,		{
						 no = 2,
						 lv = 2,
						 home_lv_limit = 1,
						 upgrade_money = {2, 100},
						 lattice_num = 2,
						 herb = {62385,62386},
						 advance_time = {0,30,60,120},
						 advance_proba = {70,60,20,5},
						 insecticide_effect = {0,5,10,20},
						 insecticide_effect_proba = {70,60,20,5},
						 reward_upgrade_proba = {70,60,20,5}
						}).

-record(home_mine,		{
						 no = 1,
						 lv = 1,
						 home_lv_limit = 1,
						 upgrade_money = {2, 0},
						 lattice_num = 1,
						 mineral = {62397},
						 charge_time = {0,30,60,120},
						 charge_proba = {70,60,20,5},
						 strengthen_effect = {0,5,10,20},
						 strengthen_effect_proba = {70,60,20,5}
						}).

-record(home_production,	{
							 no = 62413,
							 type = 1,
							 cost = {62419,3},
							 production_num = 15,
							 seedling = 1,
							 growth = 5,
							 maturity = 2,
							 withering = 9999,
							 reward_upgrade = {62413,62435,62436,62437},
							 reward_broadcast = 365,
							 mon_broadcast = 368,
							 mon = 35163,
							 mon_proba = 50,
							 mon_xy = [{21,82},{18,77},{19,72},{26,70},{34,68}]
							}).


-record(home_splendid,	{
						 no = 1,
						 name = <<"生态宜居">>,
						 home_luxury = 50,
						 broadcast = [],
						 reward = 0
						}).

-record(home_config,	{
						 no = 1,
						 lv = 1,
						 lv_limit = 50,
						 upgrade_money = {2, 1000},
						 home_xy = {53, 38},
						 land_xy = {20, 37},
						 alchemy_furnace_xy = {40, 45},
						 mine_xy = {55, 20},
						 luxury = 50
						}).

-define(PROC_KEY_HOME_DATA,		proc_home_data).

%% 家园成就条件类型定义
-define(HOME_ACHIEVEMENT_TYPE_LV_HOME,				1).		%% 家园条件类型--家园等级
-define(HOME_ACHIEVEMENT_TYPE_LV_LAND,				2).		%% 家园条件类型--土地等级
-define(HOME_ACHIEVEMENT_TYPE_LV_DAN,				3).		%% 家园条件类型--炼丹炉等级
-define(HOME_ACHIEVEMENT_TYPE_LV_MINE,				4).		%% 家园条件类型--矿井等级
-define(HOME_ACHIEVEMENT_TYPE_COUNT_REWARD_LAND,	5).		%% 家园条件类型--土地收获次数
-define(HOME_ACHIEVEMENT_TYPE_COUNT_REWARD_DAN,		6).		%% 家园条件类型--炼丹炉收获次数
-define(HOME_ACHIEVEMENT_TYPE_COUNT_REWARD_MINE,	7).		%% 家园条件类型--矿井收获次数
-define(HOME_ACHIEVEMENT_TYPE_EMPLOY_PARTNER_COUNT1,8).		%% 家园条件类型--雇佣青龙、朱雀或麒麟门客种植收获次数
-define(HOME_ACHIEVEMENT_TYPE_EMPLOY_PARTNER_COUNT2,9).		%% 家园条件类型--雇佣元始天尊、月姬或麒麟门客种植收获次数

-define(HOME_ACHIEVEMENT_TYPE_EMPLOY_PARTNER_COUNT3,10).    %% 家园条件类型--雇佣修罗武神、神荼鬼帝采矿收获100次
-define(HOME_ACHIEVEMENT_TYPE_DEGREE,               11).	%% 家园条件类型--家园豪华度达到5000






-endif.  %% __HOME_H__