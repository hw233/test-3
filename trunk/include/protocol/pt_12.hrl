

%%% =======================================
%%% 场景(scene)相关的协议
%%% 分类号:12
%%%
%%% Author: huangjf
%%% Created: 2013.6.17
%%% ======================================


%%% PT: 表示protocol

%%% 普通NPC：是指静态的、一直在场景中存在的功能NPC
%%% 动态NPC：目前有两种，一种是定时刷出和消失的与活动相关的NPC，另一种是会走动的NPC（以下统称为“可移动NPC”）
%%% 注意：为了避免冲突，普通npc的唯一id小于十万，动态npc的唯一id从十万开始！


%% 涉及的宏:
% %% 游戏中的对象类型
% -define(OBJ_INVALID,  0).      % 无效类型（用于程序做判定）
% -define(OBJ_PLAYER,   1).      % 玩家
% -define(OBJ_PARTNER,  2).      % 宠物
% -define(OBJ_NPC,      3).      % NPC
% -define(OBJ_MONSTER,  4).      % 怪物

%% AOI信息变化宏定义
% -define(OI_CODE_BACKWEAR, 151).          % 玩家背饰编号
% -define(OI_CODE_WEAPON, 152).            % 玩家武器编号
% -define(OI_CODE_GUILDNAME, 153).         % 帮派名
% -define(OI_CODE_TITLE, 154).             % 称号


%% --------------- 玩家走动 -------------------------
-define(PT_PLAYER_MOVE, 12001).

%% 协议号:12001
%% c >> s:
%%      SceneId     u32    所在场景的id
%%      NewX        u16    新X坐标
%%      NewY        u16    新Y坐标

%% s >> c:
%%      PlayerId    u64    玩家id
%%      NewX        u16    新X坐标
%%      NewY        u16    新Y坐标







%% --------------- 通知场景玩家：有玩家进入了我的AOI -------------------------
-define(PT_NOTIFY_PLAYERS_ENTER_MY_AOI, 12002).

%% 协议号: 12002
%% s >> c:
%%	    array(
%%	    	Id   		      u64      玩家id
%%	    	X 			      u16      X坐标
%%	    	Y                 u16      Y坐标
%%	    	Race              u8       种族
%%          Faction           u8       门派
%%	    	Lv                u8       等级
%%	    	Sex               u8       性别（1：男，2：女）
%%          PlayerName        string   玩家名字
%%　　　　　GuildName         string   帮派名（如果没加入帮派，则固定返回空字符串）
%%          GraphTitle        u32      当前的图片称号id（如果没有称号，则固定返回0）
%%          TextTitle         u32      当前的文字称号id（如果没有称号，则固定返回0）
%%          UserDefTitle      string   当前的自定义称号（如果没有称号，则固定返回空串）
%%          BackWear          u32      背饰编号
%%          Weapon            u32      武器编号
%%          Headwear          u32      头饰编号
%%          Clothes           u32      服饰编号t
%%          PartnerNo         u32      跟随宠物编号
%%          ParWeapon         u32      跟随武器编号
%%          ParEvolveLv       u8       跟随进化等级
%%          CultivateLv       u8       跟随修炼等级
%%          CultivateLayer    u8       跟随修炼层数
%%          ParQuality        u8       跟随品质
%%          ParName           string   跟随名字
%%          ParClothes        u32      跟随画皮 即衣服
%%          BhvState          u8       玩家行为状态（详见char.hrl的BHV_XXX宏）
%%          VipLv             u8       当前vip等级
%%          IsLeader          u8       是否队长， 1：是， 0：否
%%			TeamId 			  u32	   队伍id，没有则为0
%%			StrenLv 		  u8 	   玩家套装最低强化等级，如果没有套装则是0
%%          array(                     当前buff列表
%%               BuffNo       u32
%%              )
%%          SpouseName      string     配偶名字
%%          MagicKeyNo        u32      法宝编号
%%          MountNo           u32      坐骑编号
%%          MountSkinNo       u16      坐骑皮肤编号
%%          MountStep         u8       坐骑阶数
%%          Popular           u32      人气值
%%			TransfigurationNo u32      变身编号
%%			PaodianType       u32      泡点类型
%%          WingNo            u32      翅膀编号
%%	        )



