%%%---------------------------------------------
%%% @Module  : tst_create_role
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.2.8
%%% @Description: 测试创建角色（主要目的是试验应当如何对角色名做合法性检测）
%%%---------------------------------------------
-module(tst_create_role).
-export([
		% batch_create_roles/0

		test_create_same_role/0
	]).

-include("common.hrl").







-define(HOST, "127.0.0.1").
-define(PORT, 9999).
-define(ACCOUNT_NAME, "account").



%% 测试方法： 开服， 然后打开erlang的shell， 然后在shell中调用此函数。
test_create_same_role() ->
	test_client_base:connect_server(?HOST, ?PORT),
	timer:sleep(100),
	
	test_client_base:login(?ACCOUNT_NAME),
	test_client_base:get_role_list(),

	Race = ?RACE_REN,
	Sex = ?SEX_MALE,
	% RoleName = <<1:8, 2:8, 3:8, 127:8>>,
	% test_client_base:create_role(Race, Sex, RoleName).



	% timer:sleep(100),

	% test_client_base:create_role(Race, Sex, RoleName),

	% timer:sleep(100),

	% RoleName2 = <<37:8, 42:8, 43:8>>,
	% test_client_base:create_role(Race, Sex, RoleName2),

	% RoleName3 = <<42:8, 43:8, 37:8>>,
	% test_client_base:create_role(Race, Sex, RoleName3),

	% RoleName4 = <<37:8, 100:8, 43:8>>,
	% test_client_base:create_role(Race, Sex, RoleName4),

	% RoleName5 = <<37:8, 37:8, 43:8>>,
	% test_client_base:create_role(Race, Sex, RoleName5),

	% RoleName6 = <<37:8, 42:8, 42:8>>,
	% test_client_base:create_role(Race, Sex, RoleName6),



	% “你”对应的utf8编码： <<228:8, 189:8, 160:8>>
	% “好"对应的utf8编码： <<229:8, 165:8, 189:8>>
	% “啊”对应的utf8编码： <<229:8, 149:8, 138:8>>

	RoleName7 = list_to_binary("你%好"),
	io:format("RoleName7:~p,  byte size: ~p~n", [RoleName7, byte_size(RoleName7)]),
	test_client_base:create_role(Race, Sex, RoleName7).
	
	% test_client_base:create_role(Race, Sex, RoleName7),




	% RoleName8 = list_to_binary("你好你好你好aa你"),
	% io:format("RoleName8 byte size: ~p~n", [byte_size(RoleName8)]),
	% test_client_base:create_role(Race, Sex, RoleName8),

	% test_client_base:create_role(Race, Sex, RoleName8),



	% RoleName9 = list_to_binary("你好你好你好你好啊"),
	% io:format("RoleName9 byte size: ~p~n", [byte_size(RoleName9)]),
	% test_client_base:create_role(Race, Sex, RoleName9),


	% RoleName10 = list_to_binary("你好你好你好你a好"),
	% io:format("RoleName10 byte size: ~p~n", [byte_size(RoleName10)]),
	% test_client_base:create_role(Race, Sex, RoleName10),

	% RoleName11 = list_to_binary("你"),
	% io:format("RoleName11 byte size: ~p~n", [byte_size(RoleName11)]),
	% test_client_base:create_role(Race, Sex, RoleName11),

	% RoleName12 = list_to_binary("你好a啊"),
	% io:format("RoleName12 byte size: ~p~n", [byte_size(RoleName12)]),
	% test_client_base:create_role(Race, Sex, RoleName12).
































%%% 作废！！
% name_list_for_test() ->
% 	[<<"">>, <<>>, <<>>].


% batch_create_roles() ->
% 	NameList = name_list_for_test(),
% 	N = length(NameList),
% 	batch_create_roles__(NameList, 1, N).


% batch_create_roles__(NameList, Sequence, N) when Sequence > N ->
% 	done;
% batch_create_roles__(NameList, Sequence, N) ->
% 	Name = lists:nth(Sequence, NameList),
% 	create_one_role(Name, Sequence),
% 	batch_create_roles__(NameList, Sequence + 1, N).




% -define(HOST, "127.0.0.1").
% -define(PORT, 9999).
% -define(ACCOUNT_NAME, "account").


% create_one_role(Name, Sequence) ->
% 	test_client_base:connect_server(?HOST, ?PORT),
% 	timer:sleep(100),
% 	AccName = ?ACCOUNT_NAME ++ integer_to_list(Sequence),
% 	test_client_base:login(AccName),
% 	test_client_base:get_role_list(),
% 	test_client_base:create_role().