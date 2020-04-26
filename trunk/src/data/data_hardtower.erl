-module(data_hardtower).


-include("common.hrl").
-include("record.hrl").
-include("dungeon.hrl").
-compile(export_all).


get_max_floor() -> 10.

get(100002) ->
  #dungeon_data{
    no = 100002,
    lv = 60,
    group = 100002,
    type = 12,
    cd={day, 1},
        role_num=1,
        timing=0,
        default_listener=[1],
        listener=[
            #listener{id=10,
                     condition=[],
                      action=[
			#action{type=create_tower_map, object=nil, target=[3302]},
                        #action{type=convey_dungeon, object=all, target=[{3302, 34, 12}]},
                        #action{type=add_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=add_seemon, object=nil, target=[{18501, 3302, 61, 25}]},
                        #action{type=push_id, object=nil, target=[11]}
                      ]
                      },
            #listener{id=11,
                      condition=[
			#condition{type =rand_battle_win_group, object = self,target= [8501,8502,8503,8504,8505,8506,8507,8508,8509,8510]}
                      ],
                      action=[
                        #action{type=add_npc, object=nil, target=[{4000, 3302, 73, 16}]},
                        #action{type = del_seemon, object=nil, target=[{18501, 3302, 61, 25}]},
                        #action{type = del_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=set_floor_pass, object=nil, target=[10]},
                        #action{type=push_id, object=nil, target=[12]}
                      ]
                      },
            #listener{id=12,
                      condition=[
			#condition{type = next_floor, object = self,target=[20]}
                      ],
                      action=[
                        #action{type=push_id, object=nil, target=[20]}
                      ]
                      },
            #listener{id=20,
                     condition=[],
                      action=[
			#action{type=create_tower_map, object=nil, target=[3302]},
                        #action{type=convey_dungeon, object=all, target=[{3302, 34, 12}]},
			#action{type = reclaim_map, object=nil, target=[]},
                        #action{type=add_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=add_seemon, object=nil, target=[{18502, 3302, 61, 25}]},
                        #action{type=push_id, object=nil, target=[21]}
                      ]
                      },
            #listener{id=21,
                      condition=[
			#condition{type = rand_battle_win_group, object = self,target= [8511,8512,8513,8514,8515,8516,8517,8518,8519,8520]}
                      ],
                      action=[
                        #action{type=add_npc, object=nil, target=[{4000, 3302, 73, 16}]},
                        #action{type = del_seemon, object=nil, target=[{18502, 3302, 61, 25}]},
                        #action{type = del_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=set_floor_pass, object=nil, target=[20]},
                        #action{type=push_id, object=nil, target=[22]}
                      ]
                      },
            #listener{id=22,
                      condition=[
			#condition{type = next_floor, object = self,target=[30]}
                      ],
                      action=[
                        #action{type=push_id, object=nil, target=[30]}
                      ]
                      },
            #listener{id=30,
                     condition=[],
                      action=[
			#action{type=create_tower_map, object=nil, target=[3302]},
                        #action{type=convey_dungeon, object=all, target=[{3302, 34, 12}]},
                        #action{type=add_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=add_seemon, object=nil, target=[{18503, 3302, 61, 25}]},
                        #action{type=push_id, object=nil, target=[31]}
                      ]
                      },
            #listener{id=31,
                      condition=[
			#condition{type = rand_battle_win_group, object = self,target= [8521,8522,8523,8524,8525,8526,8527,8528,8529,8530]}
                      ],
                      action=[
                        #action{type=add_npc, object=nil, target=[{4000, 3302, 73, 16}]},
                        #action{type = del_seemon, object=nil, target=[{18503, 3302, 61, 25}]},
                        #action{type = del_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=set_floor_pass, object=nil, target=[30]},
                        #action{type=push_id, object=nil, target=[32]}
                      ]
                      },
            #listener{id=32,
                      condition=[
			#condition{type = next_floor, object = self,target=[40]}
                      ],
                      action=[
                        #action{type=push_id, object=nil, target=[40]}
                      ]
                      },
            #listener{id=40,
                     condition=[],
                      action=[
			#action{type=create_tower_map, object=nil, target=[3302]},
                        #action{type=convey_dungeon, object=all, target=[{3302, 34, 12}]},
			#action{type = reclaim_map, object=nil, target=[]},
                        #action{type=add_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=add_seemon, object=nil, target=[{18504, 3302, 61, 25}]},
                        #action{type=push_id, object=nil, target=[41]}
                      ]
                      },
            #listener{id=41,
                      condition=[
			#condition{type = rand_battle_win_group, object = self,target= [8531,8532,8533,8534,8535,8536,8537,8538,8539,8540]}
                      ],
                      action=[
                        #action{type=add_npc, object=nil, target=[{4000, 3302, 73, 16}]},
                        #action{type = del_seemon, object=nil, target=[{18504, 3302, 61, 25}]},
                        #action{type = del_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=set_floor_pass, object=nil, target=[40]},
                        #action{type=push_id, object=nil, target=[42]}
                      ]
                      },
            #listener{id=42,
                      condition=[
			#condition{type = next_floor, object = self,target=[50]}
                      ],
                      action=[
                        #action{type=push_id, object=nil, target=[50]}
                      ]
                      },
            #listener{id=50,
                     condition=[],
                      action=[
			#action{type=create_tower_map, object=nil, target=[3302]},
                        #action{type=convey_dungeon, object=all, target=[{3302, 34, 12}]},
			#action{type = reclaim_map, object=nil, target=[]},
                        #action{type=add_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=add_seemon, object=nil, target=[{18505, 3302, 61, 25}]},
                        #action{type=push_id, object=nil, target=[51]}
                      ]
                      },
            #listener{id=51,
                      condition=[
			#condition{type = rand_battle_win_group, object = self,target= [8541,8542,8543,8544,8545,8546,8547,8548,8549,8550]}
                      ],
                      action=[
                        #action{type=add_npc, object=nil, target=[{4000, 3302, 73, 16}]},
                        #action{type = del_seemon, object=nil, target=[{18505, 3302, 61, 25}]},
                        #action{type = del_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=set_floor_pass, object=nil, target=[50]},
                        #action{type=push_id, object=nil, target=[52]}
                      ]
                      },
            #listener{id=52,
                      condition=[
			#condition{type = next_floor, object = self,target=[60]}
                      ],
                      action=[
                        #action{type=push_id, object=nil, target=[60]}
                      ]
                      },
            #listener{id=60,
                     condition=[],
                      action=[
			#action{type=create_tower_map, object=nil, target=[3302]},
                        #action{type=convey_dungeon, object=all, target=[{3302, 34, 12}]},
			#action{type = reclaim_map, object=nil, target=[]},
                        #action{type=add_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=add_seemon, object=nil, target=[{18506, 3302, 61, 25}]},
                        #action{type=push_id, object=nil, target=[61]}
                      ]
                      },
            #listener{id=61,
                      condition=[
			#condition{type = rand_battle_win_group, object = self,target= [8551,8552,8553,8554,8555,8556,8557,8558,8559,8560]}
                      ],
                      action=[
                        #action{type=add_npc, object=nil, target=[{4000, 3302, 73, 16}]},
                        #action{type = del_seemon, object=nil, target=[{18506, 3302, 61, 25}]},
                        #action{type = del_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=set_floor_pass, object=nil, target=[60]},
                        #action{type=push_id, object=nil, target=[62]}
                      ]
                      },
            #listener{id=62,
                      condition=[
			#condition{type = next_floor, object = self,target=[70]}
                      ],
                      action=[
                        #action{type=push_id, object=nil, target=[70]}
                      ]
                      },
            #listener{id=70,
                      condition=[
                      ],
                      action=[
			#action{type=create_tower_map, object=nil, target=[3302]},
                        #action{type=convey_dungeon, object=all, target=[{3302, 34, 12}]},
			#action{type = reclaim_map, object=nil, target=[]},
                        #action{type=add_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=add_seemon, object=nil, target=[{18507, 3302, 61, 25}]},
			#action{type=push_id, object=nil, target=[71]}
                      ]
                      },
            #listener{id=71,
                      condition=[
			#condition{type = rand_battle_win_group, object = self,target= [8561,8562,8563,8564,8565,8566,8567,8568,8569,8570]}
                      ],
                      action=[
                        #action{type=add_npc, object=nil, target=[{4000, 3302, 73, 16}]},
                        #action{type = del_seemon, object=nil, target=[{18507, 3302, 61, 25}]},
                        #action{type = del_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=set_floor_pass, object=nil, target=[70]},
                        #action{type=push_id, object=nil, target=[72]}
                      ]
                  },
            #listener{id=72,
                      condition=[
			#condition{type = next_floor, object = self,target=[80]}
                      ],
                      action=[
                        #action{type=push_id, object=nil, target=[80]}
                      ]
                  },
            #listener{id=80,
                      condition=[
                      ],
                      action=[
			#action{type=create_tower_map, object=nil, target=[3302]},
                        #action{type=convey_dungeon, object=all, target=[{3302, 34, 12}]},
			#action{type = reclaim_map, object=nil, target=[]},
                        #action{type=add_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=add_seemon, object=nil, target=[{18508, 3302, 61, 25}]},
			#action{type=push_id, object=nil, target=[81]}
                      ]
                      },
            #listener{id=81,
                      condition=[
			#condition{type = rand_battle_win_group, object = self,target= [8571,8572,8573,8574,8575,8576,8577,8578,8579,8580]}
                      ],
                      action=[
                        #action{type=add_npc, object=nil, target=[{4000, 3302, 73, 16}]},
                        #action{type = del_seemon, object=nil, target=[{18508, 3302, 61, 25}]},
                        #action{type = del_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=set_floor_pass, object=nil, target=[80]},
                        #action{type=push_id, object=nil, target=[82]}
                      ]
                  },
            #listener{id=82,
                      condition=[
			#condition{type = next_floor, object = self,target=[90]}
                      ],
                      action=[
                        #action{type=push_id, object=nil, target=[90]}
                      ]
                  },
            #listener{id=90,
                      condition=[
                      ],
                      action=[
			#action{type=create_tower_map, object=nil, target=[3302]},
                        #action{type=convey_dungeon, object=all, target=[{3302, 34, 12}]},
			#action{type = reclaim_map, object=nil, target=[]},
                        #action{type=add_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=add_seemon, object=nil, target=[{18509, 3302, 61, 25}]},
			#action{type=push_id, object=nil, target=[91]}
                      ]
                   },
            #listener{id=91,
                      condition=[
			#condition{type = rand_battle_win_group, object = self,target= [8581,8582,8583,8584,8585,8586,8587,8588,8589,8590]}
                      ],
                      action=[
                        #action{type=add_npc, object=nil, target=[{4000, 3302, 73, 16}]},
                        #action{type = del_seemon, object=nil, target=[{18509, 3302, 61, 25}]},
                        #action{type = del_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=set_floor_pass, object=nil, target=[90]},
                        #action{type=push_id, object=nil, target=[92]}
                      ]
                  },
            #listener{id=92,
                      condition=[
			#condition{type = next_floor, object = self,target=[90]}
                      ],
                      action=[
                        #action{type=push_id, object=nil, target=[100]}
                      ]
                  },
            #listener{id=100,
                      condition=[
                      ],
                      action=[
			#action{type=create_tower_map, object=nil, target=[3302]},
                        #action{type=convey_dungeon, object=all, target=[{3302, 34, 12}]},
			#action{type = reclaim_map, object=nil, target=[]},
                        #action{type=add_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=add_seemon, object=nil, target=[{18510, 3302, 61, 25}]},
			#action{type=push_id, object=nil, target=[101]}
                      ]
                   },
            #listener{id=101,
                      condition=[
			#condition{type = rand_battle_win_group, object = self,target= [8591,8592,8593,8594,8595,8596,8597,8598,8599,8600]}
                      ],
                      action=[
                        #action{type = del_seemon, object=nil, target=[{18510, 3302, 61, 25}]},
                        #action{type = del_npc, object=nil, target=[{4101, 3302, 44, 13}]},
                        #action{type=set_floor_pass, object=nil, target=[100]},
			#action{type = tower_top, object=nil, target=[]} 
                      ]
		}

        ] 
};

get(_Arg) ->
    ?ASSERT(false, [_Arg]),
    null.