%%%------------------------------------------------
%%% File    : ets_name.hrl
%%% Author  :
%%% Created : 2013.5.15
%%% Description: ets名字的相关宏
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__ETS_NAME_H__).
-define(__ETS_NAME_H__, 0).


%% 做映射：账户名 -> 账户下当前在线的角色。仅仅是为了方便通过账户名查找对应的在线角色（角色进入游戏的流程中用到）
-define(ETS_MAP_OF_ACCNAME_TO_ONLINE_PLAYER, ets_map_of_accname_to_online_player).

%% 删除角色的次数记录（仅用于辅助判断和避免同一账户的玩家频繁删角色）
-define(ETS_DISCARD_ROLE_TIMES, ets_discard_role_times).


%% 开多少个ets去存在线玩家数据（目前开128个）
-define(ETS_ONLINE_COUNT, 128).             % 注意：如果修改，记得对应调整player:my_ets_online()函数！！
% -define(HALF_ETS_ONLINE_COUNT, 64).
% -define(ONE_QUARTER_ETS_ONLINE_COUNT, 32).
% -define(THREE_QUARTER_ETS_ONLINE_COUNT, 96).
% -define(ONE_EIGHTH_ETS_ONLINE_COUNT, 16).
% -define(THREE_EIGHTH_ETS_ONLINE_COUNT, 48).


%% 获取玩家对应的在线玩家结构体ets表
-define(MY_ETS_ONLINE(PlayerId_or_PS), player:my_ets_online(PlayerId_or_PS)).

