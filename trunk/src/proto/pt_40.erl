%%%-------------------------------------- 
%%% @Module: pt_40
%%% @Author: zhangwq
%%% @Created: 2013-09-25
%%% @Description: 帮会解包、组包协议
%%%-------------------------------------- 
-module(pt_40).

%%
%% Include Files
%%

-include("protocol/pt_40.hrl").
-include("debug.hrl").
-include("record/guild_record.hrl").
-include("guild.hrl").
-include("common.hrl").
-include("offline_data.hrl").
-include("num_limits.hrl").

%%
%% External Exports
%%

-export([read/2, write/2]).

%% ------------------------------------------------------------
%% Client >> Server
%% ------------------------------------------------------------

%% 创建帮会
read(?PT_CREATE_GUILD, <<BinData/binary>>) ->
	{GuildName, BinData2} = pt:read_string(BinData),
	{Brief, _} = pt:read_string(BinData2),
	{ok, [GuildName, Brief]};


%% 申请解散帮会
read(?PT_DISBAND_GUILD, <<GuildId:64>>) ->
	{ok, [GuildId]};

% %% 取消帮会解散申请
% read(40003, <<GuildId:64>>) ->
% 	{ok, GuildId};


%% 申请加入帮派
read(?PT_APPLY_JOIN_GUILD, <<GuildId:64,Index:8>>) ->
	{ok, [GuildId,Index]};


%% 审批本帮会申请人员 finish
read(?PT_HANDLE_APPLY, <<PlayerId:64, Choise:8>>) ->
	{ok, [PlayerId, Choise]};
	

%% 邀请他人加入帮派
read(?PT_INVITE_JOIN_GUILD, <<PlayerId:64>>) ->
	{ok, [PlayerId]};


%% 回复帮会邀请
read(?PT_REPLY_INVITE, <<GuildId:64, Choise:8>>) ->
	{ok, [GuildId, Choise]};


%% 开除帮会成员
read(?PT_KICK_OUT_FROM_GUILD, <<GuildId:64, PlayerId:64>>) ->
	{ok, [GuildId, PlayerId]};
    

%% 退出帮派
read(?PT_QUIT_GUILD, <<GuildId:64>>) ->
	{ok, [GuildId]};


%% 获取帮会列表
read(?PT_GET_GUILD_LIST, <<PageSize:8, PageNum:16>>) ->
	{ok, [PageSize, PageNum]};


%% 获取帮会成员列表
read(?PT_GET_GUILD_MB_LIST, <<GuildId:64, PageSize:8, PageNum:16, SortType:8>>) ->
	{ok, [GuildId, PageSize, PageNum, SortType]};


%% 获取帮会申请列表
read(?PT_GET_REQ_JOIN_LIST, <<GuildId:64, PageSize:8, PageNum:16>>) ->
	{ok, [GuildId, PageSize, PageNum]};


% %% 获取帮会邀请列表  finish
% read(40013, <<_PlayerId:32, PageSize:16, PageNum:16>>) ->
% 	{ok, [PageSize, PageNum]};


%% 获取帮派基本信息  
read(?PT_BASE_GUILD_INFO, <<GuildId:64>>) ->
	{ok, [GuildId]};


%% 修改帮派宗旨
read(?MODIFY_GUILD_TENET, <<GuildId:64, BinData/binary>>) ->
	{Tenet, _} = pt:read_string(BinData),
	{ok, [GuildId, Tenet]};

% %% 修改帮派公告 finish
% read(40016, <<GuildId:64, BinData/binary>>) ->
% 	{Tenet, _} = pt:read_string(BinData),
% 	{ok, [GuildId, Tenet]};


%% 帮会授予官职
read(?APPOINT_GUILD_POSITION, <<PlayerId:64, Position:8>>) ->
    {ok, [PlayerId, Position]};



%% 获取帮会列表
read(?PT_SEARCH_GUILD_LIST, <<PageSize:8, PageNum:16, NotFull:8, Bin/binary>>) ->
	{SearchName, _} = pt:read_string(Bin),
	{ok, [PageSize, PageNum, NotFull, SearchName]};


read(?PT_GET_PLAYER_GUILD_INFO, _) ->
	{ok, []};


read(?PT_GET_GUILD_POS_INFO, <<GuildId:64>>) ->
	{ok, [GuildId]};


read(?PT_QUERY_GUILD_PAY, _) ->
	{ok, []};


read(?PT_GET_GUILD_PAY, <<Type:8>>) ->
	{ok, [Type]};

read(?PT_GUILD_ADD_DISHES, <<DishesNo:8>>) ->
	{ok, [DishesNo]};

read(?PT_GUILD_GET_DISHES, <<>>) ->
	{ok, []};	

read(?PT_GUILD_DUNGEON_ENTER, _) ->
	{ok, []};	

read(?PT_GUILD_DUNGEON_COLLECT, <<NpcId:32>>) ->
	{ok, [NpcId]};	

