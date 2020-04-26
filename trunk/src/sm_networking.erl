%%%-----------------------------------
%%% @Module  : sm_networking
%%% @Author  :
%%% @Email   :
%%% @Created : 2011.06.1
%%% @Description: 网络
%%%------------------------------------
-module(sm_networking).
-export([start/1, start_world/0]).
-compile(export_all).

-include("net.hrl").
-include("go.hrl").
-include("lginout.hrl").
-include("framework.hrl").
-include("log.hrl").
-include("common.hrl").
-include("road.hrl").

%% 开启server节点 （注意确保：各模块启动的先后顺序要正确！）
start([Ip, Port, Sid]) ->
    inets:start(),
    ok = start_kernel(),        % 核心服务须优先启动
    ok = start_timer(),

    % ok = start_rand(),
    ok = start_id_alloc(),
    ok = start_db_queue_manage(),
    ok = start_cross_client(),		% 跨服通信客户端
    ok = start_server_clock(),
    ok = start_mytime(),

    ok = start_job_schedule(),
    ok = start_disperse([Ip, Port, Sid]),

    ok = start_client(),
    ok = start_tcp(Port),

    ok = start_player_hb_mgr(),
    ok = start_mon_mgr(),
    ok = start_npc_mgr(),
    ok = start_scene_mgr(),

    mod_data_checker:check_cfg_data(),
    % mod_global_data:init(),
    start_golbal_data(),
    
    %%ok = start_task(),

    %%ok = start_mail(),
    ok = start_guild(),

    ok = start_world_lv(),

    ok = start_golbal_collection(),

    ok = start_dungeon(),

    ok = start_offline_arena(),

    ok = start_cruise(),

    ok = start_activity(),

    ok = start_rank(),
    ok = start_reward_pool(),
    ok = start_player_asyn(),
    ok = start_battle_mgr(),
    ok = start_battle_judger(),
    ok = start_hire(),  % 初始化天将模块
    ok = start_market(),
    ok = start_shop(),
    ok = start_broadcast(),

    ok = start_loginout_TSL(),
    ok = start_logout_server(),

    ok = start_write_log_server(),
    ok = start_team_mgr(),
    ok = start_relation(),
    ok = start_sys_checker(),

    ok = start_player_tmplogout_cache(),
    ok = start_arena_1v1(),
    ok = start_arena_3v3(),
    ok = start_tve(),  % 初始化tve兵临城下模块

    ok = start_transport(),

    ok = start_data_load(),

    ok = start_udp(),

    ok = start_cdk(),

    ok = start_chat(),

    ok = start_sprd(),

    ok = start_offcast(),

    ok = start_beauty_contest(),    % 启动女妖选美统计管理器

    ok = start_xs_task(),           % 启动悬赏任务管理器

    ok = start_horse_race(),         % 启动跑马场管理器

    ok = start_ernie(),              % 幸运转盘

    ok = start_business(),           % 商会系统

    ok = start_player_ext(),         % 玩家拓展属性系统 例如PK值

    ok = start_slotmachine(),        % 老虎机系统启动

    ok = start_guild_battle(),
	
	ok = start_home(),			     % 家园系统
	
	ok = start_guess(),			     % 竞猜活动进程
    ok = start_guild_dungeon(),      %帮派副本
    ok = start_newyear_banquet(),    %限时转盘
 	
	ok = start_cross_server(),		% 跨服通信服务端
    ok = start_road(),

    ok = start_cross_3v3_pvp(),      % 跨服3v3战斗

    % !!! 活动管理器最后开启（它有可能会给前面一些活动公共进程发送消息）
    ok = start_admin_acitivty(),
    del_data(),
    % 最后，设为开服状态
    sm:set_server_open_state(open),
    %开服获取限时任务排行榜数据
  lib_limited_task:get_rank_player_data(),
  load_player_Auto_fanli(),
    ply_guild:refresh_guild_shop(),
    ok.





%% 开启world节点
start_world() ->
    not_need_now.  % world节点已经废弃了！！ -- huangjf







-ifdef(debug).
	%% 开启自定义时间server
	start_mytime() ->
		{ok,_} = supervisor:start_child(
               		sm_sup,
               		{mod_mytm,
                	{mod_mytm, start_link, []},
                  permanent, 10000, worker, [mod_mytm]}),
    ok.
-else.
	%% release版本不需开启自定义时间server
	start_mytime() ->
    %%io:format("release version, start_mytime() do nothing!~n", []),
		ok.
