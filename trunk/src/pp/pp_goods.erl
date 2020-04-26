%%%--------------------------------------
%%% @Module  : pp_goods
%%% @Author  : huangjf,
%%% @Email   : 
%%% @Created : 2013.5.15
%%% @Description:  物品系统
%%%--------------------------------------

-module(pp_goods).
-export([handle/3]).


-include("common.hrl").
-include("record.hrl").
-include("goods.hrl").
-include("protocol/pt_15.hrl").
-include("prompt_msg_code.hrl").
-include("record/goods_record.hrl").
-include("log.hrl").
-include("sys_code.hrl").
-include("obj_info_code.hrl").
-include("player.hrl").
-include("clifford.hrl").
-include("reward.hrl").

%% 获取背包仓库玩家装备区域的物品列表
handle(?PT_QRY_INVENTORY, PS, [PartnerId, Location]) ->
	GoodsList =
		case PartnerId =:= 0 of
			true -> mod_inv:get_goods_list(player:get_id(PS), Location);
			false -> mod_equip:get_partner_equip_list(player:id(PS), PartnerId)
		end,
	{ok, BinData} = pt_15:write(?PT_QRY_INVENTORY, [PartnerId, Location, player:get_id(PS), GoodsList]),
	lib_send:send_to_sock(PS, BinData);

%% 查看某物品的详细信息
handle(?PT_GET_GOODS_DETAIL, PS, [GoodsId]) ->
	lib_goods:get_goods_data(PS, GoodsId);

%% 扩充背包仓库容量
handle(?PT_EXTEND_CAPACITY, PS, [Location, SlotNum]) ->
	case mod_inv:extend_capacity(PS, Location, SlotNum) of
		{ok, NewSlotNum} ->
			{ok, BinData} = pt_15:write(?PT_EXTEND_CAPACITY, [?RES_OK, Location, SlotNum, NewSlotNum]),
			lib_send:send_to_sock(PS, BinData);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;

%% 玩家穿装备
handle(?PT_PUTON_EQUIP, PS, [PartnerId, GoodsId]) ->
	case check_msg(?PT_PUTON_EQUIP, [PartnerId, GoodsId]) of
		ok ->
			case PartnerId =:= 0 of
				true ->
					case mod_equip:puton_equip(for_player, PS, GoodsId) of
						{fail, Reason} ->
							lib_send:send_prompt_msg(PS, Reason);
						{ok, Goods, Change} ->
							{ok, BinData} = pt_15:write(?PT_PUTON_EQUIP, [?RES_OK, PartnerId, GoodsId, lib_goods:get_equip_pos(Goods)]),
							lib_send:send_to_sock(PS, BinData),
							case Change of
								false -> skip;
								true -> lib_inv:notify_cli_goods_info_change(player:id(PS), Goods)
							end
					end;
				false ->
					case mod_equip:puton_equip(for_partner, PS, PartnerId, GoodsId) of
						{fail, Reason} ->
							lib_send:send_prompt_msg(PS, Reason);
						{ok, Goods, Change} ->
							{ok, BinData} = pt_15:write(?PT_PUTON_EQUIP, [?RES_OK, PartnerId, GoodsId, lib_goods:get_equip_pos(Goods)]),
							lib_send:send_to_sock(PS, BinData),
							case Change of
								false -> skip;
								true -> lib_inv:notify_cli_goods_info_change(player:id(PS), Goods)
							end
					end
			end;
		fail ->
			?ASSERT(false, [PartnerId, GoodsId]),
			skip
	end;


% 玩家卸下装备
handle(?PT_TAKEOFF_EQUIP, PS, [PartnerId, EquipPos]) ->
	case PartnerId =:= 0 of
		true ->
			case mod_equip:takeoff_equip(for_player, PS, EquipPos) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				{ok, GoodsId, Slot} ->
					lib_inv:notify_cli_goods_destroyed(player:id(PS), GoodsId, ?LOC_PLAYER_EQP),
					{ok, BinData} = pt_15:write(?PT_TAKEOFF_EQUIP, [?RES_OK, PartnerId, GoodsId, Slot, EquipPos]),
					lib_send:send_to_sock(PS, BinData)
			end;
		false ->
			case mod_equip:takeoff_equip(for_partner, PS, PartnerId, EquipPos) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				{ok, GoodsId, Slot} ->
					lib_inv:notify_cli_goods_destroyed(player:id(PS), GoodsId, ?LOC_PARTNER_EQP),
					{ok, BinData} = pt_15:write(?PT_TAKEOFF_EQUIP, [?RES_OK, PartnerId, GoodsId, Slot, EquipPos]),
					lib_send:send_to_sock(PS, BinData)
			end
	end;


