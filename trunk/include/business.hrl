%%%------------------------------------------------
%%% File    : business.hrl
%%% Author  : 段世和
%%% Created : 2015-07-06
%%% Description: 商会交易系统的相关宏
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__BUSINESS_H__).
-define(__BUSINESS_H__, 0).

% 商会配置结构体
-record(data_business_config, {
        no = 0,                                 %  物品编号
        bind_state = 0,                         %  绑定状态
        init_num = 0,                           %  初始数量
        type = 0,                               %  类型
        sub_type = 0,                           %  子类型
        refresh_num = 0,                        %  刷新增加数量
        refresh_cycle = 0,                      %  更新周期
        refresh_time = [],                      %  更新时间
        buy_count_limit = 0,                    %  个人限制购买次数
        global_buy_count_limit = 0,             %  全局限制购买次数
        sell_count_limit = 0,                   %  个人限制出售次数
        global_sell_count_limit = 0,            %  全局限制出售次数
        price_type = 0,                         %  价格类型
        price = 0,                              %  价格
        extent = 0                              %  幅度
    }).

% 商会配置持久化结构体
-record(business_server_persistence, {
        no = 0,                                 %  配置no
        version = 0,                            %  当前更新的版本，每次更新+1
        sell_count = 0,                         %  当前版本出售了多少个
        buy_count = 0,                          %  当前版本回收了多少个
        total_sell_count = 0,                   %  累计出售了多少个
        total_buy_count = 0,                    %  累计回收了多少个
        stock = 0                               %  当前库存
    }).


% 商会配置持久化结构体，存储于玩家表的
-record(business_player_persistence, {
        no = 0,                                 %  配置no
        version = 0,                            %  当前更新的版本，每次更新+1，如果玩家表中的版本号低于服务器版本则更新状态
        sell_count = 0,                         %  当前版本出售了多少个
        buy_count = 0                           %  当前版本回收了多少个
    }).

-record(data_guild_shop, {
        id = 1,
        shop_no = 1,
        goods_no = 59002,
        count_limit = 200,
        price = [{89001,100}],
        weight = 1000,
        guide_lv_limit = 1
}).


-record(state, {}).
-record(now, {date, time, week, day}).

-define(REFRESH_HOURLY      , 1).               % 小时               [分...]
-define(REFRESH_DAILY       , 2).               % 天                 [{时,分}...]
-define(REFRESH_WEEKLY      , 3).               % 周                 [{星期, 时, 分}...]
-define(REFRESH_MONTHLY     , 4).               % 月                 [{天,时,分}...]
-define(REFRESH_CYCLE       , 5).               % 周期更新           [更新间隔] 分钟

-define(SELL_DISCOUNT       , 0.7).             % 售出打折           

-define(BUSINESS_DATA, business_data_dict). 

-endif.  %% __MARKET_H__