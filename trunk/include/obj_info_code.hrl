%%%------------------------------------------------
%%% File    : obj_info_code.hrl
%%% Author  : huangjf
%%% Created : 2013.7.17
%%% Description: 对象（如玩家、宠物、物品）相关信息对应的数字代号（仅用于和客户端通信，发送协议的时候会用到）
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__OBJ_INFO_CODE_H__).
-define(__OBJ_INFO_CODE_H__, 0).


%% ！！！注意：目前代号是以u8传给客户端的，故代号值不要超过255！！！！


%% OI: object info

%%% 属性
-define(OI_CODE_HP, 1).                  % 生命
-define(OI_CODE_HP_LIM, 2).              % 生命上限
-define(OI_CODE_MP, 3).                  % 法力
-define(OI_CODE_MP_LIM, 4).              % 法力上限

-define(OI_CODE_PHY_ATT, 5).             % 物理攻击
-define(OI_CODE_MAG_ATT, 6).             % 法术攻击
-define(OI_CODE_PHY_DEF, 7).             % 物理防御
-define(OI_CODE_MAG_DEF, 8).             % 法术防御

-define(OI_CODE_HIT, 9).                 % 命中
-define(OI_CODE_DODGE, 10).              % 闪避
-define(OI_CODE_CRIT, 11).               % 暴击
-define(OI_CODE_TEN, 12).                % 坚韧

-define(OI_CODE_TALENT_STR, 13).         % 力量（strength）
-define(OI_CODE_TALENT_CON, 14).         % 体质（constitution）
-define(OI_CODE_TALENT_STA, 15).         % 耐力（stamina）
-define(OI_CODE_TALENT_SPI, 16).         % 灵力（spirit）
-define(OI_CODE_TALENT_AGI, 17).         % 敏捷（agility）

-define(OI_CODE_ANGER, 18).              % 怒气
-define(OI_CODE_ANGER_LIM, 19).          % 怒气上限
-define(OI_CODE_ACT_SPEED, 20).          % 出手速度
-define(OI_CODE_LUCK, 21).               % 幸运

-define(OI_CODE_FROZEN_RESIS, 22).       % 冰封抗性
-define(OI_CODE_FROZEN_RESIS_LIM, 23).   % 冰封抗性上限

-define(OI_CODE_TRANCE_RESIS, 24).       % 昏睡抗性
-define(OI_CODE_TRANCE_RESIS_LIM, 25).   % 昏睡抗性上限

-define(OI_CODE_RESIS_CHAOS, 26).        % 混乱抗性
-define(OI_CODE_RESIS_CHAOS_LIM, 27).    % 混乱抗性上限

-define(OI_CODE_FROZEN_HIT, 28).         % 冰封命中
-define(OI_CODE_FROZEN_HIT_LIM, 29).     % 冰封命中上限

-define(OI_CODE_TRANCE_HIT, 30).         % 昏睡命中
-define(OI_CODE_TRANCE_HIT_LIM, 31).     % 昏睡命中上限

-define(OI_CODE_CHAOS_HIT, 32).          % 混乱命中
-define(OI_CODE_CHAOS_HIT_LIM, 33).      % 混乱命中上限

-define(OI_CODE_SEAL_HIT, 34).          % 封印命中
-define(OI_CODE_SEAL_RESIS, 35).        % 封印抗性

-define(OI_CODE_PHY_COMBO_ATT_PROBA, 36).   % 物理连击概率（传给客户端的是一个放大了1000倍的整数，因为概率基数为1000）
-define(OI_CODE_MAG_COMBO_ATT_PROBA, 37).   % 法术连击概率（传给客户端的是一个放大了1000倍的整数，因为概率基数为1000）
-define(OI_CODE_STRIKEBACK_PROBA, 38).  % 反击概率（传给客户端的是一个放大了1000倍的整数，因为概率基数为1000）
-define(OI_CODE_PURSUE_ATT_PROBA, 39).  % 追击概率（传给客户端的是一个放大了1000倍的整数，因为概率基数为1000）

