%%%---------------------------------------
%%% @Module  : data_achievement
%%% @Author  : lds
%%% @Email   : 
%%% @Description:  成就
%%%---------------------------------------


-module(data_achievement).
-include("common.hrl").
-include("achievement.hrl").
-compile(export_all).

get_achievement_no(lv)->
	[1,11,21,31,41,51,61];
get_achievement_no(join_team)->
	[2];
get_achievement_no(join_guild)->
	[3];
get_achievement_no(dati_10_right)->
	[4];
get_achievement_no(xinfa_skill)->
	[5];
get_achievement_no(submit_task_ex)->
	[6,16,29,33,53];
get_achievement_no(business_buy)->
	[7];
get_achievement_no(change_title)->
	[8];
get_achievement_no(world_talk)->
	[9];
get_achievement_no(add_friend)->
	[10];
get_achievement_no(stren_equip)->
	[12,102];
get_achievement_no(senior_find_par)->
	[13];
get_achievement_no(get_reward)->
	[14];
get_achievement_no(guild_skill)->
	[15];
get_achievement_no(shopcost)->
	[17];
get_achievement_no(transport)->
	[18];
get_achievement_no(use_ernie)->
	[19];
get_achievement_no(partner_join_battle)->
	[20,24,34,35,44];
get_achievement_no(battle_power_reach)->
	[22,32,42,52,62];
get_achievement_no(use_laba)->
	[23];
get_achievement_no(inlay_gemstone)->
	[25,105];
get_achievement_no(involve_recharge)->
	[26];
get_achievement_no(equip_improve_qual)->
	[27];
get_achievement_no(use_goods)->
	[28,36];
get_achievement_no(perfect_find_par)->
	[30];
get_achievement_no(pass_dun)->
	[37,55];
get_achievement_no(mount_lv)->
	[38];
get_achievement_no(par_passive_skills)->
	[39];
get_achievement_no(wear_equip)->
	[40,45,57,64,65];
get_achievement_no(submit_task)->
	[43];
get_achievement_no(evolve_partner)->
	[46];
get_achievement_no(par_active_skill)->
	[47];
get_achievement_no(get_neigong)->
	[48];
get_achievement_no(pass_tower)->
	[49];
get_achievement_no(mount_skill)->
	[50];
get_achievement_no(equip_attr_wash)->
	[54];
get_achievement_no(equip_texiao_wash)->
	[56];
get_achievement_no(feisheng)->
	[58];
get_achievement_no(mount_step_up)->
	[59];
get_achievement_no(stren_neigong)->
	[60];
get_achievement_no(cultivate_new)->
	[63];
get_achievement_no(pass_qujing)->
	[66];
get_achievement_no(get_wuxing)->
	[67];
get_achievement_no(pass_binglin)->
	[68];
get_achievement_no(offline_arena)->
	[69];
get_achievement_no(join_dun)->
	[70];
get_achievement_no(upgrade_role_skill)->
	[100];
get_achievement_no(feed_pet)->
	[101];
get_achievement_no(set_pet_battler)->
	[103,106,109];
get_achievement_no(feed_mount)->
	[104];
get_achievement_no(apply_join_guild)->
	[107];
get_achievement_no(equip_build)->
	[108];
get_achievement_no(jiadian_renwu)->
	[110];
get_achievement_no(jiadian_chongwu)->
	[111];
get_achievement_no(xilian_zuoqi)->
	[112];
get_achievement_no(jineng_chongwu)->
	[113];
get_achievement_no(huodong_dati)->
	[114];
get_achievement_no(jineng_shenghuo)->
	[115];
get_achievement_no(huodong_tianti)->
	[116];
get_achievement_no(goumai_shanghui)->
	[117];
get_achievement_no(huodong_zhenyaota)->
	[118];

get_achievement_no(_Arg) ->
    null.
          
 
