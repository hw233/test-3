%%%-----------------------------------
%%% @Module  : lib_drop
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.11.12
%%% @Description: 掉落相关的接口
%%%-----------------------------------
-module(lib_drop).
-export([
        give_drop_to_player/5,
        calc_drop_to_partner/4,
        tst_get_drop_prob_expand/0,
        tst_set_drop_prob_expand/1,
        tst_send_goods_by_drop_no/2        
    ]).

-include("common.hrl").
-include("drop.hrl").
-include("log.hrl").
-include("goods.hrl").
-include("buff.hrl").
-include("player.hrl").

%% 测试获取掉落放大的倍数
tst_get_drop_prob_expand() ->
    case erlang:get(?PDKN_TST_PLAYER_DROP_PROB_EXPAND) of
        undefined -> 
            1;
        Rd -> Rd
    end.


tst_set_drop_prob_expand(Value) ->
    erlang:put(?PDKN_TST_PLAYER_DROP_PROB_EXPAND, Value).


tst_send_goods_by_drop_no(PS, DropPkgNo) ->
    do_give_drop_to_player(#drop_dtl{}, PS, lib_Bmon_tpl:get_tpl_data(1001), get_drop_pkg_cfg_data(DropPkgNo), [player:id(PS)], []).

get_drop_pkg_cfg_data(PkgNo) ->
    data_drop_pkg:get(PkgNo).



%% 给予玩家打怪的掉落
give_drop_to_player(DropDtl, PS, BMonNo, ShuffledTeamMbList, LogInfo) ->
    BMonTpl = lib_Bmon_tpl:get_tpl_data(BMonNo),
    case lib_Bmon_tpl:get_drop_pkg_no(BMonTpl) of
        ?INVALID_NO ->  % 没有配掉落包，则只给经验
            % ?LDS_TRACE("!!!!!!!!!!!!!!!!! drop exp"),
            %%?DEBUG_MSG("give_drop_to_player(), only give exp, BMonTpl:~w~n", [BMonTpl]),
            do_calc_drop_to_player__(exp, DropDtl, PS, BMonTpl);
        DropPkgNo ->
            ?TRACE("[lib_drop] give_drop_to_player(), PlayerId=~p, DropPkgNo=~p, ShuffledTeamMbList=~p~n", [player:id(PS), DropPkgNo, ShuffledTeamMbList]),
            case get_drop_pkg_cfg_data(DropPkgNo) of
                null ->
                    ?ASSERT(false, DropPkgNo),
                    DropDtl;
                DropPkg ->
                    ?LDS_TRACE("!!!!!!!!!!!!!!!!! drop item"),
                    do_give_drop_to_player(DropDtl, PS, BMonTpl, DropPkg, ShuffledTeamMbList, LogInfo)
            end
    end.
    
% give_drop_to_partner(_PS, _BMonNo, []) ->
%     skip;
% give_drop_to_partner(PS, BMonNo, [PartnerId | T]) ->
%     ?TRACE("[lib_drop] give_drop_to_partner(), PartnerId=~p~n", [PartnerId]),
%     % 只给经验
%     BMonTpl = lib_Bmon_tpl:get_tpl_data(BMonNo),
%     do_give_drop_to_partner__(exp, PS, PartnerId, BMonTpl),
%     give_drop_to_partner(PS, BMonNo, T).

calc_drop_to_partner(DropDtl, PS, PartnerId, BMonNo) ->
    % 只给经验
    BMonTpl = lib_Bmon_tpl:get_tpl_data(BMonNo),
    do_calc_drop_to_partner__(exp, DropDtl, PS, PartnerId, BMonTpl).



do_give_drop_to_player(DropDtl, PS, BMonTpl, DropPkg, ShuffledTeamMbList, LogInfo) ->
    % 给经验
    DropExp = do_calc_drop_to_player__(exp, DropDtl, PS, BMonTpl),

    % 给钱
    % DropMoney = do_give_drop_to_player__(money, PS, BMonTpl, DropPkg#drop_pkg.money, LogInfo),
    DropMoneyList = DropPkg#drop_pkg.money,

    FMoney = fun(X, Acc) ->
        RetDropMoney = do_give_drop_to_player__(money, PS, BMonTpl, X, LogInfo),
        sum_drop([Acc, RetDropMoney])
    end,

    DropMoney = lists:foldl(FMoney, #drop_dtl{}, DropMoneyList),

    % 给物品（todo：给物品的操作可以考虑异步给予，因为刚开服的初始阶段，人多，有可能会同时给大量的玩家做掉落的处理，从而引发大量的数据库操作（插入物品记录到物品表）！）
    FGoods = fun(X, Acc) ->
        RetDropGoods = do_give_drop_to_player__(goods, PS, ShuffledTeamMbList, X, LogInfo),
        sum_drop([Acc, RetDropGoods])
    end,
    
    % 修改本字段为数组
    DropGoodsList = DropPkg#drop_pkg.goods,
                    % [   
                    %     DropPkg#drop_pkg.goods1, 
                    %     DropPkg#drop_pkg.goods2, 
                    %     DropPkg#drop_pkg.goods3, 
                    %     DropPkg#drop_pkg.goods4 
                    % ],
    
    DropGoods = lists:foldl(FGoods, #drop_dtl{}, DropGoodsList),

    % 给任务物品
    FTaskGoods = fun(DropTaskGoods, Acc) ->
        RetDropTaskGoods = do_give_drop_to_player__(task_goods, PS, ShuffledTeamMbList, DropTaskGoods, LogInfo),
        sum_drop([Acc, RetDropTaskGoods])
    end,

    % 修改了本字段配置为数组
    DropTaskGoodsList = DropPkg#drop_pkg.task_goods, %[DropPkg#drop_pkg.task_goods1, DropPkg#drop_pkg.task_goods2],
    DropTaskGoods = lists:foldl(FTaskGoods, #drop_dtl{}, DropTaskGoodsList),

    DropLeader = do_give_drop_to_team_leader__(leader_weal, PS, DropPkg#drop_pkg.leader_weal, LogInfo),
    DropAct = do_give_drop_to_player__(act_goods, PS, DropPkg#drop_pkg.act_goods, LogInfo),

    sum_drop([DropExp, DropMoney, DropGoods, DropTaskGoods, DropLeader, DropAct]).






do_calc_drop_to_player__(exp, DropDtl, PS, BMonTpl) ->
    % 怪物经验= 系数*怪物等级*等级差减益
    ExpCoef = lib_Bmon_tpl:get_drop_exp_coef(BMonTpl),
    BMonLv = lib_Bmon_tpl:get_lv(BMonTpl),
    LvDiff = abs(player:get_lv(PS) - BMonLv), 
    LvDiffReduce = lib_reward:get_lv_delta_coef(LvDiff),
    Exp = 
        case lib_Bmon_tpl:is_drop_exp_buff_effect(BMonTpl) of
            false ->
                util:ceil(ExpCoef * BMonLv * LvDiffReduce);
            true ->
                VipAddRate = 
                    case lib_vip:welfare(drop_exp_addition, PS) of
                        null -> 1;
                        TVipAdd -> 1 + TVipAdd
                    end,
                case mod_buff:has_buff(player, player:id(PS), ?BFN_ADD_EXP) of
                    false -> util:ceil(ExpCoef * BMonLv * LvDiffReduce * VipAddRate);
                    true ->
                        case mod_buff:get_buff_state_by_name(player, player:id(PS), ?BFN_ADD_EXP) of
                            0 -> 
                                util:ceil(ExpCoef * BMonLv * LvDiffReduce * VipAddRate);
                            1 ->
                                BuffPara = mod_buff:get_buff_para_by_name(player, player:id(PS), ?BFN_ADD_EXP),
                                ?ASSERT(BuffPara =/= null andalso is_integer(BuffPara)),
                                util:ceil(ExpCoef * BMonLv * LvDiffReduce * BuffPara * VipAddRate)
                        end
                end
        end,

    case lists:keyfind(?VGOODS_EXP, 2, DropDtl#drop_dtl.goods_list) of
        false -> DropDtl#drop_dtl{goods_list = DropDtl#drop_dtl.goods_list ++ [{?INVALID_ID, ?VGOODS_EXP, Exp}]};
        {GoodsId, GoodsNo, Count} ->
            GoodsList = lists:keyreplace(GoodsNo, 2, DropDtl#drop_dtl.goods_list, {GoodsId, GoodsNo, Exp + Count}),
            DropDtl#drop_dtl{goods_list = GoodsList}
    end.


do_calc_drop_to_partner__(exp, DropDtl, _PS, PartnerId, BMonTpl) ->
    % 宠物获得经验= 系数*怪物等级*等级差减益
    BMonLv = lib_Bmon_tpl:get_lv(BMonTpl),
    Partner = lib_partner:get_partner(PartnerId),
    ?ASSERT(Partner /= null),
    case Partner =:= null of
        true -> DropDtl;
        false ->
            LvDiff = abs(lib_partner:get_lv(Partner) - BMonLv), 
            LvDiffReduce = lib_reward:get_lv_delta_coef(LvDiff),
            BaseExpCoef = lib_Bmon_tpl:get_drop_exp_coef(BMonTpl),
            Exp = 
                case lib_partner:is_main_partner(Partner) of %% 主宠获得经验的比例与人物一样，副宠需要乘以一个比例
                    true -> util:ceil(BaseExpCoef * BMonLv * LvDiffReduce);
                    false -> 
                        ParExpCoef = lib_Bmon_tpl:get_drop_par_exp_coef(BMonTpl),
                        util:ceil(BaseExpCoef * BMonLv * LvDiffReduce * ParExpCoef)
                end,
            ?TRACE("do_calc_drop_to_partner__(), exp, Exp=~p~n", [Exp]),
            
            case lists:keyfind(?VGOODS_PAR_EXP, 2, DropDtl#drop_dtl.goods_list) of
                false -> DropDtl#drop_dtl{goods_list = DropDtl#drop_dtl.goods_list ++ [{?INVALID_ID, ?VGOODS_PAR_EXP, Exp}]};
                {GoodsId, GoodsNo, Count} ->
                    GoodsList = lists:keyreplace(GoodsNo, 2, DropDtl#drop_dtl.goods_list, {GoodsId, GoodsNo, Exp + Count}),
                    DropDtl#drop_dtl{goods_list = GoodsList}
            end
    end.


do_give_drop_to_player__(money, _PS, _BMonTpl, null, _) ->
    #drop_dtl{};
do_give_drop_to_player__(money, _PS, _BMonTpl, {Proba, MoneyType, MoneyAmount} = _DropMoney, _LogInfo) ->
    ?ASSERT(util:is_probability(Proba), _DropMoney),
    ?ASSERT(lib_comm:is_valid_money_type(MoneyType) , _DropMoney),
    ?ASSERT(is_integer(MoneyAmount) andalso MoneyAmount > 0, _DropMoney),

    case util:decide_proba_once(Proba) of
        fail ->
            #drop_dtl{};
        success ->
            %% 改到玩家进程添加金钱
            % player:add_money(PS, MoneyType, MoneyAmount, LogInfo),
            GoodsNo = 
                case MoneyType of
                    ?MNY_T_GAMEMONEY -> ?VGOODS_GAMEMONEY;
                    ?MNY_T_YUANBAO -> ?VGOODS_YB;
                    ?MNY_T_BIND_GAMEMONEY -> ?VGOODS_BIND_GAMEMONEY;
                    ?MNY_T_BIND_YUANBAO -> ?VGOODS_BIND_YB;
                    ?MNY_T_INTEGRAL -> ?VGOODS_INTEGRAL;
                    ?MNY_T_COPPER -> ?VGOODS_COPPER;
                    ?MNY_T_VITALITY -> ?VGOODS_VITALITY;
                    ?MNY_T_CHIVALROUS -> ?VGOODS_CHIVALROUS;
                    ?MNY_T_QUJING      -> ?VGOODS_QUJING;

                    
                    _Any -> ?ASSERT(false, MoneyType), ?INVALID_NO
                end,

            #drop_dtl{goods_list = [{?INVALID_ID, GoodsNo, MoneyAmount}]}
    end;



do_give_drop_to_player__(goods, _PS, _ShuffledTeamMbList, null, _) ->
    #drop_dtl{};

% 增加有公告的掉落提示
do_give_drop_to_player__(goods, PS, ShuffledTeamMbList, { Proba, GoodsNo, GoodsCount, Quality1, BindState,NeedBroadcast} = _DropGoods, LogInfo) ->
    % ?ASSERT(is_integer(AdaptTeamMbCount) andalso AdaptTeamMbCount >= 0, _DropGoods),
    ?ASSERT(util:is_probability(Proba), _DropGoods),
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0, _DropGoods),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo), _DropGoods),

    Quality = case Quality1 of
        0 ->
            null;
        _ -> Quality1
    end,

    ?ASSERT(Quality == null orelse lib_goods:is_valid_quality(Quality), Quality),
    ?ASSERT(lib_goods:is_valid_bind_state(BindState), BindState),


    PlayerId = player:id(PS),
    
    % AdaptMbList = lists:sublist(ShuffledTeamMbList, AdaptTeamMbCount),
    % % ?TRACE("do_give_drop_to_player__(goods, ..), PlayerId:~p , AdaptMbList: ~p, Proba:~p~n", [PlayerId, AdaptMbList, Proba]),
    % % 自己是否在队伍适配人数列表中？
    % case lists:member(PlayerId, AdaptMbList) of
    %     false ->
    %         #drop_dtl{};
    %     true ->
            case util:decide_proba_once(Proba) of
                fail ->
                    #drop_dtl{};
                success ->
                    % case mod_inv:check_batch_add_goods(PlayerId, [{GoodsNo, GoodsCount}]) of
                    %     {fail, _Reason} ->  % 背包满了则不给
                    %         ?TRACE("do_give_drop_to_player__(), bag full!!!~n"),
                    %         #drop_dtl{};
                    %     ok ->
                    ?DEBUG_MSG("do_give_drop_to_player__(), goods, GoodsNo=~p, GoodsCount=~p, Quality=~p~n", [GoodsNo, GoodsCount, Quality]),
                    RetAddGoods = 
                    case Quality of
                        null -> % 不指定品质
                            mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount}], [{bind_state, BindState}], LogInfo);
                        _ ->  % 指定品质
                            mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount}], [{quality, Quality}, {bind_state, BindState}], LogInfo)
                    end,

                    case NeedBroadcast of
                        0 -> skip;
                        _ -> mod_broadcast:send_sys_broadcast(NeedBroadcast, [player:get_name(PS), player:id(PS), GoodsNo, 0, GoodsCount,0])
                    end,

                    case RetAddGoods of
                        {fail, _Reason} ->
                            ?ERROR_MSG("lib_drop:do_give_drop_to_player__ add_goods error!Reason:~p~n", [_Reason]),
                            #drop_dtl{};
                        {ok, RetGoods} ->
                            F = fun({Id, No, Cnt}) ->
                                case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                                    null -> skip;
                                    Goods ->
                                        ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt,Id]}),
                                        case lib_goods:get_quality(Goods) >= ?QUALITY_PURPLE of
                                            true -> ply_tips:send_sys_tips(PS, {get_goods_quality, [player:get_name(PS), PlayerId, GoodsNo, lib_goods:get_quality(Goods), Cnt]});
                                            false -> skip
                                        end
                                end
                            end,
                            [F(X) || X <- RetGoods],
                            #drop_dtl{goods_list = RetGoods}
                    end
                    % end
            % end
    end;