%% 物品相关
-define(OI_CODE_LEFT_VALID_TIME, 40).    % 剩余有效时间，单位：秒
-define(OI_CODE_STREN_LV, 41).           % 强化等级
-define(OI_CODE_STREN_EXP, 42).          % 当前强化经验
-define(OI_CODE_DIG_SCENO_NO, 43).       % 挖宝场景编号
-define(OI_CODE_DIG_SCENO_X, 44).        % 挖宝场景X坐标
-define(OI_CODE_DIG_SCENO_Y, 45).        % 挖宝场景Y坐标
-define(OI_CODE_QUALITY_LV, 46).         % 品质等级,例如物品品质等级：如：绿+1
-define(OI_CODE_MK_SKILL, 47).           % 法宝技能
-define(OI_CODE_NEGLECT_RET_DAM,48).     % 忽视反震概率


%% 其他
-define(OI_CODE_EXP, 60).                		% 当前经验
-define(OI_FREE_TALENT_POINTS, 61).      		% 自由天赋点数（未分配的天赋点数）
-define(OI_CODE_BATTLE_POWER, 62).       		% 玩家or宠物or装备当前战斗力
-define(OI_CODE_DO_PHY_DAM_SCALING, 63). 		% 物理伤害放缩系数（传给客户端的是一个放大了100倍的整数）
-define(OI_CODE_DO_MAG_DAM_SCALING, 64). 		% 法术伤害放缩系数（传给客户端的是一个放大了100倍的整数）
-define(OI_CODE_CRIT_COEF, 65).          		% 暴击系数（传给客户端的是一个放大了100倍的整数）
-define(OI_CODE_RET_DAM_PROBA, 66).      		% 反震（即反弹）概率（传给客户端的是一个放大了1000倍的整数，因为概率基数为1000）
-define(OI_CODE_RET_DAM_COEF, 67).       		% 反震（即反弹）系数（传给客户端的是一个放大了100倍的整数）
-define(OI_CODE_BE_HEAL_EFF_COEF, 68).   		% 被治疗效果系数（传给客户端的是一个放大了100倍的整数）
-define(OI_CODE_BE_PHY_DAM_REDUCE_COEF, 69).   	% 物理伤害减免系数（传给客户端的是一个放大了100倍的整数）
-define(OI_CODE_BE_MAG_DAM_REDUCE_COEF, 70).   	% 法术伤害减免系数（传给客户端的是一个放大了100倍的整数）
-define(OI_CODE_ABSORB_HP_COEF, 71).   			% 吸血系数（传给客户端的是一个放大了100倍的整数）

-define(OI_CODE_STORE_HP, 72).                  % 生命库
-define(OI_CODE_STORE_MP, 73).                  % 法力库
-define(OI_CODE_STORE_PAR_HP, 74).              % 玩家宠物专用气血库
-define(OI_CODE_STORE_PAR_MP, 75).              % 玩家宠物专用魔法库
-define(OI_CODE_GUILD_CONTRI, 76).              % 玩家对帮派剩余贡献度

-define(OI_CODE_QUGUI_COEF, 77).   				% 驱鬼系数（传给客户端的是一个放大了100倍的整数）
-define(OI_CODE_BE_PHY_DAM_SHRINK, 78).   		% （受）物理伤害缩小值
-define(OI_CODE_BE_MAG_DAM_SHRINK, 79).   		% （受）法术伤害缩小值
-define(OI_CODE_HP_LIM_RATE, 80).				% 生命上限 比例
-define(OI_CODE_PURSUE_ATT_DAM_COEF, 81).   	% 追击伤害系数（传给客户端的是一个放大了100倍的整数）

-define(OI_CODE_GUILD_CHIEF_ID, 82).            % 所在帮派的帮主id
-define(OI_CODE_FREE_STREN_CNT, 83).            % 今天剩余免费强化装备次数

