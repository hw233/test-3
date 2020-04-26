%%%------------------------------------------------
%%% File    : common.hrl
%%% Author  :
%%% Created : 2011-04-22
%%% Description: 公共定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__COMMON_H__).
-define(__COMMON_H__, 0).


-include("debug.hrl").

-define(true, true).
-define(false, false).
-define(undefined, undefined).

-define(IF(B,T,F), case B of true -> T; _ -> F end).
-define(TODO, ?INFO_MSG("TODO here !", [])).
-define(TODO(X), begin ?TODO, X end).


%-define(SD_SERVERS, 'SD_SERVERS').
-define(ALL_SERVER_PLAYERS, 10000).

%%服务IP和端口
%-define(HOST, "localhost").
%-define(PORT, 6666).
%-define(GAYEWAY_POST, 5555).

%%安全校验
-define(TICKET, "uc_Xproj9527").
% -define(LOGIN_TIMEOUT, 300). % 登录接口超时：300秒

%%flash843安全沙箱
-define(FL_POLICY_REQ, <<"<pol">>).
%-define(FL_POLICY_REQ, <<"<policy-file-request/>\0">>).
-define(FL_POLICY_FILE, <<"<cross-domain-policy><allow-access-from domain='*' to-ports='*' /></cross-domain-policy>">>).


-define(CROSS_SECURITY,	<<"migA!0IJKIOK5NVTC%YD2lYkutuKef&!bX2$c&UptvwtcVnEClQ1iI9u@MR3m&!#">>).

%%tcp_server监听参数
-define(TCP_OPTIONS, [binary, {packet, 0}, {active, false}, {reuseaddr, true}, {nodelay, false}, {delay_send, true}, {send_timeout, 10000}, {keepalive, true}, {exit_on_close, true}]).

%%基准移动速度
-define(BASE_MOVE_SPEED, 200).

%%日志
-define(DEFAULT_LOG_FILE, "logs/log").
-define(DEFAULT_LOG_LEVEL, 5).

%% log event manager name
-define(LOGMODULE, logger_mgr).

-define(DIFF_SECONDS_1970_1900, 2208988800).
-define(DIFF_SECONDS_0000_1900, 62167219200).

%% 无效的id（规定：游戏中统一把0当做无效的id，比如：用0表示无效的玩家id、无效的明雷怪id、无效的队伍id、无效的帮派id等等）
-define(INVALID_ID, 0).

%% 无效的编号
-define(INVALID_NO, 0).



%% 概率基数
-define(PROBABILITY_BASE, 1000).
%% 常用概率基数100
-define(PROBABILITY_BASE_COM, 1).

% %% 场景AOI范围
% -define(HALF_AOI_RANGE_X, 24). % 场景的半个横向AOI范围
% -define(HALF_AOI_RANGE_Y, 10). % 场景的半个纵向AOI范围
% -define(AOI_RANGE_X, 48).      % 场景的横向AOI范围
% -define(AOI_RANGE_Y, 20).      % 场景的纵向AOI范围

%% 游戏中的对象类型
-define(OBJ_INVALID,  0).      % 无效类型（用于程序做判定）
-define(OBJ_PLAYER,   1).      % 玩家
-define(OBJ_PARTNER,  2).      % 宠物
-define(OBJ_NPC,      3).      % NPC
-define(OBJ_MONSTER,  4).      % 怪物
-define(OBJ_NORMAL_BOSS, 5).   % 普通BOSS
-define(OBJ_ITEM,     6).      % 道具
-define(OBJ_HIRED_PLAYER, 7).  % 雇佣玩家（仅用于战斗系统）
-define(OBJ_WORLD_BOSS,   8).  % 世界BOSS
-define(OBJ_MIN,      1).      % 对象类型的最小值（用于程序做判定）
-define(OBJ_MAX,      8).      % 对象类型的最大值（用于程序做判定）