%% 在线玩家结构体表
-define(ETS_ONLINE_1,  ets_online_1).   % 在线玩家结构体表1
-define(ETS_ONLINE_2,  ets_online_2).   % 在线玩家结构体表2
-define(ETS_ONLINE_3,  ets_online_3).   % 在线玩家结构体表3
-define(ETS_ONLINE_4,  ets_online_4).   % ...
-define(ETS_ONLINE_5,  ets_online_5).
-define(ETS_ONLINE_6,  ets_online_6).
-define(ETS_ONLINE_7,  ets_online_7).
-define(ETS_ONLINE_8,  ets_online_8).
-define(ETS_ONLINE_9,  ets_online_9).
-define(ETS_ONLINE_10, ets_online_10).
-define(ETS_ONLINE_11, ets_online_11).
-define(ETS_ONLINE_12, ets_online_12).
-define(ETS_ONLINE_13, ets_online_13).
-define(ETS_ONLINE_14, ets_online_14).
-define(ETS_ONLINE_15, ets_online_15).
-define(ETS_ONLINE_16, ets_online_16).
-define(ETS_ONLINE_17, ets_online_17).
-define(ETS_ONLINE_18, ets_online_18).
-define(ETS_ONLINE_19, ets_online_19).
-define(ETS_ONLINE_20, ets_online_20).
-define(ETS_ONLINE_21, ets_online_21).
-define(ETS_ONLINE_22, ets_online_22).
-define(ETS_ONLINE_23, ets_online_23).
-define(ETS_ONLINE_24, ets_online_24).
-define(ETS_ONLINE_25, ets_online_25).
-define(ETS_ONLINE_26, ets_online_26).
-define(ETS_ONLINE_27, ets_online_27).
-define(ETS_ONLINE_28, ets_online_28).
-define(ETS_ONLINE_29, ets_online_29).
-define(ETS_ONLINE_30, ets_online_30).
-define(ETS_ONLINE_31, ets_online_31).
-define(ETS_ONLINE_32, ets_online_32).
-define(ETS_ONLINE_33, ets_online_33).
-define(ETS_ONLINE_34, ets_online_34).
-define(ETS_ONLINE_35, ets_online_35).
-define(ETS_ONLINE_36, ets_online_36).
-define(ETS_ONLINE_37, ets_online_37).
-define(ETS_ONLINE_38, ets_online_38).
-define(ETS_ONLINE_39, ets_online_39).
-define(ETS_ONLINE_40, ets_online_40).
-define(ETS_ONLINE_41, ets_online_41).
-define(ETS_ONLINE_42, ets_online_42).
-define(ETS_ONLINE_43, ets_online_43).
-define(ETS_ONLINE_44, ets_online_44).
-define(ETS_ONLINE_45, ets_online_45).
-define(ETS_ONLINE_46, ets_online_46).
-define(ETS_ONLINE_47, ets_online_47).
-define(ETS_ONLINE_48, ets_online_48).
-define(ETS_ONLINE_49, ets_online_49).
-define(ETS_ONLINE_50, ets_online_50).
-define(ETS_ONLINE_51, ets_online_51).
-define(ETS_ONLINE_52, ets_online_52).
-define(ETS_ONLINE_53, ets_online_53).
-define(ETS_ONLINE_54, ets_online_54).
-define(ETS_ONLINE_55, ets_online_55).
-define(ETS_ONLINE_56, ets_online_56).
-define(ETS_ONLINE_57, ets_online_57).
-define(ETS_ONLINE_58, ets_online_58).
-define(ETS_ONLINE_59, ets_online_59).
-define(ETS_ONLINE_60, ets_online_60).
-define(ETS_ONLINE_61, ets_online_61).
-define(ETS_ONLINE_62, ets_online_62).
-define(ETS_ONLINE_63, ets_online_63).
-define(ETS_ONLINE_64, ets_online_64).
-define(ETS_ONLINE_65, ets_online_65).
-define(ETS_ONLINE_66, ets_online_66).
-define(ETS_ONLINE_67, ets_online_67).
-define(ETS_ONLINE_68, ets_online_68).
-define(ETS_ONLINE_69, ets_online_69).
-define(ETS_ONLINE_70, ets_online_70).
-define(ETS_ONLINE_71, ets_online_71).
-define(ETS_ONLINE_72, ets_online_72).
-define(ETS_ONLINE_73, ets_online_73).
-define(ETS_ONLINE_74, ets_online_74).
-define(ETS_ONLINE_75, ets_online_75).
-define(ETS_ONLINE_76, ets_online_76).
-define(ETS_ONLINE_77, ets_online_77).
-define(ETS_ONLINE_78, ets_online_78).
-define(ETS_ONLINE_79, ets_online_79).
-define(ETS_ONLINE_80, ets_online_80).
-define(ETS_ONLINE_81, ets_online_81).
-define(ETS_ONLINE_82, ets_online_82).
-define(ETS_ONLINE_83, ets_online_83).
-define(ETS_ONLINE_84, ets_online_84).
-define(ETS_ONLINE_85, ets_online_85).
-define(ETS_ONLINE_86, ets_online_86).
-define(ETS_ONLINE_87, ets_online_87).
-define(ETS_ONLINE_88, ets_online_88).
-define(ETS_ONLINE_89, ets_online_89).
-define(ETS_ONLINE_90, ets_online_90).
-define(ETS_ONLINE_91, ets_online_91).
-define(ETS_ONLINE_92, ets_online_92).
-define(ETS_ONLINE_93, ets_online_93).
-define(ETS_ONLINE_94, ets_online_94).
-define(ETS_ONLINE_95, ets_online_95).
-define(ETS_ONLINE_96, ets_online_96).
-define(ETS_ONLINE_97, ets_online_97).
-define(ETS_ONLINE_98, ets_online_98).
-define(ETS_ONLINE_99, ets_online_99).
-define(ETS_ONLINE_100, ets_online_100).
-define(ETS_ONLINE_101, ets_online_101).
-define(ETS_ONLINE_102, ets_online_102).
-define(ETS_ONLINE_103, ets_online_103).
-define(ETS_ONLINE_104, ets_online_104).
-define(ETS_ONLINE_105, ets_online_105).
-define(ETS_ONLINE_106, ets_online_106).
-define(ETS_ONLINE_107, ets_online_107).
-define(ETS_ONLINE_108, ets_online_108).
-define(ETS_ONLINE_109, ets_online_109).
-define(ETS_ONLINE_110, ets_online_110).
-define(ETS_ONLINE_111, ets_online_111).
-define(ETS_ONLINE_112, ets_online_112).
-define(ETS_ONLINE_113, ets_online_113).
-define(ETS_ONLINE_114, ets_online_114).
-define(ETS_ONLINE_115, ets_online_115).
-define(ETS_ONLINE_116, ets_online_116).
-define(ETS_ONLINE_117, ets_online_117).
-define(ETS_ONLINE_118, ets_online_118).
-define(ETS_ONLINE_119, ets_online_119).
-define(ETS_ONLINE_120, ets_online_120).
-define(ETS_ONLINE_121, ets_online_121).
-define(ETS_ONLINE_122, ets_online_122).
-define(ETS_ONLINE_123, ets_online_123).
-define(ETS_ONLINE_124, ets_online_124).
-define(ETS_ONLINE_125, ets_online_125).
-define(ETS_ONLINE_126, ets_online_126).
-define(ETS_ONLINE_127, ets_online_127).
-define(ETS_ONLINE_128, ets_online_128).


%% 临时退出的玩家结构体表
-define(ETS_TMPLOGOUT_PLAYER_STATUS, ets_tmplogout_player_status).


%% 在线玩家的简要信息表
%% 注意：这是一个存轻量数据项的ets，仅仅用于方便通过玩家id快速得到玩家对应的进程pid、sendpid、socket、在线标记，以及做统计（如在线人数统计），不做他用!!!!!
-define(ETS_ONLINE_PLAYER_BRIEF, ets_online_player_brief).

