%%%------------------------------------------------
%%% File    : proc_name.hrl
%%% Author  : huangjf 
%%% Created : 2014.6.11
%%% Description: 进程名字
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__PROC_NAME_H__).
-define(__PROC_NAME_H__, 0).

-define(PUBLIC_DB_PROC, public_db_proc).  % 公共数据库进程
-define(PRIVATE_DB_PROC, "private_db_proc_"). % 玩家私人数据库进程
-define(MARK_PROCESS, mark_process).  % 市场（拍卖行）进程
-define(DUNGEON_MANAGE, dungeon_manage).  % 副本管理进程
-define(TEAM_PROCESS, team_process).  % 队伍管理进程

-endif.  %% __PROC_NAME_H__
