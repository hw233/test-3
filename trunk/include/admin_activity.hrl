-ifndef(ADMIN_ACTIVITY_HRL).
-define(ADMIN_ACTIVITY_HRL, admin_activity_hrl).


-record(admin_activity, {
    order_id = 0
    ,start_time = 0
    ,end_time = 0
    ,mail_title = <<>>
    ,mail_content = <<>>
    ,mail_attach = []
    ,client_start_time = 0
    ,client_end_time = 0
    ,client_content = <<>>
    }).

-record(admin_sys_activity, {
    order_id = 0
    ,timestamp = 0
    ,end_time = 0
    ,sys = 0
    ,content = []
    ,show_panel = <<>>
    ,display = 1
    }).

-record(admin_sys_activity_brief, {
    order_id = 0
    ,timestamp = 0
    ,end_time = 0
    ,state = 0      % 0 -> unopen 1 -> open
    }).

-record(role_admin_activity, {
    role_id = 0
    ,order_id_list = []
    }).


-record(admin_festival_activity, {
    order_id = 0
    ,no = 0
    ,start_time = 0
    ,end_time = 0
    ,type = 0
    ,content = []
    ,state = 0      % 0 -> unopen 1 -> open
    }).

-record(festival_activity_data, {
    no = 0
    ,lv = 0
    ,script = []
    }).

-record(admin_sys_set, {
    no = 0
    ,start_time = 0
    ,end_time = 0
    ,script = []
    }).

-define(AA_ACTIVE(Id), {admin_activity, Id}).

-define(AA_TIMER_INTERVAL, 5000).          % 检查运营活动时间间隔

-define(AA_FESTIVAL_FATHER_ACT, 0).         % 节日父活动

-define(AA_UNEFFICIENT, 0).         % 未生效活动
-define(AA_EFFICIENT, 1).           % 正在生效
-define(AA_OVERDUE, 2).             % 过期


-endif.