%% 临时退出的玩家的简要信息表（tmplogout: temporary logout）
-define(ETS_TMPLOGOUT_PLAYER_BRIEF, ets_tmplogout_player_brief).




%% 离线bo(battle obj)表，目前是用于辅助实现离线战斗的功能
-define(ETS_OFFLINE_BO, ets_offline_bo).

%% 离线玩家简要信息表
-define(ETS_OFFLINE_ROLE_BRIEF, ets_offline_role_brief).


%% 玩家自身的已开放的系统列表
-define(ETS_PLAYER_OPENED_SYS, ets_player_opened_sys).



%% 门派的玩家列表（目前仅用于辅助实现门派聊天的功能）
-define(ETS_FACTION_PLAYER_LIST, ets_faction_player_list).




%% 开多少个ets去存玩家的具体位置（目前开64个）
-define(ETS_PLAYER_POSITION_COUNT, 64).      % 注意：如果修改，记得对应调整player:my_ets_player_position()函数！！
-define(HALF_ETS_PLAYER_POSITION_COUNT, 32).
-define(ONE_QUARTER_ETS_PLAYER_POSITION_COUNT, 16).
-define(THREE_QUARTER_ETS_PLAYER_POSITION_COUNT, 48).

%% 获取玩家对应的具体位置ets表名
-define(MY_ETS_PLAYER_POSITION(PlayerId), player:my_ets_player_position(PlayerId)).

%% 玩家的具体位置（元素为plyr_pos结构体，详见player.hrl）
-define(ETS_PLAYER_POSITION_1, ets_player_position_1).   % 玩家的具体位置表1
-define(ETS_PLAYER_POSITION_2, ets_player_position_2).   % 玩家的具体位置表2
-define(ETS_PLAYER_POSITION_3, ets_player_position_3).   % 玩家的具体位置表3
-define(ETS_PLAYER_POSITION_4, ets_player_position_4).   % ...
-define(ETS_PLAYER_POSITION_5, ets_player_position_5).
-define(ETS_PLAYER_POSITION_6, ets_player_position_6).
-define(ETS_PLAYER_POSITION_7, ets_player_position_7).
-define(ETS_PLAYER_POSITION_8, ets_player_position_8).
-define(ETS_PLAYER_POSITION_9, ets_player_position_9).
-define(ETS_PLAYER_POSITION_10, ets_player_position_10).
-define(ETS_PLAYER_POSITION_11, ets_player_position_11).
-define(ETS_PLAYER_POSITION_12, ets_player_position_12).
-define(ETS_PLAYER_POSITION_13, ets_player_position_13).
-define(ETS_PLAYER_POSITION_14, ets_player_position_14).
-define(ETS_PLAYER_POSITION_15, ets_player_position_15).
-define(ETS_PLAYER_POSITION_16, ets_player_position_16).
-define(ETS_PLAYER_POSITION_17, ets_player_position_17).
-define(ETS_PLAYER_POSITION_18, ets_player_position_18).
-define(ETS_PLAYER_POSITION_19, ets_player_position_19).
-define(ETS_PLAYER_POSITION_20, ets_player_position_20).
-define(ETS_PLAYER_POSITION_21, ets_player_position_21).
-define(ETS_PLAYER_POSITION_22, ets_player_position_22).
-define(ETS_PLAYER_POSITION_23, ets_player_position_23).
-define(ETS_PLAYER_POSITION_24, ets_player_position_24).
-define(ETS_PLAYER_POSITION_25, ets_player_position_25).
-define(ETS_PLAYER_POSITION_26, ets_player_position_26).
-define(ETS_PLAYER_POSITION_27, ets_player_position_27).
-define(ETS_PLAYER_POSITION_28, ets_player_position_28).
-define(ETS_PLAYER_POSITION_29, ets_player_position_29).
-define(ETS_PLAYER_POSITION_30, ets_player_position_30).
-define(ETS_PLAYER_POSITION_31, ets_player_position_31).
-define(ETS_PLAYER_POSITION_32, ets_player_position_32).
-define(ETS_PLAYER_POSITION_33, ets_player_position_33).
-define(ETS_PLAYER_POSITION_34, ets_player_position_34).
-define(ETS_PLAYER_POSITION_35, ets_player_position_35).
-define(ETS_PLAYER_POSITION_36, ets_player_position_36).
-define(ETS_PLAYER_POSITION_37, ets_player_position_37).
-define(ETS_PLAYER_POSITION_38, ets_player_position_38).
-define(ETS_PLAYER_POSITION_39, ets_player_position_39).
-define(ETS_PLAYER_POSITION_40, ets_player_position_40).
-define(ETS_PLAYER_POSITION_41, ets_player_position_41).
-define(ETS_PLAYER_POSITION_42, ets_player_position_42).
-define(ETS_PLAYER_POSITION_43, ets_player_position_43).
-define(ETS_PLAYER_POSITION_44, ets_player_position_44).
-define(ETS_PLAYER_POSITION_45, ets_player_position_45).
-define(ETS_PLAYER_POSITION_46, ets_player_position_46).
-define(ETS_PLAYER_POSITION_47, ets_player_position_47).
-define(ETS_PLAYER_POSITION_48, ets_player_position_48).
-define(ETS_PLAYER_POSITION_49, ets_player_position_49).
-define(ETS_PLAYER_POSITION_50, ets_player_position_50).
-define(ETS_PLAYER_POSITION_51, ets_player_position_51).
-define(ETS_PLAYER_POSITION_52, ets_player_position_52).
-define(ETS_PLAYER_POSITION_53, ets_player_position_53).
-define(ETS_PLAYER_POSITION_54, ets_player_position_54).
-define(ETS_PLAYER_POSITION_55, ets_player_position_55).
-define(ETS_PLAYER_POSITION_56, ets_player_position_56).
-define(ETS_PLAYER_POSITION_57, ets_player_position_57).
-define(ETS_PLAYER_POSITION_58, ets_player_position_58).
-define(ETS_PLAYER_POSITION_59, ets_player_position_59).
-define(ETS_PLAYER_POSITION_60, ets_player_position_60).
-define(ETS_PLAYER_POSITION_61, ets_player_position_61).
-define(ETS_PLAYER_POSITION_62, ets_player_position_62).
-define(ETS_PLAYER_POSITION_63, ets_player_position_63).
-define(ETS_PLAYER_POSITION_64, ets_player_position_64).