-define(OI_CODE_MP_LIM_RATE, 84).               
-define(OI_CODE_PHY_ATT_RATE, 85).
-define(OI_CODE_MAG_ATT_RATE, 86).
-define(OI_CODE_PHY_DEF_RATE, 87).
-define(OI_CODE_MAG_DEF_RATE, 88).
-define(OI_CODE_HIT_RATE, 89).
-define(OI_CODE_DODGE_RATE, 90).
-define(OI_CODE_CRIT_RATE, 91).
-define(OI_CODE_TEN_RATE, 92).
-define(OI_CODE_ACT_SPEED_RATE, 93).
-define(OI_CODE_SEAL_HIT_RATE, 94).
-define(OI_CODE_SEAL_RESIS_RATE, 95).

-define(OI_CODE_ART_EXP, 96).                    % 内功当前的经验
-define(OI_CODE_ART_LV, 97).                     % 内功当前等级
-define(OI_CODE_ART_ATTR, 98).                   % 内功当前加成属性

-define(OI_CODE_DAN, 99).                        % 段位

%% 宠物战斗外属性相关（100到144）注意：跟人物一样的属性用人物的代号
-define(OI_CODE_PAR_LV, 100).
-define(OI_CODE_PAR_LOYALTY, 101).              % 忠诚度
-define(OI_CODE_PAR_INTIMACY, 103).             % 女妖亲密度
-define(OI_CODE_PAR_INTIMACY_LV, 104).          % 女妖亲密度等级
-define(OI_CODE_PAR_CULTIVATE, 105).            % 女妖修炼值
-define(OI_CODE_PAR_CULTIVATE_LV, 106).         % 女妖修炼等级
-define(OI_CODE_PAR_LIFE, 107).                 % 女妖寿命
-define(OI_CODE_PAR_POSTNATAL_SKILL_SLOT, 108). % 女妖后天已经开启的技能格数 (已经没用)
-define(OI_CODE_PAR_ADD_SKILL, 109).            % 女妖增加技能
-define(OI_CODE_PAR_DEL_SKILL, 110).            % 女妖删除技能
-define(OI_CODE_PAR_MOOD_NO, 111).              % 女妖心情编号
-define(OI_CODE_PAR_STATE, 112).                % 宠物状态
-define(OI_CODE_PAR_CLOTHES, 113).              % 宠物画皮
-define(OI_CODE_PAR_EVOLVE, 114).            	% 女妖进化值
-define(OI_CODE_PAR_EVOLVE_LV, 115).         	% 女妖进化等级
-define(OI_CODE_PAR_FOLLOW, 116).               % 宠物跟随状态
-define(OI_CODE_PAR_FIVE_ELEMENT, 117).        %五行
-define(OI_CODE_PAR_FIVE_ELEMENT_LV, 118).     %五行等级

%% 场景同步AOI信息（141到166）
-define(OI_CODE_BATTLE_FABAO, 141).      % 法宝佩戴的编号
-define(OI_CODE_FABAO_NO, 142).          % 法宝展示的编号
-define(OI_CODE_PEAK_LV, 143).           % 玩家巅峰等级
-define(OI_CODE_WING_SHOW, 144).         % 翅膀
-define(OI_CODE_FIRE_WORKS, 145).        % 烟花
-define(OI_CODE_MOUNT_NO, 146).          % 玩家坐骑编号
-define(OI_CODE_MOUNT_STEP, 147).        % 玩家坐骑阶数
-define(OI_CODE_MAGIC_KEY, 150).         % 玩家法宝编号
-define(OI_CODE_BACKWEAR, 151).          % 玩家背饰编号
-define(OI_CODE_WEAPON, 152).            % 玩家武器编号
-define(OI_CODE_GUILDNAME, 153).         % 帮派名
-define(OI_CODE_NICKNAME, 154).          % 角色名
-define(OI_CODE_HEADWEAR, 155).          % 玩家头饰编号
-define(OI_CODE_CLOTHES, 156).           % 玩家服饰编号
-define(OI_CODE_BHV_STATE, 157).         % 玩家行为状态
-define(OI_CODE_VIP_LV, 158).            % 玩家VIP等级
-define(OI_CODE_LEADER_FLAG, 159).       % 玩家的队长标记 1 是队长 0是非队长
-define(OI_CODE_TEAM_ID, 160).           % 玩家的队伍id 为0表示没有队伍
-define(OI_CODE_TEXT_TITLE, 161).        % 文字称号
-define(OI_CODE_GRAPH_TITLE, 162).       % 图片称号
-define(OI_CODE_UEER_DEF_TITLE, 163).    % 自定义称号(字符串)
-define(OI_CODE_LV, 164).            	 % 玩家等级
-define(OI_CODE_PRIV_LV, 165).           % 玩家的权限级别（权限级别详见priv.hrl）
-define(OI_CODE_SPOUSE_NAME, 166).       % 配偶名字

