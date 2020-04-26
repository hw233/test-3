%%%--------------------------------------
%%% @Module  : ply_skill
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.10.30
%%% @Description: 玩家与技能相关的一些接口
%%%--------------------------------------
-module(ply_skill).
-export([
        already_learned_skill/2,
        get_skill_list/1,
        get_couple_skill_list/1,
        get_magic_key_skill_list/1,
        get_initiative_skill_list/1,
        get_passive_skill_list/1,
        get_equip_skill/1
    ]).

-include("common.hrl").
-include("xinfa.hrl").
-include("skill.hrl").
-include("fabao.hrl").
-include("record.hrl").
-include("record/goods_record.hrl").
-include("equip.hrl").
-include("mount.hrl").


%% 判断是否已经学习了某技能？
%% @return: true | false
already_learned_skill(_PS, _SkillId) ->
    % case SkillId of
    %     ?NORMAL_ATT_SKILL_ID ->
    %         true;  % 普通攻击不需学习，固定返回true
    %     _ ->
            % 临时都返回true
            todo_here,

            true.
    % end.



%% 获取玩家已解锁的技能列表（主动技 + 被动技）包括心法技能与法宝技能（因为法宝技能也有ai，自动挂机用到）
%% @return: [] | skl_brief结构体列表
get_skill_list(PlayerId) ->
    MagicSkillL = [#skl_brief{id = Id} || Id <- ply_skill:get_magic_key_skill_list(PlayerId)],
    case ply_xinfa:get_player_xinfa_info(PlayerId) of
        null ->
            MagicSkillL;
        PlyXfInfo ->
            XfBriefList = PlyXfInfo#ply_xinfa.info_list,
            MagicSkillL ++ lib_skill:derive_skill_list_from(XfBriefList)
    end.

%% 获取玩家的夫妻技能列表
%% @return: [] | skl_brief结构体列表
get_couple_skill_list(PlayerId) ->
    IdList = ply_relation:get_couple_skill_id_list(PlayerId),
    [#skl_brief{id = Id} || Id <- IdList].


%% 获取玩家可用的法宝技能id列表
get_magic_key_skill_list(PlayerId) ->
    case mod_equip:get_magic_key(PlayerId) of
        null -> [];
        Goods -> lib_goods:get_mk_skill_list(Goods)
    end.

% 获取人物装备技能
get_equip_skill(PlayerId) ->
    TEqpList = mod_equip:get_player_equip_list(PlayerId),
    Skills = [#skl_brief{id = lib_goods:get_equip_stunt(Goods),lv=player:get_lv(PlayerId)} || Goods <- TEqpList, lib_goods:get_equip_stunt(Goods) =/= 0],

    EffectNos = [lib_goods:get_equip_effect(Goods) || Goods <- TEqpList, lib_goods:get_equip_effect(Goods) =/= 0],
    EffectSkills = [#skl_brief{id = (data_equip_speci_effect:get(EffectNo))#equip_speci_effect_tpl.value} || EffectNo <- EffectNos,
        (data_equip_speci_effect:get(EffectNo))#equip_speci_effect_tpl.eff_name =:= ?EQUIP_EFFECT_ADD_SKILL],
    ?DEBUG_MSG("Skills=~p,EffectNos===~p,EffectSkills=~p",[Skills,EffectNos,EffectSkills]),
    Skills ++ EffectSkills.



% 获取玩家门派技能列表
get_faction_skill(PlayerId) when is_integer(PlayerId) ->
	PS = player:get_PS(PlayerId),
	get_faction_skill(PS);

get_faction_skill(PS) ->
	ply_faction:get_faction_skills(PS).


%% 获取主动技列表
%% @return: [] | skl_brief结构体列表
get_initiative_skill_list(PlayerId) ->
    %%获取法宝技能
    FabaoSkill=
        case lib_fabao:get_fabao_battle(PlayerId) of
            [] -> [];
            FaBaoId ->
                case lib_fabao:get_fabao_info(FaBaoId) of
                    [] ->
                        [];
                    RecordData  ->
                        [ {skl_brief, X ,player:get_lv(PlayerId)} || X <- [RecordData#fabao_info.skill_array_1,RecordData#fabao_info.skill_array_2,RecordData#fabao_info.skill_array_3], X > 0]
                end
        end,
    PS = player:get_PS(PlayerId),
    TmpSkillList =  [ {skl_brief, TmpNo ,player:get_lv(PlayerId)} || TmpNo <-  PS#player_status.tmp_skill, TmpNo > 0],
	%% 门派技能
	SkillsFaction = get_faction_skill(PS),
    L = get_skill_list(PlayerId) ++ get_equip_skill(PlayerId) ++ FabaoSkill ++ TmpSkillList ++ SkillsFaction,
    [X || X <- L, mod_skill:is_initiative(X#skl_brief.id)].

% 获取坐骑技能列表
get_passive_skill_list_of_mount(PlayerId) ->
    PS = player:get_PS(PlayerId),
    case player:get_mount(PS) of
        ?INVALID_ID -> [];
        MountId -> [#skl_brief{id = X} || X <- lib_mount:get_mount_skill(MountId), X =/= ?INVALID_NO]
    end.

get_mount_step_skill(PS) ->
    case player:get_mount(PS) of
        ?INVALID_ID -> [];
        MountId ->
            case lib_mount:get_mount(MountId) of
                Mount when is_record(Mount, ets_mount) ->
                    SkillList = (data_mount:get_mount_info(Mount#ets_mount.no))#mount_info.step_skill,
                    {StepSkill, _Step} = lists:nth(Mount#ets_mount.step, SkillList),
                    [#skl_brief{id = StepSkill}];
                _ -> []
            end
    end.

%% 获取被动技列表
%% @return: [] | skl_brief结构体列表
get_passive_skill_list(PlayerId) ->
    L = get_skill_list(PlayerId) ++ get_equip_skill(PlayerId) ++ get_passive_skill_list_of_mount(PlayerId) ++ get_faction_skill(PlayerId) ++ get_mount_step_skill(player:get_PS(PlayerId)),
    [X || X <- L, mod_skill:is_passive(X#skl_brief.id)].

% get_skill_lv(_PS, _SkillId) ->
%     % 暂时都返回1级
%     1.






    




%% 作废！！
% %% 检查是否满足技能的使用条件？
% %% @return: ok | {fail, Reason}
% check_use_conditions(PS, SkillId) ->
%     % case SkillId of
%     %     ?NORMAL_ATT_SKILL_ID ->
%     %         ok;   % 普通攻击无使用条件限制，固定返回ok
%     %     _ ->
%             SkillLv = get_skill_lv(PS, SkillId),
%             SklCfg = mod_skill:get_cfg_data(SkillId, SkillLv),
%             ConditionList = mod_skill:get_use_condition_list(SklCfg),
%             check_use_conditions__(ConditionList, PS).
%     % end.

            



% check_use_conditions__([Condition | T], PS) ->
%     case check_one_use_condition(Condition, PS) of
%         ok ->
%             check_use_conditions__(T, PS);
%         {fail, Reason} ->
%             {fail, Reason}
%     end;
% check_use_conditions__([], _PS) ->
%     ok.




% % -define(USE_CONDI_HP_RATE_MORE_THAN, hp_rate_more_than).
% % -define().

% check_one_use_condition({hp_rate_more_than, _Rate}, _PS) ->
%     % HpLim = player:get_hp_lim(PS),
%     % Hp = player:get_hp(PS),
%     % case Hp >= HpLim * Rate of
%     %     true ->
%     %         ok;
%     %     false ->
%     %         {fail, ?PM_REQ_USE_SKL_FAIL_HP_NOT_ENOUGH}
%     % end;

%     ok;


% check_one_use_condition({hp_rate_less_than, _Rate}, _PS) ->
%     % HpLim = player:get_hp_lim(PS),
%     % Hp = player:get_hp(PS),
%     % case Hp =< HpLim * Rate of
%     %     true ->
%     %         ok;
%     %     false ->
%     %         {fail, ?PM_REQ_USE_SKL_FAIL_HP_TOO_MUCH}
%     % end;

%     ok;

% check_one_use_condition(_Condition, _PS) ->
%     ?ASSERT(false, _Condition),
%     {fail, ?PM_UNKNOWN_ERR}.

    




