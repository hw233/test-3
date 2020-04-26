%% @author wujiancheng
%% @doc @todo Add description to lib_wing.


-module(lib_wing).

-include("chibang.hrl").
-include("pt_44.hrl").
-include("diy.hrl").
-include("prompt_msg_code.hrl").

-export([get_all_wing/1,init_all_wing/1,
  cacul_all_wing/1,add_wing/3,add_wing/4, feed_wing/5,get_use_wing_no/1,check_player_add_wing/2]).

get_all_wing(PlayerId) ->
  case ets:lookup(ets_player_wing, PlayerId) of
    [] ->
      skip;
    [R] ->
      UseId = R#player_wing.wing_id,
      UseNo = R#player_wing.use_wing,
      AllId = R#player_wing.all_wing_id,
      F = fun(X , Acc) ->
            [WingList,DiyWingList] = Acc,
            [WingInfo] = ets:lookup(ets_wing_info, {PlayerId,X}),
            Type = WingInfo#wing_info.type,
            WingNo = WingInfo#wing_info.wing_no,
            Lv = WingInfo#wing_info.lv,
            Exp = WingInfo#wing_info.exp,
            case Type of
              0 ->
                [[{X, WingNo, Lv, Exp, Type}|WingList], DiyWingList];
              _ ->
                Attrs = WingInfo#wing_info.attrs,
                [WingList, [{X, WingNo, Lv, Exp, Type, Attrs}|DiyWingList]]
            end
          end,
      [AllWingInfo, AllDiyWingInfo] = lists:foldl(F, [[],[]], AllId),
      {ok, Bin} = pt_44:write(?PT_GET_WING, [UseId, UseNo, AllWingInfo, AllDiyWingInfo]),
      lib_send:send_to_sock(player:get_PS(PlayerId), Bin)

  end.

