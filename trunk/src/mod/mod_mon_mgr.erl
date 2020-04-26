%%%------------------------------------
%%% @Module  : mod_mon_mgr
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.05.12
%%% @Modified: 2013.6.16  -- huangjf
%%% @Description: 明雷怪管理
%%%------------------------------------
-module(mod_mon_mgr).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start_link/0,
        battle_feedback/2,
        do_clear_mon/1,

        add_to_mon_id_set/1,
        del_from_mon_id_set/1,

        on_server_clock_tick/2,
        dbg_assert_no_mons_in_scene/1
        ]).

-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("monster.hrl").
-include("ets_name.hrl").
-include("abbreviate.hrl").
-include("record/battle_record.hrl").

-record(state, {
        % auto_id = 1,  % 该字段作废

        mon_id_set = undefined,   % 全服的明雷怪对象id的集合

        time_to_update_mons_bhv = 0,
        time_to_clear_expired_mons = 0,
        time_to_clear_residual_mons = 0
        }).


%% 进程字典的key名
-define(PDKN_MON_IS_BEING_CLEARED, mon_is_being_cleared).




start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


%% 废弃！！
% %% 快速创建怪物，  注：“快速”是指创建时只是做了最简单的初始化工作。  如有需要，上层函数可以用返回值做进一步的初始化!
% %% @return: {ok, 新创建的怪物} | fail
% fast_create_mon([MonNo, SceneId, X, Y]) ->
%     gen_server:call(?MODULE, {'fast_create_mon', [MonNo, SceneId, X, Y]}).






% %% 获取下一个有效的明雷怪id
% %% @return: fail | {ok, NewMonId}
% get_next_id()->
%     case catch gen_server:call(?MODULE, 'get_next_id') of
%         {'EXIT', _Reason} ->
%             ?ERROR_MSG("[mod_mon_mgr] get_next_id() failed!! reason: ~w", [_Reason]),
%             fail;
%         NewMonId when is_integer(NewMonId) ->
%             {ok, NewMonId}
%     end.



battle_feedback(MonId, FeedbackInfo) ->
    gen_server:cast(?MODULE, {'battle_feedback', MonId, FeedbackInfo}).



    
%% 清除单个怪物， 注：直接从ets删除，而没有先做其他清理工作。  上层函数可以先做其他一些必要的清理工作，然后再调用此接口。
do_clear_mon(MonId) ->
	?TRACE("do_clear_mon, mon id: ~p~n", [MonId]),
    gen_server:cast(?MODULE, {'do_clear_mon', MonId}).
    %%mod_mon:del_mon_from_ets(MonId).




%% 添加明雷怪对象id到集合
add_to_mon_id_set(MonId) ->
    gen_server:cast(?MODULE, {'add_to_mon_id_set', MonId}).

del_from_mon_id_set(MonId) ->
    gen_server:cast(?MODULE, {'del_from_mon_id_set', MonId}).




on_server_clock_tick(CurTickCount, CurUnixTime) ->
    gen_server:cast(?MODULE, {'on_server_clock_tick', CurTickCount, CurUnixTime}).
    


-ifdef(debug).
%% （场景清除后）断言没有怪物属于某个场景， 仅仅用于调试！
dbg_assert_no_mons_in_scene(SceneId) ->
    gen_server:cast(?MODULE, {'dbg_assert_no_mons_in_scene', SceneId}).

-else.

dbg_assert_no_mons_in_scene(_SceneId) ->
    void.

-endif.

    



%% ===================================================================================================
    
init([]) ->
    process_flag(trap_exit, true),
    State = #state{
                % auto_id = 1,  % 明雷怪id从1开始

                mon_id_set = sets:new(),

                time_to_update_mons_bhv = 0,
                time_to_clear_expired_mons = 0,  % TODO：确认----初始化为0是否ok？？
                time_to_clear_residual_mons = 0
                }, 
    {ok, State}.



%% 更新明雷怪行为的时间间隔（单位：秒）
-define(UPDATE_MONS_BHV_INTV, 8).

