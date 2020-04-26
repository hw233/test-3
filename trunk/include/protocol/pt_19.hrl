%% =========================================================
%% 19  邮件协议
%% =========================================================



% % =========================
% 发邮件
% 协议号： 19001
% C >> S:
%     RecvName    String      收件人姓名
%     title       String      标题
%     content     String      内容
% S >> C:
%     state       u8          1->成功 0->失败
    

% % =========================
% 查看邮件列表简要信息
% 协议号： 19002
% C >> S:
%     type      u8      邮件类型  1->系统 2->私人
% S >> C:
%     type        u8          邮件类型  1->系统 2->私人
%     array(
%         mailId      u64         邮件ID
%         title       String      标题
%         state       u8          0->未读, 1->已读
%         startStamp  u32         开始时间戳
%         endStamp    u32         到期时间戳
%         attach_flag u8          是否有附件(0->无 1->有 )
%     )
    
    
% % =========================
% 查看具体邮件
% 协议号： 19003
% C >> S:
%     mailId      u64         邮件ID
% S >> C:
%     mailId      u64         邮件ID
%     sendName    String      发件人姓名
%     content     String      内容
%     array(
%         goodsID     u64         物品ID
%         goodsNO     u32         物品编号
%         num         u32         数量
%         quality     u8          质量
%         bind        u8          绑定状态
%     )
    
    
% % =========================
% 收取附件
% 协议号： 19004
% C >> S:
%     mailId      u64         邮件ID
%     goodsID     u64         物品ID
% S >> C:
%     mailId      u64         邮件ID
%     goodsID     u64         物品ID    

% % =========================
% 批量收取附件
% 协议号： 19005
% C >> S:
%     array(
%         mailId      u64         邮件ID
%     )
% S >> C:
%     array(
%         mailId      u64         成功提取附件的邮件ID
%     )
%     array(
%         mailId      u64         失败提取附件的邮件ID
%     )
    
    
% % =========================
% 删除邮件
% 协议号： 19006
% C >> S:
%     mailId      u64         邮件ID
% S >> C:
%     mailId      u64         邮件ID
      
       
% % =========================
% 批量删除邮件
% 协议号： 19007
% C >> S:
%     array(
%         mailId      u64         邮件ID
%     )
% S >> C:
%     array(
%         mailId      u64         成功删除的邮件ID
%     )    
%     array(
%         mailId      u64         失败删除的邮件ID
%     ) 
    

% % =========================
% 新邮件提示
% 协议号： 19008
% S >> C:
%     mailId      u64         邮件ID
%     type        u8          邮件类型
%     title       String      标题
%     timestamp   u32         到期时间戳
%         attach_flag u8          是否有附件(0->无 1->有 )


% % =========================
% 删除邮件候补的旧邮件
% 协议号： 19010
% S >> C:
%     mailId      u64         邮件ID
%     type        u8          邮件类型
%     title       String      标题
%     timestamp   u32         到期时间戳
%         attach_flag u8          是否有附件(0->无 1->有 )
%         state       u8          0->未读, 1->已读


% % =========================
% 历史收件人  (废弃)
% 协议号： 19009
% S >> C:
%     array(
%         name       string         名字
%     ) 