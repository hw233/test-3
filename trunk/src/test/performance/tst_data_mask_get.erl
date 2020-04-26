%% Author: huangjf
%% Created: 2014.4.16
%% Description: 测试data_mask:get()的效率
-module(tst_data_mask_get).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([
		test/0,
		test2/0,
		test3/0
	]).


-include("scene.hrl").

%%
%% API Functions
%%



%% 2014.4.16 huangjf本机测试结果：
%%           （1） test()和test2()的效率是一样的； 
%%           （2） 两个函数各自循环调用一百万次，所耗时间都约为190毫秒，由此可见data_mask:get()并没有性能问题！
test() ->
	tst_prof:run(fun is_blocked/0, 1000000).


test2() ->
	tst_prof:run(fun is_blocked2/0, 1000000).


test3() ->
	tst_prof:run(fun get_scene_width_height/0, 1000000).



is_blocked() ->
			Width = 256,     % 宽度
			_Height = 192,      
			X1 = 90,
			Y1 = 100,

			X2 = 1,
			Y2 = 15,

			X3 = 231,
			Y3 = 185,

 			Index1 = Y1 * Width + X1 + 1,
 			Mask1 = data_mask:get(1304),
 			BlockType1 = erlang:element(Index1, Mask1),

 			% io:format("Mask:~w~n", [Mask]),
 			% io:format("BlockType:~p~n", [BlockType]),

 			Index2 = Y2 * Width + X2 + 1,
 			Mask2 = data_mask:get(1304),
 			BlockType2 = erlang:element(Index2, Mask2),

 			Index3 = Y3 * Width + X3 + 1,
 			Mask3 = data_mask:get(1304),
 			BlockType3 = erlang:element(Index3, Mask3),

 			BlockType1 == 2 
 			orelse BlockType2 == 2
 			orelse BlockType3 == 2.




is_blocked2() ->
			Width = 256,     % 宽度
			_Height = 192,      
			X1 = 90,
			Y1 = 100,

			X2 = 1,
			Y2 = 15,

			X3 = 231,
			Y3 = 185,

 			Index1 = Y1 * Width + X1 + 1,
 			BlockType1 = erlang:element(Index1, data_mask:get(1304)),

 			Index2 = Y2 * Width + X2 + 1,
 			BlockType2 = erlang:element(Index2, data_mask:get(1304)),

 			Index3 = Y3 * Width + X3 + 1,
 			BlockType3 = erlang:element(Index3, data_mask:get(1304)),

 			BlockType1 == 2 
 			orelse BlockType2 == 2
 			orelse BlockType3 == 2.





get_scene_width_height() ->
	SceneTpl = get_scene_width_height__(),
	Val = get_scene_width_height__(SceneTpl),
	Val2 = get_scene_width_height_2__(SceneTpl),
	SceneTpl#scene_tpl.no + Val + Val2.



get_scene_width_height__() ->
	_SceneTpl1 = data_scene:get(1303),
	SceneTpl2 = data_scene:get(1304),

	% {
	% 	SceneTpl1#scene_tpl.width,
	% 	SceneTpl1#scene_tpl.height,

	% 	SceneTpl2#scene_tpl.width,
	% 	SceneTpl2#scene_tpl.height
	% }.


	SceneTpl2.
	




get_scene_width_height__(SceneTpl) ->
	SceneTpl#scene_tpl.no + 10.



get_scene_width_height_2__(SceneTpl) ->
	SceneTpl#scene_tpl.width + 5.





%%
%% Local Functions
%%

