%%%------------------------------------------------
%%% File    : player_ext.hrl
%%% Author  : 段世和
%%% Created : 2015-10-24
%%% Description: 玩家拓展信息表
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__TRANSFIGURATION_H__).
-define(__TRANSFIGURATION_H__, 0).

% 老虎机配置结构体--------------------------------------------------
-record(transfiguration_config,{
		no = 1,
		add_attr = []
	}).


-endif.  %% __TRANSFIGURATION_H__