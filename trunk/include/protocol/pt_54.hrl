%% =========================================================
%% 54 寻宝&许愿池
%% =========================================================
%%--------开始寻宝 -------------
-define(PT_START_AWARD_HUNTING,54001).
%% 协议号:54001
%% c >> s:
%%    	type			    u8	   1:水玉1次 2：水玉10次 3：奖券一次  		

%% s >> c:             
%%		array{						寻宝结果 数组下标代表第N个奖励
%%			index			u8		对应奖励index
%%		}
%%      lucky_value        	u16      抽奖完后的幸运值  
%%      weekly_award       	u16      抽奖完后的每周累积次数

%%--------领取每周累积奖励 -------------
-define(PT_GET_WEEKLY_AWARD,54002).
%% 协议号:54002
%% c >> s:
%%    	type			    u8	   	1 ~ 5 1:领取第一个 2：领取 第二个 。。。	

%% s >> c:             
%%		array{							新的领取状态 数组下标代表第N个箱子
%%			 state          u8  	
%%		}

%%--------玩家打开寻宝界面 -------------
-define(PT_ON_AWARD_HUNTING_PANEL_OPEN,54003).
%% 协议号:54003
%% c >> s:
%%      type			    u8	   	1

%% s >> c:     
%%      lucky_value        	u16     抽奖完后的幸运值  
%%      weekly_award       	u16      抽奖完后的每周累积次数  
%%		array{						领取状态
%%			 state          u8  
%%		}

%%--------玩家关闭寻宝界面 -------------
-define(PT_ON_AWARD_HUNTING_PANEL_CLOSE,54004).
%% 协议号:54004
%% c >> s:
%%    	type			    u8	   	1



%%--------后端推送寻宝记录 -------------
-define(PT_PUSH_HUNTING_RECORD,54005).
%% 协议号:54005
%% c >> s:
%%    	无

%% s >> c:     
%%		array{						寻宝记录
%%			 name          string  	玩家名字
%%			 goods_no	   u32   	道具编号	
%%			 amount		   u32		道具数量
%%           quality       u8
%%		}

%%-----------玩家打开许愿池界面--------------
-define(PT_ON_AWARD_TREASURE_PANEL_OPEN,54010).
%% 协议号：54010
%% C >> S：
%%      type			         u8	                   许愿发2	
%% S >> C:
%%      Total_integral      	u32     	奖池总积分
%%      Total_amount      		u16      	玩家当前抽取次数
%%      array{
%%          no                  u8          玩家已领取奖励编号
%%          num                 u16         玩家已领取该档位的数量
%%      }

%%--------后端推送幸运玩家名单-------------
-define(PT_PUSH_TREASURE_RECORD,54011).
%% 协议号：54011    
%% S >> C:
%%		array{							寻宝记录
%%			 name          string  		玩家名字
%%			 goods_no	   u32   		道具编号	
%%			 amount		   u32			道具数量
%%           quality       u8           品质
%%		}    

%%--------开始许愿-------------
-define(PT_START_AWARD_TREASURE,54012).
%% 协议号：54012
%% C >> S:
%%      Type         u8          1:许愿一次，2：许愿10次，3：使用许愿币           
%% S >> C:
%%		array{						 		
%%			goods_no			u32			道具编号
%%			amount				u32			道具数量
%%          quality             u8          特效品质
%%		}
%%      Total_integral        	u32      	奖池总积分  
%%      Total_amount      		u16      	玩家当前抽取次数
	
%%--------领取许愿满100次的奖励-------------
-define(PT_GET_FULL_TREASURE,54013).
%% 协议号：54013
%% C >> S:
%%      index   		        u8                       玩家选择宝箱位置
%% S >> C:
%% S >> C:
%%		flag 					u8   		1：领取成功，0：领取失败
%%  	Total_integral      	u32     	奖池总积分
%%		Total_amount      		u16      	玩家当前抽取次数
%%      array{
%%          no                  u8          玩家已领取奖励编号
%%          num                 u16         玩家已领取该档位的数量
%%      }
%%	     

