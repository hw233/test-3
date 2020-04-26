-module(mod_mail).
% -behaviour(gen_server).

% -include("common.hrl").
% -include("record.hrl").
% -include("mail.hrl").

% -export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

% -record(state, {}).

% start_link() ->
%     gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

% %% init/1
% %% ====================================================================
% %% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:init-1">gen_server:init/1</a>
% -spec init(Args :: term()) -> Result when
%     Result :: {ok, State}
%             | {ok, State, Timeout}
%             | {ok, State, hibernate}
%             | {stop, Reason :: term()}
%             | ignore,
%     State :: term(),
%     Timeout :: non_neg_integer() | infinity.
% %% ====================================================================
% init([]) -> {ok, #state{}}.


% %% handle_call/3
% %% ====================================================================
% %% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_call-3">gen_server:handle_call/3</a>
% -spec handle_call(Request :: term(), From :: {pid(), Tag :: term()}, State :: term()) -> Result when
%     Result :: {reply, Reply, NewState}
%             | {reply, Reply, NewState, Timeout}
%             | {reply, Reply, NewState, hibernate}
%             | {noreply, NewState}
%             | {noreply, NewState, Timeout}
%             | {noreply, NewState, hibernate}
%             | {stop, Reason, Reply, NewState}
%             | {stop, Reason, NewState},
%     Reply :: term(),
%     NewState :: term(),
%     Timeout :: non_neg_integer() | infinity,
%     Reason :: term().
% %% ====================================================================
% handle_call(_Request, _From, State) ->
%     Reply = ok,
%     {reply, Reply, State}.


% %% handle_cast/2
% %% ====================================================================
% %% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_cast-2">gen_server:handle_cast/2</a>
% -spec handle_cast(Request :: term(), State :: term()) -> Result when
%     Result :: {noreply, NewState}
%             | {noreply, NewState, Timeout}
%             | {noreply, NewState, hibernate}
%             | {stop, Reason :: term(), NewState},
%     NewState :: term(),
%     Timeout :: non_neg_integer() | infinity.
% %% ====================================================================
% handle_cast(_Msg, State) ->
%     {noreply, State}.


% %% handle_info/2
% %% ====================================================================
% %% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_info-2">gen_server:handle_info/2</a>
% -spec handle_info(Info :: timeout | term(), State :: term()) -> Result when
%     Result :: {noreply, NewState}
%             | {noreply, NewState, Timeout}
%             | {noreply, NewState, hibernate}
%             | {stop, Reason :: term(), NewState},
%     NewState :: term(),
%     Timeout :: non_neg_integer() | infinity.
% %% ====================================================================
% handle_info(timeout, State) ->
%     {noreply, State};

% handle_info(_Info, State) ->
%     {noreply, State}.


% %% terminate/2
% %% ====================================================================
% %% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:terminate-2">gen_server:terminate/2</a>
% -spec terminate(Reason, State :: term()) -> Any :: term() when
%     Reason :: normal
%             | shutdown
%             | {shutdown, term()}
%             | term().
% %% ====================================================================
% terminate(_Reason, _State) ->
%     ok.


% %% code_change/3
% %% ====================================================================
% %% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:code_change-3">gen_server:code_change/3</a>
% -spec code_change(OldVsn, State :: term(), Extra :: term()) -> Result when
%     Result :: {ok, NewState :: term()} | {error, Reason :: term()},
%     OldVsn :: Vsn | {down, Vsn},
%     Vsn :: term().
% %% ====================================================================
% code_change(_OldVsn, State, _Extra) ->
%     {ok, State}.


% %% ====================================================================
% %% Internal functions
% %% ====================================================================

% %% 加载所有玩家私人邮件和系统邮件摘要
% load_all_mail([]) ->
%     List = erase(),
%     load_data_in_memory(List);
% load_all_mail([[MailId, Timestamp, RoleId, Type] | Left]) ->
%     case get({RoleId, Type}) of
%         undefined -> put({RoleId, Type}, #mail_brief{id = {RoleId, Type}, num = 1, mails = [{MailId, Timestamp}]});
%         Rd ->
%             Num = Rd#mail_brief.num,
%             MailList = Rd#mail_brief.mails, 
%             put({RoleId, Type}, Rd#mail_brief{num = Num + 1, mails = [{MailId, Timestamp} | MailList]})
%     end,
%     load_all_mail(Left).


% load_data_in_memory([]) -> skip;
% load_data_in_memory([{Key, MailBrief} | Left]) ->
%     %% 邮件按时间降序排序
%     SortList = lists:reverse(lists:ukeysort(2, MailBrief#mail_brief.mails)),
%     lib_mail:set_mail_brief(MailBrief#mail_brief{mails = SortList}).
