%%%--------------------------------------
%%% @Module  : lib_comm
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2012.xx.xx
%%% @Description: 通用的函数
%%%--------------------------------------
-module(lib_comm).
-export([
        to_coord/1,
        to_coord/2,

        is_valid_money_type/1,
        is_valid_race/1,
        is_valid_faction/1,
        cost_money_now/3,

        is_now_nearby_midnight/0
    ]).

-include("common.hrl").
-include("record.hrl").
-include("faction.hrl").




%% 转为coord结构体
to_coord({X, Y}) ->
    #coord{x = X, y = Y}.


to_coord(X, Y) ->
    #coord{x = X, y = Y}.



%% 是否为有效的钱的类型？
is_valid_money_type(MoneyType) ->
    ?MNY_T_MIN =< MoneyType andalso MoneyType =< ?MNY_T_MAX.



%% 是否有效的种族代号？
is_valid_race(Race) ->
    ?RACE_MIN =< Race andalso Race =< ?RACE_MAX.


%% 是否为有效的门派代号？
is_valid_faction(Faction) ->
    ?FACTION_MIN =< Faction andalso Faction =< ?FACTION_MAX.




%% 当前时间是否处于午夜0点整左右？
%% @return: true | false
is_now_nearby_midnight() ->
    case erlang:time() of
        {23, 56, _} -> true;
        {23, 57, _} -> true;
        {23, 58, _} -> true;
        {23, 59, _} -> true;
        {0, 0, _} -> true;
        {0, 1, _} -> true;
        {0, 2, _} -> true;
        {0, 3, _} -> true;
        _ -> false
    end.

   








% %% exports
% %% desc: 确保为list类型
% %% returns: list()
% make_sure_list(Data) ->
%     case is_list(Data) of
%         true -> 
%             Data;
%         false when is_binary(Data) ->
%             binary_to_list(Data);
%         _ ->
%             []
%     end.

% make_sure_binary(Data) ->
%     case is_binary(Data) of
%         true ->
%             Data;
%         false when is_list(Data) ->
%             list_to_binary(Data);
%         _ ->
%             <<>>
%     end.

% make_sure_float(Num) when is_integer(Num) ->
%     Num * 1.0;
% make_sure_float(Num) when is_float(Num) ->
%     Num;
% make_sure_float(_Other) ->
%     0.0.


cost_money_now(PS, MoneyList, LogInfo) ->
    case length(MoneyList) of
        0 -> skip;
        1 ->
            {MoneyType1, Money1} = lists:nth(1, MoneyList),
            player_syn:cost_money(PS, MoneyType1, Money1, LogInfo);
        2 ->
            {MoneyType1, Money1} = lists:nth(1, MoneyList),
            {MoneyType2, Money2} = lists:nth(2, MoneyList),
            PS1 = player_syn:cost_money(PS, MoneyType1, Money1, LogInfo),
            player_syn:cost_money(PS1, MoneyType2, Money2, LogInfo)
    end.





















	
	