-endif.



%% 开启核心服务
start_kernel() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_kernel,
                {mod_kernel, start_link,[]},
                %%permanent, 10000, supervisor, [mod_kernel]}),
                permanent, 10000, worker, [mod_kernel]}),
    ok.


%% 开启服务器时钟
start_server_clock() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {svr_clock,
                {svr_clock, start_link,[]},
                permanent, 10000, worker, [svr_clock]}),
    ok.


%% 开启id自动分配器功能
start_id_alloc() ->
    mod_id_alloc:init(),
    ok.


%% 开启作业计划服务
start_job_schedule() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_ply_jobsch,
                {mod_ply_jobsch, start_link,[]},
                permanent, 10000, worker, [mod_ply_jobsch]}),
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_sys_jobsch,
                {mod_sys_jobsch, start_link,[]},
                permanent, 10000, worker, [mod_sys_jobsch]}),
    ok.


%% 开启多线
start_disperse([Ip, Port, Sid]) ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_disperse,
                {mod_disperse, start_link,[Ip, Port, Sid]},
                %%permanent, 10000, supervisor, [mod_disperse]}),
                permanent, 10000, worker, [mod_disperse]}),
    ok.

%% 随机种子
% start_rand() ->
%     {ok,_} = supervisor:start_child(
%                sm_sup,
%                {mod_rand,
%                 {mod_rand, start_link,[]},
%                 %%permanent, 10000, supervisor, [mod_rand]}),
%                 permanent, 10000, worker, [mod_rand]}),
%     ok.


%% 开启客户端监控树
start_client() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {sm_tcp_client_sup,
                {sm_tcp_client_sup, start_link,[]},
                transient, infinity, supervisor, [sm_tcp_client_sup]}),
    ok.


%% 开启跨服客户端监控树
start_cross_client() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {sm_cross_client_sup,
                {sm_cross_client_sup, start_link,[]},
                transient, infinity, supervisor, [sm_cross_client_sup]}),
    ok.


%% 开启tcp listener监控树
start_tcp(Port) ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {?TCP_LISTENER_SUP,
                {sm_tcp_listener_sup, start_link, [Port]},
                transient, infinity, supervisor, [sm_tcp_listener_sup]}),
    ok.



%% 开启玩家的心跳管理服务
start_player_hb_mgr() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_ply_hb_mgr,
                {mod_ply_hb_mgr, start_link,[]},
                permanent, 10000, worker, [mod_ply_hb_mgr]}),
    ok.


%% 开启怪物管理服务
start_mon_mgr() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_mon_mgr,
                {mod_mon_mgr, start_link,[]},
                %%permanent, 10000, supervisor, [mod_mon_create]}),
                permanent, 10000, worker, [mod_mon_mgr]}),
    ok.


%% 开启npc管理服务
start_npc_mgr() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_npc_mgr,
                {mod_npc_mgr, start_link,[]},
                %%permanent, 10000, supervisor, [mod_npc_create]}),
                permanent, 10000, worker, [mod_npc_mgr]}),
    ok.

%% 开启场景管理服务
start_scene_mgr() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_scene_mgr,
                {mod_scene_mgr, start_link,[]},
                %%permanent, 10000, supervisor, [mod_scene]}),
                permanent, 10000, worker, [mod_scene_mgr]}),
    ok.



%% 开启用于辅助玩家（重新）上线、下线之间同步的server
start_loginout_TSL() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_lginout_TSL,
                {mod_lginout_TSL, start_link,[]},
                permanent, 10000, worker, [mod_lginout_TSL]}),
    ok.


%% 开启专处理玩家下线的server
start_logout_server() ->
  F = fun(SeqNum) ->
        ChildId = list_to_atom("mod_lgout_svr" ++ integer_to_list(SeqNum)),
        {ok,_} = supervisor:start_child(
                   sm_sup,
                   {ChildId,
                    {mod_lgout_svr, start_link,[SeqNum]},
                    permanent, 10000, worker, [mod_lgout_svr]})
      end,
  L = lists:seq(1, ?MAX_LOGOUT_SERVER_COUNT),
  [F(X) || X <- L],
  ok.