%%------------------------------------------------------
-define(OI_CODE_CONTRI, 167).            % 玩家成就战绩值
-define(OI_CODE_MOUNT, 168).             % 玩家坐骑值


%%-------------物品商会信息
-define(OI_BUY_PRICE, 169).            % 买入价格
-define(OI_BUY_PRICE_TYPE, 170).       % 买入价格类型

-define(OI_EQUIP_EFFECT, 171).           % 装备特效编号
-define(OI_EQUIP_MAKER, 172).            % 装备制作者

%%----新增战斗属性
-define(OI_CODE_PHY_CRIT,200).       		%物理暴击
-define(OI_CODE_PHY_TEN,201).       		%物理坚韧
-define(OI_CODE_MAG_CRIT,202).       		%法术暴击
-define(OI_CODE_MAG_TEN,203).       		%法术坚韧
-define(OI_CODE_PHY_CRIT_COEF,204).       	%物理暴击程度
-define(OI_CODE_MAG_CRIT_COEF,205).       	%法术暴击程度
-define(OI_CODE_HEAL_VALUE,206).       	    %治疗强度

-define(OI_CODE_POPULAR,207).       	    %玩家人气值
-define(OI_CODE_CHIP,208).       	    	% 玩家筹码

-define(OI_CODE_KILL_NUM,209).       	    % 杀人数
-define(OI_CODE_BE_KILL_NUM,210).       	% 被杀人数

-define(OI_CODE_FREE_POINT,211).       		% 属性点

-define(OI_GOODS_LAST_SELL_TIME, 212).      % 物品最后贩卖日期
-define(OI_CODE_FIRST_USE_TIME, 213).    	% 第一次使用时间


% 新增战斗属性
-define(OI_BE_CHAOS_ATT_TEAM_PAOBA,301).
-define(OI_BE_CHAOS_ATT_TEAM_PHY_DAM,302).
-define(OI_NEGLECT_SEAL_RESIS,303).
-define(OI_SEAL_HIT_TO_PARTNER,304).
-define(OI_SEAL_HIT_TO_MON,305).
-define(OI_PHY_DAM_TO_PARTNER,306).
-define(OI_PHY_DAM_TO_MON,307).
-define(OI_MAG_DAM_TO_PARTNER,308).
-define(OI_MAG_DAM_TO_MON,309).
-define(OI_BE_CHAOS_ROUND_REPAIR,310).
-define(OI_CHAOS_ROUND_REPAIR,311).
-define(OI_BE_FROZE_ROUND_REPAIR,312).
-define(OI_FROZE_ROUND_REPAIR,313).
-define(OI_NEGLECT_PHY_DEF,314).
-define(OI_NEGLECT_MAG_DEF,315).
-define(OI_PHY_DAM_TO_SPEED_1,316).
-define(OI_PHY_DAM_TO_SPEED_2,317).
-define(OI_MAG_DAM_TO_SPEED_1,318).
-define(OI_MAG_DAM_TO_SPEED_2,319).
-define(OI_SEAL_HIT_TO_SPEED,320).
-define(OI_REVIVE_HEAL_COEF,321).

-define(OI_TRANSFIGURATION_NO,322).

-define(OI_CODE_PAODIAN_TYPE, 324).          % 玩家坐骑编号
-define(OI_CODE_MOUNT_SKIN, 325).          % 玩家坐骑皮肤

-define(OI_DISPLAY_GRAPE_TITLE, 331).
-define(OI_DISPLAY_TEXT_TITLE, 332).

-define(OI_CODE_EQUIP_FASHION, 333).

-endif.  %% __OBJ_INFO_CODE_H__
