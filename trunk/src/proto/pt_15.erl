%%%-----------------------------------
%%% @Module  : pt_15
%%% @Author  :
%%% @Email   :
%%% @Created : 2013.06.13
%%% @Description: 物品系统协议
%%%-----------------------------------
-module(pt_15).

-include("common.hrl").
-include("pt_15.hrl").
-include("goods.hrl").
-include("record/goods_record.hrl").
-include("obj_info_code.hrl").
-include("equip.hrl").
-include("pt.hrl").

-export([read/2, write/2]).



%%
%%客户端 -> 服务端 ----------------------------
%%


%%查询物品栏信息（服务端会返回物品列表）
read(?PT_QRY_INVENTORY, <<PartnerId:64, Location:8>>) ->
    {ok, [PartnerId, Location]};

read(?PT_GET_GOODS_DETAIL, <<GoodsId:64>>) ->
    {ok, [GoodsId]};


read(?PT_SELL_ALL_GOODS_FROM_TEMP_BAG, _) ->
    {ok, []};

read(?PT_GET_ALL_GOODS_FROM_TEMP_BAG, _) ->
    {ok, []};

read(?PT_SELL_GOODS_FROM_BAG, <<GoodsId:64, SellCount:32>>) ->
    {ok, [GoodsId, SellCount]};

read(?PT_EXTEND_CAPACITY, <<Location:8, ExtendNum:16>>) ->
    {ok, [Location, ExtendNum]};

read(?PT_PUTON_EQUIP, <<PartnerId:64, GoodsId:64>>) ->
    {ok, [PartnerId, GoodsId]};

read(?PT_TAKEOFF_EQUIP, <<PartnerId:64, EquipPos:8>>) ->
    {ok, [PartnerId, EquipPos]};


%% 使用物品（战斗外使用）
read(?PT_BATCH_USE_GOODS, <<GoodsId:64, Count:32>>) ->
    {ok, [GoodsId, Count]};


%% 使用物品（战斗外使用）
read(?PT_USE_GOODS, <<GoodsId:64>>) ->
    {ok, [GoodsId]};


%% 丢弃物品
read(?PT_DISCARD_GOODS, <<Location:8, GoodsId:64>>) ->
    {ok, [Location, GoodsId]};

read(?PT_DRAG_GOODS, <<Location:8, GoodsId:64, ToSlot:8>>) ->
    {ok, [Location, GoodsId, ToSlot]};

read(?PT_MOVE_GOODS, <<GoodsId:64, Count:32, ToLocation:8>>) ->
    {ok, [GoodsId, Count, ToLocation]};

%% 整理背包
read(?PT_ARRANGE_BAG, _) ->
    {ok, dummy};

read(?PT_ARRANGE_STORAGE, _) ->
    {ok, dummy};

read(?PT_STRENTHEN_EQUIP, <<GoodsId:64, Count:8, UseBindStone:8>>) ->
    {ok, [GoodsId, Count, UseBindStone]};


read(?PT_COMPOSE_GOODS, <<GoodsNo:32, Count:32, UseBindGoods:8>>) ->
    {ok, [GoodsNo, Count, UseBindGoods]};

% duanshihe添加道具转换
read(?PT_CHANGE_GOODS, <<GoodsId:64, GoodsNo:32>>) ->
    {ok, [GoodsId, GoodsNo]};

read(?PT_EQUIP_BUILD, <<GoodsNo:32, Type:8>>) ->
    {ok, [GoodsNo, Type]};    

read(?PT_GOODS_RESET_REWARD, <<>>) ->
    {ok, []};    

read(?PT_EQUIP_DECOMPOSE, <<Bin/binary>>) ->
    {IdList, _} = pt:read_array(Bin, [u64]),
    {ok, [IdList]};

read(?PT_EQ_OPEN_GEMSTONE, <<GoodsId:64, HoleNo:8>>) ->
    {ok, [GoodsId, HoleNo]};

read(?PT_EQ_INLAY_GEMSTONE, <<EqGoodsId:64, GemGoodsId:64, HoleNo:8>>) ->
    {ok, [EqGoodsId, GemGoodsId, HoleNo]};

read(?PT_EQ_UNLOAD_GEMSTONE, <<EqGoodsId:64, GemGoodsId:64, HoleNo:8>>) ->
    {ok, [EqGoodsId, GemGoodsId, HoleNo]};

read(?PT_STREN_TRS, <<SrcEqId:64, ObjEqId:64>>) ->
    {ok, [SrcEqId, ObjEqId]};   

read(?PT_EQ_UPGRADE_QUALITY, <<GoodsId:64>>) ->
    {ok, [GoodsId]};

read(?PT_EQ_RECAST, <<GoodsId:64,Type:8>>) ->
    {ok, [GoodsId,Type]};    

read(?PT_EQ_RECAST_NEW, <<GoodsId:64,Type:8>>) ->
    {ok, [GoodsId,Type]};   

read(?PT_EQ_RECAST_SAVE, <<GoodsId:64,Type:8,Action:8>>) ->
    {ok, [GoodsId,Type,Action]};  

read(?PT_OPEN_BOX, <<Type:8,No:16,NpcId:32>>) ->
    {ok, [Type,No,NpcId]};  

read(?PT_EQ_REFINE, <<GoodsId:64, Count:8, Index:8>>) ->
    {ok, [GoodsId, Count, Index]};        

read(?PT_EQ_UPGRADE_LV, <<GoodsId:64>>) ->
    {ok, [GoodsId]};

read(?PT_GOODS_SMELT, Bin) ->
    {List, _} = pt:read_array(Bin, [u32, u8]),
    {ok, [List]};

read(?PT_MAGIC_KEY_QUALITY_UPGRADE, <<GoodsId:64, Bin/binary>>) ->
    {IdList, _} = pt:read_array(Bin, [u64]),
    {ok, [GoodsId, IdList]};

read(?PT_MAGIC_KEY_XILIAN, <<GoodsId:64, Bin/binary>>) ->
    {IdList, _} = pt:read_array(Bin, [u32]),
    {ok, [GoodsId, IdList]};

read(?PT_MAGIC_KEY_SKILL_LV_UP, <<GoodsId:64, SkillId:32>>) ->
    {ok, [GoodsId, SkillId]};         

read(?PT_EQ_EFF_REFRESH, <<GoodsId:64, Type:8>>) ->
    {ok, [GoodsId, Type]};

read(?PT_EQ_TRANSMOGRIFY_NEW, <<TargetGoodsId:64, GoodsId:64, Type:8>>) ->
    {ok, [TargetGoodsId, GoodsId, Type]};

read(?PT_EQ_TRANSMOGRIFY_GET, <<TargetGoodsId:64>>) ->
    {ok, [TargetGoodsId]};