%% --------------- 通知场景玩家：有玩家离开了我的AOI（主动或者被动离开） -------------------------
-define(PT_NOTIFY_PLAYERS_LEAVE_MY_AOI, 12003).

%% 协议号: 12003
%% s >> c:
%%      array(
%%            PlayerId   u64  玩家id
%%          )




%% --------------- 通知场景玩家：对象（怪物或可移动NPC）走动 -------------------------
-define(PT_NOTIFY_OBJ_MOVE, 12004).

%% 协议号:12004
%% s >> c:
%%      ObjType       u8     对象类型（详见文件开头的宏）
%%      ObjId         u32    对象唯一id（怪物或NPC的唯一id）
%%      NewX          u16    新X坐标
%%      NewY          u16    新Y坐标





%% --------------- 通知场景玩家：有对象（怪物或可移动NPC）进入了我的AOI -------------------------
-define(PT_NOTIFY_OBJS_ENTER_MY_AOI, 12005).

%% 协议号:12005
%% s >> c:
%%      array(
%%            ObjType     			u8      对象类型（详见文件开头的宏）
%%            ObjId       			u32     对象唯一id（怪物或NPC的唯一id）
%%            ObjNo       			u32     对象的编号（怪物或NPC的编号，由策划制定）
%%            X           			u16     对象的X坐标
%%            Y           			u16     对象的Y坐标
%%            TeamId      			u32     对象所属队伍的id（若不属于任何队伍，则固定返回0）对于npc来说,表示称号id,如果没有则为0
%%            OwnerId    			u64     对象所属玩家的id（若不属于任何玩家，则固定返回0）
%%            LeftCanBeKilledTimes  u16     剩余可被杀死的次数，如果不限次数，则返回9999（目前某些怪物有该属性，npc没有，若没有该属性，则固定返回0）
%%            BhvState              u8      对象的行为状态（详见char.hrl的BHV_XXX宏）
%%            String_1              string   aoi显示用的字符串
%%            String_2              string   aoi显示用的字符串
%%          )







%% --------------- 通知场景玩家：有对象（怪物或可移动NPC）离开了我的AOI（主动或者被动离开） -------------------------
-define(PT_NOTIFY_OBJS_LEAVE_MY_AOI, 12006).

%% 协议号:12006
%% s >> c:
%%      array(
%%            ObjType    u8   对象类型（详见文件开头的宏）
%%            ObjId      u32  对象唯一id（怪物或NPC的唯一id）
%%          )




%% --------------- 请求逃离阻挡位置 -------------------------
-define(PT_REQ_LEAVE_BLOCKED_POS, 12007).

%% 协议号: 12007
%% c >> s:
%%      无



%% --------------- 直接传送到目标位置 -------------------------
-define(PT_FORCE_TELEPORT, 12008).

%% 协议号: 12008
%% c >> s:
%%       SceneId    u32   目标场景id
%%       X          u16   X坐标
%%       Y          u16   Y坐标
%%
%% 注：若传送成功则直接返回12011协议， 否则返回失败提示消息协议


%% --------------- 请求传送 -------------------------
-define(PT_REQ_TELEPORT, 12009).

%% 协议号: 12009
%% c >> s:
%%       TeleportNo    u32   传送编号
%%
%% 注：若传送成功则直接返回12011协议， 否则返回失败提示消息协议




%% --------------- 请求普通场景之间跳转（从一个普通场景请求进入另一个普通场景） -------------------------
%% 注意： 这个协议后面会废弃！！
-define(PT_SWITCH_BETWEEN_NORMAL_SCENES, 12010).

%% 协议号:12010
%% c >> s:
%%       NewSceneId     u32     新场景编号
%%
%% 注：若成功则直接返回12011协议， 否则返回失败提示消息协议，失败原因见如下说明
%%


%% 失败原因:
%% PM_LV_LIMIT -- 等级不够
%% TODO: 其他。。。







%% --------------- 通知客户端：切换到新场景（客户端随后发下面三个协议，以查询相关的信息） -------------------------
-define(PT_NOTIFY_SWITCH_TO_NEW_SCENE, 12011).

%% 协议号:12011
%% s >> c:
%%     NewSceneId     u32     新场景的唯一id
%%     NewSceneNo     u32     新场景的编号
%%     NewX           u16     玩家在新场景的X坐标
%%     NewY           u16     玩家在新场景的Y坐标





