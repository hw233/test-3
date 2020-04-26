%%%------------------------------------------------
%%% File    : gs_stati.hrl
%%% Author  : huangjf 
%%% Created : 2012.7.23
%%% Description: 全服的一些数据统计
%%%              gs_stati: 表示global server statistic
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__GS_STATI_H__).
-define(__GS_STATI_H__, 0).



%% 全服平均在线人数取值的修正范围： 最低平均数
-define(MIN_AVG_ONLINE_NUM, 10).

%% 全服平均在线人数取值的修正范围： 最高平均数
-define(MAX_AVG_ONLINE_NUM, 20000).

%% 全服平均战天币剩余量取值的修正范围： 最低剩余量
-define(MIN_AVG_ZT_MONEY, 100).






-record(gs_stati, {
			is_valid = false,                  % 这些统计数据是否有效？ true => 是，false => 否
											   % 如果没有在隔天0点时做更新，或者隔天0点时更新失败，则标记为无效!
											   
			yesterday_avg_online_num = 0,      % 前一天全服的平均在线人数
			yesterday_avg_zt_money = 0,        % 前一天全服活跃玩家的平均战天币剩余量
			
			yesterday_use_RMB_player_num = 0,  % 前一天全服消费元宝的人数
			yesterday_total_use_RMB = 0   	   % 前一天全服的元宝消费总额
	}).
























-endif.  %% __GS_STATI_H__
