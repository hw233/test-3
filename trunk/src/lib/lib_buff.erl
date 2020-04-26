%%%-----------------------------------
%%% @Module  : lib_buff
%%% @Author  : zwq
%%% @Email   :
%%% @Created : 2013.10.29
%%% @Description: 玩家or宠物buff操作接口
%%%-----------------------------------

-module(lib_buff).

-export([
        is_buff_no_valid/1,
        on_player_login/2,          % 初始化玩家自己和宠物的buff
        on_player_tmp_logout/2,     % 移除作业计划，更新数据到内存

        player_add_buff/2,
        player_add_buff/3,
        partner_add_buff/3,

        player_del_buff/2,          % 玩家自己删除buff
        sys_del_player_buff/2,      % 系统删除buff
        partner_del_buff/3,

        set_buff_state/3,
        is_max_overlap/2            % 判断玩家某个buff是否到了最大堆叠上限
    ]).


-include("debug.hrl").
-include("buff.hrl").
-include("job_schedule.hrl").
-include("pt_13.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("common.hrl").

is_buff_no_valid(BuffNo) ->
    data_buff:get(BuffNo) /= null.


%% 从数据库加载buff 添加到作业计划和添加到内存
on_player_login(PS, RoleCacheInfo) ->
    PlayerId = player:id(PS),
    ObjBuffList =
        case RoleCacheInfo of
            role_in_cache -> mod_buff:get_obj_buff_list(PlayerId);
            role_not_in_cache -> mod_buff:db_load_buff(PlayerId)
        end,
    
    LogoutTime = player:get_last_logout_time(PS),
    % 添加到作业计划和添加到内存
    Now = util:unixtime(),
    F = fun(ObjBuff) ->
        ?ASSERT(is_record(ObjBuff, obj_buff), ObjBuff),
        BuffList = ObjBuff#obj_buff.buff_list,

        F0 = fun(Buff, Acc) ->
            case Buff#buff.open_state =:= 0 of
                true -> [Buff | Acc];
                false ->
                    ?ASSERT(Buff#buff.start_time > 0, Buff#buff.start_time),
                    Delta = Now - LogoutTime,
                    BuffLeftTime =
                        case lib_buff_tpl:get_name(lib_buff_tpl:get_tpl_data(Buff#buff.no)) of
                            ?BFN_VIP_EXPERIENCE -> player:get_vip_expire_time(PS) - Now;
                            _ -> Buff#buff.left_time
                        end,

                    case Delta >= BuffLeftTime of
                        true -> Acc;
                        false -> [Buff#buff{left_time = BuffLeftTime - Delta, start_time = Now} | Acc]
                    end
            end
        end,
        NewBuffList = lists:foldl(F0, [], BuffList),
        NewObjBuff = ObjBuff#obj_buff{buff_list = NewBuffList},

        mod_buff:update_buff_to_ets(NewObjBuff),

        %% 添加到作业计划
        PartnerId =
            case ObjBuff#obj_buff.key of
                {player, _} -> 0;
                {partner, PartnerId1} -> PartnerId1
            end,

        F1 = fun(X) ->
            BuffNo = X#buff.no,
            LeftTime = X#buff.left_time,
            ?ASSERT(LeftTime > 0, LeftTime),
            case PartnerId =:= 0 of
                false -> skip; %% 暂时宠物心情buff都是固定时间刷新，没必要为每个宠物都添加作业计划，目前是通过JSET_UPDATE_PAR_MOOD事件统一处理
                true ->
                    case X#buff.left_time =< 0 orelse X#buff.open_state =:= 0 of
                        true -> skip;
                        false -> mod_ply_jobsch:add_schedule(?JSET_CANCEL_BUFF, LeftTime, [PlayerId, PartnerId, BuffNo])
                    end
            end
        end,

        [F1(X) || X <- NewBuffList]
        % add_job_schedule(PlayerId, BuffList)
    end,
    lists:foreach(F, ObjBuffList).


% 移除作业计划，更新buff剩余时间等信息到内存
on_player_tmp_logout(PlayerId, ParIdList) ->
    mod_ply_jobsch:remove_one_sch(PlayerId, ?JSET_CANCEL_BUFF),

    F = fun(ObjBuff) ->
        NewBuffList = mod_buff:update_buff_left_time(ObjBuff#obj_buff.buff_list),
        NewObjBuff = ObjBuff#obj_buff{buff_list = NewBuffList},
        mod_buff:update_buff_to_ets(NewObjBuff)
    end,

    case ets:lookup(?ETS_BUFF, {player, PlayerId}) of
        [] -> skip;
        [ObjBuffPlayer] -> F(ObjBuffPlayer)
    end,

    F1 = fun(PartnerId) ->
        case ets:lookup(?ETS_BUFF, {partner, PartnerId}) of
            [] -> skip;
            [ObjBuffPartner] -> F(ObjBuffPartner)
        end
    end,
    lists:foreach(F1, ParIdList).


player_add_buff(PlayerId, BuffNo) ->
    BuffTpl = data_buff:get(BuffNo),
    BuffList = mod_buff:get_buff_list(player, PlayerId),
    mod_ply_jobsch:remove_one_sch(PlayerId, ?JSET_CANCEL_BUFF),
    mod_achievement:notify_achi(get_buff, [{no, BuffNo}], player:get_PS(PlayerId)),

    case BuffTpl#buff_tpl.max_overlap =:= 1 of
        true ->
            NewBuff = #buff{no = BuffNo, start_time = util:unixtime(), left_time = BuffTpl#buff_tpl.lasting_time, open_state = 1},
            NewBuffList =
                case lists:keyfind(BuffNo, #buff.no, BuffList) of
                    false -> BuffList ++ [NewBuff];
                    _Any -> lists:keyreplace(BuffNo, #buff.no, BuffList, NewBuff)
                end,
            NewBuffList1 = mod_buff:update_buff_left_time(NewBuffList),
            ObjBuff = #obj_buff{key = {player, PlayerId}, buff_list = NewBuffList1},
            mod_buff:update_buff_to_ets(ObjBuff),
            mod_buff:db_save_buff(PlayerId, []),
            add_job_schedule(PlayerId, NewBuffList1),
            notify_buff_change(PlayerId, NewBuff);
        false ->
            case lists:keyfind(BuffNo, #buff.no, BuffList) of
                false ->
                    NewBuff = #buff{no = BuffNo, start_time = util:unixtime(), left_time = BuffTpl#buff_tpl.lasting_time, open_state = 1},
                    NewBuffList = BuffList ++ [NewBuff],
                    NewBuffList1 = mod_buff:update_buff_left_time(NewBuffList),
                    ObjBuff = #obj_buff{key = {player, PlayerId}, buff_list = NewBuffList1},
                    mod_buff:update_buff_to_ets(ObjBuff),
                    mod_buff:db_save_buff(PlayerId, []),
                    add_job_schedule(PlayerId, NewBuffList1),
                    notify_buff_change(PlayerId, NewBuff);
                Buff ->
                    Buff1 = mod_buff:update_buff_left_time(Buff),
                    % LeftTime = erlang:min(BuffTpl#buff_tpl.lasting_time * BuffTpl#buff_tpl.max_overlap, Buff1#buff.left_time + BuffTpl#buff_tpl.lasting_time),
                    LeftTime = Buff1#buff.left_time + BuffTpl#buff_tpl.lasting_time,
                    Buff2 = Buff1#buff{left_time = LeftTime, open_state = 1, start_time = util:unixtime()}, %% 这里务必重新更新开始时间（从现在开始还剩余多少时间）
                    NewBuffList = lists:keyreplace(BuffNo, #buff.no, BuffList, Buff2),
                    NewBuffList1 = mod_buff:update_buff_left_time(NewBuffList),
                    ObjBuff = #obj_buff{key = {player, PlayerId}, buff_list = NewBuffList1},
                    mod_buff:update_buff_to_ets(ObjBuff),
                    mod_buff:db_save_buff(PlayerId, []),
                    add_job_schedule(PlayerId, NewBuffList1),
                    notify_buff_change(PlayerId, Buff2)
            end
    end.


player_add_buff(PlayerId, BuffNo, LastingTime) ->
    case LastingTime =< 0 of
        true -> skip;
        false ->
            BuffTpl = data_buff:get(BuffNo),
            BuffList = mod_buff:get_buff_list(player, PlayerId),
            mod_ply_jobsch:remove_one_sch(PlayerId, ?JSET_CANCEL_BUFF),
            mod_achievement:notify_achi(get_buff, [{no, BuffNo}], player:get_PS(PlayerId)),
            
            case BuffTpl#buff_tpl.max_overlap =:= 1 of
                true ->
                    NewBuff = #buff{no = BuffNo, start_time = util:unixtime(), left_time = LastingTime, open_state = 1},
                    NewBuffList =
                        case lists:keyfind(BuffNo, #buff.no, BuffList) of
                            false -> BuffList ++ [NewBuff];
                            _Any -> lists:keyreplace(BuffNo, #buff.no, BuffList, NewBuff)
                        end,
                    NewBuffList1 = mod_buff:update_buff_left_time(NewBuffList),
                    ObjBuff = #obj_buff{key = {player, PlayerId}, buff_list = NewBuffList1},
                    mod_buff:update_buff_to_ets(ObjBuff),
                    mod_buff:db_save_buff(PlayerId, []),
                    add_job_schedule(PlayerId, NewBuffList1),
                    notify_buff_change(PlayerId, NewBuff);
                false ->
                    case lists:keyfind(BuffNo, #buff.no, BuffList) of
                        false ->
                            NewBuff = #buff{no = BuffNo, start_time = util:unixtime(), left_time = LastingTime, open_state = 1},
                            NewBuffList = BuffList ++ [NewBuff],
                            NewBuffList1 = mod_buff:update_buff_left_time(NewBuffList),
                            ObjBuff = #obj_buff{key = {player, PlayerId}, buff_list = NewBuffList1},
                            mod_buff:update_buff_to_ets(ObjBuff),
                            mod_buff:db_save_buff(PlayerId, []),
                            add_job_schedule(PlayerId, NewBuffList1),
                            notify_buff_change(PlayerId, NewBuff);
                        Buff ->
                            Buff1 = mod_buff:update_buff_left_time(Buff),
                            % LeftTime = erlang:min(BuffTpl#buff_tpl.lasting_time * BuffTpl#buff_tpl.max_overlap, Buff1#buff.left_time + BuffTpl#buff_tpl.lasting_time),
                            LeftTime = Buff1#buff.left_time + LastingTime,
                            Buff2 = Buff1#buff{left_time = LeftTime, start_time = util:unixtime()},
                            NewBuffList = lists:keyreplace(BuffNo, #buff.no, BuffList, Buff2),
                            NewBuffList1 = mod_buff:update_buff_left_time(NewBuffList),
                            ObjBuff = #obj_buff{key = {player, PlayerId}, buff_list = NewBuffList1},
                            mod_buff:update_buff_to_ets(ObjBuff),
                            mod_buff:db_save_buff(PlayerId, []),
                            add_job_schedule(PlayerId, NewBuffList1),
                            notify_buff_change(PlayerId, Buff2)
                    end
            end
    end.


player_del_buff(PlayerId, BuffNo) when is_integer(BuffNo) ->
    BuffList = mod_buff:get_buff_list(player, PlayerId),
    case BuffList =:= [] of
        true ->  skip; % ?ASSERT(false, BuffNo); %% 此断言不合理，玩家的buff已经移除了
        false ->
            case lists:keyfind(BuffNo, #buff.no, BuffList) of
                false -> skip;
                Buff ->
                    case Buff#buff.open_state =:= 0 of
                        true -> skip;
                        false ->
                            NewBuffList = lists:keydelete(BuffNo, #buff.no, BuffList),
                            ObjBuff = #obj_buff{key = {player, PlayerId}, buff_list = NewBuffList},
                            mod_buff:update_buff_to_ets(ObjBuff),
                            % mod_buff:db_save_buff(PlayerId, []),
                            notify_buff_change(PlayerId, #buff{no = BuffNo, left_time = 0}),
                            %% 添加异常日志记录
                            case lib_buff_tpl:get_name(lib_buff_tpl:get_tpl_data(BuffNo)) of
                                ?BFN_ADD_EXP -> ?ERROR_MSG("lib_buff:player_del_buff: del BFN_ADD_EXP error!~n", []);
                                _ -> skip
                            end
                    end
            end
    end;

player_del_buff(PlayerId, BuffName) ->
    BuffList = mod_buff:get_buff_list(player, PlayerId),
    BuffNoList = [Buff#buff.no || Buff <- BuffList],
    case mod_buff:find_buff_no_by_name(BuffNoList, BuffName) of
        ?INVALID_NO ->
            skip;
        BuffNo ->
            player_del_buff(PlayerId, BuffNo)
    end.


sys_del_player_buff(PlayerId, BuffNo) ->
    BuffList = mod_buff:get_buff_list(player, PlayerId),
    case BuffList =:= [] of
        true ->  skip; % ?ASSERT(false, BuffNo); %% 此断言不合理，玩家的buff已经移除了，当作业计划返回要移除的时候，已经找不到了
        false ->
            case lists:keyfind(BuffNo, #buff.no, BuffList) of
                false -> skip;
                Buff ->
                    case Buff#buff.open_state =:= 0 of
                        true -> skip;
                        false ->
                            case Buff#buff.start_time + Buff#buff.left_time - util:unixtime() >= 3 * 60 of
                                true -> skip; %% 剩余时间大于3分钟
                                false ->
                                    NewBuffList = lists:keydelete(BuffNo, #buff.no, BuffList),
                                    ObjBuff = #obj_buff{key = {player, PlayerId}, buff_list = NewBuffList},
                                    mod_buff:update_buff_to_ets(ObjBuff),
                                    % mod_buff:db_save_buff(PlayerId, []),
                                    notify_buff_change(PlayerId, #buff{no = BuffNo, left_time = 0}),
                                    case lib_buff_tpl:get_name(lib_buff_tpl:get_tpl_data(BuffNo)) of
                                        ?BFN_VIP_EXPERIENCE -> mod_vip:vip_expire(PlayerId);
                                        _ -> skip
                                    end
                            end
                    end
            end
    end.

partner_del_buff(PlayerId, PartnerId, BuffNo) ->
    BuffList = mod_buff:get_buff_list(partner, PartnerId),
    case BuffList =:= [] of
        true ->
            % ?ASSERT(false, BuffNo);
            skip;
        false ->
            NewBuffList = lists:keydelete(BuffNo, #buff.no, BuffList),
            ObjBuff = #obj_buff{key = {partner, PartnerId}, buff_list = NewBuffList},
            mod_buff:update_buff_to_ets(ObjBuff),
            mod_buff:db_save_buff(PlayerId, player:get_partner_id_list(PlayerId))
    end.


partner_add_buff(PlayerId, PartnerId, BuffNo) ->
    % ?ASSERT(lists:member(PartnerId, player:get_partner_id_list(PlayerId))),
    BuffTpl = data_buff:get(BuffNo),
    BuffList = mod_buff:get_buff_list(partner, PartnerId),
    case BuffTpl#buff_tpl.max_overlap =:= 1 of
        true ->
            NewBuff = #buff{no = BuffNo, start_time = util:unixtime(), left_time = BuffTpl#buff_tpl.lasting_time, open_state = 1},
            NewBuffList = BuffList ++ [NewBuff],
            ObjBuff = #obj_buff{key = {partner, PartnerId}, buff_list = NewBuffList},
            mod_buff:update_buff_to_ets(ObjBuff);
        false ->
            case lists:keyfind(BuffNo, #buff.no, BuffList) of
                false ->
                    NewBuff = #buff{no = BuffNo, start_time = util:unixtime(), left_time = BuffTpl#buff_tpl.lasting_time, open_state = 1},
                    NewBuffList = BuffList ++ [NewBuff],
                    ObjBuff = #obj_buff{key = {partner, PlayerId}, buff_list = NewBuffList},
                    mod_buff:update_buff_to_ets(ObjBuff);
                Buff ->
                    Buff1 = mod_buff:update_buff_left_time(Buff),
                    LeftTime = erlang:min(BuffTpl#buff_tpl.lasting_time * BuffTpl#buff_tpl.max_overlap, Buff1#buff.left_time + BuffTpl#buff_tpl.lasting_time),
                    Buff2 = Buff1#buff{left_time = LeftTime, start_time = util:unixtime()},
                    NewBuffList = lists:keyreplace(BuffNo, #buff.no, BuffList, Buff2),
                    ObjBuff = #obj_buff{key = {partner, PlayerId}, buff_list = NewBuffList},
                    mod_buff:update_buff_to_ets(ObjBuff)
            end
    end.


set_buff_state(PlayerId, BuffNo, OpenState) ->
    BuffList = mod_buff:get_buff_list(player, PlayerId),
    case lists:keyfind(BuffNo, #buff.no, BuffList) of
        false ->
            {fail, ?PM_BUFF_NOT_EXISTS};
        Buff ->
            case Buff#buff.open_state =:= OpenState of
                true -> ok;
                false ->
                    mod_ply_jobsch:remove_one_sch(PlayerId, ?JSET_CANCEL_BUFF),

                    Buff2 =
                        case OpenState =:= 0 of
                            false -> %% 现在要开启
                                case Buff#buff.open_state =:= 0 of
                                    true -> %% 原来是关闭的
                                        Buff#buff{open_state = OpenState, start_time = util:unixtime()};
                                    false ->
                                        ?ERROR_MSG("lib_buff:set_buff_state error!~n", []),
                                        Buff
                                end;
                            true -> %% 现在要关闭
                                case Buff#buff.open_state =:= 1 of
                                    true -> % 原来是开启的
                                        NewLeftTime = erlang:max(0, Buff#buff.left_time - (util:unixtime() - Buff#buff.start_time)),
                                        Buff#buff{open_state = OpenState, left_time = NewLeftTime};
                                    false ->
                                        ?ERROR_MSG("lib_buff:set_buff_state error!~n", []),
                                        Buff
                                end    
                        end,
                        
                    NewBuffList = lists:keyreplace(BuffNo, #buff.no, BuffList, Buff2),
                    NewBuffList1 = mod_buff:update_buff_left_time(NewBuffList),
                    ObjBuff = #obj_buff{key = {player, PlayerId}, buff_list = NewBuffList1},
                    mod_buff:update_buff_to_ets(ObjBuff),
                    add_job_schedule(PlayerId, NewBuffList1),
                    notify_buff_change(PlayerId, Buff2),
                    ok
            end
    end.


is_max_overlap(PlayerId, BuffNo) ->
    BuffList = mod_buff:get_buff_list(player, PlayerId),
    case lists:keyfind(BuffNo, #buff.no, BuffList) of
        false -> false;
        Buff ->
            case data_buff:get(BuffNo) of
                null ->
                    ?ASSERT(false, BuffNo),
                    false;
                BuffTpl ->
                    LeftTime =
                    case Buff#buff.open_state =:= 0 of
                        true -> Buff#buff.left_time;
                        false -> erlang:max(0, Buff#buff.left_time - (util:unixtime() - Buff#buff.start_time))
                    end,
                    LeftTime > BuffTpl#buff_tpl.lasting_time * BuffTpl#buff_tpl.max_overlap
            end
    end.


notify_buff_change(PlayerId, Buff) ->
    BuffNo = Buff#buff.no,
    LeftTime = Buff#buff.left_time,
    OpenState = Buff#buff.open_state,
    {ok, BinData} = pt_13:write(?PT_PLYR_BUFF_CHANGE, [BuffNo, LeftTime, OpenState]),
    case player:get_PS(PlayerId) of
        null ->
            skip;
        PS ->
            lib_send:send_to_sock(PS, BinData)
    end.


add_job_schedule(PlayerId, BuffList) ->
    F = fun(Buff) ->
        case Buff#buff.left_time =< 0 orelse Buff#buff.open_state =:= 0 of
            true -> skip;
            false -> mod_ply_jobsch:add_schedule(?JSET_CANCEL_BUFF, Buff#buff.left_time, [PlayerId, 0, Buff#buff.no])
        end
    end,
    [F(X) || X <- BuffList].