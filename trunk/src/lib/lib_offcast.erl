%%%--------------------------------------
%%% @Module: lib_offcast
%%% @Author: liuzhongzheng2012@gmail.com
%%% @Created: 2014-07-29
%%% @Description: 离线cast
%%%--------------------------------------

-module(lib_offcast).

-export([
            cast/2,
            on_login/1
        ]).


%% 登录时的处理
on_login(PS) ->
    UID = player:id(PS),
    case db:kv_lookup(offcast, UID) of
        [[]] ->
            ok;
        [Casts] ->
            Casts1 = lists:reverse(Casts),
            [gen_server:cast(self(), C) || C <- Casts1],
            db:kv_insert(offcast, UID, []),
            ok;
        [] ->
            ok
    end.


cast(UID, Info) ->
    case player:get_pid(UID) of
        Pid when is_pid(Pid) ->
            gen_server:cast(Pid, Info);
        _ ->
            mod_offcast:cast(UID, Info)
    end.




