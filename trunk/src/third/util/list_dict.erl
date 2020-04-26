-module(list_dict).
-export([new/0,
         set/3,
         get/2,
         del/2,
         has_key/2,
         keys/1,
         size/1,
         fold/3,
         foreach/2,
         to_hash_dict/1]).

new() ->
        [{"cls", <<"l">>}].
        
set(Dict, Key, Value) ->
        Dict2 = del(Dict, Key),

        lists:append(Dict2, [{Key, Value}]).

get(Dict, Key) ->
        case lists:keyfind(Key, 1, Dict) of
                false ->
                        undef;
                {_Key2, Value} ->
                        Value
        end.

del(Dict, Key) ->
        case lists:keyfind(Key, 1, Dict) of
                false ->
                        Dict;
                Tuple ->
                        lists:delete(Tuple, Dict)
        end.

has_key(Dict, Key) ->
        case lists:keyfind(Key, 1, Dict) of
                false ->
                        false;
                _Other ->
                        true
        end.
        
keys(Dict) ->
        lists:foldl(fun({Key, _Value}, State) ->
                        case Key of
                                "cls" ->
                                        State;
                                _Other ->
                                        lists:append(State, [Key])
                        end
                    end,
                    [], Dict).

size(Dict) ->
        length(Dict) - 1.

fold(Fun, State, Dict) ->
        lists:foldl(fun({Key, Value}, State2) ->
                        case Key of
                                "cls" ->
                                        State2;
                                _Other ->
                                        Fun(Key, Value, State2)
                        end
                    end,
                    State, Dict).

foreach(Fun, Dict) ->
        lists:foreach(fun({Key, Value}) ->
                        case Key of
                                "cls" ->
                                        pass;
                                _Other ->
                                        Fun(Key, Value)
                        end
                    end,
                    Dict).

to_hash_dict([{"cls",<<"l">>}|_] = Dict) ->
        lists:foldl(fun({Key, Value}, State) ->
                        case Key of
                                "cls" ->
                                        State;
                                _Other ->
                                        hash_dict:set(State, Key, to_hash_dict(Value))
                        end
                    end,
                    hash_dict:new(), Dict);

to_hash_dict(Dict) ->
        Dict.