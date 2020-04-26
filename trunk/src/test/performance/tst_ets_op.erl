%% Author: Administrator
%% Created: 2011-8-22
%% Description: TODO: Add description to ets_op
%% 测试用例：ets表存了3000个玩家的所有武将，每个玩家有10个武将，即ets表里有30000个武将对象
%% ets的match操作大概是4-5ms, lookup操作是0.5us
%% match比select要快0.67ms
%% test_list_to_atom比test_concur_read快
-module(tst_ets_op).

% %%
% %% Include files
% %%
% -include("common.hrl").
% -include("record.hrl").
% -include_lib("stdlib/include/ms_transform.hrl").
% %%
% %% Exported Functions
% %%
% -export([init/1,
% 		 init_set/0, init_ordered_set/0,
% 		 test_lookup/0, test_match/0, test_matchobj/0, test_select/0, test_mul_lookup/0,
% 		 test_lookup_vary/0, test_match_vary/0, test_matchobj_vary/0, test_del_ordered/0,
% 		 test_aoi_update_online/0, test_aoi_match/0, test_aoi_lookup/0,
% 		 init_aoi/1, test_aoi_update/0,
% 		 init_concur/1, test_concur_read/0, test_list_to_atom/0,
% 		 test_new/0, test_ets_exist/0, test_ets_exist2/0, test_ets_exist3/0,
% 		 test_matchobj_result/0, test_matchobj_limit_result/1,
% 		 init_bag/0, test_bag_lookup/1, test_bag_matchobj/1, test_bag_match_del/1, test_bag_matchobj2/1]).



% %% 角色任务历史记录
% -record(role_task_log,
%     {
%         role_id=0,
%         task_id=0,
%         trigger_time=0,
%         finish_time=0,
%         type = 0         %任务类型
%     }).

    

