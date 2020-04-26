%%%---------------------------------------
%%% @Module  : data_special_config
%%% @Author  : lds
%%% @Email   : 
%%% @Description:  游戏特殊配置表
%%%---------------------------------------


-module(data_special_config).
-include("common.hrl").
-include("record.hrl").
-compile(export_all).


get('integral_ratio') ->
	100
	;

get('ernie_no') ->
	62379
	;

get('horn') ->
	1000000000
	;

get('creat_lv1_group') ->
	300
	;

get('creat_lv2_group') ->
	300
	;

get('paodian_born_x') ->
	46
	;

get('paodian_born_y') ->
	32
	;

get('paodian_reborn') ->
	[{46, 32},{28, 44},{20, 35},{32, 29},{42, 44}]

	;

get('dragonball_limit') ->
	99
	;

get('paodian_mail_title') ->
	"蟠桃盛宴奖励"
	;

get('paodian_mail_content') ->
	"大侠在蟠桃盛宴活动中夺回了~p个蟠桃。天庭对你的英勇战斗赞赏有加，向你发放~p个武勋。武勋可以在汉中城武状元处兑换丰厚奖励"
	;

get('home_map') ->
	6001
	;

get('friend_steal_proba') ->
	30
	;

get('stranger_steal_proba') ->
	80
	;

get('steal_num_proba') ->
	20
	;

get('guess_mail_title') ->
	"竞猜奖励"
	;

get('guess_mail_content') ->
	"恭喜大侠在~s竞猜活动中竞猜成功，特此奖励你~p奖杯，~p水玉！欢迎继续参与下期竞猜，祝你游戏愉快"
	;

get('jiangbei') ->
	89059
	;

get('guess_min_goods_reward') ->
	10
	;

get('guess_min_money_reward') ->
	10000
	;

get('guess_mail_paybacktitle') ->
	"竞猜反还"
	;

get('guess_mail_paybackcontent') ->
	"由于系统错误~s竞猜活动自动关闭，特此反还你~p奖杯，~p水玉！欢迎继续参与下期竞猜，祝你游戏愉快"
	;

get('internal_skill_eat_cost') ->
	100000
	;

get('qujing_reset') ->
	2000
	;

get('guild_dungeon_mail_title') ->
	"帮派副本奖励"
	;

get('guild_dungeon_mail_content') ->
	"感谢大侠在帮派副本中做出的贡献，现根据贡献值给您发放奖励！"
	;

get('one_draw_cost') ->
	{62379,1}
	;

get('ten_draw_cost') ->
	{62379,9}
	;

get('one_draw_point') ->
	10
	;

get('ten_draw_point') ->
	100
	;

get('server_talk') ->
	{89058,10}
	;

get('70573') ->
	{70573, 62349, 3}
	;

get('70574') ->
	{70574, 62349, 5}
	;

get('70575') ->
	{70575, 62349, 10}
	;

get('exchange_num1') ->
	1
	;

get('exchange_num2') ->
	10
	;

get('exchange_num3') ->
	100
	;

get('break_lv') ->
	200
	;

get('mount_num') ->
	50
	;

get('fudai_mail') ->
	"中秋快乐，祝大侠中秋节节日快乐,以下为大侠购买的福袋，祝大家能开出令自己心满意足的东西"
	;

get('fudai_mail_title') ->
	"中秋福袋"
	;

get('3V3_start_time') ->
	19
	;

get('3V3_end_time') ->
	20
	;

get('3V3_chuanqi_score') ->
	{10,2700}
	;

get('3V3_open_lv') ->
	150
	;

get('fudai') ->
	{1,188,91849,91876}
	;

get('lucky_value') ->
	1000
	;

get('wish_num') ->
	5000
	;

get('auto_use_goods') ->
	[{89127,2},{89128,5},{89129,8},{89130,12}]
	;

get('chat_condition') ->
	30
	;

get('wish_score') ->
	150
	;

get('get_bangding') ->
	81410
	;

get('monopoly_ticket') ->
	200
	;

get('monopoly_dice_price') ->
	20
	;

get('monoticket_moneytype') ->
	"积分"
	;

get('monodice_moneytype') ->
	"积分"
	;

get('timetask_exreward') ->
	3500
	;

get('reset') ->
	50
	;

get('reset_start') ->
	100
	;

get('normal_huanjing') ->
	{62582,100}
	;

