%% @author Administrator
%% @doc @todo Add description to sm_invisible.
%% 防泄漏处理，在线授权，自我保护，密文通信

-module(sm_gateway_srv).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-include("common.hrl").
%% 定义des3的key和ivec，都要8位
-define(KEY1,			<<"9iu7$#@!">>).
-define(KEY2,			<<"%gT%43H~">>).
-define(KEY3,			<<"OI))_+_?">>).
-define(IVEC,			<<"~!zxx23^">>).	

%% remote auth address
-define(SECURTIY_START_SERVER_URL, lists:concat([i,m,v,i,s,i,b,l,e,".",j,i,n,k,e,h,c,".",c,o,m])).
%% -define(SECURTIY_START_SERVER_URL, "127.0.0.1").
-define(SECURTIY_START_SERVER_PORT, 48443).

-define(SECURITY_STRING, "xfTNoR7Oei!f0Ev@4yrvZPKW*iUOfQ$&GF$dI1LdlrE8FLydjk5X$SkKk&AriQ!FxEGQqPX361Ivqm53esqNqSYd#HfW3ribDAa").


-compile(export_all).
%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/0]).
start_security_server() ->
	start_listen().

start_link() ->
	Filename = "auth_imvisible",
	case file:read_file(Filename) of
		{error, enoent} ->
			%% 执行远程授权验证
			start();
		{ok, Binary} ->
			case util:to_binary(?SECURITY_STRING) of
				Binary ->
					start_listen(),
					true;
				_ ->
					false
			end	
	end.
%% 	gen_server:start_link(?MODULE, [], []).

%% ====================================================================
%% Behavioural functions
%% ====================================================================
-record(state, {auth, listen_socket}).

%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:init-1">gen_server:init/1</a>
-spec init(Args :: term()) -> Result when
	Result :: {ok, State}
			| {ok, State, Timeout}
			| {ok, State, hibernate}
			| {stop, Reason :: term()}
			| ignore,
	State :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
