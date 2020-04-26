%%%------------------------------------------------------------------------------
%%% File    : char.hrl
%%% Author  : huangjf
%%% Created : 2014.3.7
%%% Description: 广义上的角色（character，包括玩家，NPC, 宠物，怪物）的相关宏定义
%%%------------------------------------------------------------------------------


%% 避免头文件多重包含
-ifndef(__CHAR_H__).
-define(__CHAR_H__, 0).

%% 跨服通信的调用方式
-define(DEF_RPC_CALL,		1).
-define(DEF_RPC_CAST,		2).

-record(cross_msg,		{
						 from_server = 0,
						 dist_server = [],
						 type,				%%% 详见 char.hrl -> 跨服通信的调用方式
						 from_pid,
						 ref,
						 mod,
						 func,
						 args = []
						 }).


-record(cross_msg_reply,		{
								 from_server,
								 from_pid,
								 ref,
								 reply
								}).




-endif.  %% __CHAR_H__
