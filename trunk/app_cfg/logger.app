%% auther:  Skyman Wu
%% email: 
%% date: 2011.11.22
  
{   
    application, logger,
    [   
        {description, "This is an sm logger."},   
        {vsn, "1.0a"},   
        {modules,
		[
			sm
		]},   
        {registered, [sm_logger_sup]},   
        {applications, [kernel, stdlib, sasl]},   
        {mod, {sm_logger_app, []}},   
        {start_phases, []},
	{env, [{log_file, "logs/log"},
           {log_level, 5}]}
    ]   
}.    
 
%% File end.  
