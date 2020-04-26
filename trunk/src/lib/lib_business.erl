%%%-----------------------------------
%%% @Module  : lib_business
%%% @Author  : 段世和
%%% @Email   : 
%%% @Created : 2015.07.06
%%% @Description: 商会交易系统
%%%-----------------------------------

-module(lib_business).

% include
-include("common.hrl").
-include("business.hrl").
-include("goods.hrl").
-include("record/goods_record.hrl").
-include("abbreviate.hrl").
-include("ets_name.hrl").
-include("log.hrl").

-compile(export_all).
-export([]).

% function body

% 玩家登陆---加载数据（在玩家进程中执行）
login(PS) ->
    PlayerID = player:id(PS),

    % 首先从字段读取
    BusinessDataDB = 
        case db:kv_lookup(business, PlayerID) of
            [] -> [];
            [List] -> List
        end,

    % 存储到进程字典
    erlang:put(?BUSINESS_DATA, BusinessDataDB),
    void.

% 玩家临时退出操作---缓存数据
tmp_logout(PS) ->
    PlayerID = player:id(PS),
    % 保存到数据库
    BusinessDatas = case erlang:get(?BUSINESS_DATA) of
        undefined -> [];
        DataList -> DataList
    end,

    % ?DEBUG_MSG("tmp_logout BusinessDatas=(~p)",[BusinessDatas]),

    % 写入数据库
    db:kv_insert(business, PlayerID, BusinessDatas),
    void.

% 玩家最终退出操作---写数据库
final_logout(_PS) ->
    void.
    
% 获取玩家信息
get_business_player_persistence(PS,No) ->
    PlayerId = player:id(PS),
    PlayerPer = 
    case get_dict(No) of
        null -> % 第一次创建新的
            #business_player_persistence{no=No};
        PlayerPer__ when is_record(PlayerPer__, business_player_persistence) ->
            PlayerPer__;
        _ -> % 错误数据
            ?ERROR_MSG("business_player_persistence error error_data , id= ~p", [PlayerId]),
            #business_player_persistence{no=No}
    end,
    PlayerPer.

% 玩家进程调用
set_business_player_persistence(_PS,No,BusinessPlayerPer) ->
    put_dict(No, BusinessPlayerPer),
    void.
    
% 字典操作
get_dict(Key) ->
    case erlang:get(?BUSINESS_DATA) of
        undefined -> null;
        DataList -> 
            case lists:keyfind(Key, 1, DataList) of
                false -> null;
                {Key, Data} -> Data
            end
    end.
put_dict(Key, Data) ->
    OldDataList = 
    case erlang:get(?BUSINESS_DATA) of
        undefined -> [];
        DataList__ -> DataList__
    end,
    NewDataList = lists:keystore(Key, 1, OldDataList, {Key, Data}),
    erlang:put(?BUSINESS_DATA, NewDataList).


% 获取对应编号的配置
get_player_persistence_by_no([],_No) -> null;

get_player_persistence_by_no([H|T],No) -> 
    case is_record(H,business_player_persistence) of
        false ->
            ?DEBUG_MSG("get_business_by_no H = ~p",[H]),
            get_player_persistence_by_no(T,No);
        true ->
            if 
                H#business_player_persistence.no =:= No -> H;
                true -> get_player_persistence_by_no(T,No)
            end
    end.

get_player_persistence_by_type(All,Type,SubType) -> 
    PlayerInfo = lists:filter(
        fun(P) -> 
            No = P#business_player_persistence.no,
            BusinessConfig = data_business_config:get(No),

            BusinessConfig#data_business_config.type =:=Type  andalso
            BusinessConfig#data_business_config.sub_type =:=SubType 
        end
    , All),

    PlayerInfo.


% 判断是否应该刷新
is_should_refresh(#data_business_config{refresh_cycle=?REFRESH_HOURLY, refresh_time=MM},#now{time={_HH, MM, _}}) ->
    true;
is_should_refresh(#data_business_config{refresh_cycle=?REFRESH_DAILY, refresh_time={HH, MM}},#now{time={HH, MM, _}}) ->
    true;
is_should_refresh(#data_business_config{refresh_cycle=?REFRESH_WEEKLY, refresh_time={Day, HH, MM}},#now{day=Day, time={HH, MM, _}}) ->
    true;
is_should_refresh(#data_business_config{refresh_cycle=?REFRESH_MONTHLY, refresh_time={D, HH, MM}},#now{date={_Y, _M, D}, time={HH, MM, _}}) ->
    true;
is_should_refresh(#data_business_config{refresh_cycle=?REFRESH_CYCLE, refresh_time=M, no = _No},#now{time={_HH, MM, _}}) ->
    case MM rem M of
        0 -> true;
        _ -> false
    end;
is_should_refresh(_, _) ->
    false.

% 获取现在的时间格式
build_now() ->
    Date = date(),
    Time = time(),
    Week = calendar:iso_week_number(),
    Day = calendar:day_of_the_week(Date),
    Now = #now{date=Date, time=Time, week=Week, day=Day},
    Now.