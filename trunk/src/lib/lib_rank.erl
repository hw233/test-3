%%%--------------------------------------
%%% @Module: lib_rank
%%% @Author: liuzhongzheng2012@gmail.com
%%% @Created: 2014-05-08
%%% @Description: 排行榜
%%%--------------------------------------

-module(lib_rank).

%% 本模块仅限于mod_rank模块调用
-export([
            exe/2,

            enter/2,
            data_to_ranker/2,
            check_refresh/0,
            release_rank/0,
            release_rank/1,
            send_rank/3,
            send_equip_detail/2,
            reset_board/1,

            vip_up/2,
            init_rank/0,
            save_board_to_db/0,
            save_as_history/1,
			get_release_board/1,
			send_rank_goods/1,
            send_all_rmb_rank/1,
  			get_max_lv/1,
			get_rank_data_current/2

        ]).

-include("common.hrl").

-include("rank.hrl").
-include("pt_15.hrl").
-include("pt_22.hrl").

-include("goods.hrl").
-include("partner.hrl").
-include("record/goods_record.hrl").
-include("arena_1v1.hrl").
-include("db.hrl").
-include("mount.hrl").
-include("guild_dungeon.hrl").
-include("log.hrl").
-include("reward.hrl").

-record(rboard, {
             rank_id     = 0,          %% 榜单编号
             rank_list   = [],         %% 榜单(Ranker的列表)
             bottom_val  = 0,          %% 末名数值
             bottom_time = infinity,   %% 末名时间(atom大于整数)
             size        = 0           %% 榜单大小
             }).

%% 对指定榜单执行处理
exe(RankID, Func) ->
    #rboard{rank_list=RList} = get_release_board(RankID),
    Func(RList).


get_rank_data_current(PlayerId, ?RANK_GUILD_BATTLE_POWER) ->
	case player:get_guild_id(PlayerId) of
		0 ->
			0;
		GuildId ->
			mod_guild:get_battle_power(GuildId)
	end;

get_rank_data_current(PlayerId, ?RANK_GUILD_BATTLE_PROSPER) ->
	case player:get_guild_id(PlayerId) of
		0 ->
			0;
		GuildId ->
			mod_guild:get_prosper(GuildId)
	end;

get_rank_data_current(PlayerId, RankID) ->
	case ply_misc:get_player_misc(PlayerId) of
		#player_misc{rank_data_current = RankDataCurrent} ->
			case lists:keyfind(RankID, 1, RankDataCurrent) of
				{RankID, Data} ->
					Data;
				?false ->
					0
			end;
		_ ->
			0
	end.


rank_data_current(Pid, RankID, Data) when is_pid(Pid) ->
	gen_server:cast(Pid, {rank_data_current, RankID, Data});


rank_data_current(_Pid, _RankID, _Data) ->
	skip.



