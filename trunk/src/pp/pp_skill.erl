%%%-------------------------------------- 
%%% @Module: pp_skill
%%% @Author: 黄鸣杨
%%% @Created: 2012-5-13
%%% @Description: 技能系统
%%%-------------------------------------- 
-module(pp_skill).
% -export([handle/3, test/3]).
% -include("common.hrl"). 
% -include("record.hrl").
% -include("skill.hrl").
% -include("player.hrl").
% -include("skill.hrl").
  
% %% 获取玩家已学的技能列表,Skill_list:[{sid, slv, type, equip},...]
% handle(21001,Status,[]) ->
%     case lib_skill:get_skill(Status) of
%         {false, _ErrCode} ->
%             ?TRACE("21001_error_id:~p, ErrCode:~p~n", [Status#player_status.id, _ErrCode]),
%             skip;
%         {true, SkillPoint, SkillList} ->
%             {ok,Bdata} = pt_21:write(21001, [SkillPoint,SkillList]),
%             ?TRACE("21001_len:~p:BinData=~p~n", [length(SkillList), Bdata]),
%             lib_send:send_one(Status#player_status.socket,Bdata)
%     end,
%     ok;

% %% 技能学习及升级
% handle(21002,Status,[SkillId]) ->
%     case lib_skill:upgrade_skill(Status, SkillId) of
%         {false, ErrCode} ->
%             {ok,Bdata} = pt_21:write(21002, [ErrCode]),
%             ?TRACE("21002_0:BinData=~p~n", [Bdata]),
%             lib_send:send_one(Status#player_status.socket,Bdata),
%             ok;
%         {true, NewStatus} ->
%             {ok,Bdata} = pt_21:write(21002, [1]),
%             ?TRACE("21002_1:BinData=~p~n", [Bdata]),
%             lib_send:send_one(Status#player_status.socket,Bdata),
%             {ok, skill, NewStatus}
%     end;

% %% 装备/卸载技能
% %% Equip表示技能格子编号
% handle(21003, Status, [Id, SkillId, Equip]) ->
% 	if
% 		Id == 0 ->
%     		case lib_skill:equip_skill(Status, SkillId, Equip) of
%         		{false, ErrCode} ->
%             		{ok,Bdata} = pt_21:write(21003, [ErrCode,0,0,0]),
%             		?TRACE("21003_0:BinData=~p~n", [Bdata]),
%             		lib_send:send_one(Status#player_status.socket,Bdata),
%             		ok;
%         		{true, NewStatus} ->
%             		{ok,Bdata} = pt_21:write(21003, [1, 0, SkillId, Equip]),
%             		?TRACE("21003_1:BinData=~p~n", [Bdata]),
%             		lib_send:send_one(Status#player_status.socket,Bdata),
%             		{ok, skill, NewStatus}
%     		end;
% 		true ->
% 			Flag = lib_skill:equip_partner_skill(Id, SkillId, Equip),
% 			{ok,Bdata} = pt_21:write(21003, [Flag, 0, SkillId, Equip]),
%             ?TRACE("21003_partner:Flag=~p~n", [Flag]),
%             lib_send:send_one(Status#player_status.socket,Bdata)
% 	end;
				

% %% 交换技能 
% %% Equip表示技能格子编号
% %% handle(21004, Status, [_Id, Cell1, Cell2]) when (_Id > 0 andalso (Cell1 == ?EQ_STUN_CELL orelse Cell2 == ?EQ_STUN_CELL)) orelse Cell1 =< 0 orelse Cell1 > ?EQ_SKILL_MAX_CELL orelse Cell2 =< 0 orelse Cell2 > ?EQ_SKILL_MAX_CELL ->
% %%     {ok,Bdata} = pt_21:write(21004, [2]),
% %%     ?TRACE("21004:BinData=~p~n", [Bdata]),
% %%     lib_send:send_one(Status#player_status.socket,Bdata),
% %%     ok;
% %% 交换技能 
% %% Equip表示技能格子编号
% handle(21004, _Status, [_Id, Cell1, Cell2]) when Cell1 =:= Cell2 ->
%     ok;
% handle(21004, Status, [Id, Cell1, Cell2]) ->
% 	if
% 		Id == 0 ->
% 			case lib_skill:chg_cell(Status, Cell1, Cell2) of
%         		{false, ErrCode} ->
%             		{ok,Bdata} = pt_21:write(21004, [ErrCode]),
%             		?TRACE("21004_0:BinData=~p~n", [Bdata]),
%             		lib_send:send_one(Status#player_status.socket,Bdata),
%             		ok;
%         		{true, NewStatus} ->
%             		{ok,Bdata} = pt_21:write(21004, [1]),
%             		?TRACE("21004_1:BinData=~p~n", [Bdata]),
%             		lib_send:send_one(Status#player_status.socket,Bdata),
%             		{ok, skill, NewStatus}
%     		end;
% 		true ->
% 			Flag = lib_skill:change_partner_skill(Id, Cell1, Cell2),
% 			{ok,Bdata} = pt_21:write(21004, [Flag]),
%             ?TRACE("21004_0 partner :Flag=~p~n", [Flag]),
%             lib_send:send_one(Status#player_status.socket, Bdata)
% 	end;

% %% 阵法学习/升级
% handle(21005,PlayerStatus,[TroopId]) ->
% 	[Result,Msg] = mod_troop:upgrade_troop(TroopId,PlayerStatus),
% 	{ok,Bdata} = case Result of
% 		ok ->
% 			pt_21:write(21005,[1,<<>>]);
% 		error ->
% 			Msg1 = atom_to_list(Msg),
% 			pt_21:write(21005,[0, tool:to_binary(Msg1)])
%     end,
%     ?TRACE("21005_1:BinData=~p~n", [Bdata]),
% 	lib_send:send_one(PlayerStatus#player_status.socket,Bdata);

% %% 获取已装备技能信息 
% handle(21008, Status, []) ->
%     {true, Eqskill} = lib_skill:get_eq_skill_list(Status),
%     {ok,Bdata} = pt_21:write(21008, [Eqskill]),
% %%     io:format("21008_1:BinData=~p~n", [Bdata]),
%     lib_send:send_one(Status#player_status.socket,Bdata);

% %% 洗点
% %% Equip表示技能格子编号
% handle(21009, Status, [Type]) ->
%     case lib_skill:clear_skill(Status, Type) of
%         {false, ErrCode} ->
%             {ok,Bdata} = pt_21:write(21009, [ErrCode, 0]),
%             ?TRACE("21009_0:BinData=~p~n", [Bdata]),
%             lib_send:send_one(Status#player_status.socket,Bdata),
%             ok;
%         {true, NewStatus} ->
%             {ok,Bdata} = pt_21:write(21009, [1, NewStatus#player_status.soul_power]),
%             ?TRACE("21009_1:BinData=~p~n", [Bdata]),
%             lib_send:send_one(Status#player_status.socket,Bdata),
% %%             lib_player:refresh_client(Status#player_status.id, ?REFRESH_BAG),
%             {ok, skill, NewStatus}
%     end;

% %%技能可升级通知
% handle(21010, Status, []) ->
% 	lib_skill:is_skill_point_leave(Status),
% 	ok;

% %%==========================================武将技能=============================================

% %%学习武将技能
% handle(21100, Status, [BookId, PartnerId]) ->
% 	?TRACE("21100\n"),
% %% 	Flag = case gen_server:call(?GET_GOODS_PID(Status), {'delete_one', BookId, 1}) of
% %% 		[GoodsModuleCode, 0] ->
% %% 			?DEBUG_MSG("learn_partner_skill:Call goods module faild, result code=[~p]", [GoodsModuleCode]),
% %% 			2;
% %% 		_ ->
% %% 			lib_skill:learn_partner_skill_by_book(Status, BookId, PartnerId)
% %% 	end,
	
% 	Flag = lib_skill:learn_partner_skill_by_book(Status, BookId, PartnerId),
% 	case Flag of
% 		1 ->
% 			goods_util:throw_goods(Status, BookId, 1),
% 			lib_player:refresh_client(Status#player_status.id, ?REFRESH_BAG);
% 		_ ->
% 			skip
% 	end,
% 	?TRACE("21100 Flag=~p~n", [Flag]),
% 	{ok, BinData} = pt_21:write(21100, [Flag]),
% 	lib_send:send_one(Status#player_status.socket, BinData);

% %%获取武将所学技能列表
% handle(21102, Status, [PartnerId]) ->
% 	?TRACE("21102 PartnerId=~p~n", [PartnerId]),
% 	Partner = lib_partner:get_partner(PartnerId),
% 	CastSeq = Partner#ets_partner.cast_seq,
% 	SkillList = Partner#ets_partner.skills,
% 	EqSkillList = Partner#ets_partner.eq_skills,
% 	{ok, BinData} = pt_21:write(21102, [CastSeq, SkillList, EqSkillList]),
% 	lib_send:send_one(Status#player_status.socket, BinData);

% %%更改技能选择方式
% handle(21103, Status, [PartnerId, Seq]) ->
% 	?TRACE("21103 Seq=~p~n", [Seq]),
% 	Flag = lib_skill:change_skillcast_seq(PartnerId, Seq),
% 	{ok, BinData} = pt_21:write(21103, [Flag]),
% 	lib_send:send_one(Status#player_status.socket, BinData);

% %%熟练度提升
% handle(21104, Status, [PartnerId, SkillId, Type]) ->
% 	?TRACE("21104 SkillId=~p Type=~p~n", [SkillId, Type]),
% 	{Flag, NewStatus} = lib_skill:add_partner_profi_by_gold(Status, PartnerId, SkillId, Type),
% 	?TRACE("21104 Flag=~p~n", [Flag]),
% 	{ok, BinData} = pt_21:write(21104, [Flag]),
% 	lib_send:send_one(Status#player_status.socket, BinData),
% 	{ok, skill, NewStatus};

% %%取得能习得该技能的武将列表
% handle(21105, Status, [BookId]) ->
% 	?TRACE("21105  BookId=~p~n", [BookId]),
% 	SkillBookRd = data_book:get(BookId),
% 	SkillId = lib_skill:get_skill_by_book(BookId),
% 	PartnerList = lib_skill:get_learn_book_partner(Status, BookId),
% 	Spid = SkillBookRd#rd_skill_book.spec_partner,
% 	Name = case Spid of
% 			   0 -> <<>>;
% 			   _ -> Partner = data_partner:get(Spid),
% 					Partner#par_born_data.name
% 		   end,
% 	{ok, BinData} = pt_21:write(21105, [SkillId, PartnerList, SkillBookRd#rd_skill_book.career_limit,
% 										Name, SkillBookRd#rd_skill_book.color]),
% 	lib_send:send_one(Status#player_status.socket, BinData);

% %% 上面均不符合的话
% handle(_,_,_) ->
% 	{error,"pp_skill can't match this action"}.

% %%%%%%%%%%%%%%%%%%%%%%%%
% test(Id, Cmd, Arg) ->
% 	Pid = lib_player:get_online_pid(Id),
% 	case is_pid(Pid) of
% 		true ->
% 			Status = gen_server:call(Pid, 'PLAYER'),
% 			case Cmd of
% 				21102 ->
% 					handle(21102, Status, Arg);
% 				21103 ->
% 					handle(21103, Status, Arg);
% 				21104 ->
% 					handle(21104, Status, Arg);
% 				21105 ->
% 					handle(21105, Status, Arg);
% 				21003 ->
% 					handle(21003, Status, Arg);
% 				21004 ->
% 					handle(21004, Status, Arg);
% 				_ ->
% 					?TRACE("error Cmd !! \n")
% 			end;
% 		_ ->
% 			?TRACE("error ~p is not online !! ~n", [Pid])
% 	end.
