%%%-----------------------------------
%%% @Module  : mod_guild
%%% @Author  : 
%%% @Email   : 
%%% @Created : 
%%% @Description: 帮派系统本身相关的一些接口 如：添加帮派成员等操作
%%%-----------------------------------

-module(mod_guild).

-include("guild.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("record/guild_record.hrl").
-include("job_schedule.hrl").
-include("record.hrl").
-include("common.hrl").
-include_lib("stdlib/include/ms_transform.hrl").
-include("obj_info_code.hrl").
-include("pt_40.hrl").
-include("log.hrl").
-include("abbreviate.hrl").
-include("offline_data.hrl").
-include("num_limits.hrl").

-export([
          is_chief/1,
          is_guild_brief_valid/1,          
          get_chief_id/1,                         %% 获取帮主id
          get_counsellor_id_list/1,               %% 获取帮派军师id列表
          get_shaozhang_id_list/1,                %% 获取哨长id列表
          get_lv/1,                               %% 获取帮派等级
          get_id/1,                               %% 获取帮派id
          get_name/1,
          get_name_by_id/1,
          get_member_id_list/1,                   %% 获取帮派的成员id列表
          get_online_member_PS_list/1,
          get_member_info/1,                      %% 获取帮派成员的信息
          get_info/1,                             %% 获取帮派信息
          get_member_count_of_pos/2,              %% 获取某个职位的人数
          get_guild_pos/1,
          
          get_prosper_today/1,                    %% 获取今天累计获得繁荣度
          set_prosper_today/2,

          get_last_add_prosper_time/1,            %% 获取上次获得繁荣度时间
          set_last_add_prosper_time/2,
          get_mb_donate_today/1,
		  
		  get_guild_name_by_playerid/1,

          get_prosper/1,
          set_prosper/2,
          add_prosper/2,                          %% 帮派添加繁荣度
          del_prosper/2,
          add_liveness/2,                         %% 增加帮派活跃度

          add_guild_member_contri/3,              %% 添加帮派成员贡献度
          add_guild_member_contri1/3,
          cost_guild_member_contri/3,

          add_guild_member_donate/2,              %% 添加帮派捐献

          db_load_all_guild_info/0,
          db_load_guild_info/1,                   %% 从数据库查询帮派信息
          db_load_members_info/1,                 %% 从DB加载帮派成员的信息
          db_get_guild_id_by_player_id/1,         %% 数据库中根据玩家id查找帮派id
          db_save_guild/1,                        %% 保存帮派到数据库 
          db_save_all_guild/0,                    %% 保存所有帮派到数据库 
          db_insert_new_member/1,                 %% 在数据库中插入新帮派成员
          db_insert_new_guild/1,                  %% 插入新帮派到数据库的guild表
          db_delete_guild_member_by_mb_id/1,      %% 从数据库的guild_member表删帮派信息
          db_delete_guild_member_by_guild_id/1,   %% 从数据库的guild_member表删帮派信息
          db_delete_guild/1,                      %% 从数据库的guild表删帮派信息
          db_save_member/1,                       %% 保存帮派成员信息到数据库                       

          add_guild_to_ets/1,                     %% 插入到ETS_GUILD 
          to_member_record/1,                     %% 构造guild_mb结构体
          to_guild_record/1,                      %% 构造guild结构体
          update_guild_to_ets/1,                  %% 更新到ETS_GUILD
          add_member_info_to_ets/1,               %% 添加单个成员信息到ets
          update_member_to_ets/2,                 %% 更新帮派成员的信息到ets

          del_guild_from_ets/1,                   %% 从ETS_GUILD删除帮派 
          del_member_from_ets_by_guild_id/1,      %% 根据帮派id删除帮派成员
          del_member_from_ets_by_guild/1,
          del_member_from_ets_by_mb_id/1,         %% 根据帮派成员id删除帮派成员
          
          get_capacity_by_guild_lv/1,             %% 根据帮派等级获取帮派容量
          get_guild_member_count/1,               %% 获取帮派人数
          get_online_member_count/1,
          get_guild_apply_count/1,                %% 获取帮派申请人数          
          get_member_info_list/1,                 %% 获取帮派的成员信息列表
          get_guild_list/0,                       %% 获取全部帮会列表
          search_guild_list/2,                    %% 根据名字等搜索帮派列表
          get_req_join_list/1,                    %% 获取申请入帮派的全部玩家列表 
          clear_guild_id_of_member/1,

          db_save_guild_id/2,
          db_save_leave_guild_time/2,

          decide_guild_pos/2,
          try_record_login_player/2,              %% 尝试记录登录的玩家
          get_guild_scene_id/1,                   %% 获取帮派场景id
          get_guild_scene_id/2,                   %% 获取帮派场景id

          set_job_schedule/0,                             
          on_job_schedule/0,

          refresh_member_today/1,

          create_guild_scene/3,
          calc_battle_power/1,
          get_battle_power/1,
          correct_guild_id/2,                     %% 玩家帮派id容错
          sys_disband_guild/1,
          
          notify_guild_info_change/2,
          notify_player_join_guild/2
    ]).


%% 是否帮主？（true | false）
is_chief(PlayerId) when is_integer(PlayerId) ->
  MemberInfo = get_member_info(PlayerId),
  case MemberInfo =:= null of
      true -> false;
      false -> MemberInfo#guild_mb.position =:= ?GUILD_POS_CHIEF
  end;

is_chief(PS) ->
    case player:is_in_guild(PS) of
        false ->
            false;
        true ->
            MemberInfo = get_member_info(player:id(PS)),
            ?ASSERT(MemberInfo /= null),
            case MemberInfo =:= null of
                true -> false;
                false -> MemberInfo#guild_mb.position =:= ?GUILD_POS_CHIEF
            end
    end.


%% 检查帮会公告（简介）是否合法
is_guild_brief_valid(Brief) ->
    ?ASSERT(is_list(Brief)),
    case asn1rt:utf8_binary_to_list(list_to_binary(Brief)) of
        {ok, CharList} ->
            Len = util:string_width(CharList),
            case Len > ?GUILD_BRIEF_MAX_LEN of
                true ->
                    {false, len_error};
                false ->
                    true
            end;
        {error, _Reason} ->
            {false, char_illegal}
    end.


%% 获取帮主id
get_chief_id(GuildId) when is_integer(GuildId) ->
    case get_info(GuildId) of
        null -> ?INVALID_ID;
        Guild -> get_chief_id(Guild)
    end;
get_chief_id(Guild) ->
     Guild#guild.chief_id.


%% 获取军师id列表
get_counsellor_id_list(Guild) ->
     Guild#guild.counsellor_id_list.

get_shaozhang_id_list(Guild) ->
    Guild#guild.shaozhang_id_list.  


get_lv(Guild) when is_record(Guild, guild) ->
    Guild#guild.lv;
get_lv(GuildId) ->
    case get_info(GuildId) of
        null ->
            ?INVALID_NO;
        Guild ->
            get_lv(Guild)
    end.


get_id(Guild) ->
    Guild#guild.id.

get_name(Guild) ->
    Guild#guild.name.

%% 通过帮派id获取帮派名字
%% @return: <<"无">> | 帮派名称
get_name_by_id(GuildId) ->
  case get_info(GuildId) of
    null ->
      <<"无">>;
    GuildInfo ->
      get_name(GuildInfo)
  end.

%% 获取帮派的成员id列表
%% @return: [] | 成员id列表
get_member_id_list(Guild) when is_record(Guild, guild) ->
    Guild#guild.member_id_list;
get_member_id_list(GuildId) ->
     case get_info(GuildId) of
          null ->
               [];
          GuildInfo ->
               GuildInfo#guild.member_id_list
     end.

get_online_member_PS_list(GuildId) ->
    List = get_member_id_list(GuildId),
    F = fun(Id, Acc) ->
        case player:get_PS(Id) of
            null -> Acc;
            PS -> [PS | Acc]
        end
    end,
    lists:foldl(F, [], List).
  

%% 获取帮派成员的信息
%% @return: null | guild_mb结构体
get_member_info(PlayerId) ->
     case ets:lookup(?ETS_GUILD_MEMBER, PlayerId) of
          [] ->
               null;
          [MemberInfo] ->
               MemberInfo
     end.

get_guild_name_by_playerid(PlayerId) ->
	GuildMenber = mod_guild:get_member_info(PlayerId),
	case GuildMenber of 
		null  ->
			<<"无">>;
		_ ->GuildId = GuildMenber#guild_mb.guild_id,
			mod_guild:get_name_by_id(GuildId)
	end.
	

%% 获取帮派某个职位的人数
get_member_count_of_pos(GuildId, Pos) ->
    %% 容错处理函数
    F = fun(Id, Sum) ->
        case mod_guild:get_member_info(Id) of
            null -> Sum;
            GuildMb ->
                case GuildMb#guild_mb.guild_id =:= GuildId of
                    true -> Sum + 1;
                    false -> Sum
                end
        end
    end,

    case get_info(GuildId) of
        null -> ?ASSERT(false), 0;
        Guild ->
            case Pos of
                ?GUILD_POS_CHIEF -> 1;
                ?GUILD_POS_COUNSELLOR -> 
                    lists:foldl(F, 0, get_counsellor_id_list(Guild));
                ?GUILD_POS_SHAOZHANG ->
                    lists:foldl(F, 0, get_shaozhang_id_list(Guild));
                ?GUILD_POS_NORMAL_MEMBER -> length(get_member_id_list(Guild)) - length(get_counsellor_id_list(Guild)) - length(get_shaozhang_id_list(Guild)) - 1;
                _Any ->
                    ?ASSERT(false),
                    0
            end
    end.


%% 更新帮派成员的信息
%% 只是更新到内存（ets）
update_member_to_ets(PlayerId, MemberInfo_New) when is_record(MemberInfo_New, guild_mb) ->
    ?ASSERT(get_member_info(PlayerId) /= null, PlayerId),
    ?ASSERT(MemberInfo_New#guild_mb.id == PlayerId),
    case MemberInfo_New#guild_mb.id =:= PlayerId of
        false -> skip;
        true -> 
            case get_member_info(PlayerId) =:= null of
                true -> skip;
                false -> ets:insert(?ETS_GUILD_MEMBER, MemberInfo_New)
            end
    end.


%% 获取帮派信息
%% @return: null | guild结构体
get_info(GuildId) ->
     case ets:lookup(?ETS_GUILD, GuildId) of
          [] ->
              null;
          [GuildInfo]  ->
               ?ASSERT(is_record(GuildInfo, guild)),
               GuildInfo
     end.


get_battle_power(GuildId) when is_integer(GuildId) ->
    case get_info(GuildId) of
        null -> 0;
        Guild -> Guild#guild.battle_power
    end;
get_battle_power(Guild) ->
    Guild#guild.battle_power.


get_guild_scene_id(GuildId) when is_integer(GuildId) ->
    case GuildId =:= ?INVALID_ID of
        true -> ?INVALID_ID;
        false ->
            case get_info(GuildId) of
                null ->
                    ?ASSERT(false, GuildId),
                    ?INVALID_ID;
                Guild ->
                    case Guild#guild.scene_id =:= ?INVALID_ID of
                        true ->
                            GuildLv = case Guild#guild.lv =< 0 of true -> ?MIN_GUILD_LV; false -> Guild#guild.lv end, %% 等级调整，避免异常
                            SceneNo = (data_guild_lv:get(GuildLv))#guild_lv_data.scene_no,
                            case create_guild_scene(SceneNo, GuildLv, GuildId) of
                                fail -> ?INVALID_ID;
                                {ok, NewSceneId} ->
                                    NewSceneId
                            end;
                        false ->
                            Guild#guild.scene_id
                    end
            end
    end;

get_guild_scene_id(Guild) ->
    case Guild#guild.scene_id =:= ?INVALID_ID of
        true ->
            GuildLv = case Guild#guild.lv =< 0 of true -> ?MIN_GUILD_LV; false -> Guild#guild.lv end, %% 等级调整，避免异常
            SceneNo = (data_guild_lv:get(GuildLv))#guild_lv_data.scene_no,
            case create_guild_scene(SceneNo, GuildLv, Guild#guild.id) of
                fail -> ?INVALID_ID;
                {ok, NewSceneId} ->
                    NewSceneId
            end;
        false ->
            Guild#guild.scene_id
    end.


%% para：
%%  CreateFlag如果还没有创建帮派场景，是否创建 true | false
get_guild_scene_id(GuildId, CreateFlag) when is_integer(GuildId) ->
    case get_info(GuildId) of
        null ->
            ?ASSERT(false, GuildId),
            ?INVALID_ID;
        Guild ->
            case Guild#guild.scene_id =:= ?INVALID_ID andalso CreateFlag =:= true of
                true ->
                    GuildLv = case Guild#guild.lv =< 0 of true -> ?MIN_GUILD_LV; false -> Guild#guild.lv end, %% 等级调整，避免异常
                    SceneNo = (data_guild_lv:get(GuildLv))#guild_lv_data.scene_no,
                    case create_guild_scene(SceneNo, GuildLv, GuildId) of
                        fail -> ?INVALID_ID;
                        {ok, NewSceneId} ->
                            NewSceneId
                    end;
                false ->
                    Guild#guild.scene_id
            end
    end;

get_guild_scene_id(Guild, CreateFlag) ->
    case Guild#guild.scene_id =:= ?INVALID_ID andalso CreateFlag =:= true of
        true ->
            GuildLv = case Guild#guild.lv =< 0 of true -> ?MIN_GUILD_LV; false -> Guild#guild.lv end, %% 等级调整，避免异常
            SceneNo = (data_guild_lv:get(GuildLv))#guild_lv_data.scene_no,
            case create_guild_scene(SceneNo, GuildLv, Guild#guild.id) of
                fail -> ?INVALID_ID;
                {ok, NewSceneId} ->
                    NewSceneId
            end;
        false ->
            Guild#guild.scene_id
    end.
    

%% 此函数只能由非帮派进程调用，因为call了帮派进程
create_guild_scene(SceneNo, GuildLv, GuildId) ->
    case mod_scene:create_scene(SceneNo) of
        fail -> fail;
        {ok, NewSceneId} ->
            case mod_scene_tpl:get_tpl_data(SceneNo) of
                null -> fail;
                _SceneTpl ->
                    NeedNpcList = 
                        case data_guild_lv:get(GuildLv) of
                            null -> [];
                            GuildCfg -> GuildCfg#guild_lv_data.npc_list
                        end,
                    F = fun({NpcNo, X, Y}) ->
                        mod_scene:spawn_dynamic_npc_to_scene_WNC(NpcNo, NewSceneId, X, Y)
                    end,
                    [F(X) || X <- NeedNpcList],
                    case mod_guild_mgr:syn_guild_scene(GuildId, NewSceneId) of
                        ok -> {ok, NewSceneId};
                        fail -> fail
                    end
            end
    end.

%% 从数据库查询帮派信息
db_load_guild_info(GuildId) ->
    db:select_row(guild, ?GUILD_QRY_SQL, [{id, GuildId}], [], [1]).


db_load_all_guild_info() ->
    case db:select_all(guild, ?GUILD_QRY_SQL, []) of
        InfoList_List when is_list(InfoList_List) ->
            F = fun(InfoList) ->
                    case to_guild_record(InfoList) of
                        null -> skip;
                        Guild ->
                            add_guild_to_ets(Guild),
                            add_guild_war_ets(Guild)
                    end
                end,
            lists:foreach(F, InfoList_List);
        _Any ->
            ?ASSERT(false, _Any),
            []
    end.

%% 插入到ETS_GUILD
add_guild_to_ets(Guild) when is_record(Guild, guild) ->
    true = ets:insert_new(?ETS_GUILD, Guild).


%% 顺便把帮派争霸赛需要的成员数据加载到内存
add_guild_war_ets(Guild) ->
    case Guild#guild.total_bid > 0 of
        true ->
            GuildWar = #guild_war{
              guild_id = Guild#guild.id, name = Guild#guild.name, battle_power = Guild#guild.battle_power, 
              total_bid = Guild#guild.total_bid, bid_id_list = Guild#guild.bid_id_list
            },
            lib_guild:add_guild_war_to_ets(GuildWar),
            mod_guild:db_load_members_info(Guild#guild.id);
        false -> skip
    end.


%% 从DB加载帮派成员的信息
db_load_members_info(GuildId) ->
    case db:select_all(guild_member, ?GUILD_MB_SQL, [{guild_id, GuildId}]) of
        InfoList_List when is_list(InfoList_List) andalso InfoList_List =/= [] ->
            F = fun(InfoList) ->
                    MemberInfo = to_member_record(InfoList),
                    add_member_info_to_ets(MemberInfo)
                end,
            lists:foreach(F, InfoList_List);
        _Any ->
            ?DEBUG_MSG("mod_guild:Local:~p~n", [lib_account:to_local_id(GuildId)]),
            case db:select_all(guild_member, ?GUILD_MB_SQL, [{guild_id, lib_account:to_local_id(GuildId)}]) of
                InfoList_List when is_list(InfoList_List) ->
                    F = fun(InfoList) ->
                            MemberInfo = to_member_record(InfoList),
                            add_member_info_to_ets(MemberInfo)
                        end,
                    lists:foreach(F, InfoList_List);
                _ -> []
            end
    end.


to_member_record(InfoList) ->
    [Id, TGuildId, Name, Lv, VipLv, Sex, Race, Faction, JoinTime, Contri, BattlePower, TitleId, LeftContri, ContriToday, LastAddContriTime, DonateToday, DonateTotal,
    LastDonateTime, PayToday, Bid] = InfoList,
    PayToday1 = 
        case is_list(PayToday) of
            true -> PayToday;
            false -> case util:bitstring_to_term(PayToday) of undefined -> []; PayList -> PayList end
        end,

    GuildId = case lib_account:is_global_uni_id(TGuildId) of true -> TGuildId; false -> lib_account:to_global_uni_id(TGuildId) end,
    #guild_mb{
        id = Id,
        guild_id = GuildId,
        name = Name,
        lv = Lv,
        vip_lv = VipLv,
        sex = Sex,
        race = Race,
        faction = Faction,
        join_time = JoinTime,
        contri = Contri,
        title_id = TitleId,
        battle_power = BattlePower,
        left_contri = LeftContri,
        contri_today = ContriToday, 
        last_add_contri_time = LastAddContriTime,
        donate_today = DonateToday,
        donate_total = DonateTotal,
        last_donate_time = LastDonateTime,
        pay_today = PayToday1,
        position = decide_guild_pos(Id, GuildId),
        bid = Bid
        }.


%% 转成guild结构体 | null
to_guild_record(InfoList) ->
    ?ASSERT(InfoList /= []),
    [Id, Name, Brief, Lv, CreateTime, ChiefId, Counsellor_BS, Shaozhang_BS, Rank, Prosper, MemberList_BS, RequestJoiningList_BS, ProsperToday, LastAddProsperTime, Fund, 
    LoginIdList_BS, Liveness, DonateRank_BS, TotalBid, BidIdList_BS, JoinControl, GuildShop] = InfoList,
    case ChiefId =:= ?INVALID_ID of
        true -> null; %% 数据容错
        false ->
            ChiefName = %% 容错
                case lib_account:db_get_role_name_by_id(ChiefId) of
                    null -> <<>>;
                    TChiefName -> TChiefName
                end,
            
            CounsellorIdlist = case util:bitstring_to_term(Counsellor_BS) of undefined -> []; CounsellorIds-> tuple_to_list(CounsellorIds) end,
            ShaozhangIdList = case util:bitstring_to_term(Shaozhang_BS) of undefined -> []; ShaozhangIds -> tuple_to_list(ShaozhangIds) end,
            
            #guild{
                  id = adust_id(Id),
                  name = Name,
                  brief = Brief,
                  lv = Lv,
                  create_time = CreateTime,
                  chief_id = ChiefId,
                  chief_name = ChiefName,
                  counsellor_id_list = sets:to_list(sets:from_list(CounsellorIdlist)),
                  shaozhang_id_list = sets:to_list(sets:from_list(ShaozhangIdList)),
                  rank = Rank,
                  prosper = Prosper,
                  member_id_list = case util:bitstring_to_term(MemberList_BS) of undefined -> []; Members -> tuple_to_list(Members) end,
                  request_joining_list = case util:bitstring_to_term(RequestJoiningList_BS) of undefined -> []; RequestJoinings -> tuple_to_list(RequestJoinings) end,
                  prosper_today = ProsperToday, 
                  last_add_prosper_time = LastAddProsperTime, 
                  fund = Fund, 
                  login_id_list = case util:bitstring_to_term(LoginIdList_BS) of undefined -> []; LoginIds -> tuple_to_list(LoginIds) end,
                  liveness = Liveness,
                  donate_rank = case util:bitstring_to_term(DonateRank_BS) of undefined -> []; DonateRank -> DonateRank end,
                  total_bid = TotalBid,
                  bid_id_list = case util:bitstring_to_term(BidIdList_BS) of undefined -> []; BidIds -> tuple_to_list(BidIds) end,
                  join_control = JoinControl,
                    guild_shop = case util:bitstring_to_term(GuildShop) of undefined -> []; GuildShop11 -> GuildShop11 end
                  }
    end.


adust_id(TId) ->
    Id = 
        case lib_account:is_global_uni_id(TId) of 
            true -> TId; 
            false -> 
                GlobalId = lib_account:to_global_uni_id(TId),
                db:update(?DB_SYS, guild, ["id"], [GlobalId], "id", TId), 
                GlobalId
        end,
    Id.

get_capacity_by_guild_lv(Lv) ->
    case Lv =< 0 of
        true ->
           (data_guild_lv:get(1))#guild_lv_data.capacity;
        false -> 
            case data_guild_lv:get(Lv) of
                null ->
                    ?ASSERT(false, Lv),
                    (data_guild_lv:get(1))#guild_lv_data.capacity;
                Data -> Data#guild_lv_data.capacity
            end
    end.

get_guild_member_count(GuildId) when is_integer(GuildId) ->
    ?ASSERT(is_integer(GuildId), GuildId),
    MbIdList = mod_guild:get_member_id_list(GuildId),
    length(MbIdList);
get_guild_member_count(Guild) ->
    length(Guild#guild.member_id_list).


get_online_member_count(MemberList) ->
    F = fun(Member, Sum) ->
        case player:is_online(Member#guild_mb.id) of
            true -> Sum + 1;
            false -> Sum
        end
    end,
    lists:foldl(F, 0, MemberList).


%% 获取帮派申请人数
get_guild_apply_count(GuildId) when is_integer(GuildId) ->
    case get_info(GuildId) of
        null -> 0;
        Guild ->
            length(Guild#guild.request_joining_list)
    end;
get_guild_apply_count(Guild) ->
    length(Guild#guild.request_joining_list).


%% 更新到ETS_GUILD
update_guild_to_ets(Guild) when is_record(Guild, guild) ->
    case get_info(Guild#guild.id) of
        null ->
            ?ERROR_MSG("mod_guild:update_guild_to_ets error!~n", []),
            skip;
        _Any ->
            ets:insert(?ETS_GUILD, Guild)
    end.


%% 数据库中根据玩家id查找帮派id
%% return guild_id | ?INVALID_ID
db_get_guild_id_by_player_id(PlayerId) ->
    case db:select_one(player, "guild_id", [{id, PlayerId}], [], [1]) of
        GuildId when is_integer(GuildId) ->
            GuildId;
        _Any -> % db出错
            ?ASSERT(false, _Any),
            ?INVALID_ID
    end.


%% 添加单个成员信息到ets
add_member_info_to_ets(MemberInfo) when is_record(MemberInfo, guild_mb) ->
    % true = ets:insert_new(?ETS_GUILD_MEMBER, MemberInfo).
    _Ret = ets:insert_new(?ETS_GUILD_MEMBER, MemberInfo),
    case _Ret of
        true -> skip;
        false -> ?ERROR_MSG("mod_guild:add_member_info_to_ets error!~w,~w~n", [MemberInfo, get_member_info(MemberInfo#guild_mb.id)])
    end.


-define(DB_SAVE_GUILD_DATA_INTV, 20). % 保存各帮派数据到DB的间隔，单位：毫秒 

db_save_all_guild() ->
    GuildList = get_guild_list(),
    F = fun(Guild) ->
        db_save_guild(Guild),
        timer:sleep(?DB_SAVE_GUILD_DATA_INTV)   % 为避免瞬间集中存储，稍sleep一下！
    end,
    lists:foreach(F, GuildList),

    MemberList = ets:tab2list(?ETS_GUILD_MEMBER),
    F1 = fun(Member) ->
        case Member#guild_mb.is_dirty of
            true ->
                db_save_member(Member),
                timer:sleep(?DB_SAVE_GUILD_DATA_INTV);   % 为避免瞬间集中存储，稍sleep一下！
            false ->
                skip
        end
    end,
    lists:foreach(F1, MemberList),
    ok.


%% 保存帮派到数据库
db_save_guild(Guild) ->
    % BS:表示bitstring
    MbIdList_BS = util:term_to_bitstring(list_to_tuple(Guild#guild.member_id_list)),
    ReqJoinList_BS = util:term_to_bitstring(list_to_tuple(Guild#guild.request_joining_list)),
    Counsellor_BS = util:term_to_bitstring(list_to_tuple(Guild#guild.counsellor_id_list)),
    Shaozhang_BS = util:term_to_bitstring(list_to_tuple(Guild#guild.shaozhang_id_list)),
    LoginIdList_BS = util:term_to_bitstring(list_to_tuple(Guild#guild.login_id_list)),
    DonateRank_BS = util:term_to_bitstring(Guild#guild.donate_rank),
    BidIdList_BS = util:term_to_bitstring(list_to_tuple(Guild#guild.bid_id_list)),
    GuildShop = util:term_to_bitstring(Guild#guild.guild_shop),

    db:update(?DB_SYS, guild, ["name", "lv", "chief_id", "rank", "counsellor_list", "shaozhang_list", "member_list", "request_joining_list", "prosper", 
                      "prosper_today", "last_add_prosper_time", "fund", "login_id_list", "liveness", "donate_rank", "brief", "battle_power", "total_bid", "bid_id_list",
                      "join_control","guild_shop"],
                     [Guild#guild.name, Guild#guild.lv, Guild#guild.chief_id, Guild#guild.rank, Counsellor_BS, Shaozhang_BS, MbIdList_BS, ReqJoinList_BS,
                     Guild#guild.prosper, Guild#guild.prosper_today, Guild#guild.last_add_prosper_time, Guild#guild.fund, LoginIdList_BS, Guild#guild.liveness, 
                     DonateRank_BS, Guild#guild.brief, Guild#guild.battle_power, Guild#guild.total_bid, BidIdList_BS, Guild#guild.join_control, GuildShop],
                    "id",
                    Guild#guild.id
            ).


%% 保存帮派成员信息到数据库  
db_save_member(Member) ->
    case Member#guild_mb.is_dirty of
        false -> skip;
        true -> update_member_to_ets(Member#guild_mb.id, Member#guild_mb{is_dirty = false})
    end,
    
    PayToday_BS = util:term_to_bitstring(Member#guild_mb.pay_today),
    db:update(?DB_SYS, guild_member, ["lv", "faction", "contri", "title_id", "left_contri", "contri_today", "last_add_contri_time", "donate_today", "donate_total", 
                                      "last_donate_time", "pay_today", "position", "bid", "name", "guild_id"
                                     ],
                            [
                            Member#guild_mb.lv, Member#guild_mb.faction, Member#guild_mb.contri, Member#guild_mb.title_id, Member#guild_mb.left_contri, 
                            Member#guild_mb.contri_today, Member#guild_mb.last_add_contri_time, Member#guild_mb.donate_today, Member#guild_mb.donate_total, 
                            Member#guild_mb.last_donate_time, PayToday_BS, Member#guild_mb.position, Member#guild_mb.bid, Member#guild_mb.name, Member#guild_mb.guild_id],
                            "id",
                            Member#guild_mb.id).


db_insert_new_member(Member) ->
    db:replace(?DB_SYS, guild_member, [{id, Member#guild_mb.id}, {guild_id, Member#guild_mb.guild_id}, 
                                      {name, Member#guild_mb.name}, {lv, Member#guild_mb.lv}, {vip_lv, Member#guild_mb.vip_lv}, {sex, Member#guild_mb.sex}, 
                                      {race, Member#guild_mb.race}, {faction, Member#guild_mb.faction}, {join_time, svr_clock:get_unixtime()}, 
                                      {contri, Member#guild_mb.contri}, {title_id, Member#guild_mb.title_id}, {battle_power,Member#guild_mb.battle_power},
                                      {left_contri, Member#guild_mb.left_contri}, {contri_today, Member#guild_mb.contri_today}, {position, Member#guild_mb.position},
                                      {bid, Member#guild_mb.bid}
                                      ]).


%% 插入新帮派到数据库的guild表
%% @return；新帮派的唯一id
db_insert_new_guild(Guild) ->
    % BS:表示bitstring
    MbIdList_BS = util:term_to_bitstring(list_to_tuple(Guild#guild.member_id_list)),
    ReqJoinList_BS = util:term_to_bitstring(list_to_tuple(Guild#guild.request_joining_list)),
    Counsellor_BS = util:term_to_bitstring(list_to_tuple(Guild#guild.counsellor_id_list)),
    Shaozhang_BS = util:term_to_bitstring(list_to_tuple(Guild#guild.shaozhang_id_list)),
    LoginIdList_BS = util:term_to_bitstring(list_to_tuple(Guild#guild.login_id_list)),
    BidIdList_BS = util:term_to_bitstring(list_to_tuple(Guild#guild.bid_id_list)),
    GuildShop = util:term_to_bitstring(Guild#guild.guild_shop),

    db:insert_get_id(guild, ["name", "brief", "lv", "create_time", "chief_id", "counsellor_list", "shaozhang_list", "rank", "prosper", "member_list", 
                      "request_joining_list", "prosper_today", "last_add_prosper_time", "fund", "login_id_list", "total_bid", "bid_id_list", "join_control","guild_shop"],
                     [Guild#guild.name, Guild#guild.brief, Guild#guild.lv, svr_clock:get_unixtime(), Guild#guild.chief_id, Counsellor_BS, 
                     Shaozhang_BS, Guild#guild.rank, Guild#guild.prosper, MbIdList_BS, ReqJoinList_BS, get_prosper_today(Guild), 
                     get_last_add_prosper_time(Guild), Guild#guild.fund, LoginIdList_BS, Guild#guild.total_bid, BidIdList_BS, Guild#guild.join_control,GuildShop]
                    ).


%% 从ETS_GUILD删除帮派
del_guild_from_ets(GuildId) ->
    ets:delete(?ETS_GUILD, GuildId).


%% 根据帮派id删除帮派成员
del_member_from_ets_by_guild_id(GuildId) when is_integer(GuildId) ->
    F = fun(MemberId) ->
        ets:delete(?ETS_GUILD_MEMBER, MemberId)
    end,
    lists:foreach(F, get_member_id_list(GuildId)).


del_member_from_ets_by_guild(Guild) ->
    F = fun(MemberId) ->
        ets:delete(?ETS_GUILD_MEMBER, MemberId)
    end,
    lists:foreach(F, get_member_id_list(Guild)).


del_member_from_ets_by_mb_id(MemberId) ->
    ets:delete(?ETS_GUILD_MEMBER, MemberId).


%% 从数据库的guild_member表删帮派信息
db_delete_guild_member_by_mb_id(MemberId) ->
    db:delete(?DB_SYS, guild_member, [{id, MemberId}]).


%% 从数据库的guild_member表删帮派信息
db_delete_guild_member_by_guild_id(GuildId) ->
    db:delete(?DB_SYS, guild_member, [{guild_id, GuildId}]).


%% 从数据库的guild表删帮派信息
db_delete_guild(GuildId) ->
    db:delete(?DB_SYS, guild, [{id, GuildId}]).


%% 获取帮派的全部成员信息列表
get_member_info_list(GuildId) ->
     Ms = ets:fun2ms(fun(T) when GuildId =:= T#guild_mb.guild_id -> T end),
     ets:select(?ETS_GUILD_MEMBER, Ms).


%% 获取全部帮会列表
get_guild_list() ->
    ets:tab2list(?ETS_GUILD).


search_guild_list(NotFull, SearchName) ->
    % if 
    %     NotFull =:= 1 andalso SearchName =:= [] ->
    %         Ms = ets:fun2ms(fun(T) when length(T#guild.member_id_list) < T#guild.capacity -> T end);
    %     NotFull =:= 1 andalso SearchName =/= [] ->
    %         Ms = ets:fun2ms(fun(T) when length(T#guild.member_id_list) < T#guild.capacity -> 
    %                                                         case string:str(binary_to_list(T#guild.name), SearchName) of
    %                                                             _Result when _Result =/= 0 -> T;
    %                                                             _ -> null
    %                                                         end
    %               end);
    %     NotFull =:= 0 andalso SearchName =/= [] ->
    %         Ms = ets:fun2ms(fun(T) when is_record(T, guild) -> 
    %                                                         case string:str(binary_to_list(T#guild.name), SearchName) of
    %                                                             _Result when _Result =/= 0 -> T;
    %                                                             _ -> null
    %                                                         end
    %               end);
    %     true ->
    %         ?ASSERT(false)
    % end,

    List = ets:tab2list(?ETS_GUILD),
    F = fun(T) ->
        if 
            NotFull =:= 1 andalso SearchName =:= [] ->
                case length(T#guild.member_id_list) < get_capacity_by_guild_lv(T#guild.lv) of
                    true -> T;
                    false -> null
                end;
            NotFull =:= 1 andalso SearchName =/= [] ->
                case length(T#guild.member_id_list) < get_capacity_by_guild_lv(T#guild.lv) andalso string:str(binary_to_list(T#guild.name), SearchName) =/= 0 of
                    true -> T;
                    false -> null
                end;
            NotFull =:= 0 andalso SearchName =/= [] ->
                case string:str(binary_to_list(T#guild.name), SearchName) =/= 0 of
                    true -> T;
                    false -> null
                end;
            true ->
                ?ASSERT(false)
        end
    end,
    List1 = [F(X) || X <- List],
    [F(X) || X <- List1, X =/= null].


%% 获取申请入帮派的玩家列表
get_req_join_list(GuildId) ->
    case get_info(GuildId) of
        null ->
            [];
        Guild ->
            Guild#guild.request_joining_list
    end.

get_prosper_today(Guild) ->
    Guild#guild.prosper_today.

set_prosper_today(Guild, Value) ->
    Guild#guild{prosper_today = Value}.

get_last_add_prosper_time(Guild) ->
    Guild#guild.last_add_prosper_time.

set_last_add_prosper_time(Guild, Value) ->
    Guild#guild{last_add_prosper_time = Value}.


%% 获取成员的繁荣度  
get_prosper(GuildId) when is_integer(GuildId) ->
    case get_info(GuildId) of
        null -> 0;
        Guild -> Guild#guild.prosper
    end;
get_prosper(Guild) ->
    Guild#guild.prosper.

set_prosper(Guild, Value) ->
    Guild#guild{prosper = Value}.

get_prosper_lim(Lv) ->
    case Lv > lists:last(data_guild_lv:get_all_lv_list()) of
        false -> (data_guild_lv:get(Lv))#guild_lv_data.need_prosper;
        true -> ?MAX_U32
    end.

add_prosper(GuildId, AddValue) when is_integer(GuildId) ->
    case get_info(GuildId) of
        null -> fail;
        Guild -> add_prosper(Guild, AddValue)
    end;
add_prosper(Guild, Value) ->
    GuildLv = get_lv(Guild),
    case GuildLv >= lists:last(data_guild_lv:get_all_lv_list()) of
        true ->
            fail;
        false ->
            Guild1 = refresh_prosper_today(Guild),
            %% 每日获得最多不超过 帮派当前最大人数*帮派成员每日可接取帮派任务次数*每帮派任务提供繁荣度 点繁荣度
            Data = data_guild_lv:get(Guild#guild.lv),
            Max = Data#guild_lv_data.prosper_max_day,
            AddValue = 
                case get_prosper_today(Guild1) + Value > Max of
                    true -> Max - get_prosper_today(Guild1);
                    false -> Value
                end,
            case AddValue > 0 of
                false -> fail;
                true ->
                    NewGuild = set_prosper(Guild1, get_prosper(Guild1) + AddValue),
                    NewGuild1 = set_prosper_today(NewGuild, get_prosper_today(NewGuild) + AddValue),
                    NewGuild2 = set_last_add_prosper_time(NewGuild1, svr_clock:get_unixtime()),
                    ProsperLim = get_prosper_lim(get_lv(NewGuild2) + 1),
                    case get_prosper(NewGuild2) < ProsperLim of
                        true ->
                            NewGuild3 = NewGuild2#guild{battle_power = mod_guild:calc_battle_power(NewGuild2)},
                            update_guild_to_ets(NewGuild3),
                            %% 更新帮派排名
                            mod_guild_mgr:update_guild_rank(),
                            {ok, NewGuild2};
                        false ->
                            {NewLv, LeftProsper} = change_lv_by_prosper(get_lv(NewGuild2), get_prosper(NewGuild2)),
                            NewGuild3 = set_prosper(NewGuild2, LeftProsper),
                            NewGuild4 = set_lv(NewGuild3, min(NewLv, lists:last(data_guild_lv:get_all_lv_list()))),
                            NewGuild5 = NewGuild4#guild{battle_power = calc_battle_power(NewGuild4)},
                            update_guild_to_ets(NewGuild5),
                            db_save_guild(NewGuild5),
                            %% 更新帮派排名
                            mod_guild_mgr:update_guild_rank(),
                            
                            case NewLv >= 7 of
                                false -> skip;
                                true -> ply_tips:send_sys_tips(NewGuild4, {guild_lv_up, [NewGuild4#guild.name, NewLv]})
                            end,

                            spawn(fun() -> notify_guild_info_change(NewGuild4, [{guild_lv, NewGuild4#guild.lv}]) end),

                            % 检查是否要添加npc
                            case get_guild_scene_id(NewGuild4, false) of
                                ?INVALID_ID -> skip;
                                SceneId ->
                                    NeedNpcList = 
                                        case data_guild_lv:get(NewLv) of
                                            null -> [];
                                            GuildCfg -> GuildCfg#guild_lv_data.npc_list
                                        end,
                                    HaveNpcNoList = get_scene_npc_no_list(SceneId),
                                    F = fun({NpcNo, X, Y}) ->
                                        case lists:member(NpcNo, HaveNpcNoList) of
                                            true -> skip;
                                            false -> mod_scene:spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneId, X, Y)
                                        end
                                    end,
                                    [F(X) || X <- NeedNpcList]
                            end,
                            {ok, NewGuild4}
                    end
            end
    end.


del_prosper(Guild, Value) ->
    GuildLv = get_lv(Guild),
    case Value > 0 of
        false -> {ok, Guild};
        true ->
            ProsperNow = 
                case Guild#guild.lv >= ?MIN_GUILD_LV of
                    false -> max(0, get_prosper(Guild) - Value);
                    true -> 
                        F0 = fun(Lv, Sum) ->
                            case data_guild_lv:get(Lv) of
                                null -> Sum;
                                Data -> Data#guild_lv_data.need_prosper + Sum
                            end
                        end,
                        Total = lists:foldl(F0, 0, lists:seq(1, GuildLv)),
                        max(0, Total + get_prosper(Guild) - Value)
                end,

            {NewLv, LeftProsper} = change_lv_by_prosper(?MIN_GUILD_LV, ProsperNow),
            NewGuild1 = set_prosper(Guild, LeftProsper),
            NewGuild2 = set_lv(NewGuild1, NewLv),
            % NewGuild3 = NewGuild2#guild{battle_power = calc_battle_power(NewGuild2)},
            NewGuild3 = NewGuild2, %% 这里涉及数据库查询操作，0点服务器压力大，暂时不计算帮派战力
            update_guild_to_ets(NewGuild3),
            case NewLv =:= GuildLv of
                true ->
                    {ok, NewGuild3};
                false ->
                    db_save_guild(NewGuild3),
                    %% 更新帮派排名
                    mod_guild_mgr:update_guild_rank(),
                    % notify_guild_info_change(NewGuild2, [{guild_lv, NewGuild2#guild.lv}]),
            
                    % 检查是否要删除npc
                    case get_guild_scene_id(NewGuild3, false) of
                        ?INVALID_ID -> skip;
                        SceneId ->
                            NeedNpcNoList = 
                                case data_guild_lv:get(NewLv) of
                                    null -> [];
                                    GuildCfg -> [No || {No, _X, _Y} <- GuildCfg#guild_lv_data.npc_list]
                                end,
                            HaveNpcObjList = get_scene_npc_obj_list(SceneId),
                            
                            F = fun(Npc) ->
                                case lists:member(mod_npc:get_no(Npc), NeedNpcNoList) of
                                    true -> skip;
                                    false -> mod_scene:clear_dynamic_npc_from_scene_WNC(mod_npc:get_id(Npc))
                                end
                            end,
                            [F(X) || X <- HaveNpcObjList]
                    end,
                    {ok, NewGuild2}
            end
    end.

get_scene_npc_no_list(SceneId) ->
    NpcIdList = lib_scene:get_scene_dynamic_npc_ids(SceneId),
    F = fun(Id, Acc) ->
        case mod_npc:get_obj(Id) of
            null -> Acc;
            Npc -> 
                NpcNo = mod_npc:get_no(Npc),
                [NpcNo | Acc]
        end
    end,
    lists:foldl(F, [], NpcIdList).


get_scene_npc_obj_list(SceneId) ->
    NpcIdList = lib_scene:get_scene_dynamic_npc_ids(SceneId),
    F = fun(Id, Acc) ->
        case mod_npc:get_obj(Id) of
            null -> Acc;
            Npc -> 
                [Npc | Acc]
        end
    end,
    lists:foldl(F, [], NpcIdList).


add_liveness(GuildId, AddValue) ->
    Guild = get_info(GuildId),
    ?ASSERT(Guild /= null),
    NewGuild = Guild#guild{liveness = Guild#guild.liveness + AddValue},
    update_guild_to_ets(NewGuild).


add_guild_member_contri(PS, Contri, LogInfo) ->
    case Contri =< 0 of
        true ->
            ?ASSERT(false),
            fail;
        false ->
            PlayerId = player:id(PS),
            Mb = get_member_info(PlayerId),
            NewMb = Mb#guild_mb{contri = Mb#guild_mb.contri + Contri, left_contri = Mb#guild_mb.left_contri + Contri},
            NewMb1 = refresh_member_today(NewMb),
            NewMb2 = NewMb1#guild_mb{contri_today = NewMb1#guild_mb.contri_today + Contri, last_add_contri_time = svr_clock:get_unixtime()},
            update_member_to_ets(PlayerId, NewMb2),
            db_save_member(NewMb2),
            %% 货币统计
            lib_log:statis_produce_currency(PS, ?MNY_T_GUILD_CONTRI, Contri, LogInfo),
            KV_TupleList = [{?OI_CODE_GUILD_CONTRI, NewMb2#guild_mb.left_contri}],
            player:notify_cli_info_change(PS, KV_TupleList),
            ply_tips:send_sys_tips(PS, {add_contri, [Contri]}),
            {ok, NewMb2}
    end.

add_guild_member_contri1(PS, Contri, LogInfo) ->
    case Contri =< 0 of
        true ->
            ?ASSERT(false),
            fail;
        false ->
            PlayerId = player:id(PS),
            Mb = get_member_info(PlayerId),
            NewMb2 = Mb#guild_mb{contri = Mb#guild_mb.contri + Contri, left_contri = Mb#guild_mb.left_contri + Contri},
            % NewMb2 = NewMb1#guild_mb{contri_today = NewMb1#guild_mb.contri_today + Contri, last_add_contri_time = svr_clock:get_unixtime()},

            update_member_to_ets(PlayerId, NewMb2#guild_mb{is_dirty = true}),
            db_save_member(NewMb2),
            %% 货币统计
            % lib_log:statis_produce_currency(PS, ?MNY_T_GUILD_CONTRI, Contri, LogInfo),
            % KV_TupleList = [{?OI_CODE_GUILD_CONTRI, NewMb2#guild_mb.left_contri}],
            % player:notify_cli_info_change(PS, KV_TupleList),
            % ply_tips:send_sys_tips(PS, {add_contri, [Contri]}),
            {ok, NewMb2}
    end.


add_guild_member_donate(GuildMb, Value) ->
    GuildMb1 = 
        case ( (GuildMb#guild_mb.last_donate_time =:= 0) orelse (not util:is_same_day(GuildMb#guild_mb.last_donate_time)) ) of
            true -> 
                GuildMb#guild_mb{donate_today = Value, donate_total = GuildMb#guild_mb.donate_total + Value, last_donate_time = svr_clock:get_unixtime()};
            false ->
                GuildMb#guild_mb{donate_today = Value + GuildMb#guild_mb.donate_today, donate_total = GuildMb#guild_mb.donate_total + Value, last_donate_time = svr_clock:get_unixtime()}
        end,
    update_member_to_ets(GuildMb#guild_mb.id, GuildMb1),
    db_save_member(GuildMb1),
    {ok, GuildMb1}.


cost_guild_member_contri(PS, Contri, LogInfo) ->
    case Contri =< 0 of
        true ->
            skip;
        false ->
            PlayerId = player:id(PS),
            Mb = get_member_info(PlayerId),
            NewMb = Mb#guild_mb{left_contri = Mb#guild_mb.left_contri - Contri},
            update_member_to_ets(PlayerId, NewMb),
            db_save_member(NewMb),
            %% 货币统计
            lib_log:statis_consume_currency(PS, ?MNY_T_GUILD_CONTRI, Contri, LogInfo),
            KV_TupleList = [{?OI_CODE_GUILD_CONTRI, NewMb#guild_mb.left_contri}],
            player:notify_cli_info_change(PS, KV_TupleList),
            ply_tips:send_sys_tips(PS, {cost_contri, [Contri]})
    end.


%% 保存玩家的帮派信息到DB
db_save_guild_id(PlayerId, GuildId) ->
    db:update(PlayerId, player, ["guild_id"], [GuildId], "id", PlayerId).

db_save_leave_guild_time(PlayerId, LeaveGuildTime) ->
    db:update(PlayerId, player, ["leave_guild_time"], [LeaveGuildTime], "id", PlayerId).


try_record_login_player(PlayerId, Guild) when is_record(Guild, guild) ->
    ?ASSERT(lists:member(PlayerId, Guild#guild.member_id_list)),
    case lists:member(PlayerId, Guild#guild.login_id_list) of
        true ->
            skip;
        false ->
            gen_server:cast(?GUILD_PROCESS, {'record_login_player', PlayerId, Guild#guild.id})
    end;
try_record_login_player(PlayerId, GuildId) ->
    case get_info(GuildId) of
        null ->
            skip;
        Guild ->
            case lists:member(PlayerId, Guild#guild.login_id_list) of
                true ->
                    skip;
                false ->
                    gen_server:cast(?GUILD_PROCESS, {'record_login_player', PlayerId, GuildId})
            end
    end.


%% 清除所有帮派成员的帮派id 包括在线与非在线
clear_guild_id_of_member(Guild) ->
    LeaveGuildTime = util:unixtime(),
    MemberIdList = get_member_id_list(Guild),
    F = fun(PlayerId) ->
        lib_offcast:cast(PlayerId, {del_title, ?GUILD_TITLE_NO_NORMAL_MEMBER}),
        case Guild#guild.chief_id =:= PlayerId of
            true -> lib_offcast:cast(PlayerId, {del_title, ?GUILD_TITLE_NO_FIRST_CHIEF});
            false -> lib_offcast:cast(PlayerId, {del_title, ?GUILD_TITLE_NO_FIRST_GUILD})
        end,
        case mod_guild:decide_guild_pos(PlayerId, Guild) of
            ?GUILD_POS_CHIEF -> lib_offcast:cast(PlayerId, {del_title, ?GUILD_TITLE_NO_CHIEF});
            ?GUILD_POS_COUNSELLOR -> lib_offcast:cast(PlayerId, {del_title, ?GUILD_TITLE_NO_COUNSELLOR});
            ?GUILD_POS_SHAOZHANG -> lib_offcast:cast(PlayerId, {del_title, ?GUILD_TITLE_NO_SHAOZHANG});
            ?GUILD_POS_NORMAL_MEMBER -> skip;
            _ -> ?ASSERT(false), skip
        end,

        case player:get_PS(PlayerId) of
            null ->
                db_save_guild_id(PlayerId, ?INVALID_ID),
                db_save_leave_guild_time(PlayerId, LeaveGuildTime);
            PS ->
                db_save_guild_id(PlayerId, ?INVALID_ID),
                db_save_leave_guild_time(PlayerId, LeaveGuildTime),
                case player:is_online(PlayerId) of
                    true -> 
                        player:set_guild_id(PS, ?INVALID_ID),
                        player:set_leave_guild_time(PS, LeaveGuildTime);
                    false -> 
                        case ply_tmplogout_cache:get_tmplogout_PS(PlayerId) of
                            null -> skip;
                            TmplogoutPS -> ply_tmplogout_cache:set_guild_id(TmplogoutPS, ?INVALID_ID)
                        end
                end,
                lib_scene:notify_string_info_change_to_aoi(PlayerId, [{?OI_CODE_GUILDNAME, <<>>}])
        end
    end,
    lists:foreach(F, MemberIdList).


on_job_schedule() ->
    set_job_schedule(24*3600), %% 放到最前面，防止下面的代码异常而没有投递下一个作业计划
    %% 决定帮派争霸赛比赛分组
    
    Week = util:get_week(),
    case Week =:= 5  andalso mod_guild_mgr:get_guild_war_round() =:= 0 of
        false -> skip;
        true -> mod_guild_mgr:decide_guild_war_group()
    end,

    %% 清空帮派争霸赛轮数
    case Week =:= 1 of
        false -> skip;
        true ->
            Counter = mod_guild_mgr:get_guild_war_counter(),
            case Counter =:= 0 of
                true ->  
                    mod_guild_mgr:set_guild_war_round(0),
                    mod_guild_mgr:db_save_guild_war();
                false -> %% 容错
                    case Counter >= mod_guild_mgr:get_guild_war_round() of
                        false -> skip;
                        true ->
                            ?CRITICAL_MSG("mod_guild:on_job_schedule:{Counter,Round}:~w~n", [{Counter,mod_guild_mgr:get_guild_war_round()}]),
                            mod_guild_mgr:set_guild_war_counter(0),
                            mod_guild_mgr:set_guild_war_round(0),
                            mod_guild_mgr:db_save_guild_war()
                    end
            end
    end,

    GuildList = get_guild_list(),
    F = fun(Guild) ->
        %% 扣除消耗 : +系统发放 - 日维护费用
        %% 清空活跃度
        case data_guild_lv:get(Guild#guild.lv) of
            null -> skip;
            Data ->
                {ok, Guild0} = del_prosper(Guild, Data#guild_lv_data.upkeep),

                Now = svr_clock:get_unixtime(),
                DayChiefNotLogin = 
                    case Guild0#guild.chief_last_login_time =:= 0 of
                        true -> 0;
                        false -> util:ceil((Now - Guild0#guild.chief_last_login_time) / 3600)
                    end,
                Guild1 = 
                    case DayChiefNotLogin >= 3 of
                        false -> Guild0;
                        true ->
                            NewChiefId = get_contri_max_member_id(Guild0),
                            %% 邮件通知 todo
                            Guild0#guild{chief_id = NewChiefId}
                    end,

                Rate = 
                    case length(Guild1#guild.member_id_list) > 0 of
                        true -> length(Guild1#guild.login_id_list) / length(Guild1#guild.member_id_list);
                        false -> 0
                    end,
                case Rate > 0.2 of
                    true ->
                        %% 发工资
                        try_give_pay(Guild1, Data),
                        
                        NewGuild = Guild1#guild{login_id_list = [], state = ?GUILD_STATE_NORMAL, liveness = 0},
                        update_guild_to_ets(NewGuild);
                    false ->
                        Day = util:ceil((Now - Guild1#guild.mark_frozen_time) / 3600),
                        if
                            (Guild1#guild.state =:= ?GUILD_STATE_UNACTIVE) andalso (Now - Guild1#guild.mark_unactive_time > 3600 * 3) -> %% 如果当帮派处于非活跃状态连续达到 3 天 则帮派处于冻结状态
                                NewGuild = Guild1#guild{login_id_list = [], state = ?GUILD_STATE_FROZEN, mark_frozen_time = svr_clock:get_unixtime()},
                                %% 发工资
                                try_give_pay(NewGuild, Data),
                                
                                update_guild_to_ets(NewGuild#guild{liveness = 0}),
                                spawn(fun() -> send_mail_to_leader(NewGuild#guild.chief_id, NewGuild#guild.counsellor_id_list) end);
                            Guild1#guild.state =:= ?GUILD_STATE_NORMAL andalso Guild1#guild.mark_unactive_time =:= 0 ->
                                NewGuild = Guild1#guild{login_id_list = [], state = ?GUILD_STATE_UNACTIVE, mark_unactive_time = svr_clock:get_unixtime()},
                                %% 发工资
                                try_give_pay(NewGuild, Data),
                                
                                update_guild_to_ets(NewGuild#guild{liveness = 0});
                            Guild1#guild.state =:= ?GUILD_STATE_FROZEN andalso (Day rem 2 =:= 0) -> %% 降级
                                NewLv = Guild1#guild.lv - 1,
                                case NewLv =< 0 of
                                    false ->
                                        NewGuild = Guild1#guild{login_id_list = [], lv = NewLv},
                                        %% 发工资
                                        try_give_pay(NewGuild, Data),
                                        
                                        update_guild_to_ets(NewGuild#guild{liveness = 0});
                                    true -> %% 解散帮派
                                        case mod_guild_mgr:war_allow_disband(Guild1#guild.id) of
                                            true ->
                                                sys_disband_guild(Guild1);
                                            false ->
                                                NewGuild = Guild1#guild{login_id_list = [], lv = NewLv, liveness = 0},
                                                update_guild_to_ets(NewGuild)
                                        end
                                end;
                            Guild1#guild.lv =< 0 ->
                                case mod_guild_mgr:war_allow_disband(Guild1#guild.id) of
                                    true ->
                                        sys_disband_guild(Guild1);
                                    false ->
                                        skip
                                end;
                            true ->
                                % ?WARNING_MSG("mod_guild:on_job_schedule error!~w~n", [Guild1]),
                                try_give_pay(Guild1, Data),
                                NewGuild = Guild1#guild{login_id_list = [], liveness = 0},
                                update_guild_to_ets(NewGuild)
                        end
                end
        end
    end,

    lists:foreach(F, GuildList).


set_job_schedule() ->
    DelayTime = 24*3600 - (util:unixtime() - util:calc_today_0_sec()) + 2, %% 延迟60秒，减轻服务器压力
    mod_sys_jobsch:add_schedule(?JSET_AUDIT_GUILD_STATE, DelayTime, []).


set_job_schedule(DelayTime) ->
    mod_sys_jobsch:add_schedule(?JSET_AUDIT_GUILD_STATE, DelayTime, []).

%% Data -> cfg
try_give_pay(Guild, Data) ->
    case Guild#guild.liveness >= Data#guild_lv_data.liveness of
        true -> update_guild_member_pay(Guild, true);
        false -> 
            update_guild_member_pay(Guild, false),
            spawn(fun() -> send_mail_to_all(Guild#guild.member_id_list) end)
    end.

% 判定玩家在帮派中的职位
% @para: GuildId => 玩家所属的帮派id
% @return: 帮派职位代号
decide_guild_pos(PlayerId, GuildId) when is_integer(GuildId) ->
    Guild = mod_guild:get_info(GuildId),
    case Guild =:= null of
        true -> 
            ?ERROR_MSG("mod_guild:data error PlayerId:~p, GuildId:~p", [PlayerId, GuildId]),
            ?GUILD_POS_INVALID;
        false -> decide_guild_pos(PlayerId, Guild)
    end;
decide_guild_pos(PlayerId, Guild) ->
     % 是否帮主？
     case PlayerId =:= mod_guild:get_chief_id(Guild) of
          true ->
               ?GUILD_POS_CHIEF;
          false ->
              case lists:member(PlayerId, get_counsellor_id_list(Guild)) of
                  true ->
                      ?GUILD_POS_COUNSELLOR;
                  false ->
                      case lists:member(PlayerId, get_shaozhang_id_list(Guild)) of
                          true ->
                              ?GUILD_POS_SHAOZHANG;
                          false -> 
                              ?GUILD_POS_NORMAL_MEMBER
                      end
              end
     end.


%% 数据容错，避免数据库超时引起数据不一致 帮派进程调用
correct_guild_id(PlayerId, GuildId) ->
    case GuildId =:= ?INVALID_ID of
        true -> 
            case get_member_info(PlayerId) of
                null -> skip;
                _ -> 
                    del_member_from_ets_by_mb_id(PlayerId),
                    db_delete_guild_member_by_mb_id(PlayerId)
            end,
            GuildId;
        false ->
            case get_info(GuildId) of
                null -> 
                    case get_member_info(PlayerId) of
                        null -> skip;
                        _ ->
                            del_member_from_ets_by_mb_id(PlayerId),
                            db_delete_guild_member_by_mb_id(PlayerId)
                    end,
                    ?INVALID_ID;
                _Guild ->
                    case get_member_info(PlayerId) of
                        null -> ?INVALID_ID;
                        _GuildMb -> GuildId
                    end
            end
    end.


notify_player_join_guild(Guild, PlayerName) ->
    {ok, BinData} = pt_40:write(?PT_NOTIFY_JOINED_GUILD, [Guild#guild.id, PlayerName, Guild#guild.name]),
    MemberList = mod_guild:get_member_id_list(Guild),
    [lib_send:send_to_uid(PlayerId, BinData) || PlayerId <- MemberList, player:is_online(PlayerId)].



%% 获取玩家在帮派中职位
%% 初始化玩家的帮派信息后，便可以通过下面接口直接获取玩家在帮派的职位：
get_guild_pos(PlayerId) when is_integer(PlayerId) ->
     MbInfo = get_member_info(PlayerId),
     ?ASSERT(MbInfo /= null),
     MbInfo#guild_mb.position;
get_guild_pos(PS) ->
     ?ASSERT(player:is_in_guild(PS)),  % 断言玩家已经加入了帮派
     MbInfo = get_member_info( player:id(PS)),
     ?ASSERT(MbInfo /= null),
     MbInfo#guild_mb.position.


% 帮派战力=
% 帮派累计繁荣度*（1+当前帮派人数÷该等级帮派可加入最大人数）+ 
% 全体各成员VIP等级评分之和 ÷ 该等级帮派可加入最大人数 + 
% 全体成员战力之和 ÷ 该等级帮派可加入最大人数 ÷ 100；
calc_battle_power(Guild) ->
    ProsperNow = 
        case Guild#guild.lv >= ?MIN_GUILD_LV of
            false -> get_prosper(Guild);
            true -> 
                F = fun(Lv, Sum) ->
                    case data_guild_lv:get(Lv) of
                        null -> Sum;
                        Data -> Data#guild_lv_data.need_prosper + Sum
                    end
                end,
                Total = lists:foldl(F, 0, lists:seq(1, Guild#guild.lv)),
                Total + get_prosper(Guild)
        end,
    Capacity = 
        case data_guild_lv:get(Guild#guild.lv) of
            null -> ?ASSERT(false), 20;
            CurData -> CurData#guild_lv_data.capacity
        end,
    F1 = fun(Id, {Sum1, Sum2}) ->
        case player:get_PS(Id) of
            null ->
                case ply_tmplogout_cache:get_tmplogout_PS(Id) of
                    null -> 
                        case mod_offline_data:get_offline_role_brief(Id) of
                            null ->
                                {Sum1, Sum2};
                            OfflineRoleBrief ->
                                Add = 
                                    case data_guild_vip_score:get(OfflineRoleBrief#offline_role_brief.vip_lv) of
                                        null -> 0;
                                        DataScore -> DataScore#guild_vip_score.score
                                    end,
                                {Sum1 + Add, Sum2 + OfflineRoleBrief#offline_role_brief.battle_power}
                        end;
                    TPS ->
                        Add = 
                            case data_guild_vip_score:get(player:get_vip_lv(TPS)) of
                                null -> 0;
                                DataScore -> DataScore#guild_vip_score.score
                            end,
                        {Sum1 + Add, Sum2 + ply_attr:get_battle_power(TPS)}
                end;
            PS ->
                Add = 
                    case data_guild_vip_score:get(player:get_vip_lv(PS)) of
                        null -> 0;
                        DataScore -> DataScore#guild_vip_score.score
                    end,
                {Sum1 + Add, Sum2 + ply_attr:get_battle_power(PS)}
        end
    end,

    {VipLvScoreSum, BattlePowerSum} = lists:foldl(F1, {0,0}, get_member_id_list(Guild)),

    BattlePower = util:ceil(ProsperNow * (1 + get_guild_member_count(Guild) / Capacity) + VipLvScoreSum / Capacity + BattlePowerSum / Capacity / 100),
    mod_rank:guild_battle_power({Guild#guild.id, Guild#guild.name, Guild#guild.lv, BattlePower}),
	CurMbCount = length(Guild#guild.member_id_list),
	MbCapacity = mod_guild:get_capacity_by_guild_lv(Guild#guild.lv),
	MemberStr = util:to_binary(lists:concat([CurMbCount, "/",MbCapacity])),
    mod_rank:guild_battle_prosper({Guild#guild.id, Guild#guild.name, Guild#guild.lv, player:get_name(Guild#guild.chief_id), MemberStr, ProsperNow}),
    BattlePower.


%% -----------------------------------------------------------Local Fun-----------------------------------------------------------------


change_lv_by_prosper(CurLv, CurProsper) ->
    Lim = get_prosper_lim(CurLv + 1),
    case CurProsper < Lim of
        true ->
            {CurLv, CurProsper};
        _ ->
            change_lv_by_prosper(CurLv + 1, CurProsper - Lim)
    end.

set_lv(Guild, Lv) ->
    Guild#guild{lv = Lv}.


%% 刷新帮派当天的获得的繁荣度
refresh_prosper_today(Guild) ->
    LastAddProsperTime = get_last_add_prosper_time(Guild),
    case ( (LastAddProsperTime =:= 0) orelse (not util:is_same_day(LastAddProsperTime)) ) of
        true -> 
            set_prosper_today(Guild, 0);
        false ->
            Guild
    end.


%% 刷新帮派成员当天的贡献
refresh_member_today(Member) ->
    LastAddContriTime = Member#guild_mb.last_add_contri_time,
    case ( (LastAddContriTime =:= 0) orelse (not util:is_same_day(LastAddContriTime)) ) of
        true -> 
            Member#guild_mb{contri_today = 0};
        false ->
            Member
    end.


sort_member(MemberList, Type_SortBy) ->
    F = case Type_SortBy of
        sort_by_contri -> fun(M1, M2) -> M1#guild_mb.left_contri > M2#guild_mb.left_contri end;                    
        _Any -> skip
    end,
    lists:sort(F, MemberList).


get_contri_max_member_id(Guild) ->
    MemberList = get_member_info_list(Guild#guild.id),
    MbListSort = sort_member(MemberList, sort_by_contri),
    case MbListSort =:= [] of
        true -> 
            ?ASSERT(false),
            ?INVALID_ID;
        false ->
            Mb = erlang:hd(MbListSort),
            Mb#guild_mb.id
    end.

% create_guild_copy(Guild) ->
%     SceneNo = (data_guild_lv:get(Guild#guild.lv))#guild_lv_data.scene_no,
%     {ok, NewSceneId} = mod_scene:create_scene(SceneNo),
%     NewGuild = Guild#guild{scene_id = NewSceneId},
%     update_guild_to_ets(NewGuild).


%         增幅                            
% 1~30级   50  基本工资=(1~30级增幅)*等级*(5+帮派等级)                          
% 31~49级  30  基本工资=( 30*(1~30级增幅)+(等级-30)*(31~49增幅) ) * (5+帮派等级)                          
% 50~69级  20  基本工资=( 30*(1~30级增幅)+(49-30)*(31~49增幅)+(等级-49)*(50~69级增幅) ) * (5+帮派等级) 
% 70~89级  5   基本工资=( 30*(1~30级增幅)+(49-30)*(31~49增幅)+(69-49)*(50~69增幅)+(等级-69)*(70~89级增幅) )*(5+帮派等级)                         

% 90~150   2   基本工资=(30*(1~30级增幅)+(49-30)*(31~49增幅)+(69-49)*(50~69增幅)+(89-69)*(70~89级增幅)+(等级-89)*(90~150等级增幅))*(5+帮派等级)                          

get_base_pay(GuildLv, PlayerLv) ->
    if
        1 =< PlayerLv andalso PlayerLv =< 30 ->
            50 * PlayerLv * (5 + GuildLv);
        31 =< PlayerLv andalso PlayerLv =< 49 ->
            (30 * 50 + (PlayerLv - 30) * 30) * (5 + GuildLv);
        50 =< PlayerLv andalso PlayerLv =< 69 ->
            (30 * 50 + (49 - 30) * 30 + (PlayerLv - 49) * 20) * (5 + GuildLv);
        70 =< PlayerLv andalso PlayerLv =< 89 ->
            (30 * 50 + (49 - 30) * 30 + (69 - 49) * 20 + (PlayerLv - 69) * 5) * (5 + GuildLv);
        90 =< PlayerLv andalso PlayerLv =< 150 ->
            (30 * 50 + (49 - 30) * 30 + (69 - 49) * 20 + (89 - 69) * 5 + (PlayerLv - 89) * 2) * (5 + GuildLv);
        true ->
            0
    end.


get_position_pay(GuildMb) ->
    case GuildMb#guild_mb.position of
        ?GUILD_POS_CHIEF -> 10000;
        ?GUILD_POS_COUNSELLOR -> 6000;
        ?GUILD_POS_SHAOZHANG -> 4000;
        ?GUILD_POS_NORMAL_MEMBER -> 1500;
        _Any -> 0
    end.


get_contri_coef(Contri) ->
    get_contri_coef(Contri, data_guild_contri_coef:get_all_step_list()).


get_contri_coef(_Contri, []) ->
    0;
get_contri_coef(Contri, [H | T]) ->
    DataList = data_guild_contri_coef:get(H),
    Data = erlang:hd(DataList),
    case util:in_range(Contri, lists:nth(1, Data#guild_contri_coef.range), lists:nth(2, Data#guild_contri_coef.range)) of
        true -> Data#guild_contri_coef.coef;
        false -> get_contri_coef(Contri, T)
    end.


%% 贡献度薪资=4级帮派对应的基本工资*档次系数*0.3       
get_contri_pay(GuildMb) ->
    Coef = get_contri_coef(GuildMb#guild_mb.left_contri),
    util:ceil(get_base_pay(4, GuildMb#guild_mb.lv) * Coef * 0.3).


get_contri_rank_pay(GuildLv, GuildMb, MbListSort) ->
    Data = data_guild_lv:get(GuildLv),
    List = lists:sublist(MbListSort, 1, Data#guild_lv_data.rank_need),
    case lists:member(GuildMb, List) of
        false -> 0;
        true ->  Data#guild_lv_data.rank_pay
    end.


%% 考虑是否有性能问题 顺便把当日贡献清0 、当天银子捐献数量，每日0点调用
update_guild_member_pay(Guild, Grant) ->
    MemberList = get_member_info_list(Guild#guild.id),
    MbListSort = 
        case Grant of
            true -> sort_member(MemberList, sort_by_contri);
            false -> MemberList
        end,
    GuildLv = Guild#guild.lv,
    F = fun(X, Acc) ->
        {PayList, Flag} = 
            case Grant of
                true ->
                    {
                    [
                        {get_base_pay(GuildLv, X#guild_mb.lv), 0},
                        {get_position_pay(X), 0},
                        {get_contri_pay(X), 0},
                        {get_contri_rank_pay(GuildLv, X, MbListSort), 0}
                    ],
                    true
                    };
                false ->
                    {
                    [
                        {0, 0},
                        {0, 0},
                        {0, 0},
                        {0, 0}
                    ],
                    false
                    }
            end,
        
        DonateToday = get_mb_donate_today(X),
        NewGuildMb = X#guild_mb{pay_today = PayList, donate_today = DonateToday, is_dirty = true},
        NewGuildMb1 = refresh_member_today(NewGuildMb),
        update_member_to_ets(X#guild_mb.id, NewGuildMb1),
        % db_save_member(NewGuildMb),这里去掉及时保存数据库，因为此时的数据量比较大，容易导致数据库超时
        case Flag of
            true -> [NewGuildMb1 | Acc];
            false -> Acc
        end
    end,
    MbListNew = lists:foldl(F, [], MbListSort),
    spawn(fun() -> notify_pay_can_get(MbListNew) end).
    


notify_guild_info_change(Guild, KV_TupleList) ->
    ?ASSERT(util:is_tuple_list(KV_TupleList)),
    SendMail = 
        case lists:keyfind(guild_lv, 1, KV_TupleList) of
            false -> false;
            {guild_lv, _} -> true
        end,

    {ok, BinData} = pt_40:write(?PT_NOTIFY_GUILD_INFO_CHANGE, KV_TupleList),
    Title = <<"帮派通知">>,
    Content = list_to_binary(io_lib:format(<<"亲爱的帮派成员们\n您的帮派由~p级变为~p级">>, [Guild#guild.lv - 1, Guild#guild.lv])),
    F = fun(Id) ->
        case SendMail of
            false -> skip;
            true -> lib_mail:send_sys_mail(Id, Title, Content, [], [?LOG_MAIL, "recv_guild"])
        end,
        case player:is_online(Id) of
            false -> skip;
            true ->
                case player:get_PS(Id) of
                    null -> skip;
                    PS -> lib_send:send_to_sock(PS, BinData)
                end
        end
    end,
    lists:foreach(F, Guild#guild.member_id_list).


notify_pay_can_get(MbList) ->
    F = fun(Member) ->
        case player:get_PS(Member#guild_mb.id) of
            null -> skip;
            PS ->
                {ok, BinData} = pt_40:write(?PT_QUERY_GUILD_PAY, Member#guild_mb.pay_today), 
                lib_send:send_to_sock(PS, BinData)
        end
    end,
    [F(X) || X <- MbList].


send_mail_to_leader(ChiefId, CounsellorIdList) ->
    Title = <<"帮派通知">>,
    Content = list_to_binary(io_lib:format(<<"您的帮派不够活跃，如果长期活跃不够将被降级！">>, [])),
    lib_mail:send_sys_mail(ChiefId, Title, Content, [], [?LOG_MAIL, "recv_guild"]),
    F = fun(X) ->
        lib_mail:send_sys_mail(X, Title, Content, [], [?LOG_MAIL, "recv_guild"])
    end,
    [F(X) || X <- CounsellorIdList].


send_mail_to_all(MbIdList) ->
    Title = <<"帮派通知">>,
    Content = list_to_binary(io_lib:format(<<"亲爱的帮派成员们，今天帮派活跃不够无法领取工资！">>, [])),
    F = fun(X) ->
        lib_mail:send_sys_mail(X, Title, Content, [], [?LOG_MAIL, "recv_guild"])
    end,
    [F(X) || X <- MbIdList].


sys_disband_guild(Guild) ->
    ?CRITICAL_MSG("mod_guild:sys_disband_guild GuildId:~p,GuildName:~p, Lv:~p~n", [Guild#guild.id, Guild#guild.name, Guild#guild.lv]),
    %% 优先返还相关的投标信息
    case lib_guild:get_guild_war_from_ets(Guild#guild.id) of
        null -> skip;
        Guildwar -> 
            mod_guild_mgr:refund_to_player([Guildwar], guild_disband),
            lib_guild:del_guild_war_from_ets(Guild#guild.id)
    end,

    clear_guild_id_of_member(Guild),
    del_member_from_ets_by_guild(Guild),
    del_guild_from_ets(Guild#guild.id),
    
    db_delete_guild(Guild#guild.id),
    db_delete_guild_member_by_guild_id(Guild#guild.id),
    mod_guild_mgr:update_guild_rank(),
    case Guild#guild.scene_id =:= ?INVALID_ID of
        true -> skip;
        false -> 
            case lib_scene:get_obj(Guild#guild.scene_id) of
                null ->
                    ?ASSERT(false, Guild#guild.scene_id),
                    skip;
                _SceneObj ->
                    mod_scene:clear_scene(Guild#guild.scene_id)
            end
    end,
    lib_log:statis_guild_pasi_diss(Guild#guild.id, Guild#guild.lv),
    mod_guild_mgr:notify_guild_disband(Guild).


get_mb_donate_today(GuildMb) ->
    case GuildMb#guild_mb.last_donate_time =:= 0 of
        true -> GuildMb#guild_mb.donate_today;
        false ->
            case util:is_same_day(GuildMb#guild_mb.last_donate_time) of
                true -> GuildMb#guild_mb.donate_today;
                false -> 0
            end
    end.

% % 设置加入帮派时间
% set_join_guild_time(PS,Time) ->
  
%   .
% % 获取加入帮派时间
% get_join_guild_time(PS) ->