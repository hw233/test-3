%%%------------------------------------
%%% @author lf <529132738@qq.com>
%%% @copyright UCweb 2015.03.24
%%% @doc 幸运转盘 抽奖活动 头文件.
%%% @end
%%%------------------------------------

-ifndef(__ERNIE_H__).
-define(__ERNIE_H___, 0). 

%% 活动Id
-define(ACTID, 10).

% 幸运转盘玩家抽奖信息
-record(ernie_state, {
        status = 0            % 幸运转盘状态（0-结束 1-开始）
        ,reward_logs = []     % 幸运转盘抽奖记录 % {player_id, player_name, no, good_no,num}
    }).

% 抽奖数据信息
-record(ernie_reward_data, {
        no = 0          % 抽奖物品位置
		,type = 0		% 奖池编号
        ,prob = 0       % 抽奖物品概率
        ,reward = []    % {物品id，物品数量，品质，绑定状态}
		,notice = 0
    }).

-record(ernie_data, {
    ernie_times = 0         %转盘次数
    ,ernie_add_time = 0     %增加的时间
    ,ernie_sub_time = 0     %减少的时间
	,data = null			%转盘数据
    }).

-record(ernie_record_data, {
							last_time = 0,		%% 上次抽奖时间戳
							data_vsn  = 0,		%% 当前配置文件信息
							type = 0,			%% 当前奖励池的编号
							data = []			%% 已获得的物品记录
    }).


-endif. % __ERNIE_H__
