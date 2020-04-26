%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.10.13
%%% @doc 女妖选美 抽奖活动 头文件.
%%% @end
%%%------------------------------------

-ifndef(__BEAUTY_CONTEST_H__).
-define(__BEAUTY_CONTEST_H___, 0). 

%% 活动Id
-define(ACTID, 10).

%% 抽奖活动统计字典
-define(BEAUTY_CONTEST_DATA, beauty_contest_data_dict).
-define(COUNTER(ActId), {activity_gamble_counter, ActId}).

%% 抽奖面板系统重置周期
-define(BEAUTY_CONTEST_RESET_TIME, 21600). % 6×3600 = 21600
%% 大奖发放周期
-define(BEAUTY_CONTEST_BIG_REWARD_TIME, 86400). % 24*3600+0*60 = 24:00 
%-define(BEAUTY_CONTEST_BIG_REWARD_TIME, 15*3600+35*60).


%% 女妖选美配置信息
-record(data_beauty_contest, {
        no = 0              % 抽奖编号
        ,lv_limit = {0,0}   % 等级限制
        ,reward_bags= []    % 奖励包列表 {BagNo, Weight}
        ,cost_goods = {0,0} % 抽奖消耗道具基础值
        ,cost_byuanbao = 0  % 抽奖消耗绑金基础值
        ,cost_reset = 0     % 重置面板消耗数量
    }).

%% 抽奖奖励包配置信息
-record(data_beauty_contest_reward_bag, {
        bag_no = 0                          % 奖励包编号
        ,very_expensive_reward_goods = []   % 非常珍贵的奖励包列表
        ,very_expensive_reward_num = []     % 非常珍贵的奖励包抽取随机数量
        ,expensive_reward_goods = []        % 珍贵的奖励包列表
        ,expensive_reward_num = []          % 珍贵的奖励包抽取随机数量
        ,normal_reward_goods = []           % 普通的奖励包列表
        ,normal_reward_num = []             % 普通的奖励包抽取随机数量
        ,very_normal_reward_goods = []      % 非常普通的奖励包列表 （抽取数量=总抽取数量-上面3个随机数量）
        ,all_reward_num = 0                 % 总抽取数量
        ,bind = 0           % 绑定标识
    }).

%% 玩家抽奖信息
-record(beauty_contest_info, {
        no = 0                  % 当前抽奖编号
        ,last_reset_time = 0    % 上次刷新时间
        ,bag_no = 0             % 奖励包Id
        ,goods_info = []        % 抽奖信息 #beauty_contest_goods{}
    }).

%% 抽奖奖励物品信息
-record(beauty_contest_goods, {
        no = 0          % 位置（唯一标识）
        ,goods_id = 0   % 物品Id
        ,num = 0        % 数量
        ,quality = 1    % 品质
        ,bind = 0       % 是否绑定（0绑定 1非绑定）
        ,get_flag = 0   % 是否领取（0未领取 1已领取）
        ,weight = 0     % 抽奖随机权重
    }).

%% 女妖选美活动状态信息
-record(ets_beauty_contest_status, {
        id = 0                          % 唯一键（活动Id）
        ,open_status = 0                % 开启状态（0未开启 1开启）
        ,import_goods_record = []       % 重要物品公告板 {PlayerName, GoodsNo, Num}
        ,big_reward_goods = 0           % 超级大奖奖励
        ,lucky_reward_goods = 0         % 幸运奖奖励
        ,email_content = <<>>
        ,email_title = <<>>
    }).

-endif. % __BEAUTY_CONTEST_H__
