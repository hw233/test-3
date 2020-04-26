%% auther:    
%% email: 
%% date: 2011.11.30
  
{   
    application, world,
    [   
        {description, "This is a world server."},   
        {vsn, "1.0a"},   
        {modules,
		[
			sm
		]},   
        {registered, [sm_sup]},   
        {applications, [kernel, stdlib, sasl]},   
        {mod, {sm_world_app, []}},   
        {start_phases, []}
	%%{env,[{logger_node, 'sm_logger@127.0.0.1'}, {gateway_node, 'sm_gateway@127.0.0.1'}]}
    ]      
}.    
 
%% File end.  
