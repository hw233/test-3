%%%-----------------------------------
%%% @Module  : pt
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.29
%%% @Description: 协议公共函数
%%%-----------------------------------
-module(pt).
-export([
        read_string/1            
        ,pack/2
        ,read_bytes/1
        ,read_uint8/1
        ,read_int16/1
        ,read_uint16/1
        ,read_int32/1
        ,read_uint32/1
        ,read_int64/1
        ,read_array/2
        ,decode/2       % 对应在read函数里面调用
        ,encode/2       % 对应在write函数里面调用
        ,unpack_array/2 % 解包数组
        ,pack_array/2   % 封包数组
        ,string_to_binary/1
        ,calc_check_code/2
        ]).

-include("common.hrl").
%%-include("record.hrl").
%%-include("ets_name.hrl").
-include("num_limits.hrl").


%%读取字符串
read_string(Bin) ->
    case Bin of
        <<Len:16, Bin1/binary>> ->
            case Bin1 of
                <<Str:Len/binary-unit:8, Rest/binary>> ->
                    {binary_to_list(Str), Rest};
                _ ->
                	?ASSERT(false, Bin),
                    {[],<<>>}
            end;
        _ ->
        	?DEBUG_MSG("read_string() error! Bin:~p, stacktrace:~w", [Bin, erlang:get_stacktrace()]),
            {[],<<>>}
    end.




%% 打包消息
%% @para: Cmd => 协议号
%%        BinData => 协议体
%% @return：前2个字节为协议号，接着的一个字节为压缩标记（1表示有压缩，0表示没有压缩），后面的为协议体
pack(Cmd, BinData) ->
	?ASSERT(Cmd =< ?MAX_U16, {Cmd, BinData}),
	?ASSERT(is_binary(BinData), {Cmd, BinData}),
	% Len = byte_size(BinData) + 5,
%%  	pack_stat(Cmd, Len),
	
	if
% 		Cmd == 12002 andalso Len >= 1024 ->
% 			NewData = zlib:compress(BinData),
			
% %% 			Len2 = byte_size(NewData) + 5,
% %% 			pack_compress_stat(Cmd, Len, Len2),
			
% 			<<Cmd:16, 1:8, NewData/binary>>;
% 		Cmd == 15010 andalso Len >= 400 ->
% 			NewData = zlib:compress(BinData),
			
% %% 			Len2 = byte_size(NewData) + 5,
% %% 			pack_compress_stat(Cmd, Len, Len2),
			
% 			<<Cmd:16, 1:8, NewData/binary>>;
% 		Cmd == 30000 andalso Len >= 400 ->
% 			NewData = zlib:compress(BinData),
			
% %% 			Len2 = byte_size(NewData) + 5,
% %% 			pack_compress_stat(Cmd, Len, Len2),
			
% 			<<Cmd:16, 1:8, NewData/binary>>;

		true ->
			<<Cmd:16, 0:8, BinData/binary>>
	end.

%% 统计输出数据包 
% pack_stat(Cmd, Size) ->
% %% 	if Cmd =/= 10006 andalso Cmd =/= 12008 ->
% %% 		?INFO_MSG("~s_write_[~p] ",[misc:time_format(erlang:now()), Cmd]);
% %%    		true -> no_out
% %% 	end,
% 	[NowBeginTime, NowEndTime, NowCount, NowMinSize, NowMaxSize, NowSumSize] = 
% 	case ets:match(?ETS_STAT_SOCKET,{Cmd, socket_out , '$3', '$4', '$5', '$6', '$7', '$8'}) of
% 		[[OldBeginTime, _OldEndTime, OldCount, OldMinSize, OldMaxSize, OldSumSize]] ->
% 			MinSize = erlang:min(Size, OldMinSize),
% 			MaxSize = erlang:max(Size, OldMaxSize),
			
% 			[OldBeginTime, erlang:now(), OldCount+1, MinSize, MaxSize, OldSumSize+Size];
% 		_ ->
% 			Now = erlang:now(),
% 			[Now, Now, 1, Size, Size, Size]
% 	end,	
% 	ets:insert(?ETS_STAT_SOCKET, {Cmd, socket_out, NowBeginTime, NowEndTime, NowCount, NowMinSize, NowMaxSize, NowSumSize}).

