%%%------------------------------------------------
%%% File    : battle_record.hrl
%%% Author  : huangjf
%%% Created : 2012.5.15
%%% Modified: 2013.7.26
%%% Description: 战斗系统相关的结构体定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__BATTLE_RECORD_H__).
-define(__BATTLE_RECORD_H__, 0).


-include("common.hrl").
-include("battle.hrl").
-include("skill.hrl").
% -include("robot.hrl").
-include("record.hrl").
-include("bo.hrl").
-include("char.hrl").



%% 战斗创建记录
-record(btl_create_log, {
        battle_id = 0,                 % 新建战斗的id
        battle_pid = null,             % 新建战斗的进程pid
        create_date = {0, 0, 0},       % 创建日期: {年，月，日}
        create_time = {0, 0, 0},       % 创建时间：{时，分, 秒}
        create_unixtime = 0,           % 创建时的unix时间戳
        creator = 0                    % 创建者（玩家id）
    }).





%% 战斗状态数据
-record(btl_state, {
        id = 0,                % 战斗id

        type = 0,              % 战斗类型(玩家打怪、离线pk、在线pk)
        subtype = 0,           % 战斗子类型

        plot_no = 0,           % 战斗剧情编号

        scene_id = 0,          % 战斗所在场景的id
        scene_type = 0,        % 战斗所在场景的类型

        next_avail_bo_id = ?START_BO_ID,   % 下一个可用的bo id

        cur_bhv_state = ?BHV_WAITING_CLIENTS_FOR_PREPARE_CMD_DONE,  % 战斗自身的当前行为状态，初始化为等待客户端下完指令

        start_time = 0,         % 战斗的开始时间（unix时间戳）

    	round_counter = 1, 			% 当前的回合计数（表示战斗到了第几回合，初始值为1）

        % TODO: 注意： 暂时未考虑组队pvp战斗，以后再拓展和调整！！！
        pvp_player_id_list_host = [],   % pvp战斗中主队玩家的id列表，如果不是pvp战斗，则固定为[]
        pvp_player_id_list_guest = [],  % PVP战斗中客队玩家的id列表，如果不是pvp战斗，则固定为[]

        % hired_player_id_host = ?INVALID_ID,  % 主队方的雇佣玩家的id， 如果没有，则固定为INVALID_ID
        % hired_player_id_guest = ?INVALID_ID,  % 客队方的雇佣玩家的id， 如果没有，则固定为INVALID_ID

        mon_id = ?INVALID_ID,   % 打怪时对应的明雷怪id
        mon_no = ?INVALID_NO,   % 打怪时对应的明雷怪编号
        bmon_group_no = ?INVALID_NO,  % 打怪时对应的战斗怪物组编号
        nth_wave_bmon_group = 0,      % 表示打到第几波怪了（如果不是打怪，固定为默认的0）


        is_finish = false,      % 战斗是否结束了
		win_side = ?NO_SIDE,   % 胜利方（主队？客队？平局？），初始默认为平局
        callback = null,                % 处理战斗反馈时调用的回调函数

        already_handle_battle_finish = false,  % 是否已经做了战斗结束的处理
        host_zf = 0,
        guest_zf = 0,
        limit_task_key = 0 %限时任务的key
	}).



%% bo的技能简要信息
-record(bo_skl_brf, {
			id = 0,   	  			% 技能id
			lv = 0,	  	 			% 技能等级
            cd_over_round = 0       % 技能cd的结束回合（表示到了该回合，cd就结束）
	}).



%% 战斗对象所带的被动效果（学习对应的被动技之后才有） 修改为效果对象根据筛选规则来 2019.9.18 wjc
%% peff: passive effect
-record(bo_peff, {
        eff_no = 0,
        eff_name = null,

        from_skill_id = 0,             % 表示被动效果是从哪个技能而来

        expire_round = 9999,           % 过期的回合数，表示到了该回合，此被动效果即失效，默认为一个很大的数值，表示永不过期

        trigger_proba = 0,             % 触发概率（是一个放大1000倍的整数，概率基数为1000）

        hp_rate_on_revive = 0,         % 复活后的血量百分比
        wait_revive_round_count = 0,   % 等待复活的回合数
        reborn_proba = 0,               % 重生的概率（是一个放大1000倍的整数，概率基数为1000）

        do_phy_dam_scaling_reduce = 0,   % 降低的物理伤害放缩系数
        buff_no = 0,                  % 给目标所加buff的编号
        target_for_add_buff = cur_att_target,   % 加buff的目标（myself：自己，cur_att_target：当前所攻击的目标）或者比较大小的某个值
        op = 0,                            %% 计算类型  3定义为根据规则筛选，其他的按照原来的规则
        rules_filter_target = [],          % 作用目标的筛选规则
        rules_sort_target = [],            % 作用目标的排序规则
        target_count = 0 ,                  % 作用目标个数
        trigger_times = 0,                 % 本场的最大触发次数
        judge_type = 0,                     %% 0代表小于等于，1代表大于等于
        judge_action_moment = 1             %% 123前中后(中后是属于一起的)
        }).

%%{bo_peff,1001,add_buff,205,9999,1000,0,0,0,0,208,myself,0,[],
%%[],0,0,0,0}



