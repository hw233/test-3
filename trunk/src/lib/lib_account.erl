%%%--------------------------------------
%%% @Module  : lib_account
%%% @Author  :
%%% @Email   :
%%% @Created : 2011.05.10
%%% @Description:用户账户处理
%%%--------------------------------------
-module(lib_account).
-export([
		% db_get_first_accid_by_accname/1,
        to_global_uni_id/1,
        is_global_uni_id/1,
        to_local_id/1,
        db_is_account_exists/1,

        db_insert_new_account/1,
		% add_user_info_guest/2,
        db_load_player_base_info/1,
		% get_accidname_by_role_id/1,

        %%get_role_list/1,
        db_get_role_list/1,

        create_role/3,
        discard_role/2,
        retrieve_role/1,
        db_get_discard_role_times/1,
        db_update_discard_role_times/2,
        login_limit_check/0,

        new_role_name_legal/1,
        db_get_role_name_by_id/1
    ]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("goods.hrl").
-include("abbreviate.hrl").
-include("pt_10.hrl").
-include("account.hrl").
-include("inventory.hrl").
-include("partner.hrl").
-include("faction.hrl").
-include("phone.hrl").




%% 检测新角色名是否合法
%% @return: true | {false, Reason}
new_role_name_legal(Name) ->
    ?ASSERT(is_list(Name)),
    try new_role_name_legal__(Name) of
        true ->
            true
    catch
        throw: IllegalReason ->
            {false, IllegalReason}
    end.







%% 数据库中检测指定名称的角色是否已存在
db_is_role_name_exists(Name) ->
    case db_get_role_id_by_name(Name) of
        null -> false;
        _Id -> true
    end.




%% 数据库中根据角色名获取角色id
%% @return: null | 角色id
db_get_role_id_by_name(Name) ->
    db:select_one(player, "id", [{nickname,Name}], [], [1]).


%% 数据库中根据角色id获取角色名
%% @return: null | 角色名（bitstring类型）
db_get_role_name_by_id(PlayerId) ->
    db:select_one(player, "nickname", [{id, PlayerId}], [], [1]).




% %% 获得新的accid
% get_account_id() ->
% 	NewAccId = db:replace_get_id(account, [{stub,"a"}]),
% 	%%?DEBUG_MSG("get_account_id(), new acc id is: ~p!!", [NewAccId]),
% 	NewAccId.

%% 作废！！
%% 根据帐号名获取第一个帐号Id（合服后一个账户名可能对应有多个账户id，此接口只获取其中一个）
%% 返回值：null - 找不到；Accid - 帐号Id
% db_get_first_accid_by_accname(Accname) ->
% 	db:select_one(account, "accid", [{accname,Accname}], [], [1]).  % TODO: 添加order by条件




%% 根据账户名判断对应账户是否存在
%% @return: true | false
db_is_account_exists(AccName) ->
    case db:select_one(account, "accname", [{accname,AccName}]) of
        null ->
            false;
        _AccName ->
            ?TRACE("[lib_account] db_is_account_exists(), _AccName:~p~n", [_AccName]),
            true
    end.







%% 添加user信息(添加新账号到数据库)
%%add_user_info(Accid, Accname) ->
%%	db:insert(user, [accid, accname, idcard_status], [Accid, Accname, 0]).

%% 插入新账户到数据库，返回所插入的新账户记录的id
db_insert_new_account(AccName) ->
    %%db:insert(user, [accname], [AccName]).
    db:insert_get_id(account, [accname], [AccName]).




% %% 添加user信息（游客模式）
% add_user_info_guest(Accid, Accname) ->
% 	db:insert(user, [accid, accname, idcard_status], [Accid, Accname, 3]).

%% 依据玩家id从数据库加载玩家基础信息
db_load_player_base_info(PlayerId) ->  %%get_info_by_id(PlayerId) ->
    db:select_row(player, "accname,"
                          "nickname,"
                          "scene_type,"
                          "scene_id,"
                          "x,"
                          "y,"

                          "priv_lv,"

                          "race,"
                          "faction,"
                          "sex,"
                          "lv,"
                          "exp,"

                          "hp,"
                          "mp,"
                          "yuanbao,"
                          "bind_yuanbao,"
                          "gamemoney,"
                          "bind_gamemoney,"
                          "integral,"
                          "copper,"
				          "jingwen,"
                          "dan,"
                          "mijing,"
                          "huanjing,"
                          "chivalrous,"
                          "vitality,"

                          "bag_eq_capacity,"
                          "bag_usable_capacity,"
                          "bag_unusable_capacity,"
                          "storage_capacity,"
                          "guild_id,"
                          "guild_attrs,"
                          "cultivate_attrs,"

                          "base_talents,"
                          "free_talent_points,"
                          %%"newbie_guide_step,"
                          "last_logout_time,"

                          "vip_lv,"
                          "vip_exp,"
                          "vip_active_time,"
                          "vip_expire_time,"
                          "daily_reset_time,"
                          "weekly_reset_time,"

                          "team_target_type,"
                          "team_condition1,"
                          "team_condition2,"
                          "partner_capacity,"
                          "fight_par_capacity,"

                          "prev_pos,"
                          "dun_info,"
                          "feat,"
                          "store_hp,"
                          "store_mp,"
                          "store_par_hp,"
                          "store_par_mp,"

                          "create_time,"
                          "update_mood_count,"
                          "last_update_mood_time,"
                          "accum_online_time,"
                          "literary,"
                          "literary_clear_time,"
                          "recharge_state,"
                          "month_card_state,"
                          "first_recharge_reward_state,"
                          "recharge_accum,"
                          "consume_state,"
                          "admin_acitvity_state,"
                          "yuanbao_acc,"
                          "exp_slot,"
                          "local_id,"
                          "opened_sys,"
                          "xs_task_issue_num,"
                          "xs_task_left_issue_num,"
                          "xs_task_receive_num,"
                          "one_recharge_reward,"
                          "zf_state,"
                          "contri,"
                          "recharge_accum_day,"
                          "mount,"
                          "last_transform_time,"
                          "day_transform_times,"
                          "jingmai_infos,"
                          "jingmai_point,"
				 		  "first_recharge_reward,"
				 		  "login_reward_day,"
				 		  "login_reward_time,"
                          "leave_guild_time,"
                          "peak_lv,"
                          "reincarnation,"
                          "unlimited_resources,"
				 		  "faction_skills",
						[{id,PlayerId}], [], [1]).

% %% 通过玩家id取得帐号id和名
% get_accidname_by_role_id(PlayerId) ->
% 	db:select_row(player, "accid, accname", [{id,PlayerId}], [], [1]).

%% 取得指定帐号的角色列表
%%get_role_list(Name) ->
%%    db:select_all(player, "id, status, nickname, sex, lv, career", [{accname,Name}]).



%% 依据账户名获取账户下的角色列表
%% @return: fail | {ok, RetInfo}, 其中RetInfo形如：[] | [ [xx,xx,..], [xx,xx,..], ...]
db_get_role_list(AccName) ->
    try 
        RetInfo = db:select_all(player, "id, local_id, from_server_id, is_banned, vip_lv, vip_expire_time, nickname, race, faction, sex, lv", [{accname,AccName}, {is_discarded, 0}]),
        {ok, RetInfo}
    catch
        _:Reason ->
            ?ERROR_MSG("db_get_role_list() failed!! AccName:~p, Reason:~w", [AccName, Reason]),
            fail
    end.





% %% 通过玩家Accid取得VIP等级信息
% get_vip_info_by_id(Accid) ->
%     db:select_row(player, "vip, vip_time", [{accid,Accid}], [], [1]).










%% 创建角色
%% @return: {ok, NewRoleId, NewRoleLocalId} | fail
create_role(AccName, Data, FromServerId) ->
	%% 现在种族当做门派了20191207 zjy
	[Race, Sex, Name] = Data,
	case data_faction:get(Race) of
		FactionData when is_tuple(FactionData) ->
			?ASSERT(is_list(Name), Name),
			?ASSERT(Race =< ?RACE_MAX),
			{SceneId, X, Y} = ply_scene:get_born_place(Race),
			BornSceneType = ply_scene:get_born_scene_type(Race),
			TimeNow = svr_clock:get_unixtime(),
			% 默认参数
			BagEQCapacity = ?DEF_BAG_EQ_CAPACITY,
			StorageCapacity = ?DEF_STORAGE_CAPACITY,
			BagUSCapacity = ?DEF_BAG_USABLE_CAPACITY,
			BagUNUSCapacity = ?DEF_BAG_UNUSABLE_CAPACITY,
			
			% 计算出生时的基础属性
			BornTalents = ply_attr:get_born_talents(Race),
			BornAttrs = ply_attr:calc_born_base_attrs(Race, BornTalents),
			BornHp = BornAttrs#attrs.hp_lim,
			BornMp = BornAttrs#attrs.mp_lim,
			
			% BS: bitstring
			BaseTalents_BS = player:build_talents_bitstring(BornTalents),
			%%%SysSet_BS = util:term_to_bitstring(#sys_set{}), %系统设置
			try
				NewRoleLocalId = db:insert_get_id(player,
												  ["accname", "nickname", "race", "faction", "sex", "lv", "create_date", "create_time", "from_server_id", "scene_type", "scene_id", "x", "y", "hp", "mp",
												   "bag_eq_capacity", "storage_capacity", "bag_usable_capacity", "bag_unusable_capacity", "base_talents", "partner_capacity", "fight_par_capacity", "store_hp", 
												   "store_mp", "store_par_hp", "store_par_mp", "literary_clear_time", "zf_state", "contri"],
												  [AccName, Name, Race, Race, Sex, ?PLAYER_BORN_LV, util:today_date(), TimeNow, FromServerId, BornSceneType, SceneId, X, Y, BornHp, BornMp,
												   BagEQCapacity, StorageCapacity, BagUSCapacity, BagUNUSCapacity, BaseTalents_BS, ?PAR_CARRY_DEFAULT, ?PAR_FIGHT_DEFAULT, 1, 1, 1, 1, TimeNow, ply_zf:build_init_zf_bitstring(),0]
												 ),
				
				NewRoleId = to_global_uni_id(NewRoleLocalId),
				db:update(player, ["id"], [NewRoleId], "local_id", NewRoleLocalId),
				
				% 赠送物品
				give_goods_to_new_role(NewRoleId, Race, Sex),
				
				% 初始化推广码
				{ok, CDK8} = mod_cdk:gen_cdk_8(),
				ply_sprd:db_init_sprd_code(NewRoleId, CDK8),
				mod_global_data:add_player_id(NewRoleId),
				?TRACE("create role success, Race:~p, NewRoleId:~p, NewRoleLocalId:~p~n", [Race, NewRoleId, NewRoleLocalId]),
				{ok, NewRoleId, NewRoleLocalId}
			catch
				_:Reason ->
					?ERROR_MSG("[lib_account] create_role() failed!!! AccName:~p, Data:~p, Reason:~w StackTrace : ~p", [AccName, Data, Reason, erlang:get_stacktrace()]),
					?ASSERT(false),
					fail
			end;
		_ ->
			?ERROR_MSG("crreate role race err : ~p", [{AccName, Data, FromServerId}]),
			fail
	end.



%% 计算对应的全局唯一id
%% 玩家的全局唯一id形如：001000100000000001（十进制），其中前三位数表示平台号，后续4位数表示平台内的服务器编号，最后的11位数字表示服务器内的流水号
to_global_uni_id(LocalId) ->
  ServerId = config:get_server_id(),
  ?TRACE("to_global_uni_id(), ServerId:~p~n", [ServerId]),
  ?TRACE("to_global_uni_id(), ServerId:~p~n", [ServerId]),
  ServerId * 100000000000 + LocalId.


is_global_uni_id(Id) ->
    case Id =:= ?INVALID_ID of
        true -> true;
        false ->
            ServerId = config:get_server_id(),
            Id >= ServerId * 100000000000 + 1
    end.

to_local_id(GlobalId) ->
    ServerId = config:get_server_id(),
    case GlobalId < ServerId * 100000000000 + 1 of
        true -> GlobalId;
        false -> GlobalId rem (ServerId * 100000000000)
    end.

%% 删除角色
discard_role(RoleId, PhoneInfo) ->
    Date = util:today_date(),
    PhoneModel = lists:sublist(PhoneInfo#phone_info.model, ?MAX_PHONE_MODEL_STR_LEN),
    PhoneMAC = lists:sublist(PhoneInfo#phone_info.mac, ?MAX_PHONE_MAC_STR_LEN),
    ?DEBUG_MSG("discard_role(), RoleId:~p, PhoneInfo:~w, PhoneModel:~p, PhoneMAC:~p", [RoleId, PhoneInfo, PhoneModel, PhoneMAC]),
    db:update(player,
              ["is_discarded", "discard_date", "discard_phone_model", "discard_phone_mac"],
              [1, Date, PhoneModel, PhoneMAC],
              "id",
              RoleId
              ),
    ok.

%% 恢复角色
retrieve_role(RoleId) ->
    Date = util:today_date(),
    db:update(player,
              ["is_discarded", "retrieve_date"],
              [0, Date],
              "id",
              RoleId
              ),
    ok.




%% 获取删除角色的次数
db_get_discard_role_times(AccName) ->
    case db:select_one(account, "discard_role_times", [{accname,AccName}]) of
        null ->
            0;
        Val ->
            ?ASSERT(util:is_nonnegative_int(Val), Val),
            Val
    end.

%% 更新删除角色的次数
db_update_discard_role_times(AccName, NewTimes) ->
    db:update(account,
              ["discard_role_times"],
              [NewTimes],
              "accname",
              AccName
              ).


% %% 删除角色
% %% old name: delete_role(RoleId, _Accname) ->
% %% TODO: 调整删除角色的处理！！！！
% discard_role(_RoleId, _Accname) ->
%     % ok = lib_guild:delete_role(RoleId),
%     % ok = lib_goods:delete_role(RoleId),

%     % Var1 = case db:delete(player, [{id,RoleId}]) of  %%old: case db:delete(player, [{id,RoleId}, {accname,_Accname}]) of
%     %     1 -> true;
%     %     _ -> false
%     % end,
%     % Var1 andalso lib_relationship:delete_role(RoleId).

%     todo_here.







%检查在线人数，是否允许继续登录
%% @return: ok | fail
login_limit_check() ->
    LimitLogin = config:get_limit_login(server),
    % 是否开启了登录人数限制？
    case LimitLogin of
        1 ->
             OnlineNumber = lib_svr_info:get_online_player_num(),    %% lib_player:get_online_num(),
             Threshold = config:get_limit_login_threshold(server),
             % 在线人数是否已达限制登录的阀值？
             case OnlineNumber >= Threshold of
                true ->
                    fail;
                false ->
                    ok
             end;
        _ ->
            ok
    end.




%% ========================================== Local Functions ==========================================


%% 赠送物品给新创建的角色\
give_goods_to_new_role(RoleId, Race, Sex) ->
	%% 暂时不处理赠送
	ok;
	
give_goods_to_new_role(RoleId, Race, Sex) ->
    Data = data_race:get(Race, Sex),
    MaxCount = lists:min([?DEF_BAG_EQ_CAPACITY, ?DEF_BAG_USABLE_CAPACITY, ?DEF_BAG_UNUSABLE_CAPACITY]),
    case length(Data#race.inborn_goods) > MaxCount of
        true ->
            ?ERROR_MSG("lib_account:give_goods_to_new_role too many!!", []);
        false ->
            F = fun({GoodsNo, Count}, Slot) ->
                GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
                ExtraInitInfo =
                    case lib_goods:is_equip(GoodsTpl) of
                        true -> [{location, ?LOC_PLAYER_EQP}, {slot, lib_goods:get_equip_pos(GoodsTpl)}];
                        false ->
                            case lib_goods:is_can_use(GoodsTpl) of
                                true -> [{location, ?LOC_BAG_USABLE}, {slot, Slot}];
                                false -> [{location, ?LOC_BAG_UNUSABLE}, {slot, Slot}]
                            end
                    end,
                mod_inv:add_new_goods_to_player(RoleId, [{GoodsNo, Count}], ExtraInitInfo),
                case lib_goods:is_equip(GoodsTpl) of
                    false -> Slot + 1;
                    true -> Slot
                end
            end,
            lists:foldl(F, 1, Data#race.inborn_goods)
    end,

    %% 处理给钱的情况
    F1 = fun({Type, Count}) ->
        case Type of
            ?MNY_T_GAMEMONEY ->
              player:db_save_gamemoney(RoleId, Count);
            ?MNY_T_YUANBAO ->
                player:db_save_yuanbao(RoleId, Count);
            ?MNY_T_BIND_YUANBAO ->
                player:db_save_bind_yuanbao(RoleId, Count);
            ?MNY_T_VITALITY ->
              player:db_save_vitality(RoleId,Count);
			?MNY_T_INTEGRAL ->
              player:db_save_integral(RoleId,Count);
            _Any ->
                ?ERROR_MSG("lib_account:give_goods_to_new_role money error!!", [])
        end
    end,
    [F1(X) || X <- Data#race.inborn_money].


%% 名字合法则返回true，否则throw非法原因
new_role_name_legal__(Name) ->
    % 是否为空？
    ?Ifc (Name == "")
        throw(?CR_FAIL_NAME_EMPTY)
    ?End,

    case asn1rt:utf8_binary_to_list(list_to_binary(Name)) of
        {ok, CharList} ->
            Len = util:string_width_1(CharList),

            % ?TRACE("new_role_name_legal__(), Name: ~p~n", [Name]),
            % ?TRACE("CharList: ~p, Len:~p~n~n", [CharList, Len]),

            % 长度是否太短？
            ?Ifc (Len < ?MIN_ROLE_NAME_LEN)
                throw(?CR_FAIL_NAME_TOO_SHORT)
            ?End,

            % 长度是否太长？
            ?Ifc (Len > ?MAX_ROLE_NAME_LEN)
                throw(?CR_FAIL_NAME_TOO_LONG)
            ?End,

            % 是否包含非法字符（如：空格，引号...）？
            ?Ifc (has_illegal_char(CharList))
                throw(?CR_FAIL_CHAR_ILLEGAL)
            ?End;
        {error, _Reason} ->
            % 非法字符
            throw(?CR_FAIL_CHAR_ILLEGAL)
    end,

    % 数据库中角色名是否已存在？
    case db_is_role_name_exists(Name) of
        true ->
            throw(?CR_FAIL_NAME_CONFLICT);
        false ->
            true
    end.


%% 检测字符串是否包含非法字符
%% @return: true | false
has_illegal_char([]) ->
    false;
has_illegal_char([H | T]) ->
    case H of
        $' ->  % 单引号
            true;
        $" ->  % 双引号
            true;
        $` ->   % 反引号
            true;
        $\\ ->     % 反斜杠
            true;
        $% ->     % 百分号
            true;
        32 ->   % 空格
            true;
        0 ->    % 空白
            true ;
        _ ->
            has_illegal_char(T)
    end.




% 角色名的合法性检测（采用白名单的方法）
% do_check_name(Bin) when is_binary(Bin) ->  % Bin是utf8编码的字节流
%     do_check_name(?b2l(Bin));   % ?b2l: binary_to_list()
% do_check_name(Str) ->
%     do_check_name_f1(Str).

% do_check_name_f1([]) -> true;
% do_check_name_f1([C|T])
% when (C >= $0 andalso C =< $9)
% orelse (C >= $a andalso C =< $z)
% orelse (C >= $A andalso C =< $Z)
% orelse C == $? orelse C == $_
% -> do_check_name_f1(T);
% do_check_name_f1([C|_]) when C =< 127 -> false;  % 汉字对应的utf8编码的每个字节都大于127
% do_check_name_f1([_C|T]) -> do_check_name_f1(T).

