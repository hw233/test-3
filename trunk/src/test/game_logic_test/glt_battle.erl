%%%---------------------------------------------
%%% @Module  : glt_battle (game logic test: battle)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.8.1
%%% @Description: 战斗系统测试
%%%---------------------------------------------
-module(glt_battle).

-compile(export_all).


-include("common.hrl").
-include("test_client_base.hrl").
-include("battle.hrl").
-include("record/battle_record.hrl").
-include("pt_20.hrl").





%% 触发打怪
%% @para: 明雷怪id
start_mf(MonId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: start_mf~n", []),
    Data = <<MonId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_START_MF, Data)),
    ok.



%% 触发pk
%% @para: 明雷怪id
start_pk(TargetPlayerId, PK_Type) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: start_pk~n", []),
    Data = <<TargetPlayerId:64, PK_Type:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_START_PK, Data)),
    ok.


%% 快速进入游戏并立即触发打怪
fast_enter_game_and_start_mf(Host, Port, AccName, PlayerId, BMonGroupNo) ->
    test_client_base:fast_enter_game(Host, Port, AccName, PlayerId),
    timer:sleep(50),
    GMCmd= "@trigger_mf " ++ integer_to_list(BMonGroupNo), 
    glt_chat:chat_world(GMCmd).
    



%% 强行退出战斗， 仅用于调试
force_quit_battle() ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_DBG_FORCE_QUIT_BATTLE, Data)),
    ok.






%% 查询战场描述信息
query_battle_field_desc() ->
	Socket = get(?PDKN_CONN_SOCKET),
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_QRY_BATTLE_FIELD_DESC, <<>>)),
    ok.


%% 查询bo身上某buff的信息
query_bo_buff_info(TargetBoId, BuffNo) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<TargetBoId:16, BuffNo:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_QRY_BO_BUFF_INFO, Data)),
    ok.



%% 
query_skill_usable_info(QueryType) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<QueryType:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_QUERY_SKILL_USABLE_INFO, Data)),
    ok.



%% 下达空指令
nop_cmd() ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_NOP_CMD, Data)),
    ok.


%% 通知服务端：播放战报完毕
notify_show_br_done() ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_C2S_NOTIFY_SHOW_BR_DONE, Data)),
    ok.


%% 下达指令；使用技能
%% @para: ForBoId => 表示是为哪个bo下指令
%%        SkillId => 技能id（0表示是普通攻击）
%%        TargetBoId => 攻击目标（战斗对象id）
use_skill(ForBoId, SkillId, TargetBoId) ->
	Socket = get(?PDKN_CONN_SOCKET),
	Data = <<ForBoId:16, SkillId:32, TargetBoId:16>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_USE_SKILL, Data)),
    ok.


%% 下达指令：使用物品
use_goods(Type, GoodsId, TargetBoId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<Type:8, GoodsId:64, TargetBoId:16>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_USE_GOODS, Data)),
    ok.


%% 下达指令：逃跑
escape(Type) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<Type:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_ESCAPE, Data)),
    ok.



%% 下达指令：防御
defend(Type) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<Type:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_DEFEND, Data)),
    ok.


%% 下达指令：保护
protect_others(Type, TargetBoId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<Type:8, TargetBoId:16>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_PROTECT_OTHERS, Data)),
    ok.

%% 下达指令：召唤宠物
summon_partner(Type, PartnerId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<Type:8, PartnerId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_SUMMON_PARTNER, Data)),
    ok.


%% 请求自动战斗
req_auto_battle() ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_REQ_AUTO_BATTLE, Data)),
    ok.



%% 取消自动战斗
cancel_auto_battle() ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_CANCEL_AUTO_BATTLE, Data)),
    ok.




%% 获取战斗对象的信息，仅用于调试！
dbg_get_bo_info(BoId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<BoId:16>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BT_DBG_GET_BO_INFO, Data)),
    ok.







%% 通知客户端：战斗开始
read(?PT_BT_NOTIFY_BATTLE_START, <<>>, _Fd) ->
    io:format("client read: PT_BT_NOTIFY_BATTLE_START~n", []);
    % file:write(Fd, io_lib:format("战斗开始！~n", []));




%% 通知客户端：战斗结束
read(?PT_BT_NOTIFY_BATTLE_FINISH, <<WinSide:8>>, _Fd) ->
    io:format("client read: PT_BT_NOTIFY_BATTLE_FINISH, WinSide: ~p~n", [WinSide]);
    % file:write(Fd, io_lib:format("战斗结束！胜利方：~s~n", [to_win_side_string(WinSide)]));






%%	   BattleId             u32       战斗id
%%     BattleType           u8        战斗类型
%%     BattleSubType        u8        战斗子类型
%%     MyBoId               u16       玩家本人的战斗对象id
%%     array(                       主队的战斗对象信息（打怪时，玩家方是在主队，怪物方是在客队）
%%            BoId          u16       战斗对象id
%%            BoType        u8        战斗对象类型（1：玩家，2：宠物，3：npc，4：怪物，5：boss） 
%%            Pos           u8        战斗位置（1~15）
%%            name          string    名字
%%            sex           u8        性别（1：男，2：女）
%%            race          u8        种族
%%            faction       u8        门派（对怪物无意义）
%%            lv            u8        等级
%%            ParentObjId   u32       父对象id（对于玩家bo，表示对应的玩家id，对于怪物或宠物bo，表示对应的模板编号）
%%            hp            u32       当前血量
%%            hp_lim        u32       血量上限
%%            mp            u32       当前魔法值
%%            mp_lim        u32       魔法上限
%%            anger         u16       当前怒气值
%%            anger_lim     u16       怒气上限
%%	        )
%%     array(                       客队的战斗对象信息（格式同上）
%%            ...
%%          )