do_give_drop_to_player__(goods, PS, ShuffledTeamMbList, { Proba, GoodsNo, GoodsCount, Quality, BindState} = _DropGoods, LogInfo) ->
    % ?ASSERT(is_integer(AdaptTeamMbCount) andalso AdaptTeamMbCount >= 0, _DropGoods),
    ?ASSERT(util:is_probability(Proba), _DropGoods),
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0, _DropGoods),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo), _DropGoods),
    ?ASSERT(Quality == null orelse lib_goods:is_valid_quality(Quality), Quality),
    ?ASSERT(lib_goods:is_valid_bind_state(BindState), BindState),

    PlayerId = player:id(PS),
    
    % AdaptMbList = lists:sublist(ShuffledTeamMbList, AdaptTeamMbCount),
    % % ?TRACE("do_give_drop_to_player__(goods, ..), PlayerId:~p , AdaptMbList: ~p, Proba:~p~n", [PlayerId, AdaptMbList, Proba]),
    % % 自己是否在队伍适配人数列表中？
    % case lists:member(PlayerId, AdaptMbList) of
    %     false ->
    %         #drop_dtl{};
    %     true ->
            case util:decide_proba_once(Proba) of
                fail ->
                    #drop_dtl{};
                success ->
                    % case mod_inv:check_batch_add_goods(PlayerId, [{GoodsNo, GoodsCount}]) of
                    %     {fail, _Reason} ->  % 背包满了则不给
                    %         ?TRACE("do_give_drop_to_player__(), bag full!!!~n"),
                    %         #drop_dtl{};
                    %     ok ->
                    ?TRACE("do_give_drop_to_player__(), goods, GoodsNo=~p, GoodsCount=~p, Quality=~p~n", [GoodsNo, GoodsCount, Quality]),
                    RetAddGoods = 
                    case Quality of
                        null -> % 不指定品质
                            mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount}], [{bind_state, BindState}], LogInfo);
                        _ ->  % 指定品质
                            mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount}], [{quality, Quality}, {bind_state, BindState}], LogInfo)
                    end,
                    case RetAddGoods of
                        {fail, _Reason} ->
                            ?ERROR_MSG("lib_drop:do_give_drop_to_player__ add_goods error!Reason:~p~n", [_Reason]),
                            #drop_dtl{};
                        {ok, RetGoods} ->
                            F = fun({Id, No, Cnt}) ->
                                case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                                    null -> skip;
                                    Goods ->
                                        ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt,Id]}),
                                        case lib_goods:get_quality(Goods) >= ?QUALITY_PURPLE of
                                            true -> ply_tips:send_sys_tips(PS, {get_goods_quality, [player:get_name(PS), PlayerId, GoodsNo, lib_goods:get_quality(Goods), Cnt]});
                                            false -> skip
                                        end
                                end
                            end,
                            [F(X) || X <- RetGoods],
                            #drop_dtl{goods_list = RetGoods}
                    end
                    % end
            % end
    end;
