%% auther:    
%% email: 
%% date: 2011.04.09
  
{   
    application, server,
    [   
        {description, "This is an sm game server."},   
        {vsn, "1.0a"},   
        {modules,
		[
			sm
		]},   
        {registered, [sm_sup]},   
        {applications, [kernel, stdlib, sasl]},   
        {mod, {sm_server_app, []}},   
        {start_phases, []}
    ]      
}.    
 
%% File end.  
