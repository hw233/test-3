%%%------------------------------------------------
%%% File    : inventory.hrl
%%% Author  : huangjf
%%% Created : 2013.5.14
%%% Description: 玩家物品栏的相关宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__INVENTORY_H__).
-define(__INVENTORY_H__, 0).


%% 玩家的物品栏
-record(inv, {
			player_id = 0,        		% 玩家id，表示是哪个玩家的物品栏

			%%is_locked = false,       	% 物品栏是否被锁定了（true：是，false：否）  --- 暂时没用

			bag_eq_capacity = 0,       	% 当前的装备背包容量
			bag_usable_capacity = 0,	% 非装备中可用物品背包容量
			bag_unusable_capacity = 0,	% 非装备中不可用物品背包容量

			storage_capacity = 0,   	% 当前的仓库容量

			eq_goods = null,   		    % 装备背包里的物品唯一id列表， 形如：null（表示未初始化，下同） | [] （表示没有物品， 下同） | goods唯一id列表
			usable_goods = null,   		% 非装备可用物品背包里的物品唯一id列表， 形如：null（表示未初始化，下同） | [] （表示没有物品， 下同） | goods唯一id列表
			unusable_goods = null,      % 非装备不可用物品背包里的物品唯一id列表， 形如：null（表示未初始化，下同） | [] （表示没有物品， 下同） | goods唯一id列表

			storage_goods = null, 		% 仓库里的物品唯一id列表， 形如：null | [] | goods唯一id列表
										% 注意：玩家上线时，不立即从数据库加载仓库物品，而是按需动态加载（比如在玩家第一次打开仓库时才加载

			player_eq_goods = null, 	% 玩家自身已装备的物品唯一id列表，  形如：null | [] | goods唯一id列表
			partner_eq_goods = null,  	% 玩家的宠物已装备的物品唯一id列表， 形如：null | [] | goods唯一id列表
			temp_reset_goods = [],			% 领取道具列表
			temp_bag_goods = [] 		% 临时背包，存放 物品唯一id列表 不存盘 下线后最多缓存5分钟，与玩家数据缓存时间一致
	}).


%% 默认背包和仓库容量（玩家最初所拥有的容量）
-define(DEF_BAG_EQ_CAPACITY, 200).
-define(DEF_BAG_USABLE_CAPACITY, 200).
-define(DEF_BAG_UNUSABLE_CAPACITY, 200).
-define(DEF_STORAGE_CAPACITY, 300).

-define(MAX_BAG_EQ_CAPACITY, 200).      	    %% 背包的最大容量（扩展背包时不能超过该上限）
-define(MAX_BAG_USABLE_CAPACITY, 200).		%%
-define(MAX_BAG_UNUSABLE_CAPACITY, 200).		%%
-define(MAX_STORAGE_CAPACITY, (100*3)). 	    %% 仓库的最大容量（扩展仓库时不能超过该上限）

-define(MAX_PLAYER_EQUIP_COUNT,  12).   % 玩家穿戴装备最大数量
-define(MAX_PARTNER_EQUIP_COUNT, 8).    % 武将穿戴装备最大数量

-define(MAX_TEMPORARY_BAG_CAPACITY, 9).	% 临时背包最大容量

-endif.  %% __INVENTORY_H__
