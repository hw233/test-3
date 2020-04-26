%% ################################################
%% 活动相关协议
%% ################################################

%% ======================
%% 答题
%% ======================

% --------------------
% 答题活动开启提示
% 协议号：31001
% C >> S:
% S >> C:
%   state           u8          0:新进入 1:继续答题

% --------------------
% 答题活动信息
% 协议号：31002
% C >> S:
% S >> C:
%     state           u8          活动状态 0：已完成 1：进行中 2:没开放
%     cur_index       u16         当前题目数
%     max_index       u16         总题数
%     correct_num     u16         答对数
%     end_time        u32         结束时间
%     his_cor_num     u32         历史答对数
%     literary        u32         学分
%     exp             u32         经验
%     cur_question    u32         当前题号
%     array(
%       no            u16         礼包编号(连对题数/答对题数)
%       type          u8          0:连对类型  1:答对类型   **
%       state         u8          礼包状态 0：不可领 1：可领 2: 已领    
%    )
%     array(
%       index         u8          锦囊号
%       left_num      u8          剩余数量
%       use_index     u32         使用在哪道题目序号(题目数)上          *
%    )
%     total_literary  u32         总学分



% --------------------
% 答题
% 协议号：31003
% C >> S:
%   no              u32         题号
%   index           u8          选项号
% S >> C:
%   cur_index       u16         当前题目数
%   literary        u32         学分
%   exp             u32         经验
%   question        u32         下一题号 (0->完结) *
%	ten_reward_get  u8          0是没有领取.1是已经领取


% --------------------
% 使用锦囊
% 协议号：31004
% C >> S:
%   index           u8          锦囊编号
%   question        u32         题目数量序号
% S >> C:
%   index           u8          锦囊编号
%   question        u32         题号
%   state           u8          0:成功 1:失败 (参考998)


% --------------------
% 通知礼包可领取
% 协议号：31005
% S >> C:
%	ten_reward_get  u8          0是没有领取.1是已经领取
%   array(
%    no              u16         礼包编号(连对题数)
%    type            u8          0:连对类型  1:答对类型   **
%   )


% --------------------
% 选项屏蔽通知    *
% 协议号：31006
% S >> C:
%   question         u32         题目数量序号
%   array(
%    index           u8          选项序号
%   )


% --------------------
% 领取奖励    *
% 协议号：31007
% C >> S:
%    no              u16         礼包编号(连对题数/答对题数)
%    type            u8          0:连对类型  1:答对类型  **
% S >> C:
%    no              u16         礼包编号(连对题数)
%    type            u8          0:连对类型  1:答对类型  **
%   state             u8         0->成功 1->失败


%% ======================
%% 运营活动相关
%% ======================

% --------------------
% 查询生效的运营活动ID列表
% 协议号：31050
% C >> S:
% S >> C:
%   array(
%       id      u32         活动ID
%    )

% --------------------
% 查询具体活动内容
% 协议号：31051
% C >> S:
%   id          u32         活动ID
% S >> C:
%   id          u32         活动ID
%   start_time  u32         图标开始时间
%   end_time    u32         图标关闭时间
%   content     string      内容



% --------------------
% 查询生效的运营活动2ID列表
% 协议号：31060
% C >> S:
% S >> C:
%   array(
%       id      u32         活动ID
%    )

% --------------------
% 查询具体活动2内容
% 协议号：31061
% C >> S:
%   id          u32         活动ID
% S >> C:
%   id          u32         活动ID
%   content     string      内容
%	array(
%		arg1	u32			达成值1
%		arg2	u32			达成值2
%		array(
%			id		u32			物品ID
%			count	u32			物品数量
%     MimiNum u32   最低充值数
%		)
%	)

% --------------------
% 通知活动改变
% 协议号：31062
% S >> C:
%   id          u32         活动ID
%   type        u8          0:删除；1:新增

% --------------------
% 领取活动奖励
% 协议号：31063
% C >> S:
%   id          u32         活动ID
%   value       u32         达成值
% S >> C:
%   id          u32         活动ID
%   value       u32         达成值

