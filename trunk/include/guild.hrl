%%%------------------------------------------------
%%% File    : guild.hrl
%%% Author  : zhangwq
%%% Created : 2013-09-25
%%% Description: 帮派系统的相关宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__GUILD_H__).
-define(__GUILD_H__, 0).

%% 帮派职位（pos： 表示position ）
-define(GUILD_POS_INVALID,          0).        % 无效职位（用于程序做非法判定）
-define(GUILD_POS_CHIEF,            1).        % 大当家
-define(GUILD_POS_COUNSELLOR,       2).        % 军师
-define(GUILD_POS_SHAOZHANG,        3).        % 堂主
-define(GUILD_POS_NORMAL_MEMBER,    4).        % 精英


-define(GUILD_TITLE_NO_CHIEF,            60004).        % 大当家
-define(GUILD_TITLE_NO_COUNSELLOR,       60003).        % 军师
-define(GUILD_TITLE_NO_SHAOZHANG,        60002).        % 堂主
-define(GUILD_TITLE_NO_NORMAL_MEMBER,    60001).        % 精英
-define(GUILD_TITLE_NO_FIRST_CHIEF, 50019).             % 盖世大当家 
-define(GUILD_TITLE_NO_FIRST_GUILD, 50020).             % 天下第一寨

    
-define(GUILD_NAME_MAX_LEN, 12).            % 帮会名字最大长度 帮派名称最多输入6个汉字或12个字符
-define(GUILD_NAME_MIN_LEN, 2).             % 帮会名字最小长度
-define(GUILD_BRIEF_MAX_LEN, 60).           % 帮派简介最多输入30个汉字或60个字符
    
% -define(GUILD_CONTRI_PER_TASK, 5).          % 帮派成员完成任务获得帮贡

-define(GUILD_TASK_MAX_PER_DAY, 5).         % 帮派成员每天完成任务个数

-define(GUILD_LIVENESS_PER_TASK, 1).        % 帮派成员完成任务增加帮派活跃度

-define(GUILD_APPLY_CAPACITY, 50).          % 帮派申请成员上限

-define(GUILD_TENET_MAX_LEN, 30).           % 帮派宗旨最大长度

-define(CREATE_GUILD_NEED_BIND_GAMEMONEY, 100000).        %% 创建1级帮派需要绑银 也可以用银子代替绑银
-define(CREATE_GUILD_NEED_GAMEMONEY, 2000000).            %% 创建2级帮派需要银子 不能用绑银代替

-define(MIN_GUILD_LV, 1).

%  帮派状态 0 --> 正常状态  1-->非活跃状态  2-->冻结状态
-define(GUILD_STATE_NORMAL, 0).
-define(GUILD_STATE_UNACTIVE, 1).
-define(GUILD_STATE_FROZEN, 2).


%% 帮派地图进入点地图和npc编号
-define(GUILD_ENTER_SCENE_NO, 1304).
-define(GUILD_ENTER_NPC_NO, 1041).

%% 搜索帮派的CD时间（毫秒），暂定为500毫秒
-define(SEARCH_GUILD_CD_TIME, 500).


%帮派进程
-define(GUILD_PROCESS, guild_process).

%% 帮派宴会进程
-define(GUILD_PARTY_PROCESS, guild_party_process).

-define(MON_SEED, 10000).

%% 帮派副本编号
-define(GUILD_DUNGEON_NO, 12345612). %弃用

%% 神功丸可一次性增加20点修炼进度
-define(GUILD_CULTIVATE_ADD_USE_GOODS, 20).

-define(GUILD_CULTIVATE_ADD_ONCE, 10).
-define(GUILD_CULTIVATE_GOODS_ADD_ONCE, 20).

-define(GUILD_MAX_CULTIVATE_LV, 30).
%% 神功丸编号
-define(GUILD_CULTIVATE_GOODS_NO, 60101).

%% 帮派副本开放的帮派等级要求
-define(GUILD_DUNGEON_OPEN_LV, 2).

%% 帮派宴会四道菜编号
-define(GUILD_PARTY_DISHES_NO_1, 1).
-define(GUILD_PARTY_DISHES_NO_2, 2).
-define(GUILD_PARTY_DISHES_NO_3, 3).
-define(GUILD_PARTY_DISHES_NO_4, 4).

%% 帮派战开始时的总体力
-define(GUILD_TOTAL_PHYPOWER, 100).

-define(GUILD_WAR_MIN_BID, 500000).

-define(GUILD_QRY_SQL, "id, name, brief, lv, create_time, chief_id, counsellor_list, shaozhang_list, rank, prosper, member_list, request_joining_list, 
    prosper_today, last_add_prosper_time, fund, login_id_list, liveness, donate_rank, total_bid, bid_id_list, join_control,guild_shop").

-define(GUILD_MB_SQL, "id, guild_id, name, lv, vip_lv, sex, race, faction, join_time, contri, battle_power, title_id, left_contri, contri_today, last_add_contri_time, 
    donate_today, donate_total, last_donate_time, pay_today, bid").

-endif.  %% __GUILD_H__