get_achievement(1) -> 
    #achievement{
        no = 1
		,name = <<"等级提升">>
		,type = 0		
        ,event_type = lv       
        ,condition = [{num, {60, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(2) -> 
    #achievement{
        no = 2
		,name = <<"并肩作战">>
		,type = 0		
        ,event_type = join_team       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(3) -> 
    #achievement{
        no = 3
		,name = <<"加入帮派">>
		,type = 0		
        ,event_type = join_guild       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(4) -> 
    #achievement{
        no = 4
		,name = <<"每日答题">>
		,type = 0		
        ,event_type = dati_10_right       
        ,condition = []        
        ,num_limit = 10
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(5) -> 
    #achievement{
        no = 5
		,name = <<"初窥门径">>
		,type = 0		
        ,event_type = xinfa_skill       
        ,condition = [{xinfa_lv,{40, 1}},{num,{1,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(6) -> 
    #achievement{
        no = 6
		,name = <<"师门建设">>
		,type = 0		
        ,event_type = submit_task_ex       
        ,condition = [{no,[4]}]        
        ,num_limit = 10
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(7) -> 
    #achievement{
        no = 7
		,name = <<"商行天下">>
		,type = 0		
        ,event_type = business_buy       
        ,condition = [{num,{1, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(8) -> 
    #achievement{
        no = 8
		,name = <<"称号达人">>
		,type = 0		
        ,event_type = change_title       
        ,condition = [{num,{1, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(9) -> 
    #achievement{
        no = 9
		,name = <<"世界发言">>
		,type = 0		
        ,event_type = world_talk       
        ,condition = [{num,{1, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(10) -> 
    #achievement{
        no = 10
		,name = <<"添加好友">>
		,type = 0		
        ,event_type = add_friend       
        ,condition = [{num,{1, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(11) -> 
    #achievement{
        no = 11
		,name = <<"等级提升">>
		,type = 0		
        ,event_type = lv       
        ,condition = [{num, {120, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(12) -> 
    #achievement{
        no = 12
		,name = <<"强化装备">>
		,type = 0		
        ,event_type = stren_equip       
        ,condition = [{stren_lv, {5,1}},{num,{1,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(13) -> 
    #achievement{
        no = 13
		,name = <<"高级招募">>
		,type = 0		
        ,event_type = senior_find_par       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(14) -> 
    #achievement{
        no = 14
		,name = <<"活跃达人">>
		,type = 0		
        ,event_type = get_reward       
        ,condition = [{no, [41124]}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(15) -> 
    #achievement{
        no = 15
		,name = <<"帮派技能">>
		,type = 0		
        ,event_type = guild_skill       
        ,condition = [{guild_skill_lv,{40,1}},{num,{1,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(16) -> 
    #achievement{
        no = 16
		,name = <<"帮派建设">>
		,type = 0		
        ,event_type = submit_task_ex       
        ,condition = [{no,[3]}]        
        ,num_limit = 10
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(17) -> 
    #achievement{
        no = 17
		,name = <<"商城消费">>
		,type = 0		
        ,event_type = shopcost       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(18) -> 
    #achievement{
        no = 18
		,name = <<"运镖达人">>
		,type = 0		
        ,event_type = transport       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(19) -> 
    #achievement{
        no = 19
		,name = <<"幸运转盘">>
		,type = 0		
        ,event_type = use_ernie       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(20) -> 
    #achievement{
        no = 20
		,name = <<"门客成群">>
		,type = 0		
        ,event_type = partner_join_battle       
        ,condition = [{quality,{1,0}},{num,{2,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(21) -> 
    #achievement{
        no = 21
		,name = <<"等级提升">>
		,type = 0		
        ,event_type = lv       
        ,condition = [{num, {140, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(22) -> 
    #achievement{
        no = 22
		,name = <<"个人评分">>
		,type = 0		
        ,event_type = battle_power_reach       
        ,condition = [{num,{50000,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(23) -> 
    #achievement{
        no = 23
		,name = <<"梦幻声音">>
		,type = 0		
        ,event_type = use_laba       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(24) -> 
    #achievement{
        no = 24
		,name = <<"门客成群">>
		,type = 0		
        ,event_type = partner_join_battle       
        ,condition = [{quality,{2,0}},{num,{3,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(25) -> 
    #achievement{
        no = 25
		,name = <<"体验镶嵌">>
		,type = 0		
        ,event_type = inlay_gemstone       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(26) -> 
    #achievement{
        no = 26
		,name = <<"江湖名俊">>
		,type = 0		
        ,event_type = involve_recharge       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(27) -> 
    #achievement{
        no = 27
		,name = <<"装备品质">>
		,type = 0		
        ,event_type = equip_improve_qual       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(28) -> 
    #achievement{
        no = 28
		,name = <<"藏宝猎人">>
		,type = 0		
        ,event_type = use_goods       
        ,condition = [{no, [10044]}]        
        ,num_limit = 10
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(29) -> 
    #achievement{
        no = 29
		,name = <<"捉鬼大师">>
		,type = 0		
        ,event_type = submit_task_ex       
        ,condition = [{no,[6]}]        
        ,num_limit = 10
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(30) -> 
    #achievement{
        no = 30
		,name = <<"完美招募">>
		,type = 0		
        ,event_type = perfect_find_par       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(31) -> 
    #achievement{
        no = 31
		,name = <<"等级提升">>
		,type = 0		
        ,event_type = lv       
        ,condition = [{num, {160, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(32) -> 
    #achievement{
        no = 32
		,name = <<"个人评分">>
		,type = 0		
        ,event_type = battle_power_reach       
        ,condition = [{num,{100000,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(33) -> 
    #achievement{
        no = 33
		,name = <<"宝图达人">>
		,type = 0		
        ,event_type = submit_task_ex       
        ,condition = [{no,[7]}]        
        ,num_limit = 10
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(34) -> 
    #achievement{
        no = 34
		,name = <<"门客成群">>
		,type = 0		
        ,event_type = partner_join_battle       
        ,condition = [{quality,{2,0}},{num,{4,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(35) -> 
    #achievement{
        no = 35
		,name = <<"门客修炼">>
		,type = 0		
        ,event_type = partner_join_battle       
        ,condition = [{cultivate_lv,{2,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(36) -> 
    #achievement{
        no = 36
		,name = <<"门客技能">>
		,type = 0		
        ,event_type = use_goods       
        ,condition = [{no, [50398]}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(37) -> 
    #achievement{
        no = 37
		,name = <<"困难副本">>
		,type = 0		
        ,event_type = pass_dun       
        ,condition = [{no, [2002,2012,2022,2032,2042,4002,4012,4022,4032,4042]}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(38) -> 
    #achievement{
        no = 38
		,name = <<"坐骑升级">>
		,type = 0		
        ,event_type = mount_lv       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(39) -> 
    #achievement{
        no = 39
		,name = <<"门客学习">>
		,type = 0		
        ,event_type = par_passive_skills       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(40) -> 
    #achievement{
        no = 40
		,name = <<"强化达人">>
		,type = 0		
        ,event_type = wear_equip       
        ,condition = [{stren_lv, {10,1}}, {num, {6,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(41) -> 
    #achievement{
        no = 41
		,name = <<"等级提升">>
		,type = 0		
        ,event_type = lv       
        ,condition = [{num, {180, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(42) -> 
    #achievement{
        no = 42
		,name = <<"个人评分">>
		,type = 0		
        ,event_type = battle_power_reach       
        ,condition = [{num,{150000,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(43) -> 
    #achievement{
        no = 43
		,name = <<"门派挑战">>
		,type = 0		
        ,event_type = submit_task       
        ,condition = [{no, [1300001,1300002,1300003,1300004,1300005,1300006,1300007]}]        
        ,num_limit = 5
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(44) -> 
    #achievement{
        no = 44
		,name = <<"门客成群">>
		,type = 0		
        ,event_type = partner_join_battle       
        ,condition = [{quality,{3,0}},{num,{5,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(45) -> 
    #achievement{
        no = 45
		,name = <<"装备品质">>
		,type = 0		
        ,event_type = wear_equip       
        ,condition = [{quality,{3,0}},{num,{6,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(46) -> 
    #achievement{
        no = 46
		,name = <<"门客官阶">>
		,type = 0		
        ,event_type = evolve_partner       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(47) -> 
    #achievement{
        no = 47
		,name = <<"门客学习">>
		,type = 0		
        ,event_type = par_active_skill       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(48) -> 
    #achievement{
        no = 48
		,name = <<"内功修炼">>
		,type = 0		
        ,event_type = get_neigong       
        ,condition = []        
        ,num_limit = 10
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(49) -> 
    #achievement{
        no = 49
		,name = <<"勇者之塔">>
		,type = 0		
        ,event_type = pass_tower       
        ,condition = [{num,{30,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(50) -> 
    #achievement{
        no = 50
		,name = <<"坐骑技能">>
		,type = 0		
        ,event_type = mount_skill       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(51) -> 
    #achievement{
        no = 51
		,name = <<"等级提升">>
		,type = 0		
        ,event_type = lv       
        ,condition = [{num, {200, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(52) -> 
    #achievement{
        no = 52
		,name = <<"个人评分">>
		,type = 0		
        ,event_type = battle_power_reach       
        ,condition = [{num,{200000,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(53) -> 
    #achievement{
        no = 53
		,name = <<"三界修炼">>
		,type = 0		
        ,event_type = submit_task_ex       
        ,condition = [{no,[17]}]        
        ,num_limit = 10
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(54) -> 
    #achievement{
        no = 54
		,name = <<"装备属性">>
		,type = 0		
        ,event_type = equip_attr_wash       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(55) -> 
    #achievement{
        no = 55
		,name = <<"卓越副本">>
		,type = 0		
        ,event_type = pass_dun       
        ,condition = [{no, [2003,2013,2023,2033,2043,4003,4013,4023,4033,4043]}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(56) -> 
    #achievement{
        no = 56
		,name = <<"装备特效">>
		,type = 0		
        ,event_type = equip_texiao_wash       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(57) -> 
    #achievement{
        no = 57
		,name = <<"强化大师">>
		,type = 0		
        ,event_type = wear_equip       
        ,condition = [{stren_lv, {20,1}}, {num, {6,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(58) -> 
    #achievement{
        no = 58
		,name = <<"飞升修炼">>
		,type = 0		
        ,event_type = feisheng       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(59) -> 
    #achievement{
        no = 59
		,name = <<"坐骑升阶">>
		,type = 0		
        ,event_type = mount_step_up       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(60) -> 
    #achievement{
        no = 60
		,name = <<"强化内功">>
		,type = 0		
        ,event_type = stren_neigong       
        ,condition = [{neigong_lv,{10, 1}},{num,{1,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(61) -> 
    #achievement{
        no = 61
		,name = <<"等级提升">>
		,type = 0		
        ,event_type = lv       
        ,condition = [{num, {220, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(62) -> 
    #achievement{
        no = 62
		,name = <<"个人评分">>
		,type = 0		
        ,event_type = battle_power_reach       
        ,condition = [{num,{300000,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(63) -> 
    #achievement{
        no = 63
		,name = <<"修炼大师">>
		,type = 0		
        ,event_type = cultivate_new       
        ,condition = [ {lv,{5,1}},{num,{4,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(64) -> 
    #achievement{
        no = 64
		,name = <<"神兵在手">>
		,type = 0		
        ,event_type = wear_equip       
        ,condition = [{quality,{4,1}},{num,{6,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(65) -> 
    #achievement{
        no = 65
		,name = <<"强化大师">>
		,type = 0		
        ,event_type = wear_equip       
        ,condition = [{stren_lv, {30,1}}, {num, {6,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(66) -> 
    #achievement{
        no = 66
		,name = <<"取经之路">>
		,type = 0		
        ,event_type = pass_qujing       
        ,condition = [{num,{10, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(67) -> 
    #achievement{
        no = 67
		,name = <<"内功大师">>
		,type = 0		
        ,event_type = get_wuxing       
        ,condition = [{num,{5, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(68) -> 
    #achievement{
        no = 68
		,name = <<"兵临围城">>
		,type = 0		
        ,event_type = pass_binglin       
        ,condition = [{num,{10, 1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(69) -> 
    #achievement{
        no = 69
		,name = <<"角斗竞技">>
		,type = 0		
        ,event_type = offline_arena       
        ,condition = [{num,{1, 1}}]        
        ,num_limit = 10
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(70) -> 
    #achievement{
        no = 70
		,name = <<"世界BOSS">>
		,type = 0		
        ,event_type = join_dun       
        ,condition = [{no, [110001,110002]}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 0
		,contri = 0
    }       
        ;
 
get_achievement(100) -> 
    #achievement{
        no = 100
		,name = <<"技能等级">>
		,type = 0		
        ,event_type = upgrade_role_skill       
        ,condition = [{num, {2,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(101) -> 
    #achievement{
        no = 101
		,name = <<"宠物喂养">>
		,type = 0		
        ,event_type = feed_pet       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(102) -> 
    #achievement{
        no = 102
		,name = <<"强化装备">>
		,type = 0		
        ,event_type = stren_equip       
        ,condition = [{num, {1,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(103) -> 
    #achievement{
        no = 103
		,name = <<"第二宠物">>
		,type = 0		
        ,event_type = set_pet_battler       
        ,condition = [{num, {2,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(104) -> 
    #achievement{
        no = 104
		,name = <<"坐骑喂养">>
		,type = 0		
        ,event_type = feed_mount       
        ,condition = [{num, {2,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(105) -> 
    #achievement{
        no = 105
		,name = <<"宝石镶嵌">>
		,type = 0		
        ,event_type = inlay_gemstone       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(106) -> 
    #achievement{
        no = 106
		,name = <<"第三宠物">>
		,type = 0		
        ,event_type = set_pet_battler       
        ,condition = [{num, {3,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(107) -> 
    #achievement{
        no = 107
		,name = <<"加入帮派">>
		,type = 0		
        ,event_type = apply_join_guild       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(108) -> 
    #achievement{
        no = 108
		,name = <<"装备打造">>
		,type = 0		
        ,event_type = equip_build       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(109) -> 
    #achievement{
        no = 109
		,name = <<"第四宠物">>
		,type = 0		
        ,event_type = set_pet_battler       
        ,condition = [{num, {4,1}}]        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(110) -> 
    #achievement{
        no = 110
		,name = <<"完成1次人物加点">>
		,type = 0		
        ,event_type = jiadian_renwu       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(111) -> 
    #achievement{
        no = 111
		,name = <<"完成1次宠物加点">>
		,type = 0		
        ,event_type = jiadian_chongwu       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(112) -> 
    #achievement{
        no = 112
		,name = <<"完成1次坐骑洗炼">>
		,type = 0		
        ,event_type = xilian_zuoqi       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(113) -> 
    #achievement{
        no = 113
		,name = <<"学习1次宠物技能">>
		,type = 0		
        ,event_type = jineng_chongwu       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(114) -> 
    #achievement{
        no = 114
		,name = <<"参与1次每日答题">>
		,type = 0		
        ,event_type = huodong_dati       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(115) -> 
    #achievement{
        no = 115
		,name = <<"提升1次任意生活技能">>
		,type = 0		
        ,event_type = jineng_shenghuo       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(116) -> 
    #achievement{
        no = 116
		,name = <<"参与1次天梯赛">>
		,type = 0		
        ,event_type = huodong_tianti       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(117) -> 
    #achievement{
        no = 117
		,name = <<"商会购买1次任意物品">>
		,type = 0		
        ,event_type = goumai_shanghui       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;
 
get_achievement(118) -> 
    #achievement{
        no = 118
		,name = <<"挑战1次镇妖塔">>
		,type = 0		
        ,event_type = huodong_zhenyaota       
        ,condition = []        
        ,num_limit = 1
		,add_attr = []
		,reward = 300103
		,contri = 0
    }       
        ;

get_achievement(_Arg) ->
    ?ASSERT(false, [_Arg]),
    null.
		  
get_nos()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118].

