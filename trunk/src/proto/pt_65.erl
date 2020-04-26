%%%-----------------------------------
%%% @Module  : pt_65
%%% @Author  : 段世和
%%% @Email   : 
%%% @Created : 2015.12
%%% @Description: 帮战
%%%-----------------------------------
-module(pt_65).
-compile(export_all).
-include("common.hrl").
-include("pt_65.hrl").

-include("guild_battle.hrl").

%%
%%客户端 -> 服务端 ----------------------------
%%
read(?PT_ENTER1, <<>>) ->
    {ok, []};

read(?PT_ENTER2, <<NpcId:8>>) ->
    {ok, [NpcId]};

read(?PT_ENTER3, <<NpcId:8>>) ->
    {ok, [NpcId]};

read(?PT_TAKE, <<NpcId:8>>) ->
    {ok, [NpcId]};

read(?PT_QUICK_CLEAR, <<>>) ->
    {ok, []};

read(?PT_QUICK_ENETR2, <<>>) ->
    {ok, []};

read(?PT_CANCEL_ENTER, <<>>) ->
    {ok, []};

read(?PT_GUILD_END_SEND, <<Rounds:32>>) ->
    {ok, [Rounds]};

read(?PT_GET_CUR_GUILD_INFO, <<>>) ->
    {ok, []};   

% 查询个人排行榜
read(?PT_GET_GUILD_BATTLE_PLAYER_RANK, <<Rounds:32>>) ->
    {ok, [Rounds]};       


% 查询个人排行榜
read(?PT_GET_GUILD_BATTLE_GUILD_RANK, <<Rounds:32>>) ->
    {ok, [Rounds]};       

read(_Cmd, _Data) ->
    ?ASSERT(false, [_Cmd]),
    error.


%%
%%服务端 -> 客户端 ----------------------------
%%
write(?PT_ENTER1, HaltTime) ->
    {ok, pt:pack(?PT_ENTER1, <<HaltTime:32>>)};

write(?PT_ENTER2, Code) ->
    {ok, pt:pack(?PT_ENTER2, <<Code:8>>)};
write(?PT_ENTER3, Code) ->
    {ok, pt:pack(?PT_ENTER3, <<Code:8>>)};
write(?PT_TAKE, Code) ->
    {ok, pt:pack(?PT_TAKE, <<Code:8>>)};

write(?PT_QUICK_CLEAR, Code) ->
    {ok, pt:pack(?PT_QUICK_CLEAR, <<Code:8>>)};

write(?PT_QUICK_ENETR2, Code) ->
    {ok, pt:pack(?PT_QUICK_ENETR2, <<Code:8>>)};

write(?PT_CANCEL_ENTER, Code) ->
    {ok, pt:pack(?PT_CANCEL_ENTER, <<Code:8>>)};