start_write_log_server() ->
  case config:need_to_log_recved_proto(?APP_SERVER) of
    false ->
        skip;
    true ->
        F = fun(SeqNum) ->
              ChildId = list_to_atom("mod_wrlog_svr" ++ integer_to_list(SeqNum)),
              {ok,_} = supervisor:start_child(
                         sm_sup,
                         {ChildId,
                          {mod_wrlog_svr, start_link,[SeqNum]},
                          permanent, 10000, worker, [mod_wrlog_svr]})
            end,
        L = lists:seq(1, ?MAX_WRITE_LOG_SERVER_COUNT),
        [F(X) || X <- L]
  end,
  ok.






% %% 开启任务服务
% start_task() ->
%     {ok,_} = supervisor:start_child(
%                sm_sup,
%                {mod_task,
%                 {mod_task, start_link,[]},
%                 %%permanent, 10000, supervisor, [mod_task]}),
%                 permanent, 10000, worker, [mod_task]}),
%     ok.



%% 开启玩家的异步操作处理的服务
start_player_asyn() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_ply_asyn,
                {mod_ply_asyn, start_link,[]},
                permanent, 10000, worker, [mod_ply_asyn]}),
    ok.



%% 开启战斗管理
start_battle_mgr() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_battle_mgr,
                {mod_battle_mgr, start_link,[]},
                permanent, 10000, worker, [mod_battle_mgr]}),
    ok.


%% 开启战斗judger
start_battle_judger() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_battle_judger,
                {mod_battle_judger, start_link,[]},
                permanent, 10000, worker, [mod_battle_judger]}),
    ok.


% %% 开启定时器监控树
% start_timer() ->
%     {ok,_} = supervisor:start_child(
%                sm_sup,
%                {timer_frame,
%                 {timer_frame, start_link,[]},
%                 permanent, 10000, supervisor, [timer_frame]}),
%     ok.

% %% 开启定时器监控树
% start_timer_new() ->
%     {ok,_} = supervisor:start_child(
%                sm_sup,
%                {timer_frame_new,
%                 {timer_frame_new, start_link,[]},
%                 permanent, 10000, supervisor, [timer_frame_new]}),
%     ok.

% %% 开启帮派监控树
% start_guild() ->
%     {ok,_} = supervisor:start_child(
%                sm_sup,
%                {mod_guild,
%                 {mod_guild, start_link,[[guild_p_0, 0]]},
%                 permanent, 10000, supervisor, [mod_guild]}),
%     ok.







% %% 开启邮件监控树
% start_mail() ->
%     {ok,_} = supervisor:start_child(
%                sm_sup,
%                {mod_mail,
%                 {mod_mail, start_link,[]},
%                 permanent, 10000, supervisor, [mod_mail]}),
%     ok.


% %% 开启阵法服务
% start_troop() ->
%     {ok,_} = supervisor:start_child(
%                sm_sup,
%                {mod_troop,
%                 {mod_troop, start_link,[]},
%                 %%permanent, 10000, supervisor, [mod_troop]}),
%                 permanent, 10000, worker, [mod_troop]}),
%     ok.




%% 开启市场交易（拍卖行）系统服务
start_market() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_market_supply,
                {mod_market, start_link, []},
                %%permanent, 10000, supervisor, [mod_market]}),
                permanent, 10000, worker, [mod_market]}),
    ok.

% %% 开启竞技场系统服务
% start_arena() ->
%     {ok,_} = supervisor:start_child(
%                sm_sup,
%                {mod_arena,
%                 {mod_arena, start_link, []},
%                 %%permanent, 10000, supervisor, [mod_arena]}),
%                 permanent, 10000, worker, [mod_arena]}),
%     ok.


% %% 开启全服的一些数据统计模块的服务
% start_gs_stati() ->
%     {ok,_} = supervisor:start_child(
%                sm_sup,
%                {mod_gs_stati,
%                 {mod_gs_stati, start_link, []},
%                 %%permanent, 10000, supervisor, [mod_gs_stati]}),
%                 permanent, 10000, worker, [mod_gs_stati]}),
%     ok.



%% 开启定时清理器
%%start_timing_cleaner() ->
%%    {ok,_} = supervisor:start_child(
%%               sm_sup,
%%               {mod_market_supply,
%%                {mod_market_supply, start_link, []},
%%                permanent, 10000, supervisor, [mod_market_supply]}),
%%    ok.




%% 开启好友关系
start_relation() ->
	{ok, _} = supervisor:start_child(
				sm_sup,
				{mod_relation,
				 {mod_relation, start_link, []},
				 permanent, 10000, worker, [mod_relation]}),
	ok.

