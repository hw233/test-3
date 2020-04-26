%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.11.5
%%% @doc 女妖乱斗.
%%% @end
%%%------------------------------------

-module(pp_melee).
-export([handle/3]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("melee.hrl").
-include("pt_28.hrl").
-include("inventory.hrl").

%% 乱斗活动报名
handle(?PT_MELEE_APPLY, PS, []) ->
%% handle(?PT_MELEE_APPLY, PS, {?CROSS_FLAG, []}) ->
	case lib_melee:check_join_melee(PS) of
		{false, Errcode} -> lib_send:send_prompt_msg(PS, Errcode);
		{true, IdList} ->
%% 			sm_cross_server:rpc_cast(lib_melee, melee_apply, [Id])
			[sm_cross_server:rpc_cast(lib_melee, melee_apply, [Id]) || Id <- IdList],
%% 			[lib_melee:melee_apply(Id) || Id <- IdList],
			{ok, BinData} = pt_28:write(?PT_MELEE_APPLY, [0]),
			lib_send:send_to_sid(PS, BinData),
			ok
	end;

%% handle(?PT_MELEE_APPLY, PS, []) ->
%% 	%% 取消报名了，所以这个可以不理会？
%%     ?ylh_Debug("melee_apply ~p~n", [player:id(PS)]),
%%     case player:is_idle(PS) of
%%         false -> lib_send:send_prompt_msg(PS, ?PM_BUSY_NOW);
%%         true ->
%% 			
%% 			case lib_melee:check_join_melee(PS) of
%% 				{false, ErrCode} -> lib_send:send_prompt_msg(PS, ErrCode);
%% 				{true, IdList} ->
%% 					case lib_melee:check_melee_info_status_no_apply(IdList) of
%% 						{false, ErrCode} -> lib_send:send_prompt_msg(PS, ErrCode);
%% 						true ->
%% 							PlayerId = player:get_id(PS),
%% 							Inv = mod_inv:get_inventory(PlayerId),
%% 							GoodsList = lists:foldl(fun(GoodsId, Acc) ->
%% 															case mod_inv:get_goods_from_ets(GoodsId) of
%% 																null -> Acc;
%% 																Goods ->
%% 																	[Goods|Acc]
%% 															end
%% 													end, [], Inv#inv.player_eq_goods ++ Inv#inv.partner_eq_goods),
%% 							sm_cross_server:rpc_cast(mod_login, enter_game_cross, [PS, ply_title:get_titles(PlayerId), ply_sys_open:get_opened_sys_list(PlayerId), Inv, GoodsList]),
%% 							sm_cross_server:rpc_proto_data_cast(PlayerId, ?PT_MELEE_APPLY, {?CROSS_FLAG, []})
%% %% 							lib_melee:enter_melee_scene(PS) 
%% 					end
%% 			end
%%     end;

%% 进入乱斗场景
handle(?PT_MELEE_ENTER_SCENE, PS, {?CROSS_FLAG, []}) ->
	?ylh_Debug("melee_enter_scene ~p~n", [player:id(PS)]),
	case player:is_idle(PS) of
		false -> lib_send:send_prompt_msg(PS, ?PM_BUSY_NOW);
		true ->
			lib_melee:enter_melee_scene(PS) 
%% 			case lib_melee:check_join_melee(PS) of
%% 				{false, ErrCode} -> lib_send:send_prompt_msg(PS, ErrCode);
%% 				{true, IdList} ->
%% 					case lib_melee:check_melee_info_status_no_apply(IdList) of
%% 						{false, ErrCode} -> lib_send:send_prompt_msg(PS, ErrCode);
%% 						true ->
%% 							lib_melee:enter_melee_scene(PS) 
%% 					end
%% 			end
	end;

handle(?PT_MELEE_ENTER_SCENE, PS, []) ->
	PlayerId = player:get_id(PS),
	%% 初始化跨服节点镜像数据及进程
	lib_cross:init_cross(PlayerId),
	sm_cross_server:rpc_proto_data_cast(PlayerId, ?PT_MELEE_ENTER_SCENE, {?CROSS_FLAG, []});
	


%% 退出乱斗场景 （上缴龙珠也发这条）
handle(?PT_MELEE_LEAVE_SCENE, PS, [Type]) ->
    lib_melee:melee_leave_scene(PS, Type);


%% 获取玩家龙珠数量
handle(?PT_MELEE_GET_BALL_NUM, PS, [Id]) ->
    case lib_melee:get_melee_ply_info(Id) of
        null -> skip;
        Info ->
            {ok, BinData} = pt_28:write(?PT_MELEE_GET_BALL_NUM, [Id, Info#ets_melee_ply_info.ball_num]),
            lib_send:send_to_sid(PS, BinData)
    end;

%% 决斗前获取对方队伍信息（龙珠数量）
handle(?PT_MELEE_GET_PK_FORCE_PRE_INFO, PS, [TargetId]) ->
    lib_melee:get_pk_force_pre_info(PS, TargetId);

handle(_Msg, _PS, _) ->
    ?WARNING_MSG("unknown handle ~p", [_Msg]),
    error.



