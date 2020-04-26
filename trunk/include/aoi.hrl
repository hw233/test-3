%%%------------------------------------------------
%%% File    : aoi.hrl
%%% Author  : huangjf
%%% Created : 2014.4.10
%%% Description: AOI相关的宏
%%%------------------------------------------------



%% 避免头文件多重包含
-ifndef(__AOI__).
-define(__AOI__, 0).




%% 场景九宫格相关的宏
-define(GRID_WIDTH, 36).        %%网格长度
-define(GRID_HEIGHT, 26).       %%网格宽度
-define(CUT_GRID_WIDTH, (?GRID_WIDTH * 4)). %%决定是否进行地图切割的宽度
-define(CUT_GRID_HEGIHT, (?GRID_HEIGHT * 4)).   %%决定是否进行地图切割的长度



-define(GRID_SEQ_START, 1).       %%格子序号的起始值

-define(DEFAULT_GRID, ?GRID_SEQ_START).       %%默认格子下标序号









-record(aoi_scene, {
		scene_id = 0,        % 场景id
		width = 0,           % 场景宽度
		height = 0           % 场景高度
	}).



-record(aoi_pos, {
		scene_id = 0,
		x = 0,
		y = 0,
		scene_line = 0,        % 所属场景的分线
		scene_grid_index = {0, 0}  % 所在场景格子的索引，二维的{Grid_X, Grid_Y}形式
	}).









-endif.  %% __AOI__
