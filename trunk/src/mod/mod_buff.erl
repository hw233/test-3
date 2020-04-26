%%%-----------------------------------
%%% @Module  : mod_buff
%%% @Author  : zwq
%%% @Email   : 
%%% @Created : 2013.10.29
%%% @Description: buff接口
%%%-----------------------------------

-module(mod_buff).

-include("ets_name.hrl").
-include("debug.hrl").
-include("buff.hrl").
-include("common.hrl").

-export([
        get_obj_buff_list/1,          %% 获取在线玩家和刚下线不久的玩家包括他的宠物的buff对象列表
        get_buff_list/2,              %% 获取玩家or宠物身上的buff列表 return buff 结构体列表
        add_buff_to_ets/1,
        update_buff_to_ets/1,
        del_buff_from_ets/3,
        del_player_buff_from_ets/1,

        db_insert_buff/2,
        db_save_buff/2,
        db_load_buff/1,

        find_buff_no_by_name/2,       %% 根据buff名字查找玩家or宠物buff编号
        update_buff_left_time/1,      %% 更新buff剩余时间，顺便把过期的buff去掉

        get_buff_para_by_name/3,      %% 根据buff名字获取buff的参数
        get_buff_state_by_name/3,     %% 根据buff名字获取buff的状态
        get_buff_left_time_by_name/3, %% 根据buff名字获取buff的剩余有效时间，单位是秒
        has_buff/3                    %% 根据buff名字判断玩家or宠物是否有这个buff
    ]).


%% return buff 结构体列表 | [] 
get_buff_list(player, PlayerId) ->
    Key = {player, PlayerId},
    case ets:lookup(?ETS_BUFF, Key) of
        [] -> 
            [];
        [ObjBuff] ->
            ObjBuff#obj_buff.buff_list
    end;
get_buff_list(partner, PartnerId) ->
    Key = {partner, PartnerId},
    case ets:lookup(?ETS_BUFF, Key) of
        [] -> 
            [];
        [ObjBuff] ->
            ObjBuff#obj_buff.buff_list
    end.

%% return obj_buff 列表
get_obj_buff_list(PlayerId) ->
    Key = {player, PlayerId},
    PlayerBuff = 
        case ets:lookup(?ETS_BUFF, Key) of
            [] -> [];
            [ObjBuff] -> [ObjBuff]
        end,
    F = fun(X, Acc) ->
        case ets:lookup(?ETS_BUFF, {partner, X}) of
            [] -> Acc;
            [ParBuff] -> [ParBuff | Acc]
        end
    end,
    PartnerBuff = 
        case player:get_PS(PlayerId) of
            null -> 
                case ply_tmplogout_cache:get_tmplogout_PS(PlayerId) of
                    null -> [];
                    PS -> lists:foldl(F, [], player:get_partner_id_list(PS))
                end;
            PS -> lists:foldl(F, [], player:get_partner_id_list(PS))
        end,
    PlayerBuff ++ PartnerBuff.