%% 使用物品（战斗外使用，并且是玩家为自己而使用）
handle(?PT_USE_GOODS, PS, [GoodsId]) ->
	case mod_inv:find_goods_by_id_from_bag(player:id(PS), GoodsId) of
		null -> lib_send:send_prompt_msg(PS, ?PM_GOODS_NOT_EXISTS);
		Goods ->
		    case player:is_battling(PS) of
		    	true ->
		    		% ?ASSERT(false, {GoodsId, Goods}),
		            skip;
		        false ->
					case mod_inv:use_goods(PS, Goods) of
		    			{ok, Goods1} ->
		    				% ply_tips:send_sys_tips(PS, {use_goods, [lib_goods:get_no(Goods1), lib_goods:get_quality(Goods1), 1]}),
		    				{ok, BinData} = pt_15:write(?PT_USE_GOODS, [?RES_OK, Goods1]),
		    		      	lib_send:send_to_sock(PS, BinData);
		    			{fail, Reason} ->
		    		      	% 发送失败提示信息
		    		      	case Reason =:= ?PM_CAN_USE_COUNT_IS_OVER of
		    		      		true -> skip;
		    		      		false -> lib_send:send_prompt_msg(PS, Reason)
		    		      	end,
		    				{ok, BinData} = pt_15:write(?PT_USE_GOODS, [?RES_FAIL, Goods]),
		    		      	lib_send:send_to_sock(PS, BinData)
		    		end
		    end
	end;


%% 批量使用物品：是使用可叠加 但只可使用一次的物品
handle(?PT_BATCH_USE_GOODS, PS, [GoodsId, Count]) ->
	case Count =< 0 of
		true -> lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
		false ->
			case player:is_battling(PS) of
		    	true ->
		    		?ASSERT(false),
		            skip;
		        false ->
					case mod_inv:find_goods_by_id_from_bag(player:get_id(PS), GoodsId) of
						null -> 
							?ASSERT(false),
							skip;
						Goods ->
							?ASSERT(lib_goods:is_can_stack(Goods) andalso lib_goods:get_usable_times(Goods) =:= 1, lib_goods:get_no(Goods)),
							case lib_goods:get_count(Goods) >= Count of
								false ->
									?ASSERT(false),
									skip;
								true ->
									case mod_inv:use_goods(PS, Goods, Count) of
										{fail, Reason} ->
											lib_send:send_prompt_msg(PS, Reason);
										{ok, _Goods} ->
											case Count > 1 of
												true ->
													ply_tips:send_sys_tips(PS, {use_goods, [lib_goods:get_no(Goods), lib_goods:get_quality(Goods), Count,lib_goods:get_id(Goods)]});
												false -> skip
											end,
											{ok, BinData} = pt_15:write(?PT_BATCH_USE_GOODS, [?RES_OK, GoodsId, Count]),
											lib_send:send_to_sock(PS, BinData)
									end
							end
					end
			end
	end;


%% 丢弃物品
handle(?PT_DISCARD_GOODS, PS, [Location, GoodsId]) ->
	case mod_inv:find_goods_by_id(PS, GoodsId, Location) of
		null ->
			?ASSERT(false, {Location, GoodsId}),
			skip;
		Goods ->
			case lib_goods:is_can_discard(Goods) of
				false ->
					% 只发提示消息
					lib_send:send_prompt_msg(PS, ?PM_GOODS_CANT_DISCARD);
				true ->
					case player:is_battling(PS) of
						true ->
							lib_send:send_prompt_msg(PS, ?PM_IS_IN_BATTLING);
						false ->
							mod_inv:destroy_goods_WNC(player:get_id(PS), Goods, lib_goods:get_count(Goods), [?LOG_GOODS, "discard"]),
							{ok, BinData} = pt_15:write(?PT_DISCARD_GOODS, [?RES_OK, Location, GoodsId]),
		          			lib_send:send_to_sock(PS, BinData)
		          	end
			end
					
	end;


%% 拖动物品（从一个格子到另一个格子，但同在背包或仓库内）
handle(?PT_DRAG_GOODS, PS, [Location, GoodsId, ToSlot]) ->
	case check_msg(?PT_DRAG_GOODS, [player:get_id(PS), Location, GoodsId, ToSlot]) of
		ok ->
			case mod_inv:drag_goods(player:get_id(PS), GoodsId, ToSlot, Location) of
				ok ->
					{ok, BinData} = pt_15:write(?PT_DRAG_GOODS, [?RES_OK, Location, GoodsId, ToSlot]),
					lib_send:send_to_sock(PS, BinData);
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason)
			end;
		fail ->
			?ASSERT(false, [Location, GoodsId, ToSlot]),
			skip
	end;


%% 搬移物品（从背包到仓库，或从仓库到背包）
handle(?PT_MOVE_GOODS, PS, MsgArg) ->
	case check_msg(?PT_MOVE_GOODS, MsgArg) of
		ok ->
			[GoodsId, Count, ToLoc] = MsgArg,
			case mod_inv:move_goods(player:get_id(PS), GoodsId, Count, ToLoc) of
				ok ->
					{ok, BinData} = pt_15:write(?PT_MOVE_GOODS, [?RES_OK, GoodsId, Count]),
					lib_send:send_to_sock(PS, BinData);
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason)
			end;
		fail ->
			?ASSERT(false, MsgArg),
			skip
	end;


%% 整理仓库
handle(?PT_ARRANGE_STORAGE, PS, _) ->
	mod_inv:arrange_storage(PS),
	{ok, BinData} = pt_15:write(?PT_ARRANGE_STORAGE, [?RES_OK]),
	lib_send:send_to_sock(PS, BinData);


