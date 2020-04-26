%%%--------------------------------------------------------------------
%%% @Module  : mod_lginout_TSL (TSL: test and set lock)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.3.17
%%% @Description: 本server用于辅助实现玩家（重新）上线和下线之间的同步
%%%-------------------------------------------------------------------
-module(mod_lginout_TSL).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0]).

-export([
        mark_tmp_logouting/1,
        mark_tmp_logout_done/1,
        mark_final_logout_done/1,
        do_mark_tmp_logout_done/1,
        do_mark_final_logout_done/1,
        mark_handle_game_logic_reconn_timeout_done/2,
        mark_enter_game_done/1,
        tsl/3, 
        tsl_2/3
    ]).

-include("debug.hrl").
-include("sys_code.hrl").
-include("lginout.hrl").

-record(flg, {
            flag = 0,
            unixtime = 0,
            reconn_timeout_done_sys_list = []  % 用于记录重连超时已处理完毕的系统
            }).

-define(FLG_ENTERING_GAME,   1).
-define(FLG_ENTER_GAME_DONE, 2).
-define(FLG_TMP_LOGOUTING,   3).
-define(FLG_TMP_LOGOUT_DONE, 4).
-define(FLG_FINAL_LOGOUTING, 5).
-define(FLG_HANDLING_GAME_LOGIC_RECONN_TIMEOUT, 6).
-define(FLG_HANDLE_GAME_LOGIC_RECONN_TIMEOUT_DONE, 7).


%% 需要处理重连超时的系统列表（目前有：组队，副本）
-define(NEED_HANDLE_RECONN_TIMEOUT_SYS_LIST, [?SYS_TEAM, ?SYS_DUNGEON]).



start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).



mark_tmp_logouting(PlayerId) ->
    gen_server:cast(?MODULE, {mark_tmp_logouting, PlayerId}).


mark_tmp_logout_done(PlayerId) ->
    % 委托到db queue mgr，是为了保证：玩家下线时，将其相关数据更新到DB后，才允许重新登录进游戏！
    db_queue_manage:mark_tmp_logout_done(PlayerId).


mark_final_logout_done(PlayerId) ->
    db_queue_manage:mark_final_logout_done(PlayerId).


do_mark_tmp_logout_done(PlayerId) ->
    gen_server:cast(?MODULE, {mark_tmp_logout_done, PlayerId}).


do_mark_final_logout_done(PlayerId) ->
    % 通过删除标记的方式，表示final logout已完成，同时也避免了数据残余！
    gen_server:cast(?MODULE, {del_flag, PlayerId}).


%% @para: SysCode => 系统代号（详见sys_code.hrl） 
mark_handle_game_logic_reconn_timeout_done(SysCode, PlayerId) ->
    gen_server:cast(?MODULE, {mark_handle_game_logic_reconn_timeout_done, SysCode, PlayerId}).

mark_enter_game_done(PlayerId) ->
    gen_server:cast(?MODULE, {mark_enter_game_done, PlayerId}).