%% 统计数据包压缩
% pack_compress_stat(Cmd, OrgSize, ComSize) ->
% 	[NowMinOrgSize, NowMinComSize, NowMaxOrgSize, NowMaxComSize] = 
% 	case ets:match(?ETS_STAT_COMPRESS,{Cmd, socket_compress , '$3', '$4', '$5', '$6'}) of
% 		[[OldMinOrgSize, OldMinComSize, OldMaxOrgSize, OldMaxComSize]] ->
% 			MinOrgSize = erlang:min(OrgSize, OldMinOrgSize),
% 			MinComSize = erlang:min(ComSize, OldMinComSize),
			
% 			MaxOrgSize = erlang:max(OrgSize, OldMaxOrgSize),
% 			MaxComSize = erlang:max(ComSize, OldMaxComSize),
			
% 			[MinOrgSize, MinComSize, MaxOrgSize, MaxComSize];
% 		_ ->
% 			[OrgSize, ComSize, OrgSize, ComSize]
% 	end,	
% 	ets:insert(?ETS_STAT_COMPRESS, {Cmd, socket_compress, NowMinOrgSize, NowMinComSize, NowMaxOrgSize, NowMaxComSize}).

% read_str_bin(<<L:16, Bin/binary>>) ->
%     split_binary(Bin, L).

read_bytes(<<L:16, Bin/binary>>) ->
    split_binary(Bin, L).

read_uint8(<<N:8, Bin/binary>>) -> {N, Bin}.

read_int16(<<N:16/signed, Bin/binary>>) -> {N, Bin}.

read_uint16(<<N:16, Bin/binary>>) -> {N, Bin}.

read_int32(<<N:32/signed, Bin/binary>>) -> {N, Bin}.

read_uint32(<<N:32, Bin/binary>>) -> {N, Bin}.

read_int64(<<N:64/float, Bin/binary>>) -> {N, Bin}.


%% !!! 下面的 unpack_array函数 是一样的
%% 解析数组（注意：上层函数须确保传入的SrcBin参数是合法的！）
%% @para: DataTypeSeq_EachEle => 数组元素的数据类型序列， 如：[u8, string, u32]
%%        目前支持的类型有： u8, u16, u32, u64, int8, int16, int32, int64, string
%% @return: {元素列表，剩余未解析的Bin数据}
%% 例子： 调用read_array(SrcBin, [u8])， 则返回值形如（假设数组含三个元素）：{ [8, 100, 23],  BinLeft }
%%        调用read_array(SrcBin, [string])， 则返回值形如（假设数组含三个元素）：{ ["hello", "hihi", "how are you"],  BinLeft }
%%        调用read_array(SrcBin, [u8, u32])， 则返回值形如（假设数组含三个元素）：{ [{2, 999}, {32, 1500}, {10, 900}],  BinLeft }
%%        调用read_array(SrcBin, [u8, u32, string])， 则返回值形如（假设数组含两个元素）：{ [{2, 9999, "abc"}, {32, 1500, "hello"}],  BinLeft }
read_array(SrcBin, DataTypeSeq_EachEle) ->
	?ASSERT(is_binary(SrcBin) andalso byte_size(SrcBin) > 0),
	?ASSERT(is_list(DataTypeSeq_EachEle) andalso DataTypeSeq_EachEle /= []),
	<<N:16, Bin/binary>> = SrcBin,
	read_array__(N, Bin, [], DataTypeSeq_EachEle).

read_array__(0, Bin, AccEleList, _DataTypeSeq_EachEle) ->
	{lists:reverse(AccEleList), Bin};
read_array__(N, Bin, AccEleList, DataTypeSeq_EachEle) ->
	{Element, BinLeft}  = parse_array_ele(Bin, DataTypeSeq_EachEle),
	read_array__(N - 1, BinLeft, [Element | AccEleList], DataTypeSeq_EachEle).



%% 解析数组的元素
parse_array_ele(Bin, DataTypeSeq_EachEle) ->
	parse_array_ele__(Bin, DataTypeSeq_EachEle, []).

parse_array_ele__(Bin, [], AccDataListOfEle) ->
	Element = case AccDataListOfEle of
				  [OneDataOnly] -> OneDataOnly;
				  _ -> list_to_tuple(lists:reverse(AccDataListOfEle))
			  end,
	{Element, Bin};
