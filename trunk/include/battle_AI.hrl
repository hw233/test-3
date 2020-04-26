%%%------------------------------------------------
%%% File    : battle_AI.hrl
%%% Author  : huangjf
%%% Created : 2014.1.4
%%% Description: 战斗AI的相关宏或结构体定义
%%%------------------------------------------------

% 避免头文件多重包含
-ifndef(__BATTLE_AI_H__).
-define(__BATTLE_AI_H__, 0).





%% 战斗对象的AI
-record(bo_ai, {
		no = 0,       						% ai编号
		priority = 0,						% 优先级
		weight = 0,   						% 权重
		rules_filter_action_target = [], 	% 行为目标的筛选规则列表
		action_content = null,    			% 行为内容
		condition_list = []       			% 条件编号列表
	}).



%% AI条件
-record(ai_cond, {
		no = 0,                      % 条件编号

		% 后缀L表示left（左边）
		rules_filter_bo_L = no_obj,  % 判定等式左边的主体筛选规则列表，格式如： no_obj（表示无主体） | [规则1, 规则2, ...]
		attr_L = no_attr,            % 判定等式左边的主体属性，如果无属性，则为no_attr
		addi_value_L = {"+", 0},     % 判定等式左边的附加值，格式如：{运算符号，具体数值}，其中运算符号格式如："+", "-"

		cmp_symbol = "=",            % 判定符号, 格式如：">", "<", "=", ">=", "<="

		% 后缀R表示right（右边）
		rules_filter_bo_R = no_obj,  % 同上说明，只是这里是换成了判定等式的右边
		attr_R = no_attr,            % 同上说明，只是这里是换成了判定等式的右边
		addi_value_R = {"+", 0}      % 同上说明，只是这里是换成了判定等式的右边
	}).











%% AI的行为内容
-define(AI_CONT_DO_NORMAL_ATT, do_normal_att).    	% 普通攻击
-define(AI_CONT_USE_SKILL, use_skill).    			% 使用技能
-define(AI_CONT_SUMMON_MON, summon_mon).    		% 召唤怪物
-define(AI_CONT_SUMMON_PARTNER, summon_partner).    % 召唤宠物
-define(AI_CONT_PROTECT_OTHERS, protect_others).   	% 保护
-define(AI_CONT_ESCAPE, escape).   					% 逃跑
-define(AI_CONT_DEFEND, defend).   					% 防御
-define(AI_CONT_TALK, talk).   					    % 对话气泡








-endif.  % __BATTLE_AI_H__
