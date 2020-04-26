%%%-----------------------------------
%%% @Module  : pp_npc
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.06.13
%%% @Modified: 2013.7  -- huangjf
%%% @Description: NPC、明雷怪相关协议的处理
%%%-----------------------------------
-module(pp_npc).
-export([handle/3
		]).
-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("npc.hrl").
-include("protocol/pt_32.hrl").
-include("num_limits.hrl").
-include("prompt_msg_code.hrl").
-include("guild_dungeon.hrl").

%% =============================== NPC相关 =======================================

%% 查询npc的功能列表
handle(?PT_QRY_NPC_FUNC_LIST, PS, NpcId) ->
    case mod_npc:get_obj(NpcId) of
        null ->
            ?ASSERT(false, NpcId),
            skip;
        Npc ->
            FuncList = build_npc_func_list(PS, Npc),
            ?ASSERT(util:is_binary_list(FuncList)),
            {ok, BinData} = pt_32:write(?PT_QRY_NPC_FUNC_LIST, [NpcId, FuncList]),
            lib_send:send_to_sock(PS, BinData)
    end;


%% 查询npc的教授技能列表
handle(?PT_QRY_NPC_TEACH_SKILL_LIST, PS, NpcId) ->
    case mod_npc:get_obj(NpcId) of
        null ->
            ?ASSERT(false, NpcId),
            skip;
        Npc ->
            SkillIdList = mod_npc:get_teach_skill_list(Npc),
            {ok, BinData} = pt_32:write(?PT_QRY_NPC_TEACH_SKILL_LIST, [NpcId, SkillIdList]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_BUY_GOODS_FROM_NPC, PS, [NpcId, GoodsNo, Count, ShopNo]) ->
    case ply_trade:buy_goods_from_npc(PS, NpcId, GoodsNo, Count, ShopNo) of
        ok ->
            %向NPC购买物品通知成就
            mod_achievement:notify_achi(buy_goods, [], PS),
            {ok, BinData} = pt_32:write(?PT_BUY_GOODS_FROM_NPC, [?RES_OK, GoodsNo, Count]),
            lib_send:send_to_sock(PS, BinData);
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason),
            RetCode = 
            case Reason of
                ?PM_GOODS_SELL_OVER -> 1;
                ?PM_BUY_COUNT_LIMIT -> 2;
                _Any -> 0
            end,
            {ok, BinData} = pt_32:write(?PT_BUY_GOODS_FROM_NPC, [RetCode, GoodsNo, Count]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_QUERY_GOODS_BY_NPC, PS, [NpcId, ShopNo]) ->
    NpcShopGoodsInfoL = ply_trade:get_goods_list_by_npc(NpcId, ShopNo),
    {ok, BinData} = pt_32:write(?PT_QUERY_GOODS_BY_NPC, [player:get_id(PS), NpcId, NpcShopGoodsInfoL]),
    lib_send:send_to_sock(PS, BinData);


handle(?PT_QRY_BUY_BACK_LIST, PS, _) ->
    GoodsList = ply_trade:get_buy_back_list(PS),
    {ok, BinData} = pt_32:write(?PT_QRY_BUY_BACK_LIST, [GoodsList]),
    lib_send:send_to_sock(PS, BinData);


handle(?PT_BUY_BACK, PS, [GoodsId, StackCount]) ->
    case ply_trade:buy_back(PS, GoodsId, StackCount) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_32:write(?PT_BUY_BACK, [?RES_OK, GoodsId, StackCount]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_COLLECT_OK, PS, [NpcId]) ->
	case mod_npc:get_obj(NpcId) of
			null ->
				lib_send:send_prompt_msg(PS, ?PM_NPC_NOT_EXISTS);
			_ ->
				case mod_npc:get_no_by_id(NpcId) of 
					5900 -> %帮派副本第一关，目前写死处理
						lib_guild_dungeon:collect_point(PS,NpcId);
					5901 ->
						lib_guild_dungeon:collect_point(PS,NpcId);
					5902 ->
						lib_guild_dungeon:collect_point(PS,NpcId);
					
					_ -> case lib_npc:collect_from_npc(PS, NpcId) of
							 {fail, Reason} ->
								 lib_send:send_prompt_msg(PS, Reason);
							 ok ->
								 skip
						 end
				end
	end;
	
			
    

