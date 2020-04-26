%%%------------------------------------------------
%%% File    : sprd.hrl
%%% Author  : huangjf 
%%% Created : 2014.8.6
%%% Description: 推广系统
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__SPRD_H__).
-define(__SPRD_H__, 0).





%% 玩家的推广信息
-record(sprd, {
        player_id = 0,          % 玩家id
        code = "",              % 推广码
        sprdee_list = [],       % 玩家的被推广人列表（即已接受玩家的推广的被推广人列表）
        sprder_id = 0           % 玩家的推广人（即玩家主动请求与之建立推广关系的人）的id
        }).




%% 推广系统的奖励配置
-record(sprd_reward, {
        lv = 0,                  % 对应的等级
        pkg_to_sprder = 0,       % 给予推广人的奖励包编号
        pkg_to_sprdee = 0        % 给予被推广人的奖励包编号
        }).





-define(MAX_SPRDEE_COUNT, 5).   % 拥有被推广人的数量上限


-define(SPRD_LV_LIMIT, 24).  % 24或24级以下才能请求建立推广关系



%% 合服后重置的8位cdk
-define(CDK_8_AFTER_MERGE_SERVER, "XXXXXXXX").




-endif.  %% __SPRD_H__
