%%%-------------------------------------------------------------------
%%% @author wujiancheng
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% 该模块用来存放加强人物的强化和宝石等
%%%-------------------------------------------------------------------
-module(mod_strengthen).

-include("record.hrl").
-include("pt_15.hrl").
-include("inventory.hrl").
-include("goods.hrl").
-include("record.hrl").
-include("prompt_msg_code.hrl").
-include("record/goods_record.hrl").
-include("abbreviate.hrl").
-include("obj_info_code.hrl").
-include("log.hrl").
-include("equip.hrl").
-include("num_limits.hrl").
-include("sys_code.hrl").
-include("skill.hrl").
-include("ets_name.hrl").
-include("effect.hrl").

%% API
-export([send_player_info/1, strengthen_level/3,recount_all_equip_attrs/1,
  onekey_strengthen/1,arrange_strengthen/1,inlay_gemstone/4,unload_gemstone/4,get_one_strength_info/2,
  recast_new/4,check_attention/3,replace_new/4,special_recast/3,stunt_refresh/4,eff_refresh/5,eff_replace/2,
  equip_transfer/4,player_add_equip_fashion/3,
  on_login/1,
  on_logout/1,
  del_expire_fashion/2,
  find_fashion/2,
  get_fashions/1,
  set_fashions/1,
  player_change_fashion/2,
  get_fashion_remain_time/1,
  test/0]).