% %% 添加物品到本地节点的ets
% %% @para: GoodsAttrList => 物品的附加属性信息列表
% add_online_goods_to_local_ets(GoodsInfo, _GoodsAttrList) ->   % todo 保险起见，加载缓存时将附加属性重新加载
%     ets:insert(?ETS_GOODS_ONLINE(GoodsInfo#goods.player_id), GoodsInfo),
%     lib_attribute:load_equip_attr_into_ets(GoodsInfo#goods.player_id, GoodsInfo#goods.id).

%% add_online_goods_to_local_ets(GoodsInfo, GoodsAttrList) ->
%% 	ets:insert(?ETS_GOODS_ONLINE(GoodsInfo#goods.player_id), GoodsInfo),
%% 	F = fun(X) ->
%% 			ets:insert(?ETS_GOODS_ATTRIBUTE(GoodsInfo#goods.player_id), X)
%% 		end,
%% 	lists:foreach(F, GoodsAttrList).
	
	
% %% 从本地节点的ets删除物品
% %% @GoodsUniId: 物品唯一id
% del_online_goods_from_local_ets({PS, GoodsUniId}) ->
%     EtsAttrName = ?ETS_GOODS_ATTRIBUTE(PS),
%     ets:delete(?ETS_GOODS_ONLINE(PS), GoodsUniId),
%     ets:match_delete(EtsAttrName, #goods_attribute{gid = GoodsUniId, _ = '_'}),
%     %% TODO:以下代码仅用于调试验证，以后可以删掉  ---- huangjf
%     MatchRes = ets:match_object(EtsAttrName, #goods_attribute{gid = GoodsUniId, _ = '_'}),
%     ?ASSERT(MatchRes =:= []).
    

	
    
    

% %% 属性列表转换到基础属性记录，以方便重算玩家或武将的属性
% %% 注意：参数AttrList的顺序为：[hp_lim, phy_att, mag_att, spr_att, phy_def, mag_def, spr_def, hit, dodge, crit, block]
% convert_to_base_attr_record(AttrList) when is_list(AttrList) ->
%     [HpLim, PhyAtt, MagAtt, SprAtt, PhyDef, MagDef, SprDef, Hit, Dodge, Crit, Block] = AttrList,
%     #base_attri{
%     	hp_lim = HpLim,
%     	phy_att = PhyAtt,
%     	mag_att = MagAtt,
%     	spr_att = SprAtt,
%     	phy_def = PhyDef,
%     	mag_def = MagDef,
%     	spr_def = SprDef,
%     	hit = Hit,
%     	dodge = Dodge,
%     	crit = Crit,
%     	block = Block
%     	};
% convert_to_base_attr_record(PS) when is_record(PS, player_status) ->
%         #base_attri{
%         hp_lim = PS#player_status.hp_lim,
%         phy_att = PS#player_status.phy_att,
%         mag_att = PS#player_status.mag_att,
%         spr_att = PS#player_status.spr_att,
%         phy_def = PS#player_status.phy_def,
%         mag_def = PS#player_status.mag_def,
%         spr_def = PS#player_status.spr_def,
%         hit = PS#player_status.hit,
%         dodge = PS#player_status.dodge,
%         crit = PS#player_status.crit,
%         block = PS#player_status.block
%         }.


% %% desc: 取记录体信息
% %% @spec get_ets_info(Tab, Id) 
% %% returns: {} | record()
% get_ets_info(Tab, Input) ->
%     L = if
%             is_integer(Input) ->
%                 ets:lookup(Tab, Input);
%             tuple_size(Input) =:= 2 ->
%                 case element(1, Input) of
%                     Atom when is_atom(Atom) -> 
%                         ?INFO_MSG("lib_common  get_ets_info tuple key:~p", [Input]);
%                     _ -> skip
%                 end,
%                 ets:lookup(Tab, Input);   % 用{A, B}作为主键
%             true ->
%                 Pattern = handle_goods_pattern(Input),
%                 ets:match_object(Tab, Pattern)
%         end,
%     case L of
%         [Info|_] -> Info;
%         _ -> {}
%     end.

% %% desc: 取记录体列表
% %% returns: [] | List
% get_ets_list(Tab, Pattern) ->
%     NewPattern = handle_goods_pattern(Pattern),
%     L = ets:match_object(Tab, NewPattern),
%     case is_list(L) of
%         true -> L;
%         false -> []
%     end.

% %% internal
% %% desc:
% handle_goods_pattern(Pattern) when is_record(Pattern, goods) ->
%     Tid = Pattern#goods.goods_id,
%     case is_integer(Tid) andalso Tid > 0 of
%         true ->   % 有按物品类型ID进行匹配
%             case goods_convert:is_config_tid(Tid) of
%                 true ->
%                     case goods_convert:get_opp_tid(Tid) of
%                         0 ->        Pattern;   % 该物品没有对应的非绑定类型ID
%                         NewTid -> Pattern#goods{goods_id = NewTid}
%                     end;
%                 false ->
%                     Pattern
%             end;
%         false ->
%             Pattern
%     end;
% handle_goods_pattern(Pattern) -> Pattern.



% %% exports
% %% desc: 计算从当前时刻到指定时间的间隔(以秒为单位，且仅限制在同一天内)
% calc_diff_seconds({CurH, CurM, CurS}, {H, M, S}) ->
%     CurSec = CurH * ?ONE_HOUR_SECONDS + CurM * ?ONE_MINUTE_SECONDS + CurS,
%     Sec = H * ?ONE_HOUR_SECONDS + M * ?ONE_MINUTE_SECONDS + S,
%     case Sec >= CurSec of
%         true ->            Sec - CurSec;
%         false ->           -1
%     end.
 
    
    
% %% exports
% %% desc: 判断指定日期是否是连续日
% %% returns: true | false
% %% lib_common:is_con_date
% is_con_date({0, 0, 0}, _Date2) ->
%     false;
% is_con_date(_Date1, {0, 0, 0}) ->
%     false;
% is_con_date(Date1, Date2) ->
%     Diff1 = calendar:date_to_gregorian_days(Date1),
%     Diff2 = calendar:date_to_gregorian_days(Date2),
%     abs( Diff1 - Diff2 ) =:= 1.
                        
    

%% 取多条记录
%% @spec get_list(Field, Data) -> list()
%% get_list(Table, Sql) ->
%%     List = (catch db:get_all(Sql)),
%%     case is_list(List) of
%%         true when List =/= [] ->     lists:map(fun(FieldsList) -> goods_util:make_info(Table, FieldsList) end, List);
%%         _ ->                            []
%%     end.


% %% 根据等级获取在线玩家ID 世界节点
% %% 仅一个进程服务，切匆频繁调用。
% get_ids_by_level_world(MinLv, MaxLv) ->
%     gen_server:call({global, ?GLOBAL_AFFICHE}, {apply_call, ?MODULE, get_ids_by_level, [MinLv, MaxLv]}).

% %% 根据等级获取在线玩家ID
% get_ids_by_level(_MinLv, _MaxLv) ->
% 	todo_here.

% %% 根据等级获取在线玩家PID
% get_pids_by_level(_MinLv, _MaxLv) ->
% 	todo_here.
