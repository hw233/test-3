%%%--------------------------------------
%%% @Module: ply_activity
%%% @Author: liuzhongzheng2012@gmail.com
%%% @Created: 2014-05-20
%%% @Description: 玩家的活动数据
%%%--------------------------------------

-module(ply_activity).

-export([
            init/1,
            on_player_final_logout/1,
            get/2,
            set/3,
            del/2
        ]).

-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").



%% 初始化玩家的活动数据
init(PS) -> % 新上线(无缓存)
    PlayerID = player:id(PS),
    case get_activity_datas(PlayerID) of
        null ->
            DataList =
                case db:kv_lookup(activity_data, PlayerID) of
                    [] ->
                        [];
                    [List] ->
                        List
                end,
            add_activity_datas_to_ets(PlayerID, DataList);
        _ ->
            skip
    end,
    PS.


%% 玩家最终退出时的处理（保存玩家的活动数据到DB，然后从内存清掉）
on_player_final_logout(PS) ->
    PlayerID = player:id(PS),
    case get_activity_datas(PlayerID) of
        null ->
            skip;
        DataList ->
            db_save_activity_datas(PlayerID, DataList),
            del_activity_datas_from_ets(PlayerID)
    end,
    PS.



%% 获取指定活动的数据(找不到则返回null)
%% @para: ActID => 活动代号，详见activity_degree_sys.hrl
-spec get(integer(), integer()) -> any().
get(PlayerID, ActID) ->
    case get_activity_datas(PlayerID) of
        null ->
            null;
        DataList ->
            case lists:keyfind(ActID, 1, DataList) of
                ?false ->
                    null;
                {ActID, Data} ->
                    Data
            end
    end.

%% 设置活动数据
-spec set(integer(), integer(), any()) -> ok.
set(PlayerID, ActID, Data) ->
    DataList =
        case get_activity_datas(PlayerID) of
            null ->
                [];
            List ->
                List
        end,
    DataList1 = lists:keystore(ActID, 1, DataList, {ActID, Data}),
    update_activity_datas_to_ets(PlayerID, DataList1),
    ok.


%% 删除活动数据
-spec del(integer(), integer()) -> ok.
del(PlayerID, ActID) ->
    case get_activity_datas(PlayerID) of
        null ->
            skip;
        List ->
            List1 = lists:keydelete(ActID, 1, List),
            update_activity_datas_to_ets(PlayerID, List1)
    end,
    ok.











%% =============================================================================================


get_activity_datas(PlayerID) ->
    case ets:lookup(?ETS_ACTIVITY_DATA, PlayerID) of
        [] ->
            null;
        [{PlayerID, DataList}] ->
            DataList
    end.


add_activity_datas_to_ets(PlayerID, Datas) ->
    ets:insert(?ETS_ACTIVITY_DATA, {PlayerID, Datas}).


update_activity_datas_to_ets(PlayerID, NewDatas) ->
    ets:insert(?ETS_ACTIVITY_DATA, {PlayerID, NewDatas}).

del_activity_datas_from_ets(PlayerID) ->
    ets:delete(?ETS_ACTIVITY_DATA, PlayerID).


db_save_activity_datas(PlayerID, Datas) ->
    db:kv_insert(activity_data, PlayerID, Datas).
