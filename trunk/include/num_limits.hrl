%%%------------------------------------------------
%%% File    : num_limits.hrl
%%% Author  : huangjf
%%% Created : 2012.3.14
%%% Description: 数值的界限
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__NUM_LIMITS_H__).
-define(__NUM_LIMITS_H__, 0).



% 32位有符号数的最大值
-define(MAX_S32, (16#7FFFFFFF)).  %%2147483647

% 32位无符号数的最大值
-define(MAX_U32, (16#FFFFFFFF)).  %%4294967295

% 64位有符号数的最大值
-define(MAX_S64, (16#7FFFFFFFFFFFFFFF)).  %%2147483647

% 64位无符号数的最大值
-define(MAX_U64, (16#FFFFFFFFFFFFFFFF)).  %%4294967295


% 16位有符号数的最大值
-define(MAX_S16, (16#7FFF)).  %%32767

% 16位无符号数的最大值
-define(MAX_U16, (16#FFFF)).  %%65535




% 8位有符号数的最大值
-define(MAX_S8, 127).

% 8位无符号数的最大值
-define(MAX_U8, 255).


















-endif.  %% __NUM_LIMITS_H__