-record(buff_eff_para, {
        eff_real_value = 0,    % 用于记录buff的实际效果值1（注意：这个字段主要是用来记录实际增加或减少战斗对象某属性的数值，
                               %       比如：假设某个buff是加百分之xx的物理攻击，那么该字段记录的是实际所加的物理攻击的整数，而不是记录这个百分比，
                               %       以便于buff过期时，还原战斗对象的相应属性值）
        eff_real_value_2 = 0,  % 用于记录buff的实际效果值2

        cur_layer = 0  % 当前的层数，仅针对护盾类buff

  }).


%% 战斗对象身上所带的buff
-record(bo_buff, {
        buff_no = 0,                  % buff编号
        buff_name = null,             %  效果名，如：add_phy_att等

        from_bo_id = ?INVALID_ID,     % 表示buff是由哪个bo所引起的，默认为INVALID_ID
		from_skill_id = ?INVALID_ID,  % 表示buff是由哪个技能所引起的，默认为INVALID_ID

		eff_type = null,  			  % buff效果类型: good（增益） | bad（减益） | neutral（中性）|passi 被动效果buff
		eff_para = #buff_eff_para{},  % 效果参数

		expire_round = 0,   		  % 到期回合（表示到了该回合，buff就过期）
		cur_overlap = 1,		      % buff的当前叠加层数（初始叠加层数默认为1层）
        max_overlap = 1,     	      % buff的最大叠加层数（默认最大层数为1层，即不可叠加）
        need_notify_client = true     % 是否需要通告客户端（即：客户端是否需要显示此buff），有些buff仅用于服务端做逻辑处理，不需要通知客户端，如：使用某些技能后强行休息xx回合
	}).






%% 战斗对象的临时状态（单回合有效的临时状态）
-record(bo_tmp_stat, {
        rand_act_speed = 0,      % 当前回合的乱敏值（有可能为负数）

        phy_att_add = 0,         % 物理攻击加成
        act_speed_add = 0,       % 出手速度加成

        phy_att_reduce_rate = 0,      % 物理攻击降低一定的比例

        force_attack = false,     % 是否强行攻击（强行攻击：当前回合只能执行攻击，而不能执行其他类型的操作）

        force_auto_attack = false,        % 是否强行自动攻击

        is_do_fix_Hp_dam_by_xinfa_lv = false,  % 攻击时是否造成固定的hp伤害（具体伤害值和心法等级相关）
        is_do_fix_Mp_dam_by_xinfa_lv = false,  % 攻击时是否造成固定的mp伤害（具体伤害值和心法等级相关）

        is_do_dam_by_defer_hp_rate_with_limit = false,  % 攻击时，是否伤害值为受击方生命的一定比例，并有一个伤害上限
        do_dam_by_defer_hp_rate_with_limit_para = invalid,

        max_hit_obj_count = 0,            % 单回合中，多目标物理攻击时能打击的对象个数上限
        acc_hit_obj_count = 0,            % 单回合中，多目标物理攻击时，累计当前已经打了多少个对象了

        force_pursue_att_proba = invalid,   % 临时强行设置的追击概率
        force_max_pursue_att_times = invalid, % 临时强行设置的追击次数上限
        force_pursue_att_dam_coef = invalid,   % 临时强行设置的追击伤害系数

        in_phy_combo_att_status = false,  % 是否处于物理连击状态

        force_phy_combo_att_proba = invalid, %%   invalid,              % 临时强行设置的物理连击概率（放大了1000倍）
        force_max_phy_combo_att_times = invalid, %%invalid,             % 临时强行设置的物理连击次数上限

        force_mag_combo_att_proba = invalid,              % 临时强行设置的法术连击概率
        force_max_mag_combo_att_times = invalid,             % 临时强行设置的法术连击次数上限

        force_escape_success_proba = invalid,  % 临时强行设置的逃跑成功的概率

        acc_phy_combo_att_times = 0,     % 当前回合累计已执行的物理连击次数
        acc_mag_combo_att_times = 0,     % 当前回合累计已执行的法术连击次数

        acc_strikeback_times = 0,    % 当前回合累计已反击的次数
        acc_pursue_att_times = 0,       % 当前回合累计已追击的次数

        acc_be_protect_by_buff_times = 0,  % 当前回合累计因buff而受到保护的次数
        kill_target_add_buff = 0 ,         % 当前行动单位本次攻击击杀目标后加BUFF 不是 0则是被动技能效果编号
        select_first_add_buff = 0,         % 为本次技能所首选的单位添加BUFF, 不是 0则是buff编号
        select_first_cause_crit = 0,       % 对本次技能所首选的单位攻击必定造成暴击 1则是暴击
        bo_act_speed = 0                   % 玩家本回合的出手顺序，数值越大越优先
  }).



%% 宠物战斗对象的额外特性
-record(par_bo_extra, {
        cultivate_lv = 0,     % 修炼等级
        cultivate_layer = 0,  % 修炼层数
        evolve_lv = 0,        % 进化等级
        nature = 0,           % 性格
        quality = 0,          % 品质
		awake_illusion = 0	  % 宠物觉醒幻化等级(外形变化之用)
  }).


%% 战斗对象的称号
-record(bo_titles, {
        graph_title    = 0,      % 使用中的图片称号
        text_title     = 0,      % 使用中的文字称号
        user_def_title = <<"">>  % 使用中的自定义称号
  }).


-record(bo_goods_info, {
        goods_id = 0,     % 物品id
        count = 0         % 叠加数量（不可叠加物品固定为1）
    }).


