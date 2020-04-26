%%%---------------------------------------------
%%% @Module  : glt_npc (game logic test: NPC)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.9.25
%%% @Description: NPC相关的测试
%%%---------------------------------------------
-module(glt_npc).

-compile(export_all).

-include("common.hrl").
-include("test_client_base.hrl").
-include("npc.hrl").
-include("pt_32.hrl").


%% 查询npc的功能列表
query_npc_func_list(NpcId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<NpcId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_QRY_NPC_FUNC_LIST, Data)),
    ok.



% %% 查询npc的传送列表
% query_npc_teleport_list(NpcId) ->
%     Socket = get(?PDKN_CONN_SOCKET),
%     Data = <<NpcId:32>>,
%     gen_tcp:send(Socket, test_client_base:pack(?PT_QRY_NPC_TELEPORT_LIST, Data)),
%     ok.


%% 查询npc的教授技能列表
query_npc_teach_skill_list(NpcId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<NpcId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_QRY_NPC_TEACH_SKILL_LIST, Data)),
    ok.


% %% 查询npc的副本编号列表
% query_npc_dungeon_list(NpcId) ->
%     Socket = get(?PDKN_CONN_SOCKET),
%     Data = <<NpcId:32>>,
%     gen_tcp:send(Socket, test_client_base:pack(?PT_QRY_NPC_DUNGEON_LIST, Data)),
%     ok.


%% 从npc商店购买物品
buy_goods_from_npc(NpcId, GoodsNo, Count) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<NpcId:32, GoodsNo:32, Count:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BUY_GOODS_FROM_NPC, Data)),
    ok.



start_mf_by_talk_to_npc(NpcId, BMonGroupNo) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<NpcId:32, BMonGroupNo:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_START_MF_BY_TALK_TO_NPC, Data)),
    ok.


    













read(?PT_QRY_NPC_FUNC_LIST, Bin, _Fd) ->
    io:format("client read: PT_QRY_NPC_FUNC_LIST~n"),
    <<NpcId:32, FuncCount:16, Bin2/binary>> = Bin,

    % F = fun(Bin_) ->
    %         <<FuncCode:8, Bin2_/binary>> = Bin_,
    %         BinLeft = case FuncCode of
    %             ?NPC_FUNC_CODE_SELL_GOODS ->
    %                 <<NpcShopNo:32, Bin3_/binary>> = Bin2_,
    %                 io:format("    sell goods, NpcShopNo=~p~n", [NpcShopNo]),
    %                 Bin3_;
    %             ?NPC_FUNC_CODE_TELEPORT ->
    %                 {TeleportNoList, Bin3_} = pt:read_array(Bin2_, [u32]),
    %                 io:format("    teleport, TeleportNoList=~p~n", [TeleportNoList]),
    %                 Bin3_;
    %             ?NPC_FUNC_CODE_STREN_EQUIP ->
    %                 io:format("    stren equip~n"),
    %                 Bin2_;
    %             ?NPC_FUNC_CODE_TEACH_SKILLS ->
    %                 {SkillIdList, Bin3_} = pt:read_array(Bin2_, [u32]),
    %                 io:format("    teach skills, SkillIdList=~p~n", [SkillIdList]),
    %                 Bin3_
    %         end,
    %         BinLeft
    %     end,

    F = fun(Bin_) ->
            <<FuncCode:8, FuncArg:32, Bin2_/binary>> = Bin_,
            case FuncCode of
                ?NPCF_CODE_SELL_GOODS ->
                    io:format("    sell goods, NpcShopNo=~p~n", [FuncArg]);
                ?NPCF_CODE_TELEPORT ->
                    io:format("    teleport, TeteportNo=~p~n", [FuncArg]);
                ?NPCF_CODE_STREN_EQUIP ->
                    io:format("    stren equip~n");
                ?NPCF_CODE_TEACH_SKILLS ->
                    io:format("    teach skills~n");
                ?NPCF_CODE_DUNGEON ->
                    io:format("    dungeon~n");
                ?NPCF_CODE_TRIGGER_MF ->
                    io:format("    trigger mf, BMonGroupNo=~p~n", [FuncArg])
            end,
            Bin2_
        end,

    io:format("***npc func list (NpcId=~p FuncCount=~p)***:~n", [NpcId, FuncCount]),    
    <<>> = test_client_base:for(0, FuncCount, F, Bin2);




% read(?PT_QRY_NPC_TELEPORT_LIST, Bin, _Fd) ->
%     io:format("client read: PT_QRY_NPC_TELEPORT_LIST~n"),
%     <<NpcId:32, Bin2/binary>> = Bin,
%     {TeleportNoList, <<>>} = pt:read_array(Bin2, [u32]),
%     io:format("    NpcId=~p TeleportNoList=~p~n", [NpcId, TeleportNoList]);




read(?PT_QRY_NPC_TEACH_SKILL_LIST, Bin, _Fd) ->
    io:format("client read: PT_QRY_NPC_TEACH_SKILL_LIST~n"),
    <<NpcId:32, Bin2/binary>> = Bin,
    {SkillIdList, <<>>} = pt:read_array(Bin2, [u32]),
    io:format("    NpcId=~p SkillIdList=~p~n", [NpcId, SkillIdList]);


% read(?PT_QRY_NPC_DUNGEON_LIST, Bin, _Fd) ->
%     io:format("client read: PT_QRY_NPC_DUNGEON_LIST~n"),
%     <<NpcId:32, Bin2/binary>> = Bin,
%     {DungeonNoList, <<>>} = pt:read_array(Bin2, [u32]),
%     io:format("    NpcId=~p DungeonNoList=~p~n", [NpcId, DungeonNoList]);


read(?PT_BUY_GOODS_FROM_NPC, Bin, _Fd) ->
    io:format("client read: PT_BUY_GOODS_FROM_NPC~n"),
    <<RetCode:8, GoodsNo:32, Count:8>> = Bin,
    io:format("RetCode=~p, GoodsNo=~p, Count=~p~n", [RetCode, GoodsNo, Count]);


read(Cmd, Bin, _Fd) ->
    io:format("[glt_npc] default read handler!!!!!~n", []),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).
