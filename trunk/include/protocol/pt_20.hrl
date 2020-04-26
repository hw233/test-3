
%%% =================================
%%% 战斗系统相关协议
%%% 2012.4.20  ---- huangjf
%%% Modified: 2013.7.29
%%% =================================

%% pt: 表示protocol
%% bt: 表示battle


%% 策划认为的战场中的位置排布：

%      左方                 右方
%     4    9       |       9    4
%     2    7       |       7    2
%     1    6       |       6    1
%     3    8       |       8    3
%     5    10      |       10   5


%% 程序认为的战场中的位置排布：

%      左方                 右方
%     6    1       |       1    6
%     7    2       |       2    7
%     8    3       |       3    8
%     9    4       |       4    9
%     10   5       |       5    10



%% ---------- 玩家触发战斗：打明雷怪 -----------------
-define(PT_BT_START_MF, 20001).

%% 协议号: 20001
%% c >> s:
%%     MonId    u32    明雷怪id
%%	   Difficulty u8   难度，默认发1



%% ---------- 告诉前端战斗类型 ------------------
-define(PT_TELL_BT_TYPE, 20003).

%S >> C


%% ---------- 玩家发起PK邀请 -----------------
-define(PT_BT_START_PK, 20002).

%% 协议号: 20002
%% c >> s:
%%     TargetPlayerId    u64    目标玩家id
%%     PK_Type           u8     PK类型（1：切磋，2：强行PK，即决斗）

%% s >> c:
%%     RetCode           u8     若发起PK邀请成功则返回0，否则不返回，而是直接发送失败提示消息协议
%%     TargetPlayerId    u64    目标玩家id
%%     PK_Type           u8     PK类型（1：切磋，2：强行PK，即决斗）



%% ---------- 询问是否接受PK邀请 -----------------
-define(PT_BT_ASK_IF_ACCPET_PK, 20065).

%% 协议号: 20065
%% s >> c:
%%     FromPlayerId       u64       主动发起PK的玩家id
%%     FromPlayerName     string    主动发起PK的玩家名字
%%     PK_Type            u8        PK类型（1：切磋）
%%     IsFromPlayerInTeam u8        发起PK的玩家是否在队伍中（1：是，0：否）
%%     FromPlayerCount    u8        发起PK的玩家所在队伍的人数（如果不在队伍，则固定返回1）



%% ---------- 玩家回复PK邀请 -----------------
-define(PT_BT_REPLY_PK_INVITE, 20066).

%% 协议号: 20066
%% c >> s:
%%     ReplyCode         u8      回复代号（1：同意，2：拒绝）
%%     FromPlayerId      u64     发起PK邀请的玩家id
%%     PK_Type           u8      PK类型（1：切磋）



%% ---------- 通知客户端：对方拒绝了PK邀请 -----------------
-define(PT_BT_NOTIFY_PK_INVITE_REFUSED, 20067).

%% 协议号: 20067
%% s >> c:
%%     TargetPlayerId        u64       拒绝PK邀请的玩家id
%%     TargetPlayerName      string    拒绝PK邀请的玩家名字
%%     PK_Type               u8        PK类型（1：切磋）



%% ---------- 通知客户端：战斗开始（客户端收到此协议后，发20007协议向服务端查询战场描述信息） -----------------
-define(PT_BT_NOTIFY_BATTLE_START, 20005).

%% 协议号: 20005
%% s >> c:
%%     无




%% ---------- 通知客户端：战斗结束 -----------------
-define(PT_BT_NOTIFY_BATTLE_FINISH, 20006).

%% 协议号: 20006
%% s >> c:
%%     WinSide     u8      胜利方（1:主队，2：客队， 0：平局）




%% ---------- 查询战场描述信息 -----------------
-define(PT_BT_QRY_BATTLE_FIELD_DESC, 20007).

%% 协议号: 20007
%% c >> s:
%%     无

%% s >> c:
%%     BattleId             	   u32       战斗id
%%     BattleType           	   u8        战斗类型
%%     BattleSubType        	   u8        战斗子类型
%%     MyBoId               	   u16       玩家本人的战斗对象id
%%     HostZf                      u32       主队阵法
%%     GuestZf                     u32       客队阵法
%%     array(                       主队的战斗对象信息（打怪时，玩家方是在主队，怪物方是在客队）
%%            BoId         		   u16       战斗对象id
%%            BoType        	   u8        战斗对象类型（1：玩家，2：宠物，3：NPC，4：怪物，5：普通boss， 7：雇佣玩家，8：世界boss） 
%%            OwnerPlayerBoId	   u16       所属玩家的bo id，目前是用于表明战场上的宠物的归属，对于非宠物bo，统一返回0
%%            Pos           	   u8        战斗位置（1~15）
%%            Name          	   string    名字
%%            Sex           	   u8        性别（1：男，2：女）
%%            Race          	   u8        种族
%%            Faction       	   u8        门派
%%            Lv            	   u16        等级
%%            ParentObjId   	   u64       父对象id（对于玩家bo，表示对应的玩家id，对于怪物bo，表示对应的战斗怪模板编号， 对于宠物bo，表示对应的宠物id）
%%            ParentPartnerNo      u32       宠物bo对应的父宠物对象的编号（策划所配置的编号）， 如果不是宠物bo，则统一返回0
%%            Hp            	   u32       当前血量
%%            HpLim         	   u32       血量上限
%%            Mp            	   u32       当前魔法值
%%            MpLim         	   u32       魔法上限
%%            Anger         	   u32       当前怒气值
%%            AngerLim      	   u32       怒气上限
%%            Weapon               u32       武器对应的物品编号（若没有则返回0）
%%            HeadWear             u32       头饰对应的物品编号（若没有则返回0）
%%            Clothes              u32       服饰对应的物品编号（若没有则返回0）
%%            BackWear             u32       背饰对应的物品编号（若没有则返回0）
%%            ParCultivateLv       u8        宠物的修炼等级（如果不是宠物，固定返回0）
%%            ParCultivateLayer    u8        宠物的修炼层数（如果不是宠物，固定返回0，如果是宠物，但没有修炼过，也返回0）
%%            ParEvolveLv          u8        宠物的进化等级（如果不是宠物，固定返回0）
%%            ParNature            u8        宠物性格（如果不是宠物，固定返回0）
%%            ParQuality           u8        宠物的品质（1：白  2: 绿  3: 蓝  4: 紫  5: 橙  6: 红），如果不是宠物，则固定返回0
%%			  ParAwakeIllusion	   u8		  宠物的觉醒幻化等级（0表示无）（如果不是宠物，固定返回0）
%%            IsMainPar            u8        是否为主宠（1：是， 0：否）
%%            IsInvisible          u8        是否有隐身状态（1：是，0：否）
%%            InvisibleExpireRound u16       隐身状态的到期回合（表示到了该回合，隐身状态即消失），如果没有隐身状态，则返回0
%%            SuitNo               u8        套装编号（若没有则返回0）
%%            GraphTitle           u32       当前的图片称号id（若没有则返回0）
%%            TextTitle            u32       当前的文字称号id（若没有则返回0）
%%            UserDefTitle         string    当前的自定义称号（若没有则返回空串）
%%            OnlineFlag           u8        在线标记（1：在线，2：离线）
%%            IsPlotBo             u8        是否剧情bo（1：是，0：否）
%%            CanBeCtrled          u8        是否可操控（1：是，0：否），目前仅针对剧情bo，如果不是剧情bo，则统一返回0
%%            array(
%%                   BuffNo        u32       buff编号
%%                   ExpireRound   u16	     buff的到期回合（表示到了该回合，buff即消失）
%%                 )
%%            MagicKeyNo           u32       法宝编号 （若没有则返回0）
%% 				phy_att			u32	
%% 				mag_att			u32	
%% 				phy_def			u32	
%% 				mag_def			u32	
%%	        )
%%     array(                       客队的战斗对象信息（格式同上）
%%            ...
%%          )




