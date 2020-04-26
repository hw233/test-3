%%%-------------------------------------------------------------------
%%% @author lizhipeng
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. 七月 2018 19:38
%%%-------------------------------------------------------------------
-module(lib_train).

-include("train.hrl").
-include("ets_name.hrl").
-include("common.hrl").
-include("protocol/pt_39.hrl").
-include("prompt_msg_code.hrl").
-include("obj_info_code.hrl").
-include("record.hrl").
-include("partner.hrl").
-include("player.hrl").

%% API
-export([
    get_art_lv/1,
    del_role_arts/1,
    put_artno_in_dict/1,
    del_artno_in_dict/1,
    update_role_arts/1,
    generate_sole_art_id/1,
    get_arts_by_partner_id/1,
    get_arts_by_ply/0,
    attr_bonus/1,
    attr_bonus/0,
    attr_bonus_by_data/1,
    attr_bonus_by_data/0,
    db_delete_arts/1,
    login_init/1,
    login_init_server/2,
    login_init_server_by_data/2,
    login_update_art_data/1,
    final_logout/1,
    get_art_by_id/1,
    get_arts_by_role/0,
    get_unequipped_arts_by_role/0,
    get_isequipped_arts_by_role/0,
    has_art/1,
    set_attr/1,
    set_attr/3,
    get_attr/1,
    get_lv/1,
    get_exp/1,
    get_exp_lim/1,
    get_exp_lim/2,
    get_eat_exp/1,
    get_star/1,
    get_dict_arts/0,
    get_art_slot_by_lv/1,
    add_exp_to_target_art/3,
    change_lv_by_exp/4,
    set_art_slot/3,
    get_linshi_arts/0,
    get_art_slot/2,
is_ply_open/2,
    get_no_by_id/1
]).

%% @doc 初始化
login_init(RoleId) ->
%% 把玩家的内功编号放进进程字典
%%                ArtsId_List = db:select_all(arts, "id", [{player_id, RoleId}]),
%%                put(arts, ArtsId_List),
    case db:select_all(arts, "id, art_no, partner_id, bind_state, star, lv, exp, attr_add,position",
        [{player_id, RoleId}]) of
        [] ->
            ArtsId_List = [];
        RoleArtsList ->
            F = fun([Id, ArtNo, PartnerId, BindState, Star, Lv, Exp, AttrAdd_BS,Index], AccArtsId) ->
                AttrAdd = util:bitstring_to_term(AttrAdd_BS),
                update_role_arts(
                    #role_arts{
                        id = Id
                        , art_no = ArtNo
                        , player_id = RoleId
                        , partner_id = PartnerId
                        , bind_state = BindState
                        , star = Star
                        , lv = Lv
                        , exp = Exp
                        , attr_add = AttrAdd
                        , pos = Index
                    }),
                [Id | AccArtsId]
                end,
            ArtsId_List = lists:foldl(F, [], RoleArtsList)
    end,
    put(arts, ArtsId_List).

%% 对于错误内功配置处理(停服处理)
login_update_art_data(_RoleId) -> skip.
%%    case db:select_all(arts, "id, art_no, star, lv",
%%        [{player_id, RoleId}]) of
%%        [] ->
%%            skip;
%%        RoleArtsList ->
%%            F = fun([Id, ArtNo, Star, Lv]) ->
%%                    case ArtNo of
%%                        100020 ->
%%                            NewAttr = set_attr(100021, Lv, Star),
%%                            NewAttr_BS = util:term_to_bitstring(NewAttr),
%%                            db:update(Id, arts, [{art_no, 100021}, {bind_state, 0}, {partner_id, 0}, {attr_add, NewAttr_BS}], [{id, Id}]);
%%                        100022 ->
%%                            NewAttr = set_attr(100023, Lv, Star),
%%                            NewAttr_BS = util:term_to_bitstring(NewAttr),
%%                            db:update(Id, arts, [{art_no, 100023}, {bind_state, 0}, {partner_id, 0}, {attr_add, NewAttr_BS}], [{id, Id}]);
%%                        _ ->
%%                            skip
%%                    end
%%                end,
%%            lists:foreach(F, RoleArtsList)
%%    end.