%%--------玩家关闭许愿池界面界面 -------------
-define(PT_ON_AWARD_TREASURE_PANEL_CLOSE,54014).
%% 协议号:54004
%% c >> s:
%%    	type                    u8                         许愿发2


%%-----------大富翁玩法------------------------------
%-----------进入入口界面----------------
-define(PT_ENTER_CHESS_CHECK_PANEL,54101).
%% 协议号：54101
%% C >> S:
%% S >> C:
%%      free        	        u8      	当前免费次数
%%      total      				u8      	当前总剩余次数
%-----------队长请求进入游戏----------------
-define(PT_REQUEST_ENTER_CHESS_GAME,54102).
%% 协议号：54102
%% C >> S: 无
%% S >> C:
%%		array{						 		数组长度是全地图总共的格子个数，前端依据这个顺序生成环形地图
%%			no					u32			no值：0 代表随机事件格子，前端生成问号格子
%% 		}										  其他值 对应奖励goods的goods_no，前端查表生成对应图标的格子,
%%      position                u8          所在位置
%%		推送给全队

%-----------免费次数不足----------------
-define(PT_CHESS_ENTER_INVALID,54103).
%% 协议号：54103
%% S >> C: 无
%%		推送给次数不足的队员
%% C >> S:
%%		type					u8			玩家选择 1.使用水玉 2.不使用


%-----------通知有人次数不足----------------
-define(PT_CHESS_NOTIFY_INVALID,54104).
%% 协议号：54104
%% S >> C:
%%		type					u8     		1.次数不足 2.水玉不足 3
%%      name					string 		玩家名字

%-----------队长掷骰子----------------
-define(PT_CHESS_THROW_DICE,54105).
%% 协议号：54105
%% C >> S:
%%		type					u8			0:正常投掷，返回随机1~6
%%											1~6：使用遥控骰子，后端自行判断是否为免费使用
%% S >> C:
%%		type					u8     		投掷结果 1~6

%-----------玩家走到某个格子----------------
-define(PT_CHESS_STAND_ON_CELL,54106).
%% 协议号：54106
%% C >> S: 无
%%		type					u8			玩家当前走到的格子index
%% S >> C:
%%		type					u8     		随机事件	1.禁用遥控骰子 2.免费遥控骰子 3.进入战斗
%%		走到随机事件格子，就返回54106，走到奖励格子，就直接发奖励

%-----------退出界面----------------
-define(PT_EXIT_CHESS_GAME,54107).
%% 协议号：54101
%% C >> S:无
%% S >> C:
%% 		id						u64			退出的玩家ID
%%		推送给剩余队员

%-----------获得奖励----------------
-define(PT_CHESS_GET_REWARD,54108).
%% 协议号：54108
%% C >> S:无
%% S >> C:
%%      no						u32			道具no
%%		amount					u32			道具数量




%%-----------玩家自选转盘界面--------------
%%--------打开抽奖面板-------------
-define(PT_OPEN_AWARD_OPTIONAL,54200).
%% 协议号：54200
%% C >> S:
%%
%% S >> C:
%%		array{
%%			no       u8
%%		}

-define(PT_START_AWARD_OPTIONAL,54201).
%% 协议号：54201
%% C >> S:
%%      Type         u8          1:抽奖一次，2：抽奖10次
%% S >> C:
%%    	array{
%%			no			u8		道具对应表配的编号
%%		}

%%--------重置抽奖-------------
-define(PT_RESET_FULL_TREASURE,54202).
%% 协议号：54202
%% C >> S:
%%     refresh          u8          1开始重置
%%

%%--------玩家自选物品道具编号-------------
-define(PT_OPTIONAL_TREASURE_NO,54203).
%% 协议号:54203
%% c >> s:
%%    	array{
%%			no			u8		道具对应表配的编号
%%		}

%%s >>c
%%  code        u8   1表示成功，0失败