%% 战斗对象
-record(battle_obj, {
        id = 0,                         % 战斗对象id
        parent_obj_id = ?INVALID_ID,    % 战斗对象的父对象的id（玩家bo则对应玩家id，宠物bo则对应宠物id，怪物bo则是对应战斗怪的编号）
        side = 0,                       % 战斗对象所属方（主队？客队？）
        type = 0,                       % 战斗对象类型（玩家？宠物？怪物？boss？）

        pos = 0,                        % 在战场中的位置（1~10）

        parent_partner_no = ?INVALID_NO, % 宠物bo对应的父宠物对象的编号，如果不是宠物bo，则统一为INVALID_NO

        name = <<"无名">>,        % 名字
        sex = 0,                  % 性别
        race = 0,                 % 种族
        faction = 0,              % 门派
        lv = 1,                   % 等级
        gamemoney = 0,            % 银子

        transfiguration_no = 0, % 变身卡编号

        cur_bhv = ?BHV_IDLE,      % 当前行为状态（默认为空闲状态）

        tmp_status = #bo_tmp_stat{},   % 只持续单回合的临时状态

        when_spawn_round = 1,       % 是在第几个回合刷出的？（默认是第1回合）

        is_plot_bo = false,         % 是否为剧情bo（剧情战斗中刷出的剧情bo），默认为false
        can_be_ctrled = false,      % 是否可操控，目前仅针对剧情bo，如果不是剧情bo，则固定为false

        is_cmd_prepared = false,  % 当前回合是否已经下达过指令了？
        is_show_battle_report_done = false, % 是否已经播放当前回合的战报完毕？

        is_online = false,        % 是否在线（武将和怪物固定设置为非在线）
       	is_auto_battle = false,   % 是否自动战斗


        is_just_back_to_battle = false,    % 是否（断线重连后）刚回归战斗？

        is_force_change_to_normal_att = false,  % 当前回合是否被强行转为普通攻击？

        is_main_partner = false,  % 是否为主宠？

        my_main_partner_bo_id = ?INVALID_ID, % 玩家bo对应的主宠bo的id，如果不是玩家，或者没有主宠，则为INVALID_ID
        my_owner_player_bo_id = ?INVALID_ID, % 所属玩家的bo id，目前是用于表明战场上的宠物的归属，对于非宠物bo，统一为INVALID_ID
        my_hired_player_bo_id = ?INVALID_ID, % 玩家bo对应的当前雇佣的玩家bo的id

        my_partner_bo_info_list = [],             % 玩家bo对应的宠物列表， 格式如：[{PartnerBoId, PartnerId}, ...]， 如果不是玩家，或者没有宠物，则为空列表

        my_already_joined_battle_par_id_list = [],  % 玩家的本次战斗中已出战过的宠物id列表

        has_ghost_prep_status = false, % 是否有鬼魂预备状态（针对怪物）
        has_fallen_prep_status = false, % 是否有倒地预备状态（针对伪玩家，如：模仿玩家的怪物）


        die_status = ?DIE_STATUS_LIVING,     % 死亡状态（未死亡？鬼魂？倒地？）

        round_when_die = 0,              % 死亡时的回合数

        bo_ids_already_attacked = [],     % 当前回合已经攻击过的bo id列表


        %%%%phy_combo_att_proba = 0,     % 物理连击概率
        max_phy_combo_att_times = 0,      % 物理连击次数上限

        %%%%mag_combo_att_proba = 0,     % 法术连击概率
        max_mag_combo_att_times = 0,      % 法术连击次数上限

        %%%%pursue_att_proba = 0,  % 追击概率
        max_pursue_att_times = 0, % 追击次数上限

        acc_summon_par_times = 0,  % （本场战斗中）累计已召唤宠物的次数

        dam_reduce_coef_on_pursue_att = 1,   % 追击时的伤害衰减系数（默认为1，表示不衰减）

        dbg_force_fix_dam = invalid,      % 强行设置的固定伤害值（仅仅用于调试！）

        regular_protector_list = [],      % 当前回合的常规保护者列表（bo id列表），常规保护者是指通过下达保护指令来保护我的bo

        he_who_taunt_me = ?INVALID_ID,    % 当前嘲讽我的bo id

        init_attrs = #attrs{},            % 用于记录刚进战斗时各属性的初始值
        attrs = #attrs{},                 % 当前的各属性值

		sendpid = null,  	                % 专用于发送消息给客户端的进程（仅用于玩家bo，非玩家bo则固定为null）

        spouse_bo_id = ?INVALID_ID,     % 配偶bo id，默认为INVALID_ID（表示无配偶或者配偶不在本场战斗中）
        intimacy_with_spouse = 0,       % 和配偶的好友度
        couple_skill_list = [],         % 夫妻技能列表， 形如：[] | #bo_skl_brf{}列表， 默认为空

        passi_effs = [],   % 被动技所带来的被动效果（bo_peff结构体列表）

        xinfa_brief_list = [], % 心法简要信息列表， 仅用于玩家bo，非玩家bo则固定为空列表

        initiative_skill_list = [],   % 主动技能列表， 格式： [] | #bo_skl_brf{}列表
        passi_skill_list = [],   % 被动技能列表， 格式： [] | #bo_skl_brf{}列表
        ai_list = [],      % AI编号列表

        cur_round_talk_ai_list = [],  % 当前回合的对话气泡AI编号列表

		cmd_type = ?CMD_T_NORMAL_ATT,  % 当前回合所下达的指令类型，默认为普通攻击
        cmd_para = 0,            % 当前回合所下达的指令参数（使用技能时则为对应的技能id，使用物品时则为对应的物品id，其他情况下无意义，统一为0）


        cur_skill_brief = null,  		% 当前所选择使用的技能，null | bo_skl_brf结构体
        cur_goods = 0,     		% 当前使用的物品id

        last_pick_target = 0,                 % 上一个回合所选的目标bo id
        cur_pick_target =0,  %%target_bo_id = 0,     % 下达回合指令时所选定的目标bo id（攻击或施法的目标）
        cur_att_target = 0,   % 记录当前所攻击的目标bo id， 可用于连击过程中暂停后恢复时，继续打原先的攻击目标

        %%% pos_in_team_troop = 0, 	% 玩家在队伍阵法中的位置（1~9）

        buffs = [],     	% 战斗对象的buff列表（bo_buff结构体列表）

        showing_equips = #showing_equip{},

        par_extra = null,   % 宠物的额外特性，如果是宠物，则为par_bo_extra结构体，否则，固定为null

        look_idx = 1, % 外观参考造型

        suit_no = 0,            % 套装编号
        titles = #bo_titles{},  % 称号
        goods_info_list = [],    % 物品信息列表（仅仅是为了辅助实现战斗中使用物品的功能），格式如：[] | bo_goods_info结构体列表
        reborn_count = 0,        % 重生次数（玩家单场战斗重生次数不超过3次）
        bmon_group_no = 0 ,      % 所属战斗怪物组的编号，计算阵法时用到
        five_elements = {0,0},    %五行属性以及等级
        eff_buff_name = []        %五行生效的buff名，只用于清除buff效果时使用，热buff也会存在这里使用
     }).









