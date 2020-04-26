%%%-----------------------------------
%%% @Module  : pt_32
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.06.13
%%% @Description: 32 NPC模块
%%%-----------------------------------
-module(pt_32).
-export([read/2, write/2]).

-include("protocol/pt_32.hrl").
-include("debug.hrl").
-include("npc.hrl").
-include("record/goods_record.hrl").
-include("trade.hrl").

%%
%%客户端 -> 服务端 ----------------------------
%%

read(?PT_QRY_NPC_FUNC_LIST, <<NpcId:32>>) ->
    {ok, NpcId};

% read(?PT_QRY_NPC_TELEPORT_LIST, <<NpcId:32>>) ->
%     {ok, NpcId};

read(?PT_QRY_NPC_TEACH_SKILL_LIST, <<NpcId:32>>) ->
    {ok, NpcId};

% read(?PT_QRY_NPC_DUNGEON_LIST, <<NpcId:32>>) ->
%     {ok, NpcId};


read(?PT_BUY_GOODS_FROM_NPC, <<NpcId:32, GoodsNo:32, Count:8, ShopNo:32>>) ->
    {ok, [NpcId, GoodsNo, Count, ShopNo]};


read(?PT_QUERY_GOODS_BY_NPC, <<NpcId:32, ShopNo:32>>) ->
    {ok, [NpcId, ShopNo]};


read(?PT_QRY_BUY_BACK_LIST, _) ->
    {ok, []};


read(?PT_BUY_BACK, <<GoodsId:64, StackCount:16>>) ->
    {ok, [GoodsId, StackCount]};


read(?PT_COLLECT_OK, <<NpcId:32>>) ->
    {ok, [NpcId]};

read(?PT_EXCHANGE_GOODS_FROM_NPC, <<NpcId:32, No:32>>) ->
    {ok, [NpcId, No]};

%% 
read(?PT_START_MF_BY_TALK_TO_NPC, <<NpcId:32, BMonGroupNo:32>>) ->
    {ok, [NpcId, BMonGroupNo]};



read(?PT_TALK_TO_MON, <<MonId:32, Difficulty:8>>) ->
    {ok, [MonId, Difficulty]};


read(?PT_EXCHANGE_SPECIAL_GOODS_FROM_NPC, <<NpcId:32, No:32,Num:16>>) ->
    {ok, [NpcId, No, Num]};

read(?PT_BUY_GOODS_FROM_CREDIT_NPC, <<Id:8, Count:8>>) ->
    {ok, [Id, Count]};



% %% 获得npc任务对话
% read(32001, <<NpcId:32, TaskId:32>>) ->
%     {ok, [NpcId, TaskId]};

