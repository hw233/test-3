%% auther:  
%% email: 
%% date: 2011.04.09
  
{   
    application, flash,
    [   
        {description, "This is an flash policy file server."},   
        {vsn, "1.0a"},   
        {modules,
		[
			sm
		]},   
        {registered, [sm_flash_sup]},   
        {applications, [kernel, stdlib, sasl]},   
        {mod, {sm_flash_app, []}},   
        {start_phases, []}
    ]   
}.    
 
%% File end.  