%%-------- 通知客户端：某战斗对象已经准备好了（即已经下达当前回合的指令了） -------------
-define(PT_BT_NOTIFY_BO_IS_READY, 20008).

%% 协议号: 20008
%% s >> c:
%%    BoId          u16	      刚做好准备的战斗对象id
%%    CmdType       u8        下达的指令类型（1:使用技能，2: 使用物品， 3:防御，4：保护，5：逃跑，6：捕捉宠物，7：召唤宠物，8：普通攻击）
%%    CmdPara       u64       参数（若是使用技能，表示技能id，若是使用物品，表示所使用物品的编号，若是召唤宠物，表示要召唤的宠物id，其他情况则统一发0）


%% ---------- 通知客户端：当前回合的行动开始（服务端随后会开始发送一系列的战报） -----------------
-define(PT_BT_NOTIFY_ROUND_ACTION_BEGIN, 20009).

%% 协议号: 20009
%% s >> c:
%%     无



%% ---------- 通知客户端：当前回合的行动结束（表明当前回合的战报已发送完毕） -----------------
-define(PT_BT_NOTIFY_ROUND_ACTION_END, 20010).

%% 协议号: 20010
%% s >> c:
%%     无



%% ---------- 通知客户端：新回合开始（如果玩家非自动战斗，则客户端收到此协议后重新显示操作的倒计时，以备玩家下达新回合的指令） -----------------
-define(PT_BT_NOTIFY_NEW_ROUND_BEGIN, 20011).

%% 协议号: 20011
%% s >> c:
%%     NewRoundCounter     u16    新回合的计数（表示当前到了第几回合）


%% !!!!!注：buff结算是在新回合开始后就立即做的!!!!!

%% ---------- 通知客户端：buff结算开始（服务端随后会开始发送一系列与buff结算相关的协议） -----------------
-define(PT_BT_NOTIFY_SETTLE_BUFF_BEGIN, 20012).

%% 协议号: 20012
%% s >> c:
%%     无


%% ---------- 通知客户端：buff结算结束 -----------------
-define(PT_BT_NOTIFY_SETTLE_BUFF_END, 20013).

%% 协议号: 20013
%% s >> c:
%%     无


%% ---------- 通知客户端：所有bo的当前回合的对话气泡ai的信息（注意：如果全部bo在当前回合都没有对话气泡ai，则服务端不返回此协议） -----------------
-define(PT_BT_NOTIFY_TALK_AI_INFO, 20014).

%% 协议号: 20014
%% s >> c:
%%     array(
%%             BoId                u16     bo id
%%             array(
%%	                   WhenToTalk  u8      冒对话气泡的时机： 1 => 回合开始时， 2 => 实际行动时
%%                     TalkCont    u16     对话内容的编号
%%	                )	
%%			)


%% ---------- 通知客户端：新回合开始的相关工作已处理完毕 -----------------
-define(PT_BT_NOTIFY_ON_NEW_ROUND_BEGIN_JOBS_DONE, 20089).

%% 协议号: 20089
%% s >> c:
%%     无


%% ---------- 客户端通知服务端：播放战报完毕 -----------------
-define(PT_BT_C2S_NOTIFY_SHOW_BR_DONE, 20090).  % C2S: client to server

%% 协议号: 20090
%% s >> c:
%%     无


%% ---------- 服务端通知客户端：某bo播放战报完毕 -----------------
-define(PT_BT_S2C_NOTIFY_BO_SHOW_BR_DONE, 20091).  % S2C: server to client

%% 协议号: 20091
%% s >> c:
%%     BoId      u16      播放完战报的玩家所对应的战斗对象id



%% ---------- 通知客户端：某bo的在线状态改变了 -----------------
-define(PT_BT_NOTIFY_BO_ONLINE_FLAG_CHANGED, 20092).

%% 协议号: 20092
%% s >> c:
%%     BoId      u16      战斗对象id
%%     NewFlag   u8       新的在线状态（1：在线，2：离线）





%% ---------- 发送战报给客户端：执行物理攻击 -----------------
-define(PT_BT_NOTIFY_BR_DO_PHY_ATT, 20015).  % BR: battle report

%% 协议号: 20015
%% s >> c:
%%     CurActorId       u16        当前行动者的id（战斗对象id）
%%	   CmdType          u8         实际所执行的指令类型（1:使用技能，2: 使用物品， 3:防御，4：保护，5：逃跑，6：捕捉宠物，7：召唤宠物，8：普通攻击）
%%     CmdPara          u64        实际所执行的指令参数（若为使用技能，则表示技能id， 若为使用物品，则表示物品id，其他则统一发0）
%%     CurPickTarget    u16        下达指令时所选的目标战斗对象id，没有则发0
%%	   array(                      战报数组（战报格式见如下说明）
%%           ...                   
%%	       )

%% 执行物理攻击， 格式如下：
%%          ReportType       		   u8     战报类型（固定为1，表示是bo执行物理攻击）
%%          AttSubType       		   u8     攻击子类型（0: 无意义，1: 普通攻击，2：反击， 3：连击， 4：追击）
%%          AttResult        		   u8     攻击结果（1：命中，2：闪避，3：暴击）

%%          AtterId          		   u16    攻击者的bo id（bo id表示battle object's id，即战斗对象的id，下同）
%%         	DeferId          		   u16    防守者的bo id
%%          ProtectorId      		   u16    保护者的bo id，如果没有保护者，则统一返回0
%%          
%%          DamToDefer       		   int32  对防守者的伤害值，如果为负数，则表示加血，所加的值为对应的绝对值
%%          DamToDefer_Mp       	   int32  对防守者的伤害值（伤蓝），如果为负数，则表示加蓝，所加的值为对应的绝对值
%%          DamToDefer_Anger           int32  对防守者的伤害值（减少怒气），如果为负数，则表示加怒气，所加的值为对应的绝对值
%%          DamToProtector   		   u32    对保护者的伤害值
%%          DamToProtector_Anger   	   u32    对保护者的伤害值（减少怒气），如果为负数，则表示加怒气，所加的值为对应的绝对值
%%          RetDam           		   u32    反弹的伤害值（对攻击者造成伤害），如果没有，则固定为0
%%          RetDam_Anger           	   u32    反弹的伤害值（对攻击者造成伤害），如果没有，则固定为0 （减少怒气），如果为负数，则表示加怒气，所加的值为对应的绝对值

%%          AbsorbedHp                 u32    攻击者吸血的数值（如果没有吸血，则返回0）

