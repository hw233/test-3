%%%-----------------------------------
%%% @Module  : mod_offline_data
%%% @Author  : lds
%%% @Email   :
%%% @Created : 2013.12
%%% @Description: 玩家离线数据
%%%-----------------------------------
-module (mod_offline_data).
-export([
    get_name/1
    ,get_guild_contri/1
    ,get_vip_lv/1
    ,get_faction/1
    ,get_sex/1
    ,get_lv/1
    ,get_peak_lv/1
    ,get_race/1
    ,get_offline_role_brief/1
    ,update_offline_role_brief/1
    ,get_offline_bo/3
    ,db_update_role_offline_bo/2
    ,db_update_partner_offline_bo/2
    ,db_save_role_offline_bo/2
    ,db_save_partner_offline_bo/2
    ,db_del_offline_bo/3
    ,db_replace_role_offline_bo/2
    ,make_showing_equips_rd/1
    ,db_replace_partner_offline_bo/2,
	cache_player_offline_bo/1
    ]).

-include("common.hrl").
-include("record.hrl").
-include("xinfa.hrl").
-include("offline_data.hrl").
-include("ets_name.hrl").
-include("partner.hrl").
-include("goods.hrl").
-include("record.hrl").
-include("skill.hrl").
-include("sys_code.hrl").
-include("road.hrl").


%% ====================================================================
%% API functions
%% ====================================================================

%% @doc 取得离线玩家简要信息,玩家在线则取PS内容，不在线则查找内存?ETS_OFFLINE_ROLE_BRIEF表，不在内存则从数据库加载
%% @return : null | #offline_role_brief{}
get_offline_role_brief(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) ->
            #offline_role_brief{
                id = RoleId
                ,name = player:get_name(Status)
                ,guild_contri = player:get_guild_contri(Status)
                ,lv = player:get_lv(Status)
                ,race = player:get_race(Status)
                ,faction = player:get_faction(Status)
                ,battle_power = Status#player_status.battle_power
                ,sex = player:get_sex(Status)
                ,vip_lv = player:get_vip_lv(Status)
                ,peak_lv = player:get_peak_lv(Status)
            };
        _ ->
            case get_cache_offline_role_brief(RoleId) of
                null -> load_offline_role_brief(RoleId);
                Brief -> Brief
            end
    end.

