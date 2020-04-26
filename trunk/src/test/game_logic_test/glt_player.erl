%%%---------------------------------------------
%%% @Module  : glt_player (game logic test: player)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.10.10
%%% @Description: 玩家自身信息的相关测试
%%%---------------------------------------------
-module(glt_player).

-compile(export_all).

-include("common.hrl").
-include("test_client_base.hrl").
-include("pt_13.hrl").





%% （进入游戏后）获取自己的简要信息
get_my_brief_info() ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_PLYR_GET_MY_BRIEF, Data)),
    ok.


%% （进入游戏后）获取自己的详细信息
get_my_detail_info() ->
    Socket = get(?PDKN_CONN_SOCKET),
    PS = test_client_base:get_client_ps(),
    Data = <<(PS#client_ps.id) : 64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_PLYR_GET_INFO_DETAILS, Data)),
    ok.




%% 分配自由天赋点（手动加天赋点）
allot_free_talent_points() ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<5:16,   1:8, 1:16,   2:8, 2:16,   3:8, 1:16,  4:8, 1:16,  5:8, 1:16>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_PLYR_ALLOT_FREE_TALENT_POINTS, Data)),
    ok.



%% 手动升级
manual_upgrade() ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_PLYR_MANUAL_UPGRADE, Data)),
    ok.


get_my_day_reward_info() ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_PLYR_GET_ONLINE_REWARD_INFO, Data)),
    ok.



query_my_opened_sys_list() ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_PLYR_QRY_MY_OPENED_SYS_LIST, Data)),
    ok.



%% 获取自己的简要信息
read(?PT_PLYR_GET_MY_BRIEF, Bin, _Fd) ->
	io:format("client read: PT_PLYR_GET_MY_BRIEF~n", []),
    <<SceneId:32, SceneNo:32, X:16, Y:16, Hp:32, HpLim:32, Mp:32, MpLim:32, Exp:32, ExpLim:32, Yuanbao:32, BindYuanbao:32, 
       GameMoney:32, BindGameMoney:32, _Feat:32, MoveSpeed:16, Bin2/binary>> = Bin,

    {GuildName, Bin3} = pt:read_string(Bin2),
    {Title, _Bin4} = pt:read_string(Bin3),

    put(?PDKN_LOGIN_SCENE_ID, SceneId),

    PS = test_client_base:get_client_ps(),
    test_client_base:set_client_ps(PS#client_ps{
                    					scene_id = SceneId,
                    					scene_no = SceneNo,
                    					x = X,
                    					y = Y,
                    					hp = Hp,
                    					hp_lim = HpLim,
                    					mp = Mp,
                    					mp_lim = MpLim,
                    					exp = Exp,
                    					exp_lim = ExpLim,
                    					yuanbao = Yuanbao,
                    					bind_yuanbao = BindYuanbao,
                    					gamemoney = GameMoney,
                    					bind_gamemoney = BindGameMoney,
                    					move_speed = MoveSpeed,
                    					guild_name = GuildName,
                    					title = Title
                    					}),
    test_client_base:show_client_ps();
    




%% 获取自己的详细信息
read(?PT_PLYR_GET_INFO_DETAILS, Bin, _Fd) ->
	io:format("client read: PT_PLYR_GET_INFO_DETAILS~n", []),
    <<_PlayerId:64, Race:8, Faction:8, Sex:8, Lv:8, Exp:32, ExpLim:32, Hp:32, HpLim:32, Mp:32, MpLim:32, PhyAtt:32, MagAtt:32, PhyDef:32, MagDef:32,
    	Hit:32, Dodge:32, Crit:32, Ten:32, Anger:32, AngerLim:32, Luck:32, ActSpeed:32, MoveSpeed:16, 
    	Talent_Str:16, Talent_Con:16, Talent_Sta:16, Talent_Spi:16, Talent_Agi:16, FreeTalentPoints:16, 
        BattlePower:32, GuildId:64, _SealHit:32, _SealResis:32>> = Bin,

    PS = test_client_base:get_client_ps(),
    
    test_client_base:set_client_ps(PS#client_ps{
    									race = Race,
    									faction = Faction,
    									sex = Sex,
    									lv = Lv,
					
    									exp = Exp,
                    					exp_lim = ExpLim,
					
                    					hp = Hp,
                    					hp_lim = HpLim,
                    					mp = Mp,
                    					mp_lim = MpLim,
                    					
                    					phy_att = PhyAtt,
                    					mag_att = MagAtt,
					
                    					phy_def = PhyDef,
                    					mag_def = MagDef,
					
                    					hit = Hit,
                    					dodge = Dodge,
                    					crit = Crit,
                    					ten = Ten,
					
                    					anger = Anger,
                    					anger_lim = AngerLim,
					
                    					luck = Luck,
                    					act_speed = ActSpeed,
                    					move_speed = MoveSpeed,
					
                    					talent_str = Talent_Str,
                    					talent_con = Talent_Con,
                    					talent_sta = Talent_Sta,
                    					talent_spi = Talent_Spi,
                    					talent_agi = Talent_Agi,
                    					free_talent_points = FreeTalentPoints,

                                        battle_power = BattlePower,
                                        
                                        guild_id = GuildId
                    					}),
    test_client_base:show_client_ps();



read(?PT_PLYR_GET_ONLINE_REWARD_INFO, Bin, _Fd) ->
    <<CurNo:32, LastGetTime:32>> = Bin,
    io:format("client read: PT_PLYR_GET_ONLINE_REWARD_INFO: ~p ~p~n", [CurNo, LastGetTime]);



read(?PT_PLYR_QRY_MY_OPENED_SYS_LIST, Bin, _Fd) ->
    {SysCodeList, <<>>} = pt:read_array(Bin, [u8]),
    io:format("client read: PT_PLYR_QRY_MY_OPENED_SYS_LIST, SysCodeList: ~p~n", [SysCodeList]);


read(Cmd, Bin, _Fd) ->
    io:format("[glt_player] default read handler!!!!!~n", []),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).
