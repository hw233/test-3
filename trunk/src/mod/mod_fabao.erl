%%%-------------------------------------------------------------------
%%% @author wujiancheng
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. 七月 2019 20:54
%%%-------------------------------------------------------------------
-module(mod_fabao).
-author("wujiancheng").
-include("fabao.hrl").
-include("common.hrl").
-include("prompt_msg_code.hrl").
-include("record.hrl").
-include("obj_info_code.hrl").
-include("pt_45.hrl").
-include("pt_13.hrl").



-export([load_player_data/1,get_info/1,displayer_my_fabao/4, wear_fabao/3,
        compose_fabao/2,advance/3,spirit_fabao/3,refinery_fabao/2,exchange_fragment/3,buy_special_fabao/2,
        db_save_player_fabao/1,destroy_fuyin/3,player_add_fuyin/4,takeon_fuyin/6,get_player_fuyin_info/1,
        compose_fuyin/3,update_fuyin_info/3,player_add_fuyin/5,create_flashprint_list/1,test/0]).

%加载玩家法宝
load_player_data(PlayerId) ->
  case lib_fabao:get_fabao_all_id(PlayerId) of
    [] ->
      Sql = " id ,player_id, no, star, degree, type ,sp_value , displayer, battle,
degree_num, degree_pro, cultivate_pro ,is_identify,eight_diagrams,skill_num,skill_array_1,skill_array_2,skill_array_3,magic_power,element ",
      case db:select_all(fabao, Sql, [{player_id, PlayerId}]) of
        [] -> % 没有
          ?TRACE("sizeof fabao: 0~n"),
          [];
        InfoList when is_list(InfoList) ->
          F = fun(X,{AccId, AccNo}) ->
            [Id ,PlayerId, No, Star, Degree, Type ,SpValue ,Displayer, Battle,
              DegreeNum, DegreePro, CultivatePro,IsIdentify, EightDiagram,SkillNum,SkillArray_1,SkillArray_2,SkillArray_3,MagicPower,Element] = X,
            EightDiagram_OS = util:bitstring_to_term(EightDiagram),
            MagicPower_OS = util:bitstring_to_term(MagicPower),
            FuYin_OS = util:bitstring_to_term(Element),
            FabaoData =
              #fabao_info{
                id = Id,
                player_id= PlayerId,
                no = No,
                star_num =Star,
                degree =Degree,
                type =Type,
                sp_value = SpValue,
                displayer = Displayer ,
                battle = Battle,
                degree_num = DegreeNum,
                degree_pro = DegreePro ,
                cultivate_pro = CultivatePro,
                is_identify = IsIdentify,
                eight_diagrams = EightDiagram_OS,
                skill_num =SkillNum,
                skill_array_1 = SkillArray_1,
                skill_array_2 = SkillArray_2,
                skill_array_3 =SkillArray_3 ,
                magic_power = MagicPower_OS,
                fu_yin = FuYin_OS},
            ets:insert(ets_fabao_info, FabaoData),
            %%记录出战的法宝,这里要计算一遍属性
            case Battle of
              1 ->
                lib_fabao:update_fabao_battle(PlayerId,Id);
              _ ->
                skip
            end,

            {[Id|AccId],[No|AccNo]}
              end,
          {AllFabaoId, AllFabaoNo} = lists:foldl(F,{[],[]} ,InfoList),

          lib_fabao:update_fabao_all_id(PlayerId,AllFabaoId),
          %%获取玩家特殊的法宝编号
          PlayerMisc = ply_misc:get_player_misc(PlayerId),
          AllFabaoNo2 = AllFabaoNo ++ PlayerMisc#player_misc.fabao_special,
          lib_fabao:update_fabao_all_no(PlayerId, AllFabaoNo2),
          load_player_fuyin(PlayerId)
      end;
    _FaBaoIds ->
      skip
  end.

%%获取法宝信息
get_info(PlayerId) ->
  case lib_fabao:get_fabao_all_id(PlayerId) of
    [] ->
      case load_player_data(PlayerId) of
        [] ->
          []; %玩家没拥有法宝，返回空列表
        _ ->
          IdList = lib_fabao:get_fabao_all_id(PlayerId),
          F =
            fun(X, Acc) ->
              FabaoInfo = lib_fabao:get_fabao_info(X),
              [FabaoInfo | Acc]
            end,
          lists:foldl(F, [], IdList)
      end;
    IdList ->
      F = fun(X, Acc) ->
        FabaoInfo = lib_fabao:get_fabao_info(X),
        [FabaoInfo | Acc]
          end,
      lists:foldl(F, [], IdList)

  end.

