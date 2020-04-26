%%%-----------------------------------
%%% @Module  : pp_xinfa
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.11.16
%%% @Description: 心法、技能相关协议的处理
%%%-----------------------------------
-module(pp_xinfa).
-export([
        handle/3
        ]).

-include("common.hrl").
-include("pt_21.hrl").


%% 升级心法一键
upgrade_xinfa_one_key(PS,XinfaId) ->
    case mod_xinfa:is_valid_xinfa_id(XinfaId) of
        false ->
            skip;
        true ->
            case ply_xinfa:check_upgrade_xinfa(PS, XinfaId) of
                ok ->
                    PS1 = ply_xinfa:upgrade_xinfa(PS, XinfaId),
                    upgrade_xinfa_one_key(PS1,XinfaId);
                {fail, Reason} ->
                    XinfaLv = ply_xinfa:get_player_xinfa_lv(player:get_id(PS),XinfaId),
                    {ok, BinData} = pt_21:write(?PT_UPGRADE_XF, [?RES_OK, XinfaId,XinfaLv]),
                    lib_send:send_to_sock(PS, BinData),
                    Reason
            end
    end.

%% 查询自己的心法信息
handle(?PT_QUERY_XF_INFO, PS, _) ->
    PlayerId = player:id(PS),
    case ply_xinfa:get_player_xinfa_info(PlayerId) of
        null ->
            ?ASSERT(false),
            skip;
        PlaXinfa ->
            {ok, BinData} = pt_21:write(?PT_QUERY_XF_INFO, [PlaXinfa]),
            lib_send:send_to_sock(PS, BinData)
    end;

%% 升级心法
handle(?PT_UPGRADE_XF, PS, XinfaId) ->
    case mod_xinfa:is_valid_xinfa_id(XinfaId) of
        false ->
            ?ASSERT(false, XinfaId),
            skip;
        true ->
            case ply_xinfa:check_upgrade_xinfa(PS, XinfaId) of
                ok ->
                    ply_xinfa:upgrade_xinfa(PS, XinfaId),
                    XinfaLv = ply_xinfa:get_player_xinfa_lv(player:get_id(PS),XinfaId),
                    {ok, BinData} = pt_21:write(?PT_UPGRADE_XF, [?RES_OK, XinfaId,XinfaLv]),
                    lib_send:send_to_sock(PS, BinData);
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PS, Reason)
            end
    end;

%% 升级心法
handle(?PT_UPGRADE_XF_ONE_KEY, PS, XinfaId) ->
    upgrade_xinfa_one_key(PS,XinfaId),

    void;


%% 激活从属心法
handle(?PT_ACTIVATE_SLAVE_XF, PS, XinfaId) ->
    case mod_xinfa:is_valid_xinfa_id(XinfaId) of
        false ->
            ?ASSERT(false, XinfaId),
            skip;
        true ->
            case mod_xinfa:is_slave(XinfaId) of
                false ->
                    ?ASSERT(false, XinfaId),
                    skip;
                true ->
                    case ply_xinfa:check_activate_slave_xinfa(PS, XinfaId) of
                        ok ->
                            ply_xinfa:activate_slave_xinfa(PS, XinfaId),
                            {ok, BinData} = pt_21:write(?PT_ACTIVATE_SLAVE_XF, [?RES_OK, XinfaId]),
                            lib_send:send_to_sock(PS, BinData);
                        {fail, Reason} ->
                            lib_send:send_prompt_msg(PS, Reason)
                    end
            end
    end;


%% 请求门派技能列表
handle(?PT_FACTION_SKILLS, PS, _) ->
	SklBriefs = ply_faction:get_faction_skills(PS),
	{ok, BinData} = pt_21:write(?PT_FACTION_SKILLS, [SklBriefs]),
	lib_send:send_to_sock(PS, BinData);


%% 门派技能升级
handle(?PT_FACTION_SKILL_UP, PS, [SkillId]) ->
	case ply_faction:upgrade_faction_skill(PS, SkillId) of
		{ok, PS2} ->
			SklBriefs = ply_faction:get_faction_skills(PS2),
      ply_faction:finish_skill_achivement(PS2),
			{ok, BinData} = pt_21:write(?PT_FACTION_SKILLS, [SklBriefs]),
			lib_send:send_to_sock(PS2, BinData);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;


%% 转换门派
handle(?PT_FACTION_TRANSFORM, PS, [Faction]) ->
	case ply_faction:transform_faction(PS, Faction) of
		ok ->
			{ok, BinData} = pt_21:write(?PT_FACTION_TRANSFORM, [Faction]),
			lib_send:send_to_sock(PS, BinData);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end,
	void;



%% 转换门派消耗
handle(?PT_FACTION_TRANSFORM_COST, PS, []) ->
	case ply_faction:transform_faction_cost(PS) of
		{ok, PriceType, Value} ->
			{ok, BinData} = pt_21:write(?PT_FACTION_TRANSFORM_COST, [ PriceType, Value]),
			lib_send:send_to_sock(PS, BinData);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end,
	void;




handle(_Cmd, _PS, _Data) ->
    ?ASSERT(false, _Cmd),
    {error, bad_request}.










%% --------- 私有函数 ----------

