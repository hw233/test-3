%%%---------------------------------------
%%% @Module  : data_guild
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011-06-24
%%% @Description:  帮派配置
%%%---------------------------------------
-module(data_guild).

% %%
% %% External Exports
% %%

% -export([
%         get_guild_max_member/1
%         ,get_max_deputy_chief_num/1
%         ,get_max_prisbyster_num/1
%         ,get_contri_award/1
%         ,get_upg_hall_material/1
%         ,get_upg_board_material/1
%         ,get_cost_upgrade_store_material/1
%         ,get_capacity_num_of_board/1
%         ,get_capacity_num_of_store/1
%         ,config/1
%         ,get_need_guild_contri/1
%         ,get_add_mate_by_area/1
%         ,get_guild_name/1
%         ,get_init_collect_times/1
%     ]).

% -include("guild.hrl"). 
% %%
% %% API Functions
% %%

% %% desc: 获取当前等级的帮派成员上限
% get_guild_max_member(Level) ->
%     case Level of
%         1 -> 50;
%         2 -> 70;
%         3 -> 80;
%         4 -> 90;
%         5 -> 100;
%         _ -> 0
%     end.


% %% desc: 根据帮派等级获取副帮主上限
% get_max_deputy_chief_num(Level) ->
%     case Level of
%         1 -> 1;
%         2 -> 1;
%         3 -> 2;
%         4 -> 2;
%         5 -> 3;
%         _ -> 0 
%     end.


% %% desc: 根据帮派等级获取长老上限
% get_max_prisbyster_num(Level) ->
%     case Level of
%         1 -> 2;
%         2 -> 3;
%         3 -> 4;
%         4 -> 5;
%         5 -> 6;
%         _ -> 0
%     end.

% %% desc: 日常签到帮贡领取
% get_contri_award(Days) ->
%     case Days of
%         1 -> 10;
%         2 -> 20;
%         3 -> 30;
%         4 -> 40;
%         5 -> 50;
%         6 -> 60;
%         7 -> 70;
%         8 -> 80;
%         9 -> 90;
%         10 -> 100;
%         11 -> 110;
%         12 -> 120;
%         13 -> 130;
%         14 -> 140;
%         15 -> 150
%     end.


% %% 获取  帮会大厅  升级所需的石料和木材数量	{stone, wood}
% get_upg_hall_material(Level) -> % 1级 升 2级 需要200石料， 以此类推
%     case Level of
%         1 -> {2500, 2500};
%         2 -> {10000, 10000};
%         3 -> {40000, 40000};
%         4 -> {90000, 90000};
%         _ -> {30000000, 30000000}
%     end.


% %% 获取  帮会签到板  升级所需的石料和木材数量   {stone, wood}	
% get_upg_board_material(Level) -> % 1级 升 2级 需要200石料， 以此类推
%     case Level of
%         1 -> {2500, 2500};
%         2 -> {10000, 10000};
%         3 -> {40000, 40000};
%         4 -> {90000, 90000};
%         _ -> {30000000, 30000000}
%     end.


% %% 根据  签到板  等级获取签到人数上限
% get_capacity_num_of_board(Level) ->
%     case Level of
%         1 -> 20;
%         2 -> 30;
%         3 -> 40;
%         4 -> 50;
%         5 -> 60;
%         _ -> 0
%     end.


% %% 获取  帮会仓库  升级所需的石料和木材数量	{stone, wood}	
% get_cost_upgrade_store_material(Level) -> % 1级 升 2级 需要200石料， 以此类推
%     case Level of
%         1 -> {2, 2};
%         2 -> {4, 4};
%         3 -> {6, 6};
%         4 -> {8, 8};
%         _ -> {30000000, 30000000}
%     end.

% %% 根据  仓库  等级获取签到人数上限
% get_capacity_num_of_store(Level) ->
%     case Level of
%         1 -> 100;
%         2 -> 150;
%         3 -> 200;
%         4 -> 250;
%         5 -> 300;
%         _ -> 0
%     end.

% %% 每日需要消耗帮贡
% get_need_guild_contri(Area) ->
%     case Area of 
%         ?GUILD_AREA_CHUSHI -> 0;
%         ?GUILD_AREA_QINGTONG -> 1;
%         ?GUILD_AREA_BAIYIN -> 2;
%         ?GUILD_AREA_HUANGJIN -> 3;
%         _ -> 0
%     end.

% %% 帮会征战配置表
% config(Arg) ->
%     case Arg of
%         refresh_star_gold -> 20;  % 刷新星座需要元宝
%         war_lv -> 2;              % 征战等级
%         %% 妖魔反攻
%         ghost_war_time -> 60;   % 妖魔反攻时间
%         ghost_war_week -> 7;       % 默认周几妖魔反攻
%         ghost_war_start_time_6 -> {16, 30, 0}; % 周六反攻时间
%         ghost_war_start_time_other -> {21, 30, 0}; % 其它反攻时间
%         war_need_contri -> 0;
%         enter_guild_war_num -> 1% 进入帮会征战人数
%     end.


% %% desc: 根据帮会区域查询对应材料增加值
% get_add_mate_by_area(Area) ->
%     case Area of 
%         ?GUILD_AREA_CHUSHI -> 25;
%         ?GUILD_AREA_QINGTONG -> 50;
%         ?GUILD_AREA_BAIYIN -> 75;
%         ?GUILD_AREA_HUANGJIN -> 100;
%         _ -> 0
%     end.

% %% desc: 根据职位获取对应的名称
% get_guild_name(0) -> "帮众";
% get_guild_name(1) -> "长老";
% get_guild_name(2) -> "副帮主";
% get_guild_name(3) -> "帮主";
% get_guild_name(_) -> [].
    
% %% desc: 根据VIP等级查询采集初始上限
% get_init_collect_times(1) -> ?MAX_VIP1_COLLECT_TIMES;
% get_init_collect_times(2) -> ?MAX_VIP2_COLLECT_TIMES;
% get_init_collect_times(3) -> ?MAX_VIP3_COLLECT_TIMES;
% get_init_collect_times(4) -> ?MAX_VIP4_COLLECT_TIMES;
% get_init_collect_times(5) -> ?MAX_VIP5_COLLECT_TIMES;
% get_init_collect_times(_) -> ?COLLECT_MAX_TIMES.
    
    
    
    
    
    
    
    
%     