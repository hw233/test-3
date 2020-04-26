-module(mysql_cache).
-export([insert/3,
         insert/2,
         insert_get_id/3,
         insert_get_id/2,
         replace/2,
         replace_get_id/2,
         update/5,
         update/3,
         delete/2,
         select/3,
         select/5]).

-define(MYSQL_CACHE_HOST, app_opt:get_env(mysql_cache_host, "127.0.0.1")).
-define(MYSQL_CACHE_PORT, app_opt:get_env(mysql_cache_port, 9995)).

-define(MYSQL_CACHE_URL, "http://" ++ ?MYSQL_CACHE_HOST ++ ":" ++ integer_to_list(?MYSQL_CACHE_PORT)).

-include("global2.hrl").
-include("log2.hrl").

format_field(Field) when is_list(Field) ->
        list_to_atom(Field);

format_field(Field) ->
        Field.

format_value(Value) when is_list(Value)->
        list_to_binary(Value);

format_value(Value) when is_binary(Value)->
        Value;

format_value(Value) when is_tuple(Value) ->
        list_to_binary(my_eapi:sprintf("~p", [Value]));

format_value(Value) when is_atom(Value) ->
        list_to_binary(atom_to_list(Value));

format_value(Value) ->
        Value.
        
format_value_op(Op) ->
        format_field(Op).

format_where_op(Op) ->
        format_value(Op).

format_field_value_list(FieldList, ValueList) ->
        {FieldValueList, _} = 
        lists:foldl(fun(Field, {FieldValueList2, Index}) ->
                        {lists:append(FieldValueList2, [{format_field(Field), format_value(lists:nth(Index, ValueList))}]), Index + 1}
                    end,
                    {[], 1}, FieldList),

        FieldValueList.

format_field_value_list(FieldValueList) ->
        lists:foldl(fun(FieldValuePair, FieldValueList2) ->
                        SubFieldValueList = 
                        case FieldValuePair of
                                {Field, Value} ->
                                        [{format_field(Field), format_value(Value)}];
                                {Field, Value, Op} ->
                                        [{format_field(Field), [format_value(Value), format_value_op(Op)]}];
                                _Other ->
                                        []
                        end,

                        lists:append(FieldValueList2, SubFieldValueList)
                    end,
                    [], FieldValueList).

format_where_list(WhereList) ->
        lists:foldl(fun(Where, WhereList2) ->
                        SubWhereList = 
                        case Where of
                                {Field, Value} ->
                                        [{format_field(Field), format_value(Value)}];
                                {Field, Op, Value} ->
                                        Value2 = 
                                        case Op of
                                                " like " ->
                                                        string:substr(Value, 2, length(Value) - 2);
                                                _Other ->
                                                        Value
                                        end,

                                        [{format_field(Field), [format_where_op(Op), format_value(Value2)]}];
                                _Other2 ->
                                        []
                        end,

                        lists:append(WhereList2, SubWhereList)
                    end,
                    [], WhereList).


json_dumps(fv, FieldList, ValueList) ->
        rfc4627:encode({obj, format_field_value_list(FieldList, ValueList)}).

json_dumps(fv, FieldValueList) ->
        rfc4627:encode({obj, format_field_value_list(FieldValueList)});

json_dumps(wh, WhereList) ->
        rfc4627:encode({obj, format_where_list(WhereList)}).

json_loads(MysqlResult) ->
        case rfc4627:decode(MysqlResult) of
                {ok, Ret, []} ->
                        Ret;
                _Other ->
                        null
        end.

assm_insert_url(Table, FieldList, ValueList) ->
        my_eapi:sprintf("~s/insert?table=~s&pairs=~s", [?MYSQL_CACHE_URL, Table, json_dumps(fv, FieldList, ValueList)]).

assm_insert_url(Table, FieldValueList) ->
        my_eapi:sprintf("~s/insert?table=~s&pairs=~s", [?MYSQL_CACHE_URL, Table, json_dumps(fv, FieldValueList)]).

insert(Table, FieldList, ValueList) ->
        ?DEBUG_LOG("[mysql_cache] insert into ~s values (~w ~w)", [Table, FieldList, ValueList]),

        Url = assm_insert_url(Table, FieldList, ValueList),

        ?DEBUG_LOG("[mysql_cache] insert url: ~s", [Url]),

        web_cli:urlopen_async(Url).

insert(Table, FieldValueList) ->
        ?DEBUG_LOG("[mysql_cache] insert into ~s values ~w", [Table, FieldValueList]),

        Url = assm_insert_url(Table, FieldValueList),

        ?DEBUG_LOG("[mysql_cache] insert url: ~s", [Url]),

        web_cli:urlopen_async(Url).

insert_get_id(Table, FieldList, ValueList) ->
        ?DEBUG_LOG("[mysql_cache] insert_get_id into ~s values (~w ~w)", [Table, FieldList, ValueList]),

        Url = assm_insert_url(Table, FieldList, ValueList),

        ?DEBUG_LOG("[mysql_cache] insert_get_id url: ~s", [Url]),

        Ret = web_cli:urlopen(Url),

        ?DEBUG_LOG("[mysql_cache] insert_get_id ret: ~s", [Ret]),

        list_to_integer(Ret).

insert_get_id(Table, FieldValueList) ->
        ?DEBUG_LOG("[mysql_cache] insert_get_id into ~s values ~w", [Table, FieldValueList]),

        Url = assm_insert_url(Table, FieldValueList),

        ?DEBUG_LOG("[mysql_cache] insert_get_id url: ~s", [Url]),

        Ret = web_cli:urlopen(Url),

        ?DEBUG_LOG("[mysql_cache] insert_get_id ret: ~s", [Ret]),
        
        list_to_integer(Ret).
        