%% 整理背包
handle(?PT_ARRANGE_BAG, PS, _) ->
	% 增加宝石返回操作
	case mod_inv:get_all_goods_from_temp_reset_bag(PS) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_15:write(?PT_GOODS_RESET_REWARD, [?RES_OK]),
			lib_send:send_to_sock(PS, BinData)
	end,

	mod_inv:arrange_bag(PS),
	{ok, BinData1} = pt_15:write(?PT_ARRANGE_BAG, [?RES_OK]),
	lib_send:send_to_sock(PS, BinData1);


handle(?PT_SELL_GOODS_FROM_BAG, PS, [GoodsId, SellCount]) ->
	case ply_trade:sell_goods_from_bag(PS, GoodsId, SellCount) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			skip
	end;


handle(?PT_SELL_ALL_GOODS_FROM_TEMP_BAG, PS, _) ->
	case ply_trade:sell_all_goods_from_temp_bag(PS) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_15:write(?PT_SELL_ALL_GOODS_FROM_TEMP_BAG, [?RES_OK]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle(?PT_GET_ALL_GOODS_FROM_TEMP_BAG, PS, _) ->
	case mod_inv:get_all_goods_from_temp_bag(PS) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_15:write(?PT_GET_ALL_GOODS_FROM_TEMP_BAG, [?RES_OK]),
			lib_send:send_to_sock(PS, BinData)
	end;


%%handle(?PT_STRENTHEN_EQUIP, PS, [GoodsId, Count, UseBindStone]) ->
%%	TimeNow = util:longunixtime(),
%%	case (TimeNow - get_last_stren_equip_time() > 10) of
%%		false ->
%%			skip;
%%		true ->
%%			case ply_sys_open:is_open(PS, ?SYS_STRENTHEN_EQUIP) of
%%				false -> skip;
%%				true ->
%%					GoodsOld = mod_inv:find_goods_by_id_from_whole_inv(player:get_id(PS), GoodsId),
%%					case GoodsOld =:= null of
%%						true -> skip;
%%						false ->
%%							{RetList, PS1} = mod_equip:strenthen_equip(PS, GoodsId, Count, UseBindStone),
%%							case mod_inv:find_goods_by_id_from_whole_inv(player:get_id(PS), GoodsId) of
%%								null ->
%%									?ASSERT(false),
%%									skip;
%%								Goods ->
%%									case lists:keyfind(0, 1, RetList) of
%%								        {0, _, _} ->
%%								        	after_stren(PS1, GoodsOld, Goods, UseBindStone);
%%								        false ->
%%								        	case lists:keyfind(?PM_STRENGTHEN_FAIL, 1, RetList) of
%%								        		{?PM_STRENGTHEN_FAIL, _, _} ->
%%								        			after_stren(PS1, GoodsOld, Goods, UseBindStone);
%%										        false -> skip
%%										    end
%%								    end,
%%
%%								    RetLen = length(RetList),
%%								    RetList1 =
%%								    	case RetLen > 10 of
%%								    		true -> lists:sublist(RetList, RetLen - 10, RetLen);
%%								    		false -> RetList
%%								    	end,
%%
%%									{ok, BinData} = pt_15:write(?PT_STRENTHEN_EQUIP, [GoodsId, Count, UseBindStone, RetList1]),
%%									lib_send:send_to_sock(PS1, BinData),
%%
%%									mod_achievement:notify_achi(stren_equip, [], PS),
%%									mod_equip:notify_achi(PS),
%%
%%									case Count =:= 0 of
%%										true ->
%%											set_last_stren_equip_time(TimeNow);
%%										false ->
%%											skip
%%									end,
%%									{ok, PS1}
%%							end
%%					end
%%			end
%%	end;


handle(?PT_COMPOSE_GOODS, PS, [GoodsNo, Count, UseBindGoods]) ->
	case ply_sys_open:is_open(PS, ?SYS_COMPOSE_GOODS) of
		false -> skip;
		true ->
			case mod_equip:compose_goods(PS, GoodsNo, Count, UseBindGoods) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				{ok, OpNo} ->
					{ok, BinData} = pt_15:write(?PT_COMPOSE_GOODS, [?RES_OK, GoodsNo, Count, OpNo, UseBindGoods]),
					lib_send:send_to_sock(PS, BinData)
			end
	end;

handle(?PT_CHANGE_GOODS, PS, [GoodsId, GoodsNo]) ->
case ply_sys_open:is_open(PS, ?PT_CHANGE_GOODS) of
	false -> skip;
	true ->
		case mod_equip:change_goods(PS, GoodsId, GoodsNo) of
			{fail, Reason} ->
				lib_send:send_prompt_msg(PS, Reason);
			ok ->
				lib_send:send_to_sock(PS, <<0:8>>)
		end
end;


% 装备打造协议
handle(?PT_EQUIP_BUILD, PS, [GoodsNo, Type]) ->
		case mod_equip:equip_build(PS, GoodsNo, Type) of
			{fail, Reason} ->
				lib_send:send_prompt_msg(PS, Reason);
			GoodsId ->
				Goods = lib_goods:get_goods_by_id(GoodsId),
				AddiEquipEffNo = lib_goods:get_equip_effect(Goods),
				mod_achievement:notify_achi(equip_build, [], PS),
				case AddiEquipEffNo of
					0 -> skip;
					_ ->
						EquipEff = data_equip_speci_effect:get(AddiEquipEffNo),
			            BroadcastNo = EquipEff#equip_speci_effect_tpl.need_broadcast,

			            case BroadcastNo of
			                0 -> skip;
			                _ -> mod_broadcast:send_sys_broadcast(BroadcastNo,
								[player:get_name(PS), player:id(PS), GoodsNo, lib_goods:get_quality(Goods), 1,lib_goods:get_id(Goods)])
			            end
		        end,


				{ok, BinData} = pt_15:write(?PT_EQUIP_BUILD, [GoodsId]),
				lib_send:send_to_sock(PS, BinData)
		end;

% 领取丢失的宝石
handle(?PT_GOODS_RESET_REWARD, PS, []) ->
		case mod_inv:get_all_goods_from_temp_reset_bag(PS) of
			{fail, Reason} ->
				lib_send:send_prompt_msg(PS, Reason);
			ok ->
				{ok, BinData} = pt_15:write(?PT_GOODS_RESET_REWARD, [0]),
				lib_send:send_to_sock(PS, BinData)
		end;

	
handle(?PT_EQUIP_DECOMPOSE, PS, [IdList]) ->
	% case ply_sys_open:is_open(PS, ?SYS_EQUIP_DECOMPOSE) of
	% 	false -> skip;
		% true ->
			case mod_equip:equip_decompose(PS, IdList) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				ok ->
					{ok, BinData} = pt_15:write(?PT_EQUIP_DECOMPOSE, [?RES_OK, IdList]),
					lib_send:send_to_sock(PS, BinData)
			end;
	% end;

handle(?PT_EQ_OPEN_GEMSTONE, PS, [GoodsId, HoleNo]) ->
	case mod_equip:open_gemstone_hole(PS, GoodsId, HoleNo) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_15:write(?PT_EQ_OPEN_GEMSTONE, [GoodsId, HoleNo]),
			lib_send:send_to_sock(PS, BinData)
	end;

handle(?PT_EQ_INLAY_GEMSTONE, PS, [EqGoodsId, GemGoodsId, HoleNo]) ->
	case ply_sys_open:is_open(PS, ?SYS_INLAY_GEMSTONE) of
		false -> skip;
		true ->
			case mod_equip:inlay_gemstone(PS, EqGoodsId, GemGoodsId, HoleNo) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				ok ->
					{ok, BinData} = pt_15:write(?PT_EQ_INLAY_GEMSTONE, [EqGoodsId, GemGoodsId, HoleNo]),
					lib_send:send_to_sock(PS, BinData)
			end
	end;


handle(?PT_EQ_UNLOAD_GEMSTONE, PS, [EqGoodsId, GemGoodsId, HoleNo]) ->
	case mod_equip:unload_gemstone(PS, EqGoodsId, GemGoodsId, HoleNo) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_15:write(?PT_EQ_UNLOAD_GEMSTONE, [EqGoodsId, GemGoodsId, HoleNo]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle(?PT_STREN_TRS, PS, [SrcEqId, ObjEqId]) ->
	case mod_equip:stren_trs(PS, SrcEqId, ObjEqId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, _NewObjEq} ->
			{ok, BinData} = pt_15:write(?PT_STREN_TRS, [?RES_OK, SrcEqId, ObjEqId]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle(?PT_EQ_UPGRADE_QUALITY, PS, [GoodsId]) ->
	case mod_equip:upgrade_quality(PS, GoodsId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, _NewObjEq} ->
            mod_achievement:notify_achi(equip_improve_qual, [], PS),
			{ok, BinData} = pt_15:write(?PT_EQ_UPGRADE_QUALITY, [?RES_OK, GoodsId]),
			lib_send:send_to_sock(PS, BinData)
	end;
		

handle(?PT_EQ_RECAST, PS, [GoodsId,Type]) ->
	case mod_equip:recast(PS, GoodsId,Type) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, _NewObjEq} ->
			{ok, BinData} = pt_15:write(?PT_EQ_RECAST, [?RES_OK, GoodsId]),
			lib_send:send_to_sock(PS, BinData)
	end;

handle(?PT_EQ_RECAST_NEW, PS, [GoodsId,Type]) ->
	case mod_equip:recast_new(PS, GoodsId,Type) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, Goods,Attrs} ->	
			mod_achievement:notify_achi(equip_attr_wash, [], PS),
			{ok, BinData} = pt_15:write(?PT_GET_GOODS_DETAIL, Goods),
			lib_send:send_to_sock(PS, BinData)

			% {ok, BinData1} = pt_15:write(?PT_EQ_RECAST_NEW, [Type, GoodsId,Attrs]),
			% lib_send:send_to_sock(PS, BinData1)
	end;

handle(?PT_EQ_RECAST_SAVE, PS, [GoodsId,Type,Action]) ->
	case mod_equip:recast_new1(PS, GoodsId,Type,Action) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, Goods} ->
			{ok, BinData} = pt_15:write(?PT_GET_GOODS_DETAIL, Goods),
			lib_send:send_to_sock(PS, BinData)

			% {ok, BinData} = pt_15:write(?PT_EQ_RECAST_SAVE, [?RES_OK, GoodsId,Action]),
			% lib_send:send_to_sock(PS, BinData)
	end;