data_to_ranker(RankID, Val) ->
	%% 如果传进来的Val是{#player_status{}, integer()}的格式就直接在这里统一处理了
	case Val of
		{#player_status{pid = Pid}, Data} when is_integer(Data) ->
			rank_data_current(Pid, RankID, Data);
		_ ->
			skip
	end,
	do_data_to_ranker(RankID, Val).


do_data_to_ranker(RankID,
               #player_status{}=PS)
        when RankID =:= ?RANK_ROLE_BATTLE_POWER
        orelse RankID =:= ?RANK_ROLE_1021
        orelse RankID =:= ?RANK_ROLE_1022
        orelse RankID =:= ?RANK_ROLE_1023
        orelse RankID =:= ?RANK_ROLE_1024
        orelse RankID =:= ?RANK_ROLE_1025
        orelse RankID =:= ?RANK_ROLE_1026 ->
    BattlePower = ply_attr:get_battle_power(PS),
	rank_data_current(player:get_pid(PS), RankID, BattlePower),
    ps_to_rank_role(PS, BattlePower);

do_data_to_ranker(?RANK_ROLE_LV,
               #player_status{}=PS) ->
    Lv = player:get_lv(PS),
    PeakLv = player:get_peak_lv(PS),
    CurExp = player:get_exp(PS),
    ExpLim = player:get_exp_lim(PS),

    Info = case PeakLv > 0 of
               true ->
                   PeakExpLim = player:get_peak_exp_lim(PS),
                   round((PeakLv * 1000000) + round((CurExp/PeakExpLim) * 10000));
               false ->
                   round((Lv * 1000) + round((CurExp/ExpLim) * 100))
           end,
    % ?DEBUG_MSG("info=~p",Info),

    % Exp = player:get_exp(PS),
    rank_data_current(player:get_pid(PS), ?RANK_ROLE_LV, Lv),
	ps_to_rank_role(PS, Info);

do_data_to_ranker(?RANK_ROLE_MONEY,
               #player_status{}=PS) ->
    Money = player:get_gamemoney(PS),
	rank_data_current(player:get_pid(PS), ?RANK_ROLE_MONEY, Money),
    ps_to_rank_role(PS, Money);

do_data_to_ranker(?RANK_ROLE_WORLD_BOSS,
               {PS, Score}) ->
    ps_to_rank_role(PS, Score);

do_data_to_ranker(?RANK_ROLE_WORLD_BOSS_KILL,
               {PS, Score}) ->
    ps_to_rank_role(PS, Score);

do_data_to_ranker(?RANK_ROLE_RMB,
        {PS, Number}) ->
    ps_to_rank_role(PS, Number);

do_data_to_ranker(?RANK_ROLE_TOWER,
               {PS, Lv}) ->
    ps_to_rank_tower(PS, Lv);

do_data_to_ranker(?RANK_TOWER_GHOST,
               {PS, Lv}) ->
    ps_to_rank_tower(PS, Lv);

do_data_to_ranker(?RANK_ROLE_CHARM,
               {PS, Val}) ->
    ps_to_rank_role(PS, Val);

do_data_to_ranker(?RANK_ROLE_COOL,
               {PS, Val}) ->
    ps_to_rank_role(PS, Val);


%% 玩家家园豪华度排行榜
do_data_to_ranker(?RANK_HOME_LUXURY,
               {PS, Val}) ->
    ps_to_rank_role(PS, Val);

%% 帮派副本采集
do_data_to_ranker(?RANK_GUILD_COLLECT,
               {PS, Val}) ->
    ps_to_rank_role(PS, Val);

%% 帮派副本击杀
do_data_to_ranker(?RANK_GUILD_KILL,
               {PS, Val}) ->
    ps_to_rank_role(PS, Val);

%% 帮派副本伤害
do_data_to_ranker(?RANK_GUILD_DAMAGE,
               {PS, Val}) ->
    ps_to_rank_role(PS, Val);

%% 帮派副本贡献
do_data_to_ranker(?RANK_GUILD_CONTRIBUTION,
               {PS, Val}) ->
    ps_to_rank_role(PS, Val);

do_data_to_ranker(?RANK_PARTNER_LV,
               #partner{player_id = PlayerID}=PN) ->
    %% 排行榜根据等级与层数排行 lv*100+Layer
    CLv = lib_partner:get_cultivate_lv(PN) * 100 + lib_partner:get_cultivate_layer(PN),
	rank_data_current(player:get_pid(PlayerID), ?RANK_PARTNER_LV, CLv),
    make_rank_partner(PN, CLv);

do_data_to_ranker(?RANK_PARTNER_BATTLE_POWER,
               #partner{player_id = PlayerID}=PN) ->
    BattlePower = lib_partner:get_battle_power(PN),
	rank_data_current(player:get_pid(PlayerID), ?RANK_PARTNER_BATTLE_POWER, BattlePower),
    make_rank_partner(PN, BattlePower);

do_data_to_ranker(?RANK_MOUNT_LV,
               #ets_mount{player_id = PlayerID}=Mount) ->
    %% 排行榜根据等级与层数排行 lv*100+Layer
    CLv = Mount#ets_mount.level,
	rank_data_current(player:get_pid(PlayerID), ?RANK_MOUNT_LV, CLv),
    make_rank_mount(Mount, CLv);

do_data_to_ranker(?RANK_MOUNT_BATTLE_POWER,
               #ets_mount{player_id = PlayerID}=Mount) ->
    % BattlePower = Mount#ets_mount.battle_power,
    BattlePower = lib_mount:calc_mount_battle_pow(Mount),
	rank_data_current(player:get_pid(PlayerID), ?RANK_MOUNT_BATTLE_POWER, BattlePower),
    make_rank_mount(Mount, BattlePower);

%% do_data_to_ranker(?RANK_EQUIP_BATTLE_POWER,
%%                #goods{}=Goods) ->
%%     ID = lib_goods:get_id(Goods),
%%     GoodsName = lib_goods:get_name(Goods),
%%     Location = lib_goods:get_location(Goods),s
%%     BattlePower = lib_goods:get_battle_power(Goods),
%% 
%%     PlayerID = lib_goods:get_owner_id(Goods),
%%     Ranker = base_ranker(PlayerID),
%% 
%%     case (BattlePower > 0)
%%     andalso (Location == ?LOC_PLAYER_EQP)
%%     andalso lib_goods:is_weapon(Goods) of
%%         ?true ->
%%             Ranker#ranker{
%%                         p1          = ID,
%%                         p2          = GoodsName,
%%                         info        = BattlePower,
%%                         ext         = []
%%                     };
%%         ?false ->
%%             ?undefined
%%     end;

do_data_to_ranker(RankID,
				  #goods{}=Goods) when RankID == ?RANK_EQUIP_WUQI
										   orelse RankID == ?RANK_EQUIP_TOUKUI
										   orelse RankID == ?RANK_EQUIP_YIFU
										   orelse RankID == ?RANK_EQUIP_XIEZI
										   orelse RankID == ?RANK_EQUIP_XIANGLIAN
										   orelse RankID == ?RANK_EQUIP_YAODAI ->
    ID = lib_goods:get_id(Goods),
    GoodsName = lib_goods:get_name(Goods),
    Location = lib_goods:get_location(Goods),
    BattlePower = lib_goods:get_battle_power(Goods),

    PlayerID = lib_goods:get_owner_id(Goods),
    Ranker = base_ranker(PlayerID),

    case (BattlePower > 0)
    andalso (Location == ?LOC_PLAYER_EQP) of
        ?true ->io:format("{?MODULE, ?LINE, RankID, BattlePower} : ~p~n", [{?MODULE, ?LINE, RankID, BattlePower}]),
			rank_data_current(player:get_pid(PlayerID), RankID, BattlePower),
            Ranker#ranker{
                        p1          = ID,
                        p2          = GoodsName,
                        info        = BattlePower,
                        ext         = []
                    };
        ?false ->
            ?undefined
    end;

do_data_to_ranker(?RANK_ARENA_1V1_DAY,
               #arena1{id=UID, day_wins=Wins, day_all=All}) ->
    Ranker = base_ranker(UID),
    Rate = cal_rate(Wins, All),
	rank_data_current(player:get_pid(UID), ?RANK_ARENA_1V1_DAY, Rate),
    Ranker#ranker{
                    info = {Wins, Rate}
                };

do_data_to_ranker(?RANK_ARENA_1V1_WEEK,
               #arena1{id=UID, week_wins=Wins, week_all=All}) ->
    Ranker = base_ranker(UID),
    Rate = cal_rate(Wins, All),
	rank_data_current(player:get_pid(UID), ?RANK_ARENA_1V1_WEEK, Rate),
    Ranker#ranker{
                    info = {Wins, Rate}
                };

do_data_to_ranker(?RANK_ARENA_3V3_DAY,
               #arena1{id=UID, day_wins=Wins, day_all=All}) ->
    Ranker = base_ranker(UID),
    Jifen = Wins*?WIN_JIFEN + (All-Wins) * ?LOSE_JIFEN,
    Jifen1 = case Jifen > 0 of
        true -> Jifen;
        false -> 0
    end,
	rank_data_current(player:get_pid(UID), ?RANK_ARENA_3V3_DAY, Jifen1),
    Ranker#ranker{
                    info = {Jifen1,Wins}
                };

do_data_to_ranker(?RANK_ARENA_3V3_WEEK,
               #arena1{id=UID, week_wins=Wins, week_all=All}) ->
    Ranker = base_ranker(UID),
    Rate = cal_rate(Wins, All),
	rank_data_current(player:get_pid(UID), ?RANK_ARENA_3V3_WEEK, Rate),
    Ranker#ranker{
                    info = {Wins, Rate}
                };

do_data_to_ranker(?RANK_GUILD_BATTLE_POWER,
               {GuildID, Name, Lv, BattlePower}) ->
    #ranker{
            player_id   = GuildID,
            player_name = Name,
            info        = BattlePower,
            p1          = <<>>,
            p2          = <<>>,
			p3			= Lv,
			viplv		= 0
                };


do_data_to_ranker(?RANK_GUILD_BATTLE_PROSPER,
               {GuildID, GuildName, GuildLv, MasterName, MemberStr, Prosper}) ->
    #ranker{
            player_id   = GuildID,
            player_name = GuildName,
            info        = Prosper,
            p1          = MasterName,
            p2          = MemberStr,
			p3			= GuildLv,
			viplv		= 0
                };

do_data_to_ranker(_RankID, _Data) ->
    ?WARNING_MSG("Invalid rank_id or data ~w~ndata: ~p", [_RankID, _Data]),
    ?undefined.

base_ranker(PS) -> % PS或UID都可以
    ID = ?IF(is_integer(PS), PS, player:id(PS)),
    NickName = player:get_name(PS),
    VipLv = player:get_vip_lv(PS),
    #ranker{
                player_id   = ID,
                player_name = NickName,
                time        = util:unixtime(),
                viplv       = VipLv
            }.

ps_to_rank_role(PS, Info) ->
    Ranker = base_ranker(PS),
    Ranker#ranker{
                p1          = player:get_sex(PS),
                p2          = player:get_faction(PS),
                info        = Info
            }.

ps_to_rank_tower(PS, Layer) ->
	Ranker = base_ranker(PS),
	BattlePower = BattlePower = ply_attr:get_battle_power(PS),
    Ranker#ranker{
                p1          = player:get_sex(PS),
                p2          = player:get_faction(PS),
                info        = BattlePower,
				viplv 		= Layer
            }.

make_rank_partner(PN, Info) ->
    case lib_partner:is_main_partner(PN) of
        ?true ->
            ID = lib_partner:get_id(PN),
            PlayerID = lib_partner:get_owner_id(PN),
            Ranker = base_ranker(PlayerID),

            Ranker#ranker{
                        p1 = ID,
                        p2 = lib_partner:get_name(PN),
                        info = Info
                    };
        _ ->
            ?undefined
    end.

make_rank_mount(Mount, Info) ->
    ID = Mount#ets_mount.id,
    PlayerID = Mount#ets_mount.player_id,
    Ranker = base_ranker(PlayerID),
    Ranker#ranker{
        p1 = ID,
        p2 = Mount#ets_mount.name,
        info = Info
    }.

%给全服发公告
send_all_rmb_rank(RankId) ->
    #rboard{rank_list=List} = get_release_board(RankId),
    F = fun(#ranker{rank = Rank,
        player_id = _PlayId,
        player_name = Name,
        p1 = _Sex,
        p2 = _Faction,
        info = _Info,
        viplv = _VipLv},Acc) ->
        case Rank =:= 1 of
            true ->
                Name;
            false ->
                Acc
        end
        end,
    Name = lists:foldl(F, "x", List),
    Title = "土豪榜结果通报",
    Content = lists:concat(["亲爱的玩家们：  恭喜", binary_to_list(Name), "获得开服土豪榜第一名。大家赶紧去围观吧！"]),
    lib_mail:batch_send_sys_mail_time( util:to_binary(unicode:characters_to_list(Title,utf8) ),  util:to_binary(unicode:characters_to_list(Content,utf8) ), [{89000,1,666666}], []).

cal_rate(0, _) ->
    0;
cal_rate(_, 0) ->
    10000;
cal_rate(Win, All) ->
    round(Win / All * 10000).

is_can_enter(Ranker, #rboard{rank_id=RankID,
                              size=Size,
                              bottom_val=BVal,
                              bottom_time=BTime}) ->
    case data_rank:get(RankID) of
        #data_rank{total_size=TotalSize} when Size < TotalSize ->
            ?true;
        #data_rank{} ->
            VT = get_vt(Ranker),
            cmp(VT, {BVal, BTime});
        _ ->
            ?WARNING_MSG("Invalid rank id ~w", [RankID])
    end.


