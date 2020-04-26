%%%--------------------------------------
%%% @Module  : lib_goods_eff
%%% @Author  : huangjf, zhangwq
%%% @Email   :
%%% @Created : 2013.5.16
%%% @Description : 物品效果的相关接口
%%%--------------------------------------
-module(lib_goods_eff).

-export([
            get_cfg_data/1,
            decide_get_no/1,
            has_effect_name_in_effect_list/2,
            apply_effects/4,
            apply_effects/5

    ]).


-include("common.hrl").
-include("record.hrl").
-include("effect.hrl").
-include("debug.hrl").
-include("buff.hrl").
% -include("effect.hrl").
-include("partner.hrl").
-include("skill.hrl").
-include("obj_info_code.hrl").
-include("player.hrl").
-include("log.hrl").
-include("record/goods_record.hrl").
-include("goods.hrl").
-include("reward.hrl").
-include("ets_name.hrl").
-include("admin_activity.hrl").
-include("pt_13.hrl").
-include("prompt_msg_code.hrl").
-include("pt_18.hrl").

-define(GET_GOODS_EXCPT_LIST, [60136,60137,60138,60139,60140,60141,4102,4152,4202,4252,4302,4352,60103,60104,60105,60106,60087,60088,60089,60170,60171,
    4103,4104, 4154, 4204, 4254, 4304, 4354, 1004, 1054, 2004, 2054, 3004, 3054, 6004, 5004]).

%% @return: null | goods_eff结构体
get_cfg_data(EffNo) ->
    data_goods_eff:get(EffNo).

% return true | false
has_effect_name_in_effect_list([], _EffName) ->
    false;
has_effect_name_in_effect_list([EffNo | T], EffName) ->
    EffCfg = get_cfg_data(EffNo),
    case EffName =:= EffCfg#goods_eff.name of
        true -> true;
        false -> has_effect_name_in_effect_list(T, EffName)
    end.

%% 战斗外应用物品的效果到玩家身上
apply_effects(for_player, PS, Goods, UseCount) ->
    GoodsEffNoList = lib_goods:get_effects(Goods),
    F = fun(EffNo) ->
            apply_one_effect(for_player, PS, EffNo, Goods, UseCount)
        end,
    lists:foreach(F, GoodsEffNoList).


apply_effects(for_partner, PS, PartnerId, Goods, UseCount) ->
    case PartnerId =:= ?INVALID_NO of
        true ->
            skip;
        false ->
            GoodsEffNoList = lib_goods:get_effects(Goods),
            ?ASSERT(is_list(GoodsEffNoList)),
            F = fun(EffNo) ->
                    apply_one_effect(for_partner, PS, PartnerId, EffNo, Goods, UseCount)
                end,
            lists:foreach(F, GoodsEffNoList)
    end.