read(?PT_NEW_EQUIP_ARRAY, _) ->
    {ok, []};

read(?PT_NEW_EQUIP_COMMON_STRENGTHEN, <<Location:8, IsAuto:8>>) ->
    {ok, [Location,IsAuto ]};

read(?PT_NEW_EQUIP_ONE_STRENGTHEN, << IsAuto:8>>) ->
    {ok, [IsAuto ]};

read(?PT_BODY_INLAY_GEMSTONE, <<BodyNo:8, GemGoodsId:64, HoleNo:8>>) ->
    {ok, [BodyNo, GemGoodsId, HoleNo]};

read(?PT_BODY_UNLOAD_GEMSTONE, <<BodyNo:8, GemGoodsId:64, HoleNo:8>>) ->
    {ok, [BodyNo, GemGoodsId, HoleNo]};

read(?PT_EQ_NEW_RECAST, <<GoodsId:64,Type:8, Auto:8, Bin/binary>>) ->
    {AttrList, _} = pt:read_array(Bin, [u32]),
    {ok, [GoodsId, Type, Auto, AttrList]};

read(?PT_EQ_NEW_RECAST_SAVE, <<GoodsId:64, Type:8, Action:8>>) ->
    {ok, [GoodsId, Type, Action]};

read(?PT_EQ_NEW_STOP_SUCCINCT_SAVE, <<GoodsId:64, Type:8>>) ->
    {ok, [GoodsId, Type]};

read(?PT_EQ_NEW_SPECIAL_SUCCINCT, <<GoodsId:64, Bin/binary>>) ->
    {AttrList, _} = pt:read_array(Bin, [u32]),
    {ok, [GoodsId, AttrList]};

read(?PT_EQ_STUNT_REFRESH, <<GoodsId:64, Type:8, Action:8>>) ->
    {ok, [GoodsId, Type, Action]};

read(?PT_EQ_NEW_EFF_REFRESH, <<GoodsId:64, Auto:8, AttrLv:8, AttrNo:32, Action:8>>) ->
    {ok, [GoodsId, Auto, AttrLv, AttrNo, Action]};

read(?PT_EQ_NEW_EFF_REFRESH_SAVE, <<GoodsId:64>>) ->
    {ok, [GoodsId]};

read(?PT_GOODS_EFF_SELECT, <<GoodsId:64, No:32>>) ->
    {ok, [GoodsId, No]};

read(?PT_GOODS_WASH_ATTR_TRANSFER, <<GoodsId:64, TargetId:64, Bin/binary>>) ->
    {Type, _} = pt:read_array(Bin, [u8]),
    {ok, [GoodsId, TargetId, Type]};

read(?PT_ACTIVE_PERSON_FASHION, <<No:16, GoodsNo:16>>) ->
    {ok, [No,GoodsNo]};

read(?PT_CHANGE_PERSON_FASHION, <<No:16>>) ->
    {ok, [No]};

read(?PT_PERSON_FASHION_INFO, _) ->
    {ok, []};


read(_Cmd, _R) ->
    {error, no_match}.







%%
%%服务端 -> 客户端 ------------------------------------
%%
                                                 % 4


% 代码已作废
% %% 查询其他玩家装备列表
% write(15002, [Res, GoodsList]) ->
%     ListNum = length(GoodsList),
%     F = fun(GoodsInfo) ->
%             GoodsId = GoodsInfo#goods.id,
%             TypeId = GoodsInfo#goods.goods_id,
%             Cell = GoodsInfo#goods.cell,
%             GoodsNum = GoodsInfo#goods.num,
%             Stren   = GoodsInfo#goods.stren,
%             <<GoodsId:32, TypeId:32, Cell:16, GoodsNum:16, Stren:16>>
%         end,
%     ListBin = list_to_binary(lists:map(F, GoodsList)),
%     {ok, pt:pack(15002, <<Res:16, ListNum:16, ListBin/binary>>)};