get('hard_huanjing') ->
	{62582,300}
	;

get('nightmare_huanjing') ->
	{62582,500}
	;

get('mijing_reset_cost') ->
	200
	;

get('huanjing_reset_cost') ->
	500
	;

get('unlimit_shuiyu_price') ->
	{89058, 1000000}
	;

get('unlimit_xiulian_price') ->
	{89058, 500000}
	;

get('unlimit_money_type') ->
	{1,2,9,10043,60101,62032}
	;

get('optional_draw_one_cost') ->
	3000
	;

get('optional_draw_ten_cost') ->
	21600
	;

get('optional_draw_reset') ->
	50
	;

get('unlimit_jinbi_price') ->
	100
	;

get('five_elements_identification') ->
	{62603,2}
	;

get('five_elements_replace') ->
	{62603,3}
	;

get('reincarnation_exchange_ratio') ->
	10000
	;

get('reincarnation_upper_limit') ->
	300
	;

get('fabao_add_spirit_value') ->
	[{120055, 20},{120056, 50}]
	;

get('fabao_growth_float_value') ->
	0.200000
	;

get('fabao_magic_skill_book_point') ->
	[{120057, 5},{120058, 10},{120059, 20}]
	;

get('fabao_magic_skill_point_reset_cost') ->
	{120060,1}
	;

get('recast_addi_coef') ->
	[{1,0.35,1},{2,0.35,1},{3,0.35,1},{4,0.35,1},{5,0.35,1},{6,0.35,1}]
	;

get('equip_build_lv_selcet') ->
	{80,100,120,140,160,180,200,220,240,260,280,300,320,340,360}
	;

get('partner_grow_coef') ->
	{0.35,1}
	;

get('partner_aptitude_coef') ->
	{0.25,1}
	;

get('partner_wash_cost') ->
	{50366,1}
	;

get('partner_attribute_coef') ->
	{0.15,1000,0,2500}
	;

get('anger_resume_set') ->
	{150,30,30}
	;

get('partner_expend_skill_goods') ->
	[{12,50366,1},{13,50366,5},{14,50366,15}]
	;

get('partner_expend_skill_cult') ->
	[{7,0.2},{8,0.1},{9,0.05},{10,0.04},{11,0.04},{12,0},{13,0},{14,0}]
	;

get('normal_attack_scaling') ->
	1
	;

get('min_dam_scaling') ->
	-0.7
	;

get('init_crit_coef') ->
	0.500000
	;

get('max_crit_coef') ->
	2.500000
	;

get('min_pursue_att_dam_coef') ->
	-0.6
	;

get('seal_operation_coef') ->
	{2.5,5,0.8,0.005}
	;

get('seal_type_coef') ->
	[{stun,1},{trance,1.5},{silence,1.2},{chaos,0.8}]
	;

get('combo_att_time') ->
	{1,1}
	;

get('total_target_count_absorb_hp') ->
	{1,0.5}
	;

get('offline_reward_time_lim') ->
	60
	;

get('offline_reward_lv_lim') ->
	80
	;

get('offline_award_exp') ->
	2
	;

get('offline_acc_time_lim') ->
	21600
	;

get('guild_slogan') ->
	[{"长期招收活跃玩家，勤做帮派任务"},{"休闲养老玩家请进，和谐挂机轻松游戏"},{"高战活跃玩家请进，一起打造最强帮派"}]
	;

get('quit_guild_join_cd') ->
	43200
	;

get('reset_talent') ->
	{10072,10071}
	;

get('faction_change_cost') ->
	[{1,3,500},{1,3,1000},{1,3,2000}]
	;

get('mount_level_exp') ->
	[{20013,300}]
	;

get('mount_step_exp') ->
	[{20003,1},{20007,1},{20011,1},{20017,1},{20023,1}]
	;

get('mount_transform_cost') ->
	[{1,2,1000},{2,3,100},{3,3,200},{4,3,400},{5,3,600},{6,3,1000},{7,3,1500},{8,3,2000}]
	;

get('mount_attr_reset_cost') ->
	[{0,20022,1},{1,89002,200}]
	;

get('guild_shop_refresh_time') ->
	[{00,00},{08,00},{12,00},{16,00},{20,00},[24,00]]
	;

get('guild_shop_buy_join_time_limit') ->
	43200
	;

