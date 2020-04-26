%%%---------------------------------------
%%% @Module  : data_am_skill
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2012-09-15  11:18:10
%%% @Description: 自动挂机的推荐技能组合设置（模板：am_skill.tpl.php）
%%%---------------------------------------




%% meger to trunk test!!!

-module(data_am_skill).
-export([get_recommend_comb_set/3]).

-include("common.hrl").


%% 获取玩家或武将的挂机的推荐技能组合设置（技能id列表）
get_recommend_comb_set(partner, 1026, 2) ->
	[22012,22010,22009];
	
get_recommend_comb_set(partner, 1036, 1) ->
	[21004,21002,21001];
	
get_recommend_comb_set(partner, 1011, 3) ->
	[24012,24010,24009];
	
get_recommend_comb_set(partner, 1012, 1) ->
	[21028,21025];
	
get_recommend_comb_set(partner, 1030, 3) ->
	[23008,23006,23005];
	
get_recommend_comb_set(partner, 1031, 1) ->
	[21024,21022,21021];
	
get_recommend_comb_set(partner, 1032, 1) ->
	[21032,21030,21029];
	
get_recommend_comb_set(partner, 1040, 1) ->
	[21008,21005];
	
get_recommend_comb_set(partner, 1037, 2) ->
	[22004,22002,22001];
	
get_recommend_comb_set(partner, 1013, 4) ->
	[24004,24002,24001];
	
get_recommend_comb_set(partner, 1016, 3) ->
	[23004,23002,23001];
	
get_recommend_comb_set(partner, 1034, 1) ->
	[21012,21010,21009];
	
get_recommend_comb_set(partner, 1043, 4) ->
	[24008,24006,24005];
	
get_recommend_comb_set(partner, 1039, 1) ->
	[21016,21014,21013];
	
get_recommend_comb_set(partner, 1041, 2) ->
	[22008,22006,22005];
	
get_recommend_comb_set(partner, 1038, 1) ->
	[21020,21018,21017];
	
get_recommend_comb_set(player, 0, 1) ->
	[11008,11007,11004,11003,11019,11001];
	
get_recommend_comb_set(player, 0, 2) ->
	[12008,12007,12025,12003,12019,12001];
	
get_recommend_comb_set(player, 0, 3) ->
	[13008,13007,13025,13019,13005,13001];
	
get_recommend_comb_set(player, 0, 4) ->
	[14008,14007,14025,14004,14003,14001];
	

get_recommend_comb_set(_Type, _Id, _Career) ->
	?ASSERT(false, {_Type, _Id, _Career}),
    [].