write(?PT_QRY_INVENTORY, [PartnerId, Location, PlayerId, GoodsList1]) ->

    F2 = fun(Goods) when is_record(Goods,goods) -> Goods#goods.id =/= 0 andalso PlayerId =:= Goods#goods.player_id end,
    GoodsList = lists:filter(F2, GoodsList1),

    F = fun(Goods) ->
            BattlePower = lib_goods:get_battle_power(Goods),
			MakerName = case lib_goods:get_maker_name(Goods) of 
							null -> <<"system">>;
							EquipMaker -> EquipMaker
						end,
                % case lib_goods:is_equip(Goods) of
                %     false -> 0;
                %     true -> lib_equip:calc_battle_power(Goods)
                % end,
            <<
                (Goods#goods.id) : 64,
                (Goods#goods.no) : 32,
                (Goods#goods.slot) : 16,
                (Goods#goods.count) : 32,
                (Goods#goods.bind_state) : 8,
                (Goods#goods.quality) : 8,
                (Goods#goods.usable_times) : 16,
                BattlePower : 32,
            	?P_BITSTR(MakerName),
                (Goods#goods.custom_type)
            >>
        end,
    Bin = list_to_binary(lists:map(F, GoodsList)),
    Length = length(GoodsList),

    F1 = fun(Goods) ->
            L = [{?OI_CODE_STREN_LV, lib_goods:get_stren_lv(Goods)}, {?OI_CODE_QUALITY_LV, lib_goods:get_quality_lv(Goods)}],
            F0 = fun({Key, Value}) ->
                <<Key:16, Value:32>>
            end,
            case lib_goods:is_equip(Goods) of
                true -> <<(length(L)):16, (list_to_binary([F0(X) || X <- L]))/binary>>;
                false -> <<0:16, <<>>/binary>>
            end
        end,


    {Capacity, Len2, Bin2} =
        case Location of
            ?LOC_STORAGE -> {mod_inv:get_storage_capacity(PlayerId), 0, <<>>};
            ?LOC_BAG_EQ -> {mod_inv:get_bag_capacity(PlayerId, Location), Length, list_to_binary(lists:map(F1, GoodsList))};
            ?LOC_BAG_USABLE -> {mod_inv:get_bag_capacity(PlayerId, Location), 0, <<>>};
            ?LOC_BAG_UNUSABLE -> {mod_inv:get_bag_capacity(PlayerId, Location), 0, <<>>};
            ?LOC_TEMP_BAG -> {mod_inv:get_bag_capacity(PlayerId, Location), Length, list_to_binary(lists:map(F1, GoodsList))};
            ?LOC_PLAYER_EQP -> {0, Length, list_to_binary(lists:map(F1, GoodsList))};
            ?LOC_PARTNER_EQP -> {0, Length, list_to_binary(lists:map(F1, GoodsList))};
            _Any -> {0, 0, <<>>} %% 如果是非背包且非仓库则统一发0
        end,

    {ok, pt:pack(?PT_QRY_INVENTORY, <<PartnerId:64, Location:8, Capacity:16, Length:16, Bin/binary, Len2:16, Bin2/binary>>)};

write(?PT_GET_GOODS_DETAIL, Goods) ->
    DetailInfo = build_goods_detail_info(Goods),
    {ok, pt:pack(?PT_GET_GOODS_DETAIL, <<DetailInfo/binary>>)};
write(?PT_GET_GOODS_DETAIL_ON_RANK, Goods) ->
    DetailInfo = build_goods_detail_info(Goods),
    {ok, pt:pack(?PT_GET_GOODS_DETAIL_ON_RANK, <<DetailInfo/binary>>)};

write(?PT_EXTEND_CAPACITY, [RetCode, Location, ExtendNum, NewCapacity]) ->
    {ok, pt:pack(?PT_EXTEND_CAPACITY, <<RetCode:8, Location:8, ExtendNum:8, NewCapacity:16>>)};

write(?PT_PUTON_EQUIP, [RetCode, PartnerId, GoodsId, ToSlot]) ->
    {ok, pt:pack(?PT_PUTON_EQUIP, <<RetCode:8, PartnerId:64, GoodsId:64, ToSlot:8>>)};

write(?PT_TAKEOFF_EQUIP, [RetCode, PartnerId, GoodsId, NewSlot, EquipPos]) ->
    {ok, pt:pack(?PT_TAKEOFF_EQUIP, <<RetCode:8, PartnerId:64, GoodsId:64, NewSlot:8, EquipPos:8>>)};

write(?PT_USE_GOODS, [RetCode, Goods]) ->
	{ok, pt:pack(?PT_USE_GOODS, <<RetCode:8, (lib_goods:get_id(Goods)):64, (lib_goods:get_no(Goods)):32>>)};


write(?PT_BATCH_USE_GOODS, [RetCode, GoodsId, Count]) ->
    BinData = <<RetCode:8, GoodsId:64, Count:16>>,
    {ok, pt:pack(?PT_BATCH_USE_GOODS, BinData)};


write(?PT_DISCARD_GOODS, [RetCode, Location, GoodsId]) ->
	{ok, pt:pack(?PT_USE_GOODS, <<RetCode:8, Location:8, GoodsId:64>>)};

write(?PT_DRAG_GOODS, [RetCode, Location, GoodsId, ToSlot]) ->
    {ok, pt:pack(?PT_DRAG_GOODS, <<RetCode:8, Location:8, GoodsId:64, ToSlot:8>>)};

write(?PT_MOVE_GOODS, [RetCode, GoodsId, Count]) ->
    {ok, pt:pack(?PT_MOVE_GOODS, <<RetCode:8, GoodsId:64, Count:32>>)};

write(?PT_ARRANGE_BAG, [RetCode]) ->
    {ok, pt:pack(?PT_ARRANGE_BAG, <<RetCode:8>>)};


write(?PT_ARRANGE_STORAGE, [RetCode]) ->
    {ok, pt:pack(?PT_ARRANGE_STORAGE, <<RetCode:8>>)};

write(?PT_EQUIP_BUILD, [GoodsId]) ->
    {ok, pt:pack(?PT_EQUIP_BUILD, <<GoodsId:64>>)};  

write(?PT_GOODS_RESET_REWARD, [RetCode]) ->
    {ok, pt:pack(?PT_GOODS_RESET_REWARD, <<RetCode:8>>)};

write(?PT_NOTIFY_INV_GOODS_ADDED, GoodsAdded) ->
    BattlePower = lib_goods:get_battle_power(GoodsAdded),
    
    L = [{?OI_CODE_STREN_LV, lib_goods:get_stren_lv(GoodsAdded)}, {?OI_CODE_QUALITY_LV, lib_goods:get_quality_lv(GoodsAdded)}],
    F0 = fun({Key, Value}) ->
        <<Key:16, Value:32>>
    end,

    Bin2 = <<(length(L)):16, (list_to_binary([F0(X) || X <- L]))/binary>>,

    Data = <<
                (GoodsAdded#goods.partner_id) : 64,
                (GoodsAdded#goods.location) : 8,
                (GoodsAdded#goods.id) : 64,
                (GoodsAdded#goods.no) : 32,
                (GoodsAdded#goods.slot) : 16,
                (GoodsAdded#goods.count) : 32,
                (GoodsAdded#goods.bind_state) : 8,
                (GoodsAdded#goods.quality) : 8,
                (GoodsAdded#goods.usable_times) : 16,
                BattlePower : 32,
                Bin2 / binary,
                (GoodsAdded#goods.custom_type) : 8
           >>,
    
    {ok, pt:pack(?PT_NOTIFY_INV_GOODS_ADDED, Data)};

write(?PT_NOTIFY_INV_GOODS_DESTROYED, [GoodsId, Location]) ->
    Data = <<Location:8, GoodsId:64>>,
    {ok, pt:pack(?PT_NOTIFY_INV_GOODS_DESTROYED, Data)};


write(?PT_STRENTHEN_EQUIP, [GoodsId, Count, UseBindStone, RetList]) ->
    Len = length(RetList),
    F = fun({RetCode, Lv, Exp}) ->
        <<RetCode:16, Lv:8, Exp:32>>
    end,
    Bin = list_to_binary([F(X) || X <- RetList]),
    BinData = <<GoodsId:64, Count:8, UseBindStone:8, Len:16, Bin/binary>>,
    {ok, pt:pack(?PT_STRENTHEN_EQUIP, BinData)};


write(?PT_COMPOSE_GOODS, [RetCode, GoodsNo, Count, OpNo, UseBindGoods]) ->
    {ok, pt:pack(?PT_COMPOSE_GOODS, <<RetCode:8, GoodsNo:32, Count:32, OpNo:8, UseBindGoods:8>>)};


write(?PT_EQUIP_DECOMPOSE, [RetCode, IdList]) ->
    Bin = list_to_binary([ <<GoodsId:64>> || GoodsId <- IdList]),
    Len = length(IdList),
    {ok, pt:pack(?PT_EQUIP_DECOMPOSE, <<RetCode:8, Len:16, Bin/binary>>)};

write(?PT_EQ_OPEN_GEMSTONE, [GoodsId, HoleNo]) ->
    {ok, pt:pack(?PT_EQ_OPEN_GEMSTONE, <<GoodsId:64, HoleNo:8>>)};

write(?PT_EQ_INLAY_GEMSTONE, [EqGoodsId, GemGoodsId, HoleNo]) ->
    {ok, pt:pack(?PT_EQ_INLAY_GEMSTONE, <<EqGoodsId:64, GemGoodsId:64, HoleNo:8>>)};

write(?PT_EQ_UNLOAD_GEMSTONE, [EqGoodsId, GemGoodsId, HoleNo]) ->
    {ok, pt:pack(?PT_EQ_UNLOAD_GEMSTONE, <<EqGoodsId:64, GemGoodsId:64, HoleNo:8>>)};

write(?PT_SELL_ALL_GOODS_FROM_TEMP_BAG, [RetCode]) ->
    {ok, pt:pack(?PT_SELL_ALL_GOODS_FROM_TEMP_BAG, <<RetCode:8>>)};

write(?PT_GET_ALL_GOODS_FROM_TEMP_BAG, [RetCode]) ->
    {ok, pt:pack(?PT_GET_ALL_GOODS_FROM_TEMP_BAG, <<RetCode:8>>)};

write(?PT_DIG_TREASURE_RESULT, [Event, GoodsList, SceneID, GoodsNo]) ->
    % Bin = << <<G:32, N:32 >> || {G, N, _, _, _} <- GoodsList >>,

    Bin = list_to_binary( lists:foldl(fun(Para,Acc) ->
        case Para of
            {G, N, _, _, _} ->
                [<<G:32, N:32 >> | Acc];
            {G, N, _, _} ->
                 [<<G:32, N:32 >> | Acc];
            _ -> Acc
        end
    end,[],GoodsList)),

    Len = length(GoodsList),
    {ok, pt:pack(?PT_DIG_TREASURE_RESULT, <<Event:8, Len:16, Bin/binary, SceneID:32, GoodsNo:32>>)};


write(?PT_STREN_TRS, [RetCode, SrcEqId, ObjEqId]) ->
    {ok, pt:pack(?PT_STREN_TRS, <<RetCode:8, SrcEqId:64, ObjEqId:64>>)};


write(?PT_EQ_UPGRADE_QUALITY, [RetCode, GoodsId]) ->
    {ok, pt:pack(?PT_EQ_UPGRADE_QUALITY, <<RetCode:8, GoodsId:64>>)};


write(?PT_EQ_RECAST, [RetCode, GoodsId]) ->
    {ok, pt:pack(?PT_EQ_RECAST, <<RetCode:8, GoodsId:64>>)};


write(?PT_EQ_RECAST_NEW, [Type, GoodsId, Attrs]) ->
    ?DEBUG_MSG("Attrs=~p",[Attrs]),
    Bin = list_to_binary( lists:foldl(fun(Para,Acc) ->
        {AttrName, Value} =
            case Para of
                {_, TAttrName, TValue, _Lv} -> {TAttrName, TValue};
                {TAttrName, TValue} -> {TAttrName, TValue}
            end,
        
        Key = lib_attribute:attr_name_to_obj_info_code(AttrName),
        [<<Key:32, Value:32 >> | Acc]
    end,[],Attrs)),

    Len = length(Attrs),
    {ok, pt:pack(?PT_EQ_RECAST_NEW, <<Type:8, GoodsId:64, Len:16, Bin/binary>>)};

write(?PT_EQ_RECAST_SAVE, [RetCode, GoodsId,Action]) ->
    {ok, pt:pack(?PT_EQ_RECAST_SAVE, <<RetCode:8, GoodsId:64,Action:8>>)};

write(?PT_OPEN_BOX, [RetCode,RewardNo]) ->
    {ok, pt:pack(?PT_OPEN_BOX, <<RetCode:8,RewardNo:16>>)};

write(?PT_EQ_REFINE, [RetCode, GoodsId, Count, Index]) ->
    {ok, pt:pack(?PT_EQ_REFINE, <<RetCode:8, GoodsId:64, Count:8, Index:8>>)};    


write(?PT_EQ_UPGRADE_LV, [RetCode, GoodsId]) ->
    {ok, pt:pack(?PT_EQ_UPGRADE_LV, <<RetCode:8, GoodsId:64>>)};

write(?PT_GOODS_SMELT, [RetCode, OpNo, GoodsId]) ->
    {ok, pt:pack(?PT_GOODS_SMELT, <<RetCode:8, OpNo:8, GoodsId:64>>)};    


write(?PT_MAGIC_KEY_QUALITY_UPGRADE, [GoodsId]) ->
    {ok, pt:pack(?PT_MAGIC_KEY_QUALITY_UPGRADE, <<GoodsId:64>>)};    
    
write(?PT_MAGIC_KEY_XILIAN, [GoodsId]) ->
    {ok, pt:pack(?PT_MAGIC_KEY_XILIAN, <<GoodsId:64>>)};    
    
write(?PT_MAGIC_KEY_SKILL_LV_UP, [GoodsId, SkillId]) ->
    {ok, pt:pack(?PT_MAGIC_KEY_SKILL_LV_UP, <<GoodsId:64, SkillId:32>>)};    

write(?PT_EQ_EFF_REFRESH, [GoodsId, Type]) ->
    {ok, pt:pack(?PT_EQ_EFF_REFRESH, <<GoodsId:64, Type:8>>)};    

%% 幻化15155废弃协议代码
%%write(?PT_EQ_TRANSMOGRIFY_NEW, [TargetGoodsId, GoodsId, EffNo, Attrs]) ->
%%    Bin = list_to_binary(lists:foldl(fun(Para, Acc) ->
%%        {AttrName, Value} =
%%            case Para of
%%                {_, TAttrName, TValue, _Lv} -> {TAttrName, TValue};
%%                {TAttrName, TValue} -> {TAttrName, TValue}
%%            end,
%%
%%        Key = lib_attribute:attr_name_to_obj_info_code(AttrName),
%%        [<<Key:32, Value:32>> | Acc]
%%    end,[],Attrs)),
%%    Len = length(Attrs),
%%    {ok, pt:pack(?PT_EQ_TRANSMOGRIFY_NEW, <<TargetGoodsId:64, GoodsId:64, EffNo:32, Len:16, Bin/binary>>)};

write(?PT_EQ_TRANSMOGRIFY_NEW, [ResCode]) ->
    {ok, pt:pack(?PT_EQ_TRANSMOGRIFY_NEW, <<ResCode:8>>)};

write(?PT_EQ_TRANSMOGRIFY_GET, [ResCode]) ->
    {ok, pt:pack(?PT_EQ_TRANSMOGRIFY_GET, <<ResCode:8>>)};

write(?PT_NEW_EQUIP_ARRAY, Info) ->
   % [{1, Level, [宝石Id1,宝石Id2,宝石Id3···]},···] [{部位NO,强化LV,宝石镶嵌}]
    Bin = list_to_binary( lists:foldl(fun(Para,Acc) ->
        {Index, Level, GemstoneInfo} =  Para,
        StoneBin = list_to_binary([ <<No:8, StoneX:64, StoneNo:32>> || {No, StoneX, StoneNo} <- GemstoneInfo]),
        StoneLen = length(GemstoneInfo),
        [<<Index:8, Level:8, StoneLen:16, StoneBin/binary>> | Acc]
                                      end,[],Info)),
    Len = length(Info),

    {ok, pt:pack(?PT_NEW_EQUIP_ARRAY, <<Len:16, Bin/binary>>)};

write(?PT_NEW_EQUIP_COMMON_STRENGTHEN, [Location, Level]) ->
    {ok, pt:pack(?PT_NEW_EQUIP_COMMON_STRENGTHEN, <<Location:8, Level:8 >>)};

write(?PT_NEW_EQUIP_ONE_STRENGTHEN, [StrengthenInfo]) ->
    Bin = list_to_binary([ <<Location:8, Lv:8>> || {Location,Lv,_} <- StrengthenInfo]),
    Len = length(StrengthenInfo),
    {ok, pt:pack(?PT_NEW_EQUIP_ONE_STRENGTHEN, <<Len:16, Bin/binary >>)};

write(?PT_BODY_INLAY_GEMSTONE, [BodyNo, GemGoodsId, HoleNo, GemGoodsNo]) ->
    {ok, pt:pack(?PT_BODY_INLAY_GEMSTONE, <<BodyNo:8, GemGoodsId:64, HoleNo:8, GemGoodsNo:32>>)};

write(?PT_BODY_UNLOAD_GEMSTONE, [BodyNo, GemGoodsId, HoleNo]) ->
    {ok, pt:pack(?PT_BODY_UNLOAD_GEMSTONE, <<BodyNo:8, GemGoodsId:64, HoleNo:8>>)};

write(?PT_EQ_NEW_RECAST, [GoodsId, Type, Attention, RetCode, Attrs]) ->
    ?DEBUG_MSG("Attrs=~p",[Attrs]),
    Bin = list_to_binary( lists:foldl(fun(Para,Acc) ->
        {AttrName, Value} =
            case Para of
                {_, TAttrName, TValue, _Lv} -> {TAttrName, TValue};
                {TAttrName, TValue} -> {TAttrName, TValue}
            end,

        Value2 = util:ceil(Value * 1000),
        Key = lib_attribute:attr_name_to_obj_info_code(AttrName),
        [<<Key:32, Value2:32 >> | Acc]
                                      end,[],Attrs)),

    Len = length(Attrs),
    {ok, pt:pack(?PT_EQ_NEW_RECAST, <<GoodsId:64, Type:8, Attention:8, RetCode:8, Len:16, Bin/binary>>)};

write(?PT_EQ_NEW_RECAST_SAVE, [RetCode, GoodsId,Action]) ->
    {ok, pt:pack(?PT_EQ_NEW_RECAST_SAVE, <<RetCode:8, GoodsId:64,Action:8>>)};

write(?PT_EQ_STUNT_REFRESH, [GoodsId, Type, SkillNo, SkillTempNo, Action]) ->
    {ok, pt:pack(?PT_EQ_STUNT_REFRESH, <<GoodsId:64, Type:8, SkillNo:32, SkillTempNo:32, Action:8>>)};

write(?PT_EQ_NEW_EFF_REFRESH, [GoodsId, Auto, Attention, RetCode, EquipEffNo, EquipEffTempNo, Action]) ->
    {ok, pt:pack(?PT_EQ_NEW_EFF_REFRESH, <<GoodsId:64, Auto:8, Attention:8, RetCode:8, EquipEffNo:32, EquipEffTempNo:32, Action:8>>)};

write(?PT_EQ_NEW_EFF_REFRESH_SAVE, [RetCode, GoodsId, EquipEffNo, EquipEffTempNo]) ->
    {ok, pt:pack(?PT_EQ_NEW_EFF_REFRESH_SAVE, <<RetCode:8, GoodsId:64, EquipEffNo:32, EquipEffTempNo:32>>)};

write(?PT_GOODS_EFF_SELECT, [RetCode, GoodsId, GoodsNo]) ->
    {ok, pt:pack(?PT_GOODS_EFF_SELECT, <<RetCode:8, GoodsId:64, GoodsNo:32>>)};

write(?PT_GOODS_WASH_ATTR_TRANSFER, [RetCode, GoodsId, TargetId, TypeList]) ->
    Bin = list_to_binary([ <<Type:8>> || Type <- TypeList]),
    Len = length(TypeList),
    {ok, pt:pack(?PT_GOODS_WASH_ATTR_TRANSFER, <<RetCode:8, GoodsId:64, TargetId:64, Len:16, Bin/binary>>)};

write(?PT_ACTIVE_PERSON_FASHION, [Retcode, No]) ->
    Data = <<Retcode:8, No:16>>,
    {ok, pt:pack(?PT_ACTIVE_PERSON_FASHION, Data)};

write(?PT_CHANGE_PERSON_FASHION, [Retcode, No]) ->
    Data = <<Retcode:8, No:16>>,
    {ok, pt:pack(?PT_CHANGE_PERSON_FASHION, Data)};

write(?PT_PERSON_FASHION_INFO, [List]) ->
    F = fun({No, RemainTime}) ->
        <<No:16, RemainTime:32>>
        end,
    BinInfo = list_to_binary([F(X) || X <- List]),
    ListLen = length(List),
    Data = <<ListLen:16, BinInfo/binary>>,
    {ok, pt:pack(?PT_PERSON_FASHION_INFO, Data)};


write(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {ok, pt:pack(0, <<>>)}.




%% ====================================== Local Functions ==========================================

%% 构造物品的详细信息
build_goods_detail_info(Goods) ->
    BattlePower = lib_goods:get_battle_power(Goods),
        % case lib_goods:is_equip(Goods) of
        %     false -> 0;
        %     true -> lib_equip:calc_battle_power(Goods)
        % end,

    MakerName = case lib_goods:get_maker_name(Goods) of 
        null -> <<"system">>;
        EquipMaker -> EquipMaker
    end,


    % ?DEBUG_MSG("MakerName =~p",[MakerName]),

    BaseInfo = <<
            (Goods#goods.partner_id) : 64,
            (Goods#goods.location) : 8,
            (Goods#goods.id) : 64,
            (Goods#goods.no) : 32,
            (Goods#goods.slot) : 16,
            (Goods#goods.count) : 32,
            (Goods#goods.bind_state) : 8,
            (Goods#goods.quality) : 8,
            (Goods#goods.usable_times) : 16,
            BattlePower : 32,
            ?P_BITSTR(MakerName)
            >>,


    {InfoCount1, Bin1} = build_goods_base_equip_add_info(Goods),
    {InfoCount2, Bin2} = build_goods_equip_prop_info(Goods),
    {InfoCount3, Bin3} = build_goods_left_valid_time_info(Goods),
    {InfoCount4, Bin4} = build_goods_addi_equip_add_info(Goods),
    {InfoCount5, Bin5} = build_goods_stren_equip_add_info(Goods),
    {InfoCount6, Bin6} = build_goods_extra_info(Goods),
    {InfoCount7, Bin7} = build_goods_addi_equip_add_lv(Goods),
    {InfoCount8, Bin8} = build_goods_first_use_time_info(Goods),

    % ?DEBUG_MSG("InfoCount=~p,Bin=~p",[InfoCount1, Bin1]),
    % ?DEBUG_MSG("InfoCount=~p,Bin=~p",[InfoCount2, Bin2]),
    % ?DEBUG_MSG("InfoCount=~p,Bin=~p",[InfoCount3, Bin3]),
    % ?DEBUG_MSG("InfoCount=~p,Bin=~p",[InfoCount4, Bin4]),
    % ?DEBUG_MSG("InfoCount=~p,Bin=~p",[InfoCount5, Bin5]),
    % ?DEBUG_MSG("InfoCount=~p,Bin=~p",[InfoCount6, Bin6]),
    % ?DEBUG_MSG("InfoCount=~p,Bin=~p",[InfoCount7, Bin7]),

    EquipEffNo = build_goods_addi_equip_eff_add_info(Goods),
    SkillNo = build_goods_addi_equip_stu_add_info(Goods),

    % ?DEBUG_MSG("EquipEffNo=~p",[EquipEffNo]),

    {InfoGemCount, BinGem} = build_goods_gem_info(Goods),

    EquipEffNoTemp = lib_goods:get_equip_eff_temp_no(Goods),
    EquipStuntNoTemp = lib_goods:get_equip_stunt_temp_no(Goods),
    CustomType = Goods#goods.custom_type,
	
    <<BaseInfo/binary, (InfoCount1 + InfoCount2 + InfoCount3 + InfoCount4 + InfoCount5 + InfoCount6 + InfoCount7 + InfoCount8):16,
        Bin1/binary, Bin2/binary, Bin3/binary, Bin4/binary, Bin5/binary, Bin6/binary, Bin7/binary,Bin8/binary, InfoGemCount:16,
        BinGem/binary, EquipEffNo:32, SkillNo:32, EquipEffNoTemp:32, EquipStuntNoTemp:32, CustomType:8>>.



%% 构造物品信息：装备的属性加成
%% @return: {信息个数，binary类型的信息详情}
build_goods_base_equip_add_info(Goods) ->
    case lib_goods:is_equip(Goods) of
        false ->
            {0, <<>>};
        true ->
            EquipAddAttrs = lib_goods:get_show_base_equip_add(Goods),
            InfoType = 1,
            F = fun({AttrName, Value}, Acc) ->
                    % ?DEBUG_MSG("pt_15:build_goods_base_equip_add_info: ~p, ~p", [lib_attribute:attr_name_to_obj_info_code(AttrName), Value]),
                    ObjInfoCode = lib_attribute:attr_name_to_obj_info_code(AttrName),
                    case ObjInfoCode =:= ?INVALID_NO of
                        true -> Acc;
                        false ->
                            Value2 = lib_attribute:ajust_value_for_send_to_client(ObjInfoCode, Value),
                            [<<InfoType:8, ObjInfoCode:16, Value2:32>> | Acc]
                    end
                end,

            InfoType1 = 11,
            F1 = fun({AttrName, Value}, Acc) ->
                    % ?DEBUG_MSG("pt_15:build_goods_base_equip_add_info: ~p, ~p", [lib_attribute:attr_name_to_obj_info_code(AttrName), Value]),
                    ObjInfoCode = lib_attribute:attr_name_to_obj_info_code(AttrName),
                    case ObjInfoCode =:= ?INVALID_NO of
                        true -> Acc;
                        false ->
                            Value2 = lib_attribute:ajust_value_for_send_to_client(ObjInfoCode, Value),
                            [<<InfoType1:8, ObjInfoCode:16, Value2:32>> | Acc]
                    end
                end,

            RetList1 = case lib_goods:get_last_base_attr(Goods) of
                null -> [];
                AttrsList -> lists:foldl(F1, [], AttrsList) 
            end,

            % Bin = list_to_binary([F(X) || X <- L]),
            RetList = lists:foldl(F, [], EquipAddAttrs) ++ RetList1,
            Bin = list_to_binary(RetList),
            {length(RetList), Bin}
    end.


%% 构造物品信息：装备的属性加成
%% @return: {信息个数，binary类型的信息详情}
build_goods_addi_equip_add_info(Goods) ->
    case lib_goods:is_equip(Goods) of
        false ->
            {0, <<>>};
        true ->
            case lib_goods:get_addi_ep_add_kv(Goods) of
                [] -> {0, <<>>};
                EquipAddTupL ->
                    % L = lib_attribute:extract_nonzero_fields_info(EquipAddAttrs),

                    ?DEBUG_MSG("EquipAddTupL=~p",[EquipAddTupL]),
                    InfoType = 2,
                    F = fun(Para, Acc) ->
                        {AttrName, Value} =
                            case Para of
                                {_, TAttrName, 0, _Lv} -> {TAttrName, util:ceil(_Lv*100)};
                                {_, TAttrName, TValue, _Lv} -> {TAttrName, TValue};

                                {TAttrName, TValue} -> {TAttrName, TValue}
                            end,
                        
                        case Value of
                            0 -> Acc;
                            _ ->
                                ObjInfoCode = lib_attribute:attr_name_to_obj_info_code(AttrName),
                                case ObjInfoCode =:= ?INVALID_NO of
                                    true -> Acc;
                                    false ->
                                        Value2 = lib_attribute:ajust_value_for_send_to_client(ObjInfoCode, Value),
                                        [<<InfoType:8, ObjInfoCode:16, Value2:32>> | Acc]
                                end
                        end

                    end,

                    InfoType1 = 12,
                    F1 = fun(Para, Acc) ->
                        {AttrName, Value} =
                            case Para of
                                {_, TAttrName, TValue, _Lv} -> {TAttrName, TValue};
                                {TAttrName, TValue} -> {TAttrName, TValue}
                            end,

                        ObjInfoCode = lib_attribute:attr_name_to_obj_info_code(AttrName),
                        case ObjInfoCode =:= ?INVALID_NO of
                            true -> Acc;
                            false ->
                                Value2 = lib_attribute:ajust_value_for_send_to_client(ObjInfoCode, Value),
                                [<<InfoType1:8, ObjInfoCode:16, Value2:32>> | Acc]
                        end
                    end,

                    RetList1 = case lib_goods:get_last_ref_attr(Goods) of
                        null -> [];
                        AttrsList -> lists:foldl(F1, [], AttrsList) 
                    end,

                    InfoType2 = 22,
                    F2 = fun(Para, Acc) ->
                        {AttrName, Value} =
                            case Para of
                                {_, TAttrName, TValue, _Lv} -> {TAttrName, TValue};
                                {TAttrName, TValue} -> {TAttrName, TValue}
                            end,
                        ObjInfoCode = lib_attribute:attr_name_to_obj_info_code(AttrName),
                        case ObjInfoCode =:= ?INVALID_NO of
                            true -> Acc;
                            false ->
                                Value2 = lib_attribute:ajust_value_for_send_to_client(ObjInfoCode, Value),
                                [<<InfoType2:8, ObjInfoCode:16, Value2:32>> | Acc]
                        end
                    end,

                    RetList2 = case lib_goods:get_transmo_ref_attr(Goods) of
                                   null ->[];
                                   AttrsList2 -> lists:foldl(F2, [], AttrsList2)
                               end,
                    ?DEBUG_MSG("-----------------------------RetList2--------------------------~p~n", [RetList2]),

                    InfoType3 = 32,
                    F3 = fun(Para, Acc) ->
                        {AttrName, Value} =
                            case Para of
                                {_, TAttrName, TValue, _Lv} -> {TAttrName, TValue};
                                {TAttrName, TValue} -> {TAttrName, TValue}
                            end,
                        ObjInfoCode = lib_attribute:attr_name_to_obj_info_code(AttrName),
                        case ObjInfoCode =:= ?INVALID_NO of
                            true -> Acc;
                            false ->
                                Value2 = lib_attribute:ajust_value_for_send_to_client(ObjInfoCode, Value),
                                [<<InfoType3:8, ObjInfoCode:16, Value2:32>> | Acc]
                        end
                    end,

                    RetList3 = case lib_goods:get_transmo_last_ref_attr(Goods)of
                                   null -> [];
                                   AttrsList3 ->
                                       lists:foldl(F3, [], AttrsList3)
                               end,

                    ?DEBUG_MSG("-----------------------------RetList3--------------------------~p~n", [RetList3]),
                    RetList = lists:foldl(F, [], sort_by_index(EquipAddTupL)) ++ RetList1 ++ RetList2 ++ RetList3,
                    Bin = list_to_binary(RetList),
                    {length(RetList), Bin}
            end
    end.

%% 构造物品信息：特效属性
%% @return: {信息个数，binary类型的信息详情}
build_goods_addi_equip_eff_add_info(Goods) ->
    case lib_goods:is_equip(Goods) of
        false ->
            0;
        true ->
            case lib_goods:get_equip_effect(Goods) of
                0 -> 0;
                EffNo ->
                   EffNo
            end
    end.

% 构造物品信息：特技属性
build_goods_addi_equip_stu_add_info(Goods) ->
    case lib_goods:is_equip(Goods) of
        false ->
            0;
        true ->
            ?DEBUG_MSG("lib_goods:get_equip_stunt(Goods) =~p",[lib_goods:get_equip_stunt(Goods) ]),
            case lib_goods:get_equip_stunt(Goods) of
                0 -> 0;
                SkillNo ->
                   SkillNo
            end
    end.


build_goods_addi_equip_add_lv(Goods) ->
    case lib_goods:is_equip(Goods) of
        false ->
            {0, <<>>};
        true ->
            case lib_goods:get_addi_ep_add_kv(Goods) of
                [] -> {0, <<>>};
                EquipAddTupL ->
                    InfoType = 6,
                    F = fun(Para, Acc) ->
                            {AttrName, Lv} = 
                                case Para of
                                    {_, TAttrName, _Value, TLv} -> {TAttrName, 0};
                                    {TAttrName, _Value} -> {TAttrName, 0}
                                end,
                            ObjInfoCode = lib_attribute:attr_name_to_obj_info_code(AttrName),
                            case ObjInfoCode =:= ?INVALID_NO of
                                true -> Acc;
                                false ->
                                    [<<InfoType:8, ObjInfoCode:16, Lv:32>> | Acc]
                            end
                        end,
                    RetList = lists:foldl(F, [], sort_by_index(EquipAddTupL)),
                    Bin = list_to_binary(RetList),
                    {length(RetList), Bin}
            end
    end.    


build_goods_stren_equip_add_info(Goods) ->
    case lib_goods:is_equip(Goods) of
        false ->
            {0, <<>>};
        true ->
            case lib_goods:get_stren_equip_add(Goods) of
                null -> {0, <<>>};
                EquipAddAttrs ->
                    L = lib_attribute:extract_nonzero_fields_info(EquipAddAttrs),
                    InfoType = 3,
                    F = fun({AttrName, Value}, Acc) ->
                            ObjInfoCode = lib_attribute:attr_name_to_obj_info_code(AttrName),
                            case ObjInfoCode =:= ?INVALID_NO of
                                true -> Acc;
                                false ->
                                    Value2 = lib_attribute:ajust_value_for_send_to_client(ObjInfoCode, Value),
                                    [<<InfoType:8, ObjInfoCode:16, Value2:32>> | Acc]
                            end
                        end,
                    RetList = lists:foldl(F, [], L),
                    Bin = list_to_binary(RetList),
                    {length(RetList), Bin}
            end
    end.

%% 目前只有挖宝区域信息 和 法宝相关信息
% 添加购买价格跟购买价格类型的记录
build_goods_extra_info(Goods) ->
    InfoTypeMk = 7,
    F = fun(Id, Acc) -> [<<InfoTypeMk:8, (?OI_CODE_MK_SKILL):16, Id:32>> | Acc] end,

    BuyPirce = lib_goods:get_purchase_price(Goods),
    BuyPirceType = lib_goods:get_purchase_price_type(Goods),

    % ?DEBUG_MSG("BuyPirce=~p,BuyPirceType=~p,Goods=~p",[BuyPirce,BuyPirceType,Goods]),

    PirceInfoType = 8,
    EquipMakeType = 9,
    TransmoEffType = 19,
    TransmoTmpEffType = 29,

    LastSellTime = lib_goods:get_last_sell_time(Goods),

    EquipEffNo = lib_goods:get_equip_effect(Goods),
    TransmoEffNo = lib_goods:get_transmo_eff_no(Goods),
    TransmoTmpEffNo = lib_goods:get_transmo_last_eff_no(Goods),

    QualityLv = lib_goods:get_quality_lv(Goods),
    HeadRet = [
        <<PirceInfoType:8,(?OI_BUY_PRICE):16,BuyPirce:32>>,
        <<PirceInfoType:8,(?OI_BUY_PRICE_TYPE):16,BuyPirceType:32>>,
        <<PirceInfoType:8,(?OI_GOODS_LAST_SELL_TIME):16, LastSellTime:32>>,
        <<EquipMakeType:8,(?OI_EQUIP_EFFECT):16,EquipEffNo:32>>,
        <<TransmoEffType:8,(?OI_EQUIP_EFFECT):16,TransmoEffNo:32>>,
        <<TransmoTmpEffType:8,(?OI_EQUIP_EFFECT):16,TransmoTmpEffNo:32>>,
        <<InfoTypeMk:8, (?OI_CODE_QUALITY_LV):16, QualityLv:32 >>
    ], 

    % HeadRet = case lib_goods:get_maker_name(Goods) of 
    %     null -> HeadRet1;
    %     EquipMaker -> 
    %     ?DEBUG_MSG("EquipMaker ~p",[EquipMaker]),
    %     HeadRet1 ++ <<EquipMakeType:8,(?OI_EQUIP_MAKER):8,EquipMaker/binary>>
    % end,
        
    % ?DEBUG_MSG("HeadRet=~p",[HeadRet]),    
    case lib_goods:get_extra(Goods, dig_treasure) of
        null -> 
            case lib_goods:is_magic_key(Goods) of
                false -> 
                    AllList = HeadRet,
                    Bin = list_to_binary(AllList),
                    {length(AllList), Bin};
                true ->
                   RetList = lists:foldl(F, [<<InfoTypeMk:8, (?OI_CODE_QUALITY_LV):16, (lib_goods:get_quality_lv(Goods)):32>>], lists:reverse(lib_goods:get_mk_skill_list(Goods))),
                   AllList = HeadRet ++ RetList,
                   Bin = list_to_binary(AllList),
                    {length(AllList), Bin}
            end;
        {_, {SceneNo, X, Y}} ->
            InfoType = 5,
            RetListDig = 
                [
                        <<InfoType:8, (?OI_CODE_DIG_SCENO_NO):16, SceneNo:32>>,
                        <<InfoType:8, (?OI_CODE_DIG_SCENO_X):16, X:32>>,
                        <<InfoType:8, (?OI_CODE_DIG_SCENO_Y):16, Y:32>>
                ],

            RetList = 
                case lib_goods:is_magic_key(Goods) of
                    false -> RetListDig;
                    true -> RetListDig ++ lists:foldl(F, [<<InfoTypeMk:8, (?OI_CODE_QUALITY_LV):16, (lib_goods:get_quality_lv(Goods)):32>>], lists:reverse(lib_goods:get_mk_skill_list(Goods)))
                end,

            AllList = HeadRet ++ RetList,

            Bin = list_to_binary(AllList),
            {length(AllList), Bin}
    end.

build_goods_gem_info(Goods) ->
    case lib_goods:is_equip(Goods) of
        false ->
            {0, <<>>};
        true ->
            % 增加兼容判断是否存在宝石
            GemStoneList = lib_goods:get_equip_gemstone(Goods),
            F = fun({HoleNo, GoodsId}) ->
                    case lib_goods:get_goods_by_id(GoodsId) of
                        null ->
                            <<HoleNo:8, 0:64, 0:32>>;
                        GoodsGem ->
                            GoodsNo =
                                case GoodsId =:= ?INVALID_ID of
                                    true -> ?INVALID_NO;
                                    false -> lib_goods:get_no_by_id(GoodsId)
                                end,
                            <<HoleNo:8, GoodsId:64, GoodsNo:32>>
                    end
                    
                end,
            Bin = list_to_binary([F(X) || X <- GemStoneList]),

            {length(GemStoneList), Bin}
    end.

%% 构造物品信息：装备自身的属性信息（如：强化等级）注意：不包括宝石镶嵌
%% @return: {信息个数，binary类型的信息详情}
build_goods_equip_prop_info(Goods) ->
    case lib_goods:is_equip(Goods) of
        false ->
            {0, <<>>};
        true ->
            EquipProp = lib_goods:get_equip_prop(Goods),
            ?ASSERT(is_record(EquipProp, equip_prop), {EquipProp, Goods}),
            L = lib_goods:extract_nonzero_fields_info_from(EquipProp),
            InfoType = 3,
            L1 =
                case lists:keyfind(?EQP_PROP_GEM_INLAY, 1, L) of
                    false -> L;
                    {?EQP_PROP_GEM_INLAY, TValue} -> L -- [{?EQP_PROP_GEM_INLAY, TValue}]
                end,
            F = fun({EquipPropName, Value}) ->
                    <<InfoType:8, (lib_equip:equip_prop_name_to_obj_info_code(EquipPropName)):16, Value:32>>
                end,
            Bin = list_to_binary([F(X) || X <- L1]),
            {length(L1), Bin}
    end.




%% 构造物品信息：剩余有效时间
%% @return: {信息个数，binary类型的信息详情}
build_goods_left_valid_time_info(Goods) ->
    case lib_goods:is_timing_goods(Goods) of
        false ->
            {0, <<>>};
        true ->
            InfoType = 4,
            ExpireTime = 
                case lib_goods:get_expire_time(Goods) > 0 of
                    true -> lib_goods:get_expire_time(Goods);
                    false -> lib_goods:get_left_valid_time(Goods) + util:unixtime()
                end,
            % ?DEBUG_MSG("pt_15:build_goods_left_valid_time_info:GoodsNo:~p, GoodsName:~p, ExpireTime:~p~n", [lib_goods:get_no(Goods), lib_goods:get_name(Goods), ExpireTime]),
            Bin = <<InfoType:8, ?OI_CODE_LEFT_VALID_TIME:16, ExpireTime:32>>,
            {1, Bin}
    end.


build_goods_first_use_time_info(Goods) ->
    case lib_goods:is_timing_goods(Goods) of
        false ->
            {0, <<>>};
        true ->
            InfoType = 4,
            FirstUseTime = lib_goods:get_first_use_time(Goods),
            % ?DEBUG_MSG("pt_15:build_goods_left_valid_time_info:GoodsNo:~p, GoodsName:~p, ExpireTime:~p~n", [lib_goods:get_no(Goods), lib_goods:get_name(Goods), ExpireTime]),
            Bin = <<InfoType:8, ?OI_CODE_FIRST_USE_TIME:16, FirstUseTime:32>>,
            {1, Bin}
    end.


%% 构造物品信息：剩余有效时间
%% @return: {信息个数，binary类型的信息详情}
% build_goods_battle_power_info(Goods) ->
%     case lib_goods:is_equip(Goods) of
%         false ->
%             {0, <<>>};
%         true ->
%             InfoType = 5,
%             Bin = <<InfoType:8, ?OI_CODE_BATTLE_POWER:8, (lib_equip:calc_battle_power(Goods)):32>>,
%             {1, Bin}
%     end.

%% 从编号大到小排序
sort_by_index(EquipAddTupL) ->
    F = fun(Tup1, Tup2) ->
        element(1, Tup1) > element(1, Tup2)
    end,
    lists:sort(F, EquipAddTupL).