%%%--------------------------------------
%%% @Module  : lib_cdk
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.8.5
%%% @Description : cd key（激活码）
%%%--------------------------------------
-module(lib_cdk).
-export([
        init/0,
        gen_cdk_8/0,

        % 以下接口仅仅用于调试！
        dbg_test_gen_7_chars_by_seq/2,
        dbg_test_gen_reserve_ckd_8/0
    ]).

-include("debug.hrl").
-include("server_misc.hrl").
-include("ets_name.hrl").
-include("sprd.hrl").

-define(CHAR_POOL, ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 
                    "A", "B", "C", "D", "E", "F", "G",
                    "H", "I", "J", "K", "L", "M", "N",
                    "O", "P", "Q", "R", "S", "T",
                    "U", "V", "W", "X", "Y", "Z"]).
-define(FIRST_CHAR_OF_RESERVE_CDK, "Z").  % 保留的cdk均以"Z"开头
-define(MAX_GEN_CDK_TRY_TIMES, 5).




init() ->
    Count = db_query_reserve_cdk_8_count(),
    set_reserve_cdk_8_count(Count).
    

%% 生成8位的cdk
%% @return：list类型，8个字符的字符串，形如："9A3CSUUL"
gen_cdk_8() ->
    Key = gen_cdk_8__(1),
    ?ASSERT(is_list(Key) andalso length(Key) == 8, Key),
    db_insert_new_cdk_8(Key),
    Key.



% 生成16位的cdk
% gen_cdk_16() ->
%     todo_here.



%% ==========================================================================

gen_cdk_8__(CurTryTimes) when CurTryTimes > ?MAX_GEN_CDK_TRY_TIMES ->
    gen_reserve_ckd_8();  % 注：简单起见，不判断所生成的保留的8位cdk是否合法（是否包含敏感词）

gen_cdk_8__(CurTryTimes) ->
    Char1 = gen_one_char(1),
    Char2 = gen_one_char(2),
    Char3 = gen_one_char(3),
    Char4 = gen_one_char(4),
    Char5 = gen_one_char(5),
    Char6 = gen_one_char(6),
    Char7 = gen_one_char(7),
    Char8 = gen_one_char(8),
    
    Key = Char1 ++ Char2 ++ Char3 ++ Char4 ++ Char5 ++ Char6 ++ Char7 ++ Char8,

    case (not is_cdk_8_legal(Key)) orelse is_cdk_8_exists(Key) of
        true ->
            gen_cdk_8__(CurTryTimes + 1);
        false ->
            % ?DEBUG_MSG("gen_cdk_8__(), CurTryTimes:~p, Key:~p", [CurTryTimes, Key]),
            Key
    end.



gen_one_char(CharSeq) ->
    CharPool =  case CharSeq == 1 of
                    true ->
                        ?CHAR_POOL -- [?FIRST_CHAR_OF_RESERVE_CDK];  % 以"Z"开头的cdk作为保留cdk，故减掉
                    false ->
                        ?CHAR_POOL
                end,
    CharPoolLen = length(CharPool),
    Nth = util:rand(1, CharPoolLen),
    lists:nth(Nth, CharPool).




%% 敏感词
-define(SENSITIVE_WORDS_LIST, ["DICK", "SM", "FUCK", "NMD", "NND", "SHIT", "SUCK", "TMD", "ML", "3P", "UR", "JB", "CAO", "J8", "5173"]).

%% 判断8位cdk是否合法
is_cdk_8_legal(Key) ->
    case Key == ?CDK_8_AFTER_MERGE_SERVER of
        true ->
            false;
        false ->
            F = fun(SensitiveWords) ->
                    case string:str(Key, SensitiveWords) of
                        0 -> legal;
                        _ -> illegal
                    end
                end,
            L = [F(X) || X <- ?SENSITIVE_WORDS_LIST],
            % ?DEBUG_MSG("is_cdk_8_legal(), Key:~p, Ret:~p", [Key, not lists:member(illegal, L)]),
            not lists:member(illegal, L)
    end.

            




%% 判断8位cdk是否已存在
is_cdk_8_exists(Key) ->
    case db:select_one(cdk_8, "cdk", [{cdk, Key}]) of
        null ->
            % ?DEBUG_MSG("is_cdk_8_exists(), false! Key:~p", [Key]),
            false;
        _Key ->
            % ?DEBUG_MSG("is_cdk_8_exists(), true! Key:~p, _Key:~p", [Key, _Key]),
            true
    end.



%% 插入新生成的8位cdk到数据库表
db_insert_new_cdk_8(Key) ->
    db:insert(cdk_8, ["cdk"], [Key]).

    


%% 从内存获取已生成的保留的8位cdk的数量
get_reserve_cdk_8_count() ->
    [{?SM_RESERVE_CDK_8_COUNT, Count}] = ets:lookup(?ETS_SERVER_MISC, ?SM_RESERVE_CDK_8_COUNT),
    Count.

