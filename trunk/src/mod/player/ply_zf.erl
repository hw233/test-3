%%%--------------------------------------
%%% @Module  : ply_zf
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Created : 2015.2.27
%%% @Description: 玩家阵法逻辑
%%%--------------------------------------
-module(ply_zf).
-export([
        init_zf/0,
        build_init_zf_bitstring/0,
        get_common_zf/0,
        learn_zf/2,
        use_zf/2,
        set_zf_pos/2
    ]).

-include("common.hrl").
-include("zf.hrl").
-include("log.hrl").
-include("abbreviate.hrl").
-include("prompt_msg_code.hrl").


%% return [No,...]
init_zf() ->
    case data_zf:get_all_no_list() of
        [] -> [];
        L when is_list(L) -> [erlang:hd(L)];
        _ -> []
    end.
 
build_init_zf_bitstring() ->
    InitL = init_zf(),
    util:term_to_bitstring(InitL).


get_common_zf() ->
    case init_zf() of
        [] -> ?INVALID_NO;
        L -> erlang:hd(L)
    end.


learn_zf(PS, No) ->
    case check_learn_zf(PS, No) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_learn_zf(PS, No)
    end.


use_zf(PS, No) ->
    case check_use_zf(PS, No) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_use_zf(PS, No)
    end.    


set_zf_pos(PS, IdPosList) ->
    case check_set_zf_pos(PS, IdPosList) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_set_zf_pos(PS, IdPosList)
    end.        


%% ----------------------------------------local--------------------------------------------------------

check_learn_zf(PS, No) ->
    try 
        check_learn_zf__(PS, No)
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.


check_learn_zf__(PS, No) ->
    DataCfg = data_zf:get(No),
    ?Ifc (DataCfg =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (player:get_lv(PS) < DataCfg#zf_cfg.zf_lv)
        throw(?PM_LV_LIMIT)
    ?End,

    ZFL = player:get_zf_state(PS),
    ?Ifc (lists:member(No, ZFL))
        throw(?PM_TM_ZF_HAVE_LEARN_ZF)
    ?End,

    % 判断是否已经学习
    F = fun({N}, Acc) ->
        ?DEBUG_MSG("N=~p,ZFL,~p",[N,ZFL]),

        case lists:member(N, ZFL) of
            true -> Acc;
            false -> false
        end
    end,

    Ret = lists:foldl(F, true, DataCfg#zf_cfg.pre_zf),
    ?DEBUG_MSG("Ret=~p",[Ret]),

    ?Ifc (not(Ret))
        throw(?PM_TM_ZF_LEARN_PRE_ZF_FIRST)
    ?End,

    ?Ifc (lists:member(DataCfg#zf_cfg.pre_zf, ZFL))
        throw(?PM_TM_ZF_HAVE_LEARN_ZF)
    ?End,

    ?DEBUG_MSG("DataCfg#zf_cfg.zf_goods=~p",[DataCfg#zf_cfg.zf_goods]),
    
    case mod_inv:check_batch_destroy_goods(PS, DataCfg#zf_cfg.zf_goods) of
        {fail, Reason} ->
            throw(Reason);
        ok -> ok
    end.


do_learn_zf(PS, No) ->
    DataCfg = data_zf:get(No),
    mod_inv:destroy_goods_WNC(PS, DataCfg#zf_cfg.zf_goods, [?LOG_ZF, "learn_zf"]),

    player:set_zf_state(PS, [No | player:get_zf_state(PS)]),
    ok.


check_use_zf(PS, No) ->
    try 
        check_use_zf__(PS, No)
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.


check_use_zf__(PS, No) ->
    DataCfg = data_zf:get(No),
    ?Ifc (DataCfg =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    TeamId = player:get_team_id(PS),
    ?Ifc (TeamId =:= ?INVALID_ID)
        throw(?PM_NOT_TEAM_LEADER)
    ?End,

    Team = mod_team:get_team_by_id(TeamId),
    ?Ifc (Team =:= null)
        throw(?PM_TEAM_NOT_EXISTS)
    ?End,

    ?Ifc (mod_team:get_leader_id(Team) =/= player:id(PS))
        throw(?PM_NOT_TEAM_LEADER)
    ?End,

    ?Ifc (not lists:member(No, lib_team:get_learned_zf_nos(Team)))
        throw(?PM_TM_ZF_NOT_USABLE)
    ?End,
    ok.


do_use_zf(PS, No) ->
    mod_team_mgr:use_zf(player:get_team_id(PS), No),
    ok.


check_set_zf_pos(PS, IdPosList) ->
    try 
        check_set_zf_pos__(PS, IdPosList)
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.


check_set_zf_pos__(PS, IdPosList) ->
    TeamId = player:get_team_id(PS),
    ?Ifc (TeamId =:= ?INVALID_ID)
        throw(?PM_NOT_TEAM_LEADER)
    ?End,

    Team = mod_team:get_team_by_id(TeamId),
    ?Ifc (Team =:= null)
        throw(?PM_TEAM_NOT_EXISTS)
    ?End,

    ?Ifc (mod_team:get_leader_id(Team) =/= player:id(PS))
        throw(?PM_NOT_TEAM_LEADER)
    ?End,

    % MbIdList = mod_team:get_can_fight_member_id_list(Team),
    % ?DEBUG_MSG("ply_zf:check_set_zf_pos__:IdPosList:~p, MbIdList:~p~n", [IdPosList, MbIdList]),
    % ?Ifc (length(MbIdList) =/= length(IdPosList))
    %     ?ERROR_MSG("ply_zf:check_set_zf_pos__:length(IdPosList) error...~n", []),
    %     throw(?PM_PARA_ERROR)
    % ?End,

    F = fun({Id, Pos}, {Acc1, Acc2}) ->
        {[Id | Acc1], [Pos | Acc2]}
    end,
    {_IdL, PosL} = lists:foldl(F, {[], []}, IdPosList),
    % IdL1 = lists:sort(IdL),

    % MbIdList1 = lists:sort(MbIdList),

    F1 = fun(Pos, Sum) ->
        case lists:member(Pos, [1, 2, 3, 4, 5]) of
            true -> Sum;
            false -> 1 + Sum
        end
    end,
    ?Ifc (lists:foldl(F1, 0, PosL) =/= 0)
        ?ERROR_MSG("ply_zf:check_set_zf_pos__:poss error:~w~n", [PosL]),
        throw(?PM_PARA_ERROR)
    ?End,

    % ?Ifc (IdL1 =/= MbIdList1)
    %     ?ERROR_MSG("ply_zf:check_set_zf_pos__:MbIdList error:~w~n", []),
    %     throw(?PM_PARA_ERROR)
    % ?End,
    
    ?Ifc ( length(sets:to_list(sets:from_list(PosL))) =/= length(PosL) )
        ?ERROR_MSG("ply_zf:check_set_zf_pos__:duplicate error:~w~n", [PosL]),
        throw(?PM_PARA_ERROR)
    ?End,

    ok.

do_set_zf_pos(PS, IdPosList) ->
    mod_team_mgr:set_zf_pos(player:get_team_id(PS), IdPosList).

