%%%-----------------------------------
%%% @Module  : lib_bmon_group (battle monster group)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.10.20
%%% @Description: 战斗怪物组的相关接口
%%%-----------------------------------
-module(lib_bmon_group).
-export([
    	get_cfg_data/1,
    	is_valid/1,
    	is_hire_prohibited/1,
    	get_force_spawn_mon_count/1,
        get_no/1,
        get_zf_no/1
    	

    ]).

-include("common.hrl").
-include("monster.hrl").





%% get battle monster group
%% @return: null | bmon_group结构体
get_cfg_data(BMonGroupNo) ->
	data_bmon_group:get(BMonGroupNo).


%% 战斗怪物组是否有效？
is_valid(BMonGroupNo) ->
	get_cfg_data(BMonGroupNo) /= null.


%% 是否禁止雇佣的玩家出战？
%% @return: true | false
is_hire_prohibited(BMonGroupNo) ->
	?ASSERT(is_valid(BMonGroupNo), BMonGroupNo),
	BMonGroup = get_cfg_data(BMonGroupNo),
	BMonGroup#bmon_group.is_hire_prohibited == 1.


get_force_spawn_mon_count(BMonGroup) ->
	BMonGroup#bmon_group.force_spawn_mon_count.

get_no(BMonGroup) ->
    BMonGroup#bmon_group.no.    	 


%% 获取可能的阵法编号（需要符合阵法战斗单位的需求）
get_zf_no(BMonGroupNo) ->
    case get_cfg_data(BMonGroupNo) of
        null -> ?INVALID_NO;
        BMonGroup -> BMonGroup#bmon_group.zf_no
    end.

% %% TODO: 按正式规则选怪！
% pick_mon_from_group(_MonCount, MonGroup) ->
% 	MonGroup#bmon_group.fixed_mon_pool.
