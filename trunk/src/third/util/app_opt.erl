-module(app_opt).
-export([start_app/1, 
         stop_app/1, 
         notify_app_stop/2,
         get_app/0, 
         get_env/3,
         get_env/2,
         get_env/1,
         set_env/2
        ]).

-include("global2.hrl").
-include("log2.hrl").

%%启动服务器
start_app(AppName) ->
        ?TRACE("[~p] start_app(~p)...", [AppName, AppName]),

        try
                ok = start_applications([sasl, AppName])
        after
                timer:sleep(100)
        end.

%%停止服务器
stop_app(AppName) ->
        ?TRACE("[~p] stop_app(~p)...", [AppName, AppName]),
    
        timer:sleep(100),

        ok = stop_applications([sasl, AppName]),
        
        erlang:halt().

%%通知服务器停止
notify_app_stop(MainMod, StopFunc) ->
        NodeList = init:get_plain_arguments(),
        
        F = 
        fun(StrNode) ->
                Node = my_eapi:list_to_atom2(StrNode),
                net_adm:ping(Node),

                ?TRACE("Stopping ~p app...", [StrNode]),

                rpc:call(Node, MainMod, StopFunc, [])
        end,
        
        [F(StrNode) || StrNode <- NodeList],

        erlang:halt().

%%管理应用
manage_applications(Iterate, Do, Undo, SkipError, ErrorTag, Apps) ->
        Iterate(fun (App, Acc) ->
                        case Do(App) of
                                ok -> [App | Acc];%合拢
                                {error, {SkipError, _}} -> Acc;
                                {error, Reason} ->
                                        lists:foreach(Undo, Acc),
                                        throw({error, {ErrorTag, App, Reason}})
                        end
                end, [], Apps),
        
        ok.

%%启动应用
start_applications(Apps) ->
        manage_applications(fun lists:foldl/3,
                            fun application:start/1,
                            fun application:stop/1,
                            already_started,
                            cannot_start_application,
                            Apps).

%%停止应用
stop_applications(Apps) ->
        manage_applications(fun lists:foldr/3,
                            fun application:stop/1,
                            fun application:start/1,
                            not_started,
                            cannot_stop_application,
                            Apps).


get_app() ->
        case application:get_application() of
                {ok, App} ->
                        App;
                _Other ->
                        undef
        end.

get_env(App, Key, Default) ->
        case App of 
                undef ->
                        Default;
                _Other ->
                        case application:get_env(App, Key) of
                                {ok, Value} ->
                                        Value;
                                _Other2 ->
                                        Default
                        end
        end.

get_env(Key, Default) ->
        get_env(get_app(), Key, Default).

get_env(Key) ->
        get_env(Key, undef).

set_env(Key, Val) ->
    set_env(get_app(), Key, Val).

set_env(App, Key, Val) ->
    application:set_env(App, Key, Val).