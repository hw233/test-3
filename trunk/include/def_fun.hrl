%% 常用函数定义
-ifndef(DEF_FUN_HRL).
-define(DEF_FUN_HRL, true).

%%-define(IF(EXPRESSION, Value1, Value2),
%%    case EXPRESSION of
%%        true -> Value1;
%%        false -> Value2
%%    end).


-define(GET(K), erlang:get({?MODULE, K})).
-define(GET(K, Default),
    case erlang:get({?MODULE, K}) of
        undefined -> Default;
        V -> V
    end).
-define(PUT(K, V), erlang:put({?MODULE, K}, V)).
-define(DEL(K), erlang:erase({?MODULE, K})).
-define(GET_KEYS(), [__K__ || {{?MODULE, __K__}, _} <- erlang:get()]).

-define(CHECK_BIT(Pos, Num),
    (((1 bsl (Pos -1)) band Num) =/= 0)
).

-define(ADD_BIT(Pos, Num),
    (Num bor (1 bsl (Pos - 1)))
).

-define(REMOVE_BIT(Pos, Num),
    (Num band( bnot (1 bsl (Pos - 1))))
).


%% 角色消息处理，封装统一返回错误码
-define(THROW_ECODE(ErrCode), throw({fail,ErrCode})).
-define(THROW_ECODE(ErrCode, ParamList), throw({fail,ErrCode,ParamList})).


%%-define(SYS_PARAM(Id),  erlang:element(2, system_param:get(Id))).


-endif.
