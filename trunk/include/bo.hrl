%%%------------------------------------------------
%%% File    : bo.hrl (battle obj)
%%% Author  : huangjf
%%% Created : 2014.1.8
%%% Description: 战斗对象的相关宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__BO_H__).
-define(__BO_H__, 0).







%% 默认的伤害放缩系数（为1，表示不放缩）
-define(DEFAULT_DO_DAM_SCALING, 1).



%% 默认的暴击系数（为2，表示暴击时造成两倍的伤害）
-define(DEFAULT_CRIT_COEF, 2).

%% 暴击系数的最低值
-define(MIN_CRIT_COEF, 0).




%% 默认的被治疗效果系数，为1
-define(DEFAULT_BE_HEAL_EFF_COEF, 1).

%% 被治疗效果系数的最低值
-define(MIN_BE_HEAL_EFF_COEF, 0).




%% 默认的伤害减免系数，为0
-define(DEFAULT_BE_DAM_REDUCE_COEF, 0).

%% 伤害减免系数最大值，为1
-define(MAX_BE_DAM_REDUCE_COEF, 10).


%% 默认的吸血系数，为0
-define(DEFAULT_ABSORB_HP_COEF, 0).

%% 吸血系数的最低值
-define(MIN_ABSORB_HP_COEF, 0).





%% 默认的驱鬼系数，为1
-define(DEFAULT_QUGUI_COEF, 1).

%% 驱鬼系数的最低值
-define(MIN_QUGUI_COEF, 1).



%% 追击伤害系数最大值
-define(MAX_PURSUE_ATT_DAM_COEF, 10).





-endif.  %% __BO_H__