%% 钱的类型(money type)，钱和道具编号对应表在goods.hrl
-define(MNY_T_INVALID,   		0).          % 无效的钱类型（用于程序做判定）
-define(MNY_T_GAMEMONEY,		1).          % 银币
-define(MNY_T_YUANBAO, 			2).          % 水玉
-define(MNY_T_BIND_GAMEMONEY, 	3).     	 % 仙玉
-define(MNY_T_BIND_YUANBAO, 	4).       	 % 绑定的金子
-define(MNY_T_FEAT, 			5).			 % 功勋值
-define(MNY_T_GUILD_CONTRI, 	6).		  	 % 帮派贡献度
-define(MNY_T_EXP, 				7).			 % 经验
-define(MNY_T_LITERARY, 		8). 		 % 学分
-define(MNY_T_COPPER, 			9).          % 金币
-define(MNY_T_VITALITY, 		10).         % 活力值

-define(MNY_T_CHIVALROUS, 		11).         % 侠义值
-define(MNY_T_CHIP, 			12).         % 龙头小票
-define(MNY_T_GUILD_FEAT, 		13).         % 帮派战功

-define(MNY_T_INTEGRAL, 		14).         % 积分

-define(MNY_T_QUJING, 		    15).         % 经文

-define(MNY_T_MYSTERY,          16).         % 秘境
-define(MNY_T_MIRAGE,           17).         % 幻境
-define(MNY_T_REINCARNATION,    18).         % 转生



-define(MNY_T_MIN, 		1).           % 钱类型的最小值（用于程序做判定）
-define(MNY_T_MAX, 		14).           % 钱类型的最大值（用于程序做判定）

%% 种族
-define(RACE_NONE,  0).         % 无种族
-define(RACE_REN,   1).         % 人族
-define(RACE_MO,    2).         % 魔族
-define(RACE_XIAN,  3).         % 仙族
-define(RACE_YAO,   4).         % 妖族（后期版本才开放）
-define(RACE_MIN,   1).         % 最小种族代号，仅用于程序做判定
-define(RACE_MAX,   4).         % 最大种族代号，仅用于程序做判定

%% 阵营
-define(CAMP_NONE,  0).      % 无阵营
-define(CAMP_ALLY,  1).      % 友方
-define(CAMP_ENEMY, 2).      % 敌方

%% 性别
-define(SEX_NONE,   0).      % 无效
-define(SEX_MALE,   1).      % 男
-define(SEX_FEMALE, 2).      % 女

%% 返回结果（这里res表示result）
-define(RES_OK,   0).  %% 表示成功
-define(RES_FAIL, 1).  %% 表示失败

%% 发送提示级别
-define(PROMPT_MSG_TYPE_WARN, 1). %% 弹窗警告
-define(PROMPT_MSG_TYPE_TIPS, 2). %% 滑动提示

%% 数值类型
-define(VALUE_T_INT, 1).      % 整数
-define(VALUE_T_PERCENT, 2).  % 百分比

%% 支付类型
-define(PAY_T_USE_GAMEMONEY, 1).        % 使用游戏币
-define(PAY_T_USE_BIND_GAMEMONEY, 2).   % 使用绑定的游戏币
-define(PAY_T_USE_YUANBAO, 3).          % 使用元宝
-define(PAY_T_USE_BIND_YUANBAO, 4).     % 使用绑定的元宝

%% 颜色
-define(COLOR_INVALID,  0).    % 无效的颜色编号（用于程序做判定）
-define(COLOR_WHITE,    1).    % 白色
-define(COLOR_GREEN,    2).    % 绿色
-define(COLOR_BLUE,     3).    % 蓝色
-define(COLOR_PURPLE,   4).    % 紫色
-define(COLOR_ORANGE,   5).    % 橙色
-define(COLOR_YELLOW,   6).    % 黄色
-define(COLOR_GRAY,     7).    % 灰色
-define(COLOR_MAX,      7).    % 颜色的最大有效编号（用于程序做判定）

%% 计时(timekeeping)方式
-define(TKP_NONE,           0).          % 无
-define(TKP_BY_REAL,        1).          % 按现实时间
-define(TKP_BY_ACC_ONLINE,  2).          % 按累积在线时间

%% 什么时候开始计时(when begin timekeeping)
-define(WBTKP_NONE,          0).          % 无
-define(WBTKP_ON_GOT,        1).          % 获取即开始计时
-define(WBTKP_ON_FIRST_USE,  2).          % 第一次使用后开始计时


% 作废！！
% %% 数据类型（定为signed是为了做个提醒：目前项目的客户端接收数据时都把数据当做有符号数处理，
% %%                                     因此发送数据时须注意数据溢出的问题！！）
% -define(INT8,  8/signed-integer).
% -define(INT16, 16/signed-integer).
% -define(INT32, 32/signed-integer).

