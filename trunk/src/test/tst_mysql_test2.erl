%%%---------------------------------------------
%%% @Module  : mysql_test2
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.4.7
%%% @Description: 试验、测试数据库
%%%---------------------------------------------
-module(tst_mysql_test2).
-export([
		init_db/0,
		mysel/0,
		my_insert/0
		 ]).

-include("common.hrl").
-include("mysql.hrl").
-include("db.hrl").




-define(DB_USER, "simserver").
-define(DB_PASSWORD, "123456").
-define(DB_NAME, "simserver").



init_db() ->
	% 游戏
	Db_host1 = "localhost",
	mysql:start_link(?DB, Db_host1, ?DEFAULT_DB_PORT, ?DB_USER, ?DB_PASSWORD, ?DB_NAME, fun(_, _, _, _) -> ok end, ?DB_ENCODE),
		
		
    F1 = fun() -> mysql:connect(?DB, Db_host1, ?DEFAULT_DB_PORT, ?DB_USER, ?DB_PASSWORD, ?DB_NAME, ?DB_ENCODE, true) end,
    %%?TRACE("init_db(), db conn num: ~p~n", [config:get_db_conn_num(App)]),
	_ConnRet = [F1() || _ <- lists:duplicate(100, 1)],
    ?TRACE("ConnRet: ~p~n", [_ConnRet]),

	% % 后台
	% Db_host2 = config:get_bg_db_host(App),
 %    F2 = fun() -> mysql:connect(?DB_BG, Db_host2, ?DEFAULT_DB_PORT_BG, ?DB_USER_BG, ?DB_PASS_BG, ?DB_NAME_BG, ?DB_ENCODE_BG, true) end,

 %    ?TRACE("init_db(), bg db conn num: ~p~n", [config:get_bg_db_conn_num(App)]),

	% ConnRet2 = [F2() || _ <- lists:duplicate(config:get_bg_db_conn_num(App), 1)],
 %     ?TRACE("ConnRet2: ~p~n", [ConnRet2]),
	
    ok.



mysel() ->
	Sql = io_lib:format(<<"select id, lv, nickname from player">>, []),
	_Result = db_esql:get_row(?DB, Sql),

	?TRACE("Result: ~p~n", [_Result]).

my_insert() ->
	F = fun(X) ->
		db:replace(obj_buff, [{player_id, X}, {partner_id, X}, {buff_list, util:term_to_bitstring([])}]),
		db:replace(obj_buff, [{player_id, X}, {partner_id, 0}, {buff_list, util:term_to_bitstring([])}]),
		timer:sleep(100)
	end,
	[F(X) || X <- lists:seq(1, 2000000)].







