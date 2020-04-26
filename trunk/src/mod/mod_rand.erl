%%%-----------------------------------
%%% @Module  : mod_rand
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.06.18
%%% @Description: 随机种子
%%%-----------------------------------
-module(mod_rand).

-export([
        make_seed/0
        ]).


-include("debug.hrl").

%% 生成随机种子
make_seed() ->
    <<A:32, B:32, C:32>> = crypto:strong_rand_bytes(12),
    ?TRACE("make_seed(), A:~p, B:~p, C:~p~n", [A, B, C]),
    % {A, B, C}.

    random:seed({A, B, C}),
	Seed0 = {random:uniform(9999999), random:uniform(9999999), random:uniform(9999999)},
	random:seed(Seed0),
	Seed = {random:uniform(9999999), random:uniform(9999999), random:uniform(9999999)},

	?TRACE("make_seed(), Seed0: ~p, Seed: ~p~n", [Seed0, Seed]),
	Seed.







% old：
% -behaviour(gen_server).
% -export([
%         start_link/0,
%         get_seed/0,
%         make_seed/0
%     ]
% ).
% -export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

% -include("common.hrl").

% -record(state, {seed}).

% %% --- 对外接口 ---------------------------------

% %% 启动服务器
% start_link() ->
%     gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


% %% 生成随机种子
% make_seed() ->
%     <<A:32, B:32, C:32>> = crypto:strong_rand_bytes(12),
%     ?TRACE("make_seed(), A:~p, B:~p, C:~p~n", [A, B, C]),
%     {A, B, C}.


% %% 取得一个随机数种子
% get_seed() ->
% 	% To-Do: 这里要不要容错呢？因为发现有时关服时这里会出现noproc错误，估计是在本进程关闭后，还有地方调用get_seed()。先容错，后面再细查。
% 	case catch gen:call(?MODULE, '$gen_call', get_seed) of
% 		{ok,Res} ->
% 			Res;
% 		{'EXIT',Reason} ->
% 			?ERROR_MSG("get seed error, reason:~w", [Reason]),
% 			random:seed(erlang:now()),
% 			{random:uniform(99999), random:uniform(999999), random:uniform(999999)}
% 	end.

% %% --- 服务器内部实现 ---------------------------------

% init([]) ->
%     State = #state{},
%     {ok, State}.

% %% 返回一个随机数组合做为其它进程的随机数种子
% handle_call(get_seed, _From, State) ->
%     case State#state.seed of
%         undefined -> random:seed(erlang:now());
%         S -> random:seed(S)
%     end,
%     Seed = {random:uniform(99999), random:uniform(999999), random:uniform(999999)},
%     {reply, Seed, State#state{seed = Seed}};

% handle_call(_Request, _From, State) ->
%     {noreply, State}.

% handle_cast(_Msg, State) ->
%     {noreply, State}.

% handle_info(_Info, State) ->
%     {noreply, State}.

% terminate(_Reason, _State) ->
%     ok.

% code_change(_OldVsn, State, _Extra) ->
%     {ok, State}.