%% 玩家的心法信息
-define(ETS_PLAYER_XINFA, ets_player_xinfa).



%% 玩家的物品栏
-define(ETS_INVENTORY, ets_inventory).

%% 开多少个ets去存在线玩家物品（目前是开10个，而且认为应该足够了!）
-define(ETS_INV_GOODS_COUNT, 10).

-define(MY_ETS_INV_GOODS(GoodsId_or_Goods), lib_goods:my_ets_inv_goods(GoodsId_or_Goods)).

%% 2019.12.18 wjc这里没必要分成这么多ets表吧？　由于哈希表高效的特性，查找或者插入的情况在大多数情况下可以达到O(1)，
%% 时间主要花在计算hash上。
%% Insert and lookup times in
%%   tables of type set, bag,
%%     and duplicate_bag are constant, regardless of the table size.

%% 玩家物品表(存储元素为goods结构体)
-define(ETS_INV_GOODS_1, ets_inv_goods_1).		% 玩家物品表1
-define(ETS_INV_GOODS_2, ets_inv_goods_2).		% 玩家物品表2
-define(ETS_INV_GOODS_3, ets_inv_goods_3).		% 玩家物品表3
-define(ETS_INV_GOODS_4, ets_inv_goods_4).		% 玩家物品表4
-define(ETS_INV_GOODS_5, ets_inv_goods_5).		% 玩家物品表5
-define(ETS_INV_GOODS_6, ets_inv_goods_6).		% 玩家物品表6
-define(ETS_INV_GOODS_7, ets_inv_goods_7).		% 玩家物品表7
-define(ETS_INV_GOODS_8, ets_inv_goods_8).		% 玩家物品表8
-define(ETS_INV_GOODS_9, ets_inv_goods_9).		% 玩家物品表9
-define(ETS_INV_GOODS_10, ets_inv_goods_10).	% 玩家物品表10


%% 开8个ets保存家园基础数据
-define(ETS_HOME_COUNT,	8).
%% 家园基础数据ets表名字前缀
-define(ETS_HOME,	ets_home).

-define(ETS_HOME_LIST,		[
								 {1,		ets_home_1},	
								 {2,		ets_home_2},	
								 {3,		ets_home_3},	
								 {4,		ets_home_4},	
								 {5,		ets_home_5},	
								 {6,		ets_home_6},	
								 {7,		ets_home_7},	
								 {8,		ets_home_8}
								 ]).

%% 获取玩家家园对应的具体位置ets表名
-define(MY_ETS_HOME(Key), lib_home:my_ets_home(Key) ).

-define(ETS_HOME_ID, ets_homeid).

%% 开16个ets保存家园格子数据
-define(ETS_HOME_DATA_COUNT,	16).
%% 家园格子ets表名字前缀
-define(ETS_HOME_DATA,	ets_home_data).