%% 查询战场描述信息
read(?PT_BT_QRY_BATTLE_FIELD_DESC, Bin, _Fd) ->
    io:format("read PT_BT_QRY_BATTLE_FIELD_DESC...~n"),
    % file:write(Fd, io_lib:format("recv PT_BT_QRY_BATTLE_FIELD_DESC.......", [])),

	<<BattleId:32, BattleType:8, BattleSubType:8, MyBoId:16, HostSideBoCount:16, AllBoInfos/binary>> = Bin,
	io:format("client read: PT_BT_QRY_BATTLE_FIELD_DESC, BattleId=~p, BattleType=~p, BattleSubType=~p, MyBoId=~p~n", 
					[BattleId, BattleType, BattleSubType, MyBoId]),
    
    F = fun(Bin0) ->
        	<<BoId:16, BoType:8, MyOwnerPlayerBoId:16, Pos:8, Bin1/binary>> = Bin0,
        	{Name, RestBin} = pt:read_string(Bin1),
        	<<Sex:8, Race:8, Faction:8, Lv:8, ParentObjId:64, ParentParNo:32, Hp:32, HpLim:32, Mp:32, MpLim:32, Anger:32, AngerLim:32, 
                  Weapon:32, HeadWear:32, Clothes:32, BackWear:32, ParCultivateLv:8, ParEvolveLv:8, ParNature:8, ParQuality:8, 
                  IsMainPar:8, IsInvisible:8, InvisibleExpireRound:16, 
                  SuitNo:8, GraphTitle:32, TextTitle:32, RestBin2/binary>> = RestBin,
            {UserDefTitle, RestBin3} = pt:read_string(RestBin2),
            <<OnlineFlag:8, IsPlotBo:8, CanBeCtrled:8, RestBin4/binary>> = RestBin3,
        	io:format("bo info: BoId=~p BoType=~p MyOwnerPlayerBoId=~p Pos=~p Name=~s Sex=~p Race=~p Faction=~p Lv=~p ParentObjId=~p ParentParNo=~p "
        				"Hp=~p HpLim=~p Mp=~p MpLim=~p Anger=~p AngerLim=~p Weapon=~p HeadWear=~p Clothes=~p BackWear=~p ParCultivateLv=~p ParEvolveLv=~p ParNature=~p ParQuality=~p "
                        "IsMainPar=~p IsInvisible=~p InvisibleExpireRound=~p "
                        "SuitNo=~p GraphTitle=~p TextTitle=~p UserDefTitle=~p "
                        "OnlineFlag=~p IsPlotBo=~p CanBeCtrled=~p~n", 
        				[BoId, BoType, MyOwnerPlayerBoId, Pos, Name, Sex, Race, Faction, Lv, ParentObjId, ParentParNo, Hp, HpLim, Mp, MpLim, Anger, AngerLim,
                            Weapon, HeadWear, Clothes, BackWear, ParCultivateLv, ParEvolveLv, ParNature, ParQuality,
                            IsMainPar, IsInvisible, InvisibleExpireRound,
                            SuitNo, GraphTitle, TextTitle, UserDefTitle,
                            OnlineFlag, IsPlotBo, CanBeCtrled]),

            % file:write(Fd, io_lib:format("    战斗对象: id=~p 类型=~s 位置=~p 名字=~s 性别=~s 种族=~s 门派=~s 等级=~p 父对象id=~p 血量=~p 血量上限=~p 魔法=~p 魔法上限=~p 怒气=~p 怒气上限=~p~n", 
            %                             [BoId, to_bo_type_string(BoType), Pos, Name, to_sex_string(Sex), to_race_string(Race), 
            %                              to_faction_string(Faction), Lv, ParentObjId, Hp, HpLim, Mp, MpLim, Anger, AngerLim])),
        	RestBin4
    	end,
    
    io:format("***host side bo list***:~n"),
    % file:write(Fd, io_lib:format("战场信息：~n", [])),
    % file:write(Fd, io_lib:format("(1)主队信息：~n", [])),
    RestBoInfos = test_client_base:for(0, HostSideBoCount, F, AllBoInfos),

    io:format("***guest side bo list***:~n"),
    % file:write(Fd, io_lib:format("(2)客队信息：~n", [])),
    <<GuestSideBoCount:16, GuestSideBoInfos/binary>> = RestBoInfos,
    <<>> = test_client_base:for(0, GuestSideBoCount, F, GuestSideBoInfos);



%%
read(?PT_BT_NOTIFY_TALK_AI_INFO, Bin, _Fd) ->
    io:format("read PT_BT_NOTIFY_TALK_AI_INFO...~n"),
    <<Len:16, Bin2/binary>> = Bin,
    F = fun(Bin__) ->
            <<BoId:16, Bin2__/binary>> = Bin__,
            {EleList, Bin3__} = pt:read_array(Bin2__, [u8, u16]),
            F__ = fun({WhenToTalk, TalkCont}) ->
                      io:format("    BoId=~p WhenToTalk=~p TalkCont=~p~n", [BoId, WhenToTalk, TalkCont])
                  end,
            lists:foreach(F__, EleList),
            Bin3__
        end,
    <<>> = test_client_base:for(0, Len, F, Bin2);




