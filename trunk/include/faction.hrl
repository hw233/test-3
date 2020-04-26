%%%------------------------------------------------
%%% File    : faction.hrl
%%% Author  : huangjf
%%% Created : 2013.12.27
%%% Description: 门派的相关宏定义和结构体定义
%%%------------------------------------------------

% 避免头文件多重包含
-ifndef(__FACTION_H__).
-define(__FACTION_H__, 0).





%% 门派
-define(FACTION_NONE, 0).       % 无门派
-define(FACTION_XMD, 1).        % 墨家
-define(FACTION_WJM, 2).        % 兵家
-define(FACTION_YHD, 3).        % 法家
-define(FACTION_YMC, 4).        % 阴阳家
-define(FACTION_XBG, 5).        % 道家
-define(FACTION_JHG, 6).        % 儒家
-define(FACTION_MIN, 1).        % 最小门派代号，仅用于程序做判定
-define(FACTION_MAX, 6).        % 最大门派代号，仅用于程序做判定

 % 门派列表
-define(FACTION_LIST, [?FACTION_XMD, ?FACTION_WJM, ?FACTION_YHD, ?FACTION_YMC]).

 % 门派列表
% -define(FACTION_LIST_NAME, [<<"墨家">>, <<"兵家">>, <<"法家">>, <<"阴阳家">>, <<"道家">>, <<"儒家">>]).




%% 门派基本信息
-record(faction_base, {
            faction = 0,         % 门派代号
            race_limit = 0,      % 种族限制
            sex_limit = 0,       % 性别限制     
            scene_no = 0,        % 门派场景编号
            master_xinfa = 0,    % 门派的主心法id
            xinfa_list = []  ,   % 门派的心法id列表
			skills = [],
            five_elements = 1,
			init_attr = 3,
			recommand_point = []
    }).



%% 门派的玩家列表
-record(faction_players, {
		faction = 0,           % 门派代号
		player_list = []       % 玩家列表（目前是存玩家id列表）
	}).

%% 转职需要
-record(transform_faction, {
        no = 0                  %配置编号
        ,time_range = []        %时间段
        ,money = []             %消耗
    }).



-endif.  % __FACTION_H__
