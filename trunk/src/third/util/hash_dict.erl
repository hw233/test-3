-module(hash_dict).
-export([new/0,
         set/3,
         get/2,
         del/2,
         has_key/2,
         keys/1,
         size/1,
         fold/3,
         foreach/2,
         to_list_dict/1]).

new() ->
        dict:new().

set(Dict, Key, Value) ->
        Dict2 = 
        case dict:is_key(Key, Dict) of
                true ->
                        dict:erase(Key, Dict);
                false ->
                        Dict
        end,

        dict:append(Key, Value, Dict2).

get(Dict, Key) ->
        case dict:is_key(Key, Dict) of
                true ->
                        lists:nth(1, dict:fetch(Key, Dict));
                false ->
                        undef
        end.
        
del(Dict, Key) ->
        dict:erase(Key, Dict).

has_key(Dict, Key) ->
        dict:is_key(Key, Dict).

keys(Dict) ->
        dict:fetch_keys(Dict).

size(Dict) ->
        dict:size(Dict).
        
fold(Fun, State, Dict) ->
        dict:fold(fun(Key, Value, State2) ->
                        Fun(Key, lists:nth(1, Value), State2)
                  end, 
                  State, Dict).

foreach(Fun, Dict) ->
        dict:fold(fun(Key, Value, _State) ->
                        Fun(Key, lists:nth(1, Value))
                  end, 
                  null, Dict).

to_list_dict({dict, _, _, _, _, _, _, _, _} = Dict) ->
        dict:fold(fun(Key, Value, State) ->
                        list_dict:set(State, Key, to_list_dict(lists:nth(1, Value)))
                  end,
                  list_dict:new(),
                  Dict);

to_list_dict(Dict) ->
        Dict.