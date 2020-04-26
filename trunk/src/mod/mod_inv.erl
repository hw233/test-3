%%%--------------------------------------
%%% @Module  : mod_inv (inv: 表示inventory)
%%% @Author  : huangjf, zhangwq
%%% @Email   :
%%% @Created : 2013.5.15
%%% @Description : 玩家的物品栏
%%%                注：玩家的物品栏是一个概念，包括玩家的背包、仓库、装备栏以及其宠物的装备栏。
%%%--------------------------------------
-module(mod_inv).


-include("common.hrl").
-include("record.hrl").
-include("inventory.hrl").
-include("ets_name.hrl").
-include("prompt_msg_code.hrl").
-include("abbreviate.hrl").
-include("goods.hrl").
-include("record/goods_record.hrl").
-include("job_schedule.hrl").
-include("effect.hrl").
-include("reward.hrl").
-include("log.hrl").
-include("debug.hrl").
-include("buff.hrl").
-include("player.hrl").
-include("admin_activity.hrl").

-export([
		 	add_inventory_to_ets/1,
            init_inventory/3,                   % 初始化物品栏
            get_inventory/1,                    % 获取物品栏
            get_bag_capacity/2,                 % 获取背包容量
            get_storage_capacity/1,             % 获取仓库容量
            get_bag_goods_by_id/3,              % 依据物品id在背包中查找物品
            get_storage_goods_by_id/2,          % 依据物品id在仓库中查找物品
            get_empty_slot_list/2,              % 获取空槽（空格子）列表
            del_inventory_from_ets/1,           % 玩家下线，删除相应的物品栏信息
            del_goods_from_ets_by_player_id/1,  % 玩家下线, 删除玩家所有物品信息
            db_save_inventory/1,                % 保存物品栏数据到DB
            db_load_storage_goods/1,            % 从DB加载仓库数据
            del_goods_from_temp_bag/1,          % 玩家彻底下线，尝试从数据库删除临时背包物品

            update_inventory_to_ets/1,          % 更新物品栏数据到ets

            add_goods_to_bag/3,                 % 把现有的物品添加到玩家的背包
            smart_add_goods/2,                  % 把现有的物品智能添加到玩家的背包(智能的意思是会自动叠加)

            batch_smart_add_new_goods/2,       % 智能添加多个物品到背包或任务背包(智能的意思是会自动叠加)
            batch_smart_add_new_goods/3,       % 智能添加多个物品到背包或任务背包(智能的意思是会自动叠加) ，附带物品的额外的初始化信息（如：指定物品的品质、绑定状态等）
            batch_smart_add_new_goods/4,
            
            add_new_goods_to_bag/3,             % 同上
            add_new_goods_to_bag/4,             % 同上
            add_new_goods_to_bag_by_build/4,
            add_new_goods_to_bag_by_guild_use/5,%

            add_new_goods_to_player/3,         % 添加物品给玩家，放到背包以外的虚拟位置：如邮件附件

            remove_goods_from_bag/2,            % 从背包移除物品（只是从背包移除，并不销毁物品）% 使用例子：当成功挂售背包中的一个物品到市场时，可以调用该接口

            get_goods_list/2,                   % 获取背包或仓库的物品列表
            extend_capacity/3,

            check_batch_destroy_goods_by_id/2,
            check_batch_destroy_goods/2,        % 检查是否可以批量销毁物品
            destroy_goods/3,                    % 销毁物品（注意：此接口会彻底删除物品，包括删除数据库中物品对应的记录）
            destroy_goods/4,                    % 销毁物品（注意：此接口会彻底删除物品，包括删除数据库中物品对应的记录）
            destroy_goods_WNC/3,                % 销毁物品，同上，只是多了通知客户端的处理
            destroy_goods_WNC/2,                % 根据物品编号与个数 销毁物品，同上，只是多了通知客户端的处理
            destroy_goods_WNC/4,                % 根据物品编号与个数 销毁物品，同上，只是多了通知客户端的处理
            destroy_all_goods_by_no/2,          % 根据物品编号删除该编号的所有物品
            destroy_all_goods_by_no/3,          % 根据物品编号删除该编号的所有物品
            destroy_goods_by_id_WNC/2,          % 根据物品唯一id和要删除的物品个数删除物品
            destroy_goods_by_id_WNC/3,          % 根据物品唯一id和要删除的物品个数删除物品
            destroy_goods_by_id/2,              % 根据物品唯一id删除物品
            destroy_goods_by_id/3,              % 根据物品唯一id删除物品
            destroy_goods_offline/3,            % 删除离线玩家的物品数据

            drag_goods/4,                       % 拖动物品，从一个格子移到另一个格子 只能拖动背包或仓库中的物品
            move_goods/4,                       % 搬移物品（从背包到仓库，或从仓库到背包）

            destroy_goods_from_temp_bag/2,      % 从临时背包销毁物品
            get_all_goods_from_temp_bag/1,      % 从临时背包获取物品
            get_all_goods_from_temp_reset_bag/1,      % 从临时背包获取物品

            use_goods/2,                        % 使用物品
            use_goods/3,                        % 使用物品
            do_use_goods/3,                     % 宠物使用物品，需上层函数检查是否能使用
            do_use_goods/4,                     % 宠物使用物品，需上层函数检查是否能使用
            mark_dirty_flag/2,                  % 标记物品为脏（脏：指物品对象的数据在内存中有改动，但未更新到DB）
            clear_dirty_flag/2,

            is_bag_eq_full/1,                   % 判断装备背包是否已满
            is_bag_usable_full/1,               % 判断可使用物品背包是否已满
            is_bag_unusable_full/1,             % 判断不可使用背包是否已满
            is_storage_full/1,                  % 仓库是否已满

            has_enough_goods_in_bag/3,          % 判断玩家背包中是否有足够数量的指定编号的物品
            has_goods_in_bag_by_no/2,           % 判断玩家背包里是否有指定编号的物品
            has_goods_in_bag_by_id/2,           % 判断玩家背包里是否有指定唯一id的物品
            find_goods_by_no/3,                 % 根据物品编号和所在地查找物品
            find_goods_by_id/3,                 % 根据物品唯一id和所在地查找物品

            find_all_goods_by_type_and_sub/3,   % 根据物品的类型跟子类型查找物品

            find_all_goods_in_bag_by_no/2,      % 根据物品编号在背包中查找物品
            calc_add_new_goods_need_slots/2,    % 计算添加指定编号和数量的新物品时，所需的空格子数
            has_enough_empty_slots/3,           % 判断玩家背包或仓库中是否有足够数量的空格子
            find_first_empty_slot/2,            %
            calc_empty_slots/2,                 % 计算背包或仓库中的空格子数
            arrange_bag/1,                      % 整理背包
            arrange_storage/1,                  % 整理仓库
            get_goods_list_by_id_list/1,        % 根据物品id列表获取物品列表

            get_goods_count_in_bag_by_no/2,     % 根据物品编号找出该编号的物品数量
            get_goods_count_in_bag/3,           % 根据条件找出物品数量
            check_batch_add_goods/2,            % 是否可以把物品列表放到背包或任务背包
            find_goods_by_id_from_whole_inv/2,  % 根据物品唯一id尝试在整个物品栏中查找玩家自己的物品
            find_goods_by_id_from_whole_inv_except_EQP/2,
            find_goods_by_id_from_bag/2,        % 根据物品唯一id尝试在背包（包括装备，可用，不可用物品背包）中查找玩家自己的物品
            get_goods_from_ets/1,               % 根据物品唯一id尝试在整个物品栏中查找玩家自己或者其他玩家的物品
            get_goods_no_by_goods_id/2,         % 根据物品唯一id获取物品编号
            get_goods_count_in_bag_by_id/2,     % 根据物品唯一找出该物品数量的堆叠数量,包括邮件附件的物品
            handle_goods_expired/2,             % 处理时效物品过期
            add_goods_to_ets/1,                 % 添加物品到ets
            update_goods_to_ets/1,
            del_goods_from_ets_by_goods_id/1,   % 根据物品id从ets删除物品

            auto_use_goods_for_add_store_hp/1,  %
            auto_use_goods_for_add_store_mp/1,
            auto_use_goods_for_add_store_par_hp/1,
            auto_use_goods_for_add_store_par_mp/1,

            % adjust_goods/2,
            get_goods_quality_by_id/2,
            get_goods_bind_state_by_id/1,
            arrange_goods_list/1,
            to_goods_record/1,
            get_goods_info_from_db/1         % 从数据库获取道具信息
            ,extra_handle_for_timging_goods_when_use_it/1
         ]).



%% 玩家上线时初始化物品栏
init_inventory(PlayerId, PlayerPid, [BagEQCapacity, BagUSCapacity, BagUNUSCapacity, StoCapacity]) ->
    Version = case lib_player_ext:try_load_data(PlayerId,version) of
        fail ->
            0;
        {ok,Value} ->
            Value
    end,
    ?DEBUG_MSG("Version=~p",[Version]),

    % Ret = 
    % case Version of
    %     ?GOODS_RESET_VERSION -> 
    %         GoodsList = db_load_bag_goods(PlayerId),
    %         F0 = fun(X) ->
    %             case lib_goods:is_equip(X) of
    %                 true -> true;
    %                 false ->
    %                     case lib_goods:get_slot(X) =:= 0 of
    %                         true -> true;
    %                         false -> false
    %                     end
    %             end
    %         end,

    %         Inv = #inv{
    %                 player_id = PlayerId,
    %                 bag_eq_capacity = BagEQCapacity,
    %                 bag_usable_capacity = BagUSCapacity,
    %                 bag_unusable_capacity = BagUNUSCapacity,
    %                 storage_capacity = case StoCapacity < ?DEF_STORAGE_CAPACITY of true -> ?DEF_STORAGE_CAPACITY; false -> StoCapacity end,

    %                 eq_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_BAG_EQ, F0(X)],
    %                 usable_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_BAG_USABLE],
    %                 unusable_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_BAG_UNUSABLE],

    %                 storage_goods = null,  % null表示未初始化，因为仓库物品采用按需动态加载的策略

    %                 player_eq_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_PLAYER_EQP, F0(X)],
    %                 partner_eq_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_PARTNER_EQP, F0(X)]
    %                 },

    %         add_inventory_to_ets(Inv),

    %         F = fun(Goods) ->
    %                 add_goods_to_ets(Goods)
    %             end,
    %         % Ret =  lists:foreach(F, GoodsList),
    %         void;
    %     _ ->

    %         % ----------------------------------------------------------
    %         GoodsList = db_load_bag_goods1(PlayerId),
    %         F0 = fun(X) ->
    %             case lib_goods:is_equip(X) of
    %                 true -> true;
    %                 false -> false
    %             end
    %         end,

    %         ?DEBUG_MSG("GoodsList=~p",[GoodsList]),

    %         Inv = #inv{
    %                 player_id = PlayerId,
    %                 bag_eq_capacity = BagEQCapacity,
    %                 bag_usable_capacity = BagUSCapacity,
    %                 bag_unusable_capacity = BagUNUSCapacity,
    %                 storage_capacity = case StoCapacity < ?DEF_STORAGE_CAPACITY of true -> ?DEF_STORAGE_CAPACITY; false -> StoCapacity end,

    %                 eq_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_BAG_EQ, F0(X)],
    %                 usable_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_BAG_USABLE],
    %                 unusable_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_BAG_UNUSABLE],

    %                 storage_goods = null,  % null表示未初始化，因为仓库物品采用按需动态加载的策略

    %                 player_eq_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_PLAYER_EQP, F0(X)],
    %                 partner_eq_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_PARTNER_EQP, F0(X)],
    %                 temp_reset_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_TEMP_RESET]
    %                 },

    %         add_inventory_to_ets(Inv),

    %         F = fun(Goods) ->
    %                 add_goods_to_ets(Goods)
    %             end,
    %         lists:foreach(F, GoodsList),


    %         % ----------------------------------------------------------

    %         % 需要修正数据
    %         lib_player_ext:try_update_data(PlayerId,version,?GOODS_RESET_VERSION)
    % end,

    % --------------------------------------- 正常情况下
    GoodsList = db_load_bag_goods(PlayerId),

    F0 = fun(X) ->
        case lib_goods:is_equip(X) of
            true -> true;
            false ->
                case lib_goods:get_slot(X) =:= 0 of
                    true -> true;
                    false -> false
                end
        end
    end,

    Inv = #inv{
            player_id = PlayerId,
            bag_eq_capacity = BagEQCapacity,
            bag_usable_capacity = BagUSCapacity,
            bag_unusable_capacity = BagUNUSCapacity,
            storage_capacity = case StoCapacity < ?DEF_STORAGE_CAPACITY of true -> ?DEF_STORAGE_CAPACITY; false -> StoCapacity end,

            eq_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_BAG_EQ, F0(X)],
            usable_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_BAG_USABLE],
            unusable_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_BAG_UNUSABLE],

            storage_goods = null,  % null表示未初始化，因为仓库物品采用按需动态加载的策略

            player_eq_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_PLAYER_EQP, F0(X)],
            partner_eq_goods = [X#goods.id || X <- GoodsList, X#goods.location == ?LOC_PARTNER_EQP, F0(X)]
            },

    add_inventory_to_ets(Inv),

    F = fun(Goods) ->
            add_goods_to_ets(Goods)
        end,
    lists:foreach(F, GoodsList),
    % % ------------------------------------------------

    % Ret.


    %% 以下是容错代码,如果线上服没有物品id不符合合服要求，可以注释掉
    adjust_goods(PlayerId, PlayerPid, GoodsList).    

adjust_goods(PlayerId, PlayerPid, GoodsList) ->
    ServerId = config:get_server_id(),
    % case ServerId =:= 10026 orelse ServerId =:= 10027 of
    %     false -> skip;
        % true ->
            F1 = fun(Goods, AccGoods) ->
                case lib_goods:is_equip(Goods) of
                    false -> 
                        AccGoods;
                    true ->
                        GemStoneList = lib_goods:get_equip_gemstone(Goods),
                        case GemStoneList =:= [] of
                            true -> AccGoods;
                            false ->
                                F2 = fun({HNo, Id}, Acc) ->
                                    case Id =:= ?INVALID_ID of
                                        true -> [{HNo, Id} | Acc];
                                        false ->
                                            NewId = 
                                                case lib_account:is_global_uni_id(Id) of
                                                    true -> Id;
                                                    false -> lib_account:to_global_uni_id(Id)
                                                end,

                                            case get_goods_from_ets(NewId) of
                                                null -> [{HNo, ?INVALID_ID} | Acc];
                                                _GemGoods -> [{HNo, NewId} | Acc]
                                            end
                                    end
                                end,
                                NewGemStoneList = lists:foldl(F2, [], GemStoneList),
                                case NewGemStoneList =:= GemStoneList of
                                    true -> AccGoods;
                                    false ->
                                        Goods1 = lib_goods:set_equip_gemstone(Goods, NewGemStoneList),
                                        [Goods1 | AccGoods]
                                end
                        end
                end
            end,

            AdjustGooodsList = lists:foldl(F1, [], GoodsList),

            case AdjustGooodsList =:= [] of
                true -> skip;
                false -> gen_server:cast(PlayerPid, {'adjust_goods', AdjustGooodsList, PlayerId})
            end.
    % end.

%% 以下是容错代码,如果线上服没有宝石位置错乱等bug的话，可以注释掉
% adjust_goods(PlayerId, PlayerPid, GoodsList) ->
%     F1 = fun(Goods, AccGoods) ->
%         case lib_goods:is_equip(Goods) of
%             false -> 
%                 case lib_goods:is_equip(Goods) of
%                     false -> 
%                         case lists:member(lib_goods:get_location(Goods), [?LOC_BAG_EQ, ?LOC_PLAYER_EQP, ?LOC_PARTNER_EQP]) of
%                             false -> AccGoods;
%                             true -> %% 宝石在装备区域
%                                 case lib_goods:get_slot(Goods) =:= 0 of
%                                     true -> %% 镶嵌的情况，正常
%                                         AccGoods;
%                                     false -> %% bug导致位置错乱
%                                         [Goods | AccGoods]
%                                 end
%                         end;
%                     true ->
%                         AccGoods
%                 end;
%             true ->
%                 GemStoneList = lib_goods:get_equip_gemstone(Goods),
%                 F2 = fun({HNo, Id}, Acc) ->
%                     case Id =:= ?INVALID_ID of
%                         true -> [{HNo, Id} | Acc];
%                         false ->
%                             case get_goods_from_ets(Id) of
%                                 null -> [{HNo, ?INVALID_ID} | Acc];
%                                 GemGoods -> 
%                                     case lib_goods:get_slot(GemGoods) =:= 0 of
%                                         true -> [{HNo, Id} | Acc];
%                                         false ->
%                                             GemGoods1 = lib_goods:set_slot(GemGoods, ?INVALID_NO),
%                                             GemGoods2 = lib_goods:set_dirty(GemGoods1, true),
%                                             GemGoods3 = lib_goods:set_count(GemGoods2, 1),
%                                             update_goods_to_ets(GemGoods3),
%                                             [{HNo, Id} | Acc]
%                                     end
%                             end
%                     end
%                 end,
%                 NewGemStoneList = lists:foldl(F2, [], GemStoneList),
%                 case NewGemStoneList =:= GemStoneList of
%                     true -> skip;
%                     false ->
%                         Goods1 = lib_goods:set_equip_gemstone(Goods, NewGemStoneList),
%                         Goods2 = lib_goods:set_dirty(Goods1, true),
%                         update_goods_to_ets(Goods2)
%                 end,
%                 AccGoods
%         end
%     end,
    
%     AdjustGooodsList = lists:foldl(F1, [], GoodsList),
%     case AdjustGooodsList =:= [] of
%         true -> skip;
%         false -> 
%             F3 = fun(X, AccA) ->
%                 case get_goods_from_ets(lib_goods:get_id(X)) of
%                     null -> AccA;
%                     NewX ->
%                         case lib_goods:get_slot(NewX) =:= 0 of
%                             true -> AccA;
%                             false -> [NewX | AccA]
%                         end
%                 end
%             end,
%             AdjustGooodsList1 = lists:foldl(F3, [], AdjustGooodsList),
%             case AdjustGooodsList1 =:= [] of
%                 true -> skip;
%                 false -> gen_server:cast(PlayerPid, {'adjust_goods', AdjustGooodsList1, PlayerId})
%             end
%     end.