%% wb: world boss
-record(wb_mf_info, {
        boss_no = 0,   % 世界boss对应的明雷怪编号
        init_hp = 0,   % 世界boss的初始血量
        left_hp = 0,   % 世界boss的剩余血量
        init_player_id_list = [],  % 战斗初始时的玩家id列表（不包含雇佣的玩家）
        left_player_id_list = [],  % 战斗结束时剩余的玩家id列表（不包含雇佣的玩家）
        hired_player_id_list = []  % 雇佣的玩家id列表
    }).


%% 战斗结束后的反馈信息
-record(btl_feedback, {
			player_id = 0,			 % 玩家id
            side = 0,                % 玩家所属方（主队？客队？），对于pk：主动发起pk的一方固定在主队，被动接受pk的一方固定在客队

			battle_type = 0,		 % 战斗类型
			battle_subtype = 0,	     % 战斗子类型

            result = lose,   		 % 战斗结果（win：赢了，lose：输了, draw: 平局）
    		left_hp = 0,   		     % 玩家的剩余血量
            left_mp = 0,             % 玩家的剩余蓝量
    		% left_anger = 0,       % 玩家的剩余怒气值

            nth_wave_bmon_group = 0, % 表示打到第几波怪了（如果不是打怪，固定为默认的0）

            lasting_rounds = 0,   % 战斗持续的回合数
            lasting_time = 0,     % 战斗持续的时间（单位：秒）
            my_side_dead_player_count = 0,   % 战斗结束时我方死亡的玩家数

            oppo_player_id_list = [],    % 对手（玩家）的id列表，如果不是PVP，则固定为[]
            hired_player_id = ?INVALID_ID,  % 出战的雇佣玩家的id，如果没有，则固定为INVALID_ID

            teammate_id_list = [],        % 队友的玩家id列表（不包括已逃跑的队友）

            shuffled_team_mb_list = [],   % 随机序列化过的队伍成员id列表（用于配合实现打怪时的掉落规则）
            spawned_bmon_list = [],     % 战斗中已刷出的战斗怪，格式：[{战斗怪编号, 战斗怪数量}, ...]

            mon_id = ?INVALID_ID,           % 所打明雷怪的id，如果不是打明雷怪，则为INVALID_ID
            mon_no = ?INVALID_NO,           % 所打明雷怪的编号，如果不是打明雷怪，则为INVALID_NO
            bmon_group_no = ?INVALID_NO,    % 所打的战斗怪物组编号，如果不是打怪，则为INVALID_NO
            mon_left_can_be_killed_times = 0, % 明雷怪的剩余可被杀死次数，如果不是打明雷怪，则固定返回0
		      	partner_info_list = [],		% 玩家的实际出战的宠物的反馈信息列表，格式如：[] | [{宠物id, 剩余血量，剩余蓝量}, ...]

            world_boss_mf_info = null,       % 世界boss战斗的信息，如果不是世界boss战斗，则为null，否则，为wb_mf_info结构体

            callback = null ,% 处理战斗反馈时调用的回调函数
            guild_boss_hp = 0
			}).





%% 返回给客户端的技能信息
-record(skl_resp_info, {
			id = 0,   	  			% 技能id
			lv = 0,	  	 			% 技能等级
			grid = 0,		  		% 技能的格子位置
			is_can_use = false, 	% 当前是否可使用
			cd_left_round = 0,      % 当前的cd剩余回合数
			cfg_cd_round = 0    	% 配置数据：cd回合数
	}).