write(?PT_GUILD_END_SEND, [Type,GuildBattleHistory,GuildBattleInfo]) ->
    #guild_battle_history{
        rounds = Rounds,
        join_battle_player_count = Join_battle_player_count,               % 参战人数
        join_battle_guild_count = Join_battle_guild_count,                % 参战帮派数
        better_fighter_name = Better_fighter_name,   
        better_fighter_player_id = Better_fighter_player_id, 
        better_touch_throne_name = Better_touch_throne_name, 
        better_touch_throne_player_id = Better_touch_throne_player_id,
        better_trouble_name = Better_trouble_name, 
        better_trouble_player_id = Better_trouble_player_id,
        better_streak_name = Better_streak_name, 
        better_streak_player_id = Better_streak_player_id, 
        better_defend_name = Better_defend_name, 
        better_defend_player_id = Better_defend_player_id, 
        better_try_name = Better_try_name, 
        better_try_player_id = Better_try_player_id, 
        join_battle_max_rate = Join_battle_max_rate, 
        join_battle_max_rate_guild_id = Join_battle_max_rate_guild_id, 
        join_battle_max_rate_guild_name = Join_battle_max_rate_guild_name,
        join_battle_max_count = Join_battle_max_count, 
        join_battle_max_count_guild_id = Join_battle_max_count_guild_id, 
        join_battle_max_count_guild_name = Join_battle_max_count_guild_name, 
        win_guild_name = Win_guild_name, 
        win_guild_id = Win_guild_id,        
        take_throne_player_id = Take_throne_player_id, 
        take_throne_player_name = Take_throne_player_name
    } = GuildBattleHistory,

    #guild_battle_player_info{
        % player_id = PlayerId                       % 玩家id
        % ,rounds = Rounds                         % 轮次

        enter1_count = Enter1_count                   % 进入第1区域次数
        ,enter2_count = Enter2_count                   % 进入第2区域次数
        ,enter3_count = Enter3_count                   % 进入第3区域次数

        ,touch_throne = Touch_throne                   % 触摸王座次数
        ,interrupt_load = Interrupt_load                 % 打断别人读条

        ,battle_win = Battle_win                     % 战斗胜利次数
        ,battle_lose = Battle_lose                    % 战斗失败次数
        ,max_winning_streak = Max_winning_streak             % 最大连胜次数

        % 结算后的数据
        ,point = Point
        ,rank = Rank                       % 排名

    } = GuildBattleInfo,

    ?DEBUG_MSG("
        Better_fighter_name=~p,
        Better_touch_throne_name=~p,
        Better_trouble_name=~p,
        Better_streak_name=~p,
        Better_defend_name=~p,
        Better_try_name=~p,
        Join_battle_max_rate_guild_name=~p,
        Join_battle_max_count_guild_name=~p,
        Win_guild_name=~p
        ",[
        Better_fighter_name,
        Better_touch_throne_name,
        Better_trouble_name,
        Better_streak_name,
        Better_defend_name,
        Better_try_name,
        Join_battle_max_rate_guild_name,
        Join_battle_max_count_guild_name,
        Win_guild_name
        ]),

    {ok, pt:pack(?PT_GUILD_END_SEND, <<
        Type:8,

        Rounds:32,
        Join_battle_player_count:32,
        Join_battle_guild_count:32,

        (byte_size(Better_fighter_name)):16,
        Better_fighter_name/binary,
        Better_fighter_player_id:64,

        (byte_size(Better_touch_throne_name)):16,
        Better_touch_throne_name/binary,
        Better_touch_throne_player_id:64,

        (byte_size(Better_trouble_name)):16,
        Better_trouble_name/binary,
        Better_trouble_player_id:64,

        (byte_size(Better_streak_name)):16,
        Better_streak_name/binary,
        Better_streak_player_id:64,

        (byte_size(Better_defend_name)):16,
        Better_defend_name/binary,
        Better_defend_player_id:64,

        (byte_size(Better_try_name)):16,
        Better_try_name/binary,
        Better_try_player_id:64,
        (util:ceil(Join_battle_max_rate * 100)):8,
        Join_battle_max_rate_guild_id:64,

        (byte_size(Join_battle_max_rate_guild_name)):16,
        Join_battle_max_rate_guild_name/binary,
        Join_battle_max_count:32,
        Join_battle_max_count_guild_id:64,

        (byte_size(Join_battle_max_count_guild_name)):16,
        Join_battle_max_count_guild_name/binary,

        (byte_size(Win_guild_name)):16,
        Win_guild_name/binary,
        Win_guild_id:64,
        Take_throne_player_id:64,

        (byte_size(Take_throne_player_name)):16,
        Take_throne_player_name/binary,

        Enter1_count:32,                        %   进入第一区域次数
        Enter2_count:32,                        %   进入第二区域次数
        Enter3_count:32,                        %   进入第三区域次数
        Touch_throne:32,                        %   触摸王座次数
        Interrupt_load:32,                      %   打断被人读条次数
        Battle_win:32,                          %   战斗胜利次数
        Battle_lose:32,                         %   战斗失败次数
        Max_winning_streak:32,                  %   最大连胜次数
        Point:32,                               %   积分
        Rank:32                                 %   排名

        >>)};

% 当前状态
write(?PT_GET_CUR_GUILD_INFO, [Rounds,State,Time]) ->
    {ok, pt:pack(?PT_GET_CUR_GUILD_INFO, <<Rounds:32,State:8,Time:32>>)};

