%%%------------------------------------------------
%%% File    : scene_line.hrl
%%% Author  : huangjf
%%% Created : 2014.3.13
%%% Description: 场景分线的相关宏
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__SCENE_LINE_H__).
-define(__SCENE_LINE_H__, 0).






%% 第一条场景分线
-define(FIRST_SCENE_LINE, 1).

%% 默认所属的场景分线为第一条分线
-define(DEFAULT_SCENE_LINE, ?FIRST_SCENE_LINE).

%% 无效的场景分线
-define(INVALID_SCENE_LINE, 0).


%% 最大场景分线号
-define(MAX_SCENE_LINE, 40).



%% 默认的单条场景分线的最大人数
-define(SCENE_LINE_MAX_PLAYER_COUNT, 80).

%% 主城场景的单条场景分线的最大人数
-define(SCENE_LINE_MAX_PLAYER_COUNT_FOR_MAIN_CITY, 130).

%% 拷贝场景的单条场景分线的最大人数
-define(SCENE_LINE_MAX_PLAYER_COUNT_FOR_COPY_SCENE, 180).









-endif.  %% __SCENE_LINE_H__
