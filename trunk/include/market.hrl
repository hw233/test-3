%%%------------------------------------------------
%%% File    : market.hrl
%%% Author  : huangjf zhangwq
%%% Created : 2011-10-13
%%% Description: 市场交易系统的相关宏
%%%------------------------------------------------

%% 注：mk是market的缩写


%% 避免头文件多重包含
-ifndef(__MARKET_H__).
-define(__MARKET_H__, 0).


-include("common.hrl").

%%市场的挂售记录
-record(mk_selling, {
        id = 0,                                 % 挂售记录的唯一id
        seller_id = 0,                          % 卖家（玩家）id
        goods_id = 0,                           % 物品唯一id
        goods_no = 0,                           % 物品编号
        goods_name = <<>>,                      % 物品名字（binary类型）
        type = 0,                               % 物品类型
        sub_type = 0,                           % 物品子类型
        % subsub_type = 0,                      % 物品二级子类型
        quality = 0,                            % 物品品质
        level = 0,                              % 物品等级  
        race = 0,                               % 物品种族
        sex = 0,                                % 性别限制
        stack_num = 1,                          % 物品堆叠数量或货币数量（对于不可叠加物品，值固定为1，对于挂售货币，也表示所挂售的货币的数量单位是w）
        price = 0,                              % 挂售价格
        price_type = ?MNY_T_INVALID,            % 价格类型

        money_to_sell = 0,                      % 挂售货币的数量（如果不是挂售货币，而是物品，则为0）
        money_to_sell_type = ?MNY_T_INVALID,    % 挂售货币的类型

        start_time = 0,                         % 挂售的起始时间
        end_time = 0,                           % 挂售的结束时间
        status = 0                              % 挂售记录的状态（初始为无效状态）
    }).



-record(data_stall_config, {
        no = 0,                      % 编号
        type = 0,                      % 类型  
        sub_type = 0,                        % 子类型
        bind_state = 0,                      % 绑定状态
        price_type = 0,                     % 价格类型
        price = 0                       % 参考价格
    }).



%% 市场物品信息表（和ETS_GOODS_ONLINE对应，当一个物品被挂售到市场后，则该物品会从ETS_GOODS_ONLINE转移到ETS_MARKET_GOODS_ONLINE）
%%-define(ETS_MARKET_GOODS_ONLINE, ets_market_goods_online).

%% 市场物品属性表（和ETS_GOODS_ATTRIBUTE对应，当一个物品被挂售到市场后，则该物品的附加属性信息会从ETS_GOODS_ATTRIBUTE转移到ETS_MARKET_GOODS_ATTR）
%%-define(ETS_MARKET_GOODS_ATTR, ets_market_goods_attr).



-define(SQL_QUERY_MK_SELLING, "id, seller_id, goods_id, goods_no, goods_name, type, sub_type, quality, level, race, sex, stack_num, price, price_type, money_to_sell, money_to_sell_type, start_time, end_time, status").

-define(SQL_QUERY_MK_SELLING2, "SELECT id, seller_id, goods_id, goods_no, goods_name, type, sub_type, quality, level, race, sex, stack_num, price, price_type, money_to_sell, money_to_sell_type, start_time, end_time, status FROM market_selling").


%%-define(MK_MAX_SELL_TIME, 48).  % 最大挂售时间（单位：小时）


-define(SELL_TIME_UNIT_TO_SEC, 3600).  % 挂售时间的单位（默认为小时）转换成秒，为测试方便，可以修改为合适的值


-define(MK_GOODS_COUNT_PER_PAGE, 10).  % 客户端界面每页显示上架物品的数量


-define(MK_MAX_SELL_GOODS, 8).  % 最多能同时上架多少件物品

%% 最大过期时间（上架物品过期时间超过此时间，则将在下次定时清理中被清理）,单位：秒，暂定为10分钟
-define(MAX_EXPIRED_TIME, (10*60)).    

%% 定时清理过期太久的上架物品的时间间隔（单位：毫秒）, 目前为5分钟，不过代码中还会对这个间隔再加上一个随机数
-define(CLEAR_EXPIRED_GOODS_INTV, (5*60*1000)).


-define(MK_MAX_SEARCH_NAME_LEN, 20).  % 搜索字串最大长度


%% 用于数据库表market_selling的status字段，表示挂售记录的状态
-define(MK_SELL_R_STATUS_INVALID,  0).    % 无效状态
-define(MK_SELL_R_STATUS_SELLING,  1).    % 正在挂售中
-define(MK_SELL_R_STATUS_SOLD,     2).    % 已售出，等待卖家从邮件取钱
-define(MK_SELL_R_STATUS_EXPIRED,  3).    % 挂售时间已过期


-define(BUY_GOODS,  0).    % 交易类型： 买物品
-define(BUY_MONEY,  1).    % 交易类型： 买货币





%% 搜索拍卖行物品的CD时间（毫秒）
-define(SEARCH_MK_GOODS_CD_TIME, 800).

% 30天的时间
-define(VALUABLES_SELL_INTERVAL, 2592000).




%% 锁定挂售记录的持续时间（以防止多个玩家同时购买同一上架物品时出现异常），单位：秒（目前暂定为3秒）
-define(LOCK_SELL_RECORD_FOR_OPERATION_TIME, 3).


%% 可挂售的银子数量 单位是w
-define(MONEY_COUNT_1_WAN, 1).
-define(MONEY_COUNT_5_WAN, 5).
-define(MONEY_COUNT_20_WAN, 20).
-define(MONEY_COUNT_100_WAN, 100).

-define(LEFT_HOUR_CAN_BE_RESELL, 8).  % 剩余拍卖时间不足8小时的物品才可以被续期


-endif.  %% __MARKET_H__