apply_one_effect(for_player, PS, EffNo, Goods, UseCount) ->
    EffCfg = get_cfg_data(EffNo),
    EffName = EffCfg#goods_eff.name,

    %% 生效概率
    RandNum = util:rand(1, 100),
    ?TRACE("RandNum is:~p, EffCfg#goods_eff.trigger_proba is:~p~n", [RandNum, EffCfg#goods_eff.trigger_proba]),
    case RandNum >= 1 andalso RandNum =< EffCfg#goods_eff.trigger_proba of
        false ->
            skip;
        true ->
            apply_one_effect__(for_player, PS, EffName, EffCfg, Goods, UseCount)
    end.

apply_one_effect(for_partner, PS, PartnerId, EffNo, Goods, UseCount) ->
    EffCfg = get_cfg_data(EffNo),
    EffName = EffCfg#goods_eff.name,

    %% 生效概率
    RandNum = util:rand(1, 100),
    ?TRACE("PartnerId:~p, RandNum is:~p, EffCfg#goods_eff.trigger_proba is:~p~n", [PartnerId, RandNum, EffCfg#goods_eff.trigger_proba]),
    case RandNum >= 1 andalso RandNum =< EffCfg#goods_eff.trigger_proba of
        false ->
            skip;
        true ->
            apply_one_effect__(for_partner, PS, PartnerId, EffName, EffCfg, Goods, UseCount)
    end.

%% 应用单个物品效果到玩家：加xx点血 品质相关
apply_one_effect__(for_player, PS, ?EN_ADD_HP_BY_QUALITY, Eff, Goods, UseCount) ->
    {BaseAdd,QualityAdd} = Eff#goods_eff.para,
    HpAdd = util:ceil(BaseAdd + (QualityAdd * lib_goods:get_quality_lv(Goods))) * UseCount,
    ?ASSERT(is_integer(HpAdd) andalso HpAdd > 0, HpAdd), 
    player:add_hp(PS, HpAdd);
%% 应用单个物品效果到玩家：加xx点法 品质相关
apply_one_effect__(for_player, PS, ?EN_ADD_MP_BY_QUALITY, Eff, Goods, UseCount) ->
    {BaseAdd,QualityAdd} = Eff#goods_eff.para,
    MpAdd = util:ceil(BaseAdd + (QualityAdd * lib_goods:get_quality_lv(Goods))) * UseCount,
    ?ASSERT(is_integer(MpAdd) andalso MpAdd > 0, MpAdd), 
    player:add_mp(PS, MpAdd);


%% 应用单个物品效果到玩家：加xx点血 
apply_one_effect__(for_player, PS, ?EN_ADD_HP, Eff, _Goods, UseCount) ->
    HpAdd = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(HpAdd) andalso HpAdd > 0, HpAdd),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_hp(PS, HpAdd);


%% 应用单个物品效果到玩家：加一定比例的血
apply_one_effect__(for_player, PS, ?EN_ADD_HP_BY_RATE, Eff, _Goods, UseCount) ->
    AddRate = Eff#goods_eff.para,
    ?ASSERT(0 < AddRate andalso AddRate =< 1, AddRate),
    HpAdd = util:ceil(player:get_base_hp_lim(PS) * AddRate), % 注意：要对乘法的结果做取整的处理（此处是向上取整）
    player:add_hp(PS, HpAdd*UseCount);


%% 应用单个物品效果到玩家：加xx魔法
apply_one_effect__(for_player, PS, ?EN_ADD_MP, Eff, _Goods, UseCount) ->
    MpAdd = Eff#goods_eff.para,
    ?ASSERT(is_integer(MpAdd) andalso MpAdd > 0, MpAdd),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_mp(PS, MpAdd*UseCount);


%% 应用单个物品效果到玩家：加xx%的魔法（百分比的基数为初始魔法上限）
apply_one_effect__(for_player, PS, ?EN_ADD_MP_BY_RATE, Eff, _Goods, UseCount) ->
    AddRate = Eff#goods_eff.para,
    ?ASSERT(0 < AddRate andalso AddRate =< 1, AddRate),
    MpAdd = util:ceil(player:get_base_mp_lim(PS) * AddRate), % 注意：要对乘法的结果做取整的处理（此处是向上取整）
    player:add_mp(PS, MpAdd*UseCount);


%% 应用单个物品效果到玩家：传送到XXX
apply_one_effect__(for_player, PS, ?EN_TELEPORT, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    TeleportNo = Eff#goods_eff.para,
    ply_scene:try_teleport(PS, TeleportNo);


%% 成长基金
apply_one_effect__(for_player, PS, ?EN_ACTIVATE_FUND_RECHARGE_REBATES, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    Misc_Status = ply_misc:get_player_misc(player:id(PS)),
    player:use_grow_fund(PS,Misc_Status, Eff#goods_eff.para);


%% 应用单个物品效果到玩家：添加指定编号的buff
apply_one_effect__(for_player, PS, ?EN_ADD_BUFF, Eff, Goods, UseCount) ->
    BuffNo = Eff#goods_eff.para,
    ?ASSERT(UseCount =:= 1, UseCount),
    ?TRACE("add buffNo:~p~n", [BuffNo]),
    lib_buff:player_add_buff(player:get_id(PS), BuffNo),
    case data_buff:get(BuffNo) of
        null ->
            ?ASSERT(false, {BuffNo, lib_goods:get_no(Goods)}),
            skip;
        BuffCfg ->
            case lib_buff_tpl:get_name(BuffCfg) of
                ?BFN_ADD_EXP ->
                    Count = lib_vip:welfare(use_multiple_exp_count, PS),
                    TypInfo =
                        case lib_goods:get_use_limit_time(Goods) of
                            1 -> <<"日">>;
                            2 -> <<"周">>;
                            3 -> <<"月">>;
                            _Any -> ?ASSERT(false), <<>>
                        end,

                    case ply_misc:get_player_misc(player:get_id(PS)) of
                        null ->
                            ply_tips:send_sys_tips(PS, {use_exp_buff_goods_left_time, [TypInfo, Count - UseCount]});
                        PlayerMisc ->
                            case lists:keyfind(lib_goods:get_no(Goods), 1, PlayerMisc#player_misc.use_goods) of
                                false ->
                                    ply_tips:send_sys_tips(PS, {use_exp_buff_goods_left_time, [TypInfo, Count - UseCount]});
                                {_GoodsNo1, CountOld, _Time} ->
                                    ply_tips:send_sys_tips(PS, {use_exp_buff_goods_left_time, [TypInfo, Count - UseCount - CountOld]})
                            end
                    end;
                ?BFN_ADD_ZHUOGUI_EXP ->
                    Count = lib_vip:welfare(use_catch_ghost_multiple_exp_count, PS),
                    TypInfo =
                        case lib_goods:get_use_limit_time(Goods) of
                            1 -> <<"日">>;
                            2 -> <<"周">>;
                            3 -> <<"月">>;
                            _Any -> ?ASSERT(false), <<>>
                        end,

                    case ply_misc:get_player_misc(player:get_id(PS)) of
                        null ->
                            ply_tips:send_sys_tips(PS, {use_ghost_exp_buff_goods_left_time, [TypInfo, Count - UseCount]});
                        PlayerMisc ->
                            case lists:keyfind(lib_goods:get_no(Goods), 1, PlayerMisc#player_misc.use_goods) of
                                false ->
                                    ply_tips:send_sys_tips(PS, {use_ghost_exp_buff_goods_left_time, [TypInfo, Count - UseCount]});
                                {_GoodsNo1, CountOld, _Time} ->
                                    ply_tips:send_sys_tips(PS, {use_ghost_exp_buff_goods_left_time, [TypInfo, Count - UseCount - CountOld]})
                            end
                    end;
                ?BFN_VIP_EXPERIENCE ->
                    VipLv =
                        case lib_buff_tpl:get_para(BuffCfg) of
                            null -> ?ASSERT(false, BuffCfg), 1;
                            VLv when is_integer(VLv) -> VLv
                        end,
                    mod_vip:experience(VipLv, lib_buff_tpl:get_lasting_time(BuffCfg), PS);
                _Any -> skip
            end
    end;


%% 应用单个物品效果到玩家：重新激活暗雷
apply_one_effect__(for_player, PS, ?EN_REACTIVATE_TRAP, _Eff, _Goods, _UseCount) ->
    ?TRACE("apply_one_effect__ : EN_REACTIVATE_TRAP\n", []),
    ?ASSERT(_UseCount =:= 1, _UseCount),
    BuffList = mod_buff:get_buff_list(player, player:get_id(PS)),
    BuffNoList = [Buff#buff.no || Buff <- BuffList],
    case mod_buff:find_buff_no_by_name(BuffNoList, ?BFN_AVOID_TRAP) of
        ?INVALID_NO -> skip;
        BuffNo ->
            ?TRACE("apply_one_effect__ del buff: BuffNo:~p,~p ~n", [BuffNo, BuffNoList]),
            lib_buff:player_del_buff(player:get_id(PS), BuffNo)
    end;


%% 应用单个物品效果到玩家：使用某个技能
apply_one_effect__(for_player, _PS, ?EN_USE_SKILL, Eff, _Goods, _UseCount) ->
    _SkillNo = Eff#goods_eff.para,
    to_here;


%% 应用单个物品效果到玩家：给予玩家宠物
apply_one_effect__(for_player, PS, ?EN_GET_PARTNER, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    PartnerNo = Eff#goods_eff.para,
    ?TRACE("add_partner:~p~n", [PartnerNo]),
    ply_partner:player_add_partner(PS, PartnerNo);


%% 应用单个物品效果到玩家：变身
apply_one_effect__(for_player, PS, ?EN_TRANSFIGURATION, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    No = Eff#goods_eff.para,
    ?TRACE("transfiguration:~p~n", [No]),
    mod_player:transfiguration(PS, No);


apply_one_effect__(for_player, PS, ?EN_GET_MOUNTS, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    No = Eff#goods_eff.para,
    case lib_mount:player_add_mount(PS, No) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, MountId} ->
            {ok, BinData} = pt_18:write(?PT_ACTIVE_MOUNT, [?RES_OK, No, MountId]),
            lib_send:send_to_sock(PS, BinData),
            case length(lib_mount:get_all_mount(player:get_id(PS))) =:= 1 of
                true ->
                    Mount = lib_mount:get_mount(MountId),
                    lib_mount:on_mount(PS, Mount),
                    {ok, BinData1} = pt_18:write(?PT_ONOFF_MOUNT, [1, 0, MountId]),
                    lib_send:send_to_sock(PS, BinData1),
                    PartnerId = player:get_main_partner_id(PS),
                    case PartnerId =/= 0 of
                        true ->
                            Ressult = lib_mount:connect_partner(PS, MountId, PartnerId, 1),
                            case Ressult of
                                {false, Reason1} ->
                                    lib_send:send_prompt_msg(PS, Reason1);
                                ok ->
                                    {ok, BinData2} = pt_18:write(?PT_CONNECT_PARTNER, [1, MountId, PartnerId]),
                                    lib_send:send_to_sock(PS,BinData2)
                            end;
                        false -> skip
                    end;
                false -> skip
            end
    end;

apply_one_effect__(for_player, PS, ?EN_ADD_WING, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    Add = Eff#goods_eff.para,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同


    case lib_wing:check_player_add_wing(player:get_id(PS), Add) of
        ok ->
            case data_chibang:get_chibang_info(Add) of
                null ->
                    ?ERROR_MSG("lib_goods_eff:add_title data error!~n", []);
                _ ->
                    lib_wing:add_wing(player:id(PS), Add, 0)
            end;
        Other ->
            Other
    end;

apply_one_effect__(for_player, PS, ?EN_RAND_GET_PAR, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    GoodsProbList = Eff#goods_eff.para,
    ?ASSERT(is_list(GoodsProbList), GoodsProbList),   % 如果策划填表有误，则会导致断言失败，下同
    
    ParNo = decide_get_no(GoodsProbList),
    case ParNo =:= ?INVALID_NO of
        true ->
            case GoodsProbList =:= [] of
                true ->
                    ?ASSERT(false, GoodsProbList),
                    ?ERROR_MSG("lib_goods_eff:apply_one_effect__,GoodsNo:~p,GoodsProbList:~p~n", [lib_goods:get_no(_Goods), GoodsProbList]);
                false ->
                    H = erlang:hd(GoodsProbList),
                    No = element(1, H),
                    ply_partner:player_add_partner(PS, No)
            end;        
        false ->
            ply_partner:player_add_partner(PS, ParNo)
    end;


apply_one_effect__(for_player, PS, ?EN_RAND_GET_REWARD, Eff, Goods, UseCount) ->
    ?ASSERT(UseCount =:= 1, UseCount),
    List = Eff#goods_eff.para,
    PlayerId = player:id(PS),
    ?ASSERT(is_list(List), List),   % 如果策划填表有误，则会导致断言失败，下同
    case util:rand_by_weight(List, 3) of
        {reward_pkg, No, _P} ->
            apply_one_effect__(for_player, PS, ?EN_GET_REWARD, No, Goods, UseCount);
        {reward_pool, No, _P} ->
            #reward_dtl{calc_goods_list=GList} = mod_reward_pool:calc_reward(No, PS),
            
            F = fun({GoodsNo, GoodsCount, Quality, _BindState,NeedBroadcast}, Acc) ->
                    Goods = mod_inv:batch_smart_add_new_goods(PlayerId,
                                              [{GoodsNo, GoodsCount}],
                                              [{quality, Quality}, {bind_state, lib_goods:get_bind_state(Goods)}],
                                              [?LOG_GIF, Goods#goods.no]),
                    case NeedBroadcast of
                        0 -> skip;
                        _ -> mod_broadcast:send_sys_broadcast(NeedBroadcast, [player:get_name(PS), player:id(PS), GoodsNo, Quality, GoodsCount,lib_goods:get_id(Goods)])
                    end,

                    Acc

                end,
            lists:foldl(F, 0, GList);
        _ ->
            ?ERROR_MSG("lib_goods_eff:apply_one_effect__EN_RAND_GET_REWARD error!PlayerId:~p,GoodsNo:~p,Para:~w~n", [PlayerId, lib_goods:get_no(Goods), List])
    end,
    case lib_goods:get_extra(Goods, gift) of
        null -> skip;
        {gift, [FromPlayerId, BlessingNo]} ->
            lib_festival_act:show_bress(PS, BlessingNo, FromPlayerId);
        _ -> skip
    end;



%% 应用单个物品效果到玩家：给予玩家添加已接任务
apply_one_effect__(for_player, PS, ?EN_ACCEPT_TASK, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    Task = Eff#goods_eff.para,

    ?DEBUG_MSG("add_accepted_task:~w~n", [Task]),
    case is_integer(Task) of
        true ->
            %强制玩家接任务
            lib_task:force_accept(Task, PS);
        false ->
            TaskId = rand_get_one_valid_task(PS, Task),
            case TaskId =:= ?INVALID_NO of
                true -> skip;
                false -> lib_task:force_accept(TaskId, PS)
            end
    end;


apply_one_effect__(for_player, PS, ?EN_MARK_FINISH_TASK, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    Task = Eff#goods_eff.para,

    ?DEBUG_MSG("EN_FINISH_TASK:~w~n", [Task]),
    List = lib_task:get_accepted_list(),

    case get_finish_task(List, Task) of
        ?INVALID_ID ->
            ?ERROR_MSG("lib_goods_eff:?EN_MARK_FINISH_TASK error~n", []);
        TaskId ->
            % lib_task:make_task_finish(TaskId, player:id(PS))
            lib_task:force_submit(TaskId, PS, goods_eff)
    end;



%% 应用单个物品效果到玩家：加xx点体力
apply_one_effect__(for_player, PS, ?EN_ADD_PHY_POWER, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_phy_power(PS, Add*UseCount);

%% 应用单个物品效果到玩家：加xx点活力
apply_one_effect__(for_player, PS, ?EN_ADD_ENERGY, Eff, _Goods, _UseCount) ->
    Add = Eff#goods_eff.para,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_vitality(PS, Add, ["goods_eff","use_goods"]);

%% 应用单个物品效果到玩家：加xx点怒气
apply_one_effect__(for_player, PS, ?EN_ADD_ANGER, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_anger(PS, Add*UseCount);

%% 获得指定编号的奖励包
apply_one_effect__(for_player, PS, ?EN_GET_REWARD, Eff, Goods, UseCount) when is_record(Eff, goods_eff) ->
    apply_one_effect__(for_player, PS, ?EN_GET_REWARD, Eff#goods_eff.para, Goods, UseCount);

apply_one_effect__(for_player, PS, ?EN_GET_REWARD, Para, Goods, UseCount) ->
    ?ASSERT(UseCount =:= 1, UseCount),
    Add = Para,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    % RewardDtl = lib_reward:give_reward_to_player(common, PS, Add, [], [?LOG_GIF, Goods#goods.no]),
	if
		Para =:= 91491 ->
			lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_FIRE_WORKS, 1}]);
		Para =:= 91492 ->
			lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_FIRE_WORKS, 2}]);
		Para =:= 91493 ->
			lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_FIRE_WORKS, 3}]);
		Para =:= 91494 ->
			lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_FIRE_WORKS, 4}]);
		Para =:= 91495 ->
			lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_FIRE_WORKS, 5}]);
        Para =:= 91505 ->
            {ok, BinData} = pt_12:write(12030, [1]),
            Msg = pt:string_to_binary("点燃了春节烟花"),
            {ok, BinData2} = pt_11:write(11007, [player:id(PS), Msg,
                lib_chat:get_identify(PS), player:get_name(PS), ply_priv:get_priv_lv(PS),player:get_race(PS),player:get_sex(PS)]),
            lib_send:send_to_all(BinData),
            lib_send:send_to_all(BinData2);
		true ->
			skip
	end,
    NewTime = 
    case lib_goods:get_bind_state(Goods) of
        ?BIND_ALREADY ->
            1;
        ?BIND_ON_GET ->
            1;
        _ ->
            4
    end,

    RewardDtl = lib_reward:give_reward_to_player(dungeon,NewTime,PS, Add, [?LOG_GIF, lib_goods:get_no(Goods) ]),
    UseLimit = 
        case lib_goods:get_use_limit(Goods) of
            0 -> 0;
            Count when Count > 0 -> Count 
        end,

    F = fun({Id, No, Cnt}) ->
        case Id =:= ?INVALID_NO of
            true -> 
                case UseLimit =:= 0 of
                    true -> skip;
                    false ->
                        TipsType = 
                            case No of
                                ?VGOODS_BIND_GAMEMONEY -> use_add_bind_gamemoney_goods_left_time;
                                ?VGOODS_EXP -> use_add_exp_goods_left_time;
                                _Any -> null
                            end,

                        case ply_misc:get_player_misc(player:get_id(PS)) of
                            null ->
                                case TipsType =:= null of
                                    true -> skip;
                                    false -> ply_tips:send_sys_tips(PS, {TipsType, [UseLimit - UseCount]})
                                end;
                            PlayerMisc ->
                                case lists:keyfind(lib_goods:get_no(Goods), 1, PlayerMisc#player_misc.use_goods) of
                                    false ->
                                        case TipsType =:= null of
                                            true -> skip;
                                            false -> ply_tips:send_sys_tips(PS, {TipsType, [UseLimit - UseCount]})
                                        end;
                                    {_GoodsNo1, CountOld, _Time} ->
                                        case TipsType =:= null of
                                            true -> skip;
                                            false -> ply_tips:send_sys_tips(PS, {TipsType, [UseLimit - UseCount - CountOld]})
                                        end
                                end
                        end
                end;
            false ->
                case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                    null -> skip;
                    GetGoods ->
                        case lib_goods:get_quality(GetGoods) >= ?QUALITY_PURPLE of
                            true -> 
                                case lists:member(lib_goods:get_no(GetGoods), ?GET_GOODS_EXCPT_LIST) of
                                    true -> skip;
                                    false ->skip
                                        % ply_tips:send_sys_tips(PS, {get_goods_quality_gift, [player:get_name(PS), player:id(PS), lib_goods:get_no(Goods), lib_goods:get_quality(Goods), 1, No, lib_goods:get_quality(GetGoods), Cnt]})
                                end;                                        
                            false -> skip
                        end
                end
        end
    end,
    [F(X) || X <- RewardDtl#reward_dtl.goods_list];

%% 完成任务：进度加1
apply_one_effect__(for_player, PS, ?EN_FINISH_TASK, Eff, Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    Para = Eff#goods_eff.para,
    ?ASSERT(is_tuple(Para)),
    {_TaskId, _SceneNo, _AreaNo} = Para,
    lib_event:event(use_goods, [lib_goods:get_no(Goods), 1], PS);


%% 应用单个物品效果到玩家：加xx点血和魔法
apply_one_effect__(for_player, PS, ?EN_ADD_HP_MP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_hp(PS, Add),
    player:add_mp(PS, Add);


%% 应用单个物品效果到玩家：加xx点血
apply_one_effect__(for_player, PS, ?EN_REVIVE_AND_ADD_HP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_hp(PS, Add);

%% 应用单个物品效果到玩家：复活加血的道具在这里用就是浪费
apply_one_effect__(for_player, PS, ?EN_REVIVE_AND_ADD_HP_BY_QUALITY, Eff, Goods, UseCount) ->
    {BaseAdd,QualityAdd} = Eff#goods_eff.para,
    Add = util:ceil(BaseAdd + (QualityAdd * lib_goods:get_quality_lv(Goods))) * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_hp(PS, Add);

%% 应用单个物品效果到玩家：解控 加血的道具在这里用就是浪费
apply_one_effect__(for_player, PS, ?EN_CLEARANCE_AND_ADD_HP_BY_QUALITY, Eff, Goods, UseCount) ->
    {BaseAdd,QualityAdd,_PurgeBuffRule} = Eff#goods_eff.para,
    Add = util:ceil(BaseAdd + (QualityAdd * lib_goods:get_quality_lv(Goods))) * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_hp(PS, Add);


%% 应用单个物品效果到玩家：加xx点血和魔法
apply_one_effect__(for_player, PS, ?EN_REVIVE_AND_ADD_HP_MP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_mp(PS, Add),
    player:add_hp(PS, Add);


%% 应用单个物品效果到玩家：加xx点经验
apply_one_effect__(for_player, PS, ?EN_ADD_EXP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_exp(PS, Add, [?LOG_GIF, _Goods#goods.no]);

%% 应用耽搁物品效果到玩家：减少PK值
apply_one_effect__(for_player, PS, ?EN_SUB_POPULAR, Eff, _Goods, UseCount) ->
    Sub = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Sub) andalso Sub > 0, Sub),   % 如果策划填表有误，则会导致断言失败，下同
    player:set_popular(PS, player:get_popular(PS) - Sub);

%% 应用耽搁物品效果到玩家：增加PK值
apply_one_effect__(for_player, PS, ?EN_ADD_POPULAR, Eff, _Goods, UseCount) ->
    Sub = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Sub) andalso Sub > 0, Sub),   % 如果策划填表有误，则会导致断言失败，下同
    player:set_popular(PS, player:get_popular(PS) + Sub);


%% 应用耽搁物品效果到玩家：减少筹码
apply_one_effect__(for_player, PS, ?EN_SUB_CHIP, Eff, _Goods, UseCount) ->
    Sub = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Sub) andalso Sub > 0, Sub),   % 如果策划填表有误，则会导致断言失败，下同
    player:sub_chip(PS, Sub,[?LOG_GIF, _Goods#goods.no]);

%% 应用耽搁物品效果到玩家：增加筹码
apply_one_effect__(for_player, PS, ?EN_ADD_CHIP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_chip(PS, Add,[?LOG_GIF, _Goods#goods.no]);


%% 应用单个物品效果到玩家：加xx绑银
apply_one_effect__(for_player, PS, ?EN_ADD_BIND_GAMEMONEY, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_bind_gamemoney(PS, Add, [?LOG_GIF, _Goods#goods.no]);


apply_one_effect__(for_player, PS, ?EN_ADD_GAMEMONEY, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_gamemoney(PS, Add, [?LOG_GIF, _Goods#goods.no]);


apply_one_effect__(for_player, PS, ?EN_ADD_COPPER, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_copper(PS, Add, [?LOG_GIF, _Goods#goods.no]);

% 添加帮派成就
apply_one_effect__(for_player, PS, ?EN_ADD_CONTRI, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    % player:add_guild_contri(PS, Add, [?LOG_GIF, _Goods#goods.no]);
    mod_guild_mgr:add_member_contri(PS, Add, [?LOG_GIF,_Goods#goods.no]);

% 添加帮派成就
apply_one_effect__(for_player, PS, ?EN_ADD_GUILD_CONTRI, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_guild_contri(PS, Add, [?LOG_GIF, _Goods#goods.no]);

% 添加帮派战功
apply_one_effect__(for_player, PS, ?EN_ADD_GUILD_FEAT, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_guild_feat(PS, Add, [?LOG_GIF, _Goods#goods.no]);

apply_one_effect__(for_player, PS, ?EN_ADD_CHIVALROUS, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_chivalrous(PS, Add, [?LOG_GIF, _Goods#goods.no]);

apply_one_effect__(for_player, PS, ?EN_ADD_JINGWEN, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_jingwen(PS, Add, [?LOG_GIF, _Goods#goods.no]);

apply_one_effect__(for_player, PS, ?EN_ADD_MIJING, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_mijing(PS, Add, [?LOG_GIF, _Goods#goods.no]);

apply_one_effect__(for_player, PS, ?EN_ADD_HUANJING, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_huanjing(PS, Add, [?LOG_GIF, _Goods#goods.no]);




apply_one_effect__(for_player, PS, ?EN_ADD_YUANBAO, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_yuanbao(PS, Add, [?LOG_GIF, _Goods#goods.no]);


%% 应用单个物品效果 触发挖宝
apply_one_effect__(for_player, PS, ?EN_TRIGGER_DIG_TREASURE, _Eff, Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    mod_dig_treasure:dig(lib_goods:get_no(Goods), PS);


apply_one_effect__(for_player, PS, ?EN_ACTIVATE_VIP_RECHARGE_REBATES, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    player:use_month_card(PS, Eff#goods_eff.para);

%% 应用单个物品效果到玩家：
apply_one_effect__(for_player, PS, ?EN_ADD_STORE_HP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_store_hp(PS, Add),
    gen_server:cast(player:get_pid(PS), 'adjust_player_hp_mp');


%% 应用单个物品效果到玩家：
apply_one_effect__(for_player, PS, ?EN_ADD_STORE_HP_BY_QUALITY, Eff, Goods, UseCount) ->
    {BaseAdd,QualityAdd} = Eff#goods_eff.para,
    Add = util:ceil((BaseAdd + QualityAdd * lib_goods:get_quality_lv(Goods)) * UseCount),
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_store_hp(PS, Add),
    gen_server:cast(player:get_pid(PS), 'adjust_player_hp_mp');


%% 应用单个物品效果到玩家：
apply_one_effect__(for_player, PS, ?EN_ADD_STORE_MP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_store_mp(PS, Add),
    gen_server:cast(player:get_pid(PS), 'adjust_player_hp_mp');

%% 应用单个物品效果到玩家：
apply_one_effect__(for_player, PS, ?EN_ADD_STORE_MP_BY_QUALITY, Eff, Goods, UseCount) ->
    {BaseAdd,QualityAdd} = Eff#goods_eff.para,
    Add = util:ceil((BaseAdd + QualityAdd * lib_goods:get_quality_lv(Goods)) * UseCount),
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_store_mp(PS, Add),
    gen_server:cast(player:get_pid(PS), 'adjust_player_hp_mp');


%% 应用单个物品效果到玩家：
apply_one_effect__(for_player, PS, ?EN_ADD_STORE_PAR_HP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_store_par_hp(PS, Add),
    F = fun(Partner) ->
        gen_server:cast(player:get_pid(PS), {'adjust_partner_hp_mp', Partner})
    end,
    [F(X) || X <- mod_partner:get_fighting_partner_list(PS)];


%% 应用单个物品效果到玩家：
apply_one_effect__(for_player, PS, ?EN_ADD_STORE_PAR_HP_BY_QUALITY, Eff, Goods, UseCount) ->
    {BaseAdd,QualityAdd} = Eff#goods_eff.para,
    Add = util:ceil((BaseAdd + QualityAdd * lib_goods:get_quality_lv(Goods)) * UseCount),

    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_store_par_hp(PS, Add),
    F = fun(Partner) ->
        gen_server:cast(player:get_pid(PS), {'adjust_partner_hp_mp', Partner})
    end,
    [F(X) || X <- mod_partner:get_fighting_partner_list(PS)];


%% 应用单个物品效果到玩家：
apply_one_effect__(for_player, PS, ?EN_ADD_STORE_PAR_MP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_store_par_mp(PS, Add),
    F = fun(Partner) ->
        gen_server:cast(player:get_pid(PS), {'adjust_partner_hp_mp', Partner})
    end,
    [F(X) || X <- mod_partner:get_fighting_partner_list(PS)];

%% 应用单个物品效果到玩家：
apply_one_effect__(for_player, PS, ?EN_ADD_STORE_PAR_MP_BY_QUALITY, Eff, Goods, UseCount) ->
    {BaseAdd,QualityAdd} = Eff#goods_eff.para,
    Add = util:ceil((BaseAdd + QualityAdd * lib_goods:get_quality_lv(Goods)) * UseCount),
    
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    player:add_store_par_mp(PS, Add),
    F = fun(Partner) ->
        gen_server:cast(player:get_pid(PS), {'adjust_partner_hp_mp', Partner})
    end,
    [F(X) || X <- mod_partner:get_fighting_partner_list(PS)];


%% 应用单个物品效果到玩家：选择性使用


%% 应用单个物品效果到玩家：
apply_one_effect__(for_player, PS, ?EN_TURN_TALENT_TO_FREE, _Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),

    NowLv = player:get_lv(PS),              %% 玩家正常等级
    NowPeakLv = player:get_peak_lv(PS),     %% 玩家巅峰等级
    DeltaLv = NowPeakLv + NowLv - ?PLAYER_BORN_LV,   %% 玩家现有等级：正常等级 + 巅峰等级 - 出生等级
    FreePoint = DeltaLv * 5,

    player:add_base_con(PS, 0 - player:get_base_con(PS) + NowLv),      %% 体质
    player:add_base_stam(PS, 0 - player:get_base_stam(PS) + NowLv),    %% 耐力
    player:add_base_spi(PS, 0 - player:get_base_spi(PS) + NowLv),      %% 灵力
    player:add_base_agi(PS, 0 - player:get_base_agi(PS) + NowLv),      %% 敏捷
    player:add_base_str(PS, 0 - player:get_base_str(PS) + NowLv),      %% 力量

    player:add_free_talent_points(PS, 0 -player:get_free_talent_points(PS) + FreePoint);

% 洗力量
apply_one_effect__(for_player, PS, ?EN_SUB_STR, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同 

    NowLv = player:get_lv(PS),
    case player:get_base_str(PS) - Add >= NowLv of
        true -> player:add_base_str(PS, -Add),
        player:add_free_talent_points(PS, Add); %% 力量
        false -> ?ASSERT(false, Add)
    end;
apply_one_effect__(for_player, PS, ?EN_SUB_CON, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同 

    NowLv = player:get_lv(PS),
    case player:get_base_con(PS) - Add >= NowLv of
        true -> player:add_base_con(PS, -Add),
        player:add_free_talent_points(PS, Add); %% 力量
        false -> ?ASSERT(false, Add)
    end;
apply_one_effect__(for_player, PS, ?EN_SUB_STA, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同 

    NowLv = player:get_lv(PS),
    case player:get_base_stam(PS) - Add >= NowLv of
        true -> player:add_base_stam(PS, -Add),
        player:add_free_talent_points(PS, Add); %% 力量
        false -> ?ASSERT(false, Add)
    end;
apply_one_effect__(for_player, PS, ?EN_SUB_SPI, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同 

    NowLv = player:get_lv(PS),
    case player:get_base_spi(PS) - Add >= NowLv of
        true -> player:add_base_spi(PS, -Add),
        player:add_free_talent_points(PS, Add); %% 力量
        false -> ?ASSERT(false, Add)
    end;
apply_one_effect__(for_player, PS, ?EN_SUB_AGI, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同 

    NowLv = player:get_lv(PS),
    case player:get_base_agi(PS) - Add >= NowLv of
        true -> player:add_base_agi(PS, -Add),
        player:add_free_talent_points(PS, Add); %% 力量
        false -> ?ASSERT(false, Add)
    end;

%-------------------------------------%-------------------------------------%-------------------------------------%-------------------------------------%-------------------------------------%-------------------------------------%-------------------------------------%-------------------------------------%-------------------------------------

apply_one_effect__(for_player, PS, ?EN_RAND_GET_GOODS, Eff, Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    GoodsProbList = Eff#goods_eff.para,
    ?ASSERT(is_list(GoodsProbList), GoodsProbList),   % 如果策划填表有误，则会导致断言失败，下同
    
    GoodsNo = 
        case decide_get_no(GoodsProbList) of
            ?INVALID_NO ->
                case GoodsProbList =:= [] of
                    true -> ?INVALID_NO;
                    false ->
                        {TGoodsNo, _} = lists:nth(1, GoodsProbList),
                        TGoodsNo
                end;
            TGoodsNo -> TGoodsNo
        end,
    
    case GoodsNo =:= ?INVALID_NO of
        true -> skip;
        false ->
            RetAddGoods =
                mod_inv:batch_smart_add_new_goods(player:id(PS), [{GoodsNo, 1}], [{bind_state, lib_goods:get_bind_state(Goods)}], [?LOG_GOODS, "use"]),
            case RetAddGoods of
                {fail, _Reason} ->
                    ?ERROR_MSG("lib_goods_eff:apply_one_effect__ add_goods error!Reason:~p~n", [_Reason]);
                {ok, RetGoods} ->
                    F = fun({Id, _No, _Cnt}) ->
                        case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                            null -> skip;
                            GetGoods ->
                                case lib_goods:get_quality(GetGoods) >= ?QUALITY_PURPLE of
                                    true ->
                                        case lists:member(lib_goods:get_no(GetGoods), ?GET_GOODS_EXCPT_LIST) of
                                            true -> skip;
                                            false ->skip
                                                % ply_tips:send_sys_tips(PS, {get_goods_quality_gift, [player:get_name(PS), player:id(PS), lib_goods:get_no(Goods),
                                                % lib_goods:get_quality(Goods), 1, GoodsNo, lib_goods:get_quality(GetGoods), 1]})
                                        end;
                                    false -> skip
                                end
                        end
                    end,
                    [F(X) || X <- RetGoods]
            end
    end;

apply_one_effect__(for_player, PS, ?EN_ACTIVE_VIP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    IsExpie = player:is_vip_experience(PS),
    case player:is_vip(PS) of
        true when not IsExpie -> mod_vip:add_exp(Add, PS);
        _ -> mod_vip:active(PS)
    end;


apply_one_effect__(for_player, PS, ?EN_ADD_VIP_EXP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case player:is_vip(PS) of
        true ->
            PS_Latest = lib_vip:add_exp(Add, PS),
            player_syn:update_PS_to_ets(PS_Latest);
        false ->
            ?ASSERT(false), skip
    end;

apply_one_effect__(for_player, PS, ?EN_EXTEND_PAR_CAPACITY, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case Add > 0 of
        false -> skip;
        true -> 
            player:add_partner_capacity(PS, Add),
            ply_tips:send_sys_tips(PS, {extend_par_capacity, [Add]})
    end;

apply_one_effect__(for_player, PS, ?EN_ADD_TITLE, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    Add = Eff#goods_eff.para,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case data_title:get(Add) of
        null ->
            ?ERROR_MSG("lib_goods_eff:add_title data error!~n", []);
        _ ->
            ply_title:add_title(player:id(PS), Add)
    end;


apply_one_effect__(for_player, PS, ?EN_EXPAND_FIGHT_PAR_CAPACITY, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    ?ASSERT(is_integer(Eff#goods_eff.para) andalso Eff#goods_eff.para > 0, Eff#goods_eff.para),   % 如果策划填表有误，则会导致断言失败，下同
    case Eff#goods_eff.para > 0 of
        false -> skip;
        true -> ply_partner:expand_fight_par_capacity(PS, Eff#goods_eff.para)
    end;

apply_one_effect__(for_player, PS, ?EN_SPAWN_MON, Eff, Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    ?ASSERT(is_list(Eff#goods_eff.para)),   % 如果策划填表有误，则会导致断言失败，下同
    MonNo = get_mon_no_by_task(PS, Eff#goods_eff.para),
    case MonNo > 0 of
        false -> 
            ?ERROR_MSG("lib_goods_eff:get_mon_no_by_task error!~w~n", [Eff#goods_eff.para]);
        true -> 
            case data_mon:get(MonNo) of
                null ->
                    ?ERROR_MSG("lib_goods_eff:data error!MonNo:~p~n", [MonNo]);
                _ ->
                    case lib_goods:get_extra(Goods, dig_treasure) of
                        null -> 
                            ?ERROR_MSG("lib_goods_eff:data error! GoodsNo:~p~n", [lib_goods:get_no(Goods)]);
                        {_, {SceneNo, X, Y}} ->
                            mod_scene:spawn_mon_to_scene_for_player_WNC(PS, MonNo, SceneNo, X, Y)
                    end
            end
    end;

%% 应用单个物品效果到玩家：获得一个内功
apply_one_effect__(for_player, PS, ?EN_GET_INTERNAL_SKILL, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    ArtNo = Eff#goods_eff.para,
    mod_train:player_add_art(PS, ArtNo);

%% 应用单个物品效果到玩家：获得一个符印
apply_one_effect__(for_player, PS, ?EN_GET_FABAO_RUNE, Eff, _Goods, _UseCount) ->
    FuyinNo = Eff#goods_eff.para,
    ?ASSERT(is_integer(FuyinNo) andalso FuyinNo > 0, FuyinNo),   % 如果策划填表有误，则会导致断言失败，下同
    mod_fabao:player_add_fuyin(PS, FuyinNo, 0, _UseCount);

apply_one_effect__(for_player, PS, ?EN_ADD_RECHARGE_MONEY, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    Vouchers = Eff#goods_eff.para,
    Status = player:get_recharge_accum(Vouchers, PS),
    db:update(player:id(PS), player, [{recharge_accum, util:term_to_bitstring(Status#player_status.recharge_accum)}], [{id, player:id(PS)}]),
    player_syn:update_PS_to_ets(Status).





%% ---------------------------------------------------------------------------------------
%%  往宠物加效果

%% 应用单个物品效果到玩家：加xx点血 品质相关
apply_one_effect__(for_partner, _PS, PartnerId, ?EN_ADD_HP_BY_QUALITY, Eff, Goods, UseCount) ->
    {BaseAdd,QualityAdd} = Eff#goods_eff.para,
    HpAdd = util:ceil(BaseAdd + (QualityAdd * lib_goods:get_quality_lv(Goods))) * UseCount,

    ?ASSERT(is_integer(HpAdd) andalso HpAdd > 0, HpAdd),   % 如果策划填表有误，则会导致断言失败，下同
    case lib_partner:get_partner(PartnerId) of
        null ->
            ?ASSERT(false, PartnerId),
            skip;
        Partner ->
            Partner1 = lib_partner:set_hp(Partner, lib_partner:get_hp(Partner) + HpAdd),
            mod_partner:update_partner_to_ets(Partner1)
    end;
%% 应用单个物品效果到玩家：加xx点法 品质相关
apply_one_effect__(for_partner, _PS, PartnerId, ?EN_ADD_MP_BY_QUALITY, Eff, Goods, UseCount) ->
    {BaseAdd,QualityAdd} = Eff#goods_eff.para,
    MpAdd = util:ceil(BaseAdd + (QualityAdd * lib_goods:get_quality_lv(Goods))) * UseCount,
    
    ?ASSERT(is_integer(MpAdd) andalso MpAdd > 0, MpAdd),   % 如果策划填表有误，则会导致断言失败，下同
    case lib_partner:get_partner(PartnerId) of
        null ->
            ?ASSERT(false, PartnerId),
            skip;
        Partner ->
            Partner1 = lib_partner:set_mp(Partner, lib_partner:get_mp(Partner) + MpAdd),
            mod_partner:update_partner_to_ets(Partner1)
    end;


apply_one_effect__(for_partner, _PS, PartnerId, ?EN_ADD_HP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case lib_partner:get_partner(PartnerId) of
        null ->
            ?ASSERT(false, PartnerId),
            skip;
        Partner ->
            Partner1 = lib_partner:set_hp(Partner, lib_partner:get_hp(Partner) + Add),
            mod_partner:update_partner_to_ets(Partner1)
    end;

apply_one_effect__(for_partner, _PS, PartnerId, ?EN_ADD_MP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case lib_partner:get_partner(PartnerId) of
        null ->
            ?ASSERT(false, PartnerId),
            skip;
        Partner ->
            Partner1 = lib_partner:set_mp(Partner, lib_partner:get_mp(Partner) + Add),
            mod_partner:update_partner_to_ets(Partner1)
    end;

apply_one_effect__(for_partner, _PS, PartnerId, ?EN_ADD_LIFE, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case lib_partner:get_partner(PartnerId) of
        null ->
            ?ASSERT(false, PartnerId),
            skip;
        Partner ->
            Partner1 = lib_partner:set_life(Partner, lib_partner:get_life(Partner) + Add),
            mod_partner:update_partner_to_ets(Partner1)
    end;


% 洗点宠物
apply_one_effect__(for_partner, PS, PartnerId, ?EN_TURN_TALENT_TO_FREE, _Eff, _Goods, _UseCount) ->
    case lib_partner:get_partner(PartnerId) of
        null ->
            ?ASSERT(false, PartnerId),
            skip;
        _Partner ->
            lib_partner:reset_free_talent_points(PS,PartnerId)
    end;

% 洗力量
apply_one_effect__(for_partner, PS, PartnerId, ?EN_SUB_STR, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case lib_partner:get_partner(PartnerId) of
        null ->
            ?ASSERT(false, PartnerId),
            skip;
        Partner ->
            case lib_partner:get_base_str(Partner) - lib_partner:get_lv(Partner) >= Add of
                false ->
                    skip;
                true ->
                    NewPar4 = lib_partner:set_base_str(Partner,lib_partner:get_base_str(Partner) - Add),
                    NewPar5 = lib_partner:set_free_talent_points(NewPar4,lib_partner:get_free_talent_points(NewPar4) + Add),
                    NewPar6 = lib_partner:calc_base_attrs(NewPar5),
                    NewPar7 = lib_partner:recount_total_attrs(NewPar6),
                    NewPar8 = lib_partner:recount_battle_power(NewPar7),
                    mod_partner:update_partner_to_ets(NewPar8),
                    mod_partner:db_save_partner(NewPar8),
                    lib_partner:notify_cli_info_change(PS, NewPar8)
            end
    end;
apply_one_effect__(for_partner, PS, PartnerId, ?EN_SUB_CON, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case lib_partner:get_partner(PartnerId) of
        null ->
            ?ASSERT(false, PartnerId),
            skip;
        Partner ->
            case lib_partner:get_base_con(Partner) - lib_partner:get_lv(Partner) >= Add of
                    false ->
                        skip;
                    true ->
                        NewPar4 = lib_partner:set_base_con(Partner,lib_partner:get_base_con(Partner) - Add),
                        NewPar5 = lib_partner:set_free_talent_points(NewPar4,lib_partner:get_free_talent_points(NewPar4) + Add),
                        NewPar6 = lib_partner:calc_base_attrs(NewPar5),
                        NewPar7 = lib_partner:recount_total_attrs(NewPar6),
                        NewPar8 = lib_partner:recount_battle_power(NewPar7),
                        mod_partner:update_partner_to_ets(NewPar8),
                        mod_partner:db_save_partner(NewPar8),
                        lib_partner:notify_cli_info_change(PS, NewPar8)
            end
    end;
apply_one_effect__(for_partner, PS, PartnerId, ?EN_SUB_STA, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case lib_partner:get_partner(PartnerId) of
        null ->
            ?ASSERT(false, PartnerId),
            skip;
        Partner ->
            case lib_partner:get_base_stam(Partner) >= Add of
                false ->
                    skip;
                true ->
                    NewPar4 = lib_partner:set_base_stam(Partner,lib_partner:get_base_stam(Partner) - Add),
                    NewPar5 = lib_partner:set_free_talent_points(NewPar4,lib_partner:get_free_talent_points(NewPar4) + Add),
                    NewPar6 = lib_partner:calc_base_attrs(NewPar5),
                    NewPar7 = lib_partner:recount_total_attrs(NewPar6),
                    NewPar8 = lib_partner:recount_battle_power(NewPar7),
                    mod_partner:update_partner_to_ets(NewPar8),
                    mod_partner:db_save_partner(NewPar8),
                    lib_partner:notify_cli_info_change(PS, NewPar8)
            end
    end;
apply_one_effect__(for_partner, PS, PartnerId, ?EN_SUB_SPI, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case lib_partner:get_partner(PartnerId) of
        null ->
            ?ASSERT(false, PartnerId),
            skip;
        Partner ->
            case lib_partner:get_base_spi(Partner) - lib_partner:get_lv(Partner) >= Add of
                false ->
                    skip;
                true ->
                    NewPar4 = lib_partner:set_base_spi(Partner,lib_partner:get_base_spi(Partner) - Add),
                    NewPar5 = lib_partner:set_free_talent_points(NewPar4,lib_partner:get_free_talent_points(NewPar4) + Add),
                    NewPar6 = lib_partner:calc_base_attrs(NewPar5),
                    NewPar7 = lib_partner:recount_total_attrs(NewPar6),
                    NewPar8 = lib_partner:recount_battle_power(NewPar7),
                    mod_partner:update_partner_to_ets(NewPar8),
                    mod_partner:db_save_partner(NewPar8),
                    lib_partner:notify_cli_info_change(PS, NewPar8)
            end
    end;
apply_one_effect__(for_partner, PS, PartnerId, ?EN_SUB_AGI, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case lib_partner:get_partner(PartnerId) of
        null ->
            ?ASSERT(false, PartnerId),
            skip;
        Partner ->
            case lib_partner:get_base_agi(Partner) - lib_partner:get_lv(Partner) >= Add of
                false ->
                    skip;
                true ->
                    NewPar4 = lib_partner:set_base_agi(Partner,lib_partner:get_base_agi(Partner) - Add),
                    NewPar5 = lib_partner:set_free_talent_points(NewPar4,lib_partner:get_free_talent_points(NewPar4) + Add),
                    NewPar6 = lib_partner:calc_base_attrs(NewPar5),
                    NewPar7 = lib_partner:recount_total_attrs(NewPar6),
                    NewPar8 = lib_partner:recount_battle_power(NewPar7),
                    mod_partner:update_partner_to_ets(NewPar8),
                    mod_partner:db_save_partner(NewPar8),
                    lib_partner:notify_cli_info_change(PS, NewPar8)
            end
    end;


apply_one_effect__(for_partner, _PS, PartnerId, ?EN_ADD_LOYALTY, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case lib_partner:get_partner(PartnerId) of
        null ->
            ?ASSERT(false, PartnerId),
            skip;
        Partner ->
            Partner1 = lib_partner:set_loyalty(Partner, lib_partner:get_loyalty(Partner) + Add),
            mod_partner:update_partner_to_ets(Partner1)
    end;


%% 应用单个物品效果到玩家：加xx点经验
apply_one_effect__(for_partner, PS, PartnerId, ?EN_ADD_EXP, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    lib_partner:add_exp_without_world_lv(PartnerId, Add, PS, [?LOG_GIF, _Goods#goods.no]);


%% 宠物技能打书，目前需求是不区分先天和后天，只要最大格子数满足且未学过此技能就可以学习，不再限制先天和后天各自的上限
apply_one_effect__(for_partner, PS, PartnerId, ?EN_CHANGE_SKILL, Eff, _Goods, _UseCount) ->
    ?ASSERT(_UseCount =:= 1, _UseCount),
    Add = Eff#goods_eff.para,
    ?ASSERT(is_integer(Add) andalso Add > 0, Eff),   % 如果策划填表有误，则会导致断言失败，下同
    _SklCfg = mod_skill:get_cfg_data(Add),

    % case mod_skill:is_inborn_skill(_SklCfg) of
    %     true ->
    %         ?ASSERT(mod_skill:is_inborn_skill(_SklCfg) =:= false, Eff),
    %         ?ERROR_MSG("lib_goods_eff: EN_CHANGE_SKILL error!~n", []);
    %     false -> skip
    % end,

%%     IsInborn = mod_skill:is_inborn_skill(_SklCfg),

    Partner = lib_partner:get_partner(PartnerId),
%%     PosSkillList = lib_partner:get_postnatal_skill_list(Partner),
	%% 这里的MaxSlot不再是最大后天技能数，而是最大已开启的技能格子数，只要当前页的技能列表数量小于这个值就可以学习，否则就要通过扩展才可以学习
    MaxSlot = lib_partner:get_max_postnatal_skill_slot(Partner),
	
	
	SkillList = lib_partner:get_skill_list(Partner),
	
	case lists:keyfind(Add, #skl_brief.id, SkillList) of
		false ->% 可以学习
%% 			OldSkillList = lib_partner:get_skill_list(Partner),
			Skill = #skl_brief{id = Add},
			NewSkillList = [Skill] ++ SkillList,
			Partner1 = lib_partner:set_skill_list(Partner, NewSkillList),
			% Partner2 = lib_partner:recount_passi_eff_attrs(Partner1),
			Partner3 = lib_partner:recount_total_attrs(Partner1),
			Partner4 = lib_partner:recount_battle_power(Partner3),
			% Partner5 = lib_partner:set_add_skill_fail_cnt(Partner4, 0),
			mod_partner:update_partner_to_ets(Partner4),
			mod_partner:db_save_partner(Partner4),
			
			%% @State : 1->获得新技能 0->替换技能
			lib_log:statis_partner_get_skill(PS, Add, 1),
			lib_log:statis_role_action(PS, [], ?LOG_PARTNER, "pet_skill", [lib_partner:get_name(Partner), Add, ?INVALID_NO, lib_partner:get_id(Partner)]),
			
			lib_event:event(change_skill, [], PS),
			
			ply_tips:send_sys_tips(PS, {partner_add_skill, [
															player:get_name(PS),
															player:id(PS),
															lib_partner:get_name(Partner),
															lib_partner:get_id(Partner), 
															lib_partner:get_quality(Partner),
															lib_partner:get_no(Partner),
															Skill#skl_brief.id
														   ]}),
			
			lib_partner:notify_cli_info_change(PS, Partner4),
			mod_achievement:notify_achi(par_active_skill, [], PS);
		% lib_partner:notify_cli_info_change(Partner4, [{?OI_CODE_PAR_ADD_SKILL, Skill#skl_brief.id}]);
		_Any ->
			% 已学习，不可重复学习
			?ASSERT(false, _Any),
			?ERROR_MSG("lib_goods_eff: EN_CHANGE_SKILL add error!~w~n", [_Any])
	end;
	
	
	
	
	
%%     CurPSkillCnt = length(PosSkillList),

%%     InbornCount =  lists:foldl(fun(_X, Sum) -> Sum + 1 end, 0, lib_partner:get_inborn_skill_name_list(Partner)),

%%     RandNum = util:rand(1, 10000),
%%     {AddProb, CoefA} = 
%%         case data_par_change_skill:get(MaxSlot, CurPSkillCnt) of
%%             null -> {0, 0};
%%             ChangeSkillCfg -> {util:ceil(ChangeSkillCfg#change_skill_cfg.prob), ChangeSkillCfg#change_skill_cfg.coef_a}
%%         end,
    %% 当前成功率= 概率 + (1-概率) * {1/ [ (10000/概率) * (1+1/失败累计系数*失败累计次数) ]} * 失败累计次数
    %% 概率 = prob/10000 (prob读表)
%%     FailCnt = lib_partner:get_add_skill_fail_cnt(Partner),
%%     CurAddProb = 
%%         case FailCnt > 0 of
%%             false -> AddProb;
%%             true -> 
%%                 case CoefA =:= 0 of
%%                     true -> AddProb;
%%                     false ->
%%                         util:floor( ( AddProb/10000 + (1-AddProb/10000) * ( 1 / ( AddProb * (1 + 1/CoefA*FailCnt) ) ) ) * 10000 )
%%                 end
%%         end,

%%     ?INFO_MSG("lib_goods_eff: EN_CHANGE_SKILL FailCnt:~p, CurAddProb:~p,~n", [FailCnt, CurAddProb]), 
%% 	
%% 	
%% 
%%     % 判断增加技能或者是先天技能
%%     case (1 =< RandNum andalso RandNum =< CurAddProb) orelse IsInborn of
%%         true -> %% 增加技能
%% 
%%             % 判断是否有相同技能
%%             case has_skill_with_same_type(Partner, Add) of
%%                 false -> % 新增
%%                     Skill = #skl_brief{id = Add},
%%                     % 如果是先天技能且先天技能满了
%%                     case IsInborn andalso InbornCount >= ?MAX_INBORN_COUNT of
%%                         false ->
%%                             case lists:keyfind(Add, #skl_brief.id, PosSkillList) of
%%                                 false ->
%%                                     OldSkillList = lib_partner:get_skill_list(Partner),
%%                                     ?ASSERT(lists:keyfind(Add, #skl_brief.id, OldSkillList) =:= false, {Add, OldSkillList}),
%%                                     NewSkillList = [Skill] ++ OldSkillList,
%%                                     Partner1 = lib_partner:set_skill_list(Partner, NewSkillList),
%%                                     % Partner2 = lib_partner:recount_passi_eff_attrs(Partner1),
%%                                     Partner3 = lib_partner:recount_total_attrs(Partner1),
%%                                     Partner4 = lib_partner:recount_battle_power(Partner3),
%%                                     % Partner5 = lib_partner:set_add_skill_fail_cnt(Partner4, 0),
%%                                     mod_partner:update_partner_to_ets(Partner4),
%%                                     mod_partner:db_save_partner(Partner4),
%%                                     
%%                                     %% @State : 1->获得新技能 0->替换技能
%%                                     lib_log:statis_partner_get_skill(PS, Add, 1),
%%                                     lib_log:statis_role_action(PS, [], ?LOG_PARTNER, "pet_skill", [lib_partner:get_name(Partner), Add, ?INVALID_NO, lib_partner:get_id(Partner)]),
%% 
%%                                     lib_event:event(change_skill, [], PS),
%% 
%%                                     % 先天技能不提示
%%                                     case IsInborn of 
%%                                         false ->
%%                                             ply_tips:send_sys_tips(PS, {partner_add_skill, [
%%                                                 player:get_name(PS),
%%                                                 player:id(PS),
%%                                                 lib_partner:get_name(Partner),
%%                                                 lib_partner:get_id(Partner), 
%%                                                 lib_partner:get_quality(Partner),
%%                                                 lib_partner:get_no(Partner),
%%                                                 Skill#skl_brief.id
%%                                             ]});
%%                                         true -> skip
%%                                     end,
%% 
%%                                     lib_partner:notify_cli_info_change(PS, Partner4),
%%                                     mod_achievement:notify_achi(par_active_skill, [], PS);
%%                                     % lib_partner:notify_cli_info_change(Partner4, [{?OI_CODE_PAR_ADD_SKILL, Skill#skl_brief.id}]);
%%                                 _Any ->
%%                                     ?ASSERT(false, _Any),
%%                                     ?ERROR_MSG("lib_goods_eff: EN_CHANGE_SKILL add error!~w~n", [_Any])
%%                             end;
%%                         ___Any ->
%%                             ?ASSERT(false, ___Any),
%%                             ?ERROR_MSG("lib_goods_eff: EN_CHANGE_SKILL add error!~w~n", [___Any])
%%                     end;
%%                     
%%                 true -> %% 替换
%%                     SkillAdd = #skl_brief{id = Add},
%%                     SkillDel = get_rand_del_skill(Partner, Add),
%%                     SkillList = lib_partner:get_skill_list(Partner) -- [SkillDel],
%% 
%%                     case lists:keyfind(SkillAdd#skl_brief.id, #skl_brief.id, SkillList) of
%%                         false ->
%%                             SkillList1 = [SkillAdd] ++ SkillList,
%%                             Partner1 = lib_partner:set_skill_list(Partner, SkillList1),
%%                             % Partner2 = lib_partner:recount_passi_eff_attrs(Partner1),
%%                             Partner3 = lib_partner:recount_total_attrs(Partner1),
%%                             Partner4 = lib_partner:recount_battle_power(Partner3),
%%                             Partner5 = lib_partner:set_add_skill_fail_cnt(Partner4, FailCnt+1),
%%                             mod_partner:update_partner_to_ets(Partner5),
%%                             mod_partner:db_save_partner(Partner5),
%%                             %% @State : 1->获得新技能 0->替换技能
%%                             lib_log:statis_partner_get_skill(PS, Add, 0),
%%                             lib_log:statis_role_action(PS, [], ?LOG_PARTNER, "pet_skill", [lib_partner:get_name(Partner), Add, SkillDel#skl_brief.id, lib_partner:get_id(Partner)]),
%% 
%%                             ply_tips:send_sys_tips(PS, {partner_change_skill, [
%%                                         lib_partner:get_name(Partner),
%%                                         lib_partner:get_id(Partner), 
%%                                         lib_partner:get_quality(Partner),
%%                                         lib_partner:get_no(Partner),
%%                                         SkillAdd#skl_brief.id, 
%%                                         SkillDel#skl_brief.id
%%                                     ]}),
%% 
%%                             lib_event:event(change_skill, [], PS),
%%                             lib_partner:notify_cli_info_change(PS, Partner5);
%%                             % lib_partner:notify_cli_info_change(Partner5, [{?OI_CODE_PAR_DEL_SKILL, SkillDel#skl_brief.id}, {?OI_CODE_PAR_ADD_SKILL, SkillAdd#skl_brief.id}]);
%%                         _Any -> %% 增加的与被替换的技能一样  
%%                             SkillList1 = [SkillDel] ++ SkillList,
%%                             Partner1 = lib_partner:set_skill_list(Partner, SkillList1),
%%                             Partner2 = lib_partner:set_add_skill_fail_cnt(Partner1, FailCnt+1),
%%                             mod_partner:update_partner_to_ets(Partner2),
%%                             mod_partner:db_save_partner(Partner2),
%%                             %% @State : 1->获得新技能 0->替换技能
%%                             lib_log:statis_partner_get_skill(PS, SkillDel#skl_brief.id, 0),
%%                             lib_log:statis_role_action(PS, [], ?LOG_PARTNER, "pet_skill", [lib_partner:get_name(Partner), Add, SkillDel#skl_brief.id, lib_partner:get_id(Partner)]),
%% 
%%                             ply_tips:send_sys_tips(PS, {partner_change_skill, [
%%                                         lib_partner:get_name(Partner),
%%                                         lib_partner:get_id(Partner), 
%%                                         lib_partner:get_quality(Partner),
%%                                         lib_partner:get_no(Partner),
%%                                         SkillDel#skl_brief.id,
%%                                         SkillDel#skl_brief.id
%%                                     ]}),
%% 
%%                             lib_partner:notify_cli_info_change(PS, Partner2)
%%                             % lib_partner:notify_cli_info_change(Partner2, [{?OI_CODE_PAR_DEL_SKILL, SkillDel#skl_brief.id}, {?OI_CODE_PAR_ADD_SKILL, SkillDel#skl_brief.id}])
%%                     end
%%             end;
%%         false -> %% 替换技能
%%             case has_skill_with_same_type(Partner, Add) of
%%                 true -> %% 不增加不替换，防止先打到低级的技能，然后打高级技能，必然获得高级技能的情况
%%                     skip;
%%                 false -> %% 替换
%%                     case CurPSkillCnt >= 1 of
%%                         false -> skip; %% 无法替换
%%                         true ->
%% 							mod_achievement:notify_achi(par_passive_skills, [], PS),
%%                             SkillAdd = #skl_brief{id = Add},
%%                             SkillDel = lists:nth(util:rand(1, CurPSkillCnt), PosSkillList),
%%                             SkillList = lib_partner:get_skill_list(Partner) -- [SkillDel],
%% 
%%                             case lists:keyfind(SkillAdd#skl_brief.id, #skl_brief.id, SkillList) of
%%                                 false ->
%%                                     SkillList1 = [SkillAdd] ++ SkillList,
%%                                     Partner1 = lib_partner:set_skill_list(Partner, SkillList1),
%%                                     % Partner2 = lib_partner:recount_passi_eff_attrs(Partner1),
%%                                     Partner3 = lib_partner:recount_total_attrs(Partner1),
%%                                     Partner4 = lib_partner:recount_battle_power(Partner3),
%%                                     Partner5 = lib_partner:set_add_skill_fail_cnt(Partner4, FailCnt+1),
%%                                     mod_partner:update_partner_to_ets(Partner5),
%%                                     mod_partner:db_save_partner(Partner5),
%%                                     %% @State : 1->获得新技能 0->替换技能
%%                                     lib_log:statis_partner_get_skill(PS, Add, 0),
%%                                     lib_log:statis_role_action(PS, [], ?LOG_PARTNER, "pet_skill", [lib_partner:get_name(Partner), Add, SkillDel#skl_brief.id, lib_partner:get_id(Partner)]),
%% 
%%                                     lib_event:event(change_skill, [], PS),
%% 
%%                                     ply_tips:send_sys_tips(PS, {partner_change_skill, [
%%                                         lib_partner:get_name(Partner),
%%                                         lib_partner:get_id(Partner), 
%%                                         lib_partner:get_quality(Partner),
%%                                         lib_partner:get_no(Partner),
%%                                         SkillAdd#skl_brief.id,
%%                                         SkillDel#skl_brief.id
%%                                     ]}),
%% 
%%                                     lib_partner:notify_cli_info_change(PS, Partner5);
%%                                     % lib_partner:notify_cli_info_change(Partner5, [{?OI_CODE_PAR_DEL_SKILL, SkillDel#skl_brief.id}, {?OI_CODE_PAR_ADD_SKILL, SkillAdd#skl_brief.id}]);
%%                                 _Any ->
%%                                     SkillList1 = [SkillDel] ++ SkillList,
%%                                     Partner1 = lib_partner:set_skill_list(Partner, SkillList1),
%%                                     Partner2 = lib_partner:set_add_skill_fail_cnt(Partner1, FailCnt+1),
%%                                     mod_partner:update_partner_to_ets(Partner2),
%%                                     mod_partner:db_save_partner(Partner2),
%%                                     %% @State : 1->获得新技能 0->替换技能
%%                                     lib_log:statis_partner_get_skill(PS, SkillDel#skl_brief.id, 0),
%%                                     lib_log:statis_role_action(PS, [], ?LOG_PARTNER, "pet_skill", [lib_partner:get_name(Partner), Add, SkillDel#skl_brief.id, lib_partner:get_id(Partner)]),
%%                                     
%% 
%%                                      ply_tips:send_sys_tips(PS, {partner_change_skill, [
%%                                         lib_partner:get_name(Partner),
%%                                         lib_partner:get_id(Partner), 
%%                                         lib_partner:get_quality(Partner),
%%                                         lib_partner:get_no(Partner),
%%                                         SkillDel#skl_brief.id,
%%                                         SkillDel#skl_brief.id
%%                                     ]}),
%% 
%%                                     lib_partner:notify_cli_info_change(PS, Partner2)
%%                                     % lib_partner:notify_cli_info_change(Partner2, [{?OI_CODE_PAR_DEL_SKILL, SkillDel#skl_brief.id}, {?OI_CODE_PAR_ADD_SKILL, SkillDel#skl_brief.id}])
%%                             end
%%                     end
%%             end
%%     end;


apply_one_effect__(for_partner, PS, PartnerId, ?EN_ADD_PAR_EVOLVE, Eff, _Goods, UseCount) ->
    Add = Eff#goods_eff.para * UseCount,
    ?ASSERT(is_integer(Add) andalso Add > 0, Add),   % 如果策划填表有误，则会导致断言失败，下同
    case lib_partner:get_partner(PartnerId) of
        null -> skip;
        Partner -> lib_partner:add_evolve(PS, Partner, Add)
    end.


%% ----------------------------------------------------Local Fun---------------------------------------------------------


% get_dig_treasure_prob_list([]) ->
%     [];
% get_dig_treasure_prob_list([No | T]) ->
%     get_dig_treasure_prob_list([No | T], []).

% get_dig_treasure_prob_list([], AccList) ->
%     AccList;
% get_dig_treasure_prob_list([No | T], AccList) ->
%     case data_dig_treasure:get(No) of
%         null ->
%             get_dig_treasure_prob_list(T, AccList);
%         Data ->
%             get_dig_treasure_prob_list(T, [Data#dig_treasure.prob] ++ AccList)
%     end.

% is_valid_dig_treasure_prob(ProbList) ->
%     Sum = lists:foldl(fun(Prob, S) -> S + Prob end, 0, ProbList),
%     Sum =:= 1.


% decide_dig_treasure_no(WeightList, RandNum) ->
%     decide_dig_treasure_no(WeightList, RandNum, 0, 1).

% decide_dig_treasure_no([H | T], RandNum, SumToCompare, CurNo) ->
%     SumToCompare_2 = H + SumToCompare,
%     case RandNum =< SumToCompare_2 of
%         true ->
%             CurNo;
%         false ->
%             decide_dig_treasure_no(T, RandNum, SumToCompare_2, CurNo + 1)
%     end;
% decide_dig_treasure_no([], _RandNum, _SumToCompare, _CurNo) ->
%     ?ASSERT(false), 1.


% get_player_lv_step(_Lv, []) ->
%     ?ASSERT(false),
%     ?INVALID_NO;
% get_player_lv_step(Lv, [Step | T]) ->
%     case data_dig_treasure_spawn_mon:get(Step) of
%         null ->
%             get_player_lv_step(Lv, T);
%         Data ->
%             Range = Data#spawn_mon.lv_region,
%             case util:in_range(Lv, lists:nth(1, Range), lists:nth(2, Range)) of
%                 true ->
%                     Step;
%                 false ->
%                     get_player_lv_step(Lv, T)
%             end
%     end.

decide_get_no(ProbList) ->
    F = fun({_, Prob}, Sum) ->
        Sum + util:ceil(Prob * 1000)
    end,
    Range = lists:foldl(F, 0, ProbList),
    decide_get_no(ProbList, util:rand(1, Range), 0).

decide_get_no([H | T], RandNum, SumToCompare) ->
    GoodsNo = element(1, H),
    Prob = util:ceil(element(2, H) * 1000), %% 策划填写概率只支持1到100的整数或者浮点数(最小支持三位小数)
    SumToCompare_2 = Prob + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true ->
            GoodsNo;
        false ->
            decide_get_no(T, RandNum, SumToCompare_2)
    end;
decide_get_no([], _RandNum, _SumToCompare) ->
    ?ASSERT(false),
    ?INVALID_NO.  % 正常逻辑不会触发此分支，返回最低品质以容错！

%% TaskList --> [{TaskId, Prob},...]
rand_get_one_valid_task(PS, TaskList) ->
    TaskList1 = [{Id, Prob} || {Id, Prob} <- TaskList, lib_task:publ_is_can_accept(Id, PS)],
    ?DEBUG_MSG("lib_goods_eff:rand_get_one_valid_task:TaskList1:~w~n", [TaskList1]),
    rand_get_one_valid_task(PS, TaskList1, 50000).

rand_get_one_valid_task(PS, _TaskList, 0) ->
    ?ERROR_MSG("lib_goods_eff:rand_get_one_valid_task error:PlayerId:~p, _TaskList:~w~n", [player:id(PS), _TaskList]),
    ?INVALID_ID;
rand_get_one_valid_task(PS, TaskList, TryCount) when TryCount > 0 ->
    TaskId = decide_get_no(TaskList),
    case lib_task:publ_is_can_accept(TaskId, PS) of
        true -> TaskId;
        false -> rand_get_one_valid_task(PS, TaskList, TryCount-1)
    end.


% has_low_skill_with_same_type(Partner, SkillId) when is_integer(SkillId) ->
%     case data_skill:get(SkillId) of
%         null -> false;
%         SklCfg -> has_low_skill_with_same_type(lib_partner:get_skill_name_list(Partner), binary_to_list(SklCfg#skl_cfg.name))
%     end;
% has_low_skill_with_same_type([H | T], Name) ->
%     case string:str(Name, binary_to_list(H)) =/= 0 of
%         true -> true;
%         false -> has_low_skill_with_same_type(T, Name)
%     end;
% has_low_skill_with_same_type([], _Name) ->
%     false.

has_skill_with_same_type(Partner, SkillId) when is_integer(SkillId) ->
    case data_skill:get(SkillId) of
        null -> false;
        SklCfg -> has_skill_with_same_type(lib_partner:get_skill_name_list(Partner), binary_to_list(SklCfg#skl_cfg.name))
    end;
has_skill_with_same_type([H | T], Name) ->
    case Name == binary_to_list(H) of
        true -> true;
        false -> has_skill_with_same_type(T, Name)
    end;
has_skill_with_same_type([], _Name) ->
    false.

get_rand_del_skill(Partner, SkillId) when is_integer(SkillId) ->
    PosSkillList = lib_partner:get_postnatal_skill_list(Partner),
    case has_skill_with_same_type(Partner, SkillId) of
        false -> lists:nth(util:rand(1, length(PosSkillList)), PosSkillList);
        true ->
            case data_skill:get(SkillId) of
                null ->
                    ?ASSERT(false, SkillId),
                    lists:nth(util:rand(1, length(PosSkillList)), PosSkillList);
                SklCfg -> get_rand_del_skill(PosSkillList, binary_to_list(SklCfg#skl_cfg.name))
            end
    end;

get_rand_del_skill([H | T], Name) ->
    NameHave =
        case data_skill:get(H#skl_brief.id) of
            null -> ?ASSERT(false, H#skl_brief.id), <<>>;
            SklCfg -> SklCfg#skl_cfg.name
        end,
    case string:str(Name, binary_to_list(NameHave)) =/= 0 of
        true -> H;
        false -> get_rand_del_skill(T, Name)
    end;
get_rand_del_skill([], _Name) ->
    ?ASSERT(false, _Name),
    [].


%% return {AddCon, AddSta, AddSpi, AddAgi, AddStr}
get_lv_break_add_talents(NowLv) ->
    F = fun(Lv, {AccCon, AccSta, AccSpi, AccAgi, AccStr}) ->
        case NowLv > Lv of
            false -> {AccCon, AccSta, AccSpi, AccAgi, AccStr};
            true ->
                case data_lv_break:get(Lv) of
                    null -> {AccCon, AccSta, AccSpi, AccAgi, AccStr};
                    Data -> {
                            Data#lv_break.reward_con + AccCon,
                            Data#lv_break.reward_sta + AccSta,
                            Data#lv_break.reward_spi + AccSpi,
                            Data#lv_break.reward_agi + AccAgi,
                            Data#lv_break.reward_str + AccStr
                            }
                end
        end
    end,
    lists:foldl(F, {0, 0, 0, 0, 0}, data_lv_break:get_to_break_lv_list()).



% List  -> [{TaskId, MonNo},...]
get_mon_no_by_task(_PS, []) ->
    ?INVALID_NO;
get_mon_no_by_task(PS, [{TaskId, MonNo} | T]) ->
    case lib_task:publ_is_accepted(TaskId, PS) of
        true -> MonNo;
        false -> get_mon_no_by_task(PS, T)
    end.


get_finish_task([], _) ->
    ?INVALID_ID;
get_finish_task([H | T], CfgTaskIdL) ->
    case lists:member(H, CfgTaskIdL) of
        true -> H;
        false -> get_finish_task(T, CfgTaskIdL)
    end.

