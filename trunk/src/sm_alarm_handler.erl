%%%----------------------------------------
%%% @Module  : sm_alarm_handler
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.15
%%% @Description: 警报
%%%----------------------------------------

-module(sm_alarm_handler).
-behaviour(gen_event).
-include("common.hrl").

%%gen_envent callbacks.
-export([init/1, handle_event/2, handle_call/2, handle_info/2, terminate/2, code_change/3]).   

init(Args) ->   
	?DEBUG_MSG("sm_alarm_handler init : ~p.", [Args]),   
	{ok, Args}.   
  
handle_event({set_alarm, _From}, _State) ->   
    ?DEBUG_MSG("sd depot clear by ~p started.", [_From]),   
	{ok, _State};   
 
handle_event({clear_alarm, _From}, _State) ->   
	?DEBUG_MSG("sd depot clear by ~p done.", [_From]),   
	{ok, _State};   
  
handle_event(_Event, State) ->   
	?DEBUG_MSG("unmatched event: ~p.", [_Event]),   
	{ok, State}.   
  
handle_call(_Req, State) ->   
	{ok, State, State}.   
       
handle_info(_Info, State) ->   
	{ok, State}.   
  
terminate(_Reason, _State) ->   
	ok.   

code_change(_OldVsn, State, _Extra) ->   
    {ok, State}.   