% --------------------
% 活动当前值数据
% 协议号：31064
% S >> C:
%	array(
%   	id          u32         活动ID
%   	value       u32         当前值值
%		array ( =============> 这个数组是代表已经领取了奖励的档次, 如果单笔活动就是0或者非0
%				arg	u32			档次值
%				)
%	)


% --------------------
% 查询生效的节日活动列表
% 协议号：31070
% C >> S:
% S >> C:
%   array(
%       id      u32         活动ID
%       no      u32         活动编号
%    )


% --------------------
% 查询具体节日活动内容
% 协议号：31071
% C >> S:
%   array(
%       id          u32         活动ID
%       no          u32         活动编号
%   )
% S >> C:
%   array(
%       id          u32         活动ID
%       no          u32         活动编号
%       content     string      内容
%   )


% --------------------
% 通知活动改变
% 协议号：31072
% S >> C:
%   id          u32         活动ID
%   no          u32         活动编号
%   type        u8          0:删除；1:新增


%% ===========================
%% 女妖选美-抽奖活动 相关
%% ===========================

% --------------------
% 获取抽奖面板信息
% 协议号：31100
% C >> S:
% S >> C:
%    next_big_reward_time    u32     下次大奖剩余时间（秒）
%    next_reset_time       u32       下次刷新面板时间（秒）
%    array( 抽奖项信息
%        no          u8          位置（唯一标识）
%        gid         u32         物品ID
%        num         u32         数量
%        quality     u8          物品品质
%        bind        u8          是否绑定（0绑定 1非绑定）
%        get_flag    u8          获取标识（0未获取 1已获取）
%    )
%    array( 幸运玩家列表
%        name        string  玩家名字
%        goodsno     u32     物品id
%        quality     u8      物品品质
%        num         u32     数量
%    )

% --------------------
% 抽奖
% 协议号：31101
% C >> S:
%    cost_type   u8  消耗类型（1道具消耗 2绑金消耗）
% S >> C:
%    code    u8  结果 (0成功 1系统错误 2道具不足 3绑金不足, 4活动未开启 5格子空间不足)
%    no      u8  位置（唯一标识）

% --------------------
% 重置抽奖面板
% 协议号：31102
% C >> S:
% S >> C:
%    code    u8  结果（0成功 1系统错误 2绑金不足 3活动未开启 4CD中）



% --------------------
% 请求竞猜活动题目数据(所有)
% 协议号：31201
% C >> S:

% S >> C:
%	array(
%    		id    			u32  		题目ID
%    		title  			string  	标题
%			content			string		内容
%			time_bet_begin	u32			投注开始时间
%			time_end_begin	u32			投注结束时间
%			time_show_begin	u32			展示开始时间
%			time_end_begin	u32			展示结束时间
%		 array(
%				option		u8			选项
%				data		string		选项内容
%			   )
%		)

% --------------------
% 请求竞猜题目动态数据
% 协议号：31202
% C >> S:
%			id				u32			题目ID	
%			option			u8			选项(为0的时候只是请求动态数据，非0就是确认竞猜选项)		
%			rmb				u32			投入水玉数量
%			cup				u32			投入奖杯数量

% S >> C:
%    		id    			u32  		题目ID
%    		option 			u8			我的猜选 0为未猜选
%			rmb				u32			投入水玉数量
%			cup				u32			投入奖杯数量
%			sum_rmb			u32			水玉奖池数量
%			sum_cup			u32			奖杯奖池数量


% --------------------
% 新增/更新竞猜活动题目数据
% 协议号：31203
% S >> C:
%    		id    			u32  		题目ID
%    		title  			string  	标题
%			content			string		内容
%			time_bet_begin	u32			投注开始时间
%			time_end_begin	u32			投注结束时间
%			time_show_begin	u32			展示开始时间
%			time_end_begin	u32			展示结束时间
%		 	array(
%				option		u8			选项
%				data		string		选项内容
%			   )


% --------------------
% 删除竞猜活动题目数据
% 协议号：31204
% S >> C:
%    		id    			u32  		题目ID