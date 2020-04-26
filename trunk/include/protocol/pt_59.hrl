%% =========================================================
%% 59 章节成就
%% =========================================================

% =========================
% 查看章节成就内容
% 协议号：59001
% C >> S:
%   chapter_no         u8          章节No
% S >> C:
%   chapter_no         u8          章节No
%   rwd_state           u8         1成就未完成 2成就完成,奖励未领取, 3成就完成，奖励领取
%   array{
%       chai_no         u16         成就编号
%       cur_num         u32         当前计数
%       max_num         u32         最大计数
% }

% =========================
% 领取章节奖励
% 协议号：59002
% C >> S:
%   chapter_no         u8          章节No

% S >> C:
%   chapter_no         u8          章节No
%   flag               u8          0->成功




% =========================
% 查看所有章节成就
% 协议号：59003
% C >> S:
% S >> C:
%    array(
        %   chapter_no         u8          章节No
        %   flag               u8          1->未完成 2->完成未领取 3->已领取
%        )

% =========================
% 成就达成
% 协议号：59004
% S >> C:
%   chai_no         u16          成就No


% =========================
% 章节成就达成
% 协议号：59005
% C >> S:
%       type               u8   0为查询/1为领取  
%    
% S >> C:
%  
%   	chapter_no         u8    1->三个章节成就达成，2->五个，3->七个  ->4 表示全领取了
%   	flag               u8    1->未完成 2->完成未领取
%   

% =========================
% 章节当日福利
% 协议号：59006
% C >> S:
%   no                     u8    章节
%   type                   u8    0查询，1购买，2充值
% S >> C:
%   flag_buy               u32   0为不可购买，其实数值为今日还可购买的数量
%   flag_recharge          u8    1为可充值/2为不可充值
%   


% =========================
% 副本剧情目标信息
% 协议号：59101
% C >> S:
% S >> C:
%   array(
%       dunNo       u32         副本编号
%       pass        u8          1->通关 0->未通关
%       times       u16         剩余领取奖励次数
%       dun_times   u16         副本剩余次数
%   )


% % =========================
% % 副本剧情目标奖励反馈
% % 协议号：59102
% S >> C:
% array(
%     GoodsId     u64
%     GoodsNo     u32
%     GoodsNum    u16
%     GoodsQua    u8
%     bind        u8          绑定状态
%     )


%% =========================
% % 历练系统(进入游戏推送)
% % 协议号：59200
% S >> C:
%       state1       u64       达成状态(低位开始，0：代表未达成； 1：代表达成)
%       state2       u64       领取状态(低位开始，0：代表未领取； 1：代表领取)

%% =========================
% % 历练系统
% % 协议号：59201
% C >> S:
%       no          u8
% S >> C:
%       发送59200