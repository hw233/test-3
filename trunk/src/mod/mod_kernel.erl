%%%------------------------------------
%%% @Module  : mod_kernel
%%% @Author  :
%%% @Email   :
%%% @Created : 2011.06.30
%%% @Description: 核心服务
%%%------------------------------------
-module(mod_kernel).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start_link/0,
        scene_and_online_state/0
        ]).

-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("ban.hrl").
-include("inventory.hrl").
-include("player.hrl").
-include("scene.hrl").
-include("monster.hrl").
-include("npc.hrl").
-include("record/battle_record.hrl").
-include("record/goods_record.hrl").
-include("record/guild_record.hrl").
-include("partner.hrl").
-include("buff.hrl").
-include("trade.hrl").
-include("xinfa.hrl").
-include("dungeon.hrl").
-include("tower.hrl").
-include("tower_ghost.hrl").
-include("mail.hrl").
-include("faction.hrl").
-include("hire.hrl").
-include("offline_data.hrl").
-include("offline_arena.hrl").
-include("broadcast.hrl").
-include("sys_set.hrl").
-include("reward.hrl").
-include("relation.hrl").
-include("rank.hrl").
-include("chapter_target.hrl").
-include("activity.hrl").
-include("admin_activity.hrl").
-include("team.hrl").
-include("tve.hrl").
-include("db.hrl").
-include("title.hrl").
-include("account.hrl").
-include("sprd.hrl").
-include("transport.hrl").
-include("reward.hrl").
-include("melee.hrl").
-include("newyear_banquet.hrl").
-include("mount.hrl").
-include("business.hrl").
-include("home.hrl").
-include("train.hrl").
-include("road.hrl").
-include("guild_dungeon.hrl").
-include("ernie.hrl").
-include("luck_info.hrl").
-include("chibang.hrl").
-include("damijing.hrl").
-include("optional_turntable.hrl").
-include("fabao.hrl").
-include("equip.hrl").

-include("limitedtask.hrl").
-include("diy.hrl").

-include("pvp.hrl").

start_link() ->
    gen_server:start_link({local,?MODULE}, ?MODULE, [], []).

% %% 创建新的场景分线位置同步ets
% create_new_scene_line_pos_ets({LineId, Scene, PlayerId, X, Y}) ->
% 	gen_server:call(?MODULE, {'NEW_SCENE_LINE_POS_ETS', LineId, Scene, PlayerId, X, Y}).


%% 本节点在线状况
scene_and_online_state() ->
    case lib_player:get_online_num() of
        undefined ->
            [0,0];
        Num when Num < 200 -> %顺畅
            [1, Num];
        Num when Num > 200 , Num < 500 -> %正常
            [2, Num];
        Num when Num > 500 , Num < 800 -> %繁忙
            [3, Num];
        Num when Num > 800 -> %爆满
            [4, Num]
    end.

init([]) ->
    ok = init_ets(),                  % 初始ets表
    db_load_banned_info(),            % 从数据库加载封禁信息
    {ok, null}.


handle_cast(_R , Status) ->
    {noreply, Status}.

% handle_call({'NEW_SCENE_LINE_POS_ETS' , LineId, Scene, PlayerId, X, Y}, _FROM, Status) ->
%     Tab = list_to_atom([LineId]),
% 	ets:new(Tab, [named_table, public, ordered_set]),
% 	ets:insert(Tab, {{Scene, PlayerId}, X, Y}),
%     {reply, ok, Status};

% handle_call('NEW_WORLD_BOSS_ETS', _FROM, Status) ->
% 	ets:new(?ETS_WORLD_BOSS_HP, [named_table, public, set]),
%     {reply, ok, Status};

handle_call(_R , _FROM, Status) ->
    {reply, ok, Status}.

handle_info(_Reason, Status) ->
    {noreply, Status}.

terminate(normal, Status) ->
    {ok, Status}.

code_change(_OldVsn, Status, _Extra)->
    {ok, Status}.

%% ================== 私有函数 =================