%% --------------- 加载场景：获取当前所在场景内的动态npc列表（注意：返回的数组中不包括可移动NPC） -------------------------
-define(PT_GET_SCENE_DYNAMIC_NPC_LIST, 12012).

%% 协议号:12012
%% c >> s:
%%		SceneId          u32   当前所在场景唯一id
%% s >> c:
%%      array(
%%            NpcId      u32   npc唯一id
%%            NpcNo      u32   npc编号（由策划制定）
%%            X          u16   npc的X坐标
%%            Y          u16   npc的Y坐标
%%          )



%% --------------- 加载场景：获取当前场景AOI范围的信息（服务端返回AOI范围内的玩家、怪物和可移动NPC列表） -------------------------
-define(PT_GET_SCENE_AOI_INFO, 12013).

%% 协议号:12013
%% c >> s:
%% 		SceneId       u32     当前所在场景唯一id
%% s >> c:
%%      如果AOI范围内没有任何对象，则服务端不返回任何消息
%%      如果有玩家，则返回12002协议
%%      如果有怪物，则再返回12005协议（这时协议中的对象类型都是怪物）
%%      如果有可移动npc，则接着再返回12005协议（这时协议中的对象类型都是npc）




%% --------------- 加载场景：获取当前所在场景内的动态传送点列表（注意：如果场景内没有动态传送点，则服务端不返回协议） -------------------------
-define(PT_GET_SCENE_DYNAMIC_TELEPORTER_LIST, 12014).

%% 协议号: 12014
%% c >> s:
%%		SceneId            u32   当前所在场景唯一id
%% s >> c:
%%      SceneId            u32   当前所在场景唯一id
%%      array(
%%            TeleportNo   u32   动态传送点对应的传送编号
%%            X            u16   动态传送点所在的X坐标
%%            Y            u16   动态传送点所在的Y坐标
%%          )




% 此协议已作废！
% #################### 加载场景信息 （此协议已经拆分成两个协议： 12012， 12013） ##################
% 协议号:12xxx
% c >> s:
%     无
% s >> c:

%     int:16 列表长度
%     array{ 传送阵列表                 -------------- TODO： 这个可以不要
%         int:32 要进入的场景ID
%     string 要进入的场景名字
%     int:16 传送阵坐标x
%     int:16 传送阵坐标y
%     }

%     int:16 列表长度
%     array{ 角色列表
%         cmd:12003
%     }

%     int:16 列表长度
%     array{ 怪物列表
%         int16 X,
%         int16 Y,
%         int32 Id,
%         int32 Mid,
%         int16 Lv,
%         int32 当前名称,
%         int16 速度,
%         int32 资源编号,
%         array{
%         string 怪物对白
%         }
%         int32 是否通关怪
%         int16 准备战斗状态的剩余时间，单位：秒，返回0表示不在准备战斗状态，目前该字段仅仅用于boss
%     }

%     int:16 列表长度
%     array{ npc列表
%     int:32 唯一标识
%         int:32 npc ID
%     string 名字
%     int:16 坐标x
%     int:16 坐标y
%     int:32 资源编号
%     int:32 头顶图标
%     }
%     array{ 交互对象列表          ---- 去掉!
%         int:32 Item ID
%          int:32 类型
%         string 名字
%         int:32 传送阵坐标x
%         int:32 传送阵坐标y
%         int:32 Item资源
%         int:32 是否被占用
%         int32 开启方式
%         int32 开启参数
%         int32  任务ID
%         int32  所需物品类型ID
%     }



















% ##################### NPC显示图标更新 #########################
% 协议号:12xxx
% c >> s:
%     无
% s >> c:
% 	array{	场景NPC列表
%     	int32 唯一标识
%     	int8 任务状态
% 	}







%% --------------- 通知场景玩家：场景内刷出了新对象（怪物或动态NPC）。比如明雷怪死了然后重新刷出 -------------------------
-define(PT_NOTIFY_OBJ_SPAWNED, 12015).

%% 协议号: 12015
%% s >> c:
%%     返回格式和协议PT_NOTIFY_OBJS_ENTER_MY_AOI相同，只是数组长度固定是1




%% --------------- 通知场景玩家：场景内的对象（怪物或动态NPC）消失了。比如明雷怪死了、对象刷出的时间到期了而导致对象消失 -------------------------
-define(PT_NOTIFY_OBJ_CLEARED, 12016).

