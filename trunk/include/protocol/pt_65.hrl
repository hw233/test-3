%% =========================================================
%% 65  帮战协议
%% =========================================================

% 进入第一区域 进入战场
-define(PT_ENTER1, 65001).
% 协议号： 65001
% C >> S:

% S >> C:
% HaltTime			u32 冷却时间

% 进入区域二读条
-define(PT_ENTER2, 65002).
% 协议号： 65002
% C >> S:
%     NPCID        u8              %   NPC编号
% S >> C:
%   Code           u8

% 进入区域二读条
-define(PT_ENTER3, 65003).
% 协议号： 65003
% C >> S:
%     NPCID        u8              %   NPC编号
% S >> C:
%   Code           u8

% 拿取王座
-define(PT_TAKE, 65004).
% 协议号： 65004
% C >> S:
%     NPCID        u8              %   NPC编号
% S >> C:
%   Code           u8

% 快速清除冷却CD
-define(PT_QUICK_CLEAR, 65005).
% 协议号： 65005
% C >> S:
% S >> C:
%   Code           u8

% 进入区域二读条
-define(PT_QUICK_ENETR2, 65006).
% 协议号： 65006
% C >> S:
% S >> C:
%   Code           u8

% 取消读条
-define(PT_CANCEL_ENTER, 65007).
% 协议号： 65006
% C >> S:
% S >> C:
%   Code           u8


% 帮派战结束战报界面 或者主动查询
-define(PT_GUILD_END_SEND,65008).
% 协议号：65008
% C >> S:
%		Rounds  					u32					帮战轮次

% S >> C:
%		Type                        u8                  是客户端询问还是主动推送 0推送 1客户端访问

%		Rounds  					u32					帮战轮次
%		Join_battle_player_count  	u32					参与帮战人数
%		Join_battle_guild_count  	u32					参与帮战帮派数
%		
%		Better_fighter_name 		string				最佳战斗王名称
%		Better_fighter_player_id  	u64					最佳战斗王id
%		
%		Better_touch_throne_name    string				最佳偷鸡王
%		Better_touch_throne_player_id  u64				最佳偷鸡王id
%			
%		Better_trouble_name          string				最佳捣蛋王
%		Better_trouble_player_id  	 u64				最佳捣蛋王id
%		
%		Better_streak_name           string				最佳连胜王
%		Better_streak_player_id      u64				最佳连胜王id
%		
%		Better_defend_name           string				最佳防守王
%		Better_defend_player_id      u64				最佳防守王id
%		
%		Better_try_name              string				最佳尽力王
%		Better_try_player_id         u64				最佳尽力王id
%				
%		Join_battle_max_rate         u8					最佳参与率帮派 参与率
%		Join_battle_max_rate_guild_id  u64				最佳参与率帮派id
%		Join_battle_max_rate_guild_name  string			最佳参与率帮派名称
%		
%		Join_battle_max_count          u8				参与人数最多帮派人数
%		Join_battle_max_count_guild_id  u64				参与人数最多的帮派id
%		Join_battle_max_count_guild_name  string		参与人数最多的帮派名字
%		
%		Win_guild_name  = string						获得胜利帮派名称
%		Win_guild_id  = u64								获得胜利帮派id
%		
%		Take_throne_player_id  = u64					获取王座的玩家id
%		Take_throne_player_name  = string				获取王座的玩家名称

%		Enter1_count					u32,                        %   进入第一区域次数
%		Enter2_count					u32,                        %   进入第二区域次数
%		Enter3_count					u32,                        %   进入第三区域次数
%		Touch_throne					u32,                        %   触摸王座次数
%		Interrupt_load					u32,                      	%   打断被人读条次数
%		Battle_win						u32,                        %   战斗胜利次数
%		Battle_lose						u32,                        %   战斗失败次数
%		Max_winning_streak				u32,                  		%   最大连胜次数
%		Point							u32,                        %   积分
%		Rank							u32                         %   排名

% 查询当前届的帮战信息
-define(PT_GET_CUR_GUILD_INFO,65009).
% 协议号：65009
% C >> S:
% S >> C:

% Rounds   u32	% 当前轮次
% State    u8	% 当前状态 								0 等待 1进行中 2 结束
% Time     u32	% 帮战持续时间或者等待时间 				状态为等待则是等待时间 状态为进行中则是进行时间

% % 查询个人排行
-define(PT_GET_GUILD_BATTLE_PLAYER_RANK,65010).
% 协议号：65010
% C >> S:
%		Rounds  					u32					帮战轮次

% S >> C:
% Rounds   			u32	% 当前轮次
% PlayerCount 		u32 % 参与人数
% MyRank 			u32 % 我的排名

% array( 
% 	PlayerName              string	  
%   PlayerId                u64	 
%   GuildName    			string		 					         
%   GuildId                 u64	   
%   Enter1_count   		u32			% 进入第1区域次数
%   Enter1_time        	u32			% 进入第1区域时间
%   Enter2_count 		u32			% 进入第2区域次数
%   Enter2_time 		u32			% 进入第2区域时间
%   Enter3_count  		u32			% 进入第3区域次数
%   Enter3_time 		u32			% 进入第3区域时间
%   Touch_throne  		u32			% 触摸王座次数
%	Interrupt_load		u32			% 打断别人读条
%	Battle_win  		u32			% 战斗胜利次数
%	Battle_lose   		u32			% 战斗失败次数
%	Winning_streak		u32			% 连胜次数
%	Max_winning_streak  u32	    	% 最大连胜次数
%	Point				u32			% 积分
%	Rank				u32			% 排名
%	)

% % 查询帮派排行
-define(PT_GET_GUILD_BATTLE_GUILD_RANK,65011).
% 协议号：65011
% C >> S:
%		Rounds  					u32					帮战轮次

% S >> C:
% Rounds   			u32	% 当前轮次
% GuildCount 		u32 % 参与人数
% MyRank 			u32 % 我帮排名

% array( 
%   GuildName    			string	
%   GuildId                 u64	   	 	
%	Battle_count  				u32			% 战斗胜利次数
%	Battle_win  				u32			% 战斗胜利次数
%   Touch_throne  				u32			% 触摸王座次数
%   Join_battle_player_count 	u32			% 参战人数
%	Point						u32			% 积分
%	Rank						u32			% 排名
%	)


% % 查询帮派排行
-define(PT_SEND_PLAYER_LV_LIMIT,65012).
% 协议号：65012

% S >> C:
% PlayerId   			u64		% 玩家id
% PlayerName 			string 	% 玩家名称
% PlayerLv 				u32 	% 玩家等级


% 取消读条
-define(PT_LOAD_TIME, 12027).
% 协议号： 12027
% S >> C:
%   PlayerId           u64   % 玩家id
%   NPCID              u8    % 读条NPC
%   LoadTime           u16   % 读条秒数