has_buff(player, PlayerId, BuffNo) when is_integer(BuffNo) ->
    BuffList = mod_buff:get_buff_list(player, PlayerId),
    BuffNoList = [Buff#buff.no || Buff <- BuffList],
    lists:member(BuffNo, BuffNoList);

has_buff(player, PlayerId, BuffName) ->
    BuffList = mod_buff:get_buff_list(player, PlayerId),
    BuffNoList = [Buff#buff.no || Buff <- BuffList],
    case find_buff_no_by_name(BuffNoList, BuffName) of
        ?INVALID_NO ->
            false;
        _BuffNo ->
            true
    end;
    
has_buff(partner, PartnerId, BuffNo) when is_integer(BuffNo) ->
    BuffList = mod_buff:get_buff_list(partner, PartnerId),
    BuffNoList = [Buff#buff.no || Buff <- BuffList],
    lists:member(BuffNo, BuffNoList);

has_buff(partner, PartnerId, BuffName) ->
    BuffList = mod_buff:get_buff_list(partner, PartnerId),
    BuffNoList = [Buff#buff.no || Buff <- BuffList],
    case find_buff_no_by_name(BuffNoList, BuffName) of
        ?INVALID_NO ->
            false;
        _BuffNo ->
            true
    end.


%% return integer | null
get_buff_para_by_name(player, PlayerId, BuffName) ->
    BuffList = mod_buff:get_buff_list(player, PlayerId),
    BuffNoList = [Buff#buff.no || Buff <- BuffList],
    case find_buff_no_by_name(BuffNoList, BuffName) of
        ?INVALID_NO ->
            null;
        BuffNo ->
            BuffTpl = lib_buff_tpl:get_tpl_data(BuffNo),
            lib_buff_tpl:get_para(BuffTpl)
    end;

get_buff_para_by_name(partner, PartnerId, BuffName) ->
    BuffList = mod_buff:get_buff_list(partner, PartnerId),
    BuffNoList = [Buff#buff.no || Buff <- BuffList],
    case find_buff_no_by_name(BuffNoList, BuffName) of
        ?INVALID_NO ->
            null;
        BuffNo ->
            BuffTpl = lib_buff_tpl:get_tpl_data(BuffNo),
            lib_buff_tpl:get_para(BuffTpl)
    end.
    

%% 获取buff的状态：0--不开启 1-->开启
get_buff_state_by_name(player, PlayerId, BuffName) ->
    BuffList = mod_buff:get_buff_list(player, PlayerId),
    BuffNoList = [Buff#buff.no || Buff <- BuffList],
    case find_buff_no_by_name(BuffNoList, BuffName) of
        ?INVALID_NO ->
            null;
        BuffNo ->
            case lists:keyfind(BuffNo, #buff.no, BuffList) of
                false -> 0;
                Buff -> Buff#buff.open_state
            end
    end;

get_buff_state_by_name(partner, PartnerId, BuffName) ->
    BuffList = mod_buff:get_buff_list(partner, PartnerId),
    BuffNoList = [Buff#buff.no || Buff <- BuffList],
    case find_buff_no_by_name(BuffNoList, BuffName) of
        ?INVALID_NO ->
            0;
        BuffNo ->
            case lists:keyfind(BuffNo, #buff.no, BuffList) of
                false -> 0;
                Buff -> Buff#buff.open_state
            end
    end.

get_buff_left_time_by_name(player, PlayerId, BuffName) ->
    BuffList = mod_buff:get_buff_list(player, PlayerId),
    BuffNoList = [Buff#buff.no || Buff <- BuffList],
    case find_buff_no_by_name(BuffNoList, BuffName) of
        ?INVALID_NO ->
            0;
        BuffNo ->
            case lists:keyfind(BuffNo, #buff.no, BuffList) of
                false -> 0;
                Buff -> 
                    case Buff#buff.open_state =:= 0 of
                        true -> 0;
                        false -> erlang:max(0, Buff#buff.left_time - (util:unixtime() - Buff#buff.start_time))
                    end
            end
    end.

add_buff_to_ets(ObjBuff) when is_record(ObjBuff, obj_buff) ->
    ets:insert(?ETS_BUFF, ObjBuff).


update_buff_to_ets(ObjBuff) when is_record(ObjBuff, obj_buff) ->
    ets:insert(?ETS_BUFF, ObjBuff).


del_buff_from_ets(player, PlayerId, BuffNo) ->
    Key = {player, PlayerId},
    case ets:lookup(?ETS_BUFF, Key) of
        [] -> 
            ?ASSERT(false),
            void;
        [ObjBuff] ->
            BuffList = ObjBuff#obj_buff.buff_list,
            NewBuffList = lists:keydelete(BuffNo, #buff.no, BuffList),
            NewObjBuff = ObjBuff#obj_buff{buff_list = NewBuffList},
            update_buff_to_ets(NewObjBuff)
    end;
del_buff_from_ets(partner, PartnerId, BuffNo) ->
    Key = {partner, PartnerId},
    case ets:lookup(?ETS_BUFF, Key) of
        [] -> 
            ?ASSERT(false),
            void;
        [ObjBuff] ->
            BuffList = ObjBuff#obj_buff.buff_list,
            NewBuffList = lists:keydelete(BuffNo, #buff.no, BuffList),
            NewObjBuff = ObjBuff#obj_buff{buff_list = NewBuffList},
            update_buff_to_ets(NewObjBuff)
    end.

del_player_buff_from_ets(PS) ->
    Key = {player, player:id(PS)},
    ets:delete(?ETS_BUFF, Key),
    F = fun(PartnerId) ->
        ets:delete(?ETS_BUFF, {partner, PartnerId})
    end,
    lists:foreach(F, player:get_partner_id_list(PS)).


db_insert_buff(PlayerId, ObjBuff) when is_record(ObjBuff, obj_buff) ->
    PartnerId = 
    case ObjBuff#obj_buff.key of
        {player, _PlayerId1} -> 0;
        {partner, PartnerId1} -> PartnerId1;
        _Any -> ?ASSERT(false)
    end,
    BuffList_BS = util:term_to_bitstring(ObjBuff#obj_buff.buff_list),
    db:insert(PlayerId, obj_buff, ["player_id", "partner_id", "buff_list"], [PlayerId, PartnerId, BuffList_BS]).


db_save_buff(PlayerId, PartnerIdList) ->
    F = fun(ObjBuff) ->
        PartnerId = 
        case ObjBuff#obj_buff.key of
            {player, _PlayerId1} -> 0;
            {partner, PartnerId1} -> PartnerId1;
            _Any -> ?ASSERT(false)
        end,
        % NewBuffList = update_buff_left_time(ObjBuff#obj_buff.buff_list),
        BuffList_BS = util:term_to_bitstring(ObjBuff#obj_buff.buff_list),
        db:replace(PlayerId, obj_buff, [{player_id, PlayerId}, {partner_id, PartnerId}, {buff_list, BuffList_BS}])
    end,

    case ets:lookup(?ETS_BUFF, {player, PlayerId}) of
        [] -> skip;
        [ObjBuffPlayer] -> F(ObjBuffPlayer)
    end,

    F1 = fun(PartnerId) ->
        case ets:lookup(?ETS_BUFF, {partner, PartnerId}) of
            [] -> skip;
            [ObjBuffPartner] -> F(ObjBuffPartner)
        end
    end,    
    lists:foreach(F1, PartnerIdList).


%% 加载玩家自己以及玩家宠物的buff
%% @return: [] | obj_buff结构体列表
db_load_buff(PlayerId) ->
    case db:select_all(obj_buff, "player_id, partner_id, buff_list", [{player_id, PlayerId}]) of
        InfoList_List when is_list(InfoList_List) ->
            ObjBuffList = [to_obj_buff_record(InfoList) || InfoList <- InfoList_List],
            F = fun(ObjBuff) ->
                add_buff_to_ets(ObjBuff)
            end,
            lists:foreach(F, ObjBuffList),
            ObjBuffList;
         _Any ->
            ?ERROR_MSG("[mod_buff] db_load_buff() error!", []),
            ?ASSERT(false, _Any),
            []
    end.


%% 根据buffNo列表 和 buff名字，查找编号，找到返回编号，找不到则return false
find_buff_no_by_name([BuffNo | T], BuffName) ->
    case lib_buff_tpl:get_name(lib_buff_tpl:get_tpl_data(BuffNo)) =:= BuffName of
        true -> BuffNo;
        false -> find_buff_no_by_name(T, BuffName)
    end;
find_buff_no_by_name([], _BuffName) ->
    ?INVALID_NO.

%% ---------------------------------------------------------Local Fun--------------------------------


to_obj_buff_record(InfoList) ->
    [PlayerId, PartnerId, BuffList_BS] = InfoList,
    BuffList = 
    case util:bitstring_to_term(BuffList_BS) of
        undefine -> [];
        BuffList1 when is_list(BuffList1) -> BuffList1
    end,
    Key = 
    case PartnerId /= 0 of
        false -> {player, PlayerId};
        true -> {partner, PartnerId}
    end,
    #obj_buff{
    key = Key,
    buff_list = BuffList
    }.


%% 更新buff剩余时间，顺便把过期的buff去掉
update_buff_left_time(BuffList) when is_list(BuffList) ->
    Now = util:unixtime(),
    F = fun(Buff, AccList) ->
        NewLeftTime = 
            case Buff#buff.open_state =:= 0 of
                false -> erlang:max(0, Buff#buff.left_time - (Now - Buff#buff.start_time));
                true -> Buff#buff.left_time
            end,
        case NewLeftTime > 0 of
            true ->
                NewBuff = Buff#buff{left_time = NewLeftTime},
                [NewBuff | AccList];
            false ->
                AccList
        end
    end,
    lists:foldl(F, [], BuffList);
update_buff_left_time(Buff) ->
    NewLeftTime = 
        case Buff#buff.open_state =:= 0 of
            false -> erlang:max(0, Buff#buff.left_time - (util:unixtime() - Buff#buff.start_time));
            true -> Buff#buff.left_time
        end,
    Buff#buff{left_time = NewLeftTime}.