%%%------------------------------------------------
%%% File    : skill.hrl
%%% Author  : huangjf 
%%% Created : 2012.1.14
%%% Description: 技能相关的宏和结构体定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__SKILL_H__).
-define(__SKILL_H__, 0).

% -define(EQ_SKILL_MAX_CELL, 6).  %% 装备技能最大的格子数
% -define(CLEAR_SKILL_NEED_GOLD, 200).  %% 洗点需要元宝数
% -define(CLEAR_SKILL_FREE_LV, 35).  %% 洗点免费等级





%%技能的配置数据
-record(skl_cfg, {
        id = 0,                        % 技能id
        name = <<"测试">>,             % 名字
        lv = 0,                        % 等级
        can_combo = 0,                 % 是否可以连击

        desc = <<"这是技能描述...">>,  % 描述
        rarity_no = 0,                 % 稀有度编号 宠物技能专用
        race = 0,                      % 种族
        faction = 0,                   % 门派
        type = 0,                      % 大类（主动技？被动技？）
        sub_type = 0,                  % 子类型（普通？夫妻技能？法宝技能？）
        is_inborn = 0,                 % 是否先天技能 1--是 0--不是
        att_type = 0,                  % 攻击类型（物理攻击？法术攻击？无攻击？）
        target_count_type = 0,         % 目标数量类型（单目标？多目标？）
        cd_rounds = 0,                 % 技能的冷却回合数
        prev_skills = [],              % 学习的前置技能列表，格式：[{技能id，技能等级}, ...]，需学习过前置技能后，才能学习此技能

        % lv_need = 0,                   % 学习所需的等级 
        % money_type_need = 0,           % 学习所需的金钱类型
        % money_need = 0,                % 学习所需的金钱数
        % skill_book_need = 0,           % 学习所需的技能书（物品编号）

        cost_hp_coef = 0,              % 使用技能时消耗hp的系数
        cost_hp = null,                % 使用技能时固定消耗的hp，  格式如：null（表示不消耗） | {rate, 比例值} | {int, 整数值}
        base_on_which_when_cost_hp = base_on_hp_lim, % （使用时）耗血所依据的基数类型： base_on_hp_lim（依据血量上限） | base_on_cur_hp（依据当前血量）

        cost_mp_coef = 0,              % 使用技能时消耗mp的系数
        cost_mp = null,                % 使用技能时固定消耗的mp，  格式如：null（表示不消耗） | {rate, 比例值} | {int, 整数值}

        cost_anger = null,             % 使用技能时固定消耗的怒气，格式如：null（表示不消耗） | {rate, 比例值} | {int, 整数值}
        cost_gamemoney = null,         % 使用技能时固定消耗的银子 null | {int, 整数}
        innate_dam = 0,               % 固有的伤害值（默认为0）

        ext_coef = 0,
        ext_coef_lv = 0,
        
        skill_scaling = 1,            % 技能放缩系数
        attack_scaling = 1,           % 攻击放大系数
        defend_scaling = 1,           % 防御放缩系数
        att_times_scaling = 1,        % 连击或攻击次数放缩系数
        std_dam_scaling = 0,          % 标准伤害放缩系数，默认为0
        xinfa_related_coef = 0,       % 心法关联系数

        dam_to_mp_scaling = 0,        % 伤蓝放缩系数

        inverse_dam_proba = 0,        % 反转伤害的概率（是一个放大了1000倍的整数值）
        inverse_dam_coef = 1,         % 反转伤害系数



        use_conditions = [],           % 使用条件

        passive_effs = [],             % 被动效果（效果编号列表）

        att_eff = 0,                   % 攻击效果（效果编号，最多只有1个），默认为0，表示不含攻击效果
        pre_effs = [],                 % 攻击前的效果（效果编号列表）
        in_effs = [],                  % 攻击过程中的效果（效果编号列表）
        post_effs = [],                % 攻击后的效果（效果编号列表）

        crit_effs = [],
        five_elements=0,               % 五行效果

        owner_xinfa_id = 1,            % 所属心法的id

        min_target_count = 0,          % 最低目标数量（用于参与计算目标数量， 仅针对法术群攻技能、法术群控技能和群治疗技能）
        target_count_constant = 0,     % 目标数量等差常量（用于参与计算目标数量, 仅针对法术群攻技能、法术群控技能和群治疗技能）


        ai_list = [],                   % 所附带的AI列表（AI编号列表）
        sequential_interference = 0 ,    %
        special_state_can_use = []     %%特殊状态下是否可用 默认情况下填空，需要情况下填chaos、cd、dead等等



        % att_type = 0,   % To-Do: 这个没用，战斗改完后要去掉
        % quality = 0,        % To-Do: 这个没用，战斗改完后要去掉
  %       career = 0,       % 职业
  %       type = 0,         % 类型
  %       main_eff_type = 0,         % 技能的主体效果类型
  %       series = 0,       % 系别
  %       hurt_type = 0,    % 伤害类型 1:物理, 2:法术, 3:绝技
  %       obj = 0,          % 作用对象：1-我方；2-敌方
  %       mod = 0,          % 作用范围：1-单体；2-全体
  %       last_turn = 0,      % 附加效果（Buff）的持续回合
  %       following_skill = 0, % 随后触发的下一追击技（只有主动技和追击技才有）
  %       buff_invalid_to_boss = 0,  % 技能的buff效果是否对boss无效（1：是，0：否）
  %       cd_round = 0,    % 剩余冷却回合数
  %       hurt_display_times = 0,  % 客户端的伤害显示次数
  %       share_cd_skills = [],    % 与本技能共用cd的技能id列表
  %       data = []       % 技能数据（若有，则是rd_skill_data记录）
    }).


