%%%---------------------------------------
%%% @Module  : data_dungeon_plot.erl
%%% @Author  : lds
%%% @Email   : 
%%% @Description:  
%%%---------------------------------------


-module(data_dungeon_plot).
-include("common.hrl").
-include("dungeon_plot.hrl").
-compile(export_all).

 
get_dungeon_plot(1011) -> 
    #dungeon_plot{
        no = 1011                  
        ,lv = 12
        ,first_rid = 15004
        ,first_extra_rid = [{add_pet_pos, 1}]
        ,normal_rid = 15030
        ,times = 99     
    }       
        ;
 
get_dungeon_plot(1021) -> 
    #dungeon_plot{
        no = 1021                  
        ,lv = 20
        ,first_rid = 15005
        ,first_extra_rid = [{add_pet_pos, 1}]
        ,normal_rid = 15031
        ,times = 99     
    }       
        ;
 
get_dungeon_plot(1031) -> 
    #dungeon_plot{
        no = 1031                  
        ,lv = 30
        ,first_rid = 15006
        ,first_extra_rid = [{add_pet_pos, 1}]
        ,normal_rid = 15032
        ,times = 99     
    }       
        ;
 
get_dungeon_plot(1041) -> 
    #dungeon_plot{
        no = 1041                  
        ,lv = 40
        ,first_rid = 15007
        ,first_extra_rid = [{add_pet_pos, 1}]
        ,normal_rid = 15033
        ,times = 99     
    }       
        ;
 
get_dungeon_plot(1051) -> 
    #dungeon_plot{
        no = 1051                  
        ,lv = 50
        ,first_rid = 15008
        ,first_extra_rid = []
        ,normal_rid = 15034
        ,times = 99     
    }       
        ;
 
get_dungeon_plot(1061) -> 
    #dungeon_plot{
        no = 1061                  
        ,lv = 60
        ,first_rid = 15009
        ,first_extra_rid = []
        ,normal_rid = 15035
        ,times = 99     
    }       
        ;
 
get_dungeon_plot(1071) -> 
    #dungeon_plot{
        no = 1071                  
        ,lv = 70
        ,first_rid = 15010
        ,first_extra_rid = []
        ,normal_rid = 15036
        ,times = 99     
    }       
        ;
 
get_dungeon_plot(1081) -> 
    #dungeon_plot{
        no = 1081                  
        ,lv = 80
        ,first_rid = 15038
        ,first_extra_rid = []
        ,normal_rid = 15037
        ,times = 99     
    }       
        ;

get_dungeon_plot(_Arg) ->
    ?ASSERT(false, [_Arg]),
    null.
		  
get_dungeons()->
	[1011,1021,1031,1041,1051,1061,1071,1081].