%% 已收集的战报（cbrs：collected battle reports）
-record(cbrs, {
        cur_actor_id = ?INVALID_ID,       % 当前行动者的id（战斗对象id）

        cmd_type = ?CMD_T_INVALID,           % (行动的)指令类型
        cmd_para = null,        % 指令参数（若为使用技能，则表示技能id， 若为使用物品，则表示物品id）

        real_cmd_type = ?CMD_T_INVALID,   % 实际所执行的指令的类型
        real_cmd_para = null,             % 实际所执行的指令的参数

        %%cmd_para2 = null,         % 指令参数2（备用）
        cur_pick_target = 0,        % 行动者当前回合所选定的目标bo id
        report_list = []            % 战报列表，战报通常是当前行动者的行为信息（boa_xxx结构体）
  }).




%% 战斗提示
-record(btl_tips, {
        to_bo_id = 0,   % 所针对的bo id
        tips_code = 0,  % 提示信息代号
        para1 = 0,      % 参数1
        para2 = 0       % 参数2
  }).



%% 战报：发送提示信息(br: battle report)
-record(br_send_tips, {
        tips = #btl_tips{}
        % tips_code = 0,  % 提示信息代号
        % para1 = 0,      % 参数1
        % para2 = 0       % 参数2
  }).



%% 重生详情(reborn details)
-record(reborn_dtl, {
        is_reborn_applied = false, % 是否应用了重生（true | false）
        new_hp = 0                 % 重生后的血量
  }).

%% 溅射模式配置表
-record(splash_pattern, {
        no = 0          % 模式编号
        ,pos_1 = []     % 目标位置为1 (这里的1是策划心目中的1，下同)
        ,pos_2 = []     % 目标位置为2
        ,pos_3 = []     % 目标位置为3
        ,pos_4 = []     % 目标位置为4
        ,pos_5 = []     % 目标位置为5
        ,pos_6 = []     % 目标位置为6
        ,pos_7 = []     % 目标位置为7
        ,pos_8 = []     % 目标位置为8
        ,pos_9 = []     % 目标位置为9
        ,pos_10 = []    % 目标位置为10
    }).

%% 溅射伤害详情
-record(splash_dtl, {
        defer_id = 0,                           % 防守者（即：被溅射者）的bo id
        dam_val_hp = 0,                         % 对防守者的伤害值（伤血）
        dam_val_mp = 0,                         % 对防守者的伤害值（伤蓝）
        dam_val_anger = 0,                      % 对防守者的伤害值（减少怒气，负数表示增加怒气）
        defer_hp_left = 0,                      % 防守者的剩余血量
        defer_mp_left = 0,                      % 防守者的剩余蓝量
        defer_anger_left = 0,                   % 防守者的剩余怒气
        defer_die_status = ?DIE_STATUS_LIVING,  % 防守者的死亡状态，默认为未死亡
        defer_buffs_removed = [],               % 防守者移除的buff列表（如：因被溅射导致死亡，从而移除的buff）
        reborn_dtl = #reborn_dtl{}              % 重生详情
    }).

%% 物理伤害详情(phy damage details)
-record(phy_dam_dtl, {
        atter_id = 0,             % 攻击者的bo id
        defer_id = 0,             % 防守者的bo id
        protector_id = 0,         % 保护者的bo id，如果没有保护者，则统一为0

        % att_result = 0,           % 攻击结果（命中， 闪避，暴击。。）

        dam_to_defer = 0,         % 对防守者的伤害值
        dam_to_defer_mp = 0,      % 对防守者的伤害值（伤蓝）
        dam_to_defer_anger = 0,
        dam_to_protector = 0,     % 对保护者的伤害值
        dam_to_protector_anger = 0,% 对保护者的伤害值(怒气，血减少怒气增加)
        ret_dam = 0,              % 反弹的伤害值
        ret_dam_anger = 0,        % 反弹的怒气变化
        absorbed_hp = 0,          % 攻击者吸血的数值（如果没有吸血，则为0）

        atter_hp_left = 0,        % 攻击者的剩余血量
        atter_mp_left = 0,        % 攻击者的剩余魔法（连击时可能会消耗魔法）
        atter_anger_left = 0,     % 攻击者的剩余怒气（连击时可能会消耗怒气）
        atter_die_status = ?DIE_STATUS_LIVING,  % 攻击者的死亡状态，默认为未死亡
        is_atter_apply_reborn = false,        % 攻击者是否应用了重生效果

        defer_hp_left = 0,        % 防守者的剩余血量
        defer_mp_left = 0,        % 防守者的剩余魔法
        defer_anger_left = 0,     % 防守者的剩余怒气
        defer_die_status = ?DIE_STATUS_LIVING,  % 防守者的死亡状态，默认为未死亡
        is_defer_apply_reborn = false,        % 防守者是否应用了重生效果

        protector_hp_left = 0,    % 保护者的剩余血量，如果没有保护者，则统一为0
        protector_anger_left = 0,    % 保护者的剩余血量，如果没有保护者，则统一为0
        protector_die_status = ?DIE_STATUS_LIVING,  % 保护者的死亡状态，默认为未死亡
        is_protector_apply_reborn = false,        % 保护者是否应用了重生效果

        atter_buffs_added = [],   % 攻击者新增的buff列表（通常是增益buff）
        atter_buffs_removed = [], % 攻击者移除的buff列表

        defer_buffs_added = [],   % 防守者新增的buff列表（通常是减益buff）
        defer_buffs_removed = [], % 防守者移除的buff列表（通常只能是护盾类的buff）
        defer_buffs_updated = [], % 防守者更新的buff列表（比如某护盾的的可受击次数减少了一次）

        protector_buffs_removed = [], % 保护者移除的buff列表（通常是因死亡而导致移除的buff）

        additional_eff = [] , %% 场上玩家受到伤害或回血 additional_dtl结构体列表

        splash_dtl_list = []          % 溅射伤害详情列表，格式如：[] | splash_dtl结构体列表
  }).