%% 解决玩家进程字典在初始化没有数据，导致mod_login 调用recount_equip_add_and_total_attrs计算门客
%% attrs计算内功的attrs加成
login_init_server(RoleId, PartnerId) ->
    case db:select_all(arts, "partner_id, bind_state, attr_add",
        [{player_id, RoleId}]) of
        [] ->
            [];
        RoleArtsList ->
            F = fun([PartnerId_DB, BindState,AttrAdd_BS], AttrList) ->
                case (PartnerId_DB =:= PartnerId) andalso (BindState =:= 1) of
                    true ->
                        AttrAdd = util:bitstring_to_term(AttrAdd_BS),
                        ?DEBUG_MSG("------------------login_init_server-----------------~p~n", [AttrAdd]),
                        AttrList ++ AttrAdd;
                    false ->
                        AttrList
                end
            end,
            lists:foldl(F, [], RoleArtsList)
    end.

%% 直接读策划表-------策划表修改数据后不影响代码
login_init_server_by_data(RoleId, PartnerId) ->
    case db:select_all(arts, "art_no, partner_id, bind_state, star, lv",
        [{player_id, RoleId}]) of
        [] ->
            [];
        RoleArtsList ->
            F = fun([ArtNo, PartnerId_DB, BindState, Star, Lv], AttrList) ->
                case (PartnerId_DB =:= PartnerId) andalso (BindState =:= 1) of
                    true ->
                        AttrAdd = lib_train:set_attr(ArtNo, Lv, Star),
                        ?DEBUG_MSG("------------------login_init_server-----------------~p~n", [AttrAdd]),
                        AttrList ++ AttrAdd;
                    false ->
                        AttrList
                end
        end,
            lists:foldl(F, [], RoleArtsList)
    end.


final_logout(Status) ->
    case player:get_lv(Status) >= 40 of
        false -> skip;
        true ->
            ArtsIdLists = get(arts),
            lists:foreach(
                fun(ArtsId) ->
                    case get_art_by_id(ArtsId) of
                        RoleArts when is_record(RoleArts, role_arts) ->
                            del_role_arts(RoleArts),
                            db_update_role_arts(RoleArts);
                        _ -> skip
                    end
                end, ArtsIdLists)
    end.

get_no_by_id(ArtId) ->
    case get_art_by_id(ArtId) of
        #role_arts{art_no = No} ->
            No;
        _ ->
            0
    end.

