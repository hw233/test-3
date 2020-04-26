%% Author: Administrator
%% Created: 2012-2-28
%% Description: TODO: Add description to data_scene_item_pos
-module(data_scene_item_pos).


%%
%% Exported Functions
%%
-export([
		 get/1
		 ]).

%% 帮派buff位置
get(2) ->
	[{5,X,Y}||[X,Y]<-[[12,12],[33,11],[54,13]]];
get(_) ->
	[].

