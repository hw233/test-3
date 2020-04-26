%%% 家园相关协议
%%% 2018.05.14
%%% @author: goku
%%% 分类号：37

%% pt: 表示protocol

%% 家园 建造/请求总览 
-define(PT_HOME_BUILD,		 37000).
% 协议号：37000
% C >> S: 
% 		type       	  		u8      	0:请求总览信息/1:请求建造家园
% S >> C: 
%	 luxury			  		u32		豪华度
%	 lv_home		  		u16		家园等级	 
%	 lv_land		  		u16		土地等级
%    count_planting	  		u16		栽种植物数量
%    count_plant_finish	  	u16		栽种完成植物数量
%    count_plant_dead	  	u16		枯萎植物数量 
%	 lv_dan			  		u16		炼丹炉等级
%    count_refining	  		u16		正在炼制数量
%    count_refined	  		u16		炼制完成数量
% 	 lv_mine		  		u16		矿井等级
%    count_mining	  		u16		正在采矿数量
%    count_mined	  		u16		采矿完成数量




-define(PT_HOME_ENTER_SCENE, 37001).
%% 进入家园场景
%% C >> S :    
%%      id       u64        要进入的角色的id-回家发0
%%      type	 u8			回家类型

-define(PT_HOME_LEAVE_SCENE, 37002).
%% 退出家园场景
%% C >> S :
%%      仅发协议号


%% 格子数据结构 grid_data
%		type		  u8		1土地2炼丹炉3矿井
%		no			  u16		格子编号
%		goods_no	  u32		植物/炼丹/矿石编号
%		partner_no	  u32		门客编号
%		start_time 	  u32		开始的时间戳
%		time_speedup  u16		加速的秒数
%		reward_multi  u16		收获的翻倍数
%		reward_lvlup  u32		奖励的升级等级（(只有土地有效，其余类型为0)）      	
%       is_steal      u8        0表示没有被偷  1表示被偷	

%%-----------请求当前所在家园场景信息（）------------
-define(PT_GET_HOME_INFO, 37003).
% 协议号：37003
% C >> S: 
%%      仅发协议号
% S >> C:
%	 luxury			  u32		豪华度
%	 lv_home		  u16		家园等级	 
%	 lv_land		  u16		土地等级
%	 lv_mine		  u16		矿井等级
% 	 lv_dan			  u16		炼丹炉等级
%	 count_land		  u16		土地开启数量
%	 count_mine		  u16		矿井开启数量
% 	 count_dan		  u16		炼丹炉开启数量
%	 array( 土地/炼丹炉/矿井格子数据(只发有数据格子)
%		grid_data  -- 详细定义看上面
%	 )


%%-----------家园升级（家园，土地，炼丹炉，矿井）------------
-define(PT_HOME_LEVEL_UP, 37004).
% 协议号：37004
% C >> S: 
% 		type       	  		u8      	0家园1土地2炼丹炉3矿井
% S >> C:
% 		type       	  		u8      	0家园1土地2炼丹炉3矿井
% 		lv       	  		u8      	升级后的等级

%%-----------家园开始种植/炼丹/挖矿（土地，炼丹炉，矿井）------------
-define(PT_HOME_JOB_START, 37005).
% 协议号：37005
% C >> S: 
% 		type       	  		u8      	1土地2炼丹炉3矿井(种植/炼丹/挖矿)
%		no					u8			编号
%		goods_no			u32			内容
%		partner_id			u64			门客id
  
% S >> C:
%		grid_data  -- 详细定义看上面


%%-----------家园行为 1(浇水/传力/充能) 2(除虫/注入/强化) 3施肥(土地特有) ------------
-define(PT_HOME_JOB_ACTION, 37006).
% 协议号：37006
% C >> S: 
% 		type       	  		u8      	1土地2炼丹炉3矿井(种植/炼丹/挖矿)
%		no					u8			编号
%		action				u8			行为类型0(铲除/中断/召回) 1(浇水/传力/充能) 2(除虫/注入/强化) 3施肥(土地特有) 4收获
  
% S >> C:
% 		type       	  		u8      	1土地2炼丹炉3矿井
%		no					u8			编号
%		action				u8			行为类型0(铲除/中断/召回) 1(浇水/传力/充能) 2(除虫/注入/强化) 3施肥(土地特有) 4收获
%		eff_now				u32			当前行为效果值
%		eff_final			u32			最终累计效果值


%%-----------家园 1(铲除/中断/召回) 2收获------------
-define(PT_HOME_JOB_ACTION_FINISH, 37007).
% 协议号：37007
% C >> S: 
% 		type       	  		u8      	1土地2炼丹炉3矿井(种植/炼丹/挖矿)
%		no					u8			编号
%		action				u8			行为类型 1(铲除/中断/召回) 2收获
  
% S >> C:
% 		type       	  		u8      	1土地2炼丹炉3矿井(种植/炼丹/挖矿)
%		no					u8			编号
%		action				u8			行为类型 1(铲除/中断/召回) 2收获
%       master              u8          0为主人  1为访客


%%--------------家园成就数据----------------------
-define(PT_HOME_ACHIEVEMENT_DATA,		37008).
% 协议号：37008
% C >> S: 
%		只发协议号
  
% S >> C:
%	 array( 
%		type				u8			成就条件类型(1家园等级2土地等级等等...和家园成就配置表条件类型一致)
%		value				u32			成就值
%	 )
%	 array(
%		no					u32			已经领取了奖励的成就
%	 )

%% 领取成就奖励
-define(PT_HOME_ACHIEVEMENT_REWARD,		37009).
% 协议号：37009
% C >> S: 
%		no					u32			成就no
  
% S >> C:
%		no					u32			成就no


%% 请求家园拜访界面
-define(PT_HOME_VISIT_LIST,		37010).
% 协议号：37010
% C >> S: 
%		只发协议号
  
% S >> C:
%	 array( 
%		id				u64			玩家id
%		name			string		名字
%		faction			u8			门派
%		lv				u16			等级
%		degree			u32			豪华度
%	 )


%% 搜索玩家家园
-define(PT_HOME_VISIT_SEARCH,		37011).
% 协议号：37011
% C >> S: 
%		name			string		玩家名字
  
% S >> C:
%		id				u64			玩家id
%		name			string		名字
%		faction			u8			门派
%		lv				u16			等级
%		degree			u32			豪华度




