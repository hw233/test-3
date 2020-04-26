%%%------------------------------------------------
%%% File    : test_client_base.hrl
%%% Author  : huangjf 
%%% Created : 2013.8.1
%%% Description: 基础客户端测试程序
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__TEST_CLIENT_BASE_H__).
-define(__TEST_CLIENT_BASE_H__, 0).




%% 模拟客户端存储的玩家数据结构体
-record(client_ps, {
        id = 0,                 % 玩家id
        race = 0,
        faction = 0,
        sex = 0,
        lv = 0,

        scene_id = 0,
        scene_no,
        x = 0,
        y = 0,

        exp = 0,
        exp_lim = 0,

        hp = 0,
        hp_lim = 0,
        mp = 0,
        mp_lim = 0,
        
        yuanbao = 0,
        bind_yuanbao = 0,
        gamemoney = 0,
        bind_gamemoney = 0,

        guild_name = "",
        title = "",

        phy_att = 0,
        mag_att = 0,

        phy_def = 0,
        mag_def = 0,

        hit = 0,
        dodge = 0,
        crit = 0,
        ten = 0,

        anger = 0,
        anger_lim = 0,

        luck = 0,
        act_speed = 0,
        move_speed = 0,

        talent_str = 0,
        talent_con = 0,
        talent_sta = 0,
        talent_spi = 0,
        talent_agi = 0,
        free_talent_points = 0,

        battle_power = 0,

        guild_id = 0

    }).



%% 进程字典的key名 (KN: key name)
-define(PDKN_ALREADY_CREATED_PS_ETS, pdkn_clinet_ps). 


%% PDKN: process dict key name(进程字典的key名)
-define(PDKN_CONN_SOCKET, pdkn_conn_socket).  % 与服务器连接的socket
-define(PDKN_LOGIN_PLAYERID, pdkn_login_player_id).  % 玩家自己的id
-define(PDKN_LOGIN_SCENE_ID, pdkn_login_scene_id).   % 玩家初始所在的场景id
-define(PDKN_C2S_CUR_PROTO_SEQ_NUM, pdkn_c2s_cur_proto_seq_num).   % 发给服务端的协议的序列号（递增）

-define(TEST_CLIENT_LOG_FILE, "e:/test_client.dbg_log").










-endif.  %% __TEST_CLIENT_BASE_H__