handle(?PT_EXCHANGE_GOODS_FROM_NPC, PS, [NpcId, No]) ->
    case ply_trade:exchange_goods(PS, NpcId, No) of
        {fail, Reason} ->
            {ok, BinData} = pt_32:write(?PT_EXCHANGE_GOODS_FROM_NPC, [Reason, No]),
            lib_send:send_to_sock(PS, BinData);
        ok ->
            {ok, BinData} = pt_32:write(?PT_EXCHANGE_GOODS_FROM_NPC, [1, No]),
            lib_send:send_to_sock(PS, BinData)
    end;

handle(?PT_EXCHANGE_GOODS_FROM_SHOP, PS, [ExChangeNo, Num]) ->
    ply_trade:new_exchange_goods(player:get_id(PS), ExChangeNo, Num);

handle(?PT_EXCHANGE_SPECIAL_GOODS_FROM_NPC, PS, [NpcId, No,Num]) ->
    case ply_trade:exchange_special_goods(PS, NpcId, No,Num) of
        {fail, Reason} ->
            {ok, BinData} = pt_32:write(?PT_EXCHANGE_SPECIAL_GOODS_FROM_NPC, [Reason, No]),
            lib_send:send_to_sock(PS, BinData);
        ok ->
            {ok, BinData} = pt_32:write(?PT_EXCHANGE_SPECIAL_GOODS_FROM_NPC, [1, No]),
            lib_send:send_to_sock(PS, BinData)
    end;

handle(?PT_BUY_GOODS_FROM_CREDIT_NPC, PS, [Id, Count]) ->
    ply_trade:credit_buy(PS, Id, Count);


handle(?PT_START_MF_BY_TALK_TO_NPC, PS, [NpcId, TargetBMonGroupNo]) ->
    ?TRACE("PT_START_MF_BY_TALK_TO_NPC, NpcId: ~p, TargetBMonGroupNo: ~p~n", [NpcId, TargetBMonGroupNo]),
    case player:is_idle(PS) of
        false ->
            lib_send:send_prompt_msg(PS, ?PM_BUSY_NOW);
        true ->
            case check_start_mf_by_talk_to_npc(PS, NpcId, TargetBMonGroupNo) of
                ok ->
                    mod_battle:start_mf(PS, TargetBMonGroupNo, null);
                fail ->
                    ?WARNING_MSG("check_start_mf_by_talk_to_npc() failed!! PlayerId:~p, NpcId:~p, TargetBMonGroupNo:~p", [player:id(PS), NpcId, TargetBMonGroupNo]),
                    skip
            end
    end;

            




%% =============================== 明雷怪相关 =======================================

handle(?PT_TALK_TO_MON, PS, [MonId, Difficulty]) ->
    case check_start_mf_by_talk_to_mon(PS, MonId, Difficulty) of
        ok ->
            ?TRACE("PT_TALK_TO_MON, ok ...~n"),
            {ok, Bin} = pt_32:write(?PT_TALK_TO_MON, [?RES_OK, [], MonId, Difficulty]),
            lib_send:send_to_sock(PS, Bin);
        % {fail, ?PM_BT_MON_BATTLING} ->
        %     lib_send:send_prompt_msg(PS, ?PM_BT_MON_BATTLING);
        % {fail, ?PM_BT_MON_ALRDY_EXPIRED} ->
        %     lib_send:send_prompt_msg(PS, ?PM_BT_MON_ALRDY_EXPIRED);
        {fail, Reason} ->
            ?DEBUG_MSG("PT_TALK_TO_MON, fail for Reason:~p, PlayerId:~p", [Reason, player:id(PS)]),
            {ok, Bin} = pt_32:write(?PT_TALK_TO_MON, [Reason, [], MonId, Difficulty]),
            lib_send:send_to_sock(PS, Bin);

        {fail, Reason, ExtraInfoList} ->
            ?DEBUG_MSG("PT_TALK_TO_MON, fail for Reason:~p, ExtraInfoList:~p, PlayerId:~p", [Reason, ExtraInfoList, player:id(PS)]),
            {ok, Bin} = pt_32:write(?PT_TALK_TO_MON, [Reason, ExtraInfoList, MonId, Difficulty]),
            lib_send:send_to_sock(PS, Bin)
    end;