%% 开启商城
start_shop() ->
	 {ok, _} = supervisor:start_child(
				sm_sup,
				{  mod_shop,
				   {mod_shop, start_link, []},
				   permanent, 10000, worker, [mod_shop]}),
	 ok.


start_broadcast() ->
    {ok, _} = supervisor:start_child(
        sm_sup,
        {  mod_broadcast,
           {mod_broadcast, start_link, []},
           permanent, 10000, worker, [mod_broadcast]}),
    ok.


start_guild() ->
    {ok, _} = supervisor:start_child(
        sm_sup,
        {  mod_guild_mgr,
           {mod_guild_mgr, start_link, []},
           permanent, 10000, worker, [mod_guild_mgr]}),
    ok.


start_team_mgr() ->
    {ok, _} = supervisor:start_child(
        sm_sup,
        {  mod_team_mgr,
           {mod_team_mgr, start_link, []},
           permanent, 10000, worker, [mod_team_mgr]}),
    ok.


% %% 开启掉落监控树
% start_drop() ->
% 	{ok, _} = supervisor:start_child(
% 				sm_sup,
% 				{  mod_drop,
% 				   {mod_drop, start_link, []},
% 				   permanent, 10000, supervisor, [mod_drop]}),
% 	ok.





% %% 开启系统公告监控树
% start_affiche() ->
% 	{ok, _} = supervisor:start_child(
% 				sm_sup,
% 				{mod_affiche,
% 				 {mod_affiche, start_link, []},
% 				 permanent, 10000, supervisor, [mod_affiche]}),
% 	ok.


% %% 新手群
% start_group() ->
% 	{ok, _} = supervisor:start_child(
% 				sm_sup,
% 				{mod_group,
% 				 {mod_group, start_link, []},
% 				 permanent, 10000, supervisor, [mod_group]}),
% 	ok.

%% 开启副本管理
start_dungeon() ->
    {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_dungeon_manage,
           {mod_dungeon_manage, start_link, []},
           permanent, 10000, worker, [mod_dungeon_manage]}),
    ok.

%% 开启世界等级
start_world_lv() ->
  {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_world_lv,
           {mod_world_lv, start_link, []},
           permanent, 10000, worker, [mod_world_lv]}),
    ok.

start_golbal_collection() ->
  {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_global_collection,
           {mod_global_collection, start_link, []},
           permanent, 10000, worker, [mod_global_collection]}),
    ok.


%% 开启离线竞技场
start_offline_arena() ->
  {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_offline_arena,
           {mod_offline_arena, start_link, ['offline_arena_manage']},
           permanent, 10000, worker, [mod_offline_arena]}),
    ok.


%% 开启巡游活动服务
start_cruise() ->
    {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_cruise,
           {mod_cruise, start_link, []},
           permanent, 10000, worker, [mod_cruise]}),
    ok.


%% 开启活动服务
start_activity() ->
    {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_activity,
           {mod_activity, start_link, []},
           permanent, 10000, worker, [mod_activity]}),
    ok.


start_db_queue_manage() ->
    {ok, _} = supervisor:start_child(
          sm_sup,
          {db_queue_manage,
           {db_queue_manage, start_link, []},
           permanent, 10000, worker, [db_queue_manage]}),
    ok.

%% 开启排行榜
start_rank() ->
    mod_rank:start(),
    ok.


start_offcast() ->
    mod_offcast:start(),
    ok.

start_timer() ->
    mod_timer:start(),
    ok.

start_sys_checker() ->
    mod_sys_checker:start(),
    ok.


start_hire() ->
    {ok, _} = supervisor:start_child(
        sm_sup,
        {  mod_hire_mgr,
           {mod_hire_mgr, start_link, []},
           permanent, 10000, worker, [mod_hire_mgr]}),
   ok.


start_arena_1v1() ->
    mod_arena_1v1:start(),
    ok.

start_arena_3v3() ->
    mod_arena_3v3:start(),
    ok.

start_reward_pool() ->
    mod_reward_pool:start(),
    ok.

start_business() ->
    mod_business:start(),
    ok.

start_player_ext() ->
  mod_player_ext:start(),
  ok.

start_slotmachine() ->
    mod_slotmachine:start(),
    ok.

start_guild_battle() ->
    mod_guild_battle:start(),
    ok.

