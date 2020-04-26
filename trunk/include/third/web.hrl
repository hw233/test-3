-ifndef(__WEB_H__).
-define(__WEB_H__, 0).

-define(BIND_ADDRESS,  app_opt:get_env(adm_bind_address, any)).
-define(SERVER_ROOT,   "./www/").
-define(DOCUMENT_ROOT, ?SERVER_ROOT).

-define(DIRECTORY_INDEX, ["index.html"]).

-define(ESI_ALIAS, "/esi-bin").

-define(REQ_TIMEOUT, 15).


-define(AUTH_USER_FILE,  "./3wconf/passwd").
-define(AUTH_GROUP_FILE, "./3wconf/authz").

-endif.