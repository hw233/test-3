%%%------------------------------------------------
%%% File    : trade.hrl
%%% Author  : zhangwq 
%%% Created : 2013.11.6
%%% Description: NPC商店\回购\商城
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__TRADE_H__).
-define(__TRADE_H__, 0).


-record(buy_back, {
        player_id = 0,          % 玩家id，表示是哪个玩家的回购物品列表
        goods = null           % 已经卖出的物品列表， 形如：null（表示未初始化） | [] （表示没有物品， 下同） | goods结构体列表
    }).


%% 商店 商城 物品结构体
-record(shop_goods, {
        goods_no = 0,       % 物品编号
        quality = 0,
        bind_state = 0,
        price_type = 0,     % 价格类型
        price = 0,
        consumer_goods_list = [],
        discount_price = 0,
        discount = 0,       % 折扣率 运营后台商城专用
        goods_type = 0,     % 0：表示普通商品; 1：表示限时物品，无限个物品x时间下架; 2：表示限量物品，上架x个 3：某个时间段内限制购买的商品
                            % 既是限时又是限量的，优先填限时的物品类型，因为限量个人某时段内是通过 count_limit_type 和 buy_count_limit_time控制,
                            % 限制某个玩家终身购买该物品的数量通过buy_count_limit控制
        goods_count_limit = 0, % 商品类型为2时，表示每次刷新数量个数限制
        buy_count_limit = 0,   % 限制某个玩家终身购买该物品的数量   
        lv_need = 0,           % 等级范围的下限
        lv_need_max = 0,       % 等级范围的上限
        sex = 0,
        vip_lv_need = 0, 
        repu_need = 0, 
        race_need = 0, 
        faction_need = 0,

        year = 0,               % 商店物品刷新开始时间点
        month = 0,   
        week = 0,    
        day = 0, 
        hour = 0,    

        server_start_day = 0,    % nil：空 只能填写数字 表示开服第几天开始刷出物品
        continue_day = 0,        % 填写按规则刷新持续天数单位是天

        refresh_interval = 0,    % 刷新间隔，单位是小时
        continue_time = 0,       % 限时物品每个刷新周期在架时间，单位是小时

        count_limit_type = 0,       % 限制某个玩家购买的时间类型 1表示天为单位，2表示周为单位, 3表示以月为单位
        buy_count_limit_time = 0,   % 限制某个玩家某时段内购买该物品的数量

        %% 以下字段服务器保存的数据，非配置
        last_refresh_time = 0,   % 上次刷新时间 单位s
        expire_time = 0,         % goods_type = 1 表示过期时间 单位s
        left_num = 0             % goods_type = 2 表示限量物品 当前剩余数量
    }).

-define(BUY_BACK_LIST_CAPACITY, 20).        %% 回购列表最大容量
-define(BUY_BACK_TIME_LIMIT, 1 * 3600).     %% 回购物品时间限制：在卖出1小时内

-define(SHOP_PROCESS, shop_process).

%% 定时刷新商城物品的时间间隔（单位：毫秒）, 目前为5秒
-define(REFRESH_DYNAMIC_GOODS_INTV, (5*1000)).

-define(SECOND_OF_ONE_HOUR, 3600).

-define(SHOP_TYPE_NPC, 1).      % 商店
-define(SHOP_TYPE_SHOP, 2).     % 商城
-define(SHOP_TYPE_OP_SHOP, 3).  % 运营后台限时限购商城

-endif.  %% __TRADE_H__
