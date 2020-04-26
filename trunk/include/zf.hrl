%%%--------------------------------------------------------
%%% @author 
%%% @doc 阵法系统
%%%
%%% @end
%%%--------------------------------------------------------

-record(zf_cfg, {
        no = 0
        ,zf_lv = 1
        ,cnt_limit = 0
        ,type = 0
        ,zf_battle_pos = []
        ,zf_goods = []
        ,pre_zf = []
        ,pos_attr_1 = []
        ,pos_attr_2 = []
        ,pos_attr_3 = []
        ,pos_attr_4 = []
        ,pos_attr_5 = []
        ,zf_def_attr = []
    }). 


%% 阵法相克属性加成
-record(zf_def_attr_cfg, {
        no_1 = 0,    
        no_2 = 0,
        zf_def_attr = 0
    }).