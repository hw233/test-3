-module(my_eapi).
-export([list_to_atom2/1, 
         to_list/1,
         to_atom/1,
         sprintf/2, 
         string_to_binary/1, 
         send/2,
         cast/4,
         lists_foreach/3,
         add/2,
         cover/2]).

list_to_atom2(List) when is_list(List) ->
        case catch(list_to_existing_atom(List)) of
                {'EXIT', _} -> 
                        list_to_atom(List);
                Atom when is_atom(Atom) -> 
                        Atom
        end.

f2s(N) when is_integer(N) ->
        integer_to_list(N) ++ ".00";
f2s(F) when is_float(F) ->
        [A] = io_lib:format("~.2f", [F]),
        A.

to_list(Value) when is_list(Value) -> 
        Value;
to_list(Value) when is_atom(Value) -> 
        atom_to_list(Value);
to_list(Value) when is_binary(Value) -> 
        binary_to_list(Value);
to_list(Value) when is_integer(Value) -> 
        integer_to_list(Value);
to_list(Value) when is_float(Value) -> 
        f2s(Value);
to_list(_) ->
        throw(other_value).

to_atom(Value) when is_list(Value) ->
        list_to_atom(Value);

to_atom(Value) ->
        Value.

sprintf(Format, Args) ->
        lists:flatten(io_lib:format(Format, Args)).

string_to_binary(String) ->
        StringBin = list_to_binary(String),
        StringLen = byte_size(StringBin),

        <<StringLen:16, StringBin/binary>>.
        
send(Pid, Content) when is_pid(Pid) ->
        case erlang:is_process_alive(Pid) of 
                true ->
                        Pid ! Content;
                false ->
                        pass
        end;

send(_Pid, _Content) ->
        pass.

cast(Pid, Module, Method, Args) ->
        case erlang:is_process_alive(Pid) of
                true ->
                        gen_server:cast(Pid, {apply, Module, Method, Args}),

                        true;
                false ->
                        false
        end.
        
lists_foreach(_List, 0, _Fun, State) ->
        State;

lists_foreach(List, Index, Fun, State) ->
        State2 = Fun(lists:nth(Index, List), State),

        lists_foreach(List, Index - 1, Fun, State2).

lists_foreach(List, Fun, State) ->
        List2 = lists:reverse(List),
        
        lists_foreach(List2, length(List2), Fun, State).

alu_rd(Method, Value1, Value2) ->
        [Head1 | _Rest1] = tuple_to_list(Value1),
        [Head2 | _Rest2] = tuple_to_list(Value2),

        case (is_atom(Head1) and (Head1 == Head2)) of
                true ->
                        AluMod = list_to_atom2("alu_" ++ atom_to_list(Head1)),

                        apply(AluMod, Method, [Value1, Value2]);
                false ->
                        case Method of
                                add ->
                                        Value1;
                                cover ->
                                        Value2;
                                _Other ->
                                        Value1
                        end        
        end.

add(Value1, Value2) when (is_integer(Value1) or is_float(Value1)) and (is_integer(Value2) or is_float(Value2)) ->
        Value1 + Value2;

add(Value1, Value2) when is_list(Value1) and is_list(Value2) ->
        lists:append(Value1, Value2);

add(Value1, Value2) when is_tuple(Value1) and is_tuple(Value2) ->
        alu_rd(add, Value1, Value2);

add(Value1, _Value2) ->
        Value1.

cover(Value1, Value2) when is_list(Value1) and is_list(Value2) ->
        SetsValue1 = sets:from_list(Value1),
        SetsValue2 = sets:from_list(Value2),

        SetsValue = sets:union(SetsValue1, SetsValue2),

        sets:to_list(SetsValue);

cover(Value1, Value2) when is_tuple(Value1) and is_tuple(Value2) ->
        alu_rd(cover, Value1, Value2);

cover(_Value1, Value2) ->
        Value2.