%% 协议号: 12016
%% s >> c:
%%      ObjType    u8      对象类型(详见文件开头的宏）
%%      ObjId      u32     对象唯一id


%% 玩家/npc/怪物aoi整形信息变化通知
-define(PT_NOTIFY_OBJ_AOI_INFO_CHANGE1, 12017).

%% 协议号: 12017
%% s >> c:
%%     ObjType                u8   对象的类型（见文件开头的宏）
%%     ObjId                  u64  对象的唯一id
%%     array(
%%          Key               u8   信息代号（详见详见文件开头的宏）
%%          NewValue          u32  当前的新值
%%          )


%% 玩家aoi 字符串 信息变化通知， 如称号 帮派名字等
-define(PT_NOTIFY_PLAYER_AOI_INFO_CHANGE2, 12018).

%% 协议号: 12018
%% s >> c:
%%     PlayerId              u64  玩家唯一id
%%     array(
%%          Key               u8      信息代号（详见详见文件开头的宏）
%%          NewInfo           string  当前的新信息
%%          )


%% 主宠物发生变化
-define(PT_NOTIFY_MAIN_PAR_CHANGE, 12019).

%% 协议号: 12019
%% s >> c:
%%     PlayerId          u64      玩家唯一id
%%     PartnerNo         u32      主宠物编号
%%     ParWeapon         u32      主宠武器编号 影响外形
%%     EvolveLv          u8       宠物进化等级 影响外形
%%     CultivateLv       u8       主宠修炼等级
%%     CultivateLayer    u8       主宠修炼层数
%%     ParQuality        u8       主宠品质
%%     PartnerName       string   主宠物名字
%%     ParClothes        u32      主宠画皮 即衣服

%% 玩家战斗外buff消失
-define(PT_NOTIFY_PLAYER_BUFF_VANISH, 12020).

%% 协议号: 12020
%% s >> c:
%%     PlayerId          u64    玩家唯一id
%%     BuffNo            u32      主宠物编号





%% --------------- 通知场景玩家：场景内刷出了动态传送点 -------------------------
-define(PT_NOTIFY_DYNAMIC_TELEPORTER_SPAWNED, 12025).

%% 协议号: 12025
%% s >> c:
%%      SceneId        u32  场景唯一id
%%      TeleportNo     u32  动态传送点对应的传送编号
%%      X              u16  动态传送点所在的X坐标
%%      Y              u16  动态传送点所在的Y坐标




%% --------------- 通知场景玩家：场景内某动态传送点被清除了 -------------------------
-define(PT_NOTIFY_DYNAMIC_TELEPORTER_CLEARED, 12026).

%% 协议号: 12026
%% s >> c:
%%      SceneId        u32  场景唯一id
%%      TeleportNo     u32  动态传送点对应的传送编号
%%      X              u16  动态传送点所在的X坐标
%%      Y              u16  动态传送点所在的Y坐标

%% --------------- 通知全服在线玩家：放烟花 -------------------------
-define(PT_NOTIFY_SERVER_ALL_PLAYER, 12030).

%% 协议号: 12030
%% s >> c:
%%      RetCode         u8
















%% 作废！！
% %% --------------- 仅仅用于服务端自己做调试：为玩家自己刷出明雷怪到场景！ -------------------------
% -define(PT_DBG_SPAWN_MON_TO_SCENE_FOR_PLAYER_WNC, 12998).

% %% 协议号: 12998
% %% c >> s:
% %%      MonNo               u32     怪物编号
% %%      SceneId             u32     场景id







%% --------------- 仅服务端自己调试用的协议：获取场景内的明雷怪列表。 客户端同事不用理会此协议！ -------------------------
-define(PT_DBG_GET_SCENE_MON_LIST, 12999).

%% 协议号: 12999
%% c >> s:
%%      SceneId             u32     场景id

%% s >> c:
%%      SceneId             u8      场景id
%%      array(
%%             MonId        u32     怪物id
%%             MonNo        u32     怪物编号
%%     	       X            u16     X坐标
%%             Y            u16     Y坐标
%%             Lv           u8      等级
%%             BMonGroupNo  u32     对应的战斗怪物组编号
%%             Name         string  名字
%%           )
%%