handle(?PT_OPEN_BOX, PS, [Type,No,NpcId]) ->
	case lib_clifford:open_box(PS,Type,No,NpcId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok,RewardNo,RetGoods} ->
			{ok, BinData} = pt_15:write(?PT_OPEN_BOX, [?RES_OK,RewardNo]),
			lib_send:send_to_sock(PS, BinData),

		    F = fun({Id, GoodsNo, Cnt}) ->
		            case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
		                null -> skip;
		                Goods ->
		                    ply_tips:send_sys_tips(PS, {get_goods, [GoodsNo, lib_goods:get_quality(Goods), Cnt,Id]})
		            end
		    end,
		    [F(X) || X <- RetGoods],

		    case data_clifford_reward:get(RewardNo) of
		        null -> skip;
		        CliffordReward when is_record(CliffordReward,clifford_reward) ->
		            RewardId = CliffordReward#clifford_reward.reward,
		            RewardRd = lib_reward:calc_reward_to_player(player:id(PS), RewardId),

		            lib_mail:send_sys_mail(player:id(PS), <<"祈福奖励">>, 
		                        <<"您打开了箱子获得了以下奖励">>, 
		                        RewardRd#reward_dtl.calc_goods_list, [?LOG_GOODS, "open_box"])
		    end

	end;

handle(?PT_EQ_REFINE, PS, [GoodsId, Count, Index]) ->
	case lists:keyfind(Index, 1, lib_goods:get_addi_ep_add_kv(mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId))) of
		false ->
			skip;
		{_Index, AttrName, _AttrValue, OldRefineLv} ->
			case mod_equip:refine(PS, GoodsId, Count, Index) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				{fail, Goods, Reason} ->
					after_refine(PS, Goods, Index, AttrName, OldRefineLv),
					lib_send:send_prompt_msg(PS, Reason);
				{ok, Goods} ->
					after_refine(PS, Goods, Index, AttrName, OldRefineLv),
					{ok, BinData} = pt_15:write(?PT_EQ_REFINE, [?RES_OK, GoodsId, Count, Index]),
					lib_send:send_to_sock(PS, BinData)
			end
	end;