% %%
% %% API Functions
% %%
% init_set() ->
% 	ets:new(?ETS_ONLINE, [{keypos,#ets_online.id}, named_table, public, set]),
% 	F1 = fun() ->
% 		case get(player_id) of
% 			undefined ->
% 				 Base = 0,
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base, sid=Base, line_id=0}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+1, sid=Base, line_id=1}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+2, sid=Base, line_id=2}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+3, sid=Base, line_id=3}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+4, sid=Base, line_id=4}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+5, sid=Base, line_id=5}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+6, sid=Base, line_id=6}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+7, sid=Base, line_id=7}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+8, sid=Base, line_id=8}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+9, sid=Base, line_id=9}),
% 				 put(player_id, 1);
% 			Id ->
% 				 Base = Id * 10,
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base, sid=Id, line_id=0}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+1, sid=Id, line_id=1}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+2, sid=Id, line_id=2}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+3, sid=Id, line_id=3}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+4, sid=Id, line_id=4}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+5, sid=Id, line_id=5}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+6, sid=Id, line_id=6}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+7, sid=Id, line_id=7}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+8, sid=Id, line_id=8}),
% 				 ets:insert(?ETS_ONLINE, #ets_online{id=Base+9, sid=Id, line_id=9}),
% 				 put(player_id, Id+1)
% 		end
% 		end,

% 	tst_prof:run(F1, 3000).

% init_ordered_set() ->
% 	ets:new(?ETS_ONLINE, [named_table, public, ordered_set]),
% 	F1 = fun() ->
% 		case get(player_id) of
% 			undefined ->
% 				 Base = 0,
% 				 ets:insert(?ETS_ONLINE, {{0, Base}, Base, 0}),
% 				 ets:insert(?ETS_ONLINE, {{1, Base+1}, Base, 0}),
% 				 ets:insert(?ETS_ONLINE, {{2, Base+2}, Base, 0}),
% 				 ets:insert(?ETS_ONLINE, {{3, Base+3}, Base, 0}),
% 				 ets:insert(?ETS_ONLINE, {{4, Base+4}, Base, 0}),
% 				 ets:insert(?ETS_ONLINE, {{5, Base+5}, Base, 0}),
% 				 ets:insert(?ETS_ONLINE, {{6, Base+6}, Base, 0}),
% 				 ets:insert(?ETS_ONLINE, {{7, Base+7}, Base, 0}),
% 				 ets:insert(?ETS_ONLINE, {{8, Base+8}, Base, 0}),
% 				 ets:insert(?ETS_ONLINE, {{9, Base+9}, Base, 0}),
% 				 put(player_id, 1);
% 			Id ->
% 				 Base = Id * 10,
% 				 ets:insert(?ETS_ONLINE, {{0, Base}, Id, 0}),
% 				 ets:insert(?ETS_ONLINE, {{1, Base+1}, Id, 0}),
% 				 ets:insert(?ETS_ONLINE, {{2, Base+2}, Id, 0}),
% 				 ets:insert(?ETS_ONLINE, {{3, Base+3}, Id, 0}),
% 				 ets:insert(?ETS_ONLINE, {{4, Base+4}, Id, 0}),
% 				 ets:insert(?ETS_ONLINE, {{5, Base+5}, Id, 0}),
% 				 ets:insert(?ETS_ONLINE, {{6, Base+6}, Id, 0}),
% 				 ets:insert(?ETS_ONLINE, {{7, Base+7}, Id, 0}),
% 				 ets:insert(?ETS_ONLINE, {{8, Base+8}, Id, 0}),
% 				 ets:insert(?ETS_ONLINE, {{9, Base+9}, Id, 0}),
% 				 put(player_id, Id+1)
% 		end
% 		end,

% 	tst_prof:run(F1, 500).
			
% test_lookup_vary() ->
% 	F = fun(I) ->
% 			%% [Res] = ets:lookup(?ETS_ONLINE, I),
% 			%% io:format("~p,~p~n", [Res#ets_online.id, Res#ets_online.sid])
% 			ets:lookup(?ETS_ONLINE, I)
% 		 end,
% 	tst_prof:run_index(F, 30000-1).

% test_lookup() ->
% 	F = fun() ->
% 			%% [Res] = ets:lookup(?ETS_ONLINE, I),
% 			%% io:format("~p,~p~n", [Res#ets_online.id, Res#ets_online.sid])
% 			ets:lookup(?ETS_ONLINE, 311)
% 		 end,
% 	tst_prof:run(F, 30000).

% test_match_vary() ->
% 	F = fun(I) ->
% 			ets:match(?ETS_ONLINE, #ets_online{sid=I, id = '$1', _='_'})
% 		 end,
% 	tst_prof:run_index(F, 3000).

% test_match() ->
% 	F = fun() ->
% %% 			ets:match(?ETS_ONLINE, #ets_online{id = '$1', lv = '$2', x = '$3', y = '$4', hp = '$5', sid=981, line_id=0, _='_'})
% 			ets:match(?ETS_ONLINE, #ets_online{id = '$1', lv = '$2', x = '$3', y = '$4', hp = '$5', line_id=0, _='_'})
% 		 end,
% 	tst_prof:run(F, 3000).

% test_matchobj_vary() ->
% 	F = fun(I) ->
% 			ets:match_object(?ETS_ONLINE, #ets_online{sid=I, id = '$1', _='_'})
% 		 end,
% 	tst_prof:run_index(F, 3000).

% test_matchobj() ->
% 	F = fun() ->
% 			ets:match_object(?ETS_ONLINE, #ets_online{sid = 31, _='_'})
% 		 end,
% 	tst_prof:run(F, 3000).

% test_select() ->
% 	F = fun() ->
% %% 			MS = ets:fun2ms(fun(T) when T#ets_online.sid==981 andalso T#ets_online.line_id==0 -> 
% %% 									[
% %% 									 T#ets_online.id,
% %% 									 T#ets_online.lv,
% %% 									 T#ets_online.x,
% %% 									 T#ets_online.y,
% %% 									 T#ets_online.hp
% %% 									]
% %% 							end),
% %% 			ets:select(?ETS_ONLINE, MS)
% %% 			io:format("MS: ~p~n", [MS]),
% %%    			ets:select(?ETS_ONLINE, [{'$1',[{'==',{element,5,'$1'},981}],[[{element,2,'$1'}]]}])
			
% 			R=ets:select(?ETS_ONLINE, [{{{0, '$1'},'$2', '$3'}, [], ['$$']}]),
% 			io:format("--- ~p~n", [R])
% 		end,
% 	tst_prof:run(F, 1).

% del_ordered() ->
% 	ets:delete(?ETS_ONLINE, {6, 1006}),
% 	ets:insert(?ETS_ONLINE, {{6, 1006}, 6, 6}).

% test_del_ordered() ->
% 	tst_prof:run(fun del_ordered/0, 100000).

% lookup(Id) ->
% 	[Player] = ets:lookup(?ETS_ONLINE, Id),
% 	[Player#ets_online.id, Player#ets_online.lv, Player#ets_online.x, Player#ets_online.y, Player#ets_online.hp].

% test_mul_lookup() ->
% 	F = fun() ->
% 			lists:map(fun lookup/1, [9810,9811,9812,9813,9814,9815,9816,9817,9818,9819])
% 		 end,
% 	tst_prof:run(F, 3000).

% %% ------------------------------ 场景广播测试 -------------------------------
% init(N) ->
% 	put(player_id, 0),
% 	ets:new(?ETS_ONLINE, [{keypos,#ets_online.id}, named_table, public, set]),
% 	F = fun() ->
% 				Id = get(player_id),
% 				Base = Id * 50,
% 				F2 = fun(I) ->
% 							 ets:insert(?ETS_ONLINE, #ets_online{id=Base+I, line_id=Base})
% 					 end,
% 				for(1, 50, F2),
% 				put(player_id, Id+1)
% 		end,

% 	tst_prof:run(F, N).

% test_aoi_update_online() ->
% 	F = fun(I) ->
% 				ets:insert(?ETS_ONLINE, #ets_online{id=999, x=I, y=I})
% 		end,

% 	tst_prof:run_index(F, 100000).

% test_aoi_match() ->
% 	F = fun() ->
% 			ets:match(?ETS_ONLINE, #ets_online{id = '$1', lv = '$2', x = '$3', y = '$4', hp = '$5', line_id=5, _='_'})
% 		end,
% 	tst_prof:run(F, 1000).

% test_aoi_lookup() ->
% 	L = lists:seq(251, 300),
% 	F = fun() ->
% 			lists:map(fun lookup/1, L)
% 		 end,
% 	tst_prof:run(F, 1000).

% %% Type: set|ordered_set
% init_aoi(Type) ->
% 	put(player_id, 0),
% 	ets:new(?ETS_ONLINE, [named_table, public, Type]),
	
% 	F = fun() ->
% 				Id = get(player_id),
% 				ets:insert(?ETS_ONLINE, {{Id, Id}, 0, 0, 0}),
% 				put(player_id, Id+1)
% 		end,

% 	tst_prof:run(F, 2000).

% test_aoi_update() ->
% 	F = fun(I) ->
% 				ets:insert(?ETS_ONLINE, {{999, 999}, 0, I, I})
% 		end,

% 	tst_prof:run_index(F, 100000).

% %% ------------------------------------- read concurrency测试 ---------------------------------
% init_concur(Is_read_concurrency) ->
% 	put(player_id, 0),
% 	ets:new(?ETS_ONLINE, [named_table, public, set, {read_concurrency, Is_read_concurrency}]),
	
% 	F = fun() ->
% 				Id = get(player_id),
% 				Atom = list_to_atom([Id]),
% 				ets:insert(?ETS_ONLINE, {Id, Atom}),
% 				put(player_id, Id+1)
% 		end,

% 	tst_prof:run(F, 40).

% concur_read() ->
% %% 	spawn(
% %% 	  fun() -> 
% 			  ets:lookup(?ETS_ONLINE, 30).
% %% 	  end
% %% 	).

% test_concur_read() ->
% 	tst_prof:run(fun concur_read/0, 100000).


% lltoaa() ->
% 	list_to_atom([30]).

% test_list_to_atom() ->
% 	tst_prof:run(fun lltoaa/0, 100000).

% %% ----------------------------------------- 测试创建ets和判断ets是否存在的性能 ----------------------------------------
% t_new() ->
% 	ets:new(?ETS_ONLINE, [named_table, public, ordered_set]),
% 	ets:delete(?ETS_ONLINE).

% test_new() ->
% 	tst_prof:run(fun t_new/0, 100000).

% t_ets_exist() ->
% 	ets:info(?ETS_ONLINE) == undefined.

% test_ets_exist() ->
% 	tst_prof:run(fun t_ets_exist/0, 100000).

% t_ets_exist2() ->
% 	ets:info(?ETS_ONLINE, size) == undefined.

% test_ets_exist2() ->
% 	tst_prof:run(fun t_ets_exist2/0, 100000).

% t_ets_exist3(I) ->
% 	I >= 1000.

% test_ets_exist3() ->
% 	tst_prof:run_index(fun t_ets_exist3/1, 100000).

% %%
% %% Local Functions
% %%

% for(Max, Max , Fun) ->
%     Fun(Max);
% for(I, Max, Fun) -> 
%     Fun(I), 
% 	for(I + 1, Max, Fun).

% %% --------------------------------------------------------------------------------------------------------
% test_matchobj_result() ->
% 	ets:match_object(?ETS_ONLINE,  #ets_online{sid=1, _='_'}).

% test_matchobj_limit_result(Limit) ->
% 	ets:match_object(?ETS_ONLINE,  #ets_online{sid=1, _='_'}, Limit).

% %% ----------------------------------------------------- 测试bag -------------------------------------------
% init_bag() ->
% 	ets:new(?ETS_ROLE_TASK_LOG(1),[{keypos,#role_task_log.role_id}, public,bag,named_table]),
% 	F1 = fun() ->
% 		case get(player_id) of
% 			undefined ->
% %%				 Base = 0,
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+1}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+2}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+3}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+4}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+5}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+6}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+7}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+8}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+9}),
% 				 put(player_id, 1);
% 			Id ->
% %%				 Base = Id * 10,
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+1}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+2}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+3}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+4}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+5}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+6}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+7}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+8}),
% %% 				 ets:insert(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=Base, task_id=Base+9}),
% 				 put(player_id, Id+1)
% 		end
% 		end,

% 	tst_prof:run(F1, 1000).

% test_bag_lookup(K) ->
% 	F = fun() ->
% 			ets:lookup(?ETS_ROLE_TASK_LOG(K), K)
% 		 end,
% 	tst_prof:run(F, 10000).

% test_bag_matchobj(K) ->
% 	F = fun() ->
% 			ets:match_object(?ETS_ROLE_TASK_LOG(K), #role_task_log{role_id=K, task_id = 1, _='_'})
% 		 end,
% 	tst_prof:run(F, 10000).

% test_bag_match_del(K) ->
% 	F = fun() ->
% 			ets:match_delete(?ETS_ROLE_TASK_LOG(K), #role_task_log{role_id=K, _='_'})
% 		 end,
% 	tst_prof:run(F, 10000).

% test_bag_matchobj2(_K) ->
% %% 	F = fun() ->
% %% 			ets:match_delete(?ETS_ROLE_TASK_LOG,  #role_task_log{role_id=0,  _='_'})
% %% 			io:format("Res1:~p~n", [ets:match_object(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=K, _='_'})]),
% %% 			N = ets:info(?ETS_ROLE_TASK_LOG, size),
% %% 			io:format("Res2:~p~n", [ets:match_object(?ETS_ROLE_TASK_LOG, #role_task_log{role_id=K, _='_'}, N)]).
% %% 		 end,
% %% 	tst_prof:run(F, 1000).
% ok.
	
