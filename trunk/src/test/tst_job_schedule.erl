-module(tst_job_schedule).

-export([init/0, add/0, remove/0]).

-include("job_schedule.hrl").

-define(RANGE, 20000).

init() ->
	mod_kernel:start_link(),
	svr_clock:start_link(),
	mod_ply_jobsch:start_link(),
	mod_id_alloc:init().


add() ->
	F = fun() ->
			PlayerId = mod_id_alloc:next_comm_id(),
			BuffId = rand(1000, 2000),
			DelayTime = rand(600, 24*3600),
			mod_ply_jobsch:add_schedule(?JSET_CANCEL_BUFF, DelayTime, [PlayerId, BuffId])
	end,
	tst_prof:run(F, ?RANGE). %%
	

remove() ->
	F = fun() ->
		PlayerId = rand(1, ?RANGE),
		% io:format("PlayerId: ~p~n", [PlayerId]),
		mod_ply_jobsch:remove_schedules(PlayerId)
	end,
	tst_prof:run(F, 10000). %% 1 loops, using time: 0ms

%%
%% Local Functions
%%
%% 产生一个介于Min到Max之间的随机整数
rand(Same, Same) -> Same;
rand(Min, Max) ->
    %% 如果没有种子，将从核心服务器中去获取一个种子，以保证不同进程都可取得不同的种子
   
    random:seed(os:timestamp()),
    M = Min - 1,
    random:uniform(Max - M) + M.