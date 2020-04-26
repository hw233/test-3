
%%% =================================
%%% 心法、技能系统相关协议
%%% 2013.11.15  ---- huangjf
%%% =================================

%% pt: 表示protocol
%% xf: 表示心法（xinfa）





%% ---------- 查询自己的心法信息 -----------------
-define(PT_QUERY_XF_INFO, 21001).

%% 协议号: 21001
%% c >> s:
%%     无

%% s >> c:
%%     array(                       
%%            XinfaId               u32     心法id
%%            XinfaLv               u16      心法等级
%%            AddAttrs_ParaType1    u8      属性加成参数1的类型（0：无效，1：整数，2：百分比）
%%            AddAttrs_ParaValue1   u32     属性加成参数1的值（若为百分比，则返回放大100倍后的整数值，若无效，则固定返回0）
%%            AddAttrs_ParaType2    u8      属性加成参数2的类型（0：无效，1：整数，2：百分比）
%%            AddAttrs_ParaValue2   u32     属性加成参数2的值（若为百分比，则返回放大100倍后的整数值，若无效，则固定返回0）
%%	        )




%% ---------- 升级心法 -----------------
-define(PT_UPGRADE_XF, 21002).

%% 协议号: 21002
%% c >> s:
%%     XinfaId       u32     心法id

%% s >> c:
%%     RetCode       u8      若升级成功，则返回0，否则不返回，而是直接发送失败提示
%%     XinfaId       u32     心法id
%%	   XinfaLv       u32     心法等级

%% ---------- 升级心法一键 -----------------
-define(PT_UPGRADE_XF_ONE_KEY, 21004).

%% 协议号: 21004
%% c >> s:
%%     XinfaId       u32     心法id



%% ---------- 激活从属心法（激活成功后，会从0级变为1级） -----------------
-define(PT_ACTIVATE_SLAVE_XF, 21003).

%% 协议号: 21003
%% c >> s:
%%     SlaveXinfaId       u32     从属心法id

%% s >> c:
%%     RetCode            u8      若激活成功，则返回0，否则不返回，而是直接发送失败提示
%%     SlaveXinfaId       u32     从属心法id


%% ----------- 门派技能列表信息
-define(PT_FACTION_SKILLS, 21010).

%% 协议号: 21010
%% c >> s:


%% s >> c:
%%     array(                       
%%            skill_id         u32     技能id
%%            skill_lv         u16     技能等级
%%	        )

%% ---------- 升级门派技能 -----------------
-define(PT_FACTION_SKILL_UP, 21011).

%% 协议号: 21011
%% c >> s:
%%     id       u32     技能id | 0 (发0表示一键升级)

%% ----------- 转换门派 --------------------
-define(PT_FACTION_TRANSFORM, 21012).

%% 协议号: 21012
%% c >> s:
%%     faction       u8     门派

%% s >> c:
%%     faction       u8     门派


%% ----------- 转换门派消耗数据 --------------------
-define(PT_FACTION_TRANSFORM_COST, 21013).

%% 协议号: 21013
%% c >> s:

%% s >> c:
%%		type 		u8		货币类型
%% 		value		u32		货币数量


