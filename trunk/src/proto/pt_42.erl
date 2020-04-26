-module(pt_42).
-include("common.hrl").
-include("transport.hrl").
-export([read/2, write/2]).
-compile(export_all).

read(42001, _) ->
    {ok, []};

read(42004, <<RoleId:64, _/binary>>) ->
    {ok, [RoleId]};

read(42005, _) ->
    {ok, []};

read(42006, _) ->
    {ok, []};

read(42007, _) ->
    {ok, []};

read(42008, _) ->
    {ok, []};

read(42009, _) ->
    {ok, []};

read(42010, <<TruckId:64>>) ->
    {ok, [TruckId]};

read(42011, _) ->
    {ok, []};

read(42012, _) ->
    {ok, []};

read(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]),
    not_match.



write(42001, [TruckList, News, Event, CurHijack, MaxHijack, CurTran, MaxTran]) ->
    {ok, pt:pack(42001, <<(pack_truck(TruckList))/binary, (pack_news(News))/binary, 
        (pack_event(Event))/binary, CurHijack:8, MaxHijack:8, CurTran:8, MaxTran:8>>)};

write(42002, [No, Timestamp, RoleId, Name]) ->
    BinName = tool:to_binary(Name),
    {ok, pt:pack(42002, <<No:8, Timestamp:32, RoleId:64, (byte_size(BinName)):16, BinName/binary>>)};

write(42003, [Events]) ->
    {ok, pt:pack(42003, pack_event(Events))};

write(42004, [[RoleId, Name, RoleLv, TruckLv, Employ, CurHijack, MaxHijack, Stage, StageTime, Event]]) ->
    Len = byte_size(Name),
    {ok, pt:pack(42004, <<RoleId:64, Len:16, Name/binary, RoleLv:16, TruckLv:8, Employ:8, CurHijack:8, MaxHijack:8, Stage:8, StageTime:32, 
        (pack_event(Event))/binary>>)};

write(42005, [CurTruck, CurHijack, MaxHijack, BookNum, Stage, FreeTimes]) ->
    {ok, pt:pack(42005, <<CurTruck:8, CurHijack:8, MaxHijack:8, BookNum:32, Stage:8, FreeTimes:8>>)};

write(42006, [State]) ->
    {ok, pt:pack(42006, <<State:8>>)};

write(42007, [State]) ->
    {ok, pt:pack(42007, <<State:8>>)};

write(42008, [State]) ->
    {ok, pt:pack(42008, <<State:8>>)};

write(42009, [State]) ->
    {ok, pt:pack(42009, <<State:8>>)};

write(42011, [TruckList, News, Event, CurHijack, MaxHijack, CurTran, MaxTran]) ->
    {ok, pt:pack(42011, <<(pack_truck(TruckList))/binary, (pack_news(News))/binary, 
        (pack_event(Event))/binary, CurHijack:8, MaxHijack:8, CurTran:8, MaxTran:8>>)};

write(42012, [State]) ->
    {ok, pt:pack(42012, <<State:8>>)};

write(_Cmd, _) ->
    % ?ASSERT(false, [_Cmd]),
    not_match.


pack_truck(TruckList) ->
    <<(erlang:length(TruckList)):16, (pack_truck_1(TruckList))/binary>>.

pack_truck_1([]) -> <<>>;
pack_truck_1([[RoleId, Name, RoleLv, TruckLv, Employ, CurHijack, MaxHijack, Stage, StageTime, Event] | Left]) ->
    Len = byte_size(Name),
    <<RoleId:64, Len:16, Name/binary, RoleLv:16, TruckLv:8, Employ:8, CurHijack:8, MaxHijack:8, Stage:8, StageTime:32, 
        (pack_event(Event))/binary, (pack_truck_1(Left))/binary>>;
pack_truck_1(_) -> <<>>.

pack_event(Event) ->
    <<(erlang:length(Event)):16, (pack_event_1(Event))/binary>>.

pack_event_1([]) -> <<>>;
pack_event_1([Event | Left]) ->
    <<Event:8, (pack_event_1(Left))/binary>>;
pack_event_1(_) -> <<>>.

pack_news(News) ->
    <<(erlang:length(News)):16, (pack_news_1(News))/binary>>.

pack_news_1([]) -> <<>>;
pack_news_1([News | Left]) when is_record(News, transport_news) ->
    Name = tool:to_binary(News#transport_news.performer_name),
    Len = byte_size(Name),
    <<(News#transport_news.no):8, (News#transport_news.timestamp):32, (News#transport_news.performer):64, Len:16, Name/binary, (pack_news_1(Left))/binary>>;
pack_news_1(_) -> <<>>.