handle(?PT_EQ_UPGRADE_LV, PS, [GoodsId]) ->
	case mod_equip:upgrade_lv(PS, GoodsId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, _NewObjEq} ->
			{ok, BinData} = pt_15:write(?PT_EQ_UPGRADE_LV, [?RES_OK, GoodsId]),
			lib_send:send_to_sock(PS, BinData)
	end;

%% GoodsList -> [{GoodsNo, BindState}] Count 默认是1
handle(?PT_GOODS_SMELT, PS, [GoodsList]) ->
	case ply_sys_open:is_open(PS, ?SYS_COMPOSE_GOODS) of
		false -> skip;
		true ->
			case mod_equip:goods_smelt(PS, GoodsList) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				{ok, OpNo, GoodsId} ->
					{ok, BinData} = pt_15:write(?PT_GOODS_SMELT, [?RES_OK, OpNo, GoodsId]),
					lib_send:send_to_sock(PS, BinData)
			end
	end;


handle(?PT_MAGIC_KEY_SKILL_LV_UP, PS, [GoodsId, SkillId]) ->
	case lib_magic_key:upgrade_skill_lv(PS, GoodsId, SkillId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, SkillId1} ->
			{ok, BinData} = pt_15:write(?PT_MAGIC_KEY_SKILL_LV_UP, [GoodsId, SkillId1]),
			lib_send:send_to_sock(PS, BinData)
	end;	


handle(?PT_MAGIC_KEY_XILIAN, PS, [GoodsId, IdList]) ->
	case lib_magic_key:xilian(PS, GoodsId, IdList) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_15:write(?PT_MAGIC_KEY_XILIAN, [GoodsId]),
			lib_send:send_to_sock(PS, BinData)
	end;		


handle(?PT_MAGIC_KEY_QUALITY_UPGRADE, PS, [GoodsId, IdList]) ->
	case lib_magic_key:stren_magic_key(PS, GoodsId, IdList) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_15:write(?PT_MAGIC_KEY_QUALITY_UPGRADE, [GoodsId]),
			lib_send:send_to_sock(PS, BinData)
	end;			


handle(?PT_EQ_EFF_REFRESH, PS, [GoodsId, Type]) ->
	case mod_equip:eff_refresh(PS, GoodsId, Type) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, _Goods} ->
            mod_achievement:notify_achi(equip_texiao_wash, [], PS),
			{ok, BinData} = pt_15:write(?PT_EQ_EFF_REFRESH, [GoodsId, Type]),
			lib_send:send_to_sock(PS, BinData)
	end;

handle(?PT_EQ_TRANSMOGRIFY_NEW, PS, [TargetGoodsId, GoodsId, Type]) ->
    case mod_equip:equip_transmogrify(PS, TargetGoodsId, GoodsId, Type) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, EffNo, Attrs, Goods} ->
			case EffNo =:= 0 andalso Attrs =:= [] of
                true ->
                    {ok, BinData} = pt_15:write(?PT_EQ_TRANSMOGRIFY_NEW, [?RES_FAIL]),
                    lib_send:send_to_sock(PS, BinData),
                    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods);
                false ->
                    {ok, BinData} = pt_15:write(?PT_EQ_TRANSMOGRIFY_NEW, [?RES_OK]),
                    lib_send:send_to_sock(PS, BinData),
                    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods)
            end