%% 
read(?PT_BT_QRY_BO_BUFF_INFO, Bin, _Fd) ->
    io:format("read PT_BT_QRY_BO_BUFF_INFO...~n"),
    <<RetCode:8, BoId:16, BuffNo:32, ExpireRound:16, OverlapCount:8, Para1_Type:8, Para1_Value:32, Para2_Type:8, Para2_Value:32>> = Bin,
    io:format("client read: PT_BT_QRY_BO_BUFF_INFO, RetCode=~p, BoId=~p, BuffNo=~p, ExpireRound=~p, "
               "OverlapCount=~p, Para1_Type=~p, Para1_Value=~p, Para2_Type=~p, Para2_Value=~p~n", 
            [RetCode, BoId, BuffNo, ExpireRound, OverlapCount, Para1_Type, Para1_Value, Para2_Type, Para2_Value]);
    
    






%% 
read(?PT_BT_QUERY_SKILL_USABLE_INFO, Bin, _Fd) ->
    <<QueryType:8, Bin2/binary>> = Bin,
    io:format("read PT_BT_QUERY_SKILL_USABLE_INFO, QueryType=~p~n", [QueryType]),
    {EleList, <<>>} = pt:read_array(Bin2, [u32, u8, u8]),
    F = fun({SkillId, IsUsable, LeftCDRounds}) ->
            io:format("    SkillId=~p, IsUsable=~p, LeftCDRounds=~p~n", [SkillId, IsUsable, LeftCDRounds])
        end,
    lists:foreach(F, EleList);



%% 通知客户端：某战斗对象已经准备好了
read(?PT_BT_NOTIFY_BO_IS_READY, Bin, _Fd) ->
	<<BoId:16, CmdType:8, CmdPara:64>> = Bin,
	io:format("client read: PT_BT_NOTIFY_BO_IS_READY, BoId=~p, CmdType=~p, CmdPara=~p~n", [BoId, CmdType, CmdPara]);
    % file:write(Fd, io_lib:format("玩家~p当前回合已经准备好了~n", [BoId]));




read(?PT_BT_S2C_NOTIFY_BO_SHOW_BR_DONE, <<BoId:16>>, _Fd) ->
    io:format("client read: PT_BT_S2C_NOTIFY_BO_SHOW_BR_DONE, BoId=~p~n", [BoId]);

    

read(?PT_BT_NOTIFY_BO_ONLINE_FLAG_CHANGED, <<BoId:16, NewFlag:8>>, _Fd) ->
    io:format("client read: PT_BT_NOTIFY_BO_ONLINE_FLAG_CHANGED, BoId=~p, NewFlag=~p~n", [BoId, NewFlag]);




%% 通知客户端：当前回合的行动开始
read(?PT_BT_NOTIFY_ROUND_ACTION_BEGIN, <<>>, _Fd) ->
	io:format("client read: PT_BT_NOTIFY_ROUND_ACTION_BEGIN~n", []);
    % file:write(Fd, io_lib:format("当前回合的行动开始：~n", []));


%% 通知客户端：当前回合的行动结束
read(?PT_BT_NOTIFY_ROUND_ACTION_END, <<>>, _Fd) ->
	io:format("client read: PT_BT_NOTIFY_ROUND_ACTION_END~n", []);
    % file:write(Fd, io_lib:format("当前回合的行动结束！~n", []));



	
%% 通知客户端：新回合开始
read(?PT_BT_NOTIFY_NEW_ROUND_BEGIN, <<NewRoundCounter:16>>, _Fd) ->
	io:format("client read: PT_BT_NOTIFY_NEW_ROUND_BEGIN, NewRoundCounter=~p~n", [NewRoundCounter]);
    % file:write(Fd, io_lib:format("新回合开始，当前回合计数：~p，请输入指令...~n", [NewRoundCounter]));




%% 通知客户端：buff结算开始
read(?PT_BT_NOTIFY_SETTLE_BUFF_BEGIN, <<>>, _Fd) ->
    io:format("client read: PT_BT_NOTIFY_SETTLE_BUFF_BEGIN~n");


%% 通知客户端：buff结算结束
read(?PT_BT_NOTIFY_SETTLE_BUFF_END, <<>>, _Fd) ->
    io:format("client read: PT_BT_NOTIFY_SETTLE_BUFF_END~n");
    




read(?PT_BT_NOTIFY_BO_BUFF_CHANGED, Bin, _Fd) ->
    <<BoId:16, Type:8, Bin2/binary>> = Bin,
    F = fun(Type_) ->
            case Type_ of
                1 -> add_buff;
                2 -> remove_buff;
                3 -> update_buff
            end
        end,
    io:format("client read: PT_BT_NOTIFY_BO_BUFF_CHANGED, BoId=~p, Type:~p~n", [BoId, F(Type)]),
    parse_buff_details(Bin2);



read(?PT_BT_NOTIFY_BO_ATTR_CHANGED, Bin, _Fd) ->
    <<BoId:16, DieStatus:8, Bin2/binary>> = Bin,
    io:format("client read: PT_BT_NOTIFY_BO_ATTR_CHANGED, BoId=~p DieStatus=~p~n", [BoId, DieStatus]),

    {EleList, <<>>} = pt:read_array(Bin2, [u8, u32]),

    F = fun({AttrCode, NewValue}) ->
            case AttrCode of
                1 -> io:format("    NewHp=~p~n", [NewValue]);
                2 -> io:format("    NewMp=~p~n", [NewValue])
            end
        end,
    lists:foreach(F, EleList);



