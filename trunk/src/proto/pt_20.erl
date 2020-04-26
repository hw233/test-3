%%%-----------------------------------
%%% @Module  : pt_20
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.29
%%% @Description: 20战斗信息
%%%-----------------------------------
-module(pt_20).
-export([read/2, write/2]).

-include("common.hrl").
% -include("record.hrl").
-include("record/battle_record.hrl").
-include("pt_20.hrl").
-include("attribute.hrl").

% %%
% %%客户端 -> 服务端 ----------------------------
% %%

%% 触发战斗：打怪
read(?PT_BT_START_MF, <<MonId:32, Difficulty:8>>) ->
    {ok, [MonId, Difficulty]};


%% 触发战斗：PK
read(?PT_BT_START_PK, <<TargetPlayerId:64, PK_Type:8>>) ->
    {ok, [TargetPlayerId, PK_Type]};



read(?PT_BT_REPLY_PK_INVITE, <<ReplyCode:8, FromPlayerId:64, PK_Type:8>>) ->
	{ok, [ReplyCode, FromPlayerId, PK_Type]};


read(?PT_BT_QRY_BATTLE_FIELD_DESC, _) ->
    {ok, dummy};


read(?PT_BT_C2S_NOTIFY_SHOW_BR_DONE, _) ->
    {ok, dummy};


read(?PT_BT_NOP_CMD, <<ForBoId:16>>) ->
    {ok, ForBoId};


read(?PT_BT_USE_SKILL, <<ForBoId:16, SkillId:32, TargetBoId:16>>) ->
    {ok, [ForBoId, SkillId, TargetBoId]};

read(?PT_BT_CMD_CAPTURE_PARTNER, <<ForBoId:16, TargetBoId:16>>) ->
{ok, [ForBoId, TargetBoId]};


% read(?PT_BT_USE_SKILL_OUTSIDE_BATTLE, <<SkillId:32>>) ->
%     {ok, SkillId};


read(?PT_BT_USE_GOODS, <<ForBoId:16, GoodsId:64, TargetBoId:16>>) ->
    {ok, [ForBoId, GoodsId, TargetBoId]};


read(?PT_BT_PROTECT_OTHERS, <<ForBoId:16, TargetBoId:16>>) ->
	{ok, [ForBoId, TargetBoId]};


read(?PT_BT_ESCAPE, <<ForBoId:16>>) ->
	{ok, ForBoId};


read(?PT_BT_DEFEND, <<ForBoId:16>>) ->
	{ok, ForBoId};

read(?PT_BT_SUMMON_PARTNER, <<ForBoId:16, PartnerId:64>>) ->
	{ok, [ForBoId, PartnerId]};


read(?PT_BT_REQ_PREPARE_CMD_BY_AI, <<ForBoId:16>>) ->
	{ok, ForBoId};


read(?PT_BT_QRY_BO_BUFF_INFO, <<BoId:16, BuffNo:32>>) ->
	{ok, [BoId, BuffNo]};


read(?PT_BT_REQ_AUTO_BATTLE, _) ->
	{ok, dummy};

read(?PT_BT_CANCEL_AUTO_BATTLE, _) ->
	{ok, dummy};
	

read(?PT_BT_QUERY_SKILL_USABLE_INFO, <<TargetBoId:16>>) ->
	{ok, TargetBoId};


read(?PT_BT_QUERY_BO_INFO_AFTER_BACK_TO_BATTLE, <<TargetBoId:16>>) ->
	{ok, TargetBoId};

read(?PT_BT_TRY_GO_BACK_TO_BATTLE, _) ->
	{ok, dummy};

read(?PT_BT_C2S_NOTIFY_BATTLE_END, _) ->
	{ok, []};

read(?PT_BT_QUERY_BATTLE_START_TIME, <<>>) ->
	{ok, dummy};

read(?PT_BT_DBG_FORCE_QUIT_BATTLE, <<>>) ->
	{ok, dummy};


read(?PT_BT_DBG_GET_BO_INFO, <<BoId:16>>) ->
	{ok, BoId};

read(?PT_BT_CAPTAIN_PROJECT, <<BoId:16, Cmd:16>>) ->
	{ok, [BoId, Cmd]};

% %%人打人
% read(20002, <<Id:32>>) ->
%     {ok, Id};

% %%复活
% read(20004, _) ->
%     {ok, <<>>};

% %%使用辅助技能
% read(20006, <<Id:32, Sid:32>>) ->
%     {ok, [Id, Sid]};

% %%选择技能
% read(20009, <<BattleObjId:32, SkillId:32, SkillLv:16, SkillGrid:16>>) ->
%     {ok, [BattleObjId, SkillId, SkillLv, SkillGrid]};

% %%准备下一回合战斗
% read(20011, <<BattleObjId:32>>) ->
%     {ok, BattleObjId};

% %给玩家补血
% read(20013, _) ->
%     {ok, <<>>};

% %% 请求开始剧情CG战斗
% read(20015, <<CGSeqNum:32, MonObjId:32>>) ->
%     {ok, [CGSeqNum, MonObjId]};
    
% %%客户端通知服务端：播放剧情战斗CG完毕
% read(20016, <<CGSeqNum:32>>) ->
%     {ok, CGSeqNum};
    
% %% 客户端通知服务端：玩家处理QTE的结果
% read(?PT_BT_QTE_RESULT, <<BattleObjId:32, Result:8, CheckCode:32>>) ->
%     {ok, [BattleObjId, Result, CheckCode]};
    
    
% %% 客户端通知服务端：客户端倒计时开始了
% read(?PT_BT_CLIENT_COUNT_DOWN_START, <<BattleObjId:32>>) ->
% 	{ok, BattleObjId};
	
% %% 中途加入战斗
% read(?PT_BT_JOIN_BATTLE_MIDWAY, <<TargetPlayerId:32>>) ->
% 	{ok, TargetPlayerId};
	
	
% %% 请求自动战斗
% read(?PT_BT_REQ_AUTO_BATTLE, _) ->
% 	{ok, []};	
	
% %% 取消自动战斗
% read(?PT_BT_CANCEL_AUTO_BATTLE, _) ->
% 	{ok, []};		
	
% %% 查询挂机的技能组合	
% read(?PT_AM_QUERY_SKILL_COMB, <<CombId:8>>) ->
% 	{ok, CombId};
	
% %% 查询玩家的自动挂机设置信息	
% read(?PT_AM_QUERY_MY_SET_INFO, _) ->
% 	{ok, []};
	