%%        {ok, Goods, _Attrs} ->
%%            {ok, BinData} = pt_15:write(?PT_GET_GOODS_DETAIL, Goods),
%%            lib_send:send_to_sock(PS, BinData)
    end;

handle(?PT_EQ_TRANSMOGRIFY_GET, PS, [TargetGoodsId]) ->
    case mod_equip:equip_transmogrify_save(PS, TargetGoodsId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, Goods} ->
            {ok, BinData} = pt_15:write(?PT_GET_GOODS_DETAIL, Goods),
            lib_send:send_to_sock(PS, BinData)
    end;

%%发送玩家强化和宝石镶嵌的信息
handle(?PT_NEW_EQUIP_ARRAY, PS, []) ->
	mod_strengthen:send_player_info(player:get_id(PS));

handle(?PT_NEW_EQUIP_COMMON_STRENGTHEN, PS, [Location, IsAuto]) ->
	mod_strengthen:strengthen_level(player:get_id(PS),Location, IsAuto);

%%一键强化
handle(?PT_NEW_EQUIP_ONE_STRENGTHEN, PS, [ IsAuto]) ->
	mod_strengthen:onekey_strengthen(player:get_id(PS));

handle(?PT_BODY_INLAY_GEMSTONE, PS, [EqGoodsId, GemGoodsId, HoleNo]) ->
	case ply_sys_open:is_open(PS, ?SYS_INLAY_GEMSTONE) of
		false -> skip;
		true ->
			case mod_strengthen:inlay_gemstone(PS, EqGoodsId, GemGoodsId, HoleNo) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				ok ->
					GemGoodsNo = lib_goods:get_no_by_id(GemGoodsId),
					{ok, BinData} = pt_15:write(?PT_BODY_INLAY_GEMSTONE, [EqGoodsId, GemGoodsId, HoleNo, GemGoodsNo]),
					lib_send:send_to_sock(PS, BinData)
			end
	end;

handle(?PT_BODY_UNLOAD_GEMSTONE, PS, [EqGoodsId, GemGoodsId, HoleNo]) ->
	case mod_strengthen:unload_gemstone(PS, EqGoodsId, GemGoodsId, HoleNo) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_15:write(?PT_BODY_UNLOAD_GEMSTONE, [EqGoodsId, 0, HoleNo]),
			lib_send:send_to_sock(PS, BinData)
	end;

%% 新装备重铸
handle(?PT_EQ_NEW_RECAST, PS, [GoodsId, Type, Auto, AttrList]) ->
	case mod_strengthen:recast_new(PS, GoodsId, Type, AttrList) of
		{fail, Reason} ->
			case Auto =:= 2 of
				true ->
					case get(?PDKN_RECAST_TIMER) of
						undefined ->
							void;
						{_RecastArgs, TimerRef, _IsAttention} ->
							erlang:cancel_timer(TimerRef),
							erlang:erase(?PDKN_RECAST_TIMER)
					end;
				false ->
					void
			end,
			lib_send:send_prompt_msg(PS, Reason),
			{ok, BinData1} = pt_15:write(?PT_EQ_NEW_RECAST, [GoodsId, Type, 0, ?RES_FAIL, []]),
			lib_send:send_to_sock(PS, BinData1);
		{ok, Goods, Attrs, IsAttention} ->
			mod_achievement:notify_achi(equip_attr_wash, [], PS),
			{ok, BinData1} = pt_15:write(?PT_EQ_NEW_RECAST, [GoodsId, Type, IsAttention, ?RES_OK, Attrs]),
			lib_send:send_to_sock(PS, BinData1),
			%% 物品详细信息
			{ok, BinData} = pt_15:write(?PT_GET_GOODS_DETAIL, Goods),
			lib_send:send_to_sock(PS, BinData),

			%% 是否自动洗炼
			case Auto =:= 2 of
				true ->
					case IsAttention =:= 0 of
						true ->
							case get(?PDKN_RECAST_TIMER) of
								undefined ->
									RecastInfo = [GoodsId, Type, Auto, AttrList],
									mod_player:start_timer(RecastInfo, IsAttention);
								{_RecastArgs, _TimerRef, _IsAttention} ->
									void
							end;
						false ->
							case get(?PDKN_RECAST_TIMER) of
								undefined ->
									void;
								{_RecastArgs, TimerRef, _IsAttention} ->
									io:format(" PT_EQ_NEW_RECAST success===~p~n",[{TimerRef,IsAttention}]),
									erlang:cancel_timer(TimerRef),
									erlang:erase(?PDKN_RECAST_TIMER)
							end
					end;
				false ->
					void
			end
	end;

%% 替换装备重铸属性
handle(?PT_EQ_NEW_RECAST_SAVE, PS, [GoodsId, Type, Action]) ->
	case mod_strengthen:replace_new(PS, GoodsId, Type, Action) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, Goods} ->
			{ok, BinData} = pt_15:write(?PT_EQ_NEW_RECAST_SAVE, [?RES_OK, GoodsId,Action]),
			lib_send:send_to_sock(PS, BinData),
			%% 物品详细信息
			{ok, BinData1} = pt_15:write(?PT_GET_GOODS_DETAIL, Goods),
			lib_send:send_to_sock(PS, BinData1)
	end;

