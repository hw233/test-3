%% =============================================
%% @Module     : mod_global_collection.erl
%% @Author     : lidasheng
%% @Mail       : lidasheng17@gmail.com
%% @CreateDate : 2014-12-08
%% @Encoding   : UTF-8
%% @Desc       : 
%% =============================================

-module(mod_global_collection). 

-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include("debug.hrl").
-include("log.hrl").
-include("prompt_msg_code.hrl").

%% --------------------------------------------------------------------
%% External exports  mod_global_collection:do_desire_pool(10,1).

-export([
    start_link/0
    ,query_snowman/1
    ,collection_snowman/1
    ,open_snowman_activity/2
    ,close_snowman_activity/0
    ,save_data_on_close/0
    ,do_desire_pool/2
    ]).

-record(snow_man, {
    state = 0
    ,num = 0
    ,actors = ordsets:new()
    ,start_time = 0
    ,end_time = 0
    }).

-record(state, {
    snow_man = #snow_man{}
    }).



-define(ACTIVITY_COLLENTION_SNOWMAN, 20).

%% ====================================================================
%% Behavioural functions 
%% ====================================================================

%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:init-1">gen_server:init/1</a>
-spec init(Args :: term()) -> Result when
    Result :: {ok, State}
            | {ok, State, Timeout}
            | {ok, State, hibernate}
            | {stop, Reason :: term()}
            | ignore,
    State :: term(),
    Timeout :: non_neg_integer() | infinity.