init([]) ->
	%% 启动安全进程，校验并初始化授权信息，如果根目录存在安全文件则开启授权服务器
	
	{ok, #state{}}.


%% handle_call/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_call-3">gen_server:handle_call/3</a>
-spec handle_call(Request :: term(), From :: {pid(), Tag :: term()}, State :: term()) -> Result when
	Result :: {reply, Reply, NewState}
			| {reply, Reply, NewState, Timeout}
			| {reply, Reply, NewState, hibernate}
			| {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason, Reply, NewState}
			| {stop, Reason, NewState},
	Reply :: term(),
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity,
	Reason :: term().
%% ====================================================================
handle_call(Request, From, State) ->
    Reply = ok,
    {reply, Reply, State}.


%% handle_cast/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_cast-2">gen_server:handle_cast/2</a>
-spec handle_cast(Request :: term(), State :: term()) -> Result when
	Result :: {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason :: term(), NewState},
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_cast({start_auth, ?FL_POLICY_FILE}, State) ->
	case start_listen() of
		{ok, ListenSock} ->
			{noreply, State#state{listen_socket = ListenSock}};
		{error, Reason} ->
			ok
	end;

handle_cast(Msg, State) ->
    {noreply, State}.


%% handle_info/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_info-2">gen_server:handle_info/2</a>
-spec handle_info(Info :: timeout | term(), State :: term()) -> Result when
	Result :: {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason :: term(), NewState},
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_info(Info, State) ->
    {noreply, State}.


%% terminate/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:terminate-2">gen_server:terminate/2</a>
-spec terminate(Reason, State :: term()) -> Any :: term() when
	Reason :: normal
			| shutdown
			| {shutdown, term()}
			| term().
%% ====================================================================
terminate(Reason, State) ->
    ok.


%% code_change/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:code_change-3">gen_server:code_change/3</a>
-spec code_change(OldVsn, State :: term(), Extra :: term()) -> Result when
	Result :: {ok, NewState :: term()} | {error, Reason :: term()},
	OldVsn :: Vsn | {down, Vsn},
	Vsn :: term().
%% ====================================================================
code_change(OldVsn, State, Extra) ->
    {ok, State}.


%% ====================================================================
%% Internal functions
%% ====================================================================
start_listen() ->
	case gen_tcp:listen(?SECURTIY_START_SERVER_PORT, ?TCP_OPTIONS) of
		{ok, ListenSocket} ->
			erlang:spawn(?MODULE, accept, [ListenSocket]),
			{ok, ListenSocket};
		{error, Reason} ->
			{error, Reason}
	end.


accept(ListenSocket) ->
	case gen_tcp:accept(ListenSocket) of
		{ok, Socket} ->
			erlang:spawn(?MODULE, loop, [Socket]),
			accept(ListenSocket);
		{error, Reason} ->
			?ERROR_MSG("{ListenSocket, Reason} : ~p~n", [{ListenSocket, Reason}]),
			accept(ListenSocket)
	end.

loop(Socket) ->
	Ip = misc:get_ip(Socket),
	Filename = "white_ip",
	case case file:consult(Filename) of
			 {ok, Terms} ->
				 case lists:member(Ip, Terms) of
					 true ->
						 true;
					 false ->
						 FilenameLog = "start_fail.log",
						 file:write_file(FilenameLog, lists:concat(["\n",Ip]), [append]),
						 false
				 end;
			 {error, Reason} ->
				 false
		 end of
		true ->
			Term = integer_to_list(util:unixtime()),
			{ok, Packet} = encrypto_des_cbc(Term),
			gen_tcp:send(Socket, Packet),
			util:sleep(2000),
			gen_tcp:close(Socket);
		false ->
			%% 不在白名单 记录下日志，暂且断开不管，后面补充一些措施，比如远程命令销毁自身？
			gen_tcp:close(Socket)
	end.	
			





%% init_auth(Url, Port) ->
start() ->
	%% 采用http通信？,使用对称加密？密钥？DES3
	%% 	util:actin_new_proc(Mod, Func, Args)
	case gen_tcp:connect(?SECURTIY_START_SERVER_URL, ?SECURTIY_START_SERVER_PORT, [binary, {packet, 0}]) of
		{ok, Socket} ->
			%% 连接后等待返回数据包即可
			receive
				{tcp, Socket, Packet} ->
					try
						{ok, ServerTime0} = decrypto_des_cbc(Packet),
						ServerTime = binary_to_integer(ServerTime0),
						Unixtime = util:unixtime(),
						%% 时间误差在五分钟内，只适合同时区？
						erlang:abs(ServerTime - Unixtime) < 300,
						true
					catch
						E:R ->
							%% 解密失败，无法与服务器正常通信，执行后续措施
							false
					end;
				{tcp_closed, Socket} ->
					%% 网络断开，后续措施
					false
			after 3000 ->
				%% 网络通信超时，后续措施
				false
			end;
		{error, Reason} ->
			%% 无法连接授权服务器，在线授权失败，处理
			false
	end.

ad(Text) ->
	crypto:aes_cbc_128_encrypt(?KEY3, ?IVEC, Text).

ae(Cipher) ->
	crypto:aes_cbc_128_decrypt(?KEY3, ?IVEC, Cipher).

be(Text) ->
	crypto:blowfish_cbc_encrypt(?KEY3, ?IVEC, Text).

bd(Text) ->
	crypto:blowfish_cbc_decrypt(?KEY3, ?IVEC, Text).

de(Text) ->
	crypto:des3_cbc_encrypt(?KEY1, ?KEY2, ?KEY3, ?IVEC, Text).

dd(Cipher) ->
	crypto:des3_cbc_decrypt(?KEY1, ?KEY2, ?KEY3, ?IVEC, Cipher).


%% des 加密
encrypto_des_cbc(PlainText) ->
    IVec = <<1,2,3,4,5,6,7,8>>,

    %% 按DES规则，补位
    N = 8 - (byte_size(list_to_binary(PlainText)) rem 8),
    PlainText2 = lists:append(PlainText, get_padding(N)),
    %% 加密
    Ciphertext = crypto:des3_cbc_encrypt(?KEY1, ?KEY2, ?KEY3, IVec, PlainText2),
%% 	Ciphertext = crypto:block_encrypt(des_cbc, Key2, Ivec, PlainText2),
    {ok, Ciphertext}.


%% des 解密
decrypto_des_cbc(Ciphertext) ->
    IVec = <<1,2,3,4,5,6,7,8>>, 
    case is_list(Ciphertext) of
        true ->
            CipherBin = list_to_binary(Ciphertext);
        false ->
            CipherBin = Ciphertext
    end,

	PlainAndPadding = crypto:des3_cbc_decrypt(?KEY1, ?KEY2, ?KEY3, IVec, CipherBin),
%%     PlainAndPadding = crypto:block_decrypt(des_cbc,Key2,Ivec,CipherBin), %% 这是新版的erlang方法，因未升级otp版本，故使用旧接口
    <<PosLen/integer>> = binary_part(PlainAndPadding,{size(PlainAndPadding),-1}),
    Len = byte_size(PlainAndPadding) - PosLen,
    <<PlainText:Len/binary, _:PosLen/binary>> = PlainAndPadding,
    {ok, PlainText}.
    

get_padding(N) ->
    case N of
        0 ->
            get_padding2(8,8,[]);
        Num ->
            get_padding2(Num,Num,[])
    end.
    
get_padding2(N, Val, PaddingList) when N > 0 ->
    get_padding2(N-1, Val, [Val] ++ PaddingList);
get_padding2(N, _Val,PaddingList) when N == 0 ->
    PaddingList.


make_file() ->
	Filename = "auth_imvisible",
	file:write_file(Filename, ?FL_POLICY_FILE).

