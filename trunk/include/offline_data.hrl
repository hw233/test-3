%%%-----------------------------------
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2013.12
%%% @Description: 离线数据
%%%-----------------------------------
-ifndef (__OFFLINE_DATA_H__).
-define(__OFFLINE_DATA_H__, 0).


-include("record.hrl").


%% 离线玩家的简要信息
-record(offline_role_brief, {
    id = 0
    ,name = <<>>
    ,guild_contri = 0
    ,lv = 0
    ,faction = 0
    ,race = 0
    ,battle_power = 0
    ,sex = 0
    ,vip_lv = 0
    ,peak_lv = 0
    }).




%% 宠物专有的特性
-record(par_prop, {  % partner's property
        no = 0,               % 宠物编号
        is_main_par = false,  % 是否为主宠（true | false）
        is_fighting = false,  % 是否设为出战（true | false）
        loyalty = 0,          % 忠诚度
        quality = 0,          % 品质
        cultivate_lv = 0,     % 修炼等级
        cultivate_layer = 0,  % 修炼层数
        evolve_lv = 0,        % 进化等级 影响外形
        nature = 0,           % 性格
        five_elment = {0,0},
		awake_illusion = 0	  % 宠物觉醒幻化等级（0表示无） 
        }).



%% 离线战斗对象
-record(offline_bo, {
    key = {0, 0, 0}                     % 格式：{对象（玩家或宠物）id，对象类型，所对应的系统类型}
    ,name = <<"无名">>                  % 名字
    ,race = 0                           % 种族
    ,faction = 0                        % 门派
    ,sex = 0                            % 性别
    ,lv = 0                             % 等级
    ,attrs = #attrs{}                   % 属性
    ,skills = []                        % 技能信息列表，对应#partner.skills ++ 坐骑技能，即skl_brief结构体列表 或 玩家的 法宝技能skl_brief结构体列表
    ,xinfa = []                         % 心法信息列表，对应#ply_xinfa.info_list，即xinfa_brief结构体列表
    ,showing_equips = #showing_equip{}  % 会影响外形的装备信息
    ,partners = []                      % 所拥有的宠物id列表（partner id list）
    ,par_property = null                % 宠物专有的特性，如果是宠物，则为par_prop结构体， 否则，固定为null
    }).




























-endif.  %% __OFFLINE_DATA_H__