% %% 开启，关闭
% -define(TURN_ON, on).
% -define(TURN_OFF, off).

-define(ONE_DAY_SECONDS, (24 * 60 * 60)).           % 一天的秒数
-define(ONE_DAY_MSECONDS, (24 * 60 * 60 * 1000)).   % 一天的毫秒数

-define(ONE_HOUR_SECONDS, (60 * 60)).               % 一小时的秒数
-define(ONE_HOUR_MSECONDS, (60 * 60 * 1000)).       % 一小时的毫秒数

-define(ONE_MINUTE_SECONDS, 60).                    % 一分钟的秒数
-define(ONE_MINUTE_MSECONDS, (60 * 1000)).          % 一分钟的毫秒数

-define(ETS_SERVER_OPEN_TIME, server_open_time).


-define(DB_SYS, 0).		% 公共系统数据库存储标志


%% 跨服标记用
-define(CROSS_FLAG,			cross_flag).

-define(CROSS_STATE_LOCAL,	0).		% 正常未跨服进程
-define(CROSS_STATE_REMOTE,	1).		% 已跨服的本服进程
-define(CROSS_STATE_MIRROR,	2).		% 跨服节点的镜像进程


%% 聊天频道类型
-define(ENUM_CHAT_TYPE_CURRENT,		1).	   % 当前
-define(ENUM_CHAT_TYPE_WORLD,		2).    % 世界
-define(ENUM_CHAT_TYPE_SCENE,	    3).    % 场景
-define(ENUM_CHAT_TYPE_FACTION,	    4).    % 门派
-define(ENUM_CHAT_TYPE_GUILD,    	5).    % 帮派
-define(ENUM_CHAT_TYPE_TEAM,	    6).    % 队伍
-define(ENUM_CHAT_TYPE_PERSON,    	7).    % 私聊
-define(ENUM_CHAT_TYPE_TRUMPET,	    8).    % 喇叭
-define(ENUM_CHAT_TYPE_CROSS,	    9).    % 跨服


% %% 断言以及打印调试信息宏
% -ifdef(debug).
% 	-define(TRY_CATCH(Expression, Tip, ErrReason), Expression).
% 	-define(TRY_CATCH(Expression, ErrReason), Expression).
% 	-define(TRY_CATCH(Expression), Expression).

% -else.


% -endif.



% 若在同一个函数里多次用TRY_CATCH，就要用多个个参数的版本（3个参数的比2个参数的多了个Tip，就是可以加上自定义的信息）；若只用一次TRY_CATCH，则用1个参数的版本
% -------------------- 使用示例：---------------------------
% 	如果同一函数里只有1个TRY_CATCH：
% 	?TRY_CATCH(lib_scene:leave_scene(Status))

% 	如果同一函数里有多个TRY_CATCH，则要加个变量参数：
% 	?TRY_CATCH(lib_scene:leave_scene(Status), ErrReason1),
% 	?TRY_CATCH(goods_util:goods_offline(Status), ErrReason2)

% 	如果想加自定义的信息，则用3个参数的版本：
% 	Tip = lists:concat(["退出游戏时离开场景,场景Id=",Status#player_status.scene]),
% 	?TRY_CATCH(lib_scene:leave_scene(Status), Tip, ErrReason)

-define(TRY_CATCH(Expression, Tip, ErrReason), try
									Expression
								catch
									_:ErrReason ->
										?ERROR_MSG("~s, Catch exception: Reason:~w, Stacktrace:~w", [Tip, ErrReason, erlang:get_stacktrace()])
										%%?ASSERT(false, ErrReason)
								end).
-define(TRY_CATCH(Expression, ErrReason), try
									Expression
								catch
									_:ErrReason ->
										?ERROR_MSG("Catch exception: Reason:~w, Stacktrace:~w", [ErrReason, erlang:get_stacktrace()])
										%%?ASSERT(false, ErrReason)
								end).
-define(TRY_CATCH(Expression), ?TRY_CATCH(Expression, __ErrReason)).


-define(BIN_PRED(Condition, Expr1, Expr2), case Condition of
											   true -> Expr1;
											   false -> Expr2
										   end).



-endif.  %% __COMMON_H__