start_tve() ->
    {ok, _} = supervisor:start_child(
        sm_sup,
        {  mod_tve_mgr,
           {mod_tve_mgr, start_link, []},
           permanent, 10000, worker, [mod_tve_mgr]}),
   ok.

%% 数据加载
start_data_load() ->
    % 竞技场数据加载
    mod_offline_arena:db_load_all_daily_rank(),
    ok.

%% 开启运营活动
start_admin_acitivty() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_admin_activity,
                {mod_admin_activity, start_link,[]},
                permanent, 10000, worker, [mod_admin_activity]}),
    ok.


%% 开启临时退出的玩家缓存的管理
start_player_tmplogout_cache() ->
    {ok,_} = supervisor:start_child(
               sm_sup,
               {ply_tmplogout_cache,
                {ply_tmplogout_cache, start_link,[]},
                permanent, 10000, worker, [ply_tmplogout_cache]}),
    ok.


start_udp() ->
  {ok,_} = supervisor:start_child(
               sm_sup,
               {mod_udp,
                {mod_udp, start_link,[]},
                permanent, 10000, worker, [mod_udp]}),
    ok.


%% 开启激活码服务
start_cdk() ->
    {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_cdk,
           {mod_cdk, start_link, []},
           permanent, 10000, worker, [mod_cdk]}),
    ok.



%% 开启聊天敏感词服务
start_chat() ->
    {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_chat,
           {mod_chat, start_link, []},
           permanent, 10000, worker, [mod_chat]}),
    ok.



%% 开启推广系统服务
start_sprd() ->
    {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_sprd,
           {mod_sprd, start_link, []},
           permanent, 10000, worker, [mod_sprd]}),
    ok.


start_transport() ->
    {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_transport,
           {mod_transport, start_link, []},
           permanent, 10000, worker, [mod_transport]}),
    ok.

start_beauty_contest() ->
    {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_beauty_contest,
           {mod_beauty_contest, start_link, []},
           permanent, 10000, worker, [mod_beauty_contest]}),
    ok.

start_xs_task() ->
    {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_xs_task,
           {mod_xs_task, start_link, []},
           permanent, 10000, worker, [mod_xs_task]}),
    ok.

start_horse_race() ->
    {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_horse_race,
           {mod_horse_race, start_link, []},
           permanent, 10000, worker, [mod_horse_race]}),
    ok.

start_ernie() ->
    {ok, _} = supervisor:start_child(
          sm_sup,
          {mod_ernie,
           {mod_ernie, start_link, []},
           permanent, 10000, worker, [mod_ernie]}),
    ok.


start_golbal_data() ->
    {ok, _} = supervisor:start_child(
        sm_sup,
        {mod_global_data,
           {mod_global_data, start_link, []},
           permanent, 10000, worker, [mod_global_data]}),
    ok.


%% 开启家园进程管理服务
start_home() ->
	{ok,_} = supervisor:start_child(
			   sm_sup,
			   {mod_home,
				{mod_home, start_link,[]},
				%%permanent, 10000, supervisor, [mod_scene]}),
				permanent, 10000, worker, [mod_home]}),
	ok.



%% 开启竞猜活动进程管理服务
start_guess() ->
	{ok,_} = supervisor:start_child(
			   sm_sup,
			   {mod_guess,
				{mod_guess, start_link,[]},
				permanent, 10000, worker, [mod_guess]}),
	ok.

start_guild_dungeon() -> 
	{ok, _} = supervisor:start_child(
			   sm_sup,
			   {mod_guild_dungeon,
				{mod_guild_dungeon, start_link,[]},
				permanent, 10000, worker, [mod_guild_dungeon]}),
	ok.

start_newyear_banquet() -> 
	{ok, _} = supervisor:start_child(
			   sm_sup,
			   {mod_newyear_banquet,
				{mod_newyear_banquet, start_link,[]},
				permanent, 10000, worker, [mod_newyear_banquet]}),
	ok.

start_cross_3v3_pvp() ->
    {ok, _} = supervisor:start_child(
        sm_sup,
        {mod_pvp,
            {mod_pvp, start_link,[]},
            permanent, 10000, worker, [mod_pvp]}),
    ok.

start_cross_server() ->
    {ok, _} = supervisor:start_child(
        sm_sup,
        {sm_cross_server,
           {sm_cross_server, start_link, []},
           permanent, 10000, worker, [sm_cross_server]}),
    ok.