do_give_drop_to_player__(goods, _PS, _ShuffledTeamMbList, _DropGoods, _) ->  % TODO: 处理按门派的不同给予不同物品
    todo_here,
    #drop_dtl{};


do_give_drop_to_player__(task_goods, _PS, _ShuffledTeamMbList, null, _) ->
    #drop_dtl{};
do_give_drop_to_player__(task_goods, PS, ShuffledTeamMbList, { Proba, GoodsNo, GoodsCount, BindState, TaskId} = _DropTaskGoods, LogInfo) ->
    % ?ASSERT(is_integer(AdaptTeamMbCount) andalso AdaptTeamMbCount >= 0, _DropTaskGoods),
    ?ASSERT(is_integer(TaskId), _DropTaskGoods),
    ?ASSERT(util:is_probability(Proba), _DropTaskGoods),
    ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0, _DropTaskGoods),
    ?ASSERT(lib_goods:is_tpl_exists(GoodsNo), _DropTaskGoods),
    ?ASSERT(lib_goods:is_valid_bind_state(BindState), BindState),

    PlayerId = player:id(PS),
    
    % AdaptMbList = lists:sublist(ShuffledTeamMbList, AdaptTeamMbCount),
    % % 自己是否在队伍适配人数列表中？
    % case lists:member(PlayerId, AdaptMbList) of
    %     false ->
    %         #drop_dtl{};
    %     true ->
            case util:decide_proba_once(Proba) of
                fail ->
                    #drop_dtl{};
                success ->
                    % 是否接取了指定的任务？
                    case lib_task:publ_is_accepted(TaskId, PS) of
                        false ->
                            #drop_dtl{};
                        true ->
                            % case mod_inv:check_batch_add_goods(PlayerId, [{GoodsNo, GoodsCount}]) of
                            %     {fail, _Reason} ->  % 背包满了则不给
                            %         #drop_dtl{};
                            %     ok ->
                            ?TRACE("do_give_drop_to_player__(), goods, GoodsNo=~p, GoodsCount=~p~n", [GoodsNo, GoodsCount]),
                            RetAddGoods = mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount}], [{bind_state, BindState}], LogInfo),
                            case RetAddGoods of
                                {fail, _Reason} ->
                                    ?ERROR_MSG("lib_drop:do_give_drop_to_player__ add_goods error!Reason:~p~n", [_Reason]),
                                    #drop_dtl{};
                                {ok, RetGoods} ->
                                    F = fun({Id, No, Cnt}) ->
                                        case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                                            null -> skip;
                                            Goods ->
                                                ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt,Id]}),
                                                case lib_goods:get_quality(Goods) >= ?QUALITY_PURPLE of
                                                    true -> ply_tips:send_sys_tips(PS, {get_goods_quality, [player:get_name(PS), PlayerId, GoodsNo, lib_goods:get_quality(Goods), Cnt]});
                                                    false -> skip
                                                end
                                        end
                                    end,
                                    [F(X) || X <- RetGoods],
                                    #drop_dtl{goods_list = RetGoods}
                            end
                            % end
                    % end         
            end
    end.