%% @doc 功法从临时背包捡到正式背包
get_art_slot(IdList, PS) ->
    LinshiBag = get_linshi_arts(),
    case mod_train:bag_limit() - length(get_unequipped_arts_by_role()) of
        Num when Num > 0 ->
            {NewIds, _} = lists:foldl(
                fun (_ArtId, {Acc, 0}) -> {Acc,0};
                    (ArtId, {Acc, Res}) ->
                        case get_art_by_id(ArtId) of
                            #role_arts{}  ->
                                case lists:member(ArtId, LinshiBag) of
                                    true ->
                                        {[ArtId|Acc],Res-1};
                                    false ->
                                        {Acc, Res}
                                end;
                            _ ->
                                {Acc, Res}
                        end
                end, {[], Num}, IdList
            ),
            M = ply_misc:get_player_misc(),
            ply_misc:update_player_misc(M#player_misc{liangong_bag = M#player_misc.liangong_bag -- NewIds}),
            {ok, BinData} = pt_39:write(?PT_GET_ART_SLOT, [NewIds]),
            lib_send:send_to_sock(PS, BinData);
        _ ->
            lib_send:send_prompt_msg(PS, ?PM_ART_NUM_FULL)
    end.

%% get(arts)的判断，游戏加载进入时候会初始化内功系统(>=50)，对于新创建的账号，要进行get(arts)检查
get_dict_arts() ->
    case get(arts) of
        ?undefined ->
            [];
        L ->
            L
    end.

%% @doc 获取临时背包上的功法唯一ID列表
get_linshi_arts() ->
    M = ply_misc:get_player_misc(),
    M#player_misc.liangong_bag.

update_role_arts(RoleArt) when is_record(RoleArt, role_arts) ->
    ets:insert(?ETS_ROLE_ARTS, RoleArt).

get_art_by_id(ArtId) ->
    case ets:lookup(?ETS_ROLE_ARTS, ArtId) of
        [Art | _] when is_record(Art, role_arts) ->
            Art;
        _ -> null
    end.

%% 获取玩家内功详细信息(注意数据库检索出来的是[ArtId]模式)
get_arts_by_role() ->
    RoleArtsId = get_dict_arts(),
    F = fun(ArtId, ArtsAcc) ->
        case get_art_by_id(ArtId) of
            RoleArt when is_record(RoleArt, role_arts) ->
                [RoleArt | ArtsAcc];
            _ ->
                ArtsAcc
        end
        end,
    RoleArts = lists:foldl(F, [], RoleArtsId),
    RoleArts.

%% 获得玩家未佩戴的内功
get_unequipped_arts_by_role() ->
    ArtsList = get_arts_by_role(),                                  %% 玩家拥有的内功
    Misc = ply_misc:get_player_misc(get(?PDKN_PLAYER_ID)),
    [X || X<-ArtsList, X#role_arts.bind_state =:= 0, lists:member(X#role_arts.id,Misc#player_misc.liangong_bag) /= true].               %% 未佩戴的内功

get_isequipped_arts_by_role() ->
    ArtsList = get_arts_by_role(),%% 玩家拥有的内功
    [X || X<-ArtsList, X#role_arts.bind_state =:= 1].               %% 已佩戴的内功

is_ply_open(Index, PS) ->
    #train_open_cfg{need_lv = NeedLv} = data_train_open:get(Index),
    player:get_lv(PS) >= NeedLv.

%% 根据等级判断内功开放格子数(对应配置表)
get_art_slot_by_lv(Lv) ->

    [Lv1, Lv2, Lv3, Lv4, Lv5, Lv6, Lv7, Lv8] = data_train_open:get_need_lv(),
    if
        Lv < Lv1 -> 0;
        Lv1=<Lv andalso Lv<Lv2 -> 1;
        Lv2=<Lv andalso Lv<Lv3 -> 2;
        Lv3=<Lv andalso Lv<Lv4 -> 3;
        Lv4=<Lv andalso Lv<Lv5 -> 4;
        Lv5=<Lv andalso Lv<Lv6 -> 5;
        Lv6=<Lv andalso Lv<Lv7 -> 6;
        Lv7=<Lv andalso Lv<Lv8 -> 7;
        Lv >= Lv8 -> 8
    end.

set_art_slot(Partner,PlayerId,Lv) ->
    ArtData = data_train_open:get(Lv),
    NeedCost = ArtData#train_open_cfg.cost,
    ?ASSERT(lib_partner:get_lv(Partner) >= ArtData#train_open_cfg.need_lv, [ArtData#train_open_cfg.need_lv, lib_partner:get_lv(Partner)]),
    case lists:member(Lv, Partner#partner.art_slot) of
        false ->
            case mod_inv:check_batch_destroy_goods(PlayerId, NeedCost)  of
                ok ->
                    mod_inv:destroy_goods_WNC(PlayerId, NeedCost, ["lib_train", "set_art_slot"]),
					Partner2 = lib_partner:set_arts(Partner, [Lv|Partner#partner.art_slot]),
                    mod_partner:update_partner_to_ets(Partner2),
                    {ok, BinData} = pt_39:write(?PT_UNLOCK_ART_SLOT, [Partner2#partner.id, Lv]),
                    lib_send:send_to_sock(player:get_PS(PlayerId), BinData);
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PlayerId, Reason)
            end;
        true ->
            lib_send:send_prompt_msg(PlayerId, ?PM_ART_NOT_REPEAT)
    end.

%% @doc 获取功法可装备最大数量
get_max_slot_num() ->
    L = data_train_open:get_need_lv(),
    length(L).


%% 获取玩家自己佩戴的内功
get_arts_by_ply() ->
    L = get_arts_by_role(),
    [X || X <- L, X#role_arts.bind_state =:= ?ISEQUIPED, X#role_arts.partner_id =:= ?ISPLAYER].


%% 根据PartnerId获取门客已佩戴的内功
get_arts_by_partner_id(PartnerId) ->
    L = get_arts_by_role(),
    [X || X <- L, X#role_arts.bind_state =:= ?ISEQUIPED, X#role_arts.partner_id =:= PartnerId].

%% 计算玩家自己佩戴内功增加的属性列表
attr_bonus() ->
    IsEquipArts = get_arts_by_ply(),
    F = fun(Art, AttrsAcc) ->
        AttrsAcc ++ Art#role_arts.attr_add
        end,
    Attr = lists:foldl(F, [], IsEquipArts),
	?DEBUG_MSG("playerliangong:~p",[Attr]),
    Attr.

%% 计算玩家自己佩戴内功增加的属性列表(直接从配置表读取)----方便策划配置表修改
attr_bonus_by_data() ->
    IsEquipArts = get_arts_by_ply(),

    get_arts_attr(IsEquipArts, []).

get_arts_attr([], Attrs) -> Attrs;
get_arts_attr([Art|Arts], Attrs) ->
    get_arts_attr(Arts, Attrs ++ set_attr(Art#role_arts.art_no, Art#role_arts.lv, Art#role_arts.star)).


%% 计算门客佩戴内功增加的属性列表
attr_bonus(PartnerId) ->
    IsEquipArts = get_arts_by_partner_id(PartnerId),
    F = fun(Art, AttrsAcc) ->
        AttrsAcc ++ Art#role_arts.attr_add
        end,
    Attr = lists:foldl(F, [], IsEquipArts),
	?DEBUG_MSG("liangong:~p id:~p",[Attr,PartnerId]),
    Attr.

%% 计算门客佩戴内功增加的属性列表(直接从配置表读取)----方便策划配置表修改
attr_bonus_by_data(PartnerId) ->
    IsEquipArts = get_arts_by_partner_id(PartnerId),
    get_arts_attr(IsEquipArts, []).

%% 把产出的内功放到进程字典(注意数据库检索出来的是[ArtId]模式)
put_artno_in_dict(ArtId) ->
    L = get_dict_arts(),
    L2 = [ArtId | L],
    erlang:put(arts,L2).

%% 从进程字典删除某个内功
del_artno_in_dict(ArtId) ->
    L = get_dict_arts(),
    L2 = lists:delete(ArtId, L),
    erlang:put(arts, L2).

%% @doc 从ets表删除内功信息
del_role_arts(RoleArts) ->
    ets:delete(?ETS_ROLE_ARTS, RoleArts#role_arts.id).

%% @doc 从数据库表删除内功信息
db_delete_arts(RoleArts) when is_record(RoleArts, role_arts)->
    db:delete(RoleArts#role_arts.id, arts, [{id, RoleArts#role_arts.id}]).

db_update_role_arts(RoleArt) when is_record(RoleArt, role_arts) ->
    AttrAdd_BS = util:term_to_bitstring(RoleArt#role_arts.attr_add),
    db:update(arts,
        [
            {id, RoleArt#role_arts.id},
            {art_no, RoleArt#role_arts.art_no},
            {player_id, RoleArt#role_arts.player_id},
            {partner_id, RoleArt#role_arts.partner_id},
            {bind_state, RoleArt#role_arts.bind_state},
            {star, RoleArt#role_arts.star},
            {lv, RoleArt#role_arts.lv},
            {exp, RoleArt#role_arts.exp},
            {attr_add, AttrAdd_BS}
        ],
        [{id, RoleArt#role_arts.id}]).

get_art_lv(RoleArt) ->
    RoleArt#role_arts.lv.

%%get_art(ArtId) ->
%%    case ets:lookup(?ETS_ROLE_ARTS, ArtId) of
%%        [] -> null;
%%        [RoleArt] -> RoleArt
%%    end.

has_art(ArtsId) ->
    lists:member(ArtsId, get_dict_arts()).

set_exp(Art, Exp) when is_record(Art, role_arts) ->
    Art#role_arts{exp = Exp}.

set_lv(Art, Lv) when is_record(Art, role_arts) ->
    Art#role_arts{lv = Lv}.

set_attr_add(Art, AttrAdd) when is_record(Art, role_arts) ->
    Art#role_arts{attr_add = AttrAdd}.


%% 计算出加成属性值，形如{hp_lim, 增加值, 增加率}，以便直接调用lib_attribute:attr_bonus(Attrs, Bonus)
%% Bonus为{属性类型名, 增加值, 增加率}的列表 | {属性类型名, 增加值} 列表
set_attr(ArtId)  ->
    case get_art_by_id(ArtId) of
        null ->
            skip;
        Art ->
            set_attr(Art#role_arts.art_no, Art#role_arts.lv, Art#role_arts.star)
    end.

set_attr(ArtNo, Lv, Star) ->
    case (data_internal_skill:get(ArtNo))#internal_skill_cfg.internal_skill_type of
        [] ->
            [];                     %% 可能会产生无用内功(现在没用)
        [{AttrType, Absolute, Relative}] ->
            Coef = (data_internal_skill:get(ArtNo))#internal_skill_cfg.lv_coef
                        +
                    (data_internal_skill_attribute:get(Lv))#internal_skill_attribute_cfg.internal_correct,
            [?IF(Absolute /= 0, {AttrType, Absolute*Coef, Relative}, {AttrType, Absolute, Relative*Coef})]
    end.

get_lv(Art) ->
    Art#role_arts.lv.

get_star(Art) ->
    Art#role_arts.star.

get_exp(Art) ->
    Art#role_arts.exp.

get_attr(Art) ->
    Art#role_arts.attr_add.

%% 生成唯一内功id
generate_sole_art_id(Id) ->
    case lib_account:is_global_uni_id(Id) of
        true -> Id;
        false ->
            GlobalId = lib_account:to_global_uni_id(Id),
            db:update(arts, ["id"], [GlobalId], "id", Id),
            GlobalId
    end.


%% %% 获取内功对应等级经验上限（读配置表）
get_exp_lim(Lv) ->
    case Lv =:= 0 of
        true -> 0;
        false ->                %% 读取配置表
            data_internal_skill_upg_cost:get(Lv)
    end.

get_exp_lim(Lv, Star) ->
    case Lv =:= 0 of
        true -> 0;
        false ->                %% 读取配置表
            ArtUpgCostCfg = data_internal_skill_upg_cost:get(Lv),
            case Star of
                ?ONE_STAR ->
                    ArtUpgCostCfg#internal_skill_upg_cost_cfg.star_1_exp;
                ?TWO_STAR ->
                    ArtUpgCostCfg#internal_skill_upg_cost_cfg.star_2_exp;
                ?THREE_STAR ->
                    ArtUpgCostCfg#internal_skill_upg_cost_cfg.star_3_exp;
                ?FOUR_STAR ->
                    ArtUpgCostCfg#internal_skill_upg_cost_cfg.star_4_exp;
                ?FIVE_STAR ->
                    ArtUpgCostCfg#internal_skill_upg_cost_cfg.star_5_exp;
                ?SIX_STAR ->
                    ArtUpgCostCfg#internal_skill_upg_cost_cfg.star_6_exp;
                _ ->
                    0
            end
    end.

get_eat_exp(Art) ->
    ExpL = data_special_config:get('gongfa_exp'),
    StarExp =
        case lists:keyfind(get_star(Art), 1, ExpL) of
            {_, Exp} -> Exp;
            _ ->
                ?ASSERT(false, get_star(Art)),
                0
        end,
    Exp2 = trunc(get_exp(Art) * data_special_config:get('gongfa_tunshi')),
    StarExp + Exp2.

%% 根据内功获得的经验来改变内功等级
%% @return: {升级后的等级, 剩余经验}
change_lv_by_exp(PS, Lv, Star, Exp) ->
    PlayerLv = player:get_lv(PS),
    NotIsMax = Lv =< 100,
    ExpLim = lib_train:get_exp_lim(Lv, Star),
    case NotIsMax of
        true ->
            case Exp < ExpLim of
                true ->
                    {Lv, Exp};
                _ ->
                    change_lv_by_exp(PS, Lv + 1, Star, Exp - ExpLim)
            end;
        false ->
            {Lv, Exp}
    end.

%% 计算内功获得的经验(通过吞噬其他内功)
add_exp_to_target_art(TargetArt, TotalExp, PS) ->
%%    ?WARNING_MSG("Art=~p~n",[TargetArt]),
%%    ?WARNING_MSG("TotalExp=~p~n",[TotalExp]),
    case lib_train:get_lv(TargetArt) > 100 of
        true ->
            case lib_train:get_lv(TargetArt) > 100 of
                true ->
                    lib_send:send_prompt_msg(PS, ?PROMPT_MSG_TYPE_TIPS, ?PM_ART_LV_MAX_LIMIT);
                false ->
                    lib_send:send_prompt_msg(PS, ?PROMPT_MSG_TYPE_TIPS, ?PM_CANT_GET_EXP_BECAUSE_LV_TOP)
            end;
        false ->
           
            CurLv = get_lv(TargetArt),
            Star = get_star(TargetArt),
            NewArt = set_exp(TargetArt, get_exp(TargetArt)+TotalExp),
            mod_achievement:notify_achi(stren_neigong,  [[{neigong_lv, get_lv(NewArt) }, {num, 1}]], PS),
            ExpLim = get_exp_lim(CurLv, Star),
%%            ?WARNING_MSG("get_exp(NewArt)=~p, ExpLim=~p~n",[get_exp(NewArt),ExpLim]),
            case get_exp(NewArt) < ExpLim of
                true ->     %% 没升级
                    %% 更新到ets表
                    update_role_arts(NewArt),
                    %% 更新数据库
                    db_update_role_arts(NewArt),
                    %% 通知客户端内功属性已更新
%%                    ?WARNING_MSG("  ========1======~p~n",[{?OI_CODE_ART_EXP, get_exp(NewArt)}]),
                    notify_cli_info_change(NewArt, [{?OI_CODE_ART_EXP, get_exp(NewArt)}]),
                    {ok, NewArt};
                false ->        %% 升级
                    {ForecastLv, LeftExp} = change_lv_by_exp(PS, get_lv(NewArt), get_star(NewArt), get_exp(NewArt)),
                    NewLv = min(ForecastLv, player:get_player_max_lv(PS)),
                    NewCurExp =
                        case NewLv >= player:get_lv(PS) of
                            false -> LeftExp;
                            true -> 0           %% 开放新等级时，保证起跑线同步
                        end,
%%                    ?WARNING_MSG("ForecastLv=~p, LeftExp=~p~n",[ForecastLv,LeftExp]),
%%                    ?WARNING_MSG("NewLv=~p, player:get_player_max_lv(PS)=~p~n",[NewLv,player:get_player_max_lv(PS)]),
                    %%  根据配置表计算升级之后的内功属性变化
                    AttrAdd = set_attr(TargetArt#role_arts.art_no, NewLv, TargetArt#role_arts.star),
                    ?DEBUG_MSG("-----------------AttrAdd--------------------~p~n", [AttrAdd]),
                    %% 更新
                    NewArt1 = set_exp(NewArt, NewCurExp),
                    NewArt2 = set_lv(NewArt1, NewLv),
                    NewArt3 = set_attr_add(NewArt2, AttrAdd),
                    update_role_arts(NewArt3),
                    db_update_role_arts(NewArt3),
                    %% 重新计算玩家战斗力
                    ply_attr:recount_all_attrs(PS),
                    case NewArt3#role_arts.partner_id =/= 0 of
                        true ->
                            lib_partner:reset_art_total_attrs(PS, NewArt3#role_arts.partner_id);
                        false ->
                            skip
                    end,
                    %% 通知客户端内功属性已更新
                    KV_TupleList = [{?OI_CODE_ART_LV, get_lv(NewArt3)}, {?OI_CODE_ART_EXP, get_exp(NewArt3)}],
                    notify_cli_info_change(NewArt3, KV_TupleList)
            end
    end.

%% 吞噬内功后，如果内功不升级，则会调用该方法通知客户端
%% 通知客户端：内功经验发生改变
notify_cli_info_change(Art, KV_TupleList) when is_record(Art, role_arts) ->
    ?ASSERT(util:is_tuple_list(KV_TupleList)),
    case player:get_PS(Art#role_arts.player_id) of
        null -> skip;
        PS ->
            {ok, BinData} = pt_39:write(?PT_NOTIFY_ARTS_INFO_CHANGE, [Art#role_arts.id, KV_TupleList]),
            lib_send:send_to_sock(PS, BinData)
    end.