%%          AtterHpLeft     		   u32    攻击者的剩余血量
%%          AtterMpLeft     		   u32    攻击者的剩余魔法
%%          AtterAngerLeft  		   u32    攻击者的剩余怒气
%%          AtterDieStatus             u8     攻击者的死亡状态（0：未死亡，1：死亡并且进入倒地状态，2：死亡并且进入鬼魂状态， 3：死亡并且直接消失）
%%          IsAtterApplyReborn         u8     攻击者是否应用了重生效果（1：是，0：否）

%%          DeferHpLeft     		   u32    防守者的剩余血量
%%          DeferMpLeft     		   u32    防守者的剩余魔法
%%          DeferAngerLeft             u32    防守者的剩余怒气
%%          DeferDieStatus             u8     防守者的死亡状态（0：未死亡，1：死亡并且进入倒地状态，2：死亡并且进入鬼魂状态， 3：死亡并且直接消失）
%%          IsDeferApplyReborn         u8     防守者是否应用了重生效果（1：是，0：否）

%%          ProtectorHpLeft 		   u32    保护者的剩余血量，如果没有保护者，则统一返回0
%%          ProtectorAngerLeft         u32    保护者的剩余怒气，如果没有保护者，则统一返回0
%%          ProtectorDieStatus         u8     保护者的死亡状态（0：未死亡，1：死亡并且进入倒地状态，2：死亡并且进入鬼魂状态， 3：死亡并且直接消失），如果没有保护者，则统一返回0
%%          IsProtectorApplyReborn     u8     保护者是否应用了重生效果（1：是，0：否），如果没有保护者，则统一返回0

%% 			array(                            攻击者新加的buff列表（通常是增益buff）
%%              Boid                  u16
%%                array(
%%                    AtterBuffAdded        bin    buff详情（二进制流，下同，格式见下面的说明）
%%                     )
%%            )
%%
%% 			array(                            攻击者移除的buff列表（通常是增益buff）
%%              Boid                  u16
%%                array(
%%                    AtterBuffRemoved        bin    buff详情（二进制流，下同，格式见下面的说明）
%%                     )
%%            )


%%          array(                            防守者更新的buff列表（通常是护盾类buff）
%%               DeferBuffUpdated      bin    buff详情
%%              )

%%          array(                            保护者移除的buff列表（通常是因死亡而导致移除的buff）
%%               ProtectorBuffRemoved  u32    buff编号
%%              )
%%          array(
%%               boid                  u16
%%               type                  u8           1代表加血，2代表伤害
%%               Dam_Hp                32           伤害值
%%               Bo_HpLeft             32           剩余血量
%%               Bo_DieStatus    u8                 玩家的死亡状态（0：未死亡，1：死亡并且进入倒地状态，2：死亡并且进入鬼魂状态， 3：死亡并且直接消失）
%%                Bo_IsApplyReborn  u8              临时受害者是否应用了重生效果（1：是，0：否）
%%               )
%%          array(                                  溅射伤害信息列表
%%               BeSplashBo_Id                 u16     被溅射者的bo id
%%               SplashDam_Hp                  u32     溅射伤害值（伤血）
%%               SplashDam_Mp                  u32     溅射伤害值（伤蓝）
%%               SplashDam_Anger               u32     溅射伤害值（减少怒气，负数表示增加怒气）
%%               BeSplashBo_HpLeft             u32     被溅射者的剩余血量
%%               BeSplashBo_MpLeft             u32     被溅射者的剩余蓝量
%%               BeSplashBo_AngerLeft          u32     被溅射者的剩余怒气
%%               BeSplashBo_DieStatus          u8      被溅射者的死亡状态（0：未死亡，1：死亡并且进入倒地状态，2：死亡并且进入鬼魂状态， 3：死亡并且直接消失）
%%               BeSplashBo_IsApplyReborn      u8      被溅射者是否应用了重生效果（1：是，0：否）
%%               array(                             被溅射者移除的buff列表
%%                     BeSplashBo_BuffRemoved  u32     buff编号
%%                   )
%%	            )
%%



%% buff详情的二进制流格式：

%%    BuffNo         u32      buff编号，如果为0，表明这是为了容错（出bug了，或者buff所属的bo死亡消失了，但要保持协议二进制流格式的正确性）而填充的伪buff详情，客户端应该忽略它
%%    ExpireRound    u16      buff的到期回合（表示buff到了该回合即过期）， 若是永久性buff（战斗结束或死亡后才移除），则返回一个比较大的数值（大于9999）
%%    OverlapCount   u8       buff当前的叠加层数（不可叠加的buff固定返回1），对于护盾类buff，表示护盾剩余的层数

%%                            如果buff不可叠加，则以下都统一返回0
%%    Para1_Type     u8       buff参数1的类型（0:表示参数无意义，1：整数，2：百分比。下同）
%%    Para1_Value    u32      buff参数1的值（如果是百分比，则返回的是一个放大100倍后的整数，比如：0.32对应返回的是32，下同）
%%    Para2_Type     u8       buff参数2的类型
%%    Para2_Value    u32      buff参数2的值




%% ---------- 发送战报给客户端：执行（一轮）法术攻击 -----------------
-define(PT_BT_NOTIFY_BR_DO_MAG_ATT, 20016).  % BR: battle report

%% 协议号: 20016
%% s >> c:
%%     CurActorId       u16        当前行动者的id（战斗对象id）
%%	   CmdType          u8         指令类型（1:使用技能，2: 使用物品， 3:防御，4：保护，5：逃跑，6：捕捉宠物, 7:技能第二次效果）
%%     CmdPara          u64        指令参数（若为使用技能，则表示技能id， 若为使用物品，则表示物品id，其他则统一发0）
%%     CurPickTarget    u16        下达指令时所选的目标战斗对象id，没有则发0
%%	   array(                      战报数组（战报格式见如下说明）
%%           ...                   
%%	       )

