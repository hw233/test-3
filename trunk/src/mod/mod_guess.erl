%%%------------------------------------
%%% @Module  : mod_guess
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2018.5.24  -- zhengjy
%%% @Description: 竞猜活动进程
%%%------------------------------------
-module(mod_guess).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start_link/0,
		add_total/3
        ]).

-include("common.hrl").
-include("record.hrl").
-include("scene.hrl").
-include("monster.hrl").
-include("ets_name.hrl").
-include("npc.hrl").
-include("pt_12.hrl").
-include("abbreviate.hrl").
-include("home.hrl").
-include("record/battle_record.hrl").
-include("goods.hrl").
-include("log.hrl").
-include("prompt_msg_code.hrl").
-include("pt_37.hrl").
-include("activity.hrl").


-record(state, {}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
    


add_total(GuessId, RmbBet, CupBet) ->
	gen_server:cast(?MODULE, {add_total, GuessId, RmbBet, CupBet}).



%% ===================================================================================================================

init([]) ->
    process_flag(trap_exit, true),
	%% 	启动定时计划，目前需要定时处理竞猜活动数据同步，同步的过程中如果后台已经录入了竞猜答案则直接做结算（暂定5分钟一次？）
	start_timer(),
    State = #state{},
	erlang:spawn(fun lib_guess:init_guess_data/0),
    {ok, State}.

handle_call(Request, From, State) ->
	try
		do_handle_call(Request, From, State)
	catch 
		Error:Reason ->
			?ERROR_MSG("{Error, Reason, erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
			{reply, State, State}
	end.


do_handle_call(_Request, _From, State) ->
    {reply, State, State}.

% %% 统一模块+过程调用(cast)
% do_handle_cast({apply_cast, Module, Method, Args}, State) ->
% 	case (catch apply(Module, Method, Args)) of
% 		 {'EXIT', Info} ->	
% 			 ?WARNING_MSG("mod_scene__apply_cast error: Module=~p, Method=~p, Reason=~p",[Module, Method, Info]),
% 			 error;
% 		 _ -> skip
% 	end,
%     {noreply, State};


handle_cast(Request, State) ->
	try
		do_handle_cast(Request, State)
	catch 
		Error:Reason ->
			?ERROR_MSG("{Error, Reason, erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
			{noreply, State}
	end.


do_handle_cast({add_total, GuessId, RmbBet, CupBet}, State) ->
	case ets:lookup(?ETS_GUESS_QUESTION, GuessId) of
		[#guess_question{total_rmb = TotalRmb, total_cup = TotalCup}] ->
			TotalRmb2 = TotalRmb + RmbBet,
			TotalCup2 = TotalCup + CupBet,
			ets:update_element(?ETS_GUESS_QUESTION, GuessId, [{#guess_question.total_rmb, TotalRmb2}, {#guess_question.total_cup, TotalCup2}]);
		[] ->
			?ERROR_MSG("Unknown Error : ~p~n", [{add_total, GuessId, RmbBet, CupBet}])
	end,
	{noreply, State};


do_handle_cast(_Msg, State) ->
    {noreply, State}.


handle_info(Request, State) ->
	try
		do_handle_info(Request, State)
	catch 
		Error:Reason ->
			?ERROR_MSG("{Error, Reason} : ~p~n", [{erlang:get_stacktrace(), Error, Reason}]),
			{reply, State, State}
	end.


do_handle_info({timeout, _TimerRef, timer}, State) ->
	start_timer(),
	lib_guess:sync_center_data(),
	try
		lib_guess:guess_settle()
	catch
		E2:R2 ->
			?ERROR_MSG("{E2,R2} : ~n~p~n", [{erlang:get_stacktrace(),E2,R2}])
	end,
	{noreply, State};

do_handle_info(Info, State) ->
	?ERROR_MSG("UnDeal Info : ~p~n", [Info]),
    {noreply, State}.



terminate(Reason, _State) ->
    ?TRACE("[mod_scene_mgr] terminate for reason: ~w~n", [Reason]),
    case Reason of
        normal -> skip;
        shutdown -> skip;
        {shutdown, _} -> skip;
        _ ->
            ?ERROR_MSG("[~p] !!!!!terminate!!!!! for reason: ~w", [?MODULE, Reason])
    end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.



start_timer() ->
	erlang:start_timer(180* 1000, self(), timer).  %暂时改为30秒

