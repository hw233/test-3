%% Author: LDS
%% Created: 2013-11
%% Description: 
-module(data_dungeon_reward).

%%
%% Exported Functions
%%
-compile(export_all).

-include("common.hrl").
-include("dungeon.hrl").
%%
%% Local Functions
%%
%%@return: integer()

get(1001, ?DIAMOND_BOX) -> 30000;                    

get(1001, ?GOLD_BOX) -> 30001;

get(1001, ?SILVER_BOX) -> 30002;

get(1001, ?COPPER_BOX) -> 30003;


get(1002, ?DIAMOND_BOX) -> 30000;                    

get(1002, ?GOLD_BOX) -> 30001;

get(1002, ?SILVER_BOX) -> 30002;

get(1002, ?COPPER_BOX) -> 30003;

get(_, _) ->
    ?ASSERT(false),
    null.
