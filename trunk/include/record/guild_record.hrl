
%%%------------------------------------------------
%%% File    : guild_record.hrl
%%% Author  : huangjf
%%% Created : 2013.6.21
%%% Description: 帮派系统的相关record定义
%%%------------------------------------------------



%% 避免头文件多重包含
-ifndef(__GUILD_RECORD_H__).
-define(__GUILD_RECORD_H__, 0).


%% 帮派
-record(guild, {
            id = 0,
            name = <<"无名">>,
            brief = <<"简介">>,         % 帮派简介(公告)最多输入30个汉字或60个字符
            lv = 0,
            create_time = 0,            % 创建时间
            chief_id = 0,               % 帮主id
            chief_name = <<>>,          % 帮主名字，不存盘，帮派信息加载的时候从玩家表获取
            counsellor_id_list = [],    % 军师id列表
            shaozhang_id_list = [],     % 哨长id列表
            rank = 0,                   % 帮派排名
            prosper = 0,                % 帮派当前繁荣度 升级后会消耗 相当于帮派的经验
            member_id_list = [],        % 成员id列表
            request_joining_list = [],  % 格式如：[] | join_guild_req结构体列表
            prosper_today = 0,          % 今天累计获得繁荣度，规定：帮派繁荣度每日获得最多不超过(帮派等级^2-1)*20点繁荣度
            last_add_prosper_time = 0,  % 上次添加繁荣度时间
            fund = 0,                   % 帮派基金 此字段暂时没用了
            login_id_list = [],         % 24小时内登录过的玩家id列表 凌晨清空
            state = 0,                  % 帮派状态 0 --> 正常状态  1-->非活跃状态  2-->冻结状态  （不存盘）
            mark_unactive_time = 0,     % 被标记为非活跃状态的时间戳  如果当帮派处于非活跃状态连续达到 3 天 则帮派处于冻结状态 （不存盘）
            mark_frozen_time = 0,       % 被标记为冻结状态的时间戳 （不存盘）
            chief_last_login_time = 0,  % 帮主最近登录时间 需判断是不是 0（不存盘）
            scene_id = 0,               % 帮派副本id (不存盘)
            liveness = 0,               % 当日活跃度
            battle_power = 0,           % 帮派战力
            donate_rank = [],           % 累计捐献排名：[{Name, Money},...]
            total_bid = 0,              % 本周帮派争夺战投标的总money(绑银) 周日0点清空
            bid_id_list = [],           % 本周报名帮派争夺战的玩家id列表 周日0点清空
            join_control = 1,            % 控制选项：1 --> 无需审核入帮 2 --> 需要审核入帮 3 --> 禁止玩家加入
    guild_shop=[]
        }).


%% 申请入帮的记录
-record(join_guild_req, {
            id = 0,                     % 申请人的id（玩家id）
            name = <<"无名">>,          % 申请人的名字
            lv = 0,                     % 申请人的等级
            vip_lv = 0,                 % vip等级
            sex = 0,                    % 申请人的性别
            race = 0,                   % 申请人种族
            faction = 0,                % 申请人门派
            battle_power = 0,           % 战斗力
            time = 0                    % 申请时的时间（unix时间戳）
     }).


%% 帮派成员
-record(guild_mb, {
            id = 0,                                   % 帮派成员id（即玩家id）
            guild_id = 0,                             % 所属帮派id
            name = <<"无名">>,              
            lv = 0,                 
            vip_lv = 0,                               % vip等级
            sex = 0,                
            race = 0,                                 % 玩家种族
            faction = 0,                              % 玩家门派
            join_time = 0,
            contri = 0,                               % 累计帮派贡献度
            battle_power = 0,                         % 战斗力
            title_id = 0,                             % 帮派称号id
            left_contri = 0,                          % 剩余帮派贡献度
            contri_today = 0,                         % 当天贡献度
            last_add_contri_time = 0,                 % 成员上次贡献时间（unix时间戳）
            donate_today = 0,                         % 当天银子捐献数量
            donate_total = 0,                         % 累计捐献
            last_donate_time = 0,                     % 上次捐献时间 
            pay_today = [{0,0},{0,0},{0,0},{0,0}],    % 当日可以领取的工资，[{基本工资,领取状态},{职位薪资,领取状态},{贡献度薪资,领取状态},{贡献度排行薪资,领取状态}] 一天一次,1已经领取,0还没有领取
            position = 0,                             % 玩家在帮派中的职位   通过 decide_guild_pos 判断 存盘是为了数据中心统计的需要
            bid = 0,                                  % 本轮回为帮派争夺战投标的money(绑银) 确定投标是否成功时清空
            is_dirty = false                          % 标记是否为脏，是脏的话，关服时保存数据
        }).


