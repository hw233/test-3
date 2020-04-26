-module (pt_59).

-export([write/2, read/2]).

-include ("common.hrl").

read(59001, <<No:8>>) ->
    {ok, [No]};

read(59002, <<No:8>>) ->
    {ok, [No]};

read(59003, _) ->
    {ok, []};

read(59005, <<Type:8>>) ->
    {ok, [Type]};

read(59006, <<No:8 ,Type:8>>) ->
    {ok, [No, Type]};

read(59007, _) ->
    {ok, []};

read(59101, _Data) ->
    {ok, []};

read(59200, _) ->
    {ok, []};



read(59201, <<No:8>>) ->
    {ok, [No]};

read(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]),
    not_match.

 write(59001, [ChapterNo, RwdState, List]) ->
    Len = erlang:length(List),
    BinList = tool:to_binary([<<ChiNo:16, CurNum:32, MaxNum:32>> || {ChiNo, CurNum, MaxNum} <- List]),
    {ok, pt:pack(59001, <<ChapterNo:8, RwdState:8, Len:16, BinList/binary>>)};


write(59002, [ChapterNo, Flag]) ->
    {ok, pt:pack(59002, <<ChapterNo:8, Flag:8>>)};


write(59003, [List]) ->
    Len = erlang:length(List),
    BinList = tool:to_binary([<<ChiNo:8, Flag:8>> || {ChiNo, Flag} <- List]),
    {ok, pt:pack(59003, <<Len:16, BinList/binary>>)};

write(59004, [No]) ->
    {ok, pt:pack(59004, <<No:16>>)};

write(59005, [ChapterNo, Flag]) ->
    {ok, pt:pack(59005, <<ChapterNo:8, Flag:8>>)};


write(59006, [FlagBuy, FlagRecharge]) ->
    {ok, pt:pack(59006, <<FlagBuy:32, FlagRecharge:8>>)};

write(59007, [No]) ->
    {ok, pt:pack(59007, <<No:8>>)};

write(59101, [DataList]) ->
    Len = erlang:length(DataList),
    Bin = <<<<DunNo:32, Pass:8, Times:16, DunTimes:16>> || {DunNo, Pass, Times, DunTimes} <- DataList>>,
    {ok, pt:pack(59101, <<Len:16, Bin/binary>>)};

write(59102, [List]) ->
    Len = erlang:length(List),
    BinData = <<<<Id:64, No:32, Num:16, Qua:8, Bind:8>> || {Id, No, Num, Qua, Bind} <- List>>,
    {ok, pt:pack(59102, <<Len:16, BinData/binary>>)};

write(59200, [State1, State2]) ->
    {ok, pt:pack(59200, <<State1:64, State2:64>>)};



write(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]),
    not_match.