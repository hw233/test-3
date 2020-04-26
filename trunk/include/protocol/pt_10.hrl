
%%% =======================================
%%% 账户，登录相关的协议
%%% 分类号:10
%%%
%%% Author: huangjf
%%% Created: 2013.5.30
%%% ======================================


%%% PT: 表示protocol

%%% 注：登录的正确流程是： 请求登录 -> 获取角色列表 -> 创建或删除角色(可选) -> 选择角色进入游戏。
%%%     流程不要有错，否则服务端会检验并断开与客户端的连接。



%% --------------- 请求登录 -------------------------
-define(PT_LOGIN_REQ, 10000).

%% 协议号:10000
%% c >> s:
%%      TimeStamp    u32      当前unix时间戳（u32表示无符号的32位整型，下同）
%%      Account      string   账户名
%%      Md5Auth      string   Md5登录验证字符串
%%      PhoneModel   string   手机型号
%%      PhoneMAC     string   手机MAC地址
%%      FromServerId u32      表示是从哪个服登录（合服之后，有必要知道此信息），FromServerId = 平台号*10000 + 平台下的服务器流水编号，比如：10001

%% s >> c:
%%      RetCode      u8       成功则返回0，否则返回下面定义的失败原因值（u8表示无符号的8位整型，下同）
        

-define(LOGIN_FAIL_AUTH_FAILED, 1).     % 验证失败
-define(LOGIN_FAIL_SERVER_CLOSED, 2).   % 服务器未开启
-define(LOGIN_FAIL_IP_BANNED , 3).      % IP被封禁了





%% --------------- 退出游戏（!!!!注意：此协议已作废!!!!） -------------------------
%%-define(PT_EXIT_GAME, 10001).

%% 协议号:10001





%% --------------- 获取角色列表 -------------------------
-define(PT_GET_ACC_ROLE_LIST,  10002).

%% 协议号:10002
%% c >> s:
%%      无（只发协议号）

%% s >> c:
%%      RetCode             u8       获取成功返回0，失败则返回1
%%      array(
%%	        Id     			u64    	 角色ID（全局唯一）
%%          LocalId    		u32      角色在服务器内部的流水id（不具备全局唯一性），仅用于客户端在面板做显示给玩家看，不做他用！
%%       	IsBanned   		u8       是否被封禁了（1：是，0：否）
%%	        Race       		u8       种族（1：人，2：魔，3：仙，4：妖）
%%          Faction    		u8       门派（1~6分别代表6个门派，门派名待定）
%%	        Sex        		u8       性别（1：男，2：女）
%%	        Lv         		u16      等级
%%	        Name       		string   名字
%%         )




%% --------------- 创建角色 -------------------------
-define(PT_CREATE_ROLE,  10003).

%% 协议号:10003
%% c >> s:
%%      Race        u8       种族（1：人，2：魔，3：仙，4：妖）
%%      Sex         u8       性别（1：男，2：女）
%%      Name        string   名字

%% s >> c:
%%      RetCode     	u8       成功则返回0，否则返回下面定义的失败原因值
%%      NewRoleId   	u64    	 新建角色的id，全局唯一（若创建失败，则该值无效，固定返回0）
%%      NewRoleLocalId  u32      新建角色的服务器内部流水id，不具备全局唯一性，仅用于客户端在面板做显示给玩家看，不做他用（若创建失败，则该值无效，固定返回0）
%%      Race        	u8       种族
%%      Sex         	u8       性别
%%      Name        	string   名字


% CR: create role
-define(CR_FAIL_UNKNOWN,         1).         % 失败（未知错误）
-define(CR_FAIL_ROLE_LIST_FULL,  2).         % 角色列表满了，不能再创建
-define(CR_FAIL_NAME_EMPTY,      3).         % 角色名不能为空
-define(CR_FAIL_NAME_TOO_SHORT,  4).         % 角色名太短
-define(CR_FAIL_NAME_TOO_LONG,   5).         % 角色名太长
-define(CR_FAIL_CHAR_ILLEGAL,    6).         % 角色名包含非法字符
-define(CR_FAIL_NAME_CONFLICT,   7).         % 角色名已经被使用了，请重新输入名字





%% --------------- 请求进入游戏 -------------------------
-define(PT_ENTER_GAME, 10004).