%% 执行（一轮）法术攻击， 格式如下：
%%          ReportType       		        u8     战报类型（固定为2，表示是bo执行法术攻击）
%%          IsComboAtt       		        u8     此轮攻击是否为连击(1:是，0：否)
%%          AtterId                         u16    攻击者的bo id
%%          array(                                 攻击者新加的buff列表（通常是增益buff）
%%               AtterBuffAdded             bin    buff详情（二进制流，格式见20015协议中的说明）
%%              )
%% 			array(                                 攻击者移除的buff列表
%%               AtterBuffRemoved           u32    buff编号  
%%              )
%%          array(  对多个目标的伤害详情列表
%%	             DeferId                    u16    防守者的bo id
%%               AttResult                  u8     攻击结果（1：命中，2：闪避，3：暴击）
%%               DamToDefer       	        int32  对防守者的伤害值，如果为负数，则表示加血，所加的值为对应的绝对值
%%				 DamToDefer_Mp       	    int32  对防守者的伤害值（伤蓝），如果为负数，则表示加蓝，所加的值为对应的绝对值
%%				 DamToDefer_Anger       	int32  对防守者的伤害值（伤蓝），如果为负数，则表示加蓝，所加的值为对应的绝对值

%%               AbsorbedHp                    u32    攻击者吸血的数值（如果没有吸血，则返回0）

%%               AtterHpLeft     	        u32    攻击者的剩余血量
%%               AtterMpLeft     		    u32    攻击者的剩余魔法
%%               AtterAngerLeft  		    u32    攻击者的剩余怒气
%%               AtterDieStatus             u8     攻击者的死亡状态（0：未死亡，1：死亡并且进入倒地状态，2：死亡并且进入鬼魂状态， 3：死亡并且直接消失）
%%          IsAtterApplyReborn        		u8     攻击者是否应用了重生效果（1：是，0：否）

%%          	RetDam           		   u32    反弹的伤害值（对攻击者造成伤害），如果没有，则固定为0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         		RetDam_Anger           	   u32    反弹的伤害值（对攻击者造成伤害），如果没有，则固定为0 （减少怒气），如果为负数，则表示加怒气，所加的值为对应的绝对值 

%%               DeferHpLeft     		    u32    防守者的剩余血量
%%               DeferMpLeft     		    u32    防守者的剩余魔法
%%               DeferAngerLeft             u32    防守者的剩余怒气
%%               DeferDieStatus             u8     防守者的死亡状态（0：未死亡，1：死亡并且进入倒地状态，2：死亡并且进入鬼魂状态， 3：死亡并且直接消失）
%%               IsDeferApplyReborn         u8     防守者是否应用了重生效果（1：是，0：否）


%% 			array(                            攻击者新加的buff列表（通常是增益buff）
%%               AtterBuffAdded        bin    buff详情（二进制流，下同，格式见下面的说明）
%%              )
%% 			array(                            攻击者移除的buff列表
%%               AtterBuffRemoved      u32    buff编号  
%%              )

%%               array(                            防守者新加的buff列表（通常是减益buff）
%%                    DeferBuffAdded        bin    buff详情
%%                   )
%%               array(                            防守者移除的buff列表（通常是护盾类buff或增益buff）
%%                    DeferBuffRemoved      u32    buff编号
%%                   )
%%               array(                            防守者更新的buff列表（通常是护盾类buff） 
%%                    DeferBuffUpdated      bin    buff详情  
%%                   )
%%              )

%%          array(
%%               boid                  u16
%%               type                  u8           1代表加血，2代表伤害
%%               Dam_Hp                32           伤害值
%%               Bo_HpLeft             32           剩余血量
%%               Bo_DieStatus    u8                 玩家的死亡状态（0：未死亡，1：死亡并且进入倒地状态，2：死亡并且进入鬼魂状态， 3：死亡并且直接消失）
%%               Bo_IsApplyReborn  u8              临时受害者是否应用了重生效果（1：是，0：否）
%%               )

%%          array(                                  溅射伤害信息列表
%%               BeSplashBo_Id                 u16     被溅射者的bo id
%%               SplashDam_Hp                  u32     溅射伤害值（伤血）
%%               SplashDam_Mp                  u32     溅射伤害值（伤蓝）
%%               SplashDam_Anger               u32     溅射伤害值（减少怒气，负数表示增加怒气）
%%               BeSplashBo_HpLeft             u32     被溅射者的剩余血量
%%               BeSplashBo_MpLeft             u32     被溅射者的剩余蓝量
%%               BeSplashBo_AngerLeft          u32     被溅射者的剩余怒气
%%               BeSplashBo_DieStatus          u8      被溅射者的死亡状态（0：未死亡，1：死亡并且进入倒地状态，2：死亡并且进入鬼魂状态， 3：死亡并且直接消失）
%%               BeSplashBo_IsApplyReborn      u8      被溅射者是否应用了重生效果（1：是，0：否）
%%               array(                             被溅射者移除的buff列表
%%                     BeSplashBo_BuffRemoved  u32     buff编号
%%                   )
%%	            )




%% ---------- 发送战报给客户端：施法（释放或驱散buff） -----------------
-define(PT_BT_NOTIFY_BR_CAST_BUFFS, 20017).  % BR: battle report

%% 协议号: 20017
%% s >> c:
%%     CurActorId       u16        当前行动者的id（战斗对象id）
%%	   CmdType          u8         指令类型（1:使用技能，2: 使用物品， 3:防御，4：保护，5：逃跑，6：捕捉宠物）
%%     CmdPara          u64        指令参数（若为使用技能，则表示技能id， 若为使用物品，则表示物品id，其他则统一发0）
%%     CurPickTarget    u16        下达指令时所选的目标战斗对象id，没有则发0
%%	   array(                      战报数组（战报格式见如下说明）
%%           ...                   
%%	       )

%% 施法--释放或驱散buff， 格式如下：
%%          ReportType       		 u8     战报类型（固定为3，表示是bo释放或驱散buff）
%%          CasterId          		 u16    施法者的bo id
%%      	CastResult          	 u8     施法结果（0：成功，1：失败）
%%          NeedPerfCasting          u8     客户端是否需要做对应的施法表现？（1：是，0：否）
%%          CasterHpLeft             u32    施法者的剩余血量
%%          CasterMpLeft             u32    施法者的剩余蓝量
%%          CasterAngerLeft          u32    施法者的剩余怒气
%% 			array(                          施法详情
%%                TargetBoId         u16    目标bo id
%%                array(                    目标新加的buff列表
%%                     BuffAdded	 bin    buff详情（二进制流，格式见20015协议中的说明）
%%                    )
%%                array(                    目标移除的buff列表
%%                     BuffRemoved	 u32    buff编号
%%                    )
%%                array(                    目标更新的buff列表
%%                     BuffUpdated	 bin	buff详情
%%                    )
%%              )


%% ---------- 发送战报给客户端：战斗对象逃跑 -----------------
-define(PT_BT_NOTIFY_BR_ESCAPE, 20018).  % BR: battle report

%% 协议号: 20018
%% s >> c:
%%     CurActorId       u16        当前行动者的id（战斗对象id）
%%	   CmdType          u8         指令类型（1:使用技能，2: 使用物品， 3:防御，4：保护，5：逃跑，6：捕捉宠物）
%%     CmdPara          u64        指令参数（若为使用技能，则表示技能id， 若为使用物品，则表示物品id，其他则统一发0）
%%     CurPickTarget    u16        下达指令时所选的目标战斗对象id，没有则发0
%%	   array(                      战报数组（战报格式见如下说明）
%%           ...                   
%%	       )

%% 逃跑， 格式如下：
%%          ReportType       	u8     战报类型（固定为7，表示是bo逃跑）
%%          BoId          		u16    逃跑者的bo id
%%      	Result          	u8     逃跑结果（0：成功，1：失败）





%% ---------- 发送战报给客户端：治疗 -----------------
-define(PT_BT_NOTIFY_BR_HEAL, 20019).  % BR: battle report

%% 协议号: 20019
%% s >> c:
%%     CurActorId       u16        当前行动者的id（战斗对象id）
%%	   CmdType          u8         指令类型（1:使用技能，2: 使用物品， 3:防御，4：保护，5：逃跑，6：捕捉宠物）
%%     CmdPara          u64        指令参数（若为使用技能，则表示技能id， 若为使用物品，则表示物品id，其他则统一发0）
%%     CurPickTarget    u16        下达指令时所选的目标战斗对象id，没有则发0
%%	   array(                      战报数组（战报格式见如下说明）
%%           ...                   
%%	       )

