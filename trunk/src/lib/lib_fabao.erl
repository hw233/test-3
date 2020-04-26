%%%-------------------------------------------------------------------
%%% @author wujiancheng
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. 七月 2019 21:35
%%%-------------------------------------------------------------------
-module(lib_fabao).
-author("wujiancheng").
-include("fabao.hrl").
-include("prompt_msg_code.hrl").
-include("debug.hrl").
-include("pt_45.hrl").
-include("common.hrl").
-include("record.hrl").


-export([update_fabao_all_id/2, update_fabao_info/1,
  get_fabao_all_id/1,get_fabao_all_no/1, get_fabao_info/1, update_fabao_battle/2,reset_diagrams_attr/3,
  delete_fabao_battle/1, star_upgrade/3,get_fabao_battle/1,attr_all_fabao/1,update_fabao_all_no/2,
  get_diagrams_attrs/1,refresh_diagrams_attrs/4,replace_diagrams_attrs/4,identifyiagrams_attrs/3,cal_diagrams_attrs/1,
  calc_one_base_attrs/1,update_fabao_fuyin/1,update_fuyin_all_id/2,get_fabao_fuyin/1,get_fuyin_all_id/1,delete_fabao_fuyin/1,
  get_player_all_fabao_fuyin/1,get_fuyin_by_player_fuyin_type/3,get_fuyin_by_player_fuyin_no/4,get_fuyin_by_type_and_position/4,
  get_fuyin_by_player_fabao_id/2, activate_magic_skill/3,get_fuyin_by_player_bag/1,upgrade_magic_skill/4,buy_magic_skill_count/4,rest_magic_skill_count/2 , up_or_dowm_skill/4,cacul_magic_base_attrs/1]).

update_fabao_all_id(PlayerId,IdList) when is_list(IdList) ->
  ets:insert(ets_fabao_all_id, {PlayerId, IdList}).

update_fabao_all_no(PlayerId, Nolist) when is_list(Nolist) ->
  ets:insert(ets_fabao_all_no, {PlayerId,Nolist}).

