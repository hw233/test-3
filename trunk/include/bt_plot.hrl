%%%------------------------------------------------
%%% File    : bt_plot.hrl
%%% Author  : huangjf 
%%% Created : 2014.8.11
%%% Description: 战斗剧情的相关宏和结构体
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__BT_PLOT_H__).
-define(__BT_PLOT_H__, 0).








%% 战斗剧情事件
-record(bt_plot_event, {
		no = 0,                   % 事件编号
		bt_plot_no = 0,           % 所属战斗剧情的编号
		condition_list = [],      % 触发事件的条件列表（目前实际上为AI条件编号列表）
		content = undefined       % 事件内容
	}).














-endif.  %% __BT_PLOT_H__