assm_replace_url(Table, FieldValueList) ->
        my_eapi:sprintf("~s/replace?table=~s&pairs=~s", [?MYSQL_CACHE_URL, Table, json_dumps(fv, FieldValueList)]).

replace(Table, FieldValueList) ->
        ?DEBUG_LOG("[mysql_cache] replace into ~s values ~w", [Table, FieldValueList]),

        Url = assm_replace_url(Table, FieldValueList),

        ?DEBUG_LOG("[mysql_cache] replace url: ~s", [Url]),

        web_cli:urlopen_async(Url).

replace_get_id(Table, FieldValueList) ->
        ?DEBUG_LOG("[mysql_cache] replace_get_id into ~s values ~w", [Table, FieldValueList]),

        Url = assm_replace_url(Table, FieldValueList),

        ?DEBUG_LOG("[mysql_cache] replace_get_id url: ~s", [Url]),

        Ret = web_cli:urlopen(Url),

        ?DEBUG_LOG("[mysql_cache] replace_get_id ret: ~s", [Ret]),
        
        list_to_integer(Ret).

assm_update_url(Table, FieldList, ValueList, WhereField, WhereValue) ->
        my_eapi:sprintf("~s/update?table=~s&pairs=~s&where_pairs=~s", [?MYSQL_CACHE_URL, 
                                                                       Table, 
                                                                       json_dumps(fv, FieldList, ValueList),
                                                                       json_dumps(fv, [{WhereField, WhereValue}])]).

assm_update_url(Table, FieldValueList, WhereList) ->
        my_eapi:sprintf("~s/update?table=~s&pairs=~s&where_pairs=~s", [?MYSQL_CACHE_URL, 
                                                                       Table, 
                                                                       json_dumps(fv, FieldValueList),
                                                                       json_dumps(wh, WhereList)]).

update(Table, FieldList, ValueList, WhereField, WhereValue) ->
        ?DEBUG_LOG("[mysql_cache] update ~s set ~w = ~w where ~s = ~w", [Table, FieldList, ValueList, WhereField, WhereValue]),

        Url = assm_update_url(Table, FieldList, ValueList, WhereField, WhereValue),

        ?DEBUG_LOG("[mysql_cache] update url: ~s", [Url]),

        web_cli:urlopen_async(Url).

update(Table, FieldValueList, WhereList) ->
        ?DEBUG_LOG("[mysql_cache] update ~s set ~w where ~w", [Table, FieldValueList, WhereList]),

        Url = assm_update_url(Table, FieldValueList, WhereList),

        ?DEBUG_LOG("[mysql_cache] update url: ~s", [Url]),

        web_cli:urlopen_async(Url).

assm_delete_url(Table, WhereList) ->
        my_eapi:sprintf("~s/delete?table=~s&where_pairs=~s", [?MYSQL_CACHE_URL,
                                                              Table,
                                                              json_dumps(wh, WhereList)]).

delete(Table, WhereList) ->
        ?DEBUG_LOG("[mysql_cache] delete from ~s where ~w", [Table, WhereList]),

        Url = assm_delete_url(Table, WhereList),

        ?DEBUG_LOG("[mysql_cache] update url: ~s", [Url]),

        web_cli:urlopen_async(Url).

assm_select_url(Table, FieldsString, WhereList) ->
        my_eapi:sprintf("~s/select?table=~s&fields=~s&where_pairs=~s", [?MYSQL_CACHE_URL,
                                                                        Table,
                                                                        FieldsString, 
                                                                        json_dumps(wh, WhereList)]).

assm_select_url(Table, FieldsString, WhereList, OrderList, LimitNum) ->
        Url = assm_select_url(Table, FieldsString, WhereList),

        OrderBies = 
        lists:foldl(fun(OrderBy, OrderBies2) ->
                        case OrderBy of
                                {Field} ->
                                        lists:append(OrderBies2, [[Field, false]]);
                                {Field, desc} ->
                                        lists:append(OrderBies2, [[Field, true]]);
                                _Other ->
                                        OrderBies2
                        end
                    end,
                    [], OrderList),

        case length(OrderBies) of 
                0 ->
                        Url;
                _Other2 ->
                        Url2 = my_eapi:sprintf("~s&order_bies=~s", [Url, rfc4627:encode(OrderBies)]),
                        
                        case LimitNum of
                                [] ->
                                        Url2;
                                [LimitNum2] ->
                                        my_eapi:sprintf("~s&limit=[0,~p]", [Url2, LimitNum2])         
                        end
        end.

select(Table, FieldsString, WhereList) ->
        ?DEBUG_LOG("[mysql_cache] select ~s from ~p where ~w", [FieldsString, Table, WhereList]),

        Url = assm_select_url(Table, FieldsString, WhereList),

        ?DEBUG_LOG("[mysql_cache] select url: ~s", [Url]),

        Ret = web_cli:urlopen(Url),

        ?DEBUG_LOG("[mysql_cache] select ret: ~s", [Ret]),

        json_loads(Ret).

select(Table, FieldsString, WhereList, OrderList, LimitNum) ->
        ?DEBUG_LOG("[mysql_cache] select ~s from ~p where ~w order ~w limit ~w", [FieldsString, Table, WhereList, OrderList, LimitNum]),

        Url = assm_select_url(Table, FieldsString, WhereList, OrderList, LimitNum),

        ?DEBUG_LOG("[mysql_cache] select url: ~s", [Url]),

        Ret = web_cli:urlopen(Url),

        ?DEBUG_LOG("[mysql_cache] select ret: ~s", [Ret]),

        json_loads(Ret).