%场上玩家受到伤害或回血
-record(additional_dtl, {
        boid = 0,
        type = 0,
        dam_hp = 0,
        bo_hp_left = 0,
        be_bo_dieStatus =0,
        be_bo_is_apply_reborn =0
}).


%% 伤害子详情(damage sub details) ，
%% 注: 以后可以考虑抽取出buff_chg_dtl结构体，用于专门表示buff的更改信息 (buff changing details)
-record(dam_sub_dtl, {
    atter_buffs_added = [],
    atter_buffs_removed = [],

    defer_buffs_added = [],
    defer_buffs_removed = [],
    defer_buffs_updated = [],

    dam_to_mp = 0,   % 伤蓝数值
    dam_to_anger = 0,% 减少怒气值
    splash_dtl_list = []  % 溅射伤害详情列表，格式如：[] | splash_dtl结构体列表
  }).


%% 反弹伤害的详情
-record(ret_dam_dtl, {
        dam_returned = 0,  % 反弹的伤害值
        dam_returned_anger = 0  % 反弹的伤害值 (怒气)
  }).


%% 死亡详情
-record(die_details, {
        bo_id = ?INVALID_ID,
        buffs_removed = [],

        die_status = ?DIE_STATUS_LIVING  % 死亡状态（参看battle.hrl中的宏DIE_STATUS_XXX），默认为未死亡

        % 如有必要，添加其他字段。。
        % ...
  }).


%% 保护详情(protection details)
-record(protection_dtl, {
        protector_id = ?INVALID_ID,       % 保护者的bo id， 若没有保护者则统一为?INVALID_ID
        dam_shared = 0,         % 保护者分担的伤害值
        dam_anger = 0,          % 保护者获得的怒气（负数表示获得）
        % dam_left = 0,           % 剩余的伤害值

        protector_hp_left = 0,  % 保护者的剩余血量，若没有保护者则统一为0
        protector_anger_left = 0,  % 保护者的剩余怒气，若没有保护者则统一为0
        protector_die_status = ?DIE_STATUS_LIVING,  % 保护者的死亡状态，默认为未死亡
        protector_buffs_removed = [],  % 保护者移除的buff列表（通常是因死亡而导致移除的buff）

        reborn_dtl = #reborn_dtl{}
  }).






%% 减轻伤害的详情
-record(reduce_dam_dtl, {
        dam_reduced = 0,            % 减轻的伤害值
        dam_left = 0,               % 剩余的伤害值
        defer_buffs_removed = [],   % 防守者移除的buff列表（目前涉及的是护盾类buff）
        defer_buffs_updated = []    % 防守者更新的buff列表（目前涉及的是护盾类buff）
        }).



%% 受到攻击时增加一定mp的详情
-record(absorb_dam_to_mp_dtl, {
        mp_added = 0,        % 防守者所增加的mp
        buffs_removed = [],   % 防守者移除的buff列表（目前涉及的是护盾类buff）
        buffs_updated = []    % 防守者更新的buff列表（目前涉及的是护盾类buff）
        }).



%% 驱散buff的详情
-record(purge_buffs_dtl, {
        atter_buffs_removed = [],   % 攻击者移除的buff列表
        defer_buffs_removed = []    % 防守者移除的buff列表（通常是增益buff）
        }).

%% 新加buff的详情
-record(add_buffs_dtl, {
        atter_buffs_added = [],     % 攻击者新加的buff列表
        defer_buffs_added = []      % 防守者新加的buff列表（通常是减益buff）
    }).

%% buff筛选规则新增或者移除
-record(update_buffs_rule_dtl, {
        bo_id = 0,
        atter_buffs_removed = [],   % 移除的buff列表
        atter_buffs_added = []    % 攻击者新加的buff列表
}).


%% 应用不死效果的详情
-record(apply_undead_eff_dtl, {
        buffs_removed = [],   % 移除的buff列表
        buffs_updated = []    % 更新的buff列表
        }).


% 废弃！
% %% 执行攻击的描述
% -record(do_att_desc, {  % old name: do_dam_desc
%         att_type = 0,
%         att_subtype = 0,
%         att_result = 0,
%         dam_details = #dam_details{}
%   }).






%% boa: battle object's action 战斗对象的行为

%% boa： 执行物理攻击
-record(boa_do_phy_att, {
      att_type = ?ATT_T_PHY,    % 固定为物理攻击
      att_subtype = 0,          % 此次攻击的所属子类型 => 0：无意义，1: 普通攻击，2：反击，3：连击，4：追击
      att_result = 0,           % 攻击结果（命中？闪避？暴击？）
      dam_details = #phy_dam_dtl{}

      % atter_id = 0,             % 攻击者的bo id
      % defer_id = 0,             % 防守者的bo id
      % protector_id = 0,         % 保护者的bo id，如果没有保护者，则统一为0

      % dam_to_defer =  0,        % 对防守者的伤害值
      % dam_to_protector = 0,     % 对保护者的伤害值
      % ret_dam = 0,              % 反弹的伤害值

      % atter_buffs_added = [],   % 攻击者新增的buff列表（通常是增益buff）

      % defer_buffs_added = [],   % 受击者新增的buff列表（通常是减益buff）
      % defer_buffs_removed = [], % 受击者移除的buff列表（通常只能是护盾类的buff）

      % atter_hp_left = 0,        % 攻击者的剩余血量
      % atter_mp_left = 0,        % 攻击者的剩余魔法（连击时可能会消耗魔法）
      % atter_anger_left = 0,     % 攻击者的剩余怒气（连击时可能会消耗怒气）

      % defer_hp_left = 0,        % 防守者的剩余血量
      % defer_mp_left = 0,        % 防守者的剩余魔法

      % protector_hp_left = 0     % 保护者的剩余血量，如果没有保护者，则统一为0
  }).