handle(_Cmd, _PS, _Data) ->
    ?ASSERT(false, _Cmd),
    {error, bad_request}.










%% --------- 私有函数 ----------


%% 构造npc的功能列表
%% @return: binary列表（一个功能对应一串binary）
build_npc_func_list(PS, Npc) ->
    FuncList = mod_npc:get_func_list(Npc),
    L = [build_npc_one_func(Npc, PS, X) || X <- FuncList],
    L2 = [X || X <- L, X /= null],
    ?TRACE("build_npc_func_list(), L2: ~p~n", [L2]),
    lists:flatten(L2).  % 可能有嵌套，故flatten


get_all_func_list() ->
    % 格式：{功能，功能代号}
    [{?NPCF_SELL_GOODS, ?NPCF_CODE_SELL_GOODS}              % 出售物品
    ,{?NPCF_TELEPORT, ?NPCF_CODE_TELEPORT}                  % 传送
    ,{?NPCF_STREN_EQUIP, ?NPCF_CODE_STREN_EQUIP}            % 强化装备
    ,{?NPCF_TEACH_SKILLS, ?NPCF_CODE_TEACH_SKILLS}          % 教授技能
    ,{?NPCF_DUNGEON, ?NPCF_CODE_DUNGEON}                    % 副本
    ,{?NPCF_TRIGGER_MF, ?NPCF_CODE_TRIGGER_MF}              % 触发打怪
    ,{?NPCF_EMPLOY_HIRER, ?NPCF_CODE_EMPLOY_HIRER}          % 雇佣天将
    ,{?NPCF_TOWER, ?NPCF_CODE_TOWER}                        % 进入爬塔
    ,{?NPCF_OFFLINE_ARENA, ?NPCF_CODE_OFFLINE_ARENA}        % 离线竞技场        
    ,{?NPCF_OA_FEAT_EXCHANGE, ?NPCF_CODE_OA_FEAT_EXCHANGE}  % 离线竞技场功勋兑换
    ,{?NPCF_REWARD_CDKEY, ?NPCF_CODE_REWARD_CDKEY}          % 礼包激活码输入界面入口
    ,{?NPCF_GUILD_DISHES, ?NPCF_CODE_GUILD_DISHES}          % 礼包激活码输入界面入口
    ,{?NPCF_GOODS_COMPOSE, ?NPCF_CODE_GOODS_COMPOSE}        % 物品合成入口
    ,{?NPCF_GUILD_DUNGEON, ?NPCF_CODE_GUILD_DUNGEON}        % 帮派副本入口   
    ,{?NPCF_LITERARY_EXCHANGE, ?NPCF_CODE_LITERARY_EXCHANGE}        % 学分兑换
    ,{?NPCF_GUILD_CULTIVATE, ?NPCF_CODE_GUILD_CULTIVATE}        % 帮派点修入口
    ,{?NPCF_GUILD_DONATE, ?NPCF_CODE_GUILD_DONATE}        % 帮派捐献入口
    ,{?NPCF_JOIN_CRUISE, ?NPCF_CODE_JOIN_CRUISE}          % 报名参加巡游活动 
    ,{?NPCF_ARENA_BIWU, ?NPCF_CODE_ARENA_BIWU}            % 比武大会入口
    ,{?NPCF_ARENA_BIWU_3V3, ?NPCF_CODE_ARENA_BIWU_3V3}    % 比武大会入口
    ,{?NPCF_ARENA_3V3_PVP, ?NPCF_CODE_ARENA_3V3_PVP}      % 跨服3v3
    ,{?NPCF_MONOPOLY, ?NPC_MONOPOL_ENTER}                 % 大富翁入口
	,{?NPCF_ENTER_EXCHANGE, ?NPC_ENTER_EXCHANGE}                 % 兑换商店
    ,{?NPCF_ENTER_MIJING, ?NPC_ENTER_MIJING}                 % 秘境入口
    ,{?NPCF_ENTER_HUANJING, ?NPC_ENTER_HUANJING}                 % 幻境入口
    ,{?NPCF_BOSS_ENTER_MOLONG, ?NPCF_CODE_BOSS_ENTER}            % 世界boss魔龙入口
    ,{?NPCF_BOSS_ENTER_YIJUN, ?NPCF_CODE_BOSS_ENTER2}            % 世界boss异军入口
    ,{?NPCF_BOSS_RANK, ?NPCF_CODE_BOSS_RANK}              % 世界boss排名入口
    ,{?NPCF_DISCARD_ROLE, ?NPCF_CODE_DISCARD_ROLE}        % 删除角色
    ,{?NPCF_ENTER_SWORN, ?NPCF_CODE_ENTER_SWORN}          % 进入结拜
    ,{?NPCF_MODIFY_SWORN, ?NPCF_CODE_MODIFY_SWORN}        % 修改结拜
    ,{?NPCF_REMOVE_SWORN, ?NPCF_CODE_REMOVE_SWORN}        % 删除结拜
    ,{?NPCF_ENTER_SHOP, ?NPCF_CODE_ENTER_SHOP}            % 进入商城 
    ,{?NPCF_ENTER_TRANSPORT, ?NPCF_CODE_ENTER_TRANSPORT}  % 进入运镖
    ,{?NPCF_ENTER_STORAGE, ?NPCF_CODE_ENTER_STORAGE}      % 进入仓库
    ,{?NPCF_GOODS_EXCHANGE, ?NPCF_CODE_GOODS_EXCHANGE}    % npc物品兑换
    ,{?NPCF_MELEE_APPLY, ?NPCF_CODE_MELEE_APPLY}          % 女妖乱斗入口
    ,{?NPCF_MELEE_OUT, ?NPCF_CODE_MELEE_OUT}              % 女妖乱斗出口（上缴龙珠）
    ,{?NPCF_SHOW_MASSAGE, ?NPCF_CODE_SHOW_MASSAGE}        % 说明展示
    ,{?NPCF_TVE_ENTRY, ?NPCF_CODE_TVE_ENTRY}              % 兵临城下入口
    ,{?NPCF_COUPLE_ENTRY, ?NPCF_CODE_COUPLE_ENTRY}        % 结婚入口
    ,{?NPCF_JOIN_COUPLE_CRUISE, ?NPCF_CODE_JOIN_COUPLE_CRUISE}        % 加入结婚花车游入口
    ,{?NPCF_CLOSE_WIN, ?NPCF_CODE_CLOSE_WIN}              % 关闭npc选项窗口
    ,{?NPCF_YEAR_DISHES, ?NPCF_CODE_YEAR_DISHES}          
    ,{?NPCF_YEAR_ENTRY, ?NPCF_CODE_YEAR_ENTRY}
    ,{?NPCF_BLESS_ENTRY, ?NPCF_CODE_BLESS_ENTRY}
    ,{?NPCF_BLESS_GET, ?NPCF_CODE_BLESS_GET}
    ,{?NPCF_GET_GOODS, ?NPCF_CODE_GET_GOODS}
    ,{?NPCF_HARDTOWER, ?NPCF_CODE_HARDTOWER}

    ,{?NPCF_OPEN_SLOTMACHINE, ?NPCF_CODE_OPEN_SLOTMACHINE}
    ,{?NPCF_GO_BACK_FACTION, ?NPCF_CODE_GO_BACK_FACTION}

    ,{?NPCF_JOIN_GUILD_BATTLE, ?NPCF_CODE_JOIN_GUILD_BATTLE}
    ,{?NPCF_JOIN_GUILD_BATTLE1, ?NPCF_CODE_JOIN_GUILD_BATTLE1}
    ,{?NPCF_JOIN_GUILD_BATTLE2, ?NPCF_CODE_JOIN_GUILD_BATTLE2}
    ,{?NPCF_JOIN_GUILD_BATTLE3, ?NPCF_CODE_JOIN_GUILD_BATTLE3}

    ,{?NPCF_OPEN_CHANGE_FACTION, ?NPCF_CODE_OPEN_CHANGE_FACTION}

    ,{?NPCF_OPEN_BOX, ?NPCF_CODE_OPEN_BOX}

	,{?NPCF_CHANGE_PAODIAN_TYPE, ?NPCF_CODE_CHANGE_PAODIAN_TYPE}
	,{?NPCF_MELEE_HAND_IN_DRAGONBALL, ?NPCF_CODE_MELEE_HAND_IN_DRAGONBALL}
    ,{?NPCF_SINGLE_TVE, ?NPCF_CODE_SINGLE_TVE}
	,{?NPCF_ENTER_KUAFU, ?NPCF_CODE_ENTER_KUAFU}
	
	].

