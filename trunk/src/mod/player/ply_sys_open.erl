%%%--------------------------------------
%%% @Module   : ply_sys_open
%%% @Author   : huangjf
%%% @Email    : 
%%% @Created  : 2014.4.16
%%% @Description: 玩家的系统开放
%%%--------------------------------------
-module(ply_sys_open).
-export([
        is_open/2,
        get_sys_open_lv/1,
        init_opened_sys_list/2,
        get_opened_sys_list/1,
		set_opened_sys_list/2,
        del_opened_sys_list_info_from_ets/1,
        check_and_handle_sys_open/1,

        dbg_force_open_all_sys/1   % 仅仅用于调试！
    ]).

-include("record.hrl").
-include("sys_open.hrl").
-include("debug.hrl").
-include("ets_name.hrl").
-include("pt_13.hrl").
-include("partner.hrl").





%% 判断某系统是否已经对玩家开放了 return true | false
is_open(PlayerId, SysCode) when is_integer(PlayerId) ->
    L = get_opened_sys_list(PlayerId),
    lists:member(SysCode, L);
is_open(PS, SysCode) when is_record(PS, player_status) ->
    L = get_opened_sys_list(PS),
    lists:member(SysCode, L);

is_open(Partner, SysCode) when is_record(Partner, partner) ->
    check_one_sys_open_for_par(Partner, SysCode).
    

get_sys_open_lv(SysCode) ->
    case data_sys_open:get(SysCode) of
        Sys when is_record(Sys, sys_open_cfg) -> 
            Sys#sys_open_cfg.lv_need;
        _ -> 
            ?ASSERT(false), 0
    end.



get_opened_sys_list(PlayerId) when is_integer(PlayerId) ->
    case ets:lookup(?ETS_PLAYER_OPENED_SYS, PlayerId) of
        [] ->
            [];
        [{PlayerId, SysList}] ->
            ?ASSERT(is_list(SysList)),
            SysList
    end;
get_opened_sys_list(PS) when is_record(PS, player_status) ->
    PlayerId = player:id(PS),
    get_opened_sys_list(PlayerId).




set_opened_sys_list(PlayerId, SysList) when is_integer(PlayerId), is_list(SysList) ->
    ets:insert(?ETS_PLAYER_OPENED_SYS, {PlayerId, SysList}).




del_opened_sys_list_info_from_ets(PlayerId) ->
    ?ASSERT(is_integer(PlayerId)),
    ets:delete(?ETS_PLAYER_OPENED_SYS, PlayerId),
    ?ASSERT(get_opened_sys_list(PlayerId) == []),
    void.




% is_sys_opened(PS, SysCode) ->
%     L = get_opened_sys_list(PS),
%     lists:member(SysCode, L).




init_opened_sys_list(PlayerId, OpenedSys_BS) ->
    ?TRACE("init_opened_sys_list(), OpenedSys_BS:~p~n", [OpenedSys_BS]),
    OpenedSysList = case util:bitstring_to_term(OpenedSys_BS) of
                        undefined ->
                            [];
                        Val when is_tuple(Val) ->
                            ?TRACE("init_opened_sys_list(), Val: ~p~n", [Val]),
                            tuple_to_list(Val);
                        _Other ->
                            ?ASSERT(false, {PlayerId, OpenedSys_BS}),
                            []
                    end,
    ?ASSERT(util:is_integer_list(OpenedSysList)),
    set_opened_sys_list(PlayerId, OpenedSysList).




check_and_handle_sys_open(PS) ->
    AllSysList = data_sys_open:get_sys_list(),
    NotOpenedSysList = AllSysList -- get_opened_sys_list(PS),
    check_and_handle_sys_open(PS, NotOpenedSysList).



check_and_handle_sys_open(_PS, []) ->
    done;
check_and_handle_sys_open(PS, [SysCode | T]) ->
    case data_sys_open:get(SysCode) of
        null ->
            ?ASSERT(false, SysCode),
            check_and_handle_sys_open(PS, T); 
        SysOpenCfg ->
            do_check_and_handle_one_sys_open(PS, SysCode, SysOpenCfg),
            check_and_handle_sys_open(PS, T)
    end.





do_check_and_handle_one_sys_open(PS, SysCode, SysOpenCfg) ->
    case check_one_sys_open(PS, SysOpenCfg) of
        fail ->
            skip;
        ok ->
            do_open_one_sys(PS, SysCode)
    end.
    