set_reserve_cdk_8_count(Count) when is_integer(Count) andalso Count >= 0 ->
    ets:insert(?ETS_SERVER_MISC, {?SM_RESERVE_CDK_8_COUNT, Count}).


%% 从DB查询已生成的保留的8位cdk的数量
db_query_reserve_cdk_8_count() ->
    case db:select_one(cdk_misc, "reserve_cdk_8_count", []) of
        null ->
            erlang:error(db_query_reserve_cdk_8_count_failed);
        Count when is_integer(Count) ->
            Count
    end.

db_save_reserve_cdk_8_count(Count) ->
    db:update(cdk_misc, [{"reserve_cdk_8_count", Count}], []).

    


%% 生成保留的8位cdk：以"Z"开头，后7位整体按CHAR_POOL中字符的顺序递增。
%% 举例：生成的第1个保留的8位cdk是："Z0000000"
%%       生成的第2个保留的8位cdk是："Z0000001"
%%       生成的第3个保留的8位cdk是："Z0000002"
%%       ...
%%       生成的第35个保留的8位cdk是："Z000000Y"
%%       生成的第36个保留的8位cdk是："Z000000Z"
%%       生成的第37个保留的8位cdk是："Z0000010"
%%       生成的第38个保留的8位cdk是："Z0000011"
%%       依此类推...
gen_reserve_ckd_8() ->
    Count = get_reserve_cdk_8_count(),
    Char1 = ?FIRST_CHAR_OF_RESERVE_CDK,
    CharOther = gen_7_chars_by_seq(Count + 1),
    Key = Char1 ++ CharOther,
    ?ASSERT(not is_cdk_8_exists(Key), Key),
    db_save_reserve_cdk_8_count(Count + 1),
    set_reserve_cdk_8_count(Count + 1),
    ?DEBUG_MSG("gen_reserve_ckd_8(), old reserve_cdk_8_count:~p, Key:~p", [Count, Key]),
    Key.
    

%% 算法的假定前提是：Seq不会超过CharPoolLen的7次方
gen_7_chars_by_seq(Seq) ->
    CharPoolLen = length(?CHAR_POOL),

    Nth1 = (Seq - 1) div (pow6(CharPoolLen)) + 1,
    Rem1 = (Seq - 1) rem (pow6(CharPoolLen)),
    Char1 = lists:nth(Nth1, ?CHAR_POOL),

    Nth2 = Rem1 div (pow5(CharPoolLen)) + 1,
    Rem2 = Rem1 rem (pow5(CharPoolLen)),
    Char2 = lists:nth(Nth2, ?CHAR_POOL),

    Nth3 = Rem2 div (pow4(CharPoolLen)) + 1,
    Rem3 = Rem2 rem (pow4(CharPoolLen)),
    Char3 = lists:nth(Nth3, ?CHAR_POOL),

    Nth4 = Rem3 div (pow3(CharPoolLen)) + 1,
    Rem4 = Rem3 rem (pow3(CharPoolLen)),
    Char4 = lists:nth(Nth4, ?CHAR_POOL),

    Nth5 = Rem4 div (pow2(CharPoolLen)) + 1,
    Rem5 = Rem4 rem (pow2(CharPoolLen)),
    Char5 = lists:nth(Nth5, ?CHAR_POOL),

    Nth6 = Rem5 div (pow1(CharPoolLen)) + 1,
    Rem6 = Rem5 rem (pow1(CharPoolLen)),
    Char6 = lists:nth(Nth6, ?CHAR_POOL),

    Nth7 = Rem6 + 1,
    Char7 = lists:nth(Nth7, ?CHAR_POOL),

    RetChars = Char1 ++ Char2 ++ Char3 ++ Char4 ++ Char5 ++ Char6 ++ Char7,

    RetChars.


pow6(Num) ->
    pow3(Num) * pow3(Num).

pow5(Num) ->
    pow3(Num) * pow2(Num).

pow4(Num) ->
    pow2(Num) * pow2(Num).

pow3(Num) ->
    Num * Num * Num.

pow2(Num) ->
    Num * Num.

pow1(Num) ->
    Num.









%% ===================================================================

dbg_test_gen_7_chars_by_seq(SeqBegin, SeqEnd) ->
    dbg_test_gen_7_chars_by_seq__(SeqBegin, SeqEnd).


dbg_test_gen_7_chars_by_seq__(CurSeq, SeqEnd) when CurSeq > SeqEnd ->
    done;
dbg_test_gen_7_chars_by_seq__(CurSeq, SeqEnd) ->
    _Chars = gen_7_chars_by_seq(CurSeq),
    ?DEBUG_MSG("dbg_test_gen_7_chars_by_seq__(), Seq:~p, Chars:~p", [CurSeq, _Chars]),
    dbg_test_gen_7_chars_by_seq__(CurSeq + 1, SeqEnd).




dbg_test_gen_reserve_ckd_8() ->
    gen_reserve_ckd_8().