read(?PT_BT_NOTIFY_BO_DIED, Bin, _Fd) ->
    <<BoCount:16, Bin2/binary>> = Bin,
    io:format("client read: PT_BT_NOTIFY_BO_DIED, BoCount=~p~n", [BoCount]),
    F = fun(Bin__) ->
            <<BoId:16, DieStatus:8, Bin2__/binary>> = Bin__,
            {RemovedBuffNoList, Bin3__} = pt:read_array(Bin2__, [u32]),
            io:format("      BoId=~p, DieStatus=~p, RemovedBuffNoList=~p~n", [BoId, DieStatus, RemovedBuffNoList]),
            Bin3__
        end,
    <<>> = test_client_base:for(0, BoCount, F, Bin2);



%% 战报--执行物理攻击
read(?PT_BT_NOTIFY_BR_DO_PHY_ATT, Bin, Fd) ->
    read_battle_report(Bin, Fd);


%% 战报--执行法术攻击
read(?PT_BT_NOTIFY_BR_DO_MAG_ATT, Bin, Fd) ->
    % io:format("PT_BT_NOTIFY_BR_DO_MAG_ATT, Bin: ~p~n~n", [Bin]),

    read_battle_report(Bin, Fd);


%% 战报--施法
read(?PT_BT_NOTIFY_BR_CAST_BUFFS, Bin, Fd) ->
    read_battle_report(Bin, Fd);



%% 战报--逃跑
read(?PT_BT_NOTIFY_BR_ESCAPE, Bin, Fd) ->
    read_battle_report(Bin, Fd);


%% 战报--治疗
read(?PT_BT_NOTIFY_BR_HEAL, Bin, Fd) ->
    read_battle_report(Bin, Fd);


%% 战报--使用物品
read(?PT_BT_NOTIFY_BR_USE_GOODS, Bin, Fd) ->
    read_battle_report(Bin, Fd);

%% 战报--召唤bo
read(?PT_BT_NOTIFY_BR_SUMMON, Bin, Fd) ->
    read_battle_report(Bin, Fd);



%% 
read(?PT_BT_NOP_CMD, Bin, _Fd) ->
    <<RetCode:8, Type:8>> = Bin,
    io:format("client read: PT_BT_NOP_CMD, RetCode=~p Type=~p~n", [RetCode, Type]);
    % file:write(Fd, io_lib:format("使用技能ok~n", []));

%% 使用技能
read(?PT_BT_USE_SKILL, Bin, _Fd) ->
	<<RetCode:8, ForBoId:16, SkillId:32, TargetBoId:16>> = Bin,
	io:format("client read: PT_BT_USE_SKILL, RetCode=~p ForBoId=~p SkillId=~p TargetBoId=~p~n", [RetCode, ForBoId, SkillId, TargetBoId]);
    % file:write(Fd, io_lib:format("使用技能ok~n", []));


read(?PT_BT_USE_GOODS, Bin, _Fd) ->
    <<RetCode:8, Type:8, GoodsId:64, TargetBoId:16>> = Bin,
    io:format("client read: PT_BT_USE_GOODS, RetCode=~p Type=~p GoodsId=~p TargetBoId=~p~n", [RetCode, Type, GoodsId, TargetBoId]);

read(?PT_BT_SUMMON_PARTNER, Bin, _Fd) ->
    <<RetCode:8, Type:8, PartnerId:64>> = Bin,
    io:format("client read: PT_BT_SUMMON_PARTNER, RetCode=~p Type=~p PartnerId=~p~n", [RetCode, Type, PartnerId]);

%% 逃跑
read(?PT_BT_ESCAPE, Bin, _Fd) ->
    <<RetCode:8, Type:8>> = Bin,
    io:format("client read: PT_BT_ESCAPE, RetCode=~p, Type=~p~n", [RetCode, Type]);


%% 防御
read(?PT_BT_DEFEND, Bin, _Fd) ->
    <<RetCode:8, Type:8>> = Bin,
    io:format("client read: PT_BT_DEFEND, RetCode=~p, Type=~p~n", [RetCode, Type]);



%% 
read(?PT_BT_PROTECT_OTHERS, Bin, _Fd) ->
    <<RetCode:8, Type:8, TargetBoId:16>> = Bin,
    io:format("client read: PT_BT_PROTECT_OTHERS, RetCode=~p, Type=~p, TargetBoId=~p~n", [RetCode, Type, TargetBoId]);

%% 
read(?PT_BT_REQ_AUTO_BATTLE, Bin, _Fd) ->
    <<RetCode:8>> = Bin,
    io:format("client read: PT_BT_REQ_AUTO_BATTLE, RetCode=~p~n", [RetCode]);



%% 
read(?PT_BT_CANCEL_AUTO_BATTLE, Bin, _Fd) ->
    <<RetCode:8>> = Bin,
    io:format("client read: PT_BT_CANCEL_AUTO_BATTLE, RetCode=~p~n", [RetCode]);
    


%% 获取战斗对象的信息，仅用于调试！
read(?PT_BT_DBG_GET_BO_INFO, Bin, _Fd) ->
    {BoInfo, <<>>} = pt:read_string(Bin),
    io:format("client read: PT_BT_DBG_GET_BO_INFO~n~s~n", [BoInfo]); 



read(Cmd, Bin, _Fd) ->
    io:format("[glt_battle] default read handler!!!!!~n"),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).








