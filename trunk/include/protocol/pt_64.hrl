%% =========================================================
%% 64  老虎机协议
%% =========================================================

% 获取老虎机详情
-define(PT_SLOTMACHINE_INFO, 64001).
% 协议号： 64001
% C >> S:

% S >> C:
%     CurRounds		u32             %  当前轮次
%     LeftTime      u32             %  剩余开奖时间
%     Change        u16              %  我购买的大盘 跌涨平
%     Value         u32             %  大盘购买量 0 未购买
%     Array (						历史记录
%        Rounds u32                 %  历史轮次
%        No		u32                 %  配置no
%        Change u16                  %  大盘涨跌
%     )
%     Array (						我购买信息
%		Class  u32                  % 类别
%       Count  u32                  % 购买量
%	  )
%     Array (						全服购买量
%		Class  u32                  % 类别
%       Count  u32                  % 购买量
%	  )

% 下注期货
-define(PT_SLOTMACHINE_BUY_1, 64002).
% 协议号： 64002
% C >> S:
%     Array (						购买
%		Class  u32                  % 类别
%       Count  u32                  % 购买量
%	  )

% 返回 64001

% 下注大盘
-define(PT_SLOTMACHINE_BUY_2, 64003).
% 协议号： 64003
% C >> S:
%     Change        u8              %  我购买的大盘 跌涨平
%     Value         u32             %  大盘购买量 0 未购买
% S >> C:
%     Code    u8      成功失败

% 返回 64001

% 客户端定期发改协议更新界面 如果界面处于打开状态的话
-define(PT_SLOTMACHINE_SERVER_INFO, 64004).
% 协议号： 64004                    刷新全服购买信息
% C >> S:
% S >> C:
%     CurRounds		u32             %  当前轮次
%     LeftTime      u32             %  剩余开奖时间
%     Array (						全服购买量
%		Class  u32                  % 类别
%       Count  u32                  % 购买量
%	  )
% S >> C:
%     Code    u8      成功失败


% 在线玩家接收到此协议后弹出开奖界面开始转圈圈
-define(PT_SLOTMACHINE_LOTTERY_OPEN, 64005).
% 协议号： 64005                    推送开奖
% S >> C:
%     CurRounds		u32             %  当前轮次
%     No            u32             %  开奖编号
%     Change        u16              %  大盘涨跌

%     MyChange        u8            %  我购买的大盘 跌涨平
%     Value         u32             %  大盘购买量 0 未购买

%     Array (						我购买信息
%		Class  u32                  % 类别
%       Count  u32                  % 购买量
%	  )