% %% 设置挂机的技能组合	
% read(?PT_AM_SET_SKILL_COMB, <<CombId:8, SkillCount:16, SkillCombBin/binary>>) ->
% 	{ok, [CombId, SkillCount, SkillCombBin]};	

% %% 清空挂机的技能组合	
% %%read(?PT_AM_CLEAR_SKILL_COMB, <<CombId:8>>) ->
% %%	{ok, CombId};
	
% %% 选择挂机所使用的技能组合	
% read(?PT_AM_SELECT_SKILL_COMB, <<CombId:8>>) ->
% 	{ok, CombId};
	
	
% %% 设置挂机的怒气上限	
% %%read(?PT_AM_SET_ANGER_LIM, <<AngerLim:8>>) ->
% %%	{ok, AngerLim};


% %% 尝试添加新的已学技能到技能组合中	
% read(?PT_AM_TRY_ADD_NEW_SKILLS_TO_COMB, <<CombId:8, SkillCount:16, SkillIdList_Bin/binary>>) ->
% 	{ok, [CombId, SkillCount, SkillIdList_Bin]};
	
	
% %% 设置是否自动购买气血包
% read(?PT_AM_SET_AUTO_BUY_HP_BAG, <<Flag:8>>) ->
% 	{ok, Flag};	
% %% desc: 技能颜色球使用结果
% read(?PT_BT_SKILL_BALL_RESULT, <<SkillBallId:32, Lv:8>>) ->
%     {ok, [SkillBallId, Lv]};

% %% desc: 
% read(?PT_AM_FORCE_EXIT_BATTLE, _) ->
%     {ok, none};

