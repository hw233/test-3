%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.11.12
%%% @doc 女妖乱斗.
%%% @end
%%%------------------------------------

-module(mod_melee).
-behaviour(gen_server).
-export([start_link/1, stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("log.hrl").
-include("record.hrl").
-include("melee.hrl").

-define(REFRESH_SEEMON_TIME, 60). % 每60秒刷新一次明雷怪
-define(PAODIAN_TIME, 5). % 泡点间隔



%%=========================================================================
%% 接口函数
%%=========================================================================

start_link(MeleeSceneList) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [MeleeSceneList], []).
stop() ->
    gen_server:call(?MODULE, stop).

%%=========================================================================
%% 回调函数
%%=========================================================================
init([MeleeSceneList]) ->
	%%     erlang:send_after(5*1000, self(), 'refresh_seemon'),
	erlang:send_after(60 * 1000, self(), 'refresh_seemon'),
	erlang:send_after(1000, self(), 'paodian'),
	{ok, MeleeSceneList}.

handle_call(stop, _From, State) ->
    {stop, normal, stopped, State};
handle_call(Request, _From, State) -> 
    try 
		do_call(Request, _From, State)
    catch
        _Err:_Reason ->
            ?ERROR_MSG("handle_call *** [~p:~p] ~p ***~n", [_Err, _Reason, erlang:get_stacktrace()]),
            {reply, error, State}
    end.

handle_cast(Request, State)-> 
	try 
		do_cast(Request, State)
    catch
        _Err:_Reason ->
            ?ERROR_MSG("handle_cast *** [~p:~p] ~p ***~n", [_Err, _Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.

handle_info(Request, State)->  
    try 
		do_info(Request, State)
    catch
        _Err:_Reason ->
            ?ERROR_MSG("handle_info *** [~p:~p] ~p ***~n", [_Err, _Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

do_call(_Request, _From, State) ->
    throw({no_match, do_call, _Request}),
	{reply, ok, State}.

do_cast(_Request, State) ->
    throw({no_match, do_cast, _Request}),
	{noreply, State}.

do_info('paodian', MeleeSceneList) ->
    F = fun(Scene) ->
        PSS = lib_scene:get_scene_player_ids(Scene#melee_scene.scene_id),   

        F = fun(RoleId) ->
					
					
					
            PS = player:get_PS(RoleId),
			case lib_melee:get_melee_ply_info(PS) of
						PlyInfo when PlyInfo#ets_melee_ply_info.status=:=?MELEE_PLY_INFO_STATUS_APPLY ->
							BallNum = PlyInfo#ets_melee_ply_info.ball_num,
            % 获取泡点类型
            PaodianType = ply_setting:get_paodian_type(RoleId),
            % 获取泡点配置
%%             PaodianConfig = data_paodian:get(PaodianType),

            % 判断是否满足(这一步与玩家数据相关，不在跨服服务器处理，rpc通知远程玩家进程处理加泡点经验)
			ServerId = player:get_server_id(PS),
			sm_cross_server:rpc_cast(ServerId, lib_melee, interval_add_paodian_exp, [RoleId, PaodianType, BallNum]),

%%             case player:check_need_price(PS,PaodianConfig#paodian_config.price_type,PaodianConfig#paodian_config.price) of
%%                 ok ->
%%                     player:cost_money(PS, PaodianConfig#paodian_config.price_type,PaodianConfig#paodian_config.price, [?LOG_GM,"paodian"]),
%%                     lib_melee:add_paodian_exp(PS,PaodianConfig#paodian_config.exp);
%%                 _ ->
%%                     % 金钱不足设置为默认泡点
%%                     ply_setting:set_paodian_type(PS,0),
%%                     % 每分钟获经验值
%%                     lib_melee:add_paodian_exp(PS,?POPULAR_PAODIAN_ADD)
%%             end,

            void;
				_ ->
					skip
			end
        end,
        lists:foreach(F, PSS)
        %
    end,
    [F(S) || S<- MeleeSceneList],

    erlang:send_after(?PAODIAN_TIME*1000, self(), 'paodian'),
    {noreply, MeleeSceneList};

do_info('refresh_seemon', MeleeSceneList) ->
	F = fun(Scene) ->
				case lib_scene:get_scene_mon_count(Scene#melee_scene.scene_id) > 9 of 
					true ->
						skip;
					false ->
						N = 10 - lib_scene:get_scene_mon_count(Scene#melee_scene.scene_id) ,
						[begin 
							 MonNo = lib_melee:get_seemon_no(Scene#melee_scene.scene_no),
							 mod_scene:spawn_mon_to_scene_for_public_WNC(MonNo, Scene#melee_scene.scene_id)
						 end || _ <- lists:seq(1, N)]
				end
		end,
	[F(S) || S<- MeleeSceneList],
	erlang:send_after(1800 * 1000, self(), 'refresh_seemon'),
	
	{noreply, MeleeSceneList};
do_info(_Request, State) ->
    throw({no_match, do_info, _Request}),
	{noreply, State}.
