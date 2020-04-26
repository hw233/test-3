%%%------------------------------------------------
%%% File    : reward.hrl
%%% Author  : huangjf
%%% Created : 2013.11.4
%%% Description: 奖励相关的宏定义
%%%------------------------------------------------

% 避免头文件多重包含
-ifndef(__REWARD_H__).
-define(__REWARD_H__, 0).




%% 奖励包
-record(reward_pkg, {
		no = 0,             % 奖励包编号
                goods_rule = 0,
                source_type = 0,    %
		money = null,       % 奖励的金钱信息， 没有则为null，下同
		exp = null,         % 奖励的经验信息
                vip_exp = null,     % vip成长值
		talents = null,     % 奖励的天赋属性信息
		goods_list = null,      % 奖励的物品列表
                condition = [],         % 根据种族和性别给予额外物品的条件
                goods_added = [],       % 根据种族和性别给予的物品 与condition是一一对应的关系
                extra_reward = null,
                mind_lv = null,
                train_point = null,
                contribute = null,
                score = null,
                life_skill_proficiency = null,
                ratio_of_par_get = 0,                   % 副宠获得经验是主宠、人物的比例
                sys_activity_times = null
	}).


%% 奖励包常量
-record(reward_con, {
        no = 0,              % 奖励包编号
        player_coef = 0,     % 玩家经验奖励系数
        par_coef = 0,        % 宠物经验奖励系数
        coef_a = [],         % 系数A
        coef_b = [],         % 系数B
        constant_c = [],     % 常数C
        ring_add_coef = [],  % 环数增益系数
        round_add = [],      % 增益持续的轮数
        round_add_coef = [], % 初始的增益系数
        round_dec_coef = [], % 增益递减
        buff = [],           % 是否受玩家buff影响
        coef_time = 0,        % 时间系数
        lv_need = []
}).

%% 奖励详情reward detail
-record(reward_dtl, {
        goods_list = [], % 保存{GoodsId, GoodsNo, GoodsCount} 元组列表 已经发给玩家的
        calc_goods_list = []    % 保存{GoodsNo, GoodsCount, Quality, BindState, NeedBroadcast} 元组列表 根据奖励编号计算出来的奖励列表，还没有发给玩家的
        % 其他， 以后拓展
        }).


%% 每日签到与在线奖励配置数据结构体
-record(day_reward_cfg, {
        no = 0,
        type = 0,
        reward_no = 0,
        condition = 0,
        precondition = 0
        }).


-record(data_reward_cfg_1, {
        no = 0,
        goods_no = 0,
        goods_count = 0,
        bind_gold = 0,
        bind_silver = 0
        }).


%% 玩家每日签到与在线奖励
-record(day_reward, {
        player_id = 0,
        is_dirty = false,               %% 是否是脏数据
        sign_info = 0,                  %% 整数的低31位（二进制位），分别对应本月的签到情况，1表示当天有签到，0表示当天没有签到，从右边算起
        sign_reward_info = 0,           %% 整数的低31位（二进制位），分别对应本月签到n次的奖励情况，右边算起第n位是1表示签到n次的奖励已经领取，0表示还没有领取
        last_sign_time = 0,             %% 上次签到时间
        cur_no = 0,                     %% 当前奖励编号 可能是可以领取的，也可能是还不能领取的，客户端根据上次领取时间，判断是否可以领取了,如果已经领完了当天的奖励，则为0
        last_get_reward_time = 0,       %% 上次领取在线奖励时间
        seven_day_reward = 0,           %% 整数的低7位（二进制位），对应创号7天礼包的领取情况，0表示还没有领取，1表示已经领取
        lv_reward_no_list = []          %% 已经领取的等级奖励编号列表
        }).


%% 冲级奖励
-record(lv_reward, {
        no = 0,
        lv = 0,
        reward_no = 0
        }).


-record(data_reward_pool, {
                no         = 0,
                goods_pools= 0,
                prob       = 0,
                reward_bag = 0,
                period     = 0,
                renews     = []
}).

%% 持久化, 小心改动
-record(reward_pool, {
                no         = 0,
                stock      = 0,
                gid        = 0,
                quality    = 0,
                bind_state = 0,
                period     = 0,
                charged    = 0,
                next       = 0,
                data_reward_goods_id = 0,
                ext        = [],
                ext2       = 0
}).

-record(data_reward_goods, {
                no         = 0,
                good_no    = 0,
                bind_state = 0,
                quality    = 0,
                limit      = 0,
                need_broadcast = 0
}).

-record(data_cumulative_login_reward,	{
		no = 1,
		goods_no = [{89061}]
}).

-define(LV_PLAYER, 1).                             % 角色等级
-define(LV_TEAM_AVE, 2).                           % 队伍平均等级
-define(LV_TEAM_MAX, 3).                           % 队伍最大等级
-define(LV_TEAM_MIN, 4).                           % 队伍最低等级
-define(LV_ENEMY_AVE, 5).                          % 敌方平均等级
-define(LV_MON_AVE, 6).                            % 怪物平均等级
-define(LV_GUILD, 7).                              % 帮派等级
-define(LV_FARM, 8).                               % 农场等级
-define(LV_PARTNER, 9).                            % 宠物等级
-define(LV_PAR_AVE, 10).                           % 宠物平均等级
-define(LV_TASK, 11).                              % 任务等级
-define(VALUE_TOTAL_CONTRI, 12).                   % 总帮贡
-define(VALUE_LOGIN_CONTINU, 13).                  % 连续登陆天数
-define(VALUE_RANK_LADDER, 14).                    % 天梯排名
-define(VALUE_TOWER_FLOOR, 15).                    % 爬塔所在层数
-define(VALUE_RECOMMEND_BATTLE_POWER, 16).         % 当前层数推荐战力-角色战力
-define(VALUE_DEFAULT, 17).                        % 17 默认数值1 还需要调整


-endif.  % __REWARD_H__
