%%%--------------------------------------
%%% @Module  : ply_xinfa (ply: player)
%%% @Author  : huangjf
%%% @Email   :
%%% @Created : 2013.11.14
%%% @Description: 玩家的与心法相关的业务逻辑
%%%--------------------------------------
-module(ply_xinfa).
-export([
        init_xinfa/2,
        db_load_xinfa/1,

        db_save_xinfa/1,       % 保存心法信息到数据库

        on_player_final_logout/1,

        unlock_master_xinfa/2,

        get_player_xinfa_info/1,
        get_player_xinfa_brief_list/1,
        get_player_slave_xinfa_brief_list/1,

        get_player_xinfa_lv/2,
        get_faction_master_xinfa_id/1,
        get_player_master_xinfa_info/1,
        get_player_master_xinfa_lv/1,
        calc_player_all_xinfa_total_lv/1,


        check_upgrade_xinfa/2,
        upgrade_xinfa/2,        % 升级心法

        transform_xinfa/3,      %心法转换
        transform_xinfa/4,

        check_activate_slave_xinfa/2,
        activate_slave_xinfa/2,
		
		add_player_xinfa_info_to_ets/1,
		
		apply_upgrade_xinfa_costs/3


    ]).

-include("common.hrl").
-include("xinfa.hrl").
-include("ets_name.hrl").
-include("prompt_msg_code.hrl").
-include("faction.hrl").
-include("player.hrl").
-include("log.hrl").





%% 心法系统对玩家开放的需求等级
-define(START_XINFA_NEED_LV, 0).



init_xinfa(PlayerId, PlayerLv) ->
    case PlayerLv < ?START_XINFA_NEED_LV of
        true ->
            skip;
        false ->
            db_load_xinfa(PlayerId)
    end.



%% 从DB加载玩家的心法信息
db_load_xinfa(PlayerId) ->
    case db:select_row(xinfa, "xinfa_list", [{player_id, PlayerId}]) of
        [] ->
            % ?ASSERT(false, PlayerId),
            ?TRACE("db_load_xinfa(), no xinfa...~n"),
            skip;
        [XfList_BS] ->
            XfList = util:bitstring_to_term(XfList_BS),
            ?TRACE("db_load_xinfa(), PlayerId=~p, XfList_BS: ~p, XfList:~p~n", [PlayerId, XfList_BS, XfList]),
            ?ASSERT(XfList /= [] andalso XfList /= undefined, {XfList, XfList_BS}),
            F = fun({XfId, XfLv}) ->
                    #xinfa_brief{id = XfId, lv = XfLv}
                end,
            XfBriefList = [F(X) || X <- XfList],
            PlyXfInfo = #ply_xinfa{
                                player_id = PlayerId,
                                info_list = XfBriefList
                                },
            add_player_xinfa_info_to_ets(PlyXfInfo);
        _Any ->
            ?ASSERT(false, {PlayerId, _Any}),
            skip
    end.



