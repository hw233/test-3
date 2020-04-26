%%%--------------------------------------
%%% @Module  : lib_relation
%%% @Author  :
%%% @Email   :
%%% @Created : 2014.04.14
%%% @Description: 玩家结拜相关处理函数
%%%--------------------------------------


-module(lib_relation).


-export([
		get_sworn_relation/1,
		get_sworn_type_by_id/1,
		add_sworn_relation/1,
		update_sworn_relation/1,
		del_sworn_relation/1
	]).



-include("ets_name.hrl").
-include("relation.hrl").
-include("common.hrl").


%% para Id为结拜唯一标识，结拜时的队长id
get_sworn_relation(Id) ->
	case Id =:= ?INVALID_ID of
		true -> null;
		false ->
			case ets:lookup(?ETS_SWORN, Id) of
		        [] -> 
		        	case db:select_row(sworn, "type, prefix_only, prefix, suffix_list, members", [{id, Id}], [], [1]) of
		                [] ->
		                    null;
		                [Type, PrefixOnly, Prefix, SuffixList_BS, Members_BS] ->
		                	Members = case util:bitstring_to_term(Members_BS) of undefined -> []; Info -> tuple_to_list(Info) end,
		                	SuffixList = case util:bitstring_to_term(SuffixList_BS) of undefined -> []; List -> List end,
		                	NewRd = #sworn{id = Id, type = Type, prefix_only = PrefixOnly, prefix = Prefix, members = Members, suffix_list = SuffixList},
		                    gen_server:cast(?RELATION_PROCESS, {'init_sworn_relation', NewRd}),
		                    NewRd
		            end;
		        [R] -> R
		    end
	end.


get_sworn_type_by_id(Id) ->
	case Id =:= ?INVALID_ID of
		true -> ?RELA_SWORN_TYPE_NONE;
		false ->
		    case get_sworn_relation(Id) of
		        null -> ?RELA_SWORN_TYPE_NONE;
		        Sworn -> Sworn#sworn.type
		    end
	end.

add_sworn_relation(NewRd) ->
	case ets:lookup(?ETS_SWORN, NewRd#sworn.id) of
		[] ->
			Members_BS = util:term_to_bitstring(list_to_tuple(NewRd#sworn.members)),
			SuffixList_BS = util:term_to_bitstring(NewRd#sworn.suffix_list),
			
			db:replace(?DB_SYS, sworn, [{id,NewRd#sworn.id}, {type,NewRd#sworn.type}, {prefix_only,NewRd#sworn.prefix_only}, {prefix,NewRd#sworn.prefix},
			 {suffix_list,SuffixList_BS}, {members,Members_BS}]),

			ets:insert(?ETS_SWORN, NewRd);
		[Any] ->
			?ERROR_MSG("mod_relation:add_sworn_relation error!~w~n", [{NewRd, Any}])
	end.


update_sworn_relation(NewRd) ->
	Members_BS = util:term_to_bitstring(list_to_tuple(NewRd#sworn.members)),
	SuffixList_BS = util:term_to_bitstring(NewRd#sworn.suffix_list),
	db:update(?DB_SYS, sworn, [{type,NewRd#sworn.type}, {prefix_only,NewRd#sworn.prefix_only}, {prefix,NewRd#sworn.prefix}, {suffix_list,SuffixList_BS},
	 {members, Members_BS}], [{id, NewRd#sworn.id}]),

	ets:insert(?ETS_SWORN, NewRd).


del_sworn_relation(Id) ->
	db:delete(?DB_SYS, sworn, [{id, Id}]),
	ets:delete(?ETS_SWORN, Id).

	

