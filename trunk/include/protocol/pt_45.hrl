%%%-------------------------------------------------------------------
%%% @author wujiancheng
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. 七月 2019 10:58
%%%-------------------------------------------------------------------
-author("wujiancheng").
%% 避免头文件多重包含
-ifndef(__PT_45_H__).
-define(__PT_45_H__, 0).

-define(PT_FABAO_INFO, 45001).
% ########### 玩家法宝基本信息 ##############
% 协议号:45001
% c >> s:
%     code        u8          %请求法宝基本信息
% s >> c:
% array{
%        id              u64        % 法宝id
%        no              u32        % 法宝编号
%        star_num        u8         % 星数
%        degree          u8         % 阶数
%        sp_value        u32        % 灵力值
%        displayer       u8         % 是否展示(1展示，2不展示)
%        battle          u8         % 是否出战(1为出战，2为不出战)
%        degree_num      u8         % 当前阶数几重
%        degree_pro      u16         % 进阶修炼进度
%        cultivate_pro   u16        % 成长率
%        array {
%          		index           u8         % 八卦的属性位置
%		          clear_type      u16        % 洗练属性名1
%          		clear_type_2    u16        % 洗练属性名2
%          		clear_value     u16        % 洗练属性值1
%          		clear_value_2   u16        % 洗练属性值2
%          		rep_value1      u16        % 可替换洗练属性名1的值
%          		rep_value2       u16       % 可替换洗练属性名2的值
%		    }
%        skill_num       u32       % 技能点
%        skill_array_1   u32       % 上阵技能1
%        skill_array_2   u32       % 上阵技能2
%        skill_array_3   u32       % 上阵技能3
%        array {
%           degree_ski_1   u8      % 发相应位置值
%           degree_lv_1    u8       % 主动技能也发0，被动技能按等级发
%        }
%		flashprint_array(
%          set_type            u8   镶嵌类型(1风2林3火4山5阴6雷)
%          fuyinId1            u64  镶嵌子位置1的ID(如果有发符印Id,没有发0)
%          fuyinNo1            u32  镶嵌子位置1的值(如果有发符印编号,没有发0)
%          fuyinId2            u64  镶嵌子位置2的ID(如果有发符印Id,没有发0)
%          fuyinNo2            u32  镶嵌子位置2的值(如果有发符印编号,没有发0)
%          fuyinId3            u64  镶嵌子位置3的ID(如果有发符印Id,没有发0)
%          fuyinNo3            u32  镶嵌子位置3的值(如果有发符印编号,没有发0)
%       }
% }
%% ---------------------- 展示和不展示法宝 -----------------------
-define(PT_FABAO_DISPLAYER, 45002).
%% 协议号：45002
%% C >> S:
%%      FanbaoID        u64	法宝的ID
%%      body_anim       u32  幻化的外饰(没有发0)(12017加了个key值,发FanbaoNo)
%%		Num			    u8	1表示展示, 2表示不展示
%% S >> C:
%%		FanbaoNo        u32	法宝的编号
%% ---------------------- 佩戴和不佩戴法宝 -----------------------
-define(PT_FABAO_BATTLE, 45003).
%% 协议号：45003
%% C >> S:
%%      FanbaoID        u64	法宝的ID
%%		Num			    u8	1表示佩戴, 2表示不佩戴

%% ---------------------- 法宝合成 -----------------------
-define(PT_FABAO_COMPOSE, 45005).
%% 协议号：45005
%% C >> S:
%%      FanbaoNo        u32	法宝的编号(合成所需道具物品no和物品数量读表)
%% 	成功返回45001的协议,失败998

%% ---------------------- 法宝升星 -----------------------
-define(PT_FABAO_UPGRADE_STAR, 45006).
%% 协议号：45006
%% C >> S:
%%      FabaoId        u64	法宝的ID
%%      Feed          	u8  升星消耗类型（0表示道具1， 1表示道具2）
%% S >> C:
%%      FabaoId        u64	法宝的ID
%%      star_num        u8   星数
%%      cultivate_pro   u16 成长率
%% ---------------------- 法宝充灵(当灵力值发生变化，后端需主动推送)-----------------------
-define(PT_FABAO_SPIRIT, 45007).
%% 协议号：45007
%% C >> S:
%%      FabaoId        u64	法宝的ID
%%      Feed          	u8  充灵消耗类型（0表示道具1， 1表示道具2）
%% S >> C:
%%      FabaoId        u64	法宝的ID
%%      sp_value        u32 灵力值
%% ---------------------- 法宝炼化-----------------------
-define(PT_FABAO_REFINING, 45008).
%% 协议号：45008
%% C >> S:
%%      FabaoId        u64	法宝的ID(消耗所需道具物品no和物品数量读表)
%% S >> C:
%%      FabaoId        u64	法宝的ID
%%      cultivate_pro   u16 成长率

