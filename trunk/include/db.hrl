%%%------------------------------------------------
%%% File    : db.hrl
%%% Author  : huangjf 
%%% Created : 2014.3.17
%%% Description: 数据库相关的宏
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__DB_H__).
-define(__DB_H__, 0).





%% 数据库操作统计
-record(db_op_stat, {
		key = undefined,          % 形如： "表名/操作类型"
		tbl_name = undefined,     % 表名
		op_type = undefined,      % 操作类型：select | delete | update | replace | insert_get_id | ...

		first_op_time = 0,        % 第一次操作表时的时间

		op_times = 0,             % 总操作次数

		min_op_cost_time = 0,     % 单次操作的最小消耗时间（微秒）
		max_op_cost_time = 0,     % 单次操作的最大消耗时间（微秒）

		sum_op_cost_time = 0,     % 累计的总操作消耗时间（微秒）
		avg_op_cost_time = 0      % 单次操作的平均消耗时间（微秒）
	}).





%%数据库连接-游戏
-define(DB, sim_mysql_conn).     % 数据库连接池标识
-define(DEFAULT_DB_PORT, 3306).  % 默认端口
% -define(DB_USER, "smserver").
% -define(DB_PASS, "123456").
% -define(DB_NAME, "smserver").
-define(DB_ENCODE, utf8).
% -define(DB_CONN_NUM_FOR_GATEWAY, 1).  % gateway节点与游戏数据库的连接数
% -define(DB_CONN_NUM_FOR_SERVER, 200).  % server节点与游戏数据库的连接数   %% 仅仅供参考----捷游某项目的配置方式： 200对应5K在线，150对应4K，100为3K-2K，50为以下1K，叠服（合服）的就100-50就够了











% 作废！！
% %%数据库连接-后台
% -define(DB_BG, sim_mysql_conn_bg).
% -define(DEFAULT_DB_PORT_BG, 3306).  % 默认端口
% -define(DB_USER_BG, "bgadmin").
% -define(DB_PASS_BG, "654321").
% -define(DB_NAME_BG, "bgadmin").
% -define(DB_ENCODE_BG, utf8).












-endif.  %% __DB_H__