%% ====================================================================
init([]) -> 
    process_flag(trap_exit, true),
    start_save_timer(),
    State1 = init_snow_man(#state{}),
    {ok, State1}.
    

%% handle_call/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_call-3">gen_server:handle_call/3</a>
-spec handle_call(Msg :: term(), From :: {pid(), Tag :: term()}, State :: term()) -> Result when
    Result :: {reply, Reply, NewState}
            | {reply, Reply, NewState, Timeout}
            | {reply, Reply, NewState, hibernate}
            | {noreply, NewState}
            | {noreply, NewState, Timeout}
            | {noreply, NewState, hibernate}
            | {stop, Reason, Reply, NewState}
            | {stop, Reason, NewState},
    Reply :: term(),
    NewState :: term(),
    Timeout :: non_neg_integer() | infinity,
    Reason :: term().
%% ====================================================================
handle_call(Msg, From, State) ->
    try
        do_call(Msg, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("[~p] do_call error! Msg = ~p, From = ~p, Err = ~p, Reason = ~p~n stacktrace = ~p~n", 
                [?MODULE, Msg, From, Err, Reason, erlang:get_stacktrace()]),
            {reply, error, State}
    end.


%% handle_cast/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_cast-2">gen_server:handle_cast/2</a>
-spec handle_cast(Msg :: term(), State :: term()) -> Result when
    Result :: {noreply, NewState}
            | {noreply, NewState, Timeout}
            | {noreply, NewState, hibernate}
            | {stop, Reason :: term(), NewState},
    NewState :: term(),
    Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_cast(Msg, State) ->
    try
        do_cast(Msg, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("[~p] do_cast error! Msg = ~p, Err = ~p, Reason = ~p~n stacktrace = ~p~n", 
                [?MODULE, Msg, Err, Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.    


%% handle_info/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_info-2">gen_server:handle_info/2</a>
-spec handle_info(Msg :: timeout | term(), State :: term()) -> Result when
    Result :: {noreply, NewState}
            | {noreply, NewState, Timeout}
            | {noreply, NewState, hibernate}
            | {stop, Reason :: term(), NewState},
    NewState :: term(),
    Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_info(Msg, State) ->
    try
        do_info(Msg, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("[~p] do_info error! Msg = ~p, Err = ~p, Reason = ~p~n stacktrace = ~p~n", 
                [?MODULE, Msg, Err, Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end. 


%% terminate/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:terminate-2">gen_server:terminate/2</a>
-spec terminate(Reason, State :: term()) -> Any :: term() when
    Reason :: normal
            | shutdown
            | {shutdown, term()}
            | term().
%% ====================================================================
terminate(_Reason, _State) ->
    % save_data(State),
    ok.


%% code_change/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:code_change-3">gen_server:code_change/3</a>
-spec code_change(OldVsn, State :: term(), Extra :: term()) -> Result when
    Result :: {ok, NewState :: term()} | {error, Reason :: term()},
    OldVsn :: Vsn | {down, Vsn},
    Vsn :: term().
%% ====================================================================
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.



%% ====================================================================
%% External functions 
%% ====================================================================

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


query_snowman(Status) ->
    gen_server:cast(?MODULE, {'query_snowman', player:get_pid(Status)}).

do_desire_pool(Count, Type) ->
	 gen_server:cast(?MODULE, {'set_desire_integral', Count, Type}).


% -define(SNOW_BALL_NO, 4101).
collection_snowman(Status) ->
    RoleId = player:id(Status),
    Item = data_snowman:get_info(item_no),
    Num = mod_inv:get_goods_count_in_bag_by_no(RoleId, Item),
    case Num > 0 of
        false -> skip;
        true -> 
            mod_inv:destroy_goods_WNC(RoleId, [{Item, Num}], [?LOG_SNOW_MAN, "collection"]),
            gen_server:cast(?MODULE, {'collect_snowman', RoleId, Num})
    end,
    ?LDS_TRACE(collection_snowman, Num),
    {ok, BinData} = pt_29:write(29102, [Num]),
    lib_send:send_to_uid(RoleId, BinData).


open_snowman_activity(StartTime, EndTime) ->
    gen_server:cast(?MODULE, {'open_snowman_activity', StartTime, EndTime}).


close_snowman_activity() -> 
    % gen_server:cast(?MODULE, 'close_snowman_activity').
    erlang:whereis(?MODULE) ! 'close_snowman_activity'.


save_data_on_close() ->
    erlang:whereis(?MODULE) ! 'save_data_on_close'.

% daily_operation() ->
%     erlang:send_after(?SAVE_TIMER_INTEVAL, ?MODULE, 'save_data').


%% ====================================================================
%% Internal functions
%% ====================================================================

%，1代表加分,2扣去百分比
do_call({set_desire_integral, Value, Type}, _From,  State) ->
case Type of
1 ->
[{_,PoolValue}] = ets:lookup(ets_desire_integral_pool, desire_integral),
ets:insert(ets_desire_integral_pool, {desire_integral, PoolValue + Value} ),
db:update(global_sys_var, [{var, util:term_to_bitstring(PoolValue + Value)}],[{sys,1005}]);
2 ->
[{_,PoolValue}] = ets:lookup(ets_desire_integral_pool, desire_integral),
ets:insert(ets_desire_integral_pool, {desire_integral, PoolValue -  Value} ),
db:update(global_sys_var, [{var,util:term_to_bitstring(PoolValue -  Value)}] , [{sys,1005}])
end,
{reply, skip, State};

do_call(_Msg, _From, State) ->
throw({nomatch, do_call, _Msg}),
{reply, error, State}.


do_cast({'open_snowman_activity', StartTime, EndTime}, State) ->
    case (State#state.snow_man)#snow_man.state =:= 1 of
        true -> 
            ?LDS_DEBUG(open_snowman_activity, 1),
            {noreply, State};
        false ->
            NewSnow = #snow_man{state = 1, start_time = StartTime, end_time = EndTime},
            save_snowman_data(NewSnow),
            ?LDS_DEBUG(open_snowman_activity, 2),
            start_close_timer(EndTime),
            {noreply, State#state{snow_man = NewSnow}}
    end;


% do_cast('close_snowman_activity', State) ->
%     NewSnow = send_snowman_reward(State#state.snow_man),
%     save_snowman_data(NewSnow),
%     {noreply, State#state{snow_man = NewSnow}};


do_cast({'collect_snowman', RoleId, Num}, State) ->
    Snow = State#state.snow_man,
    case Snow#snow_man.state =:= 1 of
        true ->
            case Snow#snow_man.num >= data_snowman:get_info(max_num) of
                true -> 
                    lib_send:send_prompt_msg(RoleId, ?PM_ACTIVITY_SNOWMAN_LIMIT),
                    NewSnow = Snow#snow_man{
                        actors = ordsets:add_element(RoleId, Snow#snow_man.actors)},
                    {noreply, State#state{snow_man = NewSnow}};
                false ->
                    NewSnow = Snow#snow_man{num = Snow#snow_man.num + Num, 
                        actors = ordsets:add_element(RoleId, Snow#snow_man.actors)},
                    {noreply, State#state{snow_man = NewSnow}}
            end;
        false ->
            lib_send:send_prompt_msg(RoleId, ?PM_ACTIVITY_OVER),
            {noreply, State}
    end;

%，1代表加分,2扣去百分比
do_cast({set_desire_integral, Value, Type}, State) ->
    case Type of
		1 ->
			[{_,PoolValue}] = ets:lookup(ets_desire_integral_pool, desire_integral),
			ets:insert(ets_desire_integral_pool, {desire_integral, PoolValue + Value} ),
			db:update(global_sys_var, [{var, util:term_to_bitstring(PoolValue + Value)}],[{sys,1005}]);
		2 ->
			[{_,PoolValue}] = ets:lookup(ets_desire_integral_pool, desire_integral),
			ets:insert(ets_desire_integral_pool, {desire_integral, PoolValue -  Value} ),
			db:update(global_sys_var, [{var,util:term_to_bitstring(PoolValue -  Value)}] , [{sys,1005}])
	end,
	{noreply, State};
			


do_cast({'query_snowman', FromPid}, State) ->
    gen_server:cast(FromPid, {'snowman_num', (State#state.snow_man)#snow_man.num}),
    {noreply, State};


do_cast(info, State) ->
    ?LDS_TRACE(info, State),
    {noreply, State};

do_cast(_Msg, State) -> 
    throw({nomatch, do_cast, _Msg}),
    {noreply, State}.


do_info('save_data', State) ->
    save_data(State),
    start_save_timer(),
    {noreply, State};

do_info('save_data_on_close', State) ->
    save_data(State),
    {noreply, State};

do_info('close_snowman_activity', State) ->
    ?LDS_DEBUG(start_close_timer, ok),
    case (State#state.snow_man)#snow_man.state =:= 1 of
        true ->
            NewSnow = send_snowman_reward(State#state.snow_man),
            save_snowman_data(NewSnow),
            {noreply, State#state{snow_man = NewSnow}};
        false -> 
            {noreply, State#state{snow_man = #snow_man{}}}
    end;

do_info(_Msg, State) ->
    throw({nomatch, do_info, _Msg}),
    {noreply, State}.


%% @return : new #state{}
init_snow_man(State) ->
    case db:select_all(global_activity_data, "data", [{no, ?ACTIVITY_COLLENTION_SNOWMAN}]) of
        [[Data] | _] ->
            Term = util:bitstring_to_term(Data),
            Num = erlang:element(#snow_man.num, Term),
            SnowState = erlang:element(#snow_man.state, Term),
            Actors = erlang:element(#snow_man.actors, Term),
            StartTime = erlang:element(#snow_man.start_time, Term),
            EndTime = erlang:element(#snow_man.end_time, Term),
            ?ASSERT(ordsets:is_set(Actors)),
            case SnowState =:= 1 of
                true -> start_close_timer(EndTime);
                false -> skip
            end,
            State#state{snow_man = #snow_man{state = SnowState, num = Num, actors = Actors, 
                start_time = StartTime, end_time = EndTime}};
        [] -> State;
        _ -> erlang:error({?MODULE, init_snow_man}), State
    end.


start_close_timer(EndTime) when EndTime > 0 ->
    Now = util:unixtime(),
    Inteval = EndTime - Now,
    ?LDS_DEBUG(start_close_timer, Inteval),
    case Inteval > 0 of
        true -> erlang:send_after(Inteval * 1000, self(), 'close_snowman_activity');
        false -> self() ! 'close_snowman_activity'
    end;
start_close_timer(_) -> skip.


-define(SAVE_TIMER_INTEVAL, 3600000).
start_save_timer() ->
    erlang:send_after(?SAVE_TIMER_INTEVAL, self(), 'save_data').


save_data(State) ->
    save_snowman(State),
    ok.


save_snowman(State) ->
    case (State#state.snow_man)#snow_man.state =:= 1 of
        true -> save_snowman_data(State#state.snow_man);
        false -> skip
    end.

save_snowman_data(Data) when is_record(Data, snow_man) ->
    case util:term_to_bitstring(Data) of
        Bin when is_binary(Bin) -> 
            db:replace(global_activity_data, 
                [{no, ?ACTIVITY_COLLENTION_SNOWMAN}, {data, Bin}]),
            ok;
        _T -> 
            ?ERROR_MSG("[~p] save_snowman error = ~p~n", [?MODULE, _T]),
            error
    end;
save_snowman_data(_) -> skip.


%% @return : #snow_man{} 
send_snowman_reward(#snow_man{num = 0}) -> #snow_man{};
send_snowman_reward(Snow) ->
    Num = Snow#snow_man.num,
    {Rate, Index} = cal_snow_rate(Num),
    MoneyNo = data_snowman:get_info(money_no),
    ItemNo = data_snowman:get_info(item_no),
    MoneyNum = util:floor(data_snowman:get_info(money_num) * Rate * Num),
    List = [{MoneyNo, MoneyNum}],
    ItemName = tool:to_binary(lib_goods:get_name(ItemNo)),
    MoneyName = tool:to_binary(lib_goods:get_name(MoneyNo)),
    Content = 
        << <<"由于全服玩家的积极参与，在活动期间总共收集到">>/binary, ItemName/binary, (tool:to_binary(Num))/binary, 
        <<"个，达到奖励第">>/binary, (tool:to_binary(Index))/binary, <<"阶段，奉上">>/binary, MoneyName/binary, 
        (tool:to_binary(MoneyNum))/binary, <<"作为谢礼，并祝官人节日快乐。">>/binary >>,
    F = fun(RoleId) -> 
        lib_mail:send_sys_mail(RoleId, <<"堆雪人活动奖励">>, tool:to_binary(Content), List, [?LOG_MAIL, ?LOG_SNOW_MAN])
    end,
    spawn(fun() -> lists:foreach(F, ordsets:to_list(Snow#snow_man.actors)) end),
    #snow_man{}.


%% @return : {Rate, Index}
cal_snow_rate(Num) ->
    List = data_snowman:get_num_list(),
    cal_snow_rate(Num, List, 1).


cal_snow_rate(_Num, [], Index) -> {1, Index};
cal_snow_rate(_Num, [E], Index) -> {data_snowman:get_rate(E), Index};
cal_snow_rate(Num, [E1, E2 | Left], Index) ->
    case Num < E1 of
        true -> {1, Index};
        false -> 
            case Num >= E1 andalso Num < E2 of
                true -> 
                    Rate = data_snowman:get_rate(E1),
                    {Rate, Index};
                false -> 
                    cal_snow_rate(Num, [E2 | Left], Index + 1)
            end
    end.