%%初始ETS表
init_ets() ->
	% ets:new(?ETS_STAT_SOCKET, [named_table, public, set]),    % 输出socket统计
	% ets:new(?ETS_STAT_COMPRESS, [named_table, public, set]),  % socket压缩统计
	ets:new(?ETS_STAT_DB, [{keypos, #db_op_stat.key}, named_table, public, set]),  % 数据库操作统计

    ets:new(?ETS_SERVER_MISC, [named_table, public, set]),   % 服务器杂项信息

    ets:new(?ETS_MAP_OF_ACCNAME_TO_ONLINE_PLAYER, [named_table, public, set]),

    ets:new(?ETS_DISCARD_ROLE_TIMES, [{keypos,#discard_role_times.accname}, named_table, public, set]),

    ets:new(?ETS_INVENTORY, [{keypos,#inv.player_id}, named_table, public, set]), % 玩家的物品栏ets表
    ets:new(?ETS_BUY_BACK, [{keypos,#buy_back.player_id}, named_table, public, set]), % 玩家的回购物品栏ets表
    create_ets_inv_goods(), % 创建N个ets，用于存玩家物品(goods结构体)

	create_ets_onilne(),  % 存储在线玩家数据的ets表
    ets:new(?ETS_TMPLOGOUT_PLAYER_STATUS, [{keypos, #player_status.id}, named_table, public, set]),  % 存储临时退出的玩家数据的ets表

    ets:new(?ETS_ONLINE_PLAYER_BRIEF, [{keypos, #plyr_brief.id}, named_table, public, set, {read_concurrency, true}]),  % 在线玩家的简要信息表
    ets:new(?ETS_TMPLOGOUT_PLAYER_BRIEF, [{keypos, #plyr_brief.id}, named_table, public, set, {read_concurrency, true}]),  % 临时退出的玩家的简要信息表


    ets:new(?ETS_PLAYER_XINFA, [{keypos,#ply_xinfa.player_id}, named_table, public, set]), % 玩家的心法信息表

    create_ets_player_position(),  % 玩家的具体位置ets表

	%%%%ets:new(?ETS_MAP_ROLE, [named_table, public, set]), %%地图玩家信息， 存放的是：{PlayerId, SendPid}， 已废弃！！
    ets:new(?ETS_MON, [{keypos,#mon.id}, named_table, public, set]),  % 明雷怪对象表

    ets:new(?ETS_SCENE, [{keypos, #scene.id}, named_table, public, set]), % 场景对象表
    ets:new(?ETS_SCENE_PLAYERS, [{keypos,#scene_players.scene_id}, named_table, public, set]), % 记录场景内的玩家id列表
    ets:new(?ETS_OBJS_OF_SCENE, [{keypos,#objs_of_scene.scene_id}, named_table, public, set]), % 记录场景内的对象（怪物，npc，动态传送点）列表

    ets:new(?ETS_MAP_OF_SCENE_TO_RESERVE_SCENE, [named_table, public, set]),

    ets:new(?ETS_STATIC_NPC, [{keypos, #npc.id}, named_table, public, set]),
    ets:new(?ETS_DYNAMIC_NPC, [{keypos, #npc.id}, named_table, public, set]),

    ets:new(?ETS_MON_POSITION, [{keypos,#mon_pos.key}, named_table, public, set]),

    ets:new(?ETS_RELA, [{keypos, #relation.id}, named_table, public, set]), %%玩家关系记录
    ets:new(?ETS_RELA_INFO, [{keypos,#relation_info.id}, named_table, public, set]), %%好友关系相关的信息
    % ets:new(?ETS_RELA_SET, [{keypos,#ets_rela_set.id}, named_table, public, set]), %%玩家好友分组记录

    ets:new(?ETS_PARTNER, [{keypos, #partner.id}, named_table, public, set]),   		% 玩家携带中的武将

    % ets:new(?ETS_PARTNER_HOTEL, [{keypos,#partner.id}, named_table, public, set]),   		%% 玩家寻妖系统放在青楼中的女妖
    ets:new(?ETS_FIND_PAR, [{keypos,#find_par.player_id}, named_table, public, set]),       %% 玩家寻妖信息
    % ets:new(?ETS_PARTNER_CG, [{keypos,#ets_partner.player_id}, named_table, public, bag]),   	% 剧情战斗CG的临时武将（bag类型）
    % ets:new(?ETS_PLAYER_TROOP, [{keypos,#ets_player_troop.id}, named_table, public, set]), % 玩家的阵法信息

    ets:new(?ETS_TEAM, [{keypos, #team.team_id}, named_table, public, set]),          	% 玩家创建的队伍

    ets:new(?ETS_BATTLE_CREATE_LOG, [{keypos, #btl_create_log.battle_id}, named_table, public, set]),            % 战斗创建记录表

    % ets:new(?ETS_ACTIVITY, [{keypos,#ets_activity.player_id}, named_table, public, set]),        %%活动系统

    %% 商城
    % ets:new(?ETS_SHOP, [{keypos, #ets_shop.id}, named_table, public, set]),

    ets:new(?ETS_OFFLINE_BO, [{keypos, #offline_bo.key}, named_table, set, public]),
    ets:new(?ETS_OFFLINE_ROLE_BRIEF, [{keypos, #offline_role_brief.id}, named_table, set, public]),

    ets:new(?ETS_PLAYER_OPENED_SYS, [named_table, set, public]),

    ets:new(?ETS_ROLE_OFFLINE_ARENA, [{keypos, #offline_arena.id}, named_table, set, public]),
    ets:new(?ETS_OFFLINE_ARENA_TEMP_RANKING, [{keypos, #temp_ranking.id}, named_table, set, public]),

	% ets:new(?ETS_CURRENTLY_CONTACT,[{keypos,#ets_currently_contact.id},named_table,public,set]),    %%最近联系人记录表
	% ets:new(?ETS_CURRENTLY_TEAMMATE, [{keypos,#ets_currently_teammate.id},named_table,public,set]),    %%最近队友记录表


    ets:new(?ETS_GUILD, [{keypos, #guild.id}, named_table, public, set]), %% 帮派信息
    ets:new(?ETS_GUILD_MEMBER, [{keypos, #guild_mb.id}, named_table, public, set]), %% 帮派成员信息
    ets:new(?ETS_MAP_OF_GUILD_ID_TO_GUILD_NAME, [named_table, public, set]), %% 帮派id到帮派名的映射
    ets:new(?ETS_GUILD_DUNGEON, [{keypos, #guild_dungeon.guild_id}, named_table, public, set]), %% 帮派副本信息
    ets:new(?ETS_GUILD_PARTY, [{keypos, #guild_party.guild_id}, named_table, public, set]), %% 帮派宴会信息
    ets:new(?ETS_GUILD_WAR, [{keypos, #guild_war.guild_id}, named_table, public, set]), %% 帮派争夺战相关信息

	ets:new(?ETS_BUFF, [{keypos, #obj_buff.key}, named_table, public, set]), %% 玩家or宠物z战斗外的buff

    ets:new(?ETS_ROLE_DUNGEON, [{keypos, #role_dungeon.id}, named_table, public, set]),
    ets:new(?ETS_DUNGEON_CD, [{keypos, #dungeon_cd.id}, named_table, public, set]),

    ets:new(?ETS_TOWER, [{keypos, #tower.id}, named_table, public, set]),
	ets:new(?ETS_TOWER_GHOST, [{keypos, #tower_ghost.player_id}, named_table, public, set]),
	
    ets:new(?ETS_FACTION_PLAYER_LIST, [{keypos, #faction_players.faction}, named_table, public, set]),

    ets:new(?ETS_ROLE_NAME, [named_table, public, set]),
    ets:new(?ETS_MAIL_BRIEF, [{keypos, #mail_brief.id}, named_table, public, set]),

    ets:new(?ETS_DYNAMIC_SHOP_GOODS, [{keypos, #shop_goods.goods_no}, named_table, public, set]),
    ets:new(?ETS_OP_SHOP_GOODS, [{keypos, #shop_goods.goods_no}, named_table, public, set]),
    ets:new(?ETS_PLAYER_MISC, [{keypos, #player_misc.player_id}, named_table, public, set]),

    ets:new(?ETS_HIRE, [{keypos, #hire.id}, named_table, public, set]),
    ets:new(?ETS_HIRER, [{keypos, #hirer.id}, named_table, public, set]),

    ets:new(?ETS_BROADCAST, [{keypos, #broadcast.id}, named_table, public, set]),
    ets:new(?ETS_SYS_SET, [{keypos, #sys_set.player_id}, named_table, public, set]),

    ets:new(?ETS_DAY_REWARD, [{keypos, #day_reward.player_id}, named_table, public, set]),

    ets:new(?ETS_BANNED_IP, [{keypos, #banned_ip.ip}, named_table, public, set]),

    ets:new(?ETS_BANNED_ROLE, [{keypos, #banned_role.role_id}, named_table, public, set]),

    %% ------ task -------
    ets:new(?ETS_TASK_TMP_ACCEPTED, [{keypos, 1}, named_table, public, set]),
    ets:new(?ETS_TASK_TMP_ACCEPTED_LIST, [{keypos, 1}, named_table, public, set]),
    ets:new(?ETS_TASK_TMP_COMPLETED, [{keypos, 1}, named_table, public, set]),
    ets:new(?ETS_TASK_TMP_COMPLETED_LIST, [{keypos, 1}, named_table, public, set]),
    ets:new(?ETS_TASK_TMP_RING, [{keypos, 1}, named_table, public, set]),
    ets:new(?ETS_TASK_TMP_RING_LIST, [{keypos, 1}, named_table, public, set]),
    ets:new(?ETS_TASK_TMP_COMPLETED_UNREPEAT, [{keypos, 1}, named_table, public, set]),
    % ets:new(?ETS_TASK_TMP_AUTO_TRIGGER, [{keypos, 1}, named_table, public, set]),

    %% -------------------
    ets:new(?ETS_ACTIVITY_DEGREE_TMP_CACHE, [{keypos, 1}, named_table, public, set]),

    ets:new(?ETS_JINGYAN_TMP_CACHE, [{keypos, 1}, named_table, public, set]),

    ets:new(?ETS_WORLD_CHAT_CD_TMP, [{keypos, 1}, named_table, public, set]),

    ets:new(?ETS_BANNED_CHAT_TMP, [{keypos, 1}, named_table, public, set]),

    ets:new(?ETS_RANKING_STAMP, [{keypos, #ranking_stamp.id}, named_table, public, set]),

    ets:new(?ETS_ACHIEVEMENT_TMP_CACHE, [{keypos, 1}, named_table, public, set]),

    ets:new(?ETS_CHAPTER_TARGET, [{keypos, #chapter_target.id}, named_table, public, set]),

    ets:new(?ETS_ANSWER, [{keypos, #answer.role_id}, named_table, public, set]),

    ets:new(?ETS_ACTIVITY_DATA, [{keypos, 1}, named_table, public, set]),

    ets:new(?ETS_LOCALID_PLAYERID_MAP, [{keypos, 1}, named_table, public, set]),

    ets:new(?ETS_TVE, [{keypos, #tve.lv_step}, named_table, public, set]),

    ets:new(?ETS_DUNGEON_PLOT, [{keypos, 1}, named_table, public, set]),

    ets:new(?ETS_ADMIN_ACTIVITY, [{keypos, #admin_activity.order_id}, named_table, public, set]),

    ets:new(?ETS_ROLE_ADMIN_ACTIVITY, [{keypos, #role_admin_activity.role_id}, named_table, public, set]),

    ets:new(?ETS_ADMIN_SYS_ACTIVITY, [{keypos, #admin_sys_activity.order_id}, named_table, public, set]),

    ets:new(?ETS_ADMIN_SYS_ACTIVITY_BRIEF, [{keypos, #admin_sys_activity_brief.order_id}, named_table, public, set]),

    ets:new(?ETS_RECHARGE_ACCUM, [{keypos, #recharge_accum.id}, named_table, public, set]),

    ets:new(?ETS_RECHARGE_ONE, [{keypos, #recharge_one.id}, named_table, public, set]),

    ets:new(?ETS_CONSUME_ACTIVITY, [{keypos, #consume_activity.no}, named_table, public, set]),

    ets:new(?ETS_ADMIN_ACTIVITY_QUERY, [{keypos, #admin_activity_query.id}, named_table, public, set]),

    ets:new(?ETS_TITLE, [{keypos, #titles.uid}, named_table, public, set]),

    ets:new(?ETS_DIY_TITLE, [{keypos, #diy_title.uid}, named_table, public, set]),


    ets:new(?ETS_SWORN, [{keypos, #sworn.id}, named_table, public, set]),

    ets:new(?ETS_PLAYER_SPRD, [{keypos, #sprd.player_id}, named_table, public, set]),

    ets:new(?ETS_RANKING_EXCEPT_STATE, [{keypos, 1}, named_table, public, set]),

    ets:new(?ETS_TRUCK_INFO, [{keypos, #truck.role_id}, named_table, public, set]),

    ets:new(?ETS_ROLE_TRANSPORT, [{keypos, #role_transport.role_id}, named_table, public, set]),

    ets:new(?ETS_TRUCK_ID_SET, [named_table, public, set]),

    ets:new(?ETS_ADMIN_FESTIVAL_ACTIVITY, [{keypos, #admin_festival_activity.order_id}, named_table, public, set]),

    ets:new(?ETS_ADMIN_SYS_SET, [{keypos, #admin_sys_set.no}, named_table, public, set]),

    ets:new(?ETS_REWARD_POOL, [{keypos, #reward_pool.no}, named_table, public, set]),

    ets:new(?ETS_MELEE_STATUS, [{keypos, #ets_melee_status.id}, named_table, public, set]),         % 女妖乱斗活动状态信息
    ets:new(?ETS_MELEE_PLY_INFO, [{keypos, #ets_melee_ply_info.id}, named_table, public, set]),     % 女妖乱斗玩家信息表

    ets:new(?ETS_GLOBAL_SYS_VAR, [{keypos, #global_sys_var.sys}, named_table, public, set]),        % 全局系统变量

	ets:new(?ETS_TIME_LIMIT_RANK, [{keypos, #ets_time_limit_rank.id}, named_table, public, set]),   %限时转盘排行榜

    ets:new(?ETS_SECURITY_IP, [{keypos, 1}, named_table, public, set]),         % 白名单IP

    ets:new(?ETS_NEWYEAR_BANQUET, [{keypos, 1}, named_table, public, set]),     % 新年宴会

    ets:new(?ETS_NEWYEAR_BANQUET_SCENE_STATUS, [{keypos, #ets_newyear_banquet_scene_status.id}, named_table, public, set]), %新年宴会场景

    %噩梦爬塔
    ets:new(?ETS_HARD_TOWER, [{keypos, #hardtower.id}, named_table, public, set]),

    % 幸运转盘玩家缓存
    ets:new(?ETS_ERNIE_TMP_CACHE, [{keypos, 1}, named_table, public, set]),

    % 单笔消费充值
    ets:new(?ETS_RECHARGE_ACCUM_DAY, [{keypos, #recharge_accum_day.id}, named_table, public, set]),

    ets:new(?ETS_MOUNT, [{keypos, #ets_mount.id}, named_table, public, set]),   %%坐骑
    ets:new(?ETS_MOUNT_SKIN, [{keypos, #mount_skin_info.uid}, named_table, public, set]),   %%坐骑皮肤

    ets:new(?ETS_EQUIP_FASHION, [{keypos, #equip_fashion_info.uid}, named_table, public, set]),


    % 家园数据
	ets:new(?ETS_HOME_SCENE, [{keypos, 1}, named_table, public, set]),   %% 家园场景

    %家园记录ID，用于偷菜
    ets:new(?ETS_HOME_ID, [{keypos, #home_id.player_id}, named_table, public, set]),


	% 竞猜活动
    ets:new(?ETS_GUESS_QUESTION, [{keypos, #guess_question.id}, named_table, public, set]),


    % 练功

    ets:new(?ETS_ROLE_ARTS, [{keypos, #role_arts.id}, named_table, public, set]),

	% 取经之路
    ets:new(?ETS_ROAD_INFO, [{keypos, #road_info.player_id}, named_table, public, set]),

	% 帮派副本场景据
	ets:new(?ETS_GUILD_DUNGEON_SCENE, [{keypos, 1}, named_table, public, set]),  %% 帮派副场景{scene_id,guild_id}

	%帮派副本关卡信息
    ets:new(?ETS_GUILD_POINT_INFO, [{keypos, #guild_dungeon_point.guild_week}, named_table, public, set]),

    %帮派副本玩家信息
    ets:new(?ETS_GUILD_PERSON_INFO, [{keypos, #guild_person.player_id}, named_table, public, set]),


    % 限时抽奖玩家抽奖记录
    ets:new(?ETS_PLAYER_LOTTERY_INFO, [{keypos, #player_lottery_info.player_id}, named_table, public, set]),

	% 玩家现金券
    ets:new(?ETS_PLAYER_VOUCHERS_INFO, [{keypos, #player_vouchers_info.player_id}, named_table, public, set]),

    %章节成就奖励充值记录
    ets:new(ets_player_chapter_recharge, [{keypos, 1}, named_table, public, set]),% {player_id,no}

    %许愿池总分
    ets:new(ets_desire_integral_pool, [{keypos, 1}, named_table, public, set]), % {desire_integral,count}
	%许愿及寻宝的玩家数据
    ets:new(ets_luck_player_info, [{keypos, #luck_player_info.player_id}, named_table, public, set]),
	%最新的十五条幸运儿的播报记录
    ets:new(ets_lottery_record , [{keypos, #ets_lottery_history.type}, named_table, public, set]),
	%打开了寻宝及许愿的所有玩家
    ets:new(ets_open_interface, [{keypos, 1}, named_table, public, set]), % {1, [player]}
    %玩家进入拋骰子地图记录
    ets:new(ets_rich_map_record, [{keypos, #rich_map_record.player_id}, named_table, public, set]),
    %正在玩大富翁的玩家组
    ets:new(ets_rich_player, [{keypos, 1}, named_table, public, set]), % {1, [player]}

    %大秘境/幻境翻牌奖励记录
    ets:new(ets_flop_rewards_info, [{keypos, #flop_rewards_info.player_id}, named_table, public, set]),
    %幻境玩家等待进入
    ets:new(ets_mirage_wait_info, [{keypos, #mirage_wait_info.team_id}, named_table, public, set]),
    %幻境的玩家数据
    ets:new(ets_mirage_player, [{keypos, 1}, named_table, public, set]), % {1, [player]}

	create_ets_home(),
	create_ets_home_data(),
	
	%跨服聊天窗口查看玩家数据
	ets:new(?ETS_CROSS_CHAT_DATA, [{keypos, 1}, named_table, public, set]),  %% 数据{{player_id,type},bin_data,unix_time}

	% 跨服玩家player
	ets:new(?ETS_CROSS_PLAYER, [{keypos, #player_status.id}, named_table, public, set]),

    % 跨服3V3
    ets:new(?ETS_PVP_3V3_ROOM, [{keypos, #room.captain}, named_table, public, set]),
    ets:new(?ETS_PVP_3V3_SUP_POOL, [{keypos, #sup_pool.dan}, named_table, public, set]),
    ets:new(?ETS_PVP_RANK_DATA, [{keypos, #pvp_rank_data.id}, named_table, public, set]),
    ets:new(?ETS_PVP_CROSS_PLAYER_DATA, [{keypos, #pvp_cross_player_data.player_id}, named_table, public, set]),
	ets:new(?CROSS_TYPE_POOL, [{keypos, #type_pool.type}, named_table, public, set]),
	
	ets:new(?ETS_PVP_MATCH_ROOM, [{keypos, #match_room.captain}, named_table, public, set]),
	
	%3v3记录逃跑，用于额外扣分和不算近比赛
	ets:new(ets_3v3_escape, [{keypos, 1}, named_table, public, set]),  %% 数据{player_id,status} 0代表正常，1代表逃跑

	%翅膀（外观）系统
    ets:new(ets_player_wing, [{keypos, #player_wing.player_id}, named_table, public, set]), 
	ets:new(ets_wing_info, [{keypos, #wing_info.player_key}, named_table, public, set]), %key = {_ ,_}
	
	%% 短信验证码
	ets:new(?ETS_ACCOUNT_BIND_MOBILE_SMS, [{keypos, 1}, named_table, public, set]),

    %限时任务
    ets:new(ets_limit_time_task_rank, [{keypos, 1}, named_table, public, set]),  %rank
    ets:new(ets_limit_time_task_player,[{keypos, #limited_time_player.player_id}, named_table, public, set]),

    ets:new(ets_limit_time_task_player_rank_data, [{keypos, 1}, named_table, public, set]),  %rank_data

    ets:new(ets_limited_time_data, [{keypos, #limited_time_data.key}, named_table, public, set]),
    ets:new(ets_limited_time_attach,[{keypos, #limited_time_attach.key}, named_table, public, set]),
    ets:new(ets_limited_time_eattach, [{keypos, #limited_time_eattach.key}, named_table, public, set]),

    %法宝相关
    ets:new(ets_fabao_all_id, [{keypos, 1}, named_table, public, set]),
    ets:new(ets_fabao_all_no, [{keypos, 1}, named_table, public, set]),
    ets:new(ets_fabao_is_battle, [{keypos, 1}, named_table, public, set]),  %rank
    ets:new(ets_fabao_info, [{keypos, #fabao_info.id}, named_table, public, set]),
    ets:new(ets_fabao_fuyin, [{keypos, #fabao_fuyin.id}, named_table, public, set]),
    ets:new(ets_fabao_fuyin_all_id, [{keypos, 1}, named_table, public, set]),

    %自动返利功能
    ets:new(ets_player_acc_recharge , [{keypos, 1}, named_table, public, set]) ,  %活动期间累积充值

    ets:new(ets_player_day_recharge , [{keypos, 1}, named_table, public, set]) ,  %每天凌晨结算

    ets:new(ets_player_optional_reward, [{keypos, #player_optional_data.player_id}, named_table, public, set]),

    ok.



%% 创建N个ets，用于存在线玩家的数据(player_status结构体)
create_ets_onilne() ->
    F = fun(SeqNum) ->
            EtsName = list_to_atom(lists:concat([ets_online_, SeqNum])),
            ets:new(EtsName, [{keypos,#player_status.id}, named_table, public, set])
        end,
    lists:foreach(F, lists:seq(1, ?ETS_ONLINE_COUNT)).


%% 创建N个ets，用于存玩家的具体位置(plyr_pos结构体)
create_ets_player_position() ->
    F = fun(SeqNum) ->
            EtsName = list_to_atom(lists:concat([ets_player_position_, SeqNum])),
            ets:new(EtsName, [{keypos,#plyr_pos.player_id}, named_table, public, set])
        end,
    lists:foreach(F, lists:seq(1, ?ETS_PLAYER_POSITION_COUNT)).


%% 创建N个ets，用于存玩家物品(goods结构体)
create_ets_inv_goods() ->
    F = fun(SeqNum) ->
            EtsName = list_to_atom(lists:concat([ets_inv_goods_, SeqNum])),
            ets:new(EtsName, [{keypos, #goods.id}, named_table, public, set])
        end,
    lists:foreach(F, lists:seq(1, ?ETS_INV_GOODS_COUNT)).


%% 创建N个ets，存放玩家家园数据
create_ets_home() ->
	F = fun(SeqNum) ->
            EtsName = list_to_atom(lists:concat([?ETS_HOME, "_", SeqNum])),
            ets:new(EtsName, [{keypos, #home.id}, named_table, public, set])
        end,
    lists:foreach(F, lists:seq(1, ?ETS_HOME_COUNT)).





%% 创建N个ets，存放玩家家园格子数据
create_ets_home_data() ->
	F = fun(SeqNum) ->
            EtsName = list_to_atom(lists:concat([?ETS_HOME_DATA, "_", SeqNum])),
            ets:new(EtsName, [{keypos, #home_data.key}, named_table, public, set])
        end,
    lists:foreach(F, lists:seq(1, ?ETS_HOME_DATA_COUNT)).


%% 从DB加载ip封禁和角色封禁信息
db_load_banned_info() ->
    Now = util:unixtime(),
    case db:select_all(t_ban_ip_list, "ip, end_time", []) of
        [] -> skip;
        List when is_list(List) ->
            F = fun([Ip, EndTime]) ->
                case EndTime =:= ?FORVER_BAN_TIME orelse EndTime > Now of
                    true -> ets:insert(?ETS_BANNED_IP, #banned_ip{ip = Ip, end_time = EndTime});
                    false -> db:delete(t_ban_ip_list, [{ip, Ip}])
                end
            end,
            lists:foreach(F, List)
    end,
	
	
	


    case db:select_all(t_ban_role, "role_id, end_time", []) of
        [] -> skip;
        List1 when is_list(List1) ->
            F1 = fun([RoleId, EndTime1]) ->
                case EndTime1 =:= ?FORVER_BAN_TIME orelse EndTime1 > Now of
                    true -> ets:insert(?ETS_BANNED_ROLE, #banned_role{role_id = RoleId, end_time = EndTime1});
                    false -> db:delete(t_ban_role, [{role_id, RoleId}])
                end
            end,
            lists:foreach(F1, List1)
    end,
	
	case db:select_all(global_sys_var, "sys, var", []) of
		[] -> skip;
		List2 when is_list(List2) ->
			F2 = fun([Sys, Var]) ->
						 GlobalSysVar = #global_sys_var{sys = Sys, var = util:bitstring_to_term(Var)},
						 mod_svr_mgr:set_global_sys_var_cache(GlobalSysVar)
				 end,
			lists:foreach(F2, List2)
	end.