%% 治疗， 格式如下：
%%          ReportType       	     u8     战报类型（固定为4，表示是bo执行治疗）
%%          HasReviveEff             u8     是否附带复活效果（1：是，0：否）
%%          HealType                 u8     治疗类型（1：加血， 2：加蓝, 3：加血加蓝）
%%          CastResult               u8     施法结果（0：成功，1：失败）
%%          HealerHpLeft             u32    治疗者（即当前行动者）的剩余血量
%%          HealerMpLeft             u32    治疗者（即当前行动者）的剩余蓝量
%%          HealerAngerLeft          u32    治疗者（即当前行动者）的剩余怒气
%%          array(
%%               TargetBoId          u16    目标bo id
%%               IsCannotBeHeal      u8     目标是否无法被治疗（1：是，0：否），如果目标无法被治疗，则客户端无视以下返回的信息
%%               HealVal             u32    治疗量
%%      	     NewHp               u32    目标新的血量
%%      	     NewMp               u32    目标新的蓝量
%%               NewAnger            u32    目标新的怒气
%%               array(                     目标新加的buff列表
%%					  BuffAdded      bin    buff详情（二进制流，格式见20015协议中的说明）
%%                   )
%%               array(						目标移除的buff列表
%%                    BuffRemoved    u32    buff编号 
%%                   )
%%              )


%% ---------- 发送战报给客户端：使用物品 -----------------
-define(PT_BT_NOTIFY_BR_USE_GOODS, 20020).  % BR: battle report

%% 协议号: 20020
%% s >> c:
%%     CurActorId       u16        当前行动者的id（战斗对象id）
%%	   CmdType          u8         指令类型（1:使用技能，2: 使用物品， 3:防御，4：保护，5：逃跑，6：捕捉宠物）
%%     CmdPara          u64        指令参数（若为使用技能，则表示技能id， 若为使用物品，则表示物品id，其他则统一发0）
%%     CurPickTarget    u16        下达指令时所选的目标战斗对象id，没有则发0
%%	   array(                      战报数组（战报格式见如下说明）
%%           ...                   
%%	       )

%% 使用物品， 格式如下：
%%          ReportType         u8      战报类型（固定为9，表示是bo使用物品）
%%          GoodsId            u64     物品id
%%          GoodsNo            u32     物品编号
%%          HasReviveEff       u8     是否附带复活效果（1：是，0：否）
%%          TargetBoId         u16     目标bo id
%%          HealVal_Hp         u32     治疗量（hp），如果没有，则返回0
%%          HealVal_Mp         u32     治疗量（mp），如果没有，则返回0
%%          HealVal_Anger      u32     治疗量（怒气），如果没有，则返回0
%%          NewHp              u32     目标新的血量  
%%          NewMp              u32     目标新的蓝量
%%          NewAnger           u32     目标新的怒气值
%%          array(                     目标新加的buff列表
%%				 BuffAdded     bin     buff详情（二进制流，格式见20015协议中的说明）
%%              )
%%          array(                     目标移除的buff列表
%%               BuffRemoved   u32     buff编号
%%              )
%%          array(                     自己新加的buff列表
%%				 BuffAdded     bin     buff详情（二进制流，格式见20015协议中的说明）
%%              )
%%          array(                     自己移除的buff列表
%%               BuffRemoved   u32     buff编号
%%              )


%% ---------- 发送战报给客户端：召唤bo -----------------
-define(PT_BT_NOTIFY_BR_SUMMON, 20021).  % BR: battle report

%% 协议号: 20021
%% s >> c:
%%     CurActorId       u16        当前行动者的id（战斗对象id）
%%	   CmdType          u8         指令类型（1:使用技能，2: 使用物品， 3:防御，4：保护，5：逃跑，6：捕捉宠物）
%%     CmdPara          u64        指令参数（若为使用技能，则表示技能id， 若为使用物品，则表示物品id，其他则统一发0）
%%     CurPickTarget    u16        下达指令时所选的目标战斗对象id，没有则发0
%%	   array(                      战报数组（战报格式见如下说明）
%%           ...                   
%%	       )

%% 召唤bo， 格式如下：
%%          ReportType                 u8        战报类型（固定为6，表示是召唤bo）
%%          Result                     u8        召唤结果（0：成功，1：失败），如果失败，则后面的数组固定为空数组
%%          array(
%%                NewBoId              u16       新召唤bo的id
%%                Side                 u8        新召唤bo的所属方（1：主队，2：客队）
%%                Type         	       u8        新召唤bo的类型（1：玩家，2：宠物，3：npc，4：怪物，5：boss）
%%                OwnerPlayerBoId	   u16       ......... 所属玩家的bo id，目前是用于表明战场上的宠物的归属，对于非宠物bo，统一返回0
%%                Pos                  u8        ......... 位置（1~15）
%%                Name          	   string    ......... 名字
%%                Sex           	   u8        ......... 性别（1：男，2：女）
%%                Race          	   u8        ......... 种族
%%                Faction       	   u8        ......... 门派
%%                Lv            	   u16        ......... 等级
%%                ParentObjId   	   u64       ......... 父对象id（对于玩家bo，表示对应的玩家id，对于怪物bo，表示对应的战斗怪模板编号， 对于宠物bo，表示对应的宠物id）
%%                ParentPartnerNo      u32       ......... 宠物bo对应的父宠物对象的编号（策划所配置的编号）， 如果不是宠物bo，则统一返回0
%%                Hp            	   u32       ......... 当前血量
%%                HpLim         	   u32       ......... 血量上限
%%                Mp            	   u32       ......... 当前魔法值
%%                MpLim         	   u32       ......... 魔法上限
%%                Anger         	   u32       ......... 当前怒气值
%%                AngerLim      	   u32       ......... 怒气上限
%%            	  ParCultivateLv       u8        新召唤宠物的修炼等级（如果不是宠物，固定返回0）
%%            	  ParCultivateLayer    u8        新召唤宠物的修炼层数（如果不是宠物，固定返回0，如果是宠物，但没有修炼过，也返回0）
%%                ParEvolveLv          u8        新召唤宠物的进化等级（如果不是宠物，固定返回0）
%%                ParNature            u8        新召唤宠物性格（如果不是宠物，固定返回0）
%%                ParQuality           u8        宠物的品质（1：白  2: 绿  3: 蓝  4: 紫  5: 橙  6: 红），如果不是宠物，则固定返回0
%%			  	  ParAwakeIllusion	   u8		  宠物的觉醒幻化等级（0表示无）（如果不是宠物，固定返回0）
%%                IsMainPar            u8        是否主宠（1：是，0：否）
%%                IsInvisible          u8        是否有隐身状态（1：是，0：否）
%%            	  InvisibleExpireRound u16       隐身状态的到期回合（表示到了该回合，隐身状态即消失），如果没有隐身状态，则返回0
%%				  Weapon               u32       武器对应的物品编号（若没有则返回0）
%%                HeadWear             u32       头饰对应的物品编号（若没有则返回0）
%%                Clothes              u32       服饰对应的物品编号（若没有则返回0）
%%                BackWear             u32       背饰对应的物品编号（若没有则返回0）
%%				  phy_att			u32	
%% 				  mag_att			u32	
%% 				  phy_def			u32	
%% 				  mag_def			u32	
%%            		array(
%%                		BuffNo        u32       buff编号
%%                 		ExpireRound   u16	     buff的到期回合（表示到了该回合，buff即消失）
%%                 	)
%%              )