%% 停止自动洗练
handle(?PT_EQ_NEW_STOP_SUCCINCT_SAVE, PS, [GoodsId, Type]) ->
	case get(?PDKN_RECAST_TIMER) of
		undefined ->
			lib_send:send_prompt_msg(PS, ?PM_UNKNOWN_ERR);
		{RecastArgs, TimerRef, _IsAttention} ->
			[OldGoodsId, OldType, _Auto, _AttrList] = RecastArgs,
			case OldGoodsId =:= GoodsId andalso OldType =:= Type of
				true ->
					erlang:cancel_timer(TimerRef),
					erlang:erase(?PDKN_RECAST_TIMER);
				false ->
					lib_send:send_prompt_msg(PS, ?PM_UNKNOWN_ERR)
			end
	end;

%% 自选洗炼
handle(?PT_EQ_NEW_SPECIAL_SUCCINCT, PS, [GoodsId, AttrList]) ->
	case mod_strengthen:special_recast(PS, GoodsId, AttrList) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, Goods} ->
			%% 物品详细信息
			{ok, BinData} = pt_15:write(?PT_GET_GOODS_DETAIL, Goods),
			lib_send:send_to_sock(PS, BinData)
	end;

%% 特技洗炼
handle(?PT_EQ_STUNT_REFRESH, PS, [GoodsId, Type, Action]) ->
	case mod_strengthen:stunt_refresh(PS, GoodsId, Type, Action) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, SkillNo, SkillTempNo} ->
			{ok, BinData} = pt_15:write(?PT_EQ_STUNT_REFRESH, [GoodsId, Type, SkillNo, SkillTempNo, Action]),
			lib_send:send_to_sock(PS, BinData)
	end;

%% 新特效洗炼
handle(?PT_EQ_NEW_EFF_REFRESH, PS, [GoodsId, Auto, AttrLv, AttrNo, Action]) ->
	case mod_strengthen:eff_refresh(PS, GoodsId, AttrLv, AttrNo, Action) of
		{fail, Reason} ->
			Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
			EffNo = lib_goods:get_equip_effect(Goods),
			EffTempNo = lib_goods:get_equip_eff_temp_no(Goods),
			lib_send:send_prompt_msg(PS, Reason),

			{ok, BinData} = pt_15:write(?PT_EQ_NEW_EFF_REFRESH, [GoodsId, Auto, 0, ?RES_FAIL, EffNo, EffTempNo, Action]),
			lib_send:send_to_sock(PS, BinData);
		{ok, Attention, EffNo, EffTempNo} ->
			mod_achievement:notify_achi(equip_texiao_wash, [], PS),
			{ok, BinData} = pt_15:write(?PT_EQ_NEW_EFF_REFRESH, [GoodsId, Auto, Attention, ?RES_OK, EffNo, EffTempNo, Action]),
			lib_send:send_to_sock(PS, BinData)
	end;

handle(?PT_EQ_NEW_EFF_REFRESH_SAVE, PS, [GoodsId]) ->
	case mod_strengthen:eff_replace(PS, GoodsId) of
		{fail, Reason} ->
			Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
			EffNo = lib_goods:get_equip_effect(Goods),
			EffTempNo = lib_goods:get_equip_eff_temp_no(Goods),
			lib_send:send_prompt_msg(PS, Reason),

			{ok, BinData} = pt_15:write(?PT_EQ_NEW_EFF_REFRESH_SAVE, [?RES_FAIL, GoodsId, EffNo, EffTempNo]),
			lib_send:send_to_sock(PS, BinData);
		{ok, EffectNo, EffectTempNo} ->
			{ok, BinData} = pt_15:write(?PT_EQ_NEW_EFF_REFRESH_SAVE, [?RES_OK, GoodsId, EffectNo, EffectTempNo]),
			lib_send:send_to_sock(PS, BinData)
	end;

handle(?PT_GOODS_EFF_SELECT, PS, [GoodsId, EffNo]) ->
	ply_trade:goods_eff_select(PS, GoodsId, EffNo);

handle(?PT_GOODS_WASH_ATTR_TRANSFER, PS, [GoodsId, TargetId, Type]) ->
	case mod_strengthen:equip_transfer(PS, GoodsId, TargetId, Type) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_15:write(?PT_GOODS_WASH_ATTR_TRANSFER, [?RES_OK, GoodsId, TargetId, Type]),
			lib_send:send_to_sock(PS, BinData)
	end;

handle(?PT_ACTIVE_PERSON_FASHION, PS, [No, GoodsNo]) ->
	case mod_strengthen:player_add_equip_fashion(PS, No, GoodsNo) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_15:write(?PT_ACTIVE_PERSON_FASHION, [?RES_OK, No]),
			lib_send:send_to_sock(PS, BinData)
	end;

handle(?PT_CHANGE_PERSON_FASHION, PS, [No]) ->
	case mod_strengthen:player_change_fashion(PS, No) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_15:write(?PT_CHANGE_PERSON_FASHION, [?RES_OK, No]),
			lib_send:send_to_sock(PS, BinData)
	end;

handle(?PT_PERSON_FASHION_INFO, PS, []) ->
	List = mod_strengthen:get_fashion_remain_time(PS),
	{ok, BinData} = pt_15:write(?PT_PERSON_FASHION_INFO, [List]),
	lib_send:send_to_sock(PS, BinData);


