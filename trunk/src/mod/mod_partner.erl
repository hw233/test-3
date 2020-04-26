%%%-------------------------------------- 
%%% @Module: mod_partner
%%% @Author: huangjf
%%% @Created: 2013.6.6
%%% @Modify:  zhangwq 2013.10.23
%%% @Description: 宠物系统
%%%--------------------------------------

-module(mod_partner).
-export([
			update_partner_to_ets/1,
			add_partner_to_ets/1,
			del_partner_from_ets/1,
		  
            get_find_par_from_ets/1,
            add_find_par_to_ets/1,
            update_find_par_to_ets/1,
            del_find_par_from_ets/1,

            get_main_partner_obj/1,
            get_main_partner_id/1,
            find_main_partner_id/1,
            find_follow_partner_id/1,
            get_main_partner_no/1,
			get_partner_no_list/1,                       % 获取玩家携带的宠物编号列表(不重复)
            get_fighting_partner_list/1,                 % 获取玩家的参战宠物对象列表
            get_fighting_partner_count/1,                % 获取玩家的参战宠物的数量
get_all_partner_id_by_battle_power/1,

			db_insert_partner/1,			             % 新生成宠物插入数据库
            db_insert_partner_hotel/1,                   % 新生成宠物插入数据库
            db_delete_partner/2,
    db_delete_partner_hotel/2,
    db_save_partner_hotel/1,
    db_save_partner/1 ,				             % 保存宠物全部数据到数据库
    manage_parter_order/2
]).


