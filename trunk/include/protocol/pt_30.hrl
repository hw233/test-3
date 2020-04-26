%% =========================================================
%% 30  任务协议
%% =========================================================

%% 任务状态:
-define(TASK_TRIGGER, 1).		%可见的任务	1
-define(TASK_CAN_ACCEPT, 3).	%可接的任务 	11
-define(TASK_ACCEPTED, 7).		%已接的任务 	111 
-define(TASK_FAIL, 15).			%失败的任务 	1111
-define(TASK_COMPLETED, 23).	%完成的任务	10111

% =========================
% 可触发任务
% 协议号：30001
% C >> S:
% 	[]	%%空或任意

% S >> C:
% 	array{
% 		TaskId	int32
% 		State	int16		任务状态(1 or 3)
% 		NpcId	int32
% 		sceneID	int32
%       setp    u16          当前环任务的步数
%       ring    u8          当前环数
% 	}


% =========================
% 已接任务
% 协议号：30002
% C >> S:
% 	[]

% S >> C:
% 	array{
% 		TaskId	int32
% 		State	int16		任务状态
% 		NpcId	int32		接任务的NPC
% 		sceneID	int32		接任务NPC所在场景
%       setp    u16          当前环任务的步数
%       ring    u8          当前环数
%       timestamp   u32         接取的时间戳
% 		%%每项子任务状态
% 		array{
% 			event		int16	事件类型
%			state		int8	完成状态（0->未完成;1->完成）
% 			sceneId		int32	场景ID	
% 			dungeonId	int32	副本ID
% 			npcId		int32	
% 			targetId	int32	任务目标Id，如monId，itemId等
% 			curNum		int16	当前计数
% 			tolNum		int16	总计数			
% 		}
% 	}


% ===================================

-define(ERROR, 0).				%未知错误
-define(SUCCESS, 1).			%成功
-define(OVER_TASK_LIMIT, 3).	%任务日志已满
-define(TASK_STATE_ERROR, 4).	%任务状态错误
-define(BAG_OVERRIDE, 5).		%背包已满
-define(TASK_ITEM_ERROR, 10).    %任务需求物品不足
-define(PERV_TASK_NOT_SUBMIT, 11).  % 前置任务未完成
-define(TASK_NOT_ENOUT_TIMES, 12).      % 任务接取次数不足
-define(HAD_SAME_TYPE_TASK, 13).        % 已有相同类型任务
-define(TASK_ROLE_LIMIT, 14).           % 角色自身条件不符合(种族、性别等)
-define(TASK_GUILD_LIMIT, 15).          % 角色帮派条件不符合
-define(TASK_ROLE_LV_NOT_ENOUGTH, 16).  % 角色等级不足
-define(NO_TASK_TRIGGER_ITEM, 17).      % 没有触发任务物品


% =========================
% 接任务
% 协议号：30003
% C >> S:
% 	TaskId		int32		任务ID


% S >> C:
%   TaskId      int32       任务ID
% 	State		int8


% =========================
% 提交任务
% 协议号：30004
% C >> S:
% 	TaskId		int32		任务ID
%   array{
%       itemId  u64         物品id
%       num     u16         数量 
%   }

% S >> C:
%   TaskId      int32       任务ID
% 	State		int8


% =========================
% 放弃任务
% 协议号：30005
% C >> S:
% 	TaskId		int32		任务ID

% S >> C:
%   TaskId      int32       任务ID
% 	State		int8


% =========================
% 更新某一任务
% 协议号：30006
% C >> S:
% 	TaskId		int32		任务ID

% S >> C:
% 	TaskId	int32
% 	State	int16		任务状态
% 	NpcId	int32		接任务的NPC
% 	sceneID	int32		接任务NPC所在场景
%   setp    u16          当前环任务的步数
%   ring        u8          当前环数
%   timestamp   u32         接取的时间戳
% 	%%每项子任务状态
% 	array{
% 		event		int16	事件类型
%		state		int8	完成状态（0->未完成;1->完成）
% 		sceneId		int32	场景ID	
% 		dungeonId	int32	副本ID
% 		npcId		int32	
% 		targetId	int32	任务目标Id，如monId，itemId等
% 		curNum		int16	当前计数
% 		tolNum		int16	总计数			
% 	}


% =========================
% 自动触发的任务
% 协议号：30007
% S >> C:
% 	TaskId		int32		任务ID


% =========================
% 可触发任务
% 协议号：30008
% C >> S:
%   npcId      int32       

% S >> C:
%   array{
%       TaskId  int32
%       State   int16       任务状态(1 or 3)
%       NpcId   int32
%       sceneID int32
%       setp    u16          当前环任务的步数
%       ring    u8          当前环数 
%   }


