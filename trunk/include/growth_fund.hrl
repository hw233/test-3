%%%------------------------------------------------
%%% File    : bo.hrl (battle obj)
%%% Author  : huangjf
%%% Created : 2014.1.8
%%% Description: 战斗对象的相关宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__GROWTH_FUND_H__).
-define(__GROWTH_FUND_H__, 0).



-record(growth_fund, {
		no = 0,
		type = 0,
		lv = 0,
		reward = []
	}).



-endif.  %% __GROWTH_FUND_H__
