%% Author: Administrator
%% Created: 2012-8-13
%% Description: TODO: Add description to data_send_stren_goods
-module(data_send_stren_goods).

-export([get/1]).

get(100102547) -> {3, 100};
get(100104547) -> {3, 100};
get(100105547) -> {3, 100};
get(100108547) -> {3, 100};

%% 
get(_) -> {0, 0}.
     