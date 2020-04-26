%%%--------------------------------------
%%% @Module  : ply_relation
%%% @Author  :
%%% @Email   :
%%% @Created : 2014.04.14
%%% @Description: 玩家关系相关处理
%%%--------------------------------------


-module(ply_relation).


-export([
        db_get_relation_id_list/1,          %% 玩家关系id列表
        db_try_load_rela_info/1,            %% 尝试加载玩家的关系信息
        get_friend_id_list/1,               %% 玩家好友id列表
        get_enemy_id_list/1,                %% 玩家仇人id列表
        get_online_friend_list/1,           %% 玩家好友PS列表
        get_online_enemy_list/1,            %% 获取仇人PS列表
        get_relation_list/2,                %% 获取与玩家有某个关系的关系列表
        check_add_friend/2,
        add_friend/2,                       %% 添加好友关系
        add_friend/3,                       %% 添加仇人或者临时好友
        del_friend/2,                       %% 删除好友关系
        search_player_by_name/4,            %% 根据名字模糊查询在线玩家列表
        can_apply_count_day/1,              %% 获取当天可以申请加好友的次数
        deduct_apply_count_day/2,           %% 扣除当天已经申请加为好友的次数
        get_relation_id_between_AB/2,       %% 获取ab之间的关系id
        get_intimacy_between_AB/2,          %% 获取ab之间的好友度
        get_rela_id_list/1,                 %% 获取玩家的关系id列表
        set_rela_id_list/2,                 %% 设置玩家的关系id列表

        get_rela_info/1,
        get_sworn_id/1,                     %% 获取玩家的结拜唯一id
        get_sworn_type/1,                   %% 获取玩家的结拜类型
        get_sworn_attr_add/2,               %% 根据结拜类型与人数返回结拜属性加成 #attrs 结构体
        update_rela_info_to_ets/1,
        to_rela_info_record/2,

        has_sworn/1,                        %% 是否有结拜了
        can_sworn/2,

        give_flower/3,

        get_spouse_id/1,                    %% 获取配偶id
        get_couple_skill_id_list/1,         %% 获取夫妻技能id列表

        db_replace/2,
        db_save_relation_data/1,            %% 最终下线，保存数据到db
        db_save_all_relation_data/0,

        % del_relation_info_from_ets/1,
        notify_frds_lv_up/1,
        on_player_login/1,                  %% 玩家上线，通知其在线好友
        on_player_logout/1
    ]).


-include("relation.hrl").
-include("ets_name.hrl").
-include("abbreviate.hrl").
-include("prompt_msg_code.hrl").
-include("common.hrl").
-include_lib("stdlib/include/ms_transform.hrl").
-include("team.hrl").
-include("record.hrl").
-include("log.hrl").

-include("goods.hrl").
-include("pt_14.hrl").