read(?PT_GUILD_GET_DUNGEON_INFO, _) ->
	{ok, []};		


read(?PT_GUILD_CULTIVATE, <<ObjInfoCode:8, Count:8, Type:8>>) ->
	{ok, [ObjInfoCode, Count, Type]};			
	

read(?PT_GUILD_USE_GOODS, <<ObjInfoCode:8, GoodsNo:32, Count:8>>) ->
	{ok, [ObjInfoCode, GoodsNo, Count]};			

read(?PT_GUILD_DONATE, <<Contri:32>>) ->
	{ok, [Contri]};			

read(?PT_GUILD_GET_CULTIVATE_INFO, _) ->
	{ok, []};

read(?PT_GUILD_GET_DONATE_INFO, _) ->
	{ok, []};	


read(?PT_GUILD_BID_FOR_BATTLE, <<Money:32>>) ->
	{ok, [Money]};


read(?PM_GUILD_GET_BID_LIST, _) ->
	{ok, []};		

read(?PM_GUILD_SIGN_IN_FOR_GB, _) ->
	{ok, []};			

read(?PM_GUILD_QUIT_PRE_WAR, _) ->
	{ok, []};	


read(?PM_GUILD_QUIT_WAR, _) ->
	{ok, []};				

read(?PM_GUILD_GET_INFO_IN_GB, _) ->
	{ok, []};				

read(?PM_GUILD_GET_INFO_BEFORE_GB, _) ->
	{ok, []};	

read(?PM_GUILD_BATTLE_GROUP, _) ->
	{ok, []};		

read(?PT_GUILD_START_WAR_PK, <<ObjPlayerId:64>>) ->
	{ok, [ObjPlayerId]};			

read(?PM_GUILD_QRY_SIGE_IN_STATE, _) ->
	{ok, []};	


read(?PT_MODIFY_GUILD_NAME, <<GoodsId:64, Bin/binary>>) ->
    {Name, _} = pt:read_string(Bin),
    {ok, [GoodsId, Name]};

read(?PT_GUILD_GET_WASH_CONS, _) ->
    {ok, []};	

read(?PT_GUILD_DO_WASH, _) ->
    {ok, []};	


read(?PT_GUILD_SKILL_LEVEL_UP, <<No:32>>) ->
    {ok, [No]};	


read(?PT_CULTIVATE_SKILL_LEVEL_UP, <<No:32,Count:8>>) ->
    {ok, [No,Count]};	

read(?PT_GUILD_CULTIVATE_USE_GOODS, <<No:32,Count:16>>) ->
    {ok, [No,Count]};	


read(?PT_GUILD_SKILL_USE, <<No:32>>) ->
    {ok, [No]};	    

read(?PT_GUILD_GET_ALL_SKILL, _) ->
    {ok, []};	 

read(?PT_GET_ALL_CULTIVATE_SKILL, _) ->
    {ok, []};

read(?PT_JOIN_GUILD_ZHUXIAN_TASK, _) ->
	{ok, []};

read(?PT_GUILD_JOIN_CONTROLLER, <<Guild:64,Type:8>>) ->
	{ok, [Guild, Type]};

read(?PT_GUILD_QUERY_DYNAMIC_GOODS_IN_SHOP, <<GuildId:64>>) ->
	{ok, [GuildId]};

read(?PT_GUILD_SHOP_BUY, <<Guild:64,ShopId:16,Count:32>>) ->
	{ok, [Guild, ShopId,Count]};


%% 错误处理
read(_Cmd, _Bin) ->
    ?TRACE("ERROR receive 40 message ~p~n.", [_Cmd]),
	{error, no_match}.



%% ------------------------------------------------------------
%% Server >> Client
%% ------------------------------------------------------------

%% 创建帮会了	
write(?PT_CREATE_GUILD, [RetCode, GuildId, Name]) ->
	GuildName = Name,
    NameLen = byte_size(list_to_binary(GuildName)),
    % Brief1 = Brief,
    % BriefLen = byte_size(list_to_binary(Brief1)),
    % Data = <<RetCode:8, GuildId:64, Lv:8, NameLen:16, (list_to_binary(GuildName))/binary, BriefLen:16, (list_to_binary(Brief1))/binary>>,
    Data = <<RetCode:8, GuildId:64, NameLen:16, (list_to_binary(GuildName))/binary>>,
    {ok, pt:pack(?PT_CREATE_GUILD, Data)};


%% 申请解散帮派
write(?PT_DISBAND_GUILD, [RetCode]) ->
	{ok, pt:pack(?PT_DISBAND_GUILD, <<RetCode:8>>)};


% %% 取消解散帮派申请
% write(40003, Res) ->
% 	{ok, pt:pack(40003, <<Res:16>>)};


%% 申请加入帮派
write(?PT_APPLY_JOIN_GUILD, [RetCode]) ->
	{ok, pt:pack(?PT_APPLY_JOIN_GUILD, <<RetCode:8>>)};
			