get('create_guild_cost') ->
	{3,3000}
	;

get('add_huoli_cost') ->
	60022
	;

get('create_role_reward') ->
	2
	;

get('equip_fixed_attr') ->
	[{204126,[{base_equip_add,[{phy_att,63291},{mag_att,63291},{seal_hit,6064}]},{addi_equip_add,[{phy_att,6068},{mag_att,6068},{seal_hit,1517},{phy_crit,26},{mag_crit,26}]},{addi_equip_eff_no,9000}]},{204176,[{base_equip_add,[{phy_att,63291},{mag_att,63291},{seal_hit,6064}]},{addi_equip_add,[{phy_att,6068},{mag_att,6068},{seal_hit,1517},{phy_crit,26},{mag_crit,26}]},{addi_equip_eff_no,9000}]},{204226,[{base_equip_add,[{phy_att,63291},{mag_att,63291},{seal_hit,6064}]},{addi_equip_add,[{phy_att,6068},{mag_att,6068},{seal_hit,1517},{phy_crit,26},{mag_crit,26}]},{addi_equip_eff_no,9000}]},{204276,[{base_equip_add,[{phy_att,63291},{mag_att,63291},{seal_hit,6064}]},{addi_equip_add,[{phy_att,6068},{mag_att,6068},{seal_hit,1517},{phy_crit,26},{mag_crit,26}]},{addi_equip_eff_no,9000}]},{204326,[{base_equip_add,[{phy_att,63291},{mag_att,63291},{seal_hit,6064}]},{addi_equip_add,[{phy_att,6068},{mag_att,6068},{seal_hit,1517},{phy_crit,26},{mag_crit,26}]},{addi_equip_eff_no,9000}]},{204376,[{base_equip_add,[{phy_att,63291},{mag_att,63291},{seal_hit,6064}]},{addi_equip_add,[{phy_att,6068},{mag_att,6068},{seal_hit,1517},{phy_crit,26},{mag_crit,26}]},{addi_equip_eff_no,9000}]},{201026,[{base_equip_add,[{hp_lim,210965},{act_speed,4220},{seal_resis,2636}]},{addi_equip_add,[{talent_con,18},{talent_con,18},{talent_agi,18},{phy_ten,38},{mag_ten,38}]},{addi_equip_eff_no,9000}]},{202026,[{base_equip_add,[{hp_lim,210965},{mag_def,31644},{seal_resis,2636}]},{addi_equip_add,[{talent_sta,18},{talent_spi,18},{be_phy_dam_reduce_coef,0.028},{be_mag_dam_reduce_coef,0.028},{hp_lim,60686}]},{addi_equip_eff_no,9000}]},{203026,[{base_equip_add,[{phy_def,35947},{act_speed,4794},{seal_resis,5991}]},{addi_equip_add,[{talent_con,18},{talent_agi,18},{talent_agi,18},{hp_lim,60686},{phy_def,12137}]},{addi_equip_eff_no,9000}]},{206026,[{base_equip_add,[{phy_att,42193},{mag_att,42193},{seal_hit,4485}]},{addi_equip_add,[{talent_con,18},{talent_spi,18},{talent_spi,18},{phy_crit,26},{mag_crit,26}]},{addi_equip_eff_no,9000}]},{205026,[{base_equip_add,[{hp_lim,105485},{phy_def,31644},{mag_def,31644}]},{addi_equip_add,[{talent_str,18},{talent_con,18},{talent_spi,18},{phy_ten,38},{mag_ten,38}]},{addi_equip_eff_no,9000}]}]
	;

get('succinct_transfer_limit') ->
	{5,2,2}
	;

get('succinct_transfer_cost') ->
	[{1,3,100},{2,3,100},{3,3,200}]
	;

get('zhenyaota_tiaoceng') ->
	0.700000
	;

get('shuxing_renxuan') ->
	55109
	;

get('tower_ghost_init_times') ->
	10
	;

get('tower_ghost_resotre_internal') ->
	7200
	;

get('world_boss_hp') ->
	 {2100000000,100000}
	;

get('gongfa_exp') ->
	[{1,20},{2,50},{3,100},{4,500},{5,3000},{6,10000}]
	;

get('gongfa_tunshi') ->
	0.600000
	;

get('gongfa_beibao') ->
	{100,27}
	;

get(_Arg) ->
	null.
	