parse_array_ele__(Bin, [DataType | T], AccDataListOfEle) ->
	case DataType of
		u8 ->
			<<Data:8, BinLeft/binary>> = Bin;
		u16 ->
			<<Data:16, BinLeft/binary>> = Bin;
		u32 ->
			<<Data:32, BinLeft/binary>> = Bin;
		u64 ->
			<<Data:64, BinLeft/binary>> = Bin;
		int8 ->
			<<Data:8/signed, BinLeft/binary>> = Bin;
		int16 ->
			<<Data:16/signed, BinLeft/binary>> = Bin;
		int32 ->
			<<Data:32/signed, BinLeft/binary>> = Bin;
		int64 ->
			<<Data:64/signed, BinLeft/binary>> = Bin;
		string ->
			{Data, BinLeft} = read_string(Bin)
	end,
	parse_array_ele__(BinLeft, T, [Data | AccDataListOfEle]).

	

string_to_binary(String) ->
    Bin = tool:to_binary(String),
    <<(byte_size(Bin)):16, Bin/binary>>.
	
%%=====================================================================
%% 封包解包函数
%%=====================================================================
%% 使用例子:  
%    read(12001, Bin) -> 
%        {ok, pt:decode(Bin, [u32,u16,u16])};
    
decode(Bin, Pattern) -> 
    {[Data], <<>>} = unpack_array(<<1:16, Bin/binary>>, Pattern),
    tuple_to_list(Data).

%% 使用例子:
%    write(12001=Cmd, Data) ->
%        Bin = pt:encode(Data, [u64,u16,u16]),
%        {ok, <<(byte_size(Bin)+6):32, Cmd:16, Bin/binary>>};

encode(Data, Pattern) ->
    <<1:16, Bin/binary>> = pack_array([list_to_tuple(Data)], Pattern),
    Bin.


%% 解包数组（支持嵌套数组） Pattern: [8,16,32,string, [...]] string表示字符串
%% 返回 : {结果列表, 剩余Bin}
%% 如 每个元素为 <<1:8, 2:16, 3:32, "hello_world"/binary>> 
%% 调用unpack_array(Bin, [8,16,32,string]) -> {[{1,2,3,"hello_world"}], <<>>}
unpack_array(<<Len:16, Bin/binary>>, Pattern) -> 
    unpack_array(Len, Bin, Pattern, []);
unpack_array(_, _) -> {[], <<>>}.

unpack_array(0, _Bin, _Pattern, Return) -> 
    {lists:reverse(Return), _Bin};
unpack_array(Len, Bin, Pattern, Return) ->
    {OneItem, BinRest} = unpack_array__(Pattern, [], Bin),
    unpack_array(Len-1, BinRest, Pattern, [list_to_tuple(OneItem) | Return]).

unpack_array__([], VList, BinRest) -> {lists:reverse(VList), BinRest};
unpack_array__([u8|PList], VList, <<V:8, BinRest/binary>>) -> 
    unpack_array__(PList, [V|VList], BinRest);
unpack_array__([u16|PList], VList, <<V:16, BinRest/binary>>) -> 
    unpack_array__(PList, [V|VList], BinRest);
unpack_array__([u32|PList], VList, <<V:32, BinRest/binary>>) -> 
    unpack_array__(PList, [V|VList], BinRest);
unpack_array__([u64|PList], VList, <<V:64, BinRest/binary>>) -> 
    unpack_array__(PList, [V|VList], BinRest);
unpack_array__([int8|PList], VList, <<V:8/signed, BinRest/binary>>) -> 
    unpack_array__(PList, [V|VList], BinRest);
unpack_array__([int16|PList], VList, <<V:16/signed, BinRest/binary>>) -> 
    unpack_array__(PList, [V|VList], BinRest);
unpack_array__([int32|PList], VList, <<V:32/signed, BinRest/binary>>) -> 
    unpack_array__(PList, [V|VList], BinRest);
unpack_array__([int64|PList], VList, <<V:64/signed, BinRest/binary>>) -> 
    unpack_array__(PList, [V|VList], BinRest);
unpack_array__([string|PList], VList, Bin) -> 
    {V, BinRest} = read_string(Bin),
    unpack_array__(PList, [V|VList], BinRest);
unpack_array__([P|PList], VList, Bin) when is_list(P) ->
    {V, BinRest} = unpack_array(Bin, P),
    unpack_array__(PList, [V|VList], BinRest).

%% 封包数组（支持嵌套数组）
%%      Array :     [{x,y,z...}, {x1,y1,z1...}, ...] 
%%      Pattern:   [u8,u16,u32,string, [u8,u16,u32,string], ...] string表示字符串
%% 返回 : Binary
%% 如 列表L = [{1, 2, 3}, {4, 5, 6}] 
%% 调用pack_array(L, [u8, u8, u8]) -> <<0,2,1,2,3,4,5,6>>.
pack_array(Array, Pattern) when is_list(Array),is_list(Pattern) ->
    Len = length(Array),
    Bin = pack_array(Array, Pattern, <<>>),
    <<Len:16, Bin/binary>>;
