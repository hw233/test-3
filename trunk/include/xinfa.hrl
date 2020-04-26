%%%------------------------------------------------
%%% File    : xinfa.hrl
%%% Author  : huangjf 
%%% Created : 2013.11.14
%%% Description: 心法相关的宏和结构体定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__XINFA_H__).
-define(__XINFA_H__, 0).








%% 心法配置数据
-record(xinfa,{
        id = 0,
        % lv = 0,
        name = <<"无名">>,
        faction = 0,
        unlock_lv = 0,
        % upg_cost_money_type = 0,
        % upg_cost_money = 0, 
        % upg_cost_exp = 0,

        is_master = 0,    % 是否主心法（1：是，0：否）

        add_attrs = [],   % 加成的属性名列表

        skill1 = 0,
        skill1_unlock_lv = 0,

        skill2 = 0,
        skill2_unlock_lv = 0,

        skill3 = 0,
        skill3_unlock_lv = 0

}).




%% 心法升级所需的消耗
-record(xf_upg_costs, {
        lv = 0,                 % 等级
        gamemoney = 0,          % 对应升级所需消耗的游戏币
        exp = 0                 % 对应升级所需消耗的经验
        }).





%% 心法的简要信息
-record(xinfa_brief, {
        id = 0,        % 心法id
        lv = 0         % 心法等级
        }).




%% 玩家的心法信息
-record(ply_xinfa,{
        player_id = 0,
        info_list = []  %  xinfa_brief结构体列表
        }).







%% 心法等级对应的标准值（由策划配置）
-record(xinfa_std_val, {
        xinfa_lv = 0,   
        hp = 0,
        mp = 0,
        phy_att = 0, 
        mag_att = 0, 
        phy_def = 0, 
        mag_def = 0, 
        hit = 0, 
        dodge = 0,   
        crit = 0,    
        ten = 0, 
        act_speed = 0,   
        seal_hit = 0,    
        seal_resis = 0
    }).





%% 心法的属性加成的数值（由策划配置）
-record(xinfa_add_attrs_val, {
        xinfa_lv = 0,   
        hp_lim = 0,
        mp_lim = 0,
        phy_att = 0, 
        mag_att = 0, 
        phy_def = 0, 
        mag_def = 0, 
        hit = 0, 
        dodge = 0,   
        crit = 0,    
        ten = 0, 
        act_speed = 0,   
        seal_hit = 0,    
        seal_resis = 0
    }).





-define(MAX_XINFA_LV, 300).      % 心法的最高等级



















-endif.  %% __XINFA_H__