%% TODO: 其他类型的行为....
%% ....





%% ---------- 下达指令：空指令（当bo在新回合无法行动，或者因自动战斗等原因而导致不需下达任何指令时，客户端通过发此协议来模拟下达指令，以推动服务端继续执行战斗流程 -----------------
-define(PT_BT_NOP_CMD, 20029).

%% 协议号: 20029
%% c >> s:
%%    ForBoId        u16      表示是为哪个bo下指令

%% s >> c:
%%    RetCode        u8       成功则返回0，否则返回对应的失败原因代号（见下面的宏定义）
%%    ForBoId        u16      表示是为哪个bo下指令


% 涉及的失败原因：
% PC: prepare cmd
-define(PC_FAIL_UNKNOWN, 1).  				% 未知错误
-define(PC_FAIL_ALRDY_DONE, 2).  			% 已经下过指令了，不需再下达
-define(PC_FAIL_SKILL_CDING, 3).  			% 技能正在冷却中
-define(PC_FAIL_SKILL_ID_INVALID, 4).  		% 技能id非法
-define(PC_FAIL_BATTLE_ALRDY_ENDS, 5).  	% 战斗已经结束，操作无效
-define(PC_FAIL_SHOULD_NOT_NOP, 6).     	% 不应该下达空指令过来
-define(PC_FAIL_SHOULD_BE_NOP, 7).  		% 应该下达空指令过来
-define(PC_FAIL_SERVER_NOT_WAITING_CLIENTS_FOR_PREPARE_CMD_DONE, 8).   % 服务端当前并不处于等待客户端下指令的状态
-define(PC_FAIL_TARGET_NOT_EXISTS, 9).      % 所选的目标不存在（如：所要保护的目标不存在）
-define(PC_FAIL_WRONG_PROTEGE, 10).         % 所保护的目标不正确（如：试图保护自己或者敌方的bo）
-define(PC_FAIL_NO_SUCH_GOODS, 11).			% 没有这个物品
-define(PC_FAIL_GOODS_CANNOT_USE_IN_BATTLE, 12).  % 物品不能在战斗中使用
-define(PC_FAIL_WRONG_CAMP_FOR_USE_GOODS, 13).  % 使用物品时，所选目标的阵营不对（如：物品配置为只能对友方使用，但所选目标是敌方）
-define(PC_FAIL_WRONG_TARGET_OBJ_TYPE_FOR_USE_GOODS, 14).  % 使用物品时，所选目标的对象类型不对（如：物品配置为只能对玩家使用，但所选目标是宠物）
-define(PC_FAIL_NO_SUCH_PARTNER, 15).					% 没有这个宠物
-define(PC_FAIL_PARTNER_ALRDY_JOINED_BATTLE, 16).		% 宠物已经出战过了，不能被召唤
-define(PC_FAIL_HAS_NOT_SUCH_SKILL, 17).				% 你没有这个技能
-define(PC_FAIL_LV_LIMIT_FOR_USE_GOODS, 18).			% 使用物品时，等级不够
-define(PC_FAIL_CANNOT_USE_GOODS_IN_OFFLINE_ARENA, 19). % 天梯挑战中不允许使用物品
-define(PC_FAIL_CANNOT_SUMMON_PAR_IN_OFFLINE_ARENA, 20). % 天梯挑战中无法召唤宠物
-define(PC_FAIL_CANNOT_SUMMON_PAR_IN_HIJACK, 21).        % 劫镖战斗中无法召唤宠物
-define(PC_FAIL_CANNOT_SUMMON_PAR_FOR_TIMES_LIMIT, 22).  % 召唤宠物的次数已达上限（10次）
-define(PC_FAIL_CANNOT_USE_GOODS_IN_HIJACK, 23).         % 劫镖战斗中不允许使用物品








%% ---------- 下达指令：使用技能 -----------------
-define(PT_BT_USE_SKILL, 20030).

%% 协议号: 20030
%% c >> s:
%%    ForBoId        u16      表示是为哪个bo下指令
%%    SkillId        u32      所选的技能id（为0则表示是普通攻击）
%%    TargetBoId     u16      目标战斗对象id（表示攻击或施法的目标）

%% s >> c:
%%    RetCode        u8       成功则返回0，否则返回对应的失败原因代号（代号详见20029协议）
%%    ForBoId        u16      表示是为哪个bo下指令
%%    SkillId        u32      所选的技能id（为0则表示是普通攻击）
%%    TargetBoId     u16      目标战斗对象id（表示攻击或施法的目标）



%% ---------- 下达指令：使用物品 -----------------
-define(PT_BT_USE_GOODS, 20031).

%% 协议号: 20031
%% c >> s:
%%    ForBoId        u16      表示是为哪个bo下指令
%%    GoodsId        u64      所用物品的id
%%    TargetBoId     u16      所针对的目标bo id

%% s >> c:
%%    RetCode        u8       成功则返回0，否则返回对应的失败原因代号（代号详见20029协议）
%%    ForBoId        u16      表示是为哪个bo下指令
%%    GoodsId        u64      所用物品的id
%%    TargetBoId     u16      所针对的目标bo id




%% ---------- 下达指令：保护 -----------------
-define(PT_BT_PROTECT_OTHERS, 20032).

%% 协议号: 20032
%% c >> s:
%%    ForBoId           u16      表示是为哪个bo下指令
%%    TargetBoId        u16      所保护的目标bo id

%% s >> c:
%%    RetCode           u8       成功则返回0，否则返回对应的失败原因代号（代号详见20029协议）
%%    ForBoId           u16      表示是为哪个bo下指令
%%    TargetBoId        u16      所保护的目标bo id



%% ---------- 下达指令：逃跑 -----------------
-define(PT_BT_ESCAPE, 20033).

%% 协议号: 20033
%% c >> s:
%%    ForBoId           u16      表示是为哪个bo下指令

%% s >> c:
%%    RetCode           u8       下达指令成功则返回0，否则返回对应的失败原因代号（代号详见20029协议）
%%    ForBoId           u16      表示是为哪个bo下指令



%% ---------- 下达指令：防御 -----------------
-define(PT_BT_DEFEND, 20034).

%% 协议号: 20034
%% c >> s:
%%    ForBoId           u16      表示是为哪个bo下指令

%% s >> c:
%%    RetCode           u8       下达指令成功则返回0，否则返回对应的失败原因代号（代号详见20029协议）
%%    ForBoId           u16      表示是为哪个bo下指令



%% ---------- 下达指令：召唤宠物 -----------------
-define(PT_BT_SUMMON_PARTNER, 20035).

%% 协议号: 20035
%% c >> s:
%%    ForBoId           u16      表示是为哪个bo下指令
%%    PartnerId         u64      要召唤的宠物id

%% s >> c:
%%    RetCode           u8       下达指令成功则返回0，否则返回对应的失败原因代号（代号详见20029协议）
%%    ForBoId           u16      表示是为哪个bo下指令
%%    PartnerId         u64      要召唤的宠物id