%% 战报
read_battle_report(Bin, _Fd) ->
    <<CurActorId:16, CmdType:8, CmdPara:64, CurPickTarget:16, ActionCount:16, ActionInfos/binary>> = Bin,
    io:format("client read: BATTLE REPORT, CurActorId=~p, CmdType=~p, CmdPara=~p, CurPickTarget=~p, ActionCount=~p~n", 
                    [CurActorId, CmdType, CmdPara, CurPickTarget, ActionCount]),
    
    F = fun(Bin_) ->
            <<ReportType:8, Bin2_/binary>> = Bin_,
            parse_report(ReportType, Bin2_)
        end,

    io:format("***action list***:~n"),
    % file:write(Fd, io_lib:format("    战报~n", [])),
    <<>> = test_client_base:for(0, ActionCount, F, ActionInfos).






%% =====================================


parse_buff_details(BuffDtl_Bin) ->
    <<BuffNo:32, ExpireRound:16, OverlapCount:8, Para1_Type:8, Para1_Value:32, Para2_Type:8, Para2_Value:32, BinLeft/binary>> = BuffDtl_Bin,
    io:format("              BuffNo=~p ExpireRound=~p OverlapCount=~p Para1_Type=~p Para1_Value=~p Para2_Type=~p Para2_Value=~p~n", 
                            [BuffNo, ExpireRound, OverlapCount, Para1_Type, Para1_Value, Para2_Type, Para2_Value]),
    BinLeft.
        





%% 解析战报：bo执行物理攻击
parse_report(?BR_T_BO_DO_PHY_ATT, Bin) ->
    <<AttSubType:8, AttResult:8, AtterId:16, DeferId:16, ProtectorId:16, DamToDefer:32, DamToDefer_Mp:32/signed-integer, DamToProtector:32, RetDam:32, AbsorbedHp:32,
        % AtterHpLeft:32, AtterMpLeft:32, AtterAngerLeft:32, DeferHpLeft:32, DeferMpLeft:32, ProtectorHpLeft:32, AtterBuffsAddedCount:16, Bin2/binary>> = Bin,
        AtterHpLeft:32, AtterMpLeft:32, AtterAngerLeft:32, AtterDieStatus:8, IsAtterApplyReborn:8 , DeferHpLeft:32, DeferMpLeft:32, DeferDieStatus:8, IsDeferApplyReborn:8, 
        ProtectorHpLeft:32, ProtectorDieStatus:8, IsProtectorApplyReborn:8, AtterBuffsAddedCount:16, Bin2/binary>> = Bin,

    io:format("##DO PHY ATT##: AttSubType=~s AttResult=~s AtterId=~p DeferId=~p ProtectorId=~p DamToDefer=~p DamToDefer_Mp=~p DamToProtector=~p RetDam=~p AbsorbedHp=~p AtterHpLeft=~p AtterMpLeft=~p AtterAngerLeft=~p "
                "DeferHpLeft=~p DeferMpLeft=~p ProtectorHpLeft=~p~n", 
            [to_att_sub_type_string(AttSubType), to_att_result_string(english, AttResult), AtterId, DeferId, ProtectorId, DamToDefer, DamToDefer_Mp, DamToProtector, RetDam, AbsorbedHp, AtterHpLeft, AtterMpLeft, AtterAngerLeft, 
                DeferHpLeft, DeferMpLeft, ProtectorHpLeft]),

    io:format("                AtterDieStatus=~p, DeferDieStatus=~p, ProtectorDieStatus=~p~n", [AtterDieStatus, DeferDieStatus, ProtectorDieStatus]),
    io:format("                IsAtterApplyReborn=~p, IsDeferApplyReborn=~p, IsProtectorApplyReborn=~p~n", [IsAtterApplyReborn, IsDeferApplyReborn, IsProtectorApplyReborn]),

    % file:write(Fd, io_lib:format("（普通攻击）: 此次攻击是否为反击=~s 攻击者=~p 受击者=~p 攻击结果=~s 伤害值=~p 反弹伤害值=~p 攻击者剩余血量=~p 受击者剩余血量=~p~n", 
    %                     [to_bool_string(IsStrikeBack), Atter, Defer, to_att_result_string(chinese, AttResult), Dam, RetDam, AtterHpLeft, DeferHpLeft])),

    F0 = fun(Bin_) ->
            <<BuffNo:32, Bin2_/binary>> = Bin_,
            io:format("          BuffNo=~p~n", [BuffNo]),
            Bin2_
        end,

    io:format("  AtterBuffsAddedCount=~p~n", [AtterBuffsAddedCount]),  %%io:format("AtterBuffsAddedCount=~p:********~n", [AtterBuffsAddedCount]),
    Bin3 = test_client_base:for(0, AtterBuffsAddedCount, fun parse_buff_details/1, Bin2),
    %%io:format("*****************~n"),

    <<AtterBuffsRemovedCount:16, Bin4/binary>> = Bin3,
    io:format("  AtterBuffsRemovedCount=~p~n", [AtterBuffsRemovedCount]),  %%io:format("AtterBuffsRemovedCount=~p:********~n", [AtterBuffsRemovedCount]),
    Bin5 = test_client_base:for(0, AtterBuffsRemovedCount, F0, Bin4),
    %%io:format("*****************~n"),



    <<DeferBuffsAddedCount:16, Bin6/binary>> = Bin5,
    io:format("  DeferBuffsAddedCount=~p~n", [DeferBuffsAddedCount]),
    Bin7 = test_client_base:for(0, DeferBuffsAddedCount, fun parse_buff_details/1, Bin6),
    %%io:format("*****************~n"),

    <<DeferBuffsRemovedCount:16, Bin8/binary>> = Bin7,
    io:format("  DeferBuffsRemovedCount=~p~n", [DeferBuffsRemovedCount]),
    Bin9 = test_client_base:for(0, DeferBuffsRemovedCount, F0, Bin8),
    %%io:format("*****************~n"),

    <<DeferBuffsUpdatedCount:16, Bin10/binary>> = Bin9,
    io:format("  DeferBuffsUpdatedCount=~p~n", [DeferBuffsUpdatedCount]),
    Bin11 = test_client_base:for(0, DeferBuffsUpdatedCount, fun parse_buff_details/1, Bin10),
    %%io:format("*****************~n"),



    <<ProtectorBuffsRemovedCount:16, Bin12/binary>> = Bin11,
    io:format("  ProtectorBuffsRemovedCount=~p~n", [ProtectorBuffsRemovedCount]),
    Bin13 = test_client_base:for(0, ProtectorBuffsRemovedCount, F0, Bin12),
    %%io:format("*****************~n"),

    Bin13;