write(?PT_GET_GUILD_BATTLE_PLAYER_RANK, [Rounds,PlayerCount,MyRank,List1]) ->
    F = fun(#guild_battle_player_info{ 
        player_id = PlayerId ,
        guild_id = GuildId ,
        guild_name = GuildName ,
        enter1_count = Enter1_count ,
        enter1_time = Enter1_time ,
        enter2_count = Enter2_count ,
        enter2_time = Enter2_time ,
        enter3_count = Enter3_count ,
        enter3_time = Enter3_time ,
        touch_throne = Touch_throne ,
        interrupt_load = Interrupt_load ,
        battle_win = Battle_win ,
        battle_lose = Battle_lose ,
        winning_streak = Winning_streak ,
        max_winning_streak = Max_winning_streak ,
        point = Point ,
        rank = Rank 
        }) ->

        PlayerName = player:get_name(PlayerId),
        PlayerNameLen = (byte_size(PlayerName)),    

        GuildNameLen = (byte_size(GuildName)), 

        <<
            PlayerNameLen:16,
            PlayerName/binary,

            PlayerId:64,

            GuildNameLen:16,
            GuildName/binary,

            GuildId:64,

            Enter1_count:32,
            Enter1_time:32,
            Enter2_count:32,
            Enter2_time:32,
            Enter3_count:32,
            Enter3_time:32,
            Touch_throne:32,
            Interrupt_load:32,
            Battle_win:32,
            Battle_lose:32,
            Winning_streak:32,
            Max_winning_streak:32,
            Point:32,
            Rank:32
        >>
    end,
    
    List = lists:sublist(List1,?GUILD_BATTLE_PLAYER_RANK_COUNT),

    Len = length(List),
    ListBinAry = list_to_binary([F(X) || X <- List]),    

    {ok, pt:pack(?PT_GET_GUILD_BATTLE_PLAYER_RANK, <<Rounds:32,PlayerCount:32,MyRank:32,Len:16,ListBinAry/binary>>)};

write(?PT_GET_GUILD_BATTLE_GUILD_RANK, [Rounds,GuildCount,MyRank,List1]) ->
    % 这里没有写完
    F = fun(#guild_battle_guild_info{ 
        guild_id = GuildId ,
        guild_name = GuildName ,
        join_battle_player_count = Join_battle_player_count ,
        battle_count = Battle_count ,
        battle_win_count = Battle_win ,
        touch_throne = Touch_throne ,
        point = Point ,
        rank = Rank 
        }) ->

        GuildNameLen = (byte_size(GuildName)), 

        <<
            GuildNameLen:16,
            GuildName/binary,

            GuildId:64,

            Battle_count:32,
            Battle_win:32,
            Touch_throne:32,
            Join_battle_player_count:32,
            Point:32,
            Rank:32
        >>
    end,

    List = lists:sublist(List1,?GUILD_BATTLE_GUILD_RANK_COUNT),

    Len = length(List),
    ListBinAry = list_to_binary([F(X) || X <- List]),    

    {ok, pt:pack(?PT_GET_GUILD_BATTLE_GUILD_RANK, <<Rounds:32,GuildCount:32,MyRank:32,Len:16,ListBinAry/binary>>)};


% 推送玩家某些玩家等不足以进入帮战
write(?PT_SEND_PLAYER_LV_LIMIT, [PlayerId,PlayerName,Lv]) ->
    PlayerNameLen = (byte_size(PlayerName)), 

    {ok, pt:pack(?PT_SEND_PLAYER_LV_LIMIT, <<
        PlayerId:64,
        PlayerNameLen:16,
        PlayerName/binary,
        Lv:32
        >>)};

% 推送玩家某些玩家等不足以进入帮战
write(?PT_LOAD_TIME, [PlayerId,NpcId,LoadTime]) ->
    {ok, pt:pack(?PT_LOAD_TIME, <<
        PlayerId:64,
        NpcId:8,
        LoadTime:16
        >>)};



write(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]),
    error.