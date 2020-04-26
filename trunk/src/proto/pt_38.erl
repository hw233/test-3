%%%------------------------------------
%%% @author 吴剑c
%%% @copyright JKYL 2017.07.04
%%% @doc 取经之路.
%%% @end
%%%------------------------------------



-module(pt_38).
-export([write/2, read/2]).

-include("common.hrl").
%-include("home.hrl").
-include("pt_38.hrl").
-include("road.hrl").



%% 取经之路总览
read(?PT_GET_ROAD, <<>>) ->
    {ok, []};

%% 战斗准备
read(?PT_READY_BATTLE, <<>>) ->
    {ok, []};

%% 重置
read(?PT_RESET_ROAD, <<>>) ->
    {ok, []};

read(?PT_START_BATTLE, <<Bin/binary>>) ->
	{IdMainList, _} = pt:read_array(Bin, [u64, u8]),
    {ok, [IdMainList]}; % IdMainList = [{Id,Main},{Id,Main}...]

read(?PT_GET_REWARD, <<Step:8>>) ->
    {ok,[Step]};




read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.

%%-----------展示取经之路的信息------------
write(?PT_GET_ROAD, [NowPoint,ResetTimes,GetPoint]) ->
	Len = length(GetPoint),
	Bin = list_to_binary([<<X:8>>|| X <-GetPoint]),
	BinData = <<NowPoint:8,ResetTimes:8,Len:16,Bin/binary>>,
    {ok, pt:pack(?PT_GET_ROAD, BinData)};

%%-----------战斗之路的信息------------
  
write(?PT_READY_BATTLE, [PlayerAllPartner,PlayerFPartner,PkInfoData,NowPoint]) ->



	PlayerLen = length(PlayerFPartner), 
	F = fun(X) ->
		  {Id,Hp,Mp,MaxHp,MaxMp,IsMain} = X,
          Partner = lib_partner:get_partner(Id),
		  << 
			 Id:64,
			(lib_partner:get_no(Partner)):32,
            (lib_partner:get_lv(Partner)):16,
            (lib_partner:get_quality(Partner)):8,
            Hp:32,
            MaxHp:32,
            Mp:32,
            MaxMp:32,
            IsMain:8
          >>
        end,
	
	Bin1 = list_to_binary([F(X)|| X <-PlayerFPartner]),



	AllPartnerLen = length(PlayerAllPartner),	
	F1 = fun(X) ->
		  {Id,Hp,Mp,MaxHp,MaxMp} = X,
          Partner = lib_partner:get_partner(Id),
          ParName = lib_partner:get_name(Partner),
		  << 
			 Id:64,
			(lib_partner:get_no(Partner)):32,
            (lib_partner:get_lv(Partner)):16,
            (lib_partner:get_quality(Partner)):8,
            Hp:32,
            MaxHp:32,
            Mp:32,
            MaxMp:32,
			(lib_partner:get_battle_power(Partner)):32,
            (byte_size(ParName)):16,
             ParName/binary
          >>
        end,
	Bin0 = list_to_binary([ F1(X) || X <-PlayerAllPartner]),
	
	PkerData = 
		case length(PkInfoData) >= NowPoint of
			true -> lists:sublist(PkInfoData, NowPoint, 1);
			false -> ?ASSERT(false,NowPoint)
		end,

%% 	BattlePlayerData0 = lists:sublist(PkInfoData, 11, 1), %[[],[],[],...]id,name,faction,lv,sex
%% 
%% 	[[_BattlePlayerId,BattlePlayerName,BattlePlayerFaction,BattlePlayerLv,BattlePlayerSex]] = 
%% 		case length(BattlePlayerData0) >= NowPoint of
%% 			true -> lists:sublist(BattlePlayerData0, NowPoint, 1);
%% 			false -> ?ASSERT(false,NowPoint)
%% 		end,
	
	[{_PlayerId,PlayerName,Faction,PlayerLv,Sex,PkPartner}] =PkerData,
	
	PkerLen = length(PkPartner),
%% 	F1 = fun(X) ->
%% 				 [PartnerId,Hp,Mp] = X ,
%% 				 Partner = lib_partner:get_partner(PartnerId),
%% 				 <<
%% 				    PartnerId:64,
%% 				   (lib_partner:get_no(Partner)):32,
%%                    (lib_partner:get_lv(Partner)):8,
%%                    (lib_partner:get_quality(Partner)):8,
%% 				    Hp:32,
%%                     Mp:32
%% 			 	 >>
%% 		 end,

     F3 = fun(X) ->
			 {Id,Hp,Mp,MaxHp,MaxMp,IsMain} = X,
			 Partner = lib_partner:get_partner(Id),
			 << 
			   Id:64,
			   (lib_partner:get_no(Partner)):32,
			   (lib_partner:get_lv(Partner)):16,
			   (lib_partner:get_quality(Partner)):8,
		    	Hp:32,
                MaxHp:32,
                Mp:32,
                MaxMp:32,
                IsMain:8
			   >>
	 end,

	Bin2 = list_to_binary([ F3(X) ||  X <- PkPartner ]),

	BinData = <<AllPartnerLen:16,Bin0/binary,PlayerLen:16,Bin1/binary, PkerLen:16,Bin2/binary,(byte_size(PlayerName)):16, PlayerName/binary,
				 Faction:8,	PlayerLv:16,Sex:8>>,
    {ok, pt:pack(?PT_READY_BATTLE, BinData)};

%%-----------展示的信息------------
write(?PT_START_BATTLE, [EntryRoad]) ->
	BinData = <<EntryRoad:8>>,
    {ok, pt:pack(?PT_START_BATTLE, BinData)};

%% 重置
write(?PT_RESET_ROAD, [Type]) ->
     BinData = <<Type:8>>,
     {ok, pt:pack(?PT_RESET_ROAD, BinData)};


%领取奖励成功
write(?PT_GET_REWARD, [Type]) ->
     BinData = <<Type:8>>,
     {ok, pt:pack(?PT_GET_REWARD, BinData)};



write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.


