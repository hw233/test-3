%%%--------------------------------------------------------
%%% @author Lzz <liuzhongzheng2012@gmail.com>
%%% @doc 称号系统
%%%
%%% @end
%%%--------------------------------------------------------

%% 称号
-record(titles, {
            uid            = 0,    % 玩家ID
            all            = [],   % 所有称号 [#title{}...]
            all_ud_titles  = [],   % [{ID, 字名}...]
            graph_title    = 0,    % 使用中的图片称号
            text_title     = 0,    % 使用中的文字称号
            user_def_title = <<"">>,% 使用中的自定义称号
            display_graph_title = 0,
            display_text_title = 0,
            special_title = [],
            extend         = []    % 备用
    }).

-record(title, {
            id     = 0,
            expire = 0,
            ext    = []
        }).

-record(data_title, {
            id           = 0,
            type         = 0,
            valid_minute = 0,
            ava_attr = [],
            add_attr     = []
    }).

-record(special_title, {
  id = 0,
  optional_attr_add = [],
  cost1 = {},
  cost2 = {},
  custom_select = 0
}).