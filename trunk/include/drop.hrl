%%%------------------------------------------------
%%% File    : drop.hrl
%%% Author  : huangjf
%%% Created : 2013.11.12
%%% Description: 掉落相关的宏定义
%%%------------------------------------------------

% 避免头文件多重包含
-ifndef(__DROP_H__).
-define(__DROP_H__, 0).


%% 掉落详情drop detail
-record(drop_dtl, {
        goods_list = [] % 保存{GoodsId, GoodsNo, GoodsCount} 元组列表

        % 其他， 以后拓展
        }).


%% 掉落包
-record(drop_pkg, {
		no = 0,             % 奖励包编号
		money = null,       % 奖励的金钱信息， 没有则为null，下同
		goods = [],      % 掉落物品
		task_goods = [], % 掉落任务物品列表

		leader_weal = [],   % 队长福利
		act_goods = [] 		  % 活动掉落
	}).









-endif.  % __DROP_H__