%% test and set lock
%% 当所test的情况为false时，则set lock
tsl(t_is_logouting, sl_entering_game, [PlayerId]) ->
    case catch gen_server:call(?MODULE, {t_is_logouting, sl_entering_game, [PlayerId]}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("[mod_lginout_TSL] tsl(t_is_logouting, ..) for entering game, error!!! Reason: ~w", [Reason]),
            ?ASSERT(false, Reason),
            true;
        Bool ->
            ?ASSERT(is_boolean(Bool)), 
            Bool
    end;


tsl(t_is_handling_game_logic_reconn_timeout, sl_entering_game, [PlayerId]) ->
    case catch gen_server:call(?MODULE, {t_is_handling_game_logic_reconn_timeout, sl_entering_game, [PlayerId]}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("[mod_lginout_TSL] tsl(t_is_handling_game_logic_reconn_timeout, ..) for entering game, error!!! Reason: ~w", [Reason]),
            ?ASSERT(false, Reason),
            true;
        Bool ->
            ?ASSERT(is_boolean(Bool)), 
            Bool
    end;

% tsl(t_is_entering_game_or_enter_game_done, sl_tmp_logouting, [PlayerId]) ->
%     case catch gen_server:call(?MODULE, {t_is_entering_game_or_enter_game_done, sl_tmp_logouting, [PlayerId]}) of
%         {'EXIT', Reason} ->
%             ?ERROR_MSG("[mod_lginout_TSL] tsl() for tmp logout, timeout!!! Reason: ~w", [Reason]),
%             ?ASSERT(false, Reason),
%             false;
%         Bool ->
%             ?ASSERT(is_boolean(Bool)), 
%             Bool
%     end;

tsl(t_is_entering_game_or_enter_game_done, sl_final_logouting, [PlayerId]) ->
    case catch gen_server:call(?MODULE, {t_is_entering_game_or_enter_game_done, sl_final_logouting, [PlayerId]}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("[mod_lginout_TSL] tsl() for final logout, error!!! Reason: ~w", [Reason]),
            %%?ASSERT(false, Reason),
            false;
        Bool ->
            ?ASSERT(is_boolean(Bool)), 
            Bool
    end;


tsl(t_is_entering_game_or_enter_game_done, sl_handling_game_logic_reconn_timeout, [PlayerId]) ->
    case catch gen_server:call(?MODULE, {t_is_entering_game_or_enter_game_done, sl_handling_game_logic_reconn_timeout, [PlayerId]}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("[mod_lginout_TSL] tsl() for be kick out from team, error!!! Reason: ~w", [Reason]),
            ?ASSERT(false, Reason),
            false;
        Bool ->
            ?ASSERT(is_boolean(Bool)), 
            Bool
    end.
    

%% 和tsl()的区别是：在所test的情况为true时，才set lock
tsl_2(t_is_logout_done, sl_entering_game, [PlayerId]) ->
    case catch gen_server:call(?MODULE, {'tsl_on_true', t_is_logout_done, sl_entering_game, [PlayerId]}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("[mod_lginout_TSL] tsl_2(t_is_logout_done, ..) for entering game, error!!! Reason: ~w", [Reason]),
            ?ASSERT(false, Reason),
            false;
        Bool ->
            ?ASSERT(is_boolean(Bool)), 
            Bool
    end;


tsl_2(t_handle_game_logic_reconn_timeout_done, sl_entering_game, [PlayerId]) ->
    case catch gen_server:call(?MODULE, {'tsl_on_true', t_handle_game_logic_reconn_timeout_done, sl_entering_game, [PlayerId]}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("[mod_lginout_TSL] tsl_2(t_handle_game_logic_reconn_timeout_done, ..) for entering game, error!!! Reason: ~w", [Reason]),
            ?ASSERT(false, Reason),
            false;
        Bool ->
            ?ASSERT(is_boolean(Bool)), 
            Bool
    end.



    
% 作废！！
% %% test only：是否已完成了tmp logout或final logout
% test(t_is_logout_done, [PlayerId]) ->
%     gen_server:call(?MODULE, {t_is_logout_done, [PlayerId]});

% %% test only：角色被踢出队伍的处理是否已完成
% test(t_be_kick_out_from_team_done, [PlayerId]) ->
%     gen_server:call(?MODULE, {t_be_kick_out_from_team_done, [PlayerId]}).
    




% del_flag(PlayerId) ->
%     gen_server:cast(?MODULE, {del_flag, PlayerId}).







    

%% ---------------------------------------------------------------------------

init([]) ->
    process_flag(trap_exit, true),
    {ok, null}.


handle_call({t_is_logouting, sl_entering_game, [PlayerId]}, _From, State) ->
    Flag = get_flag__(PlayerId),
    %%?DEBUG_MSG("handle_call, t_is_logouting, sl_entering_game, PlayerId:~p, Flag:~w", [PlayerId, Flag]),
    Ret = case Flag of    % test
              null ->
                  false;
              _ ->
                  TimeNow = util:unixtime(),
                  is_tmp_logouting__(Flag, TimeNow)
                  orelse is_final_lgouting__(Flag, TimeNow)
          end,
    %%?DEBUG_MSG("handle_call, t_is_logouting, sl_entering_game, PlayerId:~p, Ret:~w", [PlayerId, Ret]),
    case Ret of
        true -> skip;
        false -> set_flag__(PlayerId, #flg{flag = ?FLG_ENTERING_GAME, unixtime = util:unixtime()})  % set lock
    end,
    {reply, Ret, State};


handle_call({t_is_handling_game_logic_reconn_timeout, sl_entering_game, [PlayerId]}, _From, State) ->
    Flag = get_flag__(PlayerId),
    Ret = case Flag of
              null ->
                  false;
              _ ->
                  TimeNow = util:unixtime(),
				  %% 这里判断超时？
                  is_handling_game_reconn_timeout__(Flag, TimeNow)
          end,
    case Ret of
        true -> skip;
        false -> set_flag__(PlayerId, #flg{flag = ?FLG_ENTERING_GAME, unixtime = util:unixtime()})
    end,
    {reply, Ret, State};


% 作废！！
% handle_call({t_is_entering_game_or_enter_game_done, sl_tmp_logouting, [PlayerId]}, _From, State) ->
%     Flag = get_flag__(PlayerId),
%     ?ASSERT(Flag /= undefined, PlayerId),
%     Ret = case Flag of
%               ?FLG_ENTERING_GAME ->
%                   true;
%               ?FLG_ENTER_GAME_DONE ->
%                   true;
%               _ ->
%                   false
%           end,
%     case Ret of
%         true -> skip;
%         false -> set_flag__(PlayerId, ?FLG_TMP_LOGOUTING)
%     end,
%     {reply, Ret, State};

 
handle_call({t_is_entering_game_or_enter_game_done, sl_final_logouting, [PlayerId]}, _From, State) ->
    Flag = get_flag__(PlayerId),
    ?ASSERT(Flag /= null, PlayerId),
    Ret = case Flag of
              null ->  % 容错
                  false;
              _ ->
                  (Flag#flg.flag == ?FLG_ENTERING_GAME) orelse (Flag#flg.flag == ?FLG_ENTER_GAME_DONE)
          end,
    case Ret of
        true -> skip;
        false -> set_flag__(PlayerId, #flg{flag = ?FLG_FINAL_LOGOUTING, unixtime = util:unixtime()})
    end,
    {reply, Ret, State};

handle_call({t_is_entering_game_or_enter_game_done, sl_handling_game_logic_reconn_timeout, [PlayerId]}, _From, State) ->
    Flag = get_flag__(PlayerId),
    ?ASSERT(Flag /= null, PlayerId),
    Ret = case Flag of
              null ->  % 容错
                  false;
              _ ->
                  (Flag#flg.flag == ?FLG_ENTERING_GAME) orelse (Flag#flg.flag == ?FLG_ENTER_GAME_DONE)
          end,
    case Ret of
        true -> skip;
        false -> set_flag__(PlayerId, #flg{flag = ?FLG_HANDLING_GAME_LOGIC_RECONN_TIMEOUT, unixtime = util:unixtime()})
    end,
    {reply, Ret, State};



handle_call({'tsl_on_true', t_is_logout_done, sl_entering_game, [PlayerId]}, _From, State) ->
    Flag = get_flag__(PlayerId),
    Ret = case Flag of
              null ->  % 标记不存在，表明已完成final logout（因final logout处理完后会清除标记）
                  true;
              _ ->
                  Flag#flg.flag == ?FLG_TMP_LOGOUT_DONE
          end,
    case Ret of
        true -> set_flag__(PlayerId, #flg{flag = ?FLG_ENTERING_GAME, unixtime = util:unixtime()});
        false -> skip
    end,
    %%%?DEBUG_MSG("[mod_lginout_TSL] tsl_on_true, TimeNow:~p, PlayerId:~p, t_is_logout_done:~p, Flag:~w", [util:unixtime(), PlayerId, Ret, Flag]),
    {reply, Ret, State};


handle_call({'tsl_on_true', t_handle_game_logic_reconn_timeout_done, sl_entering_game, [PlayerId]}, _From, State) ->
    Flag = get_flag__(PlayerId),
    Ret = case Flag of
              null ->
                  true;
              _ ->
                  Flag#flg.flag == ?FLG_HANDLE_GAME_LOGIC_RECONN_TIMEOUT_DONE
          end,
    case Ret of
        true -> set_flag__(PlayerId, #flg{flag = ?FLG_ENTERING_GAME, unixtime = util:unixtime()});
        false -> skip
    end,
    {reply, Ret, State};


% handle_call({t_is_logout_done, [PlayerId]}, _From, State) ->
%     Flag = get_flag__(PlayerId),
%     Ret = case Flag of
%               null ->  % 标记不存在，表明已完成final logout（因final logout处理完后会清除标记）
%                   true;
%               _ ->
%                   Flag#flg.flag == ?FLG_TMP_LOGOUT_DONE % 任一成立，则表明已完成tmp logout ---- 正确否？？？
%                   orelse Flag#flg.flag == ?FLG_BEING_KICK_OUT_FROM_TEAM
%                   orelse Flag#flg.flag == ?FLG_BE_KICK_OUT_FROM_TEAM_DONE
%           end,
%     {reply, Ret, State};

% handle_call({t_be_kick_out_from_team_done, [PlayerId]}, _From, State) ->
%     Flag = get_flag__(PlayerId),
%     Ret = case Flag of
%               null ->
%                   true;
%               _ ->
%                   Flag#flg.flag == ?FLG_BE_KICK_OUT_FROM_TEAM_DONE
%           end,
%     {reply, Ret, State};
	
handle_call(_Request, _From, State) ->
	?ASSERT(false, _Request),
    {reply, State, State}.


% handle_cast({'tmp_logout', PS, Delay}, State) ->
%     {noreply, State};



handle_cast({mark_tmp_logouting, PlayerId}, State) ->
    TimeNow = util:unixtime(),
    Flag = #flg{flag = ?FLG_TMP_LOGOUTING, unixtime = TimeNow},
    set_flag__(PlayerId, Flag),
    %%?DEBUG_MSG("[mod_lginout_TSL] mark_tmp_logouting, TimeNow:~p, PlayerId:~p, NewFlag:~w", [TimeNow, PlayerId, get_flag__(PlayerId)]),
    {noreply, State};

handle_cast({mark_tmp_logout_done, PlayerId}, State) ->
    TimeNow = util:unixtime(),
    ?TRACE("[mod_lginout_TSL] handle_cast, mark_tmp_logout_done, PlayerId:~p, TimeNow:~p~n", [PlayerId, util:unixtime()]),
    Flag = #flg{flag = ?FLG_TMP_LOGOUT_DONE, unixtime = TimeNow},
    set_flag__(PlayerId, Flag),
    %%?DEBUG_MSG("[mod_lginout_TSL] mark_tmp_logout_done, TimeNow:~p, PlayerId:~p, NewFlag:~w", [TimeNow, PlayerId, get_flag__(PlayerId)]),
    {noreply, State};

handle_cast({mark_handle_game_logic_reconn_timeout_done, SysCode, PlayerId}, State) ->
    ?DEBUG_MSG("[mod_lginout_TSL] mark_handle_game_logic_reconn_timeout_done, SysCode:~p, PlayerId:~p", [SysCode, PlayerId]),
    case get_flag__(PlayerId) of
        null ->
            ?ASSERT(false, {SysCode, PlayerId}),
            ?ERROR_MSG("[mod_lginout_TSL] mark_handle_game_logic_reconn_timeout_done error!! SysCode:~p, PlayerId:~p", [SysCode, PlayerId]),
            skip;
        Flag ->
            TimeNow = util:unixtime(),
            NewDoneList = [SysCode | Flag#flg.reconn_timeout_done_sys_list],
            % 是否所有系统的重连超时都处理完毕了？
            case (?NEED_HANDLE_RECONN_TIMEOUT_SYS_LIST -- NewDoneList) == [] of
                true ->
                    NewFlag = Flag#flg{flag = ?FLG_HANDLE_GAME_LOGIC_RECONN_TIMEOUT_DONE, unixtime = TimeNow, reconn_timeout_done_sys_list = NewDoneList},
                    ?DEBUG_MSG("[mod_lginout_TSL] all sys reconn timeout done!! SysCode:~p, PlayerId:~p, NewFlag:~w", [SysCode, PlayerId, NewFlag]),
                    set_flag__(PlayerId, NewFlag);
                false ->
                    NewFlag = Flag#flg{reconn_timeout_done_sys_list = NewDoneList},
                    ?DEBUG_MSG("[mod_lginout_TSL] all sys reconn timeout NOT done yet!! SysCode:~p, PlayerId:~p, NewFlag:~w", [SysCode, PlayerId, NewFlag]),
                    set_flag__(PlayerId, NewFlag)
            end
    end,
    {noreply, State};


handle_cast({mark_enter_game_done, PlayerId}, State) ->
    TimeNow = util:unixtime(),
    Flag = #flg{flag = ?FLG_ENTER_GAME_DONE, unixtime = TimeNow},
    set_flag__(PlayerId, Flag),
    {noreply, State};

handle_cast({del_flag, PlayerId}, State) ->
    ?ASSERT(get_flag__(PlayerId) /= null, PlayerId),
    del_flag__(PlayerId),
    %%?DEBUG_MSG("[mod_lginout_TSL] del_flag, PlayerId:~p", [PlayerId]),
    {noreply, State};
        
    
handle_cast(_Msg, State) ->
	?ASSERT(false, _Msg),
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
	case Reason of
		normal -> skip;
		shutdown -> skip;
		_ -> ?ERROR_MSG("[mod_lginout_TSL] !!!!!terminate!!!!! for reason: ~w", [Reason])
	end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.





%%========================================== Local Functions ===============================================




get_flag__(PlayerId) ->
    case get(PlayerId) of
        undefined ->
            null;
        Flag ->
            Flag
    end.

set_flag__(PlayerId, Flag) when is_record(Flag, flg) ->
    put(PlayerId, Flag).

del_flag__(PlayerId) ->
    erase(PlayerId),
    ?ASSERT(get_flag__(PlayerId) == null),
    void.




%% 暂时去掉容错时间，以免出现bug？
is_tmp_logouting__(Flag, TimeNow) ->
    (Flag#flg.flag == ?FLG_TMP_LOGOUTING)
    % 此处假定处理logout的时间最多不超过N秒，目的是为了容错，以免万一出bug后，程序一直认为角色在下线中，从而阻止角色重新进游戏，下同！
    andalso ((TimeNow - Flag#flg.unixtime) < ?MAX_HANDLE_LOGOUT_TIME).


is_final_lgouting__(Flag, TimeNow) ->
    (Flag#flg.flag == ?FLG_FINAL_LOGOUTING)
    andalso ((TimeNow - Flag#flg.unixtime) < ?MAX_HANDLE_LOGOUT_TIME).


is_handling_game_reconn_timeout__(Flag, TimeNow) ->
    (Flag#flg.flag == ?FLG_HANDLING_GAME_LOGIC_RECONN_TIMEOUT)
    % 此处假定处理游戏逻辑重连超时的时间最多不超过N秒，目的是为了容错，以免万一出bug后，程序一直认为角色正在处理游戏逻辑重连超时，从而阻止角色重新进游戏！
    andalso ((TimeNow - Flag#flg.unixtime) < ?MAX_HANDLE_GAME_LOGIC_RECONN_TIMEOUT_TIME).

