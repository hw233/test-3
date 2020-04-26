%%%------------------------------------------------
%%% File    : phone.hrl
%%% Author  : huangjf 
%%% Created : 2014.8.13
%%% Description: 手机信息
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__PHONE_H__).
-define(__PHONE_H__, 0).






%% 手机信息
-record(phone_info, {
        model = "",   % 手机型号
        mac = ""      % 手机MAC地址
    }).





-define(MAX_PHONE_MODEL_STR_LEN, 40).

-define(MAX_PHONE_MAC_STR_LEN, 17).








-endif.  %% __PHONE_H__
