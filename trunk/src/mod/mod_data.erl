%%%--------------------------------------------------------
%%% @author Lzz <liuzhongzheng2012@gmail.com>
%%% @doc 全局模块的存盘数据模块
%%%
%%% @end
%%%--------------------------------------------------------

-module(mod_data).

-export([save/2, load/1]).
-include("common.hrl").
%% 存数据
-spec save(atom(), term()) -> integer().
save(Mod, Data) ->
    db:kv_insert(q, ?DB_SYS, sys_data, Mod, Data).

%% 读数据
-spec load(atom()) -> [] | [term()].
load(Mod) ->
    db:kv_lookup(sys_data, Mod).