%% ---------------------- 法宝碎片兑换-----------------------
-define(PT_FABAO_FRAGMENT_EXCHANGE, 45009).
%% 协议号：45009
%% C >> S:
%%      FabaoNo        u32	法宝碎片的编号
%% S >> C:
%%		Num 			u8	    成功返回0,失败998
%% ---------------------- 法宝碎片转化-----------------------
-define(PT_FABAO_FRAGMENT_TRANSFORM, 45010).
%% 协议号：45010
%% C >> S:
%%      FabaoNo        u32	法宝碎片的编号
%% S >> C:
%%		  Num 			      u8	成功返回0,失败998

%% ---------------------- 法宝幻化选择-----------------------
-define(PT_FABAO_BUY_SPECIAL, 45011).
%% 协议号：45011
%% 购买特殊幻化外观
%% C >> S:
%%      SpecialNo        u32	特殊幻化外观的编号
%% S >> C:
%%		Num 			 u8		成功返回0,失败998
%%		{
%%			SpecialNo        u32	特殊幻化外观的编号
%%		}
%% ---------------------- 法宝进阶-----------------------
-define(PT_FABAO_ADVANCE, 45020).
%% 协议号：45020
%% C >> S:
%%      FanbaoId        u64 	法宝的Id
%%      type            u8    1表示正常进阶，2表示一键进阶
%% S >> C:
%%      FanbaoId        u64 	法宝的Id
%%		  NowDegree 			u8	  当前阶数
%%		  NowNum 			    u8	  当前重数
%%		  degree_pro 			u16	  当前进度
%% ---------------------- 法宝八卦重置属性生成-----------------------
%生成的时候由于没鉴定，所以不可能会有八卦
-define(PT_FABAO_DIAGRAMS_RESET, 45030).
%% 协议号：45030
%% C >> S:
%%      FabaoId          	u64 	   法宝的Id
%%      index             	u8    	八卦的属性位置
%% S >> C:
%%      FabaoId          	u64 	       法宝的Id
%%      index           	u8           八卦的属性位置
%%		  clear_type_name_1   u16        洗练属性名1
%%      clear_type_name_2   u16        洗练属性名2
%%      clear_value_1     	u16        当前洗练属性值1
%%      clear_value_2     	u16        当前洗练属性值2
%% ---------------------- 法宝八卦洗练-----------------------
-define(PT_FABAO_DIAGRAMS_CLEAR, 45031).
%% 协议号：45031
%% C >> S:
%%      FabaoId         u64 	    	法宝的Id
%%      index           u8      	八卦的属性位置
%%      clear_type      u16     	洗练属性名
%% S >> C:
%%      FanbaoId        u64 	    法宝的Id
%%      index           u8        八卦的属性位置
%%      clear_type      u16       洗练属性名
%%      rep_value      	u16       洗练后属性名的值

%% ---------------------- 法宝替换属性-----------------------
-define(PT_FABAO_DIAGRAMS_REP, 45032).
%% 协议号：45032
%% C >> S:
%%      FabaoId        u64 	    法宝的Id
%%      index          u8      八卦的属性位置
%%      clear_type      u16     洗练属性名
%% S >> C:
%%      FabaoId         u64 	    法宝的Id
%%      index           u8      八卦的属性位置
%%      clear_type      u16     洗练属性名

%% ---------------------- 法宝八卦升星后的属性-----------------------
-define(PT_FABAO_DIAGRAMS_GET_BY_STAR, 45033).
%% 协议号：45033
%% S >> C:
%%       FabaoId            u64 	       法宝的Id
%%      array {
%%        index           	  u8         八卦的属性位置
%%		    clear_type_name_1   u16        洗练属性名1
%%        clear_type_name_2   u16        洗练属性名2
%%        clear_value_1       u16        当前洗练属性值1
%%        clear_value_2       u16        当前洗练属性值2
%%        rep_value1      	  u16        洗练后属性名1的值
%%        rep_value2       	  u16        洗练后属性名2的值
%% 	  }