read(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.










%%
%%服务端 -> 客户端 ------------------------------------
%%

write(?PT_QRY_NPC_FUNC_LIST, [NpcId, FuncList]) ->
    % TaskList_Bin = pack_talk_task_list(TaskList),
    %%BinB = pack_talk(TalkList),

    FuncCount = length(FuncList),
    FuncList_Bin = list_to_binary(FuncList),
    Data = <<NpcId:32, FuncCount:16, FuncList_Bin/binary>>,
    {ok, pt:pack(?PT_QRY_NPC_FUNC_LIST, Data)};


% write(?PT_QRY_NPC_TELEPORT_LIST, [NpcId, TeleportNoList]) ->
%     Count = length(TeleportNoList),
%     Bin = list_to_binary( [<<X:32>> || X <- TeleportNoList] ),
%     Bin2 = <<NpcId:32, Count:16, Bin/binary>>,
%     {ok, pt:pack(?PT_QRY_NPC_TELEPORT_LIST, Bin2)};



write(?PT_QRY_NPC_TEACH_SKILL_LIST, [NpcId, SkillIdList]) ->
    Count = length(SkillIdList),
    Bin = list_to_binary( [<<X:32>> || X <- SkillIdList] ),
    Bin2 = <<NpcId:32, Count:16, Bin/binary>>,
    {ok, pt:pack(?PT_QRY_NPC_TEACH_SKILL_LIST, Bin2)};




% write(?PT_QRY_NPC_DUNGEON_LIST, [NpcId, DungeonNoList]) ->
%     Count = length(DungeonNoList),
%     Bin = list_to_binary( [<<X:32>> || X <- DungeonNoList] ),
%     Bin2 = <<NpcId:32, Count:16, Bin/binary>>,
%     {ok, pt:pack(?PT_QRY_NPC_DUNGEON_LIST, Bin2)};




write(?PT_BUY_GOODS_FROM_NPC, [RetCode, GoodsNo, Count]) ->
    {ok, pt:pack(?PT_BUY_GOODS_FROM_NPC, <<RetCode:8, GoodsNo:32, Count:8>>)};


write(?PT_QUERY_GOODS_BY_NPC, [PlayerId, NpcId, NpcShopGoodsInfoL]) ->
    List = lib_shop:pack_dynamic_goods_list(PlayerId, ?SHOP_TYPE_NPC, NpcShopGoodsInfoL),
    Len = length(List),
    Bin = list_to_binary(List),
    BinData = <<NpcId:32, Len:16, Bin/binary>>,
    {ok, pt:pack(?PT_QUERY_GOODS_BY_NPC, BinData)};


write(?PT_QRY_BUY_BACK_LIST, [GoodsList]) ->
    Len = length(GoodsList),
    F = fun(Goods) ->
        <<
            (Goods#goods.id) : 64,
            (Goods#goods.no) : 32,
            (Goods#goods.count) : 16,   
            (Goods#goods.bind_state) : 8,
            (Goods#goods.quality) : 8,
            (Goods#goods.usable_times) : 16,
            (Goods#goods.sell_time) : 32
        >>
    end,
    Bin = list_to_binary([F(X) || X <- GoodsList]),
    BinData = <<Len:16, Bin/binary>>,
    {ok, pt:pack(?PT_QRY_BUY_BACK_LIST, BinData)};


write(?PT_BUY_BACK, [RetCode, GoodsId, StackCount]) ->
    {ok, pt:pack(?PT_BUY_BACK, <<RetCode:8, GoodsId:64, StackCount:16>>)};

      
write(?PT_NOTIFY_BUY_BACK_GOODS_ADDED, [Goods]) ->
    BinData = 
    <<
        (Goods#goods.id) : 64,
        (Goods#goods.no) : 32,
        (Goods#goods.count) : 16,   
        (Goods#goods.bind_state) : 8,
        (Goods#goods.quality) : 8,
        (Goods#goods.usable_times) : 16,
        (Goods#goods.sell_time) : 32
    >>,
    {ok, pt:pack(?PT_NOTIFY_BUY_BACK_GOODS_ADDED, BinData)};
    

write(?PT_NOTIFY_BUY_BACK_GOODS_DESTROYED, [GoodsId]) ->
    {ok, pt:pack(?PT_NOTIFY_BUY_BACK_GOODS_DESTROYED, <<GoodsId:64>>)};

    

write(?PT_EXCHANGE_GOODS_FROM_NPC, [RetCode, No]) ->
    {ok, pt:pack(?PT_EXCHANGE_GOODS_FROM_NPC, <<RetCode:32, No:32>>)};    

% %% NPC任务对话
% write(32001, [Id, TaskId, Type, TalkList]) ->
%     Bin = pack_talk(TalkList),
%     Data = <<Id:32, TaskId:32, Type:32, Bin/binary>>,
%     {ok, pt:pack(32001, Data)};






write(?PT_TALK_TO_MON, [FailCode, _ExtraInfoList, MonId, Difficulty]) ->
    {ok, pt:pack(?PT_TALK_TO_MON, <<FailCode:8, MonId:32, Difficulty:8>>)};


write(?PT_EXCHANGE_SPECIAL_GOODS_FROM_NPC, [RetCode, No]) ->
    {ok, pt:pack(?PT_EXCHANGE_SPECIAL_GOODS_FROM_NPC, <<RetCode:32, No:32>>)};

write(?PT_BUY_GOODS_FROM_CREDIT_NPC, [RetCode, Id]) ->
    {ok, pt:pack(?PT_BUY_GOODS_FROM_CREDIT_NPC, <<RetCode:8, Id:8>>)};







write(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.





%% ----- 私有函数 -------

% %% 打包对话数据
% %% 数据格式[[{npc,<<"测试">>,[]},{yes,<<"后会有期">>,[]}]]
% pack_talk([]) ->
%     <<0:16, <<>>/binary>>;
% pack_talk(TalkList) ->
%     Bin = [pack_talk_item(X) || X<- TalkList],
%     Len = length(TalkList),
%     list_to_binary([<<Len:16>>, Bin]).
% pack_talk_item(Item) ->
%     Bin = [pack_talk_answer_item(X) || X<- Item],
%     Len = length(Item),
%     list_to_binary([<<Len:16>>, Bin]).
% pack_talk_answer_item({Type, Text, Ex}) ->
%     TypeInt = data_talk:type_to_int(Type),
%     TLen = byte_size(Text),
%     ExBin = list_to_binary(util:implode("#&", Ex)),
%     ExL = byte_size(ExBin),
%     list_to_binary([<<TypeInt:16, TLen:16>>, Text, <<ExL:16, ExBin/binary>> ]).


% %% 打包对话里的任务列表
% %% 数据格式:[任务id,状态(1:可接，2：关联，3：未完成，4：已完成),名称]
% pack_talk_task_list([]) ->
%     <<0:16, <<>>/binary>>;
% pack_talk_task_list(TaskList) ->
%     L = [pack_talk_task_list(TaskId, State, Type, Name)|| [TaskId, State, Type, Name] <- TaskList],
%     Len = length(TaskList),
%     list_to_binary([<<Len:16>>, L]).
% pack_talk_task_list(TaskId, State, Type, Name) ->
%     NL = byte_size(Name),
%     <<TaskId:32, State:8, Type:8, NL:16, Name/binary>>.