%% =============================================
%% @Module     : global_sys_var.hrl
%% @Author     : lidasheng
%% @Mail       : lidasheng17@gmail.com
%% @CreateDate : 2014-12-02
%% @Encoding   : UTF-8
%% @Desc       : 
%% =============================================

-ifndef(__GLOBAL_SYS_VAR_HRL). 
-define(__GLOBAL_SYS_VAR_HRL, 0). 


%% 系统类型

-define(WORLD_LV, 1001).            % 世界等级系统
-define(WORLD_LV_CUR_LV, 1002).     % 世界等级系统当前等级变量
-define(WORLD_LV_EFFECT_LV, 1003).  % 世界等级生效等级
-define(SEND_FIRST_RECHARGE, 1004).  % 首充奖励
-define(LUCK_DESIRE_INTEGRAL, 1005).  % 许愿总池的积分数

-endif.