%%%------------------------------------------------
%%% File    : abbreviate.hrl
%%% Author  : huangjf
%%% Created : 2012.6.1
%%% Description: 添加一些宏，使得可以简写一些常用语句
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__ABBREVIATE_H__).
-define(__ABBREVIATE_H__, 0).






-define(Ifc(Expr), case (Expr) of
					   true ->
								).

-define(End, ;false ->
				  skip
			  end
			 		   ).






% -define(if_else(Expr, RetValue1, RetValue2), case (Expr) of
% 												true ->
% 													RetValue1; 
% 												false ->
% 													RetValue2
% 											 end).






-endif.  %% __ABBREVIATE_H__
