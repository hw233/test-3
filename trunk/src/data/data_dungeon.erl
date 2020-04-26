%%%---------------------------------------
%%% @Module  : data_dungeon
%%% @Author  : lds
%%% @Email   : 
%%% @Description:  副本
%%%---------------------------------------


-module(data_dungeon).
-include("common.hrl").
-include("record.hrl").
-include("dungeon.hrl").
-compile(export_all).

   
get(5051) ->
	#dungeon_data{
	    no = 5051,
    	lv = 80,
    	timing = 2400,
    	group = 5051,
        pass_group = 5051,
        had_pass_reward =1,
    	type = 2,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [{2,2,300},{3,2,700},{4,2,1300}],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [30001,30002,30003],
        listen_dead_battle = [30001,30002,30003],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 29, 4}]},
                        #action{type=add_seemon, object=nil, target=[{34044, 9003, 33, 7}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4501]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34045, 9003, 38, 16}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4502]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34046, 9003, 17, 16}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4503]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 1,
		final_reward = 43001,
		first_reward = 0
   }
			;
   
get(5052) ->
	#dungeon_data{
	    no = 5052,
    	lv = 200,
    	timing = 2400,
    	group = 5051,
        pass_group = 5051,
        had_pass_reward =1,
    	type = 2,
    	diff = 2,
    	cd =  {day, 9999},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [{2,2,400},{3,2,900},{4,2,1700}],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [30004,30005,30006],
        listen_dead_battle = [30004,30005,30006],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 29, 4}]},
                        #action{type=add_seemon, object=nil, target=[{34047, 9003, 33, 7}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4504]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34048, 9003, 38, 16}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4505]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34049, 9003, 17, 16}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4506]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }

],
		reward_times= 1,
		final_reward = 43002,
		first_reward = 0
   }
			;
   
get(5053) ->
	#dungeon_data{
	    no = 5053,
    	lv = 250,
    	timing = 2400,
    	group = 5051,
        pass_group = 5051,
        had_pass_reward =1,
    	type = 2,
    	diff = 3,
    	cd =  {day, 9999},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [{2,2,500},{3,2,1000},{4,2,2100}],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [30007,30008,30009],
        listen_dead_battle = [30007,30008,30009],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 29, 4}]},
                        #action{type=add_seemon, object=nil, target=[{34050, 9003, 33, 7}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4507]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34051, 9003, 38, 16}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4508]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34052, 9003, 17, 16}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4509]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 1,
		final_reward = 43003,
		first_reward = 0
   }
			;
   
get(5054) ->
	#dungeon_data{
	    no = 5054,
    	lv = 300,
    	timing = 2400,
    	group = 5051,
        pass_group = 5051,
        had_pass_reward =1,
    	type = 2,
    	diff = 4,
    	cd =  {day, 9999},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [{2,2,600},{3,2,1300},{4,2,2500}],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [30010,30011,30012],
        listen_dead_battle = [30010,30011,30012],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 29, 4}]},
                        #action{type=add_seemon, object=nil, target=[{34053, 9003, 33, 7}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4510]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34054, 9003, 38, 16}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4511]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34055, 9003, 17, 16}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4512]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 1,
		final_reward = 43004,
		first_reward = 0
   }
			;
   
get(4001) ->
	#dungeon_data{
	    no = 4001,
    	lv = 80,
    	timing = 2400,
    	group = 4001,
        pass_group = 4001,
        had_pass_reward =1,
    	type = 4,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [{2,2,200},{3,2,400},{4,2,900}],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [30021,30022,30023],
        listen_dead_battle = [30021,30022,30023],
        bout_max_points = 4000,
        dead_max_points = 300,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 28, 11}]},
                        #action{type=add_seemon, object=nil, target=[{34101, 3101, 43, 20}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4521]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34102, 3101, 64, 37}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4522]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34103, 3101, 62, 60}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4523]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 1,
		final_reward = 44001,
		first_reward = 0
   }
			;
   
get(4002) ->
	#dungeon_data{
	    no = 4002,
    	lv = 200,
    	timing = 2400,
    	group = 4001,
        pass_group = 4001,
        had_pass_reward =1,
    	type = 4,
    	diff = 2,
    	cd =  {day, 9999},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [{2,2,200},{3,2,500},{4,2,1100}],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [30024,30025,30026],
        listen_dead_battle = [30024,30025,30026],
        bout_max_points = 4000,
        dead_max_points = 400,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 28, 11}]},
                        #action{type=add_seemon, object=nil, target=[{34104, 3101, 43, 20}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4524]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34105, 3101, 64, 37}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4525]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34106, 3101, 62, 60}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4526]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 1,
		final_reward = 44002,
		first_reward = 0
   }
			;
   
get(4003) ->
	#dungeon_data{
	    no = 4003,
    	lv = 250,
    	timing = 2400,
    	group = 4001,
        pass_group = 4001,
        had_pass_reward =1,
    	type = 4,
    	diff = 3,
    	cd =  {day, 9999},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [{2,2,300},{3,2,600},{4,2,1300}],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [30027,30028,30029],
        listen_dead_battle = [30027,30028,30029],
        bout_max_points = 4000,
        dead_max_points = 500,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 28, 11}]},
                        #action{type=add_seemon, object=nil, target=[{34107, 3101, 43, 20}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4527]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34108, 3101, 64, 37}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4528]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34109, 3101, 62, 60}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4529]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 1,
		final_reward = 44003,
		first_reward = 0
   }
			;
   
get(4004) ->
	#dungeon_data{
	    no = 4004,
    	lv = 300,
    	timing = 2400,
    	group = 4001,
        pass_group = 4001,
        had_pass_reward =1,
    	type = 4,
    	diff = 4,
    	cd =  {day, 9999},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [{2,2,300},{3,2,700},{4,2,1500}],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [30030,30031,30032],
        listen_dead_battle = [30030,30031,30032],
        bout_max_points = 4000,
        dead_max_points = 500,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 28, 11}]},
                        #action{type=add_seemon, object=nil, target=[{34110, 3101, 43, 20}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4530]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34111, 3101, 64, 37}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4531]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34112, 3101, 62, 60}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4532]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 1,
		final_reward = 44004,
		first_reward = 0
   }
			;
   
get(2031) ->
	#dungeon_data{
	    no = 2031,
    	lv = 210,
    	timing = 2400,
    	group = 2031,
        pass_group = 2031,
        had_pass_reward =1,
    	type = 2,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [{2, 3, 100}, {3, 3, 200}, {4, 3, 300}],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [30041,30042,30043],
        listen_dead_battle = [30041,30042,30043],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 78, 6}]},
                        #action{type=add_seemon, object=nil, target=[{34201, 3201, 62, 16}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4541]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34202, 3201, 35, 41}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4542]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34203, 3201, 21, 65}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4543]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 1,
		final_reward = 10059,
		first_reward = 0
   }
			;
   
get(2032) ->
	#dungeon_data{
	    no = 2032,
    	lv = 250,
    	timing = 2400,
    	group = 2031,
        pass_group = 2031,
        had_pass_reward =1,
    	type = 2,
    	diff = 2,
    	cd =  {day, 9999},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [{2, 3, 100}, {3, 3, 200}, {4, 3, 300}],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [30044,30045,30046],
        listen_dead_battle = [30044,30045,30046],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 78, 6}]},
                        #action{type=add_seemon, object=nil, target=[{34204, 3201, 62, 16}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4544]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34205, 3201, 35, 41}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4545]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34206, 3201, 21, 65}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4546]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 1,
		final_reward = 10060,
		first_reward = 0
   }
			;
   
get(2033) ->
	#dungeon_data{
	    no = 2033,
    	lv = 300,
    	timing = 2400,
    	group = 2031,
        pass_group = 2031,
        had_pass_reward =1,
    	type = 2,
    	diff = 3,
    	cd =  {day, 9999},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [{2, 3, 100}, {3, 3, 200}, {4, 3, 300}],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [30047,30048,30049],
        listen_dead_battle = [30047,30048,30049],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 78, 6}]},
                        #action{type=add_seemon, object=nil, target=[{34207, 3201, 62, 16}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4547]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34208, 3201, 35, 41}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4548]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34209, 3201, 21, 65}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4549]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 1,
		final_reward = 10061,
		first_reward = 0
   }
			;
   
get(2034) ->
	#dungeon_data{
	    no = 2034,
    	lv = 350,
    	timing = 2400,
    	group = 2031,
        pass_group = 2031,
        had_pass_reward =1,
    	type = 2,
    	diff = 4,
    	cd =  {day, 9999},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [{2, 3, 100}, {3, 3, 200}, {4, 3, 300}],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [30050,30051,30052],
        listen_dead_battle = [30050,30051,30052],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 78, 6}]},
                        #action{type=add_seemon, object=nil, target=[{34210, 3201, 62, 16}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4550]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34211, 3201, 35, 41}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4551]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34212, 3201, 21, 65}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [4552]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 1,
		final_reward = 10062,
		first_reward = 0
   }
			;
   
get(5001) ->
	#dungeon_data{
	    no = 5001,
    	lv = 150,
    	timing = 2400,
    	group = 50,
        pass_group = 500,
        had_pass_reward =1,
    	type = 2,
    	diff = 1,
    	cd = {slot, week, [1], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800411,800412,800413],
        listen_dead_battle = [800411,800412,800413],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35109, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800411]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35110, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800412]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35111, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800413]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91235,
		first_reward = 0
   }
			;
   
get(5002) ->
	#dungeon_data{
	    no = 5002,
    	lv = 150,
    	timing = 2400,
    	group = 50,
        pass_group = 500,
        had_pass_reward =1,
    	type = 2,
    	diff = 2,
    	cd = {slot, week, [1], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800414,800415,800416],
        listen_dead_battle = [800414,800415,800416],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35112, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800414]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35113, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800415]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35114, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800416]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91236,
		first_reward = 0
   }
			;
   
get(5003) ->
	#dungeon_data{
	    no = 5003,
    	lv = 150,
    	timing = 2400,
    	group = 50,
        pass_group = 500,
        had_pass_reward =1,
    	type = 2,
    	diff = 3,
    	cd = {slot, week, [1], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800417,800418,800419],
        listen_dead_battle = [800417,800418,800419],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35115, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800417]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35116, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800418]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35117, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800419]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91237,
		first_reward = 0
   }
			;
   
get(5011) ->
	#dungeon_data{
	    no = 5011,
    	lv = 150,
    	timing = 2400,
    	group = 51,
        pass_group = 501,
        had_pass_reward =1,
    	type = 2,
    	diff = 1,
    	cd = {slot, week, [2], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800420,800421,800422],
        listen_dead_battle = [800420,800421,800422],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35118, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800420]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35119, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800421]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35120, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800422]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91238,
		first_reward = 0
   }
			;
   
get(5012) ->
	#dungeon_data{
	    no = 5012,
    	lv = 150,
    	timing = 2400,
    	group = 51,
        pass_group = 501,
        had_pass_reward =1,
    	type = 2,
    	diff = 2,
    	cd = {slot, week, [2], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800423,800424,800425],
        listen_dead_battle = [800423,800424,800425],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35121, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800423]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35122, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800424]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35123, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800425]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91239,
		first_reward = 0
   }
			;
   
get(5013) ->
	#dungeon_data{
	    no = 5013,
    	lv = 150,
    	timing = 2400,
    	group = 51,
        pass_group = 501,
        had_pass_reward =1,
    	type = 2,
    	diff = 3,
    	cd = {slot, week, [2], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800426,800427,800428],
        listen_dead_battle = [800426,800427,800428],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35124, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800426]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35125, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800427]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35126, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800428]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91240,
		first_reward = 0
   }
			;
   
get(5021) ->
	#dungeon_data{
	    no = 5021,
    	lv = 150,
    	timing = 2400,
    	group = 52,
        pass_group = 502,
        had_pass_reward =1,
    	type = 2,
    	diff = 1,
    	cd = {slot, week, [3], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800429,800430,800431],
        listen_dead_battle = [800429,800430,800431],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35127, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800429]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35128, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800430]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35129, 9003, 40, 23}]},
                       #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800431]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91241,
		first_reward = 0
   }
			;
   
get(5022) ->
	#dungeon_data{
	    no = 5022,
    	lv = 150,
    	timing = 2400,
    	group = 52,
        pass_group = 502,
        had_pass_reward =1,
    	type = 2,
    	diff = 2,
    	cd = {slot, week, [3], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800432,800433,800434],
        listen_dead_battle = [800432,800433,800434],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35130, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800432]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35131, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800433]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35132, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800434]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91242,
		first_reward = 0
   }
			;
   
get(5023) ->
	#dungeon_data{
	    no = 5023,
    	lv = 150,
    	timing = 2400,
    	group = 52,
        pass_group = 502,
        had_pass_reward =1,
    	type = 2,
    	diff = 3,
    	cd = {slot, week, [3], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800435,800436,800437],
        listen_dead_battle = [800435,800436,800437],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35133, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800435]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35134, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800436]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35135, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800437]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91243,
		first_reward = 0
   }
			;
   
get(5031) ->
	#dungeon_data{
	    no = 5031,
    	lv = 150,
    	timing = 2400,
    	group = 53,
        pass_group = 503,
        had_pass_reward =1,
    	type = 2,
    	diff = 1,
    	cd = {slot, week, [4], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800438,800439,800440],
        listen_dead_battle = [800438,800439,800440],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35136, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800438]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35137, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800439]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35138, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800440]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91244,
		first_reward = 0
   }
			;
   
get(5032) ->
	#dungeon_data{
	    no = 5032,
    	lv = 150,
    	timing = 2400,
    	group = 53,
        pass_group = 503,
        had_pass_reward =1,
    	type = 2,
    	diff = 2,
    	cd = {slot, week, [4], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800441,800442,800443],
        listen_dead_battle = [800441,800442,800443],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35139, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800441]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35140, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800442]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35141, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800443]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91245,
		first_reward = 0
   }
			;
   
get(5033) ->
	#dungeon_data{
	    no = 5033,
    	lv = 150,
    	timing = 2400,
    	group = 53,
        pass_group = 503,
        had_pass_reward =1,
    	type = 2,
    	diff = 3,
    	cd = {slot, week, [4], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800444,800445,800446],
        listen_dead_battle = [800444,800445,800446],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35142, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800444]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35143, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800445]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35144, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800446]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91246,
		first_reward = 0
   }
			;
   
get(5041) ->
	#dungeon_data{
	    no = 5041,
    	lv = 150,
    	timing = 2400,
    	group = 54,
        pass_group = 504,
        had_pass_reward =1,
    	type = 2,
    	diff = 1,
    	cd = {slot, week, [5], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800447,800448,800449],
        listen_dead_battle = [800447,800448,800449],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35145, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800447]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35146, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800448]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35147, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800449]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91247,
		first_reward = 0
   }
			;
   
get(5042) ->
	#dungeon_data{
	    no = 5042,
    	lv = 150,
    	timing = 2400,
    	group = 54,
        pass_group = 504,
        had_pass_reward =1,
    	type = 2,
    	diff = 2,
    	cd = {slot, week, [5], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800450,800451,800452],
        listen_dead_battle = [800450,800451,800452],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35148, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800450]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35149, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800451]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35150, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800452]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91248,
		first_reward = 0
   }
			;
   
get(5043) ->
	#dungeon_data{
	    no = 5043,
    	lv = 150,
    	timing = 2400,
    	group = 54,
        pass_group = 504,
        had_pass_reward =1,
    	type = 2,
    	diff = 3,
    	cd = {slot, week, [5], {{0,0}, {23,59}}, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [200],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [800453,800454,800455],
        listen_dead_battle = [800453,800454,800455],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[9003]},
                        #action{type=convey_dungeon, object=all, target=[{9003, 64, 7}]},
                        #action{type=add_seemon, object=nil, target=[{35151, 9003, 30, 17}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800453]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35152, 9003, 49, 28}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800454]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{35153, 9003, 40, 23}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [800455]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91249,
		first_reward = 0
   }
			;
   
get(2041) ->
	#dungeon_data{
	    no = 2041,
    	lv = 270,
    	timing = 2400,
    	group = 2,
        pass_group = 204,
        had_pass_reward =1,
    	type = 2,
    	diff = 1,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [100],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504133,504134,504135],
        listen_dead_battle = [504133,504134,504135],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 25, 27}]},
                        #action{type=add_seemon, object=nil, target=[{34044, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504133]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34045, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504134]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34046, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504135]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91182,
		first_reward = 0
   }
			;
   
get(2042) ->
	#dungeon_data{
	    no = 2042,
    	lv = 270,
    	timing = 2400,
    	group = 2,
        pass_group = 204,
        had_pass_reward =1,
    	type = 2,
    	diff = 2,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [100],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504136,504137,504138],
        listen_dead_battle = [504136,504137,504138],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 25, 27}]},
                        #action{type=add_seemon, object=nil, target=[{34047, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504136]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34048, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504137]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34049, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504138]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }

],
		reward_times= 5,
		final_reward = 91184,
		first_reward = 0
   }
			;
   
get(2043) ->
	#dungeon_data{
	    no = 2043,
    	lv = 270,
    	timing = 2400,
    	group = 2,
        pass_group = 204,
        had_pass_reward =1,
    	type = 2,
    	diff = 3,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [100],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504139,504140,504141],
        listen_dead_battle = [504139,504140,504141],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 25, 27}]},
                        #action{type=add_seemon, object=nil, target=[{34050, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504139]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34051, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504140]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34052, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504141]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91186,
		first_reward = 0
   }
			;
   
get(2001) ->
	#dungeon_data{
	    no = 2001,
    	lv = 65,
    	timing = 2400,
    	group = 2,
        pass_group = 200,
        had_pass_reward =1,
    	type = 2,
    	diff = 1,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504100],
        listen_dead_battle = [504100],
        bout_max_points = 4000,
        dead_max_points = 300,
        point_lv = [300,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 25, 27}]},
                        #action{type=add_seemon, object=nil, target=[{34001, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504100]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30254,
		first_reward = 0
   }
			;
   
get(2002) ->
	#dungeon_data{
	    no = 2002,
    	lv = 65,
    	timing = 2400,
    	group = 2,
        pass_group = 200,
        had_pass_reward =1,
    	type = 2,
    	diff = 2,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504101],
        listen_dead_battle = [504101],
        bout_max_points = 4500,
        dead_max_points = 400,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 25, 27}]},
                        #action{type=add_seemon, object=nil, target=[{34002, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504101]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30256,
		first_reward = 0
   }
			;
   
get(2003) ->
	#dungeon_data{
	    no = 2003,
    	lv = 65,
    	timing = 2400,
    	group = 2,
        pass_group = 200,
        had_pass_reward =1,
    	type = 2,
    	diff = 3,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504102],
        listen_dead_battle = [504102],
        bout_max_points = 5000,
        dead_max_points = 500,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 25, 27}]},
                        #action{type=add_seemon, object=nil, target=[{34003, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504102]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30258,
		first_reward = 0
   }
			;
   
get(2011) ->
	#dungeon_data{
	    no = 2011,
    	lv = 120,
    	timing = 2400,
    	group = 2,
        pass_group = 201,
        had_pass_reward =1,
    	type = 2,
    	diff = 1,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504103],
        listen_dead_battle = [504103],
        bout_max_points = 4000,
        dead_max_points = 300,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 25, 27}]},
                        #action{type=add_seemon, object=nil, target=[{34011, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504103]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30260,
		first_reward = 0
   }
			;
   
get(2012) ->
	#dungeon_data{
	    no = 2012,
    	lv = 120,
    	timing = 2400,
    	group = 2,
        pass_group = 201,
        had_pass_reward =1,
    	type = 2,
    	diff = 2,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504104],
        listen_dead_battle = [504104],
        bout_max_points = 4500,
        dead_max_points = 400,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 25, 27}]},
                        #action{type=add_seemon, object=nil, target=[{34012, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504104]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30262,
		first_reward = 0
   }
			;
   
get(2013) ->
	#dungeon_data{
	    no = 2013,
    	lv = 120,
    	timing = 2400,
    	group = 2,
        pass_group = 201,
        had_pass_reward =1,
    	type = 2,
    	diff = 3,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504105],
        listen_dead_battle = [504105],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 25, 27}]},
                        #action{type=add_seemon, object=nil, target=[{34013, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504105]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30264,
		first_reward = 0
   }
			;
   
get(2021) ->
	#dungeon_data{
	    no = 2021,
    	lv = 180,
    	timing = 2400,
    	group = 2,
        pass_group = 202,
        had_pass_reward =1,
    	type = 2,
    	diff = 1,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [505035],
        listen_dead_battle = [505035],
        bout_max_points = 4000,
        dead_max_points = 300,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 25, 27}]},
                        #action{type=add_seemon, object=nil, target=[{34020, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [505035]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30284,
		first_reward = 0
   }
			;
   
get(2022) ->
	#dungeon_data{
	    no = 2022,
    	lv = 180,
    	timing = 2400,
    	group = 2,
        pass_group = 202,
        had_pass_reward =1,
    	type = 2,
    	diff = 2,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [505036],
        listen_dead_battle = [505036],
        bout_max_points = 4500,
        dead_max_points = 400,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 25, 27}]},
                        #action{type=add_seemon, object=nil, target=[{34021, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [505036]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30286,
		first_reward = 0
   }
			;
   
get(2023) ->
	#dungeon_data{
	    no = 2023,
    	lv = 180,
    	timing = 2400,
    	group = 2,
        pass_group = 202,
        had_pass_reward =1,
    	type = 2,
    	diff = 3,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [505037],
        listen_dead_battle = [505037],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3201]},
                        #action{type=convey_dungeon, object=all, target=[{3201, 25, 27}]},
                        #action{type=add_seemon, object=nil, target=[{34022, 3201, 43, 22}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [505037]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30288,
		first_reward = 0
   }
			;
   
get(4011) ->
	#dungeon_data{
	    no = 4011,
    	lv = 120,
    	timing = 2400,
    	group = 4,
        pass_group = 401,
        had_pass_reward =1,
    	type = 4,
    	diff = 1,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504109],
        listen_dead_battle = [504109],
        bout_max_points = 4500,
        dead_max_points = 400,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 93, 15}]},
                        #action{type=add_seemon, object=nil, target=[{34017, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504109]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30272,
		first_reward = 0
   }
			;
   
get(4012) ->
	#dungeon_data{
	    no = 4012,
    	lv = 120,
    	timing = 2400,
    	group = 4,
        pass_group = 401,
        had_pass_reward =1,
    	type = 4,
    	diff = 2,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504110],
        listen_dead_battle = [504110],
        bout_max_points = 4500,
        dead_max_points = 500,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 93, 15}]},
                        #action{type=add_seemon, object=nil, target=[{34018, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504110]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30274,
		first_reward = 0
   }
			;
   
get(4013) ->
	#dungeon_data{
	    no = 4013,
    	lv = 120,
    	timing = 2400,
    	group = 4,
        pass_group = 401,
        had_pass_reward =1,
    	type = 4,
    	diff = 3,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504111],
        listen_dead_battle = [504111],
        bout_max_points = 4500,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 93, 15}]},
                        #action{type=add_seemon, object=nil, target=[{34019, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504111]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30276,
		first_reward = 0
   }
			;
   
get(4021) ->
	#dungeon_data{
	    no = 4021,
    	lv = 180,
    	timing = 2400,
    	group = 4,
        pass_group = 402,
        had_pass_reward =1,
    	type = 4,
    	diff = 1,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504112],
        listen_dead_battle = [504112],
        bout_max_points = 4500,
        dead_max_points = 400,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 93, 15}]},
                        #action{type=add_seemon, object=nil, target=[{34023, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504112]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30278,
		first_reward = 0
   }
			;
   
get(4022) ->
	#dungeon_data{
	    no = 4022,
    	lv = 180,
    	timing = 2400,
    	group = 4,
        pass_group = 402,
        had_pass_reward =1,
    	type = 4,
    	diff = 2,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504113],
        listen_dead_battle = [504113],
        bout_max_points = 4500,
        dead_max_points = 500,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 93, 15}]},
                        #action{type=add_seemon, object=nil, target=[{34024, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504113]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30280,
		first_reward = 0
   }
			;
   
get(4023) ->
	#dungeon_data{
	    no = 4023,
    	lv = 180,
    	timing = 2400,
    	group = 4,
        pass_group = 402,
        had_pass_reward =1,
    	type = 4,
    	diff = 3,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [10],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504114],
        listen_dead_battle = [504114],
        bout_max_points = 4500,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 93, 15}]},
                        #action{type=add_seemon, object=nil, target=[{34025, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },

            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504114]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 30282,
		first_reward = 0
   }
			;
   
get(110001) ->
	#dungeon_data{
	    no = 110001,
    	lv = 30,
    	timing = 1800,
    	group = 110001,
        pass_group = 1000,
        had_pass_reward =0,
    	type = 6,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {3601, 91, 9},
    	role_num = 0,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener =          [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3601]},
                        #action{type = add_timer, object=nil, target=[3]},
                        #action{type=push_id, object=nil, target=[2]}
                      ]
                     },
            #listener{id=2,
                      condition=[
			#condition{type = timer_timeout, object = nil, target=[3]}
                      ],
                      action=[
                        #action{type=add_dungeon_boss, object=nil, target=[{13200, 3601, 36, 47}]},
                        #action{type=push_id, object=nil, target=[3]}
                      ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = dungeon_boss_killed, object = nil, target = [13200]}
                      ],
                      action=[
                        #action{type =del_seemon, object=nil, target=[{13200, 3601, 36, 47}]}
                      ]
                     }
           ],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(110002) ->
	#dungeon_data{
	    no = 110002,
    	lv = 30,
    	timing = 4200,
    	group = 110002,
        pass_group = 1000,
        had_pass_reward =0,
    	type = 6,
    	diff = 2,
    	cd = 0,
		floor = 0,
        init_pos = {3601, 64, 9},
    	role_num = 0,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener =          [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3601]},
                        #action{type = add_timer, object=nil, target=[180]},
                        #action{type=push_id, object=nil, target=[2]}
                      ]
                     },
            #listener{id=2,
                      condition=[#condition{type = timer_timeout, object = nil, target=[180]}],
                      action=[
                        #action{type=add_dungeon_boss, object=nil, target=[{13201, 3601, 40, 23}]},
                        #action{type=push_id, object=nil, target=[3]}
                      ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = dungeon_boss_killed, object = nil, target = [13201]}
                      ],
                      action=[
                        #action{type =del_seemon, object=nil, target=[{13201, 3601, 40, 23}]}
                      ]
                     }
           ],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(120000) ->
	#dungeon_data{
	    no = 120000,
    	lv = 90,
    	timing = 5400,
    	group = 120000,
        pass_group = 1200,
        had_pass_reward =0,
    	type = 9,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {3701, 38, 11},
    	role_num = 0,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3701]},
                        #action{type=add_seemon, object=nil, target=[{22000, 3701, 19, 24}]},
                        #action{type=convey_dungeon, object=all, target=[{3701, 38, 11}]}
                      ]
                     }
           ],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(120001) ->
	#dungeon_data{
	    no = 120001,
    	lv = 180,
    	timing = 5400,
    	group = 120000,
        pass_group = 1200,
        had_pass_reward =0,
    	type = 9,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {3701, 38, 11},
    	role_num = 0,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3701]},
                        #action{type=add_seemon, object=nil, target=[{22100, 3701, 19, 24}]},
                        #action{type=convey_dungeon, object=all, target=[{3701, 38, 11}]}
                      ]
                     }
           ],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(300001) ->
	#dungeon_data{
	    no = 300001,
    	lv = 60,
    	timing = 1800,
    	group = 300000,
        pass_group = 3000,
        had_pass_reward =1,
    	type = 10,
    	diff = 1,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 3,
    	more_box_price = [30],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [200008,200009,200010],
        listen_dead_battle = [200008,200009,200010],
        bout_max_points = 5000,
        dead_max_points = 500,
        point_lv = [400,600,800,1000],
        listener = [    
      #listener{id=1,                   
      condition=[],     
      action=[      
     #action{type=create_map, object=nil,target=[3101]},                                                  
     #action{type=convey_dungeon, object=all, target=[{3101, 79,25}]},                          
     #action{type=add_seemon,object=nil,target=[{23607,3101,17,48}]},                                            
     #action{type=push_id, object=nil, target=[2]}
             ]
               }, 

      #listener{id=2,
      condition=[      
     #condition{type=rand_battle_win_group,object=self,target=[200008,200009,200010]}],     
   action=[                                                                             
  #action{type=set_dungeon_pass, object=nil, target=[]}
          ]
          }
],
		reward_times= 5,
		final_reward = 30157,
		first_reward = 0
   }
			;
   
get(300002) ->
	#dungeon_data{
	    no = 300002,
    	lv = 60,
    	timing = 1800,
    	group = 300000,
        pass_group = 3000,
        had_pass_reward =1,
    	type = 10,
    	diff = 2,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 3,
    	more_box_price = [30],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [200005,200006,200007],
        listen_dead_battle = [200005,200006,200007],
        bout_max_points = 5000,
        dead_max_points = 500,
        point_lv = [400,600,800,1000],
        listener = [    
      #listener{id=1,                   
      condition=[],     
      action=[      
     #action{type=create_map, object=nil,target=[3101]},                                                  
     #action{type=convey_dungeon, object=all, target=[{3101, 79,25}]},                          
     #action{type=add_seemon,object=nil,target=[{23608,3101,17,48}]},                                            
     #action{type=push_id, object=nil, target=[2]}
             ]
               }, 

      #listener{id=2,
      condition=[      
     #condition{type=rand_battle_win_group,object=self,target=[200005,200006,200007]}],     
   action=[                                                                             
  #action{type=set_dungeon_pass, object=nil, target=[]}
          ]
          }
],
		reward_times= 5,
		final_reward = 30159,
		first_reward = 0
   }
			;
   
get(300003) ->
	#dungeon_data{
	    no = 300003,
    	lv = 60,
    	timing = 1800,
    	group = 300000,
        pass_group = 3000,
        had_pass_reward =1,
    	type = 10,
    	diff = 3,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 3,
    	more_box_price = [30],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [200002,200003,200004],
        listen_dead_battle = [200002,200003,200004],
        bout_max_points = 5000,
        dead_max_points = 500,
        point_lv = [400,600,800,1000],
        listener = [    
      #listener{id=1,                   
      condition=[],     
      action=[      
     #action{type=create_map, object=nil,target=[3101]},                                                  
     #action{type=convey_dungeon, object=all, target=[{3101, 79,25}]},                          
     #action{type=add_seemon,object=nil,target=[{23609,3101,17,48}]},                                            
     #action{type=push_id, object=nil, target=[2]}
             ]
               }, 

      #listener{id=2,
      condition=[      
     #condition{type=rand_battle_win_group,object=self,target=[200002,200003,200004]}],     
   action=[                                                                             
  #action{type=set_dungeon_pass, object=nil, target=[]}
          ]
          }
],
		reward_times= 5,
		final_reward = 30161,
		first_reward = 0
   }
			;
   
get(120002) ->
	#dungeon_data{
	    no = 120002,
    	lv = 250,
    	timing = 5400,
    	group = 120000,
        pass_group = 1200,
        had_pass_reward =0,
    	type = 9,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {3701, 38, 11},
    	role_num = 0,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3701]},
                        #action{type=add_seemon, object=nil, target=[{22200, 3701, 19, 24}]},
                        #action{type=convey_dungeon, object=all, target=[{3701, 38, 11}]}
                      ]
                     }
           ],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(120004) ->
	#dungeon_data{
	    no = 120004,
    	lv = 270,
    	timing = 5400,
    	group = 120000,
        pass_group = 1200,
        had_pass_reward =0,
    	type = 9,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {3701, 38, 11},
    	role_num = 0,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3701]},
                        #action{type=add_seemon, object=nil, target=[{22300, 3701, 19, 24}]},
                        #action{type=convey_dungeon, object=all, target=[{3701, 38, 11}]}
                      ]
                     }
           ],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(120003) ->
	#dungeon_data{
	    no = 120003,
    	lv = 110,
    	timing = 5400,
    	group = 120000,
        pass_group = 1200,
        had_pass_reward =0,
    	type = 9,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {3701, 38, 11},
    	role_num = 0,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3701]},
                        #action{type=add_seemon, object=nil, target=[{35108, 3701, 19, 24}]},
                        #action{type=convey_dungeon, object=all, target=[{3701, 38, 11}]}
                      ]
                     }
           ],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(4031) ->
	#dungeon_data{
	    no = 4031,
    	lv = 240,
    	timing = 2400,
    	group = 4,
        pass_group = 403,
        had_pass_reward =1,
    	type = 4,
    	diff = 1,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [100],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504124,504125,504126],
        listen_dead_battle = [504124,504125,504126],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 93, 15}]},
                        #action{type=add_seemon, object=nil, target=[{34035, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504124]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34036, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504125]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34037, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504126]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91056,
		first_reward = 0
   }
			;
   
get(4032) ->
	#dungeon_data{
	    no = 4032,
    	lv = 240,
    	timing = 2400,
    	group = 4,
        pass_group = 403,
        had_pass_reward =1,
    	type = 4,
    	diff = 2,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [100],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504127,504128,504129],
        listen_dead_battle = [504127,504128,504129],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 93, 15}]},
                        #action{type=add_seemon, object=nil, target=[{34038, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504127]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34039, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504128]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34040, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504129]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91058,
		first_reward = 0
   }
			;
   
get(4033) ->
	#dungeon_data{
	    no = 4033,
    	lv = 240,
    	timing = 2400,
    	group = 4,
        pass_group = 403,
        had_pass_reward =1,
    	type = 4,
    	diff = 3,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [100],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504130,504131,504132],
        listen_dead_battle = [504130,504131,504132],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 93, 15}]},
                        #action{type=add_seemon, object=nil, target=[{34041, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504130]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34042, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504131]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34043, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504132]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91060,
		first_reward = 0
   }
			;
   
get(4041) ->
	#dungeon_data{
	    no = 4041,
    	lv = 270,
    	timing = 2400,
    	group = 4,
        pass_group = 404,
        had_pass_reward =1,
    	type = 4,
    	diff = 1,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [100],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504142,504143,504144],
        listen_dead_battle = [504142,504143,504144],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 93, 15}]},
                        #action{type=add_seemon, object=nil, target=[{34053, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504142]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34054, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504143]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34055, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504144]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91188,
		first_reward = 0
   }
			;
   
get(4042) ->
	#dungeon_data{
	    no = 4042,
    	lv = 270,
    	timing = 2400,
    	group = 4,
        pass_group = 404,
        had_pass_reward =1,
    	type = 4,
    	diff = 2,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [100],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504145,504146,504147],
        listen_dead_battle = [504145,504146,504147],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 93, 15}]},
                        #action{type=add_seemon, object=nil, target=[{34056, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504145]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34057, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504146]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34058, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504147]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91190,
		first_reward = 0
   }
			;
   
get(4043) ->
	#dungeon_data{
	    no = 4043,
    	lv = 270,
    	timing = 2400,
    	group = 4,
        pass_group = 404,
        had_pass_reward =1,
    	type = 4,
    	diff = 3,
    	cd =  {day, 2},
		floor = 0,
        init_pos = {},
    	role_num = 0,
    	more_box_price = [100],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [504148,504149,504150],
        listen_dead_battle = [504148,504149,504150],
        bout_max_points = 5000,
        dead_max_points = 600,
        point_lv = [400,600,800,1000],
        listener = [
            #listener{id=1,
                      condition=[],
                      action=[
                        #action{type=create_map, object=nil, target=[3101]},
                        #action{type=convey_dungeon, object=all, target=[{3101, 93, 15}]},
                        #action{type=add_seemon, object=nil, target=[{34059, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[2]}
                             ]
                     },
            #listener{id=2,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504148]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34060, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[3]}
                             ]
                     },
            #listener{id=3,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504149]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=add_seemon, object=nil, target=[{34061, 3101, 61, 31}]},
                        #action{type=push_id, object=nil, target=[4]}
                             ]
                     },
            #listener{id=4,
                      condition=[
                        #condition{type = battle_win_group, object = self,target= [504150]},
                        #condition{type = client_battle_end, object = self, target= [1]}
                                ],
                      action=[
                        #action{type=set_dungeon_pass, object=nil, target=[]}
                             ]
                     }
],
		reward_times= 5,
		final_reward = 91192,
		first_reward = 0
   }
			;
   
get(200000) ->
	#dungeon_data{
	    no = 200000,
    	lv = 135,
    	timing = 0,
    	group = 20000,
        pass_group = 1,
        had_pass_reward =0,
    	type = 13,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {7001, 5, 37},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(200001) ->
	#dungeon_data{
	    no = 200001,
    	lv = 135,
    	timing = 0,
    	group = 20000,
        pass_group = 2,
        had_pass_reward =0,
    	type = 13,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {7002, 12, 60},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(200002) ->
	#dungeon_data{
	    no = 200002,
    	lv = 135,
    	timing = 0,
    	group = 20000,
        pass_group = 3,
        had_pass_reward =0,
    	type = 13,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {7003, 52, 43},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(200003) ->
	#dungeon_data{
	    no = 200003,
    	lv = 135,
    	timing = 0,
    	group = 20000,
        pass_group = 4,
        had_pass_reward =0,
    	type = 13,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {7002, 12, 60},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(200004) ->
	#dungeon_data{
	    no = 200004,
    	lv = 135,
    	timing = 0,
    	group = 20000,
        pass_group = 5,
        had_pass_reward =0,
    	type = 13,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {7001, 5, 37},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(200005) ->
	#dungeon_data{
	    no = 200005,
    	lv = 135,
    	timing = 0,
    	group = 20000,
        pass_group = 6,
        had_pass_reward =0,
    	type = 13,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {7003, 52, 43},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(200006) ->
	#dungeon_data{
	    no = 200006,
    	lv = 135,
    	timing = 0,
    	group = 20000,
        pass_group = 7,
        had_pass_reward =0,
    	type = 13,
    	diff = 1,
    	cd = 0,
		floor = 0,
        init_pos = {7004, 77, 58},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 5,
		final_reward = 0,
		first_reward = 0
   }
			;
   
get(10001) ->
	#dungeon_data{
	    no = 10001,
    	lv = 1,
    	timing = 2400,
    	group = 10001,
        pass_group = 10001,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 1,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3001],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390001,
		first_reward = 0
   }
			;
   
get(10002) ->
	#dungeon_data{
	    no = 10002,
    	lv = 1,
    	timing = 2400,
    	group = 10002,
        pass_group = 10002,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 2,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3002],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390002,
		first_reward = 0
   }
			;
   
get(10003) ->
	#dungeon_data{
	    no = 10003,
    	lv = 1,
    	timing = 2400,
    	group = 10003,
        pass_group = 10003,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 3,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3003],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390003,
		first_reward = 0
   }
			;
   
get(10004) ->
	#dungeon_data{
	    no = 10004,
    	lv = 1,
    	timing = 2400,
    	group = 10004,
        pass_group = 10004,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 4,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3004],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390004,
		first_reward = 0
   }
			;
   
get(10005) ->
	#dungeon_data{
	    no = 10005,
    	lv = 1,
    	timing = 2400,
    	group = 10005,
        pass_group = 10005,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 5,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3005],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390005,
		first_reward = 0
   }
			;
   
get(10006) ->
	#dungeon_data{
	    no = 10006,
    	lv = 1,
    	timing = 2400,
    	group = 10006,
        pass_group = 10006,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 6,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3006],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390006,
		first_reward = 0
   }
			;
   
get(10007) ->
	#dungeon_data{
	    no = 10007,
    	lv = 1,
    	timing = 2400,
    	group = 10007,
        pass_group = 10007,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 7,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3007],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390007,
		first_reward = 0
   }
			;
   
get(10008) ->
	#dungeon_data{
	    no = 10008,
    	lv = 1,
    	timing = 2400,
    	group = 10008,
        pass_group = 10008,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 8,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3008],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390008,
		first_reward = 0
   }
			;
   
get(10009) ->
	#dungeon_data{
	    no = 10009,
    	lv = 1,
    	timing = 2400,
    	group = 10009,
        pass_group = 10009,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 9,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3009],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390009,
		first_reward = 0
   }
			;
   
get(10010) ->
	#dungeon_data{
	    no = 10010,
    	lv = 1,
    	timing = 2400,
    	group = 10010,
        pass_group = 10010,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 10,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3010],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390010,
		first_reward = 391001
   }
			;
   
get(10011) ->
	#dungeon_data{
	    no = 10011,
    	lv = 1,
    	timing = 2400,
    	group = 10011,
        pass_group = 10011,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 11,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3011],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390011,
		first_reward = 0
   }
			;
   
get(10012) ->
	#dungeon_data{
	    no = 10012,
    	lv = 1,
    	timing = 2400,
    	group = 10012,
        pass_group = 10012,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 12,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3012],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390012,
		first_reward = 0
   }
			;
   
get(10013) ->
	#dungeon_data{
	    no = 10013,
    	lv = 1,
    	timing = 2400,
    	group = 10013,
        pass_group = 10013,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 13,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3013],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390013,
		first_reward = 0
   }
			;
   
get(10014) ->
	#dungeon_data{
	    no = 10014,
    	lv = 1,
    	timing = 2400,
    	group = 10014,
        pass_group = 10014,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 14,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3014],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390014,
		first_reward = 0
   }
			;
   
get(10015) ->
	#dungeon_data{
	    no = 10015,
    	lv = 1,
    	timing = 2400,
    	group = 10015,
        pass_group = 10015,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 15,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3015],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390015,
		first_reward = 0
   }
			;
   
get(10016) ->
	#dungeon_data{
	    no = 10016,
    	lv = 1,
    	timing = 2400,
    	group = 10016,
        pass_group = 10016,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 16,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3016],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390016,
		first_reward = 0
   }
			;
   
get(10017) ->
	#dungeon_data{
	    no = 10017,
    	lv = 1,
    	timing = 2400,
    	group = 10017,
        pass_group = 10017,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 17,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3017],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390017,
		first_reward = 0
   }
			;
   
get(10018) ->
	#dungeon_data{
	    no = 10018,
    	lv = 1,
    	timing = 2400,
    	group = 10018,
        pass_group = 10018,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 18,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3018],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390018,
		first_reward = 0
   }
			;
   
get(10019) ->
	#dungeon_data{
	    no = 10019,
    	lv = 1,
    	timing = 2400,
    	group = 10019,
        pass_group = 10019,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 19,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3019],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390019,
		first_reward = 0
   }
			;
   
get(10020) ->
	#dungeon_data{
	    no = 10020,
    	lv = 1,
    	timing = 2400,
    	group = 10020,
        pass_group = 10020,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 20,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3020],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390020,
		first_reward = 391002
   }
			;
   
get(10021) ->
	#dungeon_data{
	    no = 10021,
    	lv = 1,
    	timing = 2400,
    	group = 10021,
        pass_group = 10021,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 21,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3021],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390021,
		first_reward = 0
   }
			;
   
get(10022) ->
	#dungeon_data{
	    no = 10022,
    	lv = 1,
    	timing = 2400,
    	group = 10022,
        pass_group = 10022,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 22,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3022],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390022,
		first_reward = 0
   }
			;
   
get(10023) ->
	#dungeon_data{
	    no = 10023,
    	lv = 1,
    	timing = 2400,
    	group = 10023,
        pass_group = 10023,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 23,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3023],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390023,
		first_reward = 0
   }
			;
   
get(10024) ->
	#dungeon_data{
	    no = 10024,
    	lv = 1,
    	timing = 2400,
    	group = 10024,
        pass_group = 10024,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 24,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3024],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390024,
		first_reward = 0
   }
			;
   
get(10025) ->
	#dungeon_data{
	    no = 10025,
    	lv = 1,
    	timing = 2400,
    	group = 10025,
        pass_group = 10025,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 25,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3025],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390025,
		first_reward = 0
   }
			;
   
get(10026) ->
	#dungeon_data{
	    no = 10026,
    	lv = 1,
    	timing = 2400,
    	group = 10026,
        pass_group = 10026,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 26,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3026],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390026,
		first_reward = 0
   }
			;
   
get(10027) ->
	#dungeon_data{
	    no = 10027,
    	lv = 1,
    	timing = 2400,
    	group = 10027,
        pass_group = 10027,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 27,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3027],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390027,
		first_reward = 0
   }
			;
   
get(10028) ->
	#dungeon_data{
	    no = 10028,
    	lv = 1,
    	timing = 2400,
    	group = 10028,
        pass_group = 10028,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 28,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3028],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390028,
		first_reward = 0
   }
			;
   
get(10029) ->
	#dungeon_data{
	    no = 10029,
    	lv = 1,
    	timing = 2400,
    	group = 10029,
        pass_group = 10029,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 29,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3029],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390029,
		first_reward = 0
   }
			;
   
get(10030) ->
	#dungeon_data{
	    no = 10030,
    	lv = 1,
    	timing = 2400,
    	group = 10030,
        pass_group = 10030,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 30,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3030],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390030,
		first_reward = 391003
   }
			;
   
get(10031) ->
	#dungeon_data{
	    no = 10031,
    	lv = 1,
    	timing = 2400,
    	group = 10031,
        pass_group = 10031,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 31,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3031],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390031,
		first_reward = 0
   }
			;
   
get(10032) ->
	#dungeon_data{
	    no = 10032,
    	lv = 1,
    	timing = 2400,
    	group = 10032,
        pass_group = 10032,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 32,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3032],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390032,
		first_reward = 0
   }
			;
   
get(10033) ->
	#dungeon_data{
	    no = 10033,
    	lv = 1,
    	timing = 2400,
    	group = 10033,
        pass_group = 10033,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 33,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3033],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390033,
		first_reward = 0
   }
			;
   
get(10034) ->
	#dungeon_data{
	    no = 10034,
    	lv = 1,
    	timing = 2400,
    	group = 10034,
        pass_group = 10034,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 34,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3034],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390034,
		first_reward = 0
   }
			;
   
get(10035) ->
	#dungeon_data{
	    no = 10035,
    	lv = 1,
    	timing = 2400,
    	group = 10035,
        pass_group = 10035,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 35,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3035],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390035,
		first_reward = 0
   }
			;
   
get(10036) ->
	#dungeon_data{
	    no = 10036,
    	lv = 1,
    	timing = 2400,
    	group = 10036,
        pass_group = 10036,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 36,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3036],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390036,
		first_reward = 0
   }
			;
   
get(10037) ->
	#dungeon_data{
	    no = 10037,
    	lv = 1,
    	timing = 2400,
    	group = 10037,
        pass_group = 10037,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 37,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3037],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390037,
		first_reward = 0
   }
			;
   
get(10038) ->
	#dungeon_data{
	    no = 10038,
    	lv = 1,
    	timing = 2400,
    	group = 10038,
        pass_group = 10038,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 38,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3038],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390038,
		first_reward = 0
   }
			;
   
get(10039) ->
	#dungeon_data{
	    no = 10039,
    	lv = 1,
    	timing = 2400,
    	group = 10039,
        pass_group = 10039,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 39,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3039],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390039,
		first_reward = 0
   }
			;
   
get(10040) ->
	#dungeon_data{
	    no = 10040,
    	lv = 1,
    	timing = 2400,
    	group = 10040,
        pass_group = 10040,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 40,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3040],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390040,
		first_reward = 391004
   }
			;
   
get(10041) ->
	#dungeon_data{
	    no = 10041,
    	lv = 1,
    	timing = 2400,
    	group = 10041,
        pass_group = 10041,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 41,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3041],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390041,
		first_reward = 0
   }
			;
   
get(10042) ->
	#dungeon_data{
	    no = 10042,
    	lv = 1,
    	timing = 2400,
    	group = 10042,
        pass_group = 10042,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 42,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3042],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390042,
		first_reward = 0
   }
			;
   
get(10043) ->
	#dungeon_data{
	    no = 10043,
    	lv = 1,
    	timing = 2400,
    	group = 10043,
        pass_group = 10043,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 43,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3043],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390043,
		first_reward = 0
   }
			;
   
get(10044) ->
	#dungeon_data{
	    no = 10044,
    	lv = 1,
    	timing = 2400,
    	group = 10044,
        pass_group = 10044,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 44,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3044],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390044,
		first_reward = 0
   }
			;
   
get(10045) ->
	#dungeon_data{
	    no = 10045,
    	lv = 1,
    	timing = 2400,
    	group = 10045,
        pass_group = 10045,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 45,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3045],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390045,
		first_reward = 0
   }
			;
   
get(10046) ->
	#dungeon_data{
	    no = 10046,
    	lv = 1,
    	timing = 2400,
    	group = 10046,
        pass_group = 10046,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 46,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3046],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390046,
		first_reward = 0
   }
			;
   
get(10047) ->
	#dungeon_data{
	    no = 10047,
    	lv = 1,
    	timing = 2400,
    	group = 10047,
        pass_group = 10047,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 47,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3047],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390047,
		first_reward = 0
   }
			;
   
get(10048) ->
	#dungeon_data{
	    no = 10048,
    	lv = 1,
    	timing = 2400,
    	group = 10048,
        pass_group = 10048,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 48,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3048],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390048,
		first_reward = 0
   }
			;
   
get(10049) ->
	#dungeon_data{
	    no = 10049,
    	lv = 1,
    	timing = 2400,
    	group = 10049,
        pass_group = 10049,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 49,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3049],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390049,
		first_reward = 0
   }
			;
   
get(10050) ->
	#dungeon_data{
	    no = 10050,
    	lv = 1,
    	timing = 2400,
    	group = 10050,
        pass_group = 10050,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 50,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3050],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390050,
		first_reward = 391005
   }
			;
   
get(10051) ->
	#dungeon_data{
	    no = 10051,
    	lv = 1,
    	timing = 2400,
    	group = 10051,
        pass_group = 10051,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 51,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3051],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390051,
		first_reward = 0
   }
			;
   
get(10052) ->
	#dungeon_data{
	    no = 10052,
    	lv = 1,
    	timing = 2400,
    	group = 10052,
        pass_group = 10052,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 52,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3052],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390052,
		first_reward = 0
   }
			;
   
get(10053) ->
	#dungeon_data{
	    no = 10053,
    	lv = 1,
    	timing = 2400,
    	group = 10053,
        pass_group = 10053,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 53,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3053],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390053,
		first_reward = 0
   }
			;
   
get(10054) ->
	#dungeon_data{
	    no = 10054,
    	lv = 1,
    	timing = 2400,
    	group = 10054,
        pass_group = 10054,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 54,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3054],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390054,
		first_reward = 0
   }
			;
   
get(10055) ->
	#dungeon_data{
	    no = 10055,
    	lv = 1,
    	timing = 2400,
    	group = 10055,
        pass_group = 10055,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 55,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3055],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390055,
		first_reward = 0
   }
			;
   
get(10056) ->
	#dungeon_data{
	    no = 10056,
    	lv = 1,
    	timing = 2400,
    	group = 10056,
        pass_group = 10056,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 56,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3056],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390056,
		first_reward = 0
   }
			;
   
get(10057) ->
	#dungeon_data{
	    no = 10057,
    	lv = 1,
    	timing = 2400,
    	group = 10057,
        pass_group = 10057,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 57,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3057],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390057,
		first_reward = 0
   }
			;
   
get(10058) ->
	#dungeon_data{
	    no = 10058,
    	lv = 1,
    	timing = 2400,
    	group = 10058,
        pass_group = 10058,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 58,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3058],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390058,
		first_reward = 0
   }
			;
   
get(10059) ->
	#dungeon_data{
	    no = 10059,
    	lv = 1,
    	timing = 2400,
    	group = 10059,
        pass_group = 10059,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 59,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3059],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390059,
		first_reward = 0
   }
			;
   
get(10060) ->
	#dungeon_data{
	    no = 10060,
    	lv = 1,
    	timing = 2400,
    	group = 10060,
        pass_group = 10060,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 60,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3060],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390060,
		first_reward = 391006
   }
			;
   
get(10061) ->
	#dungeon_data{
	    no = 10061,
    	lv = 1,
    	timing = 2400,
    	group = 10061,
        pass_group = 10061,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 61,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3061],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390061,
		first_reward = 0
   }
			;
   
get(10062) ->
	#dungeon_data{
	    no = 10062,
    	lv = 1,
    	timing = 2400,
    	group = 10062,
        pass_group = 10062,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 62,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3062],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390062,
		first_reward = 0
   }
			;
   
get(10063) ->
	#dungeon_data{
	    no = 10063,
    	lv = 1,
    	timing = 2400,
    	group = 10063,
        pass_group = 10063,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 63,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3063],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390063,
		first_reward = 0
   }
			;
   
get(10064) ->
	#dungeon_data{
	    no = 10064,
    	lv = 1,
    	timing = 2400,
    	group = 10064,
        pass_group = 10064,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 64,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3064],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390064,
		first_reward = 0
   }
			;
   
get(10065) ->
	#dungeon_data{
	    no = 10065,
    	lv = 1,
    	timing = 2400,
    	group = 10065,
        pass_group = 10065,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 65,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3065],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390065,
		first_reward = 0
   }
			;
   
get(10066) ->
	#dungeon_data{
	    no = 10066,
    	lv = 1,
    	timing = 2400,
    	group = 10066,
        pass_group = 10066,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 66,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3066],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390066,
		first_reward = 0
   }
			;
   
get(10067) ->
	#dungeon_data{
	    no = 10067,
    	lv = 1,
    	timing = 2400,
    	group = 10067,
        pass_group = 10067,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 67,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3067],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390067,
		first_reward = 0
   }
			;
   
get(10068) ->
	#dungeon_data{
	    no = 10068,
    	lv = 1,
    	timing = 2400,
    	group = 10068,
        pass_group = 10068,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 68,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3068],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390068,
		first_reward = 0
   }
			;
   
get(10069) ->
	#dungeon_data{
	    no = 10069,
    	lv = 1,
    	timing = 2400,
    	group = 10069,
        pass_group = 10069,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 69,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3069],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390069,
		first_reward = 0
   }
			;
   
get(10070) ->
	#dungeon_data{
	    no = 10070,
    	lv = 1,
    	timing = 2400,
    	group = 10070,
        pass_group = 10070,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 70,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3070],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390070,
		first_reward = 391007
   }
			;
   
get(10071) ->
	#dungeon_data{
	    no = 10071,
    	lv = 1,
    	timing = 2400,
    	group = 10071,
        pass_group = 10071,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 71,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3071],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390071,
		first_reward = 0
   }
			;
   
get(10072) ->
	#dungeon_data{
	    no = 10072,
    	lv = 1,
    	timing = 2400,
    	group = 10072,
        pass_group = 10072,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 72,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3072],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390072,
		first_reward = 0
   }
			;
   
get(10073) ->
	#dungeon_data{
	    no = 10073,
    	lv = 1,
    	timing = 2400,
    	group = 10073,
        pass_group = 10073,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 73,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3073],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390073,
		first_reward = 0
   }
			;
   
get(10074) ->
	#dungeon_data{
	    no = 10074,
    	lv = 1,
    	timing = 2400,
    	group = 10074,
        pass_group = 10074,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 74,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3074],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390074,
		first_reward = 0
   }
			;
   
get(10075) ->
	#dungeon_data{
	    no = 10075,
    	lv = 1,
    	timing = 2400,
    	group = 10075,
        pass_group = 10075,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 75,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3075],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390075,
		first_reward = 0
   }
			;
   
get(10076) ->
	#dungeon_data{
	    no = 10076,
    	lv = 1,
    	timing = 2400,
    	group = 10076,
        pass_group = 10076,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 76,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3076],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390076,
		first_reward = 0
   }
			;
   
get(10077) ->
	#dungeon_data{
	    no = 10077,
    	lv = 1,
    	timing = 2400,
    	group = 10077,
        pass_group = 10077,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 77,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3077],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390077,
		first_reward = 0
   }
			;
   
get(10078) ->
	#dungeon_data{
	    no = 10078,
    	lv = 1,
    	timing = 2400,
    	group = 10078,
        pass_group = 10078,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 78,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3078],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390078,
		first_reward = 0
   }
			;
   
get(10079) ->
	#dungeon_data{
	    no = 10079,
    	lv = 1,
    	timing = 2400,
    	group = 10079,
        pass_group = 10079,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 79,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3079],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390079,
		first_reward = 0
   }
			;
   
get(10080) ->
	#dungeon_data{
	    no = 10080,
    	lv = 1,
    	timing = 2400,
    	group = 10080,
        pass_group = 10080,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 80,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3080],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390080,
		first_reward = 391008
   }
			;
   
get(10081) ->
	#dungeon_data{
	    no = 10081,
    	lv = 1,
    	timing = 2400,
    	group = 10081,
        pass_group = 10081,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 81,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3081],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390081,
		first_reward = 0
   }
			;
   
get(10082) ->
	#dungeon_data{
	    no = 10082,
    	lv = 1,
    	timing = 2400,
    	group = 10082,
        pass_group = 10082,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 82,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3082],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390082,
		first_reward = 0
   }
			;
   
get(10083) ->
	#dungeon_data{
	    no = 10083,
    	lv = 1,
    	timing = 2400,
    	group = 10083,
        pass_group = 10083,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 83,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3083],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390083,
		first_reward = 0
   }
			;
   
get(10084) ->
	#dungeon_data{
	    no = 10084,
    	lv = 1,
    	timing = 2400,
    	group = 10084,
        pass_group = 10084,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 84,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3084],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390084,
		first_reward = 0
   }
			;
   
get(10085) ->
	#dungeon_data{
	    no = 10085,
    	lv = 1,
    	timing = 2400,
    	group = 10085,
        pass_group = 10085,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 85,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3085],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390085,
		first_reward = 0
   }
			;
   
get(10086) ->
	#dungeon_data{
	    no = 10086,
    	lv = 1,
    	timing = 2400,
    	group = 10086,
        pass_group = 10086,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 86,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3086],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390086,
		first_reward = 0
   }
			;
   
get(10087) ->
	#dungeon_data{
	    no = 10087,
    	lv = 1,
    	timing = 2400,
    	group = 10087,
        pass_group = 10087,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 87,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3087],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390087,
		first_reward = 0
   }
			;
   
get(10088) ->
	#dungeon_data{
	    no = 10088,
    	lv = 1,
    	timing = 2400,
    	group = 10088,
        pass_group = 10088,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 88,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3088],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390088,
		first_reward = 0
   }
			;
   
get(10089) ->
	#dungeon_data{
	    no = 10089,
    	lv = 1,
    	timing = 2400,
    	group = 10089,
        pass_group = 10089,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 89,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3089],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390089,
		first_reward = 0
   }
			;
   
get(10090) ->
	#dungeon_data{
	    no = 10090,
    	lv = 1,
    	timing = 2400,
    	group = 10090,
        pass_group = 10090,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 90,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3090],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390090,
		first_reward = 391009
   }
			;
   
get(10091) ->
	#dungeon_data{
	    no = 10091,
    	lv = 1,
    	timing = 2400,
    	group = 10091,
        pass_group = 10091,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 91,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3091],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390091,
		first_reward = 0
   }
			;
   
get(10092) ->
	#dungeon_data{
	    no = 10092,
    	lv = 1,
    	timing = 2400,
    	group = 10092,
        pass_group = 10092,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 92,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3092],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390092,
		first_reward = 0
   }
			;
   
get(10093) ->
	#dungeon_data{
	    no = 10093,
    	lv = 1,
    	timing = 2400,
    	group = 10093,
        pass_group = 10093,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 93,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3093],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390093,
		first_reward = 0
   }
			;
   
get(10094) ->
	#dungeon_data{
	    no = 10094,
    	lv = 1,
    	timing = 2400,
    	group = 10094,
        pass_group = 10094,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 94,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3094],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390094,
		first_reward = 0
   }
			;
   
get(10095) ->
	#dungeon_data{
	    no = 10095,
    	lv = 1,
    	timing = 2400,
    	group = 10095,
        pass_group = 10095,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 95,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3095],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390095,
		first_reward = 0
   }
			;
   
get(10096) ->
	#dungeon_data{
	    no = 10096,
    	lv = 1,
    	timing = 2400,
    	group = 10096,
        pass_group = 10096,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 96,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3096],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390096,
		first_reward = 0
   }
			;
   
get(10097) ->
	#dungeon_data{
	    no = 10097,
    	lv = 1,
    	timing = 2400,
    	group = 10097,
        pass_group = 10097,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 97,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3097],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390097,
		first_reward = 0
   }
			;
   
get(10098) ->
	#dungeon_data{
	    no = 10098,
    	lv = 1,
    	timing = 2400,
    	group = 10098,
        pass_group = 10098,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 98,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3098],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390098,
		first_reward = 0
   }
			;
   
get(10099) ->
	#dungeon_data{
	    no = 10099,
    	lv = 1,
    	timing = 2400,
    	group = 10099,
        pass_group = 10099,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 99,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3099],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390099,
		first_reward = 0
   }
			;
   
get(10100) ->
	#dungeon_data{
	    no = 10100,
    	lv = 1,
    	timing = 2400,
    	group = 10100,
        pass_group = 10100,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 100,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3100],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390100,
		first_reward = 391010
   }
			;
   
get(10101) ->
	#dungeon_data{
	    no = 10101,
    	lv = 1,
    	timing = 2400,
    	group = 10101,
        pass_group = 10101,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 101,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3101],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390101,
		first_reward = 0
   }
			;
   
get(10102) ->
	#dungeon_data{
	    no = 10102,
    	lv = 1,
    	timing = 2400,
    	group = 10102,
        pass_group = 10102,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 102,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3102],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390102,
		first_reward = 0
   }
			;
   
get(10103) ->
	#dungeon_data{
	    no = 10103,
    	lv = 1,
    	timing = 2400,
    	group = 10103,
        pass_group = 10103,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 103,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3103],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390103,
		first_reward = 0
   }
			;
   
get(10104) ->
	#dungeon_data{
	    no = 10104,
    	lv = 1,
    	timing = 2400,
    	group = 10104,
        pass_group = 10104,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 104,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3104],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390104,
		first_reward = 0
   }
			;
   
get(10105) ->
	#dungeon_data{
	    no = 10105,
    	lv = 1,
    	timing = 2400,
    	group = 10105,
        pass_group = 10105,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 105,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3105],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390105,
		first_reward = 0
   }
			;
   
get(10106) ->
	#dungeon_data{
	    no = 10106,
    	lv = 1,
    	timing = 2400,
    	group = 10106,
        pass_group = 10106,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 106,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3106],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390106,
		first_reward = 0
   }
			;
   
get(10107) ->
	#dungeon_data{
	    no = 10107,
    	lv = 1,
    	timing = 2400,
    	group = 10107,
        pass_group = 10107,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 107,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3107],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390107,
		first_reward = 0
   }
			;
   
get(10108) ->
	#dungeon_data{
	    no = 10108,
    	lv = 1,
    	timing = 2400,
    	group = 10108,
        pass_group = 10108,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 108,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3108],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390108,
		first_reward = 0
   }
			;
   
get(10109) ->
	#dungeon_data{
	    no = 10109,
    	lv = 1,
    	timing = 2400,
    	group = 10109,
        pass_group = 10109,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 109,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3109],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390109,
		first_reward = 0
   }
			;
   
get(10110) ->
	#dungeon_data{
	    no = 10110,
    	lv = 1,
    	timing = 2400,
    	group = 10110,
        pass_group = 10110,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 110,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3110],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390110,
		first_reward = 391011
   }
			;
   
get(10111) ->
	#dungeon_data{
	    no = 10111,
    	lv = 1,
    	timing = 2400,
    	group = 10111,
        pass_group = 10111,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 111,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3111],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390111,
		first_reward = 0
   }
			;
   
get(10112) ->
	#dungeon_data{
	    no = 10112,
    	lv = 1,
    	timing = 2400,
    	group = 10112,
        pass_group = 10112,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 112,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3112],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390112,
		first_reward = 0
   }
			;
   
get(10113) ->
	#dungeon_data{
	    no = 10113,
    	lv = 1,
    	timing = 2400,
    	group = 10113,
        pass_group = 10113,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 113,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3113],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390113,
		first_reward = 0
   }
			;
   
get(10114) ->
	#dungeon_data{
	    no = 10114,
    	lv = 1,
    	timing = 2400,
    	group = 10114,
        pass_group = 10114,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 114,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3114],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390114,
		first_reward = 0
   }
			;
   
get(10115) ->
	#dungeon_data{
	    no = 10115,
    	lv = 1,
    	timing = 2400,
    	group = 10115,
        pass_group = 10115,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 115,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3115],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390115,
		first_reward = 0
   }
			;
   
get(10116) ->
	#dungeon_data{
	    no = 10116,
    	lv = 1,
    	timing = 2400,
    	group = 10116,
        pass_group = 10116,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 116,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3116],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390116,
		first_reward = 0
   }
			;
   
get(10117) ->
	#dungeon_data{
	    no = 10117,
    	lv = 1,
    	timing = 2400,
    	group = 10117,
        pass_group = 10117,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 117,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3117],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390117,
		first_reward = 0
   }
			;
   
get(10118) ->
	#dungeon_data{
	    no = 10118,
    	lv = 1,
    	timing = 2400,
    	group = 10118,
        pass_group = 10118,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 118,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3118],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390118,
		first_reward = 0
   }
			;
   
get(10119) ->
	#dungeon_data{
	    no = 10119,
    	lv = 1,
    	timing = 2400,
    	group = 10119,
        pass_group = 10119,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 119,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3119],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390119,
		first_reward = 0
   }
			;
   
get(10120) ->
	#dungeon_data{
	    no = 10120,
    	lv = 1,
    	timing = 2400,
    	group = 10120,
        pass_group = 10120,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 120,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3120],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390120,
		first_reward = 391012
   }
			;
   
get(10121) ->
	#dungeon_data{
	    no = 10121,
    	lv = 1,
    	timing = 2400,
    	group = 10121,
        pass_group = 10121,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 121,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3121],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390121,
		first_reward = 0
   }
			;
   
get(10122) ->
	#dungeon_data{
	    no = 10122,
    	lv = 1,
    	timing = 2400,
    	group = 10122,
        pass_group = 10122,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 122,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3122],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390122,
		first_reward = 0
   }
			;
   
get(10123) ->
	#dungeon_data{
	    no = 10123,
    	lv = 1,
    	timing = 2400,
    	group = 10123,
        pass_group = 10123,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 123,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3123],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390123,
		first_reward = 0
   }
			;
   
get(10124) ->
	#dungeon_data{
	    no = 10124,
    	lv = 1,
    	timing = 2400,
    	group = 10124,
        pass_group = 10124,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 124,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3124],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390124,
		first_reward = 0
   }
			;
   
get(10125) ->
	#dungeon_data{
	    no = 10125,
    	lv = 1,
    	timing = 2400,
    	group = 10125,
        pass_group = 10125,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 125,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3125],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390125,
		first_reward = 0
   }
			;
   
get(10126) ->
	#dungeon_data{
	    no = 10126,
    	lv = 1,
    	timing = 2400,
    	group = 10126,
        pass_group = 10126,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 126,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3126],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390126,
		first_reward = 0
   }
			;
   
get(10127) ->
	#dungeon_data{
	    no = 10127,
    	lv = 1,
    	timing = 2400,
    	group = 10127,
        pass_group = 10127,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 127,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3127],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390127,
		first_reward = 0
   }
			;
   
get(10128) ->
	#dungeon_data{
	    no = 10128,
    	lv = 1,
    	timing = 2400,
    	group = 10128,
        pass_group = 10128,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 128,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3128],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390128,
		first_reward = 0
   }
			;
   
get(10129) ->
	#dungeon_data{
	    no = 10129,
    	lv = 1,
    	timing = 2400,
    	group = 10129,
        pass_group = 10129,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 129,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3129],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390129,
		first_reward = 0
   }
			;
   
get(10130) ->
	#dungeon_data{
	    no = 10130,
    	lv = 1,
    	timing = 2400,
    	group = 10130,
        pass_group = 10130,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 130,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3130],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390130,
		first_reward = 391013
   }
			;
   
get(10131) ->
	#dungeon_data{
	    no = 10131,
    	lv = 1,
    	timing = 2400,
    	group = 10131,
        pass_group = 10131,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 131,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3131],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390131,
		first_reward = 0
   }
			;
   
get(10132) ->
	#dungeon_data{
	    no = 10132,
    	lv = 1,
    	timing = 2400,
    	group = 10132,
        pass_group = 10132,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 132,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3132],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390132,
		first_reward = 0
   }
			;
   
get(10133) ->
	#dungeon_data{
	    no = 10133,
    	lv = 1,
    	timing = 2400,
    	group = 10133,
        pass_group = 10133,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 133,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3133],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390133,
		first_reward = 0
   }
			;
   
get(10134) ->
	#dungeon_data{
	    no = 10134,
    	lv = 1,
    	timing = 2400,
    	group = 10134,
        pass_group = 10134,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 134,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3134],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390134,
		first_reward = 0
   }
			;
   
get(10135) ->
	#dungeon_data{
	    no = 10135,
    	lv = 1,
    	timing = 2400,
    	group = 10135,
        pass_group = 10135,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 135,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3135],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390135,
		first_reward = 0
   }
			;
   
get(10136) ->
	#dungeon_data{
	    no = 10136,
    	lv = 1,
    	timing = 2400,
    	group = 10136,
        pass_group = 10136,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 136,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3136],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390136,
		first_reward = 0
   }
			;
   
get(10137) ->
	#dungeon_data{
	    no = 10137,
    	lv = 1,
    	timing = 2400,
    	group = 10137,
        pass_group = 10137,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 137,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3137],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390137,
		first_reward = 0
   }
			;
   
get(10138) ->
	#dungeon_data{
	    no = 10138,
    	lv = 1,
    	timing = 2400,
    	group = 10138,
        pass_group = 10138,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 138,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3138],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390138,
		first_reward = 0
   }
			;
   
get(10139) ->
	#dungeon_data{
	    no = 10139,
    	lv = 1,
    	timing = 2400,
    	group = 10139,
        pass_group = 10139,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 139,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3139],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390139,
		first_reward = 0
   }
			;
   
get(10140) ->
	#dungeon_data{
	    no = 10140,
    	lv = 1,
    	timing = 2400,
    	group = 10140,
        pass_group = 10140,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 140,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3140],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390140,
		first_reward = 391014
   }
			;
   
get(10141) ->
	#dungeon_data{
	    no = 10141,
    	lv = 1,
    	timing = 2400,
    	group = 10141,
        pass_group = 10141,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 141,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3141],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390141,
		first_reward = 0
   }
			;
   
get(10142) ->
	#dungeon_data{
	    no = 10142,
    	lv = 1,
    	timing = 2400,
    	group = 10142,
        pass_group = 10142,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 142,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3142],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390142,
		first_reward = 0
   }
			;
   
get(10143) ->
	#dungeon_data{
	    no = 10143,
    	lv = 1,
    	timing = 2400,
    	group = 10143,
        pass_group = 10143,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 143,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3143],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390143,
		first_reward = 0
   }
			;
   
get(10144) ->
	#dungeon_data{
	    no = 10144,
    	lv = 1,
    	timing = 2400,
    	group = 10144,
        pass_group = 10144,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 144,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3144],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390144,
		first_reward = 0
   }
			;
   
get(10145) ->
	#dungeon_data{
	    no = 10145,
    	lv = 1,
    	timing = 2400,
    	group = 10145,
        pass_group = 10145,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 145,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3145],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390145,
		first_reward = 0
   }
			;
   
get(10146) ->
	#dungeon_data{
	    no = 10146,
    	lv = 1,
    	timing = 2400,
    	group = 10146,
        pass_group = 10146,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 146,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3146],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390146,
		first_reward = 0
   }
			;
   
get(10147) ->
	#dungeon_data{
	    no = 10147,
    	lv = 1,
    	timing = 2400,
    	group = 10147,
        pass_group = 10147,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 147,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3147],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390147,
		first_reward = 0
   }
			;
   
get(10148) ->
	#dungeon_data{
	    no = 10148,
    	lv = 1,
    	timing = 2400,
    	group = 10148,
        pass_group = 10148,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 148,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3148],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390148,
		first_reward = 0
   }
			;
   
get(10149) ->
	#dungeon_data{
	    no = 10149,
    	lv = 1,
    	timing = 2400,
    	group = 10149,
        pass_group = 10149,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 149,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3149],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390149,
		first_reward = 0
   }
			;
   
get(10150) ->
	#dungeon_data{
	    no = 10150,
    	lv = 1,
    	timing = 2400,
    	group = 10150,
        pass_group = 10150,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 150,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3150],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390150,
		first_reward = 391015
   }
			;
   
get(10151) ->
	#dungeon_data{
	    no = 10151,
    	lv = 1,
    	timing = 2400,
    	group = 10151,
        pass_group = 10151,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 151,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3151],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390151,
		first_reward = 0
   }
			;
   
get(10152) ->
	#dungeon_data{
	    no = 10152,
    	lv = 1,
    	timing = 2400,
    	group = 10152,
        pass_group = 10152,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 152,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3152],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390152,
		first_reward = 0
   }
			;
   
get(10153) ->
	#dungeon_data{
	    no = 10153,
    	lv = 1,
    	timing = 2400,
    	group = 10153,
        pass_group = 10153,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 153,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3153],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390153,
		first_reward = 0
   }
			;
   
get(10154) ->
	#dungeon_data{
	    no = 10154,
    	lv = 1,
    	timing = 2400,
    	group = 10154,
        pass_group = 10154,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 154,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3154],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390154,
		first_reward = 0
   }
			;
   
get(10155) ->
	#dungeon_data{
	    no = 10155,
    	lv = 1,
    	timing = 2400,
    	group = 10155,
        pass_group = 10155,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 155,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3155],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390155,
		first_reward = 0
   }
			;
   
get(10156) ->
	#dungeon_data{
	    no = 10156,
    	lv = 1,
    	timing = 2400,
    	group = 10156,
        pass_group = 10156,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 156,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3156],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390156,
		first_reward = 0
   }
			;
   
get(10157) ->
	#dungeon_data{
	    no = 10157,
    	lv = 1,
    	timing = 2400,
    	group = 10157,
        pass_group = 10157,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 157,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3157],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390157,
		first_reward = 0
   }
			;
   
get(10158) ->
	#dungeon_data{
	    no = 10158,
    	lv = 1,
    	timing = 2400,
    	group = 10158,
        pass_group = 10158,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 158,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3158],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390158,
		first_reward = 0
   }
			;
   
get(10159) ->
	#dungeon_data{
	    no = 10159,
    	lv = 1,
    	timing = 2400,
    	group = 10159,
        pass_group = 10159,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 159,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3159],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390159,
		first_reward = 0
   }
			;
   
get(10160) ->
	#dungeon_data{
	    no = 10160,
    	lv = 1,
    	timing = 2400,
    	group = 10160,
        pass_group = 10160,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 160,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3160],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390160,
		first_reward = 391016
   }
			;
   
get(10161) ->
	#dungeon_data{
	    no = 10161,
    	lv = 1,
    	timing = 2400,
    	group = 10161,
        pass_group = 10161,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 161,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3161],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390161,
		first_reward = 0
   }
			;
   
get(10162) ->
	#dungeon_data{
	    no = 10162,
    	lv = 1,
    	timing = 2400,
    	group = 10162,
        pass_group = 10162,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 162,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3162],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390162,
		first_reward = 0
   }
			;
   
get(10163) ->
	#dungeon_data{
	    no = 10163,
    	lv = 1,
    	timing = 2400,
    	group = 10163,
        pass_group = 10163,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 163,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3163],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390163,
		first_reward = 0
   }
			;
   
get(10164) ->
	#dungeon_data{
	    no = 10164,
    	lv = 1,
    	timing = 2400,
    	group = 10164,
        pass_group = 10164,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 164,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3164],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390164,
		first_reward = 0
   }
			;
   
get(10165) ->
	#dungeon_data{
	    no = 10165,
    	lv = 1,
    	timing = 2400,
    	group = 10165,
        pass_group = 10165,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 165,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3165],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390165,
		first_reward = 0
   }
			;
   
get(10166) ->
	#dungeon_data{
	    no = 10166,
    	lv = 1,
    	timing = 2400,
    	group = 10166,
        pass_group = 10166,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 166,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3166],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390166,
		first_reward = 0
   }
			;
   
get(10167) ->
	#dungeon_data{
	    no = 10167,
    	lv = 1,
    	timing = 2400,
    	group = 10167,
        pass_group = 10167,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 167,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3167],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390167,
		first_reward = 0
   }
			;
   
get(10168) ->
	#dungeon_data{
	    no = 10168,
    	lv = 1,
    	timing = 2400,
    	group = 10168,
        pass_group = 10168,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 168,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3168],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390168,
		first_reward = 0
   }
			;
   
get(10169) ->
	#dungeon_data{
	    no = 10169,
    	lv = 1,
    	timing = 2400,
    	group = 10169,
        pass_group = 10169,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 169,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3169],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390169,
		first_reward = 0
   }
			;
   
get(10170) ->
	#dungeon_data{
	    no = 10170,
    	lv = 1,
    	timing = 2400,
    	group = 10170,
        pass_group = 10170,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 170,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3170],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390170,
		first_reward = 391017
   }
			;
   
get(10171) ->
	#dungeon_data{
	    no = 10171,
    	lv = 1,
    	timing = 2400,
    	group = 10171,
        pass_group = 10171,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 171,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3171],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390171,
		first_reward = 0
   }
			;
   
get(10172) ->
	#dungeon_data{
	    no = 10172,
    	lv = 1,
    	timing = 2400,
    	group = 10172,
        pass_group = 10172,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 172,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3172],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390172,
		first_reward = 0
   }
			;
   
get(10173) ->
	#dungeon_data{
	    no = 10173,
    	lv = 1,
    	timing = 2400,
    	group = 10173,
        pass_group = 10173,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 173,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3173],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390173,
		first_reward = 0
   }
			;
   
get(10174) ->
	#dungeon_data{
	    no = 10174,
    	lv = 1,
    	timing = 2400,
    	group = 10174,
        pass_group = 10174,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 174,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3174],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390174,
		first_reward = 0
   }
			;
   
get(10175) ->
	#dungeon_data{
	    no = 10175,
    	lv = 1,
    	timing = 2400,
    	group = 10175,
        pass_group = 10175,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 175,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3175],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390175,
		first_reward = 0
   }
			;
   
get(10176) ->
	#dungeon_data{
	    no = 10176,
    	lv = 1,
    	timing = 2400,
    	group = 10176,
        pass_group = 10176,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 176,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3176],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390176,
		first_reward = 0
   }
			;
   
get(10177) ->
	#dungeon_data{
	    no = 10177,
    	lv = 1,
    	timing = 2400,
    	group = 10177,
        pass_group = 10177,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 177,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3177],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390177,
		first_reward = 0
   }
			;
   
get(10178) ->
	#dungeon_data{
	    no = 10178,
    	lv = 1,
    	timing = 2400,
    	group = 10178,
        pass_group = 10178,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 178,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3178],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390178,
		first_reward = 0
   }
			;
   
get(10179) ->
	#dungeon_data{
	    no = 10179,
    	lv = 1,
    	timing = 2400,
    	group = 10179,
        pass_group = 10179,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 179,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3179],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390179,
		first_reward = 0
   }
			;
   
get(10180) ->
	#dungeon_data{
	    no = 10180,
    	lv = 1,
    	timing = 2400,
    	group = 10180,
        pass_group = 10180,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 180,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3180],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390180,
		first_reward = 391018
   }
			;
   
get(10181) ->
	#dungeon_data{
	    no = 10181,
    	lv = 1,
    	timing = 2400,
    	group = 10181,
        pass_group = 10181,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 181,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3181],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390181,
		first_reward = 0
   }
			;
   
get(10182) ->
	#dungeon_data{
	    no = 10182,
    	lv = 1,
    	timing = 2400,
    	group = 10182,
        pass_group = 10182,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 182,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3182],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390182,
		first_reward = 0
   }
			;
   
get(10183) ->
	#dungeon_data{
	    no = 10183,
    	lv = 1,
    	timing = 2400,
    	group = 10183,
        pass_group = 10183,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 183,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3183],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390183,
		first_reward = 0
   }
			;
   
get(10184) ->
	#dungeon_data{
	    no = 10184,
    	lv = 1,
    	timing = 2400,
    	group = 10184,
        pass_group = 10184,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 184,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3184],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390184,
		first_reward = 0
   }
			;
   
get(10185) ->
	#dungeon_data{
	    no = 10185,
    	lv = 1,
    	timing = 2400,
    	group = 10185,
        pass_group = 10185,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 185,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3185],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390185,
		first_reward = 0
   }
			;
   
get(10186) ->
	#dungeon_data{
	    no = 10186,
    	lv = 1,
    	timing = 2400,
    	group = 10186,
        pass_group = 10186,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 186,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3186],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390186,
		first_reward = 0
   }
			;
   
get(10187) ->
	#dungeon_data{
	    no = 10187,
    	lv = 1,
    	timing = 2400,
    	group = 10187,
        pass_group = 10187,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 187,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3187],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390187,
		first_reward = 0
   }
			;
   
get(10188) ->
	#dungeon_data{
	    no = 10188,
    	lv = 1,
    	timing = 2400,
    	group = 10188,
        pass_group = 10188,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 188,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3188],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390188,
		first_reward = 0
   }
			;
   
get(10189) ->
	#dungeon_data{
	    no = 10189,
    	lv = 1,
    	timing = 2400,
    	group = 10189,
        pass_group = 10189,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 189,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3189],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390189,
		first_reward = 0
   }
			;
   
get(10190) ->
	#dungeon_data{
	    no = 10190,
    	lv = 1,
    	timing = 2400,
    	group = 10190,
        pass_group = 10190,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 190,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3190],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390190,
		first_reward = 391019
   }
			;
   
get(10191) ->
	#dungeon_data{
	    no = 10191,
    	lv = 1,
    	timing = 2400,
    	group = 10191,
        pass_group = 10191,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 191,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3191],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390191,
		first_reward = 0
   }
			;
   
get(10192) ->
	#dungeon_data{
	    no = 10192,
    	lv = 1,
    	timing = 2400,
    	group = 10192,
        pass_group = 10192,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 192,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3192],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390192,
		first_reward = 0
   }
			;
   
get(10193) ->
	#dungeon_data{
	    no = 10193,
    	lv = 1,
    	timing = 2400,
    	group = 10193,
        pass_group = 10193,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 193,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3193],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390193,
		first_reward = 0
   }
			;
   
get(10194) ->
	#dungeon_data{
	    no = 10194,
    	lv = 1,
    	timing = 2400,
    	group = 10194,
        pass_group = 10194,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 194,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3194],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390194,
		first_reward = 0
   }
			;
   
get(10195) ->
	#dungeon_data{
	    no = 10195,
    	lv = 1,
    	timing = 2400,
    	group = 10195,
        pass_group = 10195,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 195,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3195],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390195,
		first_reward = 0
   }
			;
   
get(10196) ->
	#dungeon_data{
	    no = 10196,
    	lv = 1,
    	timing = 2400,
    	group = 10196,
        pass_group = 10196,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 196,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3196],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390196,
		first_reward = 0
   }
			;
   
get(10197) ->
	#dungeon_data{
	    no = 10197,
    	lv = 1,
    	timing = 2400,
    	group = 10197,
        pass_group = 10197,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 197,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3197],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390197,
		first_reward = 0
   }
			;
   
get(10198) ->
	#dungeon_data{
	    no = 10198,
    	lv = 1,
    	timing = 2400,
    	group = 10198,
        pass_group = 10198,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 198,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3198],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390198,
		first_reward = 0
   }
			;
   
get(10199) ->
	#dungeon_data{
	    no = 10199,
    	lv = 1,
    	timing = 2400,
    	group = 10199,
        pass_group = 10199,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 199,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3199],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390199,
		first_reward = 0
   }
			;
   
get(10200) ->
	#dungeon_data{
	    no = 10200,
    	lv = 1,
    	timing = 2400,
    	group = 10200,
        pass_group = 10200,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 200,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3200],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390200,
		first_reward = 391020
   }
			;
   
get(10201) ->
	#dungeon_data{
	    no = 10201,
    	lv = 1,
    	timing = 2400,
    	group = 10201,
        pass_group = 10201,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 201,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3201],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390201,
		first_reward = 0
   }
			;
   
get(10202) ->
	#dungeon_data{
	    no = 10202,
    	lv = 1,
    	timing = 2400,
    	group = 10202,
        pass_group = 10202,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 202,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3202],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390202,
		first_reward = 0
   }
			;
   
get(10203) ->
	#dungeon_data{
	    no = 10203,
    	lv = 1,
    	timing = 2400,
    	group = 10203,
        pass_group = 10203,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 203,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3203],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390203,
		first_reward = 0
   }
			;
   
get(10204) ->
	#dungeon_data{
	    no = 10204,
    	lv = 1,
    	timing = 2400,
    	group = 10204,
        pass_group = 10204,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 204,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3204],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390204,
		first_reward = 0
   }
			;
   
get(10205) ->
	#dungeon_data{
	    no = 10205,
    	lv = 1,
    	timing = 2400,
    	group = 10205,
        pass_group = 10205,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 205,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3205],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390205,
		first_reward = 0
   }
			;
   
get(10206) ->
	#dungeon_data{
	    no = 10206,
    	lv = 1,
    	timing = 2400,
    	group = 10206,
        pass_group = 10206,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 206,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3206],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390206,
		first_reward = 0
   }
			;
   
get(10207) ->
	#dungeon_data{
	    no = 10207,
    	lv = 1,
    	timing = 2400,
    	group = 10207,
        pass_group = 10207,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 207,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3207],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390207,
		first_reward = 0
   }
			;
   
get(10208) ->
	#dungeon_data{
	    no = 10208,
    	lv = 1,
    	timing = 2400,
    	group = 10208,
        pass_group = 10208,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 208,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3208],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390208,
		first_reward = 0
   }
			;
   
get(10209) ->
	#dungeon_data{
	    no = 10209,
    	lv = 1,
    	timing = 2400,
    	group = 10209,
        pass_group = 10209,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 209,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3209],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390209,
		first_reward = 0
   }
			;
   
get(10210) ->
	#dungeon_data{
	    no = 10210,
    	lv = 1,
    	timing = 2400,
    	group = 10210,
        pass_group = 10210,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 210,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3210],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390210,
		first_reward = 391021
   }
			;
   
get(10211) ->
	#dungeon_data{
	    no = 10211,
    	lv = 1,
    	timing = 2400,
    	group = 10211,
        pass_group = 10211,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 211,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3211],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390211,
		first_reward = 0
   }
			;
   
get(10212) ->
	#dungeon_data{
	    no = 10212,
    	lv = 1,
    	timing = 2400,
    	group = 10212,
        pass_group = 10212,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 212,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3212],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390212,
		first_reward = 0
   }
			;
   
get(10213) ->
	#dungeon_data{
	    no = 10213,
    	lv = 1,
    	timing = 2400,
    	group = 10213,
        pass_group = 10213,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 213,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3213],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390213,
		first_reward = 0
   }
			;
   
get(10214) ->
	#dungeon_data{
	    no = 10214,
    	lv = 1,
    	timing = 2400,
    	group = 10214,
        pass_group = 10214,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 214,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3214],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390214,
		first_reward = 0
   }
			;
   
get(10215) ->
	#dungeon_data{
	    no = 10215,
    	lv = 1,
    	timing = 2400,
    	group = 10215,
        pass_group = 10215,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 215,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3215],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390215,
		first_reward = 0
   }
			;
   
get(10216) ->
	#dungeon_data{
	    no = 10216,
    	lv = 1,
    	timing = 2400,
    	group = 10216,
        pass_group = 10216,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 216,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3216],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390216,
		first_reward = 0
   }
			;
   
get(10217) ->
	#dungeon_data{
	    no = 10217,
    	lv = 1,
    	timing = 2400,
    	group = 10217,
        pass_group = 10217,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 217,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3217],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390217,
		first_reward = 0
   }
			;
   
get(10218) ->
	#dungeon_data{
	    no = 10218,
    	lv = 1,
    	timing = 2400,
    	group = 10218,
        pass_group = 10218,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 218,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3218],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390218,
		first_reward = 0
   }
			;
   
get(10219) ->
	#dungeon_data{
	    no = 10219,
    	lv = 1,
    	timing = 2400,
    	group = 10219,
        pass_group = 10219,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 219,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3219],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390219,
		first_reward = 0
   }
			;
   
get(10220) ->
	#dungeon_data{
	    no = 10220,
    	lv = 1,
    	timing = 2400,
    	group = 10220,
        pass_group = 10220,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 220,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3220],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390220,
		first_reward = 391022
   }
			;
   
get(10221) ->
	#dungeon_data{
	    no = 10221,
    	lv = 1,
    	timing = 2400,
    	group = 10221,
        pass_group = 10221,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 221,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3221],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390221,
		first_reward = 0
   }
			;
   
get(10222) ->
	#dungeon_data{
	    no = 10222,
    	lv = 1,
    	timing = 2400,
    	group = 10222,
        pass_group = 10222,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 222,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3222],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390222,
		first_reward = 0
   }
			;
   
get(10223) ->
	#dungeon_data{
	    no = 10223,
    	lv = 1,
    	timing = 2400,
    	group = 10223,
        pass_group = 10223,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 223,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3223],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390223,
		first_reward = 0
   }
			;
   
get(10224) ->
	#dungeon_data{
	    no = 10224,
    	lv = 1,
    	timing = 2400,
    	group = 10224,
        pass_group = 10224,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 224,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3224],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390224,
		first_reward = 0
   }
			;
   
get(10225) ->
	#dungeon_data{
	    no = 10225,
    	lv = 1,
    	timing = 2400,
    	group = 10225,
        pass_group = 10225,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 225,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3225],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390225,
		first_reward = 0
   }
			;
   
get(10226) ->
	#dungeon_data{
	    no = 10226,
    	lv = 1,
    	timing = 2400,
    	group = 10226,
        pass_group = 10226,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 226,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3226],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390226,
		first_reward = 0
   }
			;
   
get(10227) ->
	#dungeon_data{
	    no = 10227,
    	lv = 1,
    	timing = 2400,
    	group = 10227,
        pass_group = 10227,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 227,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3227],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390227,
		first_reward = 0
   }
			;
   
get(10228) ->
	#dungeon_data{
	    no = 10228,
    	lv = 1,
    	timing = 2400,
    	group = 10228,
        pass_group = 10228,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 228,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3228],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390228,
		first_reward = 0
   }
			;
   
get(10229) ->
	#dungeon_data{
	    no = 10229,
    	lv = 1,
    	timing = 2400,
    	group = 10229,
        pass_group = 10229,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 229,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3229],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390229,
		first_reward = 0
   }
			;
   
get(10230) ->
	#dungeon_data{
	    no = 10230,
    	lv = 1,
    	timing = 2400,
    	group = 10230,
        pass_group = 10230,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 230,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3230],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390230,
		first_reward = 391023
   }
			;
   
get(10231) ->
	#dungeon_data{
	    no = 10231,
    	lv = 1,
    	timing = 2400,
    	group = 10231,
        pass_group = 10231,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 231,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3231],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390231,
		first_reward = 0
   }
			;
   
get(10232) ->
	#dungeon_data{
	    no = 10232,
    	lv = 1,
    	timing = 2400,
    	group = 10232,
        pass_group = 10232,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 232,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3232],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390232,
		first_reward = 0
   }
			;
   
get(10233) ->
	#dungeon_data{
	    no = 10233,
    	lv = 1,
    	timing = 2400,
    	group = 10233,
        pass_group = 10233,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 233,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3233],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390233,
		first_reward = 0
   }
			;
   
get(10234) ->
	#dungeon_data{
	    no = 10234,
    	lv = 1,
    	timing = 2400,
    	group = 10234,
        pass_group = 10234,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 234,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3234],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390234,
		first_reward = 0
   }
			;
   
get(10235) ->
	#dungeon_data{
	    no = 10235,
    	lv = 1,
    	timing = 2400,
    	group = 10235,
        pass_group = 10235,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 235,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3235],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390235,
		first_reward = 0
   }
			;
   
get(10236) ->
	#dungeon_data{
	    no = 10236,
    	lv = 1,
    	timing = 2400,
    	group = 10236,
        pass_group = 10236,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 236,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3236],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390236,
		first_reward = 0
   }
			;
   
get(10237) ->
	#dungeon_data{
	    no = 10237,
    	lv = 1,
    	timing = 2400,
    	group = 10237,
        pass_group = 10237,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 237,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3237],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390237,
		first_reward = 0
   }
			;
   
get(10238) ->
	#dungeon_data{
	    no = 10238,
    	lv = 1,
    	timing = 2400,
    	group = 10238,
        pass_group = 10238,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 238,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3238],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390238,
		first_reward = 0
   }
			;
   
get(10239) ->
	#dungeon_data{
	    no = 10239,
    	lv = 1,
    	timing = 2400,
    	group = 10239,
        pass_group = 10239,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 239,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3239],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390239,
		first_reward = 0
   }
			;
   
get(10240) ->
	#dungeon_data{
	    no = 10240,
    	lv = 1,
    	timing = 2400,
    	group = 10240,
        pass_group = 10240,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 240,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3240],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390240,
		first_reward = 391024
   }
			;
   
get(10241) ->
	#dungeon_data{
	    no = 10241,
    	lv = 1,
    	timing = 2400,
    	group = 10241,
        pass_group = 10241,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 241,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3241],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390241,
		first_reward = 0
   }
			;
   
get(10242) ->
	#dungeon_data{
	    no = 10242,
    	lv = 1,
    	timing = 2400,
    	group = 10242,
        pass_group = 10242,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 242,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3242],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390242,
		first_reward = 0
   }
			;
   
get(10243) ->
	#dungeon_data{
	    no = 10243,
    	lv = 1,
    	timing = 2400,
    	group = 10243,
        pass_group = 10243,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 243,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3243],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390243,
		first_reward = 0
   }
			;
   
get(10244) ->
	#dungeon_data{
	    no = 10244,
    	lv = 1,
    	timing = 2400,
    	group = 10244,
        pass_group = 10244,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 244,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3244],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390244,
		first_reward = 0
   }
			;
   
get(10245) ->
	#dungeon_data{
	    no = 10245,
    	lv = 1,
    	timing = 2400,
    	group = 10245,
        pass_group = 10245,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 245,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3245],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390245,
		first_reward = 0
   }
			;
   
get(10246) ->
	#dungeon_data{
	    no = 10246,
    	lv = 1,
    	timing = 2400,
    	group = 10246,
        pass_group = 10246,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 246,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3246],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390246,
		first_reward = 0
   }
			;
   
get(10247) ->
	#dungeon_data{
	    no = 10247,
    	lv = 1,
    	timing = 2400,
    	group = 10247,
        pass_group = 10247,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 247,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3247],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390247,
		first_reward = 0
   }
			;
   
get(10248) ->
	#dungeon_data{
	    no = 10248,
    	lv = 1,
    	timing = 2400,
    	group = 10248,
        pass_group = 10248,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 248,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3248],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390248,
		first_reward = 0
   }
			;
   
get(10249) ->
	#dungeon_data{
	    no = 10249,
    	lv = 1,
    	timing = 2400,
    	group = 10249,
        pass_group = 10249,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 249,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3249],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390249,
		first_reward = 0
   }
			;
   
get(10250) ->
	#dungeon_data{
	    no = 10250,
    	lv = 1,
    	timing = 2400,
    	group = 10250,
        pass_group = 10250,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 250,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3250],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390250,
		first_reward = 391025
   }
			;
   
get(10251) ->
	#dungeon_data{
	    no = 10251,
    	lv = 1,
    	timing = 2400,
    	group = 10251,
        pass_group = 10251,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 251,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3251],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390251,
		first_reward = 0
   }
			;
   
get(10252) ->
	#dungeon_data{
	    no = 10252,
    	lv = 1,
    	timing = 2400,
    	group = 10252,
        pass_group = 10252,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 252,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3252],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390252,
		first_reward = 0
   }
			;
   
get(10253) ->
	#dungeon_data{
	    no = 10253,
    	lv = 1,
    	timing = 2400,
    	group = 10253,
        pass_group = 10253,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 253,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3253],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390253,
		first_reward = 0
   }
			;
   
get(10254) ->
	#dungeon_data{
	    no = 10254,
    	lv = 1,
    	timing = 2400,
    	group = 10254,
        pass_group = 10254,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 254,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3254],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390254,
		first_reward = 0
   }
			;
   
get(10255) ->
	#dungeon_data{
	    no = 10255,
    	lv = 1,
    	timing = 2400,
    	group = 10255,
        pass_group = 10255,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 255,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3255],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390255,
		first_reward = 0
   }
			;
   
get(10256) ->
	#dungeon_data{
	    no = 10256,
    	lv = 1,
    	timing = 2400,
    	group = 10256,
        pass_group = 10256,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 256,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3256],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390256,
		first_reward = 0
   }
			;
   
get(10257) ->
	#dungeon_data{
	    no = 10257,
    	lv = 1,
    	timing = 2400,
    	group = 10257,
        pass_group = 10257,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 257,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3257],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390257,
		first_reward = 0
   }
			;
   
get(10258) ->
	#dungeon_data{
	    no = 10258,
    	lv = 1,
    	timing = 2400,
    	group = 10258,
        pass_group = 10258,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 258,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3258],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390258,
		first_reward = 0
   }
			;
   
get(10259) ->
	#dungeon_data{
	    no = 10259,
    	lv = 1,
    	timing = 2400,
    	group = 10259,
        pass_group = 10259,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 259,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3259],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390259,
		first_reward = 0
   }
			;
   
get(10260) ->
	#dungeon_data{
	    no = 10260,
    	lv = 1,
    	timing = 2400,
    	group = 10260,
        pass_group = 10260,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 260,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3260],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390260,
		first_reward = 391026
   }
			;
   
get(10261) ->
	#dungeon_data{
	    no = 10261,
    	lv = 1,
    	timing = 2400,
    	group = 10261,
        pass_group = 10261,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 261,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3261],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390261,
		first_reward = 0
   }
			;
   
get(10262) ->
	#dungeon_data{
	    no = 10262,
    	lv = 1,
    	timing = 2400,
    	group = 10262,
        pass_group = 10262,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 262,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3262],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390262,
		first_reward = 0
   }
			;
   
get(10263) ->
	#dungeon_data{
	    no = 10263,
    	lv = 1,
    	timing = 2400,
    	group = 10263,
        pass_group = 10263,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 263,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3263],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390263,
		first_reward = 0
   }
			;
   
get(10264) ->
	#dungeon_data{
	    no = 10264,
    	lv = 1,
    	timing = 2400,
    	group = 10264,
        pass_group = 10264,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 264,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3264],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390264,
		first_reward = 0
   }
			;
   
get(10265) ->
	#dungeon_data{
	    no = 10265,
    	lv = 1,
    	timing = 2400,
    	group = 10265,
        pass_group = 10265,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 265,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3265],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390265,
		first_reward = 0
   }
			;
   
get(10266) ->
	#dungeon_data{
	    no = 10266,
    	lv = 1,
    	timing = 2400,
    	group = 10266,
        pass_group = 10266,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 266,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3266],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390266,
		first_reward = 0
   }
			;
   
get(10267) ->
	#dungeon_data{
	    no = 10267,
    	lv = 1,
    	timing = 2400,
    	group = 10267,
        pass_group = 10267,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 267,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3267],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390267,
		first_reward = 0
   }
			;
   
get(10268) ->
	#dungeon_data{
	    no = 10268,
    	lv = 1,
    	timing = 2400,
    	group = 10268,
        pass_group = 10268,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 268,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3268],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390268,
		first_reward = 0
   }
			;
   
get(10269) ->
	#dungeon_data{
	    no = 10269,
    	lv = 1,
    	timing = 2400,
    	group = 10269,
        pass_group = 10269,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 269,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3269],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390269,
		first_reward = 0
   }
			;
   
get(10270) ->
	#dungeon_data{
	    no = 10270,
    	lv = 1,
    	timing = 2400,
    	group = 10270,
        pass_group = 10270,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 270,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3270],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390270,
		first_reward = 391027
   }
			;
   
get(10271) ->
	#dungeon_data{
	    no = 10271,
    	lv = 1,
    	timing = 2400,
    	group = 10271,
        pass_group = 10271,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 271,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3271],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390271,
		first_reward = 0
   }
			;
   
get(10272) ->
	#dungeon_data{
	    no = 10272,
    	lv = 1,
    	timing = 2400,
    	group = 10272,
        pass_group = 10272,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 272,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3272],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390272,
		first_reward = 0
   }
			;
   
get(10273) ->
	#dungeon_data{
	    no = 10273,
    	lv = 1,
    	timing = 2400,
    	group = 10273,
        pass_group = 10273,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 273,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3273],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390273,
		first_reward = 0
   }
			;
   
get(10274) ->
	#dungeon_data{
	    no = 10274,
    	lv = 1,
    	timing = 2400,
    	group = 10274,
        pass_group = 10274,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 274,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3274],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390274,
		first_reward = 0
   }
			;
   
get(10275) ->
	#dungeon_data{
	    no = 10275,
    	lv = 1,
    	timing = 2400,
    	group = 10275,
        pass_group = 10275,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 275,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3275],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390275,
		first_reward = 0
   }
			;
   
get(10276) ->
	#dungeon_data{
	    no = 10276,
    	lv = 1,
    	timing = 2400,
    	group = 10276,
        pass_group = 10276,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 276,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3276],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390276,
		first_reward = 0
   }
			;
   
get(10277) ->
	#dungeon_data{
	    no = 10277,
    	lv = 1,
    	timing = 2400,
    	group = 10277,
        pass_group = 10277,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 277,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3277],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390277,
		first_reward = 0
   }
			;
   
get(10278) ->
	#dungeon_data{
	    no = 10278,
    	lv = 1,
    	timing = 2400,
    	group = 10278,
        pass_group = 10278,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 278,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3278],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390278,
		first_reward = 0
   }
			;
   
get(10279) ->
	#dungeon_data{
	    no = 10279,
    	lv = 1,
    	timing = 2400,
    	group = 10279,
        pass_group = 10279,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 279,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3279],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390279,
		first_reward = 0
   }
			;
   
get(10280) ->
	#dungeon_data{
	    no = 10280,
    	lv = 1,
    	timing = 2400,
    	group = 10280,
        pass_group = 10280,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 280,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3280],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390280,
		first_reward = 391028
   }
			;
   
get(10281) ->
	#dungeon_data{
	    no = 10281,
    	lv = 1,
    	timing = 2400,
    	group = 10281,
        pass_group = 10281,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 281,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3281],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390281,
		first_reward = 0
   }
			;
   
get(10282) ->
	#dungeon_data{
	    no = 10282,
    	lv = 1,
    	timing = 2400,
    	group = 10282,
        pass_group = 10282,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 282,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3282],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390282,
		first_reward = 0
   }
			;
   
get(10283) ->
	#dungeon_data{
	    no = 10283,
    	lv = 1,
    	timing = 2400,
    	group = 10283,
        pass_group = 10283,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 283,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3283],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390283,
		first_reward = 0
   }
			;
   
get(10284) ->
	#dungeon_data{
	    no = 10284,
    	lv = 1,
    	timing = 2400,
    	group = 10284,
        pass_group = 10284,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 284,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3284],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390284,
		first_reward = 0
   }
			;
   
get(10285) ->
	#dungeon_data{
	    no = 10285,
    	lv = 1,
    	timing = 2400,
    	group = 10285,
        pass_group = 10285,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 285,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3285],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390285,
		first_reward = 0
   }
			;
   
get(10286) ->
	#dungeon_data{
	    no = 10286,
    	lv = 1,
    	timing = 2400,
    	group = 10286,
        pass_group = 10286,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 286,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3286],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390286,
		first_reward = 0
   }
			;
   
get(10287) ->
	#dungeon_data{
	    no = 10287,
    	lv = 1,
    	timing = 2400,
    	group = 10287,
        pass_group = 10287,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 287,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3287],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390287,
		first_reward = 0
   }
			;
   
get(10288) ->
	#dungeon_data{
	    no = 10288,
    	lv = 1,
    	timing = 2400,
    	group = 10288,
        pass_group = 10288,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 288,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3288],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390288,
		first_reward = 0
   }
			;
   
get(10289) ->
	#dungeon_data{
	    no = 10289,
    	lv = 1,
    	timing = 2400,
    	group = 10289,
        pass_group = 10289,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 289,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3289],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390289,
		first_reward = 0
   }
			;
   
get(10290) ->
	#dungeon_data{
	    no = 10290,
    	lv = 1,
    	timing = 2400,
    	group = 10290,
        pass_group = 10290,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 290,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3290],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390290,
		first_reward = 391029
   }
			;
   
get(10291) ->
	#dungeon_data{
	    no = 10291,
    	lv = 1,
    	timing = 2400,
    	group = 10291,
        pass_group = 10291,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 291,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3291],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390291,
		first_reward = 0
   }
			;
   
get(10292) ->
	#dungeon_data{
	    no = 10292,
    	lv = 1,
    	timing = 2400,
    	group = 10292,
        pass_group = 10292,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 292,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3292],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390292,
		first_reward = 0
   }
			;
   
get(10293) ->
	#dungeon_data{
	    no = 10293,
    	lv = 1,
    	timing = 2400,
    	group = 10293,
        pass_group = 10293,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 293,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3293],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390293,
		first_reward = 0
   }
			;
   
get(10294) ->
	#dungeon_data{
	    no = 10294,
    	lv = 1,
    	timing = 2400,
    	group = 10294,
        pass_group = 10294,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 294,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3294],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390294,
		first_reward = 0
   }
			;
   
get(10295) ->
	#dungeon_data{
	    no = 10295,
    	lv = 1,
    	timing = 2400,
    	group = 10295,
        pass_group = 10295,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 295,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3295],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390295,
		first_reward = 0
   }
			;
   
get(10296) ->
	#dungeon_data{
	    no = 10296,
    	lv = 1,
    	timing = 2400,
    	group = 10296,
        pass_group = 10296,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 296,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3296],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390296,
		first_reward = 0
   }
			;
   
get(10297) ->
	#dungeon_data{
	    no = 10297,
    	lv = 1,
    	timing = 2400,
    	group = 10297,
        pass_group = 10297,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 297,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3297],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390297,
		first_reward = 0
   }
			;
   
get(10298) ->
	#dungeon_data{
	    no = 10298,
    	lv = 1,
    	timing = 2400,
    	group = 10298,
        pass_group = 10298,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 298,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3298],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390298,
		first_reward = 0
   }
			;
   
get(10299) ->
	#dungeon_data{
	    no = 10299,
    	lv = 1,
    	timing = 2400,
    	group = 10299,
        pass_group = 10299,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 299,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3299],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390299,
		first_reward = 0
   }
			;
   
get(10300) ->
	#dungeon_data{
	    no = 10300,
    	lv = 1,
    	timing = 2400,
    	group = 10300,
        pass_group = 10300,
        had_pass_reward =1,
    	type = 14,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 300,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [3300],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 390300,
		first_reward = 391030
   }
			;
   
get(11001) ->
	#dungeon_data{
	    no = 11001,
    	lv = 1,
    	timing = 2400,
    	group = 11001,
        pass_group = 11001,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 1,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4001],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42001,
		first_reward = 391001
   }
			;
   
get(11002) ->
	#dungeon_data{
	    no = 11002,
    	lv = 1,
    	timing = 2400,
    	group = 11002,
        pass_group = 11002,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 2,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4002],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42001,
		first_reward = 391001
   }
			;
   
get(11003) ->
	#dungeon_data{
	    no = 11003,
    	lv = 1,
    	timing = 2400,
    	group = 11003,
        pass_group = 11003,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 3,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4003],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42001,
		first_reward = 391001
   }
			;
   
get(11004) ->
	#dungeon_data{
	    no = 11004,
    	lv = 1,
    	timing = 2400,
    	group = 11004,
        pass_group = 11004,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 4,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4004],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42001,
		first_reward = 391001
   }
			;
   
get(11005) ->
	#dungeon_data{
	    no = 11005,
    	lv = 1,
    	timing = 2400,
    	group = 11005,
        pass_group = 11005,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 5,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4005],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42001,
		first_reward = 391001
   }
			;
   
get(11006) ->
	#dungeon_data{
	    no = 11006,
    	lv = 1,
    	timing = 2400,
    	group = 11006,
        pass_group = 11006,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 6,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4006],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42001,
		first_reward = 391001
   }
			;
   
get(11007) ->
	#dungeon_data{
	    no = 11007,
    	lv = 1,
    	timing = 2400,
    	group = 11007,
        pass_group = 11007,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 7,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4007],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42001,
		first_reward = 391001
   }
			;
   
get(11008) ->
	#dungeon_data{
	    no = 11008,
    	lv = 1,
    	timing = 2400,
    	group = 11008,
        pass_group = 11008,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 8,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4008],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42001,
		first_reward = 391001
   }
			;
   
get(11009) ->
	#dungeon_data{
	    no = 11009,
    	lv = 1,
    	timing = 2400,
    	group = 11009,
        pass_group = 11009,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 9,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4009],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42001,
		first_reward = 391001
   }
			;
   
get(11010) ->
	#dungeon_data{
	    no = 11010,
    	lv = 1,
    	timing = 2400,
    	group = 11010,
        pass_group = 11010,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 10,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4010],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42001,
		first_reward = 391001
   }
			;
   
get(11011) ->
	#dungeon_data{
	    no = 11011,
    	lv = 1,
    	timing = 2400,
    	group = 11011,
        pass_group = 11011,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 11,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4011],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42002,
		first_reward = 391001
   }
			;
   
get(11012) ->
	#dungeon_data{
	    no = 11012,
    	lv = 1,
    	timing = 2400,
    	group = 11012,
        pass_group = 11012,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 12,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4012],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42002,
		first_reward = 391001
   }
			;
   
get(11013) ->
	#dungeon_data{
	    no = 11013,
    	lv = 1,
    	timing = 2400,
    	group = 11013,
        pass_group = 11013,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 13,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4013],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42002,
		first_reward = 391001
   }
			;
   
get(11014) ->
	#dungeon_data{
	    no = 11014,
    	lv = 1,
    	timing = 2400,
    	group = 11014,
        pass_group = 11014,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 14,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4014],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42002,
		first_reward = 391001
   }
			;
   
get(11015) ->
	#dungeon_data{
	    no = 11015,
    	lv = 1,
    	timing = 2400,
    	group = 11015,
        pass_group = 11015,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 15,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4015],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42002,
		first_reward = 391001
   }
			;
   
get(11016) ->
	#dungeon_data{
	    no = 11016,
    	lv = 1,
    	timing = 2400,
    	group = 11016,
        pass_group = 11016,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 16,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4016],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42002,
		first_reward = 391001
   }
			;
   
get(11017) ->
	#dungeon_data{
	    no = 11017,
    	lv = 1,
    	timing = 2400,
    	group = 11017,
        pass_group = 11017,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 17,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4017],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42002,
		first_reward = 391001
   }
			;
   
get(11018) ->
	#dungeon_data{
	    no = 11018,
    	lv = 1,
    	timing = 2400,
    	group = 11018,
        pass_group = 11018,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 18,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4018],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42002,
		first_reward = 391001
   }
			;
   
get(11019) ->
	#dungeon_data{
	    no = 11019,
    	lv = 1,
    	timing = 2400,
    	group = 11019,
        pass_group = 11019,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 19,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4019],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42002,
		first_reward = 391001
   }
			;
   
get(11020) ->
	#dungeon_data{
	    no = 11020,
    	lv = 1,
    	timing = 2400,
    	group = 11020,
        pass_group = 11020,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 20,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4020],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42002,
		first_reward = 391001
   }
			;
   
get(11021) ->
	#dungeon_data{
	    no = 11021,
    	lv = 1,
    	timing = 2400,
    	group = 11021,
        pass_group = 11021,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 21,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4021],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42003,
		first_reward = 391001
   }
			;
   
get(11022) ->
	#dungeon_data{
	    no = 11022,
    	lv = 1,
    	timing = 2400,
    	group = 11022,
        pass_group = 11022,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 22,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4022],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42003,
		first_reward = 391001
   }
			;
   
get(11023) ->
	#dungeon_data{
	    no = 11023,
    	lv = 1,
    	timing = 2400,
    	group = 11023,
        pass_group = 11023,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 23,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4023],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42003,
		first_reward = 391001
   }
			;
   
get(11024) ->
	#dungeon_data{
	    no = 11024,
    	lv = 1,
    	timing = 2400,
    	group = 11024,
        pass_group = 11024,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 24,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4024],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42003,
		first_reward = 391001
   }
			;
   
get(11025) ->
	#dungeon_data{
	    no = 11025,
    	lv = 1,
    	timing = 2400,
    	group = 11025,
        pass_group = 11025,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 25,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4025],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42003,
		first_reward = 391001
   }
			;
   
get(11026) ->
	#dungeon_data{
	    no = 11026,
    	lv = 1,
    	timing = 2400,
    	group = 11026,
        pass_group = 11026,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 26,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4026],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42003,
		first_reward = 391001
   }
			;
   
get(11027) ->
	#dungeon_data{
	    no = 11027,
    	lv = 1,
    	timing = 2400,
    	group = 11027,
        pass_group = 11027,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 27,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4027],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42003,
		first_reward = 391001
   }
			;
   
get(11028) ->
	#dungeon_data{
	    no = 11028,
    	lv = 1,
    	timing = 2400,
    	group = 11028,
        pass_group = 11028,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 28,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4028],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42003,
		first_reward = 391001
   }
			;
   
get(11029) ->
	#dungeon_data{
	    no = 11029,
    	lv = 1,
    	timing = 2400,
    	group = 11029,
        pass_group = 11029,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 29,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4029],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42003,
		first_reward = 391001
   }
			;
   
get(11030) ->
	#dungeon_data{
	    no = 11030,
    	lv = 1,
    	timing = 2400,
    	group = 11030,
        pass_group = 11030,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 30,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4030],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42003,
		first_reward = 391001
   }
			;
   
get(11031) ->
	#dungeon_data{
	    no = 11031,
    	lv = 1,
    	timing = 2400,
    	group = 11031,
        pass_group = 11031,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 31,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4031],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42004,
		first_reward = 391001
   }
			;
   
get(11032) ->
	#dungeon_data{
	    no = 11032,
    	lv = 1,
    	timing = 2400,
    	group = 11032,
        pass_group = 11032,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 32,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4032],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42004,
		first_reward = 391001
   }
			;
   
get(11033) ->
	#dungeon_data{
	    no = 11033,
    	lv = 1,
    	timing = 2400,
    	group = 11033,
        pass_group = 11033,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 33,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4033],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42004,
		first_reward = 391001
   }
			;
   
get(11034) ->
	#dungeon_data{
	    no = 11034,
    	lv = 1,
    	timing = 2400,
    	group = 11034,
        pass_group = 11034,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 34,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4034],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42004,
		first_reward = 391001
   }
			;
   
get(11035) ->
	#dungeon_data{
	    no = 11035,
    	lv = 1,
    	timing = 2400,
    	group = 11035,
        pass_group = 11035,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 35,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4035],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42004,
		first_reward = 391001
   }
			;
   
get(11036) ->
	#dungeon_data{
	    no = 11036,
    	lv = 1,
    	timing = 2400,
    	group = 11036,
        pass_group = 11036,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 36,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4036],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42004,
		first_reward = 391001
   }
			;
   
get(11037) ->
	#dungeon_data{
	    no = 11037,
    	lv = 1,
    	timing = 2400,
    	group = 11037,
        pass_group = 11037,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 37,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4037],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42004,
		first_reward = 391001
   }
			;
   
get(11038) ->
	#dungeon_data{
	    no = 11038,
    	lv = 1,
    	timing = 2400,
    	group = 11038,
        pass_group = 11038,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 38,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4038],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42004,
		first_reward = 391001
   }
			;
   
get(11039) ->
	#dungeon_data{
	    no = 11039,
    	lv = 1,
    	timing = 2400,
    	group = 11039,
        pass_group = 11039,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 39,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4039],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42004,
		first_reward = 391001
   }
			;
   
get(11040) ->
	#dungeon_data{
	    no = 11040,
    	lv = 1,
    	timing = 2400,
    	group = 11040,
        pass_group = 11040,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 40,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4040],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42004,
		first_reward = 391001
   }
			;
   
get(11041) ->
	#dungeon_data{
	    no = 11041,
    	lv = 1,
    	timing = 2400,
    	group = 11041,
        pass_group = 11041,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 41,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4041],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42005,
		first_reward = 391001
   }
			;
   
get(11042) ->
	#dungeon_data{
	    no = 11042,
    	lv = 1,
    	timing = 2400,
    	group = 11042,
        pass_group = 11042,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 42,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4042],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42005,
		first_reward = 391001
   }
			;
   
get(11043) ->
	#dungeon_data{
	    no = 11043,
    	lv = 1,
    	timing = 2400,
    	group = 11043,
        pass_group = 11043,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 43,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4043],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42005,
		first_reward = 391001
   }
			;
   
get(11044) ->
	#dungeon_data{
	    no = 11044,
    	lv = 1,
    	timing = 2400,
    	group = 11044,
        pass_group = 11044,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 44,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4044],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42005,
		first_reward = 391001
   }
			;
   
get(11045) ->
	#dungeon_data{
	    no = 11045,
    	lv = 1,
    	timing = 2400,
    	group = 11045,
        pass_group = 11045,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 45,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4045],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42005,
		first_reward = 391001
   }
			;
   
get(11046) ->
	#dungeon_data{
	    no = 11046,
    	lv = 1,
    	timing = 2400,
    	group = 11046,
        pass_group = 11046,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 46,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4046],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42005,
		first_reward = 391001
   }
			;
   
get(11047) ->
	#dungeon_data{
	    no = 11047,
    	lv = 1,
    	timing = 2400,
    	group = 11047,
        pass_group = 11047,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 47,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4047],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42005,
		first_reward = 391001
   }
			;
   
get(11048) ->
	#dungeon_data{
	    no = 11048,
    	lv = 1,
    	timing = 2400,
    	group = 11048,
        pass_group = 11048,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 48,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4048],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42005,
		first_reward = 391001
   }
			;
   
get(11049) ->
	#dungeon_data{
	    no = 11049,
    	lv = 1,
    	timing = 2400,
    	group = 11049,
        pass_group = 11049,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 49,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4049],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42005,
		first_reward = 391001
   }
			;
   
get(11050) ->
	#dungeon_data{
	    no = 11050,
    	lv = 1,
    	timing = 2400,
    	group = 11050,
        pass_group = 11050,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 50,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4050],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42005,
		first_reward = 391001
   }
			;
   
get(11051) ->
	#dungeon_data{
	    no = 11051,
    	lv = 1,
    	timing = 2400,
    	group = 11051,
        pass_group = 11051,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 51,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4051],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11052) ->
	#dungeon_data{
	    no = 11052,
    	lv = 1,
    	timing = 2400,
    	group = 11052,
        pass_group = 11052,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 52,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4052],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11053) ->
	#dungeon_data{
	    no = 11053,
    	lv = 1,
    	timing = 2400,
    	group = 11053,
        pass_group = 11053,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 53,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4053],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11054) ->
	#dungeon_data{
	    no = 11054,
    	lv = 1,
    	timing = 2400,
    	group = 11054,
        pass_group = 11054,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 54,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4054],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11055) ->
	#dungeon_data{
	    no = 11055,
    	lv = 1,
    	timing = 2400,
    	group = 11055,
        pass_group = 11055,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 55,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4055],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11056) ->
	#dungeon_data{
	    no = 11056,
    	lv = 1,
    	timing = 2400,
    	group = 11056,
        pass_group = 11056,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 56,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4056],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11057) ->
	#dungeon_data{
	    no = 11057,
    	lv = 1,
    	timing = 2400,
    	group = 11057,
        pass_group = 11057,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 57,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4057],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11058) ->
	#dungeon_data{
	    no = 11058,
    	lv = 1,
    	timing = 2400,
    	group = 11058,
        pass_group = 11058,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 58,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4058],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11059) ->
	#dungeon_data{
	    no = 11059,
    	lv = 1,
    	timing = 2400,
    	group = 11059,
        pass_group = 11059,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 59,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4059],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11060) ->
	#dungeon_data{
	    no = 11060,
    	lv = 1,
    	timing = 2400,
    	group = 11060,
        pass_group = 11060,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 60,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4060],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11061) ->
	#dungeon_data{
	    no = 11061,
    	lv = 1,
    	timing = 2400,
    	group = 11061,
        pass_group = 11061,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 61,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4061],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11062) ->
	#dungeon_data{
	    no = 11062,
    	lv = 1,
    	timing = 2400,
    	group = 11062,
        pass_group = 11062,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 62,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4062],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11063) ->
	#dungeon_data{
	    no = 11063,
    	lv = 1,
    	timing = 2400,
    	group = 11063,
        pass_group = 11063,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 63,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4063],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11064) ->
	#dungeon_data{
	    no = 11064,
    	lv = 1,
    	timing = 2400,
    	group = 11064,
        pass_group = 11064,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 64,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4064],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11065) ->
	#dungeon_data{
	    no = 11065,
    	lv = 1,
    	timing = 2400,
    	group = 11065,
        pass_group = 11065,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 65,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4065],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11066) ->
	#dungeon_data{
	    no = 11066,
    	lv = 1,
    	timing = 2400,
    	group = 11066,
        pass_group = 11066,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 66,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4066],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11067) ->
	#dungeon_data{
	    no = 11067,
    	lv = 1,
    	timing = 2400,
    	group = 11067,
        pass_group = 11067,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 67,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4067],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11068) ->
	#dungeon_data{
	    no = 11068,
    	lv = 1,
    	timing = 2400,
    	group = 11068,
        pass_group = 11068,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 68,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4068],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11069) ->
	#dungeon_data{
	    no = 11069,
    	lv = 1,
    	timing = 2400,
    	group = 11069,
        pass_group = 11069,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 69,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4069],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11070) ->
	#dungeon_data{
	    no = 11070,
    	lv = 1,
    	timing = 2400,
    	group = 11070,
        pass_group = 11070,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 70,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4070],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11071) ->
	#dungeon_data{
	    no = 11071,
    	lv = 1,
    	timing = 2400,
    	group = 11071,
        pass_group = 11071,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 71,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4071],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11072) ->
	#dungeon_data{
	    no = 11072,
    	lv = 1,
    	timing = 2400,
    	group = 11072,
        pass_group = 11072,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 72,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4072],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11073) ->
	#dungeon_data{
	    no = 11073,
    	lv = 1,
    	timing = 2400,
    	group = 11073,
        pass_group = 11073,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 73,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4073],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11074) ->
	#dungeon_data{
	    no = 11074,
    	lv = 1,
    	timing = 2400,
    	group = 11074,
        pass_group = 11074,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 74,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4074],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11075) ->
	#dungeon_data{
	    no = 11075,
    	lv = 1,
    	timing = 2400,
    	group = 11075,
        pass_group = 11075,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 75,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4075],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11076) ->
	#dungeon_data{
	    no = 11076,
    	lv = 1,
    	timing = 2400,
    	group = 11076,
        pass_group = 11076,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 76,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4076],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11077) ->
	#dungeon_data{
	    no = 11077,
    	lv = 1,
    	timing = 2400,
    	group = 11077,
        pass_group = 11077,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 77,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4077],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11078) ->
	#dungeon_data{
	    no = 11078,
    	lv = 1,
    	timing = 2400,
    	group = 11078,
        pass_group = 11078,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 78,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4078],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11079) ->
	#dungeon_data{
	    no = 11079,
    	lv = 1,
    	timing = 2400,
    	group = 11079,
        pass_group = 11079,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 79,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4079],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11080) ->
	#dungeon_data{
	    no = 11080,
    	lv = 1,
    	timing = 2400,
    	group = 11080,
        pass_group = 11080,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 80,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4080],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11081) ->
	#dungeon_data{
	    no = 11081,
    	lv = 1,
    	timing = 2400,
    	group = 11081,
        pass_group = 11081,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 81,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4081],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11082) ->
	#dungeon_data{
	    no = 11082,
    	lv = 1,
    	timing = 2400,
    	group = 11082,
        pass_group = 11082,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 82,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4082],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11083) ->
	#dungeon_data{
	    no = 11083,
    	lv = 1,
    	timing = 2400,
    	group = 11083,
        pass_group = 11083,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 83,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4083],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11084) ->
	#dungeon_data{
	    no = 11084,
    	lv = 1,
    	timing = 2400,
    	group = 11084,
        pass_group = 11084,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 84,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4084],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11085) ->
	#dungeon_data{
	    no = 11085,
    	lv = 1,
    	timing = 2400,
    	group = 11085,
        pass_group = 11085,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 85,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4085],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11086) ->
	#dungeon_data{
	    no = 11086,
    	lv = 1,
    	timing = 2400,
    	group = 11086,
        pass_group = 11086,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 86,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4086],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11087) ->
	#dungeon_data{
	    no = 11087,
    	lv = 1,
    	timing = 2400,
    	group = 11087,
        pass_group = 11087,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 87,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4087],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11088) ->
	#dungeon_data{
	    no = 11088,
    	lv = 1,
    	timing = 2400,
    	group = 11088,
        pass_group = 11088,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 88,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4088],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11089) ->
	#dungeon_data{
	    no = 11089,
    	lv = 1,
    	timing = 2400,
    	group = 11089,
        pass_group = 11089,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 89,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4089],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11090) ->
	#dungeon_data{
	    no = 11090,
    	lv = 1,
    	timing = 2400,
    	group = 11090,
        pass_group = 11090,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 90,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4090],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11091) ->
	#dungeon_data{
	    no = 11091,
    	lv = 1,
    	timing = 2400,
    	group = 11091,
        pass_group = 11091,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 91,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4091],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11092) ->
	#dungeon_data{
	    no = 11092,
    	lv = 1,
    	timing = 2400,
    	group = 11092,
        pass_group = 11092,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 92,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4092],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11093) ->
	#dungeon_data{
	    no = 11093,
    	lv = 1,
    	timing = 2400,
    	group = 11093,
        pass_group = 11093,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 93,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4093],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11094) ->
	#dungeon_data{
	    no = 11094,
    	lv = 1,
    	timing = 2400,
    	group = 11094,
        pass_group = 11094,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 94,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4094],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11095) ->
	#dungeon_data{
	    no = 11095,
    	lv = 1,
    	timing = 2400,
    	group = 11095,
        pass_group = 11095,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 95,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4095],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11096) ->
	#dungeon_data{
	    no = 11096,
    	lv = 1,
    	timing = 2400,
    	group = 11096,
        pass_group = 11096,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 96,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4096],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11097) ->
	#dungeon_data{
	    no = 11097,
    	lv = 1,
    	timing = 2400,
    	group = 11097,
        pass_group = 11097,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 97,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4097],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11098) ->
	#dungeon_data{
	    no = 11098,
    	lv = 1,
    	timing = 2400,
    	group = 11098,
        pass_group = 11098,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 98,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4098],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11099) ->
	#dungeon_data{
	    no = 11099,
    	lv = 1,
    	timing = 2400,
    	group = 11099,
        pass_group = 11099,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 99,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4099],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11100) ->
	#dungeon_data{
	    no = 11100,
    	lv = 1,
    	timing = 2400,
    	group = 11100,
        pass_group = 11100,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 100,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4100],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11101) ->
	#dungeon_data{
	    no = 11101,
    	lv = 1,
    	timing = 2400,
    	group = 11101,
        pass_group = 11101,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 101,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4101],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11102) ->
	#dungeon_data{
	    no = 11102,
    	lv = 1,
    	timing = 2400,
    	group = 11102,
        pass_group = 11102,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 102,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4102],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11103) ->
	#dungeon_data{
	    no = 11103,
    	lv = 1,
    	timing = 2400,
    	group = 11103,
        pass_group = 11103,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 103,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4103],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11104) ->
	#dungeon_data{
	    no = 11104,
    	lv = 1,
    	timing = 2400,
    	group = 11104,
        pass_group = 11104,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 104,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4104],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11105) ->
	#dungeon_data{
	    no = 11105,
    	lv = 1,
    	timing = 2400,
    	group = 11105,
        pass_group = 11105,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 105,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4105],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11106) ->
	#dungeon_data{
	    no = 11106,
    	lv = 1,
    	timing = 2400,
    	group = 11106,
        pass_group = 11106,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 106,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4106],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11107) ->
	#dungeon_data{
	    no = 11107,
    	lv = 1,
    	timing = 2400,
    	group = 11107,
        pass_group = 11107,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 107,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4107],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11108) ->
	#dungeon_data{
	    no = 11108,
    	lv = 1,
    	timing = 2400,
    	group = 11108,
        pass_group = 11108,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 108,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4108],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11109) ->
	#dungeon_data{
	    no = 11109,
    	lv = 1,
    	timing = 2400,
    	group = 11109,
        pass_group = 11109,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 109,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4109],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11110) ->
	#dungeon_data{
	    no = 11110,
    	lv = 1,
    	timing = 2400,
    	group = 11110,
        pass_group = 11110,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 110,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4110],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11111) ->
	#dungeon_data{
	    no = 11111,
    	lv = 1,
    	timing = 2400,
    	group = 11111,
        pass_group = 11111,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 111,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4111],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11112) ->
	#dungeon_data{
	    no = 11112,
    	lv = 1,
    	timing = 2400,
    	group = 11112,
        pass_group = 11112,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 112,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4112],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11113) ->
	#dungeon_data{
	    no = 11113,
    	lv = 1,
    	timing = 2400,
    	group = 11113,
        pass_group = 11113,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 113,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4113],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11114) ->
	#dungeon_data{
	    no = 11114,
    	lv = 1,
    	timing = 2400,
    	group = 11114,
        pass_group = 11114,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 114,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4114],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11115) ->
	#dungeon_data{
	    no = 11115,
    	lv = 1,
    	timing = 2400,
    	group = 11115,
        pass_group = 11115,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 115,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4115],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11116) ->
	#dungeon_data{
	    no = 11116,
    	lv = 1,
    	timing = 2400,
    	group = 11116,
        pass_group = 11116,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 116,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4116],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11117) ->
	#dungeon_data{
	    no = 11117,
    	lv = 1,
    	timing = 2400,
    	group = 11117,
        pass_group = 11117,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 117,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4117],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11118) ->
	#dungeon_data{
	    no = 11118,
    	lv = 1,
    	timing = 2400,
    	group = 11118,
        pass_group = 11118,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 118,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4118],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11119) ->
	#dungeon_data{
	    no = 11119,
    	lv = 1,
    	timing = 2400,
    	group = 11119,
        pass_group = 11119,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 119,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4119],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11120) ->
	#dungeon_data{
	    no = 11120,
    	lv = 1,
    	timing = 2400,
    	group = 11120,
        pass_group = 11120,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 120,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4120],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11121) ->
	#dungeon_data{
	    no = 11121,
    	lv = 1,
    	timing = 2400,
    	group = 11121,
        pass_group = 11121,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 121,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4121],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11122) ->
	#dungeon_data{
	    no = 11122,
    	lv = 1,
    	timing = 2400,
    	group = 11122,
        pass_group = 11122,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 122,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4122],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11123) ->
	#dungeon_data{
	    no = 11123,
    	lv = 1,
    	timing = 2400,
    	group = 11123,
        pass_group = 11123,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 123,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4123],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11124) ->
	#dungeon_data{
	    no = 11124,
    	lv = 1,
    	timing = 2400,
    	group = 11124,
        pass_group = 11124,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 124,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4124],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11125) ->
	#dungeon_data{
	    no = 11125,
    	lv = 1,
    	timing = 2400,
    	group = 11125,
        pass_group = 11125,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 125,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4125],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11126) ->
	#dungeon_data{
	    no = 11126,
    	lv = 1,
    	timing = 2400,
    	group = 11126,
        pass_group = 11126,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 126,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4126],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11127) ->
	#dungeon_data{
	    no = 11127,
    	lv = 1,
    	timing = 2400,
    	group = 11127,
        pass_group = 11127,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 127,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4127],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11128) ->
	#dungeon_data{
	    no = 11128,
    	lv = 1,
    	timing = 2400,
    	group = 11128,
        pass_group = 11128,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 128,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4128],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11129) ->
	#dungeon_data{
	    no = 11129,
    	lv = 1,
    	timing = 2400,
    	group = 11129,
        pass_group = 11129,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 129,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4129],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11130) ->
	#dungeon_data{
	    no = 11130,
    	lv = 1,
    	timing = 2400,
    	group = 11130,
        pass_group = 11130,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 130,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4130],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11131) ->
	#dungeon_data{
	    no = 11131,
    	lv = 1,
    	timing = 2400,
    	group = 11131,
        pass_group = 11131,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 131,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4131],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11132) ->
	#dungeon_data{
	    no = 11132,
    	lv = 1,
    	timing = 2400,
    	group = 11132,
        pass_group = 11132,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 132,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4132],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11133) ->
	#dungeon_data{
	    no = 11133,
    	lv = 1,
    	timing = 2400,
    	group = 11133,
        pass_group = 11133,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 133,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4133],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11134) ->
	#dungeon_data{
	    no = 11134,
    	lv = 1,
    	timing = 2400,
    	group = 11134,
        pass_group = 11134,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 134,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4134],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11135) ->
	#dungeon_data{
	    no = 11135,
    	lv = 1,
    	timing = 2400,
    	group = 11135,
        pass_group = 11135,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 135,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4135],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11136) ->
	#dungeon_data{
	    no = 11136,
    	lv = 1,
    	timing = 2400,
    	group = 11136,
        pass_group = 11136,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 136,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4136],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11137) ->
	#dungeon_data{
	    no = 11137,
    	lv = 1,
    	timing = 2400,
    	group = 11137,
        pass_group = 11137,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 137,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4137],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11138) ->
	#dungeon_data{
	    no = 11138,
    	lv = 1,
    	timing = 2400,
    	group = 11138,
        pass_group = 11138,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 138,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4138],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11139) ->
	#dungeon_data{
	    no = 11139,
    	lv = 1,
    	timing = 2400,
    	group = 11139,
        pass_group = 11139,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 139,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4139],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11140) ->
	#dungeon_data{
	    no = 11140,
    	lv = 1,
    	timing = 2400,
    	group = 11140,
        pass_group = 11140,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 140,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4140],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11141) ->
	#dungeon_data{
	    no = 11141,
    	lv = 1,
    	timing = 2400,
    	group = 11141,
        pass_group = 11141,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 141,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4141],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11142) ->
	#dungeon_data{
	    no = 11142,
    	lv = 1,
    	timing = 2400,
    	group = 11142,
        pass_group = 11142,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 142,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4142],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11143) ->
	#dungeon_data{
	    no = 11143,
    	lv = 1,
    	timing = 2400,
    	group = 11143,
        pass_group = 11143,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 143,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4143],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11144) ->
	#dungeon_data{
	    no = 11144,
    	lv = 1,
    	timing = 2400,
    	group = 11144,
        pass_group = 11144,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 144,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4144],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11145) ->
	#dungeon_data{
	    no = 11145,
    	lv = 1,
    	timing = 2400,
    	group = 11145,
        pass_group = 11145,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 145,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4145],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11146) ->
	#dungeon_data{
	    no = 11146,
    	lv = 1,
    	timing = 2400,
    	group = 11146,
        pass_group = 11146,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 146,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4146],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11147) ->
	#dungeon_data{
	    no = 11147,
    	lv = 1,
    	timing = 2400,
    	group = 11147,
        pass_group = 11147,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 147,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4147],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11148) ->
	#dungeon_data{
	    no = 11148,
    	lv = 1,
    	timing = 2400,
    	group = 11148,
        pass_group = 11148,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 148,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4148],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11149) ->
	#dungeon_data{
	    no = 11149,
    	lv = 1,
    	timing = 2400,
    	group = 11149,
        pass_group = 11149,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 149,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4149],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11150) ->
	#dungeon_data{
	    no = 11150,
    	lv = 1,
    	timing = 2400,
    	group = 11150,
        pass_group = 11150,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 150,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4150],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11151) ->
	#dungeon_data{
	    no = 11151,
    	lv = 1,
    	timing = 2400,
    	group = 11151,
        pass_group = 11151,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 151,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4151],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11152) ->
	#dungeon_data{
	    no = 11152,
    	lv = 1,
    	timing = 2400,
    	group = 11152,
        pass_group = 11152,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 152,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4152],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11153) ->
	#dungeon_data{
	    no = 11153,
    	lv = 1,
    	timing = 2400,
    	group = 11153,
        pass_group = 11153,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 153,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4153],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11154) ->
	#dungeon_data{
	    no = 11154,
    	lv = 1,
    	timing = 2400,
    	group = 11154,
        pass_group = 11154,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 154,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4154],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11155) ->
	#dungeon_data{
	    no = 11155,
    	lv = 1,
    	timing = 2400,
    	group = 11155,
        pass_group = 11155,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 155,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4155],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11156) ->
	#dungeon_data{
	    no = 11156,
    	lv = 1,
    	timing = 2400,
    	group = 11156,
        pass_group = 11156,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 156,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4156],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11157) ->
	#dungeon_data{
	    no = 11157,
    	lv = 1,
    	timing = 2400,
    	group = 11157,
        pass_group = 11157,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 157,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4157],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11158) ->
	#dungeon_data{
	    no = 11158,
    	lv = 1,
    	timing = 2400,
    	group = 11158,
        pass_group = 11158,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 158,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4158],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11159) ->
	#dungeon_data{
	    no = 11159,
    	lv = 1,
    	timing = 2400,
    	group = 11159,
        pass_group = 11159,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 159,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4159],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11160) ->
	#dungeon_data{
	    no = 11160,
    	lv = 1,
    	timing = 2400,
    	group = 11160,
        pass_group = 11160,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 160,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4160],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11161) ->
	#dungeon_data{
	    no = 11161,
    	lv = 1,
    	timing = 2400,
    	group = 11161,
        pass_group = 11161,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 161,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4161],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11162) ->
	#dungeon_data{
	    no = 11162,
    	lv = 1,
    	timing = 2400,
    	group = 11162,
        pass_group = 11162,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 162,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4162],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11163) ->
	#dungeon_data{
	    no = 11163,
    	lv = 1,
    	timing = 2400,
    	group = 11163,
        pass_group = 11163,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 163,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4163],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11164) ->
	#dungeon_data{
	    no = 11164,
    	lv = 1,
    	timing = 2400,
    	group = 11164,
        pass_group = 11164,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 164,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4164],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11165) ->
	#dungeon_data{
	    no = 11165,
    	lv = 1,
    	timing = 2400,
    	group = 11165,
        pass_group = 11165,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 165,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4165],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11166) ->
	#dungeon_data{
	    no = 11166,
    	lv = 1,
    	timing = 2400,
    	group = 11166,
        pass_group = 11166,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 166,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4166],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11167) ->
	#dungeon_data{
	    no = 11167,
    	lv = 1,
    	timing = 2400,
    	group = 11167,
        pass_group = 11167,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 167,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4167],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11168) ->
	#dungeon_data{
	    no = 11168,
    	lv = 1,
    	timing = 2400,
    	group = 11168,
        pass_group = 11168,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 168,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4168],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11169) ->
	#dungeon_data{
	    no = 11169,
    	lv = 1,
    	timing = 2400,
    	group = 11169,
        pass_group = 11169,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 169,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4169],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11170) ->
	#dungeon_data{
	    no = 11170,
    	lv = 1,
    	timing = 2400,
    	group = 11170,
        pass_group = 11170,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 170,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4170],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11171) ->
	#dungeon_data{
	    no = 11171,
    	lv = 1,
    	timing = 2400,
    	group = 11171,
        pass_group = 11171,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 171,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4171],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11172) ->
	#dungeon_data{
	    no = 11172,
    	lv = 1,
    	timing = 2400,
    	group = 11172,
        pass_group = 11172,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 172,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4172],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11173) ->
	#dungeon_data{
	    no = 11173,
    	lv = 1,
    	timing = 2400,
    	group = 11173,
        pass_group = 11173,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 173,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4173],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11174) ->
	#dungeon_data{
	    no = 11174,
    	lv = 1,
    	timing = 2400,
    	group = 11174,
        pass_group = 11174,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 174,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4174],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11175) ->
	#dungeon_data{
	    no = 11175,
    	lv = 1,
    	timing = 2400,
    	group = 11175,
        pass_group = 11175,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 175,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4175],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11176) ->
	#dungeon_data{
	    no = 11176,
    	lv = 1,
    	timing = 2400,
    	group = 11176,
        pass_group = 11176,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 176,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4176],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11177) ->
	#dungeon_data{
	    no = 11177,
    	lv = 1,
    	timing = 2400,
    	group = 11177,
        pass_group = 11177,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 177,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4177],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11178) ->
	#dungeon_data{
	    no = 11178,
    	lv = 1,
    	timing = 2400,
    	group = 11178,
        pass_group = 11178,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 178,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4178],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11179) ->
	#dungeon_data{
	    no = 11179,
    	lv = 1,
    	timing = 2400,
    	group = 11179,
        pass_group = 11179,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 179,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4179],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11180) ->
	#dungeon_data{
	    no = 11180,
    	lv = 1,
    	timing = 2400,
    	group = 11180,
        pass_group = 11180,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 180,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4180],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11181) ->
	#dungeon_data{
	    no = 11181,
    	lv = 1,
    	timing = 2400,
    	group = 11181,
        pass_group = 11181,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 181,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4181],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11182) ->
	#dungeon_data{
	    no = 11182,
    	lv = 1,
    	timing = 2400,
    	group = 11182,
        pass_group = 11182,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 182,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4182],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11183) ->
	#dungeon_data{
	    no = 11183,
    	lv = 1,
    	timing = 2400,
    	group = 11183,
        pass_group = 11183,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 183,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4183],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11184) ->
	#dungeon_data{
	    no = 11184,
    	lv = 1,
    	timing = 2400,
    	group = 11184,
        pass_group = 11184,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 184,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4184],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11185) ->
	#dungeon_data{
	    no = 11185,
    	lv = 1,
    	timing = 2400,
    	group = 11185,
        pass_group = 11185,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 185,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4185],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11186) ->
	#dungeon_data{
	    no = 11186,
    	lv = 1,
    	timing = 2400,
    	group = 11186,
        pass_group = 11186,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 186,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4186],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11187) ->
	#dungeon_data{
	    no = 11187,
    	lv = 1,
    	timing = 2400,
    	group = 11187,
        pass_group = 11187,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 187,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4187],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11188) ->
	#dungeon_data{
	    no = 11188,
    	lv = 1,
    	timing = 2400,
    	group = 11188,
        pass_group = 11188,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 188,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4188],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11189) ->
	#dungeon_data{
	    no = 11189,
    	lv = 1,
    	timing = 2400,
    	group = 11189,
        pass_group = 11189,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 189,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4189],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11190) ->
	#dungeon_data{
	    no = 11190,
    	lv = 1,
    	timing = 2400,
    	group = 11190,
        pass_group = 11190,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 190,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4190],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11191) ->
	#dungeon_data{
	    no = 11191,
    	lv = 1,
    	timing = 2400,
    	group = 11191,
        pass_group = 11191,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 191,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4191],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11192) ->
	#dungeon_data{
	    no = 11192,
    	lv = 1,
    	timing = 2400,
    	group = 11192,
        pass_group = 11192,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 192,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4192],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11193) ->
	#dungeon_data{
	    no = 11193,
    	lv = 1,
    	timing = 2400,
    	group = 11193,
        pass_group = 11193,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 193,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4193],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11194) ->
	#dungeon_data{
	    no = 11194,
    	lv = 1,
    	timing = 2400,
    	group = 11194,
        pass_group = 11194,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 194,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4194],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11195) ->
	#dungeon_data{
	    no = 11195,
    	lv = 1,
    	timing = 2400,
    	group = 11195,
        pass_group = 11195,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 195,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4195],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11196) ->
	#dungeon_data{
	    no = 11196,
    	lv = 1,
    	timing = 2400,
    	group = 11196,
        pass_group = 11196,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 196,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4196],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11197) ->
	#dungeon_data{
	    no = 11197,
    	lv = 1,
    	timing = 2400,
    	group = 11197,
        pass_group = 11197,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 197,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4197],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11198) ->
	#dungeon_data{
	    no = 11198,
    	lv = 1,
    	timing = 2400,
    	group = 11198,
        pass_group = 11198,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 198,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4198],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11199) ->
	#dungeon_data{
	    no = 11199,
    	lv = 1,
    	timing = 2400,
    	group = 11199,
        pass_group = 11199,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 199,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4199],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11200) ->
	#dungeon_data{
	    no = 11200,
    	lv = 1,
    	timing = 2400,
    	group = 11200,
        pass_group = 11200,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 200,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4200],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11201) ->
	#dungeon_data{
	    no = 11201,
    	lv = 1,
    	timing = 2400,
    	group = 11201,
        pass_group = 11201,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 201,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4201],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11202) ->
	#dungeon_data{
	    no = 11202,
    	lv = 1,
    	timing = 2400,
    	group = 11202,
        pass_group = 11202,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 202,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4202],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11203) ->
	#dungeon_data{
	    no = 11203,
    	lv = 1,
    	timing = 2400,
    	group = 11203,
        pass_group = 11203,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 203,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4203],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11204) ->
	#dungeon_data{
	    no = 11204,
    	lv = 1,
    	timing = 2400,
    	group = 11204,
        pass_group = 11204,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 204,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4204],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11205) ->
	#dungeon_data{
	    no = 11205,
    	lv = 1,
    	timing = 2400,
    	group = 11205,
        pass_group = 11205,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 205,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4205],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11206) ->
	#dungeon_data{
	    no = 11206,
    	lv = 1,
    	timing = 2400,
    	group = 11206,
        pass_group = 11206,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 206,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4206],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11207) ->
	#dungeon_data{
	    no = 11207,
    	lv = 1,
    	timing = 2400,
    	group = 11207,
        pass_group = 11207,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 207,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4207],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11208) ->
	#dungeon_data{
	    no = 11208,
    	lv = 1,
    	timing = 2400,
    	group = 11208,
        pass_group = 11208,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 208,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4208],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11209) ->
	#dungeon_data{
	    no = 11209,
    	lv = 1,
    	timing = 2400,
    	group = 11209,
        pass_group = 11209,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 209,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4209],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11210) ->
	#dungeon_data{
	    no = 11210,
    	lv = 1,
    	timing = 2400,
    	group = 11210,
        pass_group = 11210,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 210,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4210],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11211) ->
	#dungeon_data{
	    no = 11211,
    	lv = 1,
    	timing = 2400,
    	group = 11211,
        pass_group = 11211,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 211,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4211],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11212) ->
	#dungeon_data{
	    no = 11212,
    	lv = 1,
    	timing = 2400,
    	group = 11212,
        pass_group = 11212,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 212,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4212],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11213) ->
	#dungeon_data{
	    no = 11213,
    	lv = 1,
    	timing = 2400,
    	group = 11213,
        pass_group = 11213,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 213,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4213],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11214) ->
	#dungeon_data{
	    no = 11214,
    	lv = 1,
    	timing = 2400,
    	group = 11214,
        pass_group = 11214,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 214,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4214],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11215) ->
	#dungeon_data{
	    no = 11215,
    	lv = 1,
    	timing = 2400,
    	group = 11215,
        pass_group = 11215,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 215,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4215],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11216) ->
	#dungeon_data{
	    no = 11216,
    	lv = 1,
    	timing = 2400,
    	group = 11216,
        pass_group = 11216,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 216,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4216],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11217) ->
	#dungeon_data{
	    no = 11217,
    	lv = 1,
    	timing = 2400,
    	group = 11217,
        pass_group = 11217,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 217,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4217],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11218) ->
	#dungeon_data{
	    no = 11218,
    	lv = 1,
    	timing = 2400,
    	group = 11218,
        pass_group = 11218,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 218,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4218],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11219) ->
	#dungeon_data{
	    no = 11219,
    	lv = 1,
    	timing = 2400,
    	group = 11219,
        pass_group = 11219,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 219,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4219],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11220) ->
	#dungeon_data{
	    no = 11220,
    	lv = 1,
    	timing = 2400,
    	group = 11220,
        pass_group = 11220,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 220,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4220],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11221) ->
	#dungeon_data{
	    no = 11221,
    	lv = 1,
    	timing = 2400,
    	group = 11221,
        pass_group = 11221,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 221,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4221],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11222) ->
	#dungeon_data{
	    no = 11222,
    	lv = 1,
    	timing = 2400,
    	group = 11222,
        pass_group = 11222,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 222,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4222],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11223) ->
	#dungeon_data{
	    no = 11223,
    	lv = 1,
    	timing = 2400,
    	group = 11223,
        pass_group = 11223,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 223,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4223],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11224) ->
	#dungeon_data{
	    no = 11224,
    	lv = 1,
    	timing = 2400,
    	group = 11224,
        pass_group = 11224,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 224,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4224],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11225) ->
	#dungeon_data{
	    no = 11225,
    	lv = 1,
    	timing = 2400,
    	group = 11225,
        pass_group = 11225,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 225,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4225],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11226) ->
	#dungeon_data{
	    no = 11226,
    	lv = 1,
    	timing = 2400,
    	group = 11226,
        pass_group = 11226,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 226,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4226],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11227) ->
	#dungeon_data{
	    no = 11227,
    	lv = 1,
    	timing = 2400,
    	group = 11227,
        pass_group = 11227,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 227,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4227],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11228) ->
	#dungeon_data{
	    no = 11228,
    	lv = 1,
    	timing = 2400,
    	group = 11228,
        pass_group = 11228,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 228,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4228],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11229) ->
	#dungeon_data{
	    no = 11229,
    	lv = 1,
    	timing = 2400,
    	group = 11229,
        pass_group = 11229,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 229,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4229],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11230) ->
	#dungeon_data{
	    no = 11230,
    	lv = 1,
    	timing = 2400,
    	group = 11230,
        pass_group = 11230,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 230,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4230],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11231) ->
	#dungeon_data{
	    no = 11231,
    	lv = 1,
    	timing = 2400,
    	group = 11231,
        pass_group = 11231,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 231,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4231],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11232) ->
	#dungeon_data{
	    no = 11232,
    	lv = 1,
    	timing = 2400,
    	group = 11232,
        pass_group = 11232,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 232,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4232],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11233) ->
	#dungeon_data{
	    no = 11233,
    	lv = 1,
    	timing = 2400,
    	group = 11233,
        pass_group = 11233,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 233,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4233],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11234) ->
	#dungeon_data{
	    no = 11234,
    	lv = 1,
    	timing = 2400,
    	group = 11234,
        pass_group = 11234,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 234,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4234],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11235) ->
	#dungeon_data{
	    no = 11235,
    	lv = 1,
    	timing = 2400,
    	group = 11235,
        pass_group = 11235,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 235,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4235],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11236) ->
	#dungeon_data{
	    no = 11236,
    	lv = 1,
    	timing = 2400,
    	group = 11236,
        pass_group = 11236,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 236,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4236],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11237) ->
	#dungeon_data{
	    no = 11237,
    	lv = 1,
    	timing = 2400,
    	group = 11237,
        pass_group = 11237,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 237,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4237],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11238) ->
	#dungeon_data{
	    no = 11238,
    	lv = 1,
    	timing = 2400,
    	group = 11238,
        pass_group = 11238,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 238,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4238],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11239) ->
	#dungeon_data{
	    no = 11239,
    	lv = 1,
    	timing = 2400,
    	group = 11239,
        pass_group = 11239,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 239,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4239],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11240) ->
	#dungeon_data{
	    no = 11240,
    	lv = 1,
    	timing = 2400,
    	group = 11240,
        pass_group = 11240,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 240,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4240],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11241) ->
	#dungeon_data{
	    no = 11241,
    	lv = 1,
    	timing = 2400,
    	group = 11241,
        pass_group = 11241,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 241,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4241],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11242) ->
	#dungeon_data{
	    no = 11242,
    	lv = 1,
    	timing = 2400,
    	group = 11242,
        pass_group = 11242,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 242,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4242],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11243) ->
	#dungeon_data{
	    no = 11243,
    	lv = 1,
    	timing = 2400,
    	group = 11243,
        pass_group = 11243,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 243,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4243],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11244) ->
	#dungeon_data{
	    no = 11244,
    	lv = 1,
    	timing = 2400,
    	group = 11244,
        pass_group = 11244,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 244,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4244],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11245) ->
	#dungeon_data{
	    no = 11245,
    	lv = 1,
    	timing = 2400,
    	group = 11245,
        pass_group = 11245,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 245,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4245],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11246) ->
	#dungeon_data{
	    no = 11246,
    	lv = 1,
    	timing = 2400,
    	group = 11246,
        pass_group = 11246,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 246,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4246],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11247) ->
	#dungeon_data{
	    no = 11247,
    	lv = 1,
    	timing = 2400,
    	group = 11247,
        pass_group = 11247,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 247,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4247],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11248) ->
	#dungeon_data{
	    no = 11248,
    	lv = 1,
    	timing = 2400,
    	group = 11248,
        pass_group = 11248,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 248,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4248],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11249) ->
	#dungeon_data{
	    no = 11249,
    	lv = 1,
    	timing = 2400,
    	group = 11249,
        pass_group = 11249,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 249,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4249],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11250) ->
	#dungeon_data{
	    no = 11250,
    	lv = 1,
    	timing = 2400,
    	group = 11250,
        pass_group = 11250,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 250,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4250],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11251) ->
	#dungeon_data{
	    no = 11251,
    	lv = 1,
    	timing = 2400,
    	group = 11251,
        pass_group = 11251,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 251,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4251],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11252) ->
	#dungeon_data{
	    no = 11252,
    	lv = 1,
    	timing = 2400,
    	group = 11252,
        pass_group = 11252,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 252,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4252],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11253) ->
	#dungeon_data{
	    no = 11253,
    	lv = 1,
    	timing = 2400,
    	group = 11253,
        pass_group = 11253,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 253,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4253],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11254) ->
	#dungeon_data{
	    no = 11254,
    	lv = 1,
    	timing = 2400,
    	group = 11254,
        pass_group = 11254,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 254,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4254],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11255) ->
	#dungeon_data{
	    no = 11255,
    	lv = 1,
    	timing = 2400,
    	group = 11255,
        pass_group = 11255,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 255,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4255],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11256) ->
	#dungeon_data{
	    no = 11256,
    	lv = 1,
    	timing = 2400,
    	group = 11256,
        pass_group = 11256,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 256,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4256],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11257) ->
	#dungeon_data{
	    no = 11257,
    	lv = 1,
    	timing = 2400,
    	group = 11257,
        pass_group = 11257,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 257,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4257],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11258) ->
	#dungeon_data{
	    no = 11258,
    	lv = 1,
    	timing = 2400,
    	group = 11258,
        pass_group = 11258,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 258,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4258],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11259) ->
	#dungeon_data{
	    no = 11259,
    	lv = 1,
    	timing = 2400,
    	group = 11259,
        pass_group = 11259,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 259,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4259],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11260) ->
	#dungeon_data{
	    no = 11260,
    	lv = 1,
    	timing = 2400,
    	group = 11260,
        pass_group = 11260,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 260,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4260],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11261) ->
	#dungeon_data{
	    no = 11261,
    	lv = 1,
    	timing = 2400,
    	group = 11261,
        pass_group = 11261,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 261,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4261],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11262) ->
	#dungeon_data{
	    no = 11262,
    	lv = 1,
    	timing = 2400,
    	group = 11262,
        pass_group = 11262,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 262,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4262],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11263) ->
	#dungeon_data{
	    no = 11263,
    	lv = 1,
    	timing = 2400,
    	group = 11263,
        pass_group = 11263,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 263,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4263],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11264) ->
	#dungeon_data{
	    no = 11264,
    	lv = 1,
    	timing = 2400,
    	group = 11264,
        pass_group = 11264,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 264,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4264],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11265) ->
	#dungeon_data{
	    no = 11265,
    	lv = 1,
    	timing = 2400,
    	group = 11265,
        pass_group = 11265,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 265,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4265],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11266) ->
	#dungeon_data{
	    no = 11266,
    	lv = 1,
    	timing = 2400,
    	group = 11266,
        pass_group = 11266,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 266,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4266],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11267) ->
	#dungeon_data{
	    no = 11267,
    	lv = 1,
    	timing = 2400,
    	group = 11267,
        pass_group = 11267,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 267,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4267],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11268) ->
	#dungeon_data{
	    no = 11268,
    	lv = 1,
    	timing = 2400,
    	group = 11268,
        pass_group = 11268,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 268,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4268],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11269) ->
	#dungeon_data{
	    no = 11269,
    	lv = 1,
    	timing = 2400,
    	group = 11269,
        pass_group = 11269,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 269,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4269],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11270) ->
	#dungeon_data{
	    no = 11270,
    	lv = 1,
    	timing = 2400,
    	group = 11270,
        pass_group = 11270,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 270,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4270],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11271) ->
	#dungeon_data{
	    no = 11271,
    	lv = 1,
    	timing = 2400,
    	group = 11271,
        pass_group = 11271,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 271,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4271],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11272) ->
	#dungeon_data{
	    no = 11272,
    	lv = 1,
    	timing = 2400,
    	group = 11272,
        pass_group = 11272,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 272,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4272],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11273) ->
	#dungeon_data{
	    no = 11273,
    	lv = 1,
    	timing = 2400,
    	group = 11273,
        pass_group = 11273,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 273,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4273],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11274) ->
	#dungeon_data{
	    no = 11274,
    	lv = 1,
    	timing = 2400,
    	group = 11274,
        pass_group = 11274,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 274,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4274],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11275) ->
	#dungeon_data{
	    no = 11275,
    	lv = 1,
    	timing = 2400,
    	group = 11275,
        pass_group = 11275,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 275,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4275],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11276) ->
	#dungeon_data{
	    no = 11276,
    	lv = 1,
    	timing = 2400,
    	group = 11276,
        pass_group = 11276,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 276,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4276],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11277) ->
	#dungeon_data{
	    no = 11277,
    	lv = 1,
    	timing = 2400,
    	group = 11277,
        pass_group = 11277,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 277,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4277],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11278) ->
	#dungeon_data{
	    no = 11278,
    	lv = 1,
    	timing = 2400,
    	group = 11278,
        pass_group = 11278,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 278,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4278],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11279) ->
	#dungeon_data{
	    no = 11279,
    	lv = 1,
    	timing = 2400,
    	group = 11279,
        pass_group = 11279,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 279,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4279],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11280) ->
	#dungeon_data{
	    no = 11280,
    	lv = 1,
    	timing = 2400,
    	group = 11280,
        pass_group = 11280,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 280,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4280],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11281) ->
	#dungeon_data{
	    no = 11281,
    	lv = 1,
    	timing = 2400,
    	group = 11281,
        pass_group = 11281,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 281,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4281],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11282) ->
	#dungeon_data{
	    no = 11282,
    	lv = 1,
    	timing = 2400,
    	group = 11282,
        pass_group = 11282,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 282,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4282],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11283) ->
	#dungeon_data{
	    no = 11283,
    	lv = 1,
    	timing = 2400,
    	group = 11283,
        pass_group = 11283,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 283,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4283],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11284) ->
	#dungeon_data{
	    no = 11284,
    	lv = 1,
    	timing = 2400,
    	group = 11284,
        pass_group = 11284,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 284,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4284],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11285) ->
	#dungeon_data{
	    no = 11285,
    	lv = 1,
    	timing = 2400,
    	group = 11285,
        pass_group = 11285,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 285,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4285],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11286) ->
	#dungeon_data{
	    no = 11286,
    	lv = 1,
    	timing = 2400,
    	group = 11286,
        pass_group = 11286,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 286,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4286],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11287) ->
	#dungeon_data{
	    no = 11287,
    	lv = 1,
    	timing = 2400,
    	group = 11287,
        pass_group = 11287,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 287,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4287],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11288) ->
	#dungeon_data{
	    no = 11288,
    	lv = 1,
    	timing = 2400,
    	group = 11288,
        pass_group = 11288,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 288,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4288],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11289) ->
	#dungeon_data{
	    no = 11289,
    	lv = 1,
    	timing = 2400,
    	group = 11289,
        pass_group = 11289,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 289,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4289],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11290) ->
	#dungeon_data{
	    no = 11290,
    	lv = 1,
    	timing = 2400,
    	group = 11290,
        pass_group = 11290,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 290,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4290],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11291) ->
	#dungeon_data{
	    no = 11291,
    	lv = 1,
    	timing = 2400,
    	group = 11291,
        pass_group = 11291,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 291,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4291],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11292) ->
	#dungeon_data{
	    no = 11292,
    	lv = 1,
    	timing = 2400,
    	group = 11292,
        pass_group = 11292,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 292,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4292],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11293) ->
	#dungeon_data{
	    no = 11293,
    	lv = 1,
    	timing = 2400,
    	group = 11293,
        pass_group = 11293,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 293,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4293],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11294) ->
	#dungeon_data{
	    no = 11294,
    	lv = 1,
    	timing = 2400,
    	group = 11294,
        pass_group = 11294,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 294,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4294],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11295) ->
	#dungeon_data{
	    no = 11295,
    	lv = 1,
    	timing = 2400,
    	group = 11295,
        pass_group = 11295,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 295,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4295],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11296) ->
	#dungeon_data{
	    no = 11296,
    	lv = 1,
    	timing = 2400,
    	group = 11296,
        pass_group = 11296,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 296,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4296],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11297) ->
	#dungeon_data{
	    no = 11297,
    	lv = 1,
    	timing = 2400,
    	group = 11297,
        pass_group = 11297,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 297,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4297],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11298) ->
	#dungeon_data{
	    no = 11298,
    	lv = 1,
    	timing = 2400,
    	group = 11298,
        pass_group = 11298,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 298,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4298],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11299) ->
	#dungeon_data{
	    no = 11299,
    	lv = 1,
    	timing = 2400,
    	group = 11299,
        pass_group = 11299,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 299,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4299],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;
   
get(11300) ->
	#dungeon_data{
	    no = 11300,
    	lv = 1,
    	timing = 2400,
    	group = 11300,
        pass_group = 11300,
        had_pass_reward =1,
    	type = 8,
    	diff = 1,
    	cd =  {day, 9999},
		floor = 300,
        init_pos = {},
    	role_num = 1,
    	more_box_price = [],
    	discount = 100,
        default_listener = [1],
        listen_bout_battle = [4300],
        listen_dead_battle = [],
        bout_max_points = 0,
        dead_max_points = 0,
        point_lv = [],
        listener = [],
		reward_times= 1,
		final_reward = 42006,
		first_reward = 391001
   }
			;

get(_Arg) ->
    ?ASSERT(false, [_Arg]),
    null.
		  
get_nos()->
	[2001,2002,2003,2011,2012,2013,2021,2022,2023,2031,2032,2033,2034,2041,2042,2043,4001,4002,4003,4004,4011,4012,4013,4021,4022,4023,4031,4032,4033,4041,4042,4043,5001,5002,5003,5011,5012,5013,5021,5022,5023,5031,5032,5033,5041,5042,5043,5051,5052,5053,5054,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013,10014,10015,10016,10017,10018,10019,10020,10021,10022,10023,10024,10025,10026,10027,10028,10029,10030,10031,10032,10033,10034,10035,10036,10037,10038,10039,10040,10041,10042,10043,10044,10045,10046,10047,10048,10049,10050,10051,10052,10053,10054,10055,10056,10057,10058,10059,10060,10061,10062,10063,10064,10065,10066,10067,10068,10069,10070,10071,10072,10073,10074,10075,10076,10077,10078,10079,10080,10081,10082,10083,10084,10085,10086,10087,10088,10089,10090,10091,10092,10093,10094,10095,10096,10097,10098,10099,10100,10101,10102,10103,10104,10105,10106,10107,10108,10109,10110,10111,10112,10113,10114,10115,10116,10117,10118,10119,10120,10121,10122,10123,10124,10125,10126,10127,10128,10129,10130,10131,10132,10133,10134,10135,10136,10137,10138,10139,10140,10141,10142,10143,10144,10145,10146,10147,10148,10149,10150,10151,10152,10153,10154,10155,10156,10157,10158,10159,10160,10161,10162,10163,10164,10165,10166,10167,10168,10169,10170,10171,10172,10173,10174,10175,10176,10177,10178,10179,10180,10181,10182,10183,10184,10185,10186,10187,10188,10189,10190,10191,10192,10193,10194,10195,10196,10197,10198,10199,10200,10201,10202,10203,10204,10205,10206,10207,10208,10209,10210,10211,10212,10213,10214,10215,10216,10217,10218,10219,10220,10221,10222,10223,10224,10225,10226,10227,10228,10229,10230,10231,10232,10233,10234,10235,10236,10237,10238,10239,10240,10241,10242,10243,10244,10245,10246,10247,10248,10249,10250,10251,10252,10253,10254,10255,10256,10257,10258,10259,10260,10261,10262,10263,10264,10265,10266,10267,10268,10269,10270,10271,10272,10273,10274,10275,10276,10277,10278,10279,10280,10281,10282,10283,10284,10285,10286,10287,10288,10289,10290,10291,10292,10293,10294,10295,10296,10297,10298,10299,10300,11001,11002,11003,11004,11005,11006,11007,11008,11009,11010,11011,11012,11013,11014,11015,11016,11017,11018,11019,11020,11021,11022,11023,11024,11025,11026,11027,11028,11029,11030,11031,11032,11033,11034,11035,11036,11037,11038,11039,11040,11041,11042,11043,11044,11045,11046,11047,11048,11049,11050,11051,11052,11053,11054,11055,11056,11057,11058,11059,11060,11061,11062,11063,11064,11065,11066,11067,11068,11069,11070,11071,11072,11073,11074,11075,11076,11077,11078,11079,11080,11081,11082,11083,11084,11085,11086,11087,11088,11089,11090,11091,11092,11093,11094,11095,11096,11097,11098,11099,11100,11101,11102,11103,11104,11105,11106,11107,11108,11109,11110,11111,11112,11113,11114,11115,11116,11117,11118,11119,11120,11121,11122,11123,11124,11125,11126,11127,11128,11129,11130,11131,11132,11133,11134,11135,11136,11137,11138,11139,11140,11141,11142,11143,11144,11145,11146,11147,11148,11149,11150,11151,11152,11153,11154,11155,11156,11157,11158,11159,11160,11161,11162,11163,11164,11165,11166,11167,11168,11169,11170,11171,11172,11173,11174,11175,11176,11177,11178,11179,11180,11181,11182,11183,11184,11185,11186,11187,11188,11189,11190,11191,11192,11193,11194,11195,11196,11197,11198,11199,11200,11201,11202,11203,11204,11205,11206,11207,11208,11209,11210,11211,11212,11213,11214,11215,11216,11217,11218,11219,11220,11221,11222,11223,11224,11225,11226,11227,11228,11229,11230,11231,11232,11233,11234,11235,11236,11237,11238,11239,11240,11241,11242,11243,11244,11245,11246,11247,11248,11249,11250,11251,11252,11253,11254,11255,11256,11257,11258,11259,11260,11261,11262,11263,11264,11265,11266,11267,11268,11269,11270,11271,11272,11273,11274,11275,11276,11277,11278,11279,11280,11281,11282,11283,11284,11285,11286,11287,11288,11289,11290,11291,11292,11293,11294,11295,11296,11297,11298,11299,11300,110001,110002,120000,120001,120002,120003,120004,200000,200001,200002,200003,200004,200005,200006,300001,300002,300003].

get_group(5051)->
	[{1,5051},{2,5052},{3,5053},{4,5054}];
get_group(4001)->
	[{1,4001},{2,4002},{3,4003},{4,4004}];
get_group(2031)->
	[{1,2031},{2,2032},{3,2033},{4,2034}];
get_group(50)->
	[{1,5001},{2,5002},{3,5003}];
get_group(51)->
	[{1,5011},{2,5012},{3,5013}];
get_group(52)->
	[{1,5021},{2,5022},{3,5023}];
get_group(53)->
	[{1,5031},{2,5032},{3,5033}];
get_group(54)->
	[{1,5041},{2,5042},{3,5043}];
get_group(2)->
	[{1,2041},{2,2042},{3,2043},{1,2001},{2,2002},{3,2003},{1,2011},{2,2012},{3,2013},{1,2021},{2,2022},{3,2023}];
get_group(4)->
	[{1,4011},{2,4012},{3,4013},{1,4021},{2,4022},{3,4023},{1,4031},{2,4032},{3,4033},{1,4041},{2,4042},{3,4043}];
get_group(110001)->
	[{1,110001}];
get_group(110002)->
	[{2,110002}];
get_group(120000)->
	[{1,120000},{1,120001},{1,120002},{1,120004},{1,120003}];
get_group(300000)->
	[{1,300001},{2,300002},{3,300003}];
get_group(20000)->
	[{1,200000},{1,200001},{1,200002},{1,200003},{1,200004},{1,200005},{1,200006}];
get_group(10001)->
	[{1,10001}];
get_group(10002)->
	[{1,10002}];
get_group(10003)->
	[{1,10003}];
get_group(10004)->
	[{1,10004}];
get_group(10005)->
	[{1,10005}];
get_group(10006)->
	[{1,10006}];
get_group(10007)->
	[{1,10007}];
get_group(10008)->
	[{1,10008}];
get_group(10009)->
	[{1,10009}];
get_group(10010)->
	[{1,10010}];
get_group(10011)->
	[{1,10011}];
get_group(10012)->
	[{1,10012}];
get_group(10013)->
	[{1,10013}];
get_group(10014)->
	[{1,10014}];
get_group(10015)->
	[{1,10015}];
get_group(10016)->
	[{1,10016}];
get_group(10017)->
	[{1,10017}];
get_group(10018)->
	[{1,10018}];
get_group(10019)->
	[{1,10019}];
get_group(10020)->
	[{1,10020}];
get_group(10021)->
	[{1,10021}];
get_group(10022)->
	[{1,10022}];
get_group(10023)->
	[{1,10023}];
get_group(10024)->
	[{1,10024}];
get_group(10025)->
	[{1,10025}];
get_group(10026)->
	[{1,10026}];
get_group(10027)->
	[{1,10027}];
get_group(10028)->
	[{1,10028}];
get_group(10029)->
	[{1,10029}];
get_group(10030)->
	[{1,10030}];
get_group(10031)->
	[{1,10031}];
get_group(10032)->
	[{1,10032}];
get_group(10033)->
	[{1,10033}];
get_group(10034)->
	[{1,10034}];
get_group(10035)->
	[{1,10035}];
get_group(10036)->
	[{1,10036}];
get_group(10037)->
	[{1,10037}];
get_group(10038)->
	[{1,10038}];
get_group(10039)->
	[{1,10039}];
get_group(10040)->
	[{1,10040}];
get_group(10041)->
	[{1,10041}];
get_group(10042)->
	[{1,10042}];
get_group(10043)->
	[{1,10043}];
get_group(10044)->
	[{1,10044}];
get_group(10045)->
	[{1,10045}];
get_group(10046)->
	[{1,10046}];
get_group(10047)->
	[{1,10047}];
get_group(10048)->
	[{1,10048}];
get_group(10049)->
	[{1,10049}];
get_group(10050)->
	[{1,10050}];
get_group(10051)->
	[{1,10051}];
get_group(10052)->
	[{1,10052}];
get_group(10053)->
	[{1,10053}];
get_group(10054)->
	[{1,10054}];
get_group(10055)->
	[{1,10055}];
get_group(10056)->
	[{1,10056}];
get_group(10057)->
	[{1,10057}];
get_group(10058)->
	[{1,10058}];
get_group(10059)->
	[{1,10059}];
get_group(10060)->
	[{1,10060}];
get_group(10061)->
	[{1,10061}];
get_group(10062)->
	[{1,10062}];
get_group(10063)->
	[{1,10063}];
get_group(10064)->
	[{1,10064}];
get_group(10065)->
	[{1,10065}];
get_group(10066)->
	[{1,10066}];
get_group(10067)->
	[{1,10067}];
get_group(10068)->
	[{1,10068}];
get_group(10069)->
	[{1,10069}];
get_group(10070)->
	[{1,10070}];
get_group(10071)->
	[{1,10071}];
get_group(10072)->
	[{1,10072}];
get_group(10073)->
	[{1,10073}];
get_group(10074)->
	[{1,10074}];
get_group(10075)->
	[{1,10075}];
get_group(10076)->
	[{1,10076}];
get_group(10077)->
	[{1,10077}];
get_group(10078)->
	[{1,10078}];
get_group(10079)->
	[{1,10079}];
get_group(10080)->
	[{1,10080}];
get_group(10081)->
	[{1,10081}];
get_group(10082)->
	[{1,10082}];
get_group(10083)->
	[{1,10083}];
get_group(10084)->
	[{1,10084}];
get_group(10085)->
	[{1,10085}];
get_group(10086)->
	[{1,10086}];
get_group(10087)->
	[{1,10087}];
get_group(10088)->
	[{1,10088}];
get_group(10089)->
	[{1,10089}];
get_group(10090)->
	[{1,10090}];
get_group(10091)->
	[{1,10091}];
get_group(10092)->
	[{1,10092}];
get_group(10093)->
	[{1,10093}];
get_group(10094)->
	[{1,10094}];
get_group(10095)->
	[{1,10095}];
get_group(10096)->
	[{1,10096}];
get_group(10097)->
	[{1,10097}];
get_group(10098)->
	[{1,10098}];
get_group(10099)->
	[{1,10099}];
get_group(10100)->
	[{1,10100}];
get_group(10101)->
	[{1,10101}];
get_group(10102)->
	[{1,10102}];
get_group(10103)->
	[{1,10103}];
get_group(10104)->
	[{1,10104}];
get_group(10105)->
	[{1,10105}];
get_group(10106)->
	[{1,10106}];
get_group(10107)->
	[{1,10107}];
get_group(10108)->
	[{1,10108}];
get_group(10109)->
	[{1,10109}];
get_group(10110)->
	[{1,10110}];
get_group(10111)->
	[{1,10111}];
get_group(10112)->
	[{1,10112}];
get_group(10113)->
	[{1,10113}];
get_group(10114)->
	[{1,10114}];
get_group(10115)->
	[{1,10115}];
get_group(10116)->
	[{1,10116}];
get_group(10117)->
	[{1,10117}];
get_group(10118)->
	[{1,10118}];
get_group(10119)->
	[{1,10119}];
get_group(10120)->
	[{1,10120}];
get_group(10121)->
	[{1,10121}];
get_group(10122)->
	[{1,10122}];
get_group(10123)->
	[{1,10123}];
get_group(10124)->
	[{1,10124}];
get_group(10125)->
	[{1,10125}];
get_group(10126)->
	[{1,10126}];
get_group(10127)->
	[{1,10127}];
get_group(10128)->
	[{1,10128}];
get_group(10129)->
	[{1,10129}];
get_group(10130)->
	[{1,10130}];
get_group(10131)->
	[{1,10131}];
get_group(10132)->
	[{1,10132}];
get_group(10133)->
	[{1,10133}];
get_group(10134)->
	[{1,10134}];
get_group(10135)->
	[{1,10135}];
get_group(10136)->
	[{1,10136}];
get_group(10137)->
	[{1,10137}];
get_group(10138)->
	[{1,10138}];
get_group(10139)->
	[{1,10139}];
get_group(10140)->
	[{1,10140}];
get_group(10141)->
	[{1,10141}];
get_group(10142)->
	[{1,10142}];
get_group(10143)->
	[{1,10143}];
get_group(10144)->
	[{1,10144}];
get_group(10145)->
	[{1,10145}];
get_group(10146)->
	[{1,10146}];
get_group(10147)->
	[{1,10147}];
get_group(10148)->
	[{1,10148}];
get_group(10149)->
	[{1,10149}];
get_group(10150)->
	[{1,10150}];
get_group(10151)->
	[{1,10151}];
get_group(10152)->
	[{1,10152}];
get_group(10153)->
	[{1,10153}];
get_group(10154)->
	[{1,10154}];
get_group(10155)->
	[{1,10155}];
get_group(10156)->
	[{1,10156}];
get_group(10157)->
	[{1,10157}];
get_group(10158)->
	[{1,10158}];
get_group(10159)->
	[{1,10159}];
get_group(10160)->
	[{1,10160}];
get_group(10161)->
	[{1,10161}];
get_group(10162)->
	[{1,10162}];
get_group(10163)->
	[{1,10163}];
get_group(10164)->
	[{1,10164}];
get_group(10165)->
	[{1,10165}];
get_group(10166)->
	[{1,10166}];
get_group(10167)->
	[{1,10167}];
get_group(10168)->
	[{1,10168}];
get_group(10169)->
	[{1,10169}];
get_group(10170)->
	[{1,10170}];
get_group(10171)->
	[{1,10171}];
get_group(10172)->
	[{1,10172}];
get_group(10173)->
	[{1,10173}];
get_group(10174)->
	[{1,10174}];
get_group(10175)->
	[{1,10175}];
get_group(10176)->
	[{1,10176}];
get_group(10177)->
	[{1,10177}];
get_group(10178)->
	[{1,10178}];
get_group(10179)->
	[{1,10179}];
get_group(10180)->
	[{1,10180}];
get_group(10181)->
	[{1,10181}];
get_group(10182)->
	[{1,10182}];
get_group(10183)->
	[{1,10183}];
get_group(10184)->
	[{1,10184}];
get_group(10185)->
	[{1,10185}];
get_group(10186)->
	[{1,10186}];
get_group(10187)->
	[{1,10187}];
get_group(10188)->
	[{1,10188}];
get_group(10189)->
	[{1,10189}];
get_group(10190)->
	[{1,10190}];
get_group(10191)->
	[{1,10191}];
get_group(10192)->
	[{1,10192}];
get_group(10193)->
	[{1,10193}];
get_group(10194)->
	[{1,10194}];
get_group(10195)->
	[{1,10195}];
get_group(10196)->
	[{1,10196}];
get_group(10197)->
	[{1,10197}];
get_group(10198)->
	[{1,10198}];
get_group(10199)->
	[{1,10199}];
get_group(10200)->
	[{1,10200}];
get_group(10201)->
	[{1,10201}];
get_group(10202)->
	[{1,10202}];
get_group(10203)->
	[{1,10203}];
get_group(10204)->
	[{1,10204}];
get_group(10205)->
	[{1,10205}];
get_group(10206)->
	[{1,10206}];
get_group(10207)->
	[{1,10207}];
get_group(10208)->
	[{1,10208}];
get_group(10209)->
	[{1,10209}];
get_group(10210)->
	[{1,10210}];
get_group(10211)->
	[{1,10211}];
get_group(10212)->
	[{1,10212}];
get_group(10213)->
	[{1,10213}];
get_group(10214)->
	[{1,10214}];
get_group(10215)->
	[{1,10215}];
get_group(10216)->
	[{1,10216}];
get_group(10217)->
	[{1,10217}];
get_group(10218)->
	[{1,10218}];
get_group(10219)->
	[{1,10219}];
get_group(10220)->
	[{1,10220}];
get_group(10221)->
	[{1,10221}];
get_group(10222)->
	[{1,10222}];
get_group(10223)->
	[{1,10223}];
get_group(10224)->
	[{1,10224}];
get_group(10225)->
	[{1,10225}];
get_group(10226)->
	[{1,10226}];
get_group(10227)->
	[{1,10227}];
get_group(10228)->
	[{1,10228}];
get_group(10229)->
	[{1,10229}];
get_group(10230)->
	[{1,10230}];
get_group(10231)->
	[{1,10231}];
get_group(10232)->
	[{1,10232}];
get_group(10233)->
	[{1,10233}];
get_group(10234)->
	[{1,10234}];
get_group(10235)->
	[{1,10235}];
get_group(10236)->
	[{1,10236}];
get_group(10237)->
	[{1,10237}];
get_group(10238)->
	[{1,10238}];
get_group(10239)->
	[{1,10239}];
get_group(10240)->
	[{1,10240}];
get_group(10241)->
	[{1,10241}];
get_group(10242)->
	[{1,10242}];
get_group(10243)->
	[{1,10243}];
get_group(10244)->
	[{1,10244}];
get_group(10245)->
	[{1,10245}];
get_group(10246)->
	[{1,10246}];
get_group(10247)->
	[{1,10247}];
get_group(10248)->
	[{1,10248}];
get_group(10249)->
	[{1,10249}];
get_group(10250)->
	[{1,10250}];
get_group(10251)->
	[{1,10251}];
get_group(10252)->
	[{1,10252}];
get_group(10253)->
	[{1,10253}];
get_group(10254)->
	[{1,10254}];
get_group(10255)->
	[{1,10255}];
get_group(10256)->
	[{1,10256}];
get_group(10257)->
	[{1,10257}];
get_group(10258)->
	[{1,10258}];
get_group(10259)->
	[{1,10259}];
get_group(10260)->
	[{1,10260}];
get_group(10261)->
	[{1,10261}];
get_group(10262)->
	[{1,10262}];
get_group(10263)->
	[{1,10263}];
get_group(10264)->
	[{1,10264}];
get_group(10265)->
	[{1,10265}];
get_group(10266)->
	[{1,10266}];
get_group(10267)->
	[{1,10267}];
get_group(10268)->
	[{1,10268}];
get_group(10269)->
	[{1,10269}];
get_group(10270)->
	[{1,10270}];
get_group(10271)->
	[{1,10271}];
get_group(10272)->
	[{1,10272}];
get_group(10273)->
	[{1,10273}];
get_group(10274)->
	[{1,10274}];
get_group(10275)->
	[{1,10275}];
get_group(10276)->
	[{1,10276}];
get_group(10277)->
	[{1,10277}];
get_group(10278)->
	[{1,10278}];
get_group(10279)->
	[{1,10279}];
get_group(10280)->
	[{1,10280}];
get_group(10281)->
	[{1,10281}];
get_group(10282)->
	[{1,10282}];
get_group(10283)->
	[{1,10283}];
get_group(10284)->
	[{1,10284}];
get_group(10285)->
	[{1,10285}];
get_group(10286)->
	[{1,10286}];
get_group(10287)->
	[{1,10287}];
get_group(10288)->
	[{1,10288}];
get_group(10289)->
	[{1,10289}];
get_group(10290)->
	[{1,10290}];
get_group(10291)->
	[{1,10291}];
get_group(10292)->
	[{1,10292}];
get_group(10293)->
	[{1,10293}];
get_group(10294)->
	[{1,10294}];
get_group(10295)->
	[{1,10295}];
get_group(10296)->
	[{1,10296}];
get_group(10297)->
	[{1,10297}];
get_group(10298)->
	[{1,10298}];
get_group(10299)->
	[{1,10299}];
get_group(10300)->
	[{1,10300}];
get_group(11001)->
	[{1,11001}];
get_group(11002)->
	[{1,11002}];
get_group(11003)->
	[{1,11003}];
get_group(11004)->
	[{1,11004}];
get_group(11005)->
	[{1,11005}];
get_group(11006)->
	[{1,11006}];
get_group(11007)->
	[{1,11007}];
get_group(11008)->
	[{1,11008}];
get_group(11009)->
	[{1,11009}];
get_group(11010)->
	[{1,11010}];
get_group(11011)->
	[{1,11011}];
get_group(11012)->
	[{1,11012}];
get_group(11013)->
	[{1,11013}];
get_group(11014)->
	[{1,11014}];
get_group(11015)->
	[{1,11015}];
get_group(11016)->
	[{1,11016}];
get_group(11017)->
	[{1,11017}];
get_group(11018)->
	[{1,11018}];
get_group(11019)->
	[{1,11019}];
get_group(11020)->
	[{1,11020}];
get_group(11021)->
	[{1,11021}];
get_group(11022)->
	[{1,11022}];
get_group(11023)->
	[{1,11023}];
get_group(11024)->
	[{1,11024}];
get_group(11025)->
	[{1,11025}];
get_group(11026)->
	[{1,11026}];
get_group(11027)->
	[{1,11027}];
get_group(11028)->
	[{1,11028}];
get_group(11029)->
	[{1,11029}];
get_group(11030)->
	[{1,11030}];
get_group(11031)->
	[{1,11031}];
get_group(11032)->
	[{1,11032}];
get_group(11033)->
	[{1,11033}];
get_group(11034)->
	[{1,11034}];
get_group(11035)->
	[{1,11035}];
get_group(11036)->
	[{1,11036}];
get_group(11037)->
	[{1,11037}];
get_group(11038)->
	[{1,11038}];
get_group(11039)->
	[{1,11039}];
get_group(11040)->
	[{1,11040}];
get_group(11041)->
	[{1,11041}];
get_group(11042)->
	[{1,11042}];
get_group(11043)->
	[{1,11043}];
get_group(11044)->
	[{1,11044}];
get_group(11045)->
	[{1,11045}];
get_group(11046)->
	[{1,11046}];
get_group(11047)->
	[{1,11047}];
get_group(11048)->
	[{1,11048}];
get_group(11049)->
	[{1,11049}];
get_group(11050)->
	[{1,11050}];
get_group(11051)->
	[{1,11051}];
get_group(11052)->
	[{1,11052}];
get_group(11053)->
	[{1,11053}];
get_group(11054)->
	[{1,11054}];
get_group(11055)->
	[{1,11055}];
get_group(11056)->
	[{1,11056}];
get_group(11057)->
	[{1,11057}];
get_group(11058)->
	[{1,11058}];
get_group(11059)->
	[{1,11059}];
get_group(11060)->
	[{1,11060}];
get_group(11061)->
	[{1,11061}];
get_group(11062)->
	[{1,11062}];
get_group(11063)->
	[{1,11063}];
get_group(11064)->
	[{1,11064}];
get_group(11065)->
	[{1,11065}];
get_group(11066)->
	[{1,11066}];
get_group(11067)->
	[{1,11067}];
get_group(11068)->
	[{1,11068}];
get_group(11069)->
	[{1,11069}];
get_group(11070)->
	[{1,11070}];
get_group(11071)->
	[{1,11071}];
get_group(11072)->
	[{1,11072}];
get_group(11073)->
	[{1,11073}];
get_group(11074)->
	[{1,11074}];
get_group(11075)->
	[{1,11075}];
get_group(11076)->
	[{1,11076}];
get_group(11077)->
	[{1,11077}];
get_group(11078)->
	[{1,11078}];
get_group(11079)->
	[{1,11079}];
get_group(11080)->
	[{1,11080}];
get_group(11081)->
	[{1,11081}];
get_group(11082)->
	[{1,11082}];
get_group(11083)->
	[{1,11083}];
get_group(11084)->
	[{1,11084}];
get_group(11085)->
	[{1,11085}];
get_group(11086)->
	[{1,11086}];
get_group(11087)->
	[{1,11087}];
get_group(11088)->
	[{1,11088}];
get_group(11089)->
	[{1,11089}];
get_group(11090)->
	[{1,11090}];
get_group(11091)->
	[{1,11091}];
get_group(11092)->
	[{1,11092}];
get_group(11093)->
	[{1,11093}];
get_group(11094)->
	[{1,11094}];
get_group(11095)->
	[{1,11095}];
get_group(11096)->
	[{1,11096}];
get_group(11097)->
	[{1,11097}];
get_group(11098)->
	[{1,11098}];
get_group(11099)->
	[{1,11099}];
get_group(11100)->
	[{1,11100}];
get_group(11101)->
	[{1,11101}];
get_group(11102)->
	[{1,11102}];
get_group(11103)->
	[{1,11103}];
get_group(11104)->
	[{1,11104}];
get_group(11105)->
	[{1,11105}];
get_group(11106)->
	[{1,11106}];
get_group(11107)->
	[{1,11107}];
get_group(11108)->
	[{1,11108}];
get_group(11109)->
	[{1,11109}];
get_group(11110)->
	[{1,11110}];
get_group(11111)->
	[{1,11111}];
get_group(11112)->
	[{1,11112}];
get_group(11113)->
	[{1,11113}];
get_group(11114)->
	[{1,11114}];
get_group(11115)->
	[{1,11115}];
get_group(11116)->
	[{1,11116}];
get_group(11117)->
	[{1,11117}];
get_group(11118)->
	[{1,11118}];
get_group(11119)->
	[{1,11119}];
get_group(11120)->
	[{1,11120}];
get_group(11121)->
	[{1,11121}];
get_group(11122)->
	[{1,11122}];
get_group(11123)->
	[{1,11123}];
get_group(11124)->
	[{1,11124}];
get_group(11125)->
	[{1,11125}];
get_group(11126)->
	[{1,11126}];
get_group(11127)->
	[{1,11127}];
get_group(11128)->
	[{1,11128}];
get_group(11129)->
	[{1,11129}];
get_group(11130)->
	[{1,11130}];
get_group(11131)->
	[{1,11131}];
get_group(11132)->
	[{1,11132}];
get_group(11133)->
	[{1,11133}];
get_group(11134)->
	[{1,11134}];
get_group(11135)->
	[{1,11135}];
get_group(11136)->
	[{1,11136}];
get_group(11137)->
	[{1,11137}];
get_group(11138)->
	[{1,11138}];
get_group(11139)->
	[{1,11139}];
get_group(11140)->
	[{1,11140}];
get_group(11141)->
	[{1,11141}];
get_group(11142)->
	[{1,11142}];
get_group(11143)->
	[{1,11143}];
get_group(11144)->
	[{1,11144}];
get_group(11145)->
	[{1,11145}];
get_group(11146)->
	[{1,11146}];
get_group(11147)->
	[{1,11147}];
get_group(11148)->
	[{1,11148}];
get_group(11149)->
	[{1,11149}];
get_group(11150)->
	[{1,11150}];
get_group(11151)->
	[{1,11151}];
get_group(11152)->
	[{1,11152}];
get_group(11153)->
	[{1,11153}];
get_group(11154)->
	[{1,11154}];
get_group(11155)->
	[{1,11155}];
get_group(11156)->
	[{1,11156}];
get_group(11157)->
	[{1,11157}];
get_group(11158)->
	[{1,11158}];
get_group(11159)->
	[{1,11159}];
get_group(11160)->
	[{1,11160}];
get_group(11161)->
	[{1,11161}];
get_group(11162)->
	[{1,11162}];
get_group(11163)->
	[{1,11163}];
get_group(11164)->
	[{1,11164}];
get_group(11165)->
	[{1,11165}];
get_group(11166)->
	[{1,11166}];
get_group(11167)->
	[{1,11167}];
get_group(11168)->
	[{1,11168}];
get_group(11169)->
	[{1,11169}];
get_group(11170)->
	[{1,11170}];
get_group(11171)->
	[{1,11171}];
get_group(11172)->
	[{1,11172}];
get_group(11173)->
	[{1,11173}];
get_group(11174)->
	[{1,11174}];
get_group(11175)->
	[{1,11175}];
get_group(11176)->
	[{1,11176}];
get_group(11177)->
	[{1,11177}];
get_group(11178)->
	[{1,11178}];
get_group(11179)->
	[{1,11179}];
get_group(11180)->
	[{1,11180}];
get_group(11181)->
	[{1,11181}];
get_group(11182)->
	[{1,11182}];
get_group(11183)->
	[{1,11183}];
get_group(11184)->
	[{1,11184}];
get_group(11185)->
	[{1,11185}];
get_group(11186)->
	[{1,11186}];
get_group(11187)->
	[{1,11187}];
get_group(11188)->
	[{1,11188}];
get_group(11189)->
	[{1,11189}];
get_group(11190)->
	[{1,11190}];
get_group(11191)->
	[{1,11191}];
get_group(11192)->
	[{1,11192}];
get_group(11193)->
	[{1,11193}];
get_group(11194)->
	[{1,11194}];
get_group(11195)->
	[{1,11195}];
get_group(11196)->
	[{1,11196}];
get_group(11197)->
	[{1,11197}];
get_group(11198)->
	[{1,11198}];
get_group(11199)->
	[{1,11199}];
get_group(11200)->
	[{1,11200}];
get_group(11201)->
	[{1,11201}];
get_group(11202)->
	[{1,11202}];
get_group(11203)->
	[{1,11203}];
get_group(11204)->
	[{1,11204}];
get_group(11205)->
	[{1,11205}];
get_group(11206)->
	[{1,11206}];
get_group(11207)->
	[{1,11207}];
get_group(11208)->
	[{1,11208}];
get_group(11209)->
	[{1,11209}];
get_group(11210)->
	[{1,11210}];
get_group(11211)->
	[{1,11211}];
get_group(11212)->
	[{1,11212}];
get_group(11213)->
	[{1,11213}];
get_group(11214)->
	[{1,11214}];
get_group(11215)->
	[{1,11215}];
get_group(11216)->
	[{1,11216}];
get_group(11217)->
	[{1,11217}];
get_group(11218)->
	[{1,11218}];
get_group(11219)->
	[{1,11219}];
get_group(11220)->
	[{1,11220}];
get_group(11221)->
	[{1,11221}];
get_group(11222)->
	[{1,11222}];
get_group(11223)->
	[{1,11223}];
get_group(11224)->
	[{1,11224}];
get_group(11225)->
	[{1,11225}];
get_group(11226)->
	[{1,11226}];
get_group(11227)->
	[{1,11227}];
get_group(11228)->
	[{1,11228}];
get_group(11229)->
	[{1,11229}];
get_group(11230)->
	[{1,11230}];
get_group(11231)->
	[{1,11231}];
get_group(11232)->
	[{1,11232}];
get_group(11233)->
	[{1,11233}];
get_group(11234)->
	[{1,11234}];
get_group(11235)->
	[{1,11235}];
get_group(11236)->
	[{1,11236}];
get_group(11237)->
	[{1,11237}];
get_group(11238)->
	[{1,11238}];
get_group(11239)->
	[{1,11239}];
get_group(11240)->
	[{1,11240}];
get_group(11241)->
	[{1,11241}];
get_group(11242)->
	[{1,11242}];
get_group(11243)->
	[{1,11243}];
get_group(11244)->
	[{1,11244}];
get_group(11245)->
	[{1,11245}];
get_group(11246)->
	[{1,11246}];
get_group(11247)->
	[{1,11247}];
get_group(11248)->
	[{1,11248}];
get_group(11249)->
	[{1,11249}];
get_group(11250)->
	[{1,11250}];
get_group(11251)->
	[{1,11251}];
get_group(11252)->
	[{1,11252}];
get_group(11253)->
	[{1,11253}];
get_group(11254)->
	[{1,11254}];
get_group(11255)->
	[{1,11255}];
get_group(11256)->
	[{1,11256}];
get_group(11257)->
	[{1,11257}];
get_group(11258)->
	[{1,11258}];
get_group(11259)->
	[{1,11259}];
get_group(11260)->
	[{1,11260}];
get_group(11261)->
	[{1,11261}];
get_group(11262)->
	[{1,11262}];
get_group(11263)->
	[{1,11263}];
get_group(11264)->
	[{1,11264}];
get_group(11265)->
	[{1,11265}];
get_group(11266)->
	[{1,11266}];
get_group(11267)->
	[{1,11267}];
get_group(11268)->
	[{1,11268}];
get_group(11269)->
	[{1,11269}];
get_group(11270)->
	[{1,11270}];
get_group(11271)->
	[{1,11271}];
get_group(11272)->
	[{1,11272}];
get_group(11273)->
	[{1,11273}];
get_group(11274)->
	[{1,11274}];
get_group(11275)->
	[{1,11275}];
get_group(11276)->
	[{1,11276}];
get_group(11277)->
	[{1,11277}];
get_group(11278)->
	[{1,11278}];
get_group(11279)->
	[{1,11279}];
get_group(11280)->
	[{1,11280}];
get_group(11281)->
	[{1,11281}];
get_group(11282)->
	[{1,11282}];
get_group(11283)->
	[{1,11283}];
get_group(11284)->
	[{1,11284}];
get_group(11285)->
	[{1,11285}];
get_group(11286)->
	[{1,11286}];
get_group(11287)->
	[{1,11287}];
get_group(11288)->
	[{1,11288}];
get_group(11289)->
	[{1,11289}];
get_group(11290)->
	[{1,11290}];
get_group(11291)->
	[{1,11291}];
get_group(11292)->
	[{1,11292}];
get_group(11293)->
	[{1,11293}];
get_group(11294)->
	[{1,11294}];
get_group(11295)->
	[{1,11295}];
get_group(11296)->
	[{1,11296}];
get_group(11297)->
	[{1,11297}];
get_group(11298)->
	[{1,11298}];
get_group(11299)->
	[{1,11299}];
get_group(11300)->
	[{1,11300}];

		get_group(_Group) ->
    ?ASSERT(false, [_Group]),
    null.
		
get_pass_group(5051)->
	[{1,5051},{2,5052},{3,5053},{4,5054}];
get_pass_group(4001)->
	[{1,4001},{2,4002},{3,4003},{4,4004}];
get_pass_group(2031)->
	[{1,2031},{2,2032},{3,2033},{4,2034}];
get_pass_group(500)->
	[{1,5001},{2,5002},{3,5003}];
get_pass_group(501)->
	[{1,5011},{2,5012},{3,5013}];
get_pass_group(502)->
	[{1,5021},{2,5022},{3,5023}];
get_pass_group(503)->
	[{1,5031},{2,5032},{3,5033}];
get_pass_group(504)->
	[{1,5041},{2,5042},{3,5043}];
get_pass_group(204)->
	[{1,2041},{2,2042},{3,2043}];
get_pass_group(200)->
	[{1,2001},{2,2002},{3,2003}];
get_pass_group(201)->
	[{1,2011},{2,2012},{3,2013}];
get_pass_group(202)->
	[{1,2021},{2,2022},{3,2023}];
get_pass_group(401)->
	[{1,4011},{2,4012},{3,4013}];
get_pass_group(402)->
	[{1,4021},{2,4022},{3,4023}];
get_pass_group(1000)->
	[{1,110001},{2,110002}];
get_pass_group(1200)->
	[{1,120000},{1,120001},{1,120002},{1,120004},{1,120003}];
get_pass_group(3000)->
	[{1,300001},{2,300002},{3,300003}];
get_pass_group(403)->
	[{1,4031},{2,4032},{3,4033}];
get_pass_group(404)->
	[{1,4041},{2,4042},{3,4043}];
get_pass_group(1)->
	[{1,200000}];
get_pass_group(2)->
	[{1,200001}];
get_pass_group(3)->
	[{1,200002}];
get_pass_group(4)->
	[{1,200003}];
get_pass_group(5)->
	[{1,200004}];
get_pass_group(6)->
	[{1,200005}];
get_pass_group(7)->
	[{1,200006}];
get_pass_group(10001)->
	[{1,10001}];
get_pass_group(10002)->
	[{1,10002}];
get_pass_group(10003)->
	[{1,10003}];
get_pass_group(10004)->
	[{1,10004}];
get_pass_group(10005)->
	[{1,10005}];
get_pass_group(10006)->
	[{1,10006}];
get_pass_group(10007)->
	[{1,10007}];
get_pass_group(10008)->
	[{1,10008}];
get_pass_group(10009)->
	[{1,10009}];
get_pass_group(10010)->
	[{1,10010}];
get_pass_group(10011)->
	[{1,10011}];
get_pass_group(10012)->
	[{1,10012}];
get_pass_group(10013)->
	[{1,10013}];
get_pass_group(10014)->
	[{1,10014}];
get_pass_group(10015)->
	[{1,10015}];
get_pass_group(10016)->
	[{1,10016}];
get_pass_group(10017)->
	[{1,10017}];
get_pass_group(10018)->
	[{1,10018}];
get_pass_group(10019)->
	[{1,10019}];
get_pass_group(10020)->
	[{1,10020}];
get_pass_group(10021)->
	[{1,10021}];
get_pass_group(10022)->
	[{1,10022}];
get_pass_group(10023)->
	[{1,10023}];
get_pass_group(10024)->
	[{1,10024}];
get_pass_group(10025)->
	[{1,10025}];
get_pass_group(10026)->
	[{1,10026}];
get_pass_group(10027)->
	[{1,10027}];
get_pass_group(10028)->
	[{1,10028}];
get_pass_group(10029)->
	[{1,10029}];
get_pass_group(10030)->
	[{1,10030}];
get_pass_group(10031)->
	[{1,10031}];
get_pass_group(10032)->
	[{1,10032}];
get_pass_group(10033)->
	[{1,10033}];
get_pass_group(10034)->
	[{1,10034}];
get_pass_group(10035)->
	[{1,10035}];
get_pass_group(10036)->
	[{1,10036}];
get_pass_group(10037)->
	[{1,10037}];
get_pass_group(10038)->
	[{1,10038}];
get_pass_group(10039)->
	[{1,10039}];
get_pass_group(10040)->
	[{1,10040}];
get_pass_group(10041)->
	[{1,10041}];
get_pass_group(10042)->
	[{1,10042}];
get_pass_group(10043)->
	[{1,10043}];
get_pass_group(10044)->
	[{1,10044}];
get_pass_group(10045)->
	[{1,10045}];
get_pass_group(10046)->
	[{1,10046}];
get_pass_group(10047)->
	[{1,10047}];
get_pass_group(10048)->
	[{1,10048}];
get_pass_group(10049)->
	[{1,10049}];
get_pass_group(10050)->
	[{1,10050}];
get_pass_group(10051)->
	[{1,10051}];
get_pass_group(10052)->
	[{1,10052}];
get_pass_group(10053)->
	[{1,10053}];
get_pass_group(10054)->
	[{1,10054}];
get_pass_group(10055)->
	[{1,10055}];
get_pass_group(10056)->
	[{1,10056}];
get_pass_group(10057)->
	[{1,10057}];
get_pass_group(10058)->
	[{1,10058}];
get_pass_group(10059)->
	[{1,10059}];
get_pass_group(10060)->
	[{1,10060}];
get_pass_group(10061)->
	[{1,10061}];
get_pass_group(10062)->
	[{1,10062}];
get_pass_group(10063)->
	[{1,10063}];
get_pass_group(10064)->
	[{1,10064}];
get_pass_group(10065)->
	[{1,10065}];
get_pass_group(10066)->
	[{1,10066}];
get_pass_group(10067)->
	[{1,10067}];
get_pass_group(10068)->
	[{1,10068}];
get_pass_group(10069)->
	[{1,10069}];
get_pass_group(10070)->
	[{1,10070}];
get_pass_group(10071)->
	[{1,10071}];
get_pass_group(10072)->
	[{1,10072}];
get_pass_group(10073)->
	[{1,10073}];
get_pass_group(10074)->
	[{1,10074}];
get_pass_group(10075)->
	[{1,10075}];
get_pass_group(10076)->
	[{1,10076}];
get_pass_group(10077)->
	[{1,10077}];
get_pass_group(10078)->
	[{1,10078}];
get_pass_group(10079)->
	[{1,10079}];
get_pass_group(10080)->
	[{1,10080}];
get_pass_group(10081)->
	[{1,10081}];
get_pass_group(10082)->
	[{1,10082}];
get_pass_group(10083)->
	[{1,10083}];
get_pass_group(10084)->
	[{1,10084}];
get_pass_group(10085)->
	[{1,10085}];
get_pass_group(10086)->
	[{1,10086}];
get_pass_group(10087)->
	[{1,10087}];
get_pass_group(10088)->
	[{1,10088}];
get_pass_group(10089)->
	[{1,10089}];
get_pass_group(10090)->
	[{1,10090}];
get_pass_group(10091)->
	[{1,10091}];
get_pass_group(10092)->
	[{1,10092}];
get_pass_group(10093)->
	[{1,10093}];
get_pass_group(10094)->
	[{1,10094}];
get_pass_group(10095)->
	[{1,10095}];
get_pass_group(10096)->
	[{1,10096}];
get_pass_group(10097)->
	[{1,10097}];
get_pass_group(10098)->
	[{1,10098}];
get_pass_group(10099)->
	[{1,10099}];
get_pass_group(10100)->
	[{1,10100}];
get_pass_group(10101)->
	[{1,10101}];
get_pass_group(10102)->
	[{1,10102}];
get_pass_group(10103)->
	[{1,10103}];
get_pass_group(10104)->
	[{1,10104}];
get_pass_group(10105)->
	[{1,10105}];
get_pass_group(10106)->
	[{1,10106}];
get_pass_group(10107)->
	[{1,10107}];
get_pass_group(10108)->
	[{1,10108}];
get_pass_group(10109)->
	[{1,10109}];
get_pass_group(10110)->
	[{1,10110}];
get_pass_group(10111)->
	[{1,10111}];
get_pass_group(10112)->
	[{1,10112}];
get_pass_group(10113)->
	[{1,10113}];
get_pass_group(10114)->
	[{1,10114}];
get_pass_group(10115)->
	[{1,10115}];
get_pass_group(10116)->
	[{1,10116}];
get_pass_group(10117)->
	[{1,10117}];
get_pass_group(10118)->
	[{1,10118}];
get_pass_group(10119)->
	[{1,10119}];
get_pass_group(10120)->
	[{1,10120}];
get_pass_group(10121)->
	[{1,10121}];
get_pass_group(10122)->
	[{1,10122}];
get_pass_group(10123)->
	[{1,10123}];
get_pass_group(10124)->
	[{1,10124}];
get_pass_group(10125)->
	[{1,10125}];
get_pass_group(10126)->
	[{1,10126}];
get_pass_group(10127)->
	[{1,10127}];
get_pass_group(10128)->
	[{1,10128}];
get_pass_group(10129)->
	[{1,10129}];
get_pass_group(10130)->
	[{1,10130}];
get_pass_group(10131)->
	[{1,10131}];
get_pass_group(10132)->
	[{1,10132}];
get_pass_group(10133)->
	[{1,10133}];
get_pass_group(10134)->
	[{1,10134}];
get_pass_group(10135)->
	[{1,10135}];
get_pass_group(10136)->
	[{1,10136}];
get_pass_group(10137)->
	[{1,10137}];
get_pass_group(10138)->
	[{1,10138}];
get_pass_group(10139)->
	[{1,10139}];
get_pass_group(10140)->
	[{1,10140}];
get_pass_group(10141)->
	[{1,10141}];
get_pass_group(10142)->
	[{1,10142}];
get_pass_group(10143)->
	[{1,10143}];
get_pass_group(10144)->
	[{1,10144}];
get_pass_group(10145)->
	[{1,10145}];
get_pass_group(10146)->
	[{1,10146}];
get_pass_group(10147)->
	[{1,10147}];
get_pass_group(10148)->
	[{1,10148}];
get_pass_group(10149)->
	[{1,10149}];
get_pass_group(10150)->
	[{1,10150}];
get_pass_group(10151)->
	[{1,10151}];
get_pass_group(10152)->
	[{1,10152}];
get_pass_group(10153)->
	[{1,10153}];
get_pass_group(10154)->
	[{1,10154}];
get_pass_group(10155)->
	[{1,10155}];
get_pass_group(10156)->
	[{1,10156}];
get_pass_group(10157)->
	[{1,10157}];
get_pass_group(10158)->
	[{1,10158}];
get_pass_group(10159)->
	[{1,10159}];
get_pass_group(10160)->
	[{1,10160}];
get_pass_group(10161)->
	[{1,10161}];
get_pass_group(10162)->
	[{1,10162}];
get_pass_group(10163)->
	[{1,10163}];
get_pass_group(10164)->
	[{1,10164}];
get_pass_group(10165)->
	[{1,10165}];
get_pass_group(10166)->
	[{1,10166}];
get_pass_group(10167)->
	[{1,10167}];
get_pass_group(10168)->
	[{1,10168}];
get_pass_group(10169)->
	[{1,10169}];
get_pass_group(10170)->
	[{1,10170}];
get_pass_group(10171)->
	[{1,10171}];
get_pass_group(10172)->
	[{1,10172}];
get_pass_group(10173)->
	[{1,10173}];
get_pass_group(10174)->
	[{1,10174}];
get_pass_group(10175)->
	[{1,10175}];
get_pass_group(10176)->
	[{1,10176}];
get_pass_group(10177)->
	[{1,10177}];
get_pass_group(10178)->
	[{1,10178}];
get_pass_group(10179)->
	[{1,10179}];
get_pass_group(10180)->
	[{1,10180}];
get_pass_group(10181)->
	[{1,10181}];
get_pass_group(10182)->
	[{1,10182}];
get_pass_group(10183)->
	[{1,10183}];
get_pass_group(10184)->
	[{1,10184}];
get_pass_group(10185)->
	[{1,10185}];
get_pass_group(10186)->
	[{1,10186}];
get_pass_group(10187)->
	[{1,10187}];
get_pass_group(10188)->
	[{1,10188}];
get_pass_group(10189)->
	[{1,10189}];
get_pass_group(10190)->
	[{1,10190}];
get_pass_group(10191)->
	[{1,10191}];
get_pass_group(10192)->
	[{1,10192}];
get_pass_group(10193)->
	[{1,10193}];
get_pass_group(10194)->
	[{1,10194}];
get_pass_group(10195)->
	[{1,10195}];
get_pass_group(10196)->
	[{1,10196}];
get_pass_group(10197)->
	[{1,10197}];
get_pass_group(10198)->
	[{1,10198}];
get_pass_group(10199)->
	[{1,10199}];
get_pass_group(10200)->
	[{1,10200}];
get_pass_group(10201)->
	[{1,10201}];
get_pass_group(10202)->
	[{1,10202}];
get_pass_group(10203)->
	[{1,10203}];
get_pass_group(10204)->
	[{1,10204}];
get_pass_group(10205)->
	[{1,10205}];
get_pass_group(10206)->
	[{1,10206}];
get_pass_group(10207)->
	[{1,10207}];
get_pass_group(10208)->
	[{1,10208}];
get_pass_group(10209)->
	[{1,10209}];
get_pass_group(10210)->
	[{1,10210}];
get_pass_group(10211)->
	[{1,10211}];
get_pass_group(10212)->
	[{1,10212}];
get_pass_group(10213)->
	[{1,10213}];
get_pass_group(10214)->
	[{1,10214}];
get_pass_group(10215)->
	[{1,10215}];
get_pass_group(10216)->
	[{1,10216}];
get_pass_group(10217)->
	[{1,10217}];
get_pass_group(10218)->
	[{1,10218}];
get_pass_group(10219)->
	[{1,10219}];
get_pass_group(10220)->
	[{1,10220}];
get_pass_group(10221)->
	[{1,10221}];
get_pass_group(10222)->
	[{1,10222}];
get_pass_group(10223)->
	[{1,10223}];
get_pass_group(10224)->
	[{1,10224}];
get_pass_group(10225)->
	[{1,10225}];
get_pass_group(10226)->
	[{1,10226}];
get_pass_group(10227)->
	[{1,10227}];
get_pass_group(10228)->
	[{1,10228}];
get_pass_group(10229)->
	[{1,10229}];
get_pass_group(10230)->
	[{1,10230}];
get_pass_group(10231)->
	[{1,10231}];
get_pass_group(10232)->
	[{1,10232}];
get_pass_group(10233)->
	[{1,10233}];
get_pass_group(10234)->
	[{1,10234}];
get_pass_group(10235)->
	[{1,10235}];
get_pass_group(10236)->
	[{1,10236}];
get_pass_group(10237)->
	[{1,10237}];
get_pass_group(10238)->
	[{1,10238}];
get_pass_group(10239)->
	[{1,10239}];
get_pass_group(10240)->
	[{1,10240}];
get_pass_group(10241)->
	[{1,10241}];
get_pass_group(10242)->
	[{1,10242}];
get_pass_group(10243)->
	[{1,10243}];
get_pass_group(10244)->
	[{1,10244}];
get_pass_group(10245)->
	[{1,10245}];
get_pass_group(10246)->
	[{1,10246}];
get_pass_group(10247)->
	[{1,10247}];
get_pass_group(10248)->
	[{1,10248}];
get_pass_group(10249)->
	[{1,10249}];
get_pass_group(10250)->
	[{1,10250}];
get_pass_group(10251)->
	[{1,10251}];
get_pass_group(10252)->
	[{1,10252}];
get_pass_group(10253)->
	[{1,10253}];
get_pass_group(10254)->
	[{1,10254}];
get_pass_group(10255)->
	[{1,10255}];
get_pass_group(10256)->
	[{1,10256}];
get_pass_group(10257)->
	[{1,10257}];
get_pass_group(10258)->
	[{1,10258}];
get_pass_group(10259)->
	[{1,10259}];
get_pass_group(10260)->
	[{1,10260}];
get_pass_group(10261)->
	[{1,10261}];
get_pass_group(10262)->
	[{1,10262}];
get_pass_group(10263)->
	[{1,10263}];
get_pass_group(10264)->
	[{1,10264}];
get_pass_group(10265)->
	[{1,10265}];
get_pass_group(10266)->
	[{1,10266}];
get_pass_group(10267)->
	[{1,10267}];
get_pass_group(10268)->
	[{1,10268}];
get_pass_group(10269)->
	[{1,10269}];
get_pass_group(10270)->
	[{1,10270}];
get_pass_group(10271)->
	[{1,10271}];
get_pass_group(10272)->
	[{1,10272}];
get_pass_group(10273)->
	[{1,10273}];
get_pass_group(10274)->
	[{1,10274}];
get_pass_group(10275)->
	[{1,10275}];
get_pass_group(10276)->
	[{1,10276}];
get_pass_group(10277)->
	[{1,10277}];
get_pass_group(10278)->
	[{1,10278}];
get_pass_group(10279)->
	[{1,10279}];
get_pass_group(10280)->
	[{1,10280}];
get_pass_group(10281)->
	[{1,10281}];
get_pass_group(10282)->
	[{1,10282}];
get_pass_group(10283)->
	[{1,10283}];
get_pass_group(10284)->
	[{1,10284}];
get_pass_group(10285)->
	[{1,10285}];
get_pass_group(10286)->
	[{1,10286}];
get_pass_group(10287)->
	[{1,10287}];
get_pass_group(10288)->
	[{1,10288}];
get_pass_group(10289)->
	[{1,10289}];
get_pass_group(10290)->
	[{1,10290}];
get_pass_group(10291)->
	[{1,10291}];
get_pass_group(10292)->
	[{1,10292}];
get_pass_group(10293)->
	[{1,10293}];
get_pass_group(10294)->
	[{1,10294}];
get_pass_group(10295)->
	[{1,10295}];
get_pass_group(10296)->
	[{1,10296}];
get_pass_group(10297)->
	[{1,10297}];
get_pass_group(10298)->
	[{1,10298}];
get_pass_group(10299)->
	[{1,10299}];
get_pass_group(10300)->
	[{1,10300}];
get_pass_group(11001)->
	[{1,11001}];
get_pass_group(11002)->
	[{1,11002}];
get_pass_group(11003)->
	[{1,11003}];
get_pass_group(11004)->
	[{1,11004}];
get_pass_group(11005)->
	[{1,11005}];
get_pass_group(11006)->
	[{1,11006}];
get_pass_group(11007)->
	[{1,11007}];
get_pass_group(11008)->
	[{1,11008}];
get_pass_group(11009)->
	[{1,11009}];
get_pass_group(11010)->
	[{1,11010}];
get_pass_group(11011)->
	[{1,11011}];
get_pass_group(11012)->
	[{1,11012}];
get_pass_group(11013)->
	[{1,11013}];
get_pass_group(11014)->
	[{1,11014}];
get_pass_group(11015)->
	[{1,11015}];
get_pass_group(11016)->
	[{1,11016}];
get_pass_group(11017)->
	[{1,11017}];
get_pass_group(11018)->
	[{1,11018}];
get_pass_group(11019)->
	[{1,11019}];
get_pass_group(11020)->
	[{1,11020}];
get_pass_group(11021)->
	[{1,11021}];
get_pass_group(11022)->
	[{1,11022}];
get_pass_group(11023)->
	[{1,11023}];
get_pass_group(11024)->
	[{1,11024}];
get_pass_group(11025)->
	[{1,11025}];
get_pass_group(11026)->
	[{1,11026}];
get_pass_group(11027)->
	[{1,11027}];
get_pass_group(11028)->
	[{1,11028}];
get_pass_group(11029)->
	[{1,11029}];
get_pass_group(11030)->
	[{1,11030}];
get_pass_group(11031)->
	[{1,11031}];
get_pass_group(11032)->
	[{1,11032}];
get_pass_group(11033)->
	[{1,11033}];
get_pass_group(11034)->
	[{1,11034}];
get_pass_group(11035)->
	[{1,11035}];
get_pass_group(11036)->
	[{1,11036}];
get_pass_group(11037)->
	[{1,11037}];
get_pass_group(11038)->
	[{1,11038}];
get_pass_group(11039)->
	[{1,11039}];
get_pass_group(11040)->
	[{1,11040}];
get_pass_group(11041)->
	[{1,11041}];
get_pass_group(11042)->
	[{1,11042}];
get_pass_group(11043)->
	[{1,11043}];
get_pass_group(11044)->
	[{1,11044}];
get_pass_group(11045)->
	[{1,11045}];
get_pass_group(11046)->
	[{1,11046}];
get_pass_group(11047)->
	[{1,11047}];
get_pass_group(11048)->
	[{1,11048}];
get_pass_group(11049)->
	[{1,11049}];
get_pass_group(11050)->
	[{1,11050}];
get_pass_group(11051)->
	[{1,11051}];
get_pass_group(11052)->
	[{1,11052}];
get_pass_group(11053)->
	[{1,11053}];
get_pass_group(11054)->
	[{1,11054}];
get_pass_group(11055)->
	[{1,11055}];
get_pass_group(11056)->
	[{1,11056}];
get_pass_group(11057)->
	[{1,11057}];
get_pass_group(11058)->
	[{1,11058}];
get_pass_group(11059)->
	[{1,11059}];
get_pass_group(11060)->
	[{1,11060}];
get_pass_group(11061)->
	[{1,11061}];
get_pass_group(11062)->
	[{1,11062}];
get_pass_group(11063)->
	[{1,11063}];
get_pass_group(11064)->
	[{1,11064}];
get_pass_group(11065)->
	[{1,11065}];
get_pass_group(11066)->
	[{1,11066}];
get_pass_group(11067)->
	[{1,11067}];
get_pass_group(11068)->
	[{1,11068}];
get_pass_group(11069)->
	[{1,11069}];
get_pass_group(11070)->
	[{1,11070}];
get_pass_group(11071)->
	[{1,11071}];
get_pass_group(11072)->
	[{1,11072}];
get_pass_group(11073)->
	[{1,11073}];
get_pass_group(11074)->
	[{1,11074}];
get_pass_group(11075)->
	[{1,11075}];
get_pass_group(11076)->
	[{1,11076}];
get_pass_group(11077)->
	[{1,11077}];
get_pass_group(11078)->
	[{1,11078}];
get_pass_group(11079)->
	[{1,11079}];
get_pass_group(11080)->
	[{1,11080}];
get_pass_group(11081)->
	[{1,11081}];
get_pass_group(11082)->
	[{1,11082}];
get_pass_group(11083)->
	[{1,11083}];
get_pass_group(11084)->
	[{1,11084}];
get_pass_group(11085)->
	[{1,11085}];
get_pass_group(11086)->
	[{1,11086}];
get_pass_group(11087)->
	[{1,11087}];
get_pass_group(11088)->
	[{1,11088}];
get_pass_group(11089)->
	[{1,11089}];
get_pass_group(11090)->
	[{1,11090}];
get_pass_group(11091)->
	[{1,11091}];
get_pass_group(11092)->
	[{1,11092}];
get_pass_group(11093)->
	[{1,11093}];
get_pass_group(11094)->
	[{1,11094}];
get_pass_group(11095)->
	[{1,11095}];
get_pass_group(11096)->
	[{1,11096}];
get_pass_group(11097)->
	[{1,11097}];
get_pass_group(11098)->
	[{1,11098}];
get_pass_group(11099)->
	[{1,11099}];
get_pass_group(11100)->
	[{1,11100}];
get_pass_group(11101)->
	[{1,11101}];
get_pass_group(11102)->
	[{1,11102}];
get_pass_group(11103)->
	[{1,11103}];
get_pass_group(11104)->
	[{1,11104}];
get_pass_group(11105)->
	[{1,11105}];
get_pass_group(11106)->
	[{1,11106}];
get_pass_group(11107)->
	[{1,11107}];
get_pass_group(11108)->
	[{1,11108}];
get_pass_group(11109)->
	[{1,11109}];
get_pass_group(11110)->
	[{1,11110}];
get_pass_group(11111)->
	[{1,11111}];
get_pass_group(11112)->
	[{1,11112}];
get_pass_group(11113)->
	[{1,11113}];
get_pass_group(11114)->
	[{1,11114}];
get_pass_group(11115)->
	[{1,11115}];
get_pass_group(11116)->
	[{1,11116}];
get_pass_group(11117)->
	[{1,11117}];
get_pass_group(11118)->
	[{1,11118}];
get_pass_group(11119)->
	[{1,11119}];
get_pass_group(11120)->
	[{1,11120}];
get_pass_group(11121)->
	[{1,11121}];
get_pass_group(11122)->
	[{1,11122}];
get_pass_group(11123)->
	[{1,11123}];
get_pass_group(11124)->
	[{1,11124}];
get_pass_group(11125)->
	[{1,11125}];
get_pass_group(11126)->
	[{1,11126}];
get_pass_group(11127)->
	[{1,11127}];
get_pass_group(11128)->
	[{1,11128}];
get_pass_group(11129)->
	[{1,11129}];
get_pass_group(11130)->
	[{1,11130}];
get_pass_group(11131)->
	[{1,11131}];
get_pass_group(11132)->
	[{1,11132}];
get_pass_group(11133)->
	[{1,11133}];
get_pass_group(11134)->
	[{1,11134}];
get_pass_group(11135)->
	[{1,11135}];
get_pass_group(11136)->
	[{1,11136}];
get_pass_group(11137)->
	[{1,11137}];
get_pass_group(11138)->
	[{1,11138}];
get_pass_group(11139)->
	[{1,11139}];
get_pass_group(11140)->
	[{1,11140}];
get_pass_group(11141)->
	[{1,11141}];
get_pass_group(11142)->
	[{1,11142}];
get_pass_group(11143)->
	[{1,11143}];
get_pass_group(11144)->
	[{1,11144}];
get_pass_group(11145)->
	[{1,11145}];
get_pass_group(11146)->
	[{1,11146}];
get_pass_group(11147)->
	[{1,11147}];
get_pass_group(11148)->
	[{1,11148}];
get_pass_group(11149)->
	[{1,11149}];
get_pass_group(11150)->
	[{1,11150}];
get_pass_group(11151)->
	[{1,11151}];
get_pass_group(11152)->
	[{1,11152}];
get_pass_group(11153)->
	[{1,11153}];
get_pass_group(11154)->
	[{1,11154}];
get_pass_group(11155)->
	[{1,11155}];
get_pass_group(11156)->
	[{1,11156}];
get_pass_group(11157)->
	[{1,11157}];
get_pass_group(11158)->
	[{1,11158}];
get_pass_group(11159)->
	[{1,11159}];
get_pass_group(11160)->
	[{1,11160}];
get_pass_group(11161)->
	[{1,11161}];
get_pass_group(11162)->
	[{1,11162}];
get_pass_group(11163)->
	[{1,11163}];
get_pass_group(11164)->
	[{1,11164}];
get_pass_group(11165)->
	[{1,11165}];
get_pass_group(11166)->
	[{1,11166}];
get_pass_group(11167)->
	[{1,11167}];
get_pass_group(11168)->
	[{1,11168}];
get_pass_group(11169)->
	[{1,11169}];
get_pass_group(11170)->
	[{1,11170}];
get_pass_group(11171)->
	[{1,11171}];
get_pass_group(11172)->
	[{1,11172}];
get_pass_group(11173)->
	[{1,11173}];
get_pass_group(11174)->
	[{1,11174}];
get_pass_group(11175)->
	[{1,11175}];
get_pass_group(11176)->
	[{1,11176}];
get_pass_group(11177)->
	[{1,11177}];
get_pass_group(11178)->
	[{1,11178}];
get_pass_group(11179)->
	[{1,11179}];
get_pass_group(11180)->
	[{1,11180}];
get_pass_group(11181)->
	[{1,11181}];
get_pass_group(11182)->
	[{1,11182}];
get_pass_group(11183)->
	[{1,11183}];
get_pass_group(11184)->
	[{1,11184}];
get_pass_group(11185)->
	[{1,11185}];
get_pass_group(11186)->
	[{1,11186}];
get_pass_group(11187)->
	[{1,11187}];
get_pass_group(11188)->
	[{1,11188}];
get_pass_group(11189)->
	[{1,11189}];
get_pass_group(11190)->
	[{1,11190}];
get_pass_group(11191)->
	[{1,11191}];
get_pass_group(11192)->
	[{1,11192}];
get_pass_group(11193)->
	[{1,11193}];
get_pass_group(11194)->
	[{1,11194}];
get_pass_group(11195)->
	[{1,11195}];
get_pass_group(11196)->
	[{1,11196}];
get_pass_group(11197)->
	[{1,11197}];
get_pass_group(11198)->
	[{1,11198}];
get_pass_group(11199)->
	[{1,11199}];
get_pass_group(11200)->
	[{1,11200}];
get_pass_group(11201)->
	[{1,11201}];
get_pass_group(11202)->
	[{1,11202}];
get_pass_group(11203)->
	[{1,11203}];
get_pass_group(11204)->
	[{1,11204}];
get_pass_group(11205)->
	[{1,11205}];
get_pass_group(11206)->
	[{1,11206}];
get_pass_group(11207)->
	[{1,11207}];
get_pass_group(11208)->
	[{1,11208}];
get_pass_group(11209)->
	[{1,11209}];
get_pass_group(11210)->
	[{1,11210}];
get_pass_group(11211)->
	[{1,11211}];
get_pass_group(11212)->
	[{1,11212}];
get_pass_group(11213)->
	[{1,11213}];
get_pass_group(11214)->
	[{1,11214}];
get_pass_group(11215)->
	[{1,11215}];
get_pass_group(11216)->
	[{1,11216}];
get_pass_group(11217)->
	[{1,11217}];
get_pass_group(11218)->
	[{1,11218}];
get_pass_group(11219)->
	[{1,11219}];
get_pass_group(11220)->
	[{1,11220}];
get_pass_group(11221)->
	[{1,11221}];
get_pass_group(11222)->
	[{1,11222}];
get_pass_group(11223)->
	[{1,11223}];
get_pass_group(11224)->
	[{1,11224}];
get_pass_group(11225)->
	[{1,11225}];
get_pass_group(11226)->
	[{1,11226}];
get_pass_group(11227)->
	[{1,11227}];
get_pass_group(11228)->
	[{1,11228}];
get_pass_group(11229)->
	[{1,11229}];
get_pass_group(11230)->
	[{1,11230}];
get_pass_group(11231)->
	[{1,11231}];
get_pass_group(11232)->
	[{1,11232}];
get_pass_group(11233)->
	[{1,11233}];
get_pass_group(11234)->
	[{1,11234}];
get_pass_group(11235)->
	[{1,11235}];
get_pass_group(11236)->
	[{1,11236}];
get_pass_group(11237)->
	[{1,11237}];
get_pass_group(11238)->
	[{1,11238}];
get_pass_group(11239)->
	[{1,11239}];
get_pass_group(11240)->
	[{1,11240}];
get_pass_group(11241)->
	[{1,11241}];
get_pass_group(11242)->
	[{1,11242}];
get_pass_group(11243)->
	[{1,11243}];
get_pass_group(11244)->
	[{1,11244}];
get_pass_group(11245)->
	[{1,11245}];
get_pass_group(11246)->
	[{1,11246}];
get_pass_group(11247)->
	[{1,11247}];
get_pass_group(11248)->
	[{1,11248}];
get_pass_group(11249)->
	[{1,11249}];
get_pass_group(11250)->
	[{1,11250}];
get_pass_group(11251)->
	[{1,11251}];
get_pass_group(11252)->
	[{1,11252}];
get_pass_group(11253)->
	[{1,11253}];
get_pass_group(11254)->
	[{1,11254}];
get_pass_group(11255)->
	[{1,11255}];
get_pass_group(11256)->
	[{1,11256}];
get_pass_group(11257)->
	[{1,11257}];
get_pass_group(11258)->
	[{1,11258}];
get_pass_group(11259)->
	[{1,11259}];
get_pass_group(11260)->
	[{1,11260}];
get_pass_group(11261)->
	[{1,11261}];
get_pass_group(11262)->
	[{1,11262}];
get_pass_group(11263)->
	[{1,11263}];
get_pass_group(11264)->
	[{1,11264}];
get_pass_group(11265)->
	[{1,11265}];
get_pass_group(11266)->
	[{1,11266}];
get_pass_group(11267)->
	[{1,11267}];
get_pass_group(11268)->
	[{1,11268}];
get_pass_group(11269)->
	[{1,11269}];
get_pass_group(11270)->
	[{1,11270}];
get_pass_group(11271)->
	[{1,11271}];
get_pass_group(11272)->
	[{1,11272}];
get_pass_group(11273)->
	[{1,11273}];
get_pass_group(11274)->
	[{1,11274}];
get_pass_group(11275)->
	[{1,11275}];
get_pass_group(11276)->
	[{1,11276}];
get_pass_group(11277)->
	[{1,11277}];
get_pass_group(11278)->
	[{1,11278}];
get_pass_group(11279)->
	[{1,11279}];
get_pass_group(11280)->
	[{1,11280}];
get_pass_group(11281)->
	[{1,11281}];
get_pass_group(11282)->
	[{1,11282}];
get_pass_group(11283)->
	[{1,11283}];
get_pass_group(11284)->
	[{1,11284}];
get_pass_group(11285)->
	[{1,11285}];
get_pass_group(11286)->
	[{1,11286}];
get_pass_group(11287)->
	[{1,11287}];
get_pass_group(11288)->
	[{1,11288}];
get_pass_group(11289)->
	[{1,11289}];
get_pass_group(11290)->
	[{1,11290}];
get_pass_group(11291)->
	[{1,11291}];
get_pass_group(11292)->
	[{1,11292}];
get_pass_group(11293)->
	[{1,11293}];
get_pass_group(11294)->
	[{1,11294}];
get_pass_group(11295)->
	[{1,11295}];
get_pass_group(11296)->
	[{1,11296}];
get_pass_group(11297)->
	[{1,11297}];
get_pass_group(11298)->
	[{1,11298}];
get_pass_group(11299)->
	[{1,11299}];
get_pass_group(11300)->
	[{1,11300}];

        get_pass_group(_Group) ->
    ?ASSERT(false, [_Group]),
    null.
        
get(5051, ?DIAMOND_BOX) -> 43101;

get(5051, ?GOLD_BOX) -> 43101;

get(5051, ?SILVER_BOX) -> 43101;

get(5051, ?COPPER_BOX) -> 43101;


get(5052, ?DIAMOND_BOX) -> 43102;

get(5052, ?GOLD_BOX) -> 43102;

get(5052, ?SILVER_BOX) -> 43102;

get(5052, ?COPPER_BOX) -> 43102;


get(5053, ?DIAMOND_BOX) -> 43103;

get(5053, ?GOLD_BOX) -> 43103;

get(5053, ?SILVER_BOX) -> 43103;

get(5053, ?COPPER_BOX) -> 43103;


get(5054, ?DIAMOND_BOX) -> 43104;

get(5054, ?GOLD_BOX) -> 43104;

get(5054, ?SILVER_BOX) -> 43104;

get(5054, ?COPPER_BOX) -> 43104;


get(4001, ?DIAMOND_BOX) -> 44101;

get(4001, ?GOLD_BOX) -> 44101;

get(4001, ?SILVER_BOX) -> 44101;

get(4001, ?COPPER_BOX) -> 44101;


get(4002, ?DIAMOND_BOX) -> 44102;

get(4002, ?GOLD_BOX) -> 44102;

get(4002, ?SILVER_BOX) -> 44102;

get(4002, ?COPPER_BOX) -> 44102;


get(4003, ?DIAMOND_BOX) -> 44103;

get(4003, ?GOLD_BOX) -> 44103;

get(4003, ?SILVER_BOX) -> 44103;

get(4003, ?COPPER_BOX) -> 44103;


get(4004, ?DIAMOND_BOX) -> 44104;

get(4004, ?GOLD_BOX) -> 44104;

get(4004, ?SILVER_BOX) -> 44104;

get(4004, ?COPPER_BOX) -> 44104;


get(2031, ?DIAMOND_BOX) -> 300501;

get(2031, ?GOLD_BOX) -> 300501;

get(2031, ?SILVER_BOX) -> 300501;

get(2031, ?COPPER_BOX) -> 300501;


get(2032, ?DIAMOND_BOX) -> 300501;

get(2032, ?GOLD_BOX) -> 300501;

get(2032, ?SILVER_BOX) -> 300501;

get(2032, ?COPPER_BOX) -> 300501;


get(2033, ?DIAMOND_BOX) -> 300501;

get(2033, ?GOLD_BOX) -> 300501;

get(2033, ?SILVER_BOX) -> 300501;

get(2033, ?COPPER_BOX) -> 300501;


get(2034, ?DIAMOND_BOX) -> 300501;

get(2034, ?GOLD_BOX) -> 300501;

get(2034, ?SILVER_BOX) -> 300501;

get(2034, ?COPPER_BOX) -> 300501;


get(5001, ?DIAMOND_BOX) -> 91235;

get(5001, ?GOLD_BOX) -> 91235;

get(5001, ?SILVER_BOX) -> 91235;

get(5001, ?COPPER_BOX) -> 91235;


get(5002, ?DIAMOND_BOX) -> 91236;

get(5002, ?GOLD_BOX) -> 91236;

get(5002, ?SILVER_BOX) -> 91236;

get(5002, ?COPPER_BOX) -> 91236;


get(5003, ?DIAMOND_BOX) -> 91237;

get(5003, ?GOLD_BOX) -> 91237;

get(5003, ?SILVER_BOX) -> 91237;

get(5003, ?COPPER_BOX) -> 91237;


get(5011, ?DIAMOND_BOX) -> 91238;

get(5011, ?GOLD_BOX) -> 91238;

get(5011, ?SILVER_BOX) -> 91238;

get(5011, ?COPPER_BOX) -> 91238;


get(5012, ?DIAMOND_BOX) -> 91239;

get(5012, ?GOLD_BOX) -> 91239;

get(5012, ?SILVER_BOX) -> 91239;

get(5012, ?COPPER_BOX) -> 91239;


get(5013, ?DIAMOND_BOX) -> 91240;

get(5013, ?GOLD_BOX) -> 91240;

get(5013, ?SILVER_BOX) -> 91240;

get(5013, ?COPPER_BOX) -> 91240;


get(5021, ?DIAMOND_BOX) -> 91241;

get(5021, ?GOLD_BOX) -> 91241;

get(5021, ?SILVER_BOX) -> 91241;

get(5021, ?COPPER_BOX) -> 91241;


get(5022, ?DIAMOND_BOX) -> 91242;

get(5022, ?GOLD_BOX) -> 91242;

get(5022, ?SILVER_BOX) -> 91242;

get(5022, ?COPPER_BOX) -> 91242;


get(5023, ?DIAMOND_BOX) -> 91243;

get(5023, ?GOLD_BOX) -> 91243;

get(5023, ?SILVER_BOX) -> 91243;

get(5023, ?COPPER_BOX) -> 91243;


get(5031, ?DIAMOND_BOX) -> 91244;

get(5031, ?GOLD_BOX) -> 91244;

get(5031, ?SILVER_BOX) -> 91244;

get(5031, ?COPPER_BOX) -> 91244;


get(5032, ?DIAMOND_BOX) -> 91245;

get(5032, ?GOLD_BOX) -> 91245;

get(5032, ?SILVER_BOX) -> 91245;

get(5032, ?COPPER_BOX) -> 91245;


get(5033, ?DIAMOND_BOX) -> 91246;

get(5033, ?GOLD_BOX) -> 91246;

get(5033, ?SILVER_BOX) -> 91246;

get(5033, ?COPPER_BOX) -> 91246;


get(5041, ?DIAMOND_BOX) -> 91247;

get(5041, ?GOLD_BOX) -> 91247;

get(5041, ?SILVER_BOX) -> 91247;

get(5041, ?COPPER_BOX) -> 91247;


get(5042, ?DIAMOND_BOX) -> 91248;

get(5042, ?GOLD_BOX) -> 91248;

get(5042, ?SILVER_BOX) -> 91248;

get(5042, ?COPPER_BOX) -> 91248;


get(5043, ?DIAMOND_BOX) -> 91249;

get(5043, ?GOLD_BOX) -> 91249;

get(5043, ?SILVER_BOX) -> 91249;

get(5043, ?COPPER_BOX) -> 91249;


get(2041, ?DIAMOND_BOX) -> 91183;

get(2041, ?GOLD_BOX) -> 91183;

get(2041, ?SILVER_BOX) -> 91183;

get(2041, ?COPPER_BOX) -> 91183;


get(2042, ?DIAMOND_BOX) -> 91185;

get(2042, ?GOLD_BOX) -> 91185;

get(2042, ?SILVER_BOX) -> 91185;

get(2042, ?COPPER_BOX) -> 91185;


get(2043, ?DIAMOND_BOX) -> 91187;

get(2043, ?GOLD_BOX) -> 91187;

get(2043, ?SILVER_BOX) -> 91187;

get(2043, ?COPPER_BOX) -> 91187;


get(2001, ?DIAMOND_BOX) -> 30255;

get(2001, ?GOLD_BOX) -> 30255;

get(2001, ?SILVER_BOX) -> 30255;

get(2001, ?COPPER_BOX) -> 30255;


get(2002, ?DIAMOND_BOX) -> 30257;

get(2002, ?GOLD_BOX) -> 30257;

get(2002, ?SILVER_BOX) -> 30257;

get(2002, ?COPPER_BOX) -> 30257;


get(2003, ?DIAMOND_BOX) -> 30259;

get(2003, ?GOLD_BOX) -> 30259;

get(2003, ?SILVER_BOX) -> 30259;

get(2003, ?COPPER_BOX) -> 30259;


get(2011, ?DIAMOND_BOX) -> 30261;

get(2011, ?GOLD_BOX) -> 30261;

get(2011, ?SILVER_BOX) -> 30261;

get(2011, ?COPPER_BOX) -> 30261;


get(2012, ?DIAMOND_BOX) -> 30263;

get(2012, ?GOLD_BOX) -> 30263;

get(2012, ?SILVER_BOX) -> 30263;

get(2012, ?COPPER_BOX) -> 30263;


get(2013, ?DIAMOND_BOX) -> 30265;

get(2013, ?GOLD_BOX) -> 30265;

get(2013, ?SILVER_BOX) -> 30265;

get(2013, ?COPPER_BOX) -> 30265;


get(2021, ?DIAMOND_BOX) -> 30285;

get(2021, ?GOLD_BOX) -> 30285;

get(2021, ?SILVER_BOX) -> 30285;

get(2021, ?COPPER_BOX) -> 30285;


get(2022, ?DIAMOND_BOX) -> 30287;

get(2022, ?GOLD_BOX) -> 30287;

get(2022, ?SILVER_BOX) -> 30287;

get(2022, ?COPPER_BOX) -> 30287;


get(2023, ?DIAMOND_BOX) -> 30289;

get(2023, ?GOLD_BOX) -> 30289;

get(2023, ?SILVER_BOX) -> 30289;

get(2023, ?COPPER_BOX) -> 30289;


get(4011, ?DIAMOND_BOX) -> 30273;

get(4011, ?GOLD_BOX) -> 30273;

get(4011, ?SILVER_BOX) -> 30273;

get(4011, ?COPPER_BOX) -> 30273;


get(4012, ?DIAMOND_BOX) -> 30275;

get(4012, ?GOLD_BOX) -> 30275;

get(4012, ?SILVER_BOX) -> 30275;

get(4012, ?COPPER_BOX) -> 30275;


get(4013, ?DIAMOND_BOX) -> 30277;

get(4013, ?GOLD_BOX) -> 30277;

get(4013, ?SILVER_BOX) -> 30277;

get(4013, ?COPPER_BOX) -> 30277;


get(4021, ?DIAMOND_BOX) -> 30279;

get(4021, ?GOLD_BOX) -> 30279;

get(4021, ?SILVER_BOX) -> 30279;

get(4021, ?COPPER_BOX) -> 30279;


get(4022, ?DIAMOND_BOX) -> 30281;

get(4022, ?GOLD_BOX) -> 30281;

get(4022, ?SILVER_BOX) -> 30281;

get(4022, ?COPPER_BOX) -> 30281;


get(4023, ?DIAMOND_BOX) -> 30283;

get(4023, ?GOLD_BOX) -> 30283;

get(4023, ?SILVER_BOX) -> 30283;

get(4023, ?COPPER_BOX) -> 30283;


get(110001, ?DIAMOND_BOX) -> 0;

get(110001, ?GOLD_BOX) -> 0;

get(110001, ?SILVER_BOX) -> 0;

get(110001, ?COPPER_BOX) -> 0;


get(110002, ?DIAMOND_BOX) -> 0;

get(110002, ?GOLD_BOX) -> 0;

get(110002, ?SILVER_BOX) -> 0;

get(110002, ?COPPER_BOX) -> 0;


get(120000, ?DIAMOND_BOX) -> 0;

get(120000, ?GOLD_BOX) -> 0;

get(120000, ?SILVER_BOX) -> 0;

get(120000, ?COPPER_BOX) -> 0;


get(120001, ?DIAMOND_BOX) -> 0;

get(120001, ?GOLD_BOX) -> 0;

get(120001, ?SILVER_BOX) -> 0;

get(120001, ?COPPER_BOX) -> 0;


get(300001, ?DIAMOND_BOX) -> 30158;

get(300001, ?GOLD_BOX) -> 30158;

get(300001, ?SILVER_BOX) -> 30158;

get(300001, ?COPPER_BOX) -> 30158;


get(300002, ?DIAMOND_BOX) -> 30160;

get(300002, ?GOLD_BOX) -> 30160;

get(300002, ?SILVER_BOX) -> 30160;

get(300002, ?COPPER_BOX) -> 30160;


get(300003, ?DIAMOND_BOX) -> 30162;

get(300003, ?GOLD_BOX) -> 30162;

get(300003, ?SILVER_BOX) -> 30162;

get(300003, ?COPPER_BOX) -> 30162;


get(120002, ?DIAMOND_BOX) -> 0;

get(120002, ?GOLD_BOX) -> 0;

get(120002, ?SILVER_BOX) -> 0;

get(120002, ?COPPER_BOX) -> 0;


get(120004, ?DIAMOND_BOX) -> 0;

get(120004, ?GOLD_BOX) -> 0;

get(120004, ?SILVER_BOX) -> 0;

get(120004, ?COPPER_BOX) -> 0;


get(120003, ?DIAMOND_BOX) -> 0;

get(120003, ?GOLD_BOX) -> 0;

get(120003, ?SILVER_BOX) -> 0;

get(120003, ?COPPER_BOX) -> 0;


get(4031, ?DIAMOND_BOX) -> 91057;

get(4031, ?GOLD_BOX) -> 91057;

get(4031, ?SILVER_BOX) -> 91057;

get(4031, ?COPPER_BOX) -> 91057;


get(4032, ?DIAMOND_BOX) -> 91059;

get(4032, ?GOLD_BOX) -> 91059;

get(4032, ?SILVER_BOX) -> 91059;

get(4032, ?COPPER_BOX) -> 91059;


get(4033, ?DIAMOND_BOX) -> 91061;

get(4033, ?GOLD_BOX) -> 91061;

get(4033, ?SILVER_BOX) -> 91061;

get(4033, ?COPPER_BOX) -> 91061;


get(4041, ?DIAMOND_BOX) -> 91189;

get(4041, ?GOLD_BOX) -> 91189;

get(4041, ?SILVER_BOX) -> 91189;

get(4041, ?COPPER_BOX) -> 91189;


get(4042, ?DIAMOND_BOX) -> 91191;

get(4042, ?GOLD_BOX) -> 91191;

get(4042, ?SILVER_BOX) -> 91191;

get(4042, ?COPPER_BOX) -> 91191;


get(4043, ?DIAMOND_BOX) -> 91193;

get(4043, ?GOLD_BOX) -> 91193;

get(4043, ?SILVER_BOX) -> 91193;

get(4043, ?COPPER_BOX) -> 91193;


get(200000, ?DIAMOND_BOX) -> 0;

get(200000, ?GOLD_BOX) -> 0;

get(200000, ?SILVER_BOX) -> 0;

get(200000, ?COPPER_BOX) -> 0;


get(200001, ?DIAMOND_BOX) -> 0;

get(200001, ?GOLD_BOX) -> 0;

get(200001, ?SILVER_BOX) -> 0;

get(200001, ?COPPER_BOX) -> 0;


get(200002, ?DIAMOND_BOX) -> 0;

get(200002, ?GOLD_BOX) -> 0;

get(200002, ?SILVER_BOX) -> 0;

get(200002, ?COPPER_BOX) -> 0;


get(200003, ?DIAMOND_BOX) -> 0;

get(200003, ?GOLD_BOX) -> 0;

get(200003, ?SILVER_BOX) -> 0;

get(200003, ?COPPER_BOX) -> 0;


get(200004, ?DIAMOND_BOX) -> 0;

get(200004, ?GOLD_BOX) -> 0;

get(200004, ?SILVER_BOX) -> 0;

get(200004, ?COPPER_BOX) -> 0;


get(200005, ?DIAMOND_BOX) -> 0;

get(200005, ?GOLD_BOX) -> 0;

get(200005, ?SILVER_BOX) -> 0;

get(200005, ?COPPER_BOX) -> 0;


get(200006, ?DIAMOND_BOX) -> 0;

get(200006, ?GOLD_BOX) -> 0;

get(200006, ?SILVER_BOX) -> 0;

get(200006, ?COPPER_BOX) -> 0;


get(10001, ?DIAMOND_BOX) -> 0;

get(10001, ?GOLD_BOX) -> 0;

get(10001, ?SILVER_BOX) -> 0;

get(10001, ?COPPER_BOX) -> 0;


get(10002, ?DIAMOND_BOX) -> 0;

get(10002, ?GOLD_BOX) -> 0;

get(10002, ?SILVER_BOX) -> 0;

get(10002, ?COPPER_BOX) -> 0;


get(10003, ?DIAMOND_BOX) -> 0;

get(10003, ?GOLD_BOX) -> 0;

get(10003, ?SILVER_BOX) -> 0;

get(10003, ?COPPER_BOX) -> 0;


get(10004, ?DIAMOND_BOX) -> 0;

get(10004, ?GOLD_BOX) -> 0;

get(10004, ?SILVER_BOX) -> 0;

get(10004, ?COPPER_BOX) -> 0;


get(10005, ?DIAMOND_BOX) -> 0;

get(10005, ?GOLD_BOX) -> 0;

get(10005, ?SILVER_BOX) -> 0;

get(10005, ?COPPER_BOX) -> 0;


get(10006, ?DIAMOND_BOX) -> 0;

get(10006, ?GOLD_BOX) -> 0;

get(10006, ?SILVER_BOX) -> 0;

get(10006, ?COPPER_BOX) -> 0;


get(10007, ?DIAMOND_BOX) -> 0;

get(10007, ?GOLD_BOX) -> 0;

get(10007, ?SILVER_BOX) -> 0;

get(10007, ?COPPER_BOX) -> 0;


get(10008, ?DIAMOND_BOX) -> 0;

get(10008, ?GOLD_BOX) -> 0;

get(10008, ?SILVER_BOX) -> 0;

get(10008, ?COPPER_BOX) -> 0;


get(10009, ?DIAMOND_BOX) -> 0;

get(10009, ?GOLD_BOX) -> 0;

get(10009, ?SILVER_BOX) -> 0;

get(10009, ?COPPER_BOX) -> 0;


get(10010, ?DIAMOND_BOX) -> 0;

get(10010, ?GOLD_BOX) -> 0;

get(10010, ?SILVER_BOX) -> 0;

get(10010, ?COPPER_BOX) -> 0;


get(10011, ?DIAMOND_BOX) -> 0;

get(10011, ?GOLD_BOX) -> 0;

get(10011, ?SILVER_BOX) -> 0;

get(10011, ?COPPER_BOX) -> 0;


get(10012, ?DIAMOND_BOX) -> 0;

get(10012, ?GOLD_BOX) -> 0;

get(10012, ?SILVER_BOX) -> 0;

get(10012, ?COPPER_BOX) -> 0;


get(10013, ?DIAMOND_BOX) -> 0;

get(10013, ?GOLD_BOX) -> 0;

get(10013, ?SILVER_BOX) -> 0;

get(10013, ?COPPER_BOX) -> 0;


get(10014, ?DIAMOND_BOX) -> 0;

get(10014, ?GOLD_BOX) -> 0;

get(10014, ?SILVER_BOX) -> 0;

get(10014, ?COPPER_BOX) -> 0;


get(10015, ?DIAMOND_BOX) -> 0;

get(10015, ?GOLD_BOX) -> 0;

get(10015, ?SILVER_BOX) -> 0;

get(10015, ?COPPER_BOX) -> 0;


get(10016, ?DIAMOND_BOX) -> 0;

get(10016, ?GOLD_BOX) -> 0;

get(10016, ?SILVER_BOX) -> 0;

get(10016, ?COPPER_BOX) -> 0;


get(10017, ?DIAMOND_BOX) -> 0;

get(10017, ?GOLD_BOX) -> 0;

get(10017, ?SILVER_BOX) -> 0;

get(10017, ?COPPER_BOX) -> 0;


get(10018, ?DIAMOND_BOX) -> 0;

get(10018, ?GOLD_BOX) -> 0;

get(10018, ?SILVER_BOX) -> 0;

get(10018, ?COPPER_BOX) -> 0;


get(10019, ?DIAMOND_BOX) -> 0;

get(10019, ?GOLD_BOX) -> 0;

get(10019, ?SILVER_BOX) -> 0;

get(10019, ?COPPER_BOX) -> 0;


get(10020, ?DIAMOND_BOX) -> 0;

get(10020, ?GOLD_BOX) -> 0;

get(10020, ?SILVER_BOX) -> 0;

get(10020, ?COPPER_BOX) -> 0;


get(10021, ?DIAMOND_BOX) -> 0;

get(10021, ?GOLD_BOX) -> 0;

get(10021, ?SILVER_BOX) -> 0;

get(10021, ?COPPER_BOX) -> 0;


get(10022, ?DIAMOND_BOX) -> 0;

get(10022, ?GOLD_BOX) -> 0;

get(10022, ?SILVER_BOX) -> 0;

get(10022, ?COPPER_BOX) -> 0;


get(10023, ?DIAMOND_BOX) -> 0;

get(10023, ?GOLD_BOX) -> 0;

get(10023, ?SILVER_BOX) -> 0;

get(10023, ?COPPER_BOX) -> 0;


get(10024, ?DIAMOND_BOX) -> 0;

get(10024, ?GOLD_BOX) -> 0;

get(10024, ?SILVER_BOX) -> 0;

get(10024, ?COPPER_BOX) -> 0;


get(10025, ?DIAMOND_BOX) -> 0;

get(10025, ?GOLD_BOX) -> 0;

get(10025, ?SILVER_BOX) -> 0;

get(10025, ?COPPER_BOX) -> 0;


get(10026, ?DIAMOND_BOX) -> 0;

get(10026, ?GOLD_BOX) -> 0;

get(10026, ?SILVER_BOX) -> 0;

get(10026, ?COPPER_BOX) -> 0;


get(10027, ?DIAMOND_BOX) -> 0;

get(10027, ?GOLD_BOX) -> 0;

get(10027, ?SILVER_BOX) -> 0;

get(10027, ?COPPER_BOX) -> 0;


get(10028, ?DIAMOND_BOX) -> 0;

get(10028, ?GOLD_BOX) -> 0;

get(10028, ?SILVER_BOX) -> 0;

get(10028, ?COPPER_BOX) -> 0;


get(10029, ?DIAMOND_BOX) -> 0;

get(10029, ?GOLD_BOX) -> 0;

get(10029, ?SILVER_BOX) -> 0;

get(10029, ?COPPER_BOX) -> 0;


get(10030, ?DIAMOND_BOX) -> 0;

get(10030, ?GOLD_BOX) -> 0;

get(10030, ?SILVER_BOX) -> 0;

get(10030, ?COPPER_BOX) -> 0;


get(10031, ?DIAMOND_BOX) -> 0;

get(10031, ?GOLD_BOX) -> 0;

get(10031, ?SILVER_BOX) -> 0;

get(10031, ?COPPER_BOX) -> 0;


get(10032, ?DIAMOND_BOX) -> 0;

get(10032, ?GOLD_BOX) -> 0;

get(10032, ?SILVER_BOX) -> 0;

get(10032, ?COPPER_BOX) -> 0;


get(10033, ?DIAMOND_BOX) -> 0;

get(10033, ?GOLD_BOX) -> 0;

get(10033, ?SILVER_BOX) -> 0;

get(10033, ?COPPER_BOX) -> 0;


get(10034, ?DIAMOND_BOX) -> 0;

get(10034, ?GOLD_BOX) -> 0;

get(10034, ?SILVER_BOX) -> 0;

get(10034, ?COPPER_BOX) -> 0;


get(10035, ?DIAMOND_BOX) -> 0;

get(10035, ?GOLD_BOX) -> 0;

get(10035, ?SILVER_BOX) -> 0;

get(10035, ?COPPER_BOX) -> 0;


get(10036, ?DIAMOND_BOX) -> 0;

get(10036, ?GOLD_BOX) -> 0;

get(10036, ?SILVER_BOX) -> 0;

get(10036, ?COPPER_BOX) -> 0;


get(10037, ?DIAMOND_BOX) -> 0;

get(10037, ?GOLD_BOX) -> 0;

get(10037, ?SILVER_BOX) -> 0;

get(10037, ?COPPER_BOX) -> 0;


get(10038, ?DIAMOND_BOX) -> 0;

get(10038, ?GOLD_BOX) -> 0;

get(10038, ?SILVER_BOX) -> 0;

get(10038, ?COPPER_BOX) -> 0;


get(10039, ?DIAMOND_BOX) -> 0;

get(10039, ?GOLD_BOX) -> 0;

get(10039, ?SILVER_BOX) -> 0;

get(10039, ?COPPER_BOX) -> 0;


get(10040, ?DIAMOND_BOX) -> 0;

get(10040, ?GOLD_BOX) -> 0;

get(10040, ?SILVER_BOX) -> 0;

get(10040, ?COPPER_BOX) -> 0;


get(10041, ?DIAMOND_BOX) -> 0;

get(10041, ?GOLD_BOX) -> 0;

get(10041, ?SILVER_BOX) -> 0;

get(10041, ?COPPER_BOX) -> 0;


get(10042, ?DIAMOND_BOX) -> 0;

get(10042, ?GOLD_BOX) -> 0;

get(10042, ?SILVER_BOX) -> 0;

get(10042, ?COPPER_BOX) -> 0;


get(10043, ?DIAMOND_BOX) -> 0;

get(10043, ?GOLD_BOX) -> 0;

get(10043, ?SILVER_BOX) -> 0;

get(10043, ?COPPER_BOX) -> 0;


get(10044, ?DIAMOND_BOX) -> 0;

get(10044, ?GOLD_BOX) -> 0;

get(10044, ?SILVER_BOX) -> 0;

get(10044, ?COPPER_BOX) -> 0;


get(10045, ?DIAMOND_BOX) -> 0;

get(10045, ?GOLD_BOX) -> 0;

get(10045, ?SILVER_BOX) -> 0;

get(10045, ?COPPER_BOX) -> 0;


get(10046, ?DIAMOND_BOX) -> 0;

get(10046, ?GOLD_BOX) -> 0;

get(10046, ?SILVER_BOX) -> 0;

get(10046, ?COPPER_BOX) -> 0;


get(10047, ?DIAMOND_BOX) -> 0;

get(10047, ?GOLD_BOX) -> 0;

get(10047, ?SILVER_BOX) -> 0;

get(10047, ?COPPER_BOX) -> 0;


get(10048, ?DIAMOND_BOX) -> 0;

get(10048, ?GOLD_BOX) -> 0;

get(10048, ?SILVER_BOX) -> 0;

get(10048, ?COPPER_BOX) -> 0;


get(10049, ?DIAMOND_BOX) -> 0;

get(10049, ?GOLD_BOX) -> 0;

get(10049, ?SILVER_BOX) -> 0;

get(10049, ?COPPER_BOX) -> 0;


get(10050, ?DIAMOND_BOX) -> 0;

get(10050, ?GOLD_BOX) -> 0;

get(10050, ?SILVER_BOX) -> 0;

get(10050, ?COPPER_BOX) -> 0;


get(10051, ?DIAMOND_BOX) -> 0;

get(10051, ?GOLD_BOX) -> 0;

get(10051, ?SILVER_BOX) -> 0;

get(10051, ?COPPER_BOX) -> 0;


get(10052, ?DIAMOND_BOX) -> 0;

get(10052, ?GOLD_BOX) -> 0;

get(10052, ?SILVER_BOX) -> 0;

get(10052, ?COPPER_BOX) -> 0;


get(10053, ?DIAMOND_BOX) -> 0;

get(10053, ?GOLD_BOX) -> 0;

get(10053, ?SILVER_BOX) -> 0;

get(10053, ?COPPER_BOX) -> 0;


get(10054, ?DIAMOND_BOX) -> 0;

get(10054, ?GOLD_BOX) -> 0;

get(10054, ?SILVER_BOX) -> 0;

get(10054, ?COPPER_BOX) -> 0;


get(10055, ?DIAMOND_BOX) -> 0;

get(10055, ?GOLD_BOX) -> 0;

get(10055, ?SILVER_BOX) -> 0;

get(10055, ?COPPER_BOX) -> 0;


get(10056, ?DIAMOND_BOX) -> 0;

get(10056, ?GOLD_BOX) -> 0;

get(10056, ?SILVER_BOX) -> 0;

get(10056, ?COPPER_BOX) -> 0;


get(10057, ?DIAMOND_BOX) -> 0;

get(10057, ?GOLD_BOX) -> 0;

get(10057, ?SILVER_BOX) -> 0;

get(10057, ?COPPER_BOX) -> 0;


get(10058, ?DIAMOND_BOX) -> 0;

get(10058, ?GOLD_BOX) -> 0;

get(10058, ?SILVER_BOX) -> 0;

get(10058, ?COPPER_BOX) -> 0;


get(10059, ?DIAMOND_BOX) -> 0;

get(10059, ?GOLD_BOX) -> 0;

get(10059, ?SILVER_BOX) -> 0;

get(10059, ?COPPER_BOX) -> 0;


get(10060, ?DIAMOND_BOX) -> 0;

get(10060, ?GOLD_BOX) -> 0;

get(10060, ?SILVER_BOX) -> 0;

get(10060, ?COPPER_BOX) -> 0;


get(10061, ?DIAMOND_BOX) -> 0;

get(10061, ?GOLD_BOX) -> 0;

get(10061, ?SILVER_BOX) -> 0;

get(10061, ?COPPER_BOX) -> 0;


get(10062, ?DIAMOND_BOX) -> 0;

get(10062, ?GOLD_BOX) -> 0;

get(10062, ?SILVER_BOX) -> 0;

get(10062, ?COPPER_BOX) -> 0;


get(10063, ?DIAMOND_BOX) -> 0;

get(10063, ?GOLD_BOX) -> 0;

get(10063, ?SILVER_BOX) -> 0;

get(10063, ?COPPER_BOX) -> 0;


get(10064, ?DIAMOND_BOX) -> 0;

get(10064, ?GOLD_BOX) -> 0;

get(10064, ?SILVER_BOX) -> 0;

get(10064, ?COPPER_BOX) -> 0;


get(10065, ?DIAMOND_BOX) -> 0;

get(10065, ?GOLD_BOX) -> 0;

get(10065, ?SILVER_BOX) -> 0;

get(10065, ?COPPER_BOX) -> 0;


get(10066, ?DIAMOND_BOX) -> 0;

get(10066, ?GOLD_BOX) -> 0;

get(10066, ?SILVER_BOX) -> 0;

get(10066, ?COPPER_BOX) -> 0;


get(10067, ?DIAMOND_BOX) -> 0;

get(10067, ?GOLD_BOX) -> 0;

get(10067, ?SILVER_BOX) -> 0;

get(10067, ?COPPER_BOX) -> 0;


get(10068, ?DIAMOND_BOX) -> 0;

get(10068, ?GOLD_BOX) -> 0;

get(10068, ?SILVER_BOX) -> 0;

get(10068, ?COPPER_BOX) -> 0;


get(10069, ?DIAMOND_BOX) -> 0;

get(10069, ?GOLD_BOX) -> 0;

get(10069, ?SILVER_BOX) -> 0;

get(10069, ?COPPER_BOX) -> 0;


get(10070, ?DIAMOND_BOX) -> 0;

get(10070, ?GOLD_BOX) -> 0;

get(10070, ?SILVER_BOX) -> 0;

get(10070, ?COPPER_BOX) -> 0;


get(10071, ?DIAMOND_BOX) -> 0;

get(10071, ?GOLD_BOX) -> 0;

get(10071, ?SILVER_BOX) -> 0;

get(10071, ?COPPER_BOX) -> 0;


get(10072, ?DIAMOND_BOX) -> 0;

get(10072, ?GOLD_BOX) -> 0;

get(10072, ?SILVER_BOX) -> 0;

get(10072, ?COPPER_BOX) -> 0;


get(10073, ?DIAMOND_BOX) -> 0;

get(10073, ?GOLD_BOX) -> 0;

get(10073, ?SILVER_BOX) -> 0;

get(10073, ?COPPER_BOX) -> 0;


get(10074, ?DIAMOND_BOX) -> 0;

get(10074, ?GOLD_BOX) -> 0;

get(10074, ?SILVER_BOX) -> 0;

get(10074, ?COPPER_BOX) -> 0;


get(10075, ?DIAMOND_BOX) -> 0;

get(10075, ?GOLD_BOX) -> 0;

get(10075, ?SILVER_BOX) -> 0;

get(10075, ?COPPER_BOX) -> 0;


get(10076, ?DIAMOND_BOX) -> 0;

get(10076, ?GOLD_BOX) -> 0;

get(10076, ?SILVER_BOX) -> 0;

get(10076, ?COPPER_BOX) -> 0;


get(10077, ?DIAMOND_BOX) -> 0;

get(10077, ?GOLD_BOX) -> 0;

get(10077, ?SILVER_BOX) -> 0;

get(10077, ?COPPER_BOX) -> 0;


get(10078, ?DIAMOND_BOX) -> 0;

get(10078, ?GOLD_BOX) -> 0;

get(10078, ?SILVER_BOX) -> 0;

get(10078, ?COPPER_BOX) -> 0;


get(10079, ?DIAMOND_BOX) -> 0;

get(10079, ?GOLD_BOX) -> 0;

get(10079, ?SILVER_BOX) -> 0;

get(10079, ?COPPER_BOX) -> 0;


get(10080, ?DIAMOND_BOX) -> 0;

get(10080, ?GOLD_BOX) -> 0;

get(10080, ?SILVER_BOX) -> 0;

get(10080, ?COPPER_BOX) -> 0;


get(10081, ?DIAMOND_BOX) -> 0;

get(10081, ?GOLD_BOX) -> 0;

get(10081, ?SILVER_BOX) -> 0;

get(10081, ?COPPER_BOX) -> 0;


get(10082, ?DIAMOND_BOX) -> 0;

get(10082, ?GOLD_BOX) -> 0;

get(10082, ?SILVER_BOX) -> 0;

get(10082, ?COPPER_BOX) -> 0;


get(10083, ?DIAMOND_BOX) -> 0;

get(10083, ?GOLD_BOX) -> 0;

get(10083, ?SILVER_BOX) -> 0;

get(10083, ?COPPER_BOX) -> 0;


get(10084, ?DIAMOND_BOX) -> 0;

get(10084, ?GOLD_BOX) -> 0;

get(10084, ?SILVER_BOX) -> 0;

get(10084, ?COPPER_BOX) -> 0;


get(10085, ?DIAMOND_BOX) -> 0;

get(10085, ?GOLD_BOX) -> 0;

get(10085, ?SILVER_BOX) -> 0;

get(10085, ?COPPER_BOX) -> 0;


get(10086, ?DIAMOND_BOX) -> 0;

get(10086, ?GOLD_BOX) -> 0;

get(10086, ?SILVER_BOX) -> 0;

get(10086, ?COPPER_BOX) -> 0;


get(10087, ?DIAMOND_BOX) -> 0;

get(10087, ?GOLD_BOX) -> 0;

get(10087, ?SILVER_BOX) -> 0;

get(10087, ?COPPER_BOX) -> 0;


get(10088, ?DIAMOND_BOX) -> 0;

get(10088, ?GOLD_BOX) -> 0;

get(10088, ?SILVER_BOX) -> 0;

get(10088, ?COPPER_BOX) -> 0;


get(10089, ?DIAMOND_BOX) -> 0;

get(10089, ?GOLD_BOX) -> 0;

get(10089, ?SILVER_BOX) -> 0;

get(10089, ?COPPER_BOX) -> 0;


get(10090, ?DIAMOND_BOX) -> 0;

get(10090, ?GOLD_BOX) -> 0;

get(10090, ?SILVER_BOX) -> 0;

get(10090, ?COPPER_BOX) -> 0;


get(10091, ?DIAMOND_BOX) -> 0;

get(10091, ?GOLD_BOX) -> 0;

get(10091, ?SILVER_BOX) -> 0;

get(10091, ?COPPER_BOX) -> 0;


get(10092, ?DIAMOND_BOX) -> 0;

get(10092, ?GOLD_BOX) -> 0;

get(10092, ?SILVER_BOX) -> 0;

get(10092, ?COPPER_BOX) -> 0;


get(10093, ?DIAMOND_BOX) -> 0;

get(10093, ?GOLD_BOX) -> 0;

get(10093, ?SILVER_BOX) -> 0;

get(10093, ?COPPER_BOX) -> 0;


get(10094, ?DIAMOND_BOX) -> 0;

get(10094, ?GOLD_BOX) -> 0;

get(10094, ?SILVER_BOX) -> 0;

get(10094, ?COPPER_BOX) -> 0;


get(10095, ?DIAMOND_BOX) -> 0;

get(10095, ?GOLD_BOX) -> 0;

get(10095, ?SILVER_BOX) -> 0;

get(10095, ?COPPER_BOX) -> 0;


get(10096, ?DIAMOND_BOX) -> 0;

get(10096, ?GOLD_BOX) -> 0;

get(10096, ?SILVER_BOX) -> 0;

get(10096, ?COPPER_BOX) -> 0;


get(10097, ?DIAMOND_BOX) -> 0;

get(10097, ?GOLD_BOX) -> 0;

get(10097, ?SILVER_BOX) -> 0;

get(10097, ?COPPER_BOX) -> 0;


get(10098, ?DIAMOND_BOX) -> 0;

get(10098, ?GOLD_BOX) -> 0;

get(10098, ?SILVER_BOX) -> 0;

get(10098, ?COPPER_BOX) -> 0;


get(10099, ?DIAMOND_BOX) -> 0;

get(10099, ?GOLD_BOX) -> 0;

get(10099, ?SILVER_BOX) -> 0;

get(10099, ?COPPER_BOX) -> 0;


get(10100, ?DIAMOND_BOX) -> 0;

get(10100, ?GOLD_BOX) -> 0;

get(10100, ?SILVER_BOX) -> 0;

get(10100, ?COPPER_BOX) -> 0;


get(10101, ?DIAMOND_BOX) -> 0;

get(10101, ?GOLD_BOX) -> 0;

get(10101, ?SILVER_BOX) -> 0;

get(10101, ?COPPER_BOX) -> 0;


get(10102, ?DIAMOND_BOX) -> 0;

get(10102, ?GOLD_BOX) -> 0;

get(10102, ?SILVER_BOX) -> 0;

get(10102, ?COPPER_BOX) -> 0;


get(10103, ?DIAMOND_BOX) -> 0;

get(10103, ?GOLD_BOX) -> 0;

get(10103, ?SILVER_BOX) -> 0;

get(10103, ?COPPER_BOX) -> 0;


get(10104, ?DIAMOND_BOX) -> 0;

get(10104, ?GOLD_BOX) -> 0;

get(10104, ?SILVER_BOX) -> 0;

get(10104, ?COPPER_BOX) -> 0;


get(10105, ?DIAMOND_BOX) -> 0;

get(10105, ?GOLD_BOX) -> 0;

get(10105, ?SILVER_BOX) -> 0;

get(10105, ?COPPER_BOX) -> 0;


get(10106, ?DIAMOND_BOX) -> 0;

get(10106, ?GOLD_BOX) -> 0;

get(10106, ?SILVER_BOX) -> 0;

get(10106, ?COPPER_BOX) -> 0;


get(10107, ?DIAMOND_BOX) -> 0;

get(10107, ?GOLD_BOX) -> 0;

get(10107, ?SILVER_BOX) -> 0;

get(10107, ?COPPER_BOX) -> 0;


get(10108, ?DIAMOND_BOX) -> 0;

get(10108, ?GOLD_BOX) -> 0;

get(10108, ?SILVER_BOX) -> 0;

get(10108, ?COPPER_BOX) -> 0;


get(10109, ?DIAMOND_BOX) -> 0;

get(10109, ?GOLD_BOX) -> 0;

get(10109, ?SILVER_BOX) -> 0;

get(10109, ?COPPER_BOX) -> 0;


get(10110, ?DIAMOND_BOX) -> 0;

get(10110, ?GOLD_BOX) -> 0;

get(10110, ?SILVER_BOX) -> 0;

get(10110, ?COPPER_BOX) -> 0;


get(10111, ?DIAMOND_BOX) -> 0;

get(10111, ?GOLD_BOX) -> 0;

get(10111, ?SILVER_BOX) -> 0;

get(10111, ?COPPER_BOX) -> 0;


get(10112, ?DIAMOND_BOX) -> 0;

get(10112, ?GOLD_BOX) -> 0;

get(10112, ?SILVER_BOX) -> 0;

get(10112, ?COPPER_BOX) -> 0;


get(10113, ?DIAMOND_BOX) -> 0;

get(10113, ?GOLD_BOX) -> 0;

get(10113, ?SILVER_BOX) -> 0;

get(10113, ?COPPER_BOX) -> 0;


get(10114, ?DIAMOND_BOX) -> 0;

get(10114, ?GOLD_BOX) -> 0;

get(10114, ?SILVER_BOX) -> 0;

get(10114, ?COPPER_BOX) -> 0;


get(10115, ?DIAMOND_BOX) -> 0;

get(10115, ?GOLD_BOX) -> 0;

get(10115, ?SILVER_BOX) -> 0;

get(10115, ?COPPER_BOX) -> 0;


get(10116, ?DIAMOND_BOX) -> 0;

get(10116, ?GOLD_BOX) -> 0;

get(10116, ?SILVER_BOX) -> 0;

get(10116, ?COPPER_BOX) -> 0;


get(10117, ?DIAMOND_BOX) -> 0;

get(10117, ?GOLD_BOX) -> 0;

get(10117, ?SILVER_BOX) -> 0;

get(10117, ?COPPER_BOX) -> 0;


get(10118, ?DIAMOND_BOX) -> 0;

get(10118, ?GOLD_BOX) -> 0;

get(10118, ?SILVER_BOX) -> 0;

get(10118, ?COPPER_BOX) -> 0;


get(10119, ?DIAMOND_BOX) -> 0;

get(10119, ?GOLD_BOX) -> 0;

get(10119, ?SILVER_BOX) -> 0;

get(10119, ?COPPER_BOX) -> 0;


get(10120, ?DIAMOND_BOX) -> 0;

get(10120, ?GOLD_BOX) -> 0;

get(10120, ?SILVER_BOX) -> 0;

get(10120, ?COPPER_BOX) -> 0;


get(10121, ?DIAMOND_BOX) -> 0;

get(10121, ?GOLD_BOX) -> 0;

get(10121, ?SILVER_BOX) -> 0;

get(10121, ?COPPER_BOX) -> 0;


get(10122, ?DIAMOND_BOX) -> 0;

get(10122, ?GOLD_BOX) -> 0;

get(10122, ?SILVER_BOX) -> 0;

get(10122, ?COPPER_BOX) -> 0;


get(10123, ?DIAMOND_BOX) -> 0;

get(10123, ?GOLD_BOX) -> 0;

get(10123, ?SILVER_BOX) -> 0;

get(10123, ?COPPER_BOX) -> 0;


get(10124, ?DIAMOND_BOX) -> 0;

get(10124, ?GOLD_BOX) -> 0;

get(10124, ?SILVER_BOX) -> 0;

get(10124, ?COPPER_BOX) -> 0;


get(10125, ?DIAMOND_BOX) -> 0;

get(10125, ?GOLD_BOX) -> 0;

get(10125, ?SILVER_BOX) -> 0;

get(10125, ?COPPER_BOX) -> 0;


get(10126, ?DIAMOND_BOX) -> 0;

get(10126, ?GOLD_BOX) -> 0;

get(10126, ?SILVER_BOX) -> 0;

get(10126, ?COPPER_BOX) -> 0;


get(10127, ?DIAMOND_BOX) -> 0;

get(10127, ?GOLD_BOX) -> 0;

get(10127, ?SILVER_BOX) -> 0;

get(10127, ?COPPER_BOX) -> 0;


get(10128, ?DIAMOND_BOX) -> 0;

get(10128, ?GOLD_BOX) -> 0;

get(10128, ?SILVER_BOX) -> 0;

get(10128, ?COPPER_BOX) -> 0;


get(10129, ?DIAMOND_BOX) -> 0;

get(10129, ?GOLD_BOX) -> 0;

get(10129, ?SILVER_BOX) -> 0;

get(10129, ?COPPER_BOX) -> 0;


get(10130, ?DIAMOND_BOX) -> 0;

get(10130, ?GOLD_BOX) -> 0;

get(10130, ?SILVER_BOX) -> 0;

get(10130, ?COPPER_BOX) -> 0;


get(10131, ?DIAMOND_BOX) -> 0;

get(10131, ?GOLD_BOX) -> 0;

get(10131, ?SILVER_BOX) -> 0;

get(10131, ?COPPER_BOX) -> 0;


get(10132, ?DIAMOND_BOX) -> 0;

get(10132, ?GOLD_BOX) -> 0;

get(10132, ?SILVER_BOX) -> 0;

get(10132, ?COPPER_BOX) -> 0;


get(10133, ?DIAMOND_BOX) -> 0;

get(10133, ?GOLD_BOX) -> 0;

get(10133, ?SILVER_BOX) -> 0;

get(10133, ?COPPER_BOX) -> 0;


get(10134, ?DIAMOND_BOX) -> 0;

get(10134, ?GOLD_BOX) -> 0;

get(10134, ?SILVER_BOX) -> 0;

get(10134, ?COPPER_BOX) -> 0;


get(10135, ?DIAMOND_BOX) -> 0;

get(10135, ?GOLD_BOX) -> 0;

get(10135, ?SILVER_BOX) -> 0;

get(10135, ?COPPER_BOX) -> 0;


get(10136, ?DIAMOND_BOX) -> 0;

get(10136, ?GOLD_BOX) -> 0;

get(10136, ?SILVER_BOX) -> 0;

get(10136, ?COPPER_BOX) -> 0;


get(10137, ?DIAMOND_BOX) -> 0;

get(10137, ?GOLD_BOX) -> 0;

get(10137, ?SILVER_BOX) -> 0;

get(10137, ?COPPER_BOX) -> 0;


get(10138, ?DIAMOND_BOX) -> 0;

get(10138, ?GOLD_BOX) -> 0;

get(10138, ?SILVER_BOX) -> 0;

get(10138, ?COPPER_BOX) -> 0;


get(10139, ?DIAMOND_BOX) -> 0;

get(10139, ?GOLD_BOX) -> 0;

get(10139, ?SILVER_BOX) -> 0;

get(10139, ?COPPER_BOX) -> 0;


get(10140, ?DIAMOND_BOX) -> 0;

get(10140, ?GOLD_BOX) -> 0;

get(10140, ?SILVER_BOX) -> 0;

get(10140, ?COPPER_BOX) -> 0;


get(10141, ?DIAMOND_BOX) -> 0;

get(10141, ?GOLD_BOX) -> 0;

get(10141, ?SILVER_BOX) -> 0;

get(10141, ?COPPER_BOX) -> 0;


get(10142, ?DIAMOND_BOX) -> 0;

get(10142, ?GOLD_BOX) -> 0;

get(10142, ?SILVER_BOX) -> 0;

get(10142, ?COPPER_BOX) -> 0;


get(10143, ?DIAMOND_BOX) -> 0;

get(10143, ?GOLD_BOX) -> 0;

get(10143, ?SILVER_BOX) -> 0;

get(10143, ?COPPER_BOX) -> 0;


get(10144, ?DIAMOND_BOX) -> 0;

get(10144, ?GOLD_BOX) -> 0;

get(10144, ?SILVER_BOX) -> 0;

get(10144, ?COPPER_BOX) -> 0;


get(10145, ?DIAMOND_BOX) -> 0;

get(10145, ?GOLD_BOX) -> 0;

get(10145, ?SILVER_BOX) -> 0;

get(10145, ?COPPER_BOX) -> 0;


get(10146, ?DIAMOND_BOX) -> 0;

get(10146, ?GOLD_BOX) -> 0;

get(10146, ?SILVER_BOX) -> 0;

get(10146, ?COPPER_BOX) -> 0;


get(10147, ?DIAMOND_BOX) -> 0;

get(10147, ?GOLD_BOX) -> 0;

get(10147, ?SILVER_BOX) -> 0;

get(10147, ?COPPER_BOX) -> 0;


get(10148, ?DIAMOND_BOX) -> 0;

get(10148, ?GOLD_BOX) -> 0;

get(10148, ?SILVER_BOX) -> 0;

get(10148, ?COPPER_BOX) -> 0;


get(10149, ?DIAMOND_BOX) -> 0;

get(10149, ?GOLD_BOX) -> 0;

get(10149, ?SILVER_BOX) -> 0;

get(10149, ?COPPER_BOX) -> 0;


get(10150, ?DIAMOND_BOX) -> 0;

get(10150, ?GOLD_BOX) -> 0;

get(10150, ?SILVER_BOX) -> 0;

get(10150, ?COPPER_BOX) -> 0;


get(10151, ?DIAMOND_BOX) -> 0;

get(10151, ?GOLD_BOX) -> 0;

get(10151, ?SILVER_BOX) -> 0;

get(10151, ?COPPER_BOX) -> 0;


get(10152, ?DIAMOND_BOX) -> 0;

get(10152, ?GOLD_BOX) -> 0;

get(10152, ?SILVER_BOX) -> 0;

get(10152, ?COPPER_BOX) -> 0;


get(10153, ?DIAMOND_BOX) -> 0;

get(10153, ?GOLD_BOX) -> 0;

get(10153, ?SILVER_BOX) -> 0;

get(10153, ?COPPER_BOX) -> 0;


get(10154, ?DIAMOND_BOX) -> 0;

get(10154, ?GOLD_BOX) -> 0;

get(10154, ?SILVER_BOX) -> 0;

get(10154, ?COPPER_BOX) -> 0;


get(10155, ?DIAMOND_BOX) -> 0;

get(10155, ?GOLD_BOX) -> 0;

get(10155, ?SILVER_BOX) -> 0;

get(10155, ?COPPER_BOX) -> 0;


get(10156, ?DIAMOND_BOX) -> 0;

get(10156, ?GOLD_BOX) -> 0;

get(10156, ?SILVER_BOX) -> 0;

get(10156, ?COPPER_BOX) -> 0;


get(10157, ?DIAMOND_BOX) -> 0;

get(10157, ?GOLD_BOX) -> 0;

get(10157, ?SILVER_BOX) -> 0;

get(10157, ?COPPER_BOX) -> 0;


get(10158, ?DIAMOND_BOX) -> 0;

get(10158, ?GOLD_BOX) -> 0;

get(10158, ?SILVER_BOX) -> 0;

get(10158, ?COPPER_BOX) -> 0;


get(10159, ?DIAMOND_BOX) -> 0;

get(10159, ?GOLD_BOX) -> 0;

get(10159, ?SILVER_BOX) -> 0;

get(10159, ?COPPER_BOX) -> 0;


get(10160, ?DIAMOND_BOX) -> 0;

get(10160, ?GOLD_BOX) -> 0;

get(10160, ?SILVER_BOX) -> 0;

get(10160, ?COPPER_BOX) -> 0;


get(10161, ?DIAMOND_BOX) -> 0;

get(10161, ?GOLD_BOX) -> 0;

get(10161, ?SILVER_BOX) -> 0;

get(10161, ?COPPER_BOX) -> 0;


get(10162, ?DIAMOND_BOX) -> 0;

get(10162, ?GOLD_BOX) -> 0;

get(10162, ?SILVER_BOX) -> 0;

get(10162, ?COPPER_BOX) -> 0;


get(10163, ?DIAMOND_BOX) -> 0;

get(10163, ?GOLD_BOX) -> 0;

get(10163, ?SILVER_BOX) -> 0;

get(10163, ?COPPER_BOX) -> 0;


get(10164, ?DIAMOND_BOX) -> 0;

get(10164, ?GOLD_BOX) -> 0;

get(10164, ?SILVER_BOX) -> 0;

get(10164, ?COPPER_BOX) -> 0;


get(10165, ?DIAMOND_BOX) -> 0;

get(10165, ?GOLD_BOX) -> 0;

get(10165, ?SILVER_BOX) -> 0;

get(10165, ?COPPER_BOX) -> 0;


get(10166, ?DIAMOND_BOX) -> 0;

get(10166, ?GOLD_BOX) -> 0;

get(10166, ?SILVER_BOX) -> 0;

get(10166, ?COPPER_BOX) -> 0;


get(10167, ?DIAMOND_BOX) -> 0;

get(10167, ?GOLD_BOX) -> 0;

get(10167, ?SILVER_BOX) -> 0;

get(10167, ?COPPER_BOX) -> 0;


get(10168, ?DIAMOND_BOX) -> 0;

get(10168, ?GOLD_BOX) -> 0;

get(10168, ?SILVER_BOX) -> 0;

get(10168, ?COPPER_BOX) -> 0;


get(10169, ?DIAMOND_BOX) -> 0;

get(10169, ?GOLD_BOX) -> 0;

get(10169, ?SILVER_BOX) -> 0;

get(10169, ?COPPER_BOX) -> 0;


get(10170, ?DIAMOND_BOX) -> 0;

get(10170, ?GOLD_BOX) -> 0;

get(10170, ?SILVER_BOX) -> 0;

get(10170, ?COPPER_BOX) -> 0;


get(10171, ?DIAMOND_BOX) -> 0;

get(10171, ?GOLD_BOX) -> 0;

get(10171, ?SILVER_BOX) -> 0;

get(10171, ?COPPER_BOX) -> 0;


get(10172, ?DIAMOND_BOX) -> 0;

get(10172, ?GOLD_BOX) -> 0;

get(10172, ?SILVER_BOX) -> 0;

get(10172, ?COPPER_BOX) -> 0;


get(10173, ?DIAMOND_BOX) -> 0;

get(10173, ?GOLD_BOX) -> 0;

get(10173, ?SILVER_BOX) -> 0;

get(10173, ?COPPER_BOX) -> 0;


get(10174, ?DIAMOND_BOX) -> 0;

get(10174, ?GOLD_BOX) -> 0;

get(10174, ?SILVER_BOX) -> 0;

get(10174, ?COPPER_BOX) -> 0;


get(10175, ?DIAMOND_BOX) -> 0;

get(10175, ?GOLD_BOX) -> 0;

get(10175, ?SILVER_BOX) -> 0;

get(10175, ?COPPER_BOX) -> 0;


get(10176, ?DIAMOND_BOX) -> 0;

get(10176, ?GOLD_BOX) -> 0;

get(10176, ?SILVER_BOX) -> 0;

get(10176, ?COPPER_BOX) -> 0;


get(10177, ?DIAMOND_BOX) -> 0;

get(10177, ?GOLD_BOX) -> 0;

get(10177, ?SILVER_BOX) -> 0;

get(10177, ?COPPER_BOX) -> 0;


get(10178, ?DIAMOND_BOX) -> 0;

get(10178, ?GOLD_BOX) -> 0;

get(10178, ?SILVER_BOX) -> 0;

get(10178, ?COPPER_BOX) -> 0;


get(10179, ?DIAMOND_BOX) -> 0;

get(10179, ?GOLD_BOX) -> 0;

get(10179, ?SILVER_BOX) -> 0;

get(10179, ?COPPER_BOX) -> 0;


get(10180, ?DIAMOND_BOX) -> 0;

get(10180, ?GOLD_BOX) -> 0;

get(10180, ?SILVER_BOX) -> 0;

get(10180, ?COPPER_BOX) -> 0;


get(10181, ?DIAMOND_BOX) -> 0;

get(10181, ?GOLD_BOX) -> 0;

get(10181, ?SILVER_BOX) -> 0;

get(10181, ?COPPER_BOX) -> 0;


get(10182, ?DIAMOND_BOX) -> 0;

get(10182, ?GOLD_BOX) -> 0;

get(10182, ?SILVER_BOX) -> 0;

get(10182, ?COPPER_BOX) -> 0;


get(10183, ?DIAMOND_BOX) -> 0;

get(10183, ?GOLD_BOX) -> 0;

get(10183, ?SILVER_BOX) -> 0;

get(10183, ?COPPER_BOX) -> 0;


get(10184, ?DIAMOND_BOX) -> 0;

get(10184, ?GOLD_BOX) -> 0;

get(10184, ?SILVER_BOX) -> 0;

get(10184, ?COPPER_BOX) -> 0;


get(10185, ?DIAMOND_BOX) -> 0;

get(10185, ?GOLD_BOX) -> 0;

get(10185, ?SILVER_BOX) -> 0;

get(10185, ?COPPER_BOX) -> 0;


get(10186, ?DIAMOND_BOX) -> 0;

get(10186, ?GOLD_BOX) -> 0;

get(10186, ?SILVER_BOX) -> 0;

get(10186, ?COPPER_BOX) -> 0;


get(10187, ?DIAMOND_BOX) -> 0;

get(10187, ?GOLD_BOX) -> 0;

get(10187, ?SILVER_BOX) -> 0;

get(10187, ?COPPER_BOX) -> 0;


get(10188, ?DIAMOND_BOX) -> 0;

get(10188, ?GOLD_BOX) -> 0;

get(10188, ?SILVER_BOX) -> 0;

get(10188, ?COPPER_BOX) -> 0;


get(10189, ?DIAMOND_BOX) -> 0;

get(10189, ?GOLD_BOX) -> 0;

get(10189, ?SILVER_BOX) -> 0;

get(10189, ?COPPER_BOX) -> 0;


get(10190, ?DIAMOND_BOX) -> 0;

get(10190, ?GOLD_BOX) -> 0;

get(10190, ?SILVER_BOX) -> 0;

get(10190, ?COPPER_BOX) -> 0;


get(10191, ?DIAMOND_BOX) -> 0;

get(10191, ?GOLD_BOX) -> 0;

get(10191, ?SILVER_BOX) -> 0;

get(10191, ?COPPER_BOX) -> 0;


get(10192, ?DIAMOND_BOX) -> 0;

get(10192, ?GOLD_BOX) -> 0;

get(10192, ?SILVER_BOX) -> 0;

get(10192, ?COPPER_BOX) -> 0;


get(10193, ?DIAMOND_BOX) -> 0;

get(10193, ?GOLD_BOX) -> 0;

get(10193, ?SILVER_BOX) -> 0;

get(10193, ?COPPER_BOX) -> 0;


get(10194, ?DIAMOND_BOX) -> 0;

get(10194, ?GOLD_BOX) -> 0;

get(10194, ?SILVER_BOX) -> 0;

get(10194, ?COPPER_BOX) -> 0;


get(10195, ?DIAMOND_BOX) -> 0;

get(10195, ?GOLD_BOX) -> 0;

get(10195, ?SILVER_BOX) -> 0;

get(10195, ?COPPER_BOX) -> 0;


get(10196, ?DIAMOND_BOX) -> 0;

get(10196, ?GOLD_BOX) -> 0;

get(10196, ?SILVER_BOX) -> 0;

get(10196, ?COPPER_BOX) -> 0;


get(10197, ?DIAMOND_BOX) -> 0;

get(10197, ?GOLD_BOX) -> 0;

get(10197, ?SILVER_BOX) -> 0;

get(10197, ?COPPER_BOX) -> 0;


get(10198, ?DIAMOND_BOX) -> 0;

get(10198, ?GOLD_BOX) -> 0;

get(10198, ?SILVER_BOX) -> 0;

get(10198, ?COPPER_BOX) -> 0;


get(10199, ?DIAMOND_BOX) -> 0;

get(10199, ?GOLD_BOX) -> 0;

get(10199, ?SILVER_BOX) -> 0;

get(10199, ?COPPER_BOX) -> 0;


get(10200, ?DIAMOND_BOX) -> 0;

get(10200, ?GOLD_BOX) -> 0;

get(10200, ?SILVER_BOX) -> 0;

get(10200, ?COPPER_BOX) -> 0;


get(10201, ?DIAMOND_BOX) -> 0;

get(10201, ?GOLD_BOX) -> 0;

get(10201, ?SILVER_BOX) -> 0;

get(10201, ?COPPER_BOX) -> 0;


get(10202, ?DIAMOND_BOX) -> 0;

get(10202, ?GOLD_BOX) -> 0;

get(10202, ?SILVER_BOX) -> 0;

get(10202, ?COPPER_BOX) -> 0;


get(10203, ?DIAMOND_BOX) -> 0;

get(10203, ?GOLD_BOX) -> 0;

get(10203, ?SILVER_BOX) -> 0;

get(10203, ?COPPER_BOX) -> 0;


get(10204, ?DIAMOND_BOX) -> 0;

get(10204, ?GOLD_BOX) -> 0;

get(10204, ?SILVER_BOX) -> 0;

get(10204, ?COPPER_BOX) -> 0;


get(10205, ?DIAMOND_BOX) -> 0;

get(10205, ?GOLD_BOX) -> 0;

get(10205, ?SILVER_BOX) -> 0;

get(10205, ?COPPER_BOX) -> 0;


get(10206, ?DIAMOND_BOX) -> 0;

get(10206, ?GOLD_BOX) -> 0;

get(10206, ?SILVER_BOX) -> 0;

get(10206, ?COPPER_BOX) -> 0;


get(10207, ?DIAMOND_BOX) -> 0;

get(10207, ?GOLD_BOX) -> 0;

get(10207, ?SILVER_BOX) -> 0;

get(10207, ?COPPER_BOX) -> 0;


get(10208, ?DIAMOND_BOX) -> 0;

get(10208, ?GOLD_BOX) -> 0;

get(10208, ?SILVER_BOX) -> 0;

get(10208, ?COPPER_BOX) -> 0;


get(10209, ?DIAMOND_BOX) -> 0;

get(10209, ?GOLD_BOX) -> 0;

get(10209, ?SILVER_BOX) -> 0;

get(10209, ?COPPER_BOX) -> 0;


get(10210, ?DIAMOND_BOX) -> 0;

get(10210, ?GOLD_BOX) -> 0;

get(10210, ?SILVER_BOX) -> 0;

get(10210, ?COPPER_BOX) -> 0;


get(10211, ?DIAMOND_BOX) -> 0;

get(10211, ?GOLD_BOX) -> 0;

get(10211, ?SILVER_BOX) -> 0;

get(10211, ?COPPER_BOX) -> 0;


get(10212, ?DIAMOND_BOX) -> 0;

get(10212, ?GOLD_BOX) -> 0;

get(10212, ?SILVER_BOX) -> 0;

get(10212, ?COPPER_BOX) -> 0;


get(10213, ?DIAMOND_BOX) -> 0;

get(10213, ?GOLD_BOX) -> 0;

get(10213, ?SILVER_BOX) -> 0;

get(10213, ?COPPER_BOX) -> 0;


get(10214, ?DIAMOND_BOX) -> 0;

get(10214, ?GOLD_BOX) -> 0;

get(10214, ?SILVER_BOX) -> 0;

get(10214, ?COPPER_BOX) -> 0;


get(10215, ?DIAMOND_BOX) -> 0;

get(10215, ?GOLD_BOX) -> 0;

get(10215, ?SILVER_BOX) -> 0;

get(10215, ?COPPER_BOX) -> 0;


get(10216, ?DIAMOND_BOX) -> 0;

get(10216, ?GOLD_BOX) -> 0;

get(10216, ?SILVER_BOX) -> 0;

get(10216, ?COPPER_BOX) -> 0;


get(10217, ?DIAMOND_BOX) -> 0;

get(10217, ?GOLD_BOX) -> 0;

get(10217, ?SILVER_BOX) -> 0;

get(10217, ?COPPER_BOX) -> 0;


get(10218, ?DIAMOND_BOX) -> 0;

get(10218, ?GOLD_BOX) -> 0;

get(10218, ?SILVER_BOX) -> 0;

get(10218, ?COPPER_BOX) -> 0;


get(10219, ?DIAMOND_BOX) -> 0;

get(10219, ?GOLD_BOX) -> 0;

get(10219, ?SILVER_BOX) -> 0;

get(10219, ?COPPER_BOX) -> 0;


get(10220, ?DIAMOND_BOX) -> 0;

get(10220, ?GOLD_BOX) -> 0;

get(10220, ?SILVER_BOX) -> 0;

get(10220, ?COPPER_BOX) -> 0;


get(10221, ?DIAMOND_BOX) -> 0;

get(10221, ?GOLD_BOX) -> 0;

get(10221, ?SILVER_BOX) -> 0;

get(10221, ?COPPER_BOX) -> 0;


get(10222, ?DIAMOND_BOX) -> 0;

get(10222, ?GOLD_BOX) -> 0;

get(10222, ?SILVER_BOX) -> 0;

get(10222, ?COPPER_BOX) -> 0;


get(10223, ?DIAMOND_BOX) -> 0;

get(10223, ?GOLD_BOX) -> 0;

get(10223, ?SILVER_BOX) -> 0;

get(10223, ?COPPER_BOX) -> 0;


get(10224, ?DIAMOND_BOX) -> 0;

get(10224, ?GOLD_BOX) -> 0;

get(10224, ?SILVER_BOX) -> 0;

get(10224, ?COPPER_BOX) -> 0;


get(10225, ?DIAMOND_BOX) -> 0;

get(10225, ?GOLD_BOX) -> 0;

get(10225, ?SILVER_BOX) -> 0;

get(10225, ?COPPER_BOX) -> 0;


get(10226, ?DIAMOND_BOX) -> 0;

get(10226, ?GOLD_BOX) -> 0;

get(10226, ?SILVER_BOX) -> 0;

get(10226, ?COPPER_BOX) -> 0;


get(10227, ?DIAMOND_BOX) -> 0;

get(10227, ?GOLD_BOX) -> 0;

get(10227, ?SILVER_BOX) -> 0;

get(10227, ?COPPER_BOX) -> 0;


get(10228, ?DIAMOND_BOX) -> 0;

get(10228, ?GOLD_BOX) -> 0;

get(10228, ?SILVER_BOX) -> 0;

get(10228, ?COPPER_BOX) -> 0;


get(10229, ?DIAMOND_BOX) -> 0;

get(10229, ?GOLD_BOX) -> 0;

get(10229, ?SILVER_BOX) -> 0;

get(10229, ?COPPER_BOX) -> 0;


get(10230, ?DIAMOND_BOX) -> 0;

get(10230, ?GOLD_BOX) -> 0;

get(10230, ?SILVER_BOX) -> 0;

get(10230, ?COPPER_BOX) -> 0;


get(10231, ?DIAMOND_BOX) -> 0;

get(10231, ?GOLD_BOX) -> 0;

get(10231, ?SILVER_BOX) -> 0;

get(10231, ?COPPER_BOX) -> 0;


get(10232, ?DIAMOND_BOX) -> 0;

get(10232, ?GOLD_BOX) -> 0;

get(10232, ?SILVER_BOX) -> 0;

get(10232, ?COPPER_BOX) -> 0;


get(10233, ?DIAMOND_BOX) -> 0;

get(10233, ?GOLD_BOX) -> 0;

get(10233, ?SILVER_BOX) -> 0;

get(10233, ?COPPER_BOX) -> 0;


get(10234, ?DIAMOND_BOX) -> 0;

get(10234, ?GOLD_BOX) -> 0;

get(10234, ?SILVER_BOX) -> 0;

get(10234, ?COPPER_BOX) -> 0;


get(10235, ?DIAMOND_BOX) -> 0;

get(10235, ?GOLD_BOX) -> 0;

get(10235, ?SILVER_BOX) -> 0;

get(10235, ?COPPER_BOX) -> 0;


get(10236, ?DIAMOND_BOX) -> 0;

get(10236, ?GOLD_BOX) -> 0;

get(10236, ?SILVER_BOX) -> 0;

get(10236, ?COPPER_BOX) -> 0;


get(10237, ?DIAMOND_BOX) -> 0;

get(10237, ?GOLD_BOX) -> 0;

get(10237, ?SILVER_BOX) -> 0;

get(10237, ?COPPER_BOX) -> 0;


get(10238, ?DIAMOND_BOX) -> 0;

get(10238, ?GOLD_BOX) -> 0;

get(10238, ?SILVER_BOX) -> 0;

get(10238, ?COPPER_BOX) -> 0;


get(10239, ?DIAMOND_BOX) -> 0;

get(10239, ?GOLD_BOX) -> 0;

get(10239, ?SILVER_BOX) -> 0;

get(10239, ?COPPER_BOX) -> 0;


get(10240, ?DIAMOND_BOX) -> 0;

get(10240, ?GOLD_BOX) -> 0;

get(10240, ?SILVER_BOX) -> 0;

get(10240, ?COPPER_BOX) -> 0;


get(10241, ?DIAMOND_BOX) -> 0;

get(10241, ?GOLD_BOX) -> 0;

get(10241, ?SILVER_BOX) -> 0;

get(10241, ?COPPER_BOX) -> 0;


get(10242, ?DIAMOND_BOX) -> 0;

get(10242, ?GOLD_BOX) -> 0;

get(10242, ?SILVER_BOX) -> 0;

get(10242, ?COPPER_BOX) -> 0;


get(10243, ?DIAMOND_BOX) -> 0;

get(10243, ?GOLD_BOX) -> 0;

get(10243, ?SILVER_BOX) -> 0;

get(10243, ?COPPER_BOX) -> 0;


get(10244, ?DIAMOND_BOX) -> 0;

get(10244, ?GOLD_BOX) -> 0;

get(10244, ?SILVER_BOX) -> 0;

get(10244, ?COPPER_BOX) -> 0;


get(10245, ?DIAMOND_BOX) -> 0;

get(10245, ?GOLD_BOX) -> 0;

get(10245, ?SILVER_BOX) -> 0;

get(10245, ?COPPER_BOX) -> 0;


get(10246, ?DIAMOND_BOX) -> 0;

get(10246, ?GOLD_BOX) -> 0;

get(10246, ?SILVER_BOX) -> 0;

get(10246, ?COPPER_BOX) -> 0;


get(10247, ?DIAMOND_BOX) -> 0;

get(10247, ?GOLD_BOX) -> 0;

get(10247, ?SILVER_BOX) -> 0;

get(10247, ?COPPER_BOX) -> 0;


get(10248, ?DIAMOND_BOX) -> 0;

get(10248, ?GOLD_BOX) -> 0;

get(10248, ?SILVER_BOX) -> 0;

get(10248, ?COPPER_BOX) -> 0;


get(10249, ?DIAMOND_BOX) -> 0;

get(10249, ?GOLD_BOX) -> 0;

get(10249, ?SILVER_BOX) -> 0;

get(10249, ?COPPER_BOX) -> 0;


get(10250, ?DIAMOND_BOX) -> 0;

get(10250, ?GOLD_BOX) -> 0;

get(10250, ?SILVER_BOX) -> 0;

get(10250, ?COPPER_BOX) -> 0;


get(10251, ?DIAMOND_BOX) -> 0;

get(10251, ?GOLD_BOX) -> 0;

get(10251, ?SILVER_BOX) -> 0;

get(10251, ?COPPER_BOX) -> 0;


get(10252, ?DIAMOND_BOX) -> 0;

get(10252, ?GOLD_BOX) -> 0;

get(10252, ?SILVER_BOX) -> 0;

get(10252, ?COPPER_BOX) -> 0;


get(10253, ?DIAMOND_BOX) -> 0;

get(10253, ?GOLD_BOX) -> 0;

get(10253, ?SILVER_BOX) -> 0;

get(10253, ?COPPER_BOX) -> 0;


get(10254, ?DIAMOND_BOX) -> 0;

get(10254, ?GOLD_BOX) -> 0;

get(10254, ?SILVER_BOX) -> 0;

get(10254, ?COPPER_BOX) -> 0;


get(10255, ?DIAMOND_BOX) -> 0;

get(10255, ?GOLD_BOX) -> 0;

get(10255, ?SILVER_BOX) -> 0;

get(10255, ?COPPER_BOX) -> 0;


get(10256, ?DIAMOND_BOX) -> 0;

get(10256, ?GOLD_BOX) -> 0;

get(10256, ?SILVER_BOX) -> 0;

get(10256, ?COPPER_BOX) -> 0;


get(10257, ?DIAMOND_BOX) -> 0;

get(10257, ?GOLD_BOX) -> 0;

get(10257, ?SILVER_BOX) -> 0;

get(10257, ?COPPER_BOX) -> 0;


get(10258, ?DIAMOND_BOX) -> 0;

get(10258, ?GOLD_BOX) -> 0;

get(10258, ?SILVER_BOX) -> 0;

get(10258, ?COPPER_BOX) -> 0;


get(10259, ?DIAMOND_BOX) -> 0;

get(10259, ?GOLD_BOX) -> 0;

get(10259, ?SILVER_BOX) -> 0;

get(10259, ?COPPER_BOX) -> 0;


get(10260, ?DIAMOND_BOX) -> 0;

get(10260, ?GOLD_BOX) -> 0;

get(10260, ?SILVER_BOX) -> 0;

get(10260, ?COPPER_BOX) -> 0;


get(10261, ?DIAMOND_BOX) -> 0;

get(10261, ?GOLD_BOX) -> 0;

get(10261, ?SILVER_BOX) -> 0;

get(10261, ?COPPER_BOX) -> 0;


get(10262, ?DIAMOND_BOX) -> 0;

get(10262, ?GOLD_BOX) -> 0;

get(10262, ?SILVER_BOX) -> 0;

get(10262, ?COPPER_BOX) -> 0;


get(10263, ?DIAMOND_BOX) -> 0;

get(10263, ?GOLD_BOX) -> 0;

get(10263, ?SILVER_BOX) -> 0;

get(10263, ?COPPER_BOX) -> 0;


get(10264, ?DIAMOND_BOX) -> 0;

get(10264, ?GOLD_BOX) -> 0;

get(10264, ?SILVER_BOX) -> 0;

get(10264, ?COPPER_BOX) -> 0;


get(10265, ?DIAMOND_BOX) -> 0;

get(10265, ?GOLD_BOX) -> 0;

get(10265, ?SILVER_BOX) -> 0;

get(10265, ?COPPER_BOX) -> 0;


get(10266, ?DIAMOND_BOX) -> 0;

get(10266, ?GOLD_BOX) -> 0;

get(10266, ?SILVER_BOX) -> 0;

get(10266, ?COPPER_BOX) -> 0;


get(10267, ?DIAMOND_BOX) -> 0;

get(10267, ?GOLD_BOX) -> 0;

get(10267, ?SILVER_BOX) -> 0;

get(10267, ?COPPER_BOX) -> 0;


get(10268, ?DIAMOND_BOX) -> 0;

get(10268, ?GOLD_BOX) -> 0;

get(10268, ?SILVER_BOX) -> 0;

get(10268, ?COPPER_BOX) -> 0;


get(10269, ?DIAMOND_BOX) -> 0;

get(10269, ?GOLD_BOX) -> 0;

get(10269, ?SILVER_BOX) -> 0;

get(10269, ?COPPER_BOX) -> 0;


get(10270, ?DIAMOND_BOX) -> 0;

get(10270, ?GOLD_BOX) -> 0;

get(10270, ?SILVER_BOX) -> 0;

get(10270, ?COPPER_BOX) -> 0;


get(10271, ?DIAMOND_BOX) -> 0;

get(10271, ?GOLD_BOX) -> 0;

get(10271, ?SILVER_BOX) -> 0;

get(10271, ?COPPER_BOX) -> 0;


get(10272, ?DIAMOND_BOX) -> 0;

get(10272, ?GOLD_BOX) -> 0;

get(10272, ?SILVER_BOX) -> 0;

get(10272, ?COPPER_BOX) -> 0;


get(10273, ?DIAMOND_BOX) -> 0;

get(10273, ?GOLD_BOX) -> 0;

get(10273, ?SILVER_BOX) -> 0;

get(10273, ?COPPER_BOX) -> 0;


get(10274, ?DIAMOND_BOX) -> 0;

get(10274, ?GOLD_BOX) -> 0;

get(10274, ?SILVER_BOX) -> 0;

get(10274, ?COPPER_BOX) -> 0;


get(10275, ?DIAMOND_BOX) -> 0;

get(10275, ?GOLD_BOX) -> 0;

get(10275, ?SILVER_BOX) -> 0;

get(10275, ?COPPER_BOX) -> 0;


get(10276, ?DIAMOND_BOX) -> 0;

get(10276, ?GOLD_BOX) -> 0;

get(10276, ?SILVER_BOX) -> 0;

get(10276, ?COPPER_BOX) -> 0;


get(10277, ?DIAMOND_BOX) -> 0;

get(10277, ?GOLD_BOX) -> 0;

get(10277, ?SILVER_BOX) -> 0;

get(10277, ?COPPER_BOX) -> 0;


get(10278, ?DIAMOND_BOX) -> 0;

get(10278, ?GOLD_BOX) -> 0;

get(10278, ?SILVER_BOX) -> 0;

get(10278, ?COPPER_BOX) -> 0;


get(10279, ?DIAMOND_BOX) -> 0;

get(10279, ?GOLD_BOX) -> 0;

get(10279, ?SILVER_BOX) -> 0;

get(10279, ?COPPER_BOX) -> 0;


get(10280, ?DIAMOND_BOX) -> 0;

get(10280, ?GOLD_BOX) -> 0;

get(10280, ?SILVER_BOX) -> 0;

get(10280, ?COPPER_BOX) -> 0;


get(10281, ?DIAMOND_BOX) -> 0;

get(10281, ?GOLD_BOX) -> 0;

get(10281, ?SILVER_BOX) -> 0;

get(10281, ?COPPER_BOX) -> 0;


get(10282, ?DIAMOND_BOX) -> 0;

get(10282, ?GOLD_BOX) -> 0;

get(10282, ?SILVER_BOX) -> 0;

get(10282, ?COPPER_BOX) -> 0;


get(10283, ?DIAMOND_BOX) -> 0;

get(10283, ?GOLD_BOX) -> 0;

get(10283, ?SILVER_BOX) -> 0;

get(10283, ?COPPER_BOX) -> 0;


get(10284, ?DIAMOND_BOX) -> 0;

get(10284, ?GOLD_BOX) -> 0;

get(10284, ?SILVER_BOX) -> 0;

get(10284, ?COPPER_BOX) -> 0;


get(10285, ?DIAMOND_BOX) -> 0;

get(10285, ?GOLD_BOX) -> 0;

get(10285, ?SILVER_BOX) -> 0;

get(10285, ?COPPER_BOX) -> 0;


get(10286, ?DIAMOND_BOX) -> 0;

get(10286, ?GOLD_BOX) -> 0;

get(10286, ?SILVER_BOX) -> 0;

get(10286, ?COPPER_BOX) -> 0;


get(10287, ?DIAMOND_BOX) -> 0;

get(10287, ?GOLD_BOX) -> 0;

get(10287, ?SILVER_BOX) -> 0;

get(10287, ?COPPER_BOX) -> 0;


get(10288, ?DIAMOND_BOX) -> 0;

get(10288, ?GOLD_BOX) -> 0;

get(10288, ?SILVER_BOX) -> 0;

get(10288, ?COPPER_BOX) -> 0;


get(10289, ?DIAMOND_BOX) -> 0;

get(10289, ?GOLD_BOX) -> 0;

get(10289, ?SILVER_BOX) -> 0;

get(10289, ?COPPER_BOX) -> 0;


get(10290, ?DIAMOND_BOX) -> 0;

get(10290, ?GOLD_BOX) -> 0;

get(10290, ?SILVER_BOX) -> 0;

get(10290, ?COPPER_BOX) -> 0;


get(10291, ?DIAMOND_BOX) -> 0;

get(10291, ?GOLD_BOX) -> 0;

get(10291, ?SILVER_BOX) -> 0;

get(10291, ?COPPER_BOX) -> 0;


get(10292, ?DIAMOND_BOX) -> 0;

get(10292, ?GOLD_BOX) -> 0;

get(10292, ?SILVER_BOX) -> 0;

get(10292, ?COPPER_BOX) -> 0;


get(10293, ?DIAMOND_BOX) -> 0;

get(10293, ?GOLD_BOX) -> 0;

get(10293, ?SILVER_BOX) -> 0;

get(10293, ?COPPER_BOX) -> 0;


get(10294, ?DIAMOND_BOX) -> 0;

get(10294, ?GOLD_BOX) -> 0;

get(10294, ?SILVER_BOX) -> 0;

get(10294, ?COPPER_BOX) -> 0;


get(10295, ?DIAMOND_BOX) -> 0;

get(10295, ?GOLD_BOX) -> 0;

get(10295, ?SILVER_BOX) -> 0;

get(10295, ?COPPER_BOX) -> 0;


get(10296, ?DIAMOND_BOX) -> 0;

get(10296, ?GOLD_BOX) -> 0;

get(10296, ?SILVER_BOX) -> 0;

get(10296, ?COPPER_BOX) -> 0;


get(10297, ?DIAMOND_BOX) -> 0;

get(10297, ?GOLD_BOX) -> 0;

get(10297, ?SILVER_BOX) -> 0;

get(10297, ?COPPER_BOX) -> 0;


get(10298, ?DIAMOND_BOX) -> 0;

get(10298, ?GOLD_BOX) -> 0;

get(10298, ?SILVER_BOX) -> 0;

get(10298, ?COPPER_BOX) -> 0;


get(10299, ?DIAMOND_BOX) -> 0;

get(10299, ?GOLD_BOX) -> 0;

get(10299, ?SILVER_BOX) -> 0;

get(10299, ?COPPER_BOX) -> 0;


get(10300, ?DIAMOND_BOX) -> 0;

get(10300, ?GOLD_BOX) -> 0;

get(10300, ?SILVER_BOX) -> 0;

get(10300, ?COPPER_BOX) -> 0;


get(11001, ?DIAMOND_BOX) -> 0;

get(11001, ?GOLD_BOX) -> 0;

get(11001, ?SILVER_BOX) -> 0;

get(11001, ?COPPER_BOX) -> 0;


get(11002, ?DIAMOND_BOX) -> 0;

get(11002, ?GOLD_BOX) -> 0;

get(11002, ?SILVER_BOX) -> 0;

get(11002, ?COPPER_BOX) -> 0;


get(11003, ?DIAMOND_BOX) -> 0;

get(11003, ?GOLD_BOX) -> 0;

get(11003, ?SILVER_BOX) -> 0;

get(11003, ?COPPER_BOX) -> 0;


get(11004, ?DIAMOND_BOX) -> 0;

get(11004, ?GOLD_BOX) -> 0;

get(11004, ?SILVER_BOX) -> 0;

get(11004, ?COPPER_BOX) -> 0;


get(11005, ?DIAMOND_BOX) -> 0;

get(11005, ?GOLD_BOX) -> 0;

get(11005, ?SILVER_BOX) -> 0;

get(11005, ?COPPER_BOX) -> 0;


get(11006, ?DIAMOND_BOX) -> 0;

get(11006, ?GOLD_BOX) -> 0;

get(11006, ?SILVER_BOX) -> 0;

get(11006, ?COPPER_BOX) -> 0;


get(11007, ?DIAMOND_BOX) -> 0;

get(11007, ?GOLD_BOX) -> 0;

get(11007, ?SILVER_BOX) -> 0;

get(11007, ?COPPER_BOX) -> 0;


get(11008, ?DIAMOND_BOX) -> 0;

get(11008, ?GOLD_BOX) -> 0;

get(11008, ?SILVER_BOX) -> 0;

get(11008, ?COPPER_BOX) -> 0;


get(11009, ?DIAMOND_BOX) -> 0;

get(11009, ?GOLD_BOX) -> 0;

get(11009, ?SILVER_BOX) -> 0;

get(11009, ?COPPER_BOX) -> 0;


get(11010, ?DIAMOND_BOX) -> 0;

get(11010, ?GOLD_BOX) -> 0;

get(11010, ?SILVER_BOX) -> 0;

get(11010, ?COPPER_BOX) -> 0;


get(11011, ?DIAMOND_BOX) -> 0;

get(11011, ?GOLD_BOX) -> 0;

get(11011, ?SILVER_BOX) -> 0;

get(11011, ?COPPER_BOX) -> 0;


get(11012, ?DIAMOND_BOX) -> 0;

get(11012, ?GOLD_BOX) -> 0;

get(11012, ?SILVER_BOX) -> 0;

get(11012, ?COPPER_BOX) -> 0;


get(11013, ?DIAMOND_BOX) -> 0;

get(11013, ?GOLD_BOX) -> 0;

get(11013, ?SILVER_BOX) -> 0;

get(11013, ?COPPER_BOX) -> 0;


get(11014, ?DIAMOND_BOX) -> 0;

get(11014, ?GOLD_BOX) -> 0;

get(11014, ?SILVER_BOX) -> 0;

get(11014, ?COPPER_BOX) -> 0;


get(11015, ?DIAMOND_BOX) -> 0;

get(11015, ?GOLD_BOX) -> 0;

get(11015, ?SILVER_BOX) -> 0;

get(11015, ?COPPER_BOX) -> 0;


get(11016, ?DIAMOND_BOX) -> 0;

get(11016, ?GOLD_BOX) -> 0;

get(11016, ?SILVER_BOX) -> 0;

get(11016, ?COPPER_BOX) -> 0;


get(11017, ?DIAMOND_BOX) -> 0;

get(11017, ?GOLD_BOX) -> 0;

get(11017, ?SILVER_BOX) -> 0;

get(11017, ?COPPER_BOX) -> 0;


get(11018, ?DIAMOND_BOX) -> 0;

get(11018, ?GOLD_BOX) -> 0;

get(11018, ?SILVER_BOX) -> 0;

get(11018, ?COPPER_BOX) -> 0;


get(11019, ?DIAMOND_BOX) -> 0;

get(11019, ?GOLD_BOX) -> 0;

get(11019, ?SILVER_BOX) -> 0;

get(11019, ?COPPER_BOX) -> 0;


get(11020, ?DIAMOND_BOX) -> 0;

get(11020, ?GOLD_BOX) -> 0;

get(11020, ?SILVER_BOX) -> 0;

get(11020, ?COPPER_BOX) -> 0;


get(11021, ?DIAMOND_BOX) -> 0;

get(11021, ?GOLD_BOX) -> 0;

get(11021, ?SILVER_BOX) -> 0;

get(11021, ?COPPER_BOX) -> 0;


get(11022, ?DIAMOND_BOX) -> 0;

get(11022, ?GOLD_BOX) -> 0;

get(11022, ?SILVER_BOX) -> 0;

get(11022, ?COPPER_BOX) -> 0;


get(11023, ?DIAMOND_BOX) -> 0;

get(11023, ?GOLD_BOX) -> 0;

get(11023, ?SILVER_BOX) -> 0;

get(11023, ?COPPER_BOX) -> 0;


get(11024, ?DIAMOND_BOX) -> 0;

get(11024, ?GOLD_BOX) -> 0;

get(11024, ?SILVER_BOX) -> 0;

get(11024, ?COPPER_BOX) -> 0;


get(11025, ?DIAMOND_BOX) -> 0;

get(11025, ?GOLD_BOX) -> 0;

get(11025, ?SILVER_BOX) -> 0;

get(11025, ?COPPER_BOX) -> 0;


get(11026, ?DIAMOND_BOX) -> 0;

get(11026, ?GOLD_BOX) -> 0;

get(11026, ?SILVER_BOX) -> 0;

get(11026, ?COPPER_BOX) -> 0;


get(11027, ?DIAMOND_BOX) -> 0;

get(11027, ?GOLD_BOX) -> 0;

get(11027, ?SILVER_BOX) -> 0;

get(11027, ?COPPER_BOX) -> 0;


get(11028, ?DIAMOND_BOX) -> 0;

get(11028, ?GOLD_BOX) -> 0;

get(11028, ?SILVER_BOX) -> 0;

get(11028, ?COPPER_BOX) -> 0;


get(11029, ?DIAMOND_BOX) -> 0;

get(11029, ?GOLD_BOX) -> 0;

get(11029, ?SILVER_BOX) -> 0;

get(11029, ?COPPER_BOX) -> 0;


get(11030, ?DIAMOND_BOX) -> 0;

get(11030, ?GOLD_BOX) -> 0;

get(11030, ?SILVER_BOX) -> 0;

get(11030, ?COPPER_BOX) -> 0;


get(11031, ?DIAMOND_BOX) -> 0;

get(11031, ?GOLD_BOX) -> 0;

get(11031, ?SILVER_BOX) -> 0;

get(11031, ?COPPER_BOX) -> 0;


get(11032, ?DIAMOND_BOX) -> 0;

get(11032, ?GOLD_BOX) -> 0;

get(11032, ?SILVER_BOX) -> 0;

get(11032, ?COPPER_BOX) -> 0;


get(11033, ?DIAMOND_BOX) -> 0;

get(11033, ?GOLD_BOX) -> 0;

get(11033, ?SILVER_BOX) -> 0;

get(11033, ?COPPER_BOX) -> 0;


get(11034, ?DIAMOND_BOX) -> 0;

get(11034, ?GOLD_BOX) -> 0;

get(11034, ?SILVER_BOX) -> 0;

get(11034, ?COPPER_BOX) -> 0;


get(11035, ?DIAMOND_BOX) -> 0;

get(11035, ?GOLD_BOX) -> 0;

get(11035, ?SILVER_BOX) -> 0;

get(11035, ?COPPER_BOX) -> 0;


get(11036, ?DIAMOND_BOX) -> 0;

get(11036, ?GOLD_BOX) -> 0;

get(11036, ?SILVER_BOX) -> 0;

get(11036, ?COPPER_BOX) -> 0;


get(11037, ?DIAMOND_BOX) -> 0;

get(11037, ?GOLD_BOX) -> 0;

get(11037, ?SILVER_BOX) -> 0;

get(11037, ?COPPER_BOX) -> 0;


get(11038, ?DIAMOND_BOX) -> 0;

get(11038, ?GOLD_BOX) -> 0;

get(11038, ?SILVER_BOX) -> 0;

get(11038, ?COPPER_BOX) -> 0;


get(11039, ?DIAMOND_BOX) -> 0;

get(11039, ?GOLD_BOX) -> 0;

get(11039, ?SILVER_BOX) -> 0;

get(11039, ?COPPER_BOX) -> 0;


get(11040, ?DIAMOND_BOX) -> 0;

get(11040, ?GOLD_BOX) -> 0;

get(11040, ?SILVER_BOX) -> 0;

get(11040, ?COPPER_BOX) -> 0;


get(11041, ?DIAMOND_BOX) -> 0;

get(11041, ?GOLD_BOX) -> 0;

get(11041, ?SILVER_BOX) -> 0;

get(11041, ?COPPER_BOX) -> 0;


get(11042, ?DIAMOND_BOX) -> 0;

get(11042, ?GOLD_BOX) -> 0;

get(11042, ?SILVER_BOX) -> 0;

get(11042, ?COPPER_BOX) -> 0;


get(11043, ?DIAMOND_BOX) -> 0;

get(11043, ?GOLD_BOX) -> 0;

get(11043, ?SILVER_BOX) -> 0;

get(11043, ?COPPER_BOX) -> 0;


get(11044, ?DIAMOND_BOX) -> 0;

get(11044, ?GOLD_BOX) -> 0;

get(11044, ?SILVER_BOX) -> 0;

get(11044, ?COPPER_BOX) -> 0;


get(11045, ?DIAMOND_BOX) -> 0;

get(11045, ?GOLD_BOX) -> 0;

get(11045, ?SILVER_BOX) -> 0;

get(11045, ?COPPER_BOX) -> 0;


get(11046, ?DIAMOND_BOX) -> 0;

get(11046, ?GOLD_BOX) -> 0;

get(11046, ?SILVER_BOX) -> 0;

get(11046, ?COPPER_BOX) -> 0;


get(11047, ?DIAMOND_BOX) -> 0;

get(11047, ?GOLD_BOX) -> 0;

get(11047, ?SILVER_BOX) -> 0;

get(11047, ?COPPER_BOX) -> 0;


get(11048, ?DIAMOND_BOX) -> 0;

get(11048, ?GOLD_BOX) -> 0;

get(11048, ?SILVER_BOX) -> 0;

get(11048, ?COPPER_BOX) -> 0;


get(11049, ?DIAMOND_BOX) -> 0;

get(11049, ?GOLD_BOX) -> 0;

get(11049, ?SILVER_BOX) -> 0;

get(11049, ?COPPER_BOX) -> 0;


get(11050, ?DIAMOND_BOX) -> 0;

get(11050, ?GOLD_BOX) -> 0;

get(11050, ?SILVER_BOX) -> 0;

get(11050, ?COPPER_BOX) -> 0;


get(11051, ?DIAMOND_BOX) -> 0;

get(11051, ?GOLD_BOX) -> 0;

get(11051, ?SILVER_BOX) -> 0;

get(11051, ?COPPER_BOX) -> 0;


get(11052, ?DIAMOND_BOX) -> 0;

get(11052, ?GOLD_BOX) -> 0;

get(11052, ?SILVER_BOX) -> 0;

get(11052, ?COPPER_BOX) -> 0;


get(11053, ?DIAMOND_BOX) -> 0;

get(11053, ?GOLD_BOX) -> 0;

get(11053, ?SILVER_BOX) -> 0;

get(11053, ?COPPER_BOX) -> 0;


get(11054, ?DIAMOND_BOX) -> 0;

get(11054, ?GOLD_BOX) -> 0;

get(11054, ?SILVER_BOX) -> 0;

get(11054, ?COPPER_BOX) -> 0;


get(11055, ?DIAMOND_BOX) -> 0;

get(11055, ?GOLD_BOX) -> 0;

get(11055, ?SILVER_BOX) -> 0;

get(11055, ?COPPER_BOX) -> 0;


get(11056, ?DIAMOND_BOX) -> 0;

get(11056, ?GOLD_BOX) -> 0;

get(11056, ?SILVER_BOX) -> 0;

get(11056, ?COPPER_BOX) -> 0;


get(11057, ?DIAMOND_BOX) -> 0;

get(11057, ?GOLD_BOX) -> 0;

get(11057, ?SILVER_BOX) -> 0;

get(11057, ?COPPER_BOX) -> 0;


get(11058, ?DIAMOND_BOX) -> 0;

get(11058, ?GOLD_BOX) -> 0;

get(11058, ?SILVER_BOX) -> 0;

get(11058, ?COPPER_BOX) -> 0;


get(11059, ?DIAMOND_BOX) -> 0;

get(11059, ?GOLD_BOX) -> 0;

get(11059, ?SILVER_BOX) -> 0;

get(11059, ?COPPER_BOX) -> 0;


get(11060, ?DIAMOND_BOX) -> 0;

get(11060, ?GOLD_BOX) -> 0;

get(11060, ?SILVER_BOX) -> 0;

get(11060, ?COPPER_BOX) -> 0;


get(11061, ?DIAMOND_BOX) -> 0;

get(11061, ?GOLD_BOX) -> 0;

get(11061, ?SILVER_BOX) -> 0;

get(11061, ?COPPER_BOX) -> 0;


get(11062, ?DIAMOND_BOX) -> 0;

get(11062, ?GOLD_BOX) -> 0;

get(11062, ?SILVER_BOX) -> 0;

get(11062, ?COPPER_BOX) -> 0;


get(11063, ?DIAMOND_BOX) -> 0;

get(11063, ?GOLD_BOX) -> 0;

get(11063, ?SILVER_BOX) -> 0;

get(11063, ?COPPER_BOX) -> 0;


get(11064, ?DIAMOND_BOX) -> 0;

get(11064, ?GOLD_BOX) -> 0;

get(11064, ?SILVER_BOX) -> 0;

get(11064, ?COPPER_BOX) -> 0;


get(11065, ?DIAMOND_BOX) -> 0;

get(11065, ?GOLD_BOX) -> 0;

get(11065, ?SILVER_BOX) -> 0;

get(11065, ?COPPER_BOX) -> 0;


get(11066, ?DIAMOND_BOX) -> 0;

get(11066, ?GOLD_BOX) -> 0;

get(11066, ?SILVER_BOX) -> 0;

get(11066, ?COPPER_BOX) -> 0;


get(11067, ?DIAMOND_BOX) -> 0;

get(11067, ?GOLD_BOX) -> 0;

get(11067, ?SILVER_BOX) -> 0;

get(11067, ?COPPER_BOX) -> 0;


get(11068, ?DIAMOND_BOX) -> 0;

get(11068, ?GOLD_BOX) -> 0;

get(11068, ?SILVER_BOX) -> 0;

get(11068, ?COPPER_BOX) -> 0;


get(11069, ?DIAMOND_BOX) -> 0;

get(11069, ?GOLD_BOX) -> 0;

get(11069, ?SILVER_BOX) -> 0;

get(11069, ?COPPER_BOX) -> 0;


get(11070, ?DIAMOND_BOX) -> 0;

get(11070, ?GOLD_BOX) -> 0;

get(11070, ?SILVER_BOX) -> 0;

get(11070, ?COPPER_BOX) -> 0;


get(11071, ?DIAMOND_BOX) -> 0;

get(11071, ?GOLD_BOX) -> 0;

get(11071, ?SILVER_BOX) -> 0;

get(11071, ?COPPER_BOX) -> 0;


get(11072, ?DIAMOND_BOX) -> 0;

get(11072, ?GOLD_BOX) -> 0;

get(11072, ?SILVER_BOX) -> 0;

get(11072, ?COPPER_BOX) -> 0;


get(11073, ?DIAMOND_BOX) -> 0;

get(11073, ?GOLD_BOX) -> 0;

get(11073, ?SILVER_BOX) -> 0;

get(11073, ?COPPER_BOX) -> 0;


get(11074, ?DIAMOND_BOX) -> 0;

get(11074, ?GOLD_BOX) -> 0;

get(11074, ?SILVER_BOX) -> 0;

get(11074, ?COPPER_BOX) -> 0;


get(11075, ?DIAMOND_BOX) -> 0;

get(11075, ?GOLD_BOX) -> 0;

get(11075, ?SILVER_BOX) -> 0;

get(11075, ?COPPER_BOX) -> 0;


get(11076, ?DIAMOND_BOX) -> 0;

get(11076, ?GOLD_BOX) -> 0;

get(11076, ?SILVER_BOX) -> 0;

get(11076, ?COPPER_BOX) -> 0;


get(11077, ?DIAMOND_BOX) -> 0;

get(11077, ?GOLD_BOX) -> 0;

get(11077, ?SILVER_BOX) -> 0;

get(11077, ?COPPER_BOX) -> 0;


get(11078, ?DIAMOND_BOX) -> 0;

get(11078, ?GOLD_BOX) -> 0;

get(11078, ?SILVER_BOX) -> 0;

get(11078, ?COPPER_BOX) -> 0;


get(11079, ?DIAMOND_BOX) -> 0;

get(11079, ?GOLD_BOX) -> 0;

get(11079, ?SILVER_BOX) -> 0;

get(11079, ?COPPER_BOX) -> 0;


get(11080, ?DIAMOND_BOX) -> 0;

get(11080, ?GOLD_BOX) -> 0;

get(11080, ?SILVER_BOX) -> 0;

get(11080, ?COPPER_BOX) -> 0;


get(11081, ?DIAMOND_BOX) -> 0;

get(11081, ?GOLD_BOX) -> 0;

get(11081, ?SILVER_BOX) -> 0;

get(11081, ?COPPER_BOX) -> 0;


get(11082, ?DIAMOND_BOX) -> 0;

get(11082, ?GOLD_BOX) -> 0;

get(11082, ?SILVER_BOX) -> 0;

get(11082, ?COPPER_BOX) -> 0;


get(11083, ?DIAMOND_BOX) -> 0;

get(11083, ?GOLD_BOX) -> 0;

get(11083, ?SILVER_BOX) -> 0;

get(11083, ?COPPER_BOX) -> 0;


get(11084, ?DIAMOND_BOX) -> 0;

get(11084, ?GOLD_BOX) -> 0;

get(11084, ?SILVER_BOX) -> 0;

get(11084, ?COPPER_BOX) -> 0;


get(11085, ?DIAMOND_BOX) -> 0;

get(11085, ?GOLD_BOX) -> 0;

get(11085, ?SILVER_BOX) -> 0;

get(11085, ?COPPER_BOX) -> 0;


get(11086, ?DIAMOND_BOX) -> 0;

get(11086, ?GOLD_BOX) -> 0;

get(11086, ?SILVER_BOX) -> 0;

get(11086, ?COPPER_BOX) -> 0;


get(11087, ?DIAMOND_BOX) -> 0;

get(11087, ?GOLD_BOX) -> 0;

get(11087, ?SILVER_BOX) -> 0;

get(11087, ?COPPER_BOX) -> 0;


get(11088, ?DIAMOND_BOX) -> 0;

get(11088, ?GOLD_BOX) -> 0;

get(11088, ?SILVER_BOX) -> 0;

get(11088, ?COPPER_BOX) -> 0;


get(11089, ?DIAMOND_BOX) -> 0;

get(11089, ?GOLD_BOX) -> 0;

get(11089, ?SILVER_BOX) -> 0;

get(11089, ?COPPER_BOX) -> 0;


get(11090, ?DIAMOND_BOX) -> 0;

get(11090, ?GOLD_BOX) -> 0;

get(11090, ?SILVER_BOX) -> 0;

get(11090, ?COPPER_BOX) -> 0;


get(11091, ?DIAMOND_BOX) -> 0;

get(11091, ?GOLD_BOX) -> 0;

get(11091, ?SILVER_BOX) -> 0;

get(11091, ?COPPER_BOX) -> 0;


get(11092, ?DIAMOND_BOX) -> 0;

get(11092, ?GOLD_BOX) -> 0;

get(11092, ?SILVER_BOX) -> 0;

get(11092, ?COPPER_BOX) -> 0;


get(11093, ?DIAMOND_BOX) -> 0;

get(11093, ?GOLD_BOX) -> 0;

get(11093, ?SILVER_BOX) -> 0;

get(11093, ?COPPER_BOX) -> 0;


get(11094, ?DIAMOND_BOX) -> 0;

get(11094, ?GOLD_BOX) -> 0;

get(11094, ?SILVER_BOX) -> 0;

get(11094, ?COPPER_BOX) -> 0;


get(11095, ?DIAMOND_BOX) -> 0;

get(11095, ?GOLD_BOX) -> 0;

get(11095, ?SILVER_BOX) -> 0;

get(11095, ?COPPER_BOX) -> 0;


get(11096, ?DIAMOND_BOX) -> 0;

get(11096, ?GOLD_BOX) -> 0;

get(11096, ?SILVER_BOX) -> 0;

get(11096, ?COPPER_BOX) -> 0;


get(11097, ?DIAMOND_BOX) -> 0;

get(11097, ?GOLD_BOX) -> 0;

get(11097, ?SILVER_BOX) -> 0;

get(11097, ?COPPER_BOX) -> 0;


get(11098, ?DIAMOND_BOX) -> 0;

get(11098, ?GOLD_BOX) -> 0;

get(11098, ?SILVER_BOX) -> 0;

get(11098, ?COPPER_BOX) -> 0;


get(11099, ?DIAMOND_BOX) -> 0;

get(11099, ?GOLD_BOX) -> 0;

get(11099, ?SILVER_BOX) -> 0;

get(11099, ?COPPER_BOX) -> 0;


get(11100, ?DIAMOND_BOX) -> 0;

get(11100, ?GOLD_BOX) -> 0;

get(11100, ?SILVER_BOX) -> 0;

get(11100, ?COPPER_BOX) -> 0;


get(11101, ?DIAMOND_BOX) -> 0;

get(11101, ?GOLD_BOX) -> 0;

get(11101, ?SILVER_BOX) -> 0;

get(11101, ?COPPER_BOX) -> 0;


get(11102, ?DIAMOND_BOX) -> 0;

get(11102, ?GOLD_BOX) -> 0;

get(11102, ?SILVER_BOX) -> 0;

get(11102, ?COPPER_BOX) -> 0;


get(11103, ?DIAMOND_BOX) -> 0;

get(11103, ?GOLD_BOX) -> 0;

get(11103, ?SILVER_BOX) -> 0;

get(11103, ?COPPER_BOX) -> 0;


get(11104, ?DIAMOND_BOX) -> 0;

get(11104, ?GOLD_BOX) -> 0;

get(11104, ?SILVER_BOX) -> 0;

get(11104, ?COPPER_BOX) -> 0;


get(11105, ?DIAMOND_BOX) -> 0;

get(11105, ?GOLD_BOX) -> 0;

get(11105, ?SILVER_BOX) -> 0;

get(11105, ?COPPER_BOX) -> 0;


get(11106, ?DIAMOND_BOX) -> 0;

get(11106, ?GOLD_BOX) -> 0;

get(11106, ?SILVER_BOX) -> 0;

get(11106, ?COPPER_BOX) -> 0;


get(11107, ?DIAMOND_BOX) -> 0;

get(11107, ?GOLD_BOX) -> 0;

get(11107, ?SILVER_BOX) -> 0;

get(11107, ?COPPER_BOX) -> 0;


get(11108, ?DIAMOND_BOX) -> 0;

get(11108, ?GOLD_BOX) -> 0;

get(11108, ?SILVER_BOX) -> 0;

get(11108, ?COPPER_BOX) -> 0;


get(11109, ?DIAMOND_BOX) -> 0;

get(11109, ?GOLD_BOX) -> 0;

get(11109, ?SILVER_BOX) -> 0;

get(11109, ?COPPER_BOX) -> 0;


get(11110, ?DIAMOND_BOX) -> 0;

get(11110, ?GOLD_BOX) -> 0;

get(11110, ?SILVER_BOX) -> 0;

get(11110, ?COPPER_BOX) -> 0;


get(11111, ?DIAMOND_BOX) -> 0;

get(11111, ?GOLD_BOX) -> 0;

get(11111, ?SILVER_BOX) -> 0;

get(11111, ?COPPER_BOX) -> 0;


get(11112, ?DIAMOND_BOX) -> 0;

get(11112, ?GOLD_BOX) -> 0;

get(11112, ?SILVER_BOX) -> 0;

get(11112, ?COPPER_BOX) -> 0;


get(11113, ?DIAMOND_BOX) -> 0;

get(11113, ?GOLD_BOX) -> 0;

get(11113, ?SILVER_BOX) -> 0;

get(11113, ?COPPER_BOX) -> 0;


get(11114, ?DIAMOND_BOX) -> 0;

get(11114, ?GOLD_BOX) -> 0;

get(11114, ?SILVER_BOX) -> 0;

get(11114, ?COPPER_BOX) -> 0;


get(11115, ?DIAMOND_BOX) -> 0;

get(11115, ?GOLD_BOX) -> 0;

get(11115, ?SILVER_BOX) -> 0;

get(11115, ?COPPER_BOX) -> 0;


get(11116, ?DIAMOND_BOX) -> 0;

get(11116, ?GOLD_BOX) -> 0;

get(11116, ?SILVER_BOX) -> 0;

get(11116, ?COPPER_BOX) -> 0;


get(11117, ?DIAMOND_BOX) -> 0;

get(11117, ?GOLD_BOX) -> 0;

get(11117, ?SILVER_BOX) -> 0;

get(11117, ?COPPER_BOX) -> 0;


get(11118, ?DIAMOND_BOX) -> 0;

get(11118, ?GOLD_BOX) -> 0;

get(11118, ?SILVER_BOX) -> 0;

get(11118, ?COPPER_BOX) -> 0;


get(11119, ?DIAMOND_BOX) -> 0;

get(11119, ?GOLD_BOX) -> 0;

get(11119, ?SILVER_BOX) -> 0;

get(11119, ?COPPER_BOX) -> 0;


get(11120, ?DIAMOND_BOX) -> 0;

get(11120, ?GOLD_BOX) -> 0;

get(11120, ?SILVER_BOX) -> 0;

get(11120, ?COPPER_BOX) -> 0;


get(11121, ?DIAMOND_BOX) -> 0;

get(11121, ?GOLD_BOX) -> 0;

get(11121, ?SILVER_BOX) -> 0;

get(11121, ?COPPER_BOX) -> 0;


get(11122, ?DIAMOND_BOX) -> 0;

get(11122, ?GOLD_BOX) -> 0;

get(11122, ?SILVER_BOX) -> 0;

get(11122, ?COPPER_BOX) -> 0;


get(11123, ?DIAMOND_BOX) -> 0;

get(11123, ?GOLD_BOX) -> 0;

get(11123, ?SILVER_BOX) -> 0;

get(11123, ?COPPER_BOX) -> 0;


get(11124, ?DIAMOND_BOX) -> 0;

get(11124, ?GOLD_BOX) -> 0;

get(11124, ?SILVER_BOX) -> 0;

get(11124, ?COPPER_BOX) -> 0;


get(11125, ?DIAMOND_BOX) -> 0;

get(11125, ?GOLD_BOX) -> 0;

get(11125, ?SILVER_BOX) -> 0;

get(11125, ?COPPER_BOX) -> 0;


get(11126, ?DIAMOND_BOX) -> 0;

get(11126, ?GOLD_BOX) -> 0;

get(11126, ?SILVER_BOX) -> 0;

get(11126, ?COPPER_BOX) -> 0;


get(11127, ?DIAMOND_BOX) -> 0;

get(11127, ?GOLD_BOX) -> 0;

get(11127, ?SILVER_BOX) -> 0;

get(11127, ?COPPER_BOX) -> 0;


get(11128, ?DIAMOND_BOX) -> 0;

get(11128, ?GOLD_BOX) -> 0;

get(11128, ?SILVER_BOX) -> 0;

get(11128, ?COPPER_BOX) -> 0;


get(11129, ?DIAMOND_BOX) -> 0;

get(11129, ?GOLD_BOX) -> 0;

get(11129, ?SILVER_BOX) -> 0;

get(11129, ?COPPER_BOX) -> 0;


get(11130, ?DIAMOND_BOX) -> 0;

get(11130, ?GOLD_BOX) -> 0;

get(11130, ?SILVER_BOX) -> 0;

get(11130, ?COPPER_BOX) -> 0;


get(11131, ?DIAMOND_BOX) -> 0;

get(11131, ?GOLD_BOX) -> 0;

get(11131, ?SILVER_BOX) -> 0;

get(11131, ?COPPER_BOX) -> 0;


get(11132, ?DIAMOND_BOX) -> 0;

get(11132, ?GOLD_BOX) -> 0;

get(11132, ?SILVER_BOX) -> 0;

get(11132, ?COPPER_BOX) -> 0;


get(11133, ?DIAMOND_BOX) -> 0;

get(11133, ?GOLD_BOX) -> 0;

get(11133, ?SILVER_BOX) -> 0;

get(11133, ?COPPER_BOX) -> 0;


get(11134, ?DIAMOND_BOX) -> 0;

get(11134, ?GOLD_BOX) -> 0;

get(11134, ?SILVER_BOX) -> 0;

get(11134, ?COPPER_BOX) -> 0;


get(11135, ?DIAMOND_BOX) -> 0;

get(11135, ?GOLD_BOX) -> 0;

get(11135, ?SILVER_BOX) -> 0;

get(11135, ?COPPER_BOX) -> 0;


get(11136, ?DIAMOND_BOX) -> 0;

get(11136, ?GOLD_BOX) -> 0;

get(11136, ?SILVER_BOX) -> 0;

get(11136, ?COPPER_BOX) -> 0;


get(11137, ?DIAMOND_BOX) -> 0;

get(11137, ?GOLD_BOX) -> 0;

get(11137, ?SILVER_BOX) -> 0;

get(11137, ?COPPER_BOX) -> 0;


get(11138, ?DIAMOND_BOX) -> 0;

get(11138, ?GOLD_BOX) -> 0;

get(11138, ?SILVER_BOX) -> 0;

get(11138, ?COPPER_BOX) -> 0;


get(11139, ?DIAMOND_BOX) -> 0;

get(11139, ?GOLD_BOX) -> 0;

get(11139, ?SILVER_BOX) -> 0;

get(11139, ?COPPER_BOX) -> 0;


get(11140, ?DIAMOND_BOX) -> 0;

get(11140, ?GOLD_BOX) -> 0;

get(11140, ?SILVER_BOX) -> 0;

get(11140, ?COPPER_BOX) -> 0;


get(11141, ?DIAMOND_BOX) -> 0;

get(11141, ?GOLD_BOX) -> 0;

get(11141, ?SILVER_BOX) -> 0;

get(11141, ?COPPER_BOX) -> 0;


get(11142, ?DIAMOND_BOX) -> 0;

get(11142, ?GOLD_BOX) -> 0;

get(11142, ?SILVER_BOX) -> 0;

get(11142, ?COPPER_BOX) -> 0;


get(11143, ?DIAMOND_BOX) -> 0;

get(11143, ?GOLD_BOX) -> 0;

get(11143, ?SILVER_BOX) -> 0;

get(11143, ?COPPER_BOX) -> 0;


get(11144, ?DIAMOND_BOX) -> 0;

get(11144, ?GOLD_BOX) -> 0;

get(11144, ?SILVER_BOX) -> 0;

get(11144, ?COPPER_BOX) -> 0;


get(11145, ?DIAMOND_BOX) -> 0;

get(11145, ?GOLD_BOX) -> 0;

get(11145, ?SILVER_BOX) -> 0;

get(11145, ?COPPER_BOX) -> 0;


get(11146, ?DIAMOND_BOX) -> 0;

get(11146, ?GOLD_BOX) -> 0;

get(11146, ?SILVER_BOX) -> 0;

get(11146, ?COPPER_BOX) -> 0;


get(11147, ?DIAMOND_BOX) -> 0;

get(11147, ?GOLD_BOX) -> 0;

get(11147, ?SILVER_BOX) -> 0;

get(11147, ?COPPER_BOX) -> 0;


get(11148, ?DIAMOND_BOX) -> 0;

get(11148, ?GOLD_BOX) -> 0;

get(11148, ?SILVER_BOX) -> 0;

get(11148, ?COPPER_BOX) -> 0;


get(11149, ?DIAMOND_BOX) -> 0;

get(11149, ?GOLD_BOX) -> 0;

get(11149, ?SILVER_BOX) -> 0;

get(11149, ?COPPER_BOX) -> 0;


get(11150, ?DIAMOND_BOX) -> 0;

get(11150, ?GOLD_BOX) -> 0;

get(11150, ?SILVER_BOX) -> 0;

get(11150, ?COPPER_BOX) -> 0;


get(11151, ?DIAMOND_BOX) -> 0;

get(11151, ?GOLD_BOX) -> 0;

get(11151, ?SILVER_BOX) -> 0;

get(11151, ?COPPER_BOX) -> 0;


get(11152, ?DIAMOND_BOX) -> 0;

get(11152, ?GOLD_BOX) -> 0;

get(11152, ?SILVER_BOX) -> 0;

get(11152, ?COPPER_BOX) -> 0;


get(11153, ?DIAMOND_BOX) -> 0;

get(11153, ?GOLD_BOX) -> 0;

get(11153, ?SILVER_BOX) -> 0;

get(11153, ?COPPER_BOX) -> 0;


get(11154, ?DIAMOND_BOX) -> 0;

get(11154, ?GOLD_BOX) -> 0;

get(11154, ?SILVER_BOX) -> 0;

get(11154, ?COPPER_BOX) -> 0;


get(11155, ?DIAMOND_BOX) -> 0;

get(11155, ?GOLD_BOX) -> 0;

get(11155, ?SILVER_BOX) -> 0;

get(11155, ?COPPER_BOX) -> 0;


get(11156, ?DIAMOND_BOX) -> 0;

get(11156, ?GOLD_BOX) -> 0;

get(11156, ?SILVER_BOX) -> 0;

get(11156, ?COPPER_BOX) -> 0;


get(11157, ?DIAMOND_BOX) -> 0;

get(11157, ?GOLD_BOX) -> 0;

get(11157, ?SILVER_BOX) -> 0;

get(11157, ?COPPER_BOX) -> 0;


get(11158, ?DIAMOND_BOX) -> 0;

get(11158, ?GOLD_BOX) -> 0;

get(11158, ?SILVER_BOX) -> 0;

get(11158, ?COPPER_BOX) -> 0;


get(11159, ?DIAMOND_BOX) -> 0;

get(11159, ?GOLD_BOX) -> 0;

get(11159, ?SILVER_BOX) -> 0;

get(11159, ?COPPER_BOX) -> 0;


get(11160, ?DIAMOND_BOX) -> 0;

get(11160, ?GOLD_BOX) -> 0;

get(11160, ?SILVER_BOX) -> 0;

get(11160, ?COPPER_BOX) -> 0;


get(11161, ?DIAMOND_BOX) -> 0;

get(11161, ?GOLD_BOX) -> 0;

get(11161, ?SILVER_BOX) -> 0;

get(11161, ?COPPER_BOX) -> 0;


get(11162, ?DIAMOND_BOX) -> 0;

get(11162, ?GOLD_BOX) -> 0;

get(11162, ?SILVER_BOX) -> 0;

get(11162, ?COPPER_BOX) -> 0;


get(11163, ?DIAMOND_BOX) -> 0;

get(11163, ?GOLD_BOX) -> 0;

get(11163, ?SILVER_BOX) -> 0;

get(11163, ?COPPER_BOX) -> 0;


get(11164, ?DIAMOND_BOX) -> 0;

get(11164, ?GOLD_BOX) -> 0;

get(11164, ?SILVER_BOX) -> 0;

get(11164, ?COPPER_BOX) -> 0;


get(11165, ?DIAMOND_BOX) -> 0;

get(11165, ?GOLD_BOX) -> 0;

get(11165, ?SILVER_BOX) -> 0;

get(11165, ?COPPER_BOX) -> 0;


get(11166, ?DIAMOND_BOX) -> 0;

get(11166, ?GOLD_BOX) -> 0;

get(11166, ?SILVER_BOX) -> 0;

get(11166, ?COPPER_BOX) -> 0;


get(11167, ?DIAMOND_BOX) -> 0;

get(11167, ?GOLD_BOX) -> 0;

get(11167, ?SILVER_BOX) -> 0;

get(11167, ?COPPER_BOX) -> 0;


get(11168, ?DIAMOND_BOX) -> 0;

get(11168, ?GOLD_BOX) -> 0;

get(11168, ?SILVER_BOX) -> 0;

get(11168, ?COPPER_BOX) -> 0;


get(11169, ?DIAMOND_BOX) -> 0;

get(11169, ?GOLD_BOX) -> 0;

get(11169, ?SILVER_BOX) -> 0;

get(11169, ?COPPER_BOX) -> 0;


get(11170, ?DIAMOND_BOX) -> 0;

get(11170, ?GOLD_BOX) -> 0;

get(11170, ?SILVER_BOX) -> 0;

get(11170, ?COPPER_BOX) -> 0;


get(11171, ?DIAMOND_BOX) -> 0;

get(11171, ?GOLD_BOX) -> 0;

get(11171, ?SILVER_BOX) -> 0;

get(11171, ?COPPER_BOX) -> 0;


get(11172, ?DIAMOND_BOX) -> 0;

get(11172, ?GOLD_BOX) -> 0;

get(11172, ?SILVER_BOX) -> 0;

get(11172, ?COPPER_BOX) -> 0;


get(11173, ?DIAMOND_BOX) -> 0;

get(11173, ?GOLD_BOX) -> 0;

get(11173, ?SILVER_BOX) -> 0;

get(11173, ?COPPER_BOX) -> 0;


get(11174, ?DIAMOND_BOX) -> 0;

get(11174, ?GOLD_BOX) -> 0;

get(11174, ?SILVER_BOX) -> 0;

get(11174, ?COPPER_BOX) -> 0;


get(11175, ?DIAMOND_BOX) -> 0;

get(11175, ?GOLD_BOX) -> 0;

get(11175, ?SILVER_BOX) -> 0;

get(11175, ?COPPER_BOX) -> 0;


get(11176, ?DIAMOND_BOX) -> 0;

get(11176, ?GOLD_BOX) -> 0;

get(11176, ?SILVER_BOX) -> 0;

get(11176, ?COPPER_BOX) -> 0;


get(11177, ?DIAMOND_BOX) -> 0;

get(11177, ?GOLD_BOX) -> 0;

get(11177, ?SILVER_BOX) -> 0;

get(11177, ?COPPER_BOX) -> 0;


get(11178, ?DIAMOND_BOX) -> 0;

get(11178, ?GOLD_BOX) -> 0;

get(11178, ?SILVER_BOX) -> 0;

get(11178, ?COPPER_BOX) -> 0;


get(11179, ?DIAMOND_BOX) -> 0;

get(11179, ?GOLD_BOX) -> 0;

get(11179, ?SILVER_BOX) -> 0;

get(11179, ?COPPER_BOX) -> 0;


get(11180, ?DIAMOND_BOX) -> 0;

get(11180, ?GOLD_BOX) -> 0;

get(11180, ?SILVER_BOX) -> 0;

get(11180, ?COPPER_BOX) -> 0;


get(11181, ?DIAMOND_BOX) -> 0;

get(11181, ?GOLD_BOX) -> 0;

get(11181, ?SILVER_BOX) -> 0;

get(11181, ?COPPER_BOX) -> 0;


get(11182, ?DIAMOND_BOX) -> 0;

get(11182, ?GOLD_BOX) -> 0;

get(11182, ?SILVER_BOX) -> 0;

get(11182, ?COPPER_BOX) -> 0;


get(11183, ?DIAMOND_BOX) -> 0;

get(11183, ?GOLD_BOX) -> 0;

get(11183, ?SILVER_BOX) -> 0;

get(11183, ?COPPER_BOX) -> 0;


get(11184, ?DIAMOND_BOX) -> 0;

get(11184, ?GOLD_BOX) -> 0;

get(11184, ?SILVER_BOX) -> 0;

get(11184, ?COPPER_BOX) -> 0;


get(11185, ?DIAMOND_BOX) -> 0;

get(11185, ?GOLD_BOX) -> 0;

get(11185, ?SILVER_BOX) -> 0;

get(11185, ?COPPER_BOX) -> 0;


get(11186, ?DIAMOND_BOX) -> 0;

get(11186, ?GOLD_BOX) -> 0;

get(11186, ?SILVER_BOX) -> 0;

get(11186, ?COPPER_BOX) -> 0;


get(11187, ?DIAMOND_BOX) -> 0;

get(11187, ?GOLD_BOX) -> 0;

get(11187, ?SILVER_BOX) -> 0;

get(11187, ?COPPER_BOX) -> 0;


get(11188, ?DIAMOND_BOX) -> 0;

get(11188, ?GOLD_BOX) -> 0;

get(11188, ?SILVER_BOX) -> 0;

get(11188, ?COPPER_BOX) -> 0;


get(11189, ?DIAMOND_BOX) -> 0;

get(11189, ?GOLD_BOX) -> 0;

get(11189, ?SILVER_BOX) -> 0;

get(11189, ?COPPER_BOX) -> 0;


get(11190, ?DIAMOND_BOX) -> 0;

get(11190, ?GOLD_BOX) -> 0;

get(11190, ?SILVER_BOX) -> 0;

get(11190, ?COPPER_BOX) -> 0;


get(11191, ?DIAMOND_BOX) -> 0;

get(11191, ?GOLD_BOX) -> 0;

get(11191, ?SILVER_BOX) -> 0;

get(11191, ?COPPER_BOX) -> 0;


get(11192, ?DIAMOND_BOX) -> 0;

get(11192, ?GOLD_BOX) -> 0;

get(11192, ?SILVER_BOX) -> 0;

get(11192, ?COPPER_BOX) -> 0;


get(11193, ?DIAMOND_BOX) -> 0;

get(11193, ?GOLD_BOX) -> 0;

get(11193, ?SILVER_BOX) -> 0;

get(11193, ?COPPER_BOX) -> 0;


get(11194, ?DIAMOND_BOX) -> 0;

get(11194, ?GOLD_BOX) -> 0;

get(11194, ?SILVER_BOX) -> 0;

get(11194, ?COPPER_BOX) -> 0;


get(11195, ?DIAMOND_BOX) -> 0;

get(11195, ?GOLD_BOX) -> 0;

get(11195, ?SILVER_BOX) -> 0;

get(11195, ?COPPER_BOX) -> 0;


get(11196, ?DIAMOND_BOX) -> 0;

get(11196, ?GOLD_BOX) -> 0;

get(11196, ?SILVER_BOX) -> 0;

get(11196, ?COPPER_BOX) -> 0;


get(11197, ?DIAMOND_BOX) -> 0;

get(11197, ?GOLD_BOX) -> 0;

get(11197, ?SILVER_BOX) -> 0;

get(11197, ?COPPER_BOX) -> 0;


get(11198, ?DIAMOND_BOX) -> 0;

get(11198, ?GOLD_BOX) -> 0;

get(11198, ?SILVER_BOX) -> 0;

get(11198, ?COPPER_BOX) -> 0;


get(11199, ?DIAMOND_BOX) -> 0;

get(11199, ?GOLD_BOX) -> 0;

get(11199, ?SILVER_BOX) -> 0;

get(11199, ?COPPER_BOX) -> 0;


get(11200, ?DIAMOND_BOX) -> 0;

get(11200, ?GOLD_BOX) -> 0;

get(11200, ?SILVER_BOX) -> 0;

get(11200, ?COPPER_BOX) -> 0;


get(11201, ?DIAMOND_BOX) -> 0;

get(11201, ?GOLD_BOX) -> 0;

get(11201, ?SILVER_BOX) -> 0;

get(11201, ?COPPER_BOX) -> 0;


get(11202, ?DIAMOND_BOX) -> 0;

get(11202, ?GOLD_BOX) -> 0;

get(11202, ?SILVER_BOX) -> 0;

get(11202, ?COPPER_BOX) -> 0;


get(11203, ?DIAMOND_BOX) -> 0;

get(11203, ?GOLD_BOX) -> 0;

get(11203, ?SILVER_BOX) -> 0;

get(11203, ?COPPER_BOX) -> 0;


get(11204, ?DIAMOND_BOX) -> 0;

get(11204, ?GOLD_BOX) -> 0;

get(11204, ?SILVER_BOX) -> 0;

get(11204, ?COPPER_BOX) -> 0;


get(11205, ?DIAMOND_BOX) -> 0;

get(11205, ?GOLD_BOX) -> 0;

get(11205, ?SILVER_BOX) -> 0;

get(11205, ?COPPER_BOX) -> 0;


get(11206, ?DIAMOND_BOX) -> 0;

get(11206, ?GOLD_BOX) -> 0;

get(11206, ?SILVER_BOX) -> 0;

get(11206, ?COPPER_BOX) -> 0;


get(11207, ?DIAMOND_BOX) -> 0;

get(11207, ?GOLD_BOX) -> 0;

get(11207, ?SILVER_BOX) -> 0;

get(11207, ?COPPER_BOX) -> 0;


get(11208, ?DIAMOND_BOX) -> 0;

get(11208, ?GOLD_BOX) -> 0;

get(11208, ?SILVER_BOX) -> 0;

get(11208, ?COPPER_BOX) -> 0;


get(11209, ?DIAMOND_BOX) -> 0;

get(11209, ?GOLD_BOX) -> 0;

get(11209, ?SILVER_BOX) -> 0;

get(11209, ?COPPER_BOX) -> 0;


get(11210, ?DIAMOND_BOX) -> 0;

get(11210, ?GOLD_BOX) -> 0;

get(11210, ?SILVER_BOX) -> 0;

get(11210, ?COPPER_BOX) -> 0;


get(11211, ?DIAMOND_BOX) -> 0;

get(11211, ?GOLD_BOX) -> 0;

get(11211, ?SILVER_BOX) -> 0;

get(11211, ?COPPER_BOX) -> 0;


get(11212, ?DIAMOND_BOX) -> 0;

get(11212, ?GOLD_BOX) -> 0;

get(11212, ?SILVER_BOX) -> 0;

get(11212, ?COPPER_BOX) -> 0;


get(11213, ?DIAMOND_BOX) -> 0;

get(11213, ?GOLD_BOX) -> 0;

get(11213, ?SILVER_BOX) -> 0;

get(11213, ?COPPER_BOX) -> 0;


get(11214, ?DIAMOND_BOX) -> 0;

get(11214, ?GOLD_BOX) -> 0;

get(11214, ?SILVER_BOX) -> 0;

get(11214, ?COPPER_BOX) -> 0;


get(11215, ?DIAMOND_BOX) -> 0;

get(11215, ?GOLD_BOX) -> 0;

get(11215, ?SILVER_BOX) -> 0;

get(11215, ?COPPER_BOX) -> 0;


get(11216, ?DIAMOND_BOX) -> 0;

get(11216, ?GOLD_BOX) -> 0;

get(11216, ?SILVER_BOX) -> 0;

get(11216, ?COPPER_BOX) -> 0;


get(11217, ?DIAMOND_BOX) -> 0;

get(11217, ?GOLD_BOX) -> 0;

get(11217, ?SILVER_BOX) -> 0;

get(11217, ?COPPER_BOX) -> 0;


get(11218, ?DIAMOND_BOX) -> 0;

get(11218, ?GOLD_BOX) -> 0;

get(11218, ?SILVER_BOX) -> 0;

get(11218, ?COPPER_BOX) -> 0;


get(11219, ?DIAMOND_BOX) -> 0;

get(11219, ?GOLD_BOX) -> 0;

get(11219, ?SILVER_BOX) -> 0;

get(11219, ?COPPER_BOX) -> 0;


get(11220, ?DIAMOND_BOX) -> 0;

get(11220, ?GOLD_BOX) -> 0;

get(11220, ?SILVER_BOX) -> 0;

get(11220, ?COPPER_BOX) -> 0;


get(11221, ?DIAMOND_BOX) -> 0;

get(11221, ?GOLD_BOX) -> 0;

get(11221, ?SILVER_BOX) -> 0;

get(11221, ?COPPER_BOX) -> 0;


get(11222, ?DIAMOND_BOX) -> 0;

get(11222, ?GOLD_BOX) -> 0;

get(11222, ?SILVER_BOX) -> 0;

get(11222, ?COPPER_BOX) -> 0;


get(11223, ?DIAMOND_BOX) -> 0;

get(11223, ?GOLD_BOX) -> 0;

get(11223, ?SILVER_BOX) -> 0;

get(11223, ?COPPER_BOX) -> 0;


get(11224, ?DIAMOND_BOX) -> 0;

get(11224, ?GOLD_BOX) -> 0;

get(11224, ?SILVER_BOX) -> 0;

get(11224, ?COPPER_BOX) -> 0;


get(11225, ?DIAMOND_BOX) -> 0;

get(11225, ?GOLD_BOX) -> 0;

get(11225, ?SILVER_BOX) -> 0;

get(11225, ?COPPER_BOX) -> 0;


get(11226, ?DIAMOND_BOX) -> 0;

get(11226, ?GOLD_BOX) -> 0;

get(11226, ?SILVER_BOX) -> 0;

get(11226, ?COPPER_BOX) -> 0;


get(11227, ?DIAMOND_BOX) -> 0;

get(11227, ?GOLD_BOX) -> 0;

get(11227, ?SILVER_BOX) -> 0;

get(11227, ?COPPER_BOX) -> 0;


get(11228, ?DIAMOND_BOX) -> 0;

get(11228, ?GOLD_BOX) -> 0;

get(11228, ?SILVER_BOX) -> 0;

get(11228, ?COPPER_BOX) -> 0;


get(11229, ?DIAMOND_BOX) -> 0;

get(11229, ?GOLD_BOX) -> 0;

get(11229, ?SILVER_BOX) -> 0;

get(11229, ?COPPER_BOX) -> 0;


get(11230, ?DIAMOND_BOX) -> 0;

get(11230, ?GOLD_BOX) -> 0;

get(11230, ?SILVER_BOX) -> 0;

get(11230, ?COPPER_BOX) -> 0;


get(11231, ?DIAMOND_BOX) -> 0;

get(11231, ?GOLD_BOX) -> 0;

get(11231, ?SILVER_BOX) -> 0;

get(11231, ?COPPER_BOX) -> 0;


get(11232, ?DIAMOND_BOX) -> 0;

get(11232, ?GOLD_BOX) -> 0;

get(11232, ?SILVER_BOX) -> 0;

get(11232, ?COPPER_BOX) -> 0;


get(11233, ?DIAMOND_BOX) -> 0;

get(11233, ?GOLD_BOX) -> 0;

get(11233, ?SILVER_BOX) -> 0;

get(11233, ?COPPER_BOX) -> 0;


get(11234, ?DIAMOND_BOX) -> 0;

get(11234, ?GOLD_BOX) -> 0;

get(11234, ?SILVER_BOX) -> 0;

get(11234, ?COPPER_BOX) -> 0;


get(11235, ?DIAMOND_BOX) -> 0;

get(11235, ?GOLD_BOX) -> 0;

get(11235, ?SILVER_BOX) -> 0;

get(11235, ?COPPER_BOX) -> 0;


get(11236, ?DIAMOND_BOX) -> 0;

get(11236, ?GOLD_BOX) -> 0;

get(11236, ?SILVER_BOX) -> 0;

get(11236, ?COPPER_BOX) -> 0;


get(11237, ?DIAMOND_BOX) -> 0;

get(11237, ?GOLD_BOX) -> 0;

get(11237, ?SILVER_BOX) -> 0;

get(11237, ?COPPER_BOX) -> 0;


get(11238, ?DIAMOND_BOX) -> 0;

get(11238, ?GOLD_BOX) -> 0;

get(11238, ?SILVER_BOX) -> 0;

get(11238, ?COPPER_BOX) -> 0;


get(11239, ?DIAMOND_BOX) -> 0;

get(11239, ?GOLD_BOX) -> 0;

get(11239, ?SILVER_BOX) -> 0;

get(11239, ?COPPER_BOX) -> 0;


get(11240, ?DIAMOND_BOX) -> 0;

get(11240, ?GOLD_BOX) -> 0;

get(11240, ?SILVER_BOX) -> 0;

get(11240, ?COPPER_BOX) -> 0;


get(11241, ?DIAMOND_BOX) -> 0;

get(11241, ?GOLD_BOX) -> 0;

get(11241, ?SILVER_BOX) -> 0;

get(11241, ?COPPER_BOX) -> 0;


get(11242, ?DIAMOND_BOX) -> 0;

get(11242, ?GOLD_BOX) -> 0;

get(11242, ?SILVER_BOX) -> 0;

get(11242, ?COPPER_BOX) -> 0;


get(11243, ?DIAMOND_BOX) -> 0;

get(11243, ?GOLD_BOX) -> 0;

get(11243, ?SILVER_BOX) -> 0;

get(11243, ?COPPER_BOX) -> 0;


get(11244, ?DIAMOND_BOX) -> 0;

get(11244, ?GOLD_BOX) -> 0;

get(11244, ?SILVER_BOX) -> 0;

get(11244, ?COPPER_BOX) -> 0;


get(11245, ?DIAMOND_BOX) -> 0;

get(11245, ?GOLD_BOX) -> 0;

get(11245, ?SILVER_BOX) -> 0;

get(11245, ?COPPER_BOX) -> 0;


get(11246, ?DIAMOND_BOX) -> 0;

get(11246, ?GOLD_BOX) -> 0;

get(11246, ?SILVER_BOX) -> 0;

get(11246, ?COPPER_BOX) -> 0;


get(11247, ?DIAMOND_BOX) -> 0;

get(11247, ?GOLD_BOX) -> 0;

get(11247, ?SILVER_BOX) -> 0;

get(11247, ?COPPER_BOX) -> 0;


get(11248, ?DIAMOND_BOX) -> 0;

get(11248, ?GOLD_BOX) -> 0;

get(11248, ?SILVER_BOX) -> 0;

get(11248, ?COPPER_BOX) -> 0;


get(11249, ?DIAMOND_BOX) -> 0;

get(11249, ?GOLD_BOX) -> 0;

get(11249, ?SILVER_BOX) -> 0;

get(11249, ?COPPER_BOX) -> 0;


get(11250, ?DIAMOND_BOX) -> 0;

get(11250, ?GOLD_BOX) -> 0;

get(11250, ?SILVER_BOX) -> 0;

get(11250, ?COPPER_BOX) -> 0;


get(11251, ?DIAMOND_BOX) -> 0;

get(11251, ?GOLD_BOX) -> 0;

get(11251, ?SILVER_BOX) -> 0;

get(11251, ?COPPER_BOX) -> 0;


get(11252, ?DIAMOND_BOX) -> 0;

get(11252, ?GOLD_BOX) -> 0;

get(11252, ?SILVER_BOX) -> 0;

get(11252, ?COPPER_BOX) -> 0;


get(11253, ?DIAMOND_BOX) -> 0;

get(11253, ?GOLD_BOX) -> 0;

get(11253, ?SILVER_BOX) -> 0;

get(11253, ?COPPER_BOX) -> 0;


get(11254, ?DIAMOND_BOX) -> 0;

get(11254, ?GOLD_BOX) -> 0;

get(11254, ?SILVER_BOX) -> 0;

get(11254, ?COPPER_BOX) -> 0;


get(11255, ?DIAMOND_BOX) -> 0;

get(11255, ?GOLD_BOX) -> 0;

get(11255, ?SILVER_BOX) -> 0;

get(11255, ?COPPER_BOX) -> 0;


get(11256, ?DIAMOND_BOX) -> 0;

get(11256, ?GOLD_BOX) -> 0;

get(11256, ?SILVER_BOX) -> 0;

get(11256, ?COPPER_BOX) -> 0;


get(11257, ?DIAMOND_BOX) -> 0;

get(11257, ?GOLD_BOX) -> 0;

get(11257, ?SILVER_BOX) -> 0;

get(11257, ?COPPER_BOX) -> 0;


get(11258, ?DIAMOND_BOX) -> 0;

get(11258, ?GOLD_BOX) -> 0;

get(11258, ?SILVER_BOX) -> 0;

get(11258, ?COPPER_BOX) -> 0;


get(11259, ?DIAMOND_BOX) -> 0;

get(11259, ?GOLD_BOX) -> 0;

get(11259, ?SILVER_BOX) -> 0;

get(11259, ?COPPER_BOX) -> 0;


get(11260, ?DIAMOND_BOX) -> 0;

get(11260, ?GOLD_BOX) -> 0;

get(11260, ?SILVER_BOX) -> 0;

get(11260, ?COPPER_BOX) -> 0;


get(11261, ?DIAMOND_BOX) -> 0;

get(11261, ?GOLD_BOX) -> 0;

get(11261, ?SILVER_BOX) -> 0;

get(11261, ?COPPER_BOX) -> 0;


get(11262, ?DIAMOND_BOX) -> 0;

get(11262, ?GOLD_BOX) -> 0;

get(11262, ?SILVER_BOX) -> 0;

get(11262, ?COPPER_BOX) -> 0;


get(11263, ?DIAMOND_BOX) -> 0;

get(11263, ?GOLD_BOX) -> 0;

get(11263, ?SILVER_BOX) -> 0;

get(11263, ?COPPER_BOX) -> 0;


get(11264, ?DIAMOND_BOX) -> 0;

get(11264, ?GOLD_BOX) -> 0;

get(11264, ?SILVER_BOX) -> 0;

get(11264, ?COPPER_BOX) -> 0;


get(11265, ?DIAMOND_BOX) -> 0;

get(11265, ?GOLD_BOX) -> 0;

get(11265, ?SILVER_BOX) -> 0;

get(11265, ?COPPER_BOX) -> 0;


get(11266, ?DIAMOND_BOX) -> 0;

get(11266, ?GOLD_BOX) -> 0;

get(11266, ?SILVER_BOX) -> 0;

get(11266, ?COPPER_BOX) -> 0;


get(11267, ?DIAMOND_BOX) -> 0;

get(11267, ?GOLD_BOX) -> 0;

get(11267, ?SILVER_BOX) -> 0;

get(11267, ?COPPER_BOX) -> 0;


get(11268, ?DIAMOND_BOX) -> 0;

get(11268, ?GOLD_BOX) -> 0;

get(11268, ?SILVER_BOX) -> 0;

get(11268, ?COPPER_BOX) -> 0;


get(11269, ?DIAMOND_BOX) -> 0;

get(11269, ?GOLD_BOX) -> 0;

get(11269, ?SILVER_BOX) -> 0;

get(11269, ?COPPER_BOX) -> 0;


get(11270, ?DIAMOND_BOX) -> 0;

get(11270, ?GOLD_BOX) -> 0;

get(11270, ?SILVER_BOX) -> 0;

get(11270, ?COPPER_BOX) -> 0;


get(11271, ?DIAMOND_BOX) -> 0;

get(11271, ?GOLD_BOX) -> 0;

get(11271, ?SILVER_BOX) -> 0;

get(11271, ?COPPER_BOX) -> 0;


get(11272, ?DIAMOND_BOX) -> 0;

get(11272, ?GOLD_BOX) -> 0;

get(11272, ?SILVER_BOX) -> 0;

get(11272, ?COPPER_BOX) -> 0;


get(11273, ?DIAMOND_BOX) -> 0;

get(11273, ?GOLD_BOX) -> 0;

get(11273, ?SILVER_BOX) -> 0;

get(11273, ?COPPER_BOX) -> 0;


get(11274, ?DIAMOND_BOX) -> 0;

get(11274, ?GOLD_BOX) -> 0;

get(11274, ?SILVER_BOX) -> 0;

get(11274, ?COPPER_BOX) -> 0;


get(11275, ?DIAMOND_BOX) -> 0;

get(11275, ?GOLD_BOX) -> 0;

get(11275, ?SILVER_BOX) -> 0;

get(11275, ?COPPER_BOX) -> 0;


get(11276, ?DIAMOND_BOX) -> 0;

get(11276, ?GOLD_BOX) -> 0;

get(11276, ?SILVER_BOX) -> 0;

get(11276, ?COPPER_BOX) -> 0;


get(11277, ?DIAMOND_BOX) -> 0;

get(11277, ?GOLD_BOX) -> 0;

get(11277, ?SILVER_BOX) -> 0;

get(11277, ?COPPER_BOX) -> 0;


get(11278, ?DIAMOND_BOX) -> 0;

get(11278, ?GOLD_BOX) -> 0;

get(11278, ?SILVER_BOX) -> 0;

get(11278, ?COPPER_BOX) -> 0;


get(11279, ?DIAMOND_BOX) -> 0;

get(11279, ?GOLD_BOX) -> 0;

get(11279, ?SILVER_BOX) -> 0;

get(11279, ?COPPER_BOX) -> 0;


get(11280, ?DIAMOND_BOX) -> 0;

get(11280, ?GOLD_BOX) -> 0;

get(11280, ?SILVER_BOX) -> 0;

get(11280, ?COPPER_BOX) -> 0;


get(11281, ?DIAMOND_BOX) -> 0;

get(11281, ?GOLD_BOX) -> 0;

get(11281, ?SILVER_BOX) -> 0;

get(11281, ?COPPER_BOX) -> 0;


get(11282, ?DIAMOND_BOX) -> 0;

get(11282, ?GOLD_BOX) -> 0;

get(11282, ?SILVER_BOX) -> 0;

get(11282, ?COPPER_BOX) -> 0;


get(11283, ?DIAMOND_BOX) -> 0;

get(11283, ?GOLD_BOX) -> 0;

get(11283, ?SILVER_BOX) -> 0;

get(11283, ?COPPER_BOX) -> 0;


get(11284, ?DIAMOND_BOX) -> 0;

get(11284, ?GOLD_BOX) -> 0;

get(11284, ?SILVER_BOX) -> 0;

get(11284, ?COPPER_BOX) -> 0;


get(11285, ?DIAMOND_BOX) -> 0;

get(11285, ?GOLD_BOX) -> 0;

get(11285, ?SILVER_BOX) -> 0;

get(11285, ?COPPER_BOX) -> 0;


get(11286, ?DIAMOND_BOX) -> 0;

get(11286, ?GOLD_BOX) -> 0;

get(11286, ?SILVER_BOX) -> 0;

get(11286, ?COPPER_BOX) -> 0;


get(11287, ?DIAMOND_BOX) -> 0;

get(11287, ?GOLD_BOX) -> 0;

get(11287, ?SILVER_BOX) -> 0;

get(11287, ?COPPER_BOX) -> 0;


get(11288, ?DIAMOND_BOX) -> 0;

get(11288, ?GOLD_BOX) -> 0;

get(11288, ?SILVER_BOX) -> 0;

get(11288, ?COPPER_BOX) -> 0;


get(11289, ?DIAMOND_BOX) -> 0;

get(11289, ?GOLD_BOX) -> 0;

get(11289, ?SILVER_BOX) -> 0;

get(11289, ?COPPER_BOX) -> 0;


get(11290, ?DIAMOND_BOX) -> 0;

get(11290, ?GOLD_BOX) -> 0;

get(11290, ?SILVER_BOX) -> 0;

get(11290, ?COPPER_BOX) -> 0;


get(11291, ?DIAMOND_BOX) -> 0;

get(11291, ?GOLD_BOX) -> 0;

get(11291, ?SILVER_BOX) -> 0;

get(11291, ?COPPER_BOX) -> 0;


get(11292, ?DIAMOND_BOX) -> 0;

get(11292, ?GOLD_BOX) -> 0;

get(11292, ?SILVER_BOX) -> 0;

get(11292, ?COPPER_BOX) -> 0;


get(11293, ?DIAMOND_BOX) -> 0;

get(11293, ?GOLD_BOX) -> 0;

get(11293, ?SILVER_BOX) -> 0;

get(11293, ?COPPER_BOX) -> 0;


get(11294, ?DIAMOND_BOX) -> 0;

get(11294, ?GOLD_BOX) -> 0;

get(11294, ?SILVER_BOX) -> 0;

get(11294, ?COPPER_BOX) -> 0;


get(11295, ?DIAMOND_BOX) -> 0;

get(11295, ?GOLD_BOX) -> 0;

get(11295, ?SILVER_BOX) -> 0;

get(11295, ?COPPER_BOX) -> 0;


get(11296, ?DIAMOND_BOX) -> 0;

get(11296, ?GOLD_BOX) -> 0;

get(11296, ?SILVER_BOX) -> 0;

get(11296, ?COPPER_BOX) -> 0;


get(11297, ?DIAMOND_BOX) -> 0;

get(11297, ?GOLD_BOX) -> 0;

get(11297, ?SILVER_BOX) -> 0;

get(11297, ?COPPER_BOX) -> 0;


get(11298, ?DIAMOND_BOX) -> 0;

get(11298, ?GOLD_BOX) -> 0;

get(11298, ?SILVER_BOX) -> 0;

get(11298, ?COPPER_BOX) -> 0;


get(11299, ?DIAMOND_BOX) -> 0;

get(11299, ?GOLD_BOX) -> 0;

get(11299, ?SILVER_BOX) -> 0;

get(11299, ?COPPER_BOX) -> 0;


get(11300, ?DIAMOND_BOX) -> 0;

get(11300, ?GOLD_BOX) -> 0;

get(11300, ?SILVER_BOX) -> 0;

get(11300, ?COPPER_BOX) -> 0;



		get(_, _) ->
    ?ASSERT(false),
    null.
		
 
get_pass_reward_no(5051) -> 43001   
    ;
 
get_pass_reward_no(5052) -> 43002   
    ;
 
get_pass_reward_no(5053) -> 43003   
    ;
 
get_pass_reward_no(5054) -> 43004   
    ;
 
get_pass_reward_no(4001) -> 44001   
    ;
 
get_pass_reward_no(4002) -> 44002   
    ;
 
get_pass_reward_no(4003) -> 44003   
    ;
 
get_pass_reward_no(4004) -> 44004   
    ;
 
get_pass_reward_no(2031) -> 10059   
    ;
 
get_pass_reward_no(2032) -> 10060   
    ;
 
get_pass_reward_no(2033) -> 10061   
    ;
 
get_pass_reward_no(2034) -> 10062   
    ;
 
get_pass_reward_no(5001) -> 91235   
    ;
 
get_pass_reward_no(5002) -> 91236   
    ;
 
get_pass_reward_no(5003) -> 91237   
    ;
 
get_pass_reward_no(5011) -> 91238   
    ;
 
get_pass_reward_no(5012) -> 91239   
    ;
 
get_pass_reward_no(5013) -> 91240   
    ;
 
get_pass_reward_no(5021) -> 91241   
    ;
 
get_pass_reward_no(5022) -> 91242   
    ;
 
get_pass_reward_no(5023) -> 91243   
    ;
 
get_pass_reward_no(5031) -> 91244   
    ;
 
get_pass_reward_no(5032) -> 91245   
    ;
 
get_pass_reward_no(5033) -> 91246   
    ;
 
get_pass_reward_no(5041) -> 91247   
    ;
 
get_pass_reward_no(5042) -> 91248   
    ;
 
get_pass_reward_no(5043) -> 91249   
    ;
 
get_pass_reward_no(2041) -> 91182   
    ;
 
get_pass_reward_no(2042) -> 91184   
    ;
 
get_pass_reward_no(2043) -> 91186   
    ;
 
get_pass_reward_no(2001) -> 30254   
    ;
 
get_pass_reward_no(2002) -> 30256   
    ;
 
get_pass_reward_no(2003) -> 30258   
    ;
 
get_pass_reward_no(2011) -> 30260   
    ;
 
get_pass_reward_no(2012) -> 30262   
    ;
 
get_pass_reward_no(2013) -> 30264   
    ;
 
get_pass_reward_no(2021) -> 30284   
    ;
 
get_pass_reward_no(2022) -> 30286   
    ;
 
get_pass_reward_no(2023) -> 30288   
    ;
 
get_pass_reward_no(4011) -> 30272   
    ;
 
get_pass_reward_no(4012) -> 30274   
    ;
 
get_pass_reward_no(4013) -> 30276   
    ;
 
get_pass_reward_no(4021) -> 30278   
    ;
 
get_pass_reward_no(4022) -> 30280   
    ;
 
get_pass_reward_no(4023) -> 30282   
    ;
 
get_pass_reward_no(110001) -> 0   
    ;
 
get_pass_reward_no(110002) -> 0   
    ;
 
get_pass_reward_no(120000) -> 0   
    ;
 
get_pass_reward_no(120001) -> 0   
    ;
 
get_pass_reward_no(300001) -> 30157   
    ;
 
get_pass_reward_no(300002) -> 30159   
    ;
 
get_pass_reward_no(300003) -> 30161   
    ;
 
get_pass_reward_no(120002) -> 0   
    ;
 
get_pass_reward_no(120004) -> 0   
    ;
 
get_pass_reward_no(120003) -> 0   
    ;
 
get_pass_reward_no(4031) -> 91056   
    ;
 
get_pass_reward_no(4032) -> 91058   
    ;
 
get_pass_reward_no(4033) -> 91060   
    ;
 
get_pass_reward_no(4041) -> 91188   
    ;
 
get_pass_reward_no(4042) -> 91190   
    ;
 
get_pass_reward_no(4043) -> 91192   
    ;
 
get_pass_reward_no(200000) -> 0   
    ;
 
get_pass_reward_no(200001) -> 0   
    ;
 
get_pass_reward_no(200002) -> 0   
    ;
 
get_pass_reward_no(200003) -> 0   
    ;
 
get_pass_reward_no(200004) -> 0   
    ;
 
get_pass_reward_no(200005) -> 0   
    ;
 
get_pass_reward_no(200006) -> 0   
    ;
 
get_pass_reward_no(10001) -> 390001   
    ;
 
get_pass_reward_no(10002) -> 390002   
    ;
 
get_pass_reward_no(10003) -> 390003   
    ;
 
get_pass_reward_no(10004) -> 390004   
    ;
 
get_pass_reward_no(10005) -> 390005   
    ;
 
get_pass_reward_no(10006) -> 390006   
    ;
 
get_pass_reward_no(10007) -> 390007   
    ;
 
get_pass_reward_no(10008) -> 390008   
    ;
 
get_pass_reward_no(10009) -> 390009   
    ;
 
get_pass_reward_no(10010) -> 390010   
    ;
 
get_pass_reward_no(10011) -> 390011   
    ;
 
get_pass_reward_no(10012) -> 390012   
    ;
 
get_pass_reward_no(10013) -> 390013   
    ;
 
get_pass_reward_no(10014) -> 390014   
    ;
 
get_pass_reward_no(10015) -> 390015   
    ;
 
get_pass_reward_no(10016) -> 390016   
    ;
 
get_pass_reward_no(10017) -> 390017   
    ;
 
get_pass_reward_no(10018) -> 390018   
    ;
 
get_pass_reward_no(10019) -> 390019   
    ;
 
get_pass_reward_no(10020) -> 390020   
    ;
 
get_pass_reward_no(10021) -> 390021   
    ;
 
get_pass_reward_no(10022) -> 390022   
    ;
 
get_pass_reward_no(10023) -> 390023   
    ;
 
get_pass_reward_no(10024) -> 390024   
    ;
 
get_pass_reward_no(10025) -> 390025   
    ;
 
get_pass_reward_no(10026) -> 390026   
    ;
 
get_pass_reward_no(10027) -> 390027   
    ;
 
get_pass_reward_no(10028) -> 390028   
    ;
 
get_pass_reward_no(10029) -> 390029   
    ;
 
get_pass_reward_no(10030) -> 390030   
    ;
 
get_pass_reward_no(10031) -> 390031   
    ;
 
get_pass_reward_no(10032) -> 390032   
    ;
 
get_pass_reward_no(10033) -> 390033   
    ;
 
get_pass_reward_no(10034) -> 390034   
    ;
 
get_pass_reward_no(10035) -> 390035   
    ;
 
get_pass_reward_no(10036) -> 390036   
    ;
 
get_pass_reward_no(10037) -> 390037   
    ;
 
get_pass_reward_no(10038) -> 390038   
    ;
 
get_pass_reward_no(10039) -> 390039   
    ;
 
get_pass_reward_no(10040) -> 390040   
    ;
 
get_pass_reward_no(10041) -> 390041   
    ;
 
get_pass_reward_no(10042) -> 390042   
    ;
 
get_pass_reward_no(10043) -> 390043   
    ;
 
get_pass_reward_no(10044) -> 390044   
    ;
 
get_pass_reward_no(10045) -> 390045   
    ;
 
get_pass_reward_no(10046) -> 390046   
    ;
 
get_pass_reward_no(10047) -> 390047   
    ;
 
get_pass_reward_no(10048) -> 390048   
    ;
 
get_pass_reward_no(10049) -> 390049   
    ;
 
get_pass_reward_no(10050) -> 390050   
    ;
 
get_pass_reward_no(10051) -> 390051   
    ;
 
get_pass_reward_no(10052) -> 390052   
    ;
 
get_pass_reward_no(10053) -> 390053   
    ;
 
get_pass_reward_no(10054) -> 390054   
    ;
 
get_pass_reward_no(10055) -> 390055   
    ;
 
get_pass_reward_no(10056) -> 390056   
    ;
 
get_pass_reward_no(10057) -> 390057   
    ;
 
get_pass_reward_no(10058) -> 390058   
    ;
 
get_pass_reward_no(10059) -> 390059   
    ;
 
get_pass_reward_no(10060) -> 390060   
    ;
 
get_pass_reward_no(10061) -> 390061   
    ;
 
get_pass_reward_no(10062) -> 390062   
    ;
 
get_pass_reward_no(10063) -> 390063   
    ;
 
get_pass_reward_no(10064) -> 390064   
    ;
 
get_pass_reward_no(10065) -> 390065   
    ;
 
get_pass_reward_no(10066) -> 390066   
    ;
 
get_pass_reward_no(10067) -> 390067   
    ;
 
get_pass_reward_no(10068) -> 390068   
    ;
 
get_pass_reward_no(10069) -> 390069   
    ;
 
get_pass_reward_no(10070) -> 390070   
    ;
 
get_pass_reward_no(10071) -> 390071   
    ;
 
get_pass_reward_no(10072) -> 390072   
    ;
 
get_pass_reward_no(10073) -> 390073   
    ;
 
get_pass_reward_no(10074) -> 390074   
    ;
 
get_pass_reward_no(10075) -> 390075   
    ;
 
get_pass_reward_no(10076) -> 390076   
    ;
 
get_pass_reward_no(10077) -> 390077   
    ;
 
get_pass_reward_no(10078) -> 390078   
    ;
 
get_pass_reward_no(10079) -> 390079   
    ;
 
get_pass_reward_no(10080) -> 390080   
    ;
 
get_pass_reward_no(10081) -> 390081   
    ;
 
get_pass_reward_no(10082) -> 390082   
    ;
 
get_pass_reward_no(10083) -> 390083   
    ;
 
get_pass_reward_no(10084) -> 390084   
    ;
 
get_pass_reward_no(10085) -> 390085   
    ;
 
get_pass_reward_no(10086) -> 390086   
    ;
 
get_pass_reward_no(10087) -> 390087   
    ;
 
get_pass_reward_no(10088) -> 390088   
    ;
 
get_pass_reward_no(10089) -> 390089   
    ;
 
get_pass_reward_no(10090) -> 390090   
    ;
 
get_pass_reward_no(10091) -> 390091   
    ;
 
get_pass_reward_no(10092) -> 390092   
    ;
 
get_pass_reward_no(10093) -> 390093   
    ;
 
get_pass_reward_no(10094) -> 390094   
    ;
 
get_pass_reward_no(10095) -> 390095   
    ;
 
get_pass_reward_no(10096) -> 390096   
    ;
 
get_pass_reward_no(10097) -> 390097   
    ;
 
get_pass_reward_no(10098) -> 390098   
    ;
 
get_pass_reward_no(10099) -> 390099   
    ;
 
get_pass_reward_no(10100) -> 390100   
    ;
 
get_pass_reward_no(10101) -> 390101   
    ;
 
get_pass_reward_no(10102) -> 390102   
    ;
 
get_pass_reward_no(10103) -> 390103   
    ;
 
get_pass_reward_no(10104) -> 390104   
    ;
 
get_pass_reward_no(10105) -> 390105   
    ;
 
get_pass_reward_no(10106) -> 390106   
    ;
 
get_pass_reward_no(10107) -> 390107   
    ;
 
get_pass_reward_no(10108) -> 390108   
    ;
 
get_pass_reward_no(10109) -> 390109   
    ;
 
get_pass_reward_no(10110) -> 390110   
    ;
 
get_pass_reward_no(10111) -> 390111   
    ;
 
get_pass_reward_no(10112) -> 390112   
    ;
 
get_pass_reward_no(10113) -> 390113   
    ;
 
get_pass_reward_no(10114) -> 390114   
    ;
 
get_pass_reward_no(10115) -> 390115   
    ;
 
get_pass_reward_no(10116) -> 390116   
    ;
 
get_pass_reward_no(10117) -> 390117   
    ;
 
get_pass_reward_no(10118) -> 390118   
    ;
 
get_pass_reward_no(10119) -> 390119   
    ;
 
get_pass_reward_no(10120) -> 390120   
    ;
 
get_pass_reward_no(10121) -> 390121   
    ;
 
get_pass_reward_no(10122) -> 390122   
    ;
 
get_pass_reward_no(10123) -> 390123   
    ;
 
get_pass_reward_no(10124) -> 390124   
    ;
 
get_pass_reward_no(10125) -> 390125   
    ;
 
get_pass_reward_no(10126) -> 390126   
    ;
 
get_pass_reward_no(10127) -> 390127   
    ;
 
get_pass_reward_no(10128) -> 390128   
    ;
 
get_pass_reward_no(10129) -> 390129   
    ;
 
get_pass_reward_no(10130) -> 390130   
    ;
 
get_pass_reward_no(10131) -> 390131   
    ;
 
get_pass_reward_no(10132) -> 390132   
    ;
 
get_pass_reward_no(10133) -> 390133   
    ;
 
get_pass_reward_no(10134) -> 390134   
    ;
 
get_pass_reward_no(10135) -> 390135   
    ;
 
get_pass_reward_no(10136) -> 390136   
    ;
 
get_pass_reward_no(10137) -> 390137   
    ;
 
get_pass_reward_no(10138) -> 390138   
    ;
 
get_pass_reward_no(10139) -> 390139   
    ;
 
get_pass_reward_no(10140) -> 390140   
    ;
 
get_pass_reward_no(10141) -> 390141   
    ;
 
get_pass_reward_no(10142) -> 390142   
    ;
 
get_pass_reward_no(10143) -> 390143   
    ;
 
get_pass_reward_no(10144) -> 390144   
    ;
 
get_pass_reward_no(10145) -> 390145   
    ;
 
get_pass_reward_no(10146) -> 390146   
    ;
 
get_pass_reward_no(10147) -> 390147   
    ;
 
get_pass_reward_no(10148) -> 390148   
    ;
 
get_pass_reward_no(10149) -> 390149   
    ;
 
get_pass_reward_no(10150) -> 390150   
    ;
 
get_pass_reward_no(10151) -> 390151   
    ;
 
get_pass_reward_no(10152) -> 390152   
    ;
 
get_pass_reward_no(10153) -> 390153   
    ;
 
get_pass_reward_no(10154) -> 390154   
    ;
 
get_pass_reward_no(10155) -> 390155   
    ;
 
get_pass_reward_no(10156) -> 390156   
    ;
 
get_pass_reward_no(10157) -> 390157   
    ;
 
get_pass_reward_no(10158) -> 390158   
    ;
 
get_pass_reward_no(10159) -> 390159   
    ;
 
get_pass_reward_no(10160) -> 390160   
    ;
 
get_pass_reward_no(10161) -> 390161   
    ;
 
get_pass_reward_no(10162) -> 390162   
    ;
 
get_pass_reward_no(10163) -> 390163   
    ;
 
get_pass_reward_no(10164) -> 390164   
    ;
 
get_pass_reward_no(10165) -> 390165   
    ;
 
get_pass_reward_no(10166) -> 390166   
    ;
 
get_pass_reward_no(10167) -> 390167   
    ;
 
get_pass_reward_no(10168) -> 390168   
    ;
 
get_pass_reward_no(10169) -> 390169   
    ;
 
get_pass_reward_no(10170) -> 390170   
    ;
 
get_pass_reward_no(10171) -> 390171   
    ;
 
get_pass_reward_no(10172) -> 390172   
    ;
 
get_pass_reward_no(10173) -> 390173   
    ;
 
get_pass_reward_no(10174) -> 390174   
    ;
 
get_pass_reward_no(10175) -> 390175   
    ;
 
get_pass_reward_no(10176) -> 390176   
    ;
 
get_pass_reward_no(10177) -> 390177   
    ;
 
get_pass_reward_no(10178) -> 390178   
    ;
 
get_pass_reward_no(10179) -> 390179   
    ;
 
get_pass_reward_no(10180) -> 390180   
    ;
 
get_pass_reward_no(10181) -> 390181   
    ;
 
get_pass_reward_no(10182) -> 390182   
    ;
 
get_pass_reward_no(10183) -> 390183   
    ;
 
get_pass_reward_no(10184) -> 390184   
    ;
 
get_pass_reward_no(10185) -> 390185   
    ;
 
get_pass_reward_no(10186) -> 390186   
    ;
 
get_pass_reward_no(10187) -> 390187   
    ;
 
get_pass_reward_no(10188) -> 390188   
    ;
 
get_pass_reward_no(10189) -> 390189   
    ;
 
get_pass_reward_no(10190) -> 390190   
    ;
 
get_pass_reward_no(10191) -> 390191   
    ;
 
get_pass_reward_no(10192) -> 390192   
    ;
 
get_pass_reward_no(10193) -> 390193   
    ;
 
get_pass_reward_no(10194) -> 390194   
    ;
 
get_pass_reward_no(10195) -> 390195   
    ;
 
get_pass_reward_no(10196) -> 390196   
    ;
 
get_pass_reward_no(10197) -> 390197   
    ;
 
get_pass_reward_no(10198) -> 390198   
    ;
 
get_pass_reward_no(10199) -> 390199   
    ;
 
get_pass_reward_no(10200) -> 390200   
    ;
 
get_pass_reward_no(10201) -> 390201   
    ;
 
get_pass_reward_no(10202) -> 390202   
    ;
 
get_pass_reward_no(10203) -> 390203   
    ;
 
get_pass_reward_no(10204) -> 390204   
    ;
 
get_pass_reward_no(10205) -> 390205   
    ;
 
get_pass_reward_no(10206) -> 390206   
    ;
 
get_pass_reward_no(10207) -> 390207   
    ;
 
get_pass_reward_no(10208) -> 390208   
    ;
 
get_pass_reward_no(10209) -> 390209   
    ;
 
get_pass_reward_no(10210) -> 390210   
    ;
 
get_pass_reward_no(10211) -> 390211   
    ;
 
get_pass_reward_no(10212) -> 390212   
    ;
 
get_pass_reward_no(10213) -> 390213   
    ;
 
get_pass_reward_no(10214) -> 390214   
    ;
 
get_pass_reward_no(10215) -> 390215   
    ;
 
get_pass_reward_no(10216) -> 390216   
    ;
 
get_pass_reward_no(10217) -> 390217   
    ;
 
get_pass_reward_no(10218) -> 390218   
    ;
 
get_pass_reward_no(10219) -> 390219   
    ;
 
get_pass_reward_no(10220) -> 390220   
    ;
 
get_pass_reward_no(10221) -> 390221   
    ;
 
get_pass_reward_no(10222) -> 390222   
    ;
 
get_pass_reward_no(10223) -> 390223   
    ;
 
get_pass_reward_no(10224) -> 390224   
    ;
 
get_pass_reward_no(10225) -> 390225   
    ;
 
get_pass_reward_no(10226) -> 390226   
    ;
 
get_pass_reward_no(10227) -> 390227   
    ;
 
get_pass_reward_no(10228) -> 390228   
    ;
 
get_pass_reward_no(10229) -> 390229   
    ;
 
get_pass_reward_no(10230) -> 390230   
    ;
 
get_pass_reward_no(10231) -> 390231   
    ;
 
get_pass_reward_no(10232) -> 390232   
    ;
 
get_pass_reward_no(10233) -> 390233   
    ;
 
get_pass_reward_no(10234) -> 390234   
    ;
 
get_pass_reward_no(10235) -> 390235   
    ;
 
get_pass_reward_no(10236) -> 390236   
    ;
 
get_pass_reward_no(10237) -> 390237   
    ;
 
get_pass_reward_no(10238) -> 390238   
    ;
 
get_pass_reward_no(10239) -> 390239   
    ;
 
get_pass_reward_no(10240) -> 390240   
    ;
 
get_pass_reward_no(10241) -> 390241   
    ;
 
get_pass_reward_no(10242) -> 390242   
    ;
 
get_pass_reward_no(10243) -> 390243   
    ;
 
get_pass_reward_no(10244) -> 390244   
    ;
 
get_pass_reward_no(10245) -> 390245   
    ;
 
get_pass_reward_no(10246) -> 390246   
    ;
 
get_pass_reward_no(10247) -> 390247   
    ;
 
get_pass_reward_no(10248) -> 390248   
    ;
 
get_pass_reward_no(10249) -> 390249   
    ;
 
get_pass_reward_no(10250) -> 390250   
    ;
 
get_pass_reward_no(10251) -> 390251   
    ;
 
get_pass_reward_no(10252) -> 390252   
    ;
 
get_pass_reward_no(10253) -> 390253   
    ;
 
get_pass_reward_no(10254) -> 390254   
    ;
 
get_pass_reward_no(10255) -> 390255   
    ;
 
get_pass_reward_no(10256) -> 390256   
    ;
 
get_pass_reward_no(10257) -> 390257   
    ;
 
get_pass_reward_no(10258) -> 390258   
    ;
 
get_pass_reward_no(10259) -> 390259   
    ;
 
get_pass_reward_no(10260) -> 390260   
    ;
 
get_pass_reward_no(10261) -> 390261   
    ;
 
get_pass_reward_no(10262) -> 390262   
    ;
 
get_pass_reward_no(10263) -> 390263   
    ;
 
get_pass_reward_no(10264) -> 390264   
    ;
 
get_pass_reward_no(10265) -> 390265   
    ;
 
get_pass_reward_no(10266) -> 390266   
    ;
 
get_pass_reward_no(10267) -> 390267   
    ;
 
get_pass_reward_no(10268) -> 390268   
    ;
 
get_pass_reward_no(10269) -> 390269   
    ;
 
get_pass_reward_no(10270) -> 390270   
    ;
 
get_pass_reward_no(10271) -> 390271   
    ;
 
get_pass_reward_no(10272) -> 390272   
    ;
 
get_pass_reward_no(10273) -> 390273   
    ;
 
get_pass_reward_no(10274) -> 390274   
    ;
 
get_pass_reward_no(10275) -> 390275   
    ;
 
get_pass_reward_no(10276) -> 390276   
    ;
 
get_pass_reward_no(10277) -> 390277   
    ;
 
get_pass_reward_no(10278) -> 390278   
    ;
 
get_pass_reward_no(10279) -> 390279   
    ;
 
get_pass_reward_no(10280) -> 390280   
    ;
 
get_pass_reward_no(10281) -> 390281   
    ;
 
get_pass_reward_no(10282) -> 390282   
    ;
 
get_pass_reward_no(10283) -> 390283   
    ;
 
get_pass_reward_no(10284) -> 390284   
    ;
 
get_pass_reward_no(10285) -> 390285   
    ;
 
get_pass_reward_no(10286) -> 390286   
    ;
 
get_pass_reward_no(10287) -> 390287   
    ;
 
get_pass_reward_no(10288) -> 390288   
    ;
 
get_pass_reward_no(10289) -> 390289   
    ;
 
get_pass_reward_no(10290) -> 390290   
    ;
 
get_pass_reward_no(10291) -> 390291   
    ;
 
get_pass_reward_no(10292) -> 390292   
    ;
 
get_pass_reward_no(10293) -> 390293   
    ;
 
get_pass_reward_no(10294) -> 390294   
    ;
 
get_pass_reward_no(10295) -> 390295   
    ;
 
get_pass_reward_no(10296) -> 390296   
    ;
 
get_pass_reward_no(10297) -> 390297   
    ;
 
get_pass_reward_no(10298) -> 390298   
    ;
 
get_pass_reward_no(10299) -> 390299   
    ;
 
get_pass_reward_no(10300) -> 390300   
    ;
 
get_pass_reward_no(11001) -> 42001   
    ;
 
get_pass_reward_no(11002) -> 42001   
    ;
 
get_pass_reward_no(11003) -> 42001   
    ;
 
get_pass_reward_no(11004) -> 42001   
    ;
 
get_pass_reward_no(11005) -> 42001   
    ;
 
get_pass_reward_no(11006) -> 42001   
    ;
 
get_pass_reward_no(11007) -> 42001   
    ;
 
get_pass_reward_no(11008) -> 42001   
    ;
 
get_pass_reward_no(11009) -> 42001   
    ;
 
get_pass_reward_no(11010) -> 42001   
    ;
 
get_pass_reward_no(11011) -> 42002   
    ;
 
get_pass_reward_no(11012) -> 42002   
    ;
 
get_pass_reward_no(11013) -> 42002   
    ;
 
get_pass_reward_no(11014) -> 42002   
    ;
 
get_pass_reward_no(11015) -> 42002   
    ;
 
get_pass_reward_no(11016) -> 42002   
    ;
 
get_pass_reward_no(11017) -> 42002   
    ;
 
get_pass_reward_no(11018) -> 42002   
    ;
 
get_pass_reward_no(11019) -> 42002   
    ;
 
get_pass_reward_no(11020) -> 42002   
    ;
 
get_pass_reward_no(11021) -> 42003   
    ;
 
get_pass_reward_no(11022) -> 42003   
    ;
 
get_pass_reward_no(11023) -> 42003   
    ;
 
get_pass_reward_no(11024) -> 42003   
    ;
 
get_pass_reward_no(11025) -> 42003   
    ;
 
get_pass_reward_no(11026) -> 42003   
    ;
 
get_pass_reward_no(11027) -> 42003   
    ;
 
get_pass_reward_no(11028) -> 42003   
    ;
 
get_pass_reward_no(11029) -> 42003   
    ;
 
get_pass_reward_no(11030) -> 42003   
    ;
 
get_pass_reward_no(11031) -> 42004   
    ;
 
get_pass_reward_no(11032) -> 42004   
    ;
 
get_pass_reward_no(11033) -> 42004   
    ;
 
get_pass_reward_no(11034) -> 42004   
    ;
 
get_pass_reward_no(11035) -> 42004   
    ;
 
get_pass_reward_no(11036) -> 42004   
    ;
 
get_pass_reward_no(11037) -> 42004   
    ;
 
get_pass_reward_no(11038) -> 42004   
    ;
 
get_pass_reward_no(11039) -> 42004   
    ;
 
get_pass_reward_no(11040) -> 42004   
    ;
 
get_pass_reward_no(11041) -> 42005   
    ;
 
get_pass_reward_no(11042) -> 42005   
    ;
 
get_pass_reward_no(11043) -> 42005   
    ;
 
get_pass_reward_no(11044) -> 42005   
    ;
 
get_pass_reward_no(11045) -> 42005   
    ;
 
get_pass_reward_no(11046) -> 42005   
    ;
 
get_pass_reward_no(11047) -> 42005   
    ;
 
get_pass_reward_no(11048) -> 42005   
    ;
 
get_pass_reward_no(11049) -> 42005   
    ;
 
get_pass_reward_no(11050) -> 42005   
    ;
 
get_pass_reward_no(11051) -> 42006   
    ;
 
get_pass_reward_no(11052) -> 42006   
    ;
 
get_pass_reward_no(11053) -> 42006   
    ;
 
get_pass_reward_no(11054) -> 42006   
    ;
 
get_pass_reward_no(11055) -> 42006   
    ;
 
get_pass_reward_no(11056) -> 42006   
    ;
 
get_pass_reward_no(11057) -> 42006   
    ;
 
get_pass_reward_no(11058) -> 42006   
    ;
 
get_pass_reward_no(11059) -> 42006   
    ;
 
get_pass_reward_no(11060) -> 42006   
    ;
 
get_pass_reward_no(11061) -> 42006   
    ;
 
get_pass_reward_no(11062) -> 42006   
    ;
 
get_pass_reward_no(11063) -> 42006   
    ;
 
get_pass_reward_no(11064) -> 42006   
    ;
 
get_pass_reward_no(11065) -> 42006   
    ;
 
get_pass_reward_no(11066) -> 42006   
    ;
 
get_pass_reward_no(11067) -> 42006   
    ;
 
get_pass_reward_no(11068) -> 42006   
    ;
 
get_pass_reward_no(11069) -> 42006   
    ;
 
get_pass_reward_no(11070) -> 42006   
    ;
 
get_pass_reward_no(11071) -> 42006   
    ;
 
get_pass_reward_no(11072) -> 42006   
    ;
 
get_pass_reward_no(11073) -> 42006   
    ;
 
get_pass_reward_no(11074) -> 42006   
    ;
 
get_pass_reward_no(11075) -> 42006   
    ;
 
get_pass_reward_no(11076) -> 42006   
    ;
 
get_pass_reward_no(11077) -> 42006   
    ;
 
get_pass_reward_no(11078) -> 42006   
    ;
 
get_pass_reward_no(11079) -> 42006   
    ;
 
get_pass_reward_no(11080) -> 42006   
    ;
 
get_pass_reward_no(11081) -> 42006   
    ;
 
get_pass_reward_no(11082) -> 42006   
    ;
 
get_pass_reward_no(11083) -> 42006   
    ;
 
get_pass_reward_no(11084) -> 42006   
    ;
 
get_pass_reward_no(11085) -> 42006   
    ;
 
get_pass_reward_no(11086) -> 42006   
    ;
 
get_pass_reward_no(11087) -> 42006   
    ;
 
get_pass_reward_no(11088) -> 42006   
    ;
 
get_pass_reward_no(11089) -> 42006   
    ;
 
get_pass_reward_no(11090) -> 42006   
    ;
 
get_pass_reward_no(11091) -> 42006   
    ;
 
get_pass_reward_no(11092) -> 42006   
    ;
 
get_pass_reward_no(11093) -> 42006   
    ;
 
get_pass_reward_no(11094) -> 42006   
    ;
 
get_pass_reward_no(11095) -> 42006   
    ;
 
get_pass_reward_no(11096) -> 42006   
    ;
 
get_pass_reward_no(11097) -> 42006   
    ;
 
get_pass_reward_no(11098) -> 42006   
    ;
 
get_pass_reward_no(11099) -> 42006   
    ;
 
get_pass_reward_no(11100) -> 42006   
    ;
 
get_pass_reward_no(11101) -> 42006   
    ;
 
get_pass_reward_no(11102) -> 42006   
    ;
 
get_pass_reward_no(11103) -> 42006   
    ;
 
get_pass_reward_no(11104) -> 42006   
    ;
 
get_pass_reward_no(11105) -> 42006   
    ;
 
get_pass_reward_no(11106) -> 42006   
    ;
 
get_pass_reward_no(11107) -> 42006   
    ;
 
get_pass_reward_no(11108) -> 42006   
    ;
 
get_pass_reward_no(11109) -> 42006   
    ;
 
get_pass_reward_no(11110) -> 42006   
    ;
 
get_pass_reward_no(11111) -> 42006   
    ;
 
get_pass_reward_no(11112) -> 42006   
    ;
 
get_pass_reward_no(11113) -> 42006   
    ;
 
get_pass_reward_no(11114) -> 42006   
    ;
 
get_pass_reward_no(11115) -> 42006   
    ;
 
get_pass_reward_no(11116) -> 42006   
    ;
 
get_pass_reward_no(11117) -> 42006   
    ;
 
get_pass_reward_no(11118) -> 42006   
    ;
 
get_pass_reward_no(11119) -> 42006   
    ;
 
get_pass_reward_no(11120) -> 42006   
    ;
 
get_pass_reward_no(11121) -> 42006   
    ;
 
get_pass_reward_no(11122) -> 42006   
    ;
 
get_pass_reward_no(11123) -> 42006   
    ;
 
get_pass_reward_no(11124) -> 42006   
    ;
 
get_pass_reward_no(11125) -> 42006   
    ;
 
get_pass_reward_no(11126) -> 42006   
    ;
 
get_pass_reward_no(11127) -> 42006   
    ;
 
get_pass_reward_no(11128) -> 42006   
    ;
 
get_pass_reward_no(11129) -> 42006   
    ;
 
get_pass_reward_no(11130) -> 42006   
    ;
 
get_pass_reward_no(11131) -> 42006   
    ;
 
get_pass_reward_no(11132) -> 42006   
    ;
 
get_pass_reward_no(11133) -> 42006   
    ;
 
get_pass_reward_no(11134) -> 42006   
    ;
 
get_pass_reward_no(11135) -> 42006   
    ;
 
get_pass_reward_no(11136) -> 42006   
    ;
 
get_pass_reward_no(11137) -> 42006   
    ;
 
get_pass_reward_no(11138) -> 42006   
    ;
 
get_pass_reward_no(11139) -> 42006   
    ;
 
get_pass_reward_no(11140) -> 42006   
    ;
 
get_pass_reward_no(11141) -> 42006   
    ;
 
get_pass_reward_no(11142) -> 42006   
    ;
 
get_pass_reward_no(11143) -> 42006   
    ;
 
get_pass_reward_no(11144) -> 42006   
    ;
 
get_pass_reward_no(11145) -> 42006   
    ;
 
get_pass_reward_no(11146) -> 42006   
    ;
 
get_pass_reward_no(11147) -> 42006   
    ;
 
get_pass_reward_no(11148) -> 42006   
    ;
 
get_pass_reward_no(11149) -> 42006   
    ;
 
get_pass_reward_no(11150) -> 42006   
    ;
 
get_pass_reward_no(11151) -> 42006   
    ;
 
get_pass_reward_no(11152) -> 42006   
    ;
 
get_pass_reward_no(11153) -> 42006   
    ;
 
get_pass_reward_no(11154) -> 42006   
    ;
 
get_pass_reward_no(11155) -> 42006   
    ;
 
get_pass_reward_no(11156) -> 42006   
    ;
 
get_pass_reward_no(11157) -> 42006   
    ;
 
get_pass_reward_no(11158) -> 42006   
    ;
 
get_pass_reward_no(11159) -> 42006   
    ;
 
get_pass_reward_no(11160) -> 42006   
    ;
 
get_pass_reward_no(11161) -> 42006   
    ;
 
get_pass_reward_no(11162) -> 42006   
    ;
 
get_pass_reward_no(11163) -> 42006   
    ;
 
get_pass_reward_no(11164) -> 42006   
    ;
 
get_pass_reward_no(11165) -> 42006   
    ;
 
get_pass_reward_no(11166) -> 42006   
    ;
 
get_pass_reward_no(11167) -> 42006   
    ;
 
get_pass_reward_no(11168) -> 42006   
    ;
 
get_pass_reward_no(11169) -> 42006   
    ;
 
get_pass_reward_no(11170) -> 42006   
    ;
 
get_pass_reward_no(11171) -> 42006   
    ;
 
get_pass_reward_no(11172) -> 42006   
    ;
 
get_pass_reward_no(11173) -> 42006   
    ;
 
get_pass_reward_no(11174) -> 42006   
    ;
 
get_pass_reward_no(11175) -> 42006   
    ;
 
get_pass_reward_no(11176) -> 42006   
    ;
 
get_pass_reward_no(11177) -> 42006   
    ;
 
get_pass_reward_no(11178) -> 42006   
    ;
 
get_pass_reward_no(11179) -> 42006   
    ;
 
get_pass_reward_no(11180) -> 42006   
    ;
 
get_pass_reward_no(11181) -> 42006   
    ;
 
get_pass_reward_no(11182) -> 42006   
    ;
 
get_pass_reward_no(11183) -> 42006   
    ;
 
get_pass_reward_no(11184) -> 42006   
    ;
 
get_pass_reward_no(11185) -> 42006   
    ;
 
get_pass_reward_no(11186) -> 42006   
    ;
 
get_pass_reward_no(11187) -> 42006   
    ;
 
get_pass_reward_no(11188) -> 42006   
    ;
 
get_pass_reward_no(11189) -> 42006   
    ;
 
get_pass_reward_no(11190) -> 42006   
    ;
 
get_pass_reward_no(11191) -> 42006   
    ;
 
get_pass_reward_no(11192) -> 42006   
    ;
 
get_pass_reward_no(11193) -> 42006   
    ;
 
get_pass_reward_no(11194) -> 42006   
    ;
 
get_pass_reward_no(11195) -> 42006   
    ;
 
get_pass_reward_no(11196) -> 42006   
    ;
 
get_pass_reward_no(11197) -> 42006   
    ;
 
get_pass_reward_no(11198) -> 42006   
    ;
 
get_pass_reward_no(11199) -> 42006   
    ;
 
get_pass_reward_no(11200) -> 42006   
    ;
 
get_pass_reward_no(11201) -> 42006   
    ;
 
get_pass_reward_no(11202) -> 42006   
    ;
 
get_pass_reward_no(11203) -> 42006   
    ;
 
get_pass_reward_no(11204) -> 42006   
    ;
 
get_pass_reward_no(11205) -> 42006   
    ;
 
get_pass_reward_no(11206) -> 42006   
    ;
 
get_pass_reward_no(11207) -> 42006   
    ;
 
get_pass_reward_no(11208) -> 42006   
    ;
 
get_pass_reward_no(11209) -> 42006   
    ;
 
get_pass_reward_no(11210) -> 42006   
    ;
 
get_pass_reward_no(11211) -> 42006   
    ;
 
get_pass_reward_no(11212) -> 42006   
    ;
 
get_pass_reward_no(11213) -> 42006   
    ;
 
get_pass_reward_no(11214) -> 42006   
    ;
 
get_pass_reward_no(11215) -> 42006   
    ;
 
get_pass_reward_no(11216) -> 42006   
    ;
 
get_pass_reward_no(11217) -> 42006   
    ;
 
get_pass_reward_no(11218) -> 42006   
    ;
 
get_pass_reward_no(11219) -> 42006   
    ;
 
get_pass_reward_no(11220) -> 42006   
    ;
 
get_pass_reward_no(11221) -> 42006   
    ;
 
get_pass_reward_no(11222) -> 42006   
    ;
 
get_pass_reward_no(11223) -> 42006   
    ;
 
get_pass_reward_no(11224) -> 42006   
    ;
 
get_pass_reward_no(11225) -> 42006   
    ;
 
get_pass_reward_no(11226) -> 42006   
    ;
 
get_pass_reward_no(11227) -> 42006   
    ;
 
get_pass_reward_no(11228) -> 42006   
    ;
 
get_pass_reward_no(11229) -> 42006   
    ;
 
get_pass_reward_no(11230) -> 42006   
    ;
 
get_pass_reward_no(11231) -> 42006   
    ;
 
get_pass_reward_no(11232) -> 42006   
    ;
 
get_pass_reward_no(11233) -> 42006   
    ;
 
get_pass_reward_no(11234) -> 42006   
    ;
 
get_pass_reward_no(11235) -> 42006   
    ;
 
get_pass_reward_no(11236) -> 42006   
    ;
 
get_pass_reward_no(11237) -> 42006   
    ;
 
get_pass_reward_no(11238) -> 42006   
    ;
 
get_pass_reward_no(11239) -> 42006   
    ;
 
get_pass_reward_no(11240) -> 42006   
    ;
 
get_pass_reward_no(11241) -> 42006   
    ;
 
get_pass_reward_no(11242) -> 42006   
    ;
 
get_pass_reward_no(11243) -> 42006   
    ;
 
get_pass_reward_no(11244) -> 42006   
    ;
 
get_pass_reward_no(11245) -> 42006   
    ;
 
get_pass_reward_no(11246) -> 42006   
    ;
 
get_pass_reward_no(11247) -> 42006   
    ;
 
get_pass_reward_no(11248) -> 42006   
    ;
 
get_pass_reward_no(11249) -> 42006   
    ;
 
get_pass_reward_no(11250) -> 42006   
    ;
 
get_pass_reward_no(11251) -> 42006   
    ;
 
get_pass_reward_no(11252) -> 42006   
    ;
 
get_pass_reward_no(11253) -> 42006   
    ;
 
get_pass_reward_no(11254) -> 42006   
    ;
 
get_pass_reward_no(11255) -> 42006   
    ;
 
get_pass_reward_no(11256) -> 42006   
    ;
 
get_pass_reward_no(11257) -> 42006   
    ;
 
get_pass_reward_no(11258) -> 42006   
    ;
 
get_pass_reward_no(11259) -> 42006   
    ;
 
get_pass_reward_no(11260) -> 42006   
    ;
 
get_pass_reward_no(11261) -> 42006   
    ;
 
get_pass_reward_no(11262) -> 42006   
    ;
 
get_pass_reward_no(11263) -> 42006   
    ;
 
get_pass_reward_no(11264) -> 42006   
    ;
 
get_pass_reward_no(11265) -> 42006   
    ;
 
get_pass_reward_no(11266) -> 42006   
    ;
 
get_pass_reward_no(11267) -> 42006   
    ;
 
get_pass_reward_no(11268) -> 42006   
    ;
 
get_pass_reward_no(11269) -> 42006   
    ;
 
get_pass_reward_no(11270) -> 42006   
    ;
 
get_pass_reward_no(11271) -> 42006   
    ;
 
get_pass_reward_no(11272) -> 42006   
    ;
 
get_pass_reward_no(11273) -> 42006   
    ;
 
get_pass_reward_no(11274) -> 42006   
    ;
 
get_pass_reward_no(11275) -> 42006   
    ;
 
get_pass_reward_no(11276) -> 42006   
    ;
 
get_pass_reward_no(11277) -> 42006   
    ;
 
get_pass_reward_no(11278) -> 42006   
    ;
 
get_pass_reward_no(11279) -> 42006   
    ;
 
get_pass_reward_no(11280) -> 42006   
    ;
 
get_pass_reward_no(11281) -> 42006   
    ;
 
get_pass_reward_no(11282) -> 42006   
    ;
 
get_pass_reward_no(11283) -> 42006   
    ;
 
get_pass_reward_no(11284) -> 42006   
    ;
 
get_pass_reward_no(11285) -> 42006   
    ;
 
get_pass_reward_no(11286) -> 42006   
    ;
 
get_pass_reward_no(11287) -> 42006   
    ;
 
get_pass_reward_no(11288) -> 42006   
    ;
 
get_pass_reward_no(11289) -> 42006   
    ;
 
get_pass_reward_no(11290) -> 42006   
    ;
 
get_pass_reward_no(11291) -> 42006   
    ;
 
get_pass_reward_no(11292) -> 42006   
    ;
 
get_pass_reward_no(11293) -> 42006   
    ;
 
get_pass_reward_no(11294) -> 42006   
    ;
 
get_pass_reward_no(11295) -> 42006   
    ;
 
get_pass_reward_no(11296) -> 42006   
    ;
 
get_pass_reward_no(11297) -> 42006   
    ;
 
get_pass_reward_no(11298) -> 42006   
    ;
 
get_pass_reward_no(11299) -> 42006   
    ;
 
get_pass_reward_no(11300) -> 42006   
    ;

get_pass_reward_no(_Arg) ->
    null.
    
