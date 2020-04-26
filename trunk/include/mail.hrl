-ifndef(MAIL_HRL).
-define(MAIL_HRL, mail_hrl).


%% --------------- struct_name -------------------
-define(ETS_MAIL_BRIEF, ets_mail_brief).
-define(ETS_MAIL, ets_mail).

-define(MAIL_TIMER_LIST, {mail, timer_list}).

%% --------------- state -------------------

-define(MAIL_ADD, 1).
-define(MAIL_DELETE, 2).

-define(CONTENT_LENGTH, 2550).
-define(TITLE_LENGTH, 1000).
%% 邮件不再限制附件数量 20191220 zjy
-define(MAX_ATTACH_NUM, 9999).
%% -define(MAX_ATTACH_NUM, 4).

-define(UN_READ, 0).
-define(READ, 1).

-define(MAIL_SYS, 1).
-define(MAIL_PRI, 2).

-define(MAIL_COST_MONEY, 100).      % 邮资

-define(MAIL_TIMING, 1800000).     % 定期清理邮件间隔(ms) 1800000

-define(MAIL_SYS_LIFETIME, 2592000).   %系统邮件生命周期(sec)(2592000)
-define(MAIL_PRI_LIFETIME, 2592000).   %私人邮件生命周期(sec)

-define(MAIL_SYS_ID, 0).            % 系统邮件默认ID
-define(MAIL_SYS_NAME, <<"系统">>). % 系统邮件默认名字  

-define(GET_MAIL_COUNT(Type),
    case Type of
        ?MAIL_SYS -> ?MAIL_MAX_SYS_COUNT;
        ?MAIL_PRI -> ?MAIL_MAX_PRI_COUNT
    end
    ).


-define(MAIL(MailId), {mail, MailId}).
-define(DEL_MAIL(MailId), {mail, del, MailId}).
-define(MAIL_ID_LIST, {mail, mail_id_list}).
-define(MAIL_CACHE, {mail, cache}).


%% --------------- length --------------------
-define(MAIL_MAX_SYS_COUNT, 500).         % 系统邮件最大上限数500
-define(MAIL_MAX_PRI_COUNT, 100).         % 私人邮件最大上限数100

-define(MAIL_MAX_SYS_SHOW_COUNT, 30).         % 系统邮件最大显示上限数30
-define(MAIL_MAX_PRI_SHOW_COUNT, 30).         % 私人邮件最大显示上限数30

-define(NAME_LENGTH, 10).


%% --------------- record --------------------

-record(mail, {
    id = 0
    ,send_id = 0
    ,send_name = <<>>
    ,recv_id = 0
    ,recv_name = <<>>
    ,title = <<>>
    ,content = <<>>
    ,type = 0
    ,display_type = 0
    ,state = 0
    ,timestamp = 0
    ,attach = []
    }).

-record(mail_brief, {
    id = {0, 0}     %{role_id, mail_type}
    ,mails = []     %[MailId]
    }).

-record(mail_cache, {
    id = 0
    ,state = 0
    ,attach = []
    }).

-endif.