%% 功能转为对应的功能代号
to_func_code(Func)->
    L = get_all_func_list(),
    proplists:get_value(Func, L, 0).


-define(INVALID_FUNC_ARG, 0).  % 无意义的功能参数

build_npc_one_func(_Npc, _PS, {?NPCF_SELL_GOODS, NpcShopNo}) ->
    <<(to_func_code(?NPCF_SELL_GOODS)):8, NpcShopNo:32>>;


build_npc_one_func(_Npc, _PS, {?NPCF_OPEN_BOX, Type}) ->
    <<(to_func_code(?NPCF_OPEN_BOX)):8, Type:32>>;

build_npc_one_func(_Npc, _PS, {?NPCF_CHANGE_PAODIAN_TYPE, Type}) ->
    <<(to_func_code(?NPCF_CHANGE_PAODIAN_TYPE)):8, Type:32>>;



build_npc_one_func(_Npc, _PS, {?NPCF_TELEPORT, TeleportNoList}) ->
    ?ASSERT(util:is_integer_list(TeleportNoList), TeleportNoList),

    F = fun(TeleportNo) ->
            <<(to_func_code(?NPCF_TELEPORT)):8, TeleportNo:32>>
        end,
    [F(X) || X <- TeleportNoList];

build_npc_one_func(_Npc, _PS, ?NPCF_STREN_EQUIP) ->
    <<(to_func_code(?NPCF_STREN_EQUIP)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, {?NPCF_TEACH_SKILLS, _SkillIdList}) ->
    % ?ASSERT(util:is_integer_list(SkillIdList)),
    % Count = length(SkillNoList),
    % Bin = list_to_binary( [<<X:32>> || X <- SkillNoList] ),
    % <<(to_func_code(teach_skills)):8, Count:16, Bin/binary>>;
    <<(to_func_code(?NPCF_TEACH_SKILLS)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, {?NPCF_DUNGEON, _DungeonNoList,_Tag}) ->
    <<(to_func_code(?NPCF_DUNGEON)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, PS, {?NPCF_TRIGGER_MF, BMonGroupNo, ConditionList}) ->
    case ply_npc_interact:check_trigger_mf_conditions(PS, ConditionList) of
        ok ->
            <<(to_func_code(?NPCF_TRIGGER_MF)):8, BMonGroupNo:32>>;
        fail ->
            null
    end;

