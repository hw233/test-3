%%%-----------------------------------
%%% @Module  : pt_30
%%% @Author  : LDS
%%% @Email   : 用到25
%%% @Created : 2011.06.17
%%% @Description: 30 任务信息
%%%-----------------------------------
-module(pt_30).
-compile(export_all).
-include("common.hrl").
-include("protocol/pt_30.hrl").
-include("task.hrl").
%%
%%客户端 -> 服务端 ----------------------------
%%

%% 可见任务
read(30001, _Data) ->
    {ok, []};

%% 可接任务
read(30002, _Data) ->
    {ok, []};

%% 接受任务
read(30003, <<TaskId:32>>) ->
    {ok, [TaskId]};

read(30004, <<TaskId:32, Len:16, Item/binary>>) ->
    ItemList = read_array(Len, Item),
    {ok, [TaskId, ItemList]};

read(30005, <<TaskId:32>>) ->
    {ok, [TaskId]};

read(30006, <<TaskId:32>>) ->
    {ok, [TaskId]};

read(30008, <<NpcId:32>>) ->
    {ok, [NpcId]};

read(30009, <<State:8>>) ->
    {ok, [State]};

read(30901, <<TaskId:32, State:16>>) ->
    {ok, [TaskId, State]};

read(30010, <<TaskId:32>>) ->
    {ok, [TaskId]};

read(30011, <<TaskId:32>>) ->
    {ok, [TaskId]};

read(30014, <<TaskId:32>>) ->
    {ok, [TaskId]};

%% 悬赏任务相关 30100 ~ 30199
read(?PT_GET_XS_TASK_INFO, <<FiltType:8, Page:16>>) ->
    {ok, [FiltType, Page]};

read(?PT_ISSUE_XS_TASK, <<IssueNum:16, IsAnonymity:8>>) ->
    {ok, [IssueNum, IsAnonymity]};

read(?PT_RECEIVE_XS_TASK, <<IssueId:32>>) ->
    {ok, [IssueId]};

read(?PT_GET_LEFT_ISSUE_NUM, _Data) ->
    {ok, []};

read(?PT_IS_CAN_RECEIVE_XS_TASK, _Data) ->
    {ok, []};

read(?PT_IS_CAN_GET_REWARD_BY_TIMES, _Data) ->
    {ok, []};

read(?PT_ERNIE_GET, _Data) ->
    {ok, []};

read(_Cmd, _Data) ->
    ?ASSERT(false, [_Cmd]),
    {error, not_match}.


write(30001, [Data]) ->
    %%过滤环数到达的任务
    F = fun([TaskId, State, NpcId, SceneId, Step, Ring] ,Acc) ->
        DataTask = data_task:get(TaskId),
        TaskRing =
            case DataTask#task.ring of
                0 ->
                    9999;
                {_,_,_,Repeat,_} ->
                    case DataTask#task.type of
                        6 ->
                            9999;
                        _ ->
                            Repeat
                    end
            end,
        case Ring > TaskRing of
            true ->
                Acc;
            false ->
                [<<TaskId:32, State:16, NpcId:32, SceneId:32, Step:16, Ring:8>>|Acc]
        end
        end,
    List = lists:foldl(F,[],Data),

    Len = erlang:length(List),

    Bin = list_to_binary(List),

    BinData = <<Len:16, Bin/binary>>,
    {ok, pt:pack(30001, BinData)};

write(30002, [Data]) ->
    Len = erlang:length(Data),
    F = fun([TaskId, State, NpcId, SceneId, Step, Ring, Timestamp, Mark], Sum) ->
            BinMark = pack_mark(Mark),
            [<<TaskId:32, State:16, NpcId:32, SceneId:32, Step:16, Ring:8, Timestamp:32, BinMark/binary>> | Sum]
        end,
    List = lists:foldl(F, [], Data),
    Bin = list_to_binary(List),
    BinData = <<Len:16, Bin/binary>>,
    {ok, pt:pack(30002, BinData)};

write(30003, [TaskId, State]) ->
    {ok, pt:pack(30003, <<TaskId:32, State:8>>)};

write(30004, [TaskId, State]) ->
    {ok, pt:pack(30004, <<TaskId:32, State:8>>)};

write(30005, [TaskId, State]) ->
    {ok, pt:pack(30005, <<TaskId:32, State:8>>)};

write(30006, [[TaskId, State, NpcId, SceneId, Step, Ring, Timestamp, Mark]]) ->
    BinMark = pack_mark(Mark),
    {ok, pt:pack(30006, <<TaskId:32, State:16, NpcId:32, SceneId:32, Step:16, Ring:8, Timestamp:32, BinMark/binary>>)};

write(30007, [TaskId]) ->
    {ok, pt:pack(30007, <<TaskId:32>>)};