%% 法术伤害详情(magic damage details)
-record(mag_dam_dtl, {
        atter_id = 0,             % 攻击者的bo id
        defer_id = 0,             % 防守者的bo id

        att_result = 0,           % 攻击结果（命中？闪避？暴击？）
        dam_to_defer = 0,         % 对防守者的伤害值
        dam_to_defer_mp = 0,      % 对防守者的伤害值(伤蓝)
        dam_to_defer_anger = 0,   % 对防守者的伤害值(怒气)
        absorbed_hp = 0,          % 攻击者吸血的数值（如果没有吸血，则为0）
        atter_hp_left = 0,        % 攻击者的剩余血量
        atter_mp_left = 0,        % 攻击者的剩余魔法（连击时可能会消耗魔法）
        atter_anger_left = 0,     % 攻击者的剩余怒气（连击时可能会消耗怒气）
        atter_die_status = ?DIE_STATUS_LIVING,  % 攻击者的死亡状态，默认为未死亡
        is_atter_apply_reborn = false,      % 是否应用重生

        ret_dam = 0,
        ret_dam_anger = 0,

        defer_hp_left = 0,        % 防守者的剩余血量
        defer_mp_left = 0,        % 防守者的剩余魔法
        defer_anger_left = 0,     % 防守者的剩余怒气
        defer_die_status = ?DIE_STATUS_LIVING,  % 防守者的死亡状态，默认为未死亡
        is_defer_apply_reborn = false,        % 防守者是否应用了重生效果
        absorbedhp = 0,


        atter_buffs_added = [],   % 攻击者新增的buff列表（通常是增益buff）
        atter_buffs_removed = [], % 攻击者移除的buff列表

        defer_buffs_added = [],   % 防守者新增的buff列表（通常是减益buff）
        defer_buffs_removed = [], % 防守者移除的buff列表（通常只能是护盾类的buff）
        defer_buffs_updated = [], % 防守者更新的buff列表（比如某护盾的的可受击次数减少了一次）
        additional_eff = [] , %% 场上玩家受到伤害或回血 additional_dtl结构体列表
        splash_dtl_list = []      % 溅射伤害详情列表，格式如：[] | splash_dtl结构体列表
  }).

%% boa： 执行法术攻击
-record(boa_do_mag_att, {
      att_type = ?ATT_T_MAG,    % 固定为法术攻击
      is_combo_att = false,     % 此次攻击是否为连击（true | false）
      atter_id = 0,             % 攻击者的bo id
      dam_dtl_list = []         % 伤害详情列表，格式为mag_dam_dtl结构体列表

  }).




%% 处理受击时所触发的事件的详情
-record(on_be_dam_dtl, {
        buffs_removed = []   % 移除的buff编号列表
    }).



%% 处理攻击命中时所触发的事件的详情
-record(on_hit_success_dtl, {
        atter_buffs_added = [],     % 攻击者新加的buff编号列表
        atter_buffs_removed = [],   % 攻击者移除的buff编号列表

        defer_buffs_added = [],     % 防守者新加的buff编号列表
        defer_buffs_removed = [],   % 防守者移除的buff编号列表
        dam_to_defer = 0,           % 对防守者的伤害值
        dam_to_anger = 0            % 防守者怒气减少
    }).



%% 释放或驱散buff的详情(cast buffs details)
-record(cast_buffs_dtl, {
        caster_id = 0,          % 施法者的bo id
        target_bo_id = 0,       % 施法目标（目标有可能是施法者自己）
        buffs_added = [],       % 目标新加的buff编号列表
        buffs_removed = [],     % 目标移除的buff编号列表
        buffs_updated = []      % 目标更新的buff编号列表   % 注: 这里目前实际上不存在buff更新的情况，不过以后或许会有
  }).


%% boa： 施法（释放或驱散buff）
-record(boa_cast_buffs, {  % rename to a better name??
        caster_id = 0,            % 施法者的bo id
        cast_result = ?RES_FAIL,  % 施法结果：成功？失败？
        need_perf_casting = true,  % 客户端是否需要做对应的施法表现？ 默认为是
        caster_hp_left = 0,       % 施法者的剩余血量
        caster_mp_left = 0,       % 施法者的剩余蓝量
        caster_anger_left = 0,    % 施法者的剩余怒气
        details_list = []         % 详情列表：[] | cast_buffs_dtl结构体列表
  }).



%% boa： 逃跑
-record(boa_escape, {
        bo = null,           % 逃跑者bo
        result = ?RES_FAIL   % 逃跑结果：成功？失败？
  }).