% =========================
% 客户端主动推送任务信息
% 协议号：30009
% C >> S:
%   state      u8       (1 -> 探索类任务)       


% =========================
% 寻路查询
% 协议号：30010
% C >> S:
%   TaskId      int32       
% S >> C:
%   TaskId      int32       任务ID
%   sceneId     int32
%   X           int16
%   Y           int16
%   怪物id		int64


% =========================
% 组队状态下队长准备提交任务
% 协议号：30011
% C >> S:
%   TaskId      int32 
% S >> C:   (to 队员)
%   TaskId      int32 


% =========================
% 组队任务接取/提交失败反馈
% 协议号：30012
% S >> C:
%   TaskId      int32 
%   array(
%       RoleId      u64     玩家ID
%       state       u8      失败状态
%    )


% =========================
% 接取某一任务后推送客户端
% 协议号：30013
% S >> C:
%   TaskId  int32
%   State   int16       任务状态
%   NpcId   int32       接任务的NPC
%   sceneID int32       接任务NPC所在场景
%   setp    u16          当前环任务的步数
%   ring        u8          当前环数
%   timestamp   u32         接取的时间戳
%   %%每项子任务状态
%   array{
%       event       int16   事件类型
%       state       int8    完成状态（0->未完成;1->完成）
%       sceneId     int32   场景ID    
%       dungeonId   int32   副本ID
%       npcId       int32   
%       targetId    int32   任务目标Id，如monId，itemId等
%       curNum      int16   当前计数
%       tolNum      int16   总计数         
%   }


% =========================
% 取得某一任务的状态
% 协议号：30014
% C >> S
%   TaskId  u32
% S >> C:
%   TaskId  u32
%   State   u16       任务状态 1->未接 2->已接 3->已提交

-define(PT_IS_CAN_GET_REWARD_BY_TIMES, 30015).
% ======= 转盘显示 ========
%% 协议号：30015
%% C >> S:
%% S << C:
%%       code        u8      结果码


-define(PT_ERNIE_GET, 30016).
% ======= 转盘转动 ========
%% 协议号：30016
%% C >> S：
%% S << C：
%%    no      u8  奖励编号（唯一标识）


-define(PT_NOTIFY_TASKID, 30017).
% ======= 通知前端新的环任务id ========
%% 协议号：30017
%% S >> C：
%%    TaskId      u32  新的环任务id


%% ====================================================
%% 悬赏任务相关协议 pt30100 ~ pt30199 issue_task
%% ====================================================
-define(PT_GET_XS_TASK_INFO, 30100).
% ======== 悬赏任务面板信息 ========
% 协议号：30100
% C >> S
%   filt_flag   u8      是否过滤掉不可领取任务（0否  1是）
%   page        u16     页数
% S >> C:
%   page        u16     页数
%   all_page    u16     总页数
%   array{
%       IssueId         u32         悬赏唯一Id
%       RoleId          u64         发布者Id
%       RoleName        string      发布者昵称 (空则表示匿名)
%       IssueTaskLv     u16         发布任务的等级段
%       Num             u8          剩余次数
%       Time            u32         剩余时间（s）
%   }
%   receive_num         u8          今日可领取次数

-define(PT_ISSUE_XS_TASK, 30101).
% ======== 发布悬赏任务 ========
% 协议号：30101
% C >> S
%   issue_num       u16     发布次数
%   is_anonymity    u8      是否匿名(0不匿名 1匿名)
% S >> C:
%   code            u8      结果码（0成功 发布成功，并开着面板自行刷新面板
%                                   1失败 服务端发提示信息） 
%   left_issue_num  u8      剩余发布次数
%   issue_num       u8      今天已经发布次数

-define(PT_RECEIVE_XS_TASK, 30102).
% ======= 领取悬赏任务 ========
% 协议号：30102
% C >> S
%   IssueId         u32     悬赏唯一Id
% S >> C:
%   code            u8      结果码（0成功 领取成功，并开着面板自行刷新面板） 
%                                 （1失败 刷新面板-可能剩余次数剩余时间刚好为0）

-define(PT_GET_LEFT_ISSUE_NUM, 30103).
% ======= 获取剩余发布数量 ========
% 协议号：30103
% C >> S
%   空协议
% S >> C:
%   left_issue_num  u8      剩余发布次数
%   issue_num       u8      今天已经发布次数

-define(PT_IS_CAN_RECEIVE_XS_TASK, 30104).
% ======= 是否可以领取悬赏任务 ========
% 协议号：30104
% C >> S
%   空协议
% S >> C:
%   code        u8      结果码 （0成功，有可以领取的任务）
%                              （1失败，没有可以领取的任务）



