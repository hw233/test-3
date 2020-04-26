%%% 取经之路相关协议
%%% 2018.7.04
%%% @author: wujiancheng
%%% 分类号：38

%% pt: 表示protocol


%%--------获取取经之路主界面信息 -------------
-define(PT_GET_ROAD,38000).
%% 协议号:38000
%% c >> s:
%%    

%% s >> c:
%%      NowPoint           u8      当前关卡 
%%      ResetTimes         u8      可重置次数
%%      array(
%%            GetPoint     u8      已经领取的通关奖励
%%           )    


%%--------战斗准备界面信息 -------------
-define(PT_READY_BATTLE,38001).
%% 协议号:38001
%% c >> s:
%%    

%% s >> c:
%% 
%%      玩家所有的门客数据，用于更换门客
%%      array(
%%            id          u64      宠物id
%%            no          u32      宠物no
%%            lv          u16       宠物lv
%%            quality     u8       宠物品质
%%            Hp          u32      宠物血量 等于0时为阵亡
%%			  HpMax		  u32      宠物血量最大值
%%            Mp          u32      宠物蓝量
%%			  MpMp		  u32      宠物蓝量最大值
%%            BattlePower u32      宠物评分
%%            name        string   宠物名字
%%           )
%%      当前战斗准备界面的五只门客
%%      array(
%%            id          u64      宠物id
%%            no          u32      宠物no
%%            lv          u16       宠物lv
%%            quality     u8       宠物品质
%%            Hp          u32      宠物血量 等于0时为阵亡
%%			  HpMax		  u32              宠物血量最大值
%%            Mp          u32      宠物蓝量
%%			  MpMax		  u32              宠物蓝量最大值
%%			  Main        u8       0是副宠 1是主宠
%%           )  
%%      敌方的五只门客
%%      array(
%%            PartnerId   u64      宠物id
%%            no          u32      宠物no
%%            lv          u16       宠物lv
%%            quality     u8       宠物品质
%%            Hp          u32      宠物血量 等于0时为阵亡
%%			  HpMax		  u32      宠物血量最大值
%%            Mp          u32      宠物蓝量
%%			  MpMax		  u32      宠物蓝量最大值
%%			  Main        u8       0是副宠 1是主宠
%%           )    
%%      PkName            string   对手名字
%%      MenPai            u8       对手门派
%%      Pklv              u16       对手等级
%%      PkSex             u8       对手性别       
%%      viplv             u8       对手vip等级  


%%--------开始战斗 -------------
-define(PT_START_BATTLE,38002).
%% 
%% 协议号:38002
%% c >> s:
%  array(
%%            PartnerId       u64
%%			  Main 			  u8   0是副宠 1是主宠
%%       )
%%  
%%    

%% s >> c:
%%   state           u8        0代表进入取经战斗      1代表退出
%%      
%%         

%%--------重置次数-------------
-define(PT_RESET_ROAD,38003).
%% 协议号:38003
%% c >> s:
%%      
%%    

%% s >> c:
%%      重置是否成功                  u8      0代表重置成功           1代表重置失败

%%--------领取奖励-------------
-define(PT_GET_REWARD,38004).
%% 协议号:38004
%% c >> s:
%%      step        	u8     
%%    

%% s >> c:
%%      state           0代表领取成功           