%% 技能简要信息
-record(skl_brief, {
        id = 0,        % 技能id
        lv = 0        % 技能等级

    % 如有需要，添加其他字段
    % ...
    }).



%% 宠物技能的id从10000起开始
-define(PARTNER_SKILL_START_ID, 10000).



%% 技能大类
-define(SKL_T_INITIATIVE, 1).    % 主动技能
-define(SKL_T_PASSIVE,    2).    % 被动技能

%% 技能子类型
-define(SKL_SUB_T_NORMAL,    0).    % 普通（默认的子类型）
-define(SKL_SUB_T_COUPLE,    1).    % 夫妻技能
-define(SKL_SUB_T_TALISMAN,  2).    % 法宝技能



%%-define(SKL_T_ASSIST,     3).    % 辅助技能
%%-define(SKL_T_STUNT,      4).    % 绝技（必杀技）
%%-define(SKL_T_MAX,        4).    % 技能类型最大有效值（用于程序做判定）


%% 新手技能的id
-define(NEWBIE_SKILL_ID, 100).




%% 技能的伤害类型
-define(DAM_T_NONE, 0).   % 无伤害（纯粹施法而不含攻击的技能）
-define(DAM_T_PHY,  1).   % 物理伤害
-define(DAM_T_MAG,  2).   % 法术伤害





%% 攻击类型
-define(ATT_T_PHY,      1).       % 物理攻击
-define(ATT_T_MAG,      2).       % 法术攻击
-define(ATT_T_NONE,     3).       % 纯粹施法而不含攻击（如有必要，再细拆为纯增删buff，纯治疗，纯复活，纯召唤。。。）
-define(ATT_T_POISON,   5).       % 毒攻击
-define(ATT_T_PHY_2,    6).       % 物理攻击同时群攻



%% 目标个数类型
-define(TARGET_COUNT_SINGLE, 1).      % 单目标
-define(TARGET_COUNT_MULTI,  2).      % 多目标


%% 主动技能最大数量
-define(MAX_INBORN_COUNT,  4).      % 最大主动技能数量












% %% 技能每个等级对应的细化数据
% -record(rd_skill_data, {
%         desc = <<>>,        % 描述
%         study_cond = [],    % 学习条件
%         use_cond = [],      % 使用条件
        
%         gain_anger = 0,     % 获得的怒气
%         cost_anger = 0,     % 消耗的怒气
        
%         gain_arousal = 0,   % 获得的觉醒值
%         cost_arousal = 0,   % 消耗的觉醒值
        
% 		% 只有被动技才有
% 		passive_eff = [],   % 被动技的被动效果列表
		
% 		% 只有合体技才有
% 		response_time = 0,	% 响应时间
% 		extra_hurt = [],	% 附加伤害

%         % 技能球相关字段
%         ball_list = [],   % 技能球对应技能ID组合
%         ball_end = 0,   % 技能结束球对应技能ID
		  
% 		segment = []		% 技能段（rd_skill_segment记录）
%     }).

% %% 技能段
% -record(rd_skill_segment, {
%                 target_type = 0,    % 目标类型 1: 以目标决定, 2: 以格子固定
% 				att = 0,            % 攻击力
% 				combo = 0,          % 连招数		
% 				hit_shape = 0,      % 打击范围ID
%         		fx = [],            % 技能的即时效果列表
%         		buff = []           % 技能所造成的BUFF效果列表   
% 	}).



% 作废！！
% % 普通攻击对应的技能id（把普通攻击看成是一个技能），目前固定为0
% -define(NORMAL_ATT_SKILL_ID, 0).


% % 无效的技能格子位置
% -define(INVALID_SKL_GRID, 0).

% % 第一个有效的技能格子位置
% -define(FIRST_VALID_SKL_GRID, 1).


