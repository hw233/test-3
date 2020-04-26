%%%------------------------------------------------
%%% File    : less_used_hack.hrl
%%% Author  : huangjf
%%% Created : 2013.6.6
%%% Description: 很少情况下才需使用的hack
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__LESS_USED_HACK_H__).
-define(__LESS_USED_HACK_H__, 0).









%% 对于少数调用非常频繁的函数，用函数宏代替普通的函数调用。
%% 注意： 仅仅是为了省掉函数调用所带来的微小开销， 通常情况下，完全不必考虑这点开销！！！






















% -define( _get_socket(PS), (PS#player_status.socket) ).


% -define( _get_sendpid(PS), (PS#player_status.sendpid) ).









-endif.  %% __DEBUG_H__
