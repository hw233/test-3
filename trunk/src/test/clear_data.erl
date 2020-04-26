%% @author wjc
%% @doc @todo Add description to clear_data.


-module(clear_data).

%% ====================================================================
%% API functions
%% ====================================================================
-export([exe_clear/4,x6_exe_clear/4]).

% 大于Lv-1等级的数据会被保存下来or时间是七天内登录过的都会被保存下来
exe_clear(Lv,DataBaseName,UserName,Password) ->
    {M, S, _} = os:timestamp(),
    NowTime = M * 1000000 + S,
    % 2018/10/9 15:49:55  -> 1539071395
    % 2018/10/2 15:49:55  -> 1538466595  
    % 604800 = 1539071395 - 1538466595
    
    LastWeekTime =NowTime -  604800,
	%{要导出的表， 满足导出表需要的条件， in里面的player表条件字段，}，{直接导出表数据}
	ConditionList = [{account,accname,accname},{achievement_data,role_id,id},
					 {activity_data,id,id},{activity_degree,id,id},
					 {admin_activity},{admin_festival_activity},{admin_sys_activity},
					 {answer,role_id,id},{arts,player_id,id},
					 {beauty_contest_goods_record},{cdk_misc},{chapter_target_info,role_id,id},
					 {day_reward,player_id,id},{dungeon_cd,role_id,id},{dungeon_plot_target,role_id,id},
					 {ernie,role_id,id},{find_par,player_id,id},{first_open_server_time},{global_sys_var},
					 {goods,player_id,id},{guess},{guess_bet,role_id,id},{guild},{guild_dungeon},
					 {guild_dungeon_data,player_id,id},{guild_member,id,id},{hardtower},{hire},
					 {hirer},{home,id,id},{home_data,id,id},{mail,recv_id,id},{market_selling,seller_id,id},
					 {mount,player_id,id},{obj_buff,player_id,id},{offcast,id,id},
					 {offline_bo},{offstate,id,id},{partner, player_id, id},{partner_hotel, player_id, id},
					 {player_ext, player_id, id},{player_misc, player_id, id},{relation},{relation_info, id, id},
					 {road, player_id, id},{role_dungeon, role_id, id},{role_transport, role_id, id},
					 {server},{shop},{slotmachine, player_id, id},{sprd, player_id, id},{sworn,id,id},
					 {sys_set, player_id, id},{t_ban_chat, role_id, id},{t_ban_ip_list},{t_ban_role, role_id, id},
					 {t_broadcast},{task_auto_trigger, role_id, id},{task_bag, role_id, id},{task_completed, role_id, id},
					 {task_completed_unrepeat, role_id, id},{task_ring, role_id, id},{title, id, id},{tower, id, id},
					 {tve_data},{xinfa, player_id, id},{xs_task},{player,1},{relation,2},{lottery, player_id, id }
					],
	
	F = fun(X,Acc) ->
				case X of
					{NewTable,SatisfyCondition,InSatisfyCondition} ->
%% 						S = "mysqldump -u~s -p~s ~s ~s --lock-all-tables -w \"~s in (select ~s from player where lv >= ~w or last_login_time > ~w)\" >> output_data.sql\r\n",
%% 						Args = [UserName,Password,DataBaseName,NewTable,SatisfyCondition,InSatisfyCondition,LastWeekTime],
%% 						Cmd = io_lib:format(S, Args),
						Data = lists:concat(["mysqldump -u",UserName," -p",
											 Password," ", DataBaseName," ",NewTable," --lock-all-tables -w \"",
											 SatisfyCondition," in (select ",InSatisfyCondition," from player where lv >= ",Lv,
											 " or last_login_time > ",LastWeekTime,")\" >> output_data0.sql\n"]),
						lists:append(Acc, Data);						
					{NewTable}  -> 
						Data = lists:concat(["mysqldump -u",UserName," -p",
											 Password," ", DataBaseName," ",NewTable," --lock-all-tables >>  output_data0.sql\n"]),
						lists:append(Acc, Data);
					{NewTable,1} ->
						Data = lists:concat(["mysqldump -u",UserName," -p",
											 Password," ", DataBaseName," ",NewTable," --lock-all-tables  -w \"",
											 " lv >= ",Lv,
											 " or last_login_time > ",LastWeekTime,"\" >> output_data0.sql\n"]),
						lists:append(Acc, Data);
					
					{NewTable,2} ->
						Data = lists:concat(["mysqldump -u",UserName," -p",
											 Password," ", DataBaseName," ",NewTable," --lock-all-tables -w \"",
											 "idA in (select id from player where lv >= ",Lv,
											 " or last_login_time > ",LastWeekTime,") and idB in (select id from player where lv >= ",Lv,
											 " or last_login_time > ",LastWeekTime,")\" >> output_data0.sql\n"]),
						lists:append(Acc, Data)
													
				end
		end,
						
	
	SqlData = lists:foldl(F,"#!/bin/sh\r\n",ConditionList),
	%SqlData = list_to_binary(SqlData0),
	file:write_file("output_data.sh", list_to_binary(SqlData)).


