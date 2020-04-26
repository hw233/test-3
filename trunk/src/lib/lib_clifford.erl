%%%-----------------------------------
%%% @Module  : lib_slotmachine
%%% @Author  : 段世和
%%% @Email   : 
%%% @Created : 2015.07.27
%%% @Description: 老虎机
%%%-----------------------------------

-module(lib_clifford).

% include
-include("common.hrl").
-include("clifford.hrl").

-include("log.hrl").
-include("debug.hrl").
-include("goods.hrl").
-include("abbreviate.hrl").
-include("reward.hrl").
-include("prompt_msg_code.hrl").


-compile(export_all).
% -export([]).

% 获取所有配置信息
get_reward_list_by_type(Type) ->
    List = data_clifford_reward:get_config_by_type(Type),

    F = fun(No, Acc) ->
        Cfg = data_clifford_reward:get(No),
        [Cfg | Acc]
    end,
    Ret = lists:foldl(F, [],List),
    Ret.

% 计算需要随机的范围
get_random_range(Type,No) ->
    List = get_reward_list_by_type(Type),

    F = fun(Config, Sum) ->
        Widget = case Config#clifford_reward.no of
            % 如果是祈福的则增加祈福的额外权重
            No -> Config#clifford_reward.widget + Config#clifford_reward.normal_widget;
            _ -> Config#clifford_reward.widget 
        end,
        Widget + Sum
    end,

    All = lists:foldl(F, 0, List),
    All.


% 获取随机特效信息
get_random_no( Type,RandNum,No) ->
    List = get_reward_list_by_type(Type),
    get_random_no(List, RandNum, 0,No).

get_random_no([H | T],  RandNum, SumToCompare,No) ->
    % No = H#clifford_reward.no,
    Widget = case H#clifford_reward.no of
        No -> H#clifford_reward.widget + H#clifford_reward.normal_widget;
        _ -> H#clifford_reward.widget
    end,

    SumToCompare_2 = Widget + SumToCompare,

    case RandNum =< SumToCompare_2 of
        true -> 
            H#clifford_reward.no;
        false ->
            get_random_no(T, RandNum, SumToCompare_2,No)
    end;

get_random_no([],  _RandNum, _SumToCompare,No) ->
    ?ASSERT(false, { _RandNum, _SumToCompare,No}),
    0.

% 获取开奖编号 类型 祈福编号
get_open_no(Type,No) ->
    Range = get_random_range(Type,No),
    RandNum = util:rand(1, Range),
    get_random_no(Type, RandNum,No).

% 打开箱子 类型 祈福编号
open_box(PS,Type,No,NpcId) ->
    case check_open_box(PS, Type,NpcId) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_open_box(PS,Type,No,NpcId) 
    end. 

do_open_box(PS,Type,No, NpcId) ->
    Config = data_clifford_config:get(Type),
    
    % 删除NPC
    mod_scene:clear_dynamic_npc_from_scene_WNC(NpcId),

    mod_inv:destroy_goods_WNC(PS, Config#clifford_config.consume, [?LOG_GOODS, "open_box"]),
    {ok,RetGoods} = mod_inv:batch_smart_add_new_goods(player:id(PS), Config#clifford_config.must_goods, [{bind_state, ?BIND_ALREADY}], [?LOG_GOODS, "open_box"]), 

    % 提示获得道具
    RewardNo = get_open_no(Type,No),
    {ok,RewardNo,RetGoods}.

% 检测
check_open_box(PS, Type,NpcId) ->
    try check_open_box__(PS,Type,NpcId) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_open_box__(PS,Type,NpcId) ->
    List = get_reward_list_by_type(Type),

    NpcDate = case mod_npc:get_obj(NpcId) of
        null -> null;
        Npc -> Npc
    end,

    ?Ifc (NpcDate == null)
        throw(?PM_NPC_NOT_EXISTS)
    ?End,


    ?Ifc (length(List) =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Config = data_clifford_config:get(Type),

    ?Ifc (Config =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    case mod_inv:check_batch_add_goods(player:id(PS), Config#clifford_config.must_goods) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            case mod_inv:check_batch_destroy_goods(PS,Config#clifford_config.consume) of
                {fail, Reason} ->
                    throw(Reason);
                ok ->
                    ok
            end
    end.