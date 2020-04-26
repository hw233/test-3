-ifndef (__BAN_HRL__).
-define(__BAN_HRL__, ban_hrl).

-record(banned_ip, {
    ip = ""
    ,end_time = 0
    }).

-record(banned_role, {
    role_id = 0
    ,end_time = 0
    }).

-endif.