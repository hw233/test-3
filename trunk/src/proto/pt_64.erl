%%%-----------------------------------
%%% @Module  : pt_64
%%% @Author  : 段世和
%%% @Email   : 
%%% @Created : 2015.7
%%% @Description: 老虎机
%%%-----------------------------------
-module(pt_64).
-compile(export_all).
-include("common.hrl").
-include("pt_64.hrl").

-include("slotmachine.hrl").

%%
%%客户端 -> 服务端 ----------------------------
%%
read(?PT_SLOTMACHINE_INFO, <<>>) ->
    % ?DEBUG_MSG("PT_SLOTMACHINE_INFO",[]),
    {ok, []};

read(?PT_SLOTMACHINE_BUY_1, Bin) ->
    {BuyInfo, <<>>} = pt:read_array(Bin, [u32, u32]),
    {ok,[BuyInfo]};

read(?PT_SLOTMACHINE_BUY_2, <<Change:8,Value:32>>) ->
    {ok,[Change,Value]};

read(?PT_SLOTMACHINE_SERVER_INFO, <<>>) ->
    {ok, []};

read(_Cmd, _Data) ->
    ?ASSERT(false, [_Cmd]),
    error.


%%
%%服务端 -> 客户端 ----------------------------
%%

% 功能 拼装获取全部信息的接口
% 参数 当前轮次、剩余时间、自己的信息、历史信息、服务器信息
write(?PT_SLOTMACHINE_INFO, [CurRounds,LeftTime,SP,HS,SSP]) when is_record(SP,slotmachine_player) ->
    % ?DEBUG_MSG("write PT_SLOTMACHINE_INFO CurRounds=~p,LeftTime=~p,SP=~p,HS=~p,SSP=~p",[CurRounds,LeftTime,SP,HS,SSP]),

     F = fun(X) ->
            No = X#slotmachine_history.no,
            Change_ = X#slotmachine_history.change,
            Rounds = X#slotmachine_history.rounds,
            
            <<
                Rounds : 32,
                No : 32 ,
                Change_ : 16 
            >>
        end,

    HistoryBin = [F(X) || X <- HS],

    % 获取我的购买信息
    Change = SP#slotmachine_player.change,
    Value = SP#slotmachine_player.value,

    MyInfo = SP#slotmachine_player.infos,
    ServerInfo = SSP#slotmachine_player.infos,

    F1 = fun(X) ->
            Class = X#slotmachine_player_info.class,
            Count = X#slotmachine_player_info.count,

            <<
                Class : 32 ,
                Count : 32 
            >>
        end,

    MyInfoBin = [F1(X) || X <- MyInfo],

    F2 = fun(X) ->
            Class = X#slotmachine_player_info.class,
            Count = X#slotmachine_player_info.count,

            <<
                Class : 32 ,
                Count : 32 
            >>
        end,

    ServerInfoBin = [F2(X) || X <- ServerInfo],
    

    HistoryBin1 = list_to_binary(HistoryBin),
    MyInfoBin1 = list_to_binary(MyInfoBin),
    ServerInfoBin1 = list_to_binary(ServerInfoBin),

    BinData = <<
        CurRounds : 32,
        LeftTime: 32,
        Change: 16,
        Value : 32,

        (length(HistoryBin)) : 16,
        HistoryBin1 /binary,
        (length(MyInfoBin)) : 16,
        MyInfoBin1 /binary,
        (length(ServerInfoBin)) : 16,
        ServerInfoBin1 /binary
    >>,

    {ok, pt:pack(?PT_SLOTMACHINE_INFO, BinData)};

% 功能 拼装服务器购买信息
% 参数 当前的轮次、剩余时间、全服务器购买信息
write(?PT_SLOTMACHINE_SERVER_INFO, [CurRounds,LeftTime,SSP]) when is_record(SSP,slotmachine_player) ->
    F2 = fun(X) ->
            Class = X#slotmachine_player_info.class,
            Count = X#slotmachine_player_info.count,

            <<
                Class : 32 ,
                Count : 32 
            >>
        end,

    ServerInfo = SSP#slotmachine_player.infos,

    ServerInfoBin = [F2(X) || X <- ServerInfo],
    ServerInfoBin1 = list_to_binary(ServerInfoBin),

    BinData = <<
        CurRounds : 32,
        LeftTime: 32,
        (length(ServerInfoBin)) : 16,
        ServerInfoBin1 /binary
    >>,

    {ok, pt:pack(?PT_SLOTMACHINE_SERVER_INFO, BinData)};


% 功能 拼装发送开奖信息
% 参数 轮次、开奖编号、大盘跌涨标记、我的购买信息
write(?PT_SLOTMACHINE_LOTTERY_OPEN, [Rounds,No,Change,SP]) ->
    MyInfo = SP#slotmachine_player.infos,
    F1 = fun(X) ->
                Class = X#slotmachine_player_info.class,
                Count = X#slotmachine_player_info.count,

                <<
                    Class : 32 ,
                    Count : 32 
                >>
            end,

    MyInfoBin = [F1(X) || X <- MyInfo],
    MyInfoBin1 = list_to_binary(MyInfoBin),

    MyChange = SP#slotmachine_player.change,
    Value = SP#slotmachine_player.value,

    BinData = <<
        Rounds : 32,
        No: 32,
        Change: 16,

        MyChange : 8,
        Value : 32,
        (length(MyInfoBin)) : 16,
        MyInfoBin1 /binary
    >>,

    {ok, pt:pack(?PT_SLOTMACHINE_LOTTERY_OPEN, BinData)};

write(?PT_SLOTMACHINE_BUY_1, [Code]) ->
    {ok, pt:pack(?PT_SLOTMACHINE_BUY_1, <<Code:8>>)};

write(?PT_SLOTMACHINE_BUY_2, [Code]) ->
    {ok, pt:pack(?PT_SLOTMACHINE_BUY_2, <<Code:8>>)};

write(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]),
    error.