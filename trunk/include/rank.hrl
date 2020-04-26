%%%------------------------------------------------
%%% File    : rank.hrl
%%% Author  : mo
%%% Created : 2014.4.9
%%% Description: 排行榜相关宏
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__RANK_H__).
-define(__RANK_H__, 0).

-include("rank_name.hrl").

%% 玩家个人排行
% -record(rank_role, {
%                     rank      = 0,
%                     player_id = 0,
%                     nickname  = <<>>,
%                     sex       = 0,----------------P1
%                     faction   = <<>>,-------------P2
%                     info      = 0,
%                     time      = 0,
%                     viplv     = 0,
%                     ext       = 0
%     }).

%% 女妖排行
% -record(rank_partner, {
%                     rank         = 0,
%                     player_id    = 0,
%                     player_name  = <<>>,
%                     partner_id   = 0,-------------P1
%                     partner_name = <<>>,----------P2
%                     info         = 0,
%                     time         = 0,
%                     viplv        = 0,
%                     ext          = 0
%     }).

%% 装备排行榜
% -record(rank_equip, {
%                     rank        = 0,
%                     player_id   = 0,
%                     player_name = <<>>,
%                     goods_id    = 0,--------------P1
%                     goods_name  = <<>>,-----------P2
%                     info        = 0,
%                     time        = 0,
%                     viplv       = 0,
%                     ext         = 0---------------物品详情
%     }).

%%  竞技场排行榜
% -record(rank_arena, {
%                     rank        = 0,
%                     player_id   = 0,
%                     player_name = <<>>,
%                     wins        = 0,-------------info={wins, win_rate}
%                     win_rate    = 0,-------------info={wins, win_rate}
%                     time        = 0,
%                     viplv       = 0,
%                     ext         = 0
%     }).

% 协议号：22005
% C >> S:
%     uint16   排行榜类型
%     uint8    分页
% S >> C:
%     uint16   排行榜类型
%     uint16   我的排名（0显示未上榜）
%     uint16   排行榜总数
%     array(
%               uint16     排名       ---rank
%               uint64     排序ID     ---player_id
%               string     名字       ---player_name
%               uint32     排序值     ---info
%               string     参数字符串 ---p1
%               uint64     参数1      ---p2
%               uint32     参数2      ---p3
%             )


-record(ranker, {
                    rank         = 0,
                    player_id    = 0,
                    player_name  = <<>>,
                    p1           = 0,
                    p2           = 0,
                    p3           = 0,
                    info         = 0,
                    time         = 0,
                    viplv        = 0,
                    ext          = 0
    }).

-record(data_rank, {
          id           = 0,
          refresh_time = [],
          show_size    = 0,
          total_size   = 0,
          history_time = []
}).

-record(rank_title,		{
						 rank = 9003,
						 rewards = [],
						 title = 0,
						 content = 0
						}).

%% 排行榜分页大小
-define(RANK_PER_PAGE, 10).


%%%%%%%%%%%%%%%%%  排行榜分类ID  %%%%%%%%%%%%%%%%%

%% 排行榜类型对应协议号: 即 1xxx对应 22001, 2xxx对应22002, 类推!
%% 玩家个人榜 1xxx
%% 女妖榜 2xxx
%% 神器榜 3xxx
%% 竞技场榜 4xxx
%% 帮派排行榜 5xxx


-endif.  %% __RANK_H__