%%法宝展示
displayer_my_fabao(PlayerId, FabaoId,BodyAnim,Type) ->
  case lib_fabao:get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    FabaoInfo when is_record(FabaoInfo,fabao_info) ->
      case lib_fabao:get_fabao_all_no(PlayerId) of
        [] ->
          %没有法宝才会undefined, 不可能发生这种状态，除非数据错乱了
          lib_send:send_prompt_msg(PlayerId,?PM_NO_HAPPEN_DO);
        Nolist ->
          case Type of
            1 -> %展示
              case lists:member(BodyAnim, Nolist) of
                true ->
                  FabaoInfo2 = FabaoInfo#fabao_info{displayer = Type},
                  lib_fabao:update_fabao_info(FabaoInfo2),
                  %%通知12017
                  lib_scene:notify_int_info_change_to_aoi(player, PlayerId, [{?OI_CODE_FABAO_NO, BodyAnim}]),
                  %%保存展示阶数和外观到player_misc
                  PlayerMisc = ply_misc:get_player_misc(PlayerId),
                  PlayerMisc2  = PlayerMisc#player_misc{fabao_degree = FabaoInfo#fabao_info.degree, fabao_displayer =BodyAnim },
                  ply_misc:update_player_misc(PlayerMisc2),
                  {ok,Bin} = pt_45:write(?PT_FABAO_DISPLAYER,[FabaoInfo#fabao_info.no]),
                  lib_send:send_to_uid(PlayerId, Bin);
                false ->
                  lib_scene:notify_int_info_change_to_aoi(player, PlayerId, [{?OI_CODE_FABAO_NO, 0}])
              end;
            2 -> %不展示
              FabaoInfo2 = FabaoInfo#fabao_info{displayer = Type},
              lib_fabao:update_fabao_info(FabaoInfo2),
              lib_scene:notify_int_info_change_to_aoi(player, PlayerId, [{?OI_CODE_FABAO_NO, 0}]),
              PlayerMisc = ply_misc:get_player_misc(PlayerId),
              PlayerMisc2  = PlayerMisc#player_misc{fabao_degree = 0, fabao_displayer = 0 },
              ply_misc:update_player_misc(PlayerMisc2)
          end

      end
  end.

%%法宝佩戴
wear_fabao(PlayerId, FabaoId, Type) ->
  case lib_fabao:get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    FabaoInfo when is_record(FabaoInfo, fabao_info)->
      PS = player:get_PS(PlayerId),
      case Type of  %1表示佩戴， 2表示卸下
        1 ->
          % 属性的计算暂时先略过
          %佩戴的法宝灵力值小于5 无法佩戴
          case FabaoInfo#fabao_info.sp_value > 4 of
            true ->
              case lib_fabao:get_fabao_battle(PlayerId) of
                [] ->  %证明没穿戴过，不需要卸下
                  skip;
                LastWearId ->
                  ChangeInfo = lib_fabao:get_fabao_info(LastWearId), %%被卸下的法宝
                  lib_fabao:update_fabao_info(ChangeInfo#fabao_info{battle = 2})
              end,
              lib_fabao:update_fabao_battle(PlayerId,FabaoId),
              lib_fabao:update_fabao_info(FabaoInfo#fabao_info{battle = 1}),
              notify_cli_wear_fabao(PS, FabaoInfo#fabao_info.no);
            false ->
              lib_send:send_prompt_msg(PlayerId,?PM_FABAO_SPVALUE_LOW )
          end;
        2 ->  %卸下
          lib_fabao:delete_fabao_battle(PlayerId),
          lib_fabao:update_fabao_info(FabaoInfo#fabao_info{battle = 2}),
          notify_cli_wear_fabao(PS, 0)
      end,
      ply_attr:recount_all_attrs(PS)
  end.

%% 通知客户端：玩家穿戴法宝
notify_cli_wear_fabao(PS, FaBaoNo) ->
  MyId = player:get_id(PS),
  ?TRACE("notify_cli_wear_fabao(), Id=~p, FaBaoNo=~p~n", [MyId, FaBaoNo]),
  %% 通知aoi范围内的其他玩家
  lib_scene:notify_int_info_change_to_aoi(player, MyId, [{?OI_CODE_BATTLE_FABAO, FaBaoNo}]).

%%法宝的合成
compose_fabao(PlayerId,FabaoNo) ->
  %检测玩家是否已经拥有该法宝
  NoLists = lib_fabao:get_fabao_all_no(PlayerId),
  case lists:member(FabaoNo, NoLists) of
    true ->
      lib_send:send_prompt_msg(PlayerId,?PM_HAVE_THIS);
    false ->
      FabaoConfig =  data_fabao_config:get(FabaoNo),
      NeedCost = FabaoConfig#fabao_config.compose_need,
      case mod_inv:check_batch_destroy_goods(PlayerId, NeedCost)  of
        ok ->
          mod_inv:destroy_goods_WNC(PlayerId, NeedCost, ["mod_fabao", "compose"]),
          %按默认的星数生成对应八卦的位置
          %%[{X,[{GetAttrName,NewValue}]},···]
          %%生成法宝数据
          FabaoInfo = #fabao_info{
            player_id = PlayerId,
            no = FabaoNo,
            star_num =1,
            degree =1,
            type =FabaoConfig#fabao_config.type,
            sp_value = FabaoConfig#fabao_config.sp_value,
            displayer = 2 ,
            battle = 2,
            degree_num = 1,
            cultivate_pro = 10,
            is_identify =  2
          },
          db_insert_fabao(FabaoInfo);
        {fail, Reason} ->
          lib_send:send_prompt_msg(PlayerId, Reason)
      end

  end.

%% 法宝充灵
spirit_fabao(PlayerId, FabaoId, Feed) ->
  case lib_fabao:get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    FabaoInfo when is_record(FabaoInfo,fabao_info) ->
      FabaoAddValue = data_special_config:get('fabao_add_spirit_value'),
      {NeedGood, GetSpirit} = case Feed of
                                1 ->
                                  lists:nth(1, FabaoAddValue);
                                2 ->
                                  lists:nth(2, FabaoAddValue)
                              end,
      %% 是否足够道具
      case mod_inv:check_batch_destroy_goods(PlayerId, [{NeedGood, 1}])  of
        ok ->
          FaBaoNo = FabaoInfo#fabao_info.no,
          SpValue = FabaoInfo#fabao_info.sp_value,
          SpValueLim = (data_fabao_config:get(FaBaoNo))#fabao_config.sp_value,
          %% 灵气未满
          case SpValue < SpValueLim of
            true ->
              mod_inv:destroy_goods_WNC(PlayerId, [{NeedGood, 1}], ["mod_fabao", "spirit_fabao"]),
              NewSpValue = min(SpValue + GetSpirit, SpValueLim),
              NewFaBao = FabaoInfo#fabao_info{sp_value = NewSpValue},
              lib_fabao:update_fabao_info(NewFaBao),
              ?DEBUG_MSG("NewSpValue=======~p,NewFaBao===~p~n",[NewSpValue,NewFaBao]),
              {ok,Bin} = pt_45:write(?PT_FABAO_SPIRIT,[FabaoInfo#fabao_info.id, NewSpValue]),
              lib_send:send_to_uid(PlayerId, Bin);
            false ->
              lib_send:send_prompt_msg(PlayerId, ?PM_SPIRIT_LIMIT)
          end;
        {fail, Reason} ->
          lib_send:send_prompt_msg(PlayerId, Reason)
      end
  end.

%% 炼化法宝成长
refinery_fabao(PlayerId, FabaoId) ->
  case lib_fabao:get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    FabaoInfo when is_record(FabaoInfo,fabao_info) ->
      Star = FabaoInfo#fabao_info.star_num,
      NeedCost = (data_fabao_base_attr_growth_ratio:get(Star))#fabao_base_attr_growth_ratio.growth_ratio_wash_goods,
      %% 是否足够道具
      case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost])  of
        ok ->
          mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["mod_fabao", "refinery_fabao"]),
          %% 重置成长率:对应星数的{下限，上限}范围内按-0.2~0.2波动随机取值
          GrowthRatioMin = (data_fabao_base_attr_growth_ratio:get(Star))#fabao_base_attr_growth_ratio.growth_ratio_min,
          GrowthRatioMax = (data_fabao_base_attr_growth_ratio:get(Star))#fabao_base_attr_growth_ratio.growth_ratio_max,
          OldCultivatePro = FabaoInfo#fabao_info.cultivate_pro,
          GrowthFloatValue = data_special_config:get('fabao_growth_float_value'),
          Random = case OldCultivatePro == util:ceil(GrowthRatioMin*100) of
                     true ->
                       util:ceil(util:rand(0.0, GrowthFloatValue) * 100);
                     false ->
                       case OldCultivatePro == util:ceil(GrowthRatioMax*100) of
                         true ->
                           util:ceil(util:rand(-GrowthFloatValue, 0) * 100);
                         false ->
                           util:ceil(util:rand(-GrowthFloatValue, GrowthFloatValue) * 100)
                       end
                   end,
          CultivatePro = util:minmax(OldCultivatePro + Random, util:ceil(GrowthRatioMin*100), util:ceil(GrowthRatioMax*100)),
          NewFaBao = FabaoInfo#fabao_info{cultivate_pro = CultivatePro},
          lib_fabao:update_fabao_info(NewFaBao),
          PS = player:get_PS(PlayerId),
          ply_attr:recount_all_attrs(PS),
          ?DEBUG_MSG("CultivatePro=======~p~n",[CultivatePro]),
          {ok,Bin} = pt_45:write(?PT_FABAO_REFINING,[FabaoInfo#fabao_info.id, CultivatePro]),
          lib_send:send_to_uid(PlayerId, Bin);
        {fail, Reason} ->
          lib_send:send_prompt_msg(PlayerId, Reason)
      end
  end.

%% 法宝碎片兑换
exchange_fragment(PlayerId, FabaoNo, Type) ->
  ExchangeInfo = data_fabao_goods_exchange:get(Type),
  Num = ExchangeInfo#fabao_goods_exchange.exchange_goods_num,
  case Type of
    1 ->
      case lists:member(FabaoNo, ExchangeInfo#fabao_goods_exchange.get_goods) of
        true ->
          [ExchangeGoodNo] = ExchangeInfo#fabao_goods_exchange.exchange_goods,
          ExchangeGoodsNum = mod_inv:get_goods_count_in_bag_by_no(PlayerId, ExchangeGoodNo),
          case ExchangeGoodsNum < Num of
            false ->
              %% 检测背包是否已满
              case mod_inv:check_batch_add_goods(PlayerId, [{FabaoNo, 1}]) of
                {fail, _Reason} ->
                  lib_send:send_prompt_msg(PlayerId, ?PM_US_BAG_FULL);
                _ ->
                  mod_inv:destroy_goods_WNC(PlayerId, [{ExchangeGoodNo, Num}], ["mod_fabao", "compose"]),
                  mod_inv:batch_smart_add_new_goods(PlayerId, [{FabaoNo,1}], [{bind_state, 1}], ["mod_fabao", "exchange_fragment"]),
                  {ok,Bin} = pt_45:write(?PT_FABAO_FRAGMENT_EXCHANGE,[0]),
                  lib_send:send_to_uid(PlayerId, Bin)
              end;
            true ->
              lib_send:send_prompt_msg(PlayerId, ?PM_PAR_EXTEND_CAPACITY_GOODS_COUNT_LIMIT)
          end,
          ?DEBUG_MSG("PlayerId===~p,ExchangeNum===~p,ExchangeGoodsNum===~p",[PlayerId,Num,ExchangeGoodsNum]);
        false ->
          lib_send:send_prompt_msg(PlayerId, ?PM_GOODS_NOT_EXCHANGE)
      end;
    2 ->
      case lists:member(FabaoNo, ExchangeInfo#fabao_goods_exchange.exchange_goods) of
        true ->
          [TransformGoodNo] = ExchangeInfo#fabao_goods_exchange.get_goods,
          TransformGoodsNum = mod_inv:get_goods_count_in_bag_by_no(PlayerId, FabaoNo),
          case TransformGoodsNum < Num of
            false ->
              %% 检测背包是否已满
              case mod_inv:check_batch_add_goods(PlayerId, [{TransformGoodNo, 1}]) of
                {fail, _Reason} ->
                  lib_send:send_prompt_msg(PlayerId, ?PM_US_BAG_FULL);
                _ ->
                  mod_inv:destroy_goods_WNC(PlayerId, [{FabaoNo, Num}], ["mod_fabao", "compose"]),
                  mod_inv:batch_smart_add_new_goods(PlayerId, [{TransformGoodNo,1}], [{bind_state, 1}], ["mod_fabao", "exchange_fragment"]),
                  {ok,Bin} = pt_45:write(?PT_FABAO_FRAGMENT_TRANSFORM,[0]),
                  lib_send:send_to_uid(PlayerId, Bin)
              end;
            true ->
              lib_send:send_prompt_msg(PlayerId, ?PM_PAR_EXTEND_CAPACITY_GOODS_COUNT_LIMIT)
          end,
          ?DEBUG_MSG("PlayerId===~p,TransformNum===~p,TransformGoodsNum===~p",[PlayerId,Num,TransformGoodsNum]);
        false ->
          lib_send:send_prompt_msg(PlayerId, ?PM_GOODS_NOT_TRANSFORM)
      end
  end.

%% 购买特殊法宝外观
buy_special_fabao(PS, SpecialNo) ->
  PlayerId = player:get_id(PS),
  PlayerMisc = ply_misc:get_player_misc(PlayerId),
  FabaoSpecial = PlayerMisc#player_misc.fabao_special,
  %% 是否已拥有这个外观
  case lists:member(SpecialNo, FabaoSpecial) of
    true ->
      lib_send:send_prompt_msg(PlayerId, ?PM_HAVE_SPECIAL_NO);
    false ->
      ChangeAnim = (data_fabao_change_anim:get(SpecialNo))#fabao_change_anim.get_price,
      case ChangeAnim =/= 0 of
        true ->
          {MoneyType, CostNum} = ChangeAnim,
          case player:has_enough_money(PS, MoneyType, CostNum) of
            true ->
              %% 货币消耗
              player_syn:cost_money(PS, MoneyType, CostNum, ["mod_fabao", "buy_special_fabao"]),
              NewFabaoSpecial = [SpecialNo | FabaoSpecial],
              NewPlayerMisc = PlayerMisc#player_misc{fabao_special = NewFabaoSpecial },
              ply_misc:update_player_misc(NewPlayerMisc),
              AllNo = lib_fabao:get_fabao_all_no(PlayerId),
              NewAllNo = [SpecialNo|AllNo],
              lib_fabao:update_fabao_all_no(PlayerId, NewAllNo),
              ?DEBUG_MSG("FabaoSpecial====~p,NewFabaoSpecial====~p~n",[FabaoSpecial,NewFabaoSpecial]),
              {ok,Bin} = pt_45:write(?PT_FABAO_BUY_SPECIAL,[0, NewFabaoSpecial]),
              lib_send:send_to_uid(PlayerId, Bin);
            false ->
              lib_send:send_prompt_msg(PlayerId, ?PM_INTEGRAL_LIMIT)
          end;
        false -> skip
      end
  end.


%%保存法宝到数据库
db_insert_fabao(FabaoInfo) when is_record(FabaoInfo,fabao_info) ->
  EightDiagrams = util:term_to_bitstring(FabaoInfo#fabao_info.eight_diagrams),
  MagicPower = util:term_to_bitstring(FabaoInfo#fabao_info.magic_power),
  FuYin = util:term_to_bitstring(FabaoInfo#fabao_info.fu_yin),

  NewId = db:insert_get_id(fabao,
    [player_id, no,star, degree, type ,sp_value , displayer, battle,
      degree_num, degree_pro, cultivate_pro,is_identify ,eight_diagrams,skill_num,skill_array_1,skill_array_2,skill_array_3,magic_power,element ],

    [FabaoInfo#fabao_info.player_id, FabaoInfo#fabao_info.no,FabaoInfo#fabao_info.star_num, FabaoInfo#fabao_info.degree, FabaoInfo#fabao_info.type ,
      FabaoInfo#fabao_info.sp_value , FabaoInfo#fabao_info.displayer, FabaoInfo#fabao_info.battle,
      FabaoInfo#fabao_info.degree_num, FabaoInfo#fabao_info.degree_pro, FabaoInfo#fabao_info.cultivate_pro , FabaoInfo#fabao_info.is_identify,
      EightDiagrams,FabaoInfo#fabao_info.skill_num,FabaoInfo#fabao_info.skill_array_1,
      FabaoInfo#fabao_info.skill_array_2,FabaoInfo#fabao_info.skill_array_3,MagicPower,FuYin
    ]),
  NewId1 =
    case lib_account:is_global_uni_id(NewId) of
      true -> NewId;
      false ->
        GlobalId = lib_account:to_global_uni_id(NewId),
        db:update(FabaoInfo#fabao_info.player_id, fabao, ["id"], [GlobalId], "id", NewId),
        GlobalId
    end,
  lib_fabao:update_fabao_info( FabaoInfo#fabao_info{id = NewId1}),
%%  更新玩家所有法宝no
  AllId = lib_fabao:get_fabao_all_id(FabaoInfo#fabao_info.player_id),
  lib_fabao:update_fabao_all_id(FabaoInfo#fabao_info.player_id, [NewId1|AllId]),
  AllNo = lib_fabao:get_fabao_all_no(FabaoInfo#fabao_info.player_id),
  lib_fabao:update_fabao_all_no(FabaoInfo#fabao_info.player_id, [FabaoInfo#fabao_info.no|AllNo]),
  %通知前端生成的新法宝
  {ok, Bin} = pt_45:write(?PT_FABAO_INFO, [[FabaoInfo#fabao_info{id = NewId1}]]),
  lib_send:send_to_sock(player:get_PS(FabaoInfo#fabao_info.player_id), Bin).

%% 玩家离线后保存到数据库
db_save_player_fabao(PlayerId) ->
  case lib_fabao:get_fabao_all_id(PlayerId) of
    [] -> skip;
    FaobaoIds ->
      F = fun(FaobaoId) ->
            case lib_fabao:get_fabao_info(FaobaoId) of
              [] -> skip;
              R ->
                case R#fabao_info.is_dirty of
                  false -> skip;
                  true ->
                    EightDiagrams = util:term_to_bitstring(R#fabao_info.eight_diagrams),
                    MagicPower = util:term_to_bitstring(R#fabao_info.magic_power),
                    FuYin = util:term_to_bitstring(R#fabao_info.fu_yin),
                    db:replace(FaobaoId, fabao, [{id, FaobaoId}, {player_id, PlayerId}, {no, R#fabao_info.no}, {star, R#fabao_info.star_num}, {degree, R#fabao_info.degree},
                      {type, R#fabao_info.type}, {sp_value, R#fabao_info.sp_value}, {displayer, R#fabao_info.displayer},
                      {battle, R#fabao_info.battle}, {degree_num, R#fabao_info.degree_num}, {degree_pro, R#fabao_info.degree_pro},
                      {cultivate_pro, R#fabao_info.cultivate_pro},{is_identify, R#fabao_info.is_identify}, {eight_diagrams, EightDiagrams}, {skill_num, R#fabao_info.skill_num}, {skill_array_1, R#fabao_info.skill_array_1},
                      {skill_array_2, R#fabao_info.skill_array_2}, {skill_array_3, R#fabao_info.skill_array_3}, {magic_power, MagicPower}, {element, FuYin}])
                end
            end
          end,
      lists:foreach(F, FaobaoIds)
  end.


%%法宝进阶
advance(PlayerId,FabaoId,Type) -> % 1表示正常进阶，2表示一键进阶
  PS = player:get_PS(PlayerId),
  FabaoInfo = lib_fabao:get_fabao_info(FabaoId),
  %%由于策划的表也没给限制多少阶的，只能写死处理10阶10重为满
  Degree = FabaoInfo#fabao_info.degree,
  DegreeNum = FabaoInfo#fabao_info.degree_num,
  DegreePro = FabaoInfo#fabao_info.degree_pro,
  case Degree == 10 andalso DegreeNum > 10 of
    true ->
      lib_send:send_prompt_msg(PlayerId, ?PM_MK_SKILL_LV_LIMIT);
    false ->
      case Type of
        1 ->
          AdvanceData = data_fabao_advance:get(Degree,DegreeNum),
          NeedCost = [{AdvanceData#fabao_advance.alchemy_no,AdvanceData#fabao_advance.alchemy_num}],
          {NeedType, NeedGameMoney} = AdvanceData#fabao_advance.bind_gamemoney,
          %检查满足条件的物品消耗
          case mod_inv:check_batch_destroy_goods(PlayerId, NeedCost)  of
            ok ->
              case player:has_enough_money(PS, NeedType, NeedGameMoney) of
                true ->
                  player:cost_money(PS, NeedType, NeedGameMoney, ["mod_fabao","advance"]),
                  mod_inv:destroy_goods_WNC(PlayerId, NeedCost, ["mod_fabao","advance"]),
                  %%当前的进度
                  AddCultivate =AdvanceData#fabao_advance.get_cultivate,
                  case (AddCultivate + DegreePro) >= AdvanceData#fabao_advance.cultivate_next_lv_need of
                    true ->
                      %判断是升重还是升阶
                      case DegreeNum > 10 of
                        true ->
                          FabaoInfo2 = FabaoInfo#fabao_info{degree = Degree + 1, degree_num = 1,  degree_pro = 0 },
                          lib_fabao:update_fabao_info(FabaoInfo2),
                          {ok, Bin} = pt_45:write(?PT_FABAO_ADVANCE, [FabaoId, Degree + 1 , 1 , 0]),
                          lib_send:send_to_uid(PlayerId, Bin),
                          PlayerMisc = ply_misc:get_player_misc(PlayerId),
                          case FabaoInfo2#fabao_info.displayer =:= 1 of
                            true ->
                              PlayerMisc2  = PlayerMisc#player_misc{fabao_degree = Degree + 1 },
                              ply_misc:update_player_misc(PlayerMisc2),
                              lib_scene:notify_int_info_change_to_aoi(player, PlayerId, [{?OI_CODE_FABAO_NO, 0}]),
                              lib_scene:notify_int_info_change_to_aoi(player, PlayerId, [{?OI_CODE_FABAO_NO, PlayerMisc#player_misc.fabao_displayer}]);
                            false ->
                              skip
                          end;
                        false ->
                          FabaoInfo2 = FabaoInfo#fabao_info{ degree_num = DegreeNum + 1,  degree_pro = 0 },
                          lib_fabao:update_fabao_info(FabaoInfo2),
                          {ok, Bin} = pt_45:write(?PT_FABAO_ADVANCE, [FabaoId, Degree  ,  DegreeNum + 1 , 0]),
                          lib_send:send_to_uid(PlayerId, Bin)
                      end;
                    false ->
                      FabaoInfo2 = FabaoInfo#fabao_info{ degree_pro = DegreePro + 1  },
                      lib_fabao:update_fabao_info(FabaoInfo2),
                      {ok, Bin} = pt_45:write(?PT_FABAO_ADVANCE, [FabaoId, Degree  , DegreeNum , DegreePro + 1]),
                      lib_send:send_to_uid(PlayerId, Bin)

                  end;
                false -> lib_send:send_prompt_msg(PlayerId, ?PM_GAMEMONEY_LIMIT)
              end;
            {fail, Reason} ->
              lib_send:send_prompt_msg(PlayerId, Reason)
          end;
        2 -> %一键进阶
          %%仅仅为了拿物品编号
          AdvanceForGoods1 = data_fabao_advance:get(1,1),
          AdvanceForGoods2 = data_fabao_advance:get(1,11),
          %一直递归下去？
          [Degree2,DegreeNum2,DegreePro2,MoneyCount1,MoneyCount2,GoodsCount1,GoodsCount2]
            = up_degree_num(PlayerId,[ Degree, DegreeNum, DegreePro, 0, 0, 0, 0]),
          {NeedType1, _} = AdvanceForGoods1#fabao_advance.bind_gamemoney,
          {NeedType2, _} = AdvanceForGoods2#fabao_advance.bind_gamemoney,
          player:cost_money(PS, NeedType1, MoneyCount1, ["mod_fabao","advance"]),
          player:cost_money(PS, NeedType2, MoneyCount2, ["mod_fabao","advance"]),

          NeedCost2 = [{AdvanceForGoods1#fabao_advance.alchemy_no,GoodsCount1},{AdvanceForGoods2#fabao_advance.alchemy_no,GoodsCount2}],
          mod_inv:destroy_goods_WNC(PlayerId, NeedCost2, ["mod_fabao","advance"]),
          case (MoneyCount1 + MoneyCount2 + GoodsCount1 + GoodsCount2) > 0  of
            true ->
              FabaoInfo2 = FabaoInfo#fabao_info{ degree =  Degree2, degree_num = DegreeNum2,  degree_pro = DegreePro2 },
              lib_fabao:update_fabao_info(FabaoInfo2),
              {ok, Bin} = pt_45:write(?PT_FABAO_ADVANCE, [FabaoId, Degree2  , DegreeNum2 , DegreePro2]),
              lib_send:send_to_uid(PlayerId, Bin),
              case Degree =/= Degree2 andalso FabaoInfo2#fabao_info.displayer =:= 1 of
                true ->
                  PlayerMisc3 = ply_misc:get_player_misc(PlayerId),
                  PlayerMisc4  = PlayerMisc3#player_misc{fabao_degree = Degree + 1 },
                  ply_misc:update_player_misc(PlayerMisc4),
                  lib_scene:notify_int_info_change_to_aoi(player, PlayerId, [{?OI_CODE_FABAO_NO, 0}]),
                  lib_scene:notify_int_info_change_to_aoi(player, PlayerId, [{?OI_CODE_FABAO_NO, PlayerMisc3#player_misc.fabao_displayer}]);
                false ->
                  skip
              end;
            false ->
              skip
          end
      end
  end.


%用于一键升阶
up_degree_num(PlayerId,DataLists) when is_list(DataLists) ->
  [Degree,DegreeNum,DegreePro,MoneyCount1,MoneyCount2,GoodsCount1,GoodsCount2] = DataLists,
  ?DEBUG_MSG("---------Degree----------~p--------------DegreeNum---------~p~n",[Degree,DegreeNum]),
  case Degree == 10 andalso DegreeNum > 10 of
    true ->
      DataLists;
    false ->
      PS = player:get_PS(PlayerId),
      AdvanceInfo = data_fabao_advance:get(Degree,DegreeNum),
      {NeedType, NeedGameMoney} = AdvanceInfo#fabao_advance.bind_gamemoney,
      %%仅仅为了拿物品编号
      AdvanceForGoods1 = data_fabao_advance:get(1,1),
      AdvanceForGoods2 = data_fabao_advance:get(1,11),
      NeedCost = case DegreeNum > 10 of
                   true -> [{AdvanceForGoods1#fabao_advance.alchemy_no, GoodsCount1}, {AdvanceForGoods2#fabao_advance.alchemy_no, GoodsCount2 + AdvanceInfo#fabao_advance.alchemy_num}];
                   false -> [{AdvanceForGoods1#fabao_advance.alchemy_no, GoodsCount1 + AdvanceInfo#fabao_advance.alchemy_num}, {AdvanceForGoods2#fabao_advance.alchemy_no, GoodsCount2}]
                 end,
      NeedMoney = case DegreeNum > 10 of
                   true ->
                     NewMoneyCount1 = MoneyCount1,
                     NewMoneyCount2 = MoneyCount2 + NeedGameMoney,
                     NewMoneyCount2;
                   false ->
                     NewMoneyCount2 = MoneyCount2,
                     NewMoneyCount1 = MoneyCount1 + NeedGameMoney,
                     NewMoneyCount1
                 end,
      case mod_inv:check_batch_destroy_goods(PlayerId, NeedCost) of
        ok ->
          case player:has_enough_money(PS, NeedType, NeedMoney) of
            true ->
              AddCultivate =AdvanceInfo#fabao_advance.get_cultivate,
              case (AddCultivate + DegreePro) >= AdvanceInfo#fabao_advance.cultivate_next_lv_need of
                true ->
                  %判断是升重还是升阶
                  case DegreeNum > 10 of
                    true ->
                      %%消耗的物品也不同
                      DataLists2 = [Degree + 1, 1, 0, NewMoneyCount1, NewMoneyCount2, GoodsCount1, GoodsCount2 + AdvanceInfo#fabao_advance.alchemy_num ],
                      up_degree_num(PlayerId,DataLists2);
                    false ->
                      DataLists2 = [Degree, DegreeNum + 1, 0, NewMoneyCount1, NewMoneyCount2, GoodsCount1+ AdvanceInfo#fabao_advance.alchemy_num , GoodsCount2  ],
                      up_degree_num(PlayerId,DataLists2)
                  end;
                false ->
                  DataLists2 = [Degree, DegreeNum, DegreePro + 1, NewMoneyCount1, NewMoneyCount2, GoodsCount1 + AdvanceInfo#fabao_advance.alchemy_num, GoodsCount2 ],
                  up_degree_num(PlayerId,DataLists2)

              end;
            false ->
              lib_send:send_prompt_msg(PlayerId, ?PM_LIMIT_GAMEMONEY_ADVANCE),
              DataLists
          end;
        {fail, _} ->
          lib_send:send_prompt_msg(PlayerId, ?PM_LIMIT_GOODS_ADVANCE),
          DataLists
      end
  end.

test() ->
  PlayerId = 1000100000000759,
  PS = player:get_PS(PlayerId),
  advance(PlayerId, 1000100000000002, 2),
%%  refinery_fabao(PlayerId, 1000100000000002),
%%    takeon_fuyin(PlayerId, 1000100000000002, 1, 3, 1000100000000007, 1),
  skpi.

%% 仅仅为了前端处理数据方便
create_flashprint_list(FuyinList) ->
  F = fun(X, FlashPrintAcc) ->
        Data = #flashprint{
                  type = X,
                  fuyin_id1 = 0,
                  fuyin_no1 = 0,
                  fuyin_id2 = 0,
                  fuyin_no2 = 0,
                  fuyin_id3 = 0,
                  fuyin_no3 = 0
                },
        [{X, Data} | FlashPrintAcc]
      end,
  FlashPrintList = lists:reverse(lists:foldl(F, [], lists:seq(1, 6))),
  %% 构建镶嵌符印结构
  F2 = fun(Fuyin, FlashDataList) ->
            Id = Fuyin#fabao_fuyin.id,
            No = Fuyin#fabao_fuyin.no,
            Type = Fuyin#fabao_fuyin.type,
            Position = Fuyin#fabao_fuyin.position,
            FlashData= lists:nth(Type, FlashDataList),
            case Position of
              1 ->
                Index1 = #flashprint.fuyin_id1,
                Index2 = #flashprint.fuyin_no1,
                {Index, FlashPrint} = FlashData,
                NewFlashPrint1 = setelement(Index1, FlashPrint, Id),
                NewFlashPrint2 = setelement(Index2, NewFlashPrint1, No),
                NewFlashData = {Index, NewFlashPrint2},
                lists:keyreplace(Index, 1, FlashDataList, NewFlashData);
              2 ->
                Index3 = #flashprint.fuyin_id2,
                Index4 = #flashprint.fuyin_no2,
                {Index, FlashPrint} = FlashData,
                NewFlashPrint3 = setelement(Index3, FlashPrint, Id),
                NewFlashPrint4 = setelement(Index4, NewFlashPrint3, No),
                NewFlashData = {Index, NewFlashPrint4},
                lists:keyreplace(Index, 1, FlashDataList, NewFlashData);
              3 ->
                Index5 = #flashprint.fuyin_id3,
                Index6 = #flashprint.fuyin_no3,
                {Index, FlashPrint} = FlashData,
                NewFlashPrint5 = setelement(Index5, FlashPrint, Id),
                NewFlashPrint6 = setelement(Index6, NewFlashPrint5, No),
                NewFlashData = {Index, NewFlashPrint6},
                lists:keyreplace(Index, 1, FlashDataList, NewFlashData);
              _ ->
                FlashDataList
            end
       end,
  NewFlashDataList = lists:foldl(F2, FlashPrintList, FuyinList),
  NewFlashDataList.

%加载玩家法宝信息
load_player_fuyin(PlayerId) ->
  case lib_fabao:get_fuyin_all_id(PlayerId) of
    [] ->
      Sql = "id, player_id, no, fabao_id, count, type, lv, position",
      FuyinIds = case db:select_all(fabao_goods, Sql, [{player_id, PlayerId}]) of
                   [] -> % 没有
                     ?TRACE("do not have fabao fuyin: 0~n"),
                     [];
                   FuyinList when is_list(FuyinList) ->
                     F = fun(X, AccId) ->
                           [Id ,PlayerId, No, FabaoId, Count, Type ,Lv, Position] = X,
                           FuyinData = #fabao_fuyin{
                             id = Id,
                             player_id= PlayerId,
                             no = No,
                             fabao_id = FabaoId,
                             count = Count,
                             type = Type,
                             lv = Lv,
                             position = Position
                           },
                           lib_fabao:update_fabao_fuyin(FuyinData),
                           [Id|AccId]
                         end,
                     lists:foldl(F, [], FuyinList)
                 end,
      lib_fabao:update_fuyin_all_id(PlayerId, FuyinIds);
    _AllId -> skip
  end.

%%获取玩家法宝符印详细信息
get_player_fuyin_info(PlayerId) ->
  load_player_fuyin(PlayerId),
  FuyinList = lib_fabao:get_fuyin_by_player_bag(PlayerId),
  F = fun(Fuyin, FuyinAcc) ->
        #fabao_fuyin{
          id = Id,
          no = No,
          count = Count
        } = Fuyin,
        [{Id, No, Count} | FuyinAcc]
      end,
  FuyinData = lists:foldl(F, [], FuyinList),
  FuyinData.

%%法宝符印佩戴/卸下，1为佩戴，2为卸下
takeon_fuyin(PlayerId, FabaoId, SetType, Position, FuyinId, Type) ->
  case lib_fabao:get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    Fabao ->
      case lib_fabao:get_fabao_fuyin(FuyinId) of
        [] ->
          lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS_FUYIN);
        Fuyin ->
          case Fuyin#fabao_fuyin.type =:= SetType of
            false ->
              lib_send:send_prompt_msg(PlayerId, ?PM_FUYIN_TYPE_INCONSIS);
            true ->
              %% 获取法宝上镶嵌的某个类型的符印
              TakeonFuyinList = lib_fabao:get_fuyin_by_player_fuyin_type(PlayerId, FabaoId, SetType),
              Count = get_fuyin_count_by_id(TakeonFuyinList),
              case Type of
                1 ->
                  case Fabao#fabao_info.star_num >= Fuyin#fabao_fuyin.lv of
                    false ->
                      lib_send:send_prompt_msg(PlayerId, ?PM_FABAO_STAR_NOT_ENOUGH);
                    true ->
                      case Count < ?MAX_FUYIN_MOSAIC_LIMIT_NUM of
                        false ->
                          lib_send:send_prompt_msg(PlayerId, ?PM_FUYIN_TAKEON_LIMIT);
                        true ->
                          case lib_fabao:get_fuyin_by_type_and_position(PlayerId, FabaoId, SetType, Position) of
                            [] ->
                              NewId = change_db_by_take_fuyin(PlayerId, Fuyin, FabaoId, Position, 1),
                              {ok, Bin} = pt_45:write(?PT_FABAO_FUYIN_MOSAIC, [FabaoId, SetType, Position, Fuyin#fabao_fuyin.no, NewId]),
                              lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
                              ply_attr:recount_all_attrs(player:get_PS(PlayerId));
                            _Fuyin ->
                              lib_send:send_prompt_msg(PlayerId, ?PM_MK_FUYIN_LIMIT)
                          end
                      end
                  end;
                2 ->
                  case lib_fabao:get_fuyin_by_type_and_position(PlayerId, FabaoId, SetType, Position) of
                    [] ->
                      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS_FUYIN);
                    _Fuyin ->
                      change_db_by_take_fuyin(PlayerId, Fuyin, FabaoId, Position, 2),
                      {ok, Bin} = pt_45:write(?PT_FABAO_FUYIN_MOSAIC, [FabaoId, SetType, Position, 0, 0]),
                      lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
                      ply_attr:recount_all_attrs(player:get_PS(PlayerId))
                  end
              end
          end
      end
  end.

%%镶嵌和卸下符印发生的数据变化
change_db_by_take_fuyin(PlayerId, TargetFuyin, FabaoId, Position, Type) ->
  ?ASSERT(is_record(TargetFuyin, fabao_fuyin)),
  TargetId = TargetFuyin#fabao_fuyin.id,
  TargetNo = TargetFuyin#fabao_fuyin.no,
  case Type of
    1 ->
      %% 销毁背包符印
      destroy_fuyin(PlayerId, [TargetId], 1),
      %% 生成新的镶嵌符印
      Lv = (data_fabao_rune_attr:get(TargetNo))#fabao_rune_attr.lv,
      SetType = (data_fabao_rune_attr:get(TargetNo))#fabao_rune_attr.set_type,
      Id = db:insert_get_id(fabao_goods, [player_id, no, fabao_id, count, type, lv, position], [PlayerId, TargetNo, FabaoId, 1, SetType, Lv, Position]),
      NewId = case lib_account:is_global_uni_id(Id) of
                true -> Id;
                false ->
                  GlobalId = lib_account:to_global_uni_id(Id),
                  db:update(fabao_goods, ["id"], [GlobalId], "id", Id),
                  GlobalId
              end,
      FuyinData = #fabao_fuyin{
        id = NewId,
        player_id= PlayerId,
        no = TargetNo,
        fabao_id = FabaoId,
        count = 1,
        type = SetType,
        lv = Lv,
        position = Position
      },
      AllIdList = lib_fabao:get_fuyin_all_id(PlayerId),
      lib_fabao:update_fuyin_all_id(PlayerId, [NewId|AllIdList]),
      lib_fabao:update_fabao_fuyin(FuyinData),
      NewId;
    2 ->
      %% 销毁镶嵌符印
      destroy_fuyin(PlayerId, [TargetId], 1),
      %% 获取尚未叠满的符印
      case get_not_full_fuyin_by_no(PlayerId, TargetNo, 0, 0) of
        [] ->
          Lv = (data_fabao_rune_attr:get(TargetNo))#fabao_rune_attr.lv,
          SetType = (data_fabao_rune_attr:get(TargetNo))#fabao_rune_attr.set_type,
          Id = db:insert_get_id(fabao_goods, [player_id, no, fabao_id, count, type, lv, position], [PlayerId, TargetNo, 0, 1, SetType, Lv, 0]),
          NewId = case lib_account:is_global_uni_id(Id) of
                    true -> Id;
                    false ->
                      GlobalId = lib_account:to_global_uni_id(Id),
                      db:update(fabao_goods, ["id"], [GlobalId], "id", Id),
                      GlobalId
                  end,
          FuyinData = #fabao_fuyin{
            id = NewId,
            player_id= PlayerId,
            no = TargetNo,
            fabao_id = 0,
            count = 1,
            type = SetType,
            lv = Lv,
            position = 0
          },
          AllIdList = lib_fabao:get_fuyin_all_id(PlayerId),
          lib_fabao:update_fuyin_all_id(PlayerId, [NewId|AllIdList]),
          lib_fabao:update_fabao_fuyin(FuyinData),
          %% 通知客户端
          FuyinList = [{NewId, TargetNo, 1}],
          {ok, Bin} = pt_45:write(?PT_FABAO_FUYIN_DETAILS, [FuyinList]),
          lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
          NewId;
        FuyinInfo ->
          UpdateCount = FuyinInfo#fabao_fuyin.count + 1,
          update_fuyin_info(PlayerId, FuyinInfo, UpdateCount),
          FuyinInfo#fabao_fuyin.id
      end
  end.

%%合成符印 1为正常合成，2为一键自动合成
compose_fuyin(PlayerId, Type, FuyinId) ->
  PS = player:get_PS(PlayerId),
  case Type of
    1 ->
      case lib_fabao:get_fabao_fuyin(FuyinId) of
        [] ->
          lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS_FUYIN);
        FuyinInfo ->
          Compose = data_fabao_rune_compose:get(FuyinInfo#fabao_fuyin.no),
          case FuyinInfo#fabao_fuyin.count < Compose#fabao_rune_compose.need_goods_num of
            true ->
              lib_send:send_prompt_msg(PlayerId, ?PM_FUYIN_NOT_ENOUGH);
            false ->
              [{NeedType, NeedMoney}] = Compose#fabao_rune_compose.money,
              case player:has_enough_money(PS, NeedType, NeedMoney) of
                true ->
                  player:cost_money(PS, NeedType, NeedMoney, ["mod_fabao","compose_fuyin"]),
                  destroy_fuyin(PlayerId, [FuyinId], Compose#fabao_rune_compose.need_goods_num),
                  player_add_fuyin(PS, Compose#fabao_rune_compose.get_goods_no, 0, 1),
                  {ok, Bin} = pt_45:write(?PT_FABAO_FUYIN_COMPOSE, [?RES_OK]),
                  lib_send:send_to_sock(PS, Bin);
                false ->
                  lib_send:send_prompt_msg(PlayerId, ?PM_MONEY_LIMIT)
              end
          end
      end;
    2 ->
      FuyinInfo = lib_fabao:get_fabao_fuyin(FuyinId),
      TargetCount = FuyinInfo#fabao_fuyin.count,
      Compose = data_fabao_rune_compose:get(FuyinInfo#fabao_fuyin.no),
      GetCount = TargetCount div Compose#fabao_rune_compose.need_goods_num,
      case GetCount > 0 of
        true ->
          [{NeedType, NeedMoney}] = Compose#fabao_rune_compose.money,
          case player:has_enough_money(PS, NeedType, NeedMoney*GetCount) of
            true ->
              player:cost_money(PS, NeedType, NeedMoney*GetCount, ["mod_fabao","compose_fuyin"]),
              NeedCost = GetCount * Compose#fabao_rune_compose.need_goods_num,
              destroy_fuyin(PlayerId, [FuyinId], NeedCost),
              player_add_fuyin(PS, Compose#fabao_rune_compose.get_goods_no, 0, GetCount),
              {ok, Bin} = pt_45:write(?PT_FABAO_FUYIN_COMPOSE, [?RES_OK]),
              lib_send:send_to_sock(PS, Bin);
            false ->
              lib_send:send_prompt_msg(PlayerId, ?PM_MONEY_LIMIT)
          end;
        false ->
          lib_send:send_prompt_msg(PlayerId, ?PM_FUYIN_NOT_ENOUGH)
      end
  end.

%%检测是否是同一类符印
check_fuyin_no_by_id(FuyinList) ->
  case length(FuyinList) =:= 0 of
    true ->
      {false, ?PM_FUYIN_NOT_ENOUGH};
    false ->
      FirstFuyinId = lists:nth(1, FuyinList),
      case lib_fabao:get_fabao_fuyin(FirstFuyinId) of
        [] ->
          ?ASSERT(false),
          ?ERROR_MSG("mod_fabao:check_fuyin_no_by_id error!~n", []);
        FirstFuyin ->
          F = fun(X) ->
                case lib_fabao:get_fabao_fuyin(X) of
                  [] ->
                    false;
                  FuyinInfo ->
                    FirstFuyin#fabao_fuyin.no =:= FuyinInfo#fabao_fuyin.no
                end
              end,
          case lists:all(F, FuyinList) of
            true ->
              ok;
            false ->
              {false, ?PM_FUYIN_TYPE_INCONSIS}
          end
      end
  end.

%%获取该列表下的符印数量总和
get_fuyin_count_by_id(FuyinList) ->
  F = fun(X, Acc) ->
        case lib_fabao:get_fabao_fuyin(X) of
          [] -> Acc;
          FuyinIfo ->
            FuyinIfo#fabao_fuyin.count + Acc
        end
      end,
  lists:foldl(F, 0, FuyinList).


%% 销毁符印：符印数量不足则销毁，否则更改数量
destroy_fuyin(PlayerId, [H|T], Count) when Count > 0 ->
  case lib_fabao:get_fabao_fuyin(H) of
    [] ->
      ?ASSERT(false),
      ?ERROR_MSG("mod_fabao:destroy_fuyin error!~n", []);
    FuyinInfo ->
      TargetId = FuyinInfo#fabao_fuyin.id,
      case FuyinInfo#fabao_fuyin.count =< Count of
        true ->
          NewCount = Count - FuyinInfo#fabao_fuyin.count,
          %% 删除目标符印数据
          AllIdList = lib_fabao:get_fuyin_all_id(PlayerId),
          NewAllIdList = lists:delete(TargetId, AllIdList),
          db:delete(fabao_goods, [{id, TargetId}]),
          lib_fabao:delete_fabao_fuyin(TargetId),
          lib_fabao:update_fuyin_all_id(PlayerId, NewAllIdList),
          %% 通知客户端
          FuyinList = [{TargetId, FuyinInfo#fabao_fuyin.no, 0}],
          {ok, Bin} = pt_45:write(?PT_FABAO_FUYIN_DETAILS, [FuyinList]),
          lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
          %% 继续销毁
          case NewCount =:= 0 of
              true ->
                  void;
              false ->
                  destroy_fuyin(PlayerId, T, NewCount)
          end;
        false ->
          %% 修改目标符印数据
          NewCount = FuyinInfo#fabao_fuyin.count - Count,
          db:update(fabao_goods, [{count, NewCount}], [{id, TargetId}]),
          lib_fabao:update_fabao_fuyin(FuyinInfo#fabao_fuyin{count = NewCount}),
          %% 通知客户端
          FuyinList = [{TargetId, FuyinInfo#fabao_fuyin.no, NewCount}],
          {ok, Bin} = pt_45:write(?PT_FABAO_FUYIN_DETAILS, [FuyinList]),
          lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
      end
  end;
destroy_fuyin(_PlayerId, _FuyinId, 0) ->
  void.

%% 更新符印数据
update_fuyin_info(PlayerId, FuyinInfo, NewCount) when is_record(FuyinInfo, fabao_fuyin) ->
  FuyinId = FuyinInfo#fabao_fuyin.id,
  db:update(fabao_goods, [{count, NewCount}], [{id, FuyinId}]),
  lib_fabao:update_fabao_fuyin(FuyinInfo#fabao_fuyin{count = NewCount}),
  %% 通知客户端
  FuyinList = [{FuyinId, FuyinInfo#fabao_fuyin.no, NewCount}],
  {ok, Bin} = pt_45:write(?PT_FABAO_FUYIN_DETAILS, [FuyinList]),
  lib_send:send_to_sock(player:get_PS(PlayerId), Bin).


%% 玩家获得法宝符印
%% FuyinNo 符印编号
%% FabaoId 法宝Id
%% Count 增加符印数量
%% Position 符印镶嵌位置1,2,3
player_add_fuyin(PS, FuyinNo, FabaoId, Count) ->
  player_add_fuyin(PS, FuyinNo, FabaoId, Count, 0).

player_add_fuyin(PS, FuyinNo, FabaoId, Count, Position) ->
  PlayerId = player:get_id(PS),
  %% 获取尚未叠满的符印
  case get_not_full_fuyin_by_no(PlayerId, FuyinNo, FabaoId, Position) of
    [] ->
      InsertCount = min(Count, ?MAX_FUYIN_LIMIT_NUM),
      Lv = (data_fabao_rune_attr:get(FuyinNo))#fabao_rune_attr.lv,
      Type = (data_fabao_rune_attr:get(FuyinNo))#fabao_rune_attr.set_type,
      Id = db:insert_get_id(fabao_goods, [player_id, no, fabao_id, count, type, lv, position], [PlayerId, FuyinNo, FabaoId, InsertCount, Type, Lv, Position]),
      NewId = case lib_account:is_global_uni_id(Id) of
                true -> Id;
                false ->
                  GlobalId = lib_account:to_global_uni_id(Id),
                  db:update(fabao_goods, ["id"], [GlobalId], "id", Id),
                  GlobalId
              end,
      FuyinData = #fabao_fuyin{
        id = NewId,
        player_id= PlayerId,
        no = FuyinNo,
        fabao_id = FabaoId,
        count = InsertCount,
        type = Type,
        lv = Lv,
        position = Position
      },
      AllIdList = lib_fabao:get_fuyin_all_id(PlayerId),
      lib_fabao:update_fuyin_all_id(PlayerId, [NewId|AllIdList]),
      lib_fabao:update_fabao_fuyin(FuyinData),
      %% 通知客户端
      FuyinList = [{NewId, FuyinNo, InsertCount}],
      {ok, Bin} = pt_45:write(?PT_FABAO_FUYIN_DETAILS, [FuyinList]),
      lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
      %% 是否再次获得数量是否溢出
      case Count > ?MAX_FUYIN_LIMIT_NUM of
        true ->
          AddCount = Count - ?MAX_FUYIN_LIMIT_NUM,
          player_add_fuyin(PS, FuyinNo, FabaoId, AddCount);
        false ->
          skip
      end;
    FuyinInfo ->
      UpdateCount = min(FuyinInfo#fabao_fuyin.count + Count, ?MAX_FUYIN_LIMIT_NUM),
      update_fuyin_info(PlayerId, FuyinInfo, UpdateCount),
      case (FuyinInfo#fabao_fuyin.count + Count) > ?MAX_FUYIN_LIMIT_NUM of
        true ->
          NewCount = FuyinInfo#fabao_fuyin.count + Count - ?MAX_FUYIN_LIMIT_NUM,
          player_add_fuyin(PS, FuyinNo, FabaoId, NewCount);
        false ->
          skip
      end
  end.

%% 获取叠加数量尚未上限的符印
get_not_full_fuyin_by_no(PlayerId, FuyinNo, FabaoId, Position) ->
  FuyinList = lib_fabao:get_fuyin_by_player_fuyin_no(PlayerId, FabaoId, FuyinNo, Position),
  FuyinInfo = get_not_full_fuyin(FuyinList),
  FuyinInfo.

get_not_full_fuyin([H|T]) ->
  case H#fabao_fuyin.count < ?MAX_FUYIN_LIMIT_NUM of
    true ->
      H;
    false ->
      get_not_full_fuyin(T)
  end;
get_not_full_fuyin([]) -> [].