%% ---------- 下达指令：请求依据按AI下指令 -----------------
-define(PT_BT_REQ_PREPARE_CMD_BY_AI, 20036).

%% 协议号: 20036
%% c >> s:
%%    ForBoId           u16      表示是为哪个bo下指令

%% s >> c:
%%    RetCode           u8       下达指令成功则返回0，否则返回对应的失败原因代号（代号详见20029协议）
%%    ForBoId           u16      表示是为哪个bo下指令




%% ---------- 查询bo身上指定buff的信息 -----------------
-define(PT_BT_QRY_BO_BUFF_INFO, 20040).

%% 协议号: 20040
%% c >> s:
%%    BoId           u16      bo id
%%    BuffNo         u32      buff编号

%% s >> c:
%%    RetCode        u8       成功则返回0，失败则返回1（失败通常是因为bo身上没有对应编号的buff，这也意味着服务端或客户端程序有bug）
%%    BoId           u16      bo id
%%    BuffNo         u32      buff编号
%%    ExpireRound    u16      buff的到期回合（表示buff到了该回合即过期）
%%    OverlapCount   u8       buff当前的叠加层数（不可叠加的buff固定返回1）

%%                            如果buff不可叠加，则以下都统一返回0
%%    Para1_Type     u8       buff参数1的类型（0:表示参数无意义，1：整数，2：百分比。下同）
%%    Para1_Value    u32      buff参数1的值（如果是百分比，则返回的是一个放大100倍后的整数，比如：0.32对应返回的是32，下同）
%%    Para2_Type     u8       buff参数2的类型
%%    Para2_Value    u32      buff参数2的值



%% ---------- 通知客户端：自身的buff列表有改变（添加了某buff，或者移除了某buff，或者某buff的信息有更新） -----------------
%%                       注：回合结算buff时，会通过此协议通知客户端
-define(PT_BT_NOTIFY_BO_BUFF_CHANGED, 20041).

%% 协议号: 20041
%% s >> c:
%%    BoId           u16      战斗对象id
%%    Type           u8       1表示添加，2表示移除，3表示有更新
%%    BuffDetails    bin      buff详情（二进制流，格式见20015协议中的说明）



%% ---------- 通知客户端：某bo的属性有改变 -----------------
%%       注：回合结算HOT, DOT类buff时，会通过此协议通知客户端。处理回合行动时，部分情况下也会发此协议给客户端，当做战报
-define(PT_BT_NOTIFY_BO_ATTR_CHANGED, 20042).

%% 协议号: 20042
%% s >> c:
%%    BoId                u16      战斗对象id
%%    DieStatus           u8       死亡状态（0：未死亡，1：死亡并且进入倒地状态，2：死亡并且进入鬼魂状态， 3：死亡并且直接消失）
%%    array(
%%         AttrCode       u8       属性代号（见下面的说明）
%%         ChangeValue    int32    增加或减少的值（如果是减少，则返回负值），用于客户端做显示
%%         NewValue       u32      新的值
%%        )


%% 代号              代表的属性
%% ---------------------------
%%  1                 当前hp
%%  2                 当前mp
%%  3                 当前anger
%%  4                 当前 ?ATTR_PHY_ATT
%%  5                 当前 ?ATTR_MAG_ATT
%%  6                 当前 ?ATTR_PHY_DEF
%%  7                 当前 ?ATTR_MAG_DEF
%%  其他（后续按需添加）。。




%% ---------- 通知客户端：一或多个bo死亡了 -----------------
%%       注：回合结算DOT类buff时，如果DOT导致bo死亡，则会通过此协议通知客户端。处理回合行动时，部分情况下（如使用技能后强行死亡）也会发此协议给客户端，当做战报
-define(PT_BT_NOTIFY_BO_DIED, 20043).

%% 协议号: 20043
%% s >> c:
%%    array(
%%      	BoId                 u16      战斗对象id
%%    		DieStatus            u8       死亡状态（1：死亡并且进入倒地状态，2：死亡并且进入鬼魂状态， 3：死亡并且直接消失）
%%    		array(                     移除的buff列表
%%         		 BuffsRemoved    u32      buff编号
%%        		)
%%        )



%% ---------- 通知客户端：bo复活 -----------------
%% 		注：回合结算倒地、鬼魂状态时，如果bo复活了，则会通过此协议通知客户端
-define(PT_BT_NOTIFY_BO_REVIVE, 20044).

%% 协议号: 20044
%% s >> c:
%%      BoId             u16      复活的战斗对象id
%%    	NewHp            u32      复活后的血量



%% ---------------- 请求自动战斗 -------------------
-define(PT_BT_REQ_AUTO_BATTLE, 20045).

%% 协议号: 20045
%% c >> s:
%%     无

%% s >> c:
%%     RetCode    u8      如果成功，则返回0，否则不返回，而是直接发送失败提示消息的协议



%% ---------------- 取消自动战斗 -------------------
-define(PT_BT_CANCEL_AUTO_BATTLE, 20046).

%% 协议号: 20046
%% c >> s:
%%     无

%% s >> c:
%%     RetCode    u8      如果成功，则返回0，否则不返回，而是直接发送失败提示消息的协议



%% ---------------- 查询自己可操控的bo的技能可使用情况 -------------------
-define(PT_BT_QUERY_SKILL_USABLE_INFO, 20050).

%% 协议号: 20050
%% c >> s:
%%     BoId                u16     bo id 

%% s >> c:
%%     BoId                u16     bo id
%%     array(
%%           SkillId       u32     技能id	
%%           IsUsable	   u8      1：可使用，0：不可使用
%%           LeftCDRounds  u8      剩余的冷却回合数，如果不在冷却中，则返回0
%%	       )





%% ---------------- 回归战斗后查询bo的某些信息 -------------------
-define(PT_BT_QUERY_BO_INFO_AFTER_BACK_TO_BATTLE, 20051).

%% 协议号: 20051
%% c >> s:
%%     TargetBoId         u16      目标bo id

%% s >> c:
%%     TargetBoId         u16      目标bo id
%%     DieStatus          u8       死亡状态（0：未死亡，1：死亡并且进入倒地状态，2：死亡并且进入鬼魂状态， 3：死亡并且直接消失）
%%     OnlineFlag         u8       在线标记（1：在线，2：离线）
%%     AccSummonParTimes  u8       累计已召唤宠物的次数
%%     array(                    buff列表
%%           BuffNo       u32      buff编号
%%           ExpireRound  u16      buff的到期回合（表示buff到了该回合，即消失）
%%	       )
%%     array(                    玩家的已经出战过的宠物id列表（对于非玩家bo，固定返回空数组）
%%           PartnerId    u64      宠物id
%%		   )




%% ---------------- （断线重连后）尝试回归战斗 -------------------
-define(PT_BT_TRY_GO_BACK_TO_BATTLE, 20052).

%% 协议号: 20052
%% c >> s:
%%     无

%% s >> c:
%%     RetCode         u8      如果可以回归战斗，则返回0，否则，返回1（表明不可回归战斗）



%% ---------------- 战斗提示（一或多个） -------------------
-define(PT_BT_TIPS, 20055).

