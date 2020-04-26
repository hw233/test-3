%%%------------------------------------------------
%%% File    : clifford.hrl
%%% Author  : 段世和
%%% Created : 2016-05-30
%%% Description: 福源
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__CLIFFORD_H__).
-define(__CLIFFORD_H__, 0).

% 福源--------------------------------------------------
-record(clifford_config,{
		type = 0,
		consume = [],
		must_goods = []
	}).

% 福源奖励--------------------------------------------------
-record(clifford_reward,{
		no = 0,
		type = 0,
		reward = 0,
		widget = 0,
		normal_widget = 0
	}).

-endif.  %% __CLIFFORD_H__