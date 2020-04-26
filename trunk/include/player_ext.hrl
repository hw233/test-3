%%%------------------------------------------------
%%% File    : player_ext.hrl
%%% Author  : 段世和
%%% Created : 2015-10-24
%%% Description: 玩家拓展信息表
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__PLAYER_EXT_H__).
-define(__PLAYER_EXT_H__, 0).

% 商会配置结构体
-record(player_ext_record, {
        player_id = 0,                           %  玩家id
        key = null,                              %  key
        value = 0                                %  value
    }).

-record(state, {}).

% 字典
-define(PLAYER_EXT_DICT, player_ext_dict). 

-define(PK_THRESHOLD, pk_threshold). 

-define(POPULAR_NORMAL_ADD, 1). 
-define(POPULAR_PRISON_ADD, 4). 


-endif.  %% __PLAYER_EXT_H__