%%--------获取帮派副本主界面信息 -------------
-define(PT_GET_GUILD_INFO,53000).
%% 协议号:53000
%% c >> s:
%%    

%% s >> c:
%%      NowPoint           u8      今天解锁的关卡 
%%      FinishPoint        u8      完成的关卡  
%%      FinalAward         u8      全通关大奖，0表示未领取/1表示已领取/2表示不能领取


%%--------获取每个副本关卡信息 -------------
-define(PT_GET_POINT_INFO,53001).
%% 协议号:53001
%% c >> s:
%%      Point              u8      查看的关卡  

%% s >> c:
%%      SelectPoint        u8      选择的关卡 
%%      Progress           u16      当前关卡进度  581代表58.1%
%%      Contribution       u16      当前关卡的贡献值
%%      finishiValue       u32     击杀加上采集的数量值
%%      array(
%%             PreAward        u8       当前关卡已领取的进度奖励   
%%           )  


%%--------采集NPC-------------------
-define(PT_COLLECTION_RESPOND,53002).
%% 协议号:53002
%% c >> s:
%%      Point              u8     关卡  


%%--------进入相应的副本-------------------
-define(PT_ENTER_DUNGEON,53003).
%% 协议号:53003


%% s >> c:
%%      BossHp             u32     Boss当前剩余的hp(进度就为零以此来区分第七关)

%%--------获取副本关卡目标详情-------------------
-define(PT_DUNGEON_DETAIL,53004).
%% 协议号:53004
%% c >> s:
%%     

%% s >> c:
%%      Count              u16     采集的数量
%%      Kill               u16    击杀或者掉落的数量 
%%      Boss               u8     Boss击杀数量



% 帮派副本  副本界面排名信息
-define(PT_DUNGEON_RANK,53005).
% C >> S:
% S >> C:
%    point          u8          关卡
%    array( 
%       roleName    string
%       value      u32         数量/伤害值  第七关只显示BOSS的伤害值
%    )
%


% 领取奖励
-define(PT_GET_REWARD,53006).
% C >> S:
%    point          u8          关卡
%    reward         u8          奖励，0代表通关大奖1、2、3、4、5对应进度奖20、%40···
% S >> C:
%    result         u8          1代表领取成功












