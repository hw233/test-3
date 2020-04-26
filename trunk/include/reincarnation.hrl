-ifndef(__REINCARNATION_HRL__).
-define(__REINCARNATION__, reincarnation_hrl).


-record(peak_level_limit, {
    d_lv = 0,
    d_exp_lim = 0
}).

-record(reincarnation_shop, {
    id = 0,
    good = [],
    buy_count_limit = 0,
    price_type = 0,
    price = 0
}).

-endif.