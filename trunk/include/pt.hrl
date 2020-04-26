%%%------------------------------------------------
%%% File    : pt.hrl
%%% Author  : huangjf 
%%% Created : 2014.8.6
%%% Description: protocol相关的宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__PT_H__).
-define(__PT_H__, 0).







%% 打包bit string
-define(P_BITSTR(Val), <<(byte_size(Val)):16,Val/binary>>/binary).














-endif.  %% __PT_H__