%% 尝试从数据库获取玩家关系id列表 
db_get_relation_id_list(PlayerId) ->
    % List1 = get_relation_list(PlayerId, ?FRIEND),
    % List2 = get_relation_list(PlayerId, ?BLACKLIST),
    % L = List1 ++ List2,
    % [X#relation.id || X <- L].
    RelaInfoRd = get_rela_info(PlayerId),
    case RelaInfoRd#relation_info.rela_list =:= null of
        false -> skip;
        true ->
            RelaIdL1 = 
                case db:select_all(relation, ?RELA_SQL, [{idA, PlayerId}]) of
                    [] ->  % 没有数据
                        ?TRACE("[mod_relation]There are not any relation~n"),
                        [];
                    SqlRet1 when is_list(SqlRet1) ->
                        SellRecords1 = [make_relation_record(X) || X <- SqlRet1],
                        % 写入ets表中
                        gen_server:cast(?RELATION_PROCESS, {'init_rela', SellRecords1}),
                        [X#relation.id || X <- SellRecords1];
                    _ ->  % db读取出错
                        ?ASSERT(false),
                        []
                end,
            RelaIdL2 = 
                case db:select_all(relation, ?RELA_SQL, [{idB, PlayerId}]) of
                    [] ->  % 没有数据
                        ?TRACE("[mod_relation]There are not any relation~n"),
                        [];
                    SqlRet2 when is_list(SqlRet2) ->
                        SellRecords2 = [make_relation_record(X) || X <- SqlRet2],
                        % 写入ets表中
                        gen_server:cast(?RELATION_PROCESS, {'init_rela', SellRecords2}),
                        
                        [X#relation.id || X <- SellRecords2];
                    _ ->  % db读取出错
                        ?ASSERT(false),
                        []
                end,
            RelaIdL = RelaIdL1 ++ RelaIdL2,
            
            case length(RelaIdL) > ?MAX_FRIENDS of
                true -> ?ERROR_MSG("ply_relation:db_get_relation_id_list find Count error!~p ~n", [length(RelaIdL)]);
                false -> skip
            end,
            gen_server:cast(?RELATION_PROCESS, {'update_rela_list', PlayerId, RelaIdL}),
            RelaIdL
    end.


get_friend_id_list(PS) ->
    List = get_rela_id_list(player:id(PS)),
    PlayerId = player:id(PS),
    F = fun(X,Acc) ->
        case ets:lookup(?ETS_RELA, X) of
            [] ->
                % ?ASSERT(false, X),
                Acc;
            [R] ->
                case R#relation.rela =:= ?FRIEND of
                    true ->
                        case R#relation.idA =:= PlayerId of
                            true -> [R#relation.idB | Acc];
                            false ->
                                ?ASSERT(R#relation.idB =:= PlayerId, R),
                                [R#relation.idA | Acc]
                        end;
                    false -> Acc
                end
        end
    end,
    lists:foldl(F,[],List).

% 获取仇人列表
get_enemy_id_list(PS) ->
    List = get_rela_id_list(player:id(PS)),
    PlayerId = player:id(PS),
    F = fun(X,Acc) ->
        case ets:lookup(?ETS_RELA, X) of
            [] ->
                % ?ASSERT(false, X),
                Acc;
            [R] ->
                case R#relation.rela =:= ?ENEMY of
                    true ->
                        case R#relation.idA =:= PlayerId of
                            true -> [R#relation.idB | Acc];
                            false ->
                                ?ASSERT(R#relation.idB =:= PlayerId, R),
                                [R#relation.idA | Acc]
                        end;
                    false -> Acc
                end
        end
    end,
    lists:foldl(F,[],List).

get_online_friend_list(PS) ->
    List = get_rela_id_list(player:id(PS)),
    PlayerId = player:id(PS),
    F = fun(X, Acc) ->
        case ets:lookup(?ETS_RELA, X) of
            [] ->
                Acc;
            [R] ->
                case R#relation.rela of
                    ?FRIEND ->
                        case R#relation.idA =:= PlayerId of
                            true -> 
                                case player:get_PS(R#relation.idB) of
                                    null -> Acc;
                                    TPS -> [TPS | Acc]
                                end;
                            false ->
                                ?ASSERT(R#relation.idB =:= PlayerId, R),
                                case player:get_PS(R#relation.idA) of
                                    null -> Acc;
                                    TPS -> [TPS | Acc]
                                end
                        end;
                    _ -> Acc
                end
        end
    end,
    lists:foldl(F, [], List).

get_online_enemy_list(PS) ->
    List = get_rela_id_list(player:id(PS)),
    ?DEBUG_MSG("List=~p",[List]),

    % ?DEBUG_MSG("List=~p",[List]),
    PlayerId = player:id(PS),
    F = fun(X, Acc) ->
        case ets:lookup(?ETS_RELA, X) of
            [] ->
                Acc;
            [R] ->
                ?DEBUG_MSG("R=~p",[R]),
                case R#relation.rela of
                    ?ENEMY ->
                        case R#relation.idA =:= PlayerId of
                            true -> 
                                case player:get_PS(R#relation.idB) of
                                    null -> Acc;
                                    TPS -> [TPS | Acc]
                                end;
                            false ->
                                ?ASSERT(R#relation.idB =:= PlayerId, R),
                                case player:get_PS(R#relation.idA) of
                                    null -> Acc;
                                    TPS -> [TPS | Acc]
                                end
                        end;
                    _ -> Acc
                end
        end
    end,
    lists:foldl(F, [], List).

%% return [] | relation 结构体列表
get_relation_list(PlayerId, Rela) when is_integer(PlayerId) ->
    Ms =  ets:fun2ms(fun(R) when 
        (PlayerId =:= R#relation.idA orelse PlayerId =:= R#relation.idB) andalso R#relation.rela =:= Rela -> R end),
    % case Rela of
    %      ?ENEMY -> ets:fun2ms(fun(R) when PlayerId =:= R#relation.idA andalso R#relation.rela =:= Rela -> R end);
    %     _ -> ets:fun2ms(fun(R) when (PlayerId =:= R#relation.idA orelse PlayerId =:= R#relation.idB) andalso R#relation.rela =:= Rela -> R end)
    % end,
    ets:select(?ETS_RELA, Ms);

get_relation_list(PS, Rela) ->
    List = get_rela_id_list(player:id(PS)),
    F = fun(X, Acc) ->
        case ets:lookup(?ETS_RELA, X) of
            [] ->
                Acc;
            [R] ->
                case R#relation.rela =:= Rela of
                    true -> [R | Acc];
                    false -> Acc
                end
        end
    end,
    lists:foldl(F, [], List).

%% return ok | {fail, Reason}
check_add_friend(PS, ObjPS) ->
    try check_add_friend__(PS, ObjPS) of
        ok ->
            ok
    catch
        FailReason ->
            {fail, FailReason}
    end.


%% return Rid
add_friend(PlayerId, ObjId) when is_integer(PlayerId) ->
    case get_relation_id_between_AB(PlayerId, ObjId) of
        ?INVALID_ID ->
            TId = db:insert_get_id(relation, [idA, idB, rela], [PlayerId, ObjId, ?FRIEND]),
            NewId = adust_id(TId),
            ets:insert(?ETS_RELA, #relation{id = NewId, idA = PlayerId, idB = ObjId, rela = ?FRIEND}),
            add_player_rela_list(PlayerId, ObjId, NewId),
            NewId;
        RelaId ->
            case ets:lookup(?ETS_RELA, RelaId) of
                [] ->
                    ?ASSERT(false, RelaId),
                    TId = db:insert_get_id(relation, [idA, idB, rela], [PlayerId, ObjId, ?FRIEND]),
                    NewId = adust_id(TId),
                    ets:insert(?ETS_RELA, #relation{id = NewId, idA = PlayerId, idB = ObjId, rela = ?FRIEND}),
                    add_player_rela_list(PlayerId, ObjId, NewId),
                    NewId;
                [R] ->
                    R1 = R#relation{rela = ?FRIEND},
                    ets:insert(?ETS_RELA, R1),
                    db:update(?DB_SYS, relation, [{rela, ?FRIEND}], [{id, R#relation.id}]),
                    R#relation.id
            end
    end;

add_friend(PS, ObjId) ->
    case get_relation_id_between_AB(PS, ObjId) of
        ?INVALID_ID ->
            TId = db:insert_get_id(relation, [idA, idB, rela], [player:id(PS), ObjId, ?FRIEND]),
            NewId = adust_id(TId),
            ets:insert(?ETS_RELA, #relation{id = NewId, idA = player:id(PS), idB = ObjId, rela = ?FRIEND}),
            add_player_rela_list(PS, ObjId, NewId),
            NewId;
        RelaId ->
            case ets:lookup(?ETS_RELA, RelaId) of
                [] ->
                    ?ASSERT(false, RelaId),
                    TId = db:insert_get_id(relation, [idA, idB, rela], [player:id(PS), ObjId, ?FRIEND]),
                    NewId = adust_id(TId),
                    ets:insert(?ETS_RELA, #relation{id = NewId, idA = player:id(PS), idB = ObjId, rela = ?FRIEND}),
                    add_player_rela_list(PS, ObjId, NewId),
                    NewId;
                [R] ->
                    % 如果原本是仇人 则删除
                    case R#relation.rela of
                        ?ENEMY -> 
                            {ok, BinData} = pt_14:write(14003, [R#relation.id]),
                            case player:get_PS(ObjId) of
                                null -> skip;
                                FriendPS ->
                                    lib_send:send_to_sock(FriendPS, BinData)
                            end,

                            lib_send:send_to_sock(PS, BinData),
                            skip;
                        _ -> skip
                    end,

                    R1 = R#relation{rela = ?FRIEND},
                    ets:insert(?ETS_RELA, R1),
                    db:update(?DB_SYS, relation, [{rela, ?FRIEND}], [{id, R#relation.id}]),
                    R#relation.id
            end
    end.

%% 添加其他类型好友
add_friend(PS, ObjId, ?ENEMY) ->
    case get_relation_id_between_AB(PS, ObjId) of
        ?INVALID_ID ->
            TId = db:insert_get_id(relation, [idA, idB, rela], [player:id(PS), ObjId, ?ENEMY]),
            NewId = adust_id(TId),
            ets:insert(?ETS_RELA, #relation{id = NewId, idA = player:id(PS), idB = ObjId, rela = ?ENEMY}),
            add_player_rela_list(PS, ObjId, NewId),
            NewId;
        RelaId ->
            case ets:lookup(?ETS_RELA, RelaId) of
                [] ->
                    ?ASSERT(false, RelaId),
                    TId = db:insert_get_id(relation, [idA, idB, rela], [player:id(PS), ObjId, ?ENEMY]),
                    NewId = adust_id(TId),
                    ets:insert(?ETS_RELA, #relation{id = NewId, idA = player:id(PS), idB = ObjId, rela = ?ENEMY}),
                    add_player_rela_list(PS, ObjId, NewId),
                    % add_player_rela_list(player:get_PS(ObjId), player:id(PS), NewId),

                    mod_relation:notify_add_enemy(player:get_PS(ObjId), player:id(PS),NewId),
                    mod_relation:notify_add_enemy(PS,ObjId,NewId),
                    NewId;
                [R] ->
                    % ?DEBUG_MSG("R=~p",[R]),
                    case R#relation.rela of
                        ?FRIEND ->
                            Intimacy = R#relation.intimacy,

                            R1 = 
                            case Intimacy >= ?RELA_KILL_DEL_INTIMACY of
                                true ->
                                    db:update(?DB_SYS, relation, [{intimacy,Intimacy - ?RELA_KILL_DEL_INTIMACY}], [{id, R#relation.id}]),
                                    R#relation{intimacy = Intimacy - ?RELA_KILL_DEL_INTIMACY};
                                    
                                false ->
                                    db:update(?DB_SYS, relation, [{rela, ?ENEMY},{intimacy,0}], [{id, R#relation.id}]),
                                    R#relation{rela = ?ENEMY,intimacy = 0}
                            end,

                            ets:insert(?ETS_RELA, R1),
                            
                            case Intimacy >= ?RELA_KILL_DEL_INTIMACY of
                                true -> 
                                    mod_relation:notify_intimacy_change(player:get_PS(ObjId), player:id(PS), R1#relation.intimacy),
                                    mod_relation:notify_intimacy_change(PS, ObjId, R1#relation.intimacy);
                                false -> 

                                    {ok, BinData} = pt_14:write(14003, [R#relation.id]),
                                    case player:get_PS(ObjId) of
                                        null -> skip;
                                        FriendPS ->
                                            lib_send:send_to_sock(FriendPS, BinData)
                                    end,
                                    lib_send:send_to_sock(PS, BinData),
                                    
                                    mod_relation:notify_add_enemy(player:get_PS(ObjId), player:id(PS),R#relation.id),
                                    mod_relation:notify_add_enemy(PS,ObjId,R#relation.id)
                            end,
                            % write(?PT_ADD_ENEMY
                            
                            R#relation.id;
                        _ ->
                            ?INVALID_ID
                    end
            end
    end.


adust_id(TId) ->
    Id = 
        case lib_account:is_global_uni_id(TId) of 
            true -> TId; 
            false -> 
                GlobalId = lib_account:to_global_uni_id(TId),
                db:update(?DB_SYS, relation, ["id"], [GlobalId], "id", TId), 
                GlobalId
        end,
    Id.

del_friend(PS, RId) ->
    case ets:lookup(?ETS_RELA, RId) of
        [] ->
            lib_send:send_prompt_msg(PS, ?PM_RELA_NOT_BUILT_OR_IS_DEL);
        [R] ->
            case lists:member(player:id(PS), [R#relation.idA, R#relation.idB]) of
                false -> 
                    lib_send:send_prompt_msg(PS, ?PM_RELA_NOT_BUILT_OR_IS_DEL);
                true ->
                    SpouseId = ply_relation:get_spouse_id(PS),
                    case lists:member(SpouseId, [R#relation.idA, R#relation.idB]) of
                        true ->
                            lib_send:send_prompt_msg(PS, ?PM_RELA_CANT_DEL_SPOUSE);
                        false ->     
                            ets:delete(?ETS_RELA, RId),
                            db:delete(?DB_SYS, relation, [{id, RId}]),
                            FriendId =
                                case player:id(PS) =:= R#relation.idA of
                                    true -> R#relation.idB;
                                    false -> R#relation.idA
                                end,

                            {ok, BinData} = pt_14:write(14003, [RId]),
                            case player:get_PS(FriendId) of
                                null -> skip;
                                FriendPS ->
                                    lib_send:send_to_sock(FriendPS, BinData)
                            end,

                            lib_send:send_to_sock(PS, BinData),

                            del_player_rela_list(PS, FriendId, RId),
                            ok
                    end
            end
    end.

get_relation_id_between_AB(IdA, IdB) when is_integer(IdA) ->
    RelaList = get_rela_id_list(IdA),
    get_relation_id_between_AB(IdA, IdB, RelaList);

get_relation_id_between_AB(PS, IdB) ->
    RelaList = get_rela_id_list(player:id(PS)),
    get_relation_id_between_AB(player:id(PS), IdB, RelaList).


get_relation_id_between_AB(_IdA, _IdB, []) ->
    ?INVALID_ID;
get_relation_id_between_AB(IdA, IdB, [H | T]) ->
    case ets:lookup(?ETS_RELA, H) of
        [] ->
            get_relation_id_between_AB(IdA, IdB, T);
        [R] ->
            L = [R#relation.idA, R#relation.idB],
            case lists:member(IdA, L) andalso lists:member(IdB, L) of
                true -> H;
                false -> get_relation_id_between_AB(IdA, IdB, T)
            end
    end.

get_intimacy_between_AB(PlayerIdA, PlayerIdB) ->
    Rid = ply_relation:get_relation_id_between_AB(PlayerIdA, PlayerIdB),
    case Rid =:= ?INVALID_ID of
        true -> 0;
        false ->
            case ets:lookup(?ETS_RELA, Rid) of
                [] -> 0;
                [R] -> R#relation.intimacy
            end
    end.


%% return {TotalPage, PSList}
search_player_by_name(PS, Name, PageSize, PageNum) ->
    AllIdList =
        case Name =:= [] of
            true -> lib_scene:get_scene_player_ids(player:get_scene_id(PS)) -- [player:get_id(PS)];
            false -> mod_svr_mgr:get_all_online_player_ids() -- [player:get_id(PS)]
        end,

    FriendIds = get_friend_id_list(PS),

    F = fun(Id, Acc) ->
        case player:get_PS(Id) of
            null -> Acc;
            RetPS ->
                case lists:member(Id, FriendIds) of
                    true -> Acc;
                    false ->
                        case Name =:= [] of
                            true -> [RetPS | Acc];
                            false ->
                                case string:str(binary_to_list(player:get_name(RetPS)), Name) =/= 0 of
                                    true -> [RetPS | Acc];
                                    false -> Acc
                                end
                        end
                end
        end
    end,
    PSList = lists:foldl(F, [], AllIdList),

    Temp = length(PSList) div PageSize,
    TotalPage =
    case length(PSList) rem PageSize of
        0 -> Temp;
        _ -> Temp + 1
    end,

    IndexStart = (PageNum - 1) * PageSize + 1,
    IndexEnd = IndexStart + PageSize - 1,
    case IndexStart > length(PSList) orelse IndexEnd - IndexStart + 1 < 0 of
        true -> {0, []};
        false ->
            {TotalPage, lists:sublist(PSList, IndexStart, IndexEnd - IndexStart + 1)}
    end.

get_spouse_id(PlayerId) when is_integer(PlayerId) ->
    RelaInfo = get_rela_info(PlayerId),
    RelaInfo#relation_info.spouse_id;
get_spouse_id(PS) ->
    get_spouse_id(player:id(PS)).


get_couple_skill_id_list(PlayerId) ->
    RelaInfo = get_rela_info(PlayerId),
    RelaInfo#relation_info.couple_skill.


db_try_load_rela_info(PlayerId) ->
    case ets:lookup(?ETS_RELA_INFO, PlayerId) of
        [] -> gen_server:cast(?RELATION_PROCESS, {'db_try_load_rela_info', PlayerId});
        [_R] -> skip
    end.


%% 动态加载玩家自己的的关系信息
%% return relation_info 结构体
get_rela_info(PlayerId) when is_integer(PlayerId) ->
    case ets:lookup(?ETS_RELA_INFO, PlayerId) of
        [] ->
            case db:select_row(relation_info, ?RELA_INFO_SQL, [{id, PlayerId}], [], [1]) of
                [] ->
                    NewRd = #relation_info{id = PlayerId, apply_count_day = ?MAX_APPLY_DAY},
                    gen_server:cast(?RELATION_PROCESS, {'init_player_rela_info', PlayerId}),
                    NewRd;
                InfoList ->
                    NewRd = to_rela_info_record(PlayerId, InfoList),
                    gen_server:cast(?RELATION_PROCESS, {'init_player_rela_info', PlayerId, NewRd}),
                    NewRd
            end;
        [R] -> R
    end.

to_rela_info_record(PlayerId, [ApplyCountDay, LastApplyTime, OfflineMsg_BS, SwornId, FreeModifyPreCount, FreeModifySufCount, SwornSuffix, GetIntimacy, GiveIntimacy, SpouseId, CoupleSkill_BS, TimeMarry, TimeDivorce, LastDivorceForce]) ->
    OfflineMsg = case util:bitstring_to_term(OfflineMsg_BS) of undefined -> []; Info -> tuple_to_list(Info) end,
    CanCountDay = 
        if
            LastApplyTime =:= 0 -> ?MAX_APPLY_DAY;
            true ->
                case util:is_same_day(LastApplyTime) of
                    true -> ApplyCountDay;
                    false -> ?MAX_APPLY_DAY
                end
        end,

    #relation_info{
        id = PlayerId, 
        apply_count_day = CanCountDay, 
        last_apply_time = LastApplyTime, 
        offline_msg = OfflineMsg,
        sworn_id = SwornId,
        free_modify_pre_count = FreeModifyPreCount,
        free_modify_suf_count = FreeModifySufCount,
        sworn_suffix = SwornSuffix,
        get_intimacy = GetIntimacy,
        give_intimacy = GiveIntimacy,
        spouse_id = SpouseId,              %% 配偶玩家id
        couple_skill = case util:bitstring_to_term(CoupleSkill_BS) of undefined -> []; CoupleSkillL -> tuple_to_list(CoupleSkillL) end,
		time_marry = TimeMarry,
		time_divorce = TimeDivorce,
		last_divorce_force = LastDivorceForce
        }.


get_sworn_id(PlayerId) when is_integer(PlayerId) ->
    Rela = get_rela_info(PlayerId),
    Rela#relation_info.sworn_id.

get_sworn_type(PlayerId) when is_integer(PlayerId) ->
    Rela = get_rela_info(PlayerId),
    case lib_relation:get_sworn_relation(Rela#relation_info.sworn_id) of
        null -> ?RELA_SWORN_TYPE_NONE;
        Sworn -> Sworn#sworn.type
    end.

% return #attrs 结构体
get_sworn_attr_add(SwornType, MemberCount) ->
    case data_sworn_attr_add:get(SwornType) of
        null -> #attrs{};
        Data ->
            AttrNameValueL = 
                case MemberCount of
                    2 -> Data#sworn_attr_add.add_attrs_2;
                    3 -> Data#sworn_attr_add.add_attrs_3;
                    4 -> Data#sworn_attr_add.add_attrs_4;
                    _ -> []
                end,
            lib_attribute:attr_bonus(#attrs{}, AttrNameValueL)
    end.

 
has_sworn(PlayerId) ->
    Rela = get_rela_info(PlayerId),
    case Rela#relation_info.sworn_id =:= ?INVALID_ID of
        true -> false;
        false ->
            case lib_relation:get_sworn_relation(Rela#relation_info.sworn_id) of
                null ->
                    ?ERROR_MSG("ply_relation:has_sworn db data error!~n", []),
                    false;
                _ -> true
            end
    end.

can_sworn(PS, Type) ->
    try can_sworn__(PS, Type) of
        ok -> ok
    catch
        FailReason ->
            {fail, FailReason}
    end.


can_sworn__(PS, Type) ->
    ?Ifc(not player:is_leader(PS))
        throw([{player:id(PS), 6}])
    ?End,

    {MoneyType, MoneyCount} = 
        case Type of
            1 -> {?MNY_T_BIND_GAMEMONEY, 100};
            2 -> {?MNY_T_YUANBAO, 100}
        end,

    ?Ifc (not player:has_enough_money(PS, MoneyType, MoneyCount))
        throw([{player:id(PS), 5}])
    ?End,

    Team = mod_team:get_team_info(player:get_team_id(PS)),
    ?Ifc (Team =:= null)
        throw([{player:id(PS), 2}])
    ?End,

    AllMbL = mod_team:get_all_member_id_list(Team),
    MbIdL = mod_team:get_normal_member_id_list(Team),

    ?Ifc(length(MbIdL) < 2)
        throw([{player:id(PS), 8}])
    ?End,

    ?Ifc (length(AllMbL) =/= length(MbIdL))
        F0 = fun(Id, Acc) ->
            case mod_team:get_member_state(Team, player:id(PS)) =:= ?MB_STATE_IN of
                true -> Acc;
                false -> [{Id, 7} | Acc]
            end
        end,
        ReasonL = lists:foldl(F0, [], AllMbL),
        throw(ReasonL)
    ?End,

    F = fun(Id, {Sum, Acc}) ->
        case has_sworn(Id) of
            true -> {Sum + 1, [Id | Acc]};
            false -> {Sum, Acc}
        end
    end,
    {HasSwornCount, HasSwornL} = lists:foldl(F, {0, []}, MbIdL),

    F1 = fun(Id, Acc) ->
        [{Id, 1} | Acc]
    end,
    RetList = lists:foldl(F1, [], HasSwornL),

    ?Ifc (HasSwornCount > 0)
        throw(RetList)
    ?End,

    ok.

update_rela_info_to_ets(RelaInfo) when is_record(RelaInfo, relation_info) ->
    ?ASSERT(is_record(RelaInfo, relation_info), RelaInfo),
    ets:insert(?ETS_RELA_INFO, RelaInfo#relation_info{is_dirty = true}).


can_apply_count_day(PS) ->
    PlayerId = player:id(PS),
    R = get_rela_info(PlayerId),
    if
        R#relation_info.last_apply_time =:= 0 ->
            ?MAX_APPLY_DAY;
        true ->
            case util:is_same_day(R#relation_info.last_apply_time) of
                true -> R#relation_info.apply_count_day;
                false ->
                     gen_server:cast(?RELATION_PROCESS, {'update_can_apply_count', PS, ?MAX_APPLY_DAY}),
                     ?MAX_APPLY_DAY
            end
    end.


deduct_apply_count_day(PS, Count) ->
    case Count =< 0 of
        true -> skip;
        false ->
            gen_server:cast(?RELATION_PROCESS, {'update_can_apply_count', PS, Count, svr_clock:get_unixtime()})
    end.


 %% 最终下线，保存数据到db
db_save_relation_data(PlayerId) ->
    case ets:lookup(?ETS_RELA_INFO, PlayerId) of
        [] -> 
            skip;
        [R] ->
            case R#relation_info.is_dirty of
                false -> skip;
                true -> gen_server:cast(?RELATION_PROCESS, {'db_save_relation_data', PlayerId})
            end
    end.

%% 关服时保存离线聊天信息
db_save_all_relation_data() ->
    List = ets:tab2list(?ETS_RELA_INFO),
    F = fun(RelaInfo) ->
        case RelaInfo#relation_info.is_dirty of
            false -> skip;
            true -> db_replace(RelaInfo#relation_info.id, RelaInfo)
        end
    end,
    [F(X) || X <- List].

% del_relation_info_from_ets(PlayerId) ->
%     ets:delete(?ETS_RELA_INFO, PlayerId).

give_gifts(PS,PlayerId,GoodsList) ->
    case check_give_gifts(PS, PlayerId, GoodsList) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, GoodsObjCntL, ObjPS} ->
            case mod_inv:destroy_goods_by_id_WNC(player:id(PS), GoodsList, [?LOG_GOODS, "give_gifts"]) of %% 这里需要记录日志
                false ->
                    ?ERROR_MSG("give_gifts:GoodsList:~w, GoodsObjCntL:~w~n", [GoodsList, GoodsObjCntL]);
                true ->
                    gen_server:cast(?RELATION_PROCESS, {'give_gifts', PS, ObjPS, GoodsObjCntL})
            end,
            ok
    end.

check_give_gifts(PS, PlayerId, GoodsList) ->
    try check_give_gifts__(PS, PlayerId, GoodsList) of
        {ok, GoodsObjCntL, ObjPS} -> 
            {ok, GoodsObjCntL, ObjPS}
    catch
        FailReason ->
            {fail, FailReason}
    end.

check_give_gifts__(PS, PlayerId, GoodsList) ->
    ?Ifc (not lists:member(PlayerId, get_friend_id_list(PS)))
        throw(?PM_PARA_ERROR)
    ?End,

    F = fun({GoodsId, Count}, Acc) ->
        ?Ifc (Count =< 0)
            throw(?PM_PARA_ERROR)
        ?End,

        Goods = mod_inv:find_goods_by_id_from_bag(player:id(PS), GoodsId),
        ?Ifc (Goods =:= null)
            throw(?PM_GOODS_NOT_EXISTS)
        ?End,

        ?Ifc (lib_goods:get_count(Goods) < Count)
            throw(?PM_GOODS_NOT_ENOUGH)
        ?End,

        %% 判断 是否 可以赠送
        ?Ifc (not lib_goods:is_gift(Goods))
            throw(?PM_PARA_ERROR)
        ?End,

        % 判断道具是否绑定
        case lib_goods:get_bind_state(Goods) of
            ?BIND_ALREADY ->
                throw(?PM_BIND_CAN_NOT_GIFT)
        end,
        
        [{Goods, Count} | Acc]
    end,

    GoodsObjCntL = lists:foldl(F, [], GoodsList),

    ?Ifc (length(GoodsObjCntL) =/= length(GoodsList))
        throw(?PM_UNKNOWN_ERR)
    ?End,

    ObjPS = player:get_PS(PlayerId),
    ?Ifc (ObjPS =:= null)
        throw(?PM_TARGET_PLAYER_NOT_ONLINE)
    ?End,
    
    {ok, GoodsObjCntL, ObjPS}.

give_flower(PS, PlayerId, GoodsList) ->
    case check_give_flower(PS, PlayerId, GoodsList) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, GoodsObjCntL, ObjPS} ->
            case mod_inv:destroy_goods_by_id_WNC(player:id(PS), GoodsList, [?LOG_GOODS, "use"]) of %% 这里需要记录日志
                false ->
                    ?ERROR_MSG("give_flower:GoodsList:~w, GoodsObjCntL:~w~n", [GoodsList, GoodsObjCntL]);
                true ->
                    gen_server:cast(?RELATION_PROCESS, {'give_flower', PS, ObjPS, GoodsObjCntL})
            end,
            ok
    end.

check_give_flower(PS, PlayerId, GoodsList) ->
    try check_give_flower__(PS, PlayerId, GoodsList) of
        {ok, GoodsObjCntL, ObjPS} -> 
            {ok, GoodsObjCntL, ObjPS}
    catch
        FailReason ->
            {fail, FailReason}
    end.

check_give_flower__(PS, PlayerId, GoodsList) ->
    ?Ifc (not lists:member(PlayerId, get_friend_id_list(PS)))
        throw(?PM_PARA_ERROR)
    ?End,

    F = fun({GoodsId, Count}, Acc) ->
        ?Ifc (Count =< 0)
            throw(?PM_PARA_ERROR)
        ?End,

        Goods = mod_inv:find_goods_by_id_from_bag(player:id(PS), GoodsId),
        ?Ifc (Goods =:= null)
            throw(?PM_GOODS_NOT_EXISTS)
        ?End,

        ?Ifc (lib_goods:get_count(Goods) < Count)
            throw(?PM_GOODS_NOT_ENOUGH)
        ?End,

        %% 判断 是否 可以赠送
        ?Ifc (not lib_goods:can_present(Goods))
            throw(?PM_PARA_ERROR)
        ?End,
        
        [{Goods, Count} | Acc]
    end,

    GoodsObjCntL = lists:foldl(F, [], GoodsList),

    ?Ifc (length(GoodsObjCntL) =/= length(GoodsList))
        throw(?PM_UNKNOWN_ERR)
    ?End,

    ObjPS = player:get_PS(PlayerId),
    ?Ifc (ObjPS =:= null)
        throw(?PM_TARGET_PLAYER_NOT_ONLINE)
    ?End,
    
    {ok, GoodsObjCntL, ObjPS}.


on_player_login(PS) ->
    IdList = get_friend_id_list(PS),
    F = fun(Id) ->
        case player:get_PS(Id) of
            null -> skip;
            FriendPS ->
                {ok, BinData} = pt_14:write(14030, [1, player:id(PS)]),
                lib_send:send_to_sock(FriendPS, BinData)
        end
    end,
    [F(X) || X <- IdList].


on_player_logout(PS) ->
    IdList = get_friend_id_list(PS),
    F = fun(Id) ->
        case player:get_PS(Id) of
            null -> skip;
            FriendPS ->
                {ok, BinData} = pt_14:write(14030, [0, player:id(PS)]),
                lib_send:send_to_sock(FriendPS, BinData)
        end
    end,
    [F(X) || X <- IdList].


%% 获取玩家的关系id列表
get_rela_id_list(PlayerId) ->
    R = get_rela_info(PlayerId),                 
    case is_list(R#relation_info.rela_list) of
        false -> db_get_relation_id_list(PlayerId);
        true -> R#relation_info.rela_list
    end.


%% 设置玩家的关系id列表  此函数要在 mod_relation 好友进程调用
set_rela_id_list(PlayerId, List) ->
    case ets:lookup(?ETS_RELA_INFO, PlayerId) of
        [] -> % 此分支是正常的，当设置对方的好友关系时可能发生
            % ?ASSERT(false),
            % ?ERROR_MSG("ply_relation:set_rela_id_list() error!!~n", []),
            RelationInfo = get_rela_info(PlayerId),
            update_rela_info_to_ets(RelationInfo#relation_info{id = PlayerId, rela_list = List});
        [R] -> 
            update_rela_info_to_ets(R#relation_info{rela_list = List})
    end.            


%% 必须全部字段，否则会赋予默认值
db_replace(PlayerId, R) when is_record(R, relation_info) ->
    % ?DEBUG_MSG("Msg:~w~n", [R#relation_info.offline_msg]),
    F0 = fun({Id, Msg, TimeStamp}, Acc) ->
        case util:get_nth_day_from_time_to_now(TimeStamp) > ?RELA_MAX_DAY_MSG_SAVE of
            true -> Acc;
            false -> [{Id, Msg, TimeStamp} | Acc]
        end
    end,
    MsgList = lists:foldl(F0, [], R#relation_info.offline_msg),

    db:replace(PlayerId, relation_info,
        [
            {id, PlayerId}, {apply_count_day, R#relation_info.apply_count_day}, {last_apply_time, R#relation_info.last_apply_time}, 
            {offline_msg, util:term_to_bitstring(list_to_tuple(MsgList))}, {sworn_id, R#relation_info.sworn_id},
            {free_modify_pre_count, R#relation_info.free_modify_pre_count}, {free_modify_suf_count, R#relation_info.free_modify_suf_count},
            {sworn_suffix, R#relation_info.sworn_suffix}, {get_intimacy, R#relation_info.get_intimacy}, {give_intimacy, R#relation_info.give_intimacy},
            {spouse_id, R#relation_info.spouse_id}, {couple_skill, util:term_to_bitstring(list_to_tuple(R#relation_info.couple_skill))},
			{time_marry, R#relation_info.time_marry}, {time_divorce, R#relation_info.time_divorce},
			{last_divorce_force, R#relation_info.last_divorce_force}
        ]).


notify_frds_lv_up(PS) ->
    FrdsIdL = get_friend_id_list(PS),
    {ok, BinData} = pt_14:write(14036, [player:id(PS), player:get_lv(PS)]),
    spawn(fun() -> notify_frds_lv_up(FrdsIdL, BinData) end).

notify_frds_lv_up(FrdsIdL, BinData) ->
    F = fun(Id) ->
        case player:get_PS(Id) of
            null ->
                skip;
            PS ->
                lib_send:send_to_sock(PS, BinData)
        end
    end,
    [F(X) || X <- FrdsIdL].


%% ------------------------------------------Local FUN------------------------------

check_add_friend__(PS, ObjPS) ->
    ObjId = player:id(ObjPS),
    ?Ifc (player:id(PS) =:= ObjId)
        throw(?PM_RELA_CANT_ADD_YOURSELF)
    ?End,

    FriendIds = get_friend_id_list(PS),
    ?Ifc (length(FriendIds) >= ?MAX_FRIENDS)
        throw(?PM_RELA_FRIEND_COUNT_LIMIT)
    ?End,

    % EnemyIds = get_enemy_id_list(PS),
    % ?Ifc (lists:member(ObjId, EnemyIds))
    %     throw(?PM_RELA_OBJ_IS_YOUR_ENEMY)
    % ?End,

    ?Ifc (lists:member(ObjId, FriendIds))
        throw(?PM_RELA_OBJ_IS_YOUR_FRIEND)
    ?End,

    ?Ifc (not player:is_online(ObjId))
        throw(?PM_TARGET_PLAYER_NOT_ONLINE)
    ?End,

    ?Ifc (player:is_offline_guaji(ObjPS))
        throw(?PM_PLAYER_STATE_OFFLINE_GUAJI)
    ?End,

    ?Ifc (not ply_setting:accept_friend_invite(ObjId))
        throw(?PM_RELA_OBJ_REFUSE)
    ?End,

    ObjFriendIds = get_friend_id_list(ObjPS),
    ?Ifc (length(ObjFriendIds) >= ?MAX_FRIENDS)
        throw(?PM_OBJ_RELA_FRIEND_COUNT_LIMIT)
    ?End,
    ok.


% add_player_rela_list(PS, ObjId, NewId) ->
%     case player:get_PS(ObjId) of
%         null ->
%             case ply_tmplogout_cache:get_tmplogout_PS(ObjId) of
%                 null -> null;
%                 ObjPS -> 
%                     ply_tmplogout_cache:set_rela_list(ObjPS, [NewId | player:get_rela_list(ObjPS)])
%             end;
%         ObjPS -> player_syn:set_rela_list(ObjPS, [NewId | player:get_rela_list(ObjPS)])
%     end,
%     player_syn:set_rela_list(PS, [NewId | player:get_rela_list(PS)]).

add_player_rela_list(PlayerId, ObjId, NewId) when is_integer(PlayerId) ->
    set_rela_id_list(ObjId, [NewId | get_rela_id_list(ObjId)]),
    set_rela_id_list(PlayerId, [NewId | get_rela_id_list(PlayerId)]);

add_player_rela_list(PS, ObjId, NewId) ->
    set_rela_id_list(ObjId, [NewId | get_rela_id_list(ObjId)]),
    set_rela_id_list(player:id(PS), [NewId | get_rela_id_list(player:id(PS))]).


% del_player_rela_list(PS, ObjId, RelaId) ->
%     case player:get_PS(ObjId) of
%         null ->
%             case ply_tmplogout_cache:get_tmplogout_PS(ObjId) of
%                 null -> null;
%                 ObjPS -> ply_tmplogout_cache:set_rela_list(ObjPS, player:get_rela_list(ObjPS) -- [RelaId])
%             end;
%         ObjPS -> player_syn:set_rela_list(ObjPS, player:get_rela_list(ObjPS) -- [RelaId])
%     end,
%     player_syn:set_rela_list(PS, player:get_rela_list(PS) -- [RelaId]).


del_player_rela_list(PS, ObjId, RelaId) ->
    set_rela_id_list(ObjId, get_rela_id_list(ObjId) -- [RelaId]),
    set_rela_id_list(player:id(PS), get_rela_id_list(player:id(PS)) -- [RelaId]).



make_relation_record([Id, IdA, IdB, Rela, IntimacyBT, Intimacy]) ->
    #relation{
        id = adust_id(Id),
        idA = IdA,
        idB = IdB,
        rela = Rela,
        intimacy_bt = IntimacyBT,
        intimacy = Intimacy
    }.