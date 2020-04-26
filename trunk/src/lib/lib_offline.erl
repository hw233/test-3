%%%--------------------------------------
%%% @Module: lib_offline
%%% @Author: liuzhongzheng2012@gmail.com
%%% @Created: 2014-05-20
%%% @Description: 离线状态保存与上线时恢复
%%%--------------------------------------

-module(lib_offline).

-export([
            login/1,
            logout/1,

            get_value/3,
            set_value/3,
            del_key/2,
            del_keys/2
        ]).

-include("common.hrl").
-include("record.hrl").

%% 登录时的处理
login(#player_status{off_state=[]}=PS) -> % 新上线(无缓存)
    UID = player:id(PS),
    OffState =
        case db:kv_lookup(offstate, UID) of
            [] ->
                [];
            [List] ->
                List
        end,
    OffState1 = lists:keystore(online, 1, OffState, {online, true}), % 在线标记
    PS1 = PS#player_status{off_state=OffState1},
    PS2 = do_login(PS1),
    PS2;
login(PS) -> % 缓存中, 重登录
    PS1 = do_login(PS),
    PS1.

%% 别的模块登录时调用加在这里
do_login(PS) ->
    PS1 = mod_offline_guaji:login(PS),
    PS1.

%% 下线时的处理
logout(#player_status{id=UID}=PS) ->
    PS1 = do_logout(PS),
    OffState = PS1#player_status.off_state,
    OffState1 = lists:keydelete(online, 1, OffState),
    db:kv_insert(q, UID, offstate, UID, OffState1),
    PS1.

%% 别的模块下线时调用加在这里
do_logout(PS) ->
    PS1 = mod_offline_guaji:logout(PS),
    PS1.


%% 获取离线存储的值
-spec get_value(PS, Key, Default) -> Value when
    PS :: #player_status{},
    Key :: atom(),
    Default :: term(),
    Value :: term().

get_value(#player_status{off_state=OffState}=_PS, Key, Default) ->
    proplists:get_value(Key, OffState, Default).

%% 设置离线存储的值
-spec set_value(PS, Key, Value) -> NewPS when
    PS :: #player_status{},
    Key :: atom(),
    Value :: term(),
    NewPS :: #player_status{}.

set_value(#player_status{off_state=OffState}=PS, Key, Value) ->
    OffState1 = lists:keystore(Key, 1, OffState, {Key, Value}),
    PS#player_status{off_state=OffState1}.

%% 删除离线存储的值
-spec del_key(PS, Key) -> NewPS when
    PS :: #player_status{},
    Key :: atom(),
    NewPS :: #player_status{}.

del_keys(#player_status{off_state=OffState}=PS, Keys) when is_list(Keys) ->
    OffState1 = lists:foldl(fun proplists:delete/2, OffState, Keys),
    PS#player_status{off_state=OffState1}.

del_key(PS, Key) ->
    del_keys(PS, [Key]).