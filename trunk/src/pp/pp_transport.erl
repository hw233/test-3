-module(pp_transport).

-export([handle/3]).

-include("common.hrl").
-include("record.hrl").
-include("transport.hrl").
-include("prompt_msg_code.hrl").

handle(42001, Status, _) ->
    lib_transport:get_all_transport_truck_info(Status),
    ok;

handle(42004, Status, [RoleId]) ->
    case lib_transport:get_truck_info(RoleId) of
        Truck when is_record(Truck, truck) -> 
            lib_transport:push_single_truck_info(Status, Truck);
        null -> lib_send:send_prompt_msg(Status, ?PM_TS_TRUCK_NOTEXISTS)
    end,
    ok;

handle(42005, Status, _) ->
    lib_transport:push_role_transport_info(Status),
    ok;

handle(42006, Status, _) ->
    case player:is_idle(Status) andalso (player:get_lv(Status) >= ply_sys_open:get_sys_open_lv(?TS_TRUCK_SYSCODE)) of
        true ->
            mod_achievement:notify_achi(transport, [], Status),
            State = ?BIN_PRED(lib_transport:start_transport(Status), 1, 0), 
            {ok, BinData} = pt_42:write(42006, [State]),
            lib_send:send_to_uid(player:id(Status), BinData);
        _ -> lib_send:send_prompt_msg(Status, ?PM_BUSY_NOW)
    end,
    ok;

handle(42007, Status, _) ->
    lib_transport:evolve_truck_with_money(Status),
    ok;

handle(42008, Status, _) ->
    lib_transport:evolve_truck_with_goods(Status),
    ok;

handle(42009, Status, _) ->
    lib_transport:direct_evolve_truck(Status),
    ok;

handle(42010, Status, [TruckId]) ->
    case player:is_idle(Status) andalso 
        player:get_lv(Status) >= ply_sys_open:get_sys_open_lv(?TS_TRUCK_SYSCODE) andalso
        ( not lib_scene:is_melee_scene(player:get_scene_id(Status)) ) of % 新增在女妖乱斗场景不能操作劫镖
        true -> lib_transport:hijack_truck(Status, TruckId);
        false -> lib_send:send_prompt_msg(Status, ?PM_BUSY_NOW)
    end,
    ok;   

handle(42011, Status, _) ->
    lib_transport:refresh_truck(Status),
    ok;

handle(42012, Status, _) ->
    lib_transport:evolve_truck_free(Status),
    ok;

handle(_Cmd, _Status, _) ->
    ?ASSERT(false, [_Cmd]),
    not_match.