% 大于Lv-1等级的数据会被保存下来or时间是七天内登录过的都会被保存下来
%source /root/alter_2018_09_13.sql;
x6_exe_clear(Lv,DataBaseName,UserName,Password) ->
    {M, S, _} = os:timestamp(),
    NowTime = M * 1000000 + S,
    % 2018/10/9 15:49:55  -> 1539071395
    % 2018/10/2 15:49:55  -> 1538466595  
    % 604800 = 1539071395 - 1538466595
    
    LastWeekTime =NowTime -  604800,
	%{要导出的表， 满足导出表需要的条件， in里面的player表条件字段，}，{直接导出表数据}
	ConditionList = [{account,accname,accname},{achievement_data,role_id,id},
					 {activity_data,id,id},{activity_degree,id,id},
					 {admin_activity},{admin_festival_activity},{admin_sys_activity},
					 {answer,role_id,id},{arts,player_id,id},
					 {beauty_contest_goods_record},{cdk_misc},{chapter_target_info,role_id,id},
					 {day_reward,player_id,id},{dungeon_cd,role_id,id},{dungeon_plot_target,role_id,id},
					 {ernie,role_id,id},{find_par,player_id,id},{first_open_server_time},{global_sys_var},
					 {goods,player_id,id},{guess},{guess_bet,role_id,id},{guild},
					 {guild_member,id,id},{hardtower},{hire},
					 {hirer},{home,id,id},{home_data,id,id},{mail,recv_id,id},{market_selling,seller_id,id},
					 {mount,player_id,id},{obj_buff,player_id,id},{offcast,id,id},
					 {offline_bo},{offstate,id,id},{partner, player_id, id},{partner_hotel, player_id, id},
					 {player_ext, player_id, id},{player_misc, player_id, id},{relation},{relation_info, id, id},
					 {road, player_id, id},{role_dungeon, role_id, id},{role_transport, role_id, id},
					 {server},{shop},{slotmachine, player_id, id},{sprd, player_id, id},{sworn,id,id},
					 {sys_set, player_id, id},{t_ban_chat, role_id, id},{t_ban_ip_list},{t_ban_role, role_id, id},
					 {t_broadcast},{task_auto_trigger, role_id, id},{task_bag, role_id, id},{task_completed, role_id, id},
					 {task_completed_unrepeat, role_id, id},{task_ring, role_id, id},{title, id, id},{tower, id, id},
					 {tve_data},{xinfa, player_id, id},{xs_task},{player,1},{relation,2}	
					],
	
	F = fun(X,Acc) ->
				case X of
					{NewTable,SatisfyCondition,InSatisfyCondition} ->
%% 						S = "mysqldump -u~s -p~s ~s ~s --lock-all-tables -w \"~s in (select ~s from player where lv >= ~w or last_login_time > ~w)\" >> output_data.sql\r\n",
%% 						Args = [UserName,Password,DataBaseName,NewTable,SatisfyCondition,InSatisfyCondition,LastWeekTime],
%% 						Cmd = io_lib:format(S, Args),
						Data = lists:concat(["mysqldump -u",UserName," -p",
											 Password," ", DataBaseName," ",NewTable," --lock-all-tables -w \"",
											 SatisfyCondition," in (select ",InSatisfyCondition," from player where lv >= ",Lv,
											 " or last_login_time > ",LastWeekTime,")\" >> output_data0.sql\n"]),
						lists:append(Acc, Data);						
					{NewTable}  -> 
						Data = lists:concat(["mysqldump -u",UserName," -p",
											 Password," ", DataBaseName," ",NewTable," --lock-all-tables >>  output_data0.sql\n"]),
						lists:append(Acc, Data);
					{NewTable,1} ->
						Data = lists:concat(["mysqldump -u",UserName," -p",
											 Password," ", DataBaseName," ",NewTable," --lock-all-tables  -w \"",
											 " lv >= ",Lv,
											 " or last_login_time > ",LastWeekTime,"\" >> output_data0.sql\n"]),
						lists:append(Acc, Data);
					
					{NewTable,2} ->
						Data = lists:concat(["mysqldump -u",UserName," -p",
											 Password," ", DataBaseName," ",NewTable," --lock-all-tables -w \"",
											 "idA in (select id from player where lv >= ",Lv,
											 " or last_login_time > ",LastWeekTime,") and idB in (select id from player where lv >= ",Lv,
											 " or last_login_time > ",LastWeekTime,")\" >> output_data0.sql\n"]),
						lists:append(Acc, Data)
													
				end
		end,
						
	
	SqlData = lists:foldl(F,"#!/bin/sh\r\n",ConditionList),
	%SqlData = list_to_binary(SqlData0),
	file:write_file("output_data.sh", list_to_binary(SqlData)).
	
	
	
  
    




%% ====================================================================
%% Internal functions
%% ====================================================================