%% 协议号:10004
%% c >> s:
%%        Id       u64    角色id

%% s >> c:
%%        RetCode  u8       成功则返回0，否则返回下面定义的失败原因值（若成功，则客户端随后发13001协议查询玩家信息，然后开始加载场景）
%%        Id       u64    角色id
       

-define(ENTER_GAME_FAIL_UNKNOWN,      1).   % 失败（未知错误）
-define(ENTER_GAME_FAIL_ROLE_BANNED,  2).   % 角色被封禁了
-define(ENTER_GAME_FAIL_SERVER_FULL,  3).   % 服务器人满了
-define(ENTER_GAME_FAIL_SERVER_BUSY,  4).   % 服务器繁忙，请稍后再试
        





%% --------------- 删除角色 -------------------------
-define(PT_DISCARD_ROLE, 10005).

%% 协议号:10005
%% c >> s:
%%      Id       u64    角色id

%% s >> c:
%%      RetCode  u8     删除成功返回0，失败返回1
%%      Id       u64    角色id
	
	




%% --------------- 心跳包 -------------------------
-define(PT_CONNECTION_HEARTBEAT, 10006).

%% 协议号:10006
%% c >> s:
%%      无（只发协议号）





%% --------------- 通知客户端：账号在别处登录了 -------------------------
-define(PT_NOTIFY_ACC_RELOGIN, 10007).

%% 协议号:10007
%% s >> c:
%%       无（只发协议号）


%% --------------- 查询服务器的时间戳 -------------------------
-define(PT_QUERY_SERVER_TIMESTAMP, 10008).

%% 协议号:10008
%% c >> s:
%%      无
%% s >> c:
%%      TimeStamp      u32     unix时间戳


%% --------------- 客户端通知服务端：客户端已初始化完毕 -------------------------
-define(PT_C2S_NOTIFY_INIT_DONE, 10009).



%% --------------- 通知客户端：即将被服务器强行断开 -------------------------
-define(PT_NOTIFY_WILL_BE_FORCE_DISCONN_SOON, 10010).

%% 协议号:10010
%% s >> c:
%%      Reason      u8      被强行断开的原因（见下面的说明）


%% 原因：
%% 1 => 涉嫌使用加速外挂


%% --------------- 修改角色 -------------------------
-define(PT_MODIFY_ROLE_NAME,  10011).

%% 协议号:10011
%% c >> s:
%%      GoodsId     u64      消耗的物品id
%%      Name        string   名字

%% s >> c: 返回两条协议
%%      PT_NOTIFY_PLAYER_AOI_INFO_CHANGE2 (12018协议)
%%      PT_MODIFY_ROLE_NAME 
%%      RetCode     u8  0表示成功
%%      Name        string 最新的名字


%% -------------------- 检测角色名字是否已存在 --------------
-define(PT_CHECK_ROLE_NAME_REPEAT,		10012).
%% 协议号:10012
%% c >> s:
%%      Name        string   名字

%% s >> c:
%%      RetCode     u8  0表示未被使用 | 1:表示已被使用



%% --------------- 查询手机绑定状态 -------------------
-define(PT_ACCOUNT_BIND_STATE,			10020).

%% 协议号：10020
%% c >> s：
%% 		无(空参协议) 发送成功
%% s >> c: 
%%		ret 		int8u		0:未绑定 | 1：已绑定


%% --------------- 发送验证码 ------------------------
-define(PT_ACCOUNT_BIND_PHONE_SMS,		10021).

%% 协议号：10021
%% c >> s：
%% 		Mobile		string 		手机号
%% s >> c: 
%%		无(空参协议) 发送成功


%% ---------------- 绑定手机号 ----------------------
-define(PT_ACCOUNT_BIND_PHONE_CONFIRM,		10022).

%% 协议号：10022
%% c >> s：
%% 		Mobile		string 		手机号
%%		Code 		int32		验证码
%% s >> c: 
%%		无(空参协议) 成功


%% --------------- 玩家反馈意见 -------------------------
-define(PT_FEEDBACK,		10030).

%% 协议号：10030
%% c >> s：
%% 		type 		int8u 		类型
%%	    Opinion		string		意见

%% s >> c :
%%		无(空参协议) 成功




