%%%------------------------------------------------
%%% File    : battle_buff.hrl
%%% Author  : huangjf 
%%% Created : 2012.5.15
%%% Description: 战斗buff相关的宏（包括被动技效果和技能buff效果的名字）
%%%              注：对于被动技效果和技能buff效果的名字，目前实际上都是atom类型，
%%%                  定义成宏是为了方便以后改为其他类型（如果有必要的话）
%%%------------------------------------------------


%%% ！！！！注意：本文件已经作废！！！！！！！！！！！！！！！


%% 避免头文件多重包含
-ifndef(__BATTLE_BUFF_H__).
-define(__BATTLE_BUFF_H__, 0).



% %% 移除buff的原因（RB: remove buff） 
% % 回合结束刷新
% -define(RB_EXPIRE,		   1).   % buff过期
% % 立即刷新
% -define(RB_PURGED, 		   2).   % 被驱散
% -define(RB_EFF_DISAPPEAR,  3).   % 效果消失了（比如护盾的效果消失了）
% -define(RB_REPLACED,       4).   % 被新的同类buff代替（包括叠加buff时先移除旧buff的情况）
% % 动作 + 清除debuff
% -define(RB_SKL_CLEAR, 5).   % 使用纯粹清除debuff的技能




% %% 改变怒气
% -define(CHANGE_ANGER, change_anger).

% %% 改变觉醒
% -define(CHANGE_AROUSAL, change_arousal).

% %% 召唤
% -define(CALLING_MON, calling_mon).
















-endif.  %% __BATTLE_BUFF_H__
