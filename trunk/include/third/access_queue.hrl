-ifndef(__ACCESS_QUEUE_H__).
-define(__ACCESS_QUEUE_H__, 0).

-define(ACC_QUEUE_DYNC_TUNE, app_opt:get_env(acc_queue_dync_tune, false)).
-define(ACC_QUEUE_TUNE_INTV, 30000).

-define(MIN_PLAY_OL_NUM, app_opt:get_env(min_play_ol_num, 1)).
-define(NOR_PLAY_OL_NUM, app_opt:get_env(nor_play_ol_num, 4)).
-define(MAX_PLAY_OL_NUM, app_opt:get_env(max_play_ol_num, 5)).
-define(MAX_WAIT_OL_NUM, app_opt:get_env(max_wait_ol_num, 5000)).

-define(CALC_WAIT_CVAL(PlayOlNum), 10).
-define(CALC_PLAY_CVAL(CurrMaxPlayOlNum), trunc(CurrMaxPlayOlNum * 0.9)).

-define(CALC_ADD_MAX_OL(PlayOlNum, WaitNum), min(?MAX_PLAY_OL_NUM, PlayOlNum + min(WaitNum, 100))).
-define(CALC_SUB_MAX_OL(PlayOlNum), PlayOlNum).

-endif.