-define(ETS_HOME_DATA_LIST,		[
								 {1,		ets_home_data_1},	
								 {2,		ets_home_data_2},	
								 {3,		ets_home_data_3},	
								 {4,		ets_home_data_4},	
								 {5,		ets_home_data_5},	
								 {6,		ets_home_data_6},	
								 {7,		ets_home_data_7},	
								 {8,		ets_home_data_8},	
								 {9,		ets_home_data_9},	
								 {10,		ets_home_data_10},	
								 {11,		ets_home_data_11},	
								 {12,		ets_home_data_12},	
								 {13,		ets_home_data_13},	
								 {14,		ets_home_data_14},	
								 {15,		ets_home_data_15},	
								 {16,		ets_home_data_16}
								 ]).

%% 获取玩家家园对应的具体位置ets表名
-define(MY_ETS_HOME_DATA(Key), lib_home:my_ets_home_data(Key) ).


%% 保存玩家家园场景对应数据
-define(ETS_HOME_SCENE,		ets_home_scene).

%% 保存帮派副本场景对应数据
-define(ETS_GUILD_DUNGEON_SCENE, ets_guild_dungeon_scene).


%% 记录场景内的玩家
-define(ETS_SCENE_PLAYERS, ets_scene_players).

%% 记录场景内的对象（怪物，npc，动态传送点）
-define(ETS_OBJS_OF_SCENE, ets_objs_of_scene).


%% 作废！！
% %% 开多少个ets去存场景格子（目前开32个）
% -define(ETS_SCENE_GRID_COUNT, 32).        % 注意：如果修改，记得对应调整lib_scene:decide_ets_scene_grid()函数！！
% -define(HALF_ETS_SCENE_GRID_COUNT, 16).
% -define(ONE_QUARTER_ETS_SCENE_GRID_COUNT, 8).
% -define(THREE_QUARTER_ETS_SCENE_GRID_COUNT, 24).

% %% 获取场景对应的场景格子ets表名
% -define(ETS_SCENE_GRID(SceneId), lib_scene:decide_ets_scene_grid(SceneId)).

% -define(ETS_SCENE_GRID_1, ets_scene_grid_1).		% 场景格子（场景划分九宫格后的其中一格）表1
% -define(ETS_SCENE_GRID_2, ets_scene_grid_2).		% 场景格子（场景划分九宫格后的其中一格）表2
% -define(ETS_SCENE_GRID_3, ets_scene_grid_3).		% 场景格子（场景划分九宫格后的其中一格）表3
% -define(ETS_SCENE_GRID_4, ets_scene_grid_4).		% ...
% -define(ETS_SCENE_GRID_5, ets_scene_grid_5).
% -define(ETS_SCENE_GRID_6, ets_scene_grid_6).
% -define(ETS_SCENE_GRID_7, ets_scene_grid_7).
% -define(ETS_SCENE_GRID_8, ets_scene_grid_8).
% -define(ETS_SCENE_GRID_9, ets_scene_grid_9).
% -define(ETS_SCENE_GRID_10, ets_scene_grid_10).
% -define(ETS_SCENE_GRID_11, ets_scene_grid_11).
% -define(ETS_SCENE_GRID_12, ets_scene_grid_12).
% -define(ETS_SCENE_GRID_13, ets_scene_grid_13).
% -define(ETS_SCENE_GRID_14, ets_scene_grid_14).
% -define(ETS_SCENE_GRID_15, ets_scene_grid_15).
% -define(ETS_SCENE_GRID_16, ets_scene_grid_16).
% -define(ETS_SCENE_GRID_17, ets_scene_grid_17).
% -define(ETS_SCENE_GRID_18, ets_scene_grid_18).
% -define(ETS_SCENE_GRID_19, ets_scene_grid_19).
% -define(ETS_SCENE_GRID_20, ets_scene_grid_20).
% -define(ETS_SCENE_GRID_21, ets_scene_grid_21).
% -define(ETS_SCENE_GRID_22, ets_scene_grid_22).
% -define(ETS_SCENE_GRID_23, ets_scene_grid_23).
% -define(ETS_SCENE_GRID_24, ets_scene_grid_24).
% -define(ETS_SCENE_GRID_25, ets_scene_grid_25).
% -define(ETS_SCENE_GRID_26, ets_scene_grid_26).
% -define(ETS_SCENE_GRID_27, ets_scene_grid_27).
% -define(ETS_SCENE_GRID_28, ets_scene_grid_28).
% -define(ETS_SCENE_GRID_29, ets_scene_grid_29).
% -define(ETS_SCENE_GRID_30, ets_scene_grid_30).
% -define(ETS_SCENE_GRID_31, ets_scene_grid_31).
% -define(ETS_SCENE_GRID_32, ets_scene_grid_32).



% -define(ETS_STAT_SOCKET, ets_stat_socket).		%% Socket输出数据统计（协议号，次数）
% -define(ETS_STAT_COMPRESS, ets_stat_compress).	%% Socket压缩数据统计
-define(ETS_STAT_DB, ets_stat_db).				%% 数据库操作统计