%% 以下方法在玩家完全进入游戏后处理，但不可行，因为get_goods_list_by_id_list获取的物品列表已经去除了位置出错的物品
% adjust_goods(PlayerId, RoleCacheInfo) ->
%     case RoleCacheInfo of
%         role_in_cache -> skip;
%         role_not_in_cache -> 
%             case get_inventory(PlayerId) of
%                 null -> skip;
%                 Inv ->
%                     GoodsList = get_goods_list_by_id_list(Inv#inv.eq_goods) ++ get_goods_list_by_id_list(Inv#inv.player_eq_goods) ++
%                                 get_goods_list_by_id_list(Inv#inv.partner_eq_goods),

%                     F = fun(Goods, AccGoods) ->
%                         case lib_goods:is_equip(Goods) of
%                             false -> 
%                                 case lists:member(lib_goods:get_location(Goods), [?LOC_BAG_EQ, ?LOC_PLAYER_EQP, ?LOC_PARTNER_EQP]) of
%                                     false -> AccGoods;
%                                     true -> %% 宝石在装备区域
%                                         case lib_goods:get_slot(Goods) =:= 0 of
%                                             true -> %% 镶嵌的情况，正常
%                                                 AccGoods;
%                                             false -> %% bug导致位置错乱
%                                                 [Goods | AccGoods]
%                                         end
%                                 end;
%                             true ->
%                                 AccGoods
%                         end
%                     end,

%                     AdjustGooodsList = lists:foldl(F, [], GoodsList),

%                     F1 = fun(Goods) ->
%                         ?ERROR_MSG("[mod_player] adjust_goods, PlayerId:~p, GoodsList:~w~n", [PlayerId, Goods]),
%                         mod_inv:smart_add_goods(PlayerId, lib_goods:set_slot(Goods, ?INVALID_NO))
%                     end,
%                     lists:foreach(F1, AdjustGooodsList)
%             end
%     end.



% %% 判断物品栏是否被锁定了
% is_inv_locked(PlayerId) ->
%     Inv = get_inventory(PlayerId),
%     Inv#inv.is_locked.



% %% 锁定物品栏
% lock_inventory(PlayerId) ->
%     Inv = get_inventory(PlayerId),
%     Inv2 = Inv#inv{is_locked = true},
%     update_inventory_to_ets(Inv2).


% %% 解锁物品栏
% unlock_inventory(PlayerId) ->
%     Inv = get_inventory(PlayerId),
%     Inv2 = Inv#inv{is_locked = false},
%     update_inventory_to_ets(Inv2).



%% 保存玩家的物品栏据到数据库
db_save_inventory(PlayerId) ->
    % 遍历物品栏的所有物品，对于is_dirty标记为true的物品， 将其更新到数据库，否则，跳过对该物品的处理
    Inv = get_inventory(PlayerId),
    TimeNow = util:unixtime(),
    % save背包
    db_save_inventory_2(Inv#inv.eq_goods, PlayerId, TimeNow),

    % save背包
    db_save_inventory_2(Inv#inv.usable_goods, PlayerId, TimeNow),

    db_save_inventory_2(Inv#inv.unusable_goods, PlayerId, TimeNow),

    % save玩家装备栏
    db_save_inventory_2(Inv#inv.player_eq_goods, PlayerId, TimeNow),

    % save玩家的宠物的装备栏
    db_save_inventory_2(Inv#inv.partner_eq_goods, PlayerId, TimeNow),

    % save仓库
    ?Ifc (Inv#inv.storage_goods /= null)
        db_save_inventory_2(Inv#inv.storage_goods, PlayerId, TimeNow)
    ?End,
    ok.



db_save_inventory_2([], _PlayerId, _TimeNow) ->
    skip;
db_save_inventory_2([GoodsId | T], PlayerId, TimeNow) ->
    Goods = get_goods_from_ets(GoodsId),
    % ?ASSERT(is_record(Goods, goods), GoodsId),
    % ?ASSERT(lib_goods:get_owner_id(Goods) == PlayerId, {lib_goods:get_owner_id(Goods), PlayerId}),  % 顺带做下断言
    case is_record(Goods, goods) of
        false ->
            % ?ERROR_MSG("is_record(Goods, goods)=~p,GoodsId=~p,PlayerId=~p",[is_record(Goods, goods) ,GoodsId,PlayerId]),
            % skip;
            db_save_inventory_2(T, PlayerId, TimeNow); %% 多进程并发有可能引起此分支
        true ->
            case lib_goods:get_owner_id(Goods) == PlayerId of
                false ->
                    % ?ERROR_MSG("lib_goods:get_owner_id(Goods)=~p, PlayerId=~p,GoodsId=~p",[lib_goods:get_owner_id(Goods) ,PlayerId,GoodsId]),
                    % skip;
                    db_save_inventory_2(T, PlayerId, TimeNow); %% 多进程并发有可能引起此分支
                true ->
                    case Goods =:= null of
                        true -> db_save_inventory_2(T, PlayerId, TimeNow); %% 多进程并发有可能引起此分支
                        false ->
                            case lib_goods:is_dirty(Goods) of
                                true ->
                                    lib_goods:db_save_goods(Goods),
                                    clear_dirty_flag(PlayerId, Goods);  % 保存到DB后尝试清除脏标记，下同
                                false ->
                                    % 按在线累积时间计算并且未过期的时效物品也做保存的操作（为了更新剩余有效时间）
                                    case lib_goods:is_in_timekeeping(Goods)
                                    andalso (lib_goods:get_timekeeping_type(Goods) == ?TKP_BY_ACC_ONLINE)
                                    andalso (not lib_goods:is_expired(Goods)) of
                                        true ->
                                            TimeElapsed = TimeNow - lib_goods:get_time_on_last_save_valid_time(Goods),
                                            NewLeftValidTime = lib_goods:get_left_valid_time(Goods) - TimeElapsed,
                                            NewLeftValidTime2 = erlang:max(NewLeftValidTime, 0),  % 矫正
                                            Goods2 = lib_goods:set_left_valid_time(Goods, NewLeftValidTime2),
                                            Goods3 = lib_goods:set_time_on_last_save_valid_time(Goods2, TimeNow),

                                            lib_goods:db_save_goods(Goods3),
                                            clear_dirty_flag(PlayerId, Goods3);
                                        false ->
                                            skip
                                    end
                            end,
                            db_save_inventory_2(T, PlayerId, TimeNow)
                    end
            end
    end.


%% 从数据库获取这个道具信息
get_goods_info_from_db(GoodsId) ->
    case db:select_all(goods, ?SQL_QRY_GOODS_INFO, [{id,GoodsId}]) of
        InfoList_List when is_list(InfoList_List) ->
            GoodsList = [to_goods_record(InfoList) || InfoList <- InfoList_List],
            GoodsList;
        _Any ->
            []
    end.

%% 从数据库加载玩家的仓库物品
%% @return: [] | goods结构体列表
db_load_storage_goods(PlayerId) ->
    Inv = get_inventory(PlayerId),
    case db:select_all(goods, ?SQL_QRY_GOODS_INFO, [{player_id, PlayerId}, {location, ?LOC_STORAGE}]) of
        InfoList_List when is_list(InfoList_List) ->
            GoodsList = [to_goods_record(InfoList) || InfoList <- InfoList_List],
            GoodsIdList = [Goods#goods.id || Goods <- GoodsList],
            update_inventory_to_ets(Inv#inv{storage_goods = GoodsIdList}),

            F = fun(Goods) ->
                add_goods_to_ets(Goods)
            end,
            lists:foreach(F, GoodsList),
            GoodsList;
        _Any ->
            ?ERROR_MSG("[lib_inv] db_load_storage_goods() error!", []),
            ?ASSERT(false, _Any),
            []
    end.


del_goods_from_temp_bag(PlayerId) ->
    case get_inventory(PlayerId) of
        null -> skip;
        Inv ->
            case Inv#inv.temp_bag_goods =:= [] of
                true -> skip;
                false -> db:delete(PlayerId, goods, [{player_id, PlayerId}, {location, ?LOC_TEMP_BAG}])
            end
    end.
    

%% 标记为脏物品（脏：是指物品对象的数据在内存中改动了，但还没更新到DB）
%% @para: PlayerId => 玩家id
%%        Goods_Latest => 玩家的物品（goods结构体），注意：这里传进来的物品对象必须是当前最新的，否则会造成数据丢失
%% @return: 无用
mark_dirty_flag(PlayerId, Goods_Latest) ->
    ?ASSERT(lib_goods:get_owner_id(Goods_Latest) == PlayerId),
    Goods2 = lib_goods:set_dirty(Goods_Latest, true),
    update_goods_to_inv(PlayerId, Goods2).


%% 清除脏标记，注意：这里传进来的Goods必须是当前最新的Goods，否则会造成数据丢失
%% @return: 无用
clear_dirty_flag(PlayerId, GoodsId) when is_integer(GoodsId) ->
    case player:get_pid(PlayerId) of
        null -> skip;
        Pid -> gen_server:cast(Pid, {'clear_goods_dirty_flag', GoodsId})
    end;

clear_dirty_flag(PlayerId, Goods) ->
    ?ASSERT(Goods#goods.player_id == PlayerId),
    % 保险起见，如果是最近6个服务器时钟计数内标记为脏的物品，则不清除其脏标记，
    % 目的是为了避免玩家主逻辑的处理和定时存物品数据到DB之间的并发而可能引起的同步问题  -- huangjf
    Diff = svr_clock:get_tick_count() - lib_goods:get_time_on_mark_dirty(Goods),
    case Diff < 6 of  % 硬代码！
        true ->
            skip;
        false ->
            Goods2 = lib_goods:set_dirty(Goods, false),
            update_goods_to_inv(PlayerId, Goods2)
    end.


%% 废弃！
%% 标记为随机物品（把物品的is_random字段设置为true）
% mark_random_flag(PlayerId, Goods) ->
%     ?ASSERT(Goods#goods.player_id == PlayerId),
%     Goods2 = Goods#goods{is_random = true},
%     mark_random_flag(PlayerId, Goods2).



%% 使用物品（战斗外使用，并且是玩家为自己而使用）
%% @return: {ok,Goods} | {fail, Reason}
use_goods(PS, GoodsId_Or_Goods, UseCount) ->
    Goods = 
        case is_record(GoodsId_Or_Goods, goods) of
            true -> GoodsId_Or_Goods;
            false -> get_goods_from_ets(GoodsId_Or_Goods)
        end,

    EffectList = lib_goods:get_effects(Goods),
    EffCfg = 
        case EffectList =:= [] of
            true -> 
                ?WARNING_MSG("mod_inv:use_goods warning! GoodsNo:~p~n", lib_goods:get_no(Goods)),
                null;
            false -> lib_goods_eff:get_cfg_data(erlang:hd(EffectList))
        end,

    EffectName = 
        case EffCfg =:= null of
            true -> null;
            false -> EffCfg#goods_eff.name
        end,

    if
        EffectName =:= ?EN_GET_REWARD andalso UseCount > 1 ->
            use_goods_one_by_one(PS, Goods, UseCount);
        EffectName =:= ?EN_RAND_GET_GOODS andalso UseCount > 1 ->
            use_goods_one_by_one(PS, Goods, UseCount);
        EffectName =:= ?EN_ADD_BUFF andalso UseCount > 1 ->
            use_goods_one_by_one(PS, Goods, UseCount);
        EffectName =:= ?EN_GET_PARTNER andalso UseCount > 1 ->
            use_goods_one_by_one(PS, Goods, UseCount);
        EffectName =:= ?EN_RAND_GET_PAR andalso UseCount > 1 ->
            use_goods_one_by_one(PS, Goods, UseCount);

        true ->
            case check_use_goods(PS, GoodsId_Or_Goods, UseCount) of
                {ok, Goods1} ->
                    case is_record(GoodsId_Or_Goods, goods) andalso UseCount =:= 1 of
                        false -> skip;
                        true -> ply_tips:send_sys_tips(PS, {use_goods, [lib_goods:get_no(GoodsId_Or_Goods), lib_goods:get_quality(GoodsId_Or_Goods), 1,lib_goods:get_id(GoodsId_Or_Goods)]})
                    end,
                    do_use_goods(PS, Goods1, UseCount),
                    {ok, Goods1};
                {fail, Reason} ->
                    {fail, Reason}
            end
    end.

use_goods(PS, GoodsId_Or_Goods) ->
    use_goods(PS, GoodsId_Or_Goods, 1).

%% 判断玩家的背包是否满了
%% @return: true | false
is_bag_eq_full(PlayerId) ->
    Inv = get_inventory(PlayerId),
    List = get_goods_list(PlayerId, ?LOC_BAG_EQ),
    length(List) >= Inv#inv.bag_eq_capacity.


is_bag_usable_full(PlayerId) ->
    Inv = get_inventory(PlayerId),
    length(Inv#inv.usable_goods) >= Inv#inv.bag_usable_capacity.


is_bag_unusable_full(PlayerId) ->
    Inv = get_inventory(PlayerId),
    length(Inv#inv.unusable_goods) >= Inv#inv.bag_unusable_capacity.


%% 判断玩家的仓库是否满了
is_storage_full(PlayerId) ->
    Inv = get_inventory(PlayerId),
    List = get_goods_list(PlayerId, ?LOC_STORAGE),
    length(List) >= Inv#inv.storage_capacity.


%% 判断玩家背包(包括三个背包)中是否有足够数量的指定编号的物品
%% @return: true | false
has_enough_goods_in_bag(PlayerId, GoodsNo, Count) when Count >= 0 ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    Ret =
        case lists:keyfind(GoodsNo, 2, ?MONEY_TO_GOODS) of
            {MoneyType, _} ->
                player:check_need_price(player:get_PS(PlayerId), MoneyType, Count);
            _ ->
                false
        end,
    case Ret of
        ok ->
            true;
        _MsgCode ->
            case get_inventory(PlayerId) of
                null ->
%% 			false;
                    true; %% 这里返回true 适应删除离线玩家物品需求
                Inv ->
                    case lib_goods:get_tpl_data(GoodsNo) of
                        null ->
                            ?ERROR_MSG("mod_inv:has_enough_goods_in_bag(), GoodsNo:~p cant find!~n", [GoodsNo]),
                            false;
                        GoodsTpl ->
                            BagGoodsList =
                                case lib_goods:is_equip(GoodsTpl) of
                                    true ->
                                        get_goods_list_by_id_list(Inv#inv.eq_goods);
                                    false ->
                                        case lib_goods:is_can_use(GoodsTpl) of
                                            true -> get_goods_list_by_id_list(Inv#inv.usable_goods);
                                            false -> get_goods_list_by_id_list(Inv#inv.unusable_goods)
                                        end
                                end,
                            GoodsList = [Goods || Goods <- BagGoodsList, Goods#goods.no == GoodsNo],
                            TotalCount = lists:foldl(fun(X, Sum) -> X + Sum end, 0, [Goods#goods.count || Goods <- GoodsList]),
                            TotalCount >= Count
                    end
            end
    end;
has_enough_goods_in_bag(_PlayerId, _GoodsNo, _Count) ->
    false.


%% 判断玩家背包(包括三个背包)中是否有足够数量的指定编号和背包格子的物品
%% @return: true | false
has_enough_goods_in_bag(PlayerId, GoodsNo, Slot, Count) when is_integer(PlayerId) andalso Count >= 0 ->
    Ret =
        case lists:keyfind(GoodsNo, 2, ?MONEY_TO_GOODS) of
            {MoneyType, _} ->
                player:check_need_price(player:get_PS(PlayerId), MoneyType, Count);
            _ ->
                false
        end,
    case Ret of
        ok ->
            true;
        _MsgCode ->
            Inv = get_inventory(PlayerId),
            GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
            case lib_goods:get_tpl_data(GoodsNo) of
                null ->
                    ?ERROR_MSG("mod_inv:has_enough_goods_in_bag(), GoodsNo:~p cant find!~n", [GoodsNo]),
                    false;
                GoodsTpl ->
                    BagGoodsList =
                    case lib_goods:is_equip(GoodsTpl) of
                        true ->
                            get_goods_list_by_id_list(Inv#inv.eq_goods);
                        false ->
                            case lib_goods:is_can_use(GoodsTpl) of
                                true -> get_goods_list_by_id_list(Inv#inv.usable_goods);
                                false -> get_goods_list_by_id_list(Inv#inv.unusable_goods)
                            end
                    end,

                    GoodsList = [Goods || Goods <- BagGoodsList, Goods#goods.no == GoodsNo, Goods#goods.slot =:= Slot],
                    TotalCount = lists:foldl(fun(X, Sum) -> X + Sum end, 0, [Goods#goods.count || Goods <- GoodsList]),
                    TotalCount >= Count
            end

    end;
has_enough_goods_in_bag(PS, GoodsNo, BindState, Count) when Count >= 0 ->
    ?ASSERT(is_record(PS, player_status), PS),
    Ret =
        case lists:keyfind(GoodsNo, 2, ?MONEY_TO_GOODS) of
            {MoneyType, _} ->
                player:check_need_price(PS, MoneyType, Count);
            _ ->
                false
        end,
    case Ret of
        ok ->
            true;
        _MsgCode ->

            Inv = get_inventory(player:id(PS)),
            GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
            case lib_goods:get_tpl_data(GoodsNo) of
                null ->
                    ?ERROR_MSG("mod_inv:has_enough_goods_in_bag(), GoodsNo:~p cant find!~n", [GoodsNo]),
                    false;
                GoodsTpl ->
                    BagGoodsList =
                    case lib_goods:is_equip(GoodsTpl) of
                        true ->
                            get_goods_list_by_id_list(Inv#inv.eq_goods);
                        false ->
                            case lib_goods:is_can_use(GoodsTpl) of
                                true -> get_goods_list_by_id_list(Inv#inv.usable_goods);
                                false -> get_goods_list_by_id_list(Inv#inv.unusable_goods)
                            end
                    end,

                    GoodsList = [Goods || Goods <- BagGoodsList, Goods#goods.no == GoodsNo, Goods#goods.bind_state =:= BindState],
                    TotalCount = lists:foldl(fun(X, Sum) -> X + Sum end, 0, [Goods#goods.count || Goods <- GoodsList]),
                    TotalCount >= Count
            end

    end;
has_enough_goods_in_bag(_, _GoodsNo, _Slot, _Count) ->
    false.

get_goods_count_in_bag(PlayerId, GoodsNo, BindState) ->
    GoodsList = find_all_goods_in_bag_by_no(PlayerId, GoodsNo),
    lists:foldl(fun(X, Sum) -> X + Sum end, 0, [Goods#goods.count || Goods <- GoodsList, lib_goods:get_bind_state(Goods) =:= BindState]).





%% 判断玩家任务背包中是否有足够数量的指定编号的物品
% has_enough_goods_in_task_bag(PlayerId, GoodsNo, Count) ->
%     Inv = get_inventory(PlayerId),
%     TaskBagGoodsList = get_goods_list_by_id_list(Inv#inv.task_goods),
%     GoodsList = [Goods || Goods <- TaskBagGoodsList, Goods#goods.no == GoodsNo],
%     TotalCount = lists:foldl(fun(X, Sum) -> X + Sum end, 0, [Goods#goods.count || Goods <- GoodsList]),
%     TotalCount >= Count.


% %% 判断玩家任务背包中是否有足够数量的指定编号和任务背包格子的物品
% has_enough_goods_in_task_bag(PlayerId, GoodsNo, Slot, Count) ->
%     Inv = get_inventory(PlayerId),
%     TaskBagGoodsList = get_goods_list_by_id_list(Inv#inv.task_goods),
%     GoodsList = [Goods || Goods <- TaskBagGoodsList, Goods#goods.no == GoodsNo, Goods#goods.slot =:= Slot],
%     TotalCount = lists:foldl(fun(X, Sum) -> X + Sum end, 0, [Goods#goods.count || Goods <- GoodsList]),
%     TotalCount >= Count.


%% 判断玩家背包(包括三个背包)里是否有指定编号的物品
%% @return: true | false
has_goods_in_bag_by_no(PS, GoodsNo) when is_record(PS, player_status) andalso is_integer(GoodsNo) ->
    has_goods_in_bag_by_no(player:id(PS), GoodsNo);
has_goods_in_bag_by_no(PlayerId, GoodsNo) when is_integer(PlayerId) andalso is_integer(GoodsNo) ->
    case find_goods_by_no(PlayerId, GoodsNo, ?LOC_BAG_EQ) of
        null ->
            case find_goods_by_no(PlayerId, GoodsNo, ?LOC_BAG_USABLE) of
                null ->
                    case find_goods_by_no(PlayerId, GoodsNo, ?LOC_BAG_UNUSABLE) of
                        null -> false;
                        _Goods -> true
                    end;
                _Goods1 -> true
            end;
        _Goods2 -> true
    end;
has_goods_in_bag_by_no(PlayerId, [GoodsNo | T]) ->
    case has_goods_in_bag_by_no(PlayerId, GoodsNo) of
        false ->
            false;
        true ->
            has_goods_in_bag_by_no(PlayerId, T)
    end.


%% 判断玩家背包(包括三个背包)里是否有指定唯一id的物品
%% @return: true | false
has_goods_in_bag_by_id(PS, GoodsId) when is_record(PS, player_status) ->
    has_goods_in_bag_by_id(player:id(PS), GoodsId);

has_goods_in_bag_by_id(PlayerId, GoodsId) ->
    case find_goods_by_id(PlayerId, GoodsId, ?LOC_BAG_EQ) of
        null ->
            case find_goods_by_id(PlayerId, GoodsId, ?LOC_BAG_USABLE) of
                null ->
                    case find_goods_by_id(PlayerId, GoodsId, ?LOC_BAG_UNUSABLE) of
                        null -> false;
                        _Goods -> true
                    end;
                _Goods1 -> true
            end;
        _Goods2 -> true
    end.


%% 根据物品编号和所在地查找物品
%% @return: null | 所找到的第一个物品（goods结构体）
find_goods_by_no(PS, GoodsNo, Location) when is_record(PS, player_status) ->
    find_goods_by_no(player:get_id(PS), GoodsNo, Location);

find_goods_by_no(PlayerId, GoodsNo, Location) ->
    Inv = get_inventory(PlayerId),
    find_goods_by_no_from__(Inv, GoodsNo, Location).



%% 根据物品唯一id和所在地查找物品
%% @return: null | 所找到的物品（goods结构体）
find_goods_by_id(PS, GoodsId, Location) when is_record(PS, player_status) ->
    find_goods_by_id( player:get_id(PS), GoodsId, Location);
find_goods_by_id(PlayerId, GoodsId, Location) ->
    Inv = get_inventory(PlayerId),
    find_goods_by_id_from__(Inv, GoodsId, Location).



%% 计算添加指定编号和数量的新物品时，所需的空格子数（注意：上层函数需确保编号对应的物品是存在的！！）
%% 暂时没用
calc_add_new_goods_need_slots(GoodsNo, Count) ->
    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    ?ASSERT(GoodsTpl /= null, GoodsNo),
    MaxStack = lib_goods:get_max_stack(GoodsTpl),
    NeedSlots = Count div MaxStack,
    case Count rem MaxStack of
        0 ->
            NeedSlots;
        _ ->
            NeedSlots + 1
    end.



%% TODO: 计算添加多个指定数量的新物品时，所需的空格子数
%%calc_batch_add_new_goods_need_slots(XXXX) ->
%%    todo_here.



%% 判断玩家背包或仓库中是否有足够数量的空格子
%% @para: Location => ?LOC_BAG（表示背包） | ?LOC_STORAGE（表示仓库）
%% @return: true | false
has_enough_empty_slots(PlayerId, Location, Count) ->
    ?ASSERT(Location == ?LOC_BAG_EQ orelse Location == ?LOC_STORAGE orelse Location == ?LOC_BAG_USABLE orelse Location == ?LOC_BAG_UNUSABLE),
    calc_empty_slots(PlayerId, Location) >= Count.


%% 计算背包或仓库中的空格子数
calc_empty_slots(PlayerId, Location) ->
    Inv = get_inventory(PlayerId),

    case Inv#inv.storage_goods =:= null of
        true -> skip;
        false -> ?ASSERT(Inv#inv.storage_capacity >= length(Inv#inv.storage_goods), Inv)
    end,

    case Location of
        ?LOC_BAG_EQ ->
            List = get_goods_list(PlayerId, ?LOC_BAG_EQ),
            Inv#inv.bag_eq_capacity - length(List);
        ?LOC_STORAGE ->
            case Inv#inv.storage_goods =:= null of
                true -> Inv#inv.storage_capacity;
                false ->
                    Inv#inv.storage_capacity - length(Inv#inv.storage_goods)
            end;
        ?LOC_BAG_USABLE ->
            Inv#inv.bag_usable_capacity - length(Inv#inv.usable_goods);
        ?LOC_BAG_UNUSABLE ->
            Inv#inv.bag_unusable_capacity - length(Inv#inv.unusable_goods)
    end.


% 修复玩家背包的虚拟道具 将虚拟道具调整为货币
repair_virtual_goods(PlayerId, Goods, LogInfo) when is_record(Goods, goods) ->
    GoodsNo = lib_goods:get_no(Goods),
    if
        GoodsNo =:= ?VGOODS_GAMEMONEY ->
            player:add_gamemoney(PlayerId, lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_BIND_GAMEMONEY ->
            player:add_bind_gamemoney(PlayerId, lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_YB ->
            player:add_yuanbao(PlayerId, lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_BIND_YB ->
            player:add_bind_yuanbao(PlayerId, lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_EXP ->
            case player:get_PS(PlayerId) of
                null -> {ok, ?INVALID_NO};
                PS -> 
                    player:add_exp(PS, lib_goods:get_count(Goods), LogInfo),
                    lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
                    destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

                    {ok, ?INVALID_NO}
            end;
        GoodsNo =:= ?VGOODS_STR ->
            player:add_base_str(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_CON ->
            player:add_base_con(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_STA ->
            player:add_base_stam(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_SPI ->
            player:add_base_spi(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_AGI ->
            player:add_base_agi(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_LITERARY ->
            player:add_literary(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};

        GoodsNo =:= ?VGOODS_CONTRI ->
            % mod_guild_mgr:add_member_contri(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),
            player:add_guild_contri(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),

            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};

        % 金币
        GoodsNo =:= ?VGOODS_COPPER ->
            player:add_copper(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};

        % 侠义值
        GoodsNo =:= ?VGOODS_CHIVALROUS ->
            player:add_chivalrous(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};
		
		 % 经文
        GoodsNo =:= ?VGOODS_QUJING ->
            player:add_jingwen(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};

        % 秘境点数
        GoodsNo =:= ?VGOODS_MYSTERY ->
            player:add_mijing(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};

        % 幻境点数
        GoodsNo =:= ?VGOODS_MIRAGE ->
            player:add_huanjing(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};

        % 转生货币
        GoodsNo =:= ?VGOODS_REINCARNATION ->
            player:add_reincarnation(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};

        % 活跃值
        GoodsNo =:= ?VGOODS_VITALITY ->
            player:add_vitality(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),

            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};

        % 虚拟货币增加 筹码
        GoodsNo =:= ?VGOODS_CHIP ->
            player:add_chip(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};

        % 竞技场功勋
        GoodsNo =:= ?VGOODS_FEAT ->
            player:add_feat(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_PAR_EXP ->
            case player:get_PS(PlayerId) of
                null ->
                    ?ERROR_MSG("mod_inv:add_goods_to_bag error!PlayerId:~p~n", [PlayerId]),
                    {ok, ?INVALID_NO};
                PS ->
                    player:add_exp_to_main_par(PS, lib_goods:get_count(Goods), LogInfo),
                    player:add_exp_to_fighting_deputy_pars(PS, lib_goods:get_count(Goods), LogInfo),
                    lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
                    destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

                    {ok, ?INVALID_NO}
            end;
        GoodsNo =:= ?VGOODS_FREE_TALENT_POINTS ->
            player:add_free_talent_points(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),
            
            {ok, ?INVALID_NO};
		% 虚拟货币增加 积分
        GoodsNo =:= ?VGOODS_INTEGRAL ->
            player:add_integral(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), [?LOG_SKIP]),

            {ok, ?INVALID_NO};
        true ->
            {ok, ?INVALID_NO}
    end.
    
%% !!!!!! 注意：调用add_goods()接口前，需先判断玩家的背包是否还有空位 !!!!!!!!!!!!
%% 添加现有的物品到背包,如果是虚拟物品，则提取相应的属性，然后把虚拟物品删除
%% @para:   PlayerId => 玩家id
%%          Goods => 要添加的物品（goods结构体）必须是指定location 和 slot,如果没有指定slot必须是0
%% @return: {ok, slot}
add_goods_to_bag(PlayerId, Goods, LogInfo) when is_record(Goods, goods) ->
    GoodsNo = lib_goods:get_no(Goods),
    %拥有指定物品通知成就
    mod_achievement:notify_achi(have_goods, 1, [{no, GoodsNo}], player:get_PS(PlayerId)),
    % 虚拟道具类型在下面
    ?DEBUG_MSG("add_goods_to_bag = ~p,LogInfo=~p",[GoodsNo,LogInfo]),
    if
        GoodsNo =:= ?VGOODS_GAMEMONEY ->
            player:add_gamemoney(PlayerId, lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_BIND_GAMEMONEY ->
            player:add_bind_gamemoney(PlayerId, lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
		GoodsNo =:= ?VGOODS_INTEGRAL ->
            player:add_integral(PlayerId, lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_YB ->
            player:add_yuanbao(PlayerId, lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_BIND_YB ->
            player:add_bind_yuanbao(PlayerId, lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_EXP ->
            case player:get_PS(PlayerId) of
                null -> {ok, ?INVALID_NO};
                PS -> 
                    player:add_exp(PS, lib_goods:get_count(Goods), LogInfo),
                    lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
                    {ok, ?INVALID_NO}
            end;
        GoodsNo =:= ?VGOODS_STR ->
            player:add_base_str(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_CON ->
            player:add_base_con(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_STA ->
            player:add_base_stam(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_SPI ->
            player:add_base_spi(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_AGI ->
            player:add_base_agi(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_LITERARY ->
            player:add_literary(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};


        % 活跃值
        GoodsNo =:= ?VGOODS_VITALITY ->
            player:add_vitality(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};

        % 10000银币
        GoodsNo =:= ?VGOODS_GAMEMONEY_10000 ->
            player:add_gamemoney(PlayerId, lib_goods:get_count(Goods)*2000, LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};

        % 100金币
        GoodsNo =:= ?VGOODS_COPPER_100 ->
            player:add_copper(player:get_PS(PlayerId), lib_goods:get_count(Goods) * 20, LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};


        % 金币
        GoodsNo =:= ?VGOODS_COPPER ->
            player:add_copper(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};

        % 侠义值
        GoodsNo =:= ?VGOODS_CHIVALROUS ->
            player:add_chivalrous(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
		
		 % 经文
        GoodsNo =:= ?VGOODS_QUJING ->
            player:add_jingwen(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};

        % 秘境点数
        GoodsNo =:= ?VGOODS_MYSTERY ->
            player:add_mijing(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};

        % 幻境点数
        GoodsNo =:= ?VGOODS_MIRAGE ->
            player:add_huanjing(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};

        % 转生点数
        GoodsNo =:= ?VGOODS_REINCARNATION ->
            player:add_reincarnation(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};

        % 虚拟货币增加 筹码
        GoodsNo =:= ?VGOODS_CHIP ->
            player:add_chip(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};

        % 帮派贡献度
        GoodsNo =:= ?VGOODS_CONTRI ->
            % player:add_feat(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            player:add_guild_contri(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};

        % 竞技场功勋
        GoodsNo =:= ?VGOODS_FEAT ->
            player:add_feat(player:get_PS(PlayerId), lib_goods:get_count(Goods), LogInfo),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
        GoodsNo =:= ?VGOODS_PAR_EXP ->
            case player:get_PS(PlayerId) of
                null ->
                    ?ERROR_MSG("mod_inv:add_goods_to_bag error!PlayerId:~p~n", [PlayerId]),
                    {ok, ?INVALID_NO};
                PS ->
                    player:add_exp_to_main_par(PS, lib_goods:get_count(Goods), LogInfo),
                    player:add_exp_to_fighting_deputy_pars(PS, lib_goods:get_count(Goods), LogInfo),
                    lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
                    {ok, ?INVALID_NO}
            end;
        GoodsNo =:= ?VGOODS_FREE_TALENT_POINTS ->
            player:add_free_talent_points(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
            {ok, ?INVALID_NO};
        true ->
            Location = %% 容错
                case lib_goods:get_location(Goods) of
                    ?LOC_BAG_EQ -> ?LOC_BAG_EQ;
                    ?LOC_BAG_USABLE -> ?LOC_BAG_USABLE;
                    ?LOC_BAG_UNUSABLE -> ?LOC_BAG_UNUSABLE;
                    ?LOC_TEMP_BAG -> ?LOC_TEMP_BAG;
                    _Any -> lib_goods:decide_bag_location(Goods)
                end,

            % 在背包找第一个空位
            Slot =
                case lib_goods:get_slot(Goods) =:= 0 of
                    true -> find_first_empty_slot(PlayerId, Location);
                    false -> lib_goods:get_slot(Goods)
                end,
            Goods2 = Goods#goods{
                        player_id = PlayerId,
                        partner_id = 0,
                        location = Location,
                        slot = Slot,
                        is_dirty = true    % 勿忘：标记为脏
                        },

            add_goods__(PlayerId, Goods2, Location),
            % 通知客户端
            lib_inv:notify_cli_goods_added_to_bag(PlayerId, Goods2),
            {ok, Slot}
    end;
%% return ok
add_goods_to_bag(_PlayerId, [], _) ->
    ok;
add_goods_to_bag(PlayerId, [GoodsId | T], LogInfo) ->
    case find_goods_by_id_from_whole_inv(PlayerId, GoodsId) of
        null ->
            add_goods_to_bag(PlayerId, T, LogInfo);
        Goods ->
            Location = lib_goods:decide_bag_location(Goods),
            smart_add_goods(PlayerId, lib_goods:set_location(Goods, Location)),
            add_goods_to_bag(PlayerId, T, LogInfo)
    end.

get_goods_quality_by_id(PlayerId, GoodsId) ->
    case find_goods_by_id_from_whole_inv(PlayerId, GoodsId) of
        null -> ?QUALITY_INVALID;
        Goods -> lib_goods:get_quality(Goods)
    end.

get_goods_bind_state_by_id(GoodsId) ->
    case get_goods_from_ets(GoodsId) of
        null -> ?INVALID_NO;
        Goods -> lib_goods:get_bind_state(Goods)
    end.


%% 添加全新的物品到 玩家虚拟位置：如邮件等（新生成物品，并做相应的初始化，然后给予玩家）
%% @para: GoodsNo => 物品编号（注意：不是唯一id）
%%        Count => 要添加的物品数量
%%        ExtraInitInfo => 其他的初始化信息， 形如： [ {location, ?LOC_MAIL}, ... ]
%% @return: [] | [{GoodsId, Count}]
add_new_goods_to_player(_PlayerId, [], _ExtraInitInfo) ->
    [];
add_new_goods_to_player(PlayerId, [Goods | T], ExtraInitInfo) when is_record(Goods, goods) ->
    add_new_goods_to_player(PlayerId, [Goods | T], ExtraInitInfo, []);

add_new_goods_to_player(PlayerId, [{GoodsNo, Count} | T], ExtraInitInfo) ->
    add_new_goods_to_player(PlayerId, [{GoodsNo, Count} | T], ExtraInitInfo, []).

add_new_goods_to_player(_PlayerId, [], _ExtraInitInfo, RetList) ->
    RetList;

add_new_goods_to_player(PlayerId, [Goods | T], ExtraInitInfo, RetList) when is_record(Goods, goods) ->
    NewGoods = lib_goods:make_new_goods_2(Goods, ExtraInitInfo),
    Id = lib_goods:db_insert_new_goods(NewGoods),
    NewGoods1 = lib_goods:set_id(NewGoods, Id),
    NewGoods2 = lib_goods:set_owner_id(NewGoods1, PlayerId),

    %% 添加物品到背包或仓库或虚拟位置邮箱，包含更新最新inv到ets的操作
    case player:is_online(PlayerId) of
        true ->
            add_goods__(PlayerId, NewGoods2, lib_goods:get_location(NewGoods2));
        false ->
            case get_inventory(PlayerId) of
                null -> skip;
                _Any -> add_goods__(PlayerId, NewGoods2, lib_goods:get_location(NewGoods2))
            end
    end,
    add_new_goods_to_player(PlayerId, T, ExtraInitInfo, [{Id, lib_goods:get_count(NewGoods2)} | RetList]);

add_new_goods_to_player(PlayerId, [{GoodsNo, Count} | T], ExtraInitInfo, RetList) ->
    IdList = add_new_goods_to_player(PlayerId, GoodsNo, Count, ExtraInitInfo, []),
    add_new_goods_to_player(PlayerId, T, ExtraInitInfo, IdList ++ RetList).


add_new_goods_to_player(PlayerId, GoodsNo, Count, ExtraInitInfo, RetList) when Count > 0 ->
    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    MaxStack = lib_goods:get_max_stack(GoodsTpl),
    Count2 = erlang:min(MaxStack, Count),
    % 生成新物品
    Goods = lib_goods:make_new_goods(PlayerId, GoodsNo, Count2, ExtraInitInfo),

    % 插入新物品记录到数据库goods表
    Id = lib_goods:db_insert_new_goods(Goods),
    Goods2 = Goods#goods{id = Id},

    %% 添加物品到背包或仓库或虚拟位置邮箱，包含更新最新inv到ets的操作
    case player:is_online(PlayerId) of
        true ->
            add_goods__(PlayerId, Goods2, lib_goods:get_location(Goods2));
        false ->
            case get_inventory(PlayerId) of
                null -> skip;
                _Any -> add_goods__(PlayerId, Goods2, lib_goods:get_location(Goods2))
            end
    end,

    LeftCount = Count - MaxStack, % 剩余数量
    add_new_goods_to_player(PlayerId, GoodsNo, LeftCount, ExtraInitInfo, [{Id, Count2}] ++ RetList); % 递归

add_new_goods_to_player(_PlayerId, _GoodsNo, _Count, _Extra, RetList) ->
    RetList.

%% ！！注意： 调用此接口前， 需先判断玩家背包空间是否足够 ！！
%% 添加全新的物品到 背包 或 任务背包（新生成一个绑定的物品，然后给予玩家）
add_new_goods_to_bag(PlayerId, GoodsNo) when is_integer(GoodsNo) ->
    add_new_goods_to_bag(PlayerId, GoodsNo, 1, []);

%% smart_add_new_goods 函数内部调用此函数，已经记录了日志，故这里过滤掉
add_new_goods_to_bag(PlayerId, Goods) ->
    add_new_goods_to_bag(PlayerId, Goods, [?LOG_SKIP]).

%%  添加全新的已经生成相关属性的物品到背包
%% return {GoodsId, GoodsNo, Count}
add_new_goods_to_bag(PlayerId, Goods, LogInfo) ->
    % 插入新物品记录到数据库goods表
    GoodsNo = lib_goods:get_no(Goods),
    %拥有指定物品通知成就
    mod_achievement:notify_achi(have_goods, 1, [{no, GoodsNo}], player:get_PS(PlayerId)),
    if %% 说明：虚拟物品日志需要在上层函数记录
        GoodsNo =:= ?VGOODS_GAMEMONEY -> 
            player:add_gamemoney(PlayerId, lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
        GoodsNo =:= ?VGOODS_BIND_GAMEMONEY ->
            player:add_bind_gamemoney(PlayerId, lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
        GoodsNo =:= ?VGOODS_YB ->
            player:add_yuanbao(PlayerId, lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
        GoodsNo =:= ?VGOODS_BIND_YB ->
            player:add_bind_yuanbao(PlayerId, lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
        GoodsNo =:= ?VGOODS_EXP ->
            case player:get_PS(PlayerId) of
                null -> 
                    ?ERROR_MSG("mod_inv:add_new_goods_to_bag error!~n", []),
                    {?INVALID_NO, GoodsNo, 0};
                PS -> 
                    player:add_exp(PS, lib_goods:get_count(Goods), [?LOG_SKIP]),
                    {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)}
            end;
        GoodsNo =:= ?VGOODS_INTEGRAL ->
            player:add_integral(PlayerId, lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
        GoodsNo =:= ?VGOODS_STR ->
            player:add_base_str(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
        GoodsNo =:= ?VGOODS_CON ->
            player:add_base_con(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
        GoodsNo =:= ?VGOODS_STA ->
            player:add_base_stam(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
        GoodsNo =:= ?VGOODS_SPI ->
            player:add_base_spi(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
        GoodsNo =:= ?VGOODS_AGI ->
            player:add_base_agi(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
        GoodsNo =:= ?VGOODS_LITERARY ->
            player:add_literary(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};

        % 侠义值
        GoodsNo =:= ?VGOODS_CHIVALROUS ->
            player:add_chivalrous(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
		
		% 经文
        GoodsNo =:= ?VGOODS_QUJING ->
            player:add_jingwen(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};

        % 秘境点数
        GoodsNo =:= ?VGOODS_MYSTERY ->
            player:add_mijing(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};

        % 幻境点数
        GoodsNo =:= ?VGOODS_MIRAGE ->
            player:add_huanjing(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};

        % 转生点数
        GoodsNo =:= ?VGOODS_REINCARNATION ->
            player:add_reincarnation(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};

        % 竞技场功勋
        GoodsNo =:= ?VGOODS_FEAT ->
            player:add_feat(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};


        % 10000银币
        GoodsNo =:= ?VGOODS_GAMEMONEY_10000 ->
            player:add_gamemoney(PlayerId, lib_goods:get_count(Goods)*2000, [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};

        % 100金币
        GoodsNo =:= ?VGOODS_COPPER_100 ->
            player:add_copper(player:get_PS(PlayerId), lib_goods:get_count(Goods) * 20, [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};

        % 金币
        GoodsNo =:= ?VGOODS_COPPER ->
            player:add_copper(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};

        % 活跃值
        GoodsNo =:= ?VGOODS_VITALITY ->
            player:add_vitality(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};

        % 金币
        GoodsNo =:= ?VGOODS_CHIP ->
            % player:set_chip(player:get_PS(PlayerId), player:get_chip(player:get_PS(PlayerId)) + lib_goods:get_count(Goods)),
            player:add_chip(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};

        % 帮派贡献度
        GoodsNo =:= ?VGOODS_CONTRI ->
            % mod_guild_mgr:add_member_contri(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),
            player:add_guild_contri(player:get_PS(PlayerId), lib_goods:get_count(Goods), [?LOG_SKIP]),

            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
        GoodsNo =:= ?VGOODS_PAR_EXP ->
            case player:get_PS(PlayerId) of
                null ->
                    ?ERROR_MSG("mod_inv:add_new_goods_to_bag error!PlayerId:~p~n", [PlayerId]),
                    {?INVALID_NO, GoodsNo, 0};
                PS ->
                    player:add_exp_to_main_par(PS, lib_goods:get_count(Goods), [?LOG_SKIP]),
                    player:add_exp_to_fighting_deputy_pars(PS, lib_goods:get_count(Goods), [?LOG_SKIP]),
                    {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)}
            end;
        GoodsNo =:= ?VGOODS_FREE_TALENT_POINTS ->
            player:add_free_talent_points(player:get_PS(PlayerId), lib_goods:get_count(Goods)),
            {?INVALID_NO, GoodsNo, lib_goods:get_count(Goods)};
        true ->
            Id = lib_goods:db_insert_new_goods(Goods),
            Goods2 = Goods#goods{id = Id},

            Location = lib_goods:get_location(Goods2),

            %% 添加物品到背包或仓库，包含更新最新inv到ets的操作
            add_goods__(PlayerId, Goods2, Location),

            % 通知客户端
            ?Ifc (Location == ?LOC_BAG_EQ orelse Location == ?LOC_BAG_USABLE orelse Location == ?LOC_BAG_UNUSABLE orelse Location == ?LOC_TEMP_BAG)
                lib_inv:notify_cli_goods_added_to_bag(PlayerId, Goods2)
            ?End,

            GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
            case lib_goods:get_statistics_state(GoodsTpl) of
                0 -> skip;
                1 -> lib_log:statis_produce_goods(PlayerId, Id, GoodsNo, lib_goods:get_count(Goods2), LogInfo)
            end,

            ply_tips:notify_gain_item(PlayerId, lib_goods:get_type(Goods2), lib_goods:get_id(Goods2), lib_goods:get_no(Goods2), lib_goods:get_count(Goods2)),
            {lib_goods:get_id(Goods2), lib_goods:get_no(Goods2), lib_goods:get_count(Goods2)}
    end.


%% ！！注意： 调用此接口前， 需先判断玩家背包空间是否足够 ！！
%% 添加全新的物品到 背包 或 任务背包（新生成物品，并做相应的初始化，然后给予玩家）
%% @para: GoodsNo => 物品编号（注意：不是唯一id）
%%        Count => 要添加的物品数量
%%        ExtraInitInfo => 其他的初始化信息， 形如： [ {slot, Slot}, ... ]
%% @return: ok
add_new_goods_to_bag(PlayerId, GoodsNo, Count, ExtraInitInfo) when Count > 0 ->
    %拥有指定物品通知成就
    mod_achievement:notify_achi(have_goods, Count, [{no, GoodsNo}], player:get_PS(PlayerId)),
    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    MaxStack = lib_goods:get_max_stack(GoodsTpl),

    Count2 = erlang:min(MaxStack, Count),

    % 生成新物品
    NewGoods = lib_goods:make_new_goods(PlayerId, GoodsNo, Count2, ExtraInitInfo),

    % 如果还没有定格子,给新物品找第一个空格子
    NewGoods2 =
    case lib_goods:get_slot(NewGoods) >= 1 of
        true ->
            NewGoods;
        false ->
            Slot = find_first_empty_slot(PlayerId, lib_goods:get_location(NewGoods)),
            lib_goods:set_slot(NewGoods, Slot)
    end,

    NewGoods3 = case lib_goods:is_timing_goods(NewGoods2)
                andalso lib_goods:get_when_begin_timekeeping(GoodsTpl) == ?WBTKP_ON_GOT of
                    false ->
                        NewGoods2;
                    true ->
                        lib_goods:timekeeping_start(NewGoods2)  % 开始计时
                end,
    ?ASSERT(is_record(NewGoods3, goods)),

    add_new_goods_to_bag(PlayerId, NewGoods3),

    LeftCount = Count - MaxStack, % 剩余数量
    add_new_goods_to_bag(PlayerId, GoodsNo, LeftCount, ExtraInitInfo); % 递归

add_new_goods_to_bag(_PlayerId, _GoodsNo, _Count, _Extra) ->
    ok.

%% 添加道具给玩家背包通过打造
add_new_goods_to_bag_by_build(PlayerId, GoodsNo, Count, ExtraInitInfo) when Count > 0 ->
    mod_achievement:notify_achi(have_goods, Count, [{no, GoodsNo}], player:get_PS(PlayerId)),
    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    MaxStack = lib_goods:get_max_stack(GoodsTpl),
    Count2 = erlang:min(MaxStack, Count),
      % 生成新物品
    NewGoods = lib_goods:make_new_goods(PlayerId, GoodsNo, Count2, ExtraInitInfo),

    % 如果还没有定格子,给新物品找第一个空格子
    NewGoods2 =
    case lib_goods:get_slot(NewGoods) >= 1 of
        true ->
            NewGoods;
        false ->
            Slot = find_first_empty_slot(PlayerId, lib_goods:get_location(NewGoods)),
            lib_goods:set_slot(NewGoods, Slot)
    end,

    NewGoods3 = case lib_goods:is_timing_goods(NewGoods2)
                andalso lib_goods:get_when_begin_timekeeping(GoodsTpl) == ?WBTKP_ON_GOT of
                    false ->
                        NewGoods2;
                    true ->
                        lib_goods:timekeeping_start(NewGoods2)  % 开始计时
                end,
    ?ASSERT(is_record(NewGoods3, goods)),

    NewGoods4 = lib_goods:set_equip_effect(NewGoods3,NewGoods3#goods.addi_equip_eff),
    PS = player:get_PS(PlayerId),
    NewGoods5 = lib_goods:set_maker_name(NewGoods4, player:get_name(PS)), 

    mark_dirty_flag(PlayerId, NewGoods5),
    % lib_inv:notify_cli_goods_info_change(PlayerId, Goods5)
    {GoodsId,_,_ } = add_new_goods_to_bag(PlayerId, NewGoods5),   

    GoodsId.

%% 添加道具给玩家背包通过帮派技能
add_new_goods_to_bag_by_guild_use(PlayerId, GoodsNo, Count,QualityLv, ExtraInitInfo) when Count > 0 ->
    mod_achievement:notify_achi(have_goods, Count, [{no, GoodsNo}], player:get_PS(PlayerId)),
    ?DEBUG_MSG("PlayerId=~p, GoodsNo=~p, Count=~p,QualityLv=~p",[PlayerId, GoodsNo, Count,QualityLv]),
    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    MaxStack = lib_goods:get_max_stack(GoodsTpl),
    Count2 = erlang:min(MaxStack, Count),
      % 生成新物品
    NewGoods1 = lib_goods:make_new_goods(PlayerId, GoodsNo, Count2, ExtraInitInfo),
    NewGoods = lib_goods:set_quality_lv(NewGoods1,QualityLv),

    % 如果还没有定格子,给新物品找第一个空格子
    NewGoods2 =
    case lib_goods:get_slot(NewGoods) >= 1 of
        true ->
            NewGoods;
        false ->
            Slot = find_first_empty_slot(PlayerId, lib_goods:get_location(NewGoods)),
            lib_goods:set_slot(NewGoods, Slot)
    end,

    PS = player:get_PS(PlayerId),

    NewGoods3 = case lib_goods:is_timing_goods(NewGoods2)
                andalso lib_goods:get_when_begin_timekeeping(GoodsTpl) == ?WBTKP_ON_GOT of
                    false ->
                        NewGoods2;
                    true ->
                        lib_goods:timekeeping_start(NewGoods2)  % 开始计时
                end,

    NewGoods4 = lib_goods:set_equip_effect(NewGoods3,NewGoods3#goods.addi_equip_eff),

    NewGoods5 = lib_goods:set_maker_name(NewGoods4, player:get_name(PS)), 

    % lib_inv:notify_cli_goods_info_change(PlayerId, Goods5)
    {GoodsId,_,_ } = add_new_goods_to_bag(PlayerId, NewGoods5),   

    GoodsId.


%% 智能添加多个物品到背包或任务(智能的意思是会自动叠加)
%% @para:
%%  GoodsList: [ {GoodsNo1, Count1}, {GoodsNo2, Count2} ... ]
%% return: {ok, [{GoodsId, GoodsNo, GoodsCount}]}  |  {fail, Reason}
batch_smart_add_new_goods(PlayerId, GoodsList) ->
    batch_smart_add_new_goods(PlayerId, GoodsList, [], []).


batch_smart_add_new_goods(PlayerId, GoodsList, LogInfo) ->
    batch_smart_add_new_goods(PlayerId, GoodsList, [], LogInfo).

%% 智能添加多个物品到背包或任务(智能的意思是会自动叠加)，附带物品的额外的初始化信息
%% @para:
%%     GoodsList => [ {GoodsNo1, Count1}, {GoodsNo2, Count2} ... ]
%%     ExtraInitInfoList => 额外的初始化信息列表，用于指定物品品质、绑定状态等，格式如：[ {Slot, slot}, {quality, 5} ... ]
%% return: {ok, [{GoodsId, GoodsNo, GoodsCount}]}  |  {fail, Reason}
batch_smart_add_new_goods(PlayerId, GoodsList, ExtraInitInfoList, LogInfo) ->
    % case check_batch_add_goods(PlayerId, GoodsList) of
        % ok ->
            GoodsList1 = arrange_goods_list(GoodsList),
    case player:get_pid(PlayerId) of
        Pid when is_pid(Pid) ->
            catch gen_server:cast(Pid, {add_goods, [No|| {No,_}<-GoodsList]});
        _ ->
            skip
    end,

  %%自动获得物品wjc
  F = fun(X,Acc) ->
    case X of
      {FunGoodsNo,FunCount,Exr_} ->
        GoodsTpl = data_goods:get(FunGoodsNo),
        case GoodsTpl#goods_tpl.type == 13 of
          true ->
%%            lib_reward:give_reward_to_player(player:get_PS(PlayerId), GoodsTpl#goods_tpl.subtype, ["Auto"], FunCount),
%%            Rewardpkg = data_reward_pkg:get(GoodsTpl#goods_tpl.subtype),
%%            PkgGoods    = Rewardpkg#reward_pkg.goods_list,
%%            Fun2 = fun({_Q, RewardNo, Count, _, _ },Acc4) ->
%%              [{RewardNo,Count}|Acc4]
%%                   end,
%%            PkgGoodsList = lists:foldl(Fun2, [], PkgGoods),
%%            mod_inv:batch_smart_add_new_goods(PlayerId, PkgGoodsList, [{bind_state, 1}], ["lib_luck", "get_week_reward"]),
            ets:insert(?ETS_ACHIEVEMENT_TMP_CACHE,{{tmp_pro,PlayerId},util:unixtime()}),
              lib_goods_eff:apply_effects(for_player, player:get_PS(PlayerId), GoodsTpl, FunCount),
            lists:delete({FunGoodsNo,FunCount,Exr_},Acc);
          false ->
            Acc
        end;
      {FunGoodsNo,FunCount} ->
        GoodsTpl = data_goods:get(FunGoodsNo),  %%lib_goods_eff:apply_effects(for_player, player:get_PS(1000100000000609),  data_goods:get(204101), 1),
        case GoodsTpl#goods_tpl.type == 13 of
          true ->
            ets:insert(?ETS_ACHIEVEMENT_TMP_CACHE,{{tmp_pro,PlayerId},util:unixtime()}),
            lib_goods_eff:apply_effects(for_player, player:get_PS(PlayerId), GoodsTpl, FunCount),
            lists:delete({FunGoodsNo,FunCount},Acc);
          false ->
            Acc
        end
    end
    end,
    GoodsList2 = lists:foldl(F,GoodsList1,GoodsList1),
            NullBagEQSlotL = get_empty_slot_list(PlayerId, ?LOC_BAG_EQ),
            NullBagUSSlotL = get_empty_slot_list(PlayerId, ?LOC_BAG_USABLE),
            NullBagUNUSSlotL = get_empty_slot_list(PlayerId, ?LOC_BAG_UNUSABLE),
            case lists:foldl(fun smart_add_new_goods/2, {PlayerId, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, ExtraInitInfoList, LogInfo, []}, GoodsList2) of
                {_Id, _LeftBagEQSlotL, _LeftBagUSSlotL, _LeftBagUNUSSlotL, _Extra, _LogInfo, RetGoods} ->
                    {ok, RetGoods};
                _Any ->
                    ?ERROR_MSG("batch_smart_add_new_goods() failed:~p", [_Any]),
                    {fail, ?PM_UNKNOWN_ERR}
            end.
        % {fail, Reason} ->
            % {fail, Reason}
    % end.

%% ！！！注意：调用此接口前要确保玩家拥有对应的物品！！！！
%% 从物品栏销毁物品（会从数据库中删除该物品），
%% 注意： 目前只能从背包或仓库中直接销毁，不能从装备栏直接销毁
%% @para: Goods => goods结构体
%% @return: 如果完成销毁则返回ok，如果是部分销毁则返回剩余的物品{ok, LeftGoods}
destroy_goods(PlayerId, Goods, Count) ->
    destroy_goods(PlayerId, Goods, Count, []).

destroy_goods(PlayerId, Goods, Count, LogInfo) ->
    ?ASSERT(Goods#goods.player_id == PlayerId),
    Location = lib_goods:get_location(Goods),
    ?ASSERT(is_location_expcept_on_body_valid(Location), Location),

    GoodsId = lib_goods:get_id(Goods),
    PS = player:get_PS(PlayerId),
    %% 关联其他系统
    case PS =:= null of
        true -> skip;
        false -> lib_task:notify_task_refresh_all_if_change(PS)
    end,

    case lib_goods:get_tpl_data(lib_goods:get_no(Goods)) of
        null -> skip;
        GoodsTpl ->
            case lib_goods:get_statistics_state(GoodsTpl) of
                0 -> skip;
                1 -> lib_log:statis_reclaim_goods(PlayerId, GoodsId, lib_goods:get_no(Goods), Count, LogInfo)
            end,
            case lib_goods:is_equip(GoodsTpl) of
                false -> skip;
                true ->
                    case PS =:= null of
                        true -> skip;
                        false -> lib_log:statis_equip_dty(PlayerId, player:get_lv(PS), GoodsId)
                    end
            end
    end,

    case lib_goods:get_count(Goods) =:= Count of
        true ->
            % 从物品栏中删除
            remove_goods__(PlayerId, Goods, Location),
            %% 从物品ets表删除
            del_goods_from_ets_by_goods_id(GoodsId),
            % 从数据库中删除
            lib_goods:db_delete_goods(PlayerId, GoodsId),
            ?TRACE("del GoodsId:~p, GoodsNo:~p, Count:~p~n", [GoodsId, lib_goods:get_no(Goods),Count]),
            ok;
        false ->
            LeftCount = erlang:max(lib_goods:get_count(Goods) - Count, 0),
            case LeftCount > 0 of
                false ->
                    ?ASSERT(false),
                    ?ERROR_MSG("mod_inv:destroy_goods error! LeftCount:~p~n", [LeftCount]),
                    % 从物品栏中删除
                    remove_goods__(PlayerId, Goods, Location),
                    %% 从物品ets表删除
                    del_goods_from_ets_by_goods_id(GoodsId),
                    lib_goods:db_delete_goods(PlayerId, GoodsId),
                    ok;
                true ->
                    Goods1 = lib_goods:set_count(Goods, LeftCount),
                    mark_dirty_flag(PlayerId, Goods1),
                    {ok, Goods1}
            end
    end.


%% 同上，只是多了通知客户端的处理(WNC: with notify client)
destroy_goods_WNC(PlayerId, GoodsId) when is_integer(GoodsId) ->
    destroy_goods_WNC(PlayerId, GoodsId, []);

%% 根据物品编号和要删除的物品个数删除物品
%% @doc 已兼容扣除道具编号对应的货币
%% destroy_goods_WNC(PS_or_PlayerId, GoodsList) -> true|false.
%% GoodsList ：[{GoodsNo, Count}|{GoodsNo, Slot, Count}|{GoodsNo, Count, BindState}]
%%
%% @doc 注意GoodsList= [{GoodsNo, Slot, Count}]|[{GoodsNo, Count, BindState}]是通过PS_or_PlayerId的参数类型区分的
%%
destroy_goods_WNC(PS, [{GoodsNo, Count} | T]) when is_record(PS, player_status) ->
    destroy_goods_WNC(player:id(PS), [{GoodsNo, Count} | T]);
destroy_goods_WNC(PlayerId, [{GoodsNo, Count} | T]) ->
    destroy_goods_WNC(PlayerId, [{GoodsNo, Count} | T], []);

destroy_goods_WNC(PlayerId, [{GoodsNo, Slot, Count} | T]) when is_integer(PlayerId) ->
    destroy_goods_WNC(PlayerId, [{GoodsNo, Slot, Count} | T], []);

destroy_goods_WNC(PS, [{GoodsNo, Count, BindState} | T]) ->
    destroy_goods_WNC(PS, [{GoodsNo, Count, BindState} | T], []).


destroy_goods_WNC(PlayerId, GoodsId, LogInfo) when is_integer(GoodsId) ->
    case find_goods_by_id_from_whole_inv(PlayerId, GoodsId) of
        null ->
            false;
        Goods ->
            destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), LogInfo)
    end;
%% return true | false
destroy_goods_WNC(_PlayerId, [], _LogInfo) ->
    true;
destroy_goods_WNC(PS, [{GoodsNo, Count} | T], LogInfo) when is_record(PS, player_status) ->
    destroy_goods_WNC(player:id(PS), [{GoodsNo, Count} | T], LogInfo);

destroy_goods_WNC(PlayerId, [{GoodsNo, Count} | T], LogInfo) ->
    GoodsList = arrange_goods_list([{GoodsNo, Count} | T]),
    case check_batch_destroy_goods(PlayerId, GoodsList) of
        {fail, _Reason} ->
            ?TRACE("check_batch_destroy_goods fail,Reason:~p~n", [_Reason]),
            false;
        ok ->
            F = fun({No, Cnt}) ->
                case Cnt =< 0 of
                    true -> skip;
                    false ->
                        case lists:keyfind(No, 2, ?MONEY_TO_GOODS) of
                            {MoneyType, _} ->
                                player:cost_money(player:get_PS(PlayerId), MoneyType, Cnt, ["mod_inv", "destroy_goods_WNC"]);
                            _ ->
                                GoodsTpl = lib_goods:get_tpl_data(No),
                                Location = lib_goods:decide_bag_location(GoodsTpl),
                                case find_goods_by_no_from_inv(PlayerId, No, Location) of
                                    [] ->
                                        ?ASSERT(false),
                                        ?ERROR_MSG("mod_inv:destroy_goods_WNC error!~n", []);
                                    GoodsL ->
                                        TotalCount = lists:foldl(fun(X, Sum) -> X + Sum end, 0, [Goods#goods.count || Goods <- GoodsL]),
                                        case TotalCount < Cnt of
                                            true ->
                                                ?ASSERT(false,[TotalCount,Cnt,GoodsNo]),
                                                ?ERROR_MSG("mod_inv:destroy_goods_WNC error!~n", []);
                                            false ->
                                                SortedGoodsL = lib_inv:sort_goods(GoodsL, sort_by_bind_state),
                                                % SortedGoodsL1 = lists:reverse(SortedGoodsL),
                                                [Goods | _T] = SortedGoodsL,
                                                case lib_goods:get_count(Goods) < Cnt of
                                                    true ->
                                                        destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), LogInfo),
                                                        destroy_goods_WNC(PlayerId, [{No, Cnt - lib_goods:get_count(Goods)}], LogInfo);
                                                    false ->
                                                        destroy_goods_WNC(PlayerId, Goods, Cnt, LogInfo)
                                                end
                                        end
                                end
                        end
                end

                end,
            lists:foreach(F, GoodsList),
            [mod_achievement:notify_achi(use_goods, NewCount, [{no, No}], player:get_PS(PlayerId)) || {No, NewCount} <- GoodsList],

            true
    end;
%%    end;



%% 目前下面这个函数还没用到，如果以后有这个需求，需要调整物品列表，保证列表里编号和格子一样的元组仅有一个，否则会有bug
destroy_goods_WNC(PlayerId, [{GoodsNo, Slot, Count} | T], LogInfo) when is_integer(PlayerId) ->
    GoodsList = [{GoodsNo, Slot, Count}] ++ T,
    case check_batch_destroy_goods(PlayerId, GoodsList) of
        {fail, _Reason} -> false;
        ok ->
            F = fun({No, GoodsSlot, Cnt}) ->

                case Cnt =< 0 of
                    true -> skip;
                    false ->
                        case lists:keyfind(No, 2, ?MONEY_TO_GOODS) of
                            {MoneyType, _} ->
                                player:cost_money(player:get_PS(PlayerId), MoneyType, Cnt, ["mod_inv", "destroy_goods_WNC"]);
                            _ ->
                                GoodsTpl = lib_goods:get_tpl_data(No),
                                Location = lib_goods:decide_bag_location(GoodsTpl),

                                case find_goods_by_no_from_inv(PlayerId, No, Location) of
                                    [] ->
                                        ?ASSERT(false);
                                    GoodsL ->
                                        Goods =
                                            case lists:keyfind(GoodsSlot, #goods.slot, GoodsL) of
                                                false -> null;
                                                GoodsInfo -> GoodsInfo
                                            end,
                                        ?ASSERT(Goods /= null),
                                        destroy_goods_WNC(PlayerId, Goods, Cnt, LogInfo)
                                end
                        end
                end
            end,
            lists:foreach(F, GoodsList),
            true
    end;


destroy_goods_WNC(PS, [{GoodsNo, Count, BindState} | T], LogInfo) ->
    GoodsList = arrange_goods_list([{GoodsNo, Count, BindState} | T]),
    PlayerId = player:id(PS),
    case check_batch_destroy_goods(PS, GoodsList) of
        {fail, _Reason} ->
            ?TRACE("check_batch_destroy_goods fail,Reason:~p~n", [_Reason]),
            false;
        ok ->
            F = fun({No, Cnt, _}) ->
                case Cnt =< 0 of
                    true -> skip;
                    false ->
                        case lists:keyfind(No, 2, ?MONEY_TO_GOODS) of
                            {MoneyType, _} ->
                                player:cost_money(player:get_PS(PlayerId), MoneyType, Cnt, ["mod_inv", "destroy_goods_WNC"]);
                            _ ->
                                GoodsTpl = lib_goods:get_tpl_data(No),
                                Location = lib_goods:decide_bag_location(GoodsTpl),

                                case find_goods_by_no_from_inv(PlayerId, No, Location) of
                                    [] ->
                                        ?ASSERT(false),
                                        ?ERROR_MSG("mod_inv:destroy_goods_WNC error!PlayerId:~p~n", [PlayerId]);
                                    GoodsL ->
                                        GoodsL1 = [X || X <- GoodsL, X#goods.bind_state =:= BindState],
                                        TotalCount = lists:foldl(fun(X, Sum) -> X + Sum end, 0, [Goods#goods.count || Goods <- GoodsL1]),
                                        case TotalCount < Cnt of
                                            true ->
                                                ?ASSERT(false),
                                                ?ERROR_MSG("mod_inv:destroy_goods_WNC error!{TotalCount, Cnt}:~w~n", [{TotalCount, Cnt}]);
                                            false ->
                                                SortedGoodsL = lib_inv:sort_goods(GoodsL1, sort_by_count),
                                                % SortedGoodsL1 = lists:reverse(SortedGoodsL),
                                                [Goods | _T] = SortedGoodsL,
                                                case lib_goods:get_count(Goods) < Cnt of
                                                    true ->
                                                        destroy_goods_WNC(PlayerId, Goods, lib_goods:get_count(Goods), LogInfo),
                                                        destroy_goods_WNC(PS, [{No, Cnt - lib_goods:get_count(Goods),BindState}], LogInfo);
                                                    false ->
                                                        destroy_goods_WNC(PlayerId, Goods, Cnt, LogInfo)
                                                end
                                        end
                                end
                        end
                end
            end,
            lists:foreach(F, GoodsList),
            [mod_achievement:notify_achi(use_goods, NewCount, [{no, No}], player:get_PS(PlayerId)) || {No, NewCount, _BindState} <- GoodsList],
            true
    end;



% 根据物品编号和要删除的物品个数删除物品
%% @return: 如果完全销毁则返回ok，如果是部分销毁则返回剩余的物品{ok, LeftGoods} | {fail, Reason}
destroy_goods_WNC(PlayerId, Goods, Count) when is_record(Goods, goods) ->
    case Count < 0 of
        true -> {fail, ?PM_PARA_ERROR};
        false -> destroy_goods_WNC(PlayerId, Goods, Count, [])
    end.

destroy_goods_WNC(PlayerId, Goods, Count, LogInfo) when is_record(Goods, goods) ->
    case Count < 0 of
        true -> {fail, ?PM_PARA_ERROR};
        false ->
            case destroy_goods(PlayerId, Goods, Count, LogInfo) of
                ok ->
                    lib_inv:notify_cli_goods_destroyed(PlayerId, lib_goods:get_id(Goods), lib_goods:get_location(Goods)),
                    ok;
                {ok, LeftGoods} ->
                    lib_inv:notify_cli_goods_info_change(PlayerId, LeftGoods),
                    {ok, LeftGoods}
            end
    end.


%% 删除离线玩家的物品
%% return true | false
destroy_goods_offline(PlayerId, [{GoodsNo, Count} | T], LogInfo) ->
    GoodsList = arrange_goods_list([{GoodsNo, Count} | T]),
    destroy_goods_WNC(PlayerId, GoodsList, LogInfo),

    GoodsObjList = db_load_bag_goods(PlayerId),
    F = fun({No, Cnt}, {Sum, Acc}) ->
        GoodsL = [Goods || Goods <- GoodsObjList, lib_goods:get_no(Goods) =:= No],
        case lists:foldl(fun(G, S) -> lib_goods:get_count(G) + S end, 0, GoodsL) >= Cnt of
            true -> {Sum + 1, [{No, GoodsL} | Acc]};
            false -> {Sum, Acc}
        end
    end,
    {Total, GoodsObjList1} = lists:foldl(F, {0, []}, GoodsList),
    case Total < length(GoodsList) of
        true -> false;
        false ->
            destroy_goods_offline(GoodsObjList1, GoodsList),
            true
    end.

destroy_goods_offline([], _) ->
    void;
destroy_goods_offline(_, []) ->
    void;
destroy_goods_offline(GoodsObjList, [{GoodsNo, Count} | T]) ->
    case lists:keyfind(GoodsNo, 1, GoodsObjList) of
        false ->
            destroy_goods_offline(GoodsObjList, T);
        {_, GoodsL} ->
            destroy_goods_offline__(GoodsL, Count),
            destroy_goods_offline(GoodsObjList, T)
    end.

destroy_goods_offline__(_, 0) ->
    void;
destroy_goods_offline__([], _) ->
    void;
destroy_goods_offline__([Goods | T], Count) ->
    Count1 = lib_goods:get_count(Goods),
    if
        Count =:= Count1 ->
            lib_goods:db_delete_goods(lib_goods:get_owner_id(Goods), lib_goods:get_id(Goods));
        Count > Count1 ->
            lib_goods:db_delete_goods(lib_goods:get_owner_id(Goods), lib_goods:get_id(Goods)),
            destroy_goods_offline__(T, Count - Count1);
        true ->
            lib_goods:db_save_goods(lib_goods:set_count(Goods, Count1 - Count))
    end.
    

%% 根据物品唯一和要删除的物品个数删除物品
%% GoodsList ：[{GoodsId, Count}, ...]
%% return true | false
destroy_goods_by_id_WNC(PlayerId, [{GoodsId, Count} | T]) ->
    destroy_goods_by_id_WNC(PlayerId, [{GoodsId, Count} | T], []).

destroy_goods_by_id_WNC(PlayerId, [{GoodsId, Count} | T], LogInfo) ->
    GoodsList = [{GoodsId, Count}] ++ T,
    case check_batch_destroy_goods_by_id(PlayerId, GoodsList) of
        {fail, _Reason} ->
            ?ERROR_MSG("check_batch_destroy_goods fail,Reason:~p~n", [_Reason]),
            false;
        ok ->
            F = fun({Id, Cnt}) ->
                case find_goods_by_id_from_whole_inv(PlayerId, Id) of
                    null ->
                        ?ASSERT(false, Id);
                    Goods ->
                        destroy_goods_WNC(PlayerId, Goods, Cnt, LogInfo)
                end
            end,
            lists:foreach(F, GoodsList),
            true
    end.


%% 根据物品唯一id删除物品
%% GoodsList ：[GoodsId]
%% return true | false
destroy_goods_by_id(_PlayerId, []) ->
    destroy_goods_by_id(_PlayerId, [], []);

destroy_goods_by_id(PlayerId, [GoodsId | T]) ->
    destroy_goods_by_id(PlayerId, [GoodsId | T], []).

destroy_goods_by_id(_PlayerId, [], _LogInfo) ->
    true;

destroy_goods_by_id(PlayerId, [GoodsId | T], LogInfo) ->
    GoodsList = [GoodsId] ++ T,
    case check_batch_destroy_goods_by_id(PlayerId, GoodsList) of
        {fail, _Reason} ->
            ?ERROR_MSG("check_batch_destroy_goods fail, PlayerId:~p, Reason:~p~n", [PlayerId, _Reason]),
            false;
        ok ->
            case find_goods_by_id_from_whole_inv(PlayerId, GoodsId) of
                null ->
                    destroy_goods_by_id(PlayerId, T, LogInfo);
                Goods ->
                    destroy_goods(PlayerId, Goods, lib_goods:get_count(Goods), LogInfo),
                    destroy_goods_by_id(PlayerId, T, LogInfo)
            end
    end.

%% GoodsList :  [Goods | T]
destroy_goods_from_temp_bag(PlayerId, GoodsList) ->
    F = fun(Goods, Acc) ->
        GoodsId = lib_goods:get_id(Goods),
        del_goods_from_ets_by_goods_id(GoodsId),
        lib_goods:db_delete_goods(PlayerId, GoodsId),
        lib_inv:notify_cli_goods_destroyed(PlayerId, GoodsId, ?LOC_TEMP_BAG),
        [GoodsId | Acc]
    end,
    GoodsIdList = lists:foldl(F, [], GoodsList),
    case get_inventory(PlayerId) of
        null -> 
            ?ASSERT(false),
            skip;
        Inv -> update_inventory_to_ets(Inv#inv{temp_bag_goods = Inv#inv.temp_bag_goods -- GoodsIdList})
    end.

get_all_goods_from_temp_bag(PS) ->
    PlayerId = player:id(PS),
    Inv = get_inventory(PlayerId),
    F = fun(GoodsId, Acc) ->
        case get_goods_from_ets(GoodsId) of
            null -> Acc;
            Goods -> 
                Goods1 = lib_goods:set_location(Goods, lib_goods:decide_bag_location(Goods)),
                case check_batch_add_goods(PlayerId, [Goods1]) of
                    {fail, _Reason} -> 
                        Acc;
                    ok -> 
                        smart_add_goods(PlayerId, Goods1),
                        lib_inv:notify_cli_goods_destroyed(PlayerId, GoodsId, ?LOC_TEMP_BAG),
                        [lib_goods:get_id(Goods1) | Acc]
                end
        end
    end,
    GoodsIdList = lists:foldl(F, [], Inv#inv.temp_bag_goods),
    case get_inventory(PlayerId) of
        null -> ok;
        NewInv ->
            update_inventory_to_ets(NewInv#inv{temp_bag_goods = NewInv#inv.temp_bag_goods -- GoodsIdList}),
            case length(GoodsIdList) < length(NewInv#inv.temp_bag_goods) of
                true -> lib_send:send_prompt_msg(PS, ?PM_BAG_FULL);
                false -> skip
            end,
            ok
    end.

% 重置背包获取道具
get_all_goods_from_temp_reset_bag(PS) ->
    PlayerId = player:id(PS),
    Inv = get_inventory(PlayerId),
    F = fun(GoodsId, Acc) ->
        case get_goods_from_ets(GoodsId) of
            null -> Acc;
            Goods -> 
                Goods1 = lib_goods:set_location(Goods, lib_goods:decide_bag_location(Goods)),
                case check_batch_add_goods(PlayerId, [Goods1]) of
                    {fail, _Reason} -> 
                        Acc;
                    ok -> 
                        smart_add_goods(PlayerId, Goods1),
                        lib_inv:notify_cli_goods_destroyed(PlayerId, GoodsId, ?LOC_TEMP_BAG),
                        [lib_goods:get_id(Goods1) | Acc]
                end
        end
    end,

    ?DEBUG_MSG("get_all_goods_from_temp_reset_bag=~p",[Inv#inv.temp_reset_goods]),
    
    GoodsIdList = lists:foldl(F, [], Inv#inv.temp_reset_goods),
    case get_inventory(PlayerId) of
        null -> ok;
        NewInv ->
            update_inventory_to_ets(NewInv#inv{temp_reset_goods = NewInv#inv.temp_reset_goods -- GoodsIdList}),
            case length(GoodsIdList) < length(NewInv#inv.temp_reset_goods) of
                true -> lib_send:send_prompt_msg(PS, ?PM_BAG_FULL);
                false -> skip
            end,
            ok
    end.


% 根据物品编号删除该编号的所有物品
% return true | false
destroy_all_goods_by_no(PlayerId, GoodsNo) ->
    destroy_all_goods_by_no(PlayerId, GoodsNo, []).

destroy_all_goods_by_no(PlayerId, GoodsNo, LogInfo) ->
    Count = get_goods_count_in_bag_by_no(PlayerId, GoodsNo),
    case Count > 0 of
        false ->
            false;
        true ->
            destroy_goods_WNC(PlayerId, [{GoodsNo, Count}], LogInfo),
            true
    end.


%% 从背包移除物品（只是从背包移除，并不销毁）
remove_goods_from_bag(PlayerId, GoodsId) when is_integer(GoodsId) ->
    case find_goods_by_id_from_whole_inv(PlayerId, GoodsId) of
        null ->
            ?ASSERT(false, {PlayerId, GoodsId}),
            skip;
        Goods ->
            Location = lib_goods:get_location(Goods),
            remove_goods__(PlayerId, Goods, Location)
    end;
remove_goods_from_bag(PlayerId, Goods) ->
    Location = lib_goods:get_location(Goods),
    remove_goods__(PlayerId, Goods, Location).


%% 根据物品编号在背包中查找物品
%% @return: [] | 符合条件的所有物品（goods结构体）构成的列表
find_all_goods_in_bag_by_no(PS, GoodsNo) when is_record(PS, player_status) ->
    find_all_goods_in_bag_by_no(player:get_id(PS), GoodsNo);
find_all_goods_in_bag_by_no(PlayerId, GoodsNo) when is_integer(PlayerId) ->
    Inv = get_inventory(PlayerId),
    ?ASSERT(is_record(Inv, inv), PlayerId),

    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    GoodsIdList =
    case lib_goods:is_equip(GoodsTpl) of
        true -> Inv#inv.eq_goods;
        false ->
            case lib_goods:is_can_use(GoodsTpl) of
                true -> Inv#inv.usable_goods;
                false -> Inv#inv.unusable_goods
            end
    end,
    GoodsList = get_goods_list_by_id_list(GoodsIdList),
    [Goods || Goods <- GoodsList, Goods#goods.no == GoodsNo].

%% 根据物品编号在背包中查找物品
%% @return: [] | 符合条件的所有物品（goods结构体）构成的列表
find_all_goods_by_type_and_sub(PS, Type,SubType) when is_record(PS, player_status) ->
    find_all_goods_by_type_and_sub(player:get_id(PS), Type,SubType);

find_all_goods_by_type_and_sub(PlayerId, Type,SubType) when is_integer(PlayerId) ->
    Inv = get_inventory(PlayerId),
    ?ASSERT(is_record(Inv, inv), PlayerId),

    GoodsIdList = Inv#inv.unusable_goods,
    GoodsList = get_goods_list_by_id_list(GoodsIdList),

    F = fun(Goods,Acc) when is_record(Goods,goods) ->
        GoodsNo = Goods#goods.no,
        GoodsTpl = lib_goods:get_tpl_data(GoodsNo),

        if 
            GoodsTpl#goods_tpl.type == Type andalso GoodsTpl#goods_tpl.subtype == SubType  ->
                [Goods | Acc];
            true ->
                Acc
        end
    end,

    lists:foldl(F, [], GoodsList).
    
    % [Goods || Goods <- GoodsList, Goods#goods.no == GoodsNo].




% 根据物品编号找出该编号的物品数量
get_goods_count_in_bag_by_no(PlayerId, GoodsNo) ->
    GoodsList = find_all_goods_in_bag_by_no(PlayerId, GoodsNo),
    lists:foldl(fun(X, Sum) -> X + Sum end, 0, [Goods#goods.count || Goods <- GoodsList]).


% 拖动物品（从一个格子拖动到另一个格子）
%% 注：只能拖动背包或仓库中的物品
%% return ok | {fail, Reason}
drag_goods(PlayerId, GoodsId, ToSlot, Location) ->
    ?ASSERT(is_location_bag_valid(Location), Location),
    case find_goods_by_id(PlayerId, GoodsId, Location) of
        null ->
          ?DEBUG_MSG("wujiancheng2 ~p~n" ,[{GoodsId}]),
            {fail, ?PM_GOODS_NOT_EXISTS};
        Goods ->
            % 先获取目标位置的物品
            Goods1 = find_goods_by_slot(PlayerId, ToSlot, Location),

            %处理被拖动的物品
            FromSlot = lib_goods:get_slot(Goods),
            Goods2 = lib_goods:set_slot(Goods, ToSlot),
            mark_dirty_flag(PlayerId, Goods2),
            % 如果目标位置有物品，则交换位置
            case Goods1 =:= null of
                true -> ok;
                false ->
                Goods3 = lib_goods:set_slot(Goods1, FromSlot),
                mark_dirty_flag(PlayerId, Goods3),
                ok
            end
    end.


%% 搬移物品（注意：只考虑把物品从背包移到仓库，或从仓库移到背包）
%% @return: {ok, NewSlot} | {fail, Reason}
move_goods(PlayerId, GoodsId, Count, ToLoc) ->
    ?ASSERT(is_location_bag_valid(ToLoc), ToLoc),
    case check_move_goods(PlayerId, GoodsId, Count, ToLoc) of
        {ok, Goods} ->
            do_move_goods(PlayerId, Goods, Count, ToLoc);
        {fail, Reason} ->
            {fail, Reason}
    end.




%% 查找背包或仓库的第一个空格子
%% !!!!!注意：调用此函数前需保证对应的物品栏未满，还有空位!!!
find_first_empty_slot(PlayerId, Location) ->
    Inv = get_inventory(PlayerId),
    case Location of
        ?LOC_BAG_EQ ->
            SlotsOccupied = [Goods#goods.slot || Goods <- get_goods_list(PlayerId, Location)],
            L = lists:seq(1, Inv#inv.bag_eq_capacity),
            erlang:hd(L -- SlotsOccupied);
        ?LOC_STORAGE ->
            SlotsOccupied = [Goods#goods.slot || Goods <- get_goods_list(PlayerId, Location)],
            L = lists:seq(1, Inv#inv.storage_capacity),
            erlang:hd(L -- SlotsOccupied);
        ?LOC_BAG_USABLE ->
            SlotsOccupied = [Goods#goods.slot || Goods <- get_goods_list(PlayerId, Location)],
            L = lists:seq(1, Inv#inv.bag_usable_capacity),
            erlang:hd(L -- SlotsOccupied);
        ?LOC_BAG_UNUSABLE ->
            SlotsOccupied = [Goods#goods.slot || Goods <- get_goods_list(PlayerId, Location)],
            L = lists:seq(1, Inv#inv.bag_unusable_capacity),
            erlang:hd(L -- SlotsOccupied);
        ?LOC_TEMP_BAG ->
            SlotsOccupied = [Goods#goods.slot || Goods <- get_goods_list(PlayerId, Location)],
            L = lists:seq(1, ?MAX_TEMPORARY_BAG_CAPACITY),
            erlang:hd(L -- SlotsOccupied)
    end.


%% 获取背包或仓库物品列表
%% @return: goods结构体列表（有可能为空列表）注意：要排除宝石
get_goods_list(PlayerId, Location) ->
    GoodsList1 = 
    case get_inventory(PlayerId) of
        null ->
            GoodsList = db_load_bag_goods(PlayerId),
            [Goods || Goods <- GoodsList, lib_goods:get_location(Goods) =:= Location, lib_goods:get_slot(Goods) =/= 0];
        Inv ->
            case Location of
                ?LOC_BAG_EQ ->
                    get_goods_list_by_id_list(Inv#inv.eq_goods);
                ?LOC_STORAGE ->
                    if
                        % 动态从DB加载仓库的物品（懒初始化）
                        Inv#inv.storage_goods == null ->
                            GoodsList = db_load_storage_goods(PlayerId),
                            [Goods || Goods <- GoodsList, lib_goods:get_slot(Goods) =/= 0];              
                        true ->
                            get_goods_list_by_id_list(Inv#inv.storage_goods)
                    end;
                ?LOC_PLAYER_EQP ->
                    get_goods_list_by_id_list(Inv#inv.player_eq_goods);
                ?LOC_PARTNER_EQP ->
                    get_goods_list_by_id_list(Inv#inv.partner_eq_goods);
                ?LOC_BAG_USABLE ->
                    get_goods_list_by_id_list(Inv#inv.usable_goods);
                ?LOC_BAG_UNUSABLE ->
                    get_goods_list_by_id_list(Inv#inv.unusable_goods);
                ?LOC_TEMP_BAG ->
                    get_goods_list_by_id_list(Inv#inv.temp_bag_goods);
                ?LOC_TEMP_RESET ->
                    get_goods_list_by_id_list(Inv#inv.temp_reset_goods);
                _ ->
                    ?ASSERT(false, Location),
                    []  % 做容错，返回空列表
            end
    end,

    F2 = fun(Goods) when is_record(Goods,goods) -> Goods#goods.id =/= 0 andalso PlayerId =:= Goods#goods.player_id end,
    Ret = lists:filter(F2, GoodsList1),

    Ret.


%% @return: {ok, NemSlotNum} | {fail, reason}
extend_capacity(PS, Location, SlotNum) ->
    case check_extend_capacity(PS, Location, SlotNum) of
        {ok, NeedGoodsCount, NeedGamemoney, NeedBindYuanbao} ->
            % 扣除消耗...
            LogInfo = 
                case Location of
                    ?LOC_STORAGE -> [?LOG_GOODS, expand_store];
                    _ -> [?LOG_GOODS, expand_bag]
                end,
            case NeedGoodsCount > 0 of
                true -> 
                    mod_inv:destroy_goods_WNC(player:get_id(PS), [{?GOODS_NO_UNLOCK_BAG, NeedGoodsCount}], LogInfo);
                false -> skip
            end,
            case NeedGamemoney > 0 of
                true -> 
                    player:cost_gamemoney(PS, NeedGamemoney, LogInfo);
                false -> skip
            end,
            
            case NeedBindYuanbao > 0 of
                true -> player:cost_bind_yuanbao(PS, NeedBindYuanbao, LogInfo);
                false -> skip
            end,

            Inv = get_inventory(player:id(PS)),
            % 扩充容量
            if
                Location =:= ?LOC_BAG_EQ ->
                    NewInv = Inv#inv{bag_eq_capacity = Inv#inv.bag_eq_capacity + SlotNum},
                    update_inventory_to_ets(NewInv),
                    {ok, NewInv#inv.bag_eq_capacity};
                Location =:= ?LOC_BAG_USABLE ->
                    NewInv = Inv#inv{bag_usable_capacity = Inv#inv.bag_usable_capacity + SlotNum},
                    update_inventory_to_ets(NewInv),
                    {ok, NewInv#inv.bag_usable_capacity};
                Location =:= ?LOC_BAG_UNUSABLE ->
                    NewInv = Inv#inv{bag_unusable_capacity = Inv#inv.bag_unusable_capacity + SlotNum},
                    update_inventory_to_ets(NewInv),
                    {ok, NewInv#inv.bag_unusable_capacity};
                Location =:= ?LOC_STORAGE ->
                    NewInv = Inv#inv{storage_capacity = Inv#inv.storage_capacity + SlotNum},
                    update_inventory_to_ets(NewInv),
                    {ok, NewInv#inv.storage_capacity};
                true ->
                    skip
            end;
        {fail, Reason} ->
            {fail, Reason}
    end.


%% 整理背包
arrange_bag(PS) ->
    BagGoodsList1 = get_goods_list(player:id(PS), ?LOC_BAG_EQ),
    % ∵同一子类型按品质高低进行排序。
    % ∵按装备子类型先后顺序进行排列。
    % ∵同品质依据装备ID先后进行排序。
    SortedGoodsList10 = lib_inv:sort_goods(BagGoodsList1, sort_by_sub_type),
    SortedGoodsList11 = lib_inv:sort_goods(SortedGoodsList10, sort_by_no),
    SortedGoodsList12 = lib_inv:sort_goods(SortedGoodsList11, sort_by_quality),
    [_SlotCount1, _, _] = lists:foldl(fun do_arrange_bag/2, [1, {}, PS], SortedGoodsList12),

    BagGoodsList2 = get_goods_list(player:id(PS), ?LOC_BAG_USABLE),
    % ∵按类型进行先后顺序排列
    % ∵同类型按品质高低进行排序。
    % ∵同品质依据道具ID先后进行排序。
    F2 = fun(G1, G2) ->
        Type1 = lib_goods:get_type(G1),
        Type2 = lib_goods:get_type(G2),
        BindState1 = lib_goods:get_bind_state(G1),
        BindState2 = lib_goods:get_bind_state(G2),
        No1 = lib_goods:get_no(G1),
        No2 = lib_goods:get_no(G2), 

        LastSellTime1 = lib_goods:get_last_sell_time(G1),
        LastSellTime2 = lib_goods:get_last_sell_time(G2),

        if
            % Type1 < Type2 -> true;
            % Type1 > Type2 -> false;
            % No1 =:= No2 andalso BindState1 < BindState2 -> true;
            % true -> false
            No1 < No2 -> true;
            No1 =:= No2 -> LastSellTime1 > LastSellTime2;
            LastSellTime1 =:= LastSellTime2 -> lib_goods:get_id(G1) > lib_goods:get_id(G2);
            true -> false
        end
    end,
    SortedGoodsList22 = lists:sort(F2, BagGoodsList2),
    % SortedGoodsList20 = lib_inv:sort_goods(BagGoodsList2, sort_by_type),
    % SortedGoodsList21 = lib_inv:sort_goods(SortedGoodsList20, sort_by_no),
    % SortedGoodsList22 = lib_inv:sort_goods(SortedGoodsList21, sort_by_quality),
    [_SlotCount2, _, _] = lists:foldl(fun do_arrange_bag/2, [1, {}, PS], SortedGoodsList22),

    BagGoodsList3Temp = get_goods_list(player:id(PS), ?LOC_BAG_UNUSABLE),

    Frepair = fun(Goods,Acc) ->
        repair_virtual_goods(player:id(PS),Goods,[?LOG_GOODS, "repair"]) 
    end,

    lists:foldl(Frepair,0,BagGoodsList3Temp),

    BagGoodsList3 = get_goods_list(player:id(PS), ?LOC_BAG_UNUSABLE),

    % ∵按类型进行先后顺序排列
    % ∵同类型按品质高低进行排序。
    % ∵同品质依据道具ID先后进行排序。
    F3 = fun(G1, G2) ->
        Type1 = lib_goods:get_type(G1),
        Type2 = lib_goods:get_type(G2),
        BindState1 = lib_goods:get_bind_state(G1),
        BindState2 = lib_goods:get_bind_state(G2),
        No1 = lib_goods:get_no(G1),
        No2 = lib_goods:get_no(G2),

        LastSellTime1 = lib_goods:get_last_sell_time(G1),
        LastSellTime2 = lib_goods:get_last_sell_time(G2),
        if
            % Type1 < Type2 -> true;
            % Type1 > Type2 -> false;
            % No1 =:= No2 andalso BindState1 < BindState2 -> true;
            % true -> false
            No1 < No2 -> true;
            No1 =:= No2 -> LastSellTime1 > LastSellTime2;
            LastSellTime1 =:= LastSellTime2 -> lib_goods:get_id(G1) > lib_goods:get_id(G2);
            true -> false

        end
    end,
    SortedGoodsList32 = lists:sort(F3, BagGoodsList3),
    % SortedGoodsList30 = lib_inv:sort_goods(BagGoodsList3, sort_by_type),
    % SortedGoodsList31 = lib_inv:sort_goods(SortedGoodsList30, sort_by_no),
    % SortedGoodsList32 = lib_inv:sort_goods(SortedGoodsList31, sort_by_quality),
    [_SlotCount3, _, _] = lists:foldl(fun do_arrange_bag/2, [1, {}, PS], SortedGoodsList32),
    ok.


arrange_storage(PS) ->
    GoodsList = get_goods_list(player:id(PS), ?LOC_STORAGE),
    % GoodsList1 = lib_inv:sort_goods(GoodsList, sort_by_type),
    % GoodsList2 = lib_inv:sort_goods(GoodsList1, sort_by_quality),
    % GoodsList3 = lib_inv:sort_goods(GoodsList2, sort_by_no),
    F = fun(G1, G2) ->
        % Type1 = lib_goods:get_type(G1),
        % Type2 = lib_goods:get_type(G2),
        % BindState1 = lib_goods:get_bind_state(G1),
        % BindState2 = lib_goods:get_bind_state(G2),
        % No1 = lib_goods:get_no(G1),
        % No2 = lib_goods:get_no(G2),

        Type1 = lib_goods:get_type(G1),
        Type2 = lib_goods:get_type(G2),
        BindState1 = lib_goods:get_bind_state(G1),
        BindState2 = lib_goods:get_bind_state(G2),
        No1 = lib_goods:get_no(G1),
        No2 = lib_goods:get_no(G2), 

        LastSellTime1 = lib_goods:get_last_sell_time(G1),
        LastSellTime2 = lib_goods:get_last_sell_time(G2),

        if
            No1 < No2 -> true;
            No1 =:= No2 -> LastSellTime1 > LastSellTime2;
            LastSellTime1 =:= LastSellTime2 -> lib_goods:get_id(G1) > lib_goods:get_id(G2);
            true -> false
        end
    end,
    SGoodsList = lists:sort(F, GoodsList),

    [_SlotCount, _, _] = lists:foldl(fun do_arrange_bag/2, [1, {}, PS], SGoodsList),
    ok.    

%% 处理时效物品过期
handle_goods_expired(PlayerId, GoodsId) ->
    case find_goods_by_id_from_whole_inv(PlayerId, GoodsId) of
        null -> %% 这个分支是正常的，玩家可以把时效物品出售
            % ?ERROR_MSG("[mod_inv] handle_goods_expired() error!! GoodsId:~p", [GoodsId]),
            % ?ASSERT(false, GoodsId),
            skip;
        Goods ->
            ?ASSERT(lib_goods:is_timing_goods(Goods), Goods),
            ?ASSERT(lib_goods:get_owner_id(Goods) == PlayerId, {PlayerId, Goods}),
            case lib_goods:get_timekeeping_type(Goods) of
                ?TKP_BY_ACC_ONLINE ->
                    Goods2 = lib_goods:set_left_valid_time(Goods, 0),
                    mark_dirty_flag(PlayerId, Goods2);
                _ ->
                    skip
            end

            % TODO： 处理物品效果消失。。。
            %
    end.


% 玩家下线, 删除玩家所有物品信息。注意：调用此函数前，确保还没有调用del_inventory_from_ets函数
del_goods_from_ets_by_player_id(PlayerId) ->
    case get_inventory(PlayerId) of
        null ->
            ?ASSERT(false);
        Inv ->
            F = fun(GoodsId) ->
                del_goods_from_ets_by_goods_id(GoodsId)
            end,

            ?Ifc (is_list(Inv#inv.eq_goods) andalso Inv#inv.eq_goods /= [])
                lists:foreach(F, Inv#inv.eq_goods)
            ?End,

            ?Ifc (is_list(Inv#inv.usable_goods) andalso Inv#inv.usable_goods /= [])
                lists:foreach(F, Inv#inv.usable_goods)
            ?End,

            ?Ifc (is_list(Inv#inv.unusable_goods) andalso Inv#inv.unusable_goods /= [])
                lists:foreach(F, Inv#inv.unusable_goods)
            ?End,

            ?Ifc (is_list(Inv#inv.storage_goods) andalso Inv#inv.storage_goods /= [])
                lists:foreach(F, Inv#inv.storage_goods)
            ?End,

            ?Ifc (is_list(Inv#inv.player_eq_goods) andalso Inv#inv.player_eq_goods /= [])
                lists:foreach(F, Inv#inv.player_eq_goods)
            ?End,

            ?Ifc (is_list(Inv#inv.partner_eq_goods) andalso Inv#inv.partner_eq_goods /= [])
                lists:foreach(F, Inv#inv.partner_eq_goods)
            ?End
    end.


% 根据物品唯一id获取物品编号
get_goods_no_by_goods_id(PlayerId, GoodsId) ->
    case find_goods_by_id_from_whole_inv(PlayerId, GoodsId) of
        null ->
            ?ASSERT(false, GoodsId),
            ?INVALID_NO;
        Goods ->
            lib_goods:get_no(Goods)
    end.

% 根据物品唯一找出该物品数量的堆叠数量
get_goods_count_in_bag_by_id(PlayerId, GoodsId) ->
    case find_goods_by_id_from_whole_inv(PlayerId, GoodsId) of
        null ->
            ?ASSERT(false, GoodsId),
            0;
        Goods ->
            lib_goods:get_count(Goods)
    end.


find_goods_by_id_from_bag(PlayerId, GoodsId) ->
    Inv = get_inventory(PlayerId),
    % 先尝试从背包查找
    case find_goods_by_id_from__(Inv, GoodsId, ?LOC_BAG_EQ) of
        Goods when Goods /= null ->
            Goods;
        null ->
            case find_goods_by_id_from__(Inv, GoodsId, ?LOC_BAG_USABLE) of
                Goods when Goods /= null ->
                    Goods;
                null ->
                    case find_goods_by_id_from__(Inv, GoodsId, ?LOC_BAG_UNUSABLE) of  %% 尝试从不可用物品背包查找
                        Goods when Goods /= null ->
                            Goods;
                        null ->
                            null
                    end
            end
    end.

%% 根据物品唯一id尝试在整个物品栏中查找物品
%% @return: null | 所找到的物品（goods结构体）
find_goods_by_id_from_whole_inv(PlayerId, GoodsId) ->
    Inv = get_inventory(PlayerId),
    % 先尝试从背包查找
    case find_goods_by_id_from__(Inv, GoodsId, ?LOC_BAG_EQ) of
        Goods when Goods /= null ->
            Goods;
        null ->
            case find_goods_by_id_from__(Inv, GoodsId, ?LOC_PLAYER_EQP) of % 再尝试从玩家的装备栏查找
                Goods when Goods /= null ->
                    Goods;
                null ->
                    case find_goods_by_id_from__(Inv, GoodsId, ?LOC_PARTNER_EQP) of % 尝试从宠物的装备栏查找
                        Goods when Goods /= null ->
                            Goods;
                        null ->
                            case find_goods_by_id_from__(Inv, GoodsId, ?LOC_BAG_USABLE) of
                                Goods when Goods /= null ->
                                    Goods;
                                null ->
                                    case find_goods_by_id_from__(Inv, GoodsId, ?LOC_BAG_UNUSABLE) of  %% 尝试从不可用物品背包查找
                                        Goods when Goods /= null ->
                                            Goods;
                                        null ->
                                            case find_goods_by_id_from__(Inv, GoodsId, ?LOC_STORAGE) of % 尝试从仓库查找
                                                Goods when Goods /= null ->
                                                    Goods;
                                                null ->
                                                    case find_goods_by_id_from__(Inv, GoodsId, ?LOC_TEMP_BAG) of
                                                        Goods when Goods /= null ->
                                                            Goods;
                                                        null ->
                                                            case find_goods_by_id_from__(Inv, GoodsId, ?LOC_MAIL) of
                                                                Goods when Goods /= null ->
                                                                    Goods;
                                                                null ->
																	?ERROR_MSG("Could Not find {PlayerId, GoodsId} : ~p~n", [{PlayerId, GoodsId}]),
                                                                    null
                                                            end
                                                    end
                                            end
                                    end
                            end
                    end
            end
    end.


auto_use_goods_for_add_store_hp(PS) ->
    GoodsList = get_goods_list(player:id(PS), ?LOC_BAG_USABLE),
    GoodsCanUse =
        [Goods || Goods <- GoodsList, lists:member(add_store_hp, lib_goods:get_effects_name_list(Goods)),
        lists:member(?OBJ_PLAYER, lib_goods:get_target_obj_type_list(Goods))],
    case GoodsCanUse =:= [] of
        true -> skip;
        false -> do_use_goods(PS, erlang:hd(GoodsCanUse))
    end.


auto_use_goods_for_add_store_mp(PS) ->
    GoodsList = get_goods_list(player:id(PS), ?LOC_BAG_USABLE),
    GoodsCanUse =
        [Goods || Goods <- GoodsList, lists:member(add_store_mp, lib_goods:get_effects_name_list(Goods)),
        lists:member(?OBJ_PLAYER, lib_goods:get_target_obj_type_list(Goods))],
    case GoodsCanUse =:= [] of
        true -> skip;
        false -> do_use_goods(PS, erlang:hd(GoodsCanUse))
    end.

auto_use_goods_for_add_store_par_hp(PS) ->
    GoodsList = get_goods_list(player:id(PS), ?LOC_BAG_USABLE),
    GoodsCanUse =
        [Goods || Goods <- GoodsList, lists:member(add_store_par_hp, lib_goods:get_effects_name_list(Goods)),
        lists:member(?OBJ_PLAYER, lib_goods:get_target_obj_type_list(Goods))],
    case GoodsCanUse =:= [] of
        true -> skip;
        false -> do_use_goods(PS, erlang:hd(GoodsCanUse))
    end.


auto_use_goods_for_add_store_par_mp(PS) ->
    GoodsList = get_goods_list(player:id(PS), ?LOC_BAG_USABLE),
    GoodsCanUse =
        [Goods || Goods <- GoodsList, lists:member(add_store_par_mp, lib_goods:get_effects_name_list(Goods)),
        lists:member(?OBJ_PLAYER, lib_goods:get_target_obj_type_list(Goods))],
    case GoodsCanUse =:= [] of
        true -> skip;
        false -> do_use_goods(PS, erlang:hd(GoodsCanUse))
    end.


%% ================================================================================================================================
%% ================================================ Local Funciotns ===============================================================


%% 根据物品唯一id尝试在整个物品栏（不包括玩家和宠物身上的装备）中查找物品
%% @return: null | 所找到的物品（goods结构体）
find_goods_by_id_from_whole_inv_except_EQP(PlayerId, GoodsId) ->
    Inv = get_inventory(PlayerId),
    case find_goods_by_id_from__(Inv, GoodsId, ?LOC_BAG_EQ) of
        Goods when Goods /= null ->
            Goods;
        null ->
            case find_goods_by_id_from__(Inv, GoodsId, ?LOC_BAG_USABLE) of
                Goods when Goods /= null ->
                    Goods;
                null ->
                    case find_goods_by_id_from__(Inv, GoodsId, ?LOC_BAG_UNUSABLE) of  %% 尝试从不可用物品背包查找
                        Goods when Goods /= null ->
                            Goods;
                        null ->
                            case find_goods_by_id_from__(Inv, GoodsId, ?LOC_STORAGE) of % 尝试从仓库查找
                                Goods when Goods /= null ->
                                    Goods;
                                null ->
                                    case find_goods_by_id_from__(Inv, GoodsId, ?LOC_TEMP_BAG) of
                                        Goods when Goods /= null ->
                                            Goods;
                                        null ->
                                            case find_goods_by_id_from__(Inv, GoodsId, ?LOC_MAIL) of
                                                Goods when Goods /= null ->
                                                    Goods;
                                                null -> null
                                            end
                                    end
                            end
                    end
            end
    end.


%% 根据物品编号尝试在整个物品栏中查找物品 --- 目前不导出此函数，以后有需要的话，再导出
%% @return: [] | 所找到的物品（goods结构体列表）
find_goods_by_no_from_inv(PlayerId, GoodsNo, Location) ->
    case get_inventory(PlayerId) of
        null -> [];
        Inv ->
            case Location of
                ?LOC_BAG_EQ ->
                    find_goods_by_no_from__(Inv, GoodsNo, ?LOC_BAG_EQ);
                ?LOC_STORAGE ->
                    find_goods_by_no_from__(Inv, GoodsNo, ?LOC_STORAGE);
                ?LOC_PLAYER_EQP ->
                    find_goods_by_no_from__(Inv, GoodsNo, ?LOC_PLAYER_EQP);
                ?LOC_PARTNER_EQP ->
                    find_goods_by_no_from__(Inv, GoodsNo, ?LOC_PARTNER_EQP);
                ?LOC_BAG_USABLE ->
                    find_goods_by_no_from__(Inv, GoodsNo, ?LOC_BAG_USABLE);
                ?LOC_BAG_UNUSABLE ->
                    find_goods_by_no_from__(Inv, GoodsNo, ?LOC_BAG_UNUSABLE);
                _Any ->
                    []
            end
    end.


%% @return: null | inv结构体
get_inventory(PlayerId) ->
    case ets:lookup(?ETS_INVENTORY, PlayerId) of
        [] -> null;
        [Inv] -> Inv
    end.


%% return: null | goods结构体
get_goods_from_ets(GoodsId) ->
    case ets:lookup(?MY_ETS_INV_GOODS(GoodsId), GoodsId) of
        [] -> null;
        [Goods] -> Goods
    end.


get_bag_capacity(PlayerId, Location) ->
    case ets:lookup(?ETS_INVENTORY, PlayerId) of
        [] -> 0;
        [Inv] ->
            case Location of
                ?LOC_BAG_EQ -> Inv#inv.bag_eq_capacity;
                ?LOC_BAG_USABLE -> Inv#inv.bag_usable_capacity;
                ?LOC_BAG_UNUSABLE -> Inv#inv.bag_unusable_capacity;
                ?LOC_TEMP_BAG -> ?MAX_TEMPORARY_BAG_CAPACITY
            end
    end.


get_storage_capacity(PlayerId) ->
    case ets:lookup(?ETS_INVENTORY, PlayerId) of
        [] -> 0;
        [Inv] -> Inv#inv.storage_capacity
    end.


%% 添加物品到背包或仓库，包含更新最新inv到ets的操作 如果物品上包含宝石，会把宝石id加到物品栏
%% @return: 无
add_goods__(PlayerId, Goods, Location) ->
    ?ASSERT(is_record(Goods, goods), Goods),
    ?ASSERT(is_location_expcept_on_body_valid(Location), Location),
    Inv = get_inventory(PlayerId),
    Inv2 =  case Location of
                ?LOC_BAG_EQ ->
                    GemIdList = lib_goods:get_gem_id_list(Goods),
                    EqGoodsIdList = [Goods#goods.id | Inv#inv.eq_goods],
                    EqGoodsIdList1 = EqGoodsIdList ++ GemIdList,
                    Inv#inv{
                        eq_goods = sets:to_list(sets:from_list(EqGoodsIdList1))
                        };
                ?LOC_STORAGE ->
                    Inv#inv{
                        storage_goods = [Goods#goods.id | Inv#inv.storage_goods]
                        };
                ?LOC_BAG_USABLE ->
                    Inv#inv{
                        usable_goods = [Goods#goods.id | Inv#inv.usable_goods]
                        };
                ?LOC_BAG_UNUSABLE ->
                    Inv#inv{
                        unusable_goods = [Goods#goods.id | Inv#inv.unusable_goods]
                        };
                ?LOC_TEMP_BAG ->
                    Inv#inv{
                        temp_bag_goods = [Goods#goods.id | Inv#inv.temp_bag_goods]
                        };
                _Any ->
                    Inv
            end,
    update_inventory_to_ets(Inv2),
    add_goods_to_ets(Goods),
    void.


%% 添加物品到背包或仓库，不包含更新最新inv到ets的操作，而是返回它，由上层函数按需再做进一步的处理!!
%% @return: 最新的inv结构体
add_goods_2__(Inv, Goods, Location) ->
    ?ASSERT(is_record(Goods, goods), Goods),
    ?ASSERT(is_location_bag_valid(Location), Location),
    
    Inv2 =  case Location of
                ?LOC_BAG_EQ ->
                    Inv#inv{
                        eq_goods = [Goods#goods.id | Inv#inv.eq_goods]
                        };
                ?LOC_STORAGE ->
                    Inv#inv{
                        storage_goods = [Goods#goods.id | Inv#inv.storage_goods]
                        };
                ?LOC_BAG_USABLE ->
                    Inv#inv{
                        usable_goods = [Goods#goods.id | Inv#inv.usable_goods]
                        };
                ?LOC_BAG_UNUSABLE ->
                    Inv#inv{
                        unusable_goods = [Goods#goods.id | Inv#inv.unusable_goods]
                        };
                ?LOC_TEMP_BAG ->
                    Inv#inv{
                        temp_bag_goods = [Goods#goods.id | Inv#inv.temp_bag_goods]
                        }
            end,
    Inv2.


%% 从背包或仓库或装备栏移除物品（只是移除，并不销毁物品），包含更新最新inv到ets的操作
%% @return: 无
remove_goods__(PlayerId, GoodsId, Location) when is_integer(GoodsId) ->
    ?ASSERT(is_location_valid(Location), Location),
    case get_goods_from_ets(GoodsId) of
        null ->
            ?ASSERT(false, GoodsId),
            void;
        Goods ->
            remove_goods__(PlayerId, Goods, Location)
    end;            
remove_goods__(PlayerId, Goods, Location) ->
    ?ASSERT(is_location_valid(Location), Location),
    case get_inventory(PlayerId) of
        null -> void;
        Inv ->
            GoodsId = lib_goods:get_id(Goods),
            Inv2 =  case Location of
                        ?LOC_BAG_EQ ->
                            GemIdList = lib_goods:get_gem_id_list(Goods),
                            EqGoodsIdList = Inv#inv.eq_goods -- [GoodsId],
                            EqGoodsIdList1 = EqGoodsIdList -- GemIdList,
                            Inv#inv{
                                eq_goods = EqGoodsIdList1
                                };
                        ?LOC_STORAGE ->
                            Inv#inv{
                                storage_goods = Inv#inv.storage_goods -- [GoodsId]
                                };
                        ?LOC_BAG_USABLE ->
                            Inv#inv{
                                usable_goods = Inv#inv.usable_goods -- [GoodsId]
                                };
                        ?LOC_BAG_UNUSABLE ->
                            Inv#inv{
                                unusable_goods = Inv#inv.unusable_goods -- [GoodsId]
                                };
                        ?LOC_PLAYER_EQP ->
                            GemIdList = lib_goods:get_gem_id_list(Goods),
                            PlayerEqGoodsIdList = Inv#inv.player_eq_goods -- [GoodsId],
                            PlayerEqGoodsIdList1 = PlayerEqGoodsIdList -- GemIdList,
                            Inv#inv{
                                player_eq_goods = PlayerEqGoodsIdList1
                                };
                        ?LOC_PARTNER_EQP ->
                            GemIdList = lib_goods:get_gem_id_list(Goods),
                            PartnerEqGoodsIdList = Inv#inv.partner_eq_goods -- [GoodsId],
                            PartnerEqGoodsIdList1 = PartnerEqGoodsIdList -- GemIdList,
                            Inv#inv{
                                partner_eq_goods = PartnerEqGoodsIdList1
                                };
                        ?LOC_TEMP_BAG ->
                            Inv#inv{
                                usable_goods = Inv#inv.temp_bag_goods -- [GoodsId]
                                };
                        _Any ->
                            Inv

                    end,
            
            update_inventory_to_ets(Inv2),
            void
    end.


%% 从背包或仓库或装备栏移除物品（只是移除，并不销毁物品），不包含更新最新inv到ets的操作，而是返回它，由上层函数按需再做进一步的处理!!
%% @return: 最新的inv结构体
remove_goods_2__(Inv, GoodsId, Location) ->
    ?ASSERT(is_record(Inv, inv)),
    ?ASSERT(is_location_valid(Location), Location),
    
    Inv2 =  case Location of
                ?LOC_BAG_EQ ->
                    Inv#inv{
                        eq_goods = Inv#inv.eq_goods -- [GoodsId]
                        };
                ?LOC_STORAGE ->
                    Inv#inv{
                        storage_goods = Inv#inv.storage_goods -- [GoodsId]
                        };
                ?LOC_BAG_USABLE ->
                    Inv#inv{
                        usable_goods = Inv#inv.usable_goods -- [GoodsId]
                        };
                ?LOC_BAG_UNUSABLE ->
                    Inv#inv{
                        unusable_goods = Inv#inv.unusable_goods -- [GoodsId]
                        };
                ?LOC_PLAYER_EQP ->
                    Inv#inv{
                        unusable_goods = Inv#inv.player_eq_goods -- [GoodsId]
                        };
                ?LOC_PARTNER_EQP ->
                    Inv#inv{
                        unusable_goods = Inv#inv.partner_eq_goods -- [GoodsId]
                        };
                ?LOC_TEMP_BAG ->
                    Inv#inv{
                        usable_goods = Inv#inv.temp_bag_goods -- [GoodsId]
                        };
                _Any ->
                    ?ASSERT(false, _Any),
                    Inv
            end,
    Inv2.


%% 添加inv到ets
add_inventory_to_ets(Inv) when is_record(Inv, inv) ->
    ets:insert(?ETS_INVENTORY, Inv).


%% 添加物品goods结构体到ets
add_goods_to_ets(Goods) when is_record(Goods, goods) ->
    ets:insert(?MY_ETS_INV_GOODS(Goods#goods.id), Goods).

%% 从ets删除inv
del_inventory_from_ets(PlayerId) ->
    ets:delete(?ETS_INVENTORY, PlayerId).


%% 从ets删除goods
del_goods_from_ets_by_goods_id(GoodsId) ->
    ets:delete(?MY_ETS_INV_GOODS(GoodsId), GoodsId).


%% 更新inv到ets
update_inventory_to_ets(Inv_Latest) when is_record(Inv_Latest, inv) ->
    ets:insert(?ETS_INVENTORY, Inv_Latest).


update_goods_to_ets(Goods_Latest) when is_record(Goods_Latest, goods) ->
    ets:insert(?MY_ETS_INV_GOODS(Goods_Latest), Goods_Latest).


%% 从物品栏查找指定唯一id的物品
%% @return: null | goods结构体
find_goods_by_id_from__(Inv, 0, _) ->
    null;

find_goods_by_id_from__(Inv, GoodsId, ?LOC_BAG_EQ) ->
    case lists:member(GoodsId, Inv#inv.eq_goods) of
        false -> null;
        true -> get_goods_from_ets(GoodsId)
    end;

find_goods_by_id_from__(Inv, GoodsId, ?LOC_STORAGE) ->
    case is_list(Inv#inv.storage_goods) of
        false -> null;
        true ->
            case lists:member(GoodsId, Inv#inv.storage_goods) of
                false -> null;
                true -> get_goods_from_ets(GoodsId)
            end
    end;
find_goods_by_id_from__(Inv, GoodsId, ?LOC_PLAYER_EQP) ->
    case lists:member(GoodsId, Inv#inv.player_eq_goods) of
        false -> null;
        true -> get_goods_from_ets(GoodsId)
    end;
find_goods_by_id_from__(Inv, GoodsId, ?LOC_PARTNER_EQP) ->
    case lists:member(GoodsId, Inv#inv.partner_eq_goods) of
        false -> null;
        true -> get_goods_from_ets(GoodsId)
    end;
find_goods_by_id_from__(Inv, GoodsId, ?LOC_BAG_USABLE) ->
    case lists:member(GoodsId, Inv#inv.usable_goods) of
        false -> null;
        true -> get_goods_from_ets(GoodsId)
    end;
find_goods_by_id_from__(Inv, GoodsId, ?LOC_BAG_UNUSABLE) ->
    case lists:member(GoodsId, Inv#inv.unusable_goods) of
        false -> null;
        true -> get_goods_from_ets(GoodsId)
    end;
find_goods_by_id_from__(Inv, GoodsId, ?LOC_TEMP_BAG) ->
    case lists:member(GoodsId, Inv#inv.temp_bag_goods) of
        false -> null;
        true -> get_goods_from_ets(GoodsId)
    end;
find_goods_by_id_from__(_Inv, GoodsId, ?LOC_MAIL) ->
    case get_goods_from_ets(GoodsId) of
        null -> null;
        Goods ->
            case lib_goods:get_location(Goods) =:= ?LOC_MAIL of
                false -> 
                    % ?ERROR_MSG("mod_inv:find_goods_by_id_from__ error!GoodsId:~p, Location:~p~n", [GoodsId, lib_goods:get_location(Goods)]),
                    null;
                true -> Goods
            end
    end.


%% 从物品栏查找指定编号的物品
%% @return: null | goods结构体
find_goods_by_no_from__(Inv, GoodsNo, ?LOC_BAG_EQ) ->
    BagGoodsList = get_goods_list(Inv#inv.player_id, ?LOC_BAG_EQ),
    [Goods || Goods <- BagGoodsList, Goods#goods.no =:= GoodsNo];
find_goods_by_no_from__(Inv, GoodsNo, ?LOC_STORAGE) ->
    StoGoodsList = get_goods_list(Inv#inv.player_id, ?LOC_STORAGE),
    [Goods || Goods <- StoGoodsList, Goods#goods.no =:= GoodsNo];
find_goods_by_no_from__(Inv, GoodsNo, ?LOC_PLAYER_EQP) ->
    EqpGoodsList = get_goods_list(Inv#inv.player_id, ?LOC_PLAYER_EQP),
    [Goods || Goods <- EqpGoodsList, Goods#goods.no =:= GoodsNo];
find_goods_by_no_from__(Inv, GoodsNo, ?LOC_PARTNER_EQP) ->
    PeqGoodsList = get_goods_list(Inv#inv.player_id, ?LOC_PARTNER_EQP),
    [Goods || Goods <- PeqGoodsList, Goods#goods.no =:= GoodsNo];
find_goods_by_no_from__(Inv, GoodsNo, ?LOC_BAG_USABLE) ->
    GoodsList = get_goods_list(Inv#inv.player_id, ?LOC_BAG_USABLE),
    [Goods || Goods <- GoodsList, Goods#goods.no =:= GoodsNo];
find_goods_by_no_from__(Inv, GoodsNo, ?LOC_BAG_UNUSABLE) ->
    GoodsList = get_goods_list(Inv#inv.player_id, ?LOC_BAG_UNUSABLE),
    [Goods || Goods <- GoodsList, Goods#goods.no =:= GoodsNo];
find_goods_by_no_from__(Inv, GoodsNo, ?LOC_TEMP_BAG) ->
    GoodsList = get_goods_list(Inv#inv.player_id, ?LOC_TEMP_BAG),
    [Goods || Goods <- GoodsList, Goods#goods.no =:= GoodsNo].


%% 从数据库加载玩家的背包物品（包括顺带加载玩家自身以及其宠物已装备的物品）
%% @return: [] | goods结构体列表
db_load_bag_goods(PlayerId) ->
    case db:select_all(goods, ?SQL_QRY_GOODS_INFO, [{player_id, PlayerId}, {location, "<>", ?LOC_STORAGE}]) of
        InfoList_List when is_list(InfoList_List) ->
            % [to_goods_record(InfoList) || InfoList <- InfoList_List];
            F = fun(InfoList, AccList) ->
                [_GoodsId, GoodsNo, _PlayerId, _PartnerId, _BindState, _UsableTimes, _Location, _Slot, _Count, _Quality, _FirstUseTime, _ValidTime, _ExpireTime,
                    _BaseEquipAdd_BS, _AddiEquipAdd_BS, _StrenEquipAdd_BS, _EquipProp_BS, _CustomType, _Extra_BS, _ShowBaseAttr] = InfoList,
                    
                case lib_goods:get_tpl_data(GoodsNo) of
                    null ->
                        ?ERROR_MSG("[mod_inv] db_load_bag_goods() GoodsNo:~p not exist~n", [GoodsNo]),
                        AccList;
                    _GoodsTpl -> [to_goods_record(InfoList) | AccList]
                end
            end,
            lists:foldl(F, [], InfoList_List);
        _Any ->
            ?ERROR_MSG("[mod_inv] db_load_bag_goods() error!", []),
            ?ASSERT(false, _Any),
            []
    end.

db_load_bag_goods1(PlayerId) ->
    case db:select_all(goods, ?SQL_QRY_GOODS_INFO, [{player_id, PlayerId}, {location, "<>", ?LOC_STORAGE}]) of
        InfoList_List when is_list(InfoList_List) ->
            % [to_goods_record(InfoList) || InfoList <- InfoList_List];
            F = fun(InfoList, AccList) ->
                [_GoodsId, GoodsNo, _PlayerId, _PartnerId, _BindState, _UsableTimes, Location, Slot, _Count, _Quality, _FirstUseTime, _ValidTime, _ExpireTime,
                    _BaseEquipAdd_BS, _AddiEquipAdd_BS, _StrenEquipAdd_BS, _EquipProp_BS, _CustomType, _Extra_BS, _ShowBaseAttr] = InfoList,

                case GoodsNo > 70000 andalso GoodsNo < 74000 of
                    true ->
                        ?DEBUG_MSG("db_load_bag_goods1 ~p",[InfoList]);
                    false -> skip
                end,
                    
                case lib_goods:get_tpl_data(GoodsNo) of
                    null ->
                        ?ERROR_MSG("[mod_inv] db_load_bag_goods() GoodsNo:~p not exist~n", [GoodsNo]),
                        AccList;
                    GoodsTpl -> 
                        % 如果是宝石 并是镶嵌上的 则修改到设置背包
                        case lib_goods:is_gem_goods(GoodsTpl) andalso Slot =:= 0 of
                            true ->
                                ?DEBUG_MSG("[mod_inv] db_load_bag_goods() GoodsNo:~p not exist~n", [GoodsNo]),
                                [to_goods_record([_GoodsId, GoodsNo, _PlayerId, _PartnerId, _BindState, _UsableTimes, ?LOC_TEMP_RESET, Slot, _Count, _Quality, _FirstUseTime, _ValidTime, _ExpireTime,
                    _BaseEquipAdd_BS, _AddiEquipAdd_BS, _StrenEquipAdd_BS, _EquipProp_BS, _Extra_BS, _ShowBaseAttr]) | AccList];
                            false ->
                                [to_goods_record(InfoList) | AccList]
                        end
                end
            end,
            GoodsList = lists:foldl(F, [], InfoList_List),

            F1 = fun(Goods,Acc) when is_record(Goods,goods) ->
                case lib_goods:is_equip(Goods) of
                    true ->
                        [lib_goods:set_equip_gemstone(Goods,[{1,0},{2,0},{3,0},{4,0}]) | Acc];
                    false ->
                        [ Goods | Acc]
                end
            end,

            GoodsList1 = lists:foldl(F1, [], GoodsList),
            GoodsList1;
        _Any ->
            ?ERROR_MSG("[mod_inv] db_load_bag_goods() error!", []),
            ?ASSERT(false, _Any),
            []
    end.


%% 从DB加载获取的物品信息列表转为goods结构体
%% TODO: 检验、测试代码的正确性
%% return goods结构体
to_goods_record(InfoList) ->
    [GoodsId, GoodsNo, PlayerId, PartnerId, BindState, UsableTimes, Location, Slot, Count, Quality, FirstUseTime, ValidTime, ExpireTime,
        BaseEquipAdd_BS, AddiEquipAdd_BS, StrenEquipAdd_BS, EquipProp_BS, CustomType, Extra_BS, ShowBaseAttr_BS] = InfoList,  % BS: bitstring

    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    ?ASSERT(GoodsTpl /= null, GoodsNo),

    BaseEquipAdd =  case lib_goods:is_equip(GoodsTpl) of
                    false ->
                        null;  % 非装备则固定为null
                    true ->
                        case util:bitstring_to_term(BaseEquipAdd_BS) of
                            undefined ->
                                %?ASSERT(false, GoodsId),   % 目前这里先断言装备肯定是至少有加成一个属性的，以后如果不合适的话，再删掉此断言。
                                #attrs{};   % 容错，返回空attrs结构体（字段的值都为0）
                            BaseEquipAdd_KV_TupList when is_list(BaseEquipAdd_KV_TupList) ->
                                ?ASSERT(BaseEquipAdd_KV_TupList /= [], GoodsId),
                                lib_attribute:to_attrs_record(BaseEquipAdd_KV_TupList); % 转为attr结构体
                            _Any ->
                                ?ASSERT(false, {_Any, GoodsId}),
                                #attrs{}  % 容错，返回空attrs结构体（字段的值都为0）
                        end
                end,
    ?ASSERT(is_record(BaseEquipAdd, attrs) orelse BaseEquipAdd == null),

    {AddiEquipAdd, AddiEqAddKVL} =  case lib_goods:is_equip(GoodsTpl) of
                    false ->
                        {null, []};  % 非装备则固定为null
                    true ->
                        case util:bitstring_to_term(AddiEquipAdd_BS) of
                            undefined ->
                                %?ASSERT(false, GoodsId),   % 目前这里先断言装备肯定是至少有加成一个属性的，以后如果不合适的话，再删掉此断言。
                                {#attrs{}, []};   % 容错，返回空attrs结构体（字段的值都为0）
                            AddiEpAdd_TupL when is_list(AddiEpAdd_TupL) ->
                                ?ASSERT(AddiEpAdd_TupL /= [], GoodsId),
                                New_AddiEpAdd_TupL = lib_equip:adjust_eq_addi_attr(GoodsNo, AddiEpAdd_TupL),
                                {lib_attribute:to_addi_equip_add_attrs_record(New_AddiEpAdd_TupL), New_AddiEpAdd_TupL}; % 转为attr结构体
                            _Any1 ->
                                ?ASSERT(false, {_Any1, GoodsId}),
                                {#attrs{}, []}  % 容错，返回空attrs结构体（字段的值都为0）
                        end
                end,
    ?ASSERT(is_record(AddiEquipAdd, attrs) orelse AddiEquipAdd == null),

    StrenEquipAdd =  case lib_goods:is_equip(GoodsTpl) of
                    false ->
                        null;  % 非装备则固定为null
                    true ->
                        case util:bitstring_to_term(StrenEquipAdd_BS) of
                            undefined ->
                                #attrs{};   % 容错，返回空attrs结构体（字段的值都为0）
                            StrenEquipAdd_KV_TupList when is_list(StrenEquipAdd_KV_TupList) ->
                                ?ASSERT(StrenEquipAdd_KV_TupList /= [], GoodsId),
                                lib_attribute:to_attrs_record(StrenEquipAdd_KV_TupList); % 转为attr结构体
                            _Any2 ->
                                ?ASSERT(false, {_Any2, GoodsId}),
                                #attrs{}  % 容错，返回空attrs结构体（字段的值都为0）
                        end
                end,
    ?ASSERT(is_record(StrenEquipAdd, attrs) orelse StrenEquipAdd == null),

    EquipProp = case lib_goods:is_equip(GoodsTpl) of
                    false ->
                        null;
                    true ->
                        case util:bitstring_to_term(EquipProp_BS) of
                            undefined ->
                                #equip_prop{}; % 容错
                            EquipProp_KV_TupList when is_list(EquipProp_KV_TupList) ->
                                to_equip_prop_record(EquipProp_KV_TupList); % 转为equip_prop结构体
                            _Any3 ->
                                ?ASSERT(false, {_Any3, GoodsId}),
                                null
                        end
                end,

    Extra = case util:bitstring_to_term(Extra_BS) of
                undefined ->
                    [];
                ExtraInfoList when is_list(ExtraInfoList) ->
                    ?ASSERT(util:is_tuple_list(ExtraInfoList), ExtraInfoList),
                    ExtraInfoList;
                _Any4 ->
                    ?ASSERT(false, {_Any4, GoodsId}),
                    []
            end,

    ShowBaseAttr =case util:bitstring_to_term(ShowBaseAttr_BS) of
                      undefined ->
                          [];
                      ShowBaseInfoList when is_list(ShowBaseInfoList) ->
                          ?ASSERT(util:is_tuple_list(ShowBaseInfoList), ShowBaseInfoList),
                          ShowBaseInfoList;
                      _Any5 ->
                          ?ASSERT(false, {_Any5, GoodsId}),
                          []
                  end,

    AddiEquipEffNo = case lib_goods:is_equip(GoodsTpl) of
        false ->
            null;  % 非装备则固定为null
        true ->
            case lists:keyfind(equip_effect, 1, Extra) of
                false -> 0;
                {_, Lv} -> Lv
            end           
    end,

    % ?ERROR_MSG("AddiEquipEffNo=~p",[AddiEquipEffNo]),

    Goods = #goods{
        id = adust_id(PlayerId, GoodsId),
        no = GoodsNo,
        player_id = PlayerId,
        partner_id = case lib_account:is_global_uni_id(PartnerId) of true -> PartnerId; false -> lib_account:to_global_uni_id(PartnerId) end,
        bind_state = BindState,
        usable_times = UsableTimes,
        location = Location,
        slot = Slot,
        count = Count,
        quality = Quality,
        first_use_time = FirstUseTime,
        valid_time = ValidTime,
        expire_time = ExpireTime,
        base_equip_add = BaseEquipAdd,
        addi_equip_add = AddiEquipAdd,
        addi_ep_add_kv = AddiEqAddKVL,
        stren_equip_add = StrenEquipAdd,
        addi_equip_eff = AddiEquipEffNo,
        equip_prop = EquipProp,
        custom_type = CustomType,
        extra = Extra,
        show_base_attr = ShowBaseAttr
        },


    % 对于处于计时状态中并且未过期的时效物品，则添加一个物品过期的作业计划，同时对于按在线累积时间计时的物品，初始化其time_on_last_save_valid_time字段为当前时间戳
    Goods2 = case lib_goods:is_in_timekeeping(Goods) andalso (not lib_goods:is_expired(Goods)) of
                false ->
                    Goods;
                true ->
                    LeftValidTime = lib_goods:get_left_valid_time(Goods),
                    mod_ply_jobsch:add_schedule(?JSET_GOODS_EXPIRE, LeftValidTime, [PlayerId, GoodsId]),
                    case lib_goods:get_timekeeping_type(Goods) of
                        ?TKP_BY_REAL ->
                            Goods;
                        ?TKP_BY_ACC_ONLINE ->
                            lib_goods:set_time_on_last_save_valid_time(Goods, svr_clock:get_unixtime())
                    end
            end,
    ?ASSERT(is_record(Goods2, goods), Goods2),
    Goods3 = 
        case lib_goods:is_equip(Goods2) of
            true -> 
                BattlePower = lib_equip:calc_battle_power(Goods2),
                Goods2#goods{battle_power = BattlePower};
            false -> Goods2
        end,

    lib_equip:change_equip_stren_attr(Goods3).



adust_id(PlayerId, TId) ->
    Id = 
        case lib_account:is_global_uni_id(TId) of 
            true -> TId; 
            false -> 
                GlobalId = lib_account:to_global_uni_id(TId),
                db:update(PlayerId, goods, ["id"], [GlobalId], "id", TId), 
                GlobalId
        end,
    Id.



%% EquipProp_KV_TupList转为equip_prop结构体
to_equip_prop_record(EquipProp_KV_TupList) ->
    ?ASSERT(util:is_tuple_list(EquipProp_KV_TupList), EquipProp_KV_TupList),
    F = fun({Field, Value}, EquipPropRd) ->
            Index = lib_goods:get_field_index_in_equip_prop(Field),
            setelement(Index, EquipPropRd, Value)
        end,
    lists:foldl(F, #equip_prop{}, EquipProp_KV_TupList).


%% 检查是否可以使用物品（战斗外使用，并且是玩家为自己而使用）
%% @return: {ok, Goods} | {fail, Reason}
check_use_goods(PS, GoodsId_Or_Goods, UseCount) ->
    try check_use_goods__(PS, GoodsId_Or_Goods, UseCount) of
        {ok, Goods} ->  
            {ok, Goods}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

% check_use_goods(PS, GoodsId_Or_Goods) ->
%     check_use_goods(PS, GoodsId_Or_Goods, 1).

%% @return: {ok, Goods} | throw失败原因（由上层去catch）
% 使用物品检测 人物使用
check_use_goods__(PS, GoodsId_Or_Goods, UseCount) ->
	PlayerId = player:get_id(PS),
    Goods =
        case is_integer(GoodsId_Or_Goods) of
            false -> GoodsId_Or_Goods;
            true -> find_goods_by_id_from_whole_inv(player:get_id(PS), GoodsId_Or_Goods)
        end,
  ?DEBUG_MSG("wujiancheng1 ~p~n" ,[{GoodsId_Or_Goods,UseCount}]),
    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    GoodsNo = lib_goods:get_no(Goods),
    GoodsTpl = data_goods:get(GoodsNo),

    ?Ifc (GoodsTpl#goods_tpl.enter_faction =:= 1 andalso player:get_faction(PS) =:= 0)
    throw(?PM_GOODS_CANT_USE_WITHOUT_FACTION)
    ?End,

    % 物品是否可使用？
    ?Ifc (not lib_goods:is_can_use(Goods))
        throw(?PM_GOODS_CANT_USE)
    ?End,
    % 物品是否可用于玩家身上？
    ?Ifc (not lists:member(?OBJ_PLAYER, lib_goods:get_target_obj_type_list(Goods)))
        throw(?PM_GOODS_CANT_USE_ON_PLAYER)
    ?End,

    lib_inv:common_check_use_goods(PS, Goods, UseCount),

    ?Ifc (lib_goods:is_task_goods(Goods) andalso lib_goods:is_trigger_accept_task_goods(Goods) andalso (not lib_inv:can_goods_trigger_accept_task(PS, Goods)))
        throw(?PM_ACCEPTED_TASK_COUNT_LIMIT)
    ?End,

    ?Ifc(lib_goods:get_type(Goods) =:= ?GOODS_T_ROLE_CONSUME andalso lib_goods:get_subtype(Goods) =:= ?ROLE_CONSUME_T_TREASURE andalso player:get_team_id(PS) =/= 0)
        throw(?PM_GOODS_CANT_USE_WHEN_IN_TEAM)
    ?End,

	%% 检查使用消耗是否满足
	CostCurrencyL0 = lib_goods:get_use_cost_money(Goods),
	CostGoodsL0 = lib_goods:get_use_cost_goods(Goods),
	CostCurrencyL = [{T,V*UseCount}||{T,V} <- CostCurrencyL0],
	CostGoodsL = [{T,V*UseCount}||{T,V} <- CostGoodsL0],
	Pred = fun({MoneyType, Num}) ->
				player:has_enough_money(PS, MoneyType, Num)
		   end,
	?Ifc(not lists:all(Pred, CostCurrencyL))
        throw(?PM_MONEY_LIMIT)
    ?End,
	
	?Ifc(mod_inv:check_batch_destroy_goods(PlayerId, CostGoodsL) =/= ok)
        throw(?PM_PAR_EXTEND_CAPACITY_GOODS_COUNT_LIMIT)
    ?End,

    %% 判断内功数量是否超过规定的(这里需要根据物品类型判断)
    IsArtsFull =
        case mod_train:is_art_full() of
            {fail, Reason} -> false;
            ok -> true
        end,
    ?DEBUG_MSG("--------- IsArtsFull --------~p~n", [IsArtsFull]),
    ?Ifc(lib_goods:get_type(Goods) =:= ?GOODS_T_FUN_PROP andalso
        lib_goods:get_subtype(Goods) =:= ?VGOODS_T_ARTS andalso
        (not IsArtsFull))
        throw(?PM_ART_NUM_FULL)
    ?End,

    %% 判断是累充活动是否开启（局限代金券使用）GOODS_T_VIRTUAL
    IsAccumActivity =
        case lists:keymember(3, #admin_sys_activity.sys, ets:tab2list(?ETS_ADMIN_SYS_ACTIVITY)) of
            true ->
                case mod_svr_mgr:check_recharge_accum_activity_open(util:unixtime()) of
                    {true, Activity} when is_record(Activity, recharge_accum) -> true;
                    _ -> false
                end;
            false ->
                false
        end,
    ?Ifc(lib_goods:get_type(Goods) =:= ?GOODS_T_VIRTUAL andalso
        lib_goods:get_subtype(Goods) =:= ?VGOODS_T_VOUCHERS andalso
        (not IsAccumActivity))
        throw(?PM_RECHARGE_ACC_NOT_OPEN)
    ?End,

    CurLv = player:get_lv(PS),

    EffectList = lib_goods:get_effects(Goods),
    EffectCount = length(EffectList),
    EffCfg = 
        case EffectList =:= [] of
            true -> 
                ?WARNING_MSG("mod_inv:use_goods warning! GoodsNo:~p~n", lib_goods:get_no(Goods)),
                null;
            false -> lib_goods_eff:get_cfg_data(erlang:hd(EffectList))
        end,

    EffectName = 
        case EffCfg =:= null of
            true -> null;
            false -> EffCfg#goods_eff.name
        end,

    if 
        EffectCount =:= 0 -> skip; 
        EffectCount > 1 -> 
            ?ERROR_MSG("mod_inv:check_use_goods__ error~p~n", [EffectCount]),
            skip;
        true ->
            ?Ifc (EffectName =:= ?EN_GET_PARTNER andalso lib_goods:is_partner_goods(Goods) andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_GET_PARTNER, UseCount)))
                throw(?PM_PAR_CAPACITY_LIMIT)
            ?End,

            ?Ifc (EffectName =:= ?EN_ADD_WING  andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_ADD_WING, UseCount)))
                throw(?PM_USE_WING_REPEAT)
             ?End,

            ?Ifc (EffectName =:= ?EN_GET_REWARD andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_GET_REWARD, UseCount)))
                throw(?PM_BAG_FULL)
            ?End,

            ?Ifc (EffectName =:= ?EN_FINISH_TASK andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_FINISH_TASK, UseCount)))
                throw(?PM_GOODS_USE_AREA_LIMIT)
            ?End,

            ?Ifc (EffectName =:= ?EN_ADD_HP andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_ADD_HP, UseCount)))
                throw(?PM_HP_IS_FULL)
            ?End,

            ?Ifc (EffectName =:= ?EN_ADD_MP andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_ADD_MP, UseCount)))
                throw(?PM_MP_IS_FULL)
            ?End,

            ?Ifc (EffectName =:= ?EN_RAND_GET_GOODS andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_RAND_GET_GOODS, UseCount)))
                throw(?PM_BAG_FULL)
            ?End,

            ?Ifc (EffectName =:= ?EN_ADD_BUFF andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_ADD_BUFF, UseCount)))
                throw(?PM_BUFF_IS_OVERLAP)
            ?End,

            ?Ifc (EffectName =:= ?EN_RAND_GET_PAR andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_RAND_GET_PAR, UseCount)))
                throw(?PM_PAR_CAPACITY_LIMIT)
            ?End,

            ?Ifc (EffectName =:= ?EN_EXTEND_PAR_CAPACITY andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_EXTEND_PAR_CAPACITY, UseCount)))
                throw(?PM_PAR_CAPACITY_LIMIT)
            ?End,

            ?Ifc (EffectName =:= ?EN_TRIGGER_DIG_TREASURE andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_TRIGGER_DIG_TREASURE, UseCount)))
                throw(?PM_GOODS_DIG_AREA_ERROR)
            ?End,

            ?Ifc (EffectName =:= ?EN_SPAWN_MON andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_SPAWN_MON, UseCount)))
                throw(?PM_GOODS_SPAWN_MON_AREA_ERROR)
            ?End,

            ?Ifc (EffectName =:= ?EN_MARK_FINISH_TASK andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_MARK_FINISH_TASK, UseCount)))
                throw(?PM_TASK_GOODS_CAN_FINISH_NOT_ACCEPTED)
            ?End,

            % 使用道具增加帮派贡献
            ?Ifc (EffectName =:= ?EN_ADD_CONTRI andalso not (player:is_in_guild(PS)  ))
                throw(?PM_NOT_JOIN_GUILD_YET)
            ?End,

            Temp = 
            if
                % 洗点道具判断
                EffectName =:= ?EN_SUB_STR ->
                    Add = EffCfg#goods_eff.para * UseCount,
                    case player:get_base_str(PS) - Add < CurLv of
                        true -> throw(?PM_PAR_BASE_STR_LIMIT);
                        false -> ok
                    end;
                EffectName =:= ?EN_SUB_CON->
                    Add = EffCfg#goods_eff.para * UseCount,
                    case player:get_base_con(PS) - Add < CurLv of
                        true -> throw(?PM_PAR_BASE_CON_LIMIT);
                        false -> ok
                    end;
                EffectName =:= ?EN_SUB_STA ->
                    Add = EffCfg#goods_eff.para * UseCount,
                    case player:get_base_stam(PS) - Add < CurLv of
                        true -> throw(?PM_PAR_BASE_STA_LIMIT);
                        false -> ok
                    end;
                EffectName =:= ?EN_SUB_SPI ->
                    Add = EffCfg#goods_eff.para * UseCount,
                    case player:get_base_spi(PS) - Add < CurLv of
                        true -> throw(?PM_PAR_BASE_SPI_LIMIT);
                        false -> ok
                    end;
                EffectName =:= ?EN_SUB_AGI ->
                    Add = EffCfg#goods_eff.para * UseCount,
                    case player:get_base_agi(PS) - Add < CurLv of
                        true -> throw(?PM_PAR_BASE_AGI_LIMIT);
                        false -> ok
                    end;
                EffectName =:= ?EN_TURN_TALENT_TO_FREE ->
                    NowPeakLv = player:get_peak_lv(PS),     %% 玩家巅峰等级
                    DeltaLv = NowPeakLv + CurLv - ?PLAYER_BORN_LV,   %% 玩家现有等级：正常等级 + 巅峰等级 - 出生等级
                    FreePoint = DeltaLv * 5,
                    case player:get_free_talent_points(PS) =:= FreePoint of
                        true -> throw(?PM_NOT_FREE_WASH_POINT);
                        false -> ok
                    end;
                true -> ok
            end,

            ?Ifc (EffectName =:= ?EN_ACCEPT_TASK andalso not lib_task:have_task(EffCfg#goods_eff.para,PS))
                % case player:is_in_team(PS) of
                %     true -> throw(?PM_F_TASK_CAN_NOT_IN_TEAM);
                     throw(?PM_ACCEPTED_TASK_COUNT_LIMIT)
                % end
            ?End,

            ?Ifc (EffectName =:= ?EN_GET_MOUNTS andalso (not lib_inv:can_get_goods_effect(PS, Goods, ?EN_GET_MOUNTS, UseCount)))
                throw(?PM_YOU_HAVE_MOUNT)
            ?End
    end,

    case lib_goods:get_use_limit(Goods) of
        0 -> {ok, Goods};
        Count when Count > 0 ->
            case ply_misc:get_player_misc(player:get_id(PS)) of
                null ->
                    {ok, Goods};
                PlayerMisc ->
                    CountCmp = 
                        case EffectName of
                            ?EN_ADD_BUFF -> 
                                case data_buff:get(EffCfg#goods_eff.para) of
                                    null -> Count;
                                    BuffCfg ->
                                        case lib_buff_tpl:get_name(BuffCfg) of
                                            ?BFN_ADD_EXP -> lib_vip:welfare(use_multiple_exp_count, PS);
                                            _ -> Count
                                        end
                                end;
                            _ -> Count
                        end,

                    HadUseCount = get_goods_use_count_in_period(Goods, PlayerMisc),
                    case HadUseCount >= CountCmp of
                        true ->
                            case lib_goods:get_use_limit_time(Goods) of
                                1 ->
                                    ply_tips:send_sys_tips(PS, {use_goods_time_over, [<<"日">>, lib_goods:get_no(Goods), lib_goods:get_quality(Goods), 1,lib_goods:get_id(Goods)]}),
                                    throw(?PM_CAN_USE_COUNT_IS_OVER);
                                2 ->
                                    ply_tips:send_sys_tips(PS, {use_goods_time_over, [<<"周">>, lib_goods:get_no(Goods), lib_goods:get_quality(Goods), 1,lib_goods:get_id(Goods)]}),
                                    throw(?PM_CAN_USE_COUNT_IS_OVER);
                                3 ->
                                    ply_tips:send_sys_tips(PS, {use_goods_time_over, [<<"月">>, lib_goods:get_no(Goods), lib_goods:get_quality(Goods), 1,lib_goods:get_id(Goods)]}),
                                    throw(?PM_CAN_USE_COUNT_IS_OVER);
                                _Any -> throw(?PM_PARA_ERROR)
                            end;
                        false ->
							{ok, Goods}
                    end
            end
    end.


%% 获取某个物品在某个时间段已经使用的次数,包括刷新的操作
get_goods_use_count_in_period(Goods, PlayerMisc) ->
    case lists:keyfind(lib_goods:get_no(Goods), 1, PlayerMisc#player_misc.use_goods) of
        false -> 0;
        {GoodsNo, GoodsCount, Time} ->
            TimeType = lib_goods:get_use_limit_time(Goods),
            UseCount =
                if
                    TimeType =:= 1 ->
                        case util:is_same_day(Time) of
                            true -> GoodsCount;
                            false ->
                                GoodsList = lists:keyreplace(GoodsNo, 1, PlayerMisc#player_misc.use_goods, {GoodsNo, 0, Time}),
                                ply_misc:update_player_misc(PlayerMisc#player_misc{use_goods = GoodsList}),
                                0
                        end;
                    TimeType =:= 2 ->
                        case util:is_same_week(Time) of
                            true -> GoodsCount;
                            false ->
                                GoodsList = lists:keyreplace(GoodsNo, 1, PlayerMisc#player_misc.use_goods, {GoodsNo, 0, Time}),
                                ply_misc:update_player_misc(PlayerMisc#player_misc{use_goods = GoodsList}),
                                0
                        end;
                    TimeType =:= 3 ->
                        MonthNow = util:get_month(),
                        {{_Y, M, _D}, _} = util:stamp_to_date(Time, 5),
                        case MonthNow =:= M of
                            true -> GoodsCount;
                            false ->
                                GoodsList = lists:keyreplace(GoodsNo, 1, PlayerMisc#player_misc.use_goods, {GoodsNo, 0, Time}),
                                ply_misc:update_player_misc(PlayerMisc#player_misc{use_goods = GoodsList}),
                                0
                        end;
                    true ->
                        ?ASSERT(false, TimeType), 0
                end,
            UseCount
    end.

% 计时道具处理
extra_handle_for_timging_goods_when_use_it(Goods) ->
    RetGoods =
        case lib_goods:is_timing_goods(Goods) of
            false ->
                Goods;
            true ->
                ?DEBUG_MSG("(~p)(~p)",[lib_goods:get_when_begin_timekeeping(Goods) ,lib_goods:get_first_use_time(Goods)]),

                case lib_goods:get_when_begin_timekeeping(Goods) == ?WBTKP_ON_FIRST_USE
                andalso lib_goods:get_first_use_time(Goods) == 0 of
                    false ->
                        Goods;
                    true ->
                        Goods2 = lib_goods:set_first_use_time(Goods, svr_clock:get_unixtime()),  % 记录第一次使用的时间
                        lib_goods:timekeeping_start(Goods2)  % 开始计时
                end
        end,
    ?ASSERT(is_record(RetGoods, goods)),
    RetGoods.


%% 使用物品（战斗外使用，并且是玩家为自己）
do_use_goods(PS, Goods) ->
    do_use_goods(PS, Goods, 1).

do_use_goods(PS, Goods, UseCount) when is_record(Goods, goods) ->
	LogInfo = [?LOG_GOODS, "use_cost"],
    %% 使用消耗扣除
	CostCurrencyL0 = lib_goods:get_use_cost_money(Goods),
	CostGoodsL0 = lib_goods:get_use_cost_goods(Goods),
	[player:cost_money(PS, MoneyType, CostNum * UseCount, LogInfo)||{MoneyType, CostNum} <- CostCurrencyL0],
	CostGoodsL = [{T,V*UseCount}||{T,V} <- CostGoodsL0],
	mod_inv:destroy_goods_WNC(player:id(PS), CostGoodsL, LogInfo),
	
	lib_goods_eff:apply_effects(for_player, PS, Goods, UseCount),

    Goods1 = extra_handle_for_timging_goods_when_use_it(Goods),

    PlayerId = player:get_id(PS),
    case lib_goods:is_can_stack(Goods1) of
        false ->
            case lib_goods:get_usable_times(Goods1) of  % 剩余可使用次数
                infinite ->
                    %% 记录使用日志
                    case lib_goods:get_statistics_state(Goods1) of
                        0 -> skip;
                        1 -> lib_log:statis_reclaim_goods(player:id(PS), lib_goods:get_id(Goods1), lib_goods:get_no(Goods1), 1, [?LOG_GOODS, "use"])
                    end;
                UsableTimes when UsableTimes > 1 ->
                    ?ASSERT(is_integer(UsableTimes), UsableTimes),
                    Goods_Latest = lib_goods:set_usable_times(Goods1, UsableTimes - 1),
                    mark_dirty_flag(PlayerId, Goods_Latest), % 剩余可使用次数减1
                    lib_inv:notify_cli_goods_info_change(PlayerId, Goods_Latest),
                    %% 关联其他系统
                    lib_task:notify_task_refresh_all_if_change(PS),

                    %% 记录使用日志
                    case lib_goods:get_statistics_state(Goods1) of
                        0 -> skip;
                        1 -> lib_log:statis_reclaim_goods(player:id(PS), lib_goods:get_id(Goods1), lib_goods:get_no(Goods1), 1, [?LOG_GOODS, "use"])
                    end;
                _Other ->
                    ?ASSERT(_Other =:= 1, {_Other, lib_goods:get_no(Goods1)}),
                    destroy_goods_WNC(player:get_id(PS), lib_goods:get_id(Goods1), [?LOG_GOODS, "use"])  % 用完则销毁物品
            end;
        true ->  % 规定：可叠加物品的单个物品的可使用次数固定为1
            CurCount = lib_goods:get_count(Goods1),
            LeftCount = CurCount - UseCount,
            case LeftCount >= 1 of
                true ->
                    Goods_Latest = lib_goods:set_count(Goods1, LeftCount),
                    mark_dirty_flag(PlayerId, Goods_Latest),  % 叠加数量减1
                    lib_inv:notify_cli_goods_info_change(PlayerId, Goods_Latest),
                    %% 关联其他系统
                    lib_task:notify_task_refresh_all_if_change(PS),
                    %% 记录使用日志
                    case lib_goods:get_statistics_state(Goods1) of
                        0 -> skip;
                        1 -> lib_log:statis_reclaim_goods(player:id(PS), lib_goods:get_id(Goods1), lib_goods:get_no(Goods1), UseCount, [?LOG_GOODS, "use"])
                    end;
                false ->
                    destroy_goods_WNC(player:get_id(PS), lib_goods:get_id(Goods1), [?LOG_GOODS, "use"])
            end
    end,
    %% 尝试记录玩家使用某些物品的个数
    case lib_goods:get_use_limit(Goods) of
        0 -> skip;
        _TCount when _TCount > 0 ->
            case ply_misc:get_player_misc(player:get_id(PS)) of
                null ->
                    PlayerMisc = #player_misc{player_id = player:get_id(PS), use_goods = [{lib_goods:get_no(Goods), UseCount, svr_clock:get_unixtime()}]},
                    ply_misc:update_player_misc(PlayerMisc);
                PlayerMisc ->
                    PlayerMisc1 =
                        case lists:keyfind(lib_goods:get_no(Goods), 1, PlayerMisc#player_misc.use_goods) of
                            false ->
                                PlayerMisc#player_misc{use_goods = PlayerMisc#player_misc.use_goods ++ [{lib_goods:get_no(Goods), UseCount, svr_clock:get_unixtime()}]};
                            {GoodsNo1, CountOld, _Time} ->
                                GoodsList = lists:keyreplace(GoodsNo1, 1, PlayerMisc#player_misc.use_goods, {GoodsNo1, CountOld + UseCount, svr_clock:get_unixtime()}),
                                PlayerMisc#player_misc{use_goods = GoodsList}
                        end,
                    ply_misc:update_player_misc(PlayerMisc1)
            end
    end,
    mod_achievement:notify_achi(use_goods, UseCount, [{no, lib_goods:get_no(Goods)}], PS);


%% 使用物品（战斗外使用，并且是玩家为宠物使用）
do_use_goods(PS, PartnerId, Goods) ->
    do_use_goods(PS, PartnerId, Goods, 1).

do_use_goods(PS, PartnerId, Goods, UseCount) ->
    Goods_New = find_goods_by_id_from_whole_inv(player:get_id(PS), lib_goods:get_id(Goods)),
    lib_goods_eff:apply_effects(for_partner, PS, PartnerId, Goods_New, UseCount),

    Goods1 = extra_handle_for_timging_goods_when_use_it(Goods_New),

    PlayerId = player:get_id(PS),
    case lib_goods:is_can_stack(Goods1) of
        false ->
            case lib_goods:get_usable_times(Goods1) of  % 剩余可使用次数
                infinite ->
                    %% 记录使用日志
                    case lib_goods:get_statistics_state(Goods) of
                        0 -> skip;
                        1 -> lib_log:statis_reclaim_goods(player:id(PS), lib_goods:get_id(Goods), lib_goods:get_no(Goods), 1, [?LOG_GOODS, "use"])
                    end;
                UsableTimes when UsableTimes > 1 ->
                    ?ASSERT(is_integer(UsableTimes), UsableTimes),
                    Goods_Latest = lib_goods:set_usable_times(Goods1, UsableTimes - 1),
                    mark_dirty_flag(PlayerId, Goods_Latest), % 剩余可使用次数减1
                    lib_inv:notify_cli_goods_info_change(PlayerId, Goods_Latest),
                    %% 关联其他系统
                    lib_task:notify_task_refresh_all_if_change(PS),
                    %% 记录使用日志
                    case lib_goods:get_statistics_state(Goods) of
                        0 -> skip;
                        1 -> lib_log:statis_reclaim_goods(player:id(PS), lib_goods:get_id(Goods), lib_goods:get_no(Goods), 1, [?LOG_GOODS, "use"])
                    end;
                _Other ->
                    ?ASSERT(_Other =:= 1, _Other),
                    destroy_goods_WNC(player:get_id(PS), lib_goods:get_id(Goods1), [?LOG_GOODS, "use"])  % 用完则销毁物品
            end;
        true ->  % 规定：可叠加物品的单个物品的可使用次数固定为1
            CurCount = lib_goods:get_count(Goods1),
            LeftCount = CurCount - UseCount,
            case LeftCount >= 1 of
                true ->
                    Goods_Latest = lib_goods:set_count(Goods1, LeftCount),
                    mark_dirty_flag(PlayerId, Goods_Latest),  % 叠加数量减1
                    lib_inv:notify_cli_goods_info_change(PlayerId, Goods_Latest),
                    %% 关联其他系统
                    lib_task:notify_task_refresh_all_if_change(PS),
                    %% 记录使用日志
                    case lib_goods:get_statistics_state(Goods1) of
                        0 -> skip;
                        1 -> lib_log:statis_reclaim_goods(player:id(PS), lib_goods:get_id(Goods1), lib_goods:get_no(Goods1), UseCount, [?LOG_GOODS, "use"])
                    end;
                false ->
                    destroy_goods_WNC(player:get_id(PS), lib_goods:get_id(Goods1), [?LOG_GOODS, "use"])
            end
    end.


%% desc: 获取背包物品
%%return: Goods结构体
get_bag_goods_by_id(PlayerId, GoodsId, Location) ->
    find_goods_by_id(PlayerId, GoodsId, Location).


%% desc: 获取仓库的物品
%%return: Goods结构体
get_storage_goods_by_id(PlayerId, GoodsId) ->
    find_goods_by_id(PlayerId, GoodsId, ?LOC_STORAGE).


%% 根据物品位置以及所在格子获取物品
%%return: Goods结构体 | null
find_goods_by_slot(PlayerId, Slot, Location) ->
    case lists:keyfind(Slot, #goods.slot, get_goods_list(PlayerId, Location)) of
        false -> null;
        Goods -> Goods
    end.

%% ExtendSlotNum为要扩充的格子数量
%% return  ok | {fail, Reason}
check_extend_capacity(PS, Location, SlotNum) ->
    Inv = get_inventory(PS#player_status.id),

    HaveGoodsCount = mod_inv:get_goods_count_in_bag_by_no(player:get_id(PS), ?GOODS_NO_UNLOCK_BAG),
    HaveGamemoney = player:get_gamemoney(PS),
    HaveYuanbao = player:get_yuanbao(PS) + player:get_bind_yuanbao(PS),
    NeedGoodsCount =
        if
            Location =:= ?LOC_STORAGE -> %%   ∵第二页全部锁定，开启格子费用为 2万银子或1个蛛皇网,第三页全部锁定，开启格子费用为 40绑金或2个蛛皇网，开启机制同背包                           
                if
                    Inv#inv.storage_capacity >= ?DEF_STORAGE_CAPACITY andalso Inv#inv.storage_capacity < ?DEF_STORAGE_CAPACITY*2 -> %% 第二页
                        case HaveGoodsCount >= SlotNum of
                            true -> SlotNum;
                            false -> HaveGoodsCount
                        end;
                    true -> %% 第三页
                        case HaveGoodsCount >= SlotNum*2 of
                            true -> SlotNum*2;
                            false -> 
                                case util:is_odd(HaveGoodsCount) of
                                    true -> max(HaveGoodsCount-1, 0);
                                    false -> HaveGoodsCount
                                end
                        end
                end;
            true ->
                case HaveGoodsCount >= SlotNum of
                    true -> SlotNum;
                    false -> HaveGoodsCount
                end
        end,

    NeedGamemoney =
        if
            Location =:= ?LOC_STORAGE ->
                if
                    Inv#inv.storage_capacity >= ?DEF_STORAGE_CAPACITY andalso Inv#inv.storage_capacity < ?DEF_STORAGE_CAPACITY*2 ->
                        case HaveGoodsCount >= SlotNum of
                            true -> 0;
                            false -> (SlotNum - HaveGoodsCount) * 20000
                        end;
                    true ->
                        0
                end;
            true ->
                case HaveGoodsCount >= SlotNum of
                    true -> 0;
                    false -> (SlotNum - HaveGoodsCount) * 20000
                end
        end,

    NeedBindYuanbao = 
        if 
            Location =:= ?LOC_STORAGE ->
                if
                    Inv#inv.storage_capacity >= ?DEF_STORAGE_CAPACITY andalso Inv#inv.storage_capacity < ?DEF_STORAGE_CAPACITY*2 ->
                        0;
                    true ->
                        max(util:ceil((SlotNum - NeedGoodsCount/2) * 40), 0)
                end;
            true -> 0
        end,
    
    if
        % 开启位置错误
        Location =/= ?LOC_BAG_EQ andalso Location =/= ?LOC_STORAGE andalso Location =/= ?LOC_BAG_USABLE andalso Location =/= ?LOC_BAG_UNUSABLE ->
            ?ASSERT(false),
            {fail, ?PM_UNKNOWN_ERR};
        SlotNum =< 0 ->
            {fail, ?PM_UNKNOWN_ERR};
        % 背包格子数已达上限
        Location =:= ?LOC_BAG_EQ andalso Inv#inv.bag_eq_capacity + SlotNum > ?MAX_BAG_EQ_CAPACITY ->
            {fail, ?PM_BAG_MAX_CAPACITY_LIMIT};
        Location =:= ?LOC_BAG_USABLE andalso Inv#inv.bag_usable_capacity + SlotNum > ?MAX_BAG_USABLE_CAPACITY ->
            {fail, ?PM_BAG_MAX_CAPACITY_LIMIT};
        Location =:= ?LOC_BAG_UNUSABLE andalso Inv#inv.bag_unusable_capacity + SlotNum > ?MAX_BAG_UNUSABLE_CAPACITY ->
            {fail, ?PM_BAG_MAX_CAPACITY_LIMIT};
        Location =:= ?LOC_STORAGE andalso Inv#inv.storage_capacity + SlotNum > ?MAX_STORAGE_CAPACITY ->
            {fail, ?PM_STORAGE_MAX_CAPACITY_LIMIT};
        %% 不支持仓库跨页开启格子
        Location =:= ?LOC_STORAGE andalso Inv#inv.storage_capacity < ?DEF_STORAGE_CAPACITY*2 andalso Inv#inv.storage_capacity + SlotNum > ?DEF_STORAGE_CAPACITY*2 ->
            {fail, ?PM_PARA_ERROR};
        HaveGoodsCount < 0 ->
            {fail, ?PM_UNKNOWN_ERR};
        % 消耗判断
        HaveGamemoney < NeedGamemoney ->
            {fail, ?PM_GAMEMONEY_LIMIT};
        HaveYuanbao < NeedBindYuanbao ->
            {fail, ?PM_YB_LIMIT};
        true ->
            {ok, NeedGoodsCount, NeedGamemoney, NeedBindYuanbao}
    end.


%% 整理背包
%% Num为格子编号，从1开始
%% [Num, OldGoodsInfo, PS] 传入参数  [1, {}, PS]
%% return [SlotCount, _, PS]
do_arrange_bag(GoodsInfo, [Num, OldGoodsInfo, PS]) ->
    case is_record(OldGoodsInfo, goods) of
        % 与上一格子物品类型(编号)相同
        true when GoodsInfo#goods.no =:= OldGoodsInfo#goods.no
                    andalso GoodsInfo#goods.bind_state =:= OldGoodsInfo#goods.bind_state ->
            MaxStack = lib_goods:get_max_stack(GoodsInfo),
            case MaxStack > 1 andalso (not lib_goods:is_in_timekeeping(GoodsInfo)) 
                andalso 
                    (
                        lib_goods:get_last_sell_time(GoodsInfo) =:= lib_goods:get_last_sell_time(OldGoodsInfo) 
                        orelse 
                        (lib_goods:get_last_sell_time(GoodsInfo) > 0) =:= (lib_goods:get_last_sell_time(OldGoodsInfo) > 0)
                    ) 
                andalso 
                (not lib_goods:is_in_timekeeping(OldGoodsInfo))  of
                % 可叠加   
                true ->
                    [_, NewGoodsNum, _] = update_overlap_goods(OldGoodsInfo, [PS, GoodsInfo#goods.count, MaxStack]),
                    case NewGoodsNum > 0 of
                        % 还有剩余
                        true ->
                            LastSellTime1 = lib_goods:get_last_sell_time(GoodsInfo),
                            LastSellTime2 = lib_goods:get_last_sell_time(OldGoodsInfo),

                            PurchasePrice1 = lib_goods:get_purchase_price(GoodsInfo),
                            PurchasePrice2 = lib_goods:get_purchase_price(OldGoodsInfo),

                            NewGoodsInfo1 = GoodsInfo#goods{slot = Num, count = NewGoodsNum, is_dirty = true},
                            NewGoodsInfo2 = lib_goods:set_purchase_price(NewGoodsInfo1,erlang:min(PurchasePrice1,PurchasePrice2)),

                            NewGoodsInfo = 
                            if 
                                LastSellTime1 > LastSellTime2 -> lib_goods:set_last_sell_time(NewGoodsInfo2,LastSellTime1);
                                LastSellTime1 < LastSellTime2 -> lib_goods:set_last_sell_time(NewGoodsInfo2,LastSellTime2);
                                true -> lib_goods:set_last_sell_time(NewGoodsInfo2,LastSellTime2)
                            end,

                            mark_dirty_flag(player:id(PS), NewGoodsInfo),
                            [Num + 1, NewGoodsInfo, PS];
                        % 没有剩余
                        false ->
                            destroy_goods_WNC(player:id(PS), GoodsInfo, lib_goods:get_count(GoodsInfo), [?LOG_SKIP]),
                            NewGoodsNum1 = OldGoodsInfo#goods.count + GoodsInfo#goods.count,
                            NewOldGoodsInfo1 = OldGoodsInfo#goods{count = NewGoodsNum1},

                            LastSellTime1_ = lib_goods:get_last_sell_time(GoodsInfo),
                            LastSellTime2_ = lib_goods:get_last_sell_time(OldGoodsInfo),

                            % NewGoodsInfo1 = GoodsInfo#goods{slot = Num, count = NewGoodsNum, is_dirty = true},
                            NewOldGoodsInfo = 
                            if 
                                LastSellTime1_ > LastSellTime2_ -> lib_goods:set_last_sell_time(NewOldGoodsInfo1,LastSellTime1_);
                                LastSellTime1_ < LastSellTime2_ -> lib_goods:set_last_sell_time(NewOldGoodsInfo1,LastSellTime2_);
                                true -> lib_goods:set_last_sell_time(NewOldGoodsInfo1,LastSellTime2_)
                            end,

                            [Num, NewOldGoodsInfo, PS]
                    end;
                % 不可叠加
                false ->
                    NewGoodsInfo = GoodsInfo#goods{location = lib_goods:get_location(GoodsInfo), slot = Num},
                    mark_dirty_flag(player:id(PS), NewGoodsInfo),
                    [Num + 1, NewGoodsInfo, PS]
            end;
        % 与上一格子物品类型不同
        true ->
            NewGoodsInfo = GoodsInfo#goods{location = lib_goods:get_location(GoodsInfo), slot = Num},
            mark_dirty_flag(player:id(PS), NewGoodsInfo),
            [Num + 1, NewGoodsInfo, PS];
        % 第一格
        false ->
            NewGoodsInfo = GoodsInfo#goods{location = lib_goods:get_location(GoodsInfo), slot = Num},
            mark_dirty_flag(player:id(PS), NewGoodsInfo),
            [Num + 1, NewGoodsInfo, PS]
    end.


%% 更新原有的可叠加物品
%% Count->物品数量
update_overlap_goods(GoodsInfo, [PS, Count, MaxStack]) ->
    case Count > 0 of
        true when GoodsInfo#goods.count =/= MaxStack andalso MaxStack > 0 ->
            case Count + GoodsInfo#goods.count > MaxStack of
                % 总数超出可叠加数
                true ->
                    OldCount = MaxStack,
                    NewCount = Count + GoodsInfo#goods.count - MaxStack;
                false ->
                    OldCount = Count + GoodsInfo#goods.count,
                    NewCount = 0
            end,
            NewGoodsInfo = GoodsInfo#goods{count = OldCount},
            mark_dirty_flag(player:id(PS), NewGoodsInfo);
        true ->
            NewCount = Count;
        false ->
            NewCount = 0
    end,
    [PS, NewCount, MaxStack].


%% internal
%% desc: 根据location选择对应的空格子编号列表
get_empty_slot_list(PlayerId, Location) ->
    Inv = get_inventory(PlayerId),
    case Location of
        ?LOC_BAG_EQ ->
            List = [Goods#goods.slot || Goods <- get_goods_list(PlayerId, Location), Goods#goods.location == ?LOC_BAG_EQ],
            lists:seq(1, Inv#inv.bag_eq_capacity) -- List;
        ?LOC_STORAGE ->
            List = [Goods#goods.slot || Goods <- get_goods_list(PlayerId, Location), Goods#goods.location == ?LOC_STORAGE],
            lists:seq(1, Inv#inv.storage_capacity) -- List;
        ?LOC_BAG_USABLE ->
            List = [Goods#goods.slot || Goods <- get_goods_list(PlayerId, Location), Goods#goods.location == ?LOC_BAG_USABLE],
            lists:seq(1, Inv#inv.bag_usable_capacity) -- List;
        ?LOC_BAG_UNUSABLE ->
            List = [Goods#goods.slot || Goods <- get_goods_list(PlayerId, Location), Goods#goods.location == ?LOC_BAG_UNUSABLE],
            lists:seq(1, Inv#inv.bag_unusable_capacity) -- List;
        _ -> []
    end.


%% exports
%% desc: 智能添加一个新物品(智能的意思是会自动处理叠加)
%% SlotList是空格子列表
%% AccGoods : [{GoodsId, GoodsNo, Count} ...]
smart_add_new_goods(GoodsNo, {PlayerId, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, ExtraInitInfoList, LogInfo, AccGoods}) when is_integer(GoodsNo) ->
    smart_add_new_goods({GoodsNo, 1}, {PlayerId, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, ExtraInitInfoList, LogInfo, AccGoods});
%%添加指定数量的物品
smart_add_new_goods({_GoodsNo, 0}, Acc) ->
    Acc;
smart_add_new_goods({GoodsNo, Count}, {PlayerId, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, ExtraInitInfoList, LogInfo, AccGoods}) ->
    case lib_goods:get_tpl_data(GoodsNo) of
        null ->
            ?ERROR_MSG("mod_inv:smart_add_new_goods(),GoodsNo :~p not exist!~n", [GoodsNo]),
            {PlayerId, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, ExtraInitInfoList, LogInfo, AccGoods};
        GoodsTpl ->
            TempCount = erlang:min(Count, lib_goods:get_max_stack(GoodsTpl)),
            Goods1 = lib_goods:make_new_goods(PlayerId, GoodsNo, TempCount, ExtraInitInfoList),
            % 增加判断如果不是装备则无视特技
            Goods = case lib_goods:is_equip(Goods1) of 
                true -> 
                    Goods2 = lib_goods:set_equip_effect(Goods1,Goods1#goods.addi_equip_eff),
                    Goods3 = lib_goods:check_maker_name(Goods2, <<"system">>),

                    mark_dirty_flag(PlayerId, Goods3),
                    Goods3;
                false -> 
                    Goods1
            end, 

            case TempCount > 0 of
                true ->
                    ?TRACE("make_new_goods:~p~n", [Goods]),
                    MaxStack = lib_goods:get_max_stack(Goods),
                    case MaxStack >= Count of
                        true ->
                            {LeftBagEQSlotL, LeftBagUSSlotL, LeftBagUNUSSlotL, RetGoods} = do_smart_add_new_goods(Goods, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, MaxStack),
                            % %% 关联其他系统
                            Event = [buy, drop_kill, drop_kill_dark, collect, catch_pet],
                            case player:get_PS(PlayerId) of
                                null -> skip;
                                PS -> [lib_event:event(E, [GoodsNo, TempCount], PS) || E <- Event]
                            end,

                            F = fun({GoodsIdAdd, GoodsNoAdd, CountAdd}, Acc) ->
                                case lib_goods:get_statistics_state(GoodsTpl) of
                                    0 -> skip;
                                    1 -> lib_log:statis_produce_goods(PlayerId, GoodsIdAdd, GoodsNoAdd, CountAdd, LogInfo)
                                end,
                                case lists:keyfind(GoodsIdAdd, 1, Acc) of
                                    false -> [{GoodsIdAdd, GoodsNoAdd, CountAdd} | Acc];
                                    {GoodsIdAdd1, GoodsNoAdd1, CountAdd1} ->
                                        lists:keyreplace(GoodsIdAdd1, 1, Acc, {GoodsIdAdd1, GoodsNoAdd1, CountAdd1 + CountAdd})
                                end
                            end,
                            AccGoods1 = lists:foldl(F, AccGoods, RetGoods),
                            {PlayerId, LeftBagEQSlotL, LeftBagUSSlotL, LeftBagUNUSSlotL, ExtraInitInfoList, LogInfo, AccGoods1};
                        false ->
                            {LeftBagEQSlotL, LeftBagUSSlotL, LeftBagUNUSSlotL, RetGoods} = do_smart_add_new_goods(Goods, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, MaxStack),

                            %% 关联其他系统
                            Event = [buy, drop_kill, drop_kill_dark, collect, catch_pet],
                            case player:get_PS(PlayerId) of
                                null -> skip;
                                PS -> [lib_event:event(E, [GoodsNo, TempCount], PS) || E <- Event]
                            end,

                            F = fun({GoodsIdAdd, GoodsNoAdd, CountAdd}, Acc) ->
                                case lib_goods:get_statistics_state(GoodsTpl) of
                                    0 -> skip;
                                    1 -> lib_log:statis_produce_goods(PlayerId, GoodsIdAdd, GoodsNoAdd, CountAdd, LogInfo)
                                end,
                                case lists:keyfind(GoodsIdAdd, 1, Acc) of
                                    false -> [{GoodsIdAdd, GoodsNoAdd, CountAdd} | Acc];
                                    {GoodsIdAdd1, GoodsNoAdd1, CountAdd1} ->
                                        lists:keyreplace(GoodsIdAdd1, 1, Acc, {GoodsIdAdd1, GoodsNoAdd1, CountAdd1 + CountAdd})
                                end
                            end,
                            AccGoods1 = lists:foldl(F, AccGoods, RetGoods),

                            smart_add_new_goods({GoodsNo, Count - MaxStack}, {PlayerId, LeftBagEQSlotL, LeftBagUSSlotL, LeftBagUNUSSlotL, ExtraInitInfoList, LogInfo, AccGoods1})
                    end;
                false ->
                    ?TRACE("mod_inv:smart_add_new_goods() para or config error!~n", []),
                    ?ASSERT(false),
                    ?ERROR_MSG("badarg GoodsNo:~p, Num:~p", [GoodsNo, TempCount]),
                    {PlayerId, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, ExtraInitInfoList, LogInfo, AccGoods}
            end
    end;
smart_add_new_goods(_, {PlayerId, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, ExtraInitInfoList, LogInfo, AccGoods}) ->
    {PlayerId, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, ExtraInitInfoList, LogInfo, AccGoods}.


%% internal
%% desc: 给与物品中间操作 自动叠加
do_smart_add_new_goods(Goods, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, MaxStack) ->
    GoodsList = find_all_goods_in_bag_by_no(lib_goods:get_owner_id(Goods), lib_goods:get_no(Goods)),
    GoodsBindState = lib_goods:get_bind_state(Goods),
    % 获取未满物品且物品状态(绑定与非绑定)与要添加的物品状态一致的物品列表
    NotStackFullGoodsList = get_not_stack_full_list(GoodsList, MaxStack, GoodsBindState),
    SortedGoodsList = lib_inv:sort_goods(NotStackFullGoodsList, sort_by_slot),
    % 自动补满物品
    ?TRACE("do_smart_add_new_goods SortedGoodsList: ~p~n", [SortedGoodsList]),
    add_stackable_goods_count(SortedGoodsList, Goods, MaxStack, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, Goods#goods.player_id, []).


%% 把已有的物品（在玩家非背包位置或者邮件附件）智能添加到背包（包含可堆叠效果）
smart_add_goods(PlayerId, Goods) ->
    GoodsList = find_all_goods_in_bag_by_no(PlayerId, lib_goods:get_no(Goods)),
    BindState = lib_goods:get_bind_state(Goods),
    MaxStack = lib_goods:get_max_stack(Goods),

    LastSellTime = lib_goods:get_last_sell_time(Goods),
    PurchasePrice = lib_goods:get_purchase_price(Goods),
 
    ?DEBUG_MSG("LastSellTime=~p",[LastSellTime]),

    % 获取未满物品且物品状态(绑定与非绑定)与要添加的物品状态一致的物品列表
    NotStackFullGoodsList = case LastSellTime of 
        0 ->
            case PurchasePrice of
                0 ->
                    get_not_stack_full_list(GoodsList, MaxStack, BindState);
                _ ->
                    []
            end;
        _ ->
            []
    end,
    SortedGoodsList = lib_inv:sort_goods(NotStackFullGoodsList, sort_by_slot),

    % 自动补满物品
    NullBagEQSlotL = get_empty_slot_list(PlayerId, ?LOC_BAG_EQ),
    NullBagUSSlotL = get_empty_slot_list(PlayerId, ?LOC_BAG_USABLE),
    NullBagUNUSSlotL = get_empty_slot_list(PlayerId, ?LOC_BAG_UNUSABLE),
    add_stackable_goods(SortedGoodsList, Goods, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, PlayerId).


%% desc: 筛选未达到叠加上限且物品状态(绑定与非绑定)与要添加的物品状态一致 且 不处于计时中 的物品列表（同一种编号的物品中选取）
get_not_stack_full_list(GoodsList, MaxStack, GoodsBindState) ->
    lists:filter(fun(Goods) -> 
        lib_goods:get_count(Goods) < MaxStack andalso
    lib_goods:get_bind_state(Goods) =:= GoodsBindState andalso 
    lib_goods:get_last_sell_time(Goods) =:= 0 
    andalso (not lib_goods:is_in_timekeeping(Goods)) 
end, GoodsList).


%% internal
%% desc: 自动补充物品数量
%% para1->已排序的未满的物品列表；para2->要添加的Goods，para3->要添加物品的最大堆叠数；para4->空格子列表
%% para5-> 玩家id
add_stackable_goods_count(_, Goods, _MaxStack, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, _PlayerId, RetGoods) when Goods#goods.count =:= 0 ->
    {NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, RetGoods};
%% 没有位置可以填充物品了
add_stackable_goods_count([], Goods, _MaxStack, [], [], [], PlayerId, RetGoods) ->
    %% 尝试放入临时背包中
    Inv = get_inventory(PlayerId),
    GoodsCount = length(Inv#inv.temp_bag_goods),
    case GoodsCount =:= ?MAX_TEMPORARY_BAG_CAPACITY of
        true ->
            try_add_to_mail(PlayerId, Goods),
            lib_send:send_prompt_msg(PlayerId, ?PM_TEMP_BAG_FULL),
            {[], [], [], RetGoods};
        false ->
            Goods1 = lib_goods:set_location(Goods, ?LOC_TEMP_BAG),
            {GoodsId, GoodsNo, Count} = add_new_goods_to_bag(PlayerId, lib_goods:set_slot(Goods1, find_first_empty_slot(PlayerId, ?LOC_TEMP_BAG))),
            RetGoods1 =
                case lists:keyfind(GoodsId, 1, RetGoods) of
                    false -> [{GoodsId, GoodsNo, Count} | RetGoods];
                    {GoodsId1, GoodsNo1, Count1} -> lists:keyreplace(GoodsId, 1, RetGoods, {GoodsId1, GoodsNo1, Count + Count1})
                end,

            {[], [], [], RetGoods1}
    end;

add_stackable_goods_count([], Goods, _MaxStack, [], NullBagUSSlotL, NullBagUNUSSlot, PlayerId, RetGoods) when Goods#goods.location =:= ?LOC_BAG_EQ ->

    Inv = get_inventory(PlayerId),
    GoodsCount = length(Inv#inv.temp_bag_goods),
    case GoodsCount =:= ?MAX_TEMPORARY_BAG_CAPACITY of
        true ->
            try_add_to_mail(PlayerId, Goods),
            lib_send:send_prompt_msg(PlayerId, ?PM_TEMP_BAG_FULL),
            {[], NullBagUSSlotL, NullBagUNUSSlot, RetGoods};
        false ->
            Goods1 = lib_goods:set_location(Goods, ?LOC_TEMP_BAG),
            {GoodsId, GoodsNo, AddCount} = add_new_goods_to_bag(PlayerId, lib_goods:set_slot(Goods1, find_first_empty_slot(PlayerId, ?LOC_TEMP_BAG))),
            RetGoods1 =
                case lists:keyfind(GoodsId, 1, RetGoods) of
                    false -> [{GoodsId, GoodsNo, AddCount} | RetGoods];
                    {GoodsId1, GoodsNo1, Count1} -> lists:keyreplace(GoodsId, 1, RetGoods, {GoodsId1, GoodsNo1, AddCount + Count1})
                end,
            {[], NullBagUSSlotL, NullBagUNUSSlot, RetGoods1}
    end;

add_stackable_goods_count([], Goods, _MaxStack, NullBagEQSlotL, [], NullBagUNUSSlotL, PlayerId, RetGoods) when Goods#goods.location =:= ?LOC_BAG_USABLE ->
    Inv = get_inventory(PlayerId),
    GoodsCount = length(Inv#inv.temp_bag_goods),
    case GoodsCount =:= ?MAX_TEMPORARY_BAG_CAPACITY of
        true ->
            try_add_to_mail(PlayerId, Goods),
            lib_send:send_prompt_msg(PlayerId, ?PM_TEMP_BAG_FULL),
            {NullBagEQSlotL, [], NullBagUNUSSlotL, RetGoods};
        false ->
            Goods1 = lib_goods:set_location(Goods, ?LOC_TEMP_BAG),
            {GoodsId, GoodsNo, AddCount} = add_new_goods_to_bag(PlayerId, lib_goods:set_slot(Goods1, find_first_empty_slot(PlayerId, ?LOC_TEMP_BAG))),
            RetGoods1 =
                case lists:keyfind(GoodsId, 1, RetGoods) of
                    false -> [{GoodsId, GoodsNo, AddCount} | RetGoods];
                    {GoodsId1, GoodsNo1, Count1} -> lists:keyreplace(GoodsId, 1, RetGoods, {GoodsId1, GoodsNo1, AddCount + Count1})
                end,
            {NullBagEQSlotL, [], NullBagUNUSSlotL, RetGoods1}
    end;

add_stackable_goods_count([], Goods, _MaxStack, NullBagEQSlotL, NullBagUSSlotL, [], PlayerId, RetGoods) when Goods#goods.location =:= ?LOC_BAG_UNUSABLE ->
    Inv = get_inventory(PlayerId),
    GoodsCount = length(Inv#inv.temp_bag_goods),
    case GoodsCount =:= ?MAX_TEMPORARY_BAG_CAPACITY of
        true -> 
            try_add_to_mail(PlayerId, Goods),
            lib_send:send_prompt_msg(PlayerId, ?PM_TEMP_BAG_FULL),
            {NullBagEQSlotL, NullBagUSSlotL, [], RetGoods};
        false ->
            Goods1 = lib_goods:set_location(Goods, ?LOC_TEMP_BAG),
            {GoodsId, GoodsNo, AddCount} = add_new_goods_to_bag(PlayerId, lib_goods:set_slot(Goods1, find_first_empty_slot(PlayerId, ?LOC_TEMP_BAG))),
            RetGoods1 =
                case lists:keyfind(GoodsId, 1, RetGoods) of
                    false -> [{GoodsId, GoodsNo, AddCount} | RetGoods];
                    {GoodsId1, GoodsNo1, Count1} -> lists:keyreplace(GoodsId, 1, RetGoods, {GoodsId1, GoodsNo1, AddCount + Count1})
                end,
            {NullBagEQSlotL, NullBagUSSlotL, [], RetGoods1}
    end;

%% 此编号物品没满的格子列表为空的情况，要占用一个新的空格子
add_stackable_goods_count([], Goods, _MaxStack, [Slot | LeftBagEQSlotL], NullBagUSSlotL, NullBagUNUSSlot, PlayerId, RetGoods) when Goods#goods.location =:= ?LOC_BAG_EQ ->
    {GoodsId, GoodsNo, Count} = add_new_goods_to_bag(PlayerId, lib_goods:set_slot(Goods, Slot)),
    RetGoods1 =
        case lists:keyfind(GoodsId, 1, RetGoods) of
            false -> [{GoodsId, GoodsNo, Count} | RetGoods];
            {GoodsId1, GoodsNo1, Count1} -> lists:keyreplace(GoodsId, 1, RetGoods, {GoodsId1, GoodsNo1, Count + Count1})
        end,
    {LeftBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlot, RetGoods1};
%% 此编号物品没满的格子列表为空的情况，要占用一个新的空格子
add_stackable_goods_count([], Goods, _MaxStack, NullBagEQSlotL, [Slot | LeftBagUSSlotL], NullBagUNUSSlot, PlayerId, RetGoods) when Goods#goods.location =:= ?LOC_BAG_USABLE ->
    {GoodsId, GoodsNo, Count} = add_new_goods_to_bag(PlayerId, lib_goods:set_slot(Goods, Slot)),
    RetGoods1 =
        case lists:keyfind(GoodsId, 1, RetGoods) of
            false -> [{GoodsId, GoodsNo, Count} | RetGoods];
            {GoodsId1, GoodsNo1, Count1} -> lists:keyreplace(GoodsId, 1, RetGoods, {GoodsId1, GoodsNo1, Count + Count1})
        end,
    {NullBagEQSlotL, LeftBagUSSlotL, NullBagUNUSSlot, RetGoods1};

add_stackable_goods_count([], Goods, _MaxStack, NullBagEQSlotL, NullBagUSSlotL, [Slot | LeftBagUNUSSlotL], PlayerId, RetGoods) when Goods#goods.location =:= ?LOC_BAG_UNUSABLE ->
    {GoodsId, GoodsNo, Count} = add_new_goods_to_bag(PlayerId, lib_goods:set_slot(Goods, Slot)),
    RetGoods1 =
        case lists:keyfind(GoodsId, 1, RetGoods) of
            false -> [{GoodsId, GoodsNo, Count} | RetGoods];
            {GoodsId1, GoodsNo1, Count1} -> lists:keyreplace(GoodsId, 1, RetGoods, {GoodsId1, GoodsNo1, Count + Count1})
        end,
    {NullBagEQSlotL, NullBagUSSlotL, LeftBagUNUSSlotL, RetGoods1};

add_stackable_goods_count([Goods | T], Info, MaxStack, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, PlayerId, RetGoods) ->
    Count = lib_goods:get_count(Info),
    %% 计算补充一格后，剩余的数量
    [CurGoodsCount, LeftGoods] =
    case lib_goods:get_count(Goods) + Count > MaxStack of
        true ->
            Lft = Info#goods{count = lib_goods:get_count(Goods) + Count - MaxStack},
            [MaxStack, Lft];
        false ->
            [lib_goods:get_count(Goods) + Count, Info#goods{count = 0}]
    end,
    %% 修改物品数量
    mark_dirty_flag(PlayerId, Goods#goods{count = CurGoodsCount}),
    lib_inv:notify_cli_goods_info_change(PlayerId, Goods#goods{count = CurGoodsCount}),
    ply_tips:notify_gain_item(PlayerId, lib_goods:get_type(Goods), lib_goods:get_id(Goods), lib_goods:get_no(Goods), CurGoodsCount - lib_goods:get_count(Goods)),

    {GoodsIdAdd, GoodsNoAdd, CountAdd} = {lib_goods:get_id(Goods), lib_goods:get_no(Goods), CurGoodsCount - lib_goods:get_count(Goods)},
    RetGoods1 =
        case lists:keyfind(GoodsIdAdd, 1, RetGoods) of
            false -> [{GoodsIdAdd, GoodsNoAdd, CountAdd} | RetGoods];
            {GoodsId1, GoodsNo1, Count1} -> lists:keyreplace(GoodsIdAdd, 1, RetGoods, {GoodsId1, GoodsNo1, CountAdd + Count1})
        end,

    add_stackable_goods_count(T, LeftGoods, MaxStack, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, PlayerId, RetGoods1).


%% 检查是否可以搬移物品
%% return {ok, Goods} | {fail, Reason}
check_move_goods(PlayerId, GoodsId, Count, ToLoc) ->
    try check_move_goods__(PlayerId, GoodsId, Count, ToLoc) of
        {ok, Goods} ->
            {ok, Goods}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_move_goods__(PlayerId, GoodsId, Count, ToLoc) ->
    ?Ifc (Count =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Goods = find_goods_by_id_from_whole_inv_except_EQP(PlayerId, GoodsId),
    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (lib_goods:get_count(Goods) < Count)
        throw(?PM_GOODS_NOT_ENOUGH)
    ?End,

    GoodsLoc = lib_goods:get_location(Goods),
    ?Ifc (ToLoc =:= ?LOC_STORAGE andalso GoodsLoc =:= ?LOC_STORAGE)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (ToLoc =/= ?LOC_STORAGE andalso GoodsLoc =/= ?LOC_STORAGE)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (lib_goods:get_owner_id(Goods) =/= PlayerId)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (ToLoc =:= ?LOC_STORAGE andalso (not lib_goods:is_can_store(Goods)))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (ToLoc =:= ?LOC_STORAGE andalso GoodsLoc =/= ?LOC_BAG_EQ andalso GoodsLoc =/= ?LOC_BAG_USABLE andalso GoodsLoc =/= ?LOC_BAG_UNUSABLE)
        throw(?PM_PARA_ERROR)
    ?End,

    % 背包或仓库是否满了？
    ToLoc1 = 
        case ToLoc of
            ?LOC_STORAGE -> ToLoc;
            _ -> lib_goods:decide_bag_location(Goods)
        end,

    case ToLoc1 of
        ?LOC_BAG_EQ ->
            case is_bag_eq_full(PlayerId) of
                true -> throw(?PM_EQ_BAG_FULL);
                false -> {ok, Goods}
            end;
        ?LOC_BAG_USABLE ->
            case is_bag_usable_full(PlayerId) of
                true -> throw(?PM_US_BAG_FULL);
                false -> {ok, Goods}
            end;
        ?LOC_BAG_UNUSABLE ->
            case is_bag_unusable_full(PlayerId) of
                true -> throw(?PM_UNUS_BAG_FULL);
                false -> {ok, Goods}
            end;
        ?LOC_STORAGE ->
            case is_storage_full(PlayerId) of
                true -> throw(?PM_STORAGE_FULL);
                false -> {ok, Goods}
            end
    end.


%% 执行搬移物品的处理（背包 -> 仓库，或者：仓库 -> 背包）
%% return {ok, NewSlot}
do_move_goods(PlayerId, Goods, Count, TryToLoc) ->
    Location = lib_goods:get_location(Goods),
    FromLoc = Location,
    ToLoc = 
        case TryToLoc of
            ?LOC_STORAGE -> TryToLoc;
            _ -> lib_goods:decide_bag_location(Goods)
        end,

    if
        (FromLoc == ?LOC_BAG_EQ orelse FromLoc == ?LOC_BAG_USABLE orelse FromLoc == ?LOC_BAG_UNUSABLE) andalso ToLoc == ?LOC_STORAGE ->  % 从背包到仓库
            ToSlot = find_first_empty_slot(PlayerId, ?LOC_STORAGE),
            do_move_goods_from_bag_to_sto(PlayerId, Goods, Count, ToSlot);
        FromLoc == ?LOC_STORAGE andalso (ToLoc == ?LOC_BAG_EQ orelse ToLoc == ?LOC_BAG_USABLE orelse ToLoc == ?LOC_BAG_UNUSABLE) ->  % 从仓库到背包
            do_move_goods_from_sto_to_bag(PlayerId, Goods, Count)
    end.


%% 搬移物品：背包 -> 仓库
do_move_goods_from_bag_to_sto(PlayerId, Goods, Count, ToSlot) ->
    %% 从背包移除物品
    mod_inv:remove_goods_from_bag(PlayerId, Goods),
    lib_inv:notify_cli_goods_destroyed_from_bag(PlayerId, lib_goods:get_id(Goods), lib_goods:decide_bag_location(Goods)),

    %% 放物品到仓库
    Goods2 = lib_goods:set_location(Goods, ?LOC_STORAGE), % location改为仓库
    Goods3 = lib_goods:set_slot(Goods2, ToSlot),  % 设置新的slot
    Goods4 = lib_goods:set_count(Goods3, Count),
    % 加到仓库栏
    Inv = get_inventory(PlayerId),
    Inv2 = add_goods_2__(Inv, Goods4, ?LOC_STORAGE),
    Inv3 = 
        case lib_goods:is_equip(Goods4) of
            false -> Inv2;
            true ->
                GemIdList = lib_goods:get_gem_id_list(Goods4),
                %% 改变宝石位置
                F = fun(Id) ->
                    case get_goods_from_ets(Id) of
                        null ->
                            ?ASSERT(false),
                            skip;
                        GemGoods ->
                            GemGoods1 = lib_goods:set_location(GemGoods, ?LOC_STORAGE),
                            GemGoods2 = lib_goods:set_dirty(GemGoods1, true),                
                            mod_inv:update_goods_to_ets(GemGoods2)
                    end
                end,
                [F(X) || X <- GemIdList],

                NewStoGoodsList = Inv2#inv.storage_goods ++ GemIdList,
                Inv2#inv{storage_goods = sets:to_list(sets:from_list(NewStoGoodsList))}
        end,

    update_inventory_to_ets(Inv3),

    mod_inv:mark_dirty_flag(PlayerId, Goods4),
    lib_inv:notify_cli_goods_added_to_bag(PlayerId, Goods4),

    case lib_goods:get_count(Goods) > Count of
        true ->
            %% 剩余的放背包
            GoodsLeft = lib_goods:set_count(Goods, lib_goods:get_count(Goods) - Count),
            GoodsLeft1 = lib_goods:set_slot(GoodsLeft, ?INVALID_NO),
            NewGoodsId = lib_goods:db_insert_new_goods(GoodsLeft1),
            GoodsLeft2 = lib_goods:set_id(GoodsLeft1, NewGoodsId),
            mod_inv:smart_add_goods(PlayerId, GoodsLeft2);
        false ->
            skip
    end,
    ok.


%% 搬移物品：仓库 -> 背包
do_move_goods_from_sto_to_bag(PlayerId, Goods, Count) ->
    ?ASSERT(lib_goods:get_location(Goods) == ?LOC_STORAGE),
    
    lib_inv:notify_cli_goods_destroyed_from_bag(PlayerId, lib_goods:get_id(Goods), ?LOC_STORAGE),

    %%仓库移动到背包触发师门任务
    Event = [buy, drop_kill, drop_kill_dark, collect, catch_pet],
    case player:get_PS(PlayerId) of
        null -> skip;
        PS -> 
            [lib_event:event(E, [lib_goods:get_no(Goods), lib_goods:get_count(Goods)], PS) || E <- Event]
    end,

    %% 加物品到背包
    Location = lib_goods:decide_bag_location(Goods),
    Goods1 = lib_goods:set_count(Goods, Count), 
    Goods2 = lib_goods:set_location(Goods1, Location),
    Goods3 = lib_goods:set_slot(Goods2, ?INVALID_NO),
    mod_inv:smart_add_goods(PlayerId, Goods3),

    % 从仓库移除
    Inv = get_inventory(PlayerId),
    Inv2 = remove_goods_2__(Inv, lib_goods:get_id(Goods), ?LOC_STORAGE),
    Inv3 = 
        case lib_goods:is_equip(Goods3) of
            false -> Inv2;
            true ->
                GemIdList = lib_goods:get_gem_id_list(Goods3),
                %% 改变宝石位置
                F = fun(Id) ->
                    case get_goods_from_ets(Id) of
                        null ->
                            ?ASSERT(false),
                            skip;
                        GemGoods ->
                            GemGoods1 = lib_goods:set_location(GemGoods, ?LOC_BAG_EQ),
                            GemGoods2 = lib_goods:set_dirty(GemGoods1, true),                
                            mod_inv:update_goods_to_ets(GemGoods2)
                    end
                end,
                [F(X) || X <- GemIdList],

                NewStoGoodsList = Inv2#inv.storage_goods -- GemIdList,
                Inv2#inv{storage_goods = sets:to_list(sets:from_list(NewStoGoodsList))}
        end,
        
    case lib_goods:get_count(Goods) > Count of
        true ->
            %% 剩余的继续留在仓库
            GoodsLeft = lib_goods:set_count(Goods, lib_goods:get_count(Goods) - Count),
            NewGoodsId = lib_goods:db_insert_new_goods(GoodsLeft),
            GoodsLeft2 = lib_goods:set_id(GoodsLeft, NewGoodsId),
            Inv4 = add_goods_2__(Inv3, GoodsLeft2, ?LOC_STORAGE),
            update_inventory_to_ets(Inv4),

            mod_inv:mark_dirty_flag(PlayerId, GoodsLeft2),
            lib_inv:notify_cli_goods_added_to_bag(PlayerId, GoodsLeft2);
        false ->
            update_inventory_to_ets(Inv3)
    end,
    ok.


get_goods_list_by_id_list(GoodsIdList) ->
    case length(GoodsIdList) == 0 of
        true -> [];
        false ->
            F = fun(GoodsId, Acc) ->
                    case get_goods_from_ets(GoodsId) of
                        null -> Acc;
                        Goods ->
				% 这里可能有问题
                            case lib_goods:get_slot(Goods) =:= 0 of
                                true -> % 宝石
                                    Acc;
                                false -> 
                                    [Goods | Acc]
                            end
                    end
                end,
            lists:foldl(F, [], GoodsIdList)
    end.


%% 更新物品信息到物品栏（注意：需确保传入的物品对象是当前最新的goods结构体!!!）
update_goods_to_inv(PlayerId, Goods_Latest) ->
    ?ASSERT(is_record(Goods_Latest, goods), Goods_Latest),
    Inv = get_inventory(PlayerId),

    case lib_goods:get_location(Goods_Latest) of
        ?LOC_BAG_EQ ->
            % ?ASSERT(lists:member(Goods_Latest#goods.id, Inv#inv.eq_goods) /= false),此断言已经不适用 对背包的装备宝石镶嵌
            update_goods_to_ets(Goods_Latest),
            %% 宝石镶嵌在背包的装备时，宝石相当于位于装备背包了
            case lists:member(Goods_Latest#goods.id, Inv#inv.eq_goods) of
                true -> skip;
                false ->
                    NewEqGoodsList = [lib_goods:get_id(Goods_Latest) | Inv#inv.eq_goods],
                    update_inventory_to_ets(Inv#inv{eq_goods = NewEqGoodsList})
            end;

        ?LOC_BAG_USABLE ->
            ?ASSERT(lists:member(Goods_Latest#goods.id, Inv#inv.usable_goods) /= false),
            update_goods_to_ets(Goods_Latest);

        ?LOC_BAG_UNUSABLE ->
            ?ASSERT(lists:member(Goods_Latest#goods.id, Inv#inv.unusable_goods) /= false),
            update_goods_to_ets(Goods_Latest);

        ?LOC_STORAGE ->
            ?ASSERT(lists:member(Goods_Latest#goods.id, Inv#inv.storage_goods) /= false),
            update_goods_to_ets(Goods_Latest);

        ?LOC_PLAYER_EQP ->
            update_goods_to_ets(Goods_Latest),
            case lists:member(Goods_Latest#goods.id, Inv#inv.player_eq_goods) of
                true -> skip;
                false ->
                    NewPlayerEqGoodsList = [lib_goods:get_id(Goods_Latest) | Inv#inv.player_eq_goods],
                    update_inventory_to_ets(Inv#inv{player_eq_goods = NewPlayerEqGoodsList})
            end;

        ?LOC_PARTNER_EQP ->
            % ?ASSERT(lists:member(Goods_Latest#goods.id, Inv#inv.partner_eq_goods) /= false),
            % update_goods_to_ets(Goods_Latest);

            update_goods_to_ets(Goods_Latest),
            %% 宝石镶嵌在背包的装备时，宝石相当于位于装备背包了
            case lists:member(Goods_Latest#goods.id, Inv#inv.partner_eq_goods) of
                true -> skip;
                false ->
                    NewEqGoodsList = [lib_goods:get_id(Goods_Latest) | Inv#inv.partner_eq_goods],
                    update_inventory_to_ets(Inv#inv{partner_eq_goods = NewEqGoodsList})
            end;

        ?LOC_TEMP_BAG ->
            ?ASSERT(lists:member(Goods_Latest#goods.id, Inv#inv.temp_bag_goods) /= false),
            update_goods_to_ets(Goods_Latest);
        ?LOC_MAIL ->
            update_goods_to_ets(Goods_Latest);
        _Any ->
            ?ASSERT(false, _Any),
            skip
    end.


%% desc: 检查能否将物品放入背包(不包含叠加效果：不会叠加到背包已有物品上)
%% GoodsList 格式: [{GoodsNo, Count} ....]
%% returns: ok | {fail, Reason}
check_batch_add_goods_to_eq_bag(PlayerId, GoodsList) ->
    BagNullSlotCount = calc_empty_slots(PlayerId, ?LOC_BAG_EQ),
    check_batch_add_goods_to_eq_bag(PlayerId, BagNullSlotCount, GoodsList).

check_batch_add_goods_to_eq_bag(_PlayerId, 0, GoodsList) when GoodsList /= [] ->
    F = fun({GoodsNo, _Count}, Sum) ->
        GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
        case lib_goods:is_equip(GoodsTpl) of
            true -> Sum + 1;
            false -> Sum
        end
    end,
    case lists:foldl(F, 0, GoodsList) =:= 0 of
        true ->
            ok;
        false ->
            {fail, ?PM_EQ_BAG_FULL}
    end;

check_batch_add_goods_to_eq_bag(_PlayerId, _BagNullSlotCount, []) ->
    ok;
check_batch_add_goods_to_eq_bag(PlayerId, BagNullSlotCount, [{GoodsNo, GoodsCount} | T]) ->
    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    ?ASSERT(GoodsTpl /= null),

    case lib_goods:is_equip(GoodsTpl) of
        false ->
            check_batch_add_goods_to_eq_bag(PlayerId, BagNullSlotCount, T);
        true ->
            MaxStack = lib_goods:get_max_stack(GoodsTpl),
            ?ASSERT(MaxStack >= 1),
            case MaxStack >= GoodsCount of
                true ->
                    check_batch_add_goods_to_eq_bag(PlayerId, BagNullSlotCount - 1, T);
                false ->
                    check_batch_add_goods_to_eq_bag(PlayerId, BagNullSlotCount - 1, [{GoodsNo, GoodsCount - MaxStack} | T])
            end
    end;
check_batch_add_goods_to_eq_bag(_PlayerId, _BagNullSlotCount, GoodsList) ->
    ?ERROR_MSG("bad goods list:~p", [GoodsList]),
    ?ASSERT(false),
    {fail, ?PM_PARA_ERROR}.


%% desc: 检查能否将物品放入任务背包(不包含叠加效果：不会叠加到背包已有物品上)
%% GoodsList 格式: [{GoodsNo, Count} ....]
%% returns: ok | {fail, Reason}
check_batch_add_goods_to_usable_bag(PlayerId, GoodsList) ->
    BagNullSlotCount = calc_empty_slots(PlayerId, ?LOC_BAG_USABLE),
    check_batch_add_goods_to_usable_bag(PlayerId, BagNullSlotCount, GoodsList).

check_batch_add_goods_to_usable_bag(_PlayerId, 0, GoodsList) when GoodsList /= [] ->
    F = fun({GoodsNo, _Count}, Sum) ->
        GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
        case lib_goods:is_equip(GoodsTpl) of
            true ->
                Sum;
            false ->
                case lib_goods:is_can_use(GoodsTpl) of
                    true -> Sum + 1;
                    false -> Sum
                end
        end
    end,
    case lists:foldl(F, 0, GoodsList) =:= 0 of
        true ->
            ok;
        false ->
            {fail, ?PM_US_BAG_FULL}
    end;

check_batch_add_goods_to_usable_bag(_PlayerId, _BagNullSlotCount, []) ->
    ok;
check_batch_add_goods_to_usable_bag(PlayerId, BagNullSlotCount, [{GoodsNo, GoodsCount} | T]) ->
    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    ?ASSERT(GoodsTpl /= null),

    case lib_goods:is_equip(GoodsTpl) of
        true ->
            check_batch_add_goods_to_usable_bag(PlayerId, BagNullSlotCount, T);
        false ->
            case lib_goods:is_can_use(GoodsTpl) of
                false ->
                    check_batch_add_goods_to_usable_bag(PlayerId, BagNullSlotCount, T);
                true ->
                    MaxStack = lib_goods:get_max_stack(GoodsTpl),
                    case MaxStack >= GoodsCount of
                        true ->
                            check_batch_add_goods_to_usable_bag(PlayerId, BagNullSlotCount - 1, T);
                        false ->
                            check_batch_add_goods_to_usable_bag(PlayerId, BagNullSlotCount - 1, [{GoodsNo, GoodsCount - MaxStack} | T])
                    end
            end
    end;

check_batch_add_goods_to_usable_bag(_PlayerId, _BagNullSlotCount, GoodsList) ->
    ?ERROR_MSG("bad goods list:~p", [GoodsList]),
    ?ASSERT(false),
    {fail, ?PM_PARA_ERROR}.


check_batch_add_goods_to_unusable_bag(PlayerId, GoodsList) ->
    BagNullSlotCount = calc_empty_slots(PlayerId, ?LOC_BAG_UNUSABLE),
    check_batch_add_goods_to_unusable_bag(PlayerId, BagNullSlotCount, GoodsList).

check_batch_add_goods_to_unusable_bag(_PlayerId, 0, GoodsList) when GoodsList /= [] ->
    F = fun({GoodsNo, _Count}, Sum) ->
        GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
        case lib_goods:is_equip(GoodsTpl) of
            true ->
                Sum;
            false ->
                case lib_goods:is_can_use(GoodsTpl) of
                    false -> Sum + 1;
                    true -> Sum
                end
        end
    end,
    case lists:foldl(F, 0, GoodsList) =:= 0 of
        true ->
            ok;
        false ->
            {fail, ?PM_UNUS_BAG_FULL}
    end;

check_batch_add_goods_to_unusable_bag(_PlayerId, _BagNullSlotCount, []) ->
    ok;
check_batch_add_goods_to_unusable_bag(PlayerId, BagNullSlotCount, [{GoodsNo, GoodsCount} | T]) ->
    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    ?ASSERT(GoodsTpl /= null),
    case lib_goods:is_equip(GoodsTpl) orelse lib_goods:is_can_use(GoodsTpl) of
        true ->
            check_batch_add_goods_to_unusable_bag(PlayerId, BagNullSlotCount, T);
        false ->
            MaxStack = lib_goods:get_max_stack(GoodsTpl),
            case MaxStack >= GoodsCount of
                true ->
                    check_batch_add_goods_to_unusable_bag(PlayerId, BagNullSlotCount - 1, T);
                false ->
                    check_batch_add_goods_to_unusable_bag(PlayerId, BagNullSlotCount - 1, [{GoodsNo, GoodsCount - MaxStack} | T])
            end
    end;
check_batch_add_goods_to_unusable_bag(_PlayerId, _BagNullSlotCount, GoodsList) ->
    ?ERROR_MSG("bad goods list:~p", [GoodsList]),
    ?ASSERT(false),
    {fail, ?PM_PARA_ERROR}.


%% 是否可以把物品放到背包或任务背包
%% return ok | {fail, Reason}
check_batch_add_goods(_PlayerId, []) ->
    ok;
check_batch_add_goods(PlayerId, [{GoodsNo, Count} | T]) ->
    GoodsList = arrange_goods_list([{GoodsNo, Count} | T]),
    case check_batch_add_goods_to_eq_bag(PlayerId, GoodsList) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            case check_batch_add_goods_to_usable_bag(PlayerId, GoodsList) of
                {fail, Reason} ->
                    {fail, Reason};
                ok ->
                    case check_batch_add_goods_to_unusable_bag(PlayerId, GoodsList) of
                        {fail, Reason} ->
                            {fail, Reason};
                        ok ->
                            ok
                    end
            end
    end;


check_batch_add_goods(PlayerId, [GoodsId | T]) when is_integer(GoodsId) ->
    F = fun(X) ->
        TGoods = find_goods_by_id_from_whole_inv(PlayerId, X),
        ?ASSERT(TGoods =/= null, X),
        TGoods
    end,
    TGoodsList = [F(X) || X <- [GoodsId | T]],
    GoodsList = [Goods || Goods <- TGoodsList, Goods =/= null],
    check_batch_add_goods(PlayerId, GoodsList);    

check_batch_add_goods(PlayerId, [Goods_Or_GoodsTpl | T]) ->
    GoodsList = [Goods_Or_GoodsTpl | T],
    F1 = fun(X1, Sum1) ->
        case lib_goods:is_equip(X1) of
            true -> Sum1 + 1;
            false -> Sum1
        end
    end,
    EquipCount = lists:foldl(F1, 0, GoodsList),


    F2 = fun(X2, Sum2) ->
        case lib_goods:is_equip(X2) of
            true ->
                Sum2;
            false ->
                case lib_goods:is_can_use(X2) of
                    true -> Sum2 + 1;
                    false -> Sum2
                end
        end
    end,
    UsCount = lists:foldl(F2, 0, GoodsList),


    F3 = fun(X3, Sum3) ->
        case lib_goods:is_equip(X3) of
            true ->
                Sum3;
            false ->
                case lib_goods:is_can_use(X3) of
                    false ->
                        case lib_goods:get_type(X3) =:= ?GOODS_T_VIRTUAL of
                            true -> Sum3;
                            false -> Sum3 + 1
                        end;
                    true -> Sum3
                end
        end
    end,
    UnUsCount = lists:foldl(F3, 0, GoodsList),
    RetBool1 = calc_empty_slots(PlayerId, ?LOC_BAG_EQ) >= EquipCount,
    RetBool2 = calc_empty_slots(PlayerId, ?LOC_BAG_USABLE) >= UsCount,
    RetBool3 = calc_empty_slots(PlayerId, ?LOC_BAG_UNUSABLE) >= UnUsCount,
    case RetBool1 andalso RetBool2 andalso RetBool3 of
        true ->
            ok;
        false ->
            if
                RetBool1 =:= false -> {fail, ?PM_EQ_BAG_FULL};
                RetBool2 =:= false -> {fail, ?PM_US_BAG_FULL};
                true -> {fail, ?PM_UNUS_BAG_FULL}
            end
    end;

check_batch_add_goods(_PlayerId, GoodsList) ->
    ?ERROR_MSG("mod_inv:check_batch_add_goods, bad goods list:~p", [GoodsList]),
    ?ASSERT(false),
    {fail, ?PM_PARA_ERROR}.

%% @doc 通过物品编号检查物品数量是否足够，已兼容物品编号对应的货币检查
%% 注意当list=[{GoodsNo, Slot, Count}] | [{GoodsNo, Count, BindState}]是通过PlayerId_OR_PS的参数类型区分的
%%
%% check_batch_destroy_goods(PlayerId_OR_PS, List) -> ok | {fail,MsgCode}
%%      PlayerId_OR_PS = integer() | PS.
%%      List = [{GoodsNo, Count}] | [{GoodsNo, Slot, Count}] | [{GoodsNo, Count, BindState}]
%%
check_batch_destroy_goods(_PlayerId, []) ->
    ok;
check_batch_destroy_goods(PS, [{GoodsNo, Count} | T]) when is_record(PS, player_status) ->
    check_batch_destroy_goods(player:id(PS), [{GoodsNo, Count} | T]);
check_batch_destroy_goods(PlayerId, [{GoodsNo, Count} | T]) ->
    [{GoodsNo1, Count1} | T1] = arrange_goods_list([{GoodsNo, Count} | T]),

    case has_enough_goods_in_bag(PlayerId, GoodsNo1, Count1) of
        false ->
            ?TRACE("Goods not enougth: GoodsNo:~p, need Count:~p~n", [GoodsNo1, Count1]),
            {fail, ?PM_GOODS_NOT_ENOUGH};
        true -> check_batch_destroy_goods(PlayerId, T1)
    end;
%% 目前下面这个函数还没用到，如果以后有这个需求，需要调整物品列表，保证列表里编号和格子一样的元组仅有一个，否则会有bug
check_batch_destroy_goods(PlayerId, [{GoodsNo, Slot, Count} | T]) when is_integer(PlayerId) ->
    case has_enough_goods_in_bag(PlayerId, GoodsNo, Slot, Count) of
        false ->
            ?TRACE("Goods not enougth: GoodsNo:~p, need Count:~p~n", [GoodsNo, Count]),
            {fail, ?PM_GOODS_NOT_ENOUGH};
        true -> check_batch_destroy_goods(PlayerId, T)
    end;
check_batch_destroy_goods(PS, [{GoodsNo, Count, BindState} | T]) when is_record(PS, player_status) ->
    [{GoodsNo1, Count1, BindState1} | T1] = arrange_goods_list([{GoodsNo, Count, BindState} | T]),
    ?DEBUG_MSG("mod_inv:check_batch_destroy_goods:~w~n", [{GoodsNo1, Count1, BindState1}]),
    case has_enough_goods_in_bag(PS, GoodsNo1, BindState1, Count1) of
        false ->
            ?TRACE("Goods not enougth: GoodsNo:~p, need Count:~p~n", [GoodsNo, Count]),
            {fail, ?PM_GOODS_NOT_ENOUGH};
        true -> check_batch_destroy_goods(PS, T1)
    end;

check_batch_destroy_goods(_PlayerId, GoodsList) ->
    ?ERROR_MSG("bad goods list:~p", [GoodsList]),
    ?ASSERT(false),
    {fail, ?PM_PARA_ERROR}.


check_batch_destroy_goods_by_id(_PlayerId, []) ->
    ok;
check_batch_destroy_goods_by_id(PlayerId, [{GoodsId, Count} | T]) ->
    case find_goods_by_id_from_whole_inv_except_EQP(PlayerId, GoodsId) of
        null ->
            {fail, ?PM_GOODS_NOT_EXISTS_OR_CANT_USE};
        Goods ->
            case lib_goods:get_count(Goods) < Count of
                true ->
                    {fail, ?PM_GOODS_NOT_ENOUGH};
                false ->
                    check_batch_destroy_goods_by_id(PlayerId, T)
            end
    end;
check_batch_destroy_goods_by_id(PlayerId, [GoodsId | T]) ->
    case find_goods_by_id_from_whole_inv_except_EQP(PlayerId, GoodsId) of
        null ->
            {fail, ?PM_GOODS_NOT_EXISTS_OR_CANT_USE};
        _Goods ->
            check_batch_destroy_goods_by_id(PlayerId, T)
    end;
check_batch_destroy_goods_by_id(_PlayerId, GoodsList) ->
    ?ERROR_MSG("bad goods list:~p", [GoodsList]),
    ?ASSERT(false),
    {fail, ?PM_PARA_ERROR}.


%% 把列表参数[{GoodsNo, Count} | T] 或 [{GoodsNo, Count, BindState} | T] (如果有绑定状态的，这个状态全部需要相同) 编号相同的元组整合成一个元组，
%% 方便判断数量是否足够，
%% 如[{4101, 1},{4101, 1}] -> [{4101, 2}]
arrange_goods_list(GoodsList) ->
    F = fun(Para) ->
        case Para of
            {No, _Cnt} -> No;
            {No, _Cnt, _} -> No
        end
    end,
    GoodsNoList = [F(X) || X <- GoodsList],
    GoodsNoList1 = sets:to_list(sets:from_list(GoodsNoList)),

    F1 = fun(X1) ->
        F2 = fun(Para1, {Sum, _E}) ->
            case Para1 of
                {No1, Cnt1} ->
                    case No1 =:= X1 of
                        true -> {Sum + Cnt1, 0};
                        false -> {Sum, 0}
                    end;
                {No1, Cnt1, Ex} ->
                    case No1 =:= X1 of
                        true -> {Sum + Cnt1, Ex};
                        false -> {Sum, Ex}
                    end
            end
        end,
        {Count, Extra} = lists:foldl(F2, {0,0}, GoodsList),
        case Extra =:= 0 of
            true -> {X1, Count};
            false -> {X1, Count, Extra}
        end
    end,
    [F1(X1) || X1 <- GoodsNoList1].


%% internal
%% desc: 自动补充物品数量
add_stackable_goods(_, Goods, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, PlayerId) when Goods#goods.count =:= 0 ->
    lib_goods:db_delete_goods(PlayerId, lib_goods:get_id(Goods)),
    del_goods_from_ets_by_goods_id(lib_goods:get_id(Goods)),
    {NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL};

%% 没有位置可以填充物品了
add_stackable_goods([], Goods, [], [], [], PlayerId) ->
    Inv = get_inventory(PlayerId),
    GoodsCount = length(Inv#inv.temp_bag_goods),
    case GoodsCount =:= ?MAX_TEMPORARY_BAG_CAPACITY of
        true ->
            lib_send:send_prompt_msg(PlayerId, ?PM_TEMP_BAG_FULL),
            {[], [], []};
        false ->
            Goods1 = lib_goods:set_location(Goods, ?LOC_TEMP_BAG),
            add_goods_to_bag(PlayerId, lib_goods:set_slot(Goods1, find_first_empty_slot(PlayerId, ?LOC_TEMP_BAG)), [?LOG_SKIP]),
            {[], [], []}
    end;

add_stackable_goods([], Goods, [], NullBagUSSlotL, NullBagUNUSSlot, PlayerId) when Goods#goods.location =:= ?LOC_BAG_EQ ->
    Inv = get_inventory(PlayerId),
    GoodsCount = length(Inv#inv.temp_bag_goods),
    case GoodsCount =:= ?MAX_TEMPORARY_BAG_CAPACITY of
        true ->
            lib_send:send_prompt_msg(PlayerId, ?PM_TEMP_BAG_FULL),
            {[], NullBagUSSlotL, NullBagUNUSSlot};
        false ->
            Goods1 = lib_goods:set_location(Goods, ?LOC_TEMP_BAG),
            add_goods_to_bag(PlayerId, lib_goods:set_slot(Goods1, find_first_empty_slot(PlayerId, ?LOC_TEMP_BAG)), [?LOG_SKIP]),
            {[], NullBagUSSlotL, NullBagUNUSSlot}
    end;

add_stackable_goods([], Goods, NullBagEQSlotL, [], NullBagUNUSSlotL, PlayerId) when Goods#goods.location =:= ?LOC_BAG_USABLE ->
    Inv = get_inventory(PlayerId),
    GoodsCount = length(Inv#inv.temp_bag_goods),
    case GoodsCount =:= ?MAX_TEMPORARY_BAG_CAPACITY of
        true ->
            lib_send:send_prompt_msg(PlayerId, ?PM_TEMP_BAG_FULL),
            {NullBagEQSlotL, [], NullBagUNUSSlotL};
        false ->
            Goods1 = lib_goods:set_location(Goods, ?LOC_TEMP_BAG),
            add_goods_to_bag(PlayerId, lib_goods:set_slot(Goods1, find_first_empty_slot(PlayerId, ?LOC_TEMP_BAG)), [?LOG_SKIP]),
            {NullBagEQSlotL, [], NullBagUNUSSlotL}
    end;

add_stackable_goods([], Goods, NullBagEQSlotL, NullBagUSSlotL, [], PlayerId) when Goods#goods.location =:= ?LOC_BAG_UNUSABLE ->
    Inv = get_inventory(PlayerId),
    GoodsCount = length(Inv#inv.temp_bag_goods),
    case GoodsCount =:= ?MAX_TEMPORARY_BAG_CAPACITY of
        true ->
            lib_send:send_prompt_msg(PlayerId, ?PM_TEMP_BAG_FULL),
            {NullBagEQSlotL, NullBagUSSlotL, []};
        false ->
            Goods1 = lib_goods:set_location(Goods, ?LOC_TEMP_BAG),
            add_goods_to_bag(PlayerId, lib_goods:set_slot(Goods1, find_first_empty_slot(PlayerId, ?LOC_TEMP_BAG)), [?LOG_SKIP]),
            {NullBagEQSlotL, NullBagUSSlotL, []}
    end;

%% 此编号物品没满的格子列表为空的情况，要占用一个新的空格子
add_stackable_goods([], Goods, [Slot | LeftBagEQSlotL], NullBagUSSlotL, NullBagUNUSSlot, PlayerId) when Goods#goods.location =:= ?LOC_BAG_EQ ->
    add_goods_to_bag(PlayerId, lib_goods:set_slot(Goods, Slot), [?LOG_SKIP]),
    {LeftBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlot};

%% 此编号物品没满的格子列表为空的情况，要占用一个新的空格子
add_stackable_goods([], Goods, NullBagEQSlotL, [Slot | LeftBagUSSlotL], NullBagUNUSSlot, PlayerId) when Goods#goods.location =:= ?LOC_BAG_USABLE ->
    add_goods_to_bag(PlayerId, lib_goods:set_slot(Goods, Slot), [?LOG_SKIP]),
    {NullBagEQSlotL, LeftBagUSSlotL, NullBagUNUSSlot};

add_stackable_goods([], Goods, NullBagEQSlotL, NullBagUSSlotL, [Slot | LeftBagUNUSSlotL], PlayerId) when Goods#goods.location =:= ?LOC_BAG_UNUSABLE ->
    add_goods_to_bag(PlayerId, lib_goods:set_slot(Goods, Slot), [?LOG_SKIP]),
    {NullBagEQSlotL, NullBagUSSlotL, LeftBagUNUSSlotL};

add_stackable_goods([Goods | T], Info, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, PlayerId) ->
    Count = lib_goods:get_count(Info),
    MaxStack = lib_goods:get_max_stack(Info),
    %% 计算补充一格后，剩余的数量
    [CurGoodsCount, LeftGoods] =
    case lib_goods:get_count(Goods) + Count > MaxStack of
        true ->
            Lft = Info#goods{count = lib_goods:get_count(Goods) + Count - MaxStack},
            [MaxStack, Lft];
        false ->
            [lib_goods:get_count(Goods) + Count, Info#goods{count = 0}]
    end,
    %% 修改物品数量
    mark_dirty_flag(PlayerId, Goods#goods{count = CurGoodsCount}),
    lib_inv:notify_cli_goods_info_change(PlayerId, Goods#goods{count = CurGoodsCount}),
    % ply_tips:notify_gain_item(PlayerId, lib_goods:get_type(Goods), lib_goods:get_id(Goods), lib_goods:get_no(Goods), CurGoodsCount - lib_goods:get_count(Goods)),

    add_stackable_goods(T, LeftGoods, NullBagEQSlotL, NullBagUSSlotL, NullBagUNUSSlotL, PlayerId).



use_goods_one_by_one(_PS, Goods, 0) ->
    {ok, Goods};
use_goods_one_by_one(PS, Goods, UseCount) ->
    case check_use_goods(PS, lib_goods:get_id(Goods), 1) of
        {ok, Goods1} ->
            do_use_goods(PS, Goods1, 1),
            use_goods_one_by_one(PS, Goods1, UseCount - 1);
        {fail, Reason} ->
            {fail, Reason}
    end.

%% 判断物品位置（除了玩家身上和宠物身上）的是否合法
is_location_expcept_on_body_valid(Location) ->
    Location == ?LOC_BAG_EQ orelse Location == ?LOC_STORAGE orelse Location == ?LOC_BAG_USABLE orelse Location == ?LOC_BAG_UNUSABLE
    orelse Location =:= ?LOC_MAIL orelse Location =:= ?LOC_TEMP_BAG.

%% 判断物品位置是否合法，包括所有可能的位置
is_location_valid(Location) ->
    Location == ?LOC_BAG_EQ orelse Location == ?LOC_STORAGE orelse Location == ?LOC_BAG_USABLE orelse Location == ?LOC_BAG_UNUSABLE
    orelse Location =:= ?LOC_MAIL orelse Location =:= ?LOC_TEMP_BAG orelse Location =:= ?LOC_PLAYER_EQP orelse Location =:= ?LOC_PARTNER_EQP.

%% 判断背包位置（包括仓库）是否合法
is_location_bag_valid(Location) ->
    Location == ?LOC_BAG_EQ orelse Location == ?LOC_STORAGE orelse Location == ?LOC_BAG_USABLE orelse Location == ?LOC_BAG_UNUSABLE
    orelse Location =:= ?LOC_TEMP_BAG.


try_add_to_mail(PlayerId, Goods) ->
    case erlang:get(reward_player_to_mail_when_bag_full) of
        undefined -> skip;
        {true, LogInfo} -> 
            lib_mail:send_sys_mail(tranfer_goods, PlayerId, <<"背包已满">>, <<"大侠，您的背包已满，请清理背包，查收物品！">>, [Goods], LogInfo);
        _ -> skip
    end.