%% 容错处理
handle(Cmd, _Status, Data) ->
    ?DEBUG_MSG("pp_goods no match : ~p~n", [{Cmd, Data}]),
    {error, "pp_goods no match"}.




%% ==================================== Local Functions =====================================


%% 检测客户端所发消息的合法性，下同
%% @return: ok（消息合法） | fail（消息不合法）， 下同
check_msg(?PT_DRAG_GOODS, [PlayerId, Location, GoodsId, ToSlot]) ->
	BagCapacity = mod_inv:get_bag_capacity(PlayerId, Location),
	StoCapacity = mod_inv:get_storage_capacity(PlayerId),
	if
		GoodsId == 0 ->
			fail;
		Location /= ?LOC_BAG_EQ andalso Location /= ?LOC_BAG_USABLE andalso Location /= ?LOC_BAG_UNUSABLE andalso Location /= ?LOC_STORAGE ->
			fail;
		ToSlot =< 0 ->
			fail;
		(Location =:= ?LOC_BAG_EQ orelse Location =:= ?LOC_BAG_USABLE andalso Location =:= ?LOC_BAG_UNUSABLE) andalso ToSlot > BagCapacity ->
			fail;
		Location =:= ?LOC_STORAGE andalso ToSlot > StoCapacity ->
			fail;
		true ->
			ok
	end;

check_msg(?PT_MOVE_GOODS, [GoodsId, Count, ToLoc]) ->
	if
		GoodsId =< 0 ->
			fail;
		ToLoc /= ?LOC_BAG_EQ andalso ToLoc /= ?LOC_STORAGE ->
			fail;
		Count =< 0 ->
			fail;
		true ->
			ok
	end;

check_msg(?PT_PUTON_EQUIP, [PartnerId, GoodsId]) ->
	if
		GoodsId =< 0 ->
			fail;
		PartnerId < 0 ->
			fail;
		true ->
			ok
	end;

check_msg(_Protocol, _MsgArg) ->
	?ASSERT(false, _Protocol),
	fail.


get_last_stren_equip_time() ->
    case erlang:get(?PDKN_LAST_STREN_EQUIP_TIME) of
        undefined ->
            0;
        Time ->
            Time
    end.

set_last_stren_equip_time(Time) ->
    erlang:put(?PDKN_LAST_STREN_EQUIP_TIME, Time).


after_stren(PS, GoodsOld, Goods, UseBindStone) ->
	Goods1 = 
	    case UseBindStone =:= 1 orelse UseBindStone =:= 2 of
	        true -> lib_goods:set_bind_state(Goods, ?BIND_ALREADY);
	        false -> Goods
	    end,

	lib_event:event(strenthen_equip, [], PS),
    BattlePower = lib_equip:recount_battle_power(Goods1),
    Goods2 = lib_goods:set_battle_power(Goods1, BattlePower),
    mod_inv:mark_dirty_flag(lib_goods:get_owner_id(Goods2), Goods2),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods2),

    case lib_goods:get_stren_lv(GoodsOld) =:= lib_goods:get_stren_lv(Goods2) of
    	true ->
    		ply_attr:recount_equip_add_and_total_attrs(PS);
    	false ->
		    case mod_equip:is_equip_put_on(player:get_id(PS), lib_goods:get_id(Goods2)) of
		    	true -> %% 改变相关属性
		    		SuitNo = mod_equip:decide_player_suit_no(player:get_id(PS)),
					player:set_suit_no(PS, SuitNo),
					case player:get_suit_no(PS) =:= SuitNo of
		                true -> skip;
		                false -> lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_STREN_LV, SuitNo}])
		            end,
		    		ply_attr:recount_equip_add_and_total_attrs(PS);
		    	false ->
		    		case mod_equip:is_equip_put_on_par(player:get_id(PS), lib_goods:get_id(Goods2)) of
		    			true ->
		    				PartnerId = lib_goods:get_partner_id(Goods2),
		    				Partner = lib_partner:recount_equip_add_and_total_attrs(player:get_id(PS), PartnerId),
		    				mod_partner:update_partner_to_ets(Partner),

						    case lib_partner:is_fighting(Partner) of
						        true -> ply_attr:recount_battle_power(PS);
						        false -> skip
						    end;
		    			false ->
		    				skip
		    		end
		    		
		    end
	end.


after_refine(PS, Goods, Index, AttrName, OldRefineLv) ->
	Goods1 = lib_goods:set_bind_state(Goods, ?BIND_ALREADY),
	Goods2 = lib_goods:set_battle_power(Goods1, lib_equip:recount_battle_power(Goods1)),
    mod_inv:mark_dirty_flag(player:id(PS), Goods2),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods2),

    case mod_equip:is_equip_put_on(player:get_id(PS), lib_goods:get_id(Goods2)) of
    	true -> %% 改变相关属性
    		ply_attr:recount_equip_add_and_total_attrs(PS);
    	false ->
    		skip
    end,

    {_Index, _AttrName, _AttrValue, CurRefineLv} = lists:keyfind(Index, 1, lib_goods:get_addi_ep_add_kv(Goods)),
    lib_log:statis_equip_refine(PS, lib_goods:get_id(Goods), AttrName, OldRefineLv, CurRefineLv).