-define(ETS_SERVER, ets_server).                %% 服务器的各个节点（如：网关，世界，游戏逻辑等）
-define(ETS_SERVER_MISC, ets_server_misc).		%% 服务器的一些杂项信息，如：服务器当前是开服还是关服，当前服务器时钟的滴答计数，当前unix时间戳等


-define(ETS_MON, ets_mon).         % 明雷怪对象表
-define(ETS_STATIC_NPC, ets_static_npc).           % 静态NPC对象表
-define(ETS_DYNAMIC_NPC, ets_dynamic_npc).         % 动态NPC对象表
-define(ETS_SCENE, ets_scene).     % 场景对象表

-define(ETS_MAP_OF_SCENE_TO_RESERVE_SCENE, ets_map_of_scene_to_reserve_scene).     % 场景id到对应后备场景id的映射


-define(ETS_MON_POSITION, ets_mon_position).  % 目前是用于记录任务明雷怪对象的位置信息，以辅助实现客户端自动寻路


-define(ETS_MARKET_GOODS_ONLINE, ets_market_goods_online).      %% 市场的上架物品信息表

% -define(ETS_MARKET_GOODS_ATTR, ets_market_goods_attr).          %% 市场的上架物品的附加属性信息表
% -define(ETS_GOODS_DROP, ets_goods_drop).                        %% 物品掉落表


%%-define(ETS_PROTECT_TASK, ets_protect_task).            %% 护送任务奖励级别

% -define(ETS_LV_EXP, ets_lv_exp).

-define(ETS_RELA, ets_rela).                                      %% 玩家关系表
-define(ETS_RELA_INFO, ets_rela_info).                            %% 玩家关系相关的信息
% -define(ETS_RELA_SET, ets_rela_set).                            %% 玩家好友分组名字表

-define(ETS_GUILD,        ets_guild).                             %% 帮派 存储帮派本身的信息（以帮派id作为key），元素为guild结构体
-define(ETS_GUILD_MEMBER, ets_guild_member).                      %% 帮派成员 存储玩家的与帮派有关的信息（以玩家id作为key）， 元素为guild_mb结构体
-define(ETS_GUILD_DUNGEON,  ets_guild_dungeon).                   %% 帮派副本
-define(ETS_GUILD_PARTY, ets_guild_party).                        %% 帮派宴会
-define(ETS_MAP_OF_GUILD_ID_TO_GUILD_NAME, ets_map_of_guild_id_to_guild_name). %% 帮派id到帮派名的映射（目前是为了处理AOI时，可以快速依据帮派id获取帮派名）
-define(ETS_GUILD_WAR, ets_guild_war).                            %% 帮派争夺战相关信息


-define(ETS_PARTNER, ets_partner).                  %% 玩家的宠物
% -define(ETS_PARTNER_HOTEL, ets_partner_hotel).      %% 玩家寻妖系统放在青楼中的女妖
-define(ETS_FIND_PAR, ets_find_par).                %% 玩家寻妖信息
% -define(ETS_PARTNER_CG, ets_partner_CG).                  	  %% 剧情战斗CG的临时武将
% -define(ETS_PLAYER_TROOP, ets_player_troop).                    %% 玩家的阵法信息

-define(ETS_MARKET_SELLING, ets_mk_selling).                    %% 市场上架物品表

-define(ETS_BATTLE_CREATE_LOG, ets_battle_create_log).                   %% 战斗创建记录表
-define(ETS_TEAM, ets_team).                                  %% 玩家创建的队伍

-define(ETS_BUFF, ets_buff).                                  %% 玩家或宠物战斗外的buff

-define(ETS_BUY_BACK, ets_buy_back).                          %% 玩家回购物品列表

-define(ETS_DYNAMIC_SHOP_GOODS, ets_dynamic_shop_goods).       %% 商城商店动态物品信息
-define(ETS_OP_SHOP_GOODS, ets_op_shop_goods).                 %% 运营后台限时限购商城物品信息（物品编号可能与普通商城的编号一样，故另起ets保存）
-define(ETS_PLAYER_MISC, ets_player_misc).                     %% 玩家杂项信息，如从npc商店和商城的购买信息情况 和 某物品的使用情况等

% -define(ETS_GLOBAL_ARENA_INFO, ets_global_arena_info).          %% 全局竞技场信息（存于世界节点）
% -define(ETS_GLOBAL_PLAYER_CACHE, ets_global_player_cache).		%% 全局玩家缓存（用于竞技场离线pk）
% -define(ETS_GLOBAL_PARTNER_CACHE, ets_global_partner_cache).	%% 全局武将缓存（用于竞技场离线pk）


