%%%------------------------------------
%%% @author liufang
%%% @copyright UCweb 2015.01.07
%%% @doc 年夜宴会活动.
%%% @end
%%%------------------------------------

-module(pt_37).
-export([write/2, read/2]).

-include("common.hrl").
-include("home.hrl").
-include("pt_37.hrl").

%% 家园 建造/请求总览
read(?PT_HOME_BUILD, <<Type:8>>) ->
    {ok, [Type]};

%% 进入家园场景
read(?PT_HOME_ENTER_SCENE, <<PlayerId:64, Type:8>>) ->
    {ok, [PlayerId, Type]};

%% 退出家园场景
read(?PT_HOME_LEAVE_SCENE, <<>>) ->
    {ok, []};

%% 请求当前所在家园场景信息
read(?PT_GET_HOME_INFO, <<>>) ->
    {ok, []};

%% 家园升级
read(?PT_HOME_LEVEL_UP, <<Type:8>>) ->
	{ok, [Type]};

%%　家园开始种植/炼丹/挖矿（土地，炼丹炉，矿井）
read(?PT_HOME_JOB_START, <<Type:8,No:8,GoodsNo:32,PartnerId:64>>) ->
	{ok, [Type,No,GoodsNo,PartnerId]};

%%-----------家园行为 1(浇水/传力/充能) 2(除虫/注入/强化) 3施肥(土地特有)
read(?PT_HOME_JOB_ACTION, <<Type:8,No:8,Action:8>>) ->
	{ok, [Type,No,Action]};

%%-----------家园 1(铲除/中断/召回) 2收获
read(?PT_HOME_JOB_ACTION_FINISH, <<Type:8,No:8,Action:8>>) ->
	{ok, [Type,No,Action]};


%%-----------家园成就数据
read(?PT_HOME_ACHIEVEMENT_DATA, <<>>) ->
	{ok, []};


%%-----------领取成就奖励
read(?PT_HOME_ACHIEVEMENT_REWARD, <<No:32>>) ->
	{ok, [No]};

%%
read(?PT_HOME_VISIT_LIST, <<>>) ->
	{ok, []};


%%
read(?PT_HOME_VISIT_SEARCH, <<Name/binary>>) ->
	%转换成字符串
	 {Nick, _} = pt:read_string(Name),
	{ok, [Nick]};




read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.

%% 家园 建造/请求总览 
write(?PT_HOME_BUILD, [Home, HomeDatas]) ->
	#home{degree		= Degree, 
		  lv_home		= LvHome, 
		  lv_land		= LvLand, 
		  lv_dan		= LvDan, 
		  lv_mine		= LvMine} = Home,
	PredWholdLand = fun(HomeData) ->
							HomeData#home_data.type == ?HOME_DATA_TYPE_LAND
					end,
	PredWholdDan = fun(HomeData) ->
							HomeData#home_data.type == ?HOME_DATA_TYPE_DAN
					end,
	PredWholdMine = fun(HomeData) ->
							HomeData#home_data.type == ?HOME_DATA_TYPE_MINE
					end,
	PredRipe = fun(HomeData) ->
					   {ok, ?HOME_DATA_STATE_RIPE} == lib_home:check_grid_state(HomeData) 
			   end,
	PredDie = fun(HomeData) ->
					  {ok, ?HOME_DATA_STATE_DIE} == lib_home:check_grid_state(HomeData) 
			  end,
	ListWholeLand = lists:filter(PredWholdLand, HomeDatas),
	ListWholeDan = lists:filter(PredWholdDan, HomeDatas),
	ListWholeMine = lists:filter(PredWholdMine, HomeDatas),
	CountWholeLand = length(ListWholeLand),
	CountWholeDan = length(ListWholeDan),
	CountWholeMine = length(ListWholeMine),
	CountRipleLand = length(lists:filter(PredRipe, ListWholeLand)),
	CountRipleDan = length(lists:filter(PredRipe, ListWholeDan)),
	CountRipleMine = length(lists:filter(PredRipe, ListWholeMine)),
	CountDieLand = length(lists:filter(PredDie, ListWholeLand)),
	FinallyCountWholeLand = CountWholeLand - CountRipleLand - CountDieLand,
    FinallyCountWholeDan  =  CountWholeDan - CountRipleDan,
	FinallyCountWholeMine  =  CountWholeMine - CountRipleMine,
	BinData = <<Degree:32, LvHome:16, LvLand:16, FinallyCountWholeLand:16, CountRipleLand:16, CountDieLand:16, LvDan:16, FinallyCountWholeDan:16, CountRipleDan:16, LvMine:16, FinallyCountWholeMine:16, CountRipleMine:16>>,
    {ok, pt:pack(?PT_HOME_BUILD, BinData)};

