%%%-----------------------------------
%%% @Module  : mod_player_ext
%%% @Author  : 段世和
%%% @Email   : 
%%% @Created : 2015.10.24
%%% @Description: 玩家拓展属性
%%%-----------------------------------


-module(mod_player_ext).

% include
-include("common.hrl").
-include("player_ext.hrl").
% -include("goods.hrl").
% -include("record/goods_record.hrl").
-include("abbreviate.hrl").
-include("player.hrl").
-include("ets_name.hrl").
-include("log.hrl").
-include("sys_code_2.hrl").
-include("prompt_msg_code.hrl").
-include("num_limits.hrl").

-include("scene.hrl").

-export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2, code_change/3]).
-export([start/0, start_link/0, stop/0]).

-export([]).

% function body
% 循环检测
loop_check() ->
    % 获取所有在线玩家
    % 判断玩家所在位置以及人气值进行变化
    
    F = fun(RoleId) -> 
        PS = player:get_PS(RoleId),
		
		% % 判断是否在泡点地图
        % case player:get_scene_no(PS) of
        %     ?SCENE_PAODIAN_NO ->
        %         % 获取泡点类型
        %         PaodianType = ply_setting:get_paodian_type(RoleId),
        %         % 获取泡点配置
        %         PaodianConfig = data_paodian:get(PaodianType),

        %         ?DEBUG_MSG("PaodianType=~p",[PaodianType]),
        %         ?DEBUG_MSG("PaodianConfig=~p",[PaodianConfig]),

        %         % 判断是否满足
        %         case player:check_need_price(PS,PaodianConfig#paodian_config.price_type,PaodianConfig#paodian_config.price) of
        %             ok ->  
        %                 player:cost_money(PS, PaodianConfig#paodian_config.price_type,PaodianConfig#paodian_config.price, [?LOG_GM,"paodian"]),
        %                 player:add_exp(PS, PaodianConfig#paodian_config.exp, [?LOG_GM,"paodian"]); 
        %             _ ->
        %                 % 金钱不足设置为默认泡点
        %                 ply_setting:set_paodian_type(PS,0),
        %                 % 每分钟获经验值
        %                 player:add_exp(PS, ?POPULAR_PAODIAN_ADD, [?LOG_GM,"paodian"])
        %         end;
                
        %     _Ot ->
        %         skip
        % end,

        % ?DEBUG_MSG("PopularValue = ~p",[PopularValue]),
        % % 如果玩家的人气值小于0
        
        ?Ifc (player:get_popular(PS) > 0) 
            % 回复速度根据场景不同而不同

            Add = case player:get_scene_no(PS) of 
                ?SCENE_PRISON_NO ->
                    ?POPULAR_PRISON_ADD;
                _ ->
                    ?POPULAR_NORMAL_ADD
            end,

            player:set_popular(PS,util:minmax(player:get_popular(PS) - Add,0,5000 ))
        ?End,

        void
    end,

    lists:foreach(F, mod_svr_mgr:get_all_online_player_ids()).


% start
start() ->
    case erlang:whereis(?MODULE) of
        undefined ->
            case supervisor:start_child(
               sm_sup,
               {?MODULE,
                {?MODULE, start_link, []},
                 permanent, 60000, worker, [?MODULE]}) of
            {ok, Pid} ->
                Pid;
            {error, R} ->
                ?WARNING_MSG("start error:~p~n", [R]),
                undefined
            end;
        Pid ->
            Pid
    end.

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

% stop
stop() ->
    supervisor:terminate_child(sm_sup, ?MODULE).


code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(_Reason, _State) ->
    ok.

% call 同步调用需要等待结构
do_call(_Msg, _From, State) ->
    ?WARNING_MSG("unhandle call ~w", [_Msg]),
    {reply, error, State}.

% 异步调用无需等待
% cast
do_cast(_Msg, State) ->
    ?WARNING_MSG("unhandle cast ~p", [_Msg]),
    {noreply, State}.

%% info
do_info(doloop, State) ->
    loop_check(),
    {noreply, State};

do_info(_Msg, State) ->
    ?WARNING_MSG("unhandle info ~w", [_Msg]),
    {noreply, State}.

init([]) ->
    % 每60秒执行一次循环
    mod_timer:reg_loop_msg(self(), 60000),
    {ok, #state{}}.


% handle
handle_call(Request, From, State) ->
    try
        do_call(Request, From, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {reply, error, State}
    end.


handle_cast(Request, State) ->
    try
        do_cast(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {noreply, State}
    end.



handle_info(Request, State) ->
    try
        do_info(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {noreply, State}
    end.