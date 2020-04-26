%%%--------------------------------------
%%% @Module  : ply_phone
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.8.13
%%% @Description: 玩家自身的相关信息（！！！注意：本模块的函数只能在玩家自己的进程中调用！！！）
%%%--------------------------------------
-module(ply_phone).
-export([
        get_phone_info/0,
        set_phone_info/1
    ]).


-include("player.hrl").
-include("phone.hrl").
-include("debug.hrl").






%% @return: null | #phone_info{}
get_phone_info() ->
	case erlang:get(?PDKN_PHONE_INFO) of
		undefined ->
			null;
		Val ->
			Val
	end.


set_phone_info(Val) when is_record(Val, phone_info) ->
	?ASSERT(player:this_is_player_proc()),
	erlang:put(?PDKN_PHONE_INFO, Val).