% -define(ETS_CURRENTLY_CONTACT,ets_currently_contact).           %%最近联系人



% -define(ETS_CURRENTLY_TEAMMATE, ets_currently_teammate).		%%最近战友




-define(ETS_BROADCAST, ets_broadcast).  %%运营后台公告



% -define(ETS_GLOBAL_VARIABLE, ets_global_variable).              %% 全局变量,从SQL读取



-define(ETS_ROLE_NAME, ets_role_name).      %% 存储玩家{名字, id}表


-define(ETS_HIRE, ets_hire). % 可以供雇佣的天将列表
-define(ETS_HIRER, ets_hirer). % 雇主雇佣情况信息表

-define(ETS_SYS_SET, ets_sys_set). %% 玩家系统设置



-define(ETS_GLOBAL_DATA, ets_global_data).  %% 全局数据（通常是静态数据）


-define(ETS_DAY_REWARD, ets_day_reward).    %% 玩家每日奖励数据：包括每日签到与在线奖励的数据


-define(ETS_BANNED_IP, ets_banned_ip).      %% 封禁IP

-define(ETS_BANNED_ROLE, ets_banned_role).  %% 封角色

-define(ETS_WORLD_CHAT_CD_TMP, ets_world_chat_cd_tmp).  %% 世界聊天

-define(ETS_BANNED_CHAT_TMP, ets_banned_chat_tmp).      %% 禁言

-define(ETS_TASK_TMP_CACHE, ets_task_tmp_cache).        %% 任务临时存储

-define(ETS_TASK_TMP_ACCEPTED, ets_task_tmp_accepted).

-define(ETS_TASK_TMP_ACCEPTED_LIST, ets_task_tmp_accepted_list).

-define(ETS_TASK_TMP_COMPLETED, ets_task_tmp_completed).

-define(ETS_TASK_TMP_COMPLETED_LIST, ets_task_tmp_completed_list).

-define(ETS_TASK_TMP_RING, ets_task_tmp_ring).

-define(ETS_TASK_TMP_RING_LIST, ets_task_tmp_ring_list).

-define(ETS_TASK_TMP_AUTO_TRIGGER, ets_task_tmp_auto_trigger).

-define(ETS_TASK_TMP_COMPLETED_UNREPEAT, ets_task_tmp_completed_unrepeat).

-define(ETS_ACTIVITY_DEGREE_TMP_CACHE, ets_activity_degree_tmp_cache).  % 活跃度临时存储

-define(ETS_JINGYAN_TMP_CACHE, ets_jingyan_tmp_cache).  % 经验找回临时存储

-define(ETS_ACHIEVEMENT_TMP_CACHE, ets_achievement_tmp_cahce).  % 成就临时存储 还有保存一些其他的临时数据

-define(ETS_CHAPTER_TARGET, ets_chapter_target).        % 章节目标

-define(ETS_ANSWER, ets_answer).        % 答题

-define(ETS_ACTIVITY_DATA, ets_activity_data).        % 活动数据

-define(ETS_ID_ALLOC, ets_id_alloc).        % 自增ID（id自动分配器）

-define(ETS_LOCALID_PLAYERID_MAP, ets_localid_playerid_map).    % 全服/全局ID映射表

-define(ETS_TVE, ets_tve). % tve兵临城下表

-define(ETS_DUNGEON_PLOT, ets_dungeon_plot).        % 副本剧情目标表

-define(ETS_ADMIN_ACTIVITY, ets_admin_activity).    % 运营活动

-define(ETS_ROLE_ADMIN_ACTIVITY, ets_role_admin_activity).    % 运营活动角色相关数据

-define(ETS_ADMIN_SYS_ACTIVITY, ets_admin_sys_activity).    % 运营系统活动信息

-define(ETS_ADMIN_SYS_ACTIVITY_BRIEF, ets_admin_sys_activity_brief).    % 运营系统活动简要信息

-define(ETS_TITLE, ets_title).    % 玩家称号

-define(ETS_DIY_TITLE, ets_diy_title). %玩家定制称号

-define(ETS_RECHARGE_ACCUM, ets_recharge_accum).        % 充值累积活动

-define(ETS_RECHARGE_ONE, ets_recharge_one).            % 单笔充值活动

-define(ETS_CONSUME_ACTIVITY, ets_consume_activity).    % 消费累积活动                  

-define(ETS_SWORN, ets_sworn).								  % 结拜数据


-define(ETS_PLAYER_SPRD, ets_player_sprd).    % 玩家的推广信息

-define(ETS_ROLE_TRANSPORT, ets_role_transport).    % 玩家运镖信息

-define(ETS_TRUCK_INFO, ets_truck_info).        % 镖车信息

-define(ETS_TRUCK_ID_SET, ets_truck_id_set).    % 镖车ID集合

