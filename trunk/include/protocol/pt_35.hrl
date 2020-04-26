
%%% 推广系统的相关协议
%%% 2014.8.4
%%% @author: huangjf
%%% 分类号：35

%% pt: protocol
%% sprd: spread（推广）
%% sprd rela: spread relation（推广关系）
%% sprder: 推广人
%% sprdee: 被推广人
				 


%%----------- 查询我的推广信息 ------------
-define(PT_QRY_MY_SPRD_INFO,  35000).

%% 协议号：35000
%% C >> S: 
%%     无
%%  
%% S >> C: 
%%	   array(     我的被推广人列表（即已接受我的推广的被推广人列表）
%%	        SprdeeId      u64          被推广人的id
%%          SprdeeRace    u8           被推广人的种族
%%          SprdeeSex     u8           被推广人的性别
%%          SprdeeName    string       被推广人的名字
%%          SprdeeLv      u8           被推广人的等级
%%	       )
%%     MySprdCode         string       我的推广码
%%     MySprderId         u64          我的推广人（即我主动请求与之建立推广关系的人）的id，若没有则返回0
%%     MySprderRace       u8           我的推广人的种族，若没有则返回0
%%     MySprderSex        u8           我的推广人的性别，若没有则返回0
%%     MySprderName       string       我的推广人的名字，若没有则返回空字串
%%     MySprderLv         u8           我的推广人的等级，若没有则返回0




%%----------- 请求建立推广关系 ------------
-define(PT_REQ_BUILD_SPRD_RELA,  35001).

%% 协议号：35001
%% C >> S: 
%%     TargetSprdCode  string     目标玩家的推广码
%%  
%% S >> C: 
%%     RetCode         u8         如果成功则返回0，否则不返回，而是直接发送失败提示消息协议




%%----------- 通知推广关系双方：新的推广关系建立了 ------------
-define(PT_NOTIFY_NEW_SPRD_RELA_BUILDED,  35002).

%% 协议号：35002
%% S >> C: 
%%     SprderId      u64         推广人的id
%%     SprderRace    u8          推广人的种族
%%     SprderSex     u8          推广人的性别
%%     SprderName    string      推广人的名字
%%     SprderLv      u8          推广人的等级
%%     SprdeeId      u64         被推广人的id
%%     SprdeeRace    u8          被推广人的种族
%%     SprdeeSex     u8          被推广人的性别
%%     SprdeeName    string      被推广人的名字
%%     SprdeeLv      u8          被推广人的等级
