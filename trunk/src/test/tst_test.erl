-module(tst_test).
-compile(export_all).

-include("ets_name.hrl").
-include("record.hrl").
-include("common.hrl").



	

test_cross(PlayerId, ServerId) ->
	PS = player:get_PS(PlayerId),
	sm_cross_server:rpc_cast(ServerId, mod_login, enter_game_cross, [PS]),
	case player:get_sendpid(PlayerId) of
		null ->
            % ?ASSERT(false, PlayerId),
            % 调试代码，后面需屏蔽掉
            %%<<Cmd:16, _Compress:8, Body/binary>> = Bin,
            %%?DEBUG_MSG("!!!!!!!!!!!!!!!!!!!send_to_uid() error!!!  PlayerId=~p, Cmd=~p, Body=~w, stacktrace:~w", [PlayerId, Cmd, Body, erlang:get_stacktrace()]),

			skip;
		SendPid ->
            % 调试代码：
            % <<Cmd:16, _Compress:8, Body/binary>> = Bin,
            % ?DEBUG_MSG("!!!!!!!!send_tu_uid(),  PlayerId=~p, Cmd=~p, Body=~w, stacktrace=~w~n", [PlayerId, Cmd, Body, erlang:get_stacktrace()]),

%% 			send_to_sid(SendPid, Bin)
%% 			SendPid ! {test_cross, ServerId}, tst_test:recharge(1000300000047261).
    		void
	end.

recharge(RoleId) ->
	{_, _, _,No} =  data_special_config:get(fudai),
						 Title = data_special_config:get('paodian_mail_title'),
						 Title2 =unicode:characters_to_list(Title,utf8),
						 Content = data_special_config:get('guild_dungeon_mail_content'),
						 Content2 =unicode:characters_to_list(Content,utf8),
						 lib_mail:send_sys_mail(RoleId,util:to_binary(Title2), util:to_binary(Content2), [{No, 1 , 1 }], ["Fudai","onefudai"]).

revise() ->
	IdL = [],
	revise(IdL).

revise([]) ->
	ok;

revise([Id|L]) ->
	case db:select_one(player, "id", [{local_id, Id}]) of
		null ->
			io:format("Err : ~p~n", [Id]),
            revise(L);
        PlayerId ->
			io:format("revise id : ~p~n", [{Id, PlayerId}]),
			case db:select_one(mount, "id", [{player_id, PlayerId}, {no, 1009}]) of
				null ->
					io:format("Err Mount Id : ~p~n", [PlayerId]);
				MountId ->
					db:delete(mount, [{id, MountId}]),
					db:update(player, [{mount, 0}], [{id, PlayerId}, {mount, MountId}]),
					db:update(partner, [{mount_id, 0}], [{player_id, PlayerId}, {mount_id, MountId}])
			end,
            revise(L)
    end.

handle(Cmd, Args) ->
    [Id | _] = mod_svr_mgr:get_all_player_ids(),
    ?LDS_TRACE("handle/2 id = ", Id),
    handle(Id, Cmd, Args).

handle(LocId, Cmd, Args) ->
    Id = id(LocId),
    Pid = player:get_pid(Id),
    Status = player:get_PS(Id),
    gen_server:call(Pid, {apply_call, module(Cmd), handle, [Cmd, Status, Args]}).


exec(Module, Method, Args) ->
    [Id | _] = mod_svr_mgr:get_all_player_ids(),
    ?LDS_TRACE("exec/2 id = ", Id),
    exec(Id, Module, Method, Args).

exec(Id, Module, Method, Args) ->
    Pid = player:get_pid(Id),
    % Status = player:get_PS(Id),
    _Msg = gen_server:call(Pid, {apply_call, Module, Method, Args}),
    ?LDS_TRACE("exec result:", _Msg).

gm(Id, Args) ->
    Pid = player:get_pid(Id),
    Status = player:get_PS(Id),
    gen_server:cast(Pid, {apply_cast, lib_gm, handle_chat_msg_as_gm_cmd, [Status, [Args]]}).
    % ?LDS_TRACE("exec result:", Msg).


