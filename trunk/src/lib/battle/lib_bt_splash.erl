%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.10.27
%%% @doc 技能溅射效果相关操作.
%%% @end
%%%------------------------------------

-module(lib_bt_splash).
-export([
        get_splash_target/2         % 获取被溅射到的目标
        ,sum_two_splash_dtl_list/2  % 融合两个溅射详情列表
        ,pack_splash_dtl_list_bin/1 % 封包溅射信息列表
    ]).

-include("record/battle_record.hrl").
-include("debug.hrl").


%% --------------------------------------------
%% 获取被溅射到的目标
%% --------------------------------------------
% @return SplashTargetList = [Bo, ... ]
get_splash_target(DeferBo, SplashPatternNo) ->
    R = case data_skill_splash:get(SplashPatternNo) of
        SplashPattern when is_record(SplashPattern, splash_pattern) ->
            DeferSide = lib_bo:get_side(DeferBo),
            DeferPos = lib_bo:get_pos(DeferBo),
            TargetPosList = get_splash_target_pos_list(DeferSide,DeferPos, SplashPattern),
            TargetBoList = [lib_bt_comm:get_bo_by_pos(DeferSide, Pos) || Pos <- TargetPosList],
            % 过滤不存在或者死亡的bo
            [ Bo || Bo <- TargetBoList, Bo=/=null, lib_bt_comm:is_living(Bo)];
        _ -> []
    end, 
    %?ylh_Debug("get_splash_target ~p~n", [[SplashPatternNo, lib_bo:get_side(DeferBo),lib_bo:get_pos(DeferBo), R]]),
    R.

get_splash_target_pos_list(DeferSide,BasePos, SplashPattern) ->
    % BasePos 转成策划对应的站位
    CfgBasePos = lib_bt_misc:server_logic_pos_to_cfg_pos(BasePos),
    CfgTargetPosList = get_splash_target_pos_list__(CfgBasePos, SplashPattern),
    % 得到的结果转会程序用的站位
    [ lib_bt_misc:cfg_pos_to_server_logic_pos(DeferSide,BasePos,Pos) || Pos <- CfgTargetPosList].

get_splash_target_pos_list__(1, SP) -> SP#splash_pattern.pos_1;
get_splash_target_pos_list__(2, SP) -> SP#splash_pattern.pos_2;
get_splash_target_pos_list__(3, SP) -> SP#splash_pattern.pos_3;
get_splash_target_pos_list__(4, SP) -> SP#splash_pattern.pos_4;
get_splash_target_pos_list__(5, SP) -> SP#splash_pattern.pos_5;
get_splash_target_pos_list__(6, SP) -> SP#splash_pattern.pos_6;
get_splash_target_pos_list__(7, SP) -> SP#splash_pattern.pos_7;
get_splash_target_pos_list__(8, SP) -> SP#splash_pattern.pos_8;
get_splash_target_pos_list__(9, SP) -> SP#splash_pattern.pos_9;
get_splash_target_pos_list__(10, SP) -> SP#splash_pattern.pos_10;
get_splash_target_pos_list__(_, _SP) -> [].


%% --------------------------------------------
%% 融合两个溅射详情列表
%% --------------------------------------------
% List1 = [#splash_dtl{}, ...]
% List2 = [#splash_dtl{}, ...]
sum_two_splash_dtl_list([], List2) -> List2;
sum_two_splash_dtl_list([SplashDtl1 | List1_Left], List2) ->
    NewList2 = 
    case lists:keyfind(SplashDtl1#splash_dtl.defer_id, #splash_dtl.defer_id, List2) of
        false -> [SplashDtl1 | List2];
        _SplashDtl2 ->
            % 目前不支持重复溅射，所以在这里做一下断言
            ?ASSERT(false, {_SplashDtl2}),
            List2
    end,
    sum_two_splash_dtl_list(List1_Left, NewList2).



%% --------------------------------------------
%% 封包溅射信息列表
%% --------------------------------------------
pack_splash_dtl_list_bin(SplashDtlList) ->
    %?ylh_Debug("pack_splash_dtl_list_bin ~p~n", [[SplashDtlList]]),
    F = fun(SplashDtl) ->
            <<(SplashDtl#splash_dtl.defer_id) : 16
             ,(SplashDtl#splash_dtl.dam_val_hp) : 32
             ,(SplashDtl#splash_dtl.dam_val_mp) : 32
             ,(SplashDtl#splash_dtl.dam_val_anger) : 32
             ,(SplashDtl#splash_dtl.defer_hp_left) : 32
             ,(SplashDtl#splash_dtl.defer_mp_left) : 32
             ,(SplashDtl#splash_dtl.defer_anger_left) : 32
             ,(SplashDtl#splash_dtl.defer_die_status) : 8
             ,(util:bool_to_oz(SplashDtl#splash_dtl.reborn_dtl#reborn_dtl.is_reborn_applied)) : 8
             ,(length(SplashDtl#splash_dtl.defer_buffs_removed)) : 16
             ,(<< <<(BuffNo):32>> || BuffNo <- SplashDtl#splash_dtl.defer_buffs_removed>>) /binary
            >>
    end,
    SplashDtlListBin = list_to_binary([F(X) || X <- SplashDtlList]),
    {ok, SplashDtlListBin}.



