%%%------------------------------------------------
%%% File    : sys_set.hrl
%%% Author  : huangjf 
%%% Created : 2014.2.27
%%% Description: 玩家的系统设置
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__SYS_SET_H__).
-define(__SYS_SET_H__, 0).













%% 玩家的系统设置
%% 数值为0的时候都是没有打钩的状态
-record(sys_set, {
                  player_id = 0,
                  is_dirty = false,          % 标记是否为脏，是脏的话，下线时需要保存数据库
                  is_auto_add_hp_mp = 0,     % 玩家是否开启使用物品自动补给血库和魔法库 1--是，0--否
                  is_auto_add_par_hp_mp = 0, % 玩家是否开启使用物品自动补给宠物血库和宠物魔法库 1--是，0--否
                  is_accepted_leader = 0,    % 是否允许被请求担任队长  0--允许，1--不允许
                  is_accepted_team_mb = 0,   % 是否接收加入队伍邀请   0--接收，1--不接收
                  is_accepted_friend = 0,    % 是否接收加为好友请求   0--接收，1--不接收
                  is_accepted_pk = 0,        % 是否接受pk邀请 0--接收，1--不接收
                  is_par_clothes_hide = 0,   % 女妖画皮  0 表示展示，1表示隐藏 
                  is_headwear_hide = 0,		 % 角色面具  0 表示展示，1表示隐藏
                  is_backwear_hide = 0,		 % 角色背饰  0 表示展示，1表示隐藏
                  is_clothes_hide = 0, 		 % 角色时装  0 表示展示，1表示隐藏
				  paodian_type = 0          % 0免费 >1 付费
                 }).














-endif.  %% __SYS_SET_H__