build_npc_one_func(_Npc, _PS, ?NPCF_EMPLOY_HIRER) ->
    <<(to_func_code(?NPCF_EMPLOY_HIRER)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_OPEN_SLOTMACHINE) ->
    <<(to_func_code(?NPCF_OPEN_SLOTMACHINE)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_GO_BACK_FACTION) ->
    <<(to_func_code(?NPCF_GO_BACK_FACTION)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_JOIN_GUILD_BATTLE) ->
    <<(to_func_code(?NPCF_JOIN_GUILD_BATTLE)):8, ?INVALID_FUNC_ARG:32>>;
build_npc_one_func(_Npc, _PS, ?NPCF_JOIN_GUILD_BATTLE1) ->
    <<(to_func_code(?NPCF_JOIN_GUILD_BATTLE1)):8, ?INVALID_FUNC_ARG:32>>;
build_npc_one_func(_Npc, _PS, ?NPCF_JOIN_GUILD_BATTLE2) ->
    <<(to_func_code(?NPCF_JOIN_GUILD_BATTLE2)):8, ?INVALID_FUNC_ARG:32>>;
build_npc_one_func(_Npc, _PS, ?NPCF_JOIN_GUILD_BATTLE3) ->
    <<(to_func_code(?NPCF_JOIN_GUILD_BATTLE3)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_OPEN_CHANGE_FACTION) ->
    <<(to_func_code(?NPCF_OPEN_CHANGE_FACTION)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_TOWER) ->
    <<(to_func_code(?NPCF_TOWER)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_OFFLINE_ARENA) ->
    <<(to_func_code(?NPCF_OFFLINE_ARENA)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, {?NPCF_OA_FEAT_EXCHANGE, ShopNo}) ->
    <<(to_func_code(?NPCF_OA_FEAT_EXCHANGE)):8, ShopNo:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_REWARD_CDKEY) ->
    <<(to_func_code(?NPCF_REWARD_CDKEY)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_GUILD_DISHES) ->
    <<(to_func_code(?NPCF_GUILD_DISHES)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_GOODS_COMPOSE) ->
    <<(to_func_code(?NPCF_GOODS_COMPOSE)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_GUILD_DUNGEON) ->
    <<(to_func_code(?NPCF_GUILD_DUNGEON)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, {?NPCF_LITERARY_EXCHANGE, ShopNo}) ->
    <<(to_func_code(?NPCF_LITERARY_EXCHANGE)):8, ShopNo:32>>;
    