-define(ETS_RANKING_EXCEPT_STATE, ets_ranking_except_state).    % 排名异常状态表

-define(ETS_ADMIN_FESTIVAL_ACTIVITY, ets_admin_festival_activity).  % 节日活动表

-define(ETS_ADMIN_SYS_SET, ets_admin_sys_set).  % 后台活动与系统相关设置

-define(ETS_REWARD_POOL, ets_reward_pool).  % 奖励池

-define(ETS_BEAUTY_CONTEST_STATUS, ets_beauty_contest_status).  % 女妖选美状态ets
-define(ETS_BEAUTY_CONTEST_CACHE, ets_beauty_contest_cache).    % 女妖选美缓存

-define(ETS_MELEE_STATUS, ets_melee_status).                    % 女妖乱斗状态ets
-define(ETS_MELEE_PLY_INFO, ets_melee_ply_info).                % 女妖乱斗玩家信息表

-define(ETS_ADMIN_ACTIVITY_QUERY, ets_admin_activity_query).    % 玩家运营活动查询信息

-define(ETS_GLOBAL_SYS_VAR, ets_global_sys_var).                        % 全局系统变量

-define(ETS_HORSE_RACE, ets_horse_race).                        % 跑马场信息

-define(ETS_SECURITY_IP, ets_security_ip).                      % 白名单ID列表

-define(ETS_LIB_ARENA_1V1, ets_lib_arena_1v1).                  %比武大会玩家匹配信息表

-define(ETS_NEWYEAR_BANQUET, ets_newyear_banquet).              %年夜宴会
-define(ETS_NEWYEAR_BANQUET_SCENE_STATUS, ets_newyear_banquet_scene_status). %年夜宴会场景状态
-define(ETS_ERNIE_TMP_CACHE, ets_ernie_tmp_cache).              %幸运转盘玩家缓存
-define(ETS_RECHARGE_ACCUM_DAY, ets_recharge_accum_day).        % 每日充值累积活动
-define(ETS_LIB_ARENA_3V3, ets_lib_arena_3v3).                  %3v3比武大会队伍匹配信息表
-define(ETS_MOUNT, ets_mount).                                  %坐骑
-define(ETS_MOUNT_SKIN, ets_mount_skin).                        %坐骑皮肤
-define(ETS_BUSINESS_SERVER, ets_business_server).                               %商会
-define(ETS_BUSINESS_PLAYER, ets_business_player).                               %商会

-define(ETS_GUESS_QUESTION, ets_guess_question).				% 竞猜活动题目数据

-define(ETS_ROLE_ARTS, ets_role_arts).                          % 某玩家练功数据
%%-define(ETS_PLAYER_ARTS_INV, ets_player_arts).                % 某个玩家的内功

-define(ETS_ROAD_INFO, ets_road_info).				            % 取经之路数据


-define(ETS_GUILD_POINT_INFO, ets_guild_point_info).	        % 帮派副本每个关卡的数据

-define(ETS_GUILD_PERSON_INFO, ets_guild_person_info).	        % 帮派副本玩家的数据

-define(ETS_TIME_LIMIT_RANK, ets_time_limit_rank).              %限时转盘排名ets
-define(ETS_PLAYER_LOTTERY_INFO, ets_player_lottery_info).		% 限时抽奖

-define(ETS_TIME_LIMIT_RANK_PLAYER_DATA, ets_time_limit_rank_player_data).       %限时转盘排名的具体信息ets

-define(ETS_PLAYER_VOUCHERS_INFO, ets_player_vouchers_info).    % 玩家现金券

-define(ETS_EQUIP_FASHION, ets_equip_fashion).


%% 跨服聊天窗口查看玩家数据
-define(ETS_CROSS_CHAT_DATA, ets_cross_chat_DATA).

-define(ETS_CROSS_PLAYER,	ets_cross_player).					% 跨服玩家的player数据

-define(ETS_PVP_3V3_SUP_POOL, ets_pvp_3v3_sup_pool).		    % 跨服3v3战斗房间匹配池

-define(ETS_PVP_3V3_ROOM, ets_pvp_3v3_room).					% 跨服3v3创建房间

-define(ETS_PVP_RANK_DATA, ets_pvp_rank_data).					% 跨服3v3战斗全服排名

-define(ETS_PVP_CROSS_PLAYER_DATA, pvp_cross_player_data).      % 跨服3v3玩家数据

-define(CROSS_TYPE_POOL, cross_type_pool).

-define(ETS_PVP_MATCH_ROOM, ets_pvp_match_room).			    % 匹配房间

-define(ETS_ACCOUNT_BIND_MOBILE_SMS,	ets_account_bind_mobile_sms).	% 绑定手机短信验证码


 

-endif.  %% __ETS_NAME_H__