do_open_one_sys(PS, SysCode) ->
    notify_cli_sys_open(PS, SysCode),
    OldOpenedSysList = get_opened_sys_list(PS),
    
    case lists:member(SysCode, OldOpenedSysList) of
        true ->
            skip;
        false ->
            NewOpenedSysList = [SysCode | OldOpenedSysList],
            set_opened_sys_list( player:id(PS), NewOpenedSysList),
            %通知噩梦爬塔系统开启，防止等级已经超过60级没有接取过这个任务
            case SysCode =:= 50 of
                true ->
                    % 通知噩梦爬塔
                    gen_server:cast(self(), 'notify_enter_hardtower');
                false ->
                    skip
            end,
            case SysCode =:= 42 of
                true ->
                    % 通知运镖系统
                    lib_transport:open_transport_system(PS);
                false ->
                    skip
            end,
            case data_sys_open:get(SysCode) of
                null ->
                    skip;
                #sys_open_cfg{sys_open_reward = null} ->
                    skip;
                #sys_open_cfg{sys_open_reward = Reward} ->
                    case lib_reward:check_bag_space(player:id(PS), Reward) of
                        ok ->
                            lib_reward:give_reward_to_player(PS, Reward, ["ply_sys_open", "do_open_one_sys"]);
                        {fail, Reason} ->
                            lib_send:send_prompt_msg(PS, Reason)
                    end
            end,
            db_save_opened_sys_list(PS, NewOpenedSysList)
    end.

            



notify_cli_sys_open(PS, SysCode) ->
    % ?DEBUG_MSG("~n~nnotify_cli_sys_open(), SysCode:~p~n~n", [SysCode]),
    {ok, Bin} = pt_13:write(?PT_PLYR_NOTIFY_NEW_SYS_OPEN, SysCode),
    lib_send:send_to_sock(PS, Bin).




db_save_opened_sys_list(PS, NewOpenedSysList) ->
    PlayerId = player:id(PS),
    db:update(
            PlayerId,
            player,
            ["opened_sys"], 
            [util:term_to_bitstring( list_to_tuple(NewOpenedSysList) )], % 为避免出错，转为tuple的形式
            "id", 
            PlayerId
            ).



check_one_sys_open(PS, SysOpenCfg) ->
    % 是否满足等级需求?
    LvNeed = SysOpenCfg#sys_open_cfg.lv_need,
    ?ASSERT(is_integer(LvNeed)),
    case player:get_lv(PS) >= LvNeed of
        false ->
            fail;
        true ->
            % 是否满足任务需求？
            case SysOpenCfg#sys_open_cfg.task_need of
                null ->
                    ok;
                TaskNeed ->
                    case TaskNeed of
                        {already_accept_task, TaskId} ->
                            ?ASSERT(is_integer(TaskId)),
                            case already_accept_task(PS, TaskId) of
                                true ->
                                    ok;
                                false ->
                                    fail
                            end;
                        {already_accept_one_of_task, TaskIdList} ->
                            ?ASSERT(TaskIdList /= [] andalso util:is_integer_list(TaskIdList)),
                            case already_accept_one_of_task(PS, TaskIdList) of
                                true ->
                                    ok;
                                false ->
                                    fail
                            end;
                        {already_submit_task, TaskId} ->
                            ?ASSERT(is_integer(TaskId)),
                            case already_submit_task(PS, TaskId) of
                                true ->
                                    ok;
                                false ->
                                    fail
                            end
                    end
            end
    end.


%% return true | false
check_one_sys_open_for_par(Partner, SysCode) ->
    % 是否满足等级需求? 暂时只判断等级
    case data_sys_open:get(SysCode) of
        null -> true;
        SysOpenCfg ->
            LvNeed = SysOpenCfg#sys_open_cfg.par_lv_need,
            ?ASSERT(is_integer(LvNeed)),
            case lib_partner:get_lv(Partner) >= LvNeed of
                false ->
                    false;
                true ->
                    true
            end
    end.

            



already_accept_task(PS, TaskId) ->
    lib_task:publ_is_accepted(TaskId, PS) orelse lib_task:publ_is_submit(TaskId, PS).

    

already_accept_one_of_task(PS, [TaskId | T]) ->
    case already_accept_task(PS, TaskId) of
        true ->
            true;
        false ->
            already_accept_one_of_task(PS, T)
    end;
already_accept_one_of_task(_PS, []) ->
    false.



already_submit_task(PS, TaskId) ->
    lib_task:publ_is_submit(TaskId, PS).
















dbg_force_open_all_sys(PS) ->
    L = data_sys_open:get_sys_list(),
    F = fun(SysCode) ->
            do_open_one_sys(PS, SysCode)
        end,
    lists:foreach(F, L).
    