build_npc_one_func(_Npc, _PS, ?NPCF_GUILD_CULTIVATE) ->
    <<(to_func_code(?NPCF_GUILD_CULTIVATE)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_GUILD_DONATE) ->
    <<(to_func_code(?NPCF_GUILD_DONATE)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(Npc, _PS, ?NPCF_JOIN_CRUISE) ->
    % ?DEBUG_MSG("build_npc_one_func(), NPCF_JOIN_CRUISE", []),
    case mod_npc:is_waiting_player_to_join_cruise(Npc) of
        true ->
            <<(to_func_code(?NPCF_JOIN_CRUISE)):8, ?INVALID_FUNC_ARG:32>>;
        false ->
            ?TRACE("npc NOT waiting_player_to_join_cruise!!!~n"),
            null
    end;    

build_npc_one_func(_Npc, _PS, ?NPCF_ARENA_BIWU) ->
    <<(to_func_code(?NPCF_ARENA_BIWU)):8, ?INVALID_FUNC_ARG:32>>;


build_npc_one_func(_Npc, _PS, ?NPCF_ARENA_BIWU_3V3) ->
    <<(to_func_code(?NPCF_ARENA_BIWU_3V3)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_BOSS_ENTER_MOLONG) ->
    <<(to_func_code(?NPCF_BOSS_ENTER_MOLONG)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_BOSS_ENTER_YIJUN) ->
    <<(to_func_code(?NPCF_BOSS_ENTER_YIJUN)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_BOSS_RANK) ->
    <<(to_func_code(?NPCF_BOSS_RANK)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_DISCARD_ROLE) ->
    <<(to_func_code(?NPCF_DISCARD_ROLE)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_ENTER_SWORN) ->
    <<(to_func_code(?NPCF_ENTER_SWORN)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_MODIFY_SWORN) ->
    <<(to_func_code(?NPCF_MODIFY_SWORN)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_REMOVE_SWORN) ->
    <<(to_func_code(?NPCF_REMOVE_SWORN)):8, ?INVALID_FUNC_ARG:32>>;
    
build_npc_one_func(_Npc, _PS, ?NPCF_ENTER_SHOP) ->
    <<(to_func_code(?NPCF_ENTER_SHOP)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_ENTER_TRANSPORT) ->
    <<(to_func_code(?NPCF_ENTER_TRANSPORT)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_ENTER_STORAGE) ->
    <<(to_func_code(?NPCF_ENTER_STORAGE)):8, ?INVALID_FUNC_ARG:32>>;
    
build_npc_one_func(_Npc, _PS, {?NPCF_GOODS_EXCHANGE, No}) ->
    <<(to_func_code(?NPCF_GOODS_EXCHANGE)):8, No:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_MELEE_APPLY) ->
    <<(to_func_code(?NPCF_MELEE_APPLY)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_MELEE_OUT) ->
    <<(to_func_code(?NPCF_MELEE_OUT)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, {?NPCF_SHOW_MASSAGE, No}) ->
    <<(to_func_code(?NPCF_SHOW_MASSAGE)):8, No:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_TVE_ENTRY) ->
    <<(to_func_code(?NPCF_TVE_ENTRY)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_COUPLE_ENTRY) ->
    <<(to_func_code(?NPCF_COUPLE_ENTRY)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_JOIN_COUPLE_CRUISE) ->
    <<(to_func_code(?NPCF_JOIN_COUPLE_CRUISE)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_CLOSE_WIN) ->
    <<(to_func_code(?NPCF_CLOSE_WIN)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_YEAR_DISHES) ->
    <<(to_func_code(?NPCF_YEAR_DISHES)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_YEAR_ENTRY) ->
    <<(to_func_code(?NPCF_YEAR_ENTRY)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_BLESS_ENTRY) ->
    <<(to_func_code(?NPCF_BLESS_ENTRY)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_BLESS_GET) ->
    <<(to_func_code(?NPCF_BLESS_GET)):8, ?INVALID_FUNC_ARG:32>>;