cmp({Val, Time1}, {Val, Time2}) ->
    Time1 < Time2;
cmp({Val1, _Time1}, {Val2, _Time2}) ->
    Val1 > Val2;
cmp(Ranker1, Ranker2) ->
    VT1 = get_vt(Ranker1),
    VT2 = get_vt(Ranker2),
    cmp(VT1, VT2).

get_vt(#ranker{time=Time, info=Val}) -> {Val, Time}.

key_pos(#ranker{}) -> #ranker.player_id.

rank_pos(#ranker{}) -> #ranker.rank.

vip_pos(#ranker{}) -> #ranker.viplv.

uid(#ranker{}=Ranker) -> Ranker#ranker.player_id.

%% 排行榜类型对应协议号: 即 1xxx对应 22001, 2xxx对应22002, 类推!
get_pt(RankID) -> 22000 + RankID div 1000. 

enter(RankID, Ranker) ->
    RBoard = get_board(RankID),
    case is_can_enter(Ranker, RBoard) of
        ?true ->
            Ranker1 = get_ext(RankID, Ranker),
            RBoard1 = enter_board(Ranker1, RBoard),
            set_board(RBoard1);
        _ ->
            case is_in_board(Ranker, RBoard) of
                ?true ->
                    RBoard1 = exit_board(Ranker, RBoard),
                    set_board(RBoard1);
                _ ->
                    skip
            end
    end.



% 获取额外信息
%% get_ext(?RANK_EQUIP_BATTLE_POWER, Ranker) ->
%%     get_goods_ext(Ranker);
get_ext(RankID, Ranker) when RankID == ?RANK_EQUIP_WUQI
							 orelse RankID == ?RANK_EQUIP_TOUKUI
							 orelse RankID == ?RANK_EQUIP_YIFU
							 orelse RankID == ?RANK_EQUIP_XIEZI
							 orelse RankID == ?RANK_EQUIP_XIANGLIAN
							 orelse RankID == ?RANK_EQUIP_YAODAI ->
    get_goods_ext(Ranker);
get_ext(_, Ranker) ->
    Ranker.

% 获取物品额外信息
get_goods_ext(#ranker{p1=GoodsID, player_id=UID}=Ranker) ->
    case mod_inv:find_goods_by_id_from_whole_inv(UID, GoodsID) of
        #goods{}=Goods ->
            RecInfo = record_info(fields, goods),
            Ext = util:rec_to_pl(RecInfo, Goods),
            Ranker#ranker{ext=Ext};
        _ ->
            Ranker
    end.

is_in_board(#ranker{player_id=ID}, #rboard{rank_list=RList}) ->
    case lists:keyfind(ID, #ranker.player_id, RList) of
        #ranker{} ->
            ?true;
        _ ->
            ?false
    end.

enter_board(Ranker, #rboard{rank_id=RankID, rank_list=RList}=RBoard) ->
    KeyPos = key_pos(Ranker),
    Key = erlang:element(KeyPos, Ranker),
    RList1 = lists:keystore(Key, KeyPos, RList, Ranker),
    RList2 = lists:sort(fun cmp/2, RList1),
    Len = length(RList2),
    #data_rank{total_size=TotalSize} = data_rank:get(RankID),
    {RList3, Len1} =
        case Len > TotalSize of
            ?true ->
                {lists:sublist(RList2, 1, TotalSize), TotalSize};
            _ ->
                {RList2, Len}
        end,
    {LastVal, LastTime} =
        case Len1 of
            TotalSize ->
                Last = lists:last(RList3),
                get_vt(Last);
            _ ->
                {0, infinity}
        end,
    RList4 = make_rank_pos(RList3),
    RBoard#rboard{rank_list=RList4,
                  bottom_val=LastVal,
                  bottom_time=LastTime,
                  size=Len1}.

exit_board(Ranker, #rboard{rank_list=RList, size = Size}=RBoard) ->
    KeyPos = key_pos(Ranker),
    Key = erlang:element(KeyPos, Ranker),
    RList1 = lists:keydelete(Key, KeyPos, RList),
    RList2 = make_rank_pos(RList1),
    RBoard#rboard{rank_list=RList2, size = Size - 1}.


make_rank_pos(RList) ->
    make_rank_pos(RList, 1, []).

make_rank_pos([H|T], Pos, Acc) ->
    H1 = erlang:setelement(rank_pos(H), H, Pos),
    make_rank_pos(T, Pos+1, [H1|Acc]);
make_rank_pos([], _Pos, Acc) ->
    lists:reverse(Acc).

%% 检查是否要刷新
check_refresh() ->
    RBoards = get_all_board(),
    lists:foreach(fun check_refresh/1, RBoards).

check_refresh(#rboard{rank_id=RankID}) ->
    case data_rank:get(RankID) of
        #data_rank{refresh_time=RTime, history_time=HTime} ->
            {H, M, _S} = erlang:time(),
            case lists:member({H, M}, RTime) of
                ?true ->
                    release_rank(RankID);
                _ ->
                    ok
            end,
            case lists:member({H, M}, HTime) of
                ?true ->
                    save_as_history(RankID);
                _ ->
                    ok
            end;
        _ ->
            ok
    end.


%% 发布全部排行榜
release_rank() ->
    Boards = get_all_board(),
    [ release_rank(ID) || #rboard{rank_id=ID} <- Boards],
    ok.

release_rank(RankID) ->
    #rboard{rank_list=RList} = Board = get_board(RankID),
    RList1 =
        case lists:member(RankID, [?RANK_GUILD_BATTLE_POWER, ?RANK_GUILD_BATTLE_PROSPER]) of
            ?true ->
                [R#ranker{player_name=mod_guild:get_name_by_id(ID)} || #ranker{player_id=ID}=R <- RList];
            _ ->
                [R#ranker{player_name=player:get_name(ID)} || #ranker{player_id=ID}=R <- RList]
        end,
    erlang:put({release_board, RankID}, Board#rboard{rank_list=RList1}),
    cache_goods(Board),
    ok.

%% 获取已发布的排行榜
get_release_board(RankID) ->
    case erlang:get({release_board, RankID}) of
        ?undefined ->
            #rboard{rank_id=RankID, size=0};
        RBoard ->
            RBoard
    end.

%% 清空已发布的排行榜
reset_release_board(RankID) ->
	 erlang:put({release_board, RankID}, #rboard{rank_id=RankID, size=0}).

%% 清空排行榜
reset_board(RankID) ->
    NewRBoard = #rboard{rank_id=RankID},
    erlang:put({board, RankID}, NewRBoard).

get_board(RankID) ->
    case erlang:get({board, RankID}) of
        ?undefined ->
            NewRBoard = #rboard{rank_id=RankID},
            NewRBoard;
        RBoard ->
            RBoard
    end.

get_all_board() ->
    [RB || {{board, _ID}, #rboard{}=RB} <- erlang:get()].


set_board(#rboard{rank_id=RankID}=RBoard) ->
    erlang:put({board, RankID}, RBoard).

save_board_to_db() ->
    Boards = get_all_board(),
    lists:map(fun save_board_to_db/1, Boards).

save_board_to_db(#rboard{rank_id=RankID}=RBoard) ->
    db:kv_insert(rank, RankID, RBoard).


get_my_rank(RankID, UID, RList) when RankID == ?RANK_GUILD_BATTLE_POWER
									 orelse RankID == ?RANK_GUILD_BATTLE_PROSPER ->
    % 帮派排序依据不是UID, 需要取出自己的帮派ID来获取自己排名
    GuildID = player:get_guild_id(UID),
    get_my_rank(GuildID, RList);

get_my_rank(_, UID, RList) ->
    get_my_rank(UID, RList).

get_my_rank(UID, [Ranker|T]) ->
    case uid(Ranker) of
        UID ->
            RankPos = rank_pos(Ranker),
            erlang:element(RankPos, Ranker);
        _ ->
            get_my_rank(UID, T)
    end;
get_my_rank(_UID, []) ->
    0.

%%得到等级排行榜的榜单第一名wjc 360005
get_max_lv(RankId) ->
  #rboard{rank_list=List} = get_release_board(RankId),
  case lists:keyfind(1,2,List) of
   RankData  ->
     RankData#ranker.info div 1000;
    false ->
      40
  end.

%data_guild_dungeon_rank_reward
send_rank_goods(RankId) ->
	#rboard{rank_list=List} = get_release_board(RankId),
	
	F = fun(#ranker{rank = Rank,
					player_id = PlayId,
					player_name = _Name,
					p1 = _Sex,
					p2 = _Faction,
					info = _Info,
					viplv = _VipLv},Acc) ->
				[{Rank,PlayId}] ++ Acc
		end,
	RankList = lists:foldl(F, [], List),
%% 	F2 = fun({Rank,PlayId},{Rank2,PlayId2}) ->
%% 				 Rank < Rank2
%% 		 end,
%% 	RankList2 = lists:sort(F2, RankList),
	F3 = fun({Rank,PlayId}) ->
				 Reward = if 
							  Rank < 6 ->
								  GuildReward = data_guild_dungeon_rank_reward:get(Rank),
								  No =  GuildReward#guild_dungeon_rank_reward.reward,
								  Rewardpkg = data_reward_pkg:get(No),
								  GoodsLists = Rewardpkg#reward_pkg.goods_list,
								  F4 = fun({_Q, RewardNo, Count, _, _ ,_},Acc4) ->
											   [{RewardNo,?BIND_ALREADY,Count}|Acc4]
									   end,
								  lists:foldl(F4, [], GoodsLists);
							  11   < Rank  ->
								  GuildReward = data_guild_dungeon_rank_reward:get(6),
								  No = GuildReward#guild_dungeon_rank_reward.reward,
								  Rewardpkg = data_reward_pkg:get(No),
								  GoodsLists = Rewardpkg#reward_pkg.goods_list,
								  F4 = fun({_Q, RewardNo, Count, _, _ ,_},Acc4) ->
											   [{RewardNo,?BIND_ALREADY,Count}|Acc4]
									   end,
								  lists:foldl(F4, [], GoodsLists);
							  51 < Rank ->
								  GuildReward = data_guild_dungeon_rank_reward:get(7),
								  No = GuildReward#guild_dungeon_rank_reward.reward,
								  Rewardpkg = data_reward_pkg:get(No),
								  GoodsLists = Rewardpkg#reward_pkg.goods_list,
								  F4 = fun({_Q, RewardNo, Count, _, _ ,_},Acc4) ->
											   [{RewardNo,?BIND_ALREADY,Count}|Acc4]
									   end,
								  lists:foldl(F4, [], GoodsLists);
							  101 < Rank  ->
								  GuildReward = data_guild_dungeon_rank_reward:get(8),
								  No = GuildReward#guild_dungeon_rank_reward.reward,
								  Rewardpkg = data_reward_pkg:get(No),
								  GoodsLists = Rewardpkg#reward_pkg.goods_list,
								  F4 = fun({_Q, RewardNo, Count, _, _ ,_},Acc4) ->
											   [{RewardNo,?BIND_ALREADY,Count}|Acc4]
									   end,
								  lists:foldl(F4, [], GoodsLists);
							  301 < Rank  ->
								  GuildReward = data_guild_dungeon_rank_reward:get(9),
								  No = GuildReward#guild_dungeon_rank_reward.reward,
								  Rewardpkg = data_reward_pkg:get(No),
								  GoodsLists = Rewardpkg#reward_pkg.goods_list,
								  F4 = fun({_Q, RewardNo, Count, _, _ ,_},Acc4) ->
											   [{RewardNo,?BIND_ALREADY,Count}|Acc4]
									   end,
								  lists:foldl(F4, [], GoodsLists);
							  300 < Rank  ->
								  GuildReward = data_guild_dungeon_rank_reward:get(10),
								  No = GuildReward#guild_dungeon_rank_reward.reward,
								  Rewardpkg = data_reward_pkg:get(No),
								  GoodsLists = Rewardpkg#reward_pkg.goods_list,
								  F4 = fun({_Q, RewardNo, Count, _, _ ,_},Acc4) ->
											   [{RewardNo,?BIND_ALREADY,Count}|Acc4]
									   end,
								  lists:foldl(F4, [], GoodsLists);
							  Rank < 1001  -> 
								  GuildReward = data_guild_dungeon_rank_reward:get(11),
								  No = GuildReward#guild_dungeon_rank_reward.reward,
								  Rewardpkg = data_reward_pkg:get(No),
								  GoodsLists = Rewardpkg#reward_pkg.goods_list,
								  F4 = fun({_Q, RewardNo, Count, _, _ ,_},Acc4) ->
											   [{RewardNo,?BIND_ALREADY,Count}|Acc4]
									   end,
								  lists:foldl(F4, [], GoodsLists);
							  Rank > 1000 ->
								  GuildReward = data_guild_dungeon_rank_reward:get(12),
								  No = GuildReward#guild_dungeon_rank_reward.reward,
								  Rewardpkg = data_reward_pkg:get(No),
								  GoodsLists = Rewardpkg#reward_pkg.goods_list,
								  F4 = fun({_Q, RewardNo, Count, _, _ ,_},Acc4) ->
											   [{RewardNo,?BIND_ALREADY,Count}|Acc4]
									   end,
								  lists:foldl(F4, [], GoodsLists)
						  end,
		 Title =unicode:characters_to_list(data_special_config:get(guild_dungeon_mail_title),utf8),
         Content = unicode:characters_to_list(data_special_config:get(guild_dungeon_mail_content),utf8),

		 lib_mail:send_sys_mail(PlayId, util:to_binary(Title), util:to_binary(Content), Reward, [?LOG_GUILD_DUNGEON, "reward"])
		 end,
					 
	lists:foreach(F3, RankList),
	reset_board(?RANK_GUILD_COLLECT),
	reset_board(?RANK_GUILD_CONTRIBUTION),
	reset_board(?RANK_GUILD_DAMAGE),
	reset_board(?RANK_GUILD_KILL),
	reset_release_board(?RANK_GUILD_COLLECT),
	reset_release_board(?RANK_GUILD_CONTRIBUTION),
	reset_release_board(?RANK_GUILD_DAMAGE),
	reset_release_board(?RANK_GUILD_KILL).
	

%% 向玩家发送排行榜信息
send_rank(UID, RankID, Page) ->
    case data_rank:get(RankID) of
        #data_rank{show_size=MaxShowSize} ->
            #rboard{rank_list=RList} = get_release_board(RankID),
            ShowList = lists:sublist(RList, 1, MaxShowSize),
            ShowSize = length(ShowList),
            MyRank = get_my_rank(RankID, UID, ShowList),
			RankDataCurrent = get_rank_data_current(UID, RankID),
            RankPage = rank_page(ShowList, Page),
            PT = get_pt(RankID),
            {ok, BinData} = pt_22:write(PT, [RankID, MyRank, RankDataCurrent, ShowSize, RankPage]),
            lib_send:send_to_uid(UID, BinData);
        _ ->
            ?WARNING_MSG("Invalid rank id ~w", [RankID])
    end.

%% 取第Page页, Page从1开始
rank_page(RankList, Page) ->
    Start = (Page - 1) * ?RANK_PER_PAGE + 1,
    case length(RankList) of
        Len when Len >= Start ->
            lists:sublist(RankList, Start, ?RANK_PER_PAGE);
        _ ->
            []
    end.



%% 开服检查数据库
init_rank() ->
    read_db_rank().


read_db_rank() ->
    Fun = fun(#rboard{}=RBoard, N) -> set_board(RBoard#rboard{size = length(RBoard#rboard.rank_list)}), N + 1 end,
    _Num = db:kv_foldl(Fun, 0, rank),
    release_rank(),
    ?INFO_MSG("Read ~w rank board from database", [_Num]).

%% 缓存物品信息(因为玩家不在线查不到物品详情, 故在排行榜中特殊处理做缓存)
%% cache_goods(#rboard{rank_id=?RANK_EQUIP_BATTLE_POWER,
%%                     rank_list=RList}) ->
%%     lists:foreach(fun set_goods_cache/1, RList);

cache_goods(#rboard{rank_id=RankID,
					rank_list=RList}) when RankID == ?RANK_EQUIP_WUQI
											   orelse RankID == ?RANK_EQUIP_TOUKUI
											   orelse RankID == ?RANK_EQUIP_YIFU
											   orelse RankID == ?RANK_EQUIP_XIEZI
											   orelse RankID == ?RANK_EQUIP_XIANGLIAN
											   orelse RankID == ?RANK_EQUIP_YAODAI ->
	lists:foreach(fun set_goods_cache/1, RList);


cache_goods(_) ->
    pass.

set_goods_cache(#ranker{p1=GoodsID, ext=Ext}) ->
    Ext1 = ?IF(is_list(Ext), Ext, []), % 防止ext为默认值0
    RecInfo = record_info(fields, goods),
    Goods = util:pl_to_rec(Ext1, RecInfo, #goods{}),
    erlang:put({goods, GoodsID}, Goods).

get_goods_cache(GoodsID) ->
    erlang:get({goods, GoodsID}).

send_equip_detail(UID, GoodsID) ->
    {ok, Bin} =
        case get_goods_cache(GoodsID) of
            #goods{} = Goods ->
                pt_15:write(?PT_GET_GOODS_DETAIL_ON_RANK, Goods);
            _ ->
                pt_22:write(?PT_RANK_EQUIP_DETAIL, [0])
        end,
    lib_send:send_to_uid(UID, Bin).

%% VIP升级通知排行榜处理
vip_up(UID, Lv) ->
    Boards = get_all_board(),
    [set_board(vip_up(UID, Lv, B)) || B <- Boards],
    ok.

vip_up(UID, Lv, #rboard{rank_list=RList}=Board) ->
    RList1 = vip_up(UID, Lv, RList, []),
    Board#rboard{rank_list=RList1}.

vip_up(UID, Lv, [H|T], Acc) ->
    H1 =
        case uid(H) of
            UID ->
                erlang:setelement(vip_pos(H), H, Lv);
            _ ->
                H
        end,
    vip_up(UID, Lv, T, [H1|Acc]);
vip_up(_UID, _Lv, [], Acc) ->
    lists:reverse(Acc).


save_as_history(RankID) when is_integer(RankID) ->
    #rboard{} = RBoard = get_release_board(RankID),
    proc_lib:spawn(fun()-> save_as_history(RBoard) end);

save_as_history(#rboard{rank_list=[]}) ->
    ok;
save_as_history(#rboard{rank_id=RankID, rank_list=RList}) ->
    F = fun(#ranker{rank=Rank, player_id=UID, info=Info}, Acc) ->
                [{RankID, Rank, UID, Info}|Acc];
            (_, Acc) ->
                Acc
        end,
    Data = lists:foldl(F, [], RList),
    SQL = make_sql(Data, []),

    db_esql:execute(?DB, SQL).


make_sql([H|T], Acc) ->
    make_sql(T, [make_val(H)|Acc]);
make_sql([], Acc) ->
    Values = string:join(Acc, ","),
    "INSERT INTO `rank_history` (`rank_id`, `rank`, `player_id`, `data`) VALUES " ++ Values.

make_val({RankID, Rank, UID, Info}) ->
    lists:concat(["(", str(RankID), ",", str(Rank), ",", str(UID), ",", str(Info), ")"]).

str(Int) when is_integer(Int) ->
    integer_to_list(Int);
str(Val) ->
    mysql:encode(util:term_to_bitstring(Val)).