%% 处理入帮申请
write(?PT_HANDLE_APPLY, [RetCode, Choise]) ->
	{ok, pt:pack(?PT_HANDLE_APPLY, <<RetCode:8, Choise:8>>)};


%% 邀请他人加入帮派
write(?PT_INVITE_JOIN_GUILD, [RetCode]) ->
	{ok, pt:pack(?PT_INVITE_JOIN_GUILD, <<RetCode:8>>)};


%% 回复帮会邀请
write(?PT_REPLY_INVITE, [RetCode]) ->
	{ok, pt:pack(?PT_REPLY_INVITE, <<RetCode:8>>)};


%% 开除帮会成员
write(?PT_KICK_OUT_FROM_GUILD, [RetCode]) ->
	{ok, pt:pack(?PT_KICK_OUT_FROM_GUILD, <<RetCode:8>>)};


%% 退出帮派操作
write(?PT_QUIT_GUILD, [RetCode]) ->
	{ok, pt:pack(?PT_QUIT_GUILD, <<RetCode:8>>)};


% %% 获取帮会列表
% write(?PT_GET_GUILD_LIST, [RetCode, TotalPage, PageNum, GuildList]) ->
% 	F = fun(GuildInfo) -> guild_info_to_binary(GuildInfo) end, 
% 	List = lists:map(F, GuildList),
% 	Len = length(List),
% 	Bin = list_to_binary(List),
% 	?TRACE("RetCode=~p,TotalPage=~p,PageNum=~p,GuildList=~p~n", [RetCode, TotalPage, PageNum, GuildList]),
% 	{ok, pt:pack(?PT_GET_GUILD_LIST, <<RetCode:8, TotalPage:16, PageNum:16, Len:16, Bin/binary>>)};


%% 获取帮会成员列表
write(?PT_GET_GUILD_MB_LIST, [GuildId, MemberCount, OnlineCount, TotalPages, PageNum, MemberList]) ->
	F = fun(Info) -> member_info_to_binary(Info) end, 
	List = lists:map(F, MemberList),
	Len = length(List),
	Bin = list_to_binary(List),
	{ok, pt:pack(?PT_GET_GUILD_MB_LIST, <<GuildId:64, MemberCount:32, OnlineCount:32, TotalPages:16, PageNum:16, Len:16, Bin/binary>>)};	


%% 获取帮会申请列表
write(?PT_GET_REQ_JOIN_LIST, [RetCode, TotalPages, PageNum, ApplyList]) ->
	F = fun(Info) -> apply_info_to_binary(Info) end,
	List = lists:map(F, ApplyList),
	Len = length(List),
	Bin = list_to_binary(List),
	{ok, pt:pack(?PT_GET_REQ_JOIN_LIST, <<RetCode:8, TotalPages:16, PageNum:16, Len:16, Bin/binary>>)};



