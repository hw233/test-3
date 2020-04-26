%%%------------------------------------------------
%%% File    : arena.hrl
%%% Author  : huangjf
%%% Created : 2012.1.15
%%% Description: 竞技场相关的宏
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__ARENA_H__).
-define(__ARENA_H__, 0).

				  
%% 玩家的竞技场数据
-record(arena, {
			id = 0,  							% 玩家id
			name = [],							% 玩家名字
			lv = 0,								% 玩家等级
			sex = 0,							% 玩家性别，1：男，2：女
			career = 0,							% 玩家职业
			guild_name = <<"">>,                % 帮派名字
			vip = 0,                            % vip等级
			battle_capacity = 0,  				% 战斗力
  			acc_points = 0, 					% 竞技场的积分
  			grade = 0,      					% 等级段
  			rank = 0,         					% 排名
  			title = <<"">>,        				% 称号
  			cur_opponent_list = [],				% 当前对手的id列表（[Id1, Id2, ...]）
  			
  			%%can_chal_times = 0, 				% 当天剩余可挑战次数
  			already_chal_times = 0, 			% 当天已挑战的次数
  			
  			can_refresh_oppo_times = 0,		 	% 当天剩余可刷新对手列表次数
  	    	winning_streak = 0, 				% 连胜次数
  			battle_history = [],  				% 最近战报记录，暂时最多存最近的5个
  			can_worship_arena_king = 0,  		% 是否可以膜拜战天王，1：是，0：否
  			can_admire_arena_king = 0,   		% 是否可以钦佩战天王，1：是，0：否
  			next_can_chal_time = 0,  			% 下次可以挑战的时间点
  			equip_current = [0, 0, 0, 0], 		% 当前装备：[武器，衣服，翅膀，时装]
  			date = 0,							% 当前日期（用于辅助实现隔天重置可挑战次数和可刷新对手列表次数）
	  		is_locked = false      				% 是否处于竞技场战斗锁定状态（用于避免多个玩家同时挑战同一个对手）
  	}).
  	
  	
%% 竞技场战报记录
-record(ar_battle_history, {
  			is_passive = 0,      % 1: 我是被动接受挑战，0: 我是主动挑战对方
  			opponent_id = 0,     % 对手id  
  			opponent_name = [],  % 对手名字
  			win_or_lose = 0,     % 1: 我赢了， 0: 我输了
  			old_rank_then = 0,   % 当时原来的排名
  			new_rank_then = 0,   % 当时新的排名
  			occur_time = 0       % 战斗触发的时间点
  	}).
 
%% 竞技场商店的物品 	
-record(ar_shop_goods, {
			shop_type = 0,  				% 1 => 挑战赛商店，2 => 竞技赛商店（详见arena.hrl中的宏）
			goods_type_id = 0,  			% 物品编号
			price_type = ?MNY_T_INVALID,	% 价格类型（0：无效类型，表示不需要花费钱， 1：人民币，2：游戏币，3：战天币）
            price = 0, 						% 价格（如果不需要花费钱，则为0）
            init_bind_state = 0, 			% 物品的初始绑定状态
			cost_acc_points = 0,  			% 购买所需花费的积分（勇勋值）
			cost_battle_contrib = 0,  		% 购买所需花费的战功值
			need_gongxun = 0                % 购买所需的功勋值（只用作判定是否满足购买的条件，实际购买时并不会扣减玩家的功勋值）
		}).
  	


% 竞技场对玩家开放的最低需求等级， 目前是25级
-define(START_ARENA_NEED_LV,  25).

% 竞技场挑战的cd时间（单位：秒），现在暂定为10分钟
-define(ARENA_CHALLENGE_CD_TIME, 600).


% 玩家下线时，如果其竞技场排名在MAX_RANK_NEED_CACHE范围内，则服务端会继续缓存其竞技场的相关数据，
% 目前暂时定为3000
-define(MAX_RANK_NEED_CACHE, 3000).


% 对手列表最多显示5个对手
-define(MAX_OPPONENT_LIST_SIZE, 5).

% 最多显示8条最近战报记录
-define(MAX_BATTLE_HISTORY_SHOWED, 8).

% 排行榜最多显示10页
-define(MAX_ARENA_RANKING_LIST_PAGE, 10).

% 排行榜每页最多显示10个玩家
-define(MAX_PLAYER_SHOWED_PER_PAGE, 10).


% 无效的竞技场排名
-define(AR_RANK_INVALID, 0).

% 购买抽取对手列表次数所需的元宝数
-define(BUY_REFRESH_OPPO_LIST_TIMES_NEED_MONEY, 10).



% 每天可以挑战的次数
-define(TIMES_CAN_CHAL_ONE_DAY, 15).

% 每天可以刷新对手列表的次数
-define(TIMES_CAN_REFRESH_OPPO_LIST_ONE_DAY, 10).




% 竞技场等级段
-define(AR_GRADE_GREEN,  1).   % 绿带
-define(AR_GRADE_BLUE,   2).   % 蓝带
-define(AR_GRADE_PURPLE, 3).   % 紫带
-define(AR_GRADE_ORANGE, 4).   % 橙带
-define(AR_GRADE_YELLOW, 5).   % 黄带
-define(AR_GRADE_MAX,    5).   % 等级段最大有效值（用于程序做判定）



-define(WORSHIP_ARENA_KING, 1).  % 膜拜战天王
-define(ADMIRE_ARENA_KING,  2).  % 钦佩战天王


% 竞技场商店类型
-define(AR_SHOP_T_CHALLENGE, 1).	% 挑战赛商店
-define(AR_SHOP_T_ONLINE_COMPETE, 2).	% 竞技赛商店(rename to: AR_SHOP_T_ONLINE_PK??)


% 客户端每页显示竞技场商店物品的数量
-define(AR_SHOP_GOODS_COUNT_PER_PAGE, 9). 

% 每次购买藏宝阁限量物品的最大数量
-define(AR_MAX_BUY_COUNT_EACH_TIME, 99).



















-endif.  %% __ARENA_H__
