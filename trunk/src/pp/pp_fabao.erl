%%%-------------------------------------------------------------------
%%% @author wujiancheng 583461955@qq.com
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. 七月 2019 20:37
%%%-------------------------------------------------------------------
-module(pp_fabao).
-author("wujiancheng").
-include("pt_45.hrl").
-include("common.hrl").

%% API
-export([handle/3]).

%%玩家法宝基本信息
handle(?PT_FABAO_INFO, PS , _) ->
  AllFabaoInfo =  mod_fabao:get_info(player:get_id(PS)),
  {ok, Bin} = pt_45:write(?PT_FABAO_INFO, [AllFabaoInfo]),
  lib_send:send_to_sock(PS, Bin);

%%法宝升星
handle(?PT_FABAO_UPGRADE_STAR, PS , [FaBaoId, Feed]) ->
  case lib_fabao:star_upgrade(PS, Feed, FaBaoId) of
    {fail, Reason} ->
      lib_send:send_prompt_msg(PS, Reason);
    {ok, NewFaBaoId, Star, NewGrowthValue} ->
      {ok, Bin} = pt_45:write(?PT_FABAO_UPGRADE_STAR, [NewFaBaoId, Star, NewGrowthValue]),
      lib_send:send_to_sock(PS, Bin)
  end;

%%展示和不展示法宝
handle(?PT_FABAO_DISPLAYER, PS , [FanbaoId,BodyAnim,Type]) ->
  mod_fabao:displayer_my_fabao(player:get_id(PS), FanbaoId,BodyAnim,Type);

%%法宝充灵
handle(?PT_FABAO_SPIRIT, PS , [Feed, FaBaoId]) ->
  mod_fabao:spirit_fabao(player:get_id(PS), Feed, FaBaoId);

%%法宝炼化
handle(?PT_FABAO_REFINING, PS , [FaBaoId]) ->
  mod_fabao:refinery_fabao(player:get_id(PS), FaBaoId);

%%佩戴和不佩戴法宝
handle(?PT_FABAO_BATTLE, PS , [FanbaoId,Type]) ->
  mod_fabao:wear_fabao(player:get_id(PS), FanbaoId,Type);

%%法宝合成
handle(?PT_FABAO_COMPOSE, PS , [FanbaoNo]) ->
  mod_fabao:compose_fabao(player:get_id(PS), FanbaoNo);

%%法宝进阶
handle(?PT_FABAO_ADVANCE, PS , [FabaoId,Type]) ->
  mod_fabao:advance(player:get_id(PS),FabaoId,Type);

%%法宝碎片兑换
handle(?PT_FABAO_FRAGMENT_EXCHANGE, PS , [FabaoNo]) ->
  mod_fabao:exchange_fragment(player:get_id(PS), FabaoNo, 1);

%%法宝碎片转化
handle(?PT_FABAO_FRAGMENT_TRANSFORM, PS , [FabaoNo]) ->
  mod_fabao:exchange_fragment(player:get_id(PS), FabaoNo, 2);

%%法宝幻化选择
handle(?PT_FABAO_BUY_SPECIAL, PS , [SpecialNo]) ->
  mod_fabao:buy_special_fabao(PS, SpecialNo);

%%法宝八卦重置属性生成
handle(?PT_FABAO_DIAGRAMS_RESET, PS , [FabaoId,Index]) ->
  lib_fabao:reset_diagrams_attr(player:get_id(PS) ,FabaoId, Index);

%%法宝八卦洗练
handle(?PT_FABAO_DIAGRAMS_CLEAR, PS , [FabaoId,Index,ClearType]) ->
  lib_fabao:refresh_diagrams_attrs(player:get_id(PS) ,FabaoId, Index,ClearType);

handle(?PT_FABAO_DIAGRAMS_REP, PS , [FabaoId,Index,ClearType]) ->
  lib_fabao:replace_diagrams_attrs(player:get_id(PS) ,FabaoId, Index,ClearType);

handle(?PT_IDENTIFY_FABAO, PS , [FabaoId,Index]) ->
  lib_fabao:identifyiagrams_attrs(player:get_id(PS) ,FabaoId,Index);

%%激活神通
handle(?PT_MAGIC_ACTVIATE, PS , [FabaoId,Condition]) ->
   lib_fabao:activate_magic_skill(player:get_id(PS) ,FabaoId,Condition);

%%升级神通技能
handle(?PT_MAGIC_UPGRADLV, PS , [FabaoId, Condition, PlusLV]) ->
  lib_fabao:upgrade_magic_skill(player:get_id(PS), FabaoId, Condition, PlusLV);

%%兑换技能点数
handle(?PT_MAGIC_GET_SKILLCOUNT, PS , [ FabaoId,GoodsNo,Count ]) ->
  lib_fabao:buy_magic_skill_count(player:get_id(PS), FabaoId, GoodsNo, Count);

%%重置技能点数
handle(?PT_MAGIC_RESET_ALL_SKILLCOUNT, PS , [ FabaoId ]) ->
  lib_fabao:rest_magic_skill_count(player:get_id(PS), FabaoId);

%%上下阵技能
handle(?PT_MAGIC_ARRAY, PS , [ FabaoId, Condition ,Type ]) ->
  lib_fabao:up_or_dowm_skill(player:get_id(PS),FabaoId, Condition, Type);


%%获取法宝符印简要信息
handle(?PT_FABAO_FUYIN_DETAILS, PS , _) ->
  FuyinInfoList = mod_fabao:get_player_fuyin_info(player:get_id(PS)),
  {ok, Bin} = pt_45:write(?PT_FABAO_FUYIN_DETAILS, [FuyinInfoList]),
  lib_send:send_to_sock(PS, Bin);

%%法宝符印镶嵌/卸下
handle(?PT_FABAO_FUYIN_MOSAIC, PS , [FabaoId, SetType, Position, FuyinId, Type]) ->
  mod_fabao:takeon_fuyin(player:get_id(PS), FabaoId, SetType, Position, FuyinId, Type);

%%法宝符印合成
handle(?PT_FABAO_FUYIN_COMPOSE, PS , [Type, Fuyin]) ->
  mod_fabao:compose_fuyin(player:get_id(PS), Type, Fuyin);


handle(_Cmd, _Status, _Data) ->
  ?DEBUG_MSG("handle_account no match", []),
  {error, "handle_account no match"}.
