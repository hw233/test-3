%%%-------------------------------------------------------------------
%%% @copyright (C) 2018, <COMPANY>
%%% @doc 跨服3V3战斗相关宏
%%%
%%% @end
%%% Created : 11. 十二月 2018 18:17
%%%-------------------------------------------------------------------

%% 避免头文件多重包含
-ifndef(__PVP_H__).
-define(__PVP_H__, 0).

-include("record.hrl").

-record(room, {
    captain = 0,        % 队长(均是保存玩家Id)
    teammates = [],     % 队友(同上)
    timestamp = 0,      % 开始匹配时间戳
    state = 0,          % 0：表示可加入队伍 1：表示不可加入队伍(表示正在匹配)
    grade = 0,          % 队伍评分(目前只是把房间队员的score相加)
    counters = 1,       % 房间默认人数(即是队长)
    cur_troop = 0,      % 当前阵法
    timestamp2 = 0,     % 房间创建时间戳
    apply_list = [],    % 申请入房间玩家信息列表(直接存id)
    invited_list = [],  % 队长已经发送邀请信息的玩家id列表(好友和帮派成员)
    petlists = []       % 形式{captain, partnerID}
}).
-record(match_room, {
    captain = 0,        % 队长(均是保存玩家Id)
    teammates = [],     % 队友(同上)
    timestamp = 0,      % 开始时间戳
    counters = 1,       % 房间默认人数(即是队长)
    cur_troop = 0      % 当前阵法
}).

-record(sup_pool, {
    dan = 0,            % 段位
    pool = []           % 存放房间已经开始匹配的room
}).


-record(pvp_cross_player_data, {
    player_id = 0,           % 玩家Id
    player_name = <<>>,      % 玩家名字
    server_id = 0,           % 服务器Id
    faction = 0,            % 门派
    sex = 0,                % 性别（1：男，2：女）
    race = 0,               % 种族
    lv = 0,                 % 角色等级
    vip_lv = 0,             % vip等级
    showing_equips = #showing_equip{},  % 会影响外形的装备信息
    win = 0,                % 赢场数
    lose = 0,               % 负场数
    escape = 0,             % 逃跑场数
    daytimes = 0,           % 每天参与次数
    dayreward = [],          % 每日领取奖励
    timestamp = 0,          % 最新匹配时间戳
    dan = 0,                % 段位
    score = 0,              % 分数
    rank = 0,               % 排名
    status = 0,             % 0：不在房间  1：在房间    2、准备
    reward = []             % 段位达成奖励
}).


-record(pvp_rank_data, {
    id                          % 唯一键
    ,ranklist =[]               % 排名列表
    ,dirty = 1                  % 脏数据（0正常数据 1脏读数据），每次战斗后标记为1，mod_pvp进程每10分钟检查，
                                % 若dirty=:=1,表示为脏数据，则更新并且广播给其它服，若dirty=:=0，不更新，不广播
}).


-record(type_pool,		{
						 type = {1,1},  %前一个值表示段位，第二个值表示该段位为单排或者双排
						 player_id = [] %玩家列表
						}).


-record(ranking3v3_rank_reward,  {
								  group = 0   
								  ,begin_ranking =0              
								  ,end_ranking = 0                
								  ,reward = 0                 
								 }).

-record(ranking3v3_settlement, {
								no,
								min,
								max,
								bonus_points,
								minus_points
								}).


-define(RANDOM_NAME_PLAYER, [ "青春期的叛逆","﹏夏兮尕。  ","那kiss不算",
							  "我，在笑。","止殤.","无关愛情","习惯了你习惯","GG、那感觉 ",
							  "深情不套路~","语言凝望恐惧","假装狠、坚强 ","傷口卟疼 ",
							  "遛狗de仙女 ","午后慵懒少女","老公不在家 ","怜香惜yu","青春祭","心情随我心"]).

-define(RANDOM_NAME_PARTNER, [ "主攻","所爱非良人","主法","主物理",
							   "高物","高防","彼岸轮回","你专属","高级法","主防",
							   "高级物","高级防","副法","副防","副攻","冷眼旁观"]).
   
%% 段位
-define(BRONZE, 1).        % 青铜
-define(SILVER, 2).        % 白银
-define(GOLD, 3).            % 黄金
-define(PLATINUM, 4).    % 铂金
-define(MASONRY, 5).      % 钻石
-define(PEERLESS, 6).    % 无双
-define(KING, 7).            % 王者

-define(ONE_PARTICPATE, 1).
-define(FIVE_PARTICPATE, 5).
-define(TEN_PARTICPATE, 10).

-record(ranking3v3_team_match_range, {
    no,
    team_match_range
}).

-record(ranking3v3_score, {
    no,
    name,
    min,
    max,
	reward,
    inactive_minus_points = 0
}).

-record(ranking3v3_section, {
    no,
    section
}).

-define(NOT_IN_ROOM, 0).
-define(IN_ROOM, 1).
-define(IS_PREPARE, 2).

-define(ROOM_MEMBER_MAX, 3).
-define(SPLIT_RANKLIST, 100).
-define(RANK_DATA_REFRESH_TIMER, 10).   % 10分钟刷新一次排行榜
-define(SPLIT_ROOMLIST, 6).             % 一次发送6条房间数据给客户端
%%-define(CROSS_PVP_PLAYER_QRY_SQL, "player_id, player_name, server_id, faction, sex, race, lv, showing_equips, win, lose, escape, daytimes, tiemstamp,
%%    dan, score").
-define(CROSS_PVP_PLAYER_QRY_SQL, "player_id, server_id, player_name, sex, race, faction, win, lose, escape, daytimes, tiemstamp,
    dan, score, reward, dayreward").

-endif.  %% __RANK_H__