status(LocId) ->
    Id = id(LocId),
    Status = player:get_PS(Id),
    InfoList = record_info(fields, player_status),
    io:format("============= player_status =============~n", []),
    print(InfoList, Status, 2).

id(Id) -> 
    ServerId = config:get_server_id(),
    ServerId * 100000000000 + Id.

logout(Id) ->
    Pid = player:get_pid(Id),
    gen_server:cast(Pid, 'stop').

print([], _, _) -> io:format("==========================~n", []);
print([Field | Left], Status, Num) ->
    io:format("    ~p = ~p,~n", [Field, erlang:element(Num, Status)]),
    print(Left, Status, Num + 1).


module(Cmd) ->
    %%取前面二位区分功能类型
    [H1, H2, _, _, _] = integer_to_list(Cmd),
    case [H1, H2] of
        %%游戏基础功能处理
        "11" -> pp_chat;
        "30" -> pp_task;
        "20" -> pp_battle;
        "23" -> pp_offline_arena;
        "32" -> pp_npc;
        "15" -> pp_goods;
        "17" -> pp_partner;
        "57" -> pp_dungeon;
        "41" -> pp_hire;
        "40" -> pp_guild;
        "24" -> pp_team;
        "49" -> pp_tower;
        "26" -> pp_market;
        "19" -> pp_mail;
        "52" -> pp_trade;
        "58" -> pp_activity_degree;
        "13" -> pp_player;
        "14" -> pp_relation;
        "42" -> pp_transport;
        "29" -> pp_christmas;
        "36" -> pp_newyear_banquet;
        "34" -> pp_activity;
        "62" -> pp_hardtower;
        %%错误处理
        _Any ->
            ?LDS_TRACE("test routing error", Cmd),
            ?ASSERT(false, _Any),
            {error, "routing failed"}
    end.



%% ====================

create_robot(N) ->
    IdList = lists:seq(10000, 10000 + N),
    F = fun(Index) -> test_client_base:t(Index) end,
    lists:foreach(F, IdList).


%% test:t().
t(N) ->
    Name = "test" ++ integer_to_list(N),
    test_client_base:connect_server("127.0.0.1", 9999),
    timer:sleep(500),
    test_client_base:login(Name),
    timer:sleep(500),
    test_client_base:get_role_list(),
    timer:sleep(500),
    test_client_base:create_role(1, 1, Name),
    timer:sleep(2000),
    db:update(player, [{id, N}], [{nickname, Name}]).

tt(N) ->
    test_client_base:connect_server("127.0.0.1", 9999),
    timer:sleep(500),
    test_client_base:login("test"),
    timer:sleep(500),
    test_client_base:get_role_list(),
    timer:sleep(500),
    test_client_base:create_role(1, 1, string:concat("robot", integer_to_list(N))).

%% test:enter().  tst_test:arrange_list([1,2,3,4,5,6,7],[a,b,c,d,e,f,g]) 1092 21*7
enter(N) ->
    Name = "test" ++ integer_to_list(N),
    test_client_base:fast_enter_game("127.0.0.1", 9999, Name, N).

arrange_list(ListsA,ListsB) ->

  AllList = [[X,X2,X3]||X <- ListsA,X2 <- ListsA,X3 <-ListsB,X =/= X2,(not lists:member(X,ListsB) andalso not lists:member(X2,ListsB))] ++
  [[X,X2,X3]||X2 <- ListsA,X3 <- ListsA,X <-ListsB,X3 =/= X2,(not lists:member(X3,ListsB) andalso not lists:member(X2,ListsB))] ++
[[X,X2,X3]||X <- ListsA,X3 <- ListsA,X2 <-ListsB,X =/= X3,(not lists:member(X,ListsB) andalso not lists:member(X3,ListsB))]++
    [[X,X2,X3]||X <- ListsA,X3 <- ListsA,X2 <-ListsA,X =/= X3,X2 =/=X3,X =/=X2,
      (not (lists:member(X,ListsB) andalso lists:member(X3,ListsB))),(not (lists:member(X,ListsB)
      andalso lists:member(X2,ListsB))),(not (lists:member(X2,ListsB) andalso lists:member(X3,ListsB)))],
  length(AllList).

test_print() ->
  io:format("wujiancheng222").