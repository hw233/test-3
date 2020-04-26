-ifndef(__MONOPOLY_HRL__).
-define(__MONOPOLY_HRL__, monopoly_hrl).

%% ets_desire_integral_pool
%% ets_luck_player_info
%% ets_lottery_record


-record(monopoly, {
    type = 0,
    probability = []
}).

-record(monopoly_event, {
    no = 1,
    event = [nocontrol,1],
    reward = []
}).

-record(monopoly_reward, {
    no = 0,
    type = 0,
    number = [],
    probability = [],
    bind = 0
}).

-record(monopoly_monreward, {
    mon = 0,
    reward = []
}).

-record(monopoly_endreward, {
    no = 0,
    reward = 0
}).


-endif.