start_road() ->
	{ok, _} = supervisor:start_child(
        sm_sup,
        {mod_road,
           {mod_road, start_link, []},
           permanent, 10000, worker, [mod_road]}),
    ok.


load_player_Auto_fanli() ->
  case db:select_all(clock_data, "player_id, fanli", []) of
    List when is_list(List) ->
      F =
        fun(X) ->
          [PlayerId,BinData]= X,
          {DayRecharge  , AccRecharge, HavaGet} = util:bitstring_to_term(BinData),
          case AccRecharge > 0 of
            true ->
              ets:insert(ets_player_acc_recharge,  {PlayerId, AccRecharge, HavaGet});
            false ->
              skip
          end,
          case DayRecharge > 0 of
            true ->
              ets:insert(ets_player_day_recharge, {PlayerId, DayRecharge});
            false ->
              skip
          end
        end,
      lists:foreach(F, List);
    Err ->
      ?ERROR_MSG("server_start_init Err : ~p~n", [Err])
  end.



%%
del_data() ->
    ServerId = config:get_server_id(),
    case erlang:date() =< {2015, 5, 21} of
        true ->
			%% 这里是什么意思？临时修复？  v
            db:update(?DB_SYS, mount, ["id"], [(ServerId * 100000000000 + 1)], "id", 1);
        % true ->
        %     ?DEBUG_MSG("del_data(), server_id:~p, date:~p", [config:get_server_id(), erlang:date()]),
        %     F0 = fun(TableName) ->
        %         db:delete(?DB_SYS, TableName, [{id, 0}])
        %     end,
        %     [F0(X) || X <- [player,guild_member,relation_info,offstate,activity_data,offcast,activity_degree,tower,title,hardtower]],

        %     F = fun(TableName) ->
        %         db:delete(?DB_SYS, TableName, [{player_id, 0}])
        %     end,
        %     [F(X) || X <- [day_reward,find_par,obj_buff,player_misc,sys_set,xinfa]],

        %     F1 = fun(TableName) ->
        %         db:delete(?DB_SYS, TableName, [{role_id, 0}])
        %     end,
        %     [F1(X) || X <- [achievement_data,answer,chapter_target_info,dungeon_cd,dungeon_plot_target,role_dungeon,role_transport,t_ban_chat,t_ban_role,
        %     task_auto_trigger,task_bag,task_completed,task_completed_unrepeat,task_ring,truck_info,ernie]];
        false ->
            ?DEBUG_MSG("not need to del_data, server_id:~p, date:~p", [config:get_server_id(), erlang:date()]),
            skip
    end.
    % case erlang:date() =< {2015, 4, 30} andalso (ServerId =:= 10026 orelse ServerId =:= 10027) of
    %     true ->
    %         if
    %             ServerId =:= 10026 ->
    %                 db:delete(?DB_SYS, offline_bo, [{id, "<", 1002600000000001}]);
    %             ServerId =:= 10027 ->
    %                 db:delete(?DB_SYS, offline_bo, [{id, "<", 1002700000000001}]);
    %             true -> skip
    %         end;
    %     false ->
    %         skip
    % end.


% 现已作废！！
% %% 合服之前初始化from_server_id
% update_from_server_id_for_all_players() ->
%     case erlang:date() =< {2015, 1, 15} of
%         true ->
%             ?DEBUG_MSG("update_from_server_id_for_all_players(), server_id:~p, date:~p", [config:get_server_id(), erlang:date()]),
%             db:update(
%                 ?DB_SYS,
%                 player,
%                 [{"from_server_id", config:get_server_id()}],
%                 []
%                 );
%         false ->
%             ?DEBUG_MSG("not need to update_from_server_id_for_all_players(), server_id:~p, date:~p", [config:get_server_id(), erlang:date()]),
%             skip
%     end.