build_npc_one_func(_Npc, _PS, ?NPCF_GET_GOODS) ->
    <<(to_func_code(?NPCF_GET_GOODS)):8, ?INVALID_FUNC_ARG:32>>;
    

build_npc_one_func(_Npc, _PS, {?NPCF_HARDTOWER, No}) ->
    <<(to_func_code(?NPCF_HARDTOWER)):8, No:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_MELEE_HAND_IN_DRAGONBALL) ->
    <<(to_func_code(?NPCF_MELEE_HAND_IN_DRAGONBALL)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_SINGLE_TVE) ->
    <<(to_func_code(?NPCF_SINGLE_TVE)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_ENTER_KUAFU) ->
    <<(to_func_code(?NPCF_ENTER_KUAFU)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_ARENA_3V3_PVP) ->
    <<(to_func_code(?NPCF_ARENA_3V3_PVP)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_MONOPOLY) ->
    <<(to_func_code(?NPCF_MONOPOLY)):8, ?INVALID_FUNC_ARG:32>>;
	
build_npc_one_func(_Npc, _PS, ?NPCF_ENTER_EXCHANGE) ->
    <<(to_func_code(?NPCF_ENTER_EXCHANGE)):8, ?INVALID_FUNC_ARG:32>>;

	
build_npc_one_func(_Npc, _PS, ?NPCF_ENTER_MIJING) ->
    <<(to_func_code(?NPCF_ENTER_MIJING)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, ?NPCF_ENTER_HUANJING) ->
    <<(to_func_code(?NPCF_ENTER_HUANJING)):8, ?INVALID_FUNC_ARG:32>>;

build_npc_one_func(_Npc, _PS, _Func) ->
    ?ASSERT(false, _Func),
    null.






