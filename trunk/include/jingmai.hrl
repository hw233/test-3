%% =============================================
%% @Module     : jingmai.hrl
%% @Author     : duanshihe
%% @CreateDate : 2014-12-03
%% @Encoding   : UTF-8
%% @Desc       : 
%% =============================================

-ifndef(__JINGMAI_HRL). 
-define(__JINGMAI_HRL, 0). 

-record(jinmai_config, {
    no = 0,
	class = 0,
	lv = 0,
	limit_1 = 1,
	add_attr = []
    }).

-record(jingmai_exchange_config, {
    id = 0,
	cost = [],
	count = 0,
	price = 0,
	wash_price = 0
    }).


% 经脉信息
-record(jingmai_info, {
    class = 0,
	point = 0
    }).

-endif.