pack_array(_, _) -> <<>>.

pack_array([], _Pattern, ReturnBin) -> ReturnBin;
pack_array([OneItem | ArrayRest], Pattern, ReturnBin) ->
    Bin = pack_array__(?IF(is_tuple(OneItem),tuple_to_list(OneItem),[OneItem]), Pattern, <<>>),
    pack_array(ArrayRest, Pattern, <<ReturnBin/binary,Bin/binary>>).

pack_array__([], [], BinAcc) -> BinAcc;
pack_array__([V|VList], [u8|PList], BinAcc) ->
    pack_array__(VList, PList, <<BinAcc/binary,V:8>>);
pack_array__([V|VList], [u16|PList], BinAcc) ->
    pack_array__(VList, PList, <<BinAcc/binary,V:16>>);
pack_array__([V|VList], [u32|PList], BinAcc) ->
    pack_array__(VList, PList, <<BinAcc/binary,V:32>>);
pack_array__([V|VList], [u64|PList], BinAcc) ->
    pack_array__(VList, PList, <<BinAcc/binary,V:64>>);
pack_array__([V|VList], [int8|PList], BinAcc) ->
    pack_array__(VList, PList, <<BinAcc/binary,V:8/signed>>);
pack_array__([V|VList], [int16|PList], BinAcc) ->
    pack_array__(VList, PList, <<BinAcc/binary,V:16/signed>>);
pack_array__([V|VList], [int32|PList], BinAcc) ->
    pack_array__(VList, PList, <<BinAcc/binary,V:32/signed>>);
pack_array__([V|VList], [int64|PList], BinAcc) ->
    pack_array__(VList, PList, <<BinAcc/binary,V:64/signed>>);
pack_array__([V|VList], [string|PList], BinAcc) -> 
    pack_array__(VList, PList, <<BinAcc/binary, (string_to_binary(V))/binary>>);
pack_array__([V|VList], [L|PList], BinAcc) when is_list(L) ->
    pack_array__(VList, PList, <<BinAcc/binary, (pack_array(V,L))/binary>>).



% 旧实现，废弃！！
% %% 说明：参数Fun => 用于解析数组元素的函数
% read_array(<<N:16, Bin/binary>>, Fun) ->
%     read_array__(N, Bin, Fun, []).

% read_array__(0, Bin, _Fun, List) -> {List, Bin};
% read_array__(N, Bin, Fun, List) ->
%     {Element, BinLeft} = Fun(Bin),
%     read_array__(N - 1, BinLeft, Fun, [Element | List]).







    
%% CCC: calc check code
-define(CCC_BASE_NUM, 2166136).
-define(CCC_COEF, 16777).

%% 计算协议包的校验码
%% @para: Cmd => 协议号
%%        ToCheckBin => 格式为：<<协议包的序列号:32, 实际有效的协议体/binary>>
%% @return: integer()
calc_check_code(Cmd, ToCheckBin) ->
    Tmp = calc_tmp_check_code(?CCC_BASE_NUM, Cmd),
    do_more_calc_check_code(Tmp, ToCheckBin).


do_more_calc_check_code(Tmp, <<Bin:8>>) ->
    % ?DEBUG_MSG("do_more_calc_check_code(), Bin:~p", [Bin]),
    Ret = calc_tmp_check_code(Tmp, Bin),
    % ?DEBUG_MSG("do_more_calc_check_code(), Ret:~p", [Ret]),
    Ret;

do_more_calc_check_code(Tmp, <<Bin:16>>) ->
    % ?DEBUG_MSG("do_more_calc_check_code(), Bin:~p", [Bin]),
    Ret = calc_tmp_check_code(Tmp, Bin),
    % ?DEBUG_MSG("do_more_calc_check_code(), Ret:~p", [Ret]),
    Ret;

do_more_calc_check_code(Tmp, <<Bin:16, RestBin/binary>>) ->
    % ?DEBUG_MSG("do_more_calc_check_code(), Bin:~p, RestBin:~w", [Bin, RestBin]),
    Tmp2 = calc_tmp_check_code(Tmp, Bin),

    % ?DEBUG_MSG("do_more_calc_check_code(), Tmp2:~p", [Tmp2]),
    do_more_calc_check_code(Tmp2, RestBin).

    
calc_tmp_check_code(Num1, Num2) ->
    ((Num1 bxor Num2) * ?CCC_COEF) rem ?MAX_U32. 