%% 清除过期的明雷怪的时间间隔（单位：秒）
-define(CLEAR_EXPIRED_MONS_INTV, 8).

%% 清除过期的明雷怪的时间间隔的浮动范围（单位：秒）
-define(CLEAR_EXPIRED_MONS_INTV_FLOATING, 0).


%% 清除残余的明雷怪的时间间隔（单位：秒）
-define(CLEAR_RESIDUAL_MONS_INTV, 120).

%% 清除残余的明雷怪的时间间隔的浮动范围（单位：秒）
-define(CLEAR_RESIDUAL_MONS_INTV_FLOATING, 30).


handle_cast({'battle_feedback', MonId, FeedbackInfo} , State) ->
    ?TRY_CATCH(battle_feedback__(MonId, FeedbackInfo), ErrReason),
    {noreply, State};



handle_cast({'do_clear_mon', MonId} , State) ->
    ?TRY_CATCH(do_clear_mon__(MonId), ErrReason),
    {noreply, State};



handle_cast({'add_to_mon_id_set', MonId} , State) ->
    OldSet = State#state.mon_id_set,
    ?ASSERT(not sets:is_element(MonId, OldSet), {MonId, sets:to_list(OldSet)}),
    NewSet = sets:add_element(MonId, OldSet),
    ?DEBUG_MSG("add_to_mon_id_set, MonId:~p, NewSetSize:~p", [MonId, sets:size(NewSet)]),
    NewState = State#state{mon_id_set = NewSet},
    {noreply, NewState};


handle_cast({'del_from_mon_id_set', MonId} , State) ->
    OldSet = State#state.mon_id_set,
    ?ASSERT(sets:is_element(MonId, OldSet), {MonId, sets:to_list(OldSet)}),
    NewSet = sets:del_element(MonId, OldSet),
    ?DEBUG_MSG("del_from_mon_id_set, MonId:~p, NewSetSize:~p", [MonId, sets:size(NewSet)]),
    NewState = State#state{mon_id_set = NewSet},
    {noreply, NewState};


handle_cast({'on_server_clock_tick', _CurTickCount, CurUnixTime} , State) ->
    NewState =  case CurUnixTime >= State#state.time_to_update_mons_bhv of
                    true ->
                        ?TRY_CATCH(foreach_mon(State, CurUnixTime), ErrReason),

                        State2 = State#state{time_to_update_mons_bhv = CurUnixTime + ?UPDATE_MONS_BHV_INTV},
                        State3 = case CurUnixTime >= State#state.time_to_clear_expired_mons of
                                    true ->
                                        NextTimeToClearExpiredMons = CurUnixTime + ?CLEAR_EXPIRED_MONS_INTV +  util:rand(0, ?CLEAR_EXPIRED_MONS_INTV_FLOATING),
                                        State2#state{time_to_clear_expired_mons = NextTimeToClearExpiredMons};
                                    false ->
                                        State2
                                end,
                        State4 = case CurUnixTime >= State#state.time_to_clear_residual_mons of
                                    true ->                                        
                                        NextTimeToClearResidualMons = CurUnixTime + ?CLEAR_RESIDUAL_MONS_INTV +  util:rand(0, ?CLEAR_RESIDUAL_MONS_INTV_FLOATING),
                                        State3#state{time_to_clear_residual_mons = NextTimeToClearResidualMons};
                                    false ->
                                        State3
                                end,

                        State4;

                    false ->
                        State
                end,            

    {noreply, NewState};