%% 解析战报：bo执行法术攻击
parse_report(?BR_T_BO_DO_MAG_ATT, Bin) ->
    <<IsComboAtt:8, AtterId:16, AtterBuffsAddedCount:16, Bin2/binary>> = Bin,
    io:format("##DO MAG ATT##: IsComboAtt=~p AtterId=~p~n", [IsComboAtt, AtterId]),

    F0 = fun(Bin__) ->
            <<BuffNo:32, Bin2__/binary>> = Bin__,
            io:format("            BuffNo=~p~n", [BuffNo]),
            Bin2__
        end,

    io:format("      AtterBuffsAddedCount=~p~n", [AtterBuffsAddedCount]),

    % io:format("        Bin2: ~p~n", [Bin2]),

    Bin3 = test_client_base:for(0, AtterBuffsAddedCount, fun parse_buff_details/1, Bin2),

    <<AtterBuffsRemovedCount:16, Bin4/binary>> = Bin3,
    io:format("      AtterBuffsRemovedCount=~p~n", [AtterBuffsRemovedCount]),
    Bin5 = test_client_base:for(0, AtterBuffsRemovedCount, F0, Bin4),

    <<DamDtlCount:16, Bin6/binary>> = Bin5,

    F = fun(Bin_) ->
            % <<DeferId:16, AttResult:8, DamToDefer:32, AtterHpLeft:32, AtterMpLeft:32, AtterAngerLeft:32, DeferHpLeft:32, DeferMpLeft:32,
            % AtterBuffsAddedCount:16, Bin2_/binary>> = Bin_,

            <<DeferId:16, AttResult:8, DamToDefer:32, DamToDefer_Mp:32/signed-integer, AtterHpLeft:32, AtterMpLeft:32, AtterAngerLeft:32, AtterDieStatus:8, 
            DeferHpLeft:32, DeferMpLeft:32, DeferDieStatus:8, IsDeferApplyReborn:8,
            % <<DeferId:16, AttResult:8, DamToDefer:32, AtterHpLeft:32, AtterMpLeft:32, AtterAngerLeft:32, DeferHpLeft:32, DeferMpLeft:32,
            DeferBuffsAddedCount:16, Bin2_/binary>> = Bin_,

            io:format("    @@DeferId=~p AttResult=~s DamToDefer=~p DamToDefer_Mp=~p AtterHpLeft=~p AtterMpLeft=~p AtterAngerLeft=~p DeferHpLeft=~p DeferMpLeft=~p~n", 
                            [DeferId, to_att_result_string(english, AttResult), DamToDefer, DamToDefer_Mp, AtterHpLeft, AtterMpLeft, AtterAngerLeft, DeferHpLeft, DeferMpLeft]),
            io:format("      AtterDieStatus=~p, DeferDieStatus=~p, IsDeferApplyReborn:~p~n", [AtterDieStatus, DeferDieStatus, IsDeferApplyReborn]),

            % io:format("      AtterBuffsAddedCount=~p~n", [AtterBuffsAddedCount]),  %%io:format("AtterBuffsAddedCount=~p:********~n", [AtterBuffsAddedCount]),
            % Bin3_ = test_client_base:for(0, AtterBuffsAddedCount, fun parse_buff_details/1, Bin2_),
            % %%io:format("*****************~n"),

            % <<AtterBuffsRemovedCount:16, Bin4_/binary>> = Bin3_,
            % io:format("      AtterBuffsRemovedCount=~p~n", [AtterBuffsRemovedCount]),  %%io:format("AtterBuffsRemovedCount=~p:********~n", [AtterBuffsRemovedCount]),
            % Bin5_ = test_client_base:for(0, AtterBuffsRemovedCount, F0, Bin4_),
            % %%io:format("*****************~n"),

            Bin6_ = Bin2_,

            % <<DeferBuffsAddedCount:16, Bin6_/binary>> = Bin5_,
            io:format("      DeferBuffsAddedCount=~p~n", [DeferBuffsAddedCount]),
            Bin7_ = test_client_base:for(0, DeferBuffsAddedCount, fun parse_buff_details/1, Bin6_),
            %%io:format("*****************~n"),

            <<DeferBuffsRemovedCount:16, Bin8_/binary>> = Bin7_,
            io:format("      DeferBuffsRemovedCount=~p~n", [DeferBuffsRemovedCount]),
            Bin9_ = test_client_base:for(0, DeferBuffsRemovedCount, F0, Bin8_),
            %%io:format("*****************~n"),

            <<DeferBuffsUpdatedCount:16, Bin10_/binary>> = Bin9_,
            io:format("      DeferBuffsUpdatedCount=~p~n", [DeferBuffsUpdatedCount]),
            Bin11_ = test_client_base:for(0, DeferBuffsUpdatedCount, fun parse_buff_details/1, Bin10_),
            %%io:format("*****************~n"),

            Bin11_
        end,
    
    Bin7 = test_client_base:for(0, DamDtlCount, F, Bin6),
    Bin7;


