%%%------------------------------------------------
%%% File    : tve.hrl
%%% Author  : zwq
%%% Created : 2014-6-17
%%% Description: 组队兵临城下 外围相关记录、宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__TVE_H__).
-define(__TVE_H__, 0).


%% 排名数据
-record(tve_rank, {
        leader_name = <<>>,
        leader_vip_lv = 0,
        faction_list = [],
        id_list = [],           %% 参与者id列表
        win = 0,                %% 打怪胜利波数
        rounds = 0              %% 回合总数
    }).

-record(tve, {
        lv_step = 0,            % 等级段
        rank = []               % 当天排名 只保存前10名的数据，排行榜根据玩家战胜多少波怪为优先排名，同样波数后以回合数排名，越短越靠前。(数组下标越小名次越前)                             
    }).


%% 玩家自身的兵临城下数据
-record(player_tve_data, {
        enter_time = []             %% 今天进入兵临城下次数 在重置模块统一重置
		,enter_time_single = []		%% 今天进入单人兵临城下次数
    }).

-record(tve_cfg, {
        no = 0,   
        lv_range = [],    
        reward_type = [],  
        bind_gamemoney = [],    
        gamemoney = [],
        exp = [],
        goods = [], 
        par_exp = [],
        goods_extra = [],
        base = 0,    
        coef = 0, 
        times = 0,
        times_use_goods = 0,
        use_goods_no = 0,
        dungeon_no = 0,
        max_wave = 0,
        mb_limit = 0
    }).

%% 兵临城下排名奖励
-record(rank_reward, {
        no = 0,  
        lv_range = [],
        rank = 0,    
        goods_list = [],
        mail_title = <<>>,
        mail_content = <<>>
    }).


%% 排名奖励前n名获得奖励
-define(TVE_MGR_PROCESS, tve_mgr_process).
-define(ACT_TVE_NO, 23).


-endif.  %% 