%% ---------------------- 鉴定法宝 -----------------------
-define(PT_IDENTIFY_FABAO, 45034).
%% 协议号：45034
%% C >> S:
%%      SutrasId        u64		法宝的ID
%%      index           u8      八卦的属性位置
%% S >> C:
%%      SutrasId        u64 	法宝的Id
%%      index           u8      八卦的属性位置

%% ---------------------- 激活或领悟神通某个技能 -----------------------
-define(PT_MAGIC_ACTVIATE, 45040).
%% 协议号：45040
%% C >> S:
%%      FabaoID        u64	法宝的ID
%%      Condition       u8  总共五列看是哪一类
%% S >> C:
%%      FabaoID        u64	法宝的ID
%%      Condition       u8  总共五列看是哪一类
%%      失败通过998

%% ---------------------- 升级神通的某个技能 -----------------------
-define(PT_MAGIC_UPGRADLV, 45041).
%% 协议号：45041
%% C >> S:
%%      FanbaoID        u64	法宝的ID
%%      Condition       u8  编号（1-50）
%%      PlusLV          u8  玩家一次要升多少级
%% S >> C:
%%      FanbaoID        u64	法宝的ID
%%      Condition       u8  编号（1-50）
%%      SkillCount      u32 剩余的总技能点
%%      NewLv           u8  该技能升级后的总等级

%%      失败通过998

%% ---------------------- 神通使用物品获取技能点 -----------------------
-define(PT_MAGIC_GET_SKILLCOUNT, 45042).
%% 协议号：45042
%% C >> S:
%%      FanbaoID        u64	法宝的ID
%%      GoodsNo         u32 物品编号
%%      Count           u16 物品数量
%% S >> C:
%%      FanbaoID        u64	法宝的ID
%%      SkillCount      u32 剩余的总技能点

%% ---------------------- 神通上下阵谋个主动技能 -----------------------
-define(PT_MAGIC_ARRAY, 45043).
%% 协议号：45043
%% C >> S:
%%      FanbaoID        u64	法宝的ID
%%      Condition       u8  总共五列看是哪一类
%%      Type            u8  1是上阵\2是下阵
%% S >> C:
%%      FanbaoID        u64	法宝的ID
%%      SkillArray1     u32 上阵技能1
%%      SkillArray2     u32 上阵技能2
%%      SkillArray3     u32 上阵技能3
%%      失败通过998


%% ---------------------- 神通重置所有的技能点数 -----------------------
-define(PT_MAGIC_RESET_ALL_SKILLCOUNT, 45044).
%% 协议号：45044
%% C >> S:
%%      FanbaoID        u64	法宝的ID
%% S >> C:
%%      FanbaoID        u64	法宝的ID
%%      NowSkillCount   u32 总技能点
%%      失败通过998



%% ---------------------- 法宝符印简要信息 -----------------------
-define(PT_FABAO_FUYIN_DETAILS, 45050).
%% 协议号：45050
%% C >> S:
%%      仅发协议通知
%% S >> C:
%%      array(
%%          fuyinid         u64 符印物品ID
%%          fuyinno         u32 符印编号
%%          count           u32 符印数量
%%      )
%%

%% ---------------------- 法宝符印镶嵌/卸下 -----------------------
-define(PT_FABAO_FUYIN_MOSAIC, 45051).
%% 协议号：45051
%% C >> S:
%%      FabaoId             u64	法宝的ID
%%      SetType             u8  镶嵌类型(1风2林3火4山5阴6雷)
%%      Position            u8  符印镶嵌位置(1,2,3)
%%      FuyinId             u64 符印ID
%%      Type                u8  1表示镶嵌,2表示卸下
%% S >> C:
%%      FabaoId             u64 法宝的ID
%%      SetType             u8  镶嵌类型(1风2林3火4山5阴6雷)
%%      Position            u8  符印镶嵌位置(1,2,3)
%%      Value               u32 镶嵌子某个位置的值(如果有发符印编号,没有发0)
%%      FuyinId             u64 符印id(如果有发符印编号,没有发0)
%%

%% ---------------------- 法宝符印合成 -----------------------
-define(PT_FABAO_FUYIN_COMPOSE, 45052).
%% 协议号：45052
%% C >> S:
%%      Type                u8  1表示正常合成,2表示一键合成
%%      FuyinId             u64	符印物品ID
%% S >> C:
%%      ResCode             u8  成功返回0，否则返回998
%%


-endif.


