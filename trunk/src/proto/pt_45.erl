%%%-------------------------------------------------------------------
%%% @author wujiancheng
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. 七月 2019 18:24
%%%-------------------------------------------------------------------
-module(pt_45).
-author("JKYL").

-export([read/2, write/2]).

-include("common.hrl").
-include("pt_45.hrl").
-include("record.hrl").
-include("fabao.hrl").


read(?PT_FABAO_INFO, <<Code:8>>) ->
  {ok, [Code]};


read(?PT_FABAO_DISPLAYER, <<FanbaoId:64, BodyAnim:32 ,Num:8>>) ->
  {ok, [FanbaoId,BodyAnim,Num]};

read(?PT_FABAO_BATTLE, <<FanbaoId:64, Num:8>>) ->
  {ok, [FanbaoId,Num]};

read(?PT_FABAO_COMPOSE, <<FanbaoNo:32>>) ->
  {ok,  [FanbaoNo]};

read(?PT_FABAO_UPGRADE_STAR, <<FanbaoId:64, Feed:8>>) ->
  {ok, [FanbaoId,Feed]};

read(?PT_FABAO_SPIRIT, <<FanbaoId:64, Feed:8>>) ->
  {ok, [FanbaoId,Feed]};

read(?PT_FABAO_REFINING, <<FanbaoId:64>>) ->
  {ok, [FanbaoId]};

read(?PT_FABAO_FRAGMENT_EXCHANGE, <<FanbaoNo:32>>) ->
  {ok, [FanbaoNo]};

read(?PT_FABAO_FRAGMENT_TRANSFORM, <<FanbaoNo:32>>) ->
  {ok, [FanbaoNo]};

read(?PT_FABAO_ADVANCE, <<FanbaoId:64, Type:8>>) ->
  {ok, [FanbaoId, Type]};

read(?PT_FABAO_BUY_SPECIAL, <<SpecialNo:32>>) ->
  {ok, [SpecialNo]};

read(?PT_FABAO_DIAGRAMS_RESET, <<FanbaoId:64, Index:8>>) ->
  {ok, [FanbaoId, Index]};

read(?PT_FABAO_DIAGRAMS_CLEAR, <<FanbaoId:64, Index:8, ClearType:16>>) ->
  {ok, [FanbaoId, Index,ClearType]};

read(?PT_FABAO_DIAGRAMS_REP, <<FanbaoId:64, Index:8, ClearType:16>>) ->
  {ok, [FanbaoId, Index,ClearType]};

read(?PT_IDENTIFY_FABAO, <<FanbaoId:64,Index:8>>) ->
  {ok, [FanbaoId, Index]};


read(?PT_MAGIC_ACTVIATE, <<FanbaoId:64, Condition:8 >>) ->
  {ok, [FanbaoId, Condition]};

read(?PT_MAGIC_UPGRADLV, <<FanbaoId:64 , Condition:8, PlusLv:8 >>) ->
  {ok, [FanbaoId, Condition, PlusLv]};

read(?PT_MAGIC_GET_SKILLCOUNT, <<FanbaoId:64 ,GoodsNo:32 , Count:16  >>) ->
  {ok, [FanbaoId, GoodsNo, Count]};

read(?PT_MAGIC_ARRAY, <<FanbaoId:64 ,Condition:8 , Type:8  >>) ->
  {ok, [FanbaoId, Condition, Type]};

read(?PT_MAGIC_RESET_ALL_SKILLCOUNT, <<FanbaoId:64 >>) ->
  {ok, [FanbaoId]};





read(?PT_FABAO_FUYIN_DETAILS, <<>>) ->
  {ok, []};

read(?PT_FABAO_FUYIN_MOSAIC, <<FabaoId:64, SetType:8, Position:8, FuyinId:64, Type:8>>) ->
  {ok, [FabaoId, SetType, Position, FuyinId, Type]};

read(?PT_FABAO_FUYIN_COMPOSE, <<Type:8, FuyinId:64>>) ->
  {ok, [Type, FuyinId]};

read(_Cmd, _R) ->
  ?ASSERT(false, {_Cmd, _R}),
  {error, not_match}.