get_name(RoleId) ->
    get_any(RoleId, #offline_role_brief.name, <<>>).

get_guild_contri(RoleId) ->
    get_any(RoleId, #offline_role_brief.guild_contri, 0).

get_vip_lv(RoleId) ->
    get_any(RoleId, #offline_role_brief.vip_lv, 0).

get_faction(RoleId) ->
    get_any(RoleId, #offline_role_brief.faction, 0).

get_sex(RoleId) ->
    get_any(RoleId, #offline_role_brief.sex, 0).

get_lv(RoleId) ->
    get_any(RoleId, #offline_role_brief.lv, 0).

get_peak_lv(RoleId) ->
    get_any(RoleId, #offline_role_brief.peak_lv, 0).

get_race(RoleId) ->
    get_any(RoleId, #offline_role_brief.race, 0).

get_any(RoleId, Pos, Default) ->
    case get_offline_role_brief(RoleId) of
        #offline_role_brief{}=Role ->
            erlang:element(Pos, Role);
        _ ->
            ?ERROR_MSG("~p offline brief not found", [RoleId]),
            Default
    end.


%% @doc 玩家下线，更新离线玩家简要信息
update_offline_role_brief(Status) ->
    RoleId = player:id(Status),
    case get_cache_offline_role_brief(RoleId) of
        null -> skip;
        _ ->
            cache_offline_role_brief(#offline_role_brief{
                id = player:id(Status)
                ,name = player:get_name(Status)
                ,lv = player:get_lv(Status)
                ,race = player:get_race(Status)
                ,faction = player:get_faction(Status)
                ,battle_power = Status#player_status.battle_power
                ,sex = player:get_sex(Status)
                ,vip_lv = player:get_vip_lv(Status)
                ,peak_lv = player:get_peak_lv(Status)
            })
    end.


%% -----------------------------------------------------------
%% 离线战斗数据

%% 获取离线bo
%% @para: Id => 玩家id或宠物id
%%        BoType => bo类型（玩家？还是宠物？），详见common.hrl中的OBJ_XXX宏
%%        SysType => 系统类型（竞技场系统？ 还是雇佣天将系统？），详见sys_code.hrl
%% @return: null | offline_bo结构体
get_offline_bo(Id, BoType, SysType) ->
    % 采用懒初始化(lazy initialization)的方式：
    % 先从ets中查找， 如果没有，则再调用db_load_offline_bo()尝试从数据库加载
    case ets:lookup(?ETS_OFFLINE_BO, #offline_bo.key) of
        [Bo] when is_record(Bo, offline_bo) -> Bo;
        [] ->
            case db_load_offline_bo(Id, BoType, SysType) of
                OfflineBo when is_record(OfflineBo, offline_bo) ->
                    cache_offline_bo(OfflineBo), % 添加到ets当做缓存，下次获取时便可以直接从ets中获取
                    OfflineBo;
                _ ->
                    % ?WARNING_MSG("get_offline_bo() failed!! Id:~p, BoType:~p, SysType:~p, stacktrace:~w", [Id, BoType, SysType, erlang:get_stacktrace()]),
                    null
            end
    end.




%% 更新角色BO
db_update_role_offline_bo(Status, SysType) ->
    OfflineBo = make_offline_bo_rd(Status, SysType),
    cache_offline_bo(OfflineBo),
    db_update_offline_bo(OfflineBo).


%% 更新宠物BO
db_update_partner_offline_bo(Partner, SysType) ->
    OfflineBo = make_offline_bo_rd(Partner, SysType),
    cache_offline_bo(OfflineBo),
    db_update_offline_bo(OfflineBo).





%% 保存角色BO到DB , 同时保存玩家携带的宠物BO
db_save_role_offline_bo(Status, SysType) ->
    % ?ERROR_MSG("db_save_role_offline_bo = ~p~n", erlang:get_stacktrace()),
    OfflineBo = make_offline_bo_rd(Status, SysType),
    F1 = fun(X) ->
        Partner = lib_partner:get_partner(X),
        db_save_partner_offline_bo(Partner, SysType)
    end,
    lists:foreach(F1, OfflineBo#offline_bo.partners),
    db_save_offline_bo(OfflineBo).





%% 保存宠物BO到DB
db_save_partner_offline_bo(Partner, SysType) ->
    OfflineBo = make_offline_bo_rd(Partner, SysType),
    db_save_offline_bo(OfflineBo).



%% 保存角色BO到DB(有原数据就更新，没有数据则保存)
db_replace_role_offline_bo(Status, SysType) ->
%% 	case SysType =:=  of  
%% 		true -> %特殊处理
%% 			OfflineBo = make_offline_bo_rd(Status, SysType),
%% 			RoadRecord = mod_road:get_road_from_ets(player:get_id(Status)),
%% 			PkerData = RoadRecord#road_info.pk_info,
%% 			NowPoint = RoadRecord#road_info.now_point,
%% 			OpponentPartner = 
%% 				case length(PkerData) >= NowPoint of
%% 					true -> lists:sublist(PkerData, NowPoint, 1);
%% 					false -> ?ASSERT(false,NowPoint)
%% 				end,
%% 			
%% 			[{_PlayerId,_PlayerName,_Faction,_PlayerLv,_Sex,PkPartner}] =OpponentPartner,
%% 			
%% 			F1 = fun({PartnerId,Hp,Mp,_MaxHp,_MaxMp,_IsMain}) ->
%% 						 Partner = lib_partner:get_partner(PartnerId),
%% 						 Partner1= Partner#partner{total_attrs = Partner#partner.total_attrs#attrs{hp = Hp, mp = Mp}},
%% 						 db_replace_partner_offline_bo(Partner1, SysType)
%% 				 end,
%% 			lists:foreach(F1, PkPartner),
%% 			
%% 			cache_offline_bo(OfflineBo),
%% 			db_replace_offline_bo(OfflineBo);
%% 		false ->
			OfflineBo = make_offline_bo_rd(Status, SysType),
			F1 = fun(X) ->
						 Partner = lib_partner:get_partner(X),
						 
						 db_replace_partner_offline_bo(Partner, SysType)
				 end,
			lists:foreach(F1, OfflineBo#offline_bo.partners),
			cache_offline_bo(OfflineBo),
			db_replace_offline_bo(OfflineBo).

%只保存玩家的离线数据在ets
cache_player_offline_bo(PS) ->
	OfflineBo = make_offline_bo_rd(PS, 26),
	cache_offline_bo(OfflineBo).
  

%% 保存宠物BO到DB (有原数据就更新，没有数据则保存)
db_replace_partner_offline_bo(Partner, SysType) ->
    OfflineBo = make_offline_bo_rd(Partner, SysType),
    cache_offline_bo(OfflineBo),
    db_replace_offline_bo(OfflineBo).


%% 删除offline_bo记录
db_del_offline_bo(Id, BoType, SysType) ->
    ets:delete(?ETS_OFFLINE_BO, {Id, BoType, SysType}),
    db:delete(?DB_SYS, offline_bo, [{id, Id}, {bo_type, BoType}, {sys_type, SysType}]).

%% ====================================================================
%% internal functions
%% ====================================================================


%% @数据库加载玩家简要信息
%% @return : null | #offline_role_brief{}
load_offline_role_brief(RoleId) ->
    case RoleId of
        ?INVALID_ID ->
            % ?ERROR_MSG("load_offline_role_brief() failed!! RoleId invalid! stacktrace:~w", [erlang:get_stacktrace()]),
            % ?ASSERT(false, RoleId),
            null;
        _ ->
            case mod_global_data:is_player_deleted(RoleId) of
                true ->
                    null;
                false ->
                    % 帮派贡献度
                    GuildContri = case lib_player_ext:try_load_data(RoleId,guild_contri) of
                        fail ->
                            0;
                        {ok,GuildContri_} ->
                            GuildContri_
                    end,

                    case db:select_row(player, "nickname, lv, race, faction, battle_power, sex, vip_lv, peak_lv", [{id, RoleId}]) of
                        [Name, Lv, Race, Faction, BattlePower, Sex, VipLv, PeakLv] ->
                            Brief = #offline_role_brief{
                                id = RoleId
                                ,name = Name
                                ,guild_contri = GuildContri
                                ,lv = Lv
                                ,race = Race
                                ,faction = Faction
                                ,battle_power = BattlePower
                                ,sex = Sex
                                ,vip_lv = VipLv
                                ,peak_lv = PeakLv
                            },
                            cache_offline_role_brief(Brief),
                            Brief;
                        _ ->
                            ?ERROR_MSG("load_offline_role_brief() failed!! RoleId:~p, stacktrace:~w", [RoleId, erlang:get_stacktrace()]),
                            ?ASSERT(false, RoleId),
                            null
                    end
            end
    end.

            


%% @doc 缓存玩家简要信息
cache_offline_role_brief(Brief) when is_record(Brief, offline_role_brief) ->
    ets:insert(?ETS_OFFLINE_ROLE_BRIEF, Brief).


%% @doc 提取缓存玩家简要信息
%% @return : null | #offline_role_brief{}
get_cache_offline_role_brief(RoleId) ->
    case ets:lookup(?ETS_OFFLINE_ROLE_BRIEF, RoleId) of
        [Brief | _] when is_record(Brief, offline_role_brief) -> Brief;
        _ -> null
    end.


%% 添加离线bo到ets
%% @para: OfflineBo => 离线bo（offline_bo结构体）
cache_offline_bo(OfflineBo) when is_record(OfflineBo, offline_bo) ->
    ets:insert(?ETS_OFFLINE_BO, OfflineBo).


%% 从数据库加载离线bo
%% @return: null | offline_bo结构体
db_load_offline_bo(Id, BoType, SysType) ->
    case db:select_row(offline_bo, "name, race, faction, sex, lv, attrs, skills, xinfa, showing_equips, partners, par_property", [{id, Id}, {bo_type, BoType}, {sys_type, SysType}]) of
        [] -> null;
        [Name, Race, Faction, Sex, Lv, Attrs, Skills, Xinfa, ShowEquips_KV_TupList, Partners, ParProp_KV_TupList] ->
            ParProp =   case util:bitstring_to_term(ParProp_KV_TupList) of
                            null ->
                                null;
                            ParProp_KV_TupList2 when is_list(ParProp_KV_TupList2) ->
                                _ParPropRd = make_par_prop_rd(ParProp_KV_TupList2),
                                ?TRACE("db_load_offline_bo(), _ParPropRd: ~w~n", [_ParPropRd]),
                                ?ASSERT(is_boolean(_ParPropRd#par_prop.is_main_par)),
                                _ParPropRd
                        end,

            ShowEquips =   case util:bitstring_to_term(ShowEquips_KV_TupList) of
                            null ->
                                null;
                            ShowEquips_KV_TupList2 when is_list(ShowEquips_KV_TupList2) ->
                                ShowEquipsRd = make_showing_equips_rd(ShowEquips_KV_TupList2),
                                ?TRACE("db_load_offline_bo(), ShowEquipsRd: ~w~n", [ShowEquipsRd]),
                                ShowEquipsRd
                        end,
            #offline_bo{
                key = {Id, BoType, SysType}
                ,name = Name
                ,race = Race
                ,faction = Faction
                ,sex = Sex
                ,lv = Lv
                ,attrs = util:bitstring_to_term(Attrs)
                ,skills = util:bitstring_to_term(Skills)
                ,xinfa = util:bitstring_to_term(Xinfa)
                ,showing_equips = ShowEquips
                ,partners = tuple_to_list(util:bitstring_to_term(Partners))  % 因存储时转为了tuple类型，故这里转换回list类型！
                ,par_property = ParProp
                }
    end.


db_save_offline_bo(Bo) when is_record(Bo, offline_bo) ->
    {Id, BoType, SysType} = Bo#offline_bo.key,
    ParProp_BS = build_saving_par_prop_BS(Bo),
    ShowEquips_BS = build_saving_showing_equips_BS(Bo),
    db:insert(?DB_SYS,offline_bo,
        [
        {id, Id}
        ,{bo_type, BoType}
        ,{sys_type, SysType}
        ,{name, Bo#offline_bo.name}
        ,{race, Bo#offline_bo.race}
        ,{faction, Bo#offline_bo.faction}
        ,{sex, Bo#offline_bo.sex}
        ,{lv, Bo#offline_bo.lv}
        ,{attrs, util:term_to_bitstring(Bo#offline_bo.attrs)}
        ,{skills, util:term_to_bitstring(Bo#offline_bo.skills)}
        ,{xinfa, util:term_to_bitstring(Bo#offline_bo.xinfa)}
        ,{showing_equips, ShowEquips_BS}
        ,{partners, util:term_to_bitstring(list_to_tuple(Bo#offline_bo.partners))}  % 注意：为避免发生数据存储格式的错误，不直接存整数列表，而是转为tuple类型再存！！
        ,{par_property, ParProp_BS}
        ]);
db_save_offline_bo(_Bo) -> ?ASSERT(false, [_Bo]).




db_replace_offline_bo(Bo) when is_record(Bo, offline_bo) ->
    {Id, BoType, SysType} = Bo#offline_bo.key,
    ParProp_BS = build_saving_par_prop_BS(Bo),
    ShowEquips_BS = build_saving_showing_equips_BS(Bo),
    db:replace(?DB_SYS, offline_bo,
        [
        {id, Id}
        ,{bo_type, BoType}
        ,{sys_type, SysType}
        ,{name, Bo#offline_bo.name}
        ,{race, Bo#offline_bo.race}
        ,{faction, Bo#offline_bo.faction}
        ,{sex, Bo#offline_bo.sex}
        ,{lv, Bo#offline_bo.lv}
        ,{attrs, util:term_to_bitstring(Bo#offline_bo.attrs)}
        ,{skills, util:term_to_bitstring(Bo#offline_bo.skills)}
        ,{xinfa, util:term_to_bitstring(Bo#offline_bo.xinfa)}
        ,{showing_equips, ShowEquips_BS}
        ,{partners, util:term_to_bitstring(list_to_tuple(Bo#offline_bo.partners))}  % 注意：为避免发生数据存储格式的错误，不直接存整数列表，而是转为tuple类型再存！！
        ,{par_property, ParProp_BS}
        ]);
db_replace_offline_bo(_Bo) -> ?ASSERT(false, [_Bo]).





%% 更新offline_bo记录
db_update_offline_bo(Bo) when is_record(Bo, offline_bo) ->
    {Id, BoType, SysType} = Bo#offline_bo.key,
    ParProp_BS = build_saving_par_prop_BS(Bo),
    ShowEquips_BS = build_saving_showing_equips_BS(Bo),
    db:update(?DB_SYS, offline_bo,
        [
        {name, Bo#offline_bo.name}
        ,{race, Bo#offline_bo.race}
        ,{faction, Bo#offline_bo.faction}
        ,{sex, Bo#offline_bo.sex}
        ,{lv, Bo#offline_bo.lv}
        ,{attrs, util:term_to_bitstring(Bo#offline_bo.attrs)}
        ,{skills, util:term_to_bitstring(Bo#offline_bo.skills)}
        ,{xinfa, util:term_to_bitstring(Bo#offline_bo.xinfa)}
        ,{showing_equips, ShowEquips_BS}
        ,{partners, util:term_to_bitstring(list_to_tuple(Bo#offline_bo.partners))}
        ,{par_property, ParProp_BS}
        ],
        [
        {id, Id}
        ,{bo_type, BoType}
        ,{sys_type, SysType}
        ]);
db_update_offline_bo(_Bo) -> ?ASSERT(false, [_Bo]).









%% 构建offline_bo结构体
make_offline_bo_rd(Status, SysType) when is_record(Status, player_status) ->
    RoleId = player:id(Status),
    Attrs = ply_attr:get_total_attrs(Status),
    XinfaRd = ply_xinfa:get_player_xinfa_info(RoleId),
    Xinfa =
        case is_record(XinfaRd, ply_xinfa) of
            true -> XinfaRd#ply_xinfa.info_list;
            false -> []
        end,

    ShowEquips = player:get_showing_equips_base_setting(Status),
    ShowEquips1 = ShowEquips#showing_equip{suit_no = player:get_suit_no(Status)},
    
    % 增加装备特技
    Skills = [#skl_brief{id = Id} || Id <- ply_skill:get_magic_key_skill_list(RoleId)] ++ ply_skill:get_equip_skill(RoleId),
    #offline_bo{
        key = {RoleId, ?OBJ_PLAYER, SysType}
        ,name = player:get_name(Status)
        ,race = player:get_race(Status)
        ,faction = player:get_faction(Status)
        ,sex = player:get_sex(Status)
        ,lv = player:get_lv(Status)
        ,attrs = Attrs
        ,xinfa = Xinfa
        ,skills = Skills
        ,showing_equips = ShowEquips1
        ,partners = player:get_partner_id_list(Status)
        };



make_offline_bo_rd(Partner, SysType) when is_record(Partner, partner) ->
    PartnerId = lib_partner:get_id(Partner),
    Attrs = lib_partner:get_total_attrs(Partner),
	
	

	
    % 离线数据增加装备技能
    Skills = lib_partner:get_skill_list(Partner) ++  lib_partner:get_equip_skill(Partner) ++ lib_partner:get_passive_skill_list_of_mount(Partner),
    
    ParProp = #par_prop{
                    no = lib_partner:get_no(Partner),
                    is_main_par = lib_partner:is_main_partner(Partner),
                    is_fighting = lib_partner:is_fighting(Partner),
                    loyalty = lib_partner:get_loyalty(Partner),
                    quality = lib_partner:get_quality(Partner),
                    cultivate_lv = lib_partner:get_cultivate_lv(Partner),
                    cultivate_layer = lib_partner:get_cultivate_layer(Partner),
                    evolve_lv = lib_partner:get_evolve_lv(Partner),
                    nature = lib_partner:get_nature(Partner),
                    five_elment = Partner#partner.five_element
                    },
    
    #offline_bo{
        key = {PartnerId, ?OBJ_PARTNER, SysType}
        ,name = lib_partner:get_name(Partner)
        ,race = lib_partner:get_race(Partner)
        ,faction = lib_partner:get_faction(Partner)
        ,sex = lib_partner:get_sex(Partner)
        ,lv = lib_partner:get_lv(Partner)
        ,attrs = Attrs
        ,skills = Skills
        ,showing_equips = lib_partner:get_showing_equips_base_setting(Partner)
        ,partners = []
        ,par_property = ParProp
        }.




%% 构造要保存到数据库的宠物特性信息的bitstring
%% 说明：不直接存par_prop结构体，而是存构造后的key-value形式的元组列表，
%%       这样，以后即使par_prop结构体改了，也不用担心从数据库读取数据时无法正确还原出所想要的信息。
build_saving_par_prop_BS(Bo) ->
    case Bo#offline_bo.par_property of
        null ->
            util:term_to_bitstring(null);
        ParProp ->
            ?ASSERT(is_record(ParProp, par_prop), ParProp),
            FieldList = record_info(fields, par_prop),
            F = fun(Field, Acc_ParProp_KV_TupList) ->
                    case Field of
                        no ->
                            [{Field, ParProp#par_prop.no} | Acc_ParProp_KV_TupList];
                        is_main_par ->
                            IsMainPar_Int = util:bool_to_oz(ParProp#par_prop.is_main_par),
                            [{Field, IsMainPar_Int} | Acc_ParProp_KV_TupList];
                        is_fighting ->
                            IsFighting_Int = util:bool_to_oz(ParProp#par_prop.is_fighting),
                            [{Field, IsFighting_Int} | Acc_ParProp_KV_TupList];
                        loyalty ->
                            [{Field, ParProp#par_prop.loyalty} | Acc_ParProp_KV_TupList];
                        quality ->
                            [{Field, ParProp#par_prop.quality} | Acc_ParProp_KV_TupList];
                        cultivate_lv ->
                            [{Field, ParProp#par_prop.cultivate_lv} | Acc_ParProp_KV_TupList];
                        cultivate_layer ->
                            [{Field, ParProp#par_prop.cultivate_layer} | Acc_ParProp_KV_TupList];
                        evolve_lv ->
                            [{Field, ParProp#par_prop.evolve_lv} | Acc_ParProp_KV_TupList];
                        nature ->
                            [{Field, ParProp#par_prop.nature} | Acc_ParProp_KV_TupList];
                        five_elment ->
                            [{Field, ParProp#par_prop.five_elment} | Acc_ParProp_KV_TupList];
						awake_illusion ->
                            [{Field, ParProp#par_prop.awake_illusion} | Acc_ParProp_KV_TupList]
                    end
                end,
            ParProp_KV_TupList = lists:foldl(F, [], FieldList),
            ?ASSERT(util:is_tuple_list(ParProp_KV_TupList)),
            util:term_to_bitstring(ParProp_KV_TupList)
    end.


%% 构建par_prop结构体
make_par_prop_rd(ParProp_KV_TupList) ->
    ?ASSERT(util:is_tuple_list(ParProp_KV_TupList)),
     F = fun({Field, Value}, ParPropRd) ->
            case Field of
                no ->
                    ?ASSERT(util:is_positive_int(Value), Value),
                    ParPropRd#par_prop{no = Value};
                is_main_par ->
                    ?ASSERT(Value == 0 orelse Value == 1, Value),
                    ParPropRd#par_prop{is_main_par = util:oz_to_bool(Value)};
                is_fighting ->
                    ?ASSERT(Value == 0 orelse Value == 1, Value),
                    ParPropRd#par_prop{is_fighting = util:oz_to_bool(Value)};
                loyalty ->
                    ?ASSERT(is_integer(Value), Value),
                    ParPropRd#par_prop{loyalty = Value};
                quality ->
                    ?ASSERT(is_integer(Value), Value),
                    ParPropRd#par_prop{quality = Value};
                cultivate_lv ->
                    ?ASSERT(is_integer(Value), Value),
                    ParPropRd#par_prop{cultivate_lv = Value};
                cultivate_layer ->
                    ?ASSERT(is_integer(Value), Value),
                    ParPropRd#par_prop{cultivate_layer = Value};
                evolve_lv ->
                    ?ASSERT(is_integer(Value), Value),
                    ParPropRd#par_prop{evolve_lv = Value};
                nature ->
                    ?ASSERT(is_integer(Value), Value),
                    ParPropRd#par_prop{nature = Value};
                five_elment ->
                    ParPropRd#par_prop{five_elment  = Value};
				awake_illusion ->
                    ParPropRd#par_prop{awake_illusion  = Value}
				
            end
        end,
    lists:foldl(F, #par_prop{}, ParProp_KV_TupList).


build_saving_showing_equips_BS(Bo) ->
    case Bo#offline_bo.showing_equips of
        null ->
            util:term_to_bitstring(null);
        ShowEquips ->
            ?ASSERT(is_record(ShowEquips, showing_equip), ShowEquips),
            FieldList = record_info(fields, showing_equip),
            F = fun(Field, Acc_ShowEquips_KV_TupList) ->
                    case Field of
                        weapon ->
                            [{Field, ShowEquips#showing_equip.weapon} | Acc_ShowEquips_KV_TupList];
                        headwear ->
                            [{Field, ShowEquips#showing_equip.headwear} | Acc_ShowEquips_KV_TupList];
                        clothes ->
                            [{Field, ShowEquips#showing_equip.clothes} | Acc_ShowEquips_KV_TupList];
                        backwear ->
                            [{Field, ShowEquips#showing_equip.backwear} | Acc_ShowEquips_KV_TupList];
                        suit_no ->
                            [{Field, ShowEquips#showing_equip.suit_no} | Acc_ShowEquips_KV_TupList];
                        magic_key ->
                            [{Field, ShowEquips#showing_equip.magic_key} | Acc_ShowEquips_KV_TupList]
                    end
                end,
            ShowEquips_KV_TupList = lists:foldl(F, [], FieldList),
            ?ASSERT(util:is_tuple_list(ShowEquips_KV_TupList)),
            util:term_to_bitstring(ShowEquips_KV_TupList)
    end.

make_showing_equips_rd(ShowingEquips_KV_TupList) ->
    ?ASSERT(util:is_tuple_list(ShowingEquips_KV_TupList)),
     F = fun({Field, Value}, ShowingEquipsRd) ->
            case Field of
                weapon ->
                    ?ASSERT(is_integer(Value), Value),
                    ShowingEquipsRd#showing_equip{weapon = Value};
                headwear ->
                    ?ASSERT(is_integer(Value), Value),
                    ShowingEquipsRd#showing_equip{headwear = Value};
                clothes ->
                    ?ASSERT(is_integer(Value), Value),
                    ShowingEquipsRd#showing_equip{clothes = Value};
                backwear ->
                    ?ASSERT(is_integer(Value), Value),
                    ShowingEquipsRd#showing_equip{backwear = Value};
                suit_no ->
                    ?ASSERT(is_integer(Value), Value),
                    ShowingEquipsRd#showing_equip{suit_no = Value};
                magic_key ->
                    ?ASSERT(is_integer(Value), Value),
                    ShowingEquipsRd#showing_equip{magic_key = Value}
            end
        end,
    lists:foldl(F, #showing_equip{}, ShowingEquips_KV_TupList).