do_give_drop_to_team_leader__(leader_weal, _PS, null, _) ->
    #drop_dtl{};
do_give_drop_to_team_leader__(leader_weal, _PS, [], _) ->
    #drop_dtl{};
%% ParaList --> [{Proba, GoodsNo, GoodsCount, Quality, BindState},...]
do_give_drop_to_team_leader__(leader_weal, PS, ParaList, LogInfo) ->
    case player:is_leader(PS) of
        false -> #drop_dtl{};
        true ->
            case mod_team:get_normal_member_count(player:get_team_id(PS)) >= 2 of
                false -> #drop_dtl{};
                true ->
                    PlayerId = player:id(PS),
                    F = fun({Proba, GoodsNo, GoodsCount, Quality, BindState} = _DropGoods, AccDropDtl) ->
                        ?ASSERT(util:is_probability(Proba), _DropGoods),
                        ?ASSERT(is_integer(GoodsCount) andalso GoodsCount > 0, _DropGoods),
                        ?ASSERT(lib_goods:is_tpl_exists(GoodsNo), _DropGoods),
                        ?ASSERT(Quality == null orelse lib_goods:is_valid_quality(Quality), Quality),
                        ?ASSERT(lib_goods:is_valid_bind_state(BindState), BindState),

                        case util:decide_proba_once(Proba) of
                            fail -> AccDropDtl;
                            success ->
                                RetAddGoods = 
                                    case Quality of
                                        null -> % 不指定品质
                                            mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount}], [{bind_state, BindState}], LogInfo);
                                        _ ->  % 指定品质
                                            mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount}], [{quality, Quality}, {bind_state, BindState}], LogInfo)
                                    end,
                                case RetAddGoods of
                                    {fail, _Reason} ->
                                        ?ERROR_MSG("lib_drop:do_give_drop_to_player__ add_goods error!Reason:~p~n", [_Reason]),
                                        AccDropDtl;
                                    {ok, RetGoods} ->
                                        F = fun({Id, No, Cnt}) ->
                                            case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                                                null -> skip;
                                                Goods ->
                                                    ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt,Id]}),
                                                    case lib_goods:get_quality(Goods) >= ?QUALITY_PURPLE of
                                                        true -> ply_tips:send_sys_tips(PS, {get_goods_quality, [player:get_name(PS), PlayerId, GoodsNo, lib_goods:get_quality(Goods), Cnt]});
                                                        false -> skip
                                                    end
                                            end
                                        end,
                                        [F(X) || X <- RetGoods],
                                        AccDropDtl#drop_dtl{goods_list = RetGoods ++ AccDropDtl#drop_dtl.goods_list}
                                end
                        end
                    end,
                    lists:foldl(F, #drop_dtl{}, ParaList)
            end
    end.

%% Para --> [{概率，物品编号, 物品数量,品质,绑定状态,活动id},...]
do_give_drop_to_player__(act_goods, PS, Para, LogInfo) ->
    PlayerId = player:id(PS),
    F = fun({Proba, GoodsNo, GoodsCount, Quality, BindState, ActId}, Acc) ->
        Drop = 
            case mod_admin_activity:is_festival_activity_alive(ActId) of
                false -> #drop_dtl{};
                true ->
                    case util:decide_proba_once(Proba) of
                        fail -> #drop_dtl{};
                        success ->
                            RetAddGoods = 
                                case Quality of
                                    null -> % 不指定品质
                                        mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount}], [{bind_state, BindState}], LogInfo);
                                    _ ->  % 指定品质
                                        mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, GoodsCount}], [{quality, Quality}, {bind_state, BindState}], LogInfo)
                                end,
                            case RetAddGoods of
                                {fail, _Reason} ->
                                    ?ERROR_MSG("lib_drop:do_give_drop_to_player__ act_goods add_goods error!Reason:~p~n", [_Reason]),
                                    #drop_dtl{};
                                {ok, RetGoods} ->
                                    F = fun({Id, No, Cnt}) ->
                                        case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                                            null -> skip;
                                            Goods ->
                                                ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt,Id]}),
                                                case lib_goods:get_quality(Goods) >= ?QUALITY_PURPLE of
                                                    true -> ply_tips:send_sys_tips(PS, {get_goods_quality, [player:get_name(PS), PlayerId, GoodsNo, lib_goods:get_quality(Goods), Cnt]});
                                                    false -> skip
                                                end
                                        end
                                    end,
                                    [F(X) || X <- RetGoods],
                                    #drop_dtl{goods_list = RetGoods}
                            end
                    end
            end,
        sum_drop([Acc, Drop])
    end,
    lists:foldl(F, #drop_dtl{}, Para).

%% 多个drop_dtl结构体的对应字段相加，返回结果
%% @return: drop_dtl结构体
sum_drop([]) ->
    #drop_dtl{};
sum_drop([Drop]) ->
    ?ASSERT(is_record(Drop, drop_dtl)),
    Drop;
sum_drop([Drop1, Drop2 | T]) ->
    TmpDrop = sum_two_drop(Drop1, Drop2),
    sum_drop([TmpDrop | T]).

sum_two_drop(Drop1, Drop2) ->
    ?ASSERT(is_record(Drop1, drop_dtl), Drop1),
    ?ASSERT(is_record(Drop2, drop_dtl), Drop2),
    #drop_dtl{
        goods_list = Drop1#drop_dtl.goods_list ++ Drop2#drop_dtl.goods_list
        }.            