%%%------------------------------------------------
%%% File    : newhand.hrl
%%% Author  : huangjf
%%% Created : 2012.8.12
%%% Description: 新手引导相关的宏
%%%------------------------------------------------



%% 避免头文件多重包含
-ifndef(__NEWHAND_H__).
-define(__NEWHAND_H__, 0).






%% 无效的新手引导事件id
-define(INVALID_GUIDE_EVENT_ID, 99999999).



%% 无效的引导任务id
-define(INVALID_GUIDE_TASK_ID, 99999999).







%% 新手引导涉及显示的图标代号: 1 => 阵法图标， 2 => 铸造图标， 3 => 生产图标）
-define(ICON_CODE_TROOP,   1).
-define(ICON_CODE_CASTING, 2).
-define(ICON_CODE_PRODUCE, 3).
















-endif.  %% __NEWHAND_H__