%% @return: ok | fail
check_start_mf_by_talk_to_npc(PS, NpcId, TargetBMonGroupNo) ->
    case mod_npc:get_obj(NpcId) of
        null ->
            ?ASSERT(false, NpcId),
            fail;
        NpcObj ->
            case lib_bmon_group:is_valid(TargetBMonGroupNo) of
                false ->
                    ?ASSERT(false, TargetBMonGroupNo),
                    fail;
                true ->
                    % case player:get_scene_id(PS) /= mod_npc:get_scene_id(NpcObj) of
                    %     true ->
                    %         % ?ASSERT(false, NpcId),
                    %         % fail;

                    %         ?WARNING_MSG("check_start_mf_by_talk_to_npc failed, PlayerSceneId:~p, NpcSceneId:~p, PlayerPos:~p, NpcObj:~w", 
                    %                     [player:get_scene_id(PS), mod_npc:get_scene_id(NpcObj), player:get_position(PS), NpcObj]),
                    %         ok;
                    %     false ->
                            case player:is_in_team_but_not_leader(PS) andalso (not player:is_tmp_leave_team(PS)) of
                                true -> % 组队状态下（未暂离）只有队长的操作才有效
                                    ?TRACE("check_start_mf_by_talk_to_npc(), is_in_team_but_not_leader, andalso not tmp leave team...~n"),
                                    fail;
                                false ->
                                    case mod_npc:get_trigger_mf_func_list(NpcObj) of
                                        [] ->
                                            ?ASSERT(false, {NpcId, TargetBMonGroupNo}),
                                            fail;
                                        FuncList ->
                                            check_start_mf_by_talk_to_npc_2(FuncList, PS, NpcId, TargetBMonGroupNo)
                                    end
                            end
                    % end
            end         
    end.

            



check_start_mf_by_talk_to_npc_2([TriggerMfFunc | T], PS, NpcId, TargetBMonGroupNo) ->
    {_FuncName, BMonGroupNo_Cfg, ConditionList} = TriggerMfFunc,
    case BMonGroupNo_Cfg /= TargetBMonGroupNo of
        true ->
            check_start_mf_by_talk_to_npc_2(T, PS, NpcId, TargetBMonGroupNo);
        false ->
            case ply_npc_interact:check_trigger_mf_conditions(PS, ConditionList) of
                fail ->
                    ?DEBUG_MSG("[pp_npc] check_start_mf_by_talk_to_npc_2(), check_trigger_mf_conditions failed!!! PlayerId:~p, ConditionList:~w", [player:id(PS), ConditionList]),
                    fail;
                ok ->
                    ok
            end
    end;

check_start_mf_by_talk_to_npc_2([], _PS, _NpcId, _TargetBMonGroupNo) ->
    fail.




%% @return: ok | {fail, Reason}
check_start_mf_by_talk_to_mon(PS, MonId, Difficulty) ->
    case mod_mon:get_obj(MonId) of
        null ->
            ?ASSERT(false, MonId),
            {fail, ?TTM_FAIL_UNKNOWN};
        MonObj ->
            case player:is_in_team_but_not_leader(PS) andalso (not player:is_tmp_leave_team(PS)) of
                true -> % 组队状态下（未暂离）只有队长的操作才有效
                    ?TRACE("check_start_mf_by_talk_to_mon(), is_in_team_but_not_leader, andalso not tmp leave team, PlayerId=~p...~n", [player:id(PS)]),
                    {fail, ?TTM_FAIL_IN_TEAM_BUT_NOT_LEADER};
                false ->
                    % 检测明雷怪的归属
                    case ( mod_mon:has_owner(MonObj) andalso mod_mon:get_owner_id(MonObj) /= player:id(PS) ) 
                    andalso ( mod_mon:has_team(MonObj) andalso mod_mon:get_team_id(MonObj) /= player:get_team_id(PS) ) of
                        true ->
                            ?TRACE("check_start_mf_by_talk_to_mon(), NOT your mon, Playerid=~p...~n", [player:id(PS)]),
                            {fail, ?TTM_FAIL_NOT_YOUR_MON};
                        false ->
                            case mod_mon:is_battling(MonObj) andalso (not mod_mon:can_concurrent_battle(MonObj)) of
                                true ->
                                    {fail, ?TTM_FAIL_MON_BATTLING};
                                false ->
                                    case mod_mon:is_expired(MonObj) of
                                        true ->
                                            {fail, ?TTM_FAIL_MON_ALRDY_EXPIRED};
                                        false ->
                                            case ply_mon_interact:check_trigger_mf_conditions(PS, MonObj, Difficulty) of
                                                ok ->
                                                    ok;
                                                {fail, Reason} ->
                                                    {fail, Reason};
                                                {fail, Reason, ExtraInfoList} ->
                                                    {fail, Reason, ExtraInfoList}
                                            end 
                                    end
                            end
                    end
            end                            
    end.
    