-include("record.hrl"). 
-include("partner.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("pt_17.hrl").
	
update_partner_to_ets(Partner) when is_record(Partner, partner) ->
    % ?DEBUG_MSG("add_par = ~p",[Partner]),
	ets:insert(?ETS_PARTNER, Partner#partner{is_dirty = true});
update_partner_to_ets(_) -> skip.


add_partner_to_ets(Partner) when is_record(Partner, partner) ->
	ets:insert(?ETS_PARTNER, Partner).
	

del_partner_from_ets(PartnerId) ->
	ets:delete(?ETS_PARTNER, PartnerId).

del_find_par_from_ets(PlayerId) ->
    ets:delete(?ETS_FIND_PAR, PlayerId).
    
    
get_find_par_from_ets(PlayerId) ->
    case ets:lookup(?ETS_FIND_PAR, PlayerId) of
        [] -> 
            null;
        [R] ->
            R
    end.

add_find_par_to_ets(FindPar) when is_record(FindPar, find_par) ->
    ets:insert(?ETS_FIND_PAR, FindPar).

update_find_par_to_ets(FindPar) when is_record(FindPar, find_par) ->
    ets:insert(?ETS_FIND_PAR, FindPar#find_par{is_dirty = true}).

%% 获取玩家的主宠对象
%% @return: null | partner结构体
get_main_partner_obj(PS_or_PlayerId) ->
    case get_main_partner_id(PS_or_PlayerId) of
        ?INVALID_ID ->
            null;
        MainParId ->
            lib_partner:get_partner(MainParId)
    end.
    

%% 获取玩家的主宠id，如果没有主宠，则返回?INVALID_ID
get_main_partner_id(PlayerId) when is_integer(PlayerId) ->
    case player:get_PS(PlayerId) of
        null ->
            ?INVALID_ID;
        PS ->
            get_main_partner_id(PS)
    end;
get_main_partner_id(PS) when is_record(PS, player_status) ->
    player:get_main_partner_id(PS).

find_main_partner_id([]) ->
    ?INVALID_ID;
find_main_partner_id([ParId | T]) ->
    ParObj = lib_partner:get_partner(ParId),
    ?ASSERT(ParObj /= null, ParId),
    case lib_partner:is_main_partner(ParObj) of
        true ->
            ParId;
        false ->
            find_main_partner_id(T)
    end.


find_follow_partner_id([]) ->
    ?INVALID_ID;
find_follow_partner_id([ParId | T]) ->
    ParObj = lib_partner:get_partner(ParId),
    ?ASSERT(ParObj /= null, ParId),
    case lib_partner:is_follow_partner(ParObj) of
        true ->
            ParId;
        false ->
            find_follow_partner_id(T)
    end.
    

%% 获取玩家的主宠编号，如果没有主宠，则返回?INVALID_NO
get_main_partner_no(PS_Or_PlayerId) ->
    case get_main_partner_obj(PS_Or_PlayerId) of
        null ->
            ?INVALID_NO;
        MainParObj ->
            lib_partner:get_no(MainParObj)
    end.


%% 获取玩家的参战宠物对象列表
%% @return: [] | partner结构体列表
get_fighting_partner_list(PS) ->
    ?ASSERT(is_record(PS, player_status), PS),
    F = fun(X, AccList) ->
            case lib_partner:get_partner(X) of
                null ->
                    AccList;
                ParObj ->
                    case lib_partner:is_fighting(ParObj) of
                        true ->
                            AccList ++ [ParObj];
                        false ->
                            AccList
                    end
            end     
        end,
    ParIdList = player:get_partner_id_list(PS),
    lists:foldl(F, [], ParIdList).

%% 获取玩家的所有门客的根据战力降序Id
%% @return: [] | partner结构体列表
get_all_partner_id_by_battle_power(PlayerId) ->
    F = fun(X,Acc) ->
        case lib_partner:get_partner(X) of
            null ->
                Acc;
            ParObj ->
                Acc ++ [{ParObj#partner.battle_power, ParObj#partner.id}]
        end
        end,
    ParIdList = player:get_partner_id_list(player:get_PS(PlayerId)),
    ParIdList2 = lists:foldl(F, [], ParIdList),
    SortFun = fun({IndexA,_},{IndexB,_}) ->
        IndexA < IndexB
              end,
    NewIndexPartList = lists:sort(SortFun,ParIdList2),
    GetIndexParFun = fun({_,IndexPartnerId},IndexPartnerAcc) ->
        [IndexPartnerId|IndexPartnerAcc]
                     end,
    lists:foldl(GetIndexParFun,[],NewIndexPartList).




%% 获取玩家的参战宠物的数量
get_fighting_partner_count(PS) ->
    ?ASSERT(is_record(PS, player_status), PS),
    F = fun(ParId) ->
            case lib_partner:get_partner(ParId) of
                null -> 
                    ?ASSERT(false, ParId), false;
                ParObj ->
                    lib_partner:is_fighting(ParObj)
            end
        end,
    ParIdList = player:get_partner_id_list(PS),
    L = [dummy || X <- ParIdList, F(X)],
    length(L).


%% return partner 结构体
db_insert_partner(Partner) when is_record(Partner, partner) ->
	Skills_BS = util:term_to_bitstring(Partner#partner.skills),
    Skills_BS_Two = util:term_to_bitstring(Partner#partner.skills_two),
    BaseTrainAttrs_BS = build_base_train_attrs_bitstring(Partner#partner.base_train_attrs),
	BaseTrainAttrsTmp_BS = build_base_train_attrs_bitstring(Partner#partner.base_train_attrs_tmp),
	
    BaseTalents = lib_partner:build_talents_bitstring(lib_partner:get_base_talents(Partner)),
    FeerPoint = lib_partner:get_free_talent_points(Partner),
	AttrRefine = util:term_to_bitstring(Partner#partner.attr_refine),
    ArtSlot = util:term_to_bitstring(Partner#partner.art_slot),
	CostRefine = util:term_to_bitstring(Partner#partner.cost_refine),
	
	NewId = db:insert_get_id(partner, 
        [player_id, no, name, sex, quality, state, lv, exp, 
        hp, intimacy,intimacy_lv,life,cur_battle_num,position,follow,cultivate,cultivate_lv,cultivate_layer,skills_use,skills,skills_two,battle_power,loyalty,
        nature_no,evolve_lv,evolve,awake_lv,awake_illusion,base_train_attrs, base_train_attrs_tmp, max_postnatal_skill, mood_no, last_update_mood_time, version, 
		mount_id,base_talents,free_talent_points,five_element,ts_join_battle,join_battle_order, attr_refine,art_slot, cost_refine],
		[Partner#partner.player_id, Partner#partner.no, Partner#partner.name, 
        Partner#partner.sex, Partner#partner.quality,Partner#partner.state, Partner#partner.lv, Partner#partner.exp,Partner#partner.hp, 
        Partner#partner.intimacy, Partner#partner.intimacy_lv, Partner#partner.life,Partner#partner.cur_battle_num, Partner#partner.position, Partner#partner.follow,
        Partner#partner.cultivate,Partner#partner.cultivate_lv, Partner#partner.cultivate_layer, Partner#partner.skills_use, Skills_BS, Skills_BS_Two, Partner#partner.battle_power,
        Partner#partner.loyalty, lib_partner:get_nature(Partner),Partner#partner.evolve_lv,Partner#partner.evolve,Partner#partner.awake_lv,Partner#partner.awake_illusion,BaseTrainAttrs_BS, BaseTrainAttrsTmp_BS, Partner#partner.max_postnatal_skill,
        Partner#partner.mood_no, Partner#partner.last_update_mood_time, lib_partner:get_version(Partner), Partner#partner.mount_id
        ,BaseTalents
        ,FeerPoint,util:term_to_bitstring(Partner#partner.five_element)
        ,Partner#partner.ts_join_battle,Partner#partner.join_battle_order, AttrRefine,ArtSlot,CostRefine]),
    NewId1 = 
        case lib_account:is_global_uni_id(NewId) of 
            true -> NewId; 
            false -> 
                GlobalId = lib_account:to_global_uni_id(NewId),
                db:update(Partner#partner.player_id, partner, ["id"], [GlobalId], "id", NewId), 
                GlobalId
        end,
	Partner#partner{id = NewId1}.


%% return partner 结构体
db_insert_partner_hotel(Partner) when is_record(Partner, partner) ->
    Skills_BS = util:term_to_bitstring(Partner#partner.skills),
    Skills_BS_Two = util:term_to_bitstring(Partner#partner.skills),
    Skills_BS_Exclusive = util:term_to_bitstring(Partner#partner.skills),
    BaseTrainAttrs_BS = build_base_train_attrs_bitstring(Partner#partner.base_train_attrs),
        
    BaseTalents = lib_partner:build_talents_bitstring(lib_partner:get_base_talents(Partner)),

    ?DEBUG_MSG("BaseTalents=~p",[BaseTalents]),

    FeerPoint = lib_partner:get_free_talent_points(Partner),

    NewId = db:insert_get_id(partner_hotel, 
        [player_id, no, name, sex, quality, state, lv, exp, 
        hp, intimacy,intimacy_lv,life,cur_battle_num,position,follow,cultivate,cultivate_lv,cultivate_layer,skills_use,skills,skills_two,skills_exclusive,battle_power,loyalty,
        nature_no,evolve_lv,evolve,base_train_attrs, max_postnatal_skill, mood_no, last_update_mood_time, version,base_talents,free_talent_points,five_element,ts_join_battle],
        [Partner#partner.player_id, Partner#partner.no, Partner#partner.name, 
        Partner#partner.sex, Partner#partner.quality,Partner#partner.state, Partner#partner.lv, Partner#partner.exp,Partner#partner.hp, 
        Partner#partner.intimacy, Partner#partner.intimacy_lv, Partner#partner.life,Partner#partner.cur_battle_num, Partner#partner.position, Partner#partner.follow,
        Partner#partner.cultivate,Partner#partner.cultivate_lv, Partner#partner.cultivate_layer,Partner#partner.skills_use,Skills_BS, Skills_BS_Two, Skills_BS_Exclusive, Partner#partner.battle_power,
        Partner#partner.loyalty, lib_partner:get_nature(Partner),Partner#partner.evolve_lv,Partner#partner.evolve, BaseTrainAttrs_BS, Partner#partner.max_postnatal_skill,
        Partner#partner.mood_no, Partner#partner.last_update_mood_time, lib_partner:get_version(Partner)
        ,BaseTalents
        ,FeerPoint,<<"{0,0}">>
        ,Partner#partner.ts_join_battle]),

    NewId1 = 
        case lib_account:is_global_uni_id(NewId) of 
            true -> NewId; 
            false -> 
                GlobalId = lib_account:to_global_uni_id(NewId),
                db:update(Partner#partner.player_id, partner_hotel, ["id"], [GlobalId], "id", NewId), 
                GlobalId
        end,
    Partner#partner{id = NewId1}.


%% 保存武将数据到db
db_save_partner(Partner) when is_record(Partner, partner) ->
	Skills_BS = util:term_to_bitstring(Partner#partner.skills),
    Skills_BS_Two = util:term_to_bitstring(Partner#partner.skills_two),
    BaseTrainAttrs_BS = build_base_train_attrs_bitstring(Partner#partner.base_train_attrs),
	BaseTrainAttrsTmp_BS = build_base_train_attrs_bitstring(Partner#partner.base_train_attrs_tmp),
	
    BaseTalents = lib_partner:build_talents_bitstring(lib_partner:get_base_talents(Partner)),
    FeerPoint = lib_partner:get_free_talent_points(Partner),
	AttrRefine = util:term_to_bitstring(Partner#partner.attr_refine),
    ArtSlot = util:term_to_bitstring(Partner#partner.art_slot),
	CostRefine = util:term_to_bitstring(Partner#partner.cost_refine),
	db:update(Partner#partner.player_id, partner, 
	["name", "quality", "state", "lv", "exp", "hp", "intimacy","intimacy_lv","life","cur_battle_num","position", "follow", "cultivate",
    "cultivate_lv", "cultivate_layer", "skills_use", "skills", "skills_two", "battle_power", "loyalty","nature_no", "evolve_lv", "evolve","awake_lv","awake_illusion","mood_no", "last_update_mood_time", "update_mood_count", "base_train_attrs",
    "base_train_attrs_tmp", "max_postnatal_skill", "add_skill_fail_cnt", "version", "mount_id","base_talents","free_talent_points","five_element", "ts_join_battle","join_battle_order", "attr_refine","art_slot","cost_refine"],
	[Partner#partner.name, Partner#partner.quality, Partner#partner.state, Partner#partner.lv, 
	Partner#partner.exp, Partner#partner.hp, Partner#partner.intimacy, Partner#partner.intimacy_lv,Partner#partner.life,Partner#partner.cur_battle_num, 
    Partner#partner.position, Partner#partner.follow, Partner#partner.cultivate,Partner#partner.cultivate_lv,Partner#partner.cultivate_layer,Partner#partner.skills_use, Skills_BS, Skills_BS_Two, Partner#partner.battle_power, 
    Partner#partner.loyalty, lib_partner:get_nature(Partner),Partner#partner.evolve_lv, Partner#partner.evolve, Partner#partner.awake_lv, Partner#partner.awake_illusion, Partner#partner.mood_no, Partner#partner.last_update_mood_time,
    Partner#partner.update_mood_count, BaseTrainAttrs_BS, BaseTrainAttrsTmp_BS, Partner#partner.max_postnatal_skill, lib_partner:get_add_skill_fail_cnt(Partner), lib_partner:get_version(Partner), Partner#partner.mount_id
    ,BaseTalents
    ,FeerPoint,util:term_to_bitstring(Partner#partner.five_element)
    ,Partner#partner.ts_join_battle,Partner#partner.join_battle_order, AttrRefine,ArtSlot,CostRefine],
	"id",
	Partner#partner.id).


%% 保存武将数据到db
db_save_partner_hotel(Partner) when is_record(Partner, partner) ->
    Skills_BS = util:term_to_bitstring(Partner#partner.skills),
    Skills_BS_Two = util:term_to_bitstring(Partner#partner.skills_two),
    Skills_BS_Exclusive = util:term_to_bitstring(Partner#partner.skills_exclusive),
    BaseTrainAttrs_BS = build_base_train_attrs_bitstring(Partner#partner.base_train_attrs),
	
    BaseTalents = lib_partner:build_talents_bitstring(lib_partner:get_base_talents(Partner)),
    FeerPoint = lib_partner:get_free_talent_points(Partner),

    db:update(Partner#partner.player_id, partner_hotel, 
    ["name", "quality", "state", "lv", "exp", "hp", "intimacy","intimacy_lv","life","cur_battle_num","position", "follow", "cultivate",
    "cultivate_lv", "cultivate_layer", "skills","skills_two","skills_exclusive","battle_power", "loyalty","nature_no", "evolve_lv", "evolve", "mood_no", "last_update_mood_time", "update_mood_count", "base_train_attrs", "version"], 
    [Partner#partner.name, Partner#partner.quality, Partner#partner.state, Partner#partner.lv, 
    Partner#partner.exp, Partner#partner.hp, Partner#partner.intimacy, Partner#partner.intimacy_lv,Partner#partner.life,Partner#partner.cur_battle_num, 
    Partner#partner.position,Partner#partner.follow,Partner#partner.cultivate,Partner#partner.cultivate_lv,Partner#partner.cultivate_layer,Skills_BS, Skills_BS_Two, Skills_BS_Exclusive, Partner#partner.battle_power, 
    Partner#partner.loyalty, lib_partner:get_nature(Partner),Partner#partner.evolve_lv, Partner#partner.evolve, Partner#partner.mood_no, Partner#partner.last_update_mood_time,
    Partner#partner.update_mood_count, BaseTrainAttrs_BS, lib_partner:get_version(Partner)
    ,BaseTalents
    ,FeerPoint  
    ],
    "id",
    Partner#partner.id).

	
%% 获取玩家携带的宠物编号列表(不重复)
%% return NoList
get_partner_no_list(PlayerId) ->
    F = fun(PartnerId) ->
        Partner = lib_partner:get_partner(PartnerId),
        lib_partner:get_no(Partner)
    end,
    List = [F(X) || X <- player:get_partner_id_list(PlayerId)],
    sets:to_list(sets:from_list(List)).


db_delete_partner(PlayerId, PartnerId) ->
    db:delete(PlayerId, partner, [{id, PartnerId}]).


db_delete_partner_hotel(PlayerId, PartnerId) ->
    db:delete(PlayerId, partner_hotel, [{id, PartnerId}]).

%%排序出战的门客
manage_parter_order(PS, PartnerIdList) ->
    %%先排序再操作
    F = fun(PartnerId,Acc) ->
        case lib_partner:get_partner(PartnerId) of
            null ->
                throw(1); %% 0成功 1失败
            Partner ->
                case lib_partner:is_fighting(Partner) of
                    false ->
                        throw(1); %% 0成功 1失败;
                    true ->
                        Index = length(Acc) + 1,
                        [{Index, PartnerId}|Acc]
                end
        end
            end,
    NewPartnerIdList  = lists:foldl(F,[],PartnerIdList),
    case lists:keyfind(1, 1 ,NewPartnerIdList) of
        false ->
            throw(1);
        {_ ,MainPartnerId} ->
            ply_partner:set_main_partner(PS, MainPartnerId)
    end,
    F2 =
        fun({BattleOrder,PartnerId}) ->
            Par = lib_partner:get_partner(PartnerId),
            mod_partner:update_partner_to_ets(Par#partner{ join_battle_order = BattleOrder})
        end,
    lists:foreach(F2,NewPartnerIdList),
    {ok, BinData} = pt_17:write(?PT_CHANGE_PARTNER_BATTLE_ORDER, [0, PartnerIdList]),
    lib_send:send_to_sock(PS, BinData).

%%    F2 =
%%        fun({Index2, PartnerId2}) ->
%%            case Index2 of
%%                1 ->
%%                    %%主将需要先取消之前的，再设置成现在的
%%                    case get_main_partner_id(PlayerId) of
%%                        PartnerId2 ->
%%                            skip;
%%                        MainPartId ->
%%                            ply_partner:set_main_partner(player:get_PS(PlayerId), MainPartId)
%%                    end;
%%                _ ->
%%                    skip
%%            end,
%%        end,
%%
%%    lists:foreach(F2,NewPartnerIdList).




% %% ==================================== Local Functions =============================================

build_base_train_attrs_bitstring(BaseTrainAttrs) ->
    ?ASSERT(is_record(BaseTrainAttrs, base_train_attrs)),
    % 顺序：{成长，生命资质，法力资质，物攻资质，法功资质，物防资质，法防资质，速度资质}， 顺序不要调换，因为存到DB时默认是这个顺序！
    Tup = {BaseTrainAttrs#base_train_attrs.grow, BaseTrainAttrs#base_train_attrs.life_aptitude, BaseTrainAttrs#base_train_attrs.mag_aptitude, BaseTrainAttrs#base_train_attrs.phy_att_aptitude, 
            BaseTrainAttrs#base_train_attrs.mag_att_aptitude, BaseTrainAttrs#base_train_attrs.phy_def_aptitude, BaseTrainAttrs#base_train_attrs.mag_def_aptitude,
            BaseTrainAttrs#base_train_attrs.speed_aptitude
            },
    util:term_to_bitstring(Tup).