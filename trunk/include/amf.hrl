%%%------------------------------------------------
%%% File    : amf.hrl (amf: auto MF, 自动打怪，引申为挂机的意思)
%%% Author  : huangjf 
%%% Created : 2012.6.13
%%% Description: 挂机系统的相关宏
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__AMF_H__).
-define(__AMF_H__, 0).





%% 自动挂机对玩家开放的最低需求等级，目前是6级
-define(START_AUTO_MF_NEED_LV, 6).


%% 玩家最多可以有xx个挂机技能组合（目前最多可以有两个）
-define(MAX_SKILL_COMB_COUNT, 2).


%% 每个挂机技能组合中最多可以有xx个技能（目前最多有6个）
-define(MAX_SKILL_IN_COMB, 6).



%%-define(AM_DEFAULT_ANGER_LIM, 80).  % 默认设置的怒气上限
























-endif.  %% __AMF_H__
