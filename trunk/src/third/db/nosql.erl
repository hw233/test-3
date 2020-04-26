-module(nosql).
-export([new/1, 
         set/3, 
         get/2, 
         del/2, 
         exists/2,
         foldl/3]).

-record(pair, {key, value}).

new(Name) ->
        ets:new(Name, [public, set, named_table, {keypos, #pair.key}]).

set(Name, Key, Value) ->
        ets:insert(Name, #pair{key=Key, value=Value}).

get(Name, Key) ->
        Rets = ets:lookup(Name, Key),

        case length(Rets) of 
                0 ->
                        undef;
                _Other ->
                        [Head | _Rests] = Rets,

                        Head#pair.value
        end.

del(Name, Key) -> 
        ets:delete(Name, Key).

exists(Name, Key) ->
        case length(ets:lookup(Name, Key)) of 
                0 -> 
                        false;
                _Other ->
                        true
        end.

foldl(Fun, State, Name) ->
        ets:foldl(fun(Pair, State2) ->
                        Fun(Pair#pair.key, Pair#pair.value, State2)
                  end,
                  State, Name).