%玩家上线初始化所有翅膀
init_all_wing(PlayerId) ->

  case ets:lookup(ets_player_wing, PlayerId) of
    [] ->
      case db:select_all(wing, "wing_id ,wing_no, exp, lv, use_state, type, attrs", [{player_id, PlayerId}]) of
        [] ->   ok;
        DataList ->
          Fun = fun([WingId, WingNo, Exp, Lv, UseState, Type, Attrs],Acc) ->
                  [WingIds, WingState, UseWingId]= Acc,
                  ets:insert(ets_wing_info, #wing_info{player_key = {PlayerId, WingId},
                    wing_no = WingNo, type = Type, lv = Lv, exp = Exp, attrs = util:bitstring_to_term(Attrs)}),
                  case UseState of
                    0 ->
                      [[WingId|WingIds], WingState, UseWingId];
                    1 ->
                      [[WingId|WingIds], WingNo, WingId]
                  end
                end,
          [AllWing,IsUseNo,IsUseId] = lists:foldl(Fun, [[],0,0], DataList),
          ets:insert(ets_player_wing,#player_wing{player_id =PlayerId, use_wing =IsUseNo, wing_id = IsUseId, all_wing_id = AllWing })
      end;
    _ ->
      skip
  end.

%获取已穿戴的翅膀编号
get_use_wing_no(PlayerId) ->
  case ets:lookup(ets_player_wing, PlayerId) of
    [] ->
      0;
    [R] ->
      R#player_wing.use_wing
  end.



%计算所有翅膀的属性加成   配置表里面的基础值*等级*（系数+等级/50）{ok, B} =  pt_44:write(44004, [1, 10000]).   lib_send:send_to_sock(player:get_PS(1010800000000338), B).
cacul_all_wing(PlayerId) ->
  case ets:lookup(ets_player_wing, PlayerId) of
    [] ->
      [];
    [R] ->
      AllWing = R#player_wing.all_wing_id,
      Fun = fun(X,Acc) ->
              [WingInfo] = ets:lookup(ets_wing_info, {PlayerId,X}),
              Lv = WingInfo#wing_info.lv,
              Type = WingInfo#wing_info.type,
              %% 是否定制翅膀
              AttrList = case Type of
                           0 ->
                             WingNo = WingInfo#wing_info.wing_no,
                             data_chibang:get_attr(WingNo);
                           _ ->
                             DiyWing = data_diy_chibang_config:get(Type),
                             ChibangAddAttr = DiyWing#diy_chibang_config.chibang_add_attr,
                             AttrsNum = WingInfo#wing_info.attrs,
                             F = fun(X, Attr) ->
                                  [lists:nth(X, ChibangAddAttr) | Attr]
                                 end,
                             lists:foldl(F, [], AttrsNum)
                         end,
              %% 翅膀基础属性公式
              Fun2 = fun({AttrName,BaseAttr, AttrCoef},Acc2) ->
                        [{AttrName, BaseAttr * Lv * (AttrCoef + Lv/50)} |Acc2]
                     end,
              Acc ++ lists:foldl(Fun2, [], AttrList)
            end,
      lists:foldl(Fun, [], AllWing)
  end.

%获取翅膀调用
add_wing(PlayerId, No, Type) ->
  add_wing(PlayerId, No, Type, []).

add_wing(PlayerId, No, Type, ExtraInitInfo) ->
  %% 是否定制
  case Type of
    0 ->
      WingIds = case ets:lookup(ets_player_wing, PlayerId) of
                  [] -> [];
                  [PlayWing] -> PlayWing#player_wing.all_wing_id
                end,
      F = fun(X,Acc) ->
            [WingInfo] = ets:lookup(ets_wing_info, {PlayerId,X}),
            case WingInfo#wing_info.type =:= 0 of
              true -> [WingInfo#wing_info.wing_no|Acc];
              false -> Acc
            end
          end,
      WingList = lists:foldl(F, [], WingIds),
      case lists:member(No, WingList) of
        false ->
          NewRoleLocalId = db:insert_get_id(wing,["player_id","wing_no","exp","lv","use_state","type"],[PlayerId, No, 0, 1, 0, 0]),
          WingId = lib_account:to_global_uni_id(NewRoleLocalId),
          db:update(PlayerId,wing, ["wing_id"], [WingId], "wing_id", NewRoleLocalId),
          ets:insert(ets_wing_info, #wing_info{player_key = {PlayerId, WingId},
            wing_no = No, type = 0, lv = 1, exp = 0}),
          case ets:lookup(ets_player_wing, PlayerId) of
            [] ->
              ets:insert(ets_player_wing,#player_wing{player_id =PlayerId, use_wing =0, all_wing_id = [WingId] });
            [R] ->
              ets:insert(ets_player_wing,R#player_wing{ all_wing_id = [ WingId|R#player_wing.all_wing_id] })
          end,
          get_all_wing(PlayerId),
          ply_attr:recount_all_attrs(player:get_PS(PlayerId));
        true ->
          skip
      end;
    _ ->
      NewRoleLocalId = db:insert_get_id(wing,["player_id","wing_no","exp","lv","use_state","type","attrs"],[PlayerId, No, 0, 1, 0, Type, util:term_to_bitstring(ExtraInitInfo)]),
      WingId = lib_account:to_global_uni_id(NewRoleLocalId),
      db:update(PlayerId,wing, ["wing_id"], [WingId], "wing_id", NewRoleLocalId),
      ets:insert(ets_wing_info, #wing_info{player_key = {PlayerId, WingId},
        wing_no = No, type = Type, lv = 1, exp = 0, attrs = ExtraInitInfo}),
      case ets:lookup(ets_player_wing, PlayerId) of
        [] ->
          ets:insert(ets_player_wing,#player_wing{player_id =PlayerId, use_wing =0, all_wing_id = [WingId] });
        [R] ->
          ets:insert(ets_player_wing,R#player_wing{ all_wing_id = [ WingId|R#player_wing.all_wing_id] })
      end,
      get_all_wing(PlayerId),
      ply_attr:recount_all_attrs(player:get_PS(PlayerId))
  end.



%喂养翅膀
feed_wing(PlayerId,WingId,WingNo,Count,Type) ->
  [WingInfo] = ets:lookup(ets_wing_info, {PlayerId,WingId}),
  WingExp = WingInfo#wing_info.exp,
  WingLv = WingInfo#wing_info.lv,
  ChibangInfo = data_chibang:get_chibang_info(WingNo),
  {GoodsNo,GoodsExp} = case Type of
    0 ->
      ChibangInfo#chibang_info.train_goods1;
    1 ->
      ChibangInfo#chibang_info.train_goods2;
    2 ->
      ChibangInfo#chibang_info.train_goods3
  end,
  case mod_inv:check_batch_destroy_goods(PlayerId, [{GoodsNo, Count}])  of
    ok ->
      Count2 = (data_chibang_exp:get( data_chibang:get_max_lv(10000) - 1 ) - WingExp) div GoodsExp + 1,
      Count3 = case Count2 > Count of
                 true ->
                   Count;
                 false ->
                   Count2
               end,
      mod_inv:destroy_goods_WNC(PlayerId, [{GoodsNo, Count3}], ["lib_wing", "feed"]),
      GetExp  =  Count3 * GoodsExp,
      NewExp  = GetExp + WingExp,
      NewLv = new_lv(NewExp,WingLv),
      DisplayExp  =
        case  NewLv > 1  of
          true ->
            NewExp -  data_chibang_exp:get(NewLv - 1);
          false ->
            NewExp
        end,
      {ok, Bin}= pt_44:write(?PT_TRAIN_WING,[WingId,WingNo,NewLv,DisplayExp]),
      lib_send:send_to_sock(player:get_PS(PlayerId),Bin ),
      db:update(wing, [{exp, NewExp}, {lv, NewLv}], [{player_id,PlayerId},{wing_id,WingId}]),
      ets:insert(ets_wing_info,WingInfo#wing_info{exp = NewExp, lv = NewLv } ),
      ply_attr:recount_all_attrs(player:get_PS(PlayerId));
    {fail, Reason} ->
      lib_send:send_prompt_msg(PlayerId, Reason)
  end.

new_lv(Exp, Lv) ->
  UpgradeExp = data_chibang_exp:get(Lv),
  case Exp >=  UpgradeExp of
    true ->
      new_lv(Exp, Lv +1);
    false ->
      Lv
  end.

%判断能不能获取翅膀
check_player_add_wing(PlayerId, WingNo) ->
  WingIds = case ets:lookup(ets_player_wing, PlayerId) of
               [] -> [];
               [R] -> R#player_wing.all_wing_id
            end,
  F = fun(X,Acc) ->
        [WingInfo] = ets:lookup(ets_wing_info, {PlayerId,X}),
        case WingInfo#wing_info.type =:= 0 of
          true -> [WingInfo#wing_info.wing_no|Acc];
          false -> Acc
        end
      end,
  WingList = lists:foldl(F, [], WingIds),
  case lists:member(WingNo, WingList) of
    false ->
      ok;
    true ->
      {fail, ?PM_USE_WING_REPEAT}
  end.











	
	
	
