%%%--------------------------------------
%%% @Module  : 
%%% @Author  : 
%%% @Email   : 
%%% @Created : 
%%% @Description: 心法、技能系统的相关协议
%%%--------------------------------------
-module(pt_21).
-export([read/2, write/2]).

-include("common.hrl").
-include("pt_21.hrl").
-include("xinfa.hrl").
-include("debug.hrl").
-include("skill.hrl").

%%
%%客户端 -> 服务端 ----------------------------
%%

read(?PT_QUERY_XF_INFO, _) ->
    {ok, dummy};



read(?PT_UPGRADE_XF, <<XinfaId:32>>) ->
    {ok, XinfaId};

read(?PT_UPGRADE_XF_ONE_KEY, <<XinfaId:32>>) ->
    {ok, XinfaId};

   
% read(?PT_UPGRADE_XF, <<XinfaId:32, TargetLv:8, TargetExp>>) ->
%     {ok, [XinfaId, TargetLv, TargetExp]};


read(?PT_ACTIVATE_SLAVE_XF, <<XinfaId:32>>) ->
	{ok, XinfaId};



read(?PT_FACTION_SKILLS, <<>>) ->
	{ok, []};



read(?PT_FACTION_SKILL_UP, <<SkillId:32>>) ->
	{ok, [SkillId]};


read(?PT_FACTION_TRANSFORM, <<Faction:8>>) ->
	{ok, [Faction]};


read(?PT_FACTION_TRANSFORM_COST, <<>>) ->
	{ok, []};

% read(21002, _B0) ->
%     {P0_id, _B1} = pt:read_uint32(_B0),
%     {ok, [P0_id]};


% read(21003, <<Id:32, SkillId:32, Cell:8>>) ->
%     {ok, [Id, SkillId, Cell]};


% read(21004, <<Id:32, Cell1:8, Cell2:8>>) ->
%     {ok, [Id, Cell1, Cell2]};


% read(21005, _B0) ->
%     {P0_troop_id, _B1} = pt:read_uint32(_B0),
%     {ok, [P0_troop_id]};


% read(21007, _B0) ->
%     {ok, []};


% read(21008, _B0) ->
%     {ok, []};


% read(21009, <<Type:32>>) ->
%     {ok, [Type]};

% read(21010, _) ->
% 	{ok, []};

% %% read(21101, _B0) ->
% %%     {ok, []};
% %% 
% %% 
% %% read(21102, _B0) ->
% %%     {P0_partner_id, _B1} = pt:read_uint32(_B0),
% %%     {ok, [P0_partner_id]};


% %% -----------------------------武将技能------------------------------------
% read(21100, <<BookId:32, PartnerId:32>>) ->
% 	{ok, [BookId, PartnerId]};

% read(21102, <<PartnerId:32>>) ->
% 	{ok, [PartnerId]};

% read(21103, <<PartnerId:32, Seq:8>>) ->
% 	{ok, [PartnerId, Seq]};

% read(21104, <<PartnerId:32, SkillId:32, Type:8>>) ->
% 	{ok, [PartnerId, SkillId, Type]};

% read(21105, <<BookId:32>>) ->
% 	{ok, [BookId]};

