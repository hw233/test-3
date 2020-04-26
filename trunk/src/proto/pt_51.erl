%% @author wujiancheng
%% @doc @todo Add description to pt_54.


-module(pt_51).
-export([write/2, read/2]).

-include("common.hrl").
-include("pt_51.hrl").


%% ====================================================================
%% Internal functions
%% ====================================================================

% 定制
read(?PT_DIY_TITLES, <<No:8, Bin/binary>>) ->
    {AttrList, _} = pt:read_array(Bin, [u8]),
    {ok, [No, AttrList]};

read(?PT_DIY_PARTNERS, <<Type:8, No:8, PartnerNo:16, SkillNo:32>>) ->
    {ok,[Type, No, PartnerNo, SkillNo]};

read(?PT_DIY_FASHION, <<No:8, Fashion:32, Effect:16, Bin/binary>>) ->
    {AttrList, _} = pt:read_array(Bin, [u8]),
    {ok, [No, Fashion, Effect, AttrList]};

read(?PT_DIY_WING, <<No:8, WingNo:32, Bin/binary>>) ->
    {AttrList, _} = pt:read_array(Bin, [u8]),
    {ok, [No, WingNo, AttrList]};

read(?PT_DIY_MOUNT, <<Type:8, No:8, MountNo:32, Bin/binary>>) ->
    {AttrList, _} = pt:read_array(Bin, [u8]),
    {ok, [Type, No, MountNo, AttrList]};

read(?PT_DIY_EQUIP, <<Type:8, No:8, EquipNo:32, EffectNo:8, SkillNo:32, Bin/binary>>) ->
    {AttrList, _} = pt:read_array(Bin, [u8]),
    {ok, [Type, No, EquipNo, EffectNo, SkillNo, AttrList]};

read(?PT_DIY_GOODS_EXCHANGE, <<Type:8, GoodsNo:32, Count:32>>) ->
    {ok,[Type, GoodsNo, Count]};

read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.


% 定制
write(?PT_DIY_TITLES, [RetCode, GoodsNo]) ->
    {ok, pt:pack(?PT_DIY_TITLES, <<RetCode:8, GoodsNo:32>>)};

write(?PT_DIY_PARTNERS, [RetCode, GoodsNo]) ->
    {ok, pt:pack(?PT_DIY_PARTNERS, <<RetCode:8, GoodsNo:32>>)};

write(?PT_DIY_FASHION, [RetCode, GoodsNo]) ->
    {ok, pt:pack(?PT_DIY_FASHION, <<RetCode:8, GoodsNo:32>>)};

write(?PT_DIY_WING, [RetCode, GoodsNo]) ->
    {ok, pt:pack(?PT_DIY_WING, <<RetCode:8, GoodsNo:32>>)};

write(?PT_DIY_MOUNT, [RetCode, GoodsNo]) ->
    {ok, pt:pack(?PT_DIY_MOUNT, <<RetCode:8, GoodsNo:32>>)};

write(?PT_DIY_EQUIP, [RetCode, GoodsNo]) ->
    {ok, pt:pack(?PT_DIY_EQUIP, <<RetCode:8, GoodsNo:32>>)};

write(?PT_DIY_GOODS_EXCHANGE, [RetCode, Type]) ->
    {ok, pt:pack(?PT_DIY_GOODS_EXCHANGE, <<RetCode:8, Type:8>>)};


write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.
