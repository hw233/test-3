%%%-----------------------------------
%%% @Module  : lib_slotmachine
%%% @Author  : 段世和
%%% @Email   : 
%%% @Created : 2015.07.27
%%% @Description: 老虎机
%%%-----------------------------------

-module(lib_slotmachine).

% include
-include("common.hrl").
-include("slotmachine.hrl").
-include("goods.hrl").
-include("ets_name.hrl").
-include("abbreviate.hrl").
-include("log.hrl").

-include("record.hrl").

-include("debug.hrl").

-include("pt_64.hrl").

-compile(export_all).
% -export([]).

% 从数据库加载所有玩家信息
slotmachine_all_player_from_db_load(Rounds) ->
    try 
        MyInfo = case db:select_all(slotmachine, "*", [{rounds, Rounds}]) of
            [] -> [];
            List -> 
                F = fun([_, Rounds, PlayerId, Change,Value,InfosBS], Acc) ->
                    Infos = util:bitstring_to_term(InfosBS),

                    F = fun({Class, Count}) ->
                        #slotmachine_player_info{class = Class, count = Count}
                    end,
                    Infos1 = [F(X) || X <- Infos],

                    [#slotmachine_player{rounds=Rounds,player_id=PlayerId,change=Change,value=Value,infos=Infos1 } | Acc]
                end,
                lists:foldl(F, [],List)
        end
    catch
        _:Reason ->
            ?ERROR_MSG("get_my_sm_info() failed!! Rounds=~p,Reason:~w", [ Rounds,Reason]),
            fail
    end.

% 更新或者插入
update_or_insert_slotmachine_player_to_db(SP) when is_record(SP, slotmachine_player) ->
    try
        sava_slotmachine_player_to_db(SP)
    catch
        _:Reason ->
            fali
    end.

% 插入数据
sava_slotmachine_player_to_db(SP) when is_record(SP, slotmachine_player) ->
    try
        Rounds = SP#slotmachine_player.rounds,
        PlayerID = SP#slotmachine_player.player_id,
        Change = SP#slotmachine_player.change,
        Value = SP#slotmachine_player.value,

        Infos = SP#slotmachine_player.infos,

        L = [{X#slotmachine_player_info.class, X#slotmachine_player_info.count} || X <- Infos],
        InfosBS = util:term_to_bitstring(L),
        % ?DEBUG_MSG("InfosBS ~p",[InfosBS]),      

        % 判断如果没有购买则不更新
        case Change =:= 0 andalso Infos == [#slotmachine_player_info{class = 2,count = 0},
                            #slotmachine_player_info{class = 3,count = 0},
                            #slotmachine_player_info{class = 4,count = 0},
                            #slotmachine_player_info{class = 5,count = 0},
                            #slotmachine_player_info{class = 6,count = 0},
                            #slotmachine_player_info{class = 7,count = 0},
                            #slotmachine_player_info{class = 8,count = 0},
                            #slotmachine_player_info{class = 9,count = 0}] of 
            true ->
                skip;
            _ ->
                db:insert_or_update(slotmachine, [rounds, player_id, change,value,infos], [Rounds, PlayerID, Change,Value, InfosBS])
        end
    catch
        _:Reason ->
            %?ERROR_MSG("sava_slotmachine_player_to_db() failed!! Reason:~p,SP=~p", [ Reason,SP]),
            fail
    end.

% 从数据库加载历史记录到ets
slotmachine_history_from_load() ->
    try 
        % case db:select_all(slotmachine, "*", [{player_id, PlayerID},{rounds, Rounds}]) of
        case db:select_all(slotmachine_history, "*", [],[],[5]) of
            [] -> [];
            List ->
                ?DEBUG_MSG("List=~p",[List]),
                F = fun([_, Rounds, No, Change,__], Acc) ->
                    [#slotmachine_history{rounds=Rounds,no=No,change=Change} | Acc]
                end,
                lists:foldl(F, [],List)
        end
    catch
        _:Reason ->
            ?ERROR_MSG("slotmachine_history_from_load() failed!! Reason:~w", [Reason]),
            fail
    end.


% 插入历史记录
save_history_to_db(Rounds,No,Change) ->
    % ?DEBUG_MSG("save_history_to_db,~p,~p,~p",[Rounds,No,Change]),

    try
        % 插入历史数据到数据库
        CurTime = svr_clock:get_unixtime(),
        db:insert_or_update(slotmachine_history, [rounds, no, change, open_time], [Rounds,No,Change,CurTime])
    catch
        _:Reason ->
            % ?ERROR_MSG("insert_history() failed!! Rounds:~p, Reason:~w", [Rounds, Reason]),
            fail
    end.

% 插入历史记录
update_history_to_db(Rounds,No,Change) ->
    % ?DEBUG_MSG("save_history_to_db,~p,~p,~p",[Rounds,No,Change]),

    try
        % 插入历史数据到数据库
        db:update(slotmachine_history, [{no,No},{change,Change}],[{rounds,Rounds}]) 
    catch
        _:Reason ->
            % ?ERROR_MSG("insert_history() failed!! Rounds:~p, Reason:~w", [Rounds, Reason]),
            fail
    end.

% 更新或者插入历史记录
update_or_insert_history_to_db(Rounds,No,Change) ->
    % ?DEBUG_MSG("update_or_insert_history_to_db,~p,~p,~p",[Rounds,No,Change]),
    try
        % 更新历史数据到数据库
        save_history_to_db(Rounds,No,Change)
        %update_history_to_db(Rounds,No,Change)
    catch
        _:Reason ->
            ?DEBUG_MSG("Reason,~p",[Reason])
    end.


% 保存历史
sava_history(Rounds,No,Change) ->
    % ?DEBUG_MSG("sava_history,~p,~p,~p",[Rounds,No,Change]),
    update_or_insert_history_to_db(Rounds,No,Change),

    % 插入历史数据到ets
    mod_slotmachine:add_slotmachine_history_to_ets(#slotmachine_history{rounds=Rounds,no=No,change=Change}),
    % 删除ets 多余的历史记录
    mod_slotmachine:del_slotmachine_history_from_ets().

% 获取说明
get_open_name(Change) ->
	case Change of 
		1 -> "涨";
		2 -> "持平";
		3 -> "跌";
		_ -> "无"
	end.

% 获取赔率
get_open_odds(Change) ->
	case Change of 
		1 -> 1.8;
		2 -> 30;
		3 -> 1.8;
		_ -> 0
	end.

% 获取类型描述
get_type_string(Type) ->
	case Type of
		1 -> "流行";
		2 -> "风靡";
		_ -> "无"
	end.

get_name_by_class(Class) ->
	case Class of
		1 -> "LUCK";
		2 -> "钻石";
		3 -> "黄金";
		4 -> "白银";
		5 -> "丝绸";
		6 -> "花生";
		7 -> "小麦";
		8 -> "大豆";
		9 -> "玉米";
		_ -> "无"
	end.

get_my_class_list_is_buy([]) ->
	0;

get_my_class_list_is_buy(MyClassList) ->
	F = fun({Class,Count},Acc) ->
		case Count of 
			0 -> Acc;
			_ -> Acc + Count
		end		 
	end,

	lists:foldl(F, 0,MyClassList).

get_my_class_list_name([]) ->
	"无";

get_my_class_list_name(MyClassList) ->
	F = fun({Class,Count},Acc) ->
		case Count of 
			0 -> Acc;
			_ -> Acc ++ [get_name_by_class(Class),"X",Count]
		end		 
	end,

	lists:concat(lists:foldl(F, [],MyClassList)).

% 开奖
open_slotmachine(Rounds) ->
    % 获取开奖id
    % ?DEBUG_MSG("open_slotmachine~p,Rounds=~p",[1,Rounds]),
    No = get_open_no(),

    % ?DEBUG_MSG("open_slotmachine~p",[2]),
    Config = data_slotmachine:get(No),

    % ?DEBUG_MSG("Config~p",[Config]),
    % ?DEBUG_MSG("open_slotmachine~p",[3]),
    % 清除ETS所有非当前回合的数据
    mod_slotmachine:del_all_not_cur_rounds_data(),

    % ?DEBUG_MSG("open_slotmachine~p",[4]),
    List = mod_slotmachine:get_all_slotmachine_player(),

    % ?DEBUG_MSG("open_slotmachine~p",[5]),
    OpenChange1 = util:rand(1, 6),
    OpenChange2 = util:rand(1, 6),
    OpenChange3 = util:rand(1, 6),

    OpenChange = OpenChange1 * 100 + OpenChange2 * 10 + OpenChange3,
    OpenChangeValue = OpenChange1+OpenChange2+OpenChange3,

    IsLeopard = (OpenChange1 == OpenChange2 andalso OpenChange2 == OpenChange3),

    OpenRet = 
    	if  IsLeopard -> 2;
            OpenChangeValue < 11 -> 3;
            OpenChangeValue > 10 -> 1;
            true -> 0
        end,

    % ?DEBUG_MSG("OpenRet~p",[OpenRet]),
    % ?DEBUG_MSG("IsLeopard~p",[IsLeopard]),

    sava_history(Rounds,No,OpenChange),
    % ?DEBUG_MSG("open_slotmachine~p",[25]),

    F1 = fun(#slotmachine_player{rounds=Rounds,player_id=PlayerID,change=Change,value=Value,infos=Infos} = SP, Acc) ->
        F = fun(#slotmachine_player_info{class=Class,count=Count}, Acc={PlayerID,A2,A3}) ->
            OddsValue = case Config#slotmachine_config.class of
            	Class -> Count * Config#slotmachine_config.odds;
            	_ -> 0
            end,

            {PlayerID, A2 + OddsValue, [{Class,Count} | A3]}
        end,

        Title1 = <<"大盘开奖公告">>,
        Title2 = <<"期货开奖公告">>,

        ?Ifc (OpenRet == Change)
             Content = io_lib:format(
                <<"期货大盘第~p期开奖信息：#27a337[~p,~p,~p]
                大盘(~s)#7a4a19\n您投资的是#27a337 [大盘(~s)]
                #7a4a19本期投资成功,获得收益#E338FF~p筹码">>, 
            	[
	            	Rounds,
	            	OpenChange1,
	            	OpenChange2,
	            	OpenChange3,
	            	get_open_name(OpenRet),
	            	get_open_name(Change),
	            	util:floor(get_open_odds(OpenRet) * Value)
            	]),

            GoodsList = [{?VGOODS_CHIP, util:floor(get_open_odds(OpenRet) * Value)}],

            ?Ifc (util:floor(get_open_odds(OpenRet) * Value) >= 500)
                mod_broadcast:send_sys_broadcast(170, [
                                            player:get_name(PlayerID),
                                            PlayerID,
                                            get_open_name(OpenRet),
                                            util:floor(get_open_odds(OpenRet) * Value)
                                        ])
            ?End,


            lib_mail:send_sys_mail(PlayerID, Title1 , Content, GoodsList , [?LOG_SLOTMACHINE, "dapan"])
        ?End,
        ?Ifc (OpenRet /= Change andalso Change /= 0)
             Content1 = io_lib:format(<<
                "期货大盘第~p期开奖信息：#27a337[~p,~p,~p] 
                大盘(~s)#7a4a19\n您投资的是#27a337[大盘(~s)]
                #7a4a19,本期投资失败,下期请再接再厉,祝您好运">>, 
            	[
	            	Rounds,
	            	OpenChange1,
	            	OpenChange2,
	            	OpenChange3,
	            	get_open_name(OpenRet),
	            	get_open_name(Change)
            	]),

            lib_mail:send_sys_mail(PlayerID, Title1, Content1, [] , [?LOG_SLOTMACHINE, "dapan"])
        ?End,
 
        % ?DEBUG_MSG("open_slotmachine~p",[9]),
        MyInfo = lists:foldl(F, {PlayerID,0,[]},Infos),

        {_,OddsV ,MyClassList} = MyInfo,
        % ?DEBUG_MSG("open_slotmachine~p",[21]),

        ?Ifc (OddsV > 0)
             Content2 = io_lib:format(<<"期货市场第~p期开奖信息：#27a337[(~s) ~s]#7a4a19\n您投资的是#27a337[(~s)]#7a4a19,本期投资成功, 获得收益#E338FF~p筹码#7a4a19.\n奖励请通过附件提取，祝您下期再中大奖">>, 
            	[
	            	Rounds,
	            	Config#slotmachine_config.name,
	            	get_type_string(Config#slotmachine_config.type),
	            	get_my_class_list_name(MyClassList),
	            	OddsV
	            ]),

            GoodsList2 = [{?VGOODS_CHIP, OddsV}],

            ?Ifc (OddsV >= 500)
                mod_broadcast:send_sys_broadcast(171, [
                                                        player:get_name(PlayerID)
                                                        ,PlayerID
                                                        ,Config#slotmachine_config.name
                                                        ,get_type_string(Config#slotmachine_config.type)
                                                        ,OddsV
                                                    ])
            ?End,

            lib_mail:send_sys_mail(PlayerID, Title2 , Content2, GoodsList2 , [?LOG_SLOTMACHINE, "dapan"])
        ?End,

        ?Ifc (OddsV =< 0 andalso get_my_class_list_is_buy(MyClassList) > 0)
            Content3 = io_lib:format(<<"期货市场第~p期开奖信息：#27a337[(~s) ~s]#7a4a19\n您投资的是#27a337[(~s)]#7a4a19,本期投资失败. 下期请再接再厉，祝您好运">>, 
	            [
		            Rounds,
		            Config#slotmachine_config.name,
	            	get_type_string(Config#slotmachine_config.type),
	            	get_my_class_list_name(MyClassList)
	            ]),

            lib_mail:send_sys_mail(PlayerID, Title2 , Content3, [] , [?LOG_SLOTMACHINE, "dapan"])
        ?End
    end,

    lists:foldl(F1, 0,List),

    F2 = fun(PlayerID) -> 
        PS = player:get_PS(PlayerID),
        % ?DEBUG_MSG("open_slotmachine~p",[14]),
        % 如果该玩家在线的话
        case player:is_online(PlayerID) of
            true ->
                ply_tips:send_sys_tips(PS, {open_slotmachine1, [Rounds,OpenChange1,OpenChange2,OpenChange3,get_open_name(OpenRet),2024]}),
                ply_tips:send_sys_tips(PS, {open_slotmachine2, [Rounds,Config#slotmachine_config.name,get_type_string(Config#slotmachine_config.type),2024]}),

                % 推送协议开奖
                SP = mod_slotmachine:get_slotmachine_player(PlayerID),
                {ok, BinData} = pt_64:write(?PT_SLOTMACHINE_LOTTERY_OPEN, [Rounds,No,OpenChange,SP]),
                lib_send:send_to_uid(PlayerID, BinData);
            false ->
                skip
        end
    end,
    lists:foreach(F2, mod_svr_mgr:get_all_online_player_ids()),
    void.


% 获取所有配置信息
get_config_list() ->
    List = data_slotmachine:get_all_config_no_list(),

    F = fun(No, Acc) ->
        Cfg = data_slotmachine:get(No),
        [Cfg | Acc]
    end,
    Ret = lists:foldl(F, [],List),
    Ret.

% 计算需要随机的范围
get_random_range() ->
    List = get_config_list(),

    F = fun(Config, Sum) ->
        Widget = Config#slotmachine_config.widget,
        Widget + Sum
    end,

    All = lists:foldl(F, 0, List),
    All.


% 获取随机特效信息
get_random_no( RandNum) ->
    List = get_config_list(),
    get_random_no(List, RandNum, 0).

get_random_no([H | T],  RandNum, SumToCompare) ->
    No = H#slotmachine_config.no,
    Widget = H#slotmachine_config.widget,

    SumToCompare_2 = Widget + SumToCompare,

    case RandNum =< SumToCompare_2 of
        true -> 
            No;
        false ->
            get_random_no(T, RandNum, SumToCompare_2)
    end;

get_random_no([],  _RandNum, _SumToCompare) ->
    ?ASSERT(false, { _RandNum, _SumToCompare}),
    0.

% 获取开奖编号
get_open_no() ->
    % ?DEBUG_MSG("get_open_no~p",[1]),
    Range = get_random_range(),
    % ?DEBUG_MSG("get_open_no~p",[2]),
    RandNum = util:rand(1, Range),
    % ?DEBUG_MSG("get_open_no~p",[3]),
    get_random_no( RandNum).