read(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.

%%
%%服务端 -> 客户端 ------------------------------------
%%

% write(21001, [P0_skill_point, P0_skills]) ->
%     Data = <<P0_skill_point:32, (length(P0_skills)):16, (list_to_binary([<<P1_id:32, P1_cur_lv:8, P1_max_lv:8, P1_can_study:8, P1_is_eq:8>> || {P1_id, P1_cur_lv, P1_max_lv, P1_can_study, P1_is_eq} <- P0_skills]))/binary>>,
%     {ok, pt:pack(21001, Data)};


% write(21002, [P0_code]) ->
%     Data = <<P0_code:8>>,
%     {ok, pt:pack(21002, Data)};


% write(21003, [P0_res, P0_auto_eq, P0_skill, P0_cell]) ->
%     Data = <<P0_res:8, P0_auto_eq:8, P0_skill:32, P0_cell:8>>,
%     {ok, pt:pack(21003, Data)};


% write(21004, [P0_code]) ->
%     Data = <<P0_code:8>>,
%     {ok, pt:pack(21004, Data)};


% write(21005, []) ->
%     Data = <<>>,
%     {ok, pt:pack(21005, Data)};


% % write(21007, [P0_update_skill_list]) ->
% %     Data = pack_21007(P0_update_skill_list),
% %     {ok, pt:pack(21007, Data)};

% write(21008, [P0_eq_skills]) ->
%     Data = <<(length(P0_eq_skills)):16, (list_to_binary([<<P1_skill_id:32, P1_cell:8>> || {P1_skill_id, P1_cell} <- P0_eq_skills]))/binary>>,
%     {ok, pt:pack(21008, Data)};


% write(21009, [P0_code, P0_skill_pit]) ->
%     Data = <<P0_code:8, P0_skill_pit:32>>,
%     {ok, pt:pack(21009, Data)};

% write(21010, [Flag]) ->
% 	{ok, pt:pack(21010, <<Flag:8>>)};

% %% write(21101, [P0_partner_id, P0_skill_id, P0_skill_lv]) ->
% %%     Data = <<P0_partner_id:32, P0_skill_id:32, P0_skill_lv:16>>,
% %%     {ok, pt:pack(21101, Data)};
% %% 
% %% 
% %% write(21102, [P0_skill_list_all, P0_skill_list, P0_eq_skill_list]) ->
% %%     Data = <<(length(P0_skill_list_all)):16, (list_to_binary([<<P1_id_all:32>> || P1_id_all <- P0_skill_list_all]))/binary, (length(P0_skill_list)):16, (list_to_binary([<<P1_id:32, P1_lv:16>> || {P1_id, P1_lv} <- P0_skill_list]))/binary, (length(P0_eq_skill_list)):16, (list_to_binary([<<P1_id_eq:32, P1_equit:16>> || {P1_id_eq, P1_equit} <- P0_eq_skill_list]))/binary>>,
% %%     {ok, pt:pack(21102, Data)};


% %% -----------------------------武将技能------------------------------------
% write(21100, [Flag]) ->
% 	{ok, pt:pack(21100, <<Flag:8>>)};

% write(21101, [PartnerId, SkillID, SkillLv]) ->
% 	{ok, pt:pack(21101, <<PartnerId:32, SkillID:32, SkillLv:16>>)};

% write(21102, [CastSeq, SkillList, EqSkillList]) ->
% 	SkillLen = length(SkillList),
% 	EqSkillLen = length(EqSkillList),
% 	SkillFun = 
% 		fun({Id, Lv, _Grid, Profi}) ->
% 				?TRACE("? Id=~p, Lv=~p~n", [Id, Lv]),
% 				{_, MaxProfi} = lib_skill:get_skill_condition(Id, Lv),
% 				MaxLv = lib_skill:get_max_lv(Id),
% 				<<Id:32, Lv:16, MaxLv:16, Profi:32, MaxProfi:32>>
% 		end,
% 	EqFun = 
% 		fun({EqId, _, EqGrid, _}) ->
% 				<<EqId:32, EqGrid:8>>
% 		end,
% 	SkillData = tool:to_binary([SkillFun(Skill) || Skill <- SkillList, Skill =/= {}]),
% 	EqData = tool:to_binary([EqFun(Eq) || Eq <- EqSkillList, Eq =/= {}]),
% 	{ok, pt:pack(21102, <<CastSeq:8, SkillLen:16, SkillData/binary, EqSkillLen:16, EqData/binary>>)};

% write(21103, [Flag]) ->
% 	{ok, pt:pack(21103, <<Flag:8>>)};

% write(21104, [Flag]) ->
% 	{ok, pt:pack(21104, <<Flag:8>>)};

% write(21105, [SkillId, PartnerList, Career, PName, Color]) ->
% 	BpName = tool:to_binary(PName),
% 	Plen = byte_size(BpName),
% 	Len = length(PartnerList),
% 	F = fun(Partner) ->
% 				BinName = tool:to_binary(Partner#partner.name),
% 				NameLen = byte_size(BinName),
% 				<<(Partner#partner.id):32, (Partner#partner.lv):16, 
% 				  NameLen:16, BinName/binary>>
% 		end,
% 	BinData = tool:to_binary([F(X) || X <- PartnerList, X /= []]),
% 	ColorLen = length(Color),
% 	Cf = fun(Col) -> <<Col:32>> end,
% 	Bcolor = tool:to_binary([Cf(Cx) || Cx <- Color, Cx /= []]),
% 	{ok, pt:pack(21105, <<SkillId:32, Len:16, BinData/binary, Career:32, Plen:16, BpName/binary, ColorLen:16, Bcolor/binary>>)};


write(?PT_QUERY_XF_INFO, [PlyXinfa]) ->
	F = fun(XfBrief) ->
			XfId = XfBrief#xinfa_brief.id,
			XfLv = XfBrief#xinfa_brief.lv,
			XfCfg = mod_xinfa:get_cfg_data(XfId),
			AddAttrsPara_Bin = build_add_attrs_para_bin(XfCfg, XfLv),
			<<XfId:32, XfLv:16, AddAttrsPara_Bin/binary>>
		end,
	Bin = list_to_binary([F(X) || X <- PlyXinfa#ply_xinfa.info_list]),
	Bin2 = <<
			  (length(PlyXinfa#ply_xinfa.info_list)) : 16,
			  Bin / binary
		   >>,
	{ok, pt:pack(?PT_QUERY_XF_INFO, Bin2)};


write(?PT_UPGRADE_XF, [RetCode, XinfaId,XinfaLv]) ->
	Bin = <<RetCode:8, XinfaId:32, XinfaLv:32 >>,
	{ok, pt:pack(?PT_UPGRADE_XF, Bin)};


write(?PT_ACTIVATE_SLAVE_XF, [RetCode, XinfaId]) ->
	Bin = <<RetCode:8, XinfaId:32>>,
	{ok, pt:pack(?PT_ACTIVATE_SLAVE_XF, Bin)};


write(?PT_FACTION_SKILLS, [Skills]) ->
	Length = length(Skills),
	BinAcc0 = <<Length:16>>,
	BinData = 
		lists:foldl(fun(#skl_brief{id = SkillId, lv = SkillLv}, BinAcc) ->
						BinAcc2 = <<SkillId:32, SkillLv:16>>,
						<<BinAcc/binary, BinAcc2/binary>>
				end, BinAcc0, Skills),
	{ok, pt:pack(?PT_FACTION_SKILLS, BinData)};


write(?PT_FACTION_TRANSFORM, [Faction]) ->
	{ok, pt:pack(?PT_FACTION_TRANSFORM, <<Faction:8>>)};



write(?PT_FACTION_TRANSFORM_COST, [PriceType, Value]) ->
	{ok, pt:pack(?PT_FACTION_TRANSFORM_COST, <<PriceType:8, Value:32>>)};

write(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
    % {ok, pt:pack(0, <<>>)}.
    {error, not_match}.

% %% exports
% %% desc: 
% pack_21007(SklRespInfoList) ->
%     Count = length(SklRespInfoList),
%     Bin = list_to_binary( lists:map(fun sel_send_field/1, SklRespInfoList) ),
%     <<Count:16, Bin/binary>>.

% %% desc: 选择要发送的字段
% sel_send_field(SklRespInfo) ->
% 	?TRACE("sel_send_field,  ~p~n", [SklRespInfo]),
%     <<
%     	(SklRespInfo#skl_resp_info.id) : 32,
%     	(SklRespInfo#skl_resp_info.lv) : 16,
%     	(SklRespInfo#skl_resp_info.grid) : 16,
%     	(util:bool_to_int(SklRespInfo#skl_resp_info.is_can_use)) : 8,
%     	(SklRespInfo#skl_resp_info.cd_left_round) : 8,
%     	(SklRespInfo#skl_resp_info.cfg_cd_round) : 8
%     >>.
%     



build_add_attrs_para_bin(XfCfg, XfLv) ->
	AddAttrsNameList = mod_xinfa:get_add_attrs_name_list(XfCfg),
	AddAttrs_KV_TupleList = ply_attr:build_xinfa_add_attrs_KV_list(AddAttrsNameList, XfLv),
	case AddAttrs_KV_TupleList of
		[OnlyOneAddAttr] ->
			<<
				(build_one_add_attr_para_bin(OnlyOneAddAttr)) / binary,
				0 : 8,  % 第二个参数无效，统一返回0
				0 : 32
			>>;
		[AddAttr1, AddAttr2] ->
			<<
				(build_one_add_attr_para_bin(AddAttr1)) / binary,
				(build_one_add_attr_para_bin(AddAttr2)) / binary
			>>;
		_ ->
			?ASSERT(false, XfCfg),
			<<0:8, 0:32, 0:8, 0:32>>
	end.


build_one_add_attr_para_bin(AddAttr) ->
	case AddAttr of
		{_AttrName, Value} ->
			<<?VALUE_T_INT:8, Value:32>>;
		{_AttrName, rate, Value} ->
			<<?VALUE_T_PERCENT:8, Value:32>>
	end.