% 请求当前所在家园场景信息
write(?PT_GET_HOME_INFO, [Home, HomeDatas]) ->
	#home{degree = Degree, 
		  lv_home = LvHome, 
		  lv_land = LvLand, 
		  lv_dan = LvDan, 
		  lv_mine = LvMine} = Home,
	#home_land{lattice_num = CountLand} = data_home_land:get(LvLand),
	#home_dan{lattice_num = CountDan} = data_home_dan:get(LvLand),
	#home_mine{lattice_num = CountMine} = data_home_mine:get(LvLand),
	CountHomeData = erlang:length(HomeDatas),
	Bin = <<Degree:32,LvHome:16,LvLand:16,LvDan:16,LvMine:16,CountLand:16,CountDan:16,CountMine:16,CountHomeData:16>>,
	BinData = 
		lists:foldl(fun(HomeData, BinAcc) ->
							BinAcc2 = lib_home:grid_data(HomeData),
							<<BinAcc/binary, BinAcc2/binary>>
					end, Bin, HomeDatas),
    {ok, pt:pack(?PT_GET_HOME_INFO, BinData)};

%%-----------家园升级（家园，土地，炼丹炉，矿井）------------
write(?PT_HOME_LEVEL_UP, [Type, Lv]) ->
	Bin = <<Type:8,Lv:8>>,
    {ok, pt:pack(?PT_HOME_LEVEL_UP, Bin)};

%%-----------家园开始种植/炼丹/挖矿（土地，炼丹炉，矿井）------------
write(?PT_HOME_JOB_START, [HomeData]) ->
	Bin = lib_home:grid_data(HomeData),
    {ok, pt:pack(?PT_HOME_JOB_START, Bin)};

%%-----------家园行为 1(浇水/传力/充能) 2(除虫/注入/强化) 3施肥(土地特有) ------------
write(?PT_HOME_JOB_ACTION, [Type, No, Action, EffNow, EffFinal]) ->
	Bin = <<Type:8,No:8,Action:8,EffNow:32,EffFinal:32>>,
    {ok, pt:pack(?PT_HOME_JOB_ACTION, Bin)};


%%-----------家园 1(铲除/中断/召回) 2收获------------
write(?PT_HOME_JOB_ACTION_FINISH, [Type, No, Action,Master]) ->
	Bin = <<Type:8,No:8,Action:8,Master:8>>,
    {ok, pt:pack(?PT_HOME_JOB_ACTION_FINISH, Bin)};


%%-----------家园成就数据------------
write(?PT_HOME_ACHIEVEMENT_DATA, [AchievementValue, AchievementRewardNos]) ->
	Len = erlang:length(AchievementValue),
    Bin = tool:to_binary([<<Type:8, Value:32>> || {Type, Value} <- AchievementValue]),
	Len2 = erlang:length(AchievementRewardNos),
    Bin2 = tool:to_binary([<<No:32>> || No <- AchievementRewardNos]),
	
	BinData = <<Len:16, Bin/binary, Len2:16, Bin2/binary>>,
    {ok, pt:pack(?PT_HOME_ACHIEVEMENT_DATA, BinData)};


%%-----------领取成就奖励------------
write(?PT_HOME_ACHIEVEMENT_REWARD, [No]) ->
	Bin = <<No:32>>,
    {ok, pt:pack(?PT_HOME_ACHIEVEMENT_REWARD, Bin)};


%%----------- 请求家园拜访界面------------
write(?PT_HOME_VISIT_LIST, [DataList]) ->
%		id				u64			玩家id
%		name			string		名字
%		faction			u8			门派
%		lv				u16			等级
%		degree			u32			豪华度
	Len = erlang:length(DataList),
    Bin = tool:to_binary([<<Id:64, (byte_size(Name)):16,Name/binary, Faction:8, Lv:16, Degree:32>> || {Id, Name, Faction, Lv, Degree} <- DataList]),
    {ok, pt:pack(?PT_HOME_VISIT_LIST, <<Len:16, Bin/binary>>)};


%%----------- 搜索玩家家园------------
write(?PT_HOME_VISIT_SEARCH, [{Id, Name, Faction, Lv, Degree}]) ->
%		id				u64			玩家id
%		name			string		名字
%		faction			u8			门派
%		lv				u16			等级
%		degree			u32			豪华度
    Bin = tool:to_binary([<<Id:64, (byte_size(Name)):16,Name/binary, Faction:8, Lv:16, Degree:32>>]),
    {ok, pt:pack(?PT_HOME_VISIT_SEARCH, <<Bin/binary>>)};



write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.