%% 获取帮派基本信息
write(?PT_BASE_GUILD_INFO, InfoList) ->
	[GuildId, GuildName, Lv, Notice, ChiefId, ChiefName, Rank, _CurMbCount, MbCapacity, Contri, CurProsper, MaxProsper, Fund, State, Liveness, BattlePower, Type] = InfoList,
	
	NameLen = byte_size(GuildName),
	NoticeLen = byte_size(Notice),
	ChiefNameLen = byte_size(ChiefName),

	MemberInfoL = mod_guild:get_member_info_list(GuildId),
	CurMbCount = length(MemberInfoL),
	SortMbL = ply_guild:get_member_info_list(90, GuildId, 1, CurMbCount, MemberInfoL),

	F = fun(Member) -> 
		<<
			(byte_size(Member#guild_mb.name)) : 16,
			(Member#guild_mb.name) / binary,
			(Member#guild_mb.contri_today) : 32,
			(Member#guild_mb.vip_lv) : 8
		>>
	end, 
	Top3MbL = 
		case length(SortMbL) < 0 of
			true -> 
				[];
			false -> 
				TopMbLen = erlang:min(3, length(SortMbL)),
				lists:sublist(SortMbL, 1, TopMbLen)
		end,
    List = lists:map(F, Top3MbL),
    MbLen = length(List),
    BinMb = list_to_binary(List),

    LivenessSD = 
    	case data_guild_lv:get(Lv) of
    		null -> ?MAX_U32;
    		DataCfg -> DataCfg#guild_lv_data.liveness
    	end,
    
	BinData = <<GuildId:64, NameLen:16, GuildName/binary, Lv:16, NoticeLen:16, Notice/binary, ChiefId:64, 
	ChiefNameLen:16, ChiefName/binary, Rank:16, CurMbCount:16, MbCapacity:16, Contri:32, CurProsper:32, MaxProsper:32, 
	Fund:32, State:8, MbLen:16, BinMb/binary, Liveness:32, LivenessSD:32, BattlePower:32, Type:8>>,

	{ok, pt:pack(?PT_BASE_GUILD_INFO, <<BinData/binary>>)};


%% 修改帮派宗旨
write(?MODIFY_GUILD_TENET, [RetCode]) ->
	{ok, pt:pack(?MODIFY_GUILD_TENET, <<RetCode:8>>)};


% %% 修改帮派公告
% write(40016, Res) ->
% 	{ok, pt:pack(40016, <<Res:16>>)};

%% 帮会授予官职
write(?APPOINT_GUILD_POSITION, [RetCode, PlayerId, Position]) ->
	{ok, pt:pack(?APPOINT_GUILD_POSITION, <<RetCode:8, PlayerId:64, Position:8>>)};


write(?PT_GOT_INVITE, [FromPlayerId, FromPlayerName, Guild]) ->
	GuildName = mod_guild:get_name(Guild),
	Data = <<FromPlayerId:64, (byte_size(FromPlayerName)):16, FromPlayerName/binary, (mod_guild:get_id(Guild)):64, (byte_size(GuildName)):16, 
	GuildName/binary, (Guild#guild.lv):16>>,
	{ok, pt:pack(?PT_GOT_INVITE, Data)};


write(?PT_GET_PLAYER_GUILD_INFO, [Member]) ->
	Data = <<(Member#guild_mb.position):8, (player:get_guild_contri(player:get_PS(Member#guild_mb.id))):32, (Member#guild_mb.contri):32>>,
	{ok, pt:pack(?PT_GET_PLAYER_GUILD_INFO, Data)};


%% 获取帮会列表
write(?PT_SEARCH_GUILD_LIST, [RetCode, PlayerId, TotalPage, PageNum, GuildList]) ->
	F = fun(GuildInfo) -> guild_info_to_binary(PlayerId, GuildInfo) end, 
	List = lists:map(F, GuildList),
	Len = length(List),
	Bin = list_to_binary(List),
	?TRACE("RetCode=~p,TotalPage=~p,PageNum=~p,GuildList=~p~n", [RetCode, TotalPage, PageNum, GuildList]),
	{ok, pt:pack(?PT_SEARCH_GUILD_LIST, <<RetCode:8, TotalPage:16, PageNum:16, Len:16, Bin/binary>>)};


write(?PT_GET_GUILD_POS_INFO, [Guild]) ->
	GuildId = Guild#guild.id,
	CounsellorCount = length(Guild#guild.counsellor_id_list),
	ShaozhangCount = length(Guild#guild.shaozhang_id_list),
	InfoList = [{?GUILD_POS_CHIEF, 1, 1}, 
				{?GUILD_POS_COUNSELLOR, CounsellorCount, (data_guild_lv:get(Guild#guild.lv))#guild_lv_data.counsellor_max},
				{?GUILD_POS_SHAOZHANG, ShaozhangCount, (data_guild_lv:get(Guild#guild.lv))#guild_lv_data.shaozhang_max},
				{?GUILD_POS_NORMAL_MEMBER, length(Guild#guild.member_id_list) - 1 - CounsellorCount - ShaozhangCount, 
					(data_guild_lv:get(Guild#guild.lv))#guild_lv_data.capacity - 1}
				],

	F = fun({Pos, CurCount, MaxCount}) ->
		<<Pos:8, CurCount:8, MaxCount:8>>
	end,

	Len = length(InfoList),
	List = lists:map(F, InfoList),
	Bin = list_to_binary(List),
	{ok, pt:pack(?PT_GET_GUILD_POS_INFO, <<GuildId:64, Len:16, Bin/binary>>)};


write(?PT_NOTIFY_JOINED_GUILD, [GuildId, PlayerName, GuildName]) ->
	Data = <<GuildId:64, (byte_size(PlayerName)):16, PlayerName/binary, (byte_size(GuildName)):16, GuildName/binary>>,
	{ok, pt:pack(?PT_NOTIFY_JOINED_GUILD, Data)};


write(?PT_NOTIFY_GUILD_DISBANDED, [GuildId, PlayerName, GuildName]) ->
	Data = <<GuildId:64, (byte_size(PlayerName)):16, PlayerName/binary, (byte_size(GuildName)):16, GuildName/binary>>,
	{ok, pt:pack(?PT_NOTIFY_GUILD_DISBANDED, Data)};


write(?PT_NOTIFY_MEMBER_POS_CHANGE, [OpPos, OpName, OpedName, OpedPrePos, OpedNowPos]) ->
	Data = <<OpPos:8, (byte_size(OpName)):16, OpName/binary, (byte_size(OpedName)):16, OpedName/binary, OpedPrePos:8, OpedNowPos:8>>,
	{ok, pt:pack(?PT_NOTIFY_MEMBER_POS_CHANGE, Data)};


write(?PT_NOTIFY_QUIT_GUILD, [GuildId, PlayerName, GuildName]) ->
	Data = <<GuildId:64, (byte_size(PlayerName)):16, PlayerName/binary, (byte_size(GuildName)):16, GuildName/binary>>,
	{ok, pt:pack(?PT_NOTIFY_QUIT_GUILD, Data)};


write(?PT_NOTIFY_KICK_OUT_GUILD, [GuildId, OpPos, OpName, OpedName]) ->
	Data = <<GuildId:64, OpPos:8, (byte_size(OpName)):16, OpName/binary, (byte_size(OpedName)):16, OpedName/binary>>,
	{ok, pt:pack(?PT_NOTIFY_KICK_OUT_GUILD, Data)};


write(?PT_QUERY_GUILD_PAY, PayList) ->
	Len = length(PayList),
	List = 
		case PayList =:= [] of
			false ->
				[<<1:8, (element(2, lists:nth(1, PayList))):8, (element(1, lists:nth(1, PayList))):32>>, 
				 <<2:8, (element(2, lists:nth(2, PayList))):8, (element(1, lists:nth(2, PayList))):32>>,
				 <<3:8, (element(2, lists:nth(3, PayList))):8, (element(1, lists:nth(3, PayList))):32>>,
				 <<4:8, (element(2, lists:nth(4, PayList))):8, (element(1, lists:nth(4, PayList))):32>>
				];
			true -> []
		end,
		
	Bin = list_to_binary(List),
	{ok, pt:pack(?PT_QUERY_GUILD_PAY, <<Len:16, Bin/binary>>)};


write(?PT_GET_GUILD_PAY, [RetCode, Type]) ->
	{ok, pt:pack(?PT_GET_GUILD_PAY, <<RetCode:8, Type:8>>)};	


write(?PT_NOTIFY_GUILD_INFO_CHANGE, KV_TupleList) ->
    F = fun({ObjInfo, Value}) ->
    		ObjInfoCode = 
	    		case ObjInfo of
	    			guild_lv -> 1;
	    			_Any -> ?ASSERT(false, ObjInfo), ?INVALID_NO
	    		end,
            <<ObjInfoCode:8, Value:32>>
        end,
    Bin = list_to_binary([F(X) || X <- KV_TupleList]),
    Bin2 = <<
            (length(KV_TupleList)) : 16,
             Bin / binary
           >>,
    {ok, pt:pack(?PT_NOTIFY_GUILD_INFO_CHANGE, Bin2)};


write(?PT_GUILD_ADD_DISHES, [RetCode]) ->
	{ok, pt:pack(?PT_GUILD_ADD_DISHES, <<RetCode:8>>)};	

% 返回list
write(?PT_GUILD_GET_DISHES, [Dishes_No_List]) ->
	F = fun(Dishes_No) ->    		
        <<Dishes_No:32>>
    end,

	Bin = list_to_binary([F(X) || X <- Dishes_No_List]),
    Bin2 = <<
            (length(Dishes_No_List)) : 16,
            Bin / binary
            >>,

	{ok, pt:pack(?PT_GUILD_GET_DISHES, Bin2)};		

write(?PT_GUILD_DUNGEON_ENTER, [RetCode, GuildLv]) ->
	{ok, pt:pack(?PT_GUILD_DUNGEON_ENTER, <<RetCode:8, GuildLv:8>>)};		

write(?PT_GUILD_DUNGEON_COLLECT, [RetCode]) ->
	{ok, pt:pack(?PT_GUILD_DUNGEON_COLLECT, <<RetCode:8>>)};			

write(?PT_GUILD_NOTIFY_DUNGEON_RET, [PlayerId, WinState, GoodsList]) ->
	% ?DEBUG_MSG("lib_guild:give_reward_and_notify_result_success Reward:~p ~n", [{PlayerId, WinState, GoodsList}]),
	F = fun({GoodsId, GoodsNo, GoodsCount}) ->
    		GoodsQua = mod_inv:get_goods_quality_by_id(PlayerId, GoodsId),
    		BindState = mod_inv:get_goods_bind_state_by_id(GoodsId),
            <<GoodsId:64, GoodsNo:32, GoodsCount:32, GoodsQua:8, BindState:8>>
        end,
    Bin = list_to_binary([F(X) || X <- GoodsList]),

    Bin2 = <<
    		WinState: 8,
            (length(GoodsList)) : 16,
             Bin / binary
           >>,
    {ok, pt:pack(?PT_GUILD_NOTIFY_DUNGEON_RET, Bin2)};


write(?PT_GUILD_GET_DUNGEON_INFO, [Dungeon]) ->
	Floor = Dungeon#guild_dungeon.floor,
	Data = data_guild_dungeon:get(Floor),
	LeftTime = max(Data#guild_dungeon_cfg.time - (svr_clock:get_unixtime() - Dungeon#guild_dungeon.start_time), 0),
	NeedPoint = Data#guild_dungeon_cfg.need_point,
	Collect = Dungeon#guild_dungeon.collect,
	KillMon = Dungeon#guild_dungeon.kill_mon,
	CurPoint = Collect * Data#guild_dungeon_cfg.point_npc + KillMon * Data#guild_dungeon_cfg.point_mon,
	% ?DEBUG_MSG("write(?PT_GUILD_GET_DUNGEON_INFO Dungeon:~w LeftTime:~p, Collect:~p, KillMon:~p~n", [Dungeon, LeftTime, Collect, KillMon]),
	BinData = <<
		Floor : 16,
		LeftTime : 32,
		CurPoint : 32,
		NeedPoint : 32,
		Collect : 32,
		KillMon : 32
	>>,
	
	{ok, pt:pack(?PT_GUILD_GET_DUNGEON_INFO, BinData)};


write(?PT_GUILD_CULTIVATE, [RetList, Cultivate, CultivateLv, ObjInfoCode, Type]) ->
	Len = length(RetList),
	F = fun({RetCode, AddCultivate}) ->
		<<RetCode:16, AddCultivate:32>>
	end,

	Bin = list_to_binary([F(X) || X <- RetList]),
	BinData = <<Len:16, Bin/binary, Cultivate:32, CultivateLv:16, ObjInfoCode:8, Type:8>>,
	{ok, pt:pack(?PT_GUILD_CULTIVATE, BinData)};


write(?PT_GUILD_DONATE, [Contri, AddProsper]) ->
	{ok, pt:pack(?PT_GUILD_DONATE, <<Contri:32, AddProsper:32>>)};

write(?PT_GUILD_USE_GOODS, [Cultivate, CultivateLv, ObjInfoCode]) ->
	{ok, pt:pack(?PT_GUILD_USE_GOODS, <<Cultivate:32, CultivateLv:16, ObjInfoCode:8>>)};

write(?PT_GUILD_GET_CULTIVATE_INFO, [PS, GuildLv, Contri]) ->
	Len = length(player:get_guild_attrs(PS)),
	F = fun({AttrName, Lv, Value}) ->
		Code = lib_attribute:attr_name_to_obj_info_code(AttrName),
		<<Code:8, Lv:8, Value:32>>
	end,

	Bin = list_to_binary([F(X) || X <- player:get_guild_attrs(PS)]),
	BinData = <<GuildLv:8, Contri:32, Len:16, Bin/binary>>,
	{ok, pt:pack(?PT_GUILD_GET_CULTIVATE_INFO, BinData)};


write(?PT_GUILD_GET_DONATE_INFO, [GuildMb, Guild]) ->
	GuildLv = mod_guild:get_lv(Guild),
	Prosper = mod_guild:get_prosper(Guild),

	RankList = 
		case length(Guild#guild.donate_rank) >= 6 of
			true -> lists:sublist(Guild#guild.donate_rank, 1, 6);
			false -> Guild#guild.donate_rank
		end,
	Len = length(RankList),
	F = fun({Name, Value}) ->
		<<(byte_size(Name)):16, Name/binary, Value:32>>
	end,
	Contri = GuildMb#guild_mb.left_contri,
	Position = mod_guild:decide_guild_pos(GuildMb#guild_mb.id, Guild),

	Bin = list_to_binary([F(X) || X <- RankList]),
	BinData = <<GuildLv:8, Contri:32, Prosper:32, Position:8, (GuildMb#guild_mb.donate_today):32, Len:16, Bin/binary>>,
	{ok, pt:pack(?PT_GUILD_GET_DONATE_INFO, BinData)};


write(?PT_GUILD_NOTIFY_PLAYER_APPLY, []) ->
	{ok, pt:pack(?PT_GUILD_NOTIFY_PLAYER_APPLY, <<>>)};

write(?PT_GUILD_BID_FOR_BATTLE, [RetCode]) ->
	{ok, pt:pack(?PT_GUILD_BID_FOR_BATTLE, <<RetCode:8>>)};	


write(?PM_GUILD_GET_BID_LIST, [Guild, GuildMb, MinNeedMoney]) ->
	Len = length(Guild#guild.bid_id_list),
	F = fun(Id) ->
		Member = 
			case Id =:= GuildMb#guild_mb.id of
				true -> GuildMb;
				false -> mod_guild:get_member_info(Id)
			end,
		case Member =:= null of
			true -> <<>>;
			false ->
				<<Id:64, (Member#guild_mb.position):8, (Member#guild_mb.bid):32, (byte_size(Member#guild_mb.name)):16, (Member#guild_mb.name)/binary>>
		end
	end,
	Bin = list_to_binary([F(X) || X <- Guild#guild.bid_id_list]),
	BinData = <<(Guild#guild.total_bid):32, MinNeedMoney:32, Len:16, Bin/binary>>,
	{ok, pt:pack(?PM_GUILD_GET_BID_LIST, BinData)};	

write(?PM_GUILD_SIGN_IN_FOR_GB, [RetCode]) ->
	{ok, pt:pack(?PM_GUILD_SIGN_IN_FOR_GB, <<RetCode:8>>)};		

write(?PM_GUILD_QUIT_PRE_WAR, [RetCode]) ->
	{ok, pt:pack(?PM_GUILD_QUIT_PRE_WAR, <<RetCode:8>>)};	

write(?PM_GUILD_QUIT_WAR, [RetCode]) ->
	{ok, pt:pack(?PM_GUILD_QUIT_WAR, <<RetCode:8>>)};			

write(?PM_GUILD_GET_INFO_IN_GB, [CurPhyPower, AllPhyPower, SelfPlayer, OtherPlayer, LeftTime, OtherGuildName]) ->
	BinData = <<CurPhyPower:32, AllPhyPower:32, SelfPlayer:32, OtherPlayer:32, LeftTime:32, (byte_size(OtherGuildName)):16, OtherGuildName/binary>>,
	{ok, pt:pack(?PM_GUILD_GET_INFO_IN_GB, BinData)};				

write(?PM_GUILD_GET_INFO_BEFORE_GB, [CurPhyPower, AllPhyPower, CurPlayer, StartTime]) ->
	BinData = <<CurPhyPower:32, AllPhyPower:32, CurPlayer:32, StartTime:32>>,
	{ok, pt:pack(?PM_GUILD_GET_INFO_BEFORE_GB, BinData)};	

write(?PM_GUILD_BATTLE_GROUP, [Round, RoundTimeL, FirstGuildName, GroupList]) ->
	?DEBUG_MSG("PM_GUILD_BATTLE_GROUP: Round: ~p, RoundTimeL:~w, GroupList:~w~n", [Round, RoundTimeL, GroupList]),
	F0 = fun({R, Time}) ->
		<<R:8, Time:32>>
	end,
	Bin0 = list_to_binary([F0(X) || X <- RoundTimeL]),

	F = fun({Index, GuildId, Name}) ->
		<<Index:8, GuildId:64, (byte_size(Name)):16, Name/binary>>
	end,
	Bin = list_to_binary([F(X) || X <- GroupList]),

	{ok, pt:pack(?PM_GUILD_BATTLE_GROUP, <<Round:8, (length(RoundTimeL)):16, Bin0/binary, (byte_size(FirstGuildName)):16, FirstGuildName/binary, 
		(length(GroupList)):16, Bin/binary>>)};	


write(?PM_GUILD_QRY_SIGE_IN_STATE, [CanSignIn]) ->
	{ok, pt:pack(?PM_GUILD_QRY_SIGE_IN_STATE, <<CanSignIn:8>>)};		

write(?PM_GUILD_WAR_RET, [RetCode]) ->
	{ok, pt:pack(?PM_GUILD_WAR_RET, <<RetCode:8>>)};	

write(?PT_GUILD_GET_WASH_CONS, [NeedGameMoney]) ->
	{ok, pt:pack(?PT_GUILD_GET_WASH_CONS, <<NeedGameMoney:32>>)};

write(?PT_GUILD_DO_WASH, [RetCode]) ->
	{ok, pt:pack(?PT_GUILD_DO_WASH, <<RetCode:8>>)};


write(?PT_GUILD_SKILL_LEVEL_UP, [No,Lv]) ->
	{ok, pt:pack(?PT_GUILD_SKILL_LEVEL_UP, <<No:32,Lv:32>>)};

write(?PT_CULTIVATE_SKILL_LEVEL_UP, [No,Lv,Point]) ->
	{ok, pt:pack(?PT_CULTIVATE_SKILL_LEVEL_UP, <<No:32,Lv:32,Point:32>>)};

write(?PT_GUILD_CULTIVATE_USE_GOODS, [No,Lv,Point]) ->
	{ok, pt:pack(?PT_GUILD_CULTIVATE_USE_GOODS, <<No:32,Lv:32,Point:32>>)};

write(?PT_GUILD_SKILL_USE, [No,GoodsId]) ->
	{ok, pt:pack(?PT_GUILD_SKILL_USE, <<No:32,GoodsId : 64>>)};

write(?PT_GUILD_GET_ALL_SKILL, [PS]) ->
	Len = length(player:get_guild_attrs(PS)),
	
	F = fun({No, Lv}) ->
		<<No:32, Lv:32>>
	end,

	Bin = list_to_binary([F(X) || X <- player:get_guild_attrs(PS)]),
	BinData = <<Len:16, Bin/binary>>,
	{ok, pt:pack(?PT_GUILD_GET_ALL_SKILL, BinData)};	


write(?PT_GET_ALL_CULTIVATE_SKILL, [PS]) ->
	Len = length(player:get_cultivate_attrs(PS)),
	
	F = fun({No, Lv, Point}) ->
		<<No:32, Lv:32, Point:32>>
	end,

	Bin = list_to_binary([F(X) || X <- player:get_cultivate_attrs(PS)]),
	BinData = <<Len:16, Bin/binary>>,
	{ok, pt:pack(?PT_GET_ALL_CULTIVATE_SKILL, BinData)};

write(?PT_GUILD_JOIN_CONTROLLER, [RetCode]) ->
	{ok, pt:pack(?PT_GUILD_JOIN_CONTROLLER, <<RetCode:8>>)};

write(?PT_GUILD_QUERY_DYNAMIC_GOODS_IN_SHOP, [ShopList]) ->
	Len = length(ShopList),
	F = fun({Id, _No, NumberLimit}) ->
		<<Id:16, NumberLimit:32>>
		end,

	Bin = list_to_binary([F(X) || X <- ShopList]),
	BinData = <<Len:16, Bin/binary>>,
	{ok, pt:pack(?PT_GUILD_QUERY_DYNAMIC_GOODS_IN_SHOP, BinData)};

write(?PT_GUILD_SHOP_BUY, [RetCode,ShopId,NumberLimit]) ->
	{ok, pt:pack(?PT_GUILD_SHOP_BUY, <<RetCode:8,ShopId:16,NumberLimit:32>>)};
	

%% 错误处理
write(_Cmd, _Reply) ->
    ?TRACE("pt_40 wrong protocol ~p~n", _Cmd),
    {ok, pt:pack(0, <<>>)}.
			


		
%% 申请信息转化二进制 
apply_info_to_binary(Info) ->
	PlayerId = Info#join_guild_req.id,
	Name = Info#join_guild_req.name,
	NameLen = byte_size(Name),
    Lv = Info#join_guild_req.lv,
	Sex = Info#join_guild_req.sex,
	Race = Info#join_guild_req.race,
	Faction = Info#join_guild_req.faction,
	BattlePower = Info#join_guild_req.battle_power,
	VipLv = Info#join_guild_req.vip_lv,
	Time = Info#join_guild_req.time,
	<<PlayerId:64, NameLen:16, Name/binary, Lv:16, Sex:8, Race:8, Faction:8, BattlePower:32, VipLv:8, Time:32>>.


%% 帮会信息转化二进制
guild_info_to_binary(PlayerId, Guild) ->
	GuildId = Guild#guild.id,
	GuildName = Guild#guild.name,
	LenGuildName = byte_size(GuildName),
	Level = Guild#guild.lv,
	ChiefId = Guild#guild.chief_id,
	ChiefName = player:get_name(Guild#guild.chief_id),
	LenChiefName = byte_size(ChiefName),
	Rank = Guild#guild.rank,
	CurMbCount = length(Guild#guild.member_id_list),
	MbCapacity = mod_guild:get_capacity_by_guild_lv(Level),
	LenBrief = byte_size(Guild#guild.brief),
	HasApplied = 
		case lists:keyfind(PlayerId, #join_guild_req.id, Guild#guild.request_joining_list) of
			false -> 0;
			_Any -> 1
		end,
	VipLv = 
		case mod_offline_data:get_offline_role_brief(ChiefId) of
			null -> 0;
			OfflineRoleBrief -> OfflineRoleBrief#offline_role_brief.vip_lv
		end,

	?DEBUG_MSG("GuildName=~p,ChiefName=~p,Guild#guild.brief=~p",[GuildName,ChiefName,Guild#guild.brief]),

	<<GuildId:64, LenGuildName:16, GuildName/binary, Level:16, ChiefId:64, LenChiefName:16, ChiefName/binary, Rank:16, 
      CurMbCount:16, MbCapacity:16, LenBrief:16, (Guild#guild.brief)/binary, HasApplied:8, VipLv:8>>.


%% 成员信息转化二进制
member_info_to_binary(Info) ->
	PlayerId = Info#guild_mb.id,
	PlayerName = Info#guild_mb.name,
	PnameLen = byte_size(PlayerName),
	Sex = Info#guild_mb.sex,
	Race = Info#guild_mb.race,
    Faction = Info#guild_mb.faction,
    Contri = player:get_guild_contri(PlayerId),
    TitleId = Info#guild_mb.title_id,
	Position = Info#guild_mb.position,

	LastLogoutTime = player:get_last_logout_time(PlayerId),
	{Online, BattlePower, Lv, VipLv} =
		case player:get_PS(PlayerId) of
			null -> 
				case ply_tmplogout_cache:get_tmplogout_PS(PlayerId) of
					null ->
						case mod_offline_data:get_offline_role_brief(PlayerId) of
							null -> 
								{LastLogoutTime, 0, 0, 0};
							OfflineRoleBrief -> 
								{LastLogoutTime, OfflineRoleBrief#offline_role_brief.battle_power, OfflineRoleBrief#offline_role_brief.lv, OfflineRoleBrief#offline_role_brief.vip_lv}
						end;
					TPS ->
						{LastLogoutTime, ply_attr:get_battle_power(TPS), player:get_lv(TPS), player:get_vip_lv(TPS)}
				end;
			PS -> 
				{0, ply_attr:get_battle_power(PS), player:get_lv(PS), player:get_vip_lv(PS)}
		end,
		
	<<PlayerId:64, PnameLen:16, PlayerName/binary, Lv:16, Sex:8, Race:8, Faction:8, Contri:32, TitleId:8,
	  Position:8, BattlePower:32, Online:32, VipLv:8>>.
