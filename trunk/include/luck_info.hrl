-ifndef(__LUCK_INFO_HRL__).
-define(__LUCK_INFO_HRL__, luck_info_hrl).
 
%% ets_desire_integral_pool
%% ets_luck_player_info
%% ets_lottery_record 


-record(luck_player_info, {
     player_id = 0
    ,treasure_value = 0
    ,desire_value = 0
    ,treasure_weekly_value = 0
	,have_treasure_weekly = []
	,have_desire = []
    }).


-record(rich_map_record,{
	player_id = 0
	,is_use = 1,
	position = 0,
	is_get = 0,
	table = []
}).

%%			 name          string  	玩家名字
%%			 goods_no	   u32   	道具编号	
%%			 amount		   u32		道具数量
-record(ets_lottery_history, {
						  type = 1,
						  lottery_history = [] 
						   }).


-record(xunbao_xuyuanchi_cost, {
								no = 0,
								type = 0,
								num = 0,
								draw_cost = {}
							   }).

-record(xunbao_xuyuanchi_draw, {
								no = 0,
								type = 0,
								prob = 0,
								goods_type = 0,
								reward = [],
								notice = 0
							   }).

-record(xunbao_extra_reward, {
							  no = 0,
							  num = 0,
							  reward = 0
							 }).

-record(xuyuanchi_extra_reward, {
							  no = 0,
							  xuyuan_num = 5000,
							  reward = []
							 }).

   

-endif.