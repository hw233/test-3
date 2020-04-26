-module(web_svr).
-export([init/0, stop/0,
         add_esi/2, start/2]).

-include("web.hrl").

init() ->
        nosql:new(web),

        nosql:set(web, svrs, []),

        inets:start().

stop() ->
        WebSvrs = nosql:get(web, svrs),

        lists:foreach(fun(Pid) -> inets:stop(httpd, Pid) end, WebSvrs),

        inets:stop().

add_esi(ServerName, Module) ->
        ModulesKey = ServerName ++ "_modules",

        Modules =
        case nosql:get(web, ModulesKey) of
                undef ->
                        [];
                Other ->
                        Other
        end,

        nosql:set(web, ModulesKey,
                  lists:append(lists:delete(Module, Modules), [Module])).

start(Port, ServerName)->
        Modules =
        case nosql:get(web, ServerName ++ "_modules") of
                undef ->
                        [];
                Other ->
                        Other
        end,
        Options = 
            [{port,                  Port},
            {bind_address,          ?BIND_ADDRESS},
            {ipfamily,              inet},
            {server_name,           ServerName},
            {server_root,           ?SERVER_ROOT},
            {document_root,         ?DOCUMENT_ROOT},
            {directory_index,       ?DIRECTORY_INDEX},
            {erl_script_alias,      {?ESI_ALIAS, Modules}},
            {error_log,             "error_log"},
            {security_log,          "security_log"},
            {transfer_log,          "transfer_log"}],

        {Username, Password, Group} = get_user_info(),
        
        Options2 = 
            lists:append(Options, [{directory, {"/logs/", [{auth_type, plain},
                                                                 {auth_user_file, "."++?AUTH_USER_FILE},
                                                                 {auth_group_file, "."++?AUTH_GROUP_FILE},
                                                                 {auth_name, Username},
                                                                 {auth_access_password, Password},
                                                                 {require_user, [Username]},
                                                                 {require_group, [Group]}]}},
                                    {directory, {"/act_log/", [{auth_type, plain},
                                                                 {auth_user_file, "."++?AUTH_USER_FILE},
                                                                 {auth_group_file, "."++?AUTH_GROUP_FILE},
                                                                 {auth_name, Username},
                                                                 {auth_access_password, Password},
                                                                 {require_user, [Username]},
                                                                 {require_group, [Group]}]}}
                                    ]),

        {ok, Pid} = inets:start(httpd, Options2),

        nosql:set(web, svrs, lists:append(nosql:get(web, svrs), [Pid])),

        {ok, Pid}.


get_user_info() ->
        {ok, Passwd} = file:open(?AUTH_USER_FILE, [read]),
        
        [Username, Password] = string:tokens(io:get_line(Passwd, ""), ":"),

        file:close(Passwd),

        {ok, Authz} = file:open(?AUTH_GROUP_FILE, [read]),

        [Group, _] = string:tokens(io:get_line(Authz, ""), ":"),
        
        file:close(Authz),

        {Username, Password, Group}.