%发送玩家强化和宝石信息
send_player_info(PlayerId) ->
  PlayerMisc = ply_misc:get_player_misc(PlayerId),
  {ok, BinData} = pt_15:write(?PT_NEW_EQUIP_ARRAY, PlayerMisc#player_misc.strengthen_info),
  lib_send:send_to_uid(PlayerId, BinData).

%%是否完成任务成就
finish_stren_achivement(PlayerId) ->
  PlayerMisc = ply_misc:get_player_misc(PlayerId),
  StrengtheInfo = PlayerMisc#player_misc.strengthen_info,
  %%取所有技能中最低的那个
  case StrengtheInfo == [] of
    true ->
      skip;
    false ->
      SortFun = fun({_, First, _},{_, Next, _}) ->
        First < Next
                end,
      NewStrengtheInfo = lists:sort(SortFun, StrengtheInfo),
      [{_,LV,_}|_] = NewStrengtheInfo,
      mod_achievement:notify_achi(stren_equip, [{num, LV}], PlayerId)
  end.

%强化玩家等级
strengthen_level(PlayerId, Localtion, _IsAuto) ->
  PlayerMisc = ply_misc:get_player_misc(PlayerId),
  StrengtheInfo = PlayerMisc#player_misc.strengthen_info,
  case lists:keytake(Localtion, 1 , StrengtheInfo) of
    false ->
      case strengthen_condition(PlayerId, 1,[])  of
        fail->
          skip;
        CostGoods ->
          case mod_inv:destroy_goods_WNC(player:get_PS(PlayerId), CostGoods, [?MODULE, "stren"]) of
            true ->
              %%代表没强化过也没镶过宝石
              ply_misc:update_player_misc(PlayerMisc#player_misc{strengthen_info =[{Localtion, 1, [{1,0,0},{2,0,0},{3,0,0},{4,0,0}]}|StrengtheInfo] }),
              %%重算属性
              {ok, BinData} = pt_15:write(?PT_NEW_EQUIP_COMMON_STRENGTHEN, [Localtion,1]),
              lib_send:send_to_uid(PlayerId, BinData),
              finish_stren_achivement(PlayerId),
              ply_attr:recount_equip_add_and_total_attrs(player:get_PS(PlayerId));
            false -> ?ERROR_MSG("mod_equip:destroy_goods_WNC error!~n", [])
          end
      end;
    {value, {_, LV, GemStoneInfo}, StrengtheInfo2} ->
      case strengthen_condition(PlayerId, LV +1, [])  of
        fail ->
          skip;
        CostGoods ->
          case mod_inv:destroy_goods_WNC(player:get_PS(PlayerId), CostGoods, [?MODULE, "stren"]) of
            true ->
              ply_misc:update_player_misc(PlayerMisc#player_misc{strengthen_info =[{Localtion, LV+1, GemStoneInfo}|StrengtheInfo2] }),
              {ok, BinData} = pt_15:write(?PT_NEW_EQUIP_COMMON_STRENGTHEN, [Localtion, LV+1]),
              lib_send:send_to_uid(PlayerId, BinData),
              finish_stren_achivement(PlayerId),
              ply_attr:recount_equip_add_and_total_attrs(player:get_PS(PlayerId));
            false -> ?ERROR_MSG("mod_equip:destroy_goods_WNC error!~n", [])
          end
      end

  end.

%%一键强化  mod_strengthen:onekey_strengthen(1000100000000108).
onekey_strengthen(PlayerId) ->
  %%最低优先，从上到下
  PlayerMisc = ply_misc:get_player_misc(PlayerId),
  StrengtheInfo = PlayerMisc#player_misc.strengthen_info,
  {NewStrengtheInfo,Type} = arrange_strengthen(StrengtheInfo),
  {NewStrengtheInfo2,NeedCostGoods} = calc_onekey_upgrade(PlayerId,NewStrengtheInfo,[],Type),
  case mod_inv:check_batch_destroy_goods(player:get_PS(PlayerId), NeedCostGoods) of
    {fail, Reason} ->
      lib_send:send_prompt_msg(PlayerId, Reason),
      fail;
    ok ->
      case mod_inv:destroy_goods_WNC(player:get_PS(PlayerId), NeedCostGoods, [?MODULE, "stren"]) of
        true ->
          ply_misc:update_player_misc(PlayerMisc#player_misc{strengthen_info = NewStrengtheInfo2}),
          {ok ,Bin} = pt_15:write(?PT_NEW_EQUIP_ONE_STRENGTHEN, [NewStrengtheInfo2]),
          lib_send:send_to_uid(PlayerId, Bin),
          %%最好的话是在外面加成判断
          finish_stren_achivement(PlayerId),
          ply_attr:recount_equip_add_and_total_attrs(player:get_PS(PlayerId));
        false -> ?ERROR_MSG("mod_equip:destroy_goods_WNC error!~n", [])
      end
  end.

%% 递归计算消耗的物品和等级
calc_onekey_upgrade(PlayerId,StrengtheInfo, Goods,Type) ->
  [HeadInfo|T] = StrengtheInfo,
  {Index, StrengthenLv, GemStone} = HeadInfo,
  case strengthen_condition(PlayerId, StrengthenLv + 1, Goods) of
    fail ->
      {StrengtheInfo, Goods};
    NeedCost ->
      case Type =/= 0 of
        true ->
          %%再重新排列一次。若为0则不需要再排列
          {NewStrengtheInfo,NewType} = arrange_strengthen([{Index, StrengthenLv + 1, GemStone}|T]),
          calc_onekey_upgrade(PlayerId,NewStrengtheInfo, NeedCost, NewType);
        false ->
          calc_onekey_upgrade(PlayerId, T ++ [{Index, StrengthenLv + 1, GemStone}],  NeedCost, 0)
      end
  end.

%%累计物品计算
calc_arrange_goods(OldGoods, {GoodsNo,Count}) ->
  case lists:keytake(GoodsNo, 1, OldGoods) of
    false ->
      [{GoodsNo,Count}|OldGoods];
    {value, {GoodsNo,NewCount}, RemainGoods} ->
      [{GoodsNo,NewCount + Count}|RemainGoods]
  end.


arrange_strengthen(StrengtheInfo ) ->
  %%把没强化过的或者没镶过宝石的给个初始化值
  NeedList = [?EQP_POS_NECKLACE, ?EQP_POS_BRACER, ?EQP_POS_WEAPON, ?EQP_POS_BARDE, ?EQP_POS_WAISTBAND, ?EQP_POS_SHOES],
  F = fun(X,Acc) ->
    case lists:keyfind(X, 1, StrengtheInfo) of
      false ->
        [{X, 0, [{1,0,0}, {2,0,0}, {3,0,0}, {4,0,0}]}|Acc];
      _ ->
        Acc
    end
      end,
  %% 递归计算消耗的物品和等级
  NewStrengtheInfo =
    case length(StrengtheInfo) == 6 of
      true ->
        StrengtheInfo;
      false ->
        lists:foldl(F, StrengtheInfo ,NeedList)
    end,
  %%按最低强化的部位排序，强化到等级全一样重新排序一次
  NewStrengtheInfo2 = lists:keysort(2, NewStrengtheInfo),
  %%仅用于得到一个强化等级
  [HeadInfo|_] = NewStrengtheInfo2,
  {_, StrengthenLv, _} = HeadInfo,
  %%判断是否所有等级都相同
  F2 = fun(X,Acc) ->
    [InitLv, IsSame]= Acc,
    case IsSame of
      true ->
        {_, SameLv, _} = X,
        case InitLv == SameLv of
          true ->
            Acc;
          false ->
            %%不是都相同
            [SameLv, false]
        end;
      false ->
        Acc
    end
       end,
  %% true 代表所有等级都相同需要重新排列
  [_,IsSameBoolen] = lists:foldl(F2, [StrengthenLv,true], NewStrengtheInfo2),
  case IsSameBoolen == true of
    true ->
      {lists:keysort(2, NewStrengtheInfo2), 0};
    false ->
      {NewStrengtheInfo2, 1}
  end.

%%强化的条件
strengthen_condition(PlayerId, NewLv,OldGoods) ->
  case NewLv > length(data_equip_strenthen:get_all_lv_step_list()) of
    true ->
      lib_send:send_prompt_msg(PlayerId, ?PM_MAX_STREN_LV_LIMIT),
      fail;
    false ->
      StrenthenData = data_equip_strenthen:get(NewLv),
      case player:get_lv(PlayerId) >= StrenthenData#equip_strenthen.need_eq_lv of
        true ->
          case mod_inv:check_batch_destroy_goods(player:get_PS(PlayerId), [{StrenthenData#equip_strenthen.strengthen_stone,StrenthenData#equip_strenthen.strengthen_stone_count}|OldGoods]) of
            {fail, Reason} ->
              lib_send:send_prompt_msg(PlayerId, Reason),
              fail;
            ok ->
              calc_arrange_goods(OldGoods, {StrenthenData#equip_strenthen.strengthen_stone,StrenthenData#equip_strenthen.strengthen_stone_count})
          end;
        false ->
          lib_send:send_prompt_msg(PlayerId, ?PM_LV_LIMIT),
          fail
      end
  end.


recount_all_equip_attrs(PlayerId) ->
  PlayerMisc = ply_misc:get_player_misc(PlayerId),
  StrengtheInfo = PlayerMisc#player_misc.strengthen_info,
  F = fun(EquipPos, Acc) ->
    case lists:keyfind(EquipPos, #goods.slot, mod_equip:get_player_equip_list(PlayerId)) of
      false ->
        Acc;
      Goods ->
        BaseAttr = lib_goods:get_base_equip_add(Goods),
        case lists:keyfind(EquipPos, 1, StrengtheInfo) of
          false ->
            %%没强化
            Acc;
          {_, StrengthenLv, _GemStone} ->
            case StrengthenLv of
              0 ->
                Acc;
              _ ->
                StrenthenData = data_equip_strenthen:get(StrengthenLv),
                AddRatio = StrenthenData#equip_strenthen.base_attr_add,
                StrenAttr = BaseAttr#attrs{
                  hp = util:ceil(BaseAttr#attrs.hp * ((AddRatio / 1000) )),
                  hp_lim = util:ceil(BaseAttr#attrs.hp_lim * ((AddRatio / 1000) )),
                  mp = util:ceil(BaseAttr#attrs.mp * ((AddRatio / 1000) )),
                  mp_lim = util:ceil(BaseAttr#attrs.mp_lim * ((AddRatio / 1000) )),
                  phy_att = util:ceil(BaseAttr#attrs.phy_att * ((AddRatio / 1000) )),
                  mag_att = util:ceil(BaseAttr#attrs.mag_att * ((AddRatio / 1000) )),
                  phy_def = util:ceil(BaseAttr#attrs.phy_def * ((AddRatio / 1000) )),
                  mag_def = util:ceil(BaseAttr#attrs.mag_def * ((AddRatio / 1000) )),
                  crit = util:ceil(BaseAttr#attrs.crit * ((AddRatio / 1000))),
                  ten = util:ceil(BaseAttr#attrs.ten * ((AddRatio / 1000) )),
                  talent_str = util:ceil(BaseAttr#attrs.talent_str * ((AddRatio / 1000) )),
                  talent_con = util:ceil(BaseAttr#attrs.talent_con * ((AddRatio / 1000) )),
                  talent_sta = util:ceil(BaseAttr#attrs.talent_sta * ((AddRatio / 1000) )),
                  talent_spi = util:ceil(BaseAttr#attrs.talent_spi * ((AddRatio / 1000) )),
                  talent_agi = util:ceil(BaseAttr#attrs.talent_agi * ((AddRatio / 1000) )),
                  anger = util:ceil(BaseAttr#attrs.anger * ((AddRatio / 1000) )),
                  anger_lim = util:ceil(BaseAttr#attrs.anger_lim * ((AddRatio / 1000) )),
                  act_speed = util:ceil(BaseAttr#attrs.act_speed * ((AddRatio / 1000) )),
                  luck = util:ceil(BaseAttr#attrs.luck * ((AddRatio / 1000) )),
                  neglect_ret_dam =  util:ceil(BaseAttr#attrs.neglect_ret_dam * ((AddRatio / 1000) )),
                  frozen_hit = util:ceil(BaseAttr#attrs.frozen_hit * ((AddRatio / 1000) )),
                  frozen_hit_lim = util:ceil(BaseAttr#attrs.frozen_hit_lim * ((AddRatio / 1000) )),
                  trance_hit = util:ceil(BaseAttr#attrs.trance_hit * ((AddRatio / 1000) )),
                  trance_hit_lim = util:ceil(BaseAttr#attrs.trance_hit_lim * ((AddRatio / 1000) )),
                  chaos_hit = util:ceil(BaseAttr#attrs.chaos_hit * ((AddRatio / 1000) )),
                  chaos_hit_lim = util:ceil(BaseAttr#attrs.chaos_hit_lim * ((AddRatio / 1000) )),
                  frozen_resis = util:ceil(BaseAttr#attrs.frozen_resis * ((AddRatio / 1000) )),
                  frozen_resis_lim = util:ceil(BaseAttr#attrs.frozen_resis_lim * ((AddRatio / 1000) )),
                  trance_resis = util:ceil(BaseAttr#attrs.trance_resis * ((AddRatio / 1000) )),
                  trance_resis_lim = util:ceil(BaseAttr#attrs.trance_resis_lim * ((AddRatio / 1000) )),
                  chaos_resis = util:ceil(BaseAttr#attrs.chaos_resis * ((AddRatio / 1000) )),
                  chaos_resis_lim = util:ceil(BaseAttr#attrs.chaos_resis_lim * ((AddRatio / 1000) )),
                  seal_hit = util:ceil(BaseAttr#attrs.seal_hit * ((AddRatio / 1000) )),
                  seal_resis = util:ceil(BaseAttr#attrs.seal_resis * ((AddRatio / 1000) )),
                  heal_value = util:ceil(BaseAttr#attrs.heal_value * ((AddRatio / 1000) ))
                },
                [StrenAttr | Acc]
            end
        end
    end
      end,
  NeedList = [?EQP_POS_NECKLACE, ?EQP_POS_BRACER, ?EQP_POS_WEAPON, ?EQP_POS_BARDE, ?EQP_POS_WAISTBAND, ?EQP_POS_SHOES],
  lists:foldl(F, [], NeedList).


inlay_gemstone(PS, BodyId, GemGoodsId, HoleNo) ->
  case check_inlay_gemstone(PS, BodyId, GemGoodsId, HoleNo) of
    {fail, Reason} ->
      {fail, Reason};
    {ok, StrengthInfo, GemGoods} ->
      do_inlay_gemstone(PS, StrengthInfo, GemGoods, HoleNo)
  end.

get_one_strength_info(PS, BodyId) ->
  PlyMisc = ply_misc:get_player_misc(player:get_id(PS)),
  Strength = PlyMisc#player_misc.strengthen_info,
  GemstoneList = case lists:keyfind(BodyId, 1, Strength) of
                   {_BodyId, _StrengthLv, GemList} ->
                     {_BodyId, _StrengthLv, GemList};
                   false ->
                     StrengthSon = {BodyId, 0, [{1,0,0}, {2,0,0}, {3,0,0}, {4,0,0}]},
                     NewStrength = [StrengthSon|Strength],
                     ply_misc:update_player_misc(PlyMisc#player_misc{strengthen_info = NewStrength}),
                     StrengthSon
                 end,
  GemstoneList.


unload_gemstone(PS, BodyId, GemGoodsId, HoleNo) ->
  case check_unload_gemstone(PS, BodyId, GemGoodsId, HoleNo) of
    {fail, Reason} ->
      {fail, Reason};
    {ok, StrengthInfo, GemGoods} ->
      do_unload_gemstone(PS, StrengthInfo, GemGoods, HoleNo)
  end.

do_inlay_gemstone(PS, StrengthInfo, GemGoods, HoleNo) ->
  {BodyId, StrengthLv, GemStoneList} = StrengthInfo,
  case lists:keyfind(HoleNo, 1, GemStoneList) of
    false ->
      ?ASSERT(false, BodyId),
      {fail, ?PM_UNKNOWN_ERR};
    {_, Id, _No} ->
      %% 从背包移除物品
      mod_inv:remove_goods_from_bag(player:id(PS), GemGoods),
      lib_inv:notify_cli_goods_destroyed_from_bag(player:id(PS), lib_goods:get_id(GemGoods), lib_goods:decide_bag_location(GemGoods)),
      DelGemIdList =
        case Id =:= ?INVALID_ID of
          true -> [];
          false ->
            case mod_inv:find_goods_by_id_from_whole_inv(player:get_id(PS), Id) of
              null ->
                ?ASSERT(false, Id),
                [];
              OldGem ->
                % mod_inv:add_goods_to_bag(player:get_id(PS), OldGem, [?LOG_SKIP])
                Location = lib_goods:decide_bag_location(OldGem),
                mod_inv:smart_add_goods(player:get_id(PS), lib_goods:set_location(OldGem, Location)),
                [lib_goods:get_id(OldGem)]
            end
        end,

      case lib_goods:get_count(GemGoods) > 1 of
        false ->
          %% 放在装备上
          GemGoods1 = lib_goods:set_slot(GemGoods, ?INVALID_NO),
          GemGoods2 = lib_goods:set_location(GemGoods1, ?LOC_PLAYER_EQP),
          % ?DEBUG_MSG("mod_equip:do_inlay_gemstone() Gem Location:~p slot:~p ~n", [lib_goods:get_location(GemGoods2), lib_goods:get_slot(GemGoods2)]),
          mod_inv:mark_dirty_flag(player:get_id(PS), GemGoods2),
          lib_inv:notify_cli_goods_info_change(player:id(PS), GemGoods2);
        true ->
          %% 放在装备上
          GemGoods1 = lib_goods:set_slot(GemGoods, ?INVALID_NO),
          GemGoods2 = lib_goods:set_location(GemGoods1, ?LOC_PLAYER_EQP),
          GemGoods3 = lib_goods:set_count(GemGoods2, 1),
          mod_inv:mark_dirty_flag(player:get_id(PS), GemGoods3),
          lib_inv:notify_cli_goods_info_change(player:id(PS), GemGoods3),

          %% 把剩余的宝石重新放入背包
          GemLeft = lib_goods:set_count(GemGoods, lib_goods:get_count(GemGoods) - 1),
          GemLeft1 = lib_goods:set_slot(GemLeft, ?INVALID_NO),
          NewGoodsId = lib_goods:db_insert_new_goods(GemLeft1),
          GemLeft2 = lib_goods:set_id(GemLeft1, NewGoodsId),
          % mod_inv:add_goods_to_bag(player:get_id(PS), GemLeft2, [?LOG_SKIP])
          mod_inv:smart_add_goods(player:get_id(PS), GemLeft2)
      end,

      %% 更新物品栏信息
      Inv = mod_inv:get_inventory(player:id(PS)),
      PlayerEqGoodsList = [lib_goods:get_id(GemGoods) | Inv#inv.player_eq_goods],
      PlayerEqGoodsList1 = PlayerEqGoodsList -- DelGemIdList,
      mod_inv:update_inventory_to_ets(Inv#inv{player_eq_goods = sets:to_list(sets:from_list(PlayerEqGoodsList1))}),


      %% 更新强化信息
      GemStoneList1 = lists:keyreplace(HoleNo, 1, GemStoneList, {HoleNo, lib_goods:get_id(GemGoods), lib_goods:get_no(GemGoods)}),
      StrengthInfo1 = {BodyId, StrengthLv, GemStoneList1},
      PlyMisc = ply_misc:get_player_misc(player:get_id(PS)),
      OldStrengthInfo = PlyMisc#player_misc.strengthen_info,
      NewStrengthInfo = lists:keyreplace(BodyId, 1, OldStrengthInfo, StrengthInfo1),
      ply_misc:update_player_misc(PlyMisc#player_misc{strengthen_info = NewStrengthInfo}),
      io:format("NewStrengthInfo===========~p~n",[NewStrengthInfo]),
      lib_event:event(inlay_gemstone, [], PS),
      % 指定等级的宝石成就
      mod_achievement:notify_achi(inlay_gemstone,[{gem_lv,lib_goods:get_lv(GemGoods)}], PS),
      mod_achievement:notify_achi(inlay_gemstone,[], PS),

%%      lib_log:statis_inlay_gemstone(PS, lib_goods:get_no(GemGoods), lib_goods:get_id(GemGoods), lib_goods:get_id(EqGoods), HoleNo, lib_goods:get_no(EqGoods)),

      % 只能人物镶嵌宝石
      ply_attr:recount_all_attrs(imme, PS),
      ok
  end.

do_unload_gemstone(PS, StrengthInfo, GemGoods, HoleNo) ->
  {BodyId, StrengthLv, GemStoneList} = StrengthInfo,
  case lists:keyfind(HoleNo, 1, GemStoneList) of
    false ->
      ?ASSERT(false, BodyId),
      {fail, ?PM_UNKNOWN_ERR};
    {_, _, _} ->
      Location = lib_goods:decide_bag_location(GemGoods),
      GemGoods1 = lib_goods:set_count(GemGoods, 1), %% 确保是返回一个
      mod_inv:smart_add_goods(player:get_id(PS), lib_goods:set_location(GemGoods1, Location)),

      %% 更新物品栏信息
      Inv = mod_inv:get_inventory(player:id(PS)),
      PlayerEqGoodsList = Inv#inv.player_eq_goods -- [lib_goods:get_id(GemGoods)],
      mod_inv:update_inventory_to_ets(Inv#inv{player_eq_goods = PlayerEqGoodsList}),

      GemStoneList1 = lists:keyreplace(HoleNo, 1, GemStoneList, {HoleNo, ?INVALID_ID, ?INVALID_ID}),
      StrengthInfo1 = {BodyId, StrengthLv, GemStoneList1},
      PlyMisc = ply_misc:get_player_misc(player:get_id(PS)),
      OldStrengthInfo = PlyMisc#player_misc.strengthen_info,
      NewStrengthInfo = lists:keyreplace(BodyId, 1, OldStrengthInfo, StrengthInfo1),
      ply_misc:update_player_misc(PlyMisc#player_misc{strengthen_info = NewStrengthInfo}),
      io:format("NewStrengthInfo===========~p~n",[NewStrengthInfo]),
%%      lib_log:statis_unload_gemstone(PS, lib_goods:get_no(GemGoods), lib_goods:get_id(GemGoods), lib_goods:get_id(EqGoods), HoleNo),

      % 宝石只镶嵌在人物身上
      ply_attr:recount_all_attrs(imme, PS),
      ok
  end.

check_inlay_gemstone(PS, BodyId, GemGoodsId, HoleNo) ->
  try check_inlay_gemstone__(PS, BodyId, GemGoodsId, HoleNo) of
    {ok, StrengthInfo, GemGoods} ->
      {ok, StrengthInfo, GemGoods}
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.


check_inlay_gemstone__(PS, BodyId, GemGoodsId, HoleNo) ->
  io:format("BodyId==~p,GemGoodsId===~p,HoleNo===~p~n",[BodyId,GemGoodsId,HoleNo]),
  ?Ifc (HoleNo =< 0 orelse HoleNo > ?MAX_GEMSTONE_HOLE)
    throw(?PM_PARA_ERROR)
  ?End,

  ?Ifc (BodyId =< 0 orelse BodyId > 6)
    throw(?PM_PARA_ERROR)
  ?End,

  GemGoods = mod_inv:find_goods_by_id_from_bag(player:get_id(PS), GemGoodsId),
  ?Ifc (GemGoods =:= null)
    throw(?PM_GOODS_NOT_EXISTS)
  ?End,

  ?Ifc (lib_goods:get_count(GemGoods) < 1)
    throw(?PM_GOODS_NOT_EXISTS)
  ?End,

  ?Ifc (lib_goods:get_slot(GemGoods) =< 0)
    throw(?PM_PARA_ERROR)
  ?End,

  StrengthInfo = get_one_strength_info(PS, BodyId),
  {_BodyId, _Lv, GemStoneList} = StrengthInfo,
  ?ASSERT(is_list(GemStoneList), GemStoneList),

  GemNo = lib_goods:get_no(GemGoods),
  GemCfg = data_gem_add:get(GemNo),
  ?Ifc (GemCfg =:= null)
    throw(?PM_DATA_CONFIG_ERROR)
  ?End,

  GemTypeList = GemCfg#gem_add.body_type,
  LvLimit = GemCfg#gem_add.lv_limit,

  ?Ifc (LvLimit > player:get_lv(PS))
    throw(?PM_NEWYEAR_BANQUET_LEVEL_LIMIT)
  ?End,

  % 判断是否满足宝石位置
  IsSatisfy = case lists:member(BodyId, GemTypeList) of
                ?true -> true;
                ?false -> false
              end,

  ?Ifc (IsSatisfy =:= false)
    throw(?PM_GOODS_EQUIP_NOT_APPLICABLE_GEM)
  ?End,

  case lists:keyfind(HoleNo, 1, GemStoneList) of
    false -> throw(?PM_PARA_ERROR);
    _Any -> {ok, StrengthInfo, GemGoods}
  end.

check_unload_gemstone(PS, BodyId, GemGoodsId, HoleNo) ->
  try check_unload_gemstone__(PS, BodyId, GemGoodsId, HoleNo) of
    {ok, EqGoods, GemGoods} ->
      {ok, EqGoods, GemGoods}
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.


check_unload_gemstone__(PS, BodyId, GemGoodsId, HoleNo) ->
  ?Ifc (HoleNo =< 0 orelse HoleNo > ?MAX_GEMSTONE_HOLE)
    throw(?PM_PARA_ERROR)
  ?End,

  ?Ifc (BodyId =< 0 orelse BodyId > 6)
    throw(?PM_PARA_ERROR)
  ?End,

  GemGoods = mod_inv:find_goods_by_id_from_whole_inv(player:get_id(PS), GemGoodsId),
  ?Ifc (GemGoods =:= null)
    throw(?PM_GOODS_NOT_EXISTS)
  ?End,

  ?ASSERT(lib_goods:get_count(GemGoods) =:= 1, lib_goods:get_count(GemGoods)),
  StrengthInfo = get_one_strength_info(PS, BodyId),
  {_BodyId, _Lv, GemStoneList} = StrengthInfo,
  ?ASSERT(is_list(GemStoneList), GemStoneList),

  case lists:keyfind(HoleNo, 1, GemStoneList) of
    false -> throw(?PM_GOODS_EQUIP_HOLE_NOT_OPENED);
    {_No, Id, _} ->
      if
      Id =:= ?INVALID_ID ->
        throw(?PM_GOODS_EQUIP_NOT_INLAY_GEM);
      Id =/= GemGoodsId ->
        throw(?PM_PARA_ERROR);
      true ->
        case mod_inv:check_batch_add_goods(player:id(PS), [GemGoods]) of
          {fail, Reason} ->
            throw(Reason);
          ok ->
            {ok, StrengthInfo, GemGoods}
        end
      end
  end.

%%装备重铸
recast_new(PS, GoodsId, Type, AttrList) ->
  case check_recast(PS, GoodsId, Type) of
    {fail, Reason} ->
      {fail, Reason};
    {ok, Goods} ->
      case Type of
        0 ->
          do_recast_new(PS, Goods, AttrList);
        _ ->
          do_recast_base_new(PS, Goods, AttrList)
      end
  end.

check_recast(PS, GoodsId,Type) ->
  try check_recast__(PS, GoodsId, Type) of
    {ok, Goods} ->
      {ok, Goods}
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.


check_recast__(PS, GoodsId, Type) ->
  ?Ifc (GoodsId =< 0)
    throw(?PM_PARA_ERROR)
  ?End,

  Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
  GoodsNo = lib_goods:get_no(Goods),

  ?Ifc (Goods =:= null)
    throw(?PM_GOODS_NOT_EXISTS)
  ?End,

  ?Ifc (lib_goods:is_fashion(Goods))
    throw(?PM_PARA_ERROR)
  ?End,

  ?Ifc (not lib_goods:is_equip(Goods))
    throw(?PM_PARA_ERROR)
  ?End,

  %% 判断系统开放等级
  ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_XILIAN))
    throw(?PM_LV_LIMIT)
  ?End,

  Data = data_equip_recast_cost:get(GoodsNo),
  ?Ifc (Data =:= null)
    throw(?PM_DATA_CONFIG_ERROR)
  ?End,

  ?Ifc (length(Data#eq_recast_cost.money_list) > 2)
    throw(?PM_DATA_CONFIG_ERROR)
  ?End,
  CostMoneyList = case Type of
                    0 -> Data#eq_recast_cost.money_list;
                    _ -> Data#eq_recast_cost.base_money_list
                  end,

  RetMoney = check_money(PS, CostMoneyList),

  ?Ifc (RetMoney =/= 0)
    throw(RetMoney)
  ?End,

  % 重铸基本属性消耗强化石
  GoodsList = case Type of
                0 -> Data#eq_recast_cost.goods_list;
                _ -> Data#eq_recast_cost.base_goods_list
              end,

  case mod_inv:check_batch_destroy_goods(PS,GoodsList) of
    {fail, Reason} ->
      throw(Reason);
    ok ->
      {ok, Goods}
  end.

% ------------------------------------------------------------------------- %
% 重铸基础属性
do_recast_base_new(PS, Goods, AttrList) ->
  GoodsNo = lib_goods:get_no(Goods),
  DataCfg = data_equip_recast_cost:get(GoodsNo),
  case length(DataCfg#eq_recast_cost.base_money_list) of
    0 -> skip;
    1 ->
      {MoneyType1, Money1} = lists:nth(1, DataCfg#eq_recast_cost.base_money_list),
      player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "recast"]);
    2 ->
      {MoneyType1, Money1} = lists:nth(1, DataCfg#eq_recast_cost.base_money_list),
      {MoneyType2, Money2} = lists:nth(2, DataCfg#eq_recast_cost.base_money_list),
      player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "recast"]),
      player:cost_money(PS, MoneyType2, Money2, [?LOG_EQUIP, "recast"])
  end,

  % 重铸基本属性消耗强化石
  GoodsList = DataCfg#eq_recast_cost.base_goods_list,

  mod_inv:destroy_goods_WNC(PS,GoodsList,[?LOG_EQUIP, "recast_base"]),

  GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
  Quality = lib_goods:get_quality(Goods),

  BaseEquipAdd = lib_equip:decide_base_equip_add(GoodsTpl, Quality),
  Goods4 = lib_goods:set_last_base_attr(Goods,BaseEquipAdd),

  mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
%%  lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),

  %% 是否关注成功
  IsAttention = case check_attention(AttrList, BaseEquipAdd, 1) of
                  false -> 0;
                  true -> 1
                end,

  %% 属性计算
  recount_attr_equip_put_on(PS, Goods4),

  {ok, Goods4, BaseEquipAdd, IsAttention}.

% 重铸附加属性
do_recast_new(PS, Goods, AttrList) ->
  GoodsNo = lib_goods:get_no(Goods),
  DataCfg = data_equip_recast_cost:get(GoodsNo),
  case length(DataCfg#eq_recast_cost.money_list) of
    0 -> skip;
    1 ->
      {MoneyType1, Money1} = lists:nth(1, DataCfg#eq_recast_cost.money_list),
      player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "recast"]);
    2 ->
      {MoneyType1, Money1} = lists:nth(1, DataCfg#eq_recast_cost.money_list),
      {MoneyType2, Money2} = lists:nth(2, DataCfg#eq_recast_cost.money_list),
      player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "recast"]),
      player:cost_money(PS, MoneyType2, Money2, [?LOG_EQUIP, "recast"])
  end,

  mod_inv:destroy_goods_WNC(PS,DataCfg#eq_recast_cost.goods_list,[?LOG_EQUIP, "recast"]),

  GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
  Quality = lib_goods:get_quality(Goods),

  % 重铸附加属性
  AddiEquipAdd =
    case lib_goods:get_type(GoodsTpl) =:= ?GOODS_T_PAR_EQUIP of
      true -> [];
      false ->
        AddiEquipAddDebug = lib_equip:make_addi_random_attr(GoodsNo, Quality),
        AddiEquipAddDebug
    end,

  Goods4 = lib_goods:set_last_ref_attr(Goods,AddiEquipAdd),

  mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
%%  lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),

  %% 是否关注成功
  IsAttention = case check_attention(AttrList, AddiEquipAdd, 2) of
                  false -> 0;
                  true -> 1
                end,

  %% 属性计算
  recount_attr_equip_put_on(PS, Goods4),
  % lib_log:statis_equip_recast(PS, lib_goods:get_id(Goods4), lib_goods:get_addi_ep_add_kv(Goods), AddiEquipAdd),
  {ok, Goods4, AddiEquipAdd, IsAttention}.


check_money(_PS, []) ->
  0;
check_money(PS, [{MoneyType, Count} | T]) ->
  ?DEBUG_MSG("check_money=~p,~p",[MoneyType, Count]),
  case player:has_enough_money(PS, MoneyType, Count) of
    false ->
      case MoneyType of
        ?MNY_T_GAMEMONEY -> ?PM_GAMEMONEY_LIMIT;
        ?MNY_T_YUANBAO -> ?PM_YB_LIMIT;
        ?MNY_T_BIND_GAMEMONEY -> ?PM_BIND_GAMEMONEY_LIMIT;
        ?MNY_T_BIND_YUANBAO -> ?PM_BIND_YB_LIMIT;
        ?MNY_T_INTEGRAL -> ?PM_INTEGRAL_LIMIT;
        ?MNY_T_VITALITY -> ?PM_VITALITY_LIMIT;
        ?MNY_T_COPPER -> ?PM_COPPER_LIMIT;
        ?MNY_T_CHIVALROUS -> ?PM_CHIVALROUS_LIMIT;
        ?MNY_T_EXP -> ?PM_EXP_LIMIT;
        ?MNY_T_GUILD_CONTRI -> ?PM_GUILD_CONTRI_LIMIT;
        ?MNY_T_QUJING       ->  ?PM_JINGWEN_LIMIT

      end;
    true -> check_money(PS, T)
  end;
check_money(_PS, _) ->
  ?PM_DATA_CONFIG_ERROR.

%%检测是否全部为关注属性
check_attention([], _AttrList, _Type) ->
  false;

check_attention(AttrNoList, AttrList, Type) ->
  %%1基础洗炼，2附加洗炼
  case Type of
    1 ->
      F = fun({AttrName, _AttrValue}, Acc) ->
              ObjInfoCode = lib_attribute:attr_name_to_obj_info_code(AttrName),
              case ObjInfoCode =:= ?INVALID_NO of
                true ->
                  Acc;
                false ->
                  [ObjInfoCode | Acc]
              end
          end,
      BaseAttrNoList = lists:foldl(F, [], AttrList),
      io:format("AttrNoList====~p,BaseAttrNoList====~p~n",[AttrNoList, BaseAttrNoList]),
      F1 = fun(X1, {NoAcc1, BaseAttrAcc1}) ->
              case lists:member(X1, BaseAttrAcc1) of
                true ->
                  NewNoAcc1 = lists:delete(X1, NoAcc1),
                  NewBaseAttrAcc1 = lists:delete(X1, BaseAttrAcc1),
                  {NewNoAcc1, NewBaseAttrAcc1};
                false ->
                  {NoAcc1, BaseAttrAcc1}
              end
           end,
      {NoList1, _} = lists:foldl(F1, {AttrNoList, BaseAttrNoList}, AttrNoList),
      case NoList1 =:= [] of
        true -> ?true;
        false -> ?false
      end;
    2 ->
      F2 = fun({_, AttrName, _AttrValue, _Lv}, Acc) ->
              ObjInfoCode = lib_attribute:attr_name_to_obj_info_code(AttrName),
              case ObjInfoCode =:= ?INVALID_NO of
                true ->
                  Acc;
                false ->
                  [ObjInfoCode | Acc]
              end
          end,
      BaseAttrNoList = lists:foldl(F2, [], AttrList),
      io:format("AttrNoList====~p,BaseAttrNoList====~p~n",[AttrNoList, BaseAttrNoList]),
      F3 = fun(X3, {NoAcc1, BaseAttrAcc1}) ->
        case lists:member(X3, BaseAttrAcc1) of
          true ->
            NewNoAcc1 = lists:delete(X3, NoAcc1),
            NewBaseAttrAcc1 = lists:delete(X3, BaseAttrAcc1),
            {NewNoAcc1, NewBaseAttrAcc1};
          false ->
            {NoAcc1, BaseAttrAcc1}
        end
           end,
      {NoList2, _} = lists:foldl(F3, {AttrNoList, BaseAttrNoList}, AttrNoList),
      case NoList2 =:= [] of
        true -> ?true;
        false -> ?false
      end;
    _ ->
      false
  end.

%% 穿戴的装备属性重算
recount_attr_equip_put_on(PS, Goods) ->
  PlayerId = player:get_id(PS),
  GoodsId = lib_goods:get_id(Goods),
  case mod_equip:is_equip_put_on(PlayerId, GoodsId) of
    false ->
      case mod_equip:is_equip_put_on_par(PlayerId, GoodsId) of
        false ->
          skip;
        true ->
          PartnerId = Goods#goods.partner_id,
          Partner = lib_partner:recount_equip_add_and_total_attrs(PlayerId, PartnerId),
          mod_partner:update_partner_to_ets(Partner)
      end;
    true -> ply_attr:recount_equip_add_and_total_attrs(PS)
  end.

% 替换
replace_new(PS, GoodsId, Type, Action) ->
  case check_replace(PS, GoodsId, Type, Action) of
    {fail, Reason} ->
      {fail, Reason};
    {ok, Goods} ->
      do_recast_new(PS, Goods, Type, Action)
  end.

check_replace(PS, GoodsId, Type, Action) ->
  try check_replace__(PS, GoodsId, Type, Action) of
    {ok, Goods} ->
      {ok, Goods}
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.

check_replace__(PS, GoodsId,Type,_Action) ->
  ?Ifc (GoodsId =< 0)
    throw(?PM_PARA_ERROR)
  ?End,

  Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
  GoodsNo = lib_goods:get_no(Goods),

  ?Ifc (Goods =:= null)
    throw(?PM_GOODS_NOT_EXISTS)
  ?End,

  ?Ifc (lib_goods:is_fashion(Goods))
    throw(?PM_PARA_ERROR)
  ?End,

  ?Ifc (not lib_goods:is_equip(Goods))
    throw(?PM_PARA_ERROR)
  ?End,

  %% 判断系统开放等级
  ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_XILIAN))
    throw(?PM_LV_LIMIT)
  ?End,

  ?Ifc (Type == 0 andalso lib_goods:get_last_ref_attr(Goods) =:= null)
    throw(?PM_NOT_HAVE_ATTRS)
  ?End,

  ?Ifc (Type == 1 andalso lib_goods:get_last_base_attr(Goods) =:= null)
    throw(?PM_NOT_HAVE_ATTRS)
  ?End,

  {ok, Goods}.

do_recast_new(PS, Goods, Type, Action) ->
  %% 0附加属性 1基础属性
  case Type of
    0 ->
      %% 0放弃 1替换
      case Action of
        1 ->
          AddiEquipAdd = lib_goods:get_last_ref_attr(Goods),
          AddiEquipAdd2 = lib_attribute:to_addi_equip_add_attrs_record(AddiEquipAdd),   % 转为attrs结构体

          Goods1 = lib_goods:set_addi_ep_add_kv(Goods, AddiEquipAdd),                   % 存到ets
          Goods2 = lib_goods:set_addi_equip_add(Goods1, AddiEquipAdd2),
          Goods3 = lib_goods:set_last_ref_attr(Goods2,null),

          Goods4 = lib_goods:set_battle_power(Goods3, lib_equip:recount_battle_power(Goods3)),

          mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
          lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),


          %% 属性计算
          recount_attr_equip_put_on(PS, Goods4),
          lib_log:statis_equip_recast(PS, lib_goods:get_id(Goods4), lib_goods:get_addi_ep_add_kv(Goods), AddiEquipAdd),
          {ok, Goods4};
        0 ->
          Goods1 = lib_goods:set_last_ref_attr(Goods,null),
          mod_inv:mark_dirty_flag(player:get_id(PS), Goods1),
          {ok, Goods1};
        _G -> {fail, ?PM_CLI_MSG_ILLEGAL}
      end;
    1 ->
      case Action of
        1 ->
          BaseEquipAdd = lib_goods:get_last_base_attr(Goods),
          Goods01 = lib_goods:set_show_base_equip_add(Goods,BaseEquipAdd),
          BaseEquipAdd01 =util:duplicate_key_sum_value(BaseEquipAdd) ,
          BaseEquipAdd2 = lib_attribute:to_attrs_record(BaseEquipAdd01),
          Goods1 = lib_goods:set_last_base_attr(Goods01,null),
          Goods3 = lib_goods:set_base_equip_add(Goods1, BaseEquipAdd2),
          Goods4 = lib_goods:set_battle_power(Goods3, lib_equip:recount_battle_power(Goods3)),

          mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
          lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),

          %% 属性计算
          recount_attr_equip_put_on(PS, Goods4),

          {ok, Goods4};
        0 ->
          Goods1 = lib_goods:set_last_base_attr(Goods,null),
          mod_inv:mark_dirty_flag(player:get_id(PS), Goods1),
          {ok, Goods1};
        _G -> {fail, ?PM_CLI_MSG_ILLEGAL}
      end;
    _ ->
      {fail, ?PM_CLI_MSG_ILLEGAL}
  end.

%% 特殊（自选）洗炼
special_recast(PS, GoodsId, AttrList) ->
  try check_replace__(PS, GoodsId, 2, 1) of
    {ok, Goods} ->
      AttrLen = length(AttrList),
      case AttrLen =:= 5 of
        true ->
          %% 获取装备附加属性
          Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
          GoodsNo = lib_goods:get_no(Goods),
          Quality = lib_goods:get_quality(Goods),
          EquipAdded = data_equip_added:get(GoodsNo),
          F = fun(X, Acc) ->
                AttrName = lib_attribute:obj_info_code_to_attr_name(X),% 属性位置
                Index = lib_equip:get_field_index_in_equip_added1(AttrName),
                AttrValue = case element(Index,EquipAdded) of
                              [] ->
                                ?ASSERT(false, Index),
                                0;
                              Value -> Value
                            end,
                AddiCoef = data_special_config:get('recast_addi_coef'),
                {_, Max} = case lists:keyfind(Quality, 1, AddiCoef) of
                               {_Quality, _Min, _Max} ->
                                 {_Min, _Max};
                               false ->
                                 %%用于纠正系数
                                 {1.0, 1.1}
                             end,
                RealValue = util:ceil(Max * AttrValue),  % 系数 * 基础属性加成基数， 勿忘对结果取整！
                ?ASSERT(RealValue >= 1),
                [{0, AttrName, RealValue, 0} | Acc]
              end,
          %% 替换新的附加属性
          AddiEquipAdd = lists:foldl(F, [], AttrList),
          AddiEquipAdd2 = lib_attribute:to_addi_equip_add_attrs_record(AddiEquipAdd),   % 转为attrs结构体

          Goods1 = lib_goods:set_addi_ep_add_kv(Goods, AddiEquipAdd),                   % 存到ets
          Goods2 = lib_goods:set_addi_equip_add(Goods1, AddiEquipAdd2),
          Goods3 = lib_goods:set_last_ref_attr(Goods2,null),

          Goods4 = lib_goods:set_battle_power(Goods3, lib_equip:recount_battle_power(Goods3)),

          mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
          lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),


          %% 属性计算
          recount_attr_equip_put_on(PS, Goods4),
          lib_log:statis_equip_recast(PS, lib_goods:get_id(Goods4), lib_goods:get_addi_ep_add_kv(Goods), AddiEquipAdd),
          {ok, Goods4};
        false ->
          {fail, ?PM_DIY_TITLE_ATTRS_NOT_CORRECT}
      end
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.


%% 装备特效洗练
stunt_refresh(PS, GoodsId, Type, Action) ->
  case check_stunt_refresh(PS, GoodsId, Type, Action) of
    {fail, Reason} ->
      {fail, Reason};
    {ok, Goods, 1} ->
      do_stunt_refresh(PS, Goods, Action);
    {ok, Goods, 2} ->
      do_stunt_replace(PS, Goods)
  end.

check_stunt_refresh(PS, GoodsId, Type, Action) ->
  try check_stunt_refresh__(PS, GoodsId, Type, Action) of
    {ok, Goods, 1} ->
      {ok, Goods, 1};
    {ok, Goods, 2} ->
      {ok, Goods, 2}
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.

check_stunt_refresh__(PS, GoodsId, 1, Action) ->
  ?Ifc (GoodsId =< 0)
    throw(?PM_PARA_ERROR)
  ?End,

  Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
  GoodsNo = lib_goods:get_no(Goods),

  ?Ifc (Goods =:= null)
    throw(?PM_GOODS_NOT_EXISTS)
  ?End,

  ?Ifc (not lib_goods:is_equip(Goods))
    throw(?PM_PARA_ERROR)
  ?End,

  StuntNo = lib_goods:get_equip_stunt(Goods),
  ?Ifc (StuntNo =:= null orelse StuntNo =:= 0)
    throw(?PM_GOODS_EQUIP_NOT_STUNT)
  ?End,

  %% 判断系统开放等级
  ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_EFFECT_XILIAN))
    throw(?PM_LV_LIMIT)
  ?End,

  DataCfg = data_equip_recast_cost:get(GoodsNo),
  [{PriceType, Price}] = DataCfg#eq_recast_cost.stunt_money_list,

  RetMoney = check_money(PS, [{PriceType, Price}]),
  ?Ifc (RetMoney =/= 0)
    throw(RetMoney)
  ?End,

  StuntGoods = case Action of
                  0 -> DataCfg#eq_recast_cost.stunt_list;
                  1 -> DataCfg#eq_recast_cost.stunt_list2
              end,

  case mod_inv:check_batch_destroy_goods(PS, StuntGoods) of
    {fail, Reason} ->
      throw(Reason);
    ok ->
      {ok, Goods, 1}
  end;

check_stunt_refresh__(PS, GoodsId, 2, _Action) ->
  ?Ifc (GoodsId =< 0)
    throw(?PM_PARA_ERROR)
  ?End,

  Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),

  ?Ifc (Goods =:= null)
    throw(?PM_GOODS_NOT_EXISTS)
  ?End,

  ?Ifc (not lib_goods:is_equip(Goods))
    throw(?PM_PARA_ERROR)
  ?End,

  %% 判断系统开放等级
  ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_EFFECT_XILIAN))
    throw(?PM_LV_LIMIT)
  ?End,

  {ok, Goods, 2}.

do_stunt_refresh(PS, Goods, Action) ->
  GoodsNo = lib_goods:get_no(Goods),
  DataCfg = data_equip_recast_cost:get(GoodsNo),
  [{PriceType, Price}] = DataCfg#eq_recast_cost.stunt_money_list,
  {StuntGoods, Time} = case Action of
                 0 ->
                   {DataCfg#eq_recast_cost.stunt_list, lib_goods:get_equip_stunt_refresh_time(Goods)};
                 1 ->
                   {DataCfg#eq_recast_cost.stunt_list2, lib_goods:get_equip_high_stunt_refresh_time(Goods)}
               end,

  player:cost_money(PS, PriceType, Price, [?LOG_EQUIP, "stunt_refresh"]),
  mod_inv:destroy_goods_WNC(PS, StuntGoods, [?LOG_EQUIP, "stunt_refresh"]),

  NewTime = Time + 1,
  EquipStuntNo = lib_equip:get_new_make_equip_added_stunt_no(GoodsNo, NewTime, Action),


  ?DEBUG_MSG("Time ===== ~p, EquipStuntNo : ~p~n", [NewTime,EquipStuntNo]),
  Goods2 = lib_goods:set_equip_stunt_temp_no(Goods, EquipStuntNo),
  Goods3 = lib_goods:set_equip_stunt_refresh_time(Goods2, NewTime),

  mod_inv:mark_dirty_flag(player:get_id(PS), Goods3),
  lib_inv:notify_cli_goods_info_change(player:id(PS), Goods3),

  OldEquipStuntNo = lib_goods:get_equip_stunt(Goods3),

  {ok, OldEquipStuntNo, EquipStuntNo}.


do_stunt_replace(PS, Goods) ->
  case lib_goods:get_equip_stunt_temp_no(Goods) of
    0 ->
      {fail, ?PM_PARA_ERROR};
    EquipStuntNo ->
      ?DEBUG_MSG("EquipStuntNo============~p~n",[EquipStuntNo]),

      Goods2 = lib_goods:set_equip_stunt(Goods, EquipStuntNo),
      Goods3 = lib_goods:set_equip_stunt_temp_no(Goods2, 0),

      mod_inv:mark_dirty_flag(player:get_id(PS), Goods3),
      lib_inv:notify_cli_goods_info_change(player:id(PS), Goods3),
      {ok, EquipStuntNo, 0}
  end.

%% 装备特效洗练
eff_refresh(PS, GoodsId, AttrLv, AttrNo, Action) ->
    case check_eff_refresh(PS, GoodsId, Action) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods} ->
            do_eff_refresh(PS, Goods, AttrLv, AttrNo, Action)
    end.

check_eff_refresh(PS, GoodsId, Action) ->
    try check_eff_refresh__(PS, GoodsId, Action) of
        {ok, Goods} ->
            {ok, Goods}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

%% 装备特效洗练替换
eff_replace(PS, GoodsId) ->
  case check_eff_replace(PS, GoodsId) of
    {fail, Reason} ->
      {fail, Reason};
    {ok, Goods} ->
      do_eff_replace(PS, Goods)
  end.

check_eff_replace(PS, GoodsId) ->
  try check_eff_replace__(PS, GoodsId) of
    {ok, Goods} ->
      {ok, Goods}
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.

check_eff_refresh__(PS, GoodsId, Action) ->
    ?Ifc (GoodsId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
    GoodsNo = lib_goods:get_no(Goods),

    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (not lib_goods:is_equip(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    EffectNo = lib_goods:get_equip_effect(Goods),
    ?Ifc (EffectNo =:= null orelse EffectNo =:= 0)
        throw(?PM_GOODS_EQUIP_NOT_EFFECT)
    ?End,

    %% 判断系统开放等级
    ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_EFFECT_XILIAN))
        throw(?PM_LV_LIMIT)
    ?End,

    DataCfg = data_equip_recast_cost:get(GoodsNo),
    [{PriceType, Price}] = DataCfg#eq_recast_cost.eff_money_list,

    RetMoney = check_money(PS, [{PriceType, Price}]),
    ?Ifc (RetMoney =/= 0)
        throw(RetMoney)
    ?End,

    EffGoods = case Action of
                0 -> DataCfg#eq_recast_cost.eff_list;
                1 -> DataCfg#eq_recast_cost.eff_list2
              end,
    case mod_inv:check_batch_destroy_goods(PS, EffGoods) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            {ok, Goods}
    end.

check_eff_replace__(PS, GoodsId) ->
    ?Ifc (GoodsId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),

    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (not lib_goods:is_equip(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    %% 判断系统开放等级
    ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_EFFECT_XILIAN))
        throw(?PM_LV_LIMIT)
    ?End,

    {ok, Goods}.


do_eff_refresh(PS, Goods, AttrLv, AttrNo, Action) ->
    GoodsNo = lib_goods:get_no(Goods),
    DataCfg = data_equip_recast_cost:get(GoodsNo),
    [{PriceType, Price}] = DataCfg#eq_recast_cost.eff_money_list,
    {EffectGoods, Time} = case Action of
                            0 -> {DataCfg#eq_recast_cost.eff_list, lib_goods:get_equip_eff_refresh_time(Goods)};
                            1 -> {DataCfg#eq_recast_cost.eff_list2, lib_goods:get_equip_high_eff_refresh_time(Goods)}
                          end,
    player:cost_money(PS, PriceType, Price, [?LOG_EQUIP, "eff_refresh"]),
    mod_inv:destroy_goods_WNC(PS, EffectGoods, [?LOG_EQUIP, "eff_refresh"]),

    NewTime = Time + 1,
    EquipEffNo = lib_equip:get_new_make_equip_added_effect_no(GoodsNo, NewTime, Action),

    ?DEBUG_MSG("NewTime :   ~p,EquipEffNo :   ~p~n", [NewTime,EquipEffNo]),
    Goods2 = lib_goods:set_equip_eff_temp_no(Goods, EquipEffNo),
    Goods3 = lib_goods:set_equip_eff_refresh_time(Goods2, NewTime),

    mod_inv:mark_dirty_flag(player:get_id(PS), Goods3),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods3),

    %% 是否关注
    IsAttention = if
                    AttrLv =/= 0 andalso AttrNo =:= 0 ->
                      case (data_equip_speci_effect:get(EquipEffNo))#equip_speci_effect_tpl.lv >= AttrLv of
                        true -> 1;
                        false -> 0
                      end;
                    AttrLv =:= 0 andalso AttrNo =/= 0 ->
                      AttributeNo = (data_equip_speci_effect_type:get(AttrNo))#equip_speci_effect_type.no,
                      RefreshAttributeNo = (data_equip_speci_effect:get(EquipEffNo))#equip_speci_effect_tpl.attribute,
                      case AttributeNo =:= RefreshAttributeNo of
                        true -> 1;
                        false -> 0
                      end;
                    AttrLv =/= 0 andalso AttrNo =/= 0 ->
                      EffLv = (data_equip_speci_effect:get(EquipEffNo))#equip_speci_effect_tpl.lv,
                      AttributeNo1 = (data_equip_speci_effect_type:get(AttrNo))#equip_speci_effect_type.no,
                      RefreshAttributeNo1 = (data_equip_speci_effect:get(EquipEffNo))#equip_speci_effect_tpl.attribute,
                      case EffLv >= AttrLv andalso AttributeNo1 =:= RefreshAttributeNo1 of
                        true -> 1;
                        false -> 0
                      end;
                    true -> 0
                  end,

    OldEquipEffNo = lib_goods:get_equip_effect(Goods3),

    {ok, IsAttention, OldEquipEffNo, EquipEffNo}.


do_eff_replace(PS, Goods) ->
    case lib_goods:get_equip_eff_temp_no(Goods) of
        0 ->
            {fail, ?PM_PARA_ERROR};
        AddiEquipEffNo ->
            AddiEquipEffAdd = case AddiEquipEffNo of
                                  0 -> #attrs{};
                                  _ -> lib_attribute:to_addi_equip_eff(AddiEquipEffNo)
                              end,
            ?INFO_MSG("~n~n~n~nAddiEquipEffNo : ~p~n~n~n", [AddiEquipEffNo]),
            Goods2 = lib_goods:set_equip_eff_temp_no(Goods#goods{
                addi_equip_eff = AddiEquipEffNo,
                addi_equip_eff_add = AddiEquipEffAdd
            }, 0),
            Goods3 = lib_goods:set_equip_effect(Goods2,Goods2#goods.addi_equip_eff),
            Goods4 = lib_goods:set_battle_power(Goods3, lib_equip:recount_battle_power(Goods3)),
            mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
            lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),
            %% 属性计算
            recount_attr_equip_put_on(PS, Goods4),
            {ok, AddiEquipEffNo, 0}
    end.

equip_transfer(PS, GoodsId, TargetId, Type) ->
  case check_equip_transfer(PS, GoodsId, TargetId, Type) of
    {ok, Goods, TargetGoods} ->
      do_equip_transfer(PS, Goods, TargetGoods, Type);
    {fail, FailReason} ->
      {fail, FailReason}
  end.

check_equip_transfer(PS, GoodsId, TargetId, Type) ->
  try check_equip_transfer__(PS, GoodsId, TargetId, Type) of
    {ok, Goods, TargetGoods} ->
      {ok, Goods, TargetGoods}
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.

check_equip_transfer__(PS, GoodsId, TargetId, TypeList) ->
  io:format("TypeList == ~p, GoodsId == ~p, TargetId == ~p~n",[TypeList, GoodsId, TargetId]),

  ?Ifc (GoodsId =< 0)
    throw(?PM_PARA_ERROR)
  ?End,

  Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),

  ?Ifc (Goods =:= null)
    throw(?PM_GOODS_NOT_EXISTS)
  ?End,

  ?Ifc (not lib_goods:is_equip(Goods))
    throw(?PM_PARA_ERROR)
  ?End,

  ?Ifc (TargetId =< 0)
    throw(?PM_PARA_ERROR)
  ?End,

  TargetGoods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), TargetId),

  ?Ifc (TargetGoods =:= null)
    throw(?PM_GOODS_NOT_EXISTS)
  ?End,

  ?Ifc (not lib_goods:is_equip(TargetGoods))
    throw(?PM_PARA_ERROR)
  ?End,

  ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_EFFECT_XILIAN))
    throw(?PM_LV_LIMIT)
  ?End,

  TarSubType = lib_goods:get_subtype(TargetGoods),
  SubType = lib_goods:get_subtype(Goods),

  ?Ifc(TarSubType =/= SubType)
    throw(?PM_EQUIP_TYPE_NOT_SAME)
  ?End,

  F = fun(Type) ->
          ?Ifc (not lists:member(Type, [1, 2, 3]))
            throw(?PM_PARA_ERROR)
          ?End,

          Condition = element(Type, data_special_config:get('succinct_transfer_limit')),
          case Type of
            1 ->
              AddiEquipKv = [{AttrName, Value} || {_, AttrName, Value, _} <- lib_goods:get_addi_ep_add_kv(Goods)],
              Keys = proplists:get_keys(AddiEquipKv),
              IsTheSave = check_save_key(Keys, AddiEquipKv, Condition),
              ?Ifc (not IsTheSave)
                throw(?PM_EQUIP_NOT_ENOUGH_CONDITION)
              ?End;
            2 ->
              Shunt = lib_goods:get_equip_stunt(Goods),
              ?Ifc (Shunt =:= 0)
                throw(?PM_EQUIP_NOT_ENOUGH_CONDITION)
              ?End,
              RarityNo = (data_skill:get(Shunt))#skl_cfg.rarity_no,
              ?Ifc (not (RarityNo =/= 0 andalso RarityNo =< Condition))
                throw(?PM_EQUIP_NOT_ENOUGH_CONDITION)
              ?End;
            3 ->
              EffNo = lib_goods:get_equip_effect(Goods),
              ?Ifc (EffNo =:= 0)
                throw(?PM_EQUIP_NOT_ENOUGH_CONDITION)
              ?End,
              RarityNo = (data_equip_speci_effect:get(EffNo))#equip_speci_effect_tpl.rarity_no,
              ?Ifc (not (RarityNo =/= 0 andalso RarityNo =< Condition))
                throw(?PM_EQUIP_NOT_ENOUGH_CONDITION)
              ?End
            end,

          case lists:keyfind(Type, 1, data_special_config:get('succinct_transfer_cost')) of
            {_, PriceType, Price} ->
            RetMoney = check_money(PS, [{PriceType, Price}]),
            ?Ifc (RetMoney =/= 0)
              throw(RetMoney)
            ?End;
            _ ->
              throw(?PM_PARA_ERROR)
          end
      end,
  lists:foreach(F, TypeList),

  {ok, Goods, TargetGoods}.

check_save_key([], _List, _Num) ->
  false;

check_save_key([H|T], List, Num) ->
  NewList = proplists:get_all_values(H, List),
  case length(NewList) >= Num of
    true ->
      true;
    false ->
      check_save_key(T, List, Num)
  end.

do_equip_transfer(PS, GoodsOne, GoodsTwo, Type) ->
  T = fun(Y, Acc) ->
      {_, MoneyType, CostNum} = lists:nth(Y, data_special_config:get('succinct_transfer_cost')),
      case lists:keyfind(MoneyType, 1 ,Acc) of
        {_, Num} ->
          NewNum = Num + CostNum,
          lists:keyreplace(MoneyType, 1, Acc, {MoneyType, NewNum});
        false ->
          [{MoneyType, CostNum}|Acc]
      end
    end,
  CostList = lists:foldl(T, [], Type),

  T2 = fun(Q, W) ->
          player:cost_money(PS, Q, W, ["do_equip_transfer"])
      end,
  lists:foreach(T2, CostList),

  F = fun(X, {TransGoods,TargetGoods}) ->
        case X of
          1 ->
            TransAddiEquipAdd1 = lib_goods:get_addi_ep_add_kv(TransGoods),
            TransAddiEquipAdd2 = lib_goods:get_addi_equip_add(TransGoods),

            TargetAddiEquipAdd1 = lib_goods:get_addi_ep_add_kv(TargetGoods),
            TargetAddiEquipAdd2 = lib_goods:get_addi_equip_add(TargetGoods),

            TransGoods1 = lib_goods:set_addi_ep_add_kv(TransGoods, TargetAddiEquipAdd1),
            TransGoods2 = lib_goods:set_addi_equip_add(TransGoods1, TargetAddiEquipAdd2),

            TargetGoods1 = lib_goods:set_addi_ep_add_kv(TargetGoods, TransAddiEquipAdd1),
            TargetGoods2 = lib_goods:set_addi_equip_add(TargetGoods1, TransAddiEquipAdd2),

            {TransGoods2, TargetGoods2};
          2 ->
            TransStuntNo = lib_goods:get_equip_stunt(TransGoods),
            TargetStuntNo = lib_goods:get_equip_stunt(TargetGoods),

            TransGoods3 = lib_goods:set_equip_stunt(TransGoods, TargetStuntNo),
            TargetGoods3 = lib_goods:set_equip_stunt(TargetGoods, TransStuntNo),

            {TransGoods3, TargetGoods3};
          3 ->
            TransEffNo = lib_goods:get_equip_effect(TransGoods),
            TargetEffNo = lib_goods:get_equip_effect(TargetGoods),

            TransGoods4 = lib_goods:set_equip_effect(TransGoods, TargetEffNo),
            TargetGoods4 = lib_goods:set_equip_effect(TargetGoods, TransEffNo),

            {TransGoods4, TargetGoods4}
        end
      end,
  {NewGoodsOne, NewGoodsTwo} = lists:foldl(F, {GoodsOne, GoodsTwo}, Type),

  NewGoodsOne2 = lib_goods:set_battle_power(NewGoodsOne, lib_equip:recount_battle_power(NewGoodsOne)),
  mod_inv:mark_dirty_flag(player:get_id(PS), NewGoodsOne2),
  lib_inv:notify_cli_goods_info_change(player:id(PS), NewGoodsOne2),
  recount_attr_equip_put_on(PS, NewGoodsOne2),

  NewGoodsTwo2 = lib_goods:set_battle_power(NewGoodsTwo, lib_equip:recount_battle_power(NewGoodsTwo)),
  mod_inv:mark_dirty_flag(player:get_id(PS), NewGoodsTwo2),
  lib_inv:notify_cli_goods_info_change(player:id(PS), NewGoodsTwo2),
  recount_attr_equip_put_on(PS, NewGoodsTwo2),

  ok.

player_add_equip_fashion(PS, No, GoodsNo) ->
  case check_player_add_equip_fashion(PS, No, GoodsNo) of
    {fail, Reason} ->
      {fail, Reason};
    {ok, FashionNo, Second} ->
      add_fashion(player:get_id(PS), FashionNo, Second),
      ok
  end.


check_player_add_equip_fashion(PS, FashionNo, GoodsNo) ->
  case data_equip_fashion:get(FashionNo) of
    null ->
      ?ASSERT(false, FashionNo),
      {fail, ?PM_DATA_CONFIG_ERROR};
    MountFashion ->
      case lists:keyfind(GoodsNo, 1, MountFashion#equip_fashion.goods_list) of
        {_GoodsNo, Num} ->
          case mod_inv:check_batch_destroy_goods(PS, [{GoodsNo, Num}]) of
            {fail, Reason} ->
              {fail, Reason};
            ok ->
              case find_fashion(player:get_id(PS), FashionNo) of
                #equip_fashion_data{no = FashionNo} ->
                  {fail, ?PM_YOU_HAVE_EQUIP_FASHION};
                false ->
                  [Effect] = (data_goods:get(GoodsNo))#goods_tpl.effects,
                  {_FashionNo, Second} = (data_goods_eff:get(Effect))#goods_eff.para,
                  {ok, FashionNo, Second}
              end
          end;
        false ->
          {fail, ?PM_DATA_CONFIG_ERROR}
      end
  end.

add_fashion(UID, FashionNo, AddTime) ->
  FashionInfo = get_fashions(UID),
  FashionInfo1 = do_add_fashion(FashionNo, AddTime, FashionInfo),
  set_fashion_info(FashionInfo1),
  lib_scene:notify_int_info_change_to_aoi(player, UID, [{?OI_CODE_MOUNT_SKIN, FashionNo}]), % AOI
  PS = player:get_PS(UID),

  List = get_fashion_remain_time(PS),
  {ok, BinData} = pt_15:write(?PT_PERSON_FASHION_INFO, [List]),
  lib_send:send_to_sock(PS, BinData),

  ply_attr:recount_all_attrs(PS),
  io:format("you are use fashion").

test() ->
%%  c:l(mod_strengthen).
%%  mod_strengthen:test().
  PlayerId = 1000100000000008,
  PS = player:get_PS(PlayerId),
  TEST = player_add_equip_fashion(PS, 2, 20046),
  Kin = get_fashion_remain_time(PS),
  {ok, BinData} = pt_15:write(?PT_PERSON_FASHION_INFO, [Kin]),
  lib_send:send_to_sock(PS, BinData),
  io:format("KIN ========= ~p~n",[Kin]),

  skip.

do_add_fashion(FashionNo, AddTime, #equip_fashion_info{uid = UID, all_fashion = AllFashion, wear_fashion_no = WearNo} = FashionInfo) ->
  case data_equip_fashion:get(FashionNo) of
    null ->
      ?ASSERT(false, FashionInfo),
      FashionInfo;
    _DataFashion ->
      Expire = ?IF(AddTime > 0, AddTime + util:unixtime(), 0),
      NewFashion = #equip_fashion_data{no = FashionNo, expire = Expire},
      schedule_one_timeout(UID, NewFashion),
      AllFashion2 = lists:keystore(FashionNo, #equip_fashion_data.no, AllFashion, NewFashion),
      FashionInfo1 = case WearNo =:= 0 of
                    true ->
                      FashionInfo#equip_fashion_info{all_fashion = AllFashion2, wear_fashion_no = FashionNo};
                    false ->
                      FashionInfo#equip_fashion_info{all_fashion = AllFashion2}
                  end,
      FashionInfo1
  end.

on_login(UID) ->
  MountFashion =
    case ets:lookup(?ETS_EQUIP_FASHION, UID) of
      [] ->
        db_load(UID);
      [T] ->
        T
    end,
  MountFashion1 = filter_expire(MountFashion),
  schedule_all_timeout(MountFashion1),
  ets:insert(?ETS_EQUIP_FASHION, MountFashion1).

on_logout(UID) ->
  FashionInfo = get_fashions(UID),
  db:kv_insert(equip_fashion, UID, FashionInfo),
  ets:delete(?ETS_EQUIP_FASHION, UID).

db_load(UID) ->
  case db:kv_lookup(equip_fashion, UID) of
    [] ->
      new_equip_fashion_data(UID);
    [MountFashion] ->
      MountFashion
  end.

new_equip_fashion_data(UID) ->
  #equip_fashion_info{
    uid=UID,
    wear_fashion_no = 0,
    all_fashion = []
  }.

filter_expire(#equip_fashion_info{all_fashion = All} = AllFashion) ->
  Now = util:unixtime(),
  F = fun(#equip_fashion_data{expire= 0 }, T) -> T;
    (#equip_fashion_data{no=No, expire=Expire}, T) when Expire =< Now->
      do_del_fashion(No, T);
    (_, T) -> T
      end,
  AllFashion1 = lists:foldl(F, AllFashion, All),
  AllFashion1.

schedule_all_timeout(#equip_fashion_info{uid = UID, all_fashion = All}) ->
  F = fun(T) -> schedule_one_timeout(UID, T) end,
  lists:foreach(F, All).

schedule_one_timeout(UID, #equip_fashion_data{no = FashionNo, expire = Expire}) when Expire > 0 ->
  Now = util:unixtime(),
  mod_ply_jobsch:add_mfa_schedule(UID, Expire - Now, {?MODULE, del_expire_fashion, [UID, FashionNo]});
schedule_one_timeout(_, _) ->
  ok.

do_del_fashion(No, #equip_fashion_info{all_fashion = AllFashion, wear_fashion_no = FashionNo} = FashionInfo) ->
  AllFashion1 = lists:keydelete(No, #equip_fashion_data.no, AllFashion),
  FashionInfo1 = FashionInfo#equip_fashion_info{all_fashion = AllFashion1},
  FashionInfo2 = case No =:= FashionNo of
                true ->
                  FashionInfo1#equip_fashion_info{wear_fashion_no = 0};
                false ->
                  FashionInfo1
              end,
  FashionInfo2.

del_expire_fashion(UID, FashionNo) ->
  Now = util:unixtime(),
  case find_fashion(UID, FashionNo) of
    #equip_fashion_data{expire = 0} ->
      ok;
    #equip_fashion_data{expire = Expire} when Expire =< Now ->
      del_fashion(UID, FashionNo);
    _ ->
      ok
  end.

find_fashion(UID, FashionNo) ->
  #equip_fashion_info{all_fashion = AllFashion} = get_fashions(UID),
  lists:keyfind(FashionNo, #equip_fashion_data.no, AllFashion).

get_fashions(UID) ->
  [FashionInfo] = ets:lookup(?ETS_EQUIP_FASHION, UID),
  FashionInfo.

set_fashions(FashionInfo) ->
  ets:insert(?ETS_EQUIP_FASHION, FashionInfo).

del_fashion(UID, FashionNo) ->
  FashionInfo = get_fashions(UID),
  FashionInfo1 = do_del_fashion(FashionNo, FashionInfo),
  FashionInfo2 = case FashionInfo#equip_fashion_info.wear_fashion_no =:= FashionNo of
                true ->
                  FashionInfo1#equip_fashion_info{wear_fashion_no = 0};
                false ->
                  FashionInfo1
              end,
  set_fashion_info(FashionInfo2),
  lib_scene:notify_int_info_change_to_aoi(player, UID, [{?OI_CODE_EQUIP_FASHION, FashionInfo2#equip_fashion_info.wear_fashion_no}]), % AOI

  List = get_fashion_remain_time(player:get_PS(UID)),
  {ok, BinData} = pt_15:write(?PT_PERSON_FASHION_INFO, [List]),
  lib_send:send_to_sock(player:get_PS(UID), BinData),

  ?DEBUG_MSG("del_fashion   :   ~p, FashionInfo2 = ~p~n",[FashionNo,FashionInfo2]),
  PS = player:get_PS(UID),
  ply_attr:recount_all_attrs(PS).

set_fashion_info(FashionInfo) when is_record(FashionInfo, equip_fashion_info) ->
  ets:insert(?ETS_EQUIP_FASHION, FashionInfo).

player_change_fashion(PS, FashionNo) ->
  case get_fashions(player:get_id(PS)) of
    #equip_fashion_info{all_fashion = AllFashion} = FashionInfo ->
      case FashionNo =:= 0 of
        true ->
          FashionInfo1 = FashionInfo#equip_fashion_info{wear_fashion_no = FashionNo},
          set_fashion_info(FashionInfo1),
          lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_EQUIP_FASHION, FashionNo}]), % AOI
          ok;
        false ->
          case lists:keyfind(FashionNo, #equip_fashion_data.no, AllFashion) of
            #equip_fashion_data{no = FashionNo} ->
              FashionInfo2 = FashionInfo#equip_fashion_info{wear_fashion_no = FashionNo},
              set_fashion_info(FashionInfo2),
              lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_EQUIP_FASHION, FashionNo}]), % AOI
              ok;
            false ->
              {fail, ?PM_DATA_CONFIG_ERROR}
          end
      end;
    _ ->
      {fail, ?PM_DATA_CONFIG_ERROR}
  end.

get_fashion_remain_time(PS) ->
  FashionInfo = get_fashions(player:get_id(PS)),
  F = fun(X, Acc) ->
    No = X#equip_fashion_data.no,
    Expire = X#equip_fashion_data.expire,
    [{No, Expire} | Acc]
      end,
  lists:foldl(F, [], FashionInfo#equip_fashion_info.all_fashion).