read(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.

% %%
% %%服务端 -> 客户端 ------------------------------------
% %%

% %% %%广播战斗结果 - 玩家PK怪
% %% write(20001, [Id, Hp, Mp, Sid, X, Y, DefList]) ->
% %%     Data1 = <<Id:32, Hp:32, Mp:32, Sid:32, X:16, Y:16>>,
% %%     Data2 = def_list(DefList),
% %%     Data = << Data1/binary, Data2/binary>>,
% %%     {ok, pt:pack(20001, Data)};

% %% 新的战斗结果
% % write(20001, TurnList) ->
% % TurnList = [Turn1, Turn2, Turn3, ...]
% % Turni = [Atter-Defers-Pair1, Atter-Defers-Pair2, ...]
% % Atter-Defers-Pair = [Atter, [Defer1, Defer2, ...]]
% % Atter = [atterId/int32, skillId/int32]
% % Deferi =[mon_or_player/int8,deferId/int32,damage/int32,state/int8]


% %%广播战斗结果 - 玩家PK玩家
% %write(20002, [Pid1, Pid2, Hurt, Sid, Hp1, Mp1, Hp2, Mp2, S]) ->
% %    Data = <<Pid1:32, Hp1:32, Mp1:32, Pid2:32, Hp2:32, Mp2:32, Hurt:32, Sid:16, S:8>>,
% %    {ok, pt:pack(20002, Data)};

% %%广播战斗结果 - 怪PK玩家
% write(20003, [Id, Hp, Mp, Sid, X, Y, DefList]) ->
%     Data1 = <<Id:32, Hp:32, Mp:32, Sid:32, X:16, Y:16>>,
%     Data2 = def_list(DefList),
%     Data = << Data1/binary, Data2/binary>>,
%     {ok, pt:pack(20003, Data)};

% %%广播战斗结果 - 怪PK玩家
% write(20005, [State, Sign1, User1, Hp1, X1, Y1, Sign2, User2, Hp2, X2, Y2]) ->
%     {ok, pt:pack(20005, <<State:8, Sign1:8, User1:32, Hp1:32, X1:16, Y1:16, Sign2:8, User2:32, Hp2:32, X2:16, Y2:16>>)};

% %%广播战斗结果 - 辅助技能
% write(20006, [Id, Sid, MP, List]) ->
%     Data1 = <<Id:32, Sid:32, MP:32>>,
%     Data2 = assist_list(List),
%     Data = << Data1/binary, Data2/binary>>,
%     {ok, pt:pack(20006, Data)};

% %%战场初始化
% write(20007, {Is_reverse, Is_att_side, SkillRespInfoList, Bo_id, [BattleType, BattleSubType, AerWidth,AerHeight,AerList,DerWidth,DerHeight,DerList]}) ->
% 	?DEBUG_MSG("write 20007...", []),
% 	AHideBorder = 1,  % 固定隐藏左方的阵法边缘
% 	DHideBorder = 1,  % 固定隐藏右方的阵法边缘
% 	Data0 = pt_21:pack_21007(SkillRespInfoList),
% 	Data1 = <<AerWidth:8,AerHeight:8,AHideBorder:8>>,
% 	Data2 = pack_obj_list(AerList),
% 	Data3 = <<DerWidth:8,DerHeight:8,DHideBorder:8>>,
% 	Data4 = pack_obj_list(DerList),
% 	Data = <<BattleType:8, BattleSubType:8, Is_reverse:8, Is_att_side:8, Data0/binary, Bo_id:32, Data1/binary, Data2/binary, Data3/binary, Data4/binary>>,
% 	{ok, pt:pack(20007, Data)};

% %%战报数据
% write(20008, BattleReportData) ->
% 	?DEBUG_MSG("write 20008...", []),
% 	?ASSERT(BattleReportData /= []),
%     Data = pack_battle_report_list(BattleReportData),
%     {ok, pt:pack(20008, Data)};

% %%选择技能（成功则返回当前目标格子坐标，否则返回失败原因）
% write(20009, {FailReason}) ->
%     Data = <<FailReason:8, 0:8, 0:8, 0:32, 0:16, 0:16, <<>>/binary>>,
%     {ok, pt:pack(20009, Data)};
% write(20009, {X, Y, SkillId, SkillLv, SkillBallList}) ->
%     F = fun(SkillBallColor) -> <<SkillBallColor:32>> end,
%     Len = length(SkillBallList),
%     Bin = list_to_binary( lists:map(F, SkillBallList) ),
%     Res = ?RESULT_OK,
%     Data = <<Res:8, X:8, Y:8, SkillId:32, SkillLv:16, Len:16, Bin/binary>>,
%     {ok, pt:pack(20009, Data)};

% %%战斗结果
% write(20010, Result) ->
%     {ok, pt:pack(20010, <<Result:32>>)};

% %%通知客户端删除某战斗对象
% write(20012, BattleObjId) ->
%     {ok, pt:pack(20012, <<BattleObjId:32>>)};

% %%帮会PVP发起战斗失败
% write(20014, BinFailReason) ->
% 	Len = byte_size(BinFailReason),
%     {ok, pt:pack(20014, <<Len:16,BinFailReason/binary>>)};

% %% 通知客户端开始倒计时    
% write(?PT_BT_NOTIFY_CLIENT_COUNT_DOWN, _) ->
% 	?DEBUG_MSG("write PT_BT_NOTIFY_CLIENT_COUNT_DOWN...", []),
% 	{ok, pt:pack(?PT_BT_NOTIFY_CLIENT_COUNT_DOWN, <<>>)};
	

% %% 通知客户端显示QTE	
% write(?PT_BT_NOTIFY_CLIENT_SHOW_QTE, [SkillType, CheckCode, SkillId]) ->
% 	QTE_Type = 	case SkillType of
% 					?SKL_T_COMM -> 1;
% 					?SKL_T_PURSUE -> 1;
% 					?SKL_T_COOPERATE -> 2
% 				end,
% 	%%F = fun(KeyCode) ->
% 	%%		<<KeyCode: 32>>
% 	%%	end,
% 	%%Data = list_to_binary([F(X) || X <- KeyCodeList]),
% 	%%KeyCount = length(KeyCodeList),
% 	%%?DEBUG_MSG("keycount : ~p, keybin: ~p", [KeyCount, Data]),
% 	%%RespData = <<QTE_Type:8, CheckCode:32, KeyCount:16, Data/binary>>,
% 	RespData = <<QTE_Type:8, CheckCode:32, SkillId:32>>,
% 	{ok, pt:pack(?PT_BT_NOTIFY_CLIENT_SHOW_QTE, RespData)};
	

% %% 通知客户端更新战斗对象的属性
% write(?PT_BT_NOTIFY_BO_ATTR_CHANGED, [Bo, ChangeReason]) ->
%     write(?PT_BT_NOTIFY_BO_ATTR_CHANGED, [Bo, ChangeReason, 0, 0]);
% write(?PT_BT_NOTIFY_BO_ATTR_CHANGED, [Bo, ChangeReason, AddBoHpNum, AddMyHpBoId]) ->
% %%write(?PT_BT_NOTIFY_BO_ATTR_CHANGED, Bo) ->
% 	?ASSERT(is_integer(ChangeReason), ChangeReason),
% 	?ASSERT(is_integer(Bo#battle_obj.hp), Bo#battle_obj.hp),
% 	?ASSERT(Bo#battle_obj.hp >= 0, Bo#battle_obj.hp),
% 	?ASSERT(is_integer(Bo#battle_obj.anger), Bo#battle_obj.anger),
% 	?ASSERT(Bo#battle_obj.anger >= 0, Bo#battle_obj.anger),
% 	?ASSERT(is_integer(Bo#battle_obj.arousal), Bo#battle_obj.arousal),
% 	?ASSERT(Bo#battle_obj.arousal >= 0, Bo#battle_obj.arousal),

% 	RespData =  <<
% 					ChangeReason 			: 8,
% 					(Bo#battle_obj.bo_id)   : 32,
% 					(Bo#battle_obj.hp) 	  	: 32,
% 					(Bo#battle_obj.anger)   : 16,
% 					(Bo#battle_obj.arousal) : 16,
% 					(Bo#battle_obj.hp_lim) 	: 32,
%                     AddBoHpNum             :32,
%                     AddMyHpBoId            :32
% 				>>,
% 	{ok, pt:pack(?PT_BT_NOTIFY_BO_ATTR_CHANGED, RespData)};
	

% %% 通知战场上的所有玩家：某玩家已经准备好了
% write(?PT_BT_NOTIFY_SOMEONE_IS_READY, [PlayerId, CmdType, ExtraId]) ->
% 	RespData = <<PlayerId:32, CmdType:8, ExtraId:32>>,
% 	{ok, pt:pack(?PT_BT_NOTIFY_SOMEONE_IS_READY, RespData)};
	
	
% %% 中途加入战斗
% write(?PT_BT_JOIN_BATTLE_MIDWAY, RetCode) ->
% 	RespData = <<RetCode:8>>,
% 	{ok, pt:pack(?PT_BT_JOIN_BATTLE_MIDWAY, RespData)};


% %% 通知有人或怪中途加入战斗
% write(?PT_BT_NOTIFY_JOIN_BATTLE_MIDWAY, NewJoinBo) when is_record(NewJoinBo, battle_obj) ->
%    write(?PT_BT_NOTIFY_JOIN_BATTLE_MIDWAY, {NewJoinBo, 0});
% write(?PT_BT_NOTIFY_JOIN_BATTLE_MIDWAY, {NewJoinBo, Type}) ->
% 	Side = 	case NewJoinBo#battle_obj.side of
% 				l -> 0;
% 				r -> 1
% 			end,
%     [WQ, YF, Fashion] = NewJoinBo#battle_obj.battle_current_equip,
% 	Name = NewJoinBo#battle_obj.name,
% 	Data = <<
% 				(NewJoinBo#battle_obj.id) 		: 32,
% 				(NewJoinBo#battle_obj.sign) 		: 8,
% 				(NewJoinBo#battle_obj.bo_id) 	: 32,
% 				(Side) 								: 8,
% 				(NewJoinBo#battle_obj.res_id) 	: 32,
% 				(NewJoinBo#battle_obj.pos_x) 	: 8,
% 				(NewJoinBo#battle_obj.pos_y) 	: 8,
% 				(NewJoinBo#battle_obj.size_x) 	: 8,
% 				(NewJoinBo#battle_obj.size_y) 	: 8,
% 				(byte_size(Name)) 					: 16,
% 				(Name) 								/ binary,
% 				(NewJoinBo#battle_obj.lv) 		: 16,
% 				(NewJoinBo#battle_obj.anger) 	: 8,
% 				(NewJoinBo#battle_obj.hp) 		: 32,
% 				(NewJoinBo#battle_obj.hp_lim) 	: 32,
% 				(NewJoinBo#battle_obj.arousal) 	: 8,
%                 0:16, <<>>/binary,   % 表示武将装备技能，组队没有武将，故此用空数组表示
%                 0:8,   % 人物品质默认为0
%                 WQ:32, 
%                 YF:32, 
%                 Fashion:32,
%                 Type:8  %0、路途跑进来，1、Boss招出小怪
% 		   >>,
% 	{ok, pt:pack(?PT_BT_NOTIFY_JOIN_BATTLE_MIDWAY, Data)};
	
	
% %% 通知战场上所有玩家：某战斗对象增加了一个buff
% write(?PT_BT_NOTIFY_BO_ADD_BUFF, [Bo, NewBuff]) ->
% 	BuffType = NewBuff#bo_buff.type,
% 	EffName = NewBuff#bo_buff.eff_name,
% 	EffValue = NewBuff#bo_buff.eff_value,
% 	BuffId = lib_battle_buff:get_buff_id(EffName, BuffType),
	
% 	?ASSERT(NewBuff#bo_buff.skill_id /= 0, {EffName, EffValue, BuffId, Bo}),
	
% 	?DEBUG_MSG("PT_BT_NOTIFY_BO_ADD_BUFF, ~p, ~p, ~p~n", [EffName, EffValue, BuffId]),
% 	EffValue2 = case is_float(EffValue) of
% 					true -> util:ceil(util:absolute(EffValue * 100));
% 					false -> ?ASSERT(is_integer(EffValue), {EffName, EffValue, BuffId}), EffValue
% 				end,
% 	?DEBUG_MSG("PT_BT_NOTIFY_BO_ADD_BUFF, skill id : ~p, eff name: ~p, expire turn: ~p", [NewBuff#bo_buff.skill_id, EffName, NewBuff#bo_buff.expire_turn]),
% 	Data = 	<<	
% 				(Bo#battle_obj.bo_id) : 32,
% 				(BuffId) : 32,
% 				(EffValue2) : 16,
% 				(NewBuff#bo_buff.expire_turn) : 16,
% 				(NewBuff#bo_buff.skill_id) : 32
% 			>>,
% 	{ok, pt:pack(?PT_BT_NOTIFY_BO_ADD_BUFF, Data)};


% %% 通知战场上所有玩家：某战斗对象移除了一个buff
% write(?PT_BT_NOTIFY_BO_REMOVE_BUFF, [Bo, BuffToRemove, RmvReason, HelperId]) ->
% 	BuffType = BuffToRemove#bo_buff.type,
% 	EffName = BuffToRemove#bo_buff.eff_name,
% 	BuffId = lib_battle_buff:get_buff_id(EffName, BuffType),
% 	Data = 	<<	
% 				(Bo#battle_obj.bo_id) : 32,
% 				(BuffId) : 32,
% 				(BuffToRemove#bo_buff.skill_id) : 32,
% 				(RmvReason) : 8,
%                 (HelperId):32
% 			>>,
% 	{ok, pt:pack(?PT_BT_NOTIFY_BO_REMOVE_BUFF, Data)};	


% %% 针对使用非攻击类型（比如治疗，纯加buff或debuff，复活等）的技能时的通知战报
% write(?PT_BT_REPORT_USE_CAST_SKILL, [CasterId, SkillId, TargetBoIdList]) ->
	
% 	%%    caster               int32    施法者战斗对象id
% %%    skillId              int32    所使用的技能id
% %%    array(
% %%            targetBoId   int32    施法目标战斗对象id
% %%         )
	
% 	F = fun(BoId) -> 
% 			<<BoId:32>> 
% 		end,
% 	Bin = list_to_binary([F(X) || X <- TargetBoIdList]),
% 	Data = 	<<	
% 				(CasterId) : 32,
% 				(SkillId) : 32,
% 				(length(TargetBoIdList)) : 16,
% 				Bin / binary
% 			>>,
% 	{ok, pt:pack(?PT_BT_REPORT_USE_CAST_SKILL, Data)};	
	

% %% 查询挂机的技能组合	
% write(?PT_AM_QUERY_SKILL_COMB, [PS, CombId, SkillComb]) ->
% 	?TRACE("write PT_AM_QUERY_SKILL_COMB...~n"),
% 	F = fun({SkillId, Grid}) ->
% 			SkillLv = lib_skill:get_cur_lv(SkillId, PS),
% 			<<SkillId:32, SkillLv:8, Grid:8>>
% 		end,
% 	SkillData = list_to_binary([F(X) || X <- SkillComb]),
% 	SkillCount = length(SkillComb),
% 	RespData = <<CombId:8, SkillCount:16, SkillData/binary>>,
% 	{ok, pt:pack(?PT_AM_QUERY_SKILL_COMB, RespData)};
	
	
% %% 查询玩家的自动挂机设置信息
% write(?PT_AM_QUERY_MY_SET_INFO, [CurUseSklCombId, IsAutoBuyHpBag]) ->
% 	BinData = <<
% 				CurUseSklCombId : 8, 
% 				(util:bool_to_int(IsAutoBuyHpBag)) : 8
% 			  >>,
% 	{ok, pt:pack(?PT_AM_QUERY_MY_SET_INFO, BinData)};

% %% 设置挂机的技能组合	
% write(?PT_AM_SET_SKILL_COMB, [RetCode, CombId]) ->
% 	BinData = <<RetCode:8, CombId:8>>,
% 	{ok, pt:pack(?PT_AM_SET_SKILL_COMB, BinData)};
	

% %% 清空挂机的技能组合	
% %%write(?PT_AM_CLEAR_SKILL_COMB, [RetCode, CombId]) ->
% %%	BinData = <<RetCode:8, CombId:8>>,
% %%	{ok, pt:pack(?PT_AM_CLEAR_SKILL_COMB, BinData)};
	

% %% 选择挂机所使用的技能组合	
% %%write(?PT_AM_SELECT_SKILL_COMB, [RetCode, CombId]) ->
% %%	BinData = <<RetCode:8, CombId:8>>,
% %%	{ok, pt:pack(?PT_AM_SELECT_SKILL_COMB, BinData)};


% %% 设置挂机的怒气上限	
% %%write(?PT_AM_SET_ANGER_LIM, [RetCode, AngerLim]) ->
% %%	BinData = <<RetCode:8, AngerLim:8>>,
% %%	{ok, pt:pack(?PT_AM_SET_ANGER_LIM, BinData)};


% %% 尝试添加新的已学技能到技能组合中
% write(?PT_AM_TRY_ADD_NEW_SKILLS_TO_COMB, [PS, CombId, NewSkillIdList]) ->
% 	F = fun(SkillId) ->
% 			SkillLv = lib_skill:get_cur_lv(SkillId, PS),
% 			<<SkillId:32, SkillLv:8>>
% 		end,
% 	SkillData = list_to_binary([F(X) || X <- NewSkillIdList]),
% 	SkillCount = length(NewSkillIdList),
% 	RespData = <<CombId:8, SkillCount:16, SkillData/binary>>,
% 	{ok, pt:pack(?PT_AM_TRY_ADD_NEW_SKILLS_TO_COMB, RespData)};
	

% %% 通知客户端：当前回合已结束	
% write(?PT_BT_NOTIFY_CUR_TURN_FINISH, NewTurnIdx) ->
% 	RespData = <<NewTurnIdx:16>>,
% 	{ok, pt:pack(?PT_BT_NOTIFY_CUR_TURN_FINISH, RespData)};	
	

% %% @desc: 强制退出本场战斗
% write(?PT_AM_FORCE_EXIT_BATTLE, _) ->
%     {ok, pt:pack(?PT_AM_FORCE_EXIT_BATTLE, <<>>)};

% %% 设置是否自动购买气血包	
% write(?PT_AM_SET_AUTO_BUY_HP_BAG, [RetCode, Flag]) ->
% 	RespData = <<RetCode:8, Flag:8>>,
% 	{ok, pt:pack(?PT_AM_SET_AUTO_BUY_HP_BAG, RespData)};	



write(?PT_BT_START_PK, [RetCode, TargetPlayerId, PK_Type]) ->
	Bin = <<
			RetCode : 8,
			TargetPlayerId : 64,
			PK_Type : 8
		  >>,
	{ok, pt:pack(?PT_BT_START_PK, Bin)};

write(?PT_BT_NOTIFI_ANGER_CHANGE_INFO, [List]) ->
	BinLen = length(List),
	Bin = list_to_binary([<<Boid:16,Value:32>> || {Boid,Value,_} <- List ]),
	{ok, pt:pack(?PT_BT_NOTIFI_ANGER_CHANGE_INFO, <<BinLen:16, Bin/binary>>)};




write(?PT_BT_ASK_IF_ACCPET_PK, [FromPS, PK_Type]) ->
	FromPlayerId = player:id(FromPS),
	FromPlayerName = player:get_name(FromPS),
	{IsInTeam, PlayerCount} = case player:is_in_team(FromPS) of
								  true ->
								  	  _TeamId = player:get_team_id(FromPS),
								  	  _TeamMbCount = mod_team:get_normal_member_count(_TeamId),
								  	  {true, max(_TeamMbCount, 1)};
								  false ->
								  	  {false, 1}
							  end,
	Bin = <<
			 FromPlayerId : 64,
			 (byte_size(FromPlayerName)) : 16,
			 FromPlayerName / binary,
			 PK_Type : 8,
			 (util:bool_to_oz(IsInTeam)) : 8,
			 PlayerCount : 8
		  >>,
	{ok, pt:pack(?PT_BT_ASK_IF_ACCPET_PK, Bin)};


write(?PT_BT_NOTIFY_PK_INVITE_REFUSED, [TargetPS, PK_Type]) ->
	TargetPlayerId = player:id(TargetPS),
	TargetPlayerName = player:get_name(TargetPS),
	Bin = <<
			 TargetPlayerId : 64,
			 (byte_size(TargetPlayerName)) : 16,
			 TargetPlayerName / binary,
			 PK_Type : 8
		  >>,
	{ok, pt:pack(?PT_BT_NOTIFY_PK_INVITE_REFUSED, Bin)};


write(?PT_BT_NOTIFY_BATTLE_START, _) ->
	{ok, pt:pack(?PT_BT_NOTIFY_BATTLE_START, <<>>)};

write(?PT_TELL_BT_TYPE, _) ->
	{ok, pt:pack(?PT_TELL_BT_TYPE, <<>>)};

write(?PT_BT_WORLD_BOSS_ESCAPE, _) ->
	{ok, pt:pack(?PT_BT_WORLD_BOSS_ESCAPE, <<>>)};


write(?PT_BT_TEST_BATTLE_INFO, [BattleType,SkillNo,SkillSca,SkillInitDam,
	PhyCoef,DoubleCoef,TotalPhyDam,PurseCoef,TotalDam ,TotalHealCoef,HealValue,HitCoef ,Hitrate]) ->
	{ok, pt:pack(?PT_BT_TEST_BATTLE_INFO, <<BattleType:8,SkillNo:32,SkillSca:32,SkillInitDam:32,PhyCoef:32,DoubleCoef:32,TotalPhyDam:32,PurseCoef:32,TotalDam :32,TotalHealCoef:32,HealValue:32,HitCoef :32,Hitrate:32>>)};




write(?PT_BT_NOTIFY_BATTLE_FINISH, WinSide) ->
	{ok, pt:pack(?PT_BT_NOTIFY_BATTLE_FINISH, <<WinSide:8>>)};


write(?PT_BT_QRY_BATTLE_FIELD_DESC, Desc_Bin) ->
	?ASSERT(is_binary(Desc_Bin)),
	{ok, pt:pack(?PT_BT_QRY_BATTLE_FIELD_DESC, Desc_Bin)};


write(?PT_BT_QRY_BO_BUFF_INFO, Bin) ->
	?ASSERT(is_binary(Bin)),
	{ok, pt:pack(?PT_BT_QRY_BO_BUFF_INFO, Bin)};


write(?PT_BT_NOTIFY_BO_IS_READY, Bo) ->
	Bin = <<
			(lib_bo:get_id(Bo)) : 16,
			(lib_bo:get_cmd_type(Bo)) : 8,
			(lib_bo:get_cmd_para(Bo)) : 64
		>>,
	{ok, pt:pack(?PT_BT_NOTIFY_BO_IS_READY, Bin)};



write(?PT_BT_S2C_NOTIFY_BO_SHOW_BR_DONE, BoId) ->
	Bin = <<BoId : 16>>,
	{ok, pt:pack(?PT_BT_S2C_NOTIFY_BO_SHOW_BR_DONE, Bin)};


write(?PT_BT_NOTIFY_BO_ONLINE_FLAG_CHANGED, [BoId, NewOnlineInfo]) ->
	OnlineFlag = case NewOnlineInfo of
					online -> 1;
					offline -> 2
				end,
	Bin = <<BoId:16, OnlineFlag:8>>,
	{ok, pt:pack(?PT_BT_NOTIFY_BO_ONLINE_FLAG_CHANGED, Bin)};


write(?PT_BT_NOTIFY_ROUND_ACTION_BEGIN, _) ->
	{ok, pt:pack(?PT_BT_NOTIFY_ROUND_ACTION_BEGIN, <<>>)};


write(?PT_BT_NOTIFY_ROUND_ACTION_END, _) ->
	{ok, pt:pack(?PT_BT_NOTIFY_ROUND_ACTION_END, <<>>)};


write(?PT_BT_NOTIFY_NEW_ROUND_BEGIN, NewRoundIndex) ->
	{ok, pt:pack(?PT_BT_NOTIFY_NEW_ROUND_BEGIN, <<NewRoundIndex:16>>)};


write(?PT_BT_NOTIFY_SETTLE_BUFF_BEGIN, _) ->
	{ok, pt:pack(?PT_BT_NOTIFY_SETTLE_BUFF_BEGIN, <<>>)};

write(?PT_BT_NOTIFY_SETTLE_BUFF_END, _) ->
	{ok, pt:pack(?PT_BT_NOTIFY_SETTLE_BUFF_END, <<>>)};

write(?PT_BT_NOTIFY_ON_NEW_ROUND_BEGIN_JOBS_DONE, _) ->
	{ok, pt:pack(?PT_BT_NOTIFY_ON_NEW_ROUND_BEGIN_JOBS_DONE, <<>>)};

write(?PT_BT_NOTIFY_BR_DO_PHY_ATT, BtlReport_Bin) ->
	{ok, pt:pack(?PT_BT_NOTIFY_BR_DO_PHY_ATT, <<BtlReport_Bin/binary>>)};


write(?PT_BT_NOTIFY_BR_DO_MAG_ATT, BtlReport_Bin) ->
	{ok, pt:pack(?PT_BT_NOTIFY_BR_DO_MAG_ATT, <<BtlReport_Bin/binary>>)};


write(?PT_BT_NOTIFY_BR_CAST_BUFFS, BtlReport_Bin) ->
	{ok, pt:pack(?PT_BT_NOTIFY_BR_CAST_BUFFS, <<BtlReport_Bin/binary>>)};


write(?PT_BT_NOTIFY_BR_ESCAPE, BtlReport_Bin) ->
	{ok, pt:pack(?PT_BT_NOTIFY_BR_ESCAPE, <<BtlReport_Bin/binary>>)};


write(?PT_BT_NOTIFY_BR_HEAL, BtlReport_Bin) ->
	{ok, pt:pack(?PT_BT_NOTIFY_BR_HEAL, <<BtlReport_Bin/binary>>)};

% 作废！！	
% write(?PT_BT_NOTIFY_BR_FORCE_DIE, BtlReport_Bin) ->
% 	{ok, pt:pack(?PT_BT_NOTIFY_BR_FORCE_DIE, <<BtlReport_Bin/binary>>)};


write(?PT_BT_NOTIFY_BR_USE_GOODS, BtlReport_Bin) ->
	{ok, pt:pack(?PT_BT_NOTIFY_BR_USE_GOODS, <<BtlReport_Bin/binary>>)};


write(?PT_BT_NOTIFY_BR_SUMMON, BtlReport_Bin) ->
	{ok, pt:pack(?PT_BT_NOTIFY_BR_SUMMON, <<BtlReport_Bin/binary>>)};


write(?PT_BT_NOP_CMD, [RetCode, ForBoId]) ->
	Bin = <<RetCode:8, ForBoId:16>>,
	{ok, pt:pack(?PT_BT_NOP_CMD, Bin)};


write(?PT_BT_USE_SKILL, [RetCode, ForBoId, SkillId, TargetBoId]) ->
	Bin = <<RetCode:8, ForBoId:16, SkillId:32, TargetBoId:16>>,
	{ok, pt:pack(?PT_BT_USE_SKILL, Bin)};


write(?PT_BT_CMD_CAPTURE_PARTNER, [RetCode, ForBoId, TargetBoId]) ->
	Bin = <<RetCode:8, ForBoId:16, TargetBoId:16>>,
	{ok, pt:pack(?PT_BT_CMD_CAPTURE_PARTNER, Bin)};


write(?PT_BT_USE_GOODS, [RetCode, ForBoId, GoodsId, TargetBoId]) ->
	Bin = <<RetCode:8, ForBoId:16, GoodsId:64, TargetBoId:16>>,
	{ok, pt:pack(?PT_BT_USE_GOODS, Bin)};



write(?PT_BT_PROTECT_OTHERS, [RetCode, ForBoId, TargetBoId]) ->
	Bin = <<RetCode:8, ForBoId:16, TargetBoId:16>>,
	{ok, pt:pack(?PT_BT_PROTECT_OTHERS, Bin)};



write(?PT_BT_ESCAPE, [RetCode, ForBoId]) ->
	Bin = <<RetCode:8, ForBoId:16>>,
	{ok, pt:pack(?PT_BT_ESCAPE, Bin)};


write(?PT_BT_DEFEND, [RetCode, ForBoId]) ->
	Bin = <<RetCode:8, ForBoId:16>>,
	{ok, pt:pack(?PT_BT_DEFEND, Bin)};

write(?PT_BT_SUMMON_PARTNER, [RetCode, ForBoId, PartnerId]) ->
	Bin = <<RetCode:8, ForBoId:16, PartnerId:64>>,
	{ok, pt:pack(?PT_BT_SUMMON_PARTNER, Bin)};


write(?PT_BT_REQ_PREPARE_CMD_BY_AI, [RetCode, ForBoId]) ->
	Bin = <<RetCode:8, ForBoId:16>>,
	{ok, pt:pack(?PT_BT_REQ_PREPARE_CMD_BY_AI, Bin)};


write(?PT_BT_REQ_AUTO_BATTLE, [RetCode]) ->
	Bin = <<RetCode:8>>,
	{ok, pt:pack(?PT_BT_REQ_AUTO_BATTLE, Bin)};


write(?PT_BT_CANCEL_AUTO_BATTLE, [RetCode]) ->
	Bin = <<RetCode:8>>,
	{ok, pt:pack(?PT_BT_CANCEL_AUTO_BATTLE, Bin)};


write(?PT_BT_NOTIFY_BO_BUFF_CHANGED, [ChangeType, BoId, BuffDetails]) ->
	ChangeCode = case ChangeType of
				buff_added -> 1;
				buff_removed -> 2;
				buff_updated -> 3
			end,
	Bin = <<BoId:16, ChangeCode:8, BuffDetails/binary>>,
	{ok, pt:pack(?PT_BT_NOTIFY_BO_BUFF_CHANGED, Bin)};



write(?PT_BT_NOTIFY_BO_ATTR_CHANGED, [Bo_Latest, ChangedAttrInfoList]) ->
	F_ToAttrCode = 	fun(Attr) ->
						case Attr of
							?ATTR_HP -> 1;
							?ATTR_MP -> 2;
							?ATTR_ANGER -> 3;
							?ATTR_PHY_ATT -> 4;
							?ATTR_MAG_ATT -> 5;
							?ATTR_PHY_DEF -> 6;
							?ATTR_MAG_DEF -> 7
						end
					end,

	F = fun({Attr, ChangeVal}) ->
			AttrCode = F_ToAttrCode(Attr),
			case Attr of
				?ATTR_HP -> <<AttrCode:8, ChangeVal:32/signed-integer, (lib_bo:get_hp(Bo_Latest)):32>>;
				?ATTR_MP -> <<AttrCode:8, ChangeVal:32/signed-integer, (lib_bo:get_mp(Bo_Latest)):32>>;
				?ATTR_ANGER -> <<AttrCode:8, ChangeVal:32/signed-integer, (lib_bo:get_anger(Bo_Latest)):32>>;
				?ATTR_PHY_ATT -> <<AttrCode:8, ChangeVal:32/signed-integer, (lib_bo:get_phy_att(Bo_Latest)):32>>;
				?ATTR_MAG_ATT -> <<AttrCode:8, ChangeVal:32/signed-integer, (lib_bo:get_mag_att(Bo_Latest)):32>>;
				?ATTR_PHY_DEF -> <<AttrCode:8, ChangeVal:32/signed-integer, (lib_bo:get_phy_def(Bo_Latest)):32>>;
				?ATTR_MAG_DEF -> <<AttrCode:8, ChangeVal:32/signed-integer, (lib_bo:get_mag_def(Bo_Latest)):32>>
			end
		end,

	L = [F(X) || X <- ChangedAttrInfoList],

	Bin = <<
			(lib_bo:id(Bo_Latest)) : 16,
			(lib_bo:get_die_status(Bo_Latest)) : 8,
			(length(L)) : 16,
			(list_to_binary(L)) / binary
		>>,
	?TRACE("PT_BT_NOTIFY_BO_ATTR_CHANGED, BoId=~p, L=~w~n", [lib_bo:id(Bo_Latest), L]),
	{ok, pt:pack(?PT_BT_NOTIFY_BO_ATTR_CHANGED, Bin)};


write(?PT_BT_CAPTURE_PARTNER, [BoId, TargetBoId, Result]) ->
	Bin = << BoId:16,TargetBoId:16,Result,8 >>,
	{ok, pt:pack(?PT_BT_CAPTURE_PARTNER, Bin)};


write(?PT_BT_NOTIFY_BO_DIED, [BoId, DieDetails]) ->
	L = [<<BuffNo:32>> || BuffNo <- DieDetails#die_details.buffs_removed],
	BuffsRemoved_Bin = list_to_binary(L),
	Bin = <<
			1 : 16,      % 单人死亡，固定为1
			BoId : 16,
			(DieDetails#die_details.die_status) : 8,
			(length(L)) : 16,
			BuffsRemoved_Bin / binary
		  >>,
	{ok, pt:pack(?PT_BT_NOTIFY_BO_DIED, Bin)};

write(?PT_BT_NOTIFY_BO_DIED, Bin) when is_binary(Bin) ->
	{ok, pt:pack(?PT_BT_NOTIFY_BO_DIED, Bin)};


write(?PT_BT_NOTIFY_BO_REVIVE, Bo) ->
	Bin = <<
			(lib_bo:get_id(Bo)) : 16,
			(lib_bo:get_hp(Bo)) : 32
		  >>,
	{ok, pt:pack(?PT_BT_NOTIFY_BO_REVIVE, Bin)};


write(?PT_BT_TIPS, Bin) ->
	{ok, pt:pack(?PT_BT_TIPS, Bin)};



write(?PT_BT_QUERY_SKILL_USABLE_INFO, [TargetBoId, UsableInfo_Bin]) ->
	Bin = <<TargetBoId:16, UsableInfo_Bin/binary>>,
	{ok, pt:pack(?PT_BT_QUERY_SKILL_USABLE_INFO, Bin)};



write(?PT_BT_QUERY_BO_INFO_AFTER_BACK_TO_BATTLE, TargetBoInfo_Bin) ->
	Bin = <<TargetBoInfo_Bin/binary>>,
	{ok, pt:pack(?PT_BT_QUERY_BO_INFO_AFTER_BACK_TO_BATTLE, Bin)};


write(?PT_BT_TRY_GO_BACK_TO_BATTLE, RetCode) ->
	Bin = <<RetCode:8>>,
	{ok, pt:pack(?PT_BT_TRY_GO_BACK_TO_BATTLE, Bin)};


write(?PT_BT_NOTIFY_NOT_NEED_BACK_TO_BATTLE, _) ->
	Bin = <<>>,
	{ok, pt:pack(?PT_BT_NOTIFY_NOT_NEED_BACK_TO_BATTLE, Bin)};


write(?PT_BT_NOTIFY_TALK_AI_INFO, InfoBin) ->
	Bin = <<InfoBin/binary>>,
	{ok, pt:pack(?PT_BT_NOTIFY_TALK_AI_INFO, Bin)};

write(?PT_BT_NOTIFY_NEXT_BMON_GROUP_SPAWNED, MonBoInfoList_Bin) ->
	{ok, pt:pack(?PT_BT_NOTIFY_NEXT_BMON_GROUP_SPAWNED, MonBoInfoList_Bin)};

write(?PT_BT_NOTIFY_NEW_BO_SPAWNED, NewBoInfo_Bin) ->
	{ok, pt:pack(?PT_BT_NOTIFY_NEW_BO_SPAWNED, NewBoInfo_Bin)};

write(?PT_BT_QUERY_BATTLE_START_TIME, [RetCode, StartTime]) ->
	Bin = <<RetCode:8, StartTime:32>>,
	{ok, pt:pack(?PT_BT_QUERY_BATTLE_START_TIME, Bin)};

write(?PT_BT_CAPTAIN_PROJECT, [BoId, Cmd]) ->
	Bin = <<BoId:16, Cmd:16>>,
	{ok, pt:pack(?PT_BT_CAPTAIN_PROJECT, Bin)};

write(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.
    
    
% %% ==================================================================================
    

% def_list([]) ->
%     <<0:16, <<>>/binary>>;
% def_list(DefList) ->
%     Rlen = length(DefList),
%     F = fun([Sign, Id, Hp, Mp, Hurt, S]) ->
%         <<Sign:8, Id:32, Hp:32, Mp:32, Hurt:32, S:8>>
%     end,
%     RB = list_to_binary([F(D) || D <- DefList]),
%     <<Rlen:16, RB/binary>>.

% assist_list([]) ->
%     <<0:16, <<>>/binary>>;
% assist_list(List) ->
%     Rlen = length(List),
%     F = fun([Id, Hp]) ->
%         <<Id:32, Hp:32>>
%     end,
%     RB = list_to_binary([F(D) || D <- List]),
%     <<Rlen:16, RB/binary>>.

% pack_obj_list([]) ->
% 	<<0:16, <<>>/binary>>;
% pack_obj_list(List) ->
% 	?ASSERT(is_list(List), List),
% 	Len = length(List),
% 	F = fun({BoType,Id,Name,Level,Anger,Arousal,Hp,Hp_lim,ResId,X,Y,Width,Height, ParEqSkills, Quality, CurrentCloth}) ->
% 				?ASSERT(is_integer(Anger), Anger),
% 				?ASSERT(is_integer(Hp), {Hp, Id, Level}),
% 				?ASSERT(is_integer(Hp_lim), Hp_lim),
% 				Len1 = byte_size(Name),
%                 F1 = fun(SklBrief) -> <<(SklBrief#skl_brief.id):32>> end,
%                 BinEqSkill = list_to_binary( lists:map(F1, ParEqSkills) ), % ParEqSkills: 武将的已装备技能列表，如果不是武将，则为空
%                 Len2 = length(ParEqSkills),
%                 [WQ, YF, Fashion] = CurrentCloth,
% 				<<BoType:8,Id:32,Len1:16,Name/binary,Level:16,Hp:32,Hp_lim:32,ResId:32,X:8,Y:8,Width:8,Height:8, Anger:8, Arousal:8, Len2:16, BinEqSkill/binary, Quality:8, WQ:32, YF:32, Fashion:32>>
% 		end,
% 	Bin = list_to_binary([F(D) || D <- List]),
% 	<<Len:16, Bin/binary>>.

% %%战斗信息通信（战报数据）
% pack_battle_report_list([])->
%    	<<0:16, <<>>/binary>>;
% pack_battle_report_list(TurnList)->
	
%   	Rlen = length(TurnList),
% 	F = fun(Turn) ->
% 				pack_battle_report_list1(Turn)
% 	end,
% 	RB = list_to_binary(lists:reverse([F(D) || D <- TurnList])), % 这里要反一下序，见战斗模块头部的说明
% 	<<Rlen:16,RB/binary>>.

% pack_battle_report_list1([])->
%    	<<0:16, <<>>/binary>>;
% pack_battle_report_list1(Turn)->
%   	Rlen = length(Turn),
% 	F = fun({Type,AtterIdList,SkillId,SegList, _Round, _Num}) ->
% 				?DEBUG_MSG("type: ~p, AtterIdList: ~p, SkillId: ~p~n", [Type, AtterIdList, SkillId]),
% 				AtterIds = pack_atter_id_list(AtterIdList),
% 				SegData = pack_skillsegment_list(SegList),
% 				<<Type:8,AtterIds/binary,SkillId:32, SegData/binary>>
% 		end,
% 	RB = list_to_binary([F(D) || D <- Turn]),
% 	<<Rlen:16,RB/binary>>.


% pack_atter_id_list(AtterIdList) ->
% 	F = fun(AtterId) ->
% 			<<AtterId:32>>
% 		end,
% 	IdCount = length(AtterIdList),
% 	Bin = list_to_binary([F(X) || X <- AtterIdList]),
% 	<<IdCount:16, Bin/binary>>.


% pack_skillsegment_list([])->
%    	<<0:16, <<>>/binary>>;
% pack_skillsegment_list(SegList) ->
% 	Rlen = length(SegList),
% 	F = fun({HitGridList, DeferList}) ->
% 			Len = length(HitGridList),
% 			F2 = fun({X, Y}) ->
%         			<<X:8, Y:8>> 
%     			end,
%     		Bin = list_to_binary([F2(D) || D <- HitGridList]),
% 			Defer = pack_battleinfo_list2(DeferList),
% 			<<Len:16,Bin/binary,Defer/binary>>
% 		end,
% 	RB = list_to_binary(lists:reverse([F(D) || D <- SegList])), % 这里要反一下序，见战斗模块头部的说明
% 	<<Rlen:16,RB/binary>>.

% pack_battleinfo_list2([])->
%    	<<0:16, <<>>/binary>>;
% pack_battleinfo_list2(DeferList)->
%   	Rlen = length(DeferList),
% 	F = fun({MonOrPlayer,DeferId,DamageAndState}) ->
% 				DAS = pack_battleinfo_list3(DamageAndState),
% 				<<MonOrPlayer:8,DeferId:32,DAS/binary>>
% 	end,
% 	RB = list_to_binary(lists:reverse([F(D) || D <- DeferList])), % 这里要反一下序，见战斗模块头部的说明
% 	<<Rlen:16,RB/binary>>.

% pack_battleinfo_list3([])->
%    	<<0:16, <<>>/binary>>;
% pack_battleinfo_list3(DemageAndState)->
%   	Rlen = length(DemageAndState),
% 	F = fun({Anger,Arousal,Combo,Damage,DefNewHp, State, DefAnger, DefArousal}) ->
% 				% TODO: 这里做一些断言，以后确认无bug后可以删掉
% 				?ASSERT(is_integer(Anger), Anger),
% 				?ASSERT(Anger >= 0, Anger),
% 				?ASSERT(is_integer(Arousal), Arousal),
% 				?ASSERT(Arousal >= 0, Arousal),
% 				?ASSERT(is_integer(Damage), Damage),
% 				?ASSERT(Damage >= 0, Damage),
% 				?ASSERT(is_integer(DefNewHp), DefNewHp),
% 				?ASSERT(DefNewHp >= 0, DefNewHp),
% 				?ASSERT(is_integer(DefAnger), DefAnger),
% 				?ASSERT(DefAnger >= 0, DefAnger),
% 				?ASSERT(is_integer(DefArousal), DefArousal),
% 				?ASSERT(DefArousal >= 0, DefArousal),
				
% 				%%AChangeSkill_data = <<0:16>>,  %%pack_skill_list(AChangeSkill),
% 				%%DChangeSkill_data = <<0:16>>,  %%pack_skill_list(DChangeSkill),
%                 SafeDmg = util:ceil(Damage),
% 				<<Anger:16,Arousal:8,Combo:16,SafeDmg:32,DefNewHp:32,State:8, DefAnger:16, DefArousal:8>>
% 	end,
% 	RB = list_to_binary(lists:reverse([F(D) || D <- DemageAndState])), % 这里要反一下序，见战斗模块头部的说明
% 	<<Rlen:16,RB/binary>>.
