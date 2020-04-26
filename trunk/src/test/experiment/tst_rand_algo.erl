%% Author: huangjf
%% Created: 2014.10.10
%% Description: 测试随机算法
-module(tst_rand_algo).

-export([
		init_seed/0,
        next_int/1,
        test/2
	]).

-include("debug.hrl").


%% 赞爷提供的参考算法（C++代码）：

% //最大随机整数上限
%     const Int32 MAX_MOD_0 = 1072591837;
%     const Int32 MAX_MOD_1 = 12246271 * 3;
%     int MAX_MOD;

%     private Int32 generate()
%     {
%         trycount++;

%         if (mGenType == 0)  // 同余法求随机数
%         {
%             Int32 a = 20246293;
%             Int32 b = 12246287;
%             mSeed = (a * mSeed  + b) % MAX_MOD;
%             return mSeed + MAX_MOD;
%         }
%         else  // RSA的随机算法
%         {
%             mSeed++;
%             return (mSeed * mSeed * mSeed) % MAX_MOD + MAX_MOD;
%         }
%     }

%     ////1~21亿之间随机数
%     public Int32 NextInt()
%     {
%         return generate();
%     }



% 下面用一个例子来试验一下，看看这个算法有多神奇（很均匀）。

% 　　设Ｎ＝１５，Ｐ＝５，Ｑ＝３，则Ａ为２到14的数。现在要产生２到14的伪随机数。取Ｄ为３，E为３，

% 　　Ｃ２＝（２EXP３）mod１５ = 8,　　

% 　　Ｃ３＝（３EXP３）mod １５ = １２,
% 　　Ｃ４  ＝ （４EXP３）mod １５= ４，
% 　　Ｃ５  ＝ （５EXP３）mod １５= ５，
% 　　Ｃ６  ＝ （６EXP３）mod １５= ６，
% 　　Ｃ７  ＝ （７EXP３）mod １５= １３，
% 　　Ｃ８  ＝ （８EXP３）mod １５= ２，
% 　　Ｃ９  ＝ （９EXP３）mod １５= ９，
% 　　Ｃ１０  ＝ （１０EXP３）mod １５= １０，
% 　　Ｃ１１  ＝ （１１EXP３）mod １５= １１，
% 　　Ｃ１２  ＝ （１２EXP３）mod １５= ３，
% 　　Ｃ１３  ＝ （１３EXP３）mod １５= ７，
% 　　Ｃ１４  ＝ （１４EXP３）mod １５= １４。






init_seed() ->
    set_seed(util:rand(1, 100000)).


get_seed() ->
    erlang:get(the_seed).

set_seed(Val) ->
    erlang:put(the_seed, Val).

incr_seed() ->
    Val = get_seed(),
    set_seed(Val + 1).


next_int(MaxMod) ->
    incr_seed(),
    Val = get_seed(),
    Ret = (Val * Val * Val) rem MaxMod,
    ?DEBUG_MSG("next_int(), MaxMod:~p, Ret:~p", [MaxMod, Ret]),
    Ret.




test(MaxMod, Times) ->
    init_seed(),
    ?DEBUG_MSG("test(), MaxMod:~p, Seed:~p", [MaxMod, get_seed()]),
    tst_prof:run_arg(fun do_test/1, Times, MaxMod).



do_test(MaxMod) ->
    next_int(MaxMod).