%% 解析战报：bo施法（释放或驱散buff）
parse_report(?BR_T_BO_CAST_BUFFS, Bin) ->
    F0 = fun(Bin_) ->
            <<BuffNo:32, Bin2_/binary>> = Bin_,
            io:format("              BuffNo=~p~n", [BuffNo]),
            Bin2_
        end,
                    
    F1 = fun(Bin_) ->
            <<TarBoId:16, BuffAddedCount:16, Bin2_/binary>> = Bin_,
            io:format("  TarBoId=~p~n", [TarBoId]),

            io:format("      BuffAddedCount=~p~n", [BuffAddedCount]),  %%io:format("      BuffAddedCount=~p:********~n", [BuffAddedCount]),
            Bin3_ = test_client_base:for(0, BuffAddedCount, fun parse_buff_details/1, Bin2_),
            %%io:format("      *****************~n"),

            <<BuffRemovedCount:16, Bin4_/binary>> = Bin3_,
            io:format("      BuffRemovedCount=~p~n", [BuffRemovedCount]),  %%io:format("      BuffRemovedCount=~p:********~n", [BuffRemovedCount]),
            Bin5_ = test_client_base:for(0, BuffRemovedCount, F0, Bin4_),
            %%io:format("      *****************~n"),

            <<BuffUpdatedCount:16, Bin6_/binary>> = Bin5_,
            io:format("      BuffUpdatedCount=~p~n", [BuffUpdatedCount]),  %%io:format("      BuffUpdatedCount=~p:********~n", [BuffUpdatedCount]),
            Bin7_ = test_client_base:for(0, BuffUpdatedCount, fun parse_buff_details/1, Bin6_),
            %%io:format("      *****************~n"),

            Bin7_
        end,

    <<CasterId:16, CastResult:8, NeedPerfCasting:8, TarBoCount:16, Bin2/binary>> = Bin,
    io:format("##CAST BUFFS##: CasterId=~p CastResult=~p NeedPerfCasting=~p~n", [CasterId, CastResult, NeedPerfCasting]),

    io:format("TarBoCount=~p:********~n", [TarBoCount]),
    Bin3 = test_client_base:for(0, TarBoCount, F1, Bin2),
    io:format("**********************~n"),
    Bin3;




%% 解析战报：bo执行治疗
parse_report(?BR_T_BO_DO_HEAL, Bin) ->
    <<HasReviveEff:8, HealType:8, CastingResult:8, TarBoCount:16, Bin2/binary>> = Bin,

    io:format("##HEAL##: HasReviveEff=~p HealType=~p CastingResult=~p~n", [HasReviveEff, HealType, CastingResult]),


    F0 = fun(Bin_) ->
            <<BuffNo:32, Bin2_/binary>> = Bin_,
            io:format("              BuffNo=~p~n", [BuffNo]),
            Bin2_
        end,

    F = fun(Bin_) ->
            <<TarBoId:16, IsCannotBeHeal:8, HealVal:32, NewHp:32, NewMp:32, BuffAddedCount:16, Bin2_/binary>> = Bin_,
            io:format("    TarBoId=~p IsCannotBeHeal=~p HealVal=~p NewHp=~p NewMp=~p~n", [TarBoId, IsCannotBeHeal, HealVal, NewHp, NewMp]),

            io:format("          BuffAddedCount=~p~n", [BuffAddedCount]),
            Bin3_ = test_client_base:for(0, BuffAddedCount, fun parse_buff_details/1, Bin2_),
            
            <<BuffRemovedCount:16, Bin4_/binary>> = Bin3_,
            io:format("          BuffRemovedCount=~p~n", [BuffRemovedCount]),
            Bin5_ = test_client_base:for(0, BuffRemovedCount, F0, Bin4_),

            Bin5_
        end,

    io:format("TarBoCount=~p:********~n", [TarBoCount]),
    Bin3 = test_client_base:for(0, TarBoCount, F, Bin2),
    io:format("**********************~n"),
    Bin3;



%% 解析战报：bo强行死亡
parse_report(?BR_T_BOS_FORCE_DIE, Bin) ->
    {EleList, Bin2} = pt:read_array(Bin, [u16, u8]),
    io:format("##FORCE_DIE##:~n"),
    F = fun({BoId, DieStatus}) ->
            io:format("      BoId=~p, DieStatus=~p~n", [BoId, DieStatus])
        end,
    io:format("ForceDieBoCount=~p:********~n", [length(EleList)]),
    lists:foreach(F, EleList),
    io:format("**********************~n"),
    Bin2;



%% 解析战报：bo逃跑
parse_report(?BR_T_BO_ESCAPE, Bin) ->
    <<BoId:16, Result:8, Bin2/binary>> = Bin,
    io:format("## ESCAPE ##: BoId=~p Result=~p~n", [BoId, Result]),
    Bin2;