% %% 技能类型
% -define(SKL_T_COMM, 1). 		% 普通技
% -define(SKL_T_STUNT, 2). 		% 必杀技
% -define(SKL_T_PASSIVE, 3).  	% 被动技
% -define(SKL_T_PURSUE, 4). 		% 追击技
% -define(SKL_T_COOPERATE, 5).  	% 合体技
% -define(SKL_T_SKILLBALL, 6).   % 目前该类型仅仅是用于标识，无实际意义
% -define(SKL_T_AWAKE_STUNT, 7).   % 觉醒必杀技






% %% 技能伤害类型
% -define(HURT_TYPE_PHY, 1). % 物理
% -define(HURT_TYPE_MGC, 2). % 法术
% -define(HURT_TYPE_STU, 3). % 绝技






%% 最大比例，百分比
% -define(SKIL_MAX_PERCENT, 100). 

%% 技能球的默认等级
% -define(SKILL_BALL_DEFAULT_LV, 1).

%% 最大技能吸血量
% -define(MAX_SKILL_DIVERT_HP, 5000).

%% 技能的无视属性类型
% -define(IGNORE_PHY_DEF, ignore_phy_def).
% -define(IGNORE_MAG_DEF, ignore_mag_def).
% -define(IGNORE_STU_DEF, ignore_stu_def).
% -define(IGNORE_DODGE, ignore_dodge).
% -define(IGNORE_BLOCK, ignore_block).



%% 技能的主体效果类型
% -define(MAIN_EFF_T_ATTACK, 		0). 	% 攻击敌方（这是默认主体效果）
% -define(MAIN_EFF_T_ADD_BUFF, 	1).  	% 纯粹给己方加buff
% -define(MAIN_EFF_T_ADD_DEBUFF, 	2). 	% 纯粹给敌方加debuff
% -define(MAIN_EFF_T_HEAL, 		3).  	% 纯治疗
% -define(MAIN_EFF_T_PURGE, 		4).  	% 纯驱散
% -define(MAIN_EFF_T_REVIVE, 		5).  	% 复活
% -define(MAIN_EFF_T_ONLY_FX, 6).   % 仅使用Fx效果






%% 被动技的效果标记
%% PE: passive effect
%%-define(PE_T_PHY_ATT_ADD_RATE, 1).   % 提升xx%的物理攻击
%%-define(PE_T_DODGE_ADD_RATE, 1).   % 提升xx%的物理攻击
%%-define(PE_T_GAIN_ANGER_BY_ATT, 1).   % 每次攻击获得而外的怒气
%%-define(PE_T_GAIN_ANGER_BY_USE_PUR_SKL, 1). % 使用追击技时额外获得怒气



% %% 技能攻击方式
% -define(ATT_TYPE_STU_NEAR, 1). 	 % 必杀近战
% -define(ATT_TYPE_STU_REMOTE, 2). % 必杀远程
% -define(ATT_TYPE_BUFF, 3). 		 % BUFF
% -define(ATT_TYPE_DEBUFF, 4). 	 % DEBUFF
% -define(ATT_TYPE_REMOTE, 5). 	 % 远程
% -define(ATT_TYPE_NEAR, 6). 		 % 近战









%% 技能目标类型
% -define(TARGET_TYPE_OBJ, 1).	   % 以目标所在格为中心
% -define(TARGET_TYPE_GRID, 2).	   % 固定以打击范围的格子为绝对坐标
% -define(TARGET_TYPE_GRIG_ORDER, 3).   % 按 hit_shape 格子列表逐个查询，如果查到有对象，则停止继续查询

%% 技能公共CD时间（毫秒）
% -define(SKILL_CD_TIME, 500).

%% 禁止使用的技能类型
%%-define(FORBID_NONE, 0).   % 无
%%-define(FORBID_REMOTE, 1). % 远程
%%-define(FORBID_NEAR, 2).   % 近战
%%-define(FORBID_STUN, 3).   % 必杀技



%%熟练度相关
% -define(PROFI_TYPE_1, 50). %方式1增加的熟练度数量
% -define(PROFI_GOLD, 1).    %每点熟练度需要元宝

% -define(EQ_PARTNER_SKILL_MAX_CELL, 4).  %武将技能装备栏最大限制
% -define(EQ_NORMAL_SKILL_CELL, 3).  %武将主动技能最大格子限制
% -define(EQ_STUN_CELL, 4).   %武将必杀格子

% -define(SkillTask, 8008).   %开放技能系统任务ID

% -define(AUTO_LEARN_LV_1, 5).  %%自动学习第一个技能等级
% -define(AUTO_LEARN_LV_2, 6).  %%自动学习第二个技能等级














-endif.  %% __SKILL_H__
