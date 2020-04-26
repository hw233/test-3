%% Author: Administrator
%% Created: 2013.6.19
%% Author:  huangjf
%% Description: 测试性能：同时开N1个进程去写xx次ets，开N2个进程去读xx次ets

-module(tst_ets_op2).


-export([test/0]).



% -include("scene.hrl").



-define(READ_PROC_COUNT, 1000).	
-define(WRITE_PROC_COUNT, 1000).	



%% 场景格子（场景划分九宫格后的其中一格）
-record(scene_grid, {
           key = {0, 0},         % 场景格子的key: {所在场景的唯一id， 场景格子的索引} ---- 目前场景格子的索引不是一维的整数索引，而是二维的{Grid_X, Grid_Y}形式
           player_ids = [],      % 场景格子中的玩家id列表
           mon_ids = [],         % 场景格子中的怪物唯一id列表
           npc_ids = []          % 场景格子中的npc唯一id列表（这里npc是指会走动的智能npc）
    }).




test() ->
	F = fun() -> test2() end,
	 tst_prof:run(F, 1).
	
test2() ->
		ets:new(mytbl, [{keypos, #scene_grid.key}, named_table, public, set]),
		F1 = fun(Pid, X) ->
				spawn(fun() -> read_ets(Pid, X)  end)
			end,
		F2 = fun(Pid, X) ->
				spawn(fun() -> write_ets(Pid, X)  end)
			end,
		L1 = lists:seq(1, ?READ_PROC_COUNT),
		L2 = lists:seq(1, ?WRITE_PROC_COUNT),

		Self = self(),

		% 先写后读
		[F2(Self, X) || X <- L2],  %%lists:foreach(F2, L2), 
		%%timer:sleep(1),
		[F1(Self, X) || X <- L1],  %%lists:foreach(F1, L1),
		
		put(done_count, 0),
		wait_until_finish(),
		io:format("test finished!!~n").
		
		


wait_until_finish() ->		
	receive
		{_Any, _SeqNum} ->
			%%io:format("~p proc ~p is done~n", [Any, _SeqNum]),
			case get(done_count) of
				  ?READ_PROC_COUNT + ?WRITE_PROC_COUNT - 1 ->
				  %%?READ_PROC_COUNT - 1 ->
				  	 	done;
				  Count ->
				 		put(done_count,  Count + 1),
				 		wait_until_finish()
			end
	end.
		
		

-define(READ_TIMES, 400).
-define(WRITE_TIMES, 400).



read_ets(ParPid, SeqNum) ->
		%%io:format("ins_ets(), seq_num: ~p~n", [SeqNum]),
		%%random:seed(erlang:now()),

		%%init_insert_items_to_ets(),

		loop_read(ParPid, SeqNum, ?READ_TIMES, 0).


% init_insert_items_to_ets() ->
% 		F = fun(SeqNum, CurLoop) ->
% 					SceneCell = #scene_grid{
% 							key = {SeqNum, CurLoop},
% 							player_ids =  [SeqNum, 22, 33, SeqNum + 100, CurLoop, 55,55, 66, 55, 77, 88, 99, 10, 11, 99],
% 							mon_ids = [SeqNum, 22, 33, SeqNum + 100, SeqNum + 55, 55,55, 66, 55, 77, 88, 99, 10, 11, 99],
% 							npc_ids = [1]
% 							},
% 					ets:insert(mytbl, SceneCell)
% 			end,

% 		L = lists:seq(1, 400),
% 		[F(X, X) || X <- L].

		



write_ets(ParPid, SeqNum) ->
		%%io:format("ins_ets(), seq_num: ~p~n", [SeqNum]),
		%%random:seed(erlang:now()),
		loop_write(ParPid, SeqNum, ?WRITE_TIMES, 0).
		


			
loop_read(ParPid, SeqNum, 0, _CurLoop) ->
		ParPid ! {read_i_am_done, SeqNum},
		done;
loop_read(ParPid, SeqNum,  LeftTimes, CurLoop) ->
		%%PS = #player_status{id = SeqNum, lv = 1},
		%%Lv = 22, %%random:uniform(100),
		%%PS2 = PS#player_status{lv = Lv},

		ets:lookup(mytbl, {SeqNum, CurLoop}),
		
		%%ets:insert(mytbl, PS),
		loop_read(ParPid, SeqNum, LeftTimes - 1, CurLoop + 1).
		
	

loop_write(ParPid, SeqNum, 0, _CurLoop) ->
		ParPid ! {write_i_am_done, SeqNum},
		done;
loop_write(ParPid, SeqNum,  LeftTimes, CurLoop) ->
		%%PS = #player_status{id = SeqNum, lv = 1},
		%%Lv = 22, %%random:uniform(100),
		%%PS2 = PS#player_status{lv = Lv},

		SceneCell = #scene_grid{
							key = {SeqNum, CurLoop},
							player_ids =  [SeqNum, 22, 33, SeqNum + 100, CurLoop, 55,55, 66, 55, 77, 88, 99, 10, 11, 99],
							mon_ids = [SeqNum, 22, 33, SeqNum + 100, SeqNum + 55, 55,55, 66, 55, 77, 88, 99, 10, 11, 99],
							npc_ids = [1]
						},
		%%ets:insert(mytbl, {simple_tuple, SeqNum, [11, 22, 33, 44, 55, 55,55, 66, 55, 77, 88, 99, 10, 11], "string", here, 30}),
		ets:insert(mytbl, SceneCell),
		
		%%ets:insert(mytbl, PS),
		loop_write(ParPid, SeqNum, LeftTimes - 1, CurLoop + 1).
