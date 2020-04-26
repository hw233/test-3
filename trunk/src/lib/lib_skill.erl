%%%--------------------------------------
%%% @Module  : lib_skill
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.2.17
%%% @Description : 技能相关的公用函数
%%%--------------------------------------
-module(lib_skill).
-export([
        pick_initiative_skill_list_from/1,
		build_AI_list_from/1,
		derive_skill_list_from/1
    ]).

-include("common.hrl").
-include("skill.hrl").
-include("xinfa.hrl").



%% 从列表挑选出主动技能
pick_initiative_skill_list_from(SklBriefList) ->
    F = fun(SklBrief) ->
            SkillId = SklBrief#skl_brief.id,
            mod_skill:is_initiative(SkillId)
        end,
    [X || X <- SklBriefList, F(X)].





%% @return：[] | ai编号列表
build_AI_list_from(SklBriefList) ->
	SklIdList = [X#skl_brief.id || X <- SklBriefList],
    F = fun(SklId, AccAIList) ->
            SklCfg = mod_skill:get_cfg_data(SklId),
            L = mod_skill:get_AI_list(SklCfg),
            L ++ AccAIList
        end,
    lists:foldl(F, [], SklIdList).

                    


%% 从心法信息列表推导出技能信息列表
%% @return: [] | skl_brief结构体列表
derive_skill_list_from(XfBriefList) ->
	F = fun(XfBrief) ->
            XfId = XfBrief#xinfa_brief.id,
            XfLv = XfBrief#xinfa_brief.lv,
            XfCfg = mod_xinfa:get_cfg_data(XfId),
            ?ASSERT(XfCfg /= null),
            pick_already_unlock_skill_list(XfCfg, XfLv)
        end,     
    L = [F(X) || X <- XfBriefList],
    lists:flatten(L).










%% 挑选出已经解锁的技能id列表
pick_already_unlock_skill_list(XfCfg, CurXfLv) ->
    SklBrief1 = case mod_xinfa:get_skill1(XfCfg) of
                    ?INVALID_ID ->
                        invalid;
                    Skill1_Id ->
                        Skill1_UnlockLv = mod_xinfa:get_skill1_unlock_lv(XfCfg),
                        case CurXfLv >= Skill1_UnlockLv of
                            true -> #skl_brief{id = Skill1_Id, lv = CurXfLv - Skill1_UnlockLv + 1};
                            false -> invalid
                        end
                end,

    SklBrief2 = case mod_xinfa:get_skill2(XfCfg) of
                    ?INVALID_ID ->
                        invalid;
                    Skill2_Id ->
                        Skill2_UnlockLv = mod_xinfa:get_skill2_unlock_lv(XfCfg),
                        case CurXfLv >= Skill2_UnlockLv of
                            true -> #skl_brief{id = Skill2_Id, lv = CurXfLv - Skill2_UnlockLv + 1};
                            false -> invalid
                        end
                end,

    SklBrief3 = case mod_xinfa:get_skill3(XfCfg) of
                    ?INVALID_ID ->
                        invalid;
                    Skill3_Id ->
                        Skill3_UnlockLv = mod_xinfa:get_skill3_unlock_lv(XfCfg),
                        case CurXfLv >= Skill3_UnlockLv of
                            true -> #skl_brief{id = Skill3_Id, lv = CurXfLv - Skill3_UnlockLv + 1};
                            false -> invalid
                        end
                end,

    L = [SklBrief1, SklBrief2, SklBrief3],
    RetL = [X || X <- L, X /= invalid],
    ?ASSERT(util:is_tuple_list(RetL)),
    RetL.
