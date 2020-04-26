%%%-------------------------------------------------------------------
%%% @author
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24 五月 2019 16:39
%%%-------------------------------------------------------------------
-module(pp_diy).

%% API
-export([handle/3]).

-include("common.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("pt_51.hrl").

%%----------- 定制称号 -------------
handle(?PT_DIY_TITLES, PS, [No, AttrList]) ->
    lib_diy:start_diy_title(player:get_id(PS), No, AttrList);

%%----------- 定制门客 -------------
handle(?PT_DIY_PARTNERS, PS, [Type, No, PartnerNo, SkillNo]) ->
    lib_diy:start_diy_partner(PS, Type, No, PartnerNo, SkillNo);

%%----------- 定制时装 -------------
handle(?PT_DIY_FASHION, PS, [No, FashionNo, EffectNo, AttrsNum]) ->
    lib_diy:start_diy_fashion(player:get_id(PS), No, FashionNo, EffectNo, AttrsNum);

%%----------- 定制翅膀 -------------
handle(?PT_DIY_WING, PS, [No, WingNo, AttrsNum]) ->
    lib_diy:start_diy_wing(player:get_id(PS), No, WingNo, AttrsNum);

%%----------- 定制坐骑 -------------
handle(?PT_DIY_MOUNT, PS, [Type, No, MountNo, AttrsNum]) ->
    lib_diy:start_diy_mount(PS, Type, No, MountNo, AttrsNum);

%%----------- 定制装备 -------------
handle(?PT_DIY_EQUIP, PS, [Type, No, EquipNo, EffectNo, SkillNo, AttrsNum]) ->
    lib_diy:start_diy_equip(player:get_id(PS), Type, No, EquipNo, EffectNo, SkillNo, AttrsNum);

%%----------- 定制装备 -------------
handle(?PT_DIY_GOODS_EXCHANGE, PS, [Type, GoodsNo, Count]) ->
    lib_diy:start_goods_exchange(player:get_id(PS), Type, GoodsNo, Count);

%% desc: 容错
handle(_Cmd, _PS, _Data) ->
    ?DEBUG_MSG("pp_mystery no match", []),
    {error, "pp_mystery no match"}.