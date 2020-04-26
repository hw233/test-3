%%%------------------------------------
%%% @Module  : mod_gm
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.07.03
%%% @Description: gm指令
%%%------------------------------------
-module(mod_gm).       %% 本文件作废，gm指令的处理见lib_gm.erl
% %% -export([gm_command/2]).

% -include("common.hrl").
% -include("record.hrl").
% -compile(export_all).

% %% 执行GM命令 spec {ok, NewState}|false 
% %% make 10001 1 >> 制造物品命令 物品ID 数量
% %% coin 10000  >>加金币命令 数量
% %% level 50 >> 设置等级命令 等级
% gm_command(Status, [Data]) ->
%     %% C = string:tokens(erlang:bitstring_to_list(Data), " "),
%     C = string:tokens(Data, " "),
%     case catch do_cmd(C, Status) of
%         {ok, NewRole} ->
%             {ok, NewRole};
%         {false, Reason} ->
%             ?TRACE("gm_command_false_reson:~p~n", [Reason]),
%             false;
%         Err ->
%             ?TRACE("gm_command_err:~p~n", [Err]),
%             false
%     end.

% %% 制造物品
% do_cmd(["make", BaseId], Status) -> do_cmd(["make", BaseId, "1"], Status);  
% do_cmd(["make", BaseId, Num], Status = #player_status{id = Id}) ->
%     GoodsTypeInfo = lib_common:get_ets_info(?ETS_GOODS_TYPE, to_int(BaseId)),
%     NewInfo = lib_goods:convert_basegoods_to_goods(GoodsTypeInfo),
%     GoodsInfo = NewInfo#goods{player_id=Id, location=4, cell=1, num=to_int(Num)},
%     (catch lib_goods:add_goods(GoodsInfo)),
%     lib_player:refresh_client(Status), 
%    {ok, Status}; 

% %%    case item:make(to_int(BaseId), 0, to_int(Num)) of
% %%        false -> 
% %%            {false, <<"get items failure! the goodsId  is invalid">>};
% %%        {ok, Item} ->
% %%            case storage:add(bag, Status, Item) of
% %%                false -> {false, <<"Add items fail, may have full backpack">>};
% %%                {ok, NewBag} ->
% %%                    {ok, Status#player_status{bag = NewBag}}
% %%            end
% %%    end;

% %% 设置等级
% do_cmd(["level", Num], Status) ->
%     NewStatus = Status#player_status{lv = to_int(Num)},
%     lib_player:refresh_client(Status), 
%     {ok, NewStatus};

% %% 设金币
% do_cmd(["gold", Num], Status) ->
%     C = Status#player_status.gold + to_int(Num),
%     NewStatus = Status#player_status{gold = C},
%     lib_player:refresh_client(Status), 
%     {ok, NewStatus};

% %% 设银币（已作废）
% %%do_cmd(["silver", Num], Status) ->
% %%    C = Status#player_status.silver + to_int(Num),
% %%    NewStatus = Status#player_status{silver = C},
% %%    lib_player:refresh_client(Status), 
% %%    {ok, NewStatus};

% %% 加铜币
% do_cmd(["coin", Num], Status) ->
%     NewStatus = lib_money:add_coin(Status, to_int(Num)),
%     lib_player:refresh_client(Status), 
%     {ok, NewStatus};

% %% 加绑定铜币
% do_cmd(["bcoin", Num], Status) ->
%     C = Status#player_status.bcoin + to_int(Num),
%     NewStatus = Status#player_status{bcoin = C},
%     lib_player:refresh_client(Status), 
%     {ok, NewStatus};

% %% 增加经验
% do_cmd(["exp", Num], Status) ->
%     NewStatus = lib_player:add_exp(Status, to_int(Num)),
%     lib_player:refresh_client(Status), 
%     {ok, NewStatus};

% do_cmd(_Err, _Status) ->
%     ?TRACE("no matching command..."),
%     false.

% %% 转整数
% to_int(Val) when is_integer(Val) -> Val;
% to_int(Val) when is_binary(Val) -> to_int(binary_to_list(Val));
% to_int(Val) when is_list(Val) -> to_int(list_to_integer(Val));
% to_int(Val) when is_float(Val) -> to_int(float_to_list(Val));
% to_int(Val) -> Val.