% %% 治疗的详情(cast heal details)
% -record(cast_heal_dtl, {
%         caster_id = 0,          % 施法者的bo id
%         target_bo_id = 0,       % 施法目标（目标有可能是施法者自己）
%         hp_new = 0,             % 目标新的血量
%         mp_new = 0              % 目标新的魔法值
%   }).

%% 治疗详情
-record(heal_dtl, {
        target_bo_id = 0,  % 治疗的目标
        % heal_result = ?RES_FAIL,   % 对目标的治疗结果（成功？失败？），目标处于某些特殊状态时，无法被治疗

        is_cannot_be_heal = false, % 目标是否无法被治疗？

        heal_value = 0,    % 治疗量

        new_hp = 0,        % 目标新的血量
        new_mp = 0,         % 目标新的蓝量
        new_anger = 0,       % 目标新的怒气
        buffs_added = [],    % 目标新加的buff列表
        buffs_removed = []   % 目标移除的buff列表
  }).


%% boa：治疗
-record(boa_heal, {
        has_revive_eff = false,    % 是否附带复活效果
        heal_type = 0,             % 治疗类型（1：加血，2：加蓝，3：加血加蓝）
        cast_result = ?RES_FAIL,   % 施法结果（0：成功，1：失败）
        healer_hp_left = 0,        % 治疗者的剩余血量
        healer_mp_left = 0,        % 治疗者的剩余蓝量
        healer_anger_left = 0,     % 治疗者的剩余怒气
        details_list = []          % 治疗详情列表，格式为：[] | heal_dtl结构体列表
  }).







% %% 复活的详情(cast revive details)
% -record(cast_revive_dtl, {
%         caster_id = 0,          % 施法者的bo id
%         target_bo_id = 0,       % 施法目标（目标有可能是施法者自己）
%         hp_new = 0,             % 目标新的血量
%         mp_new = 0              % 目标新的魔法值
%         % 其他...
%   }).

% %% boa： 施法（复活）
% -record(boa_cast_revive, {
%         caster_id = 0,               % 施法者的bo id
%         cast_result = ?RES_FAIL,     % 施法结果：成功？失败？
%         details_list = []            % 详情列表：[] | cast_revive_dtl结构体列表
%   }).




%% 使用物品的详情
-record(use_goods_dtl, {
        goods_id = 0,           % 所使用物品的id
        goods_no = 0,           % 所使用物品的编号
        target_bo_id = 0,       % 目标bo id

        %%% eff_type_list = [],     % 物品效果类型列表，类型有： 1: 加血，2：加蓝，3：加怒气，4：加血并加蓝，5：复活并加血，6：复活并加血加蓝，7：加buff

        heal_val_hp = 0,        % 治疗量（hp），用于客户端做显示
        heal_val_mp = 0,        % 治疗量（mp），用于客户端做显示
        heal_val_anger = 0,     % 治疗量（怒气），用于客户端做显示
        has_revive_eff = false,

        hp_added = 0,           % 实际所加的血量
        mp_added = 0,           % 实际所加的蓝量
        anger_added = 0,        % 实际所加的怒气值

        hp_new = 0,             % 目标新的血量
        mp_new = 0,             % 目标新的蓝量
        anger_new = 0,          % 目标新的怒气值

        buffs_added = [],       % 目标新加的buff列表
        buffs_removed = [],      % 目标移除的buff列表

        buffs_added_myself = [], % 自己新加的buff列表
        buffs_removed_myself = []% 自己移除的buff列表
    }).


%% boa：使用物品
-record(boa_use_goods, {
        actor_id = 0,               % 行动者（使用物品者）的bo id
        % goods_id = 0,               % 物品id
        % target_bo_id = 0,           % 目标bo id
        details = #use_goods_dtl{}  % 详情，为use_goods_dtl结构体
  }).





%% 强行死亡的详情
-record(force_die_dtl, {
        bo_id = 0,          % 强行死亡的bo id
        die_status = 0,     % 死亡状态
        buffs_removed = []  % 移除的buff列表
  }).

%% boa： 一或多个bo强行死亡
-record(boa_force_die, {
        details_list = []    % 详情列表：[] | force_die_dtl结构体列表
  }).



%% 召唤详情
-record(summon_dtl, {
        new_bo_id_list = []            % 新召唤出的bo id列表

        % 其他。。。
  }).


%% boa：召唤
-record(boa_summon, {
        actor_id = 0,            % 召唤者bo id
        result = ?RES_FAIL,      % 召唤结果：成功？失败？
        details = #summon_dtl{}  % 召唤详情（summon_dtl结构体）
  }).





%% 在线对离线战斗的离线方的属性加成(o2o: online to offline)
-record(o2o_bt_add_attrs, {
        bt_type_code = 0,
        do_phy_dam_scaling = 0,
        do_mag_dam_scaling = 0,
        be_phy_dam_reduce_coef = 0,
        be_mag_dam_reduce_coef = 0,
        be_heal_eff_coef = 0,
        act_speed_rate = 0,
        seal_hit_rate = 0,
        seal_resis_rate = 0
        }).


%% 好友度对应的触发保护的概率
-record(prote_proba_by_intimacy, {
        intimacy = 0,
        protect_proba = 0
    }).



% br_add_buff_by_skl


% br_del_buff_by_skl


% br_heal_by_skl


% br_revive


% br_summon


% br_normal_att


% br_skill_att



% br_use_goods


% br_capture_partner


% br_escape


% br_buff_expired  % -  buff 自然过期
















-endif.  %% __BATTLE_RECORD_H__
