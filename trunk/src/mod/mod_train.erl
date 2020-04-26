%%%-------------------------------------------------------------------
%%% @author lizhipeng
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. 七月 2018 21:08
%%%-------------------------------------------------------------------
-module(mod_train).

-include("train.hrl").
-include("pt_13.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("goods.hrl").
-include("ets_name.hrl").
-include("record.hrl").
-include("common.hrl").
-include("protocol/pt_39.hrl").
-include("abbreviate.hrl").
-include("def_fun.hrl").

%% API
-export([
    get_train_info/1,
    evolve_train_with_money/3,
    takeoff_art/4,
    takeoff_art/5,
    puton_art/4,
    puton_art/5,
    player_add_art/2,
    check_player_add_art/3,
    art_transmit/3,
    is_art_full/0,
    bag_limit/0,
    linshi_bag_limit/0
]).

%% 获取练功房总览信息
get_train_info(PS) ->
    PlayerId = player:get_id(PS),
    PlayerMisc = ply_misc:get_player_misc(PlayerId),

    NowTime = util:unixtime(),
%%    ?DEBUG_MSG("---------------true or false-----------------~p~n", [util:is_timestamp_same_day(NowTime, 0)]),
    case util:is_timestamp_same_day(NowTime, PlayerMisc#player_misc.reset_time) of
        true ->
            #player_misc{
                lv_train = LvTrain
            } = PlayerMisc;
        false ->
            LvTrain = [1],
            ResetTime = NowTime,
            ply_misc:update_player_misc(PlayerMisc#player_misc{lv_train = LvTrain, reset_time = ResetTime}),
            ply_misc:db_save_player_misc(PlayerId)
    end,
%%    lib_train:login_init(PS),
    ArtsListIne = lib_train:get_unequipped_arts_by_role(),         %% 未装备的内功
    NewMisc = ply_misc:get_player_misc(PlayerId),
    {ok,Bin} = pt_39:write(?PT_TRAIN_INVENTORY, [LvTrain,erlang:length(ArtsListIne),NewMisc#player_misc.liangong_bag]),
    lib_send:send_to_uid(PlayerId, Bin),
    ok.

%% 练功，有概率升级练功房，并且一定产生内功
evolve_train_with_money(PS,CostType, Lv) ->
    case check_player_add_art(PS, CostType, Lv) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            PlayerId = player:get_id(PS),
%%          case ets:lookup(?ETS_PLAYER_MISC, PlayerId) of(可以改回来)
            case ply_misc:get_player_misc(PlayerId) of
                PlayerMisc when is_record(PlayerMisc, player_misc) ->
					mod_achievement:notify_achi(get_neigong, [], PS),
%%                    LvTrain = PlayerMisc#player_misc.lv_train,
                    case get_config_data(Lv) of
                        ConfigData when is_record(ConfigData, train_cfg) ->
                            [{MoneyType, MoneyNum}] = ConfigData#train_cfg.cost2,
                            [NeedCost] =ConfigData#train_cfg.cost,
                            Up = ConfigData#train_cfg.upgrade_rate,
                            ArtsPool = ConfigData#train_cfg.pool,
                            case CostType == 1 of
                                true ->
                                    mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["mod_train", "evolve_train"]),
                                    evolve_detail(PS,PlayerId,PlayerMisc,ArtsPool,Up,Lv);
                                false ->
                                    player:cost_money(PS, MoneyType, MoneyNum, ["mod_train", "evolve_train"]),
                                    evolve_detail(PS,PlayerId,PlayerMisc,ArtsPool,Up,Lv)
                            end
                    end;
                _ ->
                    null
            end
    end.

evolve_detail(PS,PlayerId,PlayerMisc0,ArtsPool,Up,LvTrain) ->
    ArtNo = produce_one_art(ArtsPool),
    ArtStar = (data_internal_skill:get(ArtNo))#internal_skill_cfg.internal_skill_star,
    mod_achievement:notify_achi(get_wuxing, [{num, ArtStar}], PS),
    AttrAdd = lib_train:set_attr(ArtNo, 1, ArtStar),
    AttrAdd_BS = util:term_to_bitstring(AttrAdd),
    NewId = db:insert_get_id(arts, [art_no, player_id, star, attr_add], [ArtNo, PlayerId, ArtStar, AttrAdd_BS]),
%%                                  ?DEBUG_MSG("NewId----------------~p~n", [NewId]),
    ArtId = lib_train:generate_sole_art_id(NewId),

    RoleArt = #role_arts{
        id = ArtId
        ,art_no = ArtNo
        ,player_id = PlayerId
        ,partner_id = 0
        ,bind_state = 0
        ,star = ArtStar
        ,lv = 1
        ,exp = 0
        ,attr_add = AttrAdd
        ,pos = 0

    },
    lib_train:update_role_arts(RoleArt),
%%                                    ?DEBUG_MSG("-------------------Before--------------~p", [get(arts)]),
    lib_train:put_artno_in_dict(ArtId),
%%                                    ?DEBUG_MSG("-------------------After--------------~p", [get(arts)]),

    %% 13014协议
    {ok, BinData1} = pt_13:write(?PT_PLYR_NOTIFY_GAIN_ITEM, [?GOODS_T_ART, ArtId, ArtNo, 1]),
    lib_send:send_to_uid(PlayerId, BinData1),

    PlayerMisc= PlayerMisc0#player_misc{liangong_bag = [ArtId|PlayerMisc0#player_misc.liangong_bag]},

    NewLvTrainList1 = ?IF(LvTrain == 1, PlayerMisc#player_misc.lv_train, lists:delete(LvTrain, PlayerMisc#player_misc.lv_train)),
    Seed = random:uniform(1000),
    case Seed =< Up of
        %%升级
        true ->
            MaxTrainLv = lists:max(data_train:get_no()),
            NewLvTrainList2 = ?IF(LvTrain + 1 > MaxTrainLv,
                NewLvTrainList1,
                lists:usort([LvTrain + 1|NewLvTrainList1])),
            ply_misc:update_player_misc(PlayerMisc#player_misc{lv_train = NewLvTrainList2}),
            ply_misc:db_save_player_misc(PlayerId),
            {ok, BinData} = pt_39:write(?PT_START_TRAIN, [ArtId, ArtNo, NewLvTrainList2]),
            lib_send:send_to_uid(PlayerId, BinData);
        false ->
            ply_misc:update_player_misc(PlayerMisc#player_misc{lv_train = NewLvTrainList1}),
            ply_misc:db_save_player_misc(PlayerId),
            {ok, BinData} = pt_39:write(?PT_START_TRAIN, [ArtId, ArtNo, NewLvTrainList1]),
            lib_send:send_to_uid(PlayerId, BinData)
    end.

%% @doc 取得配置表相关数据
get_config_data(TrainLv) ->
    data_train:get(TrainLv).

%% 产出一个内功
produce_one_art(ArtsPool) ->

    F0 = fun({_, ArtsWeight}, Acc) ->
        ArtsWeight + Acc
    end,
    Sum = lists:foldl(F0, 0, ArtsPool),
    Seed = random:uniform(Sum),
    get_art_no(Seed,ArtsPool,0).

get_art_no(Seed,[H|T],SumCount0) ->
    {ArtNo,Weight} = H,
    SumCount = SumCount0 + Weight,
    case SumCount >= Seed of
        true -> ArtNo ;
        false -> get_art_no(Seed,T,SumCount)
    end.

%% 脱下内功
takeoff_art(for_player, PS, ArtId, _Index) ->
    case is_art_full() of
        ok ->
            ets:update_element(?ETS_ROLE_ARTS, ArtId, [{#role_arts.bind_state, 0},{#role_arts.pos, 0}]),
            db:update(arts, [{bind_state, 0},{position, 0}], [{id, ArtId}]),
            ply_attr:recount_all_attrs(PS),             %% 计算属性
            {ok, ?RES_OK, ArtId};
        {fail, MsgCode} ->
            {fail, MsgCode}
    end.

takeoff_art(for_partner, PS, PartnerId, ArtId, _Index) ->
    case is_art_full() of
        ok ->
            ets:update_element(?ETS_ROLE_ARTS, ArtId, [{#role_arts.bind_state, 0}, {#role_arts.pos, 0}]),
            db:update(arts, [{bind_state, 0},{position, 0}], [{id, ArtId}]),
            lib_partner:reset_art_total_attrs(PS, PartnerId),
            {ok, ?RES_OK, ArtId};
        {fail, MsgCode} ->
            {fail, MsgCode}
    end.

check_partner_puton_art(PartnerId, ArtId, Index) ->
    case lib_partner:get_partner(PartnerId) of
        null -> {fail, ?PM_PAR_NOT_EXISTS};
        Partner ->
            case lib_train:get_art_by_id(ArtId) of
                #role_arts{} = RoleArt ->
%%                    ?ASSERT(RoleArt#role_arts.index )
                    M = ply_misc:get_player_misc(),
                    case lists:member(ArtId, M#player_misc.liangong_bag) of
                        false ->
                            Partner = lib_partner:get_partner(PartnerId),
                            PartnerLv = lib_partner:get_lv(Partner),
                            SlotNum = lib_train:get_art_slot_by_lv(PartnerLv),
                            ParArtsIe = lib_train:get_arts_by_partner_id(PartnerId),
                            ?ASSERT(not lists:keymember(Index, #role_arts.pos, ParArtsIe), Index),
                            ?ASSERT(lists:member(Index, lib_partner:get_arts(Partner)), [Index]),
                            ParArtNoIe = [X#role_arts.art_no || X<-ParArtsIe],
                            ISEquipedNum = erlang:length(ParArtsIe),
                            case SlotNum > ISEquipedNum of
                                true ->
                                    case lists:member(RoleArt#role_arts.art_no, ParArtNoIe) of
                                        true ->
                                            {fail, ?PM_ART_SAME_NOT_EQUIP};
                                        false ->
                                            ArtLv = lib_train:get_art_lv(RoleArt),
                                            ParLv = lib_partner:get_lv(Partner),
                                            if
                                            % 等级不够
                                                ParLv < ArtLv ->
                                                    {fail, ?PM_PAR_LV_LIMIT};
                                                true ->
                                                    {ok, RoleArt}
                                            end
                                    end;
                                false ->
                                    {fail, ?PM_ART_SLOT_FULL}
                            end;
                        true ->
                            null
                    end;
                null ->
                    {fail, ?PM_ART_NOT_EXISTS}
            end

    end.

check_player_puton_art(PS, ArtId, Index) ->
    case lib_train:get_art_by_id(ArtId) of
        null -> {fail, ?PM_ART_NOT_EXISTS};
        RoleArt ->
            PlayerLv = player:get_lv(PS),
            ?DEBUG_MSG("-------------------------PlayerLv----------------------~p~n", [PlayerLv]),
            SlotNum = lib_train:get_art_slot_by_lv(PlayerLv),
            ?ASSERT(lib_train:is_ply_open(Index, PS), [Index, PlayerLv]),
            ?DEBUG_MSG("-------------------------SlotNum----------------------~p~n", [SlotNum]),
            PlyArtsIe = lib_train:get_arts_by_ply(),
            ?ASSERT(not lists:keymember(Index, #role_arts.pos, PlyArtsIe), Index),
            PlyArtNoIe = [X#role_arts.art_no || X<-PlyArtsIe],
            ISEquipedNum = erlang:length(PlyArtsIe),
            ?ASSERT(not lists:member(ArtId, lib_train:get_linshi_arts()), [ArtId]),
            ?DEBUG_MSG("-------------------------ISEquipedNum----------------------~p~n", [ISEquipedNum]),
            case SlotNum > ISEquipedNum of
                true ->
                    case lists:member(RoleArt#role_arts.art_no, PlyArtNoIe) of
                        true ->
                            {fail, ?PM_ART_SAME_NOT_EQUIP};
                        false ->
                            {ok, RoleArt}
                    end;
                false ->
                    {fail, ?PM_ART_SLOT_FULL}
            end

    end.

puton_art(for_partner, PS, PartnerId, ArtId, Index) ->
    case check_partner_puton_art(PartnerId, ArtId, Index) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, RoleArt} ->
            do_partner_puton_art(PS, PartnerId, RoleArt, Index)
    end.
puton_art(for_player, PS, ArtId, Index) ->
    case check_player_puton_art(PS, ArtId, Index) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, RoleArt} ->
            do_player_puton_art(PS, RoleArt, Index)
    end.

do_player_puton_art(PS, RoleArt, Index) ->
    ArtId = RoleArt#role_arts.id,
    ets:update_element(?ETS_ROLE_ARTS, ArtId, [{#role_arts.pos, Index},{#role_arts.bind_state, 1}, {#role_arts.partner_id, 0}]),
    db:update(arts, [{bind_state, 1}, {partner_id, 0},{position,Index}], [{id, ArtId}]),
    ply_attr:recount_all_attrs(PS),             %% 计算属性
    {ok, RoleArt}.

do_partner_puton_art(PS, PartnerId, RoleArt, Index) ->
    ArtId = RoleArt#role_arts.id,
    ets:update_element(?ETS_ROLE_ARTS, ArtId, [{#role_arts.pos, Index},{#role_arts.bind_state, 1}, {#role_arts.partner_id, PartnerId}]),
    db:update(arts, [{bind_state, 1}, {partner_id, PartnerId},{position,Index}], [{id, ArtId}]),
    %% 计算属性
    lib_partner:reset_art_total_attrs(PS, PartnerId),
    {ok, RoleArt}.

art_transmit(PS, TargetArtId, IdList) ->
    case check_arts_transmit(PS, TargetArtId, IdList) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, TargetArt, ArtsList, AllExp} ->
            do_art_transmit(PS, TargetArt, ArtsList, AllExp)
    end.

do_art_transmit(PS, TargetArt, ArtsList, AllExp) ->
%%    player:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, NeedMoney, ["internal-skill", "upgrade"]),
%%    ?DEBUG_MSG("-----------------NeedMoney--------------------~p~n", [NeedMoney]),
%%    ?DEBUG_MSG("-----------------ArtsList--------------------~p~n", [ArtsList]),
%%    ?DEBUG_MSG("-----------------TargetArt--------------------~p~n", [TargetArt]),
    F = fun(Art) ->
        lib_train:del_artno_in_dict(Art#role_arts.id),
        lib_train:del_role_arts(Art),        %% 从ets表删除
        lib_train:db_delete_arts(Art)        %% 从数据库删除
        end,
    [F(X) || X <- ArtsList],
    lib_train:add_exp_to_target_art(TargetArt, AllExp, PS),         %% 日志[?LOG_ART, "art transmit"]
    ok.

%% 玩家获得内功
player_add_art(PS, ArtNo) ->
    PlayerId = player:get_id(PS),
    ArtStar = (data_internal_skill:get(ArtNo))#internal_skill_cfg.internal_skill_star,
    AttrAdd = lib_train:set_attr(ArtNo, 1, ArtStar),
    AttrAdd_BS = util:term_to_bitstring(AttrAdd),
    NewId = db:insert_get_id(arts, [art_no, player_id, star, attr_add], [ArtNo, PlayerId, ArtStar, AttrAdd_BS]),
    ArtId = lib_train:generate_sole_art_id(NewId),

    RoleArt = #role_arts{
        id = ArtId
        ,art_no = ArtNo
        ,player_id = PlayerId
        ,partner_id = 0
        ,bind_state = 0
        ,star = ArtStar
        ,lv = 1
        ,exp = 0
        ,attr_add = AttrAdd

    },
    lib_train:update_role_arts(RoleArt),
    lib_train:put_artno_in_dict(ArtId).

%% @doc 背包上限
bag_limit() ->
    {N,_} = data_special_config:get(gongfa_beibao),
    N.

%% @doc 临时背包上限
linshi_bag_limit() ->
    {_, N} = data_special_config:get(gongfa_beibao),
    N.

is_linshi_limit(PS) ->
    Misc = ply_misc:get_player_misc(player:id(PS)),
    case length(Misc#player_misc.liangong_bag) >= linshi_bag_limit() of
        true ->
            {fail, ?PM_ART_NUM_FULL_1};
        false ->
            ok
    end.

%% @doc 检查内功数量是否满了
is_art_full() ->
    case length(lib_train:get_unequipped_arts_by_role()) >= bag_limit() of
        true ->
            {fail, ?PM_ART_NUM_FULL};
        false ->
            ok
    end.

check_player_add_art(PS, CostType, Lv) ->
    case is_linshi_limit(PS) of
        ok ->
            case ply_misc:get_player_misc(player:id(PS)) of
                PlayerMisc when is_record(PlayerMisc, player_misc) ->
                    LvTrainList = PlayerMisc#player_misc.lv_train,
                    case lists:member(Lv, LvTrainList) of
                        true ->
                            case get_config_data(Lv) of
                                ConfigData when is_record(ConfigData, train_cfg) ->
                                    [{MoneyType, MoneyNum}] = ConfigData#train_cfg.cost2,
                                    [NeedCost] =ConfigData#train_cfg.cost,
                                    case CostType == 1 of
                                        true ->
                                            mod_inv:check_batch_destroy_goods(player:id(PS), [NeedCost]);
                                        false ->
                                            case player:check_need_price(PS, MoneyType, MoneyNum) of
                                                ok ->ok;
                                                MsgCode -> {fail, MsgCode}
                                            end
                                    end
                            end;
                        false ->
                            ?ASSERT(false, null)
                    end;
                _ ->
                    ?ASSERT(false, null)
            end;
        {fail, Reason} ->
            {fail, Reason}
    end.

%%  检查内功升级
%%  失败，返回{fail, FailReason}
%%  成功，返回{ok, 目标内功, 被吞噬的内功列表}
check_arts_transmit(PS, TargetArtId, IdList) ->
    try check_arts_transmit__(PS, TargetArtId, IdList) of
        {ok, TargetArt, ArtsList, AllExp} ->
            {ok, TargetArt, ArtsList, AllExp}
    catch
        FailReason ->
            {fail, FailReason}
    end.

check_arts_transmit__(PS, TargetArtId, IdList) ->


    F1 = fun(Id, AccList) ->
        case lib_train:get_art_by_id(Id) of
            null ->
                AccList;
            Art ->
                [Art | AccList]
        end
         end,
    ArtsList = lists:foldl(F1, [], IdList),

    Linshi = lib_train:get_linshi_arts(),
    F0 = fun(A) -> ?ASSERT(not lists:member(A#role_arts.id, Linshi), [A#role_arts.id, Linshi]) end,
    [F0(A)|| A <- [lib_train:get_art_by_id(TargetArtId)|ArtsList]],

    ?Ifc (not lib_train:has_art(TargetArtId))
        throw(?PM_ART_NOT_EXISTS)
    ?End,

%%    ?Ifc (length(IdList) > ?ARTS_MAX_TRANSMITED_OBJ)
%%        throw(?PM_EAT_ART_MAX_NUM)
%%    ?End,

    TargetArt = lib_train:get_art_by_id(TargetArtId),
    ?Ifc (TargetArt =:= null)
        throw(?PM_ART_NOT_EXISTS)
    ?End,

%%    ?DEBUG_MSG("-----------------TargetArt--------------------~p~n", [TargetArt]),
%%    ?DEBUG_MSG("-----------------IdList--------------------~p~n", [IdList]),
%%    ?DEBUG_MSG("-----------------ETS--------------------~p~n", [ets:tab2list(ets_role_arts)]),
%%    F = fun(Id) ->
%%            Art = lib_train:get_art_by_id(Id),
%%            ?DEBUG_MSG("-----------------Art--------------------~p~n", [Art])
%%        end,
%%    lists:foreach(F, IdList),           %% 测试



%%    ?DEBUG_MSG("-----------------ArtsList--------------------~p~n", [ArtsList]),

    F2 = fun(Art, SumExp) ->
        ArtLv = lib_train:get_lv(Art),
        ?DEBUG_MSG("-----------------ArtLv--------------------~p~n", [ArtLv]),
        ArtStar = lib_train:get_star(Art),
        ?DEBUG_MSG("-----------------ArtStar--------------------~p~n", [ArtStar]),
        AddExp = lib_train:get_eat_exp(Art),
        ?DEBUG_MSG("-----------------ArtEatExpCfg--------------------~p~n", [AddExp]),
        SumExp + AddExp
%%          读配置表
%%        case ArtStar of
%%            ?ONE_STAR ->
%%                SumExp + ArtEatExpCfg#internal_skill_eat_exp_cfg.eat_1_star_exp;
%%            ?TWO_STAR ->
%%                SumExp + ArtEatExpCfg#internal_skill_eat_exp_cfg.eat_2_star_exp;
%%            ?THREE_STAR ->
%%                SumExp + ArtEatExpCfg#internal_skill_eat_exp_cfg.eat_3_star_exp;
%%            ?FOUR_STAR ->
%%                SumExp + ArtEatExpCfg#internal_skill_eat_exp_cfg.eat_4_star_exp;
%%            ?FIVE_STAR ->
%%                SumExp + ArtEatExpCfg#internal_skill_eat_exp_cfg.eat_5_star_exp;
%%            _ ->
%%                SumExp
%%        end
    end,
    AllExp = lists:foldl(F2, 0, ArtsList),
%%    ?DEBUG_MSG("-----------------AllExp--------------------~p~n", [AllExp]),
%%    NeedMoney = length(IdList) * data_special_config:get(internal_skill_eat_cost),
%%%%    ?DEBUG_MSG("-----------------NeedMoney--------------------~p~n", [NeedMoney]),
%%
%%    ?Ifc (not player:has_enough_bind_gamemoney(PS, NeedMoney))
%%        throw(?PM_GAMEMONEY_LIMIT)
%%    ?End,

    ?Ifc (lib_train:get_lv(TargetArt) >= (player:get_player_max_lv(PS)))
        throw(?PM_ART_LV_MAX_LIMIT)
    ?End,

    TargetArt_Lv = lib_train:get_lv(TargetArt),
    TargetArt_Star = lib_train:get_star(TargetArt),
    TargetArt_Exp = lib_train:get_exp(TargetArt),
    {NewLv, _LeftExp} = lib_train:change_lv_by_exp(PS, TargetArt_Lv, TargetArt_Star, TargetArt_Exp+AllExp),

    case TargetArt#role_arts.bind_state of
        1 ->
            case TargetArt#role_arts.partner_id of
                0 ->
                    ?Ifc (NewLv > player:get_lv(PS))
                        throw(?PM_CANT_GET_EXP_BECAUSE_LV_TOP)
                    ?End;
                _Any ->
                    PartnerId = TargetArt#role_arts.partner_id,
                    Partner = lib_partner:get_partner(PartnerId),
                    ?Ifc (NewLv > lib_partner:get_lv(Partner))
                        throw(?PM_ART_BIGGER_PARTNER_LV)
                    ?End
            end;
        0 ->
            ?Ifc (NewLv > player:get_lv(PS))
                throw(?PM_CANT_GET_EXP_BECAUSE_LV_TOP)
            ?End
    end,

    {ok, TargetArt, ArtsList, AllExp}.
