%%%-----------------------------------
%%% @Module  : list_util
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2012.9.1
%%% @Description: 列表类型的相关接口
%%%-----------------------------------
-module(list_util).
-export([
        get_ele_pos/2,
        rand_pick_one/1
    ]).
    
-include("common.hrl").



%% 获取元素在列表中第一次出现的位置（位置从1开始算起）
%% @para: Element => 要找的元素
%%        List => 列表
%% @return: -1 (表示列表中没有该元素) | Pos（元素在列表中第一次出现的位置）
get_ele_pos(Element, List) ->
	get_ele_pos_2(Element, List, 1).
	

get_ele_pos_2(_Element, [], _Pos) ->
	-1;
get_ele_pos_2(Element, [CurCmpEle | T], Pos) ->
	case Element =:= CurCmpEle of
		true ->
			Pos;
		false ->
			get_ele_pos_2(Element, T, Pos + 1)
	end.	





%% 从列表随机挑选一个元素并返回之
rand_pick_one(L) when L /= [] ->
	Rand = util:rand(1, length(L)),
	lists:nth(Rand, L).

















%% ======================================== Local Functions ===========================================


	