%% 解析战报：bo使用物品
parse_report(?BR_T_BO_USE_GOODS, Bin) ->
    <<GoodsId:64, GoodsNo:32, TargetBoId:16, HealVal_Hp:32, HealVal_Mp:32, HealVal_Anger:32, NewHp:32, NewMp:32, NewAnger:32, BuffAddedCount:16, Bin2/binary>> = Bin,

    io:format("##USE_GOODS##: GoodsId=~p GoodsNo=~p TargetBoId=~p HealVal_Hp=~p HealVal_Mp=~p HealVal_Anger=~p NewHp=~p NewMp=~p NewAnger=~p~n", 
                                    [GoodsId, GoodsNo, TargetBoId, HealVal_Hp, HealVal_Mp, HealVal_Anger, NewHp, NewMp, NewAnger]),
    io:format("        BuffAddedCount=~p~n", [BuffAddedCount]),
    
    Bin3 = test_client_base:for(0, BuffAddedCount, fun parse_buff_details/1, Bin2),

    F0 = fun(Bin_) ->
            <<BuffNo:32, Bin2_/binary>> = Bin_,
            io:format("              BuffNo=~p~n", [BuffNo]),
            Bin2_
        end,

    <<BuffRemovedCount:16, Bin4/binary>> = Bin3,
    io:format("        BuffRemovedCount=~p~n", [BuffRemovedCount]),
    Bin5 = test_client_base:for(0, BuffRemovedCount, F0, Bin4),
    Bin5;

%% 解析战报：召唤bo
parse_report(?BR_T_BO_DO_SUMMON, Bin) ->
    <<Result:8, Bin2/binary>> = Bin,
    io:format("##BR_T_BO_DO_SUMMON##: Result=~p~n", [Result]),
    {EleList, Bin3} = pt:read_array(Bin2, [u16, u8, u8, u16, u8, string, u8, u8, u8, u8, u64, u32, u32, u32, u32, u32, u32, u32,
                                            u8, u8, u8, u8, u8, u16]),

    F = fun(NewBoInfo) ->
            {NewBoId, Side, Type, OwnerPlayerBoId, Pos, Name, Sex, Race, Faction, Lv, 
                ParentObjId, ParentPartnerNo, Hp, HpLim, Mp, MpLim, Anger, AngerLim, 
                ParCultivateLv, ParEvolveLv, ParNature, IsMainPar, IsInvisible, InvisibleExpireRound} = NewBoInfo,
            io:format("               ****************************"),
            io:format("                NewBoId=~p~n", [NewBoId]),
            io:format("                Side=~p~n", [Side]),
            io:format("                Type=~p~n", [Type]),
            io:format("                OwnerPlayerBoId=~p~n", [OwnerPlayerBoId]),
            io:format("                Pos=~p~n", [Pos]),
            io:format("                Name=~p~n", [Name]),
            io:format("                Sex=~p~n", [Sex]),
            io:format("                Race=~p~n", [Race]),
            io:format("                Faction=~p~n", [Faction]),
            io:format("                Lv=~p~n", [Lv]),
            io:format("                ParentObjId=~p~n", [ParentObjId]),
            io:format("                ParentPartnerNo=~p~n", [ParentPartnerNo]),
            io:format("                Hp=~p~n", [Hp]),
            io:format("                HpLim=~p~n", [HpLim]),
            io:format("                Mp=~p~n", [Mp]),
            io:format("                MpLim=~p~n", [MpLim]),
            io:format("                Anger=~p~n", [Anger]),
            io:format("                AngerLim=~p~n", [AngerLim]),
            io:format("                ParCultivateLv=~p~n", [ParCultivateLv]),
            io:format("                ParEvolveLv=~p~n", [ParEvolveLv]),
            io:format("                ParNature=~p~n", [ParNature]),
            io:format("                IsMainPar=~p~n", [IsMainPar]),
            io:format("                IsInvisible=~p~n", [IsInvisible]),
            io:format("                InvisibleExpireRound=~p~n", [InvisibleExpireRound]),
            io:format("               ****************************")
        end,

    io:format("        NewBoCount=~p~n", [length(EleList)]),
    lists:foreach(F, EleList),
    Bin3.

    

to_win_side_string(WinSide) ->
    case WinSide of
        0 -> "平局";
        1 -> "主队";
        2 -> "客队"
    end.

to_bool_string(Bool) ->
    case Bool of
        true -> "是";
        false -> "否"
    end.

to_bo_type_string(ObjType) ->
    case ObjType of
        1 -> "玩家";
        2 -> "宠物";
        3 -> "NPC";
        4 -> "怪物"
    end.


to_sex_string(Sex) ->
    case Sex of
        0 -> "无";
        1 -> "男";
        2 -> "女"
    end.



to_race_string(Race) ->
    case Race of
        0 -> "无种族";
        1 -> "人族";
        2 -> "魔族";
        3 -> "仙族";
        4 -> "妖族"
    end. 


to_faction_string(Faction) ->
    case Faction of
        0 -> "无门派";
        1 -> "门派1";
        2 -> "门派2";
        3 -> "门派3";
        4 -> "门派4";
        5 -> "门派5";
        6 -> "门派6"
    end.


to_att_type_string(AttType) ->
    case AttType of
        1 -> "Phy";
        2 -> "Mag";
        3 -> "None"
    end.

to_att_sub_type_string(AttSubType) ->
    case AttSubType of
        0 -> "nil !!!!!!!!!!!!!!";
        1 -> "Normal";
        2 -> "StrkBk";  % strike back
        3 -> "Combo ";
        4 -> "Pursue"
    end.
    


to_att_result_string(chinese, AttResult) ->
    case AttResult of
        ?AR_HIT -> "命中";
        ?AR_DODGE -> "闪避";
        ?AR_CRIT -> "暴击"
    end;


to_att_result_string(english, AttResult) ->
	case AttResult of
		?AR_HIT -> "hit";
		?AR_DODGE -> "dodge";
		?AR_CRIT -> "crit" 
	end.