%% 帮派争夺战 相关信息
-record(guild_war, {
            guild_id = 0,
            name = <<>>,
            total_bid = 0,
            battle_power = 0,
            
            finish = 0,                                  % 0表示没有结束，1表示已经结束了
            war_handle_pid = 0,                          % 帮派战斗实例进程
            war_pre_dun_pid = 0,                         % 帮派战准备副本进程标识 没有开始则为0
            war_dun_pid = 0,                             % 战斗副本进程标识 没有开始则为0

            bid_id_list = []
    }).


%% 帮派等级关联属性
-record(guild_lv_data, {
            no = 0,    
            capacity = 0,    
            need_prosper = 0,
            prosper_max_day = 0,
            upkeep = 0,
            day_grant = 0,      
            skill = 0, 
            goods = 0, 
            base_pay = 0,    
            rank_need = 0, 
            rank_pay = 0,  
            bag_capacity = 0,      
            counsellor_max = 0,    
            shaozhang_max = 0,
            scene_no = 0,
            prospe_add_per_task = 0,
            prospe_add_party = 0,
            prospe_add_dungeon = 0,      
            prospe_add_war = 0,    
            contri_add_party = 0,  
            contri_add_dungeon = 0,      
            contri_add_war = 0,
            npc_list = [],
            liveness = 0,            %% 标准活跃度            
            layer = [],
            repair_attrs = [],
            point_repair_max = 0
      }).


-record(guild_contri_coef, { 
      range = 0, 
      coef = 0
      }).


-record(guild_dungeon, {
      guild_id = 0,
      dungeon_pid = 0,          % 副本进程
      floor = 0,                % 当前层数
      collect = 0,              % 当前资源采集数
      kill_mon = 0,             % 当前杀怪数
      start_time = 0,           % 该层开始时间
      max_floor = 0,            % 最大层数
      join_id_list = []
    }).

%% 帮派宴会数据另起ets存在，不保存在 ets_guild 防止出现多进程同步造成数据覆盖的问题
-record(guild_party, {
      guild_id = 0,
      start_time = 0,              % 开始时间
      mon_id = [],                 % 宴会刷出怪的id列表
      dishes_no = [],              % 帮派菜式编号列表
      dishes_npc = []              % 帮派宴会刷出来的npc id列表，清除时用
      }).

%% 帮派副本层数配置表
-record(guild_dungeon_cfg, {
      floor = 0, 
      reward_no = 0,   
      time = 0,  
      need_point = 0,
      point_mon = 0,   
      point_npc = 0,
      enter_point = []        %% 该层地图进入点：MapNo,X,Y
      }).


%% 帮派加菜配置数据
-record(guild_dishes, {
      no = 0,
      buff_no = 0,    
      exp_add = 0,  
      broadcast_id = 0,
      reward_id = 0,   
      gamemoney_add = 0,     
      need_yuanbao = 0,
      vip_lv = 0,
      npc = {}
      }).


%% 帮派点修数据
-record(guild_cultivate_cfg, {
      lv = 0,
      need_point_next_lv = 0,
      need_gamemoney = 0,
      need_contri = 0,
      need_exp = 0,    
      need_contri_2 = 0,
      hp_lim = null,
      act_speed = null,
      seal_hit = null,
      seal_resis = null,
      mp_lim = null,
      crit = null,
      ten = null,
      hit = null,
      dodge = null
      }).


-record(guild_vip_score, {
      vip_lv = 0,
      score = 0
      }).


-record(guild_sys_cfg, {
      p_name = null,
      init_phy_power = 0,    
      att_phy_power = 0,     
      fail_phy_power = 0,    
      atted_succ_phy_power = 0,
      pre_war_time = 0,
      war_time = 0
      }).

-record(guild_war_reward, {
      no = 0,    
      goods_no = 0,
      boss_goods_no = 0,      %% 冠亚军寨主额外奖励包
      prosper = 0
      }).


% 帮派技能配置
-record(guild_skill_config, {
      no = 0,    
      type = 0,  
      name = <<"">>,  
      skill_name = null,  
      cons_ratio = 0,  
      value = 0,
      vitality = null,
      goods_list = []
      }).

% 帮派技能升级配置
-record(guild_skill_up_cons_config, {
      no = 0,    
      price_type = 0,  
      price = 0, 
	  need_lv = 0,
      need_contri = 0
      }).


% 帮派点修等级配置
-record(guild_cultivate_lv_cfg, {
      lv = 0,    
      need_point = 0,  
      price_type = 0,  
      price = 0, 
      do_phy_dam_scaling = 0,      
      do_mag_dam_scaling = 0,      
      heal_value = 0,  
      seal_hit = 0,    
      seal_resis = 0,  
      be_phy_dam_reduce_coef = 0,  
      be_mag_dam_reduce_coef = 0
      }).

% 帮派点修学习配置
-record(guild_cultivate_learn_cfg, {
      no  =0,
      type  =0,
      goods_no = 0,
      cons_ratio = 0,  
      include_attrs = []
      }).


-endif.  %% __GUILD_RECORD_H__