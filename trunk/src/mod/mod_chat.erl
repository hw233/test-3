-module(mod_chat).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start_link/0,
		ban_sensitive/3
        ]).

-compile(export_all).

-include("debug.hrl").
-include("common.hrl").

-record(state, {updatetime, sensitive_words = []}).

%% 因为目前是比较更新时间戳，所以暂时定义同步间隔时间为1分钟一次
-define(TIME_INTERVAL_UPDATETIME, 10).

%% API
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


init_ban_phone(Account, FromPid) ->
	gen_server:cast(?MODULE, {init_ban_phone, Account, FromPid}).

%% 聊天信息敏感词处理
ban_sensitive(PlayerId, Account, Msg) ->
	gen_server:cast(?MODULE, {chat_sensitive, PlayerId, Account, Msg}).

ban_chat_phone(RoleId, Time) ->
	gen_server:cast(?MODULE, {ban_chat_phone, RoleId, Time}).

%% ===================================================================================================
    
init([]) ->
    process_flag(trap_exit, true),
	%% 初始化定时器
    mod_timer:reg_loop_msg(self(), ?TIME_INTERVAL_UPDATETIME * 1000),
    {ok, #state{}}.


handle_cast(Msg, State) ->
	try
		do_handle_cast(Msg, State)
	catch
		Error:Reason ->
			?ERROR_MSG("Error : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
			{noreply, State}
	end.



handle_call(_R, _From, State) ->
    ?ASSERT(false, _R),
    {reply, ok, State}.

handle_info(doloop, #state{updatetime = UpdatetimeOld} = State) ->
	%% 定时检查updatetime是否有改变，相应同步最新数据
	ControlUrl = config:get_admin_addr_control_server(),
	case sync_updatetime(ControlUrl) of
		{ok, Updatetime} when UpdatetimeOld =/= Updatetime ->
			%% 最后更新时间有变化，同步最新数据
			case sync_sensitive(ControlUrl) of
				{ok, WordList} ->
					{noreply, State#state{updatetime = Updatetime, sensitive_words = WordList}};
				error ->
					{noreply, State}
			end;
		_ ->
			{noreply, State}
	end;

handle_info(_R, State) ->
    {noreply, State}.


terminate(Reason, _State) -> 
    case Reason of
        normal -> skip;
        shutdown -> skip;
        {shutdown, _} -> skip;
        _ ->
            ?ERROR_MSG("[~p] !!!!!terminate!!!!! for reason: ~w", [?MODULE, Reason])
    end,
    ok.


code_change(_OldVsn, State, _Extra)->
    {ok, State}.



%% 检查敏感词，账号和手机号禁言（如果有绑定）
do_handle_cast({chat_sensitive, PlayerId, Account, Msg}, #state{sensitive_words = SensitiveWords} = State) ->
	case verify_sensitive(SensitiveWords, Msg) of
		illegal ->
			%% 先本服禁言
			Reason = "玩家发送敏感词",
			player:ban_chat(PlayerId, -1, Reason),
			%% 非法文字，禁言此号以及手机号（如果已绑定），通过http接口将要禁言的账号传过去
			ban_phone(Account),
			ok;
		legal ->
			%% 没有问题
			ok
	end,
	{noreply, State};

do_handle_cast({init_ban_phone, Account, FromPid}, State) ->
	ControlUrl = config:get_admin_addr_control_server(),
	Path = "/BanChatPhone/CheckPhone",
	Url = lists:concat([ControlUrl, Path]),
	%% 加上个时间戳和login key组成的字符串md5做校验
	Arguments = [{account, Account}],
	case util:request_get(Url, Arguments) of
		{ok, {{_NewVersion, 200, _NewReasonPhrase}, _NewHeaders, NewBody}} ->
			case rfc4627:decode(NewBody) of
				{ok, Object, []} ->
					{ok, Result} = rfc4627:get_field(Object, "result"),
					case util:to_binary(Result) of
						<<"0">> ->% 没绑定手机号，需要绑定或者充钱
							gen_server:cast(FromPid, {ban_chat_phone, 0});
						<<"1">> ->% 绑定了被禁言的手机号
							gen_server:cast(FromPid, {ban_chat_phone, 1});
						<<"2">> ->% 已绑定了手机号且不在被禁列表，可以讲话
							gen_server:cast(FromPid, {ban_chat_phone, 2});
						_ ->
							ok
					end;
				Err ->
					?ERROR_MSG("chat sensitive err : ~p~n", [Err]),
					error
			end;
		Err ->
			%% 请求接口数据出错，
			?ERROR_MSG("Err : ~p~n", [Err]),
			error
	end,
	{noreply, State};

do_handle_cast({ban_chat_phone, RoleId, Time}, State) ->
	case db:select_row(player, "accname", [{id, RoleId}]) of
		[Account] ->
			case Time of
				-1 ->
					ban_phone(Account);
				0 ->
					%% 解禁的时候需要重新初始化手机号禁言状态
					unban_phone(Account),
					case player:is_online(RoleId) of
						true ->
							FromPid = player:get_pid(RoleId),
							do_handle_cast({init_ban_phone, Account, FromPid}, State);
						false -> 
							ok
					end;
				_ ->
					ok
			end;
		_ ->
			ok
	end,
	
	{noreply, State};

do_handle_cast(_R, State) ->
    ?ASSERT(false, _R),
    {noreply, State}.




verify_sensitive([], _Msg) ->
	legal;

verify_sensitive([Word|SensitiveWords], Msg) ->
	
	case re:run(Msg, Word, [unicode]) of
		nomatch ->
			verify_sensitive(SensitiveWords, Msg);
		_->
			illegal
	end.


sync_updatetime() ->
	ControlUrl = config:get_admin_addr_control_server(),
	sync_updatetime(ControlUrl).

sync_updatetime(ControlUrl) ->
	PathUpdatetime = "/ChatSensitive/GetUpdatetime",
	UrlUpdatetime = lists:concat([ControlUrl, PathUpdatetime]),
	Params = [],
	case util:request_get(UrlUpdatetime, Params) of
		{ok, {{_NewVersion, 200, _NewReasonPhrase}, _NewHeaders, NewBody}} ->
			case rfc4627:decode(NewBody) of
				{ok, Object, []} ->
					{ok, Updatetime} = rfc4627:get_field(Object, "updatetime"),
					{ok, Updatetime};
				Err ->
					?ERROR_MSG("chat sensitive err : ~p~n", [Err]),
					error
			end;
		Err ->
			%% 请求接口数据出错，
			?ERROR_MSG("Err : ~p~n", [Err]),
			error
	end.


sync_sensitive() ->
	ControlUrl = config:get_admin_addr_control_server(),
	sync_sensitive(ControlUrl).

sync_sensitive(ControlUrl) ->
	PathUpdatetime = "/ChatSensitive/GetList",
	UrlUpdatetime = lists:concat([ControlUrl, PathUpdatetime]),
	Params = [],
	case util:request_get(UrlUpdatetime, Params) of
		{ok, {{_NewVersion, 200, _NewReasonPhrase}, _NewHeaders, NewBody}} ->
			{ok, ObjList, _Remainder} = rfc4627:decode(NewBody),
			WordList = 
				lists:foldl(fun(Obj, Acc) ->
									{ok, Word} = rfc4627:get_field(Obj, "word"),
									[Word|Acc]
							end, [], ObjList),
			{ok, WordList};
		Err ->
			%% 请求接口数据出错，
			?ERROR_MSG("Err : ~p~n", [Err]),
			error
	end.

ban_phone(Account) ->
	ControlUrl = config:get_admin_addr_control_server(),
	Path = "/BanChatPhone/BanPhone",
	Url = lists:concat([ControlUrl, Path]),
	%% 加上个时间戳和login key组成的字符串md5做校验
	Arguments = [{account, Account}],
	util:request_get(Url, Arguments).

unban_phone(Account) ->
	ControlUrl = config:get_admin_addr_control_server(),
	Path = "/BanChatPhone/UnBanPhone",
	Url = lists:concat([ControlUrl, Path]),
	%% 加上个时间戳和login key组成的字符串md5做校验
	Arguments = [{account, Account}],
	util:request_get(Url, Arguments).