write(?PT_FABAO_INFO, [DataLists]) ->
  N = length(DataLists),
  F = fun(FabaoInfo) ->
    [Id,No, StarNum, Degree,  SpValue,  Displayer, Battle, DegreeNum, DegreePro ,CultivatePro ,EightDiagrams,
      SkillNum, SkillArray_1, SkillArray_2, SkillArray_3, MagicPower,PlayerId ] = [
      FabaoInfo#fabao_info.id,  FabaoInfo#fabao_info.no, FabaoInfo#fabao_info.star_num,FabaoInfo#fabao_info.degree,
      FabaoInfo#fabao_info.sp_value,FabaoInfo#fabao_info.displayer,FabaoInfo#fabao_info.battle,FabaoInfo#fabao_info.degree_num,
      FabaoInfo#fabao_info.degree_pro,FabaoInfo#fabao_info.cultivate_pro,FabaoInfo#fabao_info.eight_diagrams,
      FabaoInfo#fabao_info.skill_num,FabaoInfo#fabao_info.skill_array_1, FabaoInfo#fabao_info.skill_array_2,FabaoInfo#fabao_info.skill_array_3,
      FabaoInfo#fabao_info.magic_power,FabaoInfo#fabao_info.player_id
    ],

    DiagramsLen = length(EightDiagrams),
    F2 = fun({Index,ClearType,ClearType2,ClearValue,ClearValue2,RepValue1,RepValue2}) ->
      {ObjClearType1,ObjClearType2} =
        case Index >8 of
          true ->
            %%特效不需要转换
            {ClearType,ClearType2};
          false ->
            {lib_attribute:attr_name_to_obj_info_code(ClearType), lib_attribute:attr_name_to_obj_info_code(ClearType2)}
        end,
      <<Index:8, ObjClearType1:16 ,ObjClearType2:16 ,ClearValue:16 ,ClearValue2:16
        ,RepValue1:16 , RepValue2:16>>
         end,
    DiagramsBinary = list_to_binary([F2(X2) || X2 <- EightDiagrams]),

    MagicPowerLen = length(MagicPower),
    F3 = fun({DegreeIndex, SkiLv}) ->
      <<DegreeIndex:8,SkiLv:8 >>
         end,
    MagicPowerBinary = list_to_binary([F3(X3) || X3 <- MagicPower]),
    %% 符印部分（独立法宝处理）
    FuyinList = lib_fabao:get_fuyin_by_player_fabao_id(PlayerId, Id),
    Fuyin = mod_fabao:create_flashprint_list(FuyinList),
    FuyinLen = length(Fuyin),
    F4 = fun({_Type, FuyinInfo}) ->
      [Type, FuyinId1, FuyinNo1, FuyinId2, FuyinNo2, FuyinId3, FuyinNo3] = [FuyinInfo#flashprint.type, FuyinInfo#flashprint.fuyin_id1,
        FuyinInfo#flashprint.fuyin_no1, FuyinInfo#flashprint.fuyin_id2, FuyinInfo#flashprint.fuyin_no2, FuyinInfo#flashprint.fuyin_id3, FuyinInfo#flashprint.fuyin_no3],
      <<Type:8, FuyinId1:64, FuyinNo1:32, FuyinId2:64, FuyinNo2:32, FuyinId3:64, FuyinNo3:32>>
         end,
    FuyinBinary = list_to_binary([F4(X4) || X4 <- Fuyin]),
    DegreeNum2 = DegreeNum - 1,
    <<Id:64, No:32, StarNum:8, Degree:8, SpValue:32,  Displayer:8, Battle:8,DegreeNum2:8,DegreePro:16
      ,CultivatePro:16 ,DiagramsLen:16, DiagramsBinary/binary, SkillNum:32, SkillArray_1:32, SkillArray_2:32, SkillArray_3:32
      ,MagicPowerLen:16, MagicPowerBinary/binary, FuyinLen:16 , FuyinBinary/binary>>
      end,
  ListBinary = list_to_binary([F(X) || X <- DataLists]),
  {ok, pt:pack(?PT_FABAO_INFO, << N:16, ListBinary/binary>>)};

write(?PT_FABAO_DISPLAYER, [FanbaoNo]) ->
  {ok, pt:pack(?PT_FABAO_DISPLAYER,<<FanbaoNo:32>>)};


write(?PT_FABAO_UPGRADE_STAR, [FabaoId, StartNum, CultivatePro]) ->
  {ok, pt:pack(?PT_FABAO_UPGRADE_STAR,<<FabaoId:64, StartNum:8, CultivatePro:16>>)};


write(?PT_FABAO_SPIRIT, [FabaoId, SpValue]) ->
  {ok, pt:pack(?PT_FABAO_SPIRIT,<<FabaoId:64, SpValue:32>>)};

write(?PT_FABAO_REFINING, [FabaoId, CultivatePro]) ->
  {ok, pt:pack(?PT_FABAO_REFINING,<<FabaoId:64, CultivatePro:16>>)};

write(?PT_FABAO_FRAGMENT_EXCHANGE, [Code]) ->
  {ok, pt:pack(?PT_FABAO_FRAGMENT_EXCHANGE,<<Code:8>>)};

write(?PT_FABAO_FRAGMENT_TRANSFORM, [Code]) ->
  {ok, pt:pack(?PT_FABAO_FRAGMENT_TRANSFORM,<<Code:8>>)};

write(?PT_FABAO_BUY_SPECIAL, [Num,SpecialNoList]) ->
  F = fun(Num) ->
    <<Num:32>>
      end,
  Bin = list_to_binary( [F(X) || X <- SpecialNoList] ),
  Bin2 = <<Num:8,
    (length(SpecialNoList)) : 16,
    Bin / binary
  >>,
  {ok, pt:pack(?PT_FABAO_BUY_SPECIAL, Bin2)};

write(?PT_FABAO_ADVANCE, [FanbaoId, NowDegree, NowNum, DegreePro]) ->
  NowNum2 = NowNum -1 ,
  {ok, pt:pack(?PT_FABAO_ADVANCE,<<FanbaoId:64, NowDegree:8, NowNum2:8, DegreePro:16>>)};

write(?PT_FABAO_DIAGRAMS_RESET, [FabaoId, Index, ClearType, ClearType2, ClearValue, ClearValue2]) ->
  {ObjClearType1,ObjClearType2} =
    case Index >8 of
      true ->
        %%特效不需要转换
        {ClearType,ClearType2};
      false ->
        {lib_attribute:attr_name_to_obj_info_code(ClearType), lib_attribute:attr_name_to_obj_info_code(ClearType2)}
    end,
  {ok, pt:pack(?PT_FABAO_DIAGRAMS_RESET,<<FabaoId:64,Index:8, ObjClearType1:16, ObjClearType2:16, ClearValue:16, ClearValue2:16>>)};

write(?PT_FABAO_DIAGRAMS_CLEAR, [FabaoId,Index, ClearType, ClearValue]) ->
  {ok, pt:pack(?PT_FABAO_DIAGRAMS_CLEAR,<<FabaoId:64, Index:8, ClearType:16, ClearValue:16>>)};


write(?PT_FABAO_DIAGRAMS_REP, [FabaoId, Index, AttrName]) ->
  {ok, pt:pack(?PT_FABAO_DIAGRAMS_REP,<<FabaoId:64, Index:8, AttrName:16>>)};

write(?PT_FABAO_DIAGRAMS_GET_BY_STAR, [FaBaoId,DiagramsData]) ->
 {Index, GetAttrName1, GetAttrName2 , NewValue1, NewValue2 , TypeValue1 , TypeValue2} = DiagramsData,
    {ObjClearType1,ObjClearType2} =
      case Index >8 of
        true ->
          %%特效不需要转换
          {GetAttrName1,GetAttrName2};
        false ->
          {lib_attribute:attr_name_to_obj_info_code(GetAttrName1), lib_attribute:attr_name_to_obj_info_code(GetAttrName2)}
      end,
  Bin = list_to_binary( [<<Index:8,ObjClearType1:16, ObjClearType2:16 , NewValue1:16, NewValue2:16 , TypeValue1 :16 , TypeValue2:16>>] ),
  Bin2 = <<FaBaoId:64,
    1 : 16,
    Bin / binary
  >>,
  {ok, pt:pack(?PT_FABAO_DIAGRAMS_GET_BY_STAR, Bin2)};

write(?PT_IDENTIFY_FABAO, [FabaoId,Index]) ->
  {ok, pt:pack(?PT_IDENTIFY_FABAO,<<FabaoId:64,Index:8>>)};

write(?PT_MAGIC_ACTVIATE, [FabaoId,Condition]) ->
  {ok, pt:pack(?PT_MAGIC_ACTVIATE,<<FabaoId:64, Condition:8>>)};

write(?PT_MAGIC_UPGRADLV, [FabaoId,Condition, SkillCount, NewLv]) ->
  {ok, pt:pack(?PT_MAGIC_UPGRADLV,<<FabaoId:64, Condition:8, SkillCount:32, NewLv:8>>)};

write(?PT_MAGIC_GET_SKILLCOUNT, [FabaoId, SkillCount]) ->
  {ok, pt:pack(?PT_MAGIC_GET_SKILLCOUNT,<<FabaoId:64,  SkillCount:32>>)};

write(?PT_MAGIC_ARRAY, [FabaoId, SkillArray1, SkillArray2, SkillArray3]) ->
  {ok, pt:pack(?PT_MAGIC_ARRAY,<<FabaoId:64,  SkillArray1:32, SkillArray2:32, SkillArray3:32>>)};

write(?PT_MAGIC_RESET_ALL_SKILLCOUNT, [FabaoId, SkillCount]) ->
  {ok, pt:pack(?PT_MAGIC_RESET_ALL_SKILLCOUNT,<<FabaoId:64,  SkillCount:32>>)};



write(?PT_FABAO_FUYIN_DETAILS, [FuyinList]) ->
  F = fun({Id, No, Count}) ->
    <<Id:64, No:32, Count:32>>
      end,
  BinInfo = list_to_binary([F(X) || X <- FuyinList]),
  ListLen = length(FuyinList),
  Data = <<ListLen:16, BinInfo/binary>>,
  {ok, pt:pack(?PT_FABAO_FUYIN_DETAILS, Data)};

write(?PT_FABAO_FUYIN_MOSAIC, [FabaoId, SetType, Position, FuyinNo, FuyinId]) ->
  {ok, pt:pack(?PT_FABAO_FUYIN_MOSAIC,<<FabaoId:64, SetType:8, Position:8, FuyinNo:32, FuyinId:64>>)};

write(?PT_FABAO_FUYIN_COMPOSE, [ResCode]) ->
  {ok, pt:pack(?PT_FABAO_FUYIN_COMPOSE,<<ResCode:8>>)};

write(_Cmd, _R) ->
  ?ASSERT(false, {_Cmd, _R}),
  {error, not_match}.