%% 协议号: 20055
%% s >> c:
%%     array(
%%     	    ToBoId            u16     提示信息所针对的bo id，如果不具体针对某个bo，则统一发0
%%          TipsCode          u32     提示信息的代号（详见如下说明）
%%          Para1             u32     提示信息的参数1，若无意义，则统一发0
%%          Para2             u32     提示信息的参数2，若无意义，则统一发0
%%         )

%% 
%%   代号      参数1                     参数2                       所代表的含义
%% ----------------------------------------------------------------------------------------
%%    1        无意义                    无意义                     当前无法行动
%%    2        所用技能的id              无意义                     使用技能失败：原因不明（表明程序有bug）
%%    3        所用技能的id              无意义                     使用技能失败：血量不足
%%    4        所用技能的id              无意义                     使用技能失败：蓝量不足
%%    5        所用技能的id              无意义                     使用技能失败：怒气不足
%%    6        所用技能的id              无意义                     使用技能失败：技能在冷却中
%%    7        所用技能的id              无意义                     使用技能失败：当前血量比例太高
%%    8        所用技能的id              无意义                     使用技能失败：当前血量比例太低
%%    9        所用技能的id              无意义                     使用技能失败：当前处于隐身状态中
%%    10       所用技能的id              无意义                     使用技能失败：当前处于特殊状态中
%%    11       不肯出战的宠物id          无意义                     宠物因忠诚度不够而不肯出战
%%    15       所使用物品的编号          目标bo id                  使用物品失败：原因不明（表明程序有bug，此时参数1固定返回0）
%%    16       所使用物品的编号          目标bo id                  使用物品失败：目标不存在
%%    17       所使用物品的编号          目标bo id                  使用物品失败：目标已死亡
%%    18       所使用物品的编号          目标bo id                  使用物品失败：目标无法被治疗
%%    19       所使用物品的编号          目标bo id                  使用物品失败：目标灵魂已被禁锢
%%    20       所用技能的id              无意义                     使用技能失败：银子不足



%% ---------- 客户端通知服务端：客户端战斗结束 ----------------
-define(PT_BT_C2S_NOTIFY_BATTLE_END, 20060).

%% 协议号: 20060
%% C >> S:
%%      无



%% ---------- 通知客户端：不需回归战斗 ----------------
-define(PT_BT_NOTIFY_NOT_NEED_BACK_TO_BATTLE, 20061).

%% 协议号: 20061
%% C >> S:
%%      无



%% ---------- 通知客户端：新的bo刷出了 -----------------
-define(PT_BT_NOTIFY_NEW_BO_SPAWNED, 20062).

%% 协议号: 20062
%% s >> c:
%%       Side      u8         所属方（1：主队，2：客队）
%%       剩余的格式和20007协议中的array中的格式一致




%% ---------- 通知客户端：下一波怪刷出了 ----------------
-define(PT_BT_NOTIFY_NEXT_BMON_GROUP_SPAWNED, 20063).
%% 协议号: 20063
%% c >> s:
%%      ForRound    u16       表示怪是在哪一个回合刷出（目前都是在当前回合的下一个回合）
%%      ForSide     u8        表示怪是在哪一方刷出（目前都是客队方）
%%      NthWave     u16       表示这一波是属于第几波
%%      array(                新刷出的          
%%             ...            和20007协议中的array中的格式一致	
%%	         )



%% ---------- 查询战斗的开始时间（unix时间戳） ----------------
-define(PT_BT_QUERY_BATTLE_START_TIME, 20064).

%% 协议号: 20064
%% c >> s:
%%      无

%% s >> c:
%%      RetCode      u8        查询成功则返回0，失败则返回1
%%      StartTime    u32       战斗的开始时间（unix时间戳），如果查询失败，则固定返回0






%% ---------- 强行退出战斗， 仅用于调试 -----------------
-define(PT_BT_DBG_FORCE_QUIT_BATTLE, 20998).

%% 协议号: 20998
%% c >> s:
%%      无



%% ---------- 获取战斗对象的信息，此协议仅仅用于调试！ -----------------
-define(PT_BT_DBG_GET_BO_INFO, 20999).

%% 协议号: 20999
%% c >> s:
%%    BoId     u16      要查询的战斗对象的id

%% s >> c:
%%    战斗对象信息的字符串格式化形式的数据



%% ---------- 通知客户端：捕捉宠物 -----------------
-define(PT_BT_CAPTURE_PARTNER, 20100).

%% 协议号: 20100
%% s >> c:
%%      BoId                 u16      战斗对象id
%%    	TargetBoId           u16      被捕捉对象id
%%    	Result          	 u8       结果(1成功,0失败)


%% ---------- 下达指令：捕捉宠物 -----------------
-define(PT_BT_CMD_CAPTURE_PARTNER, 20101).

%% 协议号: 20101
%% c >> s:
%%    ForBoId           u16      表示是为哪个bo下指令
%%    TargetBoId        u16      所保护的目标bo id

%% s >> c:
%%    RetCode           u8       成功则返回0，否则返回对应的失败原因代号（代号详见20029协议）
%%    ForBoId           u16      表示是为哪个bo下指令
%%    TargetBoId        u16      所保护的目标bo id

%%----------------用于世界BOSS逃跑----------------
-define(PT_BT_WORLD_BOSS_ESCAPE, 20110).

%%---------------用于debug模式的时候发送给前端显示-------
-define(PT_BT_TEST_BATTLE_INFO, 20200).
%% s >> c:
%%    BattleType        u8       1物理，2法术，3治疗，4封印
%%    SkillNo           u32      若没技能默认为0
%%    SkillSca          u32      技能伤害放缩系数
%%    SkillInitDam      u32      技能伤害固定值部分=技能伤害等级提升值*技能等级+技能伤害初始值
%%    PhyCoef           u32      物伤加成系数=max(物伤&法伤加成最小值，己.物伤增加 - 敌.物伤减免)
%%    DoubleCoef         u32     连击伤害系数=连击或攻击次数放缩系数^(连击或攻击次数-1)
%%    TotalPhyDam      u32       min(物理暴伤&法术暴伤最大值，己.物理暴伤）+ 初始物理暴伤
%%    PurseCoef           u32      追击伤害系数=max(追击伤害加成最小值，己.追击伤害增加-敌.追击伤害减免)
%%    TotalDam         u32     最终伤害值
%%    TotalHealCoef      u32      最终治疗加成系数=治疗加成系数+被治疗加成系数
%%    HealValue           u32     最终治疗量
%%    HitCoef         u32     封印状态系数
%%    Hitrate      u32      封印命中率

%%---------------队长作战方针转发--------------------- 
-define(PT_BT_CAPTAIN_PROJECT,	20301).
%% 协议号: 20301
%% c >> s:
%%    ForBoId           u16      表示是为哪个bo下指令
%%    TargetBoId        u16      所保护的目标bo id

%% s >> c:
%%    ForBoId           u16      表示是为哪个bo下指令
%%    TargetBoId        u16      所保护的目标bo id

%% ---------------- 通知前端怒气变化 -------------------
-define(PT_BT_NOTIFI_ANGER_CHANGE_INFO, 20302).

%% 协议号: 20302

%% s >> c:
%%     array(
%%           BoId                u16     bo id
%%           Value               u32     对象的怒气值
%%	       )









