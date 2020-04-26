%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.12.10
%%% @doc 女妖结婚系统.
%%% @end
%%%------------------------------------

-module(pt_33).
-export([write/2, read/2]).

-include("common.hrl").
-include("pt_33.hrl").

%%---------------------------------------------
%% read 函数
%%---------------------------------------------
%% 申请结婚
read(?PT_COUPLE_APPLY_MARRIAGE, <<Type:8>>) ->
    {ok, [Type]};

%% 回应求婚
read(?PT_COUPLE_RESPOND_MARRIAGE, <<Respond:8>>) ->
    {ok, [Respond]};

%% 申请离婚
read(?PT_COUPLE_APPLY_DEVORCE, <<DevorceType:8>>) ->
    {ok, [DevorceType]};

read(?PT_COUPLE_REQ_STOP_CRUISE, _) ->
    {ok, []};    

read(?PT_COUPLE_QUERY_SKILL_INFO, _) ->
    {ok, []};        

read(?PT_COUPLE_LEARN_SKILL, <<SkillId:32>>) ->
    {ok, [SkillId]};            

read(?PT_COUPLE_APPLY_CRUISE, <<Type:8>>) ->
    {ok, [Type]};

read(?PT_COUPLE_REQ_JOIN_CRUISE, _) ->
    {ok, []};        

read(?PT_COUPLE_RESPOND_DEVORCE, <<Respond:8>>) ->
    {ok, [Respond]};            


read(?PT_COUPLE_CAR_POS, _) ->
    {ok, []};


read(?PT_COUPLE_FIREWORKS, _) ->
    {ok, []};    

read(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.

%%---------------------------------------------
%% write 函数
%%---------------------------------------------
%% 申请结婚
write(?PT_COUPLE_APPLY_MARRIAGE, [Code]) ->
    {ok, pt:pack(?PT_COUPLE_APPLY_MARRIAGE, <<Code:8>>)};

%% 求婚
write(?PT_COUPLE_ASK_MARRIAGE, [ObjPlayerName]) ->
    {ok, pt:pack(?PT_COUPLE_ASK_MARRIAGE, <<(byte_size(ObjPlayerName)) : 16, ObjPlayerName/binary>>)};

%% 结婚广播 （广播周围其他玩家结婚成功，在结婚玩家周围放烟花）
write(?PT_COUPLE_MARRIAGE_BROADCAST, [Type, Id1, Id2]) ->
    {ok, pt:pack(?PT_COUPLE_MARRIAGE_BROADCAST, <<Type:8, Id1:64, Id2:64>>)};


write(?PT_COUPLE_SHOW_FIREWORKS, [Type, SceneId, X, Y]) ->
    {ok, pt:pack(?PT_COUPLE_SHOW_FIREWORKS, <<Type:8, SceneId:32, X:32, Y:32>>)};    

write(?PT_COUPLE_REQ_STOP_CRUISE, [RetCode, Type]) ->
    {ok, pt:pack(?PT_COUPLE_REQ_STOP_CRUISE, <<RetCode:8, Type:8>>)};


write(?PT_COUPLE_QUERY_SKILL_INFO, [PlayerId]) ->
    RetList = 
        case ply_relation:get_spouse_id(PlayerId) =:= ?INVALID_ID of
            true -> [];
            false -> data_couple:get_type_list_by_key(learn_skill)
        end,
    HaveSkillL = ply_relation:get_couple_skill_id_list(PlayerId),

    F = fun(Id) ->
        State = 
            case lists:member(Id, HaveSkillL) of
                true -> 1;
                false -> 0
            end,
        <<Id:32, State:8>>
    end,
    Len = length(RetList),
    Data = list_to_binary([F(X) || X <- RetList]),
    {ok, pt:pack(?PT_COUPLE_QUERY_SKILL_INFO, <<Len:16, Data/binary>>)};    

write(?PT_COUPLE_LEARN_SKILL, [RetCode]) ->
    {ok, pt:pack(?PT_COUPLE_LEARN_SKILL, <<RetCode:8>>)};    


write(?PT_COUPLE_NOTIFY_CRUISE_BEGIN, [Type, NpcId]) ->
    {ok, pt:pack(?PT_COUPLE_NOTIFY_CRUISE_BEGIN, <<Type:8, NpcId:32>>)};    
        

write(?PT_COUPLE_REQ_JOIN_CRUISE, [RetCode]) ->
    {ok, pt:pack(?PT_COUPLE_REQ_JOIN_CRUISE, <<RetCode:8>>)}; 


write(?PT_COUPLE_APPLY_DEVORCE, [RetCode, Type]) ->
    {ok, pt:pack(?PT_COUPLE_APPLY_DEVORCE, <<RetCode:8, Type:8>>)}; 

write(?PT_COUPLE_ASK_DEVORCE, [ObjPlayerName]) ->
    {ok, pt:pack(?PT_COUPLE_ASK_DEVORCE, <<(byte_size(ObjPlayerName)) : 16, ObjPlayerName/binary>>)};         


write(?PT_COUPLE_DEVORCE_OK, _) ->
    {ok, pt:pack(?PT_COUPLE_DEVORCE_OK, <<>>)};    


write(?PT_COUPLE_BROADCAST_CRUISE_BEGIN, [PlayerName1, PlayerName2]) ->
    {ok, pt:pack(?PT_COUPLE_BROADCAST_CRUISE_BEGIN, <<(byte_size(PlayerName1)) : 16, PlayerName1/binary, (byte_size(PlayerName2)) : 16, PlayerName2/binary>>)};        

write(?PT_COUPLE_CAR_POS, [NpcId, SceneNo, X, Y]) ->
    {ok, pt:pack(?PT_COUPLE_CAR_POS, <<NpcId:32, SceneNo:32, X:32, Y:32>>)};            

write(?PT_COUPLE_CRUISE_STATE, _) ->
    {ok, pt:pack(?PT_COUPLE_CRUISE_STATE, <<>>)};        

write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.