handle_cast({'dbg_assert_no_mons_in_scene', _SceneId}, State) ->
    ?ASSERT(ets:match_object(?ETS_MON, #mon{scene_id = _SceneId, _ = '_'}) =:= []),
    {noreply, State};



handle_cast(_R , State) ->
    ?ASSERT(false, _R),
    {noreply, State}.


% %% 创建怪物
% handle_call({'fast_create_mon', [MonNo, SceneId, X, Y]} , _From, State) ->
%     case mod_mon_tpl:get_tpl_data(MonNo) of
%         null ->
%             ?ASSERT(false, MonNo),
%             {reply, fail, State};
%         MonTpl ->
%             NewMonId = State#state.auto_id,
%             NewMon = MonTpl#mon{
%                         id = NewMonId,
%                         x = X,
%                         y = Y,
%                         scene_id = SceneId
%                         },
%             mod_mon:add_mon_to_ets(NewMon),
%             {reply, {ok, NewMon}, State#state{auto_id = NewMonId + 1}}
%     end;



% %% 获取下一个有效的明雷怪id
% handle_call('get_next_id' , _From, State) ->
%     NewMonId = State#state.auto_id,
%     {reply, NewMonId, State#state{auto_id = NewMonId + 1}};



handle_call(_R , _From, State) ->
    ?ASSERT(false, _R),
    {reply, ok, State}.

% %%todo:查询mid为none的怪物重新启动
% handle_info({'EXIT', _Mid, _Reason}, State) ->
%     {noreply, State};

handle_info(_Reason, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
    case Reason of
        normal -> skip;
        shutdown -> skip;
        {shutdown, _} -> skip;
        _ ->
            ?ERROR_MSG("[~p] !!!!!terminate!!!!! for reason: ~w", [?MODULE, Reason])
    end,
    ok.

code_change(_OldVsn, State, _Extra)->
	{ok, State}.





battle_feedback__(MonId, FeedbackInfo) ->
    case mod_mon:get_obj(MonId) of
        null ->
            skip;
        MonObj ->
            ?TRACE("[mod_mon] battle_feedback(), MonId=~p~n", [MonId]),
            % 如果过期则立即清除
            case mod_mon:is_expired(MonObj) of
                true ->
                    ?DEBUG_MSG("[mod_mon_mgr] battle_feedback(), mon expired.... MonId:~p, TimeNow:~p, MonExpireTime:~p~n", [MonId, svr_clock:get_unixtime(), MonObj#mon.expire_time]),
                    mod_scene:clear_mon_from_scene_WNC(MonId);
                false ->
                    % 先恢复为空闲
                    MonObj2 = mod_mon:mark_idle(MonObj),
                    
                    case FeedbackInfo#btl_feedback.result of
                        win ->
                            skip;
                        draw ->
                            skip;
                        lose ->
                            BeKilledTimes_Old = mod_mon:get_acc_be_killed_times(MonObj2),
                            BeKilledTimes_New = BeKilledTimes_Old + 1,
                            case mod_mon:need_cleared_after_die(MonObj2) of
                                true ->
                                    ?TRACE("[mod_mon] battle_feedback(), need_cleared_after_die, MonId=~p~n", [MonId]), 
                                    case mod_mon:get_can_be_killed_times(MonObj2) of
                                        infinite ->
                                            skip;
                                        CanBeKilledTimes ->
                                            case BeKilledTimes_New >= CanBeKilledTimes of
                                                true ->
                                                    ?TRACE("[mod_mon] battle_feedback(), BeKilledTimes_New=~p, CanBeKilledTimes=~p~n", [BeKilledTimes_New, CanBeKilledTimes]),
                                                    mod_scene:clear_mon_from_scene_WNC(MonId);
                                                false ->
                                                    % 递增累计已被杀死的次数
                                                    MonObj3 = MonObj2#mon{acc_be_killed_times = BeKilledTimes_New},
                                                    mod_mon:update_mon_to_ets(MonObj3)
                                            end                                            
                                    end;
                                false ->
                                    ?TRACE("[mod_mon] battle_feedback(), NOT need_cleared_after_die, MonId=~p~n", [MonId]),
                                    skip
                            end
                    end

                    % try_mark_idle(MonId)

                    % % 如果已过期，则立即清除
                    % case is_expired(MonObj) of
                    %     true -> mod_scene:clear_mon_from_scene_WNC(MonId);
                    %     false -> skip
                    % end
            end                    
    end.




% %% 更新所有怪物的行为（fsm）
% update_mons_behavior(MonList) ->
%     lists:foreach(fun update_one_mon_bhv/1, MonList).







foreach_mon(State, CurUnixTime) ->
    MonIdSet = State#state.mon_id_set,

    % ?TRACE("[mod_mon_mgr] foreach_mon, MonIdSet:~w~n", [sets:to_list(MonIdSet)]),

    ?Ifc (sets:size(MonIdSet) > 3000 andalso (erlang:get('__already_warn_so_many_mons__') == undefined))
        ?WARNING_MSG("[mod_mon_mgr] mon count > 3000!!!!!!!!", []),
        erlang:put('__already_warn_so_many_mons__', true)
    ?End,

    F = fun(MonId, _Acc) ->
            ?ASSERT(is_integer(MonId), MonId),
            case mod_mon:get_obj(MonId) of
                null ->
                    skip;
                MonObj ->
                    handle_one_mon(MonObj, State, CurUnixTime)
            end,
            void
        end,

    sets:fold(F, void, MonIdSet).

    


handle_one_mon(MonObj, State, CurUnixTime) ->
    
    update_mon_bhv(MonObj),

    case CurUnixTime >= State#state.time_to_clear_expired_mons of
        true -> try_clear_expired_mon(MonObj);
        false -> skip
    end,

    case CurUnixTime >= State#state.time_to_clear_residual_mons of
        true -> try_clear_residual_mon(MonObj);  % 容错：清除残余的明雷怪
        false -> skip
    end.

                        

    


%% 更新怪物的行为（怪物的fsm）
update_mon_bhv(_MonObj) ->  % fsm_update(), update_action()
    % ?TRACE("[mod_mon_mgr] update_mon_bhv(), MonId:~p~n", [mod_mon:get_id(_MonObj)]),
    todo_here.







% %% 清除过期的怪
% clear_expired_mons(MonList) ->
%     lists:foreach(fun clear_one_expired_mon/1, MonList).


try_clear_expired_mon(MonObj) ->
    case mod_mon:is_expired(MonObj) of
        true ->
            MonId = mod_mon:get_id(MonObj),
            mark_mon_being_cleared(MonId),
            % ?DEBUG_MSG("[mod_mon_mgr] clear expired mon!! MonId:~p, TimeNow:~p, MonExpireTime:~p", [MonId, svr_clock:get_unixtime(), MonObj#mon.expire_time]),
            mod_scene:clear_mon_from_scene_WNC(MonId);
        false ->
            skip
    end.





% %% 清除残余的怪（因bug、未意料到的并发问题而导致的残余）
% clear_residual_mons(MonList) ->
%     lists:foreach(fun clear_one_residual_mon/1, MonList).



try_clear_residual_mon(MonObj) ->
    MonId = mod_mon:get_id(MonObj),
    case is_mon_being_cleared(MonId) of  % 判断，以避免重复删除
        true ->
            skip;
        false ->
            case mod_mon:is_residual(MonObj) of
                true ->
                    MonId = mod_mon:get_id(MonObj),
                    ?DEBUG_MSG("[mod_mon_mgr] clear residual mon!! TimeNow:~p, MonObj:~w", [svr_clock:get_unixtime(), MonObj]),
                    mod_scene:clear_mon_from_scene_WNC(MonId);
                false ->
                    skip
            end
    end.




do_clear_mon__(MonId) ->
    ?ASSERT(mod_mon:is_exists(MonId), MonId),
    mod_mon:del_mon_from_ets(MonId),
    unmark_mon_being_cleared(MonId).





mark_mon_being_cleared(MonId) ->
    erlang:put({?PDKN_MON_IS_BEING_CLEARED, MonId}, dummy).
    

unmark_mon_being_cleared(MonId) ->
    erlang:erase({?PDKN_MON_IS_BEING_CLEARED, MonId}).
    

is_mon_being_cleared(MonId) ->
    case erlang:get({?PDKN_MON_IS_BEING_CLEARED, MonId}) of
        undefined ->
            false;
        _ ->
            true
    end.






% %% 处理单个怪物的行为（fsm）
% handle_one_mon_action(_Mon) ->
%     todo_here.