write(30008, [Data]) ->
    Len = length(Data),
    List = [<<TaskId:32, State:16, NpcId:32, SceneId:32, Step:16, Ring:8>> ||
            [TaskId, State, NpcId, SceneId, Step, Ring] <- Data],
    BinList = list_to_binary(List),
    {ok, pt:pack(30008, <<Len:16, BinList/binary>>)};

write(30010, [TaskId, SceneId, X, Y,MonId]) ->
    Bin = <<TaskId:32, SceneId:32, X:16, Y:16,MonId:32>>,
    {ok, pt:pack(30010, Bin)};

write(30011, [TaskId]) ->
    {ok, pt:pack(30011, <<TaskId:32>>)};

write(30012, [TaskId, FailList]) ->
    Len = erlang:length(FailList),
    Bin = list_to_binary([<<Id:64, Err:8>> || {Id, Err} <- FailList]),
    {ok, pt:pack(30012, <<TaskId:32, Len:16, Bin/binary>>)};

write(30013, [[TaskId, State, NpcId, SceneId, Step, Ring, Timestamp, Mark]]) ->
    BinMark = pack_mark(Mark),
    {ok, pt:pack(30013, <<TaskId:32, State:16, NpcId:32, SceneId:32, Step:16, Ring:8, Timestamp:32, BinMark/binary>>)};


write(30014, [TaskId, State]) ->
    {ok, pt:pack(30014, <<TaskId:32, State:16>>)};


write(?PT_NOTIFY_TASKID, [TaskId]) ->
    {ok, pt:pack(?PT_NOTIFY_TASKID, <<TaskId:32>> )};

write(30901, [Flag]) ->
    {ok, pt:pack(30901, <<Flag:8>>)};

%% 悬赏任务相关 30100 ~ 30199
write(?PT_GET_XS_TASK_INFO, [Page, AllPage, Array, ReceiveNum]) ->
    ArrayBin = pt:pack_array(Array, [u32, u64, string, u16, u8, u32]),
    {ok, pt:pack(?PT_GET_XS_TASK_INFO, <<Page:16, AllPage:16, ArrayBin/binary, ReceiveNum:8>>)};

write(?PT_ISSUE_XS_TASK, [Code, LeftIssueNum]) ->
    {ok, pt:pack(?PT_ISSUE_XS_TASK, <<Code:8, LeftIssueNum:8>>)};

write(?PT_RECEIVE_XS_TASK, [Code]) ->
    {ok, pt:pack(?PT_RECEIVE_XS_TASK, <<Code:8>>)};

write(?PT_GET_LEFT_ISSUE_NUM, [LeftIssueNum, IssueNum]) ->
    {ok, pt:pack(?PT_GET_LEFT_ISSUE_NUM, <<LeftIssueNum:8, IssueNum:8>>)};

write(?PT_IS_CAN_RECEIVE_XS_TASK, [Code]) ->
    {ok, pt:pack(?PT_IS_CAN_RECEIVE_XS_TASK, <<Code:8>>)};

write(?PT_IS_CAN_GET_REWARD_BY_TIMES, [Code]) ->
    {ok, pt:pack(?PT_IS_CAN_GET_REWARD_BY_TIMES, <<Code:8>>)};

write(?PT_ERNIE_GET, [Code]) ->
    {ok, pt:pack(?PT_ERNIE_GET, <<Code:8>>)};

write(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]),
    {error, not_match}.


pack_mark([]) -> <<0:16>>;
pack_mark(Mark) ->
    Len = erlang:length(Mark),
    List = [pack_mark_1(MarkItem) || MarkItem <- Mark],
    Bin = list_to_binary(List),
    <<Len:16, Bin/binary>>.

pack_mark_1([Event, State, SceneId, DunId, NpcId, TarList, CurNum, TolNum | _]) when is_list(TarList) ->
    TarId = case TarList =:= [] of
        true -> 0;
        false -> [Tar | _] = TarList, Tar
    end,
    <<Event:16, State:8, SceneId:32, DunId:32, NpcId:32, TarId:32, CurNum:16, TolNum:16>>;
pack_mark_1([Event, State, SceneId, DunId, NpcId, TarId, CurNum, TolNum | _]) ->
    <<Event:16, State:8, SceneId:32, DunId:32, NpcId:32, TarId:32, CurNum:16, TolNum:16>>.

read_array(0, _) -> [];
read_array(1, <<Id:64, Num:16, _/binary>>) -> [{Id, Num}];
read_array(Len, <<Id:64, Num:16, Left/binary>>) when Len > 0 ->
    [{Id, Num} | read_array(Len - 1, Left)];
read_array(_Len, _Msg) -> ?ERROR_MSG("task read 30004 client data no match , len = ~p, data = ~p~n", [_Len, _Msg]), [].