update_fabao_info(Data) when is_record(Data,fabao_info) ->
  ets:insert(ets_fabao_info, Data#fabao_info{is_dirty = true}).

get_fabao_all_id(PlayerId) ->
  case ets:lookup(ets_fabao_all_id, PlayerId) of
    [] -> [];
    [{_PlayerId, AllId}] -> AllId
  end.  %%玩家所有法宝的id的列表，在请求时加载一次

get_fabao_all_no(PlayerId) ->
  case ets:lookup(ets_fabao_all_no, PlayerId) of
    [] -> [];
    [{_PlayerId, AllNo}] -> AllNo
  end.   %%玩家所有法宝的NO的列表

get_fabao_info(FabaoId) ->
  case ets:lookup(ets_fabao_info,FabaoId) of
    [] -> [];
    [R] -> R
  end.


%更新出战法宝id
update_fabao_battle(PlayerId,FabaoId) ->
  ets:insert(ets_fabao_is_battle, {PlayerId, FabaoId}).

%删除出战法宝id
delete_fabao_battle(PlayerId) ->
  ets:delete(ets_fabao_is_battle, PlayerId).

%获取出战法宝id
get_fabao_battle(PlayerId) ->
  case ets:lookup(ets_fabao_is_battle, PlayerId) of
    [] -> [];
    [{_PlayerId, FaBaoId}] -> FaBaoId
  end.
%%%%%%%%%%% 符印相关
%更新法宝符印
update_fabao_fuyin(Data) when is_record(Data,fabao_fuyin) ->
  ets:insert(ets_fabao_fuyin, Data).

%更新法宝符印id
update_fuyin_all_id(PlayerId,IdList) when is_list(IdList) ->
  ets:insert(ets_fabao_fuyin_all_id, {PlayerId, IdList}).

%%删除单个法宝符印
delete_fabao_fuyin(FuyinId) ->
  ets:delete(ets_fabao_fuyin, FuyinId).

%获得法宝符印信息
get_fabao_fuyin(FuYinId) ->
  case ets:lookup(ets_fabao_fuyin, FuYinId) of
    [] -> [];
    [R] -> R
  end.

%获取所有符印id
get_fuyin_all_id(PlayerId) ->
  case ets:lookup(ets_fabao_fuyin_all_id, PlayerId) of
    [] -> [];
    [{_PlayerId, AllId}] -> AllId
  end.

%获取玩家所有法宝符印数据
get_player_all_fabao_fuyin(PlayerId) ->
  FuyinIds = get_fuyin_all_id(PlayerId),
  F = fun(FuyinId, Acc) ->
    case get_fabao_fuyin(FuyinId) of
      FuyinInfo when is_record(FuyinInfo, fabao_fuyin) ->
        [FuyinInfo | Acc];
      _ ->
        Acc
    end
      end,
  lists:foldl(F, [], FuyinIds).

%获取玩家符印背包中的符印
get_fuyin_by_player_bag(PlayerId) ->
  FuyinInfo = get_player_all_fabao_fuyin(PlayerId),
  [X || X <- FuyinInfo, X#fabao_fuyin.fabao_id =:= 0].

%获取玩家某个法宝镶嵌的符印
get_fuyin_by_player_fabao_id(PlayerId, FabaoId) ->
  FuyinInfo = get_player_all_fabao_fuyin(PlayerId),
  [X || X <- FuyinInfo, X#fabao_fuyin.fabao_id =:= FabaoId].

%获取玩家符印背包中某一类型的符印（1风2林3火4山5阴6雷）
get_fuyin_by_player_fuyin_type(PlayerId, FabaoId, Type) ->
  FuyinInfo = get_player_all_fabao_fuyin(PlayerId),
  [X || X <- FuyinInfo, X#fabao_fuyin.fabao_id =:= FabaoId, X#fabao_fuyin.type =:= Type].

%获取玩家某个法宝（或背包）中镶嵌指定编号的符印
get_fuyin_by_player_fuyin_no(PlayerId, FabaoId, FuyinNo, Position) ->
  FuyinInfo = get_player_all_fabao_fuyin(PlayerId),
  [X || X <- FuyinInfo, X#fabao_fuyin.fabao_id =:= FabaoId, X#fabao_fuyin.no =:= FuyinNo, X#fabao_fuyin.position =:= Position].

%获取玩家某个法宝指定类型和指定位置下的符印
get_fuyin_by_type_and_position(PlayerId, FabaoId, Type, Position) ->
  FuyinInfo = get_player_all_fabao_fuyin(PlayerId),
  [X || X <- FuyinInfo, X#fabao_fuyin.fabao_id =:= FabaoId, X#fabao_fuyin.type =:= Type, X#fabao_fuyin.position =:= Position].


%% 法宝升星
star_upgrade(PS, Feed, FaBaoId) ->
  case get_fabao_info(FaBaoId) of
    [] -> {fail, ?PM_NO_HAVE_THIS};
    FaBao ->
      FaBaoNo = FaBao#fabao_info.no,
      Star = FaBao#fabao_info.star_num,
      case Star >= ?MAX_STAR_LIMIT_LV of
        true ->
          {fail, ?PM_HOME_LV_MAX};
        false ->
          FaBaoInfo = data_fabao_config:get(FaBaoNo),
          %% 获取升星消耗
          StepNeedGoods = FaBaoInfo#fabao_config.step_need_goods,
          StepNeedNum = FaBaoInfo#fabao_config.step_need_num,
          NeedGood = lists:nth(Feed,StepNeedGoods),
          {_NextStar, NeedNum} = lists:nth(Star, StepNeedNum),
          case mod_inv:check_batch_destroy_goods(PS, [{NeedGood,NeedNum}])  of
            ok ->
              NewStar = Star + 1,
              %% 消耗道具
              mod_inv:destroy_goods_WNC(PS, [{NeedGood,NeedNum}], ["lib_fabao", "star_upgrade"]),
              %% 基础属性
              GrowthValue = FaBao#fabao_info.cultivate_pro,
              NowGrowthMax = (data_fabao_base_attr_growth_ratio:get(Star))#fabao_base_attr_growth_ratio.growth_ratio_max,
              NextGrowthMax = (data_fabao_base_attr_growth_ratio:get(NewStar))#fabao_base_attr_growth_ratio.growth_ratio_max,
              %% 升星后成长率=(升星前成长率/升星前满成长)*升星后满成长
              NewGrowthValue = util:ceil(GrowthValue / (NowGrowthMax * 100) * (NextGrowthMax * 100)),
              NewFaBao = FaBao#fabao_info{star_num = NewStar, cultivate_pro = NewGrowthValue},
              %%升星对应的八卦
%%              NewDiagramsData =
%%                case FaBao#fabao_info.is_identify of
%%                  1 ->
%%                    %已经鉴定了
%%                    DiagramsNum = (data_fabao_base_attr_growth_ratio:get(Star))#fabao_base_attr_growth_ratio.diagrams_attr,
%%                    %拿到的数据有可能是两个index
%%                    DiagramsData = lib_fabao:get_diagrams_attrs(DiagramsNum),
%%                    %%拼接下发送给前端并保存起来的数据类型
%%                    DiagramsF =
%%                      fun(DiagramsX, Acc) ->
%%                        %DiagramsX可能是一条属性或者两条
%%                        [{Index ,AttrsList}] = DiagramsX,
%%                        case length(AttrsList)  == 1 of
%%                          true ->
%%                            [{GetAttrName,NewValue}] = AttrsList,
%%                            [{Index, GetAttrName, 0 , NewValue, 0 , 0 , 0 }|Acc];
%%                          false ->
%%                            %%目前顶多两条属性
%%                            [{GetAttrName1,NewValue1},{GetAttrName2,NewValue2}] = AttrsList,
%%                            [{Index, GetAttrName1, GetAttrName2 , NewValue1, NewValue2 , 0 , 0 } | Acc ]
%%                        end
%%                      end,
%%                    DiagramsData2 = lists:foldl(DiagramsF, [] , DiagramsData),
%%                    %%发送给前端
%%                    {ok,Bin} = pt_45:write(?PT_FABAO_DIAGRAMS_GET_BY_STAR,[FaBaoId, DiagramsData2]),
%%                    lib_send:send_to_uid(player:get_id(PS), Bin),
%%                    DiagramsData2;
%%                  _ ->
%%                    []
%%                end,
%%              update_fabao_info(NewFaBao#fabao_info{eight_diagrams = NewDiagramsData}),
              update_fabao_info(NewFaBao),
              ply_attr:recount_all_attrs(PS),
              ?DEBUG_MSG("NeedGood====~p,NeedNum====~p~n",[NeedGood,NeedNum]),
              {ok, FaBaoId, NewFaBao#fabao_info.star_num, NewGrowthValue};
            {fail, Reason} ->
              {fail, Reason}
          end
      end
  end.

%% 获取法宝所有属性加成
attr_all_fabao(PlayerId) ->
  case get_fabao_battle(PlayerId) of
    [] -> [];
    FaBaoId ->
      case get_fabao_info(FaBaoId) of
        [] -> [];
        FaBao ->
          attr_base_bonus(FaBao) ++ attr_fuyin_all_bonus(PlayerId, FaBaoId)
      end
  end.

%% 获取基础属性加成
attr_base_bonus(FaBao) ->
  No = FaBao#fabao_info.no,
  CultivatePro = FaBao#fabao_info.cultivate_pro,
  Star = FaBao#fabao_info.star_num,
  Attrs = (data_fabao_config:get(No))#fabao_config.attr,
  BaseAttrGrowth = data_fabao_base_attr_growth_ratio:get(Star),
  F = fun(X, AttrList) ->
    case lists:keyfind(X, 1, BaseAttrGrowth#fabao_base_attr_growth_ratio.attr) of
      {AttrName, AttrValue1, AttrValue2} ->
        %% 法宝基础属性=成长率*浮动值*对应星数属性/10 (法宝成长值/100)
        NewValue = util:ceil(CultivatePro * BaseAttrGrowth#fabao_base_attr_growth_ratio.float_value * AttrValue1 / 1000),
        [{AttrName, NewValue, AttrValue2} | AttrList ];
      false ->
        AttrList
    end
      end,
  BaseAttrList = lists:foldl(F, [], Attrs),
  ?DEBUG_MSG("------Star--~p------FaBaoBaseAttrList------------~p~n",[Star,BaseAttrList]),
  BaseAttrList.

%% 获取佩戴法宝的符印属性加成(基础属性 + 组合属性)
attr_fuyin_all_bonus(PlayerId, FaBaoId) ->
  FuyinList = get_fuyin_by_player_fabao_id(PlayerId, FaBaoId),
  F = fun(FuyinInfo, AttrList) ->
    {BaseAttrList, CombinNoList} = AttrList,
    FuyinNo = FuyinInfo#fabao_fuyin.no,
    FuyinNum = FuyinInfo#fabao_fuyin.count,
    NewCombinNoList = case lists:keyfind(FuyinNo, 1, CombinNoList) of
                        false ->
                          [{FuyinNo, FuyinNum} | CombinNoList];
                        {_FuyinNo, Count} ->
                          Member = {FuyinNo, Count + FuyinNum},
                          lists:keyreplace(FuyinNo, 1, CombinNoList, Member)
                      end,
    {calc_one_base_attrs(FuyinNo) ++ BaseAttrList, NewCombinNoList}
      end,
  FuyinAttrLlist = lists:foldl(F, {[],[]}, FuyinList),
  %% 基础属性 + 组合属性
  {BaseAttrList1, CombinNoList1} = FuyinAttrLlist,
  F2 = fun({No, Num}, AccAttrList) ->
    calc_one_combin_attrs(No, Num) ++ AccAttrList
       end,
  CombinAttrList = lists:foldl(F2, [], CombinNoList1),
  ?DEBUG_MSG("BaseAttrList1---------~p,CombinNoList1-----~p,CombinAttrList-----~p~n",[BaseAttrList1,CombinNoList1,CombinAttrList]),
  BaseAttrList1 ++ CombinAttrList.

%% 获取单类符印的组合加成
calc_one_combin_attrs(FuyinNo, Num) ->
  case data_fabao_rune_combin_effect:get(FuyinNo) of
    null -> [];
    Data ->
      case Num =:= Data#fabao_rune_combin_effect.rune_combin_num of
        false -> [];
        true ->
          Data#fabao_rune_combin_effect.rune_combin_effect
      end
  end.

%% 获取单个符印的属性加成
calc_one_base_attrs(FuYinNo) ->
  case data_fabao_rune_attr:get(FuYinNo) of
    null -> [];
    Data ->
      case Data#fabao_rune_attr.attr_type of
        %% 物理攻击值
        ?FUYIN_TYPE_PHY_ATT ->
          Para = Data#fabao_rune_attr.ratio,
          ?ASSERT(is_integer(Para), Para),
          [{phy_att, Para, 0}];
        %% 法术攻击值
        ?FUYIN_TYPE_MAG_ATT ->
          Para = Data#fabao_rune_attr.ratio,
          ?ASSERT(is_integer(Para), Para),
          [{mag_att, Para, 0}];
        %% 物理防御值
        ?FUYIN_TYPE_PHY_DEF ->
          Para = Data#fabao_rune_attr.ratio,
          ?ASSERT(is_integer(Para), Para),
          [{phy_def, Para, 0}];
        %% 法术防御值
        ?FUYIN_TYPE_MAG_DEF ->
          Para = Data#fabao_rune_attr.ratio,
          ?ASSERT(is_integer(Para), Para),
          [{mag_def, Para, 0}];
        %% 生命上限值
        ?FUYIN_TYPE_HP_LIM ->
          Para = Data#fabao_rune_attr.ratio,
          ?ASSERT(is_integer(Para), Para),
          [{hp_lim, Para, 0}];
        %% 速度值
        ?FUYIN_TYPE_ACT_SPEED ->
          Para = Data#fabao_rune_attr.ratio,
          ?ASSERT(is_integer(Para), Para),
          [{act_speed, Para, 0}];
        %% 封印命中值
        ?FUYIN_TYPE_SEAL_HIT ->
          Para = Data#fabao_rune_attr.ratio,
          ?ASSERT(is_integer(Para), Para),
          [{seal_hit, Para, 0}];
        %% 抗封印命中值
        ?FUYIN_TYPE_SEAL_RESIS ->
          Para = Data#fabao_rune_attr.ratio,
          ?ASSERT(is_integer(Para), Para),
          [{seal_resis, Para, 0}];
        %% 治疗强度
        ?FUYIN_TYPE_HEAL_VALUE ->
          Para = Data#fabao_rune_attr.ratio,
          ?ASSERT(is_integer(Para), Para),
          [{heal_value, Para, 0}];
        _ ->
          ?ASSERT(false, Data),
          []
      end
  end.


%% 获取八卦属性时，生成随机的属性，与重置可共用
get_diagrams_attrs(ListNo) ->
  ListNo2 =  tuple_to_list(ListNo),
  F =
    fun(X,Acc) ->
      %%获取随机属性以及属性条目
      FabaoDiagramsRec = data_fabao_diagrams_attr:get(X),
      %%得出总概率
      AllAttrs = FabaoDiagramsRec#fabao_diagrams_attr.attr,
      F2 =
        fun(X2, Acc2) ->
          {_AttrName,{ProVal,[_MinValue,_MaxValue]}} = X2,
          ProVal +  Acc2
        end,
      AllPro = lists:foldl(F2 , 0 , AllAttrs),

      %%特效
      EffAllAtts1 = FabaoDiagramsRec#fabao_diagrams_attr.effect1,
      EffAllAtts2 = FabaoDiagramsRec#fabao_diagrams_attr.effect2,
      F3 =
        fun(X3, Acc3) ->
          {EffProVal1,_} =X3,
          EffProVal1 + Acc3
        end,
      EffAllPro1 = lists:foldl(F3,0,EffAllAtts1),

      EffAllPro2 = lists:foldl(F3,0,EffAllAtts2),
      %确定是属性还是特效
      case FabaoDiagramsRec#fabao_diagrams_attr.attr2_chance == 0 of
        true -> %等于0，则是特效的
          %判断是一条还是两条
          case random:uniform(1000) >= FabaoDiagramsRec#fabao_diagrams_attr.effect2_chance of
            true ->
              %%只有一条
              RandomValue = random:uniform(EffAllPro1),
              {_,EffNos}= get_one_eff_by_pro(0,RandomValue,EffAllAtts1),
              %随机取列表一个值
              EffNo = lists:nth(random:uniform(length(EffNos)), EffNos),
              [{X,[{EffNo,0}]}|Acc];
            false ->
              RandomValue = random:uniform(EffAllPro1),
              {_,EffNos}= get_one_eff_by_pro(0,RandomValue,EffAllAtts1),
              %随机取列表一个值
              EffNo = lists:nth(random:uniform(length(EffNos)), EffNos),

              RandomValue2 = random:uniform(EffAllPro2),
              {_,EffNos2}= get_one_eff_by_pro(0,RandomValue2,EffAllAtts2),
              %随机取列表一个值
              EffNo2 = lists:nth(random:uniform(length(EffNos2)), EffNos2),

              [{X,[{EffNo,0},{EffNo2,0}]}|Acc]

          end;
        false ->
          %%先确定是两条还是一条
          case random:uniform(1000) >= FabaoDiagramsRec#fabao_diagrams_attr.attr2_chance of
            true ->
              %%只有一条
              RandomValue = random:uniform(AllPro),
              {GetAttrName,{_GetProVal,[GetMinValue,GetMaxValue]}} = get_one_attrs_by_pro(0,RandomValue,AllAttrs ),
              %%从范围随机获取一个值
              NewValue = util:rand(GetMinValue,GetMaxValue),
              %%这里我再做个限制，防止玩家容易洗到最好的属性
              NewValue2 =
                case NewValue >= GetMaxValue * 0.85 of
                  true ->
                    %百分之五十从最大值取
                    case random:uniform(2) of
                      1 ->
                        util:rand(GetMinValue,NewValue);
                      2 ->
                        util:rand(GetMinValue,util:ceil(NewValue* 0.9))
                    end;
                  false ->
                    NewValue
                end,
              [{X,[{GetAttrName,NewValue2}]}|Acc];
            false ->
              %%两条属性
              RandomValue = random:uniform(AllPro),
              {GetAttrName1,{_GetProVal1,[GetMinValue1,GetMaxValue1]}} = get_one_attrs_by_pro(0,RandomValue,AllAttrs ),
              %%从范围随机获取一个值
              NewValue1 = util:rand(GetMinValue1,GetMaxValue1),

              NewValue2 =
                case NewValue1 >= GetMaxValue1 * 0.85 of
                  true ->
                    %百分之五十从最大值取
                    case random:uniform(2) of
                      1 ->
                        util:rand(GetMinValue1,NewValue1);
                      2 ->
                        util:rand(GetMinValue1,util:ceil(NewValue1* 0.9))
                    end;
                  false ->
                    NewValue1
                end,

              RandomValue2 = random:uniform(AllPro),
              {GetAttrName2,{_GetProVal2,[GetMinValue2,GetMaxValue2]}} = get_one_attrs_by_pro(0,RandomValue2,AllAttrs ),
              %%从范围随机获取一个值
              NewValue3 = util:rand(GetMinValue2,GetMaxValue2),
              NewValue4 =
                case NewValue3 >= GetMaxValue2 * 0.85 of
                  true ->
                    %百分之五十从最大值取
                    case random:uniform(2) of
                      1 ->
                        util:rand(GetMinValue2,NewValue3);
                      2 ->
                        util:rand(GetMinValue2,util:ceil(NewValue3* 0.9))
                    end;
                  false ->
                    NewValue3
                end,

              [{X,[{GetAttrName1,NewValue2}|[{GetAttrName2,NewValue4}]]}| Acc]
          end

      end

    end,
  lists:foldl(F, [] , ListNo2).

%%(默认值,随机值，lists)
get_one_attrs_by_pro(BaseVal,RandomVal, AllAttrs) ->
  [H|T] = AllAttrs,
  {_AttrName,{ProVal,[_MinValue,_MaxValue]}} = H,
  case  BaseVal + ProVal >=  RandomVal of
    true ->
      %获得该属性的值
      H;
    false ->
      %继续递归
      get_one_attrs_by_pro( BaseVal + ProVal,RandomVal, T )
  end.

%%(默认值,随机值，lists)
get_one_eff_by_pro(BaseVal,RandomVal, AllEff) ->
  [H|T] = AllEff,
  {ProVal,_} = H,
  case  BaseVal + ProVal >=  RandomVal of
    true ->
      %获得该属性的值
      H;
    false ->
      %继续递归
      get_one_eff_by_pro( BaseVal + ProVal,RandomVal, T )
  end.


%%重置八卦某个位置的属性  1、如果法宝是出战的话，还需要重算一遍属性 2、如果是特效需要特殊处理
reset_diagrams_attr(PlayerId ,FabaoId, Index) ->
  case get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    RecordData  ->
      EightDiagrams = RecordData#fabao_info.eight_diagrams,
      case  lists:keytake(Index, 1, EightDiagrams) of
        false ->
          lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAPPEN_DO);
        {value,{Index, AttrName1, AttrName2 , NewValue1, NewValue2 , _ , _ },RestList} ->
          ResetCost = (data_fabao_diagrams_attr:get(Index))#fabao_diagrams_attr.reset_cost,
          ResetPrice = (data_fabao_diagrams_attr:get(Index))#fabao_diagrams_attr.reset_price,
          [{ResetType, ResetNum}] = ResetPrice,
          %检查满足条件的物品消耗
          case mod_inv:check_batch_destroy_goods(PlayerId, ResetCost)  of
            ok ->
              case player:has_enough_money(player:get_PS(PlayerId), ResetType, ResetNum) of
                true ->
                  mod_inv:destroy_goods_WNC(PlayerId, ResetCost, ["lib_fabao","reset_diagrams_attr"]),
                  player:cost_money(player:get_PS(PlayerId), ResetType, ResetNum, ["lib_fabao","reset_diagrams_attr"]),
                  %%获取新的随机属性
                  %%[{X,[{GetAttrName,NewValue}]},···]
                  DiagramsData = lib_fabao:get_diagrams_attrs({Index}),
                  [{_ ,AttrsList}] = DiagramsData,
                  case length(AttrsList)  == 1 of
                    true ->
                      %%判断是否是9和10的要特殊处理
                      case Index > 8 of
                        true ->
                          [{GetAttrName,NewValue}] = AttrsList,
                          NewDiagrams = [{Index, AttrName1, AttrName2 , NewValue, 0 , GetAttrName, 0 } | RestList],
                          update_fabao_info(RecordData#fabao_info{eight_diagrams =  NewDiagrams}),
                          {ok,Bin} = pt_45:write(?PT_FABAO_DIAGRAMS_RESET,[FabaoId, Index, AttrName1, AttrName2 , GetAttrName, 0]),
                          lib_send:send_to_uid(PlayerId, Bin);
                        false ->
                          [{GetAttrName,NewValue}] = AttrsList,
                          NewDiagrams = [{Index, GetAttrName, 0 , NewValue, 0 , 0 , 0 } | RestList],
                          update_fabao_info(RecordData#fabao_info{eight_diagrams =  NewDiagrams}),
                          %%通知前端
                          {ok,Bin} = pt_45:write(?PT_FABAO_DIAGRAMS_RESET,[FabaoId, Index, GetAttrName, 0 , NewValue, 0]),
                          lib_send:send_to_uid(PlayerId, Bin)
                      end;
                    false ->
                      case Index > 8 of
                        true ->
                          [{GetAttrName1,_},{GetAttrName2,_}] = AttrsList,
                          NewDiagrams = [{Index, AttrName1, AttrName2 , 0, 0 , GetAttrName1, GetAttrName2 } | RestList],
                          update_fabao_info(RecordData#fabao_info{eight_diagrams =  NewDiagrams}),
                          {ok,Bin} = pt_45:write(?PT_FABAO_DIAGRAMS_RESET,[FabaoId, Index,AttrName1, AttrName2  , GetAttrName1, GetAttrName2]),
                          lib_send:send_to_uid(PlayerId, Bin);
                        false ->
                          [{GetAttrName1,GetNewValue1},{GetAttrName2,GetNewValue2}] = AttrsList,
                          NewDiagrams = [{Index, GetAttrName1, GetAttrName2 , GetNewValue1, GetNewValue2 , 0 , 0 } | RestList ],
                          update_fabao_info(RecordData#fabao_info{eight_diagrams =  NewDiagrams}),
                          {ok,Bin} = pt_45:write(?PT_FABAO_DIAGRAMS_RESET,[FabaoId, Index, GetAttrName1, GetAttrName2 , GetNewValue1, GetNewValue2]),
                          lib_send:send_to_uid(PlayerId, Bin)
                      end
                  end,
                  ply_attr:recount_all_attrs(player:get_PS(PlayerId));
                false -> lib_send:send_prompt_msg(PlayerId, ?PM_YB_LIMIT)
              end;
            {fail, Reason} ->
              lib_send:send_prompt_msg(PlayerId, Reason)
          end
      end
  end.

%%洗练法宝的八卦属性
refresh_diagrams_attrs(PlayerId ,FabaoId, Index, AttrNameNo) ->
  case get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    RecordData  ->
      EightDiagrams = RecordData#fabao_info.eight_diagrams,
      case  lists:keytake(Index, 1 , EightDiagrams) of
        false ->
          lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAPPEN_DO);
        {value,{Index, GetAttrName1, GetAttrName2 , AttrNewValue1, AttrNewValue2 , RepValue1 , RepValue2},RestList} ->
          %%获取新的随机属性
          %%[{X,[{GetAttrName,NewValue}]},···]
          AttrName= lib_attribute:obj_info_code_to_attr_name(AttrNameNo),
          DiagramsDataRec = data_fabao_diagrams_attr:get(Index),
          WashCost = DiagramsDataRec#fabao_diagrams_attr.wash_cost,
          [{WashType, WashPrice}] = DiagramsDataRec#fabao_diagrams_attr.wash_price,
          %检查满足条件的物品消耗
          case mod_inv:check_batch_destroy_goods(PlayerId, WashCost)  of
            ok ->
              case player:has_enough_money(player:get_PS(PlayerId), WashType, WashPrice) of
                true ->
                  AllAtts = DiagramsDataRec#fabao_diagrams_attr.attr,
                  case lists:keyfind(AttrName, 1, AllAtts) of
                    false ->
                      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAPPEN_DO);
                    {_,{_ProVal,[MinValue,MaxValue]}} ->
                      mod_inv:destroy_goods_WNC(PlayerId, WashCost, ["lib_fabao","refresh_diagrams_attrs"]),
                      player:cost_money(player:get_PS(PlayerId), WashType, WashPrice, ["lib_fabao","refresh_diagrams_attrs"]),
                      NewValue1 = util:rand(MinValue,MaxValue),
                      NewValue2 =
                        case NewValue1 >= MaxValue * 0.85 of
                          true ->
                            %百分之25从最大值取
                            case random:uniform(4) of
                              1 ->
                                util:rand(MinValue,NewValue1);
                              _ ->
                                util:rand(MinValue,util:ceil(NewValue1* 0.9))
                            end;
                          false ->
                            NewValue1
                        end,
                      case AttrName == GetAttrName1 of
                        true ->
                          NewDiagrams = [{Index, GetAttrName1, GetAttrName2 ,AttrNewValue1, AttrNewValue2 , NewValue2 , RepValue2} | RestList],
                          update_fabao_info(RecordData#fabao_info{eight_diagrams =  NewDiagrams});
                        false ->
                          NewDiagrams = [{Index, GetAttrName1, GetAttrName2 , AttrNewValue1, AttrNewValue2 , RepValue1 , NewValue2} | RestList],
                          update_fabao_info(RecordData#fabao_info{eight_diagrams =  NewDiagrams})
                      end,
                      {ok,Bin} = pt_45:write(?PT_FABAO_DIAGRAMS_CLEAR, [ FabaoId,Index, AttrNameNo, NewValue2 ]),
                      lib_send:send_to_uid(PlayerId, Bin)
                  end;
                false -> lib_send:send_prompt_msg(PlayerId, ?PM_GAMEMONEY_LIMIT)
              end;
            {fail, Reason} ->
              lib_send:send_prompt_msg(PlayerId, Reason)
          end
      end
  end.

replace_diagrams_attrs(PlayerId ,FabaoId, Index, AttrNameNo) ->
  case get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    RecordData  ->
      EightDiagrams = RecordData#fabao_info.eight_diagrams,
      case  lists:keytake(Index, 1, EightDiagrams) of
        false ->
          lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAPPEN_DO);
        {value,{Index, GetAttrName1, GetAttrName2 , NewValue1, NewValue2 , RepValue1 , RepValue2 },RestList} ->
          case Index > 8 of
            true ->
              NewDiagrams = [{Index, RepValue1, RepValue2 , 0, 0 , 0 , 0} | RestList],
              update_fabao_info(RecordData#fabao_info{eight_diagrams =  NewDiagrams});
            false ->
              AttrName= lib_attribute:obj_info_code_to_attr_name(AttrNameNo),
              case AttrName == GetAttrName1 of
                true ->
                  %%替换的是第一条属性
                  NewDiagrams = [{Index, GetAttrName1, GetAttrName2 , RepValue1, NewValue2 , 0 , RepValue2} | RestList],
                  update_fabao_info(RecordData#fabao_info{eight_diagrams =  NewDiagrams});
                false ->
                  NewDiagrams = [{Index, GetAttrName1, GetAttrName2 , NewValue1, RepValue2 , RepValue1 , 0} | RestList],
                  update_fabao_info(RecordData#fabao_info{eight_diagrams =  NewDiagrams})
              end
          end,
          ply_attr:recount_all_attrs(player:get_PS(PlayerId)),
          {ok,Bin} = pt_45:write(?PT_FABAO_DIAGRAMS_REP, [ FabaoId, Index, AttrNameNo ]),
          lib_send:send_to_uid(PlayerId, Bin)

      end
  end.

%%鉴定法宝的八卦
identifyiagrams_attrs(PlayerId,FaBaoId,Index) ->
  case get_fabao_info(FaBaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    RecordData  ->
      %检测是否满足
      DiagramsData = data_fabao_diagrams_attr:get(Index),
      case  RecordData#fabao_info.star_num >= DiagramsData#fabao_diagrams_attr.fabao_star_lv of
        true ->
          %检测消耗

          NeedCost = DiagramsData#fabao_diagrams_attr.identify_cost,
          case mod_inv:check_batch_destroy_goods(player:get_PS(PlayerId), NeedCost)  of
            ok ->
              %%检测需要消耗的货币是否足够
              [{MoneyType,Count}] = DiagramsData#fabao_diagrams_attr.identify_price,
              case player:has_enough_money(player:get_PS(PlayerId), MoneyType, Count) of
                false ->
                  MSGCode =
                    case MoneyType of
                      ?MNY_T_GAMEMONEY -> ?PM_GAMEMONEY_LIMIT;
                      ?MNY_T_YUANBAO -> ?PM_YB_LIMIT;
                      ?MNY_T_BIND_GAMEMONEY -> ?PM_BIND_GAMEMONEY_LIMIT;
                      ?MNY_T_BIND_YUANBAO -> ?PM_BIND_YB_LIMIT;
                      _ -> ?PM_MONEY_LIMIT
                    end,
                  lib_send:send_prompt_msg(PlayerId, MSGCode);
                true ->
                  %% 消耗道具
                  mod_inv:destroy_goods_WNC(player:get_PS(PlayerId), NeedCost, ["lib_fabao", "identifyiagrams"]),
                  %%消耗货币
                  player:cost_money(player:get_PS(PlayerId), MoneyType, Count, ["lib_fabao", "identifyiagrams"]),
                  NewRecordData  = RecordData#fabao_info{is_identify = 1},
                  %%八卦属性
%%                  DiagramsStarF =
%%                    fun(DiagramsStarX, DiagramsStarAcc) ->
%%                      DiagramsStarAcc ++ tuple_to_list((data_fabao_base_attr_growth_ratio:get(DiagramsStarX))#fabao_base_attr_growth_ratio.diagrams_attr)
%%                    end,
%%                  DiagramsNum =lists:foldl(DiagramsStarF, [] , lists:seq(1, RecordData#fabao_info.star_num)),
                  %拿到的数据有可能是两个index
                  DiagramsAttr = lib_fabao:get_diagrams_attrs({Index}),
                  %%拼接下发送给前端并保存起来的数据类型
                  DiagramsF =
                    fun(DiagramsX, Acc) ->
                      %DiagramsX可能是一条属性或者两条
                      {Index ,AttrsList} = DiagramsX,
                      case length(AttrsList)  == 1 of
                        true ->
                          [{GetAttrName,NewValue}] = AttrsList,
                          {Index, GetAttrName, 0 , NewValue, 0 , 0 , 0 };
                        false ->
                          %%目前顶多两条属性
                          [{GetAttrName1,NewValue1},{GetAttrName2,NewValue2}] = AttrsList,
                          {Index, GetAttrName1, GetAttrName2 , NewValue1, NewValue2 , 0 , 0 }
                      end
                    end,
                  DiagramsData2 = lists:foldl(DiagramsF, {} , DiagramsAttr),
                  %%发送给前端
                  {ok,Bin2} = pt_45:write(?PT_IDENTIFY_FABAO,[FaBaoId,Index]),
                  lib_send:send_to_uid(PlayerId, Bin2),
                  {ok,Bin} = pt_45:write(?PT_FABAO_DIAGRAMS_GET_BY_STAR,[FaBaoId, DiagramsData2]),
                  lib_send:send_to_uid(PlayerId, Bin),
                  update_fabao_info(NewRecordData#fabao_info{eight_diagrams = [ DiagramsData2| NewRecordData#fabao_info.eight_diagrams ]}),
                  ply_attr:recount_all_attrs(player:get_PS(PlayerId))
              end;
            {fail, Reason} ->
              lib_send:send_prompt_msg(PlayerId, Reason)
          end;
        false ->
          lib_send:send_prompt_msg(PlayerId, ?PM_FABAO_DIAGRAM_STAR_LIMIT)
      end

  end.

%%法宝八卦的总属性
cal_diagrams_attrs(PlayerId) ->
  case get_fabao_battle(PlayerId) of
    [] -> #attrs{};
    FaBaoId ->
      case get_fabao_info(FaBaoId) of
        [] -> #attrs{};
        FaBao ->
          EightDiagrams =  FaBao#fabao_info.eight_diagrams,
          %%算附加属性
          F =
            fun(X,Acc) ->
              {Index,ClearType,ClearType2,ClearValue,ClearValue2,_,_} = X,
              case Index > 8 of  %%暂定9，10是特效的
                true ->
                  %%计算特效
                  case ClearType == 0 of
                    true ->
                      case ClearType2 == 0 of
                        true ->
                          Acc;
                        false ->
                          lib_attribute:sum_two_attrs(Acc,  lib_attribute:to_addi_equip_eff(ClearType2))
                      end;
                    false ->
                      Acc2 =   lib_attribute:sum_two_attrs(Acc,lib_attribute:to_addi_equip_eff(ClearType)),
                      case ClearType2 == 0 of
                        true ->
                          Acc2;
                        false ->
                          lib_attribute:sum_two_attrs(Acc2, lib_attribute:to_addi_equip_eff(ClearType2))
                      end
                  end;
                false ->
                  %判断下是否有属性值
                  case ClearType == 0 of
                    true ->
                      case ClearType2 == 0 of
                        true ->
                          Acc;
                        false ->
                          lib_attribute:sum_two_attrs(Acc, lib_attribute:to_attrs_record([{ClearType2,ClearValue2}]))
                      end;
                    false ->
                      Acc2 =   lib_attribute:sum_two_attrs(Acc, lib_attribute:to_attrs_record([{ClearType,ClearValue}])),
                      case ClearType2 == 0 of
                        true ->
                          Acc2;
                        false ->
                          lib_attribute:sum_two_attrs(Acc2, lib_attribute:to_attrs_record([{ClearType2,ClearValue2}]))
                      end
                  end

              end
            end,
          lists:foldl(F, #attrs{}, EightDiagrams)
      end
  end.

%%计算神通加成的总基础属性lib_fabao:cacul_magic_base_attrs(1010900000000589)
cacul_magic_base_attrs(PlayerId) ->
  case get_fabao_battle(PlayerId) of
    [] -> [];
    FaBaoId ->
      case get_fabao_info(FaBaoId) of
        [] ->
          lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS),
          [];
        RecordData  ->
          MagicPower = RecordData#fabao_info.magic_power,
          FabaoNo = RecordData#fabao_info.no,
          F = fun({Condition,Lv}, Acc) ->
            MagicData = data_fabao_magic_skill:get(Condition,FabaoNo),
            [{Type, SkillData}] = MagicData#fabao_magic_skill.magic_skill,
            case Type == 1 of
              true ->
                Acc;
              false ->
                {AttrType, GetValueType, _} =  SkillData,
                MagicAttrValueData = data_fabao_magic_skill_attr_value:get(Lv),
                AttrValues = MagicAttrValueData#fabao_magic_skill_attr_value.attr_value,
                GetAttrValue = lists:keyfind(GetValueType,1, AttrValues),
                GetAttrValue2 = case GetAttrValue of
                                  {_, Value} ->
                                    {AttrType, Value};
                                  {_, _, Rate} ->
                                    {AttrType, 0, Rate}
                                end,
                [GetAttrValue2 | Acc]
            end
              end,
          lists:foldl(F, [], MagicPower)
      end
  end.



%%激活神通的某个技能
activate_magic_skill(PlayerId, FabaoId, Condition) ->
  case get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    RecordData  ->
      FabaoNo = RecordData#fabao_info.no,
      MagicData  = data_fabao_magic_skill:get( Condition ,FabaoNo),
      %%先判断学习的前置条件是否满足
      LearnCondition = MagicData#fabao_magic_skill.learn_condition,
      case length(LearnCondition) > 0 of
        true ->
          %%需要判断条件是否满足
          ConditionLen = length(LearnCondition),
          ConditionF =
            fun({NeedCondition, NeedLv},Acc) ->
              MagicPower = RecordData#fabao_info.magic_power,
              case lists:keyfind(NeedCondition, 1, MagicPower) of
                false ->
                  Acc;
                {_, GetLv} ->
                  case GetLv >= NeedLv of
                    true ->
                      Acc + 1;
                    false ->
                      Acc
                  end
              end
            end,
          TotalValue = lists:foldl(ConditionF , 0, LearnCondition),
          case ConditionLen == TotalValue of
            true ->
              study_magic(PlayerId , Condition,RecordData,MagicData);
            false ->
              lib_send:send_prompt_msg(PlayerId, ?PM_FABAO_SKILL_IS_CLOCK)
          end;
        false ->
          %直接学习
          study_magic(PlayerId , Condition,RecordData,MagicData)
      end
  end.

study_magic(PlayerId , Condition,RecordData,MagicData) when is_record(MagicData, fabao_magic_skill) ->
  %%检测需要消耗的货币是否足够
%%  [{MoneyType,Count}] = MagicData#fabao_magic_skill.money,
%%  case player:has_enough_money(player:get_PS(PlayerId), MoneyType, Count) of
%%    false ->
%%      MSGCode =
%%        case MoneyType of
%%          ?MNY_T_GAMEMONEY -> ?PM_GAMEMONEY_LIMIT;
%%          ?MNY_T_YUANBAO -> ?PM_YB_LIMIT;
%%          ?MNY_T_BIND_GAMEMONEY -> ?PM_BIND_GAMEMONEY_LIMIT;
%%          ?MNY_T_BIND_YUANBAO -> ?PM_BIND_YB_LIMIT;
%%          _ ->   ?PM_MONEY_LIMIT
%%        end,
%%      lib_send:send_prompt_msg(PlayerId, MSGCode);
%%    true ->
%%      %%消耗货币
%%      player:cost_money(player:get_PS(PlayerId), MoneyType, Count, ["lib_fabao", "study_magic"]),
  MagicPoowerData =  RecordData#fabao_info.magic_power,
  case lists:keyfind(Condition, 1 , MagicPoowerData) of
    false ->
      [{SkillType, _}] = MagicData#fabao_magic_skill.magic_skill,
      Lv =
        case SkillType of
          1 ->
            %%主动技能
            0;
          2 ->
            1
        end,
      NewMagicPoowerData = [{Condition, Lv}| MagicPoowerData],
      NewFabaoData2 = RecordData#fabao_info{magic_power = NewMagicPoowerData },
      update_fabao_info(NewFabaoData2),
      {ok, Bin}= pt_45:write(?PT_MAGIC_ACTVIATE, [RecordData#fabao_info.id,Condition ]),
      lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
      ply_attr:recount_all_attrs(player:get_PS(PlayerId));
    _ ->
      lib_send:send_prompt_msg(PlayerId, ?PM_FABAO_SKILL_HAVE_LEARN)
  end.


%%
upgrade_magic_skill(PlayerId, FabaoId, Condition, PlusLV) ->
  case get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    RecordData  ->
      FabaoNo = RecordData#fabao_info.no,
      %%检测是否满级了
      MagicData  = data_fabao_magic_skill:get( Condition ,FabaoNo),

      [{MoneyType,Count}] = MagicData#fabao_magic_skill.money,


      [{_, {_, _, [_, MaxLv]}}] = MagicData#fabao_magic_skill.magic_skill,
      MagicPower = RecordData#fabao_info.magic_power,
      case lists:keytake(Condition, 1 , MagicPower) of
        false ->
          lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAPPEN_DO);
        {value, {Condition, Lv}, Plus} ->
          NewLv =
            case Lv + PlusLV > MaxLv of
              true -> MaxLv;
              false -> Lv + PlusLV
            end,
          case player:has_enough_money(player:get_PS(PlayerId), MoneyType, Count * (NewLv - Lv)) of
            false ->
              MSGCode =
                case MoneyType of
                  ?MNY_T_GAMEMONEY -> ?PM_GAMEMONEY_LIMIT;
                  ?MNY_T_YUANBAO -> ?PM_YB_LIMIT;
                  ?MNY_T_BIND_GAMEMONEY -> ?PM_BIND_GAMEMONEY_LIMIT;
                  ?MNY_T_BIND_YUANBAO -> ?PM_BIND_YB_LIMIT;
                  _ ->   ?PM_MONEY_LIMIT
                end,
              lib_send:send_prompt_msg(PlayerId, MSGCode);
            true ->

              %%消耗点数
              CostSkillCountRule =get_need_cost_skill_num(NewLv,Lv, MagicData, 0 ),
              SkillNum = RecordData#fabao_info.skill_num,
              case  SkillNum >= CostSkillCountRule of
                true ->
                  %%消耗货币
                  player:cost_money(player:get_PS(PlayerId), MoneyType, Count* (NewLv - Lv), ["lib_fabao", "study_magic"]),
                  NewFabaoInfo = RecordData#fabao_info{skill_num =SkillNum -  CostSkillCountRule, magic_power =[ {Condition, NewLv} | Plus] },
                  update_fabao_info(NewFabaoInfo),
                  {ok, Bin} = pt_45:write(?PT_MAGIC_UPGRADLV, [FabaoId, Condition, SkillNum -  CostSkillCountRule, NewLv ]),
                  lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
                  ply_attr:recount_all_attrs(player:get_PS(PlayerId));
                false ->
                  lib_send:send_prompt_msg(PlayerId, ?PM_FABAO_SKILL_COUNT_LIMIT)
              end
          end
      end
  end.


get_need_cost_skill_num(TotalLv, NowLv, MagicData, CumulCount) ->
  NewLv = NowLv + 1,
  SortFun = fun({SortA,_},{SorrB,_}) ->
    SortA > SorrB
    end,
  CostSkillCountRule =  lists:sort(SortFun,  MagicData#fabao_magic_skill.skill_point_extra_cost),
  PointCost = MagicData#fabao_magic_skill.skill_point_cost,
  F =
    fun({NeedLv, PlusSkillCount},Acc) ->
      case Acc == 0 of
        true ->
          case NewLv > NeedLv of
            true ->
              PointCost + PlusSkillCount;
            false ->
              Acc
          end;
        false ->
          Acc
      end
    end,
  RealSkillCount =
    case lists:foldl(F, 0, CostSkillCountRule) of
      0 ->
        PointCost;
      HaveRuleCount ->
        HaveRuleCount
    end,
  case TotalLv == NewLv of
    true ->
      RealSkillCount  + CumulCount ;
    false ->
      get_need_cost_skill_num(TotalLv, NewLv, MagicData, RealSkillCount + CumulCount)
  end.

%%兑换技能点数
buy_magic_skill_count(PlayerId, FabaoId, GoodsNo, Count) ->
  case get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    RecordData  ->
      case mod_inv:check_batch_destroy_goods(player:get_PS(PlayerId), [{ GoodsNo, Count}])  of
        ok ->
          mod_inv:destroy_goods_WNC(player:get_PS(PlayerId), [{GoodsNo,Count}], ["lib_fabao", "buy_magic_skill_count"]),
          SpecialData  = data_special_config:get('fabao_magic_skill_book_point'),
%%          [{120057, 1},{120058, 3},{120059, 5}]
          {_GoodsNo, MulCount} = lists:keyfind(GoodsNo, 1, SpecialData),
          GetMagicSkillNum = MulCount * Count,
          NewReCordData = RecordData#fabao_info{skill_num =(RecordData#fabao_info.skill_num + GetMagicSkillNum)},
          update_fabao_info(NewReCordData),
          {ok, Bin} = pt_45:write(?PT_MAGIC_GET_SKILLCOUNT,[FabaoId, RecordData#fabao_info.skill_num + GetMagicSkillNum]),
          lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
        {fail,Reason} ->
          lib_send:send_prompt_msg(PlayerId, Reason)
      end
  end.

%%重置技能点数
rest_magic_skill_count(PlayerId, FabaoId) ->
  case get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    RecordData  ->
      NeedCost  = data_special_config:get(fabao_magic_skill_point_reset_cost),
      case mod_inv:check_batch_destroy_goods(player:get_PS(PlayerId), [NeedCost])  of
        ok ->
          mod_inv:destroy_goods_WNC(player:get_PS(PlayerId),[NeedCost], ["lib_fabao", "rest_magic_skill_count"]),
          FabaoNo = RecordData#fabao_info.no,
          F =
            fun({Condition, Lv}, Acc) ->
              case Lv == 0 of
                true ->
                  Acc;
                false ->
                  MagicSkillData = data_fabao_magic_skill:get(Condition, FabaoNo ),
                  BaseCostCount = MagicSkillData#fabao_magic_skill.skill_point_cost,
                  SortFun = fun({SortA,_},{SorrB,_}) ->
                    SortA > SorrB
                            end,
                  LvRule =  lists:sort(SortFun,  MagicSkillData#fabao_magic_skill.skill_point_extra_cost),
                  F2 =
                    fun(CalExtrLv, Acc2) ->
                      F3 =
                        fun({NeedLv, NeedExtraCost},Acc3) ->
                          case CalExtrLv > NeedLv andalso  Acc3 == 0 of
                            true ->
                              NeedExtraCost;
                            false ->
                              Acc3
                          end
                        end,
                      GetExtraCount = lists:foldl(F3, 0 , LvRule),
                      Acc2 + GetExtraCount
                    end,

                  BaseCostCount* (Lv -1) +  lists:foldl(F2, 0 , lists:seq(1, Lv)) + Acc
              end
            end,
          GetAllExtraNum = lists:foldl(F, 0, RecordData#fabao_info.magic_power),
          update_fabao_info(RecordData#fabao_info{magic_power = [], skill_num =  GetAllExtraNum + RecordData#fabao_info.skill_num , skill_array_1 = 0, skill_array_2 = 0, skill_array_3 = 0}),
          {ok, Bin} = pt_45:write(?PT_MAGIC_RESET_ALL_SKILLCOUNT, [FabaoId, GetAllExtraNum + RecordData#fabao_info.skill_num]),
          lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
          ply_attr:recount_all_attrs(player:get_PS(PlayerId));
        {fail,Reason} ->
          lib_send:send_prompt_msg(PlayerId, Reason)
      end
  end.

up_or_dowm_skill(PlayerId,FabaoId, Condition, Type) ->
  case get_fabao_info(FabaoId) of
    [] ->
      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS);
    RecordData  ->
      FabaoNo = RecordData#fabao_info.no,
      MagicData = data_fabao_magic_skill:get(Condition, FabaoNo),
      [{_, [SkillNo]}] = MagicData#fabao_magic_skill.magic_skill,
      case Type of
        1 ->
          case RecordData#fabao_info.skill_array_1 of
            0 ->
              %%上阵这里
              update_fabao_info( RecordData#fabao_info{skill_array_1 = SkillNo});
            _ ->
              case RecordData#fabao_info.skill_array_2 of
                0 ->
                  update_fabao_info( RecordData#fabao_info{skill_array_2 = SkillNo});
                _ ->
                  case RecordData#fabao_info.skill_array_3 of
                    0 ->
                      update_fabao_info( RecordData#fabao_info{skill_array_3 = SkillNo});
                    _ ->
                      lib_send:send_prompt_msg(PlayerId, ?PM_FABAO_ARRAY_LIMIT)
                  end
              end
          end;
        2 ->
          case RecordData#fabao_info.skill_array_1 of
            SkillNo ->
              %%上阵这里
              update_fabao_info( RecordData#fabao_info{skill_array_1 = 0});
            _ ->
              case RecordData#fabao_info.skill_array_2 of
                SkillNo ->
                  update_fabao_info( RecordData#fabao_info{skill_array_2 = 0});
                _ ->
                  case RecordData#fabao_info.skill_array_3 of
                    SkillNo ->
                      update_fabao_info( RecordData#fabao_info{skill_array_3 = 0});
                    _ ->
                      lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAPPEN_DO)
                  end
              end
          end
      end,
      NewFabaoData = get_fabao_info(FabaoId),
      {ok, Bin} = pt_45:write(?PT_MAGIC_ARRAY, [FabaoId, NewFabaoData#fabao_info.skill_array_1,NewFabaoData#fabao_info.skill_array_2,NewFabaoData#fabao_info.skill_array_3]),
      lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
  end.