%% 纠正数据用，仅用一次
% alter_data() ->
%     ServerId = config:get_server_id(),
%     case erlang:date() =< {2015, 2, 26} andalso (ServerId =:= 10025 orelse ServerId =:= 10026 orelse ServerId =:= 10027 orelse ServerId =:= 10028) of
%         true ->
%             ?DEBUG_MSG("alter_data(), server_id:~p, date:~p", [ServerId, erlang:date()]),
%             if 
%                 ServerId =:= 10025 ->
%                     db:update(?DB_SYS, partner, "update `partner` set `id`= (10025 * 100000000000 + id) where id < 1002500000000001"),
%                     db:update(?DB_SYS, partner_hotel, "update `partner_hotel` set `id`= (10025 * 100000000000 + id) where id < 1002500000000001"),
%                     db:update(?DB_SYS, guild, "update `guild` set `id`= (10025 * 100000000000 + id) where id < 1002500000000001"),
%                     db:update(?DB_SYS, market_selling, "update `market_selling` set `id`= (10025 * 100000000000 + id) where id < 1002500000000001"),
%                     db:update(?DB_SYS, mail, "update `mail` set `id`= (10025 * 100000000000 + id) where id < 1002500000000001"),
%                     db:update(?DB_SYS, relation, "update `relation` set `id`= (10025 * 100000000000 + id) where id < 1002500000000001");
%                 ServerId =:= 10026 ->
%                     db:update(?DB_SYS, partner, "update `partner` set `id`= (10026 * 100000000000 + id) where id < 1002600000000001"),
%                     db:update(?DB_SYS, partner_hotel, "update `partner_hotel` set `id`= (10026 * 100000000000 + id) where id < 1002600000000001"),
%                     db:update(?DB_SYS, guild, "update `guild` set `id`= (10026 * 100000000000 + id) where id < 1002600000000001"),
%                     db:update(?DB_SYS, goods, "update `goods` set `id`= (10026 * 100000000000 + id) where id < 1002600000000001"),
%                     db:update(?DB_SYS, market_selling, "update `market_selling` set `id`= (10026 * 100000000000 + id) where id < 1002600000000001"),
%                     db:update(?DB_SYS, mail, "update `mail` set `id`= (10026 * 100000000000 + id) where id < 1002600000000001"),
%                     db:update(?DB_SYS, relation, "update `relation` set `id`= (10026 * 100000000000 + id) where id < 1002600000000001");
%                 ServerId =:= 10027 ->
%                     db:update(?DB_SYS, partner, "update `partner` set `id`= (10027 * 100000000000 + id) where id < 1002700000000001"),
%                     db:update(?DB_SYS, partner_hotel, "update `partner_hotel` set `id`= (10027 * 100000000000 + id) where id < 1002700000000001"),
%                     db:update(?DB_SYS, guild, "update `guild` set `id`= (10027 * 100000000000 + id) where id < 1002700000000001"),
%                     db:update(?DB_SYS, goods, "update `goods` set `id`= (10027 * 100000000000 + id) where id < 1002700000000001"),
%                     db:update(?DB_SYS, market_selling, "update `market_selling` set `id`= (10027 * 100000000000 + id) where id < 1002700000000001"),
%                     db:update(?DB_SYS, mail, "update `mail` set `id`= (10027 * 100000000000 + id) where id < 1002700000000001"),
%                     db:update(?DB_SYS, relation, "update `relation` set `id`= (10027 * 100000000000 + id) where id < 1002700000000001");
%               ServerId =:= 10028 ->
%                     db:update(?DB_SYS, partner, "update `partner` set `id`= (10028 * 100000000000 + id) where id < 1002800000000001"),
%                     db:update(?DB_SYS, partner_hotel, "update `partner_hotel` set `id`= (10028 * 100000000000 + id) where id < 1002800000000001"),
%                     db:update(?DB_SYS, guild, "update `guild` set `id`= (10028 * 100000000000 + id) where id < 1002800000000001"),
%                     db:update(?DB_SYS, market_selling, "update `market_selling` set `id`= (10028 * 100000000000 + id) where id < 1002800000000001"),
%                     db:update(?DB_SYS, relation, "update `relation` set `id`= (10028 * 100000000000 + id) where id < 1002800000000001");
%               true ->
%                     skip
%             end;
%         false ->
%             ?DEBUG_MSG("not need to alter_data(), server_id:~p, date:~p", [config:get_server_id(), erlang:date()]),
%             skip
%     end.


% adjust_guild_war() ->
%     ServerId = config:get_server_id(),
%     case erlang:date() =< {2015, 4, 23} andalso ServerId =:= 10030 of
%         true ->
%             ?DEBUG_MSG("adjust_guild_war(), server_id:~p, date:~p", [config:get_server_id(), erlang:date()]),
%             mod_guild_mgr:reset_counter_and_round();
%         false ->
%             ?DEBUG_MSG("not need to adjust_guild_war(), server_id:~p, date:~p", [config:get_server_id(), erlang:date()]),
%             skip
%     end.