%%%-------------------------------------- 
%%% @Module: lib_bt_tips
%%% @Author: huangjf
%%% @Created: 2014.1.21
%%% @Description: 战斗中的提示信息
%%%-------------------------------------- 

-module(lib_bt_tips).
-export([
        % build_tips/2
        build_cannot_use_skill_tips/3,
        build_use_goods_failed_tips/4
    ]).
    
% -include("common.hrl").
% -include("buff.hrl").
% % -include("record.hrl").
% % -include("skill.hrl").
-include("battle.hrl").
-include("record/battle_record.hrl").
% % -include("battle_buff.hrl").
% % -include("effect.hrl").


% -import(lib_bt_comm, [
%             get_bo_by_id/1,
%             is_dead/1
%             % is_bo_exists/1
%             ]).





%% @return: btl_tips结构体
build_cannot_use_skill_tips(Actor, SklCfg, Reason) ->
    ActorId = lib_bo:id(Actor),
    TipsCode = to_tips_code(cannot_use_skill, Reason),
    SkillId = mod_skill:get_id(SklCfg),
    #btl_tips{
        to_bo_id = ActorId,
        tips_code = TipsCode,
        para1 = SkillId,
        para2 = 0
        }.




%% 注意：参数Goods有可能传入null
build_use_goods_failed_tips(Actor, Goods, TargetBoId, Reason) ->
    ActorId = lib_bo:id(Actor),
    TipsCode = to_tips_code(use_goods_failed, Reason),
    GoodsNo =   case Goods of
                    null -> ?INVALID_NO;
                    _ -> lib_goods:get_no(Goods)
                end,
    #btl_tips{
        to_bo_id = ActorId,
        tips_code = TipsCode,
        para1 = GoodsNo,
        para2 = TargetBoId
        }.





% build_tips(summon_partner_failed, [ActorId, TargetPartnerId, Reason]) ->
%     TipsCode = to_tips_code(summon_partner_failed, Reason),
%     #btl_tips{
%         tips_code = TipsCode,
%         para1 = TargetPartnerId,
%         para2 = 0
%         }.





to_tips_code(cannot_use_skill, Reason) ->
    case Reason of
        unknown_err ->          2;
        hp_not_enough ->        3;
        mp_not_enough ->        4;
        anger_not_enough ->     5;
        cding ->                6;
        hp_rate_too_high ->     7;
        hp_rate_too_low ->      8;
        in_invisible_status ->  9;
        in_special_status ->    10;
        gamemoney_not_enough -> 20;
        _Any ->  % 容错：其他的统一归为“原因不明”   
            ?ERROR_MSG("[lib_bt_tips] to_tips_code(cannot_use_skil, ..) error!! unknown reason:~p", [_Any]),
            2
    end;



to_tips_code(use_goods_failed, Reason) ->
    case Reason of
        unknown_err ->           15;
        target_not_exists ->     16;
        target_dead ->           17;
        target_cannot_be_heal -> 18;
        target_soul_shackled ->  19;
        _Any ->  % 容错：其他的统一归为“原因不明”
            ?ERROR_MSG("[lib_bt_tips] to_tips_code(use_goods_failed, ..) error!! unknown reason:~p", [_Any]),                 
            15
    end.



% to_tips_code(summon_partner_failed, _Reason) ->
%     1.