%% 保存玩家的心法信息到DB
db_save_xinfa(PlayerId) ->
    case get_player_xinfa_info(PlayerId) of
        null ->
            ?ASSERT(false, PlayerId),
            skip;
        PlyXfInfo ->
            XfBriefList = PlyXfInfo#ply_xinfa.info_list,
            ?ASSERT(XfBriefList /= [], PlayerId),

            L = [{X#xinfa_brief.id, X#xinfa_brief.lv} || X <- XfBriefList],

            XfBriefList_BS = util:term_to_bitstring(L),

            ?TRACE("db_save_xinfa(), PlayerId=~p, L=~p, XfBriefList_BS=~p~n", [PlayerId, L, XfBriefList_BS]),

            db:update(PlayerId, xinfa, ["xinfa_list"], [XfBriefList_BS], "player_id", PlayerId)
    end.



%% 插入玩家所对应的一条记录到数据库的xinfa表
db_insert_one_xinfa_record(PlayerId, XfId, XfLv) ->
    XfList = [{XfId, XfLv}],
    XfList_BS = util:term_to_bitstring(XfList),
    db:insert(xinfa, ["player_id", "xinfa_list"], [PlayerId, XfList_BS]),
    void.




on_player_final_logout(PlayerId) ->
    del_player_xinfa_info_from_ets(PlayerId).




%% 获取门派对应的主心法id
get_faction_master_xinfa_id(Faction) ->
    % case Facton of
    %     ?FACTION_WJM ->

    % end.
    ?ASSERT(lib_comm:is_valid_faction(Faction), Faction),
    BaseInfo = data_faction:get(Faction),
    ?ASSERT(BaseInfo /= null, Faction),
    ?ASSERT(util:is_positive_int(BaseInfo#faction_base.master_xinfa)),

    BaseInfo#faction_base.master_xinfa.




%% 主心法的初始等级
-define(MASTER_XINFA_INIT_LV, 1).


%% 解锁主心法
unlock_master_xinfa(PS, Faction) ->
    ?ASSERT(lib_comm:is_valid_faction(Faction)),

    PlayerId = player:id(PS),


    XfId = get_faction_master_xinfa_id(Faction),

    % Xf = mod_xinfa:get_cfg_data(XfId),

    XfBrief = #xinfa_brief{id = XfId, lv = ?MASTER_XINFA_INIT_LV},

    % 构造玩家心法的初始信息
    PlyXfInfo = #ply_xinfa{
                    player_id = PlayerId,
                    info_list = [XfBrief]
                    },
    % 插入到ets
    add_player_xinfa_info_to_ets(PlyXfInfo),
    % 插入到DB
    db_insert_one_xinfa_record(PlayerId, XfId, ?MASTER_XINFA_INIT_LV),

    % apply心法的属性加成
    ply_attr:recount_xinfa_add_and_total_attrs(PS).




%% 获取玩家的心法信息
%% @return: null | ply_xinfa结构体
get_player_xinfa_info(PlayerId) ->
    ?ASSERT(is_integer(PlayerId)),
    case ets:lookup(?ETS_PLAYER_XINFA, PlayerId) of
        [] -> null;
        [PlyXfInfo] -> PlyXfInfo
    end.


%% 以获玩家的心法简要信息列表
%% @return: [] | xinfa_brief结构体列表
get_player_xinfa_brief_list(PlayerId) ->
    case get_player_xinfa_info(PlayerId) of
        null ->
            [];
        PlyXfInfo ->
            PlyXfInfo#ply_xinfa.info_list
    end.

%% 以获玩家的副心法简要信息列表
%% @return: [] | xinfa_brief结构体列表
get_player_slave_xinfa_brief_list(PlayerId) ->
    XfList = get_player_xinfa_brief_list(PlayerId),
    F = fun(#xinfa_brief{id=XfID}) -> not mod_xinfa:is_master(XfID) end,
    lists:filter(F, XfList).



%% 获取玩家的一个指定id的心法的信息
%% @return: null | xinfa_brief结构体
get_player_one_xinfa_info(PlayerId, XfId) ->
    case get_player_xinfa_info(PlayerId) of
        null ->
            null;
        PlyXfInfo ->
            XfBriefList = PlyXfInfo#ply_xinfa.info_list,
            case lists:keyfind(XfId, #xinfa_brief.id, XfBriefList) of
                false ->
                    null;
                XfBrief ->
                    XfBrief
            end
    end.



%% 获取玩家的主心法信息
%% @return: null | xinfa_brief结构体
get_player_master_xinfa_info(PlayerId) ->
    case get_player_xinfa_info(PlayerId) of
        null ->
            null;
        PlyXfInfo ->
            XfBriefList = PlyXfInfo#ply_xinfa.info_list,
            get_player_master_xinfa_info__(XfBriefList)
    end.

get_player_master_xinfa_info__([XfBrief | T]) ->
    case mod_xinfa:is_master(XfBrief#xinfa_brief.id) of
        true ->
            XfBrief;
        false ->
            get_player_master_xinfa_info__(T)
    end;
get_player_master_xinfa_info__([]) ->
    ?ASSERT(false),
    null.



% 获取主心法等级
get_player_master_xinfa_lv(PlayerId) ->
    case ply_xinfa:get_player_master_xinfa_info(PlayerId) of
        #xinfa_brief{lv=Lv} ->
            Lv;
        _ ->
            0
    end.


%% 获取玩家的指定心法的等级
%% @return: 等级 | error
get_player_xinfa_lv(PlayerId, XfId) ->
    case get_player_one_xinfa_info(PlayerId, XfId) of
        null ->
            error;
        XfBrief ->
            XfBrief#xinfa_brief.lv
    end.


%% 计算玩家所有心法的等级总和， 如果玩家没有学习任何心法，则返回0
calc_player_all_xinfa_total_lv(PlayerId) ->
    case get_player_xinfa_info(PlayerId) of
        null ->
            0;
        PlyXfInfo ->
            XfBriefList = PlyXfInfo#ply_xinfa.info_list,
            F = fun(XfBrief, TotalLv) ->
                    TotalLv + XfBrief#xinfa_brief.lv
                end,
            lists:foldl(F, 0, XfBriefList)
    end.


add_player_xinfa_info_to_ets(PlyXfInfo) when is_record(PlyXfInfo, ply_xinfa) ->
    % ?ASSERT(get_player_xinfa_info(PlyXfInfo#ply_xinfa.player_id) == null, PlyXfInfo),
    % 为何会出现ETS数据还在就要添加的情况？
    ets:insert(?ETS_PLAYER_XINFA, PlyXfInfo).


del_player_xinfa_info_from_ets(PlayerId) ->
    ?ASSERT(is_integer(PlayerId)),
    ets:delete(?ETS_PLAYER_XINFA, PlayerId).



update_player_xinfa_info_to_ets(PlyXfInfo) when is_record(PlyXfInfo, ply_xinfa) ->
    ets:insert(?ETS_PLAYER_XINFA, PlyXfInfo).






%% 检测升级心法
%% @return: ok | {fail, Reason}
check_upgrade_xinfa(PS, XfId) ->
    PlayerId = player:id(PS),
    case get_player_one_xinfa_info(PlayerId, XfId) of
        null ->
            ?ASSERT(false, XfId),
            {fail, ?PM_UNKNOWN_ERR};
        XfBrief ->
            CurLv = XfBrief#xinfa_brief.lv,
            case CurLv >= ?MAX_XINFA_LV of
                true ->
                    {fail, ?PM_XF_ALRDY_MAX_LV};
                false ->
                    case check_upgrade_xinfa_costs(PS, CurLv) of
                        {fail, Reason} ->
                            {fail, Reason};
                        ok ->
                            XfCfg = mod_xinfa:get_cfg_data(XfId),
                            case mod_xinfa:is_master(XfCfg) of
                                true ->
                                    ?ASSERT(get_player_master_xinfa_info(PlayerId) =:= XfBrief),
                                    % 是否会超过玩家等级？

                                    MaxLv = player:get_player_max_lv(PS),

                                    case (CurLv >= (player:get_lv(PS) + 10) orelse CurLv >= MaxLv) of
                                        true ->
                                            {fail, ?PM_XF_UPGRADE_FAIL_FOR_PLAYER_LV_LIMIT};
                                        false ->
                                            ok
                                    end;
                                false ->
                                    % 是否会超过主心法等级？
                                    case get_player_master_xinfa_info(PlayerId) of
                                        null ->
                                            ?ASSERT(false, {PlayerId, XfId}),
                                            {fail, ?PM_UNKNOWN_ERR};
                                        MasterXfBrief ->
                                            MasterXfLv = MasterXfBrief#xinfa_brief.lv,
                                            case CurLv >= MasterXfLv of
                                                true ->
                                                    {fail, ?PM_XF_UPGRADE_FAIL_FOR_MASTER_XF_LV_LIMIT};
                                                false ->
                                                    ok
                                            end
                                    end
                            end
                    end
            end
    end.


%% 升级心法
%% @return: 无用
upgrade_xinfa(PS, XfId) ->
    PlayerId = player:id(PS),
    PlyXfInfo = get_player_xinfa_info(PlayerId),
    XfBrief = get_player_one_xinfa_info(PlayerId, XfId),

    OldLv = XfBrief#xinfa_brief.lv,
    NewLv = OldLv + 1,
	mod_achievement:notify_achi(xinfa_skill,  [[{xinfa_lv, NewLv}, {num, 1}]],PS),
    XfBrief_New = XfBrief#xinfa_brief{lv = NewLv},

    InfoList_New = lists:keyreplace(XfId, #xinfa_brief.id, PlyXfInfo#ply_xinfa.info_list, XfBrief_New),

    PlyXfInfo_New = PlyXfInfo#ply_xinfa{info_list = InfoList_New},

    update_player_xinfa_info_to_ets(PlyXfInfo_New),

    db_save_xinfa(PlayerId),

    PS1 = apply_upgrade_xinfa_costs(PS, XfId, OldLv),

    % apply心法的属性加成
    ply_attr:recount_xinfa_add_and_total_attrs(PS1),
    ply_tips:send_sys_tips(PS1, {xinfa_lv_up, [XfId, NewLv]}),
    PS1.



%% 转换心法
%% 参数 新门派
%% 返回值void
transform_xinfa(PS, faction ,NewFaction) ->
    %% 当前门派
    Faction = player:get_faction(PS),

    ?DEBUG_MSG("Faction:~p",[Faction]),
    ?DEBUG_MSG("NewFaction:~p",[NewFaction]),

    CurXinFaList = ply_faction:get_faction_xinfa_ids_config(Faction),    
    NewXinFaList = ply_faction:get_faction_xinfa_ids_config(NewFaction),

    ?DEBUG_MSG("CurXinFaList:~p",[CurXinFaList]),
    ?DEBUG_MSG("NewXinFaList:~p",[NewXinFaList]),

    transform_xinfa(PS,list,CurXinFaList,NewXinFaList),

    void.

%% 转换心法
%% @return: void
transform_xinfa(PS, single, XfId, NewId) ->
    PlayerId = player:id(PS),
    PlyXfInfo = get_player_xinfa_info(PlayerId),

    XfBrief = get_player_one_xinfa_info(PlayerId, XfId),
    OldLv = XfBrief#xinfa_brief.lv,
    ?DEBUG_MSG("PlayerId:~p XfBrief:~p OldLv:~p",[PlayerId,XfBrief,OldLv]),

    XfBrief_New = XfBrief#xinfa_brief{id = NewId,lv = OldLv},

    InfoList_New = lists:keyreplace(XfId, #xinfa_brief.id, PlyXfInfo#ply_xinfa.info_list, XfBrief_New),

    PlyXfInfo_New = PlyXfInfo#ply_xinfa{info_list = InfoList_New},

    ?DEBUG_MSG("PlyXfInfo_New:~p",[PlyXfInfo_New]),

    update_player_xinfa_info_to_ets(PlyXfInfo_New),

    %db_save_xinfa(PlayerId),

    % apply心法的属性加成
    %ply_attr:recount_xinfa_add_and_total_attrs(PS),

    PlyXfInfo_New;
    %ply_tips:send_sys_tips(PS, {xinfa_lv_up, [XfId, NewLv]}).


%% 转换心法
%% 参数 当前心法列表 新心法列表
%% 返回值void
transform_xinfa(PS, list, CurXinFaList, NewXinFaList) ->
    [Oid1,Oid2,Oid3] = CurXinFaList,
    [Nid1,Nid2,Nid3] = NewXinFaList,

    PlayerId = player:id(PS),

    ?DEBUG_MSG("Oid1:~p",[Oid1]),
    ?DEBUG_MSG("Nid1:~p",[Nid1]),

    transform_xinfa(PS,single,Oid1,Nid1),
    transform_xinfa(PS,single,Oid2,Nid2),
    _PlyXfInfo = transform_xinfa(PS,single,Oid3,Nid3),
    db_save_xinfa(PlayerId),

    %%?DEBUG_MSG("PlyXfInfo:~p",[_PlyXfInfo]),

    %%del_player_xinfa_info_from_ets(PlayerId),
    %%?DEBUG_MSG("del PlayerId:~p",[PlayerId]),
    %%add_player_xinfa_info_to_ets(PlyXfInfo),

    void.


%% 升级所需的消耗
get_upgrade_costs(CurXfLv) ->
    data_xinfa_upg_costs:get(CurXfLv).


%% 检查是否满足升级所需的消耗
%% @return: ok | {fail, Reason}
check_upgrade_xinfa_costs(PS, CurXfLv) ->
    UpgCosts = get_upgrade_costs(CurXfLv),
    % 钱是否够？
    CostGameMoney = UpgCosts#xf_upg_costs.gamemoney,
    ?ASSERT(util:is_nonnegative_int(CostGameMoney), CurXfLv),
    case player:has_enough_money(PS, ?MNY_T_BIND_GAMEMONEY, CostGameMoney) of
        false ->
            {fail, ?PM_MONEY_LIMIT};
        true ->
            % 经验是否够？
            CostExp = UpgCosts#xf_upg_costs.exp,
            ?ASSERT(util:is_nonnegative_int(CostExp), CurXfLv),
            case player:get_exp(PS) >= CostExp of
                false ->
                    {fail, ?PM_EXP_LIMIT};
                true ->
                    ok
            end
    end.

%% 处理升级心法的消耗
apply_upgrade_xinfa_costs(PS, _XfId, OldLv) ->
    % XfCfg = mod_xinfa:get_cfg_data(XfId),

    % % 扣钱
    % CostMoneyType = mod_xinfa:get_upg_cost_money_type(XfCfg),
    % CostMoney = mod_xinfa:get_upg_cost_money(XfCfg),
    % case CostMoneyType of
    %     ?MNY_T_INVALID ->
    %         skip;
    %     _ ->
    %         ?ASSERT(lib_comm:is_valid_money_type(CostMoneyType), XfCfg),
    %         ?ASSERT(is_integer(CostMoney) andalso CostMoney > 0, XfCfg),

    %         ?TRACE("apply_upgrade_xinfa_costs(), CostMoneyType=~p, CostMoney=~p~n", [CostMoneyType, CostMoney]),
    %         player:cost_money(PS, CostMoneyType, CostMoney)
    % end,

    % % 扣经验
    % CostExp = mod_xinfa:get_upg_cost_exp(XfCfg),
    % ?ASSERT(is_integer(CostExp) andalso CostExp >= 0, XfCfg),
    % ?TRACE("apply_upgrade_xinfa_costs(), CostExp=~p~n", [CostExp]),
    % player:cost_exp(PS, CostExp).

    UpgCosts = get_upgrade_costs(OldLv),
    % 扣钱
    CostGameMoney = UpgCosts#xf_upg_costs.gamemoney,

    % 修改为同步扣钱
    NewPS = player_syn:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, CostGameMoney, [?LOG_ROLE, "skill_up"]),
    % player_syn:update_PS_to_ets(NewPS).
    NewPS.
    % % 扣经验
    % CostExp = UpgCosts#xf_upg_costs.exp,
    % player:cost_exp(PS, CostExp, [?LOG_ROLE, "skill_up"]).




%% 检测激活从属心法
%% @return: ok | {fail, Reason}
check_activate_slave_xinfa(PS, SlaveXfId) ->
    ?ASSERT(mod_xinfa:is_slave(SlaveXfId)),

    PlayerId = player:id(PS),
    case get_player_master_xinfa_info(PlayerId) of
        null ->
            {fail, ?PM_UNKNOWN_ERR};
        MasterXfBrief ->
            % 是否属于同一个门派？
            SlaveXfCfg = mod_xinfa:get_cfg_data(SlaveXfId),
            case mod_xinfa:get_faction(SlaveXfCfg) == player:get_faction(PS) of
                false ->
                    ?ASSERT(false, SlaveXfId),
                    {fail, ?PM_UNKNOWN_ERR};
                true ->
                    % 是否已解锁？
                    MasterXfLv = MasterXfBrief#xinfa_brief.lv,
                    UnlockLv = mod_xinfa:get_unlock_lv(SlaveXfCfg),
                    case MasterXfLv >= UnlockLv of
                        false ->
                            {fail, ?PM_XF_LOCKED};
                        true ->
                            % 是否已经激活过了？
                            case get_player_one_xinfa_info(PlayerId, SlaveXfId) of
                                null ->
                                    ok;
                                _SlaveXfBrief ->
                                    {fail, ?PM_XF_ALRDY_ACTIVATED}
                            end
                    end
            end
    end.





%% 激活从属心法
activate_slave_xinfa(PS, XfId) ->
    ?ASSERT(mod_xinfa:is_slave(XfId)),

    PlayerId = player:id(PS),
    PlyXfInfo = get_player_xinfa_info(PlayerId),

    InfoList_Old = PlyXfInfo#ply_xinfa.info_list,

    % 构造心法brief
    NewXfBrief = #xinfa_brief{id = XfId, lv = 1},  % 激活后为1级

    InfoList_New = InfoList_Old ++ [NewXfBrief],


    PlyXfInfo_New = PlyXfInfo#ply_xinfa{info_list = InfoList_New},

    update_player_xinfa_info_to_ets(PlyXfInfo_New),

    db_save_xinfa(PlayerId),

    % apply心法的属性加成
    